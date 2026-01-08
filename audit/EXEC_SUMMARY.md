# Executive Summary

- 기준시각(KST): 2025-12-10T15:58:34+09:00 (`Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz"`)
- 브랜치/커밋: main @ 767edb5 (dirty: 변경·신규·삭제 다수)  
  증거: `git status -sb`, `git log -1 --oneline`
- 배포 타겟: Cloudflare Pages + Workers, 출력물 `dist/`  
  최근 빌드/배포 로그: 미수집(Cloudflare Pages 콘솔 접근 필요) → FOLLOW-UP  
  증거: `wrangler.jsonc` (`pages_build_output_dir`, `nodejs_compat`)
- 템플릿 버전: MAJOR 266 / JOB 182 / HOWTO 81 / GUIDE 1  
  증거: `src/constants/template-versions.ts`
- ISR 적용: `/job/:slug`, `/major/:slug` → D1 캐시 + 버전 무효화  
  증거: `src/index.tsx` (`getOrGeneratePage` 호출), `src/utils/page-cache.ts`

## 되는 것 (기능/데이터/운영)
1) ISR 캐시 시스템 동작 코드 존재, 캐시 헤더 설정 포함 (`src/utils/page-cache.ts`).  
2) 직업/전공 템플릿 및 병합 로직 문서화 (`docs/JOB_DATA_MERGE_LOGIC.md`, `docs/ETL_FIELD_MAPPING.md`).  
3) 이름 매핑·관련 직업/전공 연계 ETL 설계 (`docs/ETL_CURRENT_STATE.md`).  
4) 이미지 필드 스키마 및 Cloudflare Images 계획 수립 (`docs/IMAGE_STORAGE_PLAN.md`).  
5) 로컬 개발 프로필(PM2) + wrangler pages dev 설정 (`ecosystem.config.cjs`).

## 안 되는 것 / 미확인
- p95 지연, 에러율, 빌드시간, 크롤링 성공률: UNKNOWN (관측/로그 부재).  
- 레이트리밋/큐/백오프 정책: UNKNOWN.  
- 실배포 도메인/SSL/방화벽 현재 상태: UNKNOWN.  
- 비밀/토큰 관리(OAuth/Secrets) 검증: UNKNOWN.  
- DB 결측 상위 필드 최신 값: UNKNOWN.

## 품질 지표 스냅샷 (부분 갱신)
- 샘플 응답 실측:  
  - `/api/jobs?keyword=개발&page=1&perPage=5` → status 200, time 4.2336s, content-length 4478 | 증거: `evidence/sample_api_jobs.txt`
  - `/api/majors?keyword=컴퓨터&page=1&perPage=5` → status 200, time 0.4053s, content-length 6557 | 증거: `evidence/sample_api_majors.txt`
  - `/job/software-developer` → status 200, Cache-Control public,max-age=86400…, X-Template-Version 182 | 증거: `evidence/sample_page_job.txt`
- 빌드 시간, p95 API 지연, 에러율, 크롤링 성공률, DB 결측 TOP N → UNKNOWN (관측/대시보드 없음)

## 리스크 Top 5
| 리스크 | 영향 | 가능성 | 완화 상태 |
| --- | --- | --- | --- |
| 템플릿 버전 미증가로 캐시 갱신 실패 | 높음 | 중 | 버전 증가 체크리스트 필요 |
| 관측/알림 부재 | 높음 | 높음 | Workers/Pages Analytics, 알림 미구성 |
| 비밀/접근통제 미확인 | 높음 | 중 | secrets 인벤토리/회수 필요 |
| 데이터 품질 최신 검증 부재 | 중 | 중 | ETL 재실행+품질 리포트 필요 |
| DR/백업/레이트리밋 부재 | 중 | 중 | 정책/도구 미구성 |

## 다음 검사 필요 포인트 (증거/작업 경로)
1) wrangler secrets 목록·KV/Images 키 확인 → Cloudflare Dashboard.  
2) Cloudflare Pages 빌드/배포 로그 수집 → Pages 프로젝트 콘솔.  
3) 실 배포 URL 헬스체크(prod/preview) → README 링크 확인 후 curl.  
4) API 샘플 응답 확보 (`/api/jobs`, `/api/majors`) → 로컬/preview 호출 로그 저장.  
5) D1 백업/스냅샷 설정 확인 → CF D1 콘솔/문서.

