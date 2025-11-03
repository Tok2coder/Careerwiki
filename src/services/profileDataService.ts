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

export type SourceStatusRecord = Record<DataSource, SourceStatus>

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

export const searchUnifiedMajors = async (
  params: { keyword?: string; page?: number; perPage?: number; includeSources?: DataSource[] },
  env?: CareerWikiEnv
): Promise<UnifiedSearchResult<UnifiedMajorSummaryEntry>> => {
  const { keyword = '', page = 1, perPage = 20, includeSources } = params
  const sourcesToUse = resolveIncludedSources(includeSources)

  const itemsMap = new Map<string, UnifiedMajorSummaryEntry>()
  const sourcesStatus = createInitialSourceStatus()

  // CareerNet search
  if (sourcesToUse.includes('CAREERNET')) {
    const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
    status.attempted = true
    try {
      const rawMajors = await searchCareerNetMajors(
        {
          keyword,
          thisPage: page,
          perPage
        },
        env
      )

      rawMajors.forEach((major) => {
        const profile = normalizeCareerNetMajorSummary(major)
        const entry: UnifiedMajorSummaryEntry = {
          profile,
          sourceMeta: {
            careernet: {
              majorSeq: major.majorSeq
            }
          },
          display: {
            summary: major.summary?.trim(),
            categoryName: major.department?.trim(),
            employmentRate: major.employmentRate?.trim(),
            salaryAfterGraduation: major.salaryAfterGraduation?.trim()
          }
        }
        itemsMap.set(profile.id, entry)
      })

      status.count = rawMajors.length
    } catch (error) {
      status.error = error instanceof Error ? error.message : 'CareerNet 학과 검색 실패'
    }
  } else {
    sourcesStatus.CAREERNET.skippedReason = 'excluded'
  }

  // Goyong24 search (requires keyword)
  if (sourcesToUse.includes('GOYONG24')) {
    const status = ensureSourceStatus(sourcesStatus, 'GOYONG24')
    if (!keyword.trim()) {
      status.skippedReason = 'keyword-required'
    } else {
      status.attempted = true
      try {
        const response = await fetchGoyong24MajorList(
          {
            keyword,
            srchType: 'K'
          },
          env as any
        )

        response.items.forEach((item: Goyong24MajorListItem) => {
          const profile = normalizeGoyong24MajorListItem(item)
          const entry: UnifiedMajorSummaryEntry = {
            profile,
            sourceMeta: {
              goyong24: {
                majorGb: (item.majorGb as '1' | '2') || '1',
                departmentId: item.empCurtState1Id,
                majorId: item.empCurtState2Id
              }
            },
            display: {
              categoryName: item.knowDtlSchDptNm?.trim()
            }
          }
          itemsMap.set(profile.id, entry)
        })

        status.count = response.items.length
      } catch (error) {
        status.error = error instanceof Error ? error.message : '고용24 학과 검색 실패'
      }
    }
  } else {
    sourcesStatus.GOYONG24.skippedReason = 'excluded'
  }

  return {
    items: Array.from(itemsMap.values()),
    meta: {
      total: itemsMap.size,
      sources: sourcesStatus
    }
  }
}

export const searchUnifiedJobs = async (
  params: { keyword?: string; category?: string; page?: number; perPage?: number; includeSources?: DataSource[] },
  env?: CareerWikiEnv
): Promise<UnifiedSearchResult<UnifiedJobSummaryEntry>> => {
  const { keyword = '', category = '', page = 1, perPage = 20, includeSources } = params
  const sourcesToUse = resolveIncludedSources(includeSources)

  const itemsMap = new Map<string, UnifiedJobSummaryEntry>()
  const sourcesStatus = createInitialSourceStatus()

  // CareerNet search
  if (sourcesToUse.includes('CAREERNET')) {
    const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
    status.attempted = true
    try {
      const rawJobs = await searchCareerNetJobs(
        {
          keyword,
          category,
          thisPage: page,
          perPage
        },
        env
      )

      rawJobs.forEach((job) => {
        const profile = normalizeCareerNetJobSummary(job)
        const entry: UnifiedJobSummaryEntry = {
          profile,
          sourceMeta: {
            careernet: {
              jobdicSeq: job.jobdicSeq
            }
          },
          display: {
            summary: job.summary?.trim(),
            salary: (job.avgSalary || job.salery)?.trim(),
            outlook: (job.jobOutlook || job.possibility)?.trim(),
            categoryName: (job.jobCategoryName || job.profession)?.trim()
          }
        }
        itemsMap.set(profile.id, entry)
      })

      status.count = rawJobs.length
    } catch (error) {
      status.error = error instanceof Error ? error.message : 'CareerNet 직업 검색 실패'
    }
  } else {
    sourcesStatus.CAREERNET.skippedReason = 'excluded'
  }

  // Goyong24 search
  if (sourcesToUse.includes('GOYONG24')) {
    const status = ensureSourceStatus(sourcesStatus, 'GOYONG24')
    status.attempted = true
    try {
      const response = await fetchGoyong24JobList(
        {
          keyword,
          srchType: 'K'
        },
        env as any
      )

      response.items.forEach((item: Goyong24JobListItem) => {
        const profile = normalizeGoyong24JobListItem(item)
        const entry: UnifiedJobSummaryEntry = {
          profile,
          sourceMeta: {
            goyong24: {
              jobCd: item.jobCd,
              jobClcd: item.jobClcd
            }
          },
          display: {
            categoryName: item.jobClcdNm?.trim()
          }
        }
        itemsMap.set(profile.id, entry)
      })

      status.count = response.items.length
    } catch (error) {
      status.error = error instanceof Error ? error.message : '고용24 직업 검색 실패'
    }
  } else {
    sourcesStatus.GOYONG24.skippedReason = 'excluded'
  }

  return {
    items: Array.from(itemsMap.values()),
    meta: {
      total: itemsMap.size,
      sources: sourcesStatus
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

  // CareerNet detail
  if (sourcesToUse.includes('CAREERNET')) {
    const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
    const resolvedCareernetId =
      careernetId ||
      (id ? extractCanonicalSuffix(id, 'major:C_') : undefined) ||
      (id && !id.includes(':') ? id : undefined)

    if (!resolvedCareernetId) {
      status.skippedReason = 'missing-id'
    } else {
      status.attempted = true
      try {
        const raw = await fetchCareerNetMajorDetail(resolvedCareernetId, env)
        if (raw) {
          careernetProfile = normalizeCareerNetMajorDetail(raw)
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
        goyongProfile = normalizeGoyong24MajorDetail(raw)
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
    sources: sourcesStatus
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
  if (env && 'DB' in env) {
    try {
      const db = (env as any).DB
      
      // Extract potential careernet ID from canonical ID format (e.g., "job:C_354" -> "354")
      const extractedId = id ? extractCanonicalSuffix(id, 'job:C_') : undefined
      
      // Build flexible query - try multiple match strategies
      let jobRow: any = null
      
      // Strategy 1: Try by careernet_id
      if (explicitCareernetId || extractedId) {
        const searchId = explicitCareernetId || extractedId
        jobRow = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json 
          FROM jobs 
          WHERE careernet_id = ?
          LIMIT 1
        `).bind(searchId).first()
      }
      
      // Strategy 2: Try by name if no match yet
      if (!jobRow && id && !id.includes(':')) {
        jobRow = await db.prepare(`
          SELECT id, name, careernet_id, goyong24_id, api_data_json 
          FROM jobs 
          WHERE name = ?
          LIMIT 1
        `).bind(id).first()
      }
      
      if (jobRow && jobRow.api_data_json) {
        try {
          const apiData = JSON.parse(jobRow.api_data_json)
          
          // Use cached data from D1
          if (apiData.careernet && sourcesToUse.includes('CAREERNET')) {
            rawCareernetData = apiData.careernet
            careernetProfile = normalizeCareerNetJobDetail(apiData.careernet)
            sourcesStatus.CAREERNET.attempted = true
            sourcesStatus.CAREERNET.count = 1
          }
          
          if (apiData.goyong24 && sourcesToUse.includes('GOYONG24')) {
            rawGoyong24Data = apiData.goyong24
            goyongProfile = normalizeGoyong24JobDetail(apiData.goyong24)
            sourcesStatus.GOYONG24.attempted = true
            sourcesStatus.GOYONG24.count = 1
          }
          
          // If we found data in D1, skip API calls
          if (careernetProfile || goyongProfile) {
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
        } catch (parseError) {
          console.error('Failed to parse D1 api_data_json:', parseError)
          // Continue to API fallback
        }
      }
    } catch (dbError) {
      console.error('D1 database query failed:', dbError)
      // Continue to API fallback
    }
  }

  // Step 2: Fallback to API calls if D1 doesn't have the data
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
        rawGoyong24Data = raw
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
    sources: sourcesStatus,
    rawApiData: {
      careernet: rawCareernetData,
      goyong24: rawGoyong24Data
    }
  }
}
