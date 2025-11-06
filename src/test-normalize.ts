import { getMajorDetail, normalizeCareerNetMajorDetail } from './api/careernetAPI'

async function test() {
  try {
    console.log('=== Testing Full Pipeline ===')
    console.log('Step 1: getMajorDetail')
    const raw = await getMajorDetail('10')
    
    if (!raw) {
      console.log('❌ getMajorDetail returned null!')
      return
    }
    
    console.log('✅ getMajorDetail success')
    
    console.log('\nStep 2: normalizeCareerNetMajorDetail')
    const normalized = normalizeCareerNetMajorDetail(raw)
    
    console.log('✅ Normalization success!')
    console.log('Normalized profile:')
    console.log('  - ID:', normalized.id)
    console.log('  - Name:', normalized.name)
    console.log('  - Summary length:', normalized.summary?.length || 0)
    console.log('  - Universities:', normalized.universities?.length || 0)
    console.log('  - Related jobs:', normalized.relatedJobs?.length || 0)
    console.log('  - Sources:', normalized.sources)
    
  } catch (error: any) {
    console.error('❌ Error:', error.message)
    console.error(error.stack)
  }
}

test()
