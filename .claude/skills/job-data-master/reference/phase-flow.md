# Phase Flow — Phase 0~7 상세 + 자동 분기

> SKILL.md의 Phase 흐름 확장본. 본 doc은 reference 전용 — Phase 실행 시 의문 발생 시 참조.

---

## 자동 분기 흐름도

```
┌─ Phase 0-A: 직업 상태 SQL 판정 ─────────┐
│ SELECT id, slug, name, is_active,       │
│   marker_count (page_revisions LIKE     │
│   '%[job-data-master]%' OR              │
│   '%[job-data-enhance]%')               │
└─────────────┬───────────────────────────┘
              │
              ▼
   --force-enhance flag ? ─ Yes ──► ENHANCE 모드 직진 (Phase 1.5)
              │
              No
              ▼
       is_active = 0 ? ─── Yes ──► SKIP (보고만, Phase 7 DONE)
              │
              No
              ▼
       marker_count = 0 ? ─ Yes ──► ENHANCE 모드 (Phase 0-DIAG → 1 → 2 → ...)
              │
              No
              ▼
       audit-via-api 실행 ◄─── (--exclude-sal 표준)
              │
       CLEAN ? ─── Yes ──────────► IDLE (Phase 7 DONE 즉시)
              │
              FAIL
              ▼
       CLEANUP 모드 (Phase 1 audit + 산문 영역 검사 → 2 → 3 → ...)
              │
              ▼
       (본문 fact verify Phase 1.5)
              ▼
       fact mismatch ? ─ Yes ── CLEANUP + fact 정정 모드
              │
              No
              ▼
       CLEANUP 모드 그대로
```

---

## Phase 1.5 — `--force-enhance` 모드 직진 (2026-05-09 신규)

audit CLEAN이어도 enhance 사이클을 강제 실행하는 옵션. cluster 패턴 / 출처 0 / 옛 룰 retroactive 보강 use case.

### 진입 신호

다음 중 하나면 force-enhance 모드 직진:
- 호출에 `--force-enhance` flag 포함
- 사용자 prompt에 "force re-do" / "재처리" / "quality 회복" / "enhance 강제" / "force enhance" 등 명시
- audit `arrayItemPeriod(N)` / `sourcePositionCluster(N)` WARN 검출 + 사용자 quality 회복 요청

### 처리 흐름 (archive enhance와 동일 — 임의 제한 X)

1. Phase 0-PRE (SYNC + START_TRACKING) — `.skill-runs/.start-{session}-{slug}.json` 기록 의무 (`enhance-phase-procedures.md` 참조)
2. Phase 0-A 자동 분기 **skip** — `--force-enhance` flag 인식 시 ENHANCE 모드 직진
3. Phase 0-DIAG (12 필드 풀 진단) — `merged_profile_json` 기준 type별 length 검사 (`enhance-phase-procedures.md`)
4. Phase 0-D (기존 각주 정합성 점검 / Go-over) — FP/GN/SK 검사
5. Phase 0-E (사이드바 현황 점검) — Major/Org/Cert 부족분만 보강 대상 식별
6. Phase 0-F (Preservation Contract) — 배열 항목 수 감소 X / prospect 방향 반전 X
7. Phase 1-PRE (cert-org-mapping.json lookup) — sidebarCerts/sidebarOrgs 사전 캐싱
8. Phase 1 (1차 출처 발굴 + 17 필드 풀 작성) — archive enhance와 동일
   - cluster 항목 → 1:1 매핑으로 deep URL N개 발굴
   - 마침표 항목 → 마침표 제거 (deep URL 발굴 시 함께)
   - 출처 0 fieldKey → enhance 사이클 풀 적용
   - **17 필드 풀 작성 가능** (way / detailReady / trivia / wlbDetail / socialDetail / wlb·social 등급 / overviewProspect / sidebar 4종 / heroTags / youtubeLinks / careerTree)
   - **본문 expand 가능** (기존 fact 보존 + 새 fact append)
   - **detailReady 항목 추가 가능** (기존 항목 그대로 + 새 항목 append)
   - **trivia 새 fact 발굴 가능**
   - **careerTree 부재 시 신규 작성 가능** (Phase 3.6 — archive enhance 본래 capability 그대로)
9. Phase 2 (4 게이트 — Gate 0 원문 보존 / Gate 1 각주 / Gate 2 완결성 / Gate 3 YouTube / Gate 4 sources 순서)
10. Phase 3-A (validate-job-edit.cjs PASS 확인)
11. Phase 3.5 (Save Self-check — 배열 항목 수 / prospect 방향 / curriculum 각주 / yt 깊이 / careerTree 깊이 / sources URL 품질)
12. Phase 3-B (minimal POST)
13. Phase 3.6 (careerTree DB INSERT — 부재 시)
14. Phase 4-MARKER (본문 마커 뭉침 0건 확인)
15. Phase 5 (각주·출처 수선 SK→GN→FP→OM→OS)
16. Phase 5-DEDUP / 5-AUDIT / 5-VERIFY
17. END_TRACKING (skill-runs.jsonl append)

### enhance 모드와 차이

`--force-enhance`는 archive `job-data-enhance` 본래 capability를 **그대로** 적용한다. 마커 미보유 ENHANCE와 차이는 단지 진입 조건 + change_summary 접두뿐 — Phase 0-DIAG 풀 진단 / 17 필드 풀 체크 / careerTree 신규 작성 / 본문 expand / detailReady 항목 추가 / trivia 새 fact 발굴 모두 동일하게 허용.

| 측면 | 마커 미보유 ENHANCE | `--force-enhance` ENHANCE |
|---|---|---|
| 진입 조건 | marker_count=0 + active | flag 명시 + (audit CLEAN 무관) |
| 12 필드 진단 | 풀 진단 | **풀 진단** (archive 본래 capability 그대로) |
| Self-Report | 17 필드 체크리스트 | **17 필드 체크리스트** (동일) |
| change_summary | `[job-data-master] enhance — way·trivia·...` | `[job-data-master] enhance — force-enhance: way·trivia·detailReady·...` |
| careerTree 신규 작성 | 가능 (Phase 3.6) | **가능** (Phase 3.6 동일 — 기존 careerTree 부재 또는 stub이면 신규 작성 허용. 단 기존 careerTree 수정/삭제는 절대 X) |
| 본문 expand / fact 추가 | 가능 | **가능** — detailReady 항목 추가 / trivia 새 fact 발굴 / 산문 영역 expand 모두 |

### 보호 영역 (force-enhance에도 적용)

- sal-protection: `fields.overviewSalary` / `sources["overviewSalary.sal"]` 절대 X
- careerTree: **기존** careerTree 절대 수정/삭제 X. 신규 작성(부재 시)은 enhance 모드 동일하게 허용 (Phase 3.6 절차)
- enhance 사이클 일반 보호 영역 그대로 (`reference/safety-rules.md`)
- Preservation Contract (배열 항목 수 감소 X / prospect 방향 반전 X / 기존 trivia 무단 교체 X) 그대로

### 사용자 보고

force-enhance 진입 시 즉시 보고:
- 진입 사유 (cluster / 출처 0 / quality 회복)
- 변경 영역 (어느 fieldKey)
- 예상 비용 (WebFetch 수 / 항목별 deep URL 발굴 수)
- 보호 영역 (sal/careerTree 미접촉 명시)

---

## Phase 0 — SYNC + 진단

### 0-PRE. SYNC

```bash
git fetch origin main
git log --oneline -1 origin/main
```

main HEAD가 `MAIN_HEAD_MIN` (본 스킬 머지 시점 hash로 갱신) 미만이면:

```bash
git pull origin main
```

미만 + 미pull → 작업 시작 X.

### 0-A. 대상 선택 + 자동 분기 SQL

```sql
SELECT j.id, j.slug, j.name, j.is_active,
  (SELECT COUNT(*) FROM page_revisions
   WHERE entity_type='job' AND entity_id=CAST(j.id AS TEXT)
     AND (change_summary LIKE '%[job-data-master]%' OR change_summary LIKE '%[job-data-enhance]%')) AS marker_count
FROM jobs j WHERE slug = ?;
```

→ 4 모드 중 하나로 분기 (위 흐름도).

배치 처리 시 (multiple slug):
```sql
SELECT slug, name FROM jobs
WHERE is_active=1
  AND id NOT IN (
    SELECT DISTINCT entity_id FROM page_revisions
    WHERE entity_type='job'
      AND (change_summary LIKE '%[job-data-master]%' OR change_summary LIKE '%[job-data-enhance]%')
  )
ORDER BY popularity DESC LIMIT N;
```

### 0-B. ENHANCE 모드 — 12 필드 진단

`reference/enhance-fields-spec.md` 참조. `merged_profile_json` 기준 12 필드 점검:
- way / detailReady (curriculum/recruit/training) / trivia / detailWlb (wlb/social/wlbDetail/socialDetail) / overviewProspect.main / sidebarJobs / sidebarMajors / sidebarCerts / sidebarOrgs / heroTags / youtubeLinks / careerTree

각 필드별 권장 임계치 (text length, array count) 점검 + 부실 / 누락 분류.

⚠️ **`merged_profile_json` 기준 진단 강제** — `user_contributed_json` 단독 금지 (api 측 채움 false positive 발생).

### 0-C. CLEANUP 모드 — Phase 1 audit으로 직접

진단 skip. audit-via-api.cjs로 FAIL findings 추출 후 Phase 2 분기.

### 0-D. 기존 각주 정합성 점검 (Go-over) — ENHANCE 모드

Phase 1 신규 작성 전 기존 UCJ 각주 상태 fix:
- FP (마침표 앞 마커 `합니다[1].` → `합니다.[1]`)
- FP (중간 삽입 `A.[1] B이다.` → `A. B이다.[1]`)
- 비순차 번호 (`[1]`, `[3]` → `[1]`, `[2]`)
- sources 불일치 / 각주 누락

### 0-E. 사이드바 현황 점검 — ENHANCE 모드

`merged_profile_json.sidebarMajors` / `sidebarOrgs` / `sidebarCerts` 기존값 확인 → 부족만 보강 (기존 항목 절대 삭제 X).

### 0-F. Preservation Contract — 두 모드 공통

```
[ ] 배열 항목 수 감소 X (sidebarCerts 5→3 등 정보 손실 차단)
[ ] prospect 텍스트 방향 유지 (감소 → 증가 변경 절대 X)
[ ] 기존 trivia 무단 교체 X
[ ] 검증 안 된 URL recruit sources 등록 X
[ ] sal/wage/wageSource 절대 손대지 X
[ ] careerTree 기존값 절대 손대지 X (enhance 모드 신규 작성만 예외)
```

---

## Phase 1 — AUDIT

### 1-A. audit-via-api 실행

```bash
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal
```

stdout flag 파싱:

| flag | 룰 ID | 영역 |
|---|---|---|
| `origin(N)` | F | 산문 + array (sal 외) |
| `rootURL(N)` | 13 | 동일 |
| `listPage(N)` | E | 동일 |
| `wikiQuota(N%)` | 14 | 글로벌 (sal 제외) |
| `sidebarSources(N)` | L | sidebar* |
| `arrayBrokenRef(N)` | J | detailReady array |
| `orderViolation` | K | 본문 첫 등장 |
| `selfCite` | F' | careerwiki.org host |
| `idxGap` | — | 글로벌 idx |
| `mojibake(N)` | — | text/url U+FFFD |
| `bracketPrefix(N)` | — | text 앞 [N] |
| `brokenRef(N)` | I | 본문 [N] > srcLen (산문) |
| `dup(N)` | — | 한 필드 같은 [N] 2회+ |
| `orphan(N)` | H **+ proseBodyOrphan** | 산문 (PR 14 활성화) |
| `arrayItemPeriod(N)` | X | detailReady array 항목 마침표 (WARN) |
| `sourcePositionCluster(N)` | Y | detailReady cluster (WARN) |
| `urlCountInsufficient(N<X)` | **Z (2026-05-10)** | 글로벌 URL count 부족 (WARN) |
| `bodyWithoutSources(N)` | **ZZ (2026-05-10)** | 본문 충실 but _sources 부재 (WARN) |
| `sourcesWithoutMarkers(N)` | **ZZZ (2026-05-11)** | _sources 있는데 본문 [N] 0개 (**FAIL**) |
| `orphanSources(N)` | **ZZZZ (2026-05-11)** | 본문 미존재 영역에 _sources 잔존 (**FAIL**) |

**proseBodyOrphan** (PR 14, 2026-05-08): 산문 9 BODY_FIELDS (`way` / `summary` / `trivia` / `overviewWork.main` / `overviewProspect.main` / `overviewAbilities.technKnow` / `overviewSalary.sal` / `detailWlb.wlbDetail` / `detailWlb.socialDetail`) 본문 [N] vs `_sources[fieldKey]` 정합 — `_proseRaw` namespace 활용.

**urlCountInsufficient (룰 Z, 2026-05-10)**: force-enhance 후 직업당 _sources URL count < `max(12, fieldsCount × 1.5)`이면 WARN. 다음 cycle 자동 트리거 역할 (FAIL X — patch 차단 X). 2026-05-09 사고 (6 직업 URL <10) 재발 방지.

### 1-A-2. **sparse fieldKey 식별 의무 (룰 Z, 2026-05-10 신규)**

baseline `_sources` 가져온 후 fieldKey별 count 보고:

```
[직업명] _sources baseline:
  way: 3
  trivia: 2
  overviewProspect.main: 0  ← sparse (보강 대상)
  detailWlb.wlbDetail: 1   ← sparse (보강 대상)
  detailWlb.socialDetail: 0 ← sparse (보강 대상)
  detailReady.curriculum: 5
  detailReady.recruit: 3
  detailReady.training: 0  ← sparse (보강 대상)
total URL: 14, fields: 5/8
sparse fieldKey list: [overviewProspect.main, detailWlb.wlbDetail, detailWlb.socialDetail, detailReady.training]
```

**기준**: count 0 또는 1인 fieldKey = sparse. Phase 2 PATCH에서 모두 보강 의무.

**누락 영역 cleanup-only force-enhance 사고 패턴**:
- 패턴 A: cleanup으로 broken 5건 + rootURL 3건 제거 → _sources 8건 줄어든 상태로 종료. 신규 보강 X. → 2026-05-09 대학교수 (URL=4)
- 패턴 B: way 글자수만 늘림 / careerTree만 추가, detailReady·sidebar 출처 추가 X. → 2026-05-09 기업고위임원 (URL=2), 리포터 (URL=7)

### 1-A-3. **zero-registration fieldKey 식별 의무 (룰 ZZ, 2026-05-10 신규)**

`_sources`에 등록 안 된 영역 (zero-registration)도 별도 식별. sparse fieldKey 식별 (1-A-2)이 _sources 등록된 fieldKey만 점검하므로, 본문은 충실한데 _sources에 fieldKey 자체 부재인 케이스 silent 통과.

**검사 대상**:
- 산문 5 영역: `way` / `trivia` / `overviewProspect.main` / `detailWlb.wlbDetail` / `detailWlb.socialDetail`
- detailReady array 3 영역: `curriculum` / `recruit` / `training`

**판정**:
- 산문: `_proseRaw[fieldKey].length >= 100` AND `_sources[fieldKey]` 부재 또는 url 0건 → zero-registration
- detailReady array: 항목 2+ AND 모든 항목 [N] 마커 0 AND `_sources["detailReady.{sub}"]` 부재 또는 url 0건 → zero-registration

**보고 형식**:
```
[직업명] zero-registration fieldKey list:
  detailWlb.wlbDetail: body 157자 / _sources 부재 ← 보강 의무
  detailWlb.socialDetail: body 115자 / _sources 부재 ← 보강 의무
  detailReady.curriculum: 3 항목 모두 [N] 0 / _sources 부재 ← 보강 의무
  detailReady.training: 3 항목 모두 [N] 0 / _sources 부재 ← 보강 의무
```

**Phase 2 PATCH 의무**: zero-registration 영역 모두 보강 (_sources 신규 등록 + 산문은 본문 [N] 마커 추가, array는 항목별 [N]).

**사고 사례 (2026-05-10 사용자 발견)**: 경찰관 detailWlb.wlbDetail(157자)/socialDetail(115자)/curriculum(3)/training(3) 본문 충실 but [N]+_sources 모두 0. master force-enhance가 detailReady.recruit만 처리. 103 직업 sample 결과 42% 영향.

**audit 자동 검출**: `audit-via-api.cjs --exclude-sal`에서 `bodyWithoutSources(N: f1,f2,...)` WARN. 다음 cycle 트리거.

**제외 영역**: `overviewWork.main` / `overviewAbilities.technKnow` / `summary` — CareerNet API 원본 데이터 영역. UCJ 출처 의무 X (false positive 회피).

### 1-B. 본문 fact 정확성 사전 검증 (NEW)

`reference/fact-verification.md` 참조. 본문 통계/숫자/회사명 → WebSearch cross-check. mismatch 발견 시 fact 정정 작업 범위에 포함 (CLEANUP + fact 정정 모드).

이 단계는 enhance 사이클에선 신규 작성 전 1차 출처 검증으로 작동, cleanup 사이클에선 기존 fact 재검증으로 작동.

---

## Phase 2 — ANALYZE

### 2-0. 영역 분류 매트릭스 (먼저 결정)

`reference/area-classification.md` 참조. 각 finding이 산문 / detailReady array / sidebar 영역 중 어디 속하는지 분류. fix 패턴이 다르다.

### 2-1. detailReady array — 4단계 fallback

`reference/fix-patterns.md` 참조. 단순 REMOVE 시 UCJ 룰 A FAIL이라 신중히:
1. URL 교체 (선호) — WebFetch deep page 발굴
2. 본문 fact 일반화 + url 교체
3. 항목 merge (정보 손실, 4+ 항목일 때만)
4. 인정 + pending 기록

### 2-2. 산문 / sidebar — 직접 fix

산문 src REMOVE + body [N] RE-INDEX 가능. sidebar* `_sources` 통째 DELETE (`{delete:true}`).

### 2-3. fact 정정 (CLEANUP + fact 정정 모드)

`reference/fact-verification.md` 절차. 본문 통계/숫자/회사명 정정 + 새 출처 등록.

### 2-4. **sparse + zero-registration fieldKey 보강 의무 (룰 Z + ZZ, 2026-05-10 신규)**

Phase 1-A-2 (sparse) + 1-A-3 (zero-registration) 식별 영역 **모두** 보강 의무. cleanup-only / 부분-처리 force-enhance 사고 차단.

**원칙**:
- 영역당 최소 1개 deep URL, 평균 2~3개 목표
- 산문 영역 (way / trivia / overviewProspect.main / detailWlb.wlbDetail / detailWlb.socialDetail / overviewAbilities.technKnow): 본문 fact마다 출처 등록
- detailReady array (curriculum / recruit / training): 항목별 1:1 출처 매핑 (룰 Y와 정합)
- sidebar 영역은 sidebar* 항목 자체 url로 보강 (`_sources["sidebar*"]` 등록 X — 룰 L)

**금지 패턴**:
- way 글자수만 늘리고 새 출처 발굴 X (기업고위임원 사고)
- careerTree 신규에만 집중 + detailReady 영역 출처 1씩만 (리포터 사고)
- cleanup 후 sources 8건 줄어든 채 종료 (대학교수 사고)
- wiki cleanup 후 1차 출처 1:1 교체로 끝 (간호조무사 — 수 비슷)

**target**: URL count ≥ `max(12, fieldsCount × 1.5)`. Phase 6 VERIFY에서 검증.

---

## Phase 3 — PATCH

### 3-A. minimal payload 구성

```js
const payload = {
  fields: {
    // 변경된 본문만. 미변경은 미포함
    way: "...[1][2]",
    trivia: "...[1]",
  },
  sources: {
    // _sources 변경 fieldKey만
    way: [...],
    "sidebarOrgs": { delete: true },  // sidebar* DELETE
  },
  changeSummary: "[job-data-master] {mode} — {fixes 요약}",
  // 선택 (sal-readonly 호환):
  _jobSlug: "<slug>",
};
```

### 3-B. 보호 영역 강제 (payload 빌드 시)

```bash
# payload 작성 후 grep으로 자가 차단:
grep -E "overviewSalary|wageSource" payload.json && echo "FAIL: sal 포함" && exit 1
grep -E "careerTree" payload.json | grep -v "_careerTreeNote" && echo "FAIL: careerTree 포함" && exit 1
```

(enhance 모드의 신규 careerTree 생성은 wrangler d1 직접 INSERT — payload에 포함 X. 기존 careerTree 수정/삭제 절대 X.)

### 3-C. ENHANCE 모드 — Self-Report 17필드 체크리스트

`reference/enhance-fields-spec.md` 참조. 17필드 (12 필드 + sidebarOrgs/heroTags/youtubeLinks/careerTree/_careerTreeNote/_youtubeSearchNote) 상태 보고. ✅완료 / ⚠️부분 / ❌미작업 / 🔒스킵.

---

## Phase 4 — VALIDATE

```bash
node scripts/validate-job-edit.cjs payload.json
```

errors 0. 산문 영역 게이트 (PROSE_BODY_FIELDS 9 필드 orphan / brokenRef / dup) 자동 통과 확인.

`_sources["overviewSalary.sal"]` 변경 포함 시 즉시 FAIL — 절대 포함 X.

(sal-readonly 호환 — `_jobSlug` 포함하면 `validateAsync`가 prod에서 prev sal sources fetch하여 strict 검증.)

### 4-A. 룰 ZZZ/ZZZZ 차단 룰 (2026-05-11 신규)

validate-job-edit.cjs가 다음 두 룰로 POST 전 차단:

- **`[sourcesWithoutMarkers]` FAIL** (룰 ZZZ): body 100자+ AND _sources url 1+ AND 본문 [N] 0개. 출처 등록과 본문 [N] 박힘이 동반되지 않으면 차단.
- **`[orphanSources]` FAIL** (룰 ZZZZ): _sources fieldKey가 ALLOWED set 미포함. ALLOWED = PROSE_BODY_FIELDS (산문 9) + detailReady.{curriculum,recruit,training,researchList,certificate}. 미사용 fieldKey (예: detailGrowth.growth, detailWork.workDetail) 등록 차단.

→ 두 룰 FAIL이면 POST 절대 X. 본문 [N] 박는 작업 / fieldKey 교정 / _sources 제거 중 택1 후 재validate.

---

## Phase 5 — POST

```bash
curl -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @payload.json
```

또는 Node.js fetch + UTF-8:

```js
await fetch(`https://careerwiki.org/api/job/${id}/edit`, {
  method: 'POST',
  headers: { 'X-Admin-Secret': 'careerwiki-admin-2026', 'Content-Type': 'application/json; charset=utf-8' },
  body: JSON.stringify(payload),  // UTF-8 자동
});
```

> 🚫 Windows curl 인라인 한글 (`-d '{"name":"한글"}'`) 절대 X — CP949 mojibake 차단

`change_summary` 마커 형식 강제:
- ENHANCE 모드: `[job-data-master] enhance — way·trivia·detailWlb·... 17필드 보완`
- CLEANUP 모드: `[job-data-master] cleanup — rootURL=2→0, sidebarSources=1→0, ...`
- fact 정정 모드: `[job-data-master] cleanup — factCorrected=1 (trivia 0.6→0.82 mSv WebSearch verified)`

---

## Phase 6 — VERIFY

### 6-A. audit-via-api 재실행

```bash
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal
```

CLEAN (또는 4단계 인정만 잔존) 확인.

### 6-B. prod 페이지 fetch + 키워드 매칭

```bash
curl -s "https://careerwiki.org/job/<slug>" | grep -o "변경 키워드"
```

HTTP 200 + 본문 키워드 등장 확인. 미반영이면 캐시 우회:
```bash
curl -s "https://careerwiki.org/job/<slug>?nocache=1" | grep -o "키워드"
```

### 6-C. (옵션) full-quality-audit

```bash
node scripts/full-quality-audit.cjs --slug=<slug>
```

Gate 1 (각주) PASS 확인. Gate 4 ID 역전 WARN은 editService 구조적 동작 — 정상.

### 6-D. **URL count 검증 (룰 Z, 2026-05-10 신규)**

force-enhance 사이클 종료 직전 URL count target 도달 검증:

```bash
node -e "
fetch('https://careerwiki.org/api/jobs/<slug>').then(r=>r.json()).then(j=>{
  const s = (j.data||j)._sources || {};
  const urls = Object.values(s).reduce((n,a)=>n+(Array.isArray(a)?a.filter(x=>x.url).length:0),0);
  const fields = Object.keys(s).length;
  const target = Math.max(12, Math.ceil(fields*1.5));
  console.log('URL count:', urls, '/ target:', target, '/ fields:', fields);
  if (urls < target) console.log('⚠️ urlCountInsufficient — RETRY (Phase 2 재진입, sparse fieldKey 보강)');
  else console.log('✅ PASS');
})"
```

**판정**:
- URL count ≥ `max(12, fieldsCount × 1.5)` → PASS
- 미달 → **RETRY** (Phase 2 재진입, 추가 sparse fieldKey 보강)
- 가구조립원 시범 (URL 23, fields 9, target 14) reference 패턴

**RETRY 횟수 1회 후도 미달**:
- (a) 4단계 인정 (deep URL 발굴 실패 영역만 인정 + pending 기록)
- (b) STOP + 사용자 보고 (사고 가능성)

audit-via-api.cjs 출력에서 `urlCountInsufficient(N<X)` flag로 자동 검출.

### 6-E. **bodyWithoutSources 검증 (룰 ZZ, 2026-05-10 신규)**

force-enhance 사이클 종료 직전 zero-registration 영역 부재 검증:

```bash
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal | grep bodyWithoutSources
# clean 또는 비어있으면 PASS
# bodyWithoutSources(N: f1,f2,...) 표시되면 → RETRY (Phase 2 재진입, 해당 영역 보강)
```

**판정**:
- bodyWithoutSources 0건 → PASS
- 1건+ → **RETRY** (Phase 2 재진입, 표시된 fieldKey 모두 _sources 등록 + 본문 [N] 마커 추가)

**제외 영역**: overviewWork.main / overviewAbilities.technKnow / summary는 CareerNet API 원본 — 룰 ZZ 자동 제외.

### 6-F. **sourcesWithoutMarkers 검증 (룰 ZZZ, 2026-05-11 신규 — FAIL)**

force-enhance 사이클 종료 직전 marker 부재 영역 검증:

```bash
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal | grep sourcesWithoutMarkers
# clean 또는 비어있으면 PASS
# sourcesWithoutMarkers(N: f1(bodyLen/srcsCount),...) 표시되면 → RETRY (Phase 2 재진입, 본문 [N] 마커 추가)
```

**판정**:
- sourcesWithoutMarkers 0건 → PASS
- 1건+ → **RETRY 또는 STOP** — body 100자+이고 _sources 등록 영역인데 본문에 [N] 마커 0개. 출처를 등록했으면 본문에 1개 이상 [N] 박혀야 함. fact가 본문에 안 등장하면 출처 자체 부적격(제거 + 룰 ZZ 재발) → 출처 적격이면 본문 [N] 추가 또는 본문 보강.

**검사 대상 8 영역**: `way` / `overviewProspect.main` / `trivia` / `detailWlb.wlbDetail` / `detailWlb.socialDetail` / `overviewWork.main` / `summary` / `overviewAbilities.technKnow`.

**ZZZ vs ZZ 비교** (정반대 사고):
- 룰 ZZ: body 충실 + _sources 0개 → 출처 발굴해서 등록 + [N] 박기
- 룰 ZZZ: body 충실 + _sources 1+ + 본문 [N] 0개 → 본문 [N] 추가 (또는 출처 부적격이면 제거)

**사고 사례 (2026-05-11 사용자 발견)**: 경찰관 "출처 14개 있는데 인라인 각주 안 박힘". 362 master 직업 audit 8건 발견 (abilities 5건 / way 2건 / socialDetail 1건).

### 6-G. **orphanSources 검증 (룰 ZZZZ, 2026-05-11 신규 — FAIL)**

force-enhance 사이클 종료 직전 본문 미존재 영역 검증:

```bash
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal | grep orphanSources
# clean 또는 비어있으면 PASS
# orphanSources(N: f1[area/srcs],...) 표시되면 → RETRY (Phase 2 재진입, _sources fieldKey 제거 또는 본문 생성)
```

**판정**:
- orphanSources 0건 → PASS
- 1건+ → **RETRY 또는 STOP** — 본문이 _proseRaw에도 detailReady에도 API top-level에도 없거나 너무 짧은데 _sources만 잔존. 두 가지 fix:
  - (a) 해당 fieldKey가 유효 영역이면 본문 작성 (산문 50자+ 또는 detailReady array 항목 추가)
  - (b) 유효 영역 아니면 _sources에서 fieldKey 자체 제거

**area 종류**:
- `body-missing`: API 응답에 fieldKey 자체 미존재 (예: 경찰관 detailGrowth/detailWork)
- `body-too-short`: 본문 존재하지만 trim 후 50자 미만
- `detailReady-empty`: detailReady array가 빈 배열 또는 모든 항목 empty

**사고 사례 (2026-05-11 사용자 발견)**: 경찰관 `_sources.detailGrowth.growth`(2건) + `_sources.detailWork.workDetail`(2건) — API top-level에 detailGrowth/detailWork 자체 없는데 _sources 잔존 (4 출처 silent orphan). 362 master 직업 audit 10건 발견 (detailGrowth.growth 5 / detailWork.workDetail 5 / summary 2 / abilities 1 / overviewSalary.prospects 1 / overviewProspect.main 1).

**핵심 차단**: enhance 시 **존재하지 않는 fieldKey에 _sources 등록 금지**. detailGrowth.growth / detailWork.workDetail 영역은 master skill이 작성 대상 아니면 _sources 키 자체 생성 X.

---

## Phase 7 — REPORT

### 7-A. changeSummary 양식 강제 (2026-05-10 신규)

force-enhance 사이클의 changeSummary는 **모든 처리 영역 list 의무**:

```
✅ 올바른 형식:
[job-data-master] enhance — force-enhance: way + trivia + overviewProspect + detailWlb.wlbDetail +
  detailWlb.socialDetail + detailReady.curriculum + detailReady.recruit + detailReady.training +
  sidebarOrgs (각 N건 출처 보강)

❌ 잘못된 형식 (사고 패턴):
[job-data-master] enhance — force-enhance: detailReady.recruit (출처 0→3)
  → 다른 영역 처리 안 했으면 changeSummary에 명시 X — silent 부분 처리 사고
```

부분 처리 의도면 명시:
```
[job-data-master] enhance — force-enhance: detailReady.recruit only
  (sparse: way/trivia 처리됨; zero-registration 잔존: detailWlb / curriculum / training — 4단계 인정 또는 다음 cycle)
```

**경찰관 사고 (2026-05-10)**: rev 14306 changeSummary "force-enhance: detailReady.recruit (출처 0→3)" — 다른 영역 무시하고 종료. 본 룰로 차단.



DONE / RETRY 형식 (SKILL.md 참조). 

배치 처리 시 — 직업당 1개 row + Summary:

```
=== Batch Result ===
DONE 5/5
- 가수 rev=14270 mode=cleanup audit=CLEAN
- 가축사육자 rev=14264 mode=cleanup audit=CLEAN
- ...
```

---

## END_TRACKING (배치 완료 시)

```bash
node scripts/skill-runs-stats.cjs --since=2026-05-08
```

p50/p90 시간 + 누적 토큰 + 결과별 count 보고.

---

## Phase 8 — DEPLOY ⚠️ **PR 머지 후 즉시 (2026-05-10 신규)**

**원칙**: skill 또는 코드 변경 PR 머지 후 즉시 main worktree에서 `npm run deploy` 실행. main HEAD = prod state 동기화 보장. **"auto-deploy 대기" 가정 절대 X**.

**Why**: 2026-05-10 사고 — PR #18~24 (7개) 머지됐지만 1일 동안 prod deploy 안 됨. 본 프로젝트는 Cloudflare GitHub auto-deploy 미구성 (`package.json`의 `"deploy": "node scripts/safe-deploy.cjs"` 수동 실행 방식). 사용자가 admin 페이지에서 master/예전 분리 UI 안 보여 발견.

`feedback_pr_merge_includes_deploy.md` 룰 박힘.

### 8-A. main worktree로 이동 후 deploy

```bash
# Windows PowerShell
Set-Location C:\Users\user\Careerwiki
git pull origin main   # 최신 HEAD 확인
npm run deploy         # safe-deploy.cjs: tsc → vite build → wrangler pages deploy
```

`safe-deploy.cjs` exit 0 + deployment URL 반환 확인. 예: `Deployment complete! Take a peek over at https://519fade2.careerwiki-phase1.pages.dev`.

### 8-B. prod 검증

```bash
# 1. 직업 page (인증 X)
node -e "fetch('https://careerwiki.org/job/<slug>').then(r=>console.log('HTTP',r.status))"
# 기대: 200

# 2. admin page (인증 X anonymous fetch는 401 정상)
node -e "fetch('https://careerwiki.org/admin/job-equalize').then(r=>console.log('HTTP',r.status))"
# 기대: 401 (인증 page 도달 OK)

# 3. wrangler deployment list로 새 commit hash 반영 확인
npx wrangler pages deployment list --project-name=careerwiki | head -8
# 기대: 가장 최근 row의 Source = main HEAD commit hash
```

### 8-C. 보고 의무 항목

PR 머지 보고 끝에 다음 명시 의무:
- ✅ PR 머지 (PR # + main HEAD)
- ✅ **deploy 완료 / preview URL: `https://<id>.careerwiki-phase1.pages.dev`**
- ✅ wrangler deployment list 새 commit 반영 확인
- ✅ prod URL ping 응답 (직업 200 / admin 401)

### 8-D. 보호 영역 (deploy 시)

- **worktree에서 deploy 절대 X** — CLAUDE.md `Worktree 배포 롤백` 룰 (worktree 코드 → 다음 main 배포 시 롤백됨)
- **pre-commit hook 우회 (`--no-verify`) 절대 X** — `scripts/check-secrets.cjs`가 비밀키 차단
- **main 외 branch에서 deploy 절대 X**

### 8-E. deploy 실패 시

- 즉시 STOP + 사고 보고 (root cause + 시도한 deploy 출력)
- 코드 변경 새 PR로 fix (예: tsc error / build error)
- 사용자 결정 받기 전 추가 retry X

### 8-F. cleanup-only / DB-only 작업은 deploy 불필요

force-enhance 사이클은 DB 직접 작업 (POST /api/job/{id}/edit) — 코드 변경 없으면 deploy 불필요. 본 Phase 8은 **코드 PR 머지 시에만** 적용.

직업당 force-enhance (Phase 0~7) → DB rev 변경 → prod 페이지에 즉시 반영 (deploy 무관).

---

## See Also

- `feedback_pr_merge_includes_deploy.md` — 본 룰의 사용자 영구 메모리 룰
- CLAUDE.md `## CareerWiki-Specific Rules` 배포 섹션
- `scripts/safe-deploy.cjs` — 본 deploy 명령
