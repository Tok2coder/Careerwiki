// src/services/ai-analyzer/mini-module-questions.ts
// ============================================
// 미니모듈: LLM 판단 앵커 시스템
// ============================================
// LLM은 "텍스트"가 아닌 "정량화된 구조 신호"를 받아서 해석만 담당
// 이 모듈이 LLM에게 "어디를 파야 하는지" 알려주는 나침반 역할
// ============================================

// ============================================
// Types
// ============================================

export interface MiniModuleQuestion {
  id: string
  text: string
  token: string
  emoji: string
}

export interface MiniModuleResult {
  // Q1~Q4: Top 2 토큰 (각 모듈에서 가장 많이 선택된 2개)
  interest_top: string[]      // Q1. 예: ["problem_solving", "analysis"]
  value_top: string[]         // Q2. 예: ["autonomy", "growth"]
  strength_top: string[]      // Q3. 예: ["structuring", "explanation"]
  constraint_flags: string[]  // Q4. 선택된 모든 제약: ["time_constraint", "income_constraint"]
  
  // Q5~Q7: 스타일 및 배경 정보 (2026-02-03 추가)
  workstyle_top?: string[]              // Q5. 업무 스타일 - 최대 2개 ["solo", "flexible"]
  background_flags?: string[]           // Q6. 배경 정보 - 최대 3개
  language_skills?: Array<{             // Q7. 언어 능력 - 최대 5개
    language: string
    level: 'basic' | 'business' | 'native'
  }>
  
  // Q8~Q15: 확장 모듈 결과 (2026-01-28 추가)
  sacrifice_flags?: string[]           // Q8. 포기 가능성 - 최대 2개
  energy_drain_flags?: string[]        // Q9. 에너지 소모원 - 최대 2개
  achievement_feedback_top?: string[]  // Q10. 성취 피드백 타입 - 최대 2개
  execution_style?: string             // Q11. 실행 속도 성향 - 단일 선택
  impact_scope?: string                // Q12. 영향 범위 선호 - 단일 선택
  failure_response?: string            // Q13. 실패 반응 - 단일 선택 (Hard Bias급)
  persistence_anchor?: string          // Q14. 버팀 앵커 - 단일 선택
  external_expectation?: string        // Q15. 타인 기대 반응 - 단일 선택
  
  // 장애 유형 (physical_constraint 선택 시 세부 유형)
  disability_type?: 'visual' | 'hearing' | 'mobility' | 'other'

  // 신뢰도/일관성 신호 (보강 1)
  low_confidence_flags?: string[]      // 예: ['interest', 'value'] - 고르게 선택됨
  internal_conflict_flags?: string[]   // 예: ['autonomy_vs_stability'] - 충돌 가치
  
  // 원본 선택 데이터 (디버깅/분석용)
  raw_selections?: {
    interest: string[]
    value: string[]
    strength: string[]
    constraint: string[]
    workstyle?: string[]
    background?: string[]
    language?: Array<{ language: string; level: string }>
    sacrifice?: string[]
    energy_drain?: string[]
    achievement_feedback?: string[]
    execution_style?: string[]
    impact_scope?: string[]
    failure_response?: string[]
    persistence_anchor?: string[]
    external_expectation?: string[]
  }
}

// ============================================
// 흥미(Interest) 모듈 - 6문항
// "무엇에 끌리는가?"
// ============================================
export const INTEREST_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_int_1',
    text: '문제를 분석하고 해결책을 찾는 것',
    token: 'problem_solving',
    emoji: '🔍'
  },
  {
    id: 'mm_int_2',
    text: '새로운 것을 만들거나 디자인하는 것',
    token: 'creating',
    emoji: '🎨'
  },
  {
    id: 'mm_int_3',
    text: '사람들을 돕거나 가르치는 것',
    token: 'helping_teaching',
    emoji: '🤝'
  },
  {
    id: 'mm_int_4',
    text: '데이터나 숫자를 다루는 것',
    token: 'data_numbers',
    emoji: '📊'
  },
  {
    id: 'mm_int_5',
    text: '조직하고 체계적으로 관리하는 것',
    token: 'organizing',
    emoji: '📋'
  },
  {
    id: 'mm_int_6',
    text: '영향력을 발휘하고 설득하는 것',
    token: 'influencing',
    emoji: '📢'
  },
]

// ============================================
// 가치(Value) 모듈 - 6문항
// "무엇이 중요한가?"
// ============================================
export const VALUE_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_val_1',
    text: '스스로 결정하고 자율적으로 일하기',
    token: 'autonomy',
    emoji: '🦋'
  },
  {
    id: 'mm_val_2',
    text: '새로운 것을 배우고 성장하기',
    token: 'growth',
    emoji: '🌱'
  },
  {
    id: 'mm_val_3',
    text: '안정적이고 예측 가능한 환경',
    token: 'stability',
    emoji: '🏠'
  },
  {
    id: 'mm_val_4',
    text: '높은 수입과 경제적 보상',
    token: 'income',
    emoji: '💰'
  },
  {
    id: 'mm_val_5',
    text: '의미 있는 일, 사회에 기여',
    token: 'meaning',
    emoji: '🌍'
  },
  {
    id: 'mm_val_6',
    text: '인정받고 영향력 발휘하기',
    token: 'recognition',
    emoji: '⭐'
  },
]

// ============================================
// 강점(Strength) 모듈 - 6문항
// "무엇을 잘하는가?"
// ============================================
export const STRENGTH_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_str_1',
    text: '복잡한 것을 분석하고 논리적으로 정리',
    token: 'analytical',
    emoji: '🧠'
  },
  {
    id: 'mm_str_2',
    text: '새로운 아이디어를 떠올리고 창의적 해결',
    token: 'creative',
    emoji: '💡'
  },
  {
    id: 'mm_str_3',
    text: '다른 사람에게 설명하고 소통하기',
    token: 'communication',
    emoji: '💬'
  },
  {
    id: 'mm_str_4',
    text: '계획을 세우고 체계적으로 실행',
    token: 'structured_execution',
    emoji: '📑'
  },
  {
    id: 'mm_str_5',
    text: '끈기 있게 끝까지 해내기',
    token: 'persistence',
    emoji: '🏋️'
  },
  {
    id: 'mm_str_6',
    text: '빠르게 배우고 적응하기',
    token: 'fast_learning',
    emoji: '📖'
  },
]

// ============================================
// 제약(Constraint) 모듈 - 6문항
// "무엇을 피하고 싶은가?" / "현실적 제약은?"
// ============================================
export const CONSTRAINT_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_con_1',
    text: '야근이나 긴 근무시간은 어려움',
    token: 'time_constraint',
    emoji: '⏰'
  },
  {
    id: 'mm_con_2',
    text: '수입이 일정 수준 이상이어야 함',
    token: 'income_constraint',
    emoji: '💵'
  },
  {
    id: 'mm_con_3',
    text: '특정 지역에서만 근무 가능',
    token: 'location_constraint',
    emoji: '📍'
  },
  {
    id: 'mm_con_4',
    text: '육체적으로 힘든 일은 어려움',
    token: 'physical_constraint',
    emoji: '💪'
  },
  {
    id: 'mm_con_5',
    text: '새로운 자격증/학위 취득은 어려움',
    token: 'qualification_constraint',
    emoji: '📜'
  },
  {
    id: 'mm_con_6',
    text: '불확실하거나 불안정한 환경은 어려움',
    token: 'uncertainty_constraint',
    emoji: '❓'
  },
]

// ============================================
// Q5. 업무 스타일 (Workstyle) - 최대 2개 선택
// "일할 때 어떤 방식이 더 편한가요?"
// 👉 협업 방식 + 환경 구조 혼합 선택
// ============================================
export const WORKSTYLE_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_ws_1',
    text: '혼자 집중',
    token: 'solo',
    emoji: '🧘'
  },
  {
    id: 'mm_ws_2',
    text: '팀워크',
    token: 'team',
    emoji: '👫'
  },
  {
    id: 'mm_ws_3',
    text: '규칙/절차 있는 환경',
    token: 'structured',
    emoji: '📋'
  },
  {
    id: 'mm_ws_4',
    text: '자유로운 환경',
    token: 'flexible',
    emoji: '🦋'
  },
]

// ============================================
// Q6. 배경 정보 (Background) - 최대 3개 선택
// "특별한 경험이나 배경이 있나요?"
// 👉 직업 추천 시 경험 기반 가중치
// ============================================
export const BACKGROUND_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_bg_1',
    text: '해외 거주/유학',
    token: 'overseas_living',
    emoji: '🌍'
  },
  {
    id: 'mm_bg_2',
    text: '전문 자격증/면허',
    token: 'license_cert',
    emoji: '📜'
  },
  {
    id: 'mm_bg_3',
    text: '창업/사업 경험',
    token: 'startup_experience',
    emoji: '🚀'
  },
  {
    id: 'mm_bg_4',
    text: '연구/학술 경험',
    token: 'research_academic',
    emoji: '🔬'
  },
  {
    id: 'mm_bg_5',
    text: '봉사/NGO 활동',
    token: 'volunteer_ngo',
    emoji: '🤝'
  },
]

// ============================================
// Q7. 언어 능력 (Language) - 최대 5개 선택
// "한국어 외에 사용 가능한 언어가 있나요?"
// 👉 글로벌/외국계 직업 추천에 활용
// ============================================
export interface LanguageQuestion {
  id: string
  text: string
  token: string
  emoji: string
}

export const LANGUAGE_QUESTIONS: LanguageQuestion[] = [
  { id: 'mm_lang_1', text: '영어', token: 'english', emoji: '🇺🇸' },
  { id: 'mm_lang_2', text: '중국어', token: 'chinese', emoji: '🇨🇳' },
  { id: 'mm_lang_3', text: '일본어', token: 'japanese', emoji: '🇯🇵' },
  { id: 'mm_lang_4', text: '스페인어', token: 'spanish', emoji: '🇪🇸' },
  { id: 'mm_lang_5', text: '프랑스어', token: 'french', emoji: '🇫🇷' },
  { id: 'mm_lang_6', text: '독일어', token: 'german', emoji: '🇩🇪' },
  { id: 'mm_lang_7', text: '베트남어', token: 'vietnamese', emoji: '🇻🇳' },
  { id: 'mm_lang_8', text: '태국어', token: 'thai', emoji: '🇹🇭' },
]

export const LANGUAGE_LEVELS = [
  { value: 'basic', label: '일상회화', emoji: '💬' },
  { value: 'business', label: '업무가능', emoji: '💼' },
  { value: 'native', label: '원어민급', emoji: '🏆' },
]

// ============================================
// Q8. 포기 가능성 질문 (Sacrifice) - 최대 2개 선택
// "진로를 위해 감수할 수 있는 것은?"
// 👉 전공 추천 vs 직업 추천, 안정형 vs 성장형, 현실형 vs 이상형 분기
// ============================================
export const SACRIFICE_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_sac_1',
    text: '초반 연봉이 낮아도 괜찮다',
    token: 'low_initial_income',
    emoji: '📉'
  },
  {
    id: 'mm_sac_2',
    text: '다시 공부/훈련하는 건 괜찮다',
    token: 'willing_to_study',
    emoji: '📚'
  },
  {
    id: 'mm_sac_3',
    text: '완전히 다른 분야로 가도 괜찮다',
    token: 'field_change_ok',
    emoji: '🔄'
  },
  {
    id: 'mm_sac_4',
    text: '주변의 시선을 감수할 수 있다',
    token: 'ignore_social_pressure',
    emoji: '🧑‍🤝‍🧑'
  },
  {
    id: 'mm_sac_5',
    text: '아무것도 포기하고 싶지 않다',
    token: 'no_sacrifice',
    emoji: '⛔'
  },
]

// ============================================
// Q9. 에너지 소모원 (Energy Drain) - 최대 2개 선택
// "이럴 때 가장 빨리 지치나요?"
// 👉 stress_tolerance, people, environment 축 보강
// ============================================
export const ENERGY_DRAIN_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_ene_1',
    text: '사람 상대할 때',
    token: 'people_drain',
    emoji: '😵'
  },
  {
    id: 'mm_ene_2',
    text: '계속 생각해야 하는 일',
    token: 'cognitive_drain',
    emoji: '🧠'
  },
  {
    id: 'mm_ene_3',
    text: '시간 압박이 있을 때',
    token: 'time_pressure_drain',
    emoji: '⏱️'
  },
  {
    id: 'mm_ene_4',
    text: '책임이 큰 결정을 해야 할 때',
    token: 'responsibility_drain',
    emoji: '📊'
  },
  {
    id: 'mm_ene_5',
    text: '반복 작업할 때',
    token: 'repetition_drain',
    emoji: '🔁'
  },
  {
    id: 'mm_ene_6',
    text: '예측 불가한 상황',
    token: 'unpredictability_drain',
    emoji: '❓'
  },
]

// ============================================
// Q10. 성취 피드백 타입 (Achievement Feedback) - 최대 2개 선택
// "일을 잘하고 있다는 느낌은 언제 드나요?"
// 👉 직업 만족도 예측 정확도 크게 상승
// ============================================
export const ACHIEVEMENT_FEEDBACK_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_ach_1',
    text: '결과가 수치로 보일 때',
    token: 'metric_feedback',
    emoji: '🏆'
  },
  {
    id: 'mm_ach_2',
    text: '누군가에게 직접 도움이 됐을 때',
    token: 'helping_feedback',
    emoji: '🙌'
  },
  {
    id: 'mm_ach_3',
    text: '어려운 문제를 해결했을 때',
    token: 'problem_solved_feedback',
    emoji: '🧩'
  },
  {
    id: 'mm_ach_4',
    text: '내가 만든 결과물이 남을 때',
    token: 'tangible_output_feedback',
    emoji: '🎨'
  },
  {
    id: 'mm_ach_5',
    text: '시간이 지날수록 성장할 때',
    token: 'growth_feedback',
    emoji: '📈'
  },
]

// ============================================
// Q11. 실행 속도 성향 (Execution Style) - 단일 선택
// "새로운 일을 시작할 때 나는?"
// 👉 스타트업/기획/연구 vs 운영/관리/전문직 분기
// ============================================
export const EXECUTION_STYLE_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_exe_1',
    text: '일단 해보며 배우는 편',
    token: 'action_first',
    emoji: '🚀'
  },
  {
    id: 'mm_exe_2',
    text: '계획이 서야 시작하는 편',
    token: 'plan_first',
    emoji: '🧱'
  },
  {
    id: 'mm_exe_3',
    text: '둘 다 상황 따라 다름',
    token: 'flexible_execution',
    emoji: '🔄'
  },
]

// ============================================
// Q12. 영향 범위 선호 (Impact Scope) - 단일 선택
// "내 일이 영향을 미치길 바라는 범위는?"
// 👉 의미 지향 직업 추천의 정확도 보강
// ============================================
export const IMPACT_SCOPE_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_imp_1',
    text: '개인 한 명',
    token: 'impact_individual',
    emoji: '👤'
  },
  {
    id: 'mm_imp_2',
    text: '작은 팀/조직',
    token: 'impact_team',
    emoji: '🧑‍🤝‍🧑'
  },
  {
    id: 'mm_imp_3',
    text: '회사/산업',
    token: 'impact_industry',
    emoji: '🏢'
  },
  {
    id: 'mm_imp_4',
    text: '사회 전반',
    token: 'impact_society',
    emoji: '🌏'
  },
  {
    id: 'mm_imp_5',
    text: '잘 모르겠다',
    token: 'impact_unsure',
    emoji: '🤷'
  },
]

// ============================================
// Q13. 실패했을 때의 반응 (Failure Response) - 단일 선택
// "일이 잘 안 됐을 때, 나는 보통 어떤 반응에 가깝나요?"
// 👉 '버틸 수 있는 직업' 결정 핵심 - Hard Bias에 준하는 보정자
// ============================================
export const FAILURE_RESPONSE_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_fail_1',
    text: '다시 구조를 고쳐본다',
    token: 'iterate_on_failure',
    emoji: '🔄'
  },
  {
    id: 'mm_fail_2',
    text: '다른 방식으로 빠르게 바꾼다',
    token: 'pivot_on_failure',
    emoji: '🧪'
  },
  {
    id: 'mm_fail_3',
    text: '잠시 멈추고 정리한다',
    token: 'pause_on_failure',
    emoji: '⏸️'
  },
  {
    id: 'mm_fail_4',
    text: '크게 흔들린다',
    token: 'emotionally_affected',
    emoji: '💥'
  },
]

// ============================================
// Q14. 일을 계속하게 만드는 결정적 조건 (Persistence Anchor) - 단일 선택
// "아래 중 하나만 유지된다면, 힘들어도 일을 계속할 수 있다면?"
// 👉 '버팀 앵커' - Desire와 Feasibility 갈등 해소
// ============================================
export const PERSISTENCE_ANCHOR_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_anc_1',
    text: '보상이 명확함',
    token: 'reward_anchor',
    emoji: '💰'
  },
  {
    id: 'mm_anc_2',
    text: '성장 체감',
    token: 'growth_anchor',
    emoji: '📈'
  },
  {
    id: 'mm_anc_3',
    text: '함께하는 사람',
    token: 'people_anchor',
    emoji: '🤝'
  },
  {
    id: 'mm_anc_4',
    text: '의미/방향성',
    token: 'meaning_anchor',
    emoji: '🧭'
  },
  {
    id: 'mm_anc_5',
    text: '안정성',
    token: 'stability_anchor',
    emoji: '🛡️'
  },
]

// ============================================
// Q15. 타인의 기대에 대한 반응 (External Expectation) - 단일 선택
// "주변의 기대나 기준이 있을 때 나는?"
// 👉 전문직 / 조직 / 프리랜서 / 창작직 분기에 유용
// ============================================
export const EXTERNAL_EXPECTATION_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_exp_1',
    text: '기준이 있으면 편하다',
    token: 'external_structure_ok',
    emoji: '🧱'
  },
  {
    id: 'mm_exp_2',
    text: '상관없다',
    token: 'neutral_to_expectation',
    emoji: '😐'
  },
  {
    id: 'mm_exp_3',
    text: '부담이 된다',
    token: 'expectation_pressure',
    emoji: '😣'
  },
]

// ============================================
// 전체 모듈 통합 (Q1~Q15 순서대로)
// ============================================
export const MINI_MODULE_QUESTIONS = {
  // Q1~Q4: 기본 질문
  interest: INTEREST_QUESTIONS,              // Q1
  value: VALUE_QUESTIONS,                    // Q2
  strength: STRENGTH_QUESTIONS,              // Q3
  constraint: CONSTRAINT_QUESTIONS,          // Q4
  // Q5~Q7: 스타일 및 배경
  workstyle: WORKSTYLE_QUESTIONS,            // Q5
  background: BACKGROUND_QUESTIONS,          // Q6
  language: LANGUAGE_QUESTIONS,              // Q7
  // Q8~Q15: 확장 질문
  sacrifice: SACRIFICE_QUESTIONS,            // Q8
  energy_drain: ENERGY_DRAIN_QUESTIONS,      // Q9
  achievement_feedback: ACHIEVEMENT_FEEDBACK_QUESTIONS,  // Q10
  execution_style: EXECUTION_STYLE_QUESTIONS,            // Q11
  impact_scope: IMPACT_SCOPE_QUESTIONS,                  // Q12
  failure_response: FAILURE_RESPONSE_QUESTIONS,          // Q13
  persistence_anchor: PERSISTENCE_ANCHOR_QUESTIONS,      // Q14
  external_expectation: EXTERNAL_EXPECTATION_QUESTIONS,  // Q15
}

// ============================================
// 충돌 가치 쌍 정의
// ============================================
const CONFLICT_PAIRS: Array<[string, string, string]> = [
  ['autonomy', 'stability', 'autonomy_vs_stability'],
  ['growth', 'income', 'growth_vs_income'],
  ['meaning', 'income', 'meaning_vs_income'],
  ['autonomy', 'recognition', 'autonomy_vs_recognition'],
]

// ============================================
// Hard Bias 내부 충돌 쌍 정의 (Q8 ↔ Q9)
// "버티는 쪽 보수 해석" 규칙 적용
// ============================================
export interface HardBiasConflict {
  sacrificeFlag: string
  energyDrainFlag: string
  conflictName: string
  interpretation: string  // 보수 해석 방향
  recommendationType: 'conservative' | 'exploratory' | 'balanced'
}

export const HARD_BIAS_CONFLICT_RULES: HardBiasConflict[] = [
  // no_sacrifice 조합 (강력한 안정 신호)
  {
    sacrificeFlag: 'no_sacrifice',
    energyDrainFlag: 'unpredictability_drain',
    conflictName: 'no_sacrifice_unpredictability',
    interpretation: '변화 없이 안정 원함 + 예측 불가 싫음 → 현 직업군 내 안정적 선택만',
    recommendationType: 'conservative',
  },
  {
    sacrificeFlag: 'no_sacrifice',
    energyDrainFlag: 'time_pressure_drain',
    conflictName: 'no_sacrifice_time_pressure',
    interpretation: '포기 없음 + 시간 압박 싫음 → 워라밸 좋은 기존 직업 우선',
    recommendationType: 'conservative',
  },
  {
    sacrificeFlag: 'no_sacrifice',
    energyDrainFlag: 'responsibility_drain',
    conflictName: 'no_sacrifice_responsibility',
    interpretation: '포기 없음 + 책임 싫음 → 실무 전문가 경로 (관리직 제외)',
    recommendationType: 'conservative',
  },
  
  // low_initial_income 조합 (성장 vs 현실 긴장)
  {
    sacrificeFlag: 'low_initial_income',
    energyDrainFlag: 'time_pressure_drain',
    conflictName: 'low_income_time_pressure',
    interpretation: '성장 원함 but 과도한 희생 NO → 스타트업보다 중견기업 성장직',
    recommendationType: 'balanced',
  },
  {
    sacrificeFlag: 'low_initial_income',
    energyDrainFlag: 'cognitive_drain',
    conflictName: 'low_income_cognitive',
    interpretation: '성장 원함 but 지속 페이스 필요 → 점진적 성장 경로 (급격한 학습 제외)',
    recommendationType: 'balanced',
  },
  
  // willing_to_study 조합 (학습 의지 vs 에너지 제약)
  {
    sacrificeFlag: 'willing_to_study',
    energyDrainFlag: 'cognitive_drain',
    conflictName: 'study_cognitive_conflict',
    interpretation: '배움 의지 있으나 인지 피로 민감 → 단기 집중보다 장기 점진 학습',
    recommendationType: 'balanced',
  },
  {
    sacrificeFlag: 'willing_to_study',
    energyDrainFlag: 'time_pressure_drain',
    conflictName: 'study_time_pressure',
    interpretation: '재학습 OK but 시간 압박 싫음 → 파트타임/야간 학습 가능 경로',
    recommendationType: 'balanced',
  },
  
  // field_change_ok 조합 (전환 의지 vs 에너지 제약)
  {
    sacrificeFlag: 'field_change_ok',
    energyDrainFlag: 'unpredictability_drain',
    conflictName: 'field_change_unpredictability',
    interpretation: '전환 열림 but 불확실 싫음 → 체계적 전환 프로그램 있는 분야로',
    recommendationType: 'balanced',
  },
  {
    sacrificeFlag: 'field_change_ok',
    energyDrainFlag: 'people_drain',
    conflictName: 'field_change_people',
    interpretation: '전환 OK but 대인 피로 → 독립 작업 중심 신규 분야 추천',
    recommendationType: 'exploratory',
  },
]

/**
 * Hard Bias 내부 충돌 감지
 * Q8(sacrifice)과 Q9(energy_drain) 간의 충돌을 감지하고 해석 방향 반환
 */
export function detectHardBiasConflicts(
  sacrificeFlags: string[],
  energyDrainFlags: string[]
): {
  conflicts: HardBiasConflict[]
  overallType: 'conservative' | 'exploratory' | 'balanced'
  decisionBias: string
} {
  const detectedConflicts: HardBiasConflict[] = []
  
  for (const rule of HARD_BIAS_CONFLICT_RULES) {
    if (
      sacrificeFlags.includes(rule.sacrificeFlag) &&
      energyDrainFlags.includes(rule.energyDrainFlag)
    ) {
      detectedConflicts.push(rule)
    }
  }
  
  // 전체 타입 결정: conservative가 하나라도 있으면 conservative
  let overallType: 'conservative' | 'exploratory' | 'balanced' = 'balanced'
  if (detectedConflicts.some(c => c.recommendationType === 'conservative')) {
    overallType = 'conservative'
  } else if (detectedConflicts.every(c => c.recommendationType === 'exploratory')) {
    overallType = 'exploratory'
  }
  
  // 결정 편향 요약 문구 생성
  let decisionBias = ''
  if (overallType === 'conservative') {
    decisionBias = 'Stability-preserving: prioritize low-risk, familiar paths'
  } else if (overallType === 'exploratory') {
    decisionBias = 'Exploration-ready: open to new directions with structure'
  } else {
    decisionBias = 'Balanced: growth-oriented but sustainable pace required'
  }
  
  return {
    conflicts: detectedConflicts,
    overallType,
    decisionBias,
  }
}

// ============================================
// 결과 계산 함수
// ============================================

/**
 * 선택 배열에서 Top N 추출
 * @param selections 선택된 토큰 배열
 * @param n 추출할 개수
 * @returns Top N 토큰 배열
 */
function getTopN(selections: string[], n: number): string[] {
  // 빈도 계산
  const freq = new Map<string, number>()
  for (const token of selections) {
    freq.set(token, (freq.get(token) || 0) + 1)
  }
  
  // 빈도 순 정렬
  const sorted = Array.from(freq.entries())
    .sort((a, b) => b[1] - a[1])
    .map(([token]) => token)
  
  return sorted.slice(0, n)
}

/**
 * 신뢰도 플래그 계산
 * Top2 선택이 너무 고르게 분산되면 low_confidence
 */
function checkLowConfidence(selections: string[], moduleName: string): string | null {
  if (selections.length < 2) return moduleName // 선택이 너무 적음
  
  const freq = new Map<string, number>()
  for (const token of selections) {
    freq.set(token, (freq.get(token) || 0) + 1)
  }
  
  const counts = Array.from(freq.values()).sort((a, b) => b - a)
  
  // 상위 3개가 모두 같은 빈도면 low_confidence
  if (counts.length >= 3 && counts[0] === counts[1] && counts[1] === counts[2]) {
    return moduleName
  }
  
  return null
}

/**
 * 내부 충돌 플래그 계산
 * 충돌하는 가치가 동시에 Top2에 포함되면 플래그
 */
function checkInternalConflicts(valueTop: string[]): string[] {
  const conflicts: string[] = []
  
  for (const [val1, val2, conflictName] of CONFLICT_PAIRS) {
    if (valueTop.includes(val1) && valueTop.includes(val2)) {
      conflicts.push(conflictName)
    }
  }
  
  return conflicts
}

/**
 * 미니모듈 결과 계산
 * @param rawSelections 각 모듈별 선택된 토큰 배열
 * @returns MiniModuleResult
 */
export function calculateMiniModuleResult(rawSelections: {
  interest: string[]
  value: string[]
  strength: string[]
  constraint: string[]
  sacrifice?: string[]
  energy_drain?: string[]
  achievement_feedback?: string[]
  execution_style?: string[]
  impact_scope?: string[]
  failure_response?: string[]
  persistence_anchor?: string[]
  external_expectation?: string[]
}): MiniModuleResult {
  // Top 2 추출
  const interest_top = getTopN(rawSelections.interest, 2)
  const value_top = getTopN(rawSelections.value, 2)
  const strength_top = getTopN(rawSelections.strength, 2)
  
  // 제약은 선택된 모든 항목 (플래그 방식)
  const constraint_flags = [...new Set(rawSelections.constraint)]
  
  // 신규 모듈 결과 (2026-01-28 추가)
  const sacrifice_flags = rawSelections.sacrifice ? [...new Set(rawSelections.sacrifice)].slice(0, 2) : undefined
  const energy_drain_flags = rawSelections.energy_drain ? [...new Set(rawSelections.energy_drain)].slice(0, 2) : undefined
  const achievement_feedback_top = rawSelections.achievement_feedback ? getTopN(rawSelections.achievement_feedback, 2) : undefined
  const execution_style = rawSelections.execution_style?.[0] || undefined  // 단일 선택
  const impact_scope = rawSelections.impact_scope?.[0] || undefined  // 단일 선택
  const failure_response = rawSelections.failure_response?.[0] || undefined  // Q13. 단일 선택
  const persistence_anchor = rawSelections.persistence_anchor?.[0] || undefined  // Q14. 단일 선택
  const external_expectation = rawSelections.external_expectation?.[0] || undefined  // Q15. 단일 선택
  
  // 신뢰도 체크
  const low_confidence_flags: string[] = []
  const interestConf = checkLowConfidence(rawSelections.interest, 'interest')
  const valueConf = checkLowConfidence(rawSelections.value, 'value')
  const strengthConf = checkLowConfidence(rawSelections.strength, 'strength')
  
  if (interestConf) low_confidence_flags.push(interestConf)
  if (valueConf) low_confidence_flags.push(valueConf)
  if (strengthConf) low_confidence_flags.push(strengthConf)
  
  // 내부 충돌 체크
  const internal_conflict_flags = checkInternalConflicts(value_top)
  
  return {
    interest_top,
    value_top,
    strength_top,
    constraint_flags,
    sacrifice_flags,
    energy_drain_flags,
    achievement_feedback_top,
    execution_style,
    impact_scope,
    failure_response,
    persistence_anchor,
    external_expectation,
    low_confidence_flags: low_confidence_flags.length > 0 ? low_confidence_flags : undefined,
    internal_conflict_flags: internal_conflict_flags.length > 0 ? internal_conflict_flags : undefined,
    raw_selections: rawSelections,
  }
}

// ============================================
// 토큰 → 영어 키워드 맵핑 (벡터 검색용)
// ============================================
export const TOKEN_TO_ENGLISH: Record<string, string> = {
  // Interest tokens
  problem_solving: 'problem solving analytical logical',
  creating: 'creative design innovation artistic',
  helping_teaching: 'helping teaching coaching mentoring',
  helping: 'helping caring social welfare counseling service',
  data_numbers: 'data analysis numerical quantitative',
  organizing: 'organizing management systematic administrative office',
  influencing: 'influencing persuasion leadership sales',
  routine: 'administrative clerical civil service government office regular',
  research: 'research investigation academic scientific',

  // Value tokens
  autonomy: 'autonomous independent self-directed freedom',
  growth: 'learning development career growth advancement',
  stability: 'stable secure government civil service permanent regular',
  income: 'high income salary compensation financial',
  meaning: 'meaningful purpose impact social contribution',
  recognition: 'recognition achievement influence status',
  wlb: 'work-life balance regular hours no overtime',
  expertise: 'expertise professional specialist skilled',
  
  // Strength tokens
  analytical: 'analytical logical reasoning problem-solving',
  creative: 'creative innovative imaginative design',
  communication: 'communication presentation explanation interpersonal',
  structured_execution: 'organized systematic planning execution',
  persistence: 'persistent dedicated focused determined',
  fast_learning: 'fast learner adaptable quick study',
  
  // Constraint tokens
  time_constraint: 'work-life balance no overtime regular hours',
  work_hours_strict: 'regular hours no overtime strict schedule predictable',
  no_travel: 'no business trip local commute office-based',
  income_constraint: 'minimum salary income requirement',
  location_constraint: 'specific location remote work',
  physical_constraint: 'office work non-physical sedentary',
  qualification_constraint: 'no degree no certification entry-level',
  uncertainty_constraint: 'stable environment predictable secure',
  
  // Major Constraint tokens (전공 추천용)
  math_impossible: 'no math avoid mathematics statistics quantitative',
  lab_impossible: 'no lab no experiment no practical no hands-on',
  high_competition_avoid: 'low competition easy admission accessible',
  low_employment_avoid: 'high employment rate career prospects job security',
  reading_heavy_avoid: 'minimal reading writing avoid essay thesis papers',

  // Sacrifice tokens (Q8)
  low_initial_income: 'low starting salary growth potential long-term',
  willing_to_study: 'retraining education new skills certification',
  field_change_ok: 'career pivot industry change transition',
  ignore_social_pressure: 'unconventional non-traditional bold choice',
  no_sacrifice: 'safe choice low risk stable path',
  
  // Energy Drain tokens (Q9)
  people_drain: 'introvert independent solitary low-interaction',
  cognitive_drain: 'routine simple physical hands-on',
  time_pressure_drain: 'relaxed pace no deadline flexible schedule',
  responsibility_drain: 'support role team contributor low-stakes',
  repetition_drain: 'varied dynamic changing creative',
  unpredictability_drain: 'structured predictable routine systematic',
  
  // Achievement Feedback tokens (Q10)
  metric_feedback: 'KPI metrics quantifiable performance measurable',
  helping_feedback: 'service helping others impact direct people',
  problem_solved_feedback: 'challenge solving complex puzzle technical',
  tangible_output_feedback: 'creation portfolio product artifact visible',
  growth_feedback: 'development learning mastery progression career',
  
  // Execution Style tokens (Q11)
  action_first: 'startup agile experimental fast-moving iterative',
  plan_first: 'structured methodical process systematic planning',
  flexible_execution: 'adaptable balanced versatile context-dependent',
  
  // Impact Scope tokens (Q12)
  impact_individual: 'one-on-one personal coaching counseling direct',
  impact_team: 'small group team local department unit',
  impact_industry: 'corporate enterprise industry-wide business B2B',
  impact_society: 'public social global systemic community NGO',
  impact_unsure: 'exploring open flexible undefined scope',
  
  // Failure Response tokens (Q13)
  iterate_on_failure: 'resilient systematic problem-solver iterative improvement',
  pivot_on_failure: 'adaptable agile quick-pivot flexible startup',
  pause_on_failure: 'reflective careful planner needs-recovery structured',
  emotionally_affected: 'sensitive emotional needs-support stable-environment',
  
  // Persistence Anchor tokens (Q14)
  reward_anchor: 'compensation-driven bonus incentive financial motivation',
  growth_anchor: 'learning-driven development mastery career-advancement',
  people_anchor: 'team-oriented relationship collaborative social connection',
  meaning_anchor: 'purpose-driven mission values impact significance',
  stability_anchor: 'security-driven predictable steady reliable safe',
  
  // External Expectation tokens (Q15)
  external_structure_ok: 'structure-comfortable organized guidelines clear-expectations',
  neutral_to_expectation: 'independent self-directed flexible autonomous',
  expectation_pressure: 'pressure-sensitive creative autonomous freelance artist',
}

// ============================================
// 토큰 → 한국어 라벨 맵핑 (UI 표시용)
// ============================================
export const TOKEN_TO_KOREAN: Record<string, string> = {
  // Interest tokens
  problem_solving: '문제해결',
  creating: '창작/디자인',
  helping_teaching: '도움/가르침',
  data_numbers: '데이터/숫자',
  organizing: '조직/관리',
  influencing: '영향력/설득',
  research: '연구/탐구',
  tech: '기술/IT',
  art: '예술',
  design: '디자인',
  routine: '정형화된 업무',
  helping: '돌봄/봉사',
  creative: '창작/예술',

  // Value tokens
  autonomy: '자율',
  growth: '성장',
  stability: '안정',
  income: '수입',
  meaning: '의미',
  recognition: '인정',
  expertise: '전문성',
  wlb: '워라밸',
  creativity: '창의성',
  
  // Strength tokens (Note: creative는 Interest와 동일 키이므로 생략, 프론트엔드 STRENGTH_LABELS에서 처리)
  analytical: '분석력',
  // creative: 생략 (Interest에서 정의됨 - 프론트엔드가 컨텍스트 구분)
  communication: '소통력',
  structured_execution: '실행력',
  persistence: '끈기',
  fast_learning: '학습력',
  
  // Constraint tokens
  time_constraint: '시간 제약',
  income_constraint: '수입 조건',
  location_constraint: '위치 제약',
  physical_constraint: '체력 제약',
  qualification_constraint: '자격 제약',
  uncertainty_constraint: '불확실성 회피',
  
  // Sacrifice tokens (Q8)
  low_initial_income: '낮은 초봉 감수',
  willing_to_study: '재학습 감수',
  field_change_ok: '분야 전환 감수',
  ignore_social_pressure: '주변 시선 감수',
  no_sacrifice: '포기 불가',
  
  // Energy Drain tokens (Q9)
  people_drain: '대인관계 스트레스',
  cognitive_drain: '인지 피로',
  time_pressure_drain: '시간 압박 스트레스',
  responsibility_drain: '책임 스트레스',
  repetition_drain: '반복 피로',
  unpredictability_drain: '불확실성 스트레스',
  
  // Achievement Feedback tokens (Q10)
  metric_feedback: '수치 성과',
  helping_feedback: '직접 도움',
  problem_solved_feedback: '문제 해결',
  tangible_output_feedback: '결과물 산출',
  growth_feedback: '성장 실감',
  
  // Execution Style tokens (Q11)
  action_first: '행동 우선',
  plan_first: '계획 우선',
  flexible_execution: '상황 적응',
  
  // Impact Scope tokens (Q12)
  impact_individual: '개인',
  impact_team: '팀/조직',
  impact_industry: '회사/산업',
  impact_society: '사회 전반',
  impact_unsure: '미정',
  
  // Failure Response tokens (Q13)
  iterate_on_failure: '구조 재점검',
  pivot_on_failure: '빠른 전환',
  pause_on_failure: '멈추고 정리',
  emotionally_affected: '크게 흔들림',
  
  // Persistence Anchor tokens (Q14)
  reward_anchor: '보상 앵커',
  growth_anchor: '성장 앵커',
  people_anchor: '사람 앵커',
  meaning_anchor: '의미 앵커',
  stability_anchor: '안정 앵커',
  
  // External Expectation tokens (Q15)
  external_structure_ok: '외부 기준 편함',
  neutral_to_expectation: '무관',
  expectation_pressure: '기대 부담',
  
  // Workstyle tokens (Q5)
  solo: '혼자 집중',
  solo_deep: '혼자 깊이 집중',
  team: '팀워크',
  team_harmony: '팀 조화',
  structured: '규칙/절차',
  flexible: '자유로운 환경',
  
  // Background tokens (Q6)
  overseas_living: '해외 거주/유학',
  license_cert: '전문 자격증/면허',
  startup_experience: '창업/사업 경험',
  research_academic: '연구/학술 경험',
  volunteer_ngo: '봉사/NGO 활동',
  
  // Language Level tokens (Q7)
  basic: '일상회화',
  business: '업무가능',
  native: '원어민급',
  
  // Extended Execution Style tokens (Q11 aliases)
  fast_mover: '빠른 실행',
  balanced_pace: '균형 잡힌 속도',
  thorough_planner: '철저한 계획',
  
  // Extended Impact Scope tokens (Q12 aliases)
  individual_impact: '개인 영향',
  team_impact: '팀 영향',
  org_impact: '조직 영향',
  society_impact: '사회 영향',
  
  // Extended Failure Response tokens (Q13 alias)
  persist_on_failure: '끈기 있게 도전',
  
  // Health Constraint token
  health_constraint: '건강 제약',

  // Major Constraint tokens (전공 추천용)
  math_impossible: '수학 불가',
  lab_impossible: '실험/실습 불가',
  high_competition_avoid: '높은 경쟁률 기피',
  low_employment_avoid: '낮은 취업률 기피',
  reading_heavy_avoid: '독해/작문 기피',

  // Academic State tokens (전공 추천 학업상태)
  high_school_early: '수시 준비',
  high_school_regular: '정시 준비',
  high_school_undecided: '진로 미정',
  university_freshman: '전과/복수전공',
  transfer: '편입 준비',
  retake: '재수/반수',
  adult_learner: '성인학습자',

  // Extended Constraint tokens (HardCut/Job attributes)
  // 피하고 싶은 것 문맥에서 사용되므로 "~불가"가 아닌 피하고 싶은 대상으로 표기
  work_hours_strict: '불규칙한 근무시간',
  no_travel: '출장',
  no_overtime: '야근',
  remote_only: '출퇴근',
  remote_preferred: '재택 선호',
  prefer_remote: '재택 선호',
  no_shift: '교대근무',
  no_physical: '육체노동',
  no_outdoor: '야외근무',
  no_weekend: '주말근무',
  no_repetitive: '반복 업무',
  no_social_stress: '대인 스트레스',
  no_relocation: '이사/출장',
  shift_work_no: '교대근무',
  degree_impossible: '학위 취득 어려움',
  license_impossible: '자격 취득 어려움',
  travel_impossible: '출장 불가',
  prefer_low_overtime: '야근 최소화',

  // Additional Energy Drain tokens (aliases)
  uncertainty_drain: '불확실성 스트레스',
  routine_drain: '반복 루틴 피로',
  bureaucracy_drain: '관료적 절차 스트레스',
}

// ============================================
// 빈 결과 생성 (초기화용)
// ============================================
export function createEmptyMiniModuleResult(): MiniModuleResult {
  return {
    interest_top: [],
    value_top: [],
    strength_top: [],
    constraint_flags: [],
    sacrifice_flags: [],
    energy_drain_flags: [],
    achievement_feedback_top: [],
    execution_style: undefined,
    impact_scope: undefined,
    failure_response: undefined,
    persistence_anchor: undefined,
    external_expectation: undefined,
    raw_selections: {
      interest: [],
      value: [],
      strength: [],
      constraint: [],
      sacrifice: [],
      energy_drain: [],
      achievement_feedback: [],
      execution_style: [],
      impact_scope: [],
      failure_response: [],
      persistence_anchor: [],
      external_expectation: [],
    },
  }
}

// ============================================
// decision_summary 생성 (LLM Judge 품질 향상용)
// 한 줄 메타 요약으로 Judge의 점수 일관성 및 rationale 품질 향상
// ============================================
export function generateDecisionSummary(result: MiniModuleResult): string {
  const parts: string[] = []
  
  // 1. 기본 성향 파악
  const hasExploratoryFlags = 
    result.sacrifice_flags?.includes('field_change_ok') ||
    result.sacrifice_flags?.includes('willing_to_study') ||
    result.sacrifice_flags?.includes('low_initial_income')
  
  const hasConservativeFlags = 
    result.sacrifice_flags?.includes('no_sacrifice') ||
    result.constraint_flags.includes('uncertainty_constraint')
  
  // 2. 탐색 준비 상태
  if (hasConservativeFlags) {
    parts.push('Stability-focused')
  } else if (hasExploratoryFlags) {
    parts.push('Exploration-ready')
  } else {
    parts.push('Balanced approach')
  }
  
  // 3. 주요 에너지 제약 (Q9)
  const drainWarnings: string[] = []
  if (result.energy_drain_flags?.includes('people_drain')) {
    drainWarnings.push('social pressure')
  }
  if (result.energy_drain_flags?.includes('unpredictability_drain')) {
    drainWarnings.push('unpredictability')
  }
  if (result.energy_drain_flags?.includes('time_pressure_drain')) {
    drainWarnings.push('time pressure')
  }
  if (result.energy_drain_flags?.includes('responsibility_drain')) {
    drainWarnings.push('high responsibility')
  }
  if (result.energy_drain_flags?.includes('cognitive_drain')) {
    drainWarnings.push('cognitive overload')
  }
  
  if (drainWarnings.length > 0) {
    parts.push(`low tolerance for ${drainWarnings.join(' and ')}`)
  }
  
  // 4. 핵심 가치 (Top 1)
  if (result.value_top.length > 0) {
    const topValue = TOKEN_TO_KOREAN[result.value_top[0]] || result.value_top[0]
    parts.push(`prioritizes ${topValue}`)
  }
  
  // 5. 내부 충돌 있으면 추가
  if (result.internal_conflict_flags?.length) {
    parts.push('with internal value conflicts')
  }
  
  // 6. 성취 피드백 선호 (Q10)
  if (result.achievement_feedback_top?.length) {
    const feedbackMap: Record<string, string> = {
      'metric_feedback': 'needs measurable results',
      'helping_feedback': 'motivated by direct impact',
      'problem_solved_feedback': 'thrives on challenges',
      'tangible_output_feedback': 'wants visible outcomes',
      'growth_feedback': 'seeks continuous growth',
    }
    const topFeedback = feedbackMap[result.achievement_feedback_top[0]]
    if (topFeedback) {
      parts.push(topFeedback)
    }
  }
  
  // 7. 실행 스타일 (Q11)
  if (result.execution_style === 'action_first') {
    parts.push('prefers agile execution')
  } else if (result.execution_style === 'plan_first') {
    parts.push('prefers structured planning')
  }
  
  // 8. 실패 반응 (Q13) - Hard Bias급 보정자
  if (result.failure_response === 'emotionally_affected') {
    parts.push('needs stable environment (sensitive to failure)')
  } else if (result.failure_response === 'pause_on_failure') {
    parts.push('reflective under stress')
  } else if (result.failure_response === 'pivot_on_failure') {
    parts.push('quick to pivot')
  } else if (result.failure_response === 'iterate_on_failure') {
    parts.push('systematic problem-solver')
  }
  
  // 9. 버팀 앵커 (Q14) - Desire vs Feasibility 갈등 해소
  if (result.persistence_anchor) {
    const anchorMap: Record<string, string> = {
      'reward_anchor': 'anchored by compensation',
      'growth_anchor': 'anchored by growth',
      'people_anchor': 'anchored by relationships',
      'meaning_anchor': 'anchored by purpose',
      'stability_anchor': 'anchored by security',
    }
    const anchor = anchorMap[result.persistence_anchor]
    if (anchor) {
      parts.push(anchor)
    }
  }
  
  // 10. 외부 기대 반응 (Q15) - 직업 형태 분기
  if (result.external_expectation === 'expectation_pressure') {
    parts.push('pressure-sensitive (avoid strict hierarchy)')
  } else if (result.external_expectation === 'external_structure_ok') {
    parts.push('comfortable with external structure')
  }
  
  return parts.join(', ')
}

/**
 * SearchProfile용 decision_summary 및 hardBiasConflicts 생성
 */
export function enrichSearchProfileWithDecisionSummary(
  result: MiniModuleResult
): {
  decision_summary: string
  hardBiasConflicts: {
    hasConflict: boolean
    overallType: 'conservative' | 'exploratory' | 'balanced'
    conflictNames: string[]
  }
} {
  // Hard Bias 충돌 감지
  const conflictResult = detectHardBiasConflicts(
    result.sacrifice_flags || [],
    result.energy_drain_flags || []
  )
  
  // decision_summary 생성
  let summary = generateDecisionSummary(result)
  
  // 충돌 정보가 있으면 요약에 추가
  if (conflictResult.conflicts.length > 0) {
    summary = `${conflictResult.decisionBias}. ${summary}`
  }
  
  return {
    decision_summary: summary,
    hardBiasConflicts: {
      hasConflict: conflictResult.conflicts.length > 0,
      overallType: conflictResult.overallType,
      conflictNames: conflictResult.conflicts.map(c => c.conflictName),
    },
  }
}

// ============================================
// 결과 요약 문자열 생성 (디버깅/로깅용)
// ============================================
export function summarizeMiniModuleResult(result: MiniModuleResult): string {
  const parts: string[] = []
  
  parts.push(`흥미: ${result.interest_top.map(t => TOKEN_TO_KOREAN[t] || t).join(', ') || '없음'}`)
  parts.push(`가치: ${result.value_top.map(t => TOKEN_TO_KOREAN[t] || t).join(', ') || '없음'}`)
  parts.push(`강점: ${result.strength_top.map(t => TOKEN_TO_KOREAN[t] || t).join(', ') || '없음'}`)
  parts.push(`제약: ${result.constraint_flags.map(t => TOKEN_TO_KOREAN[t] || t).join(', ') || '없음'}`)
  
  // 신규 모듈 (2026-01-28 추가)
  if (result.sacrifice_flags?.length) {
    parts.push(`🔥 포기: ${result.sacrifice_flags.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')}`)
  }
  if (result.energy_drain_flags?.length) {
    parts.push(`⚡ 에너지소모: ${result.energy_drain_flags.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')}`)
  }
  if (result.achievement_feedback_top?.length) {
    parts.push(`🏆 성취피드백: ${result.achievement_feedback_top.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')}`)
  }
  if (result.execution_style) {
    parts.push(`🏃 실행: ${TOKEN_TO_KOREAN[result.execution_style] || result.execution_style}`)
  }
  if (result.impact_scope) {
    parts.push(`🌍 영향범위: ${TOKEN_TO_KOREAN[result.impact_scope] || result.impact_scope}`)
  }
  
  // 신규 모듈 (Q13-Q15)
  if (result.failure_response) {
    parts.push(`💥 실패반응: ${TOKEN_TO_KOREAN[result.failure_response] || result.failure_response}`)
  }
  if (result.persistence_anchor) {
    parts.push(`🛡️ 버팀앵커: ${TOKEN_TO_KOREAN[result.persistence_anchor] || result.persistence_anchor}`)
  }
  if (result.external_expectation) {
    parts.push(`👁️ 기대반응: ${TOKEN_TO_KOREAN[result.external_expectation] || result.external_expectation}`)
  }
  
  if (result.low_confidence_flags?.length) {
    parts.push(`⚠️ 신뢰도 낮음: ${result.low_confidence_flags.join(', ')}`)
  }
  
  if (result.internal_conflict_flags?.length) {
    parts.push(`⚡ 내부 충돌: ${result.internal_conflict_flags.join(', ')}`)
  }

  return parts.join(' | ')
}

// ============================================
// P1: Like 검증 질문
// 관심사 선택에 대한 실제 경험 확인
// ============================================

export interface LikeValidationResult {
  interest_token: string
  validation_level: 'experienced_loved' | 'experienced_ok' | 'never_tried'
  like_adjustment: number  // +10, 0, +5
}

export const LIKE_VALIDATION_OPTIONS = [
  { value: 'experienced_loved', label: '해봤고 좋았어요', likeBoost: 10, emoji: '😍' },
  { value: 'experienced_ok', label: '해봤는데 그럭저럭', likeBoost: 0, emoji: '😐' },
  { value: 'never_tried', label: '안 해봤지만 끌려요', likeBoost: 5, emoji: '✨' },
] as const

export type LikeValidationLevel = typeof LIKE_VALIDATION_OPTIONS[number]['value']

/**
 * 관심사 토큰에 대한 Like 검증 질문 생성
 */
export function generateLikeValidationQuestion(
  interestToken: string
): { question: string; options: typeof LIKE_VALIDATION_OPTIONS } {
  const koreanLabel = TOKEN_TO_KOREAN[interestToken] || interestToken

  return {
    question: `"${koreanLabel}" 분야를 실제로 경험해보신 적 있나요?`,
    options: LIKE_VALIDATION_OPTIONS,
  }
}

/**
 * Like 검증 답변 → Like Boost 계산
 */
export function calculateLikeBoost(
  validationLevel: LikeValidationLevel
): number {
  const option = LIKE_VALIDATION_OPTIONS.find(o => o.value === validationLevel)
  return option?.likeBoost ?? 0
}

/**
 * 여러 Like 검증 결과의 총 boost 계산
 * - MAX_TOTAL_LIKE_BOOST (40) 상한 적용
 */
export function calculateTotalLikeBoost(
  results: LikeValidationResult[],
  maxCap: number = 40
): number {
  const totalBoost = results.reduce((sum, r) => sum + r.like_adjustment, 0)
  return Math.min(totalBoost, maxCap)
}

// ============================================
// 전공 추천 전용 질문 모듈
// ============================================

// ---- 전공용 제약 조건 (Q4 대체) ----
// analysis_type === 'major'일 때 CONSTRAINT_QUESTIONS 대신 사용
export const MAJOR_CONSTRAINT_QUESTIONS: MiniModuleQuestion[] = [
  {
    id: 'mm_mcon_1',
    text: '수학이 많은 전공은 피하고 싶다',
    token: 'math_impossible',
    emoji: '🔢'
  },
  {
    id: 'mm_mcon_2',
    text: '실험/실습 위주 전공은 어렵다',
    token: 'lab_impossible',
    emoji: '🔬'
  },
  {
    id: 'mm_mcon_3',
    text: '경쟁률이 높은 학과는 피하고 싶다',
    token: 'high_competition_avoid',
    emoji: '📈'
  },
  {
    id: 'mm_mcon_4',
    text: '취업률이 낮은 전공은 걱정된다',
    token: 'low_employment_avoid',
    emoji: '💼'
  },
  {
    id: 'mm_mcon_5',
    text: '글 읽기/쓰기가 많은 전공은 피하고 싶다',
    token: 'reading_heavy_avoid',
    emoji: '📝'
  },
]

// ---- 학업 상태 질문 (전공 전용, 프로필 빌딩 첫 단계) ----
// analysis_type === 'major'일 때 흥미/가치/강점 질문 전에 학업 상태를 먼저 물어봄
// 이 정보는 LLM Judge의 feasibilityScore 평가에 활용
export interface AcademicStateOption {
  id: string
  label: string
  token: string
  emoji: string
  description: string  // 부가 설명 (UI 툴팁용)
}

export const ACADEMIC_STATE_QUESTION_OPTIONS: AcademicStateOption[] = [
  {
    id: 'mm_acad_1',
    label: '고등학생 - 수시 준비',
    token: 'high_school_early',
    emoji: '📋',
    description: '학생부 종합/교과 전형으로 대학 진학을 준비하고 있어요',
  },
  {
    id: 'mm_acad_2',
    label: '고등학생 - 정시 준비',
    token: 'high_school_regular',
    emoji: '📝',
    description: '수능 성적으로 대학 진학을 준비하고 있어요',
  },
  {
    id: 'mm_acad_3',
    label: '고등학생 - 아직 미정',
    token: 'high_school_undecided',
    emoji: '🤔',
    description: '입시 방향이 아직 정해지지 않았어요',
  },
  {
    id: 'mm_acad_4',
    label: '대학 재학 - 전과/복수전공 고민',
    token: 'university_freshman',
    emoji: '🎓',
    description: '현재 재학 중이며 전과 또는 복수전공을 고민하고 있어요',
  },
  {
    id: 'mm_acad_5',
    label: '편입 준비',
    token: 'transfer',
    emoji: '🔄',
    description: '다른 대학/학과로 편입을 준비하고 있어요',
  },
  {
    id: 'mm_acad_6',
    label: '재수/반수',
    token: 'retake',
    emoji: '🔁',
    description: '재수 또는 반수를 통해 다시 대학을 준비하고 있어요',
  },
  {
    id: 'mm_acad_7',
    label: '성인학습자/직장인',
    token: 'adult_learner',
    emoji: '💼',
    description: '직장 생활 중이거나 성인이 된 후 대학 진학을 고민하고 있어요',
  },
]

export const ACADEMIC_STATE_QUESTION_TEXT = '현재 학업 상황은 어떤가요?'

// ---- 전공용 미니모듈 통합 (Q0~Q15) ----
// Q0: 학업 상태 (전공 전용)
// Q1~Q3: 흥미/가치/강점 (직업과 동일)
// Q4: 전공 제약 (직업 제약 대신)
// Q5~Q15: 나머지 공통 질문 (직업과 동일)
export const MAJOR_MINI_MODULE_QUESTIONS = {
  academic_state: ACADEMIC_STATE_QUESTION_OPTIONS,   // Q0 (전공 전용)
  interest: INTEREST_QUESTIONS,                      // Q1
  value: VALUE_QUESTIONS,                            // Q2
  strength: STRENGTH_QUESTIONS,                      // Q3
  constraint: MAJOR_CONSTRAINT_QUESTIONS,             // Q4 (전공용 교체)
  workstyle: WORKSTYLE_QUESTIONS,                    // Q5
  background: BACKGROUND_QUESTIONS,                  // Q6
  language: LANGUAGE_QUESTIONS,                      // Q7
  sacrifice: SACRIFICE_QUESTIONS,                    // Q8
  energy_drain: ENERGY_DRAIN_QUESTIONS,              // Q9
  achievement_feedback: ACHIEVEMENT_FEEDBACK_QUESTIONS, // Q10
  execution_style: EXECUTION_STYLE_QUESTIONS,        // Q11
  impact_scope: IMPACT_SCOPE_QUESTIONS,              // Q12
  failure_response: FAILURE_RESPONSE_QUESTIONS,      // Q13
  persistence_anchor: PERSISTENCE_ANCHOR_QUESTIONS,  // Q14
  external_expectation: EXTERNAL_EXPECTATION_QUESTIONS, // Q15
}
