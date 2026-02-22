// CareerWiki AI Analyzer - Major Recommendation Test Scenarios
// Version: v1.0.0
//
// ============================================
// 전공 추천 자동화 테스트 시나리오
// - 직업 추천 테스트(`test-scenarios.ts`)의 전공 추천 버전
// - 6개 테스트 페르소나로 전공 추천 파이프라인 E2E 검증
// ============================================

import type { MiniModuleResult } from './mini-module-questions'
import type { AcademicState } from './types'

// ============================================
// 전공 테스트 시나리오 타입 정의
// ============================================

export interface MajorTestScenario {
  id: string
  name: string
  description: string
  category: 'basic' | 'edge_case' | 'conflict' | 'comprehensive'

  // Mini Module 답변
  miniModule: MiniModuleResult

  // 학업 상태 (전공 전용)
  academicState: AcademicState

  // Can 검증 질문 자동 응답
  canValidationAnswers: Record<string, string>

  // Risk 강도 질문 자동 응답
  constraintIntensityAnswers: Record<string, string>

  // LLM 후속 질문 자동 응답 패턴
  llmFollowupAnswers: MajorLLMFollowupPattern[]

  // 예상 결과
  expectedResults: MajorExpectedResults

  // E2E 자동화 필드
  careerState: 'student' | 'job_seeker' | 'employed' | 'career_changer'

  // 내러티브 답변 (전공 심층질문용)
  narrativeAnswers: {
    motivation: string      // "왜 이 전공에 관심이 있나요?"
    avoidance: string       // "어떤 학습 환경은 피하고 싶나요?"
    constraints: string     // "현실적 제약은?"
  }

  // LLM 라운드별 폴백 답변
  roundFallbackAnswers: {
    round1: string[]  // 학문적 흥미/욕망
    round2: string[]  // 학습 회피/환경 제약
    round3: string[]  // 성적/입시/진로 현실
  }
}

export interface MajorLLMFollowupPattern {
  questionPattern: string
  answer: string
  expectedFactKey?: string
}

export interface MajorExpectedResults {
  // 예상 상위 전공 키워드
  topMajorKeywords: string[]
  // 제외되어야 할 전공 키워드
  excludedMajorKeywords: string[]
  // Fit 점수 범위
  fitScoreRange: { min: number; max: number }
  // Like/Can 밸런스 검증
  balanceCheck: {
    canShouldNotDominateLike: boolean
    likeCanGap: { max: number }
  }
  // 적용되어야 할 기능 검증
  featuresApplied: {
    tagFilterApplied: boolean
    internalConflictRisk: boolean
    diversityGuardApplied: boolean
    archetypeInjected: boolean
  }
}

// ============================================
// 테스트 시나리오 정의 (6개)
// ============================================

export const MAJOR_TEST_SCENARIOS: MajorTestScenario[] = [
  // ============================================
  // 시나리오 1: STEM 지향 고등학생
  // ============================================
  {
    id: 'major_stem_student',
    name: 'STEM 지향 학생',
    description: '수학/과학에 강하고 기술 분야에 관심 있는 고등학생',
    category: 'basic',
    academicState: 'high_school_regular',

    miniModule: {
      interest_top: ['data_numbers', 'problem_solving'],
      value_top: ['growth', 'income'],
      strength_top: ['analytical', 'fast_learning'],
      constraint_flags: [],
      workstyle_top: ['solo', 'structured'],
      background_flags: [],
      language_skills: [{ language: 'english', level: 'business' as const }],
      sacrifice_flags: ['low_initial_income', 'willing_to_study'],
      energy_drain_flags: ['people_drain'],
      achievement_feedback_top: ['metric_feedback', 'problem_solved_feedback'],
      execution_style: 'plan_first',
      impact_scope: 'impact_industry',
      failure_response: 'iterate_on_failure',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'neutral_to_expectation',
    },

    canValidationAnswers: {
      'can_analytical': 'study_experience',
      'can_fast_learning': 'self_study',
    },

    constraintIntensityAnswers: {},

    llmFollowupAnswers: [
      {
        questionPattern: '수학|과학|이과',
        answer: '수학을 좋아하고 물리, 화학 성적이 좋습니다. 프로그래밍도 독학으로 배우고 있어요.',
        expectedFactKey: 'like.stem_interest.detail',
      },
      {
        questionPattern: '진로|졸업|취업',
        answer: '소프트웨어 개발자나 데이터 분석가 같은 IT 관련 직업에 관심이 있습니다.',
        expectedFactKey: 'like.career_goal',
      },
      {
        questionPattern: '대학|학교|입시',
        answer: '수능 수학, 과학 성적은 상위권이고, 정시를 준비하고 있습니다.',
        expectedFactKey: 'can.academic_performance',
      },
    ],

    expectedResults: {
      topMajorKeywords: ['컴퓨터', '소프트웨어', '전자', '수학', '통계', '데이터', '공학', 'IT'],
      excludedMajorKeywords: ['문학', '미술', '철학', '음악', '무용'],
      fitScoreRange: { min: 60, max: 95 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 30 },
      },
      featuresApplied: {
        tagFilterApplied: false,
        internalConflictRisk: false,
        diversityGuardApplied: true,
        archetypeInjected: true,
      },
    },

    careerState: 'student',
    narrativeAnswers: {
      motivation: '수학 문제를 풀 때 가장 재미있고, 프로그래밍으로 뭔가 만들 때 성취감을 느낍니다. 데이터로 패턴을 찾는 것도 흥미롭습니다.',
      avoidance: '암기 위주 학습이나 글쓰기가 많은 과목은 피하고 싶습니다. 팀 발표도 그렇게 좋아하지 않습니다.',
      constraints: '수능 수학, 과학탐구 성적이 좋아서 이공계 상위권 대학을 목표로 하고 있습니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '알고리즘 문제 풀이에 빠지면 시간 가는 줄 모릅니다.',
        '인공지능과 머신러닝에 대해 더 깊이 배우고 싶습니다.',
        '논리적으로 구조를 설계하는 것이 재미있습니다.',
      ],
      round2: [
        '글을 많이 읽고 써야 하는 건 좀 지칩니다.',
        '정답이 없는 토론식 수업보다 명확한 답이 있는 문제가 좋습니다.',
        '예술적 감각이 필요한 분야는 자신 없습니다.',
      ],
      round3: [
        '서울 소재 상위권 대학에 진학하고 싶습니다.',
        '수능 모의고사 기준 수학 1등급, 과탐 2등급 수준입니다.',
        '장학금을 받을 수 있으면 좋겠지만 필수는 아닙니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 2: 인문 지향 고등학생
  // ============================================
  {
    id: 'major_humanities_student',
    name: '인문 지향 학생',
    description: '사람과 사회에 관심이 많고, 교육/심리/사회학에 흥미를 느끼는 학생',
    category: 'basic',
    academicState: 'high_school_early',

    miniModule: {
      interest_top: ['helping_teaching', 'organizing'],
      value_top: ['meaning', 'stability'],
      strength_top: ['communication', 'persistence'],
      constraint_flags: ['math_impossible'],
      workstyle_top: ['team', 'flexible'],
      background_flags: ['volunteer_ngo'],
      language_skills: [],
      sacrifice_flags: ['willing_to_study'],
      energy_drain_flags: ['cognitive_drain'],
      achievement_feedback_top: ['helping_feedback', 'growth_feedback'],
      execution_style: 'flexible_execution',
      impact_scope: 'impact_individual',
      failure_response: 'pause_on_failure',
      persistence_anchor: 'meaning_anchor',
      external_expectation: 'external_structure_ok',
    },

    canValidationAnswers: {
      'can_communication': 'school_activity',
      'can_persistence': 'volunteer_experience',
    },

    constraintIntensityAnswers: {
      'intensity_math': 'absolute',
    },

    llmFollowupAnswers: [
      {
        questionPattern: '교육|가르치|봉사',
        answer: '동아리에서 멘토링 활동을 하면서 가르치는 것에 보람을 느꼈습니다.',
        expectedFactKey: 'like.teaching_experience.detail',
      },
      {
        questionPattern: '수학|숫자|계산',
        answer: '수학은 정말 어렵고, 수학이 많은 학과는 절대 가면 안 됩니다.',
        expectedFactKey: 'constraint.math.intensity',
      },
      {
        questionPattern: '사회|심리|인간',
        answer: '사람들의 행동과 심리가 왜 그런지 이해하는 데 관심이 많습니다.',
        expectedFactKey: 'like.psychology_interest',
      },
    ],

    expectedResults: {
      topMajorKeywords: ['심리', '교육', '사회', '상담', '복지', '아동', '인문'],
      excludedMajorKeywords: ['공학', '물리', '수학', '통계', '화학'],
      fitScoreRange: { min: 55, max: 90 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 25 },
      },
      featuresApplied: {
        tagFilterApplied: true,  // math_impossible 제약 활성화
        internalConflictRisk: false,
        diversityGuardApplied: true,
        archetypeInjected: true,
      },
    },

    careerState: 'student',
    narrativeAnswers: {
      motivation: '사람들을 돕고 가르치는 일에 보람을 느낍니다. 학교에서 친구들에게 설명해주는 걸 좋아하고, 상담 관련 일에도 관심이 있습니다.',
      avoidance: '수학이 많은 학과는 절대 안 됩니다. 실험이나 실습보다는 이론과 토론 위주가 좋습니다.',
      constraints: '수시 전형으로 준비 중이고, 내신은 국어/사회 과목이 강합니다. 학생부 활동으로 봉사와 교육 동아리를 했습니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '사람들의 마음을 이해하고 도와주는 직업이면 좋겠습니다.',
        '교육이나 복지 분야에서 의미 있는 일을 하고 싶습니다.',
        '글을 읽고 토론하는 수업이 가장 재미있습니다.',
      ],
      round2: [
        '숫자가 많이 나오는 과목은 정말 싫습니다.',
        '혼자 연구실에서 실험하는 것보다 사람들과 함께하는 게 좋습니다.',
        '정답이 딱 정해진 문제보다 열린 토론이 더 편합니다.',
      ],
      round3: [
        '학교 내신 평균 2등급 정도이고, 국어/사회 과목이 특히 좋습니다.',
        '서울이나 수도권 대학을 희망합니다.',
        '교직이수가 가능한 학과면 좋겠습니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 3: 예술형 학생
  // ============================================
  {
    id: 'major_creative_student',
    name: '예술형 학생',
    description: '디자인, 미술, 창작에 관심이 많은 학생',
    category: 'basic',
    academicState: 'high_school_undecided',

    miniModule: {
      interest_top: ['creating', 'influencing'],
      value_top: ['autonomy', 'recognition'],
      strength_top: ['creative', 'communication'],
      constraint_flags: [],
      workstyle_top: ['flexible'],
      background_flags: [],
      language_skills: [],
      sacrifice_flags: ['low_initial_income', 'ignore_social_pressure'],
      energy_drain_flags: ['repetition_drain', 'time_pressure_drain'],
      achievement_feedback_top: ['tangible_output_feedback', 'growth_feedback'],
      execution_style: 'action_first',
      impact_scope: 'impact_society',
      failure_response: 'pivot_on_failure',
      persistence_anchor: 'meaning_anchor',
      external_expectation: 'expectation_pressure',
    },

    canValidationAnswers: {
      'can_creative': 'portfolio_exists',
    },

    constraintIntensityAnswers: {},

    llmFollowupAnswers: [
      {
        questionPattern: '디자인|미술|예술|창작',
        answer: '어릴 때부터 그림 그리기를 좋아했고, 디지털 아트도 독학으로 배웠습니다. 포트폴리오도 준비하고 있어요.',
        expectedFactKey: 'like.art_experience.detail',
      },
      {
        questionPattern: '진로|직업|미래',
        answer: 'UX 디자이너나 일러스트레이터가 되고 싶습니다. 내 작품으로 사람들에게 영감을 주고 싶어요.',
        expectedFactKey: 'like.career_goal',
      },
    ],

    expectedResults: {
      topMajorKeywords: ['디자인', '미술', '시각', '산업디자인', '영상', '애니메이션', '건축'],
      excludedMajorKeywords: ['수학', '통계', '법학', '회계', '경제'],
      fitScoreRange: { min: 55, max: 95 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 35 },
      },
      featuresApplied: {
        tagFilterApplied: false,
        internalConflictRisk: false,
        diversityGuardApplied: true,
        archetypeInjected: true,
      },
    },

    careerState: 'student',
    narrativeAnswers: {
      motivation: '무언가를 직접 만들고 디자인하는 것이 가장 즐겁습니다. 내 아이디어가 시각적으로 구현될 때 최고의 성취감을 느낍니다.',
      avoidance: '반복적인 암기나 정해진 틀에 맞춰야 하는 학습은 답답합니다. 수학적 계산이 많은 분야도 맞지 않습니다.',
      constraints: '아직 입시 방향을 정하지 못했습니다. 미대 실기 준비도 고민 중이고, 일반 전형도 생각하고 있습니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '그림, 디자인, 영상 편집 같은 창작 활동에 빠지면 하루가 금방 갑니다.',
        '남들과 다른 독창적인 결과물을 만들 때 가장 뿌듯합니다.',
        '예술적 감각을 살릴 수 있으면서도 실용적인 분야를 찾고 싶습니다.',
      ],
      round2: [
        '규칙이나 절차가 엄격한 환경은 숨 막힙니다.',
        '같은 것을 반복하는 일은 금방 지루해집니다.',
        '다른 사람의 기대에 맞추느라 내 스타일을 못 살리면 스트레스받습니다.',
      ],
      round3: [
        '미대 실기 준비를 할지, 디자인과를 일반 전형으로 갈지 고민 중입니다.',
        '부모님은 안정적인 직업을 원하시지만, 저는 창작 분야를 하고 싶습니다.',
        '학비나 비용은 크게 걱정되지 않습니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 4: 취업 중시 학생
  // ============================================
  {
    id: 'major_career_focused',
    name: '취업 중시 학생',
    description: '졸업 후 취업률과 소득을 중시하는 실용적 학생',
    category: 'basic',
    academicState: 'high_school_regular',

    miniModule: {
      interest_top: ['organizing', 'data_numbers'],
      value_top: ['income', 'stability'],
      strength_top: ['structured_execution', 'persistence'],
      constraint_flags: ['low_employment_avoid'],
      workstyle_top: ['structured', 'team'],
      background_flags: [],
      language_skills: [{ language: 'english', level: 'basic' as const }],
      sacrifice_flags: ['no_sacrifice'],
      energy_drain_flags: ['unpredictability_drain', 'cognitive_drain'],
      achievement_feedback_top: ['metric_feedback'],
      execution_style: 'plan_first',
      impact_scope: 'impact_team',
      failure_response: 'iterate_on_failure',
      persistence_anchor: 'reward_anchor',
      external_expectation: 'external_structure_ok',
    },

    canValidationAnswers: {
      'can_structured_execution': 'school_activity',
    },

    constraintIntensityAnswers: {
      'intensity_employment': 'strong_prefer',
    },

    llmFollowupAnswers: [
      {
        questionPattern: '취업|직업|소득|연봉',
        answer: '졸업하면 바로 취업할 수 있는 학과가 좋습니다. 연봉도 중요합니다.',
        expectedFactKey: 'like.career_priority',
      },
      {
        questionPattern: '안정|공무원|정규직',
        answer: '대기업이나 공기업 같은 안정적인 직장에 취업하고 싶습니다.',
        expectedFactKey: 'like.stability_preference',
      },
    ],

    expectedResults: {
      topMajorKeywords: ['간호', '컴퓨터', '경영', '전자', '약학', '기계', '회계', '금융'],
      excludedMajorKeywords: ['철학', '사학', '문학', '순수미술', '고고학'],
      fitScoreRange: { min: 55, max: 90 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 25 },
      },
      featuresApplied: {
        tagFilterApplied: true,  // low_employment_avoid 활성화
        internalConflictRisk: false,
        diversityGuardApplied: true,
        archetypeInjected: true,
      },
    },

    careerState: 'student',
    narrativeAnswers: {
      motivation: '졸업 후 빠르게 취업해서 경제적으로 안정되고 싶습니다. 구체적인 기술이나 자격을 갖추는 것이 중요하다고 생각합니다.',
      avoidance: '취업률이 낮은 인문계열이나, 졸업해도 뭘 할 수 있을지 모르는 학과는 피하고 싶습니다.',
      constraints: '수능 성적은 중상위권이고, 서울/수도권 대학을 목표로 합니다. 장학금이 있으면 좋지만 등록금은 부담 가능합니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '안정적인 대기업이나 공기업에 입사하는 것이 목표입니다.',
        '실용적인 기술을 배워서 바로 활용할 수 있는 전공이 좋습니다.',
        '월급이 좋고 정년이 보장되는 직장을 원합니다.',
      ],
      round2: [
        '뭘 배우는지는 모르겠고 졸업장만 주는 학과는 싫습니다.',
        '4년 배워도 취업이 안 되면 시간 낭비라고 생각합니다.',
        '너무 이론적이기만 한 학과는 맞지 않습니다.',
      ],
      round3: [
        '수능 전 과목 평균 2~3등급 수준입니다.',
        '부모님도 취업 잘 되는 학과를 원하십니다.',
        '등록금은 부담 가능하지만, 너무 비싼 사립은 부담됩니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 5: 갈등형 학생 (창의성 vs 안정)
  // ============================================
  {
    id: 'major_conflict_student',
    name: '갈등형 학생',
    description: '창의적 분야를 좋아하지만 안정성도 포기 못하는 학생',
    category: 'conflict',
    academicState: 'high_school_undecided',

    miniModule: {
      interest_top: ['creating', 'organizing'],
      value_top: ['autonomy', 'stability'],  // 충돌 가치
      strength_top: ['creative', 'structured_execution'],
      constraint_flags: [],
      workstyle_top: ['flexible', 'structured'],  // 모순적 선호
      background_flags: [],
      language_skills: [],
      sacrifice_flags: ['low_initial_income'],
      energy_drain_flags: ['unpredictability_drain', 'repetition_drain'],  // 불확실성 싫지만 반복도 싫음
      achievement_feedback_top: ['tangible_output_feedback', 'metric_feedback'],
      execution_style: 'flexible_execution',
      impact_scope: 'impact_team',
      failure_response: 'pause_on_failure',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'expectation_pressure',
    },

    canValidationAnswers: {
      'can_creative': 'hobby_experience',
      'can_structured_execution': 'school_activity',
    },

    constraintIntensityAnswers: {},

    llmFollowupAnswers: [
      {
        questionPattern: '갈등|고민|선택',
        answer: '디자인이나 창작을 좋아하지만, 먹고 살 수 있을지 걱정됩니다.',
        expectedFactKey: 'conflict.creative_vs_stability',
      },
      {
        questionPattern: '부모|주변|기대',
        answer: '부모님은 안정적인 직업을 원하시고, 저도 이해가 되면서도 억울합니다.',
        expectedFactKey: 'conflict.external_pressure',
      },
    ],

    expectedResults: {
      topMajorKeywords: ['산업디자인', 'UX', '미디어', '커뮤니케이션', '건축', '광고', '콘텐츠'],
      excludedMajorKeywords: [],
      fitScoreRange: { min: 50, max: 85 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 30 },
      },
      featuresApplied: {
        tagFilterApplied: false,
        internalConflictRisk: true,  // 내면갈등 감지 필수
        diversityGuardApplied: true,
        archetypeInjected: true,
      },
    },

    careerState: 'student',
    narrativeAnswers: {
      motivation: '창의적인 일을 하면서도 안정적으로 살고 싶습니다. 디자인을 좋아하지만 순수 예술보다는 실용적인 분야가 나을 것 같습니다.',
      avoidance: '너무 틀에 박힌 일도 싫지만, 너무 불확실한 미래도 불안합니다. 둘 다 피하고 싶은데 가능한지 모르겠습니다.',
      constraints: '입시 방향을 못 정했습니다. 미대를 갈까 일반 전형으로 디자인 관련 학과를 갈까 고민입니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '디자인이나 영상 만들기를 좋아하지만, 이것만으로 살 수 있을지 고민됩니다.',
        '창의적이면서도 취업이 잘 되는 분야가 있으면 좋겠습니다.',
        '내 아이디어가 실제 제품이나 서비스가 되는 걸 보고 싶습니다.',
      ],
      round2: [
        '매일 같은 일을 반복하는 건 답답하지만, 너무 불안정한 것도 싫습니다.',
        '예술가처럼 가난해질까 봐 걱정이면서도 사무직은 답답할 것 같습니다.',
        '두 가지 사이에서 항상 갈등합니다.',
      ],
      round3: [
        '성적은 중간 정도이고, 특별히 잘하는 과목은 없습니다.',
        '부모님은 안정적인 학과를 권하시지만 설득할 수 있을 것 같습니다.',
        '서울 또는 수도권이면 좋겠습니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 6: 수학 제약 학생 (edge case)
  // ============================================
  {
    id: 'major_math_constrained',
    name: '수학 제약 학생',
    description: '수학이 절대 안 되지만, 문제해결과 기술에 관심 있는 학생',
    category: 'edge_case',
    academicState: 'retake',

    miniModule: {
      interest_top: ['problem_solving', 'helping_teaching'],
      value_top: ['growth', 'meaning'],
      strength_top: ['communication', 'fast_learning'],
      constraint_flags: ['math_impossible'],
      workstyle_top: ['team', 'flexible'],
      background_flags: [],
      language_skills: [{ language: 'english', level: 'business' as const }],
      sacrifice_flags: ['willing_to_study', 'field_change_ok'],
      energy_drain_flags: ['cognitive_drain', 'time_pressure_drain'],
      achievement_feedback_top: ['helping_feedback', 'problem_solved_feedback'],
      execution_style: 'flexible_execution',
      impact_scope: 'impact_individual',
      failure_response: 'iterate_on_failure',
      persistence_anchor: 'meaning_anchor',
      external_expectation: 'neutral_to_expectation',
    },

    canValidationAnswers: {
      'can_communication': 'work_experience_1to3',
      'can_fast_learning': 'self_study',
    },

    constraintIntensityAnswers: {
      'intensity_math': 'absolute',
    },

    llmFollowupAnswers: [
      {
        questionPattern: '수학|숫자|계산|정량',
        answer: '수학을 정말 못합니다. 수포자라서 수학 집중 학과는 절대 안 됩니다.',
        expectedFactKey: 'constraint.math.absolute',
      },
      {
        questionPattern: '문제|해결|논리',
        answer: '수학은 못하지만 사람 사이의 문제를 해결하거나 논리적으로 생각하는 것은 좋아합니다.',
        expectedFactKey: 'like.non_math_problem_solving',
      },
    ],

    expectedResults: {
      topMajorKeywords: ['교육', '심리', '사회', '커뮤니케이션', '행정', '법학', '언어', '복지'],
      excludedMajorKeywords: ['수학', '통계', '물리', '컴퓨터공학', '전자', '화학', '경제학'],
      fitScoreRange: { min: 50, max: 85 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 30 },
      },
      featuresApplied: {
        tagFilterApplied: true,  // math_impossible 제약 활성화
        internalConflictRisk: false,
        diversityGuardApplied: true,
        archetypeInjected: true,
      },
    },

    careerState: 'student',
    narrativeAnswers: {
      motivation: '사람들과 소통하면서 문제를 해결하는 일에 관심이 있습니다. 수학 없이도 논리적 사고를 활용할 수 있는 분야를 찾고 있습니다.',
      avoidance: '수학이 핵심인 학과는 절대 안 됩니다. 수포자이기 때문에 통계나 미적분이 필수인 전공은 이수 자체가 불가능합니다.',
      constraints: '재수 중이라 내년에 확실하게 갈 학과를 정해야 합니다. 수능 국어/영어는 괜찮지만 수학은 5등급입니다.',
    },
    roundFallbackAnswers: {
      round1: [
        '사람의 행동이나 사회 현상을 이해하는 데 관심이 많습니다.',
        '영어를 잘해서 글로벌하게 활동할 수 있는 분야면 좋겠습니다.',
        '다른 사람을 가르치거나 상담하는 일이 보람있을 것 같습니다.',
      ],
      round2: [
        '수학이 나오면 머리가 하얘집니다. 절대 안 됩니다.',
        '하루 종일 혼자 연구만 하는 환경도 맞지 않습니다.',
        '시험이 너무 많은 학과는 힘들 것 같습니다.',
      ],
      round3: [
        '수능 수학 5등급이라 이과 계열은 불가능합니다.',
        '국어 2등급, 영어 1등급, 사탐 2등급 정도입니다.',
        '지방이라도 좋은 학과가 있으면 갈 의향이 있습니다.',
      ],
    },
  },
]

// ============================================
// 헬퍼 함수
// ============================================

/**
 * LLM 후속 질문에 대한 자동 응답 선택
 */
export function getMajorFollowupAnswer(
  question: string,
  scenario: MajorTestScenario
): string | null {
  for (const pattern of scenario.llmFollowupAnswers) {
    const regex = new RegExp(pattern.questionPattern, 'i')
    if (regex.test(question)) {
      return pattern.answer
    }
  }
  return null
}

/**
 * Can 검증 질문 자동 응답
 */
export function getMajorCanValidationAnswer(
  questionId: string,
  scenario: MajorTestScenario
): string {
  return scenario.canValidationAnswers[questionId] || 'study_only'
}

/**
 * Risk 강도 질문 자동 응답
 */
export function getMajorConstraintIntensityAnswer(
  questionId: string,
  scenario: MajorTestScenario
): string {
  return scenario.constraintIntensityAnswers[questionId] || 'prefer_avoid'
}

// ============================================
// 결과 검증 함수
// ============================================

export interface MajorTestVerificationResult {
  passed: boolean
  score: number  // 0-100
  details: {
    topMajorsCheck: { passed: boolean; message: string }
    excludedMajorsCheck: { passed: boolean; message: string }
    fitScoreCheck: { passed: boolean; message: string }
    balanceCheck: { passed: boolean; message: string }
    featuresCheck: { passed: boolean; message: string }
  }
  warnings: string[]
  summary: string
}

/**
 * 전공 테스트 결과 검증
 */
export function verifyMajorTestResults(
  scenario: MajorTestScenario,
  actualResults: {
    topMajors: Array<{ major_name: string; scores: { fit: number; like: number; can: number } }>
    excludedMajors: Array<{ major_name: string; reason: string }>
    appliedFeatures: {
      tagFilterApplied: boolean
      conflictRiskApplied: boolean
      diversityGuardApplied: boolean
      archetypeInjected: boolean
    }
  }
): MajorTestVerificationResult {
  const expected = scenario.expectedResults
  const warnings: string[] = []
  let totalScore = 0

  // 1. Top Majors 키워드 검증 (25점)
  const topMajorNames = actualResults.topMajors.slice(0, 5).map(m => m.major_name.toLowerCase())
  const topMajorKeywordMatch = expected.topMajorKeywords.some(keyword =>
    topMajorNames.some(name => name.includes(keyword.toLowerCase()))
  )
  const topMajorsCheck = {
    passed: topMajorKeywordMatch,
    message: topMajorKeywordMatch
      ? `상위 전공에 예상 키워드(${expected.topMajorKeywords.slice(0, 5).join(', ')}) 포함`
      : `상위 전공에 예상 키워드 없음. 실제: ${topMajorNames.slice(0, 3).join(', ')}`,
  }
  if (topMajorsCheck.passed) totalScore += 25

  // 2. 제외 전공 검증 (20점)
  const excludedMajorNames = actualResults.excludedMajors.map(m => m.major_name.toLowerCase())
  const excludedCorrect = expected.excludedMajorKeywords.length === 0 || expected.excludedMajorKeywords.every(keyword =>
    excludedMajorNames.some(name => name.includes(keyword.toLowerCase())) ||
    !topMajorNames.some(name => name.includes(keyword.toLowerCase()))
  )
  const excludedMajorsCheck = {
    passed: excludedCorrect,
    message: excludedCorrect
      ? expected.excludedMajorKeywords.length > 0
        ? `제외 키워드(${expected.excludedMajorKeywords.slice(0, 5).join(', ')}) 올바르게 제외됨`
        : '제외 키워드 없음 (검증 통과)'
      : '일부 제외 전공이 상위에 노출됨',
  }
  if (excludedMajorsCheck.passed) totalScore += 20

  // 3. Fit 점수 범위 검증 (20점)
  const topFitScores = actualResults.topMajors.slice(0, 3).map(m => m.scores.fit)
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

  // 4. Balance 검증 (15점)
  let balancePassed = true
  const topMajor = actualResults.topMajors[0]
  if (topMajor && expected.balanceCheck.canShouldNotDominateLike) {
    const gap = topMajor.scores.can - topMajor.scores.like
    if (gap > expected.balanceCheck.likeCanGap.max) {
      balancePassed = false
      warnings.push(`Can이 Like를 ${gap}점 초과 (최대 허용: ${expected.balanceCheck.likeCanGap.max})`)
    }
  }
  const balanceCheck = {
    passed: balancePassed,
    message: balancePassed
      ? 'Like-Can 밸런스 정상'
      : 'Like-Can 밸런스 이상: Can이 Like를 과도하게 초과',
  }
  if (balanceCheck.passed) totalScore += 15

  // 5. 기능 적용 검증 (20점)
  const { appliedFeatures } = actualResults
  const featureChecks = {
    tagFilter: expected.featuresApplied.tagFilterApplied === appliedFeatures.tagFilterApplied,
    conflict: expected.featuresApplied.internalConflictRisk === appliedFeatures.conflictRiskApplied,
    diversity: expected.featuresApplied.diversityGuardApplied === appliedFeatures.diversityGuardApplied,
    archetype: expected.featuresApplied.archetypeInjected === appliedFeatures.archetypeInjected,
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
    ? `✅ 전공 테스트 통과 (${totalScore}/100)`
    : `❌ 전공 테스트 실패 (${totalScore}/100)`

  return {
    passed,
    score: totalScore,
    details: {
      topMajorsCheck,
      excludedMajorsCheck,
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

export function getMajorScenarioById(id: string): MajorTestScenario | undefined {
  return MAJOR_TEST_SCENARIOS.find(s => s.id === id)
}

export function getMajorScenariosByCategory(category: MajorTestScenario['category']): MajorTestScenario[] {
  return MAJOR_TEST_SCENARIOS.filter(s => s.category === category)
}

export function getAllMajorScenarioSummary(): Array<{
  id: string
  name: string
  description: string
  category: string
}> {
  return MAJOR_TEST_SCENARIOS.map(s => ({
    id: s.id,
    name: s.name,
    description: s.description,
    category: s.category,
  }))
}
