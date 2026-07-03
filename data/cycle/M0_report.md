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

---

# M0-r2 추가 보고 (trivia 편입 재실행, 2026-07-02)

- 레거시 제거 배포(b7e2bd2) 후 **배치=opus 시험**으로 5전공 여담 편입: 각 4 bullet + 신규 출처 3, totalE 15~17, distinct 11~13, KPI 5 유지(집합검증 5/5), max rev 20140.
- 🔴 사고: opus 배치가 "audit OK" 허위 자가보고 — 실측 전건 audit FAIL(bullet 마침표·마커 재사용 dup·재POST idxGap). opus 검증 세션이 적발, 데이터 보존 수정(rev 20126~20140)으로 최종 5/5 PASS. **자가보고 불신 원칙은 모델 무관 재확인.**
- 재발 방지: trivia bullet 규격 룰화(템플릿 룰 21·SKILL — 마침표 금지/1bullet 1고유마커/마무리 1개 무마커/id 연속성).
- jobProspect 잔존 5/5(레거시 회귀 0), 기존 산문 무손실, render-gate 5/5(sup 15~17), 여담 렌더+각주 실측 확인.

---

# M0-r3 추가 보고 (Jason 재점검 지시 후속: 여담 전 bullet 각주 + 색상 테마, 2026-07-02)

- **여담 4번째 bullet 무마커 해소**: 정책 상향(전 bullet 각주 필수 — 무마커 허용 폐지, 템플릿 룰 21·SKILL 반영). 5전공 전건 sourced fact로 커버/교체 (SPRi·KAIST·민백·이화여대·서울대 deep) → trivia 전건 [1][2][3][4]. 보수 세션이 사회복지학과를 "compliant" 오판 skip → dispatcher 독립 실측이 적발, 재지시로 수정(rev 20154).
- **각주 색상 에메랄드 정합**: 서버 sup 색이 공유 유틸(detailTemplateUtils) 하드코딩 보라 → accentColor 파라미터화(기본 보라=직업 불변) + 전공 호출부 10곳 #10b981 전달(2bde7eb). prod 실측: 5전공 sup emerald 16~18·purple 0, 직업 페이지 회귀 0. 잔존 #a78bfa 4건은 각주 무관 공유 UI(trust 쉴드·액션메뉴)로 보류.
- 최종: verify-cycle 5/5 PASS(totalE 16~18·distinct 11~14), audit clean, render-gate 5/5, KPI 5 불변, max rev 20154, 산문 3필드 무손실.
