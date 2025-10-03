# CareerWiki - AI 진로 분석 플랫폼

## 프로젝트 개요
- **이름**: CareerWiki (careerwiki.org)
- **목표**: AI 기반 개인 맞춤형 진로 분석과 전공/직업 위키 플랫폼
- **주요 기능**: 
  - AI 진로 분석기 (직업 추천 / 전공 추천)
  - 직업 · 전공 위키 (고용24 + 커리어넷 통합 데이터)
  - 통합 상세 페이지 SSR (canonical/OG/JSON-LD/데이터 출처 패널)
  - HowTo 가이드 (진로 설정 방법론)
  - 실시간 검색 및 데이터 연동

## 🌐 서비스 URL
- **개발 서버**: https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev
- **프로덕션**: https://careerwiki.org (배포 예정)
- **GitHub**: https://github.com/[username]/careerwiki (연동 예정)
- **API Status**: ✅ 커리어넷 API 실시간 연동 중 (인증키 활성)

## 📊 데이터 아키텍처

### 데이터 모델
```typescript
type DataSource = 'CAREERNET' | 'GOYONG24'

type SourceIdentifiers = {
  careernet?: string
  goyong24?: string
}

type UnifiedMajorDetail = {
  id: string
  name: string
  summary?: string
  categoryName?: string
  relatedMajors?: string[]
  mainSubjects?: string[]
  licenses?: string[]
  universities?: MajorUniversityInfo[]
  recruitmentStatus?: MajorRecruitmentStat[]
  relatedJobs?: string[]
  jobProspect?: string
  salaryAfterGraduation?: string
  employmentRate?: string
  sources: DataSource[]
  sourceIds: SourceIdentifiers
}

type UnifiedJobDetail = {
  id: string
  name: string
  summary?: string
  category?: { code?: string; name?: string }
  classifications?: { large?: string; medium?: string; small?: string }
  salary?: string
  prospect?: string
  satisfaction?: string
  duties?: string
  way?: string
  relatedMajors?: JobRelatedEntity[]
  relatedJobs?: JobRelatedEntity[]
  relatedCertificates?: string[]
  educationDistribution?: EducationDistribution
  majorDistribution?: MajorDistribution
  sources: DataSource[]
  sourceIds: SourceIdentifiers
}
```

### 데이터 파이프라인 & 스토리지
- **통합 파이프라인**: CareerNet + 고용24 API 래퍼 → `mergeJobProfiles` / `mergeMajorProfiles`
- **SSR 템플릿**: `renderUnifiedJobDetail`, `renderUnifiedMajorDetail`, JSON-LD (`createJobJsonLd`, `createMajorJsonLd`)
- **소스 상태 관리**: `SourceStatusRecord`로 호출 결과/오류/스킵 사유 기록
- **Cloudflare D1**: 사용자 데이터, 분석 결과 저장 (예정)
- **Cloudflare KV**: 캐싱, 세션 관리 (예정)
- **External API**: 커리어넷 & 고용24 오픈 API (환경 변수 `CAREER_NET_API_KEY`, `GOYONG24_API_KEY`)

## 🚀 현재 완료된 기능

### ✅ 핵심 기능
1. **홈페이지**
   - Google 스타일 미니멀 검색 UI
   - 인기 직업/전공 동적 표시
   - 메뉴 네비게이션

2. **API 시스템** (커리어넷 · 고용24 실시간 연동)
   - `/api/majors` - **학과 정보 검색** (통합 소스 상태 포함)
   - `/api/majors/:id` - **학과 상세 정보** (통합 소스별 partial + 상태)
   - `/api/jobs` - **직업 정보 검색** (통합 결과 + 카테고리)
   - `/api/jobs/:id` - **직업 상세 정보** (통합 소스별 partial + 상태)
   - `/api/categories` - 카테고리 정보

3. **SSR 상세 페이지**
   - `/job/:slug` → `getUnifiedJobDetail` + `renderUnifiedJobDetail`
   - `/major/:slug` → `getUnifiedMajorDetail` + `renderUnifiedMajorDetail`
   - canonical/OG 메타, JSON-LD, 데이터 출처 패널, 공통 fallback UI

4. **프론트엔드**
   - 반응형 디자인 (모바일/태블릿/PC)
   - 다크 테마 + 그라디언트 UI
   - Glass morphism 디자인
   - 동적 데이터 로딩

### ✅ 기술 스택
- **Backend**: Hono Framework on Cloudflare Workers
- **Frontend**: Vanilla JavaScript + TailwindCSS
- **API**: CareerNet OpenAPI 통합
- **Development**: PM2, Wrangler, Vite

## 📌 주요 API 엔드포인트

### 학과 정보 API
```bash
# 학과 검색
GET /api/majors?keyword=컴퓨터&page=1&perPage=20

# 학과 상세
GET /api/majors/1001
```

### 직업 정보 API
```bash
# 직업 검색
GET /api/jobs?keyword=개발&category=100060&page=1&perPage=20

# 직업 상세
GET /api/jobs/2001

# 카테고리 목록
GET /api/categories
```

## 🔄 미구현 기능 및 다음 단계

### 🔜 구현 예정
1. **목록 페이지 SSR & SEO 고도화**
   - `/job`, `/major` 검색 결과 SSR + hydrated client 필터링
   - SERP freshness 유지 전략 (신규 데이터 동기화 스케줄러)
   - 인기 섹션 prefetch 및 캐싱 레이어 설계

2. **AI 분석 기능**
   - Claude/GPT API 통합
   - 사용자 입력 폼 구현
   - 맞춤형 분석 리포트 생성

3. **데이터베이스**
   - Cloudflare D1 스키마 정의 및 마이그레이션 관리
   - 통합 데이터 캐싱/버전 관리
   - 검색 히스토리 및 사용자 액션 로깅

4. **사용자 기능**
   - 로그인/회원가입 (OAuth)
   - 마이페이지 및 분석 결과 저장/공유

5. **위키 협업 & 프리미엄**
   - 사용자 기여 시스템 + 편집 이력 관리
   - 결제 시스템 (Stripe) 및 Pro 플랜
   - B2C/B2B 맞춤 리포트 고급 분석

## 💻 개발 환경 설정

### 로컬 개발
```bash
# 의존성 설치
npm install

# 개발 서버 실행
npm run build
pm2 start ecosystem.config.cjs

# API 키 설정 (.env)
CAREER_NET_API_KEY=your_api_key_here
```

### 배포
```bash
# Cloudflare Pages 배포
npm run deploy

# 프로덕션 배포
npm run deploy:prod
```

## 🛠️ 기술 스택

- **Runtime**: Cloudflare Workers/Pages
- **Framework**: Hono 4.0
- **Language**: TypeScript
- **Styling**: TailwindCSS
- **Icons**: Font Awesome
- **Build**: Vite
- **Deploy**: Wrangler
- **Process Manager**: PM2

## 📈 프로젝트 상태

- **개발 진행률**: 50%
- **API 통합**: ✅ **완료** (커리어넷 직업 API 실시간 연동)
- **UI/UX**: ✅ 기본 완료
- **AI 기능**: ⏳ 예정
- **데이터베이스**: ⏳ 예정
- **배포**: ⏳ 예정

### 🔥 최근 업데이트
- ✅ 통합 직업/전공 상세 페이지 SSR 적용 (canonical/OG/JSON-LD 포함)
- ✅ CareerNet + 고용24 통합 병합 로직 및 소스 상태 패널 추가
- ✅ 공통 fallback UI/에러 처리 및 데이터 출처 서머리 제공
- ✅ 헤더/검색/네비게이션 UI 고도화 & wrangler dev 환경 안정화

## 🎯 추천 다음 작업

1. **긴급도 높음**
   - `/job`, `/major` 목록 SSR 및 검색 파라미터 canonical 전략 확립
   - SERP freshness 지표 정의 및 데이터 동기화 스케줄 설계
   - JSON-LD 검사 (Rich Result Test) + Lighthouse SEO 점검 자동화

2. **중요도 높음**
   - Cloudflare D1 스키마/마이그레이션 초안 작성 및 wrangler 워크플로 완성
   - 통합 데이터 캐싱 전략 수립 (KV/R2 여부 결정, TTL 정책)
   - API 응답 source diagnostics → 프론트 라벨링 연동

3. **향후 개선**
   - AI Analyzer 폼 → 백엔드 파이프라인 연결 (Claude/GPT)
   - 사용자 계정 및 즐겨찾기/히스토리 설계
   - 관측 가능성(로그/메트릭) 및 에러 어노테이션 정비

## 📞 연락처

프로젝트 관련 문의: [이메일 주소]

---

*Last Updated: 2025-10-03*