# LOCAL PROBES (BEFORE → AFTER, wrangler dev 8787)

## /api/jobs?keyword=개발&page=1&perPage=10
- Before: 200, TIME~6.3s, no 304, Cache-Control public,max-age=60, Server-Timing: search-start~6s
- After-1st: 200, TIME=8.24s, CL=7444, Cache-Control public,max-age=60, ETag W/"52e4f...", Server-Timing parse=8006/build=7973/db=2/post=2/serialize=2
- After-2nd: 304, TIME=0.22s, Cache-Control public,max-age=60, ETag W/"52e4f...", X-Cache-Status=HIT, Server-Timing parse=1
- 해석: 캐시 미스 시 여전히 8s대(LIKE 경로 병목). ETag로 2회차 304 달성 → db/post/serialize 스킵. FTS5 적용 및 MATCH 전환이 필요.

## /api/majors?keyword=컴퓨터&page=1&perPage=10
- Before: 200, TIME~0.60s, no 304
- After-1st: 200, TIME=0.71s, CL=19676, Cache-Control public,max-age=60, ETag W/"b41fe...", Server-Timing parse=1/build=0/db=3/post=0/serialize=0
- After-2nd: 304, TIME=0.24s, Cache-Control public,max-age=60, ETag W/"b41fe...", X-Cache-Status=HIT, Server-Timing parse=1
- 해석: majors는 1회차도 0.7s 수준. 2회차 304로 바로 응답.

## /job/가상현실전문가
- Before: 200, TIME~0.66s, 2회차도 200 (ETag 비교 약함)
- After-1st: 200, TIME=0.55s, Cache-Control public,max-age=86400,s-maxage=86400, ETag W/"182-job-가상현실전문가-520516", X-Template-Version=182, Server-Timing route-start=~30ms
- After-2nd: 304, TIME=0.27s, Cache-Control 동일, ETag 동일, X-Cache-Status=HIT
- 해석: HTML도 If-None-Match 비교 강화(matchETag)로 304 재현.

## /robots.txt
- After: 200, CL=67, body includes Sitemap pointing to local base.

## /sitemap.xml
- After: 200, CL=~250, <loc>에 encodeURI 처리된 한국어 슬러그 포함.

### 5줄 요약
- API/HTML 모두 ETag+304 동작 확인(2회차 304).
- Server-Timing 단계 분리로 parse/build/db/post/serialize 각각 확인 가능; jobs는 parse/build 구간 8s로 병목.
- 한글 슬러그 NFC+encodeURI 적용, sitemap에 인코딩된 슬러그 노출.
- Cache-Control 유지(HTML 86400, API 60s) + X-Cache-Status=HIT 헤더로 캐시 상태 확인 가능.
- FTS5 dev 가상테이블 준비 완료; MATCH 전환/인덱스 다이어트가 다음 단계.

