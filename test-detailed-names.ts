import { readFileSync } from 'fs'
import { resolve } from 'path'
import { fetchGoyong24MajorList } from './src/api/goyong24API'

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

console.log('🔍 Testing with detailed major names (knowDtlSchDptNm)...\n')

fetchGoyong24MajorList({ 
  keyword: '과',
  srchType: 'K'
}, env)
  .then(response => {
    const seenDetailed = new Set<string>()
    const seenStandard = new Set<string>()
    
    response.items.forEach(item => {
      if (item.knowDtlSchDptNm) {
        seenDetailed.add(item.knowDtlSchDptNm)
      }
      if (item.knowSchDptNm) {
        seenStandard.add(item.knowSchDptNm)
      }
    })
    
    console.log('📊 Results for keyword "과":')
    console.log('   Total API responses:', response.items.length)
    console.log('   Unique detailed names (knowDtlSchDptNm):', seenDetailed.size)
    console.log('   Unique standard names (knowSchDptNm):', seenStandard.size)
    
    console.log('\n📋 Sample detailed names (first 15):')
    let count = 0
    for (const name of seenDetailed) {
      if (count >= 15) break
      console.log(`   ${count + 1}. ${name}`)
      count++
    }
    
    console.log('\n🎯 Improvement:', seenDetailed.size - seenStandard.size, 'more majors!')
    
    process.exit(0)
  })
  .catch(error => {
    console.error('❌ Error:', error.message)
    process.exit(1)
  })
