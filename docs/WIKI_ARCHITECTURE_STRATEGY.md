# CareerWiki 위키 시스템 아키텍처 전략

**작성일:** 2025-11-06  
**기반:** 나무위키/위키피디아 아키텍처 분석

---

## 🎯 핵심 전략: Cached Dynamic Rendering

### 위키 시스템의 핵심 인사이트

```
Wikipedia/나무위키 방식:
┌─────────────────────────────────────────────────────────────┐
│  사용자 요청: /w/ChatGPT                                       │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  1. 캐시 확인 (Redis/Memcached)                              │
│     - 캐시 히트 → 즉시 HTML 응답 (50ms) ⚡                     │
│     - 캐시 미스 → 다음 단계                                     │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  2. DB 조회: wikitext 로드                                    │
│     SELECT text FROM revision WHERE page='ChatGPT'          │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  3. 파싱 & 렌더링                                             │
│     - Wikitext → AST → HTML                                │
│     - 템플릿 삽입 ({{틀:정보상자}})                              │
│     - 스킨 적용 (레이아웃)                                      │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  4. 캐시 저장 & 응답                                           │
│     - Redis에 HTML 저장                                      │
│     - 브라우저에 HTML 응답 (300ms)                             │
└─────────────────────────────────────────────────────────────┘

편집 시:
┌─────────────────────────────────────────────────────────────┐
│  사용자가 "ChatGPT" 문서 편집                                   │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  1. DB에 새 revision 저장                                     │
│  2. 해당 페이지의 캐시 무효화 (INVALIDATE)                       │
│  3. 다음 요청 시 자동으로 재생성                                  │
└─────────────────────────────────────────────────────────────┘
```

**핵심 장점:**
- ✅ **템플릿 수정 시**: 캐시만 무효화하면 모든 페이지 자동 업데이트
- ✅ **데이터 업데이트 시**: 해당 페이지 캐시만 무효화
- ✅ **확장성**: 페이지 수 증가해도 성능 유지 (캐시 덕분)

---

## 🏗️ CareerWiki 적용 아키텍처

### Architecture: Hybrid Cached Template System

```
┌─────────────────────────────────────────────────────────────┐
│  사용자 요청: /major/컴퓨터공학과                                │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  Hono Router: app.get('/major/:slug')                       │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  Cache Layer (D1 wiki_pages 테이블)                          │
│                                                             │
│  SELECT content, cache_version                              │
│  FROM wiki_pages                                            │
│  WHERE slug = '컴퓨터공학과'                                   │
│                                                             │
│  IF cache_version == CURRENT_TEMPLATE_VERSION:              │
│    → 캐시 히트! HTML 즉시 반환 (50ms) ⚡                       │
│  ELSE:                                                      │
│    → 캐시 미스! 재생성 필요                                     │
└─────────────────────────────────────────────────────────────┘
        ↓ (캐시 미스 시만)
┌─────────────────────────────────────────────────────────────┐
│  Data Layer (D1 majors/jobs 테이블)                          │
│                                                             │
│  SELECT api_data_json                                       │
│  FROM majors                                                │
│  WHERE name = '컴퓨터공학과'                                   │
│                                                             │
│  → API 데이터 파싱 (JSON → UnifiedMajorDetail)                │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  Template Rendering (하나의 템플릿으로 모든 페이지 생성)            │
│                                                             │
│  MajorDetailTemplate.tsx (컴포넌트)                          │
│  - Hero Section                                             │
│  - 학과 특성                                                  │
│  - 관련 고교 교과목                                             │
│  - 대학 주요 교과목                                             │
│  - 통계 차트                                                  │
│  - 개설 대학                                                  │
│                                                             │
│  → 완성된 HTML 생성                                           │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  Cache Update (D1 wiki_pages)                               │
│                                                             │
│  INSERT OR REPLACE INTO wiki_pages (                        │
│    slug, content, cache_version, updated_at                 │
│  ) VALUES (                                                 │
│    '컴퓨터공학과',                                             │
│    '<html>...</html>',                                      │
│    CURRENT_TEMPLATE_VERSION,  ← 버전 저장!                   │
│    CURRENT_TIMESTAMP                                        │
│  )                                                          │
└─────────────────────────────────────────────────────────────┘
        ↓
┌─────────────────────────────────────────────────────────────┐
│  Response: HTML 반환 (첫 요청 300ms, 이후 50ms)                │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔧 템플릿 업데이트 시나리오

### Case 1: 템플릿 디자인 수정 (CSS/레이아웃 변경)

```typescript
// src/templates/MajorDetailTemplate.tsx
// 버전 상수 정의
export const MAJOR_TEMPLATE_VERSION = 2  // ← 이거 하나만 올리면 끝!

export const MajorDetailTemplate = (data: UnifiedMajorDetail) => {
  return (
    <html>
      <head>
        <style>{`
          /* 새로운 스타일 */
          .major-header { background: linear-gradient(...); }
        `}</style>
      </head>
      <body>
        {/* 새로운 레이아웃 */}
      </body>
    </html>
  )
}
```

**라우터 코드:**
```typescript
// src/index.tsx
import { MAJOR_TEMPLATE_VERSION } from './templates/MajorDetailTemplate'

app.get('/major/:slug', async (c) => {
  const slug = c.req.param('slug')
  
  // 1. 캐시 확인
  const cached = await c.env.DB.prepare(`
    SELECT content, cache_version 
    FROM wiki_pages 
    WHERE slug = ? AND page_type = 'major'
  `).bind(slug).first()
  
  // 2. 캐시 히트 & 버전 일치 → 즉시 반환
  if (cached && cached.cache_version === MAJOR_TEMPLATE_VERSION) {
    return c.html(cached.content)  // ⚡ 50ms
  }
  
  // 3. 캐시 미스 or 버전 불일치 → 재생성
  const data = await getUnifiedMajorDetail(slug, c.env)
  const html = await renderToString(<MajorDetailTemplate {...data} />)
  
  // 4. 캐시 저장
  await c.env.DB.prepare(`
    INSERT OR REPLACE INTO wiki_pages 
    (slug, page_type, content, cache_version, updated_at)
    VALUES (?, 'major', ?, ?, ?)
  `).bind(slug, html, MAJOR_TEMPLATE_VERSION, Date.now()).run()
  
  return c.html(html)  // 300ms (첫 요청만)
})
```

**결과:**
- ✅ `MAJOR_TEMPLATE_VERSION = 2`로 올림
- ✅ 다음 요청들이 자동으로 새 템플릿으로 재생성
- ✅ 관리자가 일괄 재생성 명령 실행 불필요!

---

### Case 2: API 데이터 업데이트 (시딩 재실행)

```typescript
// src/scripts/seedAllMajors.ts
async function seedMajor(major: UnifiedMajorDetail, env: Env) {
  // 1. majors 테이블에 API 데이터 저장
  await env.DB.prepare(`
    INSERT OR REPLACE INTO majors (...)
    VALUES (...)
  `).run()
  
  // 2. 해당 전공의 캐시 무효화
  await env.DB.prepare(`
    DELETE FROM wiki_pages 
    WHERE slug = ? AND page_type = 'major'
  `).bind(major.name).run()
  
  console.log(`✅ ${major.name} - 캐시 무효화 완료`)
  // 다음 요청 시 자동으로 새 데이터로 재생성됨
}
```

**결과:**
- ✅ 시딩 시 자동으로 캐시 무효화
- ✅ 다음 사용자 요청 시 새 데이터로 페이지 생성

---

### Case 3: 사용자 기여 콘텐츠 추가 (향후 Phase 4)

```typescript
// src/routes/contributions.ts
app.post('/api/contributions', async (c) => {
  const { slug, section, content } = await c.req.json()
  
  // 1. 기여 데이터 저장
  await c.env.DB.prepare(`
    INSERT INTO user_contributions (page_slug, section_name, content, status)
    VALUES (?, ?, ?, 'approved')
  `).bind(slug, section, content).run()
  
  // 2. 해당 페이지 캐시 무효화
  await c.env.DB.prepare(`
    DELETE FROM wiki_pages WHERE slug = ?
  `).bind(slug).run()
  
  return c.json({ success: true })
})

// 페이지 렌더링 시 기여 콘텐츠 병합
const MajorDetailTemplate = async (data: UnifiedMajorDetail, contributions: UserContribution[]) => {
  return (
    <html>
      <body>
        {/* API 데이터 섹션 */}
        <section>{data.overview}</section>
        
        {/* 사용자 기여 섹션 */}
        <section class="user-contributions">
          <h2>졸업생 후기</h2>
          {contributions.map(c => (
            <div class="review">{c.content}</div>
          ))}
        </section>
      </body>
    </html>
  )
}
```

---

## 📊 성능 비교

| 방식 | 템플릿 수정 시 | 첫 요청 | 이후 요청 | 확장성 |
|------|------------|--------|---------|-------|
| **정적 생성 (SSG)** | 모든 페이지 재빌드 (30분) | 50ms | 50ms | ⚠️ 빌드 시간 증가 |
| **순수 SSR** | 즉시 반영 | 500ms | 500ms | ❌ 트래픽 증가 시 느림 |
| **위키 방식 (Cached Dynamic)** | 즉시 반영 (버전만 올림) | 300ms | 50ms | ✅ 무한 확장 가능 |

---

## 🗄️ D1 스키마 (위키 방식)

### wiki_pages 테이블 (캐시 레이어)

```sql
CREATE TABLE wiki_pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT NOT NULL,
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major')),
  
  -- 캐시된 HTML
  content TEXT NOT NULL,
  
  -- 버전 관리 (핵심!)
  cache_version INTEGER NOT NULL,  -- 템플릿 버전과 비교
  
  -- 메타데이터
  title TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  
  UNIQUE(slug, page_type)
);

CREATE INDEX idx_wiki_pages_slug ON wiki_pages(slug, page_type);
CREATE INDEX idx_wiki_pages_version ON wiki_pages(cache_version);
```

### majors 테이블 (데이터 레이어)

```sql
CREATE TABLE majors (
  id TEXT PRIMARY KEY,
  careernet_id TEXT,
  goyong24_id TEXT,
  name TEXT NOT NULL,
  
  -- API 원본 데이터 (JSON)
  api_data_json TEXT,
  api_data_hash TEXT,
  api_last_fetched_at INTEGER,
  api_last_updated_at INTEGER,
  
  created_at INTEGER NOT NULL,
  is_active INTEGER DEFAULT 1
);
```

### user_contributions 테이블 (사용자 기여)

```sql
CREATE TABLE user_contributions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_slug TEXT NOT NULL,
  section_name TEXT NOT NULL,
  content TEXT NOT NULL,
  
  user_id INTEGER,
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'approved', 'rejected')),
  
  upvotes INTEGER DEFAULT 0,
  downvotes INTEGER DEFAULT 0,
  
  created_at INTEGER NOT NULL,
  
  FOREIGN KEY (page_slug) REFERENCES wiki_pages(slug)
);
```

---

## 🚀 구현 로드맵

### Phase 2.1: 캐시 시스템 구축 (1-2일)
- [ ] `wiki_pages` 테이블 생성
- [ ] 템플릿 버전 관리 시스템
- [ ] 캐시 히트/미스 로직 구현
- [ ] 10개 샘플 페이지 테스트

### Phase 2.2: 템플릿 개발 (2-3일)
- [ ] `MajorDetailTemplate.tsx` 컴포넌트
- [ ] `JobDetailTemplate.tsx` 컴포넌트
- [ ] Phase 1 필드 활용한 섹션 구성
- [ ] Tailwind CSS 스타일링

### Phase 2.3: 전체 마이그레이션 (1일)
- [ ] 1,424개 전공 캐시 생성
- [ ] 587개 직업 캐시 생성
- [ ] 성능 벤치마크

### Phase 3-6: 사용자 기여 시스템 (추후)
- [ ] 로그인 시스템 (Cloudflare Access)
- [ ] 편집 UI
- [ ] 버전 히스토리
- [ ] AI 콘텐츠 생성

---

## 💡 핵심 인사이트

### ✅ 위키피디아/나무위키의 성공 비결

1. **동적 생성 + 캐싱**: 정적 사이트의 속도 + 동적 사이트의 유연성
2. **템플릿 시스템**: 하나의 틀로 수백만 페이지 관리
3. **버전 기반 캐시 무효화**: 수동 재생성 불필요
4. **사용자 기여 친화적**: 편집 시 해당 페이지 캐시만 무효화

### ✅ CareerWiki에 적용

- ✅ **템플릿 수정**: 버전만 올리면 자동 반영
- ✅ **데이터 업데이트**: 캐시 무효화로 자동 재생성
- ✅ **사용자 기여**: 편집 시 해당 페이지만 재생성
- ✅ **확장성**: 페이지 100만 개도 문제없음

---

## 🔗 관련 문서

- [ARCHITECTURE.md](./ARCHITECTURE.md) - 전체 시스템 아키텍처
- [PROJECT_STATUS.md](./PROJECT_STATUS.md) - 현재 프로젝트 상태
- [DEVELOPMENT_ROADMAP.md](./DEVELOPMENT_ROADMAP.md) - 개발 로드맵

---

**작성:** CareerWiki Development Team  
**최종 업데이트:** 2025-11-06
