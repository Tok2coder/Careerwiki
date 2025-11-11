/**
 * universityList 필드 수정을 위한 테스트 스크립트
 * API 응답 구조를 확인하고 매핑 로직을 검증
 */

import { readFileSync } from 'fs'
import { resolve } from 'path'
import { getMajorDetail } from './src/api/careernetAPI'
import { Miniflare } from 'miniflare'

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
  console.warn('⚠️  Could not load .dev.vars file, using system environment variables')
}

async function testUniversityList() {
  console.log('🔍 universityList 필드 테스트 시작...\n')
  
  // 테스트할 학과 ID (CareerNet majorSeq)
  const testMajorSeq = '100100' // 전기전자공학과 예시
  
  try {
    console.log(`📡 API 호출: majorSeq=${testMajorSeq}`)
    const major = await getMajorDetail(testMajorSeq, {
      CAREER_NET_API_KEY: process.env.CAREER_NET_API_KEY
    })
    
    if (!major) {
      console.error('❌ 학과 정보를 찾을 수 없습니다.')
      return
    }
    
    console.log('\n📊 API 응답 분석:')
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    
    // university 필드 타입 확인
    console.log(`\n1. university 필드 타입: ${typeof major.university}`)
    console.log(`   값: ${JSON.stringify(major.university, null, 2).substring(0, 500)}`)
    
    // universityList 필드 확인
    console.log(`\n2. universityList 필드 존재 여부: ${major.universityList ? '있음' : '없음'}`)
    if (major.universityList) {
      console.log(`   배열 길이: ${major.universityList.length}`)
      console.log(`   첫 번째 항목: ${JSON.stringify(major.universityList[0], null, 2)}`)
    }
    
    // 원본 API 응답의 university 구조 확인
    const rawUniversity = (major as any).university
    console.log(`\n3. 원본 university 필드 구조:`)
    console.log(`   타입: ${Array.isArray(rawUniversity) ? '배열' : typeof rawUniversity}`)
    if (Array.isArray(rawUniversity)) {
      console.log(`   배열 길이: ${rawUniversity.length}`)
      if (rawUniversity.length > 0) {
        console.log(`   첫 번째 항목 타입: ${typeof rawUniversity[0]}`)
        console.log(`   첫 번째 항목: ${JSON.stringify(rawUniversity[0], null, 2).substring(0, 500)}`)
      }
    } else if (rawUniversity) {
      console.log(`   값: ${JSON.stringify(rawUniversity, null, 2).substring(0, 500)}`)
    }
    
    // 문제 진단
    console.log('\n🔍 문제 진단:')
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    
    if (!major.universityList || major.universityList.length === 0) {
      console.log('❌ universityList가 생성되지 않았습니다.')
      
      if (Array.isArray(rawUniversity)) {
        if (rawUniversity.length > 0) {
          const firstItem = rawUniversity[0]
          if (typeof firstItem === 'object' && firstItem !== null) {
            console.log('✅ university는 배열이고, 각 항목은 객체입니다.')
            console.log(`   객체 키: ${Object.keys(firstItem).join(', ')}`)
            
            // schoolName 필드 확인
            if ('schoolName' in firstItem) {
              console.log('✅ schoolName 필드가 존재합니다.')
            } else {
              console.log('❌ schoolName 필드가 없습니다!')
              console.log(`   실제 필드명: ${Object.keys(firstItem).join(', ')}`)
            }
          } else if (typeof firstItem === 'string') {
            console.log('❌ university 배열의 각 항목이 문자열입니다.')
            console.log('   → 객체가 아닌 문자열이므로 매핑 로직이 작동하지 않습니다.')
          }
        } else {
          console.log('⚠️  university 배열이 비어있습니다.')
        }
      } else {
        console.log('❌ university가 배열이 아닙니다.')
        console.log(`   타입: ${typeof rawUniversity}`)
      }
    } else {
      console.log('✅ universityList가 정상적으로 생성되었습니다!')
      console.log(`   항목 수: ${major.universityList.length}`)
    }
    
  } catch (error) {
    console.error('\n❌ 테스트 실패:', error)
    if (error instanceof Error) {
      console.error('   메시지:', error.message)
      console.error('   스택:', error.stack)
    }
  }
}

testUniversityList().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

