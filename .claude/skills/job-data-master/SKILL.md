---
name: job-data-master
description: >
  CareerWiki 직업 데이터 통합 관리 스킬 (enhance + cleanup MECE 통합, ultimate).
  단일 entry point — 직업 상태별 자동 분기로 신규 enhance / cleanup / fact 정정 / 산문 영역 보강을 모두 처리한다.
  유저가 "직업 데이터 보완", "균등화", "equalize", "부실 직업", "NULL 직업", "데이터 채워줘",
  "직업 데이터 업데이트", "배치 처리", "품질 고도화", "정보보완", "출처 정리", "각주 정리",
  "마커 정리", "audit FAIL fix", "rootURL 수정", "sidebarSources 제거", "wikiQuota 줄이기",
  "origin 잔존 정리", "orderViolation fix", "fact 정정", "산문 영역 보강", "job data master",
  "trivia 수정", "footnote fix", "quality repair", "orphan marker", "고아 마커", "Phase 5",
  "정신건강의학전문의사 보완", "직업 보완 X명", "32M 토큰 풀 dispatch" 등 어떤 표현을 써도
  반드시 이 스킬을 사용한다. 단일 직업이든 수백 개 배치든 본 스킬이 처리한다.
  job-data-enhance와 job-data-cleanup은 archive로 보존되며 본 스킬이 supersede한다.
---

# CareerWiki 직업 데이터 master 스킬

기존 두 스킬 (`job-data-enhance`, `job-data-cleanup`)을 통합한 단일 entry point. 직업 상태와 audit 결과에 따라 자동 분기하여 신규 enhance / cleanup / fact 정정 / 산문 영역 보강을 모두 처리한다.

> 📌 **archive**: 기존 두 스킬은 `.claude/skills/_archive/job-data-enhance/` + `.claude/skills/_archive/job-data-cleanup/`에 그대로 보존됨. 과거 사례/룰 reference로만 사용. 새 작업은 본 스킬 사용 강제.

> 📚 **reference docs** (작업 중 의문 발생 시 참조):
> - `reference/phase-flow.md` — Phase 0~7 상세 + 자동 분기 로직
> - `reference/fix-patterns.md` — 룰별 fix 패턴 + 4단계 fallback (산문 / array / sidebar 영역별)
> - `reference/safety-rules.md` — 15 안전 룰 + 보호 영역 + hallucinated 도메인 블랙리스트 + 검증된 도메인 화이트리스트
> - `reference/area-classification.md` — 산문 / detailReady array / sidebar 영역별 정책 + UCJ 룰 영향
> - `reference/fact-verification.md` — 본문 fact 정확성 검증 (WebSearch cross-check, 사고 사례 인용)
> - `reference/enhance-fields-spec.md` — enhance 모드 12 필드 상세 spec (way / detailReady / trivia / wlbDetail / sidebarCerts / careerTree / heroTags / youtubeLinks 등)
> - `reference/enhance-strict-rules.md` — **archive enhance 본문 통합** (출처·사실성 철칙 + 핵심 기술 규칙 표 30+ 룰 + 4 카테고리 판단 매트릭스 + 출처 수집 규칙 + 무출처 문장 처리 절차 + 기존 콘텐츠 보존 F3 + 차단 사이트 폴백 체인)
> - `reference/enhance-phase-procedures.md` — **archive enhance 본문 통합** (Phase 0-PRE START_TRACKING / 0-MODE / 0-DIAG / 0-A~F / 1-PRE / Gate 0~4 / 3.5 Self-check / 3-A validate 10가지 / 3-B 편집 API / 4-MARKER 마커 뭉침 금지 / 5-DEDUP / 5-AUDIT / 5-VERIFY / END_TRACKING)
> - `reference/user-expectation.md` — 사용자가 본 스킬 호출 시 기대할 수 있는 결과 (시나리오 4종 / 비용 / 보호 영역 / 직접 검증)

---

## When to use

모든 직업 데이터 작업의 단일 entry point:
- 신규 enhance (마커 미보유 직업)
- partial enhance (이미 enhance + 일부 필드만 보강)
- cleanup (audit FAIL 정리)
- 본문 fact 정정 (WebSearch cross-check 사고 발견 시)
- 산문 영역 보강 (proseBodyOrphan 룰 검출)
- 배치 처리 (multiple slug)

키워드 트리거 (description의 모든 키워드 포함). 단일 직업이든 332+ 풀 배치든 본 스킬이 처리.

## When NOT to use

- 신규 직업 추가 (없는 직업 생성) → `job-data-create` 스킬
- HowTo 가이드 작업 → `howto-publish` 스킬

---

## Auto-branching (진입 시 자동 분기)

직업 상태 + audit 결과에 따라 4 모드 자동 분기:

```
1. is_active=0 (비활성)              → SKIP (작업 X, 보고만)
2. [job-data-master] OR [job-data-enhance] 마커 보유 + audit CLEAN  → IDLE (DONE 즉시)
3. [job-data-master] OR [job-data-enhance] 마커 보유 + audit FAIL   → CLEANUP 모드
4. 마커 미보유 + active                → ENHANCE 모드 (풀 사이클)
```

**판정 SQL** (Phase 0-A에서 실행):
```sql
SELECT id, slug, name, is_active,
  (SELECT COUNT(*) FROM page_revisions
   WHERE entity_type='job' AND entity_id=CAST(j.id AS TEXT)
     AND (change_summary LIKE '%[job-data-master]%' OR change_summary LIKE '%[job-data-enhance]%')) AS marker_count
FROM jobs j WHERE slug = ?;
```

→ `is_active=0` → SKIP. `marker_count=0` → ENHANCE. `marker_count≥1` → audit-via-api 실행 후 CLEAN/FAIL 분기.

### `--force-enhance` 옵션 (2026-05-09 신규, archive enhance 풀 통합)

audit CLEAN이어도 **enhance 사이클을 강제 실행**하는 옵션. 사용 case:
- cluster 패턴 데이터 (1 출처 + N 항목 + 마지막 항목만 [N]) — audit는 CLEAN이지만 룰 X/Y WARN level 검출 → quality 회복 필요
- detailReady 출처 0개 직업 (감정평가사 / 경찰관 등) — audit CLEAN이지만 quality 부족
- 기존 enhance가 옛 룰에서 박혀 retroactive 보강 필요

> 🚀 **archive enhance 본래 capability 그대로 적용 (2026-05-09)**: `--force-enhance`는 마커 미보유 ENHANCE와 **동일한 풀 사이클**을 실행. archive `job-data-enhance`가 신규 직업에 했던 모든 작업 (12 필드 진단 / 17 필드 작성 / careerTree 신규 작성 / 본문 expand / detailReady 항목 추가 / trivia 새 fact 발굴) 모두 허용. 이전 master 버전의 임의 제한 ("careerTree 신규 작성 X", "Self-Report 부분 체크리스트") 제거됨.

호출:
- `/job-data-master <slug> --force-enhance` — 명시 flag
- 또는 사용자 prompt에 "force re-do" / "재처리" / "quality 회복" / "enhance 강제" 등 신호

자동 분기 우선순위 (force-enhance 추가):
```
0. --force-enhance 명시 → ENHANCE 모드 직진 (audit / 마커 무관)
1. is_active=0 → SKIP
2. 마커 보유 + audit CLEAN → IDLE
3. 마커 보유 + audit FAIL → CLEANUP
4. 마커 미보유 + active → ENHANCE
```

force-enhance도 **마커 미보유 ENHANCE와 동일한 capability** 적용 — 차이는 진입 조건 (이미 enhance된 직업이라는 점) + change_summary `force-enhance:` 접두만. 단 보호 영역 (sal/wage 절대 X, 기존 careerTree 수정/삭제 절대 X — **신규 작성은 허용**) 그대로.

상세는 `reference/phase-flow.md` Phase 1.5 + `reference/user-expectation.md` 시나리오 4 + `reference/enhance-strict-rules.md` + `reference/enhance-phase-procedures.md`.

---

## Phase 0~7 흐름

상세는 `reference/phase-flow.md`. 본 SKILL.md는 핵심 흐름만.

### Phase 0 — SYNC + 진단

```bash
git fetch origin main
git log --oneline -1 origin/main    # MAIN_HEAD_MIN 이상 확인
git pull origin main                # 미만이면
```

`MAIN_HEAD_MIN` (현재 — 본 스킬 머지 시점 hash로 갱신될 예정).

직업 상태 판정 (위 auto-branching SQL).

ENHANCE 모드: 0-DIAG (`merged_profile_json` 기준 12 필드 점검) → 0-D (기존 각주 정합성) → 0-E (사이드바 현황) → Preservation Contract 확인. 상세 `reference/enhance-fields-spec.md`.

CLEANUP 모드: 진단 skip. Phase 1 audit으로 직접 진입.

### Phase 1 — AUDIT

```bash
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal
```

stdout에서 FAIL flags 파싱 (룰별 매핑은 `reference/fix-patterns.md` 표).

산문 영역 추가 검사 — `proseBodyOrphan` 룰 (PR 14, 2026-05-08): `_proseRaw` namespace로 9 BODY_FIELDS 본문 [N] vs `_sources[fieldKey]` 정합 확인. 검출 카테고리:
- `orphan(N)` — `_sources` 등록인데 본문 [N] 미인용
- `brokenRef(N)` — 본문 [N]이 `_sources` length 초과
- `dup(N)` — 같은 [N]이 한 필드 2회+

**본문 fact 정확성 사전 검증** (NEW, `reference/fact-verification.md`): 본문 통계/숫자/회사명 → WebSearch cross-check. mismatch 발견 시 fact 정정 작업 범위에 포함.

### Phase 2 — ANALYZE

`reference/fix-patterns.md` 표를 따라 룰 + 영역 (산문 / detailReady array / sidebar) 조합별 fix 패턴 결정. **4단계 fallback** (URL 교체 → 본문 일반화 → 항목 merge → 인정+pending) 영역별 적용.

**영역 분류 매트릭스 우선** — `reference/area-classification.md` 참조. detailReady array는 단순 REMOVE 시 UCJ 룰 A `[UCJ각주항목누락]` FAIL이라 fix 패턴이 다름.

### Phase 3 — PATCH

minimal payload (변경된 field만):

```js
const payload = {
  fields: { /* 변경 본문만 */ },
  sources: {
    /* _sources 변경 fieldKey만 — patch 내 id를 1부터 차례대로 부여
       (server가 SOURCE_FIELD_ORDER 기준 1..N 자동 재할당하므로 글로벌 id 유지 시도 X)
       sidebar* DELETE 시 {delete:true} */
  },
  changeSummary: "[job-data-master] mode=enhance|cleanup, fixes=...",
  // (선택) sal 영역 검증을 validateAsync로 자동 fetch하려면:
  _jobSlug: '<slug>',
};
```

**server merge 정책 핵심** (`src/routes/job-editor.ts`):
- patch 안 보낸 _sources fieldKey는 server가 **보존** — minimal POST 안전
- patch 보낸 fieldKey는 normalize 후 `renumberSourceIds`로 **글로벌 id 1..N 자동 재할당**
- 즉 client `[idxGap]` validate는 patch sources 평탄화 1..N만 통과하면 PASS — 자세한 충돌 해소는 `reference/fix-patterns.md` `[idxGap]` 섹션 참조

**보호 영역** — `reference/safety-rules.md` 참조:
- `fields.overviewSalary` 절대 X (sal-protection)
- `sources["overviewSalary.sal"]` 절대 X (`[sal-readonly]` strict)
- `fields.careerTree` 절대 X (별도 사이클)

### Phase 4 — VALIDATE

```bash
node scripts/validate-job-edit.cjs payload.json
```

errors 0 + 모든 적용 룰 PASS. 산문 영역 게이트 (`PROSE_BODY_FIELDS` 9 필드 orphan/brokenRef/dup) 자동 통과 확인.

### Phase 5 — POST

```bash
curl -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @payload.json
```

또는 Node.js fetch + UTF-8 (Windows curl 인라인 한글 mojibake 차단).

`change_summary` 마커 형식: `[job-data-master] {mode} — {fixes/fields 요약}`. 기존 enhance/cleanup 마커와 분리.

### Phase 6 — VERIFY

```bash
# 1. audit 재실행
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal

# 2. prod 페이지 fetch + 키워드 매칭
curl -s "https://careerwiki.org/job/<slug>" | grep -o "키워드"
```

audit CLEAN (또는 4단계 인정만 잔존) + prod 200 + 본문 키워드 매칭.

### Phase 7 — REPORT

DONE / RETRY 형식 (아래).

---

## DONE / RETRY 포맷

### DONE 형식

```
DONE: <slug> rev=N mode=enhance|cleanup audit=CLEAN externalHosts=N
fixes: rootURL=X→0, origin=Y→0, sidebarSources=Z→0, wikiQuota=A%→B%, arrayBrokenRef=C→0,
       orderViolation=D→0, listPage=E→0, proseBodyOrphan=F→0, factCorrected=G
fields_modified: way, trivia, detailWlb.wlbDetail, sidebarCerts, ...
WebFetch=R, no-self-validation=true
```

### RETRY 형식

```
RETRY: <slug> root cause: <어떤 룰 / 어느 path / 시도한 fix / 실패 이유>
attempted: <what was tried>
blocker: <왜 막혔는지 — WebFetch 차단 / 4단계 fallback 모두 실패 / 사용자 결정 필요 등>
next: <Phase 1 재시작 / 4단계 인정 + pending 기록 / STOP + 사용자 보고 중 택일>
```

> 🚫 **LLM 자가 "CLEAN" / "DONE" 라벨 1줄 통과 절대 금지**. `audit-via-api.cjs --exclude-sal` exit 0 + "OK clean" 출력만 진리.

---

## ⚠️ Rule WL-KILL — 화이트리스트 폐기 (2026-05-16, OMEGA 사후 강화)

**배경**: 2026-05 PR #31 OMEGA 룰 통합 후 362 master pool 전수 재감사 결과 196개 master 적용 중 137개(70%)가 사고 잔존. 원인 — 화이트리스트 방식 17필드 체크리스트가 `overviewAbilities.technKnow` / `summary` / `overviewWork.main` 등을 invisible 영역으로 만들었음.

**룰 WL-KILL** — 모든 진단·Self-Report·patch 계획에서 영역을 화이트리스트로 enumerate하지 X. 대신 다음 자동 인지 룰을 강제:

1. **진단 단계 (Phase 0-DIAG / 0-B)**: `merged_profile_json`의 prose body 영역을 자동 enumerate. 다음 14개 prose body field를 baseline로 평가:
   - `way`, `summary`, `trivia`, `overviewWork.main`, `overviewProspect.main`, `overviewAbilities.technKnow`, `detailWlb.wlbDetail`, `detailWlb.socialDetail`, `detailReady.curriculum`, `detailReady.recruit`, `detailReady.training`, `detailReady.researchList`, `detailReady.certificate`, `detailReady.pathExplore`
   - 단, `overviewSalary.sal`은 sal-protection으로 진단에서 skip만, force-enhance 영역에는 영구 제외
2. **Self-Report 강제 enumerate**: 17필드 화이트리스트 표 사용 금지. 대신:
   ```bash
   # 진단 SQL — prose body 14개 + sidebar 4개 + heroTags + youtubeLinks + careerTree (총 21+ 영역)
   SELECT json_type(merged_profile_json,'$.way') AS way_type, length(json_extract(merged_profile_json,'$.way')) AS way_len,
          json_type(merged_profile_json,'$.summary') AS summary_type, length(...) AS summary_len,
          json_type(merged_profile_json,'$.overviewWork.main') AS duties_type, ...,
          json_type(merged_profile_json,'$.overviewAbilities.technKnow') AS abilities_type, ...,
          json_extract(user_contributed_json,'$._sources') AS sources_keys
   FROM jobs WHERE slug=?;
   ```
3. **patch 계획 검증** (Phase 2 직후): 진단 결과의 모든 fail/short field가 patch 계획에 포함됐는가? skip하려면 changeSummary에 명시적 사유 필수 ("abilities 영역은 careernet 원본 충실 — skip", "summary는 admin 영역 — patch X" 등).
4. **OMEGA self-audit 강제** (Phase 4.5): `audit-via-api.cjs --exclude-sal` 출력에서 `OMEGA-FAIL` 발견 시 즉시 차단. PR #31의 server-side guard와 별개로 client에서도 검증.

**감지 방법** — 다음 자가 검증 의무:
- changeSummary에 어느 영역을 patch했는지 명시
- changeSummary에 skip 영역 사유 명시 (skip 영역 있으면)
- 21+ 영역 중 patch도 skip도 없는 영역이 있으면 → WL-KILL 위반 자동 차단

---

## Safety Rules 16개 (hardcoded)

본 스킬은 다음 16 안전 룰을 빠짐없이 강제한다. 상세는 `reference/safety-rules.md`.

1. **WebFetch 강제** — 신규 URL 등록 *전* tool_use ≥ 1회. tool_uses < new URL count → 작업 무효
2. **Hallucinated 도메인 블랙리스트** — `kgta.or.kr` / `k-lpn.or.kr` / `kpba.co.kr` / `kindergarten.go.kr` 등 + deep path 추정 패턴 (board ID / lsiSeq / boardSeq round number 등)
3. **Phase 0-SYNC 필수** — main HEAD ≥ `MAIN_HEAD_MIN`
4. **sal-protection 절대** — `fields.overviewSalary` / `sources["overviewSalary.sal"]` 어떤 식으로든 손대지 X. audit는 `--exclude-sal` 사용으로 sal 영역 검증 skip. (사용자 명시 — `feedback_sal_protection_strict.md`)
5. **careerTree 보호** — `fields.careerTree` 어떤 식으로든 손대지 X (enhance 모드 신규 작성은 예외 — Phase 3.6 careerTree 생성 절차 따름. 단, 기존 careerTree 수정/삭제는 절대 X)
6. **본문 fact 보존** — 출처 정리만, 본문 단어/숫자/구체정보는 그대로. **단, fact verification (Phase 1)에서 mismatch 검출 시 정정 허용** — WebSearch cross-check evidence 의무. 일반화는 deep page 시도 모두 실패한 마지막 수단
7. **minimal POST** — 변경된 field만 payload. `[minimalPOST]` rule이 changeSummary 마커만 + fields/sources 0건 차단
8. **DONE/RETRY 포맷 강제** — LLM 자가검증 1줄 통과 금지
9. **main branch에서만 deploy** — 코드 변경 시. cleanup-only는 DB만 수정 (deploy 불필요)
10. **Pre-commit hook 우회 금지** — `--no-verify` 절대 X
11. **subagent fan-out 금지** — 본 세션 직접 처리. polling 1줄 → fan-out 사고 (75 fan-out / 172M token) 재발 방지
12. **사고 발견 시 즉시 STOP** — retry 1회 후도 FAIL이면 STOP + 보고
13. **일반화는 사용 가치 떨어뜨림** — deep page 시도 우선
14. **detailReady array 항목 마침표 금지** (룰 X) — `detailReady.{curriculum,recruit,training}` array 항목 끝에 마침표(`.`) X. `[N]` 출처 마커가 항목 종결자 역할. 잘못: `"...채용 포털.[1]"` / 올바름: `"...채용 포털 [1]"`. 산문 영역(way/trivia 등)은 일반 종결 마침표 OK — array 항목만 적용
15. **출처 마지막 줄 몰아놓기 금지** (룰 Y) — N개 array 항목이 1개 출처에 통째 의존하면서 마지막 항목에만 [N] 박는 패턴 금지. 1 항목 = 1 [N] 마커 (해당 항목 fact가 그 출처에 직접 등장 시). 1 출처가 N 항목 cover 못하면: (a) 출처 더 발굴 (b) 4단계 fallback (`reference/fix-patterns.md`) (c) 항목 일반화
16. **WL-KILL — 화이트리스트 폐기** (2026-05-16) — 17필드 체크리스트 방식 진단 금지. 21+ 영역 (prose body 14 + sidebar 4 + heroTags + youtubeLinks + careerTree) 자동 enumerate + patch 또는 skip 사유 명시. OMEGA self-audit 통과 의무.

---

## Examples

### Example 1 — 신규 enhance (마커 미보유)

```
입력: /job-data-master 신규직업명
판정: marker_count=0 + is_active=1 → ENHANCE 모드
Phase 0: 12 필드 진단 (way=NULL, trivia=NULL, sidebarCerts=0개 등)
Phase 1: WebSearch + WebFetch로 1차 출처 발굴 (협회 deep page / 정부 통계 / 1차 미디어)
Phase 2: 12 필드 작성 + Self-Report 17필드 체크리스트
Phase 3: validate PASS
Phase 4: minimal POST → revisionId 받음
Phase 5: change_summary = "[job-data-master] enhance — way·trivia·detailWlb·detailReady·sidebar·youtubeLinks·careerTree"
Phase 6: audit-via-api CLEAN
Phase 7: DONE
```

### Example 2 — cleanup (rootURL 단순 url 교체)

```
입력: /job-data-master 바리스타
판정: marker_count=1 (이미 enhance) + audit FAIL "rootURL(1)" → CLEANUP 모드
Phase 1: audit FAIL = way 필드 src `https://www.kgames.or.kr/` (rootURL)
Phase 2: 영역 = 산문 필드. 1단계 deep page 시도
Phase 3: WebFetch `https://www.kgames.or.kr/partnership/partner-list/` → 본문 fact "K-Games 파트너" 키워드 등장 → url 교체
         payload: { sources: { "way": [...길이2 그대로, idx=N url만 교체] } }
Phase 4: validate PASS
Phase 5: POST → "[job-data-master] cleanup — rootURL=1→0 (way deep page 교체)"
Phase 6: audit CLEAN
Phase 7: DONE
```

### Example 3 — proseBodyOrphan (산문 영역 trivia _sources orphan)

```
입력: /job-data-master 게임-프로그래머
판정: marker_count=1 + audit FAIL "orphan(3)" → CLEANUP 모드
Phase 1: trivia _sources 3개 등록인데 본문 [N] 마커 0개 (proseBodyOrphan 검출)
Phase 2: 옵션 분석:
         (a) 본문에 출처 인용 가능한 fact가 있으면 [N] 마커 추가
         (b) trivia _sources 통째 DELETE (의미 없는 등록이면)
Phase 3: 본문 fact 검토 결과 인용 가능 → trivia 본문 끝에 [1][2][3] 추가
         (단, sentence 분리 + 마침표 뒤 마커 정합성 강제 — 한 sentence 1 마커 max)
Phase 4: validate PASS — orphanSrc 0
Phase 5: POST → "[job-data-master] cleanup — proseBodyOrphan=3→0 (trivia 본문 [N] 정합화)"
Phase 6: audit CLEAN
Phase 7: DONE
```

### Example 4 — fact 정정 (factSourceMismatch)

```
입력: /job-data-master 방사선사
판정: marker_count=1 + WebSearch cross-check 결과 본문 "0.6 mSv" → 실제 0.82 mSv (mismatch)
       → CLEANUP + fact 정정
Phase 1: 본문 fact mismatch + 새 출처 deep page 발굴
Phase 2: 본문 통계 정정 + 출처 등록
Phase 3: payload = { fields: { trivia: "...실효선량 0.82 mSv[1]..." }, sources: { trivia: [...] } }
Phase 4: validate PASS
Phase 5: POST → "[job-data-master] cleanup — factCorrected=1 (trivia 0.6→0.82 mSv WebSearch verified)"
Phase 6: audit CLEAN
Phase 7: DONE
```

### Example 5 — detailReady array 4단계 fallback (rootURL 잔존)

```
입력: /job-data-master 게임-프로그래머
판정: marker_count=1 + audit FAIL "rootURL(6)" detailReady.curriculum/recruit
Phase 1: 6건 모두 detailReady array 영역 — 단순 REMOVE 금지 (UCJ FAIL)
Phase 2: 4단계 fallback 시도
         1단계 (URL 교체): WebFetch deep page 발굴 → kgames root → /kr/about/index.php 시도
                          → 본문 fact "컴퓨터공학·게임학과 진학" cover 못 함 → 실패
         2단계 (본문 일반화): 학과진학 일반론으로 약화 → "관련 학과 진학·기초 교과 이수"
                            → cover deep page도 부재 → 실패
         3단계 (항목 merge): curriculum 5개 → 4개로 합치기 → 정보 손실 → 보류
         4단계 (인정 + pending): root URL 잔존 6건. memory deck/04-pending.md에 기록.
                                rev=N. 다음 사이클에서 재시도
Phase 7: DONE (4단계 인정 — audit FAIL 6건 영구 잔존, pending에 명시)
```

### Example 6 — IDLE (이미 enhance + audit CLEAN)

```
입력: /job-data-master 가수
판정: marker_count=1 (이미 enhance) + audit-via-api CLEAN → IDLE
Phase 7: DONE — nothing to do
```

### Example 7 — force-enhance (archive enhance 본래 capability 그대로)

```
입력: /job-data-master 가구조립원 --force-enhance
판정: --force-enhance flag → ENHANCE 모드 직진 (마커 보유 + audit CLEAN 무관)
Phase 0-PRE: START_TRACKING (.skill-runs/.start-{session}-가구조립원.json)
Phase 0-DIAG: 12 필드 풀 진단 (way 350자 / detailReady 출처 1개 / trivia 80자 / sidebarCerts 1개 / careerTree 부재)
Phase 0-D: 기존 각주 정합성 점검 (FP/GN/SK 검사)
Phase 0-E: 사이드바 현황 점검 (sidebarMajors 2개 → 보강 필요)
Phase 0-F: Preservation Contract 확인 (배열 항목 수 감소 X)
Phase 1-PRE: cert-org-mapping.json lookup (Q-net 자격증)
Phase 1: WebSearch + WebFetch로 1차 출처 발굴 — 17 필드 풀 작성
         - way: 진로 경로 expand (자격요건·시험·진입경로 + 새 출처)
         - detailReady.curriculum/recruit/training: 항목 추가 + 1:1 매핑 출처
         - trivia: 새 fact 발굴 + 출처 등록
         - sidebar* 보강 (Cert/Org/Major/Job 부족분만 추가, 기존 항목 보존)
         - careerTree: 한국인 공인 인물 후보 발굴 (정치인 제외, 역대 대통령 제외)
                      적합 인물 부재 시 _careerTreeNote 5명+ 후보 기재
Phase 2 (4 게이트): Gate 0 원문 보존 / Gate 1 각주 / Gate 2 완결성 / Gate 3 YouTube / Gate 4 sources 순서
Phase 3-A: validate-job-edit.cjs PASS 확인
Phase 3.5: Save Self-check (배열 항목 수 / prospect 방향 / curriculum 각주)
Phase 3-B: minimal POST → revisionId
Phase 3.6: careerTree DB INSERT (career_trees + career_tree_job_links — 부재 시만)
Phase 4-MARKER: 본문 마커 뭉침 0건 확인
Phase 5: 각주·출처 수선 (SK→GN→FP→OM→OS)
Phase 5-DEDUP: auto-dedup-sweep
Phase 5-AUDIT: audit-sources 4 패턴 검증
Phase 5-VERIFY: post-edit-verify.cjs (URL HEAD)
END_TRACKING: skill-runs.jsonl append
change_summary = "[job-data-master] enhance — force-enhance: way·trivia·detailReady·sidebar·careerTree·..."
Phase 7: DONE — 17 필드 풀 보강
```

---

## See Also

- `reference/phase-flow.md` — Phase 0~7 상세 + 자동 분기 흐름도
- `reference/fix-patterns.md` — 룰별 fix 패턴 + 4단계 fallback (영역별)
- `reference/safety-rules.md` — 15 안전 룰 + 보호 영역 + 블랙리스트
- `reference/area-classification.md` — 산문 / detailReady array / sidebar 영역별 정책
- `reference/fact-verification.md` — 본문 fact 정확성 검증 (WebSearch cross-check)
- `reference/enhance-fields-spec.md` — enhance 모드 12 필드 spec + Resume Safety + careerTree + 각주 수선
- `reference/enhance-strict-rules.md` — **archive enhance 통합** (출처·사실성 철칙 + 핵심 기술 규칙 표 + 4 카테고리 판단 매트릭스 + 출처 수집 규칙 + 무출처 문장 처리 + 기존 콘텐츠 보존 F3 + 차단 사이트 폴백 체인)
- `reference/enhance-phase-procedures.md` — **archive enhance 통합** (Phase 0-PRE / 0-MODE / 0-DIAG / Gate 0~4 / 3.5 Self-check / 3-A validate / 4-MARKER / 5-DEDUP / 5-AUDIT / 5-VERIFY / END_TRACKING)
- `reference/user-expectation.md` — 사용자가 기대할 수 있는 결과 (시나리오 4종 + 비용 + 보호 영역)
- `scripts/skill-cache/audit-via-api.cjs` — 결정적 audit (`--exclude-sal` 표준)
- `scripts/validate-job-edit.cjs` — POST 직전 validate
- `scripts/_shared/detect-patterns.cjs` — 모든 룰 single source
- `.claude/skills/_archive/job-data-enhance/` — archive 본문 (본 master에 통합됨, 원본 보존)
- `.claude/skills/_archive/job-data-cleanup/` — archive (구 cleanup 스킬, reference만)
