// src/services/ai-analyzer/resume-routes.ts
// ============================================
// P0: 이력서 파싱 API (텍스트만 처리)
// P0-8: PDF 원본 저장은 P1으로 미룸
// ============================================

import { Hono } from 'hono'
import type { D1Database, Ai } from '@cloudflare/workers-types'
import { getUserIdFromContext } from '../../utils/auth'
import { parseResumeText, parsedResumeToCareerState, type ParsedResumeData } from './resume-parser'

interface Env {
  D1: D1Database
  AI: Ai
}

const resumeRoutes = new Hono<{ Bindings: Env }>()

// ============================================
// POST /api/analyzer/resume/parse
// - 클라이언트에서 pdf.js로 추출한 텍스트를 받음
// - Workers AI로 파싱
// - 결과 반환 (저장은 선택적)
// ============================================
resumeRoutes.post('/parse', async (c) => {
  const userId = getUserIdFromContext(c)
  if (!userId) {
    return c.json({ error: 'UNAUTHORIZED', message: 'Login required' }, 401)
  }

  try {
    const body = await c.req.json()
    const { text, session_id, save_to_draft } = body as {
      text: string
      session_id?: string
      save_to_draft?: boolean
    }

    if (!text || typeof text !== 'string') {
      return c.json({ error: 'BAD_REQUEST', message: 'Resume text is required' }, 400)
    }

    // 텍스트 길이 제한 (10KB)
    if (text.length > 10000) {
      return c.json({
        error: 'BAD_REQUEST',
        message: 'Resume text too long (max 10KB)',
      }, 400)
    }

    // 텍스트가 너무 짧으면 경고
    if (text.length < 100) {
      return c.json({
        error: 'BAD_REQUEST',
        message: 'Resume text too short (min 100 characters)',
      }, 400)
    }

    // Workers AI로 파싱
    const parsed = await parseResumeText(c.env.AI, text)

    // 파싱 결과 저장 (옵션)
    if (save_to_draft && session_id) {
      await saveResumeDataToDraft(c.env.D1, userId, session_id, parsed)
    }

    return c.json({
      success: true,
      data: parsed,
      // 클라이언트에서 CareerState로 변환할 수 있도록 변환된 상태도 제공
      career_state: parsedResumeToCareerState(parsed),
    })
  } catch (error) {
    return c.json({
      error: 'INTERNAL_SERVER_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// 파싱 결과를 Draft에 저장
// ============================================
async function saveResumeDataToDraft(
  db: D1Database,
  userId: number,
  sessionId: string,
  parsed: ParsedResumeData
): Promise<void> {
  // 1. Draft 조회 또는 생성
  const { results: drafts } = await db.prepare(
    `SELECT id FROM analyzer_drafts WHERE user_id = ? AND session_id = ?`
  ).bind(userId, sessionId).all()

  let draftId: number

  if (drafts && drafts.length > 0) {
    draftId = (drafts[0] as { id: number }).id

    // CareerState 업데이트
    const careerState = parsedResumeToCareerState(parsed)
    await db.prepare(
      `UPDATE analyzer_drafts
       SET career_state_json = ?, updated_at = CURRENT_TIMESTAMP
       WHERE id = ?`
    ).bind(JSON.stringify(careerState), draftId).run()
  } else {
    // 새 Draft 생성
    const careerState = parsedResumeToCareerState(parsed)
    const { results } = await db.prepare(
      `INSERT INTO analyzer_drafts (user_id, session_id, analysis_type, current_step, career_state_json)
       VALUES (?, ?, 'job', 1, ?)
       RETURNING id`
    ).bind(userId, sessionId, JSON.stringify(careerState)).all()

    draftId = (results[0] as { id: number }).id
  }

  // 2. 기존 resume_parsed facts 삭제
  await db.prepare(
    `DELETE FROM analyzer_facts WHERE draft_id = ? AND source = 'resume_parsed'`
  ).bind(draftId).run()

  // 3. 파싱된 상태를 facts로 저장
  const facts: Array<{
    user_id: number | null
    session_id: string
    draft_id: number
    request_id: number | null
    fact_key: string
    value_json: string
    value_text: string | null
    rank_int: number | null
    source: string
    confidence_weight: number
  }> = []

  // 5축 상태 저장 (resume_parsed로 마킹)
  const inferred = parsed.inferred_state

  if (inferred.role_identity) {
    facts.push({
      user_id: userId,
      session_id: sessionId,
      draft_id: draftId,
      request_id: null,
      fact_key: 'state.role_identity',
      value_json: JSON.stringify(inferred.role_identity),
      value_text: inferred.role_identity,
      rank_int: null,
      source: 'resume_parsed',
      confidence_weight: 1.0,
    })
  }

  if (inferred.career_stage_years) {
    facts.push({
      user_id: userId,
      session_id: sessionId,
      draft_id: draftId,
      request_id: null,
      fact_key: 'state.career_stage_years',
      value_json: JSON.stringify(inferred.career_stage_years),
      value_text: inferred.career_stage_years,
      rank_int: null,
      source: 'resume_parsed',
      confidence_weight: 1.0,
    })
  }

  if (inferred.transition_status) {
    facts.push({
      user_id: userId,
      session_id: sessionId,
      draft_id: draftId,
      request_id: null,
      fact_key: 'state.transition_status',
      value_json: JSON.stringify(inferred.transition_status),
      value_text: inferred.transition_status,
      rank_int: null,
      source: 'resume_parsed',
      confidence_weight: 1.0,
    })
  }

  if (inferred.skill_level !== null && inferred.skill_level !== undefined) {
    facts.push({
      user_id: userId,
      session_id: sessionId,
      draft_id: draftId,
      request_id: null,
      fact_key: 'state.skill_level',
      value_json: JSON.stringify(inferred.skill_level),
      value_text: String(inferred.skill_level),
      rank_int: null,
      source: 'resume_parsed',
      confidence_weight: 1.0,
    })
  }

  // 스킬 저장
  if (parsed.extracted.skills.length > 0) {
    for (const skill of parsed.extracted.skills) {
      facts.push({
        user_id: userId,
        session_id: sessionId,
        draft_id: draftId,
        request_id: null,
        fact_key: 'resume.skill',
        value_json: JSON.stringify(skill),
        value_text: skill,
        rank_int: null,
        source: 'resume_parsed',
        confidence_weight: 1.0,
      })
    }
  }

  // 자격증 저장
  if (parsed.extracted.certifications.length > 0) {
    for (const cert of parsed.extracted.certifications) {
      facts.push({
        user_id: userId,
        session_id: sessionId,
        draft_id: draftId,
        request_id: null,
        fact_key: 'resume.certification',
        value_json: JSON.stringify(cert),
        value_text: cert,
        rank_int: null,
        source: 'resume_parsed',
        confidence_weight: 1.0,
      })
    }
  }

  // 업종 저장
  if (parsed.extracted.industries.length > 0) {
    for (const industry of parsed.extracted.industries) {
      facts.push({
        user_id: userId,
        session_id: sessionId,
        draft_id: draftId,
        request_id: null,
        fact_key: 'resume.industry',
        value_json: JSON.stringify(industry),
        value_text: industry,
        rank_int: null,
        source: 'resume_parsed',
        confidence_weight: 1.0,
      })
    }
  }

  // 학력 수준
  if (parsed.extracted.education_level) {
    facts.push({
      user_id: userId,
      session_id: sessionId,
      draft_id: draftId,
      request_id: null,
      fact_key: 'resume.education_level',
      value_json: JSON.stringify(parsed.extracted.education_level),
      value_text: parsed.extracted.education_level,
      rank_int: null,
      source: 'resume_parsed',
      confidence_weight: 1.0,
    })
  }

  // 역할 유형
  if (parsed.extracted.current_role_type) {
    facts.push({
      user_id: userId,
      session_id: sessionId,
      draft_id: draftId,
      request_id: null,
      fact_key: 'resume.role_type',
      value_json: JSON.stringify(parsed.extracted.current_role_type),
      value_text: parsed.extracted.current_role_type,
      rank_int: null,
      source: 'resume_parsed',
      confidence_weight: 1.0,
    })
  }

  // Facts 일괄 저장
  if (facts.length > 0) {
    const placeholders = facts.map(() => '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)').join(', ')
    const values = facts.flatMap(f => [
      f.user_id,
      f.session_id,
      f.draft_id,
      f.request_id,
      f.fact_key,
      f.value_json,
      f.value_text,
      f.rank_int,
      f.source,
      f.confidence_weight,
    ])

    await db.prepare(
      `INSERT INTO analyzer_facts (user_id, session_id, draft_id, request_id, fact_key, value_json, value_text, rank_int, source, confidence_weight)
       VALUES ${placeholders}`
    ).bind(...values).run()
  }
}

export { resumeRoutes }
