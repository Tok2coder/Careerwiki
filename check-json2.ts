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
  console.log('2️⃣ Sources:', jsonData.sources)
  
  if (jsonData.careernet) {
    const cn = jsonData.careernet
    console.log('\n3️⃣ careernet data:')
    console.log('  - majorSeq:', cn.majorSeq)
    console.log('  - major:', cn.major)
    console.log('  - university type:', typeof cn.university)
    
    if (typeof cn.university === 'string') {
      const univCount = cn.university.split(',').length
      console.log('  - Universities string (first 150 chars):', cn.university.substring(0, 150))
      console.log('  - Number of universities:', univCount)
    }
    
    console.log('\n4️⃣ Rich data fields:')
    console.log('  - main_subject:', Array.isArray(cn.main_subject) ? `Array(${cn.main_subject.length}) ✅` : typeof cn.main_subject)
    console.log('  - relate_subject:', Array.isArray(cn.relate_subject) ? `Array(${cn.relate_subject.length}) ✅` : typeof cn.relate_subject)
    console.log('  - career_act:', Array.isArray(cn.career_act) ? `Array(${cn.career_act.length}) ✅` : typeof cn.career_act)
    console.log('  - chartData:', cn.chartData ? 'Object ✅' : 'null')
    
    if (cn.main_subject && cn.main_subject.length > 0) {
      console.log('\n5️⃣ Sample main_subject (first 2):')
      cn.main_subject.slice(0, 2).forEach((item: any, idx: number) => {
        console.log(`  ${idx + 1}.`, item)
      })
    }
    
    if (cn.relate_subject && cn.relate_subject.length > 0) {
      console.log('\n6️⃣ Sample relate_subject (first 2):')
      cn.relate_subject.slice(0, 2).forEach((item: any, idx: number) => {
        console.log(`  ${idx + 1}.`, item)
      })
    }
    
    if (cn.chartData) {
      console.log('\n7️⃣ chartData keys:', Object.keys(cn.chartData))
    }
  }
  
  if (jsonData.merged) {
    console.log('\n8️⃣ merged data (normalized):')
    console.log('  - Keys:', Object.keys(jsonData.merged))
  }
} else {
  console.log('❌ No data found')
}

process.exit(0)
