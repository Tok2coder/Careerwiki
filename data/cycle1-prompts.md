# Cycle 1 Prompts (20직업 — 5세션 × 4직업)

**Generated**: 2026-04-29T14:00:18.488Z
**Source**: data/master-list-50.json (47건 사고 풀)
**운영 룰**: 한 세션 최대 5직업, 한 세션은 동시 1직업 (single-job mode), 5세션 동시 운영
**기준**: 패턴 다양성 (rawURL only / brokenRef only / selfCiteOnly / mojibake / 다중 mix) + 처리 시간 균형 (각 세션 무거움 1-2 + 중간 1-2 + 가벼움 1)

## 세션별 분배 (5세션 × 4직업 = 20직업)

### 세션 1: 수의사보조원 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 입학사정관 | 17.0 | 17 | 17 | rawURL×17 | 무거움 |
| 2 | 사회단체활동가 | 8.0 | 3 | 0 | selfCiteOnly / listPage×3 / selfCite×3 | 중간 |
| 3 | 마케팅전문가 | 10.0 | 6 | 4 | brokenRef×6 / rawURL×4 / selfCite×2 | 무거움 |
| 4 | 번역가 | 8.0 | 3 | 2 | brokenRef×5 / rawURL×3 / selfCite×1 | 중간 |

### 세션 2: 만화가 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 보험계리사 | 10.0 | 28 | 27 | mojibake×1 / selfCite×1 | 무거움 |
| 2 | 집배원 | 5.0 | 3 | 3 | brokenRef×5 | 중간 |
| 3 | 전문의사 | 12.0 | 11 | 11 | brokenRef×1 / rawURL×11 | 무거움 |
| 4 | 직업상담사 | 9.0 | 3 | 2 | brokenRef×6 / rawURL×3 / selfCite×1 | 중간 |

### 세션 3: 사서 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 의료코디네이터 | 12.0 | 10 | 6 | brokenRef×8 / orphan×8 / dup×2 / selfCite×4 | 무거움 |
| 2 | 마취병리과의사 | 2.0 | 2 | 2 | brokenRef×2 / dup×2 | 가벼움 |
| 3 | 방송연출가 | 10.0 | 5 | 3 | brokenRef×5 / rawURL×5 / selfCite×2 | 무거움 |
| 4 | 화학공학기술자 | 9.0 | 3 | 2 | brokenRef×6 / rawURL×3 / selfCite×1 | 중간 |

### 세션 4: 경제학연구원 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 수상운송사무원 | 10.0 | 5 | 0 | selfCiteOnly / listPage×5 / selfCite×5 | 무거움 |
| 2 | 법원공무원 | 3.0 | 8 | 7 | listPage×1 / brokenRef×2 / dup×5 / selfCite×1 | 가벼움 |
| 3 | 사회학연구원 | 10.0 | 3 | 2 | brokenRef×7 / rawURL×3 / selfCite×1 | 무거움 |
| 4 | 서예가 | 10.0 | 5 | 4 | brokenRef×7 / rawURL×3 / selfCite×1 | 무거움 |

### 세션 5: 리포터 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 드라마작가 | 10.0 | 6 | 5 | brokenRef×6 / rawURL×4 / selfCite×1 | 무거움 |
| 2 | 네일아티스트 | 6.0 | 13 | 8 | rawURL×4 / orphan×4 / selfCite×5 | 중간 |
| 3 | 역사학연구원 | 10.0 | 5 | 3 | brokenRef×5 / rawURL×5 / selfCite×2 | 무거움 |
| 4 | 전화교환원 | 10.0 | 5 | 0 | selfCiteOnly / listPage×5 / selfCite×5 | 무거움 |

## 운영 가이드

- 각 세션이 직업 1개를 single-job 풀 사이클로 처리 → DONE/RETRY 보고
- 오케스트레이터가 DONE 받으면 같은 세션에 다음 직업 send_message
- cycle 1 (20건) 끝나고 잔여 27건 → cycle 2 (새 5세션 × 5직업 = 25건)
- 마지막 cycle 2 끝나면 master-list-50.json에서 잔여 2건은 별도 처리

## 🆕 Cycle 1 정책 변경 3가지 (이전 5세션 결과 반영)

1. **detailReady 항목별 [N] 마커 + _sources 등록 필수** — 이전 5세션 일관성 부족 발견
2. **외부 host minimum 3+ 권장** — 리포터 외부 2개 통과 사례 빈약 (5+ 이상적)
3. **careerTree 이번 사이클 대상 X** — 별도 사이클로 분리, 기존 유지

---

# 세션 1 (수의사보조원 worktree) — 4직업

> **dispatch 순서**: 4직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 1 — 직업 1/4: 입학사정관

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 입학사정관 (id=1765284146444414)
- URL: https://careerwiki.org/job/입학사정관
- 사고 패턴 (deep audit 2026-04-29): rawURL×17
  - rawURL 위치: overviewProspect.main#1, detailWlb.wlbDetail#2, detailWlb.socialDetail#3, trivia#4, overviewAbilities.technKnow#5, way#6 …
- audit 메트릭: totalUrls=17, externalHosts=17, uniqueHosts=6
- 핵심 작업: _sources.text가 raw URL 17건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765284146444414/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=입학사정관 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=입학사정관`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 입학사정관 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 입학사정관 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 1 — 직업 2/4: 사회단체활동가

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 사회단체활동가 (id=1765283321094381)
- URL: https://careerwiki.org/job/사회단체활동가
- 사고 패턴 (deep audit 2026-04-29): selfCiteOnly / listPage×3 / selfCite×3
  - listPage URL: overviewProspect.main: https://www.career.go.kr/cloud/w/job/list / trivia: https://www.career.go.kr/cloud/w/job/list / way: https://www.career.go.kr/cloud/w/job/list
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=3, externalHosts=0, uniqueHosts=1
- 핵심 작업: 외부 host 0개 — origin(career.go.kr/work.go.kr) 단독; 인덱스 URL 3건 (직업 specific URL로 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283321094381/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=사회단체활동가 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=사회단체활동가`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 사회단체활동가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 사회단체활동가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 1 — 직업 3/4: 마케팅전문가

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 마케팅전문가 (id=176528330314020)
- URL: https://careerwiki.org/job/마케팅전문가
- 사고 패턴 (deep audit 2026-04-29): brokenRef×6 / rawURL×4 / selfCite×2
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"trivia","idx":2},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#5, way#6
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=6, externalHosts=4, uniqueHosts=5
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 6건; _sources.text가 raw URL 4건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/176528330314020/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=마케팅전문가 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=마케팅전문가`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 마케팅전문가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 마케팅전문가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 1 — 직업 4/4: 번역가

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 번역가 (id=176528331355150)
- URL: https://careerwiki.org/job/번역가
- 사고 패턴 (deep audit 2026-04-29): brokenRef×5 / rawURL×3 / selfCite×1
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"way","idx":2},{"field":"way","idx":3},{"field":"way","idx":4}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=3, externalHosts=2, uniqueHosts=3
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 5건; _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/176528331355150/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=번역가 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=번역가`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 번역가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 번역가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

---

# 세션 2 (만화가 worktree) — 4직업

> **dispatch 순서**: 4직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 2 — 직업 1/4: 보험계리사

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 보험계리사 (id=1765284083754370)
- URL: https://careerwiki.org/job/보험계리사
- 사고 패턴 (deep audit 2026-04-29): mojibake×1 / selfCite×1
  - mojibake 위치: user_contributed_json (raw)
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=28, externalHosts=27, uniqueHosts=12
- 핵심 작업: 인코딩 깨짐 1건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765284083754370/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=보험계리사 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=보험계리사`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 보험계리사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 보험계리사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 2 — 직업 2/4: 집배원

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 집배원 (id=1765283493607565)
- URL: https://careerwiki.org/job/집배원
- 사고 패턴 (deep audit 2026-04-29): brokenRef×5
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"trivia","idx":2},{"field":"trivia","idx":3},{"field":"way","idx":2},{"field":"way","idx":3}]
- audit 메트릭: totalUrls=3, externalHosts=3, uniqueHosts=2
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 5건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283493607565/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=집배원 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=집배원`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 집배원 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 집배원 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 2 — 직업 3/4: 전문의사

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 전문의사 (id=1765283366442139)
- URL: https://careerwiki.org/job/전문의사
- 사고 패턴 (deep audit 2026-04-29): brokenRef×1 / rawURL×11
  - brokenRef: [{"field":"trivia","idx":4}]
  - rawURL 위치: overviewProspect.main#1, overviewProspect.main#2, overviewProspect.main#3, overviewProspect.main#4, trivia#5, trivia#6 …
- audit 메트릭: totalUrls=11, externalHosts=11, uniqueHosts=10
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 1건; _sources.text가 raw URL 11건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283366442139/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=전문의사 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=전문의사`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 전문의사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 전문의사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 2 — 직업 4/4: 직업상담사

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 직업상담사 (id=1765283460443102)
- URL: https://careerwiki.org/job/직업상담사
- 사고 패턴 (deep audit 2026-04-29): brokenRef×6 / rawURL×3 / selfCite×1
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"way","idx":2},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=3, externalHosts=2, uniqueHosts=3
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 6건; _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283460443102/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=직업상담사 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=직업상담사`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 직업상담사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 직업상담사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

---

# 세션 3 (사서 worktree) — 4직업

> **dispatch 순서**: 4직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 3 — 직업 1/4: 의료코디네이터

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 의료코디네이터 (id=1765283423024989)
- URL: https://careerwiki.org/job/의료코디네이터
- 사고 패턴 (deep audit 2026-04-29): brokenRef×8 / orphan×8 / dup×2 / selfCite×4
  - brokenRef: [{"field":"overviewProspect.main","idx":5},{"field":"overviewProspect.main","idx":6},{"field":"detailWlb.wlbDetail","idx":9},{"field":"detailWlb.wlbDetail","idx":10},{"field":"detailWlb.socialDetail","idx":11},{"field":"detailWlb.socialDetail","idx":12},{"field":"trivia","idx":7},{"field":"trivia","idx":8}]
  - orphanSrc: [{"field":"overviewProspect.main","idx":1},{"field":"overviewProspect.main","idx":2},{"field":"detailWlb.wlbDetail","idx":1},{"field":"detailWlb.wlbDetail","idx":2},{"field":"detailWlb.socialDetail","idx":1},{"field":"detailWlb.socialDetail","idx":2}] …
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=10, externalHosts=6, uniqueHosts=4
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 8건; _sources 등록만 본문 미사용 8건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283423024989/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=의료코디네이터 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=의료코디네이터`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 의료코디네이터 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 의료코디네이터 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 3 — 직업 2/4: 마취병리과의사

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 마취병리과의사 (id=1765283464572237)
- URL: https://careerwiki.org/job/마취병리과의사
- 사고 패턴 (deep audit 2026-04-29): brokenRef×2 / dup×2
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"way","idx":2}]
- audit 메트릭: totalUrls=2, externalHosts=2, uniqueHosts=2
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 2건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283464572237/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=마취병리과의사 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=마취병리과의사`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 마취병리과의사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 마취병리과의사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 3 — 직업 3/4: 방송연출가

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 방송연출가 (id=1765283311944704)
- URL: https://careerwiki.org/job/방송연출가
- 사고 패턴 (deep audit 2026-04-29): brokenRef×5 / rawURL×5 / selfCite×2
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, trivia#3, way#4, way#5
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=5, externalHosts=3, uniqueHosts=4
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 5건; _sources.text가 raw URL 5건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283311944704/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=방송연출가 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=방송연출가`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 방송연출가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 방송연출가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 3 — 직업 4/4: 화학공학기술자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 화학공학기술자 (id=1765283402753351)
- URL: https://careerwiki.org/job/화학공학기술자
- 사고 패턴 (deep audit 2026-04-29): brokenRef×6 / rawURL×3 / selfCite×1
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"way","idx":2},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=3, externalHosts=2, uniqueHosts=3
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 6건; _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283402753351/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=화학공학기술자 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=화학공학기술자`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 화학공학기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 화학공학기술자 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

---

# 세션 4 (경제학연구원 worktree) — 4직업

> **dispatch 순서**: 4직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 4 — 직업 1/4: 수상운송사무원

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 수상운송사무원 (id=176528342030072)
- URL: https://careerwiki.org/job/수상운송사무원
- 사고 패턴 (deep audit 2026-04-29): selfCiteOnly / listPage×5 / selfCite×5
  - listPage URL: overviewProspect.main: https://www.career.go.kr/cloud/w/job/list / detailWlb.wlbDetail: https://www.career.go.kr/cloud/w/job/list / detailWlb.socialDetail: https://www.career.go.kr/cloud/w/job/list
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=5, externalHosts=0, uniqueHosts=1
- 핵심 작업: 외부 host 0개 — origin(career.go.kr/work.go.kr) 단독; 인덱스 URL 5건 (직업 specific URL로 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/176528342030072/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=수상운송사무원 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=수상운송사무원`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 수상운송사무원 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 수상운송사무원 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 4 — 직업 2/4: 법원공무원

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 법원공무원 (id=1765283415778123)
- URL: https://careerwiki.org/job/법원공무원
- 사고 패턴 (deep audit 2026-04-29): listPage×1 / brokenRef×2 / dup×5 / selfCite×1
  - brokenRef: [{"field":"detailWlb.wlbDetail","idx":2},{"field":"detailWlb.socialDetail","idx":2}]
  - listPage URL: detailWlb.wlbDetail: https://www.career.go.kr/cloud/w/job/list
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=8, externalHosts=7, uniqueHosts=6
- 핵심 작업: 인덱스 URL 1건 (직업 specific URL로 교체); 본문 [N] vs _sources 길이 mismatch 2건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283415778123/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=법원공무원 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=법원공무원`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 법원공무원 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 법원공무원 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 4 — 직업 3/4: 사회학연구원

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 사회학연구원 (id=1765283321689634)
- URL: https://careerwiki.org/job/사회학연구원
- 사고 패턴 (deep audit 2026-04-29): brokenRef×7 / rawURL×3 / selfCite×1
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"trivia","idx":2},{"field":"way","idx":2},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=3, externalHosts=2, uniqueHosts=3
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 7건; _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283321689634/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=사회학연구원 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=사회학연구원`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 사회학연구원 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 사회학연구원 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 4 — 직업 4/4: 서예가

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 서예가 (id=1765283324729983)
- URL: https://careerwiki.org/job/서예가
- 사고 패턴 (deep audit 2026-04-29): brokenRef×7 / rawURL×3 / selfCite×1
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"trivia","idx":2},{"field":"way","idx":2},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#5
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=5, externalHosts=4, uniqueHosts=5
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 7건; _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283324729983/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=서예가 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=서예가`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 서예가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 서예가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

---

# 세션 5 (리포터 worktree) — 4직업

> **dispatch 순서**: 4직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 5 — 직업 1/4: 드라마작가

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 드라마작가 (id=1765283301376889)
- URL: https://careerwiki.org/job/드라마작가
- 사고 패턴 (deep audit 2026-04-29): brokenRef×6 / rawURL×4 / selfCite×1
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"way","idx":2},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, trivia#3, way#6
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=6, externalHosts=5, uniqueHosts=6
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 6건; _sources.text가 raw URL 4건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283301376889/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=드라마작가 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=드라마작가`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 드라마작가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 드라마작가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 5 — 직업 2/4: 네일아티스트

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 네일아티스트 (id=1765283295005846)
- URL: https://careerwiki.org/job/네일아티스트
- 사고 패턴 (deep audit 2026-04-29): rawURL×4 / orphan×4 / selfCite×5
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3, way#4
  - orphanSrc: [{"field":"overviewProspect.main","idx":1},{"field":"trivia","idx":1},{"field":"way","idx":1},{"field":"way","idx":2}]
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=13, externalHosts=8, uniqueHosts=4
- 핵심 작업: _sources.text가 raw URL 4건 (기관명 교체); _sources 등록만 본문 미사용 4건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283295005846/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=네일아티스트 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=네일아티스트`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 네일아티스트 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 네일아티스트 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 5 — 직업 3/4: 역사학연구원

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 역사학연구원 (id=17652833431652)
- URL: https://careerwiki.org/job/역사학연구원
- 사고 패턴 (deep audit 2026-04-29): brokenRef×5 / rawURL×5 / selfCite×2
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, trivia#3, way#4, way#5
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=5, externalHosts=3, uniqueHosts=3
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 5건; _sources.text가 raw URL 5건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/17652833431652/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=역사학연구원 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=역사학연구원`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 역사학연구원 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 역사학연구원 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

### 세션 5 — 직업 4/4: 전화교환원

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 전화교환원 (id=1765283368847566)
- URL: https://careerwiki.org/job/전화교환원
- 사고 패턴 (deep audit 2026-04-29): selfCiteOnly / listPage×5 / selfCite×5
  - listPage URL: overviewProspect.main: https://www.career.go.kr/cloud/w/job/list / detailWlb.wlbDetail: https://www.career.go.kr/cloud/w/job/list / detailWlb.socialDetail: https://www.career.go.kr/cloud/w/job/list
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=5, externalHosts=0, uniqueHosts=1
- 핵심 작업: 외부 host 0개 — origin(career.go.kr/work.go.kr) 단독; 인덱스 URL 5건 (직업 specific URL로 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283368847566/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=전화교환원 --apply`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=전화교환원`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 55a6199, 2026-04-29 originDomain 격상):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 있으면 즉시 FAIL** (이전 selfCiteOnly 정책 폐기). 의료코디네이터 wagework.go.kr 사고로 격상 (사용자 직접 발견)
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - `detailReady.curriculum` 각 항목 끝에 `[N]` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - `detailReady.recruit` 각 항목 끝에 `[N]` 부착
    - `detailReady.training` 각 항목 끝에 `[N]` 부착
    - 각 sub 필드의 `_sources["detailReady.curriculum"]` / `["detailReady.recruit"]` / `["detailReady.training"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - `externalHostCount ≥ 3` 권장 (가능하면 5+)
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨** — origin 자체 사용 금지

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 🆕 Phase 4-SRC: 출처 검증 강제 (2026-04-29 신설):

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함 (예: "출처 검증: 5/5 URL 200 OK + 키워드 매칭 PASS")

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
```
DONE: 전화교환원 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
```

**audit FAIL 시 (재작업 필요)**:
```
RETRY: 전화교환원 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
```

---
