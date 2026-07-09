# R72 Cycle 보고 (2026-07-09)

## 한 일
- R72 (버터교유기조작원~벽돌판매원, 25직업) master enhance. foreground 5배치(sonnet) 동시 + opus 이원화 검증.
- preflight 3종 실측(KPI 2182 / max rev 20377 / rev>max master 0건 = 미착수)로 상태 무결 확인 후 착수.

## 결과
| 항목 | 값 |
|---|---|
| 완료 | **25/25** (마커 전건 OK) |
| audit / verify-cycle | FAIL 0 (PASS 17 / WARN 8=urlUnverified) |
| totalE (최소) | 19 (전건 ≥19) |
| distinct | niche 10~13 / major 18~19 (전건 하한 충족) |
| 복붙 (Jaccard) | 벨트 3공정 max 8.6%, 버터 2종 pool 분리 |
| URL / origin | careerwiki.org 도메인만, origin 자기인용 0 |
| rev 범위 | 20383~20427 (+검증 fix 20428) |

## 사고와 수습
- 사고 0 (리밋·세션사망·오탐 abort 없음, 단판 완주).
- urlUnverified WARN 8건 → opus 검증세션 node GET 재검 3분류:
  - **7 거짓양성 유지**: schannel TLS(shoenet/kst-tct/korapis/ifds 200) + KCI(kci.go.kr) 학술DB timeout(200, 91~197KB 정상 콘텐츠).
  - **1 진짜 soft-404 교체**: 번역물품질관리사무원 recruit 출처 `kstinc.or.kr idx=305`(삭제 공지 빈셸 311자) → 같은 협회 live `idx=4084`(7798자)로 교체. fix POST rev 20428, `[job-data-master]` 마커 유지 → KPI 무영향.

## 부작용 없음
- baseline 이탈 0, sal/wage 미접촉, 명단 밖 직업 무접촉, fix POST 직업당 1회.

## KPI
- **2207** (예상 2182+25 = 2207 정확 일치, admin 단일진실 쿼리 이중 실측).
- fix rev 20428도 마커 유지 확인 → latest=master 보존, KPI 무손실.

## 확인 방법
- admin: https://careerwiki.org/admin (job-equalize 탭 KPI 2207)
- 표본: careerwiki.org/job/법의학자 · careerwiki.org/job/벨트여과기조작원 · careerwiki.org/job/번역물품질관리사무원

## 다음
- R73은 go 주면 시작 (예상 KPI 2232, 시작=벽돌판매원 다음).
