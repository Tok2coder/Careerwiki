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

  let careernetProfile: UnifiedJobDetail | null = null
  let goyongProfile: UnifiedJobDetail | null = null

  // CareerNet detail
  if (sourcesToUse.includes('CAREERNET')) {
    const status = ensureSourceStatus(sourcesStatus, 'CAREERNET')
    const resolvedCareernetId =
      careernetId ||
      (id ? extractCanonicalSuffix(id, 'job:C_') : undefined) ||
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
    const resolvedJobId =
      goyong24JobId || (id ? extractCanonicalSuffix(id, 'job:G_') : undefined)

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

  return {
    profile: merged,
    partials: {
      CAREERNET: careernetProfile,
      GOYONG24: goyongProfile
    },
    sources: sourcesStatus
  }
}
