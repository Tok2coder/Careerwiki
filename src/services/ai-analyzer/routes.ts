// CareerWiki AI Analyzer API Routes
// Version: v2.0.0-stage-based (Universal Intake + Stage-based Follow-up)
// Framework: Hono (Cloudflare Workers)

import { Hono } from 'hono'
import type { D1Database, VectorizeIndex, Ai } from '@cloudflare/workers-types'
import {
  VERSIONS,
  assertConstraintType,
  isValidStage,
  isMinorStage,
  isExperienceAllowed,
  type AnalysisRequestPayload,
  type AnalysisResultJSON,
  type AnalysisRequestPayloadV3,
  type UniversalAnswers,
  type AnalysisStage,
  type FollowupResponsePayload,
  type FollowupResult,
  type DeepIntakeInput,
  type UserInsight,
  type DebugInfo,
} from './types'
import {
  calculateFactBoosts,
  applyFactBoostsToJob,
  normalizeDeepIntake,
  type JobScores,
  type NormalizedDeepIntake,
} from './fact-score-mapping'
import {
  generateFollowupQuestions,
  type ScoredJob,
  type FollowupQuestion,
} from './question-generation'
import { taggerRoutes } from './tagger-routes'
import {
  UNIVERSAL_QUESTIONS,
  getUniversalQuestionsForStage,
  INSIGHT_WORDING,
  type UniversalQuestion,
} from './universal-questions'
import {
  getQuestionsForStage,
  getQuestionText,
  type StageQuestion,
} from './stage-question-banks'
import {
  handleFollowupNo,
  applyDiversityGuard,
  type FollowupNoResult,
  type RankChangeInfo,
} from './safe-replacement'
import {
  buildEvidenceLinks,
  generateDefaultEvidence,
  type Fact as EvidenceFact,
  type ScoredJobForEvidence,
} from './evidence-generator'
import {
  generatePremiumReport,
  type PremiumReportInput,
} from './premium-report-generator'
import {
  generatePurposeBasedFollowups,
  type PurposeBasedFollowupInput,
} from './question-generation'
import {
  saveConversationTurn,
  saveProfileSnapshot,
  buildProfileFromTurns,
  getNextTurnNumber,
  getLatestProfileSnapshot,
  extractSignalsFromAnswer,
  type TurnType,
  type ProfileSnapshot,
} from './user-profile'
import {
  expandCandidates,
  vectorResultsToScoredJobs,
  buildSearchQuery,
} from './vectorize-pipeline'

// ============================================
// Error Handling (V3 표준화)
// ============================================
type ErrorCode = 
  | 'VALIDATION_ERROR'     // 400: 입력 검증 실패
  | 'INVALID_STAGE'        // 400: 잘못된 Stage
  | 'INVALID_PAYLOAD'      // 400: 잘못된 페이로드 형식
  | 'SESSION_NOT_FOUND'    // 404: 세션 없음
  | 'REQUEST_NOT_FOUND'    // 404: 분석 요청 없음
  | 'RESULT_NOT_FOUND'     // 404: 분석 결과 없음
  | 'DB_ERROR'             // 500: 데이터베이스 오류
  | 'ANALYSIS_FAILED'      // 500: 분석 처리 실패
  | 'INTERNAL_ERROR'       // 500: 내부 오류

interface ApiError {
  error: string
  code: ErrorCode
  details?: Record<string, unknown>
  request_id?: number
  timestamp: string
}

function createErrorResponse(
  code: ErrorCode,
  message: string,
  details?: Record<string, unknown>,
  requestId?: number
): ApiError {
  return {
    error: message,
    code,
    details,
    request_id: requestId,
    timestamp: new Date().toISOString(),
  }
}

// Error logging (development only - no file logging)
function logError(
  code: ErrorCode, 
  message: string, 
  context?: Record<string, unknown>
): void {
  console.error(`[AI-ANALYZER ERROR] ${code}: ${message}`, context ? JSON.stringify(context) : '')
}

// ============================================
// Phase 4 Metrics Events Helper
// ============================================
async function savePhase4MetricsEvents(
  db: D1Database,
  sessionId: string,
  userId: string | undefined,
  requestId: number,
  result: AnalysisResultJSON
): Promise<void> {
  try {
    // Phase 4 적용 여부 확인
    if (!result.phase4_applied) return
    
    // 1. Diversity Guard 적용 이벤트
    if (result.diversity_guard_active) {
      await db.prepare(`
        INSERT INTO raw_events (user_id, session_id, event_type, payload_json)
        VALUES (?, ?, 'DIVERSITY_GUARD_APPLIED', ?)
      `).bind(
        userId || null,
        sessionId,
        JSON.stringify({
          request_id: requestId,
          changes: result.diversity_changes || [],
          top3_jobs: result.fit_top3?.map(j => j.job_name) || [],
        })
      ).run()
    }
    
    // 2. Research Bias Cap 적용 여부 확인 (diversity_changes에서 추론)
    const researchBiasApplied = (result.diversity_changes || []).some(
      change => change.includes('연구') || change.includes('research') || change.includes('Diversity Guard')
    )
    if (researchBiasApplied) {
      await db.prepare(`
        INSERT INTO raw_events (user_id, session_id, event_type, payload_json)
        VALUES (?, ?, 'RESEARCH_BIAS_CAP_APPLIED', ?)
      `).bind(
        userId || null,
        sessionId,
        JSON.stringify({
          request_id: requestId,
          original_changes: result.diversity_changes || [],
        })
      ).run()
    }
    
  } catch (error) {
    // 메트릭스 저장 실패는 분석 결과에 영향 없음
    console.error('Phase4 metrics event save failed:', error)
  }
}

// ============================================
// Bindings (Cloudflare Workers)
// ============================================
interface Bindings {
  DB: D1Database
  VECTORIZE?: VectorizeIndex
  AI?: Ai
  GEMINI_API_KEY?: string
  [key: string]: unknown
}

// ============================================
// AI Analyzer Routes
// ============================================
const analyzerRoutes = new Hono<{ Bindings: Bindings }>()

// ============================================
// POST /analyze - 분석 요청 (V3: Stage-based + V2 호환)
// ============================================
interface AnalysisRequestPayloadV2 extends AnalysisRequestPayload {
  deep_intake?: DeepIntakeInput
}

// V3 또는 V2 페이로드 둘 다 처리
type AnalyzePayload = AnalysisRequestPayloadV3 | AnalysisRequestPayloadV2

analyzerRoutes.post('/analyze', async (c) => {
  const db = c.env.DB
  const rawPayload = await c.req.json<AnalyzePayload>()
  
  try {
    // V3 vs V2 판별
    const isV3 = 'stage' in rawPayload && 'universal_answers' in rawPayload
    
    // 1. 입력 검증
    if (!rawPayload.session_id) {
      logError('VALIDATION_ERROR', 'session_id is required')
      return c.json(createErrorResponse('VALIDATION_ERROR', 'session_id is required'), 400)
    }
    
    // V3 추가 검증
    let stage: AnalysisStage | undefined
    let universalAnswers: UniversalAnswers = {}
    let debugMode = false
    
    if (isV3) {
      const v3Payload = rawPayload as AnalysisRequestPayloadV3
      debugMode = v3Payload.debug || false
      
      if (!isValidStage(v3Payload.stage)) {
        logError('INVALID_STAGE', `Invalid stage: ${v3Payload.stage}`, { provided: v3Payload.stage })
        return c.json(createErrorResponse('INVALID_STAGE', `Invalid stage: ${v3Payload.stage}`, {
          provided: v3Payload.stage,
          allowed: ['job_explore', 'job_student', 'job_early', 'major_explore', 'major_student', 'major_early']
        }), 400)
      }
      stage = v3Payload.stage
      universalAnswers = v3Payload.universal_answers || {}
      
      // 2a. Stage 선택 이벤트 저장 [수정사항 2: CHECK 제약 없이 문자열로 기록]
      await db.prepare(`
        INSERT INTO raw_events (user_id, session_id, event_type, payload_json, client_meta)
        VALUES (?, ?, 'STAGE_SELECTED', ?, ?)
      `).bind(
        v3Payload.user_id || null,
        v3Payload.session_id,
        JSON.stringify({ stage: v3Payload.stage, analysis_type: v3Payload.analysis_type }),
        c.req.header('User-Agent') || null
      ).run()
      
      // 2b. Universal 제출 이벤트 저장
      if (Object.keys(universalAnswers).length > 0) {
        await db.prepare(`
          INSERT INTO raw_events (user_id, session_id, event_type, payload_json)
          VALUES (?, ?, 'UNIVERSAL_SUBMITTED', ?)
        `).bind(
          v3Payload.user_id || null,
          v3Payload.session_id,
          JSON.stringify(universalAnswers)
        ).run()
        
        // Universal answers → facts 저장
        await saveUniversalFacts(db, v3Payload.session_id, v3Payload.user_id, universalAnswers, stage)
        
        // ============================================
        // Conversation Turns 저장 (P1 기능)
        // ============================================
        try {
          let turnNumber = await getNextTurnNumber(db, v3Payload.session_id)
          
          for (const [questionId, answer] of Object.entries(universalAnswers)) {
            if (answer === null || answer === undefined) continue
            
            const answerStr = Array.isArray(answer) ? answer.join(', ') : String(answer)
            const signals = extractSignalsFromAnswer(answerStr)
            
            await saveConversationTurn(db, {
              session_id: v3Payload.session_id,
              user_id: v3Payload.user_id,
              turn_number: turnNumber,
              turn_type: 'universal_intake',
              question_id: questionId,
              answer_raw: answerStr,
              answer_type: Array.isArray(answer) ? 'multi_choice' : 'text',
              extracted_signals: signals,
            })
            turnNumber++
          }
          console.log(`[V3 Analyze] Saved ${Object.keys(universalAnswers).length} conversation turns`)
        } catch (turnError) {
          // 대화 턴 저장 실패해도 분석은 계속 진행 (graceful degradation)
          console.error('[V3 Analyze] Conversation turn save failed:', turnError)
        }
      }
    } else {
      // V2: 기존 로직
      const v2Payload = rawPayload as AnalysisRequestPayloadV2
      if (!v2Payload.profile) {
        logError('VALIDATION_ERROR', 'profile is required for V2 payload', { session_id: rawPayload.session_id })
        return c.json(createErrorResponse('VALIDATION_ERROR', 'profile is required for V2 payload'), 400)
      }
      
      // 2. Raw event 저장 (V2)
      await db.prepare(`
        INSERT INTO raw_events (user_id, session_id, event_type, payload_json, client_meta)
        VALUES (?, ?, 'ANALYSIS_REQUESTED', ?, ?)
      `).bind(
        v2Payload.user_id || null,
        v2Payload.session_id,
        JSON.stringify(v2Payload),
        c.req.header('User-Agent') || null
      ).run()
    }
    
    // 3. Deep Intake 처리 (V2/V3 공통)
    let normalizedDeepIntake: NormalizedDeepIntake | undefined
    const deepIntake = (rawPayload as any).deep_intake as DeepIntakeInput | undefined
    
    if (deepIntake) {
      // [수정사항 3] 미성년 단계에서는 Deep Intake 서사형 질문 제한
      if (stage && isMinorStage(stage)) {
        // 미성년 단계: MBTI, priority만 허용, 오픈텍스트는 무시
        const sanitizedDeepIntake: DeepIntakeInput = {
          mbti: deepIntake.mbti,
          priority_top1: deepIntake.priority_top1,
          // best_moment, worst_moment, change_reason은 무시
        }
        normalizedDeepIntake = normalizeDeepIntake(sanitizedDeepIntake)
      } else {
        normalizedDeepIntake = normalizeDeepIntake(deepIntake)
      }
      
      // Deep Intake 이벤트 저장
      await db.prepare(`
        INSERT INTO raw_events (user_id, session_id, event_type, payload_json)
        VALUES (?, ?, 'DEEP_INTAKE_SUBMITTED', ?)
      `).bind(
        rawPayload.user_id || null,
        rawPayload.session_id,
        JSON.stringify({ raw: deepIntake, normalized: normalizedDeepIntake })
      ).run()
      
      // Deep Intake → facts 저장
      await saveDeepIntakeFacts(db, rawPayload.session_id, rawPayload.user_id, normalizedDeepIntake)
    }
    
    // 4. 기존 facts 조회 (이 세션에서 수집된)
    const existingFacts = await db.prepare(`
      SELECT fact_key, value_json, confidence, fact_level
      FROM facts
      WHERE session_id = ?
      ORDER BY fact_level ASC, collected_at DESC
    `).bind(rawPayload.session_id).all<{
      fact_key: string
      value_json: string
      confidence: number
      fact_level: number
    }>()
    
    const facts = existingFacts.results || []
    
    // 5. 분석 요청 생성 (버전 잠금)
    const analysisType = isV3 
      ? ((rawPayload as AnalysisRequestPayloadV3).analysis_type || 'job')
      : ((rawPayload as AnalysisRequestPayloadV2).analysis_type || 'job')
    
    const promptPayload = isV3
      ? JSON.stringify({ stage, universal_answers: universalAnswers })
      : JSON.stringify((rawPayload as AnalysisRequestPayloadV2).profile)
    
    const requestResult = await db.prepare(`
      INSERT INTO ai_analysis_requests (
        session_id, user_id, analysis_type, pricing_tier, prompt_payload,
        status, recipe_version, tagger_version, scoring_version
      )
      VALUES (?, ?, ?, ?, ?, 'processing', ?, ?, ?)
      RETURNING id
    `).bind(
      rawPayload.session_id,
      rawPayload.user_id || null,
      analysisType,
      (rawPayload as any).pricing_tier || 'free',
      promptPayload,
      VERSIONS.recipe,
      VERSIONS.tagger,
      VERSIONS.scoring
    ).first<{ id: number }>()
    
    if (!requestResult) {
      logError('DB_ERROR', 'Failed to create analysis request', { session_id: rawPayload.session_id })
      return c.json(createErrorResponse('DB_ERROR', 'Failed to create analysis request'), 500)
    }
    
    const requestId = requestResult.id
    
    // 6. 분석 실행 (V3는 stage + debug 전달 + Vectorize 확장)
    const env = c.env as Bindings
    const result = await runAnalysisV3(
      db, 
      rawPayload, 
      requestId, 
      facts, 
      normalizedDeepIntake,
      stage,
      debugMode,
      { VECTORIZE: env.VECTORIZE, AI: env.AI }
    )
    
    // 7. 결과 저장
    await db.prepare(`
      INSERT INTO ai_analysis_results (request_id, result_json)
      VALUES (?, ?)
    `).bind(requestId, JSON.stringify(result)).run()
    
    // 8. 요청 상태 업데이트
    await db.prepare(`
      UPDATE ai_analysis_requests
      SET status = 'completed', processed_at = CURRENT_TIMESTAMP
      WHERE id = ?
    `).bind(requestId).run()
    
    // 9. 완료 이벤트 저장
    await db.prepare(`
      INSERT INTO raw_events (user_id, session_id, event_type, payload_json)
      VALUES (?, ?, 'ANALYSIS_COMPLETED', ?)
    `).bind(
      rawPayload.user_id || null,
      rawPayload.session_id,
      JSON.stringify({ 
        request_id: requestId, 
        facts_applied: facts.length,
        has_deep_intake: !!normalizedDeepIntake,
        stage: stage || null,
        is_v3: isV3,
      })
    ).run()
    
    // 10. Phase 4 메트릭스 이벤트 저장
    await savePhase4MetricsEvents(db, rawPayload.session_id, rawPayload.user_id, requestId, result)
    
    return c.json({
      success: true,
      request_id: requestId,
      result,
      facts_applied: facts.length,
      deep_intake_processed: !!normalizedDeepIntake,
      stage: stage || null,
    })
    
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Unknown error'
    logError('ANALYSIS_FAILED', message, { 
      session_id: rawPayload.session_id,
      stack: error instanceof Error ? error.stack : undefined
    })
    return c.json(createErrorResponse('ANALYSIS_FAILED', 'Analysis failed', { 
      message, 
      session_id: rawPayload.session_id 
    }), 500)
  }
})

// ============================================
// V3: Universal Answers → facts 저장
// ============================================
async function saveUniversalFacts(
  db: D1Database,
  sessionId: string,
  userId: string | undefined,
  answers: UniversalAnswers,
  stage?: AnalysisStage
): Promise<void> {
  const UNIVERSAL_QUESTIONS_MAP = new Map(
    UNIVERSAL_QUESTIONS.map(q => [q.question_id, q])
  )
  
  // Universal 제약조건 → confirmed_constraint 매핑
  // 사용자가 "절대 불가"로 선택한 제약은 Phase 4 Hard Filter 대상
  const CONSTRAINT_TO_CONFIRMED: Record<string, string> = {
    'no_overtime': 'work_hours_strict',
    'no_shift': 'shift_work_no',
    'no_travel': 'travel_impossible',
    'remote_only': 'remote_only',
    'no_degree': 'degree_impossible',
    'no_license': 'license_impossible',
  }
  
  for (const [questionId, answer] of Object.entries(answers)) {
    if (answer === null || answer === undefined) continue
    if (Array.isArray(answer) && answer.length === 0) continue
    if (typeof answer === 'string' && answer.trim() === '') continue
    
    const question = UNIVERSAL_QUESTIONS_MAP.get(questionId)
    if (!question) continue
    
    // 정규화
    const normalized = normalizeUniversalAnswer(question, answer)
    
    // fact_level 결정
    const factLevel = determineUniversalFactLevel(question.fact_key)
    
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level, question_id)
      VALUES (?, ?, ?, ?, 1.0, 'universal', ?, ?)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(
      sessionId,
      userId || null,
      question.fact_key,
      JSON.stringify(normalized),
      factLevel,
      questionId
    ).run()
    
    // 🔥 Phase 4 Hard Filter 자동 승격
    // 제약조건 질문(univ_constraint_*)이면 confirmed_constraint도 저장
    if (questionId.startsWith('univ_constraint_')) {
      const values = Array.isArray(answer) ? answer : [answer]
      
      for (const value of values) {
        const confirmedType = CONSTRAINT_TO_CONFIRMED[value]
        if (confirmedType) {
          await db.prepare(`
            INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
            VALUES (?, ?, ?, ?, 1.0, 'universal', 1)
            ON CONFLICT(session_id, fact_key) DO UPDATE SET
              value_json = excluded.value_json,
              fact_level = 1,
              collected_at = CURRENT_TIMESTAMP
          `).bind(
            sessionId,
            userId || null,
            `confirmed_constraint.${confirmedType}`,
            JSON.stringify({ 
              confirmed: true, 
              source: 'universal_intake',
              original_value: value,
              confirmed_at: new Date().toISOString() 
            })
          ).run()
        }
      }
    }
  }
}

// Universal 답변 정규화
function normalizeUniversalAnswer(
  question: UniversalQuestion,
  answer: string | string[]
): { value: string | string[]; tags: string[]; raw?: string } {
  const values = Array.isArray(answer) ? answer : [answer]
  const tags: string[] = []
  
  // 옵션에서 태그 추출
  if (question.options) {
    for (const val of values) {
      const option = question.options.find(o => o.value === val)
      if (option?.tags) {
        tags.push(...option.tags)
      }
    }
  }
  
  // 텍스트 정규화 (freetext용)
  if (question.normalize_rule === 'keywords' && typeof answer === 'string') {
    return {
      value: answer,
      tags: extractKeywordTags(answer),
      raw: answer,
    }
  }
  
  return {
    value: answer,
    tags: [...new Set(tags)],
  }
}

// 키워드 기반 태그 추출 (freetext용)
function extractKeywordTags(text: string): string[] {
  const tags: string[] = []
  const lowerText = text.toLowerCase()
  
  // 간단한 키워드 매칭
  const keywordMap: Record<string, string[]> = {
    '건강': ['health'],
    '아프': ['health'],
    '돌봄': ['caregiving'],
    '가족': ['caregiving', 'family'],
    '아이': ['caregiving'],
    '원격': ['remote'],
    '재택': ['remote'],
    '야근': ['work_hours_strict'],
    '저녁': ['work_hours_strict', 'wlb'],
    '출퇴근': ['commute'],
  }
  
  for (const [keyword, keywordTags] of Object.entries(keywordMap)) {
    if (lowerText.includes(keyword)) {
      tags.push(...keywordTags)
    }
  }
  
  return [...new Set(tags)]
}

// Universal fact_level 결정
function determineUniversalFactLevel(factKey: string): number {
  if (factKey.startsWith('profile.constraints')) return 2
  if (factKey.startsWith('priority.')) return 2
  if (factKey.startsWith('profile.life_constraint')) return 2
  if (factKey.startsWith('profile.')) return 4
  if (factKey.startsWith('discovery.')) return 3
  return 4
}

// ============================================
// Phase 1C: Deep Intake → facts 저장
// ============================================
async function saveDeepIntakeFacts(
  db: D1Database,
  sessionId: string,
  userId: string | undefined,
  normalized: NormalizedDeepIntake
): Promise<void> {
  // MBTI 저장
  if (normalized.mbti) {
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'profile.mbti', ?, 1.0, 'deep_intake', 4)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(
      sessionId,
      userId || null,
      JSON.stringify({ value: normalized.mbti, traits: normalized.mbti_traits })
    ).run()
  }
  
  // best_moment 저장
  if (normalized.best_moment) {
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'discovery.best_moment', ?, 0.9, 'deep_intake', 3)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(
      sessionId,
      userId || null,
      JSON.stringify(normalized.best_moment)
    ).run()
  }
  
  // worst_moment 저장
  if (normalized.worst_moment) {
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'discovery.worst_moment', ?, 0.9, 'deep_intake', 3)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(
      sessionId,
      userId || null,
      JSON.stringify(normalized.worst_moment)
    ).run()
  }
  
  // change_reason 저장
  if (normalized.change_reason) {
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'motivation.change_reason', ?, 0.9, 'deep_intake', 3)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(
      sessionId,
      userId || null,
      JSON.stringify(normalized.change_reason)
    ).run()
  }
  
  // priority.top1 저장
  if (normalized.priority_top1) {
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'priority.top1', ?, 1.0, 'deep_intake', 2)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(
      sessionId,
      userId || null,
      JSON.stringify({ value: normalized.priority_top1 })
    ).run()
  }
}

// ============================================
// POST /followup - Follow-up 응답 처리 (facts 저장)
// ============================================
analyzerRoutes.post('/followup', async (c) => {
  const db = c.env.DB
  const payload = await c.req.json<FollowupPayloadV2>()
  
  try {
    // 1. 필수 필드 검증
    if (!payload.session_id || !payload.question_id || payload.answer === undefined) {
      logError('VALIDATION_ERROR', 'session_id, question_id, and answer are required')
      return c.json(createErrorResponse('VALIDATION_ERROR', 'session_id, question_id, and answer are required'), 400)
    }
    
    // 2. Raw event 저장 (원문 그대로)
    await db.prepare(`
      INSERT INTO raw_events (user_id, session_id, event_type, payload_json)
      VALUES (?, ?, 'FOLLOWUP_ANSWERED', ?)
    `).bind(
      payload.user_id || null,
      payload.session_id,
      JSON.stringify(payload)
    ).run()
    
    // ============================================
    // Conversation Turn 저장 (P1 기능)
    // ============================================
    try {
      const turnNumber = await getNextTurnNumber(db, payload.session_id)
      const answerStr = payload.answer_text || String(payload.answer)
      const signals = extractSignalsFromAnswer(answerStr)
      
      // FollowupV3 타입인지 확인 (purpose 기반)
      const turnType: TurnType = payload.question_type ? 
        (['contradiction_resolver', 'decision_variable', 'reality_constraint'].includes(payload.question_type) 
          ? 'followup_v3' 
          : 'followup_v2') 
        : 'followup_v2'
      
      await saveConversationTurn(db, {
        session_id: payload.session_id,
        user_id: payload.user_id,
        request_id: payload.request_id,
        turn_number: turnNumber,
        turn_type: turnType,
        question_id: payload.question_id,
        question_type: payload.question_type as any,
        answer_raw: answerStr,
        answer_type: payload.answer_text ? 'text' : 'single_choice',
        extracted_signals: signals,
        affected_dimensions: payload.affects_attributes,
      })
      console.log(`[Followup] Saved conversation turn #${turnNumber} for session: ${payload.session_id}`)
    } catch (turnError) {
      // 대화 턴 저장 실패해도 followup 처리는 계속 진행
      console.error('[Followup] Conversation turn save failed:', turnError)
    }
    
    // 3. fact_key와 value 결정
    const factKey = payload.fact_key || `answer.${payload.question_id}`
    const factLevel = determineFctLevel(factKey)
    
    // 4. facts 테이블에 저장 (UPSERT - 같은 session+fact_key면 갱신)
    await db.prepare(`
      INSERT INTO facts (
        session_id, user_id, fact_key, value_json, confidence, question_id, 
        source_type, fact_level
      )
      VALUES (?, ?, ?, ?, ?, ?, 'followup', ?)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        confidence = excluded.confidence,
        collected_at = CURRENT_TIMESTAMP
    `).bind(
      payload.session_id,
      payload.user_id || null,
      factKey,
      JSON.stringify({ value: payload.answer, raw: payload.answer_text }),
      payload.confidence || 1.0,
      payload.question_id,
      factLevel
    ).run()
    
    // 5. question_history 업데이트
    await db.prepare(`
      INSERT INTO question_history (session_id, question_id, question_type, attribute, answer_value)
      VALUES (?, ?, ?, ?, ?)
      ON CONFLICT(session_id, question_id) DO UPDATE SET
        answered_at = CURRENT_TIMESTAMP,
        answer_value = excluded.answer_value
    `).bind(
      payload.session_id,
      payload.question_id,
      payload.question_type || 'unknown',
      payload.attribute || null,
      payload.answer
    ).run()
    
    // 6. 기존 constraint 기반 followup 처리 (backward compatibility)
    if (payload.constraint && payload.request_id) {
      const constraint = assertConstraintType(payload.constraint)
      
      await db.prepare(`
        INSERT INTO followup_responses (
          request_id, question_id, constraint_type, job_id, job_name, answer
        )
        VALUES (?, ?, ?, ?, ?, ?)
      `).bind(
        payload.request_id,
        payload.question_id,
        constraint,
        payload.job_id || null,
        payload.job_name || null,
        payload.answer
      ).run()
      
      if (payload.answer === 'no') {
        await db.prepare(`
          INSERT OR IGNORE INTO confirmed_constraints (
            session_id, user_id, request_id, constraint_type, constraint_value
          )
          VALUES (?, ?, ?, ?, ?)
        `).bind(
          payload.session_id,
          payload.user_id || null,
          payload.request_id,
          constraint,
          'true'
        ).run()
      }
    }
    
    // 7. Phase 4: answer="no"면 Safe Replacement 처리
    if (payload.answer === 'no' && payload.job_id && payload.request_id) {
      // 현재 결과에서 후보군과 TOP3 가져오기
      const existingResult = await db.prepare(`
        SELECT result_json FROM ai_analysis_results WHERE request_id = ?
      `).bind(payload.request_id).first<{ result_json: string }>()
      
      if (existingResult) {
        try {
          const resultData = JSON.parse(existingResult.result_json)
          
          // TOP3와 전체 후보군 구성
          const originalTop3: ScoredJob[] = (resultData.fit_top3 || []).map((j: any) => ({
            job_id: j.job_id,
            job_name: j.job_name,
            scores: {
              fit: j.fit_score || 0,
              like: j.like_score || 0,
              can: j.can_score || 0,
              risk_penalty: 0,
            },
            attributes: {},
          }))
          
          // 전체 후보는 like_top10과 can_top10 합쳐서 구성 (dedupe)
          const allJobIds = new Set<string>()
          const allCandidates: ScoredJob[] = []
          
          for (const source of [resultData.fit_top3, resultData.like_top10, resultData.can_top10]) {
            if (!source) continue
            for (const j of source) {
              if (!allJobIds.has(j.job_id)) {
                allJobIds.add(j.job_id)
                allCandidates.push({
                  job_id: j.job_id,
                  job_name: j.job_name,
                  scores: {
                    fit: j.fit_score || j.like_score || 0,
                    like: j.like_score || 0,
                    can: j.can_score || 0,
                    risk_penalty: 0,
                  },
                  attributes: {},
                })
              }
            }
          }
          
          // constraint 타입 결정
          const constraintType = payload.constraint || factKey.replace('answer.', '')
          
          // Phase 4 Safe Replacement 실행
          const safeResult = await handleFollowupNo(
            db,
            payload.session_id,
            payload.user_id,
            payload.question_id,
            constraintType,
            payload.job_id,
            allCandidates,
            originalTop3,
            payload.request_id
          )
          
          // Phase 4 결과 반환
          return c.json({
            success: true,
            phase4_applied: true,
            fact_saved: {
              fact_key: factKey,
              value: payload.answer,
              fact_level: factLevel,
            },
            ...safeResult,
          })
          
        } catch (error) {
          console.error('Phase 4 Safe Replacement error:', error)
          // Phase 4 실패해도 기본 응답은 반환
        }
      }
    }
    
    // 8. 응답 구성 (Phase 4 미적용 시)
    const result: FollowupResultV2 = {
      success: true,
      fact_saved: {
        fact_key: factKey,
        value: payload.answer,
        fact_level: factLevel,
      },
      reanalyze_available: true,
      message: '답변이 저장되었습니다. 재분석 시 반영됩니다.',
    }
    
    return c.json(result)
    
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Unknown error'
    logError('ANALYSIS_FAILED', `Followup failed: ${message}`, {
      stack: error instanceof Error ? error.stack : undefined
    })
    return c.json(createErrorResponse('ANALYSIS_FAILED', 'Followup failed', { message }), 500)
  }
})

// ============================================
// GET /result/:requestId - 결과 조회
// ============================================
analyzerRoutes.get('/result/:requestId', async (c) => {
  const db = c.env.DB
  const requestId = parseInt(c.req.param('requestId'), 10)
  
  const providedId = c.req.param('requestId')
  if (isNaN(requestId)) {
    logError('VALIDATION_ERROR', 'Invalid request_id', { provided: providedId })
    return c.json(createErrorResponse('VALIDATION_ERROR', 'Invalid request_id', { provided: providedId }), 400)
  }
  
  try {
    const request = await db.prepare(`
      SELECT * FROM ai_analysis_requests WHERE id = ?
    `).bind(requestId).first()
    
    if (!request) {
      logError('REQUEST_NOT_FOUND', 'Analysis request not found', { request_id: requestId })
      return c.json(createErrorResponse('REQUEST_NOT_FOUND', 'Analysis request not found', { request_id: requestId }), 404)
    }
    
    const result = await db.prepare(`
      SELECT * FROM ai_analysis_results WHERE request_id = ?
    `).bind(requestId).first<{ result_json: string }>()
    
    const followups = await db.prepare(`
      SELECT * FROM followup_responses WHERE request_id = ?
    `).bind(requestId).all()
    
    return c.json({
      request,
      result: result ? JSON.parse(result.result_json) : null,
      followups: followups.results,
    })
    
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Unknown error'
    logError('DB_ERROR', `Failed to fetch result: ${message}`, {
      request_id: requestId,
      stack: error instanceof Error ? error.stack : undefined
    })
    return c.json(createErrorResponse('DB_ERROR', 'Failed to fetch result', { 
      message, 
      request_id: requestId 
    }), 500)
  }
})

// ============================================
// GET /session/:sessionId - 세션 이력 조회
// ============================================
analyzerRoutes.get('/session/:sessionId', async (c) => {
  const db = c.env.DB
  const sessionId = c.req.param('sessionId')
  
  try {
    const events = await db.prepare(`
      SELECT * FROM raw_events 
      WHERE session_id = ?
      ORDER BY created_at ASC
    `).bind(sessionId).all()
    
    const requests = await db.prepare(`
      SELECT * FROM ai_analysis_requests
      WHERE session_id = ?
      ORDER BY requested_at ASC
    `).bind(sessionId).all()
    
    const constraints = await db.prepare(`
      SELECT * FROM confirmed_constraints
      WHERE session_id = ?
    `).bind(sessionId).all()
    
    // Phase 1A: facts 조회 추가
    const facts = await db.prepare(`
      SELECT * FROM facts
      WHERE session_id = ?
      ORDER BY fact_level ASC, collected_at DESC
    `).bind(sessionId).all()
    
    return c.json({
      session_id: sessionId,
      events: events.results,
      requests: requests.results,
      confirmed_constraints: constraints.results,
      facts: facts.results,  // Phase 1A 추가
    })
    
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Unknown error'
    logError('DB_ERROR', `Failed to fetch session: ${message}`, {
      session_id: sessionId,
      stack: error instanceof Error ? error.stack : undefined
    })
    return c.json(createErrorResponse('DB_ERROR', 'Failed to fetch session', { 
      message, 
      session_id: sessionId 
    }), 500)
  }
})

// ============================================
// GET /facts/:sessionId - 세션의 facts만 조회
// ============================================
analyzerRoutes.get('/facts/:sessionId', async (c) => {
  const db = c.env.DB
  const sessionId = c.req.param('sessionId')
  
  try {
    const facts = await db.prepare(`
      SELECT * FROM facts
      WHERE session_id = ?
      ORDER BY fact_level ASC, collected_at DESC
    `).bind(sessionId).all()
    
    return c.json({
      session_id: sessionId,
      facts: facts.results,
      count: facts.results?.length || 0,
    })
    
  } catch (error) {
    logError('DB_ERROR', 'Failed to fetch facts', { session_id: sessionId })
    return c.json(createErrorResponse('DB_ERROR', 'Failed to fetch facts', { session_id: sessionId }), 500)
  }
})

// ============================================
// Analysis Logic (Phase 1A MVE)
// ============================================

interface Fact {
  fact_key: string
  value_json: string
  confidence: number
  fact_level: number
}

async function runAnalysis(
  db: D1Database,
  payload: AnalysisRequestPayloadV2,
  requestId: number,
  facts: Fact[],
  deepIntake?: NormalizedDeepIntake
): Promise<AnalysisResultJSON> {
  // 1. job_attributes에서 실제 데이터 조회 (Phase 1B)
  const jobAttrs = await db.prepare(`
    SELECT 
      job_id, job_name,
      wlb, growth, stability, income,
      teamwork, solo_deep, analytical, creative, execution, people_facing,
      work_hours, shift_work, travel, remote_possible,
      degree_required, license_required
    FROM job_attributes
    WHERE tagger_version = 'tagger-v1.0.0'
    LIMIT 80
  `).all<{
    job_id: string
    job_name: string
    wlb: number
    growth: number
    stability: number
    income: number
    teamwork: number
    solo_deep: number
    analytical: number
    creative: number
    execution: number
    people_facing: number
    work_hours: string
    shift_work: string
    travel: string
    remote_possible: string
    degree_required: string
    license_required: string
  }>()
  
  // DB에 데이터가 없으면 샘플 사용
  const sampleJobs = (jobAttrs.results && jobAttrs.results.length > 0)
    ? jobAttrs.results.map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        base_like: Math.round((j.wlb + j.growth + j.stability + j.income) / 4),
        // 연구직 과도 대표 방지를 위해 analytical 가중치 조정 (0.7배)
        base_can: Math.round((j.teamwork + (j.analytical * 0.7) + j.creative) / 3),
        base_risk: 10,  // 기본 risk
        attributes: {
          wlb: j.wlb,
          growth: j.growth,
          stability: j.stability,
          income: j.income,
          remote: j.remote_possible === 'full' ? 100 : j.remote_possible === 'partial' ? 50 : 0,
          solo_work: j.solo_deep,
          people_facing: j.people_facing,
          analytical: j.analytical,
          creative: j.creative,
        },
      }))
    : getSampleJobs()
  
  // 2. Fact boosts 계산
  const factBoosts = calculateFactBoosts(facts)
  
  // 3. 각 직업에 점수 적용
  const scoredJobs: ScoredJob[] = sampleJobs.map(job => {
    const baseScores: JobScores = {
      like: job.base_like,
      can: job.base_can,
      risk_penalty: job.base_risk,
    }
    
    const adjusted = applyFactBoostsToJob(baseScores, job.attributes, factBoosts)
    const fit = Math.round(0.5 * adjusted.like + 0.5 * adjusted.can - adjusted.risk_penalty)
    
    return {
      job_id: job.job_id,
      job_name: job.job_name,
      scores: {
        fit: Math.max(0, fit),
        like: adjusted.like,
        can: adjusted.can,
        risk_penalty: adjusted.risk_penalty,
      },
      attributes: job.attributes,
    }
  })
  
  // 4. 정렬 (Fit 기준)
  scoredJobs.sort((a, b) => b.scores.fit - a.scores.fit)
  
  const top10 = scoredJobs.slice(0, 10)
  
  // Phase 4: Diversity Guard (내부에서 Research Bias Cap도 적용)
  const rawTop3 = top10.slice(0, 3)
  const diversityResult = applyDiversityGuard(rawTop3, scoredJobs)
  const top3 = diversityResult.adjusted
  
  // 5. Follow-up 질문 생성 (Deep Intake 여부 반영)
  const existingFactKeys = facts.map(f => ({ fact_key: f.fact_key }))
  const followupQuestions = generateFollowupQuestions({
    candidates: scoredJobs,
    topK: top10,
    existingFacts: existingFactKeys,
    hasDeepIntake: !!deepIntake,  // Phase 1C: Deep Intake 여부 전달
  }, 3)
  
  // 6. Phase 1C: User Insight 생성
  const userInsight = generateUserInsight(facts, deepIntake, factBoosts.applied_rules)
  
  // 7. 결과 구성
  const result: AnalysisResultJSON = {
    engine_state: deepIntake ? 'phase1a_mve' : (facts.length > 0 ? 'phase1a_mve' : 'phase1a_initial'),
    
    versions: {
      recipe: VERSIONS.recipe,
      tagger: VERSIONS.tagger,
      scoring: VERSIONS.scoring,
    },
    
    input_summary: {
      profile_revision_id: `rev-${requestId}-${Date.now()}`,
      key_interests: payload.profile.interest.keywords.slice(0, 3),
      key_skills: payload.profile.skill.map(s => s.name).slice(0, 3),
      non_negotiables: Object.entries(payload.profile.constraints || {})
        .filter(([_, v]) => v === true)
        .map(([k]) => k),
      preferences: [],
      facts_applied: facts.length,
      applied_rules: factBoosts.applied_rules,
      // Phase 1C: Deep Intake 정보 추가
      deep_intake_provided: !!deepIntake,
      insight_tags: userInsight?.key_traits.map(t => t.trait) || [],
    },
    
    fit_top3: top3.map(j => {
      // Evidence 생성 (facts + job attributes 기반)
      // ⚠️ Evidence는 "설명용"이며 점수 계산에 영향 없음
      const evidenceFacts: EvidenceFact[] = facts.map(f => ({
        fact_key: f.fact_key,
        value_json: f.value_json,
      }))
      let evidenceLinks = buildEvidenceLinks(evidenceFacts, j)
      
      // Evidence가 부족하면 기본 Evidence 추가
      if (evidenceLinks.length < 3) {
        const defaultEvidence = generateDefaultEvidence(j)
        evidenceLinks = [...evidenceLinks, ...defaultEvidence].slice(0, 10)
      }
      
      return {
        job_id: j.job_id,
        job_name: j.job_name,
        fit_score: j.scores.fit,
        like_score: j.scores.like,
        can_score: j.scores.can,
        risk_details: [],
        evidence_links: evidenceLinks,
      }
    }),
    
    like_top10: top10.map(j => ({
      job_id: j.job_id,
      job_name: j.job_name,
      like_score: j.scores.like,
    })),
    
    can_top10: top10.map(j => ({
      job_id: j.job_id,
      job_name: j.job_name,
      can_score: j.scores.can,
    })),
    
    caution_jobs: scoredJobs
      .filter(j => j.scores.risk_penalty > 20)
      .slice(0, 5)
      .map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        risk_penalty: j.scores.risk_penalty,
      })),
    
    // Phase 1A: followup_questions 추가!
    followup_questions: followupQuestions,
    
    ux_flags: {
      has_caution_in_top3: top3.some(j => j.scores.risk_penalty > 20),
      has_unknown_in_top3: false,
      needs_followup_question: followupQuestions.length > 0,
      counts_before_filter: {
        safe_known: scoredJobs.filter(j => j.scores.risk_penalty <= 10).length,
        safe_unknown: scoredJobs.filter(j => j.scores.risk_penalty > 10 && j.scores.risk_penalty <= 20).length,
        caution: scoredJobs.filter(j => j.scores.risk_penalty > 20).length,
        total: scoredJobs.length,
      },
      counts_after_filter: {
        safe_known: scoredJobs.filter(j => j.scores.risk_penalty <= 10).length,
        safe_unknown: scoredJobs.filter(j => j.scores.risk_penalty > 10 && j.scores.risk_penalty <= 20).length,
        caution: scoredJobs.filter(j => j.scores.risk_penalty > 20).length,
        total: scoredJobs.length,
      },
    },
    
    llm_explanation: generateExplanation(facts, factBoosts.applied_rules, top3[0]?.job_name),
    generated_at: new Date().toISOString(),
    total_candidates: scoredJobs.length,
    
    // Phase 1C: User Insight 추가
    user_insight: userInsight,
    
    // Phase 4: Diversity Guard 정보
    phase4_applied: true,
    diversity_guard_active: diversityResult.diversityApplied,
    diversity_changes: diversityResult.changes,
  }
  
  return result
}

// ============================================
// Explainability V3: 직업별 추천 근거 생성
// ============================================
interface JobExplanation {
  like_reason: string    // Like 점수 근거
  can_reason: string     // Can 점수 근거
  risk_warning: string   // Risk 경고 (있으면)
}

function generateJobExplanation(
  job: ScoredJob,
  facts: Fact[],
  appliedRules: string[]
): JobExplanation {
  // Like 근거 (interest/values 매칭)
  let likeReason = '기본 적합도 기반 추천'
  const interestFacts = facts.filter(f => 
    f.fact_key.includes('interest') || f.fact_key.includes('priority')
  )
  if (interestFacts.length > 0) {
    try {
      const firstInterest = JSON.parse(interestFacts[0].value_json)
      const interestValue = Array.isArray(firstInterest.value) 
        ? firstInterest.value[0] 
        : firstInterest.value
      if (interestValue) {
        likeReason = `"${interestValue}" 관심사와 매칭`
      }
    } catch { /* ignore */ }
  }
  
  // 규칙 기반 보정
  if (appliedRules.includes('profile.interest.keywords')) {
    likeReason = '관심 키워드 기반 매칭'
  }
  if (appliedRules.includes('priority.top1')) {
    const priorityFact = facts.find(f => f.fact_key === 'priority.top1')
    if (priorityFact) {
      try {
        const pv = JSON.parse(priorityFact.value_json)
        const priorityMap: Record<string, string> = {
          growth: '성장 가능성', wlb: '워라밸', income: '수입', stability: '안정성'
        }
        likeReason = `${priorityMap[pv.value] || pv.value} 우선순위 반영`
      } catch { /* ignore */ }
    }
  }
  
  // Can 근거 (skill/degree/license 관련)
  let canReason = '기본 역량 적합도 기반'
  const constraintFacts = facts.filter(f => 
    f.fact_key.includes('constraint') || f.fact_key.includes('qualification')
  )
  if (constraintFacts.length === 0) {
    canReason = '특별한 자격 요건 없음'
  } else {
    canReason = '입력된 제약 조건과 호환'
  }
  
  // workstyle 반영
  if (appliedRules.includes('profile.workstyle.social')) {
    const styleFact = facts.find(f => f.fact_key === 'profile.workstyle.social')
    if (styleFact) {
      try {
        const sv = JSON.parse(styleFact.value_json)
        const styleMap: Record<string, string> = {
          solo: '독립적 업무 환경', team: '팀 협업 환경', balanced: '균형 잡힌 업무 환경'
        }
        canReason = `${styleMap[sv.value] || '선호'} 업무 스타일 부합`
      } catch { /* ignore */ }
    }
  }
  
  // Risk 경고 (confirmed_constraint 충돌 체크)
  let riskWarning = ''
  const confirmedConstraints = facts.filter(f => f.fact_key.startsWith('confirmed_constraint.'))
  if (confirmedConstraints.length > 0) {
    // 제약이 있지만 이 직업이 추천됐다면 통과한 것
    riskWarning = '제약 조건 충족'
  }
  if (job.scores.risk_penalty > 15) {
    riskWarning = '일부 주의 필요 (상세 정보 확인 권장)'
  } else if (job.scores.risk_penalty > 10) {
    riskWarning = '경미한 불확실성 있음'
  }
  if (!riskWarning) {
    riskWarning = '특별한 위험 요소 없음'
  }
  
  return {
    like_reason: likeReason,
    can_reason: canReason,
    risk_warning: riskWarning,
  }
}

// ============================================
// Phase 1C: User Insight 생성
// ============================================
function generateUserInsight(
  facts: Fact[],
  deepIntake?: NormalizedDeepIntake,
  appliedRules?: string[]
): UserInsight | undefined {
  if (!deepIntake && facts.length === 0) {
    return undefined
  }
  
  const keyTraits: UserInsight['key_traits'] = []
  const appliedFacts: UserInsight['applied_facts'] = []
  
  // MBTI 기반 인사이트
  if (deepIntake?.mbti && deepIntake.mbti_traits) {
    const workStyles = deepIntake.mbti_traits.workStyles
    
    if (workStyles.includes('solo_deep')) {
      keyTraits.push({
        trait: '혼자 깊게 파기를 선호',
        evidence: `MBTI ${deepIntake.mbti}의 특성`,
        score_impact: '분석/연구 중심 직업에 +5~10 부스트',
      })
    }
    if (workStyles.includes('team_collab')) {
      keyTraits.push({
        trait: '팀 협업을 선호',
        evidence: `MBTI ${deepIntake.mbti}의 특성`,
        score_impact: '협업 중심 직업에 +5~10 부스트',
      })
    }
    if (workStyles.includes('creative')) {
      keyTraits.push({
        trait: '창의적인 업무 선호',
        evidence: `MBTI ${deepIntake.mbti}의 특성`,
        score_impact: '창의성 요구 직업에 +5 부스트',
      })
    }
  }
  
  // best_moment 기반 인사이트
  if (deepIntake?.best_moment) {
    const tags = deepIntake.best_moment.tags
    if (tags.includes('solo_deep')) {
      keyTraits.push({
        trait: '몰입하며 일할 때 에너지를 얻음',
        evidence: `"${deepIntake.best_moment.raw.slice(0, 30)}..."`,
        score_impact: '분석/연구 직업에 +15 부스트',
      })
    }
    if (tags.includes('team_collab') || tags.includes('people_facing')) {
      keyTraits.push({
        trait: '사람들과 함께할 때 에너지를 얻음',
        evidence: `"${deepIntake.best_moment.raw.slice(0, 30)}..."`,
        score_impact: '협업/대인 직업에 +15 부스트',
      })
    }
    if (tags.includes('creative')) {
      keyTraits.push({
        trait: '창작/기획할 때 보람을 느낌',
        evidence: `"${deepIntake.best_moment.raw.slice(0, 30)}..."`,
        score_impact: '창의성 요구 직업에 +15 부스트',
      })
    }
  }
  
  // worst_moment 기반 인사이트
  if (deepIntake?.worst_moment) {
    const stressTrigger = deepIntake.worst_moment.stress_trigger
    if (stressTrigger === 'people') {
      keyTraits.push({
        trait: '대인 갈등에 스트레스를 받음',
        evidence: `"${deepIntake.worst_moment.raw.slice(0, 30)}..."`,
        score_impact: '독립적 업무 직업에 +15 부스트',
      })
    }
    if (stressTrigger === 'deadline') {
      keyTraits.push({
        trait: '마감 압박에 스트레스를 받음',
        evidence: `"${deepIntake.worst_moment.raw.slice(0, 30)}..."`,
        score_impact: '워라밸 좋은 직업에 +10 부스트',
      })
    }
    if (stressTrigger === 'meeting') {
      keyTraits.push({
        trait: '회의가 많은 환경을 피하고 싶음',
        evidence: `"${deepIntake.worst_moment.raw.slice(0, 30)}..."`,
        score_impact: '독립적/원격 직업에 +10 부스트',
      })
    }
  }
  
  // priority.top1 기반 인사이트
  if (deepIntake?.priority_top1) {
    const priorityMap: Record<string, string> = {
      'growth': '성장 가능성',
      'stability': '안정성',
      'wlb': '워라밸',
      'income': '높은 수입',
    }
    keyTraits.push({
      trait: `${priorityMap[deepIntake.priority_top1] || deepIntake.priority_top1}을(를) 최우선시`,
      evidence: '직접 선택',
      score_impact: `해당 속성에 +20 부스트`,
    })
  }
  
  // facts 기반 인사이트
  for (const fact of facts) {
    try {
      const value = JSON.parse(fact.value_json)
      
      if (fact.fact_key === 'tradeoff.salary_vs_wlb') {
        appliedFacts.push({
          fact_key: fact.fact_key,
          effect_summary: value.value === 'wlb' 
            ? '워라밸을 연봉보다 중시 → WLB 직업에 +15 부스트'
            : '연봉을 워라밸보다 중시 → 고수입 직업에 +15 부스트',
        })
      }
      if (fact.fact_key === 'tradeoff.growth_vs_stability') {
        appliedFacts.push({
          fact_key: fact.fact_key,
          effect_summary: value.value === 'growth'
            ? '성장을 안정보다 중시 → 성장 가능성 직업에 +15 부스트'
            : '안정을 성장보다 중시 → 안정적 직업에 +15 부스트',
        })
      }
      if (fact.fact_key === 'motivation.work_hours_reason') {
        appliedFacts.push({
          fact_key: fact.fact_key,
          effect_summary: `"${value.value || value.raw?.slice(0, 20)}" 이유로 야근 기피 → 관련 리스크 페널티 조정`,
        })
      }
    } catch {
      // JSON 파싱 실패 시 무시
    }
  }
  
  // 요약 문장 생성
  let summary = ''
  if (keyTraits.length > 0) {
    const topTraits = keyTraits.slice(0, 3).map(t => t.trait)
    summary = `당신은 ${topTraits.join(', ')} 사람입니다.`
  } else if (appliedFacts.length > 0) {
    summary = `${appliedFacts.length}개의 답변을 분석하여 맞춤 추천을 제공했습니다.`
  } else {
    summary = '더 많은 정보를 입력하시면 더 정확한 인사이트를 드릴 수 있어요.'
  }
  
  return {
    summary,
    key_traits: keyTraits,
    applied_facts: appliedFacts,
  }
}

// ============================================
// 설명 생성 (Phase 1A 간단 버전)
// ============================================
function generateExplanation(
  facts: Fact[],
  appliedRules: string[],
  topJobName?: string
): string {
  if (facts.length === 0) {
    return '추가 질문에 답변하시면 더 정확한 추천을 받으실 수 있습니다.'
  }
  
  const explanations: string[] = []
  
  for (const fact of facts) {
    try {
      const value = JSON.parse(fact.value_json)
      const choice = value.value || value
      
      if (fact.fact_key === 'tradeoff.salary_vs_wlb') {
        if (choice === 'wlb') {
          explanations.push('워라밸을 중시한다는 답변을 반영했습니다')
        } else {
          explanations.push('연봉을 중시한다는 답변을 반영했습니다')
        }
      } else if (fact.fact_key === 'tradeoff.growth_vs_stability') {
        if (choice === 'growth') {
          explanations.push('성장 가능성을 중시한다는 답변을 반영했습니다')
        } else {
          explanations.push('안정성을 중시한다는 답변을 반영했습니다')
        }
      } else if (fact.fact_key.startsWith('motivation.')) {
        explanations.push(`"${choice}" 때문이라는 이유를 반영했습니다`)
      }
    } catch {
      // JSON 파싱 실패 시 무시
    }
  }
  
  if (explanations.length === 0) {
    return `${facts.length}개의 답변을 반영하여 추천했습니다.`
  }
  
  return explanations.join('. ') + '.'
}

// ============================================
// 샘플 직업 데이터 (Phase 1A)
// ============================================
interface SampleJob {
  job_id: string
  job_name: string
  base_like: number
  base_can: number
  base_risk: number
  attributes: Record<string, string | number>
}

function getSampleJobs(): SampleJob[] {
  return [
    {
      job_id: 'data-analyst',
      job_name: '데이터 분석가',
      base_like: 70,
      base_can: 65,
      base_risk: 5,
      attributes: { wlb: 80, growth: 85, stability: 70, income: 75, solo_work: 70, remote: 60 },
    },
    {
      job_id: 'software-developer',
      job_name: '소프트웨어 개발자',
      base_like: 75,
      base_can: 60,
      base_risk: 10,
      attributes: { wlb: 50, growth: 90, stability: 75, income: 85, solo_work: 65, remote: 80 },
    },
    {
      job_id: 'ux-designer',
      job_name: 'UX 디자이너',
      base_like: 72,
      base_can: 55,
      base_risk: 8,
      attributes: { wlb: 70, growth: 80, stability: 65, income: 70, solo_work: 50, remote: 75, creative: 90 },
    },
    {
      job_id: 'project-manager',
      job_name: '프로젝트 매니저',
      base_like: 68,
      base_can: 70,
      base_risk: 15,
      attributes: { wlb: 40, growth: 75, stability: 70, income: 80, people_facing: 90, solo_work: 20 },
    },
    {
      job_id: 'accountant',
      job_name: '회계사',
      base_like: 60,
      base_can: 75,
      base_risk: 5,
      attributes: { wlb: 60, growth: 50, stability: 95, income: 75, solo_work: 80, analytical: 90 },
    },
    {
      job_id: 'marketing-specialist',
      job_name: '마케팅 전문가',
      base_like: 70,
      base_can: 60,
      base_risk: 20,
      attributes: { wlb: 45, growth: 70, stability: 55, income: 65, people_facing: 75, creative: 80 },
    },
    {
      job_id: 'hr-manager',
      job_name: '인사 담당자',
      base_like: 62,
      base_can: 68,
      base_risk: 10,
      attributes: { wlb: 70, growth: 60, stability: 80, income: 65, people_facing: 95, solo_work: 30 },
    },
    {
      job_id: 'financial-analyst',
      job_name: '재무 분석가',
      base_like: 65,
      base_can: 62,
      base_risk: 25,
      attributes: { wlb: 35, growth: 75, stability: 70, income: 90, solo_work: 65, analytical: 95 },
    },
    {
      job_id: 'content-creator',
      job_name: '콘텐츠 크리에이터',
      base_like: 78,
      base_can: 50,
      base_risk: 30,
      attributes: { wlb: 55, growth: 65, stability: 30, income: 50, solo_work: 75, remote: 90, creative: 95 },
    },
    {
      job_id: 'teacher',
      job_name: '교사',
      base_like: 60,
      base_can: 70,
      base_risk: 5,
      attributes: { wlb: 80, growth: 40, stability: 95, income: 55, people_facing: 90, impact: 85 },
    },
    {
      job_id: 'nurse',
      job_name: '간호사',
      base_like: 55,
      base_can: 60,
      base_risk: 35,
      attributes: { wlb: 25, growth: 50, stability: 90, income: 65, people_facing: 95, impact: 95 },
    },
    {
      job_id: 'consultant',
      job_name: '경영 컨설턴트',
      base_like: 72,
      base_can: 55,
      base_risk: 40,
      attributes: { wlb: 20, growth: 95, stability: 50, income: 95, people_facing: 80, analytical: 85 },
    },
  ]
}

// ============================================
// Helper Types
// ============================================
interface FollowupPayloadV2 {
  session_id: string
  user_id?: string
  question_id: string
  question_type?: string
  attribute?: string
  fact_key?: string
  answer: string
  answer_text?: string  // 자유응답 원문
  confidence?: number
  // backward compatibility
  request_id?: number
  constraint?: string
  job_id?: string
  job_name?: string
}

interface FollowupResultV2 {
  success: boolean
  fact_saved: {
    fact_key: string
    value: string
    fact_level: number
  }
  reanalyze_available: boolean
  message: string
}

function determineFctLevel(factKey: string): number {
  if (factKey.startsWith('confirmed_constraint')) return 1
  if (factKey.startsWith('priority.dealbreaker')) return 2
  if (factKey.startsWith('priority.') || factKey.startsWith('tradeoff.') || factKey.startsWith('motivation.')) return 3
  return 4
}

// ============================================
// V3: Stage-based Analysis (with stage-aware follow-ups)
// ============================================
async function runAnalysisV3(
  db: D1Database,
  payload: AnalyzePayload,
  requestId: number,
  facts: Fact[],
  deepIntake?: NormalizedDeepIntake,
  stage?: AnalysisStage,
  debugMode?: boolean,
  env?: { VECTORIZE?: VectorizeIndex; AI?: Ai }
): Promise<AnalysisResultJSON> {
  // ============================================
  // P1 Vectorize 기반 후보군 확장
  // ============================================
  let candidateSource: 'vectorize' | 'tagged' | 'sample_fallback' = 'tagged'
  let taggedCount = 0
  let vectorizeUsed = false
  let totalCandidates = 0
  
  // Vectorize 사용 가능 여부 확인
  const useVectorize = env?.VECTORIZE && env?.AI
  
  let sampleJobs: Array<{
    job_id: string
    job_name: string
    base_like: number
    base_can: number
    base_risk: number
    attributes: Record<string, number | string>
  }>
  
  if (useVectorize) {
    // Vectorize 기반 후보군 확장 (80 → 500)
    try {
      console.log('[V3 Analyze] Using Vectorize for candidate expansion')
      const expansionResult = await expandCandidates(
        db,
        env!.VECTORIZE,
        env!.AI,
        facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json })),
        { targetSize: 500, minTaggedJobs: 80 }
      )
      
      if (!expansionResult.fallback_used && expansionResult.candidates.length > 0) {
        // 벡터 결과를 ScoredJob 형태로 변환
        sampleJobs = await vectorResultsToScoredJobs(db, expansionResult.candidates)
        candidateSource = 'vectorize'
        vectorizeUsed = true
        totalCandidates = expansionResult.candidates.length
        console.log(`[V3 Analyze] Vectorize returned ${totalCandidates} candidates in ${expansionResult.search_duration_ms}ms`)
      } else {
        // Vectorize 실패 시 기존 방식
        throw new Error('Vectorize fallback triggered')
      }
    } catch (vectorError) {
      console.log('[V3 Analyze] Vectorize unavailable, using tagged jobs')
      // 기존 방식으로 폴백
      const jobAttrs = await db.prepare(`
        SELECT 
          job_id, job_name,
          wlb, growth, stability, income,
          teamwork, solo_deep, analytical, creative, execution, people_facing,
          work_hours, shift_work, travel, remote_possible,
          degree_required, license_required
        FROM job_attributes
        WHERE tagger_version = 'tagger-v1.0.0'
        LIMIT 80
      `).all<{
        job_id: string
        job_name: string
        wlb: number
        growth: number
        stability: number
        income: number
        teamwork: number
        solo_deep: number
        analytical: number
        creative: number
        execution: number
        people_facing: number
        work_hours: string
        shift_work: string
        travel: string
        remote_possible: string
        degree_required: string
        license_required: string
      }>()
      
      const useDbData = jobAttrs.results && jobAttrs.results.length > 0
      candidateSource = useDbData ? 'tagged' : 'sample_fallback'
      taggedCount = jobAttrs.results?.length || 0
      
      sampleJobs = useDbData
        ? jobAttrs.results!.map(j => ({
            job_id: j.job_id,
            job_name: j.job_name,
            base_like: Math.round((j.wlb + j.growth + j.stability + j.income) / 4),
            base_can: Math.round((j.teamwork + (j.analytical * 0.7) + j.creative) / 3),
            base_risk: 10,
            attributes: {
              wlb: j.wlb,
              growth: j.growth,
              stability: j.stability,
              income: j.income,
              remote: j.remote_possible === 'full' ? 100 : j.remote_possible === 'partial' ? 50 : 0,
              solo_work: j.solo_deep,
              people_facing: j.people_facing,
              analytical: j.analytical,
              creative: j.creative,
            },
          }))
        : getSampleJobs()
    }
  } else {
    // Vectorize 없이 기존 방식
    const jobAttrs = await db.prepare(`
      SELECT 
        job_id, job_name,
        wlb, growth, stability, income,
        teamwork, solo_deep, analytical, creative, execution, people_facing,
        work_hours, shift_work, travel, remote_possible,
        degree_required, license_required
      FROM job_attributes
      WHERE tagger_version = 'tagger-v1.0.0'
      LIMIT 80
    `).all<{
      job_id: string
      job_name: string
      wlb: number
      growth: number
      stability: number
      income: number
      teamwork: number
      solo_deep: number
      analytical: number
      creative: number
      execution: number
      people_facing: number
      work_hours: string
      shift_work: string
      travel: string
      remote_possible: string
      degree_required: string
      license_required: string
    }>()
    
    const useDbData = jobAttrs.results && jobAttrs.results.length > 0
    candidateSource = useDbData ? 'tagged' : 'sample_fallback'
    taggedCount = jobAttrs.results?.length || 0
    
    sampleJobs = useDbData
      ? jobAttrs.results!.map(j => ({
          job_id: j.job_id,
          job_name: j.job_name,
          base_like: Math.round((j.wlb + j.growth + j.stability + j.income) / 4),
          base_can: Math.round((j.teamwork + (j.analytical * 0.7) + j.creative) / 3),
          base_risk: 10,
          attributes: {
            wlb: j.wlb,
            growth: j.growth,
            stability: j.stability,
            income: j.income,
            remote: j.remote_possible === 'full' ? 100 : j.remote_possible === 'partial' ? 50 : 0,
            solo_work: j.solo_deep,
            people_facing: j.people_facing,
            analytical: j.analytical,
            creative: j.creative,
          },
        }))
      : getSampleJobs()
  }
  
  // 2. Fact boosts 계산
  const factBoosts = calculateFactBoosts(facts)
  
  // 3. 각 직업에 점수 적용
  const scoredJobs: ScoredJob[] = sampleJobs.map(job => {
    const baseScores: JobScores = {
      like: job.base_like,
      can: job.base_can,
      risk_penalty: job.base_risk,
    }
    
    const adjusted = applyFactBoostsToJob(baseScores, job.attributes, factBoosts)
    const fit = Math.round(0.5 * adjusted.like + 0.5 * adjusted.can - adjusted.risk_penalty)
    
    return {
      job_id: job.job_id,
      job_name: job.job_name,
      scores: {
        fit: Math.max(0, fit),
        like: adjusted.like,
        can: adjusted.can,
        risk_penalty: adjusted.risk_penalty,
      },
      attributes: job.attributes,
    }
  })
  
  // 4. 정렬 (Fit 기준)
  scoredJobs.sort((a, b) => b.scores.fit - a.scores.fit)
  
  const top10 = scoredJobs.slice(0, 10)
  
  // Phase 4: Diversity Guard (Research Bias 방지 + 다양성 확보)
  const rawTop3 = top10.slice(0, 3)
  const diversityResult = applyDiversityGuard(rawTop3, scoredJobs)
  const top3 = diversityResult.adjusted
  
  // 5. Follow-up 질문 생성 (Stage-aware)
  const existingFactKeys = facts.map(f => ({ fact_key: f.fact_key }))
  
  let followupQuestions: FollowupQuestion[]
  if (stage) {
    // V3: Stage 기반 질문 생성
    followupQuestions = generateStageBasedFollowups(
      scoredJobs,
      top10,
      existingFactKeys,
      stage,
      !!deepIntake
    )
  } else {
    // V2 fallback: 기존 방식
    followupQuestions = generateFollowupQuestions({
      candidates: scoredJobs,
      topK: top10,
      existingFacts: existingFactKeys,
      hasDeepIntake: !!deepIntake,
    }, 3)
  }
  
  // 6. User Insight 생성 (Stage-aware)
  const userInsight = stage
    ? generateStageAwareInsight(facts, deepIntake, factBoosts.applied_rules, stage)
    : generateUserInsight(facts, deepIntake, factBoosts.applied_rules)
  
  // 7. 입력 정보 정리
  const lifeConstraints = extractLifeConstraints(facts)
  const universalFactsCount = facts.filter(f => f.fact_key.startsWith('profile.')).length
  const confirmedConstraints = facts
    .filter(f => f.fact_key.startsWith('confirmed_constraint.'))
    .map(f => f.fact_key.replace('confirmed_constraint.', ''))
  
  // Legacy profile 추출 (V2 호환)
  const legacyProfile = 'profile' in payload && payload.profile
    ? payload.profile
    : { interest: { keywords: [] }, value: { priority: [] }, skill: [], dislike: { keywords: [] }, constraints: {} }
  
  // 8. 결과 구성
  const result: AnalysisResultJSON = {
    engine_state: stage 
      ? 'phase2_stage_based'  // V3: Stage-based 분석
      : (deepIntake ? 'phase1a_mve' : (facts.length > 0 ? 'phase1a_mve' : 'phase1a_initial')),
    
    versions: {
      recipe: VERSIONS.recipe,
      tagger: VERSIONS.tagger,
      scoring: VERSIONS.scoring,
    },
    
    input_summary: {
      profile_revision_id: `rev-${requestId}-${Date.now()}`,
      key_interests: legacyProfile.interest?.keywords?.slice(0, 3) || [],
      key_skills: legacyProfile.skill?.map(s => s.name).slice(0, 3) || [],
      non_negotiables: Object.entries(legacyProfile.constraints || {})
        .filter(([_, v]) => v === true)
        .map(([k]) => k),
      preferences: [],
      facts_applied: facts.length,
      applied_rules: factBoosts.applied_rules,
      deep_intake_provided: !!deepIntake,
      insight_tags: userInsight?.key_traits.map(t => t.trait) || [],
      // V3 추가 필드
      stage: stage,
      universal_facts_count: universalFactsCount,
      life_constraints: lifeConstraints,
      confirmed_constraints: confirmedConstraints,
    },
    
    fit_top3: top3.map(j => {
      // Evidence 생성 (facts + job attributes 기반)
      // ⚠️ Evidence는 "설명용"이며 점수 계산에 영향 없음
      const evidenceFacts: EvidenceFact[] = facts.map(f => ({
        fact_key: f.fact_key,
        value_json: f.value_json,
      }))
      let evidenceLinks = buildEvidenceLinks(evidenceFacts, j)
      
      // Evidence가 부족하면 기본 Evidence 추가
      if (evidenceLinks.length < 3) {
        const defaultEvidence = generateDefaultEvidence(j)
        evidenceLinks = [...evidenceLinks, ...defaultEvidence].slice(0, 10)
      }
      
      return {
        job_id: j.job_id,
        job_name: j.job_name,
        fit_score: j.scores.fit,
        like_score: j.scores.like,
        can_score: j.scores.can,
        risk_details: [],
        evidence_links: evidenceLinks,
      }
    }),
    
    like_top10: top10.map(j => ({
      job_id: j.job_id,
      job_name: j.job_name,
      like_score: j.scores.like,
    })),
    
    can_top10: top10.map(j => ({
      job_id: j.job_id,
      job_name: j.job_name,
      can_score: j.scores.can,
    })),
    
    caution_jobs: scoredJobs
      .filter(j => j.scores.risk_penalty > 20)
      .slice(0, 5)
      .map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        risk_penalty: j.scores.risk_penalty,
      })),
    
    followup_questions: followupQuestions,
    
    ux_flags: {
      has_caution_in_top3: top3.some(j => j.scores.risk_penalty > 20),
      has_unknown_in_top3: false,
      needs_followup_question: followupQuestions.length > 0,
      counts_before_filter: {
        safe_known: scoredJobs.filter(j => j.scores.risk_penalty <= 10).length,
        safe_unknown: scoredJobs.filter(j => j.scores.risk_penalty > 10 && j.scores.risk_penalty <= 20).length,
        caution: scoredJobs.filter(j => j.scores.risk_penalty > 20).length,
        total: scoredJobs.length,
      },
      counts_after_filter: {
        safe_known: scoredJobs.filter(j => j.scores.risk_penalty <= 10).length,
        safe_unknown: scoredJobs.filter(j => j.scores.risk_penalty > 10 && j.scores.risk_penalty <= 20).length,
        caution: scoredJobs.filter(j => j.scores.risk_penalty > 20).length,
        total: scoredJobs.length,
      },
    },
    
    llm_explanation: generateExplanation(facts, factBoosts.applied_rules, top3[0]?.job_name),
    generated_at: new Date().toISOString(),
    total_candidates: scoredJobs.length,
    
    user_insight: userInsight,
    
    // Phase 4: Diversity Guard 정보
    phase4_applied: true,
    diversity_guard_active: diversityResult.diversityApplied,
    diversity_changes: diversityResult.changes,
    
    // V3: Stage 기반 분석 정보
    analysis_stage: stage,
    stage_specific_insights: stage ? generateStageInsights(stage, facts) : undefined,
    
    // Debug info (only included when debugMode=true)
    debug_info: debugMode ? generateDebugInfo(
      candidateSource,
      taggedCount,
      sampleJobs.length,
      top3,
      sampleJobs,
      factBoosts,
      facts,
      followupQuestions[0],
      diversityResult
    ) : undefined,
  }
  
  return result
}

// ============================================
// Debug Info Generator (for test UI)
// ============================================
interface SampleJobWithBase {
  job_id: string
  job_name: string
  base_like: number
  base_can: number
  base_risk: number
  attributes: Record<string, number>
}

function generateDebugInfo(
  candidateSource: 'tagged' | 'sample_fallback' | 'vector' | 'random',
  taggedCount: number,
  totalInDb: number,
  top3: ScoredJob[],
  sampleJobs: SampleJobWithBase[],
  factBoosts: { like_boost: number; can_boost: number; risk_boost: number; applied_rules: string[] },
  facts: Fact[],
  firstFollowup: FollowupQuestion | undefined,
  diversityResult: { diversityApplied: boolean; changes: string[] }
): DebugInfo {
  // Score breakdown for TOP3
  const scoreBreakdown = top3.map(job => {
    const baseJob = sampleJobs.find(s => s.job_id === job.job_id)
    const baseLike = baseJob?.base_like || 50
    const baseCan = baseJob?.base_can || 50
    const baseRisk = baseJob?.base_risk || 10
    
    // Calculate boosts per rule (simplified)
    const likeBoosts = factBoosts.applied_rules
      .filter(r => r.includes('interest') || r.includes('priority') || r.includes('value'))
      .map(r => ({ rule: r, delta: Math.round(factBoosts.like_boost / Math.max(1, factBoosts.applied_rules.length)) }))
    
    const canBoosts = factBoosts.applied_rules
      .filter(r => r.includes('workstyle') || r.includes('strength') || r.includes('skill'))
      .map(r => ({ rule: r, delta: Math.round(factBoosts.can_boost / Math.max(1, factBoosts.applied_rules.length)) }))
    
    const riskBoosts = factBoosts.applied_rules
      .filter(r => r.includes('constraint') || r.includes('dislike'))
      .map(r => ({ rule: r, delta: factBoosts.risk_boost }))
    
    return {
      job_id: job.job_id,
      job_name: job.job_name,
      base_like: baseLike,
      base_can: baseCan,
      base_risk: baseRisk,
      like_boosts: likeBoosts,
      can_boosts: canBoosts,
      risk_boosts: riskBoosts,
      final_like: job.scores.like,
      final_can: job.scores.can,
      final_risk: job.scores.risk_penalty,
      final_fit: job.scores.fit,
    }
  })
  
  // Applied facts summary
  const appliedFacts = facts.slice(0, 10).map(f => {
    let valueStr = ''
    try {
      const parsed = JSON.parse(f.value_json)
      valueStr = Array.isArray(parsed.value) ? parsed.value.join(', ') : String(parsed.value || '')
    } catch {
      valueStr = f.value_json
    }
    return {
      fact_key: f.fact_key,
      value: valueStr.slice(0, 50),
      effect: factBoosts.applied_rules.includes(f.fact_key) ? 'applied' : 'stored',
    }
  })
  
  // Followup rationale
  const followupRationale = firstFollowup ? {
    split_attribute: firstFollowup.affects_attributes?.[0] || firstFollowup.constraint || 'unknown',
    split_gain: 0.5, // Placeholder - actual splitGain calculation is complex
    reason: firstFollowup.context || 'TOP3 직업 간 분별력 향상',
  } : undefined
  
  return {
    candidate_source: candidateSource,
    tagged_count: taggedCount,
    total_in_db: totalInDb,
    score_breakdown: scoreBreakdown,
    followup_rationale: followupRationale,
    applied_facts: appliedFacts,
    versions: {
      recipe: VERSIONS.recipe,
      tagger: VERSIONS.tagger,
      scoring: VERSIONS.scoring,
      embedding: 'none', // Will be updated when Vectorize is implemented
    },
    diversity_guard_triggered: diversityResult.diversityApplied,
    research_bias_cap_applied: diversityResult.changes.some(c => c.includes('Research')),
  }
}

// V3: Stage별 맞춤 인사이트 생성
function generateStageInsights(stage: AnalysisStage, facts: Fact[]): string[] {
  const insights: string[] = []
  
  switch (stage) {
    case 'job_explore':
      insights.push('탐색 단계: 다양한 직업군을 폭넓게 검토하고 있습니다.')
      if (facts.some(f => f.fact_key.includes('interest'))) {
        insights.push('관심 분야를 기반으로 추천이 조정되었습니다.')
      }
      break
    case 'job_student':
      insights.push('학생 단계: 전공·진로 연계성이 반영되었습니다.')
      if (facts.some(f => f.fact_key.includes('constraints'))) {
        insights.push('자격·시간 제약이 고려되었습니다.')
      }
      break
    case 'job_early':
      insights.push('초기 경력 단계: 성장 가능성이 강조되었습니다.')
      if (facts.some(f => f.fact_key.includes('dislike'))) {
        insights.push('기피 요소가 제외 필터에 반영되었습니다.')
      }
      break
    default:
      break
  }
  
  return insights
}

// ============================================
// Stage-based Follow-up 질문 생성
// ============================================
function generateStageBasedFollowups(
  candidates: ScoredJob[],
  topK: ScoredJob[],
  existingFacts: { fact_key: string }[],
  stage: AnalysisStage,
  hasDeepIntake: boolean
): FollowupQuestion[] {
  // Stage에 맞는 질문 풀 가져오기
  const stageQuestions = getQuestionsForStage(stage)
  
  // 이미 답변한 fact_key 제외
  const answeredKeys = new Set(existingFacts.map(f => f.fact_key))
  const availableQuestions = stageQuestions.filter(q => !answeredKeys.has(q.fact_key))
  
  if (availableQuestions.length === 0) {
    // Stage 질문이 없으면 기존 방식으로 fallback
    return generateFollowupQuestions({
      candidates,
      topK,
      existingFacts,
      hasDeepIntake,
    }, 3)
  }
  
  // 정보이득 점수 계산 (간단 버전)
  const scoredQuestions = availableQuestions.map(q => {
    let score = 0
    
    // 1. 타입별 기본 점수
    if (q.type === 'behavior' && !hasDeepIntake) score += 10
    if (q.type === 'tradeoff') score += 8
    if (q.type === 'projection') score += 6
    if (q.type === 'scenario') score += 5
    if (q.type === 'narrative' && hasDeepIntake) score += 7
    
    // 2. TOP10 차별화 가능성
    const affectedAttrs = q.affects_attributes
    const attrVariance = calculateAttributeVariance(topK, affectedAttrs)
    score += attrVariance * 2
    
    return { question: q, score }
  })
  
  // 점수 기준 정렬
  scoredQuestions.sort((a, b) => b.score - a.score)
  
  // 상위 3~5개 선택
  const maxQuestions = hasDeepIntake ? 3 : 5
  const selected = scoredQuestions.slice(0, maxQuestions)
  
  // FollowupQuestion 형식으로 변환
  return selected.map(sq => ({
    id: sq.question.question_id,
    type: sq.question.type as any,
    question: getQuestionText(sq.question, stage),
    context: `Stage: ${stage}`,
    options: sq.question.options.map(o => ({
      value: o.value,
      label: o.label,
      tags: o.tags,
    })),
    fact_key: sq.question.fact_key,
    affects_attributes: sq.question.affects_attributes,
  }))
}

// 속성 분산 계산 (TOP10 간 차이)
function calculateAttributeVariance(jobs: ScoredJob[], attrs: string[]): number {
  if (jobs.length === 0 || attrs.length === 0) return 0
  
  let totalVariance = 0
  for (const attr of attrs) {
    const values = jobs.map(j => {
      const attrValue = (j.attributes as any)[attr]
      return typeof attrValue === 'number' ? attrValue : 50
    })
    
    const mean = values.reduce((a, b) => a + b, 0) / values.length
    const variance = values.reduce((sum, v) => sum + Math.pow(v - mean, 2), 0) / values.length
    totalVariance += Math.sqrt(variance)
  }
  
  return totalVariance / attrs.length
}

// ============================================
// Stage-aware User Insight 생성
// ============================================
function generateStageAwareInsight(
  facts: Fact[],
  deepIntake: NormalizedDeepIntake | undefined,
  appliedRules: string[],
  stage: AnalysisStage
): UserInsight | undefined {
  // 기본 인사이트 생성
  const baseInsight = generateUserInsight(facts, deepIntake, appliedRules)
  
  if (!baseInsight) {
    // facts가 없어도 stage 기반 기본 메시지
    const wording = INSIGHT_WORDING[stage]
    return {
      summary: '더 많은 정보를 입력하시면 맞춤 인사이트를 드릴 수 있어요.',
      key_traits: [],
      applied_facts: [],
    }
  }
  
  // Stage별 wording 적용
  const wording = INSIGHT_WORDING[stage]
  
  // 요약 문장 재생성
  const topTraits = baseInsight.key_traits.slice(0, 3).map(t => t.trait)
  let summary = ''
  
  if (topTraits.length > 0) {
    summary = `${wording.summary_prefix}${topTraits.join(', ')} 성향이 보입니다.`
  } else if (baseInsight.applied_facts.length > 0) {
    summary = `${baseInsight.applied_facts.length}개의 답변을 분석하여 맞춤 추천을 제공했습니다.`
  } else {
    summary = '더 많은 정보를 입력하시면 더 정확한 인사이트를 드릴 수 있어요.'
  }
  
  // evidence 라벨 업데이트
  const updatedTraits = baseInsight.key_traits.map(trait => ({
    ...trait,
    evidence: trait.evidence.includes('선택') 
      ? trait.evidence.replace('선택', wording.evidence_label)
      : trait.evidence,
  }))
  
  return {
    summary,
    key_traits: updatedTraits,
    applied_facts: baseInsight.applied_facts,
  }
}

// Life constraints 추출
function extractLifeConstraints(facts: Fact[]): string[] {
  const lifeConstraintFact = facts.find(f => f.fact_key === 'profile.life_constraint')
  if (!lifeConstraintFact) return []
  
  try {
    const value = JSON.parse(lifeConstraintFact.value_json)
    return Array.isArray(value.value) ? value.value : [value.value]
  } catch {
    return []
  }
}

// ============================================
// V3 Premium Report API
// ============================================
analyzerRoutes.post('/v3/report', async (c) => {
  const env = c.env as { DB: D1Database }
  const db = env.DB
  
  try {
    const body = await c.req.json<{
      request_id: number
      session_id?: string
    }>()
    
    // request_id로 분석 결과 조회
    const requestRow = await db.prepare(`
      SELECT request_id, request_payload, result_json
      FROM ai_analysis_requests
      WHERE request_id = ?
    `).bind(body.request_id).first<{
      request_id: number
      request_payload: string
      result_json: string | null
    }>()
    
    if (!requestRow) {
      return c.json({ 
        error: 'NOT_FOUND',
        message: '분석 결과를 찾을 수 없습니다'
      }, 404)
    }
    
    if (!requestRow.result_json) {
      return c.json({
        error: 'NOT_READY',
        message: '분석이 아직 완료되지 않았습니다'
      }, 400)
    }
    
    // 분석 결과 파싱
    const analysisResult = JSON.parse(requestRow.result_json)
    
    // facts 조회
    const factsResult = await db.prepare(`
      SELECT fact_key, value_json
      FROM raw_events
      WHERE session_id = ?
      ORDER BY created_at DESC
    `).bind(body.session_id || `session-${body.request_id}`).all<{
      fact_key: string
      value_json: string
    }>()
    
    const facts = factsResult.results || []
    
    // 추천 결과를 ScoredJobForEvidence 형태로 변환
    const recommendations: ScoredJobForEvidence[] = (analysisResult.fit_top3 || []).map((job: any) => ({
      job_id: job.job_id,
      job_name: job.job_name,
      scores: {
        fit: job.fit_score || 50,
        like: job.like_score || 50,
        can: job.can_score || 50,
        risk_penalty: 0,
      },
      attributes: {
        wlb: 50,
        growth: 50,
        stability: 50,
        income: 50,
        ...job.attributes,
      },
    }))
    
    // Premium Report 생성
    const sessionId = body.session_id || `session-${body.request_id}`
    const reportInput: PremiumReportInput = {
      session_id: sessionId,
      facts: facts.map(f => ({
        fact_key: f.fact_key,
        value_json: f.value_json,
      })),
      recommendations,
      userInsight: analysisResult.user_insight,
      stage: analysisResult.input_summary?.stage,
    }
    
    const premiumReport = generatePremiumReport(reportInput)
    
    // ============================================
    // User Profile 스냅샷 저장 (P1 기능)
    // ============================================
    try {
      // 이전 스냅샷 조회
      const previousSnapshot = await getLatestProfileSnapshot(db, sessionId)
      
      // 프로필 빌드
      const profile = await buildProfileFromTurns(db, sessionId, previousSnapshot?.profile)
      
      // 스냅샷 저장
      await saveProfileSnapshot(
        db,
        sessionId,
        undefined, // user_id는 세션에서 가져올 수 있으면 추가
        body.request_id,
        premiumReport.report_id,
        'premium_report',
        profile,
        previousSnapshot?.id
      )
      
      console.log(`[V3 Report] Profile snapshot saved for session: ${sessionId}`)
    } catch (profileError) {
      // 프로필 저장 실패해도 보고서는 반환 (graceful degradation)
      console.error('[V3 Report] Profile snapshot save failed:', profileError)
    }
    
    return c.json({
      success: true,
      report: premiumReport,
    })
    
  } catch (error) {
    console.error('[V3 Report] Error:', error)
    return c.json({
      error: 'INTERNAL_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// V3 Purpose-based Followup API
// ============================================
analyzerRoutes.post('/v3/followup-questions', async (c) => {
  const env = c.env as { DB: D1Database }
  const db = env.DB
  
  try {
    const body = await c.req.json<{
      request_id: number
      session_id?: string
    }>()
    
    // 기존 분석 결과 조회
    const requestRow = await db.prepare(`
      SELECT result_json
      FROM ai_analysis_requests
      WHERE request_id = ?
    `).bind(body.request_id).first<{ result_json: string | null }>()
    
    if (!requestRow?.result_json) {
      return c.json({
        error: 'NOT_FOUND',
        message: '분석 결과를 찾을 수 없습니다'
      }, 404)
    }
    
    const analysisResult = JSON.parse(requestRow.result_json)
    
    // facts 조회
    const factsResult = await db.prepare(`
      SELECT fact_key, value_json
      FROM raw_events
      WHERE session_id = ?
    `).bind(body.session_id || `session-${body.request_id}`).all<{
      fact_key: string
      value_json: string
    }>()
    
    const facts = factsResult.results || []
    
    // 추천 결과 변환
    const topK = (analysisResult.fit_top3 || []).map((job: any) => ({
      job_id: job.job_id,
      job_name: job.job_name,
      scores: {
        fit: job.fit_score || 50,
        like: job.like_score || 50,
        can: job.can_score || 50,
        risk_penalty: 0,
      },
      attributes: {
        wlb: 50,
        growth: 50,
        stability: 50,
        income: 50,
        people_facing: 50,
        remote_possible: 50,
        ...job.attributes,
      },
    }))
    
    // Purpose-based Followup 생성
    const input: PurposeBasedFollowupInput = {
      candidates: topK,
      topK,
      facts,
      maxQuestions: 3,
    }
    
    const followupQuestions = generatePurposeBasedFollowups(input)
    
    return c.json({
      success: true,
      followup_questions: followupQuestions,
      question_count: followupQuestions.length,
    })
    
  } catch (error) {
    console.error('[V3 Followup Questions] Error:', error)
    return c.json({
      error: 'INTERNAL_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// Mount Tagger Routes
// ============================================
analyzerRoutes.route('/tagger', taggerRoutes)

export { analyzerRoutes }
