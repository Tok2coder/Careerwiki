# ETL 병합 시스템 가이드

## 🎯 개요

CareerWiki는 **오프라인 ETL 병합 시스템**을 사용합니다.
- Raw 데이터: `job_sources`, `major_sources` 테이블
- 병합 데이터: `jobs.merged_profile_json`, `majors.merged_profile_json` 컬럼
- 렌더링: 병합된 데이터만 사용 (실시간 병합 없음)

---

## 📁 파일 구조

### ETL 스크립트
```
src/scripts/etl/
├── mergeJobProfiles.ts       # 직업 병합 로직
├── mergeMajorProfiles.ts     # 전공 병합 로직
└── (seeding scripts)         # 데이터 시딩 스크립트들

src/scripts/
├── runJobMerge.ts            # 직업 병합 실행기
└── runMajorMerge.ts          # 전공 병합 실행기
```

### 병합 유틸리티
```
src/services/
├── profileMerge.ts           # ETL 병합 로직 (공통 유틸리티)
├── profileDataService.ts     # 렌더링용 데이터 로더
└── jobDataMerger.ts          # 편집 UI용 데이터 변환 (ETL과 별개)
```

---

## 🚀 사용법

### 1️⃣ 직업 병합

```bash
# 전체 직업 병합
npm run etl:merge-jobs

# 100개만 병합 (테스트용)
npm run etl:merge-jobs:limit

# 특정 개수 지정
npm run etl:merge-jobs:limit -- --limit=50
```

### 2️⃣ 전공 병합

```bash
# 전체 전공 병합
npm run etl:merge-majors

# 100개만 병합 (테스트용)
npm run etl:merge-majors:limit
```

### 3️⃣ 전체 병합

```bash
# 직업 + 전공 모두 병합
npm run etl:merge-all
```

---

## 🔄 병합 프로세스

### 1. 데이터 흐름

```
job_sources (Raw)
├── CAREERNET
├── WORK24_JOB
└── WORK24_DJOB
     ↓
[mergeJobProfiles.ts]
     ↓
jobs.merged_profile_json
     ↓
[profileDataService.ts]
     ↓
렌더링 (템플릿)
```

### 2. 병합 규칙

**소스 우선순위**:
- 직업: `CAREERNET` > `WORK24_JOB` > `WORK24_DJOB`
- 전공: `CAREERNET` > `WORK24_MAJOR`

**필드별 전략**:
- 단일 값 필드 (name, summary 등): 우선순위 기준 선택
- 배열 필드 (skills, tasks 등): 중복 제거 후 병합
- 객체 필드 (salary, satisfaction 등): 우선순위 기준 선택

### 3. 병합 그룹화 기준

- **이름 완전 일치** (`normalized_payload.name`)
- 예: "변호사" = "변호사" → 동일 엔티티
- 유사어, fuzzy matching 등 사용 안 함

---

## 📊 출력 형식

### `merged_profile_json` 구조

```json
{
  "name": "변호사",
  "slug": "lawyer",
  "sources": {
    "CAREERNET": { "id": "11101", "data": {...} },
    "WORK24_JOB": { "id": "149010", "data": {...} },
    "WORK24_DJOB": { "id": "K000007482", "data": {...} }
  },
  "merged": {
    "summary": "법률 자문과 소송 대리...",
    "duties": "계약서 검토, 소송 진행...",
    "relatedMajors": [...],
    "relatedCertificates": [...],
    "salary": {...},
    "satisfaction": {...},
    ...
  }
}
```

---

## 🔧 렌더링 로직

### profileDataService.ts

```typescript
// 1. merged_profile_json 우선 사용
const job = await db.prepare(`
  SELECT merged_profile_json FROM jobs WHERE slug = ?
`).bind(slug).first()

if (job?.merged_profile_json) {
  return JSON.parse(job.merged_profile_json)
}

// 2. Fallback: api_data_json (하위 호환)
// ETL 미실행 데이터용
```

---

## ⚠️ 주의사항

### 1. 실시간 병합 안 함
- 유저 요청 시 병합 안 함
- ETL로 미리 병합된 데이터만 사용

### 2. 소스 테이블 직접 사용 금지
- `job_sources`, `major_sources`는 ETL 전용
- 프론트엔드/SSR에서 직접 조회 금지
- 디버그/관리자 페이지에서만 사용 가능

### 3. Fallback 유지
- `api_data_json` fallback은 유지
- ETL 미실행 데이터에 대한 하위 호환

### 4. 편집 기능
- `jobDataMerger.ts`는 ETL과 별개
- 편집 UI에서만 사용 (API 응답 → 구조화)

---

## 🛠️ 트러블슈팅

### Q: 병합 후 페이지에 반영 안 됨
```bash
# ISR 캐시 무효화 필요
# /job/:slug?cache=refresh 접속
```

### Q: FOREIGN KEY 제약 위반
```
✅ 이미 수정됨: jobs 테이블 먼저 생성 후 job_sources 업데이트
```

### Q: 특정 직업/전공만 재병합하려면?
```bash
# 현재 미지원 (전체 재실행만 가능)
# TODO: 개별 엔티티 병합 기능 추가
```

---

## 📝 로그 확인

### 병합 진행 상황

```bash
npm run etl:merge-jobs
```

출력:
```
🔄 [1/100] 변호사 → ✅ jobs.id=1
🔄 [2/100] 의사 → ✅ jobs.id=2
...
📊 FINAL SUMMARY
Total:   100
Success: 100
Failed:  0
Time:    28s
```

### 에러 발생 시

```
❌ [변호사] JSON parse error
```

→ `job_sources` 테이블의 `raw_payload`/`normalized_payload` 확인

---

## 🔗 관련 문서

- **데이터베이스 스키마**: `docs/D1_DATABASE_STRUCTURE.md`
- **ETL 시딩 가이드**: `docs/ETL_SEEDING_GUIDE.md`
- **아키텍처 문서**: `docs/ARCHITECTURE.md`
- **프로젝트 상태**: `docs/PROJECT_STATUS.md`

---

## 🎯 Next Steps

1. ✅ ETL 스크립트 완성
2. ✅ 렌더링 로직 리팩토링
3. ⏳ 개별 엔티티 병합 기능
4. ⏳ 병합 규칙 UI 설계 (선택적)
5. ⏳ 자동 병합 스케줄러 (Cloudflare Cron)

---

**최종 업데이트**: 2025-11-21






