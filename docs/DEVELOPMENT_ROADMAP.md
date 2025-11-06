# CareerWiki 개발 로드맵

## 🔍 **순서 결정의 핵심 원칙**

### ✅ **의존성 기반 순서 (Dependency-First)**
```
기반 시스템 → 데이터 → 기능 → 고도화
```

### ❌ **잘못된 순서 예시**
```
데이터 마이그레이션 → 로그인 구축 → 편집 시스템
                      ↑
                      문제: 데이터 스키마 변경 필요 시 전체 재작업!
```

---

## 🏗️ **제안: 4단계 점진적 구축**

## Phase 0: 아키텍처 기반 구축 (현재)
**기간**: 1일  
**목표**: 모든 후속 작업의 기반이 되는 스키마와 문서 정립

### Task 0.1: D1 스키마 최종 설계
**이유**: 모든 기능이 이 스키마에 의존

```sql
-- 한 번만 제대로 설계하면 나중에 변경 불필요
CREATE TABLE wiki_pages (...)      -- 페이지 저장
CREATE TABLE users (...)           -- 로그인 시스템용
CREATE TABLE user_contributions (...) -- 편집 시스템용
CREATE TABLE ai_generated_content (...) -- AI 분석기용
```

**체크리스트:**
- [ ] `migrations/0003_wiki_architecture.sql` 작성
- [ ] 로그인 시스템 연동 필드 포함 (`user_id`, `editor_id`)
- [ ] 편집 시스템 필드 포함 (`status`, `reviewed_by`)
- [ ] AI 분석기 필드 포함 (`ai_generated_content` 테이블)
- [ ] 버전 관리 필드 포함 (`version`, `revisions`)

### Task 0.2: 핵심 문서 업데이트
**우선순위 1 (바로 업데이트):**
- [ ] `README.md` - 새 아키텍처 반영
- [ ] `ARCHITECTURE.md` (신규) - 시스템 설계 문서
- [ ] `API_INTEGRATION.md` (신규) - API 필드 매핑 문서

**우선순위 2 (Phase 1 시작 전):**
- [ ] `CONTRIBUTING.md` - 편집 시스템 가이드
- [ ] `DEVELOPMENT.md` - 개발 환경 설정

---

## Phase 1: 데이터 완전성 확보 (핵심!)
**기간**: 2-3일  
**목표**: 모든 API 필드를 빠짐없이 수집하고 병합

### 왜 이게 먼저?
```
✅ 장점:
- 로그인/편집 시스템은 이 데이터를 "보여주고 수정"하는 것
- 데이터가 불완전하면 나중에 편집 시스템도 수정 필요
- AI 분석기도 완전한 데이터가 있어야 제대로 작동

❌ 나중에 하면:
- 편집 시스템 구축 → 데이터 필드 추가 → 편집 UI 재작업
- AI 분석기 구축 → 데이터 부족 → AI 프롬프트 재작성
```

### Task 1.1: API 필드 완전 매핑
**산출물**: `docs/API_INTEGRATION.md`

```markdown
# API 통합 문서

## 커리어넷 학과정보 API
| 필드명 | 타입 | 설명 | 수집 여부 | D1 저장 위치 |
|--------|------|------|----------|-------------|
| majorSeq | string | 학과 시퀀스 | ✅ | careernet_id |
| major | string | 학과명 | ✅ | name |
| summary | string | 학과 개요 | ✅ | api_data_json.summary |
| aptitude | string | 적성 및 흥미 | ✅ | api_data_json.aptitude |
| courseList | array | 전공 교과목 | ⚠️ 확인 필요 | - |
| certificate | array | 관련 자격증 | ⚠️ 확인 필요 | - |
...
```

### Task 1.2: 시딩 스크립트 개선
- [ ] 모든 필드 수집 확인
- [ ] 재시딩 (1,435개 전공 + 587개 직업)
- [ ] 검증 스크립트 실행

### Task 1.3: 데이터 병합 로직
- [ ] 커리어넷 ↔ 고용24 자동 매칭
- [ ] 수동 매핑 테이블 생성
- [ ] 병합 결과 검증

**산출물**: 완전한 데이터를 가진 D1 데이터베이스

---

## Phase 2: 정적 위키 페이지 생성 (프로토타입)
**기간**: 2-3일  
**목표**: 10개 페이지로 새 아키텍처 검증

### 왜 프로토타입?
```
✅ 장점:
- 전체 마이그레이션 전에 문제 발견
- 로그인/편집 시스템 개발 중 실제 페이지로 테스트 가능
- 병렬 작업 가능 (내가 페이지 생성, 정우님이 로그인 설계 검토)

❌ 바로 전체 하면:
- 2,022개 페이지 생성 → 문제 발견 → 전체 재생성 (시간 낭비)
```

### Task 2.1: 페이지 빌더 구현
```typescript
class PageBuilder {
  async buildWikiPage(slug: string): Promise<WikiPage> {
    // API 데이터 → HTML 섹션 생성
    // 사용자 기여 슬롯 추가 (빈 상태)
    // AI 콘텐츠 슬롯 추가 (빈 상태)
  }
}
```

### Task 2.2: 프로토타입 페이지 생성
**10개 샘플 페이지:**
- 전공 5개: 컴퓨터공학과, 간호학과, 경영학과, 건축학과, 의예과
- 직업 5개: 소프트웨어개발자, 간호사, 변호사, 의사, 교사

### Task 2.3: 라우팅 변경 및 A/B 테스트
```typescript
// 프로토타입 페이지만 정적 위키로 제공
app.get('/major/:slug', async (c) => {
  const slug = c.req.param('slug')
  const prototypePages = ['컴퓨터공학과', '간호학과', ...]
  
  if (prototypePages.includes(slug)) {
    // 정적 위키 페이지
    return serveStaticWikiPage(slug)
  } else {
    // 기존 SSR (fallback)
    return serveSSRPage(slug)
  }
})
```

**검증 항목:**
- [ ] 성능 비교 (SSR vs 정적)
- [ ] SEO 메타태그 정상
- [ ] 데이터 표시 완전성
- [ ] 사용자 기여 슬롯 위치 확인

---

## Phase 3: 로그인 시스템 구축
**기간**: 2-3일  
**목표**: 사용자 인증 및 권한 관리

### 왜 이 시점?
```
✅ 이제 할 수 있는 것:
- 데이터 완전 (Phase 1)
- 프로토타입 페이지 존재 (Phase 2)
- 로그인 후 편집 UI 테스트 가능

⚠️ 이전에 하면:
- 테스트할 페이지가 없음 (SSR 페이지에 편집 기능 추가는 비효율)
```

### Task 3.1: 인증 시스템 선택
**옵션:**

**Option A: Cloudflare Access (추천)**
- 장점: 무료, 빠름, Cloudflare 네이티브
- 단점: 커스터마이징 제한

**Option B: Clerk**
- 장점: 풍부한 UI, 소셜 로그인
- 단점: 유료 (월 $25)

**Option C: Auth.js (NextAuth)**
- 장점: 오픈소스, 완전 제어
- 단점: 구현 시간 ↑

### Task 3.2: D1 users 테이블 활용
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT UNIQUE NOT NULL,
  nickname TEXT,
  role TEXT DEFAULT 'user' CHECK(role IN ('user', 'editor', 'admin')),
  created_at INTEGER NOT NULL
);
```

### Task 3.3: 권한 미들웨어
```typescript
// 로그인 유저만 접근
const requireAuth = async (c, next) => {
  const user = await getAuthUser(c)
  if (!user) return c.redirect('/login')
  c.set('user', user)
  await next()
}

// 편집 권한 확인
const requireEditor = async (c, next) => {
  const user = c.get('user')
  if (!['editor', 'admin'].includes(user.role)) {
    return c.json({ error: 'Forbidden' }, 403)
  }
  await next()
}
```

---

## Phase 4: 편집 시스템 구축
**기간**: 3-4일  
**목표**: 사용자가 페이지를 편집하고 기여할 수 있는 시스템

### Task 4.1: 편집 UI
```html
<!-- 로그인 유저에게만 표시 -->
<div class="edit-section" data-section="reviews">
  <button onclick="editSection('reviews')">
    <i class="fas fa-edit"></i> 졸업생 후기 추가
  </button>
</div>

<!-- 편집 모달 -->
<div id="edit-modal">
  <textarea id="content"></textarea>
  <button onclick="submitContribution()">제출</button>
</div>
```

### Task 4.2: 편집 API
```typescript
// POST /api/contributions
app.post('/api/contributions', requireAuth, async (c) => {
  const user = c.get('user')
  const { pageSlug, sectionName, content } = await c.req.json()
  
  // 기여 저장
  await db.prepare(`
    INSERT INTO user_contributions 
    (page_slug, section_name, content, user_id, status)
    VALUES (?, ?, ?, ?, 'pending')
  `).bind(pageSlug, sectionName, content, user.id).run()
  
  // 업데이트 큐에 추가
  await queuePageUpdate(pageSlug, [sectionName])
  
  return c.json({ success: true })
})
```

### Task 4.3: 관리자 검토 대시보드
```
/admin/contributions
- 대기 중인 기여 목록
- 승인/거부 버튼
- 승인 시 자동으로 페이지 업데이트
```

---

## Phase 5: 전체 마이그레이션 (프로토타입 검증 후)
**기간**: 1-2일  
**목표**: 2,022개 모든 페이지 정적 위키로 전환

### Task 5.1: 전체 페이지 생성
```bash
npm run build:all-wiki-pages
# 1,435 전공 + 587 직업 = 2,022 페이지
```

### Task 5.2: 라우팅 완전 전환
```typescript
// 모든 페이지 정적 위키로 제공
app.get('/major/:slug', serveStaticWikiPage)
app.get('/job/:slug', serveStaticWikiPage)
```

### Task 5.3: 레거시 SSR 제거
- [ ] 기존 템플릿 함수 deprecated
- [ ] SSR 라우트 제거
- [ ] 코드 정리

---

## Phase 6: AI 분석기 고도화
**기간**: 3-5일  
**목표**: AI로 부족한 데이터 자동 생성

### Task 6.1: AI 콘텐츠 생성기
```typescript
class AiContentGenerator {
  async generateCareerPath(major: string): Promise<string> {
    // Claude/GPT API 호출
    const prompt = `
      전공: ${major}
      
      이 전공의 졸업 후 진로 경로를 3가지 제시해주세요:
      1. 대기업 취업
      2. 스타트업
      3. 대학원 진학
      
      각 경로별로 필요한 역량과 예상 연봉을 포함해주세요.
    `
    
    return await callAI(prompt)
  }
}
```

### Task 6.2: AI 콘텐츠 삽입
```typescript
// 페이지 빌드 시 AI 콘텐츠 섹션 추가
const aiContent = await aiGenerator.generateCareerPath(major.name)

await db.prepare(`
  INSERT INTO ai_generated_content
  (page_slug, section_name, content_type, content, model, status)
  VALUES (?, 'career_path', 'career_path', ?, 'claude-3', 'approved')
`).bind(major.slug, aiContent).run()
```

### Task 6.3: AI 콘텐츠 검증 UI
```
/admin/ai-content
- AI 생성 콘텐츠 검토
- 수정/재생성 버튼
- 신뢰도 점수 표시
```

---

## 📊 **전체 타임라인**

```
Week 1:
├─ Day 1: Phase 0 (아키텍처 기반)
├─ Day 2-3: Phase 1 (데이터 완전성) ← 가장 중요!
└─ Day 4-5: Phase 2 (프로토타입)

Week 2:
├─ Day 1-2: Phase 3 (로그인 시스템)
├─ Day 3-5: Phase 4 (편집 시스템)
└─ Day 6-7: Phase 5 (전체 마이그레이션)

Week 3:
└─ Day 1-5: Phase 6 (AI 분석기)
```

**총 소요 시간**: 2-3주

---

## 🎯 **병렬 작업 가능 지점**

### Week 1 (Phase 1-2 진행 중)
정우님이 할 수 있는 것:
- [ ] 로그인 시스템 기술 선택 (Cloudflare Access vs Clerk vs Auth.js)
- [ ] 편집 UI 디자인 스케치
- [ ] 관리자 대시보드 요구사항 정리

### Week 2 (Phase 3-4)
저와 병렬로:
- 저: 로그인 시스템 구현
- 정우님: 편집 UI 디자인 검토 및 피드백

---

## ✅ **결론: 최적 순서**

### **추천 순서 (Option C)**
```
Phase 0 (1일) → Phase 1 (2-3일) → Phase 2 프로토타입 (2-3일) 
→ 검증 → Phase 3 로그인 (2-3일) → Phase 4 편집 (3-4일) 
→ Phase 5 전체 마이그레이션 (1-2일) → Phase 6 AI (3-5일)
```

### **왜 이 순서?**
1. ✅ **Phase 0 먼저**: 모든 기능의 기반 (스키마)
2. ✅ **Phase 1 먼저**: 데이터가 완전해야 모든 기능이 제대로 작동
3. ✅ **Phase 2 프로토타입**: 전체 마이그레이션 전 문제 발견
4. ✅ **Phase 3-4**: 프로토타입 페이지로 로그인/편집 테스트
5. ✅ **Phase 5**: 검증 완료 후 전체 마이그레이션
6. ✅ **Phase 6**: 모든 기반이 갖춰진 후 AI 고도화

---

## 🚀 **지금 바로 시작할 작업**

### 제가 지금 할 것:
1. [ ] `docs/ARCHITECTURE.md` 작성
2. [ ] `docs/API_INTEGRATION.md` 작성 (고용24 문서 분석)
3. [ ] `migrations/0003_wiki_architecture.sql` 작성
4. [ ] `README.md` 업데이트

### 정우님이 검토해주시면 좋을 것:
- 로그인 시스템: Cloudflare Access vs Clerk vs Auth.js?
- 편집 권한: 모든 로그인 유저 vs 승인된 편집자만?
- AI 콘텐츠: 자동 승인 vs 관리자 검토?

---

## 🌐 도메인 연동 타이밍 계획 (careerwiki.org)

### ⏰ 권장 타이밍: Phase 2 완료 후

**이유:**

#### ❌ 지금 연동하면 안 되는 이유
1. **콘텐츠가 완성되지 않음**
   - 현재: API 데이터만 있고, SSR 방식 (느림, ~500ms)
   - 사용자 경험이 나쁨
   - 구글 SEO에 나쁜 첫인상 (Page Speed Score 낮음)

2. **아키텍처 전환 중**
   - Phase 2에서 Static Wiki로 전환 예정
   - 빠른 로딩 (~50ms) 달성 후 연동
   - 도메인 연동 후 대규모 변경하면 혼란스러움

3. **데이터 완전성 미검증**
   - Phase 1에서 데이터 갭 발견 가능
   - 불완전한 데이터로 런칭하면 신뢰도 하락

#### ✅ Phase 2 완료 후 연동하면
- **완성도**: 정적 페이지 생성 완료 (2,022개 페이지)
- **성능**: 빠른 로딩 속도 (~50ms)
- **데이터**: 완전한 API 데이터 + 병합 완료
- **SEO**: 최적화 완료 (meta tags, canonical URLs)
- **첫인상**: 좋은 사용자 경험으로 신뢰도 확보

---

### 📅 예상 일정

| Phase | 기간 | 완료 예상 | 작업 내용 |
|-------|------|----------|----------|
| Phase 0 | 1일 | 2025-01-06 | ✅ 아키텍처 기반 완료 |
| Phase 1 | 2-3일 | 2025-01-09 | 데이터 완전성 확보 |
| Phase 2 | 2-3일 | 2025-01-12 | Static Wiki 10개 페이지 프로토타입 |
| **🌐 도메인 연동** | **1시간** | **2025-01-12** | **careerwiki.org 연동** |
| Phase 3 | 2-3일 | 2025-01-15 | 로그인 시스템 구축 |
| Phase 4 | 3-4일 | 2025-01-19 | 편집 시스템 구축 |
| Phase 5 | 1-2일 | 2025-01-21 | 전체 마이그레이션 (2,022페이지) |
| Phase 6 | 3-5일 | 2025-01-26 | AI 분석기 통합 |

**총 예상 기간**: 2-3주

---

### 🚀 도메인 연동 절차 (Phase 2 완료 시)

#### 1. Cloudflare Pages Custom Domain 추가
```bash
# Wrangler CLI 사용
npx wrangler pages domain add careerwiki.org --project-name careerwiki-phase1

# 또는 Cloudflare Dashboard에서:
# Pages → careerwiki-phase1 → Custom domains → Add domain
```

#### 2. DNS 설정
Cloudflare Dashboard에서 DNS 레코드 추가:
```
Type: CNAME
Name: careerwiki.org (또는 @)
Content: careerwiki-phase1.pages.dev
Proxy status: Proxied (오렌지 구름 ☁️)
TTL: Auto
```

#### 3. SSL/TLS 설정 확인
- Cloudflare가 자동으로 SSL 인증서 발급 (Let's Encrypt)
- 5-10분 내 HTTPS 활성화
- 설정: Full (strict) 모드 권장

#### 4. 연동 확인
```bash
# DNS 전파 확인 (최대 24시간, 보통 5-10분)
dig careerwiki.org

# HTTPS 연결 확인
curl -I https://careerwiki.org

# 브라우저에서 확인
# https://careerwiki.org
```

#### 5. SEO 설정 업데이트
```bash
# wrangler.jsonc 업데이트
{
  "name": "careerwiki-phase1",
  "pages_build_output_dir": "./dist",
  // 환경 변수에 canonical URL 추가
  "vars": {
    "CANONICAL_URL": "https://careerwiki.org"
  }
}

# Deploy
npm run deploy:prod
```

#### 6. Google Search Console 등록
- https://search.google.com/search-console
- 속성 추가: careerwiki.org
- 소유권 확인 (DNS TXT 레코드 또는 HTML 파일)
- Sitemap 제출: https://careerwiki.org/sitemap.xml

---

### ⚠️ 중요 체크리스트 (도메인 연동 전)

**Phase 2 완료 시 확인사항:**
- [ ] 10개 프로토타입 페이지 로딩 속도 <100ms
- [ ] 모든 페이지에 meta title, description 존재
- [ ] canonical URL 올바르게 설정
- [ ] 404 페이지 구현
- [ ] robots.txt 설정
- [ ] sitemap.xml 생성
- [ ] 모바일 반응형 확인
- [ ] 주요 브라우저 테스트 (Chrome, Safari, Firefox)

**도메인 연동 후 모니터링:**
- [ ] Google PageSpeed Insights 점수 >90
- [ ] Core Web Vitals 통과 (LCP <2.5s, FID <100ms, CLS <0.1)
- [ ] Cloudflare Analytics 활성화
- [ ] Error rate <1%
- [ ] 평균 응답 시간 <100ms

---

### 💡 참고사항

#### 도메인 연동 비용
- **Cloudflare Pages Custom Domain**: 무료
- **SSL 인증서**: 무료 (자동 발급)
- **DNS 서비스**: 무료 (Cloudflare 사용 시)
- **도메인 등록비**: 연간 $12-15 (별도)

#### 테스트 도메인 (임시)
Phase 2 개발 중에는 Cloudflare Pages 기본 도메인 사용:
```
https://careerwiki-phase1.pages.dev
https://main.careerwiki-phase1.pages.dev (main 브랜치)
```

---

이 순서가 적절한가요? 수정하고 싶은 부분이 있나요?
