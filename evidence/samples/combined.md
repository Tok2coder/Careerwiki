# Evidence Combined (local wrangler dev)

- Collected at: 2025-12-10T15:58:34+09:00
- Env: `wrangler pages dev dist --local --port 3000`
- Note: Production/preview domain 미제공 → 모든 샘플은 localhost 기준. 배포 도메인 제공 시 재수집 가능.

## 1) /api/jobs 샘플
Source: `evidence/sample_api_jobs.txt`
```
status: 200
time_total: 4.233593s
headers: access-control-allow-origin: *, content-type: application/json, content-length: 4478
```

## 2) /api/majors 샘플
Source: `evidence/sample_api_majors.txt`
```
status: 200
time_total: 0.405294s
headers: access-control-allow-origin: *, content-type: application/json, content-length: 6557
```

## 3) /job/software-developer (HTML, 캐시 헤더 확인)
Source: `evidence/sample_page_job.txt`
```
status: 200
cache-control: public, max-age=86400, s-maxage=86400, stale-while-revalidate=604800
x-template-version: 182
x-cache-status: MISS
content-type: text/html; charset=UTF-8
```

## Pending (prod/preview 필요)
- 실 배포 도메인에서 동일 3건 재수집 (헤더/ETag/시간 포함) → 요청 시 즉시 수행
- robots.txt, sitemap.xml 배포 및 접근 로그
- Rate limit(429 재현) 캡처, KV 바인딩 정보
- D1 백업 로그/파일 메타, Analytics 대시보드 캡처

