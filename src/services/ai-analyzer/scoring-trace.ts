// src/services/ai-analyzer/scoring-trace.ts
// ============================================
// 결정변수 산출 + 확신도 계산 (P1)
// ============================================
// P1-1: scoring_trace - 결정변수 산출 근거 (LLM이 아닌 엔진이 계산)
// P1-2: confidence_score - uncertainty_reduction 기반 계산
// P0-10: followup.* fact_key 기반 점수화 제거, source='followup' 보정치만

import type { AnalyzerFact } from './fact-saver'

// ============================================
// Types
// ============================================
export interface ScoringTrace {
  // 각 후보 직업별 점수 breakdown
  candidates: Array<{
    job_id: string
    job_name: string
    total_score: number
    // 어떤 fact가 점수에 얼마나 기여했는지
    feature_contributions: Array<{
      fact_key: string
      user_value: string
      weight: number // 이 fact의 가중치
      contribution: number // 최종 점수 기여분
    }>
  }>

  // 결정변수 산출: "이 fact를 제거하면 순위가 얼마나 바뀌나"
  decision_variables: Array<{
    fact_key: string
    rank_change_if_removed: number // 순위 변동 폭 (클수록 중요)
    affected_jobs: string[] // 영향받는 직업들
  }>
}

export interface KeyDecisionVariable {
  fact_key: string
  question_summary: string // "워라밸 vs 성장 트레이드오프"
  user_answer: string // "워라밸 선택"
  rank_change_if_removed: number // 순위 변동 폭
  alternative_outcome: string // "다르게 답했다면 A, B가 추천됐을 거예요"
  importance_score: number // 0~1
}

export interface ConfidenceResult {
  score: number // 0~1
  level: string // '매우 높음' | '높음' | '보통' | '기본'
  description: string
}

// ============================================
// P0-10: Fact Uncertainty Reduction 맵
// ============================================
// - 표준 fact_key 사전(STATE/CONSTRAINT/TRANSITION/ANCHOR)만 포함
// - followup.* 제거됨
const FACT_UNCERTAINTY_REDUCTION: Record<string, number> = {
  // 5축 상태 좌표
  'state.role_identity': 0.15,
  'state.career_stage_years': 0.1,
  'state.transition_status': 0.12,
  'state.skill_level': 0.08,
  'state.constraint.*': 0.05, // 제약은 개당 0.05

  // 전이 신호
  'transition.desired_type': 0.1,
  'transition.motivation_primary': 0.12,
  'transition.blocker': 0.05,
  'transition.timeline': 0.08,
  'transition.time_invest_hours_bucket': 0.06,

  // identity_anchor (가장 강력!)
  'anchor.non_negotiable_value': 0.2,
  'anchor.desired_emotion': 0.15,
  'anchor.dealbreaker': 0.12,

  // Deep intake
  'profile.mbti': 0.05,
  'discovery.best_moment': 0.08,
  'discovery.worst_moment': 0.08,
  'motivation.change_reason': 0.06,
  'priority.top1': 0.1,

  // Universal answers
  'profile.*': 0.04,
}

// ============================================
// 확신도 계산 (P0-10 반영)
// v3.10.6: roundAnswers + topScoreSpread 반영하여 유저별 차별화
// ============================================
export function calculateConfidenceScore(
  facts: Array<{ fact_key: string; confidence_weight?: number; source?: string; value_json?: string }>,
  roundAnswerCount?: number,
  topScores?: number[]
): ConfidenceResult {
  const baseline = 0.3 // 최소 신뢰도

  // P0-10: source='followup' facts는 별도 처리
  const standardFacts = facts.filter((f) => f.source !== 'followup')
  const followupFacts = facts.filter((f) => f.source === 'followup')

  let totalReduction = 0

  // 표준 fact_key 사전 기반 점수 계산 (P0-10: followup 제외)
  for (const fact of standardFacts) {
    let reduction = 0
    for (const [pattern, value] of Object.entries(FACT_UNCERTAINTY_REDUCTION)) {
      if (pattern.endsWith('*')) {
        if (fact.fact_key.startsWith(pattern.slice(0, -1))) {
          reduction = value
          break
        }
      } else if (fact.fact_key === pattern) {
        reduction = value
        break
      }
    }

    // confidence_weight 반영 (resume_parsed=1.3 등)
    const weight = fact.confidence_weight || 1.0
    totalReduction += reduction * weight
  }

  // P0-10: source='followup' 개수에 따른 보정치 (개당 +0.04, 최대 +0.15)
  const followupBonus = Math.min(followupFacts.length * 0.04, 0.15)

  // v3.11: fact 수 보너스
  const factCountBonus = Math.min(facts.length * 0.008, 0.10)

  // v3.11: 심층 질문 답변 수 반영 (개당 +0.04, 최대 +0.16)
  const roundBonus = Math.min((roundAnswerCount || 0) * 0.04, 0.16)

  // v3.12: 점수 분포 반영 — 전체 추천 직업의 분포 사용 (유저별 차별화)
  let spreadBonus = 0
  if (topScores && topScores.length >= 3) {
    // 전체 점수의 표준편차 사용 (top3만의 max-min 대신)
    const mean = topScores.reduce((s, v) => s + v, 0) / topScores.length
    const variance = topScores.reduce((s, v) => s + (v - mean) ** 2, 0) / topScores.length
    const std = Math.sqrt(variance)
    // std 5 → +0.05, std 10 → +0.10, std 15+ → +0.15
    spreadBonus = Math.min(std * 0.01, 0.15)

    // 1위와 2위 갭 보너스 (명확한 1순위 = 높은 확신)
    const sorted = [...topScores].sort((a, b) => b - a)
    const topGap = sorted[0] - sorted[1]
    if (topGap > 2) {
      spreadBonus += Math.min((topGap - 2) * 0.008, 0.08)
    }
  } else if (topScores && topScores.length >= 2) {
    const spread = Math.max(...topScores) - Math.min(...topScores)
    spreadBonus = Math.min(spread * 0.004, 0.12)
  }

  // v3.12: 선택 다양성 보너스 — 배열형 fact에서 선택된 항목 수 기반
  // 유저A: interest 2개, strength 1개 = 3개 → 정보 적음
  // 유저B: interest 3개, strength 2개, value 2개 = 7개 → 정보 많음
  let diversityBonus = 0
  let totalSelections = 0
  for (const f of facts) {
    if (!f.value_json) continue
    try {
      const parsed = JSON.parse(f.value_json)
      if (Array.isArray(parsed)) {
        totalSelections += parsed.length
      }
    } catch { /* non-JSON fact, skip */ }
  }
  // 3개(기본) → +0, 8개(보통) → +0.05, 15개+(꼼꼼) → +0.12
  if (totalSelections > 3) {
    diversityBonus = Math.min((totalSelections - 3) * 0.01, 0.12)
  }

  // 최종 신뢰도
  const score = Math.min(
    baseline + totalReduction + followupBonus + factCountBonus + roundBonus + spreadBonus + diversityBonus,
    0.95
  )


  return {
    score,
    ...getConfidenceLevel(score),
  }
}

// 확신도 등급 결정
function getConfidenceLevel(score: number): { level: string; description: string } {
  if (score >= 0.85) return { level: '매우 높음', description: '상세한 답변으로 정확한 추천이 가능해요' }
  if (score >= 0.7) return { level: '높음', description: '좋은 답변이에요. 추천을 믿어도 좋아요' }
  if (score >= 0.55) return { level: '보통', description: '추가 질문에 답하시면 더 정확해져요' }
  return { level: '기본', description: '더 솔직하게 답해주시면 맞춤 추천이 가능해요' }
}

// ============================================
// 결정변수 산출 (P1-1)
// ============================================
export function extractKeyDecisionVariables(
  scoringTrace: ScoringTrace,
  factLabels: Record<string, string>, // fact_key → 질문 요약
  topK: number = 3
): KeyDecisionVariable[] {
  // 순위 변동 폭 기준 상위 N개 추출
  return scoringTrace.decision_variables
    .sort((a, b) => b.rank_change_if_removed - a.rank_change_if_removed)
    .slice(0, topK)
    .map((dv) => ({
      fact_key: dv.fact_key,
      question_summary: factLabels[dv.fact_key] || dv.fact_key,
      user_answer: '', // 실제 사용 시 facts에서 추출
      rank_change_if_removed: dv.rank_change_if_removed,
      alternative_outcome: `다르게 답했다면 ${dv.affected_jobs.slice(0, 2).join(', ')}가 추천됐을 거예요`,
      importance_score: Math.min(dv.rank_change_if_removed / 5, 1),
    }))
}

// ============================================
// Scoring Trace 생성 (간이 버전)
// ============================================
export interface ScoredJobForTrace {
  job_id: string
  job_name: string
  final_score: number
  // 점수 breakdown
  score_breakdown?: Record<string, number>
}

export function createScoringTrace(
  candidates: ScoredJobForTrace[],
  facts: Array<{ fact_key: string; value_json: string }>
): ScoringTrace {
  // 각 후보별 feature contributions 계산
  const candidateTraces = candidates.slice(0, 10).map((job) => {
    const contributions: ScoringTrace['candidates'][0]['feature_contributions'] = []

    // score_breakdown이 있으면 활용
    if (job.score_breakdown) {
      for (const [factKey, contribution] of Object.entries(job.score_breakdown)) {
        const fact = facts.find((f) => f.fact_key === factKey)
        contributions.push({
          fact_key: factKey,
          user_value: fact?.value_json || '',
          weight: 1.0,
          contribution,
        })
      }
    }

    return {
      job_id: job.job_id,
      job_name: job.job_name,
      total_score: job.final_score,
      feature_contributions: contributions,
    }
  })

  // 결정변수 계산 (간이 버전: 상위 3개와 나머지의 점수 차이 분석)
  const decisionVariables: ScoringTrace['decision_variables'] = []

  // 각 fact가 결과에 미치는 영향 추정
  const factImpacts = new Map<string, { rank_change: number; affected_jobs: string[] }>()

  for (const fact of facts) {
    // 이 fact가 영향을 줬을 수 있는 직업들 추정
    const affectedJobs = candidates
      .filter((c) => c.score_breakdown?.[fact.fact_key])
      .map((c) => c.job_name)

    if (affectedJobs.length > 0) {
      // 간이 추정: affected jobs 수에 비례한 rank_change
      factImpacts.set(fact.fact_key, {
        rank_change: Math.min(affectedJobs.length, 5),
        affected_jobs: affectedJobs,
      })
    }
  }

  // 결정변수 배열로 변환
  for (const [fact_key, impact] of factImpacts) {
    decisionVariables.push({
      fact_key,
      rank_change_if_removed: impact.rank_change,
      affected_jobs: impact.affected_jobs,
    })
  }

  return {
    candidates: candidateTraces,
    decision_variables: decisionVariables,
  }
}

// ============================================
// Fact Labels (질문 요약용)
// ============================================
export const DEFAULT_FACT_LABELS: Record<string, string> = {
  'state.role_identity': '현재 역할/상황',
  'state.career_stage_years': '경력 연차',
  'state.transition_status': '전환 상태',
  'state.skill_level': '관심 분야 숙련도',
  'state.constraint.time': '시간 제약',
  'state.constraint.money': '경제적 제약',
  'state.constraint.location': '장소 제약',
  'state.constraint.family': '가족 상황',
  'state.constraint.health': '건강/컨디션',
  'state.constraint.qualification': '자격 제약',
  'transition.desired_type': '원하는 커리어 발전 방식',
  'transition.motivation_primary': '변화 동기',
  'transition.blocker': '걱정되는 점',
  'transition.timeline': '변화 타임라인',
  'transition.time_invest_hours_bucket': '투자 가능 시간',
  'anchor.non_negotiable_value': '절대 포기 못하는 가치',
  'anchor.desired_emotion': '일에서 느끼고 싶은 감정',
  'anchor.dealbreaker': '절대 안 되는 조건',
}
