/**
 * 문제 쿼리 21개 타겟 테스트 + 기존 12개 회귀 테스트
 */
const BASE_URL = 'https://careerwiki.org'

const QUERIES = [
  // === 이전에 확인된 21개 문제 쿼리 ===
  '기자', '파일럿', 'N잡러', '디지털노마드',
  'AI 관련 직업', '이직 준비', '자기소개서 쓰는 법', '연봉 협상',
  '판검사', '꿈이 없는데',
  'HR 담당자', '사무직', '서비스직', '전문직', '기술직', '현장직',
  '멋있는 직업', '쉬운 직업', '고고학자',
  '수학 잘하는 사람 직업', '영어 잘하는 사람 직업',
  // === 기존 12개 회귀 테스트 ===
  '데이터 분석가', '웹 개발자', '철밥통', '코드몽키',
  '연봉 높은 직업', '워라밸 좋은 직업', '컴퓨터공학', '심리학',
  '뭐 할지 모르겠어요', '면접 준비', '포트폴리오 만들기',
  '안정적이면서 연봉 높은 IT 직업',
  // === 추가 의심 쿼리 ===
  '공무원', '공시생', '프리랜서', '유튜버', '선생님',
  '4차산업혁명', '체육 관련 직업', '동물 관련 직업', '노인 관련 직업',
  '비전공자 취업', '고졸 취업', '개발자',
  '자격증 필요 없는 고소득 직업', '체력 안 쓰는 고소득 직업',
  '인간관계 스트레스 없는 직업',
  '취업 방법', '커리어 전환', '직업 추천', '적성에 맞는 직업',
]

const uniqueQueries = [...new Set(QUERIES)]

async function testQuery(query) {
  const url = `${BASE_URL}/search?q=${encodeURIComponent(query)}`
  try {
    const res = await fetch(url, { headers: { 'User-Agent': 'CareerWiki-RAG-Test/1.0' } })
    if (!res.ok) return { query, jobs: [], error: `HTTP ${res.status}` }
    const html = await res.text()
    const jobPattern = /<h2 class="text-lg sm:text-xl font-bold[^"]*">\s*([^<]+?)\s*<\/h2>/g
    const jobs = []
    let match
    while ((match = jobPattern.exec(html)) !== null) jobs.push(match[1].trim())
    return { query, jobs: jobs.slice(0, 5) }
  } catch (e) {
    return { query, jobs: [], error: e.message }
  }
}

async function main() {
  console.log(`=== 타겟 검증 테스트 (${uniqueQueries.length}개) ===\n`)
  const results = []
  for (let i = 0; i < uniqueQueries.length; i += 5) {
    const batch = uniqueQueries.slice(i, i + 5)
    const br = await Promise.all(batch.map(q => testQuery(q)))
    results.push(...br)
    process.stderr.write(`\r  ${Math.min(i+5, uniqueQueries.length)}/${uniqueQueries.length}`)
    if (i + 5 < uniqueQueries.length) await new Promise(r => setTimeout(r, 500))
  }
  process.stderr.write('\n\n')

  for (const r of results) {
    const jobList = r.jobs.length > 0
      ? r.jobs.map((j, i) => `${i+1}.${j}`).join('  ')
      : '(결과 없음)'
    console.log(`"${r.query}" → ${jobList}`)
  }
}
main().catch(console.error)
