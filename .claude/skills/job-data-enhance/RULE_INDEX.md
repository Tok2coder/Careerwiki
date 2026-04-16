# RULE_INDEX.md — job-data-enhance 규칙 위치 맵

각 규칙의 **정규(canonical) 위치**와 반복 참조 위치를 한눈에 보여주는 인덱스.
규칙 충돌 시 **정규 위치가 우선**한다.

업데이트: 2026-04-16 (Mojibake 탐지 규칙 추가)

---

## 범례

| 기호 | 의미 |
|------|------|
| ✅ 정규 | 해당 규칙의 단일 권위 소스 |
| 📎 참조 | 정규 위치를 가리키는 포인터 또는 요약 언급 |
| 🔒 코드 | 스크립트(validate/audit)에서 자동 검증됨 |

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

## 유지보수 원칙

1. 규칙이 **정규 위치에서 변경**되면 → 코드(validate/audit)도 함께 업데이트.
2. 규칙이 **코드에서 변경**되면 → 정규 위치(SKILL.md) 텍스트도 함께 업데이트.
3. 📎 참조 위치는 포인터만 남기고 내용 반복 최소화 (L1 dedup 원칙).
4. 새 규칙 추가 시 → RULE_INDEX.md에 반드시 추가.
