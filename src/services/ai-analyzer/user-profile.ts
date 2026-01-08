// CareerWiki AI Analyzer - User Profile Manager
// Version: v1.0.0
//
// ⚠️ 설계 원칙 (피드백 반영)
// ============================================
// 1. 가설 신뢰도 변화 (before/after) 기록
// 2. 이번 세션에서 새로 확정된 사항 기록
// 3. 불확실성 감소 항목 추적
// → "다음에 올수록 더 똑똑해지는 서비스" 구현 기반
// ============================================

import type { D1Database } from '@cloudflare/workers-types'
import type { FollowupPurpose } from './types'

// ============================================
// 타입 정의
// ============================================

export type TurnType = 
  | 'universal_intake'
  | 'stage_intake'
  | 'deep_intake'
  | 'followup_v2'
  | 'followup_v3'
  | 'premium_report_generated'

export type AnswerType = 'text' | 'single_choice' | 'multi_choice' | 'json'

export interface ConversationTurn {
  session_id: string
  user_id?: string
  request_id?: number
  turn_number: number
  turn_type: TurnType
  question_id?: string
  question_type?: FollowupPurpose
  question_why_asked?: string
  answer_raw: string
  answer_type: AnswerType
  extracted_signals?: ExtractedSignals
  affected_dimensions?: string[]
}

export interface ExtractedSignals {
  preferences?: string[]
  constraints?: string[]
  motivations?: string[]
  dislikes?: string[]
}

export type HypothesisStatus = 'new' | 'strengthened' | 'weakened' | 'unchanged' | 'invalidated'

export interface Hypothesis {
  id: string
  statement: string
  confidence_before: number
  confidence_after: number
  confidence_change: number
  supporting_facts: string[]
  contradicting_facts: string[]
  status: HypothesisStatus
}

export interface NewlyConfirmed {
  fact_key: string
  value: any
  turn_number: number
}

export interface UncertaintyReduced {
  dimension: string
  before_uncertainty: number
  after_uncertainty: number
  resolved_by_turn: number
}

export interface PendingClarification {
  question: string
  priority: 'high' | 'medium' | 'low'
  affected_dimensions: string[]
}

export interface ProfileSnapshot {
  raw_answers_summary: {
    total_turns: number
    intake_turns: number
    followup_turns: number
  }
  extracted_signals: ExtractedSignals
  hypotheses: Hypothesis[]
  newly_confirmed: NewlyConfirmed[]
  uncertainty_reduced: UncertaintyReduced[]
  pending_clarifications: PendingClarification[]
}

export type SnapshotTrigger = 'initial_analysis' | 'followup_completed' | 'premium_report' | 'manual_update'

// ============================================
// 대화 턴 저장
// ============================================

export async function saveConversationTurn(
  db: D1Database,
  turn: ConversationTurn
): Promise<number> {
  const result = await db.prepare(`
    INSERT INTO conversation_turns (
      session_id, user_id, request_id,
      turn_number, turn_type,
      question_id, question_type, question_why_asked,
      answer_raw, answer_type,
      extracted_signals_json, affected_dimensions_json
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).bind(
    turn.session_id,
    turn.user_id || null,
    turn.request_id || null,
    turn.turn_number,
    turn.turn_type,
    turn.question_id || null,
    turn.question_type || null,
    turn.question_why_asked || null,
    turn.answer_raw,
    turn.answer_type,
    turn.extracted_signals ? JSON.stringify(turn.extracted_signals) : null,
    turn.affected_dimensions ? JSON.stringify(turn.affected_dimensions) : null
  ).run()
  
  return result.meta.last_row_id as number
}

// ============================================
// 세션의 대화 턴 조회
// ============================================

export async function getConversationTurns(
  db: D1Database,
  session_id: string
): Promise<ConversationTurn[]> {
  const result = await db.prepare(`
    SELECT 
      session_id, user_id, request_id,
      turn_number, turn_type,
      question_id, question_type, question_why_asked,
      answer_raw, answer_type,
      extracted_signals_json, affected_dimensions_json
    FROM conversation_turns
    WHERE session_id = ?
    ORDER BY turn_number ASC
  `).bind(session_id).all<{
    session_id: string
    user_id: string | null
    request_id: number | null
    turn_number: number
    turn_type: TurnType
    question_id: string | null
    question_type: FollowupPurpose | null
    question_why_asked: string | null
    answer_raw: string
    answer_type: AnswerType
    extracted_signals_json: string | null
    affected_dimensions_json: string | null
  }>()
  
  return (result.results || []).map(row => ({
    session_id: row.session_id,
    user_id: row.user_id || undefined,
    request_id: row.request_id || undefined,
    turn_number: row.turn_number,
    turn_type: row.turn_type,
    question_id: row.question_id || undefined,
    question_type: row.question_type || undefined,
    question_why_asked: row.question_why_asked || undefined,
    answer_raw: row.answer_raw,
    answer_type: row.answer_type,
    extracted_signals: row.extracted_signals_json 
      ? JSON.parse(row.extracted_signals_json) 
      : undefined,
    affected_dimensions: row.affected_dimensions_json
      ? JSON.parse(row.affected_dimensions_json)
      : undefined,
  }))
}

// ============================================
// 다음 턴 번호 조회
// ============================================

export async function getNextTurnNumber(
  db: D1Database,
  session_id: string
): Promise<number> {
  const result = await db.prepare(`
    SELECT MAX(turn_number) as max_turn
    FROM conversation_turns
    WHERE session_id = ?
  `).bind(session_id).first<{ max_turn: number | null }>()
  
  return (result?.max_turn || 0) + 1
}

// ============================================
// 프로필 스냅샷 저장
// ============================================

export async function saveProfileSnapshot(
  db: D1Database,
  session_id: string,
  user_id: string | undefined,
  request_id: number | undefined,
  report_id: string | undefined,
  trigger_type: SnapshotTrigger,
  profile: ProfileSnapshot,
  previous_snapshot_id?: number
): Promise<number> {
  // 가설 통계 계산
  const hypothesesCount = profile.hypotheses.length
  const hypothesesStrengthened = profile.hypotheses.filter(h => h.status === 'strengthened').length
  const hypothesesWeakened = profile.hypotheses.filter(h => h.status === 'weakened').length
  const hypothesesNew = profile.hypotheses.filter(h => h.status === 'new').length
  
  // 불확실성 감소 점수 계산
  const uncertaintyReductionScore = profile.uncertainty_reduced.reduce(
    (sum, u) => sum + (u.before_uncertainty - u.after_uncertainty),
    0
  ) / Math.max(profile.uncertainty_reduced.length, 1)
  
  const result = await db.prepare(`
    INSERT INTO user_profile_snapshots (
      session_id, user_id, request_id, report_id,
      trigger_type, profile_json,
      hypotheses_count, hypotheses_strengthened, hypotheses_weakened, hypotheses_new,
      uncertainty_reduction_score, previous_snapshot_id
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).bind(
    session_id,
    user_id || null,
    request_id || null,
    report_id || null,
    trigger_type,
    JSON.stringify(profile),
    hypothesesCount,
    hypothesesStrengthened,
    hypothesesWeakened,
    hypothesesNew,
    uncertaintyReductionScore,
    previous_snapshot_id || null
  ).run()
  
  return result.meta.last_row_id as number
}

// ============================================
// 최신 프로필 스냅샷 조회
// ============================================

export async function getLatestProfileSnapshot(
  db: D1Database,
  session_id: string
): Promise<{ id: number; profile: ProfileSnapshot } | null> {
  const result = await db.prepare(`
    SELECT id, profile_json
    FROM user_profile_snapshots
    WHERE session_id = ?
    ORDER BY created_at DESC
    LIMIT 1
  `).bind(session_id).first<{ id: number; profile_json: string }>()
  
  if (!result) return null
  
  return {
    id: result.id,
    profile: JSON.parse(result.profile_json),
  }
}

// ============================================
// 가설 히스토리 저장
// ============================================

export async function saveHypothesisHistory(
  db: D1Database,
  session_id: string,
  user_id: string | undefined,
  snapshot_id: number,
  hypothesis: Hypothesis,
  triggered_by_turn?: number,
  triggered_by_fact_key?: string,
  change_reason?: string
): Promise<number> {
  const result = await db.prepare(`
    INSERT INTO hypothesis_history (
      session_id, user_id, snapshot_id,
      hypothesis_id, hypothesis_statement,
      confidence_before, confidence_after, confidence_change,
      change_reason, triggered_by_turn, triggered_by_fact_key,
      status
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).bind(
    session_id,
    user_id || null,
    snapshot_id,
    hypothesis.id,
    hypothesis.statement,
    hypothesis.confidence_before,
    hypothesis.confidence_after,
    hypothesis.confidence_change,
    change_reason || null,
    triggered_by_turn || null,
    triggered_by_fact_key || null,
    hypothesis.status
  ).run()
  
  return result.meta.last_row_id as number
}

// ============================================
// 가설 히스토리 조회
// ============================================

export async function getHypothesisHistory(
  db: D1Database,
  session_id: string,
  hypothesis_id?: string
): Promise<Hypothesis[]> {
  let query = `
    SELECT 
      hypothesis_id, hypothesis_statement,
      confidence_before, confidence_after, confidence_change,
      status
    FROM hypothesis_history
    WHERE session_id = ?
  `
  const bindings: any[] = [session_id]
  
  if (hypothesis_id) {
    query += ` AND hypothesis_id = ?`
    bindings.push(hypothesis_id)
  }
  
  query += ` ORDER BY created_at ASC`
  
  const result = await db.prepare(query).bind(...bindings).all<{
    hypothesis_id: string
    hypothesis_statement: string
    confidence_before: number | null
    confidence_after: number
    confidence_change: number | null
    status: HypothesisStatus
  }>()
  
  return (result.results || []).map(row => ({
    id: row.hypothesis_id,
    statement: row.hypothesis_statement,
    confidence_before: row.confidence_before || 0,
    confidence_after: row.confidence_after,
    confidence_change: row.confidence_change || 0,
    supporting_facts: [],
    contradicting_facts: [],
    status: row.status,
  }))
}

// ============================================
// 신호 추출 (답변에서 preferences/constraints 등 추출)
// ============================================

export function extractSignalsFromAnswer(
  answer: string,
  question_type?: FollowupPurpose
): ExtractedSignals {
  const signals: ExtractedSignals = {
    preferences: [],
    constraints: [],
    motivations: [],
    dislikes: [],
  }
  
  const lowerAnswer = answer.toLowerCase()
  
  // 선호도 키워드
  const preferenceKeywords: Record<string, string> = {
    '워라밸': 'wlb',
    '재택': 'remote',
    '원격': 'remote',
    '성장': 'growth',
    '안정': 'stability',
    '수입': 'income',
    '연봉': 'income',
    '의미': 'meaning',
    '보람': 'meaning',
    '창의': 'creative',
    '분석': 'analytical',
    '혼자': 'solo',
    '팀': 'teamwork',
  }
  
  for (const [keyword, signal] of Object.entries(preferenceKeywords)) {
    if (lowerAnswer.includes(keyword)) {
      signals.preferences?.push(signal)
    }
  }
  
  // 제약 키워드
  const constraintKeywords: Record<string, string> = {
    '야근': 'no_overtime',
    '출장': 'no_travel',
    '교대': 'no_shift',
    '주말': 'no_weekend',
    '자격증': 'license_issue',
    '학력': 'degree_issue',
  }
  
  for (const [keyword, signal] of Object.entries(constraintKeywords)) {
    // 부정적 맥락에서 언급되면 제약으로 추가
    if (lowerAnswer.includes(keyword) && 
        (lowerAnswer.includes('싫') || lowerAnswer.includes('안') || 
         lowerAnswer.includes('못') || lowerAnswer.includes('어려'))) {
      signals.constraints?.push(signal)
    }
  }
  
  // 중복 제거
  signals.preferences = [...new Set(signals.preferences)]
  signals.constraints = [...new Set(signals.constraints)]
  signals.motivations = [...new Set(signals.motivations)]
  signals.dislikes = [...new Set(signals.dislikes)]
  
  return signals
}

// ============================================
// 프로필 빌드 (대화 턴들로부터 프로필 생성)
// ============================================

export async function buildProfileFromTurns(
  db: D1Database,
  session_id: string,
  previous_profile?: ProfileSnapshot
): Promise<ProfileSnapshot> {
  const turns = await getConversationTurns(db, session_id)
  
  // 기본 구조
  const profile: ProfileSnapshot = {
    raw_answers_summary: {
      total_turns: turns.length,
      intake_turns: turns.filter(t => 
        t.turn_type === 'universal_intake' || 
        t.turn_type === 'stage_intake' ||
        t.turn_type === 'deep_intake'
      ).length,
      followup_turns: turns.filter(t => 
        t.turn_type === 'followup_v2' || 
        t.turn_type === 'followup_v3'
      ).length,
    },
    extracted_signals: {
      preferences: [],
      constraints: [],
      motivations: [],
      dislikes: [],
    },
    hypotheses: [],
    newly_confirmed: [],
    uncertainty_reduced: [],
    pending_clarifications: [],
  }
  
  // 모든 턴에서 신호 수집
  for (const turn of turns) {
    if (turn.extracted_signals) {
      profile.extracted_signals.preferences = [
        ...new Set([
          ...profile.extracted_signals.preferences!,
          ...(turn.extracted_signals.preferences || [])
        ])
      ]
      profile.extracted_signals.constraints = [
        ...new Set([
          ...profile.extracted_signals.constraints!,
          ...(turn.extracted_signals.constraints || [])
        ])
      ]
      profile.extracted_signals.motivations = [
        ...new Set([
          ...profile.extracted_signals.motivations!,
          ...(turn.extracted_signals.motivations || [])
        ])
      ]
      profile.extracted_signals.dislikes = [
        ...new Set([
          ...profile.extracted_signals.dislikes!,
          ...(turn.extracted_signals.dislikes || [])
        ])
      ]
    }
  }
  
  // 가설 업데이트 (이전 프로필 대비)
  profile.hypotheses = updateHypotheses(profile.extracted_signals, previous_profile?.hypotheses)
  
  // 새로 확정된 사항 (followup_v3에서)
  const v3Turns = turns.filter(t => t.turn_type === 'followup_v3')
  for (const turn of v3Turns) {
    if (turn.question_type === 'reality_constraint') {
      profile.newly_confirmed.push({
        fact_key: turn.question_id || 'unknown',
        value: turn.answer_raw,
        turn_number: turn.turn_number,
      })
    }
  }
  
  // 불확실성 감소 계산
  if (previous_profile) {
    for (const hypothesis of profile.hypotheses) {
      const prev = previous_profile.hypotheses.find(h => h.id === hypothesis.id)
      if (prev && hypothesis.confidence_after > prev.confidence_after) {
        profile.uncertainty_reduced.push({
          dimension: hypothesis.id,
          before_uncertainty: 1 - prev.confidence_after,
          after_uncertainty: 1 - hypothesis.confidence_after,
          resolved_by_turn: turns[turns.length - 1]?.turn_number || 0,
        })
      }
    }
  }
  
  // 다음에 확인할 사항
  const uncheckedDimensions = ['wlb', 'income', 'growth', 'remote', 'location']
    .filter(d => !profile.extracted_signals.preferences?.includes(d) && 
                 !profile.extracted_signals.constraints?.includes(`no_${d}`))
  
  for (const dimension of uncheckedDimensions.slice(0, 3)) {
    profile.pending_clarifications.push({
      question: `${dimension}에 대한 선호도를 확인해야 합니다`,
      priority: 'medium',
      affected_dimensions: [dimension],
    })
  }
  
  return profile
}

// ============================================
// 가설 업데이트
// ============================================

function updateHypotheses(
  signals: ExtractedSignals,
  previousHypotheses?: Hypothesis[]
): Hypothesis[] {
  const hypotheses: Hypothesis[] = []
  const prevMap = new Map(previousHypotheses?.map(h => [h.id, h]) || [])
  
  // 가설 1: 작업 스타일
  const workstyleHypothesis = createWorkstyleHypothesis(signals, prevMap.get('h_workstyle'))
  if (workstyleHypothesis) hypotheses.push(workstyleHypothesis)
  
  // 가설 2: 우선순위
  const priorityHypothesis = createPriorityHypothesis(signals, prevMap.get('h_priority'))
  if (priorityHypothesis) hypotheses.push(priorityHypothesis)
  
  // 가설 3: 제약 사항
  const constraintHypothesis = createConstraintHypothesis(signals, prevMap.get('h_constraint'))
  if (constraintHypothesis) hypotheses.push(constraintHypothesis)
  
  return hypotheses
}

function createWorkstyleHypothesis(
  signals: ExtractedSignals,
  previous?: Hypothesis
): Hypothesis | null {
  const hasSolo = signals.preferences?.includes('solo')
  const hasTeam = signals.preferences?.includes('teamwork')
  
  if (!hasSolo && !hasTeam) {
    if (previous) {
      return { ...previous, status: 'unchanged' }
    }
    return null
  }
  
  const statement = hasSolo 
    ? '사용자는 독립적인 업무 환경을 선호한다'
    : '사용자는 팀 협업 환경을 선호한다'
  
  const newConfidence = (hasSolo || hasTeam) ? 0.7 : 0.5
  const prevConfidence = previous?.confidence_after || 0.5
  
  return {
    id: 'h_workstyle',
    statement,
    confidence_before: prevConfidence,
    confidence_after: newConfidence,
    confidence_change: newConfidence - prevConfidence,
    supporting_facts: hasSolo ? ['pref:solo'] : (hasTeam ? ['pref:teamwork'] : []),
    contradicting_facts: [],
    status: previous 
      ? (newConfidence > prevConfidence ? 'strengthened' : 
         newConfidence < prevConfidence ? 'weakened' : 'unchanged')
      : 'new',
  }
}

function createPriorityHypothesis(
  signals: ExtractedSignals,
  previous?: Hypothesis
): Hypothesis | null {
  const priorities = ['growth', 'income', 'wlb', 'stability', 'meaning']
  const found = priorities.find(p => signals.preferences?.includes(p))
  
  if (!found) {
    if (previous) {
      return { ...previous, status: 'unchanged' }
    }
    return null
  }
  
  const labels: Record<string, string> = {
    growth: '성장 가능성',
    income: '수입/보상',
    wlb: '워라밸',
    stability: '안정성',
    meaning: '의미/보람',
  }
  
  const statement = `사용자는 ${labels[found]}을 가장 중시한다`
  const newConfidence = 0.75
  const prevConfidence = previous?.confidence_after || 0.5
  
  return {
    id: 'h_priority',
    statement,
    confidence_before: prevConfidence,
    confidence_after: newConfidence,
    confidence_change: newConfidence - prevConfidence,
    supporting_facts: [`pref:${found}`],
    contradicting_facts: [],
    status: previous
      ? (newConfidence > prevConfidence ? 'strengthened' :
         newConfidence < prevConfidence ? 'weakened' : 'unchanged')
      : 'new',
  }
}

function createConstraintHypothesis(
  signals: ExtractedSignals,
  previous?: Hypothesis
): Hypothesis | null {
  const constraints = signals.constraints || []
  
  if (constraints.length === 0) {
    if (previous) {
      return { ...previous, status: 'unchanged' }
    }
    return null
  }
  
  const statement = `사용자에게는 ${constraints.join(', ')} 제약이 있다`
  const newConfidence = 0.8
  const prevConfidence = previous?.confidence_after || 0.5
  
  return {
    id: 'h_constraint',
    statement,
    confidence_before: prevConfidence,
    confidence_after: newConfidence,
    confidence_change: newConfidence - prevConfidence,
    supporting_facts: constraints.map(c => `constraint:${c}`),
    contradicting_facts: [],
    status: previous
      ? (newConfidence > prevConfidence ? 'strengthened' :
         newConfidence < prevConfidence ? 'weakened' : 'unchanged')
      : 'new',
  }
}




