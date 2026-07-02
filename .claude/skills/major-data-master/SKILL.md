---
name: major-data-master
description: >
  CareerWiki 전공(major) 데이터 통합 관리 스킬 — job-data-master의 전공판 (M-cycle).
  단일 entry point — 전공 상태별 자동 분기로 신규 enhance / cleanup / fact 정정 / 산문 영역 보강을 모두 처리한다.
  유저가 "전공 데이터 보완", "major 보완", "전공 배치", "전공 enhance", "전공 균등화",
  "학과 데이터 보완", "전공 NULL", "전공 채워줘", "major data master", "M-cycle", "M0 파일럿",
  "whatStudy 작성", "howPrepare 작성", "jobProspect 작성", "전공 출처 정리", "전공 각주 정리",
  "전공 audit FAIL fix", "전공 산문 보강", "전공 X개 보완" 등 어떤 표현을 써도
  반드시 이 스킬을 사용한다. 단일 전공이든 607 전공 배치든 본 스킬이 처리한다.
  직업(job) 데이터 작업은 job-data-master 스킬 사용 — 본 스킬은 major 전용.
---

# CareerWiki 전공(major) 데이터 master 스킬

`job-data-master` (Phase 0~7, 485줄)를 전공으로 이식한 단일 entry point. 설계 진리: `data/cycle/major_cycle_design_v1.md`. 배치 spawn 템플릿: `data/cycle/_major_dispatch_template_v1.md`.

> 🔴 **품질 패리티 (Jason 지시)**: 전공 결과물은 직업 데이터 보완과 동등 수준이어야 한다 — 산문 깊이(문단 수준 서술), deep URL 강제, WebFetch 검증 강제, 각주 양방향 정합 전부 job 스킬과 동일 강도. 필드와 게이트 수치만 전공용으로 치환됐다.
>
> 📌 본 SKILL.md는 **자족적(self-contained)** — job 스킬의 `reference/*.md` 9종을 포크하지 않고 전공에 필요한 핵심(fix 패턴·safety 룰·서버 동작)을 본문에 압축했다. 전공에 없는 개념(careerTree·sal/wage·detailReady array·sidebar* 세트·abilityList·industry_class)의 룰은 의도적으로 제외.

---

## When to use

모든 **전공(major)** 데이터 작업의 단일 entry point:
- 신규 enhance (`[major-data-master]` 마커 미보유 전공 — 현재 607 전공 전원 UCJ NULL이라 사실상 전부 여기)
- partial enhance (이미 enhance + 일부 필드만 보강)
- cleanup (audit FAIL 정리)
- 본문 fact 정정 (WebSearch cross-check mismatch 발견 시)
- 배치 처리 (M-cycle, multiple slug)

## When NOT to use

- 직업(job) 데이터 작업 → `job-data-master` 스킬 (본 스킬에서 `/api/job/*` 접근 절대 금지)
- 신규 전공 추가 (없는 전공 생성) → 별도 절차 (`/api/major/create`) — 본 스킬 범위 밖
- HowTo 가이드 → `howto-publish` 스킬

---

## Auto-branching (진입 시 자동 분기)

전공 상태 + audit 결과에 따라 4 모드 자동 분기:

```
1. is_active=0 (비활성)                    → SKIP (작업 X, 보고만)
2. [major-data-master] 마커 보유 + audit CLEAN → IDLE (DONE 즉시)
3. [major-data-master] 마커 보유 + audit FAIL  → CLEANUP 모드
4. 마커 미보유 + active                     → ENHANCE 모드 (풀 사이클)
```

**판정 SQL** (Phase 0에서 실행 — majors.id는 TEXT):
```sql
SELECT m.id, m.slug, m.name, m.is_active,
  (SELECT COUNT(*) FROM page_revisions
   WHERE entity_type='major' AND entity_id=m.id
     AND change_summary LIKE '%[major-data-master]%') AS marker_count
FROM majors m WHERE m.slug = ? OR m.name = ?;
```

→ `is_active=0` → SKIP. `marker_count=0` → ENHANCE. `marker_count≥1` → `audit-major-via-api.cjs` 실행 후 CLEAN/FAIL 분기.

> 현재 실측 (2026-07-02): 607 전공 전원 `user_contributed_json` NULL·편집 이력 0·whatStudy/howPrepare/jobProspect 전량 공백 — **M-cycle 기간엔 사실상 전부 ENHANCE 모드**. `--force-enhance` 옵션은 마커 보유 + audit CLEAN이어도 풀 사이클 강제 (job과 동일 semantics).

---

## 필드 스펙 (설계서 §2 — 렌더 확인 필드만)

### 채우는 필드

| 필드 | 내용 | 규칙 |
|---|---|---|
| `whatStudy` | 배우는 내용 산문 | **신규 작성, ≥300자 문단 서술 + 본문 [N] 각주** — 상세정보 탭 렌더 (`formatRichText`, `\n\n` 문단 분리) |
| `howPrepare` | 준비 방법 산문 | 〃 (렌더 확정 — 2026-07-02 신설 + M0 prod 검증) |
| `jobProspect` | 진로 전망 산문 | **신규 작성, ≥300자 + [N] 각주.** ⚠️ 렌더가 `\n` 단위 bullet 분리 — 3~5개 문장 블록을 `\n`으로 구분 작성 (한 덩어리 금지) |
| `summary` | 학과 소개 | **보강만** — careernet API 원문 존중, 전면 재작성 X. **`_sources["summary"]` 출처 등록 절대 금지** (careernet canonical) |
| `mainSubjects` | 주요 교과목 | API 값 있으면 보강 (array 타입 유지, 기존 항목 삭제 X) |
| `enterField` | 진출 분야 | 〃 (기존 타입 유지) |
| `licenses` | 추천 자격증 | 〃 (array 타입 유지) |
| `youtubeLinks` | 관련 영상 | 1~3개 (oembed 200 + title 매칭 verify, 한국어만). 부재 시 `youtubeLinks: []` + `_youtubeSearchNote` (탐색어 ≥6 or 카테고리 ≥3) — **무언 스킵 금지** |
| `heroTags` | 태그 | 있으면 유지, 부족 시 보강 (선택) |
| `_sources` | 출처 | text 한글 제목 필수 + 본문 [N] 양방향 정합 + 한 sentence 1 마커 max |

### 🔴 각주 컨벤션 (M0 렌더 사고로 확정, 2026-07-02)

- **본문 [N]은 필드-로컬** — 각 필드에서 1부터 시작 (직업과 동일 컨벤션). 예: jobProspect 본문은 [1]~[4], 그 필드의 1~4번째 출처를 가리킨다.
- 서버(major-editor)는 `_sources` id를 **전역 연속(max+1)**으로 부여하고, 템플릿이 필드-로컬 [N]→전역 표시번호로 매핑해 렌더한다 (unifiedMajorDetail 직업 등가 포팅, main ff9bef5).
- **작성자는 전역 id를 본문에 절대 쓰지 말 것** — 전역 번호를 쓰면 매핑이 깨져 raw `[N]` 텍스트가 노출된다 (M0 컴퓨터공학과 jobProspect 사고 형태).

### 🔴 보호영역 (전공판 sal-protection — 절대 미접촉)

fields에도 sources에도 아래 키 절대 포함 금지. POST 후 readback에서 diff 0 확인:

- `chartData` / `employmentRate` / `salaryAfterGraduation` — 취업률·급여 차트 (API 원천)
- `universities` / `recruitmentStatus` — 대학정보 탭 (API 원천)
- `relatedJobs` / `relatedMajors` / `sources`(origin) / `sourceIds` — 시스템 생성
- `aptitude` / `property` / `careerAct` / `relateSubject` / `mainSubject`(단수형 레거시) — API 원천, v1 미접촉

### 🔴 trivia 전송 절대 금지 (전공 특화 — 서버 레거시 함정)

`src/routes/major-editor.ts`에 레거시 로직: **patch fields에 `trivia` 키가 있으면 서버가 `jobProspect`를 user_contributed_json과 merged_profile_json 양쪽에서 삭제**한다. 전공 enhance의 핵심 필드인 jobProspect가 파괴됨. `fields.trivia` / `sources["trivia"]` 어떤 형태로도 전송 금지.

### 게이트 수치 (✅ M0 실측으로 확정 — totalE 12~14·distinct 8~10·산문 508~707자 전건 통과)

- totalEntries (모든 fieldKey `_sources` entry 합산) **≥ 12**
- distinct URL **≥ 8** (단일 기준 — 직업의 niche/major 분류 없음. patch 9개 분배 권장 — audit 1 offset 마진)
- 산문 3필드 (whatStudy/howPrepare/jobProspect) **각 ≥300자 + 각주 보유**

---

## 출처 정책 (전공 특화)

우선순위:
1. **대학 `.ac.kr` 학과 페이지 deep** — 학과 소개·커리큘럼·진로 페이지 (루트 금지). 최우선 pool: 해당 전공 개설 대학은 전국 수십 곳.
2. 정부 `.go.kr` deep — 정책·통계 페이지
3. 학회·협회 `.or.kr` deep / 한국 미디어 deep article (한국경제·전자신문·연합뉴스 등)
4. ko.wikipedia deep (보조)

**금지 패턴**:
- 🔴 **origin 자기인용 (전공 확장판)**: `career.go.kr` / `work.go.kr` / `wagework.go.kr` / `work24.go.kr` / `job.go.kr` — **majors 데이터 원천(CAREERNET / WORK24_MAJOR) 자기인용 절대 금지**. `careerwiki.org` 자기인용 금지.
- root URL을 구체 fact 출처로 등록 (대학 메인 → 학과 fact 출처 X)
- 검색/리스트 URL (`?q=`, `/search`, `/articleList?sc_word=`) / `_csrf` 세션 URL / 로그인 게이트 stub (R67 교훈 — 200이어도 정책위반)
- fabricated URL — **WebFetch tool_uses ≥ 신규 URL 수 강제** (환각 차단)

**전공 환각 리스크 게이트 (본 스킬 최중요 특화 룰)**:
- 교과목·커리큘럼·자격증·입시 fact는 **대학마다 다르다** — 산문은 "일반적 경향" 서술 강제 ("대학에 따라 다르나 일반적으로", "다수 대학에서" 등).
- **특정 대학 fact (특정 학교 커리큘럼·트랙·연계과정) 언급 시 그 대학 `.ac.kr` deep 출처 필수** — cover 못 하면 fact 제거 또는 일반화.
- 자격증 응시자격·시험과목은 시행처 deep 페이지 (q-net 시험일정 deep 등)로 cover. 자격증 카탈로그 URL (`q-net.or.kr/crf005.do?id=crf00505` 류 — 본문 <200자 카테고리 페이지)은 reject (job 룰 25 승계).

**Body-Source Coherence**: 본문 구체 fact (통계·연도·기관명·순위)는 그 fact를 직접 cover하는 deep 출처 매핑. cover 못 하면 ① 더 구체적 출처 발굴 → ② 본문 일반화 → ③ fact 제거. **한 sentence = 한 마커 max** — `[1][2][3]` 연속 금지, 다중 출처 시 sentence 분리.

---

## Phase 0~7 흐름

### Phase 0 — SYNC + 진단

```bash
git fetch origin main && git log --oneline -1 origin/main   # 최신 확인, 뒤처지면 pull
```

- 전공 상태 판정 (위 auto-branching SQL — `wrangler d1 execute careerwiki-kr --remote --command "..."`, ⚠️ `--json` flag 금지·plain stdout parse).
- ENHANCE 모드 진단: `merged_profile_json`에서 §필드 스펙 전 필드 현황 점검 (whatStudy/howPrepare/jobProspect 길이, mainSubjects/enterField/licenses 존재·타입, `_sources` 유무, 보호영역 값 스냅샷 백업 — POST 후 diff 0 대조용).
- **기존 값 타입 기록**: mainSubjects/enterField/licenses는 API 원천 타입 그대로 보강 (array는 array로 — string 덮어쓰기 금지).
- CLEANUP 모드: 진단 skip → Phase 1 audit 직진.

### Phase 1 — 발굴 (ENHANCE) / AUDIT (CLEANUP)

**ENHANCE**: WebSearch + WebFetch로 1차 출처 발굴.
- 발굴 순서: 개설 대학 `.ac.kr` 학과 페이지 (2~4곳) → 관련 학회/협회 `.or.kr` → 정부 통계/정책 deep → 미디어 deep article → 유튜브 (oembed verify).
- **Lazy abort 방지**: 1차 pool 부족 → 추가 8~10 site 시도 의무. "alternate 없음" 결론 전 minimum 10 site. 사전 abort 절대 X.
- 모든 등록 예정 URL은 WebFetch로 내용 검증 (본문 fact cover 확인 — 단순 키워드 hit X).

**CLEANUP**: `node scripts/skill-cache/audit-major-via-api.cjs <slug>` → FAIL flags 파싱 → fix 패턴 결정 (아래 Fix 패턴 표).

### Phase 2 — 작성

- 산문 3필드 각 ≥300자 문단 서술 + [N] 각주. summary 보강 (careernet 원문 존중·출처 등록 X). mainSubjects/enterField/licenses 보강 (타입 유지). youtubeLinks 의무 처리.
- **32K 출력 한도 대응**: 필드별 작은 파일 Write (`scripts/skill-cache/_tmp_major_<slug>_*.json`, 인접 2~3필드 묶음, 전공당 ~6개 이내) → `node -e`로 payload.json 조립. payload 통째 1회 Write/echo 금지.
- [N] 번호는 **fieldKey별 local 번호** — patch 내 `_sources[fk]` 배열 순서와 본문 [N] 위치 1:1.

### Phase 3 — PATCH 조립

```js
// payload.json
{
  "fields": {
    "whatStudy": "…[1]…[2]…",        // string, ≤7000자 (서버 400 한도)
    "howPrepare": "…[1]…",
    "jobProspect": "문장블록1 [1]\n문장블록2 [2]\n…",  // \n bullet 렌더 유의
    "summary": "…(보강)…",
    "mainSubjects": [...], "enterField": "...", "licenses": [...],
    "youtubeLinks": [{"url":"…","title":"…"}]   // 또는 [] + _youtubeSearchNote
  },
  "sources": {
    "whatStudy":  [{"text":"○○대학교 △△학과 — 교육과정 소개","url":"https://…ac.kr/…"}, …],
    "howPrepare": […], "jobProspect": […]
    // summary 키 금지 / 보호영역 키 금지 / trivia 키 금지
  },
  "changeSummary": "[major-data-master] enhance — whatStudy·howPrepare·jobProspect·youtubeLinks·…",
  "baseTimestamp": <user_last_updated_at 현재값>   // 충돌 감지 (409 시 재조회)
}
```

**서버 merge 동작** (`src/routes/major-editor.ts` 실측):
- `changeSummary`는 **top-level** — fields 안에 중첩 시 기본값 `"N개 필드 수정"`으로 저장 → 마커 미생성 → KPI 탈락 (R39 교훈).
- `_sources` id는 서버가 기존 max+1부터 연속 자동 부여 (job editor의 1..N renumber와 다름) — **동일 fieldKey 재POST 시 id 상승**. 렌더는 displayOrder 기준 1..N 재부여하므로 표시 번호는 안정. 재POST 최소화 (룰: 전공당 1회).
- `sources` 특정 fieldKey 삭제는 `{"delete": true}`.
- 🔴 **서버 `text: text || url` silent fallback** — text 누락 시 raw URL이 사이드바 노출 (job R1 109건 사고 동일 패턴). client에서 text 필수 강제: "기관명 — 페이지 제목" 한글 5자+.

### Phase 4 — VALIDATE (POST 전 셀프 게이트)

```bash
# 1. URL 생존 일괄 확인 (신규 URL 전부, node 1회 호출 — URL당 개별 Bash 금지)
#    404/410/NXDOMAIN = 교체 의무 / 000·403·timeout·TLS = 거짓양성 가능 (타 방법 재검) / 200·30x = OK
#    검색·리스트·_csrf·로그인게이트 URL은 200이어도 reject
# 2. 결정적 validate
node scripts/validate-major-edit.cjs payload.json
```

validate 게이트 (스크립트가 판정 — 자가 카운트 보고 무효): totalE≥12 / distinct≥8 / 산문 3필드 ≥300자 / 보호영역·trivia·summary-sources 접촉 차단 / text=URL 차단 / [N]↔_sources 양방향 정합 / youtubeLinks 영역 존재. **FAIL 상태로 POST 절대 금지.**

### Phase 5 — POST (전공당 1회 원칙)

```bash
curl -X POST "https://careerwiki.org/api/major/{id}/edit" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @payload.json
```

- **파일 기반만** (`-d @file.json`) — 인라인 한글 = mojibake hook 차단. 또는 Node fetch + UTF-8.
- id는 majors.id (TEXT). slug/name fallback 조회도 서버가 지원하나 id 사용 권장.
- 409 CONFLICT → 최신 user_last_updated_at 재조회 후 baseTimestamp 갱신 재시도 (1회).
- **동일 payload 반복 POST 금지.** 재POST는 audit FAIL 수정 시에만, 최대 2회, 재POST 전 latest rev 확인.

### Phase 6 — VERIFY (1라운드 — 과검증 루프 금지)

```bash
# 1. 마커 실존 확인 (자가 보고 X — DB 실측)
wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id, change_summary FROM page_revisions WHERE entity_type='major' AND entity_id='<id>' ORDER BY id DESC LIMIT 3"
# → change_summary에 [major-data-master] 포함 확인

# 2. audit
node scripts/skill-cache/audit-major-via-api.cjs <slug>

# 3. prod 렌더 게이트 (M0 각주 렌더 사고 후속 — 결정적 검사, 필수)
node scripts/major-render-gate.cjs <slug>
# → PASS 조건: 본문 각주 sup ≥1 + raw "[N]" 텍스트 잔존 0 + 패널 [필드명] prefix 0 + 필드 그룹 헤더 존재

# 4. prod 본문 키워드 확인 (careerwiki.org 도메인 직접 — preview X, node fetch 권장)
curl -s "https://careerwiki.org/major/<slug>" | grep -o "본문 키워드"
```

완료 조건: 마커 rev 실존 + audit WARN 0 / FAIL 0 + prod 200 + **render-gate PASS** + 본문 키워드 매칭 + **보호영역 diff 0** (Phase 0 스냅샷 대비 chartData 등 미변경). 통과 즉시 다음 전공 (배치 모드) — 전공당 검증 1라운드 엄수 (~40 tool-call 목표).

### Phase 7 — REPORT

전공당 1줄: `slug | rev_id | distinct_url | totalE(정확 수치) | audit_status | 마커OK`
- totalE는 **실측 정확 숫자** — 부등호(`≥12`) 표기 = 미완료 간주.
- 재POST 발생 시 **모든 rev id 기재** (최종 rev만 기재 금지).
- 배치 마지막: `MAJORS DONE: N/N ok` (미완 시 `MAJORS: M/N ok, 미완=<slug+사유>`).

---

## DONE / RETRY 포맷

```
DONE: <slug> rev=N mode=enhance|cleanup audit=CLEAN distinct=N totalE=N
fields_modified: whatStudy, howPrepare, jobProspect, youtubeLinks, ...
protected_diff: 0 (chartData/universities/... 미변경 확인)
WebFetch=R (≥ 신규 URL 수), no-self-validation=true
```

```
RETRY: <slug> root cause: <어떤 룰 / 어느 필드 / 시도한 fix / 실패 이유>
attempted: <시도 내역 — URL pool 발굴 목록 + 실패 사유 포함>
blocker: <WebFetch 차단 / pool 고갈(10 site 시도 후) / 사용자 결정 필요 등>
next: <Phase 1 재시작 / skip + 검증세션 위탁 / STOP + 보고 중 택일>
```

> 🚫 **LLM 자가 "CLEAN"/"DONE" 라벨 1줄 통과 절대 금지.** `audit-major-via-api.cjs` exit 0 + validate PASS + DB 마커 실측만 진리.

---

## Fix 패턴 (CLEANUP 모드 핵심 — job reference/fix-patterns.md 압축)

| audit flag | 영역 | fix 패턴 |
|---|---|---|
| rootURL | 산문 _sources | ① deep page 발굴 (WebFetch로 fact cover 확인) → url 교체. ② 실패 시 본문 일반화 → ③ fact 제거 → ④ 인정+pending 기록 (4단계 fallback) |
| originDomain | _sources | careernet/work24 계열·careerwiki.org → 즉시 교체 (fallback 없음 — 무조건 제거·대체) |
| brokenRef ([N] > _sources 길이) | 산문 본문 | 본문 [N] 재부여 (1..N 단조) 또는 누락 출처 보충 |
| orphanSources (등록 + 본문 [N] 0) | _sources | 본문에 인용 가능 fact 있으면 [N] 추가 (sentence 분리), 없으면 해당 fieldKey `{delete:true}` |
| sourcesWithoutMarkers | 산문 | 위와 동일 — 본문 [N] 정합화 우선 |
| bodyWithoutSources (본문 충실 + _sources 0) | 산문 | 출처 발굴 + [N] 각주 등록 (본문 임의 삭제 금지) |
| markerCluster ([1][2][3] 연속) | 산문 | sentence 분리 후 마커 1개씩 재배치 |
| urlDead (404/410/NXDOMAIN) | _sources | 즉시 교체 (룰 A). 000/403/timeout은 재검 후 판단 |
| urlUnverified (검색/_csrf/로그인게이트) | _sources | deep page로 교체 (R67 패턴 — indeed `/jobs?q=`·nsis `_csrf` 류) |
| mojibake | 본문 | 파일 기반 재POST로 정정 |
| dup ([N] 한 필드 2회+) | 산문 | 중복 마커 제거 (렌더도 첫 것만 유지하나 데이터 정합 우선) |

fix 후 재POST는 최대 2회 — 그래도 FAIL이면 STOP + 보고.

---

## Safety Rules (hardcoded — job 32룰 중 전공 유효분 압축 + 전공 신설)

1. **WebFetch 강제** — 신규 URL 등록 전 tool_use ≥ 1회/URL. tool_uses < 신규 URL 수 → 작업 무효.
2. **URL 생존 일괄 확인** (룰 A) — POST 전 신규 URL 전부 node fetch (브라우저 UA) 1회 호출. 404/410/NXDOMAIN 교체 의무.
3. **보호영역 절대 미접촉** — chartData/employmentRate/salaryAfterGraduation/universities/recruitmentStatus/relatedJobs/relatedMajors/sources/sourceIds/aptitude/property/careerAct/relateSubject/mainSubject(단수). POST 후 diff 0 확인.
4. 🔴 **trivia 전송 절대 금지** (전공 신설) — 서버가 jobProspect 삭제. `fields.trivia`/`sources["trivia"]` 어떤 형태로도 X.
5. **summary sources 등록 금지** — careernet canonical. summary 본문은 보강만 (전면 재작성 X, 60~150자 권장 존중 — 폭주 금지).
6. **`_sources[].text` 한글 제목 필수** — 서버 `text||url` silent fallback 있음. "기관명 — 페이지 제목" 형식, 한글 5자+, `text===url`/`http` 시작 금지.
7. **양방향 정합** — _sources 등록 fieldKey ↔ 본문 [N] 1:1. orphan/brokenRef/dup 0. 한 sentence 1 마커 max.
8. **전공 환각 게이트** (전공 신설) — 대학별 상이 fact는 "일반적 경향" 서술. 특정 대학 fact는 해당 .ac.kr deep 출처 필수.
9. **필드 7000자 한도** (전공 신설) — 서버 400 reject. 산문 필드 300~1500자 권장.
10. **기존 콘텐츠 보존** — API 원문(summary·mainSubjects·enterField·licenses) 삭제·축약 금지, 보강만. array 타입 유지. 항목 수 감소 금지.
11. **minimal patch 금지** — 출처만 추가/본문 미작성 X. 산문 3필드 ≥300자 + 각주 의무 (풀 사이클 100%).
12. **무언 스킵 금지** — youtubeLinks 빈값이면 `_youtubeSearchNote` 의무. 필드 skip 시 changeSummary에 사유 명시.
13. **changeSummary top-level** — fields 중첩 시 마커 미생성 → KPI 탈락 (R39).
14. **파일 기반 POST만** — 인라인 한글 curl 금지 (mojibake hook). Windows curl 한글 = CP949 사고.
15. **PowerShell 절대 금지** — Bash만 (powershell-block hook).
16. **자작 bulk 스크립트 금지** — cycle-script-block hook. 임시 산출물은 `_tmp_*` prefix + `scripts/skill-cache/` 하위.
17. **cleanup rm 와일드카드 금지** — `git clean -fdn` dry-run 또는 명시 파일명만. 종료 시 `git status -s`로 D 라인 0 확인.
18. **배치 모드: 할당 명단 외 전공 접근 절대 X** — NULL 풀 자동 다음 SELECT 금지. 명단 끝 = 즉시 종료.
19. **subagent fan-out 금지** — 세션 내 직렬 처리.
20. **AskUser 절대 금지** — 막히면 텍스트 보고 + skip + 다음 전공 (배치 전체 abort 금지).
21. **wrangler `--json` flag 금지** — plain stdout regex parse (Windows wrangler 호환).
22. **사고 발견 시 즉시 STOP** — retry 2회 후도 FAIL이면 STOP + 보고. 자가 "DONE" 라벨로 통과 금지.

---

## ⚠️ M0 파일럿 확인 항목 (렌더 실측 caveat — 확정 전 잠정)

major edit API는 **한 번도 실사용된 적 없다** (607 전공 UCJ 전원 NULL). M0 파일럿 (5전공)에서 아래를 실측 PASS해야 정식 M1~ 진입 (설계서 §7):

1. POST → readback → merged 반영 → prod 렌더 전 구간 first-blood
2. **`howPrepare` 렌더 확인** — 2026-07-02 코드 실측에서 `unifiedMajorDetail.ts` 내 howPrepare 렌더 라인 미발견 (설계서 §0 표와 불일치 가능). M0에서 prod 육안 확인 → 미렌더 확정 시 필드 목록 조정 (콘텐츠 낭비 방지)
3. **각주 [N] 실렌더** — `__SOURCE_FIELD_MAP__`에 `howPrepare`·`jobProspect` fieldKey 미등록 (whatStudy는 등록됨) → 헤딩 각주 배지 부착 여부 확인. 미부착이어도 _sources 등록 + 본문 [N] 정합은 의무 (데이터 우선, 렌더는 코드 후속)
4. `jobProspect` bullet 분리 렌더 품질 (문장 블록 `\n` 작성 방식 검증)
5. 마커 rev 생성 + KPI 쿼리 +5 정확 일치 (아래 KPI)
6. 보호영역 diff 0
7. 게이트 수치 (totalE 12 / distinct 8) 현실성 → 확정 (조정 시 설계서 + 본 스킬 + 템플릿 동시 갱신)

---

## KPI (단일 진실 — 설계서 §1)

- 마커: `[major-data-master]` (changeSummary top-level)
- KPI = latest content rev (`NOT LIKE '%[sidebar-fill]%'`)가 `[major-data-master]` 마커 + `user_contributed_json IS NOT NULL`인 DISTINCT entity 수 (entity_type='major')
- 매 cycle 예상 = 직전 + 25 (M0은 +5). **1이라도 어긋나면 완료 선언 금지.**
- helper: `node scripts/major-cycle-helper.cjs --status` (DB 진리값). 사용자 보고는 KPI 쿼리 하나만.

---

## Examples

### Example 1 — 신규 enhance (마커 미보유 — 표준 케이스)

```
입력: /major-data-master 컴퓨터공학과
판정: marker_count=0 + is_active=1 → ENHANCE 모드
Phase 0: 진단 (whatStudy="" / howPrepare="" / jobProspect="" / mainSubjects 12항목 존재 / _sources 없음) + 보호영역 스냅샷
Phase 1: 발굴 — 서울대·KAIST·부산대 컴퓨터공학 학과 페이지 deep (.ac.kr) + 한국정보과학회 + SW중심대학협의회 + 고용 미디어 deep. WebFetch 10+ site
Phase 2: whatStudy 450자(자료구조·운영체제·네트워크 일반 경향 서술)[1][2] / howPrepare 380자(수학·코딩 기초, "대학에 따라 다르나")[3][4] / jobProspect 문장블록 4개[5][6] / youtubeLinks 2개 oembed verify
Phase 3: payload.json 조립 (파일 분할 → node -e). summary·trivia·보호영역 키 없음 확인
Phase 4: URL 9개 일괄 생존 확인 → validate-major-edit PASS (totalE=13, distinct=9)
Phase 5: POST → revisionId=N
Phase 6: 마커 rev 실측 + audit CLEAN + prod fetch 키워드 매칭 + 보호영역 diff 0
Phase 7: 컴퓨터공학과 | rev=N | 9 | 13 | CLEAN | 마커OK
```

### Example 2 — cleanup (rootURL 교체)

```
입력: /major-data-master 간호학과 (marker_count=1 + audit FAIL "rootURL(1)")
Phase 1: whatStudy _sources에 대학 메인 루트 URL 1건
Phase 2: 해당 대학 간호학과 교육과정 deep page WebFetch → 본문 fact cover 확인 → url 교체
Phase 3~5: minimal payload { sources: { whatStudy: [...url만 교체] }, changeSummary: "[major-data-master] cleanup — rootURL=1→0" } → validate → POST
Phase 6~7: audit CLEAN → DONE
```

### Example 3 — 환각 게이트 발동 (특정 대학 fact cover 실패)

```
Phase 2 작성 중: "○○대는 3학년부터 AI 트랙 운영" — 해당 대학 .ac.kr에서 트랙 페이지 못 찾음
→ 룰 8: fact 일반화 ("일부 대학은 고학년에 AI 세부 트랙을 운영한다") 또는 제거. 특정 대학명 잔존 + 미cover 출처 = validate FAIL
```

---

## See Also

- `data/cycle/major_cycle_design_v1.md` — 설계 진리 (§2 필드·보호영역 / §3 출처 정책 / §5 게이트 / §7 M0 파일럿)
- `data/cycle/_major_dispatch_template_v1.md` — 배치 spawn STRICT 템플릿 (dispatcher용)
- `scripts/validate-major-edit.cjs` — POST 전 결정적 validate (빌드 B2)
- `scripts/skill-cache/audit-major-via-api.cjs` — POST 후 결정적 audit (빌드 B3)
- `scripts/major-verify-cycle.cjs` — cycle 전수 검증 (빌드 B4)
- `scripts/major-cycle-helper.cjs` — `--status` / `--cycle=N` / `--resume=N` (빌드 B5)
- `src/routes/major-editor.ts` — 편집 API 실서버 동작 (trivia 함정·text fallback·7000자 한도 근거)
- `.claude/skills/job-data-master/SKILL.md` — 원본 스킬 (직업 전용 — 본 스킬에서 호출 금지)
