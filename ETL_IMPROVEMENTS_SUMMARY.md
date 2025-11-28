# ETL 개선 사항 요약

## ✅ 완료된 개선 사항

### 1. normalizeGoyong24JobDetail 함수 사용 추가

**변경 전**:
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

**변경 후**:
```typescript
else if (system === 'WORK24_JOB' && rawData.jobNm) {
  try {
    // 정규화 함수 사용하여 모든 필드 매핑
    const normalized = normalizeGoyong24JobDetail(rawData as Goyong24JobDetailAggregated)
    finalData = normalized
  } catch (normalizeError) {
    // Fallback: 기본 필드만 매핑
    finalData = { ... }
  }
}
```

**효과**:
- ✅ normalized_payload가 비어있을 때도 모든 필드 매핑
- ✅ `duties`, `abilities`, `knowledge`, `environment` 등 누락 방지
- ✅ `classifications`, `relatedMajors`, `relatedCertificates` 등 포함

---

### 2. mergeFieldByPriority 함수 개선

**변경 전**:
```typescript
function mergeFieldByPriority(
  sources: Array<{ system: string; data: any }>,
  field: string
): any {
  // normalized_payload만 확인
  if (source && source.data[field]) {
    return source.data[field]
  }
}
```

**변경 후**:
```typescript
function mergeFieldByPriority(
  sources: Array<{ system: string; data: any; raw?: any }>,
  field: string
): any {
  // 1. normalized_payload 확인 (null이 아닌 값만)
  if (source.data && source.data[field] !== null && ...) {
    return source.data[field]
  }
  
  // 2. raw_payload 확인 (필요한 경우에만)
  if (source.raw) {
    const rawValue = extractFieldFromRawPayload(source.raw, field, sourceSystem)
    if (rawValue !== null && ...) {
      return rawValue
    }
  }
}
```

**효과**:
- ✅ normalized_payload에 필드가 null이어도 raw_payload 확인
- ✅ 데이터 누락 방지
- ✅ 기존 코드 호환성 유지 (raw는 optional)

---

### 3. raw_payload 직접 접근 최소화

**변경 전**:
```typescript
// raw_payload에서 직접 접근
const jobLrclNm = goyong24Raw?.summary?.jobLrclNm || goyong24Raw?.jobLrclNm
const jobMdclNm = goyong24Raw?.summary?.jobMdclNm || goyong24Raw?.jobMdclNm
const jobSmclNm = goyong24Raw?.summary?.jobSmclNm || goyong24Raw?.jobSmclNm
```

**변경 후**:
```typescript
// normalized_payload에서 classifications 우선 확인
const jobClassifications = jobData?.classifications || djobData?.classifications
if (jobClassifications?.large && jobClassifications?.medium && jobClassifications?.small) {
  heroCategory = { ... }
} else {
  // Fallback: raw_payload에서 직접 접근 (normalized_payload에 없을 때만)
  const jobLrclNm = goyong24Raw?.summary?.jobLrclNm || ...
}
```

**효과**:
- ✅ normalized_payload 우선 사용
- ✅ 일관성 향상
- ✅ raw_payload는 정말 필요한 경우만 사용

---

## 🔍 영향 범위 분석

### 영향받는 파일
- ✅ `src/scripts/etl/mergeJobProfiles.ts` - 수정 완료
- ✅ `src/scripts/etl/mergeMajorProfiles.ts` - 영향 없음 (별도 함수)

### 영향받는 함수 호출
- ✅ `mergeFieldByPriority` - 49번 사용, 모두 호환됨 (raw는 optional)
- ✅ `mergeArrayFields` - 영향 없음
- ✅ `selectBestValue` - 영향 없음

### 타입 체크
- ✅ TypeScript 컴파일 오류 없음
- ✅ 린트 오류 없음

---

## 📊 예상 효과

### Case 7 (고용24직업만) 개선
- **이전**: `summary`, `salary`, `prospect` 등 null
- **개선 후**: 모든 필드 정상 매핑

### 데이터 완전성 향상
- **이전**: normalized_payload가 비어있으면 4개 필드만 매핑
- **개선 후**: 모든 필드 매핑 (30+ 필드)

### 일관성 향상
- **이전**: 일부는 normalized_payload, 일부는 raw_payload 직접 접근
- **개선 후**: normalized_payload 우선, raw_payload는 fallback

---

## 🧪 테스트 필요 사항

1. **ETL 재실행**
   ```bash
   npm run etl:merge-jobs -- "IT기술지원전문가" "IT테스터 및 IT QA전문가" "UX·UI디자이너"
   ```

2. **데이터 확인**
   - `jobs.merged_profile_json`에 모든 필드가 있는지 확인
   - `summary`, `salary`, `prospect` 등이 null이 아닌지 확인

3. **템플릿 렌더링 확인**
   - 페이지가 정상적으로 렌더링되는지 확인
   - 모든 섹션이 표시되는지 확인

---

## ⚠️ 주의사항

1. **정규화 함수 호출 시 에러 처리**
   - try-catch로 감싸서 실패 시 fallback 사용
   - 로그 출력으로 디버깅 가능

2. **raw_payload 직접 접근**
   - 일부 필드(태그, 카테고리 fallback 등)는 여전히 raw_payload 직접 접근
   - 이는 정상적인 fallback 로직

3. **타입 호환성**
   - `mergeFieldByPriority`의 raw 파라미터는 optional이므로 기존 코드 호환
   - `mergeMajorProfiles.ts`는 별도 파일이므로 영향 없음

