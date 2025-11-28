# 템플릿 정제 로직 정리 요약

## ✅ 완료된 작업

### 1. `normalizeBracketLabel` 함수 제거
- **위치**: `src/templates/unifiedJobDetail.ts` (2822-2825줄)
- **용도**: `heroCategory.value`에서 대괄호 제거
- **처리**: ETL에서 이미 정제된 데이터 사용하도록 변경
- **변경 사항**:
  ```typescript
  // 이전
  const normalizedLabel = normalizeBracketLabel(profile.heroCategory.value)
  
  // 이후
  const categoryValue = safeTrim(profile.heroCategory.value)  // ETL에서 이미 정제됨
  ```

### 2. ETL에서 `heroCategory.value` 정제 확인
- **위치**: `src/scripts/etl/mergeJobProfiles.ts` (457-465줄)
- **상태**: ✅ 이미 정제 로직 존재
- **로직**: `removeBrackets()` 함수로 `dJobICdNm` 대괄호 제거

---

## 🔍 유지된 텍스트 포맷팅 로직

다음 로직들은 **텍스트 파싱/렌더링** 목적이므로 템플릿에 유지:

### 1. `formatWorkDetailAsNumberedCards`의 대괄호 제거
- **위치**: `src/templates/unifiedJobDetail.ts` (268줄)
- **용도**: 업무 상세 텍스트에서 대분류 카테고리 파싱
- **예시**: `[철도신호원]` → `철도신호원` (텍스트 구조화)
- **이유**: 텍스트 포맷팅이므로 렌더링 로직으로 유지

### 2. 기타 텍스트 포맷팅 로직
- 숫자 파싱 (쉼표 제거 등): 렌더링 목적
- HTML 이스케이프: 보안 목적
- 앵커 ID 정규화: URL 생성 목적
- 텍스트 trim/정규화: 표시 목적

---

## 📊 정제 로직 위치 정리

### ETL에서 정제 (데이터 정제)
- ✅ `dJobICdNm` 대괄호 제거 (`[J602]텔레비전 방송업` → `텔레비전 방송업`)
- ✅ `heroCategory.value` 정제
- ✅ `normalizeGoyong24JobDictionaryDetail`에서 정제
- ✅ `mergeJobProfiles`에서 raw_payload 매핑 시 정제

### 템플릿에서 유지 (렌더링/포맷팅)
- ✅ 텍스트 파싱 (대괄호로 카테고리 구분)
- ✅ 숫자 포맷팅 (쉼표 제거 등)
- ✅ HTML 이스케이프
- ✅ 앵커 ID 생성

---

## 🎯 원칙

1. **데이터 정제**: ETL에서 수행 (원본 데이터 정제)
2. **텍스트 포맷팅**: 템플릿에서 수행 (표시 목적)
3. **구분 기준**: 
   - 데이터 정제: 원본 데이터를 정제하여 저장
   - 텍스트 포맷팅: 표시를 위한 구조화/포맷팅

---

## ✅ 검증 완료

- ✅ `normalizeBracketLabel` 제거 완료
- ✅ ETL에서 `heroCategory.value` 정제 확인 완료
- ✅ 텍스트 포맷팅 로직 유지 확인 완료
- ✅ 린트 오류 없음

