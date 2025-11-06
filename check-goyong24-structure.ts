import { readFileSync } from 'fs'
import { resolve } from 'path'

// Load .dev.vars
const envPath = resolve(process.cwd(), '.dev.vars')
const envContent = readFileSync(envPath, 'utf-8')
envContent.split('\n').forEach(line => {
  const trimmed = line.trim()
  if (trimmed && !trimmed.startsWith('#')) {
    const [key, ...valueParts] = trimmed.split('=')
    if (key && valueParts.length > 0) {
      process.env[key.trim()] = valueParts.join('=').trim()
    }
  }
})

const apiKey = process.env.GOYONG24_MAJOR_API_KEY

console.log('🔍 Checking raw XML response structure...\n')

const url = new URL('https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo213L01.do')
url.searchParams.set('authKey', apiKey!)
url.searchParams.set('returnType', 'XML')
url.searchParams.set('target', 'MAJORCD')
url.searchParams.set('srchType', 'K')
url.searchParams.set('keyword', '컴퓨터')

fetch(url.toString())
  .then(async response => {
    const xml = await response.text()
    
    // Extract first 3 majorList items
    const items = xml.match(/<majorList>[\s\S]*?<\/majorList>/g) || []
    
    console.log('📊 Total items:', items.length)
    console.log('\n📋 First 3 items (full XML):\n')
    
    items.slice(0, 3).forEach((item, idx) => {
      console.log(`--- Item ${idx + 1} ---`)
      console.log(item)
      console.log('')
    })
    
    process.exit(0)
  })
  .catch(error => {
    console.error('❌ Error:', error.message)
    process.exit(1)
  })
