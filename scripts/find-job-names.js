/**
 * 특정 키워드로 DB 직업명 검색 (확인용)
 * careerwiki.org /search 에서 직업명 확인
 */
const BASE_URL = 'https://careerwiki.org'

// 직업명 검색 키워드 목록
const SEARCHES = [
  // 파일럿/항공 관련
  '항공기조종사', '조종사', '기장', '부기장',
  // 기자 관련
  '신문기자', '방송기자', '취재기자', '영상기자',
  // 사무직 관련
  '총무사무원', '기획사무원', '행정사무원',
  // 서비스직 관련
  '판매원', '고객상담원', '안내원',
  // 전문직 관련
  '변호사', '건축가', '전문의사',
  // 기술직 관련
  '기계기술자', '전기기술자',
  // 현장직 관련
  '건설기술자', '배관공', '용접기술자',
  // 교육 관련
  '체육교사', '스포츠지도사', '운동처방사',
  // 동물 관련
  '동물사육사', '동물조련사', '동물간호',
  // 노인 관련
  '요양보호사', '노인복지', '노인전문',
  // 고고학
  '고고학', '매장문화재', '역사학연구원',
  // HR 관련
  '인사사무원', '인적자원', '채용',
  // 통역/번역
  '통역가', '번역가', '외교관',
  // 수학 관련
  '보험계리사', '통계연구원', '금융공학',
  // 영어 관련
  '외국어교사', '외국어강사', '해외마케터',
  // 관련 직업 패턴
  '프리랜서마켓', '진로상담',
  // 개발자 관련
  '앱개발자', '웹개발자', '게임개발자',
  // 멋있는 직업
  '프로게이머', '영화감독',
  // N잡러, 디지털노마드
  '1인기업', '크리에이터', '디지털',
  // 경비원, 배관공
  '경비원', '설비기술자',
  // 커리어/취업 관련
  '직업상담사', '진로상담사',
]

async function searchJobName(keyword) {
  const url = `${BASE_URL}/search?q=${encodeURIComponent(keyword)}`
  try {
    const res = await fetch(url, { headers: { 'User-Agent': 'CareerWiki-Test/1.0' } })
    if (!res.ok) return { keyword, found: [] }
    const html = await res.text()
    const pattern = /<h2 class="text-lg sm:text-xl font-bold[^"]*">\s*([^<]+?)\s*<\/h2>/g
    const found = []
    let m
    while ((m = pattern.exec(html)) !== null) found.push(m[1].trim())
    return { keyword, found: found.slice(0, 3) }
  } catch (e) {
    return { keyword, found: [], error: e.message }
  }
}

async function main() {
  const results = []
  for (let i = 0; i < SEARCHES.length; i += 5) {
    const batch = SEARCHES.slice(i, i + 5)
    const br = await Promise.all(batch.map(k => searchJobName(k)))
    results.push(...br)
    process.stderr.write(`\r  ${Math.min(i+5, SEARCHES.length)}/${SEARCHES.length}`)
    await new Promise(r => setTimeout(r, 400))
  }
  process.stderr.write('\n')
  for (const r of results) {
    console.log(`"${r.keyword}" → ${r.found.join(' | ') || '(없음)'}`)
  }
}
main().catch(console.error)
