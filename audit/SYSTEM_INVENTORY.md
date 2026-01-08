# SYSTEM INVENTORY

## 레포/모듈/구조
- 주요 경로: `src/index.tsx`(엔트리), `src/templates/*`, `src/utils/page-cache.ts`, `public/static/*`, `dist/`(빌드 산출물)
- 데이터/ETL 문서·스크립트: `docs/ETL_CURRENT_STATE.md`, `docs/JOB_DATA_MERGE_LOGIC.md`, `docs/ETL_FIELD_MAPPING.md`, `scripts/`, `migrations/*.sql`
- 정적 자산: `public/static/api-client.js`, `public/static/perf-metrics.js` 등
- 코드베이스 LOC: 미계측 → UNKNOWN (필요 시 cloc)

## 의존성 매트릭스 (주요)
- 런타임/프레임워크: hono 4.9.9, @cloudflare/workers-types 4.20251008.0
- 빌드/도구: wrangler 4.4.0, vite 6.3.5, tsx 4.20.6, typescript 5.9.3, miniflare 4.20251011.2
- 유틸: axios 1.12.2, csv-parse 6.1.0, jose 6.1.2
- EOL 여부: 미검토 → UNKNOWN
증거: `package.json`

## 환경 (local/dev/stage/prod)
- local/dev: `wrangler pages dev dist --d1=careerwiki-jobs --local --ip 0.0.0.0 --port 3000` (PM2 profile)  
  증거: `ecosystem.config.cjs`
- prod: Cloudflare Pages + Workers, D1 `careerwiki-db` 바인딩  
  증거: `wrangler.jsonc`
- preview: README에 latest preview URL 기재 (b5797c35.careerwiki-phase1.pages.dev)  
- 차이점: local D1 로컬 스토리지, prod D1 본 DB; secrets/vars 설정 상태 미확인 → UNKNOWN

## 릴리즈 프로세스
- 빌드/배포: `npm run build` → `npm run deploy` (wrangler pages deploy dist)  
  증거: `package.json`
- 브랜치 전략: main 기준, 현재 dirty (다수 변경/신규/삭제)  
- 태깅/롤백: 절차 미문서 → UNKNOWN

