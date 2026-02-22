// src/services/ai-analyzer/auto-tagger-major.ts
// ============================================
// 전공 생성/업데이트 시 자동 태깅 (LLM 기반)
// major_attributes 테이블에 전공 속성 수치 저장
// ============================================

import type { D1Database } from '@cloudflare/workers-types'
import { callOpenAI } from './openai-client'

// ============================================
// Constants
// ============================================
const MAJOR_TAGGER_VERSION = 'major-auto-v1.0.0'

const VALID_FIELD_CATEGORIES = [
  'engineering',      // 공학
  'natural_science',  // 자연과학
  'social_science',   // 사회과학
  'humanities',       // 인문학
  'arts',             // 예술/체육
  'medical',          // 의약/보건
  'education',        // 교육
  'business',         // 경영/경제
  'law',              // 법학
  'agriculture',      // 농림/수산
  'general',          // 일반/기타
] as const

const VALID_DEGREE_LEVELS = ['bachelor', 'master_preferred', 'phd_required'] as const

const MAJOR_TAGGING_SYSTEM_PROMPT = `당신은 CareerWiki의 전공(학과) 속성 태거입니다.
주어진 전공 정보를 분석하여 구조화된 속성을 추출하세요.

### 중요 규칙
1. 증거가 명확할 때만 극단값(0-20 또는 80-100)을 사용하세요
2. 정보가 없거나 불확실하면 중간값(50)을 사용하세요
3. 한국 대학 기준으로 평가하세요

### 점수 스케일 앵커 (0-100)
| 필드 | 0점 | 50점 | 100점 |
|------|-----|------|-------|
| academic_rigor | 실습/실기 위주 | 이론+실습 반반 | 순수 이론/연구 중심 |
| math_intensity | 수학 전혀 불필요 | 기초 통계 수준 | 수학이 전공 핵심 |
| creativity | 정해진 절차/지식 암기 | 일부 창의성 요구 | 창작/디자인이 핵심 |
| social_interaction | 완전 개인 학습 | 발표/토론 반반 | 팀프로젝트/임상 중심 |
| lab_practical | 강의/이론 위주 | 실습 반반 | 실험/실습이 대부분 |
| reading_writing | 읽기/쓰기 거의 없음 | 리포트 보통 | 에세이/논문 중심 |
| career_breadth | 특정 직업에만 연결 | 5-10개 진로 | 매우 다양한 진로 |
| career_income_potential | 졸업 후 평균 이하 | 평균 수준 | 상위 소득 직종 |
| employment_rate | 40% 이하 | 60-70% | 90% 이상 |
| competition_level | 거의 경쟁 없음 | 보통 | 매우 높은 경쟁률 |
| growth_outlook | 축소/쇠퇴 산업 | 안정적 | 급성장 산업 |
| stability | 불안정/비정규 많음 | 보통 | 정규직/공무원급 |
| autonomy | 정해진 커리큘럼만 | 선택과목 반반 | 자유 연구/자기주도 |
| teamwork | 완전 개인학습 | 팀과제 반반 | 대부분 팀 활동 |

### field_category 값
engineering(공학), natural_science(자연과학), social_science(사회과학), humanities(인문학), arts(예술/체육), medical(의약/보건), education(교육), business(경영/경제), law(법학), agriculture(농림/수산), general(기타)

### degree_level 값
bachelor(학사 졸업으로 충분), master_preferred(석사 권장), phd_required(박사 필수)

### 출력 형식 (JSON)
{
  "academic_rigor": 0-100,
  "math_intensity": 0-100,
  "creativity": 0-100,
  "social_interaction": 0-100,
  "lab_practical": 0-100,
  "reading_writing": 0-100,
  "career_breadth": 0-100,
  "career_income_potential": 0-100,
  "employment_rate": 0-100,
  "competition_level": 0-100,
  "growth_outlook": 0-100,
  "stability": 0-100,
  "autonomy": 0-100,
  "teamwork": 0-100,
  "field_category": "engineering|natural_science|social_science|humanities|arts|medical|education|business|law|agriculture|general",
  "degree_level": "bachelor|master_preferred|phd_required",
  "prerequisite_subjects": ["과목1", "과목2"],
  "related_careers": ["직업1", "직업2", "직업3"],
  "key_skills": ["역량1", "역량2", "역량3"],
  "description": "전공 한줄 설명"
}`

// ============================================
// 전공 정보로부터 태깅용 프롬프트 빌드
// ============================================
function buildMajorInfoPrompt(major: {
  id: number | string
  name: string
  merged_profile_json?: string | null
}): string {
  let info = `전공명: ${major.name}`

  if (major.merged_profile_json) {
    try {
      const profile = JSON.parse(major.merged_profile_json)
      if (profile.summary || profile.요약) {
        info += `\n요약: ${(profile.summary || profile.요약 || '').substring(0, 500)}`
      }
      if (profile.curriculum || profile.교과목) {
        const curriculum = profile.curriculum || profile.교과목
        const currStr = Array.isArray(curriculum) ? curriculum.join(', ') : String(curriculum)
        info += `\n교과목: ${currStr.substring(0, 500)}`
      }
      if (profile.relatedJobs || profile.관련직업) {
        const jobs = profile.relatedJobs || profile.관련직업
        const jobStr = Array.isArray(jobs) ? jobs.map((j: any) => typeof j === 'string' ? j : j.name || j.jobName).join(', ') : String(jobs)
        info += `\n관련직업: ${jobStr.substring(0, 300)}`
      }
      if (profile.classification || profile.분류 || profile.계열) {
        info += `\n분류: ${profile.classification || profile.분류 || profile.계열}`
      }
      if (profile.qualifications || profile.자격요건) {
        info += `\n자격: ${(profile.qualifications || profile.자격요건 || '').substring(0, 300)}`
      }
      if (profile.outlook || profile.전망) {
        info += `\n전망: ${(profile.outlook || profile.전망 || '').substring(0, 300)}`
      }
      if (profile.aptitudes || profile.적성) {
        info += `\n적성: ${(profile.aptitudes || profile.적성 || '').substring(0, 300)}`
      }
    } catch { /* ignore parse error */ }
  }

  return info
}

// ============================================
// 값 검증 및 정제
// ============================================
function cleanMajorTagResult(raw: any): any {
  const clamp = (v: any, min: number, max: number) => {
    const n = typeof v === 'number' ? v : parseInt(v)
    return isNaN(n) ? 50 : Math.max(min, Math.min(max, n))
  }

  const ensureArray = (v: any): string[] => {
    if (Array.isArray(v)) return v.map(String).slice(0, 10)
    if (typeof v === 'string') return [v]
    return []
  }

  return {
    academic_rigor: clamp(raw.academic_rigor, 0, 100),
    math_intensity: clamp(raw.math_intensity, 0, 100),
    creativity: clamp(raw.creativity, 0, 100),
    social_interaction: clamp(raw.social_interaction, 0, 100),
    lab_practical: clamp(raw.lab_practical, 0, 100),
    reading_writing: clamp(raw.reading_writing, 0, 100),
    career_breadth: clamp(raw.career_breadth, 0, 100),
    career_income_potential: clamp(raw.career_income_potential, 0, 100),
    employment_rate: clamp(raw.employment_rate, 0, 100),
    competition_level: clamp(raw.competition_level, 0, 100),
    growth_outlook: clamp(raw.growth_outlook, 0, 100),
    stability: clamp(raw.stability, 0, 100),
    autonomy: clamp(raw.autonomy, 0, 100),
    teamwork: clamp(raw.teamwork, 0, 100),
    field_category: VALID_FIELD_CATEGORIES.includes(raw.field_category) ? raw.field_category : 'general',
    degree_level: VALID_DEGREE_LEVELS.includes(raw.degree_level) ? raw.degree_level : 'bachelor',
    prerequisite_subjects: JSON.stringify(ensureArray(raw.prerequisite_subjects)),
    related_careers: JSON.stringify(ensureArray(raw.related_careers)),
    key_skills: JSON.stringify(ensureArray(raw.key_skills)),
    description: typeof raw.description === 'string' ? raw.description.substring(0, 500) : '',
  }
}

// ============================================
// 단일 전공 자동 태깅
// ============================================
export async function autoTagMajor(
  db: D1Database,
  major: {
    id: number | string
    name: string
    merged_profile_json?: string | null
  },
  openaiApiKey: string,
): Promise<{ success: boolean; error?: string }> {

  try {
    const majorInfo = buildMajorInfoPrompt(major)

    const { response } = await callOpenAI(openaiApiKey, [
      { role: 'system', content: MAJOR_TAGGING_SYSTEM_PROMPT },
      { role: 'user', content: `아래 전공에 대해 태깅 결과를 JSON으로 출력하세요.\n\n${majorInfo}` },
    ], {
      temperature: 0.3,
      max_tokens: 800,
    })

    // JSON 파싱
    const jsonMatch = response.match(/\{[\s\S]*\}/)
    if (!jsonMatch) {
      return { success: false, error: 'JSON_PARSE_FAILED' }
    }

    const raw = JSON.parse(jsonMatch[0])
    const cleaned = cleanMajorTagResult(raw)

    // DB INSERT (재태깅 시 덮어쓰기)
    await db.prepare(`
      INSERT OR REPLACE INTO major_attributes (
        major_id, major_name,
        academic_rigor, math_intensity, creativity, social_interaction,
        lab_practical, reading_writing,
        career_breadth, career_income_potential, employment_rate,
        competition_level, growth_outlook, stability, autonomy, teamwork,
        field_category, degree_level,
        prerequisite_subjects, related_careers, key_skills, description,
        updated_at
      ) VALUES (
        ?, ?,
        ?, ?, ?, ?,
        ?, ?,
        ?, ?, ?,
        ?, ?, ?, ?, ?,
        ?, ?,
        ?, ?, ?, ?,
        datetime('now')
      )
    `).bind(
      major.id, major.name,
      cleaned.academic_rigor, cleaned.math_intensity, cleaned.creativity, cleaned.social_interaction,
      cleaned.lab_practical, cleaned.reading_writing,
      cleaned.career_breadth, cleaned.career_income_potential, cleaned.employment_rate,
      cleaned.competition_level, cleaned.growth_outlook, cleaned.stability, cleaned.autonomy, cleaned.teamwork,
      cleaned.field_category, cleaned.degree_level,
      cleaned.prerequisite_subjects, cleaned.related_careers, cleaned.key_skills, cleaned.description,
    ).run()

    return { success: true }
  } catch (error) {
    const msg = error instanceof Error ? error.message : String(error)
    return { success: false, error: msg }
  }
}

// ============================================
// 배치 자동 태깅 (관리자용)
// ============================================
export async function autoTagAllMajors(
  db: D1Database,
  openaiApiKey: string,
  options: { batchSize?: number; onlyUntagged?: boolean } = {},
): Promise<{ total: number; success: number; failed: number; errors: Array<{ majorId: string; error: string }> }> {
  const { batchSize = 10, onlyUntagged = true } = options

  // 대상 전공 조회
  const query = onlyUntagged
    ? `SELECT m.id, m.name, m.merged_profile_json
       FROM majors m
       LEFT JOIN major_attributes ma ON m.id = ma.major_id
       WHERE ma.major_id IS NULL AND m.name IS NOT NULL
       ORDER BY m.id`
    : `SELECT id, name, merged_profile_json
       FROM majors
       WHERE name IS NOT NULL
       ORDER BY id`

  const allMajors = await db.prepare(query).all<{
    id: number
    name: string
    merged_profile_json: string | null
  }>()

  const majors = allMajors.results || []
  let success = 0
  let failed = 0
  const errors: Array<{ majorId: string; error: string }> = []

  // 배치 단위로 처리
  for (let i = 0; i < majors.length; i += batchSize) {
    const batch = majors.slice(i, i + batchSize)
    const results = await Promise.allSettled(
      batch.map(major => autoTagMajor(db, major, openaiApiKey))
    )

    for (let j = 0; j < results.length; j++) {
      const result = results[j]
      if (result.status === 'fulfilled' && result.value.success) {
        success++
      } else {
        failed++
        const errorMsg = result.status === 'fulfilled'
          ? result.value.error || 'UNKNOWN'
          : result.reason?.message || 'PROMISE_REJECTED'
        errors.push({ majorId: String(batch[j].id), error: errorMsg })
      }
    }
  }

  return { total: majors.length, success, failed, errors }
}

// ============================================
// 전공 삭제 시 major_attributes 정리
// ============================================
export async function deleteMajorAttributes(db: D1Database, majorId: number | string): Promise<void> {
  await db.prepare('DELETE FROM major_attributes WHERE major_id = ?').bind(majorId).run()
}
