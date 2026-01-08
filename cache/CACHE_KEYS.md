# CACHE KEYS (DEV 기준)

## HTML (ISR)
- Seed: `pageType:slugNFC:templateVersion`
- ETag: `W/"<version>-<pageType>-<slug>-<len>"`
- Invalidation: 템플릿 버전 변경 시 자동, slug 단위 재생성.

## API (/api/jobs, /api/majors)
- Seed: `templateVersion:dataVersion:keywordNFC:page:perPage[:category]`
- ETag: `weakETag(seed)` → `W/"<sha1(seed)>"`
- Cache-Control: `public, max-age=60, stale-while-revalidate=30`
- 304 조건: If-None-Match 헤더와 seed 기반 ETag 매치(weak/quote 무시 비교).

## 한글 슬러그/쿼리
- 입력: `decodeURIComponent(...).normalize('NFC')`
- 출력: `encodeURI/encodeURIComponent` 로 path/loc 생성
- Seed/ETag에도 NFC 적용으로 일관성 유지.

