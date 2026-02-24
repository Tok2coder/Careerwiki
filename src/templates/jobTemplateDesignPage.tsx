import type { UnifiedJobDetail } from '../types/unifiedProfiles'
import type { JobSourceRow } from '../types/database'

// 소스별 색상
const SOURCE_COLORS = {
  CAREERNET: { border: 'border-blue-500', bg: 'bg-blue-500/10', text: 'text-blue-400' },
  WORK24_JOB: { border: 'border-green-500', bg: 'bg-green-500/10', text: 'text-green-400' },
  WORK24_DJOB: { border: 'border-purple-500', bg: 'bg-purple-500/10', text: 'text-purple-400' }
}

const SOURCE_LABELS = {
  CAREERNET: '커리어넷',
  WORK24_JOB: '고용24 직업정보',
  WORK24_DJOB: '고용24 직업사전'
}

// 히어로 섹션 필드
interface HeroField {
  label: string
  sources: Array<{ sourceType: string; path: string; value: any }>
}

// 확장된 필드 정의 - 실제 템플릿의 모든 섹션 포함
interface FieldDefinition {
  label: string
  careernetPaths: string[]
  work24JobPaths: string[]
  work24DjobPaths: string[]
  section: 'overview' | 'details' | 'characteristics'
  subsection?: string
  alwaysShow?: boolean // 데이터 없어도 표시
}

// =====================================================
// 직업사전 API (WORK24_DJOB) 실제 제공 필드 목록
// - dJobCd, dJobCdSeq, dJobNm (직업코드/명)
// - workSum (직무개요), doWork (수행직무)
// - optionJobInfo: eduLevel, skillYear, workStrong, workPlace, 
//   physicalAct, workEnv, workFunc1/2/3, similarNm, connectJob,
//   certLic, dJobECd/Nm, dJobJCd/Nm, dJobICd/Nm, inqYear, etc
// =====================================================

const FIELD_DEFINITIONS: FieldDefinition[] = [
  // === 개요 탭 ===
  
  // 하는 일
  {
    label: '직업명',
    careernetPaths: ['name', 'duty.job_nm'],
    work24JobPaths: ['name', 'jobNm'],
    work24DjobPaths: ['dJobNm'],
    section: 'overview',
    subsection: '하는 일',
    alwaysShow: true
  },
  {
    label: '직업 소개 (요약)',
    careernetPaths: ['summary', 'duty.job_summary'],
    work24JobPaths: ['summary', 'duty.jobSum'],
    work24DjobPaths: ['workSum'],
    section: 'overview',
    subsection: '하는 일',
    alwaysShow: true
  },
  {
    label: '주요 업무',
    careernetPaths: ['duties', 'encyclopedia.workList'],
    work24JobPaths: ['duties', 'duty.jobSum', 'summary.jobSum'],
    work24DjobPaths: ['doWork'],
    section: 'overview',
    subsection: '하는 일',
    alwaysShow: true
  },
  
  // 커리어 전망
  {
    label: '취업 전망 (텍스트)',
    careernetPaths: ['prospect', 'encyclopedia.forecastList', 'encyclopedia.prosAndCons.pros'],
    work24JobPaths: ['prospect', 'salProspect.jobProspect', 'summary.jobProspect'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '커리어 전망',
    alwaysShow: true
  },
  {
    label: '기간별 전망',
    careernetPaths: ['forecastList'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '커리어 전망',
    alwaysShow: true
  },
  {
    label: '재직자 전망 데이터',
    careernetPaths: [],
    work24JobPaths: ['salProspect.jobSumProspect'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '커리어 전망',
    alwaysShow: true
  },
  
  // 한국의 직업지표
  {
    label: '한국의 직업지표',
    careernetPaths: ['encyclopedia.indicatorChart'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '한국의 직업지표',
    alwaysShow: true
  },
  
  // 핵심 능력·자격
  {
    label: '핵심 역량',
    careernetPaths: ['abilities', 'encyclopedia.abilityList', 'encyclopedia.performList.ability'],
    work24JobPaths: ['abilities', 'summary.jobAbil', 'ablKnwEnv.jobAbil'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '핵심 능력·자격',
    alwaysShow: true
  },
  {
    label: '정규교육과정',
    careernetPaths: ['jobReadyList.curriculum', 'encyclopedia.jobReadyList.curriculum'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '핵심 능력·자격',
    alwaysShow: true
  },
  {
    label: '관련 영상',
    careernetPaths: ['relVideoList', 'encyclopedia.relVideoList'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '추가 리소스',
    alwaysShow: true
  },
  {
    label: '태그 정보 (히어로)',
    careernetPaths: ['encyclopedia.tagList'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '기본 정보',
    alwaysShow: true
  },
  {
    label: '활용 기술',
    careernetPaths: ['technKnow'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '핵심 능력·자격',
    alwaysShow: true
  },
  
  // 적성 및 흥미
  {
    label: '직업 만족도',
    careernetPaths: ['satisfaction', 'encyclopedia.baseInfo.satisfication'],
    work24JobPaths: ['satisfaction', 'salProspect.jobSatis', 'summary.jobSatis'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '적성 및 흥미',
    alwaysShow: true
  },
  {
    label: '관련 직업 정보',
    careernetPaths: ['relatedJobs'],
    work24JobPaths: ['relatedJobs'],
    work24DjobPaths: ['optionJobInfo.connectJob'],
    section: 'overview',
    subsection: '관련 정보',
    alwaysShow: true
  },
  {
    label: '관련 전공 정보',
    careernetPaths: ['relatedMajors'],
    work24JobPaths: ['relatedMajors'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '관련 정보',
    alwaysShow: true
  },
  {
    label: '관련 기관 정보',
    careernetPaths: ['relatedOrganizations'],
    work24JobPaths: ['relatedOrganizations'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '관련 정보',
    alwaysShow: true
  },
  {
    label: '관련 자격증 정보',
    careernetPaths: ['relatedCertificates'],
    work24JobPaths: ['relatedCertificates'],
    work24DjobPaths: ['optionJobInfo.certLic'],
    section: 'overview',
    subsection: '관련 정보',
    alwaysShow: true
  },
  {
    label: '적성',
    careernetPaths: ['personality', 'encyclopedia.performList.personality'],
    work24JobPaths: ['personality', 'chrIntrVals.jobChr', 'chrIntrVals.jobChrCmpr'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '적성 및 흥미',
    alwaysShow: true
  },
  {
    label: '흥미',
    careernetPaths: ['interests', 'encyclopedia.performList.interests'],
    work24JobPaths: ['interests', 'chrIntrVals.jobIntrst', 'chrIntrVals.jobIntrstCmpr'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '적성 및 흥미',
    alwaysShow: true
  },
  {
    label: '가치관',
    careernetPaths: ['values', 'encyclopedia.performList.value'],
    work24JobPaths: ['values', 'chrIntrVals.jobVals', 'chrIntrVals.jobValsCmpr'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '적성 및 흥미',
    alwaysShow: true
  },
  
  // 임금 정보
  {
    label: '평균 연봉',
    careernetPaths: ['salary', 'encyclopedia.baseInfo.wage'],
    work24JobPaths: ['salary', 'salProspect.sal', 'summary.sal'],
    work24DjobPaths: [],
    section: 'overview',
    subsection: '임금 정보',
    alwaysShow: true
  },
  
  // === 상세정보 탭 ===
  
  {
    label: '업무 상세',
    careernetPaths: [],
    work24JobPaths: ['duty.execJob'],
    work24DjobPaths: [],
    section: 'details',
    subsection: '업무 상세',
    alwaysShow: true
  },
  {
    label: '학력 분포',
    careernetPaths: ['educationDistribution', 'encyclopedia.baseInfo.education'],
    work24JobPaths: ['educationDistribution', 'path.educationDistribution', 'summary.edu'],
    work24DjobPaths: [],
    section: 'details',
    subsection: '학력·전공 분포',
    alwaysShow: true
  },
  {
    label: '전공 분포',
    careernetPaths: ['majorDistribution'],
    work24JobPaths: ['majorDistribution', 'path.majorDistribution', 'summary.relMajor'],
    work24DjobPaths: [],
    section: 'details',
    subsection: '학력·전공 분포',
    alwaysShow: true
  },
  {
    label: '워라밸 지수',
    careernetPaths: ['encyclopedia.baseInfo.wlb'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '워라밸 & 사회적 평가',
    alwaysShow: true
  },
  {
    label: '사회적 기여도',
    careernetPaths: ['encyclopedia.baseInfo.social'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '워라밸 & 사회적 평가',
    alwaysShow: true
  },
  {
    label: '필요기술 및 지식',
    careernetPaths: [],
    work24JobPaths: ['path.technKnow'],
    work24DjobPaths: [],
    section: 'details',
    subsection: '교육·자격',
    alwaysShow: true
  },
  {
    label: '입직 및 취업방법',
    careernetPaths: ['jobReadyList.recruit', 'encyclopedia.jobReadyList.recruit'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '교육·자격',
    alwaysShow: true
  },
  {
    label: '진로 탐색 활동',
    careernetPaths: ['researchList', 'encyclopedia.researchList'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '교육·자격',
    alwaysShow: true
  },
  {
    label: '추천 교육과정 (직업준비)',
    careernetPaths: ['jobReadyList.curriculum', 'encyclopedia.jobReadyList.curriculum'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '교육·자격',
    alwaysShow: true
  },
  {
    label: '추가 자격증 정보',
    careernetPaths: ['jobReadyList.certificate', 'encyclopedia.jobReadyList.certificate'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '교육·자격',
    alwaysShow: true
  },
  {
    label: '필요 교육/훈련',
    careernetPaths: ['jobReadyList.training', 'encyclopedia.jobReadyList.training'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '교육·자격',
    alwaysShow: true
  },
  {
    label: '채용 정보',
    careernetPaths: ['jobReadyList.recruit'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '직업 준비하기',
    alwaysShow: true
  },
  {
    label: '추가 자격증',
    careernetPaths: ['jobReadyList.certificate'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '직업 준비하기',
    alwaysShow: true
  },
  {
    label: '필요 교육/훈련',
    careernetPaths: ['jobReadyList.training'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '직업 준비하기',
    alwaysShow: true
  },
  {
    label: '추천 교육과정',
    careernetPaths: ['jobReadyList.curriculum'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: '직업 준비하기',
    alwaysShow: true
  },
  {
    label: 'KECO 코드',
    careernetPaths: ['kecoCodes'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'details',
    subsection: 'KECO 코드',
    alwaysShow: true
  },
  {
    label: '직업 분류',
    careernetPaths: ['classifications', 'category'],
    work24JobPaths: ['category'],
    work24DjobPaths: [],
    section: 'details',
    subsection: '직업 분류',
    alwaysShow: true
  },
  {
    label: '관련 전공',
    careernetPaths: ['relatedMajors', 'encyclopedia.majorList'],
    work24JobPaths: ['relatedMajors'],
    work24DjobPaths: [],
    section: 'details',
    subsection: '관련 전공',
    alwaysShow: true
  },
  {
    label: '관련 자격증',
    careernetPaths: ['relatedCertificates', 'encyclopedia.licenseList'],
    work24JobPaths: ['relatedCertificates'],
    work24DjobPaths: ['optionJobInfo.certLic'],
    section: 'details',
    subsection: '관련 자격증',
    alwaysShow: true
  },
  {
    label: '관련 직업',
    careernetPaths: ['relatedJobs', 'encyclopedia.jobList'],
    work24JobPaths: ['relatedJobs'],
    work24DjobPaths: ['optionJobInfo.connectJob'],
    section: 'details',
    subsection: '관련 직업',
    alwaysShow: true
  },
  {
    label: '유사명칭',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.similarNm'],
    section: 'details',
    subsection: '관련 직업',
    alwaysShow: true
  },
  
  // === 업무특성 탭 ===
  
  {
    label: '필수 지식',
    careernetPaths: ['knowledge', 'encyclopedia.performList.knowledge'],
    work24JobPaths: ['knowledge', 'summary.knowldg', 'ablKnwEnv.Knwldg'],
    work24DjobPaths: [],
    section: 'characteristics',
    subsection: '필수 지식',
    alwaysShow: true
  },
  {
    label: '고용 현황',
    careernetPaths: ['status'],
    work24JobPaths: [],
    work24DjobPaths: [],
    section: 'characteristics',
    subsection: '고용 현황',
    alwaysShow: true
  },
  {
    label: '근무 환경',
    careernetPaths: ['environment', 'encyclopedia.performList.environment'],
    work24JobPaths: ['summary.jobEnv', 'ablKnwEnv.jobEnv'],
    work24DjobPaths: ['optionJobInfo.workEnv'],
    section: 'characteristics',
    subsection: '근무 환경',
    alwaysShow: true
  },
  {
    label: '업무활동 중요도',
    careernetPaths: ['activitiesImportance'],
    work24JobPaths: ['actv.jobActvImprtnc', 'actv.jobActvImprtncCmpr'],
    work24DjobPaths: [],
    section: 'characteristics',
    subsection: '업무 수행 지표',
    alwaysShow: true
  },
  {
    label: '업무활동 수준',
    careernetPaths: ['activitiesLevels'],
    work24JobPaths: ['actv.jobActvLvl', 'actv.jobActvLvlCmpr'],
    work24DjobPaths: [],
    section: 'characteristics',
    subsection: '업무 수행 지표',
    alwaysShow: true
  },
  
  // === 직업사전 전용 필드 ===
  {
    label: '교육수준',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.eduLevel'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '숙련기간',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.skillYear'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '작업강도',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.workStrong'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '작업장소',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.workPlace'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '육체활동',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.physicalAct'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '직무기능(자료)',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.workFunc1'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '직무기능(사람)',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.workFunc2'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '직무기능(사물)',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.workFunc3'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '한국고용직업분류',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.dJobECdNm', 'dJobECdNm'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '한국표준직업분류',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.dJobJCdNm', 'dJobJCdNm'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '한국표준산업분류',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.dJobICdNm', 'dJobICdNm'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  },
  {
    label: '조사년도',
    careernetPaths: [],
    work24JobPaths: [],
    work24DjobPaths: ['optionJobInfo.inqYear', 'inqYear'],
    section: 'details',
    subsection: '직업사전 정보',
    alwaysShow: true
  }
]

function getNestedValue(obj: any, path: string): any {
  if (!obj || !path) return undefined

  const keys = path.split('.')
  const tryResolve = (target: any) => {
    if (!target) return undefined
    let current = target
    for (const key of keys) {
      if (current === null || current === undefined) return undefined
      current = current[key]
    }
    return current
  }

  const candidates = [obj, obj.__raw, obj.__normalized]
  for (const candidate of candidates) {
    const value = tryResolve(candidate)
    if (value !== undefined) {
      return value
    }
  }

  return undefined
}

function formatValue(value: any): string {
  if (value === null || value === undefined) {
    return '<span class="text-wiki-muted text-sm">데이터 없음</span>'
  }
  
  if (typeof value === 'string') {
    if (value.length > 200) {
      const id = `text-${Math.random().toString(36).substr(2, 9)}`
      return `
        <div class="expandable-content">
          <p class="text-wiki-text text-sm whitespace-pre-wrap content-preview" id="${id}-preview">${escapeHtml(value.slice(0, 200))}...</p>
          <p class="text-wiki-text text-sm whitespace-pre-wrap content-full hidden" id="${id}-full">${escapeHtml(value)}</p>
          <button onclick="toggleContent('${id}')" class="text-xs text-blue-400 hover:text-blue-300 mt-1 underline">더보기</button>
        </div>
      `
    }
    return `<p class="text-wiki-text text-sm whitespace-pre-wrap">${escapeHtml(value)}</p>`
  }
  
  if (Array.isArray(value)) {
    if (value.length === 0) {
      return '<span class="text-wiki-muted text-sm">빈 배열</span>'
    }
    
    if (value.length > 5) {
      const id = `array-${Math.random().toString(36).substr(2, 9)}`
      const previewItems = value.slice(0, 5).map(item => {
        if (typeof item === 'object') {
          return `<li class="text-sm">${escapeHtml(JSON.stringify(item))}</li>`
        }
        return `<li class="text-sm">${escapeHtml(String(item))}</li>`
      }).join('')
      
      const fullItems = value.map(item => {
        if (typeof item === 'object') {
          return `<li class="text-sm">${escapeHtml(JSON.stringify(item))}</li>`
        }
        return `<li class="text-sm">${escapeHtml(String(item))}</li>`
      }).join('')
      
      return `
        <div class="expandable-content">
          <ul class="list-disc list-inside text-wiki-text content-preview" id="${id}-preview">${previewItems}<li class="text-wiki-muted text-xs">... 외 ${value.length - 5}개</li></ul>
          <ul class="list-disc list-inside text-wiki-text content-full hidden" id="${id}-full">${fullItems}</ul>
          <button onclick="toggleContent('${id}')" class="text-xs text-blue-400 hover:text-blue-300 mt-1 underline">더보기</button>
        </div>
      `
    }
    
    const items = value.map(item => {
      if (typeof item === 'object') {
        return `<li class="text-sm">${escapeHtml(JSON.stringify(item))}</li>`
      }
      return `<li class="text-sm">${escapeHtml(String(item))}</li>`
    }).join('')
    return `<ul class="list-disc list-inside text-wiki-text">${items}</ul>`
  }
  
  if (typeof value === 'object') {
    const str = JSON.stringify(value, null, 2)
    if (str.length > 300) {
      const id = `obj-${Math.random().toString(36).substr(2, 9)}`
      return `
        <div class="expandable-content">
          <pre class="text-xs text-wiki-text bg-wiki-card p-2 rounded overflow-x-auto max-h-40 content-preview" id="${id}-preview">${escapeHtml(str.slice(0, 300))}...</pre>
          <pre class="text-xs text-wiki-text bg-wiki-card p-2 rounded overflow-x-auto content-full hidden" id="${id}-full">${escapeHtml(str)}</pre>
          <button onclick="toggleContent('${id}')" class="text-xs text-blue-400 hover:text-blue-300 mt-1 underline">더보기</button>
        </div>
      `
    }
    return `<pre class="text-xs text-wiki-text bg-wiki-card p-2 rounded overflow-x-auto">${escapeHtml(str)}</pre>`
  }
  
  return `<span class="text-wiki-text text-sm">${escapeHtml(String(value))}</span>`
}

// 미할당 데이터 섹션용: 제한 없이 전체 표시
function formatValueFull(value: any): string {
  if (value === null || value === undefined) {
    return '<span class="text-wiki-muted text-sm">데이터 없음</span>'
  }
  
  if (typeof value === 'string') {
    return `<p class="text-wiki-text text-sm whitespace-pre-wrap max-h-96 overflow-y-auto">${escapeHtml(value)}</p>`
  }
  
  if (Array.isArray(value)) {
    if (value.length === 0) {
      return '<span class="text-wiki-muted text-sm">빈 배열</span>'
    }
    
    const items = value.map(item => {
      if (typeof item === 'object') {
        return `<li class="text-sm">${escapeHtml(JSON.stringify(item))}</li>`
      }
      return `<li class="text-sm">${escapeHtml(String(item))}</li>`
    }).join('')
    return `<ul class="list-disc list-inside text-wiki-text max-h-96 overflow-y-auto">${items}</ul>`
  }
  
  if (typeof value === 'object') {
    const str = JSON.stringify(value, null, 2)
    return `<pre class="text-xs text-wiki-text bg-wiki-card p-2 rounded overflow-x-auto max-h-96 overflow-y-auto">${escapeHtml(str)}</pre>`
  }
  
  return `<span class="text-wiki-text text-sm">${escapeHtml(String(value))}</span>`
}

function escapeHtml(str: string): string {
  const map: Record<string, string> = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;'
  }
  return String(str).replace(/[&<>"']/g, m => map[m])
}

export function renderJobTemplateDesignPage(jobName: string, sources: JobSourceRow[]): string {
  // 소스별로 데이터 파싱
  const careernetSource = sources.find(s => s.source_system === 'CAREERNET')
  const work24JobSource = sources.find(s => s.source_system === 'WORK24_JOB')
  const work24DjobSource = sources.find(s => s.source_system === 'WORK24_DJOB')
  
const parseJson = (payload?: string | null) => {
  if (!payload) return {}
  try {
    const parsed = JSON.parse(payload)
    return parsed && typeof parsed === 'object' ? parsed : {}
  } catch {
    return {}
  }
}

const buildSourceData = (normalizedPayload?: string | null, rawPayload?: string | null, preferRaw = false) => {
  const normalized = parseJson(normalizedPayload)
  const raw = parseJson(rawPayload)
  const base = {
    __raw: raw,
    __normalized: normalized
  }
  if (preferRaw) {
    return {
      ...base,
      ...raw,
      ...normalized
    }
  }
  return {
    ...base,
    ...normalized,
    ...raw
  }
}

let careernetData: any = {}
let work24JobData: any = {}
let work24DjobData: any = {}
  
  try {
    if (careernetSource) {
      careernetData = buildSourceData(careernetSource.normalized_payload, careernetSource.raw_payload)
    }
  } catch (e) {
  }
  
  try {
    if (work24JobSource) {
      work24JobData = buildSourceData(work24JobSource.normalized_payload, work24JobSource.raw_payload)
    }
  } catch (e) {
  }
  
  try {
    if (work24DjobSource) {
      work24DjobData = buildSourceData(work24DjobSource.normalized_payload, work24DjobSource.raw_payload, true)
    }
  } catch (e) {
  }
  
  // 필드별 데이터 추출
  const fieldData = FIELD_DEFINITIONS.map(field => {
    const careernetValues = field.careernetPaths.map(path => ({
      path,
      value: getNestedValue(careernetData, path)
    })).filter(v => v.value !== undefined)
    
    const work24JobValues = field.work24JobPaths.map(path => ({
      path,
      value: getNestedValue(work24JobData, path)
    })).filter(v => v.value !== undefined)
    
    const work24DjobValues = field.work24DjobPaths.map(path => ({
      path,
      value: getNestedValue(work24DjobData, path)
    })).filter(v => v.value !== undefined)
    
    return {
      ...field,
      careernetValues,
      work24JobValues,
      work24DjobValues,
      hasData: careernetValues.length > 0 || work24JobValues.length > 0 || work24DjobValues.length > 0
    }
  })
  
  // 할당되지 않은 필드 찾기
  const usedPaths = new Set<string>()
  FIELD_DEFINITIONS.forEach(field => {
    field.careernetPaths.forEach(p => usedPaths.add(`CAREERNET:${p}`))
    field.work24JobPaths.forEach(p => usedPaths.add(`WORK24_JOB:${p}`))
    field.work24DjobPaths.forEach(p => usedPaths.add(`WORK24_DJOB:${p}`))
  })
  
  function getAllPaths(obj: any, prefix = ''): string[] {
    const paths: string[] = []
    if (!obj || typeof obj !== 'object') return paths
    
    for (const key in obj) {
      if (key.startsWith('__')) continue
      const path = prefix ? `${prefix}.${key}` : key
      paths.push(path)
      if (typeof obj[key] === 'object' && !Array.isArray(obj[key])) {
        paths.push(...getAllPaths(obj[key], path))
      }
    }
    return paths
  }
  
  const allCareernetPaths = getAllPaths(careernetData).filter(p => !usedPaths.has(`CAREERNET:${p}`))
  const allWork24JobPaths = getAllPaths(work24JobData).filter(p => !usedPaths.has(`WORK24_JOB:${p}`))
  const allWork24DjobPaths = getAllPaths(work24DjobData).filter(p => !usedPaths.has(`WORK24_DJOB:${p}`))
  
  // 탭별로 필드 그룹화
  const overviewFields = fieldData.filter(f => f.section === 'overview')
  const detailFields = fieldData.filter(f => f.section === 'details')
  const characteristicsFields = fieldData.filter(f => f.section === 'characteristics')
  
  // 개요 탭 섹션별로 그룹화
  const overviewSections = new Map<string, typeof fieldData>()
  overviewFields.forEach(field => {
    const subsection = field.subsection || '기타'
    if (!overviewSections.has(subsection)) {
      overviewSections.set(subsection, [])
    }
    overviewSections.get(subsection)!.push(field)
  })
  
  // 상세정보 탭 섹션별로 그룹화
  const detailSections = new Map<string, typeof fieldData>()
  detailFields.forEach(field => {
    const subsection = field.subsection || '기타'
    if (!detailSections.has(subsection)) {
      detailSections.set(subsection, [])
    }
    detailSections.get(subsection)!.push(field)
  })
  
  // 업무특성 탭 섹션별로 그룹화
  const characteristicsSections = new Map<string, typeof fieldData>()
  characteristicsFields.forEach(field => {
    const subsection = field.subsection || '기타'
    if (!characteristicsSections.has(subsection)) {
      characteristicsSections.set(subsection, [])
    }
    characteristicsSections.get(subsection)!.push(field)
  })
  
  // 히어로 섹션 필드 정보
  const heroFields: HeroField[] = [
    {
      label: '카테고리',
      sources: [
        { sourceType: 'CAREERNET', path: 'category.name', value: getNestedValue(careernetData, 'category.name') },
        { sourceType: 'CAREERNET', path: 'classifications.large', value: getNestedValue(careernetData, 'classifications.large') },
        { sourceType: 'WORK24_JOB', path: 'category.name', value: getNestedValue(work24JobData, 'category.name') },
        { sourceType: 'WORK24_DJOB', path: 'category.name', value: getNestedValue(work24DjobData, 'category.name') }
      ].filter(s => s.value !== undefined)
    },
    {
      label: '직업명',
      sources: [
        { sourceType: 'CAREERNET', path: 'name', value: getNestedValue(careernetData, 'name') },
        { sourceType: 'CAREERNET', path: 'duty.job_nm', value: getNestedValue(careernetData, 'duty.job_nm') },
        { sourceType: 'WORK24_JOB', path: 'jobNm', value: getNestedValue(work24JobData, 'jobNm') },
        { sourceType: 'WORK24_DJOB', path: 'dJobNm', value: getNestedValue(work24DjobData, 'dJobNm') }
      ].filter(s => s.value !== undefined)
    },
    {
      label: '직업 소개 (히어로 설명)',
      sources: [
        { sourceType: 'CAREERNET', path: 'summary', value: getNestedValue(careernetData, 'summary')?.split('\n')[0] },
        { sourceType: 'WORK24_JOB', path: 'duty.jobSum', value: getNestedValue(work24JobData, 'duty.jobSum') },
        { sourceType: 'WORK24_DJOB', path: 'dJobsum', value: getNestedValue(work24DjobData, 'dJobsum') }
      ].filter(s => s.value !== undefined)
    },
    {
      label: '태그',
      sources: [
        { sourceType: 'CAREERNET', path: 'encyclopedia.tagList', value: getNestedValue(careernetData, 'encyclopedia.tagList') }
      ].filter(s => s.value !== undefined)
    }
  ]
  
  // 필드 렌더링 함수 (병합 규칙 설계 기능 추가)
  function renderField(field: typeof fieldData[0]): string {
    // 모든 필드를 항상 표시 (데이터 유무와 관계없이)
    const fieldId = `field-${field.label.replace(/[^a-zA-Z0-9가-힣]/g, '-')}`
    const hasCareernetData = field.careernetValues.length > 0
    const hasWork24JobData = field.work24JobValues.length > 0
    const hasWork24DjobData = field.work24DjobValues.length > 0
    
    return `
      <div class="mb-6 p-4 bg-wiki-card/30 rounded-xl border border-wiki-border/50 merge-field" data-field-id="${fieldId}">
        <!-- 필드 헤더: 라벨 + 병합 설정 -->
        <div class="flex flex-wrap items-center justify-between gap-3 mb-4 pb-3 border-b border-wiki-border/30">
          <div class="flex items-center gap-3">
            <label class="flex items-center gap-2 cursor-pointer">
              <input type="checkbox" class="field-enabled w-4 h-4 rounded border-wiki-border text-wiki-primary bg-wiki-bg focus:ring-wiki-primary" checked>
              <h4 class="text-base font-bold text-wiki-secondary">${escapeHtml(field.label)}</h4>
            </label>
          </div>
          
          <!-- 우선순위 설정 -->
          <div class="flex items-center gap-2 text-xs">
            <span class="text-wiki-muted">우선순위:</span>
            <select class="priority-select bg-wiki-bg border border-wiki-border rounded px-2 py-1 text-xs text-wiki-text focus:ring-wiki-primary focus:border-wiki-primary">
              <option value="CAREERNET_FIRST" ${hasCareernetData ? '' : 'disabled'}>커리어넷 우선</option>
              <option value="WORK24_JOB_FIRST" ${hasWork24JobData ? '' : 'disabled'}>고용24직업 우선</option>
              <option value="WORK24_DJOB_FIRST" ${hasWork24DjobData ? '' : 'disabled'}>고용24사전 우선</option>
              <option value="MERGE_ALL">모두 병합</option>
            </select>
          </div>
        </div>
        
        <!-- 소스별 데이터 -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          ${renderSourceField('CAREERNET', field.careernetValues, field.careernetPaths, fieldId)}
          ${renderSourceField('WORK24_JOB', field.work24JobValues, field.work24JobPaths, fieldId)}
          ${renderSourceField('WORK24_DJOB', field.work24DjobValues, field.work24DjobPaths, fieldId)}
        </div>
      </div>
    `
  }
  
  function renderSourceField(sourceType: string, values: Array<{path: string, value: any}>, allPaths: string[], fieldId?: string): string {
    const colors = SOURCE_COLORS[sourceType as keyof typeof SOURCE_COLORS]
    const label = SOURCE_LABELS[sourceType as keyof typeof SOURCE_LABELS]
    const sourceId = fieldId ? `${fieldId}-${sourceType}` : sourceType
    
    // 정의된 경로가 없으면 (템플릿에 이 소스 사용 안함)
    if (allPaths.length === 0) {
      return `
        <div class="p-3 rounded-lg border border-wiki-border/30 bg-wiki-bg/20 source-field" data-source="${sourceType}">
          <div class="flex items-center gap-2 mb-2">
            <input type="checkbox" class="source-enabled w-3 h-3 rounded" disabled>
            <span class="text-xs font-bold text-wiki-muted uppercase">${label}</span>
          </div>
          <div class="text-wiki-muted text-xs italic">템플릿에서 사용하지 않음</div>
        </div>
      `
    }
    
    // 데이터가 없지만 정의된 경로가 있으면 경로 표시
    if (values.length === 0) {
      return `
        <div class="p-3 rounded-lg border ${colors.border} ${colors.bg} source-field" data-source="${sourceType}">
          <div class="flex items-center gap-2 mb-2">
            <input type="checkbox" class="source-enabled w-3 h-3 rounded border-wiki-border" disabled>
            <span class="text-xs font-bold ${colors.text} uppercase">${label}</span>
            <span class="text-[10px] px-1.5 py-0.5 bg-red-500/20 text-red-400 rounded">값 없음</span>
          </div>
          <div class="space-y-1">
            ${allPaths.map(path => `
              <div class="text-xs">
                <span class="text-wiki-muted">정의된 필드:</span>
                <code class="text-[10px] ${colors.text} bg-wiki-bg/50 px-1.5 py-0.5 rounded ml-1">${escapeHtml(path)}</code>
              </div>
            `).join('')}
            <div class="text-[10px] text-wiki-muted italic mt-2 pt-2 border-t border-wiki-border/30">
              ⚠️ 이 필드에 대한 데이터가 현재 소스에 없습니다
            </div>
          </div>
        </div>
      `
    }
    
    // 데이터가 있으면 데이터와 함께 표시
    return `
      <div class="p-3 rounded-lg border ${colors.border} ${colors.bg} source-field" data-source="${sourceType}">
        <div class="flex items-center gap-2 mb-2">
          <input type="checkbox" class="source-enabled w-3 h-3 rounded border-wiki-border text-wiki-primary bg-wiki-bg" checked>
          <span class="text-xs font-bold ${colors.text} uppercase">${label}</span>
          <span class="text-[10px] px-1.5 py-0.5 bg-green-500/20 text-green-400 rounded">
            <i class="fas fa-check text-[8px] mr-0.5"></i>데이터 있음
          </span>
        </div>
        ${values.map(v => `
          <div class="mb-2 last:mb-0 pb-2 last:pb-0 border-b last:border-b-0 border-wiki-border/20">
            <div class="text-xs text-wiki-muted mb-1">
              <span class="font-semibold">정의된 필드:</span>
              <code class="text-[10px] ${colors.text} bg-wiki-bg/50 px-1.5 py-0.5 rounded ml-1">${escapeHtml(v.path)}</code>
            </div>
            <div class="text-xs mt-1.5">
              <span class="text-wiki-muted font-semibold">데이터 값:</span>
              <div class="mt-1 pl-2 border-l-2 ${colors.border}">${formatValue(v.value)}</div>
            </div>
          </div>
        `).join('')}
      </div>
    `
  }
  
  // HTML 생성
  return `
<!DOCTYPE html>
<html lang="ko" class="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${jobName} - 템플릿 설계 페이지</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --wiki-bg: #0a0e27;
      --wiki-card: #1a1f3a;
      --wiki-border: #2d3748;
      --wiki-text: #e2e8f0;
      --wiki-muted: #94a3b8;
      --wiki-secondary: #60a5fa;
      --wiki-primary: #3b82f6;
    }
    
    body {
      background-color: var(--wiki-bg);
      color: var(--wiki-text);
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    }
    
    .wiki-bg { background-color: var(--wiki-bg); }
    .wiki-card { background-color: var(--wiki-card); }
    .wiki-border { border-color: var(--wiki-border); }
    .text-wiki-text { color: var(--wiki-text); }
    .text-wiki-muted { color: var(--wiki-muted); }
    .text-wiki-secondary { color: var(--wiki-secondary); }
    .text-wiki-primary { color: var(--wiki-primary); }
    .bg-wiki-card { background-color: var(--wiki-card); }
    .bg-wiki-bg { background-color: var(--wiki-bg); }
    .bg-wiki-primary { background-color: var(--wiki-primary); }
    .border-wiki-border { border-color: var(--wiki-border); }
    
    .glass-card {
      background: rgba(26, 31, 58, 0.5);
      backdrop-filter: blur(10px);
    }
    
    .tab-button {
      transition: all 0.2s;
    }
    
    .tab-button.active {
      background-color: var(--wiki-secondary);
      color: white;
    }
    
    .tab-content {
      display: none;
    }
    
    .tab-content.active {
      display: block;
    }
  </style>
</head>
<body class="wiki-bg">
  <div class="min-h-screen">
    <div class="max-w-[1400px] mx-auto px-4 md:px-6 space-y-4 md:space-y-8 py-4 md:py-8">
      <!-- 히어로 섹션 -->
      <section class="glass-card border px-6 py-6 rounded-2xl space-y-5">
        <div class="space-y-4">
          <div class="flex flex-wrap items-start justify-between gap-4">
            <h1 class="text-3xl md:text-4xl font-bold text-white">${escapeHtml(jobName)}</h1>
            <span class="px-4 py-2 bg-purple-500/20 text-purple-400 rounded-lg text-sm font-semibold border border-purple-500/50">
              <i class="fas fa-flask mr-2"></i>템플릿 설계
            </span>
          </div>
          
          <!-- 히어로 섹션 필드 정보 -->
          <div class="p-4 bg-wiki-card/50 border border-wiki-border/50 rounded-xl">
            <h3 class="text-sm font-bold text-wiki-secondary mb-3">
              <i class="fas fa-info-circle mr-2"></i>히어로 섹션 필드 매핑
            </h3>
            <div class="space-y-3">
              ${heroFields.map(field => `
                <div class="p-3 bg-wiki-bg/30 rounded-lg">
                  <div class="text-xs font-semibold text-white mb-2">${escapeHtml(field.label)}</div>
                  ${field.sources.length > 0 ? `
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-2">
                      ${field.sources.map(s => {
                        const color = s.sourceType === 'CAREERNET' ? 'blue' : s.sourceType === 'WORK24_JOB' ? 'green' : 'purple'
                        return `
                          <div class="p-2 bg-${color}-500/10 border border-${color}-500/30 rounded">
                            <div class="text-[10px] text-${color}-400 font-bold mb-1">[${s.sourceType}]</div>
                            <code class="text-[9px] text-wiki-muted block mb-1">${escapeHtml(s.path)}</code>
                            <div class="text-[10px] text-wiki-text truncate">${formatValue(s.value)}</div>
                          </div>
                        `
                      }).join('')}
                    </div>
                  ` : '<div class="text-xs text-wiki-muted">데이터 없음</div>'}
                </div>
              `).join('')}
            </div>
          </div>
          
          <!-- 데이터 소스 상태 및 병합 규칙 도구 -->
          <div class="flex flex-wrap items-center justify-between gap-3 pt-3 border-t border-wiki-border/30">
            <div class="flex flex-wrap gap-3">
              <div class="px-3 py-1.5 bg-blue-500/20 border border-blue-500/50 rounded-lg flex items-center gap-2">
                <i class="fas ${careernetSource ? 'fa-check-circle text-green-400' : 'fa-times-circle text-red-400'} text-xs"></i>
                <span class="text-xs text-wiki-text">커리어넷</span>
              </div>
              <div class="px-3 py-1.5 bg-green-500/20 border border-green-500/50 rounded-lg flex items-center gap-2">
                <i class="fas ${work24JobSource ? 'fa-check-circle text-green-400' : 'fa-times-circle text-red-400'} text-xs"></i>
                <span class="text-xs text-wiki-text">고용24 직업정보</span>
              </div>
              <div class="px-3 py-1.5 bg-purple-500/20 border border-purple-500/50 rounded-lg flex items-center gap-2">
                <i class="fas ${work24DjobSource ? 'fa-check-circle text-green-400' : 'fa-times-circle text-red-400'} text-xs"></i>
                <span class="text-xs text-wiki-text">고용24 직업사전</span>
              </div>
            </div>
            
            <!-- 병합 규칙 도구 버튼 -->
            <div class="flex gap-2">
              <button onclick="exportMergeConfig()" class="px-3 py-1.5 bg-wiki-primary hover:bg-wiki-primary/80 text-white rounded-lg text-xs font-semibold flex items-center gap-2 transition-colors">
                <i class="fas fa-download text-[10px]"></i>규칙 내보내기
              </button>
              <button onclick="document.getElementById('importFile').click()" class="px-3 py-1.5 bg-wiki-card hover:bg-wiki-card/80 text-wiki-text rounded-lg text-xs font-semibold flex items-center gap-2 border border-wiki-border transition-colors">
                <i class="fas fa-upload text-[10px]"></i>규칙 가져오기
              </button>
              <input type="file" id="importFile" accept=".json" onchange="importMergeConfig(event)" class="hidden">
            </div>
          </div>
        </div>
      </section>
      
      <!-- 메인 컨텐츠 (사이드바 제거) -->
      <div class="space-y-4 min-w-0">
          <!-- 탭 네비게이션 -->
          <div class="flex gap-2 border-b border-wiki-border pb-2 overflow-x-auto">
            <button class="tab-button active px-5 py-2.5 rounded-lg text-sm font-semibold whitespace-nowrap" data-tab="overview">
              <i class="fas fa-circle-info mr-1.5 text-xs"></i>개요
            </button>
            <button class="tab-button px-5 py-2.5 rounded-lg text-sm font-semibold text-wiki-text hover:bg-wiki-card whitespace-nowrap" data-tab="details">
              <i class="fas fa-layer-group mr-1.5 text-xs"></i>상세정보
            </button>
            <button class="tab-button px-5 py-2.5 rounded-lg text-sm font-semibold text-wiki-text hover:bg-wiki-card whitespace-nowrap" data-tab="characteristics">
              <i class="fas fa-chart-pie mr-1.5 text-xs"></i>업무특성
            </button>
            <button class="tab-button px-5 py-2.5 rounded-lg text-sm font-semibold text-wiki-text hover:bg-wiki-card whitespace-nowrap" data-tab="unmapped">
              <i class="fas fa-exclamation-triangle mr-1.5 text-xs"></i>미할당
            </button>
          </div>
          
          <!-- 개요 탭 -->
          <div id="overview" class="tab-content active">
            ${Array.from(overviewSections.entries()).map(([subsection, fields]) => {
              const sectionId = `section-overview-${subsection.replace(/[^a-zA-Z0-9가-힣]/g, '-')}`
              return `
              <div class="mb-8 section-block" data-section-id="${sectionId}">
                <div class="flex items-center justify-between gap-4 mb-4 pb-2 border-b border-wiki-border">
                  <h2 class="text-xl font-bold text-white">
                    <i class="fas fa-bookmark mr-2 text-wiki-secondary text-sm"></i>${escapeHtml(subsection)}
                  </h2>
                  <button onclick="toggleSectionNotes('${sectionId}')" class="text-xs px-3 py-1.5 bg-wiki-card hover:bg-wiki-card/80 text-wiki-muted rounded-lg border border-wiki-border transition-colors">
                    <i class="fas fa-sticky-note mr-1"></i>규칙 메모
                  </button>
                </div>
                <!-- 섹션 규칙 메모 영역 -->
                <div id="${sectionId}-notes" class="hidden mb-4 p-3 bg-yellow-500/10 border border-yellow-500/30 rounded-lg">
                  <label class="block text-xs font-semibold text-yellow-400 mb-2">
                    <i class="fas fa-pencil-alt mr-1"></i>이 섹션의 병합 규칙 메모
                  </label>
                  <textarea 
                    class="section-notes w-full h-24 p-2 bg-wiki-bg border border-wiki-border rounded-lg text-sm text-wiki-text placeholder-wiki-muted focus:ring-wiki-primary focus:border-wiki-primary resize-y"
                    placeholder="예: 커리어넷 데이터 우선, 없으면 고용24 직업정보 사용..."
                  ></textarea>
                </div>
                ${fields.map(field => renderField(field)).join('')}
              </div>
            `}).join('')}
          </div>
          
          <!-- 상세정보 탭 -->
          <div id="details" class="tab-content">
            ${Array.from(detailSections.entries()).map(([subsection, fields]) => {
              const sectionId = `section-details-${subsection.replace(/[^a-zA-Z0-9가-힣]/g, '-')}`
              return `
              <div class="mb-8 section-block" data-section-id="${sectionId}">
                <div class="flex items-center justify-between gap-4 mb-4 pb-2 border-b border-wiki-border">
                  <h2 class="text-xl font-bold text-white">
                    <i class="fas fa-layer-group mr-2 text-wiki-secondary text-sm"></i>${escapeHtml(subsection)}
                  </h2>
                  <button onclick="toggleSectionNotes('${sectionId}')" class="text-xs px-3 py-1.5 bg-wiki-card hover:bg-wiki-card/80 text-wiki-muted rounded-lg border border-wiki-border transition-colors">
                    <i class="fas fa-sticky-note mr-1"></i>규칙 메모
                  </button>
                </div>
                <!-- 섹션 규칙 메모 영역 -->
                <div id="${sectionId}-notes" class="hidden mb-4 p-3 bg-yellow-500/10 border border-yellow-500/30 rounded-lg">
                  <label class="block text-xs font-semibold text-yellow-400 mb-2">
                    <i class="fas fa-pencil-alt mr-1"></i>이 섹션의 병합 규칙 메모
                  </label>
                  <textarea 
                    class="section-notes w-full h-24 p-2 bg-wiki-bg border border-wiki-border rounded-lg text-sm text-wiki-text placeholder-wiki-muted focus:ring-wiki-primary focus:border-wiki-primary resize-y"
                    placeholder="예: 커리어넷 데이터 우선, 없으면 고용24 직업정보 사용..."
                  ></textarea>
                </div>
                ${fields.map(field => renderField(field)).join('')}
              </div>
            `}).join('')}
          </div>
          
          <!-- 업무특성 탭 -->
          <div id="characteristics" class="tab-content">
            ${Array.from(characteristicsSections.entries()).map(([subsection, fields]) => {
              const sectionId = `section-characteristics-${subsection.replace(/[^a-zA-Z0-9가-힣]/g, '-')}`
              return `
              <div class="mb-8 section-block" data-section-id="${sectionId}">
                <div class="flex items-center justify-between gap-4 mb-4 pb-2 border-b border-wiki-border">
                  <h2 class="text-xl font-bold text-white">
                    <i class="fas fa-chart-pie mr-2 text-wiki-secondary text-sm"></i>${escapeHtml(subsection)}
                  </h2>
                  <button onclick="toggleSectionNotes('${sectionId}')" class="text-xs px-3 py-1.5 bg-wiki-card hover:bg-wiki-card/80 text-wiki-muted rounded-lg border border-wiki-border transition-colors">
                    <i class="fas fa-sticky-note mr-1"></i>규칙 메모
                  </button>
                </div>
                <!-- 섹션 규칙 메모 영역 -->
                <div id="${sectionId}-notes" class="hidden mb-4 p-3 bg-yellow-500/10 border border-yellow-500/30 rounded-lg">
                  <label class="block text-xs font-semibold text-yellow-400 mb-2">
                    <i class="fas fa-pencil-alt mr-1"></i>이 섹션의 병합 규칙 메모
                  </label>
                  <textarea 
                    class="section-notes w-full h-24 p-2 bg-wiki-bg border border-wiki-border rounded-lg text-sm text-wiki-text placeholder-wiki-muted focus:ring-wiki-primary focus:border-wiki-primary resize-y"
                    placeholder="예: 커리어넷 데이터 우선, 없으면 고용24 직업정보 사용..."
                  ></textarea>
                </div>
                ${fields.map(field => renderField(field)).join('')}
              </div>
            `}).join('')}
          </div>
          
          <!-- 미할당 필드 탭 -->
          <div id="unmapped" class="tab-content">
            <h2 class="text-xl font-bold text-red-400 mb-4 pb-2 border-b border-red-500/50">
              <i class="fas fa-exclamation-triangle mr-2 text-sm"></i>템플릿에 할당되지 않은 필드
            </h2>
            
            <div class="space-y-4">
              ${allCareernetPaths.length > 0 ? `
                <div class="p-4 bg-blue-500/10 border border-blue-500/50 rounded-lg">
                  <h3 class="text-base font-bold text-blue-400 mb-3">
                    <i class="fas fa-database mr-2 text-sm"></i>커리어넷 (${allCareernetPaths.length}개)
                  </h3>
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-2">
                    ${allCareernetPaths.map(path => `
                      <div class="p-2 bg-wiki-card rounded">
                        <code class="text-[10px] text-blue-300 block mb-1">${escapeHtml(path)}</code>
                        <div class="text-[10px] text-wiki-muted">
                          ${formatValueFull(getNestedValue(careernetData, path))}
                        </div>
                      </div>
                    `).join('')}
                  </div>
                </div>
              ` : '<div class="text-sm text-wiki-muted p-3 bg-wiki-card/30 rounded-lg">커리어넷: 모든 필드 할당됨</div>'}
              
              ${allWork24JobPaths.length > 0 ? `
                <div class="p-4 bg-green-500/10 border border-green-500/50 rounded-lg">
                  <h3 class="text-base font-bold text-green-400 mb-3">
                    <i class="fas fa-database mr-2 text-sm"></i>고용24 직업정보 (${allWork24JobPaths.length}개)
                  </h3>
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-2">
                    ${allWork24JobPaths.map(path => `
                      <div class="p-2 bg-wiki-card rounded">
                        <code class="text-[10px] text-green-300 block mb-1">${escapeHtml(path)}</code>
                        <div class="text-[10px] text-wiki-muted">
                          ${formatValueFull(getNestedValue(work24JobData, path))}
                        </div>
                      </div>
                    `).join('')}
                  </div>
                </div>
              ` : '<div class="text-sm text-wiki-muted p-3 bg-wiki-card/30 rounded-lg">고용24 직업정보: 모든 필드 할당됨</div>'}
              
              ${allWork24DjobPaths.length > 0 ? `
                <div class="p-4 bg-purple-500/10 border border-purple-500/50 rounded-lg">
                  <h3 class="text-base font-bold text-purple-400 mb-3">
                    <i class="fas fa-database mr-2 text-sm"></i>고용24 직업사전 (${allWork24DjobPaths.length}개)
                  </h3>
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-2">
                    ${allWork24DjobPaths.map(path => `
                      <div class="p-2 bg-wiki-card rounded">
                        <code class="text-[10px] text-purple-300 block mb-1">${escapeHtml(path)}</code>
                        <div class="text-[10px] text-wiki-muted">
                          ${formatValueFull(getNestedValue(work24DjobData, path))}
                        </div>
                      </div>
                    `).join('')}
                  </div>
                </div>
              ` : '<div class="text-sm text-wiki-muted p-3 bg-wiki-card/30 rounded-lg">고용24 직업사전: 모든 필드 할당됨</div>'}
            </div>
          </div>
      </div>
    </div>
  </div>
  
  <script>
    // 탭 전환
    document.querySelectorAll('.tab-button').forEach(button => {
      button.addEventListener('click', () => {
        const tabId = button.dataset.tab
        document.querySelectorAll('.tab-button').forEach(btn => {
          btn.classList.remove('active')
          btn.classList.add('text-wiki-text', 'hover:bg-wiki-card')
        })
        button.classList.add('active')
        button.classList.remove('text-wiki-text', 'hover:bg-wiki-card')
        document.querySelectorAll('.tab-content').forEach(content => {
          content.classList.remove('active')
        })
        document.getElementById(tabId).classList.add('active')
      })
    })
    
    // 더보기/접기 토글
    window.toggleContent = function(id) {
      const preview = document.getElementById(id + '-preview')
      const full = document.getElementById(id + '-full')
      const button = event.target
      
      if (preview.classList.contains('hidden')) {
        // 접기
        preview.classList.remove('hidden')
        full.classList.add('hidden')
        button.textContent = '더보기'
      } else {
        // 펼치기
        preview.classList.add('hidden')
        full.classList.remove('hidden')
        button.textContent = '접기'
      }
    }
    
    // 섹션 규칙 메모 토글
    window.toggleSectionNotes = function(sectionId) {
      const notesEl = document.getElementById(sectionId + '-notes')
      if (notesEl) {
        notesEl.classList.toggle('hidden')
      }
    }
    
    // 병합 규칙 내보내기
    window.exportMergeConfig = function() {
      const config = {
        version: '1.1',
        exportedAt: new Date().toISOString(),
        jobName: '${escapeHtml(jobName)}',
        sections: [],
        fields: []
      }
      
      // 섹션별 규칙 메모 수집
      document.querySelectorAll('.section-block').forEach(section => {
        const sectionId = section.dataset.sectionId
        const sectionTitle = section.querySelector('h2')?.textContent?.trim() || sectionId
        const notesEl = section.querySelector('.section-notes')
        const notes = notesEl?.value?.trim() || ''
        
        if (notes) {
          config.sections.push({
            id: sectionId,
            title: sectionTitle,
            notes: notes
          })
        }
      })
      
      // 모든 필드 설정 수집
      document.querySelectorAll('.merge-field').forEach(field => {
        const fieldId = field.dataset.fieldId
        const fieldLabel = field.querySelector('h4')?.textContent?.trim() || fieldId
        const enabled = field.querySelector('.field-enabled')?.checked ?? true
        const priority = field.querySelector('.priority-select')?.value || 'CAREERNET_FIRST'
        
        // 소스별 활성화 상태
        const sources = {}
        field.querySelectorAll('.source-field').forEach(sourceEl => {
          const sourceType = sourceEl.dataset.source
          const sourceEnabled = sourceEl.querySelector('.source-enabled')?.checked ?? false
          sources[sourceType] = sourceEnabled
        })
        
        config.fields.push({
          id: fieldId,
          label: fieldLabel,
          enabled,
          priority,
          sources
        })
      })
      
      // JSON 파일로 다운로드
      const blob = new Blob([JSON.stringify(config, null, 2)], { type: 'application/json' })
      const url = URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = 'merge-config-' + new Date().toISOString().split('T')[0] + '.json'
      document.body.appendChild(a)
      a.click()
      document.body.removeChild(a)
      URL.revokeObjectURL(url)
      
      alert('병합 규칙이 내보내기되었습니다. (섹션 메모: ' + config.sections.length + '개, 필드: ' + config.fields.length + '개)')
    }
    
    // 병합 규칙 가져오기
    window.importMergeConfig = function(event) {
      const file = event.target.files[0]
      if (!file) return
      
      const reader = new FileReader()
      reader.onload = function(e) {
        try {
          const config = JSON.parse(e.target.result)
          
          if (!config.fields || !Array.isArray(config.fields)) {
            throw new Error('유효하지 않은 설정 파일입니다.')
          }
          
          // 섹션 메모 적용
          let sectionsApplied = 0
          if (config.sections && Array.isArray(config.sections)) {
            config.sections.forEach(sectionConfig => {
              const section = document.querySelector('[data-section-id="' + sectionConfig.id + '"]')
              if (section) {
                const notesEl = section.querySelector('.section-notes')
                if (notesEl && sectionConfig.notes) {
                  notesEl.value = sectionConfig.notes
                  // 메모가 있으면 메모 영역 표시
                  const notesContainer = document.getElementById(sectionConfig.id + '-notes')
                  if (notesContainer) {
                    notesContainer.classList.remove('hidden')
                  }
                  sectionsApplied++
                }
              }
            })
          }
          
          // 필드 설정 적용
          config.fields.forEach(fieldConfig => {
            const field = document.querySelector('[data-field-id="' + fieldConfig.id + '"]')
            if (!field) return
            
            // 필드 활성화
            const enabledCheckbox = field.querySelector('.field-enabled')
            if (enabledCheckbox) {
              enabledCheckbox.checked = fieldConfig.enabled
            }
            
            // 우선순위
            const prioritySelect = field.querySelector('.priority-select')
            if (prioritySelect) {
              prioritySelect.value = fieldConfig.priority
            }
            
            // 소스별 설정
            if (fieldConfig.sources) {
              Object.entries(fieldConfig.sources).forEach(([sourceType, enabled]) => {
                const sourceEl = field.querySelector('[data-source="' + sourceType + '"]')
                if (sourceEl) {
                  const checkbox = sourceEl.querySelector('.source-enabled')
                  if (checkbox && !checkbox.disabled) {
                    checkbox.checked = enabled
                  }
                }
              })
            }
          })
          
          alert('병합 규칙이 적용되었습니다. (섹션 메모: ' + sectionsApplied + '개, 필드: ' + config.fields.length + '개)')
        } catch (err) {
          alert('설정 파일 가져오기 실패: ' + err.message)
        }
      }
      reader.readAsText(file)
      
      // 파일 입력 초기화
      event.target.value = ''
    }
  </script>
</body>
</html>
  `
}
