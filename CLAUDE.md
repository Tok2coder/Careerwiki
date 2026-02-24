# CLAUDE.md - CareerWiki Project Guide

## Project Overview

CareerWiki는 한국어 진로 정보 위키 플랫폼. AI 기반 직업/전공 추천 + 사용자 편집 가능한 위키 시스템.
- **Production**: https://careerwiki.org
- **데이터**: 1,435개 전공 + 587개 직업

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

### 작업 완료 시 필수 절차
1. `npx tsc --noEmit` — 타입 체크 통과 확인
2. `npm run build` — 빌드 성공 확인
3. 관련 파일만 `git add` → `git commit`
4. `npm run deploy` — Cloudflare Pages 배포
5. careerwiki.org에서 동작 확인 (로컬 테스트 불필요, Vectorize는 프로덕션에서만 동작)

### 큰 작업 완료 시
- `git push` 전에 **반드시 유저에게 확인** 요청
- 푸시 전 점검사항 보고: 빌드 상태, 타입 에러, 변경 파일 목록, 배포 확인 여부
- 유저 승인 후에만 push 실행

### 테스트
- 로컬 dev 서버 사용하지 않음
- 배포 후 careerwiki.org에서 직접 테스트
- Vectorize, AI binding 등 Cloudflare 바인딩은 프로덕션에서만 정상 동작

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
