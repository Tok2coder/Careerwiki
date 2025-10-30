# 필드 병합 규칙 (Field Merge Rules)

## 📋 병합 규칙 분류

### 🔴 타입 A: 동일 데이터 - 병합 필요 (중복 제거)
**규칙:** 같은 섹션 내에서 같은 의미, 같은 값 → 하나만 선택

#### A-1. 직업 코드 (jobCd)
**병합 대상:**
- `summary.jobCd`
- `duty.jobCd`
- `path.jobCd`
- `salProspect.jobCd`
- `ablKnwEnv.jobCd`
- `chrIntrVals.jobCd`
- `actv.jobCd`

**병합 결과:** `jobCd` (하나만)
**값:** `K000007482` (모두 동일)
**판단:** ✅ 병합 - 사용자에게 보여줄 필요 없음 (내부 ID)

#### A-2. 직업 분류 (대/중/소분류)
**병합 대상:**
- `summary.jobLrclNm/jobMdclNm/jobSmclNm`
- `salProspect.jobLrclNm/jobMdclNm/jobSmclNm`
- `ablKnwEnv.jobLrclNm/jobMdclNm/jobSmclNm`
- `chrIntrVals.jobLrclNm/jobMdclNm/jobSmclNm`
- `actv.jobLrclNm/jobMdclNm/jobSmclNm`
- `duty.jobLrclNm/jobMdclNm/jobSmclNm`

**병합 결과:** `classification { large, medium, small }` (하나만)
**값 예시:** 
- 대분류: "법률·경찰·소방·교도·국방"
- 중분류: "법률"
- 소분류: "변호사"

**판단:** ✅ 병합 - 모든 섹션에서 동일한 값

---

### 🟡 타입 B: 유사 데이터 - 우선순위 선택
**규칙:** 같은 의미이지만 출처가 다름 → 품질/최신성 기준 선택

#### B-1. 직업명
**비교 대상:**
- `encyclopedia.baseInfo.job_nm` → "변호사"
- `summary.jobNm` → "변호사"

**판단:** 🔸 별도 취급
- `encyclopedia.baseInfo.job_nm` → 커리어넷 직업 명칭
- `summary.jobSmclNm` → 고용24 소분류명 (우연히 같은 값)
- **의미가 다름**: 하나는 "직업명", 하나는 "직업 소분류"
- **결론:** ❌ 병합 안함 - 둘 다 유지

#### B-2. 임금
**비교 대상:**
- `encyclopedia.baseInfo.wage` → 4,800만원 (오래된 데이터)
- `summary.sal` → "상위 25%: 5,500만원, 하위 25%: 4,000만원"
- `salProspect.sal` → "상위 25%: 5,500만원, 하위 25%: 4,000만원, 중위값: 5,000만원"

**판단:** ✅ 우선순위 선택
1. `salProspect.sal` (최우선 - 가장 상세, 최신)
2. `summary.sal` (보조)
3. `encyclopedia.baseInfo.wage` (폴백)

**병합 결과:** `salary { primary, secondary, tertiary }`

#### B-3. 직업만족도
**비교 대상:**
- `encyclopedia.baseInfo.satisfication` → 75 (%)
- `summary.jobSatis` → "높음"
- `salProspect.jobSatis` → "만족도 75%, 업무강도 중간"

**판단:** ✅ 우선순위 선택
1. `salProspect.jobSatis` (최우선 - 가장 상세)
2. `summary.jobSatis` (보조)
3. `encyclopedia.baseInfo.satisfication` (폴백)

#### B-4. 전망
**비교 대상:**
- `encyclopedia.forecastList` → ["인공지능 발전으로...", "법률 수요 증가..."]
- `summary.jobProspect` → "증가"
- `salProspect.jobProspect` → "다소 증가 (향후 10년)"

**판단:** ✅ 우선순위 선택
1. `salProspect.jobProspect` (최우선 - 최신, 기간 명시)
2. `summary.jobProspect` (보조)
3. `encyclopedia.forecastList` (상세 설명용)

---

### 🟢 타입 C: 보완 데이터 - 병합 표시
**규칙:** 서로 다른 관점/상세도 → 둘 다 활용

#### C-1. 하는 일 / 수행 직무
**비교 대상:**
- `encyclopedia.workList` → ["법률 자문을 제공한다", "소송을 수행한다", ...] (5개, 친화적)
- `summary.jobSum` → "의뢰인의 법률 문제를 해결하고..." (1개, 요약)
- `duty.execJob` → [{execJobNm: "법률 자문", execJobCont: "..."}, ...] (10개, 상세)

**판단:** ✅ 모두 활용 - 보완 관계
- **개요 탭**: `encyclopedia.workList` (친화적, 간결)
- **상세정보 탭 - 직무 정보**:
  - 주요 업무: `encyclopedia.workList`
  - 상세 직무: `duty.execJob` (더 전문적, 상세)
  - 요약: `summary.jobSum`

#### C-2. 능력 / 지식
**비교 대상:**
- `encyclopedia.abilityList` → ["문제해결능력", "의사소통능력"] (간단)
- `summary.jobAbil` → "법률지식, 논리력, 판단력..."
- `ablKnwEnv.jobAbilCmpr` → [{jobAblNmCmpr: "법률지식", jobAblContCmpr: "...", 점수}] (10개, 비교)

**판단:** ✅ 모두 활용 - 상세도 차이
- **개요 탭**: `encyclopedia.abilityList` (간단)
- **상세정보 탭 - 능력**:
  - 간단: `encyclopedia.abilityList`
  - 요약: `summary.jobAbil`
  - 상세 분석: `ablKnwEnv.jobAbilCmpr` (직업내 비교)
  - 상세 분석: `ablKnwEnv.jobAbil` (직업간 비교)

#### C-3. 관련 자격증
**비교 대상:**
- `encyclopedia.certiList` → ["변호사", "법무사", ...]
- `summary.relCertList` → ["변호사", "법학전문박사"]
- `path.relCertList` → ["변호사"]

**판단:** ✅ 병합 후 중복 제거
- **병합 방법**: 세 소스 합치고 → 중복 제거 → 정렬
- **결과**: `certificates = unique([...encyclopedia, ...summary, ...path])`

#### C-4. 관련 학과 / 전공
**비교 대상:**
- `encyclopedia.departList` → ["법학과", "법학전문대학원", ...] (학과 중심)
- `summary.relMajorList` → [{majorCd, majorNm: "법학"}] (전공 코드)
- `path.relMajorList` → [{majorCd, majorNm: "법학"}]

**판단:** ✅ 병합 후 중복 제거
- **커리어넷**: 학과명 (더 상세, 교육적)
- **고용24**: 전공명 + 코드 (표준화)
- **병합 방법**: 커리어넷 주 + 고용24 보조 (중복 제거)

---

### 🔵 타입 D: 독립 데이터 - 각자 유지
**규칙:** 완전히 다른 정보 → 모두 표시

#### D-1. 커리어넷 전용
- `encyclopedia.baseInfo.wlb` → 워라밸
- `encyclopedia.baseInfo.social` → 사회적 평가
- `encyclopedia.relVideoList` → 관련 동영상
- `encyclopedia.researchList` → 진로탐색
- `encyclopedia.tagList` → 태그
- `encyclopedia.jobReadyList` → 직업준비

**판단:** ✅ 유지 - 커리어넷만의 고유 정보

#### D-2. 고용24 전용 (상세 분석)
- `salProspect.jobSumProspect` → 전망 상세 분석
- `salProspect.jobStatusList` → 일자리 현황
- `ablKnwEnv.jobAbilCmpr/jobAbil` → 능력 비교 (직업내/직업간)
- `ablKnwEnv.KnwldgCmpr/Knwldg` → 지식 비교
- `ablKnwEnv.jobsEnvCmpr/jobsEnv` → 업무환경 비교
- `chrIntrVals.*` → 성격/흥미/가치관 비교
- `actv.*` → 업무활동 중요도/수준 비교
- `path.educationDistribution` → 학력 분포 통계
- `path.majorDistribution` → 전공 분포 통계
- `path.technKnow` → 필수 기술 및 지식
- `path.kecoList` → 한국고용직업분류

**판단:** ✅ 유지 - 고용24만의 전문 통계/분석 데이터

---

## 🎯 병합 전략 - 최종 제안

### 전략 1: 계층적 병합 (Hierarchical Merge)

**핵심 원칙:**
1. **같은 값** → 병합 (중복 제거)
2. **같은 의미, 다른 값** → 우선순위 선택 (최신/상세 우선)
3. **다른 상세도** → 모두 활용 (보완)
4. **독립 정보** → 각자 유지

### 병합 프로세스

#### Step 1: 메타데이터 통합
```typescript
// 병합 필요 - 중복 제거
{
  jobCode: "K000007482",  // 모든 섹션의 jobCd 병합
  classification: {
    large: "법률·경찰·소방·교도·국방",
    medium: "법률",
    small: "변호사"
  }  // 모든 섹션의 분류 병합
}
```

#### Step 2: 핵심 필드 우선순위 선택
```typescript
{
  jobName: {
    value: goyong24.summary.jobNm || encyclopedia.baseInfo.job_nm,
    source: "goyong24" // 우선순위 표시
  },
  
  salary: {
    primary: salProspect.sal,      // "상위 25%: 5,500만원, 중위값: 5,000만원"
    secondary: summary.sal,         // "상위 25%: 5,500만원"
    fallback: encyclopedia.wage,    // 4,800만원
    display: salProspect.sal || summary.sal || encyclopedia.wage
  },
  
  satisfaction: {
    primary: salProspect.jobSatis,
    secondary: summary.jobSatis,
    fallback: encyclopedia.satisfication,
    display: salProspect.jobSatis || summary.jobSatis || encyclopedia.satisfication
  },
  
  prospect: {
    primary: salProspect.jobProspect,  // "다소 증가 (향후 10년)"
    secondary: summary.jobProspect,     // "증가"
    detail: encyclopedia.forecastList,  // 상세 설명
    display: salProspect.jobProspect || summary.jobProspect
  }
}
```

#### Step 3: 보완 데이터 병합
```typescript
{
  // 하는 일 - 모두 활용
  workDescription: {
    simple: encyclopedia.workList,     // 개요용 (친화적)
    summary: summary.jobSum,           // 요약
    detailed: duty.execJob             // 상세정보용 (전문적)
  },
  
  // 능력 - 계층적 표시
  abilities: {
    simple: encyclopedia.abilityList,          // 간단 리스트
    summary: summary.jobAbil,                  // 요약
    detailedComparison: {
      withinJob: ablKnwEnv.jobAbilCmpr,       // 직업내 비교
      betweenJobs: ablKnwEnv.jobAbil          // 직업간 비교
    }
  },
  
  // 자격증 - 병합 후 중복 제거
  certificates: unique([
    ...encyclopedia.certiList,
    ...summary.relCertList.map(c => c.certNm),
    ...path.relCertList
  ]),
  
  // 학과/전공 - 병합 후 중복 제거
  majors: {
    departments: encyclopedia.departList,  // 학과 (상세)
    majors: unique([
      ...summary.relMajorList,
      ...path.relMajorList
    ])  // 전공 (표준)
  }
}
```

#### Step 4: 독립 데이터 유지
```typescript
{
  // 커리어넷 전용
  careernetOnly: {
    workLifeBalance: encyclopedia.baseInfo.wlb,
    socialReputation: encyclopedia.baseInfo.social,
    relatedVideos: encyclopedia.relVideoList,
    careerResearch: encyclopedia.researchList,
    tags: encyclopedia.tagList,
    jobPreparation: encyclopedia.jobReadyList
  },
  
  // 고용24 전용
  goyong24Only: {
    salaryDetail: salProspect,
    educationStats: path.educationDistribution,
    majorStats: path.majorDistribution,
    technicalKnowledge: path.technKnow,
    kecoClassification: path.kecoList,
    detailedAnalysis: {
      abilities: ablKnwEnv,
      personality: chrIntrVals,
      workActivities: actv
    }
  }
}
```

---

## 📊 최종 데이터 구조 제안

### 개요 탭 (Overview)
```typescript
interface JobOverview {
  // 기본 정보
  jobCode: string                    // 병합 (내부용)
  jobName: string                    // 우선순위 선택
  classification: {
    large: string
    medium: string
    small: string
  }                                  // 병합
  
  // 핵심 지표
  salary: string                     // 우선순위 선택 (salProspect > summary > encyclopedia)
  satisfaction: string               // 우선순위 선택
  workLifeBalance?: string           // 커리어넷 전용
  socialReputation?: string          // 커리어넷 전용
  prospect: string                   // 우선순위 선택
  
  // 주요 설명
  workDescription: string[]          // encyclopedia.workList (간단, 친화적)
}
```

### 상세정보 탭 (Detailed Info)
```typescript
interface JobDetail {
  // 1. 직무 정보
  work: {
    main: string[]                   // encyclopedia.workList
    summary: string                  // summary.jobSum
    detailed: Array<{
      name: string
      content: string
    }>                               // duty.execJob
    howToBecome: string              // summary.way
  }
  
  // 2. 임금 & 전망
  salaryAndProspect: {
    salary: {
      value: string
      source: 'salProspect' | 'summary' | 'encyclopedia'
      alternatives?: string[]        // 다른 소스들
    }
    satisfaction: {...}              // 동일 구조
    prospect: {
      value: string
      detail: string[]               // encyclopedia.forecastList
      futureOutlook: Array<{
        name: string
        ratio: string
        year: string
      }>                             // salProspect.jobSumProspect
      jobStatus: Array<{...}>        // salProspect.jobStatusList
    }
  }
  
  // 3. 교육 & 학력
  education: {
    departments: string[]            // encyclopedia.departList
    majors: Array<{
      code: string
      name: string
    }>                               // 병합 (summary + path)
    certificates: string[]           // 병합 (3개 소스)
    educationStats: {...}            // path.educationDistribution
    majorStats: {...}                // path.majorDistribution
    relatedOrganizations: string[]   // 병합 (encyclopedia + path)
    kecoClassification: Array<{...}> // path.kecoList
  }
  
  // 4. 능력 & 지식
  abilitiesAndKnowledge: {
    // 간단 리스트
    simpleAbilities: string[]        // encyclopedia.abilityList
    simpleKnowledge: string[]        // encyclopedia.performList.knowledge
    
    // 요약
    abilitySummary: string           // summary.jobAbil
    knowledgeSummary: string         // summary.knowldg
    technicalKnowledge: string       // path.technKnow
    
    // 상세 비교 (고용24)
    detailedAbilities: {
      withinJob: Array<{...}>        // ablKnwEnv.jobAbilCmpr
      betweenJobs: Array<{...}>      // ablKnwEnv.jobAbil
      levels: {...}                  // ablKnwEnv.jobAbilLvlCmpr/jobAbilLvl
    }
    detailedKnowledge: {
      withinJob: Array<{...}>        // ablKnwEnv.KnwldgCmpr
      betweenJobs: Array<{...}>      // ablKnwEnv.Knwldg
      levels: {...}                  // ablKnwEnv.KnwldgLvlCmpr/KnwldgLvl
    }
  }
  
  // 5. 업무환경
  workEnvironment: {
    simple: string[]                 // encyclopedia.performList.environment
    summary: string                  // summary.jobEnv
    detailed: {
      withinJob: Array<{...}>        // ablKnwEnv.jobsEnvCmpr
      betweenJobs: Array<{...}>      // ablKnwEnv.jobsEnv
    }
  }
  
  // 6. 성격/흥미/가치관
  personalityAndInterests: {
    aptitude: string[]               // encyclopedia.aptitudeList
    aptitudeType: string             // encyclopedia.baseInfo.aptit_name
    interest: string[]               // encyclopedia.interestList
    
    detailed: {
      personality: {
        summary: string              // summary.jobChr
        withinJob: Array<{...}>      // chrIntrVals.jobChrCmpr
        betweenJobs: Array<{...}>    // chrIntrVals.jobChr
      }
      interest: {
        summary: string              // summary.jobIntrst
        withinJob: Array<{...}>      // chrIntrVals.jobIntrstCmpr
        betweenJobs: Array<{...}>    // chrIntrVals.jobIntrst
      }
      values: {
        summary: string              // summary.jobVals
        withinJob: Array<{...}>      // chrIntrVals.jobValsCmpr
        betweenJobs: Array<{...}>    // chrIntrVals.jobVals
      }
    }
  }
  
  // 7. 업무활동 (고용24 전용)
  workActivities: {
    importance: {
      withinJob: Array<{...}>        // actv.jobActvImprtncCmpr
      betweenJobs: Array<{...}>      // actv.jobActvImprtnc
    }
    level: {
      withinJob: Array<{...}>        // actv.jobActvLvlCmpr
      betweenJobs: Array<{...}>      // actv.jobActvLvl
    }
  }
  
  // 8. 관련 정보
  relatedInfo: {
    relatedJobs: Array<{...}>        // summary.relJobList
    videos: Array<{...}>             // encyclopedia.relVideoList
    careerResearch: string[]         // encyclopedia.researchList
    solutions: Array<{...}>          // encyclopedia.relSolList
    jobPreparation: {...}            // encyclopedia.jobReadyList
    tags: string[]                   // encyclopedia.tagList
  }
}
```

---

## 🚀 구현 가이드

### 1단계: 데이터 정규화 함수
```typescript
function normalizeJobData(careernet: any, goyong24: any): JobData {
  return {
    // 메타데이터 병합
    jobCode: goyong24.summary.jobCd,
    classification: {
      large: goyong24.summary.jobLrclNm,
      medium: goyong24.summary.jobMdclNm,
      small: goyong24.summary.jobSmclNm
    },
    
    // 우선순위 선택
    salary: goyong24.salProspect?.sal || goyong24.summary?.sal || careernet.encyclopedia?.baseInfo?.wage,
    
    // 병합
    certificates: unique([
      ...(careernet.encyclopedia?.certiList || []),
      ...(goyong24.summary?.relCertList || []).map(c => c.certNm || c),
      ...(goyong24.path?.relCertList || [])
    ])
  }
}
```

### 2단계: 유틸리티 함수
```typescript
// 중복 제거
function unique(arr: any[]): any[] {
  return Array.from(new Set(arr.filter(Boolean)))
}

// 우선순위 선택
function selectWithPriority(...sources: any[]): any {
  return sources.find(s => s !== null && s !== undefined && s !== '')
}

// 병합 후 출처 표시
function mergeWithSource(primary: any, secondary: any, tertiary: any) {
  const result = selectWithPriority(primary, secondary, tertiary)
  const source = primary ? 'goyong24-detail' : secondary ? 'goyong24-summary' : 'careernet'
  return { value: result, source }
}
```

---

## ✅ 최종 결론

### 병합 원칙
1. ✅ **중복 제거**: jobCd, 직업분류 → 1개로 병합
2. ✅ **우선순위**: 임금/만족도/전망 → 고용24 salProspect 우선
3. ✅ **보완 활용**: 하는일/능력 → 모두 계층적 활용
4. ✅ **독립 유지**: 워라밸, 상세 비교 데이터 → 각자 유지

### 사용자에게 보여주기
- **개요 탭**: 우선순위 선택된 1개 값만
- **상세정보 탭**: 계층적 구조로 모든 데이터 표시
  - 간단 → 요약 → 상세 순서
  - 출처 표시 옵션 제공

### 다음 단계
정우님이 확인 후:
1. 불필요한 필드 제거 리스트 제공
2. 우선순위 조정 필요 시 반영
3. 실제 병합 코드 구현
