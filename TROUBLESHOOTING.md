# 🔧 CareerWiki 트러블슈팅 가이드

이 문서는 실제 발생한 버그와 해결 과정을 기록하여 동일하거나 유사한 문제를 빠르게 해결하기 위한 레퍼런스입니다.

---

## 📋 목차

1. [데이터 머지/파싱 문제](#1-데이터-머지파싱-문제)
   - [Case 1.1: API 데이터가 파싱되지만 partials에 반영되지 않는 문제](#case-11-api-데이터가-파싱되지만-partials에-반영되지-않는-문제)

---

## 1. 데이터 머지/파싱 문제

### Case 1.1: API 데이터가 파싱되지만 partials에 반영되지 않는 문제

#### 🐛 증상

- **현상**: 디버그 로그에서 API 데이터 파싱은 성공했지만, HTML 템플릿의 `partials_goyong` 값이 `"N/A"`로 표시됨
- **예시**: 
  - PM2 로그: `[DEBUG] Goyong24 salProspect.jobSatis: 78.3 length: 4` ✅
  - HTML 출력: `<!-- partials_goyong="N/A" -->` ❌
- **결과**: 우선순위가 높은 데이터가 무시되고 낮은 우선순위 데이터가 표시됨

#### 🔍 진단 방법

**1단계: HTML 디버그 코멘트 확인**
```bash
curl -s "http://localhost:3000/job/lawyer" | grep "SATISFACTION:"
```
예상 출력:
```html
<!-- SATISFACTION: value="78.3" partials_goyong="N/A" partials_careernet="83.3" -->
```

**2단계: API 파싱 로그 확인**
```bash
pm2 logs --nostream | grep -E "(Goyong24|satisfaction)" | tail -20
```
예상 출력:
```
[DEBUG] Goyong24 salProspect.jobSatis: 78.3 length: 4
```

**3단계: 문제 식별**
- API 파싱은 성공 (`78.3` 파싱됨)
- `partials` 객체에는 반영 안됨 (`N/A`)
- ⚠️ **결론**: `normalize` 함수와 `partials` 생성 사이에 문제 존재

#### 🔎 원인 분석

**데이터 흐름 추적:**

```typescript
// 1. API 호출 (profileDataService.ts)
const raw = await fetchGoyong24JobDetail(resolvedJobId, env)
rawGoyong24Data = raw  // ✅ API 응답 받음

// 2. 정규화 (goyong24API.ts)
goyongProfile = normalizeGoyong24JobDetail(raw)  // ❌ 여기서 문제 발생!

// 3. Partials 생성 (profileDataService.ts)
const partialsRecord: Partial<Record<DataSource, UnifiedJobDetail | null>> = {
  CAREERNET: careernetProfile,
  GOYONG24: goyongProfile  // ❌ goyongProfile에 satisfaction이 없음
}
```

**실제 원인: 정의되지 않은 변수 참조**

```typescript
// goyong24API.ts - normalizeGoyong24JobDetail 함수
export const normalizeGoyong24JobDetail = (
  detail: Goyong24JobDetailAggregated
): UnifiedJobDetail => {
  const summary = detail.summary
  // ❌ salProspect 변수를 선언하지 않음!
  
  return {
    // ...
    satisfaction: (summary.jobSatis && summary.jobSatis.trim()) 
      || (salProspect.jobSatis && salProspect.jobSatis.trim())  // ❌ 정의되지 않은 변수!
      || undefined,
    // ...
  }
}
```

**JavaScript 동작:**
- `salProspect`가 정의되지 않음 → `ReferenceError` 발생 가능
- 또는 `undefined.jobSatis` 접근 → `TypeError` 발생
- 에러 처리로 인해 전체 `satisfaction` 값이 `undefined`가 됨

#### ✅ 해결 방법

**수정 전:**
```typescript
export const normalizeGoyong24JobDetail = (
  detail: Goyong24JobDetailAggregated
): UnifiedJobDetail => {
  const summary = detail.summary
  // salProspect 선언 없음!
  
  return {
    // ...
    satisfaction: (summary.jobSatis && summary.jobSatis.trim()) 
      || (salProspect.jobSatis && salProspect.jobSatis.trim())  // ❌
      || undefined,
  }
}
```

**수정 후:**
```typescript
export const normalizeGoyong24JobDetail = (
  detail: Goyong24JobDetailAggregated
): UnifiedJobDetail => {
  const summary = detail.summary
  const salProspect = detail.salProspect  // ✅ 변수 선언 추가
  
  return {
    // ...
    satisfaction: (summary.jobSatis && summary.jobSatis.trim()) 
      || (salProspect?.jobSatis && salProspect.jobSatis.trim())  // ✅ 옵셔널 체이닝
      || undefined,
  }
}
```

**변경 사항:**
1. ✅ `const salProspect = detail.salProspect` 선언 추가
2. ✅ `salProspect?.jobSatis` 옵셔널 체이닝 추가 (안전성)

#### 🧪 검증 방법

**1. 빌드 및 재시작**
```bash
cd /home/user/webapp && npm run build
fuser -k 3000/tcp 2>/dev/null || true
pm2 restart careerwiki
```

**2. HTML 디버그 코멘트 재확인**
```bash
sleep 3
curl -s "http://localhost:3000/job/lawyer" | grep "SATISFACTION:"
```

**기대 결과:**
```html
<!-- SATISFACTION: value="78.3" partials_goyong="78.3" partials_careernet="83.3" -->
<p class="content-text text-wiki-text">78.3</p>
```

**성공 기준:**
- ✅ `partials_goyong="78.3"` (이전: `"N/A"`)
- ✅ `value="78.3"` (Goyong24 우선순위 적용)
- ✅ 페이지에 78.3 표시 (이전: 83.3)

#### 📚 교훈 및 예방법

**1. TypeScript 타입 체킹 활용**
```typescript
// ❌ 잘못된 방법: 선언 없이 사용
satisfaction: (summary.jobSatis?.trim()) || (salProspect.jobSatis?.trim())

// ✅ 올바른 방법: 명시적 선언
const summary = detail.summary
const salProspect = detail.salProspect  // TypeScript가 타입 체크 가능
satisfaction: (summary.jobSatis?.trim()) || (salProspect?.jobSatis?.trim())
```

**2. 중첩 객체 접근 시 옵셔널 체이닝 사용**
```typescript
// ❌ 위험: 중간 값이 undefined면 에러
detail.salProspect.jobSatis

// ✅ 안전: 옵셔널 체이닝
detail.salProspect?.jobSatis
```

**3. 디버그 로그 vs 실제 출력 불일치 시 체크리스트**
- [ ] API 응답이 제대로 들어오는가? (`rawApiData` 확인)
- [ ] 파싱 함수가 올바르게 실행되는가? (디버그 로그 확인)
- [ ] **정규화 함수에서 반환값이 올바른가?** ⚠️ **여기가 문제일 확률 높음**
- [ ] Merge 로직이 올바르게 동작하는가? (`profileMerge.ts`)
- [ ] Partials 객체가 올바르게 생성되는가? (`partialsRecord`)
- [ ] 템플릿에서 올바르게 참조하는가?

**4. 유사한 문제가 발생할 수 있는 코드 패턴**
```typescript
// 🚨 위험 패턴: 중첩 객체에서 여러 필드 참조
const value = obj.nested.field1 || obj.other.field2  // ❌

// ✅ 안전 패턴: 명시적 추출
const nested = obj.nested
const other = obj.other
const value = nested?.field1 || other?.field2  // ✅
```

**5. 코드 리뷰 체크포인트**
- [ ] 모든 변수가 사용 전에 선언되었는가?
- [ ] 중첩 객체 접근 시 옵셔널 체이닝을 사용했는가?
- [ ] API 응답 구조가 변경되지 않았는가?
- [ ] 디버그 로그와 실제 출력이 일치하는가?

#### 🔗 관련 파일

- `/home/user/webapp/src/api/goyong24API.ts` - `normalizeGoyong24JobDetail()` (1128줄)
- `/home/user/webapp/src/services/profileDataService.ts` - `getUnifiedJobDetailWithRawData()` (750줄)
- `/home/user/webapp/src/services/profileMerge.ts` - `mergeJobProfiles()` (291줄)
- `/home/user/webapp/src/templates/unifiedJobDetail.ts` - 만족도 표시 (1916-1940줄)

#### 📅 발생일

- **날짜**: 2025-01-30
- **발견자**: 정우
- **해결 시간**: 약 1시간 (디버깅 + 수정)

---

## 🛠️ 일반적인 디버깅 전략

### 데이터 흐름 추적 순서

1. **API 응답 확인** → `/api/debug/...` 엔드포인트 또는 PM2 로그
2. **파싱 로그 확인** → `console.log` 또는 디버그 코멘트
3. **Normalize 함수 확인** → 반환값 검증
4. **Merge 로직 확인** → 우선순위 및 병합 규칙
5. **Partials 생성 확인** → `partialsRecord` 객체
6. **템플릿 렌더링 확인** → HTML 디버그 코멘트

### 효과적인 디버그 코멘트 패턴

```html
<!-- 
  DEBUG_FIELD_NAME: 
  final_value="..." 
  source1_value="..." 
  source2_value="..." 
  merge_logic="source1 ?? source2"
-->
```

이 패턴을 사용하면:
- 최종값이 무엇인지
- 각 소스에서 어떤 값이 왔는지
- 어떤 머지 로직이 적용되었는지
를 한눈에 파악 가능!

---

## 📖 추가 문서

- [README.md](/home/user/webapp/README.md) - 프로젝트 개요
- [API 통합 가이드](/home/user/webapp/docs/API_INTEGRATION.md) - API 연동 방법 (예정)
- [데이터 머지 전략](/home/user/webapp/docs/DATA_MERGING.md) - 다중 소스 병합 규칙 (예정)
