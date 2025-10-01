# CareerWiki - AI 진로 분석 플랫폼

## 프로젝트 개요
- **이름**: CareerWiki (careerwiki.org)
- **목표**: AI 기반 개인 맞춤형 진로 분석과 전공/직업 위키 플랫폼
- **주요 기능**: 
  - AI 진로 분석기 (직업 추천 / 전공 추천)
  - 직업 위키 (1000+ 직업 정보)
  - 전공 위키 (500+ 전공 정보)
  - HowTo 가이드 (진로 설정 방법론)
  - 실시간 검색 및 데이터 연동

## 🌐 서비스 URL
- **개발 서버**: https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev
- **프로덕션**: https://careerwiki.org (배포 예정)
- **GitHub**: https://github.com/[username]/careerwiki (연동 예정)

## 📊 데이터 아키텍처

### 데이터 모델
```typescript
// 학과 정보
interface Major {
  majorSeq: string;        // 학과 코드
  major: string;           // 학과명
  summary: string;         // 학과 소개
  university?: string;     // 대학 목록
  department?: string;     // 학과 계열
  salaryAfterGraduation?: string;  // 졸업 후 평균 연봉
  employmentRate?: string; // 취업률
  relatedJob?: string;     // 관련 직업
  aptitude?: string;       // 적성 유형
}

// 직업 정보
interface Job {
  jobdicSeq: string;       // 직업 코드
  jobName: string;         // 직업명
  summary: string;         // 직업 소개
  aptdType?: string;       // 적성유형
  jobCategoryName?: string; // 직업 분류
  avgSalary?: string;      // 평균 연봉
  salaryRange?: string;    // 연봉 범위
  jobOutlook?: string;     // 직업 전망
  relatedMajor?: string;   // 관련 학과
  requiredEducation?: string; // 요구 학력
  requiredCertification?: string; // 필요 자격증
  employmentTrend?: string; // 고용 동향
}
```

### 스토리지 서비스
- **Cloudflare D1**: 사용자 데이터, 분석 결과 저장 (예정)
- **Cloudflare KV**: 캐싱, 세션 관리 (예정)
- **External API**: 한국교육개발원 커리어넷 오픈API 연동
  - 학과정보 API: 실시간 학과 정보 제공
  - 직업정보 API: 실시간 직업 정보 제공

## 🚀 현재 완료된 기능

### ✅ 핵심 기능
1. **홈페이지**
   - Google 스타일 미니멀 검색 UI
   - 인기 직업/전공 동적 표시
   - 메뉴 네비게이션

2. **API 시스템**
   - `/api/majors` - 학과 정보 검색
   - `/api/majors/:id` - 학과 상세 정보
   - `/api/jobs` - 직업 정보 검색
   - `/api/jobs/:id` - 직업 상세 정보
   - `/api/categories` - 카테고리 정보

3. **프론트엔드**
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
1. **AI 분석 기능**
   - Claude/GPT API 통합
   - 사용자 입력 폼 구현
   - 맞춤형 분석 리포트 생성

2. **데이터베이스**
   - Cloudflare D1 데이터베이스 설정
   - 사용자 분석 결과 저장
   - 검색 히스토리 관리

3. **사용자 기능**
   - 로그인/회원가입 (OAuth)
   - 마이페이지
   - 분석 결과 저장/공유

4. **위키 기능**
   - 직업/전공 상세 페이지
   - 사용자 기여 시스템
   - 편집 이력 관리

5. **프리미엄 기능**
   - 결제 시스템 (Stripe)
   - Pro 플랜 (₩9,900/월)
   - 고급 AI 분석

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

- **개발 진행률**: 40%
- **API 통합**: ✅ 완료
- **UI/UX**: ✅ 기본 완료
- **AI 기능**: ⏳ 예정
- **데이터베이스**: ⏳ 예정
- **배포**: ⏳ 예정

## 🎯 추천 다음 작업

1. **긴급도 높음**
   - CareerNet API 키 발급 및 환경변수 설정
   - Cloudflare Pages 프로젝트 생성 및 배포
   - 도메인 (careerwiki.org) 연결

2. **중요도 높음**
   - AI API (Claude/GPT) 통합
   - D1 데이터베이스 스키마 설계
   - 사용자 인증 시스템

3. **향후 개선**
   - 성능 최적화 (캐싱)
   - SEO 최적화
   - 분석 대시보드

## 📞 연락처

프로젝트 관련 문의: [이메일 주소]

---

*Last Updated: 2025-10-01*