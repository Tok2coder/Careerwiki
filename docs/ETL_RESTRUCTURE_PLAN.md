# ETL 구조 재설계 계획

## 현재 문제점

1. **소스별 독립 데이터 포함**: `careernetOnly`, `goyong24Only` 같은 필드가 ETL 결과에 포함됨
2. **템플릿 구조와 불일치**: 템플릿은 평탄한 필드 구조를 기대하지만, ETL은 계층적 구조도 포함
3. **데이터 중복**: 같은 데이터가 여러 필드에 중복 저장됨
4. **누락된 필드**: 정규화 과정에서 일부 필드가 누락됨

## 목표 구조

### jobs.merged_profile_json 구조

템플릿 구조에 맞춘 평탄한 필드 구조:

```typescript
{
  // 기본 정보
  name: string
  id?: string
  
  // 히어로 섹션
  heroCategory: { type: 'single' | 'breadcrumb', value?: string, ... }
  heroTitle: string
  heroIntro: string
  heroTags: string[]
  
  // 개요 탭
  // 주요 업무
  summary: string
  duties: string
  doWork?: string  // WORK24_DJOB 전용
  workStrong?: string  // WORK24_DJOB 전용
  workPlace?: string  // WORK24_DJOB 전용
  physicalAct?: string  // WORK24_DJOB 전용
  
  // 커리어 전망
  prospect: string
  forecastList?: ForecastItem[]
  jobSumProspect?: JobSumProspectItem[]  // 재직자 전망 데이터
  
  // 한국의 직업지표
  indicatorChart?: IndicatorChartItem[]
  
  // 핵심 능력·자격
  abilityList?: AbilityItem[]
  eduLevel?: string
  skillYear?: string
  curriculum?: string[]
  
  // 적성 및 흥미
  satisfaction?: string
  personality?: string
  interests?: string
  values?: string
  
  // 임금 정보
  salary?: string
  
  // 상세정보 탭
  // 업무 상세
  way?: string
  
  // 학력·전공 분포
  educationDistribution?: EducationDistribution
  majorDistribution?: MajorDistribution
  
  // 워라밸 & 사회적 평가
  wlb?: string
  social?: string
  
  // 직업 준비하기
  jobReadyList?: JobReadyItem
  researchList?: ResearchItem[]
  technKnow?: string
  
  // 직업 분류
  classifications?: { large?: string, medium?: string, small?: string }
  kecoCodes?: JobKecoCodeInfo[]
  
  // 업무특성 탭
  // 필수 지식
  knowledge?: KnowledgeItem[] | string
  
  // 고용 현황
  status?: string
  
  // 근무 환경
  environment?: PerformEnvironmentItem[] | string
  
  // 업무 수행 지표
  performList?: PerformList
  
  // 활동 분석
  activitiesImportance?: any
  activitiesLevels?: any
  
  // 사이드바
  relatedJobs?: JobRelatedEntity[]
  relatedMajors?: JobRelatedEntity[]
  relatedOrganizations?: JobOrganizationInfo[]
  relatedCertificates?: string[]
  
  // 리소스
  relVideoList?: any[]
  relSolList?: any[]
  relJinsolList?: any[]
  
  // 소스 정보
  sources: DataSource[]
  sourceIds: SourceIdentifiers
}
```

## 제거할 필드

- `careernetOnly` - 필요한 필드는 평탄한 구조로 병합
- `goyong24Only` - 필요한 필드는 평탄한 구조로 병합
- `work.simple`, `work.summary`, `work.detailed` - 이미 `summary`, `duties`로 병합됨
- `abilitiesDetail` - 이미 `abilityList`, `abilities`로 병합됨
- `knowledgeDetail` - 이미 `knowledge`로 병합됨
- `educationDetail` - 이미 `educationDistribution`로 병합됨
- `majorDetail` - 이미 `relatedMajors`로 병합됨

## 병합 규칙

### 1. `goyong24Only.prospectChart` → `jobSumProspect`
- 재직자 전망 데이터를 평탄한 필드로 병합

### 2. `careernetOnly.wlb` → `wlb`
- 워라밸 데이터를 평탄한 필드로 병합

### 3. `careernetOnly.social` → `social`
- 사회적 평가 데이터를 평탄한 필드로 병합

### 4. `careernetOnly.researchList` → `researchList`
- 진로 탐색 활동 데이터를 평탄한 필드로 병합

### 5. `goyong24Only.workEnvironment` → `performList.environment`
- 업무환경 데이터를 `performList`에 병합

### 6. `goyong24Only.personality` → `personality`
- 성격 특성 데이터를 평탄한 필드로 병합 (이미 병합됨)

### 7. `goyong24Only.activity` → `activitiesImportance`, `activitiesLevels`
- 업무활동 데이터를 평탄한 필드로 병합

## 누락된 필드 처리

### 정규화 과정에서 누락된 필드
- `normalized_payload`가 비어있을 때 `raw_payload`에서 직접 매핑
- `extractFieldFromRawPayload` 함수로 필드 추출

### ETL 병합 과정에서 누락된 필드
- `mergeFieldByPriority` 함수가 모든 필드를 병합하도록 보장
- 필드별 우선순위 규칙 적용

## 구현 단계

1. 템플릿에서 사용하는 모든 필드 목록 작성
2. ETL에서 소스별 독립 데이터 제거
3. 필요한 필드를 평탄한 구조로 병합
4. 템플릿 수정 (rawApiData 의존성 제거)
5. 테스트 및 검증

