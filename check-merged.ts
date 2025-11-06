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
  
  console.log('✅ Merged (Normalized) Data for 간호학과:\n')
  
  const merged = jsonData.merged
  if (merged) {
    console.log('📊 Basic Info:')
    console.log('  - ID:', merged.id)
    console.log('  - Name:', merged.name)
    console.log('  - Category:', merged.categoryName)
    console.log('  - Sources:', merged.sources)
    
    console.log('\n📝 Summary (first 200 chars):')
    console.log(' ', merged.summary ? merged.summary.substring(0, 200) + '...' : 'N/A')
    
    console.log('\n🎯 Aptitude:')
    console.log(' ', merged.aptitude || 'N/A')
    
    console.log('\n🏫 Universities (' + (merged.universities ? merged.universities.length : 0) + '):')
    if (merged.universities && merged.universities.length > 0) {
      merged.universities.slice(0, 5).forEach((u: string, idx: number) => {
        console.log(`  ${idx + 1}. ${u}`)
      })
      if (merged.universities.length > 5) {
        console.log(`  ... and ${merged.universities.length - 5} more`)
      }
    }
    
    console.log('\n💼 Related Jobs (' + (merged.relatedJobs ? merged.relatedJobs.length : 0) + '):')
    if (merged.relatedJobs && merged.relatedJobs.length > 0) {
      merged.relatedJobs.slice(0, 5).forEach((job: any, idx: number) => {
        console.log(`  ${idx + 1}. ${job.name || job}`)
      })
      if (merged.relatedJobs.length > 5) {
        console.log(`  ... and ${merged.relatedJobs.length - 5} more`)
      }
    }
    
    console.log('\n💰 Career Info:')
    console.log('  - Salary After Graduation:', merged.salaryAfterGraduation || 'N/A')
    console.log('  - Employment Rate:', merged.employmentRate || 'N/A')
  }
  
  // Check careernet raw data
  console.log('\n\n🔍 Checking careernet raw data object type:')
  console.log('  Type:', typeof jsonData.careernet)
  console.log('  Is Array:', Array.isArray(jsonData.careernet))
  console.log('  Keys:', jsonData.careernet ? Object.keys(jsonData.careernet) : 'null')
  
  if (jsonData.careernet && Array.isArray(jsonData.careernet) && jsonData.careernet.length > 0) {
    console.log('\n📦 careernet[0] (raw API data):')
    const raw = jsonData.careernet[0]
    console.log('  - majorSeq:', raw.majorSeq)
    console.log('  - major:', raw.major)
    console.log('  - university type:', typeof raw.university)
    console.log('  - Has main_subject:', !!raw.main_subject)
    console.log('  - Has relate_subject:', !!raw.relate_subject)
  }
} else {
  console.log('❌ No data found')
}

process.exit(0)
