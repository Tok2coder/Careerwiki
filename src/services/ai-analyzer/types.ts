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
  | 'tradeoff'     // 트레이드오프형 (기존)
  | 'narrative'    // 서사형 (왜?)
  | 'pattern'      // 패턴형 (반복되는 성향)
  | 'priority'     // 우선순위형
  | 'clarification' // 명확화형
  | 'discovery'    // 자기발견형 (기존)

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

// 7. 학습/전환 로드맵
export interface RoadmapMilestone {
  title: string
  tasks: string[]
}

export interface LearningRoadmapSection {
  _meta: SectionMeta
  timeline: '2w' | '1m' | '3m'        // 권장 기간
  milestones: RoadmapMilestone[]
}

// 8. 다음 질문 (업그레이드용)
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
  
  // 8개 섹션
  summary_one_page: SummaryOnePageSection
  personal_analysis: PersonalAnalysisSection
  key_hypotheses: KeyHypothesesSection
  recommendations_top: TopRecommendationsSection
  recommendations_hold: HoldRecommendationsSection
  plan_b_paths: PlanBPathsSection
  learning_roadmap: LearningRoadmapSection
  next_questions: NextQuestionsSection
}

