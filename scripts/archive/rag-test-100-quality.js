/**
 * RAG 검색 품질 평가 - 결과 상세 출력
 * 각 쿼리에 대해 5개 직업 결과를 상세 출력하여 수동 평가 용이하게 함
 */

const BASE_URL = 'https://careerwiki.org'

// 문제 의심 쿼리 + 기존 OK 쿼리 전부 테스트
const QUERIES = [
  // === 이전 테스트에서 확인된 문제 쿼리 ===
  '기자', '파일럿', 'N잡러', '디지털노마드',
  'AI 관련 직업', '이직 준비', '자기소개서 쓰는 법', '연봉 협상',
  '판검사', '꿈이 없는데',
  // === 결과가 의심스러운 쿼리 ===
  'HR 담당자', '비전공자 취업', '고졸 취업',
  '체력 안 쓰는 고소득 직업', '인간관계 스트레스 없는 직업',
  '자격증 필요 없는 고소득 직업', '요리사', '선생님',
  '워라밸 좋고 연봉 괜찮은 사무직', '여성 유망 직업',
  // === 추가 엣지케이스 ===
  '개발자', '디자이너', '엔지니어', '분석가', '상담사',
  '교수', '작가', '감독', 'PD', '아나운서',
  '은행원', '공인중개사', '관세사', '노무사', '법무사',
  '항공승무원', '호텔리어', '바리스타', '플로리스트', '소믈리에',
  '드론조종사', '게임개발자', '로봇공학자', '천문학자', '고고학자',
  '수화통역사', '영양사', '물리치료사', '작업치료사', '언어치료사',
  '치위생사', '방사선사', '임상병리사', '응급구조사', '산업안전기사',
  // 추가 스타일/조건 쿼리
  '사무직', '현장직', '기술직', '전문직', '서비스직',
  '돈 많이 버는 직업', '쉬운 직업', '멋있는 직업',
  '어린이를 위한 직업', '노인 관련 직업', '동물 관련 직업',
  '음악 관련 직업', '미술 관련 직업', '체육 관련 직업',
  '수학 잘하는 사람 직업', '영어 잘하는 사람 직업',
  '코딩', '인공지능', '빅데이터', '로봇',
  '의료기기', '제약', '화장품', '식품',
  '건축', '인테리어', '조경', '토목',
  '항공', '해운', '철도', '자동차',
  '보험', '증권', '부동산', '세무',
  // HowTo 성격
  '취업 방법', '커리어 전환', '자격증 추천',
]

const uniqueQueries = [...new Set(QUERIES)]

async function testQuery(query) {
  const url = `${BASE_URL}/search?q=${encodeURIComponent(query)}`
  try {
    const res = await fetch(url, {
      headers: { 'User-Agent': 'CareerWiki-RAG-Test/1.0' }
    })
    if (!res.ok) return { query, jobs: [], error: `HTTP ${res.status}` }
    const html = await res.text()

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
  console.log(`=== RAG 검색 품질 상세 테스트 (${uniqueQueries.length}개) ===\n`)

  const results = []
  const batchSize = 5

  for (let i = 0; i < uniqueQueries.length; i += batchSize) {
    const batch = uniqueQueries.slice(i, i + batchSize)
    const batchResults = await Promise.all(batch.map(q => testQuery(q)))
    results.push(...batchResults)
    const done = Math.min(i + batchSize, uniqueQueries.length)
    process.stderr.write(`\r  진행: ${done}/${uniqueQueries.length}`)
    if (i + batchSize < uniqueQueries.length) {
      await new Promise(r => setTimeout(r, 500))
    }
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
