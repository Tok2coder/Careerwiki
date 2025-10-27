# CareerWiki - Technical Specification

> **문서 버전**: 2.0  
> **최종 업데이트**: 2025-10-25  
> **작성자**: AI Development Agent  
> **목적**: 프로젝트 전체 계획 및 개발 인수인계서

---

## 📋 목차

1. [프로젝트 개요](#1-프로젝트-개요)
2. [개발 방식 및 원칙](#2-개발-방식-및-원칙)
3. [Phase별 작업 계획](#3-phase별-작업-계획)
4. [현재 상태 및 진행상황](#4-현재-상태-및-진행상황)
5. [시스템 아키텍처](#5-시스템-아키텍처)
6. [데이터 모델](#6-데이터-모델)
7. [코드 구현 지침](#7-코드-구현-지침)
8. [Technical Debt 관리](#8-technical-debt-관리)

---

## 1. 프로젝트 개요

### 1.1 핵심 목표

**AI 기반 진로 분석 플랫폼**

- 직업/전공 정보 통합 위키
- 사용자 맞춤형 진로 분석 (AI)
- 커뮤니티 기반 위키 협업

### 1.2 기술 스택

| 계층 | 기술 |
|-----|------|
| Runtime | Cloudflare Workers/Pages |
| Framework | Hono 4.9.9 |
| Language | TypeScript 5.9.3 |
| Database | Cloudflare D1 (SQLite) |
| Cache | Cloudflare KV |
| Build | Vite 6.3.5 |
| Deploy | Wrangler 4.4.0 |

---

## 2. 개발 방식 및 원칙

### 2.1 작업 프로세스

```
Tech Spec 확인
    ↓
Plan 작성 (큰 그림)
    ↓
Task 분해 (작은 단위)
    ↓
┌─────────────────────┐
│ Task 1 실행         │
│  ↓                  │
│ 완료 보고           │
│  ↓                  │
│ 정우님 승인 대기     │
│  ↓                  │
│ Commit & Push       │
└─────────────────────┘
    ↓
Task 2 실행...
```

### 2.2 코드 작성 원칙

#### ✅ 해야 할 것
1. **정확한 목적**: 모든 코드는 명확한 이유가 있어야 함
2. **최소 재사용**: 필요한 경우만 재사용
3. **중복 제거**: 같은 로직은 한 곳에만
4. **깔끔한 구조**: 파일/함수 역할 명확

#### ❌ 하지 말아야 할 것
1. **중복 코드**: 같은 로직을 여러 곳에 작성
2. **중복 페이지**: 같은 목적의 페이지 여러 개
3. **불필요한 코드 옮기기**: 의미 없는 복사/이동
4. **과도한 추상화**: 쓸데없이 복잡하게 만들기

### 2.3 템플릿 시스템 철학

**목표**: 틀 1개 수정 → 모든 페이지 자동 반영

```
샘플 페이지 제작 (테스트용)
    ↓
수정 및 개선 반복
    ↓
완성된 틀(템플릿) 확정
    ↓
API 데이터 → 틀에 주입
    ↓
모든 상세페이지 일괄 생성
```

**샘플 vs 틀**:
- **샘플**: 별도 URL로 관리, 완료 후 삭제
  - 예: `/samples/job/lawyer`, `/samples/major/computer-science`
- **틀(템플릿)**: 별도 파일로 영구 보관
  - 예: `src/templates/jobDetailTemplate.ts`

**UI 수정 시나리오**:
```
"변호사 페이지에서 X 섹션을 고치고 싶다"
    ↓
틀 파일 1개만 수정
    ↓
모든 직업 페이지에 자동 반영
```

---

## 3. Phase별 작업 계획

### Phase 1: 상세페이지 템플릿 완성 ⭐ **최우선 작업 (현재)**

**목표**: 완벽한 직업/전공 상세페이지 틀 확정

**작업 순서**:
1. ✅ 직업 상세 샘플 제작 (변호사)
   - Hero, Quick Stats, 탭 구조, 소스 비교 매트릭스
2. 🔄 직업 상세 샘플 개선 (반복)
   - UI/UX 개선
   - 데이터 표시 방식 최적화
   - 특수 케이스 처리 (변호사 전용 로직)
3. ⏳ 전공 상세 샘플 제작
   - 커리큘럼, 진로, 대학 정보
4. ⏳ 전공 상세 샘플 개선 (반복)
5. ⏳ 틀 확정 및 일반화
   - 직업 템플릿 파일 완성
   - 전공 템플릿 파일 완성
   - 샘플 코드 삭제
6. ⏳ 모든 직업/전공 페이지 생성 테스트
   - API 데이터로 대량 생성
   - QA 및 버그 수정

**완료 기준**:
- [ ] 직업 상세 템플릿 100% 완성
- [ ] 전공 상세 템플릿 100% 완성
- [ ] 샘플 페이지 모두 삭제
- [ ] API 데이터로 생성된 페이지 10개 이상 QA 완료

---

### Phase 2: 로그인 시스템

**목표**: 사용자 인증 및 세션 관리

**작업 항목**:
1. ⏳ OAuth 통합 (Google, Kakao)
2. ⏳ JWT 세션 관리
3. ⏳ 사용자 DB 테이블 (`users`, `sessions`)
4. ⏳ 로그인/회원가입 UI
5. ⏳ 권한 시스템 (User, Admin, Pro)

**완료 기준**:
- [ ] Google/Kakao 로그인 작동
- [ ] 세션 유지 및 자동 로그아웃
- [ ] 마이페이지 기본 구현

---

### Phase 3: 편집 시스템 (위키 협업)

**목표**: 사용자가 직접 위키 페이지를 편집할 수 있는 시스템

**작업 항목**:
1. ⏳ 편집 권한 관리
2. ⏳ Markdown 에디터
3. ⏳ 편집 이력 (revision history)
4. ⏳ 변경사항 리뷰 (승인/반려)
5. ⏳ 기여도 추적

**완료 기준**:
- [ ] 로그인 사용자가 페이지 편집 가능
- [ ] 편집 이력 조회 및 롤백
- [ ] 관리자 승인 플로우 작동

---

### Phase 4: HowTo 콘텐츠 작성 및 테스트

**목표**: 진로 설정 가이드 콘텐츠 제작

**작업 항목**:
1. ⏳ HowTo 템플릿 확정
2. ⏳ HowTo 콘텐츠 5-10개 작성
   - 예: "변호사가 되는 방법", "컴퓨터공학 전공 선택 가이드"
3. ⏳ HowTo ↔ 직업/전공 연결
4. ⏳ 사용자 피드백 수집

**완료 기준**:
- [ ] HowTo 최소 5개 발행
- [ ] 사용자 조회수 100+ 달성
- [ ] 평균 체류시간 2분 이상

---

### Phase 5: AI 분석 리포트 생성

**목표**: 사용자 맞춤형 진로 분석 AI 서비스

**작업 항목**:
1. ⏳ Claude/GPT API 연동
2. ⏳ 프롬프트 템플릿 작성
   - 직업 추천
   - 전공 추천
   - 커리어 패스 분석
3. ⏳ AI 분석 UI
   - 입력 폼 (성향, 관심사, 능력)
   - 결과 리포트 페이지
4. ⏳ 토큰/비용 추적
5. ⏳ 결과 저장 및 공유

**완료 기준**:
- [ ] AI 분석 요청 성공률 95% 이상
- [ ] 평균 응답 시간 30초 이하
- [ ] 사용자 만족도 4.0/5.0 이상

---

## 4. 현재 상태 및 진행상황

### 4.1 Phase 1 진행상황 (상세페이지 템플릿)

#### ✅ 완료된 작업

**직업 상세 페이지**:
- ✅ 변호사 샘플 페이지 기본 구조
  - Hero 섹션 (제목, 이미지, 공유 버튼)
  - Quick Stats (평균 연봉, 직업 전망, 직무 만족도)
  - 탭 구조 (개요, 상세 정보)
  - 소스 비교 매트릭스 (CareerNet vs 고용24)
  - JSON-LD, OG 메타, canonical URL

- ✅ 변호사 전용 커스터마이징
  - `isLawyerProfile()` 조건 분기
  - 불필요한 블록 제거:
    - ❌ 고용 형태 (Quick Stats에서 제외)
    - ❌ 직업 분류 체계 카드
    - ❌ 데이터 출처 패널
  - 소스 비교 매트릭스 강조

- ✅ API 통합
  - CareerNet API 클라이언트 (611 lines)
  - 고용24 API 클라이언트 (824 lines)
  - 데이터 병합 로직 (`mergeJobProfiles`)
  - 소스 상태 추적 (`SourceStatusRecord`)

**전공 상세 페이지**:
- ✅ 기본 구조 구축
  - 탭 구조 (개요, 커리큘럼, 진로, 대학 정보)
  - 관련 직업 연결

**기타**:
- ✅ 목록 페이지 (직업, 전공)
- ✅ 캐싱 시스템 (KV, Freshness)
- ✅ 성능 메트릭 수집
- ✅ 댓글 시스템 (백엔드)

#### 🔄 진행 중인 작업

**직업 상세 템플릿 개선**:
- 🔄 변호사 페이지 UI/UX 최종 검토
- 🔄 다른 직업 샘플 추가 필요 판단
  - 개발자? 간호사? 선생님?
- 🔄 특수 케이스 처리 방식 확정
  - 변호사처럼 특별한 직업이 또 있는가?

#### ⏳ 대기 중인 작업

**전공 상세 템플릿**:
- ⏳ 전공 샘플 페이지 제작 (컴퓨터공학 등)
- ⏳ 전공 샘플 개선 반복
- ⏳ 전공 특수 케이스 처리

**템플릿 확정**:
- ⏳ 직업 템플릿 파일 분리 및 일반화
- ⏳ 전공 템플릿 파일 분리 및 일반화
- ⏳ 샘플 코드 삭제
- ⏳ 대량 생성 테스트

### 4.2 프로젝트 구조

```
webapp/
├── src/
│   ├── index.tsx (3,779 lines)        # 메인 + 모든 라우트 (분리 필요)
│   ├── api/                           # 외부 API 클라이언트
│   │   ├── careernetAPI.ts (611)
│   │   └── goyong24API.ts (824)
│   ├── services/                      # 비즈니스 로직
│   │   ├── profileDataService.ts (674)  # 데이터 통합
│   │   ├── profileMerge.ts (277)        # 소스 병합
│   │   ├── cacheService.ts (217)        # KV 캐싱
│   │   ├── freshnessService.ts (511)    # 재검증
│   │   ├── commentService.ts (688)      # 댓글 CRUD
│   │   ├── perfMetricsService.ts (647)
│   │   ├── aiAnalysisService.ts (289)
│   │   └── serpInteractionService.ts (136)
│   ├── templates/                     # SSR 템플릿 (핵심!)
│   │   ├── unifiedJobDetail.ts (1,466)  # 직업 상세 (개선 중)
│   │   ├── unifiedMajorDetail.ts (386)  # 전공 상세
│   │   ├── howtoDetail.ts (629)
│   │   └── detailTemplateUtils.ts (1,056)  # 공통 헬퍼
│   ├── types/                         # TypeScript 타입
│   │   ├── unifiedProfiles.ts
│   │   ├── aiAnalysis.ts
│   │   └── howto.ts
│   ├── config/
│   │   ├── cachePolicy.ts
│   │   └── freshnessConfig.ts
│   ├── data/
│   │   └── sampleRegistry.ts          # 샘플 데이터 (임시)
│   └── utils/
│       └── slug.ts
├── public/static/
│   ├── api-client.js (117KB)          # 클라이언트 하이드레이션
│   ├── perf-metrics.js (13KB)
│   └── style.css
├── migrations/
│   ├── 0001_initial_schema.sql
│   ├── 0002_career_analysis_pipeline.sql
│   └── 0003_comment_policy.sql
├── wrangler.jsonc                     # Cloudflare 설정 (D1/KV 추가 필요)
├── package.json
├── TECH_SPEC.md                       # 이 문서
└── README.md
```

### 4.3 알려진 문제 (Known Issues)

#### 🔴 긴급 (Blocking)

없음 (현재 작업 진행 가능)

#### 🟡 중요 (Important)

1. **index.tsx 비대화** (3,779 lines)
   - 모든 라우트가 한 파일에
   - 유지보수 어려움
   - 해결: Phase 1 완료 후 분리

2. **D1/KV 바인딩 누락**
   - wrangler.jsonc에 설정 없음
   - 로컬 마이그레이션 불가
   - 해결: Phase 1 완료 후 설정

3. **템플릿 중복 로직**
   - 직업/전공 템플릿에 유사 코드
   - 해결: Phase 1에서 공통화 작업 포함

#### 🟢 낮음 (Nice to Have)

1. **테스트 부재**
2. **TypeScript strict 모드 비활성화**
3. **성능 메트릭 조회 UI 없음**

---

## 5. 시스템 아키텍처

### 5.1 전체 아키텍처

```
┌─────────────────────────────────────────────────────────────┐
│                        사용자 브라우저                          │
│  - HTML/CSS/JS 렌더링                                        │
│  - api-client.js (하이드레이션)                               │
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
│  │  - /job/:slug (직업 상세) ← Phase 1 핵심             │  │
│  │  - /major/:slug (전공 상세) ← Phase 1 핵심           │  │
│  │  - /job, /major (목록)                                │  │
│  │  - /api/* (REST API)                                  │  │
│  └────┬──────────────────────────────────────────────────┘  │
│       │                                                      │
│  ┌────▼────────────────────────────────────────────────┐   │
│  │              Services Layer                          │   │
│  │  - profileDataService (데이터 통합)                  │   │
│  │  - profileMerge (소스 병합)                         │   │
│  │  - cacheService (KV 캐싱)                           │   │
│  └────┬───────────────────┬───────────────────────────┘   │
│       │                   │                               │
│  ┌────▼────────┐    ┌────▼────────┐                      │
│  │ API Clients │    │  Templates  │ ← Phase 1 핵심!      │
│  │ - CareerNet │    │ - Job Detail│                      │
│  │ - Goyong24  │    │ - Major Det.│                      │
│  └─────────────┘    └─────────────┘                      │
└───────┬───────────────────┬─────────────────────────────┘
        │                   │
        ▼                   ▼
┌───────────────┐   ┌──────────────────┐
│ External APIs │   │ Cloudflare Data  │
│ - CareerNet   │   │ - D1 (SQLite)    │
│ - Goyong24    │   │ - KV (Cache)     │
└───────────────┘   └──────────────────┘
```

### 5.2 상세페이지 생성 플로우 (Phase 1 핵심)

```
사용자 요청: GET /job/lawyer
    ↓
index.tsx 라우트 핸들러
    ↓
resolveDetailIdFromSlug('lawyer')
    → { id: 'job:G_K000007482', source: 'GOYONG24' }
    ↓
getUnifiedJobDetail(id, env)
    ↓
    ├─ fetchCareernetJob(375)
    │   → CareerNet API 호출
    │   → parseCareernetJob()
    │   → UnifiedJobDetail (partial)
    │
    └─ fetchGoyong24JobDetail('K000007482')
        → Goyong24 API 호출
        → parseGoyong24Job()
        → UnifiedJobDetail (partial)
    ↓
mergeJobProfiles([careernet, goyong24])
    → 두 소스 데이터 병합
    → UnifiedJobDetail (merged)
    ↓
applyJobDetailOverrides('lawyer')
    → 특수 케이스 처리 (변호사 등)
    ↓
renderUnifiedJobDetail(profile, partials, sources)
    ↓
    ├─ renderHero()           # Hero 섹션
    ├─ renderQuickStats()     # Quick Stats (조건부)
    ├─ renderTabs()           # 탭 구조
    ├─ renderLawyerFieldMatrix()  # 소스 비교 (변호사 전용)
    └─ renderSourcesCollapsible()  # 데이터 출처 (조건부)
    ↓
HTML Response (SSR)
```

---

## 6. 데이터 모델

### 6.1 핵심 타입 정의

#### UnifiedJobDetail

```typescript
export interface UnifiedJobDetail {
  // 기본 정보
  id: string                    // "job:C_375" 또는 "job:G_K000007482"
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
  educationDistribution?: EducationDistribution
  majorDistribution?: MajorDistribution
  
  // 연관 정보
  relatedMajors?: JobRelatedEntity[]
  relatedJobs?: JobRelatedEntity[]
  relatedCertificates?: string[]
  relatedOrganizations?: JobOrganizationInfo[]
  kecoCodes?: JobKecoCodeInfo[]
}
```

#### SourceStatusRecord

```typescript
export interface SourceStatus {
  count?: number        // 반환된 항목 수
  total?: number        // 전체 항목 수
  error?: string        // 에러 메시지
  skipped?: string      // 스킵 사유
}

export interface SourceStatusRecord {
  CAREERNET?: SourceStatus
  GOYONG24?: SourceStatus
}
```

### 6.2 데이터베이스 스키마

#### 댓글 시스템 (Phase 2-3에서 UI 구현)

```sql
CREATE TABLE pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major', 'guide')),
  content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  parent_id INTEGER,
  nickname TEXT DEFAULT '익명',
  content TEXT NOT NULL,
  ip_hash TEXT,
  likes INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES pages(id)
);
```

---

## 7. 코드 구현 지침

### 7.1 Phase 1: 템플릿 시스템 구현 지침

#### 7.1.1 샘플 페이지 관리

**목표**: 샘플 페이지로 템플릿을 반복 개선

**구현 방식 Option A: 별도 라우트**

```typescript
// src/index.tsx에 샘플 라우트 추가
app.get('/samples/job/:sampleId', (c) => {
  const sampleId = c.req.param('sampleId')
  const sample = getSampleJobDetail(sampleId)
  
  if (!sample) {
    return c.notFound()
  }
  
  // 실제 템플릿과 동일한 렌더링
  const html = renderUnifiedJobDetail(
    sample.profile,
    sample.partials,
    sample.sources
  )
  
  return c.html(html)
})

// 접근: /samples/job/lawyer
```

**구현 방식 Option B: 쿼리 파라미터**

```typescript
app.get('/job/:slug', async (c) => {
  const slug = c.req.param('slug')
  const isSample = c.req.query('sample') === 'true'
  
  let profile, partials, sources
  
  if (isSample) {
    // 샘플 데이터 사용
    const sample = getSampleJobDetail(slug)
    profile = sample.profile
    partials = sample.partials
    sources = sample.sources
  } else {
    // 실제 API 호출
    const result = await getUnifiedJobDetail(slug, c.env)
    profile = result.profile
    partials = result.partials
    sources = result.sources
  }
  
  const html = renderUnifiedJobDetail(profile, partials, sources)
  return c.html(html)
})

// 접근: /job/lawyer?sample=true
```

**권장**: Option A (별도 라우트) - 명확한 구분

#### 7.1.2 템플릿 파일 구조

**현재 (Phase 1 진행 중)**:
```
src/templates/
├── unifiedJobDetail.ts       # 직업 상세 템플릿 (개선 중)
├── unifiedMajorDetail.ts     # 전공 상세 템플릿
├── howtoDetail.ts
└── detailTemplateUtils.ts    # 공통 헬퍼
```

**Phase 1 완료 후 (목표)**:
```
src/templates/
├── job/
│   ├── jobDetailTemplate.ts       # 최종 확정된 틀
│   ├── jobDetailRenderer.ts       # 렌더링 로직
│   └── jobDetailHelpers.ts        # 헬퍼 함수
├── major/
│   ├── majorDetailTemplate.ts
│   ├── majorDetailRenderer.ts
│   └── majorDetailHelpers.ts
├── howto/
│   └── howtoTemplate.ts
└── shared/
    ├── tabRenderer.ts             # 탭 공통 렌더러
    ├── heroRenderer.ts            # Hero 공통 렌더러
    └── metaHelpers.ts             # SEO 메타 헬퍼
```

#### 7.1.3 템플릿 렌더링 인터페이스

**표준 인터페이스**:

```typescript
// src/templates/job/jobDetailTemplate.ts
export interface JobDetailTemplateParams {
  profile: UnifiedJobDetail
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>
  sources?: SourceStatusRecord
  options?: {
    showQuickStats?: boolean      // 기본 true
    showClassifications?: boolean // 기본 true
    showSourcesPanel?: boolean    // 기본 true
    customSections?: string[]     // 커스텀 섹션 ID
  }
}

export function renderJobDetail(params: JobDetailTemplateParams): string {
  const {
    profile,
    partials,
    sources,
    options = {}
  } = params
  
  // 특수 케이스 감지
  const isLawyer = isLawyerProfile(profile)
  
  // 옵션 기본값 설정
  const finalOptions = {
    showQuickStats: !isLawyer, // 변호사는 Quick Stats 숨김
    showClassifications: !isLawyer,
    showSourcesPanel: !isLawyer,
    ...options
  }
  
  // 렌더링
  return buildJobDetailHTML(profile, partials, sources, finalOptions)
}
```

#### 7.1.4 특수 케이스 처리

**원칙**: 조건 분기로 처리, 별도 템플릿 파일 만들지 않음

```typescript
// src/templates/job/jobDetailHelpers.ts

export function isLawyerProfile(profile: UnifiedJobDetail): boolean {
  const lawyerIds = ['lawyer', '변호사', 'job:c_375', 'job:g_k000007482']
  return lawyerIds.some(id => 
    profile.id.toLowerCase().includes(id) ||
    profile.name.toLowerCase().includes(id)
  )
}

export function getTemplateOptions(profile: UnifiedJobDetail) {
  if (isLawyerProfile(profile)) {
    return {
      showQuickStats: false,
      showClassifications: false,
      showSourcesPanel: false,
      customSections: ['lawyerFieldMatrix'] // 변호사 전용 섹션
    }
  }
  
  // 다른 특수 케이스 추가 가능
  // if (isDoctorProfile(profile)) { ... }
  
  return {
    showQuickStats: true,
    showClassifications: true,
    showSourcesPanel: true
  }
}
```

### 7.2 코드 중복 제거 가이드

#### 7.2.1 공통 렌더러 추출

**문제**: 직업/전공 템플릿에 탭 렌더링 로직 중복

**해결**:

```typescript
// src/templates/shared/tabRenderer.ts
export interface TabConfig {
  id: string
  label: string
  icon: string
  content: string
}

export function renderTabs(
  tabs: TabConfig[],
  telemetryVariant?: string
): string {
  const tabButtons = tabs.map((tab, index) => `
    <button
      type="button"
      role="tab"
      aria-selected="${index === 0 ? 'true' : 'false'}"
      aria-controls="tab-panel-${tab.id}"
      id="tab-${tab.id}"
      class="tab-button ${index === 0 ? 'active' : ''}"
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
    <div class="tabs-container" data-telemetry-variant="${telemetryVariant || ''}">
      <div role="tablist" class="tab-list">
        ${tabButtons}
      </div>
      <div class="tab-panels">
        ${tabPanels}
      </div>
    </div>
  `
}
```

**사용 예시**:

```typescript
// src/templates/job/jobDetailRenderer.ts
import { renderTabs, TabConfig } from '../shared/tabRenderer'

const tabs: TabConfig[] = [
  { 
    id: 'overview', 
    label: '개요', 
    icon: 'fa-circle-info', 
    content: renderOverviewSection(profile) 
  },
  { 
    id: 'details', 
    label: '상세 정보', 
    icon: 'fa-layer-group', 
    content: renderDetailsSection(profile) 
  }
]

const tabsHtml = renderTabs(tabs, 'job-detail-v1')
```

#### 7.2.2 중복 코드 식별 체크리스트

작업 시작 전 확인:

- [ ] 이 로직이 다른 파일에도 있는가?
- [ ] 비슷한 함수가 이미 있는가?
- [ ] 공통 헬퍼로 추출 가능한가?
- [ ] 템플릿 간 공유 가능한가?

### 7.3 라우트 분리 (Phase 1 완료 후)

**현재 문제**: index.tsx가 3,779 lines

**해결 계획** (Phase 1 완료 후 진행):

```typescript
// src/index.tsx (목표: 100 lines 이하)
import { Hono } from 'hono'
import { pagesRoutes } from './routes/pages'
import { apiJobsRoutes } from './routes/api/jobs'
import { apiMajorsRoutes } from './routes/api/majors'
// ...

const app = new Hono<{ Bindings: Bindings }>()

app.use('*', cors())
app.use('*', renderer)
app.use('/static/*', serveStatic({ root: './public' }))

app.route('/', pagesRoutes)
app.route('/api/jobs', apiJobsRoutes)
app.route('/api/majors', apiMajorsRoutes)
// ...

export default app
```

**우선순위**: Phase 1 완료 후 (지금은 하지 않음)

### 7.4 에러 처리 표준화

**모든 서비스 함수는 일관된 에러 처리**:

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
  context: string
): Promise<T> {
  try {
    return await operation()
  } catch (error) {
    console.error(`[${context}] 오류:`, error)
    
    if (error instanceof ServiceError) {
      throw error
    }
    
    throw new ServiceError(
      `${context} 실패: ${error instanceof Error ? error.message : String(error)}`,
      'UNKNOWN_ERROR',
      500,
      { originalError: error }
    )
  }
}
```

---

## 8. Technical Debt 관리

### 8.1 긴급 (High Priority) - Phase 1 완료 후 처리

#### TD-1: index.tsx 라우트 분리
- **문제**: 3,779 lines, 유지보수 어려움
- **해결**: 라우트별 파일 분리
- **예상 시간**: 4-6시간
- **우선순위**: Phase 1 완료 후

#### TD-2: D1/KV 바인딩 설정
- **문제**: wrangler.jsonc 설정 누락
- **해결**: D1/KV 생성 및 바인딩
- **예상 시간**: 30분
- **우선순위**: Phase 1 완료 후

#### TD-3: 에러 처리 표준화
- **문제**: 일관성 없는 에러 처리
- **해결**: ServiceError 클래스 적용
- **예상 시간**: 2-3시간
- **우선순위**: Phase 1 완료 후

### 8.2 중간 (Medium Priority) - Phase 2-3에서 처리

#### TD-4: 템플릿 중복 제거
- **문제**: 직업/전공 템플릿 유사 로직
- **해결**: 공통 렌더러 추출
- **예상 시간**: 3-4시간
- **우선순위**: Phase 1에 일부 포함될 수 있음

#### TD-5: 테스트 추가
- **문제**: 테스트 부재
- **해결**: Vitest + Mock KV/D1
- **예상 시간**: 8-10시간
- **우선순위**: Phase 3

### 8.3 낮음 (Low Priority) - 추후

#### TD-6: TypeScript strict 모드
- **예상 시간**: 6-8시간

#### TD-7: 성능 메트릭 조회 UI
- **예상 시간**: 4-6시간

---

## 9. 작업 가이드

### 9.1 Task 단위 작업 가이드

**원칙**:
1. Task는 1-2시간 내 완료 가능한 크기
2. Task 완료 시마다 보고
3. 승인 받으면 Commit & Push
4. 다음 Task 시작

**Task 예시 (Phase 1)**:
- Task 1-1: 변호사 샘플 페이지 Hero 섹션 개선
- Task 1-2: 변호사 샘플 페이지 Quick Stats 제거 확인
- Task 1-3: 소스 비교 매트릭스 레이아웃 조정
- Task 1-4: 개발자 샘플 페이지 생성 (필요 시)
- Task 1-5: 전공 샘플 페이지 (컴퓨터공학) 생성
- ...

### 9.2 Commit 메시지 가이드

**형식**:
```
<type>: <subject>

<body>
```

**타입**:
- `feat`: 새 기능 (샘플 페이지 추가 등)
- `fix`: 버그 수정
- `refactor`: 리팩토링 (템플릿 공통화 등)
- `docs`: 문서 수정 (Tech Spec 등)
- `style`: UI/스타일 변경
- `test`: 테스트 추가

**예시**:
```
feat: Add lawyer sample page Hero section

- Implement Hero section with title, description, share button
- Add lawyer-specific styling
- Remove unnecessary metadata chips
```

---

## 10. 참고 자료

### 10.1 외부 문서
- [Hono 공식 문서](https://hono.dev/)
- [Cloudflare Workers 문서](https://developers.cloudflare.com/workers/)
- [CareerNet API 가이드](https://www.career.go.kr/cnet/front/openapi/openApiGuide.do)

### 10.2 내부 문서
- `README.md`: 프로젝트 개요
- `migrations/*.sql`: DB 스키마
- `src/types/*.ts`: 타입 정의

---

## 변경 이력

| 버전 | 날짜 | 변경 내용 | 작성자 |
|-----|------|----------|--------|
| 1.0 | 2025-10-25 | 초안 작성 | AI Agent |
| 2.0 | 2025-10-25 | 전면 개정 - Phase별 작업 계획 명확화, 템플릿 시스템 집중, 개발 방식 구체화 | AI Agent |

---

**이 문서는 살아있는 문서(Living Document)입니다.**  
Phase 진행에 따라 지속적으로 업데이트됩니다.

**다음 업데이트 예정**: Phase 1 완료 시 (템플릿 확정 후)
