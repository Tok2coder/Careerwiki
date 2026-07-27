# R124 cycle 보고 (2026-07-26)

## 한 일
영유아안전장치설치원~예술모델 25직업 master enhance (🔀 v6-disperse 18회차). **영화 계열 14직 = 동일 heroCategory 최대 클러스터**.
- **R122·R123 교훈 2종 사전 적용**: ①DB heroCategory 실측 → cycle 공통 기준 분류표(major 21/niche 4) 프롬프트 주입 ②**배치별 출처 축 분리 지시**(기술감독=현장기술 / 제작자=투자·수익 / 배급관리자=부율·스크린 / 배급원=개봉운영 / 프로듀서=기획·펀드 …) + **KOFIC 통계는 배치당 대표 1직만 인용**.

## 결과 (25/25)
- **집합검증 25/25 정확 일치·이탈 0** (rev 23001~23055, latest=master distinct 25)
- **마커 25/25**, **audit 실FAIL 0**, **totalE 전건 ≥19**
- **URL-set 재사용 FAIL 0쌍** — 영화 14직이 같은 산업인데도 교집합 0 (출처 축 분리 성공, R122형 사고 재발 없음)
- **복붙 0쌍** (영화 14직 4-gram Jaccard max 3.7%)
- **KOFIC 통계 대표 규칙 준수** (비대표 직업의 박스오피스·매출 재인용 0)
- **수치 단위 대조 통과** — R122(1000배)·R123(10배) 패턴 오류 **0건**(KOFIC 1조1,945억/6,910억/7,147만명 원문 일치 등)
- **distinct**: major 21직 18~20 / niche 4직 11~14
- **prod 표본 5/5** 200, sal 이탈 0/25
- **KPI 3471** (3446+25 정확 일치, admin fresh + CTE 이중 실측), max rev 23055

## 결함과 수습
| 구분 | 내용 | 조치 |
|---|---|---|
| 🔴 게이트 하드 FAIL 1 | 영화라인프로듀서 `urlDead(1)` — `staffingbridge.co.kr/feeds/10` | **거짓양성 확정**(dispatcher 독립 검증: 최소 헤더 GET **200/42KB, 본문 "표준계약서·스태프·영화" 포함** / 대조군 `/feeds/999999`는 404 shell) → URL 유지, 게이트 패치로 수습 |
| 🔴 도메인 집중 2직 | 예능학원강사 riss.kr 78%(3dom) · 예술모델 riss.kr 61% — B5가 자진 신고 | opus fix POST **rev 23054·23055** → 각 **16·18도메인, 최대 비중 10%**, riss 완전 소거 (교체 41 URL 전수 node GET 재검증 200/200) |
| urlUnverified | KOBIS 등 | 3분류 결과 **전부 거짓양성**(재시도 6/6 200), 교체 0 |

## 게이트 보정 2건 (커밋: url-liveness + master-verify-cycle)
| 게이트 | 문제 | 수정 | 회귀 검증 |
|---|---|---|---|
| `url-liveness` | 풀 헤더 GET에 404 shell을 주는 서버 때문에 live URL을 dead로 오판 | **404/410 선언 직전 최소 헤더 GET 1회 재확인** | 실사고 URL은 dead 해제, **진짜 404 2건은 dead 유지**(검출력 손실 0) |
| `master-verify-cycle` 도메인 | 기존 `hosts≤3 / topShare≥0.5`가 영화프로듀서(4dom, riss 32%·wiki 32%) padding을 **PASS로 통과** | distinct≥18(major)은 **hosts≤5 또는 topShare≥0.35**로 강화 | R124 재실행 시 **영화프로듀서 1건만 검출, 나머지 24직 오탐 0** |

## soft-flag 1직
- **영화프로듀서**(4dom/19url, riss 32%·위키 32%) — 강화 게이트가 새로 검출. 직업당 1 POST 원칙으로 이번 cycle 미수습, 재보강 백로그.

## 부작용 없음
sal/wage 미접촉(0/25), baseline 이탈 0, 명단 밖 무접촉. careerTree 신규 1(영화프로듀서→차승재 id422).

## 확인 방법
- admin: https://careerwiki.org/admin/job-equalize (KPI 3471)
- 표본: careerwiki.org/job/영화프로듀서 · /job/예방의학과전문의사 · /job/예비군지휘관

## 교훈
1. **게이트 오탐도 게이트 결함이다** — dead URL 판정 하나가 cycle 완료를 막았고, 원인은 서버 헤더 반응이었다. 판정 로직은 "dead 선언 직전 한 번 더 관대하게" 재확인하는 게 안전(진짜 dead는 그대로 잡힘).
2. **게이트 임계는 워커에게 준 기준과 일치해야 한다** — 프롬프트로 "도메인 ≥6, 최대 30%"를 요구하면서 게이트는 "≤3, 50%"만 잡으면 그 사이 구간이 전부 통과한다.

R125는 go 주면 시작.
