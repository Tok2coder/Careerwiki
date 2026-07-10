# R79 Cycle Report (2026-07-11)

## 요약
- **직업 25건** (북한경제연구원~분단기조작원), rev 20734~20782
- **KPI 2382** (2357 + 25 정확 일치, admin 단일진실 쿼리 이중 실측)
- **완료 게이트: 25/25 marker OK · FAIL 0** (verify-cycle 전수)
- 🆕 **Tier 1+2 명칭함정 사전차단 첫 실전 cycle** (helper commit 1efdd6c)
- 사고 0, 리밋·세션사망·자가fix 0, 단판 완주. baseline 이탈 0, sal/wage 미접촉, 명단 밖 무접촉.

## 🆕 Tier 1+2 명칭함정 사전차단 실전 결과 (3건 탐지)
| 직업 | 이름 유도 함정 | DB heroCategory | 워커 처리 |
|---|---|---|---|
| 분병원 | "병원"→의료 pool | 의약품 제조업 | ✅ 함정 회피, 분병 충전공정으로 확정(식약처/제약협회, distinct 19) |
| 브라운관검사원 | "검사"→법조 pool | 전자부품 제조업 | ✅ 함정 회피, CRT QC로 확정 |
| 분식점조리사 | (과경보) | 음식점업 | 정상 처리(식품, distinct 13) — 무해 과경보 |

→ 2건 진짜 함정 워커 정확 회피(사전 차단 실전 검증), 1건 무해 과경보. 오유도 0.

## 배치 결과 (25/25)
| 배치 | 직업 | rev | distinct | totalE | class | audit |
|---|---|---|---:|---:|---|---|
| B1 | 북한경제연구원 | 20748 | 21 | 25 | major | CLEAN |
| B1 | 분괴압연원 | 20762 | 20 | 27 | major | CLEAN |
| B1 | 분뇨수거차량운전원 | 20774 | 13 | 24 | niche | CLEAN |
| B1 | 분뇨처리기술자 | 20778 | 12 | 25 | niche | WARN:urlUnverified(djsiseol .asp) |
| B1 | 분단기조작원 | 20782 | 11 | 24 | niche | CLEAN |
| B2 | 분말기조작원 | 20738 | 11 | 19 | niche | CLEAN |
| B2 | 분말소지제조원 | 20746 | 10 | 19 | niche | CLEAN |
| B2 | 분무건조기조작원 | 20750 | 10 | 19 | niche | CLEAN |
| B2 | 분무도장공 | 20758 | 10 | 19 | niche | CLEAN |
| B2 | 분무시유원 | 20766 | 10 | 19 | niche | CLEAN |
| B3 | 분병원 | 20734 | 19 | 28 | major | WARN:urlUnverified(gmpschool tls) |
| B3 | 분사단열원 | 20744 | 14 | 24 | niche | WARN:urlUnverified(codil/wiki1 tls) |
| B3 | 분식점시중원 | 20752 | 12 | 24 | niche | CLEAN |
| B3 | 분식점조리사 | 20760 | 13 | 25 | niche | CLEAN |
| B3 | 분실물조사원 | 20770 | 11 | 26 | niche | CLEAN |
| B4 | 분열방지밴드압입원 | 20740 | 10 | 19 | niche | CLEAN |
| B4 | 분제제조원 | 20756 | 10 | 19 | niche | WARN:urlUnverified(forest timeout) |
| B4 | 분체도장공 | 20772 | 10 | 21 | niche | CLEAN |
| B4 | 불꽃연출가 | 20776 | 10 | 20 | niche | CLEAN |
| B4 | 불림원 | 20780 | 10 | 19 | niche | CLEAN |
| B5 | 불활성가스텅스텐아크용접원 | 20736 | 10 | 25 | niche | CLEAN |
| B5 | 붐오퍼레이터 | 20742 | 10 | 24 | niche | CLEAN |
| B5 | 브라운관검사원 | 20754 | 10 | 24 | niche | CLEAN |
| B5 | 브라운관배기원 | 20764 | 10 | 24 | niche | CLEAN |
| B5 | 브라운관봉입원 | 20768 | 10 | 24 | niche | CLEAN |

## WARN 4건 (전부 urlUnverified, 비차단) — dispatcher 독립 재검
- **forest.go.kr**(분제제조원): dispatcher node fetch **200/146442 실증 → 거짓양성 확정** (timeout=일시 지연)
- **gmpschool.co.kr / wiki1.kr / djsiseol.or.kr(.asp) / codil.or.kr(.do)**: node TLS legacy renegotiation → 독립확정 불가. 워커 curl 200 재검증 보고(schannel 거짓양성 패턴). WARN 비차단.

## 검증 방법
- admin KPI 단일진실 쿼리 2회 실측 (전 2357 → 후 2382, +25 정확)
- master-verify-cycle --cycle=79 전수 (25/25 marker OK, FAIL 0)
- WARN URL 5종 dispatcher 직접 node fetch 재확인
