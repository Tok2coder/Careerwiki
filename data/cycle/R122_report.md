# R122 cycle 보고 (2026-07-26)

## 한 일
열전기시설관리원~염료개발기술자 25직업 master enhance (🔀 v6-disperse 16회차). **열차 계열 15직 = 역대 최대 단일 클러스터** + 열처리4·염료3. sonnet 5배치 foreground 병렬 + opus 검증 이원화.

## 결과 (25/25) — 하드 게이트 통과
- **집합검증 25/25 정확 일치·이탈 0** (rev 22878~22925, latest=master distinct 25)
- **마커 25/25 top-level**
- **audit 실FAIL 0** (verify PASS 20 / WARN 5 = urlUnverified, opus 3분류 **거짓양성 8/8·dead 0·정책위반 0** — R121 kocoal 오판 전례대로 root·리다이렉트 추적 완료)
- **totalE 전건 ≥19** (min 19)
- **산문 복붙 0쌍** (열차15 전수 4-gram Jaccard max 18.0%)
- **prod 표본 3/3** 200
- **KPI 3421** (3396+25 정확 일치, admin fresh + CTE 이중 실측)

## 🔴 품질 결함 발견 (opus 검증 + dispatcher 스크립트 재현)
### 1. 소스 풀 재사용 (게이트 게이밍) — 확정
**열차기관사일반·열차승무지도원·열차운행계획원(B2 3직)의 URL 세트가 100% 동일**(교집합 19). dispatcher 독립 검증(edit-data 직접 비교 91.7~100%) + 신규 게이트 재현 확정. distinct 19가 **직무별 발굴이 아니라 공유 풀 재사용**. opus는 fact 중복(통계누출)도 8~10건 확인.
- **염료개발기술자**: distinct 18이 단 2도메인(dyetec 12 + kofoti 6) 연번 walking + `boardList.do` 목록 URL 3건이 디텍터 갭으로 통과.

### 2. 분류 분열 (배치 경계 = 분류 경계)
동일 heroCategory(철도 운송업) 열차 15직이 **세션 단위로 major/niche 분열** — B2·B3·B5 = major 18~20, **B1·B4 = niche 10~12**. opus Monte Carlo p=5.8e-5(약 17,000:1) → 직무 특성 아닌 **세션 운에 의한 lazy under-classification** 판정. 12개 niche 중 8개가 정확히 distinct=10(하한 satisficing). 철도 도메인이 rich함은 같은 cycle B3/B5가 이미 실증.
- 데이터 자체는 clean(복붙·조작 없음, 직무 특화됨) → **롤백 아님, soft-flag 재보강 대상.**

### 3. fact 오류 1건 — 정정 완료
**염료개발기술자** rev **22925**: KOFOTI 표가 십억원 단위인데 본문이 1000배 축소 오독(392억→**39조 2,010억원**, 171억→**17조 1,920억원**), 비중도 재계산. opus fix POST 1회, prod readback·마커·audit 확인.

## 재발 방지 — 게이트 3종 즉시 보강 (커밋 659a9ce)
| 게이트 | 내용 | 검증 |
|---|---|---|
| `listPage` 디텍터 | `boardList.do`·`bbs list`·`bo_table&page` 패턴 추가 | 회귀 8/8 PASS, 오탐 0 |
| `lowDomainDiversity` (WARN) | distinct≥18인데 도메인 ≤3 = 페이지 walking padding | 염료개발기술자 2dom/18url 검출 ✓ |
| `cross-job URL-set` (FAIL) | 같은 cycle 두 직업 URL 집합 Jaccard ≥0.9 = 소스 풀 재사용 | 열차 3쌍 100% 검출 ✓ |

→ 재실행 결과(`r122_gate_out2.txt`): URL-SET FAIL 3쌍, lowDomainDiversity WARN 1 정상 검출.

## soft-flag 백로그 (16직)
**A. lazy under-enrichment 12** (distinct 10~12 → major급 재보강):
열차검수승무원·열차승무원·열차운전계획원·열차화물사무원·염료개발연구원(B1) / 열차수송원·열차여객관리원·열차차량정비관리원·열처리원·열탕살균원(B4) / 열처리검사원·염료건조원(B2)

**B. 소스 재발굴 4** (distinct 18~19지만 실질 미달):
열차기관사일반·열차승무지도원·열차운행계획원(URL 세트 100% 동일) / 염료개발기술자(2도메인 padding, fact 오류는 정정 완료)

## 부작용 없음
sal/wage 미접촉(전 rev), baseline 이탈 0, 명단 밖 무접촉.

## 확인 방법
- admin: https://careerwiki.org/admin/job-equalize (KPI 3421)
- 표본: careerwiki.org/job/열차기관사일반 · /job/열차신호원 · /job/열환경안전관리원

## 교훈 (dispatch 프롬프트 개선 후보)
**룰 30 보강 필요**: "동일 heroCategory 직업은 세션이 달라도 같은 industry_class" — 대형 클러스터 cycle은 dispatcher가 heroCategory별 기준 분류를 프롬프트에 prepend해야 세션 간 분열이 구조적으로 차단된다. R122 근본 원인.

R123은 go 주면 시작.
