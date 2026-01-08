// CareerWiki AI Analyzer - Job Attributes Types
// Version: tagger-v1.0.0 (Phase 1B)
// 직업 태깅 스키마 정의

// ============================================
// 버전 상수
// ============================================
export const TAGGER_VERSION = 'tagger-v1.0.0'

// ============================================
// Enum Types
// ============================================

export type WorkHoursType = 'regular' | 'overtime_some' | 'overtime_frequent'
export type ShiftWorkType = 'none' | 'possible' | 'required'
export type TravelType = 'none' | 'some' | 'frequent'
export type RemotePossibleType = 'none' | 'partial' | 'full'
export type DegreeRequiredType = 'none' | 'college' | 'bachelor' | 'master' | 'phd'
export type LicenseRequiredType = 'none' | 'preferred' | 'required' | 'multiple_required'
export type ExperienceRequiredType = 'none' | 'entry' | 'junior' | 'mid' | 'senior'

// ============================================
// Tagging Status (운영용)
// ============================================
export const VALID_TAGGING_STATUS = ['pending', 'stubbed', 'tagged', 'needs_review'] as const
export type TaggingStatus = typeof VALID_TAGGING_STATUS[number]

export function validateTaggingStatus(status: string): status is TaggingStatus {
  return VALID_TAGGING_STATUS.includes(status as TaggingStatus)
}

// ============================================
// Evidence Types
// ============================================

export interface EvidenceItem {
  source: string          // 'duties', 'environment', 'salary_info', 'requirements'
  snippet: string         // 근거 텍스트 (최대 200자)
  weight: number          // 0~1 (영향도)
}

export interface EvidenceMap {
  [field: string]: EvidenceItem[]
}

// ============================================
// Field Confidence Type
// ============================================

export interface FieldConfidence {
  wlb: number
  growth: number
  stability: number
  income: number
  remote_possible: number
  work_hours: number
  shift_work: number
  travel: number
  degree_required: number
  license_required: number
  teamwork: number
  solo_deep: number
  analytical: number
  creative: number
  execution: number
  people_facing: number
}

// ============================================
// Main Job Attributes Type
// ============================================

export interface JobAttributes {
  // 식별
  job_id: string
  job_name: string
  source_system: 'CAREERNET' | 'WORK24_JOB' | 'MERGED'
  
  // 버전
  tagger_version: string
  
  // ============================================
  // 핵심 Attributes (0~100 스케일)
  // ============================================
  
  // Work-Life Balance 관련
  wlb: number                           // 워라밸 점수 0~100
  work_hours: WorkHoursType             // 근무시간 유형
  shift_work: ShiftWorkType             // 교대근무 여부
  travel: TravelType                    // 출장 빈도
  remote_possible: RemotePossibleType   // 원격근무 가능성
  
  // Career Growth 관련
  growth: number                        // 성장 가능성 0~100
  stability: number                     // 안정성 0~100
  income: number                        // 수입 수준 0~100
  
  // Work Style 관련
  teamwork: number                      // 협업 비중 0~100
  solo_deep: number                     // 집중 업무 비중 0~100
  analytical: number                    // 분석적 업무 0~100
  creative: number                      // 창의적 업무 0~100
  execution: number                     // 실행/운영 업무 0~100
  people_facing: number                 // 대인 업무 0~100
  
  // Requirements (Constraint 관련)
  degree_required: DegreeRequiredType
  license_required: LicenseRequiredType
  experience_required: ExperienceRequiredType
  
  // ============================================
  // Confidence Scores (0~1)
  // ============================================
  _confidence: number                   // 전체 신뢰도 0~1
  _field_confidence: FieldConfidence    // 필드별 신뢰도 0~1
  
  // ============================================
  // Evidence (추적용)
  // ============================================
  evidence: EvidenceMap                 // 필드별 근거
}

// ============================================
// Tagging Input (job_sources 원본)
// ============================================

export interface JobSourceInput {
  job_id: string
  job_name: string
  source_system: string
  normalized_payload: {
    name: string
    duties?: string
    environment?: string
    qualifications?: string
    outlook?: string
    salary_info?: string
    related_majors?: string[]
    related_licenses?: string[]
    classifications?: {
      large?: string
      medium?: string
      small?: string
    }
  }
}

// ============================================
// Tagger Output (D1 저장용)
// ============================================

export interface JobAttributesRow {
  job_id: string
  job_name: string
  source_system: string
  tagger_version: string
  
  // Status (운영용)
  status: TaggingStatus           // 'pending' | 'stubbed' | 'tagged' | 'needs_review'
  
  // Numeric attributes
  wlb: number
  growth: number
  stability: number
  income: number
  teamwork: number
  solo_deep: number
  analytical: number
  creative: number
  execution: number
  people_facing: number
  
  // Categorical attributes
  work_hours: string
  shift_work: string
  travel: string
  remote_possible: string
  degree_required: string
  license_required: string
  experience_required: string
  
  // Confidence
  _confidence: number
  _field_confidence_json: string  // JSON.stringify(FieldConfidence)
  
  // Evidence
  evidence_json: string           // JSON.stringify(EvidenceMap)
  
  // Raw source (디버깅용)
  raw_source_json: string
}

// ============================================
// QA Thresholds (Phase 1B 합격선)
// ============================================

export const QA_THRESHOLDS = {
  // 전체 합격선
  MIN_CONFIDENCE: 0.7,
  
  // 필드별 합격선
  wlb: 0.85,                      // 85%+
  degree_required: 0.90,          // 90%+
  license_required: 0.90,         // 90%+
  
  // Constraint 관련 필드 (false positive 최소화)
  remote_possible: 0.85,
  work_hours: 0.85,
  shift_work: 0.85,
  travel: 0.80,
  
  // 일반 필드
  DEFAULT: 0.75,
}

// ============================================
// Batch Processing Types
// ============================================

export interface TaggerBatchConfig {
  batchSize: number               // 한 번에 처리할 job 수
  maxRetries: number              // 최대 재시도 횟수
  retryDelayMs: number            // 재시도 대기 시간
  saveIntervalMs: number          // 중간 저장 간격
  timeoutMs: number               // 단일 job 타임아웃
}

export const DEFAULT_BATCH_CONFIG: TaggerBatchConfig = {
  batchSize: 50,
  maxRetries: 3,
  retryDelayMs: 1000,
  saveIntervalMs: 60000,          // 1분마다 저장
  timeoutMs: 30000,               // 30초 타임아웃
}

export interface TaggerRunResult {
  run_id: string
  tagger_version: string
  total_jobs: number
  processed_jobs: number
  failed_jobs: number
  qa_passed: number
  qa_failed: number
  avg_confidence: number
  started_at: string
  completed_at: string
  errors: TaggerError[]
}

export interface TaggerError {
  job_id: string
  error_type: 'parse_error' | 'api_error' | 'validation_error' | 'timeout'
  error_message: string
  retry_count: number
}

// ============================================
// QA Report Types
// ============================================

export interface QAReport {
  run_id: string
  tagger_version: string
  generated_at: string
  
  // Summary
  total_jobs: number
  passed_jobs: number
  failed_jobs: number
  pass_rate: number
  
  // Field Stats
  field_stats: {
    [field: string]: {
      avg_confidence: number
      min_confidence: number
      max_confidence: number
      pass_rate: number
      fail_count: number
    }
  }
  
  // Source Stats
  source_stats: {
    [source: string]: {
      count: number
      avg_confidence: number
      pass_rate: number
    }
  }
  
  // Low Confidence Jobs (상위 100개)
  low_confidence_jobs: Array<{
    job_id: string
    job_name: string
    confidence: number
    weak_fields: string[]
  }>
  
  // Confusion Matrix (가능하면)
  confusion_matrix?: {
    [field: string]: {
      true_positive: number
      true_negative: number
      false_positive: number
      false_negative: number
    }
  }
}

// ============================================
// Tagger Prompts Config
// ============================================

export interface TaggerPromptConfig {
  model: string
  temperature: number
  max_tokens: number
  system_prompt: string
  user_prompt_template: string
}

export const DEFAULT_TAGGER_PROMPT: TaggerPromptConfig = {
  model: 'gemini-1.5-flash',
  temperature: 0.1,              // 일관성 위해 낮은 temperature
  max_tokens: 2000,
  
  system_prompt: `You are a job attribute tagger for CareerWiki.
Your task is to analyze job information and extract structured attributes.
Be conservative with confidence scores - only give high confidence (>0.9) when evidence is clear.
For constraint-related fields (degree_required, license_required, remote_possible, work_hours, shift_work), minimize false positives.

Output ONLY valid JSON matching the schema, no explanation.`,

  user_prompt_template: `Analyze this job and extract attributes:

Job Name: {{job_name}}
Duties: {{duties}}
Environment: {{environment}}
Qualifications: {{qualifications}}
Salary Info: {{salary_info}}

Extract these attributes with confidence scores (0-1):
1. wlb (0-100): Work-life balance score
2. work_hours: "regular" | "overtime_some" | "overtime_frequent"
3. shift_work: "none" | "possible" | "required"
4. travel: "none" | "some" | "frequent"
5. remote_possible: "none" | "partial" | "full"
6. growth (0-100): Career growth potential
7. stability (0-100): Job stability
8. income (0-100): Income level
9. teamwork (0-100): Team collaboration %
10. solo_deep (0-100): Solo deep work %
11. analytical (0-100): Analytical work %
12. creative (0-100): Creative work %
13. execution (0-100): Execution/operations %
14. people_facing (0-100): Client-facing work %
15. degree_required: "none" | "college" | "bachelor" | "master" | "phd"
16. license_required: "none" | "preferred" | "required" | "multiple_required"

Return JSON with _confidence (overall 0-1), _field_confidence (per field 0-1), and evidence.`,
}

