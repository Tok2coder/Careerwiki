# INFRA / DEPLOY / OBSERVABILITY

## 호스팅/배포 파이프라인
- Cloudflare Pages + Workers, 출력물 `dist/`  
- 배포 명령: `npm run deploy` → `wrangler pages deploy dist`  
증거: `package.json`, `wrangler.jsonc`

## 시크릿 관리/권한
- wrangler secrets/KV/Images 토큰 설정 상태 미기록 → UNKNOWN (CF Dashboard 확인 필요)
- nodejs_compat 활성화 | 증거: `wrangler.jsonc`

## 도메인/SSL/CDN/방화벽
- Pages 기본 CDN, custom domain 계획(careerwiki.org) 문서화  
- 실제 도메인/SSL/WAF 설정 미확인 → UNKNOWN

## 로그/모니터링/알림
- Workers/Pages Analytics 설정 기록 없음 → UNKNOWN  
- perfMetricsService 존재하나 수집/대시보드 불명 → UNKNOWN

## 백업/DR
- D1 백업/스냅샷 전략 미확인 → UNKNOWN  
- 권장: 주기적 export→R2, 복구 연습 필요

## 비용 스냅샷
- 추정: Workers/Pages 무료티어, Images 옵션 $5/mo (문서 기준)  
- 실제 월간 비용 데이터 없음 → UNKNOWN

