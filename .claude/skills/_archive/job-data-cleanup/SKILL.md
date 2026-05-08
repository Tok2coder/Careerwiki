---
name: job-data-cleanup
description: >
  [ARCHIVED — superseded by job-data-master, 2026-05-08]
  본 스킬은 더 이상 사용하지 않습니다. 기존 사이클의 reference로만 보존됩니다.
  새 작업은 반드시 `job-data-master` 스킬을 사용하세요.
  master 스킬이 enhance + cleanup + 산문 영역 audit + fact verification 모두 통합 처리합니다.
---

# CareerWiki 직업 데이터 cleanup 스킬

이미 `[job-data-enhance]` 마커가 부착된 직업에 대해 audit FAIL 항목만 surgical하게 정리한다. 본문 fact는 보존, 출처/마커/sidebar 영역만 손댄다. **신규 콘텐츠 추가·필드 보강은 이 스킬의 범위가 아니다 — `job-data-enhance`가 처리한다.**

---

## When to use

- 대상 직업이 이미 `[job-data-enhance]` 마커 보유 (page_revisions에 enhance 이력 존재)
- `audit-via-api.cjs <slug> --exclude-sal` 결과 1+ FAIL
- FAIL 종류가 본 스킬 fix 패턴 표에 포함된 것

키워드 트리거: "cleanup", "audit FAIL fix", "마커 정리", "출처 정리", "rootURL 수정", "sidebarSources 제거", "wikiQuota 줄이기", "origin 잔존 정리", "orderViolation fix".

## When NOT to use

- **신규 직업** (`[job-data-enhance]` 마커 미보유) → `job-data-enhance` 사용
- audit CLEAN (수정할 게 없음)
- **sal/wage 영역 단독 FAIL** → 본 스킬은 sal 영역 절대 손대지 않음. `--exclude-sal` 옵션으로 sal 영역 검증을 skip하므로 audit 결과에 sal FAIL이 안 보임. 만약 보호 스킵 없이 audit 했더니 sal만 FAIL이라면 무시 (별도 sal 정비 사이클 필요)
- 본문 fact 자체가 부정확 → `job-data-enhance` 풀 사이클로 본문 재작성

---

## Phase 0 — SYNC

```bash
git fetch origin main
git log --oneline -1 origin/main
```

main HEAD가 `MAIN_HEAD_MIN` (현재 `384ce33` — `--exclude-sal` 머지 후) 미만이면 즉시:

```bash
git pull origin main
```

---

## Phase 1 — AUDIT

```bash
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal
```

stdout에서 FAIL flags 파싱. 각 flag는 룰 ID에 매핑된다:

| flag | 룰 ID | path |
|---|---|---|
| `origin(N)` | F | `_sources[fieldKey][i]` (sal 외) |
| `rootURL(N)` | 13 | 동일 |
| `listPage(N)` | E | 동일 |
| `wikiQuota(N%)` | 14 | 글로벌 (sal 제외) |
| `sidebarSources(N)` | L | `_sources["sidebar*"]` |
| `arrayBrokenRef(N)` | J | `detailReady.{curriculum,recruit,training}` 항목 |
| `orderViolation` | K | 본문 [N] 첫 등장 sequential 위반 |
| `selfCite` | F' | `careerwiki.org` host |
| `idxGap` | — | 글로벌 idx 1..N 연속 |
| `mojibake(N)` | — | text/url U+FFFD |
| `bracketPrefix(N)` | — | `text` 앞 `[N]` |
| `brokenRef(N)` | I | 본문 [N] > `_sources[fieldKey].length` |
| `dup(N)` | — | 본문 [N] 같은 마커 ≥2회 |
| `orphan(N)` | H | `_sources[fieldKey][i]` 본문 미인용 (WARN, 보통 cleanup 대상 X) |

상세 finding은 `audit-via-api.cjs --json` (옵션 추가 필요 시 다른 호출) 또는 stdout extra lines에서 수집.

---

## Phase 2 — ANALYZE (Fix 패턴 매핑)

### Phase 2.0 — 영역 분류 매트릭스 (먼저 결정)

각 finding이 **어느 영역**에 속하는지 분류한다. 영역에 따라 fix 가능 패턴이 다르다.

| 영역 종류 | 예시 path | UCJ 각주 필수? | rootURL/origin fix 패턴 |
|---|---|---|---|
| **산문 필드** | `trivia`, `overviewProspect.main`, `way`, `summary`, `detailWlb.wlbDetail`, `detailWlb.socialDetail`, `overviewWork.main`, `overviewAbilities.technKnow` | X | src REMOVE + body `[N]` 제거 OK |
| **detailReady array** | `detailReady.curriculum`, `detailReady.recruit`, `detailReady.training` | **모든 항목 [N] 필수** (validate 룰 A `[UCJ각주항목누락]`) | src REMOVE 시 항목 마커 사라져 즉시 FAIL. **4단계 fallback** 적용 |
| **사이드바** | `sidebarCerts._sources`, `sidebarOrgs._sources`, `sidebarMajors._sources`, `sidebarJobs._sources` | (orphan만) | 통째 DELETE (`{delete:true}`) |

**왜 영역 분류가 필요한가?** 산문 필드는 src REMOVE → body [N] 제거가 단순 작동하지만, detailReady array는 항목이 [N] 마커를 잃으면 validate `[UCJ각주항목누락]` FAIL. 따라서 detailReady array의 rootURL/origin/listPage fix는 **반드시 url 교체 또는 일반화** 우선. 단순 REMOVE는 항목 자체를 함께 제거할 때만 가능.

### Phase 2.1 — detailReady array rootURL/origin/listPage fix 4단계 fallback

순서대로 시도:

**1단계 — URL 교체 (선호)**
- WebFetch로 협회/기관 deep page 발굴 (예: `kgames.or.kr/` → `kgames.or.kr/kr/about/index.php`, `learn.unity.com/` → `learn.unity.com/pathway/junior-programmer`)
- WebFetch 본문에 fact 단어/통계 등장 확인
- PASS → `_sources[idx].url`만 교체. body는 그대로. 항목 마커 [N] 그대로 유지 → UCJ 룰 PASS

**2단계 — 본문 fact 일반화 + url 교체** (URL 교체 실패 시)
- 항목 본문을 더 일반적 fact로 약화 (예: 항목 본문 "kgames.or.kr 회원사 list" → "협회 회원사 list")
- 일반화된 fact를 cover하는 deep page 발굴 (root보다는 deeper, 단 1단계만큼 specific할 필요 X)
- 본문 1개 변경 + src url 교체. UCJ 마커 [N] 유지 → UCJ 룰 PASS
- **일반화는 정보 가치 ↓** — 1단계 시도 후만 진입

**3단계 — 항목 merge** (단일 항목 fact가 너무 약하면)
- 인접 항목의 fact가 같은 출처를 cover한다면 두 항목을 하나로 합침
- _sources idx 정리 + body marker RE-INDEX
- 위험: 정보 손실. 신중히 사용. 항목 수 4 이상일 때만 권장 (3 이하면 정보 손실 임팩트 큼)

**4단계 — 인정 + pending 기록** (모든 fallback 실패 시)
- src 그대로 유지 (root URL 잔존)
- 사고 인정 → `~/.claude/projects/.../memory/deck/04-pending.md` 직업명 + 룰 + 잔존 finding 기록
- audit는 영구 FAIL 1건 (게임-기획자 sal id=3 같은 패턴 — 전사적 보류)
- 사용자에게 **명시 보고** + 다음 cleanup 사이클 또는 별도 enhance 사이클로 이관

### Phase 2.2 — 룰별 Fix 패턴

| 룰 | Fix 패턴 |
|---|---|
| **`[origin]`** (career/work/work24/wagework/job.go.kr) — **산문 필드** | `_sources[fieldKey]`에서 src REMOVE + 본문에서 `[N]` 마커 제거 + 후속 마커 RE-INDEX (1..N 연속). 본문 fact는 그대로 |
| **`[origin]`** — **detailReady array** | **4단계 fallback 적용** (1단계 우선). 단순 REMOVE 시 UCJ FAIL — 금지 |
| **`[rootURL]`** — **산문 필드** | WebFetch deep candidate (협회/기관 deep page). fact cover 검증 PASS면 url만 교체 (text 유지). cover X면 src REMOVE + 본문 마커 RE-INDEX |
| **`[rootURL]`** — **detailReady array** | **4단계 fallback 적용** (1단계 우선) |
| **`[listPage]`** — **산문 필드** | WebFetch deep article. PASS면 url 교체. 실패면 REMOVE + RE-INDEX |
| **`[listPage]`** — **detailReady array** | **4단계 fallback 적용** (1단계 우선) |
| **`[wikiQuota]` >30%** | wikipedia/namu src 중 cover 가장 약한 것부터 REMOVE + 본문 RE-INDEX. wikipedia 비율이 30% 이하로 떨어지면 stop. 1차 출처 (협회 deep / 정부 통계 / 학술 / 1차 미디어 deep article)는 보존 |
| **`[sidebarSources]`** | `_sources["sidebarOrgs"]` / `["sidebarCerts"]` / `["sidebarMajors"]` / `["sidebarJobs"]` 통째 DELETE (`{delete: true}` merge). 본문 sidebar* 항목은 미접촉 — 사이드바는 자체 `{name, url}` 객체로 표시 |
| **`[arrayBrokenRef]`** | `detailReady.{curriculum,recruit,training}` element 안 `[N]` 정정. element 단위 idx 검증 — element[i] 본문 [N] → `_sources["detailReady.{sub}"]` 의 (N-1)번째 entry 존재 필수 |
| **`[orderViolation]`** | 본문 `[1]`부터 sequential 첫 등장. body + `_sources` 동시 RE-INDEX. 도구: 본문에서 `[\d+]` regex로 첫 등장 순서 추출 → 1..N 매핑 → `_sources` 배열 reorder |
| **`[selfCite]`** (careerwiki.org) | self-citation src REMOVE + 본문 마커 제거 + RE-INDEX |
| **`[idxGap]`** | 글로벌 idx (`_sources[*][i].id`) 1..N 연속 강제. 빈 곳 메우거나 후속 idx shift |
| **`[mojibake]`** | text/url UTF-8 재인코딩. 원본이 mojibake면 src REMOVE (재발굴 불가). Node.js fetch로 POST (Windows curl 절대 X) |
| **`[bracketPrefix]`** | `text` 시작의 stray `[N] ` 제거 (예: `"[1] 한국직업능력연구원"` → `"한국직업능력연구원"`) |
| **`[brokenRef]`** | 본문 `[N]` 마커 N이 `_sources[fieldKey].length` 초과 → 마커 제거 또는 N을 존재하는 idx로 정정 |
| **`[dup]`** | 본문 같은 `[N]` 2회 이상 등장 — 두 번째부터 제거 (한 sentence 1 마커 max) |

**일반화는 마지막 수단** — fact cover 못 하는 src 제거 시 본문 fact가 의미를 잃지 않는지 확인. 의미 잃으면 deep page 재시도 (WebFetch). deep page도 실패면 본문 fact 일반화 (회사명 → 산업 표현). 일반화는 사용 가치를 떨어뜨리므로 deep page 시도가 우선.

---

## Phase 3 — PATCH

minimal payload — 변경된 field만:

```js
const payload = {
  fields: {},                  // 본문이 변경된 필드만 (RE-INDEX된 way/trivia/...)
  sources: {                   // _sources가 변경된 fieldKey만
    "way": [...],              // RE-INDEX된 array
    // sidebarSources DELETE 시:
    "sidebarOrgs": { delete: true }
  },
  changeSummary: "[job-data-cleanup] rootURL=2→0, origin=1→0"
};
```

**보호 영역**:
- `fields.overviewSalary` 절대 미포함
- `sources["overviewSalary.sal"]` 절대 미포함 (`[sal-readonly]` strict)
- `careerTree` 절대 미포함 (별도 사이클)
- 변경 안 한 field는 payload에 미포함 (`[minimalPOST]`는 changeSummary 마커만 부착하는 케이스만 차단)

---

## Phase 4 — VALIDATE

```bash
node scripts/validate-job-edit.cjs payload.json
```

errors 0 + 모든 적용 룰 PASS 확인. stdout 첨부.

`_sources["overviewSalary.sal"]` 변경이 payload에 들어가면 즉시 FAIL — 절대 포함 X.

---

## Phase 5 — POST

```bash
curl -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @payload.json
```

또는 Node.js fetch + UTF-8 (한글 mojibake 예방). Windows curl 인라인 한글 `-d '...'` 절대 X.

`change_summary`에 `[job-data-cleanup]` 마커 부착. enhance 마커와 분리.

---

## Phase 6 — VERIFY

```bash
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal
```

**OK clean** 확인 → DONE. FAIL 잔존 시 RETRY 1회 (Phase 2 재분석 + Phase 3 재패치). retry도 동일 사고면 STOP + 보고.

prod 페이지 fetch HTTP 200 + 본문 키워드 매칭으로 배포 반영 확인:

```bash
curl -s "https://careerwiki.org/job/<slug>" | grep -o "키워드"
```

---

## Phase 7 — REPORT

### DONE 형식

```
DONE: <slug> rev=N deep-audit=CLEAN externalHosts=N
fixes: rootURL=X→0, sidebarSources=Y→0, wikiQuota=Z%→W%, origin=V→0, arrayBrokenRef=U→0, orderViolation=T→0, listPage=S→0
WebFetch=R, no-self-validation=true
```

### RETRY 형식

```
RETRY: <root cause: 어떤 룰 / 어느 path / 시도한 fix / 실패 이유>
attempted: <what was tried>
blocker: <왜 막혔는지>
```

LLM 자가 "CLEAN"/"DONE" 라벨 1줄 통과 절대 금지. `audit-via-api.cjs --exclude-sal` exit 0 + "OK clean" 출력이 진리.

---

## Safety Rules (hardcoded 13개)

본 스킬은 다음 13 안전 룰을 빠짐없이 강제한다:

1. **WebFetch 강제** — 신규 URL은 등록 *전* WebFetch tool_use ≥ 1회. tool_uses 카운트 < new URL 카운트면 cleanup 무효
2. **Hallucinated 도메인 블랙리스트** — `kgta.or.kr` / `k-lpn.or.kr` / `kpba.co.kr` / `kindergarten.go.kr boardid 추정` / `humanrights.go.kr boardid 추정` / `gamejob.co.kr ASP path` / `careers.* deep path` / `learn.unity.com pathway 추정`. 등록 전 WebFetch 의무
3. **Phase 0-SYNC 필수** — main HEAD ≥ `MAIN_HEAD_MIN`. 미만이면 작업 시작 전 git pull
4. **sal-protection 절대** — `fields.overviewSalary` / `sources["overviewSalary.sal"]` 어떤 식으로든 손대지 X. payload에 미포함. audit는 `--exclude-sal` 사용으로 sal 검증 skip
5. **careerTree 보호** — `fields.careerTree` 어떤 식으로든 손대지 X. 별도 사이클 (`career-tree-fill` 등)이 처리
6. **본문 fact 보존** — 출처 정리만, 본문 단어/숫자/구체정보는 그대로. 일반화는 deep page 시도가 모두 실패할 때 마지막 수단
7. **minimal POST** — 변경된 field만 payload. 미변경 field 동봉 시 의도치 않은 덮어쓰기 위험
8. **DONE/RETRY 포맷 강제** — LLM 자가검증 1줄 통과 금지. `audit-via-api.cjs --exclude-sal` 결정적 검증만 진리
9. **main branch에서만 deploy** — worktree에서 deploy 시 다음 main 배포에서 롤백됨. cleanup은 DB만 수정 (코드 변경 없으면 deploy 불필요)
10. **Pre-commit hook 우회 금지** — `--no-verify` 절대 X. `scripts/check-secrets.cjs` 실패 시 원인 fix
11. **subagent fan-out 금지** — 본 세션 직접 처리. polling 1줄 → fan-out 사고 (어제 75 fan-out / 172M token) 재발 방지
12. **사고 발견 시 즉시 STOP** — retry 1회 후도 FAIL이면 STOP + 보고. 자체 판단으로 추가 retry 진행 X
13. **일반화는 사용 가치를 떨어뜨림** — deep page 시도 우선. 일반화는 마지막 수단. 본문에 회사명·통계·연도·금액·순위가 있으면 그 fact를 직접 cover하는 deep URL 발굴 노력

상세는 `reference/safety-rules.md` 참고.

---

## Examples

### Example 1 — rootURL 단순 url 교체

audit: `rootURL(1)` (way 필드, `https://www.kgames.or.kr/`)

본문 way: "...K-Games 파트너 리스트에 따르면 한국 게임 산업 매출은 2024년 19조원[1]..."

fix: WebFetch `https://www.kgames.or.kr/partnership/partner-list/` → "K-Games 파트너 2024" 키워드 등장 확인 → url만 교체 (text 유지).

```js
sources: {
  "way": [
    { id: 1, text: "한국게임산업협회", url: "https://www.kgames.or.kr/partnership/partner-list/" }
  ]
}
```

본문 RE-INDEX 불필요 (마커 [1] 그대로).

### Example 2 — origin 제거 + RE-INDEX

audit: `origin(1)` (way 필드, `_sources["way"][2].url = "https://www.work24.go.kr/..."`)

본문 way: "...자격은 [1][2][3]..."  (`[1]` 협회, `[2]` 통계청, `[3]` work24)

fix: src `[3]` REMOVE + 본문 `[3]` 제거.

```js
sources: { "way": [src1, src2] }    // 길이 3 → 2
fields: { "way": "...자격은 [1][2]..." }  // [3] 제거
```

후속 마커 없으면 RE-INDEX 필요 X. 있으면 4→3, 5→4 등 shift.

### Example 3 — sidebarSources DELETE

audit: `sidebarSources(1)` (`_sources["sidebarCerts"]` 길이 1, body sidebar에 `[N]` 마커 없음 — orphan)

fix: `_sources["sidebarCerts"]` 통째 삭제. sidebar 본문 (`{name, url}` 객체 배열)은 미접촉.

```js
sources: { "sidebarCerts": { delete: true } }
fields: {}    // 본문 변경 없음
```

### Example 4 — wikiQuota 38% → 22%

audit: `wikiQuota(38%)` (총 13 src 중 wiki 5건 = 38%)

fix: wiki 5건 중 cover가 가장 약한 2건 (개념 일반론 페이지) REMOVE + 본문 마커 제거 + RE-INDEX. wiki 3/13 = 23% → PASS.

```js
sources: {
  "way": [...],            // wiki 1건 제거 + RE-INDEX
  "trivia": [...],         // wiki 1건 제거 + RE-INDEX
}
fields: {
  "way": "...",            // 해당 마커 제거 + 후속 RE-INDEX
  "trivia": "..."
}
```

cover 강한 wiki (직업 정의 위키 페이지 등)는 보존.

---

## See Also

- `reference/fix-patterns.md` — 각 fix 패턴 상세 + edge cases + 코드 snippet
- `reference/safety-rules.md` — 보호 영역 명시 + 블랙리스트 + sal-protection 강조
- `scripts/skill-cache/audit-via-api.cjs` — 결정적 audit (--exclude-sal 표준)
- `scripts/validate-job-edit.cjs` — POST 직전 validate
- `.claude/skills/job-data-enhance/SKILL.md` — 풀 enhance (cleanup과 분리된 책임)
