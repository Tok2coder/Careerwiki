# BACKEND RUNTIME STATUS

## 런타임/프레임워크
- Cloudflare Workers + Hono 4.9.9 (TypeScript, nodejs_compat)  
증거: `package.json`, `wrangler.jsonc`

## 미들웨어 파이프라인
- cors, renderer, serveStatic(/static/*), authMiddleware (전역)  
증거: `src/index.tsx` (상단 미들웨어 설정)

## 주요 라우트/API (요약)
- HTML: `/job/:slug`, `/major/:slug`, `/howto/:slug`, `/feedback`, `/onboarding`, `/auth/*`, `/admin/*` 등  
- ISR 적용: `/job/:slug`, `/major/:slug` → `getOrGeneratePage`  
증거: `src/index.tsx`
- 서비스 헬퍼: profileDataService, commentService, feedbackService 등 다수 의존 (상세 스키마 미문서)

## 캐시 정책
- ISR D1 캐시, 템플릿 버전 매칭 시 캐시 HIT 50ms, MISS 300ms (설계)  
- Cache-Control: public, max-age=86400, s-maxage=86400, stale-while-revalidate=604800  
- 개발/우회: dev 모드 no-cache, `_t` 파라미터로 BYPASS  
증거: `src/utils/page-cache.ts`

## 레이트리밋/큐/배치
- 구현/설정 미확인 → UNKNOWN

## 샘플 요청/응답 (수집 필요)
- 권장 테스트:  
  - `GET /api/jobs?keyword=개발&page=1&perPage=20`  
  - `GET /api/majors?keyword=컴퓨터&page=1`  
  - `GET /job/software-developer` (ISR 캐시 헤더 확인)  
- 현재 샘플 응답/로그 없음 → UNKNOWN

## 최근 에러로그 Top N
- 수집/대시보드 없음 → UNKNOWN (Workers/Pages Analytics 설정 필요)

