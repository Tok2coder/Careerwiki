# R123 cycle 보고 (2026-07-26)

## 한 일
염료분산기조작원~영양교사 25직업 master enhance (🔀 v6-disperse 17회차: 염료5·염색7·영상5·영업2 등).
- **R122 근본원인 차단 적용**: dispatcher가 25직 **DB heroCategory를 사전 실측**해 cycle 공통 기준 분류표(major 20 / niche 5)를 확정하고 5배치 프롬프트에 주입 → **세션 간 분류 분열 0**(R122 최대 결함 재발 없음).
- 신규 품질 게이트 4항목(URL-set 재사용·domain diversity·listPage 금지·fact 재인용 금지)도 프롬프트에 명시.

## 결과 (25/25)
- **집합검증 25/25 정확 일치·이탈 0** (rev 22943~22994, latest=master distinct 25)
- **마커 25/25**, **audit 실FAIL 0**, **totalE 전건 ≥19**
- **distinct**: major 20직 18~20 / niche 5직 10~11 (기준표 100% 준수)
- **복붙 0쌍** (염료5·염색7·영상5 클러스터 Jaccard max 16.4%)
- **prod 표본 3/3** 200, sal 이탈 0
- **KPI 3446** (3421+25 정확 일치, admin fresh + CTE 이중 실측), max rev 22994

## 🔴 fact 오류 2건 — 정정 완료 (opus fix POST)
| slug | rev | 내용 |
|---|---|---|
| 염색공정개발기술자 | **22993** | 대기오염방지 `6,500억원` → **`650억원`** (출처 실측 "총 650억원" = **10배 오류**) |
| 염색반장 | **22994** | `시간당 390톤` → **`540톤`** (출처 위키백과 실측 540TON/H, 출처 미일치) |

R122(1000배)·R123(10배) 연속 발생 → **단위·자릿수 오독이 반복 실패 모드**로 확인. opus 검증에 수치 대조가 필수 항목임을 재확인.

## 🔴 내가 만든 게이트의 false negative — opus가 적발, 재calibration (커밋 6f07391)
R122 후속으로 내가 추가한 `cross-job URL-set` 게이트가 **임계 Jaccard ≥0.9**여서 사실상 도달 불가였고, `lowDomainDiversity`는 `distinct≥18` 조건이라 **niche 직업 전부 면제**였다. 그 결과 실제 재사용을 놓쳤다:
- **염료표준화원 ↔ 엽상기조작원: 교집합 8, Jaccard 38.1%, 엽상기 피복률 80%** (dispatcher 독립 재검증으로 확정)

**재calibration 내용**:
| 항목 | before | after |
|---|---|---|
| URL-set 재사용 | Jaccard ≥0.9 FAIL | **Jaccard ≥0.30 또는 작은쪽 피복률 ≥0.60 FAIL** |
| domain diversity | distinct≥18 & 도메인≤3 | **distinct 하한 8로 확장 + singleDomainDominance(단일 도메인 ≥50%) WARN** |
| 신디케이션 | — | naver·daum 기사 단위 카운트 |

**재실행 검증**: 이전 0쌍/0건 → **URL-set FAIL 1쌍 + padding WARN 4직 검출**(index.go.kr 11/18·casenote.kr 9/18·foodnews 9/18·1도메인 11url). 오탐 없음.

## soft-flag 5직 (재보강 백로그)
| slug | 문제 |
|---|---|
| 엽상기조작원 | 소스 80% 형제 재사용(고유 출처 0) |
| 염색용얼음제조원 | casenote.kr 법령 **1도메인 100%** |
| 영상필름관리원 | casenote 9/18 + 근거 약한 추론 브리지 |
| 영양교사 | foodnews idxno **연번 수확** 9건, 직무 무관 4건 |
| 영상통신연구원 | index.go.kr `idx_cd` 연번 페이지워킹 11/18 |

## 통계누출 4건 (opus 적발)
염료표준화원↔엽상기조작원(기계산업 통계·화학물질 배출량 — 게다가 기초화학물질 직업에 **기계산업 통계 오전용**), 염색공정개발기술자↔염료조액원(대구염색산단 3수치), 염색설비개발기술자 양쪽 재인용.

## 부작용 없음
sal/wage 미접촉, baseline 이탈 0, 명단 밖 무접촉.

## 확인 방법
- admin: https://careerwiki.org/admin/job-equalize (KPI 3446)
- 표본: careerwiki.org/job/영상기자 · /job/영양교사 · /job/염료조액원

## 교훈
1. **게이트는 실데이터로 calibration해야 한다** — 임계값을 "이론상 안전"하게 잡으면(0.9) 실제 결함(0.38)을 통과시킨다. 새 게이트 추가 시 **반드시 과거 사고 데이터로 검출되는지 확인**.
2. **단위·자릿수 오독이 반복 실패 모드**(R122 1000배·R123 10배) — 검증 프롬프트에 수치 단위 대조를 상시 항목으로.
3. heroCategory 기준표 사전 주입은 효과 확인 — 분류 분열 0.

R124는 go 주면 시작.
