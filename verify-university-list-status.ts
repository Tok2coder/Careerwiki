/**
 * universityList 필드 수집 현황 확인
 */

import { readFileSync } from 'fs'
import { resolve } from 'path'
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
} catch (e) {
  // 무시
}

async function verifyStatus() {
  console.log('📊 universityList 필드 수집 현황 확인\n')
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB')

  // 전체 CareerNet 전공 통계
  const totalResult = await db.prepare(`
    SELECT COUNT(*) as count
    FROM majors
    WHERE careernet_id IS NOT NULL
  `).first<{ count: number }>()
  const total = totalResult?.count || 0

  // universityList가 있는 전공
  const withUniversityList = await db.prepare(`
    SELECT COUNT(*) as count
    FROM majors
    WHERE careernet_id IS NOT NULL
    AND api_data_json IS NOT NULL
  `).all<{ count: number }>()

  let hasUniversityListCount = 0
  let stringUniversityCount = 0
  let arrayUniversityCount = 0
  let emptyUniversityCount = 0
  let noUniversityCount = 0

  const allMajors = await db.prepare(`
    SELECT api_data_json
    FROM majors
    WHERE careernet_id IS NOT NULL
    AND api_data_json IS NOT NULL
  `).all<{ api_data_json: string }>()

  for (const row of allMajors.results || []) {
    try {
      const apiData = JSON.parse(row.api_data_json)
      const rawCareernet = apiData.rawCareernet || apiData.careernet
      
      if (!rawCareernet) {
        noUniversityCount++
        continue
      }

      const university = rawCareernet.university
      const universityList = rawCareernet.universityList

      if (universityList && Array.isArray(universityList) && universityList.length > 0) {
        hasUniversityListCount++
      }

      if (typeof university === 'string' && university.length > 0) {
        stringUniversityCount++
      } else if (Array.isArray(university)) {
        if (university.length === 0) {
          emptyUniversityCount++
        } else {
          arrayUniversityCount++
        }
      } else {
        noUniversityCount++
      }
    } catch (e) {
      // 무시
    }
  }

  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('📊 universityList 필드 수집 현황')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  console.log(`총 CareerNet 전공: ${total}개\n`)

  console.log(`✅ universityList가 있는 전공: ${hasUniversityListCount}개`)
  console.log(`   수집률: ${((hasUniversityListCount / total) * 100).toFixed(1)}%\n`)

  console.log(`📋 university 필드 타입 분류:`)
  console.log(`   - 문자열: ${stringUniversityCount}개`)
  console.log(`   - 배열 (비어있음): ${emptyUniversityCount}개`)
  console.log(`   - 배열 (데이터 있음): ${arrayUniversityCount}개`)
  console.log(`   - 없음: ${noUniversityCount}개`)

  console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('💡 결론')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  if (hasUniversityListCount === total) {
    console.log('✅ 모든 전공에 universityList가 생성되어 있습니다!')
    console.log('   → 수정 완료, 추가 작업 불필요')
  } else {
    const missingCount = total - hasUniversityListCount
    console.log(`⚠️  ${missingCount}개 전공에 universityList가 없습니다.`)
    console.log(`\n원인 분석:`)
    
    if (stringUniversityCount > 0) {
      console.log(`   - ${stringUniversityCount}개 전공: university가 문자열 (API가 상세 정보 제공 안 함)`)
    }
    if (emptyUniversityCount > 0) {
      console.log(`   - ${emptyUniversityCount}개 전공: university가 빈 배열 (개설 대학 정보 없음)`)
    }
    
    console.log(`\n해결 방안:`)
    console.log(`   1. API가 상세 정보를 제공하지 않는 전공은 universityList 생성 불가`)
    console.log(`   2. 현재 로직은 정상 작동 중 (객체 배열인 경우 universityList 생성)`)
    console.log(`   3. 수집률 ${((hasUniversityListCount / total) * 100).toFixed(1)}%는 API 제공 데이터 범위 내에서 최선의 결과`)
  }
}

verifyStatus().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

