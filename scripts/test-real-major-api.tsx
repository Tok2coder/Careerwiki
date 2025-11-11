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

  // 실제로 데이터가 있는 전공 찾기
  const major = await db.prepare(`
    SELECT name, careernet_id, api_data_json
    FROM majors
    WHERE careernet_id IS NOT NULL 
      AND api_data_json IS NOT NULL
      AND json_extract(api_data_json, '$.careernet.summary') IS NOT NULL
    LIMIT 1
  `).first()

  if (!major) {
    console.log('❌ 데이터가 있는 전공 없음')
    return
  }

  const majorData = major as any
  console.log('=== 실제 데이터가 있는 전공 테스트 ===\n')
  console.log('전공명:', majorData.name)
  console.log('CareerNet ID:', majorData.careernet_id)
  
  // API 직접 호출 (현재 코드와 동일한 방식)
  const url = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi')
  url.searchParams.append('apiKey', API_KEY)
  url.searchParams.append('svcType', 'api')
  url.searchParams.append('svcCode', 'MAJOR_VIEW')
  url.searchParams.append('contentType', 'json')
  url.searchParams.append('gubun', 'univ_list')
  url.searchParams.append('majorSeq', majorData.careernet_id)
  
  console.log('\n요청 URL:', url.toString())
  console.log('\n응답 대기 중...\n')
  
  try {
    const response = await fetch(url.toString())
    const jsonData = await response.json()
    
    // 에러 체크
    if (jsonData.result?.content?.[0]?.code === '-7') {
      console.log('❌ API 오류:', jsonData.result.content[0].message)
      console.log('\n대안: XML 응답 테스트\n')
      
      // XML 응답 테스트
      const xmlUrl = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi.xml')
      xmlUrl.searchParams.append('apiKey', API_KEY)
      xmlUrl.searchParams.append('svcType', 'api')
      xmlUrl.searchParams.append('svcCode', 'MAJOR_VIEW')
      xmlUrl.searchParams.append('gubun', 'univ_list')
      xmlUrl.searchParams.append('majorSeq', majorData.careernet_id)
      
      const xmlResponse = await fetch(xmlUrl.toString())
      const xmlText = await xmlResponse.text()
      
      if (xmlText.includes('<content>') && !xmlText.includes('<code>-7</code>')) {
        console.log('✅ XML 응답 성공')
        
        // 필드 확인
        const fields = ['lstMiddleAptd', 'lstHighAptd', 'lstVals', 'chartData']
        fields.forEach(field => {
          const exists = xmlText.includes(`<${field}>`)
          console.log(`  ${exists ? '✅' : '❌'} ${field}`)
        })
        
        // XML 구조 샘플 출력
        console.log('\nXML 구조 샘플 (lstMiddleAptd 부분):')
        const match = xmlText.match(/<lstMiddleAptd>[\s\S]{0,1000}<\/lstMiddleAptd>/)
        if (match) {
          console.log(match[0])
        } else {
          console.log('  (필드 없음)')
        }
      } else {
        console.log('❌ XML 응답도 실패')
        console.log('응답:', xmlText.substring(0, 500))
      }
      return
    }
    
    const apiMajor = jsonData.dataSearch?.content?.[0]
    
    if (apiMajor) {
      console.log('✅ JSON 응답 성공')
      console.log('전공명:', apiMajor.major || apiMajor.mClass)
      
      const fields = ['lstMiddleAptd', 'lstHighAptd', 'lstVals', 'chartData']
      console.log('\n필드 존재 여부:')
      fields.forEach(field => {
        const exists = apiMajor[field] !== undefined && apiMajor[field] !== null
        const type = exists ? typeof apiMajor[field] : '없음'
        console.log(`  ${exists ? '✅' : '❌'} ${field}: ${type}`)
        
        if (exists) {
          if (typeof apiMajor[field] === 'object') {
            console.log(`    구조: ${Array.isArray(apiMajor[field]) ? '배열' : '객체'}`)
            if (typeof apiMajor[field] === 'object' && !Array.isArray(apiMajor[field])) {
              const keys = Object.keys(apiMajor[field])
              console.log(`    키: ${keys.join(', ')}`)
              if (keys.length > 0) {
                console.log(`    샘플: ${JSON.stringify(apiMajor[field][keys[0]], null, 2).substring(0, 200)}`)
              }
            }
          } else {
            console.log(`    값: ${String(apiMajor[field]).substring(0, 100)}`)
          }
        }
      })
    } else {
      console.log('❌ JSON 응답에 데이터 없음')
      console.log('응답 구조:', Object.keys(jsonData))
    }
  } catch (error: any) {
    console.error('❌ 오류:', error.message)
  }
}

main().catch(console.error)
