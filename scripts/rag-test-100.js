/**
 * RAG 검색 100개 쿼리 대규모 테스트
 * 사용법: node scripts/rag-test-100.js
 *
 * 각 쿼리에 대해 /search?q= 페이지를 호출하고
 * 직업 카드에서 직업명을 파싱하여 출력합니다.
 */

const BASE_URL = 'https://careerwiki.org'

// 100개 테스트 쿼리 (카테고리별 분류)
const QUERIES = [
  // === 1. 구체적 직업명 (20개) ===
  '간호사', '변호사', '약사', '회계사', '건축가',
  '소방관', '경찰관', '의사', '치과의사', '수의사',
  '요리사', '미용사', '사진작가', '통역사', '기자',
  '파일럿', '외교관', '판사', '세무사', '약사',

  // === 2. 분야/도메인 쿼리 (15개) ===
  'IT', '의료', '금융', '교육', '건설',
  '물류', '마케팅', '디자인', '법률', '농업',
  '환경', '에너지', '문화', '스포츠', '국방',

  // === 3. 전공 관련 (10개) ===
  '경영학', '전자공학', '생명공학', '화학', '물리학',
  '경제학', '사회학', '철학', '수학', '간호학',

  // === 4. 직무/역할 (15개) ===
  '프로그래머', '데이터 분석가', '웹 개발자', 'AI 엔지니어', 'UX 디자이너',
  '프로젝트 매니저', '마케터', '컨설턴트', '연구원', '기획자',
  'HR 담당자', '영업사원', '물류관리자', '품질관리', '시스템 관리자',

  // === 5. 속어/구어체 (15개) ===
  '철밥통', '코드몽키', '공무원', '공시생', '프리랜서',
  '유튜버', '인플루언서', '알바', '백수', '취준생',
  '선생님', '판검사', '기레기', 'N잡러', '디지털노마드',

  // === 6. 조건/스타일 쿼리 (15개) ===
  '연봉 높은 직업', '워라밸 좋은 직업', '안정적인 직업', '재택근무 가능한 직업', '야근 없는 직업',
  '혼자 하는 직업', '창의적인 직업', '해외에서 일하는 직업', '자격증 따기 쉬운 직업', '여성 유망 직업',
  '미래 유망 직업', '문과 취업', '이과 취업', '비전공자 취업', '고졸 취업',

  // === 7. 복합 쿼리 (10개) ===
  '안정적이면서 연봉 높은 IT 직업', '워라밸 좋고 연봉 괜찮은 사무직',
  '창의적이면서 돈 잘 버는 직업', '재택 가능한 개발자 직업',
  '자격증 필요 없는 고소득 직업', '문과 출신 연봉 높은 직업',
  '야근 없고 안정적인 직업', '해외 취업 가능한 IT 직업',
  '체력 안 쓰는 고소득 직업', '인간관계 스트레스 없는 직업',

  // === 8. 트렌드/산업 (10개) ===
  '4차산업혁명', 'AI 관련 직업', '메타버스', '블록체인',
  '전기차', '반도체', '바이오', '핀테크', '클라우드', '사이버보안',

  // === 9. 모호한/탐색 쿼리 (5개) ===
  '뭐 할지 모르겠어요', '적성에 맞는 직업', '꿈이 없는데', '진로 고민', '직업 추천',

  // === 10. 실용 쿼리 (5개) ===
  '면접 준비', '포트폴리오 만들기', '이직 준비', '자기소개서 쓰는 법', '연봉 협상',
]

// 중복 제거
const uniqueQueries = [...new Set(QUERIES)]

async function testQuery(query) {
  const url = `${BASE_URL}/search?q=${encodeURIComponent(query)}`
  try {
    const res = await fetch(url, {
      headers: { 'User-Agent': 'CareerWiki-RAG-Test/1.0' }
    })
    if (!res.ok) return { query, jobs: [], error: `HTTP ${res.status}` }

    const html = await res.text()

    // 직업 카드에서 직업명 추출 (h2 태그)
    // 패턴: <h2 class="text-lg sm:text-xl font-bold text-white ...">직업명</h2>
    const jobPattern = /<h2 class="text-lg sm:text-xl font-bold[^"]*">\s*([^<]+?)\s*<\/h2>/g
    const jobs = []
    let match
    while ((match = jobPattern.exec(html)) !== null) {
      jobs.push(match[1].trim())
    }

    return { query, jobs: jobs.slice(0, 5) }
  } catch (e) {
    return { query, jobs: [], error: e.message }
  }
}

async function main() {
  console.log(`=== RAG 검색 대규모 테스트 (${uniqueQueries.length}개 쿼리) ===\n`)

  const results = []
  const batchSize = 5  // 동시 요청 수

  for (let i = 0; i < uniqueQueries.length; i += batchSize) {
    const batch = uniqueQueries.slice(i, i + batchSize)
    const batchResults = await Promise.all(batch.map(q => testQuery(q)))
    results.push(...batchResults)

    // 진행률 표시
    const done = Math.min(i + batchSize, uniqueQueries.length)
    process.stderr.write(`\r  진행: ${done}/${uniqueQueries.length}`)

    // rate limit 방지
    if (i + batchSize < uniqueQueries.length) {
      await new Promise(r => setTimeout(r, 500))
    }
  }

  process.stderr.write('\n\n')

  // 결과 출력
  let totalScore = 0
  const maxScore = uniqueQueries.length * 15
  const problemQueries = []

  for (const r of results) {
    const jobCount = r.jobs.length
    const score = jobCount * 3  // 각 직업 3점
    totalScore += score

    const statusIcon = score >= 12 ? 'OK' : score >= 9 ? 'WARN' : 'BAD'
    const jobList = r.jobs.length > 0 ? r.jobs.join(', ') : '(결과 없음)'

    console.log(`[${statusIcon}] ${score}/15  "${r.query}" → ${jobList}${r.error ? ` ERROR: ${r.error}` : ''}`)

    if (score < 12) {
      problemQueries.push({ ...r, score })
    }
  }

  console.log(`\n${'='.repeat(60)}`)
  console.log(`총점: ${totalScore}/${maxScore} (${(totalScore / maxScore * 100).toFixed(1)}%)`)
  console.log(`테스트 쿼리: ${uniqueQueries.length}개`)
  console.log(`OK (12+): ${results.filter(r => r.jobs.length >= 4).length}개`)
  console.log(`WARN (9-11): ${results.filter(r => r.jobs.length >= 3 && r.jobs.length < 4).length}개`)
  console.log(`BAD (<9): ${results.filter(r => r.jobs.length < 3).length}개`)

  if (problemQueries.length > 0) {
    console.log(`\n=== 문제 쿼리 (${problemQueries.length}개) ===`)
    for (const p of problemQueries) {
      console.log(`  ${p.score}/15  "${p.query}" → ${p.jobs.length > 0 ? p.jobs.join(', ') : '(없음)'}`)
    }
  }
}

main().catch(console.error)
