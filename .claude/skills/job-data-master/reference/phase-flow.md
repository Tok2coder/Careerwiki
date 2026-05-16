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

### 0-B. ENHANCE 모드 — 21+ 영역 자동 enumerate 진단 (WL-KILL 강화, 2026-05-16)

🔥 **2026-05-16 WL-KILL 강화** — 화이트리스트 12필드 진단 폐기. 21+ 영역 자동 enumerate 강제.

`reference/enhance-fields-spec.md` 참조. `merged_profile_json` 기준 21+ 영역 점검:

**Prose Body 14 영역**:
- `way` / `summary` / `trivia` / `overviewWork.main` (duties) / `overviewProspect.main` / `overviewAbilities.technKnow` (abilities) / `detailWlb.wlbDetail` / `detailWlb.socialDetail` / `detailReady.curriculum` / `detailReady.recruit` / `detailReady.training` / `detailReady.researchList` / `detailReady.certificate` / `detailReady.pathExplore`
- (sal-protection: `overviewSalary.sal`은 진단도 skip)

**Sidebar 4 영역**: `sidebarJobs` / `sidebarMajors` / `sidebarCerts` / `sidebarOrgs`

**보조 영역**: `detailWlb.wlb` (등급) / `detailWlb.social` (등급) / `heroTags` / `youtubeLinks` / `careerTree`

각 영역별 권장 임계치 (text length, array count) 점검 + 부실 / 누락 분류.

⚠️ **WL-KILL 룰 강제**: 진단 후 Self-Report 21+ 영역 enumerate 의무 (`enhance-phase-procedures.md`). 1개라도 patch도 skip도 없는 영역 잔존 시 Phase 3 진행 차단.

⚠️ **`merged_profile_json` 기준 진단 강제** — `user_contributed_json` 단독 금지 (api 측 채움 false positive 발생).

⚠️ **사고 잔존 영역 알림** (PR #31 OMEGA 전수 재감사 기준):
- `overviewAbilities.technKnow` — Round 1~9 누락 빈도 1위 (조각가/모바일앱/양식조리 등 abilities 본문 350~500자 / _sources 0)
- `summary` — careernet 원본 충실로 자주 skip되나 zero-reg 케이스 다수
- `overviewWork.main` (duties) — careernet 원본 보존 후 _sources 매핑 누락

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

**proseBodyOrphan** (PR 14, 2026-05-08): 산문 9 BODY_FIELDS (`way` / `summary` / `trivia` / `overviewWork.main` / `overviewProspect.main` / `overviewAbilities.technKnow` / `overviewSalary.sal` / `detailWlb.wlbDetail` / `detailWlb.socialDetail`) 본문 [N] vs `_sources[fieldKey]` 정합 — `_proseRaw` namespace 활용.

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

---

## Phase 7 — REPORT

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
