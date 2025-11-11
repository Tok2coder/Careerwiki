import type { D1Database } from '@cloudflare/workers-types'
import { readFileSync } from 'fs'
import { resolve, dirname } from 'path'
import { fileURLToPath } from 'url'
import { Miniflare } from 'miniflare'

async function main() {
  const __filename = fileURLToPath(import.meta.url)
  const projectRoot = resolve(dirname(__filename), '..')

  const devVarsPath = resolve(projectRoot, '.dev.vars')
  try {
    const content = readFileSync(devVarsPath, 'utf-8')
    content.split('\n').forEach((line) => {
      const trimmed = line.trim()
      if (!trimmed || trimmed.startsWith('#')) return
      const [key, ...valueParts] = trimmed.split('=')
      if (!key || valueParts.length === 0) return
      process.env[key.trim()] = valueParts.join('=').trim()
    })
  } catch {}

  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: resolve(projectRoot, '.wrangler', 'state', 'v3', 'd1')
  })

  const db = (await mf.getD1Database('DB')) as unknown as D1Database

  // CareerNet 전공 하나 찾기
  const major = await db.prepare(`
    SELECT name, careernet_id, api_data_json
    FROM majors
    WHERE careernet_id IS NOT NULL
    LIMIT 1
  `).first()

  if (!major) {
    console.log('❌ CareerNet 전공 없음')
    return
  }

  const majorData = major as any
  console.log('전공명:', majorData.name)
  console.log('CareerNet ID:', majorData.careernet_id)
  
  const apiData = JSON.parse(majorData.api_data_json || '{}')
  const careernet = apiData.careernet || {}
  
  console.log('\n=== D1에 저장된 CareerNet 필드 확인 ===\n')
  const fields = ['lstMiddleAptd', 'lstHighAptd', 'lstVals', 'chartData']
  fields.forEach(field => {
    const exists = careernet[field] !== undefined && careernet[field] !== null
    console.log(`${exists ? '✅' : '❌'} ${field}: ${exists ? '있음' : '없음'}`)
  })
  
  // API 직접 호출 테스트
  const API_KEY = process.env.CAREER_NET_API_KEY || 'd9e0285190fde074bef30031f17f669e'
  const url = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi')
  url.searchParams.append('apiKey', API_KEY)
  url.searchParams.append('svcType', 'api')
  url.searchParams.append('svcCode', 'MAJOR_VIEW')
  url.searchParams.append('contentType', 'json')
  url.searchParams.append('gubun', 'univ_list')
  url.searchParams.append('majorSeq', majorData.careernet_id)
  
  console.log('\n=== API 직접 호출 테스트 ===\n')
  console.log('URL:', url.toString())
  
  const response = await fetch(url.toString())
  const jsonData = await response.json()
  const apiMajor = jsonData.dataSearch?.content?.[0]
  
  if (apiMajor) {
    console.log('\n✅ API 응답 성공')
    console.log('전공명:', apiMajor.major || apiMajor.mClass)
    console.log('\n필드 존재 여부:')
    fields.forEach(field => {
      const exists = apiMajor[field] !== undefined && apiMajor[field] !== null
      console.log(`  ${exists ? '✅' : '❌'} ${field}`)
    })
  } else {
    console.log('❌ API 응답에 전공 데이터 없음')
    console.log('응답:', JSON.stringify(jsonData, null, 2).substring(0, 500))
  }
}

main().catch(console.error)
