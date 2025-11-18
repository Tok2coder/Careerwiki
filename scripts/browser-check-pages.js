/**
 * 브라우저 콘솔에서 실행하는 페이지 체크 스크립트
 * 
 * 사용법:
 * 1. 직업 또는 전공 목록 페이지를 엽니다
 *    - 직업: http://localhost:3000/job?perPage=50
 *    - 전공: http://localhost:3000/major?perPage=50
 * 2. F12를 눌러 개발자 도구를 엽니다
 * 3. Console 탭에서 이 스크립트를 붙여넣고 실행합니다
 */

(async function checkAllPagesFromList() {
  console.log('🔍 페이지 체크를 시작합니다...\n')
  
  // 현재 페이지의 모든 링크 가져오기
  const links = Array.from(document.querySelectorAll('a[href*="/job/"], a[href*="/major/"]'))
    .map(a => a.href)
    .filter((href, index, self) => self.indexOf(href) === index) // 중복 제거
  
  // 직업/전공 구분
  const jobLinks = links.filter(url => url.includes('/job/'))
  const majorLinks = links.filter(url => url.includes('/major/'))
  
  console.log(`📊 총 ${links.length}개 링크 발견`)
  console.log(`   직업: ${jobLinks.length}개`)
  console.log(`   전공: ${majorLinks.length}개\n`)
  
  const results = {
    success: [],
    empty: [],
    error: []
  }
  
  let checked = 0
  
  for (const url of links) {
    checked++
    const path = new URL(url).pathname
    
    try {
      const response = await fetch(url)
      const html = await response.text()
      
      // 데이터가 없는 페이지 체크 - 더 정확한 감지
      // 1. 제목이 "job:" 또는 "major:"로 시작하면 빈 페이지
      const titleMatch = html.match(/<title>(.*?)<\/title>/)
      const title = titleMatch ? titleMatch[1] : ''
      const hasEmptyTitle = title.includes('job:') || title.includes('major:')
      
      // 2. 주요 콘텐츠가 있는지 확인 (glass-card 또는 wiki-card)
      const hasMainContent = html.includes('glass-card') || html.includes('wiki-card')
      
      // 3. HTML 크기가 너무 작으면 빈 페이지 (정상 페이지는 100KB 이상)
      const hasSufficientContent = html.length > 50000
      
      const isEmpty = hasEmptyTitle || !hasMainContent || !hasSufficientContent
      
      if (response.ok && !isEmpty) {
        results.success.push(path)
        console.log(`✅ [${checked}/${links.length}] ${path}`)
      } else if (response.ok && isEmpty) {
        results.empty.push(path)
        console.log(`⚠️  [${checked}/${links.length}] ${path} (빈 페이지)`)
      } else {
        results.error.push(path)
        console.log(`❌ [${checked}/${links.length}] ${path} (에러 ${response.status})`)
      }
    } catch (error) {
      results.error.push(path)
      console.log(`❌ [${checked}/${links.length}] ${path} (네트워크 에러)`)
    }
    
    // 진행률 표시
    if (checked % 10 === 0) {
      console.log(`\n진행률: ${Math.round(checked / links.length * 100)}%\n`)
    }
    
    // 서버 부하 방지를 위한 딜레이
    await new Promise(resolve => setTimeout(resolve, 50))
  }
  
  // 결과 요약
  console.log('\n' + '='.repeat(60))
  console.log('📈 체크 결과 요약')
  console.log('='.repeat(60))
  console.log(`✅ 정상: ${results.success.length}개 (${Math.round(results.success.length / links.length * 100)}%)`)
  console.log(`⚠️  빈 페이지: ${results.empty.length}개 (${Math.round(results.empty.length / links.length * 100)}%)`)
  console.log(`❌ 에러: ${results.error.length}개 (${Math.round(results.error.length / links.length * 100)}%)`)
  console.log('='.repeat(60))
  
  // 직업/전공 별 통계
  const jobSuccess = results.success.filter(p => p.includes('/job/')).length
  const jobEmpty = results.empty.filter(p => p.includes('/job/')).length
  const jobError = results.error.filter(p => p.includes('/job/')).length
  const majorSuccess = results.success.filter(p => p.includes('/major/')).length
  const majorEmpty = results.empty.filter(p => p.includes('/major/')).length
  const majorError = results.error.filter(p => p.includes('/major/')).length
  
  if (jobLinks.length > 0) {
    console.log(`\n📊 직업위키 (${jobLinks.length}개):`)
    console.log(`   ✅ 정상: ${jobSuccess}개, ⚠️  빈: ${jobEmpty}개, ❌ 에러: ${jobError}개`)
  }
  
  if (majorLinks.length > 0) {
    console.log(`\n📊 전공위키 (${majorLinks.length}개):`)
    console.log(`   ✅ 정상: ${majorSuccess}개, ⚠️  빈: ${majorEmpty}개, ❌ 에러: ${majorError}개`)
  }
  
  // 문제 페이지 출력
  if (results.empty.length > 0) {
    console.log('\n⚠️  빈 페이지 목록 (처음 10개):')
    results.empty.slice(0, 10).forEach(path => console.log(`   ${path}`))
    if (results.empty.length > 10) {
      console.log(`   ... 외 ${results.empty.length - 10}개`)
    }
  }
  
  if (results.error.length > 0) {
    console.log('\n❌ 에러 페이지 목록:')
    results.error.forEach(path => console.log(`   ${path}`))
  }
  
  if (results.empty.length === 0 && results.error.length === 0) {
    console.log('\n🎉 모든 페이지가 정상적으로 작동합니다!')
  }
  
  // 💡 팁 출력
  console.log(`\n💡 팁:`)
  console.log(`   - 빈 페이지가 많다면 브라우저 강제 새로고침(Ctrl+Shift+R)을 시도하세요`)
  console.log(`   - 전공 페이지 체크: http://localhost:3000/major?perPage=50`)
  console.log(`   - 직업 페이지 체크: http://localhost:3000/job?perPage=50`)
  
  // 결과 객체 반환 (콘솔에서 확인 가능)
  return results
})()

