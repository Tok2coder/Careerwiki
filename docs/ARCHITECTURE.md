# CareerWiki 시스템 아키텍처

## 📋 목차
1. [시스템 개요](#시스템-개요)
2. [현재 아키텍처 (SSR)](#현재-아키텍처-ssr)
3. [목표 아키텍처 (정적 위키)](#목표-아키텍처-정적-위키)
4. [데이터 흐름](#데이터-흐름)
5. [기술 스택](#기술-스택)

---

## 🎯 시스템 개요

CareerWiki는 **AI 기반 진로 분석**과 **협업형 위키**를 결합한 플랫폼입니다.

### 핵심 목표
1. **완전한 데이터**: 커리어넷 + 고용24 API의 모든 필드 수집
2. **빠른 응답**: 정적 HTML 페이지로 0.1초 이내 응답
3. **사용자 기여**: 로그인 유저가 페이지 편집 및 추가 정보 기여
4. **AI 보강**: 부족한 데이터를 AI로 자동 생성
5. **무한 확장**: 페이지 수가 늘어나도 성능 유지

---

## 🔄 현재 아키텍처 (SSR)

### 데이터 흐름
```
┌─────────────────────────────────────────────────────────────┐
│                    1. 데이터 수집 (시딩)                       │
└─────────────────────────────────────────────────────────────┘
        커리어넷 API                    고용24 API
             ↓                              ↓
        ┌──────────────────────────────────────────┐
        │   seedAllMajors.ts / seedAllJobs.ts     │
        │   - normalize (정규화)                   │
        │   - merge (병합)                         │
        └──────────────────────────────────────────┘
                          ↓
        ┌──────────────────────────────────────────┐
        │      D1 Database (Cloudflare SQLite)    │
        │                                          │
        │  majors/jobs 테이블:                      │
        │  ├─ id, name                             │
        │  ├─ careernet_id, goyong24_id            │
        │  └─ api_data_json: {                     │
        │       careernet: {...},                  │
        │       goyong24: {...},                   │
        │       merged: {...}                      │
        │    }                                     │
        └──────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│              2. 사용자 요청 처리 (런타임 SSR)                  │
└─────────────────────────────────────────────────────────────┘

사용자 /major/컴퓨터공학과 접속
        ↓
Hono 라우터 (app.get('/major/:slug'))
        ↓
getUnifiedMajorDetail() - D1 조회
        ↓
renderUnifiedMajorDetail() - 템플릿 적용 ⚠️ 매번 렌더링!
        ↓
renderLayout() - HTML 생성
        ↓
브라우저로 HTML 응답 (평균 500ms)
```

### 문제점
| 문제 | 설명 | 영향 |
|------|------|------|
| **매번 렌더링** | 모든 요청마다 템플릿 엔진 실행 | CPU 사용 ↑, 응답 느림 |
| **사용자 기여 병합 복잡** | user_contributed_json 병합 로직 필요 | 코드 복잡도 ↑ |
| **확장성 제한** | 트래픽 증가 시 서버 부하 | 비용 ↑ |

---

## ✨ 목표 아키텍처 (정적 위키)

### 핵심 개념: "Build Once, Serve Many"
```
페이지 생성 (1회) → D1 저장 → 빠른 조회 (무한 반복)
```

### 데이터 흐름

#### Phase 1: 초기 페이지 생성 (1회)
```
API 데이터 수집 (기존과 동일)
        ↓
┌──────────────────────────────────────────┐
│       PageBuilder 서비스                  │
│  1. API 데이터 조회                        │
│  2. 섹션별 HTML 생성:                      │
│     - overview (API)                     │
│     - universities (API)                 │
│     - reviews (사용자 기여 슬롯)            │
│     - career_path (AI 생성 슬롯)          │
│  3. 완전한 HTML 조립                       │
└──────────────────────────────────────────┘
        ↓
┌──────────────────────────────────────────┐
│      D1 wiki_pages 테이블                 │
│                                          │
│  slug: "컴퓨터공학과"                      │
│  content: "<완전한 HTML 페이지>"           │
│  sections_meta: {                        │
│    "overview": {                         │
│      "source": "API",                    │
│      "last_updated": 1234567890          │
│    },                                    │
│    "reviews": {                          │
│      "source": "USER",                   │
│      "count": 0                          │
│    }                                     │
│  }                                       │
│  version: 1                              │
└──────────────────────────────────────────┘
```

#### Phase 2: 사용자 요청 (초고속)
```
사용자 /major/컴퓨터공학과 접속
        ↓
Hono 라우터
        ↓
SELECT content FROM wiki_pages WHERE slug = ? ⚡ 단순 SELECT!
        ↓
HTML 그대로 반환 (0.05초) ⚡ 10배 빠름!
```

#### Phase 3: 증분 업데이트 (변경 시만)
```
┌─────────────────────────────────────────────────────────────┐
│                    업데이트 트리거                             │
└─────────────────────────────────────────────────────────────┘

Case 1: API 데이터 변경
  커리어넷 API 업데이트 감지
        ↓
  page_update_queue에 추가
        ↓
  PageUpdateWorker 실행 (Cloudflare Cron)
        ↓
  해당 섹션만 재생성 (overview, universities)
        ↓
  wiki_pages.content 업데이트 + version++

Case 2: 사용자 기여
  로그인 유저가 "졸업생 후기" 작성
        ↓
  user_contributions 테이블에 저장
        ↓
  관리자 승인 (또는 자동 승인)
        ↓
  reviews 섹션만 재생성
        ↓
  wiki_pages.content 업데이트 + version++

Case 3: AI 콘텐츠 생성
  AI가 "추천 진로" 생성
        ↓
  ai_generated_content 테이블에 저장
        ↓
  관리자 검토
        ↓
  career_path 섹션만 재생성
        ↓
  wiki_pages.content 업데이트 + version++
```

---

## 🗄️ D1 스키마 설계

### 핵심 테이블

#### 1. `wiki_pages` - 완성된 HTML 페이지
```sql
CREATE TABLE wiki_pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,                    -- URL 슬러그
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major')),
  title TEXT NOT NULL,
  
  -- 완성된 HTML 콘텐츠
  content TEXT NOT NULL,                        -- ⭐ 핵심!
  
  -- 섹션 메타데이터 (JSON)
  sections_meta TEXT,                           -- 각 섹션 출처/업데이트 시간
  
  -- 원본 데이터 참조
  careernet_id TEXT,
  goyong24_id TEXT,
  
  -- 버전 관리
  version INTEGER DEFAULT 1,
  
  -- 타임스탬프
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  last_api_sync_at INTEGER
);
```

#### 2. `api_data_cache` - API 원본 데이터
```sql
CREATE TABLE api_data_cache (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  entity_type TEXT NOT NULL CHECK(entity_type IN ('job', 'major')),
  entity_id TEXT NOT NULL,
  source TEXT NOT NULL CHECK(source IN ('CAREERNET', 'GOYONG24')),
  
  -- 원본 & 정규화 데이터
  raw_data TEXT NOT NULL,
  normalized_data TEXT NOT NULL,
  
  -- 캐시 관리
  data_hash TEXT NOT NULL,
  fetched_at INTEGER NOT NULL,
  expires_at INTEGER,
  
  UNIQUE(entity_type, entity_id, source)
);
```

#### 3. `user_contributions` - 사용자 기여
```sql
CREATE TABLE user_contributions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_slug TEXT NOT NULL,
  section_name TEXT NOT NULL,
  
  contribution_type TEXT NOT NULL CHECK(contribution_type IN (
    'review', 'tip', 'course', 'resource', 'correction', 'addition'
  )),
  
  content TEXT NOT NULL,
  
  -- 기여자 정보
  user_id INTEGER,                              -- 로그인 유저
  user_nickname TEXT DEFAULT '익명',
  
  -- 상태
  status TEXT DEFAULT 'pending' CHECK(status IN (
    'pending', 'approved', 'rejected', 'archived'
  )),
  
  -- 투표
  upvotes INTEGER DEFAULT 0,
  downvotes INTEGER DEFAULT 0,
  
  created_at INTEGER NOT NULL,
  
  FOREIGN KEY (page_slug) REFERENCES wiki_pages(slug) ON DELETE CASCADE
);
```

#### 4. `ai_generated_content` - AI 생성 콘텐츠
```sql
CREATE TABLE ai_generated_content (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_slug TEXT NOT NULL,
  section_name TEXT NOT NULL,
  
  content_type TEXT NOT NULL CHECK(content_type IN (
    'career_path', 'skills', 'salary_forecast', 'job_outlook', 'study_plan'
  )),
  
  content TEXT NOT NULL,
  
  -- AI 메타데이터
  model TEXT NOT NULL,                          -- 'claude-3', 'gpt-4' 등
  confidence_score REAL,
  
  -- 검증 상태
  status TEXT DEFAULT 'pending',
  verified_by INTEGER,
  verified_at INTEGER,
  
  generated_at INTEGER NOT NULL,
  expires_at INTEGER,                           -- 재생성 필요 시점
  
  FOREIGN KEY (page_slug) REFERENCES wiki_pages(slug) ON DELETE CASCADE
);
```

#### 5. `page_update_queue` - 업데이트 큐
```sql
CREATE TABLE page_update_queue (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_slug TEXT NOT NULL,
  
  update_type TEXT NOT NULL CHECK(update_type IN (
    'api_sync', 'user_contribution', 'ai_generation', 'template_refresh'
  )),
  
  sections_to_update TEXT,                      -- JSON 배열
  priority INTEGER DEFAULT 5,
  
  status TEXT DEFAULT 'pending' CHECK(status IN (
    'pending', 'processing', 'completed', 'failed'
  )),
  
  attempts INTEGER DEFAULT 0,
  last_error TEXT,
  
  created_at INTEGER NOT NULL,
  started_at INTEGER,
  completed_at INTEGER
);
```

#### 6. `users` - 사용자 (향후)
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT UNIQUE NOT NULL,
  nickname TEXT,
  role TEXT DEFAULT 'user' CHECK(role IN ('user', 'editor', 'admin')),
  
  created_at INTEGER NOT NULL
);
```

---

## 🔄 데이터 병합 전략

### 중복 감지 알고리즘
```typescript
// 1단계: 정확 매칭 (대소문자 무시)
if (name1.toLowerCase() === name2.toLowerCase()) {
  return 'exact_match'
}

// 2단계: 유사도 매칭 (Levenshtein distance)
const similarity = calculateSimilarity(name1, name2)
if (similarity >= 0.9) {  // 90% 이상
  return 'fuzzy_match'
}

// 3단계: 수동 매핑 테이블 조회
const mapping = MANUAL_MAPPINGS[name1]
if (mapping === name2) {
  return 'manual_match'
}

return 'no_match'
```

### 병합 규칙
```typescript
// 필드 우선순위
const FIELD_PRIORITY = {
  name: 'CAREERNET',           // 커리어넷 이름 우선
  summary: 'CAREERNET',        // 커리어넷 설명 우선
  employmentRate: 'GOYONG24',  // 고용24 취업률 우선
  salary: 'GOYONG24',          // 고용24 연봉 우선
  universities: 'CAREERNET',   // 커리어넷 대학 목록 우선
}

// 병합 로직
function mergeMajors(careernet: Major, goyong24: Major): Major {
  return {
    id: `merged_${careernet.id}_${goyong24.id}`,
    name: careernet.name,        // 커리어넷 우선
    summary: careernet.summary,  // 커리어넷 우선
    employmentRate: goyong24.employmentRate,  // 고용24 우선
    salary: goyong24.salary,     // 고용24 우선
    universities: careernet.universities,  // 커리어넷 우선
    sources: ['CAREERNET', 'GOYONG24']
  }
}
```

---

## 🚀 성능 비교

| 지표 | 현재 (SSR) | 목표 (정적 위키) | 개선율 |
|------|-----------|---------------|--------|
| 평균 응답 시간 | 500ms | 50ms | **10배 ↑** |
| 서버 CPU 사용률 | 80% | 10% | **8배 ↓** |
| 동시 처리 가능 | 100 req/s | 1,000 req/s | **10배 ↑** |
| 메모리 사용량 | 200MB | 50MB | **4배 ↓** |

---

## 🛠️ 기술 스택

### 현재
- **Runtime**: Cloudflare Workers
- **Framework**: Hono 4.0
- **Database**: Cloudflare D1 (SQLite)
- **Language**: TypeScript
- **Styling**: TailwindCSS
- **Build**: Vite

### 추가 예정
- **Auth**: Cloudflare Access / Clerk / Auth.js (TBD)
- **AI**: Claude 3 / GPT-4 (TBD)
- **Monitoring**: Cloudflare Analytics

---

## 📖 관련 문서

- [개발 로드맵](./DEVELOPMENT_ROADMAP.md) - 단계별 개발 계획
- [마이그레이션 계획](./migration-plan.md) - 상세 마이그레이션 가이드
- [API 통합 문서](./API_INTEGRATION.md) - API 필드 매핑 (작성 중)
- [기여 가이드](./CONTRIBUTING.md) - 편집 시스템 (작성 예정)

---

*Last Updated: 2025-11-05*
