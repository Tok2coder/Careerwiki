import { searchMajors } from './src/api/careernetAPI'

async function findMissing() {
  // 더 구체적인 키워드로 검색
  const searches = [
    '전기전자',
    '컴퓨터',
    '디자인'
  ]
  
  for (const kw of searches) {
    console.log(`\n== ${kw} 검색 결과 ==`)
    const results = await searchMajors({ keyword: kw, perPage: 10 })
    results.forEach((r, idx) => {
      console.log(`${idx + 1}. ${r.major} (${r.majorSeq})`)
    })
    await new Promise(r => setTimeout(r, 300))
  }
}

findMissing()
