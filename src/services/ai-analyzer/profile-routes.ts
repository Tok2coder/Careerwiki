// src/services/ai-analyzer/profile-routes.ts
// ============================================
// 사용자 프로필 조회/업데이트/변경감지 API
// ============================================

import { Hono } from 'hono'
import type { D1Database, Ai } from '@cloudflare/workers-types'
import { getUserIdFromContext } from '../../utils/auth'

// ============================================
// Types
// ============================================
interface Env {
  DB: D1Database
  AI: Ai
}

interface ProfileData {
  career_state: {
    role_identity?: string
    career_stage_years?: string
    transition_status?: string
    skill_level?: number
    constraints?: Record<string, boolean>
  } | null
  universal_answers: {
    interest?: string[]
    dislike?: string[]
    priority?: string
    strength?: string[]
    // 나를 알아가기 (Q8-Q15)
    workstyle_social?: string
    language?: string[] | Record<string, any>
    mm_sacrifice?: string[]
    mm_energy_drain?: string[]
    mm_achievement?: string[]
    mm_execution?: string
    mm_impact_scope?: string
    mm_failure?: string
    mm_anchor?: string
    mm_external?: string
  } | null
  transition_signal: {
    desired_types?: string[]
    motivation?: string
    timeline?: string
    blockers?: string[]
    time_invest?: string
  } | null
  narrative_facts: {
    highAliveMoment?: string
    lostMoment?: string
  } | null
  round_answers: Array<{
    round: number
    questionId: string
    answer: string
  }>
  resume_data: {
    skills: string[]
    certifications: string[]
    industries: string[]
    education_level?: string
    role_type?: string
  }
}

interface ProfileMetadata {
  last_updated_at: string | null
  last_analysis_at: string | null
  total_facts_count: number
  data_completeness: number
}

interface ProfileChange {
  category: string
  field: string
  old?: unknown
  new?: unknown
  added?: string[]
  removed?: string[]
}

// ============================================
// Helper Functions
// ============================================

/**
 * 사용자의 모든 프로필 데이터를 수집
 */
async function collectProfileData(db: D1Database, userId: number): Promise<{
  profile: ProfileData
  metadata: ProfileMetadata
  latestDraft: { id: number; session_id: string; updated_at: string } | null
  latestAnalysis: { id: number; created_at: string; career_state_json: string | null } | null
}> {
  // 1. 최신 Draft 조회
  const latestDraft = await db
    .prepare(`
      SELECT id, session_id, career_state_json, step1_answers_json, step2_answers_json, 
             step3_answers_json, step4_answers_json, updated_at
      FROM analyzer_drafts
      WHERE user_id = ?
      ORDER BY updated_at DESC
      LIMIT 1
    `)
    .bind(userId)
    .first<{
      id: number
      session_id: string
      career_state_json: string | null
      step1_answers_json: string | null
      step2_answers_json: string | null
      step3_answers_json: string | null
      step4_answers_json: string | null
      updated_at: string
    }>()

  // 2. 최신 분석 결과 조회
  const latestAnalysis = await db
    .prepare(`
      SELECT r.id, r.created_at, r.career_state_json
      FROM ai_analysis_results r
      JOIN ai_analysis_requests req ON r.request_id = req.id
      WHERE req.user_id = ?
      ORDER BY r.created_at DESC
      LIMIT 1
    `)
    .bind(userId)
    .first<{
      id: number
      created_at: string
      career_state_json: string | null
    }>()

  // 3. 모든 Facts 조회 (draft_id가 있는 것들)
  const facts = await db
    .prepare(`
      SELECT fact_key, value_json, value_text, source, created_at
      FROM analyzer_facts
      WHERE user_id = ? AND draft_id IS NOT NULL
      ORDER BY created_at DESC
    `)
    .bind(userId)
    .all<{
      fact_key: string
      value_json: string
      value_text: string | null
      source: string
      created_at: string
    }>()

  // 4. 데이터 파싱
  const careerState = latestDraft?.career_state_json 
    ? JSON.parse(latestDraft.career_state_json) 
    : null

  const step2 = latestDraft?.step2_answers_json 
    ? JSON.parse(latestDraft.step2_answers_json) 
    : null

  const step3 = latestDraft?.step3_answers_json 
    ? JSON.parse(latestDraft.step3_answers_json) 
    : null

  const step4 = latestDraft?.step4_answers_json 
    ? JSON.parse(latestDraft.step4_answers_json) 
    : null

  // 5. Facts에서 resume 데이터 추출
  const resumeSkills: string[] = []
  const resumeCerts: string[] = []
  const resumeIndustries: string[] = []
  let resumeEducation: string | undefined
  let resumeRoleType: string | undefined

  for (const fact of facts.results || []) {
    if (fact.source === 'resume_parsed') {
      if (fact.fact_key === 'resume.skill' && fact.value_text) {
        resumeSkills.push(fact.value_text)
      } else if (fact.fact_key === 'resume.certification' && fact.value_text) {
        resumeCerts.push(fact.value_text)
      } else if (fact.fact_key === 'resume.industry' && fact.value_text) {
        resumeIndustries.push(fact.value_text)
      } else if (fact.fact_key === 'resume.education_level' && fact.value_text) {
        resumeEducation = fact.value_text
      } else if (fact.fact_key === 'resume.role_type' && fact.value_text) {
        resumeRoleType = fact.value_text
      }
    }
  }

  // 6. Round answers 추출
  const roundAnswers: ProfileData['round_answers'] = []
  if (step4?.round_answers && Array.isArray(step4.round_answers)) {
    for (const ra of step4.round_answers) {
      roundAnswers.push({
        round: ra.roundNumber || ra.round || 1,
        questionId: ra.questionId || '',
        answer: ra.answer || '',
      })
    }
  }

  // 7. 데이터 완성도 계산
  let completedSections = 0
  const totalSections = 5 // career_state, universal, transition, narrative, resume

  if (careerState && Object.keys(careerState).length > 0) completedSections++
  if (step2 && Object.keys(step2).length > 0) completedSections++
  if (step3 && Object.keys(step3).length > 0) completedSections++
  if (step4?.narrative_facts || roundAnswers.length > 0) completedSections++
  if (resumeSkills.length > 0 || resumeCerts.length > 0) completedSections++

  const profile: ProfileData = {
    career_state: careerState,
    universal_answers: step2 ? {
      interest: step2.interest || step2.univ_interest || [],
      dislike: step2.dislike || step2.univ_dislike || [],
      priority: step2.priority || step2.univ_priority,
      strength: step2.strength || step2.univ_strength || [],
      // 나를 알아가기 (Q8-Q15)
      workstyle_social: step2.univ_workstyle_social,
      language: step2.univ_language,
      mm_sacrifice: step2.mm_sacrifice || [],
      mm_energy_drain: step2.mm_energy_drain || [],
      mm_achievement: step2.mm_achievement || [],
      mm_execution: step2.mm_execution,
      mm_impact_scope: step2.mm_impact_scope,
      mm_failure: step2.mm_failure,
      mm_anchor: step2.mm_anchor,
      mm_external: step2.mm_external,
    } : null,
    transition_signal: step3 ? {
      desired_types: step3.desired_types || [],
      motivation: step3.motivation,
      timeline: step3.timeline,
      blockers: step3.blockers || [],
      time_invest: step3.time_invest,
    } : null,
    narrative_facts: step4?.narrative_facts || null,
    round_answers: roundAnswers,
    resume_data: {
      skills: resumeSkills,
      certifications: resumeCerts,
      industries: resumeIndustries,
      education_level: resumeEducation,
      role_type: resumeRoleType,
    },
  }

  const metadata: ProfileMetadata = {
    last_updated_at: latestDraft?.updated_at || null,
    last_analysis_at: latestAnalysis?.created_at || null,
    total_facts_count: facts.results?.length || 0,
    data_completeness: completedSections / totalSections,
  }

  return {
    profile,
    metadata,
    latestDraft: latestDraft ? {
      id: latestDraft.id,
      session_id: latestDraft.session_id,
      updated_at: latestDraft.updated_at,
    } : null,
    latestAnalysis: latestAnalysis || null,
  }
}

/**
 * 두 배열의 차이점 계산
 */
function diffArrays(oldArr: string[] | undefined, newArr: string[] | undefined): {
  added: string[]
  removed: string[]
} {
  const oldSet = new Set(oldArr || [])
  const newSet = new Set(newArr || [])

  const added = [...newSet].filter(x => !oldSet.has(x))
  const removed = [...oldSet].filter(x => !newSet.has(x))

  return { added, removed }
}

// ============================================
// Routes
// ============================================
export const profileRoutes = new Hono<{ Bindings: Env }>()

// ============================================
// GET /api/analyzer/profile
// 사용자 프로필 통합 조회
// ============================================
profileRoutes.get('/', async (c) => {
  const userId = getUserIdFromContext(c)
  if (!userId) {
    return c.json({ error: 'UNAUTHORIZED', message: 'Login required' }, 401)
  }

  try {
    const { profile, metadata, latestDraft } = await collectProfileData(c.env.DB, userId)

    return c.json({
      success: true,
      profile,
      metadata,
      session_id: latestDraft?.session_id || null,
    })
  } catch (error) {
    console.error('Profile fetch error:', error)
    return c.json({
      error: 'INTERNAL_SERVER_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// GET /api/analyzer/profile/diff
// 마지막 분석 이후 변경사항 감지
// ============================================
profileRoutes.get('/diff', async (c) => {
  const userId = getUserIdFromContext(c)
  if (!userId) {
    return c.json({ error: 'UNAUTHORIZED', message: 'Login required' }, 401)
  }

  try {
    const { profile, latestAnalysis } = await collectProfileData(c.env.DB, userId)

    // 마지막 분석이 없으면 변경사항 감지 불가
    if (!latestAnalysis) {
      return c.json({
        success: true,
        has_changes: false,
        changes: [],
        last_analysis_at: null,
        recommendation: '아직 분석을 진행한 적이 없습니다. 새 분석을 시작해주세요.',
      })
    }

    // 분석 시점의 career_state 조회
    const analysisCareerState = latestAnalysis.career_state_json
      ? JSON.parse(latestAnalysis.career_state_json)
      : null

    const changes: ProfileChange[] = []

    // Career State 비교
    if (profile.career_state && analysisCareerState) {
      const currentCS = profile.career_state
      const oldCS = analysisCareerState

      if (currentCS.role_identity !== oldCS.role_identity) {
        changes.push({
          category: 'career_state',
          field: 'role_identity',
          old: oldCS.role_identity,
          new: currentCS.role_identity,
        })
      }
      if (currentCS.career_stage_years !== oldCS.career_stage_years) {
        changes.push({
          category: 'career_state',
          field: 'career_stage_years',
          old: oldCS.career_stage_years,
          new: currentCS.career_stage_years,
        })
      }
      if (currentCS.skill_level !== oldCS.skill_level) {
        changes.push({
          category: 'career_state',
          field: 'skill_level',
          old: oldCS.skill_level,
          new: currentCS.skill_level,
        })
      }
      if (currentCS.transition_status !== oldCS.transition_status) {
        changes.push({
          category: 'career_state',
          field: 'transition_status',
          old: oldCS.transition_status,
          new: currentCS.transition_status,
        })
      }
    } else if (profile.career_state && !analysisCareerState) {
      changes.push({
        category: 'career_state',
        field: 'all',
        old: null,
        new: profile.career_state,
      })
    }

    // Universal Answers 비교 (마지막 분석 이후 업데이트 여부 확인)
    // 분석 결과에는 universal_answers가 직접 저장되지 않으므로
    // Draft의 updated_at이 분석 시점 이후인지 확인
    const analysisTime = new Date(latestAnalysis.created_at).getTime()

    // Facts에서 분석 이후에 추가된 resume 데이터 확인
    const newResumeFacts = await c.env.DB
      .prepare(`
        SELECT fact_key, value_text
        FROM analyzer_facts
        WHERE user_id = ? AND source = 'resume_parsed'
          AND created_at > ?
      `)
      .bind(userId, latestAnalysis.created_at)
      .all<{ fact_key: string; value_text: string | null }>()

    if (newResumeFacts.results && newResumeFacts.results.length > 0) {
      const addedSkills = newResumeFacts.results
        .filter(f => f.fact_key === 'resume.skill' && f.value_text)
        .map(f => f.value_text!)
      const addedCerts = newResumeFacts.results
        .filter(f => f.fact_key === 'resume.certification' && f.value_text)
        .map(f => f.value_text!)

      if (addedSkills.length > 0) {
        changes.push({
          category: 'resume_data',
          field: 'skills',
          added: addedSkills,
          removed: [],
        })
      }
      if (addedCerts.length > 0) {
        changes.push({
          category: 'resume_data',
          field: 'certifications',
          added: addedCerts,
          removed: [],
        })
      }
    }

    // 변경사항 기반 권장 메시지 생성
    let recommendation = ''
    if (changes.length === 0) {
      recommendation = '프로필 데이터에 변경사항이 없습니다.'
    } else if (changes.some(c => c.category === 'career_state')) {
      recommendation = '커리어 상태가 변경되어 새 분석을 권장합니다.'
    } else if (changes.some(c => c.category === 'resume_data')) {
      recommendation = '이력서 정보가 업데이트되어 새 분석을 권장합니다.'
    } else {
      recommendation = `${changes.length}개 항목이 변경되어 새 분석을 권장합니다.`
    }

    return c.json({
      success: true,
      has_changes: changes.length > 0,
      changes,
      last_analysis_at: latestAnalysis.created_at,
      recommendation,
    })
  } catch (error) {
    console.error('Profile diff error:', error)
    return c.json({
      error: 'INTERNAL_SERVER_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// PATCH /api/analyzer/profile
// 프로필 부분 업데이트
// ============================================
profileRoutes.patch('/', async (c) => {
  const userId = getUserIdFromContext(c)
  if (!userId) {
    return c.json({ error: 'UNAUTHORIZED', message: 'Login required' }, 401)
  }

  try {
    const body = await c.req.json<{
      updates: {
        career_state?: Partial<ProfileData['career_state']>
        universal_answers?: Partial<NonNullable<ProfileData['universal_answers']>>
        transition_signal?: Partial<NonNullable<ProfileData['transition_signal']>>
      }
    }>()

    const { updates } = body

    if (!updates || Object.keys(updates).length === 0) {
      return c.json({ error: 'BAD_REQUEST', message: 'No updates provided' }, 400)
    }

    // 기존 Draft 조회
    const existingDraft = await c.env.DB
      .prepare(`
        SELECT id, session_id, career_state_json, step2_answers_json, step3_answers_json
        FROM analyzer_drafts
        WHERE user_id = ?
        ORDER BY updated_at DESC
        LIMIT 1
      `)
      .bind(userId)
      .first<{
        id: number
        session_id: string
        career_state_json: string | null
        step2_answers_json: string | null
        step3_answers_json: string | null
      }>()

    if (!existingDraft) {
      return c.json({
        error: 'NOT_FOUND',
        message: 'No existing profile found. Please complete the initial analysis first.',
      }, 404)
    }

    const updatedFields: string[] = []

    // Career State 업데이트
    if (updates.career_state) {
      const currentCS = existingDraft.career_state_json
        ? JSON.parse(existingDraft.career_state_json)
        : {}
      const newCS = { ...currentCS, ...updates.career_state }

      await c.env.DB
        .prepare(`UPDATE analyzer_drafts SET career_state_json = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?`)
        .bind(JSON.stringify(newCS), existingDraft.id)
        .run()

      for (const key of Object.keys(updates.career_state)) {
        updatedFields.push(`career_state.${key}`)
      }
    }

    // Universal Answers (step2) 업데이트
    if (updates.universal_answers) {
      const currentStep2 = existingDraft.step2_answers_json
        ? JSON.parse(existingDraft.step2_answers_json)
        : {}
      const newStep2 = { ...currentStep2, ...updates.universal_answers }

      await c.env.DB
        .prepare(`UPDATE analyzer_drafts SET step2_answers_json = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?`)
        .bind(JSON.stringify(newStep2), existingDraft.id)
        .run()

      for (const key of Object.keys(updates.universal_answers)) {
        updatedFields.push(`universal_answers.${key}`)
      }
    }

    // Transition Signal (step3) 업데이트
    if (updates.transition_signal) {
      const currentStep3 = existingDraft.step3_answers_json
        ? JSON.parse(existingDraft.step3_answers_json)
        : {}
      const newStep3 = { ...currentStep3, ...updates.transition_signal }

      await c.env.DB
        .prepare(`UPDATE analyzer_drafts SET step3_answers_json = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?`)
        .bind(JSON.stringify(newStep3), existingDraft.id)
        .run()

      for (const key of Object.keys(updates.transition_signal)) {
        updatedFields.push(`transition_signal.${key}`)
      }
    }

    return c.json({
      success: true,
      updated_fields: updatedFields,
      updated_at: new Date().toISOString(),
    })
  } catch (error) {
    console.error('Profile update error:', error)
    return c.json({
      error: 'INTERNAL_SERVER_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// POST /api/analyzer/profile/quick-reanalyze
// 기존 데이터 재사용 빠른 재분석
// ============================================
profileRoutes.post('/quick-reanalyze', async (c) => {
  const userId = getUserIdFromContext(c)
  if (!userId) {
    return c.json({ error: 'UNAUTHORIZED', message: 'Login required' }, 401)
  }

  try {
    const body = await c.req.json<{
      use_existing_data?: boolean
      skip_unchanged_steps?: boolean
    }>()

    const { use_existing_data = true, skip_unchanged_steps = true } = body

    // 기존 프로필 데이터 수집
    const { profile, metadata, latestDraft, latestAnalysis } = await collectProfileData(c.env.DB, userId)

    if (!latestDraft) {
      return c.json({
        error: 'NOT_FOUND',
        message: 'No existing profile data found. Please complete the initial analysis first.',
      }, 404)
    }

    // 재사용할 데이터 목록
    const reusedData: string[] = []
    const updatedData: string[] = []

    if (use_existing_data) {
      if (profile.career_state) reusedData.push('career_state')
      if (profile.universal_answers) reusedData.push('universal_answers')
      if (profile.transition_signal) reusedData.push('transition_signal')
      if (profile.narrative_facts) reusedData.push('narrative_facts')
      if (profile.round_answers.length > 0) reusedData.push('round_answers')
      if (profile.resume_data.skills.length > 0 || profile.resume_data.certifications.length > 0) {
        reusedData.push('resume_data')
      }
    }

    // 분석 이후 변경된 데이터 확인
    if (latestAnalysis && skip_unchanged_steps) {
      const analysisTime = new Date(latestAnalysis.created_at)
      const draftTime = new Date(latestDraft.updated_at)

      if (draftTime > analysisTime) {
        // Draft가 분석 이후에 업데이트되었음
        updatedData.push('draft_updated')
      }

      // Resume facts 확인
      const newResumeFacts = await c.env.DB
        .prepare(`
          SELECT COUNT(*) as count
          FROM analyzer_facts
          WHERE user_id = ? AND source = 'resume_parsed'
            AND created_at > ?
        `)
        .bind(userId, latestAnalysis.created_at)
        .first<{ count: number }>()

      if (newResumeFacts && newResumeFacts.count > 0) {
        updatedData.push('resume_data')
      }
    }

    // 새 분석 요청 생성
    const sessionId = latestDraft.session_id
    
    const result = await c.env.DB
      .prepare(`
        INSERT INTO ai_analysis_requests (
          user_id, session_id, analysis_type, status, 
          payload_json, created_at
        ) VALUES (?, ?, 'job', 'pending', ?, CURRENT_TIMESTAMP)
        RETURNING id
      `)
      .bind(
        userId,
        sessionId,
        JSON.stringify({
          quick_reanalyze: true,
          reused_data: reusedData,
          updated_data: updatedData,
          original_draft_id: latestDraft.id,
        })
      )
      .first<{ id: number }>()

    if (!result) {
      return c.json({
        error: 'INTERNAL_SERVER_ERROR',
        message: 'Failed to create analysis request',
      }, 500)
    }

    // 분석 페이지 URL 생성 (기존 프로필 데이터를 포함하여 분석 진행)
    // 클라이언트는 이 URL로 이동하여 분석을 완료할 수 있음
    const analyzerUrl = '/analyzer/job?session=' + encodeURIComponent(sessionId) + '&quick=true&request_id=' + result.id

    return c.json({
      success: true,
      request_id: result.id,
      session_id: sessionId,
      reused_data: reusedData,
      updated_data: updatedData,
      status: 'pending',
      analyzer_url: analyzerUrl,
      message: '빠른 재분석 요청이 생성되었습니다. 기존 데이터를 재사용하여 분석을 진행합니다.',
    })
  } catch (error) {
    console.error('Quick reanalyze error:', error)
    return c.json({
      error: 'INTERNAL_SERVER_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// GET /api/analyzer/profile/summary
// 프로필 요약 정보 (카드용)
// ============================================
profileRoutes.get('/summary', async (c) => {
  const userId = getUserIdFromContext(c)
  if (!userId) {
    return c.json({ error: 'UNAUTHORIZED', message: 'Login required' }, 401)
  }

  try {
    const { profile, metadata } = await collectProfileData(c.env.DB, userId)

    // 간단한 요약 생성
    const summary = {
      has_profile: metadata.data_completeness > 0,
      completeness_percent: Math.round(metadata.data_completeness * 100),
      last_updated: metadata.last_updated_at,
      last_analysis: metadata.last_analysis_at,
      highlights: {
        role: profile.career_state?.role_identity || '미설정',
        experience: profile.career_state?.career_stage_years || '미설정',
        skills_count: profile.resume_data.skills.length,
        certifications_count: profile.resume_data.certifications.length,
        interests: profile.universal_answers?.interest?.slice(0, 3) || [],
      },
    }

    return c.json({
      success: true,
      summary,
    })
  } catch (error) {
    console.error('Profile summary error:', error)
    return c.json({
      error: 'INTERNAL_SERVER_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})
