// src/services/ai-analyzer/history-routes.ts
// ============================================
// AI Analyzer History API (결과 이력 조회)
// ============================================

import { Hono } from 'hono'
import type { D1Database } from '@cloudflare/workers-types'

// ============================================
// Types
// ============================================
interface AnalysisResult {
  id: number
  request_id: number
  result_json: string
  career_state_json: string | null
  transition_signal_json: string | null
  confidence_score: number | null
  key_decision_variables: string | null
  created_at: string
}

interface AnalysisRequest {
  id: number
  session_id: string
  analysis_type: string
  status: string
  created_at: string
}

interface HistoryItem {
  id: number
  request_id: number
  session_id: string
  analysis_type: string
  result_label: string
  result_summary: {
    top_jobs?: Array<{ name: string; score: number }>
    top_majors?: Array<{ name: string; score: number }>
  }
  confidence_score: number | null
  created_at: string
  // V3 추가 필드
  engine_version?: 'v2' | 'v3'
  has_premium_report?: boolean
  // 버전 관리
  version_number?: number
  version_note?: string | null
  parent_request_id?: number | null
}

interface Env {
  DB: D1Database
  JWT_SECRET: string
}

// Helper: 미들웨어에서 인증된 사용자 조회
function getUserFromContext(c: any): { id: number; username: string; role: string } | null {
  const user = c.get('user')
  if (!user) return null
  return { id: user.id, username: user.username || '', role: user.role }
}

// ============================================
// Routes
// ============================================
export const historyRoutes = new Hono<{ Bindings: Env }>()

// GET /api/analyzer/history - 결과 이력 조회
historyRoutes.get('/', async (c) => {
  const db = c.env.DB

  // 로그인 체크 (쿠키에서 직접 JWT 검증)
  const user = getUserFromContext(c)
  if (!user?.id) {
    return c.json({ error: 'Login required', code: 'AUTH_REQUIRED' }, 401)
  }
  const userId = user.id

  try {
    const page = parseInt(c.req.query('page') || '1', 10)
    const limit = Math.min(parseInt(c.req.query('limit') || '10', 10), 50)
    const offset = (page - 1) * limit

    // 총 개수 조회
    const countResult = await db
      .prepare(`
        SELECT COUNT(*) as total
        FROM ai_analysis_results r
        JOIN ai_analysis_requests req ON r.request_id = req.id
        WHERE req.user_id = ?
      `)
      .bind(userId)
      .first<{ total: number }>()

    const total = countResult?.total || 0

    // 결과 조회 (engine_version, premium_report_json, 버전 관리 필드 추가)
    const results = await db
      .prepare(`
        SELECT
          r.id,
          r.request_id,
          r.result_json,
          r.career_state_json,
          r.confidence_score,
          r.created_at,
          r.engine_version,
          CASE WHEN r.premium_report_json IS NOT NULL THEN 1 ELSE 0 END as has_premium_report,
          req.session_id,
          req.analysis_type,
          req.version_number,
          req.version_note,
          req.parent_request_id
        FROM ai_analysis_results r
        JOIN ai_analysis_requests req ON r.request_id = req.id
        WHERE req.user_id = ?
        ORDER BY r.created_at DESC
        LIMIT ? OFFSET ?
      `)
      .bind(userId, limit, offset)
      .all<{
        id: number
        request_id: number
        result_json: string
        career_state_json: string | null
        confidence_score: number | null
        created_at: string
        session_id: string
        analysis_type: string
        engine_version: string | null
        has_premium_report: number
        version_number: number | null
        version_note: string | null
        parent_request_id: number | null
      }>()

    // 결과 가공
    const historyItems: HistoryItem[] = (results.results || []).map((row) => {
      let resultSummary: HistoryItem['result_summary'] = {}

      try {
        const resultJson = JSON.parse(row.result_json)
        if (resultJson.fit_top3) {
          resultSummary.top_jobs = resultJson.fit_top3.slice(0, 3).map((j: any) => ({
            name: j.job_name || j.name,
            score: j.final_score || j.score,
          }))
        }
        if (resultJson.fit_top_majors) {
          resultSummary.top_majors = resultJson.fit_top_majors.slice(0, 3).map((m: any) => ({
            name: m.major_name || m.name,
            score: m.score,
          }))
        }
      } catch (e) {
        // JSON 파싱 실패 시 빈 summary
      }

      return {
        id: row.id,
        request_id: row.request_id,
        session_id: row.session_id,
        analysis_type: row.analysis_type,
        result_label: row.analysis_type === 'major' ? '추천 전공' : '추천 직업',
        result_summary: resultSummary,
        confidence_score: row.confidence_score,
        created_at: row.created_at,
        // V3 호환성 - engine_version이 null이면 'v2'로 간주
        engine_version: (row.engine_version as 'v2' | 'v3') || 'v2',
        has_premium_report: row.has_premium_report === 1,
        // 버전 관리
        version_number: row.version_number || 1,
        version_note: row.version_note || null,
        parent_request_id: row.parent_request_id || null,
      }
    })

    return c.json({
      results: historyItems,
      pagination: {
        page,
        limit,
        total,
        total_pages: Math.ceil(total / limit),
      },
    })
  } catch (error) {
    return c.json({ error: 'Failed to load history', details: String(error) }, 500)
  }
})

// GET /api/analyzer/history/:id - 특정 결과 상세 조회
historyRoutes.get('/:id', async (c) => {
  const db = c.env.DB

  // 로그인 체크 (쿠키에서 직접 JWT 검증)
  const user = getUserFromContext(c)
  if (!user?.id) {
    return c.json({ error: 'Login required', code: 'AUTH_REQUIRED' }, 401)
  }
  const userId = user.id

  try {
    const resultId = parseInt(c.req.param('id'), 10)

    if (isNaN(resultId)) {
      return c.json({ error: 'Invalid result ID' }, 400)
    }

    const result = await db
      .prepare(`
        SELECT
          r.*,
          req.session_id,
          req.analysis_type,
          req.payload_json as request_payload,
          req.version_number,
          req.version_note,
          req.parent_request_id
        FROM ai_analysis_results r
        JOIN ai_analysis_requests req ON r.request_id = req.id
        WHERE r.id = ? AND req.user_id = ?
      `)
      .bind(resultId, userId)
      .first<{
        id: number
        request_id: number
        result_json: string
        career_state_json: string | null
        transition_signal_json: string | null
        confidence_score: number | null
        key_decision_variables: string | null
        scoring_trace_json: string | null
        created_at: string
        session_id: string
        analysis_type: string
        request_payload: string | null
        engine_version: string | null
        premium_report_json: string | null
        version_number: number | null
        version_note: string | null
        parent_request_id: number | null
      }>()

    if (!result) {
      return c.json({ error: 'Result not found or access denied' }, 404)
    }

    // 같은 session의 버전 목록 조회
    const versionSiblings = await db
      .prepare(`
        SELECT req.id as request_id, req.version_number, req.version_note, r.created_at
        FROM ai_analysis_requests req
        JOIN ai_analysis_results r ON r.request_id = req.id
        WHERE req.session_id = ?
        ORDER BY req.version_number ASC
      `)
      .bind(result.session_id)
      .all<{ request_id: number; version_number: number | null; version_note: string | null; created_at: string }>()

    const parsedResult = {
      id: result.id,
      request_id: result.request_id,
      session_id: result.session_id,
      analysis_type: result.analysis_type,
      result: JSON.parse(result.result_json),
      career_state: result.career_state_json ? JSON.parse(result.career_state_json) : null,
      transition_signal: result.transition_signal_json ? JSON.parse(result.transition_signal_json) : null,
      confidence_score: result.confidence_score,
      key_decision_variables: result.key_decision_variables ? JSON.parse(result.key_decision_variables) : null,
      scoring_trace: result.scoring_trace_json ? JSON.parse(result.scoring_trace_json) : null,
      request_payload: result.request_payload ? JSON.parse(result.request_payload) : null,
      created_at: result.created_at,
      engine_version: result.engine_version || 'v2',
      premium_report: result.premium_report_json ? JSON.parse(result.premium_report_json) : null,
      // 버전 관리
      version_number: result.version_number || 1,
      version_note: result.version_note || null,
      parent_request_id: result.parent_request_id || null,
      versions: (versionSiblings.results || []).map(v => ({
        request_id: v.request_id,
        version_number: v.version_number || 1,
        version_note: v.version_note || null,
        created_at: v.created_at,
      })),
    }

    return c.json({ result: parsedResult })
  } catch (error) {
    return c.json({ error: 'Failed to load history detail', details: String(error) }, 500)
  }
})
