# R46 cycle 보고 (2026-06-13)

## 요약
- 범위: 렌즈착색기조작원 ~ 루핑지가공반장 (25건)
- KPI: **1533 → 1557 (+24)** — 예상치(1533+24, 로더조종사 dup 1건 반영) 정확 일치
- max master rev: 18909 → 18962
- 검증(master-verify-cycle): 25/25 marker OK, distinct 전건 ≥10(FAIL게이트 통과), FAIL 0(수정 후), WARN 9(urlUnverified 거짓양성류)
- 부작용: baseline 이탈 0, sal/wage 미접촉, 명단 밖 직업 0
- 실행: Workflow `wf_7c8632da-ef2` (parallel 25, sonnet) — 환경 도구 매핑 첫 적용

## cross-check: 로더조종사(J03) 기처리 dup
- latest content rev = `[sidebar-fill]`(18226), 직전 = `[job-data-master] enhance`(16365, distinct 11/minor) → sidebar-fill skip 규칙상 **이미 KPI(1533)에 카운트됨**
- master_list 고정 사전할당 경계 유지 위해 치환하지 않고 force-enhance(distinct 11→20) → net KPI +0
- ∴ 이번 cycle net 증가 = +24 (사전 선언 후 실측 일치)

## 검증 FAIL 2건 → 수정 완료
| 직업 | 죽은 URL | 수정 | 수정 rev | audit |
|---|---|---|---|---|
| 로봇공정시뮬레이션기술자 | exitbasic.com 스마팩토리…(404) | exitbasic 로봇공학자(200)로 교체+본문 일반화 | 18961 | clean |
| 로스터조작원 | haccp.or.kr/site/main/home(404 root) | ko.wikipedia.org/wiki/HACCP(200)로 4필드 교체 | 18962 | 0 FAIL |
- 수정세션 1차 session limit 사망(POST 0건, DB 실측 후 재spawn — 중복 0)

## 25직업 검증 결과 (distinct / totalE / class / audit)
| slug | distinct | totalE | class | audit |
|---|---:|---:|---|---|
| 렌즈착색기조작원 | 17 | 27 | niche | WARN(hrd timeout) |
| 렌즈하드코팅원 | 11 | 22 | niche | WARN(tls×2) |
| 로더조종사 | 20 | 33 | niche | WARN(tls×2) |
| 로봇공정시뮬레이션기술자 | 20 | 43 | major | clean(fix) |
| 로봇동작생성연구원 | 19 | 27 | major | PASS |
| 로봇지능개발자 | 20 | 35 | major | PASS |
| 로봇하드웨어설계기술자 | 19 | 35 | major | PASS |
| 로스터조작원 | 17 | 28 | niche | clean(fix) |
| 로켓터보펌프시험원 | 22 | 35 | niche | PASS |
| 로터리스크린날염기운전원 | 20 | 31 | niche | WARN(tls) |
| 로프강사 | 18 | 31 | major | PASS |
| 로프제작기보전원 | 19 | 31 | niche | PASS |
| 롤러관리원 | 21 | 29 | niche | WARN(tls) |
| 롤러날염기운전원 | 15 | 32 | niche | WARN(tls) |
| 롤러날염반장 | 17 | 23 | niche | WARN(tls×2) |
| 롤러성형원 | 15 | 30 | niche | PASS |
| 롤러소제원 | 18 | 26 | niche | PASS |
| 롤러압착기조작원 | 13 | 27 | niche | PASS |
| 롤러연마원 | 18 | 34 | niche | WARN(tls) |
| 롤러피복원 | 20 | 22 | niche | PASS |
| 롤링기조작원 | 16 | 28 | niche | PASS |
| 롤벤딩원 | 17 | 25 | niche | PASS |
| 롤회전원 | 20 | 33 | niche | PASS |
| 루터기조작원 | 15 | 33 | niche | WARN(indeed 403) |
| 루핑지가공반장 | 18 | 29 | niche | PASS |

## 환경 적립
- jobs 테이블에 `unified_career_json` 컬럼 **없음** → admin KPI = marker + sidebar-fill skip CTE COUNT(쿼리 메모리 갱신함). 페르소나·문서의 "UCJ NOT NULL" 표현은 marker 기준으로 해석.
- 25 enhance 오케스트레이션을 Workflow(parallel, model:sonnet)로 첫 실행 — 단일 완료 통지 + 동시성 캡으로 깔끔. 검증·KPI는 dispatcher가 결정적 스크립트로 별도 실측(자가보고 불신 원칙 유지).

## 다음
- R47 (시작=루핑지가공반장 다음). go 대기.
