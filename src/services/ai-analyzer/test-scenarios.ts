// CareerWiki AI Analyzer - Automated Test Scenarios
// Version: v1.0.0
//
// ============================================
// 자동화된 시나리오 테스트 시스템
// - LLM 후속 질문에 자동 응답
// - 모든 P0/P1/P2/P3 기능 검증
// ============================================

import type { MiniModuleResult } from './mini-module-questions'

// ============================================
// 시나리오 타입 정의
// ============================================

export interface TestScenario {
  id: string
  name: string
  description: string
  category: 'basic' | 'edge_case' | 'conflict' | 'comprehensive'

  // Mini Module 답변
  miniModule: MiniModuleResult

  // Can 검증 질문 자동 응답
  canValidationAnswers: Record<string, string>  // question_id -> answer_value

  // Risk 강도 질문 자동 응답
  constraintIntensityAnswers: Record<string, string>  // question_id -> intensity

  // LLM 후속 질문 자동 응답 패턴
  llmFollowupAnswers: LLMFollowupPattern[]

  // 예상 결과
  expectedResults: ExpectedResults

  // ============================================
  // 시나리오 자동화용 확장 필드 (E2E 테스트)
  // ============================================

  // 커리어 상태
  careerState: 'student' | 'job_seeker' | 'employed' | 'career_changer'

  // 내러티브 답변 (기본 심층질문용)
  narrativeAnswers: {
    motivation: string      // "왜 이 일을 하고 싶나요?"
    avoidance: string       // "어떤 일은 피하고 싶나요?"
    constraints: string     // "현실적 제약은?"
  }

  // LLM 라운드별 폴백 답변 (패턴 매칭 실패 시)
  roundFallbackAnswers: {
    round1: string[]  // 욕망 관련 폴백
    round2: string[]  // 회피 관련 폴백
    round3: string[]  // 현실 관련 폴백
  }
}

export interface LLMFollowupPattern {
  // 질문 매칭 패턴 (정규식 또는 키워드)
  questionPattern: string
  // 자동 응답
  answer: string
  // 생성될 fact key
  expectedFactKey?: string
}

export interface ExpectedResults {
  // 예상 상위 직업 카테고리
  topJobCategories: string[]
  // 제외되어야 할 직업 카테고리
  excludedJobCategories: string[]
  // Fit 점수 범위
  fitScoreRange: { min: number; max: number }
  // Like/Can 밸런스 검증
  balanceCheck: {
    canShouldNotDominateLike: boolean  // Can이 Like를 압도하면 안됨
    likeCanGap: { max: number }         // Like-Can 격차 최대값
  }
  // 적용되어야 할 기능 검증
  featuresApplied: {
    growthCurveMatching: boolean
    internalConflictRisk: boolean
    canBasedFilter: boolean
    balanceCap: boolean
  }
}

// ============================================
// 테스트 시나리오 정의
// ============================================

export const TEST_SCENARIOS: TestScenario[] = [
  // ============================================
  // 시나리오 1: 분석형 유저 (Analytical User)
  // ============================================
  {
    id: 'analytical_user',
    name: '분석형 유저',
    description: '데이터 분석에 관심 있고, 분석 경험이 있는 유저',
    category: 'basic',

    miniModule: {
      interest_top: ['data_numbers', 'problem_solving', 'research'],
      value_top: ['autonomy', 'growth', 'expertise'],
      strength_top: ['analytical', 'fast_learning', 'persistence'],
      constraint_flags: ['work_hours_strict'],
      workstyle_top: ['solo_deep', 'structured'],
      background_flags: ['research_academic'],
      language_skills: [] as Array<{ language: string; level: 'basic' | 'business' | 'native' }>,
      sacrifice_flags: ['low_initial_income'],
      energy_drain_flags: ['people_drain'],
      achievement_feedback_top: ['mastery', 'recognition'],
      execution_style: 'planner',
      impact_scope: 'specialist',
      failure_response: 'analyze_improve',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'selective_listen',
    },

    canValidationAnswers: {
      'can_analytical': 'work_experience_3plus',  // 분석 경험 3년+
      'can_fast_learning': 'project_experience',   // 학습 능력 프로젝트 경험
    },

    constraintIntensityAnswers: {
      'intensity_time': 'prefer_avoid',  // 야근 가능하면 피하고 싶음
    },

    llmFollowupAnswers: [
      {
        questionPattern: '분석|데이터|통계',
        answer: '데이터 분석 관련 업무를 3년 이상 해왔습니다. SQL과 Python을 주로 사용합니다.',
        expectedFactKey: 'can.analytical.detail',
      },
      {
        questionPattern: '야근|근무시간|워라밸',
        answer: '야근이 너무 잦으면 힘들지만, 가끔은 괜찮습니다.',
        expectedFactKey: 'constraint.overtime.detail',
      },
      {
        questionPattern: '성장|커리어|발전',
        answer: '전문성을 쌓아서 시니어 데이터 분석가가 되고 싶습니다.',
        expectedFactKey: 'like.career_goal',
      },
    ],

    expectedResults: {
      topJobCategories: ['데이터 분석', '통계', '리서치', 'BI'],
      excludedJobCategories: ['현장직', '서비스직', '육체노동'],
      fitScoreRange: { min: 60, max: 95 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 30 },
      },
      featuresApplied: {
        growthCurveMatching: true,
        internalConflictRisk: false,
        canBasedFilter: true,
        balanceCap: true,
      },
    },

    // E2E 자동화 필드
    careerState: 'employed',
    narrativeAnswers: {
      motivation: '데이터를 통해 숨겨진 인사이트를 발견하고, 이를 바탕으로 비즈니스 의사결정에 기여하고 싶습니다. 복잡한 문제를 분석해서 해결책을 찾을 때 가장 보람을 느낍니다.',
      avoidance: '반복적인 단순 업무나 사람들과 끊임없이 소통해야 하는 일은 피하고 싶습니다. 집중해서 깊이 파고들 시간이 없으면 답답함을 느낍니다.',
      constraints: '야근이 너무 잦으면 힘들지만, 프로젝트 마감 시에는 어느 정도 감수할 수 있습니다. 주 평균 주 50시간 이상은 피하고 싶습니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '전문성을 인정받는 시니어 분석가가 되고 싶습니다.',
        '복잡한 데이터에서 의미 있는 패턴을 발견할 때 흥분됩니다.',
        '자율적으로 분석 방향을 정하고 결과를 도출하는 것이 중요합니다.',
      ],
      round2: [
        '정치적인 조직 문화나 비효율적인 프로세스는 지치게 합니다.',
        '분석보다 보고서 작성에 시간을 더 쓰는 건 피하고 싶습니다.',
        '의미 없는 회의가 많은 환경은 맞지 않습니다.',
      ],
      round3: [
        '현재 연봉에서 10% 이상 상승을 기대합니다.',
        '리모트 워크가 가능하면 좋지만 필수는 아닙니다.',
        '서울 지역 내 출퇴근 1시간 이내가 좋습니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 2: 안정 지향 유저 (Stability Seeker)
  // ============================================
  {
    id: 'stability_seeker',
    name: '안정 지향 유저',
    description: '안정성과 워라밸을 중시하는 유저',
    category: 'basic',

    miniModule: {
      interest_top: ['helping', 'organizing', 'routine'],
      value_top: ['stability', 'wlb', 'income'],
      strength_top: ['structured_execution', 'persistence', 'communication'],
      constraint_flags: ['work_hours_strict', 'no_travel'],
      workstyle_top: ['team_harmony', 'structured'],
      background_flags: ['license_cert'],
      language_skills: [] as Array<{ language: string; level: 'basic' | 'business' | 'native' }>,
      sacrifice_flags: ['no_sacrifice'],  // 희생 불가
      energy_drain_flags: ['uncertainty_drain', 'time_pressure_drain'],
      achievement_feedback_top: ['stability', 'recognition'],
      execution_style: 'planner',
      impact_scope: 'team_org',
      failure_response: 'seek_support',
      persistence_anchor: 'stability_anchor',
      external_expectation: 'meet_expectations',
    },

    canValidationAnswers: {
      'can_structured_execution': 'work_experience_1to3',
      'can_communication': 'work_experience_1to3',
    },

    constraintIntensityAnswers: {
      'intensity_time': 'absolute',  // 야근 절대 불가
    },

    llmFollowupAnswers: [
      {
        questionPattern: '안정|고용|정규직',
        answer: '정규직으로 오래 다닐 수 있는 회사를 찾고 있습니다.',
        expectedFactKey: 'like.employment_type',
      },
      {
        questionPattern: '출장|이동|외근',
        answer: '출장은 전혀 불가능합니다. 가정 사정이 있어서요.',
        expectedFactKey: 'constraint.travel.intensity',
      },
    ],

    expectedResults: {
      topJobCategories: ['공무원', '행정', '사무직', '공공기관'],
      excludedJobCategories: ['스타트업', '영업', '프리랜서', '야근 많은 직업'],
      fitScoreRange: { min: 55, max: 90 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 25 },
      },
      featuresApplied: {
        growthCurveMatching: true,
        internalConflictRisk: false,
        canBasedFilter: true,
        balanceCap: true,
      },
    },

    // E2E 자동화 필드
    careerState: 'job_seeker',
    narrativeAnswers: {
      motivation: '오래 다닐 수 있는 안정적인 직장을 찾고 있습니다. 퇴근 후에는 가족과 시간을 보내고 싶고, 예측 가능한 삶을 원합니다.',
      avoidance: '불확실한 상황이나 갑작스러운 변화가 많은 환경은 스트레스입니다. 매일 다른 일을 해야 하거나 실적 압박이 심한 곳은 피하고 싶습니다.',
      constraints: '출장은 전혀 불가능합니다. 가정 사정으로 저녁 7시까지는 반드시 퇴근해야 합니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '정년까지 안정적으로 근무할 수 있는 환경이 중요합니다.',
        '복리후생이 좋고 워라밸이 보장되면 좋겠습니다.',
        '승진보다는 꾸준히 일할 수 있는 것이 우선입니다.',
      ],
      round2: [
        '실적 압박이 심하거나 경쟁이 치열한 환경은 맞지 않습니다.',
        '야근이 잦거나 주말 출근이 있는 곳은 절대 안 됩니다.',
        '불확실한 고용 형태나 계약직은 피하고 싶습니다.',
      ],
      round3: [
        '현재 연봉 수준이면 괜찮습니다. 안정성이 더 중요합니다.',
        '집에서 대중교통으로 40분 이내 거리가 좋습니다.',
        '정규직만 고려하고 있습니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 3: 내면갈등 유저 (Internal Conflict)
  // ============================================
  {
    id: 'internal_conflict',
    name: '내면갈등 유저',
    description: '자율성과 안정성 사이에서 갈등하는 유저',
    category: 'conflict',

    miniModule: {
      interest_top: ['creative', 'problem_solving', 'research'],
      value_top: ['autonomy', 'stability'],  // 충돌하는 가치관
      strength_top: ['creative', 'analytical', 'fast_learning'],
      constraint_flags: ['work_hours_strict'],
      workstyle_top: ['solo_deep', 'flexible'],
      background_flags: ['startup_experience'],
      language_skills: [] as Array<{ language: string; level: 'basic' | 'business' | 'native' }>,
      sacrifice_flags: ['no_sacrifice'],  // 희생 불가 (추가 충돌)
      energy_drain_flags: ['routine_drain', 'time_pressure_drain'],
      achievement_feedback_top: ['autonomy', 'mastery'],
      execution_style: 'explorer',
      impact_scope: 'specialist',
      failure_response: 'analyze_improve',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'ignore',
    },

    canValidationAnswers: {
      'can_creative': 'work_experience_1to3',
      'can_analytical': 'project_experience',
    },

    constraintIntensityAnswers: {
      'intensity_time': 'prefer_avoid',
    },

    llmFollowupAnswers: [
      {
        questionPattern: '자율|자유|재량',
        answer: '업무 방식을 스스로 정할 수 있는 게 중요합니다.',
        expectedFactKey: 'like.autonomy.detail',
      },
      {
        questionPattern: '안정|보장|불안',
        answer: '하지만 수입이 불안정하면 스트레스 받습니다.',
        expectedFactKey: 'risk.income_stability',
      },
    ],

    expectedResults: {
      topJobCategories: ['UX/UI', '기획', '컨설팅', '연구'],
      excludedJobCategories: ['영업', '단순 사무', '현장직'],
      fitScoreRange: { min: 50, max: 85 },  // 갈등으로 인해 범위 넓음
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 35 },
      },
      featuresApplied: {
        growthCurveMatching: true,
        internalConflictRisk: true,  // 내면갈등 감지 필수
        canBasedFilter: true,
        balanceCap: true,
      },
    },

    // E2E 자동화 필드
    careerState: 'career_changer',
    narrativeAnswers: {
      motivation: '창의적인 일을 하고 싶고 제 방식대로 업무를 진행하고 싶습니다. 하지만 동시에 수입이 안정적이어야 마음이 편합니다. 둘 다 포기하기 어렵습니다.',
      avoidance: '루틴하고 반복적인 일은 지루해서 견디기 어렵습니다. 그런데 프리랜서처럼 수입이 불규칙한 것도 불안합니다.',
      constraints: '주말은 확실히 쉬고 싶고, 야근도 가능하면 피하고 싶습니다. 창의적인 일이지만 너무 불안정한 건 싫습니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '제 아이디어가 실제로 구현되는 것을 볼 때 가장 뿌듯합니다.',
        '업무 방식에 대한 자율성이 있으면 좋겠습니다.',
        '전문성을 인정받고 성장할 수 있는 환경을 원합니다.',
      ],
      round2: [
        '매번 똑같은 일을 반복하는 건 정말 힘듭니다.',
        '하지만 수입이 들쑥날쑥하면 스트레스를 받습니다.',
        '창의성이 전혀 필요 없는 단순 업무는 피하고 싶습니다.',
      ],
      round3: [
        '최소 연봉 4천만원 이상은 되어야 할 것 같습니다.',
        '정규직이 좋지만, 조건이 맞으면 계약직도 고려할 수 있습니다.',
        '서울 강남권이나 판교 쪽이 출퇴근하기 좋습니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 4: 창의형 유저 (Creative User)
  // ============================================
  {
    id: 'creative_user',
    name: '창의형 유저',
    description: '창의적 작업을 좋아하고 포트폴리오가 있는 유저',
    category: 'basic',

    miniModule: {
      interest_top: ['creative', 'design', 'art'],
      value_top: ['autonomy', 'creativity', 'recognition'],
      strength_top: ['creative', 'communication', 'fast_learning'],
      constraint_flags: [],
      workstyle_top: ['flexible', 'solo_deep'],
      background_flags: ['overseas_living'],
      language_skills: [{ language: 'english', level: 'basic' }],
      sacrifice_flags: ['low_initial_income', 'unstable_hours'],
      energy_drain_flags: ['routine_drain', 'bureaucracy_drain'],
      achievement_feedback_top: ['recognition', 'mastery'],
      execution_style: 'explorer',
      impact_scope: 'wide_impact',
      failure_response: 'try_different',
      persistence_anchor: 'passion_anchor',
      external_expectation: 'ignore',
    },

    canValidationAnswers: {
      'can_creative': 'work_experience_3plus',  // 창의 경험 풍부
      'can_communication': 'work_experience_1to3',
    },

    constraintIntensityAnswers: {},  // 제약 없음

    llmFollowupAnswers: [
      {
        questionPattern: '포트폴리오|작품|디자인',
        answer: '디자인 관련 포트폴리오가 있고, 프리랜서로 일한 경험도 있습니다.',
        expectedFactKey: 'can.creative.portfolio',
      },
      {
        questionPattern: '팀|협업|클라이언트',
        answer: '클라이언트와 직접 소통하며 일하는 것을 선호합니다.',
        expectedFactKey: 'like.work_style.client_facing',
      },
    ],

    expectedResults: {
      topJobCategories: ['디자이너', '아트디렉터', '크리에이티브', '일러스트'],
      excludedJobCategories: ['회계', '법무', '공장', '물류'],
      fitScoreRange: { min: 65, max: 95 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 25 },
      },
      featuresApplied: {
        growthCurveMatching: true,
        internalConflictRisk: false,
        canBasedFilter: true,
        balanceCap: true,
      },
    },

    // E2E 자동화 필드
    careerState: 'student',
    narrativeAnswers: {
      motivation: '디자인으로 사람들에게 감동을 주고 싶습니다. 제 작품이 세상에 나가서 누군가의 마음을 움직이는 것이 꿈입니다. 아트 디렉터가 되고 싶어요.',
      avoidance: '숫자만 다루거나 규칙에 얽매인 업무는 창의성을 죽이는 것 같아요. 관료적인 조직 문화도 답답합니다.',
      constraints: '초봉이 낮아도 괜찮습니다. 성장할 수 있는 환경이라면 야근도 감수할 수 있어요.',
    },
    roundFallbackAnswers: {
      round1: [
        '제 포트폴리오로 인정받는 디자이너가 되고 싶습니다.',
        '브랜딩이나 아이덴티티 디자인에 특히 관심이 있습니다.',
        '해외 유명 에이전시에서 일해보고 싶은 꿈이 있습니다.',
      ],
      round2: [
        "단순 작업만 반복하는 '손'으로만 쓰이는 건 싫습니다.",
        '클라이언트가 창의성을 존중하지 않는 프로젝트는 힘듭니다.',
        '템플릿만 수정하는 일은 하고 싶지 않습니다.',
      ],
      round3: [
        '첫 연봉은 3천만원대도 괜찮습니다. 배울 수 있다면요.',
        '서울 홍대나 성수동 쪽 에이전시가 좋을 것 같습니다.',
        '포트폴리오를 쌓을 수 있는 프로젝트가 많았으면 좋겠습니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 5: Can 부족 유저 (Low Can Score)
  // ============================================
  {
    id: 'low_can_user',
    name: 'Can 부족 유저',
    description: '관심은 있지만 경험이 없는 신입/전환 유저',
    category: 'edge_case',

    miniModule: {
      interest_top: ['data_numbers', 'tech', 'problem_solving'],
      value_top: ['growth', 'expertise', 'income'],
      strength_top: ['fast_learning', 'persistence', 'analytical'],
      constraint_flags: [],
      workstyle_top: ['structured', 'team_harmony'],
      background_flags: [],  // 경험 없음
      language_skills: [] as Array<{ language: string; level: 'basic' | 'business' | 'native' }>,
      sacrifice_flags: ['low_initial_income', 'long_hours_ok'],
      energy_drain_flags: [],
      achievement_feedback_top: ['mastery', 'growth'],
      execution_style: 'planner',
      impact_scope: 'specialist',
      failure_response: 'analyze_improve',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'selective_listen',
    },

    canValidationAnswers: {
      'can_analytical': 'study_only',  // 학습만 함
      'can_fast_learning': 'study_only',
    },

    constraintIntensityAnswers: {},

    llmFollowupAnswers: [
      {
        questionPattern: '경험|경력|이력',
        answer: '관련 경험은 없지만 온라인 강의로 공부하고 있습니다.',
        expectedFactKey: 'can.experience_level',
      },
      {
        questionPattern: '전환|커리어체인지|신입',
        answer: '다른 분야에서 커리어 전환을 고려하고 있습니다.',
        expectedFactKey: 'career_state.transition',
      },
    ],

    expectedResults: {
      topJobCategories: ['신입 가능', '교육 제공', '성장 가능'],
      excludedJobCategories: ['시니어급', '전문가급'],
      fitScoreRange: { min: 40, max: 75 },  // Can 부족으로 범위 낮음
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 40 },  // Like > Can 예상
      },
      featuresApplied: {
        growthCurveMatching: true,
        internalConflictRisk: false,
        canBasedFilter: true,  // Can 필터로 일부 제외 예상
        balanceCap: false,     // Can이 낮아서 적용 안됨
      },
    },

    // E2E 자동화 필드
    careerState: 'job_seeker',
    narrativeAnswers: {
      motivation: '데이터 분석 분야에 정말 관심이 많습니다. 경험은 없지만 온라인 강의로 열심히 공부하고 있고, 부트캠프도 수료했습니다. 신입으로 기회를 얻고 싶습니다.',
      avoidance: '배울 수 없는 단순 반복 업무는 피하고 싶습니다. 성장할 수 있는 환경이 중요합니다.',
      constraints: '신입이라 연봉은 크게 기대하지 않습니다. 배울 수 있다면 야근도 괜찮고, 어떤 조건이든 열심히 할 준비가 되어있습니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '데이터로 인사이트를 발견하는 것에 매력을 느낍니다.',
        '3년 안에 주니어 분석가로 독립적으로 업무할 수 있으면 좋겠습니다.',
        '멘토가 있는 환경에서 빠르게 성장하고 싶습니다.',
      ],
      round2: [
        '배움 없이 시간만 보내는 환경은 피하고 싶습니다.',
        '성장 기회 없는 단순 보조 업무만 하는 건 맞지 않습니다.',
        '피드백 없이 혼자 방치되는 건 힘들 것 같습니다.',
      ],
      round3: [
        '신입 평균 수준이면 감사합니다. 연봉보다 경험이 중요합니다.',
        '출퇴근 거리는 1시간 반까지 괜찮습니다.',
        '인턴이나 계약직으로 시작해도 괜찮습니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 6: 종합 테스트 (Comprehensive)
  // ============================================
  {
    id: 'comprehensive_test',
    name: '종합 테스트',
    description: '모든 기능을 테스트하는 종합 시나리오',
    category: 'comprehensive',

    miniModule: {
      interest_top: ['tech', 'problem_solving', 'creative'],
      value_top: ['growth', 'autonomy', 'income'],
      strength_top: ['analytical', 'creative', 'communication'],
      constraint_flags: ['work_hours_strict', 'remote_preferred'],
      workstyle_top: ['flexible', 'solo_deep', 'team_harmony'],
      background_flags: ['license_cert', 'overseas_living'],
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

    canValidationAnswers: {
      'can_analytical': 'work_experience_1to3',
      'can_creative': 'project_experience',
      'can_communication': 'work_experience_1to3',
    },

    constraintIntensityAnswers: {
      'intensity_time': 'prefer_avoid',
      'intensity_remote': 'prefer_avoid',
    },

    llmFollowupAnswers: [
      {
        questionPattern: '기술|개발|프로그래밍',
        answer: '프론트엔드 개발 경험이 있고, 백엔드도 배우고 있습니다.',
        expectedFactKey: 'can.tech.stack',
      },
      {
        questionPattern: '영어|외국어|언어',
        answer: '비즈니스 영어 가능하고, 외국 클라이언트와 협업 경험 있습니다.',
        expectedFactKey: 'can.language.english',
      },
      {
        questionPattern: '원격|재택|리모트',
        answer: '하이브리드도 괜찮지만 주 3일 이상 재택 선호합니다.',
        expectedFactKey: 'preference.remote.detail',
      },
    ],

    expectedResults: {
      topJobCategories: ['개발자', 'PM', '기획자', '컨설턴트'],
      excludedJobCategories: ['현장직', '교대근무', '출장 많은 직업'],
      fitScoreRange: { min: 55, max: 90 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 30 },
      },
      featuresApplied: {
        growthCurveMatching: true,
        internalConflictRisk: false,
        canBasedFilter: true,
        balanceCap: true,
      },
    },

    // E2E 자동화 필드
    careerState: 'employed',
    narrativeAnswers: {
      motivation: '기술과 창의성을 결합해서 문제를 해결하는 것이 좋습니다. 프론트엔드 개발 경험이 있고, 점점 풀스택으로 성장하고 싶습니다. 자율성 있는 환경에서 일하고 싶어요.',
      avoidance: '너무 루틴한 유지보수 업무나 관료적인 조직은 맞지 않습니다. 출장이 잦거나 교대 근무가 있는 곳도 피하고 싶습니다.',
      constraints: '야근이 가끔은 괜찮지만 상시적이면 힘듭니다. 주 3일 이상 재택이 가능하면 좋겠습니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '풀스택 개발자로 성장하면서 팀 리드 역할도 해보고 싶습니다.',
        '기술적으로 도전적인 프로젝트에 참여하고 싶습니다.',
        '외국 클라이언트와 협업하며 글로벌 경험을 쌓고 싶습니다.',
      ],
      round2: [
        '레거시 코드만 유지보수하는 건 지치게 합니다.',
        '기술 결정에 전혀 참여하지 못하는 환경은 답답합니다.',
        '비효율적인 프로세스나 불필요한 회의가 많은 곳은 맞지 않습니다.',
      ],
      round3: [
        '현재 연봉에서 15-20% 정도 인상을 기대합니다.',
        '하이브리드 근무가 가능해야 합니다. 주 2일 출근 정도가 이상적입니다.',
        '판교나 강남권 스타트업/IT 기업을 선호합니다.',
      ],
    },
  },
]

// ============================================
// 자동 응답 매칭 함수
// ============================================

/**
 * LLM 질문에 매칭되는 자동 응답 찾기
 */
export function findAutoAnswer(
  question: string,
  scenario: TestScenario
): { answer: string; expectedFactKey?: string } | null {
  const normalizedQuestion = question.toLowerCase()

  for (const pattern of scenario.llmFollowupAnswers) {
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

  // 기본 응답
  return {
    answer: '잘 모르겠습니다. 일반적인 수준입니다.',
    expectedFactKey: undefined,
  }
}

/**
 * Can 검증 질문 자동 응답
 */
export function getCanValidationAnswer(
  questionId: string,
  scenario: TestScenario
): string {
  return scenario.canValidationAnswers[questionId] || 'study_only'
}

/**
 * Risk 강도 질문 자동 응답
 */
export function getConstraintIntensityAnswer(
  questionId: string,
  scenario: TestScenario
): string {
  return scenario.constraintIntensityAnswers[questionId] || 'prefer_avoid'
}

// ============================================
// 결과 검증 함수
// ============================================

export interface TestVerificationResult {
  passed: boolean
  score: number  // 0-100
  details: {
    topJobsCheck: { passed: boolean; message: string }
    excludedJobsCheck: { passed: boolean; message: string }
    fitScoreCheck: { passed: boolean; message: string }
    balanceCheck: { passed: boolean; message: string }
    featuresCheck: { passed: boolean; message: string }
  }
  warnings: string[]
  summary: string
}

/**
 * 테스트 결과 검증
 */
export function verifyTestResults(
  scenario: TestScenario,
  actualResults: {
    topJobs: Array<{ job_name: string; scores: { fit: number; like: number; can: number } }>
    excludedJobs: Array<{ job_name: string; reason: string }>
    appliedFeatures: {
      growthCurveApplied: boolean
      conflictRiskApplied: boolean
      canFilterApplied: boolean
      balanceCapApplied: boolean
    }
  }
): TestVerificationResult {
  const expected = scenario.expectedResults
  const warnings: string[] = []
  let totalScore = 0

  // 1. Top Jobs 카테고리 검증
  const topJobNames = actualResults.topJobs.slice(0, 5).map(j => j.job_name.toLowerCase())
  const topJobCategoryMatch = expected.topJobCategories.some(cat =>
    topJobNames.some(name => name.includes(cat.toLowerCase()))
  )
  const topJobsCheck = {
    passed: topJobCategoryMatch,
    message: topJobCategoryMatch
      ? `상위 직업에 예상 카테고리(${expected.topJobCategories.join(', ')}) 포함`
      : `상위 직업에 예상 카테고리 없음. 실제: ${topJobNames.slice(0, 3).join(', ')}`,
  }
  if (topJobsCheck.passed) totalScore += 25

  // 2. 제외 직업 검증
  const excludedJobNames = actualResults.excludedJobs.map(j => j.job_name.toLowerCase())
  const excludedCorrect = expected.excludedJobCategories.every(cat =>
    excludedJobNames.some(name => name.includes(cat.toLowerCase())) ||
    !topJobNames.some(name => name.includes(cat.toLowerCase()))
  )
  const excludedJobsCheck = {
    passed: excludedCorrect || actualResults.excludedJobs.length === 0,
    message: excludedCorrect
      ? `제외 카테고리(${expected.excludedJobCategories.join(', ')}) 올바르게 제외됨`
      : '일부 제외 카테고리가 상위에 노출됨',
  }
  if (excludedJobsCheck.passed) totalScore += 20

  // 3. Fit 점수 범위 검증
  const topFitScores = actualResults.topJobs.slice(0, 3).map(j => j.scores.fit)
  const avgFit = topFitScores.length > 0
    ? topFitScores.reduce((a, b) => a + b, 0) / topFitScores.length
    : 0
  const fitInRange = avgFit >= expected.fitScoreRange.min && avgFit <= expected.fitScoreRange.max
  const fitScoreCheck = {
    passed: fitInRange,
    message: fitInRange
      ? `평균 Fit 점수 ${avgFit.toFixed(1)} (예상 범위: ${expected.fitScoreRange.min}-${expected.fitScoreRange.max})`
      : `평균 Fit 점수 ${avgFit.toFixed(1)}이 예상 범위(${expected.fitScoreRange.min}-${expected.fitScoreRange.max}) 벗어남`,
  }
  if (fitScoreCheck.passed) totalScore += 20

  // 4. Balance 검증
  let balancePassed = true
  const topJob = actualResults.topJobs[0]
  if (topJob && expected.balanceCheck.canShouldNotDominateLike) {
    const gap = topJob.scores.can - topJob.scores.like
    if (gap > expected.balanceCheck.likeCanGap.max) {
      balancePassed = false
      warnings.push(`Can이 Like를 ${gap}점 초과 (최대 허용: ${expected.balanceCheck.likeCanGap.max})`)
    }
  }
  const balanceCheck = {
    passed: balancePassed,
    message: balancePassed
      ? 'Like-Can 밸런스 정상'
      : `밸런스 이상: Can이 Like를 과도하게 초과`,
  }
  if (balanceCheck.passed) totalScore += 15

  // 5. 기능 적용 검증
  const { appliedFeatures } = actualResults
  const featureChecks = {
    growthCurve: expected.featuresApplied.growthCurveMatching === appliedFeatures.growthCurveApplied,
    conflict: expected.featuresApplied.internalConflictRisk === appliedFeatures.conflictRiskApplied,
    canFilter: expected.featuresApplied.canBasedFilter === appliedFeatures.canFilterApplied,
    balanceCap: expected.featuresApplied.balanceCap === appliedFeatures.balanceCapApplied,
  }
  const allFeaturesMatch = Object.values(featureChecks).every(v => v)
  const featuresCheck = {
    passed: allFeaturesMatch,
    message: allFeaturesMatch
      ? '모든 기능 정상 적용'
      : `기능 불일치: ${Object.entries(featureChecks).filter(([_, v]) => !v).map(([k]) => k).join(', ')}`,
  }
  if (featuresCheck.passed) totalScore += 20

  // 종합 결과
  const passed = totalScore >= 70
  const summary = passed
    ? `✅ 테스트 통과 (${totalScore}/100)`
    : `❌ 테스트 실패 (${totalScore}/100)`

  return {
    passed,
    score: totalScore,
    details: {
      topJobsCheck,
      excludedJobsCheck,
      fitScoreCheck,
      balanceCheck,
      featuresCheck,
    },
    warnings,
    summary,
  }
}

// ============================================
// 유틸리티 함수
// ============================================

export function getScenarioById(id: string): TestScenario | undefined {
  return TEST_SCENARIOS.find(s => s.id === id)
}

export function getScenariosByCategory(category: TestScenario['category']): TestScenario[] {
  return TEST_SCENARIOS.filter(s => s.category === category)
}

export function getAllScenarioSummary(): Array<{
  id: string
  name: string
  description: string
  category: string
}> {
  return TEST_SCENARIOS.map(s => ({
    id: s.id,
    name: s.name,
    description: s.description,
    category: s.category,
  }))
}
