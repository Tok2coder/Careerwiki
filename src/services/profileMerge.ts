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
  
  // 대학 이름으로만 중복 제거 (학과는 무시)
  const map = new Map<string, MajorUniversityInfo>()
  const insert = (list?: MajorUniversityInfo[]) => {
    list?.forEach((item) => {
      const name = item.name?.trim()
      if (!name) return
      
      // 대학명 정규화 (캠퍼스/분교 제거)
      const normalizedName = normalizeUniversityName(name)
      const key = normalizedName.toLowerCase()
      
      if (!map.has(key)) {
        // 첫 등록: 정규화된 이름 사용
        map.set(key, { ...item, name: normalizedName })
        
        // 디버깅: department 있는지 확인
        if (!item.department) {
          console.log(`⚠️ 첫 등록 시 department 없음: ${normalizedName} (원본: ${name})`)
        }
      } else {
        // 이미 있음: 더 완전한 정보를 가진 것으로 업데이트
        const existing = map.get(key)!
        const merged: MajorUniversityInfo = { ...existing }
        
        // 디버깅: 병합 시 department 업데이트 확인
        if (item.department && !existing.department) {
          console.log(`✅ Department 업데이트: ${normalizedName} ← "${item.department}"`)
        }
        
        // 더 나은 값이 있으면 업데이트 (기존 값도 덮어씀)
        if (item.department) merged.department = item.department
        if (item.universityType) merged.universityType = item.universityType
        if (item.url) merged.url = item.url
        if (item.area) merged.area = item.area
        if (item.campus) merged.campus = item.campus
        
        map.set(key, merged)
      }
    })
  }

  insert(secondary)
  insert(primary)

  if (map.size === 0) return undefined
  
  // 병합 후 처리: area와 universityType 추론
  const result = Array.from(map.values()).map(uni => {
    let enriched = { ...uni }
    
    // area가 없으면 대학명으로 추론
    if (!enriched.area && enriched.name) {
      const inferredArea = inferRegionFromUniversityName(enriched.name)
      if (inferredArea) {
        enriched.area = inferredArea
      }
    }
    
    // universityType이 없으면 기본값 "대학교" 설정
    if (!enriched.universityType) {
      enriched.universityType = '대학교' // 기본값
    }
    
    return enriched
  })
  
  return result
}

// 대학명 정규화 (캠퍼스/분교/prefix 제거)
const normalizeUniversityName = (name: string): string => {
  return name
    // Prefix 제거 (국립, 사립, 공립 등)
    .replace(/^국립\s*/g, '')
    .replace(/^사립\s*/g, '')
    .replace(/^공립\s*/g, '')
    .replace(/^시립\s*/g, '')
    .replace(/^도립\s*/g, '')
    
    // 캠퍼스 패턴 제거
    .replace(/\s*\([^)]*캠퍼스[^)]*\)/g, '')     // (서울캠퍼스), (제2캠퍼스) 등
    .replace(/\s*서울캠퍼스$/g, '')               // 중앙대학교 서울캠퍼스
    .replace(/\s*안성캠퍼스$/g, '')
    .replace(/\s*제\d+캠퍼스$/g, '')              // 제2캠퍼스, 제3캠퍼스 등
    .replace(/\s*미래캠퍼스$/g, '')
    .replace(/\s*국제캠퍼스$/g, '')
    .replace(/\s*WISE\s*캠퍼스$/gi, '')          // WISE 캠퍼스
    
    // 분교 패턴 제거
    .replace(/\s*\(.*분교.*\)/g, '')             // (분교)
    .replace(/\s*분교$/g, '')
    .replace(/\s*본교$/g, '')
    .replace(/\s*\(본교\)$/g, '')
    
    // 특수 케이스
    .replace(/^신경주/g, '경주')                 // 신경주대학교 → 경주대학교
    
    .trim()
}

// 대학명에서 지역 추론 (확장 버전)
const inferRegionFromUniversityName = (name: string): string | undefined => {
  // 우선순위 순으로 매칭 (긴 키워드 먼저)
  const keywords: Array<[string[], string]> = [
    // 특별시/광역시 (최우선)
    [['서울'], '서울'],
    [['부산'], '부산'],
    [['대구'], '대구'],
    [['인천'], '인천'],
    [['광주광역'], '광주'],  // "광주"는 경기 광주시와 충돌 방지
    [['대전'], '대전'],
    [['울산'], '울산'],
    [['세종'], '세종'],
    
    // 강원도 (관동 = 강원)
    [['강원', '관동', '춘천', '강릉', '원주', '동해', '태백', '속초', '삼척'], '강원'],
    
    // 경기도
    [['경기', '수원', '용인', '성남', '고양', '부천', '안산', '안양', '남양주', 
      '화성', '평택', '의정부', '시흥', '파주', '김포', '광명', '군포', '오산', 
      '이천', '양주', '안성', '구리', '포천', '의왕', '하남', '여주', '양평', 
      '동두천', '과천', '가평', '연천'], '경기'],
    
    // 충청북도
    [['충북', '충청북', '청주', '충주', '제천', '음성', '진천', '괴산', '증평', '옥천'], '충북'],
    
    // 충청남도
    [['충남', '충청남', '천안', '공주', '보령', '아산', '서산', '논산', '계룡', 
      '당진', '금산', '부여', '서천', '청양', '홍성', '예산', '태안'], '충남'],
    
    // 전라북도
    [['전북', '전라북', '전주', '군산', '익산', '정읍', '남원', '김제', '완주', '무주'], '전북'],
    
    // 전라남도
    [['전남', '전라남', '목포', '여수', '순천', '나주', '광양', '담양', '곡성', '화순', '영암'], '전남'],
    
    // 경상북도
    [['경북', '경상북', '포항', '경주', '김천', '안동', '구미', '영주', '영천', 
      '상주', '문경', '경산', '군위', '의성', '청송', '영양', '영덕'], '경북'],
    
    // 경상남도
    [['경남', '경상남', '창원', '진주', '통영', '사천', '김해', '밀양', '거제', 
      '양산', '함안', '창녕', '고성', '남해', '하동', '산청', '거창'], '경남'],
    
    // 제주도
    [['제주'], '제주'],
    
    // 마지막으로 "광주" (경기 광주시로 추정)
    [['광주'], '경기']
  ]
  
  for (const [keys, region] of keywords) {
    for (const key of keys) {
      if (name.includes(key)) {
        return region
      }
    }
  }
  
  return undefined
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
