// CareerWiki AI Analyzer - Admin API
// 관제판 전용 API 엔드포인트

import { Hono } from 'hono'
import type { D1Database } from '@cloudflare/workers-types'
import { VERSIONS } from './types'
import { TAGGER_VERSION } from './job-attributes-types'

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

  const body = await c.req.json<{ batch_size?: number; offset?: number }>().catch(() => ({}))
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

  const body = await c.req.json<{ batch_size?: number; offset?: number }>().catch(() => ({}))
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

  const body = await c.req.json<{ batch_size?: number; offset?: number }>().catch(() => ({}))
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

export { adminAiApi }

