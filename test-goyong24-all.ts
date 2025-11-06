import { readFileSync } from 'fs'
import { resolve } from 'path'
import { fetchGoyong24MajorList } from './src/api/goyong24API'

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

const env = {
  GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY
}

console.log('🔑 Testing Goyong24 API...\n')

// Test 1: Empty keyword
console.log('📋 Test 1: Empty keyword (전체 조회 시도)')
fetchGoyong24MajorList({ 
  keyword: '',
  srchType: 'K'
}, env)
  .then(response => {
    console.log('✅ Success!')
    console.log('   Total items:', response.items.length)
    if (response.items.length > 0) {
      console.log('   First item:', response.items[0].knowSchDptNm)
    }
  })
  .catch(error => {
    console.log('❌ Failed:', error.message)
  })
  .finally(async () => {
    // Wait a bit
    await new Promise(resolve => setTimeout(resolve, 1000))
    
    // Test 2: Without keyword parameter
    console.log('\n📋 Test 2: Without keyword parameter')
    fetchGoyong24MajorList({ 
      srchType: 'K'
    }, env)
      .then(response => {
        console.log('✅ Success!')
        console.log('   Total items:', response.items.length)
        if (response.items.length > 0) {
          console.log('   First 5 items:')
          response.items.slice(0, 5).forEach((item: any, idx: number) => {
            console.log(`   ${idx + 1}. ${item.knowSchDptNm} (${item.empCurtState2Id})`)
          })
        }
      })
      .catch(error => {
        console.log('❌ Failed:', error.message)
      })
      .finally(() => {
        process.exit(0)
      })
  })
