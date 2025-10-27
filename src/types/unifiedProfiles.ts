export type DataSource = 'GOYONG24' | 'CAREERNET'

export interface SourceIdentifiers {
  goyong24?: string
  careernet?: string
}

export interface MajorUniversityInfo {
  department?: string
  name?: string
  universityType?: string
  url?: string
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
}

export interface EducationDistribution {
  middleSchoolOrLess?: string
  highSchool?: string
  college?: string
  university?: string
  graduate?: string
  doctor?: string
}

export interface MajorDistribution {
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
}
