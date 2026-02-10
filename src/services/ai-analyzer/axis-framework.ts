// CareerWiki AI Analyzer - Axis Framework
// Version: v1.0.0 (Freeze v1.1)
//
// ============================================
// 설계 원칙
// ============================================
// 1. 10개 축으로 사용자 프로필을 구조화
// 2. 각 축별 confidence/evidence/missing/priority 상태 관리
// 3. Interview Mode에서 QSP 생성의 기준이 됨
// 4. 태깅 없이 질문 품질을 높이기 위한 프레임워크
// ============================================

// ============================================
// 10개 핵심 축 정의
// ============================================
export const AXES = [
  'interest',               // 흥미/관심사
  'strength',               // 강점/역량
  'values',                 // 가치관/중요시하는 것
  'work_style',             // 업무 스타일 (혼자 vs 협업 등)
  'people',                 // 대인관계 선호
  'environment',            // 근무 환경 선호
  'stress_tolerance',       // 스트레스 내성/회피 패턴
  'growth',                 // 성장/발전 방향
  'risk',                   // 리스크 수용도
  'feasibility_constraints' // 현실 제약 (시간, 돈, 위치 등)
] as const

export type AxisType = typeof AXES[number]

// ============================================
// 축별 상태 타입 정의
// ============================================
export interface AxisState {
  confidence: number      // 0-1: 해당 축에 대한 정보 확신도
  evidence: string[]      // 유저 발언 2-5개 (정규화 키 또는 원문 excerpt)
  missing: boolean        // 해당 축 정보가 부족한지
  priority: number        // 0-100: 지금 파야 할 우선순위 (높을수록 먼저)
}

export type AxisCoverage = {
  [K in AxisType]: AxisState
}

// ============================================
// 축별 질문 테마 매핑
// ============================================
// QSP에서 질문 방향을 결정할 때 사용
export const AXIS_QUESTION_THEMES: Record<AxisType, {
  ko_label: string
  question_angles: string[]
  deepening_prompts: string[]
}> = {
  interest: {
    ko_label: '흥미',
    question_angles: [
      '시간 가는 줄 모르고 빠져드는 활동',
      '자발적으로 찾아보게 되는 주제',
      '에너지가 충전되는 경험',
    ],
    deepening_prompts: [
      '그때 구체적으로 어떤 부분이 재미있었나요?',
      '그 흥미가 언제부터 시작되었나요?',
      '비슷한 다른 경험도 있었나요?',
    ],
  },
  strength: {
    ko_label: '강점',
    question_angles: [
      '주변에서 인정받는 능력',
      '남들보다 쉽게 해내는 것',
      '반복해도 지치지 않는 활동',
    ],
    deepening_prompts: [
      '그 강점이 발휘된 구체적인 상황은?',
      '그 능력을 어떻게 키우게 되었나요?',
      '그 강점을 더 쓰고 싶은지, 다른 강점을 개발하고 싶은지?',
    ],
  },
  values: {
    ko_label: '가치관',
    question_angles: [
      '일할 때 가장 중요하게 여기는 것',
      '포기할 수 없는 조건',
      '이상적인 직장의 조건',
    ],
    deepening_prompts: [
      '왜 그것이 중요한가요?',
      '그 가치가 충족되지 않으면 어떤 기분인가요?',
      '과거에 그 가치가 충족/불충족된 경험은?',
    ],
  },
  work_style: {
    ko_label: '업무 스타일',
    question_angles: [
      '혼자 vs 함께 일할 때 효율',
      '구조화된 vs 자유로운 업무 선호',
      '멀티태스킹 vs 집중 선호',
    ],
    deepening_prompts: [
      '그 스타일로 일했을 때 성과가 좋았던 경험은?',
      '반대 스타일로 일해야 했을 때 어땠나요?',
      '이상적인 하루 업무 패턴은?',
    ],
  },
  people: {
    ko_label: '대인관계',
    question_angles: [
      '함께 일하고 싶은 사람 유형',
      '피하고 싶은 관계 패턴',
      '리더십/팔로워십 선호',
    ],
    deepening_prompts: [
      '왜 그런 사람과 일하고 싶나요?',
      '과거 좋았던/힘들었던 동료 관계 경험은?',
      '이상적인 팀 분위기는?',
    ],
  },
  environment: {
    ko_label: '근무 환경',
    question_angles: [
      '실내/실외, 사무실/현장 선호',
      '정적/동적 업무 선호',
      '출퇴근/원격 선호',
    ],
    deepening_prompts: [
      '그 환경에서 일했을 때 어땠나요?',
      '환경이 업무 만족도에 얼마나 영향을 주나요?',
      '절대 피하고 싶은 환경은?',
    ],
  },
  stress_tolerance: {
    ko_label: '스트레스 대응',
    question_angles: [
      '스트레스 받는 상황 유형',
      '스트레스 해소 방법',
      '압박 상황에서의 반응 패턴',
    ],
    deepening_prompts: [
      '그 상황에서 구체적으로 어떤 감정이었나요?',
      '그 스트레스를 어떻게 극복했나요?',
      '비슷한 상황이 반복되면 어떻게 할 것 같나요?',
    ],
  },
  growth: {
    ko_label: '성장 방향',
    question_angles: [
      '5년 후 목표/비전',
      '배우고 싶은 것',
      '커리어 발전 방향',
    ],
    deepening_prompts: [
      '왜 그 방향으로 성장하고 싶나요?',
      '그 목표를 위해 지금 하고 있는 것은?',
      '그 목표가 달성되면 그 다음은?',
    ],
  },
  risk: {
    ko_label: '리스크 수용도',
    question_angles: [
      '안정 vs 도전 선호',
      '불확실성에 대한 태도',
      '실패 경험과 대응',
    ],
    deepening_prompts: [
      '과거 도전적인 결정을 했던 경험은?',
      '실패했을 때 어떻게 대응했나요?',
      '지금 감수할 수 있는 리스크 수준은?',
    ],
  },
  feasibility_constraints: {
    ko_label: '현실 제약',
    question_angles: [
      '시간적 제약 (가족, 학업 등)',
      '경제적 제약',
      '위치/이동 제약',
    ],
    deepening_prompts: [
      '그 제약은 얼마나 유연한가요?',
      '제약 내에서 가능한 선택지는?',
      '제약이 해소된다면 무엇을 하고 싶나요?',
    ],
  },
}

// ============================================
// 빈 AxisCoverage 생성
// ============================================
export function createEmptyAxisCoverage(): AxisCoverage {
  const coverage = {} as AxisCoverage
  
  for (const axis of AXES) {
    coverage[axis] = {
      confidence: 0,
      evidence: [],
      missing: true,
      priority: 50, // 기본 우선순위
    }
  }
  
  return coverage
}

// ============================================
// AxisCoverage 업데이트 (새 evidence 추가)
// ============================================
export function updateAxisCoverage(
  coverage: AxisCoverage,
  axis: AxisType,
  update: Partial<AxisState>
): AxisCoverage {
  const current = coverage[axis]
  
  return {
    ...coverage,
    [axis]: {
      ...current,
      ...update,
      // evidence는 누적 (최대 5개)
      evidence: update.evidence 
        ? [...new Set([...current.evidence, ...update.evidence])].slice(0, 5)
        : current.evidence,
      // confidence가 올라가면 missing 해제
      missing: update.confidence !== undefined 
        ? update.confidence < 0.3 
        : current.missing,
    },
  }
}

// ============================================
// AxisCoverage에서 우선 질문 대상 축 추출
// ============================================
export interface AxisPriorityTarget {
  axis: AxisType
  reason: string
  suggestedAngles: string[]
}

export function getHighPriorityAxes(
  coverage: AxisCoverage,
  maxTargets: number = 3
): AxisPriorityTarget[] {
  const targets: AxisPriorityTarget[] = []
  
  // 1. missing + low confidence 우선
  const missingAxes = AXES.filter(axis => 
    coverage[axis].missing && coverage[axis].confidence < 0.3
  )
  
  for (const axis of missingAxes) {
    const theme = AXIS_QUESTION_THEMES[axis]
    targets.push({
      axis,
      reason: `${theme.ko_label} 정보 부족 (confidence: ${coverage[axis].confidence.toFixed(2)})`,
      suggestedAngles: theme.question_angles.slice(0, 2),
    })
  }
  
  // 2. 나머지는 priority 순으로
  const remainingAxes = AXES
    .filter(axis => !missingAxes.includes(axis))
    .sort((a, b) => coverage[b].priority - coverage[a].priority)
  
  for (const axis of remainingAxes) {
    if (targets.length >= maxTargets) break
    
    const theme = AXIS_QUESTION_THEMES[axis]
    targets.push({
      axis,
      reason: `${theme.ko_label} 심화 필요 (priority: ${coverage[axis].priority})`,
      suggestedAngles: theme.deepening_prompts.slice(0, 2),
    })
  }
  
  return targets.slice(0, maxTargets)
}

// ============================================
// 라운드별 추천 축 매핑 (고정 규칙)
// ============================================
export const ROUND_AXIS_FOCUS: Record<1 | 2 | 3, AxisType[]> = {
  1: ['interest', 'values', 'strength'],      // Round 1: 핵심 동기 파악
  2: ['stress_tolerance', 'people', 'risk'],  // Round 2: 회피/관계 패턴
  3: ['feasibility_constraints', 'environment', 'growth'], // Round 3: 현실 + 미래
}

// ============================================
// 축별 신뢰도 계산 (evidence 기반)
// ============================================
export function calculateAxisConfidence(
  evidenceCount: number,
  evidenceQuality: number = 0.7 // 기본 품질 점수
): number {
  // evidence 개수에 따른 기본 점수
  const countScore = Math.min(evidenceCount / 3, 1) // 3개면 만점
  
  // 품질 가중치 적용
  return Math.min(countScore * evidenceQuality, 1)
}

// ============================================
// 전체 프로필 완성도 계산
// ============================================
export function calculateProfileCompleteness(coverage: AxisCoverage): {
  overall: number
  byAxis: Record<AxisType, number>
  missingAxes: AxisType[]
} {
  const byAxis = {} as Record<AxisType, number>
  const missingAxes: AxisType[] = []
  let totalConfidence = 0
  
  for (const axis of AXES) {
    const state = coverage[axis]
    byAxis[axis] = state.confidence
    totalConfidence += state.confidence
    
    if (state.missing) {
      missingAxes.push(axis)
    }
  }
  
  return {
    overall: totalConfidence / AXES.length,
    byAxis,
    missingAxes,
  }
}
