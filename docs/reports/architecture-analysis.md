# Architecture Analysis Report

**프로젝트**: CareerWiki (한국어 진로 정보 위키 + AI 직업/전공 추천)
**분석일**: 2026-03-03
**분석자**: 김분석 (Architecture Analyst)
**코드베이스 규모**: 223개 TypeScript 파일 / 150,010 줄

---

## 1. 프로젝트 구조

### 1.1 디렉토리 구조

```
src/                          (150,010 줄, 223 파일)
├── index.tsx                  # 엔트리포인트 (194줄) — 깔끔한 라우트 등록
├── renderer.tsx               # Hono JSX 렌더러 (12줄)
├── api/                       # 외부 API 클라이언트 (2,690줄, 2 파일)
│   ├── careernetAPI.ts        # CareerNet 공공 API
│   └── goyong24API.ts         # 고용24 API
├── components/                # 공유 UI 컴포넌트 (239줄, 1 파일)
├── config/                    # 설정 (128줄, 2 파일)
├── constants/                 # 상수 (116줄, 2 파일)
├── data/                      # 샘플/시드 데이터 (967줄, 1 파일)
├── editor/                    # TipTap 에디터 (3,505줄, 16 파일)
├── middleware/                 # 인증 미들웨어 (241줄, 1 파일)
├── routes/                    # HTTP 라우트 핸들러 (33,649줄, 22 파일)
├── scripts/                   # ETL/마이그레이션 스크립트 (7,917줄, 35 파일)
├── services/                  # 비즈니스 로직 (63,723줄, 78 파일)
│   └── ai-analyzer/           # AI 추천 엔진 (45,321줄, 47 파일)
├── templates/                 # HTML 렌더링 (29,524줄, 35 파일)
├── types/                     # TypeScript 타입 (1,345줄, 6 파일)
└── utils/                     # 유틸리티 (5,760줄, 17 파일)

migrations/                    # D1 스키마 마이그레이션 (42 파일)
public/static/                 # 정적 에셋 (13 파일)
tests/                         # 테스트 (1 파일, 208줄)
docs/                          # 문서 (50+ 파일)
scripts/                       # 루트 레벨 스크립트 (Python, JS)
```

### 1.2 파일 크기 분포 (Top 15)

| 순위 | 파일 | 줄 수 | 비고 |
|---:|------|-----:|------|
| 1 | `routes/analyzer-job-page.ts` | 10,052 | **심각** — 단일 GET 핸들러에 10K줄 (인라인 HTML+JS+CSS) |
| 2 | `services/ai-analyzer/routes.ts` | 8,154 | **심각** — AI API 라우트 전체가 단일 파일 |
| 3 | `routes/analyzer-major-page.ts` | 5,063 | **경고** — 동일 패턴 (인라인 HTML) |
| 4 | `templates/unifiedJobDetail.ts` | 5,027 | 대형 템플릿이나 역할 적합 |
| 5 | `routes/howto.ts` | 3,390 | 다수 핸들러 포함 |
| 6 | `services/profileDataService.ts` | 3,354 | 데이터 통합 핵심 서비스 |
| 7 | `services/ai-analyzer/vectorize-pipeline.ts` | 3,330 | 벡터 검색 파이프라인 |
| 8 | `templates/unifiedMajorDetail.ts` | 2,979 | 대형 템플릿 |
| 9 | `templates/dataDebugTemplate.ts` | 2,861 | 디버그 전용 — 프로덕션 필요성 의문 |
| 10 | `services/rag-search.ts` | 2,802 | RAG 검색 |
| 11 | `services/ai-analyzer/llm-judge.ts` | 2,433 | LLM 스코어링 |
| 12 | `routes/user.ts` | 2,334 | 유저 관련 라우트 |
| 13 | `services/ai-analyzer/llm-reporter.ts` | 2,319 | 리포트 생성 |
| 14 | `templates/jobMergeDesigner.tsx` | 2,233 | 관리 도구 |
| 15 | `services/ai-analyzer/fact-score-mapping.ts` | 2,221 | 팩트-점수 매핑 |

**통계**:
- 1,000줄 초과 파일: ~30개 (전체 13%)
- 3,000줄 초과 파일: 7개
- 5,000줄 초과 파일: 4개 (**구조적 위험**)
- 평균 파일 크기: 673줄

### 1.3 모듈 의존성

**의존성 방향 (단방향, 순환 없음):**

```
index.tsx
  └── routes/*          → services/*, templates/*, utils/*, types/*
      ├── services/     → api/*, utils/*, types/*, constants/*
      │   └── ai-analyzer/ → utils/*, constants/* (상위 services 참조 없음)
      ├── templates/    → services/*, utils/*, types/*
      └── middleware/   → utils/*
```

- **순환 의존성: 0건** — `services/`가 `routes/`를 import하는 경우 없음. `templates/`가 `routes/`를 import하는 경우 없음. ai-analyzer가 상위 services를 import하는 경우 없음.
- **의존성 방향**: 올바른 단방향 레이어드 아키텍처 준수

**주요 의존 허브:**
- `profileDataService.ts` — 7개 라우트에서 참조 (데이터 레이어의 핵심)
- `shared-helpers.ts` — 10+ 파일에서 참조 (유틸리티 허브)
- `cacheService.ts` — 5개 라우트/서비스에서 참조
- `editService.ts` — 4개 에디터 라우트에서 참조

### 1.4 관심사 분리 평가

| 레이어 | 줄 수 | 비중 | 평가 |
|--------|-----:|-----:|------|
| Routes (라우트) | 33,649 | 22.4% | **비대** — 라우트에 비즈니스 로직 혼재 |
| Services (서비스) | 63,723 | 42.5% | 적절 — 핵심 비즈니스 로직 집중 |
| Templates (프레젠테이션) | 29,524 | 19.7% | 적절 |
| Utils/Types/Config | 7,588 | 5.1% | 적절 |
| Scripts (빌드/ETL) | 7,917 | 5.3% | 런타임에 불필요한 코드 포함 |
| Editor (클라이언트) | 3,505 | 2.3% | 적절 |
| API (외부 연동) | 2,690 | 1.8% | 적절 |

**핵심 문제**: `analyzer-job-page.ts`(10,052줄)와 `analyzer-major-page.ts`(5,063줄)가 라우트 파일이면서 HTML/CSS/JS를 인라인으로 포함. 이는 라우트-템플릿 분리 원칙을 위반하며, 전체 `routes/` 줄 수의 45%를 차지.

---

## 2. 코드 품질 지표

### 2.1 `any` 타입 사용 (575건)

| 파일 | 건수 | 심각도 |
|------|-----:|--------|
| `services/profileDataService.ts` | 45 | 높음 — 핵심 데이터 서비스 |
| `templates/unifiedJobDetail.ts` | 44 | 높음 |
| `services/ai-analyzer/routes.ts` | 44 | 높음 |
| `services/jobDataMerger.ts` | 35 | 높음 |
| `scripts/etl/mergeJobProfiles.ts` | 25 | 중간 (스크립트) |
| `routes/api-data.ts` | 23 | 중간 |
| `templates/dataDebugTemplate.ts` | 21 | 낮음 (디버그) |
| `templates/unifiedMajorDetail.ts` | 20 | 중간 |
| 기타 138개 파일 | 318 | - |

**밀도**: 575건 / 150,010줄 = 0.38% (100줄당 0.38회)
**평가**: TypeScript strict mode 활성화 상태에서 575건은 **개선 필요** 수준. 특히 핵심 데이터 서비스(`profileDataService.ts`)에 45건이 집중되어 있어 런타임 타입 안전성에 위험 요소.

### 2.2 타입 단언 `as` 사용 (274건, import 제외)

| 파일 | 건수 | 비고 |
|------|-----:|------|
| `services/ai-analyzer/routes.ts` | ~195 | **과다** — D1 쿼리 결과 캐스팅 |
| `services/adminService.ts` | ~94 | 관리 서비스 |
| `services/profileDataService.ts` | ~86 | 데이터 통합 |
| `services/rag-search.ts` | ~41 | 검색 |
| `routes/api-data.ts` | ~38 | API 라우트 |

**밀도**: 274건 / 150,010줄 = 0.18% (100줄당 0.18회)
**평가**: D1 쿼리 결과의 타입이 `unknown`이므로 `as` 사용이 불가피한 면이 있으나, D1 결과 전용 제네릭 래퍼 함수를 도입하면 대폭 감소 가능.

### 2.3 에러 처리 패턴

| 패턴 | 건수 | 비율 |
|------|-----:|-----:|
| `catch (error)` — 타입 미지정 | 473 | 66.8% |
| `catch (e)` — 타입 미지정 | 104 | 14.7% |
| `catch (err)` — 타입 미지정 | 43 | 6.1% |
| `catch (e: any)` — any 타입 | 14 | 2.0% |
| `catch (e: unknown)` — 올바른 타입 | 1 | 0.1% |
| 빈 `catch {}` — 에러 무시 | 28 | 4.0% |
| `.catch(() => ...)` — 인라인 | ~44 | 6.2% |
| **합계** | ~707 | 100% |

**평가**: **심각한 문제**. `catch` 블록 707건 중 `unknown` 타입을 올바르게 사용한 것은 단 1건(0.1%). TypeScript strict mode에서 catch 변수는 기본적으로 `unknown`으로 추론되지만, 대부분 타입 가드 없이 `error.message` 등을 직접 접근하고 있음. 빈 `catch {}` 28건은 에러를 무시하여 디버깅을 어렵게 함.

### 2.4 데드코드

**확인된 미사용 서비스 파일:**

| 파일 | 줄 수 | 상태 |
|------|-----:|------|
| `services/jobSyncCron.ts` | ~200 | **미사용** — 어디에서도 import하지 않음 |
| `services/vector-search.ts` | ~300 | **미사용** — 어디에서도 import하지 않음 |

**잠재적 데드코드:**
- `src/scripts/` 디렉토리: 35개 ETL 스크립트 (7,917줄) — 대부분 일회성 시드/마이그레이션 스크립트. 빌드 번들에 포함되지 않으나, 코드베이스 복잡도 증가
- ISR 캐시 관련 `invalidatePageCache()`, `getCacheStats()` — no-op 함수 (wiki_pages 테이블 DROP 이후)
- `console.log` 513건 — 프로덕션 코드에 디버그 로그 잔존

### 2.5 코드 중복

**패턴별 중복 현황:**

| 패턴 | 건수 | 설명 |
|------|-----:|------|
| `db.prepare(...)` | 592 | SQL 쿼리 직접 작성 (ORM/쿼리빌더 미사용) |
| `await fetch(...)` | 136 | HTTP 호출 (일부 중앙화된 클라이언트 존재) |
| `console.log(...)` | 513 | 로깅 (구조화된 로거 없음) |
| `console.error(...)` | 77 | 에러 로깅 |

**주요 중복 패턴:**
1. **analyzer-job-page.ts / analyzer-major-page.ts**: 직업/전공 분석기 페이지가 ~70% 유사한 인라인 HTML/JS/CSS를 각각 보유 (10,052줄 + 5,063줄 = 15,115줄). 공통 컴포넌트 추출로 ~7,000줄 절감 가능 추정.
2. **unifiedJobDetail.ts / unifiedMajorDetail.ts**: 직업/전공 상세 페이지 템플릿이 유사한 탭 구조, 편집 UI 패턴 공유.
3. **SQL 쿼리**: 동일 테이블 접근 패턴이 여러 서비스에 분산 (예: `jobs` 테이블 조회가 `profileDataService`, `routes/job-detail`, `routes/api-data` 등에 중복).

### 2.6 네이밍 일관성

| 컨벤션 | 적용 위치 | 파일 수 | 평가 |
|--------|-----------|-----:|------|
| kebab-case | routes/, ai-analyzer/ | 80 | 일관됨 |
| camelCase | services/, templates/ | 109 | 일관됨 |
| PascalCase | - | 2 | 거의 미사용 |

**혼재 사항:**
- `services/` 하위: `rag-search.ts`(kebab), `vector-search.ts`(kebab) vs `profileDataService.ts`(camelCase) — **혼재**
- `services/ai-analyzer/`: 전부 kebab-case — 일관됨
- `routes/`: 전부 kebab-case — 일관됨
- 변수/함수명: camelCase 준수율 높음
- 타입/인터페이스: PascalCase 준수율 높음
- DB 컬럼: snake_case 준수율 높음

**전반 평가**: 파일명에서 약간의 혼재(services/ 내 kebab vs camelCase)가 있으나, 코드 내부 네이밍은 전반적으로 일관성 양호.

---

## 3. 아키텍처 패턴 평가

### 3.1 ISR 캐싱

**현재 상태: D1 캐시 비활성화, CDN 캐싱으로 전환**

경위:
1. 원래 설계: `wiki_pages` 테이블에 렌더링된 HTML 저장 → D1 캐시 히트 시 50ms 응답
2. 2026-02-09 전환: D1 500MB 한도 중 181MB(36%)를 캐시가 차지 → `wiki_pages` DROP
3. 현재: `Cache-Control: public, max-age=86400, s-maxage=86400, stale-while-revalidate=604800` + ETag

**평가:**
- CDN 캐싱 전환은 합리적 결정 (D1 용량 절약)
- `page-cache.ts`에 D1 관련 코드가 주석/no-op으로 잔존 (217줄 중 ~40%가 죽은 코드)
- KV 캐시(`cacheService.ts`)는 별도로 건전하게 동작: stale-while-revalidate 패턴 올바르게 구현
- 버전 기반 캐시 무효화(`template-versions.ts`)는 유지됨

**위험**: `page-cache.ts`의 죽은 코드가 향후 혼란 유발 가능. 정리 권장.

### 3.2 데이터 통합 (Unified Profile)

**구조:**
```
jobs/majors 테이블
├── api_data_json       ← CareerNet, Work24 API 원본
├── user_contributed_json  ← 위키 편집 데이터
├── admin_data_json     ← 관리자 보강 데이터
└── merged_profile_json ← 병합 결과 (profileMerge.ts)
```

**구현 분석:**
- `profileDataService.ts`(3,354줄): 깊은 병합 유틸(`deepMergeProfile`), D1 재시도 로직, 다중 소스 폴백
- `profileMerge.ts`: 별도 병합 로직
- `jobDataMerger.ts`: 또 다른 병합 로직 (any 35건)

**평가:**
- 개념적으로 우수한 설계 — 다중 소스 통합 + 사용자 기여 오버라이드
- Prototype pollution 방어: `DANGEROUS_KEYS` Set으로 `__proto__`, `constructor` 차단 (양호)
- **문제점**: 병합 로직이 3개 파일에 분산 (`profileMerge.ts`, `jobDataMerger.ts`, `profileDataService.ts`내 `deepMergeProfile`)
- `any` 타입이 45건 집중 — JSON 파싱 결과의 타입 안전성 부족

### 3.3 AI 파이프라인

**6단계 흐름:**
```
1. MiniModule (프로필 수집)
   → mini-module-questions.ts, career-tree-types.ts
2. LLM Interviewer (심층 질문)
   → llm-interviewer.ts (1,700줄), llm-followup.ts, llm-memory.ts
3. Vectorize Pipeline (후보 검색)
   → vectorize-pipeline.ts (3,330줄), openai-client.ts
4. TAG Filter (하드 제외)
   → tag-filter.ts (2,080줄)
5. Personalized Scoring (맞춤 점수)
   → personalized-scoring.ts, fact-score-mapping.ts (2,221줄)
6. LLM Judge + Reporter (평가 + 리포트)
   → llm-judge.ts (2,433줄), llm-reporter.ts (2,319줄), premium-report-generator.ts (1,885줄)
```

**규모**: 47개 파일, 45,321줄 (전체 코드의 30.2%)

**평가:**
- 모듈 분리 우수 — 각 단계가 명확한 파일로 분리됨
- `routes.ts`(8,154줄)가 오케스트레이터 역할이나, 너무 비대. 단계별 조합 로직을 별도 orchestrator 파일로 분리 권장
- OpenAI API 호출은 `openai-client.ts`로 중앙화 (fetch 2건만 존재)
- 팩트 기반 스코어링(`fact-score-mapping.ts`)에 매직 넘버가 다수 (가중치 0.7, 0.3 등)이나, 구조화된 상수 객체로 관리되어 가독성은 양호

### 3.4 Cloudflare Workers 적합성

| 제약 사항 | 현재 상태 | 위험도 |
|-----------|-----------|--------|
| CPU 시간 (50ms free / 30s paid) | AI 파이프라인에서 다수 LLM 호출 → paid plan 필수 | 낮음 |
| Subrequest 한도 (1000/req) | OpenAI fetch 2-5회 + D1 쿼리 다수 → 한도 이내 | 낮음 |
| 메모리 (128MB) | 대형 JSON 파싱 (6,945 직업) → 모니터링 필요 | 중간 |
| D1 용량 (500MB) | wiki_pages DROP 후 개선, 현재 ~319MB 추정 | 중간 |
| `waitUntil` 사용 | 28건 — 백그라운드 작업 적절히 활용 | 양호 |
| 번들 크기 | `analyzer-job-page.ts` 10K줄 인라인 → 번들 비대 | 경고 |

**평가**: Cloudflare Workers 제약 내에서 전반적으로 적합한 설계. D1 쿼리를 parametrized binding(`db.prepare(...).bind(...)`)으로 사용하여 SQL injection 방어. 다만 4건의 string interpolation(`${table}`, `${placeholders}`)이 발견됨 — placeholders는 프로그래밍 생성이므로 위험은 낮으나, table명 주입은 점검 필요.

### 3.5 확장성

**새 기능 추가 용이성:**

| 확장 유형 | 난이도 | 설명 |
|-----------|--------|------|
| 새 페이지 라우트 추가 | 쉬움 | `routes/` 파일 생성 후 `index.tsx`에 등록 (1줄) |
| 새 API 엔드포인트 추가 | 쉬움 | 기존 Hono 라우트 패턴 따름 |
| 새 외부 API 연동 | 쉬움 | `api/` 디렉토리에 클라이언트 추가 |
| DB 스키마 변경 | 보통 | 마이그레이션 파일 추가 필요 |
| AI 파이프라인 단계 추가 | 보통 | `ai-analyzer/routes.ts` 수정 필요 (8K줄 파일) |
| 새 데이터 소스 통합 | 어려움 | `profileDataService.ts` 내 JSON 병합 로직이 복잡 |
| UI 프레임워크 변경 | 매우 어려움 | 인라인 HTML이 30,000줄+ 분산 |

---

## 4. 기술 부채

### 4.1 TODO/FIXME/HACK (0건)

Grep 전수조사 결과 `TODO`, `FIXME`, `HACK` 주석이 **0건** 발견됨.
- 이는 주석 기반 기술 부채 추적을 하지 않는다는 의미이며, 부채가 없다는 의미는 아님
- 실제 기술 부채는 아래 항목들에 암묵적으로 존재

### 4.2 마이그레이션 히스토리

**총 42개 파일**

| 문제 | 상세 |
|------|------|
| **번호 결번** | 0004, 0013-0017 결번 (삭제/건너뜀) |
| **번호 중복** | `0008` 2개 (`add_username`, `comment_enhancements`), `0032` 2개 (`add_embedding_tracking`, `add_image_prompt`), `0042` 2개 (`daily_view_stats`, `search_query_daily`) |
| **비표준 번호** | `010_add_aggregated_profile.sql` (0 패딩 누락) |
| **dev 전용 파일** | `dev_fts5.sql`, `dev_fts5_prefix.sql` (프로덕션에 적용 불가) |
| **네이밍 일관성** | 대부분 `{번호}_{설명}.sql` 형식이나, `010`과 `dev_*`가 예외 |

**위험도**: 중간 — 중복 번호는 마이그레이션 자동화 도구 사용 시 충돌 가능. 수동 관리 중이므로 현재는 운영 영향 없음.

### 4.3 하드코딩된 값

| 유형 | 건수 | 예시 |
|------|-----:|------|
| 외부 URL | 98 | CareerNet API URL, unsplash 이미지 URL |
| 매직 넘버 | 52+ | 가중치(0.7, 0.3), 타임아웃(86400), 페이지 크기(20) |
| D1 데이터베이스 ID | 1 | `wrangler.jsonc`에 직접 기재 (정상) |
| KV namespace ID | 1 | `wrangler.jsonc`에 직접 기재 (정상) |

**주요 하드코딩 사례:**
- CareerNet API base URL이 `careernetAPI.ts`에 직접 기재
- CDN 캐시 TTL `86400`이 여러 파일에 반복
- 페이지네이션 기본값 `20`이 여러 곳에 중복
- AI 스코어링 가중치가 `fact-score-mapping.ts`에 리터럴로 존재 (구조화는 되어 있으나 환경별 조정 불가)

### 4.4 테스트 코드

| 항목 | 수치 |
|------|------|
| 테스트 파일 수 | **1개** |
| 테스트 코드 줄 수 | 208줄 |
| 테스트 대상 | `perfMetricsService.ts`만 |
| 테스트 커버리지 | **< 0.1%** |
| E2E 테스트 | `scenario-runner.js` (브라우저 기반, 자동화 스크립트) |
| 단위 테스트 프레임워크 | 미확인 (`tsconfig.tests.json` 존재) |

**평가**: **심각한 부재**. 150,010줄 코드에 단위 테스트 208줄(1개 파일). AI 파이프라인(45,321줄)에 단위 테스트 0건. 리팩토링 시 회귀 버그 위험이 극히 높음.

### 4.5 문서화 수준

| 항목 | 수치 |
|------|------|
| JSDoc 주석 (`/** */`) | 753건 |
| 단일행 주석 (`//`) | 10,467건 |
| 루트 레벨 .md 파일 | 26개 |
| docs/ 내 문서 | 50+ 파일 |
| API 문서 (OpenAPI) | `docs/openapi-v3.yaml` 1개 |
| 인라인 주석 밀도 | 7.0% (10,467 / 150,010) |

**평가**:
- 인라인 주석이 풍부 (7%) — 한국어 주석으로 의도 설명이 잘 되어 있음
- 아키텍처 문서가 `docs/`에 다수 존재 (ISR, ETL, 스코어링 스펙 등)
- 단, 루트 디렉토리에 26개 .md 파일이 산재 — 정리 필요
- `CLAUDE.md`에 프로젝트 가이드가 잘 정리되어 있음

### 4.6 루트 디렉토리 위생 상태

| 유형 | 건수 |
|------|-----:|
| `tmp_*.json` 임시 파일 | 20 |
| `temp*` 임시 파일 | 12 |
| 루트 `.md` 문서 | 26 |
| 루트 `.sql` 파일 | 다수 |
| 루트 `.py` 스크립트 | 2 |
| 백업 디렉토리 | 3+ |

**평가**: 루트 디렉토리가 **심하게 오염**됨. 임시 파일, 백업, 일회성 스크립트가 산재하여 프로젝트 구조 파악을 어렵게 함. `.gitignore`에 `tmp_*`, `temp*`, `backup*` 패턴 추가 권장.

---

## 5. 종합 평가

### 점수

| 항목 | 점수 | 근거 |
|------|:----:|------|
| **코드 품질** | **2.5/5** | strict mode 활성화되나 any 575건, 에러 타입 미지정 99%, 빈 catch 28건 |
| **아키텍처 적합성** | **3.5/5** | 단방향 의존성, 모듈화된 AI 파이프라인, Workers 적합성. 단, 거대 파일 문제 |
| **기술 부채 수준** | **2.0/5** | 테스트 부재, 거대 파일 4개, 마이그레이션 중복, 루트 오염, 죽은 코드 |

### 주요 강점 3개

1. **순환 의존성 0건 + 명확한 레이어 분리**: routes → services → utils/types 단방향 의존성이 잘 지켜짐. 프로젝트 규모(150K줄) 대비 매우 건전한 의존성 구조.

2. **AI 파이프라인의 모듈화**: 47개 파일로 6단계 파이프라인을 명확히 분리. 각 단계(인터뷰, 벡터검색, 스코어링, 리포트)가 독립적으로 테스트/교체 가능한 구조.

3. **풍부한 인라인 문서화 + 아키텍처 문서**: 한국어 주석 10,467건, JSDoc 753건, 아키텍처 문서 50+개. 신규 개발자 온보딩에 유리.

### 주요 위험 3개

1. **테스트 커버리지 0.1% 미만**: 150K줄 코드에 테스트 1개(208줄). AI 파이프라인, 데이터 통합, 편집 시스템 등 핵심 기능에 회귀 방어가 전무. 리팩토링이나 기능 변경 시 프로덕션 장애 위험 극히 높음.

2. **거대 파일 4개 (28,296줄 합산)**: `analyzer-job-page.ts`(10,052줄), `ai-analyzer/routes.ts`(8,154줄), `analyzer-major-page.ts`(5,063줄), `unifiedJobDetail.ts`(5,027줄). 특히 분석기 페이지 2개는 단일 핸들러에 HTML/CSS/JS가 인라인으로 포함되어 있어 유지보수, 코드 리뷰, 번들 최적화 모두에 심각한 장애.

3. **에러 처리 타입 안전성 부재**: 707개 catch 블록 중 unknown 타입 사용 1건(0.1%). 프로덕션에서 예상치 못한 에러 타입으로 인한 2차 장애(예: `error.message` 접근 시 TypeError) 위험.

### 즉시 조치 필요 사항

| 우선순위 | 조치 | 예상 효과 |
|:--------:|------|-----------|
| P0 | `analyzer-job-page.ts`와 `analyzer-major-page.ts`의 공통 UI를 템플릿 파일로 추출 | 15,115줄 → ~8,000줄 (47% 감소) |
| P0 | `ai-analyzer/routes.ts` 오케스트레이터를 단계별 파일로 분리 | 8,154줄 → ~3,000줄 |
| P1 | AI 파이프라인 핵심 함수에 단위 테스트 추가 (scoring, tag-filter, fact-mapping) | 회귀 방어 확보 |
| P1 | catch 블록 에러 타입을 `unknown`으로 통일 + 타입 가드 도입 | 런타임 안전성 향상 |
| P2 | 루트 디렉토리 임시 파일 정리 + `.gitignore` 패턴 추가 | 프로젝트 위생 개선 |
| P2 | `page-cache.ts` 죽은 코드 제거 (D1 캐시 관련 주석 코드) | 코드 명확성 향상 |
| P2 | `jobSyncCron.ts`, `vector-search.ts` 미사용 파일 제거 | 데드코드 제거 |
| P3 | 마이그레이션 번호 중복 정리 (0008, 0032, 0042) | 자동화 도구 도입 대비 |
