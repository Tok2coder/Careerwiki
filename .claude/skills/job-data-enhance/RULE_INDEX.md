# RULE_INDEX.md — job-data-enhance 규칙 위치 맵

각 규칙의 **정규(canonical) 위치**와 반복 참조 위치를 한눈에 보여주는 인덱스.
규칙 충돌 시 **정규 위치가 우선**한다.

업데이트: 2026-04-24 (문체 규칙 추가)

---

## 범례

| 기호 | 의미 |
|------|------|
| ✅ 정규 | 해당 규칙의 단일 권위 소스 |
| 📎 참조 | 정규 위치를 가리키는 포인터 또는 요약 언급 |
| 🔒 코드 | 스크립트(validate/audit)에서 자동 검증됨 |

---

## 0. 진단 정확도 + 작업 모드

### 0-MODE. 부분 보강 모드 (`--field-only=<csv>`)

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 0-MODE (L146) | ✅ 정규 | — |

`[job-data-enhance]` 마커 보유 직업에 한해 단일/일부 필드만 보강.
Phase 0 진단·Phase 1 다른 필드·Phase 3.6 careerTree 생성 SKIP.
Phase 1 해당 필드 + Phase 2 검증 + Phase 3 저장 + Phase 5 수선 실행.

마커 미보유 직업은 **풀 사이클 강제** (Phase 0~5 전체).

토큰 효율 ~5x (50K → 10K 추정). Preservation Contract + START/END_TRACKING 동일 적용.

### 0-A. `merged_profile_json` 강제 (UCJ 단독 진단 금지)

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 0-DIAG (L146) | ✅ 정규 | — |
| 메모리 — feedback_uses_merged_profile_json | 📎 참조 | → 정규 위치 |

진단·필드 누락 검사·권장치 미달 분석은 **항상 `merged_profile_json` 기준**.
`user_contributed_json` 단독 진단은 api_data 측 보유 필드를 false positive로 분류 (보건교사·재활의학과·조산사·공예가·게임시나리오작가 등 8회+ 사고 발생). 2026-04-28 도입.

`json_type` + `json_array_length` 사용. 권장 임계치(sj≥3/sm≥2/sc≥2/so≥3/ht 4~8/yt≥2). URL null 검사 별도 표기.

---

## 1. 필드 타입 규칙

### 1-A. `way` — 반드시 string (배열 금지)

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — ⚡핵심 기술 규칙 표 (L39) | ✅ 정규 | — |
| SKILL.md — Phase 1 필드 보완 표 (L299) | 📎 참조 | → 핵심 기술 규칙 표 |
| SKILL.md — Phase 3-A 검증 스크립트 (L789) | 📎 참조 | → 핵심 기술 규칙 표 |
| SKILL.md — 최종 체크리스트 (L1316) | 📎 참조 | → 핵심 기술 규칙 표 |
| validate-job-edit.cjs — Rule 2 (`way` 타입 검사) | 🔒 코드 | — |

### 1-B. `detailReady` 배열 항목 — 반드시 plain string (객체 금지)

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — ⚡핵심 기술 규칙 표 (L40) | ✅ 정규 | — |
| SKILL.md — Phase 1 필드 보완 표 (L300) | 📎 참조 | → 핵심 기술 규칙 표 |
| SKILL.md — 최종 체크리스트 (L1318) | 📎 참조 | → 핵심 기술 규칙 표 |
| validate-job-edit.cjs — [recruit-객체] 규칙 | 🔒 코드 | — |

### 1-C. `detailWlb.wlb` / `.social` 등급 — 띄어쓰기 포함 5등급 중 하나

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 1 필드 보완 표 (L304) | ✅ 정규 | — |
| SKILL.md — Phase 5 Step 0 자동 교정 (L1145) | 📎 참조 | → Phase 1 |
| SKILL.md — 최종 체크리스트 (L1317) | 📎 참조 | → Phase 1 |
| validate-job-edit.cjs — [wlb-등급] 검사 | 🔒 코드 | — |

---

## 2. sources 전송 규칙

### 2-A. fields + sources 반드시 함께 전송

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 3-B 편집 API (L804) | ✅ 정규 | — |
| SKILL.md — 최종 체크리스트 (L1319) | 📎 참조 | → Phase 3-B |

### 2-B. 인라인 URL·도메인 표기 금지

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — ⚡핵심 기술 규칙 표 (L41) | ✅ 정규 | — |
| SKILL.md — 출처 수집 규칙 (L569) | 📎 참조 | → 핵심 기술 규칙 표 |
| validate-job-edit.cjs — [인라인도메인] 규칙 | 🔒 코드 | — |

### 2-C. 검색결과 페이지 URL 금지

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — ⚡핵심 기술 규칙 표 (L42) | ✅ 정규 | — |
| SKILL.md — 출처 URL 유효성 규칙 (L586) | 📎 참조 | → 핵심 기술 규칙 표 |

---

## 3. overviewSalary 읽기 전용 규칙 (⚠️ 가장 많이 반복됨)

**규칙**: `overviewSalary` 전체(`sal`/`wage`/`wageSource`) — 스킬에서 절대 수정 금지.
draft에 포함하면 validate FAIL.

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — 필드별 판단 원칙 (L74) | ✅ 정규 | — |
| SKILL.md — Phase 0 보존 체크리스트 (L90, L153, L179) | 📎 참조 | → 필드별 판단 원칙 |
| SKILL.md — Phase 1 보강 가능 필드 섹션 (L308) | 📎 참조 | → 필드별 판단 원칙 |
| SKILL.md — Phase 2 추가 규칙 (L633) | 📎 참조 | → 필드별 판단 원칙 |
| SKILL.md — Phase 5-3 수선 저장 (L1248) | 📎 참조 | → 필드별 판단 원칙 |
| SKILL.md — 최종 체크리스트 (L1320) | 📎 참조 | → 필드별 판단 원칙 |
| validate-job-edit.cjs — [sal-수정금지] 규칙 | 🔒 코드 | — |

> **주석**: overviewSalary 규칙이 6+ 곳에 반복됨 — L1 dedup 작업 대상 1순위.
> Phase 1·2·5·체크리스트의 반복 언급은 `→ 필드별 판단 원칙 참조` 포인터로 교체 예정.

---

## 4. 각주 규칙

### 4-A. 마침표 뒤에 [N] (`합니다.[1]` ✅ / `합니다[1].` ❌)

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 1 주석 위치 규칙 (L417) | ✅ 정규 | — |
| SKILL.md — Phase 2 Gate 1 체크리스트 (L689) | 📎 참조 | → Phase 1 |
| SKILL.md — 최종 체크리스트 (L1311) | 📎 참조 | → Phase 1 |
| validate-job-edit.cjs — [각주-위치] 규칙 | 🔒 코드 | — |

### 4-B. 같은 [N] 한 필드에 1회만 사용

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 1 주석 위치 규칙 (L488) | ✅ 정규 | — |
| SKILL.md — Phase 2 Gate 1 JS 함수 (L675) | 📎 참조 | → Phase 1 |
| SKILL.md — Phase 2 Gate 1 체크리스트 (L685) | 📎 참조 | → Phase 1 |
| validate-job-edit.cjs — [각주중복] 규칙 | 🔒 코드 | — |

### 4-C. curriculum 각주 — 항목마다 개별 [N], 단조증가 필수

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 1 detailReady curriculum 각주 규칙 (M2 수정 후) | ✅ 정규 | — |
| validate-job-edit.cjs — [각주중복] + [OS-Orphan] 규칙 | 🔒 코드 | — |

### 4-D. `trivia` 각주 — 마지막 문장 끝에만 위치 (중간 위치 금지) — 룰 D (2026-04-17)

**규칙**: trivia는 string 타입이므로 [N]은 반드시 **마지막 문장 끝**에만 위치해야 한다.
마지막 `[N]` 뒤에 실질 텍스트(>5자)가 남아 있으면 FAIL.

- ✅ 올바름: `"문장A. 문장B. 문장C.[1]"`
- ❌ 잘못됨: `"문장A.[1] 문장B. 문장C."`
- ✅ 허용(다중): `"문장A.[1] 문장B.[2] 문장C.[3]"` — 마지막 [3] 뒤 텍스트 없음

**인시던트**: 임상심리사(2026-04-17) — [1]이 첫 문장 뒤, 뒤 2문장 무출처.
**root cause**: `checkTrailingSentence()`가 WARN만 발생 → 스킬이 무시.

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/_shared/detect-patterns.cjs — `detectMidFootnote()` | ✅ 정규 (코드) | |
| scripts/validate-job-edit.cjs — `[trivia-각주중간]` | 🔒 코드 | **FAIL** |
| scripts/full-quality-audit.cjs — `[Gate5/trivia-각주중간]` | 🔒 코드 | **FAIL** |
| scripts/selfcheck/rule-regression-tests.cjs — 룰 D | 🔒 코드 | FAIL×2 + PASS×2 |
| SKILL.md — Phase 2 trivia 섹션 | 📎 참조 | → 이 규칙 |

---

## 5. sidebarCerts/Majors/Orgs 규칙

### 5-A. sidebarCerts 항목에 [N] 마커 금지

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — ⚡핵심 기술 규칙 표 (L43) | ✅ 정규 | — |
| SKILL.md — Phase 0 사이드바 현황 점검 (L276) | 📎 참조 | → 핵심 기술 규칙 표 |
| SKILL.md — Phase 1 필드별 처리 (L379) | 📎 참조 | → 핵심 기술 규칙 표 |
| validate-job-edit.cjs — [sidebarCerts] [N] 마커 검사 | 🔒 코드 | — |

### 5-B. sidebarCerts 시험 키워드 금지

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 1 sidebarCerts 규칙 | ✅ 정규 | — |
| validate-job-edit.cjs — [자격증] 시험 키워드 검사 | 🔒 코드 | — |

### 5-C. DB 실존 확인 (sidebarJobs, sidebarMajors)

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 1 sidebarJobs/Majors 필드 처리 (L378) | ✅ 정규 | SQL 쿼리 포함 |
| SKILL.md — Self-Report 17필드 체크리스트 (L765) | 📎 참조 | → Phase 1 |
| researcher-agent-prompt.md — 필드 [11][12] | 📎 참조 | → Phase 1 |

---

## 6. YouTube / careerTree 탐색 증거 규칙

### 6-A. `_youtubeSearchNote` — youtubeLinks=[] 시 필수

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — ⚡핵심 기술 규칙 표 (L57) | ✅ 정규 | — |
| SKILL.md — Phase 1 youtubeLinks 섹션 (L385) | 📎 참조 | → 핵심 기술 규칙 표 |
| SKILL.md — Self-Report 17필드 (L769) | 📎 참조 | → 핵심 기술 규칙 표 |
| researcher-agent-prompt.md — 필드 [16] | 📎 참조 | → 핵심 기술 규칙 표 |
| validate-job-edit.cjs — Rule 9b [youtube-증거없음] | 🔒 코드 | — |

### 6-B. `_careerTreeNote` — careerTree=null 시 필수

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — ⚡핵심 기술 규칙 표 (L58) | ✅ 정규 | — |
| SKILL.md — Phase 3.6 커리어트리 (L989) | 📎 참조 | → 핵심 기술 규칙 표 |
| SKILL.md — Self-Report 17필드 (L770) | 📎 참조 | → 핵심 기술 규칙 표 |
| researcher-agent-prompt.md — 필드 [17] | 📎 참조 | → 핵심 기술 규칙 표 |
| validate-job-edit.cjs — Rule 9c [careerTree-증거없음] | 🔒 코드 | — |

### 6-C. careerTree — 역대 대통령 절대 금지

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 3.6 인물 선정 기준 (H3 수정 후) | ✅ 정규 | 13명 명단 포함 |
| validate-job-edit.cjs — FORBIDDEN_PRESIDENTS + [careerTree-대통령금지] | 🔒 코드 | — |

---

## 7. 전망(prospect) 보존 규칙

### 7-A. 전망 방향 변경 금지

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 1 prospect 필드 원문 보존 규칙 (L345) | ✅ 정규 | — |
| SKILL.md — Phase 0 보존 계약 (L237) | 📎 참조 | → Phase 1 |
| SKILL.md — Phase 3.5 Save Self-check (L891) | 📎 참조 | → Phase 1 |

---

## 8. 출처 합성 금지

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — 출처·사실성 철칙 (L22, L29) | ✅ 정규 | — |
| SKILL.md — Phase 1 기존 데이터 수정 금지 (L341) | 📎 참조 | → 출처·사실성 철칙 |
| SKILL.md — Phase 2 Gate 0 무출처 합성 (L666) | 📎 참조 | → 출처·사실성 철칙 |

---

## 9. 배열 항목 수 보존 규칙

| 위치 | 유형 | 참조 |
|------|------|------|
| SKILL.md — Phase 0 배열 필드 보강 원칙 (L232) | ✅ 정규 | — |
| SKILL.md — Phase 3.5 Save Self-check 배열 확인 (L878) | 📎 참조 | → Phase 0 |
| SKILL.md — 최종 체크리스트 (L1329) | 📎 참조 | → Phase 0 |

---

## 10. 출처 병합 탐지 — 두 규칙으로 분리 (2026-04-16)

두 가지 위반 유형이 서로 다른 함수·심각도로 처리됩니다.

### 10-A. `[출처URL복수]` / `[Gate5/URL복수]` — text 내 복수 URL (FAIL)

source text에 `http://` 또는 `https://`가 2개 이상 포함된 경우. 구조적 위반이므로 즉시 FAIL.

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/_shared/detect-patterns.cjs — `detectMultipleUrlsInSourceText()` | ✅ 정규 (코드) | URL 2개+ 패턴 탐지 |
| scripts/validate-job-edit.cjs — `[출처URL복수]` | 🔒 코드 | **FAIL** (errors 배열) |
| scripts/full-quality-audit.cjs — `[Gate5/URL복수]` | 🔒 코드 | **FAIL** |

### 10-B. `[출처라벨병합]` / `[Gate5/라벨병합]` — 라벨 기관 병합 (INFO/WARN)

"기관A 및 기관B" 라벨 패턴. URL이 모든 언급 기관을 커버하는지는 사람 판단 영역 → FAIL 아님.

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/_shared/detect-patterns.cjs — `detectMergedOrgLabel()` | ✅ 정규 (코드) | FP_SUFFIXES + ORG_NAME_PAT 필터 포함 |
| scripts/validate-job-edit.cjs — `[출처라벨병합]` | 🔒 코드 | WARN (warnings 배열) |
| scripts/full-quality-audit.cjs — `[Gate5/라벨병합]` | 🔒 코드 | WARN |

> **분리 근거**: 라벨에 여러 기관명이 있어도 URL이 그 기관 전부를 커버하는 경우(복합 기관명 등)는
> 정상이며 자동 FAIL이 FP가 됨. text에 URL을 직접 삽입하는 것은 구조적 문제이므로 항상 FAIL.

---

## 11. 잘린 문장 탐지 (TRUNCATED_PATTERNS)

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/_shared/detect-patterns.cjs — TRUNCATED_PATTERNS | ✅ 정규 (코드) | 17개 패턴 |
| scripts/validate-job-edit.cjs | 🔒 코드 | 공유 모듈 사용 |
| scripts/full-quality-audit.cjs | 🔒 코드 | 공유 모듈 사용 |

---

## 12. validate-job-edit.cjs 전체 규칙 목록

| 규칙 ID | 설명 | 심각도 |
|---------|------|--------|
| [Mojibake] | fields/sources 내 깨진 유니코드 문자 탐지 | ERROR |
| [필드] way 짧음 | way < 100자 | ERROR |
| [필드] way 없음 | way 누락 | WARN |
| [curriculum-출처누락] | detailReady 서브 필드에 내용 있으나 sources 없음 | ERROR |
| [OS-Orphan] | sources 있으나 배열 항목에 [N] 마커 없음 | ERROR |
| [각주중복] | 같은 [N]이 한 배열 필드에 2회+ | ERROR |
| [recruit-객체] | recruit에 {text,url} 객체 포함 | ERROR |
| [인라인도메인] | 텍스트에 (도메인) 패턴 | ERROR |
| [detailReady.researchList] | CareerNet 원본 필드 수정 | ERROR |
| [detailReady.certificate] | 본문 추천 자격증 추가/수정 | ERROR |
| [사이드바] sidebarJobs 수량 | > 15개 | ERROR / > 12개 WARN |
| [자격증] 시험 키워드 | "시험", "TOEIC" 등 sidebarCerts | ERROR |
| [sidebarCerts] [N] 마커 | 자격증명에 각주 마커 포함 | WARN |
| [sidebarMajors] [N] 마커 | 전공명에 각주 마커 포함 | WARN |
| [sidebarOrgs] [N] 마커 | 기관명에 각주 마커 포함 | WARN |
| [sal-수정금지] | overviewSalary 필드 포함됨 | ERROR |
| [way-배열] | way가 배열 타입 | ERROR |
| [각주-위치] | [N]이 마침표 앞에 위치 | ERROR |
| [각주-순서] | [N]이 1부터 순차 증가 아님 | ERROR |
| [sources-길이] | sources 배열 길이 < 최대 [N] | ERROR |
| [OS-출처고아] | sources에 [N] 있으나 본문에 미사용 | WARN |
| [careerTree-자기강조] | careerTree job_slug가 마지막 스테이지에 설정 | ERROR |
| [careerTree-대통령금지] | 역대 대통령 13인 careerTree에 포함 | ERROR |
| [careerTree-증거없음] | careerTree=null이나 _careerTreeNote 미제출 | ERROR |
| [youtube-증거없음] | youtubeLinks=[]이나 _youtubeSearchNote 미제출 | ERROR |
| [merged-sources] | 출처 병합 패턴 탐지 (A 및 B 형태) | WARN |
| [잘린문장] | 서술 필드 문장 잘림 탐지 | WARN |
| [wlb-등급] | 유효하지 않은 wlb/social 등급 값 | ERROR |

---

## 13. full-quality-audit.cjs 게이트 목록

| 게이트 | 내용 | 심각도 |
|--------|------|--------|
| Gate0 | 무출처 합성 문장 탐지 | FAIL |
| Gate1 | 각주 순서·중복·sources 길이 일치 | FAIL |
| Gate2 | 잘린 문장 탐지 (TRUNCATED_PATTERNS) | FAIL |
| Gate3 | YouTube oembed 검증 + 관련성 | FAIL |
| Gate4 | sources 등장 순서 일치 | FAIL |
| Gate5 | 필드 완성도 + 타입 검증 + Mojibake 탐지 | FAIL/WARN |

---

## 13-A. Mojibake (인코딩 깨짐) 탐지 — 2026-04-16 추가

### 원인

Windows 환경에서 `curl -d`로 한글 텍스트를 전송할 때 CP949 인코딩 오류가 발생하면,
한글이 아랍·키릴·라틴확장·아르메니아 등 범위의 유니코드 문자로 깨진 채 저장된다.
(**사고 사례**: 준법감시인 `overviewAbilities.technKnow` 필드 전체 깨짐, rev 11598/11599)

### 탐지 로직

**조건 A**: 비ASCII 문자 8개 이상 + 한글 전혀 없음 + mojibake 범위(아랍·키릴 등) 비율 ≥ 40%  
**조건 B**: 비ASCII 10개 이상 + 한글 비율 < 10% + mojibake 범위 ≥ 30%

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/_shared/detect-patterns.cjs — `detectMojibake()` | ✅ 정규 (코드) | MOJI_RANGES: 아랍·시리아·라틴확장·키릴·아르메니아 |
| scripts/validate-job-edit.cjs — `[Mojibake]` (Rule 0) | 🔒 코드 | **FAIL** (Phase 3-A 차단) |
| scripts/full-quality-audit.cjs — `[Gate5/Mojibake]` | 🔒 코드 | **FAIL** |

### 검사 범위

- `validate`: `fields` 내 모든 문자열 + `sources[*][*].text` 모두 검사  
- `audit Gate5`: `overviewAbilities.technKnow`, `way`, `overviewProspect.main`, `detailWlb.*`, `trivia`, `summary` + `_sources[*][*].text`

### 방지 원칙

- **Windows curl -d 금지** — 한글이 포함된 JSON은 Node.js `fetch()`로만 전송  
- `node scripts/validate-job-edit.cjs <draft>` → PASS 확인 후에만 API 호출

---

---

## 13-B. UCJ detailReady 배열 항목별 [N] 필수 — 룰 A (2026-04-16 추가)

### 원인

오늘 기획관리자 작업에서 `detailReady.recruit[0]` 항목에 [N]이 없어 출처 없는 데이터가 저장됨.
배열 항목도 출처 의무 대상임에도 self-check가 배열 항목 단위 검사를 하지 않았음.

### 검사 로직

`user_contributed_json.detailReady.{curriculum, recruit, training}` 각 항목 문자열이 `/\[\d+\]/` 패턴을 포함하는지 검사.
`detailReady.researchList`는 CareerNet 원본 필드이므로 **제외**.

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/_shared/detect-patterns.cjs — `detectMissingFootnoteInArrayItems()` | ✅ 정규 (코드) | |
| scripts/validate-job-edit.cjs — `[UCJ각주항목누락]` | 🔒 코드 | **FAIL** (저장 차단) |
| scripts/full-quality-audit.cjs — `[Gate5/UCJ각주항목누락]` | 🔒 코드 | **FAIL** |
| scripts/selfcheck/rule-regression-tests.cjs | 🔒 코드 | 회귀 테스트 |

**소급 적용**: 신규 저장 시점부터 FAIL. 기존 DB 데이터는 그대로 유지 (재enhance 시 점진적 정리).

---

## 13-C. _youtubeSearchNote 탐색 깊이 강제 — 룰 B (2026-04-16 추가)

### 원인

기획관리자 유튜브 탐색 시 4개 탐색어만 사용했고, 재탐색 결과 3개 영상이 발견됨.
얕은 탐색으로 "없음"으로 잘못 결론 내리는 패턴 방지.

### 검사 로직

`youtubeLinks = []`이고 `_youtubeSearchNote`가 존재할 때:
- **(a)** 작은따옴표 쌍 `'...'` 탐색어 ≥6개, 또는
- **(b)** 4개 카테고리 중 ≥3개 커버: `현직자·인터뷰` / `직무·실무` / `강의·교육` / `진로·면접`

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/_shared/detect-patterns.cjs — `analyzeYoutubeSearchNote()` | ✅ 정규 (코드) | |
| scripts/validate-job-edit.cjs — `[YouTubeNote얕음]` | 🔒 코드 | **FAIL** |
| scripts/full-quality-audit.cjs — `[Gate5/YouTubeNote얕음]` | 🔒 코드 | **FAIL** |

**기존 데이터**: Gate5에서 FAIL 감지됨 — 8개 직업 위반 확인. 재enhance 시 정리.

---

## 13-D. _careerTreeNote 탐색 깊이 강제 — 룰 C (2026-04-16 추가)

### 원인

기획관리자 careerTree "없음"으로 결론 냈으나, 재탐색 시 정기선(HD현대 회장) 발견.
후보 탐색이 얕아 실제 적합 인물을 놓치는 패턴 방지.

### 검사 로직

`careerTree = null`일 때:
- **(a)** `이름(이유)` 패턴으로 후보 ≥5명 탐색됨, 또는
- **(b)** 5개 카테고리 중 ≥3개 커버: `재벌·대기업` / `컨설팅` / `공공·정부` / `학계·연구` / `스타트업·CxO`

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/_shared/detect-patterns.cjs — `analyzeCareerTreeNote()` | ✅ 정규 (코드) | |
| scripts/validate-job-edit.cjs — `[CareerTreeNote얕음]` | 🔒 코드 | **FAIL** |
| scripts/full-quality-audit.cjs — `[Gate5/CareerTreeNote얕음]` | 🔒 코드 | **FAIL** |

**기존 데이터**: 2개 직업 위반 확인 (준법감시인, 바이오화학제품연구기획자). 재enhance 시 정리.

---

## 13-E. trivia 각주 중간 배치 금지 — 룰 D (2026-04-17 추가)

### 원인

임상심리사 enhance 작업에서 `trivia` 필드의 `[1]`이 첫 번째 문장 뒤에 배치되고 이후 2문장이 이어지는 패턴이 저장됨. 전수 스캔 결과 873개 UCJ trivia 중 130개(15%)가 같은 패턴으로 위반.

### 검사 로직

`trivia` 문자열에서 **마지막 [N] 이후**에 한글·영문·숫자 등 실질 텍스트가 이어지면 위반.

- OK: `"첫문장. 둘째문장.[1]"` — 마지막 [N] 뒤 텍스트 없음
- OK: `"문장A.[1] 문장B.[2]"` — 각 문장이 다른 출처, 마지막 [2] 뒤 없음
- FAIL: `"첫문장.[1] 둘째문장."` — 마지막 [N] 뒤에 "둘째문장." 이어짐
- FAIL: `"문장A.[1] 문장B.[2] 문장C."` — 마지막 [2] 뒤에 "문장C." 이어짐

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/_shared/detect-patterns.cjs — `detectTriviaInlineFootnote()` | ✅ 정규 (코드) | |
| scripts/validate-job-edit.cjs — `[Trivia/각주중간배치]` | 🔒 코드 | **FAIL** (저장 차단) |
| scripts/full-quality-audit.cjs — `[Gate5/Trivia각주중간배치]` | 🔒 코드 | **FAIL** |
| scripts/selfcheck/rule-regression-tests.cjs — 룰 D fixture | 🔒 코드 | 회귀 테스트 (FAIL 2 + PASS 2) |

**소급 적용**: 전수 스캔 130건 발견 — 신규 저장부터 차단. 기존 데이터는 재enhance 시 점진적 정리.

---

## 문체 규칙 — 2026-04-24 신설

**원칙**: 모든 서술 필드는 **한다/이다체** (평서문 종결)로 작성한다.
경어체(합니다/입니다/됩니다/있습니다/없습니다/드립니다/됐습니다/였습니다/하였습니다 등) 사용 금지.

### 적용 대상 필드

`way`, `trivia`, `overviewProspect.main`, `detailWlb.wlbDetail`, `detailWlb.socialDetail`,
`overviewSalary.sal`, `detailReady.curriculum[]`, `detailReady.recruit[]`, `detailReady.training[]`,
`summary`, `overviewWork.main`, `overviewAbilities.technKnow`, `_careerTreeNote`, `_youtubeSearchNote`

### 예외 (원문 유지)

- `sources[]` 배열 항목의 `text`, `url` — 기관 공식 표현 그대로 유지
- `youtubeLinks[].title` — 영상 원제 그대로 유지
- 인용구 (`"..."` 또는 `『...』` 안 텍스트)
- 기관·단체 고유 슬로건·캐치프레이즈

### OK / NG 예시

| NG (경어체) | OK (한다체) |
|-------------|-------------|
| 국가시험에 합격해야 합니다.[1] | 국가시험에 합격해야 한다.[1] |
| 평균 연봉은 4,200만 원입니다.[1] | 평균 연봉은 4,200만 원이다.[1] |
| 3교대 근무가 일반적입니다.[1] | 3교대 근무가 일반적이다.[1] |
| 취업률이 낮은 편에 속합니다.[1] | 취업률이 낮은 편에 속한다.[1] |
| 대학원 진학이 도움이 됩니다.[1] | 대학원 진학이 도움이 된다.[1] |

### 코드 레벨 검증

| 위치 | 유형 | 참조 |
|------|------|------|
| scripts/full-quality-audit.cjs — `[경어체-WARN]` | 🔒 코드 | WARN (저장 차단 아님) |
| scripts/tone-normalize.cjs — dry-run/apply | 🔒 코드 | 전역 DB 스윕 유틸리티 |
| researcher-agent-prompt.md — Gate 2 완성형 판정 | 📎 참조 | WARN 조건 명시 |

---

## 유지보수 원칙

1. 규칙이 **정규 위치에서 변경**되면 → 코드(validate/audit)도 함께 업데이트.
2. 규칙이 **코드에서 변경**되면 → 정규 위치(SKILL.md) 텍스트도 함께 업데이트.
3. 📎 참조 위치는 포인터만 남기고 내용 반복 최소화 (L1 dedup 원칙).
4. 새 규칙 추가 시 → RULE_INDEX.md에 반드시 추가.
