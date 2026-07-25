# R121 cycle 보고 (2026-07-26)

## 한 일
연속주조압연원~열유체시스템연구원 25직업 master enhance (🔀 v6-disperse 15회차: 연조3·연신2·연탄3·연육3·연속주조2·연예3·열배관2 등). sonnet 5배치 foreground 병렬 + opus 검증 이원화.

## 결과 (25/25)
- **집합검증 25/25 정확 일치·이탈 0** (rev 22822~22871, latest=master distinct 25)
- **마커 25/25 top-level**
- **audit 실FAIL 0** (verify-cycle PASS 22 / WARN 3 = urlUnverified)
- **totalE 전건 ≥19** (min 19)
- **distinct**: major 6직 ≥18(18~19) / niche 19직 10~16
- **산문 복붙 0쌍** (연탄3·연조3·연신2·연육3 클러스터 4-gram Jaccard max 38.3% <0.4; 최대쌍=연탄제조반장↔관리자 공식 정의문 어간 공유, 실질 산문 차별화)
- **통계누출 0**
- **prod 표본 3/3** 200 (연예프로그램진행자·열유체시스템연구원·연속주조작업원)

## 검증 하이라이트
- **🔴 명칭 함정 정확 회피**: 연육기조작원 = 식품 어묵(surimi) 아니라 **도료·잉크 제조업 분산기(練肉機) 조작원**(heroCategory 기타화학제품). 연육배합기조작원·연육결착원은 진짜 수산 연육(어묵). opus 교차확인 정합.
- **🔴 검증자 불신 발동 — dead URL 오판 정정**: opus가 연탄제조관리자 kocoal.or.kr을 "진짜 dead(대한석탄공사 청산)"로 판정했으나, **dispatcher 독립 node fetch(302 프레임 네비 추적 + deep page 4건 본문 확인)로 전부 200 live(35~50KB, title 대한석탄공사) 확정** = 거짓양성. **dead URL 없음, fix 불요.** (root 302→/main/index.php 프레임 구조를 초기 probe가 오독한 케이스)
- **연예인총괄관리자 minor 분류(폐지 R45) → opus major 재판정**: heroCategory 엔터 매니지먼트 + 형제 연예프로그램진행자 major(18) 실증. distinct13 = under-enrichment soft-flag. careerTree 박진영(id421) 연결 확인.

## 사고와 수습
- 하드결함 0. fix POST 1직(연승어선원 22829 arrayItemPeriod 마침표, latest master).
- 전 배치 WebSearch 세션한도(200) 소진 → 후반 DuckDuckGo HTML/WebFetch 대체(게이트 urlUnverified 3 = 전부 거짓양성).
- **⚠️ soft-flag(파리티): 연예인총괄관리자**(niche→major, distinct13) — 형제 연예프로그램진행자 major18 대비 under-enrich. 데이터 clean·결함 아님·롤백X. 차기 top-up 후보.

## 부작용 없음
- sal/wage 미접촉(전 25 rev), baseline 이탈 0, 명단 밖 무접촉. benign dup 1쌍(연승어선원) latest master. careerTree 신규 1(박진영 id421).

## KPI
**3396** (예상 3371+25 정확 일치, 이중 실측: admin fresh 3,396 + KPI CTE 독립쿼리 3,396). max master rev 22871.

## 확인 방법
- admin: https://careerwiki.org/admin/job-equalize (KPI 3396)
- 표본: careerwiki.org/job/연예프로그램진행자 · /job/열유체시스템연구원 · /job/연속주조작업원

## soft-flag enrichment 백로그 (누적 3건)
| cycle | 직업 | 현 distinct | 사유 |
|---|---|---|---|
| R119 | 연금재정추계분석원 | 13 | 형제 연금 2직 18달성, deferred |
| R120 | 연료전지소재부품연구원 | 13 | R&D 형제 major 20/19 |
| R121 | 연예인총괄관리자 | 13 | minor→major 재판정, 형제 연예진행자 18 |

R122는 go 주면 시작.
