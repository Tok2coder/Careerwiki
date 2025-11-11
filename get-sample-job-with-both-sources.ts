/**
 * 커리어넷 + 고용24 둘 다 데이터가 있는 직업 샘플 추출
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

async function getSampleJob() {
  console.log('🔍 커리어넷 + 고용24 데이터 모두 있는 직업 샘플 추출\n')
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB')

  // 양쪽 소스 모두 있는 직업 찾기
  const bothSourcesJobs = await db.prepare(`
    SELECT id, name, careernet_id, goyong24_id, api_data_json
    FROM jobs
    WHERE careernet_id IS NOT NULL
    AND goyong24_id IS NOT NULL
    AND api_data_json IS NOT NULL
    LIMIT 5
  `).all<{ id: string; name: string; careernet_id: string; goyong24_id: string; api_data_json: string }>()

  if (!bothSourcesJobs.results || bothSourcesJobs.results.length === 0) {
    console.log('❌ 양쪽 소스 모두 있는 직업을 찾을 수 없습니다.')
    return
  }

  console.log(`📊 양쪽 소스 모두 있는 직업: ${bothSourcesJobs.results.length}개\n`)

  for (const job of bothSourcesJobs.results) {
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    console.log(`📋 직업: ${job.name}`)
    console.log(`   ID: ${job.id}`)
    console.log(`   커리어넷 ID: ${job.careernet_id}`)
    console.log(`   고용24 ID: ${job.goyong24_id}`)
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

    try {
      const apiData = JSON.parse(job.api_data_json)
      
      console.log('1️⃣ 커리어넷 데이터:')
      if (apiData.careernet) {
        console.log(`   - 직업명: ${apiData.careernet.jobNm || 'N/A'}`)
        console.log(`   - 하는 일: ${apiData.careernet.summary?.substring(0, 100) || 'N/A'}...`)
        console.log(`   - 필요 능력: ${apiData.careernet.ability?.substring(0, 80) || 'N/A'}...`)
        console.log(`   - 전망: ${apiData.careernet.prospect?.substring(0, 80) || 'N/A'}...`)
      } else {
        console.log('   ❌ 데이터 없음')
      }

      console.log('\n2️⃣ 고용24 데이터:')
      if (apiData.goyong24) {
        console.log(`   - 직업명: ${apiData.goyong24.jobNm || 'N/A'}`)
        console.log(`   - 직무개요: ${apiData.goyong24.jobDef?.substring(0, 100) || 'N/A'}...`)
        console.log(`   - 수행직무: ${apiData.goyong24.job?.substring(0, 80) || 'N/A'}...`)
        console.log(`   - 관련학과: ${apiData.goyong24.relatedDept?.substring(0, 80) || 'N/A'}...`)
      } else {
        console.log('   ❌ 데이터 없음')
      }

      console.log('\n3️⃣ 병합된 데이터 (merged):')
      if (apiData.merged) {
        console.log(`   - 직업명: ${apiData.merged.jobNm || 'N/A'}`)
        console.log(`   - Summary: ${apiData.merged.summary?.substring(0, 100) || 'N/A'}...`)
        console.log(`   - 능력: ${apiData.merged.ability?.substring(0, 80) || 'N/A'}...`)
        console.log(`   - 직무개요: ${apiData.merged.jobDef?.substring(0, 80) || 'N/A'}...`)
      } else {
        console.log('   ❌ 데이터 없음')
      }

      console.log('\n4️⃣ 데이터 소스:')
      console.log(`   sources: ${JSON.stringify(apiData.sources)}`)

      // 전체 API 데이터 출력 (JSON 파일로 저장)
      const fs = await import('fs')
      const outputPath = resolve(process.cwd(), `sample-job-${job.name.replace(/[^a-zA-Z0-9가-힣]/g, '_')}.json`)
      fs.writeFileSync(outputPath, JSON.stringify({
        id: job.id,
        name: job.name,
        careernet_id: job.careernet_id,
        goyong24_id: job.goyong24_id,
        apiData: apiData
      }, null, 2))
      console.log(`\n💾 전체 데이터 저장: ${outputPath}`)

      console.log('\n')
    } catch (error) {
      console.error(`   ❌ 데이터 파싱 오류:`, error)
    }
  }
}

getSampleJob().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

