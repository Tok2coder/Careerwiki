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

// Get major count
const countResult = await db.prepare('SELECT COUNT(*) as count FROM major_profiles').first()
console.log('📊 Total majors in database:', countResult?.count)

// Get sample major (간호학과)
const nursingResult = await db.prepare(
  'SELECT id, name, data_sources, LENGTH(api_data_json) as json_size FROM major_profiles WHERE name LIKE "%간호%"'
).first()

if (nursingResult) {
  console.log('\n✅ Sample major found:')
  console.log('  ID:', nursingResult.id)
  console.log('  Name:', nursingResult.name)
  console.log('  Sources:', nursingResult.data_sources)
  console.log('  JSON size:', nursingResult.json_size, 'bytes')
  
  // Get full JSON data
  const fullResult = await db.prepare(
    'SELECT api_data_json FROM major_profiles WHERE name LIKE "%간호%"'
  ).first()
  
  if (fullResult && fullResult.api_data_json) {
    const jsonData = JSON.parse(fullResult.api_data_json as string)
    console.log('\n📋 JSON data structure:')
    console.log('  Has CAREERNET data:', !!jsonData.CAREERNET)
    
    if (jsonData.CAREERNET) {
      const cn = jsonData.CAREERNET
      console.log('  - majorSeq:', cn.majorSeq)
      console.log('  - major:', cn.major)
      console.log('  - university (string):', typeof cn.university === 'string' && cn.university.length > 0 ? '✅ Yes (' + cn.university.split(',').length + ' universities)' : '❌ No')
      console.log('  - Has main_subject:', Array.isArray(cn.main_subject) && cn.main_subject.length > 0)
      console.log('  - Has relate_subject:', Array.isArray(cn.relate_subject) && cn.relate_subject.length > 0)
      console.log('  - Has career_act:', Array.isArray(cn.career_act) && cn.career_act.length > 0)
      console.log('  - Has chartData:', !!cn.chartData)
    }
  }
}

// Get recently updated majors
const recentResult = await db.prepare(
  'SELECT id, name, data_sources, updated_at FROM major_profiles ORDER BY updated_at DESC LIMIT 5'
).all()

console.log('\n🔄 Recently updated majors:')
recentResult.results.forEach((r: any) => {
  console.log(`  - ${r.name} (${r.id}) - ${r.data_sources}`)
})

process.exit(0)
