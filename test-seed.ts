import { getUnifiedJobDetailWithRawData } from './src/services/profileDataService'

// 간호사 한 개만 테스트
const jobId = '354'

async function testSeed() {
  console.log(`🔍 직업 ID ${jobId} 데이터 수집 중...`)
  
  // Mock env object
  const env = {
    CAREER_NET_API_KEY: process.env.CAREER_NET_API_KEY,
    GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY
  }
  
  try {
    const result = await getUnifiedJobDetailWithRawData({ id: jobId }, env as any)
    
    console.log('\n📊 결과:')
    console.log('- profile:', result.profile?.name)
    console.log('- rawApiData.careernet:', result.rawApiData?.careernet ? '✅ 있음' : '❌ 없음')
    console.log('- rawApiData.goyong24:', result.rawApiData?.goyong24 ? '✅ 있음' : '❌ 없음')
    
    if (result.rawApiData?.careernet) {
      console.log('\n✅ CareerNet 데이터 샘플:')
      console.log(JSON.stringify(result.rawApiData.careernet, null, 2).substring(0, 500))
    }
  } catch (error: any) {
    console.error('❌ 에러:', error.message)
  }
}

testSeed()
