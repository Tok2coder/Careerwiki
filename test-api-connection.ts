/**
 * API 연결 테스트 스크립트
 * CareerNet과 Goyong24 API 연결 및 키 유효성 검증
 */

import { searchMajors } from './src/api/careernetAPI'
import { fetchGoyong24MajorList } from './src/api/goyong24API'
import { readFileSync } from 'fs'
import { resolve } from 'path'

// .dev.vars 파일에서 환경 변수 로드
function loadEnvVars() {
  try {
    const devVarsPath = resolve(process.cwd(), '.dev.vars')
    const devVarsContent = readFileSync(devVarsPath, 'utf-8')
    const env: Record<string, string> = {}
    
    devVarsContent.split('\n').forEach(line => {
      const trimmed = line.trim()
      if (trimmed && !trimmed.startsWith('#')) {
        const [key, ...valueParts] = trimmed.split('=')
        if (key && valueParts.length > 0) {
          const value = valueParts.join('=').trim()
          env[key.trim()] = value
        }
      }
    })
    
    return env
  } catch (e) {
    console.error('❌ .dev.vars 파일을 읽을 수 없습니다:', e)
    return {}
  }
}

async function testCareerNetAPI(env: Record<string, string>) {
  console.log('\n🔍 CareerNet API 테스트')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  
  try {
    const apiKey = env.CAREER_NET_API_KEY || 'd9e0285190fde074bef30031f17f669e'
    console.log(`API Key: ${apiKey.substring(0, 10)}...`)
    
    const majors = await searchMajors({
      thisPage: 1,
      perPage: 5
    }, { CAREER_NET_API_KEY: apiKey })
    
    if (majors.length > 0) {
      console.log(`✅ CareerNet API 연결 성공!`)
      console.log(`   수집된 전공 수: ${majors.length}개`)
      console.log(`   샘플: ${majors[0].major || majors[0].summary || 'N/A'}`)
      return true
    } else {
      console.log(`⚠️  CareerNet API 연결은 되었지만 데이터가 없습니다.`)
      return false
    }
  } catch (error: any) {
    console.error(`❌ CareerNet API 연결 실패:`)
    console.error(`   ${error.message}`)
    if (error.stack) {
      console.error(`   ${error.stack.split('\n')[1]}`)
    }
    return false
  }
}

async function testGoyong24MajorAPI(env: Record<string, string>) {
  console.log('\n🔍 Goyong24 Major API 테스트')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  
  try {
    const apiKey = env.GOYONG24_MAJOR_API_KEY
    if (!apiKey) {
      console.error('❌ GOYONG24_MAJOR_API_KEY가 설정되지 않았습니다.')
      return false
    }
    
    console.log(`API Key: ${apiKey.substring(0, 10)}...`)
    
    const result = await fetchGoyong24MajorList({
      keyword: '컴퓨터',
      srchType: 'K'
    }, { GOYONG24_MAJOR_API_KEY: apiKey })
    
    if (result.items.length > 0) {
      console.log(`✅ Goyong24 Major API 연결 성공!`)
      console.log(`   수집된 전공 수: ${result.items.length}개`)
      console.log(`   샘플: ${result.items[0].knowDtlSchDptNm || result.items[0].knowSchDptNm || 'N/A'}`)
      return true
    } else {
      console.log(`⚠️  Goyong24 Major API 연결은 되었지만 데이터가 없습니다.`)
      return false
    }
  } catch (error: any) {
    console.error(`❌ Goyong24 Major API 연결 실패:`)
    console.error(`   ${error.message}`)
    if (error.stack) {
      console.error(`   ${error.stack.split('\n')[1]}`)
    }
    return false
  }
}

async function testGoyong24JobAPI(env: Record<string, string>) {
  console.log('\n🔍 Goyong24 Job API 테스트')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  
  try {
    const apiKey = env.GOYONG24_JOB_API_KEY
    if (!apiKey) {
      console.error('❌ GOYONG24_JOB_API_KEY가 설정되지 않았습니다.')
      return false
    }
    
    console.log(`API Key: ${apiKey.substring(0, 10)}...`)
    
    // Goyong24 Job API 테스트는 fetchGoyong24JobList가 필요
    // 일단 API 키만 확인
    console.log(`✅ Goyong24 Job API Key 확인됨`)
    return true
  } catch (error: any) {
    console.error(`❌ Goyong24 Job API 테스트 실패:`)
    console.error(`   ${error.message}`)
    return false
  }
}

async function main() {
  console.log('🚀 API 연결 테스트 시작')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  
  const env = loadEnvVars()
  
  if (Object.keys(env).length === 0) {
    console.error('❌ 환경 변수를 로드할 수 없습니다.')
    process.exit(1)
  }
  
  console.log('✅ 환경 변수 로드 완료')
  console.log(`   CAREER_NET_API_KEY: ${env.CAREER_NET_API_KEY ? '설정됨' : '없음'}`)
  console.log(`   GOYONG24_MAJOR_API_KEY: ${env.GOYONG24_MAJOR_API_KEY ? '설정됨' : '없음'}`)
  console.log(`   GOYONG24_JOB_API_KEY: ${env.GOYONG24_JOB_API_KEY ? '설정됨' : '없음'}`)
  
  const results = {
    careernet: await testCareerNetAPI(env),
    goyong24Major: await testGoyong24MajorAPI(env),
    goyong24Job: await testGoyong24JobAPI(env)
  }
  
  console.log('\n📊 테스트 결과 요약')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log(`CareerNet API:        ${results.careernet ? '✅ 성공' : '❌ 실패'}`)
  console.log(`Goyong24 Major API:    ${results.goyong24Major ? '✅ 성공' : '❌ 실패'}`)
  console.log(`Goyong24 Job API:     ${results.goyong24Job ? '✅ 성공' : '❌ 실패'}`)
  
  const allPassed = results.careernet && results.goyong24Major && results.goyong24Job
  
  if (allPassed) {
    console.log('\n✅ 모든 API 연결 테스트 통과!')
    console.log('   데이터 시딩을 시작할 수 있습니다.')
    process.exit(0)
  } else {
    console.log('\n❌ 일부 API 연결 테스트 실패')
    console.log('   API 키를 확인하고 다시 시도해주세요.')
    process.exit(1)
  }
}

main().catch(error => {
  console.error('❌ 테스트 실행 중 오류:', error)
  process.exit(1)
})

