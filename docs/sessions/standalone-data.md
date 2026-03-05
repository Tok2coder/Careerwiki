# Standalone — Phase 14: 데이터 전문가 팀

> **이 파일을 읽고 Team Leader로서 작업을 시작하세요.**
> Wave와 독립적으로 언제든 실행 가능합니다.

---

## 1. 공통 컨텍스트

### 프로젝트 개요
- **CareerWiki**: 한국어 진로 정보 위키 + AI 직업/전공 추천 플랫폼
- **Production**: https://careerwiki.org
- **Tech Stack**: Cloudflare Workers (Pages) + Hono + D1 (SQLite) + R2 + KV + Vectorize
- **AI/LLM**: Workers AI, OpenAI API (GPT-4o-mini)
- **데이터 규모**: 608개 전공 + 6,945개 직업
- **벡터 검색**: Cloudflare Vectorize (OpenAI text-embedding-3-small, 1536d, cosine)

### 필수 읽기 파일
1. `CLAUDE.md` — 프로젝트 규칙 전체 (빌드/배포 파이프라인, 자가 검증 포함)
2. `MASTER_PLAN.md` — 전체 Phase 목록 및 진행 상태

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 담당 영역 |
|------|------|----------|----------|
| Team Leader | Opus (메인) | 메인 세션 | 전체 조율, 우선순위 결정, 유저 보고, 최종 검증 |
| Database Architect | **Opus** | Task(run_in_background) | **스토리지 계층**: D1/SQLite 스키마, 인덱싱, 쿼리 최적화, 마이그레이션 전략 |
| Data Pipeline Engineer | Sonnet | Task(run_in_background) | **수집 계층**: ETL, 외부 API 연동, 데이터 정규화, 파이프라인 자동화 |
| Web Data Specialist | Sonnet | Task(run_in_background) | **탐색 계층**: 외부 데이터 발굴, 웹 스크래핑, 신규 API/소스 통합 |
| Search & Vector Engineer | Sonnet | Task(run_in_background) | **검색 계층**: Vectorize, 임베딩, RAG 검색 품질, 관련성 튜닝 |

### MECE 역할 분담

```
데이터 생명주기:

  [발굴/수집]        [가공/저장]        [검색/활용]
      │                  │                  │
  Web Data          Data Pipeline      Search & Vector
  Specialist        Engineer           Engineer
  (어디서 가져올까?)  (어떻게 넣을까?)    (어떻게 찾을까?)
                         │
                  Database Architect
                  (어떻게 저장할까?)
```

- **Web Data Specialist**: 데이터의 **입구** — 어떤 외부 소스가 있는지, 어떻게 가져올 수 있는지
- **Data Pipeline Engineer**: 데이터의 **흐름** — 가져온 데이터를 정규화하고 DB에 넣는 파이프라인
- **Database Architect**: 데이터의 **기반** — 스키마 설계, 쿼리 성능, 저장 최적화
- **Search & Vector Engineer**: 데이터의 **출구** — 저장된 데이터를 사용자에게 정확히 전달

---

## 3. 팀 시작 절차

### Team Leader가 할 일

```
1. TeamCreate("data-team") 생성
2. 아래 4명을 Task(run_in_background=true)로 동시 스폰
3. 각 에이전트에게 Phase 1 (감사) 작업 할당
4. 결과 수집 → 우선순위 정리 → Phase 2 (개선) 진행
```

### 스폰 템플릿

```typescript
// Database Architect (Opus)
Task({
  name: "db-architect",
  model: "opus",
  subagent_type: "general-purpose",
  run_in_background: true,
  team_name: "data-team",
  prompt: `너는 Database Architect "김아키"야.
    docs/sessions/standalone-data.md의 "Database Architect 체크리스트"를 읽고 작업해.
    CLAUDE.md를 먼저 읽어. 코드 변경 시 자가 검증 프로토콜 필수.`
})

// Data Pipeline Engineer (Sonnet)
Task({
  name: "pipeline-engineer",
  model: "sonnet",
  subagent_type: "general-purpose",
  run_in_background: true,
  team_name: "data-team",
  prompt: `너는 Data Pipeline Engineer "박파이프"야.
    docs/sessions/standalone-data.md의 "Data Pipeline Engineer 체크리스트"를 읽고 작업해.
    CLAUDE.md를 먼저 읽어. 코드 변경 시 자가 검증 프로토콜 필수.`
})

// Web Data Specialist (Sonnet)
Task({
  name: "web-data-specialist",
  model: "sonnet",
  subagent_type: "general-purpose",
  run_in_background: true,
  team_name: "data-team",
  prompt: `너는 Web Data Specialist "이크롤"이야.
    docs/sessions/standalone-data.md의 "Web Data Specialist 체크리스트"를 읽고 작업해.
    CLAUDE.md를 먼저 읽어.`
})

// Search & Vector Engineer (Sonnet)
Task({
  name: "search-vector-engineer",
  model: "sonnet",
  subagent_type: "general-purpose",
  run_in_background: true,
  team_name: "data-team",
  prompt: `너는 Search & Vector Engineer "정벡터"야.
    docs/sessions/standalone-data.md의 "Search & Vector Engineer 체크리스트"를 읽고 작업해.
    CLAUDE.md를 먼저 읽어. 코드 변경 시 자가 검증 프로토콜 필수.`
})
```

---

## 4. 작업 흐름 (2 Phase)

### Phase A: 감사 & 분석 (모든 에이전트 병렬)

각 에이전트가 자기 영역을 분석하고 현황 리포트를 Team Leader에게 제출.
**코드 수정 없음** — 분석만.

### Phase B: 개선 & 구현 (Team Leader 승인 후)

Phase A 결과를 기반으로 Team Leader가 우선순위를 정하고,
에이전트별로 개선 작업 할당.
**코드 수정 시 CLAUDE.md 자가 검증 프로토콜 필수**.
**배포 시 한 번에 하나만** `npm run deploy`.

---

## 5. 에이전트별 체크리스트

### Database Architect 체크리스트

**Phase A: D1/SQLite 감사**

핵심 파일:
- `migrations/` 전체 (0001~0045) — 스키마 진화 이력
- `src/services/profileDataService.ts` — 데이터 접근 패턴
- `src/services/editService.ts` — 편집 시 DB 쓰기 패턴
- `src/services/cacheService.ts` — ISR 캐싱 로직
- `wrangler.jsonc` — 바인딩 설정

점검 항목:
1. **인덱스 감사**
   - 모든 테이블의 현재 인덱스 확인 (`wrangler d1 execute careerwiki-kr --remote --command "SELECT * FROM sqlite_master WHERE type='index'"`)
   - 자주 사용되는 WHERE/JOIN/ORDER BY 컬럼에 인덱스가 있는지
   - 불필요한 인덱스 (쓰기 성능 저하 원인) 식별
   - 복합 인덱스 최적화 기회

2. **스키마 정규화**
   - 중복 데이터 저장 패턴 (jobs.raw_payload vs job_sources.raw_payload 등)
   - JSON 컬럼 (api_data_json, user_contributed_json, aggregated_profile_json) 사용 패턴 검토
   - SQLite JSON 함수 활용 가능성

3. **쿼리 성능**
   - 프로덕션에서 실행되는 주요 쿼리 패턴 식별
   - N+1 쿼리 문제 여부
   - 풀 테이블 스캔 위험 쿼리
   - D1 특유의 제한사항 (트랜잭션, 동시성)

4. **마이그레이션 건전성**
   - 0001~0045 마이그레이션 이력 일관성
   - 레거시 테이블 (사용하지 않는 테이블) 식별
   - 향후 마이그레이션 전략 제안

5. **현대 SQLite 활용**
   - FTS5 (Full-Text Search) 도입 가능성
   - Window Functions 활용 기회
   - CTE (Common Table Expressions) 최적화
   - STRICT 모드 활용 여부

6. **D1 플랫폼 최적화**
   - Batch API 활용 (`db.batch()`)
   - 읽기/쓰기 분리 전략
   - 연결 재시도 패턴 (`withD1Retry`) 검토
   - D1 크기 제한 (500MB free, 5GB paid) 관리

**Phase B: 개선 작업 (Team Leader 승인 후)**
- 인덱스 추가/삭제 마이그레이션 생성
- 쿼리 리팩토링
- 스키마 정규화 마이그레이션
- 성능 벤치마크 (Before/After)

---

### Data Pipeline Engineer 체크리스트

**Phase A: 파이프라인 감사**

핵심 파일:
- `src/api/careernetAPI.ts` — 커리어넷 API 클라이언트
- `src/api/goyong24API.ts` — 고용24 API 클라이언트
- `src/services/profileDataService.ts` — 데이터 통합 (deepMergeProfile)
- `scripts/` — ETL 스크립트 전체
  - `vectorize-content.ts` — 벡터화 파이프라인
  - `batch-tagger.ts` — 배치 태깅
  - `restore-job-data.ts`, `refetch-job-data.ts` — 데이터 복원/갱신
- `migrations/010_add_aggregated_profile.sql` — 통합 프로필 스키마

점검 항목:
1. **API 통합 현황**
   - CareerNet API: 호출 패턴, 에러 핸들링, 레이트 리밋 처리
   - Goyong24 API: 호출 패턴, XML 파싱 안정성
   - API 응답 캐싱 전략 (불필요한 재호출 방지)
   - API 키 로테이션/만료 처리

2. **데이터 정규화 품질**
   - `normalize*()` 함수 — 누락 필드, 타입 불일치
   - XML 엔티티 디코딩 정확성
   - 중첩 객체 파싱 안정성 (깊은 재귀)
   - 한국어 특수 인코딩 처리

3. **ETL 파이프라인 자동화**
   - 현재 수동 실행되는 스크립트 → 자동화 가능성
   - Cloudflare Cron Triggers 활용 (예: 매주 데이터 갱신)
   - 파이프라인 실패 시 알림/복구 전략
   - 증분 업데이트 vs 전체 갱신

4. **데이터 신선도**
   - 외부 API 데이터의 마지막 갱신 시점
   - 오래된 데이터 식별 (6개월+ 미갱신 직업/전공)
   - 갱신 주기 권장안

5. **deepMergeProfile 로직**
   - 병합 충돌 처리 (같은 필드에 다른 소스 데이터)
   - user_contributed_json 우선순위
   - admin_override 처리

6. **에러 핸들링 & 복원력**
   - `withD1Retry` 패턴 적절성
   - API 타임아웃 처리
   - 부분 실패 시 롤백/재시도 전략

**Phase B: 개선 작업 (Team Leader 승인 후)**
- API 클라이언트 리팩토링
- Cron Trigger 기반 자동 갱신 파이프라인 구현
- 에러 핸들링 강화
- 데이터 품질 대시보드 (관리자 페이지)

---

### Web Data Specialist 체크리스트

**Phase A: 외부 데이터 소스 분석**

핵심 파일:
- `src/api/` — 현재 연동된 API 목록
- `src/services/profileDataService.ts` — 데이터 소스 타입 정의
- `src/types/` — 데이터 타입 구조

점검 항목:
1. **현재 데이터 소스 현황**
   - CareerNet (한국교육개발원): 제공 데이터 범위, 품질, 한계
   - Goyong24 (고용24): 제공 데이터 범위, 품질, 한계
   - 각 소스의 커버리지 (직업 6,945개 중 몇 %?)

2. **추가 가능한 한국 데이터 소스 조사**
   - **워크넷** (work.go.kr): 채용공고, 직업 전망
   - **한국직업능력연구원** (krivet.re.kr): 직업 통계, 연구 데이터
   - **통계청** (kostat.go.kr): 경제활동인구조사, 임금 통계
   - **학과정보** (대학알리미, 대입정보포털): 학과별 취업률, 정원
   - **자격증 정보** (Q-net): 자격증-직업 연결
   - 각 소스의 API 유무, 접근 방법, 데이터 형태, 라이선스

3. **해외 데이터 소스 벤치마킹**
   - **O*NET** (미국): 직업 스킬/능력/관심사 분류 체계
   - **ISCO** (국제): 국제 직업 분류
   - CareerWiki에 응용 가능한 데이터 구조/분류 체계

4. **데이터 갭 분석**
   - 직업별 누락 필드 통계 (급여, 전망, 필요 역량 등)
   - 전공별 누락 필드 통계 (취업률, 관련 직업 등)
   - 사용자 가치 높은 정보 중 미확보 항목

5. **웹 스크래핑 전략**
   - 법적/윤리적 고려사항 (robots.txt, 이용약관)
   - 기술적 접근 방법 (Cloudflare Workers 내 fetch, Puppeteer 대안)
   - 데이터 갱신 주기 및 자동화 방안

6. **데이터 통합 제안**
   - 신규 소스별 데이터 매핑 (기존 스키마와 연결)
   - 데이터 품질 검증 방법
   - 구현 우선순위 (노력 대비 가치)

**Phase B: 신규 소스 통합 (Team Leader 승인 후)**
- 우선순위 높은 소스 API 클라이언트 구현
- 데이터 매핑 및 정규화 함수 작성
- 통합 테스트
- 데이터 갱신 파이프라인에 편입

---

### Search & Vector Engineer 체크리스트

**Phase A: 검색 & 벡터 감사**

핵심 파일:
- `src/services/rag-search.ts` — RAG 통합 검색
- `src/services/ai-analyzer/vectorize-pipeline.ts` — Multi-Query 벡터 검색
- `scripts/vectorize-content.ts` — 임베딩 생성 스크립트
- `scripts/run-calibration.ts` — 스코어 보정
- `scripts/rag-test-*.js` — RAG 테스트 스크립트
- `scripts/eval-quality.js`, `eval-noise.js` — 품질/노이즈 평가

점검 항목:
1. **임베딩 커버리지**
   - 전체 직업/전공 중 벡터화된 비율 확인
   - 임베딩 메타데이터 (`embedding_metadata` 테이블) 분석
   - 누락된 임베딩 식별 및 재생성 계획

2. **벡터 검색 품질**
   - `MIN_VECTOR_SCORE` 임계값 (0.30 / 0.40) 적절성
   - topK=100 제한 → Multi-Query 배치 효율성
   - 검색 결과 관련성 (precision/recall)
   - 기존 RAG 테스트 결과 분석 (`scripts/rag-test-*.js` 실행 결과)

3. **쿼리 전처리 품질**
   - `SLANG_DICTIONARY` 완성도 (속어/은어 커버리지)
   - 한국어 형태소 분석 필요성 검토
   - 동의어/유의어 확장 전략
   - 오타 보정 가능성

4. **Vectorize 인덱스 최적화**
   - 현재 인덱스 설정 (cosine, 1536d) 적절성
   - 인덱스 크기 및 쿼리 지연시간
   - 메타데이터 필터링 활용 여부
   - 네임스페이스 분리 전략 (직업/전공/HowTo)

5. **AI 추천 파이프라인과의 연결**
   - `vectorize-pipeline.ts` — Multi-Query 생성 품질
   - 후보 풀 확장 (600-800개) 효율성
   - TAG 필터와의 상호작용

6. **검색 분석 & 메트릭**
   - `serp_interaction_logs` 데이터 활용
   - 검색 쿼리 패턴 분석 (인기 검색어, 실패 검색어)
   - 클릭률 (CTR) 기반 관련성 피드백
   - 검색 품질 자동 평가 체계

**Phase B: 개선 작업 (Team Leader 승인 후)**
- 누락 임베딩 재생성
- MIN_VECTOR_SCORE 재보정
- SLANG_DICTIONARY 확장
- 검색 품질 메트릭 대시보드
- RAG 파이프라인 최적화

---

## 6. 현재 데이터 인프라 현황

### DB 테이블 구조 (주요)

| 카테고리 | 테이블 | 용도 |
|---------|--------|------|
| **마스터 데이터** | `jobs`, `majors` | 직업/전공 마스터 (6,945 + 608) |
| **소스 데이터** | `job_sources`, `major_sources` | 소스별 원본 (CareerNet, Goyong24) |
| **속성 데이터** | `job_attributes`, `major_attributes` | TAG 속성 (검색 필터) |
| **캐시** | `wiki_pages` | ISR 렌더링 캐시 |
| **편집 이력** | `page_revisions` | 위키 편집 히스토리 |
| **AI 분석** | `ai_sessions`, `ai_analysis_*` | 추천 세션/결과 |
| **콘텐츠** | `howtos`, `howto_drafts`, `howto_tags` | HowTo 문서 |
| **사용자** | `users`, `user_sessions`, `user_bookmarks` | 인증/세션/북마크 |
| **로깅** | `serp_interaction_logs`, `daily_view_stats` | 검색/조회 추적 |
| **벡터** | `embedding_metadata` | 임베딩 메타 추적 |

### 외부 API 현황

| API | 제공처 | 데이터 | 응답 형식 |
|-----|--------|--------|----------|
| CareerNet | 한국교육개발원 | 직업/전공 상세, 검색 | XML |
| Goyong24 | 고용24 (work24) | 직업/전공 목록/상세 | XML |

### 데이터 흐름

```
외부 API (CareerNet, Goyong24)
    │ XML 응답
    ▼
normalize*() — XML → Unified 타입 변환
    │
    ▼
profileDataService — deepMergeProfile()
    │ api_data_json + user_contributed_json = aggregated_profile_json
    ▼
D1 (jobs, majors, job_sources, major_sources)
    │
    ├──→ vectorize-content.ts — OpenAI embedding → Vectorize 인덱스
    │
    ├──→ rag-search.ts — 슬랭 확장 → 벡터 검색 → DB 조회 → 결과
    │
    └──→ wiki_pages (ISR 캐시) — 렌더링 후 캐시
```

---

## 7. 산출물

### 필수 산출물
1. **데이터 인프라 감사 리포트** (`docs/reports/data-audit-YYYY-MM-DD.md`)
   - 각 영역별 현황, 문제점, 개선 권고
2. **개선 작업 완료 코드** (Phase B에서 실제 코드 수정)
3. **진행 상태 파일** (`docs/phase-progress/phase-14-state.md`)

### 리포트 구조
```markdown
# CareerWiki 데이터 인프라 감사 리포트

## Executive Summary
- 전체 데이터 건전성 점수: X/100
- 핵심 발견사항 3줄 요약

## 1. Database & Schema
- 현황, 인덱스 분석, 쿼리 성능, 개선안

## 2. Data Pipeline
- API 통합 현황, 파이프라인 안정성, 자동화 수준

## 3. External Data Sources
- 현재 소스 평가, 신규 소스 후보, 데이터 갭

## 4. Search & Vector
- 임베딩 커버리지, 검색 품질, 관련성 메트릭

## 5. 개선 로드맵
| 우선순위 | 작업 | 영향 | 노력 | 담당 |
|---------|------|------|------|------|
| P0 | ... | 높음 | 낮음 | ... |
| P1 | ... | 높음 | 중간 | ... |
```

---

## 8. 배포 규칙

- Phase A (감사): 배포 없음, 읽기 전용 분석
- Phase B (개선): `CLAUDE.md`의 배포 파이프라인 준수
  - `npx tsc --noEmit` → `npm run build` → `npm run deploy`
  - 한 번에 하나만 deploy (다른 Phase와 동시 배포 금지)
  - 마이그레이션 추가 시: `npm run db:migrate:prod` 선행
- **절대 금지**: `DROP TABLE`, `DELETE FROM` (WHERE 없이), `.dev.vars` 커밋
- DB 스키마 변경 시 반드시 Team Leader 승인 후 진행

---

## 9. Context Compact 복원

컨텍스트가 compact되면:
1. 이 파일 (`docs/sessions/standalone-data.md`) 다시 읽기
2. `docs/phase-progress/phase-14-state.md` 읽기
3. `git log --oneline -5` 확인
4. Team Leader의 가장 최근 메시지 확인
