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

console.log('🔍 Analyzing Goyong24 API response for "과" keyword...\n')

fetchGoyong24MajorList({ 
  keyword: '과',
  srchType: 'K'
}, env)
  .then(response => {
    console.log('📊 Total items in response:', response.items.length)
    
    // Check unique IDs
    const uniqueIds = new Set<string>()
    const duplicateIds = new Map<string, number>()
    
    response.items.forEach(item => {
      if (item.empCurtState2Id) {
        if (uniqueIds.has(item.empCurtState2Id)) {
          duplicateIds.set(item.empCurtState2Id, (duplicateIds.get(item.empCurtState2Id) || 1) + 1)
        } else {
          uniqueIds.add(item.empCurtState2Id)
        }
      }
    })
    
    console.log('✅ Unique IDs:', uniqueIds.size)
    console.log('❌ Duplicate IDs:', duplicateIds.size)
    
    if (duplicateIds.size > 0) {
      console.log('\n🔍 Sample duplicates:')
      let count = 0
      for (const [id, occurrences] of duplicateIds.entries()) {
        if (count >= 5) break
        const item = response.items.find(i => i.empCurtState2Id === id)
        console.log(`  - ID ${id}: "${item?.knowSchDptNm}" (appears ${occurrences} times)`)
        count++
      }
    }
    
    console.log('\n📋 First 10 unique majors:')
    let shown = 0
    const seenInSample = new Set<string>()
    for (const item of response.items) {
      if (shown >= 10) break
      if (!item.empCurtState2Id || seenInSample.has(item.empCurtState2Id)) continue
      seenInSample.add(item.empCurtState2Id)
      console.log(`  ${shown + 1}. ${item.knowSchDptNm} (ID: ${item.empCurtState2Id}, majorGb: ${item.majorGb})`)
      shown++
    }
    
    process.exit(0)
  })
  .catch(error => {
    console.error('❌ Error:', error.message)
    process.exit(1)
  })
