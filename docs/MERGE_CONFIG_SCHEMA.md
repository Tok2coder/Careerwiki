# 병합 규칙 JSON 스키마

ETL에서 사용할 병합 규칙을 정의하는 JSON 스키마입니다.

## 스키마 구조

```typescript
interface MergeConfig {
  version: string                    // 스키마 버전 (예: "1.0")
  exportedAt?: string                // 내보내기 시각 (ISO 8601)
  
  // 템플릿 섹션별 필드 설정
  sections: {
    hero: SectionConfig              // 히어로 섹션
    overview: SectionConfig          // 개요 탭
    details: SectionConfig           // 상세정보 탭
    characteristics: SectionConfig   // 업무특성 탭
    sidebar: SectionConfig           // 사이드바
  }
  
  // 전역 우선순위 설정 (섹션별 설정이 없으면 이 값 사용)
  defaultPriority: SourcePriority
  
  // 제외할 필드 목록
  excludedFields: string[]
}

interface SectionConfig {
  enabled: boolean                   // 섹션 활성화 여부
  fields: FieldConfig[]              // 섹션 내 필드 설정
}

interface FieldConfig {
  id: string                         // 필드 식별자 (예: "summary", "duties")
  label: string                      // 표시 라벨 (예: "직업 소개")
  enabled: boolean                   // 필드 활성화 여부
  priority: SourcePriority           // 우선순위 설정
  sources: {
    CAREERNET?: SourceFieldConfig
    WORK24_JOB?: SourceFieldConfig
    WORK24_DJOB?: SourceFieldConfig
  }
  fallbackChain?: string[]           // 폴백 순서 (예: ["CAREERNET", "WORK24_JOB"])
  mergeStrategy?: MergeStrategy      // 병합 전략
}

interface SourceFieldConfig {
  enabled: boolean                   // 이 소스 사용 여부
  paths: string[]                    // 데이터 경로 (예: ["summary", "encyclopedia.workList"])
  transform?: TransformConfig        // 데이터 변환 설정
}

type SourcePriority = 
  | 'CAREERNET_FIRST'                // 커리어넷 우선
  | 'WORK24_JOB_FIRST'               // 고용24 직업정보 우선
  | 'WORK24_DJOB_FIRST'              // 고용24 직업사전 우선
  | 'MERGE_ALL'                      // 모든 소스 병합

type MergeStrategy =
  | 'FIRST_NON_EMPTY'                // 첫 번째 비어있지 않은 값 사용
  | 'CONCATENATE'                    // 모든 값 연결
  | 'ARRAY_MERGE'                    // 배열 병합 (중복 제거)
  | 'OBJECT_MERGE'                   // 객체 병합

interface TransformConfig {
  type: 'STRING' | 'ARRAY' | 'OBJECT'
  trim?: boolean                     // 문자열 앞뒤 공백 제거
  removeBrackets?: boolean           // 대괄호 제거 (예: "[J602]텔레비전 방송업")
  dedupe?: boolean                   // 중복 제거
  maxLength?: number                 // 최대 길이
}
```

## 예시 설정

```json
{
  "version": "1.0",
  "defaultPriority": "CAREERNET_FIRST",
  "excludedFields": [],
  "sections": {
    "hero": {
      "enabled": true,
      "fields": [
        {
          "id": "heroTitle",
          "label": "직업명",
          "enabled": true,
          "priority": "CAREERNET_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["name", "encyclopedia.baseInfo.job_nm"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["name", "summary.jobNm"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["name", "dJobNm"]
            }
          },
          "fallbackChain": ["CAREERNET", "WORK24_JOB", "WORK24_DJOB"],
          "mergeStrategy": "FIRST_NON_EMPTY"
        },
        {
          "id": "heroIntro",
          "label": "직업 소개",
          "enabled": true,
          "priority": "CAREERNET_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["summary", "encyclopedia.workList"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["summary", "duty.jobSum", "summary.way"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["workSum", "jobDefiSumryCont"]
            }
          },
          "fallbackChain": ["CAREERNET", "WORK24_JOB", "WORK24_DJOB"],
          "mergeStrategy": "FIRST_NON_EMPTY"
        },
        {
          "id": "heroCategory",
          "label": "카테고리",
          "enabled": true,
          "priority": "WORK24_JOB_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["classifications.large", "encyclopedia.baseInfo.aptit_name"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["classifications.large", "summary.jobLrclNm"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["dJobICdNm"],
              "transform": {
                "type": "STRING",
                "removeBrackets": true,
                "trim": true
              }
            }
          },
          "mergeStrategy": "FIRST_NON_EMPTY"
        },
        {
          "id": "heroTags",
          "label": "태그",
          "enabled": true,
          "priority": "MERGE_ALL",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["tagList", "encyclopedia.tagList"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["similarNm", "connectJob"]
            }
          },
          "mergeStrategy": "ARRAY_MERGE"
        }
      ]
    },
    "overview": {
      "enabled": true,
      "fields": [
        {
          "id": "workMainDesc",
          "label": "주요 업무",
          "enabled": true,
          "priority": "CAREERNET_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["summary", "duties", "encyclopedia.workList"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["duties", "duty.execJob"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["doWork", "reprDutyCont"]
            }
          },
          "mergeStrategy": "FIRST_NON_EMPTY"
        },
        {
          "id": "workMetaCards",
          "label": "업무 메타 카드 (작업강도, 작업장소)",
          "enabled": true,
          "priority": "WORK24_DJOB_FIRST",
          "sources": {
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["workStrong", "workPlace", "physicalAct"]
            }
          }
        },
        {
          "id": "prospect",
          "label": "커리어 전망",
          "enabled": true,
          "priority": "CAREERNET_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["prospect", "forecastList"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["prospect", "salProspect.jobProspect", "jobSumProspect"]
            }
          }
        },
        {
          "id": "salary",
          "label": "임금 정보",
          "enabled": true,
          "priority": "WORK24_JOB_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["salary", "encyclopedia.baseInfo.wage"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["salary", "salProspect.sal", "summary.sal"]
            }
          }
        },
        {
          "id": "abilities",
          "label": "핵심 역량",
          "enabled": true,
          "priority": "CAREERNET_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["abilities", "abilityList"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["abilities", "summary.jobAbil"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["abilities", "needAbilCont"]
            }
          }
        },
        {
          "id": "aptitude",
          "label": "적성 및 흥미",
          "enabled": true,
          "priority": "CAREERNET_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["personality", "interests", "aptitudeList", "interestList"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["personality", "interests", "summary.jobChr", "summary.jobIntrst"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["personality", "interests", "jobChrCont", "jobIntrstCont"]
            }
          }
        }
      ]
    },
    "details": {
      "enabled": true,
      "fields": [
        {
          "id": "educationDistribution",
          "label": "학력 분포",
          "enabled": true,
          "priority": "WORK24_JOB_FIRST",
          "sources": {
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["educationDistribution", "path.edubg"]
            }
          }
        },
        {
          "id": "majorDistribution",
          "label": "전공 분포",
          "enabled": true,
          "priority": "WORK24_JOB_FIRST",
          "sources": {
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["majorDistribution", "path.schDpt"]
            }
          }
        },
        {
          "id": "indicatorChart",
          "label": "한국의 직업지표",
          "enabled": true,
          "priority": "CAREERNET_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["indicatorChart", "encyclopedia.indicatorChart"]
            }
          }
        },
        {
          "id": "wlbSocial",
          "label": "워라밸 & 사회적 평가",
          "enabled": true,
          "priority": "CAREERNET_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["wlb", "social", "encyclopedia.baseInfo.wlb", "encyclopedia.baseInfo.social"]
            }
          }
        },
        {
          "id": "jobReadyList",
          "label": "직업 준비하기",
          "enabled": true,
          "priority": "CAREERNET_FIRST",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["jobReadyList", "encyclopedia.jobReadyList"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["technKnow", "path.technKnow"]
            }
          }
        }
      ]
    },
    "characteristics": {
      "enabled": true,
      "fields": [
        {
          "id": "knowledge",
          "label": "필수 지식",
          "enabled": true,
          "priority": "MERGE_ALL",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["knowledge", "performList.knowledge"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["knowledge", "ablKnwEnv.Knwldg"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["knowledge", "needKnowlgCont"]
            }
          },
          "mergeStrategy": "ARRAY_MERGE"
        },
        {
          "id": "environment",
          "label": "근무 환경",
          "enabled": true,
          "priority": "MERGE_ALL",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["environment", "performList.environment"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["environment", "ablKnwEnv.jobsEnv"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["environment", "jobWorkEnvCont"]
            }
          }
        },
        {
          "id": "chrIntrVals",
          "label": "성격/흥미/가치관 비교",
          "enabled": true,
          "priority": "WORK24_JOB_FIRST",
          "sources": {
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["chrIntrVals"]
            }
          }
        },
        {
          "id": "actv",
          "label": "업무활동 분석",
          "enabled": true,
          "priority": "WORK24_JOB_FIRST",
          "sources": {
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["actv"]
            }
          }
        }
      ]
    },
    "sidebar": {
      "enabled": true,
      "fields": [
        {
          "id": "relatedJobs",
          "label": "연관 직업",
          "enabled": true,
          "priority": "MERGE_ALL",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["relatedJobs"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["relatedJobs", "summary.relJobList", "duty.relJobList"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["relatedJobs", "relJobList"]
            }
          },
          "mergeStrategy": "ARRAY_MERGE"
        },
        {
          "id": "relatedMajors",
          "label": "관련 전공",
          "enabled": true,
          "priority": "MERGE_ALL",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["relatedMajors"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["relatedMajors", "summary.relMajorList", "path.relMajorList"]
            }
          },
          "mergeStrategy": "ARRAY_MERGE"
        },
        {
          "id": "relatedOrganizations",
          "label": "관련 기관",
          "enabled": true,
          "priority": "MERGE_ALL",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["relatedOrganizations", "encyclopedia.jobRelOrgList"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["relatedOrganizations", "path.relOrgList"]
            }
          },
          "mergeStrategy": "ARRAY_MERGE"
        },
        {
          "id": "relatedCertificates",
          "label": "추천 자격증",
          "enabled": true,
          "priority": "MERGE_ALL",
          "sources": {
            "CAREERNET": {
              "enabled": true,
              "paths": ["relatedCertificates", "encyclopedia.certiList"]
            },
            "WORK24_JOB": {
              "enabled": true,
              "paths": ["relatedCertificates", "summary.relCertList", "path.relCertList"]
            },
            "WORK24_DJOB": {
              "enabled": true,
              "paths": ["relatedCertificates", "relCertNmCont", "certLic"]
            }
          },
          "mergeStrategy": "ARRAY_MERGE"
        }
      ]
    }
  }
}
```

## 사용법

### 1. 설정 파일 생성
- `job-template-design2` 페이지에서 필드 설정 후 "규칙 내보내기" 버튼 클릭
- 또는 위 스키마에 따라 직접 JSON 파일 작성

### 2. ETL에서 설정 적용
```typescript
// src/scripts/etl/mergeJobProfiles.ts
import mergeConfig from '../../config/merge-config.json'

function applyMergeConfig(parsedSources: ParsedSource[], config: MergeConfig) {
  const merged: Partial<UnifiedJobDetail> = {}
  
  for (const section of Object.values(config.sections)) {
    if (!section.enabled) continue
    
    for (const field of section.fields) {
      if (!field.enabled) continue
      
      const value = mergeFieldWithConfig(parsedSources, field)
      if (value !== null && value !== undefined) {
        merged[field.id] = value
      }
    }
  }
  
  return merged
}
```

### 3. 설정 검증
- 스키마 버전 확인
- 필수 필드 존재 여부 확인
- 경로 유효성 검증

## 다음 단계

Phase 3에서 정우님이 이 설정을 검토하고 필요한 수정을 합니다.
그 후 Phase 4에서 ETL에 설정 적용 로직을 구현합니다.

