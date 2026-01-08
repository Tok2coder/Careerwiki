// CareerWiki AI Analyzer - Job Attributes Tagger Batch
// Version: tagger-v1.0.0 (Phase 1B)
// 7,000개 job_id 태깅 배치 스크립트

import {
  TAGGER_VERSION,
  DEFAULT_BATCH_CONFIG,
  QA_THRESHOLDS,
  DEFAULT_TAGGER_PROMPT,
  type JobSourceInput,
  type JobAttributes,
  type JobAttributesRow,
  type TaggerBatchConfig,
  type TaggerRunResult,
  type TaggerError,
  type FieldConfidence,
  type EvidenceMap,
} from './job-attributes-types'

// ============================================
// 골든셋 30개 Job IDs (Phase 1A에서 추출)
// ============================================
export const GOLDEN_SET_JOB_IDS = [
  '1765283336012159',  // 신경회로망연구원
  '1765283417801846',  // 영업기획·관리·지원사무원
  '1765283342883899',  // 여행안내원
  '1765283511988597',  // 산업전기공
  '1765283524074267',  // 음료제조기계조작원
  '1765283478490375',  // 선박객실승무원
  '1765283356043947',  // 인공위성개발원
  '1765283388569335',  // 텔레마케터
  '1765283362349517',  // 작가
  '176528336819584',   // 전통건축원
  '1765283402203809',  // 홍보도우미
  '1765283464036549',  // 방사선과의사
  '1765283347229975',  // 요리배달원
  '1765283338755480',  // 악기제조원
  '1765283495071884',  // 조적원
  '1765283500263981',  // 건설 및 채굴기계운전원
  '1765283380337288',  // 청소원
  '1765283287536467',  // 관세사
  '1765283489490514',  // 매장계산원 및 요금정산원
  '1765283347734670',  // 우편물집배원
  '1765283399808629',  // 해양학연구원
  '1765283533075562',  // 어부 및 해녀
  '1765283326911230',  // 설문조사원
  '1765283353963190',  // 응급구조사
  '1765283372476790',  // 조각가
  '1765283379244745',  // 철골공
  '1765283390424267',  // 통신엔지니어
  '1765283452152824',  // 소음진동기술자 및 연구원
  '1765283334995231',  // 시인
  '1765283483166227',  // 시설·특수경비원
]

// ============================================
// Tagger Core Logic
// ============================================

export interface TaggerContext {
  db: D1Database
  geminiApiKey: string | null  // null 허용 (스텁 모드)
  config: TaggerBatchConfig
  runId: string
}

interface D1Database {
  prepare(sql: string): D1PreparedStatement
}

interface D1PreparedStatement {
  bind(...values: unknown[]): D1PreparedStatement
  run(): Promise<D1Result>
  first<T = unknown>(): Promise<T | null>
  all<T = unknown>(): Promise<D1Results<T>>
}

interface D1Result {
  success: boolean
  meta: { duration: number }
}

interface D1Results<T> {
  results: T[]
  success: boolean
}

/**
 * 단일 job 태깅 (LLM 호출 또는 스텁)
 */
export async function tagSingleJob(
  job: JobSourceInput,
  geminiApiKey: string | null
): Promise<JobAttributes> {
  // API 키가 없으면 스텁 태깅 사용
  if (!geminiApiKey || geminiApiKey === '') {
    return tagSingleJobStub(job)
  }
  
  const payload = job.normalized_payload
  
  // 프롬프트 생성
  const userPrompt = DEFAULT_TAGGER_PROMPT.user_prompt_template
    .replace('{{job_name}}', payload.name || job.job_name)
    .replace('{{duties}}', payload.duties || '정보 없음')
    .replace('{{environment}}', payload.environment || '정보 없음')
    .replace('{{qualifications}}', payload.qualifications || '정보 없음')
    .replace('{{salary_info}}', payload.salary_info || '정보 없음')
  
  try {
    // Gemini API 호출 (올바른 엔드포인트)
    const modelName = DEFAULT_TAGGER_PROMPT.model.replace('gemini-', '')
    const apiUrl = `https://generativelanguage.googleapis.com/v1beta/models/${modelName}:generateContent?key=${geminiApiKey}`
    
    const response = await fetch(apiUrl, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        contents: [
          {
            role: 'user',
            parts: [
              { text: DEFAULT_TAGGER_PROMPT.system_prompt },
              { text: userPrompt },
            ],
          },
        ],
        generationConfig: {
          temperature: DEFAULT_TAGGER_PROMPT.temperature,
          maxOutputTokens: DEFAULT_TAGGER_PROMPT.max_tokens,
        },
      }),
    })
    
    if (!response.ok) {
      const errorText = await response.text()
      throw new Error(`Gemini API error: ${response.status} ${response.statusText} - ${errorText}`)
    }
    
    const result = await response.json() as {
      candidates?: Array<{
        content?: {
          parts?: Array<{ text?: string }>
        }
      }>
    }
    
    const text = result.candidates?.[0]?.content?.parts?.[0]?.text
    if (!text) {
      throw new Error('Empty response from Gemini')
    }
    
    // JSON 파싱 (코드블록 제거)
    const jsonMatch = text.match(/```json\s*([\s\S]*?)\s*```/) || text.match(/\{[\s\S]*\}/)
    if (!jsonMatch) {
      throw new Error('Failed to parse JSON from response')
    }
    
    const rawAttrs = JSON.parse(jsonMatch[1] || jsonMatch[0])
    
    // 스키마 검증 및 정규화
    return normalizeAttributes(job, rawAttrs)
    
  } catch (error) {
    // API 실패 시 스텁 태깅으로 폴백
    console.warn(`Gemini API failed for job ${job.job_id}, using stub:`, error)
    return tagSingleJobStub(job)
  }
}

/**
 * 스텁 태깅 (규칙 기반 기본값 생성)
 */
function tagSingleJobStub(job: JobSourceInput): JobAttributes {
  const payload = job.normalized_payload
  const jobName = payload.name || job.job_name || ''
  const duties = (payload.duties || '').toLowerCase()
  const qualifications = (payload.qualifications || '').toLowerCase()
  
  // 규칙 기반 추론
  const isResearch = jobName.includes('연구') || jobName.includes('개발') || duties.includes('연구')
  const isCreative = jobName.includes('디자인') || jobName.includes('작가') || jobName.includes('예술')
  const isService = jobName.includes('서비스') || jobName.includes('고객') || jobName.includes('상담')
  const isTechnical = jobName.includes('엔지니어') || jobName.includes('기술') || jobName.includes('개발')
  const isMedical = jobName.includes('의사') || jobName.includes('간호') || jobName.includes('의료')
  const isEducation = jobName.includes('교사') || jobName.includes('교육')
  const isSales = jobName.includes('영업') || jobName.includes('판매')
  
  // 기본값 설정 (보수적)
  const wlb = isResearch ? 70 : isService ? 50 : isMedical ? 40 : 60
  const growth = isResearch ? 85 : isTechnical ? 80 : isService ? 60 : 70
  const stability = isEducation ? 95 : isMedical ? 90 : isResearch ? 70 : 75
  const income = isMedical ? 85 : isTechnical ? 80 : isSales ? 75 : 65
  
  const teamwork = isService ? 90 : isSales ? 80 : isResearch ? 50 : 60
  const soloDeep = isResearch ? 70 : isCreative ? 80 : 40
  const analytical = isResearch ? 90 : isTechnical ? 85 : 50
  const creative = isCreative ? 90 : isResearch ? 60 : 40
  const execution = isService ? 80 : isSales ? 75 : 60
  const peopleFacing = isService ? 95 : isSales ? 90 : isEducation ? 85 : 40
  
  // Constraint 관련 (보수적)
  const hasDegree = qualifications.includes('학사') || qualifications.includes('학위') || qualifications.includes('대학')
  const hasLicense = qualifications.includes('자격증') || qualifications.includes('면허') || qualifications.includes('자격')
  const hasShift = duties.includes('교대') || duties.includes('야간') || duties.includes('주말')
  const hasTravel = duties.includes('출장') || duties.includes('외근')
  const hasRemote = duties.includes('재택') || duties.includes('원격') || duties.includes('온라인')
  const hasOvertime = duties.includes('야근') || duties.includes('초과근무')
  
  // Confidence (스텁이므로 낮게 설정)
  const fieldConf: FieldConfidence = {
    wlb: 0.75,
    growth: 0.75,
    stability: 0.75,
    income: 0.70,
    remote_possible: hasRemote ? 0.80 : 0.70,
    work_hours: hasOvertime ? 0.80 : 0.75,
    shift_work: hasShift ? 0.85 : 0.75,
    travel: hasTravel ? 0.80 : 0.75,
    degree_required: hasDegree ? 0.85 : 0.70,
    license_required: hasLicense ? 0.85 : 0.70,
    teamwork: 0.75,
    solo_deep: 0.75,
    analytical: 0.75,
    creative: 0.75,
    execution: 0.75,
    people_facing: 0.75,
  }
  
  return {
    job_id: job.job_id,
    job_name: job.job_name,
    source_system: job.source_system as 'CAREERNET' | 'WORK24_JOB' | 'MERGED',
    tagger_version: TAGGER_VERSION,
    
    wlb,
    growth,
    stability,
    income,
    teamwork,
    solo_deep,
    analytical,
    creative,
    execution,
    people_facing,
    
    work_hours: hasOvertime ? 'overtime_some' : 'regular',
    shift_work: hasShift ? 'possible' : 'none',
    travel: hasTravel ? 'some' : 'none',
    remote_possible: hasRemote ? 'partial' : 'none',
    degree_required: hasDegree ? 'bachelor' : 'none',
    license_required: hasLicense ? 'required' : 'none',
    experience_required: 'entry',
    
    _confidence: 0.75,  // 스텁이므로 보수적
    _field_confidence: fieldConf,
    evidence: {
      wlb: [{ source: 'duties', snippet: duties.substring(0, 100), weight: 0.7 }],
      degree_required: [{ source: 'qualifications', snippet: qualifications.substring(0, 100), weight: 0.8 }],
    },
  }
}

/**
 * LLM 출력을 정규화된 JobAttributes로 변환
 */
function normalizeAttributes(job: JobSourceInput, raw: Record<string, unknown>): JobAttributes {
  // 기본값으로 초기화
  const defaultFieldConfidence: FieldConfidence = {
    wlb: 0.5, growth: 0.5, stability: 0.5, income: 0.5,
    remote_possible: 0.5, work_hours: 0.5, shift_work: 0.5, travel: 0.5,
    degree_required: 0.5, license_required: 0.5,
    teamwork: 0.5, solo_deep: 0.5, analytical: 0.5, creative: 0.5,
    execution: 0.5, people_facing: 0.5,
  }
  
  // 값 추출 (범위 검증 포함)
  const clamp = (val: unknown, min: number, max: number): number => {
    const num = typeof val === 'number' ? val : parseInt(String(val), 10)
    return isNaN(num) ? (min + max) / 2 : Math.max(min, Math.min(max, num))
  }
  
  const validateEnum = <T extends string>(val: unknown, allowed: T[], fallback: T): T => {
    return allowed.includes(val as T) ? (val as T) : fallback
  }
  
  // Field confidence 추출
  const rawFieldConf = raw._field_confidence as Record<string, number> | undefined
  const fieldConfidence: FieldConfidence = {
    wlb: rawFieldConf?.wlb ?? 0.5,
    growth: rawFieldConf?.growth ?? 0.5,
    stability: rawFieldConf?.stability ?? 0.5,
    income: rawFieldConf?.income ?? 0.5,
    remote_possible: rawFieldConf?.remote_possible ?? 0.5,
    work_hours: rawFieldConf?.work_hours ?? 0.5,
    shift_work: rawFieldConf?.shift_work ?? 0.5,
    travel: rawFieldConf?.travel ?? 0.5,
    degree_required: rawFieldConf?.degree_required ?? 0.5,
    license_required: rawFieldConf?.license_required ?? 0.5,
    teamwork: rawFieldConf?.teamwork ?? 0.5,
    solo_deep: rawFieldConf?.solo_deep ?? 0.5,
    analytical: rawFieldConf?.analytical ?? 0.5,
    creative: rawFieldConf?.creative ?? 0.5,
    execution: rawFieldConf?.execution ?? 0.5,
    people_facing: rawFieldConf?.people_facing ?? 0.5,
  }
  
  // Evidence 추출
  const evidence = (raw.evidence as EvidenceMap) || {}
  
  return {
    job_id: job.job_id,
    job_name: job.job_name,
    source_system: job.source_system as 'CAREERNET' | 'WORK24_JOB' | 'MERGED',
    tagger_version: TAGGER_VERSION,
    
    // Numeric attributes
    wlb: clamp(raw.wlb, 0, 100),
    growth: clamp(raw.growth, 0, 100),
    stability: clamp(raw.stability, 0, 100),
    income: clamp(raw.income, 0, 100),
    teamwork: clamp(raw.teamwork, 0, 100),
    solo_deep: clamp(raw.solo_deep, 0, 100),
    analytical: clamp(raw.analytical, 0, 100),
    creative: clamp(raw.creative, 0, 100),
    execution: clamp(raw.execution, 0, 100),
    people_facing: clamp(raw.people_facing, 0, 100),
    
    // Categorical attributes
    work_hours: validateEnum(raw.work_hours, ['regular', 'overtime_some', 'overtime_frequent'], 'regular'),
    shift_work: validateEnum(raw.shift_work, ['none', 'possible', 'required'], 'none'),
    travel: validateEnum(raw.travel, ['none', 'some', 'frequent'], 'none'),
    remote_possible: validateEnum(raw.remote_possible, ['none', 'partial', 'full'], 'none'),
    degree_required: validateEnum(raw.degree_required, ['none', 'college', 'bachelor', 'master', 'phd'], 'none'),
    license_required: validateEnum(raw.license_required, ['none', 'preferred', 'required', 'multiple_required'], 'none'),
    experience_required: validateEnum(raw.experience_required, ['none', 'entry', 'junior', 'mid', 'senior'], 'none'),
    
    // Confidence
    _confidence: typeof raw._confidence === 'number' ? raw._confidence : 0.5,
    _field_confidence: fieldConfidence,
    
    // Evidence
    evidence,
  }
}

/**
 * QA 검증 (합격선 체크)
 */
export function validateQA(attrs: JobAttributes): { passed: boolean; failedFields: string[] } {
  const failedFields: string[] = []
  
  // 필드별 합격선 체크
  const checks: Array<{ field: keyof FieldConfidence; threshold: number }> = [
    { field: 'wlb', threshold: QA_THRESHOLDS.wlb },
    { field: 'degree_required', threshold: QA_THRESHOLDS.degree_required },
    { field: 'license_required', threshold: QA_THRESHOLDS.license_required },
    { field: 'remote_possible', threshold: QA_THRESHOLDS.remote_possible },
    { field: 'work_hours', threshold: QA_THRESHOLDS.work_hours },
    { field: 'shift_work', threshold: QA_THRESHOLDS.shift_work },
    { field: 'travel', threshold: QA_THRESHOLDS.travel },
  ]
  
  for (const { field, threshold } of checks) {
    if (attrs._field_confidence[field] < threshold) {
      failedFields.push(field)
    }
  }
  
  // 전체 confidence 체크
  if (attrs._confidence < QA_THRESHOLDS.MIN_CONFIDENCE) {
    failedFields.push('_confidence')
  }
  
  return {
    passed: failedFields.length === 0,
    failedFields,
  }
}

/**
 * JobAttributes를 DB Row로 변환
 */
export function toDbRow(attrs: JobAttributes, rawSource: JobSourceInput): JobAttributesRow {
  return {
    job_id: attrs.job_id,
    job_name: attrs.job_name,
    source_system: attrs.source_system,
    tagger_version: attrs.tagger_version,
    
    wlb: attrs.wlb,
    growth: attrs.growth,
    stability: attrs.stability,
    income: attrs.income,
    teamwork: attrs.teamwork,
    solo_deep: attrs.solo_deep,
    analytical: attrs.analytical,
    creative: attrs.creative,
    execution: attrs.execution,
    people_facing: attrs.people_facing,
    
    work_hours: attrs.work_hours,
    shift_work: attrs.shift_work,
    travel: attrs.travel,
    remote_possible: attrs.remote_possible,
    degree_required: attrs.degree_required,
    license_required: attrs.license_required,
    experience_required: attrs.experience_required,
    
    _confidence: attrs._confidence,
    _field_confidence_json: JSON.stringify(attrs._field_confidence),
    evidence_json: JSON.stringify(attrs.evidence),
    raw_source_json: JSON.stringify(rawSource),
  }
}

/**
 * D1에 upsert
 */
export async function upsertJobAttributes(
  db: D1Database,
  row: JobAttributesRow
): Promise<void> {
  await db.prepare(`
    INSERT INTO job_attributes (
      job_id, job_name, source_system, tagger_version,
      wlb, growth, stability, income, teamwork, solo_deep, analytical, creative, execution, people_facing,
      work_hours, shift_work, travel, remote_possible, degree_required, license_required, experience_required,
      _confidence, _field_confidence_json, evidence_json, raw_source_json, updated_at
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
    ON CONFLICT(job_id) DO UPDATE SET
      job_name = excluded.job_name,
      source_system = excluded.source_system,
      tagger_version = excluded.tagger_version,
      wlb = excluded.wlb,
      growth = excluded.growth,
      stability = excluded.stability,
      income = excluded.income,
      teamwork = excluded.teamwork,
      solo_deep = excluded.solo_deep,
      analytical = excluded.analytical,
      creative = excluded.creative,
      execution = excluded.execution,
      people_facing = excluded.people_facing,
      work_hours = excluded.work_hours,
      shift_work = excluded.shift_work,
      travel = excluded.travel,
      remote_possible = excluded.remote_possible,
      degree_required = excluded.degree_required,
      license_required = excluded.license_required,
      experience_required = excluded.experience_required,
      _confidence = excluded._confidence,
      _field_confidence_json = excluded._field_confidence_json,
      evidence_json = excluded.evidence_json,
      raw_source_json = excluded.raw_source_json,
      updated_at = CURRENT_TIMESTAMP
  `).bind(
    row.job_id, row.job_name, row.source_system, row.tagger_version,
    row.wlb, row.growth, row.stability, row.income, row.teamwork, row.solo_deep,
    row.analytical, row.creative, row.execution, row.people_facing,
    row.work_hours, row.shift_work, row.travel, row.remote_possible,
    row.degree_required, row.license_required, row.experience_required,
    row._confidence, row._field_confidence_json, row.evidence_json, row.raw_source_json
  ).run()
}

// ============================================
// Batch Runner
// ============================================

export interface BatchProgress {
  total: number
  processed: number
  passed: number
  failed: number
  errors: TaggerError[]
}

/**
 * 배치 태깅 실행
 */
export async function runTaggerBatch(
  ctx: TaggerContext,
  jobIds: string[],
  onProgress?: (progress: BatchProgress) => void
): Promise<TaggerRunResult> {
  const startedAt = new Date().toISOString()
  const progress: BatchProgress = {
    total: jobIds.length,
    processed: 0,
    passed: 0,
    failed: 0,
    errors: [],
  }
  
  // 배치 실행 기록 생성
  await ctx.db.prepare(`
    INSERT INTO tagger_runs (run_id, tagger_version, total_jobs, status)
    VALUES (?, ?, ?, 'running')
  `).bind(ctx.runId, TAGGER_VERSION, jobIds.length).run()
  
  // 배치 처리
  for (let i = 0; i < jobIds.length; i += ctx.config.batchSize) {
    const batchJobIds = jobIds.slice(i, i + ctx.config.batchSize)
    
    for (const jobId of batchJobIds) {
      try {
        // 1. job_sources에서 데이터 조회
        const job = await ctx.db.prepare(`
          SELECT job_id, source_system, normalized_payload
          FROM job_sources
          WHERE job_id = ?
        `).bind(jobId).first<{
          job_id: string
          source_system: string
          normalized_payload: string
        }>()
        
        if (!job) {
          throw new Error(`Job not found: ${jobId}`)
        }
        
        const jobInput: JobSourceInput = {
          job_id: job.job_id,
          job_name: '',
          source_system: job.source_system,
          normalized_payload: JSON.parse(job.normalized_payload),
        }
        jobInput.job_name = jobInput.normalized_payload.name || job.job_id
        
        // 2. 태깅 실행 (재시도 로직)
        let attrs: JobAttributes | null = null
        let lastError: Error | null = null
        
        for (let retry = 0; retry <= ctx.config.maxRetries; retry++) {
          try {
            attrs = await tagSingleJob(jobInput, ctx.geminiApiKey)
            break
          } catch (err) {
            lastError = err instanceof Error ? err : new Error(String(err))
            if (retry < ctx.config.maxRetries) {
              await sleep(ctx.config.retryDelayMs * (retry + 1))
            }
          }
        }
        
        if (!attrs) {
          throw lastError || new Error('Unknown tagging error')
        }
        
        // 3. QA 검증
        const qa = validateQA(attrs)
        
        // 4. D1 저장
        const row = toDbRow(attrs, jobInput)
        await upsertJobAttributes(ctx.db, row)
        
        // 5. 진행 상황 업데이트
        progress.processed++
        if (qa.passed) {
          progress.passed++
        } else {
          progress.failed++
          // QA 실패도 에러로 기록 (warning 수준)
        }
        
      } catch (err) {
        progress.processed++
        progress.failed++
        
        const error: TaggerError = {
          job_id: jobId,
          error_type: categorizeError(err),
          error_message: err instanceof Error ? err.message : String(err),
          retry_count: ctx.config.maxRetries,
        }
        progress.errors.push(error)
        
        // 에러 DB 기록
        await ctx.db.prepare(`
          INSERT INTO tagger_errors (run_id, job_id, error_type, error_message, retry_count)
          VALUES (?, ?, ?, ?, ?)
          ON CONFLICT(run_id, job_id) DO UPDATE SET
            error_type = excluded.error_type,
            error_message = excluded.error_message,
            retry_count = excluded.retry_count
        `).bind(ctx.runId, jobId, error.error_type, error.error_message, error.retry_count).run()
      }
      
      // Rate limiting (Gemini API 보호)
      await sleep(200)  // 200ms 간격
    }
    
    // 중간 저장 및 진행 상황 업데이트
    await ctx.db.prepare(`
      UPDATE tagger_runs SET
        processed_jobs = ?,
        failed_jobs = ?,
        qa_passed = ?,
        qa_failed = ?
      WHERE run_id = ?
    `).bind(progress.processed, progress.errors.length, progress.passed, progress.failed, ctx.runId).run()
    
    if (onProgress) {
      onProgress({ ...progress })
    }
  }
  
  // 최종 결과 저장
  const completedAt = new Date().toISOString()
  const avgConfidence = await calculateAvgConfidence(ctx.db, ctx.runId)
  
  await ctx.db.prepare(`
    UPDATE tagger_runs SET
      status = 'completed',
      processed_jobs = ?,
      failed_jobs = ?,
      qa_passed = ?,
      qa_failed = ?,
      avg_confidence = ?,
      completed_at = ?
    WHERE run_id = ?
  `).bind(
    progress.processed, progress.errors.length, progress.passed, progress.failed,
    avgConfidence, completedAt, ctx.runId
  ).run()
  
  return {
    run_id: ctx.runId,
    tagger_version: TAGGER_VERSION,
    total_jobs: progress.total,
    processed_jobs: progress.processed,
    failed_jobs: progress.errors.length,
    qa_passed: progress.passed,
    qa_failed: progress.failed,
    avg_confidence: avgConfidence,
    started_at: startedAt,
    completed_at: completedAt,
    errors: progress.errors,
  }
}

// ============================================
// Helper Functions
// ============================================

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

function categorizeError(err: unknown): TaggerError['error_type'] {
  const msg = err instanceof Error ? err.message : String(err)
  
  if (msg.includes('JSON') || msg.includes('parse')) return 'parse_error'
  if (msg.includes('API') || msg.includes('fetch') || msg.includes('network')) return 'api_error'
  if (msg.includes('timeout') || msg.includes('TIMEOUT')) return 'timeout'
  return 'validation_error'
}

async function calculateAvgConfidence(db: D1Database, runId: string): Promise<number> {
  const result = await db.prepare(`
    SELECT AVG(_confidence) as avg FROM job_attributes
    WHERE tagger_version = ?
  `).bind(TAGGER_VERSION).first<{ avg: number }>()
  
  return result?.avg ?? 0
}

// ============================================
// Export for API Route
// ============================================

export {
  TAGGER_VERSION,
  DEFAULT_BATCH_CONFIG,
}

