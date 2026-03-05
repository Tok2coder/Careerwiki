# Phase 14: 데이터 전문가 팀 — 감사 및 개선 리포트

> **날짜**: 2026-03-05
> **팀 구성**: Team Leader(Opus) + DB Architect(Opus) + Pipeline Engineer(Sonnet) + Web Data Specialist(Sonnet) + Search & Vector Engineer(Sonnet)

---

## Phase A: 감사 결과 요약

### 1. Database/Schema (김아키) — 68/100점
- **강점**: 정규화된 스키마, 적절한 인덱싱, 마이그레이션 체계
- **주요 발견**:
  - P0: `LOWER(REPLACE(...))` 풀스캔 — slug 조회마다 전체 테이블 스캔
  - P1: `api_data_json`/`user_contributed_json` JSON blob 최적화 필요
  - P2: 외래키 제약조건 미사용 (SQLite 특성상)

### 2. Data Pipeline/ETL (박파이프) — 58/100점
- **강점**: 기본 ETL 구조, CareerNet 연동 안정적
- **주요 발견**:
  - P0: 하드코딩 API 키 (`careernetAPI.ts`, `vectorize-content.ts`)
  - P0: 에러 발생 시 silent `return null` — 장애 추적 불가
  - P1: Cron Trigger 비활성화 상태
  - P1: 파이프라인 재시도/idempotency 미구현

### 3. External Data Sources (이크롤) — 52/100점
- **강점**: CareerNet API 안정적 연동
- **주요 발견**:
  - P0: Worknet API 미연동 (데이터 커버리지 제한)
  - P1: API 장애 시 fallback 전략 없음
  - P2: 데이터 freshness 모니터링 부재

### 4. Vector Search/Embeddings (정벡터) — 68/100점
- **강점**: OpenAI text-embedding-3-small 파이프라인, cosine 유사도
- **주요 발견**:
  - P0: `expandCandidates`가 `topK=500` 요청하지만 Vectorize 상한 100으로 잘림
  - P1: 임베딩 품질 메트릭 부재
  - P2: 증분 임베딩 업데이트 미구현

---

## Phase B: 개선 작업 (완료)

### B-1: 보안/에러 수정 ✅
**변경 파일**: `src/api/careernetAPI.ts`, `scripts/vectorize-content.ts`

| Before | After |
|--------|-------|
| `const APIKEY = env?.CAREER_NET_API_KEY \|\| 'd9e0285...'` | `throw new Error('CAREER_NET_API_KEY 환경변수 미설정')` |
| `const ACCOUNT_ID = '4a3...'` (하드코딩) | `process.env.CLOUDFLARE_ACCOUNT_ID` (환경변수) |
| `catch { return null }` (silent fail) | `console.error(...)` + `return null` |

**효과**: API 키 유출 위험 제거, 장애 시 로그 추적 가능

### B-2: DB 최적화 (name_normalized) ✅
**변경 파일**: `migrations/0047_add_name_normalized.sql` + 8개 라우트/서비스 파일

| Before | After |
|--------|-------|
| `WHERE LOWER(REPLACE(REPLACE(name,'-',''),' ','')) = ?` | `WHERE name_normalized = ?` |
| 매 쿼리마다 전체 테이블 스캔 (6,945행) | 인덱스 조회 (O(log n)) |

**적용 파일**:
- `src/services/profileDataService.ts` (2개소)
- `src/services/editService.ts` (1개소)
- `src/routes/content-editor.ts` (2개소)
- `src/routes/api-data.ts` (3개소)
- `src/routes/major-detail.ts` (1개소)
- `src/routes/job-detail.ts` (1개소)
- `src/routes/major-editor.ts` (1개소)
- `src/routes/job-editor.ts` (2개소)

**효과**: 페이지 조회 속도 개선 (특히 슬러그 기반 라우팅)

### B-3: 벡터 검색 Multi-Query ✅
**변경 파일**: `src/services/ai-analyzer/vectorize-pipeline.ts` (+125행)

| Before | After |
|--------|-------|
| `searchCandidates(topK=500)` → 실제 100개 반환 | `searchCandidatesMultiQuery(3-6개 쿼리)` → 300-600개 반환 |
| 단일 종합 쿼리 | 차원별 분해 (관심, 가치, 강점, 워크스타일, 심층답변) |

**새 함수**: `buildMultiSearchQueriesFromFacts(facts)`
- facts 배열을 5개 차원(interest/value/strength/workstyle/deep-intake)으로 분해
- 각 차원별 topK=100 쿼리 → 중복 제거 후 합산
- 종합 쿼리(fallback) 포함하여 최소 1개 보장

**효과**: AI 추천 후보 풀 3-6배 확대, 다양성 향상

---

## 미수행 항목 (외부 의존)

| 항목 | 이유 | 권장 시기 |
|------|------|----------|
| Cron Trigger 활성화 | Cloudflare 대시보드 설정 필요 | Phase 15 |
| Worknet API 연동 | API 키 발급 + 별도 ETL 개발 필요 | Phase 16 |

---

## 배포 기록

- **Commit**: `3d2d404` on `main`
- **Migration**: `0047_add_name_normalized.sql` (프로덕션 D1 적용 완료)
- **배포 URL**: `https://9d46632e.careerwiki-phase1.pages.dev`
- **프로덕션 검증**: careerwiki.org 직업/전공 페이지 정상 동작 확인
