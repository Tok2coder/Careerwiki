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
  'major_transfer',    // 대학 (전과/복수)
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
  // 6. 제약조건 - 시간/근무 (선택)
  // ============================================
  {
    question_id: 'univ_constraint_time',
    order: 6,
    text: '시간/근무 관련해서 꼭 피해야 하는 조건이 있나요?',
    ui_type: 'checkbox',
    options: [
      { value: 'work_hours_strict', label: '야근/긴 근무 절대 불가', tags: ['work_hours_strict'] },
      { value: 'shift_work_no', label: '교대근무 불가', tags: ['shift_work_no'] },
      { value: 'weekend_no', label: '주말근무 불가', tags: ['weekend_no'] },
    ],
    allow_unknown: true,
    unknown_label: '해당 없음',
    fact_key: 'profile.constraints.time',
    required: false,
    normalize_rule: 'direct',
  },

  // ============================================
  // 7. 제약조건 - 장소/이동 (선택)
  // ============================================
  {
    question_id: 'univ_constraint_location',
    order: 7,
    text: '장소/이동 관련해서 꼭 피해야 하는 조건이 있나요?',
    ui_type: 'checkbox',
    options: [
      { value: 'remote_only', label: '재택/원격만 가능', tags: ['remote_only'] },
      { value: 'travel_no', label: '출장 불가', tags: ['travel_no'] },
      { value: 'region_fixed', label: '특정 지역만 가능', tags: ['region_fixed'] },
    ],
    allow_unknown: true,
    unknown_label: '해당 없음',
    fact_key: 'profile.constraints.location',
    required: false,
    normalize_rule: 'direct',
  },

  // ============================================
  // 8. 제약조건 - 자격/학력 (선택)
  // ============================================
  {
    question_id: 'univ_constraint_qualification',
    order: 8,
    text: '자격/학력 관련해서 어려운 점이 있나요?',
    ui_type: 'checkbox',
    options: [
      { value: 'degree_impossible', label: '학위 취득이 어려워요', tags: ['degree_impossible'] },
      { value: 'license_impossible', label: '자격증 취득이 어려워요', tags: ['license_impossible'] },
      { value: 'training_limited', label: '장기 교육이 어려워요', tags: ['training_limited'] },
    ],
    allow_unknown: true,
    unknown_label: '해당 없음',
    fact_key: 'profile.constraints.qualification',
    required: false,
    normalize_rule: 'direct',
  },

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
  major_transfer: { summary_prefix: '전과 동기를 보면, ', evidence_label: '현 전공 피드백' },
}

// 개인정보 경고 문구 (미성년용)
export const PRIVACY_WARNING_TEXT = '⚠️ 민감한 개인정보(주소/학교 이름/연락처/실명 등)는 작성하지 마세요.'







