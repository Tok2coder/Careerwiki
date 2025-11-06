import { searchMajors } from './src/api/careernetAPI'

async function test() {
  const results = await searchMajors({ keyword: '전기전자공학', perPage: 3 })
  console.log('검색 결과:')
  results.forEach(r => {
    console.log(`  ${r.major}: ${r.majorSeq}`)
  })
}

test()
