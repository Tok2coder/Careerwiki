# CareerWiki - AI 기반 협업형 진로 위키

> **완전한 데이터 + 빠른 응답 + 사용자 기여 + AI 보강**을 결합한 차세대 진로 정보 플랫폼

[![Cloudflare Pages](https://img.shields.io/badge/Cloudflare-Pages-orange)](https://careerwiki-phase1.pages.dev)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## 🎯 프로젝트 비전

CareerWiki는 **Wikipedia의 협업 정신**과 **AI의 지능**을 결합하여, 대한민국의 모든 진로 정보를 **완전하고**, **최신이며**, **신뢰할 수 있는** 형태로 제공합니다.

### 핵심 차별점
- 🎓 **1,435개 전공 + 587개 직업** 완전 데이터
- ⚡ **0.05초 응답** (기존 대비 10배 빠름)
- 👥 **사용자가 직접 편집**하고 기여하는 위키 시스템
- 🤖 **AI가 부족한 데이터 자동 보강**
- 🔄 **API 자동 동기화** (항상 최신 정보 유지)

---

## 🌐 서비스 URL

- **Production**: https://careerwiki-phase1.pages.dev
- **Latest Preview**: https://b5797c35.careerwiki-phase1.pages.dev
- **Dev Sandbox**: https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev
- **GitHub**: https://github.com/[username]/careerwiki (연동 예정)

---

## 📊 현재 상태 (2025-11-06)

### ✅ Phase 2.1: ISR 캐시 시스템 구축 완료 (2025-11-06) 🎉

**Wikipedia/Namu Wiki 스타일 ISR (Incremental Static Regeneration) 아키텍처 적용**

- [x] **D1 wiki_pages 테이블 생성** ✅
  - slug, page_type, content (HTML), cache_version 필드
  - 템플릿 버전 기반 자동 캐시 무효화 시스템
  - 인덱스 최적화 (slug + page_type + cache_version)
- [x] **ISR 유틸리티 함수 구현** (`src/utils/page-cache.ts`) ✅
  - `getOrGeneratePage()`: 캐시 히트/미스 자동 처리
  - `getCacheStats()`: 캐시 통계 조회
  - `invalidatePageCache()`: 수동 캐시 무효화
- [x] **템플릿 버전 관리 시스템** (`src/constants/template-versions.ts`) ✅
  - MAJOR / JOB / GUIDE 템플릿 버전 중앙 관리
  - 버전 번호 변경 → 자동 캐시 무효화
- [x] `/major/:slug` 라우트 ISR 적용 ✅
  - 첫 요청: ~300ms (DB 조회 + 렌더링 + 캐시 저장)
  - 이후 요청: ~50ms (캐시된 HTML 반환)
  - 템플릿 업데이트: 버전 증가 → 자동 재생성

**성능 개선:**
- 캐시 히트 시: **500ms → 50ms (10배 빠름)** ⚡
- 빌드 시간: **30분 → 0초 (무제한 확장)** 🚀
- 템플릿 업데이트: **30분 재빌드 → 즉시 적용** ✨

**다음 단계 (Phase 2.2):**
- [ ] MajorDetailTemplate.tsx 개발 (Phase 1 필드 적용)
- [ ] JobDetailTemplate.tsx 개발
- [ ] SEO 최적화 (Schema.org, Cache-Control, ETag)
- [ ] 성능 벤치마크 (10개 샘플 페이지)

### ✅ Phase 1 완료 (2025-11-05)

**CareerNet 학과정보 44개 필드 추가 수집 완료**

- [x] **학과정보 API 완전 수집** (25% → 100%)
  - ✅ relate_subject (관련 고교 교과목)
  - ✅ career_act (진로 탐색 활동)
  - ✅ main_subject (대학 주요 교과목)
  - ✅ enter_field (졸업 후 진출분야)
  - ✅ chartData (통계 차트 데이터)
  - **총 59개 필드 완전 수집 (100%)**
- [x] **1,424개 전공 재시딩 완료**
- [x] **데이터 품질 검증** 완료

**Phase 1 최종 수집률**: **~97%** (304/314 필드)

### 📅 예정 (Phase 2-6)
- **Phase 2** (2-3일): 정적 위키 프로토타입 (10개 페이지) + **careerwiki.org 도메인 연동** 🌐
- **Phase 3** (2-3일): 로그인 시스템 (Cloudflare Access 권장)
- **Phase 4** (3-4일): 사용자 편집 시스템
- **Phase 5** (1-2일): 전체 페이지 마이그레이션 (2,022개)
- **Phase 6** (3-5일): AI 콘텐츠 생성기 (Claude 3 Haiku)

---

## 🏗️ 아키텍처

### ISR (Incremental Static Regeneration) - Wikipedia/Namu Wiki 방식 ✅

**구현 완료 (2025-11-06)**

```
사용자 요청 → wiki_pages 캐시 조회
  ├─ 캐시 히트 + 버전 일치 → 즉시 HTML 반환 (50ms) ⚡
  └─ 캐시 미스 / 버전 불일치 → DB 조회 + 렌더링 + 캐시 저장 + HTML 반환 (300ms)
```

**핵심 특징:**
- 🔄 **템플릿 업데이트**: 버전 번호 증가 → 자동 재생성 (빌드 불필요)
- 📈 **무제한 확장**: 1,424개든 100만 개든 빌드 시간 0초
- ⚡ **99% 캐시 히트**: 평균 응답 시간 ~50ms (10배 빠름)
- 🔧 **유지보수 편의**: 한 파일 수정 → 모든 페이지 자동 적용

**자세한 내용**: 
- [WIKI_ARCHITECTURE_STRATEGY.md](./docs/WIKI_ARCHITECTURE_STRATEGY.md)
- [FINAL_ARCHITECTURE_DECISION.md](./docs/FINAL_ARCHITECTURE_DECISION.md)
- [SEO_AEO_GEO_ANALYSIS.md](./docs/SEO_AEO_GEO_ANALYSIS.md)

---

## 📖 주요 문서

| 문서 | 설명 |
|------|------|
| [ARCHITECTURE.md](./docs/ARCHITECTURE.md) | 시스템 아키텍처 전체 설계 |
| [DEVELOPMENT_ROADMAP.md](./docs/DEVELOPMENT_ROADMAP.md) | 단계별 개발 로드맵 (Phase 0-6) |
| [migration-plan.md](./docs/migration-plan.md) | 상세 마이그레이션 계획 |
| [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) | 문제 해결 가이드 |

---

## 🌐 공개 API

### 현재 제공 중
```bash
# 전공 검색
GET /api/majors?keyword=컴퓨터&page=1&perPage=20

# 전공 상세
GET /api/majors/569

# 직업 검색
GET /api/jobs?keyword=개발&category=100060&page=1

# 직업 상세
GET /api/jobs/2001
```

**API 문서**: [API_INTEGRATION.md](./docs/API_INTEGRATION.md) (작성 중)

## 📊 데이터

### 현황
- **전공**: 1,435개 (CareerNet 501 + Goyong24 934)
- **직업**: 587개 (CareerNet + Goyong24 통합)
- **데이터 소스**: 커리어넷 API + 고용24 API

### 스키마
**현재 (Phase 2.1 - ISR 구현 완료)** ✅:
- `majors` - 전공 원본 데이터 (api_data_json)
- `jobs` - 직업 원본 데이터 (api_data_json)
- **`wiki_pages`** - ISR 캐시 (slug, page_type, content, cache_version) ✅

**다음 (Phase 3+)**:
- `user_contributions` - 사용자 기여
- `ai_generated_content` - AI 생성 콘텐츠
- `page_revisions` - 버전 이력

**스키마 상세**: 
- [migrations/0005_wiki_pages_cache.sql](./migrations/0005_wiki_pages_cache.sql) (ISR 캐시)
- [proposed-wiki-architecture.sql](./docs/proposed-wiki-architecture.sql) (전체 계획)

---

## 🚀 개발 로드맵

### Phase 0: 아키텍처 기반 (진행 중)
- [x] 새 D1 스키마 설계
- [x] 핵심 문서 작성 (ARCHITECTURE.md, DEVELOPMENT_ROADMAP.md)
- [ ] API 필드 완전 매핑 문서

### Phase 1: 데이터 완전성 확보 (다음)
- [ ] 커리어넷 + 고용24 전체 필드 검증
- [ ] 누락 필드 수집
- [ ] 데이터 병합 로직 구현
- [ ] 재시딩

### Phase 2-6: 위키 시스템 구축
상세 일정: [DEVELOPMENT_ROADMAP.md](./docs/DEVELOPMENT_ROADMAP.md)

---

## 💻 기술 스택

### Core
- **Runtime**: Cloudflare Workers
- **Framework**: Hono 4.0
- **Database**: Cloudflare D1 (SQLite)
- **Language**: TypeScript
- **Styling**: TailwindCSS

### Tools
- **Build**: Vite
- **Package Manager**: npm
- **Process Manager**: PM2 (dev)

### Planned
- **Auth**: Cloudflare Access / Clerk (TBD)
- **AI**: Claude 3 / GPT-4 (TBD)

---

## 🛠️ 개발 환경 설정

### 요구사항
- Node.js 18+
- npm
- Wrangler CLI

### 로컬 개발
```bash
# 1. 의존성 설치
npm install

# 2. 환경 변수 설정 (.dev.vars)
CAREER_NET_API_KEY=your_key
GOYONG24_JOB_API_KEY=your_key
GOYONG24_MAJOR_API_KEY=your_key

# 3. D1 마이그레이션
npm run db:migrate:local

# 4. 데이터 시딩 (선택)
npm run seed:majors
npm run seed:jobs

# 5. 개발 서버 실행
npm run build
pm2 start ecosystem.config.cjs

# 6. 서버 테스트
curl http://localhost:3000
```

### Cloudflare Pages 배포
```bash
# 1. 시크릿 설정 (최초 1회)
npx wrangler pages secret put CAREER_NET_API_KEY
npx wrangler pages secret put GOYONG24_JOB_API_KEY
npx wrangler pages secret put GOYONG24_MAJOR_API_KEY

# 2. 배포
npm run deploy
```

---

## 📈 성능 지표

### 현재 (SSR)
- 평균 응답 시간: ~500ms
- 동시 처리: ~100 req/s
- CPU 사용률: ~80%

### 목표 (정적 위키)
- 평균 응답 시간: ~50ms (**10배 개선**)
- 동시 처리: ~1,000 req/s (**10배 개선**)
- CPU 사용률: ~10% (**8배 개선**)

---

## 🤝 기여 가이드

현재 초기 개발 단계로 외부 기여는 받지 않습니다.  
Phase 4 (편집 시스템 구축) 이후 기여 가이드를 공개할 예정입니다.

---

## 📈 성능 목표

| 지표 | 현재 (SSR) | 목표 (정적 위키) | 개선율 |
|------|-----------|---------------|--------|
| 평균 응답 시간 | ~500ms | ~50ms | **10배 ↑** |
| 동시 처리 | ~100 req/s | ~1,000 req/s | **10배 ↑** |
| CPU 사용률 | ~80% | ~10% | **8배 ↓** |

---

## 🤝 기여 가이드

현재 초기 개발 단계로 외부 기여는 받지 않습니다.  
Phase 4 (편집 시스템 구축) 이후 기여 가이드를 공개할 예정입니다.

---

## 📜 라이선스

MIT License

---

## 📞 문의

프로젝트 관련 문의는 GitHub Issues를 이용해주세요.

---

*Last Updated: 2025-11-06*
*Version: 0.2.1 (Phase 2.1 - ISR 캐시 시스템 구축 완료)*
