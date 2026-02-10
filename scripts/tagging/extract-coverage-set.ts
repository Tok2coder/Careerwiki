/**
 * Coverage Set 직업 추출 스크립트
 * 
 * 목적: DB에서 버킷별 대표 직업을 추출하여 태깅용 CSV 생성
 * 
 * 사용법:
 *   npx wrangler d1 execute careerwiki-kr --local --file=scripts/tagging/extract-jobs-query.sql > output.json
 *   npx tsx scripts/tagging/extract-coverage-set.ts
 */

import { writeFileSync, mkdirSync, existsSync } from 'fs'
import { join } from 'path'

// ============================================
// 버킷 정의
// ============================================

interface BucketDefinition {
  id: string
  name: string
  targetCount: number
  keywords: string[]  // 직업명/분류에서 매칭할 키워드
  classifications: string[]  // 대분류/중분류 코드
}

const BUCKETS: BucketDefinition[] = [
  {
    id: 'IT_DATA',
    name: 'IT/데이터',
    targetCount: 50,
    keywords: ['개발', '프로그래머', '엔지니어', '데이터', 'IT', '소프트웨어', '시스템', '네트워크', '보안', '클라우드', 'AI', '인공지능', '빅데이터', 'DBA', '웹'],
    classifications: ['정보통신', '전산', '컴퓨터'],
  },
  {
    id: 'MANUFACTURING',
    name: '제조/생산',
    targetCount: 35,
    keywords: ['생산', '제조', '공장', '품질', '기계', '전자', '자동차', '반도체', '설비', '조립', '용접'],
    classifications: ['제조', '생산', '기계'],
  },
  {
    id: 'CONSTRUCTION',
    name: '건설/건축',
    targetCount: 30,
    keywords: ['건축', '건설', '토목', '설계', '시공', '인테리어', '조경', '측량', '감리', '현장'],
    classifications: ['건설', '건축', '토목'],
  },
  {
    id: 'SALES_MARKETING',
    name: '영업/마케팅',
    targetCount: 40,
    keywords: ['영업', '마케팅', '광고', '판매', '세일즈', 'CRM', '브랜드', '홍보', 'PR', '기획'],
    classifications: ['영업', '판매', '마케팅'],
  },
  {
    id: 'FINANCE_ACCOUNTING',
    name: '금융/회계',
    targetCount: 35,
    keywords: ['회계', '세무', '금융', '은행', '보험', '투자', '펀드', '증권', '재무', '세리사', '회계사'],
    classifications: ['금융', '회계', '경제'],
  },
  {
    id: 'EDUCATION',
    name: '교육/연구',
    targetCount: 40,
    keywords: ['교사', '강사', '교수', '연구', '학원', '교육', '튜터', '훈련', '연구원'],
    classifications: ['교육', '연구', '학술'],
  },
  {
    id: 'MEDICAL_HEALTH',
    name: '의료/보건',
    targetCount: 45,
    keywords: ['의사', '간호', '약사', '병원', '의료', '보건', '치료', '검사', '임상', '재활', '한의'],
    classifications: ['의료', '보건', '간호'],
  },
  {
    id: 'LAW_PUBLIC',
    name: '법률/공공',
    targetCount: 30,
    keywords: ['변호사', '법무', '법원', '공무원', '경찰', '소방', '검찰', '행정', '세관', '외교'],
    classifications: ['법률', '공공', '행정'],
  },
  {
    id: 'SERVICE_HOSPITALITY',
    name: '서비스/외식',
    targetCount: 35,
    keywords: ['호텔', '요리', '조리', '바리스타', '승무원', '미용', '서비스', '레스토랑', '카페'],
    classifications: ['서비스', '음식', '숙박', '관광'],
  },
  {
    id: 'ARTS_DESIGN',
    name: '예술/디자인',
    targetCount: 35,
    keywords: ['디자인', '그래픽', 'UX', 'UI', '사진', '음악', '미술', '예술', '작가', '편집', '연출'],
    classifications: ['예술', '디자인', '문화'],
  },
  {
    id: 'MEDIA_CONTENTS',
    name: '미디어/콘텐츠',
    targetCount: 30,
    keywords: ['PD', '기자', '작가', '방송', '영상', '콘텐츠', '유튜브', '게임', '출판', '언론'],
    classifications: ['방송', '미디어', '출판'],
  },
  {
    id: 'LOGISTICS_TRANSPORT',
    name: '물류/운송',
    targetCount: 25,
    keywords: ['물류', '운송', '배송', '택배', '운전', '조종사', '선장', '항공', '철도', '해운'],
    classifications: ['물류', '운송', '항공'],
  },
  {
    id: 'AGRICULTURE_ENVIRONMENT',
    name: '농업/환경',
    targetCount: 25,
    keywords: ['농업', '환경', '조경', '수의사', '축산', '원예', '산림', '어업', '생태'],
    classifications: ['농업', '환경', '생명'],
  },
  {
    id: 'MANAGEMENT_HR',
    name: '경영/인사/총무',
    targetCount: 45,
    keywords: ['CEO', '경영', '인사', '총무', '기획', '전략', '컨설팅', '프로젝트', 'PM', '비서'],
    classifications: ['경영', '인사', '총무', '기획'],
  },
]

// ============================================
// 직업 분류 함수
// ============================================

interface JobRecord {
  job_id: string
  job_name: string
  source_system: string
  large_category?: string
  medium_category?: string
  small_category?: string
}

function classifyJob(job: JobRecord): string | null {
  const jobName = job.job_name.toLowerCase()
  const categories = [
    job.large_category || '',
    job.medium_category || '',
    job.small_category || '',
  ].join(' ').toLowerCase()

  for (const bucket of BUCKETS) {
    // 키워드 매칭
    for (const keyword of bucket.keywords) {
      if (jobName.includes(keyword.toLowerCase())) {
        return bucket.id
      }
    }
    // 분류 매칭
    for (const classification of bucket.classifications) {
      if (categories.includes(classification.toLowerCase())) {
        return bucket.id
      }
    }
  }

  return null  // 분류 실패
}

// ============================================
// CSV 생성
// ============================================

function generateCSVHeader(): string {
  return [
    'job_id',
    'job_name',
    'bucket',
    'source_system',
    'wlb',
    'growth',
    'stability',
    'income',
    'teamwork',
    'solo_deep',
    'analytical',
    'creative',
    'execution',
    'people_facing',
    'work_hours',
    'shift_work',
    'travel',
    'remote_possible',
    'degree_required',
    'license_required',
    'confidence',
    'notes',
  ].join(',')
}

function generateCSVRow(job: JobRecord, bucket: string): string {
  return [
    job.job_id,
    `"${job.job_name.replace(/"/g, '""')}"`,
    bucket,
    job.source_system,
    '', // wlb
    '', // growth
    '', // stability
    '', // income
    '', // teamwork
    '', // solo_deep
    '', // analytical
    '', // creative
    '', // execution
    '', // people_facing
    '', // work_hours
    '', // shift_work
    '', // travel
    '', // remote_possible
    '', // degree_required
    '', // license_required
    '', // confidence
    '', // notes
  ].join(',')
}

// ============================================
// 메인 로직 (샘플 데이터로 템플릿 생성)
// ============================================

function generateSampleTemplate() {
  const outputDir = join(process.cwd(), 'scripts', 'tagging', 'output')
  if (!existsSync(outputDir)) {
    mkdirSync(outputDir, { recursive: true })
  }

  // 샘플 직업 리스트 (실제로는 DB에서 추출)
  const sampleJobs: JobRecord[] = [
    // IT_DATA
    { job_id: 'sample_it_001', job_name: '소프트웨어개발자', source_system: 'CAREERNET' },
    { job_id: 'sample_it_002', job_name: '데이터분석가', source_system: 'CAREERNET' },
    { job_id: 'sample_it_003', job_name: 'AI엔지니어', source_system: 'CAREERNET' },
    // MEDICAL_HEALTH
    { job_id: 'sample_med_001', job_name: '의사', source_system: 'CAREERNET' },
    { job_id: 'sample_med_002', job_name: '간호사', source_system: 'CAREERNET' },
    { job_id: 'sample_med_003', job_name: '약사', source_system: 'CAREERNET' },
    // LAW_PUBLIC
    { job_id: 'sample_law_001', job_name: '변호사', source_system: 'CAREERNET' },
    { job_id: 'sample_law_002', job_name: '공무원', source_system: 'CAREERNET' },
    // SALES_MARKETING
    { job_id: 'sample_sales_001', job_name: '영업사원', source_system: 'CAREERNET' },
    { job_id: 'sample_sales_002', job_name: '마케터', source_system: 'CAREERNET' },
  ]

  const rows = [generateCSVHeader()]
  
  for (const job of sampleJobs) {
    const bucket = classifyJob(job) || 'UNCLASSIFIED'
    rows.push(generateCSVRow(job, bucket))
  }

  const csvContent = rows.join('\n')
  const outputPath = join(outputDir, 'tagging-template.csv')
  writeFileSync(outputPath, csvContent, 'utf-8')
  
  console.log(`✅ Template generated: ${outputPath}`)
  console.log(`   - ${sampleJobs.length} sample jobs`)
  console.log(`   - Fill in the empty columns and save as tagging-coverage-set.csv`)
}

// ============================================
// 버킷 요약 출력
// ============================================

function printBucketSummary() {
  console.log('\n📊 Coverage Set 버킷 요약\n')
  console.log('| 버킷 ID | 버킷명 | 목표 개수 |')
  console.log('|---------|--------|-----------|')
  
  let total = 0
  for (const bucket of BUCKETS) {
    console.log(`| ${bucket.id} | ${bucket.name} | ${bucket.targetCount}개 |`)
    total += bucket.targetCount
  }
  
  console.log(`\n총 목표: ${total}개`)
}

// ============================================
// SQL 쿼리 생성 (D1에서 직접 실행용)
// ============================================

function generateExtractSQL() {
  const outputDir = join(process.cwd(), 'scripts', 'tagging', 'output')
  if (!existsSync(outputDir)) {
    mkdirSync(outputDir, { recursive: true })
  }

  const sql = `
-- Coverage Set 직업 추출 쿼리
-- 사용: wrangler d1 execute careerwiki-kr --local --file=scripts/tagging/output/extract-jobs.sql

-- 1. 직업 기본 정보 추출
SELECT 
  js.job_id,
  js.job_name,
  js.source_system,
  json_extract(js.normalized_payload, '$.classifications.large') as large_category,
  json_extract(js.normalized_payload, '$.classifications.medium') as medium_category,
  json_extract(js.normalized_payload, '$.classifications.small') as small_category
FROM job_sources js
WHERE js.source_system IN ('CAREERNET', 'WORK24_JOB')
ORDER BY js.job_name
LIMIT 1000;

-- 2. 기존 태깅된 직업 확인 (중복 방지)
-- SELECT job_id, job_name, status FROM job_attributes WHERE status = 'tagged';
`

  const outputPath = join(outputDir, 'extract-jobs.sql')
  writeFileSync(outputPath, sql, 'utf-8')
  console.log(`\n📝 SQL query generated: ${outputPath}`)
}

// ============================================
// 실행
// ============================================

printBucketSummary()
generateSampleTemplate()
generateExtractSQL()

console.log('\n📋 다음 단계:')
console.log('1. wrangler d1 execute careerwiki-kr --local --file=scripts/tagging/output/extract-jobs.sql')
console.log('2. 결과를 바탕으로 버킷별 직업 선정')
console.log('3. tagging-template.csv를 복사하여 태깅 작업 시작')







