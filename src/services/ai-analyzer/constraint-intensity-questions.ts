/**
 * Constraint Intensity Questions (제약 강도 질문)
 *
 * P1: 유저가 선택한 제약 조건의 강도를 확인
 * - absolute: 절대 불가 (건강/가족 이유)
 * - prefer_avoid: 가능하면 피하고 싶음
 * - acceptable: 가끔은 괜찮음
 *
 * 강도에 따라 Hard Exclusion vs Risk Penalty 결정
 */

import type { UserConstraints } from './types'
import type { ConstraintIntensity } from './tag-filter'

// ============================================
// 제약 강도 확인 질문 정의
// ============================================
export interface ConstraintIntensityQuestion {
  id: string
  trigger: keyof UserConstraints
  question: string
  options: ConstraintIntensityOption[]
  factKey: string
}

export interface ConstraintIntensityOption {
  value: ConstraintIntensity
  label: string
  penaltyMultiplier: number
  emoji: string
}

// ============================================
// 제약별 강도 확인 질문
// ============================================
export const CONSTRAINT_INTENSITY_QUESTIONS: ConstraintIntensityQuestion[] = [
  // 1. 시간 제약 (야근/근무시간)
  {
    id: 'intensity_time',
    trigger: 'work_hours_strict',
    question: '야근이 어려우시다고 하셨는데, 어느 정도인가요?',
    options: [
      { value: 'absolute', label: '절대 불가 (가족/건강 이유)', penaltyMultiplier: 1.5, emoji: '🚫' },
      { value: 'prefer_avoid', label: '가능하면 피하고 싶음', penaltyMultiplier: 1.0, emoji: '😣' },
      { value: 'acceptable', label: '가끔은 괜찮음', penaltyMultiplier: 0.3, emoji: '🤷' },
    ],
    factKey: 'constraint.time.intensity',
  },

  // 2. 육체적 제약
  {
    id: 'intensity_physical',
    trigger: 'physical_labor_no',
    question: '육체적으로 힘든 일이 어렵다고 하셨는데, 어느 정도인가요?',
    options: [
      { value: 'absolute', label: '건강상 절대 불가', penaltyMultiplier: 1.5, emoji: '🚫' },
      { value: 'prefer_avoid', label: '가능하면 피하고 싶음', penaltyMultiplier: 1.0, emoji: '😣' },
      { value: 'acceptable', label: '적당히는 괜찮음', penaltyMultiplier: 0.3, emoji: '🤷' },
    ],
    factKey: 'constraint.physical.intensity',
  },

  // 3. 야근 선호 제약
  {
    id: 'intensity_overtime',
    trigger: 'prefer_low_overtime',
    question: '야근을 피하고 싶다고 하셨는데, 어느 정도인가요?',
    options: [
      { value: 'absolute', label: '절대 불가 (가정 사정)', penaltyMultiplier: 1.5, emoji: '🚫' },
      { value: 'prefer_avoid', label: '가능하면 줄이고 싶음', penaltyMultiplier: 1.0, emoji: '😣' },
      { value: 'acceptable', label: '가끔은 괜찮음', penaltyMultiplier: 0.3, emoji: '🤷' },
    ],
    factKey: 'constraint.overtime.intensity',
  },

  // 4. 원격근무 필수
  {
    id: 'intensity_remote',
    trigger: 'remote_only',
    question: '원격근무가 필수라고 하셨는데, 어느 정도인가요?',
    options: [
      { value: 'absolute', label: '완전 원격만 가능 (지역/건강 이유)', penaltyMultiplier: 1.5, emoji: '🚫' },
      { value: 'prefer_avoid', label: '가능하면 원격이 좋음', penaltyMultiplier: 1.0, emoji: '😣' },
      { value: 'acceptable', label: '하이브리드도 괜찮음', penaltyMultiplier: 0.3, emoji: '🤷' },
    ],
    factKey: 'constraint.remote.intensity',
  },

  // 5. 교대근무 기피
  {
    id: 'intensity_shift',
    trigger: 'shift_work_no',
    question: '교대근무가 어렵다고 하셨는데, 어느 정도인가요?',
    options: [
      { value: 'absolute', label: '절대 불가 (생활 패턴 유지 필수)', penaltyMultiplier: 1.5, emoji: '🚫' },
      { value: 'prefer_avoid', label: '가능하면 피하고 싶음', penaltyMultiplier: 1.0, emoji: '😣' },
      { value: 'acceptable', label: '주기적이면 괜찮음', penaltyMultiplier: 0.3, emoji: '🤷' },
    ],
    factKey: 'constraint.shift.intensity',
  },
]

// ============================================
// 유틸리티 함수
// ============================================

/**
 * 트리거 제약에 해당하는 강도 질문 반환
 */
export function getIntensityQuestion(
  constraint: keyof UserConstraints
): ConstraintIntensityQuestion | undefined {
  return CONSTRAINT_INTENSITY_QUESTIONS.find(q => q.trigger === constraint)
}

/**
 * 유저가 선택한 제약들에 대한 강도 질문 목록 생성
 */
export function selectIntensityQuestions(
  userConstraints: Partial<UserConstraints>,
  alreadyAsked: string[]
): ConstraintIntensityQuestion[] {
  const questions: ConstraintIntensityQuestion[] = []

  for (const [constraint, value] of Object.entries(userConstraints)) {
    if (!value) continue

    const question = CONSTRAINT_INTENSITY_QUESTIONS.find(
      q => q.trigger === constraint && !alreadyAsked.includes(q.id)
    )

    if (question) {
      questions.push(question)
    }
  }

  return questions
}

/**
 * 강도 답변을 Fact로 변환
 */
export function convertIntensityToFact(
  questionId: string,
  selectedValue: ConstraintIntensity
): { factKey: string; intensity: ConstraintIntensity; multiplier: number } | null {
  const question = CONSTRAINT_INTENSITY_QUESTIONS.find(q => q.id === questionId)
  if (!question) return null

  const option = question.options.find(o => o.value === selectedValue)
  if (!option) return null

  return {
    factKey: question.factKey,
    intensity: selectedValue,
    multiplier: option.penaltyMultiplier,
  }
}

/**
 * 제약의 강도 조회 (facts에서)
 */
export function getConstraintIntensity(
  constraint: keyof UserConstraints,
  facts: Array<{ fact_key: string; value_json: string }>
): ConstraintIntensity {
  const question = getIntensityQuestion(constraint)
  if (!question) return 'prefer_avoid'  // 기본값

  const fact = facts.find(f => f.fact_key === question.factKey)
  if (!fact) return 'prefer_avoid'

  try {
    const value = JSON.parse(fact.value_json)
    if (['absolute', 'prefer_avoid', 'acceptable'].includes(value)) {
      return value as ConstraintIntensity
    }
  } catch {
    // ignore
  }

  return 'prefer_avoid'
}

/**
 * 모든 제약의 강도 맵 생성
 */
export function buildConstraintIntensityMap(
  userConstraints: Partial<UserConstraints>,
  facts: Array<{ fact_key: string; value_json: string }>
): Map<keyof UserConstraints, ConstraintIntensity> {
  const map = new Map<keyof UserConstraints, ConstraintIntensity>()

  for (const constraint of Object.keys(userConstraints) as (keyof UserConstraints)[]) {
    if (userConstraints[constraint]) {
      map.set(constraint, getConstraintIntensity(constraint, facts))
    }
  }

  return map
}
