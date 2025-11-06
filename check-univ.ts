import { Miniflare } from 'miniflare'

const mf = new Miniflare({
  modules: true,
  script: '',
  d1Databases: {
    DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
  },
  d1Persist: './.wrangler/state/v3/d1'
})

const db = await mf.getD1Database('DB')

const result = await db.prepare('SELECT api_data_json FROM majors WHERE name = ?').bind('간호학과').first()

if (result && result.api_data_json) {
  const jsonData = JSON.parse(result.api_data_json as string)
  const merged = jsonData.merged
  
  console.log('🏫 University Data Structure:\n')
  console.log('Total universities:', merged.universities ? merged.universities.length : 0)
  
  if (merged.universities && merged.universities.length > 0) {
    console.log('\nFirst 3 university objects:')
    merged.universities.slice(0, 3).forEach((univ: any, idx: number) => {
      console.log(`\n${idx + 1}. University:`)
      console.log('   Type:', typeof univ)
      if (typeof univ === 'object') {
        console.log('   Keys:', Object.keys(univ))
        console.log('   schoolName:', univ.schoolName)
        console.log('   Full data:', JSON.stringify(univ))
      } else {
        console.log('   Value:', univ)
      }
    })
  }
  
  // Check if careernet raw data exists
  console.log('\n\n🔍 Checking for raw careernet data:')
  const keys = Object.keys(jsonData)
  console.log('JSON Data top-level keys:', keys)
  
  // Try accessing different possible structures
  if (jsonData.sources && jsonData.sources.CAREERNET) {
    console.log('\n✅ CAREERNET source info:', jsonData.sources.CAREERNET)
  }
} else {
  console.log('❌ No data found')
}

process.exit(0)
