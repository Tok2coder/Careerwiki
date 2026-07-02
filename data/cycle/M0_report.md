# M0 파일럿 보고 (전공 M-cycle first-blood, 2026-07-02)

## 결과: 5/5 PASS · KPI 0→5 (+5 정확 일치, dispatcher 사전 실측 + opus 검증 재실측 이중 확인)

| slug | latest_rev | 마커 | totalE | distinct | 산문 w/h/j 글자수 | prod | audit |
|---|---|---|---|---|---|---|---|
| 컴퓨터공학과 | 20112 | OK | 12~13* | 9~10 | 587/610/508 | 200+각주9 | clean |
| 기계공학과 | 20114 | OK | 14 | 8~9 | 653/561/590 | 200+각주10 | clean |
| 사회복지학과 | 20116 | OK | 14 | 8 | 631/707/575 | 200+각주10 | clean |
| 유아교육학과 | 20118 | OK | 13 | 8 | 528/640/630 | 200+각주9 | clean |
| 식품영양학과 | 20120 | OK | 13 | 8 | 567/608/561 | 200+각주9 | clean |

*컴퓨터공학과 totalE·distinct는 배치(13/9)와 검증(12/10) 보고가 ±1 편차 — 집계 방식 차이로 추정, 게이트(≥12/≥8) 양쪽 기준 모두 통과라 비차단. 수치 편차 원인은 M1에서 카운트 기준 단일화로 후속.

## P0 체크 (설계서 §7) — 전 항목 통과
1. **API first-blood** ✅ — /api/major/{id}/edit 실전 최초 POST 정상 (rev 생성·마커·_sources 반영)
2. **merge 반영** ✅ — 산문 3필드 merged 등장, 전건 300자+(최소 508)
3. **각주 실렌더** ✅ — prod 5/5 user-footnote-ref sup 9~10개
4. **KPI +5 정확** ✅ — 단일진실 쿼리 5 (이중 실측)
5. **보호영역 비접촉** ✅ — UCJ에 보호 키·trivia 부재, merged universities/chartData 무손상
6. **게이트 현실성** ✅ — 확정: totalE≥12 / distinct≥8 / 산문 300자 유지 (실측 여유 확인)
7. **네거티브 게이트** ✅ — 빌드 단계에서 FAIL 3종 발화 실측 완료

## 사고와 수습
- 1차 opus 검증 세션 session limit 사망(리셋 8:40pm) → DB 실측(rev>20120=0, 수정 POST 0건) 확인 후 재spawn — 중복 0, 데이터 영향 0.
- rev 2간격 의심 → 규명: first-blood 시 편집 전 baseline 자동 스냅샷(홀수 rev) + enhance 마커 rev(짝수) 쌍 = 정상 메커니즘. latest=마커라 KPI 무영향.

## 부작용 없음
보호영역·직업(job) 데이터 미접촉, origin 도메인 0, 검색/root URL 0, 42 distinct URL 전건 live, 복붙 Jaccard 전 쌍 <30%.

## 확인
- admin: https://careerwiki.org/admin/job-equalize?tab=major (skillApplied=5)
- 표본: https://careerwiki.org/major/컴퓨터공학과 · /major/사회복지학과 · /major/식품영양학과
