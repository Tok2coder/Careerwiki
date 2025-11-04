import { getUnifiedJobDetailWithRawData } from './src/services/profileDataService'

const jobId = '354'
const jobName = '간호사'

async function insertNurse() {
  console.log(`🔍 ${jobName} 데이터 수집 중...`)
  
  const env = {
    CAREER_NET_API_KEY: process.env.CAREER_NET_API_KEY,
    GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY
  }
  
  try {
    const result = await getUnifiedJobDetailWithRawData({ id: jobId }, env as any)
    
    if (!result.rawApiData?.careernet) {
      throw new Error('CareerNet 데이터가 없습니다')
    }
    
    // 원본 API 데이터만 저장
    const apiDataToStore = {
      careernet: result.rawApiData.careernet,
      goyong24: result.rawApiData.goyong24 || null
    }
    
    const apiDataJson = JSON.stringify(apiDataToStore)
    const dataHash = Buffer.from(apiDataJson).toString('base64').substring(0, 64)
    
    console.log(`\n📦 저장할 데이터 크기: ${apiDataJson.length} bytes`)
    console.log(`📦 careernet 데이터: ✅`)
    console.log(`📦 goyong24 데이터: ${apiDataToStore.goyong24 ? '✅' : '❌'}`)
    
    // SQL 파일 생성
    const sql = `INSERT OR REPLACE INTO jobs (id, name, careernet_id, goyong24_id, api_data_json, api_data_hash, api_last_fetched_at, created_at, updated_at)
VALUES ('${jobId}', '${jobName}', '${jobId}', NULL, '${apiDataJson.replace(/'/g, "''")}', '${dataHash}', datetime('now'), datetime('now'), datetime('now'));`
    
    const { writeFileSync } = await import('fs')
    writeFileSync('/tmp/insert-nurse.sql', sql)
    
    console.log(`\n✅ SQL 파일 생성 완료: /tmp/insert-nurse.sql`)
    console.log(`\n실행 명령어:`)
    console.log(`cd /home/user/webapp && npx wrangler d1 execute careerwiki-jobs --local --file=/tmp/insert-nurse.sql`)
    
  } catch (error: any) {
    console.error('❌ 에러:', error.message)
  }
}

insertNurse()
