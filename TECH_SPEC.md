# CareerWiki Phase 1 - Technical Specification

> **문서 버전**: 1.0  
> **최종 업데이트**: 2025-10-25  
> **작성자**: AI Development Agent  
> **목적**: 비개발자도 이해할 수 있는 구체적인 기술 명세서 및 개발 인수인계서

---

## 📋 목차

1. [목표 및 비목표 (Goal & Non-Goal)](#1-목표-및-비목표-goal--non-goal)
2. [현재 상태 (Current Status)](#2-현재-상태-current-status)
3. [시스템 아키텍처](#3-시스템-아키텍처)
4. [데이터 모델 및 플로우](#4-데이터-모델-및-플로우)
5. [요구사항 목록 (Requirements)](#5-요구사항-목록-requirements)
6. [코드 레벨 구현 지침](#6-코드-레벨-구현-지침)
7. [개선 필요 사항 (Technical Debt)](#7-개선-필요-사항-technical-debt)
8. [배포 및 운영](#8-배포-및-운영)

---

## 1. 목표 및 비목표 (Goal & Non-Goal)

### 1.1 이번 구현의 목표 (Goal)

**핵심 목표**: AI 기반 진로 분석 플랫폼의 **위키 기반 정보 제공 시스템** 구축

#### 주요 달성 목표:

1. **직업/전공 정보 통합 위키**
   - 커리어넷(교육부)과 고용24(고용노동부) 두 개의 공공 API를 통합
   - 실시간 데이터 수집 및 통합 표시
   - 소스별 데이터 상태 추적 (성공/실패/스킵)

2. **SEO 최적화된 SSR 페이지**
   - 직업 상세: `/job/:slug` (예: `/job/변호사--job-g-k000007482`)
   - 전공 상세: `/major/:slug`
   - 직업 목록: `/job` (검색/필터 지원)
   - 전공 목록: `/major` (검색 지원)
   - HowTo 가이드: `/howto/:slug`

3. **캐싱 및 성능 최적화**
   - Cloudflare KV 기반 목록 캐싱 (stale-while-revalidate 전략)
   - Cron 기반 자동 재검증 (30분 간격)
   - 성능 메트릭 수집 (Core Web Vitals)

4. **커뮤니티 기능 준비**
   - D1 기반 댓글 시스템 (익명 지원)
   - IP 기반 신고/차단 시스템
   - 좋아요/싫어요 기능

5. **AI 분석 파이프라인 인프라**
   - AI 세션/요청/결과 D1 테이블
   - SERP 상호작용 로그 수집
   - 향후 Claude/GPT 통합 준비

### 1.2 비목표 (Non-Goal)

**이번 구현에서 하지 않는 것들:**

❌ **사용자 인증 시스템**
- 로그인/회원가입 기능
- OAuth 통합
- 사용자 권한 관리
- 이유: Phase 2에서 구현 예정

❌ **실제 AI 모델 호출**
- Claude/GPT API 실제 연동
- AI 분석 결과 생성
- 이유: D1 테이블만 준비, 실제 호출은 Phase 3

❌ **결제 시스템**
- Stripe 통합
- Pro 플랜 기능
- 이유: MVP 검증 후 구현

❌ **실시간 채팅/알림**
- WebSocket 기반 실시간 기능
- 푸시 알림
- 이유: Cloudflare Workers 제약 + 우선순위 낮음

❌ **다국어 지원**
- i18n 시스템
- 이유: 한국어만 지원 (영어는 Phase 3 이후)

❌ **모바일 앱**
- React Native/Flutter 앱
- 이유: 웹 우선 전략

---

## 2. 현재 상태 (Current Status)

### 2.1 프로젝트 구조

```
webapp/
├── src/
│   ├── index.tsx (3,779 lines)        # 메인 애플리케이션 + 모든 라우트
│   ├── api/                           # 외부 API 클라이언트
│   │   ├── careernetAPI.ts (611 lines)
│   │   └── goyong24API.ts (824 lines)
│   ├── services/                      # 비즈니스 로직
│   │   ├── profileDataService.ts (674)  # 데이터 통합
│   │   ├── profileMerge.ts (277)        # 소스 병합 로직
│   │   ├── cacheService.ts (217)        # KV 캐싱
│   │   ├── freshnessService.ts (511)    # 재검증 스케줄
│   │   ├── commentService.ts (688)      # 댓글 CRUD
│   │   ├── perfMetricsService.ts (647)  # 성능 메트릭
│   │   ├── aiAnalysisService.ts (289)   # AI 세션 관리
│   │   └── serpInteractionService.ts (136)
│   ├── templates/                     # SSR 템플릿
│   │   ├── unifiedJobDetail.ts (1,466 lines)
│   │   ├── unifiedMajorDetail.ts (386)
│   │   ├── howtoDetail.ts (629)
│   │   └── detailTemplateUtils.ts (1,056) # 공통 헬퍼
│   ├── types/                         # TypeScript 타입
│   │   ├── unifiedProfiles.ts
│   │   ├── aiAnalysis.ts
│   │   └── howto.ts
│   ├── config/                        # 설정
│   │   ├── cachePolicy.ts
│   │   └── freshnessConfig.ts
│   ├── data/
│   │   └── sampleRegistry.ts          # 샘플 데이터
│   └── utils/
│       └── slug.ts                    # URL 슬러그 처리
├── public/static/
│   ├── api-client.js (117KB)          # 클라이언트 하이드레이션
│   ├── perf-metrics.js (13KB)         # 성능 측정
│   └── style.css
├── migrations/
│   ├── 0001_initial_schema.sql        # 기본 테이블
│   ├── 0002_career_analysis_pipeline.sql
│   └── 0003_comment_policy.sql
├── wrangler.jsonc                     # Cloudflare 설정
├── package.json
└── README.md
```

### 2.2 완료된 기능 (✅ Implemented)

#### A. 핵심 위키 기능
- ✅ **직업 상세 페이지** (`/job/:slug`)
  - CareerNet + 고용24 실시간 통합
  - 변호사 페이지 특별 템플릿 (불필요한 블록 제거)
  - Hero, Quick Stats, 탭 기반 레이아웃
  - JSON-LD, OG 메타, canonical URL
  - 소스 비교 매트릭스 (변호사 전용)

- ✅ **전공 상세 페이지** (`/major/:slug`)
  - 커리큘럼, 진로, 대학 정보
  - 탭 기반 UX
  
- ✅ **직업 목록** (`/job`)
  - 검색 (keyword)
  - 카테고리 필터
  - KV 캐싱 (1시간 stale, 6시간 max-age)
  - 캐시 상태 배지
  - ItemList JSON-LD

- ✅ **전공 목록** (`/major`)
  - 키워드 검색
  - KV 캐싱
  - 소스 상태 표시

- ✅ **HowTo 가이드** (`/howto/:slug`)
  - 진로 설정 방법론
  - 커뮤니티 정책 카드

#### B. 데이터 통합
- ✅ **API 클라이언트**
  - CareerNet: 611 lines (직업/전공 검색, 상세)
  - 고용24: 824 lines (직업/전공/학과 상세, 학력/전공 분포)
  - 헤더 프로필 재시도 로직 (403/500 대응)
  
- ✅ **데이터 병합**
  - `mergeJobProfiles()`: 두 소스 필드별 병합
  - `mergeMajorProfiles()`: 전공 데이터 병합
  - 소스 상태 추적 (`SourceStatusRecord`)

#### C. 캐싱 및 성능
- ✅ **KV 캐싱**
  - stale-while-revalidate 전략
  - `?refresh=1` 수동 재검증
  - 캐시 키: `list:job|major:q=...&category=...&page=...`
  
- ✅ **Freshness 모니터링**
  - Cron 스케줄러 (`*/30 * * * *`)
  - 타겟별 재검증
  - `/api/freshness/status`, `/api/freshness/run`

- ✅ **성능 메트릭**
  - Core Web Vitals (TTFB, FCP, LCP, CLS, FID)
  - 하이드레이션 이벤트
  - KV 저장 (`/api/perf-metrics`)

#### D. 커뮤니티 인프라
- ✅ **D1 테이블**
  - `pages`: 위키 페이지 메타데이터
  - `comments`: 댓글 (익명 지원, 중첩 가능)
  - `comment_reactions`: 좋아요/싫어요
  - `comment_reports`: 신고
  - `ip_blocks`: IP 차단
  
- ✅ **댓글 API**
  - `POST /api/comments`: 생성
  - `GET /api/comments?slug=...`: 조회
  - `POST /api/comments/:id/like`: 좋아요
  - `POST /api/comments/:id/flag`: 신고
  - IP 해시 기반 익명성

#### E. AI 분석 준비
- ✅ **D1 테이블**
  - `ai_sessions`: 분석 세션
  - `ai_analysis_requests`: 요청
  - `ai_analysis_results`: 결과
  - `serp_interaction_logs`: SERP 로그
  
- ✅ **API 엔드포인트**
  - `POST /api/analyzer/sessions`
  - `POST /api/analyzer/requests`
  - `POST /api/analyzer/requests/:id/result`
  - `POST /api/serp-interactions`

### 2.3 미완료 기능 (⏳ Pending)

#### A. 인증 및 권한
- ⏳ 로그인/회원가입 UI
- ⏳ OAuth 통합 (Google, Kakao)
- ⏳ JWT 세션 관리
- ⏳ 사용자 역할 (User, Admin, Pro)

#### B. AI 실제 연동
- ⏳ Claude API 호출 로직
- ⏳ OpenAI API 호출 로직
- ⏳ 프롬프트 템플릿
- ⏳ 토큰/비용 추적
- ⏳ 재시도/타임아웃 처리

#### C. 댓글 UI
- ⏳ 프론트엔드 댓글 폼
- ⏳ 댓글 목록 렌더링
- ⏳ 실시간 좋아요 카운터
- ⏳ 신고 후 모더레이션 UI

#### D. 검색 고도화
- ⏳ 전체 사이트 통합 검색
- ⏳ 자동완성
- ⏳ 검색 히스토리

#### E. 운영 대시보드
- ⏳ 성능 메트릭 조회 UI
- ⏳ 캐시 관리 도구
- ⏳ 댓글 모더레이션 패널

### 2.4 알려진 문제 (Known Issues)

1. **KV 스토리지 에러**
   - `[perf-metrics] failed to store TypeError: Cannot read properties of undefined (reading 'put')`
   - 원인: 로컬 개발 환경에서 KV 바인딩 누락
   - 영향: 성능 메트릭 저장 실패 (핵심 기능에는 영향 없음)
   - 해결: wrangler.jsonc에 KV 바인딩 추가 필요

2. **index.tsx 파일 크기**
   - 3,779 lines - 너무 큼
   - 모든 라우트가 한 파일에 집중
   - 개선 필요: 라우트 분리

3. **코드 중복**
   - 직업/전공 상세 템플릿에 유사한 로직 반복
   - 탭 렌더링 로직 중복
   - 개선 필요: 공통 컴포넌트화

4. **D1 마이그레이션 미적용**
   - wrangler.jsonc에 d1_databases 설정 없음
   - 로컬에서 마이그레이션 실행 불가
   - 해결: D1 데이터베이스 생성 및 바인딩 추가

---

## 3. 시스템 아키텍처

### 3.1 전체 아키텍처 다이어그램

```
┌─────────────────────────────────────────────────────────────┐
│                        사용자 브라우저                          │
│  - HTML/CSS/JS 렌더링                                        │
│  - api-client.js (하이드레이션)                               │
│  - perf-metrics.js (성능 측정)                               │
└─────────────────┬───────────────────────────────────────────┘
                  │ HTTPS
                  ▼
┌─────────────────────────────────────────────────────────────┐
│                  Cloudflare Pages/Workers                    │
│                                                               │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              Hono Application (index.tsx)             │  │
│  │                                                        │  │
│  │  Routes:                                              │  │
│  │  - / (홈)                                             │  │
│  │  - /job, /major, /howto (목록)                        │  │
│  │  - /job/:slug, /major/:slug (상세)                    │  │
│  │  - /api/* (REST API)                                  │  │
│  └────┬──────────────────────────────────────────────────┘  │
│       │                                                      │
│  ┌────▼────────────────────────────────────────────────┐   │
│  │              Services Layer                          │   │
│  │  - profileDataService (데이터 통합)                  │   │
│  │  - cacheService (KV 캐싱)                           │   │
│  │  - commentService (댓글 CRUD)                       │   │
│  │  - perfMetricsService (성능)                        │   │
│  └────┬───────────────────┬───────────────────────────┘   │
│       │                   │                               │
│  ┌────▼────────┐    ┌────▼────────┐                      │
│  │ API Clients │    │  Templates  │                      │
│  │ - CareerNet │    │ - Job Detail│                      │
│  │ - Goyong24  │    │ - Major Det.│                      │
│  └─────────────┘    │ - HowTo     │                      │
│                     └─────────────┘                      │
└───────┬───────────────────┬─────────────────────────────┘
        │                   │
        ▼                   ▼
┌───────────────┐   ┌──────────────────┐
│ External APIs │   │ Cloudflare Data  │
│ - CareerNet   │   │ - D1 (SQLite)    │
│ - Goyong24    │   │ - KV (Cache)     │
└───────────────┘   └──────────────────┘
```

### 3.2 데이터 플로우

#### A. 직업 상세 조회 플로우

```
사용자 → /job/lawyer
    ↓
index.tsx: app.get('/job/:slug')
    ↓
resolveDetailIdFromSlug('lawyer')
    → { id: 'job:G_K000007482', source: 'GOYONG24' }
    ↓
getUnifiedJobDetail(id, env)
    ↓
    ├─ fetchCareernetJob(375) → CareerNet API
    │       ↓
    │   parseCareernetJob() → UnifiedJobDetail (partial)
    │
    └─ fetchGoyong24JobDetail('K000007482') → Goyong24 API
            ↓
        parseGoyong24Job() → UnifiedJobDetail (partial)
    ↓
mergeJobProfiles([careernet, goyong24])
    → UnifiedJobDetail (merged)
    ↓
applyJobDetailOverrides('lawyer') → 특별 처리
    ↓
renderUnifiedJobDetail(profile, partials, sources)
    ↓
HTML Response (SSR)
```

#### B. 직업 목록 조회 플로우 (캐싱)

```
사용자 → /job?q=개발자&category=100060
    ↓
index.tsx: app.get('/job')
    ↓
buildListCacheKey('job', params)
    → 'list:job:q=개발자&category=100060&page=1'
    ↓
withKvCache(key, fetcher, policy)
    ↓
    ├─ KV.get(key) → 캐시 확인
    │   ├─ HIT & fresh → 캐시 반환
    │   ├─ HIT & stale → 백그라운드 재검증 + 캐시 반환
    │   └─ MISS → fetcher 실행
    │
    └─ fetcher: searchUnifiedJobs(params, env)
            ↓
        careernetAPI.searchJobs() + goyong24API.listJobs()
            ↓
        병합 및 중복 제거
            ↓
        KV.put(key, data, { expirationTtl: 6h })
    ↓
recordListFreshness(target, result) → 스냅샷 저장
    ↓
renderJobList(results, cacheState)
    ↓
HTML Response (SSR)
```

### 3.3 기술 스택

| 계층 | 기술 | 용도 |
|-----|------|-----|
| **Runtime** | Cloudflare Workers | 엣지 컴퓨팅 플랫폼 |
| **Framework** | Hono 4.9.9 | 웹 프레임워크 |
| **Language** | TypeScript 5.9.3 | 타입 안전성 |
| **Build** | Vite 6.3.5 | 빌드 도구 |
| **Deploy** | Wrangler 4.4.0 | Cloudflare CLI |
| **Database** | Cloudflare D1 (SQLite) | 관계형 DB |
| **Cache** | Cloudflare KV | Key-Value 스토어 |
| **Frontend** | Vanilla JS + TailwindCSS | 클라이언트 |
| **Process** | PM2 | 로컬 개발 |

---

## 4. 데이터 모델 및 플로우

### 4.1 핵심 타입 정의

#### A. UnifiedJobDetail

```typescript
export interface UnifiedJobDetail {
  // 기본 정보
  id: string                    // 예: "job:C_375" (CareerNet) 또는 "job:G_K000007482" (Goyong24)
  sourceIds: {
    careernet?: string          // "375"
    goyong24?: string           // "K000007482"
  }
  name: string                  // "변호사"
  sources: DataSource[]         // ['CAREERNET', 'GOYONG24']
  
  // 분류
  category?: {
    code?: string               // "100050"
    name?: string               // "법률"
  }
  classifications?: {
    large?: string              // "전문가 및 관련 종사자"
    medium?: string             // "법률 전문가"
    small?: string              // "변호사 및 법무사"
  }
  
  // 상세 정보
  summary?: string              // 직업 소개
  duties?: string               // 주요 업무
  way?: string                  // 되는 방법
  salary?: string               // 평균 연봉
  prospect?: string             // 직업 전망
  satisfaction?: string         // 직무 만족도
  status?: string               // 고용 형태
  
  // 요구사항
  educationDistribution?: {     // 학력 분포
    highSchool?: string
    college?: string
    university?: string
    graduate?: string
  }
  majorDistribution?: {         // 전공 분포
    humanities?: string
    social?: string
    engineering?: string
    // ...
  }
  
  // 연관 정보
  relatedMajors?: JobRelatedEntity[]      // 관련 전공
  relatedJobs?: JobRelatedEntity[]        // 관련 직업
  relatedCertificates?: string[]          // 관련 자격증
  relatedOrganizations?: JobOrganizationInfo[]  // 관련 단체
  kecoCodes?: JobKecoCodeInfo[]           // 한국표준직업분류
}
```

#### B. SourceStatusRecord

```typescript
export interface SourceStatus {
  count?: number        // 반환된 항목 수
  total?: number        // 전체 항목 수 (페이지네이션)
  error?: string        // 에러 메시지
  skipped?: string      // 스킵 사유 ('excluded', 'missing-id', 'keyword-required' 등)
}

export interface SourceStatusRecord {
  CAREERNET?: SourceStatus
  GOYONG24?: SourceStatus
}
```

### 4.2 데이터베이스 스키마

#### A. 댓글 시스템 (0001_initial_schema.sql)

```sql
-- 위키 페이지 메타데이터
CREATE TABLE pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,                    -- "lawyer", "computer-science"
  title TEXT NOT NULL,
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major', 'guide')),
  content TEXT NOT NULL,                        -- Markdown
  summary TEXT,
  meta_data TEXT,                               -- JSON
  view_count INTEGER DEFAULT 0,
  status TEXT DEFAULT 'published',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 댓글
CREATE TABLE comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  parent_id INTEGER,                            -- 대댓글용
  nickname TEXT DEFAULT '익명',
  content TEXT NOT NULL,
  ip_hash TEXT,                                 -- SHA256(IP)
  likes INTEGER DEFAULT 0,
  flagged BOOLEAN DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);

-- 댓글 반응 (좋아요/싫어요)
CREATE TABLE comment_reactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  comment_id INTEGER NOT NULL,
  ip_hash TEXT NOT NULL,
  reaction_type TEXT NOT NULL CHECK(reaction_type IN ('like', 'dislike')),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(comment_id, ip_hash),
  FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
);

-- 댓글 신고
CREATE TABLE comment_reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  comment_id INTEGER NOT NULL,
  ip_hash TEXT NOT NULL,
  reason TEXT NOT NULL,
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'reviewed', 'dismissed')),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
);

-- IP 차단
CREATE TABLE ip_blocks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ip_hash TEXT UNIQUE NOT NULL,
  reason TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME
);
```

#### B. AI 분석 파이프라인 (0002_career_analysis_pipeline.sql)

```sql
-- AI 분석 세션
CREATE TABLE ai_sessions (
  id TEXT PRIMARY KEY,                          -- UUID
  user_id TEXT,                                 -- 익명은 NULL
  session_type TEXT NOT NULL CHECK(session_type IN ('job', 'major', 'career_path')),
  traits_snapshot TEXT,                         -- JSON (사용자 입력)
  status TEXT DEFAULT 'active',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- AI 분석 요청
CREATE TABLE ai_analysis_requests (
  id TEXT PRIMARY KEY,                          -- UUID
  session_id TEXT NOT NULL,
  analysis_type TEXT NOT NULL,
  input_data TEXT NOT NULL,                     -- JSON
  status TEXT DEFAULT 'pending',
  priority INTEGER DEFAULT 5,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (session_id) REFERENCES ai_sessions(id) ON DELETE CASCADE
);

-- AI 분석 결과
CREATE TABLE ai_analysis_results (
  id TEXT PRIMARY KEY,                          -- UUID
  request_id TEXT UNIQUE NOT NULL,
  result_data TEXT NOT NULL,                    -- JSON
  provider TEXT,                                -- 'claude', 'openai'
  model TEXT,                                   -- 'claude-3-5-sonnet-20241022'
  tokens_used INTEGER,
  latency_ms INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (request_id) REFERENCES ai_analysis_requests(id) ON DELETE CASCADE
);
```

### 4.3 캐싱 전략

#### A. KV 캐시 키 패턴

```typescript
// 목록 캐시
const key = `list:${type}:q=${keyword}&category=${cat}&page=${page}`
// 예: "list:job:q=개발자&category=100060&page=1"

// Freshness 스냅샷
const snapshotKey = `freshness:snapshot:${targetId}:${timestamp}`
// 예: "freshness:snapshot:job-tech-developer:1729756800000"

// Freshness 스케줄
const scheduleKey = `freshness:schedule:${targetId}`
// 예: "freshness:schedule:job-tech-developer"

// Freshness 인덱스
const indexKey = `freshness:index:job`
// 값: ["freshness:snapshot:job-tech-developer:1729756800000", ...]

// 성능 메트릭
const metricsKey = `perf:${timestamp}:${sessionId}`
// 예: "perf:1729756800000:abc123"
```

#### B. 캐싱 정책

| 캐시 타입 | Stale After | Expires After | 재검증 |
|----------|-------------|---------------|--------|
| 직업 목록 | 1시간 | 6시간 | Cron (30분) |
| 전공 목록 | 1시간 | 6시간 | Cron (30분) |
| Freshness | - | 7일 | - |
| 성능 메트릭 | - | 30일 | - |

---

## 5. 요구사항 목록 (Requirements)

### 5.1 기능 요구사항 (Functional Requirements)

#### FR-1: 직업 정보 조회

**설명**: 사용자가 직업 정보를 검색하고 상세 내용을 볼 수 있어야 한다.

**세부 요구사항**:
- FR-1.1: 직업 목록 페이지에서 키워드 검색 가능
- FR-1.2: 카테고리별 필터링 지원
- FR-1.3: 페이지네이션 (기본 20개/페이지)
- FR-1.4: 직업 상세 페이지는 SEO 최적화 (JSON-LD, OG 메타)
- FR-1.5: 소스별 데이터 상태 표시 (CareerNet, 고용24)
- FR-1.6: 변호사 등 특정 직업은 커스텀 템플릿

**우선순위**: ⭐⭐⭐ (최고)  
**상태**: ✅ 완료

#### FR-2: 전공 정보 조회

**설명**: 사용자가 대학 전공 정보를 검색하고 상세 내용을 볼 수 있어야 한다.

**세부 요구사항**:
- FR-2.1: 전공 목록 페이지에서 키워드 검색
- FR-2.2: 전공 상세 페이지 (커리큘럼, 진로, 대학 정보)
- FR-2.3: 관련 직업 연계 표시

**우선순위**: ⭐⭐⭐  
**상태**: ✅ 완료

#### FR-3: 캐싱 및 성능

**설명**: 목록 조회 성능을 최적화하기 위해 캐싱을 구현한다.

**세부 요구사항**:
- FR-3.1: KV 기반 stale-while-revalidate 전략
- FR-3.2: Cron 기반 자동 재검증 (30분 간격)
- FR-3.3: 수동 재검증 (`?refresh=1`)
- FR-3.4: 캐시 상태 배지 표시

**우선순위**: ⭐⭐⭐  
**상태**: ✅ 완료

#### FR-4: 댓글 시스템

**설명**: 사용자가 위키 페이지에 댓글을 작성하고 반응할 수 있다.

**세부 요구사항**:
- FR-4.1: 익명 댓글 작성 (닉네임 입력)
- FR-4.2: 대댓글 (parent_id 지원)
- FR-4.3: 좋아요/싫어요
- FR-4.4: 신고 기능
- FR-4.5: IP 해시 기반 익명성

**우선순위**: ⭐⭐  
**상태**: ⏳ 백엔드 완료, 프론트엔드 미완료

#### FR-5: 성능 모니터링

**설명**: Core Web Vitals 및 사용자 행동 메트릭을 수집한다.

**세부 요구사항**:
- FR-5.1: TTFB, FCP, LCP, CLS, FID 측정
- FR-5.2: 하이드레이션 소요 시간 측정
- FR-5.3: SERP 상호작용 로그 (정렬, 필터, 페이지 변경)
- FR-5.4: Beacon API로 KV 저장

**우선순위**: ⭐⭐  
**상태**: ✅ 수집 완료, 조회 UI 미완료

#### FR-6: AI 분석 준비

**설명**: AI 기반 진로 분석을 위한 인프라를 준비한다.

**세부 요구사항**:
- FR-6.1: 세션/요청/결과 D1 테이블
- FR-6.2: REST API 엔드포인트
- FR-6.3: 상태 추적 (pending, processing, completed, failed)

**우선순위**: ⭐  
**상태**: ⏳ 테이블만 준비, 실제 AI 호출 미구현

### 5.2 비기능 요구사항 (Non-Functional Requirements)

#### NFR-1: 성능

- **목표**: LCP < 2.5초, CLS < 0.1
- **캐싱**: 목록 조회 응답 시간 < 200ms (캐시 히트 시)
- **API 타임아웃**: 외부 API 5초

#### NFR-2: 확장성

- **Cloudflare Workers**: 무제한 스케일링
- **D1 제약**: 테이블당 10GB (무료 플랜)
- **KV 제약**: 네임스페이스당 무제한 키 (무료 플랜 100,000 read/day)

#### NFR-3: 보안

- **IP 해싱**: SHA-256 (댓글 익명성)
- **Rate Limiting**: 향후 구현 (Cloudflare 기본 보호)
- **XSS 방지**: `escapeHtml()` 사용

#### NFR-4: SEO

- **모든 상세 페이지**: JSON-LD, OG 메타, canonical URL
- **목록 페이지**: ItemList JSON-LD
- **크롤러 접근성**: robots.txt, sitemap.xml (향후)

---

## 6. 코드 레벨 구현 지침

### 6.1 라우트 분리 (Required Refactor)

**문제**: `index.tsx`가 3,779 lines로 너무 크다.

**해결 방안**:

```typescript
// 디렉토리 구조
src/
├── index.tsx (100 lines)           # 메인 진입점만
├── routes/
│   ├── pages.ts                    # 페이지 라우트 (/, /job, /major 등)
│   ├── api-jobs.ts                 # /api/jobs, /api/jobs/:id
│   ├── api-majors.ts               # /api/majors, /api/majors/:id
│   ├── api-comments.ts             # /api/comments/*
│   ├── api-analyzer.ts             # /api/analyzer/*
│   ├── api-perf.ts                 # /api/perf-metrics
│   └── api-freshness.ts            # /api/freshness/*
└── ...
```

**구현 예시**:

```typescript
// src/index.tsx (간결하게)
import { Hono } from 'hono'
import { pagesRoutes } from './routes/pages'
import { apiJobsRoutes } from './routes/api-jobs'
import { apiMajorsRoutes } from './routes/api-majors'
// ...

const app = new Hono<{ Bindings: Bindings }>()

// Middleware
app.use('*', cors())
app.use('*', renderer)
app.use('/static/*', serveStatic({ root: './public' }))

// Mount routes
app.route('/', pagesRoutes)
app.route('/api/jobs', apiJobsRoutes)
app.route('/api/majors', apiMajorsRoutes)
// ...

export default app
```

```typescript
// src/routes/pages.ts
import { Hono } from 'hono'
import type { Bindings } from '../types/bindings'

export const pagesRoutes = new Hono<{ Bindings: Bindings }>()

pagesRoutes.get('/', (c) => {
  // 홈페이지 로직
})

pagesRoutes.get('/job', async (c) => {
  // 직업 목록 로직
})

pagesRoutes.get('/job/:slug', async (c) => {
  // 직업 상세 로직
})
```

### 6.2 D1 바인딩 설정

**현재 문제**: `wrangler.jsonc`에 D1 설정이 없어 마이그레이션 불가.

**해결**:

```jsonc
// wrangler.jsonc
{
  "$schema": "node_modules/wrangler/config-schema.json",
  "name": "careerwiki-phase1",
  "compatibility_date": "2024-01-01",
  "compatibility_flags": ["nodejs_compat"],
  "pages_build_output_dir": "./dist",
  
  // D1 데이터베이스 추가
  "d1_databases": [
    {
      "binding": "DB",
      "database_name": "careerwiki-db",
      "database_id": "xxx-xxx-xxx"  // wrangler d1 create 후 받은 ID
    }
  ],
  
  // KV 네임스페이스 추가
  "kv_namespaces": [
    {
      "binding": "KV",
      "id": "xxx-xxx-xxx",  // wrangler kv:namespace create 후 받은 ID
      "preview_id": "xxx-xxx-xxx"  // 로컬 개발용
    }
  ],
  
  "vars": {
    "ENVIRONMENT": "production"
  }
}
```

**실행 순서**:

```bash
# 1. D1 데이터베이스 생성
npx wrangler d1 create careerwiki-db
# → database_id를 wrangler.jsonc에 복사

# 2. KV 네임스페이스 생성
npx wrangler kv:namespace create careerwiki_kv
npx wrangler kv:namespace create careerwiki_kv --preview
# → id와 preview_id를 wrangler.jsonc에 복사

# 3. 마이그레이션 적용
npm run db:migrate:local

# 4. 확인
npx wrangler d1 execute careerwiki-db --local --command="SELECT name FROM sqlite_master WHERE type='table';"
```

### 6.3 템플릿 공통화

**문제**: `unifiedJobDetail.ts`와 `unifiedMajorDetail.ts`에 중복 로직 많음.

**해결**:

```typescript
// src/templates/shared/tabRenderer.ts
export interface TabConfig {
  id: string
  label: string
  icon: string
  content: string
}

export function renderTabs(tabs: TabConfig[], telemetryVariant?: string): string {
  const tabButtons = tabs.map((tab, index) => `
    <button
      type="button"
      role="tab"
      aria-selected="${index === 0 ? 'true' : 'false'}"
      aria-controls="tab-panel-${tab.id}"
      id="tab-${tab.id}"
      class="tab-button"
      data-cw-telemetry-component="detail-tab"
      data-cw-telemetry-action="tab-switch"
      data-tab-id="${tab.id}"
    >
      <i class="fas ${tab.icon}"></i>
      ${escapeHtml(tab.label)}
    </button>
  `).join('')
  
  const tabPanels = tabs.map((tab, index) => `
    <div
      role="tabpanel"
      id="tab-panel-${tab.id}"
      aria-labelledby="tab-${tab.id}"
      ${index === 0 ? '' : 'hidden'}
    >
      ${tab.content}
    </div>
  `).join('')
  
  return `
    <div role="tablist" class="tab-list">
      ${tabButtons}
    </div>
    <div class="tab-panels">
      ${tabPanels}
    </div>
  `
}
```

**사용 예시**:

```typescript
// src/templates/unifiedJobDetail.ts
import { renderTabs } from './shared/tabRenderer'

const tabs: TabConfig[] = [
  { id: 'overview', label: '개요', icon: 'fa-circle-info', content: overviewContent },
  { id: 'details', label: '상세 정보', icon: 'fa-layer-group', content: detailContent }
]

const tabsHtml = renderTabs(tabs, 'job-detail-v1')
```

### 6.4 에러 처리 표준화

**모든 서비스 함수는 다음 패턴을 따른다**:

```typescript
// src/services/baseService.ts
export class ServiceError extends Error {
  constructor(
    message: string,
    public code: string,
    public statusCode: number = 500,
    public details?: any
  ) {
    super(message)
    this.name = 'ServiceError'
  }
}

export async function withErrorHandling<T>(
  operation: () => Promise<T>,
  errorContext: string
): Promise<T> {
  try {
    return await operation()
  } catch (error) {
    console.error(`[${errorContext}] 오류 발생:`, error)
    
    if (error instanceof ServiceError) {
      throw error
    }
    
    throw new ServiceError(
      `${errorContext} 실패: ${error instanceof Error ? error.message : String(error)}`,
      'UNKNOWN_ERROR',
      500,
      { originalError: error }
    )
  }
}
```

**사용 예시**:

```typescript
export async function getUnifiedJobDetail(
  id: string,
  env: any
): Promise<UnifiedJobDetail | null> {
  return withErrorHandling(async () => {
    // 로직
  }, 'getUnifiedJobDetail')
}
```

### 6.5 API 응답 표준화

**모든 API는 다음 형식을 따른다**:

```typescript
// src/types/api.ts
export interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: {
    code: string
    message: string
    details?: any
  }
  meta?: {
    timestamp: number
    requestId?: string
  }
}

export interface ListResponse<T> {
  items: T[]
  total: number
  page: number
  perPage: number
  hasMore: boolean
}
```

**사용 예시**:

```typescript
app.get('/api/jobs', async (c) => {
  try {
    const results = await searchUnifiedJobs(params, c.env)
    
    return c.json<ApiResponse<ListResponse<UnifiedJobSummary>>>({
      success: true,
      data: {
        items: results.items,
        total: results.total,
        page: params.page,
        perPage: params.perPage,
        hasMore: results.items.length === params.perPage
      },
      meta: {
        timestamp: Date.now()
      }
    })
  } catch (error) {
    return c.json<ApiResponse<never>>({
      success: false,
      error: {
        code: 'SEARCH_FAILED',
        message: error instanceof Error ? error.message : 'Unknown error'
      },
      meta: {
        timestamp: Date.now()
      }
    }, 500)
  }
})
```

---

## 7. 개선 필요 사항 (Technical Debt)

### 7.1 긴급 (High Priority)

#### TD-1: index.tsx 분리
- **문제**: 3,779 lines, 유지보수 어려움
- **해결**: 라우트별 파일 분리 (위 6.1 참조)
- **예상 시간**: 4-6시간
- **영향**: 코드 가독성 ↑, 협업 ↑

#### TD-2: D1/KV 바인딩 설정
- **문제**: 로컬 개발 시 마이그레이션 불가, KV 에러
- **해결**: wrangler.jsonc 설정 (위 6.2 참조)
- **예상 시간**: 30분
- **영향**: 로컬 개발 안정성 ↑

#### TD-3: 에러 핸들링 표준화
- **문제**: 일관성 없는 try/catch, 에러 로깅
- **해결**: ServiceError 클래스, withErrorHandling() (위 6.4 참조)
- **예상 시간**: 2-3시간
- **영향**: 디버깅 ↑, 운영 안정성 ↑

### 7.2 중간 (Medium Priority)

#### TD-4: 템플릿 중복 제거
- **문제**: 직업/전공 템플릿 유사 로직 반복
- **해결**: 공통 렌더러 추출 (위 6.3 참조)
- **예상 시간**: 3-4시간
- **영향**: 코드 재사용성 ↑

#### TD-5: API 응답 표준화
- **문제**: 각 API마다 다른 응답 형식
- **해결**: ApiResponse<T> 타입 (위 6.5 참조)
- **예상 시간**: 2시간
- **영향**: 프론트엔드 통합 ↑

#### TD-6: 테스트 추가
- **문제**: 테스트 부재
- **해결**: Vitest + Mock KV/D1
- **예상 시간**: 8-10시간
- **영향**: 회귀 방지, 리팩토링 안전성 ↑

### 7.3 낮음 (Low Priority)

#### TD-7: TypeScript strict 모드
- **문제**: `tsconfig.json`에서 strict 비활성화
- **해결**: strict: true, 점진적 타입 강화
- **예상 시간**: 6-8시간
- **영향**: 타입 안전성 ↑

#### TD-8: 성능 메트릭 조회 UI
- **문제**: 수집만 되고 조회 불가
- **해결**: `/admin/metrics` 대시보드
- **예상 시간**: 4-6시간
- **영향**: 운영 가시성 ↑

---

## 8. 배포 및 운영

### 8.1 배포 프로세스

#### A. 로컬 개발

```bash
# 1. 의존성 설치
npm install

# 2. 환경 변수 (.dev.vars)
CAREER_NET_API_KEY=your_key
GOYONG24_JOB_API_KEY=your_key
GOYONG24_MAJOR_API_KEY=your_key

# 3. D1 마이그레이션
npm run db:migrate:local

# 4. 빌드
npm run build

# 5. PM2로 시작
pm2 start ecosystem.config.cjs

# 6. 확인
curl http://localhost:3000
curl http://localhost:3000/job/lawyer
```

#### B. 프로덕션 배포

```bash
# 1. Cloudflare API 인증
setup_cloudflare_api_key  # AI 도구

# 2. D1 생성 (최초 1회)
npx wrangler d1 create careerwiki-db
# → wrangler.jsonc에 database_id 추가

# 3. D1 마이그레이션
npm run db:migrate:prod

# 4. Secrets 등록
npx wrangler pages secret put CAREER_NET_API_KEY --project-name careerwiki-phase1
npx wrangler pages secret put GOYONG24_JOB_API_KEY --project-name careerwiki-phase1
npx wrangler pages secret put GOYONG24_MAJOR_API_KEY --project-name careerwiki-phase1

# 5. 빌드 및 배포
npm run build
npx wrangler pages deploy dist --project-name careerwiki-phase1
```

### 8.2 모니터링

#### A. Cloudflare Dashboard
- Pages 배포 상태
- Workers 메트릭 (요청 수, 에러율, CPU 시간)
- D1 쿼리 수
- KV 작업 수

#### B. 로그 확인

```bash
# 로컬
pm2 logs careerwiki --nostream --lines 50

# 프로덕션
npx wrangler pages deployment tail --project-name careerwiki-phase1
```

#### C. 성능 메트릭

```bash
# KV에서 최근 메트릭 조회 (AI 도구 필요)
# 향후 /admin/metrics UI 구현 예정
```

### 8.3 운영 체크리스트

**일일 체크**:
- [ ] 프로덕션 사이트 접근 가능 확인
- [ ] 에러율 < 1% 확인 (Cloudflare Dashboard)
- [ ] API 응답 시간 < 500ms 확인

**주간 체크**:
- [ ] 캐시 히트율 확인 (목표 > 80%)
- [ ] D1 사용량 확인 (무료 플랜 제한)
- [ ] KV 작업 수 확인 (무료 플랜 제한)

**월간 체크**:
- [ ] 의존성 업데이트 (`npm outdated`)
- [ ] 보안 취약점 확인 (`npm audit`)
- [ ] 미사용 캐시 정리

---

## 9. 다음 단계 (Next Steps)

### 9.1 Phase 1 완료 기준

- [x] 직업/전공 상세 페이지 SSR
- [x] 캐싱 및 Freshness 모니터링
- [ ] index.tsx 라우트 분리
- [ ] D1/KV 바인딩 설정
- [ ] 에러 핸들링 표준화
- [ ] 댓글 프론트엔드 UI
- [ ] 테스트 추가 (최소 핵심 기능)

### 9.2 Phase 2 계획 (인증 및 권한)

- [ ] 로그인/회원가입 UI
- [ ] OAuth 통합 (Google, Kakao)
- [ ] 사용자 역할 (User, Admin, Pro)
- [ ] 마이페이지
- [ ] 관리자 대시보드

### 9.3 Phase 3 계획 (AI 실제 연동)

- [ ] Claude/GPT API 호출
- [ ] 프롬프트 템플릿
- [ ] AI 분석 UI
- [ ] 결과 저장 및 공유

---

## 10. 참고 자료

### 10.1 외부 문서

- [Hono 공식 문서](https://hono.dev/)
- [Cloudflare Workers 문서](https://developers.cloudflare.com/workers/)
- [Cloudflare D1 문서](https://developers.cloudflare.com/d1/)
- [Cloudflare KV 문서](https://developers.cloudflare.com/kv/)
- [CareerNet API 가이드](https://www.career.go.kr/cnet/front/openapi/openApiGuide.do)
- [고용24 API 가이드](https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcIntro.do)

### 10.2 내부 문서

- `README.md`: 프로젝트 개요 및 최근 업데이트
- `migrations/*.sql`: 데이터베이스 스키마
- `src/types/*.ts`: 타입 정의
- `ecosystem.config.cjs`: PM2 설정

---

## 변경 이력

| 버전 | 날짜 | 변경 내용 | 작성자 |
|-----|------|----------|--------|
| 1.0 | 2025-10-25 | 초안 작성 | AI Agent |

---

**이 문서는 살아있는 문서(Living Document)입니다.**  
프로젝트가 진행되면서 지속적으로 업데이트됩니다.
