import { readFileSync } from 'fs'
import { resolve } from 'path'

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

console.log('🔍 Testing various methods to get ALL majors...\n')

const tests = [
  { name: 'Wildcard *', keyword: '*' },
  { name: 'Wildcard %', keyword: '%' },
  { name: 'Empty string', keyword: '' },
  { name: 'Space', keyword: ' ' },
  { name: 'Single char: 학', keyword: '학' },
  { name: 'Without keyword param', keyword: null }
]

async function testMethod(testCase: { name: string, keyword: string | null }) {
  const url = new URL('https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo213L01.do')
  url.searchParams.set('authKey', apiKey!)
  url.searchParams.set('returnType', 'XML')
  url.searchParams.set('target', 'MAJORCD')
  url.searchParams.set('srchType', 'K')
  if (testCase.keyword !== null) {
    url.searchParams.set('keyword', testCase.keyword)
  }
  
  try {
    const response = await fetch(url.toString())
    const xml = await response.text()
    
    // Check for error
    if (xml.includes('<code>-') || xml.includes('오류') || xml.includes('실패')) {
      const errorMatch = xml.match(/<message>([^<]+)<\/message>/)
      return {
        success: false,
        error: errorMatch ? errorMatch[1] : 'Unknown error',
        count: 0
      }
    }
    
    const totalMatch = xml.match(/<total>(\d+)<\/total>/)
    const total = totalMatch ? parseInt(totalMatch[1]) : 0
    const itemCount = (xml.match(/<majorList>/g) || []).length
    
    return {
      success: itemCount > 0,
      count: itemCount,
      total: total
    }
  } catch (error) {
    return {
      success: false,
      error: error instanceof Error ? error.message : String(error),
      count: 0
    }
  }
}

async function runTests() {
  for (const test of tests) {
    const result = await testMethod(test)
    const icon = result.success ? '✅' : '❌'
    console.log(`${icon} ${test.name}:`)
    if (result.success) {
      console.log(`   Found ${result.count} items (total: ${result.total})`)
    } else {
      console.log(`   Error: ${result.error || 'Failed'}`)
    }
    console.log('')
    await new Promise(resolve => setTimeout(resolve, 500))
  }
  
  process.exit(0)
}

runTests()
