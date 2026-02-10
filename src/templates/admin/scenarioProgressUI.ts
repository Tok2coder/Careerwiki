// CareerWiki AI Analyzer - Scenario Progress UI
// Version: v1.0.0
//
// 시나리오 테스트 진행 상황 시각화 UI

export interface ProgressStep {
  name: string
  status: 'pending' | 'in_progress' | 'completed' | 'error'
  detail?: string
}

export class ScenarioProgressUI {
  private container: HTMLElement | null = null
  private logContainer: HTMLElement | null = null
  private stepsContainer: HTMLElement | null = null
  private currentStepElement: HTMLElement | null = null
  private progressBar: HTMLElement | null = null
  private isPaused: boolean = false
  private onPauseCallback: (() => void) | null = null
  private onResumeCallback: (() => void) | null = null
  private onStopCallback: (() => void) | null = null

  private steps: ProgressStep[] = [
    { name: 'Step 1: 프로필 입력', status: 'pending' },
    { name: 'Step 2-1: 기본 심층질문', status: 'pending' },
    { name: 'Step 2-2: LLM 라운드 1 (욕망)', status: 'pending' },
    { name: 'Step 2-3: LLM 라운드 2 (회피)', status: 'pending' },
    { name: 'Step 2-4: LLM 라운드 3 (현실)', status: 'pending' },
    { name: 'Step 3: 결과 분석', status: 'pending' },
  ]

  /**
   * Progress UI 표시
   */
  show(scenarioName: string): void {
    // 기존 UI 제거
    this.hide()

    // 오버레이 컨테이너 생성
    this.container = document.createElement('div')
    this.container.id = 'scenario-progress-overlay'
    this.container.innerHTML = `
      <div class="scenario-progress-modal">
        <div class="scenario-progress-header">
          <h2>시나리오 테스트 실행 중</h2>
          <span class="scenario-name">${scenarioName}</span>
        </div>

        <div class="scenario-progress-steps" id="progress-steps"></div>

        <div class="scenario-progress-bar-container">
          <div class="scenario-progress-bar" id="progress-bar"></div>
        </div>

        <div class="scenario-current-step" id="current-step">
          준비 중...
        </div>

        <div class="scenario-log-container" id="log-container"></div>

        <div class="scenario-progress-controls">
          <button id="pause-btn" class="btn btn-warning">일시정지</button>
          <button id="stop-btn" class="btn btn-danger">중지</button>
        </div>
      </div>
    `

    // 스타일 추가
    this.addStyles()

    // DOM에 추가
    document.body.appendChild(this.container)

    // 요소 참조 저장
    this.logContainer = document.getElementById('log-container')
    this.stepsContainer = document.getElementById('progress-steps')
    this.currentStepElement = document.getElementById('current-step')
    this.progressBar = document.getElementById('progress-bar')

    // 스텝 UI 렌더링
    this.renderSteps()

    // 버튼 이벤트 바인딩
    this.bindEvents()
  }

  /**
   * 스타일 추가
   */
  private addStyles(): void {
    if (document.getElementById('scenario-progress-styles')) return

    const style = document.createElement('style')
    style.id = 'scenario-progress-styles'
    style.textContent = `
      #scenario-progress-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        z-index: 10000;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .scenario-progress-modal {
        background: #1a1a2e;
        border-radius: 16px;
        padding: 32px;
        width: 90%;
        max-width: 700px;
        max-height: 90vh;
        overflow-y: auto;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
        color: #fff;
      }

      .scenario-progress-header {
        text-align: center;
        margin-bottom: 24px;
      }

      .scenario-progress-header h2 {
        margin: 0 0 8px 0;
        font-size: 24px;
        color: #fff;
      }

      .scenario-name {
        color: #4ade80;
        font-size: 18px;
        font-weight: 600;
      }

      .scenario-progress-steps {
        display: flex;
        flex-direction: column;
        gap: 8px;
        margin-bottom: 24px;
      }

      .step-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 16px;
        background: #16213e;
        border-radius: 8px;
        transition: all 0.3s ease;
      }

      .step-item.pending {
        opacity: 0.5;
      }

      .step-item.in_progress {
        background: #1e3a5f;
        border-left: 3px solid #4ade80;
        animation: pulse 1.5s infinite;
      }

      .step-item.completed {
        background: #1e3a2f;
        opacity: 1;
      }

      .step-item.error {
        background: #3a1e1e;
        border-left: 3px solid #f87171;
      }

      @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.7; }
      }

      .step-icon {
        width: 24px;
        height: 24px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
      }

      .step-icon.pending { background: #374151; }
      .step-icon.in_progress { background: #3b82f6; }
      .step-icon.completed { background: #10b981; }
      .step-icon.error { background: #ef4444; }

      .step-name {
        flex: 1;
        font-size: 14px;
      }

      .step-detail {
        font-size: 12px;
        color: #9ca3af;
      }

      .scenario-progress-bar-container {
        height: 8px;
        background: #374151;
        border-radius: 4px;
        overflow: hidden;
        margin-bottom: 16px;
      }

      .scenario-progress-bar {
        height: 100%;
        background: linear-gradient(90deg, #3b82f6, #10b981);
        width: 0%;
        transition: width 0.5s ease;
      }

      .scenario-current-step {
        text-align: center;
        padding: 16px;
        background: #16213e;
        border-radius: 8px;
        margin-bottom: 16px;
        font-size: 16px;
        min-height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .scenario-log-container {
        background: #0f0f1a;
        border-radius: 8px;
        padding: 16px;
        max-height: 200px;
        overflow-y: auto;
        font-family: monospace;
        font-size: 12px;
        margin-bottom: 24px;
      }

      .log-entry {
        padding: 4px 0;
        border-bottom: 1px solid #1a1a2e;
      }

      .log-entry.info { color: #60a5fa; }
      .log-entry.success { color: #4ade80; }
      .log-entry.warning { color: #fbbf24; }
      .log-entry.error { color: #f87171; }

      .scenario-progress-controls {
        display: flex;
        gap: 12px;
        justify-content: center;
      }

      .scenario-progress-controls .btn {
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
      }

      .btn-warning {
        background: #f59e0b;
        color: #000;
      }

      .btn-warning:hover {
        background: #d97706;
      }

      .btn-danger {
        background: #ef4444;
        color: #fff;
      }

      .btn-danger:hover {
        background: #dc2626;
      }

      .btn-success {
        background: #10b981;
        color: #fff;
      }

      .btn-success:hover {
        background: #059669;
      }
    `
    document.head.appendChild(style)
  }

  /**
   * 스텝 UI 렌더링
   */
  private renderSteps(): void {
    if (!this.stepsContainer) return

    this.stepsContainer.innerHTML = this.steps.map((step, index) => `
      <div class="step-item ${step.status}" id="step-${index}">
        <div class="step-icon ${step.status}">
          ${this.getStepIcon(step.status)}
        </div>
        <span class="step-name">${step.name}</span>
        ${step.detail ? `<span class="step-detail">${step.detail}</span>` : ''}
      </div>
    `).join('')
  }

  /**
   * 스텝 아이콘 반환
   */
  private getStepIcon(status: ProgressStep['status']): string {
    switch (status) {
      case 'pending': return '○'
      case 'in_progress': return '◎'
      case 'completed': return '✓'
      case 'error': return '✗'
    }
  }

  /**
   * 버튼 이벤트 바인딩
   */
  private bindEvents(): void {
    const pauseBtn = document.getElementById('pause-btn')
    const stopBtn = document.getElementById('stop-btn')

    pauseBtn?.addEventListener('click', () => {
      if (this.isPaused) {
        this.isPaused = false
        pauseBtn.textContent = '일시정지'
        pauseBtn.classList.remove('btn-success')
        pauseBtn.classList.add('btn-warning')
        this.onResumeCallback?.()
        this.log('재개됨', 'info')
      } else {
        this.isPaused = true
        pauseBtn.textContent = '재개'
        pauseBtn.classList.remove('btn-warning')
        pauseBtn.classList.add('btn-success')
        this.onPauseCallback?.()
        this.log('일시정지됨', 'warning')
      }
    })

    stopBtn?.addEventListener('click', () => {
      if (confirm('시나리오 테스트를 중지하시겠습니까?')) {
        this.onStopCallback?.()
        this.log('사용자에 의해 중지됨', 'error')
        this.hide()
      }
    })
  }

  /**
   * 스텝 업데이트
   */
  updateStep(stepIndex: number, status: ProgressStep['status'], detail?: string): void {
    if (stepIndex < 0 || stepIndex >= this.steps.length) return

    this.steps[stepIndex].status = status
    if (detail) this.steps[stepIndex].detail = detail

    this.renderSteps()
    this.updateProgressBar()

    if (this.currentStepElement && status === 'in_progress') {
      this.currentStepElement.textContent = `${this.steps[stepIndex].name}...`
    }
  }

  /**
   * 프로그레스 바 업데이트
   */
  private updateProgressBar(): void {
    if (!this.progressBar) return

    const completed = this.steps.filter(s => s.status === 'completed').length
    const progress = (completed / this.steps.length) * 100
    this.progressBar.style.width = `${progress}%`
  }

  /**
   * 현재 스텝 메시지 업데이트
   */
  setCurrentMessage(message: string): void {
    if (this.currentStepElement) {
      this.currentStepElement.textContent = message
    }
  }

  /**
   * 로그 추가
   */
  log(message: string, type: 'info' | 'success' | 'warning' | 'error' = 'info'): void {
    if (!this.logContainer) return

    const timestamp = new Date().toLocaleTimeString()
    const entry = document.createElement('div')
    entry.className = `log-entry ${type}`
    entry.textContent = `[${timestamp}] ${message}`

    this.logContainer.appendChild(entry)
    this.logContainer.scrollTop = this.logContainer.scrollHeight
  }

  /**
   * Progress UI 숨기기
   */
  hide(): void {
    if (this.container) {
      this.container.remove()
      this.container = null
    }
  }

  /**
   * 콜백 설정
   */
  onPause(callback: () => void): void {
    this.onPauseCallback = callback
  }

  onResume(callback: () => void): void {
    this.onResumeCallback = callback
  }

  onStop(callback: () => void): void {
    this.onStopCallback = callback
  }

  /**
   * 일시정지 상태 확인
   */
  get paused(): boolean {
    return this.isPaused
  }

  /**
   * 완료 표시
   */
  showComplete(message: string = '시나리오 테스트 완료!'): void {
    if (this.currentStepElement) {
      this.currentStepElement.innerHTML = `
        <div style="text-align: center;">
          <div style="font-size: 48px; margin-bottom: 8px;">✓</div>
          <div style="color: #4ade80; font-size: 18px;">${message}</div>
        </div>
      `
    }

    // 버튼 변경
    const pauseBtn = document.getElementById('pause-btn')
    const stopBtn = document.getElementById('stop-btn')
    if (pauseBtn) pauseBtn.style.display = 'none'
    if (stopBtn) {
      stopBtn.textContent = '닫기'
      stopBtn.classList.remove('btn-danger')
      stopBtn.classList.add('btn-success')
      stopBtn.onclick = () => this.hide()
    }
  }

  /**
   * 에러 표시
   */
  showError(message: string): void {
    if (this.currentStepElement) {
      this.currentStepElement.innerHTML = `
        <div style="text-align: center;">
          <div style="font-size: 48px; margin-bottom: 8px; color: #f87171;">✗</div>
          <div style="color: #f87171; font-size: 18px;">${message}</div>
        </div>
      `
    }

    // 버튼 변경
    const pauseBtn = document.getElementById('pause-btn')
    const stopBtn = document.getElementById('stop-btn')
    if (pauseBtn) pauseBtn.style.display = 'none'
    if (stopBtn) {
      stopBtn.textContent = '닫기'
      stopBtn.onclick = () => this.hide()
    }
  }
}
