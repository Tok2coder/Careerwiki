// src/services/ai-analyzer/career-tree-types.ts
// ============================================
// 커리어트리 5축 상태 좌표 + 전이 신호 타입 정의
// ============================================
// P0: 5축 구조 (role_identity + career_stage_years + transition_status + skill_level + constraints)

// ============================================
// 축 1: 역할 정체성 (Role Identity) - 직업 추천용
// ============================================
export type RoleIdentity = 'student' | 'worker' | 'manager' | 'entrepreneur' | 'job_seeker' | 'inactive'

export const ROLE_IDENTITY_OPTIONS: Array<{
  value: RoleIdentity
  label: string
  emoji: string
  description: string
  help: string // 부가 설명
}> = [
  { 
    value: 'student', 
    label: '학생', 
    emoji: '📚', 
    description: '학업 중인 분',
    help: '고등학생, 대학생, 대학원생 등 현재 학업이 주된 활동인 경우'
  },
  { 
    value: 'worker', 
    label: '직장인', 
    emoji: '💼', 
    description: '회사/조직에서 일하는 중',
    help: '정규직, 계약직, 파트타임 등 현재 고용되어 일하고 있는 경우'
  },
  { 
    value: 'manager', 
    label: '관리자/리더', 
    emoji: '👑', 
    description: '팀/조직을 이끄는 역할',
    help: '팀장, 매니저, 임원 등 사람을 관리하는 직책에 있는 경우'
  },
  { 
    value: 'entrepreneur', 
    label: '창업자/사업가', 
    emoji: '🚀', 
    description: '사업을 운영 중',
    help: '프리랜서, 자영업, 스타트업 대표 등 스스로 사업을 운영하는 경우'
  },
  { 
    value: 'job_seeker', 
    label: '취업/창업 준비생', 
    emoji: '🎯', 
    description: '새로운 기회를 찾는 중',
    help: '구직 중, 이직 준비 중, 경력 단절 후 복귀 준비, 은퇴 후 새 시작 등'
  },
]

// P0.5: student/job_seeker 세분화 "탈출구"
// UI는 단순하게 유지하되, facts 레벨에서는 분기 가능성 남겨두기
export type RoleIdentitySubtype =
  | 'high_school' // student 세분화
  | 'univ' // student 세분화
  | 'grad_school' // student 세분화
  | 'job_seeker_first' // job_seeker 세분화: 첫 취업
  | 'job_seeker_switch' // job_seeker 세분화: 이직/전직
  | 'job_seeker_return' // job_seeker 세분화: 복귀
  | 'job_seeker_retired' // job_seeker 세분화: 은퇴 후

// ============================================
// 축 2: 학습/경험 기간 (Career Stage Years)
// ============================================
export type CareerStageYears = 'none' | '0_3' | '3_10' | '10_plus'

export const CAREER_STAGE_OPTIONS: Array<{
  value: CareerStageYears
  label: string
  description: string
  help: string
  allows_resume: boolean
}> = [
  { 
    value: 'none', 
    label: '경험 없음', 
    description: '해당 분야 경험 없음',
    help: '관심 분야에서 아직 경험을 쌓지 않은 경우',
    allows_resume: false 
  },
  { 
    value: '0_3', 
    label: '초기 (0~3년)', 
    description: '막 시작한 단계',
    help: '관심 분야에서 3년 이하의 경험이 있는 경우',
    allows_resume: true 
  },
  { 
    value: '3_10', 
    label: '중간 (3~10년)', 
    description: '실무 경험 축적 중',
    help: '관심 분야에서 3~10년의 경험이 있는 경우',
    allows_resume: true 
  },
  { 
    value: '10_plus', 
    label: '시니어 (10년+)', 
    description: '풍부한 경험 보유',
    help: '관심 분야에서 10년 이상의 경험이 있는 경우',
    allows_resume: true 
  },
]

// ============================================
// 축 3: 현재 목표 (Transition Status) - 다중 선택 가능!
// ============================================
export type TransitionStatus =
  | 'growth_current' // 현 분야 성장
  | 'field_change' // 분야/업종 전환
  | 'return_work' // 경력 복귀
  | 'second_career' // 세컨드 커리어
  | 'first_job' // 첫 취업
  | 'explore' // 탐색 중
  // Legacy values (resume-parser compatibility)
  | 'none'
  | 'changer'
  | 'returner'

export const TRANSITION_STATUS_OPTIONS: Array<{
  value: TransitionStatus
  label: string
  emoji: string
  description: string
  help: string
}> = [
  { 
    value: 'first_job', 
    label: '첫 직장/첫 경험', 
    emoji: '🌟', 
    description: '처음으로 일자리를 찾는 중',
    help: '학교 졸업 후 첫 취업을 준비하거나, 새로운 분야에서 처음 경험을 쌓으려는 경우'
  },
  { 
    value: 'growth_current', 
    label: '현 분야 성장', 
    emoji: '📈', 
    description: '현재 분야에서 더 성장하고 싶음',
    help: '지금 하는 일을 계속하면서 승진, 연봉 인상, 역량 강화를 원하는 경우'
  },
  { 
    value: 'field_change', 
    label: '분야/업종 전환', 
    emoji: '🔄', 
    description: '다른 분야로 바꾸고 싶음',
    help: '현재 분야에서 벗어나 새로운 업종, 직종, 역할로 전환하고 싶은 경우'
  },
  { 
    value: 'return_work', 
    label: '복귀 준비', 
    emoji: '🔙', 
    description: '휴직/단절 후 다시 일하고 싶음',
    help: '육아휴직, 건강 문제, 기타 사유로 쉬다가 다시 일터로 돌아가려는 경우'
  },
  { 
    value: 'second_career', 
    label: '세컨드 커리어', 
    emoji: '🌅', 
    description: '은퇴 후 또는 새로운 인생 2막',
    help: '첫 번째 커리어를 마무리하고 새로운 분야에서 의미 있는 일을 찾는 경우'
  },
  { 
    value: 'explore', 
    label: '탐색 중', 
    emoji: '🔍', 
    description: '아직 방향을 정하지 못함',
    help: '여러 가능성을 열어두고 어떤 방향이 맞을지 찾아보고 있는 경우'
  },
]

// ============================================
// 축 4: 숙련 수준 (Skill Level) - "관심 분야" 기준!
// ============================================
export type SkillLevel = 0 | 1 | 2 | 3 | 4

export const SKILL_LEVEL_OPTIONS: Array<{
  value: SkillLevel
  label: string
  description: string
  help: string
}> = [
  { 
    value: 0, 
    label: '입문', 
    description: '이 분야는 처음',
    help: '관심 분야에 대해 아직 배우거나 경험해본 적이 없는 상태'
  },
  { 
    value: 1, 
    label: '초급', 
    description: '기초는 알아요',
    help: '기본 개념은 알고 있지만 실무 경험이 부족한 상태'
  },
  { 
    value: 2, 
    label: '중급', 
    description: '실무 가능해요',
    help: '혼자서 기본적인 업무를 수행할 수 있는 수준'
  },
  { 
    value: 3, 
    label: '고급', 
    description: '전문가 수준',
    help: '복잡한 문제도 해결하고 다른 사람을 가르칠 수 있는 수준'
  },
  { 
    value: 4, 
    label: '마스터', 
    description: '분야 리더',
    help: '업계에서 인정받는 전문가, 트렌드를 이끄는 수준'
  },
]

// UI 표시용 안내 문구 (Step 1 + 결과 화면에서 사용)
export const SKILL_LEVEL_NOTICE = {
  question: '관심 분야에서의 숙련도는?', // ← "관심 분야" 명시
  hint: '현재 경력과 무관하게, 앞으로 가고 싶은 분야 기준으로 선택해주세요',
  result_explainer: (years: CareerStageYears, level: SkillLevel): string | null => {
    if (years === '10_plus' && level <= 1) {
      return '경력은 풍부하지만, 현재 관심 분야에서는 새로운 시작 단계로 판단했어요.'
    }
    if (years === 'none' && level >= 3) {
      return '공식 경력은 없지만, 관심 분야에서는 이미 높은 숙련도를 가지셨네요.'
    }
    return null
  },
}

// ============================================
// 축 5: 제약 조건 (Constraints)
// ============================================
export interface ConstraintDetail<T extends string> {
  has_constraint: boolean
  details?: T
  custom_detail?: string // 사용자 입력 상세 설명
}

export interface CareerConstraints {
  time: ConstraintDetail<'overtime_no' | 'shift_no' | 'weekend_no' | 'parttime_only'>
  money: ConstraintDetail<'urgent_income' | 'cannot_invest_education' | 'debt_pressure'>
  location: ConstraintDetail<'remote_only' | 'specific_region' | 'no_travel'>
  family: ConstraintDetail<'caregiving' | 'childcare' | 'eldercare'>
  health: ConstraintDetail<'energy_limit' | 'mobility_limit'>
  qualification: ConstraintDetail<'degree_impossible' | 'license_impossible' | 'long_training_impossible'>
}

export type ConstraintType = keyof CareerConstraints

// 제약 조건 UI 옵션
export const CONSTRAINT_OPTIONS: Array<{
  type: ConstraintType
  label: string
  emoji: string
  description: string
  placeholder: string // 상세 입력 힌트
  details: Array<{ value: string; label: string }>
}> = [
  {
    type: 'time',
    label: '시간 제약',
    emoji: '⏰',
    description: '근무 시간에 제약이 있어요',
    placeholder: '예: 저녁 6시까지만 가능, 화목 오전만 가능 등',
    details: [
      { value: 'overtime_no', label: '야근 불가' },
      { value: 'shift_no', label: '교대근무 불가' },
      { value: 'weekend_no', label: '주말 근무 불가' },
      { value: 'parttime_only', label: '파트타임만 가능' },
    ],
  },
  {
    type: 'money',
    label: '경제적 제약',
    emoji: '💵',
    description: '금전적인 상황이 급해요',
    placeholder: '예: 3개월 내 수입 필요, 교육비 50만원 이하만 가능 등',
    details: [
      { value: 'urgent_income', label: '빠른 수입 필요' },
      { value: 'cannot_invest_education', label: '교육비 투자 어려움' },
      { value: 'debt_pressure', label: '부채 부담' },
    ],
  },
  {
    type: 'location',
    label: '장소 제약',
    emoji: '📍',
    description: '근무 장소에 제약이 있어요',
    placeholder: '예: 서울 강남만 가능, 주 2회 재택 필수 등',
    details: [
      { value: 'remote_only', label: '재택만 가능' },
      { value: 'specific_region', label: '특정 지역만 가능' },
      { value: 'no_travel', label: '출장 불가' },
    ],
  },
  {
    type: 'family',
    label: '가족 상황',
    emoji: '👨‍👩‍👧',
    description: '가족 돌봄이 필요해요',
    placeholder: '예: 아이 등원/하원 시간, 간병 스케줄 등',
    details: [
      { value: 'caregiving', label: '돌봄 의무' },
      { value: 'childcare', label: '육아 중' },
      { value: 'eldercare', label: '노인 돌봄' },
    ],
  },
  {
    type: 'health',
    label: '건강/컨디션 제약',
    emoji: '🔋',
    description: '건강상 제약이 있어요',
    placeholder: '예: 장시간 서있기 어려움, 무거운 것 들기 어려움 등',
    details: [
      { value: 'energy_limit', label: '컨디션/에너지 제약' },
      { value: 'mobility_limit', label: '이동/활동 제약' },
    ],
  },
  {
    type: 'qualification',
    label: '자격/학력 제약',
    emoji: '📜',
    description: '자격 취득에 제약이 있어요',
    placeholder: '예: 학위 취득 시간 없음, 자격증 시험 비용 부담 등',
    details: [
      { value: 'degree_impossible', label: '학위 취득 어려움' },
      { value: 'license_impossible', label: '자격증 취득 어려움' },
      { value: 'long_training_impossible', label: '장기 교육 어려움' },
    ],
  },
]

// ============================================
// 비활성화 규칙 (역할에 따른 옵션 제한)
// ============================================
export const ROLE_DISABLED_RULES: Record<RoleIdentity, {
  career_stage: CareerStageYears[]
  transition_status: TransitionStatus[]
  skill_level: SkillLevel[]
}> = {
  // 학생: 중간/시니어 경험, 복귀, 세컨드 커리어 제한
  student: {
    career_stage: ['3_10', '10_plus'],
    transition_status: ['return_work', 'second_career'],
    skill_level: [3, 4], // 고급/마스터 제한
  },
  // 직장인: 특별 제한 없음
  worker: {
    career_stage: [],
    transition_status: ['first_job'],
    skill_level: [],
  },
  // 관리자: 첫 취업 제한
  manager: {
    career_stage: ['none'],
    transition_status: ['first_job'],
    skill_level: [0], // 입문 제한
  },
  // 창업자: 첫 취업 제한
  entrepreneur: {
    career_stage: [],
    transition_status: ['first_job'],
    skill_level: [],
  },
  // 취업/창업 준비생: 특별 제한 없음 (은퇴자, 복귀자 등 다양)
  job_seeker: {
    career_stage: [],
    transition_status: [],
    skill_level: [],
  },
  // 비활성: 특별 제한 없음
  inactive: {
    career_stage: [],
    transition_status: [],
    skill_level: [],
  },
}

// ============================================
// 전공 추천용 학생 유형 (별도 축)
// ============================================
export type MajorStudentType = 
  | 'elementary' // 초등학생
  | 'middle' // 중학생
  | 'high' // 고등학생
  | 'univ_new' // 대학 신입/편입
  | 'univ_change' // 대학 전과/복수전공
  | 'adult_learner' // 성인 학습자

export const MAJOR_STUDENT_OPTIONS: Array<{
  value: MajorStudentType
  label: string
  emoji: string
  description: string
  help: string
}> = [
  {
    value: 'elementary',
    label: '초등학생',
    emoji: '🎒',
    description: '미래 꿈을 탐색 중',
    help: '다양한 분야를 체험하고 꿈을 찾고 싶은 초등학생'
  },
  {
    value: 'middle',
    label: '중학생',
    emoji: '📖',
    description: '진로 방향을 고민 중',
    help: '고등학교 선택을 앞두고 진로 방향을 정하고 싶은 중학생'
  },
  {
    value: 'high',
    label: '고등학생',
    emoji: '🎓',
    description: '대학/전공 선택을 앞둠',
    help: '수시/정시 전공 선택, 또는 취업 진로를 결정해야 하는 고등학생'
  },
  {
    value: 'univ_new',
    label: '대학 진학 예정',
    emoji: '🏫',
    description: '대학 입학/편입 준비 중',
    help: '대학 신입학 또는 편입을 준비하면서 전공을 선택하려는 경우'
  },
  {
    value: 'univ_change',
    label: '전과/복수전공',
    emoji: '🔀',
    description: '현재 대학생, 전공 변경 고민',
    help: '이미 대학에 재학 중이지만 전과, 복수전공, 부전공을 고민하는 경우'
  },
  {
    value: 'adult_learner',
    label: '성인 학습자',
    emoji: '📚',
    description: '사회인/직장인의 학업 복귀',
    help: '직장인 대학원, 사이버대학, 학점은행제, 재입학 등을 고려하는 경우'
  },
]

// ============================================
// 통합: 상태 좌표 (Career State) - 5축
// ============================================
export interface CareerState {
  // 5축 좌표
  role_identity: RoleIdentity
  role_identity_subtype?: RoleIdentitySubtype
  career_stage_years: CareerStageYears
  transition_status: TransitionStatus[] // 다중 선택 가능!
  skill_level: SkillLevel

  // 제약 조건
  constraints: CareerConstraints

  // 전공 추천용 (optional)
  major_student_type?: MajorStudentType

  // 메타데이터
  captured_at: string
  source: 'user_input' | 'resume_parsed' | 'inferred'
}

// ============================================
// 전이 유형 (Transition Types)
// ============================================
export type TransitionType =
  | 'learning' // 학습/교육
  | 'project' // 프로젝트/포트폴리오
  | 'certification' // 자격증 취득
  | 'job_change' // 이직
  | 'promotion' // 승진
  | 'internship' // 인턴/현장실습
  | 'startup' // 창업
  | 'freelance' // 프리랜서 전환
  | 'side_project' // 사이드 프로젝트
  | 'networking' // 네트워킹/멘토링

export type MotivationPrimary = 'growth' | 'income' | 'wlb' | 'meaning' | 'stability' | 'escape'
export type BlockerType = 'time' | 'money' | 'skill' | 'confidence' | 'unknown' | 'family' | 'age'
export type TimelineType = '1m' | '3m' | '6m' | '1y' | '2y' | 'no_rush'

// ============================================
// 전이 신호 (Transition Signal)
// ============================================
export interface TransitionSignal {
  desired_transitions: Array<{
    type: TransitionType
    rank: 1 | 2 | 3
  }>

  motivation: {
    primary: MotivationPrimary
    secondary?: string
  }

  blockers: Array<{
    type: BlockerType
    description?: string
  }>

  timeline: TimelineType

  resources: {
    time_per_week_hours: number
    budget_available: boolean
    support_network: boolean
  }
}

// ============================================
// Step 3 전이 신호 질문 정의
// ============================================
export const TRANSITION_SIGNAL_QUESTIONS = [
  {
    question_id: 'trans_desired_type',
    text: '앞으로 어떤 방식으로 커리어를 발전시키고 싶나요?',
    help: '최대 3개까지 선택할 수 있어요. 선택 순서가 우선순위가 됩니다.',
    ui_type: 'chips' as const,
    max_selections: 3,
    options: [
      { value: 'learning', label: '학습/강의 수강', emoji: '📖' },
      { value: 'project', label: '프로젝트/포트폴리오', emoji: '💼' },
      { value: 'certification', label: '자격증 취득', emoji: '📜' },
      { value: 'job_change', label: '이직', emoji: '🔄' },
      { value: 'promotion', label: '승진/역할 확대', emoji: '📈' },
      { value: 'internship', label: '인턴/현장경험', emoji: '🏢' },
      { value: 'startup', label: '창업', emoji: '🚀' },
      { value: 'freelance', label: '프리랜서', emoji: '💻' },
      { value: 'side_project', label: '사이드 프로젝트', emoji: '🌙' },
      { value: 'networking', label: '네트워킹/멘토링', emoji: '🤝' },
    ],
    fact_key: 'transition.desired_type',
  },
  {
    question_id: 'trans_motivation',
    text: '변화를 원하는 가장 큰 이유는 뭔가요?',
    help: '가장 중요한 동기 하나를 선택해주세요.',
    ui_type: 'radio' as const,
    options: [
      { value: 'growth', label: '성장하고 싶어서', emoji: '🌱' },
      { value: 'income', label: '수입을 늘리고 싶어서', emoji: '💰' },
      { value: 'wlb', label: '워라밸이 필요해서', emoji: '⚖️' },
      { value: 'meaning', label: '의미 있는 일을 하고 싶어서', emoji: '❤️' },
      { value: 'stability', label: '안정이 필요해서', emoji: '🏠' },
      { value: 'escape', label: '현재 상황에서 벗어나고 싶어서', emoji: '🏃' },
    ],
    fact_key: 'transition.motivation_primary',
  },
  {
    question_id: 'trans_blockers',
    text: '커리어 변화에서 가장 걱정되는 건 뭔가요?',
    help: '해당하는 걱정을 모두 선택해주세요.',
    ui_type: 'checkbox' as const,
    options: [
      { value: 'time', label: '시간이 부족해요', emoji: '⏰' },
      { value: 'money', label: '비용이 부담돼요', emoji: '💵' },
      { value: 'skill', label: '실력이 부족할까 봐', emoji: '📚' },
      { value: 'confidence', label: '자신감이 없어요', emoji: '😰' },
      { value: 'unknown', label: '뭘 해야 할지 모르겠어요', emoji: '❓' },
      { value: 'family', label: '가족 상황 때문에', emoji: '👨‍👩‍👧' },
      { value: 'age', label: '나이 때문에', emoji: '📅' },
    ],
    fact_key: 'transition.blocker',
  },
  {
    question_id: 'trans_timeline',
    text: '언제까지 변화가 필요한가요?',
    help: '여유를게 잡아도 괜찮아요. 급할수록 단기 실행 가능한 추천을 드려요.',
    ui_type: 'radio' as const,
    options: [
      { value: '1m', label: '1개월 내', emoji: '🔥' },
      { value: '3m', label: '3개월 내', emoji: '⚡' },
      { value: '6m', label: '6개월 내', emoji: '📆' },
      { value: '1y', label: '1년 내', emoji: '📅' },
      { value: '2y', label: '2년 이상', emoji: '🗓️' },
      { value: 'no_rush', label: '천천히 해도 돼요', emoji: '🐢' },
    ],
    fact_key: 'transition.timeline',
  },
  {
    question_id: 'trans_time_invest',
    text: '일주일에 커리어 개발에 투자할 수 있는 시간은?',
    help: '현실적으로 가능한 시간을 선택해주세요. 추천에 반영돼요.',
    ui_type: 'radio' as const,
    options: [
      { value: '0', label: '거의 없어요', emoji: '😓' },
      { value: '5', label: '5시간 이하', emoji: '⏱️' },
      { value: '10', label: '5~10시간', emoji: '📖' },
      { value: '20', label: '10~20시간', emoji: '💪' },
      { value: '40', label: '20시간 이상 (풀타임)', emoji: '🏃' },
    ],
    fact_key: 'transition.time_invest_hours_bucket',
  },
]

// ============================================
// identity_anchor 질문 패턴 (P1)
// ============================================
export const IDENTITY_ANCHOR_PATTERNS = [
  {
    id: 'anchor_non_negotiable_value',
    question: '일을 하면서 절대 포기하고 싶지 않은 것이 있다면 뭔가요?',
    why_asked: '핵심 가치를 알면 단순 조건 매칭을 넘어 진짜 맞는 직업을 찾을 수 있어요',
    affected_dimensions: ['meaning', 'wlb', 'growth', 'income'],
    options: [
      { value: 'growth_learning', label: '계속 배우고 성장하는 것' },
      { value: 'work_life_balance', label: '개인 시간과 삶의 균형' },
      { value: 'financial_security', label: '경제적 안정과 보상' },
      { value: 'meaningful_impact', label: '의미 있는 일, 사회 기여' },
      { value: 'autonomy_freedom', label: '자율성과 자유' },
      { value: 'relationships', label: '좋은 사람들과 함께하는 것' },
    ],
    fact_key: 'anchor.non_negotiable_value',
  },
  {
    id: 'anchor_desired_emotion',
    question: '일을 통해 어떤 감정을 느끼고 싶으세요?',
    why_asked: '원하는 감정을 알면 표면적인 직업 조건 너머의 적합도를 판단할 수 있어요',
    affected_dimensions: ['meaning', 'growth', 'people_facing'],
    options: [
      { value: 'accomplishment', label: '성취감, 뿌듯함' },
      { value: 'recognition', label: '인정받는 느낌' },
      { value: 'belonging', label: '소속감, 연결됨' },
      { value: 'creativity', label: '창조하는 즐거움' },
      { value: 'peace', label: '평온함, 안정감' },
      { value: 'excitement', label: '도전하는 설렘' },
    ],
    fact_key: 'anchor.desired_emotion',
  },
  {
    id: 'anchor_dealbreaker',
    question: '이것만은 절대 안 된다고 느끼는 상황이 있나요?',
    why_asked: '딜브레이커를 알면 겉으로 좋아 보여도 맞지 않는 직업을 걸러낼 수 있어요',
    affected_dimensions: ['wlb', 'people_facing', 'stability'],
    is_open_text: true,
    placeholder: '예: 매일 야근, 감정 노동, 불안정한 수입, 혼자만 일하는 것...',
    fact_key: 'anchor.dealbreaker',
  },
]

// ============================================
// Default 상태 생성 헬퍼
// ============================================
export function createDefaultCareerState(): CareerState {
  return {
    role_identity: 'worker',
    career_stage_years: '0_3',
    transition_status: ['growth_current'],
    skill_level: 1,
    constraints: {
      time: { has_constraint: false },
      money: { has_constraint: false },
      location: { has_constraint: false },
      family: { has_constraint: false },
      health: { has_constraint: false },
      qualification: { has_constraint: false },
    },
    captured_at: new Date().toISOString(),
    source: 'user_input',
  }
}

export function createDefaultTransitionSignal(): TransitionSignal {
  return {
    desired_transitions: [],
    motivation: { primary: 'growth' },
    blockers: [],
    timeline: '6m',
    resources: {
      time_per_week_hours: 5,
      budget_available: false,
      support_network: false,
    },
  }
}
