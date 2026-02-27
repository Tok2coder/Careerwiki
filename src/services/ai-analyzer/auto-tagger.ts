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
const TAGGER_VERSION = 'auto-inline-v2.0.0'

const VALID_WORK_HOURS = ['regular', 'overtime_some', 'overtime_frequent']
const VALID_SHIFT_WORK = ['none', 'possible', 'required']
const VALID_TRAVEL = ['none', 'some', 'frequent']
const VALID_REMOTE = ['none', 'partial', 'full']
const VALID_DEGREE = ['none', 'college', 'bachelor', 'master', 'phd']
const VALID_LICENSE = ['none', 'preferred', 'required', 'multiple_required']
const VALID_PHYSICAL_DEMAND = ['low', 'medium', 'high', 'very_high']
const VALID_WORK_ENVIRONMENT = ['office', 'field', 'factory', 'workshop', 'outdoor', 'hybrid', 'remote']
const VALID_EMPLOYMENT_TYPE = ['permanent', 'contract', 'freelance', 'gig', 'temporary', 'seasonal']
const VALID_JOB_TYPE = ['knowledge', 'service', 'manufacturing', 'crafts', 'manual_skilled', 'creative', 'analytical', 'management', 'field_work', 'transport']

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
| decision_authority | 지시대로 실행 | 일부 재량 | 전략/의사결정 주도 |
| repetitive_level | 매번 다른 업무 | 반복+변동 혼합 | 거의 동일한 반복 작업 |

### Enum 값
- work_hours: regular | overtime_some | overtime_frequent
- shift_work: none | possible | required
- travel: none | some | frequent
- remote_possible: none | partial | full
- degree_required: none | college | bachelor | master | phd
- license_required: none | preferred | required | multiple_required
- physical_demand: low(사무직) | medium(가끔 이동) | high(현장/육체노동) | very_high(중노동)
- work_environment: office | field(현장) | factory(공장) | workshop(작업장) | outdoor(야외) | hybrid | remote
- employment_type: permanent(정규직) | contract(계약직) | freelance | gig(긱) | temporary(임시직) | seasonal(계절직)
- job_type: knowledge(지식노동) | service(서비스) | manufacturing(제조) | crafts(공예/숙련) | manual_skilled(현장기능) | creative(창작) | analytical(분석) | management(관리) | field_work(현장직) | transport(운송)

### 카테고리 필드 결정 규칙 (필수! 기본값으로 두지 마세요!)
**⚠️ 아래 필드는 직업명과 업무 내용을 반드시 반영해야 합니다. 판단 근거 없이 기본값을 사용하지 마세요.**

**job_type 판단 기준:**
- "반장", "기사", "정비원", "기능사", "조립원", "용접" → manufacturing 또는 manual_skilled (knowledge 아님!)
- "디자이너", "작가", "작곡", "아티스트", "PD" → creative
- "분석가", "연구원", "데이터", "통계" → analytical
- "감독", "관리자", "매니저", "팀장", "이사" → management
- "운전", "배달", "택배", "조종사" → transport
- "상담사", "서비스", "판매", "영업", "안내" → service
- "소방관", "경찰", "군인", "현장직" → field_work

**work_environment 판단 기준:**
- "공장", "반장", "조립", "제조" → factory
- "현장", "시공", "건설", "소방", "경비" → field
- "야외", "농업", "조경", "해양" → outdoor
- "정비", "용접", "목공" → workshop
- "재택", "원격" → remote
- 일반 사무직, IT, 연구 → office

**physical_demand 판단 기준:**
- 사무직, IT, 연구 → low
- 영업, 교사, 의료(비수술) → medium
- "반장", "정비", "기사", "조립", "건설" → high
- "용접", "광부", "벌목", "소방" → very_high

**employment_type 판단 기준:**
- 공무원, 공기업 → permanent
- "배우", "작가", "프리랜서", "개인사업" → freelance
- "배달", "대리운전", "플랫폼" → gig

**앵커 예시 (반드시 참고!):**
| 직업 | job_type | work_environment | physical_demand | employment_type |
|------|----------|-----------------|-----------------|-----------------|
| 소방관 | field_work | field | high | permanent |
| 배우 | creative | hybrid | medium | freelance |
| 열처리반장 | manufacturing | factory | high | permanent |
| 데이터분석가 | analytical | office | low | permanent |
| 공무원 | knowledge | office | low | permanent |
| 택배기사 | transport | field | high | gig |
| 치과위생사 | service | office | medium | permanent |
| 영화감독 | creative | field | medium | freelance |
| 용접기능사 | manual_skilled | workshop | very_high | permanent |
| 웹디자이너 | creative | office | low | permanent |

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
  "decision_authority": 0-100,
  "repetitive_level": 0-100,
  "work_hours": "regular|overtime_some|overtime_frequent",
  "shift_work": "none|possible|required",
  "travel": "none|some|frequent",
  "remote_possible": "none|partial|full",
  "degree_required": "none|college|bachelor|master|phd",
  "license_required": "none|preferred|required|multiple_required",
  "physical_demand": "low|medium|high|very_high",
  "work_environment": "office|field|factory|workshop|outdoor|hybrid|remote",
  "employment_type": "permanent|contract|freelance|gig|temporary|seasonal",
  "job_type": "knowledge|service|manufacturing|crafts|manual_skilled|creative|analytical|management|field_work|transport",
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
    decision_authority: clamp(raw.decision_authority, 0, 100),
    repetitive_level: clamp(raw.repetitive_level, 0, 100),
    work_hours: VALID_WORK_HOURS.includes(raw.work_hours) ? raw.work_hours : 'regular',
    shift_work: VALID_SHIFT_WORK.includes(raw.shift_work) ? raw.shift_work : 'none',
    travel: VALID_TRAVEL.includes(raw.travel) ? raw.travel : 'none',
    remote_possible: VALID_REMOTE.includes(raw.remote_possible) ? raw.remote_possible : 'none',
    degree_required: VALID_DEGREE.includes(raw.degree_required) ? raw.degree_required : 'none',
    license_required: VALID_LICENSE.includes(raw.license_required) ? raw.license_required : 'none',
    physical_demand: VALID_PHYSICAL_DEMAND.includes(raw.physical_demand) ? raw.physical_demand : 'medium',
    work_environment: VALID_WORK_ENVIRONMENT.includes(raw.work_environment) ? raw.work_environment : 'office',
    employment_type: VALID_EMPLOYMENT_TYPE.includes(raw.employment_type) ? raw.employment_type : 'permanent',
    job_type: VALID_JOB_TYPE.includes(raw.job_type) ? raw.job_type : 'knowledge',
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

  try {
    const jobInfo = buildJobInfoPrompt(job)

    const { response } = await callOpenAI(openaiApiKey, [
      { role: 'system', content: TAGGING_SYSTEM_PROMPT },
      { role: 'user', content: `아래 직업에 대해 태깅 결과를 JSON으로 출력하세요.\n\n${jobInfo}` },
    ], {
      temperature: 0.3,
      max_tokens: 700,
    })

    // JSON 파싱
    const jsonMatch = response.match(/\{[\s\S]*\}/)
    if (!jsonMatch) {
      return { success: false, error: 'JSON_PARSE_FAILED' }
    }

    const raw = JSON.parse(jsonMatch[0])
    const cleaned = cleanTagResult(raw)

    // DB INSERT (재태깅 시 덮어쓰기)
    await db.prepare(`
      INSERT OR REPLACE INTO job_attributes (
        job_id, job_name,
        wlb, growth, stability, income,
        teamwork, solo_deep, analytical, creative, execution, people_facing,
        decision_authority, repetitive_level,
        work_hours, shift_work, travel, remote_possible,
        degree_required, license_required,
        physical_demand, work_environment, employment_type, job_type,
        _confidence, tagger_version, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).bind(
      job.id, job.name,
      cleaned.wlb, cleaned.growth, cleaned.stability, cleaned.income,
      cleaned.teamwork, cleaned.solo_deep, cleaned.analytical, cleaned.creative, cleaned.execution, cleaned.people_facing,
      cleaned.decision_authority, cleaned.repetitive_level,
      cleaned.work_hours, cleaned.shift_work, cleaned.travel, cleaned.remote_possible,
      cleaned.degree_required, cleaned.license_required,
      cleaned.physical_demand, cleaned.work_environment, cleaned.employment_type, cleaned.job_type,
      cleaned.confidence, TAGGER_VERSION, 'tagged',
    ).run()

    return { success: true }
  } catch (error) {
    const msg = error instanceof Error ? error.message : String(error)
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
  } catch (error) {
  }
}
