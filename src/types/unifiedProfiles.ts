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
}
