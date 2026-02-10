/**
 * Can Validation Questions (Can 검증 질문)
 *
 * Q3 강점 자기평가에서 선택된 항목들의 실제 경험을 검증
 * - 자기평가만으로는 Can 50% 수집률 → 검증 질문으로 80%+ 달성 목표
 * - 검증된 강점에 대해 can_boost 적용
 * - 세션당 최대 2개 Can 검증 질문 (기존 followup 2개 + can_validation 2개 = 최대 4개)
 */

import { FollowupQuestionV3 } from './types'

// ============================================
// 강점 토큰 → 검증 질문 매핑
// ============================================
export type StrengthToken =
  | 'analytical'
  | 'creative'
  | 'communication'
  | 'structured_execution'
  | 'persistence'
  | 'fast_learning'

export interface CanValidationQuestion extends FollowupQuestionV3 {
  strength_token: StrengthToken
  can_boost_on_verified: number  // 검증 시 적용할 can_boost (기본 +15)
}

// ============================================
// 6개 강점에 대한 검증 질문
// ============================================
export const CAN_VALIDATION_QUESTIONS: Record<StrengthToken, CanValidationQuestion> = {
  // 1. 분석력 검증
  analytical: {
    id: 'can_val_analytical',
    type: 'can_validation',
    strength_token: 'analytical',
    question: '분석력이 강점이시네요! 실제로 복잡한 문제를 논리적으로 분석해서 해결했던 경험이 있으신가요?',
    why_asked: '자기평가 강점의 실제 적용 경험을 확인하여 Can 점수의 신뢰도를 높입니다',
    affected_dimensions: ['can', 'fit'],
    fact_key: 'can_verified_analytical',
    can_boost_on_verified: 15,
    options: [
      {
        value: 'strong_evidence',
        label: '네, 구체적인 사례가 있어요',
        tags: ['analytical_verified', 'can_boost_high']
      },
      {
        value: 'some_evidence',
        label: '어느 정도는 있는 것 같아요',
        tags: ['analytical_partial', 'can_boost_medium']
      },
      {
        value: 'potential',
        label: '아직 기회가 없었어요',
        tags: ['analytical_potential', 'can_no_boost']
      }
    ],
    uncertainty_reduction: 0.7
  },

  // 2. 창의력 검증
  creative: {
    id: 'can_val_creative',
    type: 'can_validation',
    strength_token: 'creative',
    question: '창의력이 강점이시네요! 새로운 아이디어로 문제를 해결하거나 무언가를 만들어본 경험이 있으신가요?',
    why_asked: '창의력의 실제 발휘 경험을 확인하여 Can 점수의 신뢰도를 높입니다',
    affected_dimensions: ['can', 'fit'],
    fact_key: 'can_verified_creative',
    can_boost_on_verified: 15,
    options: [
      {
        value: 'strong_evidence',
        label: '네, 직접 만들거나 해결한 적 있어요',
        tags: ['creative_verified', 'can_boost_high']
      },
      {
        value: 'some_evidence',
        label: '아이디어를 낸 적은 있어요',
        tags: ['creative_partial', 'can_boost_medium']
      },
      {
        value: 'potential',
        label: '아직 기회가 없었어요',
        tags: ['creative_potential', 'can_no_boost']
      }
    ],
    uncertainty_reduction: 0.7
  },

  // 3. 소통력 검증
  communication: {
    id: 'can_val_communication',
    type: 'can_validation',
    strength_token: 'communication',
    question: '소통력이 강점이시네요! 어려운 개념을 다른 사람에게 잘 설명하거나, 갈등을 조율한 경험이 있으신가요?',
    why_asked: '소통력의 실제 적용 경험을 확인하여 Can 점수의 신뢰도를 높입니다',
    affected_dimensions: ['can', 'fit'],
    fact_key: 'can_verified_communication',
    can_boost_on_verified: 15,
    options: [
      {
        value: 'strong_evidence',
        label: '네, 발표나 조율 경험이 있어요',
        tags: ['communication_verified', 'can_boost_high']
      },
      {
        value: 'some_evidence',
        label: '친구들 사이에서는 잘하는 편이에요',
        tags: ['communication_partial', 'can_boost_medium']
      },
      {
        value: 'potential',
        label: '아직 공식적인 경험은 없어요',
        tags: ['communication_potential', 'can_no_boost']
      }
    ],
    uncertainty_reduction: 0.7
  },

  // 4. 실행력 검증
  structured_execution: {
    id: 'can_val_structured_execution',
    type: 'can_validation',
    strength_token: 'structured_execution',
    question: '체계적인 실행력이 강점이시네요! 복잡한 프로젝트나 일정을 계획하고 완수한 경험이 있으신가요?',
    why_asked: '실행력의 실제 적용 경험을 확인하여 Can 점수의 신뢰도를 높입니다',
    affected_dimensions: ['can', 'fit'],
    fact_key: 'can_verified_structured_execution',
    can_boost_on_verified: 15,
    options: [
      {
        value: 'strong_evidence',
        label: '네, 계획대로 완수한 경험이 있어요',
        tags: ['execution_verified', 'can_boost_high']
      },
      {
        value: 'some_evidence',
        label: '작은 프로젝트는 해봤어요',
        tags: ['execution_partial', 'can_boost_medium']
      },
      {
        value: 'potential',
        label: '아직 큰 프로젝트 경험은 없어요',
        tags: ['execution_potential', 'can_no_boost']
      }
    ],
    uncertainty_reduction: 0.7
  },

  // 5. 끈기 검증
  persistence: {
    id: 'can_val_persistence',
    type: 'can_validation',
    strength_token: 'persistence',
    question: '끈기가 강점이시네요! 포기하고 싶었지만 끝까지 해낸 구체적인 경험이 있으신가요?',
    why_asked: '끈기의 실제 발휘 경험을 확인하여 Can 점수의 신뢰도를 높입니다',
    affected_dimensions: ['can', 'fit'],
    fact_key: 'can_verified_persistence',
    can_boost_on_verified: 15,
    options: [
      {
        value: 'strong_evidence',
        label: '네, 어려웠지만 끝까지 해냈어요',
        tags: ['persistence_verified', 'can_boost_high']
      },
      {
        value: 'some_evidence',
        label: '웬만하면 포기 안 하는 편이에요',
        tags: ['persistence_partial', 'can_boost_medium']
      },
      {
        value: 'potential',
        label: '아직 그런 상황을 겪어보지 않았어요',
        tags: ['persistence_potential', 'can_no_boost']
      }
    ],
    uncertainty_reduction: 0.7
  },

  // 6. 학습력 검증
  fast_learning: {
    id: 'can_val_fast_learning',
    type: 'can_validation',
    strength_token: 'fast_learning',
    question: '빠른 학습이 강점이시네요! 짧은 시간에 새로운 기술이나 지식을 익혀서 활용해본 경험이 있으신가요?',
    why_asked: '학습력의 실제 발휘 경험을 확인하여 Can 점수의 신뢰도를 높입니다',
    affected_dimensions: ['can', 'fit'],
    fact_key: 'can_verified_fast_learning',
    can_boost_on_verified: 15,
    options: [
      {
        value: 'strong_evidence',
        label: '네, 빠르게 배워서 적용한 적 있어요',
        tags: ['learning_verified', 'can_boost_high']
      },
      {
        value: 'some_evidence',
        label: '배우는 건 빠른 것 같아요',
        tags: ['learning_partial', 'can_boost_medium']
      },
      {
        value: 'potential',
        label: '아직 급하게 배울 일이 없었어요',
        tags: ['learning_potential', 'can_no_boost']
      }
    ],
    uncertainty_reduction: 0.7
  }
}

// ============================================
// Can 검증 질문 선택 로직
// ============================================
export interface CanValidationConfig {
  max_questions_per_session: number  // 세션당 최대 Can 검증 질문 수
  already_verified: string[]         // 이미 검증된 강점 토큰들
  user_strength_tokens: string[]     // 유저가 Q3에서 선택한 강점 (최대 2개)
}

/**
 * 유저의 Q3 선택에서 검증할 Can 질문들을 선택
 * - 이미 검증된 강점은 제외
 * - 세션당 최대 2개까지만 반환
 */
export function selectCanValidationQuestions(
  config: CanValidationConfig
): CanValidationQuestion[] {
  const { max_questions_per_session, already_verified, user_strength_tokens } = config

  // 검증이 필요한 강점들 필터링
  const needsValidation = user_strength_tokens.filter(
    token => !already_verified.includes(token)
  ) as StrengthToken[]

  // 해당 강점들의 검증 질문 가져오기
  const questions: CanValidationQuestion[] = []
  for (const token of needsValidation) {
    if (CAN_VALIDATION_QUESTIONS[token]) {
      questions.push(CAN_VALIDATION_QUESTIONS[token])
    }
    if (questions.length >= max_questions_per_session) break
  }

  return questions
}

// ============================================
// Can Boost 계산 로직
// ============================================
export interface CanBoostResult {
  token: StrengthToken
  boost: number
  evidence_level: 'strong' | 'partial' | 'none'
}

/**
 * Can 검증 답변에서 boost 점수 계산
 */
export function calculateCanBoost(
  token: StrengthToken,
  answerValue: string
): CanBoostResult {
  const question = CAN_VALIDATION_QUESTIONS[token]
  if (!question) {
    return { token, boost: 0, evidence_level: 'none' }
  }

  switch (answerValue) {
    case 'strong_evidence':
      return { token, boost: question.can_boost_on_verified, evidence_level: 'strong' }
    case 'some_evidence':
      return { token, boost: Math.round(question.can_boost_on_verified * 0.5), evidence_level: 'partial' }
    case 'potential':
    default:
      return { token, boost: 0, evidence_level: 'none' }
  }
}

/**
 * 여러 Can 검증 결과들의 총 boost 계산
 * - MAX_CAN_BOOST_CAP 적용 (과도한 Can 부풀림 방지)
 */
export function calculateTotalCanBoost(
  results: CanBoostResult[],
  maxCap: number = 50  // MAPPING_POLICY.MAX_TOTAL_CAN_BOOST와 일치
): number {
  const totalBoost = results.reduce((sum, r) => sum + r.boost, 0)
  return Math.min(totalBoost, maxCap)
}

// ============================================
// 검증 상태 추적
// ============================================
export interface CanValidationState {
  verified_strengths: {
    token: StrengthToken
    evidence_level: 'strong' | 'partial' | 'none'
    boost_applied: number
  }[]
  total_can_boost: number
  questions_asked: number
}

export function createEmptyValidationState(): CanValidationState {
  return {
    verified_strengths: [],
    total_can_boost: 0,
    questions_asked: 0
  }
}

export function updateValidationState(
  state: CanValidationState,
  result: CanBoostResult
): CanValidationState {
  return {
    verified_strengths: [
      ...state.verified_strengths,
      {
        token: result.token,
        evidence_level: result.evidence_level,
        boost_applied: result.boost
      }
    ],
    total_can_boost: calculateTotalCanBoost([
      ...state.verified_strengths.map(v => ({
        token: v.token,
        boost: v.boost_applied,
        evidence_level: v.evidence_level
      })),
      result
    ]),
    questions_asked: state.questions_asked + 1
  }
}
