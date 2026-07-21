# R113 검증 세션 리포트

- 대상: 25직업 (B1~B5 × 5)
- 검증자: opus 검증 세션 (결정적 스크립트 전수 실측)
- 판정: **PASS**

## 1. 결과 표 (25행)

| slug | 배치 | rev marker | audit | totalE | distinct | verdict |
|---|---|---|---|---|---|---|
| 암벽화수선원 | B1 | OK | 0 FAIL | 20 | 20 | PASS |
| 암석조각원 | B1 | OK | 0 FAIL | 20 | 20 | PASS |
| 압연기레드오프원코드준비원 | B1 | OK | 0 FAIL | 19 | 19 | PASS |
| 애견보험판매원 | B1 | OK | 0 FAIL | 20 | 20 | PASS |
| 애니메이션-캐릭터-디자이너 | B1 | OK | 0 FAIL | 20 | 20 | PASS |
| 알아이폐기물관리원 | B2 | OK | 0 FAIL | 19 | 19 | PASS |
| 암호알고리즘개발원 | B2 | OK | 0 FAIL | 20 | 20 | PASS |
| 압연기운전원 | B2 | OK | 0 FAIL | 19 | 11 | PASS |
| 애견옷-디자이너 | B2 | OK | 0 FAIL | 19 | 11 | PASS |
| 애니메이션라이팅원 | B2 | OK | 0 FAIL | 19 | 10 | PASS |
| 알루미늄연속주조원 | B3 | OK | 0 FAIL | 21 | 11 | PASS |
| 알에프아이디시스템개발자 | B3 | OK | 0 FAIL | 22 | 10 | PASS |
| 압연롤정비원 | B3 | OK | 0 FAIL | 21 | 10 | PASS |
| 압인기조작원 | B3 | OK | 0 FAIL | 21 | 10 | WARN(urlUnverified TLS 1) |
| 애견핸들러 | B3 | OK | 0 FAIL | 21 | 10 | PASS |
| 알루미늄코일중합기조작원 | B4 | OK | 0 FAIL | 24 | 13 | WARN(urlUnverified TLS 1) |
| 알카라인전지조립원 | B4 | OK | 0 FAIL | 21 | 10 | PASS |
| 압연유관리원 | B4 | OK | 0 FAIL | 20 | 10 | WARN(urlUnverified TLS 1) |
| 압착탈수기조작원 | B4 | OK | 0 FAIL | 19 | 10 | PASS |
| 애견혈통관리자 | B4 | OK | 0 FAIL | 19 | 10 | PASS |
| 암면성형원 | B5 | OK | 0 FAIL | 20 | 10 | PASS |
| 암석절단원 | B5 | OK | 0 FAIL | 21 | 18 | PASS |
| 압연재정정원 | B5 | OK | 0 FAIL | 20 | 10 | PASS |
| 압출작업원 | B5 | OK | 0 FAIL | 20 | 10 | PASS |
| 애니메이션-배경-디자이너 | B5 | OK | 0 FAIL | 20 | 10 | PASS |

master-verify-cycle: **PASS 22 / WARN 3 / FAIL 0 / urlDead 0**. WARN 3건은 모두 `urlUnverified`(HEAD TLS handshake 미확인 — shoenet.org / sama-al.com / hansco.co.kr), 허용 WARN. totalE 전건 ≥19, distinct 전건 ≥10.

## 2. KPI 독립 재대사

admin 단일진실 쿼리 직접 재현 결과:
```
kpi = 3196
```
- 직전 KPI = 3171, 예상 = 3171+25 = **3196**
- 실측 **3196 = 예상 3196 정확 일치** ✅

## 3. 마커 실존 (page_revisions 실측)

25 entity_id 전건에 대해 latest non-sidebar-fill rev의 change_summary가 top-level `[job-data-master] enhance — ...`로 시작. **25/25 마커 실존.** R39형 changeSummary-nested(무마커) 사고 0건.

## 4. 집합검증 / 드리프트

- `[job-data-master]` 마커 최근 rev 상위 25건(rid 22414~22462)의 entity_id 집합 = 명단 25 slug 집합 정확 일치.
- rid ≤ 22412 revs는 전부 명단 밖(R112 이전) 직업 → 이번 cycle 신규 master 적용 = 정확히 우리 25건.
- **baseline 이탈(명단 밖 직업 변경) = 0.**

## 5. 통계누출 점검 (R112 신규 실패모드)

대표(알루미늄연속주조원 / 암석절단원 / 압연기레드오프원코드준비원 / 애견보험판매원) 전용 통계토큰(N개사·%·억·특정기업명)을 형제 비대표 본문에서 grep 교차검증:
- 공유 특정 통계수치/기업명 = **0건**
- 유일 flag "뿌리산업"(알루 그룹)은 일반 산업분류 용어(regex `...산업` false positive), 통계 아님 → 실제 누출 아님.

## 6. 산문 복붙 점검 (형제군 pairwise Jaccard 4-gram)

압연5(10쌍)·애견4(6쌍)·애니3(3쌍)·암석2·알루2 = 21쌍 전건:
- 최대 유사도 = **2.7%** (압연기레드오프원코드준비원:압연기운전원)
- 0.4(경고) 이상 = **0쌍**, 0.5(FAIL) 이상 = 0쌍.

## 7. sal 미접촉

- 25건 latest rev change_summary 어디에도 sal/wage/연봉/임금 언급 0건.
- verify-cycle origin 보존 검사 통과(origin없음 FAIL 0).
- overviewSalary.sal/wage 영역 변경 흔적 없음.

## 최종 판정: PASS

사고/이탈 0건. urlUnverified WARN 3건은 TLS handshake 미확인(허용), urlDead 0.
