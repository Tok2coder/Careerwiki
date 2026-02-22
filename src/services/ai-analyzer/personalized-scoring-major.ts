// ============================================
// Personalized Scoring Engine for MAJOR (전공)
// User × Major Cross-Matching for Like/Can Base Scores
// ============================================
// personalized-scoring.ts의 전공 버전
// 기존 직업 스코어링 함수를 수정하지 않고, 전공 전용 함수만 정의

import type { MajorAttributes } from './types'

// ============================================
// Like Score: Interest/Value/Workstyle × Major Attributes
// ============================================

interface WeightedScore {
  score: number
  weight: number
}

// 흥미 → 전공 속성 매핑
const INTEREST_MAJOR_MAP: Record<string, { attrs: Record<string, number> }> = {
  data_numbers:     { attrs: { math_intensity: 0.7, academic_rigor: 0.3 } },
  problem_solving:  { attrs: { academic_rigor: 0.5, math_intensity: 0.3, lab_practical: 0.2 } },
  creating:         { attrs: { creativity: 0.8, autonomy: 0.2 } },
  creative:         { attrs: { creativity: 0.8, autonomy: 0.2 } },
  helping_teaching: { attrs: { social_interaction: 0.7, reading_writing: 0.3 } },
  helping:          { attrs: { social_interaction: 0.6, teamwork: 0.2, reading_writing: 0.2 } },
  helping_feedback: { attrs: { social_interaction: 0.5, teamwork: 0.3, lab_practical: 0.2 } },
  organizing:       { attrs: { teamwork: 0.4, reading_writing: 0.3, career_breadth: 0.3 } },
  influencing:      { attrs: { social_interaction: 0.5, career_breadth: 0.3, career_income_potential: 0.2 } },
  tech:             { attrs: { lab_practical: 0.5, math_intensity: 0.3, academic_rigor: 0.2 } },
  research:         { attrs: { academic_rigor: 0.7, autonomy: 0.3 } },
  design:           { attrs: { creativity: 0.7, lab_practical: 0.3 } },
  art:              { attrs: { creativity: 0.9, autonomy: 0.1 } },
  routine:          { attrs: { stability: 0.5, teamwork: 0.3, career_breadth: 0.2 } },
}

// 가치 → 전공 속성 매핑
const VALUE_MAJOR_MAP: Record<string, { attrs: Record<string, number>, baseAdd?: number }> = {
  growth:      { attrs: { career_breadth: 0.5, growth_outlook: 0.5 } },
  stability:   { attrs: { stability: 0.5, employment_rate: 0.5 } },
  income:      { attrs: { career_income_potential: 1.0 } },
  wlb:         { attrs: { career_breadth: 0.3, stability: 0.4, autonomy: 0.3 } },
  autonomy:    { attrs: { autonomy: 0.6, academic_rigor: 0.4 } },
  meaning:     { attrs: { social_interaction: 0.3, career_breadth: 0.3 }, baseAdd: 25 },
  recognition: { attrs: { career_income_potential: 0.4, competition_level: 0.3, academic_rigor: 0.3 } },
  expertise:   { attrs: { academic_rigor: 0.6, autonomy: 0.4 } },
  creativity:  { attrs: { creativity: 1.0 } },
}

// 업무스타일 → 전공 속성 매핑 (전공에서의 학습 스타일)
const WORKSTYLE_MAJOR_MAP: Record<string, { attrs: Record<string, number> }> = {
  solo_deep:      { attrs: { autonomy: 0.6, academic_rigor: 0.4 } },
  solo:           { attrs: { autonomy: 0.7, reading_writing: 0.3 } },
  team_harmony:   { attrs: { teamwork: 0.6, social_interaction: 0.4 } },
  team:           { attrs: { teamwork: 0.7, social_interaction: 0.3 } },
  structured:     { attrs: { lab_practical: 0.4, stability: 0.3, employment_rate: 0.3 } },
  flexible:       { attrs: { creativity: 0.4, autonomy: 0.3, career_breadth: 0.3 } },
}

// 지속 동기 → 전공 속성 매핑
const ANCHOR_MAJOR_MAP: Record<string, { attrs: Record<string, number>, baseAdd?: number }> = {
  reward_anchor:    { attrs: { career_income_potential: 1.0 } },
  growth_anchor:    { attrs: { career_breadth: 0.5, growth_outlook: 0.5 } },
  stability_anchor: { attrs: { stability: 0.5, employment_rate: 0.5 } },
  meaning_anchor:   { attrs: { social_interaction: 0.4 }, baseAdd: 25 },
  people_anchor:    { attrs: { social_interaction: 0.6, teamwork: 0.4 } },
  passion_anchor:   { attrs: { creativity: 0.5, autonomy: 0.5 } },
}

// 에너지 소모 → 전공 페널티 조건
const ENERGY_DRAIN_MAJOR_PENALTIES: Record<string, (major: Record<string, any>) => number> = {
  people_drain: (major) =>
    (major.social_interaction || 0) > 70 ? -15 :
    (major.social_interaction || 0) > 50 ? -8 : 0,
  cognitive_drain: (major) =>
    (major.academic_rigor || 0) > 70 ? -10 : 0,
  time_pressure_drain: (major) =>
    (major.competition_level || 0) > 80 ? -10 : 0,
  repetition_drain: (major) =>
    ((major.lab_practical || 0) > 70 && (major.creativity || 0) < 30) ? -10 : 0,
  routine_drain: (major) =>
    ((major.reading_writing || 0) > 70 && (major.creativity || 0) < 30) ? -8 : 0,
  uncertainty_drain: (major) =>
    (major.autonomy || 0) > 70 ? -8 : 0,
  bureaucracy_drain: (major) =>
    (major.teamwork || 0) > 80 ? -5 : 0,
}

function calculateMajorLikeScore(major: Record<string, any>, mm: any): number {
  const scores: WeightedScore[] = []

  // 1) 흥미 매칭 (weight: 1.0 each)
  const interests = mm.interest_top || []
  for (const token of interests) {
    const mapping = INTEREST_MAJOR_MAP[token]
    if (mapping) {
      let score = 0
      for (const [attr, w] of Object.entries(mapping.attrs)) {
        score += (major[attr] || 0) * w
      }
      scores.push({ score, weight: 1.0 })
    }
  }

  // 2) 가치 매칭 (weight: 0.8 each)
  const values = mm.value_top || []
  for (const token of values) {
    const mapping = VALUE_MAJOR_MAP[token]
    if (mapping) {
      let score = mapping.baseAdd || 0
      for (const [attr, w] of Object.entries(mapping.attrs)) {
        score += (major[attr] || 0) * w
      }
      scores.push({ score, weight: 0.8 })
    }
  }

  // 3) 학습스타일 매칭 (weight: 0.5 each)
  const workstyles = mm.workstyle_top || []
  for (const token of workstyles) {
    const mapping = WORKSTYLE_MAJOR_MAP[token]
    if (mapping) {
      let score = 0
      for (const [attr, w] of Object.entries(mapping.attrs)) {
        score += (major[attr] || 0) * w
      }
      scores.push({ score, weight: 0.5 })
    }
  }

  // 4) 지속 동기 매칭 (weight: 0.3)
  const anchor = mm.persistence_anchor
  if (anchor) {
    const mapping = ANCHOR_MAJOR_MAP[anchor]
    if (mapping) {
      let score = mapping.baseAdd || 0
      for (const [attr, w] of Object.entries(mapping.attrs)) {
        score += (major[attr] || 0) * w
      }
      scores.push({ score, weight: 0.3 })
    }
  }

  // Weighted average
  if (scores.length === 0) {
    return Math.round(
      ((major.career_breadth || 50) + (major.growth_outlook || 50) +
       (major.stability || 50) + (major.employment_rate || 50)) / 4
    )
  }

  const totalWeight = scores.reduce((sum, s) => sum + s.weight, 0)
  let rawLike = scores.reduce((sum, s) => sum + s.score * s.weight, 0) / totalWeight

  // 5) 에너지 소모 페널티
  const drains = mm.energy_drain_flags || []
  for (const drain of drains) {
    const penaltyFn = ENERGY_DRAIN_MAJOR_PENALTIES[drain]
    if (penaltyFn) {
      rawLike += penaltyFn(major)
    }
  }

  // 6) 학습 스타일 미스매치 페널티
  const ws = mm.workstyle_top || []
  if (ws.some((w: string) => w.includes('solo'))) {
    const socialInt = major.social_interaction || 0
    if (socialInt > 80) rawLike -= 12
    else if (socialInt > 60) rawLike -= 6
  }

  // 7) 이론 vs 실습 미스매치
  const interestTokens = mm.interest_top || []
  const isTheoreticalUser = interestTokens.includes('research') ||
    interestTokens.includes('data_numbers') || interestTokens.includes('problem_solving')
  const labScore = major.lab_practical || 0
  const rigorScore = major.academic_rigor || 0

  if (isTheoreticalUser) {
    // 이론 성향 유저 + 실습 중심 전공 → 페널티
    if (labScore > 70 && rigorScore < 40) {
      const gap = labScore - rigorScore
      rawLike -= Math.min(20, Math.round(gap * 0.4))
    }
  }

  return Math.max(0, Math.min(100, Math.round(rawLike)))
}

// ============================================
// Can Score: Strength/Adaptability × Major Requirements
// ============================================

// 강점 → 전공 요구 속성 매핑
const STRENGTH_MAJOR_MAP: Record<string, { attr?: string, universal?: number }> = {
  analytical:           { attr: 'math_intensity' },
  creative:             { attr: 'creativity' },
  communication:        { attr: 'social_interaction' },
  structured_execution: { attr: 'lab_practical' },
  persistence:          { universal: 5 },
  fast_learning:        { universal: 8 },
}

// 전공의 degree_level에 따른 페널티 (학사로 충분한지)
const DEGREE_LEVEL_PENALTY: Record<string, number> = {
  bachelor: 0,
  master_preferred: -10,
  phd_required: -25,
}

// 적응성 보너스 (전공용 - 학습 의지 중심)
const SACRIFICE_MAJOR_BONUS: Record<string, number> = {
  willing_to_study: 8,     // 학습 의지 → 전공에서 더 중요
  field_change_ok: 5,
  low_initial_income: 3,
  long_hours_ok: 3,
  unstable_hours: 2,
  ignore_social_pressure: 1,
  no_sacrifice: -5,
}

// 회복탄력성 보너스
const RESILIENCE_MAJOR_BONUS: Record<string, number> = {
  analyze_improve: 5,     // 분석 후 개선 → 학업에서 중요
  try_different: 3,
  seek_support: 2,
  pause_on_failure: 0,
  emotionally_affected: -3,
}

function calculateMajorCanScore(major: Record<string, any>, mm: any): number {
  let can = 30  // 기본 베이스

  // 1) 강점 매칭 (비례 스코어링)
  const strengths = mm.strength_top || []
  for (const token of strengths) {
    const mapping = STRENGTH_MAJOR_MAP[token]
    if (!mapping) continue

    if (mapping.universal !== undefined) {
      can += mapping.universal
    } else if (mapping.attr) {
      const majorValue = major[mapping.attr] || 0
      can += Math.round((majorValue / 100) * 30)
    }
  }

  // 2) 적응성 보너스
  const sacrifices = mm.sacrifice_flags || []
  for (const flag of sacrifices) {
    can += SACRIFICE_MAJOR_BONUS[flag] || 0
  }

  // 3) 회복탄력성 보너스
  const failureResponse = mm.failure_response
  if (failureResponse) {
    can += RESILIENCE_MAJOR_BONUS[failureResponse] || 0
  }

  // 4) 전공 degree_level 페널티
  const degreeLevel = major.degree_level || 'bachelor'
  can += DEGREE_LEVEL_PENALTY[degreeLevel] || 0

  // willing_to_study가 있으면 degree 페널티 완화
  if (sacrifices.includes('willing_to_study')) {
    if (degreeLevel === 'master_preferred') can += 5
    if (degreeLevel === 'phd_required') can += 10
  }

  // 5) 배경에 따른 보너스
  const backgrounds = mm.background_flags || []
  if (backgrounds.includes('research_academic')) {
    can += 8  // 학문적 배경 → 전공 적합도 보너스
  }

  // 6) 경쟁률 페널티 (높은 경쟁률 전공 → Can 하락)
  const competition = major.competition_level || 50
  if (competition > 80) can -= 10
  else if (competition > 70) can -= 5

  // 7) 주요 속성 미스매치 페널티
  const strengthAttrs = strengths
    .map((t: string) => STRENGTH_MAJOR_MAP[t]?.attr)
    .filter(Boolean) as string[]
  if (strengthAttrs.length > 0) {
    const attrCandidates = ['math_intensity', 'creativity', 'social_interaction', 'lab_practical', 'reading_writing']
    let dominantAttr = ''
    let dominantVal = 0
    for (const attr of attrCandidates) {
      const val = major[attr] || 0
      if (val > dominantVal) {
        dominantVal = val
        dominantAttr = attr
      }
    }
    // 전공의 지배적 속성이 유저 강점에 없으면 페널티
    if (dominantAttr && dominantVal >= 60 && !strengthAttrs.includes(dominantAttr)) {
      can -= Math.round((dominantVal - 50) * 0.5)  // 최대 -25점
    }
  }

  return Math.max(5, Math.min(100, Math.round(can)))
}

// ============================================
// Main Export
// ============================================

export function calculateMajorPersonalizedBaseScores(
  majorAttrs: Record<string, any>,
  mm?: any
): { like: number; can: number } {
  // mm이 없으면 기본 공식 fallback
  if (!mm) {
    const like = Math.round(
      ((majorAttrs.career_breadth || 50) + (majorAttrs.growth_outlook || 50) +
       (majorAttrs.stability || 50) + (majorAttrs.employment_rate || 50)) / 4
    )
    const can = Math.round(
      ((majorAttrs.teamwork || 50) + ((majorAttrs.math_intensity || 50) * 0.7) + (majorAttrs.creativity || 50)) / 3
    )
    return { like, can }
  }

  return {
    like: calculateMajorLikeScore(majorAttrs, mm),
    can: calculateMajorCanScore(majorAttrs, mm),
  }
}
