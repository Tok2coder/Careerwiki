/**
 * 병합 샘플 데이터 보기 좋게 출력
 */

import { readFileSync } from 'fs'
import { resolve } from 'path'

async function showSampleMergedData() {
  console.log('📊 병합 샘플 데이터 (기업고위임원)\n')
  
  try {
    const samplePath = resolve(process.cwd(), 'matched-job-sample-기업고위임원.json')
    const sampleData = JSON.parse(readFileSync(samplePath, 'utf-8'))
    
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    console.log(`직업명: ${sampleData.name}`)
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')
    
    console.log('1️⃣ 커리어넷 데이터 (ID: ' + sampleData.careernet.careernet_id + ')')
    const c = sampleData.careernet.data.careernet
    if (c) {
      console.log('   하는 일:')
      console.log(`     ${c.summary?.substring(0, 200) || 'N/A'}...`)
      console.log('   ')
      console.log('   필요 능력:')
      console.log(`     ${c.ability?.substring(0, 150) || 'N/A'}...`)
      console.log('   ')
      console.log('   전망:')
      console.log(`     ${c.prospect?.substring(0, 150) || 'N/A'}...`)
    }
    
    console.log('\n2️⃣ 고용24 데이터 (ID: ' + sampleData.goyong24.goyong24_id + ')')
    const g = sampleData.goyong24.data.goyong24
    if (g) {
      console.log('   직무개요:')
      console.log(`     ${g.jobDef?.substring(0, 200) || 'N/A'}...`)
      console.log('   ')
      console.log('   수행직무:')
      console.log(`     ${g.job?.substring(0, 150) || 'N/A'}...`)
      console.log('   ')
      console.log('   통계 정보:')
      console.log(`     - 임금: ${g.salProspect?.jobWage || 'N/A'}`)
      console.log(`     - 고용전망: ${g.salProspect?.empProspect || 'N/A'}`)
      console.log(`     - 고용현황: ${g.salProspect?.empStat || 'N/A'}`)
      console.log(`     - 직업만족도: ${g.salProspect?.jobSatis || 'N/A'}`)
    }
    
    console.log('\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    console.log('💡 병합 후 결과 (예상)')
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')
    
    console.log('섹션별 데이터 소스:')
    console.log('  ✅ 직업명: 커리어넷')
    console.log('  ✅ 하는 일 (summary): 커리어넷 + 고용24 병합')
    console.log('  ✅ 직무개요 (duties): 고용24')
    console.log('  ✅ 필요 능력 (abilities): 고용24')
    console.log('  ✅ 임금/전망/만족도 (salary/prospect/satisfaction): 고용24')
    console.log('  ✅ 관련학과/자격증: 양쪽 병합 (중복 제거)')
    
    console.log('\n화면 표시 예시:')
    console.log('┌─────────────────────────────────────────┐')
    console.log('│ 기업고위임원                             │')
    console.log('├─────────────────────────────────────────┤')
    console.log('│ 하는 일 (커리어넷)                       │')
    console.log('│ ' + (c?.summary?.substring(0, 40) || '') + '...│')
    console.log('│                                          │')
    console.log('│ 직무개요 (고용24)                        │')
    console.log('│ ' + (g?.jobDef?.substring(0, 40) || '') + '...│')
    console.log('│                                          │')
    console.log('│ 통계 정보 (고용24)                       │')
    console.log('│ - 임금: ' + (g?.salProspect?.jobWage || 'N/A').padEnd(32) + '│')
    console.log('│ - 고용전망: ' + (g?.salProspect?.empProspect || 'N/A').padEnd(28) + '│')
    console.log('│ - 직업만족도: ' + (g?.salProspect?.jobSatis || 'N/A').padEnd(26) + '│')
    console.log('└─────────────────────────────────────────┘')
    
  } catch (error) {
    console.error('❌ 샘플 데이터 읽기 실패:', error)
  }
}

showSampleMergedData()

