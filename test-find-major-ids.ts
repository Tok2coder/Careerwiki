import { searchMajors } from './src/api/careernetAPI'

async function findIds() {
  const keywords = [
    '전기전자공학과',
    '컴퓨터공학과',
    '기계공학과',
    '경영학과',
    '심리학과',
    '간호학과',
    '디자인학과',
    '음악학과',
    '국어국문학과',
    '영어영문학과'
  ]
  
  for (const kw of keywords) {
    const results = await searchMajors({ keyword: kw, perPage: 1 })
    if (results.length > 0) {
      console.log(`{ id: '${results[0].majorSeq}', name: '${results[0].major}', category: '???'},`)
    } else {
      console.log(`// ${kw}: 검색 결과 없음`)
    }
    await new Promise(r => setTimeout(r, 300))
  }
}

findIds()
