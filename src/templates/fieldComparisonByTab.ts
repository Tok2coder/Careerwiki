/**
 * 필드 비교 테이블 렌더링 (탭별/섹션별 분류)
 * 템플릿 구조에 맞춰 필드를 분류하여 표시
 */

import { escapeHtml } from './detailTemplateUtils'

// ========== 필드 분류 (템플릿 구조 기반) ==========
const FIELD_TAB_MAPPING: Record<string, { tab: string; section?: string }> = {
  // [히어로 섹션]
  'name': { tab: '히어로', section: '전공명' },
  'categoryName': { tab: '히어로', section: '계열 배지 (전공명 상단)' },
  'summary': { tab: '히어로', section: '요약 설명 (전공명 하단)' },
  
  // [개요 탭]
  'property': { tab: '개요', section: '전공 특성' },
  'aptitude': { tab: '개요', section: '이 전공에 어울리는 사람' },
  'interest': { tab: '개요', section: '이 전공에 어울리는 사람' },
  'enterField': { tab: '개요', section: '졸업 후 진출 분야' },
  'enter_field': { tab: '개요', section: '졸업 후 진출 분야' },
  'salaryAfterGraduation': { tab: '개요', section: '핵심 지표' },
  'salary': { tab: '개요', section: '핵심 지표' },
  'employmentRate': { tab: '개요', section: '핵심 지표' },
  'employment': { tab: '개요', section: '핵심 지표' },
  'lstMiddleAptd': { tab: '개요', section: '적성 프로필 (중학생)' },
  'lstHighAptd': { tab: '개요', section: '적성 프로필 (고등학생)' },
  'lstVals': { tab: '개요', section: '가치관' },
  
  // [상세정보 탭 - 커리큘럼]
  'relateSubject': { tab: '상세정보', section: '고교 추천 교과목' },
  'relate_subject': { tab: '상세정보', section: '고교 추천 교과목' },
  'mainSubjects': { tab: '상세정보', section: '주요 교과목' },
  'mainSubject': { tab: '상세정보', section: '대학 주요 교과목 상세' },
  'main_subject': { tab: '상세정보', section: '대학 주요 교과목 상세' },
  'whatStudy': { tab: '상세정보', section: '무엇을 배우나요?' },
  'howPrepare': { tab: '상세정보', section: '어떻게 준비하나요?' },
  'careerAct': { tab: '상세정보', section: '진로 탐색 활동' },
  'career_act': { tab: '상세정보', section: '진로 탐색 활동' },
  'licenses': { tab: '상세정보', section: '추천 자격증' },
  'qualifications': { tab: '상세정보', section: '추천 자격증' },
  
  // [상세정보 탭 - 진로·전망]
  'jobProspect': { tab: '상세정보', section: '진로 전망' },
  'chartData': { tab: '상세정보', section: '통계 정보 (차트)' },
  
  // [상세정보 탭 - 추천 유사 전공]
  'relatedMajors': { tab: '상세정보', section: '추천 유사 전공' },
  'department': { tab: '상세정보', section: '추천 유사 전공' },
  
  // [개설 대학 탭]
  'universities': { tab: '개설 대학', section: '개설 대학' },
  'university': { tab: '개설 대학', section: '개설 대학' },
  'universityList': { tab: '개설 대학', section: '개설 대학' },
  'recruitmentStatus': { tab: '개설 대학', section: '모집 정원 & 지원 현황' },
  
  // [사이드바]
  'relatedJobs': { tab: '사이드바', section: '관련 직업' },
  'job': { tab: '사이드바', section: '관련 직업' },
  'relatedJob': { tab: '사이드바', section: '관련 직업' }
}

// ========== 필드 설명 맵 (간소화 버전) ==========
const FIELD_DESCRIPTIONS: Record<string, string> = {
  // CareerNet
  'major': '학과명 (CareerNet)',
  'name': '전공명 (통합)',
  'categoryName': '전공 계열명',
  'salary': '졸업 후 직장임금',
  'employment': '취업률',
  'summary': '학과개요',
  'property': '학과특성',
  'interest': '흥미와적성',
  'aptitude': '적성 및 흥미',
  'enter_field': '졸업 후 진출분야',
  'relate_subject': '관련 고교 교과목',
  'career_act': '진로 탐색 활동',
  'main_subject': '대학 주요 교과목',
  'job': '관련직업',
  'qualifications': '관련자격',
  'department': '세부관련학과',
  'university': '개설대학',
  'lstMiddleAptd': '중학생 적성 순위',
  'lstHighAptd': '고등학생 적성 순위',
  'lstVals': '가치관 순위',
  'chartData': '학과 통계 차트',
  
  // 고용24
  'knowDptNm': '계열명 (고용24)',
  'knowSchDptNm': '학과명 (고용24)',
  'schDptIntroSum': '학과소개 개요',
  'aptdIntrstCont': '적성/흥미 내용',
  'relSchDptList': '관련학과',
  'mainSubjectList': '주요 교과목',
  'licList': '취득 자격',
  'schDptList': '개설 대학 전공',
  'relAdvanJobsList': '관련직업',
  'recrStateList': '모집현황',
  'whatStudy': '하는 공부',
  'howPrepare': '준비방법',
  'jobPropect': '직업 전망',
  
  // 통합 필드
  'salaryAfterGraduation': '졸업 후 평균 연봉 (통합)',
  'employmentRate': '취업률 (통합)',
  'enterField': '졸업 후 진출 분야 (통합)',
  'relateSubject': '관련 고교 교과목 (통합)',
  'careerAct': '진로 탐색 활동 (통합)',
  'mainSubject': '대학 주요 교과목 (통합)',
  'mainSubjects': '주요 학습 과목 (통합)',
  'relatedJobs': '졸업 후 관련 직업 (통합)',
  'licenses': '취득 가능 자격증 (통합)',
  'relatedMajors': '관련 학과 목록 (통합)',
  'universities': '개설 대학 정보 (통합)',
  'recruitmentStatus': '모집 현황 (통합)',
  'jobProspect': '직업 전망 (통합)'
}

interface FieldValue {
  source: 'careernet' | 'goyong24'
  value: any
}

interface FieldsByTab {
  [tab: string]: {
    [section: string]: Array<{
      fieldKey: string
      values: FieldValue[]
    }>
  }
}

/**
 * 객체를 flat한 dot notation으로 변환
 */
function flattenObject(obj: any, prefix: string = ''): Map<string, any> {
  const result = new Map<string, any>()
  
  if (!obj || typeof obj !== 'object') {
    result.set(prefix, obj)
    return result
  }

  if (Array.isArray(obj)) {
    result.set(prefix, obj)
    // 첫 번째 아이템만 flatten
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

/**
 * 필드를 탭별/섹션별로 분류하여 렌더링
 */
export function renderFieldComparisonByTab(rawApiData?: { careernet?: any; goyong24?: any }): string {
  if (!rawApiData) {
    return '<p class="text-gray-500">원본 API 데이터 없음</p>'
  }

  const careernet = rawApiData.careernet
  const goyong24 = rawApiData.goyong24

  // Flatten
  const careernetFields = careernet ? flattenObject(careernet) : new Map()
  const goyong24Fields = goyong24 ? flattenObject(goyong24) : new Map()

  // 모든 unique 필드 수집
  const allFieldKeys = new Set<string>()
  careernetFields.forEach((_, key) => allFieldKeys.add(key))
  goyong24Fields.forEach((_, key) => allFieldKeys.add(key))

  // 탭별/섹션별 분류
  const fieldsByTab: FieldsByTab = {}

  allFieldKeys.forEach(fieldKey => {
    // 배열 인덱스 제거 (예: licenses[0] -> licenses)
    const baseFieldKey = fieldKey.replace(/\[\d+\]/g, '')
    
    // 탭/섹션 정보 가져오기
    const mapping = FIELD_TAB_MAPPING[baseFieldKey] || FIELD_TAB_MAPPING[fieldKey]
    const tab = mapping?.tab || '기타'
    const section = mapping?.section || '미분류'
    
    if (!fieldsByTab[tab]) {
      fieldsByTab[tab] = {}
    }
    if (!fieldsByTab[tab][section]) {
      fieldsByTab[tab][section] = []
    }
    
    // 값 수집
    const values: FieldValue[] = []
    if (careernetFields.has(fieldKey)) {
      values.push({ source: 'careernet', value: careernetFields.get(fieldKey) })
    }
    if (goyong24Fields.has(fieldKey)) {
      values.push({ source: 'goyong24', value: goyong24Fields.get(fieldKey) })
    }
    
    if (values.length > 0) {
      fieldsByTab[tab][section].push({ fieldKey, values })
    }
  })

  // 탭 순서 정의
  const TAB_ORDER = ['히어로', '개요', '상세정보', '개설 대학', '사이드바', '기타']
  
  const hasFields = Object.keys(fieldsByTab).length > 0
  
  if (!hasFields) {
    return '<p class="text-gray-500">표시할 필드 없음</p>'
  }

  return `
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <table class="w-full border-collapse">
        <thead>
          <tr class="bg-gradient-to-r from-purple-600 to-indigo-600">
            <th class="px-6 py-4 text-left text-white font-bold w-1/6">탭</th>
            <th class="px-6 py-4 text-left text-white font-bold w-1/6">섹션</th>
            <th class="px-6 py-4 text-left text-white font-bold w-1/4">필드명</th>
            <th class="px-6 py-4 text-left text-white font-bold w-1/12">출처</th>
            <th class="px-6 py-4 text-left text-white font-bold w-1/3">값</th>
          </tr>
        </thead>
        <tbody>
          ${TAB_ORDER.filter(tabName => fieldsByTab[tabName]).map((tabName) => {
            const tab = fieldsByTab[tabName]
            const sections = Object.keys(tab).sort()
            
            return sections.map((sectionName, sectionIdx) => {
              const fields = tab[sectionName]
              
              return fields.map((field, fieldIdx) => {
                const description = FIELD_DESCRIPTIONS[field.fieldKey] || FIELD_DESCRIPTIONS[field.fieldKey.replace(/\[\d+\]/g, '')] || ''
                const isFirstFieldInSection = fieldIdx === 0
                const rowClass = (sectionIdx % 2 === 0) ? 'bg-gray-50' : 'bg-white'
                
                const valueCell = field.values.map(src => {
                  const valueStr = typeof src.value === 'object' 
                    ? JSON.stringify(src.value, null, 2).slice(0, 200) + (JSON.stringify(src.value).length > 200 ? '...' : '')
                    : String(src.value)
                  const srcLabel = src.source === 'careernet' ? '📚 CareerNet' : '📊 Goyong24'
                  return `<div class="mb-2"><span class="text-xs font-semibold text-blue-600">${srcLabel}</span>: <span class="text-gray-700">${escapeHtml(valueStr)}</span></div>`
                }).join('')
                
                const tabCell = (sectionIdx === 0 && fieldIdx === 0) 
                  ? `<td class="px-6 py-4 align-top font-bold text-purple-700 bg-purple-50 border-r-2 border-purple-300" rowspan="${sections.reduce((sum, sec) => sum + tab[sec].length, 0)}">${escapeHtml(tabName)}</td>`
                  : ''
                
                const sectionCell = isFirstFieldInSection
                  ? `<td class="px-6 py-4 align-top font-semibold text-indigo-700 bg-indigo-50 border-r border-indigo-200" rowspan="${fields.length}">${escapeHtml(sectionName)}</td>`
                  : ''
                
                return `
                  <tr class="${rowClass} border-b border-gray-200 hover:bg-blue-50 transition-colors">
                    ${tabCell}
                    ${sectionCell}
                    <td class="px-6 py-4 align-top">
                      <div class="font-semibold text-gray-800 mb-1 text-sm">${escapeHtml(field.fieldKey)}</div>
                      ${description ? `<div class="text-xs text-gray-500 mt-1">${escapeHtml(description)}</div>` : ''}
                    </td>
                    <td class="px-6 py-4 align-top">
                      ${field.values.map(src => {
                        const srcLabel = src.source === 'careernet' ? '📚' : '📊'
                        return `<div class="text-sm mb-1">${srcLabel}</div>`
                      }).join('')}
                    </td>
                    <td class="px-6 py-4 align-top">
                      <div class="text-xs">${valueCell}</div>
                    </td>
                  </tr>
                `
              }).join('')
            }).join('')
          }).join('')}
        </tbody>
      </table>
    </div>
    
    <div class="mt-6 bg-gradient-to-r from-purple-50 to-indigo-50 rounded-lg p-4 text-sm text-gray-700">
      <h4 class="font-bold mb-2 text-purple-800">📋 필드 분류 기준</h4>
      <ul class="space-y-1 ml-4">
        <li>✅ <strong>실제 템플릿 구조</strong>를 기반으로 분류</li>
        <li>🎯 <strong>탭</strong>: 히어로, 개요, 상세정보, 개설 대학, 사이드바</li>
        <li>📂 <strong>섹션</strong>: 각 탭 내의 세부 카드/섹션</li>
        <li>📚 <strong>출처</strong>: 📚 = CareerNet, 📊 = 고용24</li>
      </ul>
    </div>
  `
}

