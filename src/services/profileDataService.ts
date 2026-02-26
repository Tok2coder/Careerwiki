import { mergeJobProfiles, mergeMajorProfiles } from './profileMerge'
import {
  getJobDetail as fetchCareerNetJobDetail,
  getMajorDetail as fetchCareerNetMajorDetail,
  normalizeCareerNetJobDetail,
  normalizeCareerNetJobSummary,
  normalizeCareerNetMajorDetail,
  normalizeCareerNetMajorSummary,
  searchJobs as searchCareerNetJobs,
  searchMajors as searchCareerNetMajors
} from '../api/careernetAPI'

/**
 * 깊은 병합 유틸리티 함수
 * 중첩된 객체를 깊은 병합하여 user_contributed_json의 부분 업데이트가 
 * 기존 데이터를 덮어쓰지 않도록 함
 * 예: { detailReady: { curriculum: [...] } }가 기존의 
 *     { detailReady: { recruit: [...], training: [...] } }를 덮어쓰지 않음
 */
const DANGEROUS_KEYS = new Set(['__proto__', 'constructor', 'prototype'])

function deepMergeProfile(target: any, source: any): any {
  if (!source) return target
  if (!target) return source
  const result = { ...target }
  for (const key of Object.keys(source)) {
    if (DANGEROUS_KEYS.has(key)) continue
    if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
      // 중첩 객체는 깊은 병합
      result[key] = deepMergeProfile(result[key] || {}, source[key])
    } else if (source[key] !== undefined) {
      // 배열이나 원시값은 덮어쓰기
      result[key] = source[key]
    }
  }
  return result
}

/**
 * D1 쿼리 재시도 유틸리티
 * ECONNRESET 등의 일시적 연결 오류 시 자동 재시도
 */
async function withD1Retry<T>(
  fn: () => Promise<T>,
  maxRetries: number = 3,
  delayMs: number = 500
): Promise<T> {
  let lastError: Error | null = null
  
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await fn()
    } catch (error) {
      lastError = error as Error
      const errorMessage = (error as Error)?.message || ''
      const cause = (error as any)?.cause?.code || ''
      
      // ECONNRESET, EPIPE 등의 연결 오류만 재시도
      const isRetryableError = 
        errorMessage.includes('fetch failed') ||
        cause === 'ECONNRESET' ||
        cause === 'EPIPE' ||
        cause === 'ETIMEDOUT'
      
      if (!isRetryableError || attempt === maxRetries) {
        throw error
      }
      
      await new Promise(resolve => setTimeout(resolve, delayMs * attempt))
    }
  }
  
  throw lastError
}
import {
  fetchGoyong24JobDetail,
  fetchGoyong24JobList,
  fetchGoyong24MajorDetail,
  fetchGoyong24MajorList,
  normalizeGoyong24JobDetail,
  normalizeGoyong24JobListItem,
  normalizeGoyong24MajorDetail,
  normalizeGoyong24MajorListItem,
  type Goyong24JobListItem,
  type Goyong24MajorDetailParams,
  type Goyong24MajorListItem
} from '../api/goyong24API'
import type {
  DataSource,
  UnifiedJobDetail,
  UnifiedJobSummary,
  UnifiedMajorDetail,
  UnifiedMajorSummary
} from '../types/unifiedProfiles'

export type CareerWikiEnv = Record<string, unknown>

export interface SourceStatus {
  attempted: boolean
  count?: number
  error?: string
  skippedReason?: string
}

export type SourceStatusRecord = Record<DataSource, SourceStatus> & {
  rawPartials?: Partial<Record<DataSource, any>>
}

const createInitialSourceStatus = (): SourceStatusRecord => ({
  CAREERNET: { attempted: false, count: 0 },
  GOYONG24: { attempted: false, count: 0 },
  WORK24_JOB: { attempted: false, count: 0 },
  WORK24_DJOB: { attempted: false, count: 0 },
  WORK24_MAJOR: { attempted: false, count: 0 },
  AI: { attempted: false, count: 0 },
  USER_CONTRIBUTED: { attempted: false, count: 0 },
  ADMIN_OVERRIDE: { attempted: false, count: 0 }
})

export interface UnifiedMajorSummaryEntry {
  profile: UnifiedMajorSummary
  sourceMeta?: {
    careernet?: {
      majorSeq: string
    }
    goyong24?: {
      majorGb: '1' | '2'
      departmentId: string
      majorId: string
    }
  }
  display?: {
    summary?: string
    categoryName?: string
    employmentRate?: string
    salaryAfterGraduation?: string
    firstJobSalary?: string  // 첫직장임금(월)
    firstJobSatisfaction?: string  // 첫 직장 만족도
    jobProspect?: string  // 직업 전망 (고용24만)
    departmentName?: string  // 계열명 (고용24만)
    universityCount?: string  // 개설 대학 수
    relatedJobCount?: string  // 관련 직업 수
  }
}

export interface UnifiedJobSummaryEntry {
  profile: UnifiedJobSummary
  sourceMeta?: {
    careernet?: {
      jobdicSeq: string
    }
    goyong24?: {
      jobCd: string
      jobClcd?: string
    }
  }
  display?: {
    summary?: string
    salary?: string
    satisfaction?: string
    wlb?: string
    outlook?: string
    categoryName?: string
    categoryLarge?: string   // 대분류
    categoryMedium?: string  // 중분류
    categorySmall?: string   // 소분류
    departmentName?: string  // 계열명 (고용24만)
    workStrong?: string      // 작업 강도 (직업사전)
    skillYear?: string       // 숙련기간 (직업사전)
  }
}

export interface UnifiedSearchMeta {
  total: number
  sources: SourceStatusRecord
}

export interface UnifiedSearchResult<T> {
  items: T[]
  meta: UnifiedSearchMeta
}

export interface MajorDetailRequest {
  id?: string
  careernetId?: string
  goyong24Params?: {
    majorGb: '1' | '2'
    departmentId: string
    majorId: string
  }
  includeSources?: DataSource[]
}

export interface JobDetailRequest {
  id?: string
  careernetId?: string
  goyong24JobId?: string
  includeSources?: DataSource[]
}

const LAWYER_IDENTIFIER_TOKENS = [
  'lawyer',
  '변호사',
  'job:c_375',
  'job-c-375',
  'job:g_k000007482',
  'job-g-k000007482',
  'jobgk000007482',
  'c_375',
  'k000007482'
]

const LAWYER_EXACT_IDS = ['375', 'k000007482']
const LAWYER_DISPLAY_NAME = '변호사'

const matchesLawyerIdentifier = (value?: string | null): boolean => {
  if (!value) {
    return false
  }
  const normalized = value.trim().toLowerCase()
  if (!normalized) {
    return false
  }
  if (LAWYER_EXACT_IDS.includes(normalized)) {
    return true
  }
  return LAWYER_IDENTIFIER_TOKENS.some((token) => normalized.includes(token))
}

const resolveJobSourceOverride = (request: JobDetailRequest) => {
  if (
    matchesLawyerIdentifier(request.id) ||
    matchesLawyerIdentifier(request.careernetId) ||
    matchesLawyerIdentifier(request.goyong24JobId)
  ) {
    return {
      careernetId: '375',
      goyong24JobId: 'K000007482'
    }
  }
  return null
}

const applyJobDetailOverrides = (
  profile: UnifiedJobDetail | null,
  partials: Partial<Record<DataSource, UnifiedJobDetail | null>>
): UnifiedJobDetail | null => {
  if (!profile) {
    return profile
  }

  const isLawyerProfile =
    matchesLawyerIdentifier(profile.id) ||
    matchesLawyerIdentifier(profile.name) ||
    matchesLawyerIdentifier(profile.sourceIds?.careernet) ||
    matchesLawyerIdentifier(profile.sourceIds?.goyong24)

  if (!isLawyerProfile) {
    return profile
  }

  const goyong = partials.GOYONG24 ?? null
  const careernet = partials.CAREERNET ?? null

  const resolveText = (...values: Array<string | undefined | null>): string | undefined => {
    for (const value of values) {
      if (typeof value !== 'string') continue
      const trimmed = value.trim()
      if (trimmed) {
        return trimmed
      }
    }
    return undefined
  }

  const mergedSources = (() => {
    const set = new Set<string>()
    profile.sources?.forEach((source) => source && set.add(source))
    goyong?.sources?.forEach((source) => source && set.add(source))
    careernet?.sources?.forEach((source) => source && set.add(source))
    const collected = Array.from(set) as DataSource[]
    return collected.length ? collected : profile.sources ?? []
  })()

  const candidateName = profile.name && !matchesLawyerIdentifier(profile.name) ? profile.name.trim() : undefined
  const goyongName = goyong?.name && !matchesLawyerIdentifier(goyong.name) ? goyong.name.trim() : undefined
  const careernetName =
    careernet?.name && !matchesLawyerIdentifier(careernet.name) ? careernet.name.trim() : undefined

  const next: UnifiedJobDetail = {
    ...profile,
    name: candidateName ?? goyongName ?? careernetName ?? LAWYER_DISPLAY_NAME,
    sources: mergedSources
  }

  const summary = resolveText(profile.summary, goyong?.summary, careernet?.summary)
  if (summary) next.summary = summary

  const duties = resolveText(profile.duties, goyong?.duties, careernet?.duties)
  if (duties) next.duties = duties

  const prospect = resolveText(profile.prospect, goyong?.prospect, careernet?.prospect)
  if (prospect) next.prospect = prospect

  const salary = resolveText(profile.salary, goyong?.salary, careernet?.salary)
  if (salary) next.salary = salary

  const status = resolveText(profile.status, goyong?.status, careernet?.status)
  if (status) next.status = status

  const abilities = resolveText(profile.abilities, goyong?.abilities, careernet?.abilities)
  if (abilities) next.abilities = abilities

  const knowledge = resolveText(profile.knowledge, goyong?.knowledge, careernet?.knowledge)
  if (knowledge) next.knowledge = knowledge

  const environment = resolveText(profile.environment, goyong?.environment, careernet?.environment)
  if (environment) next.environment = environment

  const personality = resolveText(profile.personality, goyong?.personality, careernet?.personality)
  if (personality) next.personality = personality

  const interests = resolveText(profile.interests, goyong?.interests, careernet?.interests)
  if (interests) next.interests = interests

  const values = resolveText(profile.values, goyong?.values, careernet?.values)
  if (values) next.values = values

  const activitiesImportance = resolveText(
    profile.activitiesImportance,
    goyong?.activitiesImportance,
    careernet?.activitiesImportance
  )
  if (activitiesImportance) next.activitiesImportance = activitiesImportance

  const activitiesLevels = resolveText(
    profile.activitiesLevels,
    goyong?.activitiesLevels,
    careernet?.activitiesLevels
  )
  if (activitiesLevels) next.activitiesLevels = activitiesLevels

  const technKnow = resolveText(profile.technKnow, goyong?.technKnow, careernet?.technKnow)
  if (technKnow) next.technKnow = technKnow

  const categoryName = resolveText(profile.category?.name, goyong?.category?.name, careernet?.category?.name)
  const categoryCode = resolveText(profile.category?.code, goyong?.category?.code, careernet?.category?.code)
  if (categoryName || categoryCode) {
    next.category = {
      code: categoryCode ?? profile.category?.code,
      name: categoryName ?? profile.category?.name
    }
  }

  next.classifications = {
    large: resolveText(profile.classifications?.large, goyong?.classifications?.large, careernet?.classifications?.large),
    medium: resolveText(
      profile.classifications?.medium,
      goyong?.classifications?.medium,
      careernet?.classifications?.medium
    ),
    small: resolveText(profile.classifications?.small, goyong?.classifications?.small, careernet?.classifications?.small)
  }

  return next
}

export interface UnifiedDetailResult<T> {
  profile: T | null
  partials: Partial<Record<DataSource, T | null>>
  sources: SourceStatusRecord
  // 원본 API 응답 데이터 (모든 필드 보존)
  rawPartials?: Partial<Record<DataSource, any>>
}

const DEFAULT_SOURCES: DataSource[] = ['CAREERNET', 'GOYONG24']

const resolveIncludedSources = (includeSources?: DataSource[]): DataSource[] => {
  if (!includeSources || includeSources.length === 0) {
    return DEFAULT_SOURCES
  }
  return Array.from(new Set(includeSources))
}

const ensureSourceStatus = (sources: SourceStatusRecord, source: DataSource): SourceStatus => {
  if (!sources[source]) {
    sources[source] = { attempted: false, count: 0 }
  }
  return sources[source]
}

const derivePartialsFromMergedProfile = <T extends { sources?: DataSource[] }>(
  profile: T
): Partial<Record<DataSource, T | null>> => {
  const partials: Partial<Record<DataSource, T | null>> = {}
  const sources = Array.isArray(profile.sources) ? profile.sources : []

  if (sources.includes('CAREERNET')) {
    partials.CAREERNET = profile
  }

  // WORK24_MAJOR 추가 (전공 데이터 소스)
  if (sources.includes('WORK24_JOB') || sources.includes('WORK24_DJOB') || sources.includes('WORK24_MAJOR') || sources.includes('GOYONG24')) {
    partials.GOYONG24 = profile
  }

  return partials
}

const extractCanonicalSuffix = (value: string, prefix: string): string | undefined => {
  if (value.startsWith(prefix)) {
    return value.substring(prefix.length)
  }
  return undefined
}

/**
 * Search for unified majors from D1 database
 * Simplified version - only uses D1, no API fallbacks
 */
export const searchUnifiedMajors = async (
  params: { keyword?: string; page?: number; perPage?: number; includeSources?: DataSource[]; sort?: string },
  env?: CareerWikiEnv
): Promise<UnifiedSearchResult<UnifiedMajorSummaryEntry>> => {
  const { keyword = '', page = 1, perPage = 20, sort = 'relevance' } = params

  // D1 database is required
  if (!env?.DB) {
    throw new Error('D1 database not available')
  }

  try {
    const db = env.DB as any
    const conditions: string[] = ['is_active = 1']
    const countBindings: any[] = []

  // 🔍 검색어 정규화 함수 (오타/공백/특수문자 허용)
  const normalizeSearchTerm = (term: string): string => {
    return term
      .toLowerCase()
      .replace(/\s+/g, '')           // 공백 제거
      .replace(/[·•\-_]/g, '')       // 특수문자 제거
      .replace(/[ㄱ-ㅎㅏ-ㅣ]/g, '')    // 단독 자모 제거
  }

  // 🔍 키워드 토큰화 함수 (한국어 복합어에서 의미있는 키워드 추출)
  const tokenizeKeyword = (kw: string): string[] => {
    const tokens: string[] = []
    const normalizedKw = kw.toLowerCase().replace(/\s+/g, '')
    
    // 1. 전공 관련 접미사 기반 분리
    const majorSuffixes = ['학과', '학부', '전공', '공학', '과학', '학']
    for (const suffix of majorSuffixes) {
      if (normalizedKw.endsWith(suffix) && normalizedKw.length > suffix.length + 1) {
        // 접미사 앞 부분 추가 (2글자 이상)
        const prefix = normalizedKw.slice(0, -suffix.length)
        if (prefix.length >= 2) {
          tokens.push(prefix)
        }
      }
    }
    
    // 2. 분야 키워드 추출
    const fieldKeywords = ['컴퓨터', '전자', '전기', '기계', '화학', '생명', '생물', '물리', '수학', '통계', '경영', '경제', '회계', '금융', '법학', '의학', '간호', '약학', '치의', '한의', '교육', '영어', '국어', '역사', '철학', '심리', '사회', '정치', '행정', '미디어', '언론', '광고', '디자인', '음악', '미술', '체육', '건축', '토목', '환경', '식품', '영양', '농업', '수산', '해양', '항공', '우주', '에너지', '신소재', '나노', '바이오', '소프트웨어', '정보', '데이터', '인공지능', 'ai', 'it']
    for (const fk of fieldKeywords) {
      if (normalizedKw.includes(fk) && normalizedKw !== fk) {
        tokens.push(fk)
      }
    }
    
    // 중복 제거, 원본 키워드 제외
    return [...new Set(tokens)].filter(t => t !== normalizedKw && t.length >= 2)
  }

  // 키워드 검색 조건 (확장된 범위: name + summary + heroSummary + 태그/카테고리)
  // + 토큰 기반 관련 검색 (우선순위 낮게)
  let useTokenSearch = false
  let tokens: string[] = []
  
  if (keyword?.trim()) {
    const searchTerm = keyword.trim()
    const normalizedTerm = normalizeSearchTerm(searchTerm)
    tokens = tokenizeKeyword(searchTerm)
    useTokenSearch = tokens.length > 0
    
    // 토큰 검색 조건 생성 (관련 키워드로 매칭)
    let tokenConditions = ''
    if (useTokenSearch) {
      const tokenClauses = tokens.map(() => 
        `LOWER(name) LIKE LOWER(?) OR LOWER(REPLACE(REPLACE(name, ' ', ''), '-', '')) LIKE LOWER(?)`
      ).join(' OR ')
      tokenConditions = ` OR (${tokenClauses})`
    }
    
    // 여러 필드에서 검색 (OR 조건) + 토큰 검색
    conditions.push(`(
      LOWER(name) LIKE LOWER(?) OR
      LOWER(REPLACE(REPLACE(name, ' ', ''), '-', '')) LIKE LOWER(?) OR
      json_extract(merged_profile_json, '$.summary') LIKE ? OR
      json_extract(merged_profile_json, '$.heroSummary') LIKE ? OR
      json_extract(merged_profile_json, '$.categoryDisplay') LIKE ? OR
      json_extract(merged_profile_json, '$.categoryName') LIKE ? OR
      json_extract(merged_profile_json, '$.heroTags') LIKE ?
      ${tokenConditions}
    )`)
    countBindings.push(
      `%${searchTerm}%`,           // 원본 검색어
      `%${normalizedTerm}%`,       // 정규화된 검색어 (공백/특수문자 제거)
      `%${searchTerm}%`,           // summary
      `%${searchTerm}%`,           // heroSummary
      `%${searchTerm}%`,           // categoryDisplay (계열)
      `%${searchTerm}%`,           // categoryName
      `%${searchTerm}%`            // heroTags
    )
    // 토큰 바인딩 추가
    if (useTokenSearch) {
      for (const token of tokens) {
        countBindings.push(`%${token}%`, `%${token}%`)
      }
    }
  }

  // 🚀 성능 최적화: 페이지네이션을 먼저 적용하여 필요한 전공명만 가져오기
  
  // Step 1: 고유한 전공명 목록을 페이지네이션 적용하여 가져오기
  // ⚠️ 주의: LIMIT 이후에도 정규화로 인한 병합이 발생할 수 있으므로 여유분을 가져옴
  
  // 정렬 옵션에 따른 ORDER BY 절
  const searchTerm = keyword?.trim() || ''
  const normalizedSearchTerm = normalizeSearchTerm(searchTerm)
  
  // normalizedSearchTerm이 빈 문자열이면 기본 정렬 사용 (SQL 오류 방지)
  const effectiveSort = (sort === 'relevance' && searchTerm && !normalizedSearchTerm) ? 'name-asc' : sort
  
  let orderByClause = 'ORDER BY normalized_name'
  if (effectiveSort === 'employment-desc') {
    // 취업률 높은 순 - chartData에서 추출
    orderByClause = `ORDER BY 
      CAST(COALESCE(
        json_extract(merged_profile_json, '$.chartData[0].employment_rate[0].data'),
        json_extract(merged_profile_json, '$.chartData.employment_rate[0].data'),
        json_extract(merged_profile_json, '$.employmentRate'),
        '0'
      ) AS REAL) DESC, normalized_name`
  } else if (effectiveSort === 'salary-desc') {
    // 월급 높은 순 (졸업 후 첫 직장 월급)
    orderByClause = `ORDER BY 
      CAST(COALESCE(
        json_extract(merged_profile_json, '$.salaryAfterGraduation'),
        '0'
      ) AS REAL) DESC, normalized_name`
  } else if (effectiveSort === 'name-asc') {
    orderByClause = 'ORDER BY normalized_name'
  } else if (effectiveSort === 'relevance' && searchTerm && normalizedSearchTerm) {
    // 🔍 검색 관련성 우선순위: 정확 일치 > 시작 일치 > 부분 일치 > 토큰 일치 > 데이터 풍부도
    // SQL 인젝션 방지: 작은따옴표 이스케이프 + 백슬래시 이스케이프
    // normalizedSearchTerm이 빈 문자열이면 기본 정렬 사용
    const escapedSearchTerm = searchTerm.replace(/\\/g, '\\\\').replace(/'/g, "''")
    const escapedNormalizedTerm = normalizedSearchTerm.replace(/\\/g, '\\\\').replace(/'/g, "''")
    
    orderByClause = `ORDER BY 
      (CASE 
        WHEN LOWER(name) = LOWER('${escapedSearchTerm}') THEN 0
        WHEN LOWER(REPLACE(REPLACE(name, ' ', ''), '-', '')) = LOWER('${escapedNormalizedTerm}') THEN 1
        WHEN LOWER(name) LIKE LOWER('${escapedSearchTerm}%') THEN 2
        WHEN LOWER(name) LIKE LOWER('%${escapedSearchTerm}%') THEN 3
        WHEN LOWER(REPLACE(REPLACE(name, ' ', ''), '-', '')) LIKE LOWER('%${escapedNormalizedTerm}%') THEN 4
        ELSE 5
      END),
      (CASE WHEN json_extract(merged_profile_json, '$.employmentRate') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.firstJobSalary') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.firstJobSatisfaction') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.heroSummary') IS NOT NULL THEN 1 ELSE 0 END) DESC, normalized_name`
  } else {
    // 기본: 데이터 풍부도 순
    orderByClause = `ORDER BY 
      (CASE WHEN json_extract(merged_profile_json, '$.employmentRate') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.firstJobSalary') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.firstJobSatisfaction') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.heroSummary') IS NOT NULL THEN 1 ELSE 0 END) DESC, normalized_name`
  }
  
  let uniqueNamesQuery = `
    SELECT DISTINCT LOWER(name) as normalized_name, name as original_name, merged_profile_json
    FROM majors
  `
  if (conditions.length > 0) {
    uniqueNamesQuery += ' WHERE ' + conditions.join(' AND ')
  }
  uniqueNamesQuery += ` ${orderByClause}`
  
  // 페이지네이션 적용 (정규화 병합을 고려하여 충분히 가져오기)
  const offset = (page - 1) * perPage
  // 병합으로 줄어드는 케이스를 대비해 2배 버퍼 확보
  const limitWithBuffer = Math.ceil(perPage * 2)
  uniqueNamesQuery += ` LIMIT ${limitWithBuffer} OFFSET ${offset}`
  
  const uniqueNamesResult = await withD1Retry(
    () => db.prepare(uniqueNamesQuery).bind(...countBindings).all()
  ) as { results?: any[] }
  const uniqueNames = uniqueNamesResult?.results || []
  
  if (uniqueNames.length === 0) {
    // 결과가 없으면 빈 배열 반환
    return {
      items: [],
      meta: {
        total: 0,
        sources: createInitialSourceStatus()
      }
    }
  }
  
  // Step 2: 해당 전공명들에 대한 모든 레코드 조회 (병합을 위해)
  const nameList = uniqueNames.map((r: any) => r.original_name)
  
  // 🔧 SQLite 변수 제한을 피하기 위해 IN 절을 청크로 나눔 (최대 100개씩)
  const CHUNK_SIZE = 100
  const d1Majors: any[] = []
  
  for (let i = 0; i < nameList.length; i += CHUNK_SIZE) {
    const chunk = nameList.slice(i, i + CHUNK_SIZE)
    const placeholders = chunk.map(() => '?').join(', ')
    
    // uniqueNames에서 이미 검색 조건을 적용했으므로 여기서는 name IN만 사용
    let detailQuery = `
      SELECT id, name, slug, careernet_id, goyong24_id, merged_profile_json, api_data_json, image_url 
      FROM majors 
      WHERE name IN (${placeholders}) AND is_active = 1
    `
    detailQuery += ' ORDER BY LOWER(name)'
    
    // name IN에 필요한 바인딩만 사용 (검색 조건은 이미 uniqueNames에서 적용됨)
    const detailBindings = [...chunk]
    const result = await withD1Retry(
      () => db.prepare(detailQuery).bind(...detailBindings).all()
    ) as { results?: any[] }
    
    if (result?.results) {
      d1Majors.push(...result.results)
    }
  }
  
  // Step 3: 총 개수 계산 (전체 고유 전공명 수)
  let countQuery = 'SELECT COUNT(DISTINCT LOWER(name)) as total FROM majors'
  if (conditions.length > 0) {
    countQuery += ' WHERE ' + conditions.join(' AND ')
  }
  const countResult = await withD1Retry(
    () => db.prepare(countQuery).bind(...countBindings).first() as Promise<{ total: number } | null>
  )
  const totalCount = countResult?.total || 0

  // 🔄 전공명 정규화 함수 (보수적 접근 - 실제로 같은 전공인 경우만 병합)
  // ⚠️ "한국어학과"와 "국어국문학과"는 완전히 다른 전공이므로 병합되면 안 됨
  const normalizeMajorName = (name: string): string => {
    let normalized = name
      .trim()
      .toLowerCase()
      // 🔧 URL slug의 하이픈을 공백으로 변환
      .replace(/-/g, ' ')
      // "및"를 쉼표로 변환 (예: "컴퓨터공학 및 정보통신공학" → "컴퓨터공학,정보통신공학")
      .replace(/\s*및\s*/g, ',')
      // 가운뎃점을 쉼표로 변환
      .replace(/[·•]/g, ',')
      // 쉼표 앞뒤 공백 제거
      .replace(/\s*,\s*/g, ',')
      // 공백 정규화 (여러 공백을 하나로, 하지만 완전히 제거하지 않음)
      .replace(/\s+/g, ' ')
      .trim()
      // "학과", "학부", "전공" 접미사 통일 (제거) - 단, 실제로 같은 전공인 경우만
      .replace(/\s*(학과|학부|전공)$/g, '')
      // "과" 접미사 제거 (단, 실제로 같은 전공인 경우만)
      .replace(/\s*과$/g, '')
      // 최종 공백 제거 (하지만 단어 간 구분은 유지)
      .replace(/\s+/g, '')
    
    // 🔧 특수 케이스: "한국어"와 "국어국문"은 명확히 구분
    // "한국어학과" → "한국어", "국어국문학과" → "국어국문" (이미 위에서 처리됨)
    // 하지만 혹시 모를 경우를 대비해 명시적 체크는 하지 않음 (정규화만으로 충분)
    
    return normalized
  }
  
  // 🔧 병합 제외 목록: 서로 다른 전공이지만 정규화 후 비슷해 보일 수 있는 케이스
  const shouldNotMerge = (name1: string, name2: string): boolean => {
    const n1 = normalizeMajorName(name1)
    const n2 = normalizeMajorName(name2)
    
    // "한국어"와 "국어국문"은 완전히 다름
    if ((n1 === '한국어' && n2 === '국어국문') || (n1 === '국어국문' && n2 === '한국어')) {
      return true // 병합하지 않음
    }
    
    // "한국어"로 시작하는 것과 "국어"로 시작하는 것은 다름 (단, "국어국문"은 예외)
    if (n1.startsWith('한국어') && n2.startsWith('국어') && !n2.startsWith('국어국문')) {
      return true
    }
    if (n2.startsWith('한국어') && n1.startsWith('국어') && !n1.startsWith('국어국문')) {
      return true
    }
    
    return false // 기본적으로는 병합 허용
  }

  // 🔄 같은 이름의 전공을 병합하기 위한 Map
  // ⚠️ 병합 제외 목록을 고려하여 그룹화
  // 성능 최적화: 정규화된 이름을 미리 계산하여 Map에 저장
  const normalizedNameCache = new Map<string, string>() // 원본 이름 -> 정규화된 이름 캐시
  const majorsByName = new Map<string, any[]>()
  const mergedGroups: Array<{ normalized: string; originals: string[]; count: number }> = []
  
  // 첫 번째 패스: 정규화된 이름 계산 및 그룹화 (JSON 파싱 없이)
  d1Majors.forEach((row: any) => {
    const originalName = row.name?.trim()
    if (!originalName) return
    
    // 정규화된 이름 캐시 확인
    let normalizedName = normalizedNameCache.get(originalName)
    if (!normalizedName) {
      normalizedName = normalizeMajorName(originalName)
      normalizedNameCache.set(originalName, normalizedName)
    }
    
    // 🔧 병합 제외 체크: 같은 정규화된 이름이지만 병합하면 안 되는 경우
    let key = normalizedName
    
    // 기존 그룹이 있고, 병합하면 안 되는 경우 별도 그룹으로 분리
    if (majorsByName.has(normalizedName)) {
      const existingRows = majorsByName.get(normalizedName)!
      // 기존 행들과 비교하여 병합하면 안 되는 경우 체크 (첫 번째 행만 체크하여 최적화)
      const firstExistingName = existingRows[0]?.name?.trim()
      if (firstExistingName && shouldNotMerge(originalName, firstExistingName)) {
        // 병합하면 안 되므로 원본 이름을 포함한 고유 키 사용
        key = `${normalizedName}::${originalName}`
      }
    }
    
    if (!majorsByName.has(key)) {
      majorsByName.set(key, [])
    }
    majorsByName.get(key)!.push(row)
  })
  
  // 병합된 그룹 정보 수집
  majorsByName.forEach((rows, key) => {
    if (rows.length > 1) {
      const originalNames = [...new Set(rows.map(r => r.name?.trim()))].filter(Boolean)
      const normalizedName = key.includes('::') ? key.split('::')[0] : key
      mergedGroups.push({
        normalized: normalizedName,
        originals: originalNames,
        count: rows.length
      })
    }
  })
  
  const totalMergedRecords = mergedGroups.reduce((sum, group) => sum + group.count, 0)
  const savedRecords = totalMergedRecords - mergedGroups.length
  
  // 병합 로직 완료 (로그 제거)

  // Parse D1 results into UnifiedMajorSummaryEntry format
  const items: UnifiedMajorSummaryEntry[] = []
  
  // 각 고유 전공명에 대해 병합된 레코드 생성
  majorsByName.forEach((rows: any[]) => {
    try {
      // 원본 이름 중 가장 긴 이름을 선택 (정보가 가장 풍부함)
      const originalNames = rows.map(r => r.name?.trim()).filter(Boolean)
      const majorName = originalNames.reduce((longest, current) => 
        current.length > longest.length ? current : longest
      , originalNames[0] || '알 수 없음')
      
      // 🆕 ETL로 정제된 merged_profile_json 우선 사용
      let mergedProfile: any = null
      let careernetId: string | undefined
      let goyongId: string | undefined
      let majorSlug: string | undefined
      
      // merged_profile_json이 있는 첫 번째 행 찾기
      let majorImageUrl: string | undefined
      for (const row of rows) {
        if (row.merged_profile_json) {
          try {
            mergedProfile = JSON.parse(row.merged_profile_json)
            majorSlug = row.slug
            careernetId = row.careernet_id && row.careernet_id !== 'null' ? row.careernet_id : undefined
            goyongId = row.goyong24_id && row.goyong24_id !== 'null' ? row.goyong24_id : undefined
            // image_url 추출 (DB 컬럼 또는 merged_profile_json에서)
            majorImageUrl = row.image_url || mergedProfile.image_url
            break
          } catch (parseError) {
            console.error('[profileData] merged_profile_json parse failed:', parseError)
          }
        }
      }
      
      // merged_profile_json이 없으면 기존 api_data_json 로직 사용
      let careernetData: any = {}
      let goyongData: any = {}
      
      if (!mergedProfile) {
        rows.forEach((row: any) => {
          if (!careernetId && row.careernet_id && row.careernet_id !== 'null') {
            careernetId = row.careernet_id
          }
          if (!goyongId && row.goyong24_id && row.goyong24_id !== 'null') {
            goyongId = row.goyong24_id
          }
          if (!majorSlug && row.slug) {
            majorSlug = row.slug
          }
        })
        
        const rowsToProcess = rows.length === 1 ? [rows[0]] : rows
        rowsToProcess.forEach((row: any) => {
          let apiData = null
          if (row.api_data_json) {
            try {
              apiData = JSON.parse(row.api_data_json)
            } catch (parseError) {
            }
          }
          
          if (apiData?.careernet && Object.keys(apiData.careernet).length > 0) {
            careernetData = { ...careernetData, ...apiData.careernet }
          }
          if (apiData?.goyong24 && Object.keys(apiData.goyong24).length > 0) {
            goyongData = { ...goyongData, ...apiData.goyong24 }
          }
        })
      }
      
      // Determine sources
      const sources: DataSource[] = mergedProfile?.sources || []
      if (sources.length === 0) {
        if (careernetData && Object.keys(careernetData).length > 0) sources.push('CAREERNET')
        if (goyongData && Object.keys(goyongData).length > 0) sources.push('GOYONG24')
        if (sources.length === 0) sources.push('CAREERNET')
      }

      // Create profile (merged_profile_json 우선 사용)
      const profile: UnifiedMajorSummary = {
        id: majorSlug || majorName, // slug가 있으면 사용
        sourceIds: {
          careernet: mergedProfile?.sourceIds?.careernet || careernetId,
          goyong24: mergedProfile?.sourceIds?.work24 || goyongId
        },
        name: mergedProfile?.name || majorName,
        categoryName: mergedProfile?.categoryDisplay || mergedProfile?.categoryName || careernetData.categoryName || careernetData.department || goyongData.categoryName,
        summary: mergedProfile?.heroSummary || mergedProfile?.summary || careernetData.summary || goyongData.summary,
        sources
      }

      const entry: UnifiedMajorSummaryEntry = {
        profile,
        sourceMeta: {
          careernet: careernetId ? {
            majorSeq: careernetId
          } : undefined,
          goyong24: goyongId ? {
            majorGb: goyongData?.majorGb || mergedProfile?.majorGb || '1',
            departmentId: goyongData?.departmentId,
            majorId: goyongId
          } : undefined
        },
        display: (() => {
          // 🆕 merged_profile_json이 있으면 우선 사용
          if (mergedProfile) {
            // 첫직장임금(월)
            const firstJobSalary = mergedProfile.salaryAfterGraduation?.trim()
            
            // chartData 정규화 (배열인 경우 첫 번째 요소 사용)
            let chartData = mergedProfile.chartData
            if (Array.isArray(chartData)) {
              chartData = chartData[0]
            }
            
            // 🔧 취업률: chartData.employment_rate에서 "전체" 값 우선 사용 (정확한 수치)
            // 없으면 employmentRate 필드 폴백 (대략적인 값: "60% 이상" 등)
            let employmentRate: string | undefined = undefined
            if (chartData?.employment_rate && Array.isArray(chartData.employment_rate)) {
              const totalItem = chartData.employment_rate.find((e: any) => e.item === '전체')
              if (totalItem?.data) {
                const rate = parseFloat(totalItem.data)
                if (!isNaN(rate)) {
                  // 소수점 1자리까지 표시
                  employmentRate = Number.isInteger(rate) ? `${rate}%` : `${rate.toFixed(1)}%`
                }
              }
            }
            // 폴백: employmentRate 필드 사용 (대략적인 값)
            if (!employmentRate && mergedProfile.employmentRate) {
              employmentRate = mergedProfile.employmentRate.trim()
            }
            
            // 첫 직장 만족도: chartData.satisfaction에서 추출
            let firstJobSatisfaction: string | undefined = undefined
            if (chartData?.satisfaction && Array.isArray(chartData.satisfaction)) {
              // "만족" + "매우 만족" 합산 (긍정적 만족도)
              const satisfiedItem = chartData.satisfaction.find((s: any) => s.item === '만족')
              const verySatisfiedItem = chartData.satisfaction.find((s: any) => s.item === '매우 만족')
              const satisfiedScore = parseFloat(satisfiedItem?.data || '0')
              const verySatisfiedScore = parseFloat(verySatisfiedItem?.data || '0')
              const totalSatisfaction = satisfiedScore + verySatisfiedScore
              if (totalSatisfaction > 0) {
                firstJobSatisfaction = `${totalSatisfaction.toFixed(1)}%`
              }
            }
            
            // 대학 수
            const universityCount = Array.isArray(mergedProfile.universities) ? mergedProfile.universities.length : 0
            
            // 관련 직업 수
            const relatedJobCount = Array.isArray(mergedProfile.relatedJobs) ? mergedProfile.relatedJobs.length : 0
            
            return {
              summary: mergedProfile.heroSummary?.trim() || mergedProfile.summary?.trim(),
              categoryName: mergedProfile.categoryDisplay?.trim() || mergedProfile.categoryName?.trim(),
              employmentRate,
              salaryAfterGraduation: firstJobSalary,
              firstJobSalary,
              firstJobSatisfaction,
              universityCount: universityCount > 0 ? String(universityCount) : undefined,
              relatedJobCount: relatedJobCount > 0 ? String(relatedJobCount) : undefined,
              imageUrl: majorImageUrl
            }
          }
          
          // 기존 로직: api_data_json 사용
          const hasCareernet = careernetData && Object.keys(careernetData).length > 0
          const hasGoyong24 = goyongData && Object.keys(goyongData).length > 0
          
          // 둘 다 있으면 커리어넷 데이터만 사용
          if (hasCareernet && hasGoyong24) {
            const firstJobSalary = careernetData.salaryAfterGraduation?.trim()
            
            // 취업률: chartData.employment_rate에서 "전체" 값 우선 사용
            let employmentRate: string | undefined = undefined
            if (careernetData.chartData?.employment_rate && Array.isArray(careernetData.chartData.employment_rate)) {
              const totalItem = careernetData.chartData.employment_rate.find((e: any) => e.item === '전체')
              if (totalItem?.data) {
                const rate = parseFloat(totalItem.data)
                if (!isNaN(rate)) {
                  employmentRate = Number.isInteger(rate) ? `${rate}%` : `${rate.toFixed(1)}%`
                }
              }
            }
            if (!employmentRate && careernetData.employmentRate) {
              employmentRate = careernetData.employmentRate.trim()
            }
            
            let firstJobSatisfaction: string | undefined = undefined
            if (careernetData.chartData?.satisfaction && Array.isArray(careernetData.chartData.satisfaction)) {
              const satisfiedItem = careernetData.chartData.satisfaction.find((s: any) => s.item === '만족')
              const verySatisfiedItem = careernetData.chartData.satisfaction.find((s: any) => s.item === '매우 만족')
              const satisfiedScore = parseFloat(satisfiedItem?.data || '0')
              const verySatisfiedScore = parseFloat(verySatisfiedItem?.data || '0')
              const totalSatisfaction = satisfiedScore + verySatisfiedScore
              if (totalSatisfaction > 0) {
                firstJobSatisfaction = `${totalSatisfaction.toFixed(1)}%`
              }
            }
            
            return {
              summary: careernetData.summary?.trim(),
              categoryName: (careernetData.categoryName || careernetData.department)?.trim(),
              employmentRate,
              salaryAfterGraduation: firstJobSalary,
              firstJobSalary,
              firstJobSatisfaction,
              imageUrl: majorImageUrl
            }
          }
          
          // 고용24 데이터만 있는 경우
          if (!hasCareernet && hasGoyong24) {
            return {
              summary: goyongData.summary?.trim(),
              categoryName: goyongData.categoryName?.trim(),
              jobProspect: goyongData.jobProspect?.trim(),
              departmentName: goyongData.departmentName?.trim(),
              imageUrl: majorImageUrl
            }
          }
          
          // 커리어넷 데이터만 있는 경우
          if (hasCareernet && !hasGoyong24) {
            const firstJobSalary = careernetData.salaryAfterGraduation?.trim()
            
            // 취업률: chartData.employment_rate에서 "전체" 값 우선 사용
            let employmentRate: string | undefined = undefined
            if (careernetData.chartData?.employment_rate && Array.isArray(careernetData.chartData.employment_rate)) {
              const totalItem = careernetData.chartData.employment_rate.find((e: any) => e.item === '전체')
              if (totalItem?.data) {
                const rate = parseFloat(totalItem.data)
                if (!isNaN(rate)) {
                  employmentRate = Number.isInteger(rate) ? `${rate}%` : `${rate.toFixed(1)}%`
                }
              }
            }
            if (!employmentRate && careernetData.employmentRate) {
              employmentRate = careernetData.employmentRate.trim()
            }
            
            let firstJobSatisfaction: string | undefined = undefined
            if (careernetData.chartData?.satisfaction && Array.isArray(careernetData.chartData.satisfaction)) {
              const satisfiedItem = careernetData.chartData.satisfaction.find((s: any) => s.item === '만족')
              const verySatisfiedItem = careernetData.chartData.satisfaction.find((s: any) => s.item === '매우 만족')
              const satisfiedScore = parseFloat(satisfiedItem?.data || '0')
              const verySatisfiedScore = parseFloat(verySatisfiedItem?.data || '0')
              const totalSatisfaction = satisfiedScore + verySatisfiedScore
              if (totalSatisfaction > 0) {
                firstJobSatisfaction = `${totalSatisfaction.toFixed(1)}%`
              }
            }
            
            return {
              summary: careernetData.summary?.trim(),
              categoryName: (careernetData.categoryName || careernetData.department)?.trim(),
              employmentRate,
              salaryAfterGraduation: firstJobSalary,
              firstJobSalary,
              firstJobSatisfaction,
              imageUrl: majorImageUrl
            }
          }
          
          // 둘 다 없는 경우
          return {
            summary: undefined,
            categoryName: undefined,
            imageUrl: majorImageUrl
          }
        })()
      }

      items.push(entry)
    } catch (entryError) {
      console.error('[profileData] job entry processing failed:', entryError)
    }
  })

  // 🔧 JavaScript에서 최종 정렬 적용 (DB 병합 후 순서가 깨질 수 있음)
  const parseNumberFromDisplay = (value: string | undefined): number => {
    if (!value) return 0
    const match = value.match(/([\d.]+)/)
    return match ? parseFloat(match[1]) : 0
  }
  
  // 🔍 검색어가 있을 때: 매칭 필드에 따른 우선순위 정렬
  // 우선순위: 이름 > 정규화이름 > 태그 > 히어로소개 > 카테고리 > 계열
  if (keyword?.trim() && sort === 'relevance') {
    const searchTerm = keyword.trim().toLowerCase()
    const normalizedSearchTerm = searchTerm.replace(/\s+/g, '').replace(/[·•\-_]/g, '')
    
    const getMatchScore = (item: UnifiedMajorSummaryEntry): number => {
      const name = (typeof item.profile?.name === 'string' ? item.profile.name : '').toLowerCase()
      const normalizedName = name.replace(/\s+/g, '').replace(/[·•\-_]/g, '')
      const heroTags = JSON.stringify((item as any).display?.heroTags || []).toLowerCase()
      const heroSummary = (typeof item.display?.summary === 'string' ? item.display.summary : '').toLowerCase()
      
      // categoryName이 문자열이 아닐 수 있음 (객체일 수도 있음)
      let categoryName = ''
      if (item.display?.categoryName) {
        if (typeof item.display.categoryName === 'string') {
          categoryName = item.display.categoryName.toLowerCase()
        } else if (typeof item.display.categoryName === 'object' && item.display.categoryName !== null) {
          const catObj = item.display.categoryName as any
          categoryName = (catObj.value || catObj.large || '').toLowerCase()
        }
      }
      
      // categoryDisplay도 문자열이 아닐 수 있음
      let categoryDisplay = ''
      const catDisplay = (item.display as any)?.categoryDisplay
      if (catDisplay) {
        if (typeof catDisplay === 'string') {
          categoryDisplay = catDisplay.toLowerCase()
        } else if (typeof catDisplay === 'object' && catDisplay !== null) {
          categoryDisplay = (catDisplay.value || catDisplay.large || '').toLowerCase()
        }
      }
      
      // 우선순위 점수 (높을수록 먼저)
      if (name.includes(searchTerm)) return 100           // 1. 이름 매칭
      if (normalizedName.includes(normalizedSearchTerm)) return 90  // 2. 정규화 이름 매칭
      if (heroTags.includes(searchTerm)) return 70        // 3. 태그 매칭
      if (heroSummary.includes(searchTerm)) return 50     // 4. 히어로 소개 매칭
      if (categoryName.includes(searchTerm)) return 30    // 5. 카테고리 매칭
      if (categoryDisplay.includes(searchTerm)) return 20 // 6. 계열 매칭
      return 0
    }
    
    items.sort((a, b) => {
      const scoreA = getMatchScore(a)
      const scoreB = getMatchScore(b)
      if (scoreB !== scoreA) return scoreB - scoreA
      // 점수가 같으면 이름순
      return (a.profile?.name || '').localeCompare(b.profile?.name || '', 'ko')
    })
  } else if (sort === 'salary-desc') {
    // 월급 높은 순 (salaryAfterGraduation)
    items.sort((a, b) => {
      const salaryA = parseNumberFromDisplay(a.display?.salaryAfterGraduation || a.display?.firstJobSalary)
      const salaryB = parseNumberFromDisplay(b.display?.salaryAfterGraduation || b.display?.firstJobSalary)
      return salaryB - salaryA
    })
  } else if (sort === 'employment-desc') {
    // 취업률 높은 순
    items.sort((a, b) => {
      const rateA = parseNumberFromDisplay(a.display?.employmentRate)
      const rateB = parseNumberFromDisplay(b.display?.employmentRate)
      return rateB - rateA
    })
  } else if (sort === 'relevance') {
    // 기본 순 (데이터 풍부도) - 검색어 없을 때
    items.sort((a, b) => {
      const scoreA = (a.display?.employmentRate ? 1 : 0) + 
                     (a.display?.salaryAfterGraduation || a.display?.firstJobSalary ? 1 : 0) + 
                     (a.display?.firstJobSatisfaction ? 1 : 0) + 
                     (a.profile?.summary ? 1 : 0)
      const scoreB = (b.display?.employmentRate ? 1 : 0) + 
                     (b.display?.salaryAfterGraduation || b.display?.firstJobSalary ? 1 : 0) + 
                     (b.display?.firstJobSatisfaction ? 1 : 0) + 
                     (b.profile?.summary ? 1 : 0)
      return scoreB - scoreA
    })
  }

  // 🔧 정규화 병합으로 인해 perPage보다 많거나 적을 수 있으므로 정확히 perPage 개수로 제한
  const paginatedItems = items.slice(0, perPage)

  // 🚀 페이지네이션은 이미 데이터베이스 레벨에서 적용됨 (LIMIT/OFFSET)
  const resultSources = createInitialSourceStatus()
  resultSources.CAREERNET = { attempted: true, count: paginatedItems.filter(i => i.profile.sources.includes('CAREERNET')).length }
  resultSources.GOYONG24 = { attempted: true, count: paginatedItems.filter(i => i.profile.sources.includes('GOYONG24')).length }
  
  return {
    items: paginatedItems, // 정확히 요청한 개수만 반환
    meta: {
      total: totalCount, // 전체 고유 전공명 수
      sources: resultSources
    }
  }
  } catch (error) {
    
    // 에러 발생 시 빈 결과 반환 (500 에러 방지)
    return {
      items: [],
      meta: {
        total: 0,
        sources: createInitialSourceStatus()
      }
    }
  }
}

/**
 * Search for unified jobs from D1 database
 * Simplified version - only uses D1, no API fallbacks
 */
export const searchUnifiedJobs = async (
  params: { keyword?: string; category?: string; page?: number; perPage?: number; includeSources?: DataSource[]; sort?: string },
  env?: CareerWikiEnv
): Promise<UnifiedSearchResult<UnifiedJobSummaryEntry>> => {
  const { keyword = '', category = '', page = 1, perPage = 20, sort = 'relevance' } = params

  // D1 database is required
  if (!env?.DB) {
    throw new Error('D1 database not available')
  }

  const db = env.DB as any
  const toNfc = (s?: string) => (s ? s.normalize('NFC') : '')
  const keywordTrimmed = keyword.trim()

  // 계열 값 정규화: 브레드크럼 문자열이면 첫 구간(대분류)만 사용
  const pickPrimaryCategory = (value: any, jobName?: string): string => {
    let cat = ''
    if (typeof value === 'string') {
      cat = value
    } else if (value && typeof value === 'object') {
      cat = value.large || value.value || value.name || value.medium || value.small || ''
    }
    if (cat.includes('›')) {
      cat = cat.split('›')[0].trim()
    } else if (cat.includes('>')) {
      cat = cat.split('>')[0].trim()
    }
    return cat
  }

  // 🚀 FTS5 경로 비활성화: TEXT ID와의 호환성 문제 + prefix 검색 한계로 LIKE 검색 사용
  // FTS는 "푸드*"처럼 시작하는 것만 찾고, "패스트푸드"처럼 중간에 있는 건 못 찾음
  // 또한 새로 생성된 직업(TEXT ID)은 FTS 테이블에 추가되지 않음
  const useFts = false // 항상 LIKE 검색 사용
  if (useFts) {
    // 🔧 와일드카드 추가: "푸드" → "푸드*" (prefix 검색 활성화)
    const q = toNfc(keywordTrimmed) + '*'
    const offset = (page - 1) * perPage

    let ftsRows: any[] = []
    try {
      const ftsResult = await withD1Retry(
        () =>
          db
            .prepare(
              `SELECT j.id,
                      j.name,
                      j.slug,
                      json_extract(j.merged_profile_json, '$.summary') AS summary,
                      json_extract(j.merged_profile_json, '$.salary') AS salary,
                      json_extract(j.merged_profile_json, '$.satisfaction') AS satisfaction,
                      json_extract(j.merged_profile_json, '$.wlb') AS wlb,
                      json_extract(j.merged_profile_json, '$.overviewWork.workStrong') AS workStrong,
                      json_extract(j.merged_profile_json, '$.overviewAbilities.skillYear') AS skillYear,
                      json_extract(j.merged_profile_json, '$.heroCategory.value') AS categoryValue,
                      json_extract(j.merged_profile_json, '$.heroCategory.small') AS categorySmall,
                      json_extract(j.merged_profile_json, '$.heroCategory.large') AS categoryLarge
               FROM jobs_search_fts fts
               JOIN jobs j ON CAST(j.id AS TEXT) = CAST(fts.rowid AS TEXT)
               WHERE jobs_search_fts MATCH ?
                 AND j.is_active = 1
               ORDER BY bm25(jobs_search_fts) ASC
               LIMIT ? OFFSET ?`
            )
            .bind(q, perPage, offset)
            .all()
      ) as { results?: any[] }
      ftsRows = ftsResult?.results || []
    } catch (e) {
      ftsRows = []
    }

    // 🔧 FTS 결과가 없으면 LIKE 폴백 검색으로 진행 (아래 로직 사용)
    if (ftsRows.length === 0) {
      // FTS 결과 없음 - LIKE 폴백으로 진행
    } else {
      const items: UnifiedJobSummaryEntry[] = ftsRows.map((row: any) => {
      const id = String(row.id ?? row.slug ?? row.name ?? '')
      const slug = String(row.slug ?? row.name ?? row.id ?? '')
      const nameSafe = String(row.name ?? '')
      const rawCategoryName =
        (row.categoryValue && String(row.categoryValue)) ||
        (row.categorySmall && String(row.categorySmall)) ||
        (row.categoryLarge && String(row.categoryLarge)) ||
        undefined
      const categoryName = pickPrimaryCategory(rawCategoryName, nameSafe)
      return {
        profile: {
          id,
          sourceIds: {
            careernet: undefined,
            goyong24: undefined
          },
          name: nameSafe,
          category: undefined,
          sources: ['CAREERNET']
        },
        sourceMeta: {},
        display: {
          summary: (row.summary && String(row.summary)) || '',
          categoryName,
          categoryLarge: categoryName,
          categoryMedium: undefined,
          categorySmall: categoryName,
          salary: row.salary ? String(row.salary) : undefined,
          satisfaction: row.satisfaction ? String(row.satisfaction) : undefined,
          wlb: row.wlb ? String(row.wlb) : undefined,
          workStrong: row.workStrong ? String(row.workStrong) : undefined,
          skillYear: row.skillYear ? String(row.skillYear) : undefined,
          // slug는 detail 링크 생성 시 사용 가능
          slug
        },
        _sources: { CAREERNET: row.summary ? 1 : 0 }
      }
    })

    const resultSources = createInitialSourceStatus()
    resultSources.CAREERNET = { attempted: true, count: items.length }

      return {
        items,
        meta: {
          total: items.length,
          sources: resultSources
        }
      }
    }
  }
  // 🔧 FTS 결과가 없거나 FTS를 사용하지 않을 때 LIKE 폴백 검색
  const conditions: string[] = ['merged_profile_json IS NOT NULL', 'is_active = 1']
  const bindings: any[] = []

  // 🔍 검색어 정규화 함수 (오타/공백/특수문자 허용)
  const normalizeSearchTerm = (term: string): string => {
    return term
      .toLowerCase()
      .replace(/\s+/g, '')           // 공백 제거
      .replace(/[·•\-_]/g, '')       // 특수문자 제거
      .replace(/[ㄱ-ㅎㅏ-ㅣ]/g, '')    // 단독 자모 제거
  }

  // 🔍 키워드 토큰화 함수 (한국어 복합어에서 의미있는 키워드 추출)
  const tokenizeKeyword = (kw: string): string[] => {
    const tokens: string[] = []
    const normalizedKw = kw.toLowerCase().replace(/\s+/g, '')
    
    // 1. 직업 관련 접미사 기반 분리
    const jobSuffixes = ['개발자', '엔지니어', '기술자', '설계사', '분석가', '관리자', '디자이너', '연구원', '전문가', '컨설턴트', '프로그래머', '운영자', '기획자', '마케터']
    for (const suffix of jobSuffixes) {
      if (normalizedKw.includes(suffix) && normalizedKw !== suffix && normalizedKw.length > suffix.length + 1) {
        tokens.push(suffix)
        // 접미사 앞 부분도 의미 있으면 추가 (2글자 이상)
        const idx = normalizedKw.indexOf(suffix)
        if (idx > 1) {
          const prefix = normalizedKw.substring(0, idx)
          // "용"으로 끝나면 제거 (과학용 → 과학)
          const cleanPrefix = prefix.replace(/용$/, '')
          if (cleanPrefix.length >= 2) {
            tokens.push(cleanPrefix)
          }
        }
      }
    }
    
    // 2. 도메인/기술 키워드 추출
    const techKeywords = ['소프트웨어', '하드웨어', '데이터', '시스템', '네트워크', '보안', '서버', '웹', '앱', '모바일', '클라우드', '인공지능', '머신러닝', '백엔드', '프론트엔드', '풀스택', '게임', '임베디드', '과학', '금융', '의료', '교육', '영상', '음향', '그래픽', '애니메이션', '블록체인', '빅데이터', 'it', 'ai', 'iot']
    for (const tk of techKeywords) {
      if (normalizedKw.includes(tk) && normalizedKw !== tk) {
        tokens.push(tk)
      }
    }
    
    // 중복 제거, 원본 키워드 제외
    return [...new Set(tokens)].filter(t => t !== normalizedKw && t.length >= 2)
  }

  // 키워드 검색 조건 (확장된 범위: name + summary + heroIntro + 태그/카테고리)
  // + 토큰 기반 관련 검색 (우선순위 낮게)
  let useTokenSearch = false
  let tokens: string[] = []
  
  if (keyword?.trim()) {
    const searchTerm = keyword.trim()
    const normalizedTerm = normalizeSearchTerm(searchTerm)
    tokens = tokenizeKeyword(searchTerm)
    useTokenSearch = tokens.length > 0
    
    // 토큰 검색 조건 생성 (관련 키워드로 매칭)
    let tokenConditions = ''
    if (useTokenSearch) {
      const tokenClauses = tokens.map(() => 
        `LOWER(name) LIKE LOWER(?) OR LOWER(REPLACE(REPLACE(name, ' ', ''), '-', '')) LIKE LOWER(?)`
      ).join(' OR ')
      tokenConditions = ` OR (${tokenClauses})`
    }
    
    // 여러 필드에서 검색 (OR 조건) + 토큰 검색
    conditions.push(`(
      LOWER(name) LIKE LOWER(?) OR
      LOWER(REPLACE(REPLACE(name, ' ', ''), '-', '')) LIKE LOWER(?) OR
      json_extract(merged_profile_json, '$.summary') LIKE ? OR
      json_extract(merged_profile_json, '$.heroIntro') LIKE ? OR
      json_extract(merged_profile_json, '$.categoryName') LIKE ? OR
      json_extract(merged_profile_json, '$.heroTags') LIKE ? OR
      json_extract(merged_profile_json, '$.keywords') LIKE ?
      ${tokenConditions}
    )`)
    bindings.push(
      `%${searchTerm}%`,           // 원본 검색어
      `%${normalizedTerm}%`,       // 정규화된 검색어 (공백/특수문자 제거)
      `%${searchTerm}%`,           // summary
      `%${searchTerm}%`,           // heroIntro
      `%${searchTerm}%`,           // categoryName
      `%${searchTerm}%`,           // heroTags
      `%${searchTerm}%`            // keywords
    )
    // 토큰 바인딩 추가
    if (useTokenSearch) {
      for (const token of tokens) {
        bindings.push(`%${token}%`, `%${token}%`)
      }
    }
  }

  // Step 1: 총 개수 계산 (ECONNRESET 등 연결 오류 시 자동 재시도)
  let countQuery = `SELECT COUNT(*) as total FROM jobs WHERE ${conditions.join(' AND ')}`
  const countResult = await withD1Retry(
    () => db.prepare(countQuery).bind(...bindings).first() as Promise<{ total: number } | null>
  )
  const totalCount = countResult?.total || 0

  if (totalCount === 0) {
    return {
      items: [],
      meta: {
        total: 0,
        sources: createInitialSourceStatus()
      }
    }
  }

  // Step 2: 페이지네이션 적용하여 직업 목록 조회
  const offset = (page - 1) * perPage
  const searchTerm = keyword?.trim() || ''
  const normalizedSearchTerm = normalizeSearchTerm(searchTerm)
  
  // 정렬 옵션에 따른 ORDER BY 절
  // 검색어가 있을 때: 관련성 우선순위 정렬 (정확 일치 > 부분 일치 > 토큰 일치)
  let orderByClause = 'ORDER BY name'
  if (sort === 'name-asc') {
    orderByClause = 'ORDER BY name'
  } else if (sort === 'relevance' && searchTerm) {
    // 🔍 검색 관련성 우선순위: 정확 일치 > 시작 일치 > 부분 일치 > 토큰 일치 > 데이터 풍부도
    orderByClause = `ORDER BY 
      (CASE 
        WHEN LOWER(name) = LOWER('${searchTerm.replace(/'/g, "''")}') THEN 0
        WHEN LOWER(REPLACE(REPLACE(name, ' ', ''), '-', '')) = LOWER('${normalizedSearchTerm.replace(/'/g, "''")}') THEN 1
        WHEN LOWER(name) LIKE LOWER('${searchTerm.replace(/'/g, "''")}%') THEN 2
        WHEN LOWER(name) LIKE LOWER('%${searchTerm.replace(/'/g, "''")}%') THEN 3
        WHEN LOWER(REPLACE(REPLACE(name, ' ', ''), '-', '')) LIKE LOWER('%${normalizedSearchTerm.replace(/'/g, "''")}%') THEN 4
        ELSE 5
      END),
      (CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.satisfaction') IS NOT NULL OR json_extract(merged_profile_json, '$.overviewSalary.jobSatis') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.wlb') IS NOT NULL OR json_extract(merged_profile_json, '$.detailWlb.wlb') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.heroIntro') IS NOT NULL OR json_extract(merged_profile_json, '$.summary') IS NOT NULL THEN 1 ELSE 0 END) DESC, name`
  } else {
    // 기본: 데이터 풍부도 순 (여러 필드가 있는 항목 우선)
    orderByClause = `ORDER BY 
      (CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.satisfaction') IS NOT NULL OR json_extract(merged_profile_json, '$.overviewSalary.jobSatis') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.wlb') IS NOT NULL OR json_extract(merged_profile_json, '$.detailWlb.wlb') IS NOT NULL THEN 1 ELSE 0 END +
       CASE WHEN json_extract(merged_profile_json, '$.heroIntro') IS NOT NULL OR json_extract(merged_profile_json, '$.summary') IS NOT NULL THEN 1 ELSE 0 END) DESC, name`
  }
  
  const listQuery = `
    SELECT id, name, slug, primary_source, merged_profile_json, image_url
    FROM jobs 
    WHERE ${conditions.join(' AND ')}
    ${orderByClause}
    LIMIT ${perPage} OFFSET ${offset}
  `
  const listResult = await withD1Retry(
    () => db.prepare(listQuery).bind(...bindings).all()
  ) as { results?: any[] }
  const d1Jobs = listResult?.results || []

  // Parse D1 results into UnifiedJobSummaryEntry format
  const items: UnifiedJobSummaryEntry[] = []

  d1Jobs.forEach((row: any) => {
    try {
      // merged_profile_json 파싱
      const profile = row.merged_profile_json ? JSON.parse(row.merged_profile_json) : {}
      const jobName = profile.name || row.name || '알 수 없음'
      
      // sources 추출
      const sources: DataSource[] = Array.isArray(profile.sources) ? profile.sources : ['CAREERNET']
      
      // sourceIds 추출
      const sourceIds = profile.sourceIds || {}
      
      // 히어로 설명 (상세페이지와 동일한 로직)
      const heroDescription =
        profile.heroIntro?.split('\n')[0]?.trim() ||
        profile.summary?.split('\n')[0]?.trim() ||
        profile.work?.summary?.split('\n')[0]?.trim() ||
        profile.duties?.split('\n')[0]?.trim() ||
        profile.overviewWork?.main?.split('\n')[0]?.trim() ||
        ''
      
      // 카테고리 추출 (heroCategory 우선, 브레드크럼이면 대분류만 사용)
      let categoryLarge = ''
      let categoryMedium = ''
      let categorySmall = ''
      let categoryName = ''
      
      if (typeof profile.heroCategory === 'string' || (profile.heroCategory && typeof profile.heroCategory === 'object')) {
        categoryName = pickPrimaryCategory(profile.heroCategory, jobName)
        categoryLarge = pickPrimaryCategory(profile.heroCategory, jobName)
        categoryMedium = typeof profile.heroCategory === 'object' ? (profile.heroCategory.medium || '') : ''
        categorySmall = typeof profile.heroCategory === 'object' ? (profile.heroCategory.small || '') : ''
      }
      
      // heroCategory가 비었거나 직업명과 동일해 제거된 경우, 다른 계열 필드에서 폴백
      if (!categoryName) {
        categoryName = pickPrimaryCategory(profile.categoryName || profile.category?.name, jobName)
      }
      
      // 메트릭 데이터 추출 (우선순위: 연봉 > 만족도 > 워라벨 > 작업강도 > 숙련기간)
      
      // 1. 평균 연봉
      let salary: string | undefined
      const salData = profile.salary || profile.overviewSalary?.wage || profile.overviewSalary?.sal
      if (salData) {
        const salText = String(salData).trim()
        // "조사년도:2023년, 임금 하위(25%) 3150만원, 평균(50%) 3600만원, 상위(25%) 4500만원" → "평균 3600만원"
        const match = salText.match(/평균\(50%\)\s*(\d[\d,]*만원)/)
        if (match) {
          salary = match[1]
        } else if (/^[\d,]+$/.test(salText.replace(/만원/g, ''))) {
          // 숫자만 있는 경우 (예: "2,000" 또는 "2000만원")
          const numOnly = salText.replace(/[만원,]/g, '')
          salary = `${numOnly}만원`
        } else if (salText.includes('만원')) {
          salary = salText.replace(/평균\s*/g, '')
        }
      }
      
      // 2. 만족도 (여러 경로 지원)
      let satisfaction: string | undefined
      const satisData = 
        profile.satisfaction || 
        profile.overviewAptitude?.satisfaction?.value ||
        profile.overviewSalary?.jobSatis || 
        profile.detailWlb?.satisfaction
      if (satisData) {
        const satisText = String(satisData).trim()
        // 숫자만 있으면 % 붙이기
        if (/^[\d.]+$/.test(satisText)) {
          satisfaction = `${satisText}%`
        } else {
          satisfaction = satisText
        }
      }
      
      // 3. 워라벨 (여러 경로 지원)
      let wlb: string | undefined
      const wlbData = profile.wlb || profile.detailWlb?.wlb
      if (wlbData) {
        wlb = String(wlbData).trim()
      }
      
      // 4. 작업 강도 (직업사전 - overviewWork에서 추출)
      // "가벼운 작업" → "가벼움", "아주 가벼운 작업" → "아주 가벼움" 등으로 간결하게 변환
      let workStrong: string | undefined
      const workStrongData = profile.overviewWork?.workStrong || profile.optionJobInfo?.workStrong
      if (workStrongData) {
        const raw = String(workStrongData).trim()
        // 워딩 간결화
        const workStrongMap: Record<string, string> = {
          '아주 가벼운 작업': '아주 가벼움',
          '가벼운 작업': '가벼움',
          '보통 작업': '보통',
          '힘든 작업': '힘듬',
          '아주 힘든 작업': '아주 힘듬'
        }
        workStrong = workStrongMap[raw] || raw
      }
      
      // 5. 숙련기간 (overviewAbilities에서 추출)
      // "6개월 초과 ~ 1년 이하" → "6개월 ~ 1년" 형태로 간결하게 변환
      // 단위가 같을 때 앞 단위 제거: "1년~2년" → "1~2년"
      let skillYear: string | undefined
      const skillYearData = profile.overviewAbilities?.skillYear || profile.optionJobInfo?.skillYear
      if (skillYearData) {
        let raw = String(skillYearData).trim()
        // "초과", "이하" 단어 제거하여 간결하게 표시
        raw = raw
          .replace(/\s*초과\s*/g, ' ')
          .replace(/\s*이하\s*/g, '')
          .replace(/\s+/g, ' ')
          .trim()
        
        // 단위가 같을 때 앞 단위 제거 포맷팅 (공백 고려)
        const rangeMatch = raw.match(/^(.+?)\s*([~-])\s*(.+)$/)
        if (rangeMatch) {
          const [, start, separator, end] = rangeMatch
          const startTrimmed = start.trim()
          const unitMatch = startTrimmed.match(/(\d+)\s*(년|개월|월)$/)
          if (unitMatch) {
            const [, startNum, unit] = unitMatch
            const endTrimmed = end.trim()
            const endMatch = endTrimmed.match(/^(\d+)\s*(년|개월|월)$/)
            if (endMatch) {
              const [, endNum, endUnit] = endMatch
              // 단위가 같으면 앞 단위 제거
              if (unit === endUnit) {
                raw = `${startNum}${separator}${endNum}${unit}`
              }
            }
          }
        }
        
        skillYear = raw
      }

      const entry: UnifiedJobSummaryEntry = {
        profile: {
          id: row.id || jobName,
          sourceIds: {
            careernet: sourceIds.careernet,
            goyong24: sourceIds.goyong24 || sourceIds.work24_job || sourceIds.work24_djob
          },
          name: jobName,
          category: categoryName ? { name: categoryName } : undefined,
          sources
        },
        sourceMeta: {
          careernet: sourceIds.careernet ? { jobdicSeq: sourceIds.careernet } : undefined,
          goyong24: sourceIds.goyong24 ? { jobCd: sourceIds.goyong24 } : undefined
        },
        display: {
          summary: heroDescription,
          categoryName,
          categoryLarge,
          categoryMedium,
          categorySmall,
          salary,
          satisfaction,
          wlb,
          workStrong,
          skillYear,
          imageUrl: row.image_url || profile.image_url
        }
      }

      items.push(entry)
    } catch (entryError) {
      console.error('[profileData] major entry processing failed:', entryError)
    }
  })

  // JavaScript에서 정렬 후처리 (SQL에서 처리하기 어려운 정렬)
  
  // 🔍 검색어가 있을 때: 매칭 필드에 따른 우선순위 정렬
  // 우선순위: 이름 > 정규화이름 > 태그 > 히어로소개 > 카테고리 > 키워드
  if (keyword?.trim() && sort === 'relevance') {
    const searchTerm = keyword.trim().toLowerCase()
    const normalizedSearchTerm = searchTerm.replace(/\s+/g, '').replace(/[·•\-_]/g, '')
    
    const getMatchScore = (item: UnifiedJobSummaryEntry): number => {
      const name = (typeof item.profile?.name === 'string' ? item.profile.name : '').toLowerCase()
      const normalizedName = name.replace(/\s+/g, '').replace(/[·•\-_]/g, '')
      const heroTags = JSON.stringify((item.display as any)?.heroTags || []).toLowerCase()
      const heroIntro = (typeof item.display?.summary === 'string' ? item.display.summary : '').toLowerCase()
      
      // categoryName이 문자열이 아닐 수 있음 (객체일 수도 있음)
      let categoryName = ''
      if (item.display?.categoryName) {
        if (typeof item.display.categoryName === 'string') {
          categoryName = item.display.categoryName.toLowerCase()
        } else if (typeof item.display.categoryName === 'object' && item.display.categoryName !== null) {
          // 객체인 경우 value나 large 필드 추출
          const catObj = item.display.categoryName as any
          categoryName = (catObj.value || catObj.large || '').toLowerCase()
        }
      }
      
      const keywords = JSON.stringify((item.display as any)?.keywords || []).toLowerCase()
      
      // 우선순위 점수 (높을수록 먼저)
      if (name.includes(searchTerm)) return 100           // 1. 이름 매칭
      if (normalizedName.includes(normalizedSearchTerm)) return 90  // 2. 정규화 이름 매칭
      if (heroTags.includes(searchTerm)) return 70        // 3. 태그 매칭
      if (heroIntro.includes(searchTerm)) return 50       // 4. 히어로 소개 매칭
      if (categoryName.includes(searchTerm)) return 30    // 5. 카테고리 매칭
      if (keywords.includes(searchTerm)) return 10        // 6. 키워드 매칭
      return 0
    }
    
    items.sort((a, b) => {
      const scoreA = getMatchScore(a)
      const scoreB = getMatchScore(b)
      if (scoreB !== scoreA) return scoreB - scoreA
      // 점수가 같으면 이름순
      return (a.profile?.name || '').localeCompare(b.profile?.name || '', 'ko')
    })
  } else if (sort === 'salary-desc') {
    // 연봉 높은 순: salary 필드에서 숫자 추출 후 정렬
    items.sort((a, b) => {
      const getSalaryNum = (item: UnifiedJobSummaryEntry): number => {
        const sal = item.display?.salary
        if (!sal) return 0
        const match = String(sal).match(/(\d[\d,]*)만원/)
        if (match) {
          return parseInt(match[1].replace(/,/g, ''), 10) || 0
        }
        return 0
      }
      return getSalaryNum(b) - getSalaryNum(a)
    })
  }

  const jobResultSources = createInitialSourceStatus()
  jobResultSources.CAREERNET = { attempted: true, count: items.filter(i => i.profile.sources.includes('CAREERNET')).length }
  jobResultSources.GOYONG24 = { attempted: true, count: items.filter(i => i.profile.sources.includes('GOYONG24')).length }
  
  return {
    items,
    meta: {
      total: totalCount,
      sources: jobResultSources
    }
  }
}

export const getUnifiedMajorDetail = async (
  request: MajorDetailRequest,
  env?: CareerWikiEnv
): Promise<UnifiedDetailResult<UnifiedMajorDetail>> => {
  const { id, careernetId, goyong24Params, includeSources } = request
  const sourcesToUse = resolveIncludedSources(includeSources)
  const sourcesStatus = createInitialSourceStatus()


  let careernetProfile: UnifiedMajorDetail | null = null
  let goyongProfile: UnifiedMajorDetail | null = null

  // 🆕 Step 0: Try merged_profile_json first (ETL 결과 우선 사용)
  
  // ID가 G23_, C23_ 등으로 시작하면 실제 DB ID로 간주
  const isActualDbId = id && (id.match(/^[GC]\d+_/) !== null)
  // major:xxx 형식의 ETL ID 감지
  const isEtlMajorId = id && id.startsWith('major:')
  // U_ 프리픽스 = 사용자 생성 전공
  const isUserCreatedMajor = id && id.startsWith('U_')
  const searchKey = id ? (isEtlMajorId ? id.substring(6) : id) : '' // 'major:' prefix 제거
  
  
  if (env && 'DB' in env && id) {
    try {
      const db = (env as any).DB
      
      // 🚀 PRIORITY 1: Check for ETL-merged data (merged_profile_json)
      let mergedMajorRow: any = null
      
      // 🆕 사용자 생성 전공 (U_ prefix) 우선 조회
      if (isUserCreatedMajor) {
        mergedMajorRow = await db.prepare(`
          SELECT id, name, slug, merged_profile_json, careernet_id, goyong24_id,
                 user_contributed_json, admin_data_json, image_url, image_alt
          FROM majors 
          WHERE id = ? AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
          LIMIT 1
        `).bind(id).first()
      }
      
      if (!isActualDbId && !mergedMajorRow) {
        // Try by ETL ID directly
        if (isEtlMajorId) {
          mergedMajorRow = await db.prepare(`
            SELECT id, name, slug, merged_profile_json, careernet_id, goyong24_id,
                   user_contributed_json, admin_data_json, image_url, image_alt
            FROM majors 
            WHERE id = ? AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
            LIMIT 1
          `).bind(id).first()
        }
        
        // Try by slug
        if (!mergedMajorRow && !searchKey.match(/^\d+$/)) {
          mergedMajorRow = await db.prepare(`
            SELECT id, name, slug, merged_profile_json, careernet_id, goyong24_id,
                   user_contributed_json, admin_data_json, image_url, image_alt
            FROM majors 
            WHERE slug = ? AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
            LIMIT 1
          `).bind(searchKey).first()
        }
        
        // Try by name
        if (!mergedMajorRow) {
          mergedMajorRow = await db.prepare(`
            SELECT id, name, slug, merged_profile_json, careernet_id, goyong24_id,
                   user_contributed_json, admin_data_json, image_url, image_alt
            FROM majors 
            WHERE name = ? AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
            LIMIT 1
          `).bind(searchKey).first()
        }
      }
      
      // ✅ ETL 병합 데이터가 있으면 바로 사용!
      if (mergedMajorRow && mergedMajorRow.merged_profile_json) {
        
        try {
          let merged = JSON.parse(mergedMajorRow.merged_profile_json) as UnifiedMajorDetail
          
          // 🆕 DB의 name 필드가 있으면 반드시 사용 (merged_profile_json에 없을 수 있음)
          if (mergedMajorRow.name && !merged.name) {
            merged.name = mergedMajorRow.name
          }
          
          // user_contributed_json과 admin_data_json 병합
          let userData = {}
          let adminData = {}
          
          try {
            if (mergedMajorRow.user_contributed_json) {
              userData = JSON.parse(mergedMajorRow.user_contributed_json as string)
            }
          } catch (error) {
          }
          
          try {
            if (mergedMajorRow.admin_data_json) {
              adminData = JSON.parse(mergedMajorRow.admin_data_json as string)
            }
          } catch (error) {
          }
          
          // 병합 적용 (admin > user > merged 우선순위) - 깊은 병합 사용
          merged = deepMergeProfile(deepMergeProfile(merged, userData), adminData) as UnifiedMajorDetail
          
          // 🆕 DB에서 직접 조회한 image_url, image_alt 추가
          if (mergedMajorRow.image_url) {
            (merged as any).image_url = mergedMajorRow.image_url
          }
          if (mergedMajorRow.image_alt) {
            (merged as any).image_alt = mergedMajorRow.image_alt
          }
          
          // U_ 전공: overview.summary가 없으면 summary를 개요용으로 복사
          if (isUserCreatedMajor) {
            const overviewSummary = (merged as any)?.overview?.summary
            if (!overviewSummary && merged.summary) {
              merged.overview = merged.overview || {}
              merged.overview.summary = merged.summary
            }
            
            // 태그형 교과목 데이터를 템플릿에서 호환되도록 객체 배열로 변환
            const toSubjectObjects = (arr: any) => {
              if (!Array.isArray(arr)) return arr
              return arr.map((item: any) => {
                if (typeof item === 'string') return { subject_name: item }
                return item
              })
            }
            if (Array.isArray((merged as any).mainSubject) && (merged as any).mainSubject.every((i: any) => typeof i === 'string')) {
              (merged as any).mainSubject = toSubjectObjects((merged as any).mainSubject)
            }
            if (Array.isArray((merged as any).relateSubject) && (merged as any).relateSubject.every((i: any) => typeof i === 'string')) {
              (merged as any).relateSubject = toSubjectObjects((merged as any).relateSubject)
            }
          }
          
          sourcesStatus.CAREERNET.attempted = !!mergedMajorRow.careernet_id
          sourcesStatus.CAREERNET.count = mergedMajorRow.careernet_id ? 1 : 0
          sourcesStatus.GOYONG24.attempted = !!mergedMajorRow.goyong24_id
          sourcesStatus.GOYONG24.count = mergedMajorRow.goyong24_id ? 1 : 0
          
          const partialsRecord = derivePartialsFromMergedProfile(merged)

          const careernetStatus = ensureSourceStatus(sourcesStatus, 'CAREERNET')
          if (partialsRecord.CAREERNET) {
            careernetStatus.attempted = true
            careernetStatus.count = (careernetStatus.count ?? 0) + 1
            delete careernetStatus.skippedReason
          } else {
            careernetStatus.skippedReason = careernetStatus.skippedReason ?? 'not-in-source-data'
          }

          const goyongStatus = ensureSourceStatus(sourcesStatus, 'GOYONG24')
          if (partialsRecord.GOYONG24) {
            goyongStatus.attempted = true
            goyongStatus.count = (goyongStatus.count ?? 0) + 1
            delete goyongStatus.skippedReason
          } else {
            goyongStatus.skippedReason = goyongStatus.skippedReason ?? 'not-in-source-data'
          }

          return {
            profile: merged,
            partials: partialsRecord,
            sources: sourcesStatus
          }
        } catch (error) {
          // Fallback to old logic below
        }
      }
      
      // 📦 FALLBACK: Old logic (api_data_json 사용)
      
      // ID가 실제 DB ID인 경우 직접 조회
      if (isActualDbId) {
        const directResult = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json, user_contributed_json, admin_data_json 
          FROM majors 
          WHERE id = ? AND is_active = 1
        `).bind(id).all()
        
        if (directResult.results && directResult.results.length > 0) {
          const allMajorRows = directResult
          
          // 아래의 병합 로직으로 이동
          if (allMajorRows.results && allMajorRows.results.length > 0) {
            
            // 병합 로직 처리 (아래에서 계속)
            for (const row of allMajorRows.results) {
              if (row.api_data_json) {
                try {
                  const apiData = JSON.parse(row.api_data_json)
                  
                  if (row.careernet_id && row.careernet_id !== 'null' && sourcesToUse.includes('CAREERNET') && !careernetProfile) {
                    const careernetData = apiData.careernet
                    if (careernetData && careernetData !== null && typeof careernetData === 'object') {
                      const parsedData = { ...careernetData }
                      const fieldsToCheck = ['mainSubject', 'relateSubject', 'careerAct', 'enterField']
                      for (const field of fieldsToCheck) {
                        if (parsedData[field] && typeof parsedData[field] === 'string') {
                          try {
                            parsedData[field] = JSON.parse(parsedData[field])
                          } catch (e) {}
                        }
                      }
                      
                      careernetProfile = {
                        id: `major:C_${row.careernet_id}`,
                        sourceIds: { careernet: row.careernet_id },
                        name: row.name,
                        ...parsedData,
                        sources: ['CAREERNET']
                      }
                      
                      const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
                      status.attempted = true
                      status.count = 1
                      
                      if (apiData?.rawCareernet) {
                        if (!sourcesStatus.rawPartials) sourcesStatus.rawPartials = {}
                        sourcesStatus.rawPartials.CAREERNET = apiData.rawCareernet
                      }
                    }
                  }
                  
                  if (row.goyong24_id && row.goyong24_id !== 'null' && sourcesToUse.includes('GOYONG24') && !goyongProfile) {
                    const goyong24Data = apiData.goyong24
                    if (goyong24Data && goyong24Data !== null && typeof goyong24Data === 'object') {
                      const parsedData = { ...goyong24Data }
                      const fieldsToCheck = ['mainSubject', 'relateSubject', 'careerAct', 'enterField', 'main_subject', 'relate_subject', 'career_act', 'enter_field']
                      for (const field of fieldsToCheck) {
                        if (parsedData[field] && typeof parsedData[field] === 'string') {
                          try {
                            parsedData[field] = JSON.parse(parsedData[field])
                          } catch (e) {}
                        }
                      }
                      
                      goyongProfile = {
                        id: `major:G_${row.goyong24_id}`,
                        sourceIds: { goyong24: row.goyong24_id },
                        name: row.name,
                        ...parsedData,
                        sources: ['GOYONG24']
                      }
                      
                      const status = ensureSourceStatus(sourcesStatus, 'GOYONG24')
                      status.attempted = true
                      status.count = 1
                      
                      if (apiData?.rawGoyong24) {
                        if (!sourcesStatus.rawPartials) sourcesStatus.rawPartials = {}
                        sourcesStatus.rawPartials.GOYONG24 = apiData.rawGoyong24
                      }
                    }
                  }
                  
                  if (careernetProfile && goyongProfile) break
                } catch (error) {
                  console.error('[profileData] source row parse failed:', error)
                }
              }
            }
            
            if (careernetProfile || goyongProfile) {
              let enhancedProfile = mergeMajorProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)
              const partialsRecord = { CAREERNET: careernetProfile, GOYONG24: goyongProfile }
              
              const firstRow = allMajorRows.results[0]
              let userData = {}
              let adminData = {}
              
              try {
                if (firstRow.user_contributed_json) {
                  userData = JSON.parse(firstRow.user_contributed_json as string)
                }
              } catch (error) {
              }
              
              try {
                if (firstRow.admin_data_json) {
                  adminData = JSON.parse(firstRow.admin_data_json as string)
                }
              } catch (error) {
              }
              
              enhancedProfile = deepMergeProfile(deepMergeProfile(enhancedProfile, userData), adminData) as UnifiedMajorDetail
              
              return {
                profile: enhancedProfile,
                partials: partialsRecord,
                sources: sourcesStatus,
                rawPartials: sourcesStatus.rawPartials
              }
            }
          }
        } else {
        }
      }
      
      // 🔄 전공명 정규화 함수 (목록 페이지와 동일)
      const normalizeMajorNameForSearch = (name: string): string => {
        let normalized = name
          .trim()
          .toLowerCase()
          // 🔧 URL slug의 하이픈을 공백으로 변환
          .replace(/-/g, ' ')
          .replace(/\s*및\s*/g, ',')
          .replace(/[·•]/g, ',')
          .replace(/\s*,\s*/g, ',')
          .replace(/\s+/g, ' ')
          .trim()
          .replace(/\s*(학과|학부|전공)$/g, '')
          .replace(/\s*과$/g, '')
          .replace(/\s+/g, '')
        return normalized
      }
      
      const normalizedSearchName = normalizeMajorNameForSearch(searchKey)
      
      // Try finding by name (Korean slug) in D1
      // ✅ 정규화된 이름으로도 검색하여 병합된 전공 찾기
      // 1. 정확히 일치하는 것 먼저 검색 (user_contributed_json, admin_data_json 포함)
      let allMajorRows = await db.prepare(`
        SELECT id, name, careernet_id, goyong24_id, api_data_json, user_contributed_json, admin_data_json 
        FROM majors 
        WHERE LOWER(name) = LOWER(?)
      `).bind(searchKey).all()

      // 2. 정확히 일치하는 것이 없으면 정규화된 이름으로 검색
      if (!allMajorRows.results || allMajorRows.results.length === 0) {
        // 모든 전공을 가져와서 정규화된 이름으로 필터링
        const allMajors = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json, user_contributed_json, admin_data_json 
          FROM majors
        `).all()
        
        if (allMajors.results) {
          const matchingRows = allMajors.results.filter((row: any) => {
            const normalizedRowName = normalizeMajorNameForSearch(row.name || '')
            return normalizedRowName === normalizedSearchName
          })
          allMajorRows = { results: matchingRows }
        }
      }
      
      if (allMajorRows.results && allMajorRows.results.length > 0) {
        
        // 🆕 여러 레코드가 있으면 모두 병합 (커리어넷 + 고용24)
        for (const row of allMajorRows.results) {
          if (row.api_data_json) {
            try {
              const apiData = JSON.parse(row.api_data_json)
              
              // careernet 데이터 수집 (레코드에 careernet_id가 있고 apiData.careernet이 null이 아닌 경우)
              // ⚠️ 'null' 문자열도 체크 (SQLite가 null을 문자열로 저장할 수 있음)
              if (row.careernet_id && row.careernet_id !== 'null' && sourcesToUse.includes('CAREERNET') && !careernetProfile) {
                const careernetData = apiData.careernet
                
                // null이 아니고 실제 데이터가 있는 경우만 처리
                if (careernetData && careernetData !== null && typeof careernetData === 'object') {
                  // 🔧 이중 인코딩된 JSON 문자열 필드 파싱
                  const parsedData = { ...careernetData }
                  const fieldsToCheck = ['mainSubject', 'relateSubject', 'careerAct', 'enterField']
                  for (const field of fieldsToCheck) {
                    if (parsedData[field] && typeof parsedData[field] === 'string') {
                      try {
                        parsedData[field] = JSON.parse(parsedData[field])
                      } catch (e) {
                        // 파싱 실패 시 원본 유지
                      }
                    }
                  }
                  
                const newCareernetProfile: UnifiedMajorDetail = {
                  id: `major:C_${row.careernet_id}`,
                  sourceIds: { careernet: row.careernet_id },
                  name: row.name,
                  ...parsedData,
                  sources: ['CAREERNET']
                }
                
                // 🔧 D1 데이터에 department가 없으면 rawCareernet.universityList에서 보완
                if (newCareernetProfile.universities && apiData?.rawCareernet?.universityList) {
                  newCareernetProfile.universities = newCareernetProfile.universities.map(uni => {
                    if (uni.department) return uni // 이미 있으면 그대로
                    
                    // rawCareernet.universityList에서 같은 대학 찾기
                    const rawUni = apiData.rawCareernet.universityList.find(
                      (raw: any) => raw.schoolName?.trim().toLowerCase() === uni.name?.trim().toLowerCase()
                    )
                    
                    if (rawUni?.majorName) {
                      return { ...uni, department: rawUni.majorName }
                    }
                    return uni
                  })
                }
                
                careernetProfile = newCareernetProfile
                
                const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
                status.attempted = true
                status.count = 1
                
                // rawPartials에 원본 데이터 저장
                if (apiData?.rawCareernet) {
                  if (!sourcesStatus.rawPartials) sourcesStatus.rawPartials = {}
                  sourcesStatus.rawPartials.CAREERNET = apiData.rawCareernet
                }
                }
              }
              
              // goyong24 데이터 수집 (레코드에 goyong24_id가 있고 apiData.goyong24가 null이 아닌 경우)
              // ⚠️ 'null' 문자열도 체크 (SQLite가 null을 문자열로 저장할 수 있음)
              if (row.goyong24_id && row.goyong24_id !== 'null' && sourcesToUse.includes('GOYONG24') && !goyongProfile) {
                const goyong24Data = apiData.goyong24
                
                // null이 아니고 실제 데이터가 있는 경우만 처리
                if (goyong24Data && goyong24Data !== null && typeof goyong24Data === 'object') {
                  // 🔧 이중 인코딩된 JSON 문자열 필드 파싱
                  const parsedData = { ...goyong24Data }
                  const fieldsToCheck = ['mainSubject', 'relateSubject', 'careerAct', 'enterField', 'main_subject', 'relate_subject', 'career_act', 'enter_field']
                  for (const field of fieldsToCheck) {
                    if (parsedData[field] && typeof parsedData[field] === 'string') {
                      try {
                        parsedData[field] = JSON.parse(parsedData[field])
                      } catch (e) {
                        // 파싱 실패 시 원본 유지
                      }
                    }
                  }
                  
                  goyongProfile = {
                    id: row.goyong24_id,
                    sourceIds: { goyong24: row.goyong24_id },
                    name: row.name,
                    ...parsedData,
                    sources: ['GOYONG24']
                  }
                  const status = ensureSourceStatus(sourcesStatus, 'GOYONG24')
                  status.attempted = true
                  status.count = 1
                  
                  // rawPartials에 원본 데이터 저장
                  if (apiData?.rawGoyong24) {
                    if (!sourcesStatus.rawPartials) sourcesStatus.rawPartials = {}
                    sourcesStatus.rawPartials.GOYONG24 = apiData.rawGoyong24
                  }
                }
              }
              
              // 양쪽 데이터를 모두 찾았으면 중단
              if (careernetProfile && goyongProfile) {
                break
              }
            } catch (error) {
            }
          }
        }
        
        // If we found data in D1, skip API calls and merge
        if (careernetProfile || goyongProfile) {
          const mergedResult = mergeMajorProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)
          
          // merged가 null이면 빈 객체로 초기화
          const merged: UnifiedMajorDetail = mergedResult ?? {
            id: id,
            sourceIds: {},
            name: id,
            sources: []
          }
          
          // 🔧 병합된 데이터에서도 이중 인코딩된 필드 파싱 (병합 과정에서 문자열이 남아있을 수 있음)
          const fieldsToCheck = ['mainSubject', 'relateSubject', 'careerAct', 'enterField', 'main_subject', 'relate_subject', 'career_act', 'enter_field']
          for (const field of fieldsToCheck) {
            if ((merged as any)[field] && typeof (merged as any)[field] === 'string') {
              try {
                (merged as any)[field] = JSON.parse((merged as any)[field])
              } catch (e) {
                // 파싱 실패 시 원본 유지
              }
            }
          }
          
          // 🔧 검색한 이름(id)과 정확히 일치하거나 정규화 후 일치하는 레코드의 name 우선 사용
          // 목록 페이지에서 병합된 이름과 URL slug가 다를 수 있으므로, 검색한 이름과 일치하는 것을 찾음
          // 1. 정확히 일치하는 것 먼저 찾기
          let matchingRow = allMajorRows.results.find((row: any) =>
            row.name && row.name.trim().toLowerCase() === searchKey.toLowerCase()
          )
          
          // 2. 정확히 일치하는 것이 없으면 정규화된 이름으로 찾기
          if (!matchingRow) {
            matchingRow = allMajorRows.results.find((row: any) => 
              row.name && normalizeMajorNameForSearch(row.name) === normalizedSearchName
            )
          }
          
          if (matchingRow && matchingRow.name) {
            // 검색한 이름과 일치하는 레코드의 이름 사용
            merged.name = matchingRow.name.trim()
          } else if (!merged.name || !merged.name.trim()) {
            // 일치하는 것이 없으면 첫 번째 레코드의 name 사용
            if (allMajorRows.results[0].name && allMajorRows.results[0].name.trim()) {
              merged.name = allMajorRows.results[0].name.trim()
            }
          }
          
          const partialsRecord = {
            CAREERNET: careernetProfile,
            GOYONG24: goyongProfile
          }
          
          // user_contributed_json과 admin_data_json 병합 (직업 페이지와 동일)
          // 첫 번째 레코드에서 가져오기 (모든 레코드가 같은 병합 데이터를 공유)
          const firstRow = allMajorRows.results[0]
          let userData = {}
          let adminData = {}
          
          try {
            if (firstRow.user_contributed_json) {
              userData = JSON.parse(firstRow.user_contributed_json as string)
            }
          } catch (error) {
          }
          
          try {
            if (firstRow.admin_data_json) {
              adminData = JSON.parse(firstRow.admin_data_json as string)
            }
          } catch (error) {
          }
          
          // 병합 적용 (admin > user > api 우선순위) - 깊은 병합 사용
          const enhancedProfile = deepMergeProfile(deepMergeProfile(merged, userData), adminData) as UnifiedMajorDetail
          
          return {
            profile: enhancedProfile,
            partials: partialsRecord,
            sources: sourcesStatus,
            rawPartials: sourcesStatus.rawPartials
          }
        }
      }
    } catch (d1Error) {
      // 네트워크 연결 에러는 조용히 처리 (로컬 개발 환경에서 D1이 시작되지 않았을 때)
      if (d1Error instanceof Error && (d1Error.message.includes('fetch failed') || d1Error.message.includes('ECONNREFUSED') || d1Error.message.includes('ECONNRESET'))) {
        // 조용히 API fallback으로 진행
      } else {
        // 다른 에러는 로그 남김
      }
      // Continue to API fallback
    }
  }

  // CareerNet detail (fallback if D1 didn't return data)
  if (sourcesToUse.includes('CAREERNET')) {
    const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
    const resolvedCareernetId =
      careernetId ||
      (id ? extractCanonicalSuffix(id, 'major:C_') : undefined) ||
      (id && !id.includes(':') ? id : undefined)

    if (!resolvedCareernetId) {
      status.skippedReason = 'missing-id'
    } else if (!careernetProfile) {  // Only fetch if D1 didn't provide data
      status.attempted = true
      try {
        const raw = await fetchCareerNetMajorDetail(resolvedCareernetId, env)
        if (raw) {
          // 원본 API 응답 전체를 보존 (모든 필드 포함)
          // normalizeCareerNetMajorDetail은 표시용으로만 사용
          careernetProfile = normalizeCareerNetMajorDetail(raw)
          // 원본 raw 데이터는 rawPartials에 저장 (모든 필드 보존)
          if (!sourcesStatus.rawPartials) sourcesStatus.rawPartials = {}
          sourcesStatus.rawPartials.CAREERNET = raw
          status.count = 1
        } else {
          status.error = 'CareerNet 학과 정보를 찾을 수 없습니다.'
        }
      } catch (error) {
        status.error = error instanceof Error ? error.message : 'CareerNet 학과 상세 조회 실패'
      }
    }
  } else {
    sourcesStatus.CAREERNET.skippedReason = 'excluded'
  }

  // Goyong24 detail
  if (sourcesToUse.includes('GOYONG24')) {
    const status = ensureSourceStatus(sourcesStatus, 'GOYONG24')
    const params: Goyong24MajorDetailParams | undefined = goyong24Params
      ? {
          majorGb: goyong24Params.majorGb,
          empCurtState1Id: goyong24Params.departmentId,
          empCurtState2Id: goyong24Params.majorId
        }
      : undefined

    if (!params) {
      status.skippedReason = 'missing-params'
    } else {
      status.attempted = true
      try {
        const raw = await fetchGoyong24MajorDetail(params, env as any)
        // 원본 파싱된 데이터를 보존 (모든 필드 포함)
        // normalizeGoyong24MajorDetail은 표시용으로만 사용
        goyongProfile = normalizeGoyong24MajorDetail(raw)
        // 원본 raw 데이터는 rawPartials에 저장 (모든 필드 보존)
        if (!sourcesStatus.rawPartials) sourcesStatus.rawPartials = {}
        sourcesStatus.rawPartials.GOYONG24 = raw
        status.count = 1
      } catch (error) {
        status.error = error instanceof Error ? error.message : '고용24 학과 상세 조회 실패'
      }
    }
  } else {
    sourcesStatus.GOYONG24.skippedReason = 'excluded'
  }

  let merged = mergeMajorProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)

  // 🆕 API 호출 후에도 DB에서 user_contributed_json과 admin_data_json 병합 (직업 페이지와 동일)
  if (env && 'DB' in env && id) {
    try {
      const db = (env as any).DB
      
      
      // 실제 DB ID로 변환
      let dbMajorId = id
      let dbMajor = await db.prepare('SELECT id, user_contributed_json, admin_data_json FROM majors WHERE id = ? AND is_active = 1')
        .bind(dbMajorId)
        .first() as { id: string; user_contributed_json: string | null; admin_data_json: string | null } | null
      
      // ID로 찾지 못한 경우 복합 ID 형식 처리
      if (!dbMajor && id.includes(':')) {
        const parts = id.split(':')
        if (parts.length > 1) {
          let extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          
          dbMajor = await db.prepare('SELECT id, user_contributed_json, admin_data_json FROM majors WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first() as { id: string; user_contributed_json: string | null; admin_data_json: string | null } | null
          
          if (dbMajor) {
            dbMajorId = extractedId
          }
        }
      }
      
      // 여전히 찾지 못한 경우 slug로 시도
      if (!dbMajor && !id.includes(':')) {
        const decodedSlug = decodeURIComponent(id)
        const normalizedSlug = decodedSlug.toLowerCase()
        dbMajor = await db.prepare(`
          SELECT id, user_contributed_json, admin_data_json 
          FROM majors 
          WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? 
          AND is_active = 1 
          LIMIT 1
        `).bind(normalizedSlug).first() as { id: string; user_contributed_json: string | null; admin_data_json: string | null } | null
        
        if (dbMajor) {
          dbMajorId = dbMajor.id
        }
      }
      
      if (dbMajor) {
        
        let userData = {}
        let adminData = {}
        
        try {
          if (dbMajor.user_contributed_json) {
            userData = JSON.parse(dbMajor.user_contributed_json)
          }
        } catch (error) {
        }
        
        try {
          if (dbMajor.admin_data_json) {
            adminData = JSON.parse(dbMajor.admin_data_json)
          }
        } catch (error) {
        }
        
        // 병합 적용 (admin > user > api 우선순위) - 깊은 병합 사용
        merged = deepMergeProfile(deepMergeProfile(merged, userData), adminData) as UnifiedMajorDetail
        
      } else {
      }
    } catch (dbError) {
    }
  }

  return {
    profile: merged,
    partials: {
      CAREERNET: careernetProfile,
      GOYONG24: goyongProfile
    },
    sources: sourcesStatus,
    // 원본 API 응답 데이터 (모든 필드 보존)
    rawPartials: sourcesStatus.rawPartials
  }
}

export const getUnifiedJobDetail = async (
  request: JobDetailRequest,
  env?: CareerWikiEnv
): Promise<UnifiedDetailResult<UnifiedJobDetail>> => {
  const { id, careernetId, goyong24JobId, includeSources } = request
  const sourcesToUse = resolveIncludedSources(includeSources)
  const sourcesStatus = createInitialSourceStatus()
  const overrides = resolveJobSourceOverride(request)
  const explicitCareernetId = careernetId?.trim() || undefined
  const explicitGoyongId = goyong24JobId?.trim() || undefined
  const hasExplicitSourceId = !!(explicitCareernetId || explicitGoyongId)

  let careernetProfile: UnifiedJobDetail | null = null
  let goyongProfile: UnifiedJobDetail | null = null

  // 🚀 PRIORITY 1: Check for ETL-merged data (merged_profile_json)
  if (env && 'DB' in env && id && !hasExplicitSourceId) {
    try {
      const db = (env as any).DB
      
      let mergedJobRow: any = null
      
      
      // Try by ID first (most reliable for numeric IDs)
      if (id.match(/^\d+$/)) {
        mergedJobRow = await db.prepare(`
          SELECT id, name, slug, merged_profile_json,
                 user_contributed_json, admin_data_json,
                 image_url, image_alt
          FROM jobs 
          WHERE id = ? AND is_active = 1 AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
          LIMIT 1
        `).bind(id).first()
        if (mergedJobRow) {
        }
      }
      
      // Try by slug
      if (!mergedJobRow && !id.includes(':') && !id.match(/^\d+$/)) {
        mergedJobRow = await db.prepare(`
          SELECT id, name, slug, merged_profile_json,
                 user_contributed_json, admin_data_json,
                 image_url, image_alt
          FROM jobs 
          WHERE slug = ? AND is_active = 1 AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
          LIMIT 1
        `).bind(id).first()
        if (mergedJobRow) {
        }
      }
      
      if (!mergedJobRow) {
      }
      
      // Try by name
      if (!mergedJobRow && !id.includes(':')) {
        mergedJobRow = await db.prepare(`
          SELECT id, name, slug, merged_profile_json,
                 user_contributed_json, admin_data_json,
                 image_url, image_alt
          FROM jobs 
          WHERE name = ? AND is_active = 1 AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
          LIMIT 1
        `).bind(id).first()
      }
      
      // ✅ ETL 병합 데이터가 있으면 바로 사용!
      if (mergedJobRow && mergedJobRow.merged_profile_json) {
        
        try {
          let merged = JSON.parse(mergedJobRow.merged_profile_json) as UnifiedJobDetail
          
          // 🆕 DB의 name 필드가 있으면 반드시 사용
          if (mergedJobRow.name && !merged.name) {
            merged.name = mergedJobRow.name
          }
          
          // user_contributed_json과 admin_data_json 병합
          let userData = {}
          let adminData = {}
          
          try {
            if (mergedJobRow.user_contributed_json) {
              userData = JSON.parse(mergedJobRow.user_contributed_json as string)
            }
          } catch (error) {
          }
          
          try {
            if (mergedJobRow.admin_data_json) {
              adminData = JSON.parse(mergedJobRow.admin_data_json as string)
            }
          } catch (error) {
          }
          
          // 병합 적용 (admin > user > merged 우선순위) - 깊은 병합 사용
          merged = deepMergeProfile(deepMergeProfile(merged, userData), adminData) as UnifiedJobDetail
          
          // 🖼️ DB에서 직접 가져온 필드 추가 (이미지, slug)
          if (mergedJobRow.slug) {
            (merged as any).slug = mergedJobRow.slug
          }
          if (mergedJobRow.image_url && mergedJobRow.image_url !== 'null') {
            (merged as any).image_url = mergedJobRow.image_url
          }
          if (mergedJobRow.image_alt && mergedJobRow.image_alt !== 'null') {
            (merged as any).image_alt = mergedJobRow.image_alt
          }
          
          return {
            profile: merged,
            partials: {},
            sources: sourcesStatus
          }
        } catch (error) {
          // Fallback to old logic below
        }
      }
      
    } catch (error) {
      // Fallback to old logic below
    }
  }

  // 📦 FALLBACK: API 호출 로직
  // CareerNet detail
  if (sourcesToUse.includes('CAREERNET')) {
    const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
    const resolvedCareernetId =
      overrides?.careernetId ??
      explicitCareernetId ??
      (id ? extractCanonicalSuffix(id, 'job:C_') : undefined) ??
      (id && !id.includes(':') ? id : undefined)

    if (!resolvedCareernetId) {
      status.skippedReason = 'missing-id'
    } else {
      status.attempted = true
      try {
        const raw = await fetchCareerNetJobDetail(resolvedCareernetId, env)
        if (raw) {
          careernetProfile = normalizeCareerNetJobDetail(raw)
          status.count = 1
        } else {
          status.error = 'CareerNet 직업 정보를 찾을 수 없습니다.'
        }
      } catch (error) {
        status.error = error instanceof Error ? error.message : 'CareerNet 직업 상세 조회 실패'
      }
    }
  } else {
    sourcesStatus.CAREERNET.skippedReason = 'excluded'
  }

  // Goyong24 detail
  if (sourcesToUse.includes('GOYONG24')) {
    const status = ensureSourceStatus(sourcesStatus, 'GOYONG24')
    const resolvedJobIdRaw =
      overrides?.goyong24JobId ??
      explicitGoyongId ??
      (id ? extractCanonicalSuffix(id, 'job:G_') : undefined)
    const resolvedJobId = resolvedJobIdRaw ? resolvedJobIdRaw.toUpperCase() : undefined

    if (!resolvedJobId) {
      status.skippedReason = 'missing-id'
    } else {
      status.attempted = true
      try {
        const raw = await fetchGoyong24JobDetail(resolvedJobId, env as any)
        goyongProfile = normalizeGoyong24JobDetail(raw)
        status.count = 1
      } catch (error) {
        status.error = error instanceof Error ? error.message : '고용24 직업 상세 조회 실패'
      }
    }
  } else {
    sourcesStatus.GOYONG24.skippedReason = 'excluded'
  }

  const merged = mergeJobProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)

  const partialsRecord: Partial<Record<DataSource, UnifiedJobDetail | null>> = {
    CAREERNET: careernetProfile,
    GOYONG24: goyongProfile
  }

  const enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)

  return {
    profile: enhancedProfile,
    partials: partialsRecord,
    sources: sourcesStatus
  }
}

export const getUnifiedJobDetailWithRawData = async (
  request: JobDetailRequest,
  env?: CareerWikiEnv
): Promise<UnifiedDetailResult<UnifiedJobDetail> & { rawApiData?: { careernet?: any; goyong24?: any } }> => {
  const { id, careernetId, goyong24JobId, includeSources } = request
  const sourcesToUse = resolveIncludedSources(includeSources)
  const sourcesStatus = createInitialSourceStatus()
  const overrides = resolveJobSourceOverride(request)
  const explicitCareernetId = careernetId?.trim() || undefined
  const explicitGoyongId = goyong24JobId?.trim() || undefined

  let careernetProfile: UnifiedJobDetail | null = null
  let goyongProfile: UnifiedJobDetail | null = null
  let rawCareernetData: any = null
  let rawGoyong24Data: any = null

  // 🆕 Step 0: Try merged_profile_json first (ETL 결과 우선 사용)
  // ⚠️ 쿼리 파라미터가 명시적으로 있으면 D1 병합을 건너뛰고 직접 조회
  const hasExplicitSourceId = !!(explicitCareernetId || explicitGoyongId)
  
  if (env && 'DB' in env && !hasExplicitSourceId) {
    try {
      const db = (env as any).DB
      
      // 🚀 PRIORITY 1: Check for ETL-merged data (merged_profile_json)
      // 이름, slug, 또는 ID로 조회
      let mergedJobRow: any = null
      
      if (id) {
        
        // Try by ID first (most reliable for numeric IDs or user-created IDs like U_xxx)
        if (id.match(/^\d+$/) || id.startsWith('U_')) {
          mergedJobRow = await db.prepare(`
            SELECT id, name, slug, merged_profile_json, careernet_id, goyong24_id,
                   user_contributed_json, admin_data_json,
                   image_url, image_alt
            FROM jobs 
            WHERE id = ? AND is_active = 1 AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
            LIMIT 1
          `).bind(id).first()
          if (mergedJobRow) {
          }
        }
        
        // Try by slug
        if (!mergedJobRow && !id.includes(':') && !id.match(/^\d+$/)) {
          mergedJobRow = await db.prepare(`
            SELECT id, name, slug, merged_profile_json, careernet_id, goyong24_id,
                   user_contributed_json, admin_data_json,
                   image_url, image_alt
            FROM jobs 
            WHERE slug = ? AND is_active = 1 AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
            LIMIT 1
          `).bind(id).first()
          if (mergedJobRow) {
          }
        }
        
        // Try by name
        if (!mergedJobRow && !id.includes(':')) {
          mergedJobRow = await db.prepare(`
            SELECT id, name, slug, merged_profile_json, careernet_id, goyong24_id,
                   user_contributed_json, admin_data_json,
                   image_url, image_alt
            FROM jobs 
            WHERE name = ? AND is_active = 1 AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
            LIMIT 1
          `).bind(id).first()
          if (mergedJobRow) {
          }
        }
        
        if (!mergedJobRow) {
        }
      }
      
      // ✅ ETL 병합 데이터가 있으면 바로 사용!
      if (mergedJobRow && mergedJobRow.merged_profile_json) {
        
        try {
          let merged = JSON.parse(mergedJobRow.merged_profile_json) as UnifiedJobDetail
          
          // 🆕 DB의 name 필드가 있으면 반드시 사용
          if (mergedJobRow.name && !merged.name) {
            merged.name = mergedJobRow.name
          }
          
          // user_contributed_json과 admin_data_json 병합
          let userData = {}
          let adminData = {}
          
          try {
            if (mergedJobRow.user_contributed_json) {
              userData = JSON.parse(mergedJobRow.user_contributed_json as string)
            }
          } catch (error) {
          }
          
          try {
            if (mergedJobRow.admin_data_json) {
              adminData = JSON.parse(mergedJobRow.admin_data_json as string)
            }
          } catch (error) {
          }
          
          // 병합 적용 (admin > user > merged 우선순위) - 깊은 병합 사용
          merged = deepMergeProfile(deepMergeProfile(merged, userData), adminData) as UnifiedJobDetail
          
          // rawApiData는 job_sources에서 가져오기 (디버그/편집용)
          let rawCareernetData: any = null
          let rawGoyong24Data: any = null
          
          if (mergedJobRow.careernet_id || mergedJobRow.goyong24_id) {
            try {
              const sources = await db.prepare(`
                SELECT source_system, raw_payload
                FROM job_sources
                WHERE job_id = ?
              `).bind(mergedJobRow.id).all()
              
              for (const source of sources.results || []) {
                const rawPayload = JSON.parse(source.raw_payload || '{}')
                if (source.source_system === 'CAREERNET') {
                  rawCareernetData = rawPayload
                } else if (source.source_system === 'WORK24_JOB' || source.source_system === 'WORK24_DJOB') {
                  rawGoyong24Data = rawPayload
                }
              }
            } catch (error) {
            }
          }
          
          sourcesStatus.CAREERNET.attempted = !!mergedJobRow.careernet_id
          sourcesStatus.CAREERNET.count = mergedJobRow.careernet_id ? 1 : 0
          sourcesStatus.GOYONG24.attempted = !!mergedJobRow.goyong24_id
          sourcesStatus.GOYONG24.count = mergedJobRow.goyong24_id ? 1 : 0
          
          // 🖼️ DB에서 직접 가져온 필드 추가 (slug, 이미지)
          if (mergedJobRow.slug) {
            (merged as any).slug = mergedJobRow.slug
          }
          if (mergedJobRow.image_url && mergedJobRow.image_url !== 'null') {
            (merged as any).image_url = mergedJobRow.image_url
          }
          if (mergedJobRow.image_alt && mergedJobRow.image_alt !== 'null') {
            (merged as any).image_alt = mergedJobRow.image_alt
          }
          
          return {
            profile: merged,
            partials: {},
            sources: sourcesStatus,
            rawApiData: {
              careernet: rawCareernetData,
              goyong24: rawGoyong24Data
            }
          }
        } catch (error) {
          // Fallback to old logic below
        }
      }
      
      // 📦 FALLBACK: Old logic (api_data_json 사용)
      
      // Extract potential careernet ID from canonical ID format (e.g., "job:C_354" -> "354")
      const extractedId = id ? extractCanonicalSuffix(id, 'job:C_') : undefined
      
      // Build flexible query - try multiple match strategies
      // 🆕 Strategy 3을 먼저 시도 (이름으로 검색하여 병합)
      // Strategy 3: Try by name (fetch ALL matching records for merging)
      if (id && !id.includes(':')) {
        const allJobRows = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json, user_contributed_json, admin_data_json
          FROM jobs 
          WHERE name = ?
        `).bind(id).all()
        
        
        if (allJobRows.results && allJobRows.results.length > 0) {
          // 🆕 여러 레코드가 있으면 모두 병합 (커리어넷 + 고용24)
          for (const row of allJobRows.results) {
            if (row.api_data_json) {
              try {
                const apiData = JSON.parse(row.api_data_json)
                
                // 레코드의 ID를 확인하여 어떤 소스인지 판단
                // careernet_id가 있으면 커리어넷 데이터, goyong24_id가 있으면 고용24 데이터
                
                // careernet 데이터 수집 (레코드에 careernet_id가 있고 apiData.careernet이 null이 아닌 경우)
                // ⚠️ 'null' 문자열도 체크 (SQLite가 null을 문자열로 저장할 수 있음)
                if (row.careernet_id && row.careernet_id !== 'null' && sourcesToUse.includes('CAREERNET') && !careernetProfile) {
                  // apiData 구조: { careernet: {...} 또는 null, goyong24: {...} 또는 null }
                  const careernetData = apiData.careernet
                  
                  // null이 아니고 실제 데이터가 있는 경우만 처리
                  if (careernetData && careernetData !== null && typeof careernetData === 'object') {
                    rawCareernetData = careernetData
                    careernetProfile = normalizeCareerNetJobDetail(careernetData)
                    sourcesStatus.CAREERNET.attempted = true
                    sourcesStatus.CAREERNET.count = 1
                  }
                }
                
                // goyong24 데이터 수집 (레코드에 goyong24_id가 있고 apiData.goyong24가 null이 아닌 경우)
                // ⚠️ 'null' 문자열도 체크 (SQLite가 null을 문자열로 저장할 수 있음)
                if (row.goyong24_id && row.goyong24_id !== 'null' && sourcesToUse.includes('GOYONG24') && !goyongProfile) {
                  // apiData 구조: { careernet: {...} 또는 null, goyong24: {...} 또는 null }
                  const goyong24Data = apiData.goyong24
                  
                  // null이 아니고 실제 데이터가 있는 경우만 처리
                  if (goyong24Data && goyong24Data !== null && typeof goyong24Data === 'object') {
                    rawGoyong24Data = goyong24Data
                    goyongProfile = normalizeGoyong24JobDetail(goyong24Data)
                    sourcesStatus.GOYONG24.attempted = true
                    sourcesStatus.GOYONG24.count = 1
                  }
                }
                
                // 양쪽 데이터를 모두 찾았으면 중단
                if (careernetProfile && goyongProfile) {
                  break
                }
              } catch (error) {
              }
            }
          }
          
          // If we found data in D1, skip API calls
          if (careernetProfile || goyongProfile) {
            const merged = mergeJobProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)
            const partialsRecord: Partial<Record<DataSource, UnifiedJobDetail | null>> = {
              CAREERNET: careernetProfile,
              GOYONG24: goyongProfile
            }
            let enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)
            
            // 🆕 user_contributed_json과 admin_data_json 병합 (admin > user > api 우선순위)
            // 첫 번째 레코드의 user_contributed_json과 admin_data_json 사용
            const firstRow = allJobRows.results[0]
            let userData = {}
            let adminData = {}
            
            try {
              if (firstRow.user_contributed_json) {
                userData = JSON.parse(firstRow.user_contributed_json as string)
              }
            } catch (error) {
            }
            
            try {
              if (firstRow.admin_data_json) {
                adminData = JSON.parse(firstRow.admin_data_json as string)
              }
            } catch (error) {
            }
            
            // 병합 적용 (admin > user > api 우선순위) - 깊은 병합 사용
            enhancedProfile = deepMergeProfile(deepMergeProfile(enhancedProfile, userData), adminData) as UnifiedJobDetail
            
            // 🆕 병합된 데이터의 name 사용 (mergeJobProfiles에서 이미 고용24 우선 처리됨)
            // 첫 번째 레코드의 name을 fallback으로 사용
            if (!enhancedProfile.name || !enhancedProfile.name.trim()) {
              if (firstRow.name && firstRow.name.trim()) {
                enhancedProfile.name = firstRow.name.trim()
              }
            }
            
            
            return {
              profile: enhancedProfile,
              partials: partialsRecord,
              sources: sourcesStatus,
              rawApiData: {
                careernet: rawCareernetData,
                goyong24: rawGoyong24Data
              }
            }
          }
        }
      }
      
      // 🆕 Fallback: Strategy 1 & 2 (ID로 검색 - 이름 검색에서 못 찾았을 때만)
      // Strategy 1: Try by D1 id (numeric ID from D1)
      if (!careernetProfile && !goyongProfile && id && !id.includes(':')) {
        const jobRow = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json, user_contributed_json, admin_data_json
          FROM jobs 
          WHERE id = ?
          LIMIT 1
        `).bind(id).first()
        
        if (jobRow && jobRow.api_data_json) {
          try {
            const apiData = JSON.parse(jobRow.api_data_json)
            
            // 레코드의 ID를 확인하여 어떤 소스인지 판단
            if (jobRow.careernet_id && sourcesToUse.includes('CAREERNET') && !careernetProfile) {
              const careernetData = apiData.careernet
              if (careernetData && careernetData !== null && typeof careernetData === 'object') {
                rawCareernetData = careernetData
                careernetProfile = normalizeCareerNetJobDetail(careernetData)
                sourcesStatus.CAREERNET.attempted = true
                sourcesStatus.CAREERNET.count = 1
              }
            }
            
            if (jobRow.goyong24_id && sourcesToUse.includes('GOYONG24') && !goyongProfile) {
              const goyong24Data = apiData.goyong24
              if (goyong24Data && goyong24Data !== null && typeof goyong24Data === 'object') {
                rawGoyong24Data = goyong24Data
                goyongProfile = normalizeGoyong24JobDetail(goyong24Data)
                sourcesStatus.GOYONG24.attempted = true
                sourcesStatus.GOYONG24.count = 1
              }
            }
            
            // 데이터를 찾았으면 병합하여 반환
            if (careernetProfile || goyongProfile) {
              // ID로 찾은 경우 다른 소스가 비어 있으면 동일 이름으로 추가 데이터 탐색
              if (jobRow.name && (!careernetProfile || !goyongProfile)) {
                const siblingRows = await db.prepare(`
                  SELECT id, name, careernet_id, goyong24_id, api_data_json
                  FROM jobs
                  WHERE name = ? AND id != ?
                `).bind(jobRow.name, jobRow.id).all()

                for (const sibling of siblingRows.results || []) {
                  if (!careernetProfile && sibling.careernet_id && sourcesToUse.includes('CAREERNET')) {
                    try {
                      const siblingData = JSON.parse(sibling.api_data_json || 'null')
                      const careernetData = siblingData?.careernet
                      if (careernetData && typeof careernetData === 'object') {
                        rawCareernetData = careernetData
                        careernetProfile = normalizeCareerNetJobDetail(careernetData)
                        sourcesStatus.CAREERNET.attempted = true
                        sourcesStatus.CAREERNET.count = 1
                      }
                    } catch (error) {
                    }
                  }

                  if (!goyongProfile && sibling.goyong24_id && sourcesToUse.includes('GOYONG24')) {
                    try {
                      const siblingData = JSON.parse(sibling.api_data_json || 'null')
                      const goyong24Data = siblingData?.goyong24
                      if (goyong24Data && typeof goyong24Data === 'object') {
                        rawGoyong24Data = goyong24Data
                        goyongProfile = normalizeGoyong24JobDetail(goyong24Data)
                        sourcesStatus.GOYONG24.attempted = true
                        sourcesStatus.GOYONG24.count = 1
                      }
                    } catch (error) {
                    }
                  }

                  if (careernetProfile && goyongProfile) {
                    break
                  }
                }
              }

              const merged = mergeJobProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)
              const partialsRecord: Partial<Record<DataSource, UnifiedJobDetail | null>> = {
                CAREERNET: careernetProfile,
                GOYONG24: goyongProfile
              }
              let enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)
              
              // 🆕 user_contributed_json과 admin_data_json 병합 (admin > user > api 우선순위)
              let userData = {}
              let adminData = {}
              
              try {
                if (jobRow.user_contributed_json) {
                  userData = JSON.parse(jobRow.user_contributed_json as string)
                }
              } catch (error) {
              }
              
              try {
                if (jobRow.admin_data_json) {
                  adminData = JSON.parse(jobRow.admin_data_json as string)
                }
              } catch (error) {
              }
              
              // 병합 적용 (admin > user > api 우선순위) - 깊은 병합 사용
              enhancedProfile = deepMergeProfile(deepMergeProfile(enhancedProfile, userData), adminData) as UnifiedJobDetail
              
              if (!enhancedProfile.name || !enhancedProfile.name.trim()) {
                if (jobRow.name && jobRow.name.trim()) {
                  enhancedProfile.name = jobRow.name.trim()
                }
              }
              
              return {
                profile: enhancedProfile,
                partials: partialsRecord,
                sources: sourcesStatus,
                rawApiData: {
                  careernet: rawCareernetData,
                  goyong24: rawGoyong24Data
                }
              }
            }
          } catch (parseError) {
          }
        }
      }
      
      // Strategy 2: Try by careernet_id (fallback)
      if (!careernetProfile && !goyongProfile && (explicitCareernetId || extractedId)) {
        const searchId = explicitCareernetId || extractedId
        const jobRow = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json, user_contributed_json, admin_data_json
          FROM jobs 
          WHERE careernet_id = ?
          LIMIT 1
        `).bind(searchId).first()
        
        if (jobRow && jobRow.api_data_json) {
          try {
            const apiData = JSON.parse(jobRow.api_data_json)
            
            if (jobRow.careernet_id && sourcesToUse.includes('CAREERNET') && !careernetProfile) {
              const careernetData = apiData.careernet
              if (careernetData && careernetData !== null && typeof careernetData === 'object') {
                rawCareernetData = careernetData
                careernetProfile = normalizeCareerNetJobDetail(careernetData)
                sourcesStatus.CAREERNET.attempted = true
                sourcesStatus.CAREERNET.count = 1
              }
            }
            
            // 같은 이름의 다른 레코드(고용24)도 찾아서 병합
            if (jobRow.name) {
              const otherRows = await db.prepare(`
                SELECT id, name, careernet_id, goyong24_id, api_data_json, user_contributed_json, admin_data_json
                FROM jobs 
                WHERE name = ? AND goyong24_id IS NOT NULL
              `).bind(jobRow.name).all()
              
              for (const otherRow of otherRows.results || []) {
                if (otherRow.goyong24_id && sourcesToUse.includes('GOYONG24') && !goyongProfile) {
                  try {
                    const otherApiData = JSON.parse(otherRow.api_data_json)
                    const goyong24Data = otherApiData.goyong24
                    if (goyong24Data && goyong24Data !== null && typeof goyong24Data === 'object') {
                      rawGoyong24Data = goyong24Data
                      goyongProfile = normalizeGoyong24JobDetail(goyong24Data)
                      sourcesStatus.GOYONG24.attempted = true
                      sourcesStatus.GOYONG24.count = 1
                      break
                    }
                  } catch (e) {
                  }
                }
              }
            }
            
            // 데이터를 찾았으면 병합하여 반환
            if (careernetProfile || goyongProfile) {
              // ID로 찾은 경우 다른 소스가 비어 있으면 동일 이름으로 추가 데이터 탐색
              if (jobRow.name && (!careernetProfile || !goyongProfile)) {
                const siblingRows = await db.prepare(`
                  SELECT id, name, careernet_id, goyong24_id, api_data_json
                  FROM jobs
                  WHERE name = ? AND id != ?
                `).bind(jobRow.name, jobRow.id).all()

                for (const sibling of siblingRows.results || []) {
                  if (!careernetProfile && sibling.careernet_id && sourcesToUse.includes('CAREERNET')) {
                    try {
                      const siblingData = JSON.parse(sibling.api_data_json || 'null')
                      const careernetData = siblingData?.careernet
                      if (careernetData && typeof careernetData === 'object') {
                        rawCareernetData = careernetData
                        careernetProfile = normalizeCareerNetJobDetail(careernetData)
                        sourcesStatus.CAREERNET.attempted = true
                        sourcesStatus.CAREERNET.count = 1
                      }
                    } catch (error) {
                    }
                  }

                  if (!goyongProfile && sibling.goyong24_id && sourcesToUse.includes('GOYONG24')) {
                    try {
                      const siblingData = JSON.parse(sibling.api_data_json || 'null')
                      const goyong24Data = siblingData?.goyong24
                      if (goyong24Data && typeof goyong24Data === 'object') {
                        rawGoyong24Data = goyong24Data
                        goyongProfile = normalizeGoyong24JobDetail(goyong24Data)
                        sourcesStatus.GOYONG24.attempted = true
                        sourcesStatus.GOYONG24.count = 1
                      }
                    } catch (error) {
                    }
                  }

                  if (careernetProfile && goyongProfile) {
                    break
                  }
                }
              }

              const merged = mergeJobProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)
              const partialsRecord: Partial<Record<DataSource, UnifiedJobDetail | null>> = {
                CAREERNET: careernetProfile,
                GOYONG24: goyongProfile
              }
              let enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)
              
              // 🆕 user_contributed_json과 admin_data_json 병합 (admin > user > api 우선순위)
              let userData = {}
              let adminData = {}
              
              try {
                if (jobRow.user_contributed_json) {
                  userData = JSON.parse(jobRow.user_contributed_json as string)
                }
              } catch (error) {
              }
              
              try {
                if (jobRow.admin_data_json) {
                  adminData = JSON.parse(jobRow.admin_data_json as string)
                }
              } catch (error) {
              }
              
              // 병합 적용 (admin > user > api 우선순위) - 깊은 병합 사용
              enhancedProfile = deepMergeProfile(deepMergeProfile(enhancedProfile, userData), adminData) as UnifiedJobDetail
              
              if (!enhancedProfile.name || !enhancedProfile.name.trim()) {
                if (jobRow.name && jobRow.name.trim()) {
                  enhancedProfile.name = jobRow.name.trim()
                }
              }
              
              return {
                profile: enhancedProfile,
                partials: partialsRecord,
                sources: sourcesStatus,
                rawApiData: {
                  careernet: rawCareernetData,
                  goyong24: rawGoyong24Data
                }
              }
            }
          } catch (parseError) {
          }
        }
      }
    } catch (dbError) {
      // 네트워크 연결 에러는 조용히 처리 (로컬 개발 환경에서 D1이 시작되지 않았을 때)
      if (dbError instanceof Error && (dbError.message.includes('fetch failed') || dbError.message.includes('ECONNREFUSED') || dbError.message.includes('ECONNRESET'))) {
        // 조용히 API fallback으로 진행
      } else {
        // 다른 에러는 로그 남김
      }
      // Continue to API fallback
    }
  } else if (hasExplicitSourceId) {
  }

  // Step 2: Fallback to API calls if D1 doesn't have the data (or explicit source ID provided)
  // CareerNet detail
  // ⚠️ 명시적으로 goyongJobId만 지정되었으면 CareerNet 건너뛰기
  if (!careernetProfile && sourcesToUse.includes('CAREERNET') && !(explicitGoyongId && !explicitCareernetId)) {
    const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
    const resolvedCareernetId =
      overrides?.careernetId ??
      explicitCareernetId ??
      (id ? extractCanonicalSuffix(id, 'job:C_') : undefined) ??
      (id && !id.includes(':') ? id : undefined)

    if (!resolvedCareernetId) {
      status.skippedReason = 'missing-id'
    } else {
      status.attempted = true
      try {
        const raw = await fetchCareerNetJobDetail(resolvedCareernetId, env)
        rawCareernetData = raw
        if (raw) {
          careernetProfile = normalizeCareerNetJobDetail(raw)
          status.count = 1
        } else {
          status.error = 'CareerNet 직업 정보를 찾을 수 없습니다.'
        }
      } catch (error) {
        status.error = error instanceof Error ? error.message : 'CareerNet 직업 상세 조회 실패'
      }
    }
  } else if (explicitGoyongId && !explicitCareernetId) {
    // goyongJobId만 명시적으로 지정된 경우
    sourcesStatus.CAREERNET.skippedReason = 'explicit-goyong-only'
  } else {
    sourcesStatus.CAREERNET.skippedReason = 'excluded'
  }

  // Goyong24 detail
  // ⚠️ 명시적으로 careernetId만 지정되었으면 Goyong24 건너뛰기
  if (!goyongProfile && sourcesToUse.includes('GOYONG24') && !(explicitCareernetId && !explicitGoyongId)) {
    const status = ensureSourceStatus(sourcesStatus, 'GOYONG24')
    const resolvedJobIdRaw =
      overrides?.goyong24JobId ??
      explicitGoyongId ??
      (id ? extractCanonicalSuffix(id, 'job:G_') : undefined)
    const resolvedJobId = resolvedJobIdRaw ? resolvedJobIdRaw.toUpperCase() : undefined

    if (!resolvedJobId) {
      status.skippedReason = 'missing-id'
    } else {
      status.attempted = true
      try {
        const raw = await fetchGoyong24JobDetail(resolvedJobId, env as any)
        rawGoyong24Data = raw
        goyongProfile = normalizeGoyong24JobDetail(raw)
        status.count = 1
      } catch (error) {
        status.error = error instanceof Error ? error.message : '고용24 직업 상세 조회 실패'
      }
    }
  } else if (explicitCareernetId && !explicitGoyongId) {
    // careernetId만 명시적으로 지정된 경우
    if (!goyongProfile) {
      sourcesStatus.GOYONG24.skippedReason = 'explicit-careernet-only'
    }
  } else if (!goyongProfile) {
    sourcesStatus.GOYONG24.skippedReason = 'excluded'
  }

  const merged = mergeJobProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)

  const partialsRecord: Partial<Record<DataSource, UnifiedJobDetail | null>> = {
    CAREERNET: careernetProfile,
    GOYONG24: goyongProfile
  }

  let enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)
  
  // 🆕 API 호출 후에도 DB에서 user_contributed_json과 admin_data_json 병합
  if (env && 'DB' in env && id) {
    try {
      const db = (env as any).DB
      
      // 실제 DB ID로 변환 (editJob과 동일한 로직)
      let dbJobId = id
      let dbJob = await db.prepare('SELECT id, user_contributed_json, admin_data_json FROM jobs WHERE id = ? AND is_active = 1')
        .bind(dbJobId)
        .first() as { id: string; user_contributed_json: string | null; admin_data_json: string | null } | null
      
      // ID로 찾지 못한 경우 복합 ID 형식 처리 (job:G_K000000890 같은 형식)
      if (!dbJob && id.includes(':')) {
        // job:G_K000000890 -> G_K000000890 또는 K000000890
        const parts = id.split(':')
        if (parts.length > 1) {
          let extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          
          // 추출한 ID로 다시 시도
          dbJob = await db.prepare('SELECT id, user_contributed_json, admin_data_json FROM jobs WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first() as { id: string; user_contributed_json: string | null; admin_data_json: string | null } | null
          
          if (dbJob) {
            dbJobId = extractedId
          } else {
            // G_K000000890 형식으로도 시도
            const withPrefix = parts[parts.length - 1]
            dbJob = await db.prepare('SELECT id, user_contributed_json, admin_data_json FROM jobs WHERE id = ? AND is_active = 1')
              .bind(withPrefix)
              .first() as { id: string; user_contributed_json: string | null; admin_data_json: string | null } | null
            
            if (dbJob) {
              dbJobId = withPrefix
            }
          }
        }
      }
      
      // 여전히 찾지 못한 경우 slug로 시도 (editJob과 동일한 로직)
      if (!dbJob) {
        const decodedSlug = decodeURIComponent(id)
        const normalizedSlug = decodedSlug.toLowerCase()
        
        // 방법 1: 정규화된 이름으로 조회
        dbJob = await db.prepare(
          'SELECT id, user_contributed_json, admin_data_json FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first() as { id: string; user_contributed_json: string | null; admin_data_json: string | null } | null
        
        // 방법 2: 이름으로 직접 조회 (대소문자 무시)
        if (!dbJob) {
          dbJob = await db.prepare(
            'SELECT id, user_contributed_json, admin_data_json FROM jobs WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first() as { id: string; user_contributed_json: string | null; admin_data_json: string | null } | null
        }
        
        // 방법 3: 원본 slug로 조회
        if (!dbJob) {
          dbJob = await db.prepare(
            'SELECT id, user_contributed_json, admin_data_json FROM jobs WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(decodedSlug).first() as { id: string; user_contributed_json: string | null; admin_data_json: string | null } | null
        }
        
        if (dbJob) {
          dbJobId = dbJob.id
        }
      }
      
      if (dbJob) {
        let userData = {}
        let adminData = {}
        
        try {
          if (dbJob.user_contributed_json) {
            userData = JSON.parse(dbJob.user_contributed_json)
          }
        } catch (error) {
        }
        
        try {
          if (dbJob.admin_data_json) {
            adminData = JSON.parse(dbJob.admin_data_json)
          }
        } catch (error) {
        }
        
        // 병합 적용 (admin > user > api 우선순위) - 깊은 병합 사용
        enhancedProfile = deepMergeProfile(deepMergeProfile(enhancedProfile, userData), adminData) as UnifiedJobDetail
      }
    } catch (dbError) {
      // DB 조회 실패는 조용히 처리 (로컬 개발 환경 등)
      // 에러가 발생해도 기존 enhancedProfile을 그대로 사용
    }
  }

  return {
    profile: enhancedProfile,
    partials: partialsRecord,
    sources: sourcesStatus,
    rawApiData: {
      careernet: rawCareernetData || null,
      goyong24: rawGoyong24Data || null
    }
  }
}
