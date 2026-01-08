# OPEN QUESTIONS / UNKNOWN
- Prod/preview 도메인 미제공 → 실 배포 캐시/ETag/시간/robots/sitemap/GSC 확인 불가.
- Analytics/모니터링: Workers/Pages Analytics, p95/에러 카운트 대시보드 미확인(콘솔 접근 필요).
- Secrets/바인딩 인벤토리: wrangler secrets, KV/R2/Images 리스트 미확인(대시보드/CLI 필요).
- D1 백업/DR: export 스케줄, R2 업로드, SHA/로그 미확인.
- 이미지 샘플 10건: 실제 업로드/프롬프트/메타 없음.
- /job If-None-Match → 304 미재현(로컬 dev). prod에서 확인 필요 또는 dev 모드 해제 조건 검토.

