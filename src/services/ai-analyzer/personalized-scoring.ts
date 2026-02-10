// ============================================
// Personalized Scoring Engine
// User × Job Cross-Matching for Like/Can Base Scores
// ============================================

// ============================================
// Like Score: Interest/Value/Workstyle × Job Attributes
// ============================================

interface WeightedScore {
  score: number
  weight: number
}

// 흥미 → 직업 속성 매핑
const INTEREST_JOB_MAP: Record<string, { attrs: Record<string, number> }> = {
  data_numbers:     { attrs: { analytical: 0.7, execution: 0.3 } },
  problem_solving:  { attrs: { analytical: 0.6, creative: 0.2, execution: 0.2 } },
  creating:         { attrs: { creative: 0.8, analytical: 0.2 } },
  helping_teaching: { attrs: { people_facing: 0.7, teamwork: 0.3 } },
  organizing:       { attrs: { execution: 0.6, teamwork: 0.4 } },
  influencing:      { attrs: { people_facing: 0.5, execution: 0.3, income: 0.2 } },
}

// 가치 → 직업 속성 매핑
const VALUE_JOB_MAP: Record<string, { attrs: Record<string, number>, baseAdd?: number }> = {
  growth:      { attrs: { growth: 1.0 } },
  stability:   { attrs: { stability: 1.0 } },
  income:      { attrs: { income: 1.0 } },
  autonomy:    { attrs: { solo_deep: 0.6, wlb: 0.4 } },
  meaning:     { attrs: { people_facing: 0.3, growth: 0.3 }, baseAdd: 25 },
  recognition: { attrs: { income: 0.4, growth: 0.3, people_facing: 0.3 } },
}

// 업무 스타일 → 직업 속성 매핑
const WORKSTYLE_JOB_MAP: Record<string, { attrs: Record<string, number> }> = {
  solo:       { attrs: { solo_deep: 1.0 } },
  team:       { attrs: { teamwork: 1.0 } },
  structured: { attrs: { execution: 0.6, stability: 0.4 } },
  flexible:   { attrs: { creative: 0.5, wlb: 0.5 } },
}

// 지속 동기 → 직업 속성 매핑
const ANCHOR_JOB_MAP: Record<string, { attrs: Record<string, number>, baseAdd?: number }> = {
  reward_anchor:    { attrs: { income: 1.0 } },
  growth_anchor:    { attrs: { growth: 1.0 } },
  stability_anchor: { attrs: { stability: 1.0 } },
  meaning_anchor:   { attrs: { people_facing: 0.4 }, baseAdd: 25 },
  people_anchor:    { attrs: { people_facing: 0.6, teamwork: 0.4 } },
}

// 에너지 소모 → 페널티 조건
const ENERGY_DRAIN_PENALTIES: Record<string, (job: Record<string, any>) => number> = {
  people_drain: (job) => (job.people_facing || 0) > 70 ? -15 : (job.people_facing || 0) > 50 ? -8 : 0,
  cognitive_drain: (job) => (job.analytical || 0) > 70 ? -10 : 0,
  time_pressure_drain: (job) => {
    const wh = job.work_hours || 'regular'
    if (wh === 'always_overtime' || wh === 'overtime_heavy') return -15
    if (wh === 'overtime_frequent' || wh === 'overtime_some') return -8
    return 0
  },
  repetition_drain: (job) => ((job.execution || 0) > 70 && (job.creative || 0) < 30) ? -10 : 0,
  responsibility_drain: (job) => (job.execution || 0) > 80 ? -8 : 0,
  unpredictability_drain: (job) => {
    const sw = job.shift_work || 'none'
    return sw === 'required' ? -12 : sw === 'possible' ? -5 : 0
  },
}

function calculateLikeScore(job: Record<string, any>, mm: any): number {
  const scores: WeightedScore[] = []

  // 1) 흥미 매칭 (weight: 1.0 each)
  const interests = mm.interest_top || []
  for (const token of interests) {
    const mapping = INTEREST_JOB_MAP[token]
    if (mapping) {
      let score = 0
      for (const [attr, w] of Object.entries(mapping.attrs)) {
        score += (job[attr] || 0) * w
      }
      scores.push({ score, weight: 1.0 })
    }
  }

  // 2) 가치 매칭 (weight: 0.8 each)
  const values = mm.value_top || []
  for (const token of values) {
    const mapping = VALUE_JOB_MAP[token]
    if (mapping) {
      let score = mapping.baseAdd || 0
      for (const [attr, w] of Object.entries(mapping.attrs)) {
        score += (job[attr] || 0) * w
      }
      scores.push({ score, weight: 0.8 })
    }
  }

  // 3) 업무스타일 매칭 (weight: 0.5 each)
  const workstyles = mm.workstyle_top || []
  for (const token of workstyles) {
    const mapping = WORKSTYLE_JOB_MAP[token]
    if (mapping) {
      let score = 0
      for (const [attr, w] of Object.entries(mapping.attrs)) {
        score += (job[attr] || 0) * w
      }
      scores.push({ score, weight: 0.5 })
    }
  }

  // 4) 지속 동기 매칭 (weight: 0.3)
  const anchor = mm.persistence_anchor
  if (anchor) {
    const mapping = ANCHOR_JOB_MAP[anchor]
    if (mapping) {
      let score = mapping.baseAdd || 0
      for (const [attr, w] of Object.entries(mapping.attrs)) {
        score += (job[attr] || 0) * w
      }
      scores.push({ score, weight: 0.3 })
    }
  }

  // Weighted average
  if (scores.length === 0) {
    // mm이 있지만 매칭이 전혀 안되는 경우 → 기본 공식
    return Math.round(((job.wlb || 50) + (job.growth || 50) + (job.stability || 50) + (job.income || 50)) / 4)
  }

  const totalWeight = scores.reduce((sum, s) => sum + s.weight, 0)
  let rawLike = scores.reduce((sum, s) => sum + s.score * s.weight, 0) / totalWeight

  // 5) 에너지 소모 페널티
  const drains = mm.energy_drain_flags || []
  for (const drain of drains) {
    const penaltyFn = ENERGY_DRAIN_PENALTIES[drain]
    if (penaltyFn) {
      rawLike += penaltyFn(job)
    }
  }

  // 6) 워크스타일 미스매치 페널티
  // solo 선호 유저 + 낮은 solo_deep 직업 → 페널티
  const ws = mm.workstyle_top || []
  if (ws.some((w: string) => w.includes('solo'))) {
    const soloDep = job.solo_deep || 0
    if (soloDep < 30) rawLike -= 12
    else if (soloDep < 40) rawLike -= 6
  }

  // 7) 지식노동 vs 육체노동 미스매치 페널티
  const interestTokens = mm.interest_top || []
  const isKnowledgeUser = interestTokens.includes('data_numbers') ||
    interestTokens.includes('problem_solving') || interestTokens.includes('creating')
  const exec = job.execution || 0
  const anal = job.analytical || 0
  const crea = job.creative || 0
  const knowledgeScore = anal + crea
  const manualScore = exec * 2  // execution 지배적 직업 (x2 가중)

  if (isKnowledgeUser) {
    // 고execution + 저analytical/creative → 육체노동 직업
    if (exec > 60 && anal < 50 && crea < 40) {
      const gap = exec - Math.max(anal, crea)
      rawLike -= Math.min(25, Math.round(gap * 0.5))  // 최대 -25
    }
    // 순수 execution 직업 (분석/창의 요소 거의 없음) → 강한 페널티
    if (manualScore > knowledgeScore * 1.5 && exec > 50) {
      rawLike -= 10
    }
  }

  return Math.max(0, Math.min(100, Math.round(rawLike)))
}

// ============================================
// Can Score: Strength/Adaptability × Job Requirements
// ============================================

// 강점 → 직업 요구 속성 매핑 (비례 스코어링)
const STRENGTH_JOB_MAP: Record<string, { attr?: string, universal?: number }> = {
  analytical:           { attr: 'analytical' },
  creative:             { attr: 'creative' },
  communication:        { attr: 'people_facing' },
  structured_execution: { attr: 'execution' },
  persistence:          { universal: 5 },
  fast_learning:        { universal: 8 },
}

// 진입 장벽 페널티 테이블
const DEGREE_PENALTY: Record<string, number> = {
  none: 0,
  college: -5,
  bachelor: -12,
  master: -22,
  phd: -35,
}

const LICENSE_PENALTY: Record<string, number> = {
  none: 0,
  preferred: -5,
  required: -18,
  multiple_required: -30,
}

const EXPERIENCE_PENALTY: Record<string, number> = {
  none: 0,
  entry: -3,
  junior: -8,
  mid: -18,
  senior: -30,
}

// 적응성 보너스 (축소: 모든 직업에 동일 적용되므로 차별화에 미미)
const SACRIFICE_BONUS: Record<string, number> = {
  willing_to_study: 5,
  field_change_ok: 3,
  low_initial_income: 2,
  ignore_social_pressure: 1,
  no_sacrifice: -5,
}

// 회복탄력성 보너스 (축소)
const RESILIENCE_BONUS: Record<string, number> = {
  iterate_on_failure: 3,
  pivot_on_failure: 2,
  flexible_execution: 1,
  pause_on_failure: 0,
  emotionally_affected: -3,
}

function calculateCanScore(job: Record<string, any>, mm: any): number {
  let can = 30  // 기본 베이스

  // 1) 강점 매칭 (비례 스코어링: 직업 속성값에 비례하여 점수 부여)
  const strengths = mm.strength_top || []
  for (const token of strengths) {
    const mapping = STRENGTH_JOB_MAP[token]
    if (!mapping) continue

    if (mapping.universal !== undefined) {
      can += mapping.universal
    } else if (mapping.attr) {
      // 비례 스코어: 속성값이 높을수록 더 많은 점수 (0~30 범위)
      const jobValue = job[mapping.attr] || 0
      can += Math.round((jobValue / 100) * 30)
    }
  }

  // 2) 적응성 보너스 (sacrifice_flags)
  const sacrifices = mm.sacrifice_flags || []
  for (const flag of sacrifices) {
    can += SACRIFICE_BONUS[flag] || 0
  }

  // 3) 회복탄력성 보너스 (failure_response)
  const failureResponse = mm.failure_response
  if (failureResponse) {
    can += RESILIENCE_BONUS[failureResponse] || 0
  }

  // 4) 진입 장벽 페널티
  const degreeReq = job.degree_required || 'none'
  const licenseReq = job.license_required || 'none'
  const experienceReq = job.experience_required || 'none'

  let degreePenalty = DEGREE_PENALTY[degreeReq] || 0
  let licensePenalty = LICENSE_PENALTY[licenseReq] || 0
  let experiencePenalty = EXPERIENCE_PENALTY[experienceReq] || 0

  // 5) 배경에 따른 페널티 완화
  const backgrounds = mm.background_flags || []
  if (backgrounds.includes('license_cert')) {
    licensePenalty = Math.round(licensePenalty * 0.4)  // 60% 감소
  }
  if (backgrounds.includes('research_academic')) {
    degreePenalty = Math.round(degreePenalty * 0.6)    // 40% 감소
  }
  // qualification_constraint가 있으면 추가 완화 없음 (자격 취득 어려움을 의미)
  // 반면, willing_to_study가 있으면 experience 페널티 약간 완화
  if (sacrifices.includes('willing_to_study')) {
    experiencePenalty = Math.round(experiencePenalty * 0.7)  // 30% 감소
  }

  can += degreePenalty + licensePenalty + experiencePenalty

  // 6) 주요 속성 미스매치 페널티
  // 직업의 지배적 속성이 유저 강점과 전혀 안 맞으면 페널티
  const strengthAttrs = strengths
    .map((t: string) => STRENGTH_JOB_MAP[t]?.attr)
    .filter(Boolean) as string[]
  if (strengthAttrs.length > 0) {
    // 직업의 가장 높은 속성 찾기
    const attrCandidates = ['analytical', 'creative', 'people_facing', 'execution']
    let dominantAttr = ''
    let dominantVal = 0
    for (const attr of attrCandidates) {
      const val = job[attr] || 0
      if (val > dominantVal) {
        dominantVal = val
        dominantAttr = attr
      }
    }
    // 직업의 지배적 속성이 유저 강점에 없으면 페널티
    if (dominantAttr && dominantVal >= 60 && !strengthAttrs.includes(dominantAttr)) {
      can -= Math.round((dominantVal - 50) * 0.5)  // 최대 -25점 (강화)
    }

    // 7) 지식노동 vs 육체노동 미스매치 (Can 전용)
    // 유저가 analytical/creative 강점인데 execution 지배 직업 → 큰 페널티
    const isKnowledgeStrength = strengthAttrs.includes('analytical') || strengthAttrs.includes('creative')
    const jobExec = job.execution || 0
    const jobAnal = job.analytical || 0
    const jobCrea = job.creative || 0
    if (isKnowledgeStrength && jobExec > 60 && jobAnal < 50 && jobCrea < 40) {
      const mismatchGap = jobExec - Math.max(jobAnal, jobCrea)
      can -= Math.min(20, Math.round(mismatchGap * 0.4))  // 최대 -20
    }
  }

  return Math.max(5, Math.min(100, Math.round(can)))
}

// ============================================
// Main Export
// ============================================

export function calculatePersonalizedBaseScores(
  jobAttrs: Record<string, any>,
  mm?: any
): { like: number; can: number } {
  // mm이 없으면 기존 공식 fallback (하위 호환)
  if (!mm) {
    const like = Math.round(
      ((jobAttrs.wlb || 50) + (jobAttrs.growth || 50) + (jobAttrs.stability || 50) + (jobAttrs.income || 50)) / 4
    )
    const can = Math.round(
      ((jobAttrs.teamwork || 50) + ((jobAttrs.analytical || 50) * 0.7) + (jobAttrs.creative || 50)) / 3
    )
    return { like, can }
  }

  return {
    like: calculateLikeScore(jobAttrs, mm),
    can: calculateCanScore(jobAttrs, mm),
  }
}
