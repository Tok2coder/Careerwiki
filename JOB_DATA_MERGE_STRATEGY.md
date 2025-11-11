# 직업 데이터 병합 전략

**작성일**: 2025-11-06  
**현재 상태**: 분석 완료, 병합 전략 수립

---

## 📊 현재 데이터 현황

### 소스별 통계
- **커리어넷 직업**: 443개
- **고용24 직업**: 537개
- **직업명 기반 매칭**: 136개 (13.9%)
- **매칭 안 됨**: 844개 (86.1%)

### 데이터 구조
현재 D1에 저장된 직업은:
- 커리어넷 OR 고용24 데이터만 각각 저장
- `careernet_id`와 `goyong24_id`가 동시에 있는 직업 = **0개**

---

## 🎯 병합 목표

### 목표 1: 자동 매칭
같은 직업명을 가진 커리어넷 + 고용24 데이터를 자동으로 매칭하여 하나의 페이지에 표시

### 목표 2: 데이터 중복 제거
같은 정보가 양쪽 소스에 있을 경우 우선순위에 따라 하나만 선택

### 목표 3: 데이터 보완
한쪽에만 있는 정보는 보완하여 풍부한 정보 제공

---

## 🔧 병합 전략

### 1단계: 직업명 기반 자동 매칭

**로직:**
```typescript
// 직업명 정규화
const normalizeName = (name: string) => {
  return name
    .toLowerCase()
    .trim()
    .replace(/\s+/g, '')      // 공백 제거
    .replace(/[,·]/g, '')     // 구분자 제거
}

// 커리어넷 직업명 맵 생성
const careernetMap = new Map<string, Job>()
for (const job of careernetJobs) {
  const normalizedName = normalizeName(job.name)
  careernetMap.set(normalizedName, job)
}

// 고용24 직업과 매칭
for (const goyongJob of goyong24Jobs) {
  const normalizedName = normalizeName(goyongJob.name)
  const careernetJob = careernetMap.get(normalizedName)
  
  if (careernetJob) {
    // 매칭 발견! → 병합 처리
    mergeAndUpdate(careernetJob, goyongJob)
  }
}
```

**결과:**
- 136개 직업 자동 매칭
- 844개 직업은 단일 소스만 유지

---

### 2단계: 데이터 병합 규칙

#### 기본 원칙
1. **커리어넷 우선**: 직업명, 분류, 요약 정보
2. **고용24 우선**: 임금, 고용전망, 만족도 (최신 통계)
3. **병합 (Merge)**: 관련 학과, 자격증, 관련 직업 (중복 제거)

#### 필드별 병합 규칙

| 필드 | 병합 방식 | 우선순위 | 이유 |
|------|-----------|---------|------|
| **직업명** (`name`) | 우선 선택 | 커리어넷 | 표준 명칭 |
| **요약** (`summary`) | 병합 (개행) | 커리어넷 + 고용24 | 풍부한 정보 |
| **하는 일** (`duties`) | 우선 선택 | 고용24 | 상세한 설명 |
| **필요 능력** (`abilities`) | 우선 선택 | 고용24 | 구조화된 데이터 |
| **관련 학과** (`relatedMajors`) | 배열 병합 (중복 제거) | 양쪽 | 완전한 목록 |
| **자격증** (`relatedCertificates`) | 배열 병합 (중복 제거) | 양쪽 | 완전한 목록 |
| **임금** (`salary`) | 우선 선택 | 고용24 | 최신 통계 |
| **고용전망** (`prospect`) | 우선 선택 | 고용24 | 최신 통계 |
| **만족도** (`satisfaction`) | 우선 선택 | 고용24 | 최신 통계 |
| **성격 특성** (`personality`) | 우선 선택 | 고용24 | 상세한 데이터 |
| **흥미** (`interests`) | 우선 선택 | 고용24 | 상세한 데이터 |
| **가치관** (`values`) | 우선 선택 | 고용24 | 상세한 데이터 |

---

### 3단계: 현재 코드 분석

#### `src/services/profileMerge.ts` - `mergeJobProfiles()` 함수

**현재 로직:**
```typescript
export const mergeJobProfiles = (
  goyong?: UnifiedJobDetail,
  careernet?: UnifiedJobDetail
): UnifiedJobDetail | null => {
  if (!goyong && !careernet) return null

  const base = goyong ?? careernet!
  const merged: UnifiedJobDetail = {
    ...base,
    id: goyong?.id ?? careernet!.id,
    sourceIds: mergeSourceIds(goyong?.sourceIds, careernet?.sourceIds),
    sources: mergeSources(goyong?.sources, careernet?.sources),
    name: careernet?.name ?? goyong?.name ?? base.name,  // ✅ 커리어넷 우선
    summary: mergeRichText(careernet?.summary, goyong?.summary),  // ✅ 병합
    duties: goyong?.duties ?? careernet?.duties,  // ✅ 고용24 우선
    relatedMajors: mergeRelatedEntities(goyong?.relatedMajors, careernet?.relatedMajors),  // ✅ 병합
    relatedCertificates: mergeCertificates(goyong?.relatedCertificates, careernet?.relatedCertificates),  // ✅ 병합
    salary: goyong?.salary ?? careernet?.salary,  // ✅ 고용24 우선
    satisfaction: goyong?.satisfaction ?? careernet?.satisfaction,  // ✅ 고용24 우선
    prospect: goyong?.prospect ?? careernet?.prospect,  // ✅ 고용24 우선
    abilities: goyong?.abilities ?? careernet?.abilities,  // ✅ 고용24 우선
    personality: goyong?.personality ?? careernet?.personality,  // ✅ 고용24 우선
    interests: goyong?.interests ?? careernet?.interests,  // ✅ 고용24 우선
    values: goyong?.values ?? careernet?.values,  // ✅ 고용24 우선
    // ... 기타 필드
  }

  return merged
}
```

**평가:**
- ✅ **기본 로직 완성**: 대부분의 병합 로직이 이미 구현됨
- ✅ **우선순위 적용**: 커리어넷/고용24 우선순위가 잘 설정됨
- ✅ **중복 제거**: 배열 병합 시 중복 제거 로직 존재
- ⚠️ **문제**: D1에 저장된 데이터가 이미 분리되어 있어 병합 로직이 작동하지 않음

---

## 🚀 해결 방안

### Option 1: 런타임 병합 (추천)
**설명**: 페이지 렌더링 시 직업명 기반으로 양쪽 소스를 조회하여 병합

**장점:**
- D1 데이터 수정 불필요
- 유연한 병합 규칙 적용
- 즉시 적용 가능

**구현:**
```typescript
// src/index.tsx - /job/:slug 라우트 수정
app.get('/job/:slug', async (c) => {
  const slug = c.req.param('slug')
  
  // 1. slug로 직업 조회
  const job = await c.env.DB.prepare(
    'SELECT * FROM jobs WHERE id = ? OR slug = ?'
  ).bind(slug, slug).first()
  
  if (!job) return c.notFound()
  
  // 2. 같은 이름의 다른 소스 직업 찾기
  const otherSourceJob = await c.env.DB.prepare(
    'SELECT * FROM jobs WHERE name = ? AND id != ?'
  ).bind(job.name, job.id).first()
  
  // 3. 병합 처리
  let careernetProfile = null
  let goyong24Profile = null
  
  if (job.careernet_id) {
    careernetProfile = JSON.parse(job.api_data_json).careernet
  }
  if (job.goyong24_id) {
    goyong24Profile = JSON.parse(job.api_data_json).goyong24
  }
  
  if (otherSourceJob) {
    const otherData = JSON.parse(otherSourceJob.api_data_json)
    if (otherData.careernet) careernetProfile = otherData.careernet
    if (otherData.goyong24) goyong24Profile = otherData.goyong24
  }
  
  // 4. 병합 (기존 mergeJobProfiles 사용)
  const merged = mergeJobProfiles(goyong24Profile, careernetProfile)
  
  // 5. 렌더링
  return renderJobDetailPage(merged)
})
```

---

### Option 2: D1 데이터 재구성 (시간 소요)
**설명**: 매칭된 136개 직업의 D1 데이터를 하나로 병합하여 재저장

**장점:**
- 깔끔한 데이터 구조
- 빠른 조회 성능

**단점:**
- D1 데이터 수정 필요
- 시간 소요 (2-3시간)
- 추후 데이터 업데이트 시 재병합 필요

---

## 📋 추천 진행 순서

### 즉시 적용 (Option 1 - 런타임 병합)

1. **Step 1: `/job/:slug` 라우트 수정** (30분)
   - 같은 이름의 다른 소스 직업 조회
   - 병합 처리 (`mergeJobProfiles` 활용)

2. **Step 2: 템플릿 수정** (1-2시간)
   - 병합된 데이터 표시
   - 소스별 섹션 구분 (선택 사항)

3. **Step 3: 테스트** (30분)
   - 매칭된 136개 직업 확인
   - 데이터 중복 제거 확인

---

## 📝 샘플 데이터

### 매칭된 직업 예시 (136개 중 10개)
1. 기업고위임원 (커리어넷: 238, 고용24: K000000847)
2. 행정부고위공무원 (커리어넷: 1278, 고용24: K000000933)
3. 노무사 (커리어넷: 205, 고용24: K000007562)
4. 회계사 (커리어넷: 206, 고용24: K000007449)
5. 관세사 (커리어넷: 207, 고용24: K000007500)
6. 변리사 (커리어넷: 208, 고용24: K000007499)
7. 법무사 (커리어넷: 1332, 고용24: K000007446)
8. 변호사 (커리어넷: 209, 고용24: K000007559)
9. 판사 및 검사 (커리어넷: 211, 고용24: K000007557)
10. 세무사 (커리어넷: 212, 고용24: K000007561)

### 샘플 병합 결과 (기업고위임원)

**커리어넷 데이터:**
- 요약: "기업고위임원은 경영학적 지식을 바탕으로 기업의 기본 경영방침과 목표를 계획하고..."
- 분류: 관리직

**고용24 데이터:**
- 직무개요: 상세한 직무 설명
- 임금: 최신 통계
- 고용전망: 최신 전망

**병합 결과:**
- 이름: 기업고위임원 (커리어넷)
- 요약: 커리어넷 + 고용24 병합
- 직무: 고용24
- 임금: 고용24
- 전망: 고용24

---

**다음 단계**: Option 1 (런타임 병합) 구현 진행

**작성일**: 2025-11-06

