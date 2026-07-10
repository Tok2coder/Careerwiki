# R78 Cycle Report (2026-07-11)

## 요약
- **직업 25건** (부동산연구원~부식가공원), rev 20684~20732
- **KPI 2357** (2332 + 25 정확 일치, admin 단일진실 쿼리 이중 실측)
- **완료 게이트: 25/25 marker OK · FAIL 0** (verify-cycle 전수)
- 운영: foreground 5배치(sonnet) 동시 spawn + dispatcher 직접 결정적 검증. opus 수정세션 생략(FAIL 대상 0).
- 사고 0, 리밋·세션사망·자가fix 0, 단판 완주. baseline 이탈 0, sal/wage 미접촉, 명단 밖 무접촉.

## 배치 결과 (25/25)
| 배치 | 직업 | rev | distinct | totalE | class | audit |
|---|---|---|---:|---:|---|---|
| B1 | 부동산연구원 | 20686 | 18 | 24 | major | CLEAN |
| B1 | 부동산임대사무원 | 20698 | 18 | 23 | major | CLEAN |
| B1 | 부동산정보분석사 | 20710 | 18 | 28 | major | CLEAN |
| B1 | 부동산정비사업관리자 | 20720 | 18 | 23 | major | CLEAN |
| B1 | 부동산중개보조원 | 20726 | 18 | 25 | major | CLEAN |
| B2 | 부동액배합원 | 20696 | 12 | 22 | niche | WARN:urlUnverified(edu.kcma tls) |
| B2 | 부동액충전원 | 20702 | 12 | 21 | niche | CLEAN |
| B2 | 부두노무반장 | 20706 | 19 | 23 | major | CLEAN |
| B2 | 부두장비관리사무원 | 20714 | 18 | 22 | major | CLEAN |
| B2 | 부두화물장치료계산원 | 20718 | 19 | 25 | major | CLEAN |
| B3 | 부산물하조원 | 20690 | 10 | 22 | niche | CLEAN |
| B3 | 부선관리원 | 20700 | 10 | 21 | niche | CLEAN |
| B3 | 부선원 | 20712 | 10 | 20 | niche | CLEAN |
| B3 | 부시가공원 | 20722 | 10 | 20 | niche | CLEAN |
| B3 | 부식가공원 | 20732 | 18 | 26 | major | CLEAN |
| B4 | 부실상장등록법인관리사무원 | 20684 | 18 | 19 | major | CLEAN |
| B4 | 부실채권관리사무원 | 20692 | 18 | 19 | major | CLEAN |
| B4 | 부유생물연구원 | 20704 | 13 | 19 | niche | CLEAN |
| B4 | 부유선광원 | 20716 | 12 | 19 | niche | CLEAN |
| B4 | 부잠사처리원 | 20728 | 12 | 19 | niche | CLEAN |
| B5 | 부직포결합원 | 20688 | 11 | 21 | niche | WARN:urlUnverified(kcfa 403) |
| B5 | 부직포기술자 | 20694 | 11 | 20 | niche | CLEAN |
| B5 | 부채제조원 | 20708 | 10 | 21 | niche | CLEAN |
| B5 | 부틸기조작원 | 20724 | 10 | 20 | niche | CLEAN |
| B5 | 북수리원 | 20730 | 10 | 20 | niche | CLEAN |

## 특기 — 명칭 함정 워커 실직무 확인
- **부선원**: 바지선(barge) 승무원이 아니라 **부유선광(浮選) 선탄 공정 조작원**(코크스·연탄 제조업/광업). 마린 URL hint 폐기 → 대한석탄공사·광업법·선탄시설 재발굴.
- **부시가공원**(베어링 선반가공, 기계제조) ≠ **부식가공원**(항공기 부품 화학적 부식가공, 항공우주 major) — 명칭 유사 다른 직업, 출처 100% 분리.
- **부선관리원**(건설 바지선/항만·준설) ≠ **부선원**(석탄 부유선광) — 다른 산업 출처 분리.
- hint 불일치 자가교정: 부동산정비사업관리자(항공 hint→도시정비법/정부24/LH).

## WARN 2건 (전부 urlUnverified, 비차단) — dispatcher 독립 재검
- **kcfa.or.kr**(부직포결합원): dispatcher node fetch **200/20338 실증 → 거짓양성 확정** (audit 403 = anti-bot)
- **edu.kcma.or.kr**(부동액배합원): .asp TLS 이슈 → node 독립확정 불가. 워커 WebFetch 실콘텐츠 확인(대한기계설비건설협회 교육사이트 실재). WARN 비차단.

## 검증 방법
- admin KPI 단일진실 쿼리 2회 실측 (전 2332 → 후 2357, +25 정확)
- master-verify-cycle --cycle=78 전수 (25/25 marker OK, FAIL 0)
- WARN URL 2종 dispatcher 직접 node fetch 재확인
