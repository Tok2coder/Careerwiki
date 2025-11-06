/**
 * CareerNet 학과정보 API 테스트
 * Phase 1: 새로운 필드들이 제대로 수집되는지 확인
 */

import { getMajorDetail } from './src/api/careernetAPI'

async function testMajorAPI() {
  console.log('🔍 CareerNet 학과정보 API 테스트 시작\n')
  
  // 먼저 검색으로 majorSeq 확인
  const { searchMajors } = await import('./src/api/careernetAPI')
  const searchResults = await searchMajors({ keyword: '컴퓨터공학', perPage: 1 })
  
  if (searchResults.length === 0) {
    console.error('❌ 검색 결과 없음')
    return
  }
  
  const majorSeq = searchResults[0].majorSeq
  console.log(`테스트 학과: ${searchResults[0].major} (majorSeq=${majorSeq})\n`)
  
  try {
    const major = await getMajorDetail(majorSeq)
    
    if (!major) {
      console.error('❌ API 응답 없음')
      return
    }
    
    console.log('✅ API 응답 성공\n')
    console.log('='.repeat(80))
    console.log('기본 정보')
    console.log('='.repeat(80))
    console.log(`학과명: ${major.major}`)
    console.log(`계열: ${major.department}`)
    console.log(`졸업 후 임금: ${major.salaryAfterGraduation}`)
    console.log(`취업률: ${major.employmentRate}`)
    console.log(`학과개요 길이: ${major.summary?.length || 0} 글자`)
    
    console.log('\n' + '='.repeat(80))
    console.log('Phase 1: 새로운 필드 확인')
    console.log('='.repeat(80))
    
    // 1. relate_subject (관련 고교 교과목)
    if (major.relate_subject && major.relate_subject.length > 0) {
      console.log(`\n✅ relate_subject: ${major.relate_subject.length}개 항목`)
      major.relate_subject.slice(0, 2).forEach(s => {
        console.log(`  - ${s.subject_name}: ${s.subject_description}`)
      })
    } else {
      console.log('\n❌ relate_subject: 없음')
    }
    
    // 2. career_act (진로 탐색 활동)
    if (major.career_act && major.career_act.length > 0) {
      console.log(`\n✅ career_act: ${major.career_act.length}개 항목`)
      major.career_act.slice(0, 2).forEach(a => {
        console.log(`  - ${a.act_name}: ${a.act_description.substring(0, 50)}...`)
      })
    } else {
      console.log('\n❌ career_act: 없음')
    }
    
    // 3. main_subject (대학 주요 교과목)
    if (major.main_subject && major.main_subject.length > 0) {
      console.log(`\n✅ main_subject: ${major.main_subject.length}개 항목`)
      major.main_subject.slice(0, 2).forEach(s => {
        console.log(`  - ${s.SBJECT_NM}: ${s.SBJECT_SUMRY?.substring(0, 50) || ''}...`)
      })
    } else {
      console.log('\n❌ main_subject: 없음')
    }
    
    // 4. enter_field (졸업 후 진출분야)
    if (major.enter_field && major.enter_field.length > 0) {
      console.log(`\n✅ enter_field: ${major.enter_field.length}개 항목`)
      major.enter_field.slice(0, 2).forEach(e => {
        console.log(`  - ${e.gradeuate}: ${e.description?.substring(0, 50) || ''}...`)
      })
    } else {
      console.log('\n❌ enter_field: 없음')
    }
    
    // 5. property (학과특성)
    if (major.property) {
      console.log(`\n✅ property: ${major.property.substring(0, 100)}...`)
    } else {
      console.log('\n❌ property: 없음')
    }
    
    // 6. universityList (개설대학 상세)
    if (major.universityList && major.universityList.length > 0) {
      console.log(`\n✅ universityList: ${major.universityList.length}개 대학`)
      major.universityList.slice(0, 2).forEach(u => {
        console.log(`  - ${u.schoolName} (${u.area || '지역정보없음'}) - ${u.campus_nm || '캠퍼스정보없음'}`)
      })
    } else {
      console.log('\n❌ universityList: 없음')
    }
    
    // 7. chartData (학과전망 통계)
    if (major.chartData) {
      console.log(`\n✅ chartData: 있음`)
      if (major.chartData.applicant) {
        console.log(`  - applicant: ${major.chartData.applicant.length}개 항목`)
      }
      if (major.chartData.employment_rate) {
        console.log(`  - employment_rate: ${major.chartData.employment_rate.length}개 항목`)
      }
      if (major.chartData.avg_salary) {
        console.log(`  - avg_salary: ${major.chartData.avg_salary.length}개 항목`)
      }
    } else {
      console.log('\n❌ chartData: 없음')
    }
    
    // 8. GenCD (성별비율)
    if (major.GenCD) {
      console.log(`\n✅ GenCD: 있음`)
      if (major.GenCD.popular && major.GenCD.popular.length > 0) {
        console.log(`  - popular: ${major.GenCD.popular.length}개 항목`)
        major.GenCD.popular.forEach(g => {
          console.log(`    ${g.GEN_NM}: ${g.PCNT}%`)
        })
      }
    } else {
      console.log('\n❌ GenCD: 없음')
    }
    
    // 9. lstHighAptd (고등학생 적성유형)
    if (major.lstHighAptd) {
      console.log(`\n✅ lstHighAptd: 있음`)
      if (major.lstHighAptd.popular && major.lstHighAptd.popular.length > 0) {
        console.log(`  - popular: ${major.lstHighAptd.popular.length}개 항목`)
        major.lstHighAptd.popular.slice(0, 3).forEach(a => {
          console.log(`    ${a.RANK}위: ${a.CD_NM}`)
        })
      }
    } else {
      console.log('\n❌ lstHighAptd: 없음')
    }
    
    console.log('\n' + '='.repeat(80))
    console.log('수집된 필드 통계')
    console.log('='.repeat(80))
    
    const collected = [
      major.relate_subject && major.relate_subject.length > 0,
      major.career_act && major.career_act.length > 0,
      major.main_subject && major.main_subject.length > 0,
      major.enter_field && major.enter_field.length > 0,
      major.property,
      major.universityList && major.universityList.length > 0,
      major.chartData,
      major.GenCD,
      major.SchClass,
      major.lstMiddleAptd,
      major.lstHighAptd,
      major.lstVals
    ].filter(Boolean).length
    
    console.log(`\n수집된 새 필드 섹션: ${collected} / 12`)
    console.log(`수집률: ${Math.round(collected / 12 * 100)}%`)
    
    // 전체 JSON 구조 확인
    console.log('\n' + '='.repeat(80))
    console.log('전체 API 응답 키 목록')
    console.log('='.repeat(80))
    console.log(Object.keys(major).sort().join(', '))
    
  } catch (error) {
    console.error('❌ 테스트 실패:', error)
  }
}

testMajorAPI()
