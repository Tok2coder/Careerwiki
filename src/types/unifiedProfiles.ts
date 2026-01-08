// Extended data sources for new architecture
export type DataSource = 'CAREERNET' | 'GOYONG24' | 'WORK24_JOB' | 'WORK24_DJOB' | 'WORK24_MAJOR' | 'AI' | 'USER_CONTRIBUTED' | 'ADMIN_OVERRIDE'

// Legacy aliases for backward compatibility
export type LegacyDataSource = 'GOYONG24' | 'CAREERNET'

export interface SourceIdentifiers {
  careernet?: string
  goyong24?: string      // Legacy (Work24 학과정보)
  work24_job?: string    // Work24 직업정보
  work24_djob?: string   // Work24 직업사전
  work24_major?: string  // Work24 학과정보 (new)
}

export interface MajorUniversityInfo {
  department?: string
  name?: string
  universityType?: string
  url?: string
  area?: string        // Phase 1: 지역 (예: "서울특별시")
  campus?: string      // Phase 1: 캠퍼스명 (예: "서울캠퍼스")
}

export interface MajorRecruitmentStat {
  enrollmentQuota?: string
  applicants?: string
  graduates?: string
  universityType?: string
  year?: string
}

export interface UnifiedMajorSummary {
  id: string
  sourceIds: SourceIdentifiers
  name: string
  categoryId?: string
  categoryName?: string
  summary?: string
  aptitude?: string
  relatedMajors?: string[]
  sources: DataSource[]
}

export interface UnifiedMajorDetail extends UnifiedMajorSummary {
  mainSubjects?: string[]
  licenses?: string[]
  universities?: MajorUniversityInfo[]
  recruitmentStatus?: MajorRecruitmentStat[]
  relatedJobs?: string[]
  whatStudy?: string
  howPrepare?: string
  jobProspect?: string
  salaryAfterGraduation?: string
  employmentRate?: string
  
  // Phase 1: CareerNet 학과정보 새 필드들 (44개 필드)
  // 교육 콘텐츠 (우선순위: HIGH)
  relateSubject?: Array<{
    subject_name: string
    subject_description: string
  }>
  careerAct?: Array<{
    act_name: string
    act_description: string
  }>
  mainSubject?: Array<{
    SBJECT_NM: string
    SBJECT_SUMRY: string
  }>
  enterField?: Array<{
    gradeuate: string  // Note: API has typo "gradeuate"
    description: string
  }>
  property?: string
  
  // 통계 데이터 (우선순위: MEDIUM)
  chartData?: {
    applicant?: Array<{name: string, data: string}>
    gender?: Array<{name: string, data: string}>
    employment_rate?: Array<{name: string, data: string}>
    field?: Array<{name: string, data: string}>
    avg_salary?: Array<{name: string, data: string}>
    satisfaction?: Array<{name: string, data: string}>
    after_graduation?: Array<{name: string, data: string}>
  }
  
  // 특성 통계 (우선순위: LOW, 복잡한 중첩 구조)
  genCD?: any        // 성별 통계
  schClass?: any     // 학교 분류 통계
  lstMiddleAptd?: any  // 중학교 적성 리스트
  lstHighAptd?: any    // 고등학교 적성 리스트
  lstVals?: any      // 가치관 리스트
}

export interface EducationDistribution {
  [key: string]: string | undefined
  middleSchoolOrLess?: string
  highSchool?: string
  college?: string
  university?: string
  graduate?: string
  doctor?: string
}

export interface MajorDistribution {
  [key: string]: string | undefined
  humanities?: string
  social?: string
  education?: string
  engineering?: string
  natural?: string
  medical?: string
  artsSports?: string
}

export interface JobRelatedEntity {
  id?: string
  name: string
}

export interface JobOrganizationInfo {
  name: string
  url?: string
}

export interface JobKecoCodeInfo {
  code: string
  name: string
}

export interface UnifiedJobSummary {
  id: string
  sourceIds: SourceIdentifiers
  name: string
  category?: {
    code?: string
    name?: string
  }
  sources: DataSource[]
}

// CareerNet API 상세 배열 타입들
export interface WorkListItem {
  workName?: string
  workDesc?: string
}

export interface PerformEnvironmentItem {
  code?: string
  name?: string
  importance?: number
}

export interface PerformItem {
  code?: string
  name?: string
  importance?: number
}

export interface KnowledgeItem {
  code?: string
  name?: string
  importance?: number
}

export interface PerformList {
  environment?: PerformEnvironmentItem[]
  perform?: PerformItem[]
  knowledge?: KnowledgeItem[]
}

export interface AbilityItem {
  code?: string
  name?: string
  score?: number
}

export interface AptitudeItem {
  code?: string
  name?: string
  score?: number
}

export interface InterestItem {
  code?: string
  name?: string
  score?: number
}

export interface JobReadyItem {
  recruit?: string[]
  certificate?: string[]
  training?: string[]
  curriculum?: string[]
}

export interface ForecastItem {
  period?: string
  outlook?: string
  description?: string
}

export interface IndicatorChartItem {
  category?: string
  value?: number
  description?: string
}

export interface RelVideoItem {
  title?: string
  url?: string
  thumbnail?: string
  duration?: string
}

export interface RelSolItem {
  title?: string
  content?: string
  url?: string
}

export interface ResearchItem {
  title?: string
  author?: string
  date?: string
  url?: string
}

export interface JobWorkSection {
  simple?: WorkListItem[]
  summary?: string
  detailed?: string
}

export interface AbilityDetail {
  simple?: AbilityItem[]
  summary?: string
}

export interface KnowledgeDetail {
  simple?: string
}

export interface EducationDetail {
  simple?: EducationDistribution
}

export interface MajorDetail {
  simple?: JobRelatedEntity[]
}

export interface CareernetOnlyData {
  wlb?: string | null
  social?: string | null
  researchList?: ResearchItem[] | null
  tagList?: Array<string | Record<string, unknown>> | null
  jobReadyList?: JobReadyItem
  licenseAdv?: string | null
  videos?: RelVideoItem[] | null
  performList?: PerformList | null
}

export interface Goyong24OnlyData {
  prospectDetail?: unknown
  prospectChart?: unknown
  personality?: unknown
  interest?: unknown
  values?: unknown
  activity?: unknown
  workEnvironment?: unknown
  entryStatistics?: unknown
}

// Phase 1.2: 추가 타입 정의
export interface EduChartItem {
  name?: string
  data?: string
  source?: string
}

export interface MajorChartItem {
  name?: string
  data?: string
  source?: string
}

export interface JobSumProspectItem {
  jobProspectNm: string
  jobProspectRatio: string
  jobProspectInqYr: string
}

// WORK24_JOB 상세 비교 데이터 타입
export interface AblKnwEnvData {
  jobCd?: string
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

export interface ChrIntrValsData {
  jobCd?: string
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

export interface ActvData {
  jobCd?: string
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

// 히어로 섹션 카테고리 (브레드크럼 또는 단일 값)
export interface HeroCategory {
  type: 'breadcrumb' | 'single'
  large?: string
  medium?: string
  small?: string
  value?: string
}

export interface UnifiedJobDetail extends UnifiedJobSummary {
  classifications?: {
    large?: string
    medium?: string
    small?: string
  }
  summary?: string
  duties?: string
  way?: string
  relatedMajors?: JobRelatedEntity[]
  relatedCertificates?: string[]
  salary?: string
  satisfaction?: string
  prospect?: string
  status?: string
  abilities?: string
  knowledge?: string
  environment?: string
  personality?: string
  interests?: string
  values?: string
  activitiesImportance?: string
  activitiesLevels?: string
  relatedJobs?: JobRelatedEntity[]
  technKnow?: string
  eduLevel?: string
  skillYear?: string
  educationDistribution?: EducationDistribution
  majorDistribution?: MajorDistribution
  relatedOrganizations?: JobOrganizationInfo[]
  kecoCodes?: JobKecoCodeInfo[]
  
  // CareerNet API 확장 필드들
  workList?: WorkListItem[]
  performList?: PerformList
  abilityList?: AbilityItem[]
  aptitudeList?: AptitudeItem[]
  interestList?: InterestItem[]
  jobReadyList?: JobReadyItem
  forecastList?: ForecastItem[]
  indicatorChart?: IndicatorChartItem[]
  relVideoList?: RelVideoItem[]
  relSolList?: RelSolItem[]
  relJinsolList?: RelSolItem[]
  researchList?: ResearchItem[]
  
  // 히어로 섹션 필드들 (템플릿 기반 병합)
  heroCategory?: HeroCategory
  heroTitle?: string
  heroIntro?: string
  heroTags?: string[]
  
  // WORK24_DJOB 특수 필드 (주요 업무 섹션용)
  doWork?: string
  workStrong?: string
  workPlace?: string
  physicalAct?: string
  dJobICdNm?: string | null
  workEnv?: string | null
  similarNm?: string | null
  connectJob?: string | null
  certLic?: string | null
  workSum?: string | null
  aptitude?: string | null
  relatedJobsText?: string | null
  description?: string
  
  // Phase 1.2: CAREERNET 추가 필드
  wlb?: string
  social?: string
  tagList?: string[]
  eduChart?: EduChartItem[]
  majorChart?: MajorChartItem[]
  
  // Phase 1.2: WORK24_JOB 추가 필드
  jobSumProspect?: JobSumProspectItem[]
  ablKnwEnv?: AblKnwEnvData
  chrIntrVals?: ChrIntrValsData
  actv?: ActvData

  // Phase1 structured blocks
  work?: JobWorkSection
  abilitiesDetail?: AbilityDetail
  knowledgeDetail?: KnowledgeDetail
  educationDetail?: EducationDetail
  majorDetail?: MajorDetail

  // Raw-only attachments (for debug/templates)
  careernetOnly?: CareernetOnlyData
  goyong24Only?: Goyong24OnlyData
  
  // ========== ETL 구조화 필드 (Phase 5) ==========
  
  // 개요 탭 구조화 필드
  overviewWork?: {
    main?: string | null
    workStrong?: string | null
    workPlace?: string | null
    physicalAct?: string | null
    workEnv?: string | null
  }
  overviewProspect?: {
    main?: string | ForecastItem[] | null
    forecastList?: ForecastItem[] | null
    jobProspect?: string | null
    jobSumProspect?: JobSumProspectItem[] | null
  }
  overviewAbilities?: {
    abilityList?: AbilityItem[] | null
    technKnow?: string | null
    eduLevel?: string | null
    skillYear?: string | null
  }
  overviewAptitude?: {
    aptitudeList?: AptitudeItem[] | null
    interestList?: InterestItem[] | null
    satisfaction?: {
      value?: string | number | null
      source?: string | null
    } | null
  }
  trivia?: string | string[] | null
  overviewSalary?: {
    sal?: string | null
    wage?: string | null
    wageSource?: string | null
    source?: string | null
  } | null
  
  // 상세정보 탭 구조화 필드
  detailEducation?: {
    majorDistribution?: MajorDistribution | Record<string, string> | null
    educationDistribution?: EducationDistribution | Record<string, string> | null
  }
  detailReady?: {
    recruit?: string[] | null
    certificate?: string[] | null
    training?: string[] | null
    curriculum?: string[] | null
    researchList?: ResearchItem[] | null
  }
  detailWlb?: {
    wlb?: string | null
    social?: string | null
  }
  detailIndicators?: IndicatorChartItem[] | null
  
  // 업무특성 탭 구조화 필드
  charKnowledge?: {
    knowledge?: KnowledgeItem[] | null
    Knwldg?: Array<{ knwldgNm?: string; name?: string }> | null
    source?: string | null
  } | null
  charStatus?: {
    jobActvImprtnc?: Array<{ actvNm?: string; name?: string }> | null
    jobActvImprtncCmpr?: unknown[] | null
    jobActvLvl?: Array<{ actvNm?: string; name?: string }> | null
    jobActvLvlCmpr?: unknown[] | null
  } | null
  charEnvironment?: {
    jobsEnv?: Array<{ envNm?: string; name?: string }> | null
    jobsEnvCmpr?: unknown[] | null
  } | null
  charPerformance?: {
    jobAbil?: unknown[] | null
    perform?: PerformItem[] | null
    source?: string | null
  } | null
  charInterest?: {
    jobIntrst?: Array<{ intrstNm?: string; name?: string }> | null
    jobIntrstCmpr?: unknown[] | null
  } | null
  charValues?: {
    jobVals?: Array<{ valsNm?: string; name?: string }> | null
    jobValsCmpr?: unknown[] | null
  } | null
  
  // 사이드바 구조화 필드
  sidebarJobs?: JobRelatedEntity[] | null
  sidebarMajors?: JobRelatedEntity[] | null
  sidebarOrgs?: JobOrganizationInfo[] | null
  sidebarCerts?: string[] | null
}
