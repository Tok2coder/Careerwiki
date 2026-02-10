# CareerWiki ETL & Seeding 종합 가이드

> **Last Updated**: 2025-12-09  
> **Version**: 2.0  
> **Authors**: CareerWiki Team

---

## 📋 개요

이 문서는 CareerWiki의 직업(Job) 및 전공(Major) 데이터를 수집하고 정규화하는 ETL 프로세스를 설명합니다.

### 데이터 흐름

```
외부 API → *_sources 테이블 (원본) → jobs/majors 테이블 (병합)
```

### 중요 사항

⚠️ **HowTo 데이터는 시딩 대상이 아닙니다!**
- HowTo는 사용자가 에디터에서 직접 작성
- 기존 HowTo를 복구하려면 백업 필요

---

## 🗂️ 아키텍처 원칙

### 1. 원본 보존 (Source Preservation)

모든 외부 API 데이터는 `*_sources` 테이블에 원본 그대로 저장됩니다.

```
job_sources / major_sources
├── raw_payload (원본 JSON)
├── normalized_payload (정규화된 JSON)
├── source_system (CAREERNET, WORK24_JOB, 등)
├── source_type (LIST, DETAIL, DICTIONARY, 등)
└── fetched_at, updated_at
```

### 2. 정규화 (Normalization)

원본 데이터를 `Unified*Detail` 형식으로 변환하여 `normalized_payload`에 저장합니다.

### 3. 통합 (Canonical Entity)

`jobs`, `majors` 테이블에 통합된 엔티티를 저장합니다.

```
jobs / majors
├── canonical_id (내부 식별자)
├── api_data_json (병합된 프로필)
├── ai_data_json (AI 생성 콘텐츠)
├── user_contributed_json (사용자 기여)
└── admin_data_json (관리자 큐레이션)
```

---

## 📁 스크립트 구조

### Runner 스크립트 (`src/scripts/`)

| 파일명 | 용도 | 결과 테이블 |
|--------|------|------------|
| `loadJobDictionaryIndex.ts` | 직업사전 마스터 CSV 로드 | `job_dictionary_index` |
| `runCareerNetJobsSeeding.ts` | 커리어넷 직업 API 시딩 | `job_sources` |
| `runWork24JobsSeeding.ts` | 고용24 직업 API 시딩 | `job_sources` |
| `runWork24JobDictionarySeeding.ts` | 고용24 직업사전 API 시딩 | `job_sources` |
| `runCareerNetMajorsSeeding.ts` | 커리어넷 전공 API 시딩 | `major_sources` |
| `runWork24MajorsSeeding.ts` | 고용24 전공 API 시딩 | `major_sources` |
| `runWork24MajorsCSVSeeding.ts` | 고용24 전공 CSV 시딩 | `major_sources` |
| `runJobMerge.ts` | 직업 프로필 병합 | **`jobs`** |
| `runMajorMerge.ts` | 전공 프로필 병합 | **`majors`** |
| `runRelatedJobs.ts` | 연관 직업 양방향 업데이트 | `jobs` (업데이트) |

### ETL 로직 (`src/scripts/etl/`)

| 파일명 | 설명 |
|--------|------|
| `seedCareerNetJobs.ts` | 커리어넷 직업 시딩 로직 |
| `seedCareerNetMajors.ts` | 커리어넷 전공 시딩 로직 |
| `seedWork24Jobs.ts` | 고용24 직업 시딩 로직 |
| `seedWork24JobDictionary.ts` | 고용24 직업사전 시딩 로직 |
| `seedWork24JobDictionaryFromCSV.ts` | 고용24 직업사전 CSV 시딩 로직 |
| `seedWork24Majors.ts` | 고용24 전공 시딩 로직 |
| `seedWork24MajorsFromCSV.ts` | 고용24 전공 CSV 시딩 로직 |
| `mergeJobProfiles.ts` | 직업 프로필 병합 로직 |
| `mergeMajorProfiles.ts` | 전공 프로필 병합 로직 |
| `updateRelatedJobs.ts` | 연관 직업 양방향 업데이트 로직 |

---

## 🚀 시딩 실행 절차 (로컬 개발 환경)

### 사전 준비

1. **API 키 설정** (`.dev.vars` 파일)
```bash
CAREERNET_API_KEY=your_careernet_api_key
WORK24_API_KEY=your_work24_api_key
```

2. **D1 마이그레이션 적용**
```bash
npx wrangler d1 migrations apply careerwiki --local
```

---

### Phase 1: 직업 데이터 시딩

```bash
# Step 1: 직업사전 마스터 코드 로드 (CSV → job_dictionary_index)
# 결과: 6,581개 레코드 생성
npx tsx src/scripts/loadJobDictionaryIndex.ts

# Step 2: 커리어넷 직업 시딩 (API → job_sources)
npx tsx src/scripts/runCareerNetJobsSeeding.ts
# 옵션: --limit=100 (테스트용)

# Step 3: 고용24 직업 시딩 (API → job_sources)
npx tsx src/scripts/runWork24JobsSeeding.ts

# Step 4: 고용24 직업사전 시딩 (API → job_sources)
# ⚠️ 6,581개 항목 - 시간이 오래 걸립니다 (수 시간)
npx tsx src/scripts/runWork24JobDictionarySeeding.ts
# 옵션: --limit=1000 --offset=0 (분할 실행)

# Step 5: 직업 프로필 병합 (job_sources → jobs)
# 결과: jobs 테이블에 최종 데이터 생성
npx tsx src/scripts/runJobMerge.ts
```

---

### Phase 2: 전공 데이터 시딩

```bash
# Step 6: 커리어넷 전공 시딩 (API → major_sources)
npx tsx src/scripts/runCareerNetMajorsSeeding.ts --track=university
npx tsx src/scripts/runCareerNetMajorsSeeding.ts --track=highschool

# Step 7: 고용24 전공 시딩 (API 또는 CSV → major_sources)
# 방법 A: API 버전
npx tsx src/scripts/runWork24MajorsSeeding.ts

# 방법 B: CSV 버전 (API 불안정 시 사용)
npx tsx src/scripts/runWork24MajorsCSVSeeding.ts

# Step 8: 전공 프로필 병합 (major_sources → majors)
# 결과: majors 테이블에 최종 데이터 생성
npx tsx src/scripts/runMajorMerge.ts
# 옵션: --majorGb=1 (일반학과만), --majorGb=2 (이색학과만)
# 옵션: --name=컴퓨터공학과 (특정 전공만)
```

---

### Phase 3: 후처리 (연관 직업 업데이트)

```bash
# Step 9: 연관 직업 양방향 관계 업데이트
# - 같은 분류코드 직업끼리 연관직업 추가
# - 양방향 관계 보장 (A→B면 B→A도)
# ⚠️ 병합(merge) 후 실행해야 함
npx tsx src/scripts/runRelatedJobs.ts
# 옵션: --limit=100 (테스트용), --dry-run (미리보기)
```

---

### Phase 4: HowTo 데이터

**⚠️ HowTo는 시딩 대상이 아닙니다!**

- HowTo는 사용자가 에디터(`/write`)에서 직접 작성
- `publishService`를 통해 발행
- 기존 HowTo 데이터를 복구하려면 **백업 파일이 필요**
- 백업이 없다면 수동으로 재작성해야 함

---

## 📊 진행 상황 확인

### 테이블별 데이터 개수 확인

```bash
# 개별 테이블 확인
npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) FROM job_dictionary_index;"
npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) FROM job_sources;"
npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) FROM jobs;"
npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) FROM major_sources;"
npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) FROM majors;"
```

### 시딩 로그 확인

```sql
-- 최근 시딩 작업 확인
SELECT * FROM seed_logs ORDER BY started_at DESC LIMIT 10;

-- 실패 항목 확인
SELECT * FROM seed_errors WHERE resolved_at IS NULL;

-- 성공률 확인
SELECT 
  seed_type,
  status,
  total_count,
  success_count,
  failed_count,
  ROUND((success_count * 100.0 / total_count), 2) as success_rate
FROM seed_logs
ORDER BY started_at DESC
LIMIT 20;
```

---

## 🔧 스크립트 옵션

### 공통 옵션

| 옵션 | 설명 | 예시 |
|------|------|------|
| `--limit=N` | 처리할 최대 개수 | `--limit=100` |
| `--skip=true` | 기존 데이터 스킵 | `--skip=true` |

### runJobMerge.ts 전용

| 옵션 | 설명 | 예시 |
|------|------|------|
| `직업명` | 특정 직업만 병합 | `소프트웨어개발자` |

```bash
# 특정 직업만 병합
npx tsx src/scripts/runJobMerge.ts 소프트웨어개발자 데이터분석가
```

### runMajorMerge.ts 전용

| 옵션 | 설명 | 예시 |
|------|------|------|
| `--majorGb=1` | 일반학과만 | `--majorGb=1` |
| `--majorGb=2` | 이색학과만 | `--majorGb=2` |
| `--name=전공명` | 특정 전공만 | `--name=컴퓨터공학과` |

```bash
# 일반학과만 병합
npx tsx src/scripts/runMajorMerge.ts --majorGb=1

# 특정 전공만 병합
npx tsx src/scripts/runMajorMerge.ts --name=스마트폰콘텐츠과
```

---

## 🌐 프로덕션 배포 시

### 로컬 vs 프로덕션

| 환경 | D1 위치 | 시딩 필요 여부 |
|------|---------|---------------|
| 로컬 | `.wrangler/state/v3/d1/` | DB 초기화 시마다 필요 |
| 프로덕션 | Cloudflare D1 | 한 번만 시딩 후 유지 |

### 프로덕션 시딩

```bash
# 프로덕션 D1에 시딩 (--remote 플래그)
npx wrangler d1 execute careerwiki --remote --command "SELECT COUNT(*) FROM jobs;"

# 또는 API 엔드포인트 사용 (관리자 권한 필요)
curl -X POST https://careerwiki.org/api/admin/seed-jobs \
  -H "Authorization: Bearer YOUR_ADMIN_TOKEN"
```

### 재배포 시

- **코드 재배포**: 기존 D1 데이터 유지 (시딩 불필요)
- **D1 초기화**: 시딩 다시 필요

---

## ⚠️ 주의사항

### Rate Limiting

- CareerNet API: **300ms 이상 간격** 권장
- Work24 API: **300ms 이상 간격** 권장
- 대량 시딩 시 `sleep` 추가 필수

### API 안정성

- Work24 목록 API는 `srchType='A'`가 불안정할 수 있음
- 실패 시 CSV 버전 사용 권장

### 데이터 정합성

- `source_key`는 UNIQUE 제약으로 중복 방지
- 병합 전 `*_sources` 테이블에 데이터가 있어야 함

---

## 🔍 트러블슈팅

### 문제: API 타임아웃

**해결:**
- `--limit` 옵션으로 배치 크기 감소
- Rate limiting 간격 증가

### 문제: 메모리 부족

**해결:**
- `--limit` 옵션 사용
- 분할 실행 (`--offset`)

### 문제: D1 초기화됨

**해결:**
1. 마이그레이션 재적용
2. Phase 1~2 전체 재실행

### 문제: 병합 후 jobs/majors가 비어있음

**해결:**
- `job_sources`/`major_sources`에 데이터가 있는지 확인
- 시딩 단계부터 재실행

---

## 📈 예상 소요 시간

| 단계 | 예상 시간 | 비고 |
|------|----------|------|
| job_dictionary_index 로드 | 1~2분 | CSV 파싱 |
| 커리어넷 직업 시딩 | 30분~1시간 | API 호출 |
| 고용24 직업 시딩 | 30분~1시간 | API 호출 |
| 고용24 직업사전 시딩 | **3~6시간** | 6,581개 항목 |
| 직업 병합 | 5~10분 | DB 작업 |
| 커리어넷 전공 시딩 | 20~40분 | API 호출 |
| 고용24 전공 시딩 | 20~40분 | API/CSV |
| 전공 병합 | 5~10분 | DB 작업 |
| 연관 직업 업데이트 | 3~5분 | DB 작업 |

**총 예상 시간**: 5~10시간 (직업사전 포함 시)

---

## 📚 관련 문서

- `src/scripts/etl/README.md` - ETL 스크립트 간단 설명
- `docs/JOB_SOURCES_ARCHITECTURE.md` - job_sources 아키텍처
- `QUICK_REFERENCE.md` - 빠른 참조 가이드
