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
      // 기존 핵심 패턴
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
      // 학습스타일
      {
        questionPattern: '공부|학습|방법|스타일|암기|이해',
        answer: '개념을 완전히 이해한 뒤 문제에 적용하는 방식을 좋아합니다. 무작정 암기하는 건 비효율적이라고 생각해요. 혼자 교재로 공부하는 게 가장 잘 맞습니다.',
      },
      // 동기
      {
        questionPattern: '시간.*모르|몰입|빠져|집중',
        answer: '코딩으로 알고리즘 문제를 풀 때 시간 가는 줄 모릅니다. 수학 문제도 어려울수록 더 집중하게 돼요.',
      },
      {
        questionPattern: '동기|원동력|에너지|보람',
        answer: '복잡한 문제를 논리적으로 풀어냈을 때 성취감이 큽니다. 코드가 정상 작동하는 순간이 가장 보람차요.',
      },
      // 강점
      {
        questionPattern: '강점|잘하|능력|역량|자신',
        answer: '논리적 사고력과 수리 능력이 강점입니다. 새로운 프로그래밍 언어도 독학으로 빠르게 배울 수 있어요.',
      },
      // 약점
      {
        questionPattern: '약점|부족|개선|못하|어려',
        answer: '국어 비문학이나 글쓰기는 잘 못합니다. 발표할 때도 긴장을 많이 하는 편이에요.',
      },
      // 학업환경
      {
        questionPattern: '수업|환경|방식|강의|실험|실습',
        answer: '이론 수업보다 실습 위주 수업이 좋습니다. 직접 코딩하거나 실험하면서 배우는 게 이해가 빨라요.',
      },
      // 가치관
      {
        questionPattern: '가치|중요|의미|핵심|우선',
        answer: '전문성을 키워서 실력으로 인정받는 게 가장 중요합니다. 성장할 수 있는 환경이면 초봉이 낮아도 괜찮아요.',
      },
      // 현실제약
      {
        questionPattern: '현실|제약|조건|성적|부모|경제|등록금',
        answer: '수능 수학 1등급, 과탐 1~2등급입니다. 부모님은 제 선택을 존중해주시고, 등록금 부담은 없습니다.',
      },
      // 관계
      {
        questionPattern: '관계|사람|팀|소통|협업|친구',
        answer: '소수의 친한 친구들과 깊은 대화를 좋아합니다. 팀 프로젝트에서는 분석이나 코딩 파트를 맡는 편이에요.',
      },
      // 갈등
      {
        questionPattern: '갈등|고민|선택|걱정|불안',
        answer: '컴퓨터공학이랑 전자공학 사이에서 고민이에요. 둘 다 관심 있는데 어디가 더 맞을지 아직 모르겠습니다.',
      },
      // 미래계획
      {
        questionPattern: '미래|5년|10년|계획|목표|꿈',
        answer: '대학원까지 가서 AI나 데이터 사이언스 분야를 깊이 공부하고 싶습니다. 10년 후에는 빅테크 기업에서 일하고 싶어요.',
      },
      // 실패경험
      {
        questionPattern: '실패|어려움|힘들었|좌절|극복',
        answer: '정보올림피아드에서 떨어진 적이 있는데, 그때 부족한 부분을 분석해서 다음 해에 입상했습니다. 실패를 분석하는 과정이 오히려 도움이 됐어요.',
      },
      // 싫은 것/피하고 싶은 것
      {
        questionPattern: '싫|피하|스트레스|답답',
        answer: '암기 위주 시험이 가장 스트레스입니다. 토론이나 발표가 많은 수업도 별로예요.',
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
      // 기존 핵심 패턴
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
      // 학습스타일
      {
        questionPattern: '공부|학습|방법|스타일|암기|이해',
        answer: '교과서를 읽고 핵심을 노트에 정리하는 방식을 선호합니다. 친구들과 함께 토론하면서 공부하면 더 잘 이해돼요.',
      },
      // 동기
      {
        questionPattern: '시간.*모르|몰입|빠져|집중',
        answer: '심리학 관련 책을 읽을 때 시간 가는 줄 모릅니다. 친구의 고민을 상담해줄 때도 완전히 몰입하게 돼요.',
      },
      {
        questionPattern: '동기|원동력|에너지|보람',
        answer: '제가 도와준 덕분에 누군가가 힘을 내는 모습을 보면 정말 보람 있습니다. 의미 있는 일을 한다는 확신이 에너지원이에요.',
      },
      // 강점
      {
        questionPattern: '강점|잘하|능력|역량|자신',
        answer: '공감 능력이 좋고, 다른 사람의 이야기를 잘 들어주는 편입니다. 글쓰기와 토론 능력도 강점이에요.',
      },
      // 약점
      {
        questionPattern: '약점|부족|개선|못하|어려',
        answer: '숫자나 통계 관련 과목이 약합니다. 데이터를 분석하거나 수식을 다루는 건 정말 어렵게 느껴져요.',
      },
      // 학업환경
      {
        questionPattern: '수업|환경|방식|강의|토론',
        answer: '토론 수업이나 사례 중심 수업이 가장 재미있습니다. 교수님이 일방적으로 강의하는 것보다 학생들이 참여하는 수업이 좋아요.',
      },
      // 가치관
      {
        questionPattern: '가치|중요|의미|핵심|우선',
        answer: '사회에 의미 있는 일을 하는 것이 가장 중요합니다. 돈보다는 사람들에게 도움이 되는 직업을 갖고 싶어요.',
      },
      // 현실제약
      {
        questionPattern: '현실|제약|조건|성적|부모|경제|등록금',
        answer: '내신 국어 2등급, 사회 1등급, 수학은 5등급입니다. 수시 학생부종합 전형으로 준비 중이고, 등록금은 장학금이 있으면 좋겠어요.',
      },
      // 관계
      {
        questionPattern: '관계|사람|팀|소통|협업|친구',
        answer: '친구들과 함께하는 활동을 좋아합니다. 팀 프로젝트에서는 조장을 맡아 의견을 조율하는 역할을 자주 해요.',
      },
      // 갈등
      {
        questionPattern: '갈등|고민|선택|걱정|불안',
        answer: '교육학과 심리학 사이에서 고민입니다. 가르치는 것도 좋지만 상담하는 것도 해보고 싶어서요.',
      },
      // 미래계획
      {
        questionPattern: '미래|5년|10년|계획|목표|꿈|진로|직업',
        answer: '교사나 상담사가 되고 싶습니다. 교직이수를 해서 교단에 서거나, 상담 자격증을 따서 전문 상담사가 되고 싶어요.',
      },
      // 실패경험
      {
        questionPattern: '실패|어려움|힘들었|좌절|극복',
        answer: '수학 때문에 전과목 성적이 떨어진 적이 있어요. 그때 수학 포기를 결심하고 국어와 사회에 집중했더니 전체 성적이 올랐습니다.',
      },
      // 싫은 것
      {
        questionPattern: '싫|피하|스트레스|답답',
        answer: '혼자 오래 앉아서 계산하는 과목이 가장 싫습니다. 정답이 하나뿐인 문제보다 여러 관점에서 생각할 수 있는 주제가 좋아요.',
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
      // 기존 핵심 패턴
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
      // 학습스타일
      {
        questionPattern: '공부|학습|방법|스타일|암기|이해',
        answer: '직접 해보면서 배우는 게 가장 잘 맞아요. 이론 수업보다 실기 수업에서 배운 것이 훨씬 오래 기억에 남습니다.',
      },
      // 동기
      {
        questionPattern: '시간.*모르|몰입|빠져|집중',
        answer: '그림을 그리거나 영상 편집을 할 때 밤새도록 빠져듭니다. 작업이 완성되어갈 때의 쾌감이 중독적이에요.',
      },
      {
        questionPattern: '동기|원동력|에너지|보람',
        answer: '내 손으로 무언가를 완성했을 때 가장 큰 에너지를 받습니다. SNS에 올린 그림에 좋은 반응이 오면 더 열심히 하게 돼요.',
      },
      // 강점
      {
        questionPattern: '강점|잘하|능력|역량|자신',
        answer: '시각적 감각이 좋다는 말을 자주 듣습니다. 색감 조합이나 구도를 잡는 능력이 뛰어나고, 새로운 스타일을 빠르게 습득해요.',
      },
      // 약점
      {
        questionPattern: '약점|부족|개선|못하|어려',
        answer: '수학이나 과학처럼 정확한 답을 요구하는 과목은 어렵습니다. 마감 기한을 지키는 것도 가끔 힘들어요.',
      },
      // 학업환경
      {
        questionPattern: '수업|환경|방식|강의|실기|실습',
        answer: '자유롭게 작업할 수 있는 아틀리에 같은 환경이 좋습니다. 정해진 틀 없이 자기 스타일을 발전시킬 수 있는 수업이 최고예요.',
      },
      // 가치관
      {
        questionPattern: '가치|중요|의미|핵심|우선',
        answer: '자기 표현의 자유가 가장 중요합니다. 남들 눈치 보지 않고 내 작품 세계를 구축하고 싶어요. 돈보다 인정이 중요합니다.',
      },
      // 현실제약
      {
        questionPattern: '현실|제약|조건|성적|부모|경제|등록금',
        answer: '내신 성적은 중위권이고 미술 실기는 자신 있습니다. 부모님은 순수미술보다 디자인 쪽을 권하시는데, 어느 정도 이해는 돼요.',
      },
      // 관계
      {
        questionPattern: '관계|사람|팀|소통|협업|친구',
        answer: '비슷한 취향의 친구들과 합작 프로젝트를 할 때 즐겁습니다. 하지만 작품 스타일을 강요당하면 갈등이 생겨요.',
      },
      // 갈등
      {
        questionPattern: '갈등|고민|선택|걱정|불안|부모|기대',
        answer: '순수미술을 하고 싶지만 현실적으로 먹고살 수 있을지 걱정됩니다. 부모님은 실용적인 디자인을 하라고 하세요.',
      },
      // 미래계획
      {
        questionPattern: '미래|5년|10년|계획|목표|꿈',
        answer: '졸업 후 디자인 스튜디오에서 경력을 쌓고, 언젠가는 내 브랜드를 만들고 싶습니다. 해외 유학도 고려하고 있어요.',
      },
      // 실패경험
      {
        questionPattern: '실패|어려움|힘들었|좌절|극복',
        answer: '미술 대회에서 입상하지 못했을 때 많이 속상했어요. 하지만 심사평을 분석하고 스타일을 개선한 뒤 다음 대회에서 상을 받았습니다.',
      },
      // 싫은 것
      {
        questionPattern: '싫|피하|스트레스|답답',
        answer: '정해진 정답대로 해야 하는 것이 가장 답답합니다. 같은 것을 반복 연습하는 것도 지루해요.',
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
      // 기존 핵심 패턴
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
      // 학습스타일
      {
        questionPattern: '공부|학습|방법|스타일|암기|이해',
        answer: '시험에 나올 것 위주로 효율적으로 공부합니다. 자격증 시험처럼 목표가 확실한 공부가 잘 맞아요.',
      },
      // 동기
      {
        questionPattern: '시간.*모르|몰입|빠져|집중',
        answer: '자격증 공부할 때 집중이 잘 됩니다. 합격하면 취업에 도움이 된다는 확실한 보상이 있으니까요.',
      },
      {
        questionPattern: '동기|원동력|에너지|보람',
        answer: '구체적인 성과가 나올 때 동기부여가 됩니다. 자격증 합격, 인턴 합격 같은 눈에 보이는 결과가 중요해요.',
      },
      // 강점
      {
        questionPattern: '강점|잘하|능력|역량|자신',
        answer: '계획을 세우고 꾸준히 실행하는 것이 강점입니다. 목표를 정하면 끝까지 해내는 끈기가 있어요.',
      },
      // 약점
      {
        questionPattern: '약점|부족|개선|못하|어려',
        answer: '창의적으로 생각하거나 새로운 아이디어를 내는 것은 어렵습니다. 정해진 절차대로 하는 게 더 편해요.',
      },
      // 학업환경
      {
        questionPattern: '수업|환경|방식|강의|실습',
        answer: '실무 중심 커리큘럼이 좋습니다. 현장 실습이나 인턴십이 포함된 학과가 취업에 유리하다고 생각해요.',
      },
      // 가치관
      {
        questionPattern: '가치|중요|의미|핵심|우선',
        answer: '경제적 안정이 최우선입니다. 꿈도 좋지만 먼저 먹고사는 문제가 해결돼야 한다고 생각합니다.',
      },
      // 현실제약
      {
        questionPattern: '현실|제약|조건|성적|부모|경제|등록금',
        answer: '수능 전 과목 평균 2~3등급이고, 부모님도 취업 잘 되는 학과를 강력히 원하십니다. 너무 비싼 사립은 부담이에요.',
      },
      // 관계
      {
        questionPattern: '관계|사람|팀|소통|협업|친구',
        answer: '스터디 그룹에서 함께 공부하는 걸 좋아합니다. 팀 프로젝트에서는 일정 관리와 자료 정리를 잘하는 편이에요.',
      },
      // 갈등
      {
        questionPattern: '갈등|고민|선택|걱정|불안',
        answer: '간호학과와 경영학과 사이에서 고민입니다. 간호는 취업률이 높지만 적성에 맞을지, 경영은 범위가 넓어서 고민이에요.',
      },
      // 미래계획
      {
        questionPattern: '미래|5년|10년|계획|목표|꿈|진로',
        answer: '졸업 후 바로 취업해서 2~3년 차에 자리 잡고 싶습니다. 대기업이나 공기업 입사가 목표예요.',
      },
      // 실패경험
      {
        questionPattern: '실패|어려움|힘들었|좌절|극복',
        answer: '모의고사 성적이 한때 급락한 적이 있는데, 그때 공부 계획을 다시 짜고 매일 실행한 결과 성적을 회복했습니다.',
      },
      // 싫은 것
      {
        questionPattern: '싫|피하|스트레스|답답',
        answer: '졸업해도 뭘 할 수 있는지 모호한 학과는 절대 싫습니다. 이론만 배우고 실무와 동떨어진 수업도 답답해요.',
      },
      // 대학원 관련
      {
        questionPattern: '대학원|석사|박사|연구',
        answer: '대학원은 생각 없습니다. 4년 졸업 후 바로 취업하는 것이 목표입니다.',
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
      // 기존 핵심 패턴
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
      // 학습스타일
      {
        questionPattern: '공부|학습|방법|스타일|암기|이해',
        answer: '프로젝트 형태로 배우는 게 좋아요. 그런데 시험 공부는 체계적으로 하는 편입니다. 두 가지 방식이 다 필요한 것 같아요.',
      },
      // 동기
      {
        questionPattern: '시간.*모르|몰입|빠져|집중',
        answer: '영상 편집이나 디자인 작업을 할 때 시간 가는 줄 모릅니다. 하지만 이런 작업만으로 돈을 벌 수 있을지 불안하기도 해요.',
      },
      {
        questionPattern: '동기|원동력|에너지|보람',
        answer: '내 아이디어가 구체적인 결과물이 되었을 때 보람 있지만, 동시에 이것이 직업이 될 수 있는지 고민됩니다.',
      },
      // 강점
      {
        questionPattern: '강점|잘하|능력|역량|자신',
        answer: '창의적 아이디어를 내면서도 실행 계획을 세울 줄 압니다. 두 가지 스타일을 다 가진 게 강점이자 혼란의 원인이에요.',
      },
      // 약점
      {
        questionPattern: '약점|부족|개선|못하|어려',
        answer: '결정을 잘 못 내리는 게 가장 큰 약점입니다. 이것도 좋고 저것도 좋아서 하나를 선택하면 후회할까 봐 두려워요.',
      },
      // 학업환경
      {
        questionPattern: '수업|환경|방식|강의|실기|실습',
        answer: '실기와 이론이 균형 잡힌 수업이 좋습니다. 창작만 하면 불안하고, 이론만 하면 지루해요.',
      },
      // 가치관
      {
        questionPattern: '가치|중요|의미|핵심|우선',
        answer: '자기 표현도 중요하지만 경제적 안정도 포기할 수 없습니다. 둘 다 충족시킬 수 있는 분야가 있으면 좋겠어요.',
      },
      // 현실제약
      {
        questionPattern: '현실|제약|조건|성적|경제|등록금',
        answer: '성적은 중간 정도이고, 미대 실기 준비를 할지 일반 전형으로 갈지 결정을 못 했습니다.',
      },
      // 관계
      {
        questionPattern: '관계|사람|팀|소통|협업|친구',
        answer: '작업할 때는 혼자가 편하지만, 프로젝트 결과물을 공유하고 피드백 받는 건 좋아합니다.',
      },
      // 미래계획
      {
        questionPattern: '미래|5년|10년|계획|목표|꿈|진로|직업',
        answer: 'UX 디자이너나 브랜드 기획자처럼 창의성과 안정성을 모두 가질 수 있는 직업이면 좋겠습니다.',
      },
      // 실패경험
      {
        questionPattern: '실패|어려움|힘들었|좌절|극복',
        answer: '미술 학원과 입시 학원을 동시에 다니려다 둘 다 중도에 그만둔 적이 있어요. 한꺼번에 두 방향을 추구하니까 힘들었습니다.',
      },
      // 싫은 것
      {
        questionPattern: '싫|피하|스트레스|답답',
        answer: '하나만 선택하라고 강요하는 상황이 가장 스트레스입니다. 또 매일 같은 일만 반복하는 것도 싫지만, 너무 불확실한 것도 싫어요.',
      },
      // 디자인/창작
      {
        questionPattern: '디자인|미술|예술|창작|영상',
        answer: '영상 편집과 그래픽 디자인을 취미로 하고 있습니다. 유튜브 채널도 운영해봤는데 구독자가 조금 생겼어요.',
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
      // 기존 핵심 패턴
      {
        questionPattern: '수학|숫자|계산|정량|통계',
        answer: '수학을 정말 못합니다. 수포자라서 수학 집중 학과는 절대 안 됩니다.',
        expectedFactKey: 'constraint.math.absolute',
      },
      {
        questionPattern: '문제|해결|논리',
        answer: '수학은 못하지만 사람 사이의 문제를 해결하거나 논리적으로 생각하는 것은 좋아합니다.',
        expectedFactKey: 'like.non_math_problem_solving',
      },
      // 학습스타일
      {
        questionPattern: '공부|학습|방법|스타일|암기|이해',
        answer: '지문을 읽고 핵심을 파악하는 독해형 공부가 잘 맞습니다. 토론이나 에세이 쓰기도 즐기는 편이에요.',
      },
      // 동기
      {
        questionPattern: '시간.*모르|몰입|빠져|집중',
        answer: '영어 원서를 읽거나 사회 문제에 대해 글을 쓸 때 몰입합니다. 사람들의 이야기를 들으면서 상담할 때도 시간이 빨리 가요.',
      },
      {
        questionPattern: '동기|원동력|에너지|보람',
        answer: '누군가의 문제를 함께 고민하고 해결 방향을 찾아줄 때 보람을 느낍니다. 논리적으로 설득하는 데 성공했을 때도 기분이 좋아요.',
      },
      // 강점
      {
        questionPattern: '강점|잘하|능력|역량|자신',
        answer: '영어 실력이 좋고 글쓰기에 자신 있습니다. 새로운 분야를 빠르게 배우는 것도 강점이에요. 사람의 마음을 읽는 공감 능력도 있습니다.',
      },
      // 약점
      {
        questionPattern: '약점|부족|개선|못하|어려',
        answer: '수학이 최대 약점입니다. 숫자만 보면 머리가 하얘지고, 미적분이나 통계가 필수인 학과는 이수 자체가 불가능합니다.',
      },
      // 학업환경
      {
        questionPattern: '수업|환경|방식|강의|토론|실습',
        answer: '토론과 발표 중심 수업이 잘 맞습니다. 현장 실습이나 인턴십이 있으면 좋겠고, 사람과 교류하면서 배우고 싶어요.',
      },
      // 가치관
      {
        questionPattern: '가치|중요|의미|핵심|우선',
        answer: '의미 있는 일을 하는 것이 중요합니다. 수학 없이도 사회에 기여할 수 있는 분야가 분명히 있다고 생각해요.',
      },
      // 현실제약
      {
        questionPattern: '현실|제약|조건|성적|부모|경제|등록금',
        answer: '재수 중이라 내년이 마지막 기회입니다. 국어 2등급, 영어 1등급, 사탐 2등급이지만 수학은 5등급이에요. 지방이라도 좋은 학과가 있으면 갈 의향이 있습니다.',
      },
      // 관계
      {
        questionPattern: '관계|사람|팀|소통|협업|친구',
        answer: '사람들과 함께 일하는 것을 좋아합니다. 팀 프로젝트에서 발표나 조율 역할을 자주 맡아요. 혼자 연구실에 갇혀 있는 건 안 맞습니다.',
      },
      // 갈등
      {
        questionPattern: '갈등|고민|선택|걱정|불안',
        answer: '문제해결을 좋아하는데 수학이 안 되니까 갈 수 있는 길이 제한되는 것 같아 답답합니다. IT나 공학에 관심은 있지만 수학 때문에 포기해야 하는 게 아쉬워요.',
      },
      // 미래계획
      {
        questionPattern: '미래|5년|10년|계획|목표|꿈|진로|직업',
        answer: '상담사나 사회복지사, 혹은 교육 분야에서 일하고 싶습니다. 영어를 살려서 국제기구나 NGO에서 일하는 것도 꿈이에요.',
      },
      // 실패경험
      {
        questionPattern: '실패|어려움|힘들었|좌절|극복',
        answer: '첫 수능에서 수학 때문에 전체 성적이 무너져서 재수를 결심했습니다. 이번에는 수학에 시간 낭비하지 말고 강점에 집중하기로 전략을 바꿨어요.',
      },
      // 싫은 것
      {
        questionPattern: '싫|피하|스트레스|답답',
        answer: '수학 과목이 있으면 다른 것을 아무리 잘해도 무너집니다. 시험 기간에 수학 공부하는 것 자체가 극심한 스트레스예요.',
      },
      // 영어 관련
      {
        questionPattern: '영어|외국어|언어|글로벌',
        answer: '영어는 자신 있습니다. 영어 원서도 읽고, TOEIC도 850점 이상이에요. 영어를 활용할 수 있는 전공이면 좋겠습니다.',
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

  // ============================================
  // 시나리오 7: 호기심 많은 어린이
  // ============================================
  {
    id: 'major_child_curious',
    name: '호기심 많은 어린이',
    description: '만들기와 탐험을 좋아하는 어린이 (미성년 제한 적용 확인)',
    category: 'edge_case',
    academicState: 'high_school_undecided' as AcademicState,

    miniModule: {
      interest_top: ['creating', 'problem_solving'],
      value_top: ['growth', 'autonomy'],
      strength_top: ['creative', 'fast_learning'],
      constraint_flags: [],
      workstyle_top: ['flexible'],
      background_flags: [],
      language_skills: [],
      sacrifice_flags: [],
      energy_drain_flags: ['repetition_drain'],
      achievement_feedback_top: ['tangible_output_feedback', 'growth_feedback'],
      execution_style: 'action_first',
      impact_scope: 'impact_individual',
      failure_response: 'pivot_on_failure',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'neutral_to_expectation',
    },

    canValidationAnswers: {},
    constraintIntensityAnswers: {},

    llmFollowupAnswers: [
      // 기존 핵심 패턴
      {
        questionPattern: '좋아하|관심|재미',
        answer: '레고 조립하고 그림 그리는 게 제일 재미있어요. 과학 실험도 좋아합니다.',
        expectedFactKey: 'like.creative_activity',
      },
      {
        questionPattern: '꿈|되고 싶|미래',
        answer: '과학자나 게임 만드는 사람이 되고 싶어요.',
        expectedFactKey: 'like.dream_job',
      },
      // 학습스타일
      {
        questionPattern: '공부|학습|방법|수업|학교',
        answer: '직접 만들면서 배우는 게 좋아요. 책만 읽는 건 좀 지루한데, 실험하거나 만들기 하면 재미있어요.',
      },
      // 동기
      {
        questionPattern: '시간.*모르|몰입|빠져|집중',
        answer: '레고로 큰 작품 만들 때 몇 시간이고 집중해요. 엄마가 밥 먹으라고 불러도 안 들릴 때가 있어요.',
      },
      // 강점/잘하는 것
      {
        questionPattern: '강점|잘하|능력|자신|칭찬',
        answer: '손으로 만드는 거 잘한다고 선생님이 칭찬해주셨어요. 상상력이 풍부하다는 말도 많이 들어요.',
      },
      // 약점/어려운 것
      {
        questionPattern: '약점|못하|어려|힘든|싫',
        answer: '가만히 앉아서 글 읽는 건 지루해요. 받아쓰기도 좀 어렵고, 정리 정돈도 잘 못해요.',
      },
      // 관계
      {
        questionPattern: '관계|친구|같이|팀|함께',
        answer: '친구들이랑 같이 놀 때 재미있어요. 하지만 혼자서 조용히 만들기 할 때도 좋아요.',
      },
      // 가치/중요한 것
      {
        questionPattern: '가치|중요|의미|원하',
        answer: '새로운 걸 배우는 게 좋아요. 모르는 걸 알게 되면 신나요!',
      },
      // 갈등/걱정
      {
        questionPattern: '갈등|고민|걱정|무서|불안',
        answer: '아직 잘 모르겠어요. 하고 싶은 게 많아서 하나만 고르기 어려워요.',
      },
      // 과학/탐험
      {
        questionPattern: '과학|실험|탐험|발견|궁금',
        answer: '공룡 뼈가 왜 화석이 되는지 궁금해요. 우주에서 사는 건 어떨지도 상상해봐요.',
      },
    ],

    expectedResults: {
      topMajorKeywords: ['디자인', '미술', '공학', '과학', '게임', '교육'],
      excludedMajorKeywords: [],
      fitScoreRange: { min: 40, max: 90 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 40 },
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
      motivation: '레고 만들기랑 그림 그리기를 좋아해요. 공룡이랑 우주도 좋아합니다.',
      avoidance: '가만히 앉아서 글 읽는 건 지루해요.',
      constraints: '아직 어린이라 잘 모르겠어요.',
    },
    roundFallbackAnswers: {
      round1: [
        '만들기를 좋아하고, 새로운 것을 배우면 신나요.',
        '과학 실험할 때 가장 재미있어요.',
        '게임을 좋아하는데, 직접 만들어보고 싶어요.',
      ],
      round2: [
        '가만히 앉아서 외우는 건 싫어요.',
        '혼자서 조용히 책만 읽는 건 좀 힘들어요.',
        '너무 어려운 문제는 포기하고 싶어져요.',
      ],
      round3: [
        '아직 잘 모르겠지만, 재미있는 걸 하고 싶어요.',
        '부모님이 공부 열심히 하래요.',
        '여러 가지를 해보고 싶어요.',
      ],
    },
  },

  // ============================================
  // 시나리오 8: 관심사 탐색 초등학생
  // ============================================
  {
    id: 'major_elementary_explorer',
    name: '관심사 탐색 초등학생',
    description: '수학과 사회에 관심 많은 초등학생 (미성년 제한 적용 확인)',
    category: 'edge_case',
    academicState: 'high_school_undecided' as AcademicState,

    miniModule: {
      interest_top: ['helping_teaching', 'data_numbers'],
      value_top: ['meaning', 'growth'],
      strength_top: ['communication', 'analytical'],
      constraint_flags: [],
      workstyle_top: ['team', 'structured'],
      background_flags: [],
      language_skills: [],
      sacrifice_flags: ['willing_to_study'],
      energy_drain_flags: ['cognitive_drain'],
      achievement_feedback_top: ['helping_feedback', 'metric_feedback'],
      execution_style: 'plan_first',
      impact_scope: 'impact_individual',
      failure_response: 'iterate_on_failure',
      persistence_anchor: 'meaning_anchor',
      external_expectation: 'external_structure_ok',
    },

    canValidationAnswers: {},
    constraintIntensityAnswers: {},

    llmFollowupAnswers: [
      // 기존 핵심 패턴
      {
        questionPattern: '과목|좋아하|잘하는',
        answer: '수학이랑 사회를 좋아하고, 친구들한테 설명해주는 걸 잘해요.',
        expectedFactKey: 'like.favorite_subject',
      },
      {
        questionPattern: '꿈|되고 싶|미래',
        answer: '선생님이나 의사 같은 사람을 돕는 직업이 되고 싶어요.',
        expectedFactKey: 'like.dream_job',
      },
      // 학습스타일
      {
        questionPattern: '공부|학습|방법|수업|학교',
        answer: '문제를 차근차근 풀어가는 게 좋아요. 선생님이 설명해주시면 바로 이해하는 편이에요.',
      },
      // 동기
      {
        questionPattern: '시간.*모르|몰입|빠져|집중',
        answer: '수학 문제를 풀 때 집중이 잘 돼요. 어려운 문제를 풀면 기분이 좋아요.',
      },
      // 강점/잘하는 것
      {
        questionPattern: '강점|잘하|능력|자신|칭찬',
        answer: '친구들에게 문제 풀이를 잘 설명해준다고 칭찬 받아요. 수학 시험에서 100점도 자주 받아요.',
      },
      // 약점/어려운 것
      {
        questionPattern: '약점|못하|어려|힘든|싫',
        answer: '체육이랑 미술은 좀 어려워요. 혼자 오래 앉아 있으면 힘들 때도 있어요.',
      },
      // 관계
      {
        questionPattern: '관계|친구|같이|팀|함께|도움',
        answer: '친구들이 모르는 거 물어보면 알려주는 게 재미있어요. 선생님 역할 놀이도 좋아해요.',
      },
      // 가치/중요한 것
      {
        questionPattern: '가치|중요|의미|원하',
        answer: '다른 사람을 도와주는 게 좋아요. 칭찬 받으면 더 열심히 하고 싶어져요.',
      },
      // 갈등/걱정
      {
        questionPattern: '갈등|고민|걱정|무서|불안',
        answer: '발표할 때 좀 떨려요. 실수하면 어쩌나 걱정될 때가 있어요.',
      },
      // 사회/역사
      {
        questionPattern: '사회|역사|뉴스|세상',
        answer: '사회 시간에 옛날 이야기 듣는 게 재미있어요. 다른 나라 문화도 궁금해요.',
      },
    ],

    expectedResults: {
      topMajorKeywords: ['교육', '심리', '사회', '수학교육', '의학', '간호'],
      excludedMajorKeywords: [],
      fitScoreRange: { min: 40, max: 90 },
      balanceCheck: {
        canShouldNotDominateLike: true,
        likeCanGap: { max: 40 },
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
      motivation: '수학 문제 푸는 것과 친구들에게 설명해주는 것을 좋아합니다.',
      avoidance: '너무 어려운 과학 실험은 좀 무서워요.',
      constraints: '초등학생이라 아직 많이 배워야 해요.',
    },
    roundFallbackAnswers: {
      round1: [
        '친구들에게 문제를 설명해줄 때 보람을 느껴요.',
        '수학 경시대회에 나가보고 싶어요.',
        '사회 시간에 역사 이야기가 재미있어요.',
      ],
      round2: [
        '혼자 오래 앉아서 하는 건 좀 힘들어요.',
        '외우는 것이 너무 많으면 지쳐요.',
        '발표할 때 떨려요.',
      ],
      round3: [
        '아직 초등학생이지만, 공부를 열심히 하고 싶어요.',
        '좋은 대학에 가고 싶어요.',
        '부모님이 열심히 하라고 응원해주세요.',
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
