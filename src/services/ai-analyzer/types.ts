// CareerWiki AI Analyzer Types
// Version: v2.0.0-stage-based (Universal Intake + Stage-based Follow-up)

// ============================================
// Stage Types (re-export from universal-questions)
// ============================================
export type { 
  JobStage, 
  MajorStage, 
  AnalysisStage,
  LifeConstraintFlag,
} from './universal-questions'
export { 
  JOB_STAGES, 
  MAJOR_STAGES,
  LIFE_CONSTRAINT_FLAGS,
  isValidStage,
  isMinorStage,
  isExperienceAllowed,
} from './universal-questions'

// ============================================
// Constraint Types (표준 5개만 허용!)
// ============================================
export const VALID_CONSTRAINT_TYPES = [
  'work_hours_strict',
  'remote_only',
  'shift_work_no',
  'degree_impossible',
  'license_impossible',
] as const

export type ConstraintType = typeof VALID_CONSTRAINT_TYPES[number]

// 금지 키 검증
export function isValidConstraintType(value: string): value is ConstraintType {
  return VALID_CONSTRAINT_TYPES.includes(value as ConstraintType)
}

export function assertConstraintType(value: string): ConstraintType {
  if (!isValidConstraintType(value)) {
    throw new Error(`Invalid constraint_type: "${value}". Allowed: ${VALID_CONSTRAINT_TYPES.join(', ')}`)
  }
  return value
}

// ============================================
// Version Constants
// ============================================
export const VERSIONS = {
  recipe: 'recipe-v1.0.0',
  tagger: 'tagger-v1.0.0',
  scoring: 'scoring-v0.2.1-final',
} as const

// ============================================
// Risk Types
// ============================================
export type RiskStatus = 'OK' | 'UNKNOWN' | 'RISK'

export interface RiskDetail {
  constraint: ConstraintType
  constraint_label: string
  job_attribute: string
  job_value: string
  status: RiskStatus
  penalty: number
  warning_message: string
  confidence: number
}

export interface RiskResult {
  total: number
  items: RiskDetail[]
  hasUnknown: boolean
  bucket: 'safe_known' | 'safe_unknown' | 'caution'
}

// ============================================
// Bucket Types
// ============================================
export type BucketType = 'safe_known' | 'safe_unknown' | 'caution'

export interface BucketCounts {
  safe_known: number
  safe_unknown: number
  caution: number
  total: number
}

// ============================================
// User Constraints (입력)
// ============================================
export interface UserConstraints {
  // Non-negotiable (절대 불가)
  work_hours_strict?: boolean
  remote_only?: boolean
  shift_work_no?: boolean
  degree_impossible?: boolean
  license_impossible?: boolean
  
  // ============================================
  // 🆕 V3 Hard Exclusion 제약 (미니모듈 기반)
  // ============================================
  // 육체/현장 노동 불가
  physical_labor_no?: boolean
  // 반복 숙련 노동 불가 (공장, 제조, 조립 등)
  repetitive_manual_no?: boolean
  // 의사결정 영향 없는 단순 실행직 회피
  no_decision_impact_avoid?: boolean
  // 데이터/분석 없는 직업 회피 (analytical 성향 강할 때)
  requires_data_work?: boolean
  
  // Preference (선호)
  prefer_low_overtime?: boolean
  prefer_remote?: boolean
  prefer_stability?: boolean
  learning_window_months?: number
}

// ============================================
// Analysis Request/Response
// ============================================
export interface AnalysisRequestPayload {
  session_id: string
  user_id?: string
  profile: {
    interest: { keywords: string[] }
    value: { priority: string[] }
    skill: { name: string; level: 'beginner' | 'intermediate' | 'advanced' }[]
    dislike: { keywords: string[] }
    constraints: UserConstraints
    preference?: { work_style?: string }
    form_summary?: string
  }
  analysis_type?: 'job' | 'major'
  pricing_tier?: 'free' | 'pro'
}

export interface FitRecommendation {
  job_id: string
  job_name: string
  job_category: string
  scores: {
    fit: number
    like: number
    can: number
    risk_penalty: number
  }
  bucket: BucketType
  risk_details: RiskDetail[]
  evidence: EvidenceLink[]
  summary: string
  next_steps: string[]
}

export interface EvidenceLink {
  user_fact: {
    key: string
    value: string
    label: string
  }
  job_attribute: {
    key: string
    value: string
    label: string
  }
  match_type: 'positive' | 'neutral' | 'negative'
  score_contribution: number
  explanation: string
}

export interface FollowupQuestion {
  id: string
  question: string
  context: string
  options: {
    yes: { label: string; effect: string }
    no: { label: string; effect: string }
  }
  affects_jobs: string[]
  constraint: ConstraintType
}

export interface UXFlags {
  has_caution_in_top3: boolean
  has_unknown_in_top3: boolean
  needs_followup_question: boolean
  counts_before_filter: BucketCounts
  counts_after_filter: BucketCounts
  followup_applied?: boolean
  replaced_jobs?: string[]
}

// ============================================
// Engine State Types (V3)
// ============================================
export type EngineStateV3 = 
  | 'phase0_stub' 
  | 'phase1a_initial' 
  | 'phase1a_mve' 
  | 'phase2_scoring' 
  | 'phase2_stage_based'  // V3: Stage-based 분석
  | 'phase4_filtered'     // V3: Hard Filter 적용됨
  | 'production'

// ============================================
// V3 Input Summary (Stage 정보 포함)
// ============================================
export interface InputSummaryV3 {
  profile_revision_id: string
  key_interests: string[]
  key_skills: string[]
  non_negotiables: string[]
  preferences: string[]
  // Phase 1A
  facts_applied?: number
  applied_rules?: string[]
  // Phase 1C
  deep_intake_provided?: boolean
  insight_tags?: string[]
  // V3: Stage-based 추가
  stage?: string
  universal_facts_count?: number
  life_constraints?: string[]
  confirmed_constraints?: string[]
}

// ============================================
// Phase 4: Replacement & Rank Change Info
// ============================================
export interface ReplacementResult {
  original_job: {
    job_id: string
    job_name: string
    rank: number
  }
  replacement_job: {
    job_id: string
    job_name: string
    fit_score: number
    similarity_score: number
  } | null
  reason: string
  rule_applied: 'hard_filter' | 'diversity_guard' | 'soft_rerank'
}

export interface RankChangeInfo {
  changed: boolean
  replacements: ReplacementResult[]
  before_top3: string[]
  after_top3: string[]
  removed_count: number
  diversity_applied: boolean
  debug: {
    hard_filtered: number
    soft_reranked: number
    constraints_applied: string[]
    diversity_violations: string[]
  }
}

// Phase 4: Follow-up "no" 처리 결과
export interface FollowupNoResult {
  success: boolean
  action: 'replaced' | 'removed' | 'already_confirmed' | 'no_change'
  rank_change: RankChangeInfo | null
  fact_saved: {
    fact_key: string
    fact_level: number
  } | null
  message: string
  new_top3?: Array<{
    job_id: string
    job_name: string
    fit_score: number
    like_score: number
    can_score: number
  }>
}

// ============================================
// Analysis Result JSON (V3 - Production Ready)
// ============================================
export interface AnalysisResultJSON {
  // Phase 상태 표시 (QA 혼동 방지)
  engine_state: EngineStateV3

  // 미니모듈 결과 (프론트엔드 복원용)
  mini_module_result?: any

  versions: {
    recipe: string
    tagger: string
    scoring: string
  }
  
  // V3: 확장된 input_summary
  input_summary: InputSummaryV3
  
  // Phase 1A: 간소화된 타입 (FitRecommendation은 Phase 2에서)
  fit_top3: Array<{
    job_id: string
    job_name: string
    fit_score: number
    like_score: number
    can_score: number
    risk_details: RiskDetail[]
    evidence_links: EvidenceLink[]
  }>
  like_top10: Array<{ job_id: string; job_name: string; like_score: number }>
  can_top10: Array<{ job_id: string; job_name: string; can_score: number }>
  caution_jobs: Array<{ job_id: string; job_name: string; risk_penalty: number }>
  ux_flags: UXFlags
  
  // Phase 1A: 새로운 FollowupQuestion 타입
  followup_questions?: FollowupQuestionV2[]
  llm_explanation: string
  generated_at: string
  total_candidates: number
  
  // Phase 1C: User Insight
  user_insight?: UserInsight
  
  // ============================================
  // V3/Phase 4: 새로운 필드들
  // ============================================
  
  // Phase 4: Diversity Guard 적용 여부
  phase4_applied?: boolean
  diversity_guard_active?: boolean
  diversity_changes?: string[]
  
  // Phase 4: 순위 변경 정보 (Follow-up "no" 처리 후)
  rank_change?: RankChangeInfo
  
  // V3: Stage 기반 분석 정보
  analysis_stage?: string
  stage_specific_insights?: string[]
  
  // Freeze v1.1: TAG 근거 패킷 (최종 결과 설명용)
  // - 왜 특정 직업이 제외되었는지
  // - 왜 특정 직업에 경고가 붙었는지
  // - 사후 검증 및 유저 신뢰 확보용
  tag_evidence?: {
    hard_excluded_jobs: Array<{
      job_id: string
      job_name: string
      rule: string
      reason: string
      confidence: 'high'
    }>
    soft_considerations: Array<{
      job_id: string
      job_name: string
      warning: string
      penalty_applied: number
    }>
    why_not_recommended: Array<{
      job_name: string
      primary_reason: string
      user_constraint: string
    }>
  }
  
  // Debug info (only included when debug=true)
  debug_info?: DebugInfo
}

// Debug info for test UI
export interface DebugInfo {
  // 1. Candidate Source
  candidate_source: 'random' | 'tagged' | 'vector' | 'sample_fallback'
  tagged_count: number
  total_in_db: number
  
  // 2. Score breakdown for TOP3
  score_breakdown: Array<{
    job_id: string
    job_name: string
    base_like: number
    base_can: number
    base_risk: number
    like_boosts: Array<{ rule: string; delta: number }>
    can_boosts: Array<{ rule: string; delta: number }>
    risk_boosts: Array<{ rule: string; delta: number }>
    final_like: number
    final_can: number
    final_risk: number
    final_fit: number
  }>
  
  // 3. Follow-up rationale
  followup_rationale?: {
    split_attribute: string
    split_gain: number
    reason: string
  }
  
  // 4. Rank changes (if any)
  rank_changes?: {
    before: string[]
    after: string[]
    changes: string[]
  }
  
  // 5. Applied facts summary
  applied_facts: Array<{
    fact_key: string
    value: string
    effect: string
  }>
  
  // 6. Full version info
  versions: {
    recipe: string
    tagger: string
    scoring: string
    embedding: string
  }
  
  // Additional debug data
  diversity_guard_triggered: boolean
  research_bias_cap_applied: boolean
  stubbedRatio?: number
}

// Phase 1A: 자기발견형 Follow-up 질문 타입
export interface FollowupQuestionV2 {
  id: string
  type: 'clarification' | 'tradeoff' | 'priority' | 'discovery'
  question: string
  context?: string
  options: Array<{
    value: string
    label: string
    tags?: string[]
  }>
  fact_key: string
  affects_attributes: string[]
}

// ============================================
// Premium V3: 목적 기반 Follow-up 질문 (3종 분류)
// ============================================
// ⚠️ LLM vs Rule 역할 경계 (중요!)
// - type, why_asked, affected_dimensions: Rule 기반으로 고정 (결정 안정성)
// - question: LLM 생성 가능 (문장 품질 향상)
// LLM은 오직 question 문장 생성에만 사용하도록 역할 제한!
// 이렇게 해야 "목적 없는 질문"이 생기지 않습니다.
// ============================================

export type FollowupPurpose =
  | 'contradiction_resolver'  // 모순 해결형: 앞 답변끼리 충돌하는 지점 확인
  | 'decision_variable'       // 결정변수 확인형: 추천을 갈라먹는 변수를 확정
  | 'reality_constraint'      // 현실 제약 확인형: 시간·돈·학력·지역 등 "불가능" 제거
  | 'identity_anchor'         // P1: 정체성/가치 앵커 질문 - 핵심 가치 확인
  | 'can_validation'          // P0: Can 검증형: 자기평가 강점의 실제 경험 확인

export interface FollowupQuestionV3 {
  id: string
  
  // ⚠️ 아래 3개 필드는 Rule 기반으로 고정 (LLM이 변경하지 않음)
  type: FollowupPurpose
  why_asked: string                    // 이 질문이 추천을 어떻게 갈라먹는지 1~2문장
  affected_dimensions: string[]        // 영향받는 직업 속성 (wlb, income, growth 등)
  
  // question: LLM 생성 가능 (단, 위 목적에 맞게)
  question: string
  
  // 선택: 객관식 옵션 (없으면 자유 텍스트)
  options?: Array<{
    value: string
    label: string
    tags?: string[]
  }>
  
  // fact 저장용
  fact_key: string
  
  // 답변에 따라 갈리는 직업군/경로
  split_impact?: {
    option_a: string[]  // 이 답변이면 추천될 직업군
    option_b: string[]  // 다른 답변이면 추천될 직업군
  }
  
  // 불확실성 감소 점수 (높을수록 이 질문이 중요)
  uncertainty_reduction?: number  // 0~1
}

// ============================================
// Follow-up Types
// ============================================
export interface FollowupResponsePayload {
  request_id: number
  question_id: string
  constraint: ConstraintType
  job_id: string
  job_name?: string
  answer: 'yes' | 'no'
}

export interface FollowupResult {
  success: boolean
  action: 'kept' | 'replaced'
  replaced_with?: {
    job_id: string
    job_name: string
  }
  fact_saved: {
    fact_key: string
    fact_value: object
  }
  updated_top3?: FitRecommendation[]
}

// ============================================
// DB Row Types
// ============================================
export interface RawEventRow {
  id: number
  user_id: string | null
  session_id: string
  event_type: string
  payload_json: string
  created_at: string
  client_meta: string | null
}

export interface AnalysisRequestRow {
  id: number
  session_id: string
  user_id: string | null
  analysis_type: string
  pricing_tier: string
  prompt_payload: string
  status: string
  requested_at: string
  processed_at: string | null
  recipe_version: string
  tagger_version: string
  scoring_version: string
  profile_revision_id: string | null
}

export interface AnalysisResultRow {
  id: number
  request_id: number
  result_json: string
  created_at: string
}

export interface FollowupResponseRow {
  id: number
  request_id: number
  question_id: string
  constraint_type: string
  job_id: string
  job_name: string | null
  answer: string
  created_at: string
}

// ============================================
// Phase 1C: Deep Intake Types
// ============================================

// MBTI 타입
export type MBTIType = 
  | 'INTJ' | 'INTP' | 'ENTJ' | 'ENTP'
  | 'INFJ' | 'INFP' | 'ENFJ' | 'ENFP'
  | 'ISTJ' | 'ISFJ' | 'ESTJ' | 'ESFJ'
  | 'ISTP' | 'ISFP' | 'ESTP' | 'ESFP'

// WorkStyle 태그 (Discovery에서 추출)
export type WorkStyleTag =
  | 'solo_deep'      // 혼자 깊게 파기
  | 'team_collab'    // 팀 협업 선호
  | 'people_facing'  // 대인 관계 중심
  | 'analytical'     // 분석 중심
  | 'creative'       // 창의적 작업
  | 'structured'     // 구조화된 환경
  | 'flexible'       // 유연한 환경
  | 'fast_paced'     // 빠른 템포
  | 'steady_paced'   // 꾸준한 템포
  | 'autonomous'     // 자율성 중시
  | 'guided'         // 가이드 선호
  | 'variety'        // 다양한 업무
  | 'routine'        // 루틴 선호

// StressTrigger 태그
export type StressTriggerTag =
  | 'deadline'       // 마감 압박
  | 'people'         // 대인 갈등
  | 'uncertainty'    // 불확실성
  | 'physical'       // 신체적 부담
  | 'multitask'      // 멀티태스킹
  | 'meeting'        // 회의 과다
  | 'micromanage'    // 세세한 관리
  | 'isolation'      // 고립
  | 'public_speaking'// 발표/프레젠테이션

// EnergySource 태그
export type EnergySourceTag =
  | 'solo'           // 혼자 있을 때
  | 'people'         // 사람들과 있을 때
  | 'learning'       // 배울 때
  | 'creating'       // 만들 때
  | 'helping'        // 도와줄 때
  | 'achieving'      // 성취할 때
  | 'exploring'      // 탐험할 때
  | 'organizing'     // 정리할 때

// Deep Intake 입력
export interface DeepIntakeInput {
  mbti?: MBTIType
  best_moment?: string      // 가장 좋았던 순간 (오픈 텍스트)
  worst_moment?: string     // 가장 싫었던 순간 (오픈 텍스트)
  change_reason?: string    // 지금 원하는 변화 (오픈 텍스트)
  priority_top1?: 'growth' | 'stability' | 'wlb' | 'income'  // 1순위
}

// 정규화된 Deep Intake (태그 추출 후)
export interface DeepIntakeNormalized {
  mbti?: MBTIType
  best_moment: {
    raw: string
    tags: WorkStyleTag[]
    energy_source?: EnergySourceTag
  }
  worst_moment: {
    raw: string
    tags: WorkStyleTag[]
    stress_trigger?: StressTriggerTag
  }
  change_reason: {
    raw: string
    tags: string[]
  }
  priority_top1: string
}

// User Insight (결과에 포함)
export interface UserInsight {
  summary: string                    // "당신은 OO를 중요하게 생각하는 사람입니다"
  key_traits: Array<{
    trait: string                    // 예: "혼자 깊게 파기를 좋아함"
    evidence: string                 // 예: "'분석 업무에서 몰입할 때 즐거웠다'고 응답"
    score_impact: string             // 예: "분석 중심 직업에 +15 부스트"
  }>
  applied_facts: Array<{
    fact_key: string
    effect_summary: string
  }>
}

// Phase 1C용 Follow-up 질문 타입 확장
export type FollowupQuestionType =
  | 'tradeoff'       // 트레이드오프형 (기존)
  | 'narrative'      // 서사형 (왜?)
  | 'pattern'        // 패턴형 (반복되는 성향)
  | 'priority'       // 우선순위형
  | 'clarification'  // 명확화형
  | 'discovery'      // 자기발견형 (기존)
  | 'can_validation' // P0: Can 검증형 (자기평가 강점 경험 확인)

// 확장된 AnalysisRequestPayload (Phase 1C)
export interface AnalysisRequestPayloadV2 extends AnalysisRequestPayload {
  deep_intake?: DeepIntakeInput
}

// ============================================
// V3: Stage-based Universal Intake (v2.0.0)
// ============================================
import type { AnalysisStage, LifeConstraintFlag } from './universal-questions'

// Universal 답변 (question_id → 답변)
export type UniversalAnswers = Record<string, string | string[] | null>

// V3 요청 페이로드
export interface AnalysisRequestPayloadV3 {
  session_id: string
  user_id?: string
  analysis_type: 'job' | 'major'
  stage: AnalysisStage
  universal_answers: UniversalAnswers
  // 선택: Deep Intake (경험 허용 단계만)
  deep_intake?: DeepIntakeInput
  // Legacy 호환: 기존 profile 형식도 지원
  profile?: AnalysisRequestPayload['profile']
  // Debug mode: includes detailed score breakdown
  debug?: boolean
  // P0 5축 상태좌표
  career_state?: {
    role_identity: string
    career_stage_years: string
    transition_status: string
    skill_level: number
    constraints: Record<string, { has_constraint: boolean; details?: string }>
  }
  // P0 전이 신호
  transition_signal?: Record<string, string | string[]>
  // P0 팔로업 답변
  followup_answers?: Record<string, string>
}

// ============================================
// Premium V3: 8섹션 구조화된 보고서
// ============================================
// ⚠️ 섹션별 실패 허용 구조
// 각 섹션에 generation_status를 붙여서
// 일부 섹션 생성 실패해도 전체 보고서가 깨지지 않음
// LLM 병렬 생성 + 캐싱에 유리한 구조
// ============================================

export type SectionGenerationStatus = 
  | 'success'      // 정상 생성
  | 'partial'      // 부분 생성 (일부 필드 누락)
  | 'fallback'     // 기본값으로 대체됨
  | 'failed'       // 생성 실패
  | 'skipped'      // 의도적 생략 (해당 없음)

export interface SectionMeta {
  status: SectionGenerationStatus
  confidence?: number           // 0~1, 해당 섹션 신뢰도
  generated_by?: 'rule' | 'llm' | 'hybrid'
  error_message?: string        // 실패 시 원인
}

// 1. 요약 1페이지
export interface SummaryOnePageSection {
  _meta: SectionMeta
  headline: string                    // "당신은 이런 타입, 지금 단계에서 최우선은 이것"
  top_takeaways: string[]             // 3~5개 핵심 요약
  recommended_next_step: string       // 다음 단계 제안
  // 🆕 추천 로직 설명 (왜 이 직업이 추천되었는지, 왜 특정 직업군이 제외되었는지)
  recommendation_rationale?: {
    included_because: string[]        // 이런 직업이 추천된 이유
    excluded_because: string[]        // 이런 직업이 제외된 이유
  }
}

// 2. 개인 분석 (서사형)
export interface PersonalAnalysisSection {
  _meta: SectionMeta
  personality_summary: string         // 성격 요약
  work_style_insights: string[]       // 3~7개 업무 스타일 인사이트
  value_priorities: string[]          // 3~7개 가치관/우선순위
  potential_challenges: string[]      // 2~5개 잠재적 도전/주의점
  blind_spots_to_check: string[]      // 2~5개 맹점/확인 필요 사항
}

// 3. 핵심 가설 (근거 포함)
export interface KeyHypothesis {
  hypothesis: string                  // 가설 문장
  confidence: number                  // 0~1 신뢰도
  supporting_evidence: EvidenceLink[] // 근거 링크들
  what_would_change_my_mind: string   // 반증 조건 (이것이 다르면 가설 변경)
}

export interface KeyHypothesesSection {
  _meta: SectionMeta
  hypotheses: KeyHypothesis[]         // 3개 핵심 가설
}

// 4. TOP 추천 (상세)
export interface TopRecommendation {
  id: string
  name: string
  fit_score: number                   // 0~100
  personal_fit_reason: string         // 개인화된 추천 이유
  evidence_links: EvidenceLink[]      // 3~10개 근거
  growth_path_30_days: string[]       // 30일 성장 경로 3~7개
  risks: string[]                     // 2~5개 리스크/주의사항
}

export interface TopRecommendationsSection {
  _meta: SectionMeta
  recommendations: TopRecommendation[] // TOP 5
}

// 5. 보류 추천 (조건부)
export interface HoldRecommendation {
  id: string
  name: string
  why_on_hold: string                 // 보류 이유
  conditions_to_reconsider: string[]  // 재고려 조건들
}

export interface HoldRecommendationsSection {
  _meta: SectionMeta
  recommendations: HoldRecommendation[] // 최대 5개
}

// 6. 대체 경로 (Plan B)
export interface PlanBPath {
  title: string                       // 경로 제목
  when_this_is_better: string         // 이 경로가 더 나은 상황
  steps: string[]                     // 구체적 단계들
}

export interface PlanBPathsSection {
  _meta: SectionMeta
  paths: PlanBPath[]                  // 2개 대체 경로
}

// 7. 다음 질문 (업그레이드용)
export interface NextQuestionsSection {
  _meta: SectionMeta
  questions: string[]                 // 3개 추가 질문
  expected_improvements: string[]     // 이 질문들로 개선될 점
}

// ============================================
// 통합 PremiumReport
// ============================================
export interface PremiumReport {
  // 메타 정보
  report_id: string
  generated_at: string
  session_id: string
  
  // 전체 상태
  overall_status: SectionGenerationStatus
  sections_completed: number
  sections_total: number
  
  // 분석 상세 메타데이터 (UI에서 사용)
  _confidence?: number          // 신뢰도 (0~1)
  _factsCount?: number          // 수집된 팩트 수
  _answeredQuestions?: number   // 답변한 질문 수
  _candidatesScored?: number    // 평가한 직업 수
  _appliedRules?: number        // 적용된 규칙 수
  
  // 7개 섹션
  summary_one_page: SummaryOnePageSection
  personal_analysis: PersonalAnalysisSection
  key_hypotheses: KeyHypothesesSection
  recommendations_top: TopRecommendationsSection
  recommendations_hold: HoldRecommendationsSection
  plan_b_paths: PlanBPathsSection
  next_questions: NextQuestionsSection
}

// ============================================
// V3 LLM+RAG 시스템 (2026-01 리팩토링)
// ============================================

// 서술형 답변 저장용
export interface NarrativeFacts {
  highAliveMoment: string   // "가장 자랑스러운 성과"
  lostMoment: string        // "아쉬운 점"
  // 커리어 스토리 (q0) - 둘 중 하나 사용
  storyAnswer?: string      // "간략하게 지금까지의 이야기"
  life_story?: string       // 별칭
  // 전공/이전 직업 정보 (구조화 입력 - 선택)
  career_background?: string  // "전공/학과, 직무/업종, 경력 기간"
  // 실존적 질문 답변 ("7일 뒤 지구 멸망" 시나리오)
  existentialAnswer?: string
}

// 실존적 질문 LLM 분석 결과
export interface ExistentialAnalysis {
  primary_orientation: string   // 주요 행동 지향성
  core_values: string[]         // 핵심 가치 신호 (최대 3개)
  time_orientation: string      // 시간 지향성
  emotional_tone: string        // 정서적 톤
  hidden_gap_analysis: string   // 잠재적 괴리 분석
  career_implication: string    // 직업 설계 시사점
}

// 3라운드 심층 질문용 타입
export type RoundPurposeTag = 'ENGINE' | 'AVOIDANCE' | 'INTEGRATION'

// 질문으로 추출하려는 데이터 타입
export type ExtractTarget = 
  | 'value_rank'        // 가치 순위
  | 'fear_root'         // 두려움 근원
  | 'decision_rule'     // 선택 기준 (If-Then)
  | 'constraint'        // 제약 조건
  | 'driver'            // 동기/욕구
  | 'pattern'           // 반복 패턴
  | 'emotional_trigger' // 감정 트리거

export interface RoundQuestion {
  id: string
  questionText: string
  purposeTag: RoundPurposeTag
  answerType: 'TEXT'
  minLengthGuidance: number    // 권장 최소 글자수
  intent?: string              // UI 노출용: "자율이 중요한 이유의 근원(경험/감정)을 확인"
  what_to_extract?: ExtractTarget[]  // 운영/학습용: 이 질문으로 뽑아내려는 데이터
}

export interface RoundAnswer {
  questionId: string
  questionText?: string  // 질문 텍스트 (다음 라운드 컨텍스트용)
  roundNumber: 1 | 2 | 3
  answer: string
  answeredAt: string
}

// 근거 인용 (사용자 원문에서 발췌)
export interface EvidenceQuote {
  text: string
  source: {
    step: number
    round?: number
    questionId: string
  }
}

// LLM Judge 결과 (개별 직업 평가)
export interface LLMJudgeResult {
  job_id: string
  job_name: string
  fitScore: number           // 0-100: 적합도
  desireScore: number        // 0-100: 욕망/원함
  feasibilityScore: number   // 0-100: 실현 가능성
  overallScore: number       // 계산: Fit*0.45 + Desire*0.35 + Feasibility*0.20 - RiskPenalty
  riskFlags: string[]        // 위험 요소 라벨
  riskPenalty: number        // 리스크 감점
  evidenceQuotes: EvidenceQuote[]  // 사용자 원문 인용 2-4개 (필수)
  rationale: string          // 추천 이유 3-6문장
  likeReason?: string        // 좋아할 이유 (흥미/가치 연결)
  canReason?: string         // 잘할 이유 (강점/스타일 매칭)
  first30DaysPlan: string[]  // 30일 실행 계획 3개
}

// SearchProfile (RAG 검색용 사용자 프로필)
export interface SearchProfile {
  desiredThemes: string[]         // 원하는 것들
  dislikedThemes: string[]        // 피하고 싶은 것들
  strengthsHypothesis: string[]   // 추정 강점
  environmentPreferences: string[] // 환경 선호
  hardConstraints: string[]       // 절대 조건
  riskSignals: string[]           // 위험 신호
  keywords: string[]              // 검색 키워드
  
  // 🆕 한 줄 메타 요약 (LLM Judge 품질 향상용)
  // 예: "Exploration-ready but low tolerance for social pressure and unpredictability"
  decision_summary?: string
  
  // 🆕 Hard Bias 충돌 정보
  hardBiasConflicts?: {
    hasConflict: boolean
    overallType: 'conservative' | 'exploratory' | 'balanced'
    conflictNames: string[]
  }
}

// ============================================
// Freeze v1.1: SearchProfileV2 확장
// ============================================
// facts, preferences, aversions, axis_coverage 추가
// ============================================

// 명시적 사실 (확정)
export interface FactItem {
  key: string               // 예: "education_level", "current_role"
  value: string             // 예: "대졸", "백엔드 개발자"
  confidence: number        // 0-1
  source: string            // 예: "step1.career_state", "round1.q2"
}

// 선호 (강도 포함)
export interface PreferenceItem {
  theme: string             // 예: "remote_work", "growth_opportunity"
  intensity: 1 | 2 | 3 | 4 | 5  // 선호 강도
  evidenceKey?: string      // 근거 소스
}

// 거부감 (강도 포함)
export interface AversionItem {
  theme: string             // 예: "overtime", "micromanagement"
  intensity: 1 | 2 | 3 | 4 | 5  // 거부감 강도
  evidenceKey?: string      // 근거 소스
}

// 축별 커버리지 상태
export interface AxisCoverageState {
  confidence: number        // 0-1
  evidence: string[]        // 유저 발언 2-5개
  missing: boolean          // 정보 부족 여부
  priority: number          // 0-100 질문 우선순위
}

// SearchProfileV2: Freeze v1.1 확장 버전
export interface SearchProfileV2 extends SearchProfile {
  // 명시적 사실 (확정)
  facts: FactItem[]
  
  // 선호/거부감 (강도 포함)
  preferences: PreferenceItem[]
  aversions: AversionItem[]
  
  // 축별 커버리지 상태
  axis_coverage: {
    interest: AxisCoverageState
    strength: AxisCoverageState
    values: AxisCoverageState
    work_style: AxisCoverageState
    people: AxisCoverageState
    environment: AxisCoverageState
    stress_tolerance: AxisCoverageState
    growth: AxisCoverageState
    risk: AxisCoverageState
    feasibility_constraints: AxisCoverageState
  }
  
  // 메타
  profile_version: number
  generated_at: string
}

// Hard Exclusion 규칙 결과
export interface HardCutItem {
  job_id: string
  job_name: string
  reason: string
  rule_matched: string
}

// Work Style Map (시각화용)
export interface WorkStyleMapData {
  analytical_vs_creative: number    // -100 ~ 100
  solo_vs_team: number              // -100 ~ 100
  structured_vs_flexible: number    // -100 ~ 100
  fast_vs_steady: number            // -100 ~ 100
  guided_vs_autonomous: number      // -100 ~ 100
}

// 전환 타이밍 (30/60/90일)
export interface TransitionTimingData {
  day30: { goal: string; actions: string[]; milestone: string }
  day60: { goal: string; actions: string[]; milestone: string }
  day90: { goal: string; actions: string[]; milestone: string }
}

// Expert Guidance (전문가 조언)
export interface ExpertGuidanceData {
  doNow: string[]              // 당장 할 것
  stopDoing: string[]          // 멈출 것
  experiment: string[]         // 실험할 것
  cognitiveTrapFixes: string[] // 인지 함정 교정 루틴
  conflictResponses: string[]  // 갈등 대응 대체 문장
}

// 프로필 항목 해석 (개별 항목)
export interface ProfileItemInterpretation {
  token: string             // 원본 토큰 (예: "problem_solving")
  label: string             // 한글 라벨 (예: "문제해결")
  meaning: string           // 의미 해석 (예: "복잡한 상황을 분석하고 해결책을 찾는 것에서 에너지를 얻는 타입입니다")
}

// 프로필 해석 전체 (LLM 생성)
export interface ProfileInterpretation {
  // 흥미/관심사 해석
  interests: ProfileItemInterpretation[]
  interests_summary: string    // "당신은 ~하는 것을 좋아하는 사람입니다"

  // 강점 해석
  strengths: ProfileItemInterpretation[]
  strengths_summary: string    // "당신은 ~에 강점을 가진 사람입니다"

  // 가치관 해석
  values: ProfileItemInterpretation[]
  values_summary: string       // "당신에게 ~는 중요한 가치입니다"

  // 제약/회피 해석
  constraints: ProfileItemInterpretation[]
  constraints_summary: string  // "당신은 ~를 피하고 싶어하는 타입입니다"

  // 종합 프로필 해석
  overall_profile: string      // 전체 프로필을 종합한 1-2문장
}

// ============================================
// 메타인지 결과 (MetaCognition Tab)
// 자기 이해 중심의 상담 스타일 분석
// ============================================

// 강점/약점 항목 (의미 해석 포함)
export interface ArsenalItem {
  trait: string       // 특성 (예: "분석력")
  meaning: string     // 왜 이게 강점/약점인지 상담 스타일 설명
}

// 선호도 항목 (WHY 포함)
export interface PreferenceMapItem {
  item: string        // 항목 (예: "문제해결", "반복업무")
  why: string         // 왜 좋아하는지/싫어하는지 심리적 해석
}

// 스트레스/회복 항목 (WHY 포함)
export interface StressRecoveryItem {
  factor: string      // 요인 (예: "시간 압박")
  why: string         // 왜 스트레스인지/회복되는지 해석
}

// 메타인지 결과 전체
export interface MetaCognitionResult {
  // 1️⃣ 나의 무기고
  myArsenal: {
    strengths: ArsenalItem[]    // 강점 + 왜 이게 강점인지
    weaknesses: ArsenalItem[]   // 약점 + 극복 방향
    counselorNote?: string      // 강점 관련 상담사 조언
  }

  // 2️⃣ 선호도 지도
  preferenceMap: {
    likes: PreferenceMapItem[]      // 좋아하는 것 + 왜
    fits: PreferenceMapItem[]       // 잘 맞는 것 + 왜
    dislikes: PreferenceMapItem[]   // 안 맞는 것 + 왜
    counselorNote?: string          // 선호도 관련 상담사 조언
  }

  // 3️⃣ 내면 탐구
  innerExploration: {
    valueAnalysis: string       // 핵심 가치관 분석 (상담 스타일)
    identityInsight: string     // 정체성 인식 ("당신은 ~ 사람입니다")
    innerConflicts: string      // 내적 갈등과 의미 (있으면)
  }

  // 4️⃣ 스트레스 & 회복
  stressRecovery: {
    stressFactors: StressRecoveryItem[]    // 스트레스 요인 + 왜
    recoveryMethods: StressRecoveryItem[]  // 회복 방법 + 왜 효과적인지
    counselorNote?: string                 // 스트레스 관련 상담사 조언
  }

  // 5️⃣ 성장 가능성
  growthPotential: {
    direction: string           // 성장 방향 제안
    leveragePoints: string[]    // 활용할 수 있는 강점
    counselorNote: string       // 상담사 스타일 조언
  }

  // 메타 정보
  _meta?: {
    generated_by: 'llm' | 'rule' | 'hybrid'
    confidence?: number
  }
}

// V3 Premium Report (LLM+RAG 기반)
export interface PremiumReportV3 {
  // 메타 정보
  report_id: string
  engine_version: 'v3'
  generated_at: string
  session_id: string

  // 0. Profile Interpretation (프로필 해석)
  profileInterpretation?: ProfileInterpretation

  // 0.5 MetaCognition (메타인지 - 자기 이해 중심 분석)
  metaCognition?: MetaCognitionResult

  // 1. Executive Summary
  executiveSummary: string
  
  // 2. Work Style Map
  workStyleMap: WorkStyleMapData
  workStyleNarrative: string
  
  // 3. Inner Conflict Analysis
  innerConflictAnalysis: string
  conflictPatterns: string[]
  
  // 4. Failure Pattern & Stress Profile
  failurePattern: string
  stressProfile: string
  stressTriggers: string[]
  
  // 5. Growth Curve Type
  growthCurveType: string
  growthCurveDescription: string
  
  // 6. Transition Timing (30/60/90)
  transitionTiming: TransitionTimingData
  
  // 7. Life Version Statement
  lifeVersionStatement: {
    oneLiner: string        // 1문장 정의
    expanded: string[]      // 3문장 확장
  }
  
  // 8. Job Recommendations (3세트)
  jobRecommendations: {
    overallTop5: LLMJudgeResult[]   // 종합 Top5
    fitTop10: LLMJudgeResult[]      // Fit 기준 Top10
    desireTop10: LLMJudgeResult[]   // Desire 기준 Top10
  }
  
  // 9. Expert Guidance
  expertGuidance: ExpertGuidanceData
  
  // 10. Appendix
  appendix: {
    hardCutList: HardCutItem[]      // 제외된 직업 목록
    evidenceIndex: EvidenceQuote[]  // 전체 인용 인덱스
    totalCandidatesSearched: number
    totalCandidatesJudged: number
  }
  
  // 안전 규칙 준수 여부
  safetyCompliance: {
    noDiagnosticTerms: boolean      // 진단명 단정 없음
    professionalHelpSuggested: boolean  // 전문가 도움 권유 포함 여부
  }
}

// V3 분석 요청 확장
export interface AnalysisRequestPayloadV3Extended extends AnalysisRequestPayloadV3 {
  // 서술형 답변
  narrative_facts?: NarrativeFacts
  // 3라운드 심층 질문 답변
  round_answers?: RoundAnswer[]
  // 엔진 버전
  engine_version?: 'v2' | 'v3'
}

// V3 분석 결과 확장
export interface AnalysisResultJSONV3 extends AnalysisResultJSON {
  // V3 프리미엄 리포트
  premium_report?: PremiumReportV3
  // 엔진 버전
  engine_version: 'v2' | 'v3'
}

// ScoredJob 타입 (기존 호환 + 확장)
export interface ScoredJob {
  job_id: string
  job_name: string
  slug?: string           // 커리어위키 URL 슬러그
  image_url?: string      // 직업 썸네일 이미지
  job_description?: string  // 직업 설명 (추천 결과에 표시용)
  rationale?: string       // 추천 근거 요약
  likeReason?: string      // Like 점수 근거
  canReason?: string       // Can 점수 근거
  riskWarning?: string     // Risk 경고
  base_like?: number
  base_can?: number
  base_risk?: number
  like_score?: number
  can_score?: number
  risk_penalty?: number
  final_score?: number
  entry_level_friendly?: boolean
  attributes?: Record<string, number | string>
  // V3 확장
  scores?: {
    fit: number
    like: number
    can: number
    risk_penalty: number
  }
  vector_score?: number
  tag_source?: 'tagged' | 'vector_only'
}

