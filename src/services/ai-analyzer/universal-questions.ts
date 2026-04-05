// Universal Questions for Stage-based AI Analyzer
// Version: v2.0.0-stage-based
// 경험 가정 없이 모든 유저가 답할 수 있는 질문만 포함

// ============================================
// Stage 정의
// ============================================
export const JOB_STAGES = [
  'job_explore',     // 탐색 (경험 거의 없음)
  'job_student',     // 전공/진학 연계 (학생)
  'job_prepare',     // 취업 준비
  'job_early',       // 초기 커리어 (0~3y)
  'job_mid',         // 경력자 (3y+)
  'job_transition',  // 전환/복귀
  'job_second',      // 세컨드 커리어/은퇴 이후
] as const

export const MAJOR_STAGES = [
  'major_child',       // 어린이 (8~12)
  'major_elementary',  // 초등 (10~13)
  'major_middle',      // 중등 (13~16)
  'major_high',        // 고등 (16~19)
  'major_freshman',    // 대학 신입생 (전공 탐색)
  'major_student',     // 대학 재학생 (전과/복수전공)
  'major_graduate',    // 대학원 진학 (석/박사)
  'major_transfer',    // 대학 (전과/복수) - legacy
] as const

export type JobStage = typeof JOB_STAGES[number]
export type MajorStage = typeof MAJOR_STAGES[number]
export type AnalysisStage = JobStage | MajorStage

// 미성년/탐색 단계 (오픈텍스트 제한)
export const MINOR_STAGES: AnalysisStage[] = [
  'major_child', 'major_elementary', 'major_middle', 'job_explore'
]

// 경험 가정 허용 단계
export const EXPERIENCE_ALLOWED_STAGES: AnalysisStage[] = [
  'job_early', 'job_mid', 'job_transition', 'job_second'
]

// ============================================
// Life Constraints Flag (상황 플래그)
// ============================================
export const LIFE_CONSTRAINT_FLAGS = [
  'none',           // 해당 없음
  'health',         // 건강 상 제약
  'disability',     // 장애
  'caregiving',     // 돌봄 (가족/자녀)
  'military',       // 군 복무 관련
  'finance_pressure', // 경제적 압박
] as const

export type LifeConstraintFlag = typeof LIFE_CONSTRAINT_FLAGS[number]

// ============================================
// Universal Question Types
// ============================================
export interface UniversalQuestionOption {
  value: string
  label: string
  emoji?: string
  tags?: string[]  // fact-score-mapping에서 사용할 태그
}

export interface UniversalQuestion {
  question_id: string
  order: number
  text: string
  ui_type: 'checkbox' | 'radio' | 'text' | 'slider' | 'chips'
  options?: UniversalQuestionOption[]
  allow_unknown: boolean
  unknown_label?: string
  fact_key: string
  required: boolean
  placeholder?: string
  hint?: string
  normalize_rule: 'direct' | 'keywords' | 'lookup' | 'none'
  max_selections?: number
  // 미성년 안전장치
  hide_in_minor_stages?: boolean
  privacy_warning?: boolean
}

// ============================================
// Universal Question Set (12 + 상황플래그 2개 = 14문항)
// 경험 가정 없이 모든 유저가 답변 가능
// ============================================
export const UNIVERSAL_QUESTIONS: UniversalQuestion[] = [
  // ============================================
  // 1. 관심/흥미 (필수)
  // ============================================
  {
    question_id: 'univ_interest',
    order: 1,
    text: '어떤 것에 관심이 있거나 재미있다고 느끼나요?',
    ui_type: 'chips',
    options: [
      { value: 'tech', label: '기술/IT', emoji: '💻', tags: ['analytical', 'tech'] },
      { value: 'art', label: '예술/창작', emoji: '🎨', tags: ['creative'] },
      { value: 'people', label: '사람/소통', emoji: '👥', tags: ['people_facing'] },
      { value: 'nature', label: '자연/환경', emoji: '🌿', tags: ['outdoor', 'impact'] },
      { value: 'numbers', label: '숫자/분석', emoji: '📊', tags: ['analytical'] },
      { value: 'health', label: '건강/의료', emoji: '🏥', tags: ['people_facing', 'impact'] },
      { value: 'business', label: '비즈니스', emoji: '💼', tags: ['business', 'execution'] },
      { value: 'education', label: '교육/가르침', emoji: '📚', tags: ['teaching', 'people_facing'] },
      { value: 'sports', label: '스포츠/활동', emoji: '⚽', tags: ['physical', 'outdoor'] },
      { value: 'media', label: '미디어/콘텐츠', emoji: '📱', tags: ['creative', 'tech'] },
    ],
    allow_unknown: true,
    unknown_label: '잘 모르겠어요',
    fact_key: 'profile.interest.keywords',
    required: true,
    hint: '여러 개 선택 가능 (최대 5개)',
    normalize_rule: 'direct',
    max_selections: 5,
  },

  // ============================================
  // 2. 싫어함/회피 (필수)
  // ============================================
  {
    question_id: 'univ_dislike',
    order: 2,
    text: '이건 피하고 싶다고 느끼는 게 있나요?',
    ui_type: 'chips',
    options: [
      { value: 'overtime', label: '야근/긴 근무', emoji: '🌙', tags: ['work_hours_strict'] },
      { value: 'meeting', label: '회의 많음', emoji: '🗣️', tags: ['meeting'] },
      { value: 'sales', label: '영업/설득', emoji: '🤝', tags: ['sales'] },
      { value: 'routine', label: '단순 반복', emoji: '🔄', tags: ['routine'] },
      { value: 'pressure', label: '압박/마감', emoji: '⏰', tags: ['deadline'] },
      { value: 'travel', label: '잦은 출장', emoji: '✈️', tags: ['travel'] },
      { value: 'physical', label: '육체적 힘듦', emoji: '💪', tags: ['physical'] },
      { value: 'conflict', label: '갈등/대립', emoji: '⚡', tags: ['conflict'] },
      { value: 'public', label: '발표/앞에 서기', emoji: '🎤', tags: ['public_speaking'] },
      { value: 'uncertainty', label: '불확실함', emoji: '❓', tags: ['uncertainty'] },
    ],
    allow_unknown: true,
    unknown_label: '딱히 없어요',
    fact_key: 'profile.dislike.keywords',
    required: true,
    hint: '여러 개 선택 가능 (최대 5개)',
    normalize_rule: 'direct',
    max_selections: 5,
  },

  // ============================================
  // 3. 작업 방식 - 혼자 vs 함께 (필수)
  // ============================================
  {
    question_id: 'univ_workstyle_social',
    order: 3,
    text: '뭔가를 할 때, 어떤 방식이 더 편한가요?',
    ui_type: 'radio',
    options: [
      { value: 'solo', label: '혼자 집중하는 게 좋아요', emoji: '🧘', tags: ['solo_deep'] },
      { value: 'team', label: '여럿이 함께하는 게 좋아요', emoji: '👫', tags: ['team_collab'] },
      { value: 'mixed', label: '상황에 따라 달라요', emoji: '🔀', tags: [] },
    ],
    allow_unknown: true,
    unknown_label: '모르겠어요',
    fact_key: 'profile.workstyle.social',
    required: true,
    normalize_rule: 'direct',
  },

  // ============================================
  // 4. 작업 방식 - 구조 vs 자유 (필수)
  // ============================================
  {
    question_id: 'univ_workstyle_structure',
    order: 4,
    text: '일이나 공부할 때, 어떤 환경이 더 맞나요?',
    ui_type: 'radio',
    options: [
      { value: 'structured', label: '정해진 규칙/절차가 있는 게 좋아요', emoji: '📋', tags: ['structured'] },
      { value: 'flexible', label: '자유롭게 스스로 정하는 게 좋아요', emoji: '🦋', tags: ['flexible', 'autonomous'] },
      { value: 'mixed', label: '상황에 따라 달라요', emoji: '🔀', tags: [] },
    ],
    allow_unknown: true,
    unknown_label: '모르겠어요',
    fact_key: 'profile.workstyle.structure',
    required: true,
    normalize_rule: 'direct',
  },

  // ============================================
  // 5. 우선순위/가치 (필수)
  // ============================================
  {
    question_id: 'univ_priority',
    order: 5,
    text: '일(또는 미래 직업)에서 가장 중요하게 생각하는 건 뭔가요?',
    ui_type: 'radio',
    options: [
      { value: 'growth', label: '배우고 성장하는 것', emoji: '🌱', tags: ['growth'] },
      { value: 'stability', label: '안정적이고 예측 가능한 것', emoji: '🏠', tags: ['stability'] },
      { value: 'wlb', label: '일과 생활의 균형', emoji: '⚖️', tags: ['wlb'] },
      { value: 'income', label: '높은 수입', emoji: '💰', tags: ['income'] },
      { value: 'meaning', label: '의미 있는 일, 사회 기여', emoji: '🌍', tags: ['meaning', 'impact'] },
      { value: 'recognition', label: '인정받고 영향력 발휘', emoji: '⭐', tags: ['recognition'] },
    ],
    allow_unknown: true,
    unknown_label: '아직 모르겠어요',
    fact_key: 'priority.top1',
    required: true,
    normalize_rule: 'direct',
  },

  // ============================================
  // 6~8. 제약조건 질문들 - Step 1에서 이미 입력받으므로 제거됨
  // (시간/근무, 장소/이동, 자격/학력은 Step 1 "5축 - 제약조건"에서 처리)
  // ============================================

  // ============================================
  // 9. 강점/잘하는 것 (선택)
  // ============================================
  {
    question_id: 'univ_strength',
    order: 9,
    text: '스스로 잘한다고 느끼거나, 남들이 인정해준 적 있는 것이 있나요?',
    ui_type: 'chips',
    options: [
      { value: 'analysis', label: '분석/논리', emoji: '🧠', tags: ['analytical'] },
      { value: 'creative', label: '창의/아이디어', emoji: '💡', tags: ['creative'] },
      { value: 'communication', label: '소통/설명', emoji: '💬', tags: ['people_facing'] },
      { value: 'organization', label: '정리/계획', emoji: '📑', tags: ['structured', 'execution'] },
      { value: 'persistence', label: '끈기/인내', emoji: '🏋️', tags: ['persistence'] },
      { value: 'learning', label: '빠른 학습', emoji: '📖', tags: ['learning'] },
      { value: 'empathy', label: '공감/배려', emoji: '❤️', tags: ['empathy', 'people_facing'] },
      { value: 'leadership', label: '리더십', emoji: '👑', tags: ['leadership'] },
    ],
    allow_unknown: true,
    unknown_label: '잘 모르겠어요',
    fact_key: 'profile.strength.keywords',
    required: false,
    hint: '여러 개 선택 가능 (최대 4개)',
    normalize_rule: 'direct',
    max_selections: 4,
  },

  // ============================================
  // 10. 에너지 충전 방식 (선택)
  // ============================================
  {
    question_id: 'univ_energy',
    order: 10,
    text: '쉴 때 에너지를 어떻게 충전하나요?',
    ui_type: 'radio',
    options: [
      { value: 'alone', label: '혼자 조용히', emoji: '🏡', tags: ['solo'] },
      { value: 'people', label: '사람들과 함께', emoji: '🎉', tags: ['people'] },
      { value: 'activity', label: '활동적으로 움직이며', emoji: '🏃', tags: ['active'] },
      { value: 'creative', label: '무언가 만들면서', emoji: '🎨', tags: ['creative'] },
    ],
    allow_unknown: true,
    unknown_label: '그때그때 달라요',
    fact_key: 'discovery.energy_source',
    required: false,
    normalize_rule: 'direct',
  },

  // ============================================
  // 11. 환경 선호 (선택)
  // ============================================
  {
    question_id: 'univ_environment',
    order: 11,
    text: '어떤 환경에서 더 잘 집중할 수 있나요?',
    ui_type: 'radio',
    options: [
      { value: 'quiet', label: '조용하고 정돈된 곳', emoji: '🏢', tags: ['quiet', 'structured'] },
      { value: 'dynamic', label: '활기차고 변화가 있는 곳', emoji: '🎪', tags: ['dynamic', 'fast_paced'] },
      { value: 'outdoor', label: '야외/자연 속', emoji: '🏕️', tags: ['outdoor'] },
      { value: 'flexible', label: '여러 곳을 옮겨 다니며', emoji: '🚀', tags: ['flexible', 'variety'] },
    ],
    allow_unknown: true,
    unknown_label: '상관없어요',
    fact_key: 'profile.environment_pref',
    required: false,
    normalize_rule: 'direct',
  },

  // ============================================
  // 12. 상황 플래그 1 - 특수 상황 (선택)
  // [수정사항 1] life_constraints_flag 추가
  // ============================================
  {
    question_id: 'univ_life_constraint',
    order: 12,
    text: '현재 특별히 고려해야 할 상황이 있나요?',
    ui_type: 'checkbox',
    options: [
      { value: 'health', label: '건강 상 제약', emoji: '🏥', tags: ['health'] },
      { value: 'disability', label: '장애', emoji: '♿', tags: ['disability'] },
      { value: 'caregiving', label: '돌봄 (가족/자녀)', emoji: '👨‍👩‍👧', tags: ['caregiving', 'time_constraint'] },
      { value: 'military', label: '군 복무 관련', emoji: '🎖️', tags: ['military'] },
      { value: 'finance_pressure', label: '경제적 압박', emoji: '💵', tags: ['finance_pressure', 'income_important'] },
    ],
    allow_unknown: true,
    unknown_label: '해당 없음',
    fact_key: 'profile.life_constraint',
    required: false,
    hint: '해당되는 것만 선택하세요 (선택)',
    normalize_rule: 'direct',
  },

  // ============================================
  // 13. 상황 플래그 2 - 시간 여유 (선택)
  // ============================================
  {
    question_id: 'univ_time_availability',
    order: 13,
    text: '준비/학습에 투자할 수 있는 시간이 어느 정도인가요?',
    ui_type: 'radio',
    options: [
      { value: 'plenty', label: '충분히 있어요 (1년 이상)', emoji: '⏳', tags: ['time_plenty'] },
      { value: 'moderate', label: '어느 정도 있어요 (6개월~1년)', emoji: '⏰', tags: ['time_moderate'] },
      { value: 'limited', label: '별로 없어요 (6개월 미만)', emoji: '⚡', tags: ['time_limited'] },
      { value: 'urgent', label: '당장 필요해요', emoji: '🔥', tags: ['time_urgent'] },
    ],
    allow_unknown: true,
    unknown_label: '모르겠어요',
    fact_key: 'profile.time_availability',
    required: false,
    normalize_rule: 'direct',
  },

  // ============================================
  // 14. 추가 메모 (선택, 오픈 텍스트)
  // [수정사항 3] 미성년 단계에서는 숨김
  // ============================================
  {
    question_id: 'univ_freetext',
    order: 14,
    text: '추천에 반영되었으면 하는 다른 조건이 있나요?',
    ui_type: 'text',
    allow_unknown: true,
    fact_key: 'profile.freetext',
    required: false,
    placeholder: '예: 오래 앉아있기 어려워요, 저녁은 꼭 비워야 해요...',
    hint: '자유롭게 적어주세요 (선택)',
    normalize_rule: 'keywords',
    // [수정사항 3] 미성년 단계에서는 숨김 + 경고 표시
    hide_in_minor_stages: true,
    privacy_warning: true,
  },
]

// ============================================
// Stage 메타데이터
// ============================================
export interface StageMetadata {
  stage_id: AnalysisStage
  label: string
  description: string
  emoji: string
  target_age?: string
  experience_allowed: boolean
  question_pool: string
}

export const JOB_STAGE_METADATA: StageMetadata[] = [
  {
    stage_id: 'job_explore',
    label: '탐색 단계',
    description: '아직 경험이 거의 없어요',
    emoji: '🔍',
    target_age: '13~19',
    experience_allowed: false,
    question_pool: 'POOL_JOB_EXPLORE',
  },
  {
    stage_id: 'job_student',
    label: '학생 (전공 연계)',
    description: '현재 학생이에요',
    emoji: '🎓',
    target_age: '16~26',
    experience_allowed: false,
    question_pool: 'POOL_JOB_STUDENT',
  },
  {
    stage_id: 'job_prepare',
    label: '취업 준비 중',
    description: '곧 취업 예정이에요',
    emoji: '📝',
    target_age: '20~30',
    experience_allowed: false,  // 제한적
    question_pool: 'POOL_JOB_PREPARE',
  },
  {
    stage_id: 'job_early',
    label: '초기 커리어 (0~3년)',
    description: '일 시작한 지 얼마 안 됐어요',
    emoji: '🌱',
    target_age: '23~32',
    experience_allowed: true,
    question_pool: 'POOL_JOB_EARLY',
  },
  {
    stage_id: 'job_mid',
    label: '경력자 (3년+)',
    description: '경력이 좀 쌓였어요',
    emoji: '🚀',
    target_age: '28~50',
    experience_allowed: true,
    question_pool: 'POOL_JOB_MID',
  },
  {
    stage_id: 'job_transition',
    label: '전환/복귀',
    description: '업종 전환 또는 재취업',
    emoji: '🔄',
    target_age: '30~55',
    experience_allowed: true,
    question_pool: 'POOL_JOB_TRANSITION',
  },
  {
    stage_id: 'job_second',
    label: '세컨드 커리어',
    description: '은퇴 후 새 시작',
    emoji: '🌅',
    target_age: '50~70+',
    experience_allowed: true,
    question_pool: 'POOL_JOB_SECOND',
  },
]

export const MAJOR_STAGE_METADATA: StageMetadata[] = [
  {
    stage_id: 'major_child',
    label: '어린이',
    description: '꿈 탐색 시작',
    emoji: '🧒',
    target_age: '8~12',
    experience_allowed: false,
    question_pool: 'POOL_MAJOR_CHILD',
  },
  {
    stage_id: 'major_elementary',
    label: '초등학생',
    description: '관심사 발견 단계',
    emoji: '📕',
    target_age: '10~13',
    experience_allowed: false,
    question_pool: 'POOL_MAJOR_ELEMENTARY',
  },
  {
    stage_id: 'major_middle',
    label: '중학생',
    description: '적성 탐색, 고교 선택 연계',
    emoji: '📗',
    target_age: '13~16',
    experience_allowed: false,
    question_pool: 'POOL_MAJOR_MIDDLE',
  },
  {
    stage_id: 'major_high',
    label: '고등학생',
    description: '대입 준비, 전공 선택',
    emoji: '📘',
    target_age: '16~19',
    experience_allowed: false,
    question_pool: 'POOL_MAJOR_HIGH',
  },
  {
    stage_id: 'major_freshman',
    label: '대학 신입생',
    description: '전공 탐색 중',
    emoji: '🎓',
    target_age: '19~20',
    experience_allowed: false,
    question_pool: 'POOL_MAJOR_TRANSFER',
  },
  {
    stage_id: 'major_student',
    label: '대학 재학생',
    description: '전과/복수전공 고려',
    emoji: '📚',
    target_age: '20~26',
    experience_allowed: false,
    question_pool: 'POOL_MAJOR_TRANSFER',
  },
  {
    stage_id: 'major_graduate',
    label: '대학원 진학',
    description: '석/박사 준비',
    emoji: '🔬',
    target_age: '22~30',
    experience_allowed: true,
    question_pool: 'POOL_MAJOR_TRANSFER',
  },
  {
    stage_id: 'major_transfer',
    label: '대학생 (전과/복수)',
    description: '현재 대학생, 전과/복수전공',
    emoji: '🎓',
    target_age: '19~26',
    experience_allowed: false,  // 제한적
    question_pool: 'POOL_MAJOR_TRANSFER',
  },
]

// ============================================
// Helper Functions
// ============================================
export function isValidJobStage(stage: string): stage is JobStage {
  return JOB_STAGES.includes(stage as JobStage)
}

export function isValidMajorStage(stage: string): stage is MajorStage {
  return MAJOR_STAGES.includes(stage as MajorStage)
}

export function isValidStage(stage: string): stage is AnalysisStage {
  return isValidJobStage(stage) || isValidMajorStage(stage)
}

export function isMinorStage(stage: AnalysisStage): boolean {
  return MINOR_STAGES.includes(stage)
}

export function isExperienceAllowed(stage: AnalysisStage): boolean {
  return EXPERIENCE_ALLOWED_STAGES.includes(stage)
}

export function getStageMetadata(stage: AnalysisStage): StageMetadata | undefined {
  return [...JOB_STAGE_METADATA, ...MAJOR_STAGE_METADATA].find(m => m.stage_id === stage)
}

// Universal Questions 필터링 (미성년 단계용)
export function getUniversalQuestionsForStage(stage: AnalysisStage): UniversalQuestion[] {
  if (isMinorStage(stage)) {
    return UNIVERSAL_QUESTIONS.filter(q => !q.hide_in_minor_stages)
  }
  return UNIVERSAL_QUESTIONS
}

// ============================================
// Stage-aware User Insight Wording
// ============================================
export const INSIGHT_WORDING: Record<AnalysisStage, {
  summary_prefix: string
  evidence_label: string
}> = {
  // Job Stages
  job_explore: { summary_prefix: '활동/관심사 패턴을 보면, ', evidence_label: '선택한 활동' },
  job_student: { summary_prefix: '학업/활동 패턴을 보면, ', evidence_label: '선택한 과목/활동' },
  job_prepare: { summary_prefix: '준비 성향을 보면, ', evidence_label: '준비 중인 것' },
  job_early: { summary_prefix: '초기 경험을 보면, ', evidence_label: '경험 서사' },
  job_mid: { summary_prefix: '경력 패턴을 보면, ', evidence_label: '경력 서사' },
  job_transition: { summary_prefix: '전환 동기를 보면, ', evidence_label: '이전 경험' },
  job_second: { summary_prefix: '새 시작 동기를 보면, ', evidence_label: '희망 활동' },
  // Major Stages
  major_child: { summary_prefix: '좋아하는 놀이를 보면, ', evidence_label: '선택한 활동' },
  major_elementary: { summary_prefix: '관심 과목을 보면, ', evidence_label: '좋아하는 과목' },
  major_middle: { summary_prefix: '적성 패턴을 보면, ', evidence_label: '관심사' },
  major_high: { summary_prefix: '진로 선호를 보면, ', evidence_label: '희망 계열' },
  major_freshman: { summary_prefix: '전공 탐색 동기를 보면, ', evidence_label: '관심 전공' },
  major_student: { summary_prefix: '전과/복수전공 동기를 보면, ', evidence_label: '현 전공 피드백' },
  major_graduate: { summary_prefix: '대학원 진학 동기를 보면, ', evidence_label: '연구 관심사' },
  major_transfer: { summary_prefix: '전과 동기를 보면, ', evidence_label: '현 전공 피드백' },
}

// 개인정보 경고 문구 (미성년용)
export const PRIVACY_WARNING_TEXT = '⚠️ 민감한 개인정보(주소/학교 이름/연락처/실명 등)는 작성하지 마세요.'

// ============================================
// V3: 서술형 필수 질문 (2026-01 리팩토링)
// 깊은 내러티브 확보를 위한 2문항
// ============================================
export interface NarrativeQuestionLegacy {
  question_id: string
  order: number
  text: string
  placeholder: string
  hint: string
  fact_key: string
  min_length: number       // 최소 글자수
  max_length: number       // 최대 글자수
  required: boolean
  purpose: string          // 이 질문의 목적 설명
}

// 레거시 - 새로운 동적 질문 시스템(NARRATIVE_QUESTIONS_BY_CONTEXT)으로 대체됨
export const NARRATIVE_QUESTIONS_LEGACY: NarrativeQuestionLegacy[] = [
  {
    question_id: 'narrative_high_alive',
    order: 1,
    text: "최근 6개월 중 가장 '살아있다'고 느낀 순간은 언제였고, 왜였나요?",
    placeholder: "예: 팀 프로젝트에서 제 아이디어가 채택됐을 때요. 처음으로 제 생각이 인정받은 느낌이었고, 밤새워도 지치지 않았어요...",
    hint: "구체적인 상황, 그때의 감정, 왜 그렇게 느꼈는지 자유롭게 적어주세요",
    fact_key: 'narrative.highAliveMoment',
    min_length: 50,
    max_length: 1000,
    required: true,
    purpose: '에너지 원천과 동기 패턴 파악',
  },
  {
    question_id: 'narrative_lost',
    order: 2,
    text: "반대로 가장 '나를 잃었다'고 느낀 순간은 언제였고, 왜였나요?",
    placeholder: "예: 매일 같은 보고서를 작성할 때요. 제가 누군지, 왜 이 일을 하는지 모르겠었어요...",
    hint: "힘들었던 상황, 그때의 감정, 무엇이 힘들었는지 자유롭게 적어주세요",
    fact_key: 'narrative.lostMoment',
    min_length: 50,
    max_length: 1000,
    required: true,
    purpose: '회피 패턴과 스트레스 트리거 파악',
  },
]

// ============================================
// V3: 3라운드 심층 질문 템플릿
// LLM이 이 템플릿을 기반으로 개인화 질문 생성
// ============================================
export type RoundPurpose = 'ENGINE' | 'AVOIDANCE' | 'INTEGRATION'

export interface RoundQuestionTemplate {
  round: 1 | 2 | 3
  purpose: RoundPurpose
  theme: string
  base_questions: string[]  // LLM이 참고할 기본 질문들
  probe_directions: string[] // 탐색 방향
}

export const ROUND_TEMPLATES: RoundQuestionTemplate[] = [
  // Round 1: DRIVE (욕망 + 정체성 + 가치)
  {
    round: 1,
    purpose: 'ENGINE',  // 레거시 호환
    theme: 'DRIVE: 욕망, 정체성, 가치 탐색',
    base_questions: [
      // 욕망/동기
      "어떤 일을 할 때 시간 가는 줄 모르나요? 그때 어떤 기분이 드나요?",
      "5년 후, '이렇게 되면 정말 행복하겠다'고 상상하면 어떤 감정이 드나요?",
      // 정체성
      "어떤 사람으로 기억되고 싶으세요?",
      "주변에서 보는 나와 내가 생각하는 나의 차이가 있나요?",
      // 가치
      "절대 포기 못하는 가치가 있다면 뭔가요? 왜 그게 중요한가요?",
    ],
    probe_directions: [
      '몰입 경험과 감정',
      '미래 비전과 행복',
      '기억되고 싶은 모습',
      '자기 인식의 간극',
      '핵심 가치와 원칙',
    ],
  },
  // Round 2: FRICTION (회피 + 관계 + 환경)
  {
    round: 2,
    purpose: 'AVOIDANCE',  // 레거시 호환
    theme: 'FRICTION: 회피, 관계 갈등, 환경 탐색',
    base_questions: [
      // 회피
      "절대 하고 싶지 않은 일이 있나요? 왜 그런 감정이 드나요?",
      "다시는 하고 싶지 않은 경험이 있다면, 그때 어떤 감정이었나요?",
      // 관계
      "절대 같이 일하고 싶지 않은 사람 유형은? 왜 그런가요?",
      "가장 힘들었던 관계 갈등 경험은? 어떤 감정이었나요?",
      // 환경
      "이런 조직 문화에서는 버틸 수 없다면, 어떤 문화인가요?",
    ],
    probe_directions: [
      '절대 회피 영역과 이유',
      '부정 경험의 감정',
      '힘든 관계 유형',
      '관계 갈등 패턴',
      '견딜 수 없는 환경',
    ],
  },
  // Round 3: REALITY (제약 + 실행 + 트레이드오프)
  {
    round: 3,
    purpose: 'INTEGRATION',  // 레거시 호환
    theme: 'REALITY: 제약, 실행, 트레이드오프 탐색',
    base_questions: [
      // 제약
      "지금 가장 큰 현실적 제약은 뭔가요? 그 제약 때문에 어떤 기분이 드나요?",
      // 실행
      "지금 당장 시작할 수 있는 가장 작은 행동은 뭘까요?",
      "새로운 시도에 얼마나 시간/에너지를 투자할 수 있나요?",
      // 트레이드오프
      "성장을 위해 포기할 수 있는 것은? 포기한다면 어떤 감정일까요?",
      "절대 포기 못하는 조건이 있다면? 왜 그게 중요한가요?",
    ],
    probe_directions: [
      '현실 제약과 감정',
      '가능한 첫 걸음',
      '투자 가능 자원',
      '포기 가능 영역',
      '비타협 조건',
    ],
  },
]

// 라운드별 설명 메타데이터 (DRIVE/FRICTION/REALITY)
export const ROUND_METADATA = {
  1: {
    title: 'DRIVE: 욕망과 정체성',
    subtitle: '무엇을 원하고, 어떤 사람이고 싶나요?',
    emoji: '🔥',
    color: 'from-orange-500 to-red-500',
    estimatedTime: '3-5분',
    axes: ['욕망', '정체성', '가치'],
  },
  2: {
    title: 'FRICTION: 회피와 경계',
    subtitle: '무엇을 피하고, 누구와 안 맞나요?',
    emoji: '🛡️',
    color: 'from-purple-500 to-indigo-500',
    estimatedTime: '3-5분',
    axes: ['회피', '관계', '환경'],
  },
  3: {
    title: 'REALITY: 현실과 실행',
    subtitle: '어떤 제약이 있고, 무엇을 포기할 수 있나요?',
    emoji: '🚀',
    color: 'from-emerald-500 to-teal-500',
    estimatedTime: '3-5분',
    axes: ['제약', '실행', '트레이드오프'],
  },
} as const

// ============================================
// 동적 서술형 질문 시스템 (상황 + 경력 + 목표 기반)
// ============================================
export interface NarrativeQuestion {
  id: string
  text: string
  placeholder: string
  emoji: string
  color: string  // gradient color
  fact_key: string  // 저장 시 사용
}

export interface NarrativeQuestionSet {
  question1: NarrativeQuestion
  question2: NarrativeQuestion
}

// 컨텍스트 키 생성 함수
export function getNarrativeContextKey(
  roleIdentity: string | null,
  careerStage: string | null,
  transitionStatus: string | null
): string {
  // 우선순위: 특수 상황 > 일반 상황
  // 1. 특수 조합 체크
  if (roleIdentity === 'inactive' && transitionStatus === 'returner') {
    return 'inactive_returner'
  }
  if (roleIdentity === 'manager' && careerStage === '10_plus' && transitionStatus === 'second_career') {
    return 'manager_10plus_second'
  }
  if (roleIdentity === 'entrepreneur') {
    return 'entrepreneur'
  }
  
  // 2. 이직/전환 의사가 있는 경우
  if (transitionStatus === 'changer') {
    if (roleIdentity === 'student') return 'student_changer'
    if (careerStage === '0_3') return 'worker_junior_changer'
    if (careerStage === '3_10') return 'worker_mid_changer'
    if (careerStage === '10_plus') return 'worker_senior_changer'
    return 'worker_changer'
  }
  
  // 3. 학생
  if (roleIdentity === 'student') {
    return 'student_explore'
  }
  
  // 4. 경력 기반
  if (careerStage === 'none' || careerStage === '0_3') {
    return 'worker_junior'
  }
  if (careerStage === '3_10') {
    return 'worker_mid'
  }
  if (careerStage === '10_plus') {
    return 'worker_senior'
  }
  
  // 5. 기본값
  return 'default'
}

// 서술형 질문 매핑
export const NARRATIVE_QUESTIONS: Record<string, NarrativeQuestionSet> = {
  // ============================================
  // 학생/탐색
  // ============================================
  'student_explore': {
    question1: {
      id: 'dream_future',
      text: '어떤 일을 하는 사람이 되고 싶나요? 왜 그런가요?',
      placeholder: '예: 사람들에게 영감을 주는 일을 하고 싶어요. 어릴 때 좋은 선생님을 만나서 제 인생이 바뀌었거든요...',
      emoji: '🌟',
      color: 'from-yellow-500 to-orange-500',
      fact_key: 'narrative.dream_future',
    },
    question2: {
      id: 'fun_experience',
      text: '학교나 일상에서 가장 재미있었던 활동은 뭐였나요? 왜 재미있었나요?',
      placeholder: '예: 팀 프로젝트에서 발표를 맡았을 때요. 제 아이디어가 팀원들에게 인정받는 느낌이 좋았어요...',
      emoji: '✨',
      color: 'from-pink-500 to-rose-500',
      fact_key: 'narrative.fun_experience',
    },
  },
  
  'student_changer': {
    question1: {
      id: 'change_reason',
      text: '전공이나 진로를 바꾸고 싶은 이유가 뭔가요?',
      placeholder: '예: 처음엔 부모님 권유로 선택했는데, 공부할수록 저랑 안 맞는다는 생각이 들었어요...',
      emoji: '🔄',
      color: 'from-blue-500 to-cyan-500',
      fact_key: 'narrative.change_reason',
    },
    question2: {
      id: 'new_interest',
      text: '새로 도전하고 싶은 분야가 있나요? 왜 끌리나요?',
      placeholder: '예: 디자인 쪽이요. 뭔가 만들어내는 일을 할 때 시간 가는 줄 모르거든요...',
      emoji: '🎯',
      color: 'from-violet-500 to-purple-500',
      fact_key: 'narrative.new_interest',
    },
  },
  
  // ============================================
  // 직장인 - 주니어 (0~3년)
  // ============================================
  'worker_junior': {
    question1: {
      id: 'rewarding_moment',
      text: '현재 일에서 가장 보람 있는 순간은 언제인가요?',
      placeholder: '예: 제가 맡은 기능이 실제로 배포되고 사용자 반응을 볼 때요. 내가 만든 게 누군가에게 도움이 된다는 게...',
      emoji: '💪',
      color: 'from-emerald-500 to-teal-500',
      fact_key: 'narrative.rewarding_moment',
    },
    question2: {
      id: 'future_vision',
      text: '3년 후 어떤 모습이고 싶나요? 구체적으로 상상해본다면?',
      placeholder: '예: 팀에서 인정받는 중간 역할이요. 후배도 가르치고, 제 의견이 반영되는 위치...',
      emoji: '🔮',
      color: 'from-indigo-500 to-blue-500',
      fact_key: 'narrative.future_vision',
    },
  },
  
  'worker_junior_changer': {
    question1: {
      id: 'change_trigger',
      text: '이직이나 전환을 생각하게 된 계기가 있나요?',
      placeholder: '예: 반복되는 업무에 성장이 멈춘 느낌이 들었어요. 매일 같은 일만 하니까...',
      emoji: '💭',
      color: 'from-amber-500 to-orange-500',
      fact_key: 'narrative.change_trigger',
    },
    question2: {
      id: 'next_must_have',
      text: '다음 직장에서 꼭 얻고 싶은 것은 뭔가요?',
      placeholder: '예: 새로운 기술을 배울 수 있는 환경이요. 그리고 야근 없이 제 시간을 가질 수 있으면...',
      emoji: '🎁',
      color: 'from-green-500 to-emerald-500',
      fact_key: 'narrative.next_must_have',
    },
  },
  
  // ============================================
  // 직장인 - 미들 (3~10년)
  // ============================================
  'worker_mid': {
    question1: {
      id: 'proud_achievement',
      text: '지금까지 커리어에서 가장 자랑스러운 성과가 있다면?',
      placeholder: '예: 처음으로 프로젝트 리드를 맡아서 성공적으로 마무리했을 때요. 힘들었지만 뿌듯했어요...',
      emoji: '🏆',
      color: 'from-yellow-500 to-amber-500',
      fact_key: 'narrative.proud_achievement',
    },
    question2: {
      id: 'current_gap',
      text: '현재 위치에서 아쉬운 점이 있다면 뭔가요?',
      placeholder: '예: 관리 업무가 늘면서 실무 역량이 정체된 느낌이에요. 예전처럼 깊이 파고들 시간이 없어서...',
      emoji: '🤔',
      color: 'from-slate-500 to-gray-600',
      fact_key: 'narrative.current_gap',
    },
  },
  
  'worker_mid_changer': {
    question1: {
      id: 'breaking_point',
      text: '더 이상 참을 수 없게 된 결정적 계기가 있었나요?',
      placeholder: '예: 연봉 협상에서 실망했어요. 3년간 열심히 했는데 인정받지 못한다는 생각에...',
      emoji: '⚡',
      color: 'from-red-500 to-rose-600',
      fact_key: 'narrative.breaking_point',
    },
    question2: {
      id: 'must_avoid',
      text: '다음 단계에서 반드시 피하고 싶은 것은?',
      placeholder: '예: 정치가 심한 조직이요. 실력보다 눈치가 중요한 환경에서는 못 버틸 것 같아요...',
      emoji: '🚫',
      color: 'from-orange-600 to-red-500',
      fact_key: 'narrative.must_avoid',
    },
  },
  
  // ============================================
  // 직장인 - 시니어 (10년+)
  // ============================================
  'worker_senior': {
    question1: {
      id: 'legacy',
      text: '지금까지 쌓아온 것 중 가장 소중한 것은 뭔가요?',
      placeholder: '예: 업계에서의 네트워크요. 어디서든 도움 주고받을 수 있는 관계들이 큰 자산이에요...',
      emoji: '💎',
      color: 'from-purple-600 to-indigo-600',
      fact_key: 'narrative.legacy',
    },
    question2: {
      id: 'remaining_goal',
      text: '남은 커리어에서 꼭 이루고 싶은 것이 있다면?',
      placeholder: '예: 후배들을 키우는 일이요. 제가 받은 도움을 다음 세대에 돌려주고 싶어요...',
      emoji: '🌱',
      color: 'from-teal-600 to-cyan-600',
      fact_key: 'narrative.remaining_goal',
    },
  },
  
  'worker_senior_changer': {
    question1: {
      id: 'senior_change_reason',
      text: '이 시점에서 변화를 생각하게 된 이유는 뭔가요?',
      placeholder: '예: 더 이상 이 분야에서 성장할 게 없다는 생각이 들었어요. 새로운 도전이 필요한 시기...',
      emoji: '🔄',
      color: 'from-blue-600 to-purple-600',
      fact_key: 'narrative.senior_change_reason',
    },
    question2: {
      id: 'non_negotiable',
      text: '새로운 시작에서 절대 포기할 수 없는 조건은?',
      placeholder: '예: 연봉 수준은 유지해야 해요. 가족 부양 책임이 있어서 너무 큰 리스크는 못 져요...',
      emoji: '⚖️',
      color: 'from-slate-600 to-zinc-600',
      fact_key: 'narrative.non_negotiable',
    },
  },
  
  // ============================================
  // 창업가/프리랜서
  // ============================================
  'entrepreneur': {
    question1: {
      id: 'entrepreneur_why',
      text: '왜 독립적인 일을 선택하셨나요? (혹은 선택하려 하나요?)',
      placeholder: '예: 제 아이디어를 직접 실현하고 싶었어요. 조직에서는 항상 누군가의 결정을 기다려야 해서...',
      emoji: '🚀',
      color: 'from-orange-500 to-red-500',
      fact_key: 'narrative.entrepreneur_why',
    },
    question2: {
      id: 'entrepreneur_challenge',
      text: '독립적으로 일하면서 가장 힘든 점은 뭔가요?',
      placeholder: '예: 수입이 불안정한 거요. 잘될 때와 안 될 때의 차이가 너무 커서 스트레스...',
      emoji: '🏔️',
      color: 'from-slate-500 to-gray-600',
      fact_key: 'narrative.entrepreneur_challenge',
    },
  },
  
  // ============================================
  // 경력 단절/복귀
  // ============================================
  'inactive_returner': {
    question1: {
      id: 'gap_reflection',
      text: '경력 단절 기간 동안 어떤 생각이 들었나요?',
      placeholder: '예: 처음엔 쉬는 게 좋았는데, 시간이 지나니까 불안해졌어요. 사회와 단절된 느낌...',
      emoji: '💭',
      color: 'from-blue-500 to-indigo-500',
      fact_key: 'narrative.gap_reflection',
    },
    question2: {
      id: 'comeback_worry',
      text: '복귀하면서 가장 걱정되는 부분은 뭔가요?',
      placeholder: '예: 기술이 많이 바뀌었을 것 같아요. 따라갈 수 있을지, 나이 때문에 편견이 있을지...',
      emoji: '😰',
      color: 'from-amber-500 to-yellow-500',
      fact_key: 'narrative.comeback_worry',
    },
  },
  
  // ============================================
  // 세컨드 커리어
  // ============================================
  'manager_10plus_second': {
    question1: {
      id: 'accumulated_value',
      text: '지금까지 쌓은 것 중 가장 가치 있는 것은 뭔가요?',
      placeholder: '예: 사람을 보는 눈이요. 수많은 면접과 평가를 하면서 인재를 알아보는 감각이 생겼어요...',
      emoji: '💎',
      color: 'from-purple-600 to-pink-600',
      fact_key: 'narrative.accumulated_value',
    },
    question2: {
      id: 'second_career_dream',
      text: '은퇴 후 또는 다음 단계에서 꼭 해보고 싶은 일은?',
      placeholder: '예: 컨설팅이요. 제 경험을 후배 경영자들에게 나눠주고 싶어요. 돈보다는 의미가 중요...',
      emoji: '🌅',
      color: 'from-amber-500 to-orange-500',
      fact_key: 'narrative.second_career_dream',
    },
  },
  
  // ============================================
  // 기본값 (모든 조건에 해당하지 않을 때)
  // ============================================
  'default': {
    question1: {
      id: 'high_alive',
      text: '최근 6개월 중 가장 "살아있다"고 느낀 순간은 언제였나요? 왜 그랬나요?',
      placeholder: '예: 팀 프로젝트에서 제 아이디어가 채택됐을 때요. 처음으로 제 생각이 인정받은 느낌이었고...',
      emoji: '🔥',
      color: 'from-orange-500 to-red-500',
      fact_key: 'narrative.high_alive_moment',
    },
    question2: {
      id: 'lost_moment',
      text: '반대로 가장 "나를 잃었다"고 느낀 순간은 언제였나요? 왜 그랬나요?',
      placeholder: '예: 매일 같은 보고서를 작성할 때요. 제가 누군지, 왜 이 일을 하는지 모르겠었어요...',
      emoji: '🌫️',
      color: 'from-violet-500 to-purple-500',
      fact_key: 'narrative.lost_moment',
    },
  },
  
  // 이직 의사 있는 일반 케이스 (경력 무관)
  'worker_changer': {
    question1: {
      id: 'change_trigger_general',
      text: '이직이나 전환을 생각하게 된 계기가 있나요?',
      placeholder: '예: 성장이 멈춘 느낌이 들었어요. 매일 같은 일만 반복하니까 무기력해지더라고요...',
      emoji: '💭',
      color: 'from-blue-500 to-cyan-500',
      fact_key: 'narrative.change_trigger',
    },
    question2: {
      id: 'next_priority',
      text: '다음 직장/커리어에서 가장 중요하게 생각하는 것은?',
      placeholder: '예: 배울 수 있는 환경이요. 정체되지 않고 계속 성장할 수 있는 곳이면 좋겠어요...',
      emoji: '⭐',
      color: 'from-yellow-500 to-amber-500',
      fact_key: 'narrative.next_priority',
    },
  },
}

// 서술형 질문 가져오기 헬퍼 함수
export function getNarrativeQuestions(
  roleIdentity: string | null,
  careerStage: string | null,
  transitionStatus: string | null
): NarrativeQuestionSet {
  const key = getNarrativeContextKey(roleIdentity, careerStage, transitionStatus)
  return NARRATIVE_QUESTIONS[key] || NARRATIVE_QUESTIONS['default']
}





