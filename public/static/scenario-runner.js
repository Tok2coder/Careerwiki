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
      existential: '뉴스를 보는 순간 가장 먼저 노트북을 열 것 같아요. 회사에서 풀다 만 그 데이터셋이 떠오릅니다. 아무도 못 찾은 패턴이 분명 있는데, 시간에 쫓겨 포기했거든요. 마지막이니까 그걸 끝까지 파보고 싶습니다. 그리고 저녁에는 부모님 댁에 가서 제가 발견한 걸 설명해드리고 싶어요. 아마 이해 못 하시겠지만 그래도 제가 뭘 좋아했는지는 아시면 좋겠습니다. 왜냐하면 결국 저는 복잡한 걸 이해하는 순간이 가장 살아있다고 느끼는 사람이고, 그걸 나눌 사람이 있다는 게 감사하니까요.',
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
      existential: '그 뉴스를 듣는 순간 바로 집으로 달려갈 것 같아요. 아이들을 안고 아내한테 "우리 내일부터 매일 같이 아침밥 먹자"라고 말할 것 같습니다. 그리고 부모님 댁에 가서 어릴 때 자주 갔던 바닷가에 가족 모두 함께 가고 싶어요. 특별한 게 아니라 그냥 같이 걷고, 밥 먹고, 이야기하는 거요. 왜 이게 먼저 떠올랐냐면, 결국 저한테 가장 중요한 건 화려한 성취가 아니라 매일 저녁 식탁에 둘러앉는 그 시간이었던 것 같거든요.',
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
      existential: '솔직히 두 가지가 동시에 떠올라서 혼란스럽습니다. 먼저 작업실로 가서 아무 제약 없이 진짜 만들고 싶었던 걸 만들고 싶어요. 클라이언트 눈치 안 보고, 수익 걱정 없이, 순수하게 제 감각대로. 근데 밤이 되면 결국 사람들한테 갈 것 같아요. 가까운 사람들이랑 조용한 곳에서 와인 마시면서 밤새 이야기하고 싶습니다. 왜 이게 먼저 떠올랐냐면, 평소에 제가 창작과 안정 사이에서 계속 갈등하는데 결국 둘 다 포기 못 하는 사람이라는 걸 알겠어서요.',
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
      existential: '뉴스 보자마자 화방으로 달려갈 것 같아요. 가장 큰 캔버스를 사서 거리 한복판에 놓고 그림을 그리고 싶습니다. 평소에는 클라이언트 취향에 맞춰야 했는데, 마지막이니까 진짜 내가 그리고 싶은 걸 그리고 싶어요. 지나가는 사람들이 잠깐이라도 멈춰서 보면 좋겠고, 그 중 누군가 "이거 뭐예요?"라고 물어보면 같이 그리자고 하고 싶어요. 밤에는 친한 사람들이랑 옥상에서 별 보면서 인생 이야기 나누고 싶습니다. 왜 이게 먼저냐면, 결국 저한테 가장 중요한 건 "만든 것이 누군가에게 닿는 순간"이라는 걸 알겠어서요.',
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
      existential: '뉴스 보면 아마 한동안 멍하게 앉아있을 것 같아요. 그리고 나서 가장 먼저 할 건 서점에 가는 거예요. 항상 사고 싶었는데 "지금은 바쁘니까 나중에"라고 미뤘던 천문학 책이랑 피아노 교본을 살 것 같습니다. 시간이 7일밖에 없지만 그래도 처음부터 끝까지 뭔가를 배워보는 경험을 하고 싶어요. 그리고 부트캠프에서 함께 공부했던 사람들을 만나서 "우리 마지막으로 해커톤 하나 하자"고 하고 싶습니다. 왜냐하면 경험은 없지만 뭔가를 배우는 과정 자체가 저한테는 가장 살아있는 시간이었거든요.',
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
      existential: '뉴스를 듣자마자 바로 에디터를 열 것 같아요. 2년 전부터 기획만 해놓고 못 만들었던 앱이 있거든요. 기술적으로 도전적이면서 실제로 사람들 도움이 되는 서비스인데, 마지막 7일이면 MVP는 만들 수 있을 것 같습니다. 낮에는 카페에서 코딩하고, 저녁에는 오래된 친구들을 불러서 맥주 마시면서 "이거 한번 써봐"라고 보여주고 싶어요. 밤에는 음악 들으면서 한강 산책하고요. 왜 이게 먼저냐면, 결국 제가 가장 후회할 건 "만들 수 있었는데 안 만든 것"이랑 "만날 수 있었는데 안 만난 사람들"이니까요.',
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
// 전공 시나리오 데이터
// ============================================

const MAJOR_SCENARIOS = {
  major_stem_student: {
    id: 'major_stem_student',
    name: 'STEM 지향 학생',
    type: 'major',
    careerState: 'student',
    stage: 'major_high',
    academicState: 'high_school_regular',
    miniModule: {
      interest_top: ['data_numbers', 'problem_solving'],
      value_top: ['growth', 'income'],
      strength_top: ['analytical', 'fast_learning'],
      constraint_flags: [],
      workstyle_top: ['solo', 'structured'],
      background_flags: [],
      language_skills: [{ language: 'english', level: 'business' }],
      sacrifice_flags: ['low_initial_income', 'willing_to_study'],
      energy_drain_flags: ['people_drain'],
      achievement_feedback_top: ['metric_feedback', 'problem_solved_feedback'],
      execution_style: 'plan_first',
      impact_scope: 'impact_industry',
      failure_response: 'iterate_on_failure',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'neutral_to_expectation',
    },
    narrativeAnswers: {
      motivation: '수학 문제를 풀 때 가장 재미있고, 프로그래밍으로 뭔가 만들 때 성취감을 느낍니다.',
      avoidance: '암기 위주 학습이나 글쓰기가 많은 과목은 피하고 싶습니다.',
      constraints: '수능 수학, 과학탐구 성적이 좋아서 이공계 상위권 대학을 목표로 하고 있습니다.',
    },
    llmPatterns: {
      '수학|과학|이과': '수학을 좋아하고 물리, 화학 성적이 좋습니다. 프로그래밍도 독학으로 배우고 있어요.',
      '진로|졸업|취업': '소프트웨어 개발자나 데이터 분석가 같은 IT 관련 직업에 관심이 있습니다.',
      '대학|학교|입시': '수능 수학, 과학 성적은 상위권이고, 정시를 준비하고 있습니다.',
    },
    roundFallbacks: {
      round1: ['알고리즘 문제 풀이에 빠지면 시간 가는 줄 모릅니다.', '인공지능과 머신러닝에 대해 더 깊이 배우고 싶습니다.'],
      round2: ['글을 많이 읽고 써야 하는 건 좀 지칩니다.', '정답이 없는 토론식 수업보다 명확한 답이 있는 문제가 좋습니다.'],
      round3: ['서울 소재 상위권 대학에 진학하고 싶습니다.', '수능 모의고사 기준 수학 1등급, 과탐 2등급 수준입니다.'],
    },
  },

  major_humanities_student: {
    id: 'major_humanities_student',
    name: '인문 지향 학생',
    type: 'major',
    careerState: 'student',
    stage: 'major_high',
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
    narrativeAnswers: {
      motivation: '사람들을 돕고 가르치는 일에 보람을 느낍니다.',
      avoidance: '수학이 많은 학과는 절대 안 됩니다.',
      constraints: '수시 전형으로 준비 중이고, 내신은 국어/사회 과목이 강합니다.',
    },
    llmPatterns: {
      '교육|가르치|봉사': '동아리에서 멘토링 활동을 하면서 가르치는 것에 보람을 느꼈습니다.',
      '수학|숫자|계산': '수학은 정말 어렵고, 수학이 많은 학과는 절대 가면 안 됩니다.',
      '사회|심리|인간': '사람들의 행동과 심리가 왜 그런지 이해하는 데 관심이 많습니다.',
    },
    roundFallbacks: {
      round1: ['사람들의 마음을 이해하고 도와주는 직업이면 좋겠습니다.', '글을 읽고 토론하는 수업이 가장 재미있습니다.'],
      round2: ['숫자가 많이 나오는 과목은 정말 싫습니다.', '혼자 연구실에서 실험하는 것보다 사람들과 함께하는 게 좋습니다.'],
      round3: ['학교 내신 평균 2등급 정도이고, 국어/사회 과목이 특히 좋습니다.', '교직이수가 가능한 학과면 좋겠습니다.'],
    },
  },

  major_creative_student: {
    id: 'major_creative_student',
    name: '예술형 학생',
    type: 'major',
    careerState: 'student',
    stage: 'major_high',
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
    narrativeAnswers: {
      motivation: '무언가를 직접 만들고 디자인하는 것이 가장 즐겁습니다.',
      avoidance: '반복적인 암기나 정해진 틀에 맞춰야 하는 학습은 답답합니다.',
      constraints: '아직 입시 방향을 정하지 못했습니다.',
    },
    llmPatterns: {
      '디자인|미술|예술|창작': '어릴 때부터 그림 그리기를 좋아했고, 디지털 아트도 독학으로 배웠습니다.',
      '진로|직업|미래': 'UX 디자이너나 일러스트레이터가 되고 싶습니다.',
    },
    roundFallbacks: {
      round1: ['그림, 디자인, 영상 편집 같은 창작 활동에 빠지면 하루가 금방 갑니다.'],
      round2: ['규칙이나 절차가 엄격한 환경은 숨 막힙니다.'],
      round3: ['미대 실기 준비를 할지, 디자인과를 일반 전형으로 갈지 고민 중입니다.'],
    },
  },

  major_career_focused: {
    id: 'major_career_focused',
    name: '취업 중시 학생',
    type: 'major',
    careerState: 'student',
    stage: 'major_high',
    academicState: 'high_school_regular',
    miniModule: {
      interest_top: ['organizing', 'data_numbers'],
      value_top: ['income', 'stability'],
      strength_top: ['structured_execution', 'persistence'],
      constraint_flags: ['low_employment_avoid'],
      workstyle_top: ['structured', 'team'],
      background_flags: [],
      language_skills: [{ language: 'english', level: 'basic' }],
      sacrifice_flags: ['no_sacrifice'],
      energy_drain_flags: ['unpredictability_drain', 'cognitive_drain'],
      achievement_feedback_top: ['metric_feedback'],
      execution_style: 'plan_first',
      impact_scope: 'impact_team',
      failure_response: 'iterate_on_failure',
      persistence_anchor: 'reward_anchor',
      external_expectation: 'external_structure_ok',
    },
    narrativeAnswers: {
      motivation: '졸업 후 빠르게 취업해서 경제적으로 안정되고 싶습니다.',
      avoidance: '취업률이 낮은 전공은 피하고 싶습니다.',
      constraints: '수능 성적은 중상위권이고, 서울/수도권 대학을 목표로 합니다.',
    },
    llmPatterns: {
      '취업|직업|소득|연봉': '졸업하면 바로 취업할 수 있는 학과가 좋습니다.',
      '안정|공무원|정규직': '대기업이나 공기업 같은 안정적인 직장에 취업하고 싶습니다.',
    },
    roundFallbacks: {
      round1: ['안정적인 대기업이나 공기업에 입사하는 것이 목표입니다.'],
      round2: ['뭘 배우는지는 모르겠고 졸업장만 주는 학과는 싫습니다.'],
      round3: ['수능 전 과목 평균 2~3등급 수준입니다.'],
    },
  },

  major_conflict_student: {
    id: 'major_conflict_student',
    name: '갈등형 학생',
    type: 'major',
    careerState: 'student',
    stage: 'major_high',
    academicState: 'high_school_undecided',
    miniModule: {
      interest_top: ['creating', 'organizing'],
      value_top: ['autonomy', 'stability'],
      strength_top: ['creative', 'structured_execution'],
      constraint_flags: [],
      workstyle_top: ['flexible', 'structured'],
      background_flags: [],
      language_skills: [],
      sacrifice_flags: ['low_initial_income'],
      energy_drain_flags: ['unpredictability_drain', 'repetition_drain'],
      achievement_feedback_top: ['tangible_output_feedback', 'metric_feedback'],
      execution_style: 'flexible_execution',
      impact_scope: 'impact_team',
      failure_response: 'pause_on_failure',
      persistence_anchor: 'growth_anchor',
      external_expectation: 'expectation_pressure',
    },
    narrativeAnswers: {
      motivation: '창의적인 일을 하면서도 안정적으로 살고 싶습니다.',
      avoidance: '너무 틀에 박힌 일도 싫지만, 너무 불확실한 미래도 불안합니다.',
      constraints: '입시 방향을 못 정했습니다.',
    },
    llmPatterns: {
      '갈등|고민|선택': '디자인이나 창작을 좋아하지만, 먹고 살 수 있을지 걱정됩니다.',
      '부모|주변|기대': '부모님은 안정적인 직업을 원하시고, 저도 이해가 되면서도 억울합니다.',
    },
    roundFallbacks: {
      round1: ['디자인이나 영상 만들기를 좋아하지만, 이것만으로 살 수 있을지 고민됩니다.'],
      round2: ['매일 같은 일을 반복하는 건 답답하지만, 너무 불안정한 것도 싫습니다.'],
      round3: ['성적은 중간 정도이고, 특별히 잘하는 과목은 없습니다.'],
    },
  },

  major_math_constrained: {
    id: 'major_math_constrained',
    name: '수학 제약 학생',
    type: 'major',
    careerState: 'student',
    stage: 'major_high',
    academicState: 'retake',
    miniModule: {
      interest_top: ['problem_solving', 'helping_teaching'],
      value_top: ['growth', 'meaning'],
      strength_top: ['communication', 'fast_learning'],
      constraint_flags: ['math_impossible'],
      workstyle_top: ['team', 'flexible'],
      background_flags: [],
      language_skills: [{ language: 'english', level: 'business' }],
      sacrifice_flags: ['willing_to_study', 'field_change_ok'],
      energy_drain_flags: ['cognitive_drain', 'time_pressure_drain'],
      achievement_feedback_top: ['helping_feedback', 'problem_solved_feedback'],
      execution_style: 'flexible_execution',
      impact_scope: 'impact_individual',
      failure_response: 'iterate_on_failure',
      persistence_anchor: 'meaning_anchor',
      external_expectation: 'neutral_to_expectation',
    },
    narrativeAnswers: {
      motivation: '사람들과 소통하면서 문제를 해결하는 일에 관심이 있습니다.',
      avoidance: '수학이 핵심인 학과는 절대 안 됩니다.',
      constraints: '재수 중이라 내년에 확실하게 갈 학과를 정해야 합니다.',
    },
    llmPatterns: {
      '수학|숫자|계산|정량': '수학을 정말 못합니다. 수포자라서 수학 집중 학과는 절대 안 됩니다.',
      '문제|해결|논리': '수학은 못하지만 사람 사이의 문제를 해결하는 것은 좋아합니다.',
    },
    roundFallbacks: {
      round1: ['사람의 행동이나 사회 현상을 이해하는 데 관심이 많습니다.'],
      round2: ['수학이 나오면 머리가 하얘집니다. 절대 안 됩니다.'],
      round3: ['수능 수학 5등급이라 이과 계열은 불가능합니다.'],
    },
  },

  major_child_curious: {
    id: 'major_child_curious',
    name: '호기심 많은 어린이',
    type: 'major',
    careerState: 'student',
    stage: 'major_child',
    academicState: null,
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
    narrativeAnswers: {
      motivation: '레고 만들기랑 그림 그리기를 좋아해요. 공룡이랑 우주도 좋아합니다.',
      avoidance: '가만히 앉아서 글 읽는 건 지루해요.',
      constraints: '아직 어린이라 잘 모르겠어요.',
    },
    llmPatterns: {
      '좋아하|관심|재미': '레고 조립하고 그림 그리는 게 제일 재미있어요. 과학 실험도 좋아합니다.',
      '꿈|되고 싶|미래': '과학자나 게임 만드는 사람이 되고 싶어요.',
    },
    roundFallbacks: {
      round1: ['만들기를 좋아하고, 새로운 것을 배우면 신나요.'],
      round2: ['가만히 앉아서 외우는 건 싫어요.'],
      round3: ['아직 잘 모르겠지만, 재미있는 걸 하고 싶어요.'],
    },
  },

  major_elementary_explorer: {
    id: 'major_elementary_explorer',
    name: '관심사 탐색 초등학생',
    type: 'major',
    careerState: 'student',
    stage: 'major_elementary',
    academicState: null,
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
    narrativeAnswers: {
      motivation: '수학 문제 푸는 것과 친구들에게 설명해주는 것을 좋아합니다.',
      avoidance: '너무 어려운 과학 실험은 좀 무서워요.',
      constraints: '초등학생이라 아직 많이 배워야 해요.',
    },
    llmPatterns: {
      '과목|좋아하|잘하는': '수학이랑 사회를 좋아하고, 친구들한테 설명해주는 걸 잘해요.',
      '꿈|되고 싶|미래': '선생님이나 의사 같은 사람을 돕는 직업이 되고 싶어요.',
    },
    roundFallbacks: {
      round1: ['친구들에게 문제를 설명해줄 때 보람을 느껴요.'],
      round2: ['혼자 오래 앉아서 하는 건 좀 힘들어요.'],
      round3: ['아직 초등학생이지만, 공부를 열심히 하고 싶어요.'],
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
    // Reset steps and pause state
    this.isPaused = false;
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
      case 'existential': return '가장 먼저 가족한테 전화할 것 같아요. 그리고 평소에 하고 싶었지만 미뤘던 것들을 하나씩 해보고 싶습니다. 결국 마지막에 떠오르는 건 소중한 사람들과 의미 있는 경험이라는 걸 이 질문을 통해 알게 됐어요.';
      default: return '일반적인 수준입니다.';
    }
  }
}


// ============================================
// ScenarioRunner 클래스
// ============================================

class ScenarioRunner {
  constructor(scenarioId, options = {}) {
    const scenario = SCENARIOS[scenarioId] || MAJOR_SCENARIOS[scenarioId];
    if (!scenario) {
      throw new Error(`시나리오를 찾을 수 없습니다: ${scenarioId}`);
    }
    this.isMajorScenario = !!MAJOR_SCENARIOS[scenarioId];

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

      // 테스트 완료 후 draft 정리 (실제 사용자 분석에 영향 안 주도록)
      try {
        await fetch(`${this.API_BASE}/draft/delete?session_id=${encodeURIComponent(this.sessionId)}`, {
          method: 'DELETE', credentials: 'same-origin'
        });
        this.progressUI.log('테스트 draft 정리 완료', 'info');
      } catch (e) { /* draft 삭제 실패는 무시 */ }

      // 결과 페이지 열기 콜백 설정
      let onResultClick = null;
      if (this.options.autoNavigateToResult && this.requestId) {
        const resultUrl = this.isMajorScenario
          ? `/analyzer/major?view=${this.requestId}`
          : `/analyzer/job?request_id=${this.requestId}`;
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

    // Stage 결정 (시나리오 직접 지정 우선, 없으면 careerState 기반)
    const stage = this.scenario.stage || this.getStageFromCareerState(careerState);

    // 503 재시도 포함 (동시 테스트 시 Worker 동시 요청 한도 대비)
    const analysisType = this.isMajorScenario ? 'major' : 'job';
    let response;
    const MAX_RETRIES = 2;
    for (let attempt = 0; attempt <= MAX_RETRIES; attempt++) {
      response = await fetch(`${this.API_BASE}/analyze`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          session_id: this.sessionId,
          analysis_type: analysisType,
          stage: stage,
          career_state: careerState,
          universal_answers: universalAnswers,
          mini_module_result: miniModule,
          academic_state: this.isMajorScenario ? (this.scenario.academicState || 'high_school_undecided') : undefined,
          debug: true,
        }),
      });
      if (response.ok || response.status < 500) break;
      if (attempt < MAX_RETRIES) {
        this.progressUI.log(`⚠️ 서버 오류 ${response.status}, ${5 * (attempt + 1)}초 후 재시도... (${attempt + 1}/${MAX_RETRIES})`, 'warning');
        await new Promise(r => setTimeout(r, 5000 * (attempt + 1)));
      }
    }

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

  // careerState → stage 변환 (직업/전공 분기)
  getStageFromCareerState(careerState) {
    if (this.isMajorScenario) {
      // 전공용 stages: major_middle, major_high, major_freshman, major_student, major_graduate
      const majorMapping = {
        'student': 'major_high',
        'job_seeker': 'major_high',
        'employed': 'major_student',
        'career_changer': 'major_student',
      };
      return majorMapping[careerState] || 'major_high';
    }
    // 직업용 stages: job_explore, job_student, job_early, job_transition, job_second
    const jobMapping = {
      'student': 'job_student',
      'job_seeker': 'job_explore',
      'employed': 'job_early',
      'career_changer': 'job_explore',
    };
    return jobMapping[careerState] || 'job_explore';
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

    // API가 기대하는 필드명: high_alive_moment, lost_moment, existential_answer
    const highAliveMoment = this.answerGenerator.getNarrativeAnswer('motivation') || '';
    const lostMoment = this.answerGenerator.getNarrativeAnswer('avoidance') || '';
    const existentialAnswer = this.answerGenerator.getNarrativeAnswer('existential') || '';

    // 안전한 substring 호출
    const displayMotivation = highAliveMoment.length > 50 ? highAliveMoment.substring(0, 50) + '...' : highAliveMoment;
    this.progressUI.log(`동기: "${displayMotivation}"`, 'info');
    if (existentialAnswer) {
      const displayExistential = existentialAnswer.length > 50 ? existentialAnswer.substring(0, 50) + '...' : existentialAnswer;
      this.progressUI.log(`실존적 가치: "${displayExistential}"`, 'info');
    }

    const response = await fetch(`${this.API_BASE}/v3/narrative-facts`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        high_alive_moment: highAliveMoment,
        lost_moment: lostMoment,
        existential_answer: existentialAnswer || undefined,
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

    // 1. 질문 요청 (전공 시나리오면 analysis_type='major' 전달 → 전공용 인터뷰어 프롬프트 사용)
    const questionsResponse = await fetch(`${this.API_BASE}/v3/round-questions`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: this.sessionId,
        round_number: round,
        analysis_type: this.isMajorScenario ? 'major' : 'job',
        narrative_facts: {
          highAliveMoment: this.answerGenerator.getNarrativeAnswer('motivation'),
          lostMoment: this.answerGenerator.getNarrativeAnswer('avoidance'),
          existentialAnswer: this.answerGenerator.getNarrativeAnswer('existential') || '',
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

    // Phase 1: Judge (추천 + 점수 매기기) — 503 재시도 포함
    const recommendEndpoint = this.isMajorScenario ? '/v3/recommend-major' : '/v3/recommend';
    const phaseLabel = this.isMajorScenario ? '전공' : '직업';
    // 전공: skipReport=false (리포트를 추천 요청 내에서 인라인 생성)
    // 직업: skipReport=true (리포트는 별도 /v3/recommend/report 엔드포인트에서 생성)
    const skipReport = !this.isMajorScenario;
    this.progressUI.log(`Phase 1: ${phaseLabel} 추천 분석 중${!skipReport ? ' (리포트 포함)' : ''}...`, 'info');
    let response = null;
    const MAX_RETRIES = 2;
    const requestBody = {
      session_id: this.sessionId,
      searchProfile: searchProfile,
      mini_module_result: miniModule,
      topK: 200,
      judgeTopN: 10,
      debug: true,
      skipReport: skipReport,
    };
    if (this.isMajorScenario && this.scenario.academicState) {
      requestBody.academic_state = this.scenario.academicState;
    }
    for (let attempt = 0; attempt <= MAX_RETRIES; attempt++) {
      try {
        response = await fetch(`${this.API_BASE}${recommendEndpoint}`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(requestBody),
        });
        if (response.ok || response.status < 500) break;
        if (attempt < MAX_RETRIES) {
          this.progressUI.log(`⚠️ 서버 오류 ${response.status}, ${5 * (attempt + 1)}초 후 재시도... (${attempt + 1}/${MAX_RETRIES})`, 'warning');
          await new Promise(r => setTimeout(r, 5000 * (attempt + 1)));
        }
      } catch (fetchError) {
        if (attempt >= MAX_RETRIES) throw fetchError;
        this.progressUI.log(`⚠️ 네트워크 오류, ${5 * (attempt + 1)}초 후 재시도... (${attempt + 1}/${MAX_RETRIES})`, 'warning');
        await new Promise(r => setTimeout(r, 5000 * (attempt + 1)));
      }
    }

    if (!response || !response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(`추천 요청 실패: ${response.status} - ${errorData.error || ''}`);
    }

    const data = await response.json();
    this.progressUI.log(`Phase 1 완료: ${phaseLabel} 추천 완료`, 'success');

    // Phase 2: Reporter (직업만 — 전공은 Phase 1에서 인라인 생성됨)
    if (!this.isMajorScenario) {
      this.progressUI.log('Phase 2: 심리분석 리포트 생성 중...', 'info');
      try {
        const reportResponse = await fetch(`${this.API_BASE}/v3/recommend/report`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ session_id: this.sessionId }),
        });
        if (reportResponse.ok) {
          const reportData = await reportResponse.json();
          data.premium_report = reportData.premium_report;
          data.report_mode = reportData.report_mode;
          const reportMode = reportData.report_mode || 'unknown';
          if (reportMode === 'llm') {
            this.progressUI.log('LLM 기반 리포트 생성 성공', 'success');
          } else if (reportMode === 'fallback') {
            this.progressUI.log('Fallback 리포트 사용', 'warning');
          }
        } else {
          this.progressUI.log('리포트 생성 실패 (추천 결과는 정상)', 'warning');
        }
      } catch (reportError) {
        this.progressUI.log('리포트 생성 중 오류 (추천 결과는 정상)', 'warning');
      }
    } else {
      // 전공: /v3/recommend-major에서 리포트가 인라인으로 생성됨
      const reportMode = data.report_mode || 'unknown';
      if (reportMode === 'llm') {
        this.progressUI.log('Phase 2: 전공 리포트 (인라인) 생성 성공', 'success');
      } else if (reportMode === 'fallback') {
        this.progressUI.log('Phase 2: 전공 리포트 Fallback 사용', 'warning');
      } else if (reportMode === 'deferred') {
        this.progressUI.log('Phase 2: 전공 리포트 지연 생성 (skipReport)', 'info');
      }
    }

    if (this.isMajorScenario && data.recommendations && data.recommendations.top_majors && data.recommendations.top_majors.length > 0) {
      // 전공 추천 결과 표시
      const topMajor = data.recommendations.top_majors[0];
      const topMajorName = topMajor?.major_name || topMajor?.name || '전공명 없음';
      const topFitScore = topMajor?.fit_score ?? topMajor?.scores?.fit ?? 'N/A';
      this.progressUI.log(`추천 1위: ${topMajorName} (Fit: ${topFitScore})`, 'success');

      for (let i = 0; i < Math.min(3, data.recommendations.top_majors.length); i++) {
        const major = data.recommendations.top_majors[i];
        const majorName = major?.major_name || major?.name || '전공명 없음';
        const fitScore = major?.fit_score ?? major?.scores?.fit ?? 'N/A';
        this.progressUI.log(`${i + 1}. ${majorName} - Fit: ${fitScore}`, 'success');
      }
    } else if (data.recommendations && data.recommendations.top_jobs && data.recommendations.top_jobs.length > 0) {
      const topJob = data.recommendations.top_jobs[0];
      const topJobName = topJob?.job_name || topJob?.name || '직업명 없음';
      const topFitScore = topJob?.fit_score ?? topJob?.scores?.fit ?? 'N/A';
      this.progressUI.log(`추천 1위: ${topJobName} (Fit: ${topFitScore})`, 'success');

      for (let i = 0; i < Math.min(3, data.recommendations.top_jobs.length); i++) {
        const job = data.recommendations.top_jobs[i];
        const jobName = job?.job_name || job?.name || '직업명 없음';
        const fitScore = job?.fit_score ?? job?.scores?.fit ?? 'N/A';
        this.progressUI.log(`${i + 1}. ${jobName} - Fit: ${fitScore}`, 'success');
      }
    } else if (data.recommendations && data.recommendations.length > 0) {
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

window.runMajorE2EScenario = async function(scenarioId) {
  try {
    const runner = new ScenarioRunner(scenarioId);
    const result = await runner.start();
    console.log('Major E2E Scenario Result:', result);
    return result;
  } catch (error) {
    console.error('Major E2E Scenario Error:', error);
    alert('전공 시나리오 실행 오류: ' + error.message);
    return { success: false, error: error.message };
  }
};

window.getMajorScenarioList = function() {
  return Object.values(MAJOR_SCENARIOS).map(s => ({
    id: s.id,
    name: s.name,
    academicState: s.academicState,
  }));
};

console.log('ScenarioRunner loaded. Available functions: runE2EScenario(scenarioId), runMajorE2EScenario(scenarioId), getMajorScenarioList()');
