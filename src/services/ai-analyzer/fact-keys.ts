// src/services/ai-analyzer/fact-keys.ts
// ============================================
// fact_key 사전 - 커리어트리 통계의 핵심
// ============================================
// P0-2: 모든 fact_key 네이밍 표준화
// - 배열 분해 저장은 단수형만 사용
// - constraints는 2단 저장 (has + detail)

// ============================================
// 3.2.1 State (항상 단일값)
// ============================================
export const STATE_FACT_KEYS = {
  role_identity: 'state.role_identity',
  role_identity_subtype: 'state.role_identity_subtype', // optional (P0.5 탈출구)
  career_stage_years: 'state.career_stage_years',
  transition_status: 'state.transition_status',
  skill_level: 'state.skill_level',
} as const

// ============================================
// 3.2.2 Constraints (P0-6: 2단 저장!)
// state.constraint.time = true/false
// state.constraint.time_detail = "overtime_no"
// ============================================
export const CONSTRAINT_FACT_KEYS = {
  time: 'state.constraint.time',
  time_detail: 'state.constraint.time_detail',
  money: 'state.constraint.money',
  money_detail: 'state.constraint.money_detail',
  location: 'state.constraint.location',
  location_detail: 'state.constraint.location_detail',
  family: 'state.constraint.family',
  family_detail: 'state.constraint.family_detail',
  health: 'state.constraint.health',
  health_detail: 'state.constraint.health_detail',
  qualification: 'state.constraint.qualification',
  qualification_detail: 'state.constraint.qualification_detail',
} as const

// ============================================
// 3.2.3 Transition (배열은 단수 분해!)
// ============================================
export const TRANSITION_FACT_KEYS = {
  desired_type: 'transition.desired_type', // 단수! (분해 row, rank_int 사용)
  motivation_primary: 'transition.motivation_primary',
  blocker: 'transition.blocker', // 단수! (분해 row)
  timeline: 'transition.timeline',
  time_invest_hours_bucket: 'transition.time_invest_hours_bucket',
} as const

// ============================================
// 3.2.4 Anchor / Followup
// ============================================
export const ANCHOR_FACT_KEYS = {
  non_negotiable_value: 'anchor.non_negotiable_value',
  desired_emotion: 'anchor.desired_emotion',
  dealbreaker: 'anchor.dealbreaker', // open text
} as const

// ============================================
// 통합 사전 (유효성 검증용)
// ============================================
export const ALL_FACT_KEYS = {
  ...STATE_FACT_KEYS,
  ...CONSTRAINT_FACT_KEYS,
  ...TRANSITION_FACT_KEYS,
  ...ANCHOR_FACT_KEYS,
} as const

// fact_key 유효성 검증 함수
export function isValidFactKey(key: string): boolean {
  // 정적 키 체크
  if (Object.values(ALL_FACT_KEYS).includes(key as any)) {
    return true
  }
  // constraint.* 패턴 체크 (동적 키)
  if (key.startsWith('state.constraint.')) {
    const suffix = key.replace('state.constraint.', '')
    const validConstraints = ['time', 'money', 'location', 'family', 'health', 'qualification']
    const validSuffixes = validConstraints.flatMap((c) => [c, `${c}_detail`])
    return validSuffixes.includes(suffix)
  }
  return false
}

// fact_key prefix 추출
export function getFactKeyPrefix(key: string): 'state' | 'transition' | 'anchor' | 'unknown' {
  if (key.startsWith('state.')) return 'state'
  if (key.startsWith('transition.')) return 'transition'
  if (key.startsWith('anchor.')) return 'anchor'
  return 'unknown'
}
