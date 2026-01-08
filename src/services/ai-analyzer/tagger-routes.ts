// CareerWiki AI Analyzer - Tagger API Routes
// Version: tagger-v1.0.0 (Phase 1B)
// 태깅 배치 실행 및 QA 리포트 API

import { Hono } from 'hono'
import type { D1Database } from '@cloudflare/workers-types'
import {
  TAGGER_VERSION,
  DEFAULT_BATCH_CONFIG,
  GOLDEN_SET_JOB_IDS,
  runTaggerBatch,
} from './tagger-batch'
import {
  generateQAReport,
  formatReportMarkdown,
  formatReportConsole,
} from './qa-report'

// ============================================
// Bindings
// ============================================
interface Bindings {
  DB: D1Database
  GEMINI_API_KEY: string
  [key: string]: unknown
}

// ============================================
// Tagger Routes
// ============================================
const taggerRoutes = new Hono<{ Bindings: Bindings }>()

/**
 * POST /api/ai-analyzer/tagger/run-golden
 * 골든셋 30개 태깅 실행
 */
taggerRoutes.post('/run-golden', async (c) => {
  const db = c.env.DB
  const geminiApiKey = c.env.GEMINI_API_KEY || null  // null 허용 (스텁 모드)
  
  const runId = `golden-${Date.now()}`
  
  try {
    const result = await runTaggerBatch(
      {
        db: db as any,
        geminiApiKey,
        config: { ...DEFAULT_BATCH_CONFIG, batchSize: 10 },
        runId,
      },
      GOLDEN_SET_JOB_IDS,
      (progress) => {
        console.log(`Progress: ${progress.processed}/${progress.total}`)
      }
    )
    
    return c.json({
      success: true,
      run_id: runId,
      result,
    })
    
  } catch (error) {
    console.error('Tagger error:', error)
    return c.json({
      error: 'Tagger failed',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

/**
 * POST /api/ai-analyzer/tagger/run-batch
 * 커스텀 job_id 배치 태깅
 */
taggerRoutes.post('/run-batch', async (c) => {
  const db = c.env.DB
  const geminiApiKey = c.env.GEMINI_API_KEY || null  // null 허용 (스텁 모드)
  
  const body = await c.req.json<{
    job_ids?: string[]
    limit?: number
    offset?: number
  }>()
  
  let jobIds: string[]
  
  if (body.job_ids && body.job_ids.length > 0) {
    jobIds = body.job_ids
  } else {
    // job_sources에서 job_id 조회
    const limit = body.limit || 100
    const offset = body.offset || 0
    
    const results = await db.prepare(`
      SELECT job_id FROM job_sources
      WHERE source_system IN ('CAREERNET', 'WORK24_JOB')
      ORDER BY job_id
      LIMIT ? OFFSET ?
    `).bind(limit, offset).all<{ job_id: string }>()
    
    jobIds = (results.results || []).map(r => r.job_id)
  }
  
  if (jobIds.length === 0) {
    return c.json({ error: 'No job_ids to process' }, 400)
  }
  
  const runId = `batch-${Date.now()}`
  
  try {
    const result = await runTaggerBatch(
      {
        db: db as any,
        geminiApiKey,
        config: DEFAULT_BATCH_CONFIG,
        runId,
      },
      jobIds
    )
    
    return c.json({
      success: true,
      run_id: runId,
      result,
    })
    
  } catch (error) {
    console.error('Tagger error:', error)
    return c.json({
      error: 'Tagger failed',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

/**
 * GET /api/ai-analyzer/tagger/qa-report/:runId
 * QA 리포트 조회
 */
taggerRoutes.get('/qa-report/:runId', async (c) => {
  const db = c.env.DB
  const runId = c.req.param('runId')
  const format = c.req.query('format') || 'json'  // json, markdown, console
  
  try {
    const report = await generateQAReport(db as any, runId)
    
    if (format === 'markdown') {
      return c.text(formatReportMarkdown(report))
    } else if (format === 'console') {
      return c.text(formatReportConsole(report))
    }
    
    return c.json(report)
    
  } catch (error) {
    return c.json({
      error: 'Failed to generate QA report',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

/**
 * GET /api/ai-analyzer/tagger/runs
 * 태깅 실행 이력 조회
 */
taggerRoutes.get('/runs', async (c) => {
  const db = c.env.DB
  
  try {
    const results = await db.prepare(`
      SELECT * FROM tagger_runs ORDER BY started_at DESC LIMIT 20
    `).all()
    
    return c.json({ runs: results.results })
    
  } catch (error) {
    return c.json({ error: 'Failed to fetch runs' }, 500)
  }
})

/**
 * GET /api/ai-analyzer/tagger/stats
 * 태깅 통계
 */
taggerRoutes.get('/stats', async (c) => {
  const db = c.env.DB
  
  try {
    const total = await db.prepare(`
      SELECT COUNT(*) as count FROM job_attributes
    `).first<{ count: number }>()
    
    const bySource = await db.prepare(`
      SELECT source_system, COUNT(*) as count, AVG(_confidence) as avg_conf
      FROM job_attributes
      GROUP BY source_system
    `).all<{ source_system: string; count: number; avg_conf: number }>()
    
    const byVersion = await db.prepare(`
      SELECT tagger_version, COUNT(*) as count
      FROM job_attributes
      GROUP BY tagger_version
    `).all<{ tagger_version: string; count: number }>()
    
    return c.json({
      total: total?.count || 0,
      current_version: TAGGER_VERSION,
      by_source: bySource.results,
      by_version: byVersion.results,
    })
    
  } catch (error) {
    return c.json({ error: 'Failed to fetch stats' }, 500)
  }
})

/**
 * GET /api/ai-analyzer/tagger/job/:jobId
 * 단일 job의 태깅 결과 조회
 */
taggerRoutes.get('/job/:jobId', async (c) => {
  const db = c.env.DB
  const jobId = c.req.param('jobId')
  
  try {
    const result = await db.prepare(`
      SELECT * FROM job_attributes WHERE job_id = ?
    `).bind(jobId).first()
    
    if (!result) {
      return c.json({ error: 'Job not found' }, 404)
    }
    
    return c.json(result)
    
  } catch (error) {
    return c.json({ error: 'Failed to fetch job' }, 500)
  }
})

export { taggerRoutes }

