# 🚨 STRICT — 절대 룰 (위반 시 즉시 abort + 보고)

1. **이 batch 직업 명단 외 직업 SELECT/POST/audit 절대 X.**
   - NULL 풀에서 가나다순 다음 직업 자동 SELECT 절대 X.
   - 명단 5 직업 처리 끝나면 즉시 종료. 새 cycle / Phase 재진입으로 자동 다른 직업 X.

2. **PowerShell 절대 X. Bash 만 사용.**
   - Windows 환경도 Bash (Git Bash, WSL). PowerShell / pwsh / Invoke-RestMethod 호출 X.
   - PreToolUse hook `.claude/hooks/powershell-block.cjs` 가 차단함 — exit 2.

3. **자작 스크립트 X.**
   - `_cycle*.cjs` `_generic*.cjs` `_bulk*.cjs` `_pool*.cjs` `_mass*.cjs` `_force-enhance*.cjs` 등 차단됨.
   - PreToolUse hook `.claude/hooks/cycle-script-block.cjs` 가 차단함 — exit 2.
   - 모든 작업 = `.claude/skills/job-data-master/SKILL.md` Phase 0~7 흐름만.

4. **WebFetch 우회 X.**
   - URL 등록 전 WebFetch 검증 의무. fabricated URL 등록 절대 X.
   - distinct URL ≥ 18 (룰 Z).

5. **subagent 병렬 X.**
   - 본 sub-session 내부 직렬 처리. fan-out 사고 (75 fan-out / 172M token) 재발 방지.

6. **sal/wage 미접촉.**
   - `fields.overviewSalary` / `sources["overviewSalary.sal"]` 절대 손대지 X.

7. **AskUser X.**
   - 막힘 시 텍스트로 상태 보고 후 abort. user 응답 대기 형태 prompt X.

8. **5 직업 처리 후 종료 형식**: 각 직업별 `slug | rev_id | distinct_url | industry_class (niche/minor/major) | audit_status` 1줄 + 마지막 `BATCH DONE: 5/5 ok, 0 fail` 또는 `BATCH FAIL: N/5 ok, K fail` 형식.

9. **🚨 산업 분류 + distinct URL 강제** (SKILL.md 룰 30):
   - 각 직업별 industry_class 명시: `niche` (단일 공정·공장 직업) / `minor` (소규모 산업) / `major` (금융·IT·법조·항공·항만·반도체·자동차·통신·에너지·의료·교육 등 광범위)
   - **major 산업 = distinct ≥ 18 발굴 의무. lazy 절충 X.**
   - niche 절충 (distinct <18 허용) 은 단일 회사·공정 + URL pool 8~10개 모두 시도 후만 가능
   - **산업 분류 모호 시 default = major** (pool 발굴 시도 의무, niche 절충 default 금지)

10. **🚨 URL pool hint 활용 의무 + alternate 발굴 (lazy 포기 X)**:
    - dispatcher가 prepend한 URL pool hint site는 **모두 시도 의무**
    - 1-2 ECONNREFUSED / 404 만나도 즉시 포기 X — 다른 deep page / alternate URL 시도
    - hint site의 다른 페이지 (예: 메인 404면 deep article·정책 페이지·통계 페이지 등) 시도
    - 산업 표준 기관·정부 deep page·deep article·자격증 페이지·학회 발표자료 등 alternate pool 활용
    - hint 외 추가 발굴도 OK (한국 1차 출처 우선)

11. **🚨 Lazy abort 방지** (2026-05-25 신규, 사용자 명시):
    - 작업 시작 전 "5 직업 모두 niche 같음" / "scope 비현실적" 자체 판단 → **사전 abort 절대 X**
    - 1차 시도 URL pool 부족 → 즉시 pool-limited 절충 X. **추가 8~10개 site 시도 의무**.
    - 막힘 발생 시 텍스트 보고 + abort 가능. 단 **작업 시작 전 / 1차 시도 후 사전 abort 절대 X**.
    - "alternate URL 없음" 결론 전 minimum 10 site 시도 의무.

12. **🚨 본문 보강 의무화** (2026-05-25 신규):
    - `way="" or trivia="" / overviewProspect.main="" / detailWlb.wlbDetail="" / detailWlb.socialDetail="" / overviewWork.main="" / overviewAbilities.technKnow="" / summary=""` 빈 영역은 **반드시 신규 작성** (output-only patch X)
    - **9 prose 영역 모두 100자+ 작성 의무** (way·trivia·overviewProspect.main·detailWlb.wlbDetail·detailWlb.socialDetail·overviewWork.main·overviewAbilities.technKnow·summary·overviewAbilities.abilityList)
    - **출처만 추가하고 본문 안 채우는 minimal patch 절대 금지** (룰 ZZ FAIL 트리거)

13. **🚨 Audit 명확화** (2026-05-25 신규):
    - `audit-via-api` 의 `urlCountInsufficient(N<18)` WARN 감지 시 **즉시 자기 인지 + 추가 발굴**
    - patch distinct 와 audit count는 1 offset 가능 → **patch 19개 분배 권장 (안전 마진, distinct 19 → audit 18)**
    - audit WARN 무시 X (FAIL 아니라도 distinct 부족 신호 = 즉시 추가 발굴 trigger)
    - audit 통과 (WARN 0 / FAIL 0) 후만 다음 직업 진입

14. **🚨 youtubeLinks 영역 omit 금지** (2026-05-26 신규):
    - 5/23~26 dispatch 171 직업 master 적용 후에도 ytLow 잔존 사고 root cause = patch에서 youtubeLinks 영역 자체 누락.
    - 모든 master enhance patch는 `youtubeLinks` 영역 **의무 포함**:
      a. 적합 한국어 영상 있음 → `youtubeLinks: [{url, title}]` (1~3개, oembed 200 + title 매칭 verify, 한국어만)
      b. 한국어 영상 부재 → `youtubeLinks: []` + `_youtubeSearchNote` (탐색어 ≥6개 OR 카테고리 ≥3개 / 현직자·인터뷰·직무·실무·강의·교육·진로·면접)
    - validate `[YouTube-영역누락]` FAIL — omit 시 차단됨.
    - 면제: change_summary에 `yt-fill` / `cleanup` / `--field-only=` 명시 부분 보강 모드만.

15. **🚨 totalEntries ≥ 19 강제** (2026-05-27 신규, SR cycle 사후):
    - `_sources` 총 entry 수 (모든 fieldKey의 entry 합산) **≥ 19** 필수.
    - distinct URL ≥ 18과 별개로, 본문 [N] 인용 위치 수 자체를 늘리거나 새 출처 항목 추가로 ≥19 달성.
    - minimal patch (totalEntries 변동 없음) 금지.
    - 보강 패턴: (a) distinct URL 추가 (1차) (b) 본문 [N] 마커 추가 인용 (1 URL → 2-3 위치 분산) (c) detailReady array 항목 추가 시 항목별 [N] (d) 9 prose 영역 본문 expand + [N] 추가.

16. **🚨 AskUser tool 호출 절대 금지** (2026-05-28 신규, R11_B2 사고 후속):
    - 작업 규모 클 거라고 우려 보고 X
    - "단일 응답 안에서 안전한지" 평가 X — 그냥 직진 처리
    - 5 직업 단일 응답으로 안되면 multi-turn으로 처리하되 AskUser는 절대 X
    - 진행 방식 결정 X — prompt 지시 그대로 따름
    - 위반 시 dispatcher 재지시 받기 전까지 batch fail로 간주
    - 2026-05-28 사고: R11_B2 sub-agent (건축 5 직업) 가 "작업 규모 크다"고 AskUser 호출 → 다른 4 batch는 같은 분량 잘 처리 중. dispatcher 재지시 30분 지체 후 정상 완료.

---

---

# 처리 대상 5 직업 (R12_B3 — ENHANCE 모드, marker 미보유 신규)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
| 1 | 게임 운영자 | 176528371423561 | 게임-운영자 | (sub-agent 자체 분류: niche/minor/major) | 한국 1차 정부·협회·기업·언론 deep — slug별 도메인 자동 발굴 |
| 2 | 게임 이펙트 디자이너 | 1765284210650171 | 게임-이펙트-디자이너 | (sub-agent 자체 분류: niche/minor/major) | 한국 1차 정부·협회·기업·언론 deep — slug별 도메인 자동 발굴 |
| 3 | 게임 캐릭터원화 디자이너 | 1765284211087338 | 게임-캐릭터원화-디자이너 | (sub-agent 자체 분류: niche/minor/major) | 한국 1차 정부·협회·기업·언론 deep — slug별 도메인 자동 발굴 |
| 4 | 게임 클라이언트 프로그래머 | 1765283706287951 | 게임-클라이언트-프로그래머 | (sub-agent 자체 분류: niche/minor/major) | 한국 1차 정부·협회·기업·언론 deep — slug별 도메인 자동 발굴 |
| 5 | 게임 플랫폼 사업 기획자 | 1765284093749716 | 게임-플랫폼-사업-기획자 | (sub-agent 자체 분류: niche/minor/major) | 한국 1차 정부·협회·기업·언론 deep — slug별 도메인 자동 발굴 |

# 처리 절차

각 직업 순서대로 `.claude/skills/job-data-master/SKILL.md` Phase 0~7 흐름 (ENHANCE 모드).
- POST: `https://careerwiki.org/api/job/{id}/edit` + `X-Admin-Secret: careerwiki-admin-2026`
- POST body: 파일 기반 (인라인 한글 본문 절대 X — mojibake-block hook)
- POST 전 `node scripts/validate-job-edit.cjs payload.json` 통과 의무
- POST 후 `node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal` CLEAN 의무
- change_summary: `[job-data-master] enhance — way·trivia·detailReady·sidebar·youtubeLinks·...`
- distinct URL ≥ 18 + totalEntries ≥ 19 강제 (룰 4·15)

배치 5 직업 끝나면 즉시 종료. 자동 다음 cycle 진입 X.

# 보고 형식

```
R12_B3 결과:
1. 게임-운영자  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN
2. 게임-이펙트-디자이너  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN
3. 게임-캐릭터원화-디자이너  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN
4. 게임-클라이언트-프로그래머  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN
5. 게임-플랫폼-사업-기획자  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN

BATCH DONE: 5/5 ok, 0 fail
```
