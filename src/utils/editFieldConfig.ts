/**
 * 편집 가능 필드 메타데이터 설정
 * 
 * 직업/전공 상세페이지 편집 시스템
 * - 필드별 라벨, 입력 타입, 검증 규칙 정의
 * - 섹션별 그룹화
 */

import type { EditFieldConfig, FieldSection, ValidationResult } from '../types/editFields'

// 기본 검증 규칙
const DEFAULT_MIN_LENGTH = 2
const DEFAULT_MAX_LENGTH = 7000

// ============================================
// 직업 상세페이지 필드 설정
// ============================================

export const JOB_FIELDS: EditFieldConfig[] = [
  // 히어로 섹션 (name 제외 - 읽기 전용)
  {
    key: 'name',
    label: '직업명',
    inputType: 'text',
    section: 'hero',
    minLength: 2,
    maxLength: 100,
    required: true,
    accessType: 'readonly'  // 생성 시에만 입력, 편집 불가
  },
  {
    key: 'summary',
    label: '직업 설명',
    inputType: 'textarea',
    section: 'hero',
    placeholder: '이 직업에 대한 간단한 설명을 입력하세요',
    minLength: DEFAULT_MIN_LENGTH,
    maxLength: DEFAULT_MAX_LENGTH,
    required: true,
    accessType: 'editable'
  },
  {
    key: 'heroTags',
    label: '태그',
    inputType: 'tags',
    section: 'hero',
    placeholder: '태그1, 태그2, 태그3 (쉼표로 구분)',
    minLength: 0,
    maxLength: 500,
    accessType: 'editable'
  },
  {
    key: 'heroCategory',
    label: '직업 분류',
    inputType: 'text',
    section: 'hero',
    placeholder: '예: IT/소프트웨어',
    minLength: 0,
    maxLength: 200,
    accessType: 'editable'
  },

  // 개요 탭 - 주요 업무
  {
    key: 'overviewWork.main',
    label: '수행 직무',
    inputType: 'textarea',
    section: 'overview',
    sectionGroup: '주요 업무',
    placeholder: '이 직업에서 수행하는 주요 업무를 설명하세요',
    minLength: DEFAULT_MIN_LENGTH,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'overviewWork.workStrong',
    label: '작업강도',
    inputType: 'text',
    section: 'overview',
    sectionGroup: '주요 업무',
    placeholder: '예: 보통, 높음, 낮음',
    minLength: 0,
    maxLength: 500,
    accessType: 'editable'
  },
  {
    key: 'overviewWork.workPlace',
    label: '작업장소',
    inputType: 'text',
    section: 'overview',
    sectionGroup: '주요 업무',
    placeholder: '예: 사무실, 현장, 재택',
    minLength: 0,
    maxLength: 500,
    accessType: 'editable'
  },
  {
    key: 'overviewWork.physicalAct',
    label: '육체활동',
    inputType: 'text',
    section: 'overview',
    sectionGroup: '주요 업무',
    placeholder: '예: 앉아서 근무, 서서 근무',
    minLength: 0,
    maxLength: 500,
    accessType: 'editable'
  },

  // 개요 탭 - 커리어 전망
  {
    key: 'overviewProspect.main',
    label: '전망 설명',
    inputType: 'textarea',
    section: 'overview',
    sectionGroup: '커리어 전망',
    placeholder: '이 직업의 미래 전망을 설명하세요',
    minLength: DEFAULT_MIN_LENGTH,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },

  // 개요 탭 - 핵심 능력·자격
  {
    key: 'overviewAbilities.technKnow',
    label: '기술 지식',
    inputType: 'textarea',
    section: 'overview',
    sectionGroup: '핵심 능력·자격',
    placeholder: '필요한 기술 지식을 설명하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'overviewAbilities.eduLevel',
    label: '학력 수준',
    inputType: 'text',
    section: 'overview',
    sectionGroup: '핵심 능력·자격',
    placeholder: '예: 고졸, 대졸, 석사 이상',
    minLength: 0,
    maxLength: 200,
    accessType: 'editable'
  },
  {
    key: 'overviewAbilities.skillYear',
    label: '숙련 기간',
    inputType: 'text',
    section: 'overview',
    sectionGroup: '핵심 능력·자격',
    placeholder: '예: 1~2년, 3~5년',
    minLength: 0,
    maxLength: 100,
    accessType: 'editable'
  },

  // 개요 탭 - 적성 및 흥미
  {
    key: 'overviewAptitude.description',
    label: '적성 설명',
    inputType: 'textarea',
    section: 'overview',
    sectionGroup: '적성 및 흥미',
    placeholder: '이 직업에 적합한 적성과 흥미를 설명하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },

  // 개요 탭 - 임금
  {
    key: 'overviewSalary.sal',
    label: '연봉 정보',
    inputType: 'text',
    section: 'overview',
    sectionGroup: '임금',
    placeholder: '예: 3,000~5,000만원',
    minLength: 0,
    maxLength: 200,
    accessType: 'editable'
  },
  {
    key: 'overviewSalary.wage',
    label: '시급/일급',
    inputType: 'text',
    section: 'overview',
    sectionGroup: '임금',
    placeholder: '예: 시급 15,000원',
    minLength: 0,
    maxLength: 200,
    accessType: 'editable'
  },

  // 상세정보 탭 - 워라밸 & 사회적 평가
  {
    key: 'detailWlb.wlb',
    label: '워라밸',
    inputType: 'textarea',
    section: 'details',
    sectionGroup: '워라밸 & 사회적 평가',
    placeholder: '일과 생활의 균형에 대해 설명하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'detailWlb.social',
    label: '사회적 평가',
    inputType: 'textarea',
    section: 'details',
    sectionGroup: '워라밸 & 사회적 평가',
    placeholder: '사회적 인식과 평가에 대해 설명하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },

  // 상세정보 탭 - 직업 준비하기
  {
    key: 'detailReady.recruit',
    label: '채용 정보',
    inputType: 'textarea',
    section: 'details',
    sectionGroup: '직업 준비하기',
    placeholder: '채용 관련 정보를 입력하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'detailReady.certificate',
    label: '관련 자격증',
    inputType: 'textarea',
    section: 'details',
    sectionGroup: '직업 준비하기',
    placeholder: '관련 자격증을 나열하세요 (쉼표로 구분)',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'detailReady.training',
    label: '교육/훈련',
    inputType: 'textarea',
    section: 'details',
    sectionGroup: '직업 준비하기',
    placeholder: '필요한 교육이나 훈련 과정을 설명하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'detailReady.curriculum',
    label: '관련 학과',
    inputType: 'textarea',
    section: 'details',
    sectionGroup: '직업 준비하기',
    placeholder: '관련 학과나 전공을 나열하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  }
]

// ============================================
// 전공 상세페이지 필드 설정
// ============================================

export const MAJOR_FIELDS: EditFieldConfig[] = [
  // 히어로 섹션 (name 제외 - 읽기 전용)
  {
    key: 'name',
    label: '전공명',
    inputType: 'text',
    section: 'hero',
    minLength: 2,
    maxLength: 100,
    required: true,
    accessType: 'readonly'  // 생성 시에만 입력, 편집 불가
  },
  {
    key: 'summary',
    label: '전공 설명',
    inputType: 'textarea',
    section: 'hero',
    placeholder: '이 전공에 대한 간단한 설명을 입력하세요',
    minLength: DEFAULT_MIN_LENGTH,
    maxLength: DEFAULT_MAX_LENGTH,
    required: true,
    accessType: 'editable'
  },
  {
    key: 'heroTags',
    label: '관련 학과 태그',
    inputType: 'tags',
    section: 'hero',
    placeholder: '학과1, 학과2, 학과3 (쉼표로 구분)',
    minLength: 0,
    maxLength: 500,
    accessType: 'editable'
  },
  {
    key: 'categoryName',
    label: '계열',
    inputType: 'text',
    section: 'hero',
    placeholder: '예: 공학계열, 자연과학계열',
    minLength: 0,
    maxLength: 200,
    accessType: 'editable'
  },

  // 개요 탭 - 전공 개요
  {
    key: 'overview.summary',
    label: '전공 개요',
    inputType: 'textarea',
    section: 'overview',
    sectionGroup: '전공 개요',
    placeholder: '전공의 핵심 개요를 작성하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },

  // 개요 탭 - 특성 / 어울리는 사람
  {
    key: 'aptitude',
    label: '적성',
    inputType: 'textarea',
    section: 'overview',
    sectionGroup: '전공 특성',
    placeholder: '이 전공에 적합한 적성을 설명하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'property',
    label: '전공 특성',
    inputType: 'textarea',
    section: 'overview',
    sectionGroup: '전공 특성',
    placeholder: '이 전공의 특징을 설명하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },

  // 개요 탭 - 졸업 후 진출 분야 (제목+설명 리스트)
  {
    key: 'enterField',
    label: '졸업 후 진출 분야',
    inputType: 'pairList',
    section: 'overview',
    sectionGroup: '졸업 후 진출 분야',
    placeholder: '제목/설명으로 진출 분야를 입력하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },

  // 개요 탭 - 여담 (한 줄씩)
  {
    key: 'jobProspect',
    label: '여담 (한 줄씩)',
    inputType: 'list',
    section: 'overview',
    sectionGroup: '여담',
    placeholder: '한 줄씩 여담을 입력하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },

  // 상세정보 탭 - 교육과정
  {
    key: 'whatStudy',
    label: '배우는 내용',
    inputType: 'textarea',
    section: 'details',
    sectionGroup: '교육과정',
    placeholder: '이 전공에서 배우는 내용을 설명하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'basicSubjects',
    label: '기초과목',
    inputType: 'tags',
    section: 'details',
    sectionGroup: '교육과정',
    placeholder: '기초 과목을 하나씩 입력하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'advancedSubjects',
    label: '심화과목',
    inputType: 'tags',
    section: 'details',
    sectionGroup: '교육과정',
    placeholder: '심화 과목을 하나씩 입력하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'mainSubject',
    label: '대학 주요 교과목 상세',
    inputType: 'pairList',
    section: 'details',
    sectionGroup: '교육과정',
    placeholder: '과목명과 설명을 입력하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },
  {
    key: 'relateSubject',
    label: '고교 추천 교과목',
    inputType: 'tags',
    section: 'details',
    sectionGroup: '교육과정',
    placeholder: '추천 고교 과목을 하나씩 입력하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },

  // 상세정보 탭 - 진로 탐색 활동 (제목+설명 리스트)
  {
    key: 'careerAct',
    label: '진로 탐색 활동',
    inputType: 'pairList',
    section: 'details',
    sectionGroup: '진로 탐색 활동',
    placeholder: '활동명과 설명을 입력하세요',
    minLength: 0,
    maxLength: DEFAULT_MAX_LENGTH,
    accessType: 'editable'
  },

  // 사이드바 - 연관 정보
  {
    key: 'sidebarJobs',
    label: '관련 직업',
    inputType: 'autocomplete',
    section: 'details',
    sectionGroup: '사이드바',
    placeholder: '관련 직업 검색',
    minLength: 0,
    maxLength: 1000,
    accessType: 'editable'
  },
  {
    key: 'sidebarMajors',
    label: '관련 전공',
    inputType: 'autocomplete',
    section: 'details',
    sectionGroup: '사이드바',
    placeholder: '관련 전공 검색',
    minLength: 0,
    maxLength: 1000,
    accessType: 'editable'
  },
  {
    key: 'sidebarHowtos',
    label: '관련 HowTo',
    inputType: 'autocomplete',
    section: 'details',
    sectionGroup: '사이드바',
    placeholder: '관련 HowTo 검색',
    minLength: 0,
    maxLength: 1000,
    accessType: 'editable'
  }
]

// ============================================
// 헬퍼 함수
// ============================================

/**
 * 엔티티 타입에 따른 필드 설정 반환
 */
export function getFieldConfigs(entityType: 'job' | 'major'): EditFieldConfig[] {
  return entityType === 'job' ? JOB_FIELDS : MAJOR_FIELDS
}

/**
 * 특정 필드 설정 반환
 */
export function getFieldConfig(entityType: 'job' | 'major', fieldKey: string): EditFieldConfig | undefined {
  const fields = getFieldConfigs(entityType)
  return fields.find(f => f.key === fieldKey)
}

/**
 * 편집 가능한 필드만 반환
 */
export function getEditableFields(entityType: 'job' | 'major'): EditFieldConfig[] {
  return getFieldConfigs(entityType).filter(f => f.accessType === 'editable')
}

/**
 * 섹션별 필드 그룹화
 */
export function getFieldsBySection(entityType: 'job' | 'major', section: FieldSection): EditFieldConfig[] {
  return getFieldConfigs(entityType).filter(f => f.section === section)
}

/**
 * 섹션 그룹별 필드 그룹화
 */
export function getFieldsBySectionGroup(entityType: 'job' | 'major'): Map<string, EditFieldConfig[]> {
  const fields = getEditableFields(entityType)
  const groups = new Map<string, EditFieldConfig[]>()
  
  for (const field of fields) {
    const groupKey = field.sectionGroup || field.section
    if (!groups.has(groupKey)) {
      groups.set(groupKey, [])
    }
    groups.get(groupKey)!.push(field)
  }
  
  return groups
}

/**
 * 필드 값 검증
 */
export function validateFieldValue(
  entityType: 'job' | 'major',
  fieldKey: string,
  value: any
): ValidationResult {
  const config = getFieldConfig(entityType, fieldKey)
  
  if (!config) {
    return { valid: false, error: `알 수 없는 필드: ${fieldKey}` }
  }
  
  // 필수 필드 검사
  if (config.required && (!value || (typeof value === 'string' && value.trim().length === 0))) {
    return { valid: false, error: `${config.label}은(는) 필수 항목입니다` }
  }
  
  // 값이 없으면 검증 통과 (선택 필드)
  if (!value) {
    return { valid: true }
  }
  
  // 문자열 길이 검사
  if (typeof value === 'string') {
    if (value.length < config.minLength) {
      return { 
        valid: false, 
        error: `${config.label}은(는) 최소 ${config.minLength}자 이상이어야 합니다` 
      }
    }
    if (value.length > config.maxLength) {
      return { 
        valid: false, 
        error: `${config.label}은(는) 최대 ${config.maxLength}자까지 입력 가능합니다` 
      }
    }
  }
  
  // 태그 배열 검사
  if (config.inputType === 'tags' && Array.isArray(value)) {
    const totalLength = value.join(',').length
    if (totalLength > config.maxLength) {
      return { 
        valid: false, 
        error: `${config.label}의 전체 길이가 너무 깁니다` 
      }
    }
  }
  
  return { valid: true }
}

/**
 * 다중 필드 검증
 */
export function validateFields(
  entityType: 'job' | 'major',
  fields: Record<string, any>
): ValidationResult {
  const errors: Record<string, string> = {}
  
  for (const [key, value] of Object.entries(fields)) {
    const result = validateFieldValue(entityType, key, value)
    if (!result.valid && result.error) {
      errors[key] = result.error
    }
  }
  
  if (Object.keys(errors).length > 0) {
    return { 
      valid: false, 
      error: '입력 값에 오류가 있습니다',
      fieldErrors: errors 
    }
  }
  
  return { valid: true }
}

/**
 * 중첩 필드 키를 평탄화된 객체로 변환
 * 예: { 'overviewWork.main': 'value' } → { overviewWork: { main: 'value' } }
 */
export function unflattenFields(flatFields: Record<string, any>): Record<string, any> {
  const result: Record<string, any> = {}
  
  for (const [key, value] of Object.entries(flatFields)) {
    const parts = key.split('.')
    let current = result
    
    for (let i = 0; i < parts.length - 1; i++) {
      const part = parts[i]
      if (!current[part]) {
        current[part] = {}
      }
      current = current[part]
    }
    
    current[parts[parts.length - 1]] = value
  }
  
  return result
}

/**
 * 중첩 객체를 평탄화된 필드로 변환
 * 예: { overviewWork: { main: 'value' } } → { 'overviewWork.main': 'value' }
 */
export function flattenFields(
  obj: Record<string, any>,
  prefix: string = ''
): Record<string, any> {
  const result: Record<string, any> = {}
  
  for (const [key, value] of Object.entries(obj)) {
    const newKey = prefix ? `${prefix}.${key}` : key
    
    if (value && typeof value === 'object' && !Array.isArray(value)) {
      Object.assign(result, flattenFields(value, newKey))
    } else {
      result[newKey] = value
    }
  }
  
  return result
}

/**
 * 허용된 필드 이름 목록 (editValidation.ts 호환용)
 */
export function getAllowedFieldKeys(entityType: 'job' | 'major'): Set<string> {
  const fields = getFieldConfigs(entityType)
  return new Set(fields.map(f => f.key))
}


