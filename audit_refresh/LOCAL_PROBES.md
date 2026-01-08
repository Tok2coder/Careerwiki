# LOCAL PROBES (wrangler dev :8787)

## Calls
- GET /api/jobs?keyword=개발&page=1&perPage=10  
  - Status 200, TIME 6.28s, Content-Length 7444  
  - Cache-Control: public, max-age=60, stale-while-revalidate=30  
  - Server-Timing: search-start=6056ms, serialize=0ms (병목: search 단계)

- GET /api/majors?keyword=컴퓨터&page=1&perPage=10  
  - Status 200, TIME 0.60s, Content-Length 19676  
  - Cache-Control: public, max-age=60, stale-while-revalidate=30  
  - Server-Timing: search-start=367ms

- GET /job/software-developer (1st)  
  - Status 200, TIME 0.66s, ETag: W/"182-job-software-developer-84118"  
  - Cache-Control: public, max-age=86400, s-maxage=86400, stale-while-revalidate=604800  
  - Server-Timing: route-start=442ms, fetch-start=275ms, db-fetch=1ms, render-start=1ms, render-done=1ms

- GET /job/software-developer (If-None-Match same ETag)  
  - Result: 200 (304 미재현, dev 캐시 히트 아님)  
  - Server-Timing: route-start=383ms, fetch-start=261ms, db-fetch=3ms, render-start=3ms, render-done=2ms

- GET /robots.txt  
  - Status 200, Content-Length 67

- GET /sitemap.xml  
  - Status 200, Content-Length 250

## Notes
- /api/jobs search 단계가 6s로 가장 큰 병목 → 검색 쿼리/인덱스/프리컴퓨트 후보.
- ETag는 생성되나 dev 모드에서 304 불발(If-None-Match 전달). prod 모드에서 재확인 필요.
- Server-Timing 헤더가 API/HTML에 표시되어 병목 구간 확인 가능.

