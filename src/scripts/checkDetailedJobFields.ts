import { getJobDetail } from '../api/careernetAPI'
import { fetchGoyong24JobDetail } from '../api/goyong24API'
import type { Env } from '../types/env'

const env = {
  DB: null as any,
  CAREERNET_API_KEY: process.env.CAREER_NET_API_KEY || '',
  GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY || '',
  GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY || ''
} as Env

function countAllFields(obj: any, prefix = ''): number {
  let count = 0
  
  if (typeof obj === 'object' && obj !== null) {
    if (Array.isArray(obj)) {
      count += obj.length
      obj.forEach(item => {
        count += countAllFields(item, prefix + '[]')
      })
    } else {
      const keys = Object.keys(obj)
      count += keys.length
      keys.forEach(key => {
        count += countAllFields(obj[key], prefix + '.' + key)
      })
    }
  }
  
  return count
}

async function main() {
  console.log('🔍 직업 데이터 상세 필드 수 확인\n')
  console.log('='.repeat(80))
  
  // CareerNet
  console.log('\n1️⃣ 커리어넷 직업백과 API')
  console.log('-'.repeat(80))
  const careernetJob = await getJobDetail('8', env)
  
  if (careernetJob) {
    const sections = Object.keys(careernetJob)
    console.log(`📊 최상위 섹션: ${sections.length}개`)
    console.log(`   - ${sections.join(', ')}`)
    
    console.log('\n📋 각 섹션별 필드 수:')
    sections.forEach(section => {
      const data = careernetJob[section]
      if (typeof data === 'object' && data !== null) {
        const fieldCount = Object.keys(data).length
        console.log(`   ✅ ${section}: ${fieldCount}개 필드`)
        
        // Show nested structure for encyclopedia
        if (section === 'encyclopedia' && typeof data === 'object') {
          Object.keys(data).forEach(subKey => {
            const subData = data[subKey]
            if (Array.isArray(subData)) {
              console.log(`      └─ ${subKey}: 배열 ${subData.length}개`)
            } else if (typeof subData === 'object' && subData !== null) {
              console.log(`      └─ ${subKey}: 객체 ${Object.keys(subData).length}개`)
            } else {
              console.log(`      └─ ${subKey}: ${typeof subData}`)
            }
          })
        }
      } else {
        console.log(`   ✅ ${section}: ${typeof data}`)
      }
    })
    
    const totalFields = countAllFields(careernetJob)
    console.log(`\n🎯 총 필드 수 (중첩 포함): ${totalFields}개`)
  }
  
  // Goyong24
  console.log('\n\n2️⃣ 고용24 직업정보 API')
  console.log('-'.repeat(80))
  
  // Fetch all detail types
  const detailTypes = ['1', '2', '3', '4', '5', '6', '7']
  const allGoyong24Data: any = {}
  
  for (const dtlGb of detailTypes) {
    const data = await fetchGoyong24JobDetail({ jobCd: '10001', dtlGb }, env)
    if (data) {
      Object.assign(allGoyong24Data, data)
    }
  }
  
  console.log(`📊 최상위 섹션: ${Object.keys(allGoyong24Data).length}개`)
  console.log(`   - ${Object.keys(allGoyong24Data).join(', ')}`)
  
  console.log('\n📋 각 섹션별 필드 수:')
  Object.keys(allGoyong24Data).forEach(section => {
    const data = allGoyong24Data[section]
    if (typeof data === 'object' && data !== null) {
      const fieldCount = Object.keys(data).length
      console.log(`   ✅ ${section}: ${fieldCount}개 필드`)
    } else {
      console.log(`   ✅ ${section}: ${typeof data}`)
    }
  })
  
  const totalGoyong24Fields = countAllFields(allGoyong24Data)
  console.log(`\n🎯 총 필드 수 (중첩 포함): ${totalGoyong24Fields}개`)
  
  console.log('\n' + '='.repeat(80))
  console.log('📊 종합 요약:')
  console.log('='.repeat(80))
  console.log(`✅ 커리어넷: ${Object.keys(careernetJob || {}).length}개 섹션, ${countAllFields(careernetJob)}개 필드`)
  console.log(`✅ 고용24: ${Object.keys(allGoyong24Data).length}개 섹션, ${totalGoyong24Fields}개 필드`)
}

main().catch(console.error)
