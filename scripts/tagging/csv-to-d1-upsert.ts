/**
 * 수동 태깅 CSV → D1 Upsert SQL 변환 스크립트
 * 
 * 사용법:
 *   npx tsx scripts/tagging/csv-to-d1-upsert.ts input.csv
 *   wrangler d1 execute careerwiki-db --local --file=scripts/tagging/output/upsert-job-attributes.sql
 */

import { readFileSync, writeFileSync, existsSync, mkdirSync } from 'fs'
import { join } from 'path'
import { parse } from 'csv-parse/sync'

// ============================================
// 타입 정의
// ============================================

interface TaggingRow {
  job_id: string
  job_name: string
  bucket: string
  source_system: string
  wlb: string
  growth: string
  stability: string
  income: string
  teamwork: string
  solo_deep: string
  analytical: string
  creative: string
  execution: string
  people_facing: string
  work_hours: string
  shift_work: string
  travel: string
  remote_possible: string
  degree_required: string
  license_required: string
  confidence: string
  notes: string
}

// ============================================
// 검증 함수
// ============================================

const VALID_WORK_HOURS = ['regular', 'overtime_some', 'overtime_frequent']
const VALID_SHIFT_WORK = ['none', 'possible', 'required']
const VALID_TRAVEL = ['none', 'some', 'frequent']
const VALID_REMOTE = ['none', 'partial', 'full']
const VALID_DEGREE = ['none', 'college', 'bachelor', 'master', 'phd']
const VALID_LICENSE = ['none', 'preferred', 'required', 'multiple_required']

function validateRow(row: TaggingRow, index: number): string[] {
  const errors: string[] = []
  const rowNum = index + 2  // 헤더 포함

  // 필수 필드 체크
  if (!row.job_id) errors.push(`Row ${rowNum}: job_id 누락`)
  if (!row.job_name) errors.push(`Row ${rowNum}: job_name 누락`)

  // 수치형 필드 체크 (0~100)
  const numericFields = ['wlb', 'growth', 'stability', 'income', 'teamwork', 'solo_deep', 'analytical', 'creative', 'execution', 'people_facing']
  for (const field of numericFields) {
    const value = row[field as keyof TaggingRow]
    if (value === '' || value === undefined) continue  // 빈 값은 스킵
    const num = parseInt(value, 10)
    if (isNaN(num) || num < 0 || num > 100) {
      errors.push(`Row ${rowNum}: ${field}는 0~100 사이여야 함 (현재: ${value})`)
    }
  }

  // 범주형 필드 체크
  if (row.work_hours && !VALID_WORK_HOURS.includes(row.work_hours)) {
    errors.push(`Row ${rowNum}: work_hours 값 오류 (${row.work_hours})`)
  }
  if (row.shift_work && !VALID_SHIFT_WORK.includes(row.shift_work)) {
    errors.push(`Row ${rowNum}: shift_work 값 오류 (${row.shift_work})`)
  }
  if (row.travel && !VALID_TRAVEL.includes(row.travel)) {
    errors.push(`Row ${rowNum}: travel 값 오류 (${row.travel})`)
  }
  if (row.remote_possible && !VALID_REMOTE.includes(row.remote_possible)) {
    errors.push(`Row ${rowNum}: remote_possible 값 오류 (${row.remote_possible})`)
  }
  if (row.degree_required && !VALID_DEGREE.includes(row.degree_required)) {
    errors.push(`Row ${rowNum}: degree_required 값 오류 (${row.degree_required})`)
  }
  if (row.license_required && !VALID_LICENSE.includes(row.license_required)) {
    errors.push(`Row ${rowNum}: license_required 값 오류 (${row.license_required})`)
  }

  // confidence 체크 (0~1)
  if (row.confidence) {
    const conf = parseFloat(row.confidence)
    if (isNaN(conf) || conf < 0 || conf > 1) {
      errors.push(`Row ${rowNum}: confidence는 0~1 사이여야 함 (현재: ${row.confidence})`)
    }
  }

  return errors
}

// ============================================
// SQL 생성
// ============================================

function generateUpsertSQL(row: TaggingRow): string {
  const escapeStr = (s: string) => s.replace(/'/g, "''")
  
  // 빈 값은 기본값으로 대체
  const wlb = row.wlb || '50'
  const growth = row.growth || '50'
  const stability = row.stability || '50'
  const income = row.income || '50'
  const teamwork = row.teamwork || '50'
  const solo_deep = row.solo_deep || '50'
  const analytical = row.analytical || '50'
  const creative = row.creative || '50'
  const execution = row.execution || '50'
  const people_facing = row.people_facing || '50'
  const work_hours = row.work_hours || 'regular'
  const shift_work = row.shift_work || 'none'
  const travel = row.travel || 'none'
  const remote_possible = row.remote_possible || 'partial'
  const degree_required = row.degree_required || 'none'
  const license_required = row.license_required || 'none'
  const confidence = row.confidence || '0.95'
  
  // 메모를 evidence로 저장
  const evidence = row.notes 
    ? JSON.stringify({ manual_note: row.notes }) 
    : '{}'

  return `
INSERT INTO job_attributes (
  job_id, job_name, source_system, tagger_version, status,
  wlb, growth, stability, income, teamwork, solo_deep, analytical, creative, execution, people_facing,
  work_hours, shift_work, travel, remote_possible, degree_required, license_required, experience_required,
  _confidence, _field_confidence_json, evidence_json, raw_source_json
)
VALUES (
  '${escapeStr(row.job_id)}',
  '${escapeStr(row.job_name)}',
  '${escapeStr(row.source_system || 'CAREERNET')}',
  'manual-v1.0.0',
  'tagged',
  ${wlb}, ${growth}, ${stability}, ${income}, ${teamwork}, ${solo_deep}, ${analytical}, ${creative}, ${execution}, ${people_facing},
  '${work_hours}', '${shift_work}', '${travel}', '${remote_possible}', '${degree_required}', '${license_required}', 'none',
  ${confidence},
  '{}',
  '${escapeStr(evidence)}',
  '{}'
)
ON CONFLICT(job_id) DO UPDATE SET
  job_name = excluded.job_name,
  tagger_version = 'manual-v1.0.0',
  status = 'tagged',
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
  _confidence = excluded._confidence,
  evidence_json = excluded.evidence_json;
`
}

// ============================================
// 메인 함수
// ============================================

function main() {
  const args = process.argv.slice(2)
  
  if (args.length === 0) {
    console.log('사용법: npx tsx scripts/tagging/csv-to-d1-upsert.ts <input.csv>')
    console.log('')
    console.log('예시:')
    console.log('  npx tsx scripts/tagging/csv-to-d1-upsert.ts tagging-coverage-set.csv')
    process.exit(1)
  }

  const inputPath = args[0]
  if (!existsSync(inputPath)) {
    console.error(`❌ 파일을 찾을 수 없습니다: ${inputPath}`)
    process.exit(1)
  }

  // CSV 파싱
  const csvContent = readFileSync(inputPath, 'utf-8')
  const records: TaggingRow[] = parse(csvContent, {
    columns: true,
    skip_empty_lines: true,
    trim: true,
  })

  console.log(`📂 ${records.length}개 행 로드됨`)

  // 검증
  const allErrors: string[] = []
  for (let i = 0; i < records.length; i++) {
    const errors = validateRow(records[i], i)
    allErrors.push(...errors)
  }

  if (allErrors.length > 0) {
    console.error('\n❌ 검증 오류:')
    for (const error of allErrors) {
      console.error(`   ${error}`)
    }
    console.error(`\n총 ${allErrors.length}개 오류. 수정 후 다시 실행하세요.`)
    process.exit(1)
  }

  console.log('✅ 검증 통과')

  // 빈 행 필터링 (필수 필드가 모두 채워진 것만)
  const validRecords = records.filter(row => 
    row.job_id && 
    row.job_name && 
    (row.wlb || row.growth || row.stability)  // 최소 1개 수치형 필드
  )

  console.log(`📊 유효한 행: ${validRecords.length}개`)

  // SQL 생성
  const sqlStatements = [
    '-- Auto-generated from csv-to-d1-upsert.ts',
    `-- Generated at: ${new Date().toISOString()}`,
    `-- Source: ${inputPath}`,
    `-- Total rows: ${validRecords.length}`,
    '',
    'BEGIN TRANSACTION;',
    '',
  ]

  for (const row of validRecords) {
    sqlStatements.push(generateUpsertSQL(row))
  }

  sqlStatements.push('')
  sqlStatements.push('COMMIT;')
  sqlStatements.push('')
  sqlStatements.push(`-- Verify:`)
  sqlStatements.push(`-- SELECT COUNT(*) FROM job_attributes WHERE tagger_version = 'manual-v1.0.0';`)

  // 출력
  const outputDir = join(process.cwd(), 'scripts', 'tagging', 'output')
  if (!existsSync(outputDir)) {
    mkdirSync(outputDir, { recursive: true })
  }

  const outputPath = join(outputDir, 'upsert-job-attributes.sql')
  writeFileSync(outputPath, sqlStatements.join('\n'), 'utf-8')

  console.log(`\n✅ SQL 생성 완료: ${outputPath}`)
  console.log('')
  console.log('다음 단계:')
  console.log('  1. SQL 내용 확인')
  console.log('  2. 로컬 DB 적용:')
  console.log('     wrangler d1 execute careerwiki-db --local --file=scripts/tagging/output/upsert-job-attributes.sql')
  console.log('  3. 적용 확인:')
  console.log('     wrangler d1 execute careerwiki-db --local --command="SELECT COUNT(*) FROM job_attributes WHERE status = \'tagged\'"')

  // 버킷별 통계
  const bucketStats: Record<string, number> = {}
  for (const row of validRecords) {
    const bucket = row.bucket || 'UNCLASSIFIED'
    bucketStats[bucket] = (bucketStats[bucket] || 0) + 1
  }

  console.log('\n📊 버킷별 통계:')
  for (const [bucket, count] of Object.entries(bucketStats).sort((a, b) => b[1] - a[1])) {
    console.log(`   ${bucket}: ${count}개`)
  }
}

main()






