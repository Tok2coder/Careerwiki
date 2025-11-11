/*
 * Goyong24 (고용24) Open API Client
 *
 * Provides low-level fetch helpers for the 고용24 학과/직업 API endpoints and
 * exposes normalization utilities that convert raw XML payloads into the unified
 * domain models shared across the application.
 */

import type {
  EducationDistribution,
  JobKecoCodeInfo,
  JobOrganizationInfo,
  JobRelatedEntity,
  MajorDistribution,
  MajorRecruitmentStat,
  MajorUniversityInfo,
  UnifiedJobDetail,
  UnifiedJobSummary,
  UnifiedMajorDetail,
  UnifiedMajorSummary
} from '../types/unifiedProfiles'

// Goyong24 API Base URL
// 문서에 따르면: https://www.work24.go.kr/cm/openApi/call/hr/ (학과)
// 코드에서는: https://www.work24.go.kr/cm/openApi/call/wk/ (직업)
// 실제 엔드포인트 확인 필요
const GOYONG24_BASE_URL = 'https://www.work24.go.kr/cm/openApi/call/wk'

declare global {
  // 전역 fallback (테스트 시 글로벌 변수로 키 주입 가능)
  // eslint-disable-next-line no-var
  var GOYONG24_MAJOR_API_KEY: string | undefined
  // eslint-disable-next-line no-var
  var GOYONG24_JOB_API_KEY: string | undefined
}

export type EnvWithGoyong24Keys = {
  GOYONG24_MAJOR_API_KEY?: string
  GOYONG24_JOB_API_KEY?: string
}

// ---------------------------------------------------------------------------
// 공통 유틸리티
// ---------------------------------------------------------------------------

const decodeXmlEntities = (value?: string | null): string => {
  if (!value) return ''
  return value
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&#xA;/gi, '\n')
    .replace(/&#xD;/gi, '')     // Remove carriage return entirely
    .replace(/&#xd;/gi, '')     // Remove lowercase variant explicitly
}

const cleanText = (value?: string | null): string => {
  const decoded = decodeXmlEntities(value)
  if (!decoded) return ''
  return decoded
    .replace(/<br\s*\/?\s*>/gi, '\n')
    .replace(/\r?\n/g, '\n')
    .replace(/\u00a0/g, ' ')
    .replace(/\t+/g, ' ')
    .replace(/ +/g, ' ')
    .replace(/\n{3,}/g, '\n\n')
    .trim()
}

const getApiKey = (type: 'major' | 'job', env?: EnvWithGoyong24Keys): string => {
  const key =
    type === 'major'
      ? env?.GOYONG24_MAJOR_API_KEY || globalThis?.GOYONG24_MAJOR_API_KEY
      : env?.GOYONG24_JOB_API_KEY || globalThis?.GOYONG24_JOB_API_KEY

  if (!key) {
    throw new Error(
      `고용24 ${type === 'major' ? '학과' : '직업'} API 인증키가 설정되지 않았습니다. ` +
        '환경 변수 GOYONG24_MAJOR_API_KEY / GOYONG24_JOB_API_KEY를 확인하세요.'
    )
  }

  return key
}

const buildUrl = (endpoint: string, params: Record<string, string>): string => {
  const url = new URL(`${GOYONG24_BASE_URL}/${endpoint}.do`)
  Object.entries(params).forEach(([key, value]) => {
    if (value !== undefined && value !== null && value !== '') {
      url.searchParams.set(key, value)
    }
  })
  return url.toString()
}

type HeaderProfile = {
  label: string
  headers: Record<string, string>
}

const FETCH_HEADER_PROFILES: HeaderProfile[] = [
  {
    label: 'chrome-desktop',
    headers: {
      Accept: 'application/xml,text/xml,*/*;q=0.9',
      'Accept-Language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7',
      'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36',
      Referer: 'https://www.work24.go.kr/',
      Origin: 'https://www.work24.go.kr',
      'Cache-Control': 'no-cache',
      Pragma: 'no-cache'
    }
  },
  {
    label: 'safari-desktop',
    headers: {
      Accept: 'application/xml,text/xml,*/*;q=0.9',
      'Accept-Language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7',
      'User-Agent':
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15',
      Referer: 'https://www.work24.go.kr/',
      Origin: 'https://www.work24.go.kr',
      'Cache-Control': 'no-cache',
      Pragma: 'no-cache'
    }
  },
  {
    label: 'careerwiki-bot',
    headers: {
      Accept: 'application/xml,text/xml,*/*;q=0.9',
      'Accept-Language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7',
      'User-Agent': 'CareerwikiBot/1.0 (+https://careerwiki-phase1.pages.dev)',
      Referer: 'https://www.work24.go.kr/',
      Origin: 'https://www.work24.go.kr'
    }
  }
]

const sanitizeResponseSnippet = (value?: string): string => {
  if (!value) return ''
  return value
    .replace(/<script[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style[\s\S]*?<\/style>/gi, ' ')
    .replace(/<[^>]+>/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
    .slice(0, 240)
}

const fetchXml = async (endpoint: string, params: Record<string, string>): Promise<string> => {
  const url = buildUrl(endpoint, params)
  let lastError: string | null = null

  for (let attempt = 0; attempt < FETCH_HEADER_PROFILES.length; attempt += 1) {
    const profile = FETCH_HEADER_PROFILES[attempt]
    try {
      const response = await fetch(url, {
        redirect: 'follow',
        headers: profile.headers,
        cf: {
          cacheEverything: false,
          cacheTtl: 0
        }
      })

      const contentType = response.headers.get('content-type')?.toLowerCase() ?? ''
      const body = await response.text()
      const trimmed = body.trim()
      const isXml = contentType.includes('xml') || trimmed.startsWith('<')

      if (response.ok && isXml) {
        if (attempt > 0) {
          console.info(`[goyong24] ${endpoint} recovered with header profile "${profile.label}" (status ${response.status})`)
        }
        return body
      }

      const snippet = sanitizeResponseSnippet(body)
      const label = `${response.status} ${response.statusText || 'Unknown'}`
      lastError = `${label}${snippet ? ` · ${snippet}` : ''}`
      console.warn(`[goyong24] ${endpoint} attempt ${attempt + 1} (${profile.label}) failed: ${lastError}`)
      
      // 404 에러인 경우 상세 정보 로깅
      if (response.status === 404) {
        console.error(`[goyong24] 404 에러 - 엔드포인트 확인 필요: ${url}`)
        console.error(`[goyong24] 응답 본문 (처음 500자): ${body.substring(0, 500)}`)
      }
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error)
      lastError = message
      console.warn(`[goyong24] ${endpoint} attempt ${attempt + 1} (${profile.label}) threw: ${message}`)
    }
  }

  throw new Error(`고용24 API 요청 실패: ${lastError ?? '알 수 없는 오류'}`)
}

const getFirstValue = (xml: string, tag: string): string => {
  const regex = new RegExp(`<${tag}>([\\s\\S]*?)<\/${tag}>`, 'i')
  const match = xml.match(regex)
  if (!match) return ''
  const value = cleanText(match[1])
  // 빈 문자열이나 공백만 있는 경우 빈 문자열 반환 (undefined 처리는 호출하는 쪽에서)
  return value.trim()
}

const getAllValues = (xml: string, tag: string): string[] => {
  const regex = new RegExp(`<${tag}>([\\s\\S]*?)<\/${tag}>`, 'gi')
  const matches: string[] = []
  let match
  while ((match = regex.exec(xml)) !== null) {
    matches.push(cleanText(match[1]))
  }
  return matches
}

const extractNodes = (xml: string, nodeName: string): string[] => {
  const regex = new RegExp(`<${nodeName}>([\\s\\S]*?)<\/${nodeName}>`, 'gi')
  const nodes: string[] = []
  let match
  while ((match = regex.exec(xml)) !== null) {
    nodes.push(match[1])
  }
  return nodes
}

const dedupeStrings = (...lists: Array<string[] | undefined>): string[] => {
  const set = new Set<string>()
  lists.forEach((list) => {
    list?.forEach((item) => {
      const trimmed = cleanText(item)
      if (trimmed) set.add(trimmed)
    })
  })
  return Array.from(set)
}

const toRelatedEntities = (values?: string[]): JobRelatedEntity[] | undefined => {
  if (!values || values.length === 0) return undefined
  const unique = dedupeStrings(values)
  if (unique.length === 0) return undefined
  return unique.map((name) => ({ name }))
}

const createCanonicalMajorId = (rawId?: string): string => `major:G_${rawId ?? 'unknown'}`
const createCanonicalJobId = (rawId?: string): string => `job:G_${rawId ?? 'unknown'}`

// ---------------------------------------------------------------------------
// 학과 리스트 / 상세 타입 & 파서
// ---------------------------------------------------------------------------

export interface Goyong24MajorListParams {
  keyword: string
  srchType?: 'A' | 'K'
}

export interface Goyong24MajorListItem {
  majorGb: string
  knowDtlSchDptNm: string
  knowSchDptNm: string
  empCurtState1Id: string
  empCurtState2Id: string
}

export interface Goyong24MajorListResponse {
  total: number
  items: Goyong24MajorListItem[]
}

export interface Goyong24MajorDetailParams {
  majorGb: '1' | '2'
  empCurtState1Id: string
  empCurtState2Id: string
}

export interface Goyong24MajorDetail {
  majorGb: '1' | '2'
  departmentId: string
  majorId: string
  departmentName: string
  majorName: string
  summary?: string
  aptitude?: string
  relatedMajors?: string[]
  mainSubjects?: string[]
  licenses?: string[]
  universities?: MajorUniversityInfo[]
  recruitmentStatus?: MajorRecruitmentStat[]
  relatedJobs?: string[]
  whatStudy?: string
  howPrepare?: string
  jobProspect?: string
}

const parseMajorList = (xml: string): Goyong24MajorListResponse => {
  const total = Number(getFirstValue(xml, 'total') || '0')
  const rawItems = extractNodes(xml, 'majorList')

  const items = rawItems.map<Goyong24MajorListItem>((itemXml) => ({
    majorGb: getFirstValue(itemXml, 'majorGb'),
    knowDtlSchDptNm: getFirstValue(itemXml, 'knowDtlSchDptNm'),
    knowSchDptNm: getFirstValue(itemXml, 'knowSchDptNm'),
    empCurtState1Id: getFirstValue(itemXml, 'empCurtState1Id'),
    empCurtState2Id: getFirstValue(itemXml, 'empCurtState2Id')
  }))

  return { total, items }
}

const parseMajorDetail = (xml: string, majorGb: '1' | '2'): Goyong24MajorDetail => {
  if (majorGb === '2') {
    const spec = getFirstValue(xml, 'knowSchDptId') ? xml : ''
    return {
      majorGb,
      departmentId: getFirstValue(spec, 'knowDptId'),
      majorId: getFirstValue(spec, 'knowSchDptId'),
      departmentName: getFirstValue(spec, 'knowDptNm'),
      majorName: getFirstValue(spec, 'knowSchDptNm'),
      summary: getFirstValue(spec, 'schDptIntroSum'),
      whatStudy: getFirstValue(spec, 'whatStudy'),
      howPrepare: getFirstValue(spec, 'howPrepare'),
      jobProspect: getFirstValue(spec, 'jobPropect'),
      aptitude: '',
      relatedMajors: getAllValues(spec, 'knowDtlSchDptNm'),
      mainSubjects: [],
      licenses: [],
      universities: [],
      recruitmentStatus: [],
      relatedJobs: []
    }
  }

  const major = getFirstValue(xml, 'knowSchDptId') ? xml : ''
  const universities = extractNodes(major, 'schDptList').map<MajorUniversityInfo>((entry) => ({
    department: getFirstValue(entry, 'schDptNm'),
    universityType: getFirstValue(entry, 'univGbnNm'),
    name: getFirstValue(entry, 'univNm'),
    url: getFirstValue(entry, 'univUrl')
  }))

  const recruitmentStatus = extractNodes(major, 'recrStateList').map<MajorRecruitmentStat>((entry) => ({
    enrollmentQuota: getFirstValue(entry, 'enscMxnp'),
    applicants: getFirstValue(entry, 'enscSpnb'),
    graduates: getFirstValue(entry, 'grdnNmpr'),
    universityType: getFirstValue(entry, 'univGbnNm'),
    year: getFirstValue(entry, 'year')
  }))

  return {
    majorGb,
    departmentId: getFirstValue(major, 'knowDptId'),
    majorId: getFirstValue(major, 'knowSchDptId'),
    departmentName: getFirstValue(major, 'knowDptNm'),
    majorName: getFirstValue(major, 'knowSchDptNm'),
    summary: getFirstValue(major, 'schDptIntroSum'),
    aptitude: getFirstValue(major, 'aptdIntrstCont'),
    relatedMajors: getAllValues(major, 'knowDtlSchDptNm'),
    mainSubjects: getAllValues(major, 'mainEdusbjCont'),
    licenses: getAllValues(major, 'adoptCertCont'),
    universities,
    recruitmentStatus,
    relatedJobs: getAllValues(major, 'knowJobNm'),
    whatStudy: '',
    howPrepare: '',
    jobProspect: ''
  }
}

export const fetchGoyong24MajorList = async (
  params: Goyong24MajorListParams,
  env?: EnvWithGoyong24Keys
): Promise<Goyong24MajorListResponse> => {
  if (!params.keyword) {
    throw new Error('고용24 학과 목록 조회에는 keyword 파라미터가 필요합니다.')
  }

  const xml = await fetchXml('callOpenApiSvcInfo213L01', {
    authKey: getApiKey('major', env),
    returnType: 'XML',
    target: 'MAJORCD',
    srchType: params.srchType ?? 'K',
    keyword: params.keyword
  })

  return parseMajorList(xml)
}

export const fetchGoyong24MajorDetail = async (
  params: Goyong24MajorDetailParams,
  env?: EnvWithGoyong24Keys
): Promise<Goyong24MajorDetail> => {
  const endpoint = params.majorGb === '2' ? 'callOpenApiSvcInfo213D02' : 'callOpenApiSvcInfo213D01'

  const xml = await fetchXml(endpoint, {
    authKey: getApiKey('major', env),
    returnType: 'XML',
    target: 'MAJORDTL',
    majorGb: params.majorGb,
    empCurtState1Id: params.empCurtState1Id,
    empCurtState2Id: params.empCurtState2Id
  })

  return parseMajorDetail(xml, params.majorGb)
}

// 원본 XML 데이터를 포함한 확장 타입 (시딩용)
export interface Goyong24MajorDetailWithRaw {
  parsed: Goyong24MajorDetail
  rawXml: string
}

export const fetchGoyong24MajorDetailWithRaw = async (
  params: Goyong24MajorDetailParams,
  env?: EnvWithGoyong24Keys
): Promise<Goyong24MajorDetailWithRaw> => {
  const endpoint = params.majorGb === '2' ? 'callOpenApiSvcInfo213D02' : 'callOpenApiSvcInfo213D01'

  const xml = await fetchXml(endpoint, {
    authKey: getApiKey('major', env),
    returnType: 'XML',
    target: 'MAJORDTL',
    majorGb: params.majorGb,
    empCurtState1Id: params.empCurtState1Id,
    empCurtState2Id: params.empCurtState2Id
  })

  return {
    parsed: parseMajorDetail(xml, params.majorGb),
    rawXml: xml
  }
}

export const normalizeGoyong24MajorListItem = (
  item: Goyong24MajorListItem
): UnifiedMajorSummary => {
  const canonicalId = createCanonicalMajorId(item.empCurtState2Id)
  return {
    id: canonicalId,
    sourceIds: {
      goyong24: item.empCurtState2Id
    },
    name: item.knowSchDptNm,
    categoryId: item.empCurtState1Id,
    categoryName: item.knowDtlSchDptNm,
    summary: undefined,
    aptitude: undefined,
    relatedMajors: [],
    sources: ['GOYONG24']
  }
}

export const normalizeGoyong24MajorDetail = (
  detail: Goyong24MajorDetail
): UnifiedMajorDetail => {
  const listSummary = normalizeGoyong24MajorListItem({
    majorGb: detail.majorGb,
    knowDtlSchDptNm: detail.departmentName,
    knowSchDptNm: detail.majorName,
    empCurtState1Id: detail.departmentId,
    empCurtState2Id: detail.majorId
  })

  return {
    ...listSummary,
    summary: detail.summary || listSummary.summary,
    aptitude: detail.aptitude || listSummary.aptitude,
    relatedMajors: detail.relatedMajors || listSummary.relatedMajors,
    mainSubjects: detail.mainSubjects,
    licenses: detail.licenses,
    universities: detail.universities,
    recruitmentStatus: detail.recruitmentStatus,
    relatedJobs: detail.relatedJobs,
    whatStudy: detail.whatStudy,
    howPrepare: detail.howPrepare,
    jobProspect: detail.jobProspect,
    sources: ['GOYONG24']
  }
}

// ---------------------------------------------------------------------------
// 직업 리스트 / 상세 타입 & 파서
// ---------------------------------------------------------------------------

export interface Goyong24JobListParams {
  keyword?: string
  srchType?: 'K' | 'C'
  avgSal?: '10' | '20' | '30' | '40'
  prospect?: '1' | '2' | '3' | '4' | '5'
}

export interface Goyong24JobListItem {
  jobClcd: string
  jobClcdNm: string
  jobCd: string
  jobNm: string
}

export interface Goyong24JobListResponse {
  total: number
  items: Goyong24JobListItem[]
}

export interface Goyong24JobDetailSummary {
  jobCd: string
  jobNm?: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  jobSum?: string
  way?: string
  relMajorList?: Array<{ majorCd: string; majorNm: string }>
  relCertList?: string[]
  sal?: string
  jobSatis?: string
  jobProspect?: string
  jobStatus?: string
  jobAbil?: string
  knowldg?: string
  jobEnv?: string
  jobChr?: string
  jobIntrst?: string
  jobVals?: string
  jobActvImprtncs?: string
  jobActvLvls?: string
  relJobList?: Array<{ jobCd: string; jobNm: string }>
}

export interface Goyong24JobDetailDuty {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  jobSum?: string
  execJob?: string
  relJobList?: Array<{ jobCd: string; jobNm: string }>
}

export interface Goyong24JobDetailPath {
  jobCd: string
  technKnow?: string
  educationDistribution?: EducationDistribution
  majorDistribution?: MajorDistribution
  relMajorList?: Array<{ majorCd: string; majorNm: string }>
  relOrgList?: Array<{ orgNm: string; orgSiteUrl?: string }>
  relCertList?: string[]
  kecoList?: Array<{ kecoCd: string; kecoNm: string }>
}

export interface Goyong24JobDetailSalProspect {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  sal?: string
  jobSatis?: string
  jobProspect?: string
  jobSumProspect?: Array<{
    jobProspectNm: string
    jobProspectRatio: string
    jobProspectInqYr: string
  }>
  jobStatusList?: Array<{ jobCd: string; jobNm: string }>
}

export interface Goyong24JobDetailAblKnwEnv {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  jobAbilCmpr?: Array<{
    jobAblStatusCmpr: string
    jobAblNmCmpr: string
    jobAblContCmpr: string
  }>
  jobAbil?: Array<{
    jobAblStatus: string
    jobAblNm: string
    jobAblCont: string
  }>
  jobAbilLvlCmpr?: Array<{
    jobAblLvlStatusCmpr: string
    jobAblLvlNmCmpr: string
    jobAblLvlContCmpr: string
  }>
  jobAbilLvl?: Array<{
    jobAblLvlStatus: string
    jobAblLvlNm: string
    jobAblLvlCont: string
  }>
  KnwldgCmpr?: Array<{
    knwldgStatusCmpr: string
    knwldgNmCmpr: string
    knwldgContCmpr: string
  }>
  Knwldg?: Array<{
    knwldgStatus: string
    knwldgNm: string
    knwldgCont: string
  }>
  KnwldgLvlCmpr?: Array<{
    knwldgLvlStatusCmpr: string
    knwldgLvlNmCmpr: string
    knwldgLvlContCmpr: string
  }>
  KnwldgLvl?: Array<{
    knwldgLvlStatus: string
    knwldgLvlNm: string
    knwldgLvlCont: string
  }>
  jobsEnvCmpr?: Array<{
    jobEnvStatusCmpr: string
    jobEnvNmCmpr: string
    jobEnvContCmpr: string
  }>
  jobsEnv?: Array<{
    jobEnvStatus: string
    jobEnvNm: string
    jobEnvCont: string
  }>
}

export interface Goyong24JobDetailChrIntrVals {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  jobChrCmpr?: Array<{
    chrStatusCmpr: string
    chrNmCmpr: string
    chrContCmpr: string
  }>
  jobChr?: Array<{
    chrStatus: string
    chrNm: string
    chrCont: string
  }>
  jobIntrstCmpr?: Array<{
    intrstStatusCmpr: string
    intrstNmCmpr: string
    intrstContCmpr: string
  }>
  jobIntrst?: Array<{
    intrstStatus: string
    intrstNm: string
    intrstCont: string
  }>
  jobValsCmpr?: Array<{
    valsStatusCmpr: string
    valsNmCmpr: string
    valsContCmpr: string
  }>
  jobVals?: Array<{
    valsStatus: string
    valsNm: string
    valsCont: string
  }>
}

export interface Goyong24JobDetailActv {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  jobActvImprtncCmpr?: Array<{
    jobActvImprtncStatusCmpr: string
    jobActvImprtncNmCmpr: string
    jobActvImprtncContCmpr: string
  }>
  jobActvImprtnc?: Array<{
    jobActvImprtncStatus: string
    jobActvImprtncNm: string
    jobActvImprtncCont: string
  }>
  jobActvLvlCmpr?: Array<{
    jobActvLvlStatusCmpr: string
    jobActvLvlNmCmpr: string
    jobActvLvlContCmpr: string
  }>
  jobActvLvl?: Array<{
    jobActvLvlStatus: string
    jobActvLvlNm: string
    jobActvLvlCont: string
  }>
}

export interface Goyong24JobDetailAggregated {
  summary?: Goyong24JobDetailSummary
  duty?: Goyong24JobDetailDuty
  path?: Goyong24JobDetailPath
  salProspect?: Goyong24JobDetailSalProspect
  ablKnwEnv?: Goyong24JobDetailAblKnwEnv
  chrIntrVals?: Goyong24JobDetailChrIntrVals
  actv?: Goyong24JobDetailActv
}

const parseRelMajorList = (xml: string): Array<{ majorCd: string; majorNm: string }> =>
  extractNodes(xml, 'relMajorList').map((entry) => ({
    majorCd: getFirstValue(entry, 'majorCd'),
    majorNm: getFirstValue(entry, 'majorNm') || getFirstValue(entry, 'knowJobNm')
  }))

const parseRelJobList = (xml: string): Array<{ jobCd: string; jobNm: string }> =>
  extractNodes(xml, 'relJobList').map((entry) => ({
    jobCd: getFirstValue(entry, 'jobCd'),
    jobNm: getFirstValue(entry, 'jobNm')
  }))

const parseRelCertList = (xml: string): string[] => getAllValues(xml, 'certNm')

const parseSummarySection = (xml: string): Goyong24JobDetailSummary => {
  const block = extractNodes(xml, 'jobSum')[0] || xml
  return {
    jobCd: getFirstValue(block, 'jobCd'),
    jobNm: getFirstValue(block, 'jobNm'),
    jobLrclNm: getFirstValue(block, 'jobLrclNm'),
    jobMdclNm: getFirstValue(block, 'jobMdclNm'),
    jobSmclNm: getFirstValue(block, 'jobSmclNm'),
    jobSum: getFirstValue(block, 'jobSum'),
    way: getFirstValue(block, 'way'),
    relMajorList: parseRelMajorList(block),
    relCertList: parseRelCertList(block),
    sal: getFirstValue(block, 'sal'),
    jobSatis: getFirstValue(block, 'jobSatis'),
    jobProspect: getFirstValue(block, 'jobProspect'),
    jobStatus: getFirstValue(block, 'jobStatus'),
    jobAbil: getFirstValue(block, 'jobAbil'),
    knowldg: getFirstValue(block, 'knowldg'),
    jobEnv: getFirstValue(block, 'jobEnv'),
    jobChr: getFirstValue(block, 'jobChr'),
    jobIntrst: getFirstValue(block, 'jobIntrst'),
    jobVals: getFirstValue(block, 'jobVals'),
    jobActvImprtncs: getFirstValue(block, 'jobActvImprtncs'),
    jobActvLvls: getFirstValue(block, 'jobActvLvls'),
    relJobList: parseRelJobList(block)
  }
}

const parseDutySection = (xml: string): Goyong24JobDetailDuty => {
  const block = extractNodes(xml, 'jobsDo')[0] || xml
  return {
    jobCd: getFirstValue(block, 'jobCd'),
    jobLrclNm: getFirstValue(block, 'jobLrclNm'),
    jobMdclNm: getFirstValue(block, 'jobMdclNm'),
    jobSmclNm: getFirstValue(block, 'jobSmclNm'),
    jobSum: getFirstValue(block, 'jobSum'),
    execJob: getFirstValue(block, 'execJob'),
    relJobList: parseRelJobList(block)
  }
}

const parsePathSection = (xml: string): Goyong24JobDetailPath => {
  const block = extractNodes(xml, 'way')[0] || xml

  const educationDistribution: EducationDistribution = {
    middleSchoolOrLess: getFirstValue(block, 'edubgMgraduUndr'),
    highSchool: getFirstValue(block, 'edubgHgradu'),
    college: getFirstValue(block, 'edubgCgraduUndr'),
    university: getFirstValue(block, 'edubgUgradu'),
    graduate: getFirstValue(block, 'edubgGgradu'),
    doctor: getFirstValue(block, 'edubgDgradu')
  }

  const majorDistribution: MajorDistribution = {
    humanities: getFirstValue(block, 'cultLangDpt'),
    social: getFirstValue(block, 'socDpt'),
    education: getFirstValue(block, 'eduDpt'),
    engineering: getFirstValue(block, 'engnrDpt'),
    natural: getFirstValue(block, 'natrlDpt'),
    medical: getFirstValue(block, 'mediDpt'),
    artsSports: getFirstValue(block, 'artphyDpt')
  }

  const relOrgList: Array<{ orgNm: string; orgSiteUrl?: string }> = extractNodes(block, 'relOrgList').map(
    (entry) => ({
      orgNm: getFirstValue(entry, 'orgNm'),
      orgSiteUrl: getFirstValue(entry, 'orgSiteUrl')
    })
  )

  const kecoList: Array<{ kecoCd: string; kecoNm: string }> = extractNodes(block, 'kecoList').map((entry) => ({
    kecoCd: getFirstValue(entry, 'kecoCd'),
    kecoNm: getFirstValue(entry, 'kecoNm')
  }))

  return {
    jobCd: getFirstValue(block, 'jobCd'),
    technKnow: getFirstValue(block, 'technKnow'),
    educationDistribution,
    majorDistribution,
    relMajorList: parseRelMajorList(block),
    relOrgList,
    relCertList: parseRelCertList(block),
    kecoList
  }
}

const parseSalProspectSection = (xml: string): Goyong24JobDetailSalProspect => {
  const block = extractNodes(xml, 'salProspect')[0] || xml
  
  const jobSumProspect = extractNodes(block, 'jobSumProspect').map((entry) => ({
    jobProspectNm: getFirstValue(entry, 'jobProspectNm'),
    jobProspectRatio: getFirstValue(entry, 'jobProspectRatio'),
    jobProspectInqYr: getFirstValue(entry, 'jobProspectInqYr')
  }))
  
  const jobStatusList = extractNodes(block, 'jobStatusList').map((entry) => ({
    jobCd: getFirstValue(entry, 'jobCd'),
    jobNm: getFirstValue(entry, 'jobNm')
  }))

  const jobSatisValue = getFirstValue(block, 'jobSatis')
  console.log('[DEBUG] Goyong24 salProspect.jobSatis:', jobSatisValue, 'length:', jobSatisValue.length)

  return {
    jobCd: getFirstValue(block, 'jobCd'),
    jobLrclNm: getFirstValue(block, 'jobLrclNm'),
    jobMdclNm: getFirstValue(block, 'jobMdclNm'),
    jobSmclNm: getFirstValue(block, 'jobSmclNm'),
    sal: getFirstValue(block, 'sal'),
    jobSatis: jobSatisValue || undefined,
    jobProspect: getFirstValue(block, 'jobProspect'),
    jobSumProspect,
    jobStatusList
  }
}

const parseAblKnwEnvSection = (xml: string): Goyong24JobDetailAblKnwEnv => {
  const block = extractNodes(xml, 'ablKnwEnv')[0] || xml

  const jobAbilCmpr = extractNodes(block, 'jobAbilCmpr').map((entry) => ({
    jobAblStatusCmpr: getFirstValue(entry, 'jobAblStatusCmpr'),
    jobAblNmCmpr: getFirstValue(entry, 'jobAblNmCmpr'),
    jobAblContCmpr: getFirstValue(entry, 'jobAblContCmpr')
  }))

  const jobAbil = extractNodes(block, 'jobAbil').map((entry) => ({
    jobAblStatus: getFirstValue(entry, 'jobAblStatus'),
    jobAblNm: getFirstValue(entry, 'jobAblNm'),
    jobAblCont: getFirstValue(entry, 'jobAblCont')
  }))

  const jobAbilLvlCmpr = extractNodes(block, 'jobAbilLvlCmpr').map((entry) => ({
    jobAblLvlStatusCmpr: getFirstValue(entry, 'jobAblLvlStatusCmpr'),
    jobAblLvlNmCmpr: getFirstValue(entry, 'jobAblLvlNmCmpr'),
    jobAblLvlContCmpr: getFirstValue(entry, 'jobAblLvlContCmpr')
  }))

  const jobAbilLvl = extractNodes(block, 'jobAbilLvl').map((entry) => ({
    jobAblLvlStatus: getFirstValue(entry, 'jobAblLvlStatus'),
    jobAblLvlNm: getFirstValue(entry, 'jobAblLvlNm'),
    jobAblLvlCont: getFirstValue(entry, 'jobAblLvlCont')
  }))

  const KnwldgCmpr = extractNodes(block, 'KnwldgCmpr').map((entry) => ({
    knwldgStatusCmpr: getFirstValue(entry, 'knwldgStatusCmpr'),
    knwldgNmCmpr: getFirstValue(entry, 'knwldgNmCmpr'),
    knwldgContCmpr: getFirstValue(entry, 'knwldgContCmpr')
  }))

  const Knwldg = extractNodes(block, 'Knwldg').map((entry) => ({
    knwldgStatus: getFirstValue(entry, 'knwldgStatus'),
    knwldgNm: getFirstValue(entry, 'knwldgNm'),
    knwldgCont: getFirstValue(entry, 'knwldgCont')
  }))

  const KnwldgLvlCmpr = extractNodes(block, 'KnwldgLvlCmpr').map((entry) => ({
    knwldgLvlStatusCmpr: getFirstValue(entry, 'knwldgLvlStatusCmpr'),
    knwldgLvlNmCmpr: getFirstValue(entry, 'knwldgLvlNmCmpr'),
    knwldgLvlContCmpr: getFirstValue(entry, 'knwldgLvlContCmpr')
  }))

  const KnwldgLvl = extractNodes(block, 'KnwldgLvl').map((entry) => ({
    knwldgLvlStatus: getFirstValue(entry, 'knwldgLvlStatus'),
    knwldgLvlNm: getFirstValue(entry, 'knwldgLvlNm'),
    knwldgLvlCont: getFirstValue(entry, 'knwldgLvlCont')
  }))

  const jobsEnvCmpr = extractNodes(block, 'jobsEnvCmpr').map((entry) => ({
    jobEnvStatusCmpr: getFirstValue(entry, 'jobEnvStatusCmpr'),
    jobEnvNmCmpr: getFirstValue(entry, 'jobEnvNmCmpr'),
    jobEnvContCmpr: getFirstValue(entry, 'jobEnvContCmpr')
  }))

  const jobsEnv = extractNodes(block, 'jobsEnv').map((entry) => ({
    jobEnvStatus: getFirstValue(entry, 'jobEnvStatus'),
    jobEnvNm: getFirstValue(entry, 'jobEnvNm'),
    jobEnvCont: getFirstValue(entry, 'jobEnvCont')
  }))

  return {
    jobCd: getFirstValue(block, 'jobCd'),
    jobLrclNm: getFirstValue(block, 'jobLrclNm'),
    jobMdclNm: getFirstValue(block, 'jobMdclNm'),
    jobSmclNm: getFirstValue(block, 'jobSmclNm'),
    jobAbilCmpr,
    jobAbil,
    jobAbilLvlCmpr,
    jobAbilLvl,
    KnwldgCmpr,
    Knwldg,
    KnwldgLvlCmpr,
    KnwldgLvl,
    jobsEnvCmpr,
    jobsEnv
  }
}

const parseChrIntrValsSection = (xml: string): Goyong24JobDetailChrIntrVals => {
  const block = extractNodes(xml, 'chrIntrVals')[0] || xml

  const jobChrCmpr = extractNodes(block, 'jobChrCmpr').map((entry) => ({
    chrStatusCmpr: getFirstValue(entry, 'chrStatusCmpr'),
    chrNmCmpr: getFirstValue(entry, 'chrNmCmpr'),
    chrContCmpr: getFirstValue(entry, 'chrContCmpr')
  }))

  const jobChr = extractNodes(block, 'jobChr').map((entry) => ({
    chrStatus: getFirstValue(entry, 'chrStatus'),
    chrNm: getFirstValue(entry, 'chrNm'),
    chrCont: getFirstValue(entry, 'chrCont')
  }))

  const jobIntrstCmpr = extractNodes(block, 'jobIntrstCmpr').map((entry) => ({
    intrstStatusCmpr: getFirstValue(entry, 'intrstStatusCmpr'),
    intrstNmCmpr: getFirstValue(entry, 'intrstNmCmpr'),
    intrstContCmpr: getFirstValue(entry, 'intrstContCmpr')
  }))

  const jobIntrst = extractNodes(block, 'jobIntrst').map((entry) => ({
    intrstStatus: getFirstValue(entry, 'intrstStatus'),
    intrstNm: getFirstValue(entry, 'intrstNm'),
    intrstCont: getFirstValue(entry, 'intrstCont')
  }))

  const jobValsCmpr = extractNodes(block, 'jobValsCmpr').map((entry) => ({
    valsStatusCmpr: getFirstValue(entry, 'valsStatusCmpr'),
    valsNmCmpr: getFirstValue(entry, 'valsNmCmpr'),
    valsContCmpr: getFirstValue(entry, 'valsContCmpr')
  }))

  const jobVals = extractNodes(block, 'jobVals').map((entry) => ({
    valsStatus: getFirstValue(entry, 'valsStatus'),
    valsNm: getFirstValue(entry, 'valsNm'),
    valsCont: getFirstValue(entry, 'valsCont')
  }))

  return {
    jobCd: getFirstValue(block, 'jobCd'),
    jobLrclNm: getFirstValue(block, 'jobLrclNm'),
    jobMdclNm: getFirstValue(block, 'jobMdclNm'),
    jobSmclNm: getFirstValue(block, 'jobSmclNm'),
    jobChrCmpr,
    jobChr,
    jobIntrstCmpr,
    jobIntrst,
    jobValsCmpr,
    jobVals
  }
}

const parseActvSection = (xml: string): Goyong24JobDetailActv => {
  const block = extractNodes(xml, 'jobActv')[0] || xml

  const jobActvImprtncCmpr = extractNodes(block, 'jobActvImprtncCmpr').map((entry) => ({
    jobActvImprtncStatusCmpr: getFirstValue(entry, 'jobActvImprtncStatusCmpr'),
    jobActvImprtncNmCmpr: getFirstValue(entry, 'jobActvImprtncNmCmpr'),
    jobActvImprtncContCmpr: getFirstValue(entry, 'jobActvImprtncContCmpr')
  }))

  const jobActvImprtnc = extractNodes(block, 'jobActvImprtnc').map((entry) => ({
    jobActvImprtncStatus: getFirstValue(entry, 'jobActvImprtncStatus'),
    jobActvImprtncNm: getFirstValue(entry, 'jobActvImprtncNm'),
    jobActvImprtncCont: getFirstValue(entry, 'jobActvImprtncCont')
  }))

  const jobActvLvlCmpr = extractNodes(block, 'jobActvLvlCmpr').map((entry) => ({
    jobActvLvlStatusCmpr: getFirstValue(entry, 'jobActvLvlStatusCmpr'),
    jobActvLvlNmCmpr: getFirstValue(entry, 'jobActvLvlNmCmpr'),
    jobActvLvlContCmpr: getFirstValue(entry, 'jobActvLvlContCmpr')
  }))

  const jobActvLvl = extractNodes(block, 'jobActvLvl').map((entry) => ({
    jobActvLvlStatus: getFirstValue(entry, 'jobActvLvlStatus'),
    jobActvLvlNm: getFirstValue(entry, 'jobActvLvlNm'),
    jobActvLvlCont: getFirstValue(entry, 'jobActvLvlCont')
  }))

  return {
    jobCd: getFirstValue(block, 'jobCd'),
    jobLrclNm: getFirstValue(block, 'jobLrclNm'),
    jobMdclNm: getFirstValue(block, 'jobMdclNm'),
    jobSmclNm: getFirstValue(block, 'jobSmclNm'),
    jobActvImprtncCmpr,
    jobActvImprtnc,
    jobActvLvlCmpr,
    jobActvLvl
  }
}

export const fetchGoyong24JobList = async (
  params: Goyong24JobListParams = {},
  env?: EnvWithGoyong24Keys
): Promise<Goyong24JobListResponse> => {
  const xml = await fetchXml('callOpenApiSvcInfo212L01', {
    authKey: getApiKey('job', env),
    returnType: 'XML',
    target: 'JOBCD',
    srchType: params.srchType ?? 'K',
    keyword: params.keyword ?? '',
    avgSal: params.avgSal ?? '',
    prospect: params.prospect ?? ''
  })

  const total = Number(getFirstValue(xml, 'total') || '0')
  const rawItems = extractNodes(xml, 'jobList')
  const items = rawItems.map<Goyong24JobListItem>((itemXml) => ({
    jobClcd: getFirstValue(itemXml, 'jobClcd'),
    jobClcdNm: getFirstValue(itemXml, 'jobClcdNM'),
    jobCd: getFirstValue(itemXml, 'jobCd'),
    jobNm: getFirstValue(itemXml, 'jobNm')
  }))

  return { total, items }
}

const jobDetailEndpoints = {
  summary: { endpoint: 'callOpenApiSvcInfo212D01', dtlGb: '1' },
  duty: { endpoint: 'callOpenApiSvcInfo212D02', dtlGb: '2' },
  path: { endpoint: 'callOpenApiSvcInfo212D03', dtlGb: '3' },
  salProspect: { endpoint: 'callOpenApiSvcInfo212D04', dtlGb: '4' },
  ablKnwEnv: { endpoint: 'callOpenApiSvcInfo212D05', dtlGb: '5' },
  chrIntrVals: { endpoint: 'callOpenApiSvcInfo212D06', dtlGb: '6' },
  actv: { endpoint: 'callOpenApiSvcInfo212D07', dtlGb: '7' }
} as const

type JobDetailSectionKey = keyof typeof jobDetailEndpoints

const fetchJobDetailSection = async (
  jobCd: string,
  section: JobDetailSectionKey,
  env?: EnvWithGoyong24Keys
): Promise<string> => {
  const { endpoint, dtlGb } = jobDetailEndpoints[section]
  return fetchXml(endpoint, {
    authKey: getApiKey('job', env),
    returnType: 'XML',
    target: 'JOBDTL',
    jobGb: '1',
    jobCd,
    dtlGb
  })
}

export const fetchGoyong24JobDetail = async (
  jobCd: string,
  env?: EnvWithGoyong24Keys
): Promise<Goyong24JobDetailAggregated> => {
  const [summaryXml, dutyXml, pathXml, salProspectXml, ablKnwEnvXml, chrIntrValsXml, actvXml] = await Promise.all([
    fetchJobDetailSection(jobCd, 'summary', env),
    fetchJobDetailSection(jobCd, 'duty', env),
    fetchJobDetailSection(jobCd, 'path', env),
    fetchJobDetailSection(jobCd, 'salProspect', env),
    fetchJobDetailSection(jobCd, 'ablKnwEnv', env),
    fetchJobDetailSection(jobCd, 'chrIntrVals', env),
    fetchJobDetailSection(jobCd, 'actv', env)
  ])

  return {
    summary: parseSummarySection(summaryXml),
    duty: parseDutySection(dutyXml),
    path: parsePathSection(pathXml),
    salProspect: parseSalProspectSection(salProspectXml),
    ablKnwEnv: parseAblKnwEnvSection(ablKnwEnvXml),
    chrIntrVals: parseChrIntrValsSection(chrIntrValsXml),
    actv: parseActvSection(actvXml)
  }
}

const extractJobTitle = (summary?: Goyong24JobDetailSummary): string | undefined => {
  if (!summary) return undefined
  if (summary.jobNm && summary.jobNm.trim()) {
    return summary.jobNm.trim()
  }

  const firstLine = summary.jobSum?.split('\n').find((line) => line.trim().length > 0)
  if (!firstLine) return undefined

  const cleaned = firstLine.replace(/^[-•]\s*/, '').trim()
  const match = cleaned.match(/^([가-힣a-zA-Z0-9\s]{2,}?)(은|는|이|가)\s/)
  if (match && match[1]) {
    return match[1].trim()
  }

  return cleaned
}

const mergeRelatedMajorEntities = (
  ...lists: Array<Array<{ majorCd: string; majorNm: string }> | undefined>
): JobRelatedEntity[] | undefined => {
  const map = new Map<string, JobRelatedEntity>()
  lists.forEach((list) => {
    list?.forEach((item) => {
      const name = cleanText(item.majorNm)
      if (!name) return
      const id = item.majorCd ? `major:G_${item.majorCd}` : undefined
      const key = id || name
      if (!map.has(key)) {
        map.set(key, { id, name })
      }
    })
  })

  if (map.size === 0) return undefined
  return Array.from(map.values())
}

const mergeRelatedJobEntities = (
  ...lists: Array<Array<{ jobCd: string; jobNm: string }> | undefined>
): JobRelatedEntity[] | undefined => {
  const map = new Map<string, JobRelatedEntity>()
  lists.forEach((list) => {
    list?.forEach((item) => {
      const name = cleanText(item.jobNm)
      if (!name) return
      const id = item.jobCd ? createCanonicalJobId(item.jobCd) : undefined
      const key = id || name
      if (!map.has(key)) {
        map.set(key, { id, name })
      }
    })
  })

  if (map.size === 0) return undefined
  return Array.from(map.values())
}

export const normalizeGoyong24JobListItem = (
  item: Goyong24JobListItem
): UnifiedJobSummary => {
  const canonicalId = createCanonicalJobId(item.jobCd)
  return {
    id: canonicalId,
    sourceIds: {
      goyong24: item.jobCd
    },
    name: item.jobNm || canonicalId,
    category: {
      code: item.jobClcd,
      name: item.jobClcdNm
    },
    sources: ['GOYONG24']
  }
}

export const normalizeGoyong24JobDetail = (
  detail: Goyong24JobDetailAggregated
): UnifiedJobDetail => {
  if (!detail.summary?.jobCd) {
    throw new Error('고용24 직업 상세 데이터에 필수 jobCd 정보가 없습니다.')
  }

  const summary = detail.summary
  const salProspect = detail.salProspect
  const jobTitle = extractJobTitle(summary) || summary.jobNm || summary.jobSmclNm || summary.jobMdclNm || summary.jobLrclNm || summary.jobCd

  const canonicalSummary = normalizeGoyong24JobListItem({
    jobClcd: summary.jobLrclNm || '',
    jobClcdNm: summary.jobLrclNm || '',
    jobCd: summary.jobCd,
    jobNm: jobTitle
  })

  const relatedMajors = mergeRelatedMajorEntities(summary.relMajorList, detail.path?.relMajorList)
  const relatedJobs = mergeRelatedJobEntities(summary.relJobList, detail.duty?.relJobList)
  const relatedCertificates = dedupeStrings(summary.relCertList, detail.path?.relCertList)

  const organizations: JobOrganizationInfo[] | undefined = detail.path?.relOrgList?.length
    ? detail.path.relOrgList.map((org) => ({ name: org.orgNm, url: org.orgSiteUrl })).filter((org) => org.name)
    : undefined

  const kecoCodes: JobKecoCodeInfo[] | undefined = detail.path?.kecoList?.length
    ? detail.path.kecoList
        .map((item) => ({ code: item.kecoCd, name: item.kecoNm }))
        .filter((item) => item.code || item.name)
    : undefined

  return {
    ...canonicalSummary,
    name: extractJobTitle(summary) || canonicalSummary.name,
    classifications: {
      large: summary.jobLrclNm,
      medium: summary.jobMdclNm,
      small: summary.jobSmclNm
    },
    // CORRECTED MAPPING: Goyong24 API field names are misleading
    // - summary.way actually contains job description (not "how to become")
    // - path.technKnow actually contains "how to become" info (not just "tech knowledge")
    summary: summary.way || summary.jobSum,  // way field contains actual job description
    duties: detail.duty?.execJob || summary.jobSum,
    way: detail.path?.technKnow,  // technKnow field contains "how to become" info
    relatedMajors,
    relatedCertificates: relatedCertificates.length ? relatedCertificates : undefined,
    salary: summary.sal,
    satisfaction: (summary.jobSatis && summary.jobSatis.trim()) || (salProspect?.jobSatis && salProspect.jobSatis.trim()) || undefined,
    prospect: summary.jobProspect,
    status: summary.jobStatus,
    abilities: summary.jobAbil,
    knowledge: summary.knowldg,
    environment: summary.jobEnv,
    personality: summary.jobChr,
    interests: summary.jobIntrst,
    values: summary.jobVals,
    activitiesImportance: summary.jobActvImprtncs,
    activitiesLevels: summary.jobActvLvls,
    relatedJobs,
    technKnow: undefined,  // No separate tech knowledge field in API
    educationDistribution: detail.path?.educationDistribution,
    majorDistribution: detail.path?.majorDistribution,
    relatedOrganizations: organizations,
    kecoCodes,
    sources: ['GOYONG24']
  }
}
