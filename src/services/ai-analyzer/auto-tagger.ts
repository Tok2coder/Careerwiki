// src/services/ai-analyzer/auto-tagger.ts
// ============================================
// 직업 생성 시 자동 태깅 (Inline)
// 직업 삭제 시 job_attributes 자동 삭제
// ============================================

import type { D1Database } from '@cloudflare/workers-types'
import { callOpenAI } from './openai-client'

// ============================================
// Constants
// ============================================
const TAGGER_VERSION = 'auto-inline-v1.0.0'

const VALID_WORK_HOURS = ['regular', 'overtime_some', 'overtime_frequent']
const VALID_SHIFT_WORK = ['none', 'possible', 'required']
const VALID_TRAVEL = ['none', 'some', 'frequent']
const VALID_REMOTE = ['none', 'partial', 'full']
const VALID_DEGREE = ['none', 'college', 'bachelor', 'master', 'phd']
const VALID_LICENSE = ['none', 'preferred', 'required', 'multiple_required']

const TAGGING_SYSTEM_PROMPT = `당신은 CareerWiki의 직업 속성 태거입니다.
주어진 직업 정보를 분석하여 구조화된 속성을 추출하세요.

### 중요 규칙
1. 증거가 명확할 때만 높은 신뢰도(>0.9)를 부여하세요
2. 제약 관련 필드(degree_required, license_required 등)는 false positive를 최소화하세요
3. 정보가 없거나 불확실하면 중간값(50)과 낮은 신뢰도(0.5-0.7)를 사용하세요

### 점수 스케일 앵커 (0-100)
| 필드 | 0점 | 50점 | 100점 |
|------|-----|------|-------|
| wlb | 거의 항상 야근/교대/콜 | 주 1-2회 야근 | 정시 퇴근/예측 가능 |
| growth | 반복업무 위주 | 일부 학습 기회 | 학습/승진 매우 큼 |
| stability | 프리랜서/계약직 위주 | 혼합 | 정규직/공무원급 안정 |
| income | 최저임금 수준 | 중간 | 상위 10% |
| teamwork | 완전 독립 작업 | 협업 반반 | 팀 중심 |
| solo_deep | 팀 협업 중심 | 혼합 | 혼자 깊이 파는 작업 |
| analytical | 분석 거의 없음 | 일부 분석 | 분석이 핵심 |
| creative | 정해진 절차대로 | 일부 창의성 | 창의성이 핵심 |
| execution | 기획 위주 | 혼합 | 실행/구현 위주 |
| people_facing | 고객 대면 없음 | 일부 대면 | 대부분 대면 |

### Enum 값
- work_hours: regular | overtime_some | overtime_frequent
- shift_work: none | possible | required
- travel: none | some | frequent
- remote_possible: none | partial | full
- degree_required: none | college | bachelor | master | phd
- license_required: none | preferred | required | multiple_required

### 출력 형식 (JSON)
{
  "wlb": 0-100,
  "growth": 0-100,
  "stability": 0-100,
  "income": 0-100,
  "teamwork": 0-100,
  "solo_deep": 0-100,
  "analytical": 0-100,
  "creative": 0-100,
  "execution": 0-100,
  "people_facing": 0-100,
  "work_hours": "regular|overtime_some|overtime_frequent",
  "shift_work": "none|possible|required",
  "travel": "none|some|frequent",
  "remote_possible": "none|partial|full",
  "degree_required": "none|college|bachelor|master|phd",
  "license_required": "none|preferred|required|multiple_required",
  "confidence": 0.5-1.0
}`

// ============================================
// 직업 정보로부터 태깅용 프롬프트 빌드
// ============================================
function buildJobInfoPrompt(job: {
  id: string
  name: string
  api_data_json?: string | null
  merged_profile_json?: string | null
  user_contributed_json?: string | null
  admin_data_json?: string | null
}): string {
  let info = `직업명: ${job.name}`

  // api_data_json에서 핵심 정보 추출
  if (job.api_data_json) {
    try {
      const data = JSON.parse(job.api_data_json)
      if (data.업무내용 || data.job_description) info += `\n업무: ${(data.업무내용 || data.job_description || '').substring(0, 500)}`
      if (data.자격요건 || data.required_qualifications) info += `\n자격: ${(data.자격요건 || data.required_qualifications || '').substring(0, 300)}`
      if (data.근무환경 || data.work_environment) info += `\n환경: ${(data.근무환경 || data.work_environment || '').substring(0, 300)}`
      if (data.평균연봉 || data.salary) info += `\n연봉: ${data.평균연봉 || data.salary}`
      if (data.학력 || data.education) info += `\n학력: ${data.학력 || data.education}`
      if (data.관련자격증 || data.certifications) info += `\n자격증: ${data.관련자격증 || data.certifications}`
    } catch { /* ignore parse error */ }
  }

  // merged_profile_json에서 추가 정보
  if (job.merged_profile_json) {
    try {
      const profile = JSON.parse(job.merged_profile_json)
      if (profile.summary) info += `\n요약: ${profile.summary.substring(0, 300)}`
      if (profile.classification || profile.직업분류) info += `\n분류: ${profile.classification || profile.직업분류}`
      if (profile.ksco_major) info += `\nKSCO: ${profile.ksco_major}`
    } catch { /* ignore */ }
  }

  // admin_data_json에서 정보 추출
  if (job.admin_data_json) {
    try {
      const data = JSON.parse(job.admin_data_json)
      if (data.summary) info += `\n요약: ${data.summary.substring(0, 300)}`
      if (data.duties) info += `\n직무: ${data.duties.substring(0, 300)}`
      if (data.salary) info += `\n급여: ${data.salary}`
    } catch { /* ignore */ }
  }

  // user_contributed_json에서 정보 추출
  if (job.user_contributed_json) {
    try {
      const data = JSON.parse(job.user_contributed_json)
      if (data.summary) info += `\n설명: ${data.summary.substring(0, 300)}`
      if (data.heroCategory) info += `\n카테고리: ${data.heroCategory}`
    } catch { /* ignore */ }
  }

  return info
}

// ============================================
// 값 검증 및 정제
// ============================================
function cleanTagResult(raw: any): any {
  const clamp = (v: any, min: number, max: number) => {
    const n = typeof v === 'number' ? v : parseInt(v)
    return isNaN(n) ? 50 : Math.max(min, Math.min(max, n))
  }

  return {
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
    work_hours: VALID_WORK_HOURS.includes(raw.work_hours) ? raw.work_hours : 'regular',
    shift_work: VALID_SHIFT_WORK.includes(raw.shift_work) ? raw.shift_work : 'none',
    travel: VALID_TRAVEL.includes(raw.travel) ? raw.travel : 'none',
    remote_possible: VALID_REMOTE.includes(raw.remote_possible) ? raw.remote_possible : 'none',
    degree_required: VALID_DEGREE.includes(raw.degree_required) ? raw.degree_required : 'none',
    license_required: VALID_LICENSE.includes(raw.license_required) ? raw.license_required : 'none',
    confidence: clamp(raw.confidence || 0.7, 0.3, 1.0) / (raw.confidence > 1 ? 100 : 1),
  }
}

// ============================================
// 단일 직업 자동 태깅 (Inline)
// ============================================
export async function autoTagJob(
  db: D1Database,
  job: {
    id: string
    name: string
    api_data_json?: string | null
    merged_profile_json?: string | null
    user_contributed_json?: string | null
    admin_data_json?: string | null
  },
  openaiApiKey: string,
): Promise<{ success: boolean; error?: string }> {
  console.log(`[AutoTag] Tagging job: ${job.name} (${job.id})`)

  try {
    const jobInfo = buildJobInfoPrompt(job)

    const { response } = await callOpenAI(openaiApiKey, [
      { role: 'system', content: TAGGING_SYSTEM_PROMPT },
      { role: 'user', content: `아래 직업에 대해 태깅 결과를 JSON으로 출력하세요.\n\n${jobInfo}` },
    ], {
      temperature: 0.3,
      max_tokens: 500,
    })

    // JSON 파싱
    const jsonMatch = response.match(/\{[\s\S]*\}/)
    if (!jsonMatch) {
      console.error(`[AutoTag] Failed to parse JSON for ${job.id}`)
      return { success: false, error: 'JSON_PARSE_FAILED' }
    }

    const raw = JSON.parse(jsonMatch[0])
    const cleaned = cleanTagResult(raw)

    // DB INSERT (기존 있으면 무시)
    await db.prepare(`
      INSERT OR IGNORE INTO job_attributes (
        job_id, job_name,
        wlb, growth, stability, income,
        teamwork, solo_deep, analytical, creative, execution, people_facing,
        work_hours, shift_work, travel, remote_possible,
        degree_required, license_required,
        _confidence, tagger_version, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).bind(
      job.id, job.name,
      cleaned.wlb, cleaned.growth, cleaned.stability, cleaned.income,
      cleaned.teamwork, cleaned.solo_deep, cleaned.analytical, cleaned.creative, cleaned.execution, cleaned.people_facing,
      cleaned.work_hours, cleaned.shift_work, cleaned.travel, cleaned.remote_possible,
      cleaned.degree_required, cleaned.license_required,
      cleaned.confidence, TAGGER_VERSION, 'tagged',
    ).run()

    console.log(`[AutoTag] Success: ${job.name} (confidence: ${cleaned.confidence})`)
    return { success: true }
  } catch (error) {
    const msg = error instanceof Error ? error.message : String(error)
    console.error(`[AutoTag] Failed for ${job.id}:`, msg)
    return { success: false, error: msg }
  }
}

// ============================================
// DB에서 직업 정보 조회 후 태깅
// ============================================
export async function autoTagJobById(
  db: D1Database,
  jobId: string,
  openaiApiKey: string,
): Promise<{ success: boolean; error?: string }> {
  // 직업 정보 조회
  const job = await db.prepare(`
    SELECT id, name, api_data_json, merged_profile_json, user_contributed_json, admin_data_json
    FROM jobs WHERE id = ?
  `).bind(jobId).first<{
    id: string
    name: string
    api_data_json: string | null
    merged_profile_json: string | null
    user_contributed_json: string | null
    admin_data_json: string | null
  }>()

  if (!job) {
    return { success: false, error: 'JOB_NOT_FOUND' }
  }

  return autoTagJob(db, job, openaiApiKey)
}

// ============================================
// 직업 삭제 시 job_attributes 동시 삭제
// ============================================
export async function deleteJobAttributes(
  db: D1Database,
  jobId: string,
): Promise<void> {
  try {
    await db.prepare('DELETE FROM job_attributes WHERE job_id = ?')
      .bind(jobId)
      .run()
    console.log(`[AutoTag] Deleted job_attributes for job: ${jobId}`)
  } catch (error) {
    console.error(`[AutoTag] Failed to delete job_attributes for ${jobId}:`, error)
  }
}
