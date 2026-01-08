# GAPS / TODO / NEXT ACTIONS

## GAP 목록
- 관측/알림 미구성 → 영향 높음 → 해결: Workers/Pages Analytics, 에러 알림 설정, ETA 1d
- 레이트리밋/보안 헤더 미정 → 영향 중 → 해결: per-IP rate limit, CF WAF 룰, ETA 1d
- 백업/DR 미정 → 영향 중 → 해결: D1 export 스케줄+R2 백업, ETA 2d
- API 실측/헬스체크 부재 → 영향 중 → 해결: synthetic + cron 헬스체크, ETA 0.5d
- SEO robots/sitemap 미확인 → 영향 중 → 해결: robots.txt/sitemap 생성 배포, ETA 0.5d
- Analytics/제품 지표 미정 → 영향 중 → 해결: 이벤트 스키마 정의, ETA 1d
- 샘플 응답/테스트 케이스 부족 → 영향 중 → 해결: contract 테스트/fixture 저장, ETA 1d

## 바로 실행 가능한 Top 10
1) wrangler secrets/KV/Images 키 인벤토리 및 불필요 키 회수
2) Cloudflare Pages 빌드/배포 로그 수집·공유 링크 확보
3) `/api/jobs`, `/api/majors` 샘플 호출 로그 저장 (status/latency/샘플 페이로드)
4) robots.txt, sitemap.xml 생성·배포
5) Workers/Pages Analytics 활성화, 알림 웹훅 설정
6) 오류 로깅 표준화(구조화 로그) + 경고 임계치 설정
7) D1 백업 스크립트 작성 및 주기 설정
8) 레이트리밋 미들웨어 또는 CF WAF rate rule 적용
9) ETL 품질 리포트 재계산(결측/중복 TOP N) 및 대시보드화
10) prod/preview 헬스체크·uptime 모니터 설정

