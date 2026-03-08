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
      // 기존 핵심 패턴
      { questionPattern: '분석|데이터|통계', answer: '데이터 분석 관련 업무를 3년 이상 해왔습니다. SQL과 Python을 주로 사용하고, A/B 테스트 설계도 경험 있습니다.' },
      { questionPattern: '야근|근무시간|워라밸', answer: '야근이 너무 잦으면 힘들지만, 프로젝트 마감 시 가끔은 괜찮습니다. 주 50시간 이상은 피하고 싶어요.' },
      { questionPattern: '성장|커리어|발전', answer: '전문성을 쌓아서 5년 내 시니어 데이터 분석가가 되고 싶습니다. 머신러닝까지 영역 확장이 목표입니다.' },
      // v3.18: 확장 패턴
      { questionPattern: '시간.*모르|몰입|빠져|집중', answer: '복잡한 데이터셋에서 패턴을 찾을 때 시간 가는 줄 모릅니다. 최근 고객 이탈 분석 모델을 만들 때 주말까지 자발적으로 했어요.' },
      { questionPattern: '동기|원동력|에너지|보람', answer: '문제의 원인을 정확히 진단해서 데이터 기반 해결책을 제시할 때 가장 큰 보람을 느낍니다.' },
      { questionPattern: '관계|사람|팀|소통|협업', answer: '소수의 전문가와 깊이 있는 기술 토론이 좋습니다. 대규모 회의나 영업 활동은 에너지가 빠집니다.' },
      { questionPattern: '싫|피하|스트레스|답답', answer: '의미 없는 보고서 작성이나 형식적 회의가 가장 스트레스입니다. 분석보다 정치에 시간 쓰는 것이 답답합니다.' },
      { questionPattern: '두렵|불안|걱정|무서', answer: '전문성이 정체되는 것이 가장 두렵습니다. 같은 SQL 쿼리만 3년 반복하는 상황은 절대 피하고 싶어요.' },
      { questionPattern: '환경|분위기|조직|문화', answer: '자율적으로 분석 방법론을 선택할 수 있고, 결과로 인정받는 데이터 드리븐 환경이 좋습니다.' },
      { questionPattern: '강점|잘하|능력|역량|자신', answer: '논리적 사고와 꼼꼼한 데이터 검증이 강점입니다. SQL, Python, Tableau 활용 능력이 있습니다.' },
      { questionPattern: '약점|부족|개선|못하', answer: '프레젠테이션이나 대중 앞 발표는 아직 어색합니다. 글로 정리하는 것이 훨씬 편해요.' },
      { questionPattern: '가치|중요|의미|핵심', answer: '전문성과 성장이 가장 중요합니다. 돈보다는 실력을 인정받고 싶고, 자율성이 있어야 합니다.' },
      { questionPattern: '현실|제약|조건|연봉|급여', answer: '현재 연봉 4500만원에서 10% 이상 오르면 좋겠습니다. 서울 강남 출퇴근 1시간 이내 희망합니다.' },
      { questionPattern: '경험|프로젝트|했던|해본', answer: '지난 프로젝트에서 A/B 테스트 설계와 결과 분석을 주도했습니다. ROI 15% 개선한 사례가 있어요.' },
      { questionPattern: '미래|5년|10년|계획|목표', answer: '5년 내 데이터 사이언스팀 리드가 되고 싶고, 머신러닝까지 영역을 확장하고 싶습니다.' },
      { questionPattern: '실패|어려움|힘들었|좌절', answer: '분석 결과를 경영진에게 전달했는데 무시당한 적이 있어요. 그때 커뮤니케이션의 중요성을 깨달았습니다.' },
      { questionPattern: '결정|선택|판단|기준', answer: '데이터에 기반한 의사결정을 가장 신뢰합니다. 직감보다 수치로 증명하는 걸 선호해요.' },
      { questionPattern: '인정|평가|피드백|칭찬', answer: '분석 결과가 실제 비즈니스 성과로 이어졌을 때 가장 큰 보람을 느꼈습니다.' },
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
        '논리적으로 문제를 풀어가는 과정 자체가 저에게 에너지를 줍니다.',
        '데이터 기반 의사결정에 기여할 수 있는 역할이 가장 매력적입니다.',
      ],
      round2: [
        '정치적인 조직 문화나 비효율적인 프로세스는 지치게 합니다.',
        '분석보다 보고서 작성에 시간을 더 쓰는 건 피하고 싶습니다.',
        '의미 없는 회의가 많은 환경은 맞지 않습니다.',
        '대인 관계에 에너지를 많이 쓰는 역할은 힘들어요. 집중 시간이 필요합니다.',
        '전문성 없이 넓고 얕게만 하는 제너럴리스트 역할은 피하고 싶습니다.',
      ],
      round3: [
        '현재 연봉에서 10% 이상 상승을 기대합니다.',
        '리모트 워크가 가능하면 좋지만 필수는 아닙니다.',
        '서울 지역 내 출퇴근 1시간 이내가 좋습니다.',
        '야근은 프로젝트 마감 시 가끔은 감수할 수 있지만 상시적이면 안 됩니다.',
        '데이터 관련 자격증이나 석사 학위 취득도 고려하고 있습니다.',
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
      // 기존 패턴
      { questionPattern: '안정|고용|정규직', answer: '정규직으로 오래 다닐 수 있는 회사를 찾고 있습니다. 정년까지 근무할 수 있으면 좋겠어요.' },
      { questionPattern: '출장|이동|외근', answer: '출장은 전혀 불가능합니다. 가정 사정으로 저녁 7시까지 반드시 퇴근해야 합니다.' },
      // v3.18: 확장 패턴
      { questionPattern: '시간.*모르|몰입|빠져|집중', answer: '서류를 체계적으로 정리하고 프로세스를 개선할 때 보람을 느낍니다. 규칙 안에서 효율을 찾는 것이 좋아요.' },
      { questionPattern: '동기|원동력|에너지|보람', answer: '맡은 일을 실수 없이 끝냈을 때, 팀원들이 의지할 수 있는 사람이 되었을 때 보람을 느낍니다.' },
      { questionPattern: '관계|사람|팀|소통|협업', answer: '팀원들과 안정적인 관계를 유지하며 일하는 것이 좋습니다. 갈등이 많은 환경은 스트레스예요.' },
      { questionPattern: '싫|피하|스트레스|답답', answer: '실적 압박이 심하거나 매일 새로운 일을 해야 하는 환경은 스트레스입니다. 예측 가능한 업무가 좋아요.' },
      { questionPattern: '두렵|불안|걱정|무서', answer: '갑작스러운 해고나 구조조정이 가장 두렵습니다. 고용 불안은 생활 전체를 흔들어요.' },
      { questionPattern: '환경|분위기|조직|문화', answer: '상하 위계가 명확하고 역할이 정해진 안정적인 조직이 좋습니다. 공공기관이나 대기업 같은 환경이요.' },
      { questionPattern: '강점|잘하|능력|역량|자신', answer: '꼼꼼한 서류 처리와 일정 관리가 강점입니다. 체계적으로 업무를 처리하는 능력이 있어요.' },
      { questionPattern: '약점|부족|개선|못하', answer: '급변하는 상황에서 빠른 판단을 내리는 것은 어렵습니다. 충분히 준비할 시간이 필요해요.' },
      { questionPattern: '가치|중요|의미|핵심', answer: '안정성과 워라밸이 가장 중요합니다. 퇴근 후에는 가족과 시간을 보내고 싶어요.' },
      { questionPattern: '현실|제약|조건|연봉|급여', answer: '현재 연봉 수준이면 괜찮습니다. 복리후생이 좋고 정년까지 일할 수 있는 것이 더 중요해요.' },
      { questionPattern: '경험|프로젝트|했던|해본', answer: '행정 사무 보조 업무를 1년 정도 해봤습니다. 문서 관리와 일정 조율을 담당했어요.' },
      { questionPattern: '미래|5년|10년|계획|목표', answer: '한 직장에서 오래 근무하며 안정적인 가정을 꾸리는 것이 목표입니다.' },
      { questionPattern: '실패|어려움|힘들었|좌절', answer: '이전 직장이 갑자기 구조조정을 해서 불안했던 경험이 있습니다. 그래서 안정성이 제일 중요해요.' },
      { questionPattern: '결정|선택|판단|기준', answer: '고용 안정성과 복리후생을 가장 먼저 봅니다. 연봉이 좀 낮아도 안정적인 곳을 선택해요.' },
      { questionPattern: '야근|근무시간|워라밸', answer: '저녁 7시까지 반드시 퇴근해야 합니다. 야근이 잦은 곳은 절대 안 됩니다.' },
      { questionPattern: '성장|커리어|발전', answer: '급격한 성장보다는 꾸준히 경력을 쌓으며 승진하는 것이 좋습니다.' },
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
        '예측 가능한 업무 패턴과 명확한 역할이 있으면 좋겠습니다.',
        '맡은 일을 실수 없이 완성했을 때 성취감을 느낍니다.',
      ],
      round2: [
        '실적 압박이 심하거나 경쟁이 치열한 환경은 맞지 않습니다.',
        '야근이 잦거나 주말 출근이 있는 곳은 절대 안 됩니다.',
        '불확실한 고용 형태나 계약직은 피하고 싶습니다.',
        '갑작스러운 업무 변경이나 예측 불가능한 상황이 많은 곳은 힘듭니다.',
        '상사의 눈치를 보면서 퇴근해야 하는 분위기는 맞지 않습니다.',
      ],
      round3: [
        '현재 연봉 수준이면 괜찮습니다. 안정성이 더 중요합니다.',
        '집에서 대중교통으로 40분 이내 거리가 좋습니다.',
        '정규직만 고려하고 있습니다.',
        '저녁 7시 이전 퇴근은 절대적인 조건입니다.',
        '공공기관이나 공기업 쪽도 적극적으로 알아보고 있습니다.',
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
      internal_conflict_flags: ['autonomy_vs_stability'],
    },

    canValidationAnswers: {
      'can_creative': 'work_experience_1to3',
      'can_analytical': 'project_experience',
    },

    constraintIntensityAnswers: {
      'intensity_time': 'prefer_avoid',
    },

    llmFollowupAnswers: [
      // 기존 패턴
      { questionPattern: '자율|자유|재량', answer: '업무 방식을 스스로 정할 수 있는 게 중요합니다. 기획 방향이나 방법론을 직접 결정하고 싶어요.' },
      { questionPattern: '안정|보장|불안', answer: '하지만 수입이 불안정하면 스트레스 받습니다. 최소 월 300만원은 보장되어야 마음이 편해요.' },
      // v3.18: 확장 패턴
      { questionPattern: '시간.*모르|몰입|빠져|집중', answer: '새로운 아이디어를 구상하고 기획서를 작성할 때 시간 가는 줄 모릅니다. 스타트업에서 서비스 컨셉을 잡던 때가 그랬어요.' },
      { questionPattern: '동기|원동력|에너지|보람', answer: '제 아이디어가 실제 제품으로 구현되는 것을 볼 때 가장 큰 에너지를 얻습니다. 창작의 결과물이 중요해요.' },
      { questionPattern: '관계|사람|팀|소통|협업', answer: '소규모 팀에서 깊이 있게 협업하는 것이 좋습니다. 대규모 조직의 정치는 피하고 싶어요.' },
      { questionPattern: '싫|피하|스트레스|답답', answer: '매일 똑같은 루틴 업무가 가장 스트레스입니다. 그런데 동시에 프리랜서의 불안정한 수입도 싫어요.' },
      { questionPattern: '두렵|불안|걱정|무서', answer: '창의적 자유를 위해 안정성을 포기해야 할까봐 두렵습니다. 둘 다 가질 수는 없는 걸까요.' },
      { questionPattern: '환경|분위기|조직|문화', answer: '자율적이면서도 안정적인 중견기업이나 대기업 내 혁신 부서 같은 환경이 이상적입니다.' },
      { questionPattern: '강점|잘하|능력|역량|자신', answer: '창의적 기획력과 분석적 사고를 겸비한 것이 강점입니다. 스타트업에서 서비스 기획 경험이 있어요.' },
      { questionPattern: '약점|부족|개선|못하', answer: '결정을 내리기 어려워하는 편입니다. 자율과 안정 사이에서 항상 고민하게 돼요.' },
      { questionPattern: '가치|중요|의미|핵심', answer: '자율성과 안정성 모두 중요하지만, 솔직히 둘 중 하나를 골라야 한다면 최소한의 안정성이 먼저예요.' },
      { questionPattern: '현실|제약|조건|연봉|급여', answer: '최소 연봉 4천만원, 주말은 확실히 쉬고 싶습니다. 정규직이면 좋지만 조건 맞으면 계약직도 고려해요.' },
      { questionPattern: '경험|프로젝트|했던|해본', answer: '스타트업에서 2년간 서비스 기획을 했습니다. 자유롭지만 불안정해서 퇴사했고, 지금은 이직 준비 중이에요.' },
      { questionPattern: '미래|5년|10년|계획|목표', answer: '안정적인 조직에서 창의적 일을 하는 UX 기획자나 서비스 디자이너가 되고 싶습니다.' },
      { questionPattern: '실패|어려움|힘들었|좌절', answer: '스타트업이 자금난으로 급여가 밀린 적이 있어요. 그때 안정성의 중요성을 뼈저리게 느꼈습니다.' },
      { questionPattern: '결정|선택|판단|기준', answer: '새로운 기회가 올 때마다 자유 vs 안정 사이에서 갈등합니다. 보통은 최소 안정성이 보장되는 쪽을 택해요.' },
      { questionPattern: '포트폴리오|작품|디자인', answer: '스타트업에서 만든 서비스 기획서와 와이어프레임이 포트폴리오입니다. UX 리서치도 일부 경험이 있어요.' },
      { questionPattern: '분석|데이터|통계', answer: '서비스 기획할 때 사용자 데이터 분석도 했습니다. 정량적 근거로 기획안을 뒷받침하는 걸 좋아해요.' },
      { questionPattern: '야근|근무시간|워라밸', answer: '주말은 확실히 쉬고 싶고, 야근도 주 1-2회 정도까지만 감수할 수 있어요.' },
      { questionPattern: '갈등|충돌|모순|딜레마', answer: '네, 자유롭게 일하고 싶지만 안정적인 수입도 포기 못하는 게 저의 가장 큰 딜레마입니다.' },
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
        '창의적 기획과 분석적 사고를 결합하는 일이 가장 끌립니다.',
        '새로운 서비스나 제품을 구상하는 과정 자체가 즐거워요.',
      ],
      round2: [
        '매번 똑같은 일을 반복하는 건 정말 힘듭니다.',
        '하지만 수입이 들쑥날쑥하면 스트레스를 받습니다.',
        '창의성이 전혀 필요 없는 단순 업무는 피하고 싶습니다.',
        '마감 압박이 극심한 환경은 창의성을 죽이는 것 같아요.',
        '자율과 안정 사이에서 항상 고민이 되지만, 최소한의 안정은 필요합니다.',
      ],
      round3: [
        '최소 연봉 4천만원 이상은 되어야 할 것 같습니다.',
        '정규직이 좋지만, 조건이 맞으면 계약직도 고려할 수 있습니다.',
        '서울 강남권이나 판교 쪽이 출퇴근하기 좋습니다.',
        '주말은 확실히 쉬고 싶고, 주중 야근도 주 1-2회까지만이요.',
        '중견기업 이상 규모에서 안정적으로 창의적 일을 하고 싶습니다.',
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
      internal_conflict_flags: ['autonomy_vs_recognition'],
    },

    canValidationAnswers: {
      'can_creative': 'work_experience_3plus',  // 창의 경험 풍부
      'can_communication': 'work_experience_1to3',
    },

    constraintIntensityAnswers: {},  // 제약 없음

    llmFollowupAnswers: [
      // 기존 패턴
      { questionPattern: '포트폴리오|작품|디자인', answer: '디자인 관련 포트폴리오가 있고, 프리랜서로 브랜딩 프로젝트 5건 이상 진행했습니다.' },
      { questionPattern: '팀|협업|클라이언트', answer: '클라이언트와 직접 소통하며 일하는 것을 선호합니다. 비전을 공유하고 함께 만들어가는 과정이 좋아요.' },
      // v3.18: 확장 패턴
      { questionPattern: '시간.*모르|몰입|빠져|집중', answer: '새로운 비주얼 컨셉을 구상할 때 시간 가는 줄 모릅니다. 밤새 작업해도 피곤하지 않을 때가 있어요.' },
      { questionPattern: '동기|원동력|에너지|보람', answer: '제 디자인이 실제 브랜드로 세상에 나가고, 사람들이 좋아할 때 가장 큰 에너지를 얻습니다.' },
      { questionPattern: '관계|사람|소통', answer: '소규모 크리에이티브 팀에서 아이디어를 주고받는 것이 좋습니다. 대기업 같은 계층적 조직은 답답해요.' },
      { questionPattern: '싫|피하|스트레스|답답', answer: '단순 시안 수정만 반복하는 도구로만 쓰이는 건 정말 싫습니다. 창의적 방향 설정에 참여하고 싶어요.' },
      { questionPattern: '두렵|불안|걱정|무서', answer: '창의성이 고갈되는 것이 가장 두렵습니다. 영감 없이 기계적으로 작업하게 될까봐요.' },
      { questionPattern: '환경|분위기|조직|문화', answer: '자유로운 분위기의 디자인 스튜디오나 에이전시가 이상적입니다. 복장 자유, 유연한 출퇴근이 중요해요.' },
      { questionPattern: '강점|잘하|능력|역량|자신', answer: '브랜드 아이덴티티 디자인과 시각적 스토리텔링이 강점입니다. Adobe Suite, Figma 능숙해요.' },
      { questionPattern: '약점|부족|개선|못하', answer: '마감 관리와 시간 분배가 약점입니다. 완벽주의 성향이 있어서 디테일에 너무 시간을 쓰는 편이에요.' },
      { questionPattern: '가치|중요|의미|핵심', answer: '창의적 자유와 작품에 대한 인정이 가장 중요합니다. 돈보다 의미 있는 작업을 하고 싶어요.' },
      { questionPattern: '현실|제약|조건|연봉|급여', answer: '초봉이 3천만원대라도 성장할 수 있다면 괜찮습니다. 포트폴리오를 쌓을 수 있는 프로젝트가 더 중요해요.' },
      { questionPattern: '경험|프로젝트|했던|해본', answer: '대학교 때 브랜딩 프로젝트로 공모전 수상 경험이 있고, 프리랜서로 중소기업 로고/CI 작업을 5건 했습니다.' },
      { questionPattern: '미래|5년|10년|계획|목표', answer: '아트 디렉터로 성장해서 브랜드의 시각적 방향을 결정하는 사람이 되고 싶습니다. 해외 에이전시도 도전해보고 싶어요.' },
      { questionPattern: '실패|어려움|힘들었|좌절', answer: '클라이언트가 제 디자인 방향을 완전히 뒤엎고 자기 취향대로 수정을 요구했을 때 좌절감을 느꼈어요.' },
      { questionPattern: '결정|선택|판단|기준', answer: '프로젝트의 창의적 자유도와 결과물의 퀄리티를 가장 먼저 봅니다. 돈보다 작품 가치를 우선해요.' },
      { questionPattern: '분석|데이터|통계', answer: '디자인 트렌드 분석은 좋아하지만, 숫자 위주의 데이터 분석은 제 적성이 아닌 것 같아요.' },
      { questionPattern: '성장|커리어|발전', answer: '다양한 브랜드와 프로젝트를 경험하면서 시각 언어를 넓혀가고 싶습니다.' },
      { questionPattern: '인정|평가|피드백|칭찬', answer: '제 디자인을 보고 클라이언트가 감탄할 때, 수상을 할 때 가장 행복합니다.' },
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
        internalConflictRisk: true,
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
        '시각적으로 아름다운 것을 만들어내는 과정 자체가 행복합니다.',
        '제 작품이 세상에 나가서 누군가에게 영감을 주는 것이 꿈이에요.',
      ],
      round2: [
        "단순 작업만 반복하는 '손'으로만 쓰이는 건 싫습니다.",
        '클라이언트가 창의성을 존중하지 않는 프로젝트는 힘듭니다.',
        '템플릿만 수정하는 일은 하고 싶지 않습니다.',
        '관료적인 조직에서 결재만 기다리는 환경은 답답합니다.',
        '숫자나 규칙에만 얽매인 업무는 창의성을 죽이는 것 같아요.',
      ],
      round3: [
        '첫 연봉은 3천만원대도 괜찮습니다. 배울 수 있다면요.',
        '서울 홍대나 성수동 쪽 에이전시가 좋을 것 같습니다.',
        '포트폴리오를 쌓을 수 있는 프로젝트가 많았으면 좋겠습니다.',
        '야근은 열정적인 프로젝트라면 기꺼이 감수할 수 있습니다.',
        '해외 교류나 글로벌 프로젝트 기회가 있으면 최고입니다.',
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
      // 기존 패턴
      { questionPattern: '경험|경력|이력', answer: '관련 경험은 없지만 온라인 강의와 부트캠프로 6개월 공부했습니다. 개인 프로젝트도 진행 중이에요.' },
      { questionPattern: '전환|커리어체인지|신입', answer: '다른 분야(유통업)에서 커리어 전환을 준비하고 있습니다. 데이터 분석에 확신이 있어요.' },
      // v3.18: 확장 패턴
      { questionPattern: '시간.*모르|몰입|빠져|집중', answer: '코딩 문제를 풀거나 데이터셋을 탐색할 때 시간 가는 줄 모릅니다. 부트캠프 과제를 밤새 했던 적도 있어요.' },
      { questionPattern: '동기|원동력|에너지|보람', answer: '새로운 것을 배우고 실력이 느는 게 느껴질 때 가장 동기부여가 됩니다. 어제보다 나아진 느낌이 중요해요.' },
      { questionPattern: '관계|사람|팀|소통|협업', answer: '멘토가 있는 환경에서 배우고 싶습니다. 팀원들과 함께 성장하는 분위기가 좋아요.' },
      { questionPattern: '싫|피하|스트레스|답답', answer: '배움 없이 시간만 보내는 환경이 가장 스트레스입니다. 성장 기회 없는 단순 보조 업무는 피하고 싶어요.' },
      { questionPattern: '두렵|불안|걱정|무서', answer: '경험이 부족해서 취업이 안 될까봐 가장 걱정됩니다. 하지만 열심히 하면 기회가 올 거라고 믿어요.' },
      { questionPattern: '환경|분위기|조직|문화', answer: '교육 프로그램이 잘 갖춰진 기업이 좋겠습니다. 신입을 체계적으로 키워주는 곳이면 최고예요.' },
      { questionPattern: '강점|잘하|능력|역량|자신', answer: '빠른 학습 속도와 끈기가 강점입니다. 부트캠프에서 상위 10% 성적으로 수료했어요.' },
      { questionPattern: '약점|부족|개선|못하', answer: '실무 경험이 전혀 없는 것이 가장 큰 약점입니다. 이론은 알지만 실전 적용 경험이 부족해요.' },
      { questionPattern: '가치|중요|의미|핵심', answer: '성장과 전문성이 가장 중요합니다. 3년 뒤에는 독립적으로 분석할 수 있는 실력을 갖추고 싶어요.' },
      { questionPattern: '현실|제약|조건|연봉|급여', answer: '신입이라 연봉은 크게 기대하지 않습니다. 인턴이나 계약직으로 시작해도 배울 수 있다면 괜찮아요.' },
      { questionPattern: '분석|데이터|통계', answer: '부트캠프에서 Python, SQL, 기초 통계를 배웠습니다. Kaggle 프로젝트도 3개 완료했어요.' },
      { questionPattern: '미래|5년|10년|계획|목표', answer: '3년 안에 주니어 데이터 분석가로 독립적 업무가 가능해지고, 5년 뒤엔 머신러닝까지 다루고 싶습니다.' },
      { questionPattern: '실패|어려움|힘들었|좌절', answer: '부트캠프 중간에 어려운 과제에 막혀서 포기하고 싶었지만, 끝까지 해냈습니다. 그 경험이 자신감을 줬어요.' },
      { questionPattern: '결정|선택|판단|기준', answer: '배울 수 있는 환경인지가 가장 중요한 기준입니다. 연봉보다 멘토링과 교육 체계를 먼저 봐요.' },
      { questionPattern: '야근|근무시간|워라밸', answer: '신입이니까 야근도 감수할 수 있습니다. 실력을 키우는 시기라고 생각해요.' },
      { questionPattern: '성장|커리어|발전', answer: '빠르게 실무 역량을 쌓아서 회사에 기여할 수 있는 사람이 되고 싶습니다.' },
      { questionPattern: '포트폴리오|작품', answer: 'Kaggle 프로젝트 3개와 부트캠프 최종 프로젝트(고객 이탈 예측 모델)가 포트폴리오입니다.' },
    ],

    expectedResults: {
      topJobCategories: ['데이터', '분석', '개발', 'IT', '주니어'],
      excludedJobCategories: ['전문의', '변호사', '임원'],
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
        '새로운 것을 배우는 과정 자체가 저에게 동기부여가 됩니다.',
        '실력을 인정받아서 회사에 필요한 사람이 되고 싶어요.',
      ],
      round2: [
        '배움 없이 시간만 보내는 환경은 피하고 싶습니다.',
        '성장 기회 없는 단순 보조 업무만 하는 건 맞지 않습니다.',
        '피드백 없이 혼자 방치되는 건 힘들 것 같습니다.',
        '경험 부족을 이유로 기회조차 주지 않는 곳은 답답할 것 같아요.',
        '의미 없는 잡일만 시키는 환경은 피하고 싶습니다.',
      ],
      round3: [
        '신입 평균 수준이면 감사합니다. 연봉보다 경험이 중요합니다.',
        '출퇴근 거리는 1시간 반까지 괜찮습니다.',
        '인턴이나 계약직으로 시작해도 괜찮습니다.',
        '교육 프로그램이나 멘토링 제도가 있는 곳이면 좋겠습니다.',
        '야근도 감수할 수 있습니다. 지금은 실력을 키우는 시기라고 생각해요.',
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
      internal_conflict_flags: ['growth_vs_income'],
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
      // 기존 패턴
      { questionPattern: '기술|개발|프로그래밍', answer: '프론트엔드 개발 경험 2년, React/TypeScript 주력입니다. 백엔드(Node.js)도 배우고 있어요.' },
      { questionPattern: '영어|외국어|언어', answer: '비즈니스 영어 가능하고, 해외 클라이언트와 화상회의 경험이 있습니다. 해외 거주 1년 경험도 있어요.' },
      { questionPattern: '원격|재택|리모트', answer: '하이브리드도 괜찮지만 주 3일 이상 재택을 선호합니다. 집중이 필요한 개발 작업은 재택이 효율적이에요.' },
      // v3.18: 확장 패턴
      { questionPattern: '시간.*모르|몰입|빠져|집중', answer: '어려운 기술적 문제를 해결할 때 시간 가는 줄 모릅니다. 복잡한 버그를 추적해서 해결했을 때 쾌감이 있어요.' },
      { questionPattern: '동기|원동력|에너지|보람', answer: '기술로 실제 사용자 문제를 해결할 때 가장 보람을 느낍니다. 코드가 서비스가 되는 과정이 좋아요.' },
      { questionPattern: '관계|사람|팀|소통|협업', answer: '소규모 개발 팀에서 코드 리뷰하며 함께 성장하는 환경이 좋습니다. 디자이너/기획자와 협업도 즐겨요.' },
      { questionPattern: '싫|피하|스트레스|답답', answer: '레거시 코드만 유지보수하는 건 지치게 합니다. 기술 결정에 참여 못하고 시키는 대로만 하는 것도 싫어요.' },
      { questionPattern: '두렵|불안|걱정|무서', answer: '기술 트렌드에 뒤처지는 것이 가장 걱정됩니다. 새로운 기술을 계속 배울 수 있어야 해요.' },
      { questionPattern: '환경|분위기|조직|문화', answer: '기술 스택 선택의 자율성이 있고, 코드 리뷰 문화가 있는 팀이 좋습니다. 스타트업이나 테크 기업 분위기가 맞아요.' },
      { questionPattern: '강점|잘하|능력|역량|자신', answer: '프론트엔드 개발과 UI/UX 감각이 강점입니다. 기술과 디자인 양쪽을 이해해서 소통이 잘 돼요.' },
      { questionPattern: '약점|부족|개선|못하', answer: '백엔드와 인프라 쪽은 아직 부족합니다. 풀스택으로 성장하려면 더 경험이 필요해요.' },
      { questionPattern: '가치|중요|의미|핵심', answer: '기술적 성장과 자율성이 가장 중요합니다. 의미 있는 제품을 만들면서 실력도 키우고 싶어요.' },
      { questionPattern: '현실|제약|조건|연봉|급여', answer: '현재 연봉에서 15-20% 인상을 기대합니다. 판교나 강남권 IT 기업을 선호해요.' },
      { questionPattern: '경험|프로젝트|했던|해본', answer: 'React 기반 SaaS 제품 프론트엔드를 2년간 담당했습니다. 자격증으로 정보처리기사가 있어요.' },
      { questionPattern: '미래|5년|10년|계획|목표', answer: '풀스택 개발자로 성장하면서 3-5년 후에는 테크 리드 역할을 맡고 싶습니다.' },
      { questionPattern: '실패|어려움|힘들었|좌절', answer: '프로젝트 마감에 쫓겨서 기술 부채를 쌓은 적이 있어요. 나중에 그 코드를 다시 작업할 때 힘들었습니다.' },
      { questionPattern: '결정|선택|판단|기준', answer: '기술 성장 가능성과 팀 문화를 가장 먼저 봅니다. 좋은 동료와 배울 점이 많은 환경이 중요해요.' },
      { questionPattern: '야근|근무시간|워라밸', answer: '야근이 가끔은 괜찮지만 상시적이면 힘듭니다. 일정 관리가 잘 되는 조직이 좋아요.' },
      { questionPattern: '성장|커리어|발전', answer: '기술 컨퍼런스나 교육비 지원이 있으면 좋겠습니다. 계속 배울 수 있는 환경이 핵심이에요.' },
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
        internalConflictRisk: true,
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
        '코드가 실제 서비스가 되어 사용자에게 닿는 과정이 가장 좋습니다.',
        '기술과 비즈니스를 연결하는 역할에 관심이 많아요.',
      ],
      round2: [
        '레거시 코드만 유지보수하는 건 지치게 합니다.',
        '기술 결정에 전혀 참여하지 못하는 환경은 답답합니다.',
        '비효율적인 프로세스나 불필요한 회의가 많은 곳은 맞지 않습니다.',
        '관료적인 문화에서 결재만 기다리는 환경은 맞지 않아요.',
        '기술 트렌드를 따라가지 못하고 정체되는 것이 가장 두렵습니다.',
      ],
      round3: [
        '현재 연봉에서 15-20% 정도 인상을 기대합니다.',
        '하이브리드 근무가 가능해야 합니다. 주 2일 출근 정도가 이상적입니다.',
        '판교나 강남권 스타트업/IT 기업을 선호합니다.',
        '기술 컨퍼런스 참가비나 교육비 지원이 있으면 좋겠습니다.',
        '코드 리뷰 문화가 잘 갖춰진 팀에서 일하고 싶습니다.',
      ],
    },
  },

  // ============================================
  // 시나리오 7: 사회공헌형 유저 (Social Impact)
  // ============================================
  {
    id: 'social_impact',
    name: '사회공헌형 유저',
    description: '사회 기여와 교육에 관심 있는 이타적 유저',
    category: 'basic',

    miniModule: {
      interest_top: ['helping_others', 'education', 'social_contribution'],
      value_top: ['meaning', 'stability', 'social_impact'],
      strength_top: ['communication', 'persistence', 'structured_execution'],
      constraint_flags: ['prefer_wlb'],
      workstyle_top: ['team_harmony', 'structured'],
      background_flags: ['volunteer_experience'],
      language_skills: [] as Array<{ language: string; level: 'basic' | 'business' | 'native' }>,
      sacrifice_flags: ['low_initial_income'],
      energy_drain_flags: ['routine_drain'],
      achievement_feedback_top: ['social_impact', 'recognition'],
      execution_style: 'planner',
      impact_scope: 'wide_impact',
      failure_response: 'seek_support',
      persistence_anchor: 'meaning_anchor',
      external_expectation: 'consider_carefully',
    },

    canValidationAnswers: {
      'can_communication': 'work_experience_1to3',
      'can_structured_execution': 'project_experience',
    },

    constraintIntensityAnswers: {
      'intensity_wlb': 'prefer_avoid',
    },

    llmFollowupAnswers: [
      { questionPattern: '교육|가르치|학생|학교', answer: '대학에서 교육봉사 2년 했습니다. 학생들이 이해하는 순간을 볼 때 가장 보람 있었어요.' },
      { questionPattern: '사회|봉사|기여|공헌|NPO|NGO', answer: 'NGO에서 인턴 경험이 있고, 사회 문제를 해결하는 일에 관심이 많습니다. 환경이나 교육 분야에서 기여하고 싶어요.' },
      { questionPattern: '동기|원동력|에너지|보람', answer: '다른 사람에게 도움이 될 때 가장 큰 보람을 느낍니다. 사회에 의미 있는 변화를 만들고 싶어요.' },
      { questionPattern: '관계|사람|팀|소통|협업', answer: '다양한 배경의 사람들과 협업하는 것을 좋아합니다. 소통하고 함께 문제를 풀어가는 과정이 좋아요.' },
      { questionPattern: '싫|피하|스트레스|답답', answer: '이윤만 추구하고 사회적 가치를 무시하는 조직은 맞지 않습니다. 의미 없는 업무에 시간 쓰는 것이 가장 스트레스예요.' },
      { questionPattern: '환경|분위기|조직|문화', answer: '가치관이 비슷한 동료들과 미션 중심으로 일하는 조직이 좋습니다. 수평적이고 협력적인 문화를 선호해요.' },
      { questionPattern: '강점|잘하|능력|역량|자신', answer: '공감 능력과 소통 능력이 강점입니다. 프레젠테이션이나 글쓰기도 잘하는 편이에요.' },
      { questionPattern: '약점|부족|개선|못하', answer: '숫자나 데이터 분석은 약합니다. 재무적인 부분은 아직 배워야 할 게 많아요.' },
      { questionPattern: '가치|중요|의미|핵심', answer: '일의 사회적 의미가 가장 중요합니다. 돈보다는 보람과 기여감을 우선시해요.' },
      { questionPattern: '현실|제약|조건|연봉|급여', answer: '연봉이 높지 않아도 괜찮지만 최소 3000만원은 필요합니다. 워라밸이 보장되어야 해요.' },
      { questionPattern: '시간.*모르|몰입|빠져|집중', answer: '교육 프로그램을 기획하거나 사람들과 워크숍을 진행할 때 시간 가는 줄 몰라요.' },
      { questionPattern: '미래|5년|10년|계획|목표', answer: '5년 후에는 사회적 기업이나 교육 기관에서 프로그램 디렉터가 되고 싶습니다.' },
      { questionPattern: '성장|커리어|발전', answer: '사회복지사 자격증을 준비하고 있고, 교육학 석사도 고려 중입니다.' },
      { questionPattern: '야근|근무시간|워라밸', answer: '규칙적인 근무시간이 중요합니다. 저녁에는 개인 봉사활동 시간을 갖고 싶어요.' },
      { questionPattern: '경험|프로젝트|했던|해본', answer: '대학 교육봉사 2년, NGO 인턴 6개월, 지역사회 환경 캠페인 기획 경험이 있습니다.' },
    ],

    expectedResults: {
      topJobCategories: ['교육', '사회복지', 'NGO', '공공'],
      excludedJobCategories: ['현장직', '금융투자', '영업'],
      fitScoreRange: { min: 55, max: 90 },
      balanceCheck: { canShouldNotDominateLike: true, likeCanGap: { max: 30 } },
      featuresApplied: { growthCurveMatching: true, internalConflictRisk: false, canBasedFilter: true, balanceCap: true },
    },

    careerState: 'job_seeker',
    narrativeAnswers: {
      motivation: '사회에 기여하고 사람들을 돕는 일을 하고 싶습니다. 교육이나 복지 분야에서 의미 있는 변화를 만들 수 있는 직업을 찾고 있어요.',
      avoidance: '이윤만 추구하는 기업이나 사회적 가치가 없는 일은 피하고 싶습니다. 경쟁적이고 개인주의적인 환경도 맞지 않아요.',
      constraints: '연봉이 높지 않아도 괜찮지만 기본 생활은 가능해야 합니다. 워라밸이 보장되는 환경이 중요합니다.',
    },
    roundFallbackAnswers: {
      round1: ['사람들에게 도움이 되는 일을 할 때 가장 행복합니다.', '교육봉사 경험이 진로를 결정하는 데 큰 영향을 줬어요.', '사회 문제 해결에 관심이 많습니다.', '공감 능력과 소통이 제 강점이에요.', '비영리 단체에서의 경험이 가장 기억에 남아요.'],
      round2: ['돈만 추구하는 조직은 동기부여가 안 됩니다.', '의미 없는 서류 작업만 하는 건 힘들어요.', '사람과의 관계에서 에너지를 얻는 편입니다.', '경쟁적인 환경보다 협력적인 환경이 맞아요.', '가치관이 맞지 않는 조직은 오래 다닐 수 없을 것 같아요.'],
      round3: ['연봉 3000만원 이상이면 괜찮습니다.', '정시 퇴근이 가능한 직장을 원합니다.', '사회복지사 자격증을 따려고 준비 중입니다.', '수도권 내 출퇴근 가능한 곳을 찾고 있어요.', '봉사활동과 병행할 수 있는 근무 형태가 좋겠어요.'],
    },
  },

  // ============================================
  // 시나리오 8: 예술/창작 지향 유저 (Artistic)
  // ============================================
  {
    id: 'artistic_user',
    name: '예술/창작 유저',
    description: '글쓰기, 영상, 예술 분야에 관심 있는 유저',
    category: 'basic',

    miniModule: {
      interest_top: ['creative', 'art_design', 'media_content'],
      value_top: ['autonomy', 'meaning', 'creativity'],
      strength_top: ['creative', 'communication', 'persistence'],
      constraint_flags: ['remote_preferred'],
      workstyle_top: ['solo_deep', 'flexible'],
      background_flags: ['portfolio'],
      language_skills: [] as Array<{ language: string; level: 'basic' | 'business' | 'native' }>,
      sacrifice_flags: ['low_initial_income', 'unstable_hours'],
      energy_drain_flags: ['routine_drain', 'bureaucracy_drain'],
      achievement_feedback_top: ['mastery', 'audience_response'],
      execution_style: 'improviser',
      impact_scope: 'wide_impact',
      failure_response: 'creative_pivot',
      persistence_anchor: 'passion_anchor',
      external_expectation: 'independent_path',
    },

    canValidationAnswers: {
      'can_creative': 'portfolio_available',
      'can_communication': 'project_experience',
    },

    constraintIntensityAnswers: {
      'intensity_remote': 'must_have',
    },

    llmFollowupAnswers: [
      { questionPattern: '글쓰기|작가|소설|시나리오|콘텐츠', answer: '단편소설과 에세이를 써왔고, 블로그에 연재도 했습니다. 스토리텔링이 제 핵심 역량이에요.' },
      { questionPattern: '영상|유튜브|미디어|촬영|편집', answer: '1인 미디어로 유튜브 채널을 운영한 경험이 있어요. 촬영, 편집, 기획까지 혼자 했습니다.' },
      { questionPattern: '동기|원동력|에너지|보람', answer: '제 작품이 누군가에게 감동을 줄 때 가장 큰 보람을 느낍니다. 창작 과정 자체가 에너지를 줘요.' },
      { questionPattern: '관계|사람|팀|소통|협업', answer: '혼자 작업하는 시간이 절대적으로 필요합니다. 하지만 좋은 피드백을 주는 소수의 동료는 소중해요.' },
      { questionPattern: '싫|피하|스트레스|답답', answer: '정해진 틀 안에서만 일하는 건 질식할 것 같아요. 창의성이 필요 없는 반복 업무가 가장 싫습니다.' },
      { questionPattern: '환경|분위기|조직|문화', answer: '카페나 작업실 같은 자유로운 공간에서 일하고 싶어요. 재택 근무가 필수입니다.' },
      { questionPattern: '강점|잘하|능력|역량|자신', answer: '글쓰기와 스토리텔링이 최대 강점입니다. 영상 편집과 디자인도 독학으로 배웠어요.' },
      { questionPattern: '약점|부족|개선|못하', answer: '규칙적인 생활이 어렵고, 마감 압박에 약한 편이에요. 행정적인 업무는 정말 못합니다.' },
      { questionPattern: '가치|중요|의미|핵심', answer: '자유롭게 표현할 수 있는 환경이 가장 중요합니다. 돈보다 하고 싶은 일을 하는 게 우선이에요.' },
      { questionPattern: '현실|제약|조건|연봉|급여', answer: '초기 수입이 적어도 감수할 수 있습니다. 대신 시간적 자유가 필요해요.' },
      { questionPattern: '시간.*모르|몰입|빠져|집중', answer: '글을 쓰거나 영상 편집할 때 밤새도록 시간 가는 줄 모릅니다.' },
      { questionPattern: '미래|5년|10년|계획|목표', answer: '5년 내 출판 작가 또는 콘텐츠 크리에이터로 자리잡고 싶습니다.' },
      { questionPattern: '경험|프로젝트|했던|해본', answer: '단편소설 공모전 입상, 유튜브 채널 구독자 3천명, 프리랜서 카피라이팅 경험이 있어요.' },
      { questionPattern: '성장|커리어|발전', answer: '창작 워크숍이나 마스터클래스에 참여하면서 계속 역량을 키우고 싶어요.' },
      { questionPattern: '야근|근무시간|워라밸', answer: '근무시간보다 결과물로 평가받고 싶어요. 새벽에 작업해도 낮에 쉴 수 있으면 좋겠습니다.' },
    ],

    expectedResults: {
      topJobCategories: ['작가', '콘텐츠', '크리에이터', '편집', '기획'],
      excludedJobCategories: ['공장', '현장직', '회계', '금융'],
      fitScoreRange: { min: 55, max: 90 },
      balanceCheck: { canShouldNotDominateLike: true, likeCanGap: { max: 30 } },
      featuresApplied: { growthCurveMatching: true, internalConflictRisk: false, canBasedFilter: true, balanceCap: true },
    },

    careerState: 'freelancer',
    narrativeAnswers: {
      motivation: '글쓰기와 영상 제작이 제 삶의 중심입니다. 스토리텔링을 통해 사람들에게 감동과 영감을 주고 싶습니다. 창작으로 먹고살 수 있는 직업을 찾고 있어요.',
      avoidance: '정해진 틀 안에서 반복적으로 일하는 건 정말 싫습니다. 창의성이 필요 없는 업무나 관료적인 조직은 피하고 싶어요.',
      constraints: '초기 수입이 적어도 감수할 수 있지만, 시간적 자유는 반드시 필요합니다. 재택이나 자유 근무가 가능해야 합니다.',
    },
    roundFallbackAnswers: {
      round1: ['글쓰기가 제 정체성의 핵심입니다.', '영상 편집과 촬영도 독학으로 배웠어요.', '창작물이 사람들에게 감동을 줄 때 가장 행복합니다.', '자유로운 환경에서 일할 때 최고의 결과물이 나와요.', '스토리텔링 능력이 제 최대 강점입니다.'],
      round2: ['반복 업무는 창의성을 죽입니다.', '관료적인 조직은 절대 맞지 않아요.', '마감에 쫓기는 건 힘들지만 감수할 수 있어요.', '사무실에 9시 출근하는 생활은 어렵습니다.', '누군가 지시하는 대로만 하는 건 참기 어려워요.'],
      round3: ['프리랜서 형태로 일할 수 있으면 가장 좋겠습니다.', '초기 수입 2000만원대도 감수 가능합니다.', '카페나 공유오피스에서 자유롭게 작업하고 싶어요.', '포트폴리오를 계속 쌓아가면서 성장하고 싶습니다.', '글쓰기 관련 교육이나 멘토링을 받고 싶어요.'],
    },
  },

  // ============================================
  // 시나리오 9: 창업/비즈니스 유저 (Entrepreneurial)
  // ============================================
  {
    id: 'entrepreneurial',
    name: '창업/비즈니스 유저',
    description: '사업을 시작하거나 경영에 관심 있는 유저',
    category: 'basic',

    miniModule: {
      interest_top: ['business_management', 'leadership', 'innovation'],
      value_top: ['income', 'autonomy', 'growth'],
      strength_top: ['communication', 'fast_learning', 'creative'],
      constraint_flags: [] as string[],
      workstyle_top: ['flexible', 'team_harmony'],
      background_flags: ['startup_experience'],
      language_skills: [{ language: 'english', level: 'business' }],
      sacrifice_flags: ['unstable_hours', 'high_stress'],
      energy_drain_flags: ['bureaucracy_drain'],
      achievement_feedback_top: ['autonomy', 'financial_success'],
      execution_style: 'improviser',
      impact_scope: 'wide_impact',
      failure_response: 'pivot_quickly',
      persistence_anchor: 'vision_anchor',
      external_expectation: 'independent_path',
    },

    canValidationAnswers: {
      'can_communication': 'work_experience_3plus',
      'can_fast_learning': 'work_experience_1to3',
    },

    constraintIntensityAnswers: {},

    llmFollowupAnswers: [
      { questionPattern: '사업|창업|스타트업|대표', answer: '작은 온라인 쇼핑몰을 6개월 운영해본 경험이 있습니다. 마케팅부터 물류까지 혼자 했어요.' },
      { questionPattern: '리더십|팀빌딩|경영|관리', answer: '이전 직장에서 5명 규모 팀을 리드한 경험이 있습니다. 사람들의 강점을 파악해서 배치하는 걸 잘해요.' },
      { questionPattern: '동기|원동력|에너지|보람', answer: '내 사업을 키워가는 과정이 가장 흥미진진합니다. 내가 만든 것이 시장에서 인정받을 때 최고로 보람차요.' },
      { questionPattern: '관계|사람|팀|소통|협업', answer: '투자자, 파트너, 고객 등 다양한 이해관계자와 소통하는 것을 즐깁니다. 네트워킹이 사업의 핵심이라고 생각해요.' },
      { questionPattern: '싫|피하|스트레스|답답', answer: '남의 밑에서 지시만 받는 건 답답합니다. 느린 의사결정과 관료주의가 가장 스트레스예요.' },
      { questionPattern: '환경|분위기|조직|문화', answer: '빠르게 움직이고 실험하는 스타트업 문화가 맞아요. 내가 의사결정권을 갖는 환경이 필요합니다.' },
      { questionPattern: '강점|잘하|능력|역량|자신', answer: '설득력 있는 프레젠테이션과 빠른 학습이 강점이에요. 새로운 분야를 빠르게 파악하는 능력이 있어요.' },
      { questionPattern: '약점|부족|개선|못하', answer: '재무 관리와 회계는 약합니다. 디테일한 실행보다 큰 그림을 그리는 편이라 꼼꼼함이 부족해요.' },
      { questionPattern: '가치|중요|의미|핵심', answer: '자율성과 경제적 자유가 가장 중요합니다. 내가 만든 비즈니스로 성공하고 싶어요.' },
      { questionPattern: '현실|제약|조건|연봉|급여', answer: '초기에는 수입이 불안정해도 괜찮습니다. 3-5년 내 사업으로 연 1억 이상을 목표로 하고 있어요.' },
      { questionPattern: '시간.*모르|몰입|빠져|집중', answer: '사업 아이디어를 구체화하거나 사업계획서를 쓸 때 밤새 몰입합니다.' },
      { questionPattern: '미래|5년|10년|계획|목표', answer: '3년 내 자기 사업을 안정화시키고, 5년 후에는 직원 10명 이상의 회사를 만들고 싶습니다.' },
      { questionPattern: '경험|프로젝트|했던|해본', answer: '온라인 쇼핑몰 운영 6개월, 이전 직장 팀리드 2년, 각종 사이드 프로젝트 경험이 있어요.' },
      { questionPattern: '성장|커리어|발전', answer: 'MBA나 경영 관련 프로그램을 수강하면서 체계적인 경영 역량을 키우고 싶습니다.' },
      { questionPattern: '야근|근무시간|워라밸', answer: '사업을 위해서라면 야근이나 주말 근무도 기꺼이 할 수 있습니다. 내 일이니까요.' },
    ],

    expectedResults: {
      topJobCategories: ['경영', '창업', '컨설턴트', '마케팅', '기획'],
      excludedJobCategories: ['공장', '현장직', '단순사무'],
      fitScoreRange: { min: 55, max: 90 },
      balanceCheck: { canShouldNotDominateLike: true, likeCanGap: { max: 30 } },
      featuresApplied: { growthCurveMatching: true, internalConflictRisk: false, canBasedFilter: true, balanceCap: true },
    },

    careerState: 'employed',
    narrativeAnswers: {
      motivation: '내 사업을 만들어서 성공하고 싶습니다. 리더십과 사업 아이디어가 있고, 시장에서 인정받는 제품이나 서비스를 만드는 것이 목표입니다.',
      avoidance: '남의 밑에서 지시만 받는 환경은 답답합니다. 관료적이고 느린 조직, 창의성 없는 반복 업무는 피하고 싶어요.',
      constraints: '사업을 위해서 야근이나 불안정한 수입도 감수할 수 있습니다. 대신 의사결정 자율성은 반드시 필요합니다.',
    },
    roundFallbackAnswers: {
      round1: ['사업을 운영하면서 성장하는 것이 꿈입니다.', '온라인 쇼핑몰을 직접 운영해본 경험이 있어요.', '사람들의 문제를 해결하는 비즈니스를 만들고 싶습니다.', '리더십과 네트워킹이 제 강점이에요.', '새로운 시장 기회를 찾는 것에 흥미를 느낍니다.'],
      round2: ['관료적인 조직에서는 오래 못 버텨요.', '의사결정권이 없는 자리는 답답합니다.', '지시만 받는 업무는 동기부여가 안 돼요.', '느린 변화와 비효율이 가장 스트레스입니다.', '안정적이지만 성장이 없는 건 감옥 같아요.'],
      round3: ['초기에 수입이 적어도 3-5년 후를 보고 투자할 수 있어요.', '야근이든 주말 근무든 내 사업을 위해서라면 기꺼이 합니다.', 'MBA 프로그램을 수강하면서 역량을 키우고 싶어요.', '수도권에서 사업을 시작할 계획입니다.', '공유오피스에서 시작해서 점점 키워가고 싶어요.'],
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
