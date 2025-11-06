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

console.log('🔬 Testing different srchType values...\n')

const srchTypes = ['K', 'N', 'A', 'ALL', '', 'C', 'D']

async function testSrchType(srchType: string, keyword: string = '공학') {
  const url = new URL('https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo213L01.do')
  url.searchParams.set('authKey', apiKey!)
  url.searchParams.set('returnType', 'XML')
  url.searchParams.set('target', 'MAJORCD')
  if (srchType) url.searchParams.set('srchType', srchType)
  url.searchParams.set('keyword', keyword)
  
  try {
    const response = await fetch(url.toString())
    const xml = await response.text()
    
    // Count results
    const totalMatch = xml.match(/<total>(\d+)<\/total>/)
    const total = totalMatch ? parseInt(totalMatch[1]) : 0
    
    // Count majorList items
    const itemCount = (xml.match(/<majorList>/g) || []).length
    
    return {
      srchType: srchType || '(empty)',
      keyword,
      status: response.status,
      total,
      itemCount,
      success: response.ok && itemCount > 0
    }
  } catch (error) {
    return {
      srchType: srchType || '(empty)',
      keyword,
      status: 0,
      total: 0,
      itemCount: 0,
      success: false,
      error: error instanceof Error ? error.message : String(error)
    }
  }
}

async function runTests() {
  console.log('📋 Testing with keyword "공학":\n')
  
  for (const srchType of srchTypes) {
    const result = await testSrchType(srchType, '공학')
    const icon = result.success ? '✅' : '❌'
    console.log(`${icon} srchType="${result.srchType}": ${result.itemCount} items (total: ${result.total})`)
    if (result.error) {
      console.log(`   Error: ${result.error}`)
    }
    await new Promise(resolve => setTimeout(resolve, 300))
  }
  
  // Test with very common single characters
  console.log('\n📋 Testing with single character keywords:\n')
  const singleChars = ['학', '과', '공', '대', '부']
  
  for (const char of singleChars) {
    const result = await testSrchType('K', char)
    const icon = result.success ? '✅' : '❌'
    console.log(`${icon} keyword="${char}": ${result.itemCount} items (total: ${result.total})`)
    await new Promise(resolve => setTimeout(resolve, 300))
  }
  
  process.exit(0)
}

runTests()
