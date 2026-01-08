# DATA FLOW (DEV, 로컬 기준)

```mermaid
flowchart TD
  A[수집: CareerNet/Work24 API] --> B[정규화: unified profiles]
  B --> C[병합: searchUnifiedJobs/majors]
  C --> D[D1: jobs, jobs_search_fts (dev)]
  D --> E[ISR cache: page-cache.ts (key: slug+templateVersion)]
  E --> F[응답 HTML (/job/:slug, /major/:slug)]
  C --> G[API 응답 (/api/jobs, /api/majors)]
```

- 슬러그 처리: `decodeURIComponent(param).normalize('NFC')` → 내부 처리 → 링크는 `encodeURI/encodeURIComponent` 로 재출력(한국어 안전).
- ISR: `getOrGeneratePage` → ETag/If-None-Match → 304 지원(HTML).
- API: ETag seed `templateVersion:dataVersion:keyword:page:perPage` → 304 지원(If-None-Match 매치 시 DB 스킵).
- Server-Timing: parse-query → build-sql → db-read → post-filter → serialize 단계별 ms 노출.
- FTS5 (dev 전용): `jobs_search_fts` (name, slug, unicode61) + insert/update/delete 트리거. LIKE 폴백 유지.

