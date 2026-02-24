// CareerWiki AI Analyzer - CAG Manager
// Version: v1.1.0 (Freeze v1.1 + P2 수집 진행도)
//
// ============================================
// CAG (Cache-Augmented Generation) 매니저
// ============================================
// 설계 원칙:
// 1. Interview Mode 동안 상태를 캐시하여 중복 계산 방지
// 2. asked_questions_log: 이미 물어본 질문 추적
// 3. axis_coverage_state: 축별 정보 수집 상태
// 4. QSP 히스토리: 최근 1-3개 QSP 저장
// 5. collection_progress: Like/Can/Risk 수집 진행도 추적 (P2)
// ============================================

import type { D1Database } from '@cloudflare/workers-types'
import type { AxisCoverage, AxisType } from './axis-framework'
import { createEmptyAxisCoverage, updateAxisCoverage, calculateAxisConfidence } from './axis-framework'
import type { QSP } from './qsp-generator'

// ============================================
// 질문 로그 항목
// ============================================
export interface AskedQuestionLog {
  questionId: string
  questionText: string
  round: 1 | 2 | 3
  askedAt: string
  targetAxis?: AxisType
  answered: boolean
  answerExcerpt?: string  // 최대 200자
}

// ============================================
// TAG 판단 로그 타입 (실시간 기억)
// ============================================
export interface TagExclusionLog {
  job_id: string
  job_name: string
  rule_id: string
  reason: string
  confidence: 'high' | 'medium' | 'low'
  source: 'user_fact' | 'job_attribute' | 'inferred'
  timestamp: string
}

export interface TagSoftFlag {
  axis: AxisType
  issue: string
  confidence: number
  affected_jobs_count: number
}

export interface TagDecisionLog {
  exclusions: TagExclusionLog[]
  soft_flags: TagSoftFlag[]
}

// ============================================
// 수집 진행도 (P2: Collection Progress)
// ============================================
export type CollectionDimension = 'like' | 'can' | 'risk'

/**
 * 각 차원별 수집 상태
 */
export interface DimensionProgress {
  /** 수집된 항목 수 */
  collected_count: number
  /** 필요한 최소 항목 수 */
  required_min: number
  /** 검증된 항목 수 (Can 검증, Like 검증 등) */
  verified_count: number
  /** 수집된 fact 키 목록 */
  fact_keys: string[]
  /** 최근 업데이트 */
  last_updated: string
  /** 진행도 (0-100%) */
  progress_percent: number
}

/**
 * 전체 수집 진행도 상태
 */
export interface CollectionProgress {
  like: DimensionProgress
  can: DimensionProgress
  risk: DimensionProgress
  /** 전체 진행도 (0-100%) */
  overall_percent: number
  /** 추가 질문이 필요한 차원 */
  needs_more: CollectionDimension[]
  /** 수집 완료 여부 */
  is_sufficient: boolean
}

// ============================================
// CAG 상태 전체
// ============================================
export interface CAGState {
  sessionId: string

  // 질문 로그
  asked_questions_log: AskedQuestionLog[]

  // 축별 정보 수집 상태
  axis_coverage_state: AxisCoverage

  // QSP 히스토리 (최대 3개)
  qsp_history: Array<{
    round: number
    qsp: QSP
    generatedAt: string
  }>

  // TAG 판단 로그 (실시간 기억)
  // - 휘발성: 추천 확정 근거로 쓰지 않음
  // - 중복 판단 방지, 질문 재진입 시 맥락 유지
  tag_decision_log: TagDecisionLog

  // P2: Like/Can/Risk 수집 진행도
  collection_progress: CollectionProgress

  // 메타
  currentRound: 1 | 2 | 3
  lastUpdated: string
  version: number
}

// ============================================
// 수집 진행도 설정 상수
// ============================================
const COLLECTION_CONFIG = {
  // Like: 최소 3개 이상 수집 필요 (취향/관심사)
  like: { required_min: 3 },
  // Can: 최소 2개 이상 수집 필요 (능력/경험)
  can: { required_min: 2 },
  // Risk: 최소 1개 이상 수집 필요 (제약/리스크)
  risk: { required_min: 1 },
}

/**
 * 빈 차원 진행도 생성
 */
function createEmptyDimensionProgress(dimension: CollectionDimension): DimensionProgress {
  return {
    collected_count: 0,
    required_min: COLLECTION_CONFIG[dimension].required_min,
    verified_count: 0,
    fact_keys: [],
    last_updated: new Date().toISOString(),
    progress_percent: 0,
  }
}

/**
 * 빈 수집 진행도 생성
 */
export function createEmptyCollectionProgress(): CollectionProgress {
  return {
    like: createEmptyDimensionProgress('like'),
    can: createEmptyDimensionProgress('can'),
    risk: createEmptyDimensionProgress('risk'),
    overall_percent: 0,
    needs_more: ['like', 'can', 'risk'],
    is_sufficient: false,
  }
}

// ============================================
// 빈 CAG 상태 생성
// ============================================
export function createEmptyCAGState(sessionId: string): CAGState {
  return {
    sessionId,
    asked_questions_log: [],
    axis_coverage_state: createEmptyAxisCoverage(),
    qsp_history: [],
    tag_decision_log: {
      exclusions: [],
      soft_flags: [],
    },
    collection_progress: createEmptyCollectionProgress(),
    currentRound: 1,
    lastUpdated: new Date().toISOString(),
    version: 1,
  }
}

// ============================================
// CAG 상태 로드 (DB에서)
// ============================================
export async function loadCAGState(
  db: D1Database,
  sessionId: string
): Promise<CAGState | null> {
  try {
    const result = await db.prepare(`
      SELECT cag_state_json
      FROM ai_analysis_drafts
      WHERE session_id = ?
    `).bind(sessionId).first<{ cag_state_json: string | null }>()
    
    if (result?.cag_state_json) {
      return JSON.parse(result.cag_state_json)
    }
  } catch (error) {
  }
  
  return null
}

// ============================================
// CAG 상태 저장 (DB에)
// ============================================
export async function saveCAGState(
  db: D1Database,
  state: CAGState
): Promise<void> {
  const stateJson = JSON.stringify(state)
  
  try {
    await db.prepare(`
      UPDATE ai_analysis_drafts
      SET cag_state_json = ?, updated_at = datetime('now')
      WHERE session_id = ?
    `).bind(stateJson, state.sessionId).run()
    
  } catch (error) {
    throw error
  }
}

// ============================================
// CAG 상태 리셋 (재분석 시 누적 방지)
// ============================================
export async function resetCAGState(
  db: D1Database,
  sessionId: string
): Promise<CAGState> {
  const newState = createEmptyCAGState(sessionId)
  try {
    await saveCAGState(db, newState)
  } catch (error) {
  }
  return newState
}

// ============================================
// CAG 상태 가져오기 또는 생성
// ============================================
export async function getOrCreateCAGState(
  db: D1Database,
  sessionId: string
): Promise<CAGState> {
  const existing = await loadCAGState(db, sessionId)
  
  if (existing) {
    return existing
  }
  
  // 새 상태 생성
  const newState = createEmptyCAGState(sessionId)
  
  // 저장 시도 (테이블에 컬럼이 있다면)
  try {
    await saveCAGState(db, newState)
  } catch (error) {
    // 컬럼이 없으면 무시 (마이그레이션 전)
  }
  
  return newState
}

// ============================================
// 질문 추가 로깅
// ============================================
export function logAskedQuestion(
  state: CAGState,
  question: {
    questionId: string
    questionText: string
    round: 1 | 2 | 3
    targetAxis?: AxisType
  }
): CAGState {
  const newLog: AskedQuestionLog = {
    questionId: question.questionId,
    questionText: question.questionText,
    round: question.round,
    askedAt: new Date().toISOString(),
    targetAxis: question.targetAxis,
    answered: false,
  }
  
  return {
    ...state,
    asked_questions_log: [...state.asked_questions_log, newLog],
    currentRound: question.round,
    lastUpdated: new Date().toISOString(),
    version: state.version + 1,
  }
}

// ============================================
// 답변 기록
// ============================================
export function logAnswerReceived(
  state: CAGState,
  questionId: string,
  answerExcerpt: string,
  targetAxis?: AxisType
): CAGState {
  // 질문 로그 업데이트
  const updatedLog = state.asked_questions_log.map(q => {
    if (q.questionId === questionId) {
      return {
        ...q,
        answered: true,
        answerExcerpt: answerExcerpt.slice(0, 200),
      }
    }
    return q
  })
  
  // 축 커버리지 업데이트
  let updatedCoverage = state.axis_coverage_state
  if (targetAxis && answerExcerpt.length > 10) {
    const evidenceCount = updatedCoverage[targetAxis].evidence.length + 1
    updatedCoverage = updateAxisCoverage(updatedCoverage, targetAxis, {
      evidence: [answerExcerpt.slice(0, 100)],
      confidence: calculateAxisConfidence(evidenceCount),
    })
  }
  
  return {
    ...state,
    asked_questions_log: updatedLog,
    axis_coverage_state: updatedCoverage,
    lastUpdated: new Date().toISOString(),
    version: state.version + 1,
  }
}

// ============================================
// QSP 히스토리 추가
// ============================================
export function addQSPToHistory(
  state: CAGState,
  round: number,
  qsp: QSP
): CAGState {
  const newEntry = {
    round,
    qsp,
    generatedAt: new Date().toISOString(),
  }
  
  // 최대 3개 유지
  const history = [...state.qsp_history, newEntry].slice(-3)
  
  return {
    ...state,
    qsp_history: history,
    lastUpdated: new Date().toISOString(),
    version: state.version + 1,
  }
}

// ============================================
// 이미 물어본 질문인지 확인
// ============================================
export function isQuestionAlreadyAsked(
  state: CAGState,
  questionText: string,
  similarityThreshold: number = 0.8
): boolean {
  // questionText가 없으면 중복 아님
  if (!questionText) return false
  
  // 정확히 같은 질문
  if (state.asked_questions_log.some(q => q.questionText === questionText)) {
    return true
  }
  
  // 유사한 질문 (간단한 키워드 기반)
  const keywords = questionText
    .split(/[^\w가-힣]+/)
    .filter(w => w.length > 1)
  
  for (const log of state.asked_questions_log) {
    // log.questionText가 없으면 스킵
    if (!log.questionText) continue
    
    const logKeywords = log.questionText
      .split(/[^\w가-힣]+/)
      .filter(w => w.length > 1)
    
    // 키워드 겹침 비율
    const intersection = keywords.filter(k => logKeywords.includes(k)).length
    const union = new Set([...keywords, ...logKeywords]).size
    const similarity = union > 0 ? intersection / union : 0
    
    if (similarity >= similarityThreshold) {
      return true
    }
  }
  
  return false
}

// ============================================
// 충분히 커버된 축 목록
// ============================================
export function getSufficientAxes(
  state: CAGState,
  confidenceThreshold: number = 0.7
): AxisType[] {
  const sufficient: AxisType[] = []
  
  for (const [axis, axisState] of Object.entries(state.axis_coverage_state)) {
    if (axisState.confidence >= confidenceThreshold && !axisState.missing) {
      sufficient.push(axis as AxisType)
    }
  }
  
  return sufficient
}

// ============================================
// 가장 최근 QSP 가져오기
// ============================================
export function getLatestQSP(state: CAGState): QSP | null {
  if (state.qsp_history.length === 0) {
    return null
  }
  
  return state.qsp_history[state.qsp_history.length - 1].qsp
}

// ============================================
// CAG Guard: 질문 필터링
// ============================================
export interface CAGGuardResult {
  allowed: boolean
  reason?: string
}

export function cagGuardQuestion(
  state: CAGState,
  questionText: string,
  targetAxis?: AxisType
): CAGGuardResult {
  // 1. 이미 물어본 질문
  if (isQuestionAlreadyAsked(state, questionText)) {
    return { 
      allowed: false, 
      reason: '이미 유사한 질문을 했습니다' 
    }
  }
  
  // 2. 이미 충분히 커버된 축
  if (targetAxis) {
    const axisState = state.axis_coverage_state[targetAxis]
    if (axisState.confidence > 0.8) {
      return { 
        allowed: false, 
        reason: `${targetAxis} 축은 이미 충분한 정보가 있습니다` 
      }
    }
  }
  
  // 3. 같은 라운드에서 너무 많은 질문
  const currentRoundQuestions = state.asked_questions_log.filter(
    q => q.round === state.currentRound
  )
  if (currentRoundQuestions.length >= 5) {
    return { 
      allowed: false, 
      reason: '이 라운드에서 이미 충분한 질문을 했습니다' 
    }
  }
  
  return { allowed: true }
}

// ============================================
// TAG 판단 로그: 제외 항목 추가
// ============================================
const MAX_EXCLUSION_LOG = 50  // 최대 저장 개수

export function logTagExclusion(
  state: CAGState,
  exclusion: Omit<TagExclusionLog, 'timestamp'>
): CAGState {
  const newExclusion: TagExclusionLog = {
    ...exclusion,
    timestamp: new Date().toISOString(),
  }
  
  // 중복 방지 (같은 job_id가 이미 있으면 스킵)
  if (state.tag_decision_log.exclusions.some(e => e.job_id === exclusion.job_id)) {
    return state
  }
  
  // 최대 개수 유지
  const exclusions = [...state.tag_decision_log.exclusions, newExclusion]
    .slice(-MAX_EXCLUSION_LOG)
  
  return {
    ...state,
    tag_decision_log: {
      ...state.tag_decision_log,
      exclusions,
    },
    lastUpdated: new Date().toISOString(),
    version: state.version + 1,
  }
}

// ============================================
// TAG 판단 로그: Soft Flag 추가
// ============================================
const MAX_SOFT_FLAGS = 20  // 최대 저장 개수

export function logTagSoftFlag(
  state: CAGState,
  softFlag: TagSoftFlag
): CAGState {
  // 같은 axis + issue 조합이 있으면 업데이트
  const existingIdx = state.tag_decision_log.soft_flags.findIndex(
    f => f.axis === softFlag.axis && f.issue === softFlag.issue
  )
  
  let soft_flags: TagSoftFlag[]
  
  if (existingIdx >= 0) {
    soft_flags = [...state.tag_decision_log.soft_flags]
    soft_flags[existingIdx] = softFlag
  } else {
    soft_flags = [...state.tag_decision_log.soft_flags, softFlag]
      .slice(-MAX_SOFT_FLAGS)
  }
  
  return {
    ...state,
    tag_decision_log: {
      ...state.tag_decision_log,
      soft_flags,
    },
    lastUpdated: new Date().toISOString(),
    version: state.version + 1,
  }
}

// ============================================
// TAG 판단 로그: 배치 업데이트
// ============================================
export function updateTagDecisionLog(
  state: CAGState,
  newExclusions: Omit<TagExclusionLog, 'timestamp'>[],
  newSoftFlags: TagSoftFlag[]
): CAGState {
  let updatedState = state
  
  for (const exclusion of newExclusions) {
    updatedState = logTagExclusion(updatedState, exclusion)
  }
  
  for (const softFlag of newSoftFlags) {
    updatedState = logTagSoftFlag(updatedState, softFlag)
  }
  
  return updatedState
}

// ============================================
// TAG 판단 로그: 가져오기
// ============================================
export function getTagDecisionSummary(state: CAGState): {
  totalExcluded: number
  totalSoftFlags: number
  topExclusionReasons: Array<{ reason: string; count: number }>
  softFlagsByAxis: Record<string, number>
} {
  const exclusionReasonCounts: Record<string, number> = {}
  for (const e of state.tag_decision_log.exclusions) {
    exclusionReasonCounts[e.reason] = (exclusionReasonCounts[e.reason] || 0) + 1
  }

  const topExclusionReasons = Object.entries(exclusionReasonCounts)
    .map(([reason, count]) => ({ reason, count }))
    .sort((a, b) => b.count - a.count)
    .slice(0, 5)

  const softFlagsByAxis: Record<string, number> = {}
  for (const f of state.tag_decision_log.soft_flags) {
    softFlagsByAxis[f.axis] = (softFlagsByAxis[f.axis] || 0) + 1
  }

  return {
    totalExcluded: state.tag_decision_log.exclusions.length,
    totalSoftFlags: state.tag_decision_log.soft_flags.length,
    topExclusionReasons,
    softFlagsByAxis,
  }
}

// ============================================
// P2: 수집 진행도 업데이트 함수들
// ============================================

/**
 * Fact 키에서 차원 분류
 */
export function classifyFactKey(factKey: string): CollectionDimension | null {
  // Like 관련 fact keys
  const likePatterns = [
    'like.',
    'interest.',
    'preference.',
    'work_style.',
    'environment.',
    'job_interest',
    'activity_preference',
    'like_verified',
  ]

  // Can 관련 fact keys
  const canPatterns = [
    'can.',
    'skill.',
    'experience.',
    'strength.',
    'ability.',
    'can_verified',
    'education.',
    'certificate.',
  ]

  // Risk 관련 fact keys
  const riskPatterns = [
    'risk.',
    'constraint.',
    'health.',
    'limitation.',
    'exclusion.',
    'physical_labor',
    'work_hours',
    'shift_work',
    'remote_only',
    'salary_min',
  ]

  for (const pattern of likePatterns) {
    if (factKey.includes(pattern)) return 'like'
  }

  for (const pattern of canPatterns) {
    if (factKey.includes(pattern)) return 'can'
  }

  for (const pattern of riskPatterns) {
    if (factKey.includes(pattern)) return 'risk'
  }

  return null
}

/**
 * 진행도 퍼센트 계산
 */
function calculateProgressPercent(collected: number, required: number): number {
  if (required <= 0) return 100
  const percent = Math.min(100, Math.round((collected / required) * 100))
  return percent
}

/**
 * 수집 진행도에 새 fact 추가
 */
export function updateCollectionProgress(
  state: CAGState,
  factKey: string,
  isVerified: boolean = false
): CAGState {
  const dimension = classifyFactKey(factKey)
  if (!dimension) {
    // 분류 불가능한 fact는 무시
    return state
  }

  const currentProgress = state.collection_progress[dimension]

  // 이미 수집된 fact인지 확인
  if (currentProgress.fact_keys.includes(factKey)) {
    // 검증 상태만 업데이트
    if (isVerified && factKey.includes('verified')) {
      const updatedDimension: DimensionProgress = {
        ...currentProgress,
        verified_count: currentProgress.verified_count + 1,
        last_updated: new Date().toISOString(),
      }

      return updateCollectionProgressState(state, dimension, updatedDimension)
    }
    return state
  }

  // 새 fact 추가
  const updatedDimension: DimensionProgress = {
    ...currentProgress,
    collected_count: currentProgress.collected_count + 1,
    verified_count: isVerified ? currentProgress.verified_count + 1 : currentProgress.verified_count,
    fact_keys: [...currentProgress.fact_keys, factKey],
    last_updated: new Date().toISOString(),
    progress_percent: calculateProgressPercent(
      currentProgress.collected_count + 1,
      currentProgress.required_min
    ),
  }

  return updateCollectionProgressState(state, dimension, updatedDimension)
}

/**
 * 특정 차원의 진행도 업데이트
 */
function updateCollectionProgressState(
  state: CAGState,
  dimension: CollectionDimension,
  updatedDimension: DimensionProgress
): CAGState {
  const newProgress: CollectionProgress = {
    ...state.collection_progress,
    [dimension]: updatedDimension,
  }

  // 전체 진행도 재계산
  const totalCollected =
    newProgress.like.collected_count +
    newProgress.can.collected_count +
    newProgress.risk.collected_count

  const totalRequired =
    COLLECTION_CONFIG.like.required_min +
    COLLECTION_CONFIG.can.required_min +
    COLLECTION_CONFIG.risk.required_min

  newProgress.overall_percent = calculateProgressPercent(totalCollected, totalRequired)

  // 추가 질문이 필요한 차원 계산
  newProgress.needs_more = []
  if (newProgress.like.collected_count < COLLECTION_CONFIG.like.required_min) {
    newProgress.needs_more.push('like')
  }
  if (newProgress.can.collected_count < COLLECTION_CONFIG.can.required_min) {
    newProgress.needs_more.push('can')
  }
  if (newProgress.risk.collected_count < COLLECTION_CONFIG.risk.required_min) {
    newProgress.needs_more.push('risk')
  }

  // 충분한 수집 완료 여부
  newProgress.is_sufficient = newProgress.needs_more.length === 0

  return {
    ...state,
    collection_progress: newProgress,
    lastUpdated: new Date().toISOString(),
    version: state.version + 1,
  }
}

/**
 * Facts 배열로부터 진행도 초기화/동기화
 */
export function syncCollectionProgressFromFacts(
  state: CAGState,
  facts: Array<{ fact_key: string; value_json: string }>
): CAGState {
  let updatedState = {
    ...state,
    collection_progress: createEmptyCollectionProgress(),
  }

  for (const fact of facts) {
    const isVerified = fact.fact_key.includes('verified')
    updatedState = updateCollectionProgress(updatedState, fact.fact_key, isVerified)
  }

  return updatedState
}

/**
 * 수집 진행도 요약 반환
 */
export function getCollectionProgressSummary(state: CAGState): {
  overall_percent: number
  like: { percent: number; collected: number; required: number; verified: number }
  can: { percent: number; collected: number; required: number; verified: number }
  risk: { percent: number; collected: number; required: number; verified: number }
  needs_more: CollectionDimension[]
  is_sufficient: boolean
  suggestion: string
} {
  const { collection_progress } = state

  // 다음 질문 제안 생성
  let suggestion = ''
  if (!collection_progress.is_sufficient) {
    const needsMoreLabels: Record<CollectionDimension, string> = {
      like: '관심사/취향',
      can: '능력/경험',
      risk: '제약조건',
    }

    const needsMoreText = collection_progress.needs_more
      .map(d => needsMoreLabels[d])
      .join(', ')

    suggestion = `추가 정보 필요: ${needsMoreText}`
  } else {
    suggestion = '충분한 정보가 수집되었습니다'
  }

  return {
    overall_percent: collection_progress.overall_percent,
    like: {
      percent: collection_progress.like.progress_percent,
      collected: collection_progress.like.collected_count,
      required: collection_progress.like.required_min,
      verified: collection_progress.like.verified_count,
    },
    can: {
      percent: collection_progress.can.progress_percent,
      collected: collection_progress.can.collected_count,
      required: collection_progress.can.required_min,
      verified: collection_progress.can.verified_count,
    },
    risk: {
      percent: collection_progress.risk.progress_percent,
      collected: collection_progress.risk.collected_count,
      required: collection_progress.risk.required_min,
      verified: collection_progress.risk.verified_count,
    },
    needs_more: collection_progress.needs_more,
    is_sufficient: collection_progress.is_sufficient,
    suggestion,
  }
}

/**
 * 가장 부족한 차원 반환 (다음 질문 선택에 활용)
 */
export function getMostNeededDimension(state: CAGState): CollectionDimension | null {
  const { collection_progress } = state

  if (collection_progress.is_sufficient) {
    return null
  }

  // 진행도가 가장 낮은 차원 선택
  type DimensionWithScore = { dimension: CollectionDimension; score: number }
  const scores: DimensionWithScore[] = [
    { dimension: 'like', score: collection_progress.like.progress_percent },
    { dimension: 'can', score: collection_progress.can.progress_percent },
    { dimension: 'risk', score: collection_progress.risk.progress_percent },
  ]

  // needs_more에 있는 것 중에서만 선택
  const needsMoreSet = new Set(collection_progress.needs_more)
  const candidates = scores.filter(s => needsMoreSet.has(s.dimension))

  if (candidates.length === 0) {
    return null
  }

  // 가장 낮은 점수 선택
  candidates.sort((a, b) => a.score - b.score)
  return candidates[0].dimension
}
