// src/services/ai-analyzer/draft-routes.ts
// ============================================
// AI Analyzer Draft API (임시저장/불러오기)
// ============================================

import { Hono } from 'hono'
import { getCookie } from 'hono/cookie'
import { verify } from 'hono/jwt'
import type { D1Database, Ai } from '@cloudflare/workers-types'
import {
  saveFactsToDb,
  replaceFactsForStep,
  careerStateToFacts,
  createRankedFacts,
  createMultiFacts,
  createScalarFact,
  type AnalyzerFact,
  type FactSaveParams,
} from './fact-saver'
import type { CareerState, TransitionSignal } from './career-tree-types'
import { 
  buildAggregatedProfile, 
  type DraftData as AggDraftData,
  type AggregatedProfile,
} from './aggregated-profile'
import { updateMemory } from './llm-memory'

// ============================================
// Types
// ============================================
interface DraftData {
  id: number
  user_id: number
  session_id: string
  analysis_type: 'job' | 'major'
  current_step: number
  career_state_json: string | null
  step1_answers_json: string | null
  step2_answers_json: string | null
  step3_answers_json: string | null
  step4_answers_json: string | null
  mini_module_result_json?: string | null
  aggregated_profile_json?: string | null
  memory_json?: string | null
  profile_version?: number
  created_at: string
  updated_at: string
}

interface DraftSaveRequest {
  session_id: string
  analysis_type: 'job' | 'major'
  current_step: number
  profile_sub_step?: number  // 프로필 서브스텝 (1: 5축, 2: 나를 알아가기)
  current_round?: number     // 심층 질문 라운드 (1-3)
  career_state?: CareerState
  step1_answers?: Record<string, unknown>
  step2_answers?: Record<string, unknown>
  step3_answers?: Record<string, unknown>
  step4_answers?: Record<string, unknown>
  // V3 추가 필드
  engine_version?: 'v2' | 'v3'
  narrative_facts?: { highAliveMoment: string; lostMoment: string; life_story?: string; storyAnswer?: string }
  round_answers?: Array<{ questionId: string; roundNumber: number; answer: string }>
  // 미니모듈 결과
  mini_module_result?: {
    interest_top: string[]
    value_top: string[]
    strength_top: string[]
    constraint_flags: string[]
    low_confidence_flags?: string[]
    internal_conflict_flags?: string[]
  }
}

interface Env {
  DB: D1Database
  JWT_SECRET: string
  AI?: Ai
  OPENAI_API_KEY?: string
}

// Helper: JWT에서 사용자 조회 (에러 정보 포함)
interface AuthResult {
  user: { id: number; username: string; role: string } | null
  error?: string
}

async function getUserFromCookie(c: any): Promise<AuthResult> {
  const accessToken = getCookie(c, 'access_token')
  
  if (!accessToken) {
    return { user: null, error: 'no_access_token' }
  }
  
  try {
    const payload = await verify(accessToken, c.env.JWT_SECRET, 'HS256') as any
    
    // JWT payload에서 userId 또는 id 사용 (auth.ts에서 userId로 생성)
    const userId = payload?.userId || payload?.id
    if (!userId) {
      return { user: null, error: 'no_id_in_payload' }
    }
    
    const user = await c.env.DB.prepare(
      'SELECT id, username, role FROM users WHERE id = ?'
    ).bind(userId).first()
    
    if (!user) {
      return { user: null, error: 'user_not_found_in_db' }
    }
    
    return { user }
  } catch (e: any) {
    return { user: null, error: 'jwt_verify_failed: ' + (e?.message || String(e)) }
  }
}

// ============================================
// Routes
// ============================================
export const draftRoutes = new Hono<{ Bindings: Env }>()

// POST /api/analyzer/draft/save - 임시저장
draftRoutes.post('/save', async (c) => {
  const db = c.env.DB

  // 디버그: 쿠키 및 환경 변수 확인
  const accessToken = getCookie(c, 'access_token')
  const hasJwtSecret = !!c.env.JWT_SECRET
  
  // 로그인 체크 (쿠키에서 직접 JWT 검증)
  const authResult = await getUserFromCookie(c)
  if (!authResult.user?.id) {
    return c.json({ 
      error: 'Login required', 
      code: 'AUTH_REQUIRED',
      debug: {
        hasAccessToken: !!accessToken,
        hasJwtSecret: hasJwtSecret,
        tokenLength: accessToken ? accessToken.length : 0,
        authError: authResult.error
      }
    }, 401)
  }
  const userId = authResult.user.id

  try {
    const body = await c.req.json<DraftSaveRequest>()
    const { session_id, analysis_type, current_step, profile_sub_step, current_round, career_state, step1_answers, step2_answers, step3_answers, step4_answers, mini_module_result } = body

    if (!session_id || !analysis_type) {
      return c.json({ error: 'session_id and analysis_type required' }, 400)
    }
    
    // step1_answers에 profile_sub_step과 current_round 포함
    const enrichedStep1Answers = {
      ...step1_answers,
      profileSubStep: profile_sub_step ?? step1_answers?.profileSubStep ?? 1,
      currentRound: current_round ?? step4_answers?.current_round ?? 0
    }

    // 기존 draft 확인 (profile_version 포함)
    const existingDraft = await db
      .prepare('SELECT id, profile_version FROM analyzer_drafts WHERE user_id = ? AND session_id = ?')
      .bind(userId, session_id)
      .first<{ id: number; profile_version?: number }>()

    let draftId: number
    let newProfileVersion: number = (existingDraft?.profile_version || 0) + 1

    if (existingDraft) {
      // 업데이트 (P0-7: updated_at 명시적 갱신 + profile_version 증가)
      await db
        .prepare(`
          UPDATE analyzer_drafts SET
            current_step = ?,
            career_state_json = ?,
            step1_answers_json = ?,
            step2_answers_json = ?,
            step3_answers_json = ?,
            step4_answers_json = ?,
            mini_module_result_json = ?,
            profile_version = ?,
            updated_at = CURRENT_TIMESTAMP
          WHERE id = ?
        `)
        .bind(
          current_step,
          career_state ? JSON.stringify(career_state) : null,
          JSON.stringify(enrichedStep1Answers),  // profile_sub_step, current_round 포함
          step2_answers ? JSON.stringify(step2_answers) : null,
          step3_answers ? JSON.stringify(step3_answers) : null,
          step4_answers ? JSON.stringify(step4_answers) : null,
          mini_module_result ? JSON.stringify(mini_module_result) : null,
          newProfileVersion,
          existingDraft.id
        )
        .run()

      draftId = existingDraft.id
    } else {
      // 신규 생성
      newProfileVersion = 1
      const result = await db
        .prepare(`
          INSERT INTO analyzer_drafts (
            user_id, session_id, analysis_type, current_step,
            career_state_json, step1_answers_json, step2_answers_json,
            step3_answers_json, step4_answers_json, mini_module_result_json,
            profile_version
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `)
        .bind(
          userId,
          session_id,
          analysis_type,
          current_step,
          career_state ? JSON.stringify(career_state) : null,
          JSON.stringify(enrichedStep1Answers),  // profile_sub_step, current_round 포함
          step2_answers ? JSON.stringify(step2_answers) : null,
          step3_answers ? JSON.stringify(step3_answers) : null,
          step4_answers ? JSON.stringify(step4_answers) : null,
          mini_module_result ? JSON.stringify(mini_module_result) : null,
          newProfileVersion
        )
        .run()

      draftId = result.meta?.last_row_id || 0
    }
    
    // ============================================
    // AggregatedProfile 자동 생성/저장 (Derived Cache)
    // ============================================
    try {
      // 전체 draft 다시 조회 (방금 저장한 것 포함)
      const fullDraft = await db
        .prepare('SELECT * FROM analyzer_drafts WHERE id = ?')
        .bind(draftId)
        .first<DraftData>()
      
      if (fullDraft) {
        // AggregatedProfile 빌드
        const aggregatedProfile = buildAggregatedProfile(fullDraft as unknown as AggDraftData)
        
        // ============================================
        // Step2 서술형(narrative_facts) 저장 시 Memory 업데이트
        // ============================================
        let updatedMemoryJson: string | null = fullDraft.memory_json || null
        
        // narrative_facts가 있거나 step2_answers에 narrative_facts가 있으면 Memory 업데이트
        const narrativeFacts = body.narrative_facts || 
          (step2_answers?.narrative_facts as { highAliveMoment?: string; lostMoment?: string; life_story?: string; storyAnswer?: string } | undefined)
        
        if (narrativeFacts && (narrativeFacts.highAliveMoment || narrativeFacts.lostMoment || narrativeFacts.life_story || narrativeFacts.storyAnswer)) {
          try {
            console.log('[Draft Save] Updating memory from narrative_facts...')
            const updatedMemory = await updateMemory(
              c.env.AI || null,
              aggregatedProfile,
              { type: 'narrative_facts', data: narrativeFacts },
              c.env.OPENAI_API_KEY
            )
            aggregatedProfile.memory = updatedMemory
            updatedMemoryJson = JSON.stringify(updatedMemory)
            console.log('[Draft Save] Memory updated from narrative_facts')
          } catch (memoryError) {
            console.error('[Draft Save] Memory update failed:', memoryError)
          }
        }
        
        // 캐시 저장 (동일 profile_version 포함 + memory_json)
        await db
          .prepare(`
            UPDATE analyzer_drafts SET
              aggregated_profile_json = ?,
              memory_json = ?
            WHERE id = ?
          `)
          .bind(JSON.stringify(aggregatedProfile), updatedMemoryJson, draftId)
          .run()
        
        console.log(`[Draft Save] AggregatedProfile generated v${newProfileVersion}`)
      }
    } catch (profileError) {
      // 프로필 생성 실패해도 draft 저장은 성공 처리
      console.error('[Draft Save] AggregatedProfile generation failed:', profileError)
    }

    // Facts 즉시 적재 (P0: Step별 delete+insert)
    const factParams: FactSaveParams = {
      session_id,
      user_id: userId,
      draft_id: draftId,
    }

    // Step 1: Career State → Facts (비어있지 않은 경우만)
    if (career_state && Object.keys(career_state).length > 0 && career_state.role_identity) {
      const stateFacts = careerStateToFacts(career_state, factParams)
      await replaceFactsForStep(db, { session_id, draft_id: draftId, fact_key_prefix: 'state.' }, stateFacts)
    }

    // Step 3: Transition Signal → Facts
    if (step3_answers) {
      const transitionFacts: AnalyzerFact[] = []

      // desired_type (ranked)
      if (Array.isArray(step3_answers.desired_types)) {
        transitionFacts.push(
          ...createRankedFacts({
            ...factParams,
            fact_key: 'transition.desired_type',
            values: step3_answers.desired_types as string[],
          })
        )
      }

      // motivation_primary (scalar)
      if (step3_answers.motivation) {
        transitionFacts.push(
          createScalarFact({
            ...factParams,
            fact_key: 'transition.motivation_primary',
            value: step3_answers.motivation as string,
          })
        )
      }

      // blockers (multi, no rank)
      if (Array.isArray(step3_answers.blockers)) {
        transitionFacts.push(
          ...createMultiFacts({
            ...factParams,
            fact_key: 'transition.blocker',
            values: step3_answers.blockers as string[],
          })
        )
      }

      // timeline (scalar)
      if (step3_answers.timeline) {
        transitionFacts.push(
          createScalarFact({
            ...factParams,
            fact_key: 'transition.timeline',
            value: step3_answers.timeline as string,
          })
        )
      }

      // time_invest (scalar)
      if (step3_answers.time_invest) {
        transitionFacts.push(
          createScalarFact({
            ...factParams,
            fact_key: 'transition.time_invest_hours_bucket',
            value: step3_answers.time_invest as string,
          })
        )
      }

      await replaceFactsForStep(db, { session_id, draft_id: draftId, fact_key_prefix: 'transition.' }, transitionFacts)
    }

    return c.json({
      success: true,
      draft_id: draftId,
      profile_version: newProfileVersion,
      saved_at: new Date().toISOString(),
    })
  } catch (error) {
    console.error('Draft save error:', error)
    return c.json({ error: 'Failed to save draft', details: String(error) }, 500)
  }
})

// GET /api/analyzer/draft/load - 임시저장 불러오기
draftRoutes.get('/load', async (c) => {
  const db = c.env.DB

  // ⚠️ 캐시 방지 헤더 (브라우저가 절대 캐시하지 않도록!)
  c.header('Cache-Control', 'no-cache, no-store, must-revalidate')
  c.header('Pragma', 'no-cache')
  c.header('Expires', '0')

  // 로그인 체크 (쿠키에서 직접 JWT 검증)
  const authResult = await getUserFromCookie(c)
  if (!authResult.user?.id) {
    return c.json({ error: 'Login required', code: 'AUTH_REQUIRED' }, 401)
  }
  const userId = authResult.user.id

  try {
    const session_id = c.req.query('session_id')

    let draft: DraftData | null

    if (session_id) {
      // 특정 session_id로 조회
      draft = await db
        .prepare('SELECT * FROM analyzer_drafts WHERE user_id = ? AND session_id = ?')
        .bind(userId, session_id)
        .first<DraftData>()
    } else {
      // 가장 최근 draft 조회
      draft = await db
        .prepare('SELECT * FROM analyzer_drafts WHERE user_id = ? ORDER BY updated_at DESC LIMIT 1')
        .bind(userId)
        .first<DraftData>()
    }

    if (!draft) {
      return c.json({ found: false, draft: null })
    }

    // JSON 파싱
    const parsedDraft = {
      id: draft.id,
      session_id: draft.session_id,
      analysis_type: draft.analysis_type,
      current_step: draft.current_step,
      career_state: draft.career_state_json ? JSON.parse(draft.career_state_json) : null,
      step1_answers: draft.step1_answers_json ? JSON.parse(draft.step1_answers_json) : null,
      step2_answers: draft.step2_answers_json ? JSON.parse(draft.step2_answers_json) : null,
      step3_answers: draft.step3_answers_json ? JSON.parse(draft.step3_answers_json) : null,
      step4_answers: draft.step4_answers_json ? JSON.parse(draft.step4_answers_json) : null,
      mini_module_result: draft.mini_module_result_json ? JSON.parse(draft.mini_module_result_json) : null,
      aggregated_profile: draft.aggregated_profile_json ? JSON.parse(draft.aggregated_profile_json) : null,
      memory: draft.memory_json ? JSON.parse(draft.memory_json) : null,
      profile_version: draft.profile_version || 0,
      created_at: draft.created_at,
      updated_at: draft.updated_at,
    }

    return c.json({
      found: true,
      draft: parsedDraft,
    })
  } catch (error) {
    console.error('Draft load error:', error)
    return c.json({ error: 'Failed to load draft', details: String(error) }, 500)
  }
})

// DELETE /api/analyzer/draft/delete - 임시저장 삭제
draftRoutes.delete('/delete', async (c) => {
  const db = c.env.DB

  // 로그인 체크 (쿠키에서 직접 JWT 검증)
  const authResult = await getUserFromCookie(c)
  if (!authResult.user?.id) {
    return c.json({ error: 'Login required', code: 'AUTH_REQUIRED' }, 401)
  }
  const userId = authResult.user.id

  try {
    const session_id = c.req.query('session_id')

    if (!session_id) {
      return c.json({ error: 'session_id required' }, 400)
    }

    // Draft 삭제
    await db
      .prepare('DELETE FROM analyzer_drafts WHERE user_id = ? AND session_id = ?')
      .bind(userId, session_id)
      .run()

    // 관련 Facts 삭제
    await db
      .prepare('DELETE FROM analyzer_facts WHERE user_id = ? AND session_id = ? AND request_id IS NULL')
      .bind(userId, session_id)
      .run()

    return c.json({ success: true, deleted_at: new Date().toISOString() })
  } catch (error) {
    console.error('Draft delete error:', error)
    return c.json({ error: 'Failed to delete draft', details: String(error) }, 500)
  }
})

// DELETE /api/analyzer/draft/delete-all - 모든 임시저장 삭제
draftRoutes.delete('/delete-all', async (c) => {
  const db = c.env.DB

  // 로그인 체크
  const authResult = await getUserFromCookie(c)
  if (!authResult.user?.id) {
    return c.json({ error: 'Login required', code: 'AUTH_REQUIRED' }, 401)
  }
  const userId = authResult.user.id

  try {
    // 모든 Draft 삭제
    const deleteResult = await db
      .prepare('DELETE FROM analyzer_drafts WHERE user_id = ?')
      .bind(userId)
      .run()

    // 관련 Facts 삭제 (request_id가 NULL인 것만 - draft에 연결된 것)
    await db
      .prepare('DELETE FROM analyzer_facts WHERE user_id = ? AND request_id IS NULL')
      .bind(userId)
      .run()

    return c.json({ 
      success: true, 
      deleted_count: deleteResult.meta?.changes || 0,
      deleted_at: new Date().toISOString() 
    })
  } catch (error) {
    console.error('Draft delete-all error:', error)
    return c.json({ error: 'Failed to delete all drafts', details: String(error) }, 500)
  }
})

// GET /api/analyzer/draft/list - 사용자 drafts 목록
draftRoutes.get('/list', async (c) => {
  const db = c.env.DB

  // 로그인 체크
  const user = (c as any).get?.('user')
  if (!user?.id) {
    return c.json({ error: 'Login required', code: 'AUTH_REQUIRED' }, 401)
  }
  const userId = user.id

  try {
    const drafts = await db
      .prepare(`
        SELECT id, session_id, analysis_type, current_step, created_at, updated_at
        FROM analyzer_drafts
        WHERE user_id = ?
        ORDER BY updated_at DESC
        LIMIT 10
      `)
      .bind(userId)
      .all<Pick<DraftData, 'id' | 'session_id' | 'analysis_type' | 'current_step' | 'created_at' | 'updated_at'>>()

    return c.json({
      drafts: drafts.results || [],
      count: drafts.results?.length || 0,
    })
  } catch (error) {
    console.error('Draft list error:', error)
    return c.json({ error: 'Failed to list drafts', details: String(error) }, 500)
  }
})
