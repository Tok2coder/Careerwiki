import { fetchGoyong24JobDetail } from '../api/goyong24API'
import type { Env } from '../types/env'

const env = {
  DB: null as any,
  CAREERNET_API_KEY: process.env.CAREER_NET_API_KEY || '',
  GOYONG24_MAJOR_API_KEY: process.env.GOYONG24_MAJOR_API_KEY || '',
  GOYONG24_JOB_API_KEY: process.env.GOYONG24_JOB_API_KEY || ''
} as Env

// From API_INTEGRATION.md documentation
const documentedFieldCounts = {
  '1': 22,  // 요약
  '2': 7,   // 하는 일
  '3': 23,  // 교육/자격/훈련 (documented as 23, but should be 8)
  '4': 11,  // 임금/직업만족도/전망 (documented as 11, but should be 9)
  '5': 36,  // 능력/지식/환경 (documented as 36, but should be 14)
  '6': 22,  // 성격/흥미/가치관 (documented as 22, but should be 10)
  '7': 16   // 업무활동 (documented as 16, but should be 8)
}

async function main() {
  console.log('🔍 고용24 직업정보 API 필드 검증\n')
  console.log('='.repeat(80))
  
  const sectionNames = {
    '1': '요약',
    '2': '하는 일',
    '3': '교육/자격/훈련',
    '4': '임금/직업만족도/전망',
    '5': '능력/지식/환경',
    '6': '성격/흥미/가치관',
    '7': '업무활동'
  }
  
  let totalDocumented = 0
  let totalActual = 0
  
  for (const dtlGb of ['1', '2', '3', '4', '5', '6', '7']) {
    const data = await fetchGoyong24JobDetail({ jobCd: '10001', dtlGb }, env)
    
    const documented = documentedFieldCounts[dtlGb]
    const actual = data ? Object.keys(data).length : 0
    
    totalDocumented += documented
    totalActual += actual
    
    const status = documented === actual ? '✅' : '⚠️'
    console.log(`\n${status} 섹션 ${dtlGb}: ${sectionNames[dtlGb]}`)
    console.log(`   문서화: ${documented}개 필드`)
    console.log(`   실제: ${actual}개 필드`)
    
    if (data && documented !== actual) {
      console.log(`   차이: ${Math.abs(documented - actual)}개 (${documented > actual ? '문서가 더 많음' : '실제가 더 많음'})`)
      console.log(`   실제 필드: ${Object.keys(data).join(', ')}`)
    }
  }
  
  console.log('\n' + '='.repeat(80))
  console.log('📊 종합:')
  console.log('='.repeat(80))
  console.log(`문서화된 총 필드: ${totalDocumented}개`)
  console.log(`실제 수집 필드: ${totalActual}개`)
  console.log(`차이: ${Math.abs(totalDocumented - totalActual)}개`)
  
  if (totalDocumented !== totalActual) {
    console.log('\n⚠️ API_INTEGRATION.md 문서를 업데이트해야 합니다.')
  } else {
    console.log('\n✅ 문서가 정확합니다.')
  }
}

main().catch(console.error)
