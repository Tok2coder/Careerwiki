/**
 * API 응답에서 universityList 필드 직접 확인
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

async function testDirectApi() {
  const apiKey = process.env.CAREER_NET_API_KEY || 'd9e0285190fde074bef30031f17f669e'
  
  // 두 가지 케이스 테스트
  const testCases = [
    { majorSeq: '10006', name: '가정교육과 (universityList 있음)' },
    { majorSeq: '336', name: '아프리카어과 (universityList 없음)' }
  ]
  
  for (const testCase of testCases) {
    console.log(`\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
    console.log(`📡 API 테스트: ${testCase.name} (${testCase.majorSeq})`)
    console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
    
    try {
      const url = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi')
      url.searchParams.append('apiKey', apiKey)
      url.searchParams.append('svcType', 'api')
      url.searchParams.append('svcCode', 'MAJOR_VIEW')
      url.searchParams.append('contentType', 'json')
      url.searchParams.append('gubun', 'univ_list')
      url.searchParams.append('majorSeq', testCase.majorSeq)
      
      const response = await fetch(url.toString())
      
      if (!response.ok) {
        console.log(`   ❌ API 오류 [${response.status}]`)
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
      
      console.log(`\n📊 API 응답 필드 분석:`)
      console.log(`\n1. university 필드:`)
      console.log(`   타입: ${Array.isArray(major.university) ? '배열' : typeof major.university}`)
      if (Array.isArray(major.university)) {
        console.log(`   길이: ${major.university.length}`)
        if (major.university.length > 0) {
          console.log(`   첫 항목: ${JSON.stringify(major.university[0], null, 2).substring(0, 400)}`)
        }
      } else if (typeof major.university === 'string') {
        console.log(`   값: ${major.university.substring(0, 200)}`)
      }
      
      console.log(`\n2. universityList 필드 (API 응답에 직접 포함되는지):`)
      if (major.universityList) {
        console.log(`   ✅ API 응답에 universityList 필드가 직접 포함되어 있습니다!`)
        console.log(`   타입: ${Array.isArray(major.universityList) ? '배열' : typeof major.universityList}`)
        if (Array.isArray(major.universityList)) {
          console.log(`   길이: ${major.universityList.length}`)
          if (major.universityList.length > 0) {
            console.log(`   첫 항목: ${JSON.stringify(major.universityList[0], null, 2)}`)
          }
        }
      } else {
        console.log(`   ❌ API 응답에 universityList 필드가 없습니다`)
      }
      
      // 모든 필드 확인
      console.log(`\n3. API 응답의 모든 필드:`)
      const fields = Object.keys(major).filter(key => 
        key.toLowerCase().includes('univ') || 
        key.toLowerCase().includes('school') ||
        key.toLowerCase().includes('college')
      )
      if (fields.length > 0) {
        console.log(`   관련 필드: ${fields.join(', ')}`)
        for (const field of fields) {
          console.log(`   - ${field}: ${typeof major[field]} ${Array.isArray(major[field]) ? `(배열, 길이: ${major[field].length})` : ''}`)
        }
      } else {
        console.log(`   관련 필드 없음`)
      }
      
    } catch (error) {
      console.error(`   ❌ 오류:`, error)
    }
  }
}

testDirectApi().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

