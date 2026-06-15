# R49 cycle 보고 (2026-06-14)

## 한 일
- R49 = 만화영화연출가~매트리스포장원 25직업 master enhance (v5 배치). Workflow 5배치 병렬(sonnet) → 검증세션(sonnet). **리밋 없이 단판 완주.**
- 검증서 dead URL 2직업 적발 → dead URL 수습 세션(sonnet) 추가 실행.

## 결과
- **25/25 처리. 실제 데이터 결함 0(수습 후).**
- 검증 raw 22 PASS / 3 "FAIL" → dispatcher node fetch 독립 재검:
  - 매립가스발전장치조작원(power-technology.com 403): 브라우저 UA로 200 → anti-bot 거짓양성, 정상.
  - 만화컬러작가(namu.wiki 404 ×2)·만화펜터치작가(namu.wiki 404 ×1): **진짜 dead(루트 302 생존, 해당 페이지만 실존 안 함 — URL 환각 패턴)** → 수습.
- 수습: namu.wiki 404 → brunch.co.kr(302→200 실글)·fnnews.com(200) live 출처로 교체(rev 19125·19126). urlDead 0, 마커 OK, KPI 불변 확인.
- marker 전건 OK / distinct 전건 ≥10(최소 10: 매너강사) / totalE 전건 ≥19(최소 23) / sal 미접촉.

## 사고와 수습
- **URL 환각 2직업(만화컬러/펜터치작가)**: 배치 세션이 실존하지 않는 namu.wiki `/w/채색작가`·`/w/만화컬러작가` 페이지를 출처로 등록. 검증세션 urlDead 게이트가 적발 → dispatcher node fetch로 진짜 dead 확정(거짓양성과 구분) → 수습 세션이 WebFetch 검증된 live 한국 출처로 교체. **게이트+수습 루프 정상 작동.**

## 부작용 없음
- baseline 이탈 0, sal/wage 미접촉, 명단 밖 직업 미접촉.

## KPI (단일 진실)
- 1607 → **1632** (+25, 예상 정확 일치). DB 독립 재실측: 신규 25 distinct / max master rev 19126(수습 포함).

## 회고 (비차단)
- **dup rev 3건(룰C 잉여 재POST)**: 망관리기술연구원·매너강사·매장-매니저가 동일 changeSummary 반복 POST. latest 마커 정상 → KPI·데이터 무영향. R44(9건)→R49(3건) 감소 추세, POST 전 셀프게이트 강조 지속.
- **출처 강도**: 만화 niche 2직업 교체 출처가 brunch(UGC) — live+관련이나 약함. 권위 출처 확보 시 격상 후보.
- **namu.wiki 함정**: `/w/{제목}` 페이지는 그럴듯하지만 실존 안 하는 경우 多 → WebFetch 검증 필수(STRICT 룰 기존 커버, urlDead 게이트가 backstop).

## 확인 방법
- admin job-equalize KPI = 1632.
- 표본: careerwiki.org/job/매장-매니저 · careerwiki.org/job/만화영화연출가 · careerwiki.org/job/만화컬러작가

## 다음
- **R50 자동 착수 안 함**(go-gate). R50(매트리스포장원 다음 가나다 순)는 go 주면 시작.
