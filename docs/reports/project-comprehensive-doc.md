# Careerwiki 프로젝트 종합 문서

> **작성일**: 2026-03-03
> **기준**: 프로덕션 운영 중인 main 브랜치 (commit f4ab654)
> **사이트**: https://careerwiki.org

---

## 목차

1. [프로젝트 개요](#1-프로젝트-개요)
2. [기술 스택](#2-기술-스택)
3. [아키텍처](#3-아키텍처)
4. [데이터베이스](#4-데이터베이스)
5. [페이지 & 라우트 전체 목록](#5-페이지--라우트-전체-목록)
6. [AI 추천 시스템](#6-ai-추천-시스템)
7. [위키 편집 시스템](#7-위키-편집-시스템)
8. [HowTo 콘텐츠 시스템](#8-howto-콘텐츠-시스템)
9. [외부 API 연동](#9-외부-api-연동)
10. [인증 & 보안](#10-인증--보안)
11. [빌드 & 배포](#11-빌드--배포)
12. [운영 & 모니터링](#12-운영--모니터링)
13. [비용 구조](#13-비용-구조)
14. [성숙도 평가 & 로드맵](#14-성숙도-평가--로드맵)
15. [부록: 상세 참조](#15-부록-상세-참조)

---

## 1. 프로젝트 개요

### 한 줄 요약

**Careerwiki**는 한국어 진로 정보 위키 + AI 맞춤 추천 플랫폼이다.

### 핵심 수치

| 항목 | 수치 |
|------|------|
| 직업 데이터 | 6,945개 |
| 전공 데이터 | 608개 |
| 코드베이스 | 150,010줄 (TypeScript 223개 파일) |
| 기능 수 | 62개 (완성 48개, 부분 구현 11개) |
| AI 파이프라인 | 6단계, 47개 파일 |
| DB 테이블 | 57개 |
| API 엔드포인트 | 230+ 개 |
| 마이그레이션 | 44개 파일 |

### 핵심 기능 3가지

1. **직업/전공 위키** — 6,945개 직업과 608개 전공의 상세 정보를 제공하고, 사용자가 직접 편집할 수 있는 위키 시스템
2. **AI 맞춤 추천** — 15개 미니 질문 + 3라운드 LLM 심층 인터뷰를 통해 사용자에게 최적의 직업/전공을 추천하는 6단계 파이프라인
3. **HowTo 진로 가이드** — TipTap 에디터 기반의 실용적 진로 가이드 콘텐츠 시스템

### 사용자 시나리오

```
시나리오 1: 직업 탐색
  사용자 → 직업 목록 검색 → 직업 상세 페이지 → 관련 직업/전공/HowTo 확인

시나리오 2: AI 맞춤 추천
  사용자 → AI 추천 시작 → 15개 프로필 질문 → 3라운드 심층 인터뷰 → 추천 결과 + 프리미엄 리포트

시나리오 3: 정보 기여
  사용자 → 직업/전공 페이지에서 "편집" 클릭 → 정보 수정 → 리비전으로 기록

시나리오 4: HowTo 가이드 작성
  로그인 사용자 → HowTo 새 글 작성 → TipTap 에디터로 편집 → 발행

시나리오 5: 결과 공유
  사용자 → AI 추천 완료 → 공유 링크 생성 → 타인에게 전달
```

---

## 2. 기술 스택

### 핵심 기술 요약

```
┌─────────────────────────────────────────────────────┐
│  프레임워크      Hono (TypeScript, JSX)              │
│  런타임          Cloudflare Workers (Pages)          │
│  데이터베이스     Cloudflare D1 (SQLite)              │
│  파일 저장소      Cloudflare R2                       │
│  세션 저장소      Cloudflare KV                       │
│  벡터 검색        Cloudflare Vectorize                │
│  AI/LLM          OpenAI GPT-4o-mini + Workers AI     │
│  임베딩           OpenAI text-embedding-3-small       │
│  프론트엔드       TailwindCSS 3.4 + TipTap 에디터     │
│  빌드             Vite 6.3 + esbuild                  │
│  언어             TypeScript (strict mode)            │
└─────────────────────────────────────────────────────┘
```

### 주요 의존성

| 패키지 | 버전 | 용도 |
|--------|------|------|
| `hono` | 4.9.9 | 웹 프레임워크 |
| `@tiptap/core` + 20개 확장 | 3.11.1 | 위키 에디터 |
| `jose` | 6.1.2 | JWT 토큰 처리 |
| `axios` | 1.12.2 | HTTP 클라이언트 (ETL) |
| `@resvg/resvg-wasm` | 2.6.2 | SVG→PNG 렌더링 (OG 이미지) |
| `wrangler` | 4.57.0 | Cloudflare CLI (dev) |
| `typescript` | 5.9.3 | 타입 체크 (dev) |
| `vite` | 6.3.5 | 빌드 도구 (dev) |
| `tailwindcss` | 3.4.19 | CSS 프레임워크 (dev) |

### Cloudflare 바인딩 (인프라)

| 바인딩 | 서비스 | 용도 |
|--------|--------|------|
| `DB` | D1 `careerwiki-kr` | 메인 데이터베이스 (SQLite) |
| `UPLOADS` | R2 `careerwiki-uploads` | 이미지/파일 저장소 |
| `KV` | KV Namespace | 세션, 캐시, 레이트 리밋 |
| `VECTORIZE` | Vectorize `careerwiki-embeddings` | 벡터 검색 (1536차원, cosine) |
| `AI` | Workers AI | AI 모델 접근 |

---

## 3. 아키텍처

### 3.1 전체 구조

```
                    ┌──────────────┐
                    │   사용자      │
                    └──────┬───────┘
                           │ HTTPS
                    ┌──────┴───────┐
                    │  Cloudflare   │
                    │  CDN/Edge     │
                    └──────┬───────┘
                           │
              ┌────────────┴────────────┐
              │   Cloudflare Workers    │
              │   (Hono + TypeScript)   │
              ├─────────────────────────┤
              │ ┌─────┐ ┌──────────┐   │
              │ │Route│→│Service   │   │
              │ │     │ │(비즈니스)│   │
              │ └─────┘ └────┬─────┘   │
              │              │         │
              │  ┌───────────┼───────┐ │
              │  │     │     │     │ │ │
              │  ▼     ▼     ▼     ▼ │ │
              │ D1    KV    R2  Vector│ │
              │(SQL) (캐시)(파일)(검색)│ │
              └─────────────────────────┘
                           │
              ┌────────────┴────────────┐
              │    외부 API 연동         │
              ├────────────┬────────────┤
              │ CareerNet  │ 고용24     │
              │ (career.go)│ (work24)   │
              └────────────┴────────────┘
                           │
              ┌────────────┴────────────┐
              │    AI/LLM 서비스        │
              ├────────────┬────────────┤
              │ OpenAI     │ Workers AI │
              │ GPT-4o-mini│ (폴백)     │
              └────────────┴────────────┘
```

### 3.2 코드베이스 구조

```
src/                          150,010줄 / 223 파일
├── index.tsx                  엔트리포인트 (234줄) — 라우트 등록, 미들웨어, 스케줄러
├── renderer.tsx               Hono JSX 렌더러 (12줄)
│
├── routes/                    HTTP 라우트 핸들러 (33,649줄 / 22 파일)
│   ├── auth.ts                Google OAuth 인증
│   ├── admin.ts               관리자 라우트
│   ├── user.ts                사용자 마이페이지
│   ├── pages.ts               정적 페이지 (홈, 로그인, about 등)
│   ├── search.ts              통합 검색
│   ├── job-list.ts            직업 목록
│   ├── job-detail.ts          직업 상세
│   ├── job-editor.ts          직업 편집 API
│   ├── major-list.ts          전공 목록
│   ├── major-detail.ts        전공 상세
│   ├── major-editor.ts        전공 편집 API
│   ├── howto.ts               HowTo 가이드
│   ├── howto-editor.ts        HowTo 편집
│   ├── content-editor.ts      콘텐츠 에디터
│   ├── comments.ts            댓글 CRUD
│   ├── feedback.ts            피드백 CRUD
│   ├── share.ts               AI 결과 공유
│   ├── upload.ts              R2 이미지 업로드
│   ├── analyzer-job-page.ts   AI 직업 추천 결과 페이지 (10,052줄)
│   ├── analyzer-major-page.ts AI 전공 추천 결과 페이지 (5,063줄)
│   ├── api-data.ts            데이터 API
│   └── api-misc.ts            기타 API
│
├── services/                  비즈니스 로직 (63,723줄 / 78 파일)
│   ├── ai-analyzer/           AI 추천 엔진 (45,321줄 / 47 파일) → §6 참조
│   ├── profileDataService.ts  직업/전공 데이터 통합 (3,354줄)
│   ├── rag-search.ts          RAG 기반 통합 검색 (2,802줄)
│   ├── editService.ts         위키 편집 서비스
│   ├── cacheService.ts        ISR 캐싱
│   └── freshnessService.ts    SERP 데이터 갱신
│
├── templates/                 HTML 렌더링 (29,524줄 / 35 파일)
│   ├── partials/nav.ts        공통 네비게이션 바
│   ├── unifiedJobDetail.ts    직업 상세 렌더링 (5,027줄)
│   ├── unifiedMajorDetail.ts  전공 상세 렌더링 (2,979줄)
│   ├── howtoDetail.ts         HowTo 상세 렌더링
│   ├── admin/                 관리자 UI (대시보드, 통계, 사용자, 피드백 등)
│   ├── user/                  사용자 마이페이지 (레이아웃, 보안, AI결과)
│   └── legal/                 법적 페이지 (이용약관, 개인정보처리방침)
│
├── editor/                    TipTap 에디터 (3,505줄 / 16 파일) → §7 참조
│
├── api/                       외부 API 클라이언트 (2,690줄)
│   ├── careernetAPI.ts        CareerNet API (career.go.kr)
│   └── goyong24API.ts         고용24 API (work24.go.kr)
│
├── utils/                     유틸리티 (5,760줄 / 17 파일)
│   ├── shared-helpers.ts      공통 레이아웃, 사용자 메뉴, 포맷
│   ├── session.ts             KV 세션 관리
│   ├── jwt.ts                 JWT 토큰 (레거시)
│   ├── auth.ts / auth-helpers.ts  OAuth 유틸
│   ├── page-cache.ts          ISR 페이지 캐싱
│   ├── editFieldConfig.ts     위키 편집 필드 설정
│   ├── editValidation.ts      편집 유효성 검증
│   ├── slug.ts                URL slug 생성
│   └── ...                    (etag, similarity, viewCounter 등)
│
├── types/                     TypeScript 타입 (1,345줄 / 6 파일)
├── middleware/                 인증 미들웨어 (241줄 / 1 파일)
├── config/                    설정 (128줄 / 2 파일)
├── constants/                 상수 (116줄 / 2 파일)
└── scripts/                   ETL 스크립트 (7,917줄 / 35 파일)

migrations/                    D1 마이그레이션 (44 파일) → §4 참조
public/static/                 정적 에셋 (18 파일)
```

### 3.3 의존성 방향

```
index.tsx
  └─→ routes/*        → services/*, templates/*, utils/*, types/*
      ├── services/    → api/*, utils/*, types/*, constants/*
      │   └── ai-analyzer/ → utils/*, constants/* (상위 services 참조 X)
      ├── templates/   → services/*, utils/*, types/*
      └── middleware/  → utils/*

순환 의존성: 0건
```

### 3.4 핵심 아키텍처 패턴

#### 데이터 통합 (Unified Profile)

직업/전공 데이터는 여러 외부 소스에서 수집되어 3계층으로 병합된다:

```
┌──────────────┐   ┌──────────────────┐   ┌──────────────┐
│ api_data_json│ + │user_contributed  │ + │admin_data_json│
│ (외부 API)    │   │_json (사용자)     │   │ (관리자)       │
└──────┬───────┘   └────────┬─────────┘   └──────┬───────┘
       │                    │                     │
       └────────────────────┴─────────────────────┘
                            │ 병합
                   ┌────────┴────────┐
                   │merged_profile   │
                   │_json (최종 통합)  │
                   └─────────────────┘
```

- **api_data_json**: CareerNet, 고용24 외부 API 원시 데이터
- **user_contributed_json**: 위키 편집으로 사용자가 기여한 데이터
- **admin_data_json**: 관리자가 수정/보완한 데이터
- **merged_profile_json**: 세 소스를 우선순위로 병합한 최종 데이터

#### ISR 캐싱

```
요청 → CDN 캐시 확인 → 캐시 히트 → 즉시 반환 (ETag 기반)
                     → 캐시 미스 → DB에서 렌더링 → 응답 + 캐시 저장
```

- 직업/전공 상세 페이지에 적용
- ETag + 버전 기반 캐시 무효화
- 편집 시 자동 캐시 퍼지

---

## 4. 데이터베이스

### 4.1 개요

| 항목 | 내용 |
|------|------|
| 엔진 | Cloudflare D1 (SQLite 호환) |
| 테이블 수 | 57개 |
| 마이그레이션 | 44개 파일 (0001 ~ 0044) |
| 주요 제약 | Foreign Key, Unique, Default, CHECK |

### 4.2 테이블 분류

#### 핵심 데이터 (6개)

| 테이블 | 용도 | 주요 컬럼 |
|--------|------|-----------|
| `jobs` | 직업 정보 | id, name, slug, category_code, api_data_json, user_contributed_json, admin_data_json, merged_profile_json, is_active |
| `majors` | 전공 정보 | id, name, slug, api_data_json, user_contributed_json, admin_data_json, merged_profile_json, is_active |
| `pages` | 위키 페이지 | id, job_id, major_id, content_type, content_json, html_cache |
| `howtos` | HowTo 가이드 | id, title, slug, content_json, author_id, status(draft/published), view_count |
| `users` | 사용자 | id, email, name, role(user/expert/admin), google_id, picture_url, is_banned |
| `comments` | 댓글 | id, target_type, target_id, user_id, content, parent_id, is_deleted |

#### 데이터 소스 (4개)

| 테이블 | 용도 |
|--------|------|
| `job_sources` | 직업별 외부 API 소스 (CareerNet, 고용24 등) |
| `major_sources` | 전공별 외부 API 소스 |
| `job_data_revisions` | 직업 데이터 편집 히스토리 |
| `major_data_revisions` | 전공 데이터 편집 히스토리 |

#### AI 추천 시스템 (7개)

| 테이블 | 용도 |
|--------|------|
| `ai_sessions` | AI 분석 세션 (사용자별) |
| `ai_analysis_requests` | 분석 요청 기록 |
| `ai_analysis_results` | 분석 결과 저장 |
| `narrative_facts` | LLM 인터뷰에서 수집한 서사적 팩트 |
| `job_attributes` | 직업별 AI 속성 (analytical, creative 등) |
| `major_attributes` | 전공별 AI 속성 |
| `embedding_metadata` | Vectorize 임베딩 메타데이터 |

#### 사용자 활동 (8개)

| 테이블 | 용도 |
|--------|------|
| `user_sessions` | 세션 감사 로그 (token_hash, ip, user_agent, action) |
| `user_bookmarks` | 북마크 (직업/전공/HowTo) |
| `user_attributions` | 사용자 기여 기록 |
| `user_profiles` | AI 분석용 사용자 프로필 |
| `user_resumes` | 이력서 업로드 |
| `consents` | 동의 기록 (GDPR 준비) |
| `feedback_posts` | 피드백 제출 |
| `feedback_votes` | 피드백 투표 |

#### HowTo 관련 (6개)

| 테이블 | 용도 |
|--------|------|
| `howtos` | HowTo 가이드 본문 |
| `howto_drafts` | 초안 저장 |
| `howto_reviews` | 리뷰/승인 |
| `tags` | 태그 마스터 |
| `howto_tags` | HowTo-태그 매핑 |
| `howto_related_jobs` / `howto_related_majors` | HowTo-직업/전공 연결 |

#### 분석/통계 (6개)

| 테이블 | 용도 |
|--------|------|
| `search_query_daily` | 일별 검색어 통계 |
| `daily_view_stats` | 일별 조회수 통계 |
| `serp_interaction_logs` | SERP 상호작용 로그 |
| `serp_freshness_snapshots` | SERP 신선도 스냅샷 |
| `view_counts` | 페이지별 누적 조회수 |
| `search_queries` | 검색 쿼리 로그 |

#### 공유/기타 (5개)

| 테이블 | 용도 |
|--------|------|
| `shared_results` | AI 결과 공유 토큰 |
| `shared_result_details` | 공유 결과 상세 |
| `categories` | 직업 카테고리 |
| `related_jobs` | 직업 간 관계 |
| `job_major_mapping` | 직업-전공 매핑 |

### 4.3 핵심 ERD (간략)

```
users ──1:N── user_sessions
  │
  ├──1:N── comments
  ├──1:N── howtos
  ├──1:N── user_bookmarks
  ├──1:N── ai_sessions ──1:N── ai_analysis_requests ──1:N── ai_analysis_results
  │                                    │
  │                                    └──1:N── narrative_facts
  │
jobs ──1:N── job_sources
  │  ──1:N── job_data_revisions
  │  ──1:N── job_attributes
  │  ──N:M── majors (via job_major_mapping)
  │  ──N:M── howtos (via howto_related_jobs)
  │
majors ──1:N── major_sources
     ──1:N── major_data_revisions
     ──1:N── major_attributes
     ──N:M── howtos (via howto_related_majors)
```

### 4.4 주요 인덱스

```sql
-- 자주 사용되는 검색 인덱스
CREATE INDEX idx_jobs_slug ON jobs(slug);
CREATE INDEX idx_jobs_name ON jobs(name);
CREATE INDEX idx_jobs_category ON jobs(category_code);
CREATE INDEX idx_majors_slug ON majors(slug);
CREATE INDEX idx_majors_name ON majors(name);
CREATE INDEX idx_howtos_slug ON howtos(slug);
CREATE INDEX idx_howtos_status ON howtos(status);
CREATE INDEX idx_comments_target ON comments(target_type, target_id);
CREATE INDEX idx_user_sessions_user ON user_sessions(user_id);
CREATE INDEX idx_narrative_facts_session ON narrative_facts(session_id);
CREATE INDEX idx_embedding_metadata_type ON embedding_metadata(entity_type, entity_id);
```

---

## 5. 페이지 & 라우트 전체 목록

### 5.1 사용자 대면 페이지 (HTML)

#### 메인/네비게이션

| URL | 설명 | 라우트 파일 |
|-----|------|------------|
| `GET /` | 홈페이지 (AI 추천 CTA, 카테고리 섹션) | `routes/pages.ts` |
| `GET /login` | 로그인 페이지 (Google OAuth) | `routes/pages.ts` |
| `GET /search` | 통합 검색 (직업+전공+HowTo) | `routes/search.ts` |
| `GET /about` | About 페이지 | `routes/pages.ts` |
| `GET /help` | 도움말 페이지 | `routes/pages.ts` |
| `GET /onboarding` | 온보딩 페이지 | `routes/pages.ts` |
| `GET /terms` | 이용약관 | `routes/pages.ts` |
| `GET /privacy` | 개인정보처리방침 | `routes/pages.ts` |

#### 직업

| URL | 설명 | 라우트 파일 |
|-----|------|------------|
| `GET /job` | 직업 목록 (검색, 정렬, 페이지네이션) | `routes/job-list.ts` |
| `GET /job/:slug` | 직업 상세 (ISR 캐싱, 다중 소스 통합) | `routes/job-detail.ts` |
| `GET /job/:slug?debug=true` | 직업 데이터 디버그 (소스별 비교) | `routes/job-detail.ts` |

#### 전공

| URL | 설명 | 라우트 파일 |
|-----|------|------------|
| `GET /major` | 전공 목록 (검색, 정렬, 페이지네이션) | `routes/major-list.ts` |
| `GET /major/:slug` | 전공 상세 (ISR 캐싱) | `routes/major-detail.ts` |
| `GET /majors/:id` | 전공 상세 (레거시 ID 기반) | `routes/major-detail.ts` |

#### HowTo

| URL | 설명 | 라우트 파일 |
|-----|------|------------|
| `GET /howto` | HowTo 가이드 목록 | `routes/howto.ts` |
| `GET /howto/:slug` | HowTo 상세 페이지 | `routes/howto.ts` |
| `GET /howto/new` | HowTo 새 글 작성 (로그인 필수) | `routes/howto.ts` |
| `GET /howto/:slug/edit` | HowTo 편집 | `routes/howto.ts` |
| `GET /howto/my` | 내 HowTo 목록 | `routes/howto.ts` |
| `GET /howto/drafts` | 초안 목록 | `routes/howto.ts` |

#### AI 추천

| URL | 설명 | 라우트 파일 |
|-----|------|------------|
| `GET /analyzer` | AI 추천 랜딩 (직업/전공 분기) | `routes/pages.ts` |
| `GET /analyzer/job` | AI 직업 추천 UI (3단계 플로우) | `routes/analyzer-job-page.ts` |
| `GET /analyzer/major` | AI 전공 추천 UI | `routes/analyzer-major-page.ts` |
| `GET /share/:token` | AI 결과 공유 페이지 | `routes/share.ts` |

#### 사용자 마이페이지

| URL | 설명 | 라우트 파일 |
|-----|------|------------|
| `GET /user/profile` | 프로필 설정 | `routes/user.ts` |
| `GET /user/security` | 보안 설정 (세션 관리) | `routes/user.ts` |
| `GET /user/ai-results` | AI 분석 결과 목록 | `routes/user.ts` |
| `GET /user/bookmarks` | 북마크 목록 | `routes/user.ts` |
| `GET /user/contributions` | 기여 내역 | `routes/user.ts` |

#### 관리자

| URL | 설명 | 라우트 파일 |
|-----|------|------------|
| `GET /admin` | 관리자 대시보드 | `routes/admin.ts` |
| `GET /admin/content` | 콘텐츠 관리 | `routes/admin.ts` |
| `GET /admin/stats` | 통계/분석 | `routes/admin.ts` |
| `GET /admin/users` | 사용자 관리 | `routes/admin.ts` |
| `GET /admin/users/:id` | 사용자 상세 | `routes/admin.ts` |
| `GET /admin/feedback` | 피드백 관리 | `routes/admin.ts` |
| `GET /admin/feedback/:id` | 피드백 상세 | `routes/admin.ts` |
| `GET /admin/ai-analyzer` | AI 분석기 관리/테스트 | `routes/admin.ts` |
| `GET /admin/similar-names` | 유사 이름 검색 | `routes/admin.ts` |

#### 기타

| URL | 설명 | 라우트 파일 |
|-----|------|------------|
| `GET /feedback` | 피드백 목록 | `routes/feedback.ts` |
| `GET /feedback/new` | 피드백 작성 | `routes/feedback.ts` |
| `GET /feedback/:id` | 피드백 상세 | `routes/feedback.ts` |

### 5.2 API 엔드포인트

#### 인증 API

| 메서드 | URL | 설명 |
|--------|-----|------|
| `GET` | `/auth/google` | Google OAuth 시작 |
| `GET` | `/auth/callback` | OAuth 콜백 |
| `GET` | `/auth/logout` | 로그아웃 |

#### 직업 편집 API

| 메서드 | URL | 설명 |
|--------|-----|------|
| `POST` | `/api/job/create` | 직업 생성 |
| `POST` | `/api/job/:id/edit` | 직업 편집 |
| `DELETE` | `/api/job/:id` | 직업 삭제 (soft) |
| `POST` | `/api/job/:id/restore` | 직업 복원 |
| `GET` | `/api/job/categories` | 카테고리 목록 |
| `POST` | `/api/job/:id/refetch-api-data` | 외부 API 데이터 재수집 |
| `GET` | `/api/job/:id/revisions` | 편집 히스토리 |
| `GET` | `/api/job/:id/revision/:revisionId` | 특정 리비전 |

#### 전공 편집 API

| 메서드 | URL | 설명 |
|--------|-----|------|
| `POST` | `/api/major/create` | 전공 생성 |
| `POST` | `/api/major/:id/edit` | 전공 편집 |
| `DELETE` | `/api/major/:id` | 전공 삭제 |
| `POST` | `/api/major/:id/restore` | 전공 복원 |
| `POST` | `/api/major/:id/refetch-api-data` | 외부 API 데이터 재수집 |
| `GET` | `/api/major/:id/revisions` | 편집 히스토리 |

#### HowTo API

| 메서드 | URL | 설명 |
|--------|-----|------|
| `POST` | `/api/howto` | HowTo 생성 |
| `PUT` | `/api/howto/:id` | HowTo 수정 |
| `DELETE` | `/api/howto/:id` | HowTo 삭제 |
| `POST` | `/api/howto/:id/publish` | HowTo 발행 |
| `POST` | `/api/howto/:id/unpublish` | HowTo 비공개 |
| `POST` | `/api/howto/:id/draft` | 초안 저장 |
| `GET` | `/api/howto/:id/draft` | 초안 조회 |
| `POST` | `/api/howto/:id/bookmark` | 북마크 토글 |
| `POST` | `/api/howto/:id/review` | 리뷰 제출 |

#### 댓글 API

| 메서드 | URL | 설명 |
|--------|-----|------|
| `POST` | `/api/comments` | 댓글 작성 |
| `PUT` | `/api/comments/:id` | 댓글 수정 |
| `DELETE` | `/api/comments/:id` | 댓글 삭제 |
| `POST` | `/api/comments/:id/report` | 댓글 신고 |

#### AI 추천 API (`/api/ai-analyzer/`)

| 메서드 | URL | 설명 |
|--------|-----|------|
| `POST` | `/api/ai-analyzer/analyze` | 세션 시작 + 프로필 제출 |
| `POST` | `/api/ai-analyzer/v3/narrative-facts` | 서사적 답변 제출 |
| `POST` | `/api/ai-analyzer/v3/round-questions` | LLM 라운드 질문 요청 |
| `POST` | `/api/ai-analyzer/v3/round-answers` | 라운드 답변 제출 |
| `POST` | `/api/ai-analyzer/v3/recommend` | 직업 추천 요청 |
| `POST` | `/api/ai-analyzer/v3/recommend-major` | 전공 추천 요청 |
| `POST` | `/api/ai-analyzer/v3/recommend/report` | 프리미엄 리포트 생성 |
| `POST` | `/api/ai-analyzer/share` | 결과 공유 링크 생성 |
| `GET` | `/api/ai-analyzer/result/:requestId` | 분석 결과 조회 |
| `GET` | `/api/ai-analyzer/saved-result/:requestId` | 저장된 결과 조회 |
| `GET` | `/api/ai-analyzer/sessions` | 사용자 세션 목록 |
| `POST` | `/api/ai-analyzer/resume/upload` | 이력서 업로드 |
| `POST` | `/api/ai-analyzer/resume/parse` | 이력서 파싱 |
| `GET` | `/api/ai-analyzer/profile` | AI 프로필 조회 |
| `PUT` | `/api/ai-analyzer/profile` | AI 프로필 업데이트 |
| `GET` | `/api/ai-analyzer/history` | 분석 이력 |

#### 기타 API

| 메서드 | URL | 설명 |
|--------|-----|------|
| `POST` | `/api/upload/image` | R2 이미지 업로드 |
| `POST` | `/api/feedback` | 피드백 제출 |
| `POST` | `/api/feedback/:id/vote` | 피드백 투표 |
| `POST` | `/api/user/profile` | 프로필 업데이트 |
| `POST` | `/api/user/picture` | 프로필 사진 업로드 |
| `DELETE` | `/api/user/sessions/:tokenHash` | 특정 세션 종료 |
| `POST` | `/api/bookmark` | 북마크 토글 |
| `GET` | `/api/search/suggest` | 검색어 자동완성 |

#### 관리자 전용 API

| 메서드 | URL | 설명 |
|--------|-----|------|
| `POST` | `/api/admin/merge-jobs` | 직업 데이터 병합 ETL |
| `POST` | `/api/admin/merge-majors` | 전공 데이터 병합 ETL |
| `POST` | `/api/admin/reseed-empty-majors` | 빈 전공 데이터 재시드 |
| `POST` | `/api/admin/users/:id/role` | 사용자 역할 변경 |
| `POST` | `/api/admin/users/:id/ban` | 사용자 밴/해제 |
| `GET` | `/api/admin/stats/overview` | 통계 개요 |
| `GET` | `/api/admin/content/search` | 콘텐츠 검색 |

---

## 6. AI 추천 시스템

### 6.1 개요

Careerwiki의 핵심 차별 기능. 사용자의 성격, 가치관, 능력, 제약 조건을 파악하여 최적의 직업/전공을 추천한다.

**핵심 공식**: `Fit = 0.5 × Like + 0.5 × Can - Risk`

- **Like**: 흥미/가치/동기 기반 적합도 (얼마나 하고 싶은가)
- **Can**: 강점/역량 기반 실현 가능성 (얼마나 할 수 있는가)
- **Risk**: 제약/리스크 감산 (어떤 장벽이 있는가)

### 6.2 6단계 파이프라인

```
┌─────────────────────────────────────────────────────────────┐
│                    AI 추천 파이프라인                         │
│                                                             │
│  Stage 1: MiniModule                                        │
│  ├── 15개 빠른 선택 질문                                     │
│  ├── 5축 상태 생성: interest, value, strength, constraint,   │
│  │   workstyle                                              │
│  └── 정량화된 구조 신호 수집                                  │
│                         ↓                                   │
│  Stage 2: LLM Interviewer (GPT-4o-mini)                     │
│  ├── Round 1 (ENGINE): 욕망/동기/에너지                      │
│  ├── Round 2 (AVOIDANCE): 회피/두려움/금기                   │
│  ├── Round 3 (INTEGRATION): 현실 제약/실행 전략               │
│  └── NarrativeFacts 수집 (D1 저장)                           │
│                         ↓                                   │
│  Stage 3: Vectorize Pipeline                                │
│  ├── LLM으로 10-12개 검색 쿼리 생성                           │
│  ├── OpenAI Embedding (text-embedding-3-small, 1536d)        │
│  ├── Cloudflare Vectorize에서 후보 600-800개 검색             │
│  └── Multi-Query 배치로 Vectorize 100개 상한 우회             │
│                         ↓                                   │
│  Stage 4: TAG Filter                                        │
│  ├── Hard Exclusion: 절대 부적합 직업 제거                    │
│  ├── Risk Penalty: 경고/감산 적용                             │
│  └── 강도 구분: absolute / prefer_avoid / acceptable          │
│                         ↓                                   │
│  Stage 5: Personalized Scoring                              │
│  ├── User × Job 교차 매칭                                    │
│  ├── 흥미/가치/업무스타일/강점 → 직업 속성 매핑               │
│  ├── Like/Can 기초 점수 산출                                  │
│  ├── Fact Score Mapping으로 boost 적용                       │
│  └── Fit = 0.5 × Like + 0.5 × Can - Risk                   │
│                         ↓                                   │
│  Stage 6: LLM Judge + Reporter                              │
│  ├── Judge: GPT-4o-mini로 Fit/Desire/Feasibility 3차원 평가  │
│  │   (배치 5개씩, 최대 60개 후보 병렬 처리)                   │
│  ├── 사용자 원문 인용(evidence quote) 필수 포함               │
│  └── Reporter: 심리분석 + 추천 + 실행계획 서사적 리포트 생성   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 6.3 5축 프레임워크

| 축 | 영문 | 설명 | 수집 방식 |
|----|------|------|-----------|
| 흥미 | interest | 무엇에 끌리는가 | MiniModule Q1-Q3 |
| 가치 | value | 무엇을 중시하는가 | MiniModule Q4-Q6 |
| 강점 | strength | 무엇을 잘하는가 | MiniModule Q7-Q9 |
| 제약 | constraint | 무엇을 못/안 하는가 | MiniModule Q10-Q12 |
| 업무스타일 | workstyle | 어떻게 일하고 싶은가 | MiniModule Q13-Q15 |

### 6.4 파일 구조 (47개 → 주요 15개)

| 파일 | 줄 수 | 역할 |
|------|------:|------|
| `routes.ts` | 8,154 | 모든 AI API 엔드포인트 |
| `vectorize-pipeline.ts` | 3,330 | Multi-Query 벡터 검색 |
| `llm-judge.ts` | 2,433 | LLM 다차원 평가 |
| `llm-reporter.ts` | 2,319 | 서사적 리포트 생성 |
| `fact-score-mapping.ts` | 2,221 | Fact → 점수 매핑 |
| `llm-interviewer.ts` | ~2,000 | 3라운드 심층 질문 |
| `premium-report-generator.ts` | ~1,800 | 규칙 기반 리포트 생성 |
| `personalized-scoring.ts` | ~1,500 | Like/Can 점수 산출 |
| `tag-filter.ts` | ~1,200 | Hard Exclusion + Risk |
| `mini-module-questions.ts` | ~1,000 | 15개 미니 질문 정의 |
| `openai-client.ts` | ~800 | OpenAI API 래퍼 |
| `types.ts` | ~600 | 전체 타입 정의 |
| `axis-framework.ts` | ~400 | 5축 프레임워크 |
| `auto-tagger.ts` | ~400 | 직업 자동 태깅 |
| `internal-conflict-risk.ts` | ~300 | 내적 갈등 감지 |

### 6.5 LLM 사용 현황

| 모델 | 용도 | 비용 |
|------|------|------|
| GPT-4o-mini | 심층 인터뷰 질문 생성 | ~$0.01/회 |
| GPT-4o-mini | 검색 쿼리 확장 | ~$0.005/회 |
| GPT-4o-mini | LLM Judge (60개 후보) | ~$0.02/회 |
| GPT-4o-mini | Reporter (리포트 생성) | ~$0.01/회 |
| text-embedding-3-small | 벡터 임베딩 | ~$0.005/회 |
| **총 분석 1회당** | | **~$0.05-0.06** |

### 6.6 벡터 검색 상세

```
Vectorize Index: careerwiki-embeddings
├── 모델: OpenAI text-embedding-3-small (1536차원)
├── 거리 메트릭: cosine
├── 저장 대상: 직업 (6,945개) + 전공 (608개) + HowTo
├── 제약: topK 상한 100개/쿼리
└── 우회: Multi-Query 배치 (10-12개 쿼리 × 100개 = 1,000개 후보 풀)
```

---

## 7. 위키 편집 시스템

### 7.1 개요

직업/전공 상세 페이지의 정보를 사용자가 직접 편집할 수 있는 위키 시스템.

### 7.2 편집 플로우

```
사용자 → "편집" 버튼 클릭 → 편집 모드 진입
  ├── 로그인 사용자: 바로 편집 가능
  └── 비로그인 사용자: 비밀번호 입력 후 편집

필드 수정 → POST /api/job/:id/edit (또는 major)
  ├── 변경 사항을 user_contributed_json에 저장
  ├── job_data_revisions에 리비전 기록
  ├── merged_profile_json 재계산
  └── ISR 캐시 퍼지
```

### 7.3 데이터 병합 우선순위

```
admin_data_json > user_contributed_json > api_data_json
(관리자 수정)     (사용자 기여)           (외부 API)
```

- 관리자 데이터가 최우선
- 사용자 기여가 그 다음
- 외부 API 원본이 기본값

### 7.4 편집 제한

| 항목 | 제한 |
|------|------|
| 익명 편집 | IP당 10회/일/entity |
| 필드 검증 | `editValidation.ts`에서 XSS 필터링 |
| 히스토리 | 모든 편집은 revision으로 기록 |
| 관리자 | 직접 `admin_data_json` 수정 가능 |

### 7.5 TipTap 에디터 (HowTo용)

HowTo 가이드 콘텐츠 작성을 위한 리치 텍스트 에디터.

**빌드**: `src/editor/` → Vite IIFE → `public/static/editor.bundle.iife.js` (449KB)

**기능**:
- 슬래시 메뉴 (`/`로 블록 삽입)
- 이미지 업로드 (R2 저장)
- 자동저장 (3초 debounce)
- 커스텀 노드: 체크포인트 박스, 결론 박스, Q&A 블록, 진로 목록, 각주
- 테이블, 리스트, 인용, 코드블록 등

---

## 8. HowTo 콘텐츠 시스템

### 8.1 개요

진로 가이드 콘텐츠를 작성/발행하는 시스템. "경찰 체력 시험 준비 가이드", "간호사 면접 준비법" 같은 실용적 가이드를 제공한다.

### 8.2 콘텐츠 라이프사이클

```
초안 작성 (draft) → 리뷰 요청 → 발행 (published) → 수정/비공개
```

### 8.3 기능 목록

| 기능 | 설명 |
|------|------|
| 목록 | 발행된 가이드 목록, 페이지네이션, 검색, 태그 필터 |
| 상세 | TipTap JSON → HTML 렌더링, 댓글, 조회수, 북마크 |
| 작성 | TipTap 에디터, 자동저장, 이미지 업로드 |
| 편집 | 작성자 또는 관리자만 편집 가능 |
| 태깅 | 태그 시스템 (tags + howto_tags) |
| 연결 | 관련 직업/전공 링크 (howto_related_jobs/majors) |
| 검색 | 통합 검색에서 HowTo도 결과에 포함 |
| JSON-LD | 구조화 데이터 (SEO) |

---

## 9. 외부 API 연동

### 9.1 CareerNet (한국교육개발원 진로정보망)

| 항목 | 내용 |
|------|------|
| 도메인 | `career.go.kr` |
| 인증 | API Key (`CAREER_NET_API_KEY`) |
| 응답 형식 | XML (자체 파싱) + JSON |
| 파일 | `src/api/careernetAPI.ts` |

**제공 데이터**: 학과 검색/상세, 직업 검색/상세, 직업백과

### 9.2 고용24 (Work24)

| 항목 | 내용 |
|------|------|
| 도메인 | `work24.go.kr` |
| 인증 | API Key 2개 (`GOYONG24_MAJOR_API_KEY`, `GOYONG24_JOB_API_KEY`) |
| 응답 형식 | XML (자체 파싱) |
| 파일 | `src/api/goyong24API.ts` |

**제공 데이터**: 학과 목록/상세, 직업 목록/상세 (7개 하위 API: Summary, Duty, Path, SalProspect, AblKnwEnv, ChrIntrVals, Actv)

### 9.3 데이터 ETL 프로세스

```
외부 API 호출 → 정규화(Normalize) → job_sources/major_sources에 저장
  → 병합(Merge) → api_data_json 업데이트
  → user_contributed + admin_data와 병합 → merged_profile_json 최종 생성
```

ETL 스크립트:
- `npm run etl:merge-jobs` — 직업 데이터 병합
- `npm run etl:merge-majors` — 전공 데이터 병합
- `npm run etl:merge-all` — 전체 ETL

---

## 10. 인증 & 보안

### 10.1 인증 체계

```
┌─────────────────────────────────────────────┐
│          인증 플로우                          │
│                                             │
│  1. Google OAuth 2.0                        │
│     사용자 → /auth/google → Google 로그인    │
│     → /auth/callback → 세션 발급            │
│                                             │
│  2. Opaque Session Token (현행)              │
│     쿠키: session_token (HttpOnly, Secure)   │
│     저장: Cloudflare KV                      │
│     형식: UUID-UUID (73자)                   │
│                                             │
│  3. JWT fallback (마이그레이션 기간)           │
│     기존 JWT 보유 사용자 → 자동 세션 발급      │
│     → JWT 쿠키 삭제                          │
│                                             │
└─────────────────────────────────────────────┘
```

### 10.2 세션 관리

| 설정 | 값 |
|------|-----|
| 유휴 타임아웃 | 7일 |
| 절대 최대 수명 | 30일 |
| Sliding window 디바운스 | 5분 |
| 사용자당 최대 세션 | 10개 |
| 감사 로그 | 토큰 SHA-256 해시로 기록 (원본 미저장) |
| IP 마스킹 | IPv4 마지막 옥텟, IPv6 앞 4블록만 |

### 10.3 권한 체계

```
user (1) < expert (2) < admin (3)

미들웨어:
├── requireAuth        로그인 필수
├── requireRole(min)   최소 역할 확인
├── requireAdmin       관리자 전용
├── requireExpert      전문가 이상
├── requireJobMajorEdit  직업/전공 편집 (로그인+비로그인)
└── requireHowToEdit   HowTo 편집 (로그인 필수)
```

### 10.4 보안 미들웨어 (프로덕션 적용)

```
Security Headers:
├── X-Content-Type-Options: nosniff
├── X-Frame-Options: DENY
├── Referrer-Policy: strict-origin-when-cross-origin
├── Permissions-Policy: camera=(), microphone=(), geolocation=()
├── Strict-Transport-Security: max-age=31536000; includeSubDomains
└── Content-Security-Policy:
    ├── default-src 'self'
    ├── script-src 'self' 'unsafe-inline' 'unsafe-eval' cdnjs, jsdelivr
    ├── style-src 'self' 'unsafe-inline' cdnjs, jsdelivr, fonts.googleapis
    ├── img-src 'self' data: blob: https:
    ├── font-src 'self' data: cdnjs, jsdelivr, fonts.gstatic
    ├── connect-src 'self'
    ├── frame-src 'none'
    ├── object-src 'none'
    └── base-uri 'self'

CORS: origin 제한 — https://careerwiki.org 만 허용

Rate Limiting (AI Analyzer):
├── 대상: POST /api/ai-analyzer/*
├── 방식: KV 기반 Token Bucket
├── 제한: 20 요청/분/IP
└── 응답: 429 + Retry-After 헤더
```

### 10.5 입력 검증

| 방어 | 구현 |
|------|------|
| XSS | `escapeHtml()`, `serializeForScript()`, `sanitizeContent()` |
| SQL Injection | D1 Prepared Statement (파라미터 바인딩) |
| CSRF (OAuth) | OAuth state 파라미터 |
| Open Redirect | `sanitizeReturnUrl()` 상대 경로만 허용 |
| SVG XSS | SVG 업로드 차단 |
| 밴 유저 | 세션 즉시 파괴 |

---

## 11. 빌드 & 배포

### 11.1 빌드 파이프라인

```
1. TailwindCSS 빌드
   src/**/*.{ts,tsx} → public/static/tailwind.css (minified)

2. TipTap 에디터 빌드 (별도)
   src/editor/index.ts → public/static/editor.bundle.iife.js (IIFE, 449KB)

3. Vite 빌드
   src/index.tsx → dist/_worker.js (단일 번들)
   ├── 플러그인: cloudflareWasmPlugin, @hono/vite-build
   ├── 타겟: es2022, esbuild minify
   ├── 단일 청크 (Cloudflare Workers 제약)
   └── WASM: @resvg/resvg-wasm 번들링

4. 배포
   dist/ → Cloudflare Pages (wrangler pages deploy)
```

### 11.2 주요 명령어

| 명령어 | 동작 |
|--------|------|
| `npm run dev` | 로컬 개발 서버 (port 3000, remote D1/R2/KV) |
| `npm run build` | TailwindCSS + Vite 프로덕션 빌드 |
| `npm run build:editor` | TipTap 에디터 IIFE 번들 빌드 |
| `npm run build:all` | 에디터 + 메인 빌드 |
| `npm run deploy` | 빌드 + wrangler pages deploy |
| `npx tsc --noEmit` | TypeScript 타입 체크 (빌드 전 필수) |
| `npm run db:migrate:local` | D1 로컬 마이그레이션 |
| `npm run db:migrate:prod` | D1 프로덕션 마이그레이션 |

### 11.3 TypeScript 설정

```
타겟: ESNext
모듈: ESNext (Bundler resolution)
Strict: true
JSX: react-jsx (hono/jsx)
```

### 11.4 정적 에셋

| 파일 | 크기 | 용도 |
|------|------|------|
| `tailwind.css` | ~121KB | TailwindCSS 빌드 결과 |
| `editor.bundle.iife.js` | ~449KB | TipTap 에디터 |
| `api-client.js` | ~307KB | 프론트엔드 API 유틸 |
| `edit-mode.js` | — | 직업/전공 편집 클라이언트 |
| `resume-upload.js` | — | 이력서 업로드 |
| `scenario-runner.js` | — | E2E 테스트 러너 |
| `perf-metrics.js` | — | 성능 메트릭 수집 |

---

## 12. 운영 & 모니터링

### 12.1 Cron 스케줄러

`src/index.tsx`의 `scheduled` 핸들러로 정의:

| 작업 | 주기 | 설명 |
|------|------|------|
| SERP Freshness | 60분 | 미리 정의된 검색 타겟의 데이터 신선도 갱신 |
| Vectorize Indexing | cron 트리거 시 | 직업/전공/HowTo 증분 인덱싱 (최대 20개/실행) |

**현재 상태**: Cloudflare Pages에서는 cron trigger가 직접 지원되지 않아 주석 처리됨. 별도 Worker 또는 외부 트리거 필요.

### 12.2 디자인 테마

```css
/* TailwindCSS 커스텀 색상 */
wiki-bg:        #0f0f23    (배경)
wiki-card:      #1a1a2e    (카드 배경)
wiki-border:    #2a2a3e    (테두리)
wiki-primary:   #4361ee    (주요 액션)
wiki-secondary: #64b5f6    (보조)
wiki-text:      #e0e0e0    (텍스트)
wiki-muted:     #9ca3af    (비활성)
```

다크 모드 기반 디자인. `darkMode: 'class'` 설정.

### 12.3 SEO

| 항목 | 구현 |
|------|------|
| JSON-LD | 직업/전공/HowTo 상세 페이지에 구조화 데이터 |
| OG 태그 | 모든 페이지 Open Graph 메타태그 |
| Sitemap | — |
| URL 구조 | `/job/:slug`, `/major/:slug`, `/howto/:slug` |

### 12.4 캐싱 전략

| 레이어 | 방식 | 대상 |
|--------|------|------|
| CDN (Cloudflare) | ETag + 버전 기반 | 직업/전공 상세 페이지 |
| KV | TTL 기반 | SERP 데이터, 검색 캐시, 세션 |
| 브라우저 | Cache-Control | 정적 에셋 |
| API | `private, no-store` | 인증된 API 응답 |

---

## 13. 비용 구조

### 13.1 월간 운영 비용 추정

| 항목 | 월 비용 | 비고 |
|------|--------:|------|
| Cloudflare Workers/Pages | $5 | Paid plan |
| Cloudflare D1 | $5 | 5GB 포함 |
| Cloudflare R2 | $0-5 | 10GB 무료 |
| Cloudflare KV | $5 | 10M reads 포함 |
| Cloudflare Vectorize | $5-10 | 인덱스 크기 기반 |
| OpenAI API | $100-150 | 100회/일 분석 기준 |
| 도메인 | $1-2 | .org 연간 ~$12 |
| **합계** | **$121-177** | |

### 13.2 OpenAI 비용 상세

| 용도 | 단가/회 | 월 비용 (100회/일) |
|------|--------:|-------------------:|
| LLM 인터뷰 (3라운드) | ~$0.01 | ~$30 |
| 검색 쿼리 확장 | ~$0.005 | ~$15 |
| LLM Judge | ~$0.02 | ~$60 |
| Reporter | ~$0.01 | ~$30 |
| Embedding | ~$0.005 | ~$15 |
| **소계** | **~$0.05** | **~$150** |

---

## 14. 성숙도 평가 & 로드맵

### 14.1 종합 평가

**성숙도 단계: Growth (성장기)**

| 영역 | 점수 | 평가 |
|------|-----:|------|
| 코드 품질 | 2.5/5 | `any` 575건, 거대 파일 4개, 테스트 < 0.1% |
| 기능 완성도 | 4.2/5 | 62개 기능 중 48개 완성 (77.4%) |
| 보안 | 3.0/5 | 세션 관리 우수, CORS/CSP/Rate Limit 적용 완료 |
| 운영 | 3.0/5 | 모니터링/알림 미구축, 로깅 비구조화 |
| 성능 | 3.5/5 | ISR/CDN 캐싱 적용, AI 파이프라인 15-25초 |
| **종합** | **3.2/5** | |

### 14.2 SWOT 분석

| | 긍정적 | 부정적 |
|---|--------|--------|
| **내부** | **강점**: AI 파이프라인 정교함, 순환 의존성 0, 견고한 세션 관리, 3계층 데이터 통합 | **약점**: 테스트 부재, 거대 파일 구조, `any` 타입 남발, 구조화 로깅 미도입 |
| **외부** | **기회**: 한국어 진로 시장 니치, AI 추천 차별화, 위키 커뮤니티 성장 가능성 | **위협**: 외부 API 의존성, OpenAI 비용 변동, CF Workers CPU 한도 |

### 14.3 개선 로드맵 (우선순위)

#### 즉시 (1-2주)

| # | 항목 | 효과 |
|---|------|------|
| 1 | 테스트 코드 추가 (핵심 서비스) | 회귀 방어, 리팩토링 안전망 |
| 2 | 거대 파일 분할 (analyzer-job-page, routes.ts) | 유지보수성 개선 |
| 3 | `any` 타입 정리 (핵심 서비스 우선) | 타입 안전성 향상 |

#### 단기 (1-2개월)

| # | 항목 | 효과 |
|---|------|------|
| 4 | 구조화 로깅 도입 | 운영 가시성 향상 |
| 5 | API 전체 Rate Limiting | 악용 방어 |
| 6 | Cron Worker 분리 배포 | 스케줄러 안정화 |
| 7 | 데드코드 정리 | 코드베이스 간소화 |

#### 중기 (3-6개월)

| # | 항목 | 효과 |
|---|------|------|
| 8 | CI/CD 파이프라인 | 자동 빌드/테스트/배포 |
| 9 | 모니터링/알림 시스템 | 장애 대응 시간 단축 |
| 10 | AI 파이프라인 최적화 (캐싱, 병렬화) | 비용 절감, 응답 속도 개선 |

---

## 15. 부록: 상세 참조

### A. 환경 변수

| 변수 | 용도 |
|------|------|
| `CAREER_NET_API_KEY` | CareerNet API 인증 |
| `GOYONG24_MAJOR_API_KEY` | 고용24 전공 API 인증 |
| `GOYONG24_JOB_API_KEY` | 고용24 직업 API 인증 |
| `ADMIN_SECRET` | 관리자 API 시크릿 |
| `JWT_SECRET` | JWT 서명 키 (레거시) |
| `GOOGLE_CLIENT_ID` | Google OAuth 클라이언트 ID |
| `GOOGLE_CLIENT_SECRET` | Google OAuth 시크릿 |
| `OPENAI_API_KEY` | OpenAI API 키 |
| `CLOUDFLARE_API_TOKEN` | Cloudflare API 토큰 |

> 모두 `.dev.vars` 파일에 저장 (절대 커밋 금지)

### B. 마이그레이션 목록

```
0001_pages.sql                  위키 페이지 테이블
0002_comments.sql               댓글 테이블
0003_comment_likes.sql          댓글 좋아요
0004_users.sql                  사용자 테이블
0005_user_sessions.sql          세션 테이블
0006_job_tables.sql             직업 기본 테이블
0007_major_tables.sql           전공 기본 테이블
0008_feedback.sql               피드백 테이블
0008_job_sources.sql            직업 소스 테이블
0009_major_sources.sql          전공 소스 테이블
0010_unified_data_columns.sql   통합 데이터 컬럼
0011_categories.sql             카테고리 테이블
0012_merge_data_columns.sql     병합 데이터 컬럼
0013_edit_tracking.sql          편집 추적
0014_howto_tables.sql           HowTo 테이블
0015_search_tables.sql          검색 통계
0016_related_content.sql        관련 콘텐츠
0017_view_stats.sql             조회 통계
0018_embedding_metadata.sql     임베딩 메타데이터
0019_ai_session_tables.sql      AI 세션 테이블
0020_howto_extensions.sql       HowTo 확장
0021_user_contributions.sql     사용자 기여
0022_serp_freshness.sql         SERP 신선도
0023-0044                       점진적 스키마 개선/확장
```

### C. 정적 에셋 전체 목록

```
public/static/
├── tailwind.css              TailwindCSS 빌드 결과물
├── style.css                 커스텀 전역 스타일
├── edit-mode.css             편집 모드 스타일
├── howto-editor.css          HowTo 에디터 스타일
├── howto-content.css         HowTo 콘텐츠 스타일
├── editor.bundle.iife.js     TipTap 에디터 번들
├── edit-mode.js              편집 모드 클라이언트 JS
├── api-client.js             프론트엔드 API 유틸
├── resume-upload.js          이력서 업로드
├── scenario-runner.js        E2E 테스트 러너
├── perf-metrics.js           성능 메트릭
├── _routes.json              CF Pages 라우팅 설정
├── favicon.ico               파비콘
└── images/
    ├── CWfavicon.png         파비콘 PNG
    ├── CWheaderlogo.png      헤더 로고
    ├── CWmainlogo.png        메인 로고
    ├── og-default.png        OG 기본 이미지
    └── og-share-card.png     OG 공유 카드
```

### D. 관련 보고서 (상세)

| 보고서 | 경로 | 내용 |
|--------|------|------|
| 기술 컨설팅 리포트 | `docs/reports/technical-audit-2026-03-03.md` | 종합 평가 (SWOT, 점수, 로드맵) |
| 아키텍처 분석 | `docs/reports/architecture-analysis.md` | 코드 구조, 의존성, 품질 지표 |
| 제품 완성도 분석 | `docs/reports/product-analysis.md` | 62개 기능 인벤토리 |
| 보안 & 운영 분석 | `docs/reports/security-ops-analysis.md` | 인증, 보안, 운영 상세 |

---

> **문서 끝** — Careerwiki 프로젝트 종합 문서 (2026-03-03)
