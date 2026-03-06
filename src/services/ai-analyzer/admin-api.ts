// CareerWiki AI Analyzer - Admin API
// 관제판 전용 API 엔드포인트

import { Hono } from 'hono'
import type { D1Database } from '@cloudflare/workers-types'
import { VERSIONS } from './types'
import { TAGGER_VERSION } from './job-attributes-types'
import {
  JOB_LARGE_CATEGORIES,
  JOB_MEDIUM_CATEGORIES,
  CAREERNET_TO_STANDARD_MAPPING,
  BREADCRUMB_ANOMALY_MAPPING,
  MAJOR_FIELD_LABELS,
  getClassificationPromptList,
  fuzzyMatchLargeCategory,
} from '../../constants/classification'
import { callOpenAI } from './openai-client'

// ============================================
// Bindings
// ============================================
interface Bindings {
  DB: D1Database
  [key: string]: unknown
}

// ============================================
// Admin API Routes
// ============================================
const adminAiApi = new Hono<{ Bindings: Bindings }>()

/**
 * GET /admin/api/ai/overview
 * 관제판 개요 통계
 */
adminAiApi.get('/overview', async (c) => {
  const db = c.env.DB
  
  try {
    // 태깅된 job 수
    const taggedJobs = await db.prepare(`
      SELECT COUNT(*) as count FROM job_attributes
    `).first<{ count: number }>()
    
    // Low confidence jobs (< 0.75)
    const lowConf = await db.prepare(`
      SELECT COUNT(*) as count FROM job_attributes WHERE _confidence < 0.75
    `).first<{ count: number }>()
    
    // 최근 tagger run
    let recentRun: { run_id: string; status: string; processed_jobs: number; started_at: string } | null = null
    try {
      recentRun = await db.prepare(`
        SELECT run_id, status, processed_jobs, started_at
        FROM tagger_runs
        ORDER BY started_at DESC
        LIMIT 1
      `).first<{
        run_id: string
        status: string
        processed_jobs: number
        started_at: string
      }>() || null
    } catch (e) {
      // 테이블이 없거나 비어있을 수 있음
      recentRun = null
    }
    
    // 최근 24h 분석 요청 수
    const analysisCount = await db.prepare(`
      SELECT COUNT(*) as count FROM ai_analysis_requests
      WHERE datetime(requested_at) >= datetime('now', '-24 hours')
    `).first<{ count: number }>()
    
    // 최근 24h follow-up 수
    const followupCount = await db.prepare(`
      SELECT COUNT(*) as count FROM facts
      WHERE datetime(collected_at) >= datetime('now', '-24 hours')
    `).first<{ count: number }>()
    
    // 최근 10 세션 통계 (질문 생성 수, facts 적용 수)
    const recentSessions = await db.prepare(`
      SELECT 
        ar.session_id,
        COUNT(DISTINCT f.id) as facts_count
      FROM ai_analysis_requests ar
      LEFT JOIN facts f ON ar.session_id = f.session_id
      GROUP BY ar.session_id
      ORDER BY ar.requested_at DESC
      LIMIT 10
    `).all<{
      session_id: string
      facts_count: number
    }>()
    
    const avgFactsApplied = (recentSessions.results || []).length > 0
      ? (recentSessions.results || []).reduce((sum, s) => sum + (s.facts_count || 0), 0) / (recentSessions.results || []).length
      : 0
    
    // 실제 followup_questions 생성 수 측정 (result_json에서 추출)
    let avgQuestionsGenerated = 0
    try {
      const recentResults = await db.prepare(`
        SELECT result_json FROM ai_analysis_results
        WHERE datetime(created_at) >= datetime('now', '-7 days')
        ORDER BY created_at DESC
        LIMIT 50
      `).all<{ result_json: string }>()
      
      if (recentResults.results && recentResults.results.length > 0) {
        let totalQuestions = 0
        let validResults = 0
        for (const row of recentResults.results) {
          try {
            const result = JSON.parse(row.result_json)
            const questionCount = Array.isArray(result.followup_questions) 
              ? result.followup_questions.length 
              : 0
            totalQuestions += questionCount
            validResults++
          } catch {
            // JSON 파싱 실패 시 무시
          }
        }
        avgQuestionsGenerated = validResults > 0 
          ? Math.round((totalQuestions / validResults) * 10) / 10 
          : 0
      }
    } catch {
      // 테이블 없거나 에러 시 기본값 유지
      avgQuestionsGenerated = 0
    }
    
    return c.json({
      taggedJobsCount: taggedJobs?.count || 0,
      candidatePoolSize: taggedJobs?.count || 0,
      targetPoolSize: 80,
      recentTaggerRun: recentRun || null,
      lowConfidenceCount: lowConf?.count || 0,
      analysisRequestsLast24h: analysisCount?.count || 0,
      followupsLast24h: followupCount?.count || 0,
      engineVersions: {
        scoring: VERSIONS.scoring,
        tagger: TAGGER_VERSION,
        recipe: VERSIONS.recipe,
      },
      recentSessionStats: {
        avgQuestionsGenerated,  // 실제 result_json에서 측정
        avgFactsApplied,
        totalSessions: (recentSessions.results || []).length,
      },
    })
    
  } catch (error) {
    return c.json({ 
      error: 'Failed to fetch overview',
      details: error instanceof Error ? error.message : String(error)
    }, 500)
  }
})

/**
 * GET /admin/api/ai/tagger-runs
 * Tagger 실행 이력
 */
adminAiApi.get('/tagger-runs', async (c) => {
  const db = c.env.DB
  const limit = parseInt(c.req.query('limit') || '20')
  
  try {
    const runs = await db.prepare(`
      SELECT * FROM tagger_runs
      ORDER BY started_at DESC
      LIMIT ?
    `).bind(limit).all()
    
    return c.json({ runs: runs.results })
    
  } catch (error) {
    return c.json({ error: 'Failed to fetch tagger runs' }, 500)
  }
})

/**
 * GET /admin/api/ai/tagger-errors
 * Tagger 에러 로그
 */
adminAiApi.get('/tagger-errors', async (c) => {
  const db = c.env.DB
  const limit = parseInt(c.req.query('limit') || '50')
  
  try {
    const errors = await db.prepare(`
      SELECT * FROM tagger_errors
      ORDER BY created_at DESC
      LIMIT ?
    `).bind(limit).all()
    
    return c.json({ errors: errors.results })
    
  } catch (error) {
    return c.json({ error: 'Failed to fetch tagger errors' }, 500)
  }
})

/**
 * GET /admin/api/ai/low-confidence-jobs
 * Low confidence jobs 목록
 */
adminAiApi.get('/low-confidence-jobs', async (c) => {
  const db = c.env.DB
  const limit = parseInt(c.req.query('limit') || '20')
  const threshold = parseFloat(c.req.query('threshold') || '0.75')
  
  try {
    const jobs = await db.prepare(`
      SELECT job_id, job_name, _confidence
      FROM job_attributes
      WHERE _confidence < ?
      ORDER BY _confidence ASC
      LIMIT ?
    `).bind(threshold, limit).all<{
      job_id: string
      job_name: string
      _confidence: number
    }>()
    
    return c.json({ jobs: jobs.results })
    
  } catch (error) {
    return c.json({ error: 'Failed to fetch low confidence jobs' }, 500)
  }
})

/**
 * GET /admin/api/ai/db-stats
 * DB 통계 (테이블별 row count 등)
 */
adminAiApi.get('/db-stats', async (c) => {
  const db = c.env.DB
  
  try {
    const tables = [
      'job_attributes',
      'tagger_runs',
      'tagger_errors',
      'ai_analysis_requests',
      'ai_analysis_results',
      'raw_events',
      'facts',
      'followup_responses',
      'confirmed_constraints',
    ]
    
    const stats: Record<string, number> = {}
    
    for (const table of tables) {
      try {
        const result = await db.prepare(`SELECT COUNT(*) as count FROM ${table}`).first<{ count: number }>()
        stats[table] = result?.count || 0
      } catch {
        stats[table] = -1  // 테이블 없음
      }
    }
    
    return c.json({ stats })
    
  } catch (error) {
    return c.json({ error: 'Failed to fetch db stats' }, 500)
  }
})

/**
 * GET /admin/api/ai/metrics
 * Phase 4 메트릭스 조회 (최근 7일/30일 집계)
 */
adminAiApi.get('/metrics', async (c) => {
  const db = c.env.DB
  const days = parseInt(c.req.query('days') || '7')
  const validDays = Math.min(Math.max(days, 1), 90) // 1~90일 범위
  
  try {
    // 1. 기간 내 총 분석 요청 수
    const totalAnalysis = await db.prepare(`
      SELECT COUNT(*) as count FROM ai_analysis_requests
      WHERE datetime(requested_at) >= datetime('now', '-${validDays} days')
    `).first<{ count: number }>()
    
    // 2. DIVERSITY_GUARD_APPLIED 이벤트 수
    const diversityGuardCount = await db.prepare(`
      SELECT COUNT(*) as count FROM raw_events
      WHERE event_type = 'DIVERSITY_GUARD_APPLIED'
        AND datetime(created_at) >= datetime('now', '-${validDays} days')
    `).first<{ count: number }>()
    
    // 3. RESEARCH_BIAS_CAP_APPLIED 이벤트 수
    const researchBiasCapCount = await db.prepare(`
      SELECT COUNT(*) as count FROM raw_events
      WHERE event_type = 'RESEARCH_BIAS_CAP_APPLIED'
        AND datetime(created_at) >= datetime('now', '-${validDays} days')
    `).first<{ count: number }>()
    
    // 4. Phase 4 적용 분석 수 (result_json에서 phase4_applied = true인 것)
    const phase4AppliedCount = await db.prepare(`
      SELECT COUNT(*) as count FROM ai_analysis_results ar
      JOIN ai_analysis_requests req ON ar.request_id = req.id
      WHERE datetime(req.requested_at) >= datetime('now', '-${validDays} days')
        AND json_extract(ar.result_json, '$.phase4_applied') = 1
    `).first<{ count: number }>()
    
    // 5. 일별 추세 (최근 7일)
    const dailyTrend = await db.prepare(`
      SELECT 
        date(created_at) as date,
        SUM(CASE WHEN event_type = 'DIVERSITY_GUARD_APPLIED' THEN 1 ELSE 0 END) as diversity_guard,
        SUM(CASE WHEN event_type = 'RESEARCH_BIAS_CAP_APPLIED' THEN 1 ELSE 0 END) as research_bias_cap,
        SUM(CASE WHEN event_type = 'ANALYSIS_COMPLETED' THEN 1 ELSE 0 END) as analysis_completed
      FROM raw_events
      WHERE datetime(created_at) >= datetime('now', '-7 days')
      GROUP BY date(created_at)
      ORDER BY date DESC
    `).all<{
      date: string
      diversity_guard: number
      research_bias_cap: number
      analysis_completed: number
    }>()
    
    // 비율 계산
    const total = totalAnalysis?.count || 0
    const diversityGuardRate = total > 0 
      ? Math.round((diversityGuardCount?.count || 0) / total * 100) 
      : 0
    const researchBiasCapRate = total > 0 
      ? Math.round((researchBiasCapCount?.count || 0) / total * 100) 
      : 0
    const phase4ApplicationRate = total > 0 
      ? Math.round((phase4AppliedCount?.count || 0) / total * 100) 
      : 0
    
    return c.json({
      period_days: validDays,
      total_analysis: total,
      metrics: {
        diversity_guard: {
          count: diversityGuardCount?.count || 0,
          rate_percent: diversityGuardRate,
        },
        research_bias_cap: {
          count: researchBiasCapCount?.count || 0,
          rate_percent: researchBiasCapRate,
        },
        phase4_applied: {
          count: phase4AppliedCount?.count || 0,
          rate_percent: phase4ApplicationRate,
        },
      },
      daily_trend: dailyTrend.results || [],
      generated_at: new Date().toISOString(),
    })
    
  } catch (error) {
    return c.json({ 
      error: 'Failed to fetch metrics',
      details: error instanceof Error ? error.message : String(error)
    }, 500)
  }
})

/**
 * POST /admin/api/ai/retag-majors
 * 전공 속성 자동 태깅 (major_attributes 테이블 채우기)
 * batch_size: 한 번에 처리할 전공 수 (기본 10, 최대 30)
 * offset: 시작 위치 (기본 0)
 * 여러 번 호출하여 전체 전공을 처리해야 함
 */
adminAiApi.post('/retag-majors', async (c) => {
  const db = c.env.DB
  const openaiKey = (c.env as any).OPENAI_API_KEY
  if (!openaiKey) {
    return c.json({ error: 'OPENAI_API_KEY not configured' }, 500)
  }

  const body = await c.req.json().catch(() => ({})) as { batch_size?: number; offset?: number }
  const batchSize = Math.min(Math.max(body.batch_size || 10, 1), 30)
  const offset = Math.max(body.offset || 0, 0)

  try {
    // 미태깅 전공 조회
    const majors = await db.prepare(`
      SELECT m.id, m.name, m.merged_profile_json
      FROM majors m
      LEFT JOIN major_attributes ma ON m.id = ma.major_id
      WHERE ma.major_id IS NULL AND m.name IS NOT NULL
      ORDER BY m.id
      LIMIT ? OFFSET ?
    `).bind(batchSize, offset).all<{
      id: number; name: string; merged_profile_json: string | null
    }>()

    const totalRemaining = await db.prepare(`
      SELECT COUNT(*) as cnt FROM majors m
      LEFT JOIN major_attributes ma ON m.id = ma.major_id
      WHERE ma.major_id IS NULL AND m.name IS NOT NULL
    `).first<{ cnt: number }>()

    const { autoTagMajor } = await import('./auto-tagger-major')
    const results: Array<{ major_id: number; major_name: string; success: boolean; error?: string }> = []

    for (const major of majors.results || []) {
      const result = await autoTagMajor(db, major, openaiKey)
      results.push({
        major_id: major.id,
        major_name: major.name,
        success: result.success,
        error: result.error,
      })
    }

    const successCount = results.filter(r => r.success).length
    const failCount = results.filter(r => !r.success).length

    return c.json({
      processed: results.length,
      success: successCount,
      failed: failCount,
      remaining: (totalRemaining?.cnt || 0) - successCount,
      next_offset: offset + batchSize,
      results,
    })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

/**
 * POST /admin/api/ai/retag-all
 * 전체 직업 재태깅 (v2 속성 추가용)
 * batch_size: 한 번에 처리할 직업 수 (기본 10, 최대 50)
 * offset: 시작 위치 (기본 0)
 */
adminAiApi.post('/retag-all', async (c) => {
  const db = c.env.DB
  const openaiKey = (c.env as any).OPENAI_API_KEY
  if (!openaiKey) {
    return c.json({ error: 'OPENAI_API_KEY not configured' }, 500)
  }

  const body = await c.req.json().catch(() => ({})) as { batch_size?: number; offset?: number }
  const batchSize = Math.min(Math.max(body.batch_size || 10, 1), 50)
  const offset = Math.max(body.offset || 0, 0)

  try {
    // v2 미태깅 직업 조회 (tagger_version이 v2가 아닌 것들)
    const jobs = await db.prepare(`
      SELECT j.id, j.name, j.api_data_json, j.merged_profile_json, j.user_contributed_json, j.admin_data_json
      FROM jobs j
      LEFT JOIN job_attributes ja ON j.id = ja.job_id AND ja.tagger_version = 'auto-inline-v2.0.0'
      WHERE ja.job_id IS NULL
      ORDER BY j.name
      LIMIT ? OFFSET ?
    `).bind(batchSize, offset).all<{
      id: string; name: string
      api_data_json: string | null; merged_profile_json: string | null
      user_contributed_json: string | null; admin_data_json: string | null
    }>()

    const totalRemaining = await db.prepare(`
      SELECT COUNT(*) as cnt FROM jobs j
      LEFT JOIN job_attributes ja ON j.id = ja.job_id AND ja.tagger_version = 'auto-inline-v2.0.0'
      WHERE ja.job_id IS NULL
    `).first<{ cnt: number }>()

    const { autoTagJob } = await import('./auto-tagger')
    const results: Array<{ job_id: string; job_name: string; success: boolean; error?: string }> = []

    for (const job of jobs.results || []) {
      const result = await autoTagJob(db, job, openaiKey)
      results.push({
        job_id: job.id,
        job_name: job.name,
        success: result.success,
        error: result.error,
      })
    }

    const successCount = results.filter(r => r.success).length
    const failCount = results.filter(r => !r.success).length

    return c.json({
      processed: results.length,
      success: successCount,
      failed: failCount,
      remaining: (totalRemaining?.cnt || 0) - successCount,
      next_offset: offset + batchSize,
      results,
    })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

/**
 * POST /admin/api/ai/retag-flat50
 * flat-50 노이즈 직업 재태깅 (모든 주요 속성이 50인 직업)
 * batch_size: 한 번에 처리할 직업 수 (기본 5, 최대 20)
 * offset: 시작 위치 (기본 0)
 */
adminAiApi.post('/retag-flat50', async (c) => {
  const db = c.env.DB
  const openaiKey = (c.env as any).OPENAI_API_KEY
  if (!openaiKey) {
    return c.json({ error: 'OPENAI_API_KEY not configured' }, 500)
  }

  const body = await c.req.json().catch(() => ({})) as { batch_size?: number; offset?: number }
  const batchSize = Math.min(Math.max(body.batch_size || 5, 1), 20)
  const offset = Math.max(body.offset || 0, 0)

  try {
    // flat-50 직업 조회: 주요 4개 속성이 모두 50인 직업
    const jobs = await db.prepare(`
      SELECT j.id, j.name, j.api_data_json, j.merged_profile_json, j.user_contributed_json, j.admin_data_json
      FROM jobs j
      INNER JOIN job_attributes ja ON j.id = ja.job_id
      WHERE ja.analytical = 50 AND ja.creative = 50 AND ja.execution = 50
        AND ja.people_facing = 50
      ORDER BY j.name
      LIMIT ? OFFSET ?
    `).bind(batchSize, offset).all<{
      id: string; name: string
      api_data_json: string | null; merged_profile_json: string | null
      user_contributed_json: string | null; admin_data_json: string | null
    }>()

    const totalFlat50 = await db.prepare(`
      SELECT COUNT(*) as cnt FROM jobs j
      INNER JOIN job_attributes ja ON j.id = ja.job_id
      WHERE ja.analytical = 50 AND ja.creative = 50 AND ja.execution = 50
        AND ja.people_facing = 50
    `).first<{ cnt: number }>()

    // 기존 속성 삭제 후 재태깅 (flat-50이므로 안전하게 삭제 가능)
    const { autoTagJob } = await import('./auto-tagger')
    const results: Array<{ job_id: string; job_name: string; success: boolean; error?: string }> = []

    for (const job of jobs.results || []) {
      // 기존 flat-50 속성 행 삭제
      await db.prepare('DELETE FROM job_attributes WHERE job_id = ?').bind(job.id).run()
      // 새로운 속성으로 재태깅
      const result = await autoTagJob(db, job, openaiKey)
      results.push({
        job_id: job.id,
        job_name: job.name,
        success: result.success,
        error: result.error,
      })
    }

    const successCount = results.filter(r => r.success).length
    const failCount = results.filter(r => !r.success).length

    return c.json({
      total_flat50: totalFlat50?.cnt || 0,
      processed: results.length,
      success: successCount,
      failed: failCount,
      remaining: (totalFlat50?.cnt || 0) - successCount,
      next_offset: offset + batchSize,
      results,
    })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

/**
 * POST /admin/api/ai/retag-category-defaults
 * 카테고리 기본값(knowledge/office) 직업 재태깅
 * flat-50이 아닌 직업 중 카테고리만 기본값인 직업을 대상으로 함
 * batch_size: 한 번에 처리할 직업 수 (기본 5, 최대 20)
 */
adminAiApi.post('/retag-category-defaults', async (c) => {
  const db = c.env.DB
  const openaiKey = (c.env as any).OPENAI_API_KEY
  if (!openaiKey) {
    return c.json({ error: 'OPENAI_API_KEY not configured' }, 500)
  }

  const body = await c.req.json().catch(() => ({})) as { batch_size?: number }
  const batchSize = Math.min(Math.max(body.batch_size || 5, 1), 20)

  try {
    // 카테고리 기본값 직업 조회: job_type='knowledge' AND work_environment='office'
    // 단, flat-50은 제외 (이미 retag-flat50에서 처리)
    const jobs = await db.prepare(`
      SELECT j.id, j.name, j.api_data_json, j.merged_profile_json, j.user_contributed_json, j.admin_data_json
      FROM jobs j
      INNER JOIN job_attributes ja ON j.id = ja.job_id
      WHERE ja.job_type = 'knowledge' AND ja.work_environment = 'office'
        AND NOT (ja.analytical = 50 AND ja.creative = 50 AND ja.execution = 50 AND ja.people_facing = 50)
      ORDER BY j.name
      LIMIT ?
    `).bind(batchSize).all<{
      id: string; name: string
      api_data_json: string | null; merged_profile_json: string | null
      user_contributed_json: string | null; admin_data_json: string | null
    }>()

    const totalDefaults = await db.prepare(`
      SELECT COUNT(*) as cnt FROM jobs j
      INNER JOIN job_attributes ja ON j.id = ja.job_id
      WHERE ja.job_type = 'knowledge' AND ja.work_environment = 'office'
        AND NOT (ja.analytical = 50 AND ja.creative = 50 AND ja.execution = 50 AND ja.people_facing = 50)
    `).first<{ cnt: number }>()

    const { autoTagJob } = await import('./auto-tagger')
    const results: Array<{ job_id: string; job_name: string; success: boolean; error?: string }> = []

    for (const job of jobs.results || []) {
      // 기존 속성 삭제 후 재태깅
      await db.prepare('DELETE FROM job_attributes WHERE job_id = ?').bind(job.id).run()
      const result = await autoTagJob(db, job, openaiKey)
      results.push({
        job_id: job.id,
        job_name: job.name,
        success: result.success,
        error: result.error,
      })
    }

    const successCount = results.filter(r => r.success).length
    const failCount = results.filter(r => !r.success).length

    return c.json({
      total_category_defaults: totalDefaults?.cnt || 0,
      processed: results.length,
      success: successCount,
      failed: failCount,
      remaining: (totalDefaults?.cnt || 0) - successCount,
      results,
    })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

// ============================================
// 직업 MECE 분류 API
// ============================================

/**
 * POST /admin/api/ai/classify/migrate-goyong24
 * A그룹: breadcrumb 직업 530개를 job_categories로 이관
 */
adminAiApi.post('/classify/migrate-goyong24', async (c) => {
  const db = c.env.DB
  const body = await c.req.json().catch(() => ({})) as { batch_size?: number }
  const batchSize = Math.min(Math.max(body.batch_size || 50, 1), 200)
  try {
    // breadcrumb 타입이면서 아직 job_categories에 없는 직업 (배치)
    const jobs = await db.prepare(`
      SELECT j.id, j.merged_profile_json
      FROM jobs j
      LEFT JOIN job_categories jc ON j.id = jc.job_id
      WHERE j.is_active = 1
        AND jc.job_id IS NULL
        AND j.goyong24_id IS NOT NULL
        AND j.merged_profile_json LIKE '%"type":"breadcrumb"%'
      LIMIT ?
    `).bind(batchSize).all<{ id: string; merged_profile_json: string }>()

    const rows = jobs.results || []
    let success = 0
    let failed = 0
    const errors: string[] = []

    for (const row of rows) {
      try {
        const profile = JSON.parse(row.merged_profile_json || '{}')
        let large = profile.heroCategory?.large || ''
        const medium = profile.heroCategory?.medium || ''

        if (!large) { failed++; continue }

        // 이상값 매핑
        if (BREADCRUMB_ANOMALY_MAPPING[large]) {
          large = BREADCRUMB_ANOMALY_MAPPING[large]
        }

        // 유효한 대분류인지 검증
        if (!JOB_LARGE_CATEGORIES.includes(large as any)) {
          errors.push(`${row.id}: 알 수 없는 대분류 "${large}"`)
          failed++
          continue
        }

        await db.prepare(`
          INSERT OR REPLACE INTO job_categories (job_id, large_category, medium_category, source, confidence)
          VALUES (?, ?, ?, 'breadcrumb', 1.0)
        `).bind(row.id, large, medium || null).run()
        success++
      } catch (e) {
        failed++
        errors.push(`${row.id}: ${e instanceof Error ? e.message : String(e)}`)
      }
    }

    // 남은 개수 확인
    const remainingResult = await db.prepare(`
      SELECT COUNT(*) as cnt FROM jobs j
      LEFT JOIN job_categories jc ON j.id = jc.job_id
      WHERE j.is_active = 1 AND jc.job_id IS NULL
        AND j.goyong24_id IS NOT NULL
        AND j.merged_profile_json LIKE '%"type":"breadcrumb"%'
    `).first<{ cnt: number }>()

    return c.json({ processed: rows.length, success, failed, remaining: remainingResult?.cnt || 0, errors: errors.slice(0, 20) })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

/**
 * POST /admin/api/ai/classify/migrate-careernet
 * B그룹: CareerNet single+classifications 직업 302개를 매핑하여 이관
 */
adminAiApi.post('/classify/migrate-careernet', async (c) => {
  const db = c.env.DB
  const body = await c.req.json().catch(() => ({})) as { batch_size?: number }
  const batchSize = Math.min(Math.max(body.batch_size || 50, 1), 200)
  try {
    // CareerNet 분류가 있으면서 아직 job_categories에 없는 직업
    const jobs = await db.prepare(`
      SELECT j.id, j.merged_profile_json
      FROM jobs j
      LEFT JOIN job_categories jc ON j.id = jc.job_id
      WHERE j.is_active = 1
        AND jc.job_id IS NULL
        AND j.careernet_id IS NOT NULL
        AND j.merged_profile_json LIKE '%"classifications"%'
        AND j.merged_profile_json LIKE '%"type":"single"%'
      LIMIT ?
    `).bind(batchSize).all<{ id: string; merged_profile_json: string }>()

    const rows = jobs.results || []
    let success = 0
    let failed = 0
    const errors: string[] = []

    for (const row of rows) {
      try {
        const profile = JSON.parse(row.merged_profile_json || '{}')
        const careernetLarge = profile.classifications?.large || ''
        const standardLarge = CAREERNET_TO_STANDARD_MAPPING[careernetLarge]

        if (!standardLarge) {
          errors.push(`${row.id}: 매핑 없는 CareerNet 분류 "${careernetLarge}"`)
          failed++
          continue
        }

        // CareerNet 원본 분류를 medium에 보존
        await db.prepare(`
          INSERT OR REPLACE INTO job_categories (job_id, large_category, medium_category, source, confidence)
          VALUES (?, ?, ?, 'careernet_mapping', 0.9)
        `).bind(row.id, standardLarge, careernetLarge).run()
        success++
      } catch (e) {
        failed++
        errors.push(`${row.id}: ${e instanceof Error ? e.message : String(e)}`)
      }
    }

    const remainingResult = await db.prepare(`
      SELECT COUNT(*) as cnt FROM jobs j
      LEFT JOIN job_categories jc ON j.id = jc.job_id
      WHERE j.is_active = 1 AND jc.job_id IS NULL
        AND j.careernet_id IS NOT NULL
        AND j.merged_profile_json LIKE '%"classifications"%'
        AND j.merged_profile_json LIKE '%"type":"single"%'
    `).first<{ cnt: number }>()

    return c.json({ processed: rows.length, success, failed, remaining: remainingResult?.cnt || 0, errors: errors.slice(0, 20) })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

/**
 * POST /admin/api/ai/classify/batch-llm
 * C그룹: 미분류 직업을 LLM으로 배치 분류
 * body: { batch_size?: number } (기본 10, 최대 30)
 */
adminAiApi.post('/classify/batch-llm', async (c) => {
  const db = c.env.DB
  const openaiKey = (c.env as any).OPENAI_API_KEY
  if (!openaiKey) {
    return c.json({ error: 'OPENAI_API_KEY not configured' }, 500)
  }

  const body = await c.req.json().catch(() => ({})) as { batch_size?: number }
  const batchSize = Math.min(Math.max(body.batch_size || 10, 1), 30)

  try {
    // 미분류 직업 조회 (job_categories에 없는 active 직업)
    const jobs = await db.prepare(`
      SELECT j.id, j.name, j.merged_profile_json,
             ja.job_type
      FROM jobs j
      LEFT JOIN job_attributes ja ON j.id = ja.job_id
      WHERE j.is_active = 1
        AND j.id NOT IN (SELECT job_id FROM job_categories)
      ORDER BY j.name
      LIMIT ?
    `).bind(batchSize).all<{
      id: string; name: string; merged_profile_json: string; job_type: string | null
    }>()

    const rows = jobs.results || []
    if (rows.length === 0) {
      const totalResult = await db.prepare(
        `SELECT COUNT(*) as cnt FROM jobs WHERE is_active = 1`
      ).first<{ cnt: number }>()
      const classifiedResult = await db.prepare(
        `SELECT COUNT(*) as cnt FROM job_categories`
      ).first<{ cnt: number }>()
      return c.json({
        processed: 0, success: 0, failed: 0, remaining: 0,
        total_jobs: totalResult?.cnt || 0,
        total_classified: classifiedResult?.cnt || 0,
        results: [],
      })
    }

    // 남은 미분류 직업 수
    const remainingResult = await db.prepare(`
      SELECT COUNT(*) as cnt FROM jobs j
      WHERE j.is_active = 1
        AND j.id NOT IN (SELECT job_id FROM job_categories)
    `).first<{ cnt: number }>()
    const remainingCount = (remainingResult?.cnt || 0) - rows.length

    const classificationList = getClassificationPromptList()
    const results: Array<{ job_id: string; job_name: string; success: boolean; large?: string; medium?: string; error?: string }> = []
    let successCount = 0
    let failCount = 0

    // 각 직업을 LLM으로 분류
    for (const row of rows) {
      try {
        const profile = JSON.parse(row.merged_profile_json || '{}')
        const heroIntro = profile.heroIntro || profile.summary || ''
        const industry = profile.heroCategory?.value || profile.categoryName || ''
        const jobType = row.job_type || ''

        const prompt = `아래 직업을 분류 체계에서 골라 대분류(large)와 중분류(medium)로 분류하세요.

## 직업 정보
- 직업명: ${row.name}
- 소개: ${heroIntro.substring(0, 300)}
${industry ? `- 산업: ${industry}` : ''}
${jobType ? `- 직업유형: ${jobType}` : ''}

## 분류 체계 (반드시 아래 목록에서만 선택)
${classificationList}

## ⚠️ 주의사항
- 대분류는 반드시 위 10개 중 하나를 **정확히 그대로** 사용하세요.
- "제조직", "경비업" 등 목록에 없는 분류는 절대 사용하지 마세요.
- 산업분류(KSIC)가 아닌 직업분류입니다.
- 가스·전기·생산·제조 관련 직업 → "설치·정비·생산직"
- 경비·보안·청소 관련 직업 → "미용·여행·숙박·음식·경비·청소직"

## 응답 (JSON만)
{"large": "대분류명", "medium": "중분류명"}`

        const llmResult = await callOpenAI(
          openaiKey,
          [{ role: 'user', content: prompt }],
          { temperature: 0.1, max_tokens: 100, model: 'gpt-4o-mini' }
        )

        const text = llmResult.response?.trim() || ''
        // JSON 파싱 (코드블록 안에 있을 수도 있음)
        const jsonMatch = text.match(/\{[\s\S]*?\}/)
        if (!jsonMatch) {
          throw new Error(`LLM 응답 파싱 실패: ${text.substring(0, 100)}`)
        }

        const parsed = JSON.parse(jsonMatch[0])
        let large = parsed.large as string
        const medium = parsed.medium as string | undefined
        let confidence = 0.8

        // 대분류 검증 (직접 매칭 → 퍼지 매칭 폴백)
        if (!JOB_LARGE_CATEGORIES.includes(large as any)) {
          const fuzzyResult = fuzzyMatchLargeCategory(large)
          if (fuzzyResult) {
            large = fuzzyResult
            confidence = 0.6
          } else {
            throw new Error(`유효하지 않은 대분류: "${parsed.large}"`)
          }
        }

        await db.prepare(`
          INSERT OR REPLACE INTO job_categories (job_id, large_category, medium_category, source, confidence)
          VALUES (?, ?, ?, 'llm', ?)
        `).bind(row.id, large, medium || null, confidence).run()

        results.push({ job_id: row.id, job_name: row.name, success: true, large, medium })
        successCount++
      } catch (e) {
        const errMsg = e instanceof Error ? e.message : String(e)
        results.push({ job_id: row.id, job_name: row.name, success: false, error: errMsg })
        failCount++
      }
    }

    return c.json({
      processed: rows.length,
      success: successCount,
      failed: failCount,
      remaining: Math.max(0, remainingCount),
      results,
    })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

/**
 * POST /admin/api/ai/classify/migrate-majors
 * 전공 608개를 field_category → 한글 대분류로 이관
 */
adminAiApi.post('/classify/migrate-majors', async (c) => {
  const db = c.env.DB
  try {
    const majors = await db.prepare(`
      SELECT m.id, ma.field_category
      FROM majors m
      INNER JOIN major_attributes ma ON m.id = ma.major_id
      WHERE m.is_active = 1
        AND ma.field_category IS NOT NULL
        AND m.id NOT IN (SELECT major_id FROM major_categories)
    `).all<{ id: string; field_category: string }>()

    const rows = majors.results || []
    let success = 0
    let failed = 0
    const errors: string[] = []

    for (const row of rows) {
      try {
        const label = MAJOR_FIELD_LABELS[row.field_category]
        if (!label) {
          errors.push(`${row.id}: 알 수 없는 field_category "${row.field_category}"`)
          failed++
          continue
        }

        await db.prepare(`
          INSERT OR REPLACE INTO major_categories (major_id, large_category, source, confidence)
          VALUES (?, ?, 'attribute', 1.0)
        `).bind(row.id, label).run()
        success++
      } catch (e) {
        failed++
        errors.push(`${row.id}: ${e instanceof Error ? e.message : String(e)}`)
      }
    }

    return c.json({ total: rows.length, success, failed, errors: errors.slice(0, 20) })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

/**
 * POST /admin/api/ai/classify/override
 * 관리자 수동 분류 변경
 * body: { job_id: string, large_category: string, medium_category?: string }
 */
adminAiApi.post('/classify/override', async (c) => {
  const db = c.env.DB
  const body = await c.req.json().catch(() => ({})) as {
    job_id?: string; large_category?: string; medium_category?: string
  }

  if (!body.job_id || !body.large_category) {
    return c.json({ error: 'job_id and large_category are required' }, 400)
  }

  if (!JOB_LARGE_CATEGORIES.includes(body.large_category as any)) {
    return c.json({ error: `Invalid large_category: "${body.large_category}"` }, 400)
  }

  try {
    await db.prepare(`
      INSERT OR REPLACE INTO job_categories (job_id, large_category, medium_category, source, confidence, updated_at)
      VALUES (?, ?, ?, 'admin', 1.0, unixepoch() * 1000)
    `).bind(body.job_id, body.large_category, body.medium_category || null).run()

    return c.json({ success: true, job_id: body.job_id, large_category: body.large_category })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

/**
 * GET /admin/api/ai/classify/stats
 * 분류 통계
 */
adminAiApi.get('/classify/stats', async (c) => {
  const db = c.env.DB
  try {
    const [jobStats, majorStats, totalJobs, totalMajors] = await Promise.all([
      db.prepare(`
        SELECT large_category, COUNT(*) as cnt
        FROM job_categories
        GROUP BY large_category
        ORDER BY cnt DESC
      `).all<{ large_category: string; cnt: number }>(),
      db.prepare(`
        SELECT large_category, COUNT(*) as cnt
        FROM major_categories
        GROUP BY large_category
        ORDER BY cnt DESC
      `).all<{ large_category: string; cnt: number }>(),
      db.prepare(`SELECT COUNT(*) as cnt FROM jobs WHERE is_active = 1`).first<{ cnt: number }>(),
      db.prepare(`SELECT COUNT(*) as cnt FROM majors WHERE is_active = 1`).first<{ cnt: number }>(),
    ])

    const classifiedJobs = (jobStats.results || []).reduce((sum, r) => sum + r.cnt, 0)
    const classifiedMajors = (majorStats.results || []).reduce((sum, r) => sum + r.cnt, 0)

    return c.json({
      jobs: {
        total: totalJobs?.cnt || 0,
        classified: classifiedJobs,
        unclassified: (totalJobs?.cnt || 0) - classifiedJobs,
        byCategory: jobStats.results || [],
      },
      majors: {
        total: totalMajors?.cnt || 0,
        classified: classifiedMajors,
        unclassified: (totalMajors?.cnt || 0) - classifiedMajors,
        byCategory: majorStats.results || [],
      },
    })
  } catch (error) {
    return c.json({ error: error instanceof Error ? error.message : String(error) }, 500)
  }
})

export { adminAiApi }

