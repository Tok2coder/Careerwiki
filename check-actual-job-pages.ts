/**
 * 실제 직업 페이지 데이터 확인
 * 같은 이름의 직업이 어떻게 저장/처리되는지 확인
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

async function checkActualJobPages() {
  console.log('🔍 실제 직업 페이지 데이터 확인\n')
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB')

  // "기업고위임원" 직업 확인
  const jobName = '기업고위임원'
  console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
  console.log(`테스트 직업: ${jobName}`)
  console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n`)

  const jobs = await db.prepare(`
    SELECT id, name, careernet_id, goyong24_id, api_data_json
    FROM jobs
    WHERE name = ?
  `).bind(jobName).all<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null; api_data_json: string }>()

  console.log(`📊 "${jobName}" 검색 결과: ${jobs.results?.length || 0}개 레코드\n`)

  if (!jobs.results || jobs.results.length === 0) {
    console.log('❌ 해당 직업을 찾을 수 없습니다.')
    return
  }

  for (let i = 0; i < jobs.results.length; i++) {
    const job = jobs.results[i]
    console.log(`레코드 ${i + 1}:`)
    console.log(`  ID: ${job.id}`)
    console.log(`  이름: ${job.name}`)
    console.log(`  careernet_id: ${job.careernet_id || 'NULL'}`)
    console.log(`  goyong24_id: ${job.goyong24_id || 'NULL'}`)
    
    try {
      const apiData = JSON.parse(job.api_data_json)
      
      console.log(`\n  📦 api_data_json 구조:`)
      console.log(`     - 최상위 키: ${Object.keys(apiData).join(', ')}`)
      console.log(`     - sources: ${JSON.stringify(apiData.sources)}`)
      
      if (apiData.careernet) {
        console.log(`\n     ✅ careernet 데이터 존재`)
        console.log(`        - jobNm: ${apiData.careernet.jobNm || 'N/A'}`)
        console.log(`        - summary: ${apiData.careernet.summary?.substring(0, 80) || 'N/A'}...`)
      } else {
        console.log(`\n     ❌ careernet 데이터 없음`)
      }
      
      if (apiData.goyong24) {
        console.log(`\n     ✅ goyong24 데이터 존재`)
        console.log(`        - jobNm: ${apiData.goyong24.jobNm || 'N/A'}`)
        console.log(`        - jobDef: ${apiData.goyong24.jobDef?.substring(0, 80) || 'N/A'}...`)
        console.log(`        - 만족도: ${apiData.goyong24.salProspect?.jobSatis || 'N/A'}`)
      } else {
        console.log(`\n     ❌ goyong24 데이터 없음`)
      }
      
      if (apiData.merged) {
        console.log(`\n     ✅ merged 데이터 존재`)
        console.log(`        - jobNm: ${apiData.merged.jobNm || 'N/A'}`)
        console.log(`        - summary: ${apiData.merged.summary?.substring(0, 80) || 'N/A'}...`)
      } else {
        console.log(`\n     ❌ merged 데이터 없음`)
      }
      
    } catch (error) {
      console.error(`  ❌ JSON 파싱 오류:`, error)
    }
    
    console.log('\n')
  }

  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('💡 결론')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  if (jobs.results.length === 1) {
    const job = jobs.results[0]
    const hasBothIds = job.careernet_id && job.goyong24_id
    
    if (hasBothIds) {
      console.log('✅ 하나의 레코드에 양쪽 ID가 모두 있음')
      console.log('   → 이미 병합된 상태로 저장되어 있음')
      console.log('   → 추가 병합 작업 불필요')
    } else {
      console.log('⚠️  하나의 레코드에 한쪽 소스만 있음')
      console.log('   → 다른 소스와 병합 필요')
    }
  } else if (jobs.results.length === 2) {
    console.log('⚠️  같은 이름의 직업이 2개의 레코드로 분리되어 있음')
    console.log('   → 런타임 병합 또는 D1 재구성 필요')
  } else {
    console.log(`⚠️  예상치 못한 상황: ${jobs.results.length}개 레코드`)
  }
}

checkActualJobPages().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

