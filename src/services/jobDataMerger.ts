/**
 * Job Data Merger Service
 * 
 * Type A: 동일 데이터 → 병합 (중복 제거)
 * Type B: 유사 데이터 → 우선순위 선택
 * Type C: 보완 데이터 → 계층적 활용 (simple/summary/detailed)
 * Type D: 독립 데이터 → 각자 유지
 */

export interface RawApiData {
  careernet?: any
  goyong24?: any
}

export interface MergedJobData {
  // Type A: 동일 데이터
  jobName: string | null
  classification: {
    large: string | null
    medium: string | null
    small: string | null
  }
  
  // Type B: 유사 데이터 (우선순위 선택)
  salary: {
    primary: string | null
    alternatives: {
      careernet: string | null
      summary: string | null
      detailed: string | null
    }
    source: string | null
  }
  satisfaction: {
    primary: string | null
    alternatives: {
      careernet: string | null
      summary: string | null
      detailed: string | null
    }
    source: string | null
  }
  prospect: {
    primary: any
    alternatives: {
      careernet: any
      summary: string | null
      detailed: string | null
    }
  }
  
  // Type C: 보완 데이터 (계층적)
  work: {
    simple: any // 개요 탭용
    summary: string | null
    detailed: string | null // 상세 탭용
  }
  abilities: {
    simple: any
    summary: string | null
    detailedComparison: {
      withinJob: any
      betweenJobs: any
    }
  }
  knowledge: {
    simple: any
    summary: string | null
    detailedComparison: {
      withinJob: any
      betweenJobs: any
    }
  }
  education: {
    simple: any // 커리어넷: 학력 분포
    summary: string | null // 고용24: 학력 요약
    detailedDistribution: any // 고용24: 학력 분포 상세
  }
  major: {
    simple: any // 커리어넷: 전공 목록
    summary: string | null // 고용24: 전공 요약
    detailedDistribution: any // 고용24: 전공 분포 상세
  }
  
  // Type D: 독립 데이터
  careernetOnly: {
    wlb: string | null // 워라밸 지수
    social: string | null // 사회적 기여도
    researchList: any // 관련 조사/연구
    tagList: any // 태그
    jobReadyList: any // 준비방법
    licenseAdv: string | null // 자격증 유리여부
    videos: any // 관련 동영상
  }
  goyong24Only: {
    prospectDetail: string | null // 전망 상세
    educationDistribution: any // 학력 분포
    majorDistribution: any // 전공 분포
    personality: {
      withinJob: any
      betweenJobs: any
    }
    interest: {
      withinJob: any
      betweenJobs: any
    }
    values: {
      withinJob: any
      betweenJobs: any
    }
    activity: {
      importance: {
        withinJob: any
        betweenJobs: any
      }
      level: {
        withinJob: any
        betweenJobs: any
      }
    }
    workEnvironment: {
      physical: any
      conditions: any
    }
    entryStatistics: any
  }
}

/**
 * Helper: 우선순위에 따라 첫 번째 유효한 값 선택
 */
const selectBestValue = (...values: any[]): any => {
  for (const val of values) {
    if (val !== null && val !== undefined && val !== '' && !(Array.isArray(val) && val.length === 0)) {
      return val
    }
  }
  return null
}

/**
 * 메인 병합 함수
 */
export const mergeJobData = (rawApiData?: RawApiData): MergedJobData => {
  if (!rawApiData) {
    return createEmptyMergedData()
  }

  const careernet = rawApiData.careernet
  const goyong24 = rawApiData.goyong24

  return {
    // 🔴 Type A: 동일 데이터 → 병합 (중복 제거)
    jobName: selectBestValue(
      careernet?.encyclopedia?.baseInfo?.job_nm,
      goyong24?.summary?.jobNm
    ),
    classification: {
      large: selectBestValue(goyong24?.summary?.jobLrclNm),
      medium: selectBestValue(goyong24?.summary?.jobMdclNm),
      small: selectBestValue(goyong24?.summary?.jobSmclNm)
    },

    // 🟡 Type B: 유사 데이터 → 우선순위 선택
    salary: {
      primary: selectBestValue(
        goyong24?.salProspect?.sal,
        goyong24?.summary?.sal,
        careernet?.encyclopedia?.baseInfo?.wage
      ),
      alternatives: {
        careernet: careernet?.encyclopedia?.baseInfo?.wage || null,
        summary: goyong24?.summary?.sal || null,
        detailed: goyong24?.salProspect?.sal || null
      },
      source: careernet?.encyclopedia?.baseInfo?.wage_source || null
    },
    satisfaction: {
      primary: selectBestValue(
        goyong24?.salProspect?.jobSatis,
        goyong24?.summary?.jobSatis,
        careernet?.encyclopedia?.baseInfo?.satisfication
      ),
      alternatives: {
        careernet: careernet?.encyclopedia?.baseInfo?.satisfication || null,
        summary: goyong24?.summary?.jobSatis || null,
        detailed: goyong24?.salProspect?.jobSatis || null
      },
      source: careernet?.encyclopedia?.baseInfo?.satisfi_source || null
    },
    prospect: {
      primary: selectBestValue(
        goyong24?.salProspect?.jobProspect,
        goyong24?.summary?.jobProspect,
        careernet?.encyclopedia?.forecastList
      ),
      alternatives: {
        careernet: careernet?.encyclopedia?.forecastList || null,
        summary: goyong24?.summary?.jobProspect || null,
        detailed: goyong24?.salProspect?.jobProspect || null
      }
    },

    // 🟢 Type C: 보완 데이터 → 계층적 활용
    work: {
      simple: careernet?.encyclopedia?.workList || null, // 개요 탭용
      summary: selectBestValue(goyong24?.summary?.jobSum, goyong24?.duty?.jobSum),
      detailed: goyong24?.duty?.execJob || null // 상세 탭용
    },
    abilities: {
      simple: careernet?.encyclopedia?.abilityList || null,
      summary: goyong24?.summary?.jobAbil || null,
      detailedComparison: {
        importance: {
          withinJob: goyong24?.ablKnwEnv?.jobAbilCmpr || null,
          betweenJobs: goyong24?.ablKnwEnv?.jobAbil || null
        },
        level: {
          withinJob: goyong24?.ablKnwEnv?.jobAbilLvlCmpr || null,
          betweenJobs: goyong24?.ablKnwEnv?.jobAbilLvl || null
        }
      }
    },
    knowledge: {
      simple: careernet?.encyclopedia?.performList?.knowledge || null,
      summary: goyong24?.summary?.knowldg || null,
      detailedComparison: {
        importance: {
          withinJob: goyong24?.ablKnwEnv?.KnwldgCmpr || null,
          betweenJobs: goyong24?.ablKnwEnv?.Knwldg || null
        },
        level: {
          withinJob: goyong24?.ablKnwEnv?.KnwldgLvlCmpr || null,
          betweenJobs: goyong24?.ablKnwEnv?.KnwldgLvl || null
        }
      }
    },
    education: {
      simple: careernet?.encyclopedia?.baseInfo?.education || null,
      summary: goyong24?.summary?.edu || null,
      detailedDistribution: goyong24?.path?.educationDistribution || null
    },
    major: {
      simple: careernet?.encyclopedia?.majorList || null,
      summary: goyong24?.summary?.relMajor || null,
      detailedDistribution: goyong24?.path?.majorDistribution || null
    },

    // 🔵 Type D: 독립 데이터 → 각자 유지
    careernetOnly: {
      wlb: careernet?.encyclopedia?.baseInfo?.wlb || null,
      social: careernet?.encyclopedia?.baseInfo?.social || null,
      researchList: careernet?.encyclopedia?.researchList || null,
      tagList: careernet?.encyclopedia?.tagList || null,
      jobReadyList: careernet?.encyclopedia?.jobReadyList || null,
      licenseAdv: careernet?.encyclopedia?.baseInfo?.licenseAdv || null,
      videos: careernet?.encyclopedia?.relVideoList || null
    },
    goyong24Only: {
      prospectDetail: goyong24?.salProspect?.jobSumProspect || null,
      educationDistribution: goyong24?.path?.educationDistribution || null,
      majorDistribution: goyong24?.path?.majorDistribution || null,
      personality: {
        withinJob: goyong24?.chrIntrVals?.jobChrCmpr || null,
        betweenJobs: goyong24?.chrIntrVals?.jobChr || null
      },
      interest: {
        withinJob: goyong24?.chrIntrVals?.jobIntrstCmpr || null,
        betweenJobs: goyong24?.chrIntrVals?.jobIntrst || null
      },
      values: {
        withinJob: goyong24?.chrIntrVals?.jobValsCmpr || null,
        betweenJobs: goyong24?.chrIntrVals?.jobVals || null
      },
      activity: {
        importance: {
          withinJob: goyong24?.actv?.jobActvImprtncCmpr || null,
          betweenJobs: goyong24?.actv?.jobActvImprtnc || null
        },
        level: {
          withinJob: goyong24?.actv?.jobActvLvlCmpr || null,
          betweenJobs: goyong24?.actv?.jobActvLvl || null
        }
      },
      workEnvironment: {
        comparison: goyong24?.ablKnwEnv?.jobsEnvCmpr || null,
        details: goyong24?.ablKnwEnv?.jobsEnv || null
      },
      entryStatistics: goyong24?.workCond?.entry || null
    }
  }
}

/**
 * 빈 병합 데이터 생성
 */
const createEmptyMergedData = (): MergedJobData => {
  return {
    jobName: null,
    classification: { large: null, medium: null, small: null },
    salary: {
      primary: null,
      alternatives: { careernet: null, summary: null, detailed: null },
      source: null
    },
    satisfaction: {
      primary: null,
      alternatives: { careernet: null, summary: null, detailed: null },
      source: null
    },
    prospect: {
      primary: null,
      alternatives: { careernet: null, summary: null, detailed: null }
    },
    work: { simple: null, summary: null, detailed: null },
    abilities: {
      simple: null,
      summary: null,
      detailedComparison: { withinJob: null, betweenJobs: null }
    },
    knowledge: {
      simple: null,
      summary: null,
      detailedComparison: { withinJob: null, betweenJobs: null }
    },
    education: { simple: null, summary: null, detailedDistribution: null },
    major: { simple: null, summary: null, detailedDistribution: null },
    careernetOnly: {
      wlb: null,
      social: null,
      researchList: null,
      tagList: null,
      jobReadyList: null,
      licenseAdv: null,
      videos: null
    },
    goyong24Only: {
      prospectDetail: null,
      educationDistribution: null,
      majorDistribution: null,
      personality: { withinJob: null, betweenJobs: null },
      interest: { withinJob: null, betweenJobs: null },
      values: { withinJob: null, betweenJobs: null },
      activity: {
        importance: { withinJob: null, betweenJobs: null },
        level: { withinJob: null, betweenJobs: null }
      },
      workEnvironment: { physical: null, conditions: null },
      entryStatistics: null
    }
  }
}
