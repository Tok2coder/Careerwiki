# R116 검증 세션 리포트 (resume cycle)

- 일시: 2026-07-25
- 대상: 25직업 (landing 7 @07-22 + resume 18 @방금)
- 검증 모델: opus (결정적 스크립트 전수 실측)
- 최종 판정: **PASS** (실FAIL 0 / 이탈 0 / 사고 0)

## 25직업 실측 표 (rev 22565~22613)

| slug | rev | marker | audit | distinct | totalE | class |
|---|---|---|---|---|---|---|
| 양육비이행모니터링수행원 | 22565 | OK | PASS | 15 | 19 | PASS |
| 양식기술개발원 | 22567 | OK | WARN(tls) | 12 | 20 | WARN |
| 양수장관리원 | 22569 | OK | PASS | 13 | 20 | PASS |
| 양식장작업원 | 22571 | OK | PASS | 11 | 20 | PASS |
| 양식장관리원 | 22573 | OK | PASS | 14 | 19 | PASS |
| 어구어법기술개발원 | 22575 | OK | WARN(tls) | 11 | 21 | WARN |
| 양조간장발효숙성원 | 22577 | OK | PASS | 11 | 21 | PASS |
| 양잠작업원 | 22579 | OK | PASS | 12 | 24 | PASS |
| 어업단순노무자 | 22581 | OK | PASS | 20 | 20 | PASS |
| 양육비이행면접교섭지원원 | 22583 | OK | PASS | 18 | 25 | PASS |
| 어묵제조반장 | 22585 | OK | PASS | 11 | 23 | PASS |
| 양식업관리자 | 22587 | OK | PASS | 19 | 25 | PASS |
| 어류사육사 | 22589 | OK | PASS | 19 | 25 | PASS |
| 어육분리기조작원 | 22591 | OK | PASS | 18 | 19 | PASS |
| 어로장 | 22593 | OK | WARN(tls×4) | 18 | 26 | WARN |
| 어문학교수 | 22595 | OK | WARN(tls) | 18 | 31 | WARN |
| 어업자원연구원 | 22597 | OK | PASS | 10 | 19 | PASS |
| 어업잠수부 | 22599 | OK | PASS | 11 | 26 | PASS |
| 양적화플래너 | 22601 | OK | PASS | 18 | 25 | PASS |
| 어류생태연구원 | 22603 | OK | WARN(tls) | 18 | 26 | WARN |
| 어육정형원 | 22605 | OK | PASS | 10 | 20 | PASS |
| 어업자원조사연구원 | 22608 | OK | WARN(tls) | 18 | 28 | WARN |
| 어음교환제도기획원 | 22609 | OK | PASS | 20 | 20 | PASS |
| 어묵제조원 | 22611 | OK | PASS | 11 | 22 | PASS |
| 어염건어물제조원 | 22613 | OK | PASS | 11 | 22 | PASS |

Summary: **PASS 19 / WARN 6 / FAIL 0**. 마커 25/25 OK. distinct 전건 ≥10, totalE 전건 ≥19.

WARN 6건은 전부 `urlUnverified(tls)` — Node/Windows 인증서 스토어 TLS 핸드셰이크 오탐(fishsci/mpsm.pknu.ac.kr, lems.seaman.or.kr, sciwatch.kiost.ac.kr, jalalika.org). 실 dead 아님. 허용.

## KPI 독립 재대사

admin 단일진실 쿼리 직접 재현:
- 실측 KPI = **3271**
- 예상 = 3246(R115) + 25 = **3271** → **정확 일치** ✓
- (07-22 부분 landing 후 3253, resume 18건 +18 = 3271 경로 일치)

## 집합검증

- 25 slug entity_id 집합 = rev 22565~22613 내 master 신규 적용 집합, **정확 일치**
- 명단 밖 이탈(baseline 이탈) = **0**
- (rev 22561 양반원 / 22563 양생원은 22565 미만 = 직전 R115 잔여, R116 무관)

## 어음교환제도기획원 dup 점검

- master rev = **[22609] 단일건**. B5 보고의 첫 POST `D1_ERROR: Network connection lost`는 실제로 저장되지 않았음(dup 없음).
- distinct id 25 = total master rev 25 → 25직업 전부 1:1, 중복 landing 0.

## 통계누출 점검 (R112 실패모드)

- 대표 6직(양식기술개발원·어류사육사·어묵제조반장·어업단순노무자·어육분리기조작원·양육비이행면접교섭지원원)의 대표 전용 통계수치(억/만원/명/%/배/톤 토큰)를 형제 비대표 본문에서 grep.
- 검출 = **0건**. 형제 간 stat 재인용 없음.

## 산문 복붙 점검 (Jaccard 4-gram)

- 형제군 16쌍 비교, 최대 유사도 **5.7%**(양식업관리자:양식장관리원). 경고 임계 0.4 대비 전건 낮음.
- 복붙 쌍 = **0**.

## sal 미접촉

- 대상 25직업 모두 이 니치 직업 특성상 `overviewSalary.wage`/`.sal` DB 값 **NULL(원래 바차트 데이터 없음)** → 접촉 대상 자체 부재.
- master edit가 추가한 sal/wage 출처 키 = **0**. sal 영역 무변경 확정.

## 사고/이탈

- **없음.** 실FAIL 0, 집합 이탈 0, dup 0, 통계누출 0, 복붙 0, sal 이탈 0.
