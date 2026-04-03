# CLAUDE.md - CareerWiki Project Guide

## Project Overview

CareerWiki는 한국어 진로 정보 위키 플랫폼. AI 기반 직업/전공 추천 + 사용자 편집 가능한 위키 시스템.
- **Production**: https://careerwiki.org
- **데이터**: 608개 전공 + 6,945개 직업

## Tech Stack

- **Runtime**: Cloudflare Workers (Pages)
- **Framework**: Hono (TypeScript, JSX)
- **Database**: Cloudflare D1 (SQLite)
- **Storage**: Cloudflare R2 (이미지), KV (세션)
- **Vector Search**: Cloudflare Vectorize (OpenAI text-embedding-3-small, 1536d, cosine)
- **AI/LLM**: Workers AI, OpenAI API (GPT-4o-mini)
- **Frontend**: TailwindCSS 3, TipTap editor
- **Build**: Vite, TypeScript strict mode

## Key Commands

```bash
npm run dev              # 로컬 개발 서버 (port 3000)
npm run build            # 프로덕션 빌드 (CSS + Vite)
npm run deploy           # Cloudflare Pages 배포
npm run db:migrate:local # 로컬 D1 마이그레이션
npm run db:migrate:prod  # 프로덕션 D1 마이그레이션
npm run build:editor     # TipTap 에디터 번들 빌드
npx tsc --noEmit         # TypeScript 타입 체크
```

## Project Structure

```
src/
├── index.tsx                  # 메인 엔트리포인트 (모든 라우트)
├── services/                  # 비즈니스 로직
│   ├── ai-analyzer/           # AI 추천 엔진 (50+ 파일)
│   │   ├── routes.ts          # AI 분석기 API 라우트
│   │   ├── vectorize-pipeline.ts  # Multi-Query 벡터 검색
│   │   ├── llm-interviewer.ts # LLM 인터뷰 시스템
│   │   ├── llm-judge.ts       # LLM 스코어링
│   │   ├── llm-reporter.ts    # 리포트 생성
│   │   └── personalized-scoring.ts # 맞춤 점수 산출
│   ├── profileDataService.ts  # 직업/전공 데이터 통합
│   ├── rag-search.ts          # RAG 기반 통합 검색
│   ├── editService.ts         # 위키 편집 시스템
│   └── cacheService.ts        # ISR 캐싱
├── templates/                 # HTML 렌더링 템플릿
├── types/                     # TypeScript 타입 정의
├── utils/                     # 유틸리티 함수
├── api/                       # 외부 API 연동 (CareerNet, Work24)
├── routes/                    # 라우트 분리 (auth 등)
└── middleware/                # 미들웨어 (인증 등)
migrations/                    # D1 마이그레이션 (0001-0039)
scripts/                       # ETL 및 유틸리티 스크립트
```

## Architecture

### ISR (Incremental Static Regeneration) 패턴
- 요청 시 `wiki_pages` 캐시 확인 → 캐시 히트면 즉시 반환 (50ms)
- 캐시 미스/버전 불일치 시 렌더링 후 캐시 저장

### 데이터 통합 (Unified Profile)
- 다중 소스 (CareerNet, Work24) → 단일 통합 뷰
- `api_data_json` + `user_contributed_json` = `aggregated_profile_json`

### AI 추천 파이프라인
1. LLM 인터뷰 → 사용자 팩트 수집
2. Multi-Query 벡터 검색 → 후보 풀 확장 (600-800개)
3. TAG 필터 → 하드 제외
4. Personalized Scoring → 맞춤 점수
5. LLM Judge → 다차원 평가
6. LLM Reporter → 서사적 리포트 생성

## Database

- **D1 주요 테이블**: `jobs`, `majors`, `job_sources`, `major_sources`, `wiki_pages`, `comments`, `users`, `user_sessions`, `job_attributes`, `major_attributes`, `narrative_facts`, `embedding_metadata`
- **마이그레이션**: `migrations/` 폴더 (0001-0039), 순서대로 적용

## Coding Conventions

- **파일명**: camelCase (`profileDataService.ts`)
- **타입/인터페이스**: PascalCase (`UnifiedJobDetail`)
- **상수**: UPPER_SNAKE_CASE (`MIN_VECTOR_SCORE`)
- **DB 컬럼**: snake_case (`raw_payload`)
- **커밋 메시지**: `feat/fix/chore: [한국어 설명]`
- **TypeScript**: strict mode, async/await, functional style

## Workflow Rules

### 1. 자가 검증 프로토콜 (Self-Verification)

코드 변경 시 **완료 선언 전** 반드시 아래 단계 수행:

**Step 1: 기본 검증**
- `npx tsc --noEmit` — 타입 에러 0개 확인
- `npm run build` — 빌드 성공 확인
- 변경한 코드를 `Read`로 다시 열어 의도대로인지 재확인

**Step 2: 충돌/회귀 검증**
- 변경한 함수를 `Grep`으로 검색 → import/호출하는 모든 파일에서 호환성 확인
- 변경한 API 경로 → 프론트엔드 호출 코드와 일치 여부 확인
- 공유 타입/유틸 변경 시 → 영향받는 전체 모듈 파악 후 이상 없음 확인
- DB 스키마 변경 시 → 해당 컬럼 참조하는 모든 쿼리 확인

**Step 3: 과거 실수 대조**
- `memory/lessons-learned.md` 확인 → 동일/유사 실수 반복 여부 체크

**Step 4: 오류 탐지**
- edge case 누락, null/undefined 처리, SQL injection 가능성 점검
- TailwindCSS 클래스 오타, JSX 닫힘 태그 누락, 이벤트 핸들러 누락 등 점검

### 2. 배포 파이프라인 (Deploy Pipeline)

검증 완료 후 **한 세트로 연속 실행** (중간에 멈추지 않음):

```
npx tsc --noEmit
→ npm run build
→ npm run deploy
→ careerwiki.org에서 변경사항 동작 확인
→ git add [변경파일만]
→ git commit -m "feat/fix/chore: [한국어 설명]"
→ git push
```

- 각 단계 실패 시 → 즉시 수정 후 파이프라인 처음부터 재시작
- push까지 자동 실행 (별도 유저 승인 불필요)
- 완료 후 변경 요약 보고

### 3. 실수 학습 (Compound Learning)

오류 발생, 빌드 실패, 잘못된 코드 발견 시:
1. **즉시** `memory/lessons-learned.md`에 기록
2. 포맷:
   ```
   ### [YYYY-MM-DD] 카테고리: 제목
   - **상황**: 무엇을 하다가
   - **원인**: 왜 발생했는지
   - **해결**: 어떻게 고쳤는지
   - **교훈**: 다음에 어떻게 방지하는지
   ```
3. 기존 항목과 중복이면 기존 항목 업데이트 (새로 추가 X)
4. **새 작업 시작 전** 반드시 lessons-learned.md 확인

### 4. 설계서 프로토콜 (Design Doc)

다음 조건 중 **하나 이상** 해당 시 → 코드 작성 전 설계서 작성 (Plan Mode 사용):
- 새 기능 추가 (3개 이상 파일 변경 예상)
- DB 스키마 변경 (마이그레이션 추가)
- API 엔드포인트 추가/변경
- UI 페이지 또는 레이아웃 신규/대폭 변경

**설계서 필수 항목:**

```
## 1. 기능 정의 (What)
- 목적: 왜 만드는지
- 범위: 포함 / 명시적 제외

## 2. UI/레이아웃 (How it looks)
- ASCII 목업 또는 상세 레이아웃 설명
- 반응형 (모바일/데스크톱) 고려
- 기존 디자인 패턴과의 일관성

## 3. 동작 명세 (How it works)
- 정상 플로우 (step by step)
- 엣지 케이스 목록 + 처리 방식
- 에러 처리

## 4. 영향 분석 (Impact)
- 변경/추가할 파일 목록
- 기존 기능 영향 여부
- DB 마이그레이션 필요 여부
- 캐시 무효화 필요 여부
```

유저 승인 후 구현 시작.

### 테스트 (중요)
- **로컬 dev 서버(preview_start, npm run dev) 절대 사용 금지** — Cloudflare 바인딩(D1, Vectorize, AI, KV, R2)이 로컬에서 정상 동작하지 않음
- **반드시 `npm run deploy`로 배포 후 careerwiki.org에서 직접 테스트**
- **프로덕션 확인은 `curl`/`WebFetch`로** — HTML 가져와서 grep/확인. 간단하고 빠름
- **MCP 도구 전체 사용 금지** — `mcp__playwright__*`, `mcp__Claude_in_Chrome__*`, `preview_*` 등 모든 MCP 도구 사용하지 않음. curl/WebFetch로 충분함

## 품질 하네스 (Quality Harness)

배포 전·후 데이터 품질을 자동으로 검증하는 스크립트 세트.

### 스크립트

| 스크립트 | 역할 | 사용 시점 |
|----------|------|-----------|
| `scripts/safe-deploy.cjs` | tsc → build → deploy 안전 래퍼 | `npm run deploy` 시 자동 호출 |
| `scripts/validate-job-edit.cjs` | 편집 API 호출 전 JSON 10개 규칙 검증 | job-data-enhance 스킬 Phase 2 |
| `scripts/full-quality-audit.cjs` | 배포 후 직업 페이지 전체 품질 감사 | job-data-enhance 스킬 Phase 4 |
| `scripts/data-health-report.cjs` | 전체 DB 데이터 건강 보고서 | 정기 모니터링, 배치 작업 전 |

### 사용법

```bash
# 직업 편집 전 검증
node scripts/validate-job-edit.cjs data.json

# 배포 후 품질 감사
node scripts/full-quality-audit.cjs --slug=소프트웨어개발자

# 데이터 건강 보고
node scripts/data-health-report.cjs --top-missing=20

# 안전 배포 (tsc + build + deploy 한번에)
npm run deploy
```

### Git Hooks

- `.git/hooks/pre-commit` — `src/` 변경 시 `npx tsc --noEmit` 자동 실행 (커밋 차단)

## Critical Rules

- **절대 금지**: `git stash`, `git reset --hard`, `DROP TABLE`, `DELETE FROM` (WHERE 없이), `.dev.vars` 커밋
- **D1 주의**: topK 쿼리 시 Vectorize 상한 100개 제한 → Multi-Query 배치로 우회
- **빌드 전 확인**: `npx tsc --noEmit`으로 타입 에러 확인
- **배포 전 확인**: `npm run build` 성공 확인 후 `npm run deploy`

## Environment Variables

`.dev.vars` 파일에 저장 (절대 커밋 금지):
- `CAREER_NET_API_KEY`, `GOYONG24_MAJOR_API_KEY`, `GOYONG24_JOB_API_KEY`
- `ADMIN_SECRET`, `JWT_SECRET`
- `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`
- `OPENAI_API_KEY`, `CLOUDFLARE_API_TOKEN`

## Cloudflare Bindings (wrangler.jsonc)

- `DB` → D1 database (careerwiki-kr)
- `BUCKET` → R2 bucket (careerwiki-uploads)
- `KV` → KV namespace
- `VECTORIZE` → Vectorize index (careerwiki-embeddings)
- `AI` → Workers AI

## 스킬 시스템 (Claude Harness)

### 스킬 통합 현황

| 스킬 | 상태 | 용도 |
|------|------|------|
| `job-data-enhance` | **메인 (사용)** | 직업 데이터 보완·균등화·고도화 통합 스킬 |
| `job-supplement` | ⚠️ DEPRECATED | → job-data-enhance로 통합됨 |
| `job-data-equalize` | ⚠️ DEPRECATED | → job-data-enhance로 통합됨 |
| `job-data-create` | 사용 | 완전히 새로운 직업 추가 전용 |
| `howto-publish` | 사용 | HowTo 가이드 기획·작성·발행 전체 워크플로우 |

직업 데이터 보완 관련 키워드 ("데이터 보완", "균등화", "부실 직업", "NULL 직업", "직업 데이터 업데이트" 등)는 **반드시 job-data-enhance 스킬**로 처리한다.

### 안전장치 목록

| 도구 | 경로 | 역할 |
|------|------|------|
| `full-quality-audit.cjs` | `scripts/full-quality-audit.cjs` | 저장 후 품질 감사 — PASS 없이 다음 직업 진행 금지 |
| `validate-job-edit.cjs` | `scripts/validate-job-edit.cjs` | 편집 API 호출 전 draft JSON 검증 — PASS 확인 후에만 API 호출 |

### 핵심 기술 규칙 (직업 데이터 작업 시 항상 적용)

| 규칙 | 내용 |
|------|------|
| `way` 타입 | **반드시 string** — 배열이면 즉시 500 에러 |
| R2 이미지 키 | `jobs/job-{slug}.webp` — `uploads/` prefix 절대 금지 |
| DB image_url | `/uploads/jobs/job-{slug}.webp?v={timestamp}` |
| 직업 페이지 URL | `https://careerwiki.org/job/슬러그` — `.kr` 또는 `/jobs` 절대 금지 |
| 편집 API URL | `POST https://careerwiki.org/api/job/{id}/edit` |
| 인증 헤더 | `X-Admin-Secret: careerwiki-admin-2026` |
| sources 전송 | fields + sources 반드시 함께 전송 — sources 누락 시 각주 깨짐 |
| sources 키 | `way`, `overviewSalary.sal`, `detailWlb.wlbDetail` 등 필드명 키 사용 — `way_sources` 등 금지 |
| overviewSalary.wage | **절대 덮어쓰기 금지** — 바 차트 렌더링 데이터 |
| 배포 브랜치 | **반드시 main 브랜치** — worktree에서 배포 시 다음 main 배포에서 롤백됨 |
