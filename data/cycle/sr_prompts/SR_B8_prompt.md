# STRICT - 절대 룰 (위반 시 즉시 abort + 보고)

1. **이 batch 직업 명단 외 직업 SELECT/POST/audit 절대 X.**
   - NULL 풀에서 자동 SELECT 절대 X. 명단 5 직업 처리 끝나면 즉시 종료.
2. **PowerShell 절대 X. Bash 만 사용.** PreToolUse hook .claude/hooks/powershell-block.cjs 차단.
3. **자작 스크립트 X.** _cycle*.cjs _generic*.cjs _bulk*.cjs 등 차단됨. 모든 작업 = .claude/skills/job-data-master/SKILL.md Phase 0~7.
4. **WebFetch 우회 X.** URL 등록 전 WebFetch 검증 의무. distinct URL >= 18 + **totalEntries >= 19** (룰 Z 강화).
5. **subagent 병렬 X.** 본 sub-session 내부 직렬.
6. **sal/wage 미접촉.**
7. **AskUser X.**
8. **5 직업 처리 후 종료 형식**: slug | rev_id | distinct_url | totalEntries | industry_class | audit_status 1줄 + BATCH DONE: 5/5 ok 또는 BATCH FAIL: N/5 ok, K fail.
9. **산업 분류 + distinct URL 강제** (SKILL.md 룰 30): major = distinct >= 18 강제, lazy 절충 X. 모호 시 default = major.
10. **URL pool hint + alternate 발굴**: hint site 모두 시도, 1-2 404로 포기 X. minimum 10 site 시도.
11. **Lazy abort 방지**: 사전 abort X.
12. **본문 보강 의무화**: way / trivia / overviewProspect.main / detailWlb.wlbDetail / detailWlb.socialDetail / overviewWork.main / overviewAbilities.technKnow / summary 빈/부족 영역 반드시 신규 작성. 9 prose 영역 100자+. minimal patch 절대 금지.
13. **Audit 명확화**: urlCountInsufficient(N<18) WARN 감지 시 즉시 추가 발굴. patch 19개 분배 권장. audit WARN 0 / FAIL 0 후 다음 직업.
14. **youtubeLinks 영역 omit 금지 (2026-05-26)**: 모든 master enhance/force-enhance patch는 youtubeLinks 영역 의무 포함. 적합 한국어 영상 있음: youtubeLinks: [{url,title}] (1-3 oembed 검증). 부재: youtubeLinks: [] + _youtubeSearchNote (탐색어 >=6 OR 카테고리 >=3). validate [YouTube-영역누락] FAIL.
15. **totalEntries >= 19 강제 (SR cycle 신규 룰)**: 본 cycle 목적은 _sources 총 entry 수 19 이상 보강. 기존 distinct URL과 별도로, 본문 [N] 인용 위치 자체를 늘리거나 새 출처 항목 추가로 >=19 달성. minimal patch (totalEntries 변동 없음) 금지.

---

# 처리 대상 5 직업 (SR_B8 - SR cycle / totalEntries < 19 보강)

이미 master 풀 enhance 적용된 직업이지만 **totalEntries < 19** 상태. **--force-enhance** 모드로 **totalEntries >= 19, distinct >= 18** 강제.

| # | name | id | slug | before | URL pool hint |
|---|---|---|---|---|---|
| 1 | 사회학연구원 | 1765283321689634 | 사회학연구원 | (before: totalE=17, distinct=14) | 한국 1차 정부 협회 기업 언론 deep |
| 2 | 선물큐레이터 | 1765284790444847 | 선물큐레이터 | (before: totalE=16, distinct=10) | 한국 1차 정부 협회 기업 언론 deep |
| 3 | 세라믹소재연구원 | 1765283824185438 | 세라믹소재연구원 | (before: totalE=17, distinct=17) | 한국 1차 정부 협회 기업 언론 deep |
| 4 | 소모반장 | 176528491203449 | 소모반장 | (before: totalE=16, distinct=8) | 한국 1차 정부 협회 기업 언론 deep |
| 5 | 쇼핑호스트 | 1765283331082680 | 쇼핑호스트 | (before: totalE=16, distinct=10) | 한국 1차 정부 협회 기업 언론 deep |

# 처리 절차

각 직업 순서대로 .claude/skills/job-data-master/SKILL.md Phase 0~7 + --force-enhance 모드.
- POST: https://careerwiki.org/api/job/{id}/edit + X-Admin-Secret: careerwiki-admin-2026
- POST body: 파일 기반 (인라인 한글 본문 절대 X — mojibake-block hook)
- POST 전 node scripts/validate-job-edit.cjs payload.json 통과 의무
- POST 후 node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal CLEAN 의무
- change_summary: [job-data-master] force-enhance — sources<19 보강, totalE {before}→{after}, distinct {before}→{after}

# 보강 우선순위 (totalEntries >= 19 달성 패턴)

1. **distinct URL 추가 발굴** (1차) - 한국 정부 협회 기업 언론 deep URL 8-12개 추가 → 자동으로 totalEntries 증가
2. **본문 [N] 마커 추가 인용** - 기존 출처의 fact를 본문에서 추가 위치에 인용 (1 URL → 2-3 [N] 분산)
3. **detailReady array 보강** - curriculum/recruit/training 항목 추가 시 항목별 [N] 출처
4. **9 prose 영역 본문 expand + [N] 추가**

기존 데이터 보존 우선. 부족한 부분만 추가. 마커 갯수 감소 절대 금지 (detectArrayMarkerCountDecrease).

# 보고 형식

```
SR_B8 결과:
1. {slug1}  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN
2. {slug2}  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN
3. {slug3}  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN
4. {slug4}  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN
5. {slug5}  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN

BATCH DONE: 5/5 ok, 0 fail
```