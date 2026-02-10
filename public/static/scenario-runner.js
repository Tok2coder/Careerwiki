/**
 * CareerWiki AI Analyzer - Scenario Runner (Client-Side)
 * Version: v1.0.0
 *
 * 시나리오 테스트 E2E 자동 실행기
 * 실제 사용자 흐름을 시뮬레이션
 */

// ============================================
// 시나리오 데이터 (서버에서 가져옴)
// ============================================

const SCENARIOS = {
  analytical_user: {
    id: 'analytical_user',
    name: '분석형 유저',
    careerState: 'employed',
    miniModule: {
      interest_top: ['data_numbers', 'problem_solving', 'research'],
      value_top: ['autonomy', 'growth', 'expertise'],
      strength_top: ['analytical', 'fast_learning', 'persistence'],
      constraint_flags: ['work_hours_strict'],
      workstyle_top: ['solo_deep', 'structured'],
      background_flags: ['has_degree', 'tech_experience'],
      language_skills: [],
      sacrifice_flags: ['low_initial_income'],
      energy_drain_flags: ['people_drain'],
      achievement_feedback_top: ['mastery', 'recognition'],
      execution_style: 'planner',
      impact_scope: 'specialist',
      failure_response: 'analyze_improve',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'selective_listen',
    },
    narrativeAnswers: {
      motivation: '데이터를 통해 숨겨진 인사이트를 발견하고, 이를 바탕으로 비즈니스 의사결정에 기여하고 싶습니다. 복잡한 문제를 분석해서 해결책을 찾을 때 가장 보람을 느낍니다.',
      avoidance: '반복적인 단순 업무나 사람들과 끊임없이 소통해야 하는 일은 피하고 싶습니다. 집중해서 깊이 파고들 시간이 없으면 답답함을 느낍니다.',
      constraints: '야근이 너무 잦으면 힘들지만, 프로젝트 마감 시에는 어느 정도 감수할 수 있습니다. 주 평균 주 50시간 이상은 피하고 싶습니다.',
    },
    llmPatterns: {
      '분석|데이터|통계': '데이터 분석 관련 업무를 3년 이상 해왔습니다. SQL과 Python을 주로 사용합니다.',
      '야근|근무시간|워라밸': '야근이 너무 잦으면 힘들지만, 가끔은 괜찮습니다.',
      '성장|커리어|발전': '전문성을 쌓아서 시니어 데이터 분석가가 되고 싶습니다.',
    },
    roundFallbacks: {
      round1: ['전문성을 인정받는 시니어 분석가가 되고 싶습니다.', '복잡한 데이터에서 의미 있는 패턴을 발견할 때 흥분됩니다.', '자율적으로 분석 방향을 정하고 결과를 도출하는 것이 중요합니다.'],
      round2: ['정치적인 조직 문화나 비효율적인 프로세스는 지치게 합니다.', '분석보다 보고서 작성에 시간을 더 쓰는 건 피하고 싶습니다.', '의미 없는 회의가 많은 환경은 맞지 않습니다.'],
      round3: ['현재 연봉에서 10% 이상 상승을 기대합니다.', '리모트 워크가 가능하면 좋지만 필수는 아닙니다.', '서울 지역 내 출퇴근 1시간 이내가 좋습니다.'],
    },
  },

  stability_seeker: {
    id: 'stability_seeker',
    name: '안정 지향 유저',
    careerState: 'job_seeker',
    miniModule: {
      interest_top: ['helping', 'organizing', 'routine'],
      value_top: ['stability', 'wlb', 'income'],
      strength_top: ['structured_execution', 'persistence', 'communication'],
      constraint_flags: ['work_hours_strict', 'no_travel'],
      workstyle_top: ['team_harmony', 'structured'],
      background_flags: ['has_degree'],
      language_skills: [],
      sacrifice_flags: ['no_sacrifice'],
      energy_drain_flags: ['uncertainty_drain', 'time_pressure_drain'],
      achievement_feedback_top: ['stability', 'recognition'],
      execution_style: 'planner',
      impact_scope: 'team_org',
      failure_response: 'seek_support',
      persistence_anchor: 'stability_anchor',
      external_expectation: 'meet_expectations',
    },
    narrativeAnswers: {
      motivation: '오래 다닐 수 있는 안정적인 직장을 찾고 있습니다. 퇴근 후에는 가족과 시간을 보내고 싶고, 예측 가능한 삶을 원합니다.',
      avoidance: '불확실한 상황이나 갑작스러운 변화가 많은 환경은 스트레스입니다. 매일 다른 일을 해야 하거나 실적 압박이 심한 곳은 피하고 싶습니다.',
      constraints: '출장은 전혀 불가능합니다. 가정 사정으로 저녁 7시까지는 반드시 퇴근해야 합니다.',
    },
    llmPatterns: {
      '안정|고용|정규직': '정규직으로 오래 다닐 수 있는 회사를 찾고 있습니다.',
      '출장|이동|외근': '출장은 전혀 불가능합니다. 가정 사정이 있어서요.',
    },
    roundFallbacks: {
      round1: ['정년까지 안정적으로 근무할 수 있는 환경이 중요합니다.', '복리후생이 좋고 워라밸이 보장되면 좋겠습니다.', '승진보다는 꾸준히 일할 수 있는 것이 우선입니다.'],
      round2: ['실적 압박이 심하거나 경쟁이 치열한 환경은 맞지 않습니다.', '야근이 잦거나 주말 출근이 있는 곳은 절대 안 됩니다.', '불확실한 고용 형태나 계약직은 피하고 싶습니다.'],
      round3: ['현재 연봉 수준이면 괜찮습니다. 안정성이 더 중요합니다.', '집에서 대중교통으로 40분 이내 거리가 좋습니다.', '정규직만 고려하고 있습니다.'],
    },
  },

  internal_conflict: {
    id: 'internal_conflict',
    name: '내면갈등 유저',
    careerState: 'career_changer',
    miniModule: {
      interest_top: ['creative', 'problem_solving', 'research'],
      value_top: ['autonomy', 'stability'],
      strength_top: ['creative', 'analytical', 'fast_learning'],
      constraint_flags: ['work_hours_strict'],
      workstyle_top: ['solo_deep', 'flexible'],
      background_flags: ['has_degree', 'creative_portfolio'],
      language_skills: [],
      sacrifice_flags: ['no_sacrifice'],
      energy_drain_flags: ['routine_drain', 'time_pressure_drain'],
      achievement_feedback_top: ['autonomy', 'mastery'],
      execution_style: 'explorer',
      impact_scope: 'specialist',
      failure_response: 'analyze_improve',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'ignore',
    },
    narrativeAnswers: {
      motivation: '창의적인 일을 하고 싶고 제 방식대로 업무를 진행하고 싶습니다. 하지만 동시에 수입이 안정적이어야 마음이 편합니다. 둘 다 포기하기 어렵습니다.',
      avoidance: '루틴하고 반복적인 일은 지루해서 견디기 어렵습니다. 그런데 프리랜서처럼 수입이 불규칙한 것도 불안합니다.',
      constraints: '주말은 확실히 쉬고 싶고, 야근도 가능하면 피하고 싶습니다. 창의적인 일이지만 너무 불안정한 건 싫습니다.',
    },
    llmPatterns: {
      '자율|자유|재량': '업무 방식을 스스로 정할 수 있는 게 중요합니다.',
      '안정|보장|불안': '하지만 수입이 불안정하면 스트레스 받습니다.',
    },
    roundFallbacks: {
      round1: ['제 아이디어가 실제로 구현되는 것을 볼 때 가장 뿌듯합니다.', '업무 방식에 대한 자율성이 있으면 좋겠습니다.', '전문성을 인정받고 성장할 수 있는 환경을 원합니다.'],
      round2: ['매번 똑같은 일을 반복하는 건 정말 힘듭니다.', '하지만 수입이 들쑥날쑥하면 스트레스를 받습니다.', '창의성이 전혀 필요 없는 단순 업무는 피하고 싶습니다.'],
      round3: ['최소 연봉 4천만원 이상은 되어야 할 것 같습니다.', '정규직이 좋지만, 조건이 맞으면 계약직도 고려할 수 있습니다.', '서울 강남권이나 판교 쪽이 출퇴근하기 좋습니다.'],
    },
  },

  creative_user: {
    id: 'creative_user',
    name: '창의형 유저',
    careerState: 'student',
    miniModule: {
      interest_top: ['creative', 'design', 'art'],
      value_top: ['autonomy', 'creativity', 'recognition'],
      strength_top: ['creative', 'communication', 'fast_learning'],
      constraint_flags: [],
      workstyle_top: ['flexible', 'solo_deep'],
      background_flags: ['creative_portfolio', 'design_experience'],
      language_skills: [],
      sacrifice_flags: ['low_initial_income', 'unstable_hours'],
      energy_drain_flags: ['routine_drain', 'bureaucracy_drain'],
      achievement_feedback_top: ['recognition', 'mastery'],
      execution_style: 'explorer',
      impact_scope: 'wide_impact',
      failure_response: 'try_different',
      persistence_anchor: 'passion_anchor',
      external_expectation: 'ignore',
    },
    narrativeAnswers: {
      motivation: '디자인으로 사람들에게 감동을 주고 싶습니다. 제 작품이 세상에 나가서 누군가의 마음을 움직이는 것이 꿈입니다. 아트 디렉터가 되고 싶어요.',
      avoidance: '숫자만 다루거나 규칙에 얽매인 업무는 창의성을 죽이는 것 같아요. 관료적인 조직 문화도 답답합니다.',
      constraints: '초봉이 낮아도 괜찮습니다. 성장할 수 있는 환경이라면 야근도 감수할 수 있어요.',
    },
    llmPatterns: {
      '포트폴리오|작품|디자인': '디자인 관련 포트폴리오가 있고, 프리랜서로 일한 경험도 있습니다.',
      '팀|협업|클라이언트': '클라이언트와 직접 소통하며 일하는 것을 선호합니다.',
    },
    roundFallbacks: {
      round1: ['제 포트폴리오로 인정받는 디자이너가 되고 싶습니다.', '브랜딩이나 아이덴티티 디자인에 특히 관심이 있습니다.', '해외 유명 에이전시에서 일해보고 싶은 꿈이 있습니다.'],
      round2: ['단순 작업만 반복하는 \'손\'으로만 쓰이는 건 싫습니다.', '클라이언트가 창의성을 존중하지 않는 프로젝트는 힘듭니다.', '템플릿만 수정하는 일은 하고 싶지 않습니다.'],
      round3: ['첫 연봉은 3천만원대도 괜찮습니다. 배울 수 있다면요.', '서울 홍대나 성수동 쪽 에이전시가 좋을 것 같습니다.', '포트폴리오를 쌓을 수 있는 프로젝트가 많았으면 좋겠습니다.'],
    },
  },

  low_can_user: {
    id: 'low_can_user',
    name: 'Can 부족 유저',
    careerState: 'job_seeker',
    miniModule: {
      interest_top: ['data_numbers', 'tech', 'problem_solving'],
      value_top: ['growth', 'expertise', 'income'],
      strength_top: ['fast_learning', 'persistence', 'analytical'],
      constraint_flags: [],
      workstyle_top: ['structured', 'team_harmony'],
      background_flags: ['no_experience'],
      language_skills: [],
      sacrifice_flags: ['low_initial_income', 'long_hours_ok'],
      energy_drain_flags: [],
      achievement_feedback_top: ['mastery', 'growth'],
      execution_style: 'planner',
      impact_scope: 'specialist',
      failure_response: 'analyze_improve',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'selective_listen',
    },
    narrativeAnswers: {
      motivation: '데이터 분석 분야에 정말 관심이 많습니다. 경험은 없지만 온라인 강의로 열심히 공부하고 있고, 부트캠프도 수료했습니다. 신입으로 기회를 얻고 싶습니다.',
      avoidance: '배울 수 없는 단순 반복 업무는 피하고 싶습니다. 성장할 수 있는 환경이 중요합니다.',
      constraints: '신입이라 연봉은 크게 기대하지 않습니다. 배울 수 있다면 야근도 괜찮고, 어떤 조건이든 열심히 할 준비가 되어있습니다.',
    },
    llmPatterns: {
      '경험|경력|이력': '관련 경험은 없지만 온라인 강의로 공부하고 있습니다.',
      '전환|커리어체인지|신입': '다른 분야에서 커리어 전환을 고려하고 있습니다.',
    },
    roundFallbacks: {
      round1: ['데이터로 인사이트를 발견하는 것에 매력을 느낍니다.', '3년 안에 주니어 분석가로 독립적으로 업무할 수 있으면 좋겠습니다.', '멘토가 있는 환경에서 빠르게 성장하고 싶습니다.'],
      round2: ['배움 없이 시간만 보내는 환경은 피하고 싶습니다.', '성장 기회 없는 단순 보조 업무만 하는 건 맞지 않습니다.', '피드백 없이 혼자 방치되는 건 힘들 것 같습니다.'],
      round3: ['신입 평균 수준이면 감사합니다. 연봉보다 경험이 중요합니다.', '출퇴근 거리는 1시간 반까지 괜찮습니다.', '인턴이나 계약직으로 시작해도 괜찮습니다.'],
    },
  },

  comprehensive_test: {
    id: 'comprehensive_test',
    name: '종합 테스트',
    careerState: 'employed',
    miniModule: {
      interest_top: ['tech', 'problem_solving', 'creative'],
      value_top: ['growth', 'autonomy', 'income'],
      strength_top: ['analytical', 'creative', 'communication'],
      constraint_flags: ['work_hours_strict', 'remote_preferred'],
      workstyle_top: ['flexible', 'solo_deep', 'team_harmony'],
      background_flags: ['has_degree', 'tech_experience'],
      language_skills: [{ language: 'english', level: 'business' }],
      sacrifice_flags: ['low_initial_income'],
      energy_drain_flags: ['routine_drain', 'bureaucracy_drain'],
      achievement_feedback_top: ['mastery', 'recognition', 'autonomy'],
      execution_style: 'balanced',
      impact_scope: 'wide_impact',
      failure_response: 'analyze_improve',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'selective_listen',
    },
    narrativeAnswers: {
      motivation: '기술과 창의성을 결합해서 문제를 해결하는 것이 좋습니다. 프론트엔드 개발 경험이 있고, 점점 풀스택으로 성장하고 싶습니다. 자율성 있는 환경에서 일하고 싶어요.',
      avoidance: '너무 루틴한 유지보수 업무나 관료적인 조직은 맞지 않습니다. 출장이 잦거나 교대 근무가 있는 곳도 피하고 싶습니다.',
      constraints: '야근이 가끔은 괜찮지만 상시적이면 힘듭니다. 주 3일 이상 재택이 가능하면 좋겠습니다.',
    },
    llmPatterns: {
      '기술|개발|프로그래밍': '프론트엔드 개발 경험이 있고, 백엔드도 배우고 있습니다.',
      '영어|외국어|언어': '비즈니스 영어 가능하고, 외국 클라이언트와 협업 경험 있습니다.',
      '원격|재택|리모트': '하이브리드도 괜찮지만 주 3일 이상 재택 선호합니다.',
    },
    roundFallbacks: {
      round1: ['풀스택 개발자로 성장하면서 팀 리드 역할도 해보고 싶습니다.', '기술적으로 도전적인 프로젝트에 참여하고 싶습니다.', '외국 클라이언트와 협업하며 글로벌 경험을 쌓고 싶습니다.'],
      round2: ['레거시 코드만 유지보수하는 건 지치게 합니다.', '기술 결정에 전혀 참여하지 못하는 환경은 답답합니다.', '비효율적인 프로세스나 불필요한 회의가 많은 곳은 맞지 않습니다.'],
      round3: ['현재 연봉에서 15-20% 정도 인상을 기대합니다.', '하이브리드 근무가 가능해야 합니다. 주 2일 출근 정도가 이상적입니다.', '판교나 강남권 스타트업/IT 기업을 선호합니다.'],
    },
  },
};


// ============================================
// ScenarioProgressUI 클래스
// ============================================

class ScenarioProgressUI {
  constructor() {
    this.container = null;
    this.logContainer = null;
    this.stepsContainer = null;
    this.currentStepElement = null;
    this.progressBar = null;
    this.isPaused = false;
    this.onPauseCallback = null;
    this.onResumeCallback = null;
    this.onStopCallback = null;

    this.steps = [
      { name: 'Step 1: 프로필 입력', status: 'pending' },
      { name: 'Step 2-1: 기본 심층질문', status: 'pending' },
      { name: 'Step 2-2: LLM 라운드 1 (욕망)', status: 'pending' },
      { name: 'Step 2-3: LLM 라운드 2 (회피)', status: 'pending' },
      { name: 'Step 2-4: LLM 라운드 3 (현실)', status: 'pending' },
      { name: 'Step 3: 결과 분석', status: 'pending' },
    ];
  }

  show(scenarioName) {
    this.hide();

    this.container = document.createElement('div');
    this.container.id = 'scenario-progress-overlay';
    this.container.innerHTML = `
      <div class="scenario-progress-modal">
        <div class="scenario-progress-header">
          <h2>E2E 시나리오 테스트 실행 중</h2>
          <span class="scenario-name">${scenarioName}</span>
        </div>
        <div class="scenario-progress-steps" id="progress-steps"></div>
        <div class="scenario-progress-bar-container">
          <div class="scenario-progress-bar" id="progress-bar"></div>
        </div>
        <div class="scenario-current-step" id="current-step">준비 중...</div>
        <div class="scenario-log-container" id="log-container"></div>
        <div class="scenario-progress-controls">
          <button id="pause-btn" class="btn btn-warning">일시정지</button>
          <button id="stop-btn" class="btn btn-danger">중지</button>
        </div>
      </div>
    `;

    this.addStyles();
    document.body.appendChild(this.container);

    this.logContainer = document.getElementById('log-container');
    this.stepsContainer = document.getElementById('progress-steps');
    this.currentStepElement = document.getElementById('current-step');
    this.progressBar = document.getElementById('progress-bar');

    this.renderSteps();
    this.bindEvents();
  }

  addStyles() {
    if (document.getElementById('scenario-progress-styles')) return;

    const style = document.createElement('style');
    style.id = 'scenario-progress-styles';
    style.textContent = `
      #scenario-progress-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.9); z-index: 10000; display: flex; align-items: center; justify-content: center; }
      .scenario-progress-modal { background: #1a1a2e; border-radius: 16px; padding: 32px; width: 90%; max-width: 700px; max-height: 90vh; overflow-y: auto; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5); color: #fff; }
      .scenario-progress-header { text-align: center; margin-bottom: 24px; }
      .scenario-progress-header h2 { margin: 0 0 8px 0; font-size: 24px; color: #fff; }
      .scenario-name { color: #4ade80; font-size: 18px; font-weight: 600; }
      .scenario-progress-steps { display: flex; flex-direction: column; gap: 8px; margin-bottom: 24px; }
      .step-item { display: flex; align-items: center; gap: 12px; padding: 12px 16px; background: #16213e; border-radius: 8px; transition: all 0.3s ease; }
      .step-item.pending { opacity: 0.5; }
      .step-item.in_progress { background: #1e3a5f; border-left: 3px solid #4ade80; animation: pulse 1.5s infinite; }
      .step-item.completed { background: #1e3a2f; opacity: 1; }
      .step-item.error { background: #3a1e1e; border-left: 3px solid #f87171; }
      @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.7; } }
      .step-icon { width: 24px; height: 24px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 14px; }
      .step-icon.pending { background: #374151; }
      .step-icon.in_progress { background: #3b82f6; }
      .step-icon.completed { background: #10b981; }
      .step-icon.error { background: #ef4444; }
      .step-name { flex: 1; font-size: 14px; }
      .step-detail { font-size: 12px; color: #9ca3af; }
      .scenario-progress-bar-container { height: 8px; background: #374151; border-radius: 4px; overflow: hidden; margin-bottom: 16px; }
      .scenario-progress-bar { height: 100%; background: linear-gradient(90deg, #3b82f6, #10b981); width: 0%; transition: width 0.5s ease; }
      .scenario-current-step { text-align: center; padding: 16px; background: #16213e; border-radius: 8px; margin-bottom: 16px; font-size: 16px; min-height: 60px; display: flex; align-items: center; justify-content: center; }
      .scenario-log-container { background: #0f0f1a; border-radius: 8px; padding: 16px; max-height: 200px; overflow-y: auto; font-family: monospace; font-size: 12px; margin-bottom: 24px; }
      .log-entry { padding: 4px 0; border-bottom: 1px solid #1a1a2e; }
      .log-entry.info { color: #60a5fa; }
      .log-entry.success { color: #4ade80; }
      .log-entry.warning { color: #fbbf24; }
      .log-entry.error { color: #f87171; }
      .scenario-progress-controls { display: flex; gap: 12px; justify-content: center; }
      .scenario-progress-controls .btn { padding: 12px 24px; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.2s ease; }
      .btn-warning { background: #f59e0b; color: #000; }
      .btn-warning:hover { background: #d97706; }
      .btn-danger { background: #ef4444; color: #fff; }
      .btn-danger:hover { background: #dc2626; }
      .btn-success { background: #10b981; color: #fff; }
      .btn-success:hover { background: #059669; }
    `;
    document.head.appendChild(style);
  }

  renderSteps() {
    if (!this.stepsContainer) return;
    this.stepsContainer.innerHTML = this.steps.map((step, index) => `
      <div class="step-item ${step.status}" id="step-${index}">
        <div class="step-icon ${step.status}">${this.getStepIcon(step.status)}</div>
        <span class="step-name">${step.name}</span>
        ${step.detail ? `<span class="step-detail">${step.detail}</span>` : ''}
      </div>
    `).join('');
  }

  getStepIcon(status) {
    switch (status) {
      case 'pending': return '○';
      case 'in_progress': return '◎';
      case 'completed': return '✓';
      case 'error': return '✗';
    }
  }

  bindEvents() {
    const pauseBtn = document.getElementById('pause-btn');
    const stopBtn = document.getElementById('stop-btn');

    pauseBtn?.addEventListener('click', () => {
      if (this.isPaused) {
        this.isPaused = false;
        pauseBtn.textContent = '일시정지';
        pauseBtn.classList.remove('btn-success');
        pauseBtn.classList.add('btn-warning');
        this.onResumeCallback?.();
        this.log('재개됨', 'info');
      } else {
        this.isPaused = true;
        pauseBtn.textContent = '재개';
        pauseBtn.classList.remove('btn-warning');
        pauseBtn.classList.add('btn-success');
        this.onPauseCallback?.();
        this.log('일시정지됨', 'warning');
      }
    });

    stopBtn?.addEventListener('click', () => {
      if (confirm('시나리오 테스트를 중지하시겠습니까?')) {
        this.onStopCallback?.();
        this.log('사용자에 의해 중지됨', 'error');
        this.hide();
      }
    });
  }

  updateStep(stepIndex, status, detail) {
    if (stepIndex < 0 || stepIndex >= this.steps.length) return;
    this.steps[stepIndex].status = status;
    if (detail) this.steps[stepIndex].detail = detail;
    this.renderSteps();
    this.updateProgressBar();
    if (this.currentStepElement && status === 'in_progress') {
      this.currentStepElement.textContent = `${this.steps[stepIndex].name}...`;
    }
  }

  updateProgressBar() {
    if (!this.progressBar) return;
    const completed = this.steps.filter(s => s.status === 'completed').length;
    const progress = (completed / this.steps.length) * 100;
    this.progressBar.style.width = `${progress}%`;
  }

  setCurrentMessage(message) {
    if (this.currentStepElement) {
      this.currentStepElement.textContent = message;
    }
  }

  log(message, type = 'info') {
    if (!this.logContainer) return;
    const timestamp = new Date().toLocaleTimeString();
    const entry = document.createElement('div');
    entry.className = `log-entry ${type}`;
    entry.textContent = `[${timestamp}] ${message}`;
    this.logContainer.appendChild(entry);
    this.logContainer.scrollTop = this.logContainer.scrollHeight;
  }

  hide() {
    if (this.container) {
      this.container.remove();
      this.container = null;
    }
    // Reset steps
    this.steps = this.steps.map(s => ({ ...s, status: 'pending', detail: undefined }));
  }

  onPause(callback) { this.onPauseCallback = callback; }
  onResume(callback) { this.onResumeCallback = callback; }
  onStop(callback) { this.onStopCallback = callback; }

  get paused() { return this.isPaused; }

  showComplete(message = '시나리오 테스트 완료!', onResultClick = null) {
    if (this.currentStepElement) {
      this.currentStepElement.innerHTML = `
        <div style="text-align: center;">
          <div style="font-size: 48px; margin-bottom: 8px;">✓</div>
          <div style="color: #4ade80; font-size: 18px;">${message}</div>
        </div>
      `;
    }
    const pauseBtn = document.getElementById('pause-btn');
    const stopBtn = document.getElementById('stop-btn');
    if (pauseBtn) pauseBtn.style.display = 'none';
    if (stopBtn) {
      stopBtn.textContent = '결과 보기';
      stopBtn.classList.remove('btn-danger');
      stopBtn.classList.add('btn-success');
      // 기존 이벤트 리스너를 제거하기 위해 버튼을 교체
      const newStopBtn = stopBtn.cloneNode(true);
      stopBtn.parentNode.replaceChild(newStopBtn, stopBtn);
      if (onResultClick) {
        newStopBtn.addEventListener('click', onResultClick);
      } else {
        newStopBtn.addEventListener('click', () => this.hide());
      }
    }
  }

  showError(message) {
    if (this.currentStepElement) {
      this.currentStepElement.innerHTML = `
        <div style="text-align: center;">
          <div style="font-size: 48px; margin-bottom: 8px; color: #f87171;">✗</div>
          <div style="color: #f87171; font-size: 18px;">${message}</div>
        </div>
      `;
    }
    const pauseBtn = document.getElementById('pause-btn');
    const stopBtn = document.getElementById('stop-btn');
    if (pauseBtn) pauseBtn.style.display = 'none';
    if (stopBtn) {
      stopBtn.textContent = '닫기';
      stopBtn.onclick = () => this.hide();
    }
  }
}


// ============================================
// AutoAnswerGenerator 클래스
// ============================================

class AutoAnswerGenerator {
  constructor(scenario, options = {}) {
    this.scenario = scenario;
    this.usedFallbackIndices = {};
    this.useLLM = options.useLLM !== false;  // 기본값: LLM 사용
    this.apiBase = options.apiBase || '/api/ai-analyzer';
    this.previousAnswers = [];
  }

  // LLM 기반 답변 생성 (비동기)
  async generateAnswerLLM(question, round) {
    try {
      const persona = {
        name: this.scenario.name,
        career_state: this.scenario.profile?.career_state || 'employed',
        interests: this.scenario.profile?.interests || [],
        strengths: this.scenario.miniModule?.strength_top || [],
        values: this.scenario.miniModule?.value_top || [],
        constraints: this.scenario.miniModule?.constraint_flags || [],
        narrative_context: this.scenario.narrativeAnswers?.motivation || '',
      };

      const response = await fetch(`${this.apiBase}/test/generate-answer`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          question,
          round,
          persona,
          previous_answers: this.previousAnswers.slice(-5),  // 최근 5개만
        }),
      });

      if (!response.ok) {
        console.warn('[AutoAnswer] LLM API failed, using fallback');
        return null;
      }

      const data = await response.json();
      if (data.success && data.answer) {
        this.previousAnswers.push(data.answer);
        return { answer: data.answer, matchType: 'llm' };
      }
      return null;
    } catch (error) {
      console.warn('[AutoAnswer] LLM error:', error);
      return null;
    }
  }

  // 동기식 답변 생성 (기존 로직 - fallback용)
  generateAnswerSync(question, round) {
    const safeQuestion = question || '';

    // 1. 패턴 매칭 시도
    const patternMatch = this.findPatternMatch(safeQuestion);
    if (patternMatch) {
      return { answer: patternMatch, matchType: 'pattern' };
    }

    // 2. 라운드별 폴백 답변 사용
    const fallbackAnswer = this.getFallbackAnswer(round);
    if (fallbackAnswer) {
      return { answer: fallbackAnswer, matchType: 'fallback' };
    }

    // 3. 기본 답변
    return { answer: this.getDefaultAnswer(round), matchType: 'default' };
  }

  // 메인 답변 생성 함수 (비동기, LLM 우선)
  async generateAnswer(question, round) {
    // LLM 모드가 활성화되어 있으면 LLM 먼저 시도
    if (this.useLLM) {
      const llmResult = await this.generateAnswerLLM(question, round);
      if (llmResult) {
        return llmResult;
      }
    }

    // LLM 실패 또는 비활성화 시 기존 로직 사용
    return this.generateAnswerSync(question, round);
  }

  findPatternMatch(question) {
    // null/undefined 체크
    if (!question || typeof question !== 'string') {
      return null;
    }

    const normalizedQuestion = question.toLowerCase();
    for (const [pattern, answer] of Object.entries(this.scenario.llmPatterns || {})) {
      const keywords = pattern.split('|');
      const isMatch = keywords.some(keyword => normalizedQuestion.includes(keyword.toLowerCase()));
      if (isMatch) return answer;
    }
    return null;
  }

  getFallbackAnswer(round) {
    const roundKey = `round${round}`;
    const fallbacks = this.scenario.roundFallbacks?.[roundKey];
    if (!fallbacks || fallbacks.length === 0) return null;

    const usedIndex = this.usedFallbackIndices[roundKey] || 0;
    if (usedIndex >= fallbacks.length) {
      return fallbacks[Math.floor(Math.random() * fallbacks.length)];
    }
    this.usedFallbackIndices[roundKey] = usedIndex + 1;
    return fallbacks[usedIndex];
  }

  getDefaultAnswer(round) {
    switch (round) {
      case 1: return '이 분야에서 성장하고 전문성을 쌓고 싶습니다.';
      case 2: return '지나치게 반복적이거나 성장 기회가 없는 환경은 피하고 싶습니다.';
      case 3: return '현실적인 조건 내에서 최선의 선택을 하고 싶습니다.';
      default: return '잘 모르겠지만 열심히 해보겠습니다.';
    }
  }

  getNarrativeAnswer(type) {
    return this.scenario.narrativeAnswers?.[type] || this.getDefaultNarrativeAnswer(type);
  }

  getDefaultNarrativeAnswer(type) {
    switch (type) {
      case 'motivation': return '관심 있는 분야에서 전문성을 쌓고 성장하고 싶습니다.';
      case 'avoidance': return '맞지 않는 환경이나 성장 기회가 없는 곳은 피하고 싶습니다.';
      case 'constraints': return '현실적인 조건을 고려해서 결정하겠습니다.';
      default: return '일반적인 수준입니다.';
    }
  }
}


// ============================================
// ScenarioRunner 클래스
// ============================================

class ScenarioRunner {
  constructor(scenarioId, options = {}) {
    const scenario = SCENARIOS[scenarioId];
    if (!scenario) {
      throw new Error(`시나리오를 찾을 수 없습니다: ${scenarioId}`);
    }

    this.scenario = scenario;
    this.API_BASE = '/api/ai-analyzer';

    // LLM 기반 답변 생성 (기본값: true)
    this.answerGenerator = new AutoAnswerGenerator(scenario, {
      useLLM: options.useLLM !== false,  // 명시적으로 false가 아니면 LLM 사용
      apiBase: this.API_BASE,
    });
    this.progressUI = new ScenarioProgressUI();

    this.options = {
      delayBetweenSteps: options.delayBetweenSteps ?? 1000,
      autoNavigateToResult: options.autoNavigateToResult ?? true,
      useLLM: options.useLLM !== false,
    };

    this.isRunning = false;
    this.isPaused = false;
    this.shouldStop = false;
    this.sessionId = this.generateUUID();  // 세션 ID 즉시 생성
    this.requestId = 0;
    this.startTime = 0;
  }

  // UUID 생성
  generateUUID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      const r = Math.random() * 16 | 0;
      const v = c === 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }

  async start() {
    if (this.isRunning) {
      throw new Error('시나리오가 이미 실행 중입니다');
    }

    this.isRunning = true;
    this.isPaused = false;
    this.shouldStop = false;
    this.startTime = Date.now();

    this.progressUI.show(this.scenario.name);
    this.setupProgressCallbacks();

    this.progressUI.log(`시나리오 시작: ${this.scenario.name}`, 'info');

    try {
      await this.runStep1();
      if (this.shouldStop) throw new Error('사용자에 의해 중지됨');

      await this.runStep2Narrative();
      if (this.shouldStop) throw new Error('사용자에 의해 중지됨');

      for (let round = 1; round <= 3; round++) {
        await this.runStep2Round(round);
        if (this.shouldStop) throw new Error('사용자에 의해 중지됨');
      }

      await this.runStep3();

      const duration = Date.now() - this.startTime;
      this.progressUI.log(`총 소요 시간: ${(duration / 1000).toFixed(1)}초`, 'success');

      // 결과 페이지 열기 콜백 설정
      let onResultClick = null;
      if (this.options.autoNavigateToResult && this.requestId) {
        const resultUrl = `/analyzer/job?request_id=${this.requestId}`;
        this.progressUI.log(`결과 페이지: ${resultUrl}`, 'info');
        onResultClick = () => {
          window.open(resultUrl, '_blank');
        };
      } else if (!this.requestId) {
        this.progressUI.log('⚠️ request_id가 없어 결과 페이지로 이동할 수 없습니다.', 'warning');
      }

      this.progressUI.showComplete(`E2E 테스트 완료! (${(duration / 1000).toFixed(1)}초)`, onResultClick);

      return { success: true, sessionId: this.sessionId, requestId: this.requestId, duration };

    } catch (error) {
      const duration = Date.now() - this.startTime;
      const errorMessage = error.message || '알 수 없는 오류';
      this.progressUI.log(`오류: ${errorMessage}`, 'error');
      this.progressUI.showError(errorMessage);
      return { success: false, error: errorMessage, duration };
    } finally {
      this.isRunning = false;
    }
  }

  setupProgressCallbacks() {
    this.progressUI.onPause(() => { this.isPaused = true; });
    this.progressUI.onResume(() => { this.isPaused = false; });
    this.progressUI.onStop(() => { this.shouldStop = true; });
  }

  async waitWhilePaused() {
    while (this.isPaused && !this.shouldStop) {
      await this.delay(100);
    }
  }

  async runStep1() {
    this.progressUI.updateStep(0, 'in_progress');
    this.progressUI.log('Step 1: 프로필 데이터 제출 중...', 'info');
    await this.waitWhilePaused();

    const miniModule = this.scenario.miniModule;
    const careerState = this.scenario.careerState;

    this.progressUI.log(`세션 ID: ${this.sessionId}`, 'info');
    this.progressUI.log(`커리어 상태: ${careerState}`, 'info');
    this.progressUI.log(`관심사: ${miniModule.interest_top.join(', ')}`, 'info');

    // Universal Answers 변환 (미니모듈 → V3 포맷)
    const universalAnswers = this.convertMiniModuleToUniversal(miniModule);

    // Stage 결정 (careerState 기반)
    const stage = this.getStageFromCareerState(careerState);

    const response = await fetch(`${this.API_BASE}/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        analysis_type: 'job',
        stage: stage,
        career_state: careerState,
        universal_answers: universalAnswers,
        mini_module_result: miniModule,
        debug: true,
      }),
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(`프로필 제출 실패: ${response.status} - ${errorData.error || errorData.message || ''}`);
    }

    const data = await response.json();
    this.requestId = data.request_id || data.requestId || 0;

    this.progressUI.log(`요청 ID: ${this.requestId}`, 'success');
    this.progressUI.updateStep(0, 'completed', '완료');

    await this.delay(this.options.delayBetweenSteps);
  }

  // careerState → stage 변환
  getStageFromCareerState(careerState) {
    const mapping = {
      'student': 'job_student',
      'job_seeker': 'job_explore',
      'employed': 'job_early',
      'career_changer': 'job_explore',
    };
    return mapping[careerState] || 'job_explore';
  }

  // 미니모듈 결과 → Universal Answers 변환
  convertMiniModuleToUniversal(miniModule) {
    return {
      interest_top: miniModule.interest_top,
      value_top: miniModule.value_top,
      strength_top: miniModule.strength_top,
      workstyle_top: miniModule.workstyle_top,
      constraint_flags: miniModule.constraint_flags,
      sacrifice_flags: miniModule.sacrifice_flags,
      energy_drain_flags: miniModule.energy_drain_flags,
      achievement_feedback_top: miniModule.achievement_feedback_top,
      execution_style: miniModule.execution_style,
      impact_scope: miniModule.impact_scope,
      failure_response: miniModule.failure_response,
      persistence_anchor: miniModule.persistence_anchor,
      external_expectation: miniModule.external_expectation,
    };
  }

  async runStep2Narrative() {
    this.progressUI.updateStep(1, 'in_progress');
    this.progressUI.log('Step 2-1: 내러티브 답변 제출 중...', 'info');
    await this.waitWhilePaused();

    // API가 기대하는 필드명: high_alive_moment, lost_moment
    const highAliveMoment = this.answerGenerator.getNarrativeAnswer('motivation') || '';
    const lostMoment = this.answerGenerator.getNarrativeAnswer('avoidance') || '';

    // 안전한 substring 호출
    const displayMotivation = highAliveMoment.length > 50 ? highAliveMoment.substring(0, 50) + '...' : highAliveMoment;
    this.progressUI.log(`동기: "${displayMotivation}"`, 'info');

    const response = await fetch(`${this.API_BASE}/v3/narrative-facts`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        high_alive_moment: highAliveMoment,
        lost_moment: lostMoment,
      }),
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(`내러티브 답변 제출 실패: ${response.status} - ${errorData.error || ''}`);
    }

    this.progressUI.log('내러티브 답변 제출 완료', 'success');
    this.progressUI.updateStep(1, 'completed', '완료');

    await this.delay(this.options.delayBetweenSteps);
  }

  async runStep2Round(round) {
    const stepIndex = round + 1;

    this.progressUI.updateStep(stepIndex, 'in_progress');
    this.progressUI.log(`Step 2-${round + 1}: LLM 라운드 ${round} 진행 중...`, 'info');
    await this.waitWhilePaused();

    // purpose_tag 결정 (라운드별)
    const purposeTagMap = {
      1: 'ENGINE',      // 욕망
      2: 'AVOIDANCE',   // 회피
      3: 'INTEGRATION', // 현실/통합
    };
    const purposeTag = purposeTagMap[round] || 'ENGINE';

    // 1. 질문 요청
    const questionsResponse = await fetch(`${this.API_BASE}/v3/round-questions`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        round_number: round,  // 'round' → 'round_number'
        narrative_facts: {
          highAliveMoment: this.answerGenerator.getNarrativeAnswer('motivation'),
          lostMoment: this.answerGenerator.getNarrativeAnswer('avoidance'),
        },
        mini_module_result: this.scenario.miniModule,
        previous_round_answers: this.previousRoundAnswers || [],
      }),
    });

    if (!questionsResponse.ok) {
      const errorData = await questionsResponse.json().catch(() => ({}));
      throw new Error(`라운드 ${round} 질문 요청 실패: ${questionsResponse.status} - ${errorData.error || ''}`);
    }

    const questionsData = await questionsResponse.json();
    const questions = questionsData.questions || [];

    // 디버깅: 질문 형식 로깅
    console.log(`[ScenarioRunner] Round ${round} questions received:`, questions);
    if (questions.length > 0) {
      console.log(`[ScenarioRunner] First question structure:`, JSON.stringify(questions[0], null, 2));
    }

    this.progressUI.log(`라운드 ${round}: ${questions.length}개 질문 수신`, 'info');

    // 질문이 없으면 스킵
    if (questions.length === 0) {
      this.progressUI.log(`라운드 ${round}: 질문 없음 (스킵)`, 'warning');
      this.progressUI.updateStep(stepIndex, 'completed', '스킵');
      await this.delay(this.options.delayBetweenSteps);
      return;
    }

    // 2. 각 질문에 대한 답변 생성
    const answers = [];
    for (const q of questions) {
      // 질문 데이터 추출 (null-safe)
      // 서버는 questionId, questionText 형식으로 반환 (llm-interviewer.ts)
      const questionId = q?.questionId || q?.question_id || q?.id || `q_${round}_${answers.length}`;
      let questionText = '';

      if (typeof q === 'string') {
        questionText = q;
      } else if (q && typeof q === 'object') {
        // 서버가 questionText 필드로 반환하므로 우선 순위 조정
        questionText = q.questionText || q.question || q.text || q.question_text || q.content || '';
      }

      // 질문 텍스트가 비어있으면 기본값 사용
      if (!questionText) {
        console.warn(`[ScenarioRunner] Empty question text in round ${round}, question:`, q);
        questionText = `라운드 ${round} 질문`;
      }

      // LLM 또는 패턴 기반 답변 생성 (비동기)
      const { answer, matchType } = await this.answerGenerator.generateAnswer(questionText, round);

      answers.push({
        question_id: questionId,
        question_text: questionText,
        purpose_tag: purposeTag,
        answer: answer,
      });

      // 다음 라운드를 위해 저장
      if (!this.previousRoundAnswers) this.previousRoundAnswers = [];
      this.previousRoundAnswers.push({
        questionId: questionId,
        questionText: questionText,
        roundNumber: round,
        answer: answer,
        answeredAt: new Date().toISOString(),
      });

      // 안전한 substring 호출
      const displayQ = questionText.length > 40 ? questionText.substring(0, 40) + '...' : questionText;
      const displayA = answer.length > 40 ? answer.substring(0, 40) + '...' : answer;

      this.progressUI.log(`Q: "${displayQ}"`, 'info');
      this.progressUI.log(`A (${matchType}): "${displayA}"`, matchType === 'llm' ? 'success' : 'warning');

      await this.waitWhilePaused();
      await this.delay(300);
    }

    // 3. 답변 제출
    const answersResponse = await fetch(`${this.API_BASE}/v3/round-answers`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        request_id: this.requestId,
        round_number: round,  // 'round' → 'round_number'
        answers: answers,
      }),
    });

    if (!answersResponse.ok) {
      const errorData = await answersResponse.json().catch(() => ({}));
      throw new Error(`라운드 ${round} 답변 제출 실패: ${answersResponse.status} - ${errorData.error || ''}`);
    }

    this.progressUI.log(`라운드 ${round} 완료`, 'success');
    this.progressUI.updateStep(stepIndex, 'completed', `${answers.length}개 답변`);

    await this.delay(this.options.delayBetweenSteps);
  }

  async runStep3() {
    this.progressUI.updateStep(5, 'in_progress');
    this.progressUI.log('Step 3: 최종 분석 및 추천 요청 중...', 'info');
    await this.waitWhilePaused();

    // SearchProfile 생성 (미니모듈 결과 기반)
    const miniModule = this.scenario.miniModule;
    const searchProfile = {
      desiredThemes: [
        ...(miniModule.interest_top || []),
        ...(miniModule.value_top || []),
      ],
      dislikedThemes: miniModule.energy_drain_flags || [],
      strengthsHypothesis: miniModule.strength_top || [],
      environmentPreferences: miniModule.workstyle_top || [],
      hardConstraints: miniModule.constraint_flags || [],
      riskSignals: [],
      keywords: [
        ...(miniModule.interest_top || []),
        ...(miniModule.strength_top || []),
      ],
    };

    const response = await fetch(`${this.API_BASE}/v3/recommend`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        searchProfile: searchProfile,
        mini_module_result: miniModule,  // ★ LLM 리포트 생성에 필요!
        topK: 200,
        judgeTopN: 10,
        debug: true,
      }),
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(`추천 요청 실패: ${response.status} - ${errorData.error || ''}`);
    }

    const data = await response.json();

    // ★ Report Mode 표시 (LLM vs Fallback)
    const reportMode = data.report_mode || 'unknown';
    if (reportMode === 'llm') {
      this.progressUI.log('✅ LLM 기반 리포트 생성 성공', 'success');
    } else if (reportMode === 'fallback') {
      this.progressUI.log('⚠️ Fallback 리포트 사용 (LLM 실패 또는 미설정)', 'warning');
    } else {
      this.progressUI.log(`📋 리포트 모드: ${reportMode}`, 'info');
    }

    if (data.recommendations && data.recommendations.top_jobs && data.recommendations.top_jobs.length > 0) {
      const topJob = data.recommendations.top_jobs[0];
      const topJobName = topJob?.job_name || topJob?.name || '직업명 없음';
      const topFitScore = topJob?.fit_score ?? topJob?.scores?.fit ?? 'N/A';
      this.progressUI.log(`추천 1위: ${topJobName} (Fit: ${topFitScore})`, 'success');

      // 상위 3개 표시
      for (let i = 0; i < Math.min(3, data.recommendations.top_jobs.length); i++) {
        const job = data.recommendations.top_jobs[i];
        const jobName = job?.job_name || job?.name || '직업명 없음';
        const fitScore = job?.fit_score ?? job?.scores?.fit ?? 'N/A';
        this.progressUI.log(`${i + 1}. ${jobName} - Fit: ${fitScore}`, 'success');
      }
    } else if (data.recommendations && data.recommendations.length > 0) {
      // 이전 API 형식 호환
      const topJob = data.recommendations[0];
      const topJobName = topJob?.job_name || topJob?.name || '직업명 없음';
      const topFitScore = topJob?.scores?.fit ?? topJob?.fit ?? 'N/A';
      this.progressUI.log(`추천 1위: ${topJobName} (Fit: ${topFitScore})`, 'success');
    } else {
      this.progressUI.log('추천 결과가 없습니다', 'warning');
    }

    // request_id 저장 (결과 페이지 이동용)
    if (data.request_id) {
      this.requestId = data.request_id;
    }

    this.progressUI.log('결과 분석 완료', 'success');
    this.progressUI.updateStep(5, 'completed', '완료');
  }

  delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  stop() {
    this.shouldStop = true;
  }
}


// ============================================
// 전역 함수 (Admin UI에서 호출)
// ============================================

window.runE2EScenario = async function(scenarioId) {
  try {
    const runner = new ScenarioRunner(scenarioId);
    const result = await runner.start();
    console.log('E2E Scenario Result:', result);
    return result;
  } catch (error) {
    console.error('E2E Scenario Error:', error);
    alert('시나리오 실행 오류: ' + error.message);
    return { success: false, error: error.message };
  }
};

window.runE2EScenarioWithUI = window.runE2EScenario;

console.log('ScenarioRunner loaded. Available functions: runE2EScenario(scenarioId)');
