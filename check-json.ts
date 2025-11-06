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
  
  console.log('✅ JSON Data Structure for 간호학과:')
  console.log('\n1️⃣ Top-level keys:', Object.keys(jsonData))
  
  if (jsonData.CAREERNET) {
    const cn = jsonData.CAREERNET
    console.log('\n2️⃣ CAREERNET data:')
    console.log('  - majorSeq:', cn.majorSeq)
    console.log('  - major:', cn.major)
    console.log('  - university type:', typeof cn.university)
    console.log('  - university value:', cn.university ? cn.university.substring(0, 100) + '...' : 'null')
    console.log('  - Number of universities:', cn.university ? cn.university.split(',').length : 0)
    
    console.log('\n3️⃣ Rich data fields:')
    console.log('  - main_subject:', Array.isArray(cn.main_subject) ? `Array(${cn.main_subject.length})` : typeof cn.main_subject)
    console.log('  - relate_subject:', Array.isArray(cn.relate_subject) ? `Array(${cn.relate_subject.length})` : typeof cn.relate_subject)
    console.log('  - career_act:', Array.isArray(cn.career_act) ? `Array(${cn.career_act.length})` : typeof cn.career_act)
    console.log('  - university (original array):', Array.isArray(cn.university) ? `Array(${cn.university.length})` : 'converted to string ✅')
    console.log('  - chartData:', cn.chartData ? 'Object ✅' : 'null')
    
    if (cn.main_subject && cn.main_subject.length > 0) {
      console.log('\n4️⃣ Sample main_subject:')
      console.log('  -', JSON.stringify(cn.main_subject[0]))
    }
    
    if (cn.chartData) {
      console.log('\n5️⃣ chartData keys:', Object.keys(cn.chartData))
    }
  }
  
  if (jsonData.GOYONG24) {
    console.log('\n6️⃣ GOYONG24 data:', 'exists ✅')
  }
} else {
  console.log('❌ No data found')
}

process.exit(0)
