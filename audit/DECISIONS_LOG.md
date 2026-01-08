# DECISIONS LOG (최근 30일+과거 핵심)

1) 2025-11-06 — ISR 채택, D1 HTML 캐시 + 템플릿 버전 기반 무효화 (대안: 전체 SSG 리빌드)  
   이유: 빌드 시간 0초, 템플릿 수정 즉시 반영, 위키식 캐싱.  
   영향: 캐시 버전 관리 필수. 되돌림 조건: ISR 오류로 캐시 불능 시 SSG 폴백.  
   증거: `docs/FINAL_ARCHITECTURE_DECISION.md`, `docs/ISR_CACHE_EXPLAINED.md`

2) 2025-11-06 — 스택 확정: Cloudflare Workers+Pages+D1 (대안: Vercel/AWS)  
   이유: 비용/지연/엣지 배포 최적. 영향: nodejs_compat 필요.  
   증거: `docs/TECH_STACK_VALIDATION.md`

3) 2025-11-28 — 이름 매핑 시스템 도입(ETL, UI /similar-names)  
   이유: 유사명 병합 품질 개선. 영향: 매핑 적용 후 ETL 재실행 필요.  
   증거: `docs/ETL_CURRENT_STATE.md`

4) 2025-11-06 — GenSpark→Cursor 마이그레이션 후 serveStatic 복원 필요 결정  
   이유: JS 403 방지, 탭 기능 복구.  
   증거: `MIGRATION_TO_CURSOR.md`

5) 2025-01-20 — Job Sources 레이어드 아키텍처 확정  
   이유: 소스/정규화/병합/캐시 분리, 프로비넌스 확보.  
   증거: `docs/JOB_SOURCES_ARCHITECTURE.md`
# DECISIONS LOG (최근 30일+과거 핵심)

1) 2025-11-06 — ISR 채택, D1 HTML 캐시 + 템플릿 버전 기반 무효화 (대안: 전체 SSG 리빌드)  
   이유: 빌드 시간 0초, 템플릿 수정 즉시 반영, 위키식 캐싱.  
   영향: 캐시 버전 관리 필수. 되돌림 조건: ISR 오류로 캐시 불능 시 SSG 폴백.  
   증거: `docs/FINAL_ARCHITECTURE_DECISION.md`, `docs/ISR_CACHE_EXPLAINED.md`

2) 2025-11-06 — 스택 확정: Cloudflare Workers+Pages+D1 (대안: Vercel/AWS)  
   이유: 비용/지연/엣지 배포 최적. 영향: nodejs_compat 필요.  
   증거: `docs/TECH_STACK_VALIDATION.md`

3) 2025-11-28 — 이름 매핑 시스템 도입(ETL, UI /similar-names)  
   이유: 유사명 병합 품질 개선. 영향: 매핑 적용 후 ETL 재실행 필요.  
   증거: `docs/ETL_CURRENT_STATE.md`

4) 2025-11-06 — GenSpark→Cursor 마이그레이션 후 serveStatic 복원 필요 결정  
   이유: JS 403 방지, 탭 기능 복구.  
   증거: `MIGRATION_TO_CURSOR.md`

5) 2025-01-20 — Job Sources 레이어드 아키텍처 확정  
   이유: 소스/정규화/병합/캐시 분리, 프로비넌스 확보.  
   증거: `docs/JOB_SOURCES_ARCHITECTURE.md`

