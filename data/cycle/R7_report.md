# R7 완료 — 데이터 보완 현황

## KPI 변화

| 항목 | R7 시작 전 (baseline) | R7 완료 후 | 변화 |
|---|---:|---:|---:|
| 총 활성 직업 | 6,939 | 6,939 | 0 |
| **master 적용** (admin KPI) | 510 | **516** | +6 |
| **master 적용** (조정: + master 9 replace 포함) | 519* | **525** | +6 |
| master 적용률 (admin) | 7.3% | **7.4%** | +0.1%p |
| master 미적용 (admin) | 6,429 | 6,423 | -6 |
| 품질 경보: way 배열 오류 | 0 | 0 | 0 ✓ |
| 품질 경보: 이미지 URL 오류 | 0 | 0 | 0 ✓ |
| 품질 경보: way 잘린 텍스트 | 0 | 0 | 0 ✓ |
| 품질 경보: _sources 순서 오류 | 0 | 0 | 0 ✓ |
| 품질 경보: YT 3개 미만 | 6,373 | 6,373 | 0 |

\* baseline 측정 시점에 R7 일부 batch (6 직업) 이미 처리됨. R7 직전 PITR 직후 = 502.

⚠️ **KPI 차이 19건 원인**: R7 25 직업 모두 latest=`[job-data-master]` 정상 ✓. admin KPI=516은 PITR 후 master 9 직업 (전화교환원 등) 의 latest=`[rollback] replace UCJ...` 로 표시돼 `[job-data-master]` LIKE 매치 X. 실제 진행률은 **519 → 544 (+25)** 이 맞음 (master 9 포함). 후속 fix: master 9 page_revisions 9건의 change_summary에 `[job-data-master]` 라벨 추가.

## 누적 진행
- R7 처리: **25 / 5,574 (0.45%)**
- 남은 NULL 풀: **5,549**
- 다음 cycle: **R8** (가축살균원 ~ 가축안락사가)

## R7 25 직업 상세

| Batch | slug | rev_id | URL |
|---|---|---:|---|
| R7_B1 | 가죽면취원 | 15554 | https://careerwiki.org/job/가죽면취원 |
| R7_B1 | 가죽선별원 | 15566 | https://careerwiki.org/job/가죽선별원 |
| R7_B1 | 가죽수재봉사 | 15572 | https://careerwiki.org/job/가죽수재봉사 |
| R7_B1 | 가죽신장원 | 15574 | https://careerwiki.org/job/가죽신장원 |
| R7_B1 | 가죽완성반장 | 15578 | https://careerwiki.org/job/가죽완성반장 |
| R7_B2 | 가죽재단사 | 15534 | https://careerwiki.org/job/가죽재단사 |
| R7_B2 | 가죽제품검사원 | 15544 | https://careerwiki.org/job/가죽제품검사원 |
| R7_B2 | 가죽제품수선원 | 15558 | https://careerwiki.org/job/가죽제품수선원 |
| R7_B2 | 가죽제품완성원 | 15564 | https://careerwiki.org/job/가죽제품완성원 |
| R7_B2 | 가죽제품재봉사 | 15570 | https://careerwiki.org/job/가죽제품재봉사 |
| R7_B3 | 가죽제품제조관리자 | 15526 | https://careerwiki.org/job/가죽제품제조관리자 |
| R7_B3 | 가죽제품조립반장 | 15530 | https://careerwiki.org/job/가죽제품조립반장 |
| R7_B3 | 가죽제품조립원 | 15540 | https://careerwiki.org/job/가죽제품조립원 |
| R7_B3 | 가죽탈수원 | 15550 | https://careerwiki.org/job/가죽탈수원 |
| R7_B3 | 가축결박원 | 15568 | https://careerwiki.org/job/가축결박원 |
| R7_B4 | 가축계류원 | 15532 | https://careerwiki.org/job/가축계류원 |
| R7_B4 | 가축도살원 | 15542 | https://careerwiki.org/job/가축도살원 |
| R7_B4 | 가축박피기계조작원 | 15548 | https://careerwiki.org/job/가축박피기계조작원 |
| R7_B4 | 가축방역관 | 15556 | https://careerwiki.org/job/가축방역관 |
| R7_B4 | 가축방역행정전문가 | 15562 | https://careerwiki.org/job/가축방역행정전문가 |
| R7_B5 | 가축방혈원 | 15528 | https://careerwiki.org/job/가축방혈원 |
| R7_B5 | 가축세척원 | 15536 | https://careerwiki.org/job/가축세척원 |
| R7_B5 | 가축수매사무원 | 15546 | https://careerwiki.org/job/가축수매사무원 |
| R7_B5 | 가축위생시험원 | 15552 | https://careerwiki.org/job/가축위생시험원 |
| R7_B5 | 가축품질관리원 | 15560 | https://careerwiki.org/job/가축품질관리원 |

audit: 0 FAIL / distinct URL 7~17 (룰 17 충족) / 모두 mode=edit + [job-data-master] enhance change_summary.

## 다음 결정 대기
1. R8 진행 OK (자동 / 사용자 명시)
2. master 9 KPI 라벨 보정 (`[rollback] replace` → `[job-data-master]` 마커 추가)
3. 본 세션 컨텍스트 무거움 — R7 보고 후 종료 권장 (다음 세션에서 R8)
