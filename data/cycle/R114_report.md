# R114 Cycle 검증 리포트 (검증 세션 — 결정적 전수 실측)

- 일시: 2026-07-21
- 대상: 25직업 (애니 10 / 앰풀 3 / 애자 2 / 액상 2 / 기타 8)
- 방법: `master-verify-cycle.cjs --cycle=114` + admin KPI 쿼리 독립 재현 + page_revisions rid 집합검증 + prod 본문 통계누출/복붙 실측 + 원본↔master rev sal diff
- **최종 판정: PASS** (FAIL 0, 이탈 0, KPI 정확 일치)

## 1. 직업별 결과 (25행)

| slug | rev(master rid) | marker | audit | distinct | totalE | class |
|---|---|---|---|---|---|---|
| 애니메이션라인프로듀서 | 22464 | OK | clean | 19 | 19 | PASS |
| 애니메이션스토리보드작가 | 22476 | OK | clean | 20 | 20 | PASS |
| 액상수화제제조원 | 22482 | OK | clean | 12 | 19 | PASS |
| 액체펌프공정검사원 | 22488 | OK | clean | 11 | 19 | PASS |
| 앰풀검사기조작원 | 22496 | OK | clean | 10 | 19 | PASS |
| 애니메이션레이아웃작가 | 22466 | OK | clean | 12 | 20 | PASS |
| 애니메이션시나리오작가 | 22478 | OK | clean | 11 | 20 | PASS |
| 액상정제기조작원 | 22486 | OK | clean | 10 | 19 | PASS |
| 앰풀세척기조작원 | 22498 | OK | clean | 10 | 20 | PASS |
| 야광제도포원 | 22506 | OK | clean | 10 | 21 | PASS |
| 애니메이션리깅원 | 22474 | OK | clean | 19 | 19 | WARN(urlUnverified TLS) |
| 애니메이션프로듀서 | 22484 | OK | clean | 19 | 21 | PASS |
| 애드마스터 | 22494 | OK | clean | 16 | 19 | WARN(urlUnverified TLS) |
| 앰풀충전엄폐기조작원 | 22502 | OK | clean | 10 | 21 | PASS |
| 야구비디오판독관 | 22510 | OK | clean | 10 | 19 | PASS |
| 애니메이션맵핑원 | 22468 | OK | clean | 12 | 22 | PASS |
| 애니메이션합성원 | 22472 | OK | clean | 12 | 23 | PASS |
| 애자일코치 | 22490 | OK | clean | 18 | 22 | PASS |
| 애플리케이션-엔지니어 | 22500 | OK | clean | 18 | 25 | PASS |
| 야드크레인사무원 | 22508 | OK | clean | 18 | 23 | PASS |
| 애니메이션모델러 | 22470 | OK | clean | 14 | 25 | PASS |
| 애니메트로닉스제작자 | 22480 | OK | clean | 11 | 21 | PASS |
| 애자조립원 | 22492 | OK | clean | 10 | 20 | WARN(urlUnverified TLS) |
| 액제의약품생산원 | 22504 | OK | clean | 11 | 19 | WARN(urlUnverified TLS) |
| 야생동물생태복원사 | 22512 | OK | clean | 10 | 19 | PASS |

- **마커 25/25 OK** — 전 직업 latest non-sidebar-fill rev의 change_summary에 top-level `[job-data-master]` 실존. R39형 changeSummary-nested 무마커 사고 0.
- **totalE 전건 ≥19, distinct 전건 ≥10** — 하한 미달 0.
- **audit-sources-deep 9패턴 전수 clean** (origin/orphan/dup/rawURL/brokenRef/markerCluster/listPage/mojibake/idxGap 전부 0). FAIL 0.
- WARN 4건(애니메이션리깅원·애드마스터·애자조립원·액제의약품생산원)은 전부 urlUnverified(TLS) 오탐 — 허용. FAIL 아님.

## 2. KPI 독립 재대사

admin 단일진실 쿼리 직접 재현:
- **실측 KPI = 3221**
- 직전 KPI 3196 + 25 = 예상 3221 → **정확 일치 (편차 0)**

## 3. 집합검증 (rid 범위)

- 이번 cycle 신규 master rev = rid **22464~22512 짝수 25건**, entity_id 25개 distinct = 명단 25 slug와 정확 일치.
- 홀수 rid(22463~22511)는 각 직업의 "원본 버전" baseline 스냅샷(정상 — edit API가 편집 직전 생성).
- rid ≤ 22462 범위에 이번 cycle 집합 없음. rid > 22512 rev **0건**(MAX rid=22512) → latest 뒤집힘 없음.
- **명단 밖 직업 변경(baseline 이탈) = 0.**

## 4. 통계누출 점검 (R112 신규 실패모드)

- 대표 전용 통계수치(라인프로듀서 박스오피스 26.9%/5조615억/90억 등, 액상수화제 수화제·농약 통계)가 형제 비대표 직업(애니 9직·액상정제기) 본문에 재인용됐는지 prod 본문 grep — **검출 0.**

## 5. 산문 복붙 점검 (형제군 pairwise 4-gram Jaccard)

- 애니 10직 C(10,2)=45쌍 + 앰풀 3 + 애자 2 + 액상 2 전 pairwise 실측.
- 최고치: 애니메이션맵핑원:애니메이션합성원 **22.9%**, 애니메이션레이아웃작가:애니메이션시나리오작가 9.2%. 나머지 전부 <5%.
- 경고 임계(0.4)·FAIL 임계(0.5) 초과 쌍 **0** → 복붙 없음.

## 6. sal 미접촉

- 원본 버전 rev + master rev 전 50건 `overviewSalary.sal`/`wage` 전부 NULL — sal 데이터 원래 부재, 신규 유입도 0. **sal 영역 무변경 확정.**

## 최종 판정

| 항목 | 결과 |
|---|---|
| 마커 실존 | 25/25 OK |
| audit FAIL | 0 |
| KPI 실측 | 3221 = 예상 3221 (일치) |
| 집합 이탈 | 0 |
| 통계누출 | 0 |
| 산문 복붙 | 0 (max 22.9% < 0.4) |
| sal 이탈 | 없음 |

**PASS — 사고/이탈 없음.**
