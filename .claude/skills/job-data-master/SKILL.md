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

### Phase 4.5 — OMEGA SELF-AUDIT (2026-05-15 신설, skip 금지) ⚠️

POST 직전, **patch + 기존 merged 결과를 통합 룰 OMEGA로 self-audit**. 화이트리스트 폐기 — `_proseRaw`·`detailReady`·`_sources` 모든 키 자동 enumerate. ZZ/ZZZ/ZZZZ는 일부 필드만 검사하지만 OMEGA는 abilities·summary·duties 등 모든 산문 영역 자동 검출.

```bash
# patch JSON에 _omegaSelfAudit: true 추가하면 validate-job-edit.cjs가 자동 실행
node scripts/validate-job-edit.cjs payload.json

# 또는 별도 호출
node -e "const {detectAllBodySourceMarkerMismatch} = require('./scripts/_shared/detect-patterns.cjs'); ..."
```

**FAIL 검출 시 처리**:
- patch가 만진 fieldKey에 OMEGA FAIL → patch에 추가 fix 포함 강제 (skip 금지)
- 잔존 prod FAIL (patch 안 보낸 영역) → 다음 사이클로 분리 (본 patch 통과)
- server-side guard (job-editor.ts)도 동일 룰 검사 — client validate 우회해도 400 reject

**Self-Report 추가 항목**: 통합 룰 검사 결과 FAIL/WARN count + 영역 목록 기록.

force-enhance 모드는 모든 prose 영역 (화이트리스트 폐기) 자동 인지 — abilities·summary 등 누락 영역도 force-enhance 풀 사이클 대상.

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
# 1. audit 재실행 (OMEGA 통합 룰 포함, 2026-05-15)
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal
# 결과 line에 OMEGA-FAIL(N: rule:field,...) / OMEGA-WARN(M) 표시

# 2. prod 페이지 fetch + 키워드 매칭
curl -s "https://careerwiki.org/job/<slug>" | grep -o "키워드"
```

audit CLEAN (또는 4단계 인정만 잔존) + prod 200 + 본문 키워드 매칭 + OMEGA-FAIL 0건 (patch 영역).

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

## Safety Rules (hardcoded)

본 스킬은 다음 안전 룰을 빠짐없이 강제한다. 상세는 `reference/safety-rules.md`.

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
16. **URL count 최소 ≥ 12 (룰 Z, 2026-05-10 신규)** — force-enhance 후 직업당 _sources URL count ≥ `max(12, fieldsCount × 1.5)`. cleanup으로 broken/wiki/root sources 제거한 만큼 신규 1차 출처 발굴 의무. **2026-05-09 사고**: 103 직업 중 6 직업이 URL <10 (기업고위임원 2 / 대학교수·의료정보SW 4 / 물리치료사 5 / 간호조무사·리포터 7) — 패턴 A (cleanup 후 미보강 4건) + 패턴 B (글자수만/careerTree만 2건). Phase 1 ANALYZE에 sparse fieldKey 식별 의무 + Phase 2 PATCH에 모든 sparse 보강 의무 + Phase 6 VERIFY에 URL count ≥ 12 검증 (미달 시 RETRY). audit-via-api `urlCountInsufficient(N<X)` WARN level (FAIL 아님 — 다음 cycle 트리거). 가구조립원 시범 (URL 23) 참고 패턴.
17. **본문 충실 + _sources 부재 절대 금지 (룰 ZZ, 2026-05-10 신규)** — 산문 5 영역 (`way` / `trivia` / `overviewProspect.main` / `detailWlb.wlbDetail` / `detailWlb.socialDetail`) 본문 100자+ 인데 _sources 부재 OR detailReady array (`curriculum`/`recruit`/`training`) 항목 2+ 모두 [N] 마커 부재 + _sources 0 인 케이스 금지. **2026-05-10 사고 (사용자 발견)**: 경찰관 detailWlb.wlbDetail(157자) / socialDetail(115자) / curriculum(3 항목) / training(3 항목) 본문 충실 but [N]+_sources 모두 0 — master force-enhance가 detailReady.recruit만 처리 후 다른 영역 무시. 103 직업 sample 결과 **42% (43건)** 영향 (detailWlb.wlbDetail 34건 / socialDetail 28건 / overviewProspect.main 11건 / trivia 4건 / way 3건). 룰 Z (urlCountInsufficient)는 _sources 등록 fieldKey만 카운트라 fieldKey 부재 silent 통과 → 룰 ZZ가 zero-registration case 보강 식별. Phase 1 ANALYZE에 **zero-registration fieldKey 별도 식별 의무** + force-enhance changeSummary에 **모든 처리 영역 명시** 의무. audit-via-api `bodyWithoutSources(N: f1,f2,...)` WARN level (FAIL X — 다음 cycle 트리거). overviewWork.main / overviewAbilities.technKnow / summary는 CareerNet API 원본 영역이라 제외 (false positive 회피).
18. **출처 등록 + [N] 마커 부재 절대 금지 (룰 ZZZ, 2026-05-11 신규)** — 산문 8 영역 (`way` / `overviewProspect.main` / `trivia` / `detailWlb.wlbDetail` / `detailWlb.socialDetail` / `overviewWork.main` / `summary` / `overviewAbilities.technKnow`) 본문 100자+ AND `_sources[field]` URL ≥ 1 인데 본문에 `[N]` 마커 0개인 케이스 **FAIL**. ZZ의 정반대 사고. **2026-05-11 사고 (사용자 발견 — 경찰관)**: "출처 14개 있는데 인라인 각주 안 박혀 있어" — 출처는 등록했는데 본문에 [N] 안 박힘. 362 master 적용 직업 audit 결과 **8 직업** (overviewAbilities.technKnow 5건 / way 2건 / detailWlb.socialDetail 1건). Phase 1 ANALYZE 시 **출처 등록 영역마다 본문 [N] 박힘 확인 의무**. audit-via-api `sourcesWithoutMarkers(N: f1(bodyLen/srcsCount),...)` **FAIL** level. ZZ(`bodyWithoutSources`)와 ZZZ는 정반대 — ZZ는 body 충실 + srcs 0, ZZZ는 body 충실 + srcs 1+ + marker 0.
19. **본문 미존재 영역에 _sources 잔존 금지 (룰 ZZZZ, 2026-05-11 신규)** — `_sources` fieldKey 중 본문이 _proseRaw에도 detailReady에도 API top-level에도 없거나(`body-missing`) trim 후 길이 <50자(`body-too-short`)인 영역에 출처가 등록된 케이스 **FAIL**. **2026-05-11 사고 (사용자 발견 — 경찰관)**: `_sources.detailGrowth.growth`(2건) + `_sources.detailWork.workDetail`(2건) — API 응답 top-level에 detailGrowth/detailWork 자체가 없는데 _sources만 잔존 → 사용자 출처 섹션에 [11][12][13][14] 표시되지만 본문에서 [N] 인용 위치를 못 찾음. 362 master 적용 직업 audit 결과 **10 직업** (detailGrowth.growth 5건 / detailWork.workDetail 5건 / summary·overviewAbilities.technKnow·overviewSalary.prospects·overviewProspect.main 각 1~2건). 차단 정책: enhance 시 **존재하지 않는 fieldKey에 _sources 등록 금지** (예: detailGrowth/detailWork 영역은 미사용이면 _sources 키 자체 생성 X). audit-via-api `orphanSources(N: f1[area/srcs],...)` **FAIL** level. sal-protection 자동 제외 (overviewSalary.sal). sidebar* 영역은 룰 L이 별도 검출.
20. **POST 전 validate-job-edit 통과 의무 (2026-05-11 신규)** — POST API 호출 직전 `node scripts/validate-job-edit.cjs <payload.json>` 실행. `[sourcesWithoutMarkers]` (ZZZ) / `[orphanSources]` (ZZZZ) FAIL 시 POST 절대 X. 자동 차단되는 사고: (a) _sources 등록만 하고 본문 [N] 누락 (origin-bulk-fix류 / URL 교체류 작업 흔한 사고 패턴) (b) ALLOWED 외 fieldKey (detailGrowth.growth, detailWork.workDetail 등) 출처 등록 (silent orphan). master skill self-report에 validate PASS 라인 의무 기록.
21. **POST 직후 audit ZZZ/ZZZZ 검증 의무 (2026-05-11 신규)** — POST 직후 `node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal` 실행. `sourcesWithoutMarkers` / `orphanSources` flag 검출 시 즉시 RETRY (Phase 2 재진입). Self-Report 라인: `audit ZZZ=N / ZZZZ=N` 필수 기록. 미기록 시 skill 단계 미완료로 간주.
22. **cleanup `rm` 와일드카드/regex 절대 금지 (2026-05-11 신규)** — Skill 작업 종료 시 `scripts/skill-cache/` 임시 산출물 정리 시 다음 패턴 모두 금지:
    - `rm -rf <dir>` (폴더 통째)
    - `rm <path>/_phase*`, `rm *.tmp` (shell glob)
    - `ls | grep <regex> | while read f; do rm "$f"; done` (regex 우회)
    - `find <path> -name '...' -delete`

    **2회 재발 사고**: 2026-05-07 inspiring-noether `.skill-cache/` 폴더 rm-rf (8 tracked D), 2026-05-11 elated-mendeleev `ls | grep '^_phaseA' | rm` (4 tracked D, `_phaseA-{audit,detailwlb,html-scan,raw-dump}.cjs`). 두 번 다 `git restore`로 복구했지만 untracked 손실 가능성 + 위험.

    **의무 절차**:
    - 임시 산출물은 `_tmp_*` / `_scratch_*` prefix 또는 `*.tmp.json` / `*.tmp.cjs` 확장자만 사용 → `scripts/skill-cache/.gitignore` 자동 격리
    - cleanup 시 `git clean -fdn <path>` (dry-run) → 검토 → `git clean -fd <path>` (tracked 절대 안 건드림)
    - 또는 명시적 파일명만 `rm` (와일드카드 X)
    - 마지막에 `git status -s`로 `D` 라인 없음 확인

    상세: `memory/feedback_worktree_safe_cleanup.md` + `memory/feedback_dirty_folder_rm_pitfall.md`.

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
