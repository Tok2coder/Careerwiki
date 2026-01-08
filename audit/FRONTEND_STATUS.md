# FRONTEND STATUS

## 스택/라우팅/상태
- Hono JSX SSR, Tailwind CDN, 최소 JS(`public/static/api-client.js`, `perf-metrics.js`)  
- 라우팅: SSR 라우트 기반 `/job/:slug`, `/major/:slug`, `/howto/:slug`, `/feedback`, `/onboarding` 등  
- 상태관리: 없음(SSR+소량 JS)
증거: `src/index.tsx`, `public/static/*`

## 디자인 시스템
- Tailwind utility + 커스텀 wiki-* 클래스, 파셜 nav/헤더 포함  
증거: `src/templates/partials/*`

## 핵심 페이지 구현률
- 직업 상세: 구현 (`src/templates/unifiedJobDetail.ts`) ✅
- 전공 상세: 구현 (`src/templates/unifiedMajorDetail.ts`) ✅
- 검색: 라우트 존재 (`/job`, `/major` 검색) | 템플릿 상세 미검토 → 부분 확인
- HowTo: 템플릿 존재 (`src/templates/howtoDetail.ts`) ✅
- 비교/커뮤니티: 커뮤니티(피드백) 존재, 비교 페이지 명시적 템플릿 없음 → UNKNOWN

## 렌더링 전략
- SSR + ISR(D1) for job/major (템플릿 버전 기반 캐시)  
- CSR 미사용, JS는 탭 전환·퍼포먼스 계측 등 보조

## Web Vitals
- LCP/CLS/FID 측정값 및 대시보드 없음 → UNKNOWN (Pages/Workers Analytics 필요)

