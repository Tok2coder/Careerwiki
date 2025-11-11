/**
 * D1에 저장된 데이터에서 university 필드 구조 확인
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
  console.log('✅ Loaded environment variables from .dev.vars')
} catch (e) {
  console.warn('⚠️  Could not load .dev.vars file')
}

async function checkUniversityStructure() {
  console.log('🔍 D1 데이터에서 university 필드 구조 확인...\n')
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB')

  // CareerNet 전공 중 university 데이터가 있는 것 찾기
  const result = await db.prepare(`
    SELECT id, name, api_data_json 
    FROM majors 
    WHERE careernet_id IS NOT NULL 
    AND api_data_json IS NOT NULL
    LIMIT 5
  `).all<{ id: string; name: string; api_data_json: string }>()

  if (!result.results || result.results.length === 0) {
    console.log('❌ 데이터를 찾을 수 없습니다.')
    return
  }

  console.log(`📊 ${result.results.length}개 전공 데이터 확인\n`)

  for (const row of result.results) {
    try {
      const apiData = JSON.parse(row.api_data_json)
      const rawCareernet = apiData.rawCareernet || apiData.careernet
      
      if (!rawCareernet) {
        console.log(`⚠️  ${row.name}: rawCareernet 데이터 없음`)
        continue
      }

      console.log(`\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
      console.log(`📋 전공: ${row.name} (${row.id})`)
      console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)

      // university 필드 확인
      const university = rawCareernet.university
      console.log(`\n1. university 필드:`)
      console.log(`   타입: ${Array.isArray(university) ? '배열' : typeof university}`)
      
      if (Array.isArray(university)) {
        console.log(`   배열 길이: ${university.length}`)
        if (university.length > 0) {
          const firstItem = university[0]
          console.log(`   첫 번째 항목 타입: ${typeof firstItem}`)
          
          if (typeof firstItem === 'object' && firstItem !== null) {
            console.log(`   객체 키: ${Object.keys(firstItem).join(', ')}`)
            console.log(`   첫 번째 항목: ${JSON.stringify(firstItem, null, 2).substring(0, 500)}`)
            
            // schoolName 필드 확인
            if ('schoolName' in firstItem) {
              console.log(`   ✅ schoolName 필드 존재: "${firstItem.schoolName}"`)
            } else {
              console.log(`   ❌ schoolName 필드 없음!`)
              console.log(`   실제 필드명: ${Object.keys(firstItem).join(', ')}`)
            }
          } else if (typeof firstItem === 'string') {
            console.log(`   ❌ 배열 항목이 문자열: "${firstItem.substring(0, 100)}"`)
          }
        }
      } else if (typeof university === 'string') {
        console.log(`   문자열 값: ${university.substring(0, 200)}`)
      } else if (university === null || university === undefined) {
        console.log(`   값: ${university}`)
      }

      // universityList 필드 확인
      const universityList = rawCareernet.universityList
      console.log(`\n2. universityList 필드:`)
      if (universityList) {
        console.log(`   ✅ 존재함, 배열 길이: ${Array.isArray(universityList) ? universityList.length : 'N/A'}`)
        if (Array.isArray(universityList) && universityList.length > 0) {
          console.log(`   첫 번째 항목: ${JSON.stringify(universityList[0], null, 2)}`)
        }
      } else {
        console.log(`   ❌ 없음 (undefined 또는 null)`)
      }

      // merged 데이터 확인
      const merged = apiData.merged
      if (merged) {
        console.log(`\n3. merged.universities 필드:`)
        if (merged.universities) {
          console.log(`   ✅ 존재함, 배열 길이: ${Array.isArray(merged.universities) ? merged.universities.length : 'N/A'}`)
          if (Array.isArray(merged.universities) && merged.universities.length > 0) {
            console.log(`   첫 번째 항목: ${JSON.stringify(merged.universities[0], null, 2)}`)
          }
        } else {
          console.log(`   ❌ 없음`)
        }
      }

    } catch (error) {
      console.error(`\n❌ ${row.name} 파싱 오류:`, error)
    }
  }
}

checkUniversityStructure().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

