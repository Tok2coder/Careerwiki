/**
 * 실제 DB 데이터로 Coverage Set 생성
 */

import { readFileSync, writeFileSync } from 'fs'
import { join } from 'path'

// ============================================
// 버킷 정의 (동일)
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
    keywords: ['개발', '프로그래머', '엔지니어', '데이터', 'IT', '소프트웨어', '시스템', '네트워크', '보안', '클라우드', 'AI', '인공지능', '빅데이터', 'DBA', '웹', '프론트엔드', '백엔드', '풀스택', '모바일', '게임'],
    classifications: ['정보통신', '전산', '컴퓨터', 'IT'],
  },
  {
    id: 'MANUFACTURING',
    name: '제조/생산',
    targetCount: 35,
    keywords: ['생산', '제조', '공장', '품질', '기계', '전자', '자동차', '반도체', '설비', '조립', '용접', '가공', '제관', '도금', '도장', '포장'],
    classifications: ['제조', '생산', '기계', '자동차', '반도체'],
  },
  {
    id: 'CONSTRUCTION',
    name: '건설/건축',
    targetCount: 30,
    keywords: ['건축', '건설', '토목', '설계', '시공', '인테리어', '조경', '측량', '감리', '현장', '건축가', '토목기사', '건축기사'],
    classifications: ['건설', '건축', '토목', '시설'],
  },
  {
    id: 'SALES_MARKETING',
    name: '영업/마케팅',
    targetCount: 40,
    keywords: ['영업', '마케팅', '광고', '판매', '세일즈', 'CRM', '브랜드', '홍보', 'PR', '기획', '마케터', '광고기획자', '영업사원', '세일즈매니저'],
    classifications: ['영업', '판매', '마케팅', '광고'],
  },
  {
    id: 'FINANCE_ACCOUNTING',
    name: '금융/회계',
    targetCount: 35,
    keywords: ['회계', '세무', '금융', '은행', '보험', '투자', '펀드', '증권', '재무', '세리사', '회계사', '펀드매니저', '증권사', '은행원'],
    classifications: ['금융', '회계', '경제', '보험'],
  },
  {
    id: 'EDUCATION',
    name: '교육/연구',
    targetCount: 40,
    keywords: ['교사', '강사', '교수', '연구', '학원', '교육', '튜터', '훈련', '연구원', '강의', '교육컨설턴트', '학습', '교재'],
    classifications: ['교육', '연구', '학술', '학교'],
  },
  {
    id: 'MEDICAL_HEALTH',
    name: '의료/보건',
    targetCount: 45,
    keywords: ['의사', '간호', '약사', '병원', '의료', '보건', '치료', '검사', '임상', '재활', '한의', '수의사', '물리치료', '작업치료'],
    classifications: ['의료', '보건', '간호', '병원', '진료'],
  },
  {
    id: 'LAW_PUBLIC',
    name: '법률/공공',
    targetCount: 30,
    keywords: ['변호사', '법무', '법원', '공무원', '경찰', '소방', '검찰', '행정', '세관', '외교', '판사', '검사', '법무사', '노무사'],
    classifications: ['법률', '공공', '행정', '법원', '검찰'],
  },
  {
    id: 'SERVICE_HOSPITALITY',
    name: '서비스/외식',
    targetCount: 35,
    keywords: ['호텔', '요리', '조리', '바리스타', '승무원', '미용', '서비스', '레스토랑', '카페', '호텔리어', '셰프', '웨이터', '메이드'],
    classifications: ['서비스', '음식', '숙박', '관광', '미용'],
  },
  {
    id: 'ARTS_DESIGN',
    name: '예술/디자인',
    targetCount: 35,
    keywords: ['디자인', '그래픽', 'UX', 'UI', '사진', '음악', '미술', '예술', '작가', '편집', '연출', '일러스트', '패션', '영상'],
    classifications: ['예술', '디자인', '문화', '방송', '출판'],
  },
  {
    id: 'MEDIA_CONTENTS',
    name: '미디어/콘텐츠',
    targetCount: 30,
    keywords: ['PD', '기자', '작가', '방송', '영상', '콘텐츠', '유튜브', '게임', '출판', '언론', '스트리머', '크리에이터', '편집자'],
    classifications: ['방송', '미디어', '출판', '언론', '게임'],
  },
  {
    id: 'LOGISTICS_TRANSPORT',
    name: '물류/운송',
    targetCount: 25,
    keywords: ['물류', '운송', '배송', '택배', '운전', '조종사', '선장', '항공', '철도', '해운', '포워더', '창고', '배차'],
    classifications: ['물류', '운송', '항공', '철도', '해운'],
  },
  {
    id: 'AGRICULTURE_ENVIRONMENT',
    name: '농업/환경',
    targetCount: 25,
    keywords: ['농업', '환경', '조경', '수의사', '축산', '원예', '산림', '어업', '생태', '환경컨설턴트', '농업기술자', '임업'],
    classifications: ['농업', '환경', '생명', '축산', '어업'],
  },
  {
    id: 'MANAGEMENT_HR',
    name: '경영/인사/총무',
    targetCount: 45,
    keywords: ['CEO', '경영', '인사', '총무', '기획', '전략', '컨설팅', '프로젝트', 'PM', '비서', '매니저', '임원', '관리자'],
    classifications: ['경영', '인사', '총무', '기획', '경영컨설팅'],
  },
]

// ============================================
// 인터페이스
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
    // 키워드 매칭 (우선순위 높음)
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
// 메인 로직
// ============================================

function main() {
  console.log('🚀 실제 DB 데이터로 Coverage Set 생성\n')

  // 텍스트 파일 읽기 (wrangler 출력)
  const txtPath = join(process.cwd(), 'scripts', 'tagging', 'output', 'jobs_all.txt')
  const txtContent = readFileSync(txtPath, 'utf-8')

  // JSON 부분만 추출 ([로 시작하는 줄부터)
  const lines = txtContent.split('\n')
  const jsonStartIndex = lines.findIndex(line => line.trim() === '[')

  if (jsonStartIndex === -1) {
    console.error('❌ JSON 데이터를 찾을 수 없습니다')
    console.log('첫 10줄:')
    lines.slice(0, 10).forEach((line, i) => console.log(`${i + 1}: "${line}"`))
    return
  }

  const jsonContent = lines.slice(jsonStartIndex).join('\n')

  // JSON 파싱
  const data = JSON.parse(jsonContent)
  const results = data[0]?.results || []

  const jobs: JobRecord[] = results.map((row: any) => ({
    job_id: row.job_id,
    job_name: row.job_name || 'Unknown',
    source_system: row.source_system,
    large_category: row.large_category || '',
    medium_category: row.medium_category || '',
    small_category: row.small_category || '',
  }))

  console.log(`📊 ${jobs.length}개 직업 데이터 로드됨`)

  // 버킷별 분류
  const bucketedJobs: Record<string, JobRecord[]> = {}
  for (const job of jobs) {
    const bucket = classifyJob(job)
    if (!bucketedJobs[bucket]) {
      bucketedJobs[bucket] = []
    }
    bucketedJobs[bucket].push(job)
  }

  // 각 버킷에서 대표 직업 선정 (중복 제거 + 우선순위 정렬)
  const selectedJobs: Record<string, JobRecord[]> = {}

  for (const bucket of BUCKETS) {
    let availableJobs = bucketedJobs[bucket.id] || []

    // 중복 제거 (job_name 기준)
    const uniqueJobs = availableJobs.filter((job, index, arr) =>
      arr.findIndex(j => j.job_name === job.job_name) === index
    )

    // 우선순위 정렬: CAREERNET 우선, 이름 길이 짧은 순, 알파벳 순
    uniqueJobs.sort((a, b) => {
      // CAREERNET 우선
      if (a.source_system === 'CAREERNET' && b.source_system !== 'CAREERNET') return -1
      if (b.source_system === 'CAREERNET' && a.source_system !== 'CAREERNET') return 1

      // 이름 길이 짧은 순 (더 일반적인 이름 우선)
      if (a.job_name.length !== b.job_name.length) {
        return a.job_name.length - b.job_name.length
      }

      // 알파벳 순
      return a.job_name.localeCompare(b.job_name)
    })

    // 목표 개수만큼 선택 (부족하면 있는 만큼)
    const selected = uniqueJobs.slice(0, Math.min(bucket.targetCount, uniqueJobs.length))
    selectedJobs[bucket.id] = selected
  }

  // 결과 출력
  console.log('\n📊 Coverage Set 선정 결과:\n')

  let totalSelected = 0
  for (const bucket of BUCKETS) {
    const selected = selectedJobs[bucket.id] || []
    const status = selected.length >= bucket.targetCount ? '✅' : selected.length > 0 ? '⚠️' : '❌'
    console.log(`${status} ${bucket.name}: ${selected.length}/${bucket.targetCount}개`)

    if (selected.length > 0) {
      const examples = selected.slice(0, 3).map(j => j.job_name).join(', ')
      console.log(`   예시: ${examples}${selected.length > 3 ? '...' : ''}`)
    }

    totalSelected += selected.length
  }

  const totalTarget = BUCKETS.reduce((sum, b) => sum + b.targetCount, 0)
  console.log(`\n총계: ${totalSelected}/${totalTarget}개`)

  // CSV 파일 생성
  generateCSVFiles(selectedJobs)

  // AI 프롬프트 생성
  generateAIPrompts(selectedJobs)

  console.log('\n🎯 생성된 파일:')
  console.log('- scripts/tagging/output/coverage-set-final.csv (전체)')
  console.log('- scripts/tagging/output/ai-prompt-phase1-final.txt')
  console.log('- scripts/tagging/output/ai-prompt-phase2-{bucket}.txt (14개)')
}

// ============================================
// CSV 파일 생성
// ============================================

function generateCSVFiles(selectedJobs: Record<string, JobRecord[]>) {
  const outputDir = join(process.cwd(), 'scripts', 'tagging', 'output')

  // 헤더
  const header = 'job_id,job_name,bucket,source_system,large_category,medium_category,small_category\n'

  // 전체 파일
  let allCsv = header
  for (const bucket of BUCKETS) {
    const jobs = selectedJobs[bucket.id] || []
    for (const job of jobs) {
      const row = [
        job.job_id,
        `"${job.job_name.replace(/"/g, '""')}"`,
        bucket.id,
        job.source_system,
        `"${job.large_category.replace(/"/g, '""')}"`,
        `"${job.medium_category.replace(/"/g, '""')}"`,
        `"${job.small_category.replace(/"/g, '""')}"`,
      ].join(',')
      allCsv += row + '\n'
    }
  }

  writeFileSync(join(outputDir, 'coverage-set-final.csv'), allCsv, 'utf-8')
  console.log('✅ CSV 파일 생성됨: coverage-set-final.csv')
}

// ============================================
// AI 프롬프트 생성
// ============================================

function generateAIPrompts(selectedJobs: Record<string, JobRecord[]>) {
  const outputDir = join(process.cwd(), 'scripts', 'tagging', 'output')

  // Phase 1: 최종 Coverage Set 확인
  const totalSelected = Object.values(selectedJobs).reduce((sum, jobs) => sum + jobs.length, 0)

  const phase1Prompt = `
[태깅 Phase 1: Coverage Set 최종 확인]

현재 선정된 Coverage Set (${totalSelected}개):

${BUCKETS.map(b => {
  const jobs = selectedJobs[b.id] || []
  const status = jobs.length >= b.targetCount ? '✅ 달성' : jobs.length > 0 ? '⚠️ 부족' : '❌ 없음'
  return `- ${b.name}: ${jobs.length}/${b.targetCount}개 ${status}`
}).join('\n')}

전체 직업 목록 (첨부된 CSV 참고):
- 총 ${totalSelected}개 직업
- 14개 버킷으로 분류됨

평가 및 조정:
1. 각 버킷의 대표성이 충분한지 확인
2. 중요한 직업군이 누락되었는지 점검
3. 목표 개수에 미달된 버킷은 어떻게 보완할지 제안

출력: 조정된 최종 Coverage Set (job_id, job_name, bucket CSV)
`

  writeFileSync(join(outputDir, 'ai-prompt-phase1-final.txt'), phase1Prompt.trim(), 'utf-8')

  // Phase 2: 각 버킷별 태깅 프롬프트
  for (const bucket of BUCKETS) {
    const jobs = selectedJobs[bucket.id] || []

    if (jobs.length === 0) continue // 빈 버킷은 스킵

    const jobListText = jobs.map((job, idx) =>
      `${idx + 1}. ${job.job_name} (${job.job_id})`
    ).join('\n')

    const prompt = `
[태깅 Phase 2-${bucket.id}: ${bucket.name} 버킷 태깅]

대상: ${bucket.name} 버킷 ${jobs.length}개 직업

직업 목록:
${jobListText}

[태깅 스키마 상세 설명]

수치형 속성 (0~100, 같은 버킷 내 상대적 비교):
- wlb: 워라밸 (정시퇴근=80+, 야근빈번=40-, 교대근무=20-)
  예: 개발자 wlb=70, DBA wlb=75, 게임개발자 wlb=60
- growth: 성장가능성 (신기술/학습기회 많음=80+, 정체=30-)
  예: AI엔지니어 growth=90, 사무직 growth=40
- stability: 고용안정성 (공기업/대기업=80+, 스타트업=40-)
  예: 공무원 stability=95, 프리랜서 stability=30
- income: 연봉수준 (1억+=80, 6천만=60, 4천만=40, 2.5천만=20)
  예: CEO income=95, 알바 income=10
- teamwork: 협업강도 (팀프로젝트 필수=80+, 독립작업=20-)
  예: 마케터 teamwork=75, 연구원 teamwork=40
- solo_deep: 깊은집중 (코딩/분석/연구=80+, 고객응대=20-)
  예: 데이터과학자 solo_deep=85, 영업사원 solo_deep=25
- analytical: 분석력요구 (데이터/논리분석=80+, 단순실행=20-)
  예: 회계사 analytical=90, 요리사 analytical=30
- creative: 창의력요구 (새로운아이디어/디자인=80+, 매뉴얼따름=20-)
  예: 광고기획자 creative=85, 택배기사 creative=20
- execution: 실행력요구 (프로세스운영/관리=80+, 기획전문=20-)
  예: 프로젝트매니저 execution=80, 연구원 execution=35
- people_facing: 대면업무 (고객/환자/학생 응대=80+, 백오피스=20-)
  예: 영업사원 people_facing=90, 프로그래머 people_facing=30

범주형 속성 (업계 표준 기준):
- work_hours: "regular"(주40시간내), "overtime_some"(야근가끔), "overtime_frequent"(야근잦음)
- shift_work: "none"(고정), "possible"(가능성), "required"(필수)
- travel: "none"(없음), "some"(가끔), "frequent"(자주)
- remote_possible: "none"(불가), "partial"(부분), "full"(완전)
- degree_required: "none"(무관), "college"(전문대), "bachelor"(4년제), "master"(석사), "phd"(박사)
- license_required: "none"(없음), "preferred"(우대), "required"(필수), "multiple_required"(다수필수)

[태깅 원칙]
1. 버킷 내 상대 비교: 가장 좋은 직업=90, 가장 나쁜 직업=20, 중간=50
2. 일반 기업 기준: 대기업도 스타트업도 아닌 중견기업
3. 논리적 일관성: wlb↑이면 work_hours="regular" 가능성 높음
4. 보수적 판단: 불확실하면 중간값, license는 최소화

출력 형식: CSV (정확히 아래 순서)
job_id,job_name,bucket,wlb,growth,stability,income,teamwork,solo_deep,analytical,creative,execution,people_facing,work_hours,shift_work,travel,remote_possible,degree_required,license_required,confidence,notes
`

    writeFileSync(join(outputDir, `ai-prompt-phase2-${bucket.id.toLowerCase()}-final.txt`), prompt.trim(), 'utf-8')
  }

  console.log('✅ AI 프롬프트 생성됨')
}

main()

