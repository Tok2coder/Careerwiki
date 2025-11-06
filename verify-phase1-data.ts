/**
 * Phase 1 필드 수집 검증 스크립트
 * D1에 저장된 데이터에서 Phase 1 필드들이 제대로 수집되었는지 확인
 */

import type { D1Database } from '@cloudflare/workers-types'

interface Env {
  DB: D1Database
}

async function verifyPhase1Data(env: Env) {
  console.log('🔍 Phase 1 필드 수집 검증 시작\n')
  
  // 1. 전체 전공 수 확인
  const totalResult = await env.DB.prepare('SELECT COUNT(*) as count FROM majors').first<{ count: number }>()
  const totalCount = totalResult?.count || 0
  console.log(`📊 총 저장된 전공 수: ${totalCount}개\n`)
  
  // 2. 랜덤 샘플 10개 선택
  const samples = await env.DB.prepare(`
    SELECT id, name, api_data_json 
    FROM majors 
    WHERE careernet_id IS NOT NULL
    ORDER BY RANDOM() 
    LIMIT 10
  `).all<{ id: string; name: string; api_data_json: string }>()
  
  if (!samples.results || samples.results.length === 0) {
    console.log('❌ 샘플 데이터를 찾을 수 없습니다')
    return
  }
  
  console.log(`📝 ${samples.results.length}개 샘플 검증 중...\n`)
  
  const stats = {
    total: samples.results.length,
    relateSubject: 0,
    careerAct: 0,
    mainSubject: 0,
    enterField: 0,
    property: 0,
    universityList: 0,
    chartData: 0,
    genCD: 0,
    schClass: 0,
    lstMiddleAptd: 0,
    lstHighAptd: 0,
    lstVals: 0
  }
  
  for (const sample of samples.results) {
    try {
      const apiData = JSON.parse(sample.api_data_json)
      const merged = apiData.merged
      
      console.log(`\n📌 ${sample.name} (ID: ${sample.id})`)
      
      // Phase 1 필드 확인
      if (merged.relateSubject && merged.relateSubject.length > 0) {
        stats.relateSubject++
        console.log(`   ✅ relateSubject: ${merged.relateSubject.length}개`)
      } else {
        console.log(`   ❌ relateSubject: 없음`)
      }
      
      if (merged.careerAct && merged.careerAct.length > 0) {
        stats.careerAct++
        console.log(`   ✅ careerAct: ${merged.careerAct.length}개`)
      } else {
        console.log(`   ❌ careerAct: 없음`)
      }
      
      if (merged.mainSubject && merged.mainSubject.length > 0) {
        stats.mainSubject++
        console.log(`   ✅ mainSubject: ${merged.mainSubject.length}개`)
      } else {
        console.log(`   ❌ mainSubject: 없음`)
      }
      
      if (merged.enterField && merged.enterField.length > 0) {
        stats.enterField++
        console.log(`   ✅ enterField: ${merged.enterField.length}개`)
      } else {
        console.log(`   ❌ enterField: 없음`)
      }
      
      if (merged.property) {
        stats.property++
        console.log(`   ✅ property: 있음`)
      } else {
        console.log(`   ❌ property: 없음`)
      }
      
      if (merged.universityList && merged.universityList.length > 0) {
        stats.universityList++
        console.log(`   ✅ universityList: ${merged.universityList.length}개`)
      } else {
        console.log(`   ⚠️  universityList: 없음 (예상된 동작)`)
      }
      
      if (merged.chartData) {
        stats.chartData++
        console.log(`   ✅ chartData: 있음`)
      } else {
        console.log(`   ❌ chartData: 없음`)
      }
      
      if (merged.genCD) {
        stats.genCD++
        console.log(`   ✅ genCD: 있음`)
      } else {
        console.log(`   ❌ genCD: 없음`)
      }
      
      if (merged.schClass) {
        stats.schClass++
        console.log(`   ✅ schClass: 있음`)
      } else {
        console.log(`   ❌ schClass: 없음`)
      }
      
      if (merged.lstMiddleAptd) {
        stats.lstMiddleAptd++
        console.log(`   ✅ lstMiddleAptd: 있음`)
      } else {
        console.log(`   ❌ lstMiddleAptd: 없음`)
      }
      
      if (merged.lstHighAptd) {
        stats.lstHighAptd++
        console.log(`   ✅ lstHighAptd: 있음`)
      } else {
        console.log(`   ❌ lstHighAptd: 없음`)
      }
      
      if (merged.lstVals) {
        stats.lstVals++
        console.log(`   ✅ lstVals: 있음`)
      } else {
        console.log(`   ❌ lstVals: 없음`)
      }
      
    } catch (error: any) {
      console.error(`   ❌ 파싱 오류: ${error.message}`)
    }
  }
  
  // 최종 통계
  console.log('\n' + '='.repeat(60))
  console.log('📊 Phase 1 필드 수집률 (샘플 기준)')
  console.log('='.repeat(60))
  const total = stats.total
  console.log(`relateSubject: ${stats.relateSubject}/${total} (${Math.round(stats.relateSubject / total * 100)}%)`)
  console.log(`careerAct: ${stats.careerAct}/${total} (${Math.round(stats.careerAct / total * 100)}%)`)
  console.log(`mainSubject: ${stats.mainSubject}/${total} (${Math.round(stats.mainSubject / total * 100)}%)`)
  console.log(`enterField: ${stats.enterField}/${total} (${Math.round(stats.enterField / total * 100)}%)`)
  console.log(`property: ${stats.property}/${total} (${Math.round(stats.property / total * 100)}%)`)
  console.log(`universityList: ${stats.universityList}/${total} (${Math.round(stats.universityList / total * 100)}%)`)
  console.log(`chartData: ${stats.chartData}/${total} (${Math.round(stats.chartData / total * 100)}%)`)
  console.log(`genCD: ${stats.genCD}/${total} (${Math.round(stats.genCD / total * 100)}%)`)
  console.log(`schClass: ${stats.schClass}/${total} (${Math.round(stats.schClass / total * 100)}%)`)
  console.log(`lstMiddleAptd: ${stats.lstMiddleAptd}/${total} (${Math.round(stats.lstMiddleAptd / total * 100)}%)`)
  console.log(`lstHighAptd: ${stats.lstHighAptd}/${total} (${Math.round(stats.lstHighAptd / total * 100)}%)`)
  console.log(`lstVals: ${stats.lstVals}/${total} (${Math.round(stats.lstVals / total * 100)}%)`)
  
  console.log('\n✅ 검증 완료!')
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

    await verifyPhase1Data(env)
    process.exit(0)
  } catch (error) {
    console.error('\n❌ 검증 실패:', error)
    process.exit(1)
  }
})()
