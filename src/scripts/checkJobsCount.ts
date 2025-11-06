import { searchJobs } from '../api/careernetAPI'
import { fetchGoyong24JobList } from '../api/goyong24API'
import type { Env } from '../types/env'

// Mock env object
const env = {
  DB: null as any,
  CAREERNET_API_KEY: process.env.CAREER_NET_API_KEY || '',
  GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY || '',
  GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY || ''
} as Env

async function main() {
  console.log('🔍 직업 데이터 수량 확인\n')
  
  // 1. CareerNet 직업 수
  console.log('1️⃣ 커리어넷 직업 수 확인 중...')
  let careernetCount = 0
  let page = 1
  
  while (true) {
    const jobs = await searchJobs({ thisPage: page, perPage: 100 }, env)
    if (!jobs || jobs.length === 0) break
    
    careernetCount += jobs.length
    console.log(`   페이지 ${page}: +${jobs.length}개 (누적: ${careernetCount}개)`)
    
    if (jobs.length < 100) break
    page++
    if (page > 20) break
  }
  
  // 2. Goyong24 직업 수
  console.log('\n2️⃣ 고용24 직업 수 확인 중...')
  const goyong24Response = await fetchGoyong24JobList({ srchType: 'K', keyword: '' }, env)
  const goyong24Count = goyong24Response?.items?.length || 0
  console.log(`   ✅ 고용24: ${goyong24Count}개`)
  
  // 3. 결과 출력
  console.log('\n' + '='.repeat(80))
  console.log('📊 최종 직업 데이터 수량:')
  console.log('='.repeat(80))
  console.log(`✅ 커리어넷: ${careernetCount}개`)
  console.log(`✅ 고용24: ${goyong24Count}개`)
  console.log(`✅ 총 ${careernetCount + goyong24Count}개`)
  console.log('='.repeat(80))
}

main().catch(console.error)
