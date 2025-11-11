# 전공 데이터 병합 디버그 페이지

## ✅ 문제 해결 완료 (2025-11-11)

**D1 병합 로직 적용**으로 이제 모든 전공 페이지가 CareerNet + Goyong24 데이터를 자동으로 병합합니다.

- **수정 파일**: `src/services/profileDataService.ts` (601-727번 라인)
- **템플릿 버전**: `MAJOR: 16 → 17`
- **적용 방법**: `.all()`로 모든 레코드 조회 → 반복문으로 양쪽 데이터 수집 → 병합

---

## 📊 병합 대상 전공 리스트 (CareerNet + Goyong24 모두 보유)

### 1. 간호학과 (의료계열)
- **메인 페이지**: http://localhost:3000/major/간호학과
- **CareerNet 전용**: http://localhost:3000/major/간호학과?careernetId=10
- **Goyong24 전용**: http://localhost:3000/major/간호학과?goyong24MajorId=G4_간호학과
- **디버그 모드**: http://localhost:3000/major/간호학과?debug=true

### 2. 건축학과 (공학계열)
- **메인 페이지**: http://localhost:3000/major/건축학과
- **CareerNet 전용**: http://localhost:3000/major/건축학과?careernetId=20
- **Goyong24 전용**: http://localhost:3000/major/건축학과?goyong24MajorId=G1_건축학과
- **디버그 모드**: http://localhost:3000/major/건축학과?debug=true

### 3. 게임공학과 (IT계열)
- **메인 페이지**: http://localhost:3000/major/게임공학과
- **CareerNet 전용**: http://localhost:3000/major/게임공학과?careernetId=21
- **Goyong24 전용**: http://localhost:3000/major/게임공학과?goyong24MajorId=G24_게임공학과
- **디버그 모드**: http://localhost:3000/major/게임공학과?debug=true

### 4. 가정교육과 (교육계열)
- **메인 페이지**: http://localhost:3000/major/가정교육과
- **CareerNet 전용**: http://localhost:3000/major/가정교육과?careernetId=10006
- **Goyong24 전용**: http://localhost:3000/major/가정교육과?goyong24MajorId=G9_가정교육과
- **디버그 모드**: http://localhost:3000/major/가정교육과?debug=true

### 5. 건축공학과 (공학계열)
- **메인 페이지**: http://localhost:3000/major/건축공학과
- **CareerNet 전용**: http://localhost:3000/major/건축공학과?careernetId=17
- **Goyong24 전용**: http://localhost:3000/major/건축공학과?goyong24MajorId=G2_건축공학과
- **디버그 모드**: http://localhost:3000/major/건축공학과?debug=true

### 6. 가족복지과 (복지계열)
- **메인 페이지**: http://localhost:3000/major/가족복지과
- **CareerNet 전용**: http://localhost:3000/major/가족복지과?careernetId=8
- **Goyong24 전용**: http://localhost:3000/major/가족복지과?goyong24MajorId=G10_가족복지과
- **디버그 모드**: http://localhost:3000/major/가족복지과?debug=true

### 7. 간호과 (의료계열)
- **메인 페이지**: http://localhost:3000/major/간호과
- **CareerNet 전용**: http://localhost:3000/major/간호과?careernetId=9
- **Goyong24 전용**: http://localhost:3000/major/간호과?goyong24MajorId=G4_간호과
- **디버그 모드**: http://localhost:3000/major/간호과?debug=true

---

## 🔍 현재 문제점

### 1️⃣ **D1 조회 로직 문제**
```typescript
// 현재 코드 (src/services/profileDataService.ts:618-623)
const majorRow = await db.prepare(`
  SELECT id, name, careernet_id, goyong24_id, api_data_json 
  FROM majors 
  WHERE LOWER(name) = LOWER(?)
  LIMIT 1  // ❌ 여기가 문제! 2개 레코드 중 1개만 가져옴
`).bind(id).first()
```

**결과**: 같은 이름의 2개 레코드(CareerNet, Goyong24) 중 **첫 번째 레코드만** 가져옵니다.

### 2️⃣ **직업 페이지는 올바르게 구현됨**
```typescript
// 직업 페이지 (src/services/profileDataService.ts:898-904)
const allJobRows = await db.prepare(`
  SELECT id, name, careernet_id, goyong24_id, api_data_json 
  FROM jobs 
  WHERE LOWER(name) = LOWER(?)
`).all()  // ✅ 모든 레코드를 가져옴!

// 그 후 반복문으로 CareerNet, Goyong24 데이터 분리
for (const row of allJobRows.results) {
  const apiData = JSON.parse(row.api_data_json)
  if (apiData?.careernet) careernetProfile = ...
  if (apiData?.goyong24) goyongProfile = ...
}
```

---

## 📋 수정 방안

### ✅ 해결책: 전공 페이지도 직업 페이지처럼 `.all()` 사용

```typescript
// 수정 후
const allMajorRows = await db.prepare(`
  SELECT id, name, careernet_id, goyong24_id, api_data_json 
  FROM majors 
  WHERE LOWER(name) = LOWER(?)
`).all()  // ✅ 모든 레코드 가져오기

for (const row of allMajorRows.results) {
  const apiData = JSON.parse(row.api_data_json)
  
  if (apiData?.careernet && !careernetProfile) {
    careernetProfile = { /* CareerNet 데이터 */ }
  }
  
  if (apiData?.goyong24 && !goyongProfile) {
    goyongProfile = { /* Goyong24 데이터 */ }
  }
}

// 두 프로필을 병합
const merged = mergeMajorProfiles(goyongProfile, careernetProfile)
```

---

## 🎯 테스트 방법

1. **CareerNet 전용 링크** → CareerNet 데이터만 표시
2. **Goyong24 전용 링크** → Goyong24 데이터만 표시
3. **메인 페이지** → 두 데이터가 병합되어 표시 (수정 후)
4. **디버그 모드** → 원본 API 응답 확인

---

## 📊 비교용 샘플 데이터

### CareerNet 주요 필드
- `categoryName` (계열명)
- `relateSubject` (관련 고교 교과목)
- `mainSubject` (대학 주요 교과목)
- `careerAct` (진로 탐색 활동)
- `enterField` (졸업 후 진출분야)
- `chartData` (통계 차트)
- `universityList` (개설 대학 목록)

### Goyong24 주요 필드
- `summary` (학과 요약)
- `departmentIntro` (학과 소개)
- `curriculum` (교육과정)
- `certification` (자격증 정보)
- `relatedMajors` (관련 학과)
- `relatedJobs` (관련 직업)

---

## ✅ 다음 단계

1. **이 문서의 링크들을 열어서 각 소스별 데이터를 확인**
2. **어떤 필드를 사용할지, 어떤 필드를 병합할지 결정**
3. **`src/services/profileDataService.ts`의 `getUnifiedMajorDetail` 함수 수정**
4. **템플릿에서 Goyong24 필드 렌더링 추가**

