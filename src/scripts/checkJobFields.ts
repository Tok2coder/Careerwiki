import { getJobDetail } from '../api/careernetAPI'
import { fetchGoyong24JobDetail } from '../api/goyong24API'
import type { Env } from '../types/env'

const env = {
  DB: null as any,
  CAREERNET_API_KEY: process.env.CAREER_NET_API_KEY || '',
  GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY || '',
  GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY || ''
} as Env

async function main() {
  console.log('🔍 직업 데이터 필드 확인\n')
  
  // Test CareerNet job
  console.log('1️⃣ 커리어넷 직업백과 API (물리학연구원, seq=8):')
  const careernetJob = await getJobDetail('8', env)
  
  if (careernetJob) {
    console.log('\n📊 수집된 섹션:')
    Object.keys(careernetJob).forEach(section => {
      const data = careernetJob[section]
      if (Array.isArray(data)) {
        console.log(`  ✅ ${section}: 배열 ${data.length}개`)
      } else if (typeof data === 'object' && data !== null) {
        const fieldCount = Object.keys(data).length
        console.log(`  ✅ ${section}: 객체 ${fieldCount}개 필드`)
        if (fieldCount <= 5) {
          console.log(`      └─ 필드: ${Object.keys(data).join(', ')}`)
        }
      } else {
        console.log(`  ✅ ${section}: ${typeof data} (${String(data).slice(0, 50)})`)
      }
    })
    
    console.log('\n📋 전체 최상위 섹션 수:', Object.keys(careernetJob).length)
  }
  
  // Test Goyong24 job
  console.log('\n\n2️⃣ 고용24 직업정보 API (jobCd=10001):')
  const goyong24Job = await fetchGoyong24JobDetail({ jobCd: '10001', dtlGb: '1' }, env)
  
  if (goyong24Job) {
    console.log('\n📊 수집된 필드:')
    const fields = Object.keys(goyong24Job)
    console.log(`  ✅ 전체 필드 수: ${fields.length}개`)
    console.log('\n  처음 20개 필드:')
    fields.slice(0, 20).forEach((field, i) => {
      const value = goyong24Job[field]
      const preview = typeof value === 'string' ? value.slice(0, 30) : String(value).slice(0, 30)
      console.log(`    ${i+1}. ${field}: ${preview}`)
    })
  }
}

main().catch(console.error)
