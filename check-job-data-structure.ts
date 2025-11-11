/**
 * 직업 데이터 구조 확인
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

async function checkJobDataStructure() {
  console.log('🔍 직업 데이터 구조 확인\n')
  
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB')

  // 전체 직업 통계
  const totalResult = await db.prepare('SELECT COUNT(*) as count FROM jobs').first<{ count: number }>()
  const total = totalResult?.count || 0

  console.log(`📊 총 직업 수: ${total}개\n`)

  // 소스별 통계
  const careernetResult = await db.prepare(
    'SELECT COUNT(*) as count FROM jobs WHERE careernet_id IS NOT NULL'
  ).first<{ count: number }>()
  const careernetCount = careernetResult?.count || 0

  const goyong24Result = await db.prepare(
    'SELECT COUNT(*) as count FROM jobs WHERE goyong24_id IS NOT NULL'
  ).first<{ count: number }>()
  const goyong24Count = goyong24Result?.count || 0

  const bothResult = await db.prepare(
    'SELECT COUNT(*) as count FROM jobs WHERE careernet_id IS NOT NULL AND goyong24_id IS NOT NULL'
  ).first<{ count: number }>()
  const bothCount = bothResult?.count || 0

  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('소스별 통계:')
  console.log(`  - 커리어넷만: ${careernetCount}개`)
  console.log(`  - 고용24만: ${goyong24Count}개`)
  console.log(`  - 양쪽 모두: ${bothCount}개`)
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  // 샘플 데이터 확인 (각 소스별로 1개씩)
  console.log('샘플 데이터 확인:\n')

  // 커리어넷 직업 샘플
  const careernetSample = await db.prepare(`
    SELECT id, name, careernet_id, goyong24_id, api_data_json
    FROM jobs
    WHERE careernet_id IS NOT NULL
    LIMIT 1
  `).first<{ id: string; name: string; careernet_id: string; goyong24_id: string | null; api_data_json: string }>()

  if (careernetSample) {
    console.log('1️⃣ 커리어넷 직업 샘플:')
    console.log(`   ID: ${careernetSample.id}`)
    console.log(`   이름: ${careernetSample.name}`)
    console.log(`   careernet_id: ${careernetSample.careernet_id}`)
    console.log(`   goyong24_id: ${careernetSample.goyong24_id || 'N/A'}`)
    
    try {
      const apiData = JSON.parse(careernetSample.api_data_json)
      console.log(`   API 데이터 키: ${Object.keys(apiData).join(', ')}`)
      console.log(`   sources: ${JSON.stringify(apiData.sources)}`)
      
      // 전체 샘플 저장
      const fs = await import('fs')
      const outputPath = resolve(process.cwd(), `sample-careernet-job.json`)
      fs.writeFileSync(outputPath, JSON.stringify({
        id: careernetSample.id,
        name: careernetSample.name,
        careernet_id: careernetSample.careernet_id,
        goyong24_id: careernetSample.goyong24_id,
        apiData: apiData
      }, null, 2))
      console.log(`   💾 샘플 저장: ${outputPath}`)
    } catch (e) {
      console.error(`   ❌ 데이터 파싱 오류:`, e)
    }
    console.log('')
  }

  // 고용24 직업 샘플
  const goyong24Sample = await db.prepare(`
    SELECT id, name, careernet_id, goyong24_id, api_data_json
    FROM jobs
    WHERE goyong24_id IS NOT NULL
    LIMIT 1
  `).first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string; api_data_json: string }>()

  if (goyong24Sample) {
    console.log('2️⃣ 고용24 직업 샘플:')
    console.log(`   ID: ${goyong24Sample.id}`)
    console.log(`   이름: ${goyong24Sample.name}`)
    console.log(`   careernet_id: ${goyong24Sample.careernet_id || 'N/A'}`)
    console.log(`   goyong24_id: ${goyong24Sample.goyong24_id}`)
    
    try {
      const apiData = JSON.parse(goyong24Sample.api_data_json)
      console.log(`   API 데이터 키: ${Object.keys(apiData).join(', ')}`)
      console.log(`   sources: ${JSON.stringify(apiData.sources)}`)
      
      // 전체 샘플 저장
      const fs = await import('fs')
      const outputPath = resolve(process.cwd(), `sample-goyong24-job.json`)
      fs.writeFileSync(outputPath, JSON.stringify({
        id: goyong24Sample.id,
        name: goyong24Sample.name,
        careernet_id: goyong24Sample.careernet_id,
        goyong24_id: goyong24Sample.goyong24_id,
        apiData: apiData
      }, null, 2))
      console.log(`   💾 샘플 저장: ${outputPath}`)
    } catch (e) {
      console.error(`   ❌ 데이터 파싱 오류:`, e)
    }
    console.log('')
  }

  console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log('💡 결론:')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  
  if (bothCount === 0) {
    console.log('\n⚠️  양쪽 소스 모두 있는 직업이 0개입니다.')
    console.log('   → 현재는 커리어넷 OR 고용24 데이터만 각각 저장됨')
    console.log('   → 같은 직업명 기반 자동 매칭 로직이 필요함')
  } else {
    console.log(`\n✅ 양쪽 소스 모두 있는 직업: ${bothCount}개`)
  }
}

checkJobDataStructure().catch(error => {
  console.error('\n❌ 스크립트 실행 실패:', error)
  process.exit(1)
})

