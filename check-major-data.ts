import { readFileSync } from 'fs'
import { resolve } from 'path'
import { Miniflare } from 'miniflare'
import type { D1Database } from '@cloudflare/workers-types'

// .dev.vars 파일에서 환경 변수 로드
try {
  const devVarsPath = resolve(process.cwd(), '.dev.vars')
  const devVars = readFileSync(devVarsPath, 'utf-8')
  devVars.split('\n').forEach(line => {
    const trimmed = line.trim()
    if (trimmed && !trimmed.startsWith('#')) {
      const [key, ...valueParts] = trimmed.split('=')
      if (key && valueParts.length) {
        process.env[key.trim()] = valueParts.join('=').trim()
      }
    }
  })
} catch (error) {
  console.warn('⚠️  .dev.vars 파일을 읽을 수 없습니다:', (error as Error).message)
}

async function checkMajorData() {
  const mf = new Miniflare({
    script: '',
    modules: true,
    d1Databases: ['DB'],
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = await mf.getD1Database('DB') as D1Database
  
  const majors = ['항공여행과', '한국어과', '작곡과']
  
  for (const name of majors) {
    console.log(`\n==================== ${name} ====================`)
    
    const result = await db
      .prepare(`SELECT id, name, careernet_id, goyong24_id, api_data_json FROM majors WHERE name LIKE ? LIMIT 1`)
      .bind(`%${name}%`)
      .first()
    
    if (!result) {
      console.log(`❌ ${name} 데이터 없음`)
      continue
    }
    
    console.log(`✅ D1 ID: ${result.id}`)
    console.log(`   이름: ${result.name}`)
    console.log(`   CareerNet ID: ${result.careernet_id || '없음'}`)
    console.log(`   Goyong24 ID: ${result.goyong24_id || '없음'}`)
    
    if (result.api_data_json) {
      const apiData = JSON.parse(result.api_data_json as string)
      console.log(`\n📊 API 데이터 구조:`)
      console.log(`   - careernet: ${apiData.careernet ? '✅ 있음' : '❌ 없음'}`)
      console.log(`   - goyong24: ${apiData.goyong24 ? '✅ 있음' : '❌ 없음'}`)
      
      if (apiData.careernet) {
        console.log(`   - CareerNet 필드 수: ${Object.keys(apiData.careernet).length}`)
      }
      
      if (apiData.goyong24) {
        console.log(`   - Goyong24 필드 수: ${Object.keys(apiData.goyong24).length}`)
      }
    } else {
      console.log(`❌ api_data_json 없음`)
    }
  }
}

checkMajorData().catch(console.error)

