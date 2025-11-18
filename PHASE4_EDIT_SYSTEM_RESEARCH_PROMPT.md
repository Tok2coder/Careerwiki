# Phase 4 편집 시스템 구축 리서치 프롬프트

**생성일**: 2025-01-XX  
**최종 수정일**: 2025-01-XX  
**목적**: 직관적이고, 깔끔하고, 오류없고, 빠르게 업데이트되는 편집 시스템 구축을 위한 종합 리서치

**⚠️ 중요 변경사항**:
- ✅ 익명 사용자도 모든 편집 가능 (비밀번호 기반 권한 관리)
- ✅ API 데이터(커리어넷/고용24)도 모든 사용자가 편집 가능
- ✅ 원본 데이터 보존을 위한 버전 관리 필수

---

## 👤 AI Persona 설정

이 리서치를 수행하는 AI는 다음 전문가 페르소나를 가정합니다:

### 페르소나 1: 위키피디아 전 Senior 엔지니어 (주 페르소나)
- **경력**: 위키피디아에서 15년간 MediaWiki 편집 시스템 개발 및 운영
- **전문 분야**: 
  - 대규모 협업 편집 시스템 설계
  - 편집 충돌 해결 알고리즘
  - 버전 관리 및 이력 추적 시스템
  - 사용자 권한 및 보안 관리
- **특징**: 
  - 수백만 명의 동시 편집자를 다룬 경험
  - 편집 품질 관리 및 반달리즘 방지 노하우
  - 오픈소스 커뮤니티 운영 경험

### 페르소나 2: 30년차 편집 시스템 전문 개발자
- **경력**: 
  - Google Docs, Notion, Confluence 등 협업 편집 도구 개발
  - 실시간 동기화 및 CRDT 알고리즘 전문가
- **전문 분야**:
  - 실시간 협업 편집 기술 (Operational Transform, CRDT)
  - 사용자 경험 최적화
  - 성능 최적화 및 확장성 설계
- **특징**:
  - 수천만 동시 사용자를 지원하는 시스템 설계 경험
  - 모바일/데스크톱 크로스 플랫폼 편집 경험

### 페르소나 3: 한국 커뮤니티 플랫폼 전문가
- **경력**: 
  - 나무위키, 디시인사이드, 클리앙 등 한국 커뮤니티 플랫폼 개발
  - 한국 사용자 특성 및 문화 이해
- **전문 분야**:
  - 한국어 텍스트 처리 및 검색 최적화
  - 한국 사용자 UX 패턴 이해
  - 반달리즘 및 악성 편집 대응
- **특징**:
  - 한국 커뮤니티의 특수성을 이해한 설계
  - 익명/실명 혼합 환경 운영 경험

**AI는 이 세 페르소나의 관점을 종합하여 최적의 편집 시스템을 설계해야 합니다.**

---

## 📋 프로젝트 개요

### 기술 스택
- **Backend**: Hono framework (TypeScript)
- **Frontend**: Hono JSX SSR + Tailwind CSS (CDN)
- **Deployment**: Cloudflare Pages + Workers
- **Database**: Cloudflare D1 (SQLite)
- **Build**: Vite + esbuild
- **Authentication**: JWT (Google OAuth)
- **Caching**: ISR (Incremental Static Regeneration)

### 현재 아키텍처 특징
- **ISR 캐시 시스템**: `wiki_pages` 테이블에 렌더링된 HTML 저장
- **템플릿 버전 관리**: `src/constants/template-versions.ts`에서 버전 관리
- **3계층 데이터 구조**: API 데이터 → 사용자 기여 → 운영진 데이터
- **SSR 기반**: 모든 페이지는 서버 사이드 렌더링

---

## 🗄️ 데이터베이스 구조 상세

### 1. `jobs` 테이블 - 직업 데이터

```sql
CREATE TABLE jobs (
    id TEXT PRIMARY KEY,                    -- 예: "354", "G_K000007482"
    careernet_id TEXT,                      -- CareerNet 직업 ID
    goyong24_id TEXT,                       -- Goyong24 직업 ID
    name TEXT NOT NULL,                     -- 직업명
    
    -- API 데이터 (자동 업데이트, 2주 주기)
    api_data_json TEXT,                     -- 통합 JSON 데이터
    api_data_hash TEXT,                     -- SHA-256 해시
    api_last_fetched_at INTEGER,
    api_last_updated_at INTEGER,
    
    -- 사용자 기여 데이터 (수동 관리)
    user_contributed_json TEXT,             -- 사용자가 추가한 정보 (JSON)
    user_last_updated_at INTEGER,
    
    -- 운영진 데이터 (최우선)
    admin_data_json TEXT,                   -- 운영진이 추가한 정보 (JSON)
    admin_last_updated_at INTEGER,
    
    created_at INTEGER NOT NULL,
    is_active INTEGER DEFAULT 1
);
```

**데이터 우선순위** (변경됨):
```
운영진 데이터 (admin_data_json) 
  > 사용자 기여 데이터 (user_contributed_json) 
  > API 데이터 (api_data_json)
  
⚠️ 주의: API 데이터도 이제 편집 가능하지만, 
   원본 데이터는 별도로 보존되어야 함 (되돌리기용)
```

**api_data_json 구조**:
```json
{
  "careernet": { /* CareerNet 원본 API 응답 */ },
  "goyong24": { /* Goyong24 원본 API 응답 */ },
  "merged": { /* UnifiedJobDetail 통합 객체 */ },
  "sources": ["CAREERNET", "GOYONG24"]
}
```

**현재 상태**: 
- 총 980개 직업 레코드
- `user_contributed_json`과 `admin_data_json`은 JSON 문자열로 저장되지만 구조가 명확하지 않음

---

### 2. `majors` 테이블 - 전공 데이터

```sql
CREATE TABLE majors (
    id TEXT PRIMARY KEY,                    -- 예: "123", "G_12345_컴퓨터공학과"
    careernet_id TEXT,
    goyong24_id TEXT,
    name TEXT NOT NULL,                     -- 학과명
    
    -- API 데이터 (자동 업데이트, 2주 주기)
    api_data_json TEXT,                     -- 통합 JSON 데이터
    api_data_hash TEXT,
    api_last_fetched_at INTEGER,
    api_last_updated_at INTEGER,
    
    -- 사용자 기여 데이터 (수동 관리)
    user_contributed_json TEXT,             -- 사용자가 추가한 정보 (JSON)
    user_last_updated_at INTEGER,
    
    -- 운영진 데이터 (최우선)
    admin_data_json TEXT,                   -- 운영진이 추가한 정보 (JSON)
    admin_last_updated_at INTEGER,
    
    created_at INTEGER NOT NULL,
    is_active INTEGER DEFAULT 1
);
```

**현재 상태**: 
- 총 1,427개 전공 레코드
- 구조는 `jobs` 테이블과 동일

---

### 3. `pages` 테이블 - HowTo 가이드

```sql
CREATE TABLE pages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major', 'guide')),
    content TEXT NOT NULL,                  -- Markdown content
    summary TEXT,
    meta_data TEXT,                         -- JSON string
    view_count INTEGER DEFAULT 0,
    status TEXT DEFAULT 'published' CHECK(status IN ('published', 'draft', 'deleted')),
    author_id INTEGER,                      -- 작성자 ID (users.id 참조)
    source TEXT CHECK(source IN ('careernet', 'goyong24', 'admin', 'user')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

**HowTo 데이터 구조** (`HowtoGuideDetail` 타입):
```typescript
interface HowtoGuideDetail {
  slug: string
  title: string
  summary: string
  heroIcon?: string
  tags: string[]
  updatedAt: string
  estimatedDuration?: string
  difficulty?: string
  audience?: string
  prerequisites?: string[]
  keyMetrics?: Array<{ label: string; value: string; hint?: string }>
  steps: Array<{
    id: string
    title: string
    description: string
    keyActions?: string[]
    expectedOutcome?: string
  }>
  checkpoints?: Array<{ title: string; description: string }>
  resources?: Array<{ label: string; url: string; description?: string }>
  nextActions?: Array<{ label: string; description: string; href?: string; type?: 'ai' | 'job' | 'major' | 'external' }>
  telemetryId: string
  // ... 기타 필드
}
```

**현재 상태**: 
- HowTo는 `pages` 테이블에 `page_type='guide'`로 저장
- `content` 필드에 Markdown 형식으로 저장 (추정)
- `author_id`로 작성자 추적 가능

---

### 4. `comments` 테이블 - 댓글 시스템

```sql
CREATE TABLE comments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    page_id INTEGER NOT NULL,               -- pages 테이블 참조
    parent_id INTEGER,                      -- 대댓글용
    author_id TEXT,                         -- 작성자 ID (users.id)
    nickname TEXT DEFAULT '익명',
    content TEXT NOT NULL,
    ip_hash TEXT,
    is_anonymous INTEGER DEFAULT 0,
    display_ip TEXT,
    status TEXT DEFAULT 'visible' CHECK(status IN ('visible', 'blinded', 'deleted')),
    like_count INTEGER DEFAULT 0,
    dislike_count INTEGER DEFAULT 0,
    report_count INTEGER DEFAULT 0,
    password_hash TEXT,                     -- 익명 댓글 비밀번호 해시
    anonymous_number INTEGER,               -- 익명 번호 (익명 1, 익명 2, ...)
    is_edited INTEGER DEFAULT 0,
    edited_at DATETIME,
    mentions TEXT,                          -- JSON array
    depth INTEGER DEFAULT 0,                -- 답글 깊이
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE
);
```

**현재 상태**: 
- 익명/로그인 유저 모두 댓글 작성 가능
- 로그인 유저는 본인 댓글 편집 가능 (구현됨)
- 익명 유저는 비밀번호로 편집 가능 (구현됨)

---

### 5. `users` 테이블 - 사용자 인증

```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    google_id TEXT UNIQUE NOT NULL,
    email TEXT NOT NULL,
    name TEXT,
    picture_url TEXT,
    role TEXT DEFAULT 'user' CHECK(role IN ('user', 'expert', 'admin')),
    
    edit_count INTEGER DEFAULT 0,
    comment_count INTEGER DEFAULT 0,
    
    is_banned INTEGER DEFAULT 0,
    ban_reason TEXT,
    banned_until INTEGER,
    
    last_login_at INTEGER,
    created_at INTEGER DEFAULT (strftime('%s','now')),
    updated_at INTEGER DEFAULT (strftime('%s','now'))
);
```

**역할 계층**:
- `user`: 일반 로그인 유저
- `expert`: 전문가 유저
- `admin`: 관리자

---

### 6. `wiki_pages` 테이블 - ISR 캐시 레이어

```sql
CREATE TABLE wiki_pages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slug TEXT NOT NULL,
    page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major', 'guide')),
    content TEXT NOT NULL,                  -- 완성된 HTML 문서
    cache_version INTEGER NOT NULL,         -- 템플릿 버전 번호
    title TEXT NOT NULL,
    description TEXT,
    og_image_url TEXT,
    created_at INTEGER NOT NULL DEFAULT (unixepoch()),
    updated_at INTEGER NOT NULL DEFAULT (unixepoch()),
    UNIQUE(slug, page_type)
);
```

**캐시 동작 방식**:
1. 사용자 요청 → `wiki_pages` 조회
2. `cache_version`이 현재 템플릿 버전과 일치 → 캐시 히트 (50ms)
3. 버전 불일치 또는 캐시 없음 → 데이터 조회 → 렌더링 → 캐시 저장

---

### 7. `page_revisions` 테이블 - 편집 이력

```sql
CREATE TABLE page_revisions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    page_id INTEGER NOT NULL,
    user_id INTEGER,                        -- 편집자 ID
    content TEXT NOT NULL,
    editor_ip TEXT,
    change_summary TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);
```

**현재 상태**: 
- 편집 이력 추적 가능
- `user_id`로 편집자 추적 가능

---

## 🎨 페이지 렌더링 구조

### 직업 상세 페이지 (`/job/:slug`)

**템플릿 파일**: `src/templates/unifiedJobDetail.ts`  
**렌더링 함수**: `renderUnifiedJobDetail()`  
**데이터 타입**: `UnifiedJobDetail`

**주요 섹션**:
- 기본 정보 (이름, 카테고리, 분류)
- 직업 소개 (`summary`)
- 주요 업무 (`duties`)
- 되는 방법 (`way`)
- 평균 연봉 (`salary`)
- 직업 전망 (`prospect`)
- 직무 만족도 (`satisfaction`)
- 고용 형태 (`status`)
- 요구사항 (학력 분포, 전공 분포)
- 연관 정보 (관련 전공, 관련 직업, 자격증, 기관, KECO 코드)

**데이터 병합 로직**:
```typescript
// src/services/jobStorage.ts
const apiData = JSON.parse(result.api_data_json)
const userData = result.user_contributed_json ? JSON.parse(result.user_contributed_json) : {}
const adminData = result.admin_data_json ? JSON.parse(result.admin_data_json) : {}

// 우선순위: admin > user > api
// ⚠️ 변경: API 데이터도 편집 가능하므로, 원본 데이터는 별도 보존 필요
```

**현재 상태**: 
- API 데이터는 정상 렌더링됨
- `user_contributed_json`과 `admin_data_json` 병합 로직은 있지만 구조가 명확하지 않음
- **변경 필요**: API 데이터 편집 시 원본 데이터 보존 메커니즘 추가 필요

---

### 전공 상세 페이지 (`/major/:slug`)

**템플릿 파일**: `src/templates/unifiedMajorDetail.ts`  
**렌더링 함수**: `renderUnifiedMajorDetail()`  
**데이터 타입**: `UnifiedMajorDetail`

**주요 섹션**:
- 기본 정보 (이름, 카테고리)
- 전공 소개 (`summary`)
- 적성 (`aptitude`)
- 관련 전공 (`relatedMajors`)
- 주요 교과목 (`mainSubjects`)
- 자격증 (`licenses`)
- 개설 대학 (`universities`)
- 채용 현황 (`recruitmentStatus`)
- 관련 직업 (`relatedJobs`)
- 배우는 내용 (`whatStudy`)
- 준비 방법 (`howPrepare`)
- 취업 전망 (`jobProspect`)
- 졸업 후 연봉 (`salaryAfterGraduation`)
- 취업률 (`employmentRate`)

**데이터 병합 로직**: `jobs`와 동일

---

### HowTo 가이드 페이지 (`/howto/:slug`)

**템플릿 파일**: `src/templates/howtoDetail.ts`  
**렌더링 함수**: `renderHowtoGuideDetail()`  
**데이터 타입**: `HowtoGuideDetail`

**주요 섹션**:
- 제목, 요약, 태그
- 필수 준비 사항 (`prerequisites`)
- 체크포인트 (`checkpoints`)
- 단계별 가이드 (`steps`)
- 리소스 (`resources`)
- 다음 액션 (`nextActions`)

**현재 상태**: 
- 샘플 데이터는 `src/data/sampleRegistry.ts`에 있음
- 실제 DB 저장 구조는 명확하지 않음 (`pages.content`에 Markdown으로 저장 추정)

---

### 댓글 시스템

**서비스 파일**: `src/services/commentService.ts`  
**주요 함수**:
- `createComment()`: 댓글 생성
- `updateComment()`: 댓글 수정
- `deleteComment()`: 댓글 삭제
- `getCommentsByPageId()`: 페이지별 댓글 조회

**현재 기능**:
- ✅ 익명/로그인 유저 모두 댓글 작성 가능
- ✅ 로그인 유저는 본인 댓글 편집 가능
- ✅ 익명 유저는 비밀번호로 댓글 편집 가능
- ✅ 대댓글 지원 (최대 깊이 3)
- ✅ 좋아요/싫어요 시스템
- ✅ 신고 시스템

---

## 🔐 인증 및 권한 시스템

### 인증 Middleware

**파일**: `src/middleware/auth.ts`

**주요 Middleware**:
- `authMiddleware`: 모든 요청에서 JWT 검증, 사용자 정보를 Context에 저장
- `requireAuth`: 로그인 필수 체크
- `requireRole(minRole)`: 특정 역할 필수 체크

**사용 예시**:
```typescript
// 로그인 필수
app.get('/api/edit', requireAuth, async (c) => {
  const user = c.get('user')  // User | null
  // ...
})

// 관리자만 접근 가능
app.post('/api/admin/edit', requireRole('admin'), async (c) => {
  const user = c.get('user')  // User (null이 아님)
  // ...
})
```

**현재 상태**: 
- ✅ Google OAuth 로그인 구현됨
- ✅ JWT 기반 인증 구현됨
- ✅ 역할 기반 권한 체크 구현됨

---

## 📝 편집 시스템 요구사항

### 1. 직업/전공 상세 페이지 편집

**권한 규칙**:
- ✅ **API 데이터 (api_data_json)**: 모든 사용자 편집 가능 (익명/로그인 모두)
- ✅ **추가 내용**: 모든 사용자 편집 가능 (익명/로그인 모두)
- ✅ **모든 편집 내용에는 데이터 출처 필수**
- ✅ **익명 편집**: 비밀번호 기반 권한 관리 (댓글 시스템과 동일)

**편집 가능한 영역**:
- ✅ **API 원본 데이터**: summary, duties, way, salary, prospect 등 모든 필드
- ✅ **추가 정보 섹션**: 사용자 리뷰/후기, 실무 팁, 관련 자료 링크
- ✅ **기본 정보**: 이름, 카테고리 등 (단, ID는 변경 불가)

**편집 불가능한 영역**:
- ❌ **기본 ID**: 직업/전공의 고유 식별자 (id 필드)
- ❌ **시스템 필드**: created_at, api_last_fetched_at 등 메타데이터

**익명 편집 보안**:
- 익명 편집 시 4자리 비밀번호 필수
- 편집 이력에 IP 해시 저장 (개인정보 보호)
- 일일 편집 제한 (IP 기반, 댓글 시스템과 동일)

---

### 2. HowTo 가이드 편집

**권한 규칙**:
- ✅ **생성**: 모든 사용자 가능 (익명/로그인 모두)
- ✅ **편집**: 작성자 본인, 관리자, 또는 비밀번호 확인 후 가능
- ✅ **익명 편집**: 비밀번호 기반 권한 관리

**편집 가능한 영역**:
- 전체 내용 (제목, 요약, 단계, 리소스 등)

---

### 3. 댓글 편집

**권한 규칙**:
- ✅ **익명 유저**: 댓글 작성 및 본인 댓글 편집 가능 (비밀번호 기반)
- ✅ **로그인 유저**: 본인이 작성한 댓글만 편집 가능
- ✅ **관리자**: 모든 댓글 편집 가능

**현재 상태**: 
- ✅ 이미 구현됨 (익명 유저도 비밀번호로 편집 가능)

---

## 🎯 리서치 질문

### 1. 데이터 구조 설계

**질문 1.1**: `user_contributed_json`과 `admin_data_json`의 최적 구조는 무엇인가?

**고려사항**:
- 직업/전공 페이지의 어떤 섹션을 편집 가능하게 할 것인가?
- 각 편집 항목에 출처 정보를 어떻게 저장할 것인가?
- 버전 관리 및 편집 이력을 어떻게 추적할 것인가?

**예상 구조 옵션**:
```json
// 옵션 1: 섹션별 편집
{
  "sections": {
    "reviews": [
      {
        "id": "uuid",
        "content": "실무 후기 내용",
        "authorId": "user123",
        "source": "user",
        "createdAt": 1234567890,
        "updatedAt": 1234567890
      }
    ],
    "tips": [...],
    "resources": [...]
  }
}

// 옵션 2: 필드별 편집
{
  "additionalInfo": {
    "field": "summary",
    "value": "추가 설명",
    "authorId": "user123",
    "source": "user"
  }
}
```

**질문 1.2**: 편집 이력 추적을 위한 별도 테이블이 필요한가?

**고려사항**:
- `page_revisions` 테이블 활용 가능 여부
- 직업/전공 편집 이력과 HowTo 편집 이력을 분리할 것인가?
- 각 편집 항목별 이력 추적이 필요한가?

---

### 2. UI/UX 설계

**질문 2.1**: 편집 인터페이스는 어떻게 구성할 것인가?

**고려사항**:
- 인라인 편집 vs 모달 편집 vs 별도 페이지 편집
- 실시간 미리보기 필요 여부
- Markdown 에디터 vs 리치 텍스트 에디터
- 모바일 반응형 고려

**질문 2.2**: 편집 가능한 영역을 어떻게 표시할 것인가?

**고려사항**:
- "편집" 버튼 위치
- 편집 가능/불가능 영역 시각적 구분
- API 데이터 vs 사용자 추가 데이터 구분 표시

**질문 2.3**: 데이터 출처 표시는 어떻게 할 것인가?

**고려사항**:
- 각 편집 항목에 출처 배지 표시
- 출처 필수 입력 UI
- 출처 검증 로직

---

### 3. 성능 및 캐싱

**질문 3.1**: 편집 후 캐시 무효화 전략은?

**고려사항**:
- `wiki_pages` 캐시 무효화 시점
- 템플릿 버전 관리와의 관계
- 부분 캐시 업데이트 가능 여부

**질문 3.2**: 편집 데이터 병합 성능은?

**고려사항**:
- `user_contributed_json`과 `admin_data_json` 병합 로직 최적화
- 대량 편집 항목 처리
- 실시간 병합 vs 배치 병합

---

### 4. 보안 및 검증

**질문 4.1**: 편집 내용 검증은 어떻게 할 것인가?

**고려사항**:
- XSS 방지
- 스팸/악성 콘텐츠 필터링
- 길이 제한
- 형식 검증 (URL, 이메일 등)

**질문 4.2**: 권한 검증은 어디서 수행할 것인가?

**고려사항**:
- Middleware 레벨 검증 (익명 사용자도 허용)
- API 엔드포인트별 검증
- 프론트엔드 vs 백엔드 검증
- **익명 편집**: 비밀번호 검증 로직 (댓글 시스템과 동일)
- **API 데이터 편집**: 원본 데이터 보존 확인

---

### 5. 편집 워크플로우

**질문 5.1**: 편집 승인 프로세스가 필요한가?

**고려사항**:
- 즉시 반영 vs 승인 후 반영
- 관리자 승인 필요 여부
- 자동 승인 조건

**질문 5.2**: 편집 충돌 해결은 어떻게 할 것인가?

**고려사항**:
- 동시 편집 방지
- 편집 충돌 감지 및 해결
- 최신 우선 vs 먼저 저장 우선

---

### 6. HowTo 편집 시스템

**질문 6.1**: HowTo 편집 인터페이스는 어떻게 구성할 것인가?

**고려사항**:
- 단계별 편집 UI
- 드래그 앤 드롭으로 순서 변경
- 이미지/파일 업로드 지원 여부

**질문 6.2**: HowTo 데이터 저장 구조는?

**고려사항**:
- `pages.content`에 Markdown으로 저장 vs JSON으로 저장
- `meta_data` 활용 여부
- 버전 관리 방식

---

### 7. 통합 및 확장성

**질문 7.1**: 기존 댓글 시스템과의 통합은?

**고려사항**:
- 댓글과 편집 항목의 관계
- 댓글을 편집 항목으로 전환 가능 여부
- 통합 검색 기능

**질문 7.2**: 향후 확장 가능성은?

**고려사항**:
- ✅ 익명 편집 지원 (Phase 4에서 구현 예정)
- 전문가 검토 시스템
- AI 기반 편집 제안
- API 데이터 편집 시 원본 데이터 보존 전략

---

### 8. 실시간 협업 및 충돌 해결

**질문 8.1**: 동시 편집 충돌을 어떻게 해결할 것인가?

**고려사항**:
- Operational Transform (OT) vs CRDT 알고리즘 선택
- Cloudflare Workers 환경에서의 실시간 동기화 구현 가능성
- 편집 잠금 메커니즘 (편집 중 다른 사용자 편집 방지)
- 마지막 쓰기 승리 (Last Write Wins) vs 머지 전략

**참고 사례**:
- Google Docs: OT 기반 실시간 동기화
- 위키피디아: 편집 충돌 감지 및 수동 해결 UI
- Notion: CRDT 기반 충돌 없는 동기화

**질문 8.2**: 실시간 편집 표시가 필요한가?

**고려사항**:
- 다른 사용자의 편집 중 표시 (커서, 선택 영역)
- 편집 중인 사용자 수 표시
- 실시간 미리보기 업데이트

---

### 9. 모바일 편집 경험

**질문 9.1**: 모바일 편집 인터페이스는 어떻게 설계할 것인가?

**고려사항**:
- 터치 친화적 UI (버튼 크기, 간격)
- 모바일 키보드 대응
- 드래그 앤 드롭 대체 방법
- 모바일 전용 편집 모드

**참고 사례**:
- 나무위키: 모바일 최적화 편집 UI
- Notion: 모바일 앱 전용 편집 경험

**질문 9.2**: 모바일에서의 성능 최적화는?

**고려사항**:
- 네트워크 대역폭 고려
- 오프라인 편집 지원 여부
- 로컬 저장 및 동기화

---

### 10. 접근성 (Accessibility)

**질문 10.1**: 접근성 요구사항은 무엇인가?

**고려사항**:
- 키보드만으로 편집 가능 여부
- 스크린 리더 지원 (ARIA 라벨)
- 색상 대비 및 시각적 피드백
- 포커스 관리

**WCAG 2.1 AA 준수**:
- 키보드 접근성
- 스크린 리더 호환성
- 색상 대비 비율

---

### 11. 에러 처리 및 복구

**질문 11.1**: 편집 중 에러 발생 시 어떻게 처리할 것인가?

**고려사항**:
- 네트워크 오류 시 자동 재시도
- 편집 내용 자동 저장 (드래프트)
- 브라우저 새로고침 전 경고
- 편집 내용 복구 기능

**질문 11.2**: 데이터 무결성 보장은?

**고려사항**:
- 트랜잭션 처리
- 롤백 메커니즘
- 데이터 검증 실패 시 처리

---

### 12. 알림 및 피드백 시스템

**질문 12.1**: 편집 관련 알림은 어떻게 제공할 것인가?

**고려사항**:
- 편집 승인/거부 알림
- 다른 사용자의 편집 알림
- 댓글/토론 알림
- 이메일 vs 인앱 알림

**질문 12.2**: 사용자 피드백 수집은?

**고려사항**:
- 편집 만족도 조사
- 편집 도구 개선 제안 수집
- 버그 리포트 시스템

---

### 13. 편집 통계 및 분석

**질문 13.1**: 편집 통계는 어떻게 수집할 것인가?

**고려사항**:
- 편집 횟수 및 사용자별 통계
- 가장 많이 편집되는 섹션
- 편집 품질 지표
- 사용자 참여도 분석

**질문 13.2**: 분석 데이터 활용은?

**고려사항**:
- 편집 패턴 분석
- 사용자 행동 분석
- 시스템 개선을 위한 인사이트 도출

---

### 14. 국제화 (i18n) 고려사항

**질문 14.1**: 다국어 지원이 필요한가?

**고려사항**:
- 현재는 한국어만 지원하지만 향후 확장 가능성
- 편집 UI 다국어화
- 번역 편집 시스템

---

### 15. 성능 모니터링 및 최적화

**질문 15.1**: 편집 성능을 어떻게 모니터링할 것인가?

**고려사항**:
- 편집 응답 시간 측정
- 동시 편집자 수 제한
- 데이터베이스 쿼리 최적화
- 캐시 전략 모니터링

**질문 15.2**: 성능 병목 지점은?

**고려사항**:
- JSON 병합 로직 성능
- 대용량 편집 항목 처리
- 실시간 동기화 오버헤드

---

## 🔍 추가 조사 필요 사항

### 코드베이스 확인 필요

1. **현재 `user_contributed_json` 사용 현황**
   - 파일: `src/services/jobStorage.ts`
   - 실제 데이터 구조 확인
   - 병합 로직 상세 분석

2. **템플릿 렌더링 로직**
   - 파일: `src/templates/unifiedJobDetail.ts`, `src/templates/unifiedMajorDetail.ts`
   - 현재 사용자 추가 데이터 표시 여부
   - 섹션별 렌더링 로직 분석

3. **ISR 캐시 무효화 로직**
   - 파일: `src/utils/page-cache.ts`
   - 캐시 업데이트 시점
   - 편집 후 캐시 처리 방법

4. **HowTo 데이터 저장 및 로드**
   - 파일: `src/index.tsx` (HowTo 라우트)
   - `pages` 테이블에서 데이터 로드 방식
   - Markdown 파싱 로직

---

## 📚 참고 자료

### 프로젝트 문서
- `docs/D1_DATABASE_STRUCTURE.md`: 데이터베이스 구조 상세
- `PHASE3_PLAN.md`: Phase 3 계획 (인증 시스템)
- `TECH_SPEC.md`: 기술 명세
- `DATA_STORAGE_GUIDE.md`: 데이터 저장 가이드

### 주요 코드 파일
- `src/index.tsx`: 메인 애플리케이션 진입점
- `src/middleware/auth.ts`: 인증 Middleware
- `src/services/commentService.ts`: 댓글 서비스
- `src/services/jobStorage.ts`: 직업 데이터 저장 서비스
- `src/templates/unifiedJobDetail.ts`: 직업 상세 템플릿
- `src/templates/unifiedMajorDetail.ts`: 전공 상세 템플릿
- `src/templates/howtoDetail.ts`: HowTo 상세 템플릿
- `src/constants/template-versions.ts`: 템플릿 버전 관리
- `src/utils/page-cache.ts`: ISR 캐시 유틸리티

---

## 🌐 참고 웹사이트 및 벤치마크

### 위키 시스템 벤치마크

#### 1. 위키피디아 (Wikipedia)
- **URL**: https://www.wikipedia.org/
- **특징**:
  - MediaWiki 기반 대규모 협업 편집 시스템
  - 편집 이력 추적 및 되돌리기 기능
  - 편집 충돌 해결 메커니즘
  - 토론 페이지를 통한 편집 논의
  - 편집 요약 및 변경 사항 표시
- **학습 포인트**:
  - 버전 관리 시스템 설계
  - 편집 품질 관리 전략
  - 사용자 권한 및 역할 관리
  - 반달리즘 방지 시스템

#### 2. 나무위키 (Namuwiki)
- **URL**: https://namu.wiki/
- **특징**:
  - 한국어 위키 시스템
  - 실시간 편집 및 미리보기
  - 편집 토론 및 합의 시스템
  - 편집 요약 및 출처 표기
  - 모바일 편집 지원
- **학습 포인트**:
  - 한국 사용자 UX 패턴
  - 실시간 미리보기 구현
  - 편집 토론 워크플로우
  - 모바일 편집 경험 최적화

#### 3. Fandom (구 Wikia)
- **URL**: https://www.fandom.com/
- **특징**:
  - 커뮤니티 기반 위키 플랫폼
  - 리치 텍스트 에디터
  - 이미지 및 미디어 편집
  - 템플릿 시스템
- **학습 포인트**:
  - 리치 텍스트 에디터 통합
  - 미디어 관리 시스템
  - 커뮤니티 기반 품질 관리

### 커뮤니티 편집 시스템 벤치마크

#### 4. 디시인사이드 (DC Inside)
- **URL**: https://www.dcinside.com/
- **특징**:
  - 익명 기반 게시판 시스템
  - 실시간 댓글 및 수정
  - 익명 번호 시스템
  - 비밀번호 기반 수정
- **학습 포인트**:
  - 익명 사용자 편집 시스템
  - 비밀번호 기반 권한 관리
  - 실시간 업데이트 처리
  - 익명 환경에서의 품질 관리

#### 5. 레딧 (Reddit)
- **URL**: https://www.reddit.com/
- **특징**:
  - Markdown 기반 편집
  - 실시간 미리보기
  - 편집 이력 표시
  - 댓글 편집 및 삭제
- **학습 포인트**:
  - Markdown 에디터 구현
  - 실시간 미리보기
  - 편집 표시 (edited 표시)

#### 6. Stack Overflow
- **URL**: https://stackoverflow.com/
- **특징**:
  - 질문/답변 편집 시스템
  - 편집 이력 및 변경 사항 표시
  - 커뮤니티 기반 편집 승인
  - 출처 및 참고 자료 관리
- **학습 포인트**:
  - 편집 이력 상세 표시
  - 커뮤니티 검토 시스템
  - 출처 관리 및 검증

### 협업 편집 도구 벤치마크

#### 7. Google Docs
- **URL**: https://docs.google.com/
- **특징**:
  - 실시간 협업 편집
  - Operational Transform 기반 충돌 해결
  - 사용자 커서 및 선택 표시
  - 제안 모드 및 댓글 시스템
- **학습 포인트**:
  - 실시간 동기화 기술
  - 편집 충돌 해결 알고리즘
  - 사용자 피드백 표시

#### 8. Notion
- **URL**: https://www.notion.so/
- **특징**:
  - 블록 기반 편집
  - 드래그 앤 드롭 재배치
  - 템플릿 시스템
  - 협업 및 권한 관리
- **학습 포인트**:
  - 블록 기반 편집 인터페이스
  - 드래그 앤 드롭 UX
  - 권한 기반 편집 제어

#### 9. Confluence
- **URL**: https://www.atlassian.com/software/confluence
- **특징**:
  - 엔터프라이즈 위키 시스템
  - 페이지 버전 관리
  - 편집 승인 워크플로우
  - 템플릿 및 매크로 시스템
- **학습 포인트**:
  - 엔터프라이즈급 편집 시스템
  - 승인 워크플로우 설계
  - 템플릿 시스템

### 오픈소스 편집 라이브러리

#### 10. ProseMirror
- **URL**: https://prosemirror.net/
- **특징**:
  - 리치 텍스트 에디터 프레임워크
  - 확장 가능한 구조
  - 협업 편집 지원
- **학습 포인트**:
  - 리치 텍스트 에디터 아키텍처
  - 확장 가능한 플러그인 시스템

#### 11. Slate.js
- **URL**: https://www.slatejs.org/
- **특징**:
  - React 기반 리치 텍스트 에디터
  - 완전히 커스터마이징 가능
  - 협업 편집 지원
- **학습 포인트**:
  - React 기반 에디터 구현
  - 커스터마이징 전략

#### 12. TipTap
- **URL**: https://tiptap.dev/
- **특징**:
  - ProseMirror 기반 Vue/React 에디터
  - 확장 가능한 구조
  - 협업 편집 지원
- **학습 포인트**:
  - Vue/React 통합
  - 확장성 있는 에디터 설계

### 참고할 핵심 기능들

1. **편집 이력 관리** (위키피디아, Stack Overflow)
   - 변경 사항 diff 표시
   - 되돌리기 기능
   - 편집 요약 작성

2. **실시간 협업** (Google Docs, Notion)
   - 동시 편집 충돌 해결
   - 사용자 커서 표시
   - 실시간 동기화

3. **익명 편집** (디시인사이드)
   - 익명 번호 시스템
   - 비밀번호 기반 수정
   - IP 기반 제한

4. **출처 관리** (위키피디아, Stack Overflow)
   - 출처 필수 입력
   - 출처 검증
   - 출처 표시 UI

5. **모바일 편집** (나무위키, Notion)
   - 모바일 최적화 UI
   - 터치 제스처 지원
   - 반응형 레이아웃

6. **편집 품질 관리** (위키피디아, 레딧)
   - 자동 스팸 필터링
   - 커뮤니티 검토
   - 신고 및 차단 시스템

---

## 🎯 리서치 목표

이 프롬프트를 바탕으로 다음을 조사하고 설계해야 합니다:

1. ✅ **데이터 구조 설계**: `user_contributed_json`과 `admin_data_json`의 최적 구조
2. ✅ **UI/UX 설계**: 직관적이고 깔끔한 편집 인터페이스
3. ✅ **성능 최적화**: 빠른 업데이트를 위한 캐싱 전략
4. ✅ **보안 강화**: 오류 없는 안전한 편집 시스템
5. ✅ **워크플로우 설계**: 편집부터 반영까지의 전체 프로세스
6. ✅ **통합 설계**: 기존 시스템과의 원활한 통합

---

## 💡 예상 결과물

리서치 완료 후 다음 문서들이 생성되어야 합니다:

1. **데이터 구조 설계서**: 편집 데이터 저장 구조 상세
   - `user_contributed_json` 및 `admin_data_json` 스키마 정의
   - 편집 항목별 데이터 구조
   - 버전 관리 및 이력 추적 구조

2. **API 명세서**: 편집 관련 API 엔드포인트 정의
   - RESTful API 엔드포인트 목록
   - 요청/응답 스키마
   - 에러 코드 및 처리 방법
   - 인증 및 권한 체크 로직

3. **UI/UX 설계서**: 편집 인터페이스 와이어프레임 및 상세 설계
   - 데스크톱 편집 UI
   - 모바일 편집 UI
   - 편집 가능/불가능 영역 시각적 구분
   - 출처 입력 및 표시 UI
   - 실시간 미리보기 UI

4. **보안 가이드**: 편집 내용 검증 및 권한 관리 가이드
   - XSS 방지 전략
   - 스팸/악성 콘텐츠 필터링
   - 입력 검증 규칙
   - 권한 검증 체크리스트

5. **성능 최적화 계획**: 캐싱 및 병합 로직 최적화 방안
   - ISR 캐시 무효화 전략
   - 데이터 병합 최적화
   - 실시간 동기화 성능 최적화
   - 모바일 성능 최적화

6. **실시간 협업 설계서**: 동시 편집 충돌 해결 방안
   - 편집 충돌 해결 알고리즘 선택 및 구현 방안
   - 편집 잠금 메커니즘
   - 실시간 동기화 아키텍처

7. **에러 처리 및 복구 가이드**: 에러 상황 대응 방안
   - 네트워크 오류 처리
   - 자동 저장 및 복구 메커니즘
   - 사용자 피드백 제공 방법

8. **접근성 가이드**: WCAG 2.1 AA 준수 방안
   - 키보드 접근성
   - 스크린 리더 지원
   - 시각적 피드백

9. **구현 로드맵**: Phase 4 개발 단계별 계획
   - 우선순위별 개발 단계
   - 예상 개발 시간
   - 테스트 계획

10. **벤치마크 분석 보고서**: 참고 웹사이트 분석 결과
    - 각 웹사이트의 핵심 기능 분석
    - 적용 가능한 패턴 및 기법
    - 차별화 포인트

---

## 🎯 리서치 수행 가이드

### AI에게 요청할 내용

다음과 같이 AI에게 요청하세요:

```
당신은 위키피디아 전 Senior 엔지니어, 30년차 편집 시스템 전문 개발자, 
그리고 한국 커뮤니티 플랫폼 전문가의 관점을 종합하여 
위의 리서치 프롬프트를 바탕으로 Phase 4 편집 시스템을 설계해주세요.

특히 다음을 중점적으로 다뤄주세요:
1. 위키피디아, 나무위키, 디시인사이드 등 참고 웹사이트의 
   핵심 기능을 분석하고 우리 프로젝트에 적용 가능한 패턴 도출
2. Cloudflare Workers 환경에서의 실시간 협업 편집 구현 가능성 검토
3. 한국 사용자 특성을 고려한 UX 설계
4. 성능과 사용성의 균형을 맞춘 실용적인 설계안 제시

위의 모든 질문에 대해 구체적이고 실행 가능한 답변을 제공해주세요.
```

### 리서치 결과 검증 체크리스트

리서치 결과물이 다음을 포함하는지 확인하세요:

- [ ] 참고 웹사이트 분석이 포함되어 있는가?
- [ ] 구체적인 데이터 구조 설계안이 제시되었는가?
- [ ] API 엔드포인트가 명확히 정의되었는가?
- [ ] UI/UX 설계가 모바일까지 고려되었는가?
- [ ] 보안 검증 로직이 구체적으로 제시되었는가?
- [ ] 성능 최적화 방안이 실행 가능한가?
- [ ] 에러 처리 및 복구 전략이 포함되었는가?
- [ ] 접근성 요구사항이 고려되었는가?
- [ ] 구현 우선순위가 명확한가?

---

**다음 단계**: 이 프롬프트를 AI에게 제공하여 종합적인 리서치를 수행하고, 위의 질문들에 대한 답변과 설계안을 도출하세요.

