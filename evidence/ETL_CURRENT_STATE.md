# ETL 현재 상태 (2025-11-28)

## 📦 데이터 흐름

```
외부 API 호출 (CareerNet, 고용24)
  ↓
job_sources / major_sources 테이블 (raw_payload + normalized_payload)
  ↓
name_mappings 테이블 (유사 이름 매핑) ← NEW!
  ↓
mergeJobProfiles.ts / mergeMajorProfiles.ts (ETL 병합 로직)
  ↓
jobs / majors 테이블 (merged_profile_json)
  ↓
unifiedJobDetail.ts / unifiedMajorDetail.ts (템플릿 렌더링)
```

---

## 📊 현재 데이터 현황

### 직업 (Jobs)
- **원본 소스**: ~21,000개 (job_sources)
- **병합 후**: ~6,945개 (jobs)
- **소스 종류**: CAREERNET, WORK24_JOB, WORK24_DJOB
- **이름 매핑**: 166개 (name_mappings)

### 전공 (Majors)
- **원본 소스**: ~619개 (major_sources)
- **병합 후**: ~595개 (majors)
- **소스 종류**: CAREERNET, WORK24_MAJOR
- **이름 매핑**: 24개 (name_mappings)

---

## 🔀 이름 매핑 시스템 (NEW!)

### 배경
- 기존: 정확히 같은 이름만 병합 (예: "간호사" = "간호사")
- 문제: 유사하지만 다른 이름은 별도 항목으로 분리됨
  - 예: "자재·구매사무원" vs "자재구매사무원"
  - 예: "안경광학과" vs "(안경)광학과"

### 해결책: name_mappings 테이블
```sql
CREATE TABLE name_mappings (
    id INTEGER PRIMARY KEY,
    type TEXT NOT NULL CHECK(type IN ('job', 'major')),
    source_name TEXT NOT NULL,  -- 원본 이름
    target_name TEXT NOT NULL,  -- 병합될 대상 이름
    similarity_score REAL,      -- 유사도 점수
    match_reason TEXT,          -- 매칭 이유 (normalized, levenshtein 등)
    is_active INTEGER DEFAULT 1
);
```

### ETL 적용 방식
```typescript
// mergeJobProfiles.ts
const nameMappings = await getNameMappingsForETL(db, 'job')
// 예: { "자재·구매사무원" → "자재구매사무원" }

// 그룹핑 시 매핑 적용
const groupName = nameMappings.get(sourceName) || sourceName
```

### 유사 이름 관리 UI
- **URL**: `/similar-names?type=job` 또는 `/similar-names?type=major`
- **기능**:
  - 유사도 60% 이상 후보 자동 추출
  - 정규화 중복 (띄어쓰기/특수문자 제거 시 동일) 표시
  - 소스별 필터링 (다른 소스 간만 비교)
  - 매핑 선택 및 복사

---

## 🔧 mergeJobProfiles.ts 병합 규칙

### 1️⃣ 이름 매핑 적용 (NEW!)
```typescript
// 1. 매핑 로드
const nameMappings = await getNameMappingsForETL(db, 'job')

// 2. 그룹핑 시 매핑 적용
sources.forEach(source => {
  const name = extractName(source)
  const mappedName = nameMappings.get(name) || name
  groups.get(mappedName).push(source)
})
```

### 2️⃣ 소스 우선순위
```
1순위: CAREERNET (커리어넷 직업백과)
2순위: WORK24_JOB (고용24 직업정보)
3순위: WORK24_DJOB (고용24 직업사전)
```

### 3️⃣ 필드별 병합 로직
- **단일 값 필드**: 우선순위 높은 소스의 값 사용
- **배열 필드**: 모든 소스의 값 병합 후 중복 제거
- **객체 필드**: 깊은 병합 (deep merge)

---

## 🚀 ETL 실행 명령어

### 직업 ETL
```bash
# 전체 직업 병합
npm run etl:merge-jobs

# 관련 직업 업데이트
npm run etl:related-jobs

# 전체 실행 (직업 + 전공 + 관련 직업)
npm run etl:merge-all
```

### 전공 ETL
```bash
# 전체 전공 병합
npm run etl:merge-majors
```

### 이름 매핑 적용
```bash
# SQL 파일로 매핑 추가
npx wrangler d1 execute careerwiki-db --local --file=apply-job-mappings.sql
npx wrangler d1 execute careerwiki-db --local --file=apply-major-mappings.sql

# 매핑 적용 후 ETL 재실행 필요
npm run etl:merge-jobs
npm run etl:merge-majors
```

---

## 📝 디버그 도구

### 1. 유사 이름 관리 UI
```
http://localhost:3000/similar-names?type=job
http://localhost:3000/similar-names?type=major
```

### 2. 상세 페이지 디버그 모드
```
http://localhost:3000/job/lawyer?debug=true
http://localhost:3000/major/computer-science?debug=true
```

### 3. 병합 규칙 설계 UI
```
http://localhost:3000/job-template-design2?job=변호사
```

---

## ⚠️ 주의사항

### ISR 캐시 무효화
템플릿 수정 시 반드시 버전 업데이트:
```typescript
// src/constants/template-versions.ts
export const TEMPLATE_VERSIONS = {
  JOB: 42,    // ← 이 값을 증가시켜야 함!
  MAJOR: 108,
}
```

### 이름 매핑 적용 순서
1. `name_mappings` 테이블에 매핑 추가
2. ETL 재실행 (`npm run etl:merge-jobs` 또는 `npm run etl:merge-majors`)
3. 캐시 무효화 (템플릿 버전 업데이트 또는 ISR 캐시 삭제)

---

## 🔄 향후 계획

### 완료됨 ✅
- 오프라인 병합 시스템 (merged_profile_json)
- 이름 매핑 시스템 (name_mappings)
- 유사 이름 관리 UI (/similar-names)
- 관련 직업 연결 (etl:related-jobs)

### 진행 예정
- 이미지 통합 (Cloudflare Images)
- 자동 병합 스케줄러 (Cloudflare Cron)
- 데이터 품질 모니터링 대시보드
