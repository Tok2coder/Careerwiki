import type { DataSource, UnifiedJobDetail, UnifiedMajorDetail } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'
import { escapeHtml } from './detailTemplateUtils'

export interface DataDebugTemplateParams {
  profile: UnifiedJobDetail | UnifiedMajorDetail | null
  partials?: Partial<Record<DataSource, UnifiedJobDetail | UnifiedMajorDetail | null>>
  sources?: SourceStatusRecord
  rawApiData?: {
    careernet?: any
    goyong24?: any
  }
  // Additional fields for flexible rendering
  pageType?: 'job' | 'major'
  rawData?: any
  breadcrumbs?: Array<{ href: string; label: string }>
}

// ========== 필드 설명 맵 (직업 & 전공 공통) ==========
const FIELD_DESCRIPTIONS: Record<string, string> = {
  // 직업/전공 기본 정보
  'name': '직업명 또는 전공명',
  'jobName': '직업명 (통합)',
  'encyclopedia.baseInfo.job_nm': '커리어넷 직업명',
  'summary.jobNm': '고용24 직업명',
  'summary': '전공/직업 요약 정보',
  'summary.jobLrclNm': '직업 대분류명 (관리직, 전문직 등)',
  'summary.jobMdclNm': '직업 중분류명',
  'summary.jobSmclNm': '직업 소분류명',
  'summary.jobDtclNm': '직업 세분류명',
  
  // 전공 관련 필드
  'categoryId': '전공 계열 ID',
  'categoryName': '전공 계열명 (인문계열, 자연계열, 공학계열 등)',
  'aptitude': '적성 및 흥미 (어떤 성향의 학생에게 적합한지)',
  'relatedMajors': '관련 학과 목록',
  'mainSubjects': '주요 학습 과목 (기초과목 + 심화과목)',
  'licenses': '취득 가능 자격증 (국가자격 + 민간자격)',
  'universities': '개설 대학 정보 (대학명, 학과명, 유형)',
  'universities[0].name': '대학명',
  'universities[0].department': '학과/학부명',
  'universities[0].universityType': '대학 유형 (4년제, 전문대 등)',
  'universities[0].url': '대학 홈페이지 URL',
  'recruitmentStatus': '모집 현황 (정원, 지원자, 졸업생 수)',
  'relatedJobs': '졸업 후 관련 직업',
  'whatStudy': '무엇을 배우나요? (전공 교육 내용 설명)',
  'howPrepare': '어떻게 준비하나요? (입학 전 준비사항)',
  'jobProspect': '졸업 후 진로 전망',
  'salaryAfterGraduation': '졸업 후 평균 연봉',
  'employmentRate': '취업률',
  
  // 임금 & 만족도
  'encyclopedia.baseInfo.wage': '커리어넷 임금 정보',
  'encyclopedia.baseInfo.wage_source': '임금 정보 출처 (조사 기관, 연도)',
  'summary.sal': '고용24 임금 (간단)',
  'salProspect.sal': '고용24 임금 (상세 - 하위 10%, 중위, 상위 10%)',
  'encyclopedia.baseInfo.satisfication': '커리어넷 직업 만족도',
  'encyclopedia.baseInfo.satisfi_source': '만족도 정보 출처',
  'summary.jobSatis': '고용24 직업 만족도 (간단)',
  'salProspect.jobSatis': '고용24 직업 만족도 (상세)',
  'encyclopedia.baseInfo.social': '사회적 평가 점수',
  'encyclopedia.baseInfo.wlb': '워라밸 점수 (일과 생활의 균형)',
  
  // 일자리 전망
  'encyclopedia.forecastList': '커리어넷 전망 정보',
  'summary.jobProspect': '고용24 일자리 전망 (간단)',
  'salProspect.jobProspect': '고용24 일자리 전망 (상세)',
  'salProspect.jobSumProspect': '일자리 전망 세부 항목 (증가, 다소증가, 현상유지 등)',
  
  // 하는 일
  'encyclopedia.duties': '커리어넷 주요 업무 (리스트)',
  'summary.jobDuty': '고용24 주요 업무 (텍스트)',
  'duty.jobDuty': '고용24 주요 업무 상세',
  'duty.workList': '세부 업무 항목',
  
  // 교육 & 자격
  'encyclopedia.academicBackground': '커리어넷 학력 요구사항',
  'encyclopedia.requiredEducation': '필요 교육 수준',
  'path.eduLvl': '고용24 학력 요구사항',
  'path.majr': '전공 요구사항',
  'encyclopedia.relatedMajors': '커리어넷 관련 전공',
  'path.majrList': '고용24 관련 전공 목록',
  'encyclopedia.certificates': '커리어넷 관련 자격증',
  'path.certList': '고용24 관련 자격증 목록',
  'path.certList[0].certNm': '자격증명',
  'path.certList[0].issuOrgnNm': '발급 기관',
  
  // 능력 & 지식
  'ablKnwEnv.abilList': '필요한 능력 목록 (의사소통, 문제해결 등)',
  'ablKnwEnv.abilList[0].abilNm': '능력명',
  'ablKnwEnv.abilList[0].contDesc': '능력 설명',
  'ablKnwEnv.abilList[0].imprtDegr': '중요도 (0-100)',
  'ablKnwEnv.knwlList': '필요한 지식 목록',
  'ablKnwEnv.knwlList[0].knwlNm': '지식명',
  'ablKnwEnv.knwlList[0].contDesc': '지식 설명',
  'ablKnwEnv.knwlList[0].imprtDegr': '중요도',
  
  // 성격 & 흥미
  'chrIntrVals.chrctrList': '필요한 성격 특성',
  'chrIntrVals.chrctrList[0].chrctrNm': '성격 특성명',
  'chrIntrVals.chrctrList[0].contDesc': '성격 설명',
  'chrIntrVals.intrList': '흥미 유형 (현실형, 탐구형, 예술형 등)',
  'chrIntrVals.intrList[0].intrNm': '흥미 유형명',
  'chrIntrVals.intrList[0].contDesc': '흥미 설명',
  'chrIntrVals.valList': '직업 가치관',
  'chrIntrVals.valList[0].valNm': '가치관명',
  'chrIntrVals.valList[0].contDesc': '가치관 설명',
  
  // 근무 환경
  'ablKnwEnv.envList': '근무 환경 정보',
  'ablKnwEnv.envList[0].envNm': '환경 요소명 (실내/실외, 소음 등)',
  'ablKnwEnv.envList[0].contDesc': '환경 설명',
  'ablKnwEnv.envList[0].expDegr': '노출 정도',
  
  // 업무 활동
  'actv.actvList': '주요 업무 활동',
  'actv.actvList[0].actvNm': '활동명',
  'actv.actvList[0].contDesc': '활동 설명',
  'actv.actvList[0].imprtDegr': '중요도',
  
  // 메타데이터
  'sourceIds': '데이터 출처 ID (careernet, goyong24)',
  'sourceIds.careernet': '커리어넷 ID',
  'sourceIds.goyong24': '고용24 ID',
  'sources': '데이터 수집 출처 목록',
  
  // 기타
  'encyclopedia.relJobs': '커리어넷 관련 직업',
  'encyclopedia.relVideoList': '관련 동영상 목록',
  'encyclopedia.relSolList': '관련 솔루션',
  'path.kecoList': '한국고용직업분류 (KECO) 코드',
  'summary.jobStatus': '일자리 현황 (현재 종사자 수)',
  'salProspect.jobStatusList': '일자리 현황 상세'
}

// 필드 설명 가져오기 함수
const getFieldDescription = (fieldPath: string): string => {
  // 정확한 매칭 먼저 시도
  if (FIELD_DESCRIPTIONS[fieldPath]) {
    return FIELD_DESCRIPTIONS[fieldPath]
  }
  
  // 배열 인덱스 제거하고 다시 시도 (예: knwlList[0].knwlNm -> knwlList[0].knwlNm)
  const withoutArrayIndex = fieldPath.replace(/\[\d+\]/g, '[0]')
  if (FIELD_DESCRIPTIONS[withoutArrayIndex]) {
    return FIELD_DESCRIPTIONS[withoutArrayIndex]
  }
  
  // 배열 부분 완전 제거하고 시도 (예: knwlList[0].knwlNm -> knwlList.knwlNm)
  const withoutArray = fieldPath.replace(/\[\d+\]\./g, '.')
  if (FIELD_DESCRIPTIONS[withoutArray]) {
    return FIELD_DESCRIPTIONS[withoutArray]
  }
  
  // 마지막 키만 추출해서 시도
  const lastKey = fieldPath.split('.').pop() || ''
  if (FIELD_DESCRIPTIONS[lastKey]) {
    return FIELD_DESCRIPTIONS[lastKey]
  }
  
  return '' // 설명 없음
}

const renderEncyclopediaTable = (data: any): string => {
  if (!data) {
    return ''
  }

  const renderNestedObject = (obj: any, depth: number = 0): string => {
    if (!obj || typeof obj !== 'object') {
      return `<span class="text-gray-600 text-sm">${escapeHtml(String(obj || '-'))}</span>`
    }

    if (Array.isArray(obj)) {
      if (obj.length === 0) {
        return `<span class="text-gray-400 text-sm italic">빈 배열</span>`
      }

      return `
        <div class="ml-${depth * 4} space-y-2">
          ${obj.map((item, index) => `
            <div class="border-l-2 border-indigo-200 pl-3 py-2 bg-indigo-50/30">
              <div class="text-xs font-bold text-indigo-600 mb-1">[${index}]</div>
              ${renderNestedObject(item, depth + 1)}
            </div>
          `).join('')}
        </div>
      `
    }

    const entries = Object.entries(obj)
    if (entries.length === 0) {
      return `<span class="text-gray-400 text-sm italic">빈 객체</span>`
    }

    return `
      <table class="w-full border-collapse">
        <tbody>
          ${entries.map(([key, value]) => {
            const isObject = value && typeof value === 'object'
            const isArray = Array.isArray(value)
            
            return `
              <tr class="border-b border-gray-100 hover:bg-gray-50">
                <td class="py-3 px-4 align-top font-semibold text-sm ${
                  isObject ? 'bg-indigo-50 text-indigo-900' : 'bg-gray-50 text-gray-800'
                }" style="min-width: 200px; width: 30%;">
                  ${escapeHtml(key)}
                  ${isArray ? ` <span class="text-xs text-indigo-600">[${(value as any[]).length}개]</span>` : ''}
                </td>
                <td class="py-3 px-4 align-top">
                  ${isObject ? renderNestedObject(value, depth + 1) : 
                    `<span class="text-gray-700">${escapeHtml(String(value || '-'))}</span>`}
                </td>
              </tr>
            `
          }).join('')}
        </tbody>
      </table>
    `
  }

  return `
    <div class="card-hover">
      <div class="bg-white rounded-lg shadow-md overflow-hidden">
        <div class="bg-gradient-to-r from-indigo-600 to-indigo-700 px-6 py-4">
          <h3 class="text-xl font-bold text-white flex items-center">
            <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
            </svg>
            커리어넷 직업백과 (jobs.json)
          </h3>
          <p class="text-indigo-100 text-sm mt-1">교육부 커리어넷 - 직업백과 API 전체 데이터</p>
        </div>
        <div class="p-6 max-h-[1000px] overflow-auto">
          ${renderNestedObject(data)}
        </div>
      </div>
    </div>
  `
}

const renderCareerNetTable = (data: any): string => {
  if (!data) {
    return `
      <div class="bg-amber-50 border-l-4 border-amber-500 p-4 rounded">
        <p class="text-amber-700 font-medium">❌ CareerNet API 응답 없음</p>
      </div>
    `
  }

  const renderNestedObject = (obj: any, depth: number = 0): string => {
    if (!obj || typeof obj !== 'object') {
      return `<span class="text-gray-600 text-sm">${escapeHtml(String(obj || '-'))}</span>`
    }

    if (Array.isArray(obj)) {
      if (obj.length === 0) {
        return `<span class="text-gray-400 text-sm italic">빈 배열</span>`
      }

      return `
        <div class="ml-${depth * 4} space-y-2">
          ${obj.map((item, index) => `
            <div class="border-l-2 border-blue-200 pl-3 py-2 bg-blue-50/30">
              <div class="text-xs font-bold text-blue-600 mb-1">[${index}]</div>
              ${renderNestedObject(item, depth + 1)}
            </div>
          `).join('')}
        </div>
      `
    }

    const entries = Object.entries(obj)
    if (entries.length === 0) {
      return `<span class="text-gray-400 text-sm italic">빈 객체</span>`
    }

    return `
      <table class="w-full border-collapse">
        <tbody>
          ${entries.map(([key, value]) => {
            const isObject = value && typeof value === 'object'
            const isArray = Array.isArray(value)
            
            return `
              <tr class="border-b border-gray-100 hover:bg-gray-50">
                <td class="py-3 px-4 align-top font-semibold text-sm ${
                  isObject ? 'bg-indigo-50 text-indigo-900' : 'bg-gray-50 text-gray-800'
                }" style="min-width: 200px; width: 30%;">
                  ${escapeHtml(key)}
                  ${isArray ? ` <span class="text-xs text-blue-600">[${(value as any[]).length}개]</span>` : ''}
                </td>
                <td class="py-3 px-4 align-top">
                  ${isObject ? renderNestedObject(value, depth + 1) : 
                    `<span class="text-gray-700">${escapeHtml(String(value || '-'))}</span>`}
                </td>
              </tr>
            `
          }).join('')}
        </tbody>
      </table>
    `
  }

  return `
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <div class="bg-gradient-to-r from-blue-600 to-blue-700 px-6 py-4">
        <h3 class="text-xl font-bold text-white flex items-center">
          <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
          </svg>
          커리어넷 (CareerNet) 원본 API 응답
        </h3>
        <p class="text-blue-100 text-sm mt-1">교육부 커리어넷 - 전체 필드 및 하위 노드</p>
      </div>
      <div class="p-6 max-h-[1000px] overflow-auto">
        ${renderNestedObject(data)}
      </div>
    </div>
  `
}

const renderGoyong24Table = (data: any): string => {
  if (!data) {
    return `
      <div class="bg-amber-50 border-l-4 border-amber-500 p-4 rounded">
        <p class="text-amber-700 font-medium">❌ Goyong24 API 응답 없음</p>
      </div>
    `
  }

  const renderNestedObject = (obj: any, depth: number = 0): string => {
    if (!obj || typeof obj !== 'object') {
      return `<span class="text-gray-600 text-sm">${escapeHtml(String(obj || '-'))}</span>`
    }

    if (Array.isArray(obj)) {
      if (obj.length === 0) {
        return `<span class="text-gray-400 text-sm italic">빈 배열</span>`
      }

      return `
        <div class="ml-${depth * 4} space-y-2">
          ${obj.map((item, index) => `
            <div class="border-l-2 border-green-200 pl-3 py-2 bg-green-50/30">
              <div class="text-xs font-bold text-green-600 mb-1">[${index}]</div>
              ${renderNestedObject(item, depth + 1)}
            </div>
          `).join('')}
        </div>
      `
    }

    const entries = Object.entries(obj)
    if (entries.length === 0) {
      return `<span class="text-gray-400 text-sm italic">빈 객체</span>`
    }

    return `
      <table class="w-full border-collapse">
        <tbody>
          ${entries.map(([key, value]) => {
            const isObject = value && typeof value === 'object'
            const isArray = Array.isArray(value)
            
            return `
              <tr class="border-b border-gray-100 hover:bg-gray-50">
                <td class="py-3 px-4 align-top font-semibold text-sm ${
                  isObject ? 'bg-emerald-50 text-emerald-900' : 'bg-gray-50 text-gray-800'
                }" style="min-width: 200px; width: 30%;">
                  ${escapeHtml(key)}
                  ${isArray ? ` <span class="text-xs text-green-600">[${(value as any[]).length}개]</span>` : ''}
                </td>
                <td class="py-3 px-4 align-top">
                  ${isObject ? renderNestedObject(value, depth + 1) : 
                    `<span class="text-gray-700">${escapeHtml(String(value || '-'))}</span>`}
                </td>
              </tr>
            `
          }).join('')}
        </tbody>
      </table>
    `
  }

  return `
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <div class="bg-gradient-to-r from-green-600 to-green-700 px-6 py-4">
        <h3 class="text-xl font-bold text-white flex items-center">
          <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
          </svg>
          고용24 (Goyong24) 원본 API 응답
        </h3>
        <p class="text-green-100 text-sm mt-1">고용노동부 고용24 - 전체 필드 및 항목</p>
      </div>
      <div class="p-6 max-h-[1000px] overflow-auto">
        ${renderNestedObject(data)}
      </div>
    </div>
  `
}

const renderActualMergedView = (rawApiData?: { careernet?: any; goyong24?: any }): string => {
  if (!rawApiData) {
    return '<p class="text-gray-500">원본 API 데이터 없음</p>'
  }

  const careernet = rawApiData.careernet
  const goyong24 = rawApiData.goyong24

  // Helper function to escape HTML
  const escapeHtml = (str: string): string => {
    return String(str)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;')
  }

  // Helper function to format value with priority logic
  const selectBestValue = (...values: any[]): any => {
    for (const val of values) {
      if (val !== null && val !== undefined && val !== '' && !(Array.isArray(val) && val.length === 0)) {
        return val
      }
    }
    return null
  }

  // Format value for display
  const formatValue = (value: any): string => {
    if (value === null || value === undefined) {
      return '<span class="text-gray-300 italic">없음</span>'
    }
    if (Array.isArray(value)) {
      if (value.length === 0) {
        return '<span class="text-gray-400 italic">빈 배열</span>'
      }
      return `<span class="text-blue-600">[${value.length}개 항목]</span> ${escapeHtml(JSON.stringify(value.slice(0, 3)))}`
    }
    if (typeof value === 'object') {
      return `<span class="text-green-600">{객체}</span> ${escapeHtml(JSON.stringify(value))}`
    }
    return escapeHtml(String(value))
  }

  // Merge logic based on Type A/B/C/D
  const mergedData = {
    // 🔴 Type A: 동일 데이터 → 병합 (중복 제거)
    jobName: selectBestValue(
      careernet?.encyclopedia?.baseInfo?.job_nm,
      goyong24?.summary?.jobNm
    ),
    classification: {
      large: selectBestValue(goyong24?.summary?.jobLrclNm),
      medium: selectBestValue(goyong24?.summary?.jobMdclNm),
      small: selectBestValue(goyong24?.summary?.jobSmclNm),
    },

    // 🟡 Type B: 유사 데이터 → 우선순위 선택
    salary: {
      primary: selectBestValue(
        goyong24?.salProspect?.sal,
        goyong24?.summary?.sal,
        careernet?.encyclopedia?.baseInfo?.wage
      ),
      alternatives: {
        careernet: careernet?.encyclopedia?.baseInfo?.wage,
        summary: goyong24?.summary?.sal,
        detailed: goyong24?.salProspect?.sal
      },
      source: careernet?.encyclopedia?.baseInfo?.wage_source
    },
    satisfaction: {
      primary: selectBestValue(
        goyong24?.salProspect?.jobSatis,
        goyong24?.summary?.jobSatis,
        careernet?.encyclopedia?.baseInfo?.satisfication
      ),
      alternatives: {
        careernet: careernet?.encyclopedia?.baseInfo?.satisfication,
        summary: goyong24?.summary?.jobSatis,
        detailed: goyong24?.salProspect?.jobSatis
      },
      source: careernet?.encyclopedia?.baseInfo?.satisfi_source
    },
    prospect: {
      primary: selectBestValue(
        goyong24?.salProspect?.jobProspect,
        goyong24?.summary?.jobProspect,
        careernet?.encyclopedia?.forecastList
      ),
      alternatives: {
        careernet: careernet?.encyclopedia?.forecastList,
        summary: goyong24?.summary?.jobProspect,
        detailed: goyong24?.salProspect?.jobProspect
      }
    },

    // 🟢 Type C: 보완 데이터 → 모두 활용 (계층적)
    work: {
      simple: careernet?.encyclopedia?.workList, // 간단 (개요 탭용)
      summary: selectBestValue(goyong24?.summary?.jobSum, goyong24?.duty?.jobSum), // 요약
      detailed: goyong24?.duty?.execJob // 상세 (상세정보 탭용)
    },
    abilities: {
      simple: careernet?.encyclopedia?.abilityList, // 간단
      summary: goyong24?.summary?.jobAbil, // 요약
      detailedComparison: { // 상세 비교
        withinJob: goyong24?.ablKnwEnv?.jobAbilCmpr,
        betweenJobs: goyong24?.ablKnwEnv?.jobAbil
      }
    },
    knowledge: {
      simple: careernet?.encyclopedia?.performList?.knowledge,
      summary: goyong24?.summary?.knowldg,
      detailedComparison: {
        withinJob: goyong24?.ablKnwEnv?.KnwldgCmpr,
        betweenJobs: goyong24?.ablKnwEnv?.Knwldg
      }
    },

    // 🔵 Type D: 독립 데이터 → 각자 유지
    careernetOnly: {
      wlb: careernet?.encyclopedia?.baseInfo?.wlb,
      social: careernet?.encyclopedia?.baseInfo?.social,
      researchList: careernet?.encyclopedia?.researchList,
      tagList: careernet?.encyclopedia?.tagList,
      jobReadyList: careernet?.encyclopedia?.jobReadyList
    },
    goyong24Only: {
      prospectDetail: goyong24?.salProspect?.jobSumProspect,
      educationDistribution: goyong24?.path?.educationDistribution,
      majorDistribution: goyong24?.path?.majorDistribution,
      personality: {
        withinJob: goyong24?.chrIntrVals?.jobChrCmpr,
        betweenJobs: goyong24?.chrIntrVals?.jobChr
      },
      interest: {
        withinJob: goyong24?.chrIntrVals?.jobIntrstCmpr,
        betweenJobs: goyong24?.chrIntrVals?.jobIntrst
      },
      values: {
        withinJob: goyong24?.chrIntrVals?.jobValsCmpr,
        betweenJobs: goyong24?.chrIntrVals?.jobVals
      },
      activity: {
        importance: {
          withinJob: goyong24?.actv?.jobActvImprtncCmpr,
          betweenJobs: goyong24?.actv?.jobActvImprtnc
        },
        level: {
          withinJob: goyong24?.actv?.jobActvLvlCmpr,
          betweenJobs: goyong24?.actv?.jobActvLvl
        }
      }
    }
  }

  // Render table
  return `
    <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-xl p-6">
      <div class="bg-white rounded-lg shadow-md overflow-hidden">
        <table class="w-full">
          <thead>
            <tr class="bg-gradient-to-r from-blue-600 to-indigo-600">
              <th class="px-6 py-4 text-left text-white font-bold">섹션</th>
              <th class="px-6 py-4 text-left text-white font-bold">필드</th>
              <th class="px-6 py-4 text-left text-white font-bold">병합된 값</th>
              <th class="px-6 py-4 text-left text-white font-bold">병합 규칙</th>
            </tr>
          </thead>
          <tbody>
            <!-- 🔴 Type A: 동일 데이터 -->
            <tr class="bg-red-50">
              <td colspan="4" class="px-6 py-3 font-bold text-red-900">
                🔴 Type A: 동일 데이터 → 병합 (중복 제거)
              </td>
            </tr>
            <tr class="border-b hover:bg-gray-50">
              <td class="px-6 py-4 text-sm font-semibold">기본정보</td>
              <td class="px-6 py-4 text-sm">직업명</td>
              <td class="px-6 py-4 text-sm">${formatValue(mergedData.jobName)}</td>
              <td class="px-6 py-4 text-xs text-gray-600">우선순위: jobName → summary.jobNm → encyclopedia.job_nm</td>
            </tr>
            <tr class="border-b hover:bg-gray-50">
              <td class="px-6 py-4 text-sm font-semibold">기본정보</td>
              <td class="px-6 py-4 text-sm">직업 분류</td>
              <td class="px-6 py-4 text-sm">
                대: ${formatValue(mergedData.classification.large)}<br>
                중: ${formatValue(mergedData.classification.medium)}<br>
                소: ${formatValue(mergedData.classification.small)}
              </td>
              <td class="px-6 py-4 text-xs text-gray-600">7개 섹션 동일값 → 1개로 병합</td>
            </tr>

            <!-- 🟡 Type B: 유사 데이터 → 우선순위 -->
            <tr class="bg-yellow-50">
              <td colspan="4" class="px-6 py-3 font-bold text-yellow-900">
                🟡 Type B: 유사 데이터 → 우선순위 선택
              </td>
            </tr>
            <tr class="border-b hover:bg-gray-50">
              <td class="px-6 py-4 text-sm font-semibold">임금 & 만족도</td>
              <td class="px-6 py-4 text-sm">임금</td>
              <td class="px-6 py-4 text-sm">
                <div class="font-bold mb-2">✅ 선택: ${formatValue(mergedData.salary.primary)}</div>
                <details class="text-xs text-gray-600">
                  <summary class="cursor-pointer hover:text-blue-600">대안 값 보기</summary>
                  <div class="ml-4 mt-2 space-y-1">
                    <div>📚 커리어넷: ${formatValue(mergedData.salary.alternatives.careernet)}</div>
                    <div>📊 고용24-요약: ${formatValue(mergedData.salary.alternatives.summary)}</div>
                    <div>📊 고용24-상세: ${formatValue(mergedData.salary.alternatives.detailed)}</div>
                  </div>
                </details>
              </td>
              <td class="px-6 py-4 text-xs text-gray-600">
                salProspect.sal (최상세) > summary.sal > encyclopedia.wage<br>
                출처: ${formatValue(mergedData.salary.source)}
              </td>
            </tr>
            <tr class="border-b hover:bg-gray-50">
              <td class="px-6 py-4 text-sm font-semibold">임금 & 만족도</td>
              <td class="px-6 py-4 text-sm">직업만족도</td>
              <td class="px-6 py-4 text-sm">
                <div class="font-bold mb-2">✅ 선택: ${formatValue(mergedData.satisfaction.primary)}</div>
                <details class="text-xs text-gray-600">
                  <summary class="cursor-pointer hover:text-blue-600">대안 값 보기</summary>
                  <div class="ml-4 mt-2 space-y-1">
                    <div>📚 커리어넷: ${formatValue(mergedData.satisfaction.alternatives.careernet)}</div>
                    <div>📊 고용24-요약: ${formatValue(mergedData.satisfaction.alternatives.summary)}</div>
                    <div>📊 고용24-상세: ${formatValue(mergedData.satisfaction.alternatives.detailed)}</div>
                  </div>
                </details>
              </td>
              <td class="px-6 py-4 text-xs text-gray-600">
                salProspect.jobSatis > summary.jobSatis > encyclopedia.satisfication<br>
                출처: ${formatValue(mergedData.satisfaction.source)}
              </td>
            </tr>

            <!-- 🟢 Type C: 보완 데이터 → 모두 활용 -->
            <tr class="bg-green-50">
              <td colspan="4" class="px-6 py-3 font-bold text-green-900">
                🟢 Type C: 보완 데이터 → 계층적 활용 (간단→상세)
              </td>
            </tr>
            <tr class="border-b hover:bg-gray-50">
              <td class="px-6 py-4 text-sm font-semibold">하는 일</td>
              <td class="px-6 py-4 text-sm">업무 설명</td>
              <td class="px-6 py-4 text-sm">
                <div class="space-y-2">
                  <div><span class="font-bold text-blue-600">📖 간단:</span> ${formatValue(mergedData.work.simple)}</div>
                  <div><span class="font-bold text-green-600">📝 요약:</span> ${formatValue(mergedData.work.summary)}</div>
                  <div><span class="font-bold text-purple-600">📊 상세:</span> ${formatValue(mergedData.work.detailed)}</div>
                </div>
              </td>
              <td class="px-6 py-4 text-xs text-gray-600">
                개요 탭: simple (encyclopedia.workList)<br>
                상세 탭: simple + summary + detailed
              </td>
            </tr>
            <tr class="border-b hover:bg-gray-50">
              <td class="px-6 py-4 text-sm font-semibold">능력 & 지식</td>
              <td class="px-6 py-4 text-sm">필요 능력</td>
              <td class="px-6 py-4 text-sm">
                <div class="space-y-2">
                  <div><span class="font-bold text-blue-600">📖 간단:</span> ${formatValue(mergedData.abilities.simple)}</div>
                  <div><span class="font-bold text-green-600">📝 요약:</span> ${formatValue(mergedData.abilities.summary)}</div>
                  <div><span class="font-bold text-purple-600">📊 상세 비교:</span> 
                    직업내: ${formatValue(mergedData.abilities.detailedComparison.withinJob)}<br>
                    직업간: ${formatValue(mergedData.abilities.detailedComparison.betweenJobs)}
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 text-xs text-gray-600">
                개요 탭: simple<br>
                상세 탭: 모든 레벨 표시
              </td>
            </tr>

            <!-- 🔵 Type D: 독립 데이터 -->
            <tr class="bg-blue-50">
              <td colspan="4" class="px-6 py-3 font-bold text-blue-900">
                🔵 Type D: 독립 데이터 → 각자 유지
              </td>
            </tr>
            <tr class="border-b hover:bg-gray-50">
              <td class="px-6 py-4 text-sm font-semibold">커리어넷 전용</td>
              <td class="px-6 py-4 text-sm">워라밸 & 사회적 평가</td>
              <td class="px-6 py-4 text-sm">
                WLB: ${formatValue(mergedData.careernetOnly.wlb)}<br>
                Social: ${formatValue(mergedData.careernetOnly.social)}
              </td>
              <td class="px-6 py-4 text-xs text-gray-600">커리어넷 독점 데이터</td>
            </tr>
            <tr class="border-b hover:bg-gray-50">
              <td class="px-6 py-4 text-sm font-semibold">고용24 전용</td>
              <td class="px-6 py-4 text-sm">상세 통계 & 비교</td>
              <td class="px-6 py-4 text-sm">
                <div class="space-y-1 text-xs">
                  <div>학력 분포: ${formatValue(mergedData.goyong24Only.educationDistribution)}</div>
                  <div>전공 분포: ${formatValue(mergedData.goyong24Only.majorDistribution)}</div>
                  <div>성격 비교: ${formatValue(mergedData.goyong24Only.personality)}</div>
                  <div>흥미 비교: ${formatValue(mergedData.goyong24Only.interest)}</div>
                  <div>업무활동 분석: ${formatValue(mergedData.goyong24Only.activity)}</div>
                </div>
              </td>
              <td class="px-6 py-4 text-xs text-gray-600">고용24 독점 통계 데이터</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="mt-6 bg-white rounded-lg p-4 text-sm text-gray-700">
        <h4 class="font-bold mb-2">💡 병합 규칙 요약</h4>
        <ul class="space-y-1 ml-4">
          <li>🔴 <strong>Type A:</strong> 같은 값 → 중복 제거 (jobCd, 분류)</li>
          <li>🟡 <strong>Type B:</strong> 같은 의미, 다른 값 → 우선순위 (최신/상세 우선)</li>
          <li>🟢 <strong>Type C:</strong> 다른 상세도 → 계층적 활용 (간단→상세)</li>
          <li>🔵 <strong>Type D:</strong> 독립 정보 → 각자 유지</li>
        </ul>
      </div>
    </div>
  `
}

const renderFieldComparisonTable = (rawApiData?: { careernet?: any; goyong24?: any }): string => {
  if (!rawApiData) {
    return '<p class="text-gray-500">원본 API 데이터 없음</p>'
  }

  const careernet = rawApiData.careernet
  const goyong24 = rawApiData.goyong24

  // Flatten nested objects into dot notation paths
  const flattenObject = (obj: any, prefix: string = ''): Map<string, any> => {
    const result = new Map<string, any>()
    
    if (!obj || typeof obj !== 'object') {
      result.set(prefix, obj)
      return result
    }

    if (Array.isArray(obj)) {
      result.set(prefix, obj)
      // Also flatten first item as example
      if (obj.length > 0 && typeof obj[0] === 'object') {
        const firstItem = flattenObject(obj[0], `${prefix}[0]`)
        firstItem.forEach((value, key) => result.set(key, value))
      }
      return result
    }

    Object.entries(obj).forEach(([key, value]) => {
      const newPrefix = prefix ? `${prefix}.${key}` : key
      
      if (value && typeof value === 'object' && !Array.isArray(value)) {
        const nested = flattenObject(value, newPrefix)
        nested.forEach((v, k) => result.set(k, v))
      } else {
        result.set(newPrefix, value)
      }
    })

    return result
  }

  const careernetFields = careernet ? flattenObject(careernet) : new Map()
  const goyong24Fields = goyong24 ? flattenObject(goyong24) : new Map()

  // ========== EXCLUDED FIELDS ==========
  // 사용자 요청으로 제외할 필드들
  const EXCLUDED_FIELDS = new Set<string>([
    // 1. 직업 기본정보 섹션에서 제외
    'jobdicSeq',                         // 직업사전 시퀀스
    'encyclopedia.baseInfo.job_cd',      // 커리어넷: 직업코드
    'encyclopedia.baseInfo.seq',         // 커리어넷: 시퀀스
    'summary.jobCd',                     // 고용24: 직업코드
    'duty.jobCd',                        // 고용24 D02: 직업코드
    'path.jobCd',                        // 고용24 D03: 직업코드
    'salProspect.jobCd',                 // 고용24 D04: 직업코드
    'ablKnwEnv.jobCd',                   // 고용24 D05: 직업코드
    'chrIntrVals.jobCd',                 // 고용24 D06: 직업코드
    'actv.jobCd',                        // 고용24 D07: 직업코드
    
    // 3. 일자리 전망 & 현황 섹션에서 제외
    'summary.jobStatus',                 // 고용24 D01: 일자리 현황
    'salProspect.jobStatusList',         // 고용24 D04: 일자리 현황 목록
    'salProspect.jobStatusList[0]',
    'salProspect.jobStatusList[0].jobCd',
    'salProspect.jobStatusList[0].jobNm',
    
    // 6. 자격증 & 기관 섹션에서 제외
    'path.kecoList',                     // 한국고용직업분류
    'path.kecoList[0]',
    'path.kecoList[0].kecoCd',
    'path.kecoList[0].kecoNm',
    
    // 12. 관련 정보 섹션에서 제외
    'encyclopedia.relVideoList',         // 관련 동영상
    'encyclopedia.relSolList',           // 관련 솔루션
    'encyclopedia.relJinsolList',        // 관련 진솔
    
    // 13. 메타데이터 섹션에서 제외
    'encyclopedia.baseInfo.INTRST_JOB_YN',  // 관심직업 설정여부
    'encyclopedia.baseInfo.emp_job_cd',      // 고용코드
    'encyclopedia.baseInfo.emp_job_nm',      // 고용코드명
    'encyclopedia.baseInfo.std_job_cd',      // 표준직업코드
    'encyclopedia.baseInfo.std_job_nm',      // 표준직업코드명
    'encyclopedia.baseInfo.tag',             // 태그
    'encyclopedia.baseInfo.views',           // 조회수
    'encyclopedia.baseInfo.likes',           // 추천수
    'encyclopedia.indicatorChart',           // 지표 차트
    'encyclopedia.baseInfo',                 // 기본 정보 (그룹)
    'encyclopedia',                          // 전체 (그룹)
    'duty',                                  // 하는 일 (그룹)
    'path',                                  // 교육/자격/훈련 (그룹)
    'salProspect',                           // 임금/만족도/전망 (그룹)
    'ablKnwEnv',                             // 능력/지식/환경 (그룹)
    'chrIntrVals',                           // 성격/흥미/가치관 (그룹)
    'actv'                                   // 업무활동 (그룹)
  ])

  // ========== SEMANTIC MERGE RULES ==========
  // Type A: 동일 데이터 - 병합 허용 (중복 제거)
  // 같은 의미 + 같은 값 → 하나로 병합
  const MERGEABLE_FIELD_GROUPS: string[][] = [
    // A-1. 직업 코드 (jobCd) - 모든 섹션에서 동일
    ['summary.jobCd', 'duty.jobCd', 'path.jobCd', 'salProspect.jobCd', 'ablKnwEnv.jobCd', 'chrIntrVals.jobCd', 'actv.jobCd'],
    
    // A-2. 대분류 코드 (jobLrclCd)
    ['summary.jobLrclCd', 'duty.jobLrclCd', 'path.jobLrclCd', 'salProspect.jobLrclCd', 'ablKnwEnv.jobLrclCd', 'chrIntrVals.jobLrclCd', 'actv.jobLrclCd'],
    
    // A-3. 대분류명 (jobLrclNm)
    ['summary.jobLrclNm', 'duty.jobLrclNm', 'path.jobLrclNm', 'salProspect.jobLrclNm', 'ablKnwEnv.jobLrclNm', 'chrIntrVals.jobLrclNm', 'actv.jobLrclNm'],
    
    // A-4. 중분류 코드 (jobMdclCd)
    ['summary.jobMdclCd', 'duty.jobMdclCd', 'path.jobMdclCd', 'salProspect.jobMdclCd', 'ablKnwEnv.jobMdclCd', 'chrIntrVals.jobMdclCd', 'actv.jobMdclCd'],
    
    // A-5. 중분류명 (jobMdclNm)
    ['summary.jobMdclNm', 'duty.jobMdclNm', 'path.jobMdclNm', 'salProspect.jobMdclNm', 'ablKnwEnv.jobMdclNm', 'chrIntrVals.jobMdclNm', 'actv.jobMdclNm'],
    
    // A-6. 소분류 코드 (jobSmclCd)
    ['summary.jobSmclCd', 'duty.jobSmclCd', 'path.jobSmclCd', 'salProspect.jobSmclCd', 'ablKnwEnv.jobSmclCd', 'chrIntrVals.jobSmclCd', 'actv.jobSmclCd'],
    
    // A-7. 소분류명 (jobSmclNm) - 주의: job_nm과 다름!
    ['summary.jobSmclNm', 'duty.jobSmclNm', 'path.jobSmclNm', 'salProspect.jobSmclNm', 'ablKnwEnv.jobSmclNm', 'chrIntrVals.jobSmclNm', 'actv.jobSmclNm'],
    
    // A-8. 세분류 코드 (jobDtclCd)
    ['summary.jobDtclCd', 'duty.jobDtclCd', 'path.jobDtclCd', 'salProspect.jobDtclCd', 'ablKnwEnv.jobDtclCd', 'chrIntrVals.jobDtclCd', 'actv.jobDtclCd'],
    
    // A-9. 세분류명 (jobDtclNm)
    ['summary.jobDtclNm', 'duty.jobDtclNm', 'path.jobDtclNm', 'salProspect.jobDtclNm', 'ablKnwEnv.jobDtclNm', 'chrIntrVals.jobDtclNm', 'actv.jobDtclNm'],
  ]

  // Build field to group mapping
  const fieldToGroupMap = new Map<string, string[]>()
  MERGEABLE_FIELD_GROUPS.forEach(group => {
    group.forEach(fieldPath => {
      fieldToGroupMap.set(fieldPath, group)
    })
  })

  // ========== MERGE FIELDS WITH SEMANTIC RULES ==========
  interface MergedField {
    paths: string[]  // Multiple field paths (only if semantically identical)
    sources: Array<{ source: 'careernet' | 'goyong24', value: any }>
    description?: string
  }
  
  // First, collect all fields with their values (excluding specified fields)
  const allFieldsWithValues = new Map<string, any>()
  careernetFields.forEach((value, key) => {
    if (!EXCLUDED_FIELDS.has(key)) {
      allFieldsWithValues.set(key, value)
    }
  })
  goyong24Fields.forEach((value, key) => {
    if (!EXCLUDED_FIELDS.has(key)) {
      allFieldsWithValues.set(key, value)
    }
  })
  
  // Create merged fields map
  const mergedFieldsMap = new Map<string, MergedField>()
  const processedFields = new Set<string>()
  
  // Process mergeable groups first
  MERGEABLE_FIELD_GROUPS.forEach(group => {
    // Find fields in this group that actually exist
    const existingFields = group.filter(fp => allFieldsWithValues.has(fp))
    
    if (existingFields.length === 0) return
    
    // Check if all existing fields have the same value
    const firstValue = allFieldsWithValues.get(existingFields[0])
    const firstValueStr = JSON.stringify(firstValue)
    const allSameValue = existingFields.every(fp => {
      return JSON.stringify(allFieldsWithValues.get(fp)) === firstValueStr
    })
    
    if (allSameValue && existingFields.length > 1) {
      // Merge these fields
      const representativeKey = existingFields.sort()[0]
      
      // Collect sources
      const sources: Array<{ source: 'careernet' | 'goyong24', value: any }> = []
      const addedSources = new Set<string>()
      
      existingFields.forEach(fieldPath => {
        if (careernetFields.has(fieldPath) && !addedSources.has('careernet')) {
          sources.push({ source: 'careernet', value: firstValue })
          addedSources.add('careernet')
        }
        if (goyong24Fields.has(fieldPath) && !addedSources.has('goyong24')) {
          sources.push({ source: 'goyong24', value: firstValue })
          addedSources.add('goyong24')
        }
      })
      
      mergedFieldsMap.set(representativeKey, {
        paths: existingFields.sort(),
        sources,
        description: undefined
      })
      
      // Mark as processed
      existingFields.forEach(fp => processedFields.add(fp))
    } else {
      // Values differ or only one field - keep separate
      existingFields.forEach(fieldPath => {
        const value = allFieldsWithValues.get(fieldPath)
        const source = careernetFields.has(fieldPath) ? 'careernet' : 'goyong24'
        
        mergedFieldsMap.set(fieldPath, {
          paths: [fieldPath],
          sources: [{ source, value }],
          description: undefined
        })
        
        processedFields.add(fieldPath)
      })
    }
  })
  
  // Process remaining fields (not in mergeable groups)
  allFieldsWithValues.forEach((value, fieldPath) => {
    if (processedFields.has(fieldPath)) return
    
    const source = careernetFields.has(fieldPath) ? 'careernet' : 'goyong24'
    
    mergedFieldsMap.set(fieldPath, {
      paths: [fieldPath],
      sources: [{ source, value }],
      description: undefined
    })
  })
  
  const allFieldPaths = new Set<string>(mergedFieldsMap.keys())

  // ========== SMART FIELD GROUPING ==========
  // Group semantically overlapping fields between CareerNet and Goyong24
  interface FieldGroup {
    label: string
    color: string
    fields: string[]
  }

  const overlappingGroups: FieldGroup[] = [
    {
      label: '🔑 직업 기본정보',
      color: 'bg-amber-50',
      fields: [
        'jobName',                           // 직업명 (우선순위: jobName → summary.jobNm → encyclopedia.baseInfo.job_nm)
        'encyclopedia.baseInfo.job_nm',      // 커리어넷: 직업명
        'summary.jobNm',                     // 고용24: 직업명
        'summary',                           // 고용24: 요약 (전체 객체)
        'summary.jobLrclNm',                 // 고용24: 직업 대분류
        'summary.jobMdclNm',                 // 고용24: 직업 중분류
        'summary.jobSmclNm',                 // 고용24: 직업 소분류
        'salProspect.jobLrclNm',             // 고용24 D04: 직업 대분류
        'salProspect.jobMdclNm',             // 고용24 D04: 직업 중분류
        'salProspect.jobSmclNm',             // 고용24 D04: 직업 소분류
        'ablKnwEnv.jobLrclNm',               // 고용24 D05: 직업 대분류
        'ablKnwEnv.jobMdclNm',               // 고용24 D05: 직업 중분류
        'ablKnwEnv.jobSmclNm',               // 고용24 D05: 직업 소분류
        'chrIntrVals.jobLrclNm',             // 고용24 D06: 직업 대분류
        'chrIntrVals.jobMdclNm',             // 고용24 D06: 직업 중분류
        'chrIntrVals.jobSmclNm',             // 고용24 D06: 직업 소분류
        'actv.jobLrclNm',                    // 고용24 D07: 직업 대분류
        'actv.jobMdclNm',                    // 고용24 D07: 직업 중분류
        'actv.jobSmclNm'                     // 고용24 D07: 직업 소분류
      ]
    },
    {
      label: '💰 임금 & 만족도',
      color: 'bg-green-50',
      fields: [
        // 임금: 디테일 수준 비교 → 최신 데이터 우선
        'encyclopedia.baseInfo.wage',           // 커리어넷: 임금
        'encyclopedia.baseInfo.wage_source',    // 커리어넷: 임금 출처
        'summary.sal',                          // 고용24 D01: 임금
        'salProspect.sal',                      // 고용24 D04: 임금 (상세)
        // 만족도: 디테일 수준 비교 → 최신 데이터 우선
        'encyclopedia.baseInfo.satisfication',  // 커리어넷: 직업만족도
        'encyclopedia.baseInfo.satisfi_source', // 커리어넷: 만족도 출처
        'summary.jobSatis',                     // 고용24 D01: 직업만족도
        'salProspect.jobSatis',                 // 고용24 D04: 직업만족도 (상세)
        // 기타 평가 지표
        'encyclopedia.baseInfo.social',         // 커리어넷: 사회적 평가
        'encyclopedia.baseInfo.wlb'             // 커리어넷: 워라밸
      ]
    },
    {
      label: '📈 일자리 전망 & 현황',
      color: 'bg-blue-50',
      fields: [
        // 전망: 가장 디테일한 것 선택 (salProspect.jobProspect 우선)
        'encyclopedia.forecastList',                 // 커리어넷: 전망
        'summary.jobProspect',                       // 고용24 D01: 일자리 전망
        'salProspect.jobProspect',                   // 고용24 D04: 일자리 전망 (상세)
        'salProspect.jobSumProspect',                // 고용24 D04: 일자리 전망 상세 (배열)
        'salProspect.jobSumProspect[0]',
        'salProspect.jobSumProspect[0].jobProspectNm',
        'salProspect.jobSumProspect[0].jobProspectRatio',
        'salProspect.jobSumProspect[0].jobProspectInqYr'
      ]
    },
    {
      label: '💼 하는 일 & 업무수행',
      color: 'bg-purple-50',
      fields: [
        // 요약용: summary.jobSum 또는 duty.jobSum
        'summary.jobSum',                    // 고용24 D01: 하는 일 (요약)
        'duty.jobSum',                       // 고용24 D02: 직업 요약
        // 상세용: encyclopedia.workList 또는 duty.execJob
        'encyclopedia.workList',             // 커리어넷: 하는 일 목록 (상세)
        'duty.execJob',                      // 고용24 D02: 수행 직무 (상세 배열)
        'duty.execJob[0]',
        'duty.execJob[0].execJobNm',
        'duty.execJob[0].execJobCont',
        // 업무활동 평가
        'summary.jobActvImprtncs',           // 고용24 D01: 업무활동 중요도
        'summary.jobActvLvls',               // 고용24 D01: 업무활동 수준
        'encyclopedia.performList'           // 커리어넷: 업무수행 정보
      ]
    },
    {
      label: '🎓 교육 & 학력',
      color: 'bg-indigo-50',
      fields: [
        'path.educationDistribution',               // 고용24 D03: 학력 분포 (객체)
        'path.educationDistribution.eduCdList',     // 학력 코드 목록
        'path.educationDistribution.eduCdList[0]',
        'path.educationDistribution.eduNmList',     // 학력명 목록
        'path.educationDistribution.eduNmList[0]',
        'path.educationDistribution.eduRatioList',  // 학력 비율 목록
        'path.educationDistribution.eduRatioList[0]',
        'path.majorDistribution',                   // 고용24 D03: 전공 분포 (객체)
        'path.majorDistribution.majorCdList',       // 전공 코드 목록
        'path.majorDistribution.majorCdList[0]',
        'path.majorDistribution.majorNmList',       // 전공명 목록
        'path.majorDistribution.majorNmList[0]',
        'path.majorDistribution.majorRatioList',    // 전공 비율 목록
        'path.majorDistribution.majorRatioList[0]',
        'encyclopedia.departList',                  // 커리어넷: 관련 학과
        'summary.relMajorList',                     // 고용24 D01: 관련 전공 (배열)
        'summary.relMajorList[0]',
        'summary.relMajorList[0].majorCd',
        'summary.relMajorList[0].majorNm',
        'path.relMajorList',                        // 고용24 D03: 관련 전공 (배열)
        'path.relMajorList[0]',
        'path.relMajorList[0].majorCd',
        'path.relMajorList[0].majorNm'
      ]
    },
    {
      label: '📜 자격증 & 기관',
      color: 'bg-pink-50',
      fields: [
        'encyclopedia.certiList',              // 커리어넷: 관련 자격증
        'summary.relCertList',                 // 고용24 D01: 관련 자격증 (배열)
        'summary.relCertList[0]',
        'summary.relCertList[0].certNm',
        'path.relCertList',                    // 고용24 D03: 관련 자격증 (배열)
        'path.relCertList[0]',
        'encyclopedia.jobRelOrgList',          // 커리어넷: 관련 기관
        'path.relOrgList',                     // 고용24 D03: 관련 기관 (배열)
        'path.relOrgList[0]',
        'path.relOrgList[0].orgNm',
        'path.relOrgList[0].orgSiteUrl',
        'path.technKnow',                      // 고용24 D03: 필수 기술 및 지식
        // 학력 분포
        'encyclopedia.eduChart',               // 커리어넷: 학력 분포
        'path.educationDistribution.middleSchoolOrLess',  // 중졸이하
        'path.educationDistribution.highSchool',          // 고졸
        'path.educationDistribution.college',             // 전문대졸
        'path.educationDistribution.university',          // 대졸
        'path.educationDistribution.graduate',            // 대학원졸
        'path.educationDistribution.doctor',              // 박사졸
        // 전공 분포
        'encyclopedia.majorChart',             // 커리어넷: 전공 분포
        'path.majorDistribution.humanities',   // 인문계열
        'path.majorDistribution.social',       // 사회계열
        'path.majorDistribution.education',    // 교육계열
        'path.majorDistribution.engineering',  // 공학계열
        'path.majorDistribution.natural',      // 자연계열
        'path.majorDistribution.medical',      // 의학계열
        'path.majorDistribution.artsSports'    // 예체능계열
      ]
    },
    {
      label: '🧠 능력 & 지식',
      color: 'bg-teal-50',
      fields: [
        'encyclopedia.performList.perform',           // 커리어넷: 업무수행능력 평가 (하는 일 섹션에서 이동)
        'encyclopedia.abilityList',                   // 커리어넷: 필요 능력 목록
        'summary.jobAbil',                            // 고용24 D01: 업무수행능력
        'ablKnwEnv.jobAbilCmpr',                      // 고용24 D05: 업무수행능력 중요도 (직업내 비교) (배열)
        'ablKnwEnv.jobAbilCmpr[0]',
        'ablKnwEnv.jobAbilCmpr[0].jobAblStatusCmpr',
        'ablKnwEnv.jobAbilCmpr[0].jobAblNmCmpr',
        'ablKnwEnv.jobAbilCmpr[0].jobAblContCmpr',
        'ablKnwEnv.jobAbil',                          // 고용24 D05: 업무수행능력 (직업간) (배열)
        'ablKnwEnv.jobAbil[0]',
        'ablKnwEnv.jobAbil[0].jobAblStatus',
        'ablKnwEnv.jobAbil[0].jobAblNm',
        'ablKnwEnv.jobAbil[0].jobAblCont',
        'ablKnwEnv.jobAbilLvlCmpr',                   // 고용24 D05: 능력 수준 (직업내) (배열)
        'ablKnwEnv.jobAbilLvlCmpr[0]',
        'ablKnwEnv.jobAbilLvlCmpr[0].jobAblLvlStatusCmpr',
        'ablKnwEnv.jobAbilLvlCmpr[0].jobAblLvlNmCmpr',
        'ablKnwEnv.jobAbilLvlCmpr[0].jobAblLvlContCmpr',
        'ablKnwEnv.jobAbilLvl',                       // 고용24 D05: 능력 수준 (직업간) (배열)
        'ablKnwEnv.jobAbilLvl[0]',
        'ablKnwEnv.jobAbilLvl[0].jobAblLvlStatus',
        'ablKnwEnv.jobAbilLvl[0].jobAblLvlNm',
        'ablKnwEnv.jobAbilLvl[0].jobAblLvlCont',
        'encyclopedia.performList.knowledge',         // 커리어넷: 필요 지식
        'summary.knowldg',                            // 고용24 D01: 지식
        'ablKnwEnv.KnwldgCmpr',                       // 고용24 D05: 지식 (직업내) (배열)
        'ablKnwEnv.KnwldgCmpr[0]',
        'ablKnwEnv.KnwldgCmpr[0].knwldgStatusCmpr',
        'ablKnwEnv.KnwldgCmpr[0].knwldgNmCmpr',
        'ablKnwEnv.KnwldgCmpr[0].knwldgContCmpr',
        'ablKnwEnv.Knwldg',                           // 고용24 D05: 지식 (직업간) (배열)
        'ablKnwEnv.Knwldg[0]',
        'ablKnwEnv.Knwldg[0].knwldgStatus',
        'ablKnwEnv.Knwldg[0].knwldgNm',
        'ablKnwEnv.Knwldg[0].knwldgCont',
        'ablKnwEnv.KnwldgLvlCmpr',                    // 고용24 D05: 지식 수준 (직업내) (배열)
        'ablKnwEnv.KnwldgLvlCmpr[0]',
        'ablKnwEnv.KnwldgLvlCmpr[0].knwldgLvlStatusCmpr',
        'ablKnwEnv.KnwldgLvlCmpr[0].knwldgLvlNmCmpr',
        'ablKnwEnv.KnwldgLvlCmpr[0].knwldgLvlContCmpr',
        'ablKnwEnv.KnwldgLvl',                        // 고용24 D05: 지식 수준 (직업간) (배열)
        'ablKnwEnv.KnwldgLvl[0]',
        'ablKnwEnv.KnwldgLvl[0].knwldgLvlStatus',
        'ablKnwEnv.KnwldgLvl[0].knwldgLvlNm',
        'ablKnwEnv.KnwldgLvl[0].knwldgLvlCont'
      ]
    },
    {
      label: '🌍 업무환경',
      color: 'bg-cyan-50',
      fields: [
        'encyclopedia.performList.environment',        // 커리어넷: 업무환경
        'summary.jobEnv',                              // 고용24 D01: 업무환경
        'ablKnwEnv.jobsEnvCmpr',                       // 고용24 D05: 업무환경 (직업내) (배열)
        'ablKnwEnv.jobsEnvCmpr[0]',
        'ablKnwEnv.jobsEnvCmpr[0].jobEnvStatusCmpr',
        'ablKnwEnv.jobsEnvCmpr[0].jobEnvNmCmpr',
        'ablKnwEnv.jobsEnvCmpr[0].jobEnvContCmpr',
        'ablKnwEnv.jobsEnv',                           // 고용24 D05: 업무환경 (직업간) (배열)
        'ablKnwEnv.jobsEnv[0]',
        'ablKnwEnv.jobsEnv[0].jobEnvStatus',
        'ablKnwEnv.jobsEnv[0].jobEnvNm',
        'ablKnwEnv.jobsEnv[0].jobEnvCont'
      ]
    },
    {
      label: '🎭 성격 & 적성',
      color: 'bg-rose-50',
      fields: [
        'encyclopedia.aptitudeList',                // 커리어넷: 적성
        'encyclopedia.baseInfo.aptit_name',         // 커리어넷: 적성 유형
        'summary.jobChr',                           // 고용24 D01: 성격
        'chrIntrVals.jobChrCmpr',                   // 고용24 D06: 성격 (직업내) (배열)
        'chrIntrVals.jobChrCmpr[0]',
        'chrIntrVals.jobChrCmpr[0].jobChrStatusCmpr',
        'chrIntrVals.jobChrCmpr[0].jobChrNmCmpr',
        'chrIntrVals.jobChrCmpr[0].jobChrContCmpr',
        'chrIntrVals.jobChr',                       // 고용24 D06: 성격 (직업간) (배열)
        'chrIntrVals.jobChr[0]',
        'chrIntrVals.jobChr[0].jobChrStatus',
        'chrIntrVals.jobChr[0].jobChrNm',
        'chrIntrVals.jobChr[0].jobChrCont'
      ]
    },
    {
      label: '❤️ 흥미 & 가치관',
      color: 'bg-orange-50',
      fields: [
        'encyclopedia.interestList',                  // 커리어넷: 흥미
        'summary.jobIntrst',                          // 고용24 D01: 흥미
        'chrIntrVals.jobIntrstCmpr',                  // 고용24 D06: 흥미 (직업내) (배열)
        'chrIntrVals.jobIntrstCmpr[0]',
        'chrIntrVals.jobIntrstCmpr[0].jobIntrstStatusCmpr',
        'chrIntrVals.jobIntrstCmpr[0].jobIntrstNmCmpr',
        'chrIntrVals.jobIntrstCmpr[0].jobIntrstContCmpr',
        'chrIntrVals.jobIntrst',                      // 고용24 D06: 흥미 (직업간) (배열)
        'chrIntrVals.jobIntrst[0]',
        'chrIntrVals.jobIntrst[0].jobIntrstStatus',
        'chrIntrVals.jobIntrst[0].jobIntrstNm',
        'chrIntrVals.jobIntrst[0].jobIntrstCont',
        'summary.jobVals',                            // 고용24 D01: 직업가치관
        'chrIntrVals.jobValsCmpr',                    // 고용24 D06: 가치관 (직업내) (배열)
        'chrIntrVals.jobValsCmpr[0]',
        'chrIntrVals.jobValsCmpr[0].jobValsStatusCmpr',
        'chrIntrVals.jobValsCmpr[0].jobValsNmCmpr',
        'chrIntrVals.jobValsCmpr[0].jobValsContCmpr',
        'chrIntrVals.jobVals',                        // 고용24 D06: 가치관 (직업간) (배열)
        'chrIntrVals.jobVals[0]',
        'chrIntrVals.jobVals[0].jobValsStatus',
        'chrIntrVals.jobVals[0].jobValsNm',
        'chrIntrVals.jobVals[0].jobValsCont'
      ]
    },
    {
      label: '⚡ 업무활동',
      color: 'bg-lime-50',
      fields: [
        'actv.jobActvImprtncCmpr',                      // 고용24 D07: 업무활동 중요도 (직업내) (배열)
        'actv.jobActvImprtncCmpr[0]',
        'actv.jobActvImprtncCmpr[0].jobActvImprtncStatusCmpr',
        'actv.jobActvImprtncCmpr[0].jobActvImprtncNmCmpr',
        'actv.jobActvImprtncCmpr[0].jobActvImprtncContCmpr',
        'actv.jobActvImprtnc',                          // 고용24 D07: 업무활동 중요도 (직업간) (배열)
        'actv.jobActvImprtnc[0]',
        'actv.jobActvImprtnc[0].jobActvImprtncStatus',
        'actv.jobActvImprtnc[0].jobActvImprtncNm',
        'actv.jobActvImprtnc[0].jobActvImprtncCont',
        'actv.jobActvLvlCmpr',                          // 고용24 D07: 업무활동 수준 (직업내) (배열)
        'actv.jobActvLvlCmpr[0]',
        'actv.jobActvLvlCmpr[0].jobActvLvlStatusCmpr',
        'actv.jobActvLvlCmpr[0].jobActvLvlNmCmpr',
        'actv.jobActvLvlCmpr[0].jobActvLvlContCmpr',
        'actv.jobActvLvl',                              // 고용24 D07: 업무활동 수준 (직업간) (배열)
        'actv.jobActvLvl[0]',
        'actv.jobActvLvl[0].jobActvLvlStatus',
        'actv.jobActvLvl[0].jobActvLvlNm',
        'actv.jobActvLvl[0].jobActvLvlCont'
      ]
    },
    {
      label: '🔗 관련 정보',
      color: 'bg-violet-50',
      fields: [
        'summary.relJobList',                  // 고용24 D01: 관련 직업 (배열)
        'summary.relJobList[0]',
        'summary.relJobList[0].jobCd',
        'summary.relJobList[0].jobNm',
        'duty.relJobList',                     // 고용24 D02: 관련 직업 목록
        'encyclopedia.tagList',                // 커리어넷: 태그
        'encyclopedia.researchList',           // 커리어넷: 진로탐색
        'encyclopedia.jobReadyList',           // 커리어넷: 직업준비 (배열)
        'encyclopedia.jobReadyList[0]',
        'encyclopedia.jobReadyList[0].jobreadyText'
      ]
    },
    {
      label: '🎯 Career 경로',
      color: 'bg-emerald-50',
      fields: [
        'encyclopedia.jobReadyList.recruit',   // 입직 및 취업방법
        'encyclopedia.jobReadyList.certificate', // 관련자격증
        'encyclopedia.jobReadyList.training',  // 직업훈련
        'encyclopedia.jobReadyList.curriculum', // 정규교육과정
        'summary.way'                          // 고용24: 되는 길
      ]
    },
    {
      label: '📊 메타데이터 & 기타',
      color: 'bg-gray-50',
      fields: [
        'encyclopedia.baseInfo.reg_dt',          // 작성일
        'encyclopedia.baseInfo.edit_dt'          // 수정일
      ]
    }
  ]

  // Create ordered field list: overlapping groups first, then remaining fields
  const orderedFields: string[] = []
  const groupedFieldsSet = new Set<string>()

  // Add fields from overlapping groups
  overlappingGroups.forEach(group => {
    group.fields.forEach(field => {
      if (allFieldPaths.has(field)) {
        orderedFields.push(field)
        groupedFieldsSet.add(field)
      }
    })
  })

  // Add remaining ungrouped fields (sorted alphabetically)
  const remainingFields = Array.from(allFieldPaths)
    .filter(field => !groupedFieldsSet.has(field))
    .sort()
  
  orderedFields.push(...remainingFields)

  // Helper function to get group info for a field
  const getGroupInfo = (fieldPath: string): { label: string; color: string } | null => {
    for (const group of overlappingGroups) {
      if (group.fields.includes(fieldPath)) {
        return { label: group.label, color: group.color }
      }
    }
    return null
  }

  const sortedFields = orderedFields

  // Field descriptions mapping
  const fieldDescriptions: Record<string, string> = {
    // CareerNet Encyclopedia
    'encyclopedia': '📚 커리어넷 직업백과 (전체)',
    'encyclopedia.baseInfo': '기본 정보',
    'encyclopedia.baseInfo.job_nm': '직업명',
    'encyclopedia.baseInfo.job_cd': '직업코드',
    'encyclopedia.baseInfo.seq': '시퀀스 번호',
    'encyclopedia.baseInfo.wage': '임금 (만원)',
    'encyclopedia.baseInfo.satisfication': '직업만족도 (%)',
    'encyclopedia.baseInfo.social': '사회적 평가',
    'encyclopedia.baseInfo.wlb': '워라밸',
    'encyclopedia.baseInfo.aptit_name': '적성 유형',
    'encyclopedia.workList': '하는 일 목록',
    'encyclopedia.abilityList': '필요 능력 목록',
    'encyclopedia.performList': '업무수행 정보',
    'encyclopedia.performList.environment': '업무환경',
    'encyclopedia.performList.perform': '수행 내용',
    'encyclopedia.performList.knowledge': '필요 지식',
    'encyclopedia.departList': '관련 학과',
    'encyclopedia.certiList': '관련 자격증',
    'encyclopedia.aptitudeList': '적성',
    'encyclopedia.interestList': '흥미',
    'encyclopedia.tagList': '태그',
    'encyclopedia.researchList': '진로탐색',
    'encyclopedia.relVideoList': '관련 동영상',
    'encyclopedia.relSolList': '관련 솔루션',
    'encyclopedia.relJinsolList': '관련 진솔',
    'encyclopedia.jobReadyList': '직업준비',
    'encyclopedia.jobRelOrgList': '관련 기관',
    'encyclopedia.forecastList': '전망',
    'encyclopedia.eduChart': '학력 분포',
    'encyclopedia.majorChart': '전공 분포',
    'encyclopedia.indicatorChart': '지표 차트',
    
    // Goyong24
    'summary': 'D01: 요약',
    'summary.jobCd': '직업코드',
    'summary.jobNm': '직업명',
    'summary.jobLrclNm': '직업 대분류',
    'summary.jobMdclNm': '직업 중분류',
    'summary.jobSmclNm': '직업 소분류',
    'summary.jobSum': '하는 일',
    'summary.way': '되는 길',
    'summary.sal': '임금',
    'summary.jobSatis': '직업만족도',
    'summary.jobProspect': '일자리 전망',
    'summary.jobStatus': '일자리 현황',
    'summary.jobAbil': '업무수행능력',
    'summary.knowldg': '지식',
    'summary.jobEnv': '업무환경',
    'summary.jobChr': '성격',
    'summary.jobIntrst': '흥미',
    'summary.jobVals': '직업가치관',
    'summary.relMajorList': '관련 전공',
    'summary.relCertList': '관련 자격증',
    'summary.relJobList': '관련 직업',
    'summary.jobActvImprtncs': '업무활동 중요도',
    'summary.jobActvLvls': '업무활동 수준',
    
    'duty': 'D02: 하는 일',
    'duty.jobCd': '직업코드 (D02)',
    'duty.jobLrclNm': '직업 대분류 (D02)',
    'duty.jobMdclNm': '직업 중분류 (D02)',
    'duty.jobSmclNm': '직업 소분류 (D02)',
    'duty.jobSum': '직업 요약 (하는 일)',
    'duty.relJobList': '관련 직업 목록',
    'duty.execJob': '수행 직무',
    
    'path': 'D03: 교육/자격/훈련',
    'path.jobCd': '직업코드 (D03)',
    'path.jobLrclNm': '직업 대분류 (D03)',
    'path.jobMdclNm': '직업 중분류 (D03)',
    'path.jobSmclNm': '직업 소분류 (D03)',
    'path.technKnow': '필수 기술 및 지식',
    'path.educationDistribution': '학력 분포',
    'path.educationDistribution.middleSchoolOrLess': '중졸이하 비율',
    'path.educationDistribution.highSchool': '고졸 비율',
    'path.educationDistribution.college': '전문대졸 비율',
    'path.educationDistribution.university': '대졸 비율',
    'path.educationDistribution.graduate': '대학원졸 비율',
    'path.educationDistribution.doctor': '박사졸 비율',
    'path.majorDistribution': '전공 분포',
    'path.majorDistribution.humanities': '인문계열 비율',
    'path.majorDistribution.social': '사회계열 비율',
    'path.majorDistribution.education': '교육계열 비율',
    'path.majorDistribution.engineering': '공학계열 비율',
    'path.majorDistribution.natural': '자연계열 비율',
    'path.majorDistribution.medical': '의학계열 비율',
    'path.majorDistribution.artsSports': '예체능계열 비율',
    'path.relMajorList': '관련 전공 목록',
    'path.relCertList': '관련 자격증 목록',
    'path.relOrgList': '관련 기관',
    'path.kecoList': '한국고용직업분류',
    
    'salProspect': 'D04: 임금/직업만족도/전망',
    'salProspect.jobCd': '직업코드 (D04)',
    'salProspect.jobLrclNm': '직업 대분류 (D04)',
    'salProspect.jobMdclNm': '직업 중분류 (D04)',
    'salProspect.jobSmclNm': '직업 소분류 (D04)',
    'salProspect.sal': '임금',
    'salProspect.jobSatis': '직업만족도',
    'salProspect.jobProspect': '일자리 전망',
    'salProspect.jobSumProspect': '일자리 전망 상세',
    'salProspect.jobStatusList': '일자리 현황 목록',
    
    'ablKnwEnv': 'D05: 능력/지식/환경',
    'ablKnwEnv.jobCd': '직업코드 (D05)',
    'ablKnwEnv.jobLrclNm': '직업 대분류 (D05)',
    'ablKnwEnv.jobMdclNm': '직업 중분류 (D05)',
    'ablKnwEnv.jobSmclNm': '직업 소분류 (D05)',
    'ablKnwEnv.jobAbilCmpr': '업무수행능력 (직업내 비교)',
    'ablKnwEnv.jobAbil': '업무수행능력 (직업간 비교)',
    'ablKnwEnv.jobAbilLvlCmpr': '능력 수준 (직업내 비교)',
    'ablKnwEnv.jobAbilLvl': '능력 수준 (직업간 비교)',
    'ablKnwEnv.KnwldgCmpr': '지식 (직업내 비교)',
    'ablKnwEnv.Knwldg': '지식 (직업간 비교)',
    'ablKnwEnv.KnwldgLvlCmpr': '지식 수준 (직업내 비교)',
    'ablKnwEnv.KnwldgLvl': '지식 수준 (직업간 비교)',
    'ablKnwEnv.jobsEnvCmpr': '업무환경 (직업내 비교)',
    'ablKnwEnv.jobsEnv': '업무환경 (직업간 비교)',
    
    'chrIntrVals': 'D06: 성격/흥미/가치관',
    'chrIntrVals.jobCd': '직업코드 (D06)',
    'chrIntrVals.jobLrclNm': '직업 대분류 (D06)',
    'chrIntrVals.jobMdclNm': '직업 중분류 (D06)',
    'chrIntrVals.jobSmclNm': '직업 소분류 (D06)',
    'chrIntrVals.jobChrCmpr': '성격 (직업내 비교)',
    'chrIntrVals.jobChr': '성격 (직업간 비교)',
    'chrIntrVals.jobIntrstCmpr': '흥미 (직업내 비교)',
    'chrIntrVals.jobIntrst': '흥미 (직업간 비교)',
    'chrIntrVals.jobValsCmpr': '가치관 (직업내 비교)',
    'chrIntrVals.jobVals': '가치관 (직업간 비교)',
    
    'actv': 'D07: 업무활동',
    'actv.jobCd': '직업코드 (D07)',
    'actv.jobLrclNm': '직업 대분류 (D07)',
    'actv.jobMdclNm': '직업 중분류 (D07)',
    'actv.jobSmclNm': '직업 소분류 (D07)',
    'actv.jobActvImprtncCmpr': '업무활동 중요도 (직업내 비교)',
    'actv.jobActvImprtnc': '업무활동 중요도 (직업간 비교)',
    'actv.jobActvLvlCmpr': '업무활동 수준 (직업내 비교)',
    'actv.jobActvLvl': '업무활동 수준 (직업간 비교)',
    
    // Array fields and detailed sub-fields - 배열 필드 및 상세 하위 필드
    'duty.execJob[0]': '수행 직무 첫 아이템',
    'duty.execJob[0].execJobNm': '수행 직무명',
    'duty.execJob[0].execJobCont': '수행 직무 내용',
    
    'path.educationDistribution.eduCdList': '학력 코드 목록',
    'path.educationDistribution.eduCdList[0]': '학력 코드 (첫 항목)',
    'path.educationDistribution.eduNmList': '학력명 목록',
    'path.educationDistribution.eduNmList[0]': '학력명 (첫 항목)',
    'path.educationDistribution.eduRatioList': '학력 비율 목록',
    'path.educationDistribution.eduRatioList[0]': '학력 비율 (첫 항목)',
    
    'path.majorDistribution.majorCdList': '전공 코드 목록',
    'path.majorDistribution.majorCdList[0]': '전공 코드 (첫 항목)',
    'path.majorDistribution.majorNmList': '전공명 목록',
    'path.majorDistribution.majorNmList[0]': '전공명 (첫 항목)',
    'path.majorDistribution.majorRatioList': '전공 비율 목록',
    'path.majorDistribution.majorRatioList[0]': '전공 비율 (첫 항목)',
    
    'summary.relMajorList[0]': '관련 전공 첫 아이템 (D01)',
    'summary.relMajorList[0].majorCd': '전공 코드 (D01)',
    'summary.relMajorList[0].majorNm': '전공명 (D01)',
    'path.relMajorList[0]': '관련 전공 첫 아이템 (D03)',
    'path.relMajorList[0].majorCd': '전공 코드 (D03)',
    'path.relMajorList[0].majorNm': '전공명 (D03)',
    
    'summary.relCertList[0]': '관련 자격증 첫 아이템 (D01)',
    'summary.relCertList[0].certNm': '자격증명 (D01)',
    'path.relCertList[0]': '관련 자격증 첫 아이템 (D03)',
    
    'path.relOrgList[0]': '관련 기관 첫 아이템',
    'path.relOrgList[0].orgNm': '기관명',
    'path.relOrgList[0].orgSiteUrl': '기관 사이트 URL',
    
    'path.kecoList[0]': '한국고용직업분류 첫 아이템',
    'path.kecoList[0].kecoCd': 'KECO 코드',
    'path.kecoList[0].kecoNm': 'KECO 직업명',
    
    'salProspect.jobSumProspect[0]': '일자리 전망 상세 첫 아이템',
    'salProspect.jobSumProspect[0].jobProspectNm': '전망 항목명',
    'salProspect.jobSumProspect[0].jobProspectRatio': '전망 비율',
    'salProspect.jobSumProspect[0].jobProspectInqYr': '전망 조사 연도',
    
    'salProspect.jobStatusList[0]': '일자리 현황 첫 아이템',
    'salProspect.jobStatusList[0].jobCd': '직업코드',
    'salProspect.jobStatusList[0].jobNm': '직업명',
    
    // D05 능력/지식/환경 배열 필드들
    'ablKnwEnv.jobAbilCmpr[0]': '업무수행능력 (직업내) 첫 아이템',
    'ablKnwEnv.jobAbilCmpr[0].jobAblStatusCmpr': '능력 상태 (직업내)',
    'ablKnwEnv.jobAbilCmpr[0].jobAblNmCmpr': '능력명 (직업내)',
    'ablKnwEnv.jobAbilCmpr[0].jobAblContCmpr': '능력 내용 (직업내)',
    'ablKnwEnv.jobAbil[0]': '업무수행능력 (직업간) 첫 아이템',
    'ablKnwEnv.jobAbil[0].jobAblStatus': '능력 상태 (직업간)',
    'ablKnwEnv.jobAbil[0].jobAblNm': '능력명 (직업간)',
    'ablKnwEnv.jobAbil[0].jobAblCont': '능력 내용 (직업간)',
    
    'ablKnwEnv.jobAbilLvlCmpr[0]': '능력 수준 (직업내) 첫 아이템',
    'ablKnwEnv.jobAbilLvlCmpr[0].jobAblLvlStatusCmpr': '능력 수준 상태 (직업내)',
    'ablKnwEnv.jobAbilLvlCmpr[0].jobAblLvlNmCmpr': '능력 수준명 (직업내)',
    'ablKnwEnv.jobAbilLvlCmpr[0].jobAblLvlContCmpr': '능력 수준 내용 (직업내)',
    'ablKnwEnv.jobAbilLvl[0]': '능력 수준 (직업간) 첫 아이템',
    'ablKnwEnv.jobAbilLvl[0].jobAblLvlStatus': '능력 수준 상태 (직업간)',
    'ablKnwEnv.jobAbilLvl[0].jobAblLvlNm': '능력 수준명 (직업간)',
    'ablKnwEnv.jobAbilLvl[0].jobAblLvlCont': '능력 수준 내용 (직업간)',
    
    'ablKnwEnv.KnwldgCmpr[0]': '지식 (직업내) 첫 아이템',
    'ablKnwEnv.KnwldgCmpr[0].knwldgStatusCmpr': '지식 상태 (직업내)',
    'ablKnwEnv.KnwldgCmpr[0].knwldgNmCmpr': '지식명 (직업내)',
    'ablKnwEnv.KnwldgCmpr[0].knwldgContCmpr': '지식 내용 (직업내)',
    'ablKnwEnv.Knwldg[0]': '지식 (직업간) 첫 아이템',
    'ablKnwEnv.Knwldg[0].knwldgStatus': '지식 상태 (직업간)',
    'ablKnwEnv.Knwldg[0].knwldgNm': '지식명 (직업간)',
    'ablKnwEnv.Knwldg[0].knwldgCont': '지식 내용 (직업간)',
    
    'ablKnwEnv.KnwldgLvlCmpr[0]': '지식 수준 (직업내) 첫 아이템',
    'ablKnwEnv.KnwldgLvlCmpr[0].knwldgLvlStatusCmpr': '지식 수준 상태 (직업내)',
    'ablKnwEnv.KnwldgLvlCmpr[0].knwldgLvlNmCmpr': '지식 수준명 (직업내)',
    'ablKnwEnv.KnwldgLvlCmpr[0].knwldgLvlContCmpr': '지식 수준 내용 (직업내)',
    'ablKnwEnv.KnwldgLvl[0]': '지식 수준 (직업간) 첫 아이템',
    'ablKnwEnv.KnwldgLvl[0].knwldgLvlStatus': '지식 수준 상태 (직업간)',
    'ablKnwEnv.KnwldgLvl[0].knwldgLvlNm': '지식 수준명 (직업간)',
    'ablKnwEnv.KnwldgLvl[0].knwldgLvlCont': '지식 수준 내용 (직업간)',
    
    'ablKnwEnv.jobsEnvCmpr[0]': '업무환경 (직업내) 첫 아이템',
    'ablKnwEnv.jobsEnvCmpr[0].jobEnvStatusCmpr': '업무환경 상태 (직업내)',
    'ablKnwEnv.jobsEnvCmpr[0].jobEnvNmCmpr': '업무환경명 (직업내)',
    'ablKnwEnv.jobsEnvCmpr[0].jobEnvContCmpr': '업무환경 내용 (직업내)',
    'ablKnwEnv.jobsEnv[0]': '업무환경 (직업간) 첫 아이템',
    'ablKnwEnv.jobsEnv[0].jobEnvStatus': '업무환경 상태 (직업간)',
    'ablKnwEnv.jobsEnv[0].jobEnvNm': '업무환경명 (직업간)',
    'ablKnwEnv.jobsEnv[0].jobEnvCont': '업무환경 내용 (직업간)',
    
    // D06 성격/흥미/가치관 배열 필드들
    'chrIntrVals.jobChrCmpr[0]': '성격 (직업내) 첫 아이템',
    'chrIntrVals.jobChrCmpr[0].jobChrStatusCmpr': '성격 상태 (직업내)',
    'chrIntrVals.jobChrCmpr[0].jobChrNmCmpr': '성격명 (직업내)',
    'chrIntrVals.jobChrCmpr[0].jobChrContCmpr': '성격 내용 (직업내)',
    'chrIntrVals.jobChr[0]': '성격 (직업간) 첫 아이템',
    'chrIntrVals.jobChr[0].jobChrStatus': '성격 상태 (직업간)',
    'chrIntrVals.jobChr[0].jobChrNm': '성격명 (직업간)',
    'chrIntrVals.jobChr[0].jobChrCont': '성격 내용 (직업간)',
    
    'chrIntrVals.jobIntrstCmpr[0]': '흥미 (직업내) 첫 아이템',
    'chrIntrVals.jobIntrstCmpr[0].jobIntrstStatusCmpr': '흥미 상태 (직업내)',
    'chrIntrVals.jobIntrstCmpr[0].jobIntrstNmCmpr': '흥미명 (직업내)',
    'chrIntrVals.jobIntrstCmpr[0].jobIntrstContCmpr': '흥미 내용 (직업내)',
    'chrIntrVals.jobIntrst[0]': '흥미 (직업간) 첫 아이템',
    'chrIntrVals.jobIntrst[0].jobIntrstStatus': '흥미 상태 (직업간)',
    'chrIntrVals.jobIntrst[0].jobIntrstNm': '흥미명 (직업간)',
    'chrIntrVals.jobIntrst[0].jobIntrstCont': '흥미 내용 (직업간)',
    
    'chrIntrVals.jobValsCmpr[0]': '가치관 (직업내) 첫 아이템',
    'chrIntrVals.jobValsCmpr[0].jobValsStatusCmpr': '가치관 상태 (직업내)',
    'chrIntrVals.jobValsCmpr[0].jobValsNmCmpr': '가치관명 (직업내)',
    'chrIntrVals.jobValsCmpr[0].jobValsContCmpr': '가치관 내용 (직업내)',
    'chrIntrVals.jobVals[0]': '가치관 (직업간) 첫 아이템',
    'chrIntrVals.jobVals[0].jobValsStatus': '가치관 상태 (직업간)',
    'chrIntrVals.jobVals[0].jobValsNm': '가치관명 (직업간)',
    'chrIntrVals.jobVals[0].jobValsCont': '가치관 내용 (직업간)',
    
    // D07 업무활동 배열 필드들
    'actv.jobActvImprtncCmpr[0]': '업무활동 중요도 (직업내) 첫 아이템',
    'actv.jobActvImprtncCmpr[0].jobActvImprtncStatusCmpr': '업무활동 중요도 상태 (직업내)',
    'actv.jobActvImprtncCmpr[0].jobActvImprtncNmCmpr': '업무활동 중요도명 (직업내)',
    'actv.jobActvImprtncCmpr[0].jobActvImprtncContCmpr': '업무활동 중요도 내용 (직업내)',
    'actv.jobActvImprtnc[0]': '업무활동 중요도 (직업간) 첫 아이템',
    'actv.jobActvImprtnc[0].jobActvImprtncStatus': '업무활동 중요도 상태 (직업간)',
    'actv.jobActvImprtnc[0].jobActvImprtncNm': '업무활동 중요도명 (직업간)',
    'actv.jobActvImprtnc[0].jobActvImprtncCont': '업무활동 중요도 내용 (직업간)',
    
    'actv.jobActvLvlCmpr[0]': '업무활동 수준 (직업내) 첫 아이템',
    'actv.jobActvLvlCmpr[0].jobActvLvlStatusCmpr': '업무활동 수준 상태 (직업내)',
    'actv.jobActvLvlCmpr[0].jobActvLvlNmCmpr': '업무활동 수준명 (직업내)',
    'actv.jobActvLvlCmpr[0].jobActvLvlContCmpr': '업무활동 수준 내용 (직업내)',
    'actv.jobActvLvl[0]': '업무활동 수준 (직업간) 첫 아이템',
    'actv.jobActvLvl[0].jobActvLvlStatus': '업무활동 수준 상태 (직업간)',
    'actv.jobActvLvl[0].jobActvLvlNm': '업무활동 수준명 (직업간)',
    'actv.jobActvLvl[0].jobActvLvlCont': '업무활동 수준 내용 (직업간)',
    
    // 관련 정보 배열 필드들
    'summary.relJobList[0]': '관련 직업 첫 아이템',
    'summary.relJobList[0].jobCd': '관련 직업 코드',
    'summary.relJobList[0].jobNm': '관련 직업명',
    
    'encyclopedia.jobReadyList[0]': '직업준비 첫 아이템',
    'encyclopedia.jobReadyList[0].jobreadyText': '직업준비 텍스트',
    
    // ========== CareerNet 추가 필드 (미분류) ==========
    'jobName': '직업명 (jobName)',
    'jobdicSeq': '직업사전 시퀀스',
    'encyclopedia.baseInfo.INTRST_JOB_YN': '관심직업 설정여부',
    'encyclopedia.baseInfo.emp_job_nm': '고용코드명',
    'encyclopedia.baseInfo.emp_job_cd': '고용코드',
    'encyclopedia.baseInfo.rel_job_nm': '관련직업명',
    'encyclopedia.baseInfo.std_job_nm': '표준직업코드명',
    'encyclopedia.baseInfo.std_job_cd': '표준직업코드',
    'encyclopedia.baseInfo.wage_source': '평균연봉 출처',
    'encyclopedia.baseInfo.edit_dt': '수정일',
    'encyclopedia.baseInfo.reg_dt': '작성일',
    'encyclopedia.baseInfo.satisfi_source': '직업만족도 출처',
    'encyclopedia.baseInfo.tag': '태그',
    'encyclopedia.baseInfo.views': '조회수',
    'encyclopedia.baseInfo.likes': '추천수',
    
    // workList 상세
    'encyclopedia.workList[0].work': '하는 일 내용',
    
    // abilityList 상세
    'encyclopedia.abilityList[0].SORT_ORDR': '정렬순서',
    'encyclopedia.abilityList[0].ability_name': '핵심능력명',
    
    // departList 상세
    'encyclopedia.departList[0].depart_id': '관련학과 ID',
    'encyclopedia.departList[0].depart_name': '관련학과명',
    
    // certiList 상세
    'encyclopedia.certiList[0].certi': '자격증명',
    'encyclopedia.certiList[0].LINK': '자격증 링크',
    
    // aptitudeList 상세
    'encyclopedia.aptitudeList[0].aptitude': '적성명',
    
    // interestList 상세
    'encyclopedia.interestList[0].interest': '흥미명',
    
    // researchList 상세
    'encyclopedia.researchList[0].research': '진로탐색활동 내용',
    
    // relVideoList 상세
    'encyclopedia.relVideoList[0].video_name': '동영상 제목',
    'encyclopedia.relVideoList[0].video_id': '동영상 ID',
    'encyclopedia.relVideoList[0].THUMBNAIL_FILE_SER': '썸네일 ID',
    'encyclopedia.relVideoList[0].THUMNAIL_PATH': '썸네일 URL',
    'encyclopedia.relVideoList[0].OUTPATH3': '동영상 URL',
    'encyclopedia.relVideoList[0].CID': '콘텐츠 ID',
    
    // relSolList 상세
    'encyclopedia.relSolList[0].TRGET_SE': '타겟층',
    'encyclopedia.relSolList[0].cnslt': '진로상담 내용',
    'encyclopedia.relSolList[0].SJ': '제목',
    'encyclopedia.relSolList[0].CN': '내용',
    'encyclopedia.relSolList[0].REGIST_DT': '등록일',
    'encyclopedia.relSolList[0].cnslt_seq': '진로상담 ID',
    
    // relJinsolList 상세
    'encyclopedia.relJinsolList[0].SUBJECT': '관련자료명',
    'encyclopedia.relJinsolList[0].ALT': '관련자료 ID',
    'encyclopedia.relJinsolList[0].THUMBNAIL': '썸네일',
    'encyclopedia.relJinsolList[0].SEQ': '고유번호',
    
    // jobReadyList 상세 추가
    'encyclopedia.jobReadyList.recruit': '입직 및 취업방법',
    'encyclopedia.jobReadyList.certificate': '관련자격증',
    'encyclopedia.jobReadyList.training': '직업훈련',
    'encyclopedia.jobReadyList.curriculum': '정규교육과정',
    
    // jobRelOrgList 상세
    'encyclopedia.jobRelOrgList[0].rel_org': '관련기관명',
    'encyclopedia.jobRelOrgList[0].rel_org_url': '관련기관 URL',
    
    // forecastList 상세
    'encyclopedia.forecastList[0].forecast': '전망 내용',
    
    // eduChart 상세
    'encyclopedia.eduChart[0].chart_name': '학력명',
    'encyclopedia.eduChart[0].chart_data': '학력 데이터',
    'encyclopedia.eduChart[0].source': '학력 출처',
    
    // majorChart 상세
    'encyclopedia.majorChart[0].major': '전공계열명',
    'encyclopedia.majorChart[0].major_data': '전공 데이터',
    'encyclopedia.majorChart[0].source': '전공 출처',
    
    // indicatorChart 상세
    'encyclopedia.indicatorChart[0].indicator': '직업지표명',
    'encyclopedia.indicatorChart[0].indicator_data': '지표 데이터',
    'encyclopedia.indicatorChart[0].source': '지표 출처',
    
    // ========== Goyong24 추가 필드 (미분류) ==========
    // 분류 코드 필드들
    'summary.jobLrclCd': '대분류 코드',
    'summary.jobMdclCd': '중분류 코드',
    'summary.jobSmclCd': '소분류 코드',
    'summary.jobDtclCd': '세분류 코드',
    'summary.jobDtclNm': '세분류명',
    
    'duty.jobLrclCd': '대분류 코드 (D02)',
    'duty.jobMdclCd': '중분류 코드 (D02)',
    'duty.jobSmclCd': '소분류 코드 (D02)',
    'duty.jobDtclCd': '세분류 코드 (D02)',
    'duty.jobDtclNm': '세분류명 (D02)',
    
    'path.jobLrclCd': '대분류 코드 (D03)',
    'path.jobMdclCd': '중분류 코드 (D03)',
    'path.jobSmclCd': '소분류 코드 (D03)',
    'path.jobDtclCd': '세분류 코드 (D03)',
    'path.jobDtclNm': '세분류명 (D03)',
    'path.technKnow[0].technKnowNm': '기술/지식명',
    'path.technKnow[0].technKnowCont': '기술/지식 내용',
    'path.relCertList[0].certNm': '자격증명 (D03)',
    
    'salProspect.jobLrclCd': '대분류 코드 (D04)',
    'salProspect.jobMdclCd': '중분류 코드 (D04)',
    'salProspect.jobSmclCd': '소분류 코드 (D04)',
    'salProspect.jobDtclCd': '세분류 코드 (D04)',
    'salProspect.jobDtclNm': '세분류명 (D04)',
    'salProspect.jobStatusList[0].jobStatusYear': '일자리 현황 연도',
    'salProspect.jobStatusList[0].jobStatusCount': '일자리 현황 수',
    
    'ablKnwEnv.jobLrclCd': '대분류 코드 (D05)',
    'ablKnwEnv.jobMdclCd': '중분류 코드 (D05)',
    'ablKnwEnv.jobSmclCd': '소분류 코드 (D05)',
    'ablKnwEnv.jobDtclCd': '세분류 코드 (D05)',
    'ablKnwEnv.jobDtclNm': '세분류명 (D05)',
    
    'chrIntrVals.jobLrclCd': '대분류 코드 (D06)',
    'chrIntrVals.jobMdclCd': '중분류 코드 (D06)',
    'chrIntrVals.jobSmclCd': '소분류 코드 (D06)',
    'chrIntrVals.jobDtclCd': '세분류 코드 (D06)',
    'chrIntrVals.jobDtclNm': '세분류명 (D06)',
    
    'actv.jobLrclCd': '대분류 코드 (D07)',
    'actv.jobMdclCd': '중분류 코드 (D07)',
    'actv.jobSmclCd': '소분류 코드 (D07)',
    'actv.jobDtclCd': '세분류 코드 (D07)',
    'actv.jobDtclNm': '세분류명 (D07)'
  }

  const formatValue = (value: any): string => {
    if (value === null || value === undefined) {
      return '<span class="text-gray-300 text-xs italic">없음</span>'
    }
    
    if (Array.isArray(value)) {
      if (value.length === 0) {
        return '<span class="text-gray-400 text-xs italic">빈 배열</span>'
      }
      
      // 배열 내용을 펼쳐서 표시
      const itemsPreview = value.slice(0, 5).map((item, idx) => {
        if (typeof item === 'string') {
          const truncated = item.length > 50 ? item.substring(0, 50) + '...' : item
          return `<div class="ml-4 text-xs text-gray-600 border-l-2 border-blue-300 pl-2 py-1">
            <span class="text-blue-600 font-mono">[${idx}]</span> ${escapeHtml(truncated)}
          </div>`
        } else if (typeof item === 'object' && item !== null) {
          const keys = Object.keys(item).slice(0, 3)
          const preview = keys.map(k => {
            const v = String(item[k])
            const truncated = v.length > 30 ? v.substring(0, 30) + '...' : v
            return `<span class="text-gray-700">${k}: </span><span class="text-gray-800">${escapeHtml(truncated)}</span>`
          }).join(', ')
          return `<div class="ml-4 text-xs text-gray-600 border-l-2 border-purple-300 pl-2 py-1">
            <span class="text-purple-600 font-mono">[${idx}]</span> {${preview}${Object.keys(item).length > 3 ? ', ...' : ''}}
          </div>`
        } else {
          return `<div class="ml-4 text-xs text-gray-600 border-l-2 border-blue-300 pl-2 py-1">
            <span class="text-blue-600 font-mono">[${idx}]</span> ${escapeHtml(String(item))}
          </div>`
        }
      }).join('')
      
      const moreCount = value.length > 5 ? value.length - 5 : 0
      const moreText = moreCount > 0 ? `<div class="ml-4 text-xs text-gray-400 italic mt-1">... +${moreCount}개 항목 더</div>` : ''
      
      return `<div class="array-container">
        <div class="inline-block bg-blue-100 text-blue-800 text-xs font-semibold px-2 py-1 rounded mb-2">
          배열 (${value.length}개)
        </div>
        ${itemsPreview}
        ${moreText}
      </div>`
    }
    
    if (typeof value === 'object') {
      const keys = Object.keys(value)
      
      // 객체 내용을 펼쳐서 표시
      const keysPreview = keys.slice(0, 5).map(key => {
        const val = value[key]
        let valStr = ''
        
        if (val === null || val === undefined) {
          valStr = '<span class="text-gray-400 italic">null</span>'
        } else if (Array.isArray(val)) {
          valStr = `<span class="text-blue-600">[${val.length}개]</span>`
        } else if (typeof val === 'object') {
          valStr = `<span class="text-purple-600">{객체}</span>`
        } else {
          const str = String(val)
          const truncated = str.length > 40 ? str.substring(0, 40) + '...' : str
          valStr = `<span class="text-gray-800">${escapeHtml(truncated)}</span>`
        }
        
        return `<div class="ml-4 text-xs border-l-2 border-purple-300 pl-2 py-1">
          <span class="text-purple-700 font-semibold">${escapeHtml(key)}:</span> ${valStr}
        </div>`
      }).join('')
      
      const moreCount = keys.length > 5 ? keys.length - 5 : 0
      const moreText = moreCount > 0 ? `<div class="ml-4 text-xs text-gray-400 italic mt-1">... +${moreCount}개 키 더</div>` : ''
      
      return `<div class="object-container">
        <div class="inline-block bg-purple-100 text-purple-800 text-xs font-semibold px-2 py-1 rounded mb-2">
          객체 (${keys.length}개 키)
        </div>
        ${keysPreview}
        ${moreText}
      </div>`
    }
    
    const str = String(value)
    if (str.length > 150) {
      return `<span class="text-gray-700 text-sm">${escapeHtml(str.substring(0, 150))}<span class="text-gray-400">...</span></span>`
    }
    
    return `<span class="text-gray-700 text-sm">${escapeHtml(str)}</span>`
  }

  // Generate merged table rows with group headers
  const rows: string[] = []
  let currentGroup: string | null = null

  sortedFields.forEach(fieldPath => {
    const mergedField = mergedFieldsMap.get(fieldPath)
    if (!mergedField) return
    
    // Get field description
    const description = fieldDescriptions[fieldPath] || getFieldDescription(fieldPath)
    
    // Check if this field belongs to a group
    const groupInfo = getGroupInfo(fieldPath)
    
    // Add group header if starting a new group
    if (groupInfo && groupInfo.label !== currentGroup) {
      currentGroup = groupInfo.label
      rows.push(`
        <tr class="border-t-4 border-gray-300">
          <td colspan="3" class="px-4 py-3 ${groupInfo.color} font-bold text-sm text-gray-800">
            <div class="flex items-center">
              <span class="text-lg mr-2">${groupInfo.label}</span>
              <span class="text-xs text-gray-500 font-normal ml-auto">
                (${overlappingGroups.find(g => g.label === groupInfo.label)?.fields.filter(f => allFieldPaths.has(f)).length}개 필드)
              </span>
            </div>
          </td>
        </tr>
      `)
    } else if (!groupInfo && currentGroup !== '미분류') {
      // Add header for ungrouped fields section
      currentGroup = '미분류'
      rows.push(`
        <tr class="border-t-4 border-gray-400">
          <td colspan="3" class="px-4 py-3 bg-gray-100 font-bold text-sm text-gray-800">
            <div class="flex items-center">
              <span class="text-lg mr-2">📦 기타 미분류 필드</span>
              <span class="text-xs text-gray-500 font-normal ml-auto">
                (${remainingFields.length}개 필드)
              </span>
            </div>
          </td>
        </tr>
      `)
    }

    // Determine source indicators
    const hasCareernetData = mergedField.sources.some(s => s.source === 'careernet')
    const hasGoyong24Data = mergedField.sources.some(s => s.source === 'goyong24')
    
    let sourceIndicator = ''
    if (hasCareernetData && hasGoyong24Data) {
      sourceIndicator = '<span class="text-xs text-gray-600 font-semibold">📚 커리어넷 • 📊 고용24</span>'
    } else if (hasCareernetData) {
      sourceIndicator = '<span class="text-xs text-blue-600 font-semibold">📚 커리어넷</span>'
    } else if (hasGoyong24Data) {
      sourceIndicator = '<span class="text-xs text-green-600 font-semibold">📊 고용24</span>'
    }

    // Get merged value (prefer non-null values)
    const careernetSource = mergedField.sources.find(s => s.source === 'careernet')
    const goyong24Source = mergedField.sources.find(s => s.source === 'goyong24')
    
    let mergedValue = null
    let valueLabel = ''
    
    if (hasCareernetData && hasGoyong24Data) {
      // Both sources have data
      const careernetVal = careernetSource?.value
      const goyong24Val = goyong24Source?.value
      
      // Check if values are identical (for merged display)
      const careernetStr = JSON.stringify(careernetVal)
      const goyong24Str = JSON.stringify(goyong24Val)
      
      if (careernetStr === goyong24Str) {
        // Identical values - show once
        mergedValue = careernetVal
        valueLabel = '<span class="text-xs text-purple-600 font-semibold mb-1 block">✓ 동일한 값</span>'
      } else {
        // Different values - show both with labels
        mergedValue = `
          <div class="space-y-2">
            <div>
              <span class="text-xs text-blue-600 font-semibold block mb-1">📚 커리어넷:</span>
              <div class="pl-4">${formatValue(careernetVal)}</div>
            </div>
            <div>
              <span class="text-xs text-green-600 font-semibold block mb-1">📊 고용24:</span>
              <div class="pl-4">${formatValue(goyong24Val)}</div>
            </div>
          </div>
        `
        valueLabel = '<span class="text-xs text-orange-600 font-semibold mb-1 block">⚠ 다른 값</span>'
      }
    } else if (hasCareernetData) {
      mergedValue = careernetSource?.value
    } else if (hasGoyong24Data) {
      mergedValue = goyong24Source?.value
    }

    // Build unified field display
    const fieldPaths = mergedField.paths
    const fieldCount = fieldPaths.length
    
    // Create unified description
    let unifiedDescription = ''
    if (fieldCount > 1) {
      // Multiple fields with same value - create unified description
      const descriptions = fieldPaths.map(fp => fieldDescriptions[fp]).filter(Boolean)
      if (descriptions.length > 0) {
        // Use first description as base
        const baseDesc = descriptions[0]
        unifiedDescription = `${baseDesc} (${fieldCount}개 필드)`
      } else {
        unifiedDescription = `동일한 값을 가진 ${fieldCount}개 필드`
      }
    } else {
      // Single field - use its description
      unifiedDescription = description
    }
    
    // Build field paths display
    let fieldPathsDisplay = ''
    if (fieldCount === 1) {
      fieldPathsDisplay = `<div class="font-semibold text-gray-800">${escapeHtml(fieldPaths[0])}</div>`
    } else {
      // Show count badge and collapsible list
      const firstPath = fieldPaths[0]
      const remainingCount = fieldCount - 1
      
      fieldPathsDisplay = `
        <div class="font-semibold text-gray-800 mb-1">
          <span class="inline-flex items-center bg-purple-100 text-purple-800 text-xs font-bold px-2 py-1 rounded mr-2">
            ${fieldCount}개 병합
          </span>
          ${escapeHtml(firstPath)}
        </div>
        <details class="text-[10px] text-gray-600 mt-1">
          <summary class="cursor-pointer hover:text-purple-600 font-semibold">
            + ${remainingCount}개 필드 더 보기
          </summary>
          <div class="ml-4 mt-1 space-y-0.5">
            ${fieldPaths.slice(1).map(fp => `<div>• ${escapeHtml(fp)}</div>`).join('')}
          </div>
        </details>
      `
    }
    
    // Store all field paths in data attribute (for copy functionality)
    const allPathsJson = JSON.stringify(fieldPaths)

    // Add data row with checkbox
    const rowBgColor = groupInfo ? groupInfo.color : 'bg-white'
    rows.push(`
      <tr class="border-b border-gray-200 hover:bg-gray-50 transition-colors ${rowBgColor}" data-field-paths='${allPathsJson}'>
        <td class="px-4 py-3 text-center ${rowBgColor} border-r border-gray-200" style="width: 60px;">
          <input type="checkbox" class="field-checkbox w-4 h-4 text-purple-600 border-gray-300 rounded focus:ring-purple-500" 
                 data-field-paths='${allPathsJson}'>
        </td>
        <td class="px-4 py-3 font-mono text-xs text-gray-800 ${rowBgColor} sticky left-0 border-r border-gray-200" style="min-width: 350px;">
          ${fieldPathsDisplay}
          ${unifiedDescription ? `<div class="text-[10px] text-gray-500 mb-1 mt-1">${escapeHtml(unifiedDescription)}</div>` : ''}
          ${sourceIndicator}
        </td>
        <td class="px-4 py-3 text-sm ${rowBgColor}">
          ${valueLabel}
          ${typeof mergedValue === 'string' && mergedValue.includes('<div') ? mergedValue : formatValue(mergedValue)}
        </td>
      </tr>
    `)
  })

  const rowsHtml = rows.join('')

  // JavaScript for checkbox handling and copy functionality
  const scriptContent = `
    <script>
      (function() {
        const selectAllCheckbox = document.getElementById('select-all-fields');
        const fieldCheckboxes = document.querySelectorAll('.field-checkbox');
        const copyButton = document.getElementById('copy-selected-fields');
        const selectedCountSpan = document.getElementById('selected-count');
        
        // Update selected count
        function updateSelectedCount() {
          const checkedCount = document.querySelectorAll('.field-checkbox:checked').length;
          selectedCountSpan.textContent = checkedCount;
          
          // Update select all checkbox state
          if (checkedCount === 0) {
            selectAllCheckbox.checked = false;
            selectAllCheckbox.indeterminate = false;
          } else if (checkedCount === fieldCheckboxes.length) {
            selectAllCheckbox.checked = true;
            selectAllCheckbox.indeterminate = false;
          } else {
            selectAllCheckbox.checked = false;
            selectAllCheckbox.indeterminate = true;
          }
        }
        
        // Select all / deselect all
        selectAllCheckbox.addEventListener('change', function() {
          const isChecked = this.checked;
          fieldCheckboxes.forEach(checkbox => {
            checkbox.checked = isChecked;
          });
          updateSelectedCount();
        });
        
        // Individual checkbox change
        fieldCheckboxes.forEach(checkbox => {
          checkbox.addEventListener('change', updateSelectedCount);
        });
        
        // Copy selected fields to clipboard (including all merged field paths)
        copyButton.addEventListener('click', function() {
          const allSelectedPaths = [];
          
          document.querySelectorAll('.field-checkbox:checked').forEach(checkbox => {
            try {
              const pathsJson = checkbox.dataset.fieldPaths;
              if (pathsJson) {
                const paths = JSON.parse(pathsJson);
                allSelectedPaths.push(...paths);
              }
            } catch (e) {
              console.error('Failed to parse field paths:', e);
            }
          });
          
          if (allSelectedPaths.length === 0) {
            alert('선택된 필드가 없습니다.');
            return;
          }
          
          const text = allSelectedPaths.join('\\n');
          
          navigator.clipboard.writeText(text).then(() => {
            // Visual feedback
            const originalText = copyButton.innerHTML;
            copyButton.innerHTML = '<svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>복사 완료! (' + allSelectedPaths.length + '개)';
            copyButton.classList.remove('bg-purple-600', 'hover:bg-purple-700');
            copyButton.classList.add('bg-green-600');
            
            setTimeout(() => {
              copyButton.innerHTML = originalText;
              copyButton.classList.remove('bg-green-600');
              copyButton.classList.add('bg-purple-600', 'hover:bg-purple-700');
            }, 2000);
          }).catch(err => {
            alert('복사 실패: ' + err.message);
          });
        });
        
        // Initialize count
        updateSelectedCount();
      })();
    </script>
  `

  return `
    <div class="overflow-x-auto rounded-lg shadow-md">
      <div class="bg-gradient-to-r from-purple-600 to-purple-700 px-6 py-4">
        <h3 class="text-xl font-bold text-white flex items-center">
          <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
          </svg>
          병합된 필드 비교 (통합 뷰)
        </h3>
        <p class="text-purple-100 text-sm mt-1">
          의미 기반 스마트 병합 • ${sortedFields.length}개 통합 필드 (원본 ${careernetFields.size + goyong24Fields.size}개) • 
          커리어넷: ${careernetFields.size}개 • 고용24: ${goyong24Fields.size}개 • 
          병합 그룹: ${Array.from(mergedFieldsMap.values()).filter(f => f.paths.length > 1).length}개
        </p>
      </div>
      
      <!-- Control buttons -->
      <div class="bg-gray-100 px-6 py-3 border-b border-gray-300 flex items-center justify-between">
        <div class="flex items-center space-x-4">
          <label class="flex items-center space-x-2 cursor-pointer">
            <input type="checkbox" id="select-all-fields" class="w-4 h-4 text-purple-600 border-gray-300 rounded focus:ring-purple-500">
            <span class="text-sm font-semibold text-gray-700">전체 선택</span>
          </label>
          <span class="text-sm text-gray-600">
            선택됨: <span id="selected-count" class="font-bold text-purple-600">0</span>개
          </span>
        </div>
        <button id="copy-selected-fields" 
                class="px-4 py-2 bg-purple-600 hover:bg-purple-700 text-white text-sm font-semibold rounded-lg transition-colors flex items-center">
          <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3"></path>
          </svg>
          선택한 필드 복사
        </button>
      </div>
      
      <table class="w-full border border-gray-200 bg-white">
        <thead class="sticky top-0 z-10">
          <tr class="bg-gradient-to-r from-gray-700 to-gray-800 text-white">
            <th class="px-4 py-4 text-center text-sm font-bold bg-gray-800 border-r border-gray-600" style="width: 60px;">
              <svg class="w-4 h-4 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
            </th>
            <th class="px-4 py-4 text-left text-sm font-bold sticky left-0 bg-gray-800 border-r border-gray-600" style="min-width: 300px;">
              <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path>
              </svg>
              필드 경로 & 출처
            </th>
            <th class="px-4 py-4 text-left text-sm font-bold bg-purple-800" style="min-width: 400px;">
              <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.582 4 8 4s8-1.79 8-4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4"></path>
              </svg>
              병합된 데이터
            </th>
          </tr>
        </thead>
        <tbody>
          ${rowsHtml}
        </tbody>
      </table>
    </div>
    ${scriptContent}
  `
}

export const renderDataDebugPage = (params: DataDebugTemplateParams): string => {
  const { profile, partials, sources, rawApiData, pageType = 'job', rawData } = params

  const jobTitle = profile?.name || (pageType === 'major' ? '전공 정보' : '직업 정보')
  const careernetId = profile?.sourceIds?.careernet || 'N/A'
  const goyong24Id = profile?.sourceIds?.goyong24 || 'N/A'
  
  // For major pages with sample data, render simplified view
  const isMajorSampleData = pageType === 'major' && rawData && !rawApiData

  const styles = `
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
      
      body {
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      }
      
      .debug-container {
        animation: fadeIn 0.5s ease-in;
      }
      
      @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
      }
      
      .card-hover {
        transition: all 0.3s ease;
      }
      
      .card-hover:hover {
        transform: translateY(-2px);
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
      }
      
      .gradient-text {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
      }
      
      table {
        font-size: 0.875rem;
      }
      
      th {
        text-transform: uppercase;
        letter-spacing: 0.05em;
      }
    </style>
  `

  return `
    <!DOCTYPE html>
    <html lang="ko">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>API 데이터 디버그 - ${escapeHtml(jobTitle)}</title>
      <script src="https://cdn.tailwindcss.com"></script>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
      ${styles}
    </head>
    <body class="min-h-screen py-8 px-4">
      <div class="max-w-[1600px] mx-auto debug-container space-y-6">
        
        <!-- Header -->
        <div class="bg-white rounded-2xl shadow-2xl p-8 card-hover">
          <div class="flex items-center justify-between mb-6">
            <div>
              <h1 class="text-4xl font-bold gradient-text mb-2">
                <i class="fas fa-database mr-3"></i>
                API 데이터 디버그
              </h1>
              <p class="text-2xl font-semibold text-gray-800">${escapeHtml(jobTitle)}</p>
            </div>
            <!-- 일반 페이지 링크 제거됨 -->
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="bg-gradient-to-br from-blue-50 to-blue-100 border-2 border-blue-300 rounded-xl p-5">
              <div class="flex items-center mb-3">
                <svg class="w-6 h-6 text-blue-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
                <h3 class="text-sm font-bold text-blue-900 uppercase tracking-wide">커리어넷 ID</h3>
              </div>
              <p class="text-2xl font-bold text-blue-700 mb-2">${escapeHtml(careernetId)}</p>
              <p class="text-xs text-gray-600 font-mono bg-white/50 p-2 rounded">
                JOB_VIEW?jobdicSeq=${escapeHtml(careernetId)}
              </p>
            </div>
            
            <div class="bg-gradient-to-br from-green-50 to-green-100 border-2 border-green-300 rounded-xl p-5">
              <div class="flex items-center mb-3">
                <svg class="w-6 h-6 text-green-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                </svg>
                <h3 class="text-sm font-bold text-green-900 uppercase tracking-wide">고용24 ID</h3>
              </div>
              <p class="text-2xl font-bold text-green-700 mb-2">${escapeHtml(goyong24Id)}</p>
              <p class="text-xs text-gray-600 font-mono bg-white/50 p-2 rounded">
                callOpenApiSvcInfo212D*?jobCd=${escapeHtml(goyong24Id)}
              </p>
            </div>
          </div>
        </div>

        <!-- API Status -->
        ${sources ? `
          <div class="bg-white rounded-2xl shadow-xl p-8 card-hover">
            <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
              <svg class="w-7 h-7 text-green-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
              API 호출 상태
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              ${Object.entries(sources).map(([source, status]) => `
                <div class="border-2 rounded-xl p-5 ${
                  status.attempted 
                    ? (status.error ? 'bg-red-50 border-red-300' : 'bg-green-50 border-green-300')
                    : 'bg-gray-50 border-gray-300'
                }">
                  <h3 class="font-bold text-lg mb-3 flex items-center">
                    <span class="text-2xl mr-2">${status.attempted ? (status.error ? '❌' : '✅') : '⏸️'}</span>
                    ${source}
                  </h3>
                  <div class="space-y-2 text-sm">
                    <div class="flex items-center">
                      <span class="text-gray-600 w-20">시도:</span>
                      <span class="font-mono font-semibold">${status.attempted ? 'YES' : 'NO'}</span>
                    </div>
                    ${status.count !== undefined ? `
                      <div class="flex items-center">
                        <span class="text-gray-600 w-20">결과:</span>
                        <span class="font-mono font-semibold text-green-700">${status.count}개</span>
                      </div>
                    ` : ''}
                    ${status.error ? `
                      <div class="flex items-start">
                        <span class="text-gray-600 w-20">에러:</span>
                        <span class="text-red-600 flex-1">${escapeHtml(status.error)}</span>
                      </div>
                    ` : ''}
                    ${status.skippedReason ? `
                      <div class="flex items-center">
                        <span class="text-gray-600 w-20">건너뜀:</span>
                        <span class="text-gray-500">${escapeHtml(status.skippedReason)}</span>
                      </div>
                    ` : ''}
                  </div>
                </div>
              `).join('')}
            </div>
          </div>
        ` : ''}

        ${isMajorSampleData ? `
        <!-- Major Sample Data View -->
        <div class="bg-white rounded-2xl shadow-xl p-8 card-hover">
          <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
            <svg class="w-7 h-7 text-purple-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
            </svg>
            전공 샘플 데이터
          </h2>
          <div class="mb-4 p-4 bg-amber-50 border-l-4 border-amber-500 rounded">
            <p class="text-sm text-amber-900">
              <strong>📌 참고:</strong> 전공 페이지는 현재 샘플 데이터로 표시됩니다. API 연동은 추후 구현 예정입니다.
            </p>
          </div>
          
          <!-- Profile Summary -->
          ${profile ? `
          <div class="space-y-6">
            <div class="border-2 border-gray-200 rounded-xl p-6 bg-gradient-to-br from-gray-50 to-white">
              <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                <i class="fas fa-graduation-cap text-blue-600 mr-2"></i>
                기본 정보
              </h3>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <span class="text-sm text-gray-600 font-semibold">전공명:</span>
                  <p class="text-lg font-bold text-gray-900">${escapeHtml(profile.name)}</p>
                </div>
                ${'categoryName' in profile && profile.categoryName ? `
                <div>
                  <span class="text-sm text-gray-600 font-semibold">계열:</span>
                  <p class="text-lg font-bold text-blue-700">${escapeHtml(profile.categoryName)}</p>
                </div>
                ` : ''}
                ${'summary' in profile && profile.summary ? `
                <div class="md:col-span-2">
                  <span class="text-sm text-gray-600 font-semibold">요약:</span>
                  <p class="text-gray-800 mt-1">${escapeHtml(profile.summary)}</p>
                </div>
                ` : ''}
              </div>
            </div>
            
            <!-- Main Subjects -->
            ${'mainSubjects' in profile && profile.mainSubjects && profile.mainSubjects.length > 0 ? `
            <div class="border-2 border-gray-200 rounded-xl p-6 bg-gradient-to-br from-blue-50 to-white">
              <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                <i class="fas fa-book text-blue-600 mr-2"></i>
                주요 과목 (${profile.mainSubjects.length}개)
              </h3>
              <ul class="grid grid-cols-1 md:grid-cols-2 gap-2">
                ${profile.mainSubjects.map((subject: string) => `
                  <li class="flex items-start">
                    <i class="fas fa-check-circle text-green-500 mr-2 mt-1"></i>
                    <span class="text-gray-800">${escapeHtml(subject)}</span>
                  </li>
                `).join('')}
              </ul>
            </div>
            ` : ''}
            
            <!-- Licenses -->
            ${'licenses' in profile && profile.licenses && profile.licenses.length > 0 ? `
            <div class="border-2 border-gray-200 rounded-xl p-6 bg-gradient-to-br from-green-50 to-white">
              <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                <i class="fas fa-certificate text-green-600 mr-2"></i>
                취득 가능 자격증 (${profile.licenses.length}개)
              </h3>
              <ul class="grid grid-cols-1 md:grid-cols-2 gap-2">
                ${profile.licenses.map((license: string) => `
                  <li class="flex items-start">
                    <i class="fas fa-award text-yellow-500 mr-2 mt-1"></i>
                    <span class="text-gray-800">${escapeHtml(license)}</span>
                  </li>
                `).join('')}
              </ul>
            </div>
            ` : ''}
            
            <!-- Related Jobs -->
            ${'relatedJobs' in profile && profile.relatedJobs && profile.relatedJobs.length > 0 ? `
            <div class="border-2 border-gray-200 rounded-xl p-6 bg-gradient-to-br from-purple-50 to-white">
              <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                <i class="fas fa-briefcase text-purple-600 mr-2"></i>
                관련 직업 (${profile.relatedJobs.length}개)
              </h3>
              <ul class="grid grid-cols-1 md:grid-cols-2 gap-2">
                ${profile.relatedJobs.map((job: string) => `
                  <li class="flex items-start">
                    <i class="fas fa-arrow-right text-purple-500 mr-2 mt-1"></i>
                    <span class="text-gray-800">${escapeHtml(job)}</span>
                  </li>
                `).join('')}
              </ul>
            </div>
            ` : ''}
            
            <!-- Full Profile JSON -->
            <div class="border-2 border-gray-200 rounded-xl p-6 bg-gradient-to-br from-gray-50 to-white">
              <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                <i class="fas fa-code text-gray-600 mr-2"></i>
                전체 프로필 데이터 (JSON)
              </h3>
              <pre class="bg-gray-900 text-green-400 p-4 rounded-lg overflow-x-auto text-xs font-mono"><code>${escapeHtml(JSON.stringify(profile, null, 2))}</code></pre>
            </div>
          </div>
          ` : '<p class="text-gray-500">프로필 데이터 없음</p>'}
        </div>
        ` : `
        <!-- Actual Merged View - 먼저 표시 -->
        <div class="bg-white rounded-2xl shadow-xl p-8 card-hover">
          <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
            <svg class="w-7 h-7 text-blue-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
            </svg>
            실제 뷰 (Actual Merged View)
          </h2>
          <div class="mb-4 p-4 bg-blue-50 border-l-4 border-blue-500 rounded">
            <p class="text-sm text-blue-900">
              <strong>💡 이 섹션은</strong> 실제 변호사 페이지(<code class="bg-blue-100 px-2 py-1 rounded">/job/lawyer</code>)에서 사용자에게 보이는 데이터를 보여줍니다.
            </p>
          </div>
          ${renderActualMergedView(rawApiData)}
        </div>

        <!-- Field Comparison - 나중에 표시 -->
        <div class="bg-white rounded-2xl shadow-xl p-8 card-hover mt-8">
          <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
            <svg class="w-7 h-7 text-purple-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17V7m0 10a2 2 0 01-2 2H5a2 2 0 01-2-2V7a2 2 0 012-2h2a2 2 0 012 2m0 10a2 2 0 002 2h2a2 2 0 002-2M9 7a2 2 0 012-2h2a2 2 0 012 2m0 10V7m0 10a2 2 0 002 2h2a2 2 0 002-2V7a2 2 0 00-2-2h-2a2 2 0 00-2 2"></path>
            </svg>
            병합 후 필드 비교
          </h2>
          ${renderFieldComparisonTable(rawApiData)}
        </div>

        <!-- CareerNet Encyclopedia (jobs.json) -->
        ${rawApiData?.careernet?.encyclopedia ? renderEncyclopediaTable(rawApiData.careernet.encyclopedia) : ''}

        <!-- CareerNet Job Info (getOpenApi) -->
        <div class="card-hover">
          ${renderCareerNetTable(rawApiData?.careernet)}
        </div>

        <!-- Goyong24 Raw Data -->
        <div class="card-hover">
          ${renderGoyong24Table(rawApiData?.goyong24)}
        </div>
        `}

        <!-- Footer 제거됨 -->
        
      </div>
    </body>
    </html>
  `
}
