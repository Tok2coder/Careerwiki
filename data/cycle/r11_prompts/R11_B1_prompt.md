# STRICT - 절대 룰 (위반 시 즉시 abort + 보고)

1. **이 batch 직업 명단 외 직업 SELECT/POST/audit 절대 X.**
   - NULL 풀에서 자동 SELECT 절대 X. 명단 5 직업 처리 끝나면 즉시 종료.
2. **PowerShell 절대 X. Bash 만 사용.** PreToolUse hook .claude/hooks/powershell-block.cjs 차단.
3. **자작 스크립트 X.** _cycle*.cjs _generic*.cjs _bulk*.cjs 등 차단됨. 모든 작업 = .claude/skills/job-data-master/SKILL.md Phase 0~7.
4. **WebFetch 우회 X.** URL 등록 전 WebFetch 검증 의무. distinct URL >= 18 + **totalEntries >= 19**.
5. **subagent 병렬 X.** 본 sub-session 내부 직렬.
6. **sal/wage 미접촉.**
7. **AskUser X.**
8. **5 직업 처리 후 종료 형식**: slug | rev_id | distinct_url | totalEntries | industry_class | audit_status 1줄 + BATCH DONE: 5/5 ok 또는 BATCH FAIL: N/5 ok, K fail.
9. **산업 분류 + distinct URL 강제** (SKILL.md 룰 30): major = distinct >= 18 강제, lazy 절충 X. 모호 시 default = major.
10. **URL pool hint + alternate 발굴**: hint site 모두 시도, 1-2 404로 포기 X. minimum 10 site 시도.
11. **Lazy abort 방지**.
12. **본문 보강 의무화**: way / trivia / overviewProspect.main / detailWlb.wlbDetail / detailWlb.socialDetail / overviewWork.main / overviewAbilities.technKnow / summary 빈 영역 반드시 신규 작성. 9 prose 영역 100자+. minimal patch 절대 금지.
13. **Audit 명확화**: urlCountInsufficient(N<18) WARN 감지 시 즉시 추가 발굴. patch 19개 분배 권장. audit WARN 0 / FAIL 0 후 다음 직업.
14. **youtubeLinks 영역 omit 금지**: 모든 master enhance patch는 youtubeLinks 영역 의무 포함. 적합 한국어 영상 있음: youtubeLinks: [{url,title}] (1-3 oembed 검증). 부재: youtubeLinks: [] + _youtubeSearchNote (탐색어 >=6 OR 카테고리 >=3). validate [YouTube-영역누락] FAIL.
15. **totalEntries >= 19 강제** (R10 사후 신규 룰): _sources 총 entry 수 19 이상. distinct URL과 별도로 본문 [N] 인용 위치 자체 늘리거나 새 출처 추가로 >=19 달성.

---

# 처리 대상 5 직업 (R11_B1 - 건전지 5)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
| 1 | 건전지제조현장감독자 | 1765285331720508 | 건전지제조현장감독자 | minor | LG에너지솔루션 (lgensol.com), 삼성SDI (samsungsdi.co.kr), SK온 (sk-on.com), EcoPro (ecopro.co.kr), 한국전지산업협회 (kbia.or.kr), KIAT 산업기술평가관리원, KEIT (keit.re.kr), 산업통상자원부 (motie.go.kr) 이차전지 정책, KOSHA, Q-net 화학공장 안전관리자 |
| 2 | 건전지충전원 | 1765284706773655 | 건전지충전원 | niche | LG에너지솔루션, 삼성SDI, SK온, 한국전지산업협회 (kbia.or.kr), Q-net 화공기능사·산업기사, KOSHA 산업안전, HRD-Net, 산업인력공단, 한국화학공학회 (kiche.or.kr) |
| 3 | 건전지품질검사원 | 1765283891983968 | 건전지품질검사원 | minor | LG에너지솔루션 QC, 삼성SDI QC, SK온 QC, KS 인증 (ksa.or.kr), Q-net 품질경영기사·품질관리기능사, 한국전지산업협회, KIAT, KOSHA |
| 4 | 건전지합제제조원 | 176528533204899 | 건전지합제제조원 | niche | LG에너지솔루션, 삼성SDI, SK온, 에코프로비엠 (ecoprobm.co.kr), 포스코퓨처엠 (poscofuturem.com), 한국전지산업협회, 한국화학공학회, Q-net 화공기능사 |
| 5 | 건전지합제제조현장감독자 | 1765285332344335 | 건전지합제제조현장감독자 | niche | LG에너지솔루션, 삼성SDI, SK온, 에코프로비엠, 포스코퓨처엠, 한국전지산업협회, KIAT, 산업통상자원부 이차전지 정책, KOSHA 화학공장 안전, Q-net |

# 처리 절차

각 직업 순서대로 .claude/skills/job-data-master/SKILL.md Phase 0~7 (ENHANCE 모드, marker_count=0).
- POST: https://careerwiki.org/api/job/{id}/edit + X-Admin-Secret: careerwiki-admin-2026
- POST body: 파일 기반 (인라인 한글 본문 절대 X)
- POST 전 node scripts/validate-job-edit.cjs payload.json 통과 의무
- POST 후 node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal CLEAN 의무
- change_summary: [job-data-master] enhance - way·trivia·detailReady·sidebar·youtubeLinks·...

batch 5 직업 끝나면 즉시 종료. 자동 다음 cycle 진입 X.

# 보고 형식

```
R11_B1 결과:
1. 건전지제조현장감독자      | rev=NNNN | distinct=NN | totalE=NN | minor | CLEAN
2. 건전지충전원              | rev=NNNN | distinct=NN | totalE=NN | niche | CLEAN
3. 건전지품질검사원          | rev=NNNN | distinct=NN | totalE=NN | minor | CLEAN
4. 건전지합제제조원          | rev=NNNN | distinct=NN | totalE=NN | niche | CLEAN
5. 건전지합제제조현장감독자  | rev=NNNN | distinct=NN | totalE=NN | niche | CLEAN

BATCH DONE: 5/5 ok, 0 fail
```
