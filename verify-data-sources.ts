/**
 * 데이터 소스 검증 스크립트
 * CareerNet과 Goyong24 양쪽 데이터가 모두 수집되고 있는지 확인
 */

import type { D1Database } from '@cloudflare/workers-types'

interface Env {
  DB: D1Database
}

async function verifyDataSources(env: Env) {
  console.log('🔍 데이터 소스 검증 시작\n')
  
  // 1. 전체 통계
  const totalResult = await env.DB.prepare('SELECT COUNT(*) as count FROM majors').first<{ count: number }>()
  const totalCount = totalResult?.count || 0
  console.log(`📊 총 저장된 전공 수: ${totalCount}개\n`)
  
  // 2. CareerNet 전공 수
  const careernetResult = await env.DB.prepare(
    'SELECT COUNT(*) as count FROM majors WHERE careernet_id IS NOT NULL'
  ).first<{ count: number }>()
  const careernetCount = careernetResult?.count || 0
  
  // 3. Goyong24 전공 수
  const goyong24Result = await env.DB.prepare(
    'SELECT COUNT(*) as count FROM majors WHERE goyong24_id IS NOT NULL'
  ).first<{ count: number }>()
  const goyong24Count = goyong24Result?.count || 0
  
  // 4. 양쪽 모두 있는 전공 수
  const bothResult = await env.DB.prepare(
    'SELECT COUNT(*) as count FROM majors WHERE careernet_id IS NOT NULL AND goyong24_id IS NOT NULL'
  ).first<{ count: number }>()
  const bothCount = bothResult?.count || 0
  
  console.log('📊 데이터 소스별 통계:')
  console.log('='.repeat(60))
  console.log(`CareerNet만: ${careernetCount - bothCount}개`)
  console.log(`Goyong24만: ${goyong24Count - bothCount}개`)
  console.log(`양쪽 모두: ${bothCount}개`)
  console.log(`총계: ${totalCount}개`)
  console.log('='.repeat(60))
  console.log(`CareerNet 비율: ${Math.round(careernetCount / totalCount * 100)}%`)
  console.log(`Goyong24 비율: ${Math.round(goyong24Count / totalCount * 100)}%`)
  console.log(`통합 데이터 비율: ${Math.round(bothCount / totalCount * 100)}%\n`)
  
  // 5. CareerNet 샘플 3개
  console.log('📝 CareerNet 샘플 (3개):')
  console.log('-'.repeat(60))
  const careernetSamples = await env.DB.prepare(`
    SELECT id, name, careernet_id, api_data_json 
    FROM majors 
    WHERE careernet_id IS NOT NULL
    ORDER BY RANDOM() 
    LIMIT 3
  `).all<{ id: string; name: string; careernet_id: string; api_data_json: string }>()
  
  for (const sample of careernetSamples.results || []) {
    try {
      const apiData = JSON.parse(sample.api_data_json)
      console.log(`\n${sample.name} (ID: ${sample.id})`)
      console.log(`  CareerNet ID: ${sample.careernet_id}`)
      console.log(`  Sources: ${apiData.sources?.join(', ') || '없음'}`)
      console.log(`  CareerNet 데이터: ${apiData.careernet ? '있음' : '없음'}`)
      console.log(`  Goyong24 데이터: ${apiData.goyong24 ? '있음' : '없음'}`)
      
      // CareerNet 주요 필드 확인
      if (apiData.careernet) {
        const cn = apiData.careernet
        console.log(`  CareerNet 필드:`)
        console.log(`    - major: ${cn.major ? '✅' : '❌'}`)
        console.log(`    - summary: ${cn.summary ? '✅' : '❌'}`)
        console.log(`    - relateSubject: ${cn.relate_subject ? '✅' : '❌'}`)
        console.log(`    - mainSubject: ${cn.main_subject ? '✅' : '❌'}`)
      }
    } catch (error: any) {
      console.error(`  ❌ 파싱 오류: ${error.message}`)
    }
  }
  
  // 6. Goyong24 샘플 3개
  console.log('\n\n📝 Goyong24 샘플 (3개):')
  console.log('-'.repeat(60))
  const goyong24Samples = await env.DB.prepare(`
    SELECT id, name, goyong24_id, api_data_json 
    FROM majors 
    WHERE goyong24_id IS NOT NULL
    ORDER BY RANDOM() 
    LIMIT 3
  `).all<{ id: string; name: string; goyong24_id: string; api_data_json: string }>()
  
  for (const sample of goyong24Samples.results || []) {
    try {
      const apiData = JSON.parse(sample.api_data_json)
      console.log(`\n${sample.name} (ID: ${sample.id})`)
      console.log(`  Goyong24 ID: ${sample.goyong24_id}`)
      console.log(`  Sources: ${apiData.sources?.join(', ') || '없음'}`)
      console.log(`  CareerNet 데이터: ${apiData.careernet ? '있음' : '없음'}`)
      console.log(`  Goyong24 데이터: ${apiData.goyong24 ? '있음' : '없음'}`)
      
      // Goyong24 주요 필드 확인
      if (apiData.goyong24) {
        const g24 = apiData.goyong24
        console.log(`  Goyong24 필드:`)
        console.log(`    - knowSchDptNm: ${g24.knowSchDptNm ? '✅' : '❌'}`)
        console.log(`    - jobDefinition: ${g24.jobDefinition ? '✅' : '❌'}`)
        console.log(`    - majorAbility: ${g24.majorAbility ? '✅' : '❌'}`)
        console.log(`    - jobPerformContent: ${g24.jobPerformContent ? '✅' : '❌'}`)
      }
    } catch (error: any) {
      console.error(`  ❌ 파싱 오류: ${error.message}`)
    }
  }
  
  // 7. 통합 데이터 샘플 3개 (양쪽 모두 있는 경우)
  console.log('\n\n📝 통합 데이터 샘플 (양쪽 모두 있는 경우, 3개):')
  console.log('-'.repeat(60))
  const bothSamples = await env.DB.prepare(`
    SELECT id, name, careernet_id, goyong24_id, api_data_json 
    FROM majors 
    WHERE careernet_id IS NOT NULL AND goyong24_id IS NOT NULL
    ORDER BY RANDOM() 
    LIMIT 3
  `).all<{ id: string; name: string; careernet_id: string; goyong24_id: string; api_data_json: string }>()
  
  for (const sample of bothSamples.results || []) {
    try {
      const apiData = JSON.parse(sample.api_data_json)
      console.log(`\n${sample.name} (ID: ${sample.id})`)
      console.log(`  CareerNet ID: ${sample.careernet_id}`)
      console.log(`  Goyong24 ID: ${sample.goyong24_id}`)
      console.log(`  Sources: ${apiData.sources?.join(', ') || '없음'}`)
      console.log(`  ✅ 양쪽 데이터 모두 수집됨`)
      
      // 통합된 데이터 필드 개수 비교
      const cnFieldCount = apiData.careernet ? Object.keys(apiData.careernet).length : 0
      const g24FieldCount = apiData.goyong24 ? Object.keys(apiData.goyong24).length : 0
      const mergedFieldCount = apiData.merged ? Object.keys(apiData.merged).length : 0
      
      console.log(`  필드 수:`)
      console.log(`    - CareerNet: ${cnFieldCount}개`)
      console.log(`    - Goyong24: ${g24FieldCount}개`)
      console.log(`    - 통합 (merged): ${mergedFieldCount}개`)
    } catch (error: any) {
      console.error(`  ❌ 파싱 오류: ${error.message}`)
    }
  }
  
  console.log('\n✅ 데이터 소스 검증 완료!')
}

// Main execution
;(async () => {
  try {
    const { Miniflare } = await import('miniflare')
    
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
      DB: db as any
    }

    await verifyDataSources(env)
    process.exit(0)
  } catch (error) {
    console.error('\n❌ 검증 실패:', error)
    process.exit(1)
  }
})()
