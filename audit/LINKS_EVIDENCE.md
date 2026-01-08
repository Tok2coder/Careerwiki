# LINKS / EVIDENCE

- git 상태/커밋: `git status -sb`, `git log -1 --oneline` → main @ 767edb5 (dirty)
- 배포/런타임 설정: `evidence/wrangler.jsonc`
- Dev 실행: `ecosystem.config.cjs` (PM2, `wrangler pages dev dist --d1=careerwiki-jobs --port 3000`)
- 의존성: `evidence/package.json` (hono 4.9.9, wrangler 4.4.0, typescript 5.9.3, vite 6.3.5)
- 템플릿 버전: `src/constants/template-versions.ts` (MAJOR 266 / JOB 182 / HOWTO 81 / GUIDE 1)
- ISR 로직: `evidence/page-cache.ts` (Cache-Control, stale-while-revalidate, _t bypass)
- ISR 적용 라우트: `evidence/index.tsx` (/job/:slug, /major/:slug → getOrGeneratePage)
- 데이터 스키마: `evidence/D1_DATABASE_STRUCTURE.md`
- 병합 로직: `evidence/JOB_DATA_MERGE_LOGIC.md`, `evidence/ETL_FIELD_MAPPING.md`
- ETL 현황/매핑: `evidence/ETL_CURRENT_STATE.md`
- API 가이드: `API_ENDPOINTS_GUIDE.md`
- SEO/AEO 분석: `evidence/SEO_AEO_GEO_ANALYSIS.md`
- 이미지 파이프라인: `evidence/IMAGE_STORAGE_PLAN.md`
- 마이그레이션/이슈: `evidence/MIGRATION_TO_CURSOR.md`
- 샘플 응답: `evidence/sample_api_jobs.txt`, `evidence/sample_api_majors.txt`, `evidence/sample_page_job.txt`

