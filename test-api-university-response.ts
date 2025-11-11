/**
 * CareerNet API 응답에서 university 필드 구조 확인
 */

import { readFileSync } from 'fs'
import { resolve } from 'path'

// .dev.vars 파일에서 환경 변수 로드
try {
  const devVarsPath = resolve(process.cwd(), '.dev.vars')
  const devVarsContent = readFileSync(devVarsPath, 'utf-8')
  devVarsContent.split('\n').forEach(line => {
    const trimmed = line.trim()
    if (trimmed && !trimmed.startsWith('#')) {
      const [key, ...valueParts] = trimmed.split('=')
      if (key && valueParts.length > 0) {
        const value = valueParts.join('=').trim()
        process.env[key.trim()] = value
      }
    }
  })
  console.log('✅ Loaded environment variables from .dev.vars')
} catch (e) {
  console.warn('⚠️  Could not load .dev.vars file')
}

async function testApiResponse() {
  const apiKey = process.env.CAREER_NET_API_KEY || 'd9e0285190fde074bef30031f17f669e'
  
  // 두 가지 다른 majorSeq 테스트
  const testCases = [
    { majorSeq: '100100', name: '전기전자공학과' },
    { majorSeq: '10006', name: '가정교육과' } // universityList가 있는 것으로 확인된 전공
  ]
  
  for (const testCase of testCases) {
    console.log(`\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
    console.log(`📡 API 테스트: ${testCase.name} (majorSeq=${testCase.majorSeq})`)
    console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
    
    try {
      const url = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi')
      url.searchParams.append('apiKey', apiKey)
      url.searchParams.append('svcType', 'api')
      url.searchParams.append('svcCode', 'MAJOR_VIEW')
      url.searchParams.append('contentType', 'json')
      url.searchParams.append('gubun', 'univ_list')
      url.searchParams.append('majorSeq', testCase.majorSeq)
      
      console.log(`\n🔗 요청 URL: ${url.toString().replace(apiKey, '***')}`)
      
      const response = await fetch(url.toString())
      
      if (!response.ok) {
        console.error(`❌ API 오류 [${response.status}]: ${response.statusText}`)
        continue
      }
      
      const jsonData = await response.json()
      
      if (jsonData.error) {
        console.error(`❌ API 에러: ${jsonData.error}`)
        continue
      }
      
      const majors = jsonData.dataSearch?.content || []
      
      if (majors.length === 0) {
        console.log(`⚠️  데이터 없음`)
        continue
      }
      
      const major = majors[0]
      
      console.log(`\n📊 API 응답 분석:`)
      console.log(`\n1. university 필드:`)
      console.log(`   타입: ${Array.isArray(major.university) ? '배열' : typeof major.university}`)
      
      if (Array.isArray(major.university)) {
        console.log(`   배열 길이: ${major.university.length}`)
        if (major.university.length > 0) {
          const firstItem = major.university[0]
          console.log(`   첫 번째 항목 타입: ${typeof firstItem}`)
          
          if (typeof firstItem === 'object' && firstItem !== null) {
            console.log(`   ✅ 객체 배열`)
            console.log(`   객체 키: ${Object.keys(firstItem).join(', ')}`)
            console.log(`   첫 번째 항목: ${JSON.stringify(firstItem, null, 2).substring(0, 500)}`)
          } else if (typeof firstItem === 'string') {
            console.log(`   ⚠️  문자열 배열`)
            console.log(`   첫 번째 항목: "${firstItem.substring(0, 100)}"`)
          }
        }
      } else if (typeof major.university === 'string') {
        console.log(`   ⚠️  문자열`)
        console.log(`   값: ${major.university.substring(0, 200)}`)
      } else {
        console.log(`   값: ${major.university}`)
      }
      
      // 다른 가능한 필드 확인
      console.log(`\n2. 다른 university 관련 필드:`)
      const possibleFields = ['universityList', 'univList', 'university_detail', 'univ_detail']
      for (const field of possibleFields) {
        if (major[field]) {
          console.log(`   ✅ ${field} 존재: ${JSON.stringify(major[field], null, 2).substring(0, 300)}`)
        }
      }
      
    } catch (error) {
      console.error(`\n❌ 테스트 실패:`, error)
    }
  }
}

testApiResponse().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

