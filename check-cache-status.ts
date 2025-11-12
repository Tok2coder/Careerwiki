/**
 * 간호학과 페이지의 캐시 상태 확인
 */

const url = 'http://localhost:3000/major/간호학과'

console.log('🔍 간호학과 페이지 캐시 상태 확인\n')
console.log(`URL: ${url}\n`)

try {
  const response = await fetch(url)
  
  console.log('📊 응답 헤더:')
  console.log(`- Status: ${response.status}`)
  console.log(`- X-Template-Version: ${response.headers.get('X-Template-Version')}`)
  console.log(`- X-Cache-Status: ${response.headers.get('X-Cache-Status')}`)
  console.log(`- Cache-Control: ${response.headers.get('Cache-Control')}`)
  
  const html = await response.text()
  
  console.log('\n📝 HTML 분석:')
  console.log(`- HTML 길이: ${html.length} chars`)
  console.log(`- "주요 교과목" 포함: ${html.includes('주요 교과목') ? '✅ YES' : '❌ NO'}`)
  console.log(`- "기초 과목" 포함: ${html.includes('기초 과목') ? '✅ YES' : '❌ NO'}`)
  console.log(`- "심화 과목" 포함: ${html.includes('심화 과목') ? '✅ YES' : '❌ NO'}`)
  console.log(`- "대학 주요 교과목 상세" 포함: ${html.includes('대학 주요 교과목 상세') ? '✅ YES' : '❌ NO'}`)
  console.log(`- "고교 추천 교과목" 포함: ${html.includes('고교 추천 교과목') ? '✅ YES' : '❌ NO'}`)
  console.log(`- "진로 탐색 활동" 포함: ${html.includes('진로 탐색 활동') ? '✅ YES' : '❌ NO'}`)
  
  // 태그 개수 확인
  const tagMatches = html.match(/fa-graduation-cap/g)
  console.log(`- 히어로 태그 개수: ${tagMatches ? tagMatches.length - 1 : 0}개 (아이콘 기준)`)
  
} catch (error) {
  console.error('❌ 오류:', error)
}

