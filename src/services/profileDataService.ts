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
  GOYONG24: { attempted: false, count: 0 }
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
    departmentName?: string  // 계열명 (고용24만)
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
  params: { keyword?: string; page?: number; perPage?: number; includeSources?: DataSource[] },
  env?: CareerWikiEnv
): Promise<UnifiedSearchResult<UnifiedMajorSummaryEntry>> => {
  const { keyword = '', page = 1, perPage = 20 } = params

  // D1 database is required
  if (!env?.DB) {
    throw new Error('D1 database not available')
  }

  const db = env.DB
  const conditions: string[] = []
  const countBindings: any[] = []

  // Add keyword search condition
  if (keyword?.trim()) {
    conditions.push('LOWER(name) LIKE LOWER(?)')
    countBindings.push(`%${keyword.trim()}%`)
  }

  // 🚀 성능 최적화: 페이지네이션을 먼저 적용하여 필요한 전공명만 가져오기
  
  // Step 1: 고유한 전공명 목록을 페이지네이션 적용하여 가져오기
  let uniqueNamesQuery = `
    SELECT DISTINCT LOWER(name) as normalized_name, name as original_name
    FROM majors
  `
  if (conditions.length > 0) {
    uniqueNamesQuery += ' WHERE ' + conditions.join(' AND ')
  }
  uniqueNamesQuery += ' ORDER BY normalized_name'
  
  // 페이지네이션 적용
  const offset = (page - 1) * perPage
  uniqueNamesQuery += ` LIMIT ${perPage} OFFSET ${offset}`
  
  const uniqueNamesResult = await db.prepare(uniqueNamesQuery).bind(...countBindings).all()
  const uniqueNames = uniqueNamesResult.results || []
  
  if (uniqueNames.length === 0) {
    // 결과가 없으면 빈 배열 반환
    return {
      items: [],
      meta: {
        total: 0,
        sources: {
          CAREERNET: { count: 0 },
          GOYONG24: { count: 0 }
        }
      }
    }
  }
  
  // Step 2: 해당 전공명들에 대한 모든 레코드 조회 (병합을 위해)
  const nameList = uniqueNames.map((r: any) => r.original_name)
  const placeholders = nameList.map(() => 'LOWER(name) = LOWER(?)').join(' OR ')
  
  let detailQuery = `
    SELECT id, name, careernet_id, goyong24_id, api_data_json 
    FROM majors 
    WHERE (${placeholders})
  `
  if (conditions.length > 0) {
    detailQuery += ' AND (' + conditions.join(' AND ') + ')'
  }
  detailQuery += ' ORDER BY LOWER(name)'
  
  const detailBindings = [...nameList, ...countBindings]
  const result = await db.prepare(detailQuery).bind(...detailBindings).all()
  const d1Majors = result.results || []
  
  // Step 3: 총 개수 계산 (전체 고유 전공명 수)
  let countQuery = 'SELECT COUNT(DISTINCT LOWER(name)) as total FROM majors'
  if (conditions.length > 0) {
    countQuery += ' WHERE ' + conditions.join(' AND ')
  }
  const countResult = await db.prepare(countQuery).bind(...countBindings).first<{ total: number }>()
  const totalCount = countResult?.total || 0

  // 🔄 전공명 정규화 함수 (보수적 접근 - 실제로 같은 전공인 경우만 병합)
  // ⚠️ "한국어학과"와 "국어국문학과"는 완전히 다른 전공이므로 병합되면 안 됨
  const normalizeMajorName = (name: string): string => {
    let normalized = name
      .trim()
      .toLowerCase()
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
      // 🔄 모든 레코드의 데이터를 병합
      let mergedCareernetData: any = {}
      let mergedGoyongData: any = {}
      let careernetId: string | undefined
      let goyongId: string | undefined
      // 원본 이름 중 가장 긴 이름을 선택 (정보가 가장 풍부함)
      const originalNames = rows.map(r => r.name?.trim()).filter(Boolean)
      const majorName = originalNames.reduce((longest, current) => 
        current.length > longest.length ? current : longest
      , originalNames[0] || '알 수 없음')
      
      // 성능 최적화: ID는 먼저 추출하고, 병합이 필요한 경우에만 JSON 파싱
      rows.forEach((row: any) => {
        // ID만 먼저 추출 (JSON 파싱 없이)
        if (!careernetId && row.careernet_id && row.careernet_id !== 'null') {
          careernetId = row.careernet_id
        }
        if (!goyongId && row.goyong24_id && row.goyong24_id !== 'null') {
          goyongId = row.goyong24_id
        }
      })
      
      // 병합이 필요한 경우에만 JSON 파싱 (단일 레코드면 첫 번째 레코드만 파싱)
      const rowsToProcess = rows.length === 1 ? [rows[0]] : rows
      rowsToProcess.forEach((row: any) => {
        let apiData = null
        if (row.api_data_json) {
          try {
            apiData = JSON.parse(row.api_data_json)
          } catch (parseError) {
            console.error(`Failed to parse api_data_json for major ${row.id}:`, parseError)
          }
        }
        
        // Careernet 데이터 병합
        if (apiData?.careernet && Object.keys(apiData.careernet).length > 0) {
          mergedCareernetData = { ...mergedCareernetData, ...apiData.careernet }
        }
        
        // Goyong24 데이터 병합
        if (apiData?.goyong24 && Object.keys(apiData.goyong24).length > 0) {
          mergedGoyongData = { ...mergedGoyongData, ...apiData.goyong24 }
        }
      })
      
      const careernetData = mergedCareernetData
      const goyongData = mergedGoyongData
      
      // Determine sources dynamically based on actual data
      const sources: DataSource[] = []
      if (careernetData && Object.keys(careernetData).length > 0) {
        sources.push('CAREERNET')
      }
      if (goyongData && Object.keys(goyongData).length > 0) {
        sources.push('GOYONG24')
      }
      
      // Fallback to CAREERNET if no sources detected
      if (sources.length === 0) {
        sources.push('CAREERNET')
      }

      // Create profile (병합된 데이터 사용)
      const profile: UnifiedMajorSummary = {
        id: majorName, // 전공명을 ID로 사용 (중복 제거)
        sourceIds: {
          careernet: careernetId,
          goyong24: goyongId
        },
        name: majorName,
        categoryName: careernetData.categoryName || careernetData.department || goyongData.categoryName,
        summary: careernetData.summary || goyongData.summary,
        sources
      }

      const entry: UnifiedMajorSummaryEntry = {
        profile,
        sourceMeta: {
          careernet: careernetId ? {
            majorSeq: careernetId
          } : undefined,
          goyong24: goyongId ? {
            majorGb: goyongData.majorGb || '1',
            departmentId: goyongData.departmentId,
            majorId: goyongId
          } : undefined
        },
        display: (() => {
          // 커리어넷과 고용24 데이터 모두 있는지 확인
          const hasCareernet = careernetData && Object.keys(careernetData).length > 0
          const hasGoyong24 = goyongData && Object.keys(goyongData).length > 0
          
          // 둘 다 있으면 커리어넷 데이터만 사용
          if (hasCareernet && hasGoyong24) {
            // 취업률
            const employmentRate = careernetData.employmentRate?.trim()
            
            // 첫직장임금(월): salaryAfterGraduation은 이미 월봉임
            const firstJobSalary = careernetData.salaryAfterGraduation?.trim()
            
            // 첫 직장 만족도: chartData.satisfaction에서 추출
            let firstJobSatisfaction: string | undefined = undefined
            if (careernetData.chartData?.satisfaction && Array.isArray(careernetData.chartData.satisfaction)) {
              const firstSatisfaction = careernetData.chartData.satisfaction[0]
              if (firstSatisfaction?.data) {
                const satisText = String(firstSatisfaction.data).trim()
                firstJobSatisfaction = satisText.includes('%') ? satisText : `${satisText}%`
              }
            }
            
            return {
              summary: careernetData.summary?.trim(),
              categoryName: (careernetData.categoryName || careernetData.department)?.trim(),
              employmentRate,
              salaryAfterGraduation: firstJobSalary,
              firstJobSalary,
              firstJobSatisfaction
            }
          }
          
          // 고용24 데이터만 있는 경우
          if (!hasCareernet && hasGoyong24) {
            return {
              summary: goyongData.summary?.trim(),
              categoryName: goyongData.categoryName?.trim(),
              jobProspect: goyongData.jobProspect?.trim(),
              departmentName: goyongData.departmentName?.trim()
            }
          }
          
          // 커리어넷 데이터만 있는 경우
          if (hasCareernet && !hasGoyong24) {
            const employmentRate = careernetData.employmentRate?.trim()
            const firstJobSalary = careernetData.salaryAfterGraduation?.trim()
            
            let firstJobSatisfaction: string | undefined = undefined
            if (careernetData.chartData?.satisfaction && Array.isArray(careernetData.chartData.satisfaction)) {
              const firstSatisfaction = careernetData.chartData.satisfaction[0]
              if (firstSatisfaction?.data) {
                const satisText = String(firstSatisfaction.data).trim()
                firstJobSatisfaction = satisText.includes('%') ? satisText : `${satisText}%`
              }
            }
            
            return {
              summary: careernetData.summary?.trim(),
              categoryName: (careernetData.categoryName || careernetData.department)?.trim(),
              employmentRate,
              salaryAfterGraduation: firstJobSalary,
              firstJobSalary,
              firstJobSatisfaction
            }
          }
          
          // 둘 다 없는 경우
          return {
            summary: undefined,
            categoryName: undefined
          }
        })()
      }

      items.push(entry)
    } catch (entryError) {
      console.error(`Failed to process D1 major row:`, entryError)
    }
  })

  // 🚀 페이지네이션은 이미 데이터베이스 레벨에서 적용됨 (LIMIT/OFFSET)
  return {
    items, // 이미 페이지네이션된 결과
    meta: {
      total: totalCount, // 전체 고유 전공명 수
      sources: {
        CAREERNET: { count: items.filter(i => i.profile.sources.includes('CAREERNET')).length },
        GOYONG24: { count: items.filter(i => i.profile.sources.includes('GOYONG24')).length }
      }
    }
  }
}

/**
 * Search for unified jobs from D1 database
 * Simplified version - only uses D1, no API fallbacks
 */
export const searchUnifiedJobs = async (
  params: { keyword?: string; category?: string; page?: number; perPage?: number; includeSources?: DataSource[] },
  env?: CareerWikiEnv
): Promise<UnifiedSearchResult<UnifiedJobSummaryEntry>> => {
  const { keyword = '', category = '', page = 1, perPage = 20 } = params

  // D1 database is required
  if (!env?.DB) {
    throw new Error('D1 database not available')
  }

  const db = env.DB
  const conditions: string[] = []
  const countBindings: any[] = []

  // Add keyword search condition
  if (keyword?.trim()) {
    conditions.push('LOWER(name) LIKE LOWER(?)')
    countBindings.push(`%${keyword.trim()}%`)
  }

  // 🚀 성능 최적화: 페이지네이션을 먼저 적용하여 필요한 직업명만 가져오기
  
  // Step 1: 고유한 직업명 목록을 페이지네이션 적용하여 가져오기
  let uniqueNamesQuery = `
    SELECT DISTINCT LOWER(name) as normalized_name, name as original_name
    FROM jobs
  `
  if (conditions.length > 0) {
    uniqueNamesQuery += ' WHERE ' + conditions.join(' AND ')
  }
  uniqueNamesQuery += ' ORDER BY normalized_name'
  
  // 페이지네이션 적용
  const offset = (page - 1) * perPage
  uniqueNamesQuery += ` LIMIT ${perPage} OFFSET ${offset}`
  
  const uniqueNamesResult = await db.prepare(uniqueNamesQuery).bind(...countBindings).all()
  const uniqueNames = uniqueNamesResult.results || []
  
  if (uniqueNames.length === 0) {
    // 결과가 없으면 빈 배열 반환
    return {
      items: [],
      meta: {
        total: 0,
        sources: {
          CAREERNET: { count: 0 },
          GOYONG24: { count: 0 }
        }
      }
    }
  }
  
  // Step 2: 해당 직업명들에 대한 모든 레코드 조회 (병합을 위해)
  const nameList = uniqueNames.map((r: any) => r.original_name)
  const placeholders = nameList.map(() => 'LOWER(name) = LOWER(?)').join(' OR ')
  
  let detailQuery = `
    SELECT id, name, careernet_id, goyong24_id, api_data_json 
    FROM jobs 
    WHERE (${placeholders})
  `
  if (conditions.length > 0) {
    detailQuery += ' AND (' + conditions.join(' AND ') + ')'
  }
  detailQuery += ' ORDER BY LOWER(name)'
  
  const detailBindings = [...nameList, ...countBindings]
  const result = await db.prepare(detailQuery).bind(...detailBindings).all()
  const d1Jobs = result.results || []
  
  // Step 3: 총 개수 계산 (전체 고유 직업명 수)
  let countQuery = 'SELECT COUNT(DISTINCT LOWER(name)) as total FROM jobs'
  if (conditions.length > 0) {
    countQuery += ' WHERE ' + conditions.join(' AND ')
  }
  const countResult = await db.prepare(countQuery).bind(...countBindings).first<{ total: number }>()
  const totalCount = countResult?.total || 0

  // 🔄 직업명 정규화 함수 (쉼표, 가운뎃점, 공백, "및" 통일)
  const normalizeJobName = (name: string): string => {
    let normalized = name
      .trim()
      .toLowerCase()
      // 일반적인 오타 수정
      .replace(/운저원/g, '운전원') // 운저원 → 운전원
      // "채굴기계" → "기계" (건설 및 채굴기계운전원 → 건설기계운전원)
      .replace(/채굴기계/g, '기계')
      // "및"를 쉼표로 변환
      .replace(/\s*및\s*/g, ',')
      // 가운뎃점을 쉼표로 변환
      .replace(/[·•]/g, ',')
      // 쉼표 앞뒤 공백 제거
      .replace(/\s*,\s*/g, ',')
      // 모든 공백 완전히 제거 (가장 공격적인 정규화)
      .replace(/\s+/g, '')
      // "공"과 "원" 접미사 통일
      .replace(/(도장|설치|수리|운전)공$/g, '$1원')
    
    // 쉼표로 구분된 경우 불필요한 추가 직무명 제거
    const parts = normalized.split(',')
    if (parts.length > 1) {
      // "코미디언", "엔터테이너" 같은 동의어 추가 직무명은 제거
      const synonymExtraParts = ['코미디언', '엔터테이너']
      const filteredParts = parts.filter(part => {
        // 마지막 부분이 동의어면 제거
        return !synonymExtraParts.some(extra => part === extra || part.endsWith(extra))
      })
      if (filteredParts.length > 0) {
        normalized = filteredParts.join(',')
      }
    }
    
    return normalized
  }

  // 🔄 같은 이름의 직업을 병합하기 위한 Map
  const jobsByName = new Map<string, any[]>()
  const mergedGroups: Array<{ normalized: string; originals: string[]; count: number }> = []
  
  d1Jobs.forEach((row: any) => {
    const originalName = row.name?.trim()
    if (!originalName) return
    
    const normalizedName = normalizeJobName(originalName)
    
    if (!jobsByName.has(normalizedName)) {
      jobsByName.set(normalizedName, [])
    }
    jobsByName.get(normalizedName)!.push(row)
  })
  
  // 병합된 그룹 정보 수집
  jobsByName.forEach((rows, normalizedName) => {
    if (rows.length > 1) {
      const originalNames = [...new Set(rows.map(r => r.name?.trim()))].filter(Boolean)
      mergedGroups.push({
        normalized: normalizedName,
        originals: originalNames,
        count: rows.length
      })
    }
  })

  // Parse D1 results into UnifiedJobSummaryEntry format
  const items: UnifiedJobSummaryEntry[] = []
  
  // 각 고유 직업명에 대해 병합된 레코드 생성
  jobsByName.forEach((rows: any[]) => {
    try {
      // 🔄 모든 레코드의 데이터를 병합
      let mergedCareernetData: any = {}
      let mergedGoyongData: any = {}
      let careernetId: string | undefined
      let goyongId: string | undefined
      // 원본 이름 중 가장 긴 이름을 선택 (정보가 가장 풍부함)
      const originalNames = rows.map(r => r.name?.trim()).filter(Boolean)
      const jobName = originalNames.reduce((longest, current) => 
        current.length > longest.length ? current : longest
      , originalNames[0] || '알 수 없음')
      
      rows.forEach((row: any) => {
        let apiData = null
        if (row.api_data_json) {
          try {
            apiData = JSON.parse(row.api_data_json)
          } catch (parseError) {
            console.error(`Failed to parse api_data_json for job ${row.id}:`, parseError)
          }
        }
        
        // Careernet 데이터 병합
        if (apiData?.careernet && Object.keys(apiData.careernet).length > 0) {
          mergedCareernetData = { ...mergedCareernetData, ...apiData.careernet }
          if (!careernetId && row.careernet_id && row.careernet_id !== 'null') {
            careernetId = row.careernet_id
          }
        }
        
        // Goyong24 데이터 병합
        if (apiData?.goyong24 && Object.keys(apiData.goyong24).length > 0) {
          mergedGoyongData = { ...mergedGoyongData, ...apiData.goyong24 }
          if (!goyongId && row.goyong24_id && row.goyong24_id !== 'null') {
            goyongId = row.goyong24_id
          }
        }
      })
      
      const careernetData = mergedCareernetData
      const goyongData = mergedGoyongData
      
      // Determine sources dynamically based on actual data
      const sources: DataSource[] = []
      if (careernetData && Object.keys(careernetData).length > 0) {
        sources.push('CAREERNET')
      }
      if (goyongData && Object.keys(goyongData).length > 0) {
        sources.push('GOYONG24')
      }
      
      // Fallback to CAREERNET if no sources detected
      if (sources.length === 0) {
        sources.push('CAREERNET')
      }
      
      // Extract data from CareerNet and Goyong24
      const baseInfo = careernetData.encyclopedia?.baseInfo || {}
      const goyongSalProspect = goyongData.salProspect || {}
      
      // 연봉: 고용24 우선, 없으면 커리어넷
      let salary: string | undefined = undefined
      
      // 1. 고용24 salProspect.sal 우선
      if (goyongSalProspect.sal) {
        // 고용24: "조사년도:2023년, 임금 하위(25%) 3150만원, 평균(50%) 3600만원, 상위(25%) 4500만원"
        // → "평균 3600만원" 추출
        const salText = String(goyongSalProspect.sal).trim()
        const match = salText.match(/평균\(50%\)\s*(\d[\d,]*만원)/)
        if (match) {
          salary = `평균 ${match[1]}`
        }
      }
      
      // 2. 고용24 summary.sal 대안
      if (!salary && goyongData.summary?.sal) {
        const salText = String(goyongData.summary.sal).trim()
        const match = salText.match(/평균\(50%\)\s*(\d[\d,]*만원)/)
        if (match) {
          salary = `평균 ${match[1]}`
        }
      }
      
      // 3. 커리어넷 encyclopedia.baseInfo.wage
      if (!salary && baseInfo.wage) {
        const wageText = String(baseInfo.wage).trim()
        // 쉼표 제거 후 숫자 확인
        const wageWithoutComma = wageText.replace(/,/g, '')
        
        if (/^[\d,]+$/.test(wageText)) {
          // 숫자만 있는 경우 (쉼표 포함): "4579" 또는 "5,000" → "평균 4579만원" 또는 "평균 5000만원"
          salary = `평균 ${wageWithoutComma}만원`
        } else if (wageText.includes('만원')) {
          // 이미 "만원" 포함: "평균" 없으면 추가
          salary = wageText.includes('평균') ? wageText : `평균 ${wageText}`
        } else {
          salary = wageText
        }
      }
      
      // 4. 레거시 데이터 (avgSalary, salery)
      if (!salary && (careernetData.avgSalary || careernetData.salery)) {
        const legacySalary = String(careernetData.avgSalary || careernetData.salery).trim()
        // 쉼표 제거 후 숫자 확인
        const legacyWithoutComma = legacySalary.replace(/,/g, '')
        
        if (/^[\d,]+$/.test(legacySalary)) {
          salary = `평균 ${legacyWithoutComma}만원`
        } else {
          salary = legacySalary
        }
      }
      
      // 직업 만족도: 고용24 우선, 없으면 커리어넷, % 붙이기
      let satisfaction: string | undefined = undefined
      if (goyongSalProspect.jobSatis) {
        const satisText = String(goyongSalProspect.jobSatis).trim()
        satisfaction = satisText.includes('%') ? satisText : `${satisText}%`
      } else if (baseInfo.satisfication) {
        const satisText = String(baseInfo.satisfication).trim()
        satisfaction = satisText.includes('%') ? satisText : `${satisText}%`
      }
      
      // 워라벨: 커리어넷만
      let wlb: string | undefined = undefined
      if (baseInfo.wlb) {
        wlb = String(baseInfo.wlb).trim()
      }
      
      // Extract outlook from encyclopedia.forecastList[0].forecast
      const forecastList = careernetData.encyclopedia?.forecastList || []
      let outlook = forecastList[0]?.forecast || careernetData.jobOutlook || careernetData.possibility
      if (outlook) {
        outlook = String(outlook).trim()
        // Truncate outlook to first 100 characters for display
        if (outlook.length > 100) {
          outlook = outlook.slice(0, 97) + '...'
        }
      }

      // Create profile (병합된 데이터 사용)
      const profile: UnifiedJobSummary = {
        id: jobName, // 직업명을 ID로 사용 (중복 제거)
        sourceIds: {
          careernet: careernetId,
          goyong24: goyongId
        },
        name: jobName,
        category: careernetData.jobCategoryName || careernetData.profession ? {
          name: (careernetData.jobCategoryName || careernetData.profession).trim()
        } : undefined,
        sources
      }

      const entry: UnifiedJobSummaryEntry = {
        profile,
        sourceMeta: {
          careernet: careernetId ? {
            jobdicSeq: careernetId
          } : undefined,
          goyong24: goyongId ? {
            jobCd: goyongId
          } : undefined
        },
        display: {
          summary: careernetData.summary?.trim() || goyongData.duty?.jobSum?.trim(),
          salary,
          satisfaction,
          wlb,
          outlook,
          categoryName: (careernetData.jobCategoryName || careernetData.profession)?.trim(),
          departmentName: goyongData.departmentName?.trim()  // 계열명 (고용24만)
        }
      }

      items.push(entry)
    } catch (entryError) {
      console.error(`Failed to process D1 job row:`, entryError)
    }
  })

  // 🚀 페이지네이션은 이미 데이터베이스 레벨에서 적용됨 (LIMIT/OFFSET)
  return {
    items, // 이미 페이지네이션된 결과
    meta: {
      total: totalCount, // 전체 고유 직업명 수
      sources: {
        CAREERNET: { count: items.filter(i => i.profile.sources.includes('CAREERNET')).length },
        GOYONG24: { count: items.filter(i => i.profile.sources.includes('GOYONG24')).length }
      }
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

  // 🆕 Step 0: Check D1 Database first (if available) for Korean name lookups
  // ⚠️ 직업 페이지와 동일한 병합 로직 적용 (이름으로 모든 레코드 검색 → 병합)
  if (env && 'DB' in env && id && !id.includes(':')) {
    try {
      const db = (env as any).DB
      
      // 🔄 전공명 정규화 함수 (목록 페이지와 동일)
      const normalizeMajorNameForSearch = (name: string): string => {
        let normalized = name
          .trim()
          .toLowerCase()
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
      
      const normalizedSearchName = normalizeMajorNameForSearch(id)
      
      // Try finding by name (Korean slug) in D1
      // ✅ 정규화된 이름으로도 검색하여 병합된 전공 찾기
      // 1. 정확히 일치하는 것 먼저 검색
      let allMajorRows = await db.prepare(`
        SELECT id, name, careernet_id, goyong24_id, api_data_json 
        FROM majors 
        WHERE LOWER(name) = LOWER(?)
      `).bind(id).all()
      
      // 2. 정확히 일치하는 것이 없으면 정규화된 이름으로 검색
      if (!allMajorRows.results || allMajorRows.results.length === 0) {
        // 모든 전공을 가져와서 정규화된 이름으로 필터링
        const allMajors = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json 
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
                  
                careernetProfile = {
                  id: `major:C_${row.careernet_id}`,
                  sourceIds: { careernet: row.careernet_id },
                  name: row.name,
                  ...parsedData,
                  sources: ['CAREERNET']
                }
                
                // 🔧 D1 데이터에 department가 없으면 rawCareernet.universityList에서 보완
                if (careernetProfile.universities && apiData?.rawCareernet?.universityList) {
                  careernetProfile.universities = careernetProfile.universities.map(uni => {
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
              console.error(`  ❌ JSON 파싱 오류 (레코드 ID: ${row.id}):`, error)
            }
          }
        }
        
        // If we found data in D1, skip API calls and merge
        if (careernetProfile || goyongProfile) {
          const merged = mergeMajorProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)
          
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
            row.name && row.name.trim().toLowerCase() === id.toLowerCase()
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
          
          return {
            profile: merged,
            partials: {
              CAREERNET: careernetProfile,
              GOYONG24: goyongProfile
            },
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
        console.error('D1 major lookup error:', d1Error)
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

  const merged = mergeMajorProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)

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

  let careernetProfile: UnifiedJobDetail | null = null
  let goyongProfile: UnifiedJobDetail | null = null

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

  // 🆕 Step 1: Check D1 Database first (if available)
  // ⚠️ 쿼리 파라미터가 명시적으로 있으면 D1 병합을 건너뛰고 직접 조회
  const hasExplicitSourceId = !!(explicitCareernetId || explicitGoyongId)
  
  if (env && 'DB' in env && !hasExplicitSourceId) {
    try {
      const db = (env as any).DB
      
      // Extract potential careernet ID from canonical ID format (e.g., "job:C_354" -> "354")
      const extractedId = id ? extractCanonicalSuffix(id, 'job:C_') : undefined
      
      // Build flexible query - try multiple match strategies
      // 🆕 Strategy 3을 먼저 시도 (이름으로 검색하여 병합)
      // Strategy 3: Try by name (fetch ALL matching records for merging)
      if (id && !id.includes(':')) {
        const allJobRows = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json 
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
                console.error(`  ❌ JSON 파싱 오류 (레코드 ID: ${row.id}):`, error)
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
            const enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)
            
            // 🆕 병합된 데이터의 name 사용 (mergeJobProfiles에서 이미 고용24 우선 처리됨)
            // 첫 번째 레코드의 name을 fallback으로 사용
            if (!enhancedProfile.name || !enhancedProfile.name.trim()) {
              if (allJobRows.results[0].name && allJobRows.results[0].name.trim()) {
                enhancedProfile.name = allJobRows.results[0].name.trim()
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
          SELECT id, name, careernet_id, goyong24_id, api_data_json 
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
                      console.error(`  ❌ JSON 파싱 오류 (동일 이름 커리어넷, 레코드 ID: ${sibling.id}):`, error)
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
                      console.error(`  ❌ JSON 파싱 오류 (동일 이름 고용24, 레코드 ID: ${sibling.id}):`, error)
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
              const enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)
              
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
            console.error('Failed to parse D1 api_data_json (fallback):', parseError)
          }
        }
      }
      
      // Strategy 2: Try by careernet_id (fallback)
      if (!careernetProfile && !goyongProfile && (explicitCareernetId || extractedId)) {
        const searchId = explicitCareernetId || extractedId
        const jobRow = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json 
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
                SELECT id, name, careernet_id, goyong24_id, api_data_json 
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
                    console.error(`  ❌ JSON 파싱 오류 (레코드 ID: ${otherRow.id}):`, e)
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
                      console.error(`  ❌ JSON 파싱 오류 (동일 이름 커리어넷, 레코드 ID: ${sibling.id}):`, error)
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
                      console.error(`  ❌ JSON 파싱 오류 (동일 이름 고용24, 레코드 ID: ${sibling.id}):`, error)
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
              const enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)
              
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
            console.error('Failed to parse D1 api_data_json (fallback careernet_id):', parseError)
          }
        }
      }
    } catch (dbError) {
      // 네트워크 연결 에러는 조용히 처리 (로컬 개발 환경에서 D1이 시작되지 않았을 때)
      if (dbError instanceof Error && (dbError.message.includes('fetch failed') || dbError.message.includes('ECONNREFUSED') || dbError.message.includes('ECONNRESET'))) {
        // 조용히 API fallback으로 진행
      } else {
        // 다른 에러는 로그 남김
        console.error('D1 database query failed:', dbError)
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

  const enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)

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
