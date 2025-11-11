/**
 * 특정 전공 재시딩 테스트 (가정교육과)
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

async function reseedSpecificMajor() {
  console.log('🔍 특정 전공 재시딩 테스트\n')
  
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

  // 가정교육과 찾기 (universityList가 정상 생성되어야 하는 전공)
  const targetMajor = await db.prepare(`
    SELECT id, name, careernet_id, api_data_json
    FROM majors
    WHERE careernet_id = '10006'
    LIMIT 1
  `).first<{ id: string; name: string; careernet_id: string; api_data_json: string }>()

  if (!targetMajor) {
    console.log('❌ 가정교육과를 찾을 수 없습니다.')
    return
  }

  console.log(`📋 테스트 대상: ${targetMajor.name} (${targetMajor.careernet_id})\n`)

  // 재시딩 전 상태
  let beforeState = { hasUniversityList: false, universityType: 'unknown', universityListCount: 0 }
  try {
    const beforeData = JSON.parse(targetMajor.api_data_json)
    const beforeRaw = beforeData.rawCareernet || beforeData.careernet
    if (beforeRaw) {
      beforeState.hasUniversityList = !!(beforeRaw.universityList && 
        Array.isArray(beforeRaw.universityList) && 
        beforeRaw.universityList.length > 0)
      beforeState.universityType = Array.isArray(beforeRaw.university) ? 'array' : typeof beforeRaw.university
      beforeState.universityListCount = Array.isArray(beforeRaw.universityList) ? beforeRaw.universityList.length : 0
    }
  } catch (e) {
    // 무시
  }

  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('재시딩 전 상태:')
  console.log(`  - universityList: ${beforeState.hasUniversityList ? '있음' : '없음'} ${beforeState.universityListCount > 0 ? `(${beforeState.universityListCount}개)` : ''}`)
  console.log(`  - university 타입: ${beforeState.universityType}`)
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  try {
    // API 호출
    console.log('📡 API 호출 중...')
    const major = await getMajorDetail(targetMajor.careernet_id, env)
    
    if (!major) {
      console.log('❌ API에서 데이터를 가져올 수 없습니다.')
      return
    }

    console.log('\n✅ API 응답 확인:')
    console.log(`  - university 타입: ${Array.isArray(major.university) ? '배열' : typeof major.university}`)
    if (Array.isArray(major.university)) {
      console.log(`  - university 배열 길이: ${major.university.length}`)
      if (major.university.length > 0) {
        const firstItem = major.university[0]
        console.log(`  - university 첫 항목 타입: ${typeof firstItem}`)
        if (typeof firstItem === 'object' && firstItem !== null) {
          console.log(`  - university 첫 항목 키: ${Object.keys(firstItem).join(', ')}`)
        }
      }
    }

    console.log(`  - universityList 생성: ${major.universityList ? '✅' : '❌'}`)
    if (major.universityList) {
      console.log(`  - universityList 길이: ${major.universityList.length}`)
      if (major.universityList.length > 0) {
        console.log(`  - universityList 첫 항목:`)
        console.log(`    ${JSON.stringify(major.universityList[0], null, 2)}`)
      }
    }

    // D1 업데이트
    console.log('\n💾 D1 업데이트 중...')
    const apiData = {
      careernet: major,
      goyong24: null,
      merged: null,
      sources: ['CAREERNET'],
      rawCareernet: major,
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
      targetMajor.id
    ).run()

    // 업데이트 후 확인
    const afterRow = await db.prepare('SELECT api_data_json FROM majors WHERE id = ?')
      .bind(targetMajor.id).first<{ api_data_json: string }>()
    
    let afterState = { hasUniversityList: false, universityListCount: 0 }
    if (afterRow) {
      try {
        const afterData = JSON.parse(afterRow.api_data_json)
        const afterRaw = afterData.rawCareernet || afterData.careernet
        if (afterRaw && afterRaw.universityList) {
          afterState.hasUniversityList = Array.isArray(afterRaw.universityList) && afterRaw.universityList.length > 0
          afterState.universityListCount = Array.isArray(afterRaw.universityList) 
            ? afterRaw.universityList.length 
            : 0
        }
      } catch (e) {
        // 무시
      }
    }

    console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    console.log('재시딩 후 상태:')
    console.log(`  - universityList: ${afterState.hasUniversityList ? '✅ 있음' : '❌ 없음'} ${afterState.universityListCount > 0 ? `(${afterState.universityListCount}개)` : ''}`)
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

    if (afterState.hasUniversityList) {
      console.log('✅ 재시딩 성공! universityList가 정상적으로 생성되었습니다.')
      console.log(`   항목 수: ${afterState.universityListCount}개`)
    } else {
      console.log('❌ 재시딩 실패. universityList가 생성되지 않았습니다.')
      console.log('   → API 응답 구조를 다시 확인해야 합니다.')
    }

  } catch (error) {
    console.error('\n❌ 오류 발생:', error)
  }
}

reseedSpecificMajor().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

