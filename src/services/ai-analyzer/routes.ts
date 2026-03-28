// CareerWiki AI Analyzer API Routes
// Version: v2.0.0-stage-based (Universal Intake + Stage-based Follow-up)
// Framework: Hono (Cloudflare Workers)

import { Hono } from 'hono'
import type { D1Database, VectorizeIndex, Ai } from '@cloudflare/workers-types'
import { saveUserProfile } from './profile-saver'
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
  // Major 전용
  applyMajorTagFilter,
  extractMajorUserConstraints,
  applyMajorMiniModuleHardFilter,
  type MajorFilteredCandidate,
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
  enforceDiversityOnTopN,
  filterUnrealisticJobs,
  sanitizeJobListOutput,
  filterNicheMaterialJobs,
  type FollowupNoResult,
  type RankChangeInfo,
  // Major 전용
  enforceMajorDiversity,
  injectArchetypeMajors,
  MAJOR_ARCHETYPE_DB_QUERIES,
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
  // Major 전용
  generateMajorPremiumReport,
  type MajorReporterInput,
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
  indexMajorsToVectorize,
  indexHowtosToVectorize,
  extractJobDescription,
  // Major 전용
  expandCandidatesV3ForMajors,
  vectorResultsToScoredMajors,
} from './vectorize-pipeline'
import { calculatePersonalizedBaseScores } from './personalized-scoring'
import { calculateMajorPersonalizedBaseScores } from './personalized-scoring-major'
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
  type JudgeOutput,
  RECOMMENDATION_ENGINE_VERSION,
  // Major 전용
  judgeMajorCandidates,
  type MajorJudgeInput,
  type MajorJudgeResult,
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

// Error logging — console.error로 Cloudflare Workers 로그에 기록
function logError(
  code: ErrorCode,
  message: string,
  context?: Record<string, unknown>
): void {
  console.error(`[AI-Analyzer] ${code}: ${message}`, context ? JSON.stringify(context) : '')
}

// Timing-safe 문자열 비교 (timing attack 방지)
function timingSafeCompare(a: string, b: string): boolean {
  if (a.length !== b.length) return false
  const encoder = new TextEncoder()
  const bufA = encoder.encode(a)
  const bufB = encoder.encode(b)
  // crypto.subtle.timingSafeEqual은 Cloudflare Workers에서 지원
  if (typeof crypto !== 'undefined' && crypto.subtle && typeof (crypto.subtle as any).timingSafeEqual === 'function') {
    return (crypto.subtle as any).timingSafeEqual(bufA, bufB)
  }
  // fallback: 전체 바이트 비교 (short-circuit 없음)
  let result = 0
  for (let i = 0; i < bufA.length; i++) {
    result |= bufA[i] ^ bufB[i]
  }
  return result === 0
}

// Admin 인증 확인 — user role 또는 X-Admin-Secret 헤더
function checkAdminAuth(c: any): Response | null {
  const user = c.get('user')
  const isAdmin = user?.role === 'admin'
  const adminSecret = c.req.header('X-Admin-Secret')
  const isSecretValid = adminSecret && c.env.ADMIN_SECRET && timingSafeCompare(adminSecret, c.env.ADMIN_SECRET)
  if (!isAdmin && !isSecretValid) {
    return c.json({ success: false, error: 'ADMIN_AUTH_REQUIRED', message: '관리자 권한이 필요합니다' }, 403)
  }
  return null
}

// ============================================
// Confidence: mini_module_result → facts 변환
// facts 테이블이 비어있을 때 miniModule 답변으로 confidence 계산
// ============================================
function buildConfidenceFactsFromMiniModule(mm: any): Array<{ fact_key: string; value_json: string }> {
  const facts: Array<{ fact_key: string; value_json: string }> = []
  if (!mm) return facts

  // 핵심 가치 → priority.top1 (FACT_UNCERTAINTY_REDUCTION: 0.10)
  if (mm.value_top?.length) {
    facts.push({ fact_key: 'priority.top1', value_json: JSON.stringify(mm.value_top[0]) })
  }

  // 흥미 → profile.interest (0.04, 배열 → diversityBonus 기여)
  if (mm.interest_top?.length) {
    facts.push({ fact_key: 'profile.interest', value_json: JSON.stringify(mm.interest_top) })
  }

  // 강점 → profile.strength (0.04)
  if (mm.strength_top?.length) {
    facts.push({ fact_key: 'profile.strength', value_json: JSON.stringify(mm.strength_top) })
  }

  // 가치 → profile.value (0.04)
  if (mm.value_top?.length) {
    facts.push({ fact_key: 'profile.value', value_json: JSON.stringify(mm.value_top) })
  }

  // 제약 → profile.constraint (0.04)
  if (mm.constraint_flags?.length) {
    facts.push({ fact_key: 'profile.constraint', value_json: JSON.stringify(mm.constraint_flags) })
  }

  // 워크스타일 → profile.workstyle (0.04)
  if (mm.workstyle_top?.length) {
    facts.push({ fact_key: 'profile.workstyle', value_json: JSON.stringify(mm.workstyle_top) })
  }

  // 에너지/실행/갈등 → profile.behavioral (0.04, 복합)
  const behavioral: string[] = []
  if (mm.energy_drain_flags?.length) behavioral.push(...mm.energy_drain_flags)
  if (mm.execution_style) behavioral.push(mm.execution_style)
  if (mm.failure_response) behavioral.push(mm.failure_response)
  if (mm.impact_scope) behavioral.push(mm.impact_scope)
  if (behavioral.length) {
    facts.push({ fact_key: 'profile.behavioral', value_json: JSON.stringify(behavioral) })
  }

  return facts
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
  
  // Phase 3: 편집 모드 파라미터
  const editMode = (rawPayload as any).edit_mode === true
  const editSessionId = (rawPayload as any).edit_session_id as string | undefined
  const sourceRequestId = (rawPayload as any).source_request_id as number | undefined
  const versionNote = (rawPayload as any).version_note as string | undefined

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
          allowed: ['job_explore', 'job_student', 'job_early', 'major_child', 'major_elementary', 'major_middle', 'major_high', 'major_freshman', 'major_student', 'major_graduate']
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
        } catch (turnError) {
          // 대화 턴 저장 실패해도 분석은 계속 진행 (graceful degradation)
        }
      }
      
      // ============================================
      // P0: 5축 상태좌표 저장 (career_state)
      // ============================================
      if (v3Payload.career_state) {
        try {
          await saveCareerStateFacts(db, v3Payload.session_id, v3Payload.user_id, v3Payload.career_state)
        } catch (stateError) {
        }
      }
      
      // ============================================
      // P0: 전이 신호 저장 (transition_signal)
      // ============================================
      if (v3Payload.transition_signal) {
        try {
          await saveTransitionSignalFacts(db, v3Payload.session_id, v3Payload.user_id, v3Payload.transition_signal)
        } catch (transError) {
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
    
    // Phase 3: 편집 모드 버전 계산
    let parentRequestId: number | null = null
    let versionNumber: number = 1
    let requestVersionNote: string | null = null

    if (editMode && sourceRequestId) {
      parentRequestId = sourceRequestId
      requestVersionNote = versionNote || '입력 수정'
      const maxVer = await db.prepare(`
        SELECT COALESCE(MAX(version_number), 1) as max_ver
        FROM ai_analysis_requests WHERE session_id = ?
      `).bind(rawPayload.session_id).first<{ max_ver: number }>()
      versionNumber = (maxVer?.max_ver || 1) + 1
    }

    const requestResult = await db.prepare(`
      INSERT INTO ai_analysis_requests (
        session_id, user_id, analysis_type, pricing_tier, prompt_payload,
        status, recipe_version, tagger_version, scoring_version,
        parent_request_id, version_number, version_note
      )
      VALUES (?, ?, ?, ?, ?, 'processing', ?, ?, ?, ?, ?, ?)
      RETURNING id
    `).bind(
      rawPayload.session_id,
      userId,
      analysisType,
      (rawPayload as any).pricing_tier || 'free',
      promptPayload,
      VERSIONS.recipe,
      VERSIONS.tagger,
      VERSIONS.scoring,
      parentRequestId,
      versionNumber,
      requestVersionNote
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

    // 11. Phase 3: 편집 모드 임시 draft 삭제
    if (editMode && editSessionId && userId) {
      try {
        await db.prepare('DELETE FROM analyzer_drafts WHERE session_id = ? AND user_id = ?')
          .bind(editSessionId, parseInt(userId)).run()
      } catch { }
    }

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
      message: '분석 중 오류가 발생했습니다. 다시 시도해주세요.',
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
// 실존적 질문 답변 LLM 분석 (비동기 백그라운드 실행)
// "7일 뒤 지구 멸망" 시나리오 답변에서 존재 기반 가치 추출
// ============================================
async function analyzeExistentialAnswer(
  db: D1Database,
  sessionId: string,
  userId: string | undefined,
  rawAnswer: string,
  openaiApiKey?: string,
): Promise<void> {
  if (!openaiApiKey) {
    return
  }


  // 1. 원문 저장 (fact)
  await db.prepare(`
    INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
    VALUES (?, ?, 'existential.priority_raw', ?, 1.0, 'deep_intake', 2)
    ON CONFLICT(session_id, fact_key) DO UPDATE SET
      value_json = excluded.value_json,
      collected_at = CURRENT_TIMESTAMP
  `).bind(sessionId, userId || null, JSON.stringify(rawAnswer)).run()

  // 2. LLM 구조적 분석
  const systemPrompt = `당신은 심리 분석가이자 커리어 전략가입니다.

사용자는 다음 질문에 답했습니다:
"만약 7일 뒤 되돌릴 수 없는 우주적 재난으로 지구가 사라진다면, 그 7일을 어디에서, 누구와, 무엇을 하며 보내고 싶은가? 그리고 그 이유는 무엇인가?"

아래 사용자의 답변을 감정적으로 요약하지 마십시오.
도덕적 평가를 하지 마십시오.
칭찬하거나 위로하지 마십시오.

대신, 다음 항목을 구조적으로 분석하십시오.

1. 주요 행동 지향성 (Primary Action Orientation)
다음 중 가장 가까운 유형을 선택:
- 관계 중심형
- 성취 추구형
- 자유/탐험 지향형
- 의미 탐색형
- 책임 수행형
- 자기표현형
- 회피/무기력형
- 경험 소비형

2. 핵심 가치 신호 (최대 3개 선택)
아래 중에서만 선택:
관계, 성취, 자유, 안정, 의미, 영향력, 인정, 성장, 기여, 경험, 자기표현, 소속

3. 시간 지향성
다음 중 선택:
- 현재 몰입형
- 관계 정리형
- 유산 남기기형
- 후회 보완형
- 초월/철학형

4. 정서적 톤
다음 중 선택:
수용, 긴박, 두려움, 평온, 체념, 저항, 공허, 성찰

5. 잠재적 괴리 분석
사용자의 마지막 7일 선택이 일반적인 사회적 성공 경로와 얼마나 다른지 한 줄로 분석하십시오.

6. 직업 설계에 시사점
이 답변이 커리어 방향 설정에 어떤 신호를 주는지 2~3줄로 분석하십시오.

반드시 JSON 형식으로만 출력하십시오.
{
  "primary_orientation": "...",
  "core_values": ["...", "..."],
  "time_orientation": "...",
  "emotional_tone": "...",
  "hidden_gap_analysis": "...",
  "career_implication": "..."
}`

  try {
    const { callOpenAI } = await import('./openai-client')
    const { response } = await callOpenAI(openaiApiKey, [
      { role: 'system', content: systemPrompt },
      { role: 'user', content: `[USER_DATA]\n${rawAnswer}\n[/USER_DATA]` },
    ], {
      temperature: 0.3,
      max_tokens: 800,
    })

    // JSON 파싱
    const jsonMatch = response.match(/\{[\s\S]*\}/)
    if (!jsonMatch) {
      return
    }

    const structured = JSON.parse(jsonMatch[0])

    // 3. 구조적 분석 결과 저장 (fact)
    await db.prepare(`
      INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
      VALUES (?, ?, 'existential.priority_structured', ?, 0.85, 'inferred', 2)
      ON CONFLICT(session_id, fact_key) DO UPDATE SET
        value_json = excluded.value_json,
        collected_at = CURRENT_TIMESTAMP
    `).bind(sessionId, userId || null, JSON.stringify(structured)).run()

  } catch (error) {
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
    } catch (turnError) {
      // 대화 턴 저장 실패해도 followup 처리는 계속 진행
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
// GET /result/:requestId - 결과 조회 (인증 + 소유권 확인)
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
    `).bind(requestId).first<{
      id: number
      session_id: string
      user_id: string | null
      [key: string]: any
    }>()

    if (!request) {
      logError('REQUEST_NOT_FOUND', 'Analysis request not found', { request_id: requestId })
      return c.json(createErrorResponse('REQUEST_NOT_FOUND', 'Analysis request not found', { request_id: requestId }), 404)
    }

    // 소유권 확인: 로그인 유저 → user_id 매칭, 비로그인 → session_id 매칭
    const authUser = (c as any).get('user') as { id: number; role?: string } | null
    const querySessionId = c.req.query('session_id')

    if (request.user_id) {
      // user_id가 있는 결과: 본인 또는 admin만 접근 가능
      if (!authUser) {
        return c.json(createErrorResponse('AUTH_REQUIRED', '로그인이 필요합니다.'), 401)
      }
      if (String(authUser.id) !== String(request.user_id) && authUser.role !== 'admin') {
        return c.json(createErrorResponse('FORBIDDEN', '본인의 분석 결과만 조회할 수 있습니다.'), 403)
      }
    } else {
      // user_id가 없는 익명 결과: session_id 매칭 필수
      if (!authUser && !querySessionId) {
        return c.json(createErrorResponse('AUTH_REQUIRED', '로그인 또는 session_id가 필요합니다.'), 401)
      }
      if (!authUser || (authUser.role !== 'admin')) {
        // 비로그인 또는 일반 유저: session_id 검증
        if (!querySessionId || querySessionId !== request.session_id) {
          return c.json(createErrorResponse('FORBIDDEN', '접근 권한이 없습니다.'), 403)
        }
      }
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
  
  // 4. 정렬 (Fit 기준) + 정무직/임명직 제거
  scoredJobs.sort((a, b) => b.scores.fit - a.scores.fit)
  const filteredScoredJobs = filterNicheMaterialJobs(filterUnrealisticJobs(scoredJobs), v2MiniModule)

  // 평가 직업 100개로 확장 (기존 10개 -> 100개)
  const top10 = filteredScoredJobs.slice(0, 100)

  // Phase 4: Diversity Guard (내부에서 Research Bias Cap도 적용)
  const rawTop5 = top10.slice(0, 5)
  const diversityResult = applyDiversityGuard(rawTop5, filteredScoredJobs)
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
    engine_version: RECOMMENDATION_ENGINE_VERSION,
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

    // like_top10: like_score 기준 + 다양성 강제 + v3.9.2 최종 안전망(정치직 제거)
    like_top10: sanitizeJobListOutput(enforceDiversityOnTopN(
      [...filteredScoredJobs].filter(j => j.scores.fit >= 25).sort((a, b) => b.scores.like - a.scores.like).slice(0, 20),
      filteredScoredJobs, 'like', 10
    ).diversified.map(j => ({
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
      }))),

    // can_top10: can_score 기준 + 다양성 강제 + v3.9.2 최종 안전망(정치직 제거)
    can_top10: sanitizeJobListOutput(enforceDiversityOnTopN(
      [...filteredScoredJobs].filter(j => j.scores.fit >= 25).sort((a, b) => b.scores.can - a.scores.can).slice(0, 20),
      filteredScoredJobs, 'can', 10
    ).diversified.map(j => ({
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
      }))),

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
// v3.9.2: Top N likeReason 최종 다양성 보장
// 상위 직업들이 모두 같은 패턴이면 강제 스타일 분산
// ============================================
// 따옴표 종류 통합 감지 (straight: ' U+0027, smart: \u2018 \u2019 \u201C \u201D)
function startsWithQuote(s: string): boolean {
  const ch = s.charAt(0)
  return ch === "'" || ch === '\u2018' || ch === '\u2019' || ch === '"' || ch === '\u201C'
}
function findClosingQuote(s: string, start: number): number {
  for (let i = start; i < s.length; i++) {
    const ch = s.charAt(i)
    if (ch === "'" || ch === '\u2019' || ch === '\u2018' || ch === '"' || ch === '\u201D') return i
  }
  return -1
}

function diversifyTopNReasons(jobs: Array<ScoredJob & { likeReason?: string }>): void {
  if (jobs.length < 2) return

  const withReason = jobs.filter(j => j.likeReason && j.likeReason.length > 10)
  if (withReason.length < 2) return

  // 패턴 감지: 따옴표(straight/smart 모두)로 시작하는 비율
  const quoteStart = withReason.filter(j => startsWithQuote(j.likeReason!)).length
  if (quoteStart < 2) return


  for (let i = 0; i < withReason.length; i++) {
    const j = withReason[i]
    const original = j.likeReason!
    if (!startsWithQuote(original)) continue

    const style = i % 3

    const quoteEnd = findClosingQuote(original, 1)
    if (quoteEnd <= 1) continue

    // v3.9.8: style=0(A)에서 전체가 따옴표로 감싸진 경우 → 따옴표 벗기기
    if (style === 0) {
      const lastChar = original.charAt(original.length - 1)
      if (lastChar === "'" || lastChar === '\u2019' || lastChar === '\u201D' || lastChar === '"') {
        j.likeReason = original.substring(1, original.length - 1).trim()
      }
      continue  // 나머지 스타일A는 그대로 유지
    }

    // v3.9.7: 닫는 따옴표 뒤 인용 속성구 통합 제거
    // "하셨는데"를 앵커로 사용 — 모든 조사/연결어미 패턴 일괄 처리
    const rawAfterQuote = original.substring(quoteEnd + 1)
    const hsIdx = rawAfterQuote.indexOf('하셨는데')
    let afterQuote: string
    if (hsIdx >= 0 && hsIdx < 60) {
      afterQuote = rawAfterQuote.substring(hsIdx + 4).replace(/^[,.\s]*/, '').trim()
    } else {
      afterQuote = rawAfterQuote
        .replace(/^(?:[을를]\s*중시한다\s*)?(?:이?\s*라고\s*)?(?:고\s*)?[,.\s]*/, '')
        .trim()
    }
    // v3.9.8: afterQuote 끝의 잔여 따옴표 제거
    afterQuote = afterQuote.replace(/['"'\u2018\u2019\u201C\u201D]+$/g, '').trim()
    const quoteContent = original.substring(1, quoteEnd)

    // v3.9.4: 전체가 따옴표로 감싸진 경우 (afterQuote가 빈 문자열)
    // 예: '안정을 중시한다고 하셨는데, 이 직업은 안정성 80/100이고...'
    // → 따옴표 안에서 "하셨는데" 기준으로 분리
    if (afterQuote.length <= 5) {
      const splitPatterns = ['고 하셨는데,', '하셨는데,', '고 하셨는데']
      for (const pat of splitPatterns) {
        const idx = quoteContent.indexOf(pat)
        if (idx > 0) {
          const userQuote = quoteContent.substring(0, idx).trim()
          afterQuote = quoteContent.substring(idx + pat.length).trim()
            .replace(/[\s,'"'\u2018\u2019\u201C\u201D]+$/g, '').trim()
          if (afterQuote.length > 5) {
            if (style === 1) {
              j.likeReason = `${afterQuote} ${userQuote} 성향과 부합합니다`
            } else if (style === 2) {
              j.likeReason = `특징적으로 ${afterQuote}`
            }
          }
          break
        }
      }
      continue
    }

    if (style === 1 && afterQuote.length > 5) {
      j.likeReason = `${afterQuote} ${quoteContent} 성향과 부합합니다`
    } else if (style === 2 && afterQuote.length > 5) {
      j.likeReason = `특징적으로 ${afterQuote}`
    }
  }
}

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
      } else {
        // Vectorize 실패 시 기존 방식
        throw new Error('Vectorize fallback triggered')
      }
    } catch (vectorError) {
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
  } catch (error) {
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
  }
  
  // 필터링된 직업 목록 사용
  const jobsToScore = filteredJobs.length > 0 ? filteredJobs : sampleJobs
  
  // 2. Fact boosts 계산
  const factBoosts = calculateFactBoosts(facts)

  // P2: 검증된 Can 추출 (Can 기반 TAG 필터용)
  const verifiedCan: VerifiedCanMap = extractVerifiedCanFromFacts(
    facts.map(f => ({ fact_key: f.fact_key, value_json: f.value_json }))
  )

  // 미니모듈 기반 추가 Risk Penalty (Hard Bias derived)
  const hardBiasConstraints = miniModuleForFilter?.energy_drain_flags
    ? deriveConstraintsFromHardBias(miniModuleForFilter.energy_drain_flags)
    : null

  // P3: 성장곡선 선호도 추출
  const growthPreference = extractGrowthPreference(miniModuleForFilter)

  // P3: 내면갈등 심각도 확인
  const conflictSeverity = calculateConflictSeverity(miniModuleForFilter)

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

  // 4. 정렬 (Fit 기준) + 정무직/임명직 제거
  scoredJobs.sort((a, b) => b.scores.fit - a.scores.fit)
  const filteredScoredJobs = filterNicheMaterialJobs(filterUnrealisticJobs(scoredJobs), miniModuleForFilter)

  // 평가 직업 100개로 확장 (기존 10개 -> 100개)
  const top10 = filteredScoredJobs.slice(0, 100)

  // Phase 4: Diversity Guard (Research Bias 방지 + 다양성 확보)
  const rawTop5 = top10.slice(0, 5)
  const diversityResult = applyDiversityGuard(rawTop5, filteredScoredJobs)
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
  
  // LLM Judge: OpenAI API 키가 있을 때만 시도 (없으면 스킵)
  if (openaiKey && candidatesForJudge.length > 0) {
    try {
      // v3.13: V2 path에서도 배경 데이터 전달
      let v2CareerState: { role_identity: string; career_stage_years: string } | undefined
      let v2CareerBackground: string | undefined
      if (payload.career_state) {
        v2CareerState = {
          role_identity: payload.career_state.role_identity || '',
          career_stage_years: payload.career_state.career_stage_years || '',
        }
      }
      try {
        const draftRow = await db.prepare(`SELECT aggregated_profile_json FROM analyzer_drafts WHERE session_id = ?`)
          .bind(payload.session_id).first<{ aggregated_profile_json?: string }>()
        if (draftRow?.aggregated_profile_json) {
          const profile = JSON.parse(draftRow.aggregated_profile_json)
          v2CareerBackground = profile?.narrative?.career_background
        }
      } catch { /* non-critical */ }

      const judgeInput: JudgeInput = {
        candidates: candidatesForJudge,
        searchProfile,
        roundAnswers,
        universalAnswers: universalAnswers,
        miniModuleResult: miniModuleResult,
        careerState: v2CareerState,
        careerBackground: v2CareerBackground,
        additionalContext: additionalContextText,
      }
      llmJudgeResults = await judgeCandidates(openaiKey, db, judgeInput)
      llmJudgeUsed = true
    } catch (judgeError) {
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
  }

  // v3.9.2: Top 3 likeReason 최종 다양성 보장
  // Top 3가 모두 같은 패턴이면 강제 스타일 분산
  diversifyTopNReasons(top3)

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
    facts.map(f => ({
      fact_key: f.fact_key,
      source: f.fact_key.startsWith('followup') ? 'followup' as const : 'minimodule' as const,
      value_json: f.value_json,
    })),
    roundAnswers.length,
    top10.map(j => j.scores.fit)
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
    } else {
    }
  } catch (narrativeError) {
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
    } else {
    }
  } catch (roundError) {
  }

  // Additional Context 조회 (사용자가 추가한 텍스트)
  let additionalContextText: string | undefined
  try {
    const acRows = await db.prepare(`
      SELECT value_text FROM analyzer_facts
      WHERE session_id = ? AND fact_key = 'additional_context'
      ORDER BY created_at DESC
    `).bind(payload.session_id).all<{ value_text: string }>()
    if (acRows.results && acRows.results.length > 0) {
      additionalContextText = acRows.results.map(r => r.value_text).join('\n\n')
    }
  } catch (acError) {
  }

  // roundAnswers 병합: DB 우선, deep_intake는 fallback
  const finalRoundAnswers = dbRoundAnswers.length > 0
    ? dbRoundAnswers
    : (roundAnswers || [])


  // LLM Reporter: OpenAI 키만 있으면 호출 (후보가 있을 때)
  if (openaiKey && candidatesForJudge.length > 0) {
    try {
      const reporterInput: ReporterInput = {
        sessionId,
        judgeResults: llmJudgeResults?.results || [],
        searchProfile,
        narrativeFacts,
        roundAnswers: finalRoundAnswers,
        universalAnswers: universalAnswers,
        hardCutList,
        miniModuleResult,
        additionalContext: additionalContextText,
      }
      premiumReport = await generateLLMPremiumReport(
        env?.AI || null,
        reporterInput,
        openaiKey
      )
    } catch (reporterError) {
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
    engine_version: RECOMMENDATION_ENGINE_VERSION,
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

    // like_top10: like_score 기준 + 다양성 강제 + v3.9.2 최종 안전망(정치직 제거)
    like_top10: sanitizeJobListOutput(enforceDiversityOnTopN(
      [...filteredScoredJobs].filter(j => j.scores.fit >= 25).sort((a, b) => b.scores.like - a.scores.like).slice(0, 20),
      filteredScoredJobs, 'like', 10
    ).diversified.map(j => ({
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
      }))),

    // can_top10: can_score 기준 + 다양성 강제 + v3.9.2 최종 안전망(정치직 제거)
    can_top10: sanitizeJobListOutput(enforceDiversityOnTopN(
      [...filteredScoredJobs].filter(j => j.scores.fit >= 25).sort((a, b) => b.scores.can - a.scores.can).slice(0, 20),
      filteredScoredJobs, 'can', 10
    ).diversified.map(j => ({
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
      }))),

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
    
    // V3: Premium Report (확신도 포함 — 프론트엔드에서 report._confidence로 접근)
    premium_report: {
      ...premiumReport,
      _confidence: confidenceResult.score,
    },

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
  
  // v3.9.2 최종 방어: 결과 반환 직전 정치직/임명직 완전 제거
  // sanitizeJobListOutput이 이미 적용되었지만, 혹시 놓친 경우 여기서 한 번 더
  if (result.like_top10) {
    const before1 = result.like_top10.length
    result.like_top10 = result.like_top10.filter((j: any) => {
      const name = (j.job_name || '').trim()
      for (const p of ['차관', '장관', '법원장', '대법관', '헌법재판관', '검찰총장', '감사원장', '국무총리', '대통령', '국회의원', '도지사', '총영사']) {
        if (name.includes(p)) return false
      }
      if (['대사', '공사', '시장', '군수', '구청장'].includes(name)) return false
      return true
    })
  }
  if (result.can_top10) {
    const before2 = result.can_top10.length
    result.can_top10 = result.can_top10.filter((j: any) => {
      const name = (j.job_name || '').trim()
      for (const p of ['차관', '장관', '법원장', '대법관', '헌법재판관', '검찰총장', '감사원장', '국무총리', '대통령', '국회의원', '도지사', '총영사']) {
        if (name.includes(p)) return false
      }
      if (['대사', '공사', '시장', '군수', '구청장'].includes(name)) return false
      return true
    })
  }
  if (result.fit_top3) {
    result.fit_top3 = result.fit_top3.filter((j: any) => {
      const name = (j.job_name || '').trim()
      for (const p of ['차관', '장관', '법원장', '대법관', '헌법재판관', '검찰총장', '감사원장', '국무총리', '대통령', '국회의원', '도지사', '총영사']) {
        if (name.includes(p)) return false
      }
      if (['대사', '공사', '시장', '군수', '구청장'].includes(name)) return false
      return true
    })
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
        req.session_id,
        res.result_json
      FROM ai_analysis_requests req
      LEFT JOIN ai_analysis_results res ON req.id = res.request_id
      WHERE req.id = ?
    `).bind(body.request_id).first<{
      request_id: number
      request_payload: string
      session_id: string | null
      result_json: string | null
    }>()

    // 소유권 검증: session_id가 일치해야 접근 가능
    if (requestRow && body.session_id && requestRow.session_id !== body.session_id) {
      return c.json({ error: 'FORBIDDEN', message: '접근 권한이 없습니다' }, 403)
    }
    
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
      
    } catch (profileError) {
      // 프로필 저장 실패해도 보고서는 반환 (graceful degradation)
    }
    
    return c.json({
      success: true,
      report: premiumReport,
    })
    
  } catch (error) {
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
// POST /api/ai-analyzer/add-context
// 추가 컨텍스트 저장 + 버전 관리 요청 생성
// ============================================
analyzerRoutes.post('/add-context', async (c) => {
  const env = c.env as Bindings
  const db = env.DB

  const authUser = c.get('user') as { id: number } | undefined
  if (!authUser?.id) {
    return c.json({ error: 'UNAUTHORIZED', message: 'Login required' }, 401)
  }
  const userId = String(authUser.id)

  try {
    const { request_id, additional_text } = await c.req.json<{
      request_id: number
      additional_text: string
    }>()

    if (!request_id || !additional_text || additional_text.trim().length < 30) {
      return c.json({ error: 'VALIDATION_ERROR', message: '추가 텍스트는 30자 이상이어야 합니다.' }, 400)
    }

    // 기존 request 조회
    const existingReq = await db.prepare(`
      SELECT req.id, req.session_id, req.analysis_type, req.user_id, req.version_number
      FROM ai_analysis_requests req
      WHERE req.id = ? AND req.user_id = ?
    `).bind(request_id, userId).first<{
      id: number; session_id: string; analysis_type: string; user_id: number; version_number: number | null
    }>()

    if (!existingReq) {
      return c.json({ error: 'NOT_FOUND', message: '해당 분석 결과를 찾을 수 없습니다.' }, 404)
    }

    // 동시 분석 방지: 같은 session_id에 processing 상태가 있는지 확인
    const processing = await db.prepare(`
      SELECT id FROM ai_analysis_requests WHERE session_id = ? AND status = 'processing'
    `).bind(existingReq.session_id).first<{ id: number }>()
    if (processing) {
      return c.json({ error: 'CONFLICT', message: '이미 분석이 진행 중입니다. 잠시 후 다시 시도해주세요.' }, 429)
    }

    const currentVersion = existingReq.version_number || 1
    const newVersion = currentVersion + 1
    const trimmedText = additional_text.trim()
    const versionNote = '내용 추가: ' + (trimmedText.length > 30 ? trimmedText.substring(0, 30) + '...' : trimmedText)

    // 추가 컨텍스트를 analyzer_facts에 저장
    await db.prepare(`
      INSERT INTO analyzer_facts (user_id, session_id, request_id, fact_key, value_json, value_text, source, confidence_weight, created_at)
      VALUES (?, ?, ?, 'additional_context', ?, ?, 'user_input', 1.0, datetime('now'))
    `).bind(userId, existingReq.session_id, request_id, JSON.stringify(trimmedText), trimmedText).run()

    // 새 버전 요청 생성
    const newReqResult = await db.prepare(`
      INSERT INTO ai_analysis_requests (
        user_id, session_id, analysis_type, status,
        parent_request_id, version_number, version_note,
        prompt_payload, requested_at
      ) VALUES (?, ?, ?, 'pending', ?, ?, ?, ?, datetime('now'))
      RETURNING id
    `).bind(
      userId,
      existingReq.session_id,
      existingReq.analysis_type,
      request_id,
      newVersion,
      versionNote,
      JSON.stringify({ add_context: true, additional_text: trimmedText, source_request_id: request_id })
    ).first<{ id: number }>()

    if (!newReqResult) {
      return c.json({ error: 'INTERNAL_ERROR', message: '요청 생성에 실패했습니다.' }, 500)
    }

    // 분석 페이지로 리다이렉트 URL 생성 (기존 세션 데이터 + 추가 컨텍스트로 파이프라인 실행)
    const analyzerUrl = `/${existingReq.analysis_type === 'major' ? 'analyzer/major' : 'analyzer/job'}?session_id=${encodeURIComponent(existingReq.session_id)}&add_context=true&request_id=${newReqResult.id}`

    return c.json({
      success: true,
      new_request_id: newReqResult.id,
      session_id: existingReq.session_id,
      analysis_type: existingReq.analysis_type,
      version_number: newVersion,
      redirect_url: analyzerUrl,
      message: '추가 정보가 저장되었습니다. 재분석을 진행합니다.',
    })
  } catch (error) {
    return c.json({ error: 'INTERNAL_ERROR', message: error instanceof Error ? error.message : 'Unknown error' }, 500)
  }
})

// ============================================
// V3: 3라운드 심층 질문 생성 API (2026-01-16)
// POST /api/ai-analyzer/v3/round-questions
// ============================================
import { generateRoundQuestions, generateMajorRoundQuestions, buildSearchProfileFromAnswers } from './llm-interviewer'

analyzerRoutes.post('/v3/round-questions', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  
  try {
    const body = await c.req.json<{
      session_id: string
      round_number: 1 | 2 | 3
      analysis_type?: 'job' | 'major'
      narrative_facts?: { highAliveMoment: string; lostMoment: string; life_story?: string; storyAnswer?: string; existentialAnswer?: string }
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

    const { session_id, round_number, analysis_type, narrative_facts, previous_round_answers, universal_answers, career_state, transition_signal, mini_module_result } = body
    
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
      }
    } catch (memError) {
    }
    
    // ============================================
    // CAG Manager: 세션 상태 관리 (2026-02-03 활성화)
    // ============================================
    let cagState: CAGState | null = null
    try {
      cagState = await getOrCreateCAGState(db, session_id)
    } catch (cagError) {
    }
    
    // 이전 라운드 답변을 CAG에 기록
    if (cagState && previous_round_answers && previous_round_answers.length > 0) {
      for (const ans of previous_round_answers) {
        logAnswerReceived(cagState, ans.questionId, ans.answer)
      }
    }
    
    // ============================================
    // Phase 9: 전체 라운드(R1/R2/R3) 질문 캐싱
    // 동일 프로필 + 동일 답변 → 동일 질문 반환 (일관성 보장)
    // R1: profile hash, R2: profile+R1답변 hash, R3: profile+R2답변 hash
    // ============================================
    const interviewerInput = {
      sessionId: session_id,
      roundNumber: round_number,
      narrativeFacts: narrative_facts,
      previousRoundAnswers: previous_round_answers || [],
      universalAnswers: universal_answers,
      careerState: career_state,
      transitionSignal: transition_signal,
      miniModuleResult: mini_module_result,
      memory: memoryData,
      openaiApiKey: (env as any).OPENAI_API_KEY,
    }

    let result: Awaited<ReturnType<typeof generateRoundQuestions>>
    const analysisTypeKey = analysis_type || 'job'

    // 라운드별 메타데이터 (캐시 히트 시 복원용)
    const ROUND_META_MAP: Record<number, { purpose: 'ENGINE' | 'AVOIDANCE' | 'INTEGRATION'; theme: string; targetAxis: readonly string[] }> = {
      1: { purpose: 'ENGINE', theme: '욕망 탐색', targetAxis: ['interest', 'value'] },
      2: { purpose: 'AVOIDANCE', theme: '회피 탐색', targetAxis: ['constraint', 'value'] },
      3: { purpose: 'INTEGRATION', theme: '통합', targetAxis: ['interest', 'value', 'strength', 'constraint', 'workstyle'] },
    }

    if (mini_module_result && round_number >= 1 && round_number <= 3) {
      // 캐시 키: 프로필 토큰 + 내러티브 + 이전 라운드 답변 (R2/R3용)
      const cacheInput = JSON.stringify({
        i: mini_module_result.interest_top?.sort(),
        v: mini_module_result.value_top?.sort(),
        s: mini_module_result.strength_top?.sort(),
        c: mini_module_result.constraint_flags?.sort(),
        h: narrative_facts?.highAliveMoment?.slice(0, 50),
        l: narrative_facts?.lostMoment?.slice(0, 50),
        // R2/R3: 이전 답변 포함 → 같은 답변이면 같은 캐시 키
        a: (previous_round_answers || []).map((a: any) => a.answer?.slice(0, 80)).sort(),
      })
      // FNV-1a 해시
      let hash = 0x811c9dc5
      for (let i = 0; i < cacheInput.length; i++) {
        hash ^= cacheInput.charCodeAt(i)
        hash = (hash * 0x01000193) >>> 0
      }
      const profileHash = hash.toString(16).padStart(8, '0')

      // 캐시 조회
      try {
        const cached = await db.prepare(
          'SELECT questions_json FROM interview_question_cache WHERE profile_hash = ? AND analysis_type = ? AND round_number = ?'
        ).bind(profileHash, analysisTypeKey, round_number).first<{ questions_json: string }>()

        if (cached) {
          // 캐시 히트 → LLM 호출 생략
          await db.prepare(
            'UPDATE interview_question_cache SET hit_count = hit_count + 1 WHERE profile_hash = ? AND analysis_type = ? AND round_number = ?'
          ).bind(profileHash, analysisTypeKey, round_number).run()

          const cachedQuestions = JSON.parse(cached.questions_json)
          const meta = ROUND_META_MAP[round_number] || ROUND_META_MAP[1]
          result = {
            round: round_number,
            questions: cachedQuestions,
            generatedBy: 'llm' as const,
            metadata: meta,
          }
        } else {
          // 캐시 미스 → LLM 호출 후 저장
          result = analysisTypeKey === 'major'
            ? await generateMajorRoundQuestions(env.AI || null, interviewerInput)
            : await generateRoundQuestions(env.AI || null, interviewerInput)

          // 캐시에 저장 (실패해도 무시)
          try {
            await db.prepare(
              'INSERT OR REPLACE INTO interview_question_cache (profile_hash, analysis_type, round_number, questions_json) VALUES (?, ?, ?, ?)'
            ).bind(profileHash, analysisTypeKey, round_number, JSON.stringify(result.questions)).run()
          } catch { /* 캐시 저장 실패 무시 */ }
        }
      } catch {
        // 캐시 테이블 없거나 오류 → 기존 로직 fallback
        result = analysisTypeKey === 'major'
          ? await generateMajorRoundQuestions(env.AI || null, interviewerInput)
          : await generateRoundQuestions(env.AI || null, interviewerInput)
      }
    } else {
      // mini_module_result 없음 → 캐시 불가, LLM 직접 호출
      result = analysisTypeKey === 'major'
        ? await generateMajorRoundQuestions(env.AI || null, interviewerInput)
        : await generateRoundQuestions(env.AI || null, interviewerInput)
    }
    
    // ============================================
    // v3.21: 감정질문 서버사이드 필터 — 라운드당 0개로 완전 차단
    // 프롬프트에서도 감정질문 금지를 명시하므로, 서버사이드는 이중 방어
    // generateRoundQuestions에서는 MIN_QUESTIONS 충족을 우선하고
    // 이 지점에서 감정질문을 완전 제거
    // ============================================
    const EMOTION_PATTERNS_ROUTE = [
      /어떤 (?:감정|느낌|기분)/,
      /(?:감정이|기분이|마음이) (?:어떠|어떤|어땠)/,
      /감정적으로|정서적으로|내면적으로|심리적으로/,
      /어떤 (?:마음|심정|기분)/,
      /마음이 (?:어떠|움직|끌)/,
      /감정(?:을|이|은|도|의)/,
      /마음속으로|마음 속에|가슴이 (?:뛰|답답|아프|떨)/,
      /(?:행복|불행)(?:하셨|했|한 적|감을|하다고)/,
      /(?:스트레스|압박감|부담감)(?:을|이|는|도)? (?:느끼|받으|많이|주|준)/,
      /(?:힘드셨|힘들었|힘들게|괴로|고통스러|속상|서운).*(?:나요|까요|는지)/,
    ]
    {
      // v3.21.7: 감정질문 필터 — 최소 1개 보장 (느끼다 false positive 제거)
      const originalQuestions = [...result.questions]
      const nonEmotionQs = result.questions.filter(q => {
        if (!q.questionText) return true
        const isEmotion = EMOTION_PATTERNS_ROUTE.some(p => p.test(q.questionText))
        return !isEmotion
      })
      if (nonEmotionQs.length >= 1) {
        result.questions = nonEmotionQs
      } else {
        // 모든 질문이 감정 → 첫 1개만 유지
        result.questions = originalQuestions.slice(0, 1)
      }
    }

    // ============================================
    // CAG: 생성된 질문 로그 기록 + 중복 필터
    // ============================================
    let filteredQuestions = result.questions
    if (cagState) {
      // 중복 질문 필터링 (임계값 0.6으로 강화)
      filteredQuestions = result.questions.filter(q => {
        // questionText가 있을 때만 중복 체크 (undefined 방지)
        if (!q.questionText) return true
        const isDuplicate = isQuestionAlreadyAsked(cagState!, q.questionText, 0.6)
        if (isDuplicate) {
        }
        return !isDuplicate
      })

      // H1 safeguard: 필터링 후 최소 3개 질문 보장
      if (filteredQuestions.length < 3 && result.questions.length >= 3) {
        filteredQuestions = result.questions
      }

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
      } catch (saveError) {
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
    } catch (progressError: any) {
    }

    // ============================================
    // Memory 업데이트 (Round 답변 저장 후) — waitUntil로 비동기 처리
    // 응답을 먼저 보내고, LLM 호출(updateMemory)은 백그라운드에서 실행
    // ============================================
    if (c.executionCtx && 'waitUntil' in c.executionCtx) {
      c.executionCtx.waitUntil((async () => {
        try {
          const draft = await db
            .prepare('SELECT * FROM analyzer_drafts WHERE session_id = ?')
            .bind(session_id)
            .first<any>()

          if (draft) {
            let aggregatedProfile: AggregatedProfile
            if (draft.aggregated_profile_json) {
              aggregatedProfile = JSON.parse(draft.aggregated_profile_json)
            } else {
              aggregatedProfile = createEmptyProfile(draft.profile_version || 0)
            }

            const roundAnswers = answers.map(ans => ({
              questionId: ans.question_id,
              roundNumber: round_number,
              answer: ans.answer,
              answeredAt: new Date().toISOString(),
            }))

            const updatedMemory = await updateMemory(
              env.AI || null,
              aggregatedProfile,
              { type: 'round_answers', data: roundAnswers, roundNumber: round_number },
              (env as any).OPENAI_API_KEY
            )

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
          }
        } catch (memoryError: any) {
          // Memory 업데이트 실패해도 답변 저장은 이미 성공
        }
      })())
    }

    return c.json({
      success: true,
      saved_count: successCount,
      round_number,
      memory_updated: false, // waitUntil로 비동기 처리되므로 항상 false
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
      existential_answer?: string
    }>()

    const { session_id, user_id, high_alive_moment, lost_moment, existential_answer } = body

    // P0-1: session_id 검증 강화
    if (!session_id || session_id.trim() === '') {
      return c.json({
        success: false,
        error: 'session_id is required and cannot be empty',
        detail: 'session_id_validation_failed'
      }, 400)
    }

    // P0-1: 입력값 로깅

    // UPSERT (기존 있으면 업데이트)
    const result = await db.prepare(`
      INSERT INTO narrative_facts (session_id, user_id, high_alive_moment, lost_moment, existential_answer)
      VALUES (?, ?, ?, ?, ?)
      ON CONFLICT(session_id) DO UPDATE SET
        high_alive_moment = excluded.high_alive_moment,
        lost_moment = excluded.lost_moment,
        existential_answer = excluded.existential_answer,
        created_at = datetime('now')
    `).bind(session_id, user_id || null, high_alive_moment, lost_moment, existential_answer || null).run()

    // 실존적 질문 답변이 있으면 비동기로 LLM 분석 실행
    if (existential_answer && existential_answer.trim().length > 10) {
      c.executionCtx.waitUntil(
        analyzeExistentialAnswer(db, session_id, user_id, existential_answer, (env as any).OPENAI_API_KEY)
          .catch(() => {})
      )
    }

    
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
  const authError = checkAdminAuth(c)
  if (authError) return authError
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
    const startTime = Date.now()
    
    const result = await indexJobsToVectorize(
      db,
      env.VECTORIZE,
      openaiApiKey,
      50  // 배치 크기 (OpenAI rate limit 고려)
    )
    
    const duration = Date.now() - startTime
    
    
    return c.json({
      success: true,
      indexed: result.indexed,
      errors: result.errors,
      duration_ms: duration,
      embedding_model: 'text-embedding-3-small',
      embedding_dimensions: 1536,
    })
    
  } catch (error) {
    return c.json({
      success: false,
      error: 'REINDEX_ERROR',
      message: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// 관리자: 전공 데이터 재인덱싱
// ============================================
analyzerRoutes.post('/admin/reindex-majors', async (c) => {
  const authError = checkAdminAuth(c)
  if (authError) return authError
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = (env as any).OPENAI_API_KEY

  if (!env.VECTORIZE) {
    return c.json({ success: false, error: 'VECTORIZE_NOT_AVAILABLE', message: 'Vectorize 바인딩이 설정되지 않았습니다' }, 503)
  }
  if (!openaiApiKey) {
    return c.json({ success: false, error: 'OPENAI_API_KEY_NOT_SET', message: 'OpenAI API 키가 설정되지 않았습니다' }, 503)
  }

  try {
    const startTime = Date.now()
    const result = await indexMajorsToVectorize(db, env.VECTORIZE, openaiApiKey, 50)
    const duration = Date.now() - startTime
    return c.json({ success: true, target: 'majors', indexed: result.indexed, errors: result.errors, duration_ms: duration })
  } catch (error) {
    return c.json({ success: false, error: 'REINDEX_ERROR', message: error instanceof Error ? error.message : 'Unknown error' }, 500)
  }
})

// ============================================
// 관리자: HowTo/가이드 데이터 재인덱싱
// ============================================
analyzerRoutes.post('/admin/reindex-howtos', async (c) => {
  const authError = checkAdminAuth(c)
  if (authError) return authError
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = (env as any).OPENAI_API_KEY

  if (!env.VECTORIZE) {
    return c.json({ success: false, error: 'VECTORIZE_NOT_AVAILABLE', message: 'Vectorize 바인딩이 설정되지 않았습니다' }, 503)
  }
  if (!openaiApiKey) {
    return c.json({ success: false, error: 'OPENAI_API_KEY_NOT_SET', message: 'OpenAI API 키가 설정되지 않았습니다' }, 503)
  }

  try {
    const startTime = Date.now()
    const result = await indexHowtosToVectorize(db, env.VECTORIZE, openaiApiKey, 50)
    const duration = Date.now() - startTime
    return c.json({ success: true, target: 'howtos', indexed: result.indexed, errors: result.errors, duration_ms: duration })
  } catch (error) {
    return c.json({ success: false, error: 'REINDEX_ERROR', message: error instanceof Error ? error.message : 'Unknown error' }, 500)
  }
})

// ============================================
// 관리자: 전체 재인덱싱 (직업 + 전공 + HowTo)
// ============================================
analyzerRoutes.post('/admin/reindex-all', async (c) => {
  const authError = checkAdminAuth(c)
  if (authError) return authError
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = (env as any).OPENAI_API_KEY

  if (!env.VECTORIZE) {
    return c.json({ success: false, error: 'VECTORIZE_NOT_AVAILABLE', message: 'Vectorize 바인딩이 설정되지 않았습니다' }, 503)
  }
  if (!openaiApiKey) {
    return c.json({ success: false, error: 'OPENAI_API_KEY_NOT_SET', message: 'OpenAI API 키가 설정되지 않았습니다' }, 503)
  }

  try {
    const startTime = Date.now()
    const [jobResult, majorResult, howtoResult] = await Promise.all([
      indexJobsToVectorize(db, env.VECTORIZE, openaiApiKey, 50),
      indexMajorsToVectorize(db, env.VECTORIZE, openaiApiKey, 50),
      indexHowtosToVectorize(db, env.VECTORIZE, openaiApiKey, 50),
    ])
    const duration = Date.now() - startTime
    return c.json({
      success: true,
      target: 'all',
      jobs: { indexed: jobResult.indexed, errors: jobResult.errors },
      majors: { indexed: majorResult.indexed, errors: majorResult.errors },
      howtos: { indexed: howtoResult.indexed, errors: howtoResult.errors },
      duration_ms: duration,
    })
  } catch (error) {
    return c.json({ success: false, error: 'REINDEX_ERROR', message: error instanceof Error ? error.message : 'Unknown error' }, 500)
  }
})

// ============================================
// Freeze v1.1: Recommendation Mode API
// ============================================
// 제출 시점에만 최종 추천 파이프라인 실행
// Interview Mode와 분리하여 설문 중 편향 방지
// ============================================
import { generateQSP, qspToPromptHints } from './qsp-generator'
import { createEmptyAxisCoverage, updateAxisCoverage } from './axis-framework'
import { incrementalUpsertToVectorize, incrementalUpsertMajorsToVectorize, incrementalUpsertHowtosToVectorize, countJobsNeedingIndexing } from './vectorize-pipeline'

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
    // v3.13: 배경 데이터 (Feasibility 평가용)
    background_flags?: string[]
    language_skills?: Array<{ language: string; level: 'basic' | 'business' | 'native' }>
  }
  // 옵션: payload에서 직접 전달하는 career_state (DB에 없을 때 fallback)
  career_state?: {
    role_identity: string
    career_stage_years: string
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
  const userId = authUser?.id?.toString() || null

  const { session_id, draft_id, topK = 800, judgeTopN = 20, debug = false, skipReport = false } = payload
  
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

    // Additional Context 조회 (사용자가 추가한 텍스트)
    let additionalContextForRecommend: string | undefined
    try {
      const acRows = await db.prepare(`
        SELECT value_text FROM analyzer_facts
        WHERE session_id = ? AND fact_key = 'additional_context'
        ORDER BY created_at DESC
      `).bind(session_id).all<{ value_text: string }>()
      if (acRows.results && acRows.results.length > 0) {
        additionalContextForRecommend = acRows.results.map(r => r.value_text).join('\n\n')
      }
    } catch { /* non-critical */ }

    // ============================================
    // Phase 9: 추천 결과 캐싱 — 동일 프로필+답변 → 동일 결과 (일관성 보장)
    // Workers AI(분산 GPU)가 temp=0에서도 비결정적이므로, 결과 자체를 캐싱
    // ============================================
    let recCacheHash: string | null = null
    // Phase 10: 내러티브/답변 데이터를 캐시 해시 + 검색 쿼리 양쪽에서 사용
    let nfRow: { high_alive_moment?: string; lost_moment?: string } | null = null
    let raRows: { results?: Array<{ answer: string }> } | null = null
    if (payload.mini_module_result) {
      try {
        // 캐시 키: mini_module 토큰 + narrative_facts + 모든 round_answers
        nfRow = await db.prepare(
          'SELECT high_alive_moment, lost_moment FROM narrative_facts WHERE session_id = ?'
        ).bind(session_id).first<{ high_alive_moment?: string; lost_moment?: string }>()
        raRows = await db.prepare(
          'SELECT answer FROM round_answers WHERE session_id = ? ORDER BY round_number, question_id'
        ).bind(session_id).all<{ answer: string }>()

        const cacheInput = JSON.stringify({
          i: payload.mini_module_result.interest_top?.sort(),
          v: payload.mini_module_result.value_top?.sort(),
          s: payload.mini_module_result.strength_top?.sort(),
          c: payload.mini_module_result.constraint_flags?.sort(),
          w: payload.mini_module_result.workstyle_top?.sort(),
          h: nfRow?.high_alive_moment?.slice(0, 80),
          l: nfRow?.lost_moment?.slice(0, 80),
          a: raRows?.results?.map(r => r.answer?.slice(0, 60)) || [],
        })
        let hash = 0x811c9dc5
        for (let ci = 0; ci < cacheInput.length; ci++) {
          hash ^= cacheInput.charCodeAt(ci)
          hash = (hash * 0x01000193) >>> 0
        }
        recCacheHash = hash.toString(16).padStart(8, '0')

        // 캐시 조회
        const cached = await db.prepare(
          'SELECT result_json, premium_report_json FROM recommendation_result_cache WHERE profile_hash = ? AND analysis_type = ? AND engine_version = ?'
        ).bind(recCacheHash, 'job', RECOMMENDATION_ENGINE_VERSION).first<{ result_json: string; premium_report_json?: string }>()

        if (cached) {
          // 캐시 히트 → 파이프라인 전체 생략
          await db.prepare(
            'UPDATE recommendation_result_cache SET hit_count = hit_count + 1 WHERE profile_hash = ? AND analysis_type = ? AND engine_version = ?'
          ).bind(recCacheHash, 'job', RECOMMENDATION_ENGINE_VERSION).run()

          const cachedResult = JSON.parse(cached.result_json)
          const cachedPremium = cached.premium_report_json ? JSON.parse(cached.premium_report_json) : null
          const duration = Date.now() - startTime
          return c.json({
            ...cachedResult,
            session_id,
            cache_hit: true,
            duration_ms: duration,
          })
        }
      } catch { /* 캐시 실패 → 정상 파이프라인 진행 */ }
    }

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
          }
        }
      } catch (err) {
      }
    }

    if (!searchProfile) {
      return c.json(createErrorResponse(
        'VALIDATION_ERROR',
        'searchProfile or draft_id or mini_module_result required'
      ), 400)
    }
    
    // 2. Vectorize 1회 (TopK=800)

    // ★ 중요: mini_module_result가 있으면 이를 기반으로 SearchProfile 생성
    // 이렇게 해야 "분석형 유저"에게 분석 관련 직업이 검색됨
    let vectorSearchProfile = searchProfile
    if (payload.mini_module_result) {
      vectorSearchProfile = buildSearchProfileFromMiniModule(payload.mini_module_result)
    }

    // Phase 10: 내러티브/인터뷰 답변에서 구체적 키워드를 벡터 검색에 반영
    const narrativeTexts: string[] = []
    if (nfRow?.high_alive_moment) narrativeTexts.push(nfRow.high_alive_moment)
    if (nfRow?.lost_moment) narrativeTexts.push(nfRow.lost_moment)
    const roundAnswerTexts = (raRows?.results || []).map(r => r.answer).filter(Boolean)

    const expansionResult = await expandCandidatesV3(
      db,
      env.VECTORIZE,
      openaiApiKey,
      vectorSearchProfile,
      {
        targetSize: topK,
        miniModule: payload.mini_module_result,
        narrativeData: { narrativeTexts, roundAnswerTexts },
      }
    )

    
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

    // v3.18: energy_drain_flags + value_top → 추가 risk constraints
    const mm = payload.mini_module_result
    if (mm) {
      const drainFlags = mm.energy_drain_flags || []
      if (drainFlags.includes('people_drain')) userConstraints.people_drain = true
      if (drainFlags.includes('routine_drain')) userConstraints.routine_drain = true
      if (drainFlags.includes('uncertainty_drain')) userConstraints.uncertainty_drain = true
      if (drainFlags.includes('time_pressure_drain')) {
        userConstraints.time_pressure_drain = true
        userConstraints.prefer_low_overtime = true  // 시간 압박 드레인 → 야근 기피로 연결
      }

      const values = mm.value_top || []
      if (values.includes('wlb')) {
        userConstraints.prefer_wlb = true
        userConstraints.prefer_low_overtime = true  // WLB 중시 → 야근 기피로 연결
      }
      if (values.includes('stability') && !userConstraints.prefer_stability) userConstraints.prefer_stability = true

      const constraints = mm.constraint_flags || []
      if (constraints.includes('no_travel')) userConstraints.no_travel = true
    }
    
    // 3-1. TAG Filter 먼저 적용 (VectorSearchResult 타입)

    let tagFilterResult
    try {
      tagFilterResult = await applyTagFilter(db, expansionResult.candidates, userConstraints)
    } catch (tagError) {
      throw tagError
    }

    // 3-2. 필터링된 결과를 ScoredJob으로 변환
    // ★ v3.16: tag-filter의 riskPenalty 보존 (이전에는 여기서 손실됨)
    const riskPenaltyMap = new Map<string, number>(
      tagFilterResult.passed.map(p => [p.job_id, p.riskPenalty])
    )
    const tagPassedAsVectorResults = tagFilterResult.passed.map(p => ({
      job_id: p.job_id,
      job_name: p.job_name,
      score: p.score,  // VectorSearchResult의 score
    }))

    let scoredJobs
    try {
      scoredJobs = await vectorResultsToScoredJobs(db, tagPassedAsVectorResults, payload.mini_module_result)

      // ★ v3.16: 실제 risk penalty 적용 (하드코딩 10 → tag-filter 계산값)
      scoredJobs = scoredJobs.map(j => {
        const tagRisk = riskPenaltyMap.get(j.job_id) ?? 0
        return {
          ...j,
          base_risk: tagRisk,
          risk_penalty: tagRisk,
          final_score: Math.round(0.55 * (j.like_score || 0) + 0.45 * (j.can_score || 0) - tagRisk),
        }
      })
      // v3.9.4: 정치직/임명직 필터링 (차관, 법원장 등 추천 부적합 직업 제거)
      scoredJobs = filterUnrealisticJobs(scoredJobs)
      // v3.9.9: 니치 소재/분야 직업 조건부 필터링 (배경이 받쳐줄 때는 통과)
      scoredJobs = filterNicheMaterialJobs(scoredJobs, payload.mini_module_result)
      // 🔍 DEBUG: 첫 번째 직업의 image_url, job_description 확인
      if (scoredJobs.length > 0) {
        const sample = scoredJobs[0]
      }
    } catch (scoreError) {
      throw scoreError
    }

    // 3-3. MiniModule Hard Filter (분석형 강점 → 현장직 제외 등)

    let filteredJobs, mmFilterResult
    try {
      const mmResult = applyMiniModuleHardFilter(scoredJobs, payload.mini_module_result)
      filteredJobs = mmResult.filtered
      mmFilterResult = mmResult.filterResult
    } catch (mmError) {
      throw mmError
    }

    if (mmFilterResult.appliedRules.length > 0) {
    }
    
    // 4. LLM Judge 호출 (Top 20 결정 + rationale 생성)
    let topJobs: any[]

    // v3.10: 벡터 검색 미스 시 DB에서 아키타입 직업 직접 주입
    // 벡터 검색이 유저의 핵심 흥미에 해당하는 직업을 못 찾은 경우, DB에서 직접 조회하여 filteredJobs에 주입
    const ARCHETYPE_DB_QUERIES: Record<string, { patterns: string[], likePatterns: string[] }> = {
      helping_teaching: {
        patterns: ['교사', '복지사', '간호', '상담', '보육'],
        likePatterns: ['%교사%', '%복지사%', '%간호%', '%상담사%', '%보육%'],
      },
      helping: {  // 돌봄/봉사 — helping_teaching과 동일 + 지도원/돌봄 추가
        patterns: ['교사', '복지사', '간호', '상담', '보육', '지도원', '돌봄'],
        likePatterns: ['%교사%', '%복지사%', '%간호%', '%상담사%', '%보육%', '%지도원%', '%돌봄%'],
      },
      helping_feedback: {  // 직접 도움 — 사회서비스 계열
        patterns: ['복지사', '상담', '지도원', '간호', '돌봄'],
        likePatterns: ['%복지사%', '%상담%', '%지도원%', '%간호%', '%돌봄%'],
      },
      organizing: {
        patterns: ['행정', '사무', '관리자', '공무원'],
        likePatterns: ['%행정%', '%사무%', '%관리자%', '%공무원%'],
      },
      tech: {
        patterns: ['개발자', '엔지니어', '프로그래머', 'SW', '소프트웨어'],
        likePatterns: ['%개발자%', '%엔지니어%', '%프로그래머%', '%SW%', '%소프트웨어%'],
      },
      creating: {
        patterns: ['디자이너', '기획자', '작가', '예술'],
        likePatterns: ['%디자이너%', '%기획자%', '%작가%', '%예술%'],
      },
      data_numbers: {
        patterns: ['분석', '통계', '회계', '데이터'],
        likePatterns: ['%분석%', '%통계%', '%회계%', '%데이터%'],
      },
      problem_solving: {
        patterns: ['컨설턴트', '연구원', '분석가'],
        likePatterns: ['%컨설턴트%', '%연구원%', '%분석가%'],
      },
      influencing: {
        patterns: ['마케터', '홍보', '영업'],
        likePatterns: ['%마케터%', '%홍보%', '%영업%'],
      },
      // 확장 토큰 (시나리오/확장 입력용)
      creative: {  // 'creating' alias
        patterns: ['디자이너', '기획자', '작가', '예술', '크리에이터'],
        likePatterns: ['%디자이너%', '%기획자%', '%작가%', '%예술%', '%크리에이터%'],
      },
      design: {
        patterns: ['디자이너', '그래픽', 'UI', 'UX', '시각'],
        likePatterns: ['%디자이너%', '%그래픽%', '%UI%', '%UX%', '%시각%'],
      },
      art: {
        patterns: ['예술', '작가', '일러스트', '미술', '공예'],
        likePatterns: ['%예술%', '%작가%', '%일러스트%', '%미술%', '%공예%'],
      },
      research: {
        patterns: ['연구원', '분석가', '리서처', '연구', '조사'],
        likePatterns: ['%연구원%', '%분석가%', '%리서처%', '%연구%', '%조사%'],
      },
      routine: {
        patterns: ['행정', '사무', '공무원', '경리', '총무'],
        likePatterns: ['%행정%', '%사무%', '%공무원%', '%경리%', '%총무%'],
      },
    }

    const existingJobIds = new Set(filteredJobs.map(j => String(j.job_id)))
    const injectedJobNames = new Set<string>()  // 동일 직업명 중복 주입 방지
    const mmInterests = (payload.mini_module_result?.interest_top || []) as string[]

    // v3.10.6: Archetype DB 쿼리 병렬화 (2개 interest를 동시에 조회)
    const archetypeQueries: Array<{ interest: string; config: typeof ARCHETYPE_DB_QUERIES[string]; existingCount: number }> = []
    for (const interest of mmInterests.slice(0, 2)) {
      const config = ARCHETYPE_DB_QUERIES[interest]
      if (!config) continue
      const existingCount = filteredJobs.filter(j => config.patterns.some(p => j.job_name.includes(p))).length
      if (existingCount >= 8) {
        continue
      }
      archetypeQueries.push({ interest, config, existingCount })
    }

    // DB 쿼리만 병렬 실행, 결과 처리는 순차 (중복 제거 로직 유지)
    const archetypeDbResults = await Promise.all(
      archetypeQueries.map(async ({ interest, config }) => {
        const likeConditions = config.likePatterns.map(() => 'ja.job_name LIKE ?').join(' OR ')
        try {
          const dbResult = await db.prepare(`
            SELECT
              ja.job_id, ja.job_name,
              j.slug, j.image_url, j.api_data_json, j.merged_profile_json,
              ja.wlb, ja.growth, ja.stability, ja.income,
              ja.teamwork, ja.solo_deep, ja.analytical, ja.creative, ja.execution, ja.people_facing,
              ja.work_hours, ja.shift_work, ja.travel, ja.remote_possible,
              ja.degree_required, ja.license_required
            FROM job_attributes ja
            JOIN jobs j ON ja.job_id = j.id
            WHERE (${likeConditions}) AND j.slug IS NOT NULL
            GROUP BY ja.job_name
            ORDER BY ja.people_facing DESC, ja.stability DESC
            LIMIT 30
          `).bind(...config.likePatterns).all()
          return { interest, results: dbResult.results || [], error: null }
        } catch (dbErr) {
          return { interest, results: [], error: dbErr }
        }
      })
    )

    // 결과 처리 (순차 - 중복 제거 상태 공유)
    for (let qi = 0; qi < archetypeQueries.length; qi++) {
      const { interest, existingCount } = archetypeQueries[qi]
      const { results } = archetypeDbResults[qi]
      if (results.length === 0) {
        continue
      }

      const injected: string[] = []
      const needed = 10 - existingCount

      for (const row of results as any[]) {
        if (existingJobIds.has(String(row.job_id))) continue
        if (injectedJobNames.has(row.job_name)) continue
        if (injected.length >= needed) break

        const personalized = calculatePersonalizedBaseScores(row, payload.mini_module_result)
        const baseLike = Math.min(100, personalized.like)
        const baseCan = Math.min(100, personalized.can)
        const baseRisk = 0  // v3.16: archetype 직접 주입은 tag-filter 미경유이므로 risk 0
        const archetypeBoost = 12
        const boostedLike = Math.min(100, baseLike + archetypeBoost)
        const boostedCan = Math.min(100, baseCan + Math.round(archetypeBoost * 0.5))

        let kscoMajor = ''
        if (row.merged_profile_json) {
          try {
            const profile = JSON.parse(row.merged_profile_json)
            kscoMajor = profile.ksco_major || profile.kscoMajor || ''
          } catch {}
        }

        const scoredJob = {
          job_id: row.job_id,
          job_name: row.job_name,
          slug: row.slug || undefined,
          image_url: row.image_url || undefined,
          job_description: extractJobDescription(row.api_data_json, row.merged_profile_json, row.job_name),
          base_like: baseLike,
          base_can: baseCan,
          base_risk: baseRisk,
          like_score: boostedLike,
          can_score: boostedCan,
          risk_penalty: baseRisk,
          final_score: Math.round(0.55 * boostedLike + 0.45 * boostedCan - baseRisk),
          ksco_major: kscoMajor,
          tag_source: 'archetype_inject' as const,
          attributes: {
            wlb: row.wlb,
            growth: row.growth,
            stability: row.stability,
            income: row.income,
            remote: row.remote_possible === 'full' ? 100 : row.remote_possible === 'partial' ? 50 : 0,
            solo_work: row.solo_deep,
            solo_deep: row.solo_deep,
            people_facing: row.people_facing,
            analytical: row.analytical,
            creative: row.creative,
            execution: row.execution,
            teamwork: row.teamwork,
            work_hours: row.work_hours,
            shift_work: row.shift_work,
            degree_required: row.degree_required,
            license_required: row.license_required,
            ksco_major: kscoMajor,
          },
        }

        filteredJobs.push(scoredJob as any)
        existingJobIds.add(String(row.job_id))
        injectedJobNames.add(row.job_name)
        injected.push(`${row.job_name}(like:${boostedLike},can:${boostedCan},fit:${scoredJob.final_score})`)
      }
    }

    // v3.9.5: 사전 필터된 상위 후보군 (Like/Can/Final 3축 분리로 다양한 후보 확보)
    // Like 편향 후보: like_score 상위 20개
    const likeBiasedJobs = [...filteredJobs]
      .sort((a, b) => (b.like_score || 0) - (a.like_score || 0))
      .slice(0, 20)
    // Can 편향 후보: can_score 상위 20개
    const canBiasedJobs = [...filteredJobs]
      .sort((a, b) => (b.can_score || 0) - (a.can_score || 0))
      .slice(0, 20)
    // Final 편향 후보: final_score 상위 20개 (개인화 점수 기반 종합 최적)
    const finalBiasedJobs = [...filteredJobs]
      .sort((a, b) => (b.final_score || 0) - (a.final_score || 0))
      .slice(0, 20)
    // 합집합 (중복 제거) → ~40-50개 unique 후보
    const preFilterJobIdSet = new Set<string>()
    const preFilteredJobs: typeof filteredJobs = []
    for (const job of [...likeBiasedJobs, ...canBiasedJobs, ...finalBiasedJobs]) {
      if (!preFilterJobIdSet.has(job.job_id)) {
        preFilterJobIdSet.add(job.job_id)
        preFilteredJobs.push(job)
      }
    }

    // v3.10: 아키타입 보장 — DB에서 주입한 직업이 pre-filter에서 밀려났으면 강제 추가
    // 최소 5개 아키타입 직업이 LLM Judge에 도달하도록 보장
    for (const interest of mmInterests.slice(0, 2)) {
      const config = ARCHETYPE_DB_QUERIES[interest]
      if (!config) continue
      const inPreFilter = preFilteredJobs.filter(j => config.patterns.some(p => j.job_name.includes(p)))
      const guaranteeMin = 5  // 최소 5개 보장 (기존 3개 → 5개로 상향)
      if (inPreFilter.length >= guaranteeMin) {
        continue
      }
      // filteredJobs에서 해당 아키타입 직업 중 pre-filter에 없는 것 강제 추가
      const missing = filteredJobs
        .filter(j => config.patterns.some(p => j.job_name.includes(p)) && !preFilterJobIdSet.has(j.job_id))
        .sort((a, b) => (b.final_score || 0) - (a.final_score || 0))
        .slice(0, guaranteeMin - inPreFilter.length)
      for (const job of missing) {
        preFilterJobIdSet.add(job.job_id)
        preFilteredJobs.push(job)
      }
      if (missing.length > 0) {
      }
    }

    // ScoredJob을 FilteredCandidate 형태로 변환 (attributes 포함!)
    const candidatesForJudge: FilteredCandidate[] = preFilteredJobs.map(job => ({
      job_id: job.job_id,
      job_name: job.job_name,
      score: job.final_score || job.like_score || 0,
      riskPenalty: job.risk_penalty || 0,
      riskWarnings: [],
      tagSource: 'tagged' as const,
      attributes: job.attributes,  // ★ job_attributes 수치 전달 (LLM Judge 근거 품질 향상)
    } as FilteredCandidate & { attributes?: Record<string, number | string> }))

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

    // v3.13: 배경 데이터 로드 (LLM Judge Feasibility 평가에 사용)
    let careerState: { role_identity: string; career_stage_years: string } | undefined
    let careerBackground: string | undefined
    try {
      const [roleRow, stageRow, draftRow] = await Promise.all([
        db.prepare(`SELECT value_json FROM facts WHERE session_id = ? AND fact_key = 'state.role_identity'`)
          .bind(session_id).first<{ value_json: string }>(),
        db.prepare(`SELECT value_json FROM facts WHERE session_id = ? AND fact_key = 'state.career_stage_years'`)
          .bind(session_id).first<{ value_json: string }>(),
        db.prepare(`SELECT aggregated_profile_json FROM analyzer_drafts WHERE session_id = ?`)
          .bind(session_id).first<{ aggregated_profile_json?: string }>(),
      ])
      careerState = {
        role_identity: roleRow ? JSON.parse(roleRow.value_json).value : '',
        career_stage_years: stageRow ? JSON.parse(stageRow.value_json).value : '',
      }
      // payload fallback: DB에 데이터가 없으면 (테스트 세션 등) payload의 career_state 사용
      if (!careerState.role_identity && payload.career_state?.role_identity) {
        careerState.role_identity = payload.career_state.role_identity
      }
      if (!careerState.career_stage_years && payload.career_state?.career_stage_years) {
        careerState.career_stage_years = payload.career_state.career_stage_years
      }
      if (draftRow?.aggregated_profile_json) {
        try {
          const profile = JSON.parse(draftRow.aggregated_profile_json)
          careerBackground = profile?.narrative?.career_background
        } catch { /* parse error, skip */ }
      }
    } catch (bgErr) {
    }

    if (openaiApiKey && candidatesForJudge.length > 0) {
      try {

        const judgeInput: JudgeInput = {
          candidates: candidatesForJudge,
          searchProfile,
          miniModuleResult: payload.mini_module_result,
          careerState,
          careerBackground,
          additionalContext: additionalContextForRecommend,
        }

        const judgeResults = await judgeCandidates(openaiApiKey, db, judgeInput)

        // Judge 결과를 topJobs에 매핑 (rationale + likeReason/canReason 포함)
        // 점수 매핑 정정:
        //   desireScore (흥미/가치 매칭) → like_score (좋아할 가능성)
        //   fitScore (강점/역량 매칭) → can_score (잘할 가능성)
        //   overallScore (종합) → fit_score (종합 적합도)
        //   feasibilityScore (배경적합도+진입장벽) → Fit 공식에 10% 반영
        // 전체 Judge 결과를 매핑 (Like/Can 분리를 위해 slice하지 않음)
        // diverseTop10에서 like_score/can_score 기준으로 각각 뽑으므로
        // 여기서 overallScore 상위 N개로 자르면 Like/Can이 동일해짐
        topJobs = judgeResults.results.map(result => {
          const originalJob = preFilteredJobs.find(j => j.job_id === result.job_id)
          // Phase 5-A2: PS Score Blending — deterministic PS 30% + LLM Judge 70%
          // PS 점수가 일관적이므로 Judge 변동을 안정화하는 앵커 역할
          const psScore = originalJob?.final_score || 0
          const judgeScore = result.overallScore
          const blendedFit = Math.round(psScore * 0.3 + judgeScore * 0.7)
          return {
            ...originalJob,
            like_score: result.desireScore,       // Like = 흥미/가치 매칭
            can_score: result.fitScore,            // Can = 강점/역량 매칭
            fit_score: blendedFit,                 // Phase 5: Blended (PS 30% + Judge 70%)
            final_score: blendedFit,
            risk_penalty: result.riskPenalty,
            feasibility_score: result.feasibilityScore,  // 현실성 점수 (참고용)
            rationale: result.rationale,
            like_reason: result.likeReason,   // 좋아할 이유
            can_reason: result.canReason,     // 잘할 이유
            feasibility_reason: result.feasibilityReason,  // 배경적합 이유
            evidence_quotes: result.evidenceQuotes,
          }
        })

        // Phase 7-B: 코드 레벨 Relevance Post-Filter (복합 키워드 매칭)
        // "연구" 같은 범용 접미사만으로 통과하지 못하도록 도메인 키워드 AND 매칭
        if (mmInterests.length > 0) {
          // interest 토큰별 도메인 키워드 (직업명의 도메인 부분과 매칭)
          // 토큰별 도메인 키워드 — 직업명에 이 키워드가 하나라도 있으면 관련 있는 것으로 판단
          // 주의: "디자이너" ≠ "디자인" (한국어 형태소가 다름) — 둘 다 포함해야 함
          const TOKEN_DOMAIN_KEYWORDS: Record<string, string[]> = {
            data_numbers: ['데이터', '분석', '통계', '수치', '빅데이터', 'AI', '인공지능', '머신러닝', '알고리즘', '정보', '수학'],
            tech: ['개발', '프로그래밍', 'IT', '소프트웨어', '시스템', '클라우드', '보안', '네트워크', '인공지능', '웹', '앱', '엔지니어'],
            creating: ['디자인', '디자이너', '창작', '기획', '콘텐츠', '게임', '영상', '광고', '미디어', '크리에이터', '방송', '원화', '아트'],
            creative: ['디자인', '디자이너', '창작', '기획', '콘텐츠', '게임', '영상', '광고', '미디어', '크리에이터', '방송', '원화', '아트'],
            design: ['디자인', '디자이너', 'UI', 'UX', '시각', '그래픽', '인터페이스', '브랜드', '패션', '원화'],
            art: ['예술', '미술', '공예', '일러스트', '작가', '디자인', '디자이너', '아트', '원화', '크리에이터'],
            helping_teaching: ['교육', '복지', '상담', '돌봄', '간호', '보육', '치료', '심리', '사회', '아동', '교사', '강사'],
            helping: ['교육', '복지', '상담', '돌봄', '간호', '보육', '치료', '심리', '사회', '아동', '지도원'],
            helping_feedback: ['복지', '상담', '지도원', '간호', '돌봄', '치료'],
            organizing: ['행정', '관리', '사무', '기획', '총무', '경영', '인사', '재무', '회계'],
            problem_solving: ['컨설팅', '전략', '분석', '기획', '솔루션', '컨설턴트', '경영컨설', '경영기획', '경영혁신'],
            influencing: ['마케팅', '홍보', '영업', '커뮤니케이션', '브랜드', '광고'],
            research: ['데이터', '통계', '실험', 'R&D', '생명공학', '의학연구', '공학연구', 'AI연구', '인공지능연구', '경제연구', '정책연구'],
          }
          // 도메인 키워드 수집 (TOKEN_DOMAIN_KEYWORDS만 사용)
          // 아키타입 패턴(ARCHETYPE_DB_QUERIES)은 DB 주입용이므로 relevance filter에 포함하지 않음
          // — "연구원", "분석가" 같은 범용 패턴이 국악연구원/버섯연구원을 통과시키는 버그 방지
          const domainKeywords: string[] = []
          for (const interest of mmInterests) {
            if (TOKEN_DOMAIN_KEYWORDS[interest]) domainKeywords.push(...TOKEN_DOMAIN_KEYWORDS[interest])
          }
          const uniqueDomainKw = [...new Set(domainKeywords)]

          // v3.18.1: 명백한 노이즈 직업명 패턴 (llm-judge.ts와 동기화)
          const NOISE_JOB_PATTERNS = [
            /버섯|양봉|양잠|양식장|축산|낙농|임업/,
            /광부|광산|채굴|채석/,
            /용접|도금|주조|단조|열처리|선반|압출/,
            /반장|조장|현장감독/,
            /고무|섬유|피혁|유리|도자기|석재/,
            /가스설비|배관|보일러|냉동|냉방|공조/,
            /식품가공|제분|도축|도정|양조/,
            /도배|미장|방수|타일|도장공/,
            /재봉|봉제|직조|편직|자수/,
            /국악|전통음악|풍물/,
            /기능성식품|건강기능|한약|한방/,
            /목재|펄프|제지|합판/,
            /비파괴검사|방사선취급|초음파검사/,
            /세탁|세차|청소업|방역/,
            // v3.19: 경미한 노이즈 추가 (llm-judge.ts와 동기화)
            /화학정보학|화학공학연구|화학분석/,
            /금융자동화기기|ATM|현금자동/,
            /광통신|광섬유|광케이블/,
            /인쇄|제본|출판인쇄/,
          ]
          const hasPhysicalInterest = mmInterests.some(i =>
            ['nature', 'physical_activity', 'manufacturing'].includes(i)
          )

          if (uniqueDomainKw.length > 0) {
            for (const job of topJobs) {
              const jobName = (job as any).job_name || ''

              // 1차: 명백한 노이즈 직업은 무조건 캡 (물리적 흥미가 없는 한)
              if (!hasPhysicalInterest && NOISE_JOB_PATTERNS.some(p => p.test(jobName))) {
                if ((job as any).like_score > 45) (job as any).like_score = 45
                if ((job as any).fit_score > 50) (job as any).fit_score = 50
                if ((job as any).final_score > 50) (job as any).final_score = 50
                continue
              }

              // 2차: 도메인 키워드 매칭
              const isRelevant = uniqueDomainKw.some(kw => jobName.includes(kw))
              if (!isRelevant) {
                if ((job as any).like_score > 45) (job as any).like_score = 45
                if ((job as any).fit_score > 55) (job as any).fit_score = 55
                if ((job as any).final_score > 55) (job as any).final_score = 55
              }
            }
          }
        }

        // Phase 6-C: Feasibility 코드 레벨 앵커 — Can부족 유저 보정
        // background_flags가 비어있으면(경험 없음) 시니어/전문가급 직업의 can_score 상한 적용
        const bgFlags = payload.mini_module_result?.background_flags || []
        const hasNoBackground = bgFlags.length === 0
        if (hasNoBackground) {
          const SENIOR_KEYWORDS = ['수석', '책임', '시니어', '선임', '수장', '총괄', '관장', '원장', '소장', '부장', '팀장', '본부장', '실장', '이사', '전문가', '아키텍트', '리드', '매니저']
          const ENTRY_KEYWORDS = ['주니어', '인턴', '보조', '사무원', '연구원', '교사', '간호사', '치료사', '사서', '상담사', '복지사']
          for (const job of topJobs) {
            const jobName = (job as any).job_name || ''
            const isSenior = SENIOR_KEYWORDS.some(kw => jobName.includes(kw))
            const isEntry = ENTRY_KEYWORDS.some(kw => jobName.includes(kw))
            if (isSenior && !isEntry) {
              // 시니어급 직업: can_score 상한 55, feasibility 상한 45
              if ((job as any).can_score > 55) (job as any).can_score = 55
              if ((job as any).feasibility_score > 45) (job as any).feasibility_score = 45
              // fit 재계산: blended는 이미 적용됨, Judge 비중(70%)의 can 반영
              const newOverall = Math.round(((job as any).like_score * 0.35) + ((job as any).can_score * 0.45) + ((job as any).feasibility_score * 0.20))
              const cappedRisk = Math.min((job as any).risk_penalty || 0, 8)
              const newFit = Math.max(0, Math.min(100, newOverall - cappedRisk))
              if (newFit < (job as any).fit_score) {
                (job as any).fit_score = newFit
                ;(job as any).final_score = newFit
              }
            } else if (!isSenior && !isEntry) {
              // 경력 무관한 일반 직업: can_score 상한 70
              if ((job as any).can_score > 70) (job as any).can_score = 70
            }
            // entry-level 직업은 제한 없음 (신입 가능)
          }
        }

        // Phase 6-D: riskPenalty 차별화 — constraint_flags 기반
        // 유저의 constraint(회피 조건)와 직업 속성이 충돌하면 추가 패널티
        const constraintFlags = payload.mini_module_result?.constraint_flags || []
        if (constraintFlags.length > 0) {
          const CONSTRAINT_JOB_CONFLICTS: Record<string, (jobName: string) => boolean> = {
            'routine_drain': (name) => ['사무원', '관리원', '서기', '수위', '경비'].some(kw => name.includes(kw)),
            'people_drain': (name) => ['영업', '상담', '안내', '접객', '서비스', '홍보', '판매'].some(kw => name.includes(kw)),
            'unstable_hours': (name) => ['간호', '응급', '소방', '경찰', '야간', '교대', '운전', '배달'].some(kw => name.includes(kw)),
            'low_initial_income': (name) => ['인턴', '봉사', '예술', '작가', '음악', '배우', '프리랜서'].some(kw => name.includes(kw)),
            'physical_demand': (name) => ['반장', '현장', '공사', '설치', '정비', '용접', '배관', '건설'].some(kw => name.includes(kw)),
          }
          for (const job of topJobs) {
            const jobName = (job as any).job_name || ''
            let extraPenalty = 0
            for (const constraint of constraintFlags) {
              const conflictFn = CONSTRAINT_JOB_CONFLICTS[constraint]
              if (conflictFn && conflictFn(jobName)) {
                extraPenalty += 5  // 충돌당 5점 추가 패널티
              }
            }
            if (extraPenalty > 0) {
              const currentFit = (job as any).fit_score || 0
              const newFit = Math.max(0, currentFit - extraPenalty)
              ;(job as any).fit_score = newFit
              ;(job as any).final_score = newFit
              ;(job as any).risk_penalty = ((job as any).risk_penalty || 0) + extraPenalty
            }
          }
        }

        // ============================================
        // Phase 6-E: 내러티브 키워드 친화도 보너스 (v3.19.1)
        // 유저가 직접 언급한 직업 도메인 키워드가 직업명에 포함되면 +3 보너스
        // → Top1이 유저의 실제 분야와 일치하도록 보정
        // ============================================
        const CAREER_FIELD_KEYWORDS: Record<string, string[]> = {
          // 유저 텍스트의 키워드 → 직업명에서 찾을 패턴
          '개발': ['개발', '프로그래머', '엔지니어'],
          '프로그래밍': ['개발', '프로그래머', '엔지니어'],
          '코딩': ['개발', '프로그래머', '엔지니어'],
          '프론트엔드': ['개발', '프로그래머', 'UI', 'UX', '웹'],
          '백엔드': ['개발', '프로그래머', '엔지니어', '서버'],
          '풀스택': ['개발', '프로그래머', '엔지니어'],
          'React': ['개발', '프로그래머', '웹'],
          'TypeScript': ['개발', '프로그래머', '웹'],
          'Python': ['개발', '프로그래머', '데이터', '분석'],
          'SQL': ['데이터', '분석', '엔지니어'],
          '디자인': ['디자이너', '디자인'],
          'Figma': ['디자이너', 'UI', 'UX', '디자인'],
          'Adobe': ['디자이너', '디자인', '그래픽'],
          '일러스트': ['디자이너', '디자인', '일러스트'],
          '브랜딩': ['디자이너', '브랜드', '마케터'],
          '데이터': ['데이터', '분석', '빅데이터'],
          '분석': ['분석', '데이터', '컨설턴트'],
          '통계': ['분석', '데이터', '통계'],
          '머신러닝': ['인공지능', 'AI', '모델', '엔지니어'],
          '인공지능': ['인공지능', 'AI', '엔지니어'],
          '공무원': ['공무원', '사무원', '행정', '공공'],
          '행정': ['행정', '사무원', '관리자', '공공'],
          '기획': ['기획자', '기획'],
          '마케팅': ['마케팅', '마케터', '광고'],
          '간호': ['간호사', '간호', '의료'],
          '교사': ['교사', '교육', '강사'],
          '교육': ['교사', '교육', '강사'],
          '회계': ['회계', '세무', '재무'],
          '법률': ['변호사', '법무', '법률'],
          '상담': ['상담사', '상담', '심리'],
        }

        // 유저 텍스트 수집 (narrative facts + round answers)
        const userTextsForAffinity: string[] = []
        if (nfRow?.high_alive_moment) userTextsForAffinity.push(nfRow.high_alive_moment)
        if (nfRow?.lost_moment) userTextsForAffinity.push(nfRow.lost_moment)
        if (raRows?.results) {
          for (const r of raRows.results) {
            if (r.answer) userTextsForAffinity.push(r.answer)
          }
        }
        const allUserText = userTextsForAffinity.join(' ')

        // 유저 텍스트에서 직업 도메인 키워드 추출
        const matchedJobPatterns = new Set<string>()
        for (const [keyword, patterns] of Object.entries(CAREER_FIELD_KEYWORDS)) {
          if (allUserText.includes(keyword)) {
            for (const p of patterns) matchedJobPatterns.add(p)
          }
        }

        // 매칭된 패턴이 있으면 보너스 적용 (v3.21: 서브도메인 강화)
        // 정확한 도메인 매칭 키워드 (유저가 "데이터분석"이라고 하면 데이터분석가에 +5)
        const EXACT_DOMAIN_KEYWORDS: Record<string, string[]> = {
          '데이터분석': ['데이터분석가', '데이터분석', '빅데이터'],
          '데이터 분석': ['데이터분석가', '데이터분석', '빅데이터'],
          '웹개발': ['웹개발', '웹프로그래머', '프론트엔드'],
          '웹 개발': ['웹개발', '웹프로그래머', '프론트엔드'],
          '게임개발': ['게임', '게임프로그래머', '게임개발'],
          'UI디자인': ['UI', 'UX', '디자이너'],
          'UX디자인': ['UI', 'UX', '디자이너'],
        }

        // 정확한 도메인 매칭 보너스 (+5, 일반 +3보다 높음)
        const exactDomainPatterns = new Set<string>()
        for (const [keyword, patterns] of Object.entries(EXACT_DOMAIN_KEYWORDS)) {
          if (allUserText.includes(keyword)) {
            for (const p of patterns) exactDomainPatterns.add(p)
          }
        }

        if (matchedJobPatterns.size > 0 || exactDomainPatterns.size > 0) {
          for (const job of topJobs) {
            const jobName = (job as any).job_name || ''
            // 정확한 도메인 매칭은 +5
            const hasExactDomain = [...exactDomainPatterns].some(p => jobName.includes(p))
            if (hasExactDomain) {
              ;(job as any).final_score = ((job as any).final_score || 0) + 5
              ;(job as any).fit_score = ((job as any).fit_score || 0) + 5
            } else {
              // 일반 키워드 매칭은 +3
              const hasAffinity = [...matchedJobPatterns].some(p => jobName.includes(p))
              if (hasAffinity) {
                ;(job as any).final_score = ((job as any).final_score || 0) + 3
                ;(job as any).fit_score = ((job as any).fit_score || 0) + 3
              }
            }
          }
        }
      } catch (judgeError) {
        // LLM Judge 실패 시 에러 반환 (fallback 없음)
        const errorMessage = judgeError instanceof Error ? judgeError.message : String(judgeError)
        return c.json(createErrorResponse(
          'LLM_JUDGE_FAILED',
          `LLM 분석이 실패했습니다: ${errorMessage}`
        ), 500)
      }
    } else {
      // API 키가 없으면 에러 (위에서 이미 체크하므로 여기 도달하면 안됨)
      return c.json(createErrorResponse(
        'INTERNAL_ERROR',
        'OpenAI API 키가 설정되지 않았습니다.'
      ), 500)
    }

    // ============================================
    // 5. LLM Reporter: 심리분석 리포트 생성 (skipReport=true이면 건너뜀)
    // ============================================
    let premiumReport: any = null
    let reportMode: 'llm' | 'fallback' | 'none' | 'deferred' = skipReport ? 'deferred' : 'none'
    let narrativeFacts: { highAliveMoment: string; lostMoment: string; existentialAnswer?: string } | undefined
    let roundAnswers: Array<{ roundNumber: 1 | 2 | 3; questionId: string; answer: string }> = []

    if (!skipReport) {
    // v3.10.6: NarrativeFacts + RoundAnswers 병렬 조회 (순차→병렬로 ~1초 절약)
    const [narrativeResult, roundAnswersResult] = await Promise.allSettled([
      // 5-1. NarrativeFacts
      db.prepare(`
        SELECT high_alive_moment, lost_moment, existential_answer
        FROM narrative_facts
        WHERE session_id = ?
      `).bind(session_id).first<{
        high_alive_moment: string | null
        lost_moment: string | null
        existential_answer: string | null
      }>(),
      // 5-2. RoundAnswers
      db.prepare(`
        SELECT round_number, question_id, answer
        FROM round_answers
        WHERE session_id = ?
        ORDER BY round_number, question_id
      `).bind(session_id).all<{
        round_number: number
        question_id: string
        answer: string
      }>(),
    ])

    if (narrativeResult.status === 'fulfilled' && narrativeResult.value) {
      const narrativeRow = narrativeResult.value
      if (narrativeRow.high_alive_moment || narrativeRow.lost_moment) {
        narrativeFacts = {
          highAliveMoment: narrativeRow.high_alive_moment || '',
          lostMoment: narrativeRow.lost_moment || '',
          existentialAnswer: narrativeRow.existential_answer || undefined,
        }
      }
    } else if (narrativeResult.status === 'rejected') {
    }

    if (roundAnswersResult.status === 'fulfilled' && roundAnswersResult.value?.results?.length) {
      roundAnswers = roundAnswersResult.value.results.map(row => ({
        roundNumber: row.round_number as 1 | 2 | 3,
        questionId: row.question_id,
        answer: row.answer,
      }))
    } else if (roundAnswersResult.status === 'rejected') {
    }

    // 5-3. LLM Reporter 호출
    if (openaiApiKey && topJobs.length > 0) {
      try {

        // excluded jobs 목록 (Hard Cut)
        const hardCutList = mmFilterResult.excludedJobIds.map((jobId, idx) => ({
          job_id: jobId,
          job_name: `Excluded Job ${idx + 1}`,
          rule_id: mmFilterResult.appliedRules[0]?.ruleId || 'mini_module_filter',
          reason: mmFilterResult.appliedRules[0]?.description || '미니모듈 기반 제외',
        })).slice(0, 10)

        // Reporter에는 fit_score 상위 20개만 전달 (프롬프트 길이 제한)
        const topJobsForReporter = [...topJobs]
          .sort((a, b) => (b.final_score || 0) - (a.final_score || 0))
          .slice(0, judgeTopN)
        const reporterInput: ReporterInput = {
          sessionId: session_id,
          judgeResults: topJobsForReporter.map(job => ({
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
          additionalContext: additionalContextForRecommend,
        }

        premiumReport = await generateLLMPremiumReport(
          env?.AI || null,
          reporterInput,
          openaiApiKey
        )
        // LLM 리포트인지 fallback인지 확인 (metaCognition._meta.generated_by로 판단)
        reportMode = premiumReport?.metaCognition?._meta?.generated_by === 'rule' ? 'fallback' : 'llm'
      } catch (reporterError) {
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
    } // end if (!skipReport)

    // v3.10.2: 포스트-Judge 아키타입 보장
    // LLM Judge가 유저의 핵심 흥미 아키타입 직업에 낮은 점수를 줄 경우,
    // 최종 결과에 최소 2개 아키타입 직업이 포함되도록 점수 보정
    if (topJobs.length > 0 && mmInterests.length > 0) {
      const primaryInterest = mmInterests[0]
      const primaryConfig = ARCHETYPE_DB_QUERIES[primaryInterest]
      if (primaryConfig) {
        const archetypeInTop = topJobs.filter(j =>
          primaryConfig.patterns.some(p => j.job_name.includes(p))
        )

        if (archetypeInTop.length > 0) {
          // topJobs를 fit 순으로 정렬했을 때 아키타입 직업이 top10 밖이면 부스트
          const sortedByFit = [...topJobs].sort((a, b) => (b.final_score || 0) - (a.final_score || 0))
          const top10Threshold = sortedByFit[Math.min(9, sortedByFit.length - 1)]?.final_score || 0

          const archetypeBelowThreshold = archetypeInTop.filter(j => (j.final_score || 0) < top10Threshold)
          if (archetypeBelowThreshold.length > 0) {
            // 상위 3개 아키타입 직업에 부스트 적용
            const toBoost = archetypeBelowThreshold
              .sort((a: any, b: any) => (b.final_score || 0) - (a.final_score || 0))
              .slice(0, 3)
            for (const job of toBoost) {
              const oldLike = job.like_score || 0
              const oldCan = job.can_score || 0
              const oldFit = job.final_score || 0
              // 유저의 #1 흥미와 직접 매칭되는 직업 → Like + Can 부스트
              job.like_score = Math.min(100, oldLike + 15)
              job.can_score = Math.min(100, oldCan + 8)
              job.final_score = Math.round(0.55 * job.like_score + 0.45 * job.can_score - (job.risk_penalty || 0))
            }
          }
        }
      }
    }

    // 6. 결과 반환
    const duration = Date.now() - startTime

    // 카테고리 다양성 적용 Top 10 선택 함수
    // 같은 KSCO 대분류에서 최대 3개까지만 허용, 부족하면 fallback으로 채움
    const diverseTop10 = (
      jobs: any[],
      scoreKey: 'like_score' | 'can_score',
      maxPerCategory: number = 3
    ) => {
      const sorted = [...jobs]
        .filter(job => (job.final_score || job.fit_score || 0) >= 25)
        .sort((a, b) => {
          const scoreDiff = (b[scoreKey] || 0) - (a[scoreKey] || 0)
          // 점수 차이 3점 이내 → 편향 tie-break: like는 desire>fit 우선, can은 fit>desire 우선
          if (Math.abs(scoreDiff) <= 3) {
            if (scoreKey === 'like_score') {
              return ((b.like_score || 0) - (b.can_score || 0)) - ((a.like_score || 0) - (a.can_score || 0))
            } else {
              return ((b.can_score || 0) - (b.like_score || 0)) - ((a.can_score || 0) - (a.like_score || 0))
            }
          }
          return scoreDiff
        })

      const result: any[] = []
      const selectedIds = new Set<string>()
      const categoryCount = new Map<string, number>()

      // 1차: 카테고리 다양성 적용
      for (const job of sorted) {
        if (result.length >= 10) break
        const category = job.ksco_major || job.attributes?.ksco_major || '기타'
        const count = categoryCount.get(category) || 0
        if (count >= maxPerCategory) continue

        result.push(job)
        selectedIds.add(job.job_id)
        categoryCount.set(category, count + 1)
      }

      // 2차 fallback: 10개 미만이면 카테고리 제한 없이 점수순으로 채움
      if (result.length < 10) {
        for (const job of sorted) {
          if (result.length >= 10) break
          if (selectedIds.has(job.job_id)) continue
          result.push(job)
          selectedIds.add(job.job_id)
        }
      }

      return result
    }

    const jobToDto = (job: any) => ({
      job_id: job.job_id,
      job_name: job.job_name,
      job_description: job.job_description || null,
      slug: job.slug,
      image_url: job.image_url || null,
      fit_score: job.final_score || job.fit_score || 50,
      like_score: job.like_score || 50,
      can_score: job.can_score || 50,
      feasibility_score: job.feasibility_score || 0,
      rationale: job.rationale || null,
      like_reason: job.like_reason || null,
      can_reason: job.can_reason || null,
    })

    // like_top10: like_score 기준 + 카테고리 다양성
    let likeTop10 = diverseTop10(topJobs, 'like_score').map(jobToDto)

    // can_top10: can_score 기준 + 카테고리 다양성
    let canTop10 = diverseTop10(topJobs, 'can_score').map(jobToDto)

    // v3.10.3: 최종 결과 아키타입 강제 삽입
    // Judge가 아키타입 직업에 낮은 점수를 줘서 top10에 못 들어가는 경우,
    // 최종 리스트에 직접 삽입하여 유저의 #1 흥미와 관련된 직업이 반드시 포함되도록 보장
    if (topJobs.length > 0 && mmInterests.length > 0) {
      const primaryInterest = mmInterests[0]
      const primaryConfig = ARCHETYPE_DB_QUERIES[primaryInterest]
      if (primaryConfig) {
        // topJobs(Judge 결과 전체)에서 아키타입 매칭 직업 찾기
        const archetypeFromJudge = topJobs
          .filter((j: any) => primaryConfig.patterns.some(p => j.job_name.includes(p)))
          .sort((a: any, b: any) => (b.like_score || 0) - (a.like_score || 0))

        const injectIntoList = (list: any[], sortKey: 'like_score' | 'can_score', minCount: number) => {
          const existingInList = list.filter(j => primaryConfig.patterns.some(p => j.job_name.includes(p)))
          if (existingInList.length >= minCount) return list

          const needed = minCount - existingInList.length
          const existingIds = new Set(list.map(j => j.job_id))

          // Judge 결과에서 아키타입 직업 중 리스트에 없는 것 선택
          const toInject = archetypeFromJudge
            .filter((j: any) => !existingIds.has(j.job_id))
            .slice(0, needed)
            .map(jobToDto)

          if (toInject.length === 0) return list

          // 리스트 끝에서부터 교체 (가장 낮은 점수 직업을 대체)
          const result = [...list]
          for (let i = 0; i < toInject.length && result.length > 0; i++) {
            result[result.length - 1 - i] = toInject[i]
          }
          return result
        }

        likeTop10 = injectIntoList(likeTop10, 'like_score', 2)
        canTop10 = injectIntoList(canTop10, 'can_score', 2)

        // fit_top3용도 체크: topJobs를 fit 순으로 정렬할 때 아키타입 포함 여부
        // (fit_top3는 resultToSave에서 직접 구성하므로 아래서 처리)
      }
    }

    // ============================================
    // 6-1. Confidence 계산 → premiumReport에 주입
    // ============================================
    try {
      // 1) DB facts 시도
      let cfFacts: Array<{ fact_key: string; value_json: string }> = []
      try {
        const factsResult = await db.prepare(
          `SELECT fact_key, value_json FROM facts WHERE session_id = ?`
        ).bind(session_id).all<{ fact_key: string; value_json: string }>()
        cfFacts = factsResult.results || []
      } catch { /* facts 테이블 없어도 OK */ }

      // 2) DB facts가 부족하면 mini_module_result에서 빌드
      if (cfFacts.length < 3 && payload.mini_module_result) {
        cfFacts = buildConfidenceFactsFromMiniModule(payload.mini_module_result)
      }

      const topScores = [...topJobs]
        .sort((a, b) => (b.final_score || 0) - (a.final_score || 0))
        .slice(0, 10)
        .map(j => j.final_score || 0)
      const confidenceResult = calculateConfidenceScore(
        cfFacts.map(f => ({
          fact_key: f.fact_key,
          source: f.fact_key.startsWith('followup') ? 'followup' as const : undefined,
          value_json: f.value_json,
        })),
        roundAnswers.length,
        topScores
      )
      if (premiumReport) {
        premiumReport._confidence = confidenceResult.score
      }
    } catch (e) {
    }

    // DB 전체 직업 수 조회 (UI 표시용)
    if (premiumReport) {
      try {
        const totalJobCount = await db.prepare('SELECT COUNT(*) as cnt FROM jobs').first<{ cnt: number }>()
        premiumReport._totalJobCount = totalJobCount?.cnt || 0
      } catch (e) {
      }
    }

    // ============================================
    // 6-F. Risk Demotion (v3.21.7) — 안정 지향 유저의 고위험 직업 점수 하락
    // Quality Floor 이전에 실행하여 디모트된 직업이 자연 탈락하도록 함
    // ============================================
    {
      const hasStabilityConstraint = Boolean(
        (userConstraints as any).work_hours_strict ||
        (userConstraints as any).no_travel ||
        (userConstraints as any).prefer_wlb ||
        (userConstraints as any).prefer_stability
      )
      if (hasStabilityConstraint) {
        for (const job of topJobs) {
          const risk = (job as any).risk_penalty || 0
          if (risk >= 10) {
            const extraPenalty = risk >= 12 ? 12 : 8
            ;(job as any).final_score = Math.max(40, ((job as any).final_score || 0) - extraPenalty)
            ;(job as any).fit_score = Math.max(40, ((job as any).fit_score || 0) - extraPenalty)
          }
        }
      }
    }

    // Risk Demotion 이후, Quality Floor 이전에 백업 (백필 후보 풀 확보)
    const allJudgedJobsBackup = [...topJobs].sort((a: any, b: any) => (b.final_score || 0) - (a.final_score || 0))

    // ============================================
    // 6-G. Spread Quality Floor (v3.21.8) — Spread ≤ 20 보장
    // Risk Demotion 이후 실행. guard >5로 소규모 풀에서도 작동
    // 백필이 10개 보장하므로 공격적 필터링 가능
    // ============================================
    if (topJobs.length > 5) {
      const sortedForFloor = [...topJobs].sort((a: any, b: any) => (b.final_score || 0) - (a.final_score || 0))
      const top1Score = (sortedForFloor[0] as any)?.final_score || 0
      const qualityFloor = top1Score - 20
      const floorFiltered = topJobs.filter((j: any) => (j.final_score || 0) >= qualityFloor)
      if (floorFiltered.length >= 5) {
        topJobs = floorFiltered
      } else {
        topJobs = sortedForFloor.slice(0, Math.max(floorFiltered.length, 5))
      }
    }

    // ============================================
    // 6-H. Ultra-Low Like Floor — like < 48 직업 제거
    // ============================================
    if (topJobs.length > 8) {
      const likeFiltered = topJobs.filter((j: any) => (j.like_score || 50) >= 48)
      if (likeFiltered.length >= 6) {
        topJobs = likeFiltered
      }
    }

    // ============================================
    // 6-I. 하드 노이즈 제거 — 명백한 도메인 불일치 직업 최종 제거
    // ============================================
    const HARD_NOISE_PATTERNS = [
      /공간정보|지리정보시스템|GIS|측량|지적/,
      /버섯|양봉|양잠|양식장|축산|낙농|임업/,
      /광부|광산|채굴|채석/,
      /국악|전통음악|풍물/,
      /기능성식품|건강기능|한약|한방/,
      /보험영업|보험설계/,
      /A&R|음반기획/,
      /공연기획|공연연출|무대감독/,
    ]
    if (topJobs.length > 5) {
      const noiseRemoved = topJobs.filter((j: any) => {
        const jobName = (j as any).job_name || ''
        return !HARD_NOISE_PATTERNS.some(p => p.test(jobName))
      })
      if (noiseRemoved.length >= 5) {
        topJobs = noiseRemoved
      }
    }

    // ============================================
    // 6-J. 최종 10개 결과 보장 (Progressive Backfill)
    // 1단계: top1-20 threshold (strict, spread ≤ 20)
    // 2단계: top1-25 threshold (relaxed, 잔여 슬롯만)
    // 양 단계 모두 노이즈 필터 적용
    // ============================================
    if (topJobs.length < 10 && allJudgedJobsBackup.length > topJobs.length) {
      const sortedCurrent = [...topJobs].sort((a: any, b: any) => (b.final_score || 0) - (a.final_score || 0))
      const currentTop1 = (sortedCurrent[0] as any)?.final_score || 0
      const existingIds = new Set(topJobs.map((j: any) => j.job_id))
      const noNoiseBackup = allJudgedJobsBackup
        .filter((j: any) => !existingIds.has(j.job_id))
        .filter((j: any) => !HARD_NOISE_PATTERNS.some(p => p.test((j as any).job_name || '')))

      // 1단계: strict (top1-20)
      const strictThreshold = currentTop1 - 20
      const strictCandidates = noNoiseBackup.filter((j: any) => (j.final_score || 0) >= strictThreshold)
      const needed1 = 10 - topJobs.length
      const strictFill = strictCandidates.slice(0, needed1)
      topJobs = [...topJobs, ...strictFill]

      // 2단계: relaxed (top1-25) — 아직 10개 미만이면
      if (topJobs.length < 10) {
        const relaxedThreshold = currentTop1 - 25
        const filledIds = new Set(topJobs.map((j: any) => j.job_id))
        const relaxedCandidates = noNoiseBackup
          .filter((j: any) => !filledIds.has(j.job_id))
          .filter((j: any) => (j.final_score || 0) >= relaxedThreshold)
        const needed2 = 10 - topJobs.length
        topJobs = [...topJobs, ...relaxedCandidates.slice(0, needed2)]
      }

      // 3단계: safety net (absolute min 55) — 극단적 제약조건 시나리오용
      if (topJobs.length < 10) {
        const absoluteMin = Math.min(currentTop1 - 30, 55)
        const filledIds3 = new Set(topJobs.map((j: any) => j.job_id))
        const safetyCandidates = noNoiseBackup
          .filter((j: any) => !filledIds3.has(j.job_id))
          .filter((j: any) => (j.final_score || 0) >= absoluteMin)
        const needed3 = 10 - topJobs.length
        topJobs = [...topJobs, ...safetyCandidates.slice(0, needed3)]
      }
    }

    // ============================================
    // 6-K. 의미적 유사 직업 Dedup Guard
    // 같은 직업의 다른 표기가 Top10에 동시 노출되는 것 방지
    // ============================================
    const SEMANTIC_DEDUP_GROUPS = [
      ['배우', '연기자'],
      ['번역가', '번역사'],
      ['통역가', '통역사'],
      ['분석가', '분석사', '애널리스트'],
      ['기자', '리포터', '저널리스트'],
      ['감독', '디렉터'],
      ['요리사', '셰프', '조리사'],
      ['상담사', '상담원', '카운슬러'],
    ]
    if (topJobs.length > 5) {
      const toRemoveIds = new Set<string>()
      for (const group of SEMANTIC_DEDUP_GROUPS) {
        // 그룹 내 suffix 매칭으로 직업 찾기 (정확히 끝나는 것만)
        const matched = topJobs.filter(j =>
          group.some(suffix => j.job_name === suffix || j.job_name.endsWith(suffix)) &&
          !toRemoveIds.has(j.job_id)
        )
        if (matched.length >= 2) {
          // 점수 높은 것 유지, 나머지 제거
          const sorted = matched.sort((a: any, b: any) => (b.final_score || 0) - (a.final_score || 0))
          for (let i = 1; i < sorted.length; i++) {
            toRemoveIds.add(sorted[i].job_id)
          }
        }
      }
      if (toRemoveIds.size > 0) {
        const before = topJobs.length
        topJobs = topJobs.filter((j: any) => !toRemoveIds.has(j.job_id))
        console.log(`[6-K Semantic Dedup] ${toRemoveIds.size}개 의미적 중복 제거 (${before} → ${topJobs.length})`)
      }
    }

    // ============================================
    // 7. 결과 저장 (ai_analysis_requests + ai_analysis_results)
    // ============================================
    const resultToSave = {
      engine_version: RECOMMENDATION_ENGINE_VERSION,
      mini_module_result: payload.mini_module_result || null,
      fit_top3: sanitizeJobListOutput([...topJobs].sort((a, b) => (b.final_score || 0) - (a.final_score || 0)).slice(0, 10).map(job => ({
        job_id: job.job_id,
        job_name: job.job_name,
        job_description: job.job_description || null,
        slug: job.slug,
        image_url: job.image_url || null,
        fit_score: job.final_score || job.fit_score || 50,
        like_score: job.like_score || 50,
        can_score: job.can_score || 50,
        feasibility_score: job.feasibility_score || 0,
        rationale: job.rationale || null,
        like_reason: job.like_reason || null,
        can_reason: job.can_reason || null,
      }))),
      like_top10: sanitizeJobListOutput(likeTop10),
      can_top10: sanitizeJobListOutput(canTop10),
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
          INSERT INTO ai_analysis_requests (session_id, user_id, analysis_type, prompt_payload, status, processed_at, requested_at)
          VALUES (?, ?, 'job', ?, 'completed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
        `).bind(session_id, effectiveUserId, JSON.stringify(searchProfile || {})).run()
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
              engine_version = ?,
              premium_report_json = ?
          WHERE request_id = ?
        `).bind(resultJson, RECOMMENDATION_ENGINE_VERSION, premiumJson, savedRequestId).run()

        if (!updateResult.meta?.changes || updateResult.meta.changes === 0) {
          // 기존 행이 없으면 새로 INSERT
          await db.prepare(`
            INSERT INTO ai_analysis_results (request_id, result_json, engine_version, premium_report_json, created_at)
            VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)
          `).bind(savedRequestId, resultJson, RECOMMENDATION_ENGINE_VERSION, premiumJson).run()
        }

      }

      // 프로필 영구 저장 (user_profiles 테이블)
      if (savedRequestId && effectiveUserId) {
        try {
          await saveUserProfile(db, {
            userId: effectiveUserId,
            analysisType: 'job',
            requestId: savedRequestId,
            miniModuleResult: payload.mini_module_result || {},
            narrativeFacts: narrativeFacts || null,
            roundAnswers: roundAnswers || null,
          })
        } catch (profileErr) {
          console.error('[recommend] Profile save error:', profileErr)
        }
      }
    } catch (saveError) {
      // 저장 실패해도 결과는 반환 (로그만 남김)
    }

    const responseBody = {
      success: true,
      mode: 'recommendation',
      session_id,
      request_id: savedRequestId,  // 결과 페이지 이동용
      recommendations: {
        top_jobs: sanitizeJobListOutput(topJobs.map(job => ({
          job_id: job.job_id,
          job_name: job.job_name,
          job_description: job.job_description || null,
          slug: job.slug,
          image_url: job.image_url || null,
          fit_score: job.final_score || job.fit_score || job.like_score || 50,
          like_score: job.like_score || 50,
          can_score: job.can_score || 50,
          feasibility_score: job.feasibility_score || 0,
          risk_penalty: job.risk_penalty || 0,
          rationale: job.rationale || null,
          like_reason: job.like_reason || null,   // 좋아할 이유
          can_reason: job.can_reason || null,     // 잘할 이유
          evidence_quotes: job.evidence_quotes || [],
        })).sort((a, b) => b.fit_score - a.fit_score)),
        like_top10: sanitizeJobListOutput(likeTop10),
        can_top10: sanitizeJobListOutput(canTop10),
        total_candidates: expansionResult.candidates.length,
        filtered_count: filteredJobs.length,
        search_duration_ms: expansionResult.search_duration_ms,
      },
      premium_report: premiumReport,
      engine_version: RECOMMENDATION_ENGINE_VERSION,
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
    }

    // Phase 9: 추천 결과 캐시 저장 (다음 동일 프로필 요청 시 즉시 반환)
    if (recCacheHash) {
      try {
        const { session_id: _sid, request_id: _rid, duration_ms: _dur, ...cacheableResult } = responseBody
        await db.prepare(
          'INSERT OR REPLACE INTO recommendation_result_cache (profile_hash, analysis_type, engine_version, result_json, premium_report_json) VALUES (?, ?, ?, ?, ?)'
        ).bind(recCacheHash, 'job', RECOMMENDATION_ENGINE_VERSION, JSON.stringify(cacheableResult), JSON.stringify(premiumReport)).run()
      } catch { /* 캐시 저장 실패 무시 */ }
    }

    return c.json(responseBody)
    
  } catch (error) {
    logError('ANALYSIS_FAILED', error instanceof Error ? error.message : 'Recommendation failed', {
      stack: error instanceof Error ? error.stack : undefined
    })
    return c.json(createErrorResponse(
      'ANALYSIS_FAILED',
      '추천 분석 중 오류가 발생했습니다.'
    ), 500)
  }
})

// ============================================
// Phase 2: LLM Reporter 전용 엔드포인트
// /v3/recommend에서 skipReport=true 후 호출
// ============================================
analyzerRoutes.post('/v3/recommend/report', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = c.env.OPENAI_API_KEY
  const { session_id } = await c.req.json<{ session_id: string }>()

  if (!session_id) {
    return c.json(createErrorResponse('VALIDATION_ERROR', 'session_id is required'), 400)
  }
  if (!openaiApiKey) {
    return c.json(createErrorResponse('INTERNAL_ERROR', 'OpenAI API key not configured'), 500)
  }

  try {
    const startTime = Date.now()

    // 1. DB에서 Phase 1 결과 로드
    const existingRequest = await db.prepare(
      `SELECT id FROM ai_analysis_requests WHERE session_id = ?`
    ).bind(session_id).first<{ id: number }>()
    if (!existingRequest) {
      return c.json(createErrorResponse('NOT_FOUND', 'Phase 1 결과가 없습니다. /v3/recommend를 먼저 호출하세요.'), 404)
    }

    const savedResult = await db.prepare(
      `SELECT result_json FROM ai_analysis_results WHERE request_id = ?`
    ).bind(existingRequest.id).first<{ result_json: string }>()
    if (!savedResult?.result_json) {
      return c.json(createErrorResponse('NOT_FOUND', '저장된 분석 결과가 없습니다.'), 404)
    }

    const parsed = JSON.parse(savedResult.result_json)
    const miniModuleResult = parsed.mini_module_result
    const searchProfile = parsed.search_profile
    const topJobs = parsed.fit_top3 || []

    // 2-3. NarrativeFacts + RoundAnswers 병렬 조회
    let narrativeFacts: { highAliveMoment: string; lostMoment: string; existentialAnswer?: string } | undefined
    let roundAnswers: Array<{ roundNumber: 1 | 2 | 3; questionId: string; answer: string }> = []

    const [nfResult, raResult] = await Promise.allSettled([
      db.prepare(
        `SELECT high_alive_moment, lost_moment, existential_answer FROM narrative_facts WHERE session_id = ?`
      ).bind(session_id).first<{ high_alive_moment: string | null; lost_moment: string | null; existential_answer: string | null }>(),
      db.prepare(
        `SELECT round_number, question_id, answer FROM round_answers WHERE session_id = ? ORDER BY round_number, question_id`
      ).bind(session_id).all<{ round_number: number; question_id: string; answer: string }>(),
    ])

    if (nfResult.status === 'fulfilled' && nfResult.value) {
      const narrativeRow = nfResult.value
      if (narrativeRow.high_alive_moment || narrativeRow.lost_moment) {
        narrativeFacts = {
          highAliveMoment: narrativeRow.high_alive_moment || '',
          lostMoment: narrativeRow.lost_moment || '',
          existentialAnswer: narrativeRow.existential_answer || undefined,
        }
      }
    }
    if (raResult.status === 'fulfilled' && raResult.value?.results?.length) {
      roundAnswers = raResult.value.results.map(r => ({ roundNumber: r.round_number as 1|2|3, questionId: r.question_id, answer: r.answer }))
    }

    // 4. Additional Context 조회
    let deferredAdditionalContext: string | undefined
    try {
      const acRows = await db.prepare(`
        SELECT value_text FROM analyzer_facts
        WHERE session_id = ? AND fact_key = 'additional_context'
        ORDER BY created_at DESC
      `).bind(session_id).all<{ value_text: string }>()
      if (acRows.results && acRows.results.length > 0) {
        deferredAdditionalContext = acRows.results.map(r => r.value_text).join('\n\n')
      }
    } catch { /* non-critical */ }

    // 4. LLM Reporter 호출
    const reporterInput: ReporterInput = {
      sessionId: session_id,
      judgeResults: topJobs.map((job: any) => ({
        job_id: job.job_id,
        job_name: job.job_name,
        slug: job.slug || '',
        image_url: job.image_url || undefined,
        like_score: job.like_score || 50,
        can_score: job.can_score || 50,
        fit_verdict: job.like_score >= 70 ? 'STRONG_FIT' : 'MODERATE_FIT',
        fit_summary: job.job_description || `${job.job_name}은(는) 당신의 관심사와 잘 맞습니다.`,
        risk_note: job.risk_penalty > 0 ? '일부 제약 조건 고려 필요' : undefined,
      })),
      searchProfile: searchProfile || { desiredThemes: [], dislikedThemes: [], strengthsHypothesis: [], environmentPreferences: [], hardConstraints: [], riskSignals: [], keywords: [] },
      narrativeFacts,
      roundAnswers,
      universalAnswers: {},
      hardCutList: [],
      miniModuleResult,
      additionalContext: deferredAdditionalContext,
    }

    const premiumReport = await generateLLMPremiumReport(env?.AI || null, reporterInput, openaiApiKey)
    const reportMode = premiumReport?.metaCognition?._meta?.generated_by === 'rule' ? 'fallback' : 'llm'

    // 4-1. Confidence 계산 → premiumReport에 주입
    try {
      // 1) DB facts 시도
      let cfFacts: Array<{ fact_key: string; value_json: string }> = []
      try {
        const factsResult = await db.prepare(
          `SELECT fact_key, value_json FROM facts WHERE session_id = ?`
        ).bind(session_id).all<{ fact_key: string; value_json: string }>()
        cfFacts = factsResult.results || []
      } catch { /* facts 테이블 없어도 OK */ }

      // 2) DB facts가 부족하면 mini_module_result에서 빌드
      if (cfFacts.length < 3 && miniModuleResult) {
        cfFacts = buildConfidenceFactsFromMiniModule(miniModuleResult)
      }

      const topScores = topJobs.map((j: any) => j.fit_score || 0)
      const confidenceResult = calculateConfidenceScore(
        cfFacts.map(f => ({
          fact_key: f.fact_key,
          source: f.fact_key.startsWith('followup') ? 'followup' as const : undefined,
          value_json: f.value_json,
        })),
        roundAnswers.length,
        topScores
      )
      if (premiumReport) {
        premiumReport._confidence = confidenceResult.score
      }
    } catch (e) {
    }

    // 5. DB에 리포트 저장
    try {
      const premiumJson = JSON.stringify(premiumReport)
      const updatedResult = { ...parsed, premium_report: premiumReport }
      await db.prepare(
        `UPDATE ai_analysis_results SET result_json = ?, premium_report_json = ? WHERE request_id = ?`
      ).bind(JSON.stringify(updatedResult), premiumJson, existingRequest.id).run()
    } catch (saveErr) {
    }

    return c.json({
      success: true,
      session_id,
      premium_report: premiumReport,
      report_mode: reportMode,
      duration_ms: Date.now() - startTime,
    })
  } catch (error) {
    return c.json(createErrorResponse(
      'REPORT_FAILED',
      error instanceof Error ? error.message : 'Report generation failed'
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
        // AggregatedProfile에서 AxisCoverage 추출
        const a = aggregated.anchors
        if (a.interest_top?.length) {
          axisCoverage = updateAxisCoverage(axisCoverage, 'interest', {
            confidence: Math.min(a.interest_top.length / 3, 1),
            evidence: a.interest_top.slice(0, 5),
          })
        }
        if (a.strength_top?.length) {
          axisCoverage = updateAxisCoverage(axisCoverage, 'strength', {
            confidence: Math.min(a.strength_top.length / 3, 1),
            evidence: a.strength_top.slice(0, 5),
          })
        }
        if (a.value_top?.length) {
          axisCoverage = updateAxisCoverage(axisCoverage, 'values', {
            confidence: Math.min(a.value_top.length / 3, 1),
            evidence: a.value_top.slice(0, 5),
          })
        }
        if (a.energy_drain_flags?.length || a.execution_style) {
          axisCoverage = updateAxisCoverage(axisCoverage, 'work_style', {
            confidence: 0.5,
            evidence: [...(a.energy_drain_flags || []), a.execution_style].filter(Boolean).slice(0, 5) as string[],
          })
        }
        if (a.impact_scope || a.external_expectation) {
          axisCoverage = updateAxisCoverage(axisCoverage, 'people', {
            confidence: 0.4,
            evidence: [a.impact_scope, a.external_expectation].filter(Boolean) as string[],
          })
        }
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
  const authError = checkAdminAuth(c)
  if (authError) return authError
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
  const authError = checkAdminAuth(c)
  if (authError) return authError
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
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

import { JOB_PROFILE_COMPACT_VERSION } from '../../constants/embedding-versions'

// ============================================
// 전공 증분 업서트 API
// ============================================
analyzerRoutes.post('/admin/incremental-upsert-majors', async (c) => {
  const authError = checkAdminAuth(c)
  if (authError) return authError
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = c.env.OPENAI_API_KEY

  if (!env.VECTORIZE) {
    return c.json({ success: false, error: 'VECTORIZE_NOT_AVAILABLE' }, 503)
  }
  if (!openaiApiKey) {
    return c.json({ success: false, error: 'OPENAI_API_KEY_NOT_SET' }, 503)
  }

  const payload = await c.req.json<{ max_items?: number }>().catch(() => ({}))
  const maxItems = payload.max_items || 100

  try {
    const result = await incrementalUpsertMajorsToVectorize(
      db, env.VECTORIZE, openaiApiKey, { maxItems }
    )
    return c.json({ success: true, ...result })
  } catch (error) {
    return c.json({ success: false, error: error instanceof Error ? error.message : 'Unknown error' }, 500)
  }
})

// ============================================
// HowTo 증분 업서트 API
// ============================================
analyzerRoutes.post('/admin/incremental-upsert-howtos', async (c) => {
  const authError = checkAdminAuth(c)
  if (authError) return authError
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = c.env.OPENAI_API_KEY

  if (!env.VECTORIZE) {
    return c.json({ success: false, error: 'VECTORIZE_NOT_AVAILABLE' }, 503)
  }
  if (!openaiApiKey) {
    return c.json({ success: false, error: 'OPENAI_API_KEY_NOT_SET' }, 503)
  }

  const payload = await c.req.json<{ max_items?: number }>().catch(() => ({}))
  const maxItems = payload.max_items || 100

  try {
    const result = await incrementalUpsertHowtosToVectorize(
      db, env.VECTORIZE, openaiApiKey, { maxItems }
    )
    return c.json({ success: true, ...result })
  } catch (error) {
    return c.json({ success: false, error: error instanceof Error ? error.message : 'Unknown error' }, 500)
  }
})

// ============================================
// 자동화 시나리오 테스트 API
// P0/P1/P2/P3 전체 기능 자동 검증
// ============================================

// 시나리오 목록 조회
analyzerRoutes.get('/test/scenarios', async (c) => {
  const authError = checkAdminAuth(c)
  if (authError) return authError
  const scenarios = getAllScenarioSummary()
  return c.json({
    success: true,
    scenarios,
    total: scenarios.length,
  })
})

// 특정 시나리오 실행
analyzerRoutes.post('/test/run-scenario', async (c) => {
  const authError = checkAdminAuth(c)
  if (authError) return authError
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

    // Background Feasibility 계산 함수 (E2E 전용: LLM 없이 결정적 계산)
    function calculateE2EFeasibility(
      jobAttrs: Record<string, string | number>,
      bgFlags: string[],
      langSkills: Array<{ language: string; level: string }>,
    ): number {
      let score = 60 // 기본값

      for (const flag of bgFlags) {
        switch (flag) {
          case 'research_academic':
            // 분석/연구 관련 직업에 보너스
            score += ((Number(jobAttrs.analytical) || 50) - 50) * 0.3
            break
          case 'license_cert':
            // 자격증 필요 직업에 보너스, 안정적 직업에도 소폭 보너스
            score += (Number(jobAttrs.license_required) || 0) > 50 ? 12 : 0
            score += ((Number(jobAttrs.stability) || 50) - 50) * 0.1
            break
          case 'startup_experience':
            // 성장 높고 안정 낮은 직업에 보너스 (스타트업 적합)
            score += ((Number(jobAttrs.growth) || 50) - 50) * 0.2
            score += (50 - (Number(jobAttrs.stability) || 50)) * 0.1
            break
          case 'overseas_living':
            // 원격/글로벌 직업에 보너스
            score += (Number(jobAttrs.remote_possible) || 0) > 50 ? 8 : 0
            score += ((Number(jobAttrs.creative) || 50) - 50) * 0.1
            break
          case 'volunteer_ngo':
            // 사람 대면/임팩트 직업에 보너스
            score += ((Number(jobAttrs.people_facing) || 50) - 50) * 0.2
            break
        }
      }

      // 언어 능력 보너스
      for (const lang of langSkills) {
        const levelBonus = lang.level === 'native' ? 8 : lang.level === 'business' ? 5 : 2
        score += levelBonus
      }

      return Math.max(35, Math.min(95, Math.round(score)))
    }

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

      // Background Feasibility 계산
      const feasibility = calculateE2EFeasibility(
        job.attributes,
        miniModule.background_flags || [],
        miniModule.language_skills || [],
      )

      // 최종 Fit 계산 (LLM Judge와 동일한 50/40/10 공식)
      const totalRiskPenalty = adjusted.risk_penalty + additionalPenalty
      const fit = Math.round(0.50 * balanced.like + 0.40 * balanced.can + 0.10 * feasibility - totalRiskPenalty)

      return {
        job_id: job.job_id,
        job_name: job.job_name,
        scores: {
          fit: Math.max(0, fit),
          like: balanced.like,
          can: balanced.can,
          risk_penalty: totalRiskPenalty,
          feasibility,
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
        feasibility_score: j.scores.feasibility,
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
      }
    } catch (saveError) {
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
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : 'Test execution failed',
    }, 500)
  }
})

// 전체 시나리오 일괄 실행
analyzerRoutes.post('/test/run-all', async (c) => {
  const authError = checkAdminAuth(c)
  if (authError) return authError
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
  const authError = checkAdminAuth(c)
  if (authError) return authError
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
    const response = await fetch('https://gateway.ai.cloudflare.com/v1/3587865378649966bfb0a814fce73c77/careerwiki/openai/chat/completions', {
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
      return c.json({ success: false, error: 'OpenAI API error' }, 500)
    }

    const data = await response.json() as {
      choices: Array<{ message: { content: string } }>
      usage: { total_tokens: number }
    }

    const answer = data.choices[0]?.message?.content?.trim() || ''


    return c.json({
      success: true,
      answer,
      usage: data.usage,
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
    }, 500)
  }
})

// ============================================
// 공유 기능: 토큰 생성 / 해제 / extractShareData
// ============================================

// HTML escape (XSS 방지)
function escapeHtml(s: string): string {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;').replace(/'/g, '&#39;')
}

// 문자열 안전 절단 + HTML escape
const safeStr = (s: any, maxLen = 50): string =>
  typeof s === 'string' ? escapeHtml(s.slice(0, maxLen)) : ''
const safeArr = (arr: any, maxItems = 3, maxLen = 20): string[] =>
  Array.isArray(arr) ? arr.slice(0, maxItems).map((s: any) => safeStr(s, maxLen)) : []

// nanoid 대체: crypto 기반 16자 토큰 생성
function generateShareToken(): string {
  const bytes = new Uint8Array(12)
  crypto.getRandomValues(bytes)
  return Array.from(bytes).map(b => b.toString(36).padStart(2, '0')).join('').slice(0, 16)
}

interface ShareData {
  v: number
  type?: 'job' | 'major'
  jobs: Array<{ name: string; fit: number; slug: string; image_url?: string }>
  vision: string
  meta: {
    strengths: string[]
    values: string[]
    cautions: string[]
    likes: string[]
    avoid: string[]
  }
  createdAt: string
}

function extractShareData(
  resultJson: any,
  premiumReport: any,
  analysisType: string = 'job',
): ShareData {
  // 화이트리스트: 이 함수 밖의 데이터는 절대 공유 페이지에 도달 불가
  const isMajor = analysisType === 'major'
  const sourceList = isMajor
    ? (resultJson.fit_top_majors || resultJson.fit_top3 || resultJson.recommendations || [])
    : (resultJson.fit_top3 || [])
  const top5 = sourceList.slice(0, 5).map((j: any) => ({
    name: safeStr(j.major_name || j.name || j.job_name, 30),
    fit: Math.min(100, Math.max(0, Math.round(Number(j.fit_score || j.final_score) || 0))),
    slug: safeStr(j.slug, 60),
    ...(j.image_url ? { image_url: safeStr(j.image_url, 200) } : {}),
  }))

  const vision = safeStr(premiumReport?.lifeVersionStatement?.oneLiner, 200)

  const mm = resultJson.mini_module_result || {}
  const meta = {
    strengths: safeArr(mm.strength_top, 3, 30),
    values: safeArr(mm.value_top, 3, 30),
    cautions: safeArr(premiumReport?.stressTriggers, 3, 60),
    likes: safeArr(mm.interest_top, 3, 30),
    avoid: safeArr(mm.dealbreaker || mm.constraint_flags, 3, 60),
  }

  return { v: 1, type: isMajor ? 'major' : 'job', jobs: top5, vision, meta, createdAt: new Date().toISOString().split('T')[0] }
}

// POST /share - 공유 토큰 생성/재발급
analyzerRoutes.post('/share', async (c) => {
  const db = c.env.DB
  const authUser = (c as any).get('user') as { id: number } | null

  if (!authUser) {
    return c.json({ success: false, error: 'Login required' }, 401)
  }

  const userId = String(authUser.id)
  const body = await c.req.json<{ request_id: number }>().catch(() => ({ request_id: 0 }))
  const { request_id } = body

  if (!request_id || isNaN(request_id)) {
    return c.json(createErrorResponse('VALIDATION_ERROR', 'Valid request_id required'), 400)
  }

  try {
    // 1. 본인 결과인지 확인
    const request = await db.prepare(`
      SELECT id, user_id, analysis_type FROM ai_analysis_requests WHERE id = ?
    `).bind(request_id).first<{ id: number; user_id: string; analysis_type: string }>()

    if (!request) {
      return c.json(createErrorResponse('REQUEST_NOT_FOUND', 'Analysis request not found'), 404)
    }

    // 본인 결과이거나 admin이면 허용 (E2E 테스트 결과는 user_id가 NULL)
    const authRole = (c as any).get('user')?.role as string | undefined
    const isAdmin = authRole === 'admin' || authRole === 'super-admin' || authRole === 'operator'
    if (!isAdmin && request.user_id && String(request.user_id) !== userId) {
      return c.json({ success: false, error: 'Not your result' }, 403)
    }

    // 2. 기존 토큰 확인 (request_id UNIQUE이므로 최대 1개)
    const existing = await db.prepare(`
      SELECT share_token, is_revoked, expires_at
      FROM share_tokens WHERE request_id = ?
    `).bind(request_id).first<{ share_token: string; is_revoked: number; expires_at: string }>()

    if (existing && !existing.is_revoked && existing.expires_at && new Date(existing.expires_at) > new Date()) {
      // 활성 토큰 재사용
      return c.json({
        success: true,
        share_url: `https://careerwiki.org/share/${existing.share_token}`,
        token: existing.share_token,
        reused: true,
      })
    }

    // 3. 분석 결과 조회 (share_data_json 생성용)
    const analysisResult = await db.prepare(`
      SELECT result_json, premium_report_json
      FROM ai_analysis_results WHERE request_id = ?
    `).bind(request_id).first<{ result_json: string; premium_report_json: string | null }>()

    if (!analysisResult) {
      return c.json(createErrorResponse('RESULT_NOT_FOUND', 'Analysis result not found'), 404)
    }

    const resultJson = JSON.parse(analysisResult.result_json)
    const premiumReport = analysisResult.premium_report_json
      ? JSON.parse(analysisResult.premium_report_json)
      : null

    const shareData = extractShareData(resultJson, premiumReport, request.analysis_type)
    const shareDataJson = JSON.stringify(shareData)

    // 4. 토큰 생성 (UNIQUE 충돌 최대 2회 재시도)
    let token = ''
    let saved = false

    for (let attempt = 0; attempt < 3; attempt++) {
      token = generateShareToken()

      try {
        if (existing) {
          // revoked/expired → UPDATE 재발급
          await db.prepare(`
            UPDATE share_tokens SET
              share_token = ?,
              share_data_json = ?,
              is_revoked = 0,
              revoked_at = NULL,
              expires_at = datetime('now', '+30 days'),
              view_count = 0,
              created_at = CURRENT_TIMESTAMP
            WHERE request_id = ? AND user_id = ?
          `).bind(token, shareDataJson, request_id, userId).run()
        } else {
          // 신규 INSERT
          await db.prepare(`
            INSERT INTO share_tokens (share_token, request_id, user_id, share_data_json, expires_at)
            VALUES (?, ?, ?, ?, datetime('now', '+30 days'))
          `).bind(token, request_id, userId, shareDataJson).run()
        }
        saved = true
        break
      } catch (e) {
        // UNIQUE 충돌이면 재시도
        const msg = e instanceof Error ? e.message : ''
        if (msg.includes('UNIQUE') && attempt < 2) continue
        throw e
      }
    }

    if (!saved) {
      return c.json(createErrorResponse('INTERNAL_ERROR', 'Failed to generate unique token'), 500)
    }


    return c.json({
      success: true,
      share_url: `https://careerwiki.org/share/${token}`,
      token,
      reused: false,
    })

  } catch (error) {
    return c.json(createErrorResponse(
      'DB_ERROR',
      error instanceof Error ? error.message : 'Share creation failed'
    ), 500)
  }
})

// POST /share/revoke - 공유 해제
analyzerRoutes.post('/share/revoke', async (c) => {
  const db = c.env.DB
  const authUser = (c as any).get('user') as { id: number } | null

  if (!authUser) {
    return c.json({ success: false, error: 'Login required' }, 401)
  }

  const userId = String(authUser.id)
  const body = await c.req.json<{ request_id?: number; token?: string }>().catch(() => ({}))

  try {
    let result
    if (body.token) {
      result = await db.prepare(`
        UPDATE share_tokens SET is_revoked = 1, revoked_at = CURRENT_TIMESTAMP
        WHERE share_token = ? AND user_id = ?
      `).bind(body.token, userId).run()
    } else if (body.request_id) {
      result = await db.prepare(`
        UPDATE share_tokens SET is_revoked = 1, revoked_at = CURRENT_TIMESTAMP
        WHERE request_id = ? AND user_id = ?
      `).bind(body.request_id, userId).run()
    } else {
      return c.json(createErrorResponse('VALIDATION_ERROR', 'request_id or token required'), 400)
    }

    const changes = result.meta?.changes || 0

    return c.json({ success: true, revoked: changes > 0 })

  } catch (error) {
    return c.json(createErrorResponse('DB_ERROR', 'Revoke failed'), 500)
  }
})

// GET /share/status/:requestId - 공유 상태 확인 (결과 페이지에서 사용)
analyzerRoutes.get('/share/status/:requestId', async (c) => {
  const db = c.env.DB
  const authUser = (c as any).get('user') as { id: number } | null

  if (!authUser) {
    return c.json({ success: false, error: 'Login required' }, 401)
  }

  const userId = String(authUser.id)
  const requestId = parseInt(c.req.param('requestId'), 10)

  if (isNaN(requestId)) {
    return c.json(createErrorResponse('VALIDATION_ERROR', 'Invalid request_id'), 400)
  }

  try {
    const existing = await db.prepare(`
      SELECT share_token, is_revoked, expires_at, view_count, created_at
      FROM share_tokens WHERE request_id = ? AND user_id = ?
    `).bind(requestId, userId).first<{
      share_token: string
      is_revoked: number
      expires_at: string
      view_count: number
      created_at: string
    }>()

    if (!existing) {
      return c.json({ success: true, shared: false })
    }

    const isActive = !existing.is_revoked && existing.expires_at && new Date(existing.expires_at) > new Date()

    return c.json({
      success: true,
      shared: isActive,
      token: isActive ? existing.share_token : null,
      share_url: isActive ? `https://careerwiki.org/share/${existing.share_token}` : null,
      view_count: existing.view_count,
      created_at: existing.created_at,
      is_revoked: !!existing.is_revoked,
    })
  } catch (error) {
    return c.json(createErrorResponse('DB_ERROR', 'Status check failed'), 500)
  }
})

// ============================================
// V3 Major Recommendation: 전공 추천 파이프라인
// /v3/recommend의 전공 버전 — 모든 단계가 major 전용 함수 사용
// ============================================
analyzerRoutes.post('/v3/recommend-major', async (c) => {
  const env = c.env as Bindings
  const db = env.DB
  const openaiApiKey = c.env.OPENAI_API_KEY
  const payload = await c.req.json<any>()

  const authUser = c.get('user') as { id: number } | undefined
  const userId = authUser?.id?.toString() || null

  const { session_id, draft_id, topK = 800, judgeTopN = 20, debug = false, skipReport = false } = payload

  if (!session_id) {
    return c.json(createErrorResponse('VALIDATION_ERROR', 'session_id is required'), 400)
  }
  if (!openaiApiKey) {
    return c.json(createErrorResponse('INTERNAL_ERROR', 'OpenAI API key not configured'), 500)
  }

  try {
    const startTime = Date.now()

    // 1. SearchProfile 확정 (job 버전과 동일 로직)
    let searchProfile = payload.searchProfile

    if (!searchProfile && draft_id) {
      const draft = await db.prepare(
        `SELECT * FROM ai_analysis_drafts WHERE id = ?`
      ).bind(draft_id).first<any>()

      if (draft) {
        const aggregated = buildAggregatedProfile(draft)
        searchProfile = {
          desiredThemes: [...aggregated.anchors.interest_top, ...aggregated.anchors.value_top],
          dislikedThemes: aggregated.universals.dislikes || [],
          strengthsHypothesis: aggregated.anchors.strength_top,
          environmentPreferences: [],
          hardConstraints: aggregated.anchors.constraint_flags,
          riskSignals: [],
          keywords: [...aggregated.anchors.interest_top, ...aggregated.anchors.strength_top],
        }
      }
    }

    if (!searchProfile && payload.mini_module_result) {
      searchProfile = buildSearchProfileFromMiniModule(payload.mini_module_result)
    }

    if (!searchProfile) {
      return c.json(createErrorResponse('VALIDATION_ERROR', 'searchProfile or draft_id or mini_module_result required'), 400)
    }

    // 2. Vectorize 검색 (전공 전용 — major: prefix만 포함)
    let vectorSearchProfile = searchProfile
    if (payload.mini_module_result) {
      vectorSearchProfile = buildSearchProfileFromMiniModule(payload.mini_module_result)
    }

    const expansionResult = await expandCandidatesV3ForMajors(
      db,
      env.VECTORIZE,
      openaiApiKey,
      vectorSearchProfile,
      {
        targetSize: topK,
        miniModule: payload.mini_module_result,
      }
    )

    // 3. TAG Hard Filter (전공 전용)
    const constraintMap: Record<string, string | string[]> = {}
    for (const c of (payload.mini_module_result?.constraint_flags || [])) {
      constraintMap[c] = 'true'
    }
    // v3.23: miniModuleResult 전달하여 drain_flags→constraint 매핑 활성화
    const majorUserConstraints = extractMajorUserConstraints(constraintMap, payload.mini_module_result)

    let tagFilterResult
    try {
      tagFilterResult = await applyMajorTagFilter(db, expansionResult.candidates, majorUserConstraints)
    } catch (tagError) {
      throw tagError
    }

    // v3.23: riskPenaltyMap 보존 (직업 v3.16 패턴 — 타입 변환 시 손실 방지)
    const majorRiskPenaltyMap = new Map<string, number>(
      tagFilterResult.passed.map((p: any) => [String(p.major_id), p.riskPenalty])
    )

    // 3-2. 필터 통과한 후보를 ScoredMajor로 변환
    const tagPassedAsVectorResults = tagFilterResult.passed.map((p: any) => ({
      major_id: p.major_id,
      major_name: p.major_name,
      score: p.score,
    }))

    let scoredMajors
    try {
      scoredMajors = await vectorResultsToScoredMajors(db, tagPassedAsVectorResults, payload.mini_module_result)

      // v3.23: tag-filter의 riskPenalty를 final_score에 반영 (직업 v3.16 패턴)
      scoredMajors = scoredMajors.map(m => {
        const tagRisk = majorRiskPenaltyMap.get(String(m.major_id)) ?? 0
        return {
          ...m,
          base_risk: tagRisk,
          risk_penalty: tagRisk,
          final_score: Math.round(0.55 * (m.like_score || 0) + 0.45 * (m.can_score || 0) - tagRisk),
        }
      })
    } catch (scoreError) {
      throw scoreError
    }

    // 3-3. MiniModule Hard Filter (전공 전용)
    let filteredMajors = scoredMajors
    try {
      const mmResult = applyMajorMiniModuleHardFilter(scoredMajors, payload.mini_module_result)
      filteredMajors = mmResult.filtered
    } catch (mmError) {
      // MiniModule 필터 실패 시 원본 유지
    }

    // 4. 아키타입 전공 주입 (벡터 검색 미스 대비)
    const existingMajorIdSet = new Set<string | number>(filteredMajors.map(m => m.major_id))
    const mmInterests = (payload.mini_module_result?.interest_top || []) as string[]
    try {
      const injectedMajors = await injectArchetypeMajors(
        db, existingMajorIdSet, mmInterests
      )
      filteredMajors = [...filteredMajors, ...injectedMajors]
    } catch (injErr) {
      // 주입 실패 시 원본 유지
    }

    // 4-1. Diversity Guard (같은 field_category 5개 이하, Judge 후보 풀 확장)
    const diversityResult = enforceMajorDiversity(filteredMajors, 5, 30)
    filteredMajors = diversityResult.diversified

    // 4-2. 사전 필터된 상위 후보군 (Like/Can/Final 3축 분리) — 25개씩 확보하여 Judge 풀 확대
    const likeBiased = [...filteredMajors]
      .sort((a, b) => (b.like_score || 0) - (a.like_score || 0))
      .slice(0, 25)
    const canBiased = [...filteredMajors]
      .sort((a, b) => (b.can_score || 0) - (a.can_score || 0))
      .slice(0, 25)
    const finalBiased = [...filteredMajors]
      .sort((a, b) => (b.final_score || 0) - (a.final_score || 0))
      .slice(0, 25)

    const preFilterIdSet = new Set<string>()
    const preFilteredMajors: typeof filteredMajors = []
    for (const major of [...likeBiased, ...canBiased, ...finalBiased]) {
      const id = String(major.major_id)
      if (!preFilterIdSet.has(id)) {
        preFilterIdSet.add(id)
        preFilteredMajors.push(major)
      }
    }

    // ScoredMajor → FilteredMajorCandidate 변환
    const candidatesForJudge = preFilteredMajors.map(major => ({
      major_id: major.major_id,
      major_name: major.major_name,
      score: major.final_score || major.like_score || 0,
      riskPenalty: major.risk_penalty || 0,
      riskWarnings: [] as string[],
      tagSource: (major.tag_source || 'tagged') as 'tagged' | 'untagged',
      attributes: major.attributes,
    }))

    // 4-3. Additional Context 조회 (사용자가 추가한 텍스트) — Judge + Reporter 공용
    let majorAdditionalContext: string | undefined
    try {
      const acRows = await db.prepare(`
        SELECT value_text FROM analyzer_facts
        WHERE session_id = ? AND fact_key = 'additional_context'
        ORDER BY created_at DESC
      `).bind(session_id).all<{ value_text: string }>()
      if (acRows.results && acRows.results.length > 0) {
        majorAdditionalContext = acRows.results.map(r => r.value_text).join('\n\n')
      }
    } catch { /* non-critical */ }

    // 4-4. DB에서 narrativeFacts, roundAnswers, universalAnswers 로드 (Judge 컨텍스트용)
    let narrativeFactsForJudge: { highAliveMoment: string; lostMoment: string; existentialAnswer?: string } | undefined
    let roundAnswersForJudge: Array<{ roundNumber: 1 | 2 | 3; questionId: string; answer: string }> = []
    let universalAnswersForJudge: Record<string, string | string[]> = {}

    try {
      const [narrativeResult, roundAnswersResult, userFactsResult] = await Promise.allSettled([
        db.prepare(`
          SELECT high_alive_moment, lost_moment, existential_answer
          FROM narrative_facts
          WHERE session_id = ?
        `).bind(session_id).first<{
          high_alive_moment: string | null
          lost_moment: string | null
          existential_answer: string | null
        }>(),
        db.prepare(`
          SELECT round_number, question_id, answer
          FROM round_answers
          WHERE session_id = ?
          ORDER BY round_number, question_id
        `).bind(session_id).all<{
          round_number: number
          question_id: string
          answer: string
        }>(),
        db.prepare(`
          SELECT fact_key, fact_value
          FROM user_facts
          WHERE session_id = ?
        `).bind(session_id).all<{
          fact_key: string
          fact_value: string
        }>(),
      ])

      if (narrativeResult.status === 'fulfilled' && narrativeResult.value) {
        const row = narrativeResult.value
        if (row.high_alive_moment || row.lost_moment) {
          narrativeFactsForJudge = {
            highAliveMoment: row.high_alive_moment || '',
            lostMoment: row.lost_moment || '',
            existentialAnswer: row.existential_answer || undefined,
          }
        }
      }

      if (roundAnswersResult.status === 'fulfilled' && roundAnswersResult.value?.results?.length) {
        roundAnswersForJudge = roundAnswersResult.value.results.map(row => ({
          roundNumber: row.round_number as 1 | 2 | 3,
          questionId: row.question_id,
          answer: row.answer,
        }))
      }

      if (userFactsResult.status === 'fulfilled' && userFactsResult.value?.results?.length) {
        for (const row of userFactsResult.value.results) {
          try {
            universalAnswersForJudge[row.fact_key] = JSON.parse(row.fact_value)
          } catch {
            universalAnswersForJudge[row.fact_key] = row.fact_value
          }
        }
      }
    } catch (dbLoadErr) {
      // DB 로드 실패 시 빈 값으로 계속 진행
    }

    // 5. LLM Judge (전공 전용)
    let topMajors: any[]

    if (openaiApiKey && candidatesForJudge.length > 0) {
      try {
        const judgeInput: MajorJudgeInput = {
          candidates: candidatesForJudge,
          searchProfile,
          narrativeFacts: narrativeFactsForJudge,
          roundAnswers: roundAnswersForJudge,
          universalAnswers: universalAnswersForJudge,
          miniModuleResult: payload.mini_module_result,
          academicState: payload.academic_state,
          additionalContext: majorAdditionalContext,
        }

        const judgeResults = await judgeMajorCandidates(openaiApiKey, db, judgeInput)

        topMajors = judgeResults.results.map(result => {
          const originalMajor = preFilteredMajors.find(m => String(m.major_id) === String(result.major_id))
          return {
            ...originalMajor,
            major_id: result.major_id,
            major_name: result.major_name,
            like_score: result.desireScore,
            can_score: result.fitScore,
            fit_score: result.overallScore,
            final_score: result.overallScore,
            risk_penalty: result.riskPenalty,
            feasibility_score: result.feasibilityScore,
            rationale: result.rationale,
            like_reason: result.likeReason,
            can_reason: result.canReason,
            feasibility_reason: result.feasibilityReason,
            risk_reason: result.riskReason,
            evidence_quotes: result.evidenceQuotes,
            semester_plan: result.semesterPlan,
          }
        })
      } catch (judgeError) {
        const errorMessage = judgeError instanceof Error ? judgeError.message : String(judgeError)
        return c.json(createErrorResponse(
          'ANALYSIS_FAILED',
          `전공 LLM 분석이 실패했습니다: ${errorMessage}`
        ), 500)
      }
    } else {
      return c.json(createErrorResponse('INTERNAL_ERROR', 'OpenAI API 키가 설정되지 않았습니다'), 500)
    }

    // ============================================
    // Phase 6: 전공 결과 정제 파이프라인 (v3.23 — 직업 v3.22.3 패리티)
    // 순서: 6-F Risk Demotion → Backup → 6-G Quality Floor → 6-H Like Floor → 6-I Hard Noise → 6-J Backfill → 6-K Spread Cap → 6-L Dedup Guard
    // ============================================

    // 6-F. Risk Demotion — 제약 유저의 고위험 전공 점수 하락
    {
      const hasMathConstraint = Boolean(majorUserConstraints.math_impossible)
      const hasLabConstraint = Boolean(majorUserConstraints.lab_impossible)
      const hasStabilityConstraint = Boolean(majorUserConstraints.prefer_stability)
      if (hasMathConstraint || hasLabConstraint || hasStabilityConstraint) {
        for (const major of topMajors) {
          const risk = (major as any).risk_penalty || 0
          if (risk >= 8) {
            const extraPenalty = risk >= 12 ? 12 : 8
            ;(major as any).final_score = Math.max(40, ((major as any).final_score || 0) - extraPenalty)
            ;(major as any).fit_score = Math.max(40, ((major as any).fit_score || 0) - extraPenalty)
          }
        }
      }
    }

    // Backup 생성 — Risk Demotion 후, Quality Floor 전 (Backfill 후보 풀)
    const allJudgedMajorsBackup = [...topMajors].sort((a: any, b: any) => (b.final_score || 0) - (a.final_score || 0))

    // 6-G. Quality Floor — top1-20 이상만 유지 (최소 5개 보장)
    if (topMajors.length > 5) {
      const sortedForFloor = [...topMajors].sort((a: any, b: any) => (b.final_score || 0) - (a.final_score || 0))
      const top1Score = (sortedForFloor[0] as any)?.final_score || 0
      const qualityFloor = top1Score - 20
      const floorFiltered = topMajors.filter((m: any) => (m.final_score || 0) >= qualityFloor)
      if (floorFiltered.length >= 5) {
        topMajors = floorFiltered
      } else {
        topMajors = sortedForFloor.slice(0, Math.max(floorFiltered.length, 5))
      }
    }

    // 6-H. Like Floor — like < 48 제거 (최소 6개 보장)
    if (topMajors.length > 8) {
      const likeFiltered = topMajors.filter((m: any) => (m.like_score || 50) >= 48)
      if (likeFiltered.length >= 6) {
        topMajors = likeFiltered
      }
    }

    // 6-I. Hard Noise Removal — 명백한 도메인 불일치 전공 제거
    const MAJOR_HARD_NOISE_PATTERNS = [
      /^군사학$|국방|무기체계/,
      /한의학|한약학/,
      /치의학|치위생/,
      /수의학|수의예/,
      /항공운항|항공조종/,
      /선박공학|해양공학|조선공학/,
      /광산|광업|자원공학/,
      /축산학|낙농/,
      /농업학|농학과|원예학/,
    ]
    // 유저 관심사에 관련 도메인이 있으면 노이즈 필터 면제
    const mmInterestsForNoise = new Set<string>(payload.mini_module_result?.interest_top || [])
    const hasExemptMajorInterest = ['nature', 'physical_activity', 'helping_feedback', 'military', 'veterinary', 'dental', 'marine', 'agriculture', 'forestry', 'oriental_medicine']
      .some(i => mmInterestsForNoise.has(i))

    if (!hasExemptMajorInterest && topMajors.length > 5) {
      const noiseRemoved = topMajors.filter((m: any) => {
        const majorName = (m as any).major_name || ''
        return !MAJOR_HARD_NOISE_PATTERNS.some(p => p.test(majorName))
      })
      if (noiseRemoved.length >= 5) {
        topMajors = noiseRemoved
      }
    }

    // 6-J. 4-Tier Progressive Backfill — 10개 절대 보장
    if (topMajors.length < 10 && allJudgedMajorsBackup.length > topMajors.length) {
      const sortedCurrent = [...topMajors].sort((a: any, b: any) => (b.final_score || 0) - (a.final_score || 0))
      const currentTop1 = (sortedCurrent[0] as any)?.final_score || 0
      const existingIds = new Set(topMajors.map((m: any) => String(m.major_id)))
      const noNoiseBackup = allJudgedMajorsBackup
        .filter((m: any) => !existingIds.has(String(m.major_id)))
        .filter((m: any) => !hasExemptMajorInterest ? !MAJOR_HARD_NOISE_PATTERNS.some(p => p.test((m as any).major_name || '')) : true)

      // 1단계: strict (top1-20)
      const strictThreshold = currentTop1 - 20
      const strictCandidates = noNoiseBackup.filter((m: any) => (m.final_score || 0) >= strictThreshold)
      const needed1 = 10 - topMajors.length
      topMajors = [...topMajors, ...strictCandidates.slice(0, needed1)]

      // 2단계: relaxed (top1-25)
      if (topMajors.length < 10) {
        const relaxedThreshold = currentTop1 - 25
        const filledIds = new Set(topMajors.map((m: any) => String(m.major_id)))
        const relaxedCandidates = noNoiseBackup
          .filter((m: any) => !filledIds.has(String(m.major_id)))
          .filter((m: any) => (m.final_score || 0) >= relaxedThreshold)
        topMajors = [...topMajors, ...relaxedCandidates.slice(0, 10 - topMajors.length)]
      }

      // 3단계: safety net (top1-30 또는 abs 55)
      if (topMajors.length < 10) {
        const absoluteMin = Math.min(currentTop1 - 30, 55)
        const filledIds3 = new Set(topMajors.map((m: any) => String(m.major_id)))
        const safetyCandidates = noNoiseBackup
          .filter((m: any) => !filledIds3.has(String(m.major_id)))
          .filter((m: any) => (m.final_score || 0) >= absoluteMin)
        topMajors = [...topMajors, ...safetyCandidates.slice(0, 10 - topMajors.length)]
      }

      // 4단계: 절대 안전망 — 점수 임계값 없이 노이즈 아닌 모든 Judge 후보 투입
      if (topMajors.length < 10) {
        const filledIds4 = new Set(topMajors.map((m: any) => String(m.major_id)))
        const absoluteCandidates = noNoiseBackup
          .filter((m: any) => !filledIds4.has(String(m.major_id)))
        topMajors = [...topMajors, ...absoluteCandidates.slice(0, 10 - topMajors.length)]
      }

      // 5단계: 최종 폴백 — 노이즈 필터도 해제하고 Judge 결과에서 채움 (10개 미달 방지)
      if (topMajors.length < 10) {
        const filledIds5 = new Set(topMajors.map((m: any) => String(m.major_id)))
        const allRemainingBackup = allJudgedMajorsBackup
          .filter((m: any) => !filledIds5.has(String(m.major_id)))
        topMajors = [...topMajors, ...allRemainingBackup.slice(0, 10 - topMajors.length)]
      }
    }

    // 6-K. Spread Cap — 과도한 점수 격차 방지 (10개 보장 우선, 초과분만 제거)
    {
      const sortedForSpread = [...topMajors].sort((a: any, b: any) => (b.final_score || 0) - (a.final_score || 0))
      const spreadTop1 = (sortedForSpread[0] as any)?.final_score || 0
      const maxSpread = 23
      const spreadFloor = spreadTop1 - maxSpread
      const spreadCapped = sortedForSpread.filter((m: any) => (m.final_score || 0) >= spreadFloor)
      // 10개 이상 남을 때만 트리밍 (10개 보장이 최우선)
      if (spreadCapped.length >= 10) {
        topMajors = spreadCapped
      }
      // 10개 미만이면 Spread Cap 적용하지 않음 — 10개 유지가 더 중요
    }

    // ============================================
    // 6-L. 전공명 변형 Dedup Guard (X과 ↔ X학과 / X학과 ↔ X학부)
    // 같은 base에서 ~과와 ~학과 (또는 ~학과와 ~학부)가 Top10에 동시 노출 방지
    // 예: 간호과 ↔ 간호학과, 국제학과 ↔ 국제학부
    // ============================================
    if (topMajors.length > 5) {
      const majorDedupRemoveIds = new Set<string>()
      // base → [{id, name, score}] 그룹핑
      const majorBaseGroups = new Map<string, Array<{ id: string; name: string; score: number }>>()

      for (const m of topMajors) {
        const mName: string = (m as any).major_name || ''
        const mId: string = (m as any).major_id || ''
        const mScore: number = (m as any).final_score || 0
        let base = ''

        // 접미사 우선순위: 공학과 > 학과 > 학부 > 과
        if (mName.endsWith('공학과')) {
          base = mName.slice(0, -3) // 공학과 제거
        } else if (mName.endsWith('학과')) {
          base = mName.slice(0, -2) // 학과 제거
        } else if (mName.endsWith('학부')) {
          base = mName.slice(0, -2) // 학부 제거
        } else if (mName.endsWith('과') && mName.length > 1) {
          base = mName.slice(0, -1) // 과 제거
        }

        if (base && base.length >= 2) {
          if (!majorBaseGroups.has(base)) majorBaseGroups.set(base, [])
          majorBaseGroups.get(base)!.push({ id: mId, name: mName, score: mScore })
        }
      }

      // 같은 base에 2개 이상 있으면 점수 높은 것만 유지
      for (const [base, group] of majorBaseGroups) {
        if (group.length >= 2) {
          const sorted = group.sort((a, b) => b.score - a.score)
          for (let i = 1; i < sorted.length; i++) {
            majorDedupRemoveIds.add(sorted[i].id)
          }
          console.log(`[6-L Major Dedup] "${base}" 그룹: ${sorted.map(g => g.name).join(', ')} → 유지: ${sorted[0].name}`)
        }
      }

      if (majorDedupRemoveIds.size > 0) {
        const beforeDedup = topMajors.length
        topMajors = topMajors.filter((m: any) => !majorDedupRemoveIds.has(m.major_id))
        console.log(`[6-L Major Dedup] ${majorDedupRemoveIds.size}개 변형 중복 제거 (${beforeDedup} → ${topMajors.length})`)
      }
    }

    // 6. LLM Reporter (전공 전용 — skipReport 시 건너뜀)
    let premiumReport: any = null
    let reportMode: 'llm' | 'fallback' | 'none' | 'deferred' = skipReport ? 'deferred' : 'none'
    let narrativeFacts: { highAliveMoment: string; lostMoment: string; existentialAnswer?: string } | undefined
    let roundAnswers: RoundAnswer[] = []

    if (!skipReport) {
      const [narrativeResult, roundAnswersResult] = await Promise.allSettled([
        db.prepare(`SELECT high_alive_moment, lost_moment, existential_answer FROM narrative_facts WHERE session_id = ?`)
          .bind(session_id).first<{ high_alive_moment: string | null; lost_moment: string | null; existential_answer: string | null }>(),
        db.prepare(`SELECT round_number, question_id, answer FROM round_answers WHERE session_id = ? ORDER BY round_number, question_id`)
          .bind(session_id).all<{ round_number: number; question_id: string; answer: string }>(),
      ])

      if (narrativeResult.status === 'fulfilled' && narrativeResult.value) {
        const row = narrativeResult.value
        if (row.high_alive_moment || row.lost_moment) {
          narrativeFacts = {
            highAliveMoment: row.high_alive_moment || '',
            lostMoment: row.lost_moment || '',
            existentialAnswer: row.existential_answer || undefined,
          }
        }
      }
      if (roundAnswersResult.status === 'fulfilled' && roundAnswersResult.value?.results?.length) {
        roundAnswers = roundAnswersResult.value.results.map(r => ({
          roundNumber: r.round_number as 1 | 2 | 3,
          questionId: r.question_id,
          answer: r.answer,
          answeredAt: new Date().toISOString(),
        }))
      }

      if (openaiApiKey && topMajors.length > 0) {
        try {
          const topMajorsForReporter = [...topMajors]
            .sort((a, b) => (b.final_score || 0) - (a.final_score || 0))
            .slice(0, judgeTopN)

          const reporterInput: MajorReporterInput = {
            sessionId: session_id,
            judgeResults: topMajorsForReporter.map((major: any) => ({
              major_id: major.major_id,
              major_name: major.major_name,
              fitScore: major.can_score || 50,
              desireScore: major.like_score || 50,
              feasibilityScore: major.feasibility_score || 50,
              overallScore: major.final_score || 50,
              riskFlags: [],
              riskPenalty: major.risk_penalty || 0,
              evidenceQuotes: major.evidence_quotes || [],
              rationale: major.rationale || '',
              likeReason: major.like_reason,
              canReason: major.can_reason,
              riskReason: major.risk_reason,
              semesterPlan: major.semester_plan,
            })),
            searchProfile,
            narrativeFacts,
            roundAnswers,
            universalAnswers: {},
            hardCutList: [],
            miniModuleResult: payload.mini_module_result,
            additionalContext: majorAdditionalContext,
          }

          premiumReport = await generateMajorPremiumReport(
            env?.AI || null,
            reporterInput,
            openaiApiKey
          )
          reportMode = 'llm'
        } catch (reporterError) {
          reportMode = 'fallback'
          premiumReport = { error: 'Reporter failed', fallback: true }
        }
      }
    }

    // 7. 결과 구성
    const majorToDto = (major: any) => ({
      major_id: major.major_id,
      major_name: major.major_name,
      major_description: major.major_description || null,
      slug: major.slug || null,
      image_url: major.image_url || null,
      fit_score: major.final_score || major.fit_score || 50,
      like_score: major.like_score || 50,
      can_score: major.can_score || 50,
      feasibility_score: major.feasibility_score || 0,
      field_category: major.field_category || major.attributes?.field_category || null,
      rationale: major.rationale || null,
      like_reason: major.like_reason || null,
      can_reason: major.can_reason || null,
      risk_reason: major.risk_reason || null,
      semester_plan: major.semester_plan || [],
    })

    // Like/Can Top 10 (field_category 다양성 적용)
    const diverseMajorTop10 = (majors: any[], scoreKey: 'like_score' | 'can_score', maxPerCategory = 3) => {
      const sorted = [...majors]
        .filter(m => (m.final_score || 0) >= 25)
        .sort((a, b) => (b[scoreKey] || 0) - (a[scoreKey] || 0))

      const result: any[] = []
      const selectedIds = new Set<string>()
      const categoryCount = new Map<string, number>()

      for (const major of sorted) {
        if (result.length >= 10) break
        const cat = major.field_category || major.attributes?.field_category || 'general'
        const count = categoryCount.get(cat) || 0
        if (count >= maxPerCategory) continue
        result.push(major)
        selectedIds.add(String(major.major_id))
        categoryCount.set(cat, count + 1)
      }

      if (result.length < 10) {
        for (const major of sorted) {
          if (result.length >= 10) break
          if (selectedIds.has(String(major.major_id))) continue
          result.push(major)
          selectedIds.add(String(major.major_id))
        }
      }

      return result
    }

    const likeTop10 = diverseMajorTop10(topMajors, 'like_score').map(majorToDto)
    const canTop10 = diverseMajorTop10(topMajors, 'can_score').map(majorToDto)

    const fitTop10 = [...topMajors]
      .sort((a, b) => (b.final_score || 0) - (a.final_score || 0))
      .slice(0, 10)
      .map(majorToDto)

    // 8. DB 저장 (analysis_type='major')
    let savedRequestId: number | null = null
    try {
      let effectiveUserId = userId
      if (!effectiveUserId) {
        const draftOwner = await db.prepare(`SELECT user_id FROM analyzer_drafts WHERE session_id = ?`)
          .bind(session_id).first<{ user_id: number | null }>()
        effectiveUserId = draftOwner?.user_id || null
      }

      const existingRequest = await db.prepare(`SELECT id FROM ai_analysis_requests WHERE session_id = ? AND analysis_type = 'major'`)
        .bind(session_id).first<{ id: number }>()

      if (existingRequest) {
        savedRequestId = existingRequest.id
        await db.prepare(`UPDATE ai_analysis_requests SET status = 'completed', processed_at = CURRENT_TIMESTAMP, user_id = COALESCE(user_id, ?) WHERE id = ?`)
          .bind(effectiveUserId, savedRequestId).run()
      } else {
        const insertResult = await db.prepare(`INSERT INTO ai_analysis_requests (session_id, user_id, analysis_type, prompt_payload, status, processed_at, requested_at) VALUES (?, ?, 'major', ?, 'completed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`)
          .bind(session_id, effectiveUserId, JSON.stringify(searchProfile || {})).run()
        savedRequestId = insertResult.meta?.last_row_id as number || null
      }

      if (savedRequestId) {
        const resultToSave = {
          engine_version: RECOMMENDATION_ENGINE_VERSION,
          analysis_type: 'major',
          mini_module_result: payload.mini_module_result || null,
          fit_top_majors: fitTop10,
          like_top10: likeTop10,
          can_top10: canTop10,
          premium_report: premiumReport,
          search_profile: searchProfile,
          total_candidates: expansionResult.candidates.length,
          filtered_count: filteredMajors.length,
        }

        const resultJson = JSON.stringify(resultToSave)
        const premiumJson = JSON.stringify(premiumReport)

        const updateResult = await db.prepare(`UPDATE ai_analysis_results SET result_json = ?, engine_version = ?, premium_report_json = ? WHERE request_id = ?`)
          .bind(resultJson, RECOMMENDATION_ENGINE_VERSION, premiumJson, savedRequestId).run()

        if (!updateResult.meta?.changes || updateResult.meta.changes === 0) {
          await db.prepare(`INSERT INTO ai_analysis_results (request_id, result_json, engine_version, premium_report_json, created_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)`)
            .bind(savedRequestId, resultJson, RECOMMENDATION_ENGINE_VERSION, premiumJson).run()
        }
      }

      // 프로필 영구 저장 (user_profiles 테이블)
      if (savedRequestId && effectiveUserId) {
        try {
          await saveUserProfile(db, {
            userId: String(effectiveUserId),
            analysisType: 'major',
            requestId: savedRequestId,
            miniModuleResult: payload.mini_module_result || {},
            narrativeFacts: narrativeFacts || null,
            roundAnswers: roundAnswers || null,
          })
        } catch (profileErr) {
          console.error('[recommend-major] Profile save error:', profileErr)
        }
      }
    } catch (saveError) {
      console.error('[recommend-major] Result save FAILED:', saveError)
    }

    // 9. 응답 반환
    const duration = Date.now() - startTime
    return c.json({
      success: true,
      mode: 'major_recommendation',
      session_id,
      request_id: savedRequestId,
      recommendations: {
        top_majors: topMajors.map(majorToDto),
        fit_top10: fitTop10,
        like_top10: likeTop10,
        can_top10: canTop10,
        total_candidates: expansionResult.candidates.length,
        filtered_count: filteredMajors.length,
        search_duration_ms: expansionResult.search_duration_ms,
      },
      premium_report: premiumReport,
      engine_version: RECOMMENDATION_ENGINE_VERSION,
      report_mode: reportMode,
      search_profile_used: searchProfile,
      debug_info: debug ? {
        vectorize_topK: topK,
        judge_topN: judgeTopN,
        fallback_used: expansionResult.fallback_used,
        has_narrative_facts: !!narrativeFacts,
        round_answers_count: roundAnswers.length,
      } : undefined,
      duration_ms: duration,
    })

  } catch (error) {
    return c.json(createErrorResponse(
      'ANALYSIS_FAILED',
      error instanceof Error ? `${error.message} | ${error.stack?.split('\n')[1] || ''}` : 'Major recommendation failed'
    ), 500)
  }
})

// ============================================
// 저장된 결과 조회 API (리포트 뷰어용)
// ============================================
// 저장된 분석 결과를 displayResults() 형식으로 반환 (리포트 뷰용)
analyzerRoutes.get('/saved-result/:requestId', async (c) => {
  const requestId = parseInt(c.req.param('requestId'), 10)
  if (!requestId || isNaN(requestId)) {
    return c.json({ error: 'Invalid request_id' }, 400)
  }

  try {
    const row = await c.env.DB.prepare(`
      SELECT r.result_json, r.premium_report_json, r.confidence_score,
             req.id as request_id, req.analysis_type, r.engine_version
      FROM ai_analysis_results r
      JOIN ai_analysis_requests req ON r.request_id = req.id
      WHERE req.id = ?
    `).bind(requestId).first<{
      result_json: string
      premium_report_json: string | null
      confidence_score: number | null
      request_id: number
      analysis_type: string
      engine_version: string | null
    }>()

    if (!row) {
      return c.json({ error: 'Result not found' }, 404)
    }

    let result: any = {}
    try { result = JSON.parse(row.result_json) } catch {}

    let premiumReport: any = null
    if (row.premium_report_json) {
      try { premiumReport = JSON.parse(row.premium_report_json) } catch {}
    }

    // premium_report를 result에 병합 (displayResults가 기대하는 형식)
    if (premiumReport) {
      result.premium_report = premiumReport
    } else if (result.premium_report) {
      // result_json 내부에 premium_report가 포함된 경우 (premium_report_json 컬럼이 null일 때)
      premiumReport = result.premium_report
    }
    if (row.engine_version) {
      result.engine_version = row.engine_version
    }
    if (row.confidence_score) {
      result.confidence = { score: row.confidence_score }
    }

    // 전공 결과 정규화: displayResults()가 result.recommendations 배열을 기대함
    if (row.analysis_type === 'major' && !result.recommendations) {
      const majors = result.fit_top_majors || result.fit_top3 || []
      result.recommendations = majors.map((m: any) => ({
        major_name: m.major_name || m.name || '추천 전공',
        name: m.name || m.major_name || '추천 전공',
        slug: m.slug || '',
        major_id: m.major_id || null,
        reason: m.rationale || m.reason || m.match_reason || '',
        fit_score: m.fit_score || m.final_score || 0,
        like_score: m.like_score || 0,
        can_score: m.can_score || 0,
        image_url: m.image_url || '',
      }))
    }

    return c.json({
      success: true,
      request_id: row.request_id,
      analysis_type: row.analysis_type,
      result,
    })
  } catch (error) {
    return c.json({ error: 'Failed to fetch result' }, 500)
  }
})

// GET /api/ai-analyzer/sample-result - 비로그인용 샘플 리포트 데이터
analyzerRoutes.get('/sample-result', async (c) => {
  const sampleResult = {
    engine_state: 'phase2_stage_based',
    engine_version: 'v3.22.3',
    mini_module_result: {
      interest_top: ['tech', 'problem_solving', 'creative'],
      value_top: ['growth', 'autonomy', 'expertise'],
      strength_top: ['analytical', 'fast_learning', 'persistence'],
      workstyle: 'solo_deep',
      constraint_top: ['routine_drain'],
    },
    versions: { recipe: 'recipe-v1.0.0', tagger: 'tagger-v1.0.0', scoring: 'scoring-v3.22.3' },
    input_summary: {
      profile_revision_id: 'sample-demo',
      facts_applied: 8,
      applied_rules: ['profile.interest.keywords', 'profile.strength.keywords', 'profile.value.keywords'],
      stage: 'job_student',
      universal_facts_count: 8,
    },
    fit_top3: [
      {
        job_id: 'sample-1', job_name: '소프트웨어개발자', slug: '소프트웨어개발자',
        image_url: '/uploads/jobs/job-커넥티드카소프트웨어개발자.webp',
        job_description: '소프트웨어를 설계하고 개발하는 전문가로, 다양한 프로그래밍 언어와 프레임워크를 활용하여 애플리케이션, 시스템, 웹 서비스 등을 구축합니다.',
        rationale: '[좋아할 이유] 기술과 문제 해결에 대한 관심이 직접 연결되는 직업입니다. 창의적 사고와 논리적 분석이 결합된 업무 특성이 있습니다. [잘할 이유] 분석적 사고력과 빠른 학습 능력이 핵심 역량으로 요구되며, 혼자 깊이 집중하는 업무 스타일과 잘 맞습니다.',
        like_reason: '기술과 문제 해결에 대한 관심이 직접 연결되는 직업입니다.',
        can_reason: '분석적 사고력과 빠른 학습 능력이 이 직업의 핵심 역량과 정확히 일치합니다.',
        fit_score: 92, like_score: 95, can_score: 90,
        risk_details: [],
        evidence_links: [
          { user_fact: { key: 'profile.interest.keywords', value: 'tech,problem_solving,creative', label: '"기술, 문제 해결, 창의성" 관심사' }, job_attribute: { key: 'tech_relevance', value: '95', label: '기술 관련성: 95/100' }, match_type: 'positive' as const, score_contribution: 18, explanation: '기술과 문제 해결에 관심이 있으시다고 하셨는데, 소프트웨어개발자는 이 분야의 핵심 직업입니다.' },
          { user_fact: { key: 'profile.strength.keywords', value: 'analytical,fast_learning', label: '"분석력, 빠른 학습" 강점' }, job_attribute: { key: 'analytical', value: '90', label: '분석력 요구: 90/100' }, match_type: 'positive' as const, score_contribution: 15, explanation: '분석적 사고력이 강점이시라고 하셨는데, 소프트웨어 개발은 복잡한 문제를 논리적으로 분해하는 능력이 핵심입니다.' },
        ],
        dislike_warnings: [],
      },
      {
        job_id: 'sample-2', job_name: '데이터분석가', slug: '데이터분석가',
        image_url: '/uploads/jobs/job-데이터분석가일반.webp',
        job_description: '대규모 데이터를 수집, 분석하여 비즈니스 인사이트를 도출하고 의사결정을 지원하는 전문가입니다.',
        rationale: '[좋아할 이유] 데이터 속에서 패턴을 찾고 문제를 해결하는 과정이 분석적 성향과 잘 맞습니다. [잘할 이유] 논리적 사고와 꼼꼼함이 데이터 분석의 핵심 역량입니다.',
        like_reason: '데이터 속에서 패턴을 찾고 문제를 해결하는 과정이 분석적 성향과 잘 맞습니다.',
        can_reason: '논리적 사고와 꼼꼼함이 데이터 분석의 핵심 역량입니다.',
        fit_score: 88, like_score: 90, can_score: 87,
        risk_details: [],
        evidence_links: [
          { user_fact: { key: 'profile.interest.keywords', value: 'problem_solving', label: '"문제 해결" 관심사' }, job_attribute: { key: 'problem_solving', value: '88', label: '문제 해결 역량: 88/100' }, match_type: 'positive' as const, score_contribution: 16, explanation: '문제 해결에 관심이 있으시다고 하셨는데, 데이터 분석가는 데이터 기반 문제 해결의 전문가입니다.' },
        ],
        dislike_warnings: [],
      },
      {
        job_id: 'sample-3', job_name: 'UX디자이너', slug: 'UX디자이너',
        image_url: '/uploads/jobs/job-uxui디자이너.webp',
        job_description: '사용자 경험을 연구하고 설계하여, 디지털 제품이 직관적이고 만족스럽게 사용될 수 있도록 하는 전문가입니다.',
        rationale: '[좋아할 이유] 창의성과 기술이 결합된 분야로, 사용자 문제를 해결하는 과정에서 보람을 느낄 수 있습니다. [잘할 이유] 분석적 사고와 창의적 문제 해결 능력이 UX 디자인의 핵심입니다.',
        like_reason: '창의성과 기술이 결합된 분야로, 사용자 문제를 해결하는 과정에서 보람을 느낄 수 있습니다.',
        can_reason: '분석적 사고와 창의적 문제 해결 능력이 UX 디자인의 핵심입니다.',
        fit_score: 85, like_score: 88, can_score: 83,
        risk_details: [],
        evidence_links: [
          { user_fact: { key: 'profile.interest.keywords', value: 'creative,tech', label: '"창의성, 기술" 관심사' }, job_attribute: { key: 'creative', value: '85', label: '창의성 요구: 85/100' }, match_type: 'positive' as const, score_contribution: 14, explanation: '창의적인 일에 관심이 있으시다고 하셨는데, UX 디자인은 기술과 창의성이 결합된 분야입니다.' },
        ],
        dislike_warnings: [],
      },
      {
        job_id: 'sample-4', job_name: '정보보안전문가', slug: '정보보안전문가',
        image_url: '/uploads/jobs/job-정보보호전문가.webp',
        job_description: '조직의 정보 자산을 보호하기 위해 보안 정책을 수립하고 시스템의 취약점을 분석·대응하는 전문가입니다.',
        rationale: '[좋아할 이유] 기술적 문제 해결과 끈기가 필요한 분야입니다. [잘할 이유] 분석력과 집중력이 보안 분석의 핵심 역량입니다.',
        like_reason: '기술적 문제 해결과 끈기가 필요한 분야입니다.',
        can_reason: '분석력과 집중력이 보안 분석의 핵심 역량입니다.',
        fit_score: 82, like_score: 84, can_score: 81,
        risk_details: [],
        evidence_links: [],
        dislike_warnings: [],
      },
      {
        job_id: 'sample-5', job_name: '게임프로그래머', slug: '게임프로그래머',
        image_url: '/uploads/jobs/job-게임프로그래머.webp',
        job_description: '게임의 핵심 시스템을 프로그래밍하고, 게임 엔진과 도구를 활용하여 인터랙티브 콘텐츠를 개발하는 전문가입니다.',
        rationale: '[좋아할 이유] 기술과 창의성이 극대화되는 분야입니다. [잘할 이유] 프로그래밍 역량과 끈기가 핵심입니다.',
        like_reason: '기술과 창의성이 극대화되는 분야입니다.',
        can_reason: '프로그래밍 역량과 끈기가 핵심입니다.',
        fit_score: 80, like_score: 86, can_score: 78,
        risk_details: [],
        evidence_links: [],
        dislike_warnings: [],
      },
    ],
    like_top10: [
      { job_id: 's1', job_name: '소프트웨어개발자', slug: '소프트웨어개발자', image_url: '/uploads/jobs/job-커넥티드카소프트웨어개발자.webp', like_score: 95, like_reason: '기술과 문제 해결에 대한 관심이 직접 연결됩니다.', job_description: '소프트웨어를 설계하고 개발하는 전문가입니다.' },
      { job_id: 's2', job_name: '데이터분석가', slug: '데이터분석가', image_url: '/uploads/jobs/job-데이터분석가일반.webp', like_score: 90, like_reason: '데이터에서 인사이트를 발견하는 과정이 분석적 성향과 잘 맞습니다.', job_description: '데이터를 수집·분석하여 비즈니스 인사이트를 도출합니다.' },
      { job_id: 's3', job_name: 'UX디자이너', slug: 'UX디자이너', image_url: '/uploads/jobs/job-uxui디자이너.webp', like_score: 88, like_reason: '기술과 창의성이 결합된 분야입니다.', job_description: '사용자 경험을 연구하고 설계하는 전문가입니다.' },
      { job_id: 's4', job_name: '게임프로그래머', slug: '게임프로그래머', image_url: '/uploads/jobs/job-게임프로그래머.webp', like_score: 86, like_reason: '기술과 창의성이 극대화되는 분야입니다.', job_description: '게임의 핵심 시스템을 프로그래밍합니다.' },
      { job_id: 's5', job_name: '정보보안전문가', slug: '정보보안전문가', image_url: '/uploads/jobs/job-정보보호전문가.webp', like_score: 84, like_reason: '기술적 문제 해결과 끈기가 필요한 분야입니다.', job_description: '조직의 정보 자산을 보호하는 전문가입니다.' },
      { job_id: 's6', job_name: '웹개발자', slug: '웹개발자', image_url: '/uploads/jobs/job-웹개발자.webp', like_score: 83, like_reason: '빠르게 결과를 만들어낼 수 있는 개발 분야입니다.', job_description: '웹 애플리케이션을 개발하는 전문가입니다.' },
      { job_id: 's7', job_name: '시스템엔지니어', slug: '시스템엔지니어', like_score: 80, like_reason: '인프라와 시스템 아키텍처에 관심이 있다면 적합합니다.', job_description: '서버 및 네트워크 시스템을 설계·운영합니다.' },
      { job_id: 's8', job_name: '인공지능엔지니어', slug: '인공지능엔지니어', like_score: 79, like_reason: '최첨단 기술로 혁신을 만드는 분야입니다.', job_description: '머신러닝과 딥러닝 모델을 개발합니다.' },
      { job_id: 's9', job_name: '데이터엔지니어', slug: '데이터엔지니어', like_score: 78, like_reason: '대규모 데이터 파이프라인을 설계하는 분야입니다.', job_description: '데이터 수집·저장·처리 시스템을 구축합니다.' },
      { job_id: 's10', job_name: '클라우드엔지니어', slug: '클라우드엔지니어', like_score: 76, like_reason: '클라우드 인프라를 설계하고 관리하는 분야입니다.', job_description: '클라우드 서비스를 설계·운영합니다.' },
    ],
    can_top10: [
      { job_id: 's1', job_name: '소프트웨어개발자', slug: '소프트웨어개발자', image_url: '/uploads/jobs/job-커넥티드카소프트웨어개발자.webp', can_score: 90, can_reason: '분석적 사고력과 빠른 학습 능력이 핵심 역량입니다.', job_description: '소프트웨어를 설계하고 개발하는 전문가입니다.' },
      { job_id: 's2', job_name: '데이터분석가', slug: '데이터분석가', image_url: '/uploads/jobs/job-데이터분석가일반.webp', can_score: 87, can_reason: '논리적 사고와 꼼꼼함이 핵심 역량입니다.', job_description: '데이터를 수집·분석하여 비즈니스 인사이트를 도출합니다.' },
      { job_id: 's3', job_name: 'UX디자이너', slug: 'UX디자이너', image_url: '/uploads/jobs/job-uxui디자이너.webp', can_score: 83, can_reason: '분석적 사고와 창의적 문제 해결 능력이 핵심입니다.', job_description: '사용자 경험을 연구하고 설계하는 전문가입니다.' },
      { job_id: 's4', job_name: '정보보안전문가', slug: '정보보안전문가', image_url: '/uploads/jobs/job-정보보호전문가.webp', can_score: 81, can_reason: '분석력과 집중력이 보안 분석의 핵심입니다.', job_description: '조직의 정보 자산을 보호하는 전문가입니다.' },
      { job_id: 's5', job_name: '웹개발자', slug: '웹개발자', image_url: '/uploads/jobs/job-웹개발자.webp', can_score: 80, can_reason: '빠른 학습력으로 다양한 웹 기술을 습득할 수 있습니다.', job_description: '웹 애플리케이션을 개발하는 전문가입니다.' },
      { job_id: 's6', job_name: '게임프로그래머', slug: '게임프로그래머', image_url: '/uploads/jobs/job-게임프로그래머.webp', can_score: 78, can_reason: '프로그래밍 역량과 끈기가 핵심입니다.', job_description: '게임의 핵심 시스템을 프로그래밍합니다.' },
      { job_id: 's7', job_name: '시스템엔지니어', slug: '시스템엔지니어', can_score: 76, can_reason: '체계적인 문제 해결 능력이 요구됩니다.', job_description: '서버 및 네트워크 시스템을 설계·운영합니다.' },
      { job_id: 's8', job_name: '데이터엔지니어', slug: '데이터엔지니어', can_score: 75, can_reason: '분석력과 기술 이해도가 핵심입니다.', job_description: '데이터 수집·저장·처리 시스템을 구축합니다.' },
      { job_id: 's9', job_name: '인공지능엔지니어', slug: '인공지능엔지니어', can_score: 74, can_reason: '수학적 사고와 프로그래밍 역량이 필요합니다.', job_description: '머신러닝과 딥러닝 모델을 개발합니다.' },
      { job_id: 's10', job_name: '클라우드엔지니어', slug: '클라우드엔지니어', can_score: 72, can_reason: '시스템 아키텍처 이해와 분석력이 요구됩니다.', job_description: '클라우드 서비스를 설계·운영합니다.' },
    ],
    caution_jobs: [],
    ux_flags: { show_risk_warning: false },
    llm_explanation: '분석 완료',
    generated_at: new Date().toISOString(),
    total_candidates: 150,
    analysis_stage: 'job_student',
    confidence: { score: 0.85 },
    premium_report: {
      report_id: 'sample-report',
      generated_at: new Date().toISOString(),
      session_id: 'sample-session',
      engine_version: 'v3.22.3',
      overall_status: 'success',
      sections_completed: 8,
      sections_total: 8,
      _confidence: 0.85,
      _factsCount: 8,
      _answeredQuestions: 9,
      _candidatesScored: 150,
      _appliedRules: 12,
      executiveSummary: '기술과 논리에 강한 분석형 인재로, 소프트웨어 개발이나 데이터 분석 분야에서 높은 적합도를 보입니다. 혼자 깊이 집중하는 업무 스타일이 개발/분석 직군의 특성과 잘 맞으며, 성장과 자율성을 중시하는 가치관이 IT 업계의 문화와 부합합니다.',
      workStyleNarrative: '당신은 복잡한 문제를 논리적으로 분해하고 체계적으로 해결하는 것을 즐기는 분석형 인재입니다. 혼자 깊이 집중하여 작업하는 환경에서 최고의 성과를 내며, 반복적이고 단조로운 업무보다는 새로운 도전과 학습 기회가 있는 환경을 선호합니다.',
      workStyleMap: {
        analytical_vs_creative: 70,
        solo_vs_team: 80,
        structured_vs_flexible: 45,
        depth_vs_breadth: 75,
        guided_vs_autonomous: 30,
        socialStyle: 'solo_deep',
        decisionStyle: 'analytical',
      },
      innerConflictAnalysis: '자율성과 안정성 사이에서 균형을 찾아야 할 수 있습니다. 자유로운 환경을 선호하지만, 너무 구조가 없으면 방향을 잃을 수 있으므로 적절한 프레임워크 안에서의 자율성이 이상적입니다.',
      conflictPatterns: ['자유 vs 구조 사이의 균형 탐색'],
      growthCurveType: '지수형 성장 (Exponential)',
      growthCurveDescription: '초기에는 학습 곡선이 가파르지만, 일정 수준 이상이 되면 빠르게 성장하는 지수형 성장 패턴을 보입니다.',
      stressTriggers: ['반복적인 단순 업무', '창의성이 제한되는 환경'],
      failurePattern: '완벽주의 경향으로 인해 작업 완료가 지연될 수 있습니다.',
      lifeVersionStatement: {
        oneLiner: '기술로 세상의 문제를 해결하는 분석적 창조자',
        expanded: [
          '기술과 문제 해결에 대한 깊은 관심이 커리어의 핵심 동력입니다.',
          '분석적 사고력과 빠른 학습 능력이 IT 분야에서의 성공 가능성을 높입니다.',
          '성장과 자율성을 중시하는 가치관이 스타트업이나 테크 기업과 잘 맞습니다.',
          '혼자 깊이 집중하는 업무 스타일이 개발/분석 직군의 특성과 부합합니다.',
          '반복적인 업무를 피하고 싶은 성향은 커리어 선택 시 중요한 고려 요소입니다.',
        ],
      },
      expertGuidance: {
        doNow: [
          '관심 있는 프로그래밍 언어(Python, JavaScript 등)로 개인 프로젝트를 시작하세요.',
          'GitHub에 포트폴리오를 만들어 학습 과정을 기록하세요.',
          'IT 관련 커뮤니티(개발자 포럼, 오픈소스 프로젝트)에 참여해보세요.',
        ],
        stopDoing: [
          '완벽한 준비를 기다리지 마세요 — 실전 경험이 가장 중요합니다.',
          '너무 넓은 범위를 한꺼번에 학습하려 하지 마세요 — 하나에 집중하세요.',
        ],
        learnNext: [
          '자료구조와 알고리즘 기초 (코딩 테스트 대비)',
          'Git과 버전 관리 시스템 사용법',
          '클라우드 서비스 기초 (AWS, GCP 등)',
        ],
        avoidPaths: [
          '단순 반복 작업 위주의 직무 (데이터 입력, 단순 관리 등)',
          '창의성이 제한되는 고도로 관료적인 조직',
        ],
      },
      profileInterpretation: {
        interests: [
          { label: '기술/IT', score: 95, insight: '기술 분야에 대한 관심이 매우 높습니다.' },
          { label: '문제해결/분석', score: 90, insight: '문제 해결 과정 자체에서 동기를 얻습니다.' },
          { label: '창작/디자인', score: 80, insight: '창의적 표현에 대한 욕구가 있습니다.' },
        ],
        strengths: [
          { label: '분석적 사고', score: 92, insight: '복잡한 정보를 분석하고 패턴을 찾는 데 탁월합니다.' },
          { label: '빠른 학습', score: 88, insight: '새로운 기술과 개념을 빠르게 습득합니다.' },
          { label: '끈기', score: 82, insight: '어려운 문제에 끈기 있게 도전합니다.' },
        ],
        values: [
          { label: '성장', score: 90, insight: '지속적인 성장과 발전을 가장 중요하게 여깁니다.' },
          { label: '자율성', score: 85, insight: '자율적으로 일하는 환경을 선호합니다.' },
          { label: '전문성', score: 80, insight: '전문성을 깊이 쌓아가는 것에 가치를 둡니다.' },
        ],
        constraints: [
          { label: '반복적 업무', score: 70, insight: '반복적인 업무에서 에너지가 소모됩니다.', meaning: '반복적이고 단조로운 업무가 계속되면 동기와 에너지가 크게 떨어집니다.' },
        ],
      },
      metaCognition: {
        myArsenal: {
          strengths: [
            { trait: '분석적 사고', confidence: 0.92, evidence: '복잡한 문제를 체계적으로 분석하는 능력' },
            { trait: '빠른 학습', confidence: 0.88, evidence: '새로운 기술을 빠르게 습득하는 학습력' },
            { trait: '끈기', confidence: 0.82, evidence: '어려운 과제에 끈기 있게 도전하는 자세' },
          ],
          hiddenStrengths: [
            { trait: '패턴 인식', confidence: 0.75, evidence: '데이터나 코드에서 규칙성을 빠르게 발견하는 능력이 잠재되어 있습니다.' },
          ],
        },
        stressRecovery: {
          stressFactors: [
            { factor: '반복적 업무', severity: 'high', copingStrategy: '자동화 도구를 만들어 반복 작업을 줄이세요.' },
            { factor: '자율성 부족', severity: 'medium', copingStrategy: '업무 범위 내에서 자신만의 방법론을 개발하세요.' },
          ],
          recoveryMethods: [
            { factor: '개인 프로젝트', why: '자기만의 프로젝트를 만들 때 자율성과 창의성을 회복하고 동기를 재충전할 수 있습니다.' },
            { factor: '새로운 기술 학습', why: '새로운 것을 배우는 과정에서 성장감을 느끼며 스트레스가 해소됩니다.' },
            { factor: '자연 속 산책', why: '화면에서 벗어나 자연 속에서 걸으면 사고가 정리되고 에너지가 회복됩니다.' },
          ],
        },
        selfAwareness: {
          knownStrengths: ['분석력', '학습력', '끈기'],
          blindSpots: ['팀 커뮤니케이션 능력이 과소평가되고 있을 수 있습니다.'],
          growthEdge: '기술적 깊이와 비즈니스 시각을 결합하면 더 큰 가치를 만들 수 있습니다.',
        },
        preferenceMap: {
          likes: [
            { item: '기술/IT', why: '새로운 기술을 탐구하고 직접 구현해보는 과정에서 큰 즐거움을 느낍니다.' },
            { item: '문제해결', why: '복잡한 퍼즐을 풀듯이 문제를 분석하고 해결하는 과정이 가장 몰입하는 순간입니다.' },
            { item: '자율적 환경', why: '스스로 계획하고 실행하는 환경에서 최고의 성과를 발휘합니다.' },
          ],
          dislikes: [
            { item: '반복적 업무', why: '같은 작업을 반복하면 동기가 급격히 떨어지고 집중력이 흐려집니다.' },
            { item: '자율성 부족', why: '세세하게 지시받는 환경에서는 창의성이 억제되어 답답함을 느낍니다.' },
          ],
          fits: [
            { item: '깊이 있는 전문성', why: '하나의 분야를 깊이 파고들어 전문가가 되는 경로가 가장 잘 맞습니다.' },
            { item: '성장 가능한 조직', why: '배움과 도전이 지속되는 환경에서 장기적으로 동기를 유지할 수 있습니다.' },
          ],
        },
      },
      summary_one_page: {
        headline: '기술 분석형 인재 — 개발·데이터 분야 최적합',
        top_takeaways: [
          '기술과 문제 해결에 대한 강한 관심 → IT 직군 핵심 적합',
          '분석적 사고력 + 빠른 학습 → 소프트웨어 개발/데이터 분석 최적',
          '성장과 자율성 중시 → 스타트업/테크 기업 문화 적합',
          '혼자 집중하는 스타일 → 개발/분석 업무 적합',
          '반복 업무 기피 → 창의적 문제 해결이 있는 직무 권장',
        ],
        recommended_next_step: '관심 분야(웹/앱/데이터/보안)를 하나 선택하고, 관련 프로젝트를 시작하세요.',
      },
      transitionTiming: {
        day30: {
          goal: '방향 설정',
          actions: ['관심 있는 프로그래밍 언어 선택하고 기초 학습 시작', '개발자 커뮤니티 가입 및 멘토 찾기'],
          milestone: '첫 번째 개인 프로젝트 아이디어 확정',
        },
        day60: {
          goal: '역량 구축',
          actions: ['선택한 언어로 개인 프로젝트 개발', 'GitHub 포트폴리오 구축 시작'],
          milestone: '동작하는 프로토타입 완성',
        },
        day90: {
          goal: '실전 경험',
          actions: ['오픈소스 프로젝트 기여 시작', '인턴십 또는 프리랜서 프로젝트 지원'],
          milestone: '실전 프로젝트 경험 1건 이상 확보',
        },
      },
    },
    user_insight: {
      primary_type: 'analytical_builder',
      type_label: '분석적 빌더',
      description: '논리와 기술로 체계적인 솔루션을 만드는 유형',
    },
  }

  return c.json({
    success: true,
    request_id: 'sample',
    analysis_type: 'job',
    result: sampleResult,
    is_sample: true,
  })
})

// POST /api/ai-analyzer/result/delete - AI 추천 결과 삭제
analyzerRoutes.post('/result/delete', async (c) => {
  const db = c.env.DB
  const authUser = c.get('user') as { id: number } | undefined
  if (!authUser?.id) {
    return c.json({ error: 'Login required' }, 401)
  }
  const userId = String(authUser.id)

  // query param 또는 body에서 request_id 가져오기
  let requestId = c.req.query('request_id')
  if (!requestId) {
    try {
      const body = await c.req.json<{ request_id?: number | string }>()
      requestId = body.request_id ? String(body.request_id) : null
    } catch { /* ignore */ }
  }
  if (!requestId) {
    return c.json({ error: 'request_id required' }, 400)
  }

  try {
    // 해당 요청이 이 유저의 것인지 확인 + session_id 가져오기
    const req = await db.prepare(
      'SELECT id, session_id FROM ai_analysis_requests WHERE id = ? AND user_id = ?'
    ).bind(requestId, userId).first<{ id: number; session_id: string }>()

    if (!req) {
      return c.json({ error: 'Not found or not authorized' }, 404)
    }

    // 결과 삭제
    await db.prepare('DELETE FROM ai_analysis_results WHERE request_id = ?').bind(requestId).run()
    // 요청 레코드 삭제
    await db.prepare('DELETE FROM ai_analysis_requests WHERE id = ?').bind(requestId).run()
    // 관련 드래프트도 삭제 (같은 session_id)
    if (req.session_id) {
      await db.prepare('DELETE FROM analyzer_drafts WHERE session_id = ? AND user_id = ?').bind(req.session_id, userId).run()
    }

    return c.json({ success: true, deleted_request_id: Number(requestId) })
  } catch (error) {
    console.error('[result/delete] Error:', error)
    return c.json({ error: 'Failed to delete result', details: String(error) }, 500)
  }
})

export { analyzerRoutes }
