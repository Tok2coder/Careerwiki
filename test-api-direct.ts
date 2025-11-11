/**
 * API 직접 테스트 스크립트
 * CareerNet과 Goyong24 API를 직접 호출하여 문제 진단
 */

async function testCareerNetAPI() {
  console.log('\n🔍 CareerNet API 직접 테스트')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  
  // .dev.vars에서 로드된 키 사용
  const apiKey = process.env.CAREER_NET_API_KEY || 'd9e0285190fde074bef30031f17f669e'
  const url = `https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=${apiKey}&svcType=api&svcCode=MAJOR&contentType=xml&gubun=univ_list&thisPage=1&perPage=5`
  
  try {
    console.log(`URL: ${url.substring(0, 100)}...`)
    const response = await fetch(url)
    
    console.log(`Status: ${response.status} ${response.statusText}`)
    console.log(`Content-Type: ${response.headers.get('content-type')}`)
    
    const text = await response.text()
    console.log(`Response Length: ${text.length} bytes`)
    console.log(`Response Preview (first 500 chars):`)
    console.log(text.substring(0, 500))
    
    if (!response.ok) {
      console.error(`❌ API 요청 실패: ${response.status}`)
      return false
    }
    
    if (text.trim().length === 0) {
      console.error('❌ 응답이 비어있습니다.')
      return false
    }
    
    console.log('✅ API 응답 성공!')
    return true
  } catch (error: any) {
    console.error(`❌ 오류 발생: ${error.message}`)
    if (error.stack) {
      console.error(error.stack.split('\n').slice(0, 3).join('\n'))
    }
    return false
  }
}

async function testGoyong24API() {
  console.log('\n🔍 Goyong24 API 직접 테스트')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  
  // .dev.vars에서 로드된 키 사용
  const apiKey = process.env.GOYONG24_MAJOR_API_KEY || '77235a2f-e5f9-4489-8895-5418c70b49bd'
  const baseUrl = 'https://www.work24.go.kr/cm/openApi/call/wk'
  const params = new URLSearchParams({
    authKey: apiKey,
    returnType: 'XML',
    target: 'MAJORCD',
    srchType: 'K',
    keyword: '과'
  })
  const url = `${baseUrl}/callOpenApiSvcInfo213L01?${params.toString()}`
  
  try {
    console.log(`URL: ${url.substring(0, 100)}...`)
    const response = await fetch(url, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        'Accept': 'application/xml,text/xml,*/*;q=0.9',
        'Referer': 'https://www.work24.go.kr/'
      }
    })
    
    console.log(`Status: ${response.status} ${response.statusText}`)
    console.log(`Content-Type: ${response.headers.get('content-type')}`)
    
    const text = await response.text()
    console.log(`Response Length: ${text.length} bytes`)
    console.log(`Response Preview (first 500 chars):`)
    console.log(text.substring(0, 500))
    
    if (!response.ok) {
      console.error(`❌ API 요청 실패: ${response.status}`)
      return false
    }
    
    if (text.trim().length === 0) {
      console.error('❌ 응답이 비어있습니다.')
      return false
    }
    
    console.log('✅ API 응답 성공!')
    return true
  } catch (error: any) {
    console.error(`❌ 오류 발생: ${error.message}`)
    if (error.stack) {
      console.error(error.stack.split('\n').slice(0, 3).join('\n'))
    }
    return false
  }
}

async function main() {
  console.log('🚀 API 직접 테스트 시작')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  
  const results = {
    careernet: await testCareerNetAPI(),
    goyong24: await testGoyong24API()
  }
  
  console.log('\n📊 테스트 결과 요약')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log(`CareerNet API: ${results.careernet ? '✅ 성공' : '❌ 실패'}`)
  console.log(`Goyong24 API:  ${results.goyong24 ? '✅ 성공' : '❌ 실패'}`)
  
  if (!results.careernet || !results.goyong24) {
    console.log('\n⚠️  API 연결 문제가 있습니다. 위의 상세 로그를 확인하세요.')
    process.exit(1)
  }
  
  console.log('\n✅ 모든 API 테스트 통과!')
  process.exit(0)
}

main().catch(error => {
  console.error('❌ 테스트 실행 중 오류:', error)
  process.exit(1)
})

