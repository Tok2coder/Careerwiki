/**
 * CareerNet API 파라미터 테스트
 * university 상세 정보를 얻기 위한 최적의 파라미터 찾기
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
} catch (e) {
  // 무시
}

async function testApiParams() {
  const apiKey = process.env.CAREER_NET_API_KEY || 'd9e0285190fde074bef30031f17f669e'
  const testMajorSeq = '336' // 아프리카어과 (문자열로 응답이 오는 것으로 확인된 전공)
  
  console.log(`🔍 API 파라미터 테스트: majorSeq=${testMajorSeq}\n`)
  
  // 테스트할 파라미터 조합
  const testCases = [
    { gubun: 'univ_list', description: '현재 사용 중 (univ_list)' },
    { gubun: 'univ_detail', description: '상세 정보 (univ_detail)' },
    { gubun: '', description: 'gubun 없음' },
    { gubun: 'major_detail', description: '전공 상세 (major_detail)' }
  ]
  
  for (const testCase of testCases) {
    console.log(`\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
    console.log(`📡 테스트: ${testCase.description}`)
    console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
    
    try {
      const url = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi')
      url.searchParams.append('apiKey', apiKey)
      url.searchParams.append('svcType', 'api')
      url.searchParams.append('svcCode', 'MAJOR_VIEW')
      url.searchParams.append('contentType', 'json')
      if (testCase.gubun) {
        url.searchParams.append('gubun', testCase.gubun)
      }
      url.searchParams.append('majorSeq', testMajorSeq)
      
      const response = await fetch(url.toString())
      
      if (!response.ok) {
        console.log(`   ❌ API 오류 [${response.status}]: ${response.statusText}`)
        continue
      }
      
      const jsonData = await response.json()
      
      if (jsonData.error) {
        console.log(`   ❌ API 에러: ${jsonData.error}`)
        continue
      }
      
      const majors = jsonData.dataSearch?.content || []
      
      if (majors.length === 0) {
        console.log(`   ⚠️  데이터 없음`)
        continue
      }
      
      const major = majors[0]
      
      console.log(`   ✅ 응답 받음`)
      console.log(`   - university 타입: ${Array.isArray(major.university) ? '배열' : typeof major.university}`)
      
      if (Array.isArray(major.university)) {
        console.log(`   - 배열 길이: ${major.university.length}`)
        if (major.university.length > 0) {
          const firstItem = major.university[0]
          console.log(`   - 첫 항목 타입: ${typeof firstItem}`)
          if (typeof firstItem === 'object' && firstItem !== null) {
            console.log(`   - ✅ 객체 배열 (상세 정보 포함)`)
            console.log(`   - 객체 키: ${Object.keys(firstItem).join(', ')}`)
            console.log(`   - 첫 항목: ${JSON.stringify(firstItem, null, 2).substring(0, 300)}`)
          } else {
            console.log(`   - ⚠️  문자열 배열 (상세 정보 없음)`)
          }
        }
      } else if (typeof major.university === 'string') {
        console.log(`   - ⚠️  문자열 (상세 정보 없음)`)
        console.log(`   - 값: ${major.university.substring(0, 200)}`)
      }
      
      // 다른 가능한 필드 확인
      const possibleFields = ['universityList', 'univList', 'university_detail', 'univ_detail', 'universityInfo']
      for (const field of possibleFields) {
        if (major[field]) {
          console.log(`   - ✅ ${field} 필드 존재: ${JSON.stringify(major[field], null, 2).substring(0, 200)}`)
        }
      }
      
    } catch (error) {
      console.error(`   ❌ 오류:`, error)
    }
  }
}

testApiParams().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

