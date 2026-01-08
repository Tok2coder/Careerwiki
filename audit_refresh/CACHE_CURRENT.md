# CACHE CURRENT (현황)

## 페이지 캐시 (ISR)
- 키: slug + page_type + cache_version
- 저장소: D1 `wiki_pages`
- 헤더: Cache-Control `public, max-age=86400, s-maxage=86400, stale-while-revalidate=604800`
- ETag: `W/"<version>-<pageType>-<slug>-<len>"` (추가)
- 무효화: 템플릿 버전 변경, `invalidatePageCache`, 캐시 미스 시 재생성
- 코드: `src/utils/page-cache.ts`

## API 캐시
- 기본: 캐시 없음 → dev 미들웨어로 `public, max-age=60, stale-while-revalidate=30` 추가 (path `/api/*`, 미지정 시)
- ETag: 미적용 (요구 없음)
- 코드: `src/index.tsx` (apiCacheHintMiddleware)

## 정적 파일
- `/static/*` -> `serveStatic({ root: './public' })`
- Cache-Control: 기본 CF/Pages 동작 (코드 내 별도 설정 없음)

## 이미지
- 스키마 필드만 존재 (`image_url`, `image_alt`, `image_credits`), 실 사용/캐시 없음

## 무효화 트리거
- 템플릿 버전 증가 (`src/constants/template-versions.ts`)
- 수동 삭제 `invalidatePageCache`
- 캐시 미스/버전 불일치 시 재생성

