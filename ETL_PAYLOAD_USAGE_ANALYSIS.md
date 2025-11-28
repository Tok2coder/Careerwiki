# ETL에서 raw_payload와 normalized_payload 사용 분석 리포트

## 📋 요약

### 사용 패턴
- **둘 다 사용**: ETL은 `normalized_payload`를 우선 사용하지만, `raw_payload`도 병합 로직에서 직접 접근
- **우선순위**: `normalized_payload` > `raw_payload` (normalized_payload가 비어있을 때만 raw_payload 사용)

### 발견된 문제
1. **WORK24_JOB normalized_payload가 비어있을 때**: 4개 필드만 매핑 (대부분 누락)
2. **필드가 null일 때**: `mergeFieldByPriority`가 raw_payload를 확인하지 않음
3. **raw_payload 직접 접근**: 일관성 없음 (일부는 normalized_payload, 일부는 raw_payload)

---

## 🔍 상세 분석

### 1. ETL 병합 프로세스

#### 1단계: 데이터 파싱
```typescript
// src/scripts/etl/mergeJobProfiles.ts:230-235
const normalizedData = JSON.parse(s.normalized_payload) || {}
const rawData = JSON.parse(s.raw_payload) || {}
```

#### 2단계: 우선순위 결정
```typescript
// 237-271줄
let finalData = normalizedData  // normalized_payload 우선

// normalized_payload가 비어있으면 raw_payload에서 직접 매핑
if (Object.keys(normalizedData).length === 0 && Object.keys(rawData).length > 0) {
  // WORK24_DJOB: 12개 필드 매핑
  // WORK24_JOB: 4개 필드만 매핑 ⚠️ 문제!
}
```

#### 3단계: 병합 로직에서 둘 다 사용
```typescript
// 307-312줄
const careernetData = careernetSource?.data || {}      // normalized_payload
const jobData = jobSource?.data || {}                 // normalized_payload
const careernetRaw = careernetSource?.raw || {}       // raw_payload
const goyong24Raw = jobSource?.raw || {}              // raw_payload
```

---

## ⚠️ 발견된 문제점

### 문제 1: WORK24_JOB normalized_payload가 비어있을 때 필드 누락

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

**누락되는 필드**:
- ❌ `duties` (`rawData.duty?.execJob`)
- ❌ `abilities` (`rawData.summary?.jobAbil`)
- ❌ `knowledge` (`rawData.ablKnwEnv?.Knwldg`)
- ❌ `environment` (`rawData.ablKnwEnv?.jobsEnv`)
- ❌ `personality`, `interests`, `values`
- ❌ `relatedMajors`, `relatedCertificates`, `relatedJobs`
- ❌ `classifications` (대/중/소분류)
- ❌ `goyong24Only.*` 구조 (비교 표 데이터)

**해결 방법**:
```typescript
// normalizeGoyong24JobDetail() 함수 사용
import { normalizeGoyong24JobDetail } from '../../api/goyong24API'

else if (system === 'WORK24_JOB' && rawData.jobNm) {
  try {
    finalData = normalizeGoyong24JobDetail(rawData)
  } catch (error) {
    // Fallback: 기본 필드만 매핑
    finalData = {
      name: rawData.jobNm,
      summary: rawData.jobSum || null,
      wage: rawData.sal || null,
      prospect: rawData.jobProspect || null
    }
  }
}
```

---

### 문제 2: 필드가 null일 때 raw_payload 확인 안 함

**현재 코드** (63-77줄):
```typescript
function mergeFieldByPriority(
  sources: Array<{ system: string; data: any }>,
  field: string
): any {
  const priority = ['CAREERNET', 'WORK24_JOB', 'WORK24_DJOB']
  
  for (const sourceSystem of priority) {
    const source = sources.find(s => s.system === sourceSystem)
    if (source && source.data[field]) {  // ⚠️ falsy 값이면 다음 소스로 넘어감
      return source.data[field]
    }
  }
  
  return null
}
```

**문제점**:
- `normalized_payload`에 필드가 `null`이면 `raw_payload`를 확인하지 않음
- 예: `summary`가 `null`이면 다음 소스로 넘어가지만, raw_payload에는 있을 수 있음

**실제 사례** (IT기술지원전문가):
- `normalized_payload.summary`: `null`
- `normalized_payload.salary`: `null`
- `normalized_payload.prospect`: `null`
- 하지만 `raw_payload`에는 있을 수 있음

**해결 방법**:
```typescript
function mergeFieldByPriority(
  sources: Array<{ system: string; data: any; raw?: any }>,
  field: string
): any {
  const priority = ['CAREERNET', 'WORK24_JOB', 'WORK24_DJOB']
  
  for (const sourceSystem of priority) {
    const source = sources.find(s => s.system === sourceSystem)
    if (!source) continue
    
    // 1. normalized_payload 확인
    if (source.data && source.data[field] !== null && source.data[field] !== undefined) {
      return source.data[field]
    }
    
    // 2. raw_payload 확인 (필드 매핑 필요)
    if (source.raw) {
      const rawValue = extractFromRawPayload(source.raw, field, sourceSystem)
      if (rawValue !== null && rawValue !== undefined) {
        return rawValue
      }
    }
  }
  
  return null
}
```

---

### 문제 3: raw_payload 직접 접근의 일관성 부족

**현재 코드**:
```typescript
// 일부는 normalized_payload 사용
const heroTitle = selectBestValue(
  careernetData?.name,      // normalized_payload
  jobData?.name,             // normalized_payload
  djobData?.name             // normalized_payload
)

// 일부는 raw_payload 직접 접근
const jobLrclNm = goyong24Raw?.summary?.jobLrclNm || goyong24Raw?.jobLrclNm  // raw_payload
const heroIntro = selectBestValue(
  careernetData?.summary,     // normalized_payload
  jobData?.summary || goyong24Raw?.summary?.jobSum || goyong24Raw?.duty?.jobSum,  // raw_payload
  djobData?.summary           // normalized_payload
)
```

**문제점**:
- `normalized_payload`에 `classifications`로 정규화되어 있는데 `raw_payload`에서 직접 접근
- 일관성 없음

**해결 방법**:
- `normalized_payload` 우선 사용
- `raw_payload`는 정말 필요한 경우만 사용 (예: normalized_payload에 없는 필드)

---

## 📊 소스별 정규화 상태

### CAREERNET
- ✅ **정규화 완료**: `normalizeCareerNetJobDetail()` 함수가 대부분의 필드 매핑
- ✅ **누락 낮음**: raw_payload에서 직접 접근하는 필드 적음 (태그, 카테고리 등)

### WORK24_JOB
- ⚠️ **정규화 완료**: `normalizeGoyong24JobDetail()` 함수 존재
- ⚠️ **문제**: normalized_payload가 비어있을 때 정규화 함수를 사용하지 않음
- ⚠️ **누락 높음**: normalized_payload가 비어있으면 4개 필드만 매핑

### WORK24_DJOB
- ⚠️ **정규화 없음**: 정규화 함수 없음, 직접 매핑
- ⚠️ **누락 중간**: 주요 필드는 매핑되지만 raw_payload에 더 많은 필드가 있을 수 있음

---

## ✅ 권장 수정 사항

### 1. WORK24_JOB 정규화 함수 사용
```typescript
// src/scripts/etl/mergeJobProfiles.ts:258-266
else if (system === 'WORK24_JOB' && rawData.jobNm) {
  try {
    // 정규화 함수 사용
    const normalized = normalizeGoyong24JobDetail(rawData)
    finalData = normalized
  } catch (error) {
    console.warn(`  ⚠️ Failed to normalize WORK24_JOB data for ${s.source_key}:`, error)
    // Fallback: 기본 필드만 매핑
    finalData = {
      name: rawData.jobNm,
      summary: rawData.jobSum || null,
      wage: rawData.sal || null,
      prospect: rawData.jobProspect || null
    }
  }
}
```

### 2. mergeFieldByPriority 개선
```typescript
// raw_payload도 확인하도록 수정
function mergeFieldByPriority(
  sources: Array<{ system: string; data: any; raw?: any }>,
  field: string
): any {
  const priority = ['CAREERNET', 'WORK24_JOB', 'WORK24_DJOB']
  
  for (const sourceSystem of priority) {
    const source = sources.find(s => s.system === sourceSystem)
    if (!source) continue
    
    // normalized_payload 확인
    if (source.data?.[field]) {
      return source.data[field]
    }
    
    // raw_payload 확인 (필요한 경우)
    // ...
  }
  
  return null
}
```

### 3. raw_payload 직접 접근 최소화
- `normalized_payload`에 있는 필드는 `data`에서 가져오기
- `raw_payload`는 정말 필요한 경우만 사용 (예: normalized_payload에 없는 필드)

---

## 📝 다음 단계

1. ✅ **WORK24_JOB 정규화 함수 사용 추가**
2. ✅ **mergeFieldByPriority 개선** (raw_payload 확인)
3. ✅ **raw_payload 직접 접근 최소화**
4. ✅ **누락 필드 감지 스크립트 작성**
5. ✅ **ETL 재실행 및 검증**

