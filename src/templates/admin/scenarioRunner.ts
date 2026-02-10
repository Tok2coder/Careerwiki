// CareerWiki AI Analyzer - Scenario Runner
// Version: v1.0.0
//
// 시나리오 테스트 E2E 자동 실행기
// 실제 사용자 흐름을 시뮬레이션

import { getScenarioById, type TestScenario } from '../../services/ai-analyzer/test-scenarios'
import { AutoAnswerGenerator } from './autoAnswerGenerator'
import { ScenarioProgressUI } from './scenarioProgressUI'

export interface ScenarioRunnerOptions {
  delayBetweenSteps?: number  // 스텝 간 딜레이 (ms)
  autoNavigateToResult?: boolean  // 완료 후 결과 페이지로 이동
}

export interface RunResult {
  success: boolean
  sessionId?: string
  requestId?: number
  error?: string
  duration: number
}

export class ScenarioRunner {
  private scenario: TestScenario
  private answerGenerator: AutoAnswerGenerator
  private progressUI: ScenarioProgressUI
  private options: Required<ScenarioRunnerOptions>

  private isRunning: boolean = false
  private isPaused: boolean = false
  private shouldStop: boolean = false

  private sessionId: string = ''
  private requestId: number = 0
  private startTime: number = 0

  private readonly API_BASE = '/api/ai-analyzer'

  constructor(scenarioId: string, options: ScenarioRunnerOptions = {}) {
    const scenario = getScenarioById(scenarioId)
    if (!scenario) {
      throw new Error(`시나리오를 찾을 수 없습니다: ${scenarioId}`)
    }

    this.scenario = scenario
    this.answerGenerator = new AutoAnswerGenerator(scenario)
    this.progressUI = new ScenarioProgressUI()

    this.options = {
      delayBetweenSteps: options.delayBetweenSteps ?? 1000,
      autoNavigateToResult: options.autoNavigateToResult ?? true,
    }
  }

  /**
   * 시나리오 실행 시작
   */
  async start(): Promise<RunResult> {
    if (this.isRunning) {
      throw new Error('시나리오가 이미 실행 중입니다')
    }

    this.isRunning = true
    this.isPaused = false
    this.shouldStop = false
    this.startTime = Date.now()

    // Progress UI 표시
    this.progressUI.show(this.scenario.name)
    this.setupProgressCallbacks()

    this.progressUI.log(`시나리오 시작: ${this.scenario.name}`, 'info')
    this.progressUI.log(`설명: ${this.scenario.description}`, 'info')

    try {
      // Step 1: 프로필 입력 (미니모듈 결과 + 커리어 상태)
      await this.runStep1()
      if (this.shouldStop) throw new Error('사용자에 의해 중지됨')

      // Step 2-1: 기본 심층질문 (내러티브 답변)
      await this.runStep2Narrative()
      if (this.shouldStop) throw new Error('사용자에 의해 중지됨')

      // Step 2-2~4: LLM 라운드 1, 2, 3
      for (let round = 1; round <= 3; round++) {
        await this.runStep2Round(round)
        if (this.shouldStop) throw new Error('사용자에 의해 중지됨')
      }

      // Step 3: 결과 분석 및 추천
      await this.runStep3()

      const duration = Date.now() - this.startTime
      this.progressUI.log(`총 소요 시간: ${(duration / 1000).toFixed(1)}초`, 'success')
      this.progressUI.showComplete(`시나리오 테스트 완료! (${(duration / 1000).toFixed(1)}초)`)

      // 결과 페이지로 이동
      if (this.options.autoNavigateToResult && this.requestId) {
        setTimeout(() => {
          window.location.href = `/analyzer/result/${this.requestId}`
        }, 2000)
      }

      return {
        success: true,
        sessionId: this.sessionId,
        requestId: this.requestId,
        duration,
      }

    } catch (error) {
      const duration = Date.now() - this.startTime
      const errorMessage = error instanceof Error ? error.message : '알 수 없는 오류'
      this.progressUI.log(`오류: ${errorMessage}`, 'error')
      this.progressUI.showError(errorMessage)

      return {
        success: false,
        error: errorMessage,
        duration,
      }

    } finally {
      this.isRunning = false
    }
  }

  /**
   * Progress UI 콜백 설정
   */
  private setupProgressCallbacks(): void {
    this.progressUI.onPause(() => {
      this.isPaused = true
    })

    this.progressUI.onResume(() => {
      this.isPaused = false
    })

    this.progressUI.onStop(() => {
      this.shouldStop = true
    })
  }

  /**
   * 일시정지 대기
   */
  private async waitWhilePaused(): Promise<void> {
    while (this.isPaused && !this.shouldStop) {
      await this.delay(100)
    }
  }

  /**
   * Step 1: 프로필 입력
   * - 미니모듈 5축 선택
   * - 커리어 상태 설정
   */
  private async runStep1(): Promise<void> {
    this.progressUI.updateStep(0, 'in_progress')
    this.progressUI.log('Step 1: 프로필 데이터 제출 중...', 'info')

    await this.waitWhilePaused()

    const miniModule = this.answerGenerator.getMiniModuleResult()
    const careerState = this.answerGenerator.getCareerState()

    this.progressUI.log(`커리어 상태: ${careerState}`, 'info')
    this.progressUI.log(`관심사: ${miniModule.interest_top.join(', ')}`, 'info')

    // 세션 생성 및 프로필 제출
    const response = await fetch(`${this.API_BASE}/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        step: 'profile',
        mini_module_result: miniModule,
        career_state: careerState,
      }),
    })

    if (!response.ok) {
      throw new Error(`프로필 제출 실패: ${response.status}`)
    }

    const data = await response.json()
    this.sessionId = data.session_id || data.sessionId || ''
    this.requestId = data.request_id || data.requestId || 0

    this.progressUI.log(`세션 ID: ${this.sessionId}`, 'success')
    this.progressUI.updateStep(0, 'completed', '완료')

    await this.delay(this.options.delayBetweenSteps)
  }

  /**
   * Step 2-1: 내러티브 질문 응답
   */
  private async runStep2Narrative(): Promise<void> {
    this.progressUI.updateStep(1, 'in_progress')
    this.progressUI.log('Step 2-1: 내러티브 답변 제출 중...', 'info')

    await this.waitWhilePaused()

    const narrativeAnswers = {
      motivation: this.answerGenerator.getNarrativeAnswer('motivation'),
      avoidance: this.answerGenerator.getNarrativeAnswer('avoidance'),
      constraints: this.answerGenerator.getNarrativeAnswer('constraints'),
    }

    this.progressUI.log(`동기: "${narrativeAnswers.motivation.substring(0, 50)}..."`, 'info')

    const response = await fetch(`${this.API_BASE}/v3/narrative-facts`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        request_id: this.requestId,
        answers: narrativeAnswers,
      }),
    })

    if (!response.ok) {
      throw new Error(`내러티브 답변 제출 실패: ${response.status}`)
    }

    this.progressUI.log('내러티브 답변 제출 완료', 'success')
    this.progressUI.updateStep(1, 'completed', '완료')

    await this.delay(this.options.delayBetweenSteps)
  }

  /**
   * Step 2-2~4: LLM 라운드 질문-응답
   */
  private async runStep2Round(round: number): Promise<void> {
    const stepIndex = round + 1  // round 1 -> step index 2

    this.progressUI.updateStep(stepIndex, 'in_progress')
    this.progressUI.log(`Step 2-${round + 1}: LLM 라운드 ${round} 진행 중...`, 'info')

    await this.waitWhilePaused()

    // 1. 질문 요청
    const questionsResponse = await fetch(`${this.API_BASE}/v3/round-questions`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        request_id: this.requestId,
        round: round,
      }),
    })

    if (!questionsResponse.ok) {
      throw new Error(`라운드 ${round} 질문 요청 실패: ${questionsResponse.status}`)
    }

    const questionsData = await questionsResponse.json()
    const questions = questionsData.questions || []

    this.progressUI.log(`라운드 ${round}: ${questions.length}개 질문 수신`, 'info')

    // 2. 각 질문에 대한 답변 생성
    const answers: Array<{ question: string; answer: string }> = []

    for (const q of questions) {
      const questionText = typeof q === 'string' ? q : q.question || q.text
      const { answer, matchType } = this.answerGenerator.generateAnswer(questionText, round)

      answers.push({
        question: questionText,
        answer: answer,
      })

      this.progressUI.log(`Q: "${questionText.substring(0, 40)}..."`, 'info')
      this.progressUI.log(`A (${matchType}): "${answer.substring(0, 40)}..."`, 'success')

      await this.waitWhilePaused()
      await this.delay(300)  // 자연스러운 진행을 위한 짧은 딜레이
    }

    // 3. 답변 제출
    const answersResponse = await fetch(`${this.API_BASE}/v3/round-answers`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        request_id: this.requestId,
        round: round,
        answers: answers,
      }),
    })

    if (!answersResponse.ok) {
      throw new Error(`라운드 ${round} 답변 제출 실패: ${answersResponse.status}`)
    }

    this.progressUI.log(`라운드 ${round} 완료`, 'success')
    this.progressUI.updateStep(stepIndex, 'completed', `${answers.length}개 답변`)

    await this.delay(this.options.delayBetweenSteps)
  }

  /**
   * Step 3: 결과 분석 및 추천
   */
  private async runStep3(): Promise<void> {
    this.progressUI.updateStep(5, 'in_progress')
    this.progressUI.log('Step 3: 최종 분석 및 추천 요청 중...', 'info')

    await this.waitWhilePaused()

    // 미니모듈 기반 SearchProfile 구성
    const miniModule = this.answerGenerator.getMiniModuleResult()
    const searchProfile = {
      desiredThemes: [
        ...(miniModule.interest_top || []),
        ...(miniModule.value_top || []),
      ].filter(Boolean),
      dislikedThemes: [] as string[],
      strengthsHypothesis: miniModule.strength_top || [],
      environmentPreferences: [] as string[],
      hardConstraints: miniModule.constraint_flags || [],
      riskSignals: [] as string[],
      keywords: [
        ...(miniModule.interest_top || []),
        ...(miniModule.strength_top || []),
      ].filter(Boolean),
    }

    // 추천 요청
    const response = await fetch(`${this.API_BASE}/v3/recommend`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        searchProfile,
        mini_module_result: miniModule,
        topK: 800,
        judgeTopN: 20,
      }),
    })

    if (!response.ok) {
      const errorBody = await response.text()
      throw new Error(`추천 요청 실패: ${response.status} - ${errorBody.substring(0, 200)}`)
    }

    const data = await response.json()

    // 결과 요약 로그
    if (data.recommendations?.top_jobs?.length > 0) {
      const topJob = data.recommendations.top_jobs[0]
      this.progressUI.log(`추천 1위: ${topJob.job_name} (Fit: ${topJob.fit_score || 'N/A'})`, 'success')
    } else if (data.recommendations && data.recommendations.length > 0) {
      const topJob = data.recommendations[0]
      this.progressUI.log(`추천 1위: ${topJob.job_name} (Fit: ${topJob.scores?.fit || 'N/A'})`, 'success')
    }

    this.progressUI.log('결과 분석 완료', 'success')
    this.progressUI.updateStep(5, 'completed', '완료')
  }

  /**
   * 딜레이 유틸리티
   */
  private delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms))
  }

  /**
   * 시나리오 정보 반환
   */
  getScenarioInfo() {
    return this.answerGenerator.getScenarioInfo()
  }

  /**
   * 실행 상태 확인
   */
  get running(): boolean {
    return this.isRunning
  }

  /**
   * 일시정지 상태 확인
   */
  get paused(): boolean {
    return this.isPaused
  }

  /**
   * 수동 중지
   */
  stop(): void {
    this.shouldStop = true
  }
}

/**
 * 시나리오 실행 헬퍼 함수
 */
export async function runScenario(
  scenarioId: string,
  options?: ScenarioRunnerOptions
): Promise<RunResult> {
  const runner = new ScenarioRunner(scenarioId, options)
  return runner.start()
}
