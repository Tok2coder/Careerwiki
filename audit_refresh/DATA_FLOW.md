# DATA FLOW (현재 구현 요약)

```mermaid
flowchart TD
  A[외부 API\nCareerNet/Work24] --> B[정규화\nnormalized_payload]
  B --> C[병합 로직\nmergeJob/MajorProfiles]
  C --> D[jobs / majors\napi_data_json.merged]
  D --> E[ISR 캐시 조회\nwiki_pages]
  E -- 히트 --> H[HTML 응답 50ms]
  E -- 미스/버전불일치 --> F[템플릿 렌더(Hono JSX)]
  F --> G[wiki_pages 저장\ncache_version=templateVersion]
  G --> H
```

- 수집/정규화: `job_sources`/`major_sources`에 raw + normalized 저장 (docs: `evidence/ETL_FIELD_MAPPING.md`)
- 병합: 우선순위/중복제거 후 merged_profile_json 작성 (`evidence/JOB_DATA_MERGE_LOGIC.md`)
- DB: `jobs`, `majors` (merged), `wiki_pages`(HTML 캐시)
- 렌더/ISR: `getOrGeneratePage` → 버전 일치 시 D1 캐시 반환, 불일치 시 재생성 후 캐시 저장
- 응답: HTML은 Cache-Control 86400/604800, ETag(weak, version+slug+len)
- 이미지: 스키마에 `image_url`, `image_alt`, `image_credits` 필드 존재(미사용 상태), CDN 계획은 Cloudflare Images (`evidence/IMAGE_STORAGE_PLAN.md`)

