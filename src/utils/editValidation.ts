/**
 * 편집 시스템 입력 검증 유틸리티
 * 
 * XSS 방지, 입력 길이 제한, 필드 이름 검증 등
 */

// 최대 content 길이 (10MB)
const MAX_CONTENT_LENGTH = 10 * 1024 * 1024

// 허용된 필드 이름 (직업/전공)
const ALLOWED_JOB_FIELDS = new Set([
  'name', 'summary', 'duties', 'salary', 'way', 'prospect', 'satisfaction', 'status',
  'abilities', 'knowledge', 'environment', 'personality', 'interests', 'values',
  'activitiesImportance', 'activitiesLevels', 'technKnow', 'aptitude',
  'educationDistribution', 'majorDistribution', 'tags', 'workSummary',
  'requirements', 'workEnvironment', 'careerPath', 'relatedJobs', 'education', 'certifications', 'skills',
  'trivia'
])

const ALLOWED_MAJOR_FIELDS = new Set([
  'name',
  'summary',
  'heroSummary',  // 히어로 섹션 전공 설명 (개요와 분리)
  'overview.summary',
  'heroTags',
  'categoryName',
  'property',
  'aptitude',
  'whatStudy',
  'mainSubject',
  'relateSubject',
  'enterField',
  'trivia',  // 여담 (개요 탭)
  'careerAct',
  'sidebarJobs',
  'sidebarMajors',
  'sidebarHowtos'
])

/**
 * URL 검증 (간단한 형식 체크)
 */
export function validateUrl(url: string): boolean {
  if (!url || url.length > 2048) {
    return false
  }
  
  try {
    const parsed = new URL(url)
    // http/https만 허용
    return parsed.protocol === 'http:' || parsed.protocol === 'https:'
  } catch {
    return false
  }
}

/**
 * Content 길이 검증
 */
export function validateContentLength(content: string): boolean {
  if (!content || content.length === 0) {
    return false
  }
  
  if (content.length > MAX_CONTENT_LENGTH) {
    return false
  }
  
  return true
}

/**
 * 필드 이름 검증
 */
export function validateFieldName(
  field: string,
  entityType: 'job' | 'major'
): boolean {
  if (!field || typeof field !== 'string') {
    return false
  }
  
  const allowedFields = entityType === 'job' 
    ? ALLOWED_JOB_FIELDS 
    : ALLOWED_MAJOR_FIELDS
  
  return allowedFields.has(field)
}

/**
 * HTML 이스케이프 (XSS 방지)
 * 
 * 편집 내용은 HTML로 저장되지 않고 텍스트로 저장되므로,
 * 실제 렌더링 시에만 이스케이프 처리됨
 * 하지만 안전을 위해 기본적인 검증 수행
 */
export function sanitizeContent(content: string): string {
  if (!content) {
    return ''
  }
  
  // 기본적인 위험한 패턴 제거 (추가 보안)
  return content
    .replace(/<script[^>]*>.*?<\/script>/gi, '')
    .replace(/javascript:/gi, '')
    .replace(/on\w+\s*=/gi, '')
}

/**
 * 통합 검증 함수
 */
export function validateEditInput(
  field: string,
  content: string,
  source: string,
  entityType: 'job' | 'major'
): { valid: boolean; error?: string } {
  // 필드 이름 검증
  if (!validateFieldName(field, entityType)) {
    return { 
      valid: false, 
      error: `Invalid field name. Allowed fields: ${Array.from(entityType === 'job' ? ALLOWED_JOB_FIELDS : ALLOWED_MAJOR_FIELDS).join(', ')}` 
    }
  }
  
  // Content 길이 검증
  if (!validateContentLength(content)) {
    return { 
      valid: false, 
      error: `Content too long. Maximum length: ${MAX_CONTENT_LENGTH} bytes` 
    }
  }
  
  // Source URL 검증 (source가 제공된 경우에만 검증)
  if (source && !validateUrl(source)) {
    return { 
      valid: false, 
      error: 'Invalid source URL. Must be a valid http/https URL' 
    }
  }
  
  return { valid: true }
}

