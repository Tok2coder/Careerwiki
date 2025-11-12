import type {
  EducationDistribution,
  JobKecoCodeInfo,
  JobOrganizationInfo,
  JobRelatedEntity,
  MajorRecruitmentStat,
  MajorUniversityInfo,
  SourceIdentifiers,
  UnifiedJobDetail,
  UnifiedMajorDetail
} from '../types/unifiedProfiles'

const mergeSources = (...lists: Array<string[] | undefined>): string[] => {
  const set = new Set<string>()
  lists.forEach((list) => list?.forEach((item) => item && set.add(item)))
  return Array.from(set)
}

const mergeSourceIds = (a?: SourceIdentifiers, b?: SourceIdentifiers): SourceIdentifiers => ({
  goyong24: a?.goyong24 ?? b?.goyong24,
  careernet: a?.careernet ?? b?.careernet
})

const mergeRichText = (...parts: Array<string | undefined>): string | undefined => {
  const unique = Array.from(new Set(parts.map((part) => part?.trim()).filter((part): part is string => !!part)))
  if (unique.length === 0) return undefined
  return unique.join('\n\n')
}

const mergeStringArray = (primary?: string[], secondary?: string[]): string[] | undefined => {
  const set = new Set<string>()
  secondary?.forEach((item) => {
    const value = item?.trim()
    if (value) set.add(value)
  })
  primary?.forEach((item) => {
    const value = item?.trim()
    if (value) set.add(value)
  })
  const merged = Array.from(set)
  return merged.length ? merged : undefined
}

const mergeCertificates = (primary?: string[], secondary?: string[]): string[] | undefined => {
  const all = [...(secondary || []), ...(primary || [])]
  
  const normalized = all.reduce((acc: string[], cert: string) => {
    const trimmed = cert?.trim()
    if (!trimmed) return acc
    
    // 자격증 정규화: 괄호 제거한 기본 이름
    const baseName = trimmed.replace(/\([^)]*\)/g, '').trim()
    
    // 동일한 기본 이름이 이미 있는지 확인
    const existingIndex = acc.findIndex(existing => {
      const existingBase = existing.replace(/\([^)]*\)/g, '').trim()
      return existingBase === baseName
    })
    
    if (existingIndex === -1) {
      // 새로운 자격증 추가
      acc.push(trimmed)
    } else {
      // 기존 것과 비교하여 더 간결한 것 선택
      const existing = acc[existingIndex]
      // 괄호 없는 버전 우선
      if (!trimmed.includes('(') && existing.includes('(')) {
        acc[existingIndex] = trimmed
      }
      // 동일 조건이면 더 짧은 것
      else if (trimmed.length < existing.length && !trimmed.includes('(')) {
        acc[existingIndex] = trimmed
      }
    }
    
    return acc
  }, [])
  
  return normalized.length ? normalized : undefined
}

const mergeRelatedEntities = (
  primary?: JobRelatedEntity[],
  secondary?: JobRelatedEntity[]
): JobRelatedEntity[] | undefined => {
  const map = new Map<string, JobRelatedEntity>()
  const insert = (list?: JobRelatedEntity[]) => {
    list?.forEach((entity) => {
      const name = entity.name?.trim()
      if (!name) return
      // 이름을 키로 사용하여 중복 제거 (ID가 달라도 이름이 같으면 병합)
      const key = name.toLowerCase()
      if (!map.has(key)) {
        map.set(key, { ...entity, name })
      } else {
        const existing = map.get(key)!
        // ID가 있는 것을 우선 사용
        const mergedId = entity.id?.trim() || existing.id
        map.set(key, { ...existing, ...entity, name, id: mergedId })
      }
    })
  }

  insert(secondary)
  insert(primary)

  if (map.size === 0) return undefined
  return Array.from(map.values())
}

const mergeUniversities = (
  primary?: MajorUniversityInfo[],
  secondary?: MajorUniversityInfo[]
): MajorUniversityInfo[] | undefined => {
  const map = new Map<string, MajorUniversityInfo>()
  const insert = (list?: MajorUniversityInfo[]) => {
    list?.forEach((item) => {
      const name = item.name?.trim()
      const department = item.department?.trim()
      if (!name && !department) return
      const key = `${(name || '').toLowerCase()}::${(department || '').toLowerCase()}`
      if (!map.has(key)) {
        map.set(key, { ...item, name, department })
      } else {
        const existing = map.get(key)!
        map.set(key, { ...existing, ...item, name, department })
      }
    })
  }

  insert(secondary)
  insert(primary)

  if (map.size === 0) return undefined
  return Array.from(map.values())
}

const mergeRecruitment = (
  primary?: MajorRecruitmentStat[],
  secondary?: MajorRecruitmentStat[]
): MajorRecruitmentStat[] | undefined => {
  const map = new Map<string, MajorRecruitmentStat>()
  const insert = (list?: MajorRecruitmentStat[]) => {
    list?.forEach((item) => {
      const key = `${item.year ?? ''}::${item.universityType ?? ''}`
      if (!map.has(key)) {
        map.set(key, { ...item })
      } else {
        const existing = map.get(key)!
        map.set(key, { ...existing, ...item })
      }
    })
  }

  insert(secondary)
  insert(primary)

  if (map.size === 0) return undefined
  return Array.from(map.values())
}

const mergeOrganizations = (
  primary?: JobOrganizationInfo[],
  secondary?: JobOrganizationInfo[]
): JobOrganizationInfo[] | undefined => {
  const map = new Map<string, JobOrganizationInfo>()
  const insert = (list?: JobOrganizationInfo[]) => {
    list?.forEach((item) => {
      const name = item.name?.trim()
      if (!name) return
      const key = (item.url?.trim() || '').toLowerCase() || name.toLowerCase()
      if (!map.has(key)) {
        map.set(key, { ...item, name })
      } else {
        const existing = map.get(key)!
        map.set(key, { ...existing, ...item, name })
      }
    })
  }

  insert(secondary)
  insert(primary)

  if (map.size === 0) return undefined
  return Array.from(map.values())
}

const mergeKecoCodes = (
  primary?: JobKecoCodeInfo[],
  secondary?: JobKecoCodeInfo[]
): JobKecoCodeInfo[] | undefined => {
  const map = new Map<string, JobKecoCodeInfo>()
  const insert = (list?: JobKecoCodeInfo[]) => {
    list?.forEach((item) => {
      const code = item.code?.trim()
      const name = item.name?.trim()
      if (!code && !name) return
      const key = code || name
      if (!map.has(key)) {
        map.set(key, { ...item, code, name })
      } else {
        const existing = map.get(key)!
        map.set(key, { ...existing, ...item, code, name })
      }
    })
  }

  insert(secondary)
  insert(primary)

  if (map.size === 0) return undefined
  return Array.from(map.values())
}

const mergeDistribution = <T extends Record<string, string | undefined>>(
  primary?: T,
  secondary?: T
): T | undefined => {
  if (!primary && !secondary) return undefined
  return {
    ...(secondary ?? {}),
    ...(primary ?? {})
  }
}

export const mergeMajorProfiles = (
  goyong?: UnifiedMajorDetail,
  careernet?: UnifiedMajorDetail
): UnifiedMajorDetail | null => {
  if (!goyong && !careernet) {
    return null
  }

  const base = goyong ?? careernet!
  const merged: UnifiedMajorDetail = {
    ...base,
    id: goyong?.id ?? careernet!.id,
    sourceIds: mergeSourceIds(goyong?.sourceIds, careernet?.sourceIds),
    sources: mergeSources(goyong?.sources, careernet?.sources),
    name: goyong?.name ?? careernet?.name ?? base.name,
    categoryId: goyong?.categoryId ?? careernet?.categoryId,
    categoryName: goyong?.categoryName ?? careernet?.categoryName,
    summary: mergeRichText(careernet?.summary, goyong?.summary),
    aptitude: goyong?.aptitude ?? careernet?.aptitude,
    relatedMajors: mergeStringArray(goyong?.relatedMajors, careernet?.relatedMajors),
    mainSubjects: mergeStringArray(goyong?.mainSubjects, careernet?.mainSubjects),
    licenses: mergeStringArray(goyong?.licenses, careernet?.licenses),
    universities: mergeUniversities(goyong?.universities, careernet?.universities),
    recruitmentStatus: mergeRecruitment(goyong?.recruitmentStatus, careernet?.recruitmentStatus),
    relatedJobs: mergeStringArray(goyong?.relatedJobs, careernet?.relatedJobs),
    whatStudy: goyong?.whatStudy ?? careernet?.whatStudy,
    howPrepare: goyong?.howPrepare ?? careernet?.howPrepare,
    jobProspect: mergeRichText(careernet?.jobProspect, goyong?.jobProspect),
    salaryAfterGraduation: goyong?.salaryAfterGraduation ?? careernet?.salaryAfterGraduation,
    employmentRate: goyong?.employmentRate ?? careernet?.employmentRate,
    // 🔧 Phase 1 필드 병합 추가 (mainSubject, relateSubject, careerAct, enterField, property)
    mainSubject: (careernet as any)?.mainSubject ?? (goyong as any)?.mainSubject ?? (careernet as any)?.main_subject ?? (goyong as any)?.main_subject,
    relateSubject: (careernet as any)?.relateSubject ?? (goyong as any)?.relateSubject ?? (careernet as any)?.relate_subject ?? (goyong as any)?.relate_subject,
    careerAct: (careernet as any)?.careerAct ?? (goyong as any)?.careerAct ?? (careernet as any)?.career_act ?? (goyong as any)?.career_act,
    enterField: (careernet as any)?.enterField ?? (goyong as any)?.enterField ?? (careernet as any)?.enter_field ?? (goyong as any)?.enter_field,
    property: (careernet as any)?.property ?? (goyong as any)?.property
  }

  return merged
}

export const mergeJobProfiles = (
  goyong?: UnifiedJobDetail,
  careernet?: UnifiedJobDetail
): UnifiedJobDetail | null => {
  if (!goyong && !careernet) {
    return null
  }

  const base = goyong ?? careernet!
  const merged: UnifiedJobDetail = {
    ...base,
    id: goyong?.id ?? careernet!.id,
    sourceIds: mergeSourceIds(goyong?.sourceIds, careernet?.sourceIds),
    sources: mergeSources(goyong?.sources, careernet?.sources),
    name: goyong?.name ?? careernet?.name ?? base.name,  // 🆕 고용24 우선 (기존: careernet 우선)
    category: {
      code: goyong?.category?.code ?? careernet?.category?.code,
      name: goyong?.category?.name ?? careernet?.category?.name
    },
    classifications: {
      large: goyong?.classifications?.large ?? careernet?.classifications?.large,
      medium: goyong?.classifications?.medium ?? careernet?.classifications?.medium,
      small: goyong?.classifications?.small ?? careernet?.classifications?.small
    },
    summary: mergeRichText(careernet?.summary, goyong?.summary),
    duties: goyong?.duties ?? careernet?.duties,
    way: goyong?.way ?? careernet?.way,
    relatedMajors: mergeRelatedEntities(goyong?.relatedMajors, careernet?.relatedMajors),
    relatedCertificates: mergeCertificates(goyong?.relatedCertificates, careernet?.relatedCertificates),
    salary: goyong?.salary ?? careernet?.salary,
    satisfaction: goyong?.satisfaction ?? careernet?.satisfaction,
    prospect: goyong?.prospect ?? careernet?.prospect,
    status: goyong?.status ?? careernet?.status,
    abilities: goyong?.abilities ?? careernet?.abilities,
    knowledge: goyong?.knowledge ?? careernet?.knowledge,
    environment: goyong?.environment ?? careernet?.environment,
    personality: goyong?.personality ?? careernet?.personality,
    interests: goyong?.interests ?? careernet?.interests,
    values: goyong?.values ?? careernet?.values,
    activitiesImportance: goyong?.activitiesImportance ?? careernet?.activitiesImportance,
    activitiesLevels: goyong?.activitiesLevels ?? careernet?.activitiesLevels,
    relatedJobs: mergeRelatedEntities(goyong?.relatedJobs, careernet?.relatedJobs),
    technKnow: goyong?.technKnow ?? careernet?.technKnow,
    educationDistribution: mergeDistribution<EducationDistribution>(
      goyong?.educationDistribution,
      careernet?.educationDistribution
    ),
    majorDistribution: mergeDistribution<MajorDistribution>(
      goyong?.majorDistribution,
      careernet?.majorDistribution
    ),
    relatedOrganizations: mergeOrganizations(goyong?.relatedOrganizations, careernet?.relatedOrganizations),
    kecoCodes: mergeKecoCodes(goyong?.kecoCodes, careernet?.kecoCodes)
  }

  return merged
}
