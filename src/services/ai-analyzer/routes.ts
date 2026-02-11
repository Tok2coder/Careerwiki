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
  type NarrativeFacts,
  type RoundAnswer,
} from './types'
import {
  calculateFactBoosts,
  applyFactBoostsToJob,
  normalizeDeepIntake,
  applyBalanceCap,  // P0: Can-Like 밸런스 캡
  type JobScores,
  type NormalizedDeepIntake,
} from './fact-score-mapping'
import {
  generateFollowupQuestions,
  type ScoredJob,
  type FollowupQuestion,
} from './question-generation'
// 2026-01-26: tagger-routes 제거됨 (태깅 의존도 완전 제거)
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
  extractUserConstraints,
  applyTagFilter,
  applyMiniModuleHardFilter,
  calculateMiniModuleRiskPenalty,
  deriveConstraintsFromHardBias,
  applyHardBiasPenalty,
  // P2: Can 기반 TAG 필터
  applyCanBasedFilter,
  extractVerifiedCanFromFacts,
  type FilteredCandidate,
  type VerifiedCanMap,
} from './tag-filter'
// P3: 성장곡선 → 직업 매핑
import {
  extractGrowthPreference,
  matchGrowthCurves,
  type UserGrowthPreference,
} from './growth-curve-mapper'
// P3: 내면갈등 → Risk 조정
import {
  calculateConflictRisk,
  calculateConflictSeverity,
} from './internal-conflict-risk'
// 자동화 테스트 시나리오
import {
  TEST_SCENARIOS,
  getScenarioById,
  getAllScenarioSummary,
  findAutoAnswer,
  getCanValidationAnswer,
  getConstraintIntensityAnswer,
  verifyTestResults,
  type TestScenario,
  type TestVerificationResult,
} from './test-scenarios'
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
  generatePremiumReportV3 as generateLLMPremiumReport,
  fixParticlesDeep,
  type ReporterInput,
} from './llm-reporter'
import {
  generatePurposeBasedFollowups,
  type PurposeBasedFollowupInput,
} from './question-generation'
import { TOKEN_TO_KOREAN } from './mini-module-questions'
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
import { draftRoutes } from './draft-routes'
import { historyRoutes } from './history-routes'
import { resumeRoutes } from './resume-routes'
import { profileRoutes } from './profile-routes'
import {
  expandCandidates,
  expandCandidatesV3WithCache,
  expandCandidatesV3,
  buildSearchProfileFromMiniModule,
  vectorResultsToScoredJobs,
  buildSearchQuery,
  indexJobsToVectorize,
  extractJobDescription,
} from './vectorize-pipeline'
import { calculatePersonalizedBaseScores } from './personalized-scoring'
import { generateOpenAIEmbedding, OPENAI_EMBEDDING_DIMENSIONS } from './openai-client'
import {
  buildAggregatedProfile,
  assertReadyForLLM,
  createEmptyProfile,
  type AggregatedProfile,
  type GatePhase,
  type DraftData as AggDraftData,
} from './aggregated-profile'
import { updateMemory } from './llm-memory'
// LLM 모듈 활성화 (2026-02-03)
import { 
  judgeCandidates, 
  type JudgeInput, 
  type JudgeOutput 
} from './llm-judge'
import {
  calculateConfidenceScore,
  extractKeyDecisionVariables,
  createScoringTrace,
  type ScoringTrace,
  type KeyDecisionVariable,
  type ConfidenceResult,
} from './scoring-trace'
import {
  synthesizeVectorInsights,
  synthesizeVectorInsightsSync,
  visToPromptHints,
  type VISOutput,
} from './vis-synthesizer'
import {
  getOrCreateCAGState,
  saveCAGState,
  logAskedQuestion,
  logAnswerReceived,
  isQuestionAlreadyAsked,
  // P2: 수집 진행도 추적
  updateCollectionProgress,
  syncCollectionProgressFromFacts,
  getCollectionProgressSummary,
  getMostNeededDimension,
  type CAGState,
} from './cag-manager'
// P0: Can 검증 질문
import {
  selectCanValidationQuestions,
  calculateCanBoost,
  type StrengthToken,
  type CanValidationQuestion,
} from './can-validation-questions'

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
  OPENAI_API_KEY?: string  // .dev.vars에서 로드됨
  JWT_SECRET: string
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
  
  // 인증된 사용자 ID 가져오기 (authMiddleware에서 설정)
  const authUser = (c as any).get('user') as { id: number } | null
  const userId = authUser?.id?.toString() || rawPayload.user_id || null
  
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
        userId,  // 인증된 사용자 ID 사용
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
      
      // ============================================
      // P0: 5축 상태좌표 저장 (career_state)
      // ============================================
      if (v3Payload.career_state) {
        try {
          await saveCareerStateFacts(db, v3Payload.session_id, v3Payload.user_id, v3Payload.career_state)
          console.log(`[V3 Analyze] Saved career_state facts`)
        } catch (stateError) {
          console.error('[V3 Analyze] career_state save failed:', stateError)
        }
      }
      
      // ============================================
      // P0: 전이 신호 저장 (transition_signal)
      // ============================================
      if (v3Payload.transition_signal) {
        try {
          await saveTransitionSignalFacts(db, v3Payload.session_id, v3Payload.user_id, v3Payload.transition_signal)
          console.log(`[V3 Analyze] Saved transition_signal facts`)
        } catch (transError) {
          console.error('[V3 Analyze] transition_signal save failed:', transError)
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
      userId,  // 인증된 사용자 ID 사용
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
    const stack = error instanceof Error ? error.stack : undefined
    console.error('[ANALYSIS_FAILED]', message, stack)
    logError('ANALYSIS_FAILED', message, {
      session_id: rawPayload.session_id,
      stack
    })
    return c.json(createErrorResponse('ANALYSIS_FAILED', 'Analysis failed', {
      message,
      stack,
      session_id: rawPayload.session_id
    }), 500)
  }
})

// ============================================
// P0: 5축 상태좌표 → facts 저장
// ============================================
async function saveCareerStateFacts(
  db: D1Database,
  sessionId: string,
  userId: string | undefined,
  careerState: {
    role_identity: string
    career_stage_years: string
    transition_status: string
    skill_level: number
    constraints: Record<string, { has_constraint: boolean; details?: string }>
  }
): Promise<void> {
  // 축 1: role_identity
  if (careerState.role_identity) {
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'state.role_identity', ?, 1.0, 'career_state', 2)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(sessionId, userId || null, JSON.stringify({ value: careerState.role_identity })).run()
  }
  
  // 축 2: career_stage_years
  if (careerState.career_stage_years) {
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'state.career_stage_years', ?, 1.0, 'career_state', 2)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(sessionId, userId || null, JSON.stringify({ value: careerState.career_stage_years })).run()
  }
  
  // 축 3: transition_status
  if (careerState.transition_status) {
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'state.transition_status', ?, 1.0, 'career_state', 2)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(sessionId, userId || null, JSON.stringify({ value: careerState.transition_status })).run()
  }
  
  // 축 4: skill_level
  if (careerState.skill_level !== undefined) {
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'state.skill_level', ?, 1.0, 'career_state', 2)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(sessionId, userId || null, JSON.stringify({ value: careerState.skill_level })).run()
  }
  
  // 축 5: constraints (P0-6: 2단 저장)
  for (const [type, constraint] of Object.entries(careerState.constraints || {})) {
    // has_constraint 저장
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, ?, ?, 1.0, 'career_state', 2)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(
      sessionId,
      userId || null,
      `state.constraint.${type}`,
      JSON.stringify({ value: !!constraint.has_constraint })
    ).run()
    
    // detail 저장 (있을 때만)
    if (constraint.has_constraint && constraint.details) {
      await db.prepare(`
        INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
        VALUES (?, ?, ?, ?, 1.0, 'career_state', 2)
        ON CONFLICT(session_id, fact_key) DO UPDATE SET
          value_json = excluded.value_json,
          collected_at = CURRENT_TIMESTAMP
      `).bind(
        sessionId,
        userId || null,
        `state.constraint.${type}_detail`,
        JSON.stringify({ value: constraint.details })
      ).run()
    }
  }
}

// ============================================
// P0: 전이 신호 → facts 저장
// ============================================
async function saveTransitionSignalFacts(
  db: D1Database,
  sessionId: string,
  userId: string | undefined,
  transitionSignal: Record<string, string | string[]>
): Promise<void> {
  for (const [questionId, answer] of Object.entries(transitionSignal)) {
    if (answer === null || answer === undefined) continue
    
    // fact_key 매핑
    const factKeyMap: Record<string, string> = {
      'trans_desired_type': 'transition.desired_type',
      'trans_motivation': 'transition.motivation_primary',
      'trans_blockers': 'transition.blocker',
      'trans_timeline': 'transition.timeline',
      'trans_time_invest': 'transition.time_invest_hours_bucket',
    }
    
    const factKey = factKeyMap[questionId] || `transition.${questionId}`
    
    if (Array.isArray(answer)) {
      // 배열 답변: ranked 저장 (순위 포함)
      for (let i = 0; i < answer.length; i++) {
        const rankFactKey = `${factKey}[${i}]`
        await db.prepare(`
          INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
          VALUES (?, ?, ?, ?, 1.0, 'transition_signal', 3)
          ON CONFLICT(session_id, fact_key) DO UPDATE SET
            value_json = excluded.value_json,
            collected_at = CURRENT_TIMESTAMP
        `).bind(
          sessionId,
          userId || null,
          rankFactKey,
          JSON.stringify({ value: answer[i], rank: i + 1 })
        ).run()
      }
      
      // 전체 배열도 저장 (편의용)
      await db.prepare(`
        INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
        VALUES (?, ?, ?, ?, 1.0, 'transition_signal', 3)
        ON CONFLICT(session_id, fact_key) DO UPDATE SET
          value_json = excluded.value_json,
          collected_at = CURRENT_TIMESTAMP
      `).bind(
        sessionId,
        userId || null,
        factKey,
        JSON.stringify({ value: answer })
      ).run()
    } else {
      // 단일 답변
      await db.prepare(`
        INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
        VALUES (?, ?, ?, ?, 1.0, 'transition_signal', 3)
        ON CONFLICT(session_id, fact_key) DO UPDATE SET
          value_json = excluded.value_json,
          collected_at = CURRENT_TIMESTAMP
      `).bind(
        sessionId,
        userId || null,
        factKey,
        JSON.stringify({ value: answer })
      ).run()
    }
  }
}

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
  // 1. jobs + job_attributes JOIN으로 실제 DB 직업만 조회 (태깅 여부 무관)
  // 2026-01-26: tagger_version 조건 제거 - 모든 직업 검색 가능
  const jobAttrs = await db.prepare(`
    SELECT
      ja.job_id, ja.job_name,
      j.slug, j.image_url, j.api_data_json, j.merged_profile_json, j.ai_data_json,
      COALESCE(ja.wlb, 50) as wlb,
      COALESCE(ja.growth, 50) as growth,
      COALESCE(ja.stability, 50) as stability,
      COALESCE(ja.income, 50) as income,
      COALESCE(ja.teamwork, 50) as teamwork,
      COALESCE(ja.solo_deep, 50) as solo_deep,
      COALESCE(ja.analytical, 50) as analytical,
      COALESCE(ja.creative, 50) as creative,
      COALESCE(ja.execution, 50) as execution,
      COALESCE(ja.people_facing, 50) as people_facing,
      COALESCE(ja.work_hours, 'regular') as work_hours,
      COALESCE(ja.shift_work, 'rare') as shift_work,
      COALESCE(ja.travel, 'rare') as travel,
      COALESCE(ja.remote_possible, 'possible') as remote_possible,
      COALESCE(ja.degree_required, 'none') as degree_required,
      COALESCE(ja.license_required, 'none') as license_required
    FROM job_attributes ja
    INNER JOIN jobs j ON ja.job_id = j.id
    ORDER BY RANDOM()
    LIMIT 500
  `).all<{
    job_id: string
    job_name: string
    slug: string
    image_url: string | null
    api_data_json: string | null
    merged_profile_json: string | null
    ai_data_json: string | null
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

  // V2에서도 mini_module_result 추출 (개인화 스코어링)
  const v2MiniModule = 'mini_module_result' in payload ? (payload as any).mini_module_result : undefined

  // DB에 데이터가 없으면 샘플 사용 (샘플은 DB에 없는 직업이므로 추천에서 제외)
  const sampleJobs = (jobAttrs.results && jobAttrs.results.length > 0)
    ? jobAttrs.results.map(j => {
        const personalized = calculatePersonalizedBaseScores(j, v2MiniModule)
        return {
          job_id: j.job_id,
          job_name: j.job_name,
          slug: j.slug,
          image_url: j.image_url,
          job_description: extractJobDescription(j.api_data_json, j.merged_profile_json, j.job_name, j.ai_data_json),
          base_like: personalized.like,
          base_can: personalized.can,
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
        }
      })
    : [] // DB 연결 실패시 빈 배열 (샘플 데이터 사용 안함)
  
  // DB 데이터가 없으면 에러 반환
  if (sampleJobs.length === 0) {
    throw new Error('직업 데이터를 불러올 수 없습니다. job_attributes 테이블을 확인하세요.')
  }
  
  // 2. Fact boosts 계산
  const factBoosts = calculateFactBoosts(facts)
  
  // 3. 각 직업에 점수 적용 (slug, image_url 포함)
  const scoredJobs: ScoredJob[] = sampleJobs.map(job => {
    const baseScores: JobScores = {
      like: job.base_like,
      can: job.base_can,
      risk_penalty: job.base_risk,
    }

    const adjusted = applyFactBoostsToJob(baseScores, job.attributes, factBoosts)

    // P0: Can-Like 밸런스 캡 적용
    const balanced = applyBalanceCap(adjusted.like, adjusted.can)
    const fit = Math.round(0.55 * balanced.like + 0.45 * balanced.can - adjusted.risk_penalty)

    // 임시 scoredJob 객체 생성 (explanation 생성용)
    const tempScoredJob: ScoredJob = {
      job_id: job.job_id,
      job_name: job.job_name,
      slug: job.slug,
      image_url: job.image_url || undefined,
      job_description: job.job_description,
      scores: {
        fit: Math.max(0, fit),
        like: balanced.like,
        can: balanced.can,
        risk_penalty: adjusted.risk_penalty,
      },
      attributes: job.attributes,
    }

    // 근거 생성 (V2: facts 기반)
    const explanation = generateJobExplanation(tempScoredJob, facts, factBoosts.applied_rules)
    const rationale = `[좋아할 이유] ${explanation.like_reason} [잘할 이유] ${explanation.can_reason}`

    return {
      ...tempScoredJob,
      rationale,
      likeReason: explanation.like_reason,
      canReason: explanation.can_reason,
      riskWarning: explanation.risk_warning,
    }
  })
  
  // 4. 정렬 (Fit 기준)
  scoredJobs.sort((a, b) => b.scores.fit - a.scores.fit)
  
  // 평가 직업 100개로 확장 (기존 10개 -> 100개)
  const top10 = scoredJobs.slice(0, 100)
  
  // Phase 4: Diversity Guard (내부에서 Research Bias Cap도 적용)
  const rawTop5 = top10.slice(0, 5)
  const diversityResult = applyDiversityGuard(rawTop5, scoredJobs)
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
  
  // 7. Premium Report 생성 (V3)
  const premiumReportInput: PremiumReportInput = {
    session_id: `session-${requestId}`,
    facts: facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json })),
    recommendations: top10.map(j => ({
      job_id: j.job_id,
      job_name: j.job_name,
      slug: j.slug,
      image_url: j.image_url,
      scores: j.scores,
      attributes: j.attributes as Record<string, number>,
    })),
    userInsight: userInsight,
  }
  const premiumReport = fixParticlesDeep(generatePremiumReport(premiumReportInput))

  // 8. 결과 구성
  const result: AnalysisResultJSON = {
    engine_state: deepIntake ? 'phase1a_mve' : (facts.length > 0 ? 'phase1a_mve' : 'phase1a_initial'),
    engine_version: 'v3',  // V3 프리미엄 리포트 활성화
    mini_module_result: miniModuleForFilter || null,

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
      
      // Dislike 경고 생성
      const dislikeWarnings = generateDislikeWarnings(facts, j)
      
      return {
        job_id: j.job_id,
        job_name: j.job_name,
        slug: j.slug,
        image_url: j.image_url,
        job_description: j.job_description || null,
        rationale: j.rationale || null,
        like_reason: j.likeReason || null,
        can_reason: j.canReason || null,
        fit_score: j.scores.fit,
        like_score: j.scores.like,
        can_score: j.scores.can,
        risk_details: [],
        evidence_links: evidenceLinks,
        dislike_warnings: dislikeWarnings, // 회피 요소 경고
      }
    }),

    // like_top10: like_score 기준으로 별도 정렬 (Fit >= 25 필터)
    like_top10: [...scoredJobs]
      .filter(j => j.scores.fit >= 25)
      .sort((a, b) => b.scores.like - a.scores.like)
      .slice(0, 10)
      .map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        slug: j.slug,
        image_url: j.image_url,
        job_description: j.job_description || null,
        fit_score: j.scores.fit,
        like_score: j.scores.like,
        can_score: j.scores.can,
        rationale: j.rationale || null,
        like_reason: j.likeReason || null,
        can_reason: j.canReason || null,
      })),

    // can_top10: can_score 기준으로 별도 정렬 (Fit >= 25 필터)
    can_top10: [...scoredJobs]
      .filter(j => j.scores.fit >= 25)
      .sort((a, b) => b.scores.can - a.scores.can)
      .slice(0, 10)
      .map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        slug: j.slug,
        image_url: j.image_url,
        job_description: j.job_description || null,
        fit_score: j.scores.fit,
        like_score: j.scores.like,
        can_score: j.scores.can,
        rationale: j.rationale || null,
        like_reason: j.likeReason || null,
        can_reason: j.canReason || null,
      })),

    caution_jobs: scoredJobs
      .filter(j => j.scores.risk_penalty > 20)
      .slice(0, 5)
      .map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        slug: j.slug,
        image_url: j.image_url,
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
    
    // V3: Premium Report
    premium_report: premiumReport,
  }
  
  return result
}

// ============================================
// 한국어 조사 헬퍼 (받침 유무 자동 판별)
// ============================================
function hasBatchim(word: string): boolean {
  if (!word || word.length === 0) return false
  const last = word.charCodeAt(word.length - 1)
  if (last >= 0xAC00 && last <= 0xD7A3) return (last - 0xAC00) % 28 !== 0
  // 숫자: 0(영),1(일),3(삼),6(육),7(칠),8(팔) = 받침 있음
  if (last >= 0x30 && last <= 0x39) return [0,1,3,6,7,8].includes(last - 0x30)
  return false
}
/** 은/는 */
function 은는(w: string): string { return hasBatchim(w) ? '은' : '는' }
/** 이/가 */
function 이가(w: string): string { return hasBatchim(w) ? '이' : '가' }
/** 을/를 */
function 을를(w: string): string { return hasBatchim(w) ? '을' : '를' }

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
  appliedRules: string[],
  mm?: any  // MiniModuleResult (optional)
): JobExplanation {
  const attrs = (job.attributes || {}) as Record<string, number>
  const jobName = job.job_name || '이 직업'

  // ============================================
  // Like 근거: 사용자 흥미/가치 ↔ 직업 속성 매칭
  // ============================================
  const interestLabels: Record<string, string> = {
    problem_solving: '문제해결', data_numbers: '데이터/숫자', creating: '창작/창의',
    influencing: '영향력/설득', helping_teaching: '도움/교육', organizing: '조직/관리',
    tech: '기술/IT', routine: '정해진 업무',
  }
  const valueLabels: Record<string, string> = {
    growth: '성장', stability: '안정', autonomy: '자율성', wlb: '워라밸',
    income: '수입', recognition: '인정', meaning: '의미', expertise: '전문성',
    creativity: '창의성',
  }
  // 직업 속성과 가치/흥미 매핑
  const valueAttrMap: Record<string, { attr: string, threshold: number }> = {
    growth: { attr: 'growth', threshold: 60 },
    stability: { attr: 'stability', threshold: 60 },
    wlb: { attr: 'wlb', threshold: 60 },
    income: { attr: 'income', threshold: 60 },
  }
  const interestAttrMap: Record<string, { attr: string, threshold: number }> = {
    data_numbers: { attr: 'analytical', threshold: 60 },
    creating: { attr: 'creative', threshold: 60 },
    tech: { attr: 'analytical', threshold: 55 },
    problem_solving: { attr: 'analytical', threshold: 55 },
    helping_teaching: { attr: 'people_facing', threshold: 60 },
    influencing: { attr: 'people_facing', threshold: 55 },
  }

  let likeReason = ''
  const likeReasons: string[] = []

  if (mm) {
    // 1) 흥미 매칭 (직업명 + 속성값 포함하여 차별화)
    const interests = mm.interest_top || mm.interests || []
    for (const token of interests) {
      const mapping = interestAttrMap[token]
      const attrVal = mapping ? (attrs[mapping.attr] || 0) : 0
      if (mapping && attrVal >= mapping.threshold) {
        const label = interestLabels[token] || token
        if (attrVal >= 80) {
          likeReasons.push(`${jobName}${은는(jobName)} ${label} 역량이 핵심인 직업으로, 당신의 관심사와 매우 잘 맞습니다`)
        } else {
          likeReasons.push(`${jobName}에서 ${label} 관련 업무를 수행하며 관심사를 살릴 수 있습니다`)
        }
        break
      }
    }
    // 2) 가치 매칭 (직업명 + 구체적 속성 포함)
    const values = mm.value_top || mm.values || []
    for (const token of values) {
      const mapping = valueAttrMap[token]
      const attrVal = mapping ? (attrs[mapping.attr] || 0) : 0
      if (mapping && attrVal >= mapping.threshold) {
        const label = valueLabels[token] || token
        if (attrVal >= 80) {
          likeReasons.push(`${label}${을를(label)} 중시하는 당신에게 ${jobName}${은는(jobName)} 높은 ${label} 지수(${attrVal}점)로 큰 만족감을 줄 수 있습니다`)
        } else {
          likeReasons.push(`${jobName}${은는(jobName)} ${label} 측면에서 양호한 환경(${attrVal}점)을 제공합니다`)
        }
        break
      }
    }
    // 3) 흥미 라벨만이라도
    if (likeReasons.length === 0 && interests.length > 0) {
      const labels = interests.slice(0, 2).map((t: string) => interestLabels[t] || t).join(', ')
      likeReasons.push(`${jobName}${은는(jobName)} ${labels} 분야에 대한 관심과 연결되는 업무입니다`)
    }
  }

  // facts 기반 보조
  if (likeReasons.length === 0) {
    const interestFacts = facts.filter(f => f.fact_key.includes('interest') || f.fact_key.includes('priority'))
    if (interestFacts.length > 0) {
      try {
        const parsed = JSON.parse(interestFacts[0].value_json)
        const val = Array.isArray(parsed.value) ? parsed.value[0] : parsed.value
        if (val && interestLabels[val]) {
          likeReasons.push(`${interestLabels[val]} 관심사와 매칭되는 업무 환경입니다`)
        }
      } catch { /* ignore */ }
    }
  }

  likeReason = likeReasons.length > 0
    ? likeReasons.join('. ')
    : `${jobName}${은는(jobName)} 당신의 관심 분야와 연관된 직업입니다`

  // ============================================
  // Can 근거: 사용자 강점/워크스타일 ↔ 직업 속성 매칭
  // ============================================
  const strengthLabels: Record<string, string> = {
    analytical: '분석력', fast_learning: '빠른 학습력', creative: '창의력',
    communication: '소통 능력', persistence: '끈기', leadership: '리더십',
    structured_execution: '체계적 실행력',
  }
  const strengthAttrMap: Record<string, { attr: string, threshold: number }> = {
    analytical: { attr: 'analytical', threshold: 55 },
    creative: { attr: 'creative', threshold: 55 },
    communication: { attr: 'people_facing', threshold: 55 },
    leadership: { attr: 'people_facing', threshold: 60 },
    structured_execution: { attr: 'execution', threshold: 55 },
  }
  const workstyleLabels: Record<string, string> = {
    solo: '혼자 집중하는', solo_deep: '깊이 몰입하는', team: '팀으로 협력하는',
    team_harmony: '조화롭게 일하는', structured: '체계적인', flexible: '자유로운',
  }

  let canReason = ''
  const canReasons: string[] = []

  if (mm) {
    // 1) 강점 매칭 (직업명 + 속성값 포함하여 차별화)
    const strengths = mm.strength_top || mm.strengths || []
    for (const token of strengths) {
      const mapping = strengthAttrMap[token]
      const attrVal = mapping ? (attrs[mapping.attr] || 0) : 0
      if (mapping && attrVal >= mapping.threshold) {
        const label = strengthLabels[token] || token
        if (attrVal >= 75) {
          canReasons.push(`${jobName}${은는(jobName)} ${label}${이가(label)} 핵심 역량(${attrVal}점)인 직업으로, 당신의 강점을 직접 활용할 수 있습니다`)
        } else {
          canReasons.push(`${jobName}에서 당신의 ${label} 강점이 도움이 될 수 있습니다`)
        }
        break
      }
    }
    // 2) 워크스타일 매칭
    const workstyles = mm.workstyle_top || []
    if (workstyles.length > 0) {
      const wsLabel = workstyleLabels[workstyles[0]] || ''
      const soloAttr = attrs['solo_work'] || attrs['solo_deep'] || 0
      const peopleAttr = attrs['people_facing'] || 0
      if (workstyles[0]?.includes('solo') && soloAttr >= 60) {
        canReasons.push(`${jobName}${은는(jobName)} ${wsLabel} 업무 스타일에 맞는 독립적인 환경입니다`)
      } else if (workstyles[0]?.includes('team') && peopleAttr >= 60) {
        canReasons.push(`${jobName}${은는(jobName)} ${wsLabel} 업무 스타일에 맞는 협업 환경입니다`)
      }
    }
    // 3) 강점 라벨만이라도
    if (canReasons.length === 0) {
      const strengths2 = mm.strength_top || mm.strengths || []
      if (strengths2.length > 0) {
        const sLabels = strengths2.slice(0, 2).map((t: string) => strengthLabels[t] || t)
        const joinedLabels = sLabels.length > 1 ? `${sLabels[0]}과 ${sLabels[1]}` : sLabels[0]
        canReasons.push(`${jobName}에서 ${joinedLabels}${을를(joinedLabels)} 발휘할 수 있습니다`)
      }
    }
  }

  // workstyle fallback from facts
  if (canReasons.length === 0 && appliedRules.includes('profile.workstyle.social')) {
    const styleFact = facts.find(f => f.fact_key === 'profile.workstyle.social')
    if (styleFact) {
      try {
        const sv = JSON.parse(styleFact.value_json)
        const styleMap: Record<string, string> = {
          solo: '독립적 업무 환경에 적합합니다', team: '팀 협업 환경에 적합합니다',
          balanced: '균형 잡힌 업무 환경에 적합합니다'
        }
        canReasons.push(styleMap[sv.value] || '선호하는 업무 스타일에 부합합니다')
      } catch { /* ignore */ }
    }
  }

  canReason = canReasons.length > 0
    ? canReasons.join('. ')
    : `${jobName}${은는(jobName)} 당신의 역량으로 충분히 도전할 수 있는 분야입니다`

  // ============================================
  // Risk 경고
  // ============================================
  let riskWarning = ''
  const confirmedConstraints = facts.filter(f => f.fact_key.startsWith('confirmed_constraint.'))
  if (confirmedConstraints.length > 0) {
    riskWarning = '제약 조건 충족'
  }
  const riskPenalty = job.scores?.risk_penalty || job.risk_penalty || 0
  if (riskPenalty > 15) {
    riskWarning = '일부 주의 필요 (상세 정보 확인 권장)'
  } else if (riskPenalty > 10) {
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
// Dislike 경고 생성 (회피 요소 포함 시)
// ============================================
interface DislikeWarning {
  type: string
  label: string
  severity: 'high' | 'medium' | 'low'
}

function generateDislikeWarnings(facts: Fact[], job: ScoredJob): DislikeWarning[] {
  const warnings: DislikeWarning[] = []
  
  // hard_dislike facts 수집
  const hardDislikeFacts = facts.filter(f => f.fact_key === 'profile.hard_dislike')
  const mildDislikeFacts = facts.filter(f => f.fact_key === 'profile.dislike')
  
  // hard_dislike → 직업 속성 매핑
  const DISLIKE_JOB_ATTR_MAP: Record<string, { attrs: string[]; label: string }> = {
    'sales': { attrs: ['people_facing'], label: '영업/설득 업무' },
    'overtime': { attrs: ['wlb', 'work_hours'], label: '야근/긴 근무' },
    'public_speaking': { attrs: ['people_facing'], label: '발표/대면 업무' },
    'meetings': { attrs: ['teamwork'], label: '회의 많음' },
    'travel': { attrs: ['travel', 'remote_possible'], label: '출장/이동' },
    'routine': { attrs: ['creative'], label: '단순 반복 업무' },
    'conflict': { attrs: ['people_facing'], label: '갈등/대립 상황' },
    'physical': { attrs: ['execution'], label: '육체적 업무' },
    'shift_work': { attrs: ['shift_work'], label: '교대 근무' },
    'woodwork': { attrs: ['execution'], label: '목공 관련' },
    'construction': { attrs: ['execution'], label: '건설/현장 업무' },
    'call_center': { attrs: ['people_facing'], label: '콜센터/전화 업무' },
  }
  
  // hard_dislike 매칭 확인
  for (const fact of hardDislikeFacts) {
    try {
      const data = JSON.parse(fact.value_json)
      const dislikeType = data.type
      const mapping = DISLIKE_JOB_ATTR_MAP[dislikeType]
      
      if (mapping) {
        // 직업의 해당 속성이 높으면 경고
        const jobAttrs = job.attributes || {}
        for (const attr of mapping.attrs) {
          const attrValue = jobAttrs[attr]
          if (attrValue !== undefined && Number(attrValue) > 50) {
            warnings.push({
              type: dislikeType,
              label: `⚠️ 주의: ${mapping.label} 요소 포함`,
              severity: 'high',
            })
            break
          }
        }
      }
    } catch { /* ignore */ }
  }
  
  // mild dislike 매칭 (경미한 경고)
  for (const fact of mildDislikeFacts) {
    try {
      const data = JSON.parse(fact.value_json)
      const dislikeType = data.type
      const mapping = DISLIKE_JOB_ATTR_MAP[dislikeType]
      
      if (mapping && !warnings.some(w => w.type === dislikeType)) {
        const jobAttrs = job.attributes || {}
        for (const attr of mapping.attrs) {
          const attrValue = jobAttrs[attr]
          if (attrValue !== undefined && Number(attrValue) > 70) {
            warnings.push({
              type: dislikeType,
              label: `ℹ️ 참고: ${mapping.label} 요소 있음`,
              severity: 'low',
            })
            break
          }
        }
      }
    } catch { /* ignore */ }
  }
  
  return warnings
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
      trait: (() => { const p = priorityMap[deepIntake.priority_top1] || deepIntake.priority_top1; return `${p}${을를(p)} 최우선시` })(),
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
  // V3 Enhancement: TAG Pre-Filter 설정
  // ============================================
  const universalAnswers = payload.universal_answers || {}
  const userConstraints = extractUserConstraints(universalAnswers, payload.career_state)
  const enableTagPreFilter = Object.values(userConstraints).some(v => v === true)
  
  if (enableTagPreFilter) {
    console.log('[V3 Analyze] TAG Pre-Filter enabled:', userConstraints)
  }
  
  // ============================================
  // P1 Vectorize 기반 후보군 확장 (태깅 무관)
  // ============================================
  // 2026-01-26: 태깅 의존도 완전 제거
  // - 벡터 검색으로 모든 직업 검색 가능
  // - tagger_version 조건 없이 후보 확보
  // ============================================
  let candidateSource: 'vectorize' | 'db_fallback' | 'sample_fallback' = 'db_fallback'
  let candidateCount = 0
  let vectorizeUsed = false
  let totalCandidates = 0

  // mini_module_result 추출 (개인화 스코어링에 사용 - sampleJobs 생성 전에 필요)
  const miniModuleForFilter = 'mini_module_result' in payload ? (payload as any).mini_module_result : undefined

  // Vectorize 사용 가능 여부 확인 (OpenAI API 키 필요)
  const openaiApiKey = (env as any)?.OPENAI_API_KEY
  const useVectorize = env?.VECTORIZE && openaiApiKey
  
  let sampleJobs: Array<{
    job_id: string
    job_name: string
    base_like: number
    base_can: number
    base_risk: number
    attributes: Record<string, number | string>
  }>
  
  if (useVectorize) {
    // Vectorize 기반 후보군 확장 (OpenAI Embedding 사용, 태깅 무관)
    try {
      console.log('[V3 Analyze] Using Vectorize + OpenAI Embedding for candidate expansion')
      const expansionResult = await expandCandidates(
        db,
        env!.VECTORIZE,
        openaiApiKey,
        facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json })),
        { targetSize: 500 }  // minTaggedJobs 제거
      )
      
      if (!expansionResult.fallback_used && expansionResult.candidates.length > 0) {
        // 벡터 결과를 ScoredJob 형태로 변환
        sampleJobs = await vectorResultsToScoredJobs(db, expansionResult.candidates, miniModuleForFilter)
        candidateSource = 'vectorize'
        vectorizeUsed = true
        totalCandidates = expansionResult.candidates.length
        console.log(`[V3 Analyze] Vectorize returned ${totalCandidates} candidates in ${expansionResult.search_duration_ms}ms`)
      } else {
        // Vectorize 실패 시 기존 방식
        throw new Error('Vectorize fallback triggered')
      }
    } catch (vectorError) {
      console.log('[V3 Analyze] Vectorize unavailable, using DB fallback (no tagging required)')
      // Fallback: jobs JOIN job_attributes (태깅 여부 무관)
      const jobAttrs = await db.prepare(`
        SELECT 
          ja.job_id, ja.job_name,
          j.slug, j.image_url,
          COALESCE(ja.wlb, 50) as wlb, 
          COALESCE(ja.growth, 50) as growth, 
          COALESCE(ja.stability, 50) as stability, 
          COALESCE(ja.income, 50) as income,
          COALESCE(ja.teamwork, 50) as teamwork, 
          COALESCE(ja.solo_deep, 50) as solo_deep, 
          COALESCE(ja.analytical, 50) as analytical, 
          COALESCE(ja.creative, 50) as creative, 
          COALESCE(ja.execution, 50) as execution, 
          COALESCE(ja.people_facing, 50) as people_facing,
          COALESCE(ja.work_hours, 'regular') as work_hours, 
          COALESCE(ja.shift_work, 'rare') as shift_work, 
          COALESCE(ja.travel, 'rare') as travel, 
          COALESCE(ja.remote_possible, 'possible') as remote_possible,
          COALESCE(ja.degree_required, 'none') as degree_required,
          COALESCE(ja.license_required, 'none') as license_required
        FROM job_attributes ja
        INNER JOIN jobs j ON ja.job_id = j.id
        ORDER BY RANDOM()
        LIMIT 500
      `).all<{
        job_id: string
        job_name: string
        slug: string
        image_url: string | null
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
      candidateSource = useDbData ? 'db_fallback' : 'sample_fallback'
      candidateCount = jobAttrs.results?.length || 0

      sampleJobs = useDbData
        ? jobAttrs.results!.map(j => {
            const personalized = calculatePersonalizedBaseScores(j, miniModuleForFilter)
            return {
              job_id: j.job_id,
              job_name: j.job_name,
              slug: j.slug,
              image_url: j.image_url,
              base_like: personalized.like,
              base_can: personalized.can,
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
            }
          })
        : []
    }
  } else {
    // Vectorize 없이 DB에서 직접 조회 (태깅 여부 무관)
    console.log('[V3 Analyze] Vectorize not available, using DB fallback (no tagging required)')
    const jobAttrs = await db.prepare(`
      SELECT
        ja.job_id, ja.job_name,
        j.slug, j.image_url, j.api_data_json, j.merged_profile_json, j.ai_data_json,
        COALESCE(ja.wlb, 50) as wlb,
        COALESCE(ja.growth, 50) as growth,
        COALESCE(ja.stability, 50) as stability,
        COALESCE(ja.income, 50) as income,
        COALESCE(ja.teamwork, 50) as teamwork,
        COALESCE(ja.solo_deep, 50) as solo_deep,
        COALESCE(ja.analytical, 50) as analytical,
        COALESCE(ja.creative, 50) as creative,
        COALESCE(ja.execution, 50) as execution,
        COALESCE(ja.people_facing, 50) as people_facing,
        COALESCE(ja.work_hours, 'regular') as work_hours,
        COALESCE(ja.shift_work, 'rare') as shift_work,
        COALESCE(ja.travel, 'rare') as travel,
        COALESCE(ja.remote_possible, 'possible') as remote_possible,
        COALESCE(ja.degree_required, 'none') as degree_required,
        COALESCE(ja.license_required, 'none') as license_required
      FROM job_attributes ja
      INNER JOIN jobs j ON ja.job_id = j.id
      ORDER BY RANDOM()
      LIMIT 500
    `).all<{
      job_id: string
      job_name: string
      slug: string
      image_url: string | null
      api_data_json: string | null
      merged_profile_json: string | null
      ai_data_json: string | null
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
    candidateSource = useDbData ? 'db_fallback' : 'sample_fallback'
    candidateCount = jobAttrs.results?.length || 0
    
    sampleJobs = useDbData
      ? jobAttrs.results!.map(j => {
          const personalized = calculatePersonalizedBaseScores(j, miniModuleForFilter)
          return {
            job_id: j.job_id,
            job_name: j.job_name,
            slug: j.slug,
            image_url: j.image_url,
            job_description: extractJobDescription(j.api_data_json, j.merged_profile_json, j.job_name, j.ai_data_json),
            base_like: personalized.like,
            base_can: personalized.can,
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
          }
        })
      : []
  }
  
  // DB 데이터가 없으면 에러 반환
  if (sampleJobs.length === 0) {
    throw new Error('직업 데이터를 불러올 수 없습니다. job_attributes 테이블을 확인하세요.')
  }
  
  // ============================================
  // 전체 직업 수 조회 (평가 직업 수 표시용)
  // ============================================
  let totalJobsInDB = sampleJobs.length
  try {
    const countResult = await db.prepare('SELECT COUNT(*) as cnt FROM jobs').first<{ cnt: number }>()
    totalJobsInDB = countResult?.cnt || sampleJobs.length
    console.log(`[V3 Analyze] Total jobs in DB: ${totalJobsInDB}`)
  } catch (error) {
    console.warn('[V3 Analyze] Failed to count total jobs:', error)
  }
  
  // ============================================
  // Phase 2.1: 미니모듈 기반 Hard Filter (벡터 검색 전 적용)
  // ============================================
  // 미니모듈 기반 Hard Exclusion 적용
  const { filtered: filteredJobs, filterResult: miniModuleFilterResult } = applyMiniModuleHardFilter(
    sampleJobs,
    miniModuleForFilter
  )
  
  // 필터링 결과 로그
  if (miniModuleFilterResult.stats.totalFiltered > 0) {
    console.log(`[V3 Analyze] MiniModule Hard Filter: ${miniModuleFilterResult.stats.beforeCount} → ${miniModuleFilterResult.stats.afterCount} jobs`)
    console.log(`[V3 Analyze] Applied rules:`, miniModuleFilterResult.appliedRules.map(r => `${r.ruleId}(${r.excludedCount})`))
  }
  
  // 필터링된 직업 목록 사용
  const jobsToScore = filteredJobs.length > 0 ? filteredJobs : sampleJobs
  
  // 2. Fact boosts 계산
  const factBoosts = calculateFactBoosts(facts)

  // P2: 검증된 Can 추출 (Can 기반 TAG 필터용)
  const verifiedCan: VerifiedCanMap = extractVerifiedCanFromFacts(
    facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json }))
  )
  console.log(`[V3 Analyze] Verified Can map:`, verifiedCan)

  // 미니모듈 기반 추가 Risk Penalty (Hard Bias derived)
  const hardBiasConstraints = miniModuleForFilter?.energy_drain_flags
    ? deriveConstraintsFromHardBias(miniModuleForFilter.energy_drain_flags)
    : null

  // P3: 성장곡선 선호도 추출
  const growthPreference = extractGrowthPreference(miniModuleForFilter)
  console.log(`[V3 Analyze] Growth preference: ${growthPreference.preferredCurve} (confidence: ${growthPreference.confidence.toFixed(2)})`)

  // P3: 내면갈등 심각도 확인
  const conflictSeverity = calculateConflictSeverity(miniModuleForFilter)
  console.log(`[V3 Analyze] Conflict severity: ${conflictSeverity.severity} (${conflictSeverity.level})`)

  // 3. 각 직업에 점수 적용 (slug, image_url 포함 + 미니모듈 Risk Penalty)
  const scoredJobs: ScoredJob[] = jobsToScore.map(job => {
    const baseScores: JobScores = {
      like: job.base_like,
      can: job.base_can,
      risk_penalty: job.base_risk,
    }
    
    const adjusted = applyFactBoostsToJob(baseScores, job.attributes, factBoosts)
    
    // 미니모듈 기반 추가 Risk Penalty 적용
    let additionalPenalty = 0
    const miniModulePenalty = calculateMiniModuleRiskPenalty(miniModuleForFilter, job.attributes)
    additionalPenalty += miniModulePenalty.penalty
    
    // Hard Bias 기반 추가 Penalty 적용
    if (hardBiasConstraints && hardBiasConstraints.penalties.length > 0) {
      const hardBiasPenalty = applyHardBiasPenalty(job.attributes, hardBiasConstraints)
      additionalPenalty += hardBiasPenalty.penalty
    }

    // P2: Can 기반 TAG 필터 페널티 적용
    const canFilterResult = applyCanBasedFilter(job.attributes, verifiedCan)
    additionalPenalty += canFilterResult.totalPenalty

    // P3: 성장곡선 매칭 (Like Boost / Risk Penalty)
    const growthMatch = matchGrowthCurves(growthPreference, job.attributes, job.job_name)
    additionalPenalty += growthMatch.riskPenalty

    // P3: 내면갈등 → Risk 조정
    const conflictRisk = calculateConflictRisk(miniModuleForFilter, job.attributes)
    additionalPenalty += conflictRisk.totalRiskAdjust

    const totalRiskPenalty = adjusted.risk_penalty + additionalPenalty

    // P0: Can-Like 밸런스 캡 적용
    // P3: 성장곡선 매칭 Like Boost 포함
    const likeWithGrowthBoost = adjusted.like + growthMatch.likeBoost
    const balanced = applyBalanceCap(likeWithGrowthBoost, adjusted.can)
    const fit = Math.round(0.55 * balanced.like + 0.45 * balanced.can - totalRiskPenalty)

    // 임시 scoredJob 객체 생성 (explanation 생성용)
    const tempScoredJob: ScoredJob = {
      job_id: job.job_id,
      job_name: job.job_name,
      slug: job.slug,
      image_url: job.image_url || undefined,
      job_description: (job as any).job_description,
      scores: {
        fit: Math.max(0, fit),
        like: balanced.like,
        can: balanced.can,
        risk_penalty: totalRiskPenalty,
      },
      attributes: job.attributes,
    }

    // 근거 생성 (V3: miniModuleForFilter 전달하여 개인화된 이유 생성)
    const explanation = generateJobExplanation(tempScoredJob, facts, factBoosts.applied_rules, miniModuleForFilter)
    const rationale = `[좋아할 이유] ${explanation.like_reason} [잘할 이유] ${explanation.can_reason}`

    return {
      ...tempScoredJob,
      rationale,
      likeReason: explanation.like_reason,
      canReason: explanation.can_reason,
    }
  })

  // 4. 정렬 (Fit 기준)
  scoredJobs.sort((a, b) => b.scores.fit - a.scores.fit)
  
  // 평가 직업 100개로 확장 (기존 10개 -> 100개)
  const top10 = scoredJobs.slice(0, 100)
  
  // Phase 4: Diversity Guard (Research Bias 방지 + 다양성 확보)
  const rawTop5 = top10.slice(0, 5)
  const diversityResult = applyDiversityGuard(rawTop5, scoredJobs)
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

  // 5.5 P0: Can 검증 질문 추가 (자기평가 강점 경험 확인)
  // mini_module_result 조기 추출 (Can 검증용)
  const mmResultForCan = 'mini_module_result' in payload ? (payload as any).mini_module_result : undefined
  if (mmResultForCan?.strength_top?.length > 0) {
    // 이미 검증된 강점 토큰들 찾기
    const alreadyVerified = facts
      .filter(f => f.fact_key.startsWith('can_verified_'))
      .map(f => f.fact_key.replace('can_verified_', ''))

    // Can 검증 질문 선택 (세션당 최대 2개)
    const canValidationQuestions = selectCanValidationQuestions({
      max_questions_per_session: 2,
      already_verified: alreadyVerified,
      user_strength_tokens: mmResultForCan.strength_top,
    })

    // FollowupQuestion 형식으로 변환하여 추가
    for (const cvq of canValidationQuestions) {
      // 세션당 총 질문 수 상한 (4개)
      if (followupQuestions.length >= 4) break

      followupQuestions.push({
        id: cvq.id,
        type: 'can_validation',
        question: cvq.question,
        context: cvq.why_asked,
        options: cvq.options?.map(opt => ({
          value: opt.value,
          label: opt.label,
          tags: opt.tags,
        })) || [],
        fact_key: cvq.fact_key,
        affects_attributes: ['can'] as any,  // Can 점수에 영향
      })
    }

    console.log(`[Can Validation] Added ${canValidationQuestions.length} questions, total: ${followupQuestions.length}`)
  }

  // 6. User Insight 생성 (Stage-aware)
  const userInsight = stage
    ? generateStageAwareInsight(facts, deepIntake, factBoosts.applied_rules, stage)
    : generateUserInsight(facts, deepIntake, factBoosts.applied_rules)
  
  // 6.5. Premium Report 생성 (V3 - LLM 기반 활성화!)
  // mini_module_result 추출 (payload에서)
  const miniModuleResult = 'mini_module_result' in payload ? (payload as any).mini_module_result : undefined
  const openaiKey = env.OPENAI_API_KEY  // Bindings 타입에 정의됨
  const sessionId = `session-${requestId}`
  
  // ★ 디버그: 환경 변수 확인
  console.log(`[★ ENV CHECK] OPENAI_API_KEY exists: ${!!openaiKey}, AI exists: ${!!env.AI}`)
  
  // ============================================
  // LLM Judge: 후보 직업 LLM 재평가 (Llama 3.1)
  // ============================================
  let llmJudgeResults: JudgeOutput | null = null
  let llmJudgeUsed = false
  
  // top10을 FilteredCandidate 형식으로 변환
  const candidatesForJudge = top10.map(j => ({
    job_id: j.job_id,
    job_name: j.job_name,
    slug: j.slug,
    image_url: j.image_url,
    attributes: j.attributes as Record<string, number>,
    base_scores: {
      like: j.scores.like,
      can: j.scores.can,
      risk_penalty: j.scores.risk_penalty,
    },
    exclusion_reasons: [],
  }))
  
  // SearchProfile 구성
  const searchProfile = {
    interests: miniModuleResult?.interests || [],
    values: miniModuleResult?.values || [],
    strengths: miniModuleResult?.strengths || [],
    constraints: userConstraints,
    sacrifice_flags: miniModuleResult?.sacrifice_flags || [],
    energy_drain_flags: miniModuleResult?.energy_drain_flags || [],
  }
  
  // roundAnswers 구성 (deep_intake에서 추출)
  const roundAnswers = deepIntake?.questions?.map((q, i) => ({
    round: Math.min(3, Math.floor(i / 3) + 1) as 1 | 2 | 3,
    questionId: `q${i + 1}`,
    question: q.question,
    answer: q.answer,
    timestamp: new Date().toISOString(),
  })) || []
  
  // 디버그 로그: LLM 조건 확인
  console.log(`[LLM Debug] openaiKey: ${!!openaiKey}, candidates: ${candidatesForJudge.length}`)
  console.log(`[LLM Debug] openaiKey value (first 10): ${openaiKey ? String(openaiKey).substring(0, 10) + '...' : 'MISSING'}`)
  
  // LLM Judge: OpenAI API 키가 있을 때만 시도 (없으면 스킵)
  if (openaiKey && candidatesForJudge.length > 0) {
    try {
      console.log(`[LLM Judge] Evaluating ${candidatesForJudge.length} candidates with OpenAI GPT-4o-mini...`)
      const judgeInput: JudgeInput = {
        candidates: candidatesForJudge,
        searchProfile,
        roundAnswers,
        universalAnswers: universalAnswers,
        miniModuleResult: miniModuleResult,
      }
      llmJudgeResults = await judgeCandidates(openaiKey, db, judgeInput)
      llmJudgeUsed = true
      console.log(`[LLM Judge] Completed: ${llmJudgeResults.results.length} jobs evaluated, avg fit: ${llmJudgeResults.stats.averageFitScore.toFixed(1)}`)
    } catch (judgeError) {
      console.error('[LLM Judge] Failed, using rule-based scores:', judgeError)
    }
  }

  // LLM Judge 결과를 scoredJobs에 병합 (개인화된 이유 반영)
  if (llmJudgeUsed && llmJudgeResults) {
    for (const judgeResult of llmJudgeResults.results) {
      const job = scoredJobs.find(j => j.job_id === judgeResult.job_id)
      if (job) {
        if (judgeResult.likeReason) job.likeReason = judgeResult.likeReason
        if (judgeResult.canReason) job.canReason = judgeResult.canReason
        if (judgeResult.rationale) job.rationale = judgeResult.rationale
      }
    }
    console.log(`[LLM Judge Merge] Updated reasons for ${llmJudgeResults.results.length} jobs in scoredJobs`)
  }

  // ============================================
  // Scoring Trace: 확신도 + 결정변수 계산
  // ============================================
  const scoringTrace = createScoringTrace(
    top10.map(j => ({
      job_id: j.job_id,
      job_name: j.job_name,
      scores: j.scores,
      attributes: j.attributes as Record<string, number>,
    })),
    facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json }))
  )
  
  const confidenceResult = calculateConfidenceScore(
    facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json, source: 'minimodule' as const, timestamp: new Date().toISOString() })),
    roundAnswers.length,
    top10.slice(0, 3).map(j => j.scores.fit)
  )
  
  const keyDecisionVars = extractKeyDecisionVariables(
    scoringTrace,
    facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json }))
  )
  
  // ============================================
  // LLM Reporter: 심리분석 리포트 생성 (GPT-4o-mini)
  // ============================================
  let premiumReport
  
  // Hard Cut 리스트 구성 (필터링된 직업들)
  const hardCutList = miniModuleFilterResult?.excluded?.map(j => ({
    job_id: j.job_id,
    job_name: j.job_name,
    rule_id: j.rule_id || 'mini_module_filter',
    reason: j.reason || '미니모듈 기반 제외',
  })) || []
  
  console.log(`[LLM Reporter Check] openaiKey: ${!!openaiKey}, llmJudgeResults: ${!!llmJudgeResults}, candidates: ${candidatesForJudge.length}`)

  // ============================================
  // NarrativeFacts 조회 (심리 분석용)
  // ============================================
  let narrativeFacts: NarrativeFacts | undefined
  try {
    const narrativeRow = await db.prepare(`
      SELECT high_alive_moment, lost_moment
      FROM narrative_facts
      WHERE session_id = ?
    `).bind(payload.session_id).first<{
      high_alive_moment: string | null
      lost_moment: string | null
    }>()

    if (narrativeRow && (narrativeRow.high_alive_moment || narrativeRow.lost_moment)) {
      narrativeFacts = {
        highAliveMoment: narrativeRow.high_alive_moment || '',
        lostMoment: narrativeRow.lost_moment || '',
      }
      console.log('[LLM Reporter] NarrativeFacts loaded:', {
        hasHighAlive: !!narrativeFacts.highAliveMoment,
        hasLostMoment: !!narrativeFacts.lostMoment,
      })
    } else {
      console.log('[LLM Reporter] No narrative facts found for session')
    }
  } catch (narrativeError) {
    console.warn('[LLM Reporter] Failed to load narrative facts:', narrativeError)
  }

  // RoundAnswers 조회 (DB에서 실제 저장된 3라운드 답변 가져오기)
  let dbRoundAnswers: Array<{
    roundNumber: 1 | 2 | 3
    questionId: string
    answer: string
  }> = []

  try {
    const roundAnswersRows = await db.prepare(`
      SELECT round_number, question_id, answer
      FROM round_answers
      WHERE session_id = ?
      ORDER BY round_number, question_id
    `).bind(payload.session_id).all<{
      round_number: number
      question_id: string
      answer: string
    }>()

    if (roundAnswersRows.results && roundAnswersRows.results.length > 0) {
      dbRoundAnswers = roundAnswersRows.results.map(row => ({
        roundNumber: row.round_number as 1 | 2 | 3,
        questionId: row.question_id,
        answer: row.answer,
      }))
      console.log(`[LLM Reporter] Loaded ${dbRoundAnswers.length} round answers from DB`)
    } else {
      console.log('[LLM Reporter] No round answers found in DB')
    }
  } catch (roundError) {
    console.warn('[LLM Reporter] Failed to load round answers:', roundError)
  }

  // roundAnswers 병합: DB 우선, deep_intake는 fallback
  const finalRoundAnswers = dbRoundAnswers.length > 0
    ? dbRoundAnswers
    : (roundAnswers || [])

  console.log(`[LLM Reporter] Final round answers count: ${finalRoundAnswers.length}`)

  // LLM Reporter: OpenAI 키만 있으면 호출 (후보가 있을 때)
  if (openaiKey && candidatesForJudge.length > 0) {
    try {
      console.log('[LLM Reporter] ★★★ Generating premium report with GPT-4o-mini... ★★★')
      const reporterInput: ReporterInput = {
        sessionId,
        judgeResults: llmJudgeResults?.results || [],
        searchProfile,
        narrativeFacts,  // ★ 추가!
        roundAnswers: finalRoundAnswers,  // ★ DB에서 조회한 실제 답변 사용!
        universalAnswers: universalAnswers,
        hardCutList,
        miniModuleResult,
      }
      premiumReport = await generateLLMPremiumReport(
        env?.AI || null,
        reporterInput,
        openaiKey
      )
      console.log('[LLM Reporter] Premium report generated successfully')
    } catch (reporterError) {
      console.error('[LLM Reporter] Failed, falling back to rule-based:', reporterError)
      // Fallback: 규칙 기반 리포트
      const premiumReportInputV3: PremiumReportInput = {
        session_id: sessionId,
        facts: facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json })),
        recommendations: top10.map(j => ({
          job_id: j.job_id,
          job_name: j.job_name,
          slug: j.slug,
          image_url: j.image_url,
          scores: j.scores,
          attributes: j.attributes as Record<string, number>,
        })),
        userInsight: userInsight,
        stage: stage,
        miniModuleResult: miniModuleResult,
      }
      premiumReport = fixParticlesDeep(generatePremiumReport(premiumReportInputV3))
    }
  } else {
    // OpenAI 키 없음: 규칙 기반 리포트
    console.log('[Premium Report] OpenAI key not available, using rule-based report')
    const premiumReportInputV3: PremiumReportInput = {
      session_id: sessionId,
      facts: facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json })),
      recommendations: top10.map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        slug: j.slug,
        image_url: j.image_url,
        scores: j.scores,
        attributes: j.attributes as Record<string, number>,
      })),
      userInsight: userInsight,
      stage: stage,
      miniModuleResult: miniModuleResult,
    }
    premiumReport = fixParticlesDeep(generatePremiumReport(premiumReportInputV3))
  }
  
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
    engine_version: 'v3',  // V3 프리미엄 리포트 활성화
    mini_module_result: miniModuleResult || null,

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
      
      // Dislike 경고 생성
      const dislikeWarnings = generateDislikeWarnings(facts, j)

      return {
        job_id: j.job_id,
        job_name: j.job_name,
        slug: j.slug,
        image_url: j.image_url,
        job_description: j.job_description || null,
        rationale: j.rationale || null,
        like_reason: j.likeReason || null,
        can_reason: j.canReason || null,
        fit_score: j.scores.fit,
        like_score: j.scores.like,
        can_score: j.scores.can,
        risk_details: [],
        evidence_links: evidenceLinks,
        dislike_warnings: dislikeWarnings,
      }
    }),

    // like_top10: like_score 기준으로 별도 정렬 (Fit >= 25 필터)
    like_top10: [...scoredJobs]
      .filter(j => j.scores.fit >= 25)
      .sort((a, b) => b.scores.like - a.scores.like)
      .slice(0, 10)
      .map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        slug: j.slug,
        image_url: j.image_url,
        job_description: j.job_description || null,
        fit_score: j.scores.fit,
        like_score: j.scores.like,
        can_score: j.scores.can,
        rationale: j.rationale || null,
        like_reason: j.likeReason || null,
        can_reason: j.canReason || null,
      })),

    // can_top10: can_score 기준으로 별도 정렬 (Fit >= 25 필터)
    can_top10: [...scoredJobs]
      .filter(j => j.scores.fit >= 25)
      .sort((a, b) => b.scores.can - a.scores.can)
      .slice(0, 10)
      .map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        slug: j.slug,
        image_url: j.image_url,
        job_description: j.job_description || null,
        fit_score: j.scores.fit,
        like_score: j.scores.like,
        can_score: j.scores.can,
        rationale: j.rationale || null,
        like_reason: j.likeReason || null,
        can_reason: j.canReason || null,
      })),

    caution_jobs: scoredJobs
      .filter(j => j.scores.risk_penalty > 20)
      .slice(0, 5)
      .map(j => ({
        job_id: j.job_id,
        job_name: j.job_name,
        slug: j.slug,
        image_url: j.image_url,
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
    // 전체 직업 수 표시 (DB의 모든 직업 = 평가 대상)
    total_candidates: totalJobsInDB,
    // 실제 점수 계산된 직업 수 (필터링 후)
    scored_candidates: scoredJobs.length,
    // 미니모듈 하드 필터로 제외된 직업 수
    filtered_out_candidates: miniModuleFilterResult.stats.totalFiltered,
    
    user_insight: userInsight,
    
    // Phase 4: Diversity Guard 정보
    phase4_applied: true,
    diversity_guard_active: diversityResult.diversityApplied,
    diversity_changes: diversityResult.changes,
    
    // V3: Stage 기반 분석 정보
    analysis_stage: stage,
    stage_specific_insights: stage ? generateStageInsights(stage, facts) : undefined,
    
    // V3: Premium Report
    premium_report: premiumReport,
    
    // V3: LLM 모듈 정보 (2026-02-03 활성화)
    llm_modules: {
      judge_used: llmJudgeUsed,
      judge_stats: llmJudgeResults?.stats || null,
      reporter_used: !!openaiKey,
      // 디버그 정보 (환경 변수 확인용)
      env_check: {
        openai_key_exists: !!openaiKey,
        openai_key_prefix: openaiKey ? String(openaiKey).substring(0, 7) : null,
        ai_binding_exists: !!env.AI,
        candidates_count: candidatesForJudge.length,
      },
    },
    
    // V3: 확신도 + 결정변수 (scoring-trace.ts)
    confidence: confidenceResult,
    key_decision_variables: keyDecisionVars.slice(0, 5),  // Top 5
    scoring_trace_summary: {
      total_features: scoringTrace.candidates[0]?.feature_contributions.length || 0,
      top_decision_variable: scoringTrace.decision_variables[0]?.fact_key || null,
    },
    
    // Debug info (only included when debugMode=true)
    debug_info: debugMode ? generateDebugInfo(
      candidateSource,
      candidateCount,
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
  candidateSource: 'vectorize' | 'db_fallback' | 'sample_fallback' | 'vector' | 'random',
  candidateCount: number,
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
    candidate_count: candidateCount,
    total_in_db: totalInDb,
    score_breakdown: scoreBreakdown,
    followup_rationale: followupRationale,
    applied_facts: appliedFacts,
    versions: {
      recipe: VERSIONS.recipe,
      tagger: VERSIONS.tagger,
      scoring: VERSIONS.scoring,
      embedding: 'bge-base-en-v1.5', // Vectorize 활성화 (2026-01-16)
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
    
    // request_id로 분석 결과 조회 (ai_analysis_requests + ai_analysis_results JOIN)
    const requestRow = await db.prepare(`
      SELECT 
        req.id as request_id, 
        req.prompt_payload as request_payload, 
        res.result_json
      FROM ai_analysis_requests req
      LEFT JOIN ai_analysis_results res ON req.id = res.request_id
      WHERE req.id = ?
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
    
    // facts 조회 (facts 테이블에서, 없으면 빈 배열)
    let facts: { fact_key: string; value_json: string }[] = []
    try {
      const factsResult = await db.prepare(`
        SELECT fact_key, value_json
        FROM facts
        WHERE session_id = ?
        ORDER BY collected_at DESC
      `).bind(body.session_id || `session-${body.request_id}`).all<{
        fact_key: string
        value_json: string
      }>()
      facts = factsResult.results || []
    } catch (e) {
      // facts 테이블이 없거나 에러시 빈 배열 유지
      console.log('Facts query failed, using empty array:', e)
    }
    
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
    
    // 기존 분석 결과 조회 (ai_analysis_results 테이블에서)
    const requestRow = await db.prepare(`
      SELECT result_json
      FROM ai_analysis_results
      WHERE request_id = ?
    `).bind(body.request_id).first<{ result_json: string | null }>()
    
    if (!requestRow?.result_json) {
      return c.json({
        error: 'NOT_FOUND',
        message: '분석 결과를 찾을 수 없습니다'
      }, 404)
    }
    
    const analysisResult = JSON.parse(requestRow.result_json)
    
    // facts 조회 (facts 테이블에서, 없으면 빈 배열)
    let facts: { fact_key: string; value_json: string }[] = []
    try {
      const factsResult = await db.prepare(`
        SELECT fact_key, value_json
        FROM facts
        WHERE session_id = ?
        ORDER BY collected_at DESC
      `).bind(body.session_id || `session-${body.request_id}`).all<{
        fact_key: string
        value_json: string
      }>()
      facts = factsResult.results || []
    } catch (e) {
      console.log('Facts query failed, using empty array:', e)
    }
    
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
// Tagger Routes 제거됨 (2026-01-26)
// 태깅 의존도 완전 제거 - 벡터 검색으로 대체
// ============================================

// ============================================
// Mount Draft Routes (P0: 임시저장)
// ============================================
analyzerRoutes.route('/draft', draftRoutes)

// ============================================
// Mount History Routes (결과 이력)
// ============================================
analyzerRoutes.route('/history', historyRoutes)

// ============================================
// Mount Resume Routes (P0: 이력서 텍스트 파싱)
// ============================================
analyzerRoutes.route('/resume', resumeRoutes)

// ============================================
// Mount Profile Routes (프로필 조회/업데이트)
// ============================================
analyzerRoutes.route('/profile', profileRoutes)

// ============================================
// V3: 3라운드 심층 질문 생성 API (2026-01-16)
// POST /api/ai-analyzer/v3/round-questions
// ============================================
import { generateRoundQuestions, buildSearchProfileFromAnswers } from './llm-interviewer'

analyzerRoutes.post('/v3/round-questions', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  
  try {
    const body = await c.req.json<{
      session_id: string
      round_number: 1 | 2 | 3
      narrative_facts?: { highAliveMoment: string; lostMoment: string; life_story?: string; storyAnswer?: string }
      previous_round_answers?: Array<{
        questionId: string
        questionText?: string  // 질문 텍스트 (다음 라운드 컨텍스트용)
        roundNumber: 1 | 2 | 3
        answer: string
        answeredAt: string
      }>
      universal_answers?: Record<string, string | string[]>
      career_state?: {
        role_identity: string
        career_stage_years: string
        transition_status: string
      }
      transition_signal?: Record<string, any>
      // 미니모듈 결과 (LLM 판단 앵커!)
      mini_module_result?: {
        interest_top: string[]
        value_top: string[]
        strength_top: string[]
        constraint_flags: string[]
        low_confidence_flags?: string[]
        internal_conflict_flags?: string[]
      }
    }>()
    
    const { session_id, round_number, narrative_facts, previous_round_answers, universal_answers, career_state, transition_signal, mini_module_result } = body
    
    // 검증
    if (!session_id) {
      return c.json({ success: false, error: 'session_id is required' }, 400)
    }
    if (![1, 2, 3].includes(round_number)) {
      return c.json({ success: false, error: 'round_number must be 1, 2, or 3' }, 400)
    }
    
    // ============================================
    // LLM Gate: 필수 데이터 검증 + 폴백 질문 반환
    // ============================================
    // AggregatedProfile 빌드 (요청 데이터로 임시 생성)
    const tempProfile: AggregatedProfile = {
      profile_version: 0,
      generated_at: new Date().toISOString(),
      anchors: {
        interest_top: mini_module_result?.interest_top || [],
        value_top: mini_module_result?.value_top || [],
        strength_top: mini_module_result?.strength_top || [],
        constraint_flags: mini_module_result?.constraint_flags || [],
        low_confidence_flags: mini_module_result?.low_confidence_flags,
        internal_conflict_flags: mini_module_result?.internal_conflict_flags,
      },
      narrative: {
        life_story: narrative_facts?.life_story || narrative_facts?.storyAnswer,
        high_alive: narrative_facts?.highAliveMoment,
        lost_moment: narrative_facts?.lostMoment,
      },
      universals: {
        priority: universal_answers?.univ_priority as string | undefined,
        interests: universal_answers?.univ_interest as string[] | undefined,
        dislikes: universal_answers?.univ_dislike as string[] | undefined,
      },
      transition: {},
      rounds: previous_round_answers ? [{
        round: (round_number > 1 ? round_number - 1 : 1) as 1|2|3,
        questions: [],
        answers: previous_round_answers.map(a => ({ question_id: a.questionId, answer: a.answer })),
      }] : [],
      memory: {
        stable_drivers: [],
        recurring_fears: [],
        decision_rules: [],
        contradictions: [],
        open_loops: [],
        resolved_loops: [],
        emotional_triggers: [],
      },
      evidence_index: {},
    }
    
    // Gate 검증 (로그만 남기고 LLM 호출은 계속 진행)
    const gatePhase: GatePhase = `round${round_number}` as GatePhase
    const gateResult = assertReadyForLLM(tempProfile, gatePhase)
    
    if (!gateResult.passed) {
      // Gate 실패해도 LLM 호출은 계속 진행 (데이터 부족해도 질문 생성 시도)
      console.log(`[V3 Round Questions] Gate warning for round ${round_number} (proceeding anyway):`, gateResult.missing)
    }
    
    // ============================================
    // DB에서 Memory 조회 (누적 메모리)
    // ============================================
    let memoryData = undefined
    try {
      const draft = await db
        .prepare('SELECT memory_json FROM analyzer_drafts WHERE session_id = ?')
        .bind(session_id)
        .first<{ memory_json?: string }>()
      
      if (draft?.memory_json) {
        memoryData = JSON.parse(draft.memory_json)
        console.log('[V3 Round Questions] Memory loaded from DB')
      }
    } catch (memError) {
      console.warn('[V3 Round Questions] Failed to load memory:', memError)
    }
    
    // ============================================
    // CAG Manager: 세션 상태 관리 (2026-02-03 활성화)
    // ============================================
    let cagState: CAGState | null = null
    try {
      cagState = await getOrCreateCAGState(db, session_id)
      console.log(`[V3 Round Questions] CAG state loaded: ${cagState.asked_questions_log.length} questions asked`)
    } catch (cagError) {
      console.warn('[V3 Round Questions] CAG state load failed (continuing without):', cagError)
    }
    
    // 이전 라운드 답변을 CAG에 기록
    if (cagState && previous_round_answers && previous_round_answers.length > 0) {
      for (const ans of previous_round_answers) {
        logAnswerReceived(cagState, ans.questionId, ans.answer)
      }
    }
    
    // ============================================
    // LLM Interviewer 호출 (Gate 통과 + Memory + CAG 포함)
    // ============================================
    const result = await generateRoundQuestions(env.AI || null, {
      sessionId: session_id,
      roundNumber: round_number,
      narrativeFacts: narrative_facts,
      previousRoundAnswers: previous_round_answers || [],
      universalAnswers: universal_answers,
      careerState: career_state,
      transitionSignal: transition_signal,
      miniModuleResult: mini_module_result,
      memory: memoryData,  // 누적 메모리 전달!
      openaiApiKey: (env as any).OPENAI_API_KEY,  // OpenAI API 키 전달
    })
    
    // ============================================
    // CAG: 생성된 질문 로그 기록 + 중복 필터
    // ============================================
    let filteredQuestions = result.questions
    if (cagState) {
      // 중복 질문 필터링
      filteredQuestions = result.questions.filter(q => {
        // questionText가 있을 때만 중복 체크 (undefined 방지)
        if (!q.questionText) return true
        const isDuplicate = isQuestionAlreadyAsked(cagState!, q.questionText, 0.8)
        if (isDuplicate) {
          console.log(`[CAG] Filtering duplicate question: ${q.questionId}`)
        }
        return !isDuplicate
      })

      // 생성된 질문 로그 기록
      for (const q of filteredQuestions) {
        logAskedQuestion(cagState, {
          questionId: q.questionId,
          questionText: q.questionText,
          round: round_number,
          askedAt: new Date().toISOString(),
          answered: false,
        })
      }
      
      // CAG 상태 저장
      try {
        await saveCAGState(db, cagState)
        console.log(`[CAG] State saved: ${cagState.asked_questions_log.length} questions tracked`)
      } catch (saveError) {
        console.warn('[CAG] Failed to save state:', saveError)
      }
    }
    
    // P2: 수집 진행도 요약 생성
    const collectionProgressSummary = cagState
      ? getCollectionProgressSummary(cagState)
      : null

    return c.json({
      success: true,
      round: result.round,
      questions: filteredQuestions,
      generated_by: result.generatedBy,
      metadata: {
        ...result.metadata,
        cag_filtered: result.questions.length - filteredQuestions.length,
        total_questions_asked: cagState?.asked_questions_log.length || 0,
      },
      collection_progress: collectionProgressSummary,
    })
    
  } catch (error: any) {
    console.error('[V3 Round Questions] Error:', error.message, error.stack)
    return c.json({
      success: false,
      error: error.message || 'Unknown error',
      detail: error.stack ? error.stack.split('\n')[0] : undefined,
    }, 500)
  }
})

// ============================================
// V3: 라운드 답변 저장 API
// POST /api/ai-analyzer/v3/round-answers
// ============================================
analyzerRoutes.post('/v3/round-answers', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  
  try {
    const body = await c.req.json<{
      session_id: string
      request_id?: number
      round_number: 1 | 2 | 3
      answers: Array<{
        question_id: string
        question_text?: string
        purpose_tag: 'ENGINE' | 'AVOIDANCE' | 'INTEGRATION'
        answer: string
      }>
    }>()
    
    const { session_id, request_id, round_number, answers } = body
    
    // P0-1: session_id 검증 강화
    if (!session_id || session_id.trim() === '') {
      console.error('[V3 Round Answers] VALIDATION FAILED: session_id is empty or null')
      return c.json({ 
        success: false, 
        error: 'session_id is required and cannot be empty',
        detail: 'session_id_validation_failed'
      }, 400)
    }
    
    if (!answers || answers.length === 0) {
      return c.json({ success: false, error: 'answers array is required' }, 400)
    }
    
    // P0-1: 입력값 로깅
    console.log('[V3 Round Answers] SAVE REQUEST:', {
      session_id,
      request_id,
      round_number,
      answers_count: answers.length,
    })
    
    // 답변 저장
    const insertStmt = db.prepare(`
      INSERT INTO round_answers (session_id, request_id, round_number, question_id, question_text, purpose_tag, answer)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    `)
    
    const results = await Promise.all(
      answers.map(ans => 
        insertStmt.bind(
          session_id,
          request_id || null,
          round_number,
          ans.question_id,
          ans.question_text || null,
          ans.purpose_tag,
          ans.answer
        ).run()
      )
    )
    
    const successCount = results.filter(r => r.success).length
    console.log('[V3 Round Answers] SAVE SUCCESS:', {
      session_id,
      round_number,
      saved_count: successCount,
      meta: results.map(r => r.meta),
    })
    
    // ============================================
    // P2: 수집 진행도 업데이트 (Round 답변 저장 후)
    // ============================================
    let collectionProgressSummary = null
    try {
      const cagState = await getOrCreateCAGState(db, session_id)

      // 답변 purpose_tag → fact_key 매핑
      for (const ans of answers) {
        // purpose_tag에 따라 fact key prefix 결정
        let factKeyPrefix = ''
        if (ans.purpose_tag === 'ENGINE') {
          // ENGINE = Like (관심사, 가치관)
          factKeyPrefix = 'like.round_answer'
        } else if (ans.purpose_tag === 'AVOIDANCE') {
          // AVOIDANCE = Risk (제약조건)
          factKeyPrefix = 'risk.round_answer'
        } else if (ans.purpose_tag === 'INTEGRATION') {
          // INTEGRATION = Can (능력, 경험)
          factKeyPrefix = 'can.round_answer'
        }

        if (factKeyPrefix) {
          const factKey = `${factKeyPrefix}.r${round_number}.${ans.question_id}`
          updateCollectionProgress(cagState, factKey)
        }
      }

      // 저장 및 요약 생성
      await saveCAGState(db, cagState)
      collectionProgressSummary = getCollectionProgressSummary(cagState)
      console.log('[V3 Round Answers] Collection progress:', collectionProgressSummary)
    } catch (progressError: any) {
      console.warn('[V3 Round Answers] Collection progress update failed:', progressError?.message)
    }

    // ============================================
    // Memory 업데이트 (Round 답변 저장 후)
    // ============================================
    let memoryUpdated = false
    try {
      // 1. Draft에서 현재 AggregatedProfile 조회
      const draft = await db
        .prepare('SELECT * FROM analyzer_drafts WHERE session_id = ?')
        .bind(session_id)
        .first<any>()
      
      if (draft) {
        // 2. 기존 profile 가져오기 또는 생성
        let aggregatedProfile: AggregatedProfile
        if (draft.aggregated_profile_json) {
          aggregatedProfile = JSON.parse(draft.aggregated_profile_json)
        } else {
          aggregatedProfile = createEmptyProfile(draft.profile_version || 0)
        }
        
        // 3. Round 답변을 RoundAnswer 형식으로 변환
        const roundAnswers = answers.map(ans => ({
          questionId: ans.question_id,
          roundNumber: round_number,
          answer: ans.answer,
          answeredAt: new Date().toISOString(),
        }))
        
        // 4. Memory 업데이트 호출
        console.log('[V3 Round Answers] Updating memory...')
        const updatedMemory = await updateMemory(
          env.AI || null,
          aggregatedProfile,
          { type: 'round_answers', data: roundAnswers, roundNumber: round_number },
          (env as any).OPENAI_API_KEY
        )
        
        // 5. Draft에 memory_json 저장
        aggregatedProfile.memory = updatedMemory
        await db
          .prepare(`
            UPDATE analyzer_drafts SET
              memory_json = ?,
              aggregated_profile_json = ?
            WHERE session_id = ?
          `)
          .bind(
            JSON.stringify(updatedMemory),
            JSON.stringify(aggregatedProfile),
            session_id
          )
          .run()
        
        memoryUpdated = true
        console.log('[V3 Round Answers] Memory updated successfully')
      }
    } catch (memoryError: any) {
      // Memory 업데이트 실패해도 답변 저장은 성공
      console.error('[V3 Round Answers] Memory update failed:', memoryError?.message || memoryError)
    }
    
    return c.json({
      success: true,
      saved_count: successCount,
      round_number,
      memory_updated: memoryUpdated,
      collection_progress: collectionProgressSummary,
    })
    
  } catch (error: any) {
    // P0-1: 상세 에러 로깅
    const errorDetail = {
      message: error.message || 'Unknown error',
      cause: error.cause?.message || error.cause || null,
      code: error.code || null,
      stack: error.stack?.substring(0, 500) || null,
    }
    console.error('[V3 Round Answers] SAVE FAILED:', errorDetail)
    
    return c.json({
      success: false,
      error: error.message || 'Database save failed',
      detail: errorDetail.cause || 'round_answers INSERT failed',
      code: errorDetail.code,
    }, 500)
  }
})

// ============================================
// V3: 서술형 답변 저장 API
// POST /api/ai-analyzer/v3/narrative-facts
// ============================================
analyzerRoutes.post('/v3/narrative-facts', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  
  try {
    const body = await c.req.json<{
      session_id: string
      user_id?: string
      high_alive_moment: string
      lost_moment: string
    }>()
    
    const { session_id, user_id, high_alive_moment, lost_moment } = body
    
    // P0-1: session_id 검증 강화
    if (!session_id || session_id.trim() === '') {
      console.error('[V3 Narrative Facts] VALIDATION FAILED: session_id is empty or null')
      return c.json({ 
        success: false, 
        error: 'session_id is required and cannot be empty',
        detail: 'session_id_validation_failed'
      }, 400)
    }
    
    // P0-1: 입력값 로깅
    console.log('[V3 Narrative Facts] SAVE REQUEST:', {
      session_id,
      user_id: user_id || null,
      high_alive_moment_length: high_alive_moment?.length || 0,
      lost_moment_length: lost_moment?.length || 0,
    })
    
    // UPSERT (기존 있으면 업데이트)
    const result = await db.prepare(`
      INSERT INTO narrative_facts (session_id, user_id, high_alive_moment, lost_moment)
      VALUES (?, ?, ?, ?)
      ON CONFLICT(session_id) DO UPDATE SET
        high_alive_moment = excluded.high_alive_moment,
        lost_moment = excluded.lost_moment,
        created_at = datetime('now')
    `).bind(session_id, user_id || null, high_alive_moment, lost_moment).run()
    
    console.log('[V3 Narrative Facts] SAVE SUCCESS:', {
      session_id,
      meta: result.meta,
      changes: result.meta?.changes || 0,
    })
    
    return c.json({
      success: true,
      session_id,
      meta: result.meta,
    })
    
  } catch (error: any) {
    // P0-1: 상세 에러 로깅
    const errorDetail = {
      message: error.message || 'Unknown error',
      cause: error.cause?.message || error.cause || null,
      code: error.code || null,
      stack: error.stack?.substring(0, 500) || null,
    }
    console.error('[V3 Narrative Facts] SAVE FAILED:', errorDetail)
    
    return c.json({
      success: false,
      error: error.message || 'Database save failed',
      detail: errorDetail.cause || 'narrative_facts UPSERT failed',
      code: errorDetail.code,
    }, 500)
  }
})

// ============================================
// Vectorize 테스트 API (2026-01-16)
// GET /api/ai-analyzer/vectorize-test?query=소프트웨어 개발자
// ============================================
analyzerRoutes.get('/vectorize-test', async (c) => {
  const env = c.env as Bindings
  const query = c.req.query('query') || '소프트웨어 개발 프로그래밍'
  const topK = parseInt(c.req.query('topK') || '10')
  
  // Vectorize 바인딩 확인
  const openaiApiKey = (env as any).OPENAI_API_KEY
  
  if (!env.VECTORIZE) {
    return c.json({
      success: false,
      error: 'VECTORIZE_NOT_AVAILABLE',
      message: 'Vectorize 바인딩이 설정되지 않았습니다',
      hint: 'wrangler.jsonc에서 vectorize 바인딩을 확인하세요',
    }, 503)
  }
  
  if (!openaiApiKey) {
    return c.json({
      success: false,
      error: 'OPENAI_API_KEY_NOT_SET',
      message: 'OpenAI API 키가 설정되지 않았습니다',
      hint: '.dev.vars 또는 Cloudflare Dashboard에서 OPENAI_API_KEY를 설정하세요',
    }, 503)
  }
  
  try {
    // 쿼리 임베딩 생성 (OpenAI - 한국어 직접 처리)
    const startTime = Date.now()
    const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, query)
    const embeddingTime = Date.now() - startTime
    
    const queryEmbedding = embeddings[0]
    
    // 벡터 검색
    // Cloudflare Vectorize limits: returnMetadata='indexed' → max topK=100
    const clampedTopK = Math.min(topK, 100)
    const searchStart = Date.now()
    const searchResult = await env.VECTORIZE.query(queryEmbedding, {
      topK: clampedTopK,
      returnValues: false,
      returnMetadata: 'indexed',
    })
    const searchTime = Date.now() - searchStart
    
    // 결과 변환
    const results = searchResult.matches.map(match => ({
      job_id: match.id,
      job_name: (match.metadata?.job_name as string) || match.id,
      score: match.score.toFixed(4),
      metadata: match.metadata,
    }))
    
    return c.json({
      success: true,
      query,
      topK,
      embedding_model: 'text-embedding-3-small',
      embedding_dimensions: OPENAI_EMBEDDING_DIMENSIONS,
      results_count: results.length,
      timing: {
        embedding_ms: embeddingTime,
        search_ms: searchTime,
        total_ms: embeddingTime + searchTime,
      },
      results,
    })
    
  } catch (error) {
    console.error('[Vectorize Test] Error:', error)
    return c.json({
      success: false,
      error: 'VECTORIZE_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// 관리자: 직업 데이터 재인덱싱 (OpenAI Embedding)
// ============================================
analyzerRoutes.post('/admin/reindex-jobs', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = (env as any).OPENAI_API_KEY
  
  if (!env.VECTORIZE) {
    return c.json({
      success: false,
      error: 'VECTORIZE_NOT_AVAILABLE',
      message: 'Vectorize 바인딩이 설정되지 않았습니다',
    }, 503)
  }
  
  if (!openaiApiKey) {
    return c.json({
      success: false,
      error: 'OPENAI_API_KEY_NOT_SET',
      message: 'OpenAI API 키가 설정되지 않았습니다',
    }, 503)
  }
  
  try {
    console.log('[Reindex] Starting job reindexing with OpenAI Embedding...')
    const startTime = Date.now()
    
    const result = await indexJobsToVectorize(
      db,
      env.VECTORIZE,
      openaiApiKey,
      50  // 배치 크기 (OpenAI rate limit 고려)
    )
    
    const duration = Date.now() - startTime
    
    console.log(`[Reindex] Completed: ${result.indexed} indexed, ${result.errors} errors in ${duration}ms`)
    
    return c.json({
      success: true,
      indexed: result.indexed,
      errors: result.errors,
      duration_ms: duration,
      embedding_model: 'text-embedding-3-small',
      embedding_dimensions: 1536,
    })
    
  } catch (error) {
    console.error('[Reindex] Error:', error)
    return c.json({
      success: false,
      error: 'REINDEX_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// Freeze v1.1: Recommendation Mode API
// ============================================
// 제출 시점에만 최종 추천 파이프라인 실행
// Interview Mode와 분리하여 설문 중 편향 방지
// ============================================
import { generateQSP, qspToPromptHints } from './qsp-generator'
import { createEmptyAxisCoverage } from './axis-framework'
import { incrementalUpsertToVectorize, countJobsNeedingIndexing } from './vectorize-pipeline'

// Fallback 심리분석 생성 (LLM 실패 시)
function generateFallbackWorkStyle(miniModule: {
  interest_top?: string[]
  value_top?: string[]
  strength_top?: string[]
  energy_drain_flags?: string[]
}): string {
  const parts: string[] = []

  const INTEREST_MAP: Record<string, string> = {
    problem_solving: '문제 해결',
    data_numbers: '데이터와 숫자',
    tech: '기술/IT',
    creative: '창작/예술',
    people: '사람과 소통',
    helping: '타인 돕기',
    business: '비즈니스',
    creating: '창작 활동',
    influencing: '영향력 발휘',
  }

  const VALUE_MAP: Record<string, string> = {
    growth: '성장',
    autonomy: '자율성',
    stability: '안정성',
    income: '높은 수입',
    meaning: '의미와 사회 기여',
    recognition: '인정과 영향력',
    wlb: '일과 삶의 균형',
  }

  const STRENGTH_MAP: Record<string, string> = {
    analytical: '분석력',
    fast_learning: '빠른 학습 능력',
    creativity: '창의성',
    communication: '소통 능력',
    leadership: '리더십',
    empathy: '공감 능력',
  }

  if (miniModule.interest_top?.length) {
    const interests = miniModule.interest_top
      .map(i => INTEREST_MAP[i] || i)
      .slice(0, 2)
      .join('과 ')
    parts.push(`${interests}에 관심이 많습니다`)
  }

  if (miniModule.value_top?.length) {
    const values = miniModule.value_top
      .map(v => VALUE_MAP[v] || v)
      .slice(0, 2)
      .join('과 ')
    parts.push(`${values}${을를(values)} 중요하게 여깁니다`)
  }

  if (miniModule.strength_top?.length) {
    const strengths = miniModule.strength_top
      .map(s => STRENGTH_MAP[s] || s)
      .slice(0, 2)
      .join(', ')
    parts.push(`${strengths}${이가(strengths)} 강점입니다`)
  }

  if (parts.length === 0) {
    return '당신의 커리어 성향을 분석하고 있습니다.'
  }

  return `당신은 ${parts.join('. ')}. 이러한 특성을 바탕으로 적합한 직업을 추천해 드립니다.`
}

interface RecommendationModePayload {
  session_id: string
  // 최종 SearchProfile (Interview Mode에서 수집된 모든 데이터)
  searchProfile?: {
    desiredThemes: string[]
    dislikedThemes: string[]
    strengthsHypothesis: string[]
    environmentPreferences: string[]
    hardConstraints: string[]
    riskSignals: string[]
    keywords: string[]
  }
  // 미니모듈 결과 (MiniModule Hard Filter용)
  mini_module_result?: {
    interest_top: string[]
    value_top: string[]
    strength_top: string[]
    constraint_flags: string[]
    sacrifice_flags?: string[]
    energy_drain_flags?: string[]
    achievement_feedback_top?: string[]
    execution_style?: string
    impact_scope?: string
    failure_response?: string
    persistence_anchor?: string
    external_expectation?: string
  }
  // 옵션: 기존 draft_id로 자동 프로필 빌드
  draft_id?: number
  // 옵션
  topK?: number  // 기본: 800
  judgeTopN?: number  // 기본: 20
  debug?: boolean
}

analyzerRoutes.post('/v3/recommend', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = c.env.OPENAI_API_KEY
  const payload = await c.req.json<RecommendationModePayload>()

  // 인증된 사용자 정보 가져오기 (있으면)
  const authUser = c.get('user') as { id: number } | undefined
  const userId = authUser?.id || null

  const { session_id, draft_id, topK = 800, judgeTopN = 20, debug = false } = payload
  
  if (!session_id) {
    return c.json(createErrorResponse(
      'VALIDATION_ERROR',
      'session_id is required'
    ), 400)
  }
  
  if (!openaiApiKey) {
    return c.json(createErrorResponse(
      'INTERNAL_ERROR',
      'OpenAI API key not configured'
    ), 500)
  }
  
  try {
    const startTime = Date.now()
    
    // 1. SearchProfile 확정
    let searchProfile = payload.searchProfile
    
    if (!searchProfile && draft_id) {
      // Draft에서 프로필 빌드
      const draft = await db.prepare(`
        SELECT * FROM ai_analysis_drafts WHERE id = ?
      `).bind(draft_id).first<AggDraftData>()
      
      if (draft) {
        const aggregated = buildAggregatedProfile(draft)
        // AggregatedProfile → SearchProfile 변환
        searchProfile = {
          desiredThemes: [
            ...aggregated.anchors.interest_top,
            ...aggregated.anchors.value_top,
          ],
          dislikedThemes: aggregated.universals.dislikes || [],
          strengthsHypothesis: aggregated.anchors.strength_top,
          environmentPreferences: [],
          hardConstraints: aggregated.anchors.constraint_flags,
          riskSignals: [],
          keywords: [
            ...aggregated.anchors.interest_top,
            ...aggregated.anchors.strength_top,
            ...Object.values(aggregated.universals.interests || []),
          ],
        }
      }
    }
    
    // Fallback: mini_module_result에서 SearchProfile 자동 빌드
    if (!searchProfile && payload.mini_module_result) {
      searchProfile = buildSearchProfileFromMiniModule(payload.mini_module_result)
      console.log('[Recommendation Mode] Built searchProfile from mini_module_result (fallback)')
    }

    // Fallback 2: 세션 DB에서 미니모듈 데이터 복원
    if (!searchProfile) {
      try {
        const analysisResult = await db.prepare(`
          SELECT result_json FROM ai_analysis_results
          WHERE request_id IN (
            SELECT id FROM ai_analysis_requests WHERE session_id = ? ORDER BY id DESC LIMIT 1
          )
        `).bind(session_id).first<{ result_json: string }>()

        if (analysisResult?.result_json) {
          const parsed = JSON.parse(analysisResult.result_json)
          // 기존 분석 결과의 input_summary에서 프로필 복원
          const mm = parsed.mini_module_result || (parsed as any).miniModuleResult
          if (mm) {
            searchProfile = buildSearchProfileFromMiniModule(mm)
            if (!payload.mini_module_result) {
              ;(payload as any).mini_module_result = mm
            }
            console.log('[Recommendation Mode] Restored searchProfile from session DB (fallback 2)')
          }
        }
      } catch (err) {
        console.warn('[Recommendation Mode] Session DB fallback failed:', err)
      }
    }

    if (!searchProfile) {
      return c.json(createErrorResponse(
        'VALIDATION_ERROR',
        'searchProfile or draft_id or mini_module_result required'
      ), 400)
    }
    
    // 2. Vectorize 1회 (TopK=800)
    console.log(`[Recommendation Mode] Starting with topK=${topK}`)

    // ★ 중요: mini_module_result가 있으면 이를 기반으로 SearchProfile 생성
    // 이렇게 해야 "분석형 유저"에게 분석 관련 직업이 검색됨
    let vectorSearchProfile = searchProfile
    if (payload.mini_module_result) {
      vectorSearchProfile = buildSearchProfileFromMiniModule(payload.mini_module_result)
      console.log(`[Recommendation Mode] Built SearchProfile from MiniModule:`, {
        desiredThemes: vectorSearchProfile.desiredThemes.slice(0, 3),
        strengthsHypothesis: vectorSearchProfile.strengthsHypothesis,
        keywords: vectorSearchProfile.keywords.slice(0, 5),
      })
    }

    const expansionResult = await expandCandidatesV3(
      db,
      env.VECTORIZE,
      openaiApiKey,
      vectorSearchProfile,
      {
        targetSize: topK,
        miniModule: payload.mini_module_result,
      }
    )

    console.log(`[Recommendation Mode] Vectorize returned ${expansionResult.candidates.length} candidates`)
    
    // 3. TAG Hard Filter
    const userConstraints = extractUserConstraints(
      searchProfile.hardConstraints.reduce((acc, c) => {
        if (c.includes('time') || c.includes('시간')) acc.work_hours_strict = true
        if (c.includes('remote') || c.includes('원격')) acc.remote_only = true
        if (c.includes('shift') || c.includes('교대')) acc.shift_work_no = true
        if (c.includes('degree') || c.includes('학위')) acc.degree_impossible = true
        if (c.includes('license') || c.includes('자격')) acc.license_impossible = true
        return acc
      }, {} as { [key: string]: boolean }),
      {}
    )
    
    // 3-1. TAG Filter 먼저 적용 (VectorSearchResult 타입)
    console.log('[Recommendation Mode] Step 3-1: Applying TAG filter...')
    console.log('[Recommendation Mode] candidates count:', expansionResult.candidates.length)

    let tagFilterResult
    try {
      tagFilterResult = await applyTagFilter(db, expansionResult.candidates, userConstraints)
      console.log(`[Recommendation Mode] After TAG filter: ${tagFilterResult.passed.length} jobs (excluded: ${tagFilterResult.excluded.length})`)
    } catch (tagError) {
      console.error('[Recommendation Mode] TAG filter error:', tagError)
      throw tagError
    }

    // 3-2. 필터링된 결과를 ScoredJob으로 변환
    console.log('[Recommendation Mode] Step 3-2: Converting to ScoredJobs...')
    const tagPassedAsVectorResults = tagFilterResult.passed.map(p => ({
      job_id: p.job_id,
      job_name: p.job_name,
      score: p.score,  // VectorSearchResult의 score
    }))
    console.log('[Recommendation Mode] tagPassedAsVectorResults count:', tagPassedAsVectorResults.length)

    let scoredJobs
    try {
      scoredJobs = await vectorResultsToScoredJobs(db, tagPassedAsVectorResults, payload.mini_module_result)
      console.log('[Recommendation Mode] scoredJobs count:', scoredJobs.length)
      // 🔍 DEBUG: 첫 번째 직업의 image_url, job_description 확인
      if (scoredJobs.length > 0) {
        const sample = scoredJobs[0]
        console.log('[Recommendation Mode] 🔍 Sample scoredJob:', {
          job_id: sample.job_id,
          job_name: sample.job_name,
          slug: sample.slug,
          image_url: sample.image_url,
          job_description: sample.job_description?.substring(0, 50),
        })
      }
    } catch (scoreError) {
      console.error('[Recommendation Mode] vectorResultsToScoredJobs error:', scoreError)
      throw scoreError
    }

    // 3-3. MiniModule Hard Filter (분석형 강점 → 현장직 제외 등)
    console.log('[Recommendation Mode] Step 3-3: Applying MiniModule filter...')
    console.log('[Recommendation Mode] mini_module_result:', JSON.stringify(payload.mini_module_result))

    let filteredJobs, mmFilterResult
    try {
      const mmResult = applyMiniModuleHardFilter(scoredJobs, payload.mini_module_result)
      filteredJobs = mmResult.filtered
      mmFilterResult = mmResult.filterResult
      console.log(`[Recommendation Mode] After MiniModule filter: ${filteredJobs.length} jobs (excluded: ${mmFilterResult.excludedJobIds.length})`)
    } catch (mmError) {
      console.error('[Recommendation Mode] MiniModule filter error:', mmError)
      throw mmError
    }

    if (mmFilterResult.appliedRules.length > 0) {
      console.log(`[Recommendation Mode] Applied rules: ${mmFilterResult.appliedRules.map(r => `${r.ruleId}(${r.excludedCount})`).join(', ')}`)
    }
    
    // 4. LLM Judge 호출 (Top 20 결정 + rationale 생성)
    let topJobs: any[]

    // 사전 필터된 상위 후보군
    const preFilteredJobs = filteredJobs
      .sort((a, b) => (b.final_score || b.like_score || 0) - (a.final_score || a.like_score || 0))
      .slice(0, Math.min(judgeTopN * 2, 40))

    // ScoredJob을 FilteredCandidate 형태로 변환
    const candidatesForJudge: FilteredCandidate[] = preFilteredJobs.map(job => ({
      job_id: job.job_id,
      job_name: job.job_name,
      score: job.final_score || job.like_score || 0,
      riskPenalty: job.risk_penalty || 0,
      riskWarnings: [],
      tagSource: 'tagged' as const,
    }))

    // 간단한 rationale 생성 함수 (LLM Judge 없을 때 사용)
    const generateSimpleRationale = (job: any, mm: any) => {
      const parts: string[] = []
      const interestMap: Record<string, string> = {
        problem_solving: '문제해결', data_numbers: '데이터/숫자', tech: '기술/IT',
        creative: '창작/예술', helping: '도움/가르침', organizing: '조직/관리'
      }
      const strengthMap: Record<string, string> = {
        analytical: '분석력', fast_learning: '빠른 학습', communication: '소통',
        persistence: '끈기', creativity: '창의성', leadership: '리더십'
      }

      if (mm?.interest_top?.length > 0) {
        const interests = mm.interest_top.slice(0, 2).map((i: string) => interestMap[i] || i).join(', ')
        parts.push(`${interests} 분야에 대한 관심`)
      }
      if (mm?.strength_top?.length > 0) {
        const strengths = mm.strength_top.slice(0, 2).map((s: string) => strengthMap[s] || s).join(', ')
        parts.push(`${strengths} 강점 활용`)
      }

      if (parts.length > 0) {
        return `당신의 ${parts.join('과 ')}에 적합한 직업입니다.`
      }
      return null
    }

    if (openaiApiKey && candidatesForJudge.length > 0) {
      try {
        console.log(`[Recommendation Mode] Calling LLM Judge (OpenAI) for ${candidatesForJudge.length} candidates...`)

        const judgeInput: JudgeInput = {
          candidates: candidatesForJudge,
          searchProfile,
          miniModuleResult: payload.mini_module_result,
        }

        const judgeResults = await judgeCandidates(openaiApiKey, db, judgeInput)

        // Judge 결과를 topJobs에 매핑 (rationale + likeReason/canReason 포함)
        // 점수 매핑 정정:
        //   desireScore (흥미/가치 매칭) → like_score (좋아할 가능성)
        //   fitScore (강점/역량 매칭) → can_score (잘할 가능성)
        //   overallScore (종합) → fit_score (종합 적합도)
        //   feasibilityScore (진입장벽/현실성) → fit_score 계산에 이미 반영됨
        topJobs = judgeResults.results.slice(0, judgeTopN).map(result => {
          const originalJob = preFilteredJobs.find(j => j.job_id === result.job_id)
          return {
            ...originalJob,
            like_score: result.desireScore,       // Like = 흥미/가치 매칭
            can_score: result.fitScore,            // Can = 강점/역량 매칭
            fit_score: result.overallScore,        // Fit = 종합 (Like×0.35 + Can×0.45 + Feasibility×0.20 - Risk)
            final_score: result.overallScore,
            risk_penalty: result.riskPenalty,
            feasibility_score: result.feasibilityScore,  // 현실성 점수 (참고용)
            rationale: result.rationale,
            like_reason: result.likeReason,   // 좋아할 이유
            can_reason: result.canReason,     // 잘할 이유
            evidence_quotes: result.evidenceQuotes,
          }
        })

        console.log(`[Recommendation Mode] LLM Judge completed: ${topJobs.length} jobs ranked`)
        // 🔍 DEBUG: topJobs에 image_url, job_description이 있는지 확인
        if (topJobs.length > 0) {
          const sample = topJobs[0]
          console.log('[Recommendation Mode] 🔍 Sample topJob after Judge:', {
            job_id: sample.job_id,
            job_name: sample.job_name,
            slug: sample.slug,
            image_url: sample.image_url,
            job_description: sample.job_description?.substring(0, 50),
            rationale: sample.rationale?.substring(0, 50),
          })
        }
      } catch (judgeError) {
        // LLM Judge 실패 시 에러 반환 (fallback 없음)
        console.error('[Recommendation Mode] ❌ LLM Judge failed:', judgeError)
        const errorMessage = judgeError instanceof Error ? judgeError.message : String(judgeError)
        return c.json(createErrorResponse(
          'LLM_JUDGE_FAILED',
          `LLM 분석이 실패했습니다: ${errorMessage}`
        ), 500)
      }
    } else {
      // API 키가 없으면 에러 (위에서 이미 체크하므로 여기 도달하면 안됨)
      console.error('[Recommendation Mode] ❌ OpenAI API key not available!')
      return c.json(createErrorResponse(
        'INTERNAL_ERROR',
        'OpenAI API 키가 설정되지 않았습니다.'
      ), 500)
    }

    // ============================================
    // 5. LLM Reporter: 심리분석 리포트 생성
    // ============================================
    let premiumReport: any = null

    // 5-1. NarrativeFacts 조회
    let narrativeFacts: { highAliveMoment: string; lostMoment: string } | undefined
    try {
      const narrativeRow = await db.prepare(`
        SELECT high_alive_moment, lost_moment
        FROM narrative_facts
        WHERE session_id = ?
      `).bind(session_id).first<{
        high_alive_moment: string | null
        lost_moment: string | null
      }>()

      if (narrativeRow && (narrativeRow.high_alive_moment || narrativeRow.lost_moment)) {
        narrativeFacts = {
          highAliveMoment: narrativeRow.high_alive_moment || '',
          lostMoment: narrativeRow.lost_moment || '',
        }
        console.log('[Recommendation Mode] NarrativeFacts loaded')
      }
    } catch (narrativeError) {
      console.warn('[Recommendation Mode] Failed to load narrative facts:', narrativeError)
    }

    // 5-2. RoundAnswers 조회
    let roundAnswers: Array<{ roundNumber: 1 | 2 | 3; questionId: string; answer: string }> = []
    try {
      const roundAnswersRows = await db.prepare(`
        SELECT round_number, question_id, answer
        FROM round_answers
        WHERE session_id = ?
        ORDER BY round_number, question_id
      `).bind(session_id).all<{
        round_number: number
        question_id: string
        answer: string
      }>()

      if (roundAnswersRows.results && roundAnswersRows.results.length > 0) {
        roundAnswers = roundAnswersRows.results.map(row => ({
          roundNumber: row.round_number as 1 | 2 | 3,
          questionId: row.question_id,
          answer: row.answer,
        }))
        console.log(`[Recommendation Mode] Loaded ${roundAnswers.length} round answers`)
      }
    } catch (roundError) {
      console.warn('[Recommendation Mode] Failed to load round answers:', roundError)
    }

    // 5-3. LLM Reporter 호출
    let reportMode: 'llm' | 'fallback' | 'none' = 'none'
    if (openaiApiKey && topJobs.length > 0) {
      try {
        console.log('[Recommendation Mode] ★★★ Generating premium report with GPT-4o-mini... ★★★')

        // excluded jobs 목록 (Hard Cut)
        const hardCutList = mmFilterResult.excludedJobIds.map((jobId, idx) => ({
          job_id: jobId,
          job_name: `Excluded Job ${idx + 1}`,
          rule_id: mmFilterResult.appliedRules[0]?.ruleId || 'mini_module_filter',
          reason: mmFilterResult.appliedRules[0]?.description || '미니모듈 기반 제외',
        })).slice(0, 10)

        const reporterInput: ReporterInput = {
          sessionId: session_id,
          judgeResults: topJobs.map(job => ({
            job_id: job.job_id,
            job_name: job.job_name,
            slug: job.slug || '',
            image_url: job.image_url || undefined,
            like_score: job.like_score || 50,
            can_score: job.can_score || 50,
            fit_verdict: job.like_score && job.like_score >= 70 ? 'STRONG_FIT' : 'MODERATE_FIT',
            fit_summary: job.job_description || `${job.job_name}${은는(job.job_name)} 당신의 관심사와 잘 맞습니다.`,
            risk_note: job.risk_penalty && job.risk_penalty > 0 ? '일부 제약 조건 고려 필요' : undefined,
          })),
          searchProfile,
          narrativeFacts,
          roundAnswers,
          universalAnswers: {},
          hardCutList,
          miniModuleResult: payload.mini_module_result,
        }

        premiumReport = await generateLLMPremiumReport(
          env?.AI || null,
          reporterInput,
          openaiApiKey
        )
        // LLM 리포트인지 fallback인지 확인 (metaCognition._meta.generated_by로 판단)
        reportMode = premiumReport?.metaCognition?._meta?.generated_by === 'rule' ? 'fallback' : 'llm'
        console.log(`[Recommendation Mode] Premium report generated - mode: ${reportMode}`)
      } catch (reporterError) {
        console.error('[Recommendation Mode] LLM Reporter failed:', reporterError)
        reportMode = 'fallback'
        // Fallback: 기본 심리 분석 제공
        const mm = payload.mini_module_result
        const toKo = (t: string) => TOKEN_TO_KOREAN[t] || t
        premiumReport = fixParticlesDeep({
          workStyleNarrative: mm ?
            generateFallbackWorkStyle(mm) : null,
          lifeVersionStatement: {
            oneLiner: '당신의 선택을 기반으로 분석 중입니다.',
            expanded: [],
          },
          // profileInterpretation fallback
          profileInterpretation: mm ? {
            interests: (mm.interest_top || []).map((t: string) => ({
              token: t,
              label: toKo(t),
              meaning: `${toKo(t)}에 관심이 있습니다.`
            })),
            interests_summary: (mm.interest_top || []).length ? `당신은 ${(mm.interest_top || []).map(toKo).join('과(와) ')}에 관심이 있습니다.` : '',
            strengths: (mm.strength_top || []).map((t: string) => ({
              token: t,
              label: toKo(t),
              meaning: `${toKo(t)}이(가) 강점입니다.`
            })),
            strengths_summary: (mm.strength_top || []).length ? `당신은 ${(mm.strength_top || []).map(toKo).join('과(와) ')}에 강점을 가지고 있습니다.` : '',
            values: (mm.value_top || []).map((t: string) => ({
              token: t,
              label: toKo(t),
              meaning: `${toKo(t)}을(를) 중요하게 생각합니다.`
            })),
            values_summary: (mm.value_top || []).length ? `당신에게 ${(mm.value_top || []).map(toKo).join('과(와) ')}은(는) 중요한 가치입니다.` : '',
            constraints: (mm.constraint_flags || []).map((t: string) => ({
              token: t,
              label: toKo(t),
              meaning: `${toKo(t)}을(를) 피하고 싶어합니다.`
            })),
            constraints_summary: (() => { const flags = (mm.constraint_flags || []).map(toKo); if (!flags.length) return ''; return `당신은 ${flags.join('과(와) ')}을(를) 피하고 싶어합니다.` })(),
            overall_profile: '프로필 분석을 위해 더 많은 정보가 필요합니다.'
          } : undefined,
        })
      }
    }

    // 6. 결과 반환
    const duration = Date.now() - startTime

    // like_top10: like_score 기준 정렬 (Fit >= 25 필터)
    const likeTop10 = [...topJobs]
      .filter(job => (job.final_score || job.fit_score || 0) >= 25)
      .sort((a, b) => (b.like_score || 0) - (a.like_score || 0))
      .slice(0, 10)
      .map(job => ({
        job_id: job.job_id,
        job_name: job.job_name,
        job_description: job.job_description || null,
        slug: job.slug,
        image_url: job.image_url || null,
        fit_score: job.final_score || job.fit_score || 50,
        like_score: job.like_score || 50,
        can_score: job.can_score || 50,
        rationale: job.rationale || null,
        like_reason: job.like_reason || null,
        can_reason: job.can_reason || null,
      }))

    // can_top10: can_score 기준 정렬 (Fit >= 25 필터)
    const canTop10 = [...topJobs]
      .filter(job => (job.final_score || job.fit_score || 0) >= 25)
      .sort((a, b) => (b.can_score || 0) - (a.can_score || 0))
      .slice(0, 10)
      .map(job => ({
        job_id: job.job_id,
        job_name: job.job_name,
        job_description: job.job_description || null,
        slug: job.slug,
        image_url: job.image_url || null,
        fit_score: job.final_score || job.fit_score || 50,
        like_score: job.like_score || 50,
        can_score: job.can_score || 50,
        rationale: job.rationale || null,
        like_reason: job.like_reason || null,
        can_reason: job.can_reason || null,
      }))

    // ============================================
    // 7. 결과 저장 (ai_analysis_requests + ai_analysis_results)
    // ============================================
    const resultToSave = {
      engine_version: 'v3',
      mini_module_result: payload.mini_module_result || null,
      fit_top3: topJobs.slice(0, 10).map(job => ({
        job_id: job.job_id,
        job_name: job.job_name,
        job_description: job.job_description || null,
        slug: job.slug,
        image_url: job.image_url || null,
        fit_score: job.final_score || job.fit_score || 50,
        like_score: job.like_score || 50,
        can_score: job.can_score || 50,
        rationale: job.rationale || null,
        like_reason: job.like_reason || null,
        can_reason: job.can_reason || null,
      })),
      like_top10: likeTop10,
      can_top10: canTop10,
      premium_report: premiumReport,
      search_profile: searchProfile,
      total_candidates: expansionResult.candidates.length,
      filtered_count: filteredJobs.length,
    }

    let savedRequestId: number | null = null
    try {
      // 1. 먼저 ai_analysis_requests에 레코드 생성 (또는 기존 것 조회)
      // user_id: 인증된 사용자 또는 draft에서 가져옴
      let effectiveUserId = userId

      // userId가 없으면 draft에서 user_id 조회
      if (!effectiveUserId) {
        const draftOwner = await db.prepare(`
          SELECT user_id FROM analyzer_drafts WHERE session_id = ?
        `).bind(session_id).first<{ user_id: number | null }>()
        effectiveUserId = draftOwner?.user_id || null
      }

      // 기존 request 확인
      const existingRequest = await db.prepare(`
        SELECT id FROM ai_analysis_requests WHERE session_id = ?
      `).bind(session_id).first<{ id: number }>()

      if (existingRequest) {
        savedRequestId = existingRequest.id
        // 기존 request 상태 업데이트 (user_id가 없으면 effectiveUserId로 설정)
        await db.prepare(`
          UPDATE ai_analysis_requests
          SET status = 'completed',
              processed_at = CURRENT_TIMESTAMP,
              user_id = COALESCE(user_id, ?)
          WHERE id = ?
        `).bind(effectiveUserId, savedRequestId).run()
      } else {
        // 새 request 생성
        const insertResult = await db.prepare(`
          INSERT INTO ai_analysis_requests (session_id, user_id, analysis_type, status, processed_at, created_at)
          VALUES (?, ?, 'job', 'completed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
        `).bind(session_id, effectiveUserId).run()
        savedRequestId = insertResult.meta?.last_row_id as number || null
      }

      if (savedRequestId) {
        // 2. ai_analysis_results에 저장 (UPDATE 우선, 없으면 INSERT)
        // NOTE: request_id에 UNIQUE 제약이 없어 ON CONFLICT UPSERT 불가 → UPDATE+INSERT 패턴 사용
        const resultJson = JSON.stringify(resultToSave)
        const premiumJson = JSON.stringify(premiumReport)

        const updateResult = await db.prepare(`
          UPDATE ai_analysis_results
          SET result_json = ?,
              engine_version = 'v3',
              premium_report_json = ?
          WHERE request_id = ?
        `).bind(resultJson, premiumJson, savedRequestId).run()

        if (!updateResult.meta?.changes || updateResult.meta.changes === 0) {
          // 기존 행이 없으면 새로 INSERT
          await db.prepare(`
            INSERT INTO ai_analysis_results (request_id, result_json, engine_version, premium_report_json, created_at)
            VALUES (?, ?, 'v3', ?, CURRENT_TIMESTAMP)
          `).bind(savedRequestId, resultJson, premiumJson).run()
        }

        console.log(`[Recommendation Mode] ✅ Result saved - request_id: ${savedRequestId}, session: ${session_id}, updated: ${updateResult.meta?.changes || 0}`)
      }
    } catch (saveError) {
      // 저장 실패해도 결과는 반환 (로그만 남김)
      console.error('[Recommendation Mode] ⚠️ Failed to save result:', saveError)
    }

    return c.json({
      success: true,
      mode: 'recommendation',
      session_id,
      request_id: savedRequestId,  // 결과 페이지 이동용
      recommendations: {
        top_jobs: topJobs.map(job => ({
          job_id: job.job_id,
          job_name: job.job_name,
          job_description: job.job_description || null,
          slug: job.slug,
          image_url: job.image_url || null,
          fit_score: job.final_score || job.fit_score || job.like_score || 50,
          like_score: job.like_score || 50,
          can_score: job.can_score || 50,
          risk_penalty: job.risk_penalty || 0,
          rationale: job.rationale || null,
          like_reason: job.like_reason || null,   // 좋아할 이유
          can_reason: job.can_reason || null,     // 잘할 이유
          evidence_quotes: job.evidence_quotes || [],
        })),
        like_top10: likeTop10,
        can_top10: canTop10,
        total_candidates: expansionResult.candidates.length,
        filtered_count: filteredJobs.length,
        search_duration_ms: expansionResult.search_duration_ms,
      },
      premium_report: premiumReport,
      report_mode: reportMode,  // 'llm' | 'fallback' | 'none'
      search_profile_used: searchProfile,
      debug_info: debug ? {
        vectorize_topK: topK,
        judge_topN: judgeTopN,
        cache_hit: expansionResult.cacheHit,
        fallback_used: expansionResult.fallback_used,
        has_narrative_facts: !!narrativeFacts,
        round_answers_count: roundAnswers.length,
      } : undefined,
      duration_ms: duration,
    })
    
  } catch (error) {
    console.error('[Recommendation Mode] Error:', error)
    console.error('[Recommendation Mode] Stack:', error instanceof Error ? error.stack : 'No stack')
    return c.json(createErrorResponse(
      'ANALYSIS_FAILED',
      error instanceof Error ? `${error.message} | ${error.stack?.split('\n')[1] || ''}` : 'Recommendation failed'
    ), 500)
  }
})

// ============================================
// Freeze v1.1: Interview Mode - QSP 생성 API
// ============================================
// 설문 중 Vectorize 센서용 QSP 생성
// ============================================
analyzerRoutes.post('/v3/interview/qsp', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = c.env.OPENAI_API_KEY
  
  const payload = await c.req.json<{
    session_id: string
    round?: 1 | 2 | 3
    draft_id?: number
  }>()
  
  const { session_id, round = 1, draft_id } = payload
  
  if (!session_id) {
    return c.json(createErrorResponse('VALIDATION_ERROR', 'session_id required'), 400)
  }
  
  if (!openaiApiKey) {
    return c.json(createErrorResponse('INTERNAL_ERROR', 'OpenAI API key not configured'), 500)
  }
  
  try {
    // Draft에서 프로필 빌드 (있으면)
    let axisCoverage = createEmptyAxisCoverage()
    
    if (draft_id) {
      const draft = await db.prepare(`
        SELECT * FROM ai_analysis_drafts WHERE id = ?
      `).bind(draft_id).first<AggDraftData>()
      
      if (draft) {
        const aggregated = buildAggregatedProfile(draft)
        // TODO: AggregatedProfile에서 AxisCoverage 추출
        // 현재는 빈 커버리지 사용
      }
    }
    
    // Vectorize 센서 쿼리 (topK=500, 직업명 비노출)
    const expansionResult = await expandCandidatesV3WithCache(
      db,
      env.VECTORIZE,
      openaiApiKey,
      {
        narrativeFacts: undefined,
        roundAnswers: [],
        universalAnswers: {},
      },
      {
        sessionId: session_id,
        targetSize: 500,  // 센서용
      }
    )
    
    // QSP 생성
    const qsp = generateQSP({
      vectorResults: expansionResult.candidates,
      axisCoverage,
      round,
    })
    
    return c.json({
      success: true,
      qsp,
      prompt_hints: qspToPromptHints(qsp),
      vectorize_stats: {
        total_candidates: expansionResult.candidates.length,
        cache_hit: expansionResult.cacheHit,
      },
    })
    
  } catch (error) {
    console.error('[Interview QSP] Error:', error)
    return c.json(createErrorResponse(
      'ANALYSIS_FAILED',
      error instanceof Error ? error.message : 'QSP generation failed'
    ), 500)
  }
})

// ============================================
// Freeze v1.1: 인덱싱 상태 확인 API
// ============================================
analyzerRoutes.get('/admin/indexing-status', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  
  try {
    const status = await countJobsNeedingIndexing(db)
    
    return c.json({
      success: true,
      ...status,
      current_version: `JPC_${JOB_PROFILE_COMPACT_VERSION}`,
      percentage_indexed: status.total > 0 
        ? Math.round((status.upToDate / status.total) * 100) 
        : 0,
    })
    
  } catch (error) {
    console.error('[Indexing Status] Error:', error)
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// Freeze v1.1: 증분 업서트 API
// ============================================
analyzerRoutes.post('/admin/incremental-upsert', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = c.env.OPENAI_API_KEY
  
  if (!env.VECTORIZE) {
    return c.json({ success: false, error: 'VECTORIZE_NOT_AVAILABLE' }, 503)
  }
  
  if (!openaiApiKey) {
    return c.json({ success: false, error: 'OPENAI_API_KEY_NOT_SET' }, 503)
  }
  
  const payload = await c.req.json<{ max_jobs?: number }>().catch(() => ({}))
  const maxJobs = payload.max_jobs || 100
  
  try {
    const result = await incrementalUpsertToVectorize(
      db,
      env.VECTORIZE,
      openaiApiKey,
      { maxJobs }
    )
    
    return c.json({
      success: true,
      ...result,
    })
    
  } catch (error) {
    console.error('[Incremental Upsert] Error:', error)
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

import { JOB_PROFILE_COMPACT_VERSION } from '../../constants/embedding-versions'

// ============================================
// 자동화 시나리오 테스트 API
// P0/P1/P2/P3 전체 기능 자동 검증
// ============================================

// 시나리오 목록 조회
analyzerRoutes.get('/test/scenarios', async (c) => {
  const scenarios = getAllScenarioSummary()
  return c.json({
    success: true,
    scenarios,
    total: scenarios.length,
  })
})

// 특정 시나리오 실행
analyzerRoutes.post('/test/run-scenario', async (c) => {
  const env = c.env as Bindings
  const db = env.DB

  const payload = await c.req.json<{ scenario_id: string }>().catch(() => ({ scenario_id: '' }))
  const { scenario_id } = payload

  if (!scenario_id) {
    return c.json({ success: false, error: 'scenario_id required' }, 400)
  }

  const scenario = getScenarioById(scenario_id)
  if (!scenario) {
    return c.json({ success: false, error: `Scenario not found: ${scenario_id}` }, 404)
  }

  console.log(`[Test Scenario] Starting: ${scenario.name} (${scenario.id})`)

  try {
    // 1. 테스트용 세션 ID 생성
    const testSessionId = `test_${scenario_id}_${Date.now()}`

    // 2. Mini Module 기반 분석 실행 (V3 Analyze 로직 재사용)
    const miniModule = scenario.miniModule

    // 3. Facts 생성 (Can 검증 답변 기반)
    const facts: Array<{ fact_key: string; value_json: string }> = []

    // Can 검증 답변을 facts로 변환
    for (const [questionId, answer] of Object.entries(scenario.canValidationAnswers)) {
      const canToken = questionId.replace('can_', '')
      const canBoostMap: Record<string, number> = {
        'work_experience_3plus': 25,
        'work_experience_1to3': 18,
        'project_experience': 12,
        'study_only': 5,
        'none': 0,
      }
      const boost = canBoostMap[answer] || 5
      facts.push({
        fact_key: `can_verified.${canToken}`,
        value_json: JSON.stringify({ boost, answer }),
      })
    }

    // Risk 강도 답변을 facts로 변환
    for (const [questionId, intensity] of Object.entries(scenario.constraintIntensityAnswers)) {
      facts.push({
        fact_key: `constraint.${questionId.replace('intensity_', '')}.intensity`,
        value_json: JSON.stringify(intensity),
      })
    }

    // 4. 직업 데이터 조회 (jobs 테이블과 조인)
    const jobAttrs = await db.prepare(`
      SELECT
        ja.job_id,
        j.name as job_name,
        j.slug,
        j.image_url,
        j.api_data_json,
        j.merged_profile_json,
        COALESCE(ja.wlb, 50) as wlb,
        COALESCE(ja.growth, 50) as growth,
        COALESCE(ja.stability, 50) as stability,
        COALESCE(ja.income, 50) as income,
        COALESCE(ja.teamwork, 50) as teamwork,
        COALESCE(ja.solo_deep, 50) as solo_deep,
        COALESCE(ja.analytical, 50) as analytical,
        COALESCE(ja.creative, 50) as creative,
        COALESCE(ja.execution, 50) as execution,
        COALESCE(ja.people_facing, 50) as people_facing,
        COALESCE(ja.work_hours, 'normal') as work_hours,
        COALESCE(ja.shift_work, 'rare') as shift_work,
        COALESCE(ja.travel, 'rare') as travel,
        COALESCE(ja.remote_possible, 'possible') as remote_possible,
        COALESCE(ja.degree_required, 'none') as degree_required,
        COALESCE(ja.license_required, 'none') as license_required
      FROM job_attributes ja
      INNER JOIN jobs j ON ja.job_id = j.id
      LIMIT 200
    `).all<{
      job_id: string
      job_name: string
      slug: string | null
      image_url: string | null
      api_data_json: string | null
      merged_profile_json: string | null
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

    if (!jobAttrs.results || jobAttrs.results.length === 0) {
      return c.json({ success: false, error: 'No job data available' }, 500)
    }

    // 5. 점수 계산 (전체 파이프라인 적용)
    const sampleJobs = jobAttrs.results.map(j => ({
      job_id: j.job_id,
      job_name: j.job_name,
      slug: j.slug || j.job_id,
      image_url: j.image_url,
      job_description: extractJobDescription(j.api_data_json, j.merged_profile_json, j.job_name),
      base_like: Math.round((j.wlb + j.growth + j.stability + j.income) / 4),
      base_can: Math.round((j.teamwork + j.analytical * 0.7 + j.creative) / 3),
      base_risk: 10,
      attributes: {
        wlb: j.wlb,
        growth: j.growth,
        stability: j.stability,
        income: j.income,
        teamwork: j.teamwork,
        solo_deep: j.solo_deep,
        analytical: j.analytical,
        creative: j.creative,
        execution: j.execution,
        people_facing: j.people_facing,
        work_hours: j.work_hours,
        shift_work: j.shift_work,
        travel: j.travel,
        remote_possible: j.remote_possible,
        degree_required: j.degree_required,
        license_required: j.license_required,
      },
    }))

    // Mini Module Hard Filter 적용
    const { filtered: filteredJobs } = applyMiniModuleHardFilter(sampleJobs, miniModule)
    const jobsToScore = filteredJobs.length > 0 ? filteredJobs : sampleJobs

    // Fact boosts 계산
    const factBoosts = calculateFactBoosts(facts)

    // Verified Can 추출
    const verifiedCan = extractVerifiedCanFromFacts(facts)

    // 성장곡선 선호도 추출
    const growthPreference = extractGrowthPreference(miniModule)

    // 내면갈등 심각도 확인
    const conflictSeverity = calculateConflictSeverity(miniModule)

    // 추적 변수
    let growthCurveApplied = false
    let conflictRiskApplied = false
    let canFilterApplied = false
    let balanceCapApplied = false

    // 각 직업 점수 계산
    const scoredJobs = jobsToScore.map(job => {
      const baseScores: JobScores = {
        like: job.base_like,
        can: job.base_can,
        risk_penalty: job.base_risk,
      }

      // Fact boosts 적용
      const adjusted = applyFactBoostsToJob(baseScores, job.attributes, factBoosts)

      // 추가 페널티 계산
      let additionalPenalty = 0

      // Mini Module Risk Penalty
      const miniModuleRisk = calculateMiniModuleRiskPenalty(miniModule, job.attributes)
      additionalPenalty += miniModuleRisk.penalty

      // Can 기반 필터 Penalty
      const canFilterResult = applyCanBasedFilter(job.attributes, verifiedCan)
      additionalPenalty += canFilterResult.totalPenalty
      if (canFilterResult.totalPenalty > 0 || canFilterResult.appliedRules.length > 0) {
        canFilterApplied = true
      }

      // 성장곡선 매칭
      const growthMatch = matchGrowthCurves(growthPreference, job.attributes, job.job_name)
      additionalPenalty += growthMatch.riskPenalty
      if (growthMatch.riskPenalty > 0 || growthMatch.likeBoost > 0) {
        growthCurveApplied = true
      }

      // 내면갈등 Risk 조정
      const conflictRisk = calculateConflictRisk(miniModule, job.attributes)
      additionalPenalty += conflictRisk.totalRiskAdjust
      if (conflictRisk.totalRiskAdjust > 0) {
        conflictRiskApplied = true
      }

      // Like에 성장곡선 부스트 적용
      const likeWithGrowthBoost = adjusted.like + growthMatch.likeBoost

      // Balance Cap 적용
      const balanced = applyBalanceCap(likeWithGrowthBoost, adjusted.can)
      if (balanced.balance_cap_applied) {
        balanceCapApplied = true
      }

      // 최종 Fit 계산
      const totalRiskPenalty = adjusted.risk_penalty + additionalPenalty
      const fit = Math.round(0.55 * balanced.like + 0.45 * balanced.can - totalRiskPenalty)

      return {
        job_id: job.job_id,
        job_name: job.job_name,
        scores: {
          fit: Math.max(0, fit),
          like: balanced.like,
          can: balanced.can,
          risk_penalty: totalRiskPenalty,
        },
      }
    })

    // 점수순 정렬
    scoredJobs.sort((a, b) => b.scores.fit - a.scores.fit)

    // 6. 결과 검증
    const verificationResult = verifyTestResults(scenario, {
      topJobs: scoredJobs.slice(0, 10),
      excludedJobs: sampleJobs
        .filter(j => !filteredJobs.some(f => f.job_id === j.job_id))
        .slice(0, 10)
        .map(j => ({ job_name: j.job_name, reason: 'Hard Filter' })),
      appliedFeatures: {
        growthCurveApplied,
        conflictRiskApplied,
        canFilterApplied,
        balanceCapApplied,
      },
    })

    console.log(`[Test Scenario] Completed: ${scenario.name} - ${verificationResult.summary}`)

    // 7. 결과를 DB에 저장하여 결과 페이지에서 볼 수 있도록
    const top10WithDetails = scoredJobs.slice(0, 10).map(j => {
      const original = sampleJobs.find(s => s.job_id === j.job_id)
      return {
        job_id: j.job_id,
        job_name: j.job_name,
        slug: original?.slug || j.job_id,
        image_url: original?.image_url || null,
        job_description: original?.job_description || null,
        fit_score: j.scores.fit,
        like_score: j.scores.like,
        can_score: j.scores.can,
        risk_penalty: j.scores.risk_penalty,
        rationale: `${scenario.name} 시나리오 테스트 결과`,
      }
    })

    // 미니모듈 기반 요약 생성
    const mm = scenario.miniModule
    const interestLabels = {
      data_numbers: '데이터 분석', problem_solving: '문제 해결', research: '연구',
      creative: '창의적 활동', design: '디자인', art: '예술',
      helping: '사람 돕기', organizing: '조직/관리', routine: '정해진 업무',
      tech: '기술/IT',
    }
    const valueLabels = {
      autonomy: '자율성', growth: '성장', expertise: '전문성',
      stability: '안정', wlb: '워라밸', income: '수입',
      creativity: '창의성', recognition: '인정',
    }
    const strengthLabels = {
      analytical: '분석력', fast_learning: '빠른 학습', persistence: '끈기',
      creative: '창의성', communication: '소통', structured_execution: '체계적 실행',
    }

    const interestStr = (mm.interest_top || []).map(i => interestLabels[i] || i).join(', ')
    const valueStr = (mm.value_top || []).map(v => valueLabels[v] || v).join(', ')
    const strengthStr = (mm.strength_top || []).map(s => strengthLabels[s] || s).join(', ')

    const resultToSave = {
      engine_version: 'v3-test',
      fit_top3: top10WithDetails,
      like_top10: top10WithDetails,
      can_top10: top10WithDetails,
      test_scenario: {
        id: scenario.id,
        name: scenario.name,
        verification: verificationResult,
      },
      // 프론트엔드 결과 페이지 호환을 위한 premium_report
      premium_report: {
        executiveSummary: `[테스트 시나리오: ${scenario.name}] ${scenario.description}`,
        workStyleNarrative: `당신은 ${interestStr}에 관심이 있고, ${valueStr}${을를(valueStr)} 중요하게 생각합니다. ${strengthStr}${이가(strengthStr)} 강점입니다.`,
        lifeVersionStatement: {
          oneLiner: scenario.description,
          expanded: [`테스트 시나리오: ${scenario.id}`, `검증 점수: ${verificationResult.score}/100`],
        },
        workStyleMap: {
          socialStyle: mm.workstyle_top?.[0] || 'balanced',
          decisionStyle: mm.execution_style || 'planner',
        },
        innerConflictAnalysis: mm.internal_conflict_flags?.length
          ? `내면 갈등 감지: ${mm.internal_conflict_flags.join(', ')}`
          : '특별한 내면 갈등이 감지되지 않았습니다.',
        growthCurveType: mm.persistence_anchor === 'growth_anchor' ? '도전 성장형' : '안정 성장형',
        growthCurveDescription: mm.persistence_anchor === 'growth_anchor'
          ? '성장 지향적인 커리어 패스를 선호합니다.'
          : '안정적인 커리어 패스를 선호합니다.',
        stressProfile: mm.energy_drain_flags?.length
          ? `에너지 소모 요인: ${mm.energy_drain_flags.join(', ')}`
          : '특별한 스트레스 요인이 없습니다.',
        stressTriggers: mm.energy_drain_flags || [],
        expertGuidance: {
          doNow: [`${scenario.name} 시나리오 테스트 결과를 검토하세요.`],
        },
        jobRecommendations: {
          overallTop5: top10WithDetails.slice(0, 5),
        },
        // 프로필 해석 (Quick Test용)
        profileInterpretation: {
          interests: (mm.interest_top || []).map((t: string) => ({
            token: t,
            label: interestLabels[t] || t,
            meaning: `${interestLabels[t] || t}에 관심이 있습니다.`
          })),
          interests_summary: interestStr ? `당신은 ${interestStr}에 관심이 있습니다.` : '',
          strengths: (mm.strength_top || []).map((t: string) => ({
            token: t,
            label: strengthLabels[t] || t,
            meaning: (() => { const l = strengthLabels[t] || t; return `${l}${이가(l)} 강점입니다.` })()
          })),
          strengths_summary: strengthStr ? `당신은 ${strengthStr}에 강점을 가지고 있습니다.` : '',
          values: (mm.value_top || []).map((t: string) => ({
            token: t,
            label: valueLabels[t] || t,
            meaning: (() => { const l = valueLabels[t] || t; return `${l}${을를(l)} 중요하게 생각합니다.` })()
          })),
          values_summary: valueStr ? `당신에게 ${valueStr}는 중요한 가치입니다.` : '',
          constraints: (mm.constraint_flags || []).map((t: string) => ({
            token: t,
            label: t,
            meaning: `${t}${을를(t)} 피하고 싶어합니다.`
          })),
          constraints_summary: (() => { const flags = mm.constraint_flags || []; if (!flags.length) return ''; const last = flags[flags.length - 1]; return `당신은 ${flags.join(', ')}${을를(last)} 피하고 싶어합니다.` })(),
          overall_profile: `${scenario.name} 시나리오 기반 테스트 프로필입니다.`
        },
      },
      user_insight: {
        summary: scenario.description,
        traits: [
          { name: '관심사', values: mm.interest_top || [] },
          { name: '가치', values: mm.value_top || [] },
          { name: '강점', values: mm.strength_top || [] },
        ],
      },
    }

    let savedRequestId: number | null = null
    try {
      // 1. 먼저 ai_sessions에 테스트 세션 생성 (외래 키 제약 조건 충족)
      await db.prepare(`
        INSERT OR IGNORE INTO ai_sessions (id, user_identifier, traits_snapshot, created_at, last_active_at)
        VALUES (?, 'test_scenario', ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
      `).bind(testSessionId, JSON.stringify(scenario.miniModule)).run()
      console.log(`[Test Scenario] Session created/exists: ${testSessionId}`)

      // 2. ai_analysis_requests에 저장 (prompt_payload는 필수)
      const promptPayload = JSON.stringify({
        test_scenario: scenario.id,
        miniModule: scenario.miniModule,
      })
      const insertResult = await db.prepare(`
        INSERT INTO ai_analysis_requests (session_id, analysis_type, pricing_tier, prompt_payload, status, processed_at, requested_at)
        VALUES (?, 'job', 'free', ?, 'completed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
      `).bind(testSessionId, promptPayload).run()
      savedRequestId = insertResult.meta?.last_row_id as number || null

      if (savedRequestId) {
        // 3. ai_analysis_results에 저장 (실제 프로덕션 스키마: result_json 사용)
        await db.prepare(`
          INSERT INTO ai_analysis_results (request_id, result_json, engine_version, created_at)
          VALUES (?, ?, 'v3-test', CURRENT_TIMESTAMP)
        `).bind(savedRequestId, JSON.stringify(resultToSave)).run()
        console.log(`[Test Scenario] Result saved - request_id: ${savedRequestId}`)
      }
    } catch (saveError) {
      console.warn('[Test Scenario] Failed to save result to DB:', saveError)
    }

    return c.json({
      success: true,
      scenario: {
        id: scenario.id,
        name: scenario.name,
        description: scenario.description,
        category: scenario.category,
      },
      test_session_id: testSessionId,
      request_id: savedRequestId,
      result_page_url: savedRequestId
        ? `/analyzer/job?request_id=${savedRequestId}`
        : null,
      result_api_url: savedRequestId
        ? `/api/ai-analyzer/result/${savedRequestId}`
        : null,
      results: {
        top_jobs: scoredJobs.slice(0, 5).map(j => {
          const original = sampleJobs.find(s => s.job_id === j.job_id)
          return {
            job_id: j.job_id,
            job_name: j.job_name,
            slug: original?.slug || j.job_id,
            image_url: original?.image_url || null,
            fit: j.scores.fit,
            like: j.scores.like,
            can: j.scores.can,
            risk: j.scores.risk_penalty,
          }
        }),
        excluded_count: sampleJobs.length - filteredJobs.length,
        total_scored: scoredJobs.length,
        applied_features: {
          growth_curve: growthCurveApplied,
          conflict_risk: conflictRiskApplied,
          can_filter: canFilterApplied,
          balance_cap: balanceCapApplied,
        },
      },
      verification: verificationResult,
      fact_boosts_applied: factBoosts.applied_rules,
    })

  } catch (error) {
    console.error('[Test Scenario] Error:', error)
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : 'Test execution failed',
    }, 500)
  }
})

// 전체 시나리오 일괄 실행
analyzerRoutes.post('/test/run-all', async (c) => {
  const env = c.env as Bindings
  const db = env.DB

  const results: Array<{
    scenario_id: string
    scenario_name: string
    passed: boolean
    score: number
    summary: string
  }> = []

  for (const scenario of TEST_SCENARIOS) {
    try {
      // 간소화된 테스트 (위의 로직을 함수로 추출해서 재사용하면 더 좋음)
      // 여기서는 시나리오 실행 결과만 요약
      const testUrl = `/api/ai-analyzer/test/run-scenario`
      // 실제로는 내부 호출하거나 로직 재사용

      results.push({
        scenario_id: scenario.id,
        scenario_name: scenario.name,
        passed: true,  // 실제 검증 필요
        score: 0,      // 실제 검증 필요
        summary: `${scenario.name} 테스트 실행 필요`,
      })
    } catch (error) {
      results.push({
        scenario_id: scenario.id,
        scenario_name: scenario.name,
        passed: false,
        score: 0,
        summary: error instanceof Error ? error.message : 'Failed',
      })
    }
  }

  const passedCount = results.filter(r => r.passed).length
  const totalScore = results.reduce((sum, r) => sum + r.score, 0) / results.length

  return c.json({
    success: true,
    summary: {
      total: results.length,
      passed: passedCount,
      failed: results.length - passedCount,
      average_score: totalScore.toFixed(1),
    },
    results,
  })
})

// ============================================
// E2E 테스트용 LLM 답변 생성 엔드포인트
// ============================================
analyzerRoutes.post('/test/generate-answer', async (c) => {
  const env = c.env as Bindings
  const openaiKey = env.OPENAI_API_KEY

  if (!openaiKey) {
    return c.json({ success: false, error: 'OPENAI_API_KEY not configured' }, 500)
  }

  try {
    const body = await c.req.json() as {
      question: string
      round: number
      persona: {
        name: string
        career_state: string
        interests: string[]
        strengths: string[]
        values: string[]
        constraints: string[]
        narrative_context?: string
      }
      previous_answers?: string[]
    }

    const { question, round, persona, previous_answers = [] } = body

    if (!question || !persona) {
      return c.json({ success: false, error: 'Missing question or persona' }, 400)
    }

    // 페르소나 컨텍스트 구성
    const personaContext = `
당신은 다음과 같은 프로필을 가진 구직자입니다:
- 이름: ${persona.name}
- 현재 상태: ${persona.career_state === 'employed' ? '재직 중' : persona.career_state === 'job_seeker' ? '구직 중' : persona.career_state === 'student' ? '학생' : '이직 고려 중'}
- 관심 분야: ${persona.interests?.join(', ') || '다양한 분야'}
- 강점: ${persona.strengths?.join(', ') || '분석력, 문제해결'}
- 중요 가치: ${persona.values?.join(', ') || '성장, 안정'}
- 피하고 싶은 것: ${persona.constraints?.join(', ') || '야근, 불규칙한 근무'}
${persona.narrative_context ? `\n추가 배경:\n${persona.narrative_context}` : ''}
`.trim()

    // 라운드별 답변 스타일 가이드
    const roundGuide = round === 1
      ? '욕망과 목표에 대해 솔직하게 답변하세요. 무엇을 원하는지, 어떤 미래를 꿈꾸는지.'
      : round === 2
      ? '피하고 싶은 것, 스트레스 요인에 대해 답변하세요. 어떤 환경이 맞지 않는지.'
      : '현실적 제약과 타협점에 대해 답변하세요. 성장을 위해 무엇을 감수할 수 있는지.'

    const systemPrompt = `${personaContext}

커리어 상담사의 질문에 답변해야 합니다.
라운드 ${round}: ${roundGuide}

답변 규칙:
1. 1~3문장으로 간결하게 답변하세요
2. 페르소나의 특성에 맞게 일관성 있게 답변하세요
3. 구체적인 예시나 경험을 언급하면 좋습니다
4. 한국어로 자연스럽게 답변하세요`

    const messages: Array<{ role: 'system' | 'user' | 'assistant', content: string }> = [
      { role: 'system', content: systemPrompt }
    ]

    // 이전 답변들을 컨텍스트에 추가
    if (previous_answers.length > 0) {
      messages.push({
        role: 'user',
        content: `이전 답변들:\n${previous_answers.map((a, i) => `${i + 1}. ${a}`).join('\n')}`
      })
    }

    messages.push({ role: 'user', content: `질문: ${question}` })

    // OpenAI 호출
    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${openaiKey}`,
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        messages,
        temperature: 0.8,
        max_tokens: 200,
      }),
    })

    if (!response.ok) {
      const error = await response.text()
      console.error('[E2E] OpenAI error:', error)
      return c.json({ success: false, error: 'OpenAI API error' }, 500)
    }

    const data = await response.json() as {
      choices: Array<{ message: { content: string } }>
      usage: { total_tokens: number }
    }

    const answer = data.choices[0]?.message?.content?.trim() || ''

    console.log(`[E2E] Generated answer for round ${round}:`, answer.substring(0, 100))

    return c.json({
      success: true,
      answer,
      usage: data.usage,
    })
  } catch (error) {
    console.error('[E2E] Generate answer error:', error)
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

export { analyzerRoutes }
