#!/usr/bin/env node
/**
 * 미태깅 직업 자동 태깅 스크립트
 *
 * job_attributes가 없는 직업들을 GPT-4o-mini로 자동 태깅하여 D1에 INSERT
 *
 * 사용법:
 *   node scripts/auto-tag-remaining-jobs.mjs [--dry-run] [--limit 100] [--batch-size 20]
 *
 * 옵션:
 *   --dry-run: DB에 쓰지 않고 결과만 출력
 *   --limit N: 최대 N개 직업만 태깅
 *   --batch-size N: 배치당 N개 직업 (기본 20, 최대 30)
 */

import { readFileSync, writeFileSync, existsSync } from 'fs'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'
import { execSync } from 'child_process'

const __dirname = dirname(fileURLToPath(import.meta.url))
const ROOT = join(__dirname, '..')

// ============================================
// Config
// ============================================
const ACCOUNT_ID = '3587865378649966bfb0a814fce73c77'
const DATABASE_ID = '1dbc57d6-0ce3-4a7e-8d2e-3159b0df1315'

function loadEnvVar(name) {
  const devVarsPath = join(ROOT, '.dev.vars')
  const content = readFileSync(devVarsPath, 'utf-8')
  const match = content.match(new RegExp(`${name}\\s*=\\s*["']?([^"'\\n]+)`))
  if (!match) throw new Error(`${name} not found in .dev.vars`)
  return match[1].trim()
}

const OPENAI_API_KEY = loadEnvVar('OPENAI_API_KEY')
const CF_API_TOKEN = loadEnvVar('CLOUDFLARE_API_TOKEN')

// ============================================
// CLI Args
// ============================================
const args = process.argv.slice(2)
const DRY_RUN = args.includes('--dry-run')
const LIMIT = (() => {
  const idx = args.indexOf('--limit')
  return idx >= 0 ? parseInt(args[idx + 1]) : Infinity
})()
const BATCH_SIZE = (() => {
  const idx = args.indexOf('--batch-size')
  return idx >= 0 ? Math.min(parseInt(args[idx + 1]), 30) : 15
})()

// ============================================
// D1 REST API
// ============================================
async function queryD1(sql, params = []) {
  const res = await fetch(
    `https://api.cloudflare.com/client/v4/accounts/${ACCOUNT_ID}/d1/database/${DATABASE_ID}/query`,
    {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${CF_API_TOKEN}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ sql, params }),
    }
  )
  const json = await res.json()
  if (!json.success) {
    throw new Error(`D1 query failed: ${JSON.stringify(json.errors)}`)
  }
  return json.result?.[0]?.results || []
}

// ============================================
// OpenAI API
// ============================================
async function callOpenAI(messages) {
  const res = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${OPENAI_API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: 'gpt-4o-mini',
      messages,
      temperature: 0.3,
      max_tokens: 16384,
      response_format: { type: 'json_object' },
    }),
  })
  const json = await res.json()
  if (json.error) throw new Error(`OpenAI error: ${json.error.message}`)
  return json.choices[0].message.content
}

// ============================================
// Tagging Prompt
// ============================================
const SYSTEM_PROMPT = `당신은 CareerWiki의 직업 속성 태거입니다.
주어진 직업 정보들을 분석하여 각 직업에 대한 구조화된 속성을 추출하세요.

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
반드시 아래 형식의 JSON을 출력하세요. jobs 배열에 각 직업의 태깅 결과를 담으세요.

{
  "jobs": [
    {
      "job_id": "string",
      "job_name": "string",
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
    }
  ]
}`

function buildUserPrompt(jobs) {
  const jobInfos = jobs.map(j => {
    let info = `- ID: ${j.id}\n  이름: ${j.name}`

    // api_data_json에서 핵심 정보 추출
    if (j.api_data_json) {
      try {
        const data = JSON.parse(j.api_data_json)
        if (data.업무내용 || data.job_description) info += `\n  업무: ${(data.업무내용 || data.job_description || '').substring(0, 300)}`
        if (data.자격요건 || data.required_qualifications) info += `\n  자격: ${(data.자격요건 || data.required_qualifications || '').substring(0, 200)}`
        if (data.근무환경 || data.work_environment) info += `\n  환경: ${(data.근무환경 || data.work_environment || '').substring(0, 200)}`
        if (data.평균연봉 || data.salary) info += `\n  연봉: ${data.평균연봉 || data.salary}`
        if (data.학력 || data.education) info += `\n  학력: ${data.학력 || data.education}`
        if (data.관련자격증 || data.certifications) info += `\n  자격증: ${data.관련자격증 || data.certifications}`
      } catch {}
    }

    // merged_profile_json에서 추가 정보
    if (j.merged_profile_json) {
      try {
        const profile = JSON.parse(j.merged_profile_json)
        if (profile.classification || profile.직업분류) info += `\n  분류: ${profile.classification || profile.직업분류}`
        if (profile.ksco_major) info += `\n  KSCO: ${profile.ksco_major}`
      } catch {}
    }

    return info
  }).join('\n\n')

  return `아래 ${jobs.length}개 직업에 대해 태깅 결과를 JSON으로 출력하세요.\n\n${jobInfos}`
}

// ============================================
// Validation
// ============================================
const VALID_WORK_HOURS = ['regular', 'overtime_some', 'overtime_frequent']
const VALID_SHIFT_WORK = ['none', 'possible', 'required']
const VALID_TRAVEL = ['none', 'some', 'frequent']
const VALID_REMOTE = ['none', 'partial', 'full']
const VALID_DEGREE = ['none', 'college', 'bachelor', 'master', 'phd']
const VALID_LICENSE = ['none', 'preferred', 'required', 'multiple_required']

function validateAndClean(tagged) {
  const clamp = (v, min, max) => Math.max(min, Math.min(max, Math.round(v)))
  const validEnum = (v, valid, def) => valid.includes(v) ? v : def

  return {
    wlb: clamp(tagged.wlb ?? 50, 0, 100),
    growth: clamp(tagged.growth ?? 50, 0, 100),
    stability: clamp(tagged.stability ?? 50, 0, 100),
    income: clamp(tagged.income ?? 50, 0, 100),
    teamwork: clamp(tagged.teamwork ?? 50, 0, 100),
    solo_deep: clamp(tagged.solo_deep ?? 50, 0, 100),
    analytical: clamp(tagged.analytical ?? 50, 0, 100),
    creative: clamp(tagged.creative ?? 50, 0, 100),
    execution: clamp(tagged.execution ?? 50, 0, 100),
    people_facing: clamp(tagged.people_facing ?? 50, 0, 100),
    work_hours: validEnum(tagged.work_hours, VALID_WORK_HOURS, 'regular'),
    shift_work: validEnum(tagged.shift_work, VALID_SHIFT_WORK, 'none'),
    travel: validEnum(tagged.travel, VALID_TRAVEL, 'some'),
    remote_possible: validEnum(tagged.remote_possible, VALID_REMOTE, 'none'),
    degree_required: validEnum(tagged.degree_required, VALID_DEGREE, 'none'),
    license_required: validEnum(tagged.license_required, VALID_LICENSE, 'none'),
    confidence: Math.max(0, Math.min(1, tagged.confidence ?? 0.6)),
  }
}

// ============================================
// Main
// ============================================
async function main() {
  console.log('═══════════════════════════════════════════════════════════')
  console.log('   🏷️  Auto-Tag Remaining Jobs')
  console.log('═══════════════════════════════════════════════════════════')
  console.log(`   Mode: ${DRY_RUN ? 'DRY RUN' : 'LIVE'}`)
  console.log(`   Limit: ${LIMIT === Infinity ? 'ALL' : LIMIT}`)
  console.log(`   Batch Size: ${BATCH_SIZE}`)
  console.log('')

  // 1. 미태깅 직업 조회
  console.log('[1/3] 미태깅 직업 조회...')
  const untaggedJobs = await queryD1(`
    SELECT j.id, j.name, j.api_data_json, j.merged_profile_json
    FROM jobs j
    LEFT JOIN job_attributes ja ON j.id = ja.job_id
    WHERE ja.job_id IS NULL
    ORDER BY j.id
  `)

  console.log(`   총 ${untaggedJobs.length}개 미태깅 직업 발견`)

  const jobsToTag = untaggedJobs.slice(0, LIMIT)
  console.log(`   태깅 대상: ${jobsToTag.length}개\n`)

  if (jobsToTag.length === 0) {
    console.log('✅ 태깅할 직업이 없습니다!')
    return
  }

  // 2. 배치 처리
  console.log('[2/3] GPT-4o-mini로 태깅 시작...')
  let totalTagged = 0
  let totalErrors = 0
  const allResults = []

  for (let i = 0; i < jobsToTag.length; i += BATCH_SIZE) {
    const batch = jobsToTag.slice(i, i + BATCH_SIZE)
    const batchNum = Math.floor(i / BATCH_SIZE) + 1
    const totalBatches = Math.ceil(jobsToTag.length / BATCH_SIZE)

    console.log(`\n   [배치 ${batchNum}/${totalBatches}] ${batch.length}개 직업 태깅 중...`)

    try {
      const response = await callOpenAI([
        { role: 'system', content: SYSTEM_PROMPT },
        { role: 'user', content: buildUserPrompt(batch) },
      ])

      const parsed = JSON.parse(response)
      const taggedJobs = parsed.jobs || []

      // 결과 매칭 및 검증
      for (const tagged of taggedJobs) {
        const originalJob = batch.find(j => j.id === tagged.job_id)
        if (!originalJob) {
          console.log(`      ⚠️ 알 수 없는 job_id: ${tagged.job_id}`)
          continue
        }

        const cleaned = validateAndClean(tagged)

        if (!DRY_RUN) {
          // D1에 INSERT
          try {
            await queryD1(`
              INSERT OR IGNORE INTO job_attributes (
                job_id, job_name,
                wlb, growth, stability, income,
                teamwork, solo_deep, analytical, creative, execution, people_facing,
                work_hours, shift_work, travel, remote_possible,
                degree_required, license_required,
                _confidence, tagger_version, status
              ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            `, [
              originalJob.id, originalJob.name,
              cleaned.wlb, cleaned.growth, cleaned.stability, cleaned.income,
              cleaned.teamwork, cleaned.solo_deep, cleaned.analytical, cleaned.creative, cleaned.execution, cleaned.people_facing,
              cleaned.work_hours, cleaned.shift_work, cleaned.travel, cleaned.remote_possible,
              cleaned.degree_required, cleaned.license_required,
              cleaned.confidence, 'auto-v1.0.0', 'tagged',
            ])
            totalTagged++
          } catch (err) {
            console.log(`      ❌ INSERT 실패 [${originalJob.id}]: ${err.message}`)
            totalErrors++
          }
        } else {
          totalTagged++
        }

        allResults.push({ job_id: originalJob.id, job_name: originalJob.name, ...cleaned })
      }

      // 매칭 안 된 직업 확인
      const taggedIds = new Set(taggedJobs.map(t => t.job_id))
      const missed = batch.filter(j => !taggedIds.has(j.id))
      if (missed.length > 0) {
        console.log(`      ⚠️ ${missed.length}개 직업 누락: ${missed.map(j => j.name).join(', ')}`)
        totalErrors += missed.length
      }

      console.log(`      ✅ ${taggedJobs.length}개 태깅 완료 (누적: ${totalTagged})`)

      // Rate limit 방지
      if (i + BATCH_SIZE < jobsToTag.length) {
        await new Promise(r => setTimeout(r, 1000))
      }

    } catch (err) {
      console.log(`      ❌ 배치 실패: ${err.message}`)
      totalErrors += batch.length
      // 실패한 배치 스킵하고 계속
      continue
    }

    // 100개마다 진행 상황 출력
    if (totalTagged > 0 && totalTagged % 100 === 0) {
      console.log(`\n   📊 진행: ${totalTagged}/${jobsToTag.length} (${Math.round(totalTagged/jobsToTag.length*100)}%)`)
    }
  }

  // 3. 결과 요약
  console.log('\n═══════════════════════════════════════════════════════════')
  console.log(`[3/3] 완료!`)
  console.log(`   ✅ 태깅 성공: ${totalTagged}개`)
  console.log(`   ❌ 에러: ${totalErrors}개`)
  console.log(`   📊 성공률: ${Math.round(totalTagged / (totalTagged + totalErrors) * 100)}%`)

  if (DRY_RUN) {
    console.log('\n   ⚠️ DRY RUN 모드 - DB에 쓰지 않았습니다')
    // DRY RUN 결과 파일 저장
    const outPath = join(ROOT, 'scripts', 'auto-tag-results-preview.json')
    writeFileSync(outPath, JSON.stringify(allResults, null, 2))
    console.log(`   📁 결과 미리보기: ${outPath}`)
  }

  // 최종 확인
  if (!DRY_RUN) {
    const count = await queryD1('SELECT COUNT(*) as cnt FROM job_attributes')
    console.log(`\n   📊 job_attributes 현재 행 수: ${count[0]?.cnt || '?'}`)
  }
}

main().catch(err => {
  console.error('❌ Fatal error:', err)
  process.exit(1)
})
