/**
 * university가 문자열로 저장된 전공 찾기
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

async function findStringUniversityMajors() {
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB')

  // 모든 CareerNet 전공 확인
  const allMajors = await db.prepare(`
    SELECT id, name, careernet_id, api_data_json
    FROM majors
    WHERE careernet_id IS NOT NULL
    AND api_data_json IS NOT NULL
  `).all<{ id: string; name: string; careernet_id: string; api_data_json: string }>()

  if (!allMajors.results || allMajors.results.length === 0) {
    console.log('❌ 데이터 없음')
    return
  }

  console.log(`📊 전체 CareerNet 전공: ${allMajors.results.length}개\n`)

  const stringUniversity: Array<{ id: string; name: string; careernet_id: string; university: string }> = []
  const arrayUniversity: Array<{ id: string; name: string; careernet_id: string }> = []
  const hasUniversityList: Array<{ id: string; name: string; careernet_id: string; count: number }> = []
  const noUniversity: Array<{ id: string; name: string; careernet_id: string }> = []

  for (const row of allMajors.results) {
    try {
      const apiData = JSON.parse(row.api_data_json)
      const rawCareernet = apiData.rawCareernet || apiData.careernet
      
      if (!rawCareernet) {
        noUniversity.push({ id: row.id, name: row.name, careernet_id: row.careernet_id })
        continue
      }

      const university = rawCareernet.university
      const universityList = rawCareernet.universityList

      if (typeof university === 'string' && university.length > 0) {
        stringUniversity.push({
          id: row.id,
          name: row.name,
          careernet_id: row.careernet_id,
          university: university.substring(0, 100)
        })
      } else if (Array.isArray(university)) {
        arrayUniversity.push({
          id: row.id,
          name: row.name,
          careernet_id: row.careernet_id
        })
      }

      if (universityList && Array.isArray(universityList) && universityList.length > 0) {
        hasUniversityList.push({
          id: row.id,
          name: row.name,
          careernet_id: row.careernet_id,
          count: universityList.length
        })
      }
    } catch (error) {
      // 파싱 오류 무시
    }
  }

  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('📊 university 필드 타입 분류')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  console.log(`1. university가 문자열인 전공: ${stringUniversity.length}개`)
  if (stringUniversity.length > 0) {
    console.log(`   (처음 5개)`)
    for (const item of stringUniversity.slice(0, 5)) {
      console.log(`   - ${item.name} (${item.careernet_id}): "${item.university}..."`)
    }
  }

  console.log(`\n2. university가 배열인 전공: ${arrayUniversity.length}개`)

  console.log(`\n3. universityList가 있는 전공: ${hasUniversityList.length}개`)
  if (hasUniversityList.length > 0) {
    const avgCount = hasUniversityList.reduce((sum, item) => sum + item.count, 0) / hasUniversityList.length
    console.log(`   평균 항목 수: ${avgCount.toFixed(1)}개`)
  }

  console.log(`\n4. university가 없는 전공: ${noUniversity.length}개`)

  console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('🎯 테스트 대상 추천')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  if (stringUniversity.length > 0) {
    console.log(`✅ university가 문자열인 전공 ${stringUniversity.length}개를 재시딩하면`)
    console.log(`   universityList 생성 여부를 확인할 수 있습니다.\n`)
    console.log('테스트 대상 (처음 5개):')
    for (const item of stringUniversity.slice(0, 5)) {
      console.log(`   - ${item.name} (careernet_id: ${item.careernet_id})`)
    }
  } else {
    console.log('✅ 모든 전공의 university가 배열 형태입니다!')
    console.log('   → universityList가 생성되지 않은 전공을 찾아야 합니다.\n')
    
    // universityList가 없는 전공 찾기
    const noUniversityList: Array<{ id: string; name: string; careernet_id: string }> = []
    for (const row of allMajors.results) {
      try {
        const apiData = JSON.parse(row.api_data_json)
        const rawCareernet = apiData.rawCareernet || apiData.careernet
        if (rawCareernet) {
          const universityList = rawCareernet.universityList
          if (!universityList || (Array.isArray(universityList) && universityList.length === 0)) {
            noUniversityList.push({
              id: row.id,
              name: row.name,
              careernet_id: row.careernet_id
            })
          }
        }
      } catch (e) {
        // 무시
      }
    }
    
    if (noUniversityList.length > 0) {
      console.log(`⚠️  universityList가 없는 전공: ${noUniversityList.length}개\n`)
      console.log('테스트 대상 (처음 5개):')
      for (const item of noUniversityList.slice(0, 5)) {
        console.log(`   - ${item.name} (careernet_id: ${item.careernet_id})`)
      }
    } else {
      console.log('✅ 모든 전공에 universityList가 이미 생성되어 있습니다!')
    }
  }
}

findStringUniversityMajors().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

