/**
 * universityList 필드 수정 검증을 위한 일부 전공 재시딩 테스트 (v2)
 * 실제 D1에 저장된 careernet_id 사용
 */

import { readFileSync } from 'fs'
import { resolve } from 'path'
import { Miniflare } from 'miniflare'
import { getMajorDetail } from './src/api/careernetAPI'
import type { Env } from './src/types/env'

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

async function testReseed() {
  console.log('🔍 universityList 필드 수정 검증 테스트 시작...\n')
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB')
  const env: Env = {
    DB: db as any,
    CAREER_NET_API_KEY: process.env.CAREER_NET_API_KEY || '',
    GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY || '',
    GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY || ''
  }

  // universityList가 없는 전공 찾기 (university가 문자열인 것)
  console.log('📋 universityList가 없는 전공 찾는 중...\n')
  const allMajors = await db.prepare(`
    SELECT id, name, careernet_id, api_data_json
    FROM majors
    WHERE careernet_id IS NOT NULL
    AND api_data_json IS NOT NULL
    ORDER BY RANDOM()
    LIMIT 20
  `).all<{ id: string; name: string; careernet_id: string; api_data_json: string }>()

  if (!allMajors.results || allMajors.results.length === 0) {
    console.log('❌ 테스트할 전공을 찾을 수 없습니다.')
    return
  }

  // universityList가 없는 전공 필터링
  const testTargets: Array<{ id: string; name: string; careernet_id: string }> = []
  
  for (const row of allMajors.results) {
    try {
      const apiData = JSON.parse(row.api_data_json)
      const rawCareernet = apiData.rawCareernet || apiData.careernet
      
      if (rawCareernet) {
        const universityList = rawCareernet.universityList
        
        // universityList가 없는 경우만 테스트 대상으로
        if (!universityList || (Array.isArray(universityList) && universityList.length === 0)) {
          testTargets.push({
            id: row.id,
            name: row.name,
            careernet_id: row.careernet_id
          })
          
          if (testTargets.length >= 5) break // 최대 5개
        }
      }
    } catch (error) {
      // 파싱 오류 무시
    }
  }

  if (testTargets.length === 0) {
    console.log('⚠️  universityList가 없는 전공을 찾을 수 없습니다.')
    console.log('   → 모든 전공에 universityList가 이미 생성되어 있습니다! ✅')
    return
  }
  
  console.log(`📊 테스트 대상: ${testTargets.length}개 전공\n`)
  for (const target of testTargets) {
    console.log(`   - ${target.name} (careernet_id: ${target.careernet_id})`)
  }
  console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  let successCount = 0
  let failCount = 0
  const results: Array<{
    name: string
    careernet_id: string
    before: { hasUniversityList: boolean; universityType: string }
    after: { hasUniversityList: boolean; universityListLength?: number }
    success: boolean
    error?: string
  }> = []

  for (const target of testTargets) {
    console.log(`\n📡 재시딩 중: ${target.name} (careernet_id: ${target.careernet_id})`)
    
    try {
      // 재시딩 전 상태 확인
      const beforeRow = await db.prepare('SELECT api_data_json FROM majors WHERE id = ?')
        .bind(target.id).first<{ api_data_json: string }>()
      
      let beforeState = { hasUniversityList: false, universityType: 'unknown' }
      if (beforeRow) {
        try {
          const beforeData = JSON.parse(beforeRow.api_data_json)
          const beforeRaw = beforeData.rawCareernet || beforeData.careernet
          if (beforeRaw) {
            beforeState.hasUniversityList = !!(beforeRaw.universityList && 
              Array.isArray(beforeRaw.universityList) && 
              beforeRaw.universityList.length > 0)
            beforeState.universityType = Array.isArray(beforeRaw.university) 
              ? 'array' 
              : typeof beforeRaw.university
          }
        } catch (e) {
          // 파싱 오류 무시
        }
      }

      console.log(`   재시딩 전: universityList ${beforeState.hasUniversityList ? '있음' : '없음'} (university 타입: ${beforeState.universityType})`)

      // API에서 최신 데이터 가져오기
      console.log(`   📡 API 호출 중...`)
      const major = await getMajorDetail(target.careernet_id, env)
      
      if (!major) {
        const error = `API에서 데이터를 가져올 수 없습니다 (majorSeq: ${target.careernet_id})`
        console.log(`   ⚠️  ${error}`)
        failCount++
        results.push({
          name: target.name,
          careernet_id: target.careernet_id,
          before: beforeState,
          after: { hasUniversityList: false },
          success: false,
          error
        })
        continue
      }

      // universityList 확인
      const hasUniversityList = !!major.universityList && major.universityList.length > 0
      const universityListLength = major.universityList?.length || 0

      console.log(`   ✅ API 응답 확인:`)
      console.log(`      - university 타입: ${Array.isArray(major.university) ? 'array' : typeof major.university}`)
      if (Array.isArray(major.university) && major.university.length > 0) {
        const firstItem = major.university[0]
        console.log(`      - university 첫 항목 타입: ${typeof firstItem}`)
        if (typeof firstItem === 'object' && firstItem !== null) {
          console.log(`      - university 첫 항목 키: ${Object.keys(firstItem).join(', ')}`)
        }
      }
      console.log(`      - universityList 생성: ${hasUniversityList ? '✅' : '❌'}`)
      if (hasUniversityList) {
        console.log(`      - universityList 항목 수: ${universityListLength}`)
        if (major.universityList && major.universityList.length > 0) {
          const first = major.universityList[0]
          console.log(`      - 첫 번째 항목: ${JSON.stringify({
            schoolName: first.schoolName,
            area: first.area,
            campus_nm: first.campus_nm
          }, null, 2)}`)
        }
      } else {
        // universityList가 생성되지 않은 이유 확인
        if (typeof major.university === 'string') {
          console.log(`      - 이유: university가 문자열입니다 (상세 정보 없음)`)
        } else if (Array.isArray(major.university) && major.university.length > 0) {
          const firstItem = major.university[0]
          if (typeof firstItem === 'string') {
            console.log(`      - 이유: university가 문자열 배열입니다 (상세 정보 없음)`)
          } else {
            console.log(`      - 이유: 알 수 없음 (로직 확인 필요)`)
          }
        } else {
          console.log(`      - 이유: university가 없거나 비어있습니다`)
        }
      }

      // D1에 업데이트
      const apiData = {
        careernet: major,
        goyong24: null,
        merged: null, // normalize는 나중에
        sources: ['CAREERNET'],
        rawCareernet: major, // 원본 데이터 보존
        rawGoyong24: null
      }

      const now = Date.now()
      await db.prepare(`
        UPDATE majors
        SET api_data_json = ?,
            api_last_updated_at = ?,
            api_last_fetched_at = ?
        WHERE id = ?
      `).bind(
        JSON.stringify(apiData),
        now,
        now,
        target.id
      ).run()

      // 업데이트 후 상태 확인
      const afterRow = await db.prepare('SELECT api_data_json FROM majors WHERE id = ?')
        .bind(target.id).first<{ api_data_json: string }>()
      
      let afterState = { hasUniversityList: false, universityListLength: 0 }
      if (afterRow) {
        try {
          const afterData = JSON.parse(afterRow.api_data_json)
          const afterRaw = afterData.rawCareernet || afterData.careernet
          if (afterRaw && afterRaw.universityList) {
            afterState.hasUniversityList = Array.isArray(afterRaw.universityList) && afterRaw.universityList.length > 0
            afterState.universityListLength = Array.isArray(afterRaw.universityList) 
              ? afterRaw.universityList.length 
              : 0
          }
        } catch (e) {
          // 파싱 오류 무시
        }
      }

      const success = afterState.hasUniversityList
      
      if (success) {
        console.log(`   ✅ 재시딩 성공: universityList 생성됨 (${afterState.universityListLength}개 항목)`)
        successCount++
      } else {
        console.log(`   ❌ 재시딩 실패: universityList 생성 안 됨`)
        failCount++
      }

      results.push({
        name: target.name,
        careernet_id: target.careernet_id,
        before: beforeState,
        after: afterState,
        success
      })

    } catch (error) {
      const errorMsg = error instanceof Error ? error.message : String(error)
      console.error(`   ❌ 오류 발생:`, errorMsg)
      failCount++
      results.push({
        name: target.name,
        careernet_id: target.careernet_id,
        before: { hasUniversityList: false, universityType: 'unknown' },
        after: { hasUniversityList: false },
        success: false,
        error: errorMsg
      })
    }
  }

  // 결과 요약
  console.log('\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('📊 재시딩 테스트 결과 요약')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  for (const result of results) {
    const status = result.success ? '✅' : '❌'
    console.log(`${status} ${result.name} (${result.careernet_id})`)
    console.log(`   재시딩 전: universityList ${result.before.hasUniversityList ? '있음' : '없음'} (university 타입: ${result.before.universityType})`)
    console.log(`   재시딩 후: universityList ${result.after.hasUniversityList ? '있음' : '없음'} ${result.after.universityListLength ? `(${result.after.universityListLength}개)` : ''}`)
    if (result.error) {
      console.log(`   오류: ${result.error}`)
    }
    console.log('')
  }

  console.log(`\n📈 통계:`)
  console.log(`   총 테스트: ${testTargets.length}개`)
  console.log(`   성공: ${successCount}개 (${testTargets.length > 0 ? (successCount / testTargets.length * 100).toFixed(1) : 0}%)`)
  console.log(`   실패: ${failCount}개 (${testTargets.length > 0 ? (failCount / testTargets.length * 100).toFixed(1) : 0}%)`)

  if (successCount === testTargets.length && testTargets.length > 0) {
    console.log('\n✅ 모든 테스트 성공! universityList 필드 수정이 정상 작동합니다.')
  } else if (successCount > 0) {
    console.log('\n⚠️  일부 성공. 실패한 전공의 API 응답 구조를 확인해야 합니다.')
  } else if (testTargets.length === 0) {
    console.log('\n✅ 모든 전공에 universityList가 이미 생성되어 있습니다!')
  } else {
    console.log('\n❌ 모든 테스트 실패. API 응답 구조를 다시 확인해야 합니다.')
  }
}

testReseed().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

