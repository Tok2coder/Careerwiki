// CareerWiki AI Analyzer - Auto Answer Generator
// Version: v1.0.0
//
// LLM 질문에 대한 자동 답변 생성기
// 패턴 매칭 + 폴백 전략 사용

import type { TestScenario, LLMFollowupPattern } from '../../services/ai-analyzer/test-scenarios'

export class AutoAnswerGenerator {
  private scenario: TestScenario
  private llmFollowupAnswers: LLMFollowupPattern[]
  private usedFallbackIndices: Record<string, number> = {}

  constructor(scenario: TestScenario) {
    this.scenario = scenario
    this.llmFollowupAnswers = scenario.llmFollowupAnswers
  }

  /**
   * LLM 질문에 대한 답변 생성
   * 1. 패턴 매칭 시도
   * 2. 실패 시 라운드별 폴백 답변 사용
   */
  generateAnswer(question: string, round: number): {
    answer: string
    matchType: 'pattern' | 'fallback' | 'default'
    expectedFactKey?: string
  } {
    // 1. 패턴 매칭 시도
    const patternMatch = this.findPatternMatch(question)
    if (patternMatch) {
      return {
        answer: patternMatch.answer,
        matchType: 'pattern',
        expectedFactKey: patternMatch.expectedFactKey,
      }
    }

    // 2. 라운드별 폴백 답변 사용
    const fallbackAnswer = this.getFallbackAnswer(round)
    if (fallbackAnswer) {
      return {
        answer: fallbackAnswer,
        matchType: 'fallback',
      }
    }

    // 3. 최종 기본 답변
    return {
      answer: this.getDefaultAnswer(round),
      matchType: 'default',
    }
  }

  /**
   * 패턴 매칭으로 답변 찾기
   */
  private findPatternMatch(question: string): {
    answer: string
    expectedFactKey?: string
  } | null {
    const normalizedQuestion = question.toLowerCase()

    for (const pattern of this.llmFollowupAnswers) {
      const keywords = pattern.questionPattern.split('|')
      const isMatch = keywords.some(keyword =>
        normalizedQuestion.includes(keyword.toLowerCase())
      )

      if (isMatch) {
        return {
          answer: pattern.answer,
          expectedFactKey: pattern.expectedFactKey,
        }
      }
    }

    return null
  }

  /**
   * 라운드별 폴백 답변 (순차적으로 사용)
   */
  private getFallbackAnswer(round: number): string | null {
    const roundKey = `round${round}` as keyof typeof this.scenario.roundFallbackAnswers
    const fallbacks = this.scenario.roundFallbackAnswers?.[roundKey]

    if (!fallbacks || fallbacks.length === 0) {
      return null
    }

    // 이미 사용한 폴백 인덱스 추적
    const key = `round${round}`
    const usedIndex = this.usedFallbackIndices[key] || 0

    if (usedIndex >= fallbacks.length) {
      // 모든 폴백을 사용했으면 랜덤으로 선택
      return fallbacks[Math.floor(Math.random() * fallbacks.length)]
    }

    // 순차적으로 사용
    this.usedFallbackIndices[key] = usedIndex + 1
    return fallbacks[usedIndex]
  }

  /**
   * 라운드별 기본 답변
   */
  private getDefaultAnswer(round: number): string {
    switch (round) {
      case 1:
        return '이 분야에서 성장하고 전문성을 쌓고 싶습니다.'
      case 2:
        return '지나치게 반복적이거나 성장 기회가 없는 환경은 피하고 싶습니다.'
      case 3:
        return '현실적인 조건 내에서 최선의 선택을 하고 싶습니다.'
      default:
        return '잘 모르겠지만 열심히 해보겠습니다.'
    }
  }

  /**
   * 내러티브 질문 답변 (심층 기초질문용)
   */
  getNarrativeAnswer(questionType: 'motivation' | 'avoidance' | 'constraints'): string {
    return this.scenario.narrativeAnswers?.[questionType] || this.getDefaultNarrativeAnswer(questionType)
  }

  /**
   * 기본 내러티브 답변
   */
  private getDefaultNarrativeAnswer(questionType: 'motivation' | 'avoidance' | 'constraints'): string {
    switch (questionType) {
      case 'motivation':
        return '관심 있는 분야에서 전문성을 쌓고 성장하고 싶습니다.'
      case 'avoidance':
        return '맞지 않는 환경이나 성장 기회가 없는 곳은 피하고 싶습니다.'
      case 'constraints':
        return '현실적인 조건을 고려해서 결정하겠습니다.'
      default:
        return '일반적인 수준입니다.'
    }
  }

  /**
   * 커리어 상태 반환
   */
  getCareerState(): string {
    return this.scenario.careerState || 'job_seeker'
  }

  /**
   * 미니모듈 결과 반환
   */
  getMiniModuleResult() {
    return this.scenario.miniModule
  }

  /**
   * Can 검증 답변 반환
   */
  getCanValidationAnswer(questionId: string): string {
    return this.scenario.canValidationAnswers[questionId] || 'study_only'
  }

  /**
   * 제약 강도 답변 반환
   */
  getConstraintIntensityAnswer(questionId: string): string {
    return this.scenario.constraintIntensityAnswers[questionId] || 'prefer_avoid'
  }

  /**
   * 시나리오 정보 반환
   */
  getScenarioInfo() {
    return {
      id: this.scenario.id,
      name: this.scenario.name,
      description: this.scenario.description,
      category: this.scenario.category,
    }
  }

  /**
   * 폴백 인덱스 리셋 (새 라운드 시작 시)
   */
  resetFallbackIndices() {
    this.usedFallbackIndices = {}
  }
}
