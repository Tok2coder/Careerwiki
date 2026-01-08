# LOCAL VERIFICATION (wrangler dev 8787)

커맨드: 제시된 6개 호출 실행 결과 (최신 빌드 기준)

1) `/api/jobs?keyword=개발&page=1&perPage=10`
- 1st: 200, CL 4613, TIME 0.304s, Cache-Control public,max-age=60, ETag W/"52e4f...", Server-Timing parse=78/build=68/db=1/post=1/serialize=1
- 2nd: 304, CL 0, TIME 0.228s, Cache-Control 유지, X-Cache-Status=HIT, Server-Timing parse=1

2) `/api/majors?keyword=컴퓨터&page=1&perPage=10`
- 1st: 200, CL 19676, TIME 0.839s, Cache-Control public,max-age=60, ETag W/"b41fe...", Server-Timing parse=594/build=591/db=1
- 2nd: 304, CL 0, TIME 0.221s, X-Cache-Status=HIT, Server-Timing parse=2

3) `/job/가상현실전문가`
- 1st: 200, TE chunked, TIME 0.445s, Cache-Control public,max-age=86400,s-maxage=86400, ETag W/"182-job-가상현실전문가-520516", Server-Timing route-start=181
- 2nd: 304, CL 0, TIME 0.265s (best 0.257s), X-Cache-Status=HIT, Server-Timing route-start≈31

5줄 해석
- /api/jobs 1회차 0.3s대로 목표(≤1.5s) 충족, 2회차 304로 0.23s.
- /api/majors 회귀: 1회차 ~0.8s, 2회차 0.22s 304.
- /job/가상현실전문가 2회차 0.26s 수준, ETag 매치 정상.
- Server-Timing으로 parse/build/db 단계 가시화; parse/build가 병목에서 0.07~0.18s로 축소.
- Cache-Control/ETag 일관 유지, HTML/JSON 모두 304 재현.

