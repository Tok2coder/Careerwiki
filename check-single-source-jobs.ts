/**
 * 단일 소스 직업 데이터 완전성 확인 스크립트
 * Case 5 (고용24사전만), Case 6 (커리어넷만), Case 7 (고용24직업만) 확인
 */

import type { D1Database } from '@cloudflare/workers-types'

interface CheckResult {
  jobName: string
  case: string
  sourceSystem: string
  hasJobSource: boolean
  hasMergedProfile: boolean
  sourceFields: string[]
  mergedFields: string[]
  missingFields: string[]
  renderingFields: string[]
}

// 각 케이스별 테스트 직업
const TEST_JOBS = {
  CASE_5_WORK24_DJOB_ONLY: ['3D지도개발자', '3D프린터설치정비원', '3D프린팅운영기사'],
  CASE_6_CAREERNET_ONLY: ['GIS전문가', 'IT컨설턴트', '가구제조,수리원'],
  CASE_7_WORK24_JOB_ONLY: ['IT기술지원전문가', 'IT테스터 및 IT QA전문가', 'UX·UI디자이너']
}

// 각 소스별 필수 필드 목록
const REQUIRED_FIELDS = {
  WORK24_DJOB: [
    'name',
    'doWork',
    'workStrong',
    'workPlace',
    'physicalAct',
    'eduLevel',
    'skillYear',
    'summary',
    'workSum'
  ],
  CAREERNET: [
    'name',
    'summary',
    'duties',
    'workList',
    'relatedMajors',
    'relatedCertificates',
    'relatedJobs',
    'prospect',
    'forecastList',
    'indicatorChart',
    'satisfaction',
    'wlb',
    'social',
    'jobReadyList',
    'researchList'
  ],
  WORK24_JOB: [
    'name',
    'summary',
    'duties',
    'salary',
    'prospect',
    'status',
    'abilities',
    'knowledge',
    'environment',
    'personality',
    'interests',
    'values',
    'relatedMajors',
    'relatedCertificates',
    'relatedJobs',
    'classifications',
    'jobSumProspect',
    'technKnow'
  ]
}

function extractFields(obj: any, prefix: string = ''): string[] {
  const fields: string[] = []
  
  if (!obj || typeof obj !== 'object') {
    return fields
  }
  
  for (const key in obj) {
    const fullKey = prefix ? `${prefix}.${key}` : key
    fields.push(fullKey)
    
    if (obj[key] && typeof obj[key] === 'object' && !Array.isArray(obj[key])) {
      fields.push(...extractFields(obj[key], fullKey))
    }
  }
  
  return fields
}

function checkFieldExists(obj: any, fieldPath: string): boolean {
  const parts = fieldPath.split('.')
  let current = obj
  
  for (const part of parts) {
    if (current === null || current === undefined) {
      return false
    }
    current = current[part]
  }
  
  return current !== null && current !== undefined && current !== ''
}

export async function checkSingleSourceJobs(db: D1Database): Promise<void> {
  console.log('🔍 단일 소스 직업 데이터 완전성 확인 시작...\n')
  
  const results: CheckResult[] = []
  
  // Case 5: 고용24사전만
  console.log('📋 Case 5: 고용24사전만 (WORK24_DJOB)\n')
  for (const jobName of TEST_JOBS.CASE_5_WORK24_DJOB_ONLY) {
    const result = await checkJob(db, jobName, 'WORK24_DJOB', 'Case 5')
    results.push(result)
    printResult(result)
  }
  
  // Case 6: 커리어넷만
  console.log('\n📋 Case 6: 커리어넷만 (CAREERNET)\n')
  for (const jobName of TEST_JOBS.CASE_6_CAREERNET_ONLY) {
    const result = await checkJob(db, jobName, 'CAREERNET', 'Case 6')
    results.push(result)
    printResult(result)
  }
  
  // Case 7: 고용24직업만
  console.log('\n📋 Case 7: 고용24직업만 (WORK24_JOB)\n')
  for (const jobName of TEST_JOBS.CASE_7_WORK24_JOB_ONLY) {
    const result = await checkJob(db, jobName, 'WORK24_JOB', 'Case 7')
    results.push(result)
    printResult(result)
  }
  
  // 종합 리포트
  console.log('\n' + '='.repeat(80))
  console.log('📊 종합 리포트\n')
  
  const summary = {
    total: results.length,
    hasJobSource: results.filter(r => r.hasJobSource).length,
    hasMergedProfile: results.filter(r => r.hasMergedProfile).length,
    completeData: results.filter(r => r.hasJobSource && r.hasMergedProfile && r.missingFields.length === 0).length,
    incompleteData: results.filter(r => r.missingFields.length > 0).length
  }
  
  console.log(`총 확인 직업: ${summary.total}개`)
  console.log(`job_sources 존재: ${summary.hasJobSource}개`)
  console.log(`jobs.merged_profile_json 존재: ${summary.hasMergedProfile}개`)
  console.log(`완전한 데이터: ${summary.completeData}개`)
  console.log(`불완전한 데이터: ${summary.incompleteData}개`)
  
  if (summary.incompleteData > 0) {
    console.log('\n⚠️ 불완전한 데이터 상세:\n')
    results.filter(r => r.missingFields.length > 0).forEach(r => {
      console.log(`  ${r.jobName} (${r.case}):`)
      console.log(`    누락 필드: ${r.missingFields.join(', ')}`)
    })
  }
}

async function checkJob(
  db: D1Database,
  jobName: string,
  sourceSystem: string,
  caseName: string
): Promise<CheckResult> {
  // 1. job_sources 확인
  const sourceQuery = `
    SELECT 
      source_system,
      raw_payload,
      normalized_payload
    FROM job_sources
    WHERE source_system = ?
      AND (
        JSON_EXTRACT(normalized_payload, '$.name') = ?
        OR JSON_EXTRACT(raw_payload, '$.dJobNm') = ?
        OR JSON_EXTRACT(raw_payload, '$.jobNm') = ?
        OR JSON_EXTRACT(raw_payload, '$.summary.jobNm') = ?
      )
    LIMIT 1
  `
  
  const sourceRow = await db.prepare(sourceQuery)
    .bind(sourceSystem, jobName, jobName, jobName, jobName)
    .first<{
      source_system: string
      raw_payload: string
      normalized_payload: string
    }>()
  
  const hasJobSource = !!sourceRow
  
  let sourceFields: string[] = []
  let normalizedData: any = {}
  
  if (sourceRow) {
    try {
      normalizedData = JSON.parse(sourceRow.normalized_payload || '{}')
      sourceFields = extractFields(normalizedData)
    } catch (e) {
      console.error(`  ⚠️ Failed to parse normalized_payload for ${jobName}`)
    }
  }
  
  // 2. jobs.merged_profile_json 확인
  const jobQuery = `
    SELECT 
      name,
      merged_profile_json
    FROM jobs
    WHERE name = ?
      AND merged_profile_json IS NOT NULL
      AND merged_profile_json != '{}'
    LIMIT 1
  `
  
  const jobRow = await db.prepare(jobQuery)
    .bind(jobName)
    .first<{
      name: string
      merged_profile_json: string
    }>()
  
  const hasMergedProfile = !!jobRow
  
  let mergedFields: string[] = []
  let mergedData: any = {}
  
  if (jobRow) {
    try {
      mergedData = JSON.parse(jobRow.merged_profile_json)
      mergedFields = extractFields(mergedData)
    } catch (e) {
      console.error(`  ⚠️ Failed to parse merged_profile_json for ${jobName}`)
    }
  }
  
  // 3. 필수 필드 확인
  const requiredFields = REQUIRED_FIELDS[sourceSystem as keyof typeof REQUIRED_FIELDS] || []
  const missingFields: string[] = []
  
  for (const field of requiredFields) {
    if (!checkFieldExists(mergedData, field)) {
      missingFields.push(field)
    }
  }
  
  // 4. 렌더링 필드 확인 (템플릿에서 사용하는 주요 필드)
  const renderingFields: string[] = []
  const renderingChecks = [
    'heroTitle',
    'heroIntro',
    'heroCategory',
    'heroTags',
    'summary',
    'duties',
    'workMainDesc',
    'prospect',
    'salary',
    'relatedMajors',
    'relatedCertificates',
    'relatedJobs'
  ]
  
  for (const field of renderingChecks) {
    if (checkFieldExists(mergedData, field)) {
      renderingFields.push(field)
    }
  }
  
  return {
    jobName,
    case: caseName,
    sourceSystem,
    hasJobSource,
    hasMergedProfile,
    sourceFields,
    mergedFields,
    missingFields,
    renderingFields
  }
}

function printResult(result: CheckResult): void {
  console.log(`  📌 ${result.jobName}`)
  console.log(`     소스: ${result.sourceSystem}`)
  console.log(`     job_sources 존재: ${result.hasJobSource ? '✅' : '❌'}`)
  console.log(`     jobs.merged_profile_json 존재: ${result.hasMergedProfile ? '✅' : '❌'}`)
  
  if (result.hasJobSource) {
    console.log(`     normalized_payload 필드 수: ${result.sourceFields.length}개`)
  }
  
  if (result.hasMergedProfile) {
    console.log(`     merged_profile_json 필드 수: ${result.mergedFields.length}개`)
    console.log(`     렌더링 가능 필드: ${result.renderingFields.length}개 (${result.renderingFields.slice(0, 5).join(', ')}${result.renderingFields.length > 5 ? '...' : ''})`)
    
    if (result.missingFields.length > 0) {
      console.log(`     ⚠️ 누락 필드: ${result.missingFields.join(', ')}`)
    } else {
      console.log(`     ✅ 필수 필드 모두 존재`)
    }
  } else {
    console.log(`     ❌ merged_profile_json 없음 - ETL 미실행 또는 실패`)
  }
  
  console.log()
}

// 실행 함수
export async function runCheck(db: D1Database): Promise<void> {
  await checkSingleSourceJobs(db)
}

