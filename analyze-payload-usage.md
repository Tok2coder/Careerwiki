# ETL에서 raw_payload와 normalized_payload 사용 분석

## 📋 사용 패턴

### 1. ETL 병합 프로세스

```typescript
// 1단계: 둘 다 파싱
const normalizedData = JSON.parse(s.normalized_payload) || {}
const rawData = JSON.parse(s.raw_payload) || {}

// 2단계: 우선순위 결정
let finalData = normalizedData  // normalized_payload 우선

// 3단계: normalized_payload가 비어있으면 raw_payload에서 매핑
if (Object.keys(normalizedData).length === 0 && Object.keys(rawData).length > 0) {
  // WORK24_DJOB 또는 WORK24_JOB의 경우 raw_payload에서 직접 매핑
  finalData = { ... }  // 일부 필드만 매핑
}

// 4단계: 병합 로직에서 둘 다 사용
parsedSourcesMap.set(system, {
  data: finalData,      // normalized_payload (또는 매핑된 데이터)
  raw: rawData         // raw_payload 원본
})
```

### 2. 병합 로직에서의 사용

```typescript
// normalized_payload 기반 (정규화된 데이터)
const careernetData = careernetSource?.data || {}
const jobData = jobSource?.data || {}
const djobData = djobSource?.data || {}

// raw_payload 기반 (원본 데이터 직접 접근)
const careernetRaw = careernetSource?.raw || {}
const goyong24Raw = jobSource?.raw || djobSource?.raw || {}
const djobRaw = djobSource?.raw || {}

// 예시: raw_payload에서 직접 접근
const jobLrclNm = goyong24Raw?.summary?.jobLrclNm || goyong24Raw?.jobLrclNm
```

---

## 🔍 소스별 사용 패턴

### CAREERNET (커리어넷)

**정규화 함수**: `normalizeCareerNetJobDetail()`

**normalized_payload에 포함되는 필드**:
- ✅ `name`, `summary`, `duties`
- ✅ `workList`, `relatedMajors`, `relatedCertificates`, `relatedJobs`
- ✅ `prospect`, `forecastList`
- ✅ `indicatorChart`, `satisfaction`
- ✅ `abilities`, `personality`, `interests`
- ✅ `jobReadyList`, `researchList`
- ✅ `relatedOrganizations`

**raw_payload에서 직접 접근하는 경우**:
- `careernetRaw?.encyclopedia?.baseInfo?.aptit_name` (카테고리)
- `careernetRaw?.encyclopedia?.baseInfo?.tag` (태그)
- `careernetRaw?.encyclopedia?.tagList` (태그 리스트)

**누락 가능성**: 낮음 (정규화 함수가 대부분의 필드를 매핑)

---

### WORK24_JOB (고용24 직업정보)

**정규화 함수**: `normalizeGoyong24JobDetail()`

**normalized_payload에 포함되는 필드**:
- ✅ `name`, `summary`, `duties`
- ✅ `salary`, `prospect`, `status`
- ✅ `abilities`, `knowledge`, `environment`
- ✅ `personality`, `interests`, `values`
- ✅ `relatedMajors`, `relatedCertificates`, `relatedJobs`
- ✅ `classifications` (대/중/소분류)
- ✅ `educationDistribution`, `majorDistribution`

**raw_payload에서 직접 접근하는 경우**:
- `goyong24Raw?.summary?.jobLrclNm` (대분류)
- `goyong24Raw?.summary?.jobMdclNm` (중분류)
- `goyong24Raw?.summary?.jobSmclNm` (소분류)
- `goyong24Raw?.duty?.jobSum` (직업 소개)
- `goyong24Raw?.salProspect?.jobSumProspect` (재직자 설문)

**normalized_payload가 비어있을 때 raw_payload 매핑** (259-265줄):
```typescript
finalData = {
  name: rawData.jobNm,
  summary: rawData.jobSum || null,
  wage: rawData.sal || null,
  prospect: rawData.jobProspect || null
}
```

**⚠️ 누락 가능성**: 높음
- `normalized_payload`가 비어있을 때 **4개 필드만** 매핑됨
- `duties`, `abilities`, `knowledge`, `environment` 등 대부분의 필드 누락
- `goyong24Only.*` 구조의 비교 표 데이터 누락

---

### WORK24_DJOB (고용24 직업사전)

**정규화 함수**: 없음 (직접 매핑)

**normalized_payload에 포함되는 필드**:
- 시딩 시 `normalized_payload`가 비어있을 수 있음 (`{}`)

**raw_payload에서 직접 접근하는 경우**:
- `djobRaw?.optionJobInfo?.dJobICdNm` (분류명)

**normalized_payload가 비어있을 때 raw_payload 매핑** (241-256줄):
```typescript
finalData = {
  name: rawData.dJobNm,
  summary: rawData.workSum || null,
  doWork: rawData.doWork || null,
  workStrong: rawData.optionJobInfo?.workStrong || null,
  workPlace: rawData.optionJobInfo?.workPlace || null,
  physicalAct: rawData.optionJobInfo?.physicalAct || null,
  eduLevel: rawData.optionJobInfo?.eduLevel || null,
  skillYear: rawData.optionJobInfo?.skillYear || null,
  workEnv: rawData.optionJobInfo?.workEnv || null,
  similarNm: rawData.optionJobInfo?.similarNm || null,
  connectJob: rawData.optionJobInfo?.connectJob || null,
  certLic: rawData.optionJobInfo?.certLic || null,
  dJobICdNm: rawData.optionJobInfo?.dJobICdNm || null
}
```

**⚠️ 누락 가능성**: 중간
- 주요 필드는 매핑됨 (12개 필드)
- 하지만 raw_payload에 더 많은 필드가 있을 수 있음

---

## ⚠️ 발견된 문제점

### 1. WORK24_JOB normalized_payload가 비어있을 때

**현재 코드** (259-265줄):
```typescript
else if (system === 'WORK24_JOB' && rawData.jobNm) {
  finalData = {
    name: rawData.jobNm,
    summary: rawData.jobSum || null,
    wage: rawData.sal || null,
    prospect: rawData.jobProspect || null
  }
}
```

**문제점**:
- ❌ `duties` 누락 (`rawData.duty?.execJob`)
- ❌ `abilities` 누락 (`rawData.summary?.jobAbil`)
- ❌ `knowledge` 누락 (`rawData.ablKnwEnv?.Knwldg`)
- ❌ `environment` 누락 (`rawData.ablKnwEnv?.jobsEnv`)
- ❌ `personality`, `interests`, `values` 누락
- ❌ `relatedMajors`, `relatedCertificates`, `relatedJobs` 누락
- ❌ `classifications` 누락
- ❌ `goyong24Only.*` 구조 누락

**해결 방법**:
- `normalizeGoyong24JobDetail()` 함수를 사용하여 정규화
- 또는 raw_payload에서 더 많은 필드 매핑

### 2. raw_payload 직접 접근의 문제

**현재 코드**:
```typescript
const jobLrclNm = goyong24Raw?.summary?.jobLrclNm || goyong24Raw?.jobLrclNm
```

**문제점**:
- normalized_payload에 이미 `classifications`로 정규화되어 있음
- raw_payload 직접 접근은 일관성 없음
- normalized_payload를 우선 사용해야 함

---

## 📊 데이터 흐름도

```
API 응답 (원본)
    ↓
job_sources.raw_payload (원본 저장)
    ↓
정규화 함수 (normalizeCareerNetJobDetail 등)
    ↓
job_sources.normalized_payload (정규화된 데이터 저장)
    ↓
ETL 병합
    ├─ normalized_payload 우선 사용
    ├─ 비어있으면 raw_payload에서 직접 매핑 (일부 필드만)
    └─ raw_payload도 병합 로직에서 직접 접근
    ↓
jobs.merged_profile_json (최종 병합 데이터)
```

---

## ✅ 권장 사항

### 1. normalized_payload 우선 사용
- 병합 로직에서 `data` (normalized_payload) 우선 사용
- raw_payload 직접 접근 최소화

### 2. 정규화 함수 활용
- WORK24_JOB의 경우 `normalizeGoyong24JobDetail()` 함수 사용
- normalized_payload가 비어있을 때도 정규화 함수 호출

### 3. 누락 필드 확인
- 각 소스별로 raw_payload에 있는데 normalized_payload에 없는 필드 확인
- 정규화 함수 업데이트 또는 ETL에서 직접 매핑 추가

---

## 🔧 수정 필요 사항

1. **WORK24_JOB 정규화 함수 호출 추가**
   ```typescript
   if (system === 'WORK24_JOB' && rawData.jobNm) {
     // normalizeGoyong24JobDetail() 함수 사용
     const normalized = normalizeGoyong24JobDetail(rawData)
     finalData = normalized
   }
   ```

2. **raw_payload 직접 접근 최소화**
   - normalized_payload에 있는 필드는 `data`에서 가져오기
   - raw_payload는 정말 필요한 경우만 사용

3. **누락 필드 감지 스크립트 작성**
   - raw_payload와 normalized_payload 비교
   - 누락된 필드 리포트 생성

