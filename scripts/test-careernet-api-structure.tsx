import { readFileSync } from 'fs'
import { resolve, dirname } from 'path'
import { fileURLToPath } from 'url'
import type { D1Database } from '@cloudflare/workers-types'
import { Miniflare } from 'miniflare'

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

const API_KEY = process.env.CAREER_NET_API_KEY || 'd9e0285190fde074bef30031f17f669e'

async function testApiResponse(majorSeq: string) {
  console.log(`\n=== 전공 코드: ${majorSeq} ===\n`)
  
  // JSON 응답 테스트
  console.log('1. JSON 응답 테스트')
  const jsonUrl = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi')
  jsonUrl.searchParams.append('apiKey', API_KEY)
  jsonUrl.searchParams.append('svcType', 'api')
  jsonUrl.searchParams.append('svcCode', 'MAJOR_VIEW')
  jsonUrl.searchParams.append('contentType', 'json')
  jsonUrl.searchParams.append('gubun', '대학교')
  jsonUrl.searchParams.append('majorSeq', majorSeq)
  
  try {
    const jsonResponse = await fetch(jsonUrl.toString())
    const jsonData = await jsonResponse.json()
    const jsonMajor = jsonData.dataSearch?.content?.[0]
    
    if (jsonMajor) {
      console.log('  ✅ JSON 응답 성공')
      console.log('  전공명:', jsonMajor.major || jsonMajor.mClass)
      const fields = ['lstMiddleAptd', 'lstHighAptd', 'lstVals', 'chartData']
      fields.forEach(field => {
        const exists = jsonMajor[field] !== undefined && jsonMajor[field] !== null
        console.log(`    ${exists ? '✅' : '❌'} ${field}`)
        if (exists && typeof jsonMajor[field] === 'object') {
          console.log(`      타입: ${Array.isArray(jsonMajor[field]) ? '배열' : '객체'}`)
          if (typeof jsonMajor[field] === 'object') {
            console.log(`      키: ${Object.keys(jsonMajor[field]).join(', ')}`)
          }
        }
      })
    } else {
      console.log('  ❌ JSON 응답에 데이터 없음')
      console.log('  응답:', JSON.stringify(jsonData, null, 2).substring(0, 300))
    }
  } catch (error: any) {
    console.log('  ❌ JSON 오류:', error.message)
  }
  
  // XML 응답 테스트
  console.log('\n2. XML 응답 테스트')
  const xmlUrl = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi.xml')
  xmlUrl.searchParams.append('apiKey', API_KEY)
  xmlUrl.searchParams.append('svcType', 'api')
  xmlUrl.searchParams.append('svcCode', 'MAJOR_VIEW')
  xmlUrl.searchParams.append('gubun', '대학교')
  xmlUrl.searchParams.append('majorSeq', majorSeq)
  
  try {
    const xmlResponse = await fetch(xmlUrl.toString())
    const xmlText = await xmlResponse.text()
    
    if (xmlText.includes('<content>')) {
      console.log('  ✅ XML 응답 성공')
      
      // 필드 존재 여부 확인
      const fields = ['lstMiddleAptd', 'lstHighAptd', 'lstVals', 'chartData']
      fields.forEach(field => {
        const exists = xmlText.includes(`<${field}>`) || xmlText.includes(`<${field.toLowerCase()}>`)
        console.log(`    ${exists ? '✅' : '❌'} ${field}`)
      })
      
      // 샘플 XML 출력 (처음 2000자)
      console.log('\n  XML 샘플 (처음 2000자):')
      console.log(xmlText.substring(0, 2000))
    } else {
      console.log('  ❌ XML 응답에 content 없음')
      console.log('  응답:', xmlText.substring(0, 500))
    }
  } catch (error: any) {
    console.log('  ❌ XML 오류:', error.message)
  }
}

async function main() {
  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: resolve(projectRoot, '.wrangler', 'state', 'v3', 'd1')
  })

  const db = (await mf.getD1Database('DB')) as unknown as D1Database

  // 여러 전공 코드 테스트
  const majors = await db.prepare(`
    SELECT DISTINCT careernet_id
    FROM majors
    WHERE careernet_id IS NOT NULL
    LIMIT 5
  `).all()

  console.log('=== CareerNet API 응답 구조 확인 ===')
  console.log(`테스트할 전공 수: ${majors.results?.length || 0}\n`)

  for (const row of majors.results || []) {
    const majorSeq = (row as any).careernet_id
    if (majorSeq) {
      await testApiResponse(majorSeq)
      await new Promise(resolve => setTimeout(resolve, 1000)) // API 호출 간격
    }
  }
}

main().catch(console.error)
