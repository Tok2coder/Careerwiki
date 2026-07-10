# R76 Cycle Report (2026-07-10)

## 요약
- **직업 25건** (보험금지급원~복층유리압착기조작원), rev 20583~20632
- **KPI 2307** (2282 + 25 정확 일치, admin 단일진실 쿼리 이중 실측)
- **완료 게이트: 25/25 marker OK · FAIL 0** (verify-cycle 전수)
- 🔴 **사고: 1차 5배치 전 세션 session limit(9pm 리셋) 동시 중단** → 부분 POST 5직업(landing KPI 2287) → `--resume=76`으로 완료 5직업 dup 가드 + 미완 20직업 재spawn → **25/25 복구, 중복 POST 0**
- 자가 fix 1회: B3 보험영업지원사무원 technKnow OMEGA(20602→20604, 규칙 내)
- opus 수정세션 생략(FAIL 대상 0). baseline 이탈 0, sal/wage 미접촉, 명단 밖 무접촉.

## 완료 5직업 (1차 landing, rev 20583~20591)
보험보유계약관리원, 보험영업기획원, 보험영업실적분석원, 복권사무원, 복합운송주선인 — resume 재처리 금지 가드 적용

## 재개 20직업 결과 (rev 20593~20632)
| 배치 | 직업 | rev | distinct | totalE | class | audit |
|---|---|---|---:|---:|---|---|
| B1 | 보험금지급원 | 20608 | 19 | 25 | major | CLEAN |
| B1 | 보험대리점소장 | 20614 | 19 | 29 | major | CLEAN |
| B1 | 보험동향분석원 | 20620 | 19 | 30 | major | CLEAN |
| B1 | 보험료수납원 | 20624 | 21 | 30 | major | CLEAN |
| B1 | 보험모집인 | 20630 | 21 | 26 | major | CLEAN |
| B2 | 보험사감독원 | 20595 | 21 | 21 | major | CLEAN |
| B2 | 보험사무지원사무원 | 20599 | 21 | 22 | major | WARN:urlUnverified(hanwhalife tls) |
| B2 | 보험시장분석원 | 20610 | 20 | 22 | major | CLEAN |
| B2 | 보험신계약담당원 | 20622 | 19 | 23 | major | WARN:urlUnverified(fntimes403·hanwhalife tls) |
| B3 | 보험영업지원사무원 | 20604 (fix 20602→20604 OMEGA) | 20 | 26 | major | CLEAN |
| B3 | 보험중개인 | 20612 | 19 | 28 | major | CLEAN |
| B3 | 보험통계담당원 | 20618 | 19 | 26 | major | CLEAN |
| B4 | 복무지도관 | 20593 | 11 | 19 | niche | CLEAN |
| B4 | 복지관보조원 | 20606 | 10 | 20 | niche | CLEAN |
| B4 | 복층유리봉합제충전원 | 20626 | 10 | 20 | niche | CLEAN |
| B4 | 복층유리압착기조작원 | 20632 | 10 | 19 | niche | CLEAN |
| B5 | 본선컨테이너관리원 | 20597 | 18 | 19 | major | CLEAN |
| B5 | 본선하역반장 | 20603 | 18 | 20 | major | CLEAN |
| B5 | 볼링설비조작원 | 20616 | 10 | 19 | niche | CLEAN |
| B5 | 볼압입원 | 20628 | 10 | 19 | niche | CLEAN |

(보험보유계약관리원은 1차 완료분이나 verify에서 hanwhalife tls WARN 1건 잔존)

## WARN 3건 (전부 urlUnverified, 비차단) — dispatcher 독립 재검
- **fntimes.com**(보험신계약담당원): dispatcher node fetch **200/106567 실증 → 거짓양성 확정** (audit 403 = anti-bot)
- **hanwhalife.com**(보험보유계약관리원·보험사무지원사무원·보험신계약담당원): .do 동적페이지 TLS legacy renegotiation → node 독립확정 불가. 워커 WebFetch 실콘텐츠 확인, 대형 보험사 페이지라 실재 가능성 높음. WARN 비차단.

## 검증 방법
- admin KPI 단일진실 쿼리 3회 실측 (시작 2282 → 중단 landing 2287 → 종료 2307, +25 정확)
- master-verify-cycle --cycle=76 전수 (25/25 marker OK, FAIL 0)
- WARN URL 2종 dispatcher 직접 node fetch 재확인
- `--resume=76` 완료분 5직업 dup 가드 → 중복 POST 0 확정
