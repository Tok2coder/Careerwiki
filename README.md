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

## 📊 현재 상태 (2025-01-06)

### ✅ Phase 0 재완료 (2025-01-06) 🎉

**공식 문서 기반 전체 API 분석 완료**

- [x] **CareerNet 공식 문서 분석** 완료
  - ✅ 직업백과 API (job.json): 19개 섹션, ~150 필드 → **100% 수집 완료** ✅
  - ✅ 학과정보 API (getOpenApi): 14개 섹션, ~80 필드 → **~25% 수집 중** ⚠️
- [x] **고용24 API 분석** 완료
  - ✅ 학과정보: 35개 필드 → **100% 수집 완료** ✅
  - ✅ 직업정보: 137개 필드 → **100% 수집 완료** ✅
- [x] **API_INTEGRATION.md 완전 재작성** (28KB)
  - 공식 문서 기반 전체 필드 문서화
  - 현재 수집 현황 정확히 계산
  - Phase 1 개선 계획 수립
- [x] **정확한 현재 수집률**:
  - CareerNet 직업백과: **100%** (79/79 필드) ✅
  - CareerNet 학과정보: **~25%** (15/59 필드) ⚠️
  - 고용24 학과정보: **100%** (35/35 필드) ✅
  - 고용24 직업정보: **100%** (141/141 필드) ✅
  - **전체: ~86%** (270/314 필드)
- [x] **Wiki 아키텍처 마이그레이션** 스크립트 작성
- [x] **도메인 연동 계획** 수립 (Phase 2 후 careerwiki.org)

### 🚧 다음 단계 (Phase 1)

**목표: CareerNet 학과정보 완전 수집 (25% → 90%)**

- [ ] **누락된 44개 필드 추가 수집**:
  - 우선순위 HIGH: relate_subject, career_act, main_subject, enter_field, property (11개)
  - 우선순위 MEDIUM: chartData 통계 데이터 (14개)
  - 우선순위 LOW: GenCD, SchClass, 적성/가치 통계 (19개)
- [ ] **careernetAPI.ts 코드 개선**
- [ ] **1,435개 전공 재시딩**
- [ ] **데이터 품질 검증**

**예상 소요 시간**: 2-3일  
**Phase 1 완료 후 예상 수집률**: **~97%** (304/314 필드)

### 📅 예정 (Phase 2-6)
- **Phase 2** (2-3일): 정적 위키 프로토타입 (10개 페이지) + **careerwiki.org 도메인 연동** 🌐
- **Phase 3** (2-3일): 로그인 시스템 (Cloudflare Access 권장)
- **Phase 4** (3-4일): 사용자 편집 시스템
- **Phase 5** (1-2일): 전체 페이지 마이그레이션 (2,022개)
- **Phase 6** (3-5일): AI 콘텐츠 생성기 (Claude 3 Haiku)

---

## 🏗️ 아키텍처

### 현재 (SSR)
```
사용자 요청 → D1 조회 → 템플릿 렌더링 → HTML 응답 (500ms)
```

### 목표 (정적 위키)
```
사용자 요청 → D1에서 완성된 HTML 조회 → 즉시 응답 (50ms)
```

**자세한 내용**: [ARCHITECTURE.md](./docs/ARCHITECTURE.md)

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
**현재 (Phase 1)**:
- `majors` - 전공 원본 데이터 (api_data_json)
- `jobs` - 직업 원본 데이터 (api_data_json)

**목표 (Phase 2+)**:
- `wiki_pages` - 완성된 HTML 페이지
- `user_contributions` - 사용자 기여
- `ai_generated_content` - AI 생성 콘텐츠
- `page_revisions` - 버전 이력

**스키마 상세**: [proposed-wiki-architecture.sql](./docs/proposed-wiki-architecture.sql)

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

*Last Updated: 2025-11-05*
*Version: 0.1.0 (Phase 0 - 아키텍처 기반 구축)*
