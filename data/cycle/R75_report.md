# R75 Cycle Report (2026-07-10)

## 요약
- **직업 25건** (보온단열재성형원~보험금지급관리원), rev 20531~20581
- **KPI 2282** (2257 + 25 정확 일치, admin 단일진실 쿼리 이중 실측)
- **완료 게이트: 25/25 marker OK · FAIL 0** (verify-cycle 전수)
- 운영: foreground 5배치(sonnet) 동시 spawn + dispatcher 직접 결정적 검증. opus 수정세션 생략(FAIL 대상 0).
- 사고 0. baseline 이탈 0. sal/wage 미접촉. 명단 밖 무접촉.

## 배치 결과 (25/25)
| 배치 | 직업 | rev | distinct | totalE | class | audit |
|---|---|---|---:|---:|---|---|
| B1 | 보온단열재성형원 | 20534 | 11 | 20 | niche | CLEAN |
| B1 | 보온병진공기조작원 | 20559 | 11 | 20 | niche | CLEAN |
| B1 | 보온함석원 | 20575 | 19 | 22 | major | CLEAN |
| B1 | 보육교사보조원 | 20579 | 19 | 22 | major | WARN:urlUnverified(1) |
| B1 | 보일러검사원 | 20581 | 18 | 22 | major | CLEAN |
| B2 | 보일러관체제작원 | 20539 (fix 20536→20539 OMEGA) | 13 | 23 | niche | CLEAN |
| B2 | 보일러설치반장 | 20545 | 11 | 21 | niche | CLEAN |
| B2 | 보일러설치보조원 | 20549 | 12 | 20 | niche | CLEAN |
| B2 | 보일러설치원 | 20551 | 11 | 20 | niche | CLEAN |
| B2 | 보일러수리원 | 20557 | 11 | 21 | niche | CLEAN |
| B3 | 보일러시험원 | 20532 (fix 20531→20532 orderViolation) | 21 | 21 | niche | CLEAN |
| B3 | 보일러제작반장 | 20541 | 20 | 20 | niche | CLEAN |
| B3 | 보일러조작원 | 20547 | 19 | 21 | niche | CLEAN |
| B3 | 보조연기자 | 20567 | 18 | 20 | major | CLEAN |
| B3 | 보조출연자섭외원 | 20573 | 18 | 20 | major | WARN:urlUnverified(1) |
| B4 | 보증보험구상사무원 | 20538 | 19 | 20 | major | CLEAN |
| B4 | 보청기검사원 | 20555 | 12 | 20 | niche | CLEAN |
| B4 | 보청기셀제작원 | 20561 | 12 | 20 | niche | CLEAN |
| B4 | 보청기수리원 | 20565 | 10 | 20 | niche | CLEAN |
| B4 | 보청기조립원 | 20571 | 10 | 20 | niche | CLEAN |
| B5 | 보험계약심사원 | 20543 | 19 | 28 | major | CLEAN |
| B5 | 보험고객불만처리사무원 | 20553 | 19 | 26 | major | WARN:urlUnverified(1) |
| B5 | 보험금관리원 | 20563 | 19 | 23 | major | WARN:urlUnverified(1) |
| B5 | 보험금심사원 | 20569 | 19 | 23 | major | WARN:urlUnverified(1) |
| B5 | 보험금지급관리원 | 20577 | 19 | 23 | major | WARN:urlUnverified(1) |

## WARN 6건 (전부 urlUnverified, 비차단) — dispatcher 독립 재검
- **m.nhlife.co.kr** (보험 4직업): dispatcher node fetch **200/10307 실증 → 거짓양성 확정** (audit 스크립트 schannel/conn000 TLS 이슈).
- **privacy.go.kr** (보조출연자섭외원): node 독립확정 불가(.go.kr TLS 재협상 패턴). 워커는 WebFetch로 실콘텐츠 확인 보고.
- **kicce.re.kr** (보육교사보조원): 원본 URL에 `editMode=ADD` 파라미터 포함 — 게시판 작성모드 URL 냄새. **다음 cycle 정리 후보로 기록**(WARN이라 비차단).

## 검증 방법
- admin KPI 단일진실 쿼리 2회 실측 (전 2257 → 후 2282, +25 정확)
- master-verify-cycle --cycle=75 전수 (25/25 marker OK, FAIL 0)
- WARN URL 3종 dispatcher 직접 node fetch 재확인
