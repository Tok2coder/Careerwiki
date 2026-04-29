# Cycle 2 Prompts (25직업 — 5세션 × 5직업)

**Generated**: 2026-04-29T17:28:40.649Z
**Source**: data/master-list-50.json (47건 사고 풀, cycle 1 처리 16건 제외 → 잔여 31건 중 25건)
**main HEAD**: 43a0f03 이상 (audit-sources-deep.cjs SyntaxError fix 반영)
**운영 룰**: 한 세션 5직업, 동시 1직업 (single-job mode), 5세션 동시

## 세션별 분배 (5세션 × 5직업 = 25직업)

### 세션 1: 수의사보조원 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 서예가 | 10.0 | 5 | 4 | brokenRef×7 / rawURL×3 / selfCite×1 | 무거움 |
| 2 | 직업상담사 | 9.0 | 3 | 2 | brokenRef×6 / rawURL×3 / selfCite×1 | 무거움 |
| 3 | 번역가 | 8.0 | 3 | 2 | brokenRef×5 / rawURL×3 / selfCite×1 | 중간 |
| 4 | 바리스타 | 4.0 | 3 | 2 | brokenRef×1 / rawURL×3 / selfCite×1 | 가벼움 |
| 5 | 영화시나리오작가 | 2.0 | 8 | 6 | brokenRef×2 / dup×4 / selfCite×2 | 가벼움 |

### 세션 2: 만화가 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 재료공학기술자 | 10.0 | 3 | 2 | brokenRef×7 / rawURL×3 / selfCite×1 | 무거움 |
| 2 | 화학공학기술자 | 9.0 | 3 | 2 | brokenRef×6 / rawURL×3 / selfCite×1 | 무거움 |
| 3 | 섬유제조기계조작원 | 8.0 | 3 | 0 | selfCiteOnly / listPage×3 / selfCite×3 | 중간 |
| 4 | 방송작가 | 4.0 | 3 | 2 | brokenRef×1 / rawURL×3 / selfCite×1 | 가벼움 |
| 5 | 항공기조종사 | 2.0 | 13 | 9 | rawURL×2 / selfCite×4 | 가벼움 |

### 세션 3: 사서 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 자동차공학기술자 | 9.0 | 4 | 2 | brokenRef×5 / rawURL×4 / selfCite×2 | 무거움 |
| 2 | 성직자 | 8.0 | 3 | 0 | selfCiteOnly / listPage×3 / selfCite×3 | 중간 |
| 3 | 피부관리사 | 8.0 | 6 | 4 | brokenRef×4 / rawURL×4 / selfCite×2 | 중간 |
| 4 | 방사선과의사 | 4.0 | 3 | 3 | brokenRef×4 / dup×2 | 가벼움 |
| 5 | 토목감리기술자 | 3.0 | 4 | 2 | brokenRef×2 / orphan×2 / dup×4 / selfCite×2 | 가벼움 |

### 세션 4: 경제학연구원 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 전자공학기술자 | 9.0 | 6 | 4 | brokenRef×5 / rawURL×4 / selfCite×2 | 무거움 |
| 2 | 유치원-원장-및-원감 | 8.0 | 3 | 0 | selfCiteOnly / listPage×3 / selfCite×3 | 중간 |
| 3 | 외교관 | 4.0 | 14 | 10 | rawURL×4 / selfCite×4 | 가벼움 |
| 4 | 패션모델 | 3.0 | 12 | 8 | rawURL×3 / selfCite×4 | 가벼움 |
| 5 | 교도관 | 1.5 | 16 | 15 | rawURL×1 / orphan×1 / selfCite×1 | 가벼움 |

### 세션 5: 리포터 worktree

| # | slug | sev | URL | ext | 사고 패턴 | 무게 |
|---|------|-----|-----|-----|-----------|------|
| 1 | 전기가스수도관리자 | 8.0 | 3 | 0 | selfCiteOnly / listPage×3 / selfCite×3 | 중간 |
| 2 | 조사전문가 | 8.0 | 3 | 0 | selfCiteOnly / listPage×3 / selfCite×3 | 중간 |
| 3 | 선박기관사 | 4.0 | 2 | 2 | brokenRef×4 | 가벼움 |
| 4 | 일반의사 | 4.0 | 3 | 1 | brokenRef×1 / rawURL×3 / selfCite×2 | 가벼움 |
| 5 | 소믈리에 | 4.0 | 3 | 2 | brokenRef×1 / rawURL×3 / selfCite×1 | 가벼움 |

## 운영 가이드

- 각 세션이 직업 1개를 single-job 풀 사이클로 처리 → DONE/RETRY 보고
- 오케스트레이터가 DONE 받으면 같은 세션에 다음 직업 send_message
- cycle 2 (25건) 끝나면 cycle 3 (잔여 6건) 자동 dispatch
- cycle 3 = 5세션 × 1.2직업 평균 (1세션이 추가 1건 처리)

---

# 세션 1 (수의사보조원 worktree) — 5직업

> **dispatch 순서**: 5직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 1 — 직업 1/5: 서예가

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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283324729983/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=서예가 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=서예가`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 서예가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 서예가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 1 — 직업 2/5: 직업상담사

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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283460443102/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=직업상담사 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=직업상담사`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 직업상담사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 직업상담사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 1 — 직업 3/5: 번역가

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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/176528331355150/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=번역가 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=번역가`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 번역가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 번역가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 1 — 직업 4/5: 바리스타

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 바리스타 (id=1765283309704378)
- URL: https://careerwiki.org/job/바리스타
- 사고 패턴 (deep audit 2026-04-29): brokenRef×1 / rawURL×3 / selfCite×1
  - brokenRef: [{"field":"way","idx":2}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=3, externalHosts=2, uniqueHosts=2
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 1건; _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283309704378/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=바리스타 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=바리스타`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 바리스타 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 바리스타 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 1 — 직업 5/5: 영화시나리오작가

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 영화시나리오작가 (id=1765283346355412)
- URL: https://careerwiki.org/job/영화시나리오작가
- 사고 패턴 (deep audit 2026-04-29): brokenRef×2 / dup×4 / selfCite×2
  - brokenRef: [{"field":"detailWlb.wlbDetail","idx":2},{"field":"detailWlb.socialDetail","idx":2}]
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=8, externalHosts=6, uniqueHosts=4
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 2건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283346355412/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=영화시나리오작가 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=영화시나리오작가`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 영화시나리오작가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 영화시나리오작가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

---

# 세션 2 (만화가 worktree) — 5직업

> **dispatch 순서**: 5직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 2 — 직업 1/5: 재료공학기술자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 재료공학기술자 (id=1765283364145434)
- URL: https://careerwiki.org/job/재료공학기술자
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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283364145434/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=재료공학기술자 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=재료공학기술자`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 재료공학기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 재료공학기술자 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 2 — 직업 2/5: 화학공학기술자

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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283402753351/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=화학공학기술자 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=화학공학기술자`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 화학공학기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 화학공학기술자 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 2 — 직업 3/5: 섬유제조기계조작원

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 섬유제조기계조작원 (id=1765283519225217)
- URL: https://careerwiki.org/job/섬유제조기계조작원
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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283519225217/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=섬유제조기계조작원 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=섬유제조기계조작원`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 섬유제조기계조작원 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 섬유제조기계조작원 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 2 — 직업 4/5: 방송작가

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 방송작가 (id=176528346734240)
- URL: https://careerwiki.org/job/방송작가
- 사고 패턴 (deep audit 2026-04-29): brokenRef×1 / rawURL×3 / selfCite×1
  - brokenRef: [{"field":"way","idx":2}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=3, externalHosts=2, uniqueHosts=2
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 1건; _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/176528346734240/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=방송작가 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=방송작가`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 방송작가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 방송작가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 2 — 직업 5/5: 항공기조종사

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 항공기조종사 (id=1765283491867444)
- URL: https://careerwiki.org/job/항공기조종사
- 사고 패턴 (deep audit 2026-04-29): rawURL×2 / selfCite×4
  - rawURL 위치: overviewProspect.main#1, trivia#2
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=13, externalHosts=9, uniqueHosts=8
- 핵심 작업: _sources.text가 raw URL 2건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283491867444/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=항공기조종사 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=항공기조종사`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 항공기조종사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 항공기조종사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

---

# 세션 3 (사서 worktree) — 5직업

> **dispatch 순서**: 5직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 3 — 직업 1/5: 자동차공학기술자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 자동차공학기술자 (id=1765283360062685)
- URL: https://careerwiki.org/job/자동차공학기술자
- 사고 패턴 (deep audit 2026-04-29): brokenRef×5 / rawURL×4 / selfCite×2
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3, way#4
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=4, externalHosts=2, uniqueHosts=2
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 5건; _sources.text가 raw URL 4건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283360062685/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=자동차공학기술자 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=자동차공학기술자`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 자동차공학기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 자동차공학기술자 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 3 — 직업 2/5: 성직자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 성직자 (id=1765283328409182)
- URL: https://careerwiki.org/job/성직자
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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283328409182/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=성직자 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=성직자`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 성직자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 성직자 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 3 — 직업 3/5: 피부관리사

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 피부관리사 (id=1765283396344506)
- URL: https://careerwiki.org/job/피부관리사
- 사고 패턴 (deep audit 2026-04-29): brokenRef×4 / rawURL×4 / selfCite×2
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#5, way#6
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=6, externalHosts=4, uniqueHosts=4
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 4건; _sources.text가 raw URL 4건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283396344506/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=피부관리사 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=피부관리사`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 피부관리사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 피부관리사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 3 — 직업 4/5: 방사선과의사

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 방사선과의사 (id=1765283464036549)
- URL: https://careerwiki.org/job/방사선과의사
- 사고 패턴 (deep audit 2026-04-29): brokenRef×4 / dup×2
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"trivia","idx":2},{"field":"way","idx":2},{"field":"way","idx":3}]
- audit 메트릭: totalUrls=3, externalHosts=3, uniqueHosts=3
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 4건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283464036549/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=방사선과의사 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=방사선과의사`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 방사선과의사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 방사선과의사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 3 — 직업 5/5: 토목감리기술자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 토목감리기술자 (id=1765283442674847)
- URL: https://careerwiki.org/job/토목감리기술자
- 사고 패턴 (deep audit 2026-04-29): brokenRef×2 / orphan×2 / dup×4 / selfCite×2
  - brokenRef: [{"field":"overviewProspect.main","idx":4},{"field":"trivia","idx":5}]
  - orphanSrc: [{"field":"overviewProspect.main","idx":1},{"field":"trivia","idx":1}]
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=4, externalHosts=2, uniqueHosts=3
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 2건; _sources 등록만 본문 미사용 2건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283442674847/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=토목감리기술자 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=토목감리기술자`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 토목감리기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 토목감리기술자 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

---

# 세션 4 (경제학연구원 worktree) — 5직업

> **dispatch 순서**: 5직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 4 — 직업 1/5: 전자공학기술자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 전자공학기술자 (id=1765283367205194)
- URL: https://careerwiki.org/job/전자공학기술자
- 사고 패턴 (deep audit 2026-04-29): brokenRef×5 / rawURL×4 / selfCite×2
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"way","idx":3},{"field":"way","idx":4},{"field":"way","idx":5}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#5, way#6
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=6, externalHosts=4, uniqueHosts=4
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 5건; _sources.text가 raw URL 4건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283367205194/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=전자공학기술자 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=전자공학기술자`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 전자공학기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 전자공학기술자 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 4 — 직업 2/5: 유치원-원장-및-원감

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 유치원-원장-및-원감 (id=1765283410710701)
- URL: https://careerwiki.org/job/유치원-원장-및-원감
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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283410710701/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=유치원-원장-및-원감 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=유치원-원장-및-원감`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 유치원-원장-및-원감 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 유치원-원장-및-원감 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 4 — 직업 3/5: 외교관

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 외교관 (id=1765283346646731)
- URL: https://careerwiki.org/job/외교관
- 사고 패턴 (deep audit 2026-04-29): rawURL×4 / selfCite×4
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#4, way#5
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=14, externalHosts=10, uniqueHosts=4
- 핵심 작업: _sources.text가 raw URL 4건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283346646731/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=외교관 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=외교관`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 외교관 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 외교관 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 4 — 직업 4/5: 패션모델

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 패션모델 (id=1765284154102933)
- URL: https://careerwiki.org/job/패션모델
- 사고 패턴 (deep audit 2026-04-29): rawURL×3 / selfCite×4
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=12, externalHosts=8, uniqueHosts=4
- 핵심 작업: _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765284154102933/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=패션모델 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=패션모델`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 패션모델 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 패션모델 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 4 — 직업 5/5: 교도관

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 교도관 (id=1765283288900613)
- URL: https://careerwiki.org/job/교도관
- 사고 패턴 (deep audit 2026-04-29): rawURL×1 / orphan×1 / selfCite×1
  - rawURL 위치: overviewProspect.main#1
  - orphanSrc: [{"field":"overviewProspect.main","idx":1}]
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=16, externalHosts=15, uniqueHosts=6
- 핵심 작업: _sources.text가 raw URL 1건 (기관명 교체); _sources 등록만 본문 미사용 1건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283288900613/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=교도관 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=교도관`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 교도관 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 교도관 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

---

# 세션 5 (리포터 worktree) — 5직업

> **dispatch 순서**: 5직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.

### 세션 5 — 직업 1/5: 전기가스수도관리자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 전기가스수도관리자 (id=1765283412976396)
- URL: https://careerwiki.org/job/전기가스수도관리자
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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283412976396/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=전기가스수도관리자 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=전기가스수도관리자`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 전기가스수도관리자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 전기가스수도관리자 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 5 — 직업 2/5: 조사전문가

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 조사전문가 (id=1765283414891152)
- URL: https://careerwiki.org/job/조사전문가
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

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283414891152/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=조사전문가 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=조사전문가`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 조사전문가 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 조사전문가 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 5 — 직업 3/5: 선박기관사

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 선박기관사 (id=1765283493883814)
- URL: https://careerwiki.org/job/선박기관사
- 사고 패턴 (deep audit 2026-04-29): brokenRef×4
  - brokenRef: [{"field":"trivia","idx":2},{"field":"trivia","idx":3},{"field":"way","idx":2},{"field":"way","idx":3}]
- audit 메트릭: totalUrls=2, externalHosts=2, uniqueHosts=2
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 4건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283493883814/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=선박기관사 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=선박기관사`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 선박기관사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 선박기관사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 5 — 직업 4/5: 일반의사

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 일반의사 (id=1765283358528451)
- URL: https://careerwiki.org/job/일반의사
- 사고 패턴 (deep audit 2026-04-29): brokenRef×1 / rawURL×3 / selfCite×2
  - brokenRef: [{"field":"way","idx":2}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=3, externalHosts=1, uniqueHosts=2
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 1건; _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283358528451/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=일반의사 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=일반의사`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 일반의사 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 일반의사 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

### 세션 5 — 직업 5/5: 소믈리에

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 소믈리에 (id=1765283329218353)
- URL: https://careerwiki.org/job/소믈리에
- 사고 패턴 (deep audit 2026-04-29): brokenRef×1 / rawURL×3 / selfCite×1
  - brokenRef: [{"field":"way","idx":2}]
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#3
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=3, externalHosts=2, uniqueHosts=3
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 1건; _sources.text가 raw URL 3건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

**🚨 Phase 0-SYNC (반드시 실행)**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저
5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283329218353/edit` + `X-Admin-Secret: careerwiki-admin-2026`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=소믈리에 --apply`
9. **Phase 5-AUDIT-DEEP**: `node scripts/skill-cache/audit-sources-deep.cjs --slug=소믈리에`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **`[selfDomain]` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **`[originDomain]` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 `*.go.kr` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **`[listPageURL]` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **`[brokenRef]` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **`[orphanSrc]` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - `detailReady.curriculum` / `recruit` / `training` 각 항목 끝 `[N]` 부착
    - 각 sub 필드 `_sources["detailReady.X"]` 등록 필수
    - validate `[UCJ각주항목누락]` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 `_careerTreeNote` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
```
DONE: 소믈리에 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**audit FAIL 시**:
```
RETRY: 소믈리에 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
```

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
```

---
