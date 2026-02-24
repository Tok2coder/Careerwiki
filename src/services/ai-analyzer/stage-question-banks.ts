// Stage-based Question Banks for AI Analyzer
// Version: v2.0.0-stage-based
// 각 Stage별로 적합한 Follow-up 질문 풀 정의

import type { AnalysisStage } from './universal-questions'
import { isMinorStage, isExperienceAllowed } from './universal-questions'

// ============================================
// Stage Question Types
// ============================================
export type QuestionType = 
  | 'behavior'      // 행동/선호 기반 (경험 가정 X)
  | 'scenario'      // 미니 시나리오/선택
  | 'narrative'     // 서사형 (과거 경험 회고) - 경험 단계만
  | 'tradeoff'      // 트레이드오프 선택
  | 'projection'    // 미래 상상/투사

export interface StageQuestionOption {
  value: string
  label: string
  tags?: string[]
}

export interface StageQuestion {
  question_id: string
  stage_ids: AnalysisStage[]
  type: QuestionType
  text: string
  alt_text?: Partial<Record<AnalysisStage, string>>  // stage별 대체 문구
  ui_type: 'radio' | 'checkbox' | 'text' | 'scale'
  options: StageQuestionOption[]
  allow_unknown: boolean
  fact_key: string
  affects_attributes: string[]
  normalize_rule: 'direct' | 'keywords' | 'lookup'
  // 경험 가정 여부
  requires_experience: boolean
  // 미성년 안전장치
  hide_in_minor: boolean
  privacy_warning?: boolean
}

// ============================================
// POOL: JOB_EXPLORE (탐색 Stage) - 경험 가정 금지
// ============================================
const POOL_JOB_EXPLORE: StageQuestion[] = [
  {
    question_id: 'explore_dream_activity',
    stage_ids: ['job_explore', 'job_student'],
    type: 'projection',
    text: '상상해보세요. 어떤 활동을 하고 있을 때 가장 신나고 시간이 빨리 갈 것 같아요?',
    ui_type: 'checkbox',
    options: [
      { value: 'create', label: '뭔가 새로운 걸 만들기', tags: ['creative'] },
      { value: 'solve', label: '퍼즐이나 문제 풀기', tags: ['analytical'] },
      { value: 'help', label: '사람들 도와주기', tags: ['people_facing', 'empathy'] },
      { value: 'organize', label: '정리하고 계획 세우기', tags: ['structured', 'execution'] },
      { value: 'explore', label: '새로운 것 발견하기', tags: ['growth', 'learning'] },
      { value: 'perform', label: '무대에 서거나 발표하기', tags: ['people_facing'] },
      { value: 'build', label: '직접 손으로 만들기', tags: ['execution', 'physical'] },
      { value: 'research', label: '깊이 파고들어 조사하기', tags: ['analytical', 'solo_deep'] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.dream_activity',
    affects_attributes: ['creative', 'analytical', 'people_facing', 'solo_deep'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'explore_school_subject',
    stage_ids: ['job_explore', 'job_student', 'major_middle', 'major_high'],
    type: 'behavior',
    text: '학교에서 어떤 과목/활동 시간이 가장 기대되나요?',
    ui_type: 'checkbox',
    options: [
      { value: 'math', label: '수학', tags: ['analytical'] },
      { value: 'science', label: '과학', tags: ['analytical', 'research'] },
      { value: 'language', label: '국어/영어', tags: ['communication'] },
      { value: 'social', label: '사회', tags: ['people', 'research'] },
      { value: 'art', label: '미술', tags: ['creative'] },
      { value: 'music', label: '음악', tags: ['creative'] },
      { value: 'pe', label: '체육', tags: ['physical'] },
      { value: 'tech', label: '정보/기술', tags: ['tech', 'analytical'] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.favorite_subject',
    affects_attributes: ['analytical', 'creative', 'people_facing'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'explore_group_role',
    stage_ids: ['job_explore', 'job_student', 'job_prepare'],
    type: 'behavior',
    text: '팀이나 모임에서 보통 어떤 역할을 맡게 되나요?',
    ui_type: 'radio',
    options: [
      { value: 'leader', label: '이끌고 결정하는 역할', tags: ['leadership', 'people_facing'] },
      { value: 'planner', label: '계획하고 정리하는 역할', tags: ['structured', 'analytical'] },
      { value: 'creator', label: '아이디어 내는 역할', tags: ['creative'] },
      { value: 'helper', label: '돕고 지원하는 역할', tags: ['teamwork', 'empathy'] },
      { value: 'executor', label: '실제로 실행하는 역할', tags: ['execution'] },
      { value: 'observer', label: '관찰하고 조언하는 역할', tags: ['analytical', 'solo_deep'] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.group_role',
    affects_attributes: ['teamwork', 'solo_deep', 'people_facing', 'leadership'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'explore_stress_imagined',
    stage_ids: ['job_explore', 'job_student'],
    type: 'projection',
    text: '만약 이런 상황이 생긴다면, 어떤 게 가장 힘들 것 같아요?',
    ui_type: 'checkbox',
    options: [
      { value: 'deadline', label: '마감이 코앞인 상황', tags: ['deadline'] },
      { value: 'presentation', label: '많은 사람 앞에서 발표', tags: ['public_speaking'] },
      { value: 'conflict', label: '팀원과 의견 충돌', tags: ['people'] },
      { value: 'unknown', label: '뭘 해야 할지 명확하지 않은 상황', tags: ['uncertainty'] },
      { value: 'repetition', label: '같은 일 반복', tags: ['routine'] },
      { value: 'alone', label: '혼자서 결정해야 하는 상황', tags: ['autonomy_pressure'] },
    ],
    allow_unknown: true,
    fact_key: 'insight.stress_trigger_imagined',
    affects_attributes: ['wlb', 'solo_deep', 'stability', 'people_facing'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'explore_success_fantasy',
    stage_ids: ['job_explore', 'job_student'],
    type: 'projection',
    text: '미래에 "성공했다"고 느끼려면 어떤 상태여야 할 것 같아요?',
    ui_type: 'radio',
    options: [
      { value: 'famous', label: '유명하거나 영향력 있는 사람이 됨', tags: ['recognition'] },
      { value: 'expert', label: '분야 최고 전문가가 됨', tags: ['growth', 'expertise'] },
      { value: 'rich', label: '경제적으로 풍족함', tags: ['income'] },
      { value: 'balanced', label: '일과 삶이 조화로움', tags: ['wlb'] },
      { value: 'helpful', label: '다른 사람들을 많이 도움', tags: ['meaning', 'people_facing'] },
      { value: 'free', label: '자유롭게 원하는 걸 함', tags: ['autonomy'] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.success_definition',
    affects_attributes: ['growth', 'income', 'wlb', 'stability', 'meaning'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'explore_free_time',
    stage_ids: ['job_explore', 'job_student', 'major_middle', 'major_high'],
    type: 'behavior',
    text: '시간이 남을 때 주로 뭘 하나요?',
    ui_type: 'checkbox',
    options: [
      { value: 'games', label: '게임', tags: ['analytical', 'tech'] },
      { value: 'reading', label: '책/웹소설', tags: ['solo_deep', 'learning'] },
      { value: 'video', label: '영상 보기', tags: ['creative', 'media'] },
      { value: 'social', label: '친구들과 만남', tags: ['people_facing'] },
      { value: 'sports', label: '운동/스포츠', tags: ['physical'] },
      { value: 'hobby', label: '취미 활동 (그림, 음악 등)', tags: ['creative'] },
      { value: 'learn', label: '새로운 것 배우기', tags: ['learning', 'growth'] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.leisure_activity',
    affects_attributes: ['creative', 'analytical', 'people_facing', 'solo_deep'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'explore_ideal_day',
    stage_ids: ['job_explore', 'job_student'],
    type: 'projection',
    text: '미래의 이상적인 하루를 상상해본다면, 어떤 모습일까요?',
    ui_type: 'radio',
    options: [
      { value: 'office_team', label: '사무실에서 팀과 함께 프로젝트', tags: ['team_collab', 'structured'] },
      { value: 'remote_solo', label: '집에서 혼자 집중하며 일', tags: ['solo_deep', 'remote'] },
      { value: 'field_active', label: '현장에서 활동적으로 움직이며', tags: ['physical', 'variety'] },
      { value: 'meeting_people', label: '다양한 사람들 만나며', tags: ['people_facing', 'variety'] },
      { value: 'creative_free', label: '자유롭게 창작하며', tags: ['creative', 'autonomous'] },
    ],
    allow_unknown: true,
    fact_key: 'projection.ideal_workday',
    affects_attributes: ['solo_deep', 'team_collab', 'remote', 'people_facing'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
]

// ============================================
// POOL: JOB_STUDENT (학생 Stage) - 경험 가정 제한적
// ============================================
const POOL_JOB_STUDENT: StageQuestion[] = [
  ...POOL_JOB_EXPLORE.filter(q => q.stage_ids.includes('job_student')),
  {
    question_id: 'student_major_satisfaction',
    stage_ids: ['job_student'],
    type: 'behavior',
    text: '전공 공부를 하면서 어떤 느낌이 드나요?',
    ui_type: 'radio',
    options: [
      { value: 'love', label: '재미있고 더 배우고 싶어요', tags: ['growth', 'passion'] },
      { value: 'okay', label: '나쁘지 않아요', tags: [] },
      { value: 'mismatch', label: '저랑 안 맞는 것 같아요', tags: ['mismatch'] },
      { value: 'unsure', label: '아직 잘 모르겠어요', tags: [] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.major_satisfaction',
    affects_attributes: ['growth'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'student_extracurricular',
    stage_ids: ['job_student'],
    type: 'behavior',
    text: '어떤 대외활동/동아리에 관심이 있거나 참여 중인가요?',
    ui_type: 'checkbox',
    options: [
      { value: 'study', label: '스터디/학술', tags: ['analytical', 'learning'] },
      { value: 'volunteer', label: '봉사/사회공헌', tags: ['meaning', 'people_facing'] },
      { value: 'startup', label: '창업/비즈니스', tags: ['business', 'autonomy'] },
      { value: 'culture', label: '문화/예술', tags: ['creative'] },
      { value: 'sports', label: '운동/스포츠', tags: ['physical', 'teamwork'] },
      { value: 'network', label: '네트워킹/커뮤니티', tags: ['people_facing'] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.extracurricular',
    affects_attributes: ['creative', 'people_facing', 'growth'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
]

// ============================================
// POOL: JOB_PREPARE (취업 준비 Stage)
// ============================================
const POOL_JOB_PREPARE: StageQuestion[] = [
  {
    question_id: 'prepare_job_priority',
    stage_ids: ['job_prepare'],
    type: 'tradeoff',
    text: '첫 직장을 선택할 때 가장 중요하게 볼 것은?',
    ui_type: 'radio',
    options: [
      { value: 'learning', label: '배울 수 있는 환경', tags: ['growth'] },
      { value: 'salary', label: '초봉/연봉', tags: ['income'] },
      { value: 'company', label: '회사 이름/안정성', tags: ['stability'] },
      { value: 'culture', label: '조직문화/워라밸', tags: ['wlb'] },
      { value: 'field', label: '하고 싶은 분야', tags: ['passion'] },
    ],
    allow_unknown: true,
    fact_key: 'priority.first_job',
    affects_attributes: ['growth', 'income', 'stability', 'wlb'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'prepare_company_size',
    stage_ids: ['job_prepare', 'job_early'],
    type: 'behavior',
    text: '어떤 규모의 회사가 더 끌리나요?',
    ui_type: 'radio',
    options: [
      { value: 'large', label: '대기업 (체계적, 안정적)', tags: ['stability', 'structured'] },
      { value: 'mid', label: '중견기업 (균형)', tags: [] },
      { value: 'small', label: '스타트업/소기업 (자유, 성장)', tags: ['growth', 'autonomous', 'flexible'] },
      { value: 'public', label: '공기업/공공기관', tags: ['stability', 'wlb'] },
    ],
    allow_unknown: true,
    fact_key: 'preference.company_size',
    affects_attributes: ['stability', 'growth', 'wlb'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'prepare_salary_vs_growth',
    stage_ids: ['job_prepare', 'job_early'],
    type: 'tradeoff',
    text: '초봉이 낮지만 성장 기회가 큰 곳 vs 초봉이 높지만 성장이 더딘 곳?',
    ui_type: 'radio',
    options: [
      { value: 'growth', label: '성장 기회가 큰 쪽', tags: ['growth'] },
      { value: 'salary', label: '초봉이 높은 쪽', tags: ['income'] },
      { value: 'depends', label: '상황에 따라', tags: [] },
    ],
    allow_unknown: true,
    fact_key: 'tradeoff.salary_vs_growth',
    affects_attributes: ['growth', 'income'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
]

// ============================================
// POOL: JOB_EARLY / JOB_MID (경력자 Stage) - 경험 가정 허용
// ============================================
const POOL_JOB_CAREER: StageQuestion[] = [
  {
    question_id: 'career_best_moment',
    stage_ids: ['job_early', 'job_mid', 'job_transition'],
    type: 'narrative',
    text: '지금까지 일하면서 가장 보람 있었던 순간은 언제였나요?',
    alt_text: {
      'job_transition': '이전 직장에서 가장 보람 있었던 순간은?',
    },
    ui_type: 'text',
    options: [],
    allow_unknown: true,
    fact_key: 'discovery.best_moment',
    affects_attributes: ['creative', 'analytical', 'people_facing', 'growth'],
    normalize_rule: 'keywords',
    requires_experience: true,
    hide_in_minor: true,
    privacy_warning: true,
  },
  {
    question_id: 'career_worst_moment',
    stage_ids: ['job_early', 'job_mid', 'job_transition'],
    type: 'narrative',
    text: '반대로, 가장 힘들었거나 "이건 안 맞는다"고 느꼈던 순간은요?',
    ui_type: 'text',
    options: [],
    allow_unknown: true,
    fact_key: 'discovery.worst_moment',
    affects_attributes: ['wlb', 'solo_deep', 'people_facing'],
    normalize_rule: 'keywords',
    requires_experience: true,
    hide_in_minor: true,
    privacy_warning: true,
  },
  {
    question_id: 'career_growth_vs_stability',
    stage_ids: ['job_early', 'job_mid', 'job_prepare'],
    type: 'tradeoff',
    text: '성장 기회가 많지만 불안정한 환경 vs 느리지만 안정적인 환경, 어느 쪽이 더 끌리나요?',
    ui_type: 'radio',
    options: [
      { value: 'growth', label: '성장 기회가 많은 쪽', tags: ['growth'] },
      { value: 'stability', label: '안정적인 쪽', tags: ['stability'] },
      { value: 'depends', label: '상황에 따라 다름', tags: [] },
    ],
    allow_unknown: true,
    fact_key: 'tradeoff.growth_vs_stability',
    affects_attributes: ['growth', 'stability'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'career_salary_vs_wlb',
    stage_ids: ['job_early', 'job_mid', 'job_prepare', 'job_transition'],
    type: 'tradeoff',
    text: '연봉 30% 높은데 야근 있는 회사 vs 연봉 낮지만 칼퇴 보장, 어느 쪽?',
    ui_type: 'radio',
    options: [
      { value: 'salary', label: '연봉 높은 쪽', tags: ['income'] },
      { value: 'wlb', label: '칼퇴 보장되는 쪽', tags: ['wlb'] },
      { value: 'depends', label: '상황에 따라 다름', tags: [] },
    ],
    allow_unknown: true,
    fact_key: 'tradeoff.salary_vs_wlb',
    affects_attributes: ['wlb', 'income'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'career_current_challenge',
    stage_ids: ['job_early', 'job_mid'],
    type: 'narrative',
    text: '현재 커리어에서 가장 바꾸고 싶거나 해결하고 싶은 문제는 뭔가요?',
    ui_type: 'text',
    options: [],
    allow_unknown: true,
    fact_key: 'motivation.change_reason',
    affects_attributes: ['growth', 'income', 'wlb', 'stability'],
    normalize_rule: 'keywords',
    requires_experience: true,
    hide_in_minor: true,
    privacy_warning: true,
  },
  {
    question_id: 'career_strength_at_work',
    stage_ids: ['job_early', 'job_mid'],
    type: 'behavior',
    text: '업무에서 가장 인정받거나 잘한다고 느끼는 부분은?',
    ui_type: 'checkbox',
    options: [
      { value: 'analysis', label: '분석/문제해결', tags: ['analytical'] },
      { value: 'communication', label: '소통/협업', tags: ['people_facing', 'team_collab'] },
      { value: 'execution', label: '실행력/추진력', tags: ['execution'] },
      { value: 'creativity', label: '창의적 아이디어', tags: ['creative'] },
      { value: 'leadership', label: '리더십/조율', tags: ['leadership'] },
      { value: 'detail', label: '꼼꼼함/정확성', tags: ['structured'] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.work_strength',
    affects_attributes: ['analytical', 'creative', 'people_facing', 'leadership'],
    normalize_rule: 'direct',
    requires_experience: true,
    hide_in_minor: true,
  },
]

// ============================================
// POOL: JOB_TRANSITION (전환/복귀 Stage)
// ============================================
const POOL_JOB_TRANSITION: StageQuestion[] = [
  ...POOL_JOB_CAREER.filter(q => q.stage_ids.includes('job_transition')),
  {
    question_id: 'transition_reason',
    stage_ids: ['job_transition'],
    type: 'narrative',
    text: '커리어 전환/복귀를 생각하게 된 가장 큰 이유는 뭔가요?',
    ui_type: 'text',
    options: [],
    allow_unknown: true,
    fact_key: 'motivation.transition_reason',
    affects_attributes: ['growth', 'stability', 'wlb'],
    normalize_rule: 'keywords',
    requires_experience: true,
    hide_in_minor: true,
    privacy_warning: true,
  },
  {
    question_id: 'transition_keep',
    stage_ids: ['job_transition', 'job_second'],
    type: 'behavior',
    text: '이전 경험에서 꼭 유지하고 싶은 것이 있다면요?',
    ui_type: 'checkbox',
    options: [
      { value: 'skills', label: '쌓아온 전문 기술', tags: ['expertise'] },
      { value: 'network', label: '인맥/네트워크', tags: ['people'] },
      { value: 'routine', label: '익숙한 업무 방식', tags: ['stability'] },
      { value: 'industry', label: '같은 업계', tags: ['industry'] },
      { value: 'nothing', label: '새로 시작하고 싶음', tags: ['growth', 'change'] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.keep_from_past',
    affects_attributes: ['stability', 'growth'],
    normalize_rule: 'direct',
    requires_experience: true,
    hide_in_minor: true,
  },
  {
    question_id: 'transition_constraint_special',
    stage_ids: ['job_transition', 'job_second'],
    type: 'behavior',
    text: '전환/복귀에 특별히 고려해야 할 상황이 있나요?',
    ui_type: 'checkbox',
    options: [
      { value: 'caregiving', label: '가족 돌봄 필요', tags: ['time_constraint', 'caregiving'] },
      { value: 'health', label: '건강 상 제약', tags: ['physical_constraint', 'health'] },
      { value: 'location', label: '지역 제한', tags: ['location_constraint'] },
      { value: 'financial', label: '수입 유지 필수', tags: ['income_constraint', 'income'] },
      { value: 'learning', label: '새 기술 배울 시간 필요', tags: ['learning_constraint', 'growth'] },
    ],
    allow_unknown: true,
    fact_key: 'profile.special_constraints',
    affects_attributes: ['wlb', 'remote', 'stability', 'income'],
    normalize_rule: 'direct',
    requires_experience: false,  // 상황 관련이므로 경험 불필요
    hide_in_minor: false,
  },
]

// ============================================
// POOL: JOB_SECOND (세컨드 커리어 Stage)
// ============================================
const POOL_JOB_SECOND: StageQuestion[] = [
  ...POOL_JOB_TRANSITION.filter(q => q.stage_ids.includes('job_second')),
  {
    question_id: 'second_motivation',
    stage_ids: ['job_second'],
    type: 'behavior',
    text: '새로운 일을 시작하려는 가장 큰 동기는 뭔가요?',
    ui_type: 'radio',
    options: [
      { value: 'income', label: '경제적 필요', tags: ['income'] },
      { value: 'meaning', label: '의미 있는 활동', tags: ['meaning'] },
      { value: 'social', label: '사회적 연결', tags: ['people_facing'] },
      { value: 'health', label: '건강/활력 유지', tags: ['physical'] },
      { value: 'legacy', label: '경험 전수/가르침', tags: ['teaching'] },
    ],
    allow_unknown: true,
    fact_key: 'motivation.second_career',
    affects_attributes: ['income', 'meaning', 'people_facing'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'second_time_commitment',
    stage_ids: ['job_second'],
    type: 'behavior',
    text: '일에 어느 정도 시간을 투자할 수 있나요?',
    ui_type: 'radio',
    options: [
      { value: 'fulltime', label: '풀타임 가능', tags: ['fulltime'] },
      { value: 'parttime', label: '파트타임(주 20시간 이하)', tags: ['parttime', 'wlb'] },
      { value: 'flexible', label: '유연하게 조절', tags: ['flexible'] },
      { value: 'project', label: '프로젝트성으로만', tags: ['project', 'flexible'] },
    ],
    allow_unknown: true,
    fact_key: 'profile.time_commitment',
    affects_attributes: ['wlb', 'remote', 'flexible'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
]

// ============================================
// POOL: MAJOR (전공 추천용) - 경험 가정 금지
// ============================================
const POOL_MAJOR_COMMON: StageQuestion[] = [
  {
    question_id: 'major_favorite_subject',
    stage_ids: ['major_elementary', 'major_middle', 'major_high', 'major_freshman', 'major_student', 'major_graduate'],
    type: 'behavior',
    text: '가장 재미있거나 잘하는 과목은 뭔가요?',
    ui_type: 'checkbox',
    options: [
      { value: 'korean', label: '국어', tags: ['communication', 'creative'] },
      { value: 'math', label: '수학', tags: ['analytical'] },
      { value: 'english', label: '영어', tags: ['communication', 'global'] },
      { value: 'science', label: '과학', tags: ['analytical', 'research'] },
      { value: 'social', label: '사회/역사', tags: ['research', 'people'] },
      { value: 'art', label: '미술', tags: ['creative'] },
      { value: 'music', label: '음악', tags: ['creative'] },
      { value: 'pe', label: '체육', tags: ['physical'] },
      { value: 'tech', label: '정보/기술', tags: ['tech', 'analytical'] },
    ],
    allow_unknown: true,
    fact_key: 'discovery.favorite_subject',
    affects_attributes: ['analytical', 'creative', 'people_facing'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
  {
    question_id: 'major_dream_job',
    stage_ids: ['major_elementary', 'major_middle', 'major_high', 'major_freshman', 'major_student', 'major_graduate'],
    type: 'projection',
    text: '미래에 어떤 일을 하고 싶나요? (여러 개 선택 가능)',
    ui_type: 'checkbox',
    options: [
      { value: 'doctor', label: '의사/간호사', tags: ['health', 'people_facing'] },
      { value: 'teacher', label: '선생님', tags: ['teaching', 'people_facing'] },
      { value: 'engineer', label: '엔지니어/개발자', tags: ['tech', 'analytical'] },
      { value: 'artist', label: '예술가/창작자', tags: ['creative'] },
      { value: 'business', label: '사업가', tags: ['business', 'leadership'] },
      { value: 'scientist', label: '과학자/연구원', tags: ['research', 'analytical'] },
      { value: 'athlete', label: '운동선수', tags: ['physical'] },
      { value: 'celebrity', label: '연예인/인플루언서', tags: ['people_facing', 'creative'] },
      { value: 'unsure', label: '아직 모르겠어요', tags: [] },
    ],
    allow_unknown: true,
    fact_key: 'projection.dream_job',
    affects_attributes: ['analytical', 'creative', 'people_facing', 'growth'],
    normalize_rule: 'direct',
    requires_experience: false,
    hide_in_minor: false,
  },
]

// ============================================
// All Questions 통합
// ============================================
export const STAGE_QUESTION_BANK: StageQuestion[] = [
  ...POOL_JOB_EXPLORE,
  ...POOL_JOB_STUDENT,
  ...POOL_JOB_PREPARE,
  ...POOL_JOB_CAREER,
  ...POOL_JOB_TRANSITION,
  ...POOL_JOB_SECOND,
  ...POOL_MAJOR_COMMON,
]

// ============================================
// Helper Functions
// ============================================

/**
 * Stage에 맞는 질문 풀 반환
 */
export function getQuestionsForStage(stage: AnalysisStage): StageQuestion[] {
  const isMinor = isMinorStage(stage)
  const expAllowed = isExperienceAllowed(stage)
  
  return STAGE_QUESTION_BANK.filter(q => {
    // 1. stage 매칭
    if (!q.stage_ids.includes(stage)) return false
    
    // 2. 미성년 단계에서는 hide_in_minor 제외
    if (isMinor && q.hide_in_minor) return false
    
    // 3. 경험 가정 질문은 경험 허용 단계에서만
    if (q.requires_experience && !expAllowed) return false
    
    return true
  })
}

/**
 * 질문 텍스트 가져오기 (stage별 대체 문구 반영)
 */
export function getQuestionText(question: StageQuestion, stage: AnalysisStage): string {
  if (question.alt_text && question.alt_text[stage]) {
    return question.alt_text[stage]!
  }
  return question.text
}

/**
 * 특정 fact_key를 가진 질문 찾기
 */
export function findQuestionByFactKey(factKey: string): StageQuestion | undefined {
  return STAGE_QUESTION_BANK.find(q => q.fact_key === factKey)
}

/**
 * 질문 풀에서 특정 타입만 필터링
 */
export function filterQuestionsByType(
  questions: StageQuestion[],
  types: QuestionType[]
): StageQuestion[] {
  return questions.filter(q => types.includes(q.type))
}








