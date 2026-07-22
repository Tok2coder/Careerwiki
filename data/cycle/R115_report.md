# R115 검증 세션 리포트

- 검증 세션: opus (master-verify-cycle 결정적 게이트 + 전수 실측)
- 대상: 25직업 (queue `data/cycle/R115_queue.txt`)
- 최종 판정: **PASS** (실 FAIL 0 — 양계장작업원 urlDead는 transient DNS 오탐, 재실측 HTTP 200 확인)

## 25직업 결과 표

| slug | rev(latest) | marker | audit | distinct | totalE | class |
|---|---|---|---|---|---|---|
| 약용작물연구원 | 22520 | OK | PASS | 17 | 20 | niche |
| 양념제분기조작원 | 22528 | OK | PASS | 12 | 19 | niche |
| 양돈장작업원 | 22535 | OK | PASS | 11 | 19 | niche |
| 양말검사원 | 22549 | OK | PASS | 10 | 20 | niche |
| 양묘관리원 | 22555 | OK | PASS | 10 | 20 | niche |
| 약품조액원 | 22522 | OK | WARN(urlUnverified tls×1) | 15 | 21 | niche |
| 양념혼합원 | 22531 | OK | PASS | 10 | 20 | niche |
| 양말성형기조정원 | 22541 | OK | PASS | 10 | 20 | niche |
| 양묘작업원 | 22551 | OK | PASS | 10 | 19 | niche |
| 양반원 | 22561 | OK | PASS | 10 | 19 | niche |
| 야생동물재활사 | 22514 | OK | PASS | 13 | 21 | niche |
| 양갱제조원 | 22524 | OK | PASS | 12 | 21 | niche |
| 양말재봉사 | 22539 | OK | PASS | 10 | 20 | niche |
| 양묘재배자 | 22545 | OK | PASS | 10 | 21 | niche |
| 양봉원 | 22557 | OK | PASS | 11 | 23 | niche |
| 약국처방전산입력원 | 22518 | OK | WARN(urlUnverified tls×1) | 19 | 19 | niche |
| 약제살포원 | 22533 | OK | PASS | 19 | 19 | niche |
| 양계장작업원 | 22543 | OK | PASS* | 13 | 19 | niche |
| 양말제조반장 | 22559 | OK | PASS | 10 | 19 | niche |
| 양생원 | 22563 | OK | PASS | 10 | 19 | niche |
| 약물감시전문가 | 22516 | OK | PASS | 21 | 21 | niche |
| 약제추출기조작원 | 22529 | OK | WARN(urlUnverified tls×1) | 14 | 22 | niche |
| 양극산화처리원 | 22537 | OK | PASS | 10 | 21 | niche |
| 양말편직원 | 22547 | OK | PASS | 11 | 21 | niche |
| 양수장감시원 | 22553 | OK | PASS | 11 | 21 | niche |

\* 양계장작업원: master-verify 배치 실행 중 `www.animal.go.kr/.../certificationList.do` 가 dns(NXDOMAIN) urlDead 1건으로 FAIL 표기되었으나, 직접 curl 2회 + url-liveness 재실측 모두 **HTTP 200** — checker 환경의 일시적 DNS 해석 실패(오탐). 실제 URL 생존. 실 FAIL 아님.

## 약제추출기조작원 dup 확인 (특별 주의)

- rev 이력: 22525(원본) → 22526([job-data-master] enhance) → 22529([job-data-master] cleanup, urlCountInsufficient WARN 대응 distinct 확충)
- latest non-sidebar-fill rev = **22529**, top-level [job-data-master] 마커 **실존**
- 둘 다 master 마커 → benign dup. KPI는 entity별 latest 1건만 COUNT → **inflation 없음**. 정상.

## KPI 독립 재대사

- admin 단일진실 쿼리 직접 재현 → **KPI = 3246**
- 직전 3221 + 25 = 3246 → **정확 일치** (편차 0)

## 집합검증

- rid 22514~22563 내 [job-data-master] 마커 rev = 26건 / DISTINCT entity_id = **25** (약제추출기조작원 dup로 rev만 +1)
- 25 entity_id 집합 = queue 25 id 집합 **정확 일치**
- rid 22513~22563 범위 내 non-master·non-원본 rev = **0건** → baseline 이탈(명단 밖 직업 변경) **0**

## 통계누출 점검 (R112 신규 실패모드)

대표 전용 통계수치가 형제 비대표 직업 본문에 재인용됐는지 prod 본문 grep:

- 양말검사원(rep) 전용 `100억`·`30만개` → 형제 4직 재인용 **0**
- 양념제분기조작원(rep) 전용 `88.09%`·`12,870톤`·`6,570톤`·`2,780톤` → 양념혼합원 재인용 **0**
- 약제살포원(rep) 전용 `40%`·`57%` → 약제추출기조작원 재인용 **0**
- 양묘관리원(rep): 대표 전용 stat token 부재 (누출 대상 없음)
- **누출 검출 0건**

## 산문 복붙 점검 (Jaccard 4-gram)

형제군 15쌍 전수 (양말 10쌍 집중 + 양묘 3 + 양념 1 + 약제 1) — 전부 5% 미만, 경고선(0.4=40%) 대비 압도적 여유:

- 양말 5직 10쌍: 1.6% ~ 3.0%
- 양묘 3쌍: 1.7% ~ 4.1%
- 양념 1쌍: 3.8% / 약제 1쌍: 1.1%
- **복붙 쌍(≥0.4) 0건**

## sal 미접촉

- 25직업 UCJ 전건 `overviewSalary`/`sal`/`wage` 키 부재 → sal/wage 영역 **무변경 확인**. 이탈 0.

## 사고/이탈 유무

- 실 FAIL: 0 (양계장 urlDead는 transient DNS 오탐, 재실측 OK)
- WARN: 3 (urlUnverified TLS 오탐 — 허용 범위)
- 무마커(R39형) 사고: 0
- baseline 이탈: 0 / 통계누출: 0 / 복붙: 0 / sal 이탈: 0

**최종 판정: PASS**
