// src/services/ai-analyzer/growth-curve-mapper.ts
// ============================================
// P3: 성장곡선 → 직업 매핑 시스템
// ============================================
// 사용자의 성장 선호도를 파악하고
// 해당 성장 곡선에 맞는 직업 추천에 가중치 적용
// ============================================

import type { MiniModuleResult } from './mini-module-questions'

// ============================================
// 성장 곡선 타입 정의
// ============================================

/**
 * 성장 곡선 유형
 * - rapid_ascent: 급성장형 (스타트업, IT 등)
 * - steady_climb: 꾸준한 성장형 (전문직, 공무원 등)
 * - late_bloomer: 후반부 성장형 (연구직, 예술 등)
 * - volatile: 변동형 (프리랜서, 영업 등)
 * - plateau: 안정형 (사무직, 관리직 등)
 */
export type GrowthCurveType =
  | 'rapid_ascent'   // 급성장형
  | 'steady_climb'   // 꾸준한 성장형
  | 'late_bloomer'   // 후반부 성장형
  | 'volatile'       // 변동형
  | 'plateau'        // 안정형

/**
 * 성장 곡선 특성
 */
export interface GrowthCurveProfile {
  type: GrowthCurveType
  label: string
  description: string
  /** 초기 성장률 (0-100) */
  initialGrowthRate: number
  /** 중기 성장률 (0-100) */
  midGrowthRate: number
  /** 후기 성장률 (0-100) */
  lateGrowthRate: number
  /** 변동성 (0-100) */
  volatility: number
  /** 천장 도달 시점 (년) */
  ceilingYears: number
  /** 직업 예시 */
  jobExamples: string[]
}

// ============================================
// 성장 곡선 프로파일 정의
// ============================================
export const GROWTH_CURVE_PROFILES: Record<GrowthCurveType, GrowthCurveProfile> = {
  rapid_ascent: {
    type: 'rapid_ascent',
    label: '급성장형',
    description: '초기에 빠르게 성장하지만 천장이 빨리 올 수 있음',
    initialGrowthRate: 90,
    midGrowthRate: 60,
    lateGrowthRate: 30,
    volatility: 60,
    ceilingYears: 8,
    jobExamples: ['스타트업 창업자', 'IT 개발자', '데이터 과학자', 'UX 디자이너'],
  },
  steady_climb: {
    type: 'steady_climb',
    label: '꾸준한 성장형',
    description: '시간이 지날수록 안정적으로 성장',
    initialGrowthRate: 50,
    midGrowthRate: 70,
    lateGrowthRate: 60,
    volatility: 20,
    ceilingYears: 20,
    jobExamples: ['공무원', '전문의', '변호사', '공인회계사', '대기업 직원'],
  },
  late_bloomer: {
    type: 'late_bloomer',
    label: '후반부 성장형',
    description: '초기에는 느리지만 경력이 쌓일수록 가치가 높아짐',
    initialGrowthRate: 30,
    midGrowthRate: 50,
    lateGrowthRate: 80,
    volatility: 30,
    ceilingYears: 25,
    jobExamples: ['교수', '연구원', '작가', '예술가', '컨설턴트'],
  },
  volatile: {
    type: 'volatile',
    label: '변동형',
    description: '성과에 따라 크게 변동하며 리스크와 보상이 공존',
    initialGrowthRate: 60,
    midGrowthRate: 50,
    lateGrowthRate: 40,
    volatility: 90,
    ceilingYears: 15,
    jobExamples: ['프리랜서', '영업직', '투자자', '유튜버', '연예인'],
  },
  plateau: {
    type: 'plateau',
    label: '안정형',
    description: '빠르게 안정 구간에 도달하고 그 수준을 유지',
    initialGrowthRate: 60,
    midGrowthRate: 30,
    lateGrowthRate: 20,
    volatility: 10,
    ceilingYears: 10,
    jobExamples: ['행정직', '사무직', '은행원', '교사', '경리'],
  },
}

// ============================================
// 사용자 성장 선호도 분석
// ============================================

/**
 * 사용자 성장 선호도
 */
export interface UserGrowthPreference {
  /** 선호 성장 곡선 유형 */
  preferredCurve: GrowthCurveType
  /** 안정성 선호도 (0-100, 높을수록 안정 선호) */
  stabilityPreference: number
  /** 초기 성장 중요도 (0-100) */
  earlyGrowthImportance: number
  /** 장기 성장 중요도 (0-100) */
  longTermImportance: number
  /** 위험 감수 성향 (0-100) */
  riskTolerance: number
  /** 분석 신뢰도 */
  confidence: number
}

/**
 * 미니모듈 결과에서 성장 선호도 추출
 */
export function extractGrowthPreference(
  miniModule: MiniModuleResult | undefined
): UserGrowthPreference {
  // 기본값 (균형형)
  if (!miniModule) {
    return {
      preferredCurve: 'steady_climb',
      stabilityPreference: 50,
      earlyGrowthImportance: 50,
      longTermImportance: 50,
      riskTolerance: 50,
      confidence: 0.3,
    }
  }

  // 1. 안정성 선호도 계산
  let stabilityPreference = 50
  let earlyGrowthImportance = 50
  let longTermImportance = 50
  let riskTolerance = 50

  // value_top에서 분석
  if (miniModule.value_top?.includes('stability')) {
    stabilityPreference += 20
    riskTolerance -= 15
  }
  if (miniModule.value_top?.includes('growth')) {
    earlyGrowthImportance += 15
    stabilityPreference -= 10
  }
  if (miniModule.value_top?.includes('autonomy')) {
    riskTolerance += 10
  }
  if (miniModule.value_top?.includes('income')) {
    earlyGrowthImportance += 10
  }

  // sacrifice_flags에서 분석
  if (miniModule.sacrifice_flags?.includes('low_initial_income')) {
    longTermImportance += 20
    earlyGrowthImportance -= 15
  }
  if (miniModule.sacrifice_flags?.includes('job_uncertainty')) {
    riskTolerance += 25
    stabilityPreference -= 20
  }
  if (miniModule.sacrifice_flags?.includes('no_sacrifice')) {
    stabilityPreference += 25
    riskTolerance -= 25
  }

  // energy_drain_flags에서 분석
  if (miniModule.energy_drain_flags?.includes('unpredictability_drain')) {
    stabilityPreference += 15
    riskTolerance -= 15
  }

  // constraint_flags에서 분석
  if (miniModule.constraint_flags?.includes('job_stability_required')) {
    stabilityPreference += 20
    riskTolerance -= 20
  }

  // persistence_anchor에서 분석
  if (miniModule.persistence_anchor === 'growth_anchor') {
    longTermImportance += 15
    earlyGrowthImportance += 10
  }
  if (miniModule.persistence_anchor === 'stability_anchor') {
    stabilityPreference += 20
  }

  // 범위 제한 (0-100)
  stabilityPreference = Math.max(0, Math.min(100, stabilityPreference))
  earlyGrowthImportance = Math.max(0, Math.min(100, earlyGrowthImportance))
  longTermImportance = Math.max(0, Math.min(100, longTermImportance))
  riskTolerance = Math.max(0, Math.min(100, riskTolerance))

  // 2. 선호 성장 곡선 결정
  const preferredCurve = determinePreferredCurve({
    stabilityPreference,
    earlyGrowthImportance,
    longTermImportance,
    riskTolerance,
  })

  // 3. 신뢰도 계산 (입력 데이터가 많을수록 높음)
  let confidence = 0.5
  if (miniModule.value_top?.length) confidence += 0.1
  if (miniModule.sacrifice_flags?.length) confidence += 0.15
  if (miniModule.energy_drain_flags?.length) confidence += 0.1
  if (miniModule.persistence_anchor) confidence += 0.1
  confidence = Math.min(1, confidence)

  return {
    preferredCurve,
    stabilityPreference,
    earlyGrowthImportance,
    longTermImportance,
    riskTolerance,
    confidence,
  }
}

/**
 * 수치들을 기반으로 선호 성장 곡선 결정
 */
function determinePreferredCurve(params: {
  stabilityPreference: number
  earlyGrowthImportance: number
  longTermImportance: number
  riskTolerance: number
}): GrowthCurveType {
  const { stabilityPreference, earlyGrowthImportance, longTermImportance, riskTolerance } = params

  // 높은 안정성 + 낮은 리스크 → plateau
  if (stabilityPreference >= 70 && riskTolerance <= 30) {
    return 'plateau'
  }

  // 높은 리스크 + 낮은 안정성 → volatile
  if (riskTolerance >= 70 && stabilityPreference <= 40) {
    return 'volatile'
  }

  // 높은 초기 성장 중요 + 낮은 장기 중요 → rapid_ascent
  if (earlyGrowthImportance >= 65 && longTermImportance <= 50) {
    return 'rapid_ascent'
  }

  // 높은 장기 성장 중요 + 낮은 초기 중요 → late_bloomer
  if (longTermImportance >= 65 && earlyGrowthImportance <= 50) {
    return 'late_bloomer'
  }

  // 기본: steady_climb (균형형)
  return 'steady_climb'
}

// ============================================
// 직업별 성장 곡선 추정
// ============================================

/**
 * 직업 속성에서 성장 곡선 추정
 */
export function estimateJobGrowthCurve(
  jobAttrs: Record<string, any>,
  jobName: string
): { curve: GrowthCurveType; confidence: number } {
  // 직업명 기반 패턴 매칭 (높은 신뢰도)
  const namePatterns: Array<{ pattern: RegExp; curve: GrowthCurveType }> = [
    // rapid_ascent
    { pattern: /개발자|엔지니어|데이터|스타트업|IT|프로그래머/i, curve: 'rapid_ascent' },
    // steady_climb
    { pattern: /공무원|변호사|의사|회계사|공인|전문의|대기업/i, curve: 'steady_climb' },
    // late_bloomer
    { pattern: /교수|연구|작가|예술|컨설팅|고문|감정|박사/i, curve: 'late_bloomer' },
    // volatile
    { pattern: /프리랜서|영업|투자|유튜브|인플루언서|연예|방송/i, curve: 'volatile' },
    // plateau
    { pattern: /사무|행정|은행|교사|경리|총무|비서/i, curve: 'plateau' },
  ]

  for (const { pattern, curve } of namePatterns) {
    if (pattern.test(jobName)) {
      return { curve, confidence: 0.8 }
    }
  }

  // 속성 기반 추정
  const growth = jobAttrs.growth || 50
  const stability = jobAttrs.stability || 50
  const income = jobAttrs.income || 50

  // 높은 성장 + 낮은 안정성 → rapid_ascent
  if (growth >= 70 && stability <= 50) {
    return { curve: 'rapid_ascent', confidence: 0.6 }
  }

  // 높은 안정성 + 중간 성장 → steady_climb
  if (stability >= 70 && growth >= 40) {
    return { curve: 'steady_climb', confidence: 0.6 }
  }

  // 높은 안정성 + 낮은 성장 → plateau
  if (stability >= 70 && growth <= 40) {
    return { curve: 'plateau', confidence: 0.6 }
  }

  // 낮은 안정성 + 높은 소득 변동성 → volatile
  if (stability <= 40) {
    return { curve: 'volatile', confidence: 0.5 }
  }

  // 기본값
  return { curve: 'steady_climb', confidence: 0.4 }
}

// ============================================
// 성장 곡선 매칭 점수 계산
// ============================================

export interface GrowthCurveMatchResult {
  /** 매칭 점수 (0-100) */
  matchScore: number
  /** 적용할 Like Boost */
  likeBoost: number
  /** 적용할 Risk Penalty */
  riskPenalty: number
  /** 설명 */
  explanation: string
  /** 사용자 선호 곡선 */
  userCurve: GrowthCurveType
  /** 직업 곡선 */
  jobCurve: GrowthCurveType
}

/**
 * 성장 곡선 호환성 행렬
 * [userCurve][jobCurve] = compatibility (0-100)
 */
const CURVE_COMPATIBILITY: Record<GrowthCurveType, Record<GrowthCurveType, number>> = {
  rapid_ascent: {
    rapid_ascent: 100,
    steady_climb: 60,
    late_bloomer: 40,
    volatile: 70,
    plateau: 30,
  },
  steady_climb: {
    rapid_ascent: 60,
    steady_climb: 100,
    late_bloomer: 80,
    volatile: 40,
    plateau: 70,
  },
  late_bloomer: {
    rapid_ascent: 40,
    steady_climb: 80,
    late_bloomer: 100,
    volatile: 30,
    plateau: 50,
  },
  volatile: {
    rapid_ascent: 70,
    steady_climb: 40,
    late_bloomer: 30,
    volatile: 100,
    plateau: 20,
  },
  plateau: {
    rapid_ascent: 30,
    steady_climb: 70,
    late_bloomer: 50,
    volatile: 20,
    plateau: 100,
  },
}

/**
 * 사용자 성장 선호도와 직업 성장 곡선 매칭
 */
export function matchGrowthCurves(
  userPreference: UserGrowthPreference,
  jobAttrs: Record<string, any>,
  jobName: string
): GrowthCurveMatchResult {
  const jobCurve = estimateJobGrowthCurve(jobAttrs, jobName)
  const compatibility = CURVE_COMPATIBILITY[userPreference.preferredCurve][jobCurve.curve]

  // 매칭 점수 계산 (신뢰도 가중)
  const rawMatchScore = compatibility
  const confidenceWeight = (userPreference.confidence + jobCurve.confidence) / 2
  const matchScore = Math.round(rawMatchScore * confidenceWeight + (100 - rawMatchScore) * (1 - confidenceWeight) * 0.5)

  // Like Boost / Risk Penalty 계산
  let likeBoost = 0
  let riskPenalty = 0

  if (matchScore >= 80) {
    // 높은 매칭 → Like Boost
    likeBoost = Math.round((matchScore - 80) * 0.5)  // 최대 +10
  } else if (matchScore <= 40) {
    // 낮은 매칭 → Risk Penalty
    riskPenalty = Math.round((40 - matchScore) * 0.3)  // 최대 +12
  }

  // 설명 생성
  const userProfile = GROWTH_CURVE_PROFILES[userPreference.preferredCurve]
  const jobProfile = GROWTH_CURVE_PROFILES[jobCurve.curve]
  let explanation = ''

  if (matchScore >= 80) {
    explanation = `${userProfile.label} 선호와 ${jobProfile.label} 직업이 잘 맞습니다`
  } else if (matchScore >= 60) {
    explanation = `${userProfile.label} 선호에 ${jobProfile.label} 직업도 적합할 수 있습니다`
  } else if (matchScore >= 40) {
    explanation = `${userProfile.label} 선호와 ${jobProfile.label} 직업 간 차이가 있을 수 있습니다`
  } else {
    explanation = `${userProfile.label} 선호와 ${jobProfile.label} 직업은 성장 패턴이 다릅니다`
  }

  return {
    matchScore,
    likeBoost,
    riskPenalty,
    explanation,
    userCurve: userPreference.preferredCurve,
    jobCurve: jobCurve.curve,
  }
}

/**
 * 배치 처리용: 직업 목록에 성장 곡선 매칭 적용
 */
export function applyGrowthCurveMatching<T extends { job_id: string; job_name: string; attributes?: Record<string, any> }>(
  jobs: T[],
  userPreference: UserGrowthPreference
): Array<T & { growthMatch: GrowthCurveMatchResult }> {
  return jobs.map(job => {
    const attrs = job.attributes || (job as any)
    const growthMatch = matchGrowthCurves(userPreference, attrs, job.job_name)

    return {
      ...job,
      growthMatch,
    }
  })
}
