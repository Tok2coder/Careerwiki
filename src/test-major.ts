import { getMajorDetail } from './api/careernetAPI'

async function test() {
  try {
    console.log('=== Testing getMajorDetail ===')
    console.log('Major ID: 10 (간호학과)')
    
    const result = await getMajorDetail('10')
    
    if (!result) {
      console.log('❌ Result is null!')
      return
    }
    
    console.log('✅ Success!')
    console.log('Major name:', result.major)
    console.log('Summary length:', result.summary?.length || 0)
    console.log('Has university array:', Array.isArray((result as any).university))
    console.log('University string:', result.university)
    console.log('Has main_subject:', !!(result as any).main_subject)
    console.log('Has relate_subject:', !!(result as any).relate_subject)
    console.log('Keys:', Object.keys(result).sort())
  } catch (error: any) {
    console.error('❌ Error:', error.message)
    console.error(error.stack)
  }
}

test()
