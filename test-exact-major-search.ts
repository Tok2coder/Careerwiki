import { searchMajors } from './src/api/careernetAPI'

async function findExact() {
  // 정확한 학과명으로 검색
  const searches = [
    { keyword: '전기', expected: '전기전자공학과' },
    { keyword: '컴퓨터', expected: '컴퓨터공학과' },
    { keyword: '기계', expected: '기계공학과' },
    { keyword: '경영', expected: '경영학과' },
    { keyword: '심리', expected: '심리학과' },
    { keyword: '간호', expected: '간호학과' },
    { keyword: '디자인', expected: '디자인학과' },
    { keyword: '음악', expected: '음악학과' },
    { keyword: '국어', expected: '국어국문학과' },
    { keyword: '영어', expected: '영어영문학과' }
  ]
  
  for (const s of searches) {
    const results = await searchMajors({ keyword: s.keyword, perPage: 20 })
    const match = results.find(r => r.major === s.expected)
    if (match) {
      console.log(`{ id: '${match.majorSeq}', name: '${match.major}' },`)
    } else {
      console.log(`// ${s.expected}: 검색 결과 없음 (첫 결과: ${results[0]?.major || '없음'})`)
    }
    await new Promise(r => setTimeout(r, 300))
  }
}

findExact()
