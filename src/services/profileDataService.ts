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
    outlook?: string
    categoryName?: string
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

  // First, get total count
  let countQuery = 'SELECT COUNT(*) as total FROM majors'
  if (conditions.length > 0) {
    countQuery += ' WHERE ' + conditions.join(' AND ')
  }

  const countResult = await db.prepare(countQuery).bind(...countBindings).first<{ total: number }>()
  const totalCount = countResult?.total || 0

  // Fetch paginated results
  let query = 'SELECT id, name, careernet_id, goyong24_id, api_data_json FROM majors'
  const bindings: any[] = [...countBindings]

  if (conditions.length > 0) {
    query += ' WHERE ' + conditions.join(' AND ')
  }

  // Add pagination
  const offset = (page - 1) * perPage
  query += ` LIMIT ? OFFSET ?`
  bindings.push(perPage, offset)

  const result = await db.prepare(query).bind(...bindings).all()
  const d1Majors = result.results || []

  // Parse D1 results into UnifiedMajorSummaryEntry format
  const items: UnifiedMajorSummaryEntry[] = []
  
  d1Majors.forEach((row: any) => {
    try {
      // Parse cached API data
      let apiData = null
      if (row.api_data_json) {
        try {
          apiData = JSON.parse(row.api_data_json)
        } catch (parseError) {
          console.error(`Failed to parse api_data_json for major ${row.id}:`, parseError)
        }
      }

      // Extract nested API data
      const careernetData = apiData?.careernet || {}
      const goyongData = apiData?.goyong24 || {}
      
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

      // Create profile
      const profile: UnifiedMajorSummary = {
        id: String(row.id),
        sourceIds: {
          careernet: row.careernet_id && row.careernet_id !== 'null' ? row.careernet_id : undefined,
          goyong24: row.goyong24_id && row.goyong24_id !== 'null' ? row.goyong24_id : undefined
        },
        name: row.name?.trim() || `전공 ${row.id}`,
        categoryName: careernetData.categoryName || careernetData.department || goyongData.categoryName,
        summary: careernetData.summary || goyongData.summary,
        sources
      }

      const entry: UnifiedMajorSummaryEntry = {
        profile,
        sourceMeta: {
          careernet: row.careernet_id ? {
            majorSeq: row.careernet_id
          } : undefined,
          goyong24: row.goyong24_id ? {
            majorGb: goyongData.majorGb || '1',
            departmentId: goyongData.departmentId,
            majorId: row.goyong24_id
          } : undefined
        },
        display: {
          summary: (careernetData.summary || goyongData.summary)?.trim(),
          categoryName: (careernetData.categoryName || careernetData.department || goyongData.categoryName)?.trim(),
          employmentRate: careernetData.employmentRate?.trim(),
          salaryAfterGraduation: careernetData.salaryAfterGraduation?.trim()
        }
      }

      items.push(entry)
    } catch (entryError) {
      console.error(`Failed to process D1 major row ${row.id}:`, entryError)
    }
  })

  return {
    items,
    meta: {
      total: totalCount,
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

  // First, get total count
  let countQuery = 'SELECT COUNT(*) as total FROM jobs'
  if (conditions.length > 0) {
    countQuery += ' WHERE ' + conditions.join(' AND ')
  }

  const countResult = await db.prepare(countQuery).bind(...countBindings).first<{ total: number }>()
  const totalCount = countResult?.total || 0

  // Fetch paginated results
  let query = 'SELECT id, name, careernet_id, goyong24_id, api_data_json FROM jobs'
  const bindings: any[] = [...countBindings]

  if (conditions.length > 0) {
    query += ' WHERE ' + conditions.join(' AND ')
  }

  // Add pagination
  const offset = (page - 1) * perPage
  query += ` LIMIT ? OFFSET ?`
  bindings.push(perPage, offset)

  const result = await db.prepare(query).bind(...bindings).all()
  const d1Jobs = result.results || []

  // Parse D1 results into UnifiedJobSummaryEntry format
  const items: UnifiedJobSummaryEntry[] = []
  
  d1Jobs.forEach((row: any) => {
    try {
      // Parse cached API data
      let apiData = null
      if (row.api_data_json) {
        try {
          apiData = JSON.parse(row.api_data_json)
        } catch (parseError) {
          console.error(`Failed to parse api_data_json for job ${row.id}:`, parseError)
        }
      }

      // Extract nested API data
      const careernetData = apiData?.careernet || {}
      const goyongData = apiData?.goyong24 || {}
      
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
      
      // Extract salary from encyclopedia.baseInfo.wage
      const baseInfo = careernetData.encyclopedia?.baseInfo || {}
      let salary = baseInfo.wage || careernetData.avgSalary || careernetData.salery
      if (salary) {
        salary = String(salary).trim()
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

      // Create profile
      const profile: UnifiedJobSummary = {
        id: String(row.id),
        sourceIds: {
          careernet: row.careernet_id && row.careernet_id !== 'null' ? row.careernet_id : undefined,
          goyong24: row.goyong24_id && row.goyong24_id !== 'null' ? row.goyong24_id : undefined
        },
        name: row.name?.trim() || `직업 ${row.id}`,
        category: careernetData.jobCategoryName || careernetData.profession ? {
          name: (careernetData.jobCategoryName || careernetData.profession).trim()
        } : undefined,
        sources
      }

      const entry: UnifiedJobSummaryEntry = {
        profile,
        sourceMeta: {
          careernet: row.careernet_id ? {
            jobdicSeq: row.careernet_id
          } : undefined,
          goyong24: row.goyong24_id ? {
            jobCd: row.goyong24_id
          } : undefined
        },
        display: {
          summary: careernetData.summary?.trim(),
          salary,
          outlook,
          categoryName: (careernetData.jobCategoryName || careernetData.profession)?.trim()
        }
      }

      items.push(entry)
    } catch (entryError) {
      console.error(`Failed to process D1 job row ${row.id}:`, entryError)
    }
  })

  return {
    items,
    meta: {
      total: totalCount,
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
      
      // Try finding by name (Korean slug) in D1
      // ✅ .all()로 변경하여 같은 이름의 모든 레코드를 가져옴 (CareerNet + Goyong24 병합)
      const allMajorRows = await db.prepare(`
        SELECT id, name, careernet_id, goyong24_id, api_data_json 
        FROM majors 
        WHERE LOWER(name) = LOWER(?)
      `).bind(id).all()
      
      console.log(`🔍 D1 전공 name 검색: name="${id}", found=${allMajorRows.results?.length || 0}개 레코드`)
      
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
                  const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
                  status.attempted = true
                  status.count = 1
                  console.log(`  ✅ 커리어넷 전공 데이터 수집 완료 (레코드 ID: ${row.id}, careernet_id: ${row.careernet_id})`)
                  
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
                  console.log(`  ✅ 고용24 전공 데이터 수집 완료 (레코드 ID: ${row.id}, goyong24_id: ${row.goyong24_id})`)
                  
                  // rawPartials에 원본 데이터 저장
                  if (apiData?.rawGoyong24) {
                    if (!sourcesStatus.rawPartials) sourcesStatus.rawPartials = {}
                    sourcesStatus.rawPartials.GOYONG24 = apiData.rawGoyong24
                  }
                }
              }
              
              // 양쪽 데이터를 모두 찾았으면 중단
              if (careernetProfile && goyongProfile) {
                console.log(`  🎯 양쪽 소스 전공 데이터 모두 수집 완료, 병합 진행`)
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
          
          // 병합된 데이터의 name 사용 (mergeMajorProfiles에서 이미 고용24 우선 처리됨)
          // 첫 번째 레코드의 name을 fallback으로 사용
          if (!merged.name || !merged.name.trim()) {
            if (allMajorRows.results[0].name && allMajorRows.results[0].name.trim()) {
              merged.name = allMajorRows.results[0].name.trim()
            }
          }
          
          console.log(`  🎉 D1 전공 병합 완료: "${merged.name}" (커리어넷: ${!!careernetProfile}, 고용24: ${!!goyongProfile})`)
          
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
      console.error('D1 major lookup error:', d1Error)
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
        
        console.log(`🔍 D1 name 검색: name="${id}", found=${allJobRows.results?.length || 0}개 레코드`)
        
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
                    console.log(`  ✅ 커리어넷 데이터 수집 완료 (레코드 ID: ${row.id}, careernet_id: ${row.careernet_id})`)
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
                    console.log(`  ✅ 고용24 데이터 수집 완료 (레코드 ID: ${row.id}, goyong24_id: ${row.goyong24_id})`)
                  }
                }
                
                // 양쪽 데이터를 모두 찾았으면 중단
                if (careernetProfile && goyongProfile) {
                  console.log(`  🎯 양쪽 소스 데이터 모두 수집 완료, 병합 진행`)
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
            
            console.log(`  🎉 D1 병합 완료: "${enhancedProfile.name}" (커리어넷: ${!!careernetProfile}, 고용24: ${!!goyongProfile})`)
            
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
        console.log(`🔍 D1 fallback ID 검색: id="${id}", found=${!!jobRow}`)
        
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
                console.log(`  ✅ 커리어넷 데이터 수집 완료 (fallback, 레코드 ID: ${jobRow.id})`)
              }
            }
            
            if (jobRow.goyong24_id && sourcesToUse.includes('GOYONG24') && !goyongProfile) {
              const goyong24Data = apiData.goyong24
              if (goyong24Data && goyong24Data !== null && typeof goyong24Data === 'object') {
                rawGoyong24Data = goyong24Data
                goyongProfile = normalizeGoyong24JobDetail(goyong24Data)
                sourcesStatus.GOYONG24.attempted = true
                sourcesStatus.GOYONG24.count = 1
                console.log(`  ✅ 고용24 데이터 수집 완료 (fallback, 레코드 ID: ${jobRow.id})`)
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
                        console.log(`  ✅ 커리어넷 데이터 추가 수집 (동일 이름, 레코드 ID: ${sibling.id})`)
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
                        console.log(`  ✅ 고용24 데이터 추가 수집 (동일 이름, 레코드 ID: ${sibling.id})`)
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
        console.log(`🔍 D1 fallback careernet_id 검색: id="${searchId}", found=${!!jobRow}`)
        
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
                console.log(`  ✅ 커리어넷 데이터 수집 완료 (fallback careernet_id, 레코드 ID: ${jobRow.id})`)
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
                      console.log(`  ✅ 고용24 데이터 수집 완료 (같은 이름 검색, 레코드 ID: ${otherRow.id})`)
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
                        console.log(`  ✅ 커리어넷 데이터 추가 수집 (동일 이름, 레코드 ID: ${sibling.id})`)
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
                        console.log(`  ✅ 고용24 데이터 추가 수집 (동일 이름, 레코드 ID: ${sibling.id})`)
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
      console.error('D1 database query failed:', dbError)
      // Continue to API fallback
    }
  } else if (hasExplicitSourceId) {
    console.log(`🎯 명시적 소스 ID 지정됨 - D1 병합 건너뛰고 직접 조회: careernetId=${explicitCareernetId}, goyong24JobId=${explicitGoyongId}`)
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
    console.log(`  ⏭️  CareerNet 건너뛰기: goyongJobId만 지정됨`)
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
      console.log(`  ⏭️  Goyong24 건너뛰기: careernetId만 지정됨`)
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
