#!/usr/bin/env npx tsx
/**
 * batch-tagger.ts
 *
 * 배치별로 AI 태깅을 자동화하는 스크립트
 * 각 직업을 분석하여 구조화된 속성을 추출
 */

import * as fs from 'fs'
import * as path from 'path'

interface JobData {
  job_id: string
  job_name: string
  source_system: string
  current_status: string
  content: {
    duties: string
    environment: string
    qualifications: string
    outlook: string
    salary_info: string
    related_majors: string[]
    related_licenses: string[]
    classifications: {
      large: string
      medium?: string
      small?: string
    }
  }
}

interface TaggedJob {
  job_id: string
  job_name: string
  source_system: 'CAREERNET' | 'WORK24_JOB' | 'MERGED'
  tagger_version: string
  status: 'tagged'
  wlb: number
  work_hours: 'regular' | 'overtime_some' | 'overtime_frequent'
  shift_work: 'none' | 'possible' | 'required'
  travel: 'none' | 'some' | 'frequent'
  remote_possible: 'none' | 'partial' | 'full'
  growth: number
  stability: number
  income: number
  teamwork: number
  solo_deep: number
  analytical: number
  creative: number
  execution: number
  people_facing: number
  degree_required: 'none' | 'college' | 'bachelor' | 'master' | 'phd'
  license_required: 'none' | 'preferred' | 'required' | 'multiple_required'
  _confidence: number
  _field_confidence: {
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
    degree_required: number
    license_required: number
  }
  evidence: {
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
    degree_required: string
    license_required: string
  }
}

// 태깅 로직 구현
function analyzeJob(job: JobData): TaggedJob {
  const duties = job.content.duties.toLowerCase()
  const environment = job.content.environment.toLowerCase()
  const qualifications = job.content.qualifications.toLowerCase()
  const classifications = job.content.classifications

  // 기본 분석 함수들
  const hasKeywords = (text: string, keywords: string[]) =>
    keywords.some(keyword => text.includes(keyword))

  const isServiceJob = () =>
    hasKeywords(classifications.large, ['서비스', '영업', '판매', '상담', '안내'])

  const isTechnicalJob = () =>
    hasKeywords(classifications.large, ['공학', '기술', '연구', '설치', '정비', '생산'])

  const isCreativeJob = () =>
    hasKeywords(classifications.large, ['예술', '디자인', '창작', '공연'])

  const isOfficeJob = () =>
    hasKeywords(classifications.large, ['사무', '금융', '경영'])

  // WLB 분석
  let wlb = 50
  let work_hours: TaggedJob['work_hours'] = 'regular'
  let shift_work: TaggedJob['shift_work'] = 'none'

  if (hasKeywords(duties, ['야근', '야간', '늦게', '연장', 'overtime'])) {
    wlb -= 20
    work_hours = 'overtime_frequent'
  } else if (hasKeywords(duties, ['방문', '출장', '외근', '현장'])) {
    wlb -= 10
    work_hours = 'overtime_some'
  }

  if (hasKeywords(duties, ['교대', 'shift', '24시간', '당직'])) {
    wlb -= 30
    shift_work = 'required'
  }

  // Travel 분석
  let travel: TaggedJob['travel'] = 'none'
  if (hasKeywords(duties, ['방문', '출장', '외근', '현장', '이동'])) {
    travel = hasKeywords(duties, ['정기적', '상시', '많이']) ? 'frequent' : 'some'
  }

  // Remote 분석
  let remote_possible: TaggedJob['remote_possible'] = 'none'
  if (isOfficeJob()) {
    remote_possible = hasKeywords(duties, ['재택', '원격', 'remote']) ? 'full' : 'partial'
  }

  // Growth 분석
  let growth = 50
  if (isTechnicalJob()) growth += 20 // 기술직은 성장 기회 많음
  if (hasKeywords(duties, ['개발', '연구', '설계', '기획'])) growth += 15
  if (hasKeywords(duties, ['교육', '훈련', '자격증'])) growth += 10

  // Stability 분석
  let stability = 50
  if (isOfficeJob()) stability += 20 // 사무직 안정적
  if (isTechnicalJob()) stability += 15 // 기술직 안정적
  if (hasKeywords(duties, ['계약', '프리랜서', '임시'])) stability -= 20

  // Income 분석 (분류 기반)
  let income = 50
  if (isCreativeJob()) income -= 10 // 예술직 수입 불안정
  if (isTechnicalJob()) income += 10 // 기술직 수입 좋음
  if (hasKeywords(classifications.large, ['고위', '임원', '전문직'])) income += 20

  // Teamwork vs Solo 분석
  let teamwork = 50
  let solo_deep = 50

  if (hasKeywords(duties, ['협력', '팀', '함께', '회의', '협의'])) {
    teamwork += 20
    solo_deep -= 20
  }
  if (hasKeywords(duties, ['독립', '개인', '혼자', '전담'])) {
    teamwork -= 20
    solo_deep += 20
  }

  // Analytical vs Creative vs Execution
  let analytical = 50
  let creative = 50
  let execution = 50

  if (hasKeywords(duties, ['분석', '연구', '계산', '평가', '조사'])) {
    analytical += 20
    creative -= 10
    execution -= 10
  }
  if (hasKeywords(duties, ['디자인', '창작', '개발', '기획', '아이디어'])) {
    creative += 20
    analytical -= 10
    execution -= 10
  }
  if (hasKeywords(duties, ['제작', '조립', '설치', '수리', '운영', '관리'])) {
    execution += 20
    analytical -= 10
    creative -= 10
  }

  // People facing 분석
  let people_facing = 50
  if (hasKeywords(duties, ['고객', '상담', '안내', '서비스', '판매'])) {
    people_facing += 25
  }
  if (hasKeywords(duties, ['내부', '독립', '연구', '개발'])) {
    people_facing -= 15
  }

  // Degree/License 요구사항 (직업명 기반 자동 추론 강화)
  let degree_required: TaggedJob['degree_required'] = 'none'
  let license_required: TaggedJob['license_required'] = 'none'
  const jobNameLower = job.job_name.toLowerCase()

  // ===== 의사 직군 (의사 면허 + 박사급 학위 필수) =====
  if (jobNameLower.includes('의사') || 
      jobNameLower.includes('내과') || 
      jobNameLower.includes('외과') ||
      jobNameLower.includes('정신과') ||
      jobNameLower.includes('안과') ||
      jobNameLower.includes('이비인후과') ||
      jobNameLower.includes('피부과') ||
      jobNameLower.includes('비뇨기과') ||
      jobNameLower.includes('산부인과')) {
    degree_required = 'phd' // doctorate level
    license_required = 'required'
  }
  // ===== 약사/한약사 직군 =====
  else if (jobNameLower.includes('약사') || jobNameLower.includes('한약사')) {
    degree_required = 'phd' // doctorate level (6년제)
    license_required = 'required'
  }
  // ===== 변호사/검사/판사 직군 =====
  else if (jobNameLower.includes('변호사') || 
           jobNameLower.includes('검사') ||
           jobNameLower.includes('판사')) {
    degree_required = 'bachelor'
    license_required = 'required'
  }
  // ===== 교수/시간강사 직군 (박사 학위 필수) =====
  else if (jobNameLower.includes('교수') || 
           jobNameLower.includes('시간강사')) {
    degree_required = 'phd'
    license_required = 'none'
  }
  // ===== 교사 직군 (학사 + 교원자격증 필수) =====
  else if (jobNameLower.includes('교사') && !jobNameLower.includes('보조교사')) {
    degree_required = 'bachelor'
    license_required = 'required'
  }
  // ===== 보조교사 =====
  else if (jobNameLower.includes('보조교사')) {
    degree_required = 'college'
    license_required = 'preferred'
  }
  // ===== 연구원 직군 (석사 이상) =====
  else if (jobNameLower.includes('연구원') || 
           jobNameLower.includes('연구자') ||
           jobNameLower.includes('과학자')) {
    degree_required = 'master'
    license_required = 'none'
  }
  // ===== 치료사 직군 (학사 + 면허) =====
  else if (jobNameLower.includes('치료사') || 
           jobNameLower.includes('물리치료') || 
           jobNameLower.includes('작업치료') ||
           jobNameLower.includes('언어치료')) {
    degree_required = 'bachelor'
    license_required = 'required'
  }
  // ===== 간호사 직군 =====
  else if (jobNameLower.includes('간호사')) {
    degree_required = 'bachelor'
    license_required = 'required'
  }
  // ===== 간호조무사 =====
  else if (jobNameLower.includes('간호조무사')) {
    degree_required = 'college'
    license_required = 'required'
  }
  // ===== 의료기사 직군 =====
  else if (jobNameLower.includes('방사선사') || 
           jobNameLower.includes('임상병리사') ||
           jobNameLower.includes('치과기공사') ||
           jobNameLower.includes('치과위생사')) {
    degree_required = 'college'
    license_required = 'required'
  }
  // ===== 임상심리사 =====
  else if (jobNameLower.includes('임상심리사')) {
    degree_required = 'bachelor'
    license_required = 'required'
  }
  // ===== 전문 자격사 (세무사, 관세사, 감정평가사, 공인회계사 등) =====
  else if (jobNameLower.includes('세무사') ||
           jobNameLower.includes('관세사') ||
           jobNameLower.includes('감정평가사') ||
           jobNameLower.includes('공인회계사') ||
           jobNameLower.includes('건축사') ||
           jobNameLower.includes('법무사') ||
           jobNameLower.includes('변리사') ||
           jobNameLower.includes('노무사') ||
           jobNameLower.includes('행정사')) {
    degree_required = 'bachelor'
    license_required = 'required'
  }
  // ===== 건축가/설계사 =====
  else if (jobNameLower.includes('건축가') || 
           jobNameLower.includes('건축설계')) {
    degree_required = 'bachelor'
    license_required = 'required'
  }
  // ===== 공학기술자 =====
  else if (jobNameLower.includes('기술자') || 
           jobNameLower.includes('엔지니어')) {
    degree_required = 'bachelor'
    license_required = 'preferred'
  }
  // ===== 강사 직군 =====
  else if (jobNameLower.includes('강사')) {
    degree_required = 'bachelor'
    license_required = 'none'
  }
  // ===== 사서 =====
  else if (jobNameLower.includes('사서') && !jobNameLower.includes('사무')) {
    degree_required = 'bachelor'
    license_required = 'required'
  }
  // ===== 도선사 (면허 필수) =====
  else if (jobNameLower.includes('도선사')) {
    degree_required = 'none'
    license_required = 'required'
  }
  // ===== 위생사/이용사/미용사 =====
  else if (jobNameLower.includes('위생사') ||
           jobNameLower.includes('이용사') ||
           jobNameLower.includes('미용사')) {
    degree_required = 'college'
    license_required = 'required'
  }
  // ===== 공무원 =====
  else if (jobNameLower.includes('공무원')) {
    degree_required = 'none'
    license_required = 'required' // 공무원 시험
  }
  // ===== 기사/산업기사 (자격증) =====
  else if (jobNameLower.includes('기사') && 
           !jobNameLower.includes('기사도우미') &&
           !jobNameLower.includes('배달기사') &&
           !jobNameLower.includes('대리기사') &&
           !jobNameLower.includes('탁송기사') &&
           !jobNameLower.includes('배차기사') &&
           !jobNameLower.includes('운전기사')) {
    degree_required = 'college'
    license_required = 'preferred'
  }
  // ===== 장례지도사 =====
  else if (jobNameLower.includes('장례지도사')) {
    degree_required = 'none'
    license_required = 'preferred'
  }
  // ===== 부사관/군인 =====
  else if (jobNameLower.includes('부사관') || jobNameLower.includes('장교')) {
    degree_required = 'none'
    license_required = 'required'
  }
  // ===== 기본 로직 (텍스트 기반) =====
  else if (isTechnicalJob()) {
    if (hasKeywords(qualifications, ['학사', '대학교', 'bachelor'])) {
      degree_required = 'bachelor'
    }
    if (hasKeywords(duties, ['자격증', '면허', 'license'])) {
      license_required = 'preferred'
    }
  }

  // 신뢰도 계산
  const baseConfidence = 0.7
  const fieldConfidence = {
    wlb: baseConfidence,
    growth: baseConfidence,
    stability: baseConfidence,
    income: baseConfidence - 0.1, // 수입은 추정치
    teamwork: baseConfidence,
    solo_deep: baseConfidence,
    analytical: baseConfidence,
    creative: baseConfidence,
    execution: baseConfidence,
    people_facing: baseConfidence,
    degree_required: qualifications.length > 0 ? baseConfidence : baseConfidence - 0.2,
    license_required: qualifications.length > 0 ? baseConfidence : baseConfidence - 0.2
  }

  const overallConfidence = Object.values(fieldConfidence).reduce((a, b) => a + b) / Object.values(fieldConfidence).length

  // 근거 생성
  const generateEvidence = (field: string, value: any) => {
    const baseEvidence = `${field}는 ${duties.substring(0, 100)}... 기반으로 ${value}로 평가`
    return baseEvidence.length > 200 ? baseEvidence.substring(0, 197) + '...' : baseEvidence
  }

  return {
    job_id: job.job_id,
    job_name: job.job_name,
    source_system: job.source_system as TaggedJob['source_system'],
    tagger_version: 'tagger-v1.1.0', // 직업명 기반 자격요건 추론 강화
    status: 'tagged',
    wlb,
    work_hours,
    shift_work,
    travel,
    remote_possible,
    growth,
    stability,
    income,
    teamwork,
    solo_deep,
    analytical,
    creative,
    execution,
    people_facing,
    degree_required,
    license_required,
    _confidence: Math.round(overallConfidence * 100) / 100,
    _field_confidence: fieldConfidence,
    evidence: {
      wlb: generateEvidence('wlb', wlb),
      growth: generateEvidence('growth', growth),
      stability: generateEvidence('stability', stability),
      income: generateEvidence('income', income),
      teamwork: generateEvidence('teamwork', teamwork),
      solo_deep: generateEvidence('solo_deep', solo_deep),
      analytical: generateEvidence('analytical', analytical),
      creative: generateEvidence('creative', creative),
      execution: generateEvidence('execution', execution),
      people_facing: generateEvidence('people_facing', people_facing),
      degree_required: generateEvidence('degree_required', degree_required),
      license_required: generateEvidence('license_required', license_required)
    }
  }
}

function main() {
  const batchNum = process.argv[2]
  if (!batchNum) {
    console.error('Usage: npx tsx scripts/batch-tagger.ts <batch_number>')
    console.error('Example: npx tsx scripts/batch-tagger.ts 001')
    process.exit(1)
  }

  const inputFile = path.join('tagging-batches', `batch_${batchNum}.json`)
  const outputFile = path.join('tagging-batches', 'results', `batch_${batchNum}_tagged.json`)

  if (!fs.existsSync(inputFile)) {
    console.error(`❌ Input file not found: ${inputFile}`)
    process.exit(1)
  }

  console.log(`🔍 Processing batch ${batchNum}...`)

  const jobs: JobData[] = JSON.parse(fs.readFileSync(inputFile, 'utf-8'))
  const taggedJobs: TaggedJob[] = []

  for (let i = 0; i < jobs.length; i++) {
    const job = jobs[i]
    console.log(`  ${i + 1}/${jobs.length}: ${job.job_name}`)

    try {
      const tagged = analyzeJob(job)
      taggedJobs.push(tagged)
    } catch (error) {
      console.error(`❌ Failed to tag ${job.job_name}:`, error)
    }
  }

  fs.writeFileSync(outputFile, JSON.stringify(taggedJobs, null, 2), 'utf-8')
  console.log(`\n✅ Tagged ${taggedJobs.length} jobs`)
  console.log(`📁 Saved to: ${outputFile}`)

  console.log(`\n💡 Next: npx tsx scripts/tagging-helper.ts apply ${batchNum}`)
}

main()

