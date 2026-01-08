/**
 * 태깅을 위한 직업 목록 추출 스크립트
 * DB에서 모든 직업을 추출하여 버킷별로 분류
 */

import { writeFileSync, mkdirSync, existsSync } from 'fs'
import { join } from 'path'

// ============================================
// 버킷 정의 (TAGGING_GUIDE_MANUAL.md와 동일)
// ============================================

interface BucketDefinition {
  id: string
  name: string
  targetCount: number
  keywords: string[]
  classifications: string[]
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
// 직업 인터페이스
// ============================================

interface JobRecord {
  job_id: string
  job_name: string
  source_system: string
  large_category: string
  medium_category: string
  small_category: string
}

// ============================================
// 버킷 분류 함수
// ============================================

function classifyJob(job: JobRecord): string {
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

  return 'UNCLASSIFIED'
}

// ============================================
// 메인 함수 (실제로는 DB에서 데이터 가져와야 함)
// ============================================

function generateCoverageSet() {
  const outputDir = join(process.cwd(), 'scripts', 'tagging', 'output')
  if (!existsSync(outputDir)) {
    mkdirSync(outputDir, { recursive: true })
  }

  // 샘플 데이터 (실제로는 DB에서 가져와야 함)
  // 실제로는 wrangler d1 execute 결과를 JSON으로 파싱해서 사용
  const sampleJobs: JobRecord[] = [
    // IT_DATA 예시
    { job_id: 'sample_it_001', job_name: '소프트웨어개발자', source_system: 'CAREERNET', large_category: 'IT관련전문직', medium_category: '', small_category: '' },
    { job_id: 'sample_it_002', job_name: '데이터분석가', source_system: 'CAREERNET', large_category: 'IT관련전문직', medium_category: '', small_category: '' },
    { job_id: 'sample_it_003', job_name: 'AI엔지니어', source_system: 'CAREERNET', large_category: 'IT관련전문직', medium_category: '', small_category: '' },
    // MEDICAL_HEALTH 예시
    { job_id: 'sample_med_001', job_name: '의사', source_system: 'CAREERNET', large_category: '의료직', medium_category: '', small_category: '' },
    { job_id: 'sample_med_002', job_name: '간호사', source_system: 'CAREERNET', large_category: '의료직', medium_category: '', small_category: '' },
    { job_id: 'sample_med_003', job_name: '약사', source_system: 'CAREERNET', large_category: '의료직', medium_category: '', small_category: '' },
    // LAW_PUBLIC 예시
    { job_id: 'sample_law_001', job_name: '변호사', source_system: 'CAREERNET', large_category: '법률직', medium_category: '', small_category: '' },
    { job_id: 'sample_law_002', job_name: '공무원', source_system: 'CAREERNET', large_category: '공무원', medium_category: '', small_category: '' },
    // SALES_MARKETING 예시
    { job_id: 'sample_sales_001', job_name: '영업사원', source_system: 'CAREERNET', large_category: '영업직', medium_category: '', small_category: '' },
    { job_id: 'sample_sales_002', job_name: '마케터', source_system: 'CAREERNET', large_category: '마케팅직', medium_category: '', small_category: '' },
  ]

  // 버킷별 분류
  const bucketedJobs: Record<string, JobRecord[]> = {}
  for (const job of sampleJobs) {
    const bucket = classifyJob(job)
    if (!bucketedJobs[bucket]) {
      bucketedJobs[bucket] = []
    }
    bucketedJobs[bucket].push(job)
  }

  // CSV 헤더
  const header = 'job_id,job_name,bucket,source_system,large_category,medium_category,small_category\n'

  // 버킷별 CSV 생성
  let allCsv = header
  let totalSelected = 0

  for (const bucket of BUCKETS) {
    const jobs = bucketedJobs[bucket.id] || []
    const selectedJobs = jobs.slice(0, bucket.targetCount) // 목표 개수만큼 선택

    console.log(`${bucket.name} (${bucket.id}): ${jobs.length}개 → ${selectedJobs.length}개 선택`)

    // 버킷별 CSV
    let bucketCsv = header
    for (const job of selectedJobs) {
      const row = [
        job.job_id,
        `"${job.job_name.replace(/"/g, '""')}"`,
        bucket.id,
        job.source_system,
        `"${job.large_category.replace(/"/g, '""')}"`,
        `"${job.medium_category.replace(/"/g, '""')}"`,
        `"${job.small_category.replace(/"/g, '""')}"`,
      ].join(',')
      bucketCsv += row + '\n'
      allCsv += row + '\n'
    }

    // 버킷별 파일 저장
    const bucketFile = join(outputDir, `coverage-set-${bucket.id.toLowerCase()}.csv`)
    writeFileSync(bucketFile, bucketCsv, 'utf-8')
    console.log(`  ✅ ${bucketFile}`)

    totalSelected += selectedJobs.length
  }

  // 전체 파일 저장
  const allFile = join(outputDir, 'coverage-set-all.csv')
  writeFileSync(allFile, allCsv, 'utf-8')
  console.log(`\n✅ 전체 파일: ${allFile} (${totalSelected}개)`)

  // 요약
  console.log('\n📊 Coverage Set 요약:')
  for (const bucket of BUCKETS) {
    const jobs = bucketedJobs[bucket.id] || []
    const selected = Math.min(jobs.length, bucket.targetCount)
    console.log(`  ${bucket.name}: ${selected}/${bucket.targetCount}개`)
  }
  console.log(`  총계: ${totalSelected}/${BUCKETS.reduce((sum, b) => sum + b.targetCount, 0)}개`)

  // AI 태깅 프롬프트 생성
  generateAIPrompts(bucketedJobs)
}

// ============================================
// AI 태깅 프롬프트 생성
// ============================================

function generateAIPrompts(bucketedJobs: Record<string, JobRecord[]>) {
  const outputDir = join(process.cwd(), 'scripts', 'tagging', 'output')

  // Phase 1: Coverage Set 선정 프롬프트
  const phase1Prompt = `
[태깅 Phase 1: Coverage Set 직업 선정]

목표: 전체 1,423개 직업 중 Coverage Set 500개를 MECE하게 선정한다.

버킷 정의:
${BUCKETS.map(b => `- ${b.id} (${b.name}): ${b.targetCount}개 목표`).join('\n')}

각 버킷의 매칭 기준:
${BUCKETS.map(b => `- ${b.id}: 키워드 [${b.keywords.join(', ')}], 분류 [${b.classifications.join(', ')}]`).join('\n')}

작업:
1. 제공된 전체 직업 목록에서 각 버킷에 속하는 직업을 분류
2. 각 버킷에서 고빈도/대표적인 직업을 목표 개수만큼 선정
3. 다양한 세부 분야를 커버하도록 균형 있게 선택

출력 형식: 버킷별로 job_id, job_name, bucket을 CSV 형식으로 나열

예시:
job_id,job_name,bucket
careernet_100001,소프트웨어개발자,IT_DATA
careernet_100002,데이터분석가,IT_DATA
...
`

  writeFileSync(join(outputDir, 'ai-prompt-phase1.txt'), phase1Prompt.trim(), 'utf-8')
  console.log('✅ AI 프롬프트: ai-prompt-phase1.txt')

  // Phase 2: 버킷별 태깅 프롬프트 템플릿
  for (const bucket of BUCKETS) {
    const prompt = `
[태깅 Phase 2-${bucket.id}: ${bucket.name} 버킷 태깅]

대상 직업 목록:
[여기에 Phase 1에서 선정된 ${bucket.targetCount}개 ${bucket.name} 직업 목록을 붙여넣으세요]

각 직업에 대해 아래 속성을 채워주세요:

[수치형 0~100 스케일]
- wlb: 워라밸 점수 (정시퇴근=80+, 야근잦음=40-, 교대=20-)
- growth: 성장가능성 (신기술=80+, 정체=30-)
- stability: 안정성 (공기업/대기업=80+, 스타트업=40-)
- income: 수입 수준 (1억+=80, 6천만=60, 4천만=40, 2.5천만=20)
- teamwork: 협업비중 (팀필수=80+, 혼자=20-)
- solo_deep: 집중업무 (연구/개발=80+, 대응업무=20-)
- analytical: 분석업무 (데이터분석=80+, 단순실행=20-)
- creative: 창의업무 (기획/디자인=80+, 매뉴얼=20-)
- execution: 실행업무 (운영/관리=80+, 조언만=20-)
- people_facing: 대면업무 (고객응대=80+, 백오피스=20-)

[범주형]
- work_hours: "regular" / "overtime_some" / "overtime_frequent"
- shift_work: "none" / "possible" / "required"
- travel: "none" / "some" / "frequent"
- remote_possible: "none" / "partial" / "full"
- degree_required: "none" / "college" / "bachelor" / "master" / "phd"
- license_required: "none" / "preferred" / "required" / "multiple_required"

[판단 원칙]
1. 같은 버킷 내 상대 비교 (예: 개발자 vs DBA → DBA가 solo_deep 높음)
2. 일반적인 중견기업 기준 (대기업/스타트업 아닌)
3. 확실치 않으면 50 (중간값)
4. 논리적 일관성 유지 (wlb 높으면 work_hours는 regular)

출력 형식: CSV (아래 컬럼 순서)
job_id,job_name,bucket,wlb,growth,stability,income,teamwork,solo_deep,analytical,creative,execution,people_facing,work_hours,shift_work,travel,remote_possible,degree_required,license_required,confidence,notes
`

    writeFileSync(join(outputDir, `ai-prompt-phase2-${bucket.id.toLowerCase()}.txt`), prompt.trim(), 'utf-8')
  }

  console.log('✅ AI 프롬프트: ai-prompt-phase2-{bucket}.txt (14개)')
}

// ============================================
// 실행
// ============================================

generateCoverageSet()






