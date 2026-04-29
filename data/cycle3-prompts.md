# Cycle 3 Prompts (6직업 — 자투리 마지막 사이클)

**Generated**: 2026-04-29T17:29:43.291Z
**Source**: data/master-list-50.json — cycle 1 (16) + cycle 2 (25) 후 잔여 6건
**main HEAD**: 43a0f03 이상 (cycle 2와 동일)
**운영 룰**: 4세션 × 1직업 + 1세션 × 2직업 (리포터 worktree가 자투리 1건 처리)

## 세션별 분배 (cycle 3 = 6직업)

### 세션 1: 수의사보조원 worktree (1직업)

| # | slug | sev | URL | ext | 사고 패턴 |
|---|------|-----|-----|-----|-----------|
| 1 | 행사기획자 | 4.0 | 20 | 19 | brokenRef×4 / selfCite×1 |

### 세션 2: 만화가 worktree (1직업)

| # | slug | sev | URL | ext | 사고 패턴 |
|---|------|-----|-----|-----|-----------|
| 1 | 전기공학기술자 | 4.0 | 6 | 4 | rawURL×4 / selfCite×2 |

### 세션 3: 사서 worktree (1직업)

| # | slug | sev | URL | ext | 사고 패턴 |
|---|------|-----|-----|-----|-----------|
| 1 | 기상연구원 | 1.5 | 15 | 12 | rawURL×1 / orphan×1 / selfCite×3 |

### 세션 4: 경제학연구원 worktree (1직업)

| # | slug | sev | URL | ext | 사고 패턴 |
|---|------|-----|-----|-----|-----------|
| 1 | 섬유공학기술자 | 1.0 | 5 | 3 | brokenRef×1 / dup×4 / selfCite×2 |

### 세션 5: 리포터 worktree (2직업)

| # | slug | sev | URL | ext | 사고 패턴 |
|---|------|-----|-----|-----|-----------|
| 1 | 토목공학기술자 | 1.0 | 19 | 15 | rawURL×1 / selfCite×4 |
| 2 | 항공공학기술자 | 1.0 | 5 | 3 | brokenRef×1 / dup×4 / selfCite×2 |

## 운영 가이드

- cycle 2 끝나면 자동 cycle 3 dispatch (사용자 GO 안 기다림)
- 세션 5 (리포터 worktree)가 토목공학+항공공학 2건 처리 (둘 다 sev=1, 가벼운 작업)
- cycle 3 끝나면 master-list-50 47건 모두 처리 완료

---

# 세션 1 (수의사보조원 worktree) — 1직업

### 세션 1 — 직업 1/1: 행사기획자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 행사기획자 (id=1765283400318551)
- URL: https://careerwiki.org/job/행사기획자
- 사고 패턴 (deep audit 2026-04-29): brokenRef×4 / selfCite×1
  - brokenRef: [{"field":"overviewProspect.main","idx":2},{"field":"overviewProspect.main","idx":3},{"field":"detailWlb.wlbDetail","idx":2},{"field":"detailWlb.socialDetail","idx":2}]
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=20, externalHosts=19, uniqueHosts=6
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 4건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성

**🚨 Phase 0-SYNC**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD 43a0f03 이상 확인. 미만이면 git pull origin main
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고):
- wagework은 외부 host 카운트에 절대 포함 금지
- Phase 2 validate stdout 첨부 강제

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준
3. **Phase 1**: 17필드 draft 작성
4. **Phase 1-PRE**: `lookup.cjs --type=cert|org` 먼저
5. **Phase 2**: `validate-job-edit.cjs` PASS + stdout 첨부
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283400318551/edit` (Node.js fetch + UTF-8)
7. **Phase 4**: `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=행사기획자 --apply`
9. **Phase 5-AUDIT-DEEP**: `audit-sources-deep.cjs --slug=행사기획자`, 9패턴+originDomain=0
10. **END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12-19. selfDomain / **originDomain (wagework 1건이라도 FAIL)** / listPageURL / brokenRef / orphanSrc / text=기관명 / sal-수정금지 / homonym + careerTree 정치인

### 🆕 Cycle 정책
20. detailReady 항목별 [N] + _sources 등록 필수
21. 외부 host minimum 3+ (origin 카운트 안 됨)
22. careerTree 손대지 않음
23. Phase 4-SRC URL fetch + 키워드 매칭 검증

### 종료 후 보고
**clean 시**:
```
DONE: 행사기획자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**FAIL 시**: `RETRY: 행사기획자 사유: {...}`

> ⚠️ enhance는 DB만 변경 — git/deploy 불필요
```

---

# 세션 2 (만화가 worktree) — 1직업

### 세션 2 — 직업 1/1: 전기공학기술자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 전기공학기술자 (id=1765283365417879)
- URL: https://careerwiki.org/job/전기공학기술자
- 사고 패턴 (deep audit 2026-04-29): rawURL×4 / selfCite×2
  - rawURL 위치: overviewProspect.main#1, trivia#2, way#5, way#6
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=6, externalHosts=4, uniqueHosts=5
- 핵심 작업: _sources.text가 raw URL 4건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성

**🚨 Phase 0-SYNC**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD 43a0f03 이상 확인. 미만이면 git pull origin main
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고):
- wagework은 외부 host 카운트에 절대 포함 금지
- Phase 2 validate stdout 첨부 강제

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준
3. **Phase 1**: 17필드 draft 작성
4. **Phase 1-PRE**: `lookup.cjs --type=cert|org` 먼저
5. **Phase 2**: `validate-job-edit.cjs` PASS + stdout 첨부
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283365417879/edit` (Node.js fetch + UTF-8)
7. **Phase 4**: `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=전기공학기술자 --apply`
9. **Phase 5-AUDIT-DEEP**: `audit-sources-deep.cjs --slug=전기공학기술자`, 9패턴+originDomain=0
10. **END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12-19. selfDomain / **originDomain (wagework 1건이라도 FAIL)** / listPageURL / brokenRef / orphanSrc / text=기관명 / sal-수정금지 / homonym + careerTree 정치인

### 🆕 Cycle 정책
20. detailReady 항목별 [N] + _sources 등록 필수
21. 외부 host minimum 3+ (origin 카운트 안 됨)
22. careerTree 손대지 않음
23. Phase 4-SRC URL fetch + 키워드 매칭 검증

### 종료 후 보고
**clean 시**:
```
DONE: 전기공학기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**FAIL 시**: `RETRY: 전기공학기술자 사유: {...}`

> ⚠️ enhance는 DB만 변경 — git/deploy 불필요
```

---

# 세션 3 (사서 worktree) — 1직업

### 세션 3 — 직업 1/1: 기상연구원

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 기상연구원 (id=1765283293608896)
- URL: https://careerwiki.org/job/기상연구원
- 사고 패턴 (deep audit 2026-04-29): rawURL×1 / orphan×1 / selfCite×3
  - rawURL 위치: overviewProspect.main#1
  - orphanSrc: [{"field":"overviewProspect.main","idx":1}]
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=15, externalHosts=12, uniqueHosts=6
- 핵심 작업: _sources.text가 raw URL 1건 (기관명 교체); _sources 등록만 본문 미사용 1건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성

**🚨 Phase 0-SYNC**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD 43a0f03 이상 확인. 미만이면 git pull origin main
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고):
- wagework은 외부 host 카운트에 절대 포함 금지
- Phase 2 validate stdout 첨부 강제

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준
3. **Phase 1**: 17필드 draft 작성
4. **Phase 1-PRE**: `lookup.cjs --type=cert|org` 먼저
5. **Phase 2**: `validate-job-edit.cjs` PASS + stdout 첨부
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283293608896/edit` (Node.js fetch + UTF-8)
7. **Phase 4**: `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=기상연구원 --apply`
9. **Phase 5-AUDIT-DEEP**: `audit-sources-deep.cjs --slug=기상연구원`, 9패턴+originDomain=0
10. **END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12-19. selfDomain / **originDomain (wagework 1건이라도 FAIL)** / listPageURL / brokenRef / orphanSrc / text=기관명 / sal-수정금지 / homonym + careerTree 정치인

### 🆕 Cycle 정책
20. detailReady 항목별 [N] + _sources 등록 필수
21. 외부 host minimum 3+ (origin 카운트 안 됨)
22. careerTree 손대지 않음
23. Phase 4-SRC URL fetch + 키워드 매칭 검증

### 종료 후 보고
**clean 시**:
```
DONE: 기상연구원 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**FAIL 시**: `RETRY: 기상연구원 사유: {...}`

> ⚠️ enhance는 DB만 변경 — git/deploy 불필요
```

---

# 세션 4 (경제학연구원 worktree) — 1직업

### 세션 4 — 직업 1/1: 섬유공학기술자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 섬유공학기술자 (id=1765283327188975)
- URL: https://careerwiki.org/job/섬유공학기술자
- 사고 패턴 (deep audit 2026-04-29): brokenRef×1 / dup×4 / selfCite×2
  - brokenRef: [{"field":"trivia","idx":2}]
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=5, externalHosts=3, uniqueHosts=4
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 1건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성

**🚨 Phase 0-SYNC**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD 43a0f03 이상 확인. 미만이면 git pull origin main
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고):
- wagework은 외부 host 카운트에 절대 포함 금지
- Phase 2 validate stdout 첨부 강제

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준
3. **Phase 1**: 17필드 draft 작성
4. **Phase 1-PRE**: `lookup.cjs --type=cert|org` 먼저
5. **Phase 2**: `validate-job-edit.cjs` PASS + stdout 첨부
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283327188975/edit` (Node.js fetch + UTF-8)
7. **Phase 4**: `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=섬유공학기술자 --apply`
9. **Phase 5-AUDIT-DEEP**: `audit-sources-deep.cjs --slug=섬유공학기술자`, 9패턴+originDomain=0
10. **END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12-19. selfDomain / **originDomain (wagework 1건이라도 FAIL)** / listPageURL / brokenRef / orphanSrc / text=기관명 / sal-수정금지 / homonym + careerTree 정치인

### 🆕 Cycle 정책
20. detailReady 항목별 [N] + _sources 등록 필수
21. 외부 host minimum 3+ (origin 카운트 안 됨)
22. careerTree 손대지 않음
23. Phase 4-SRC URL fetch + 키워드 매칭 검증

### 종료 후 보고
**clean 시**:
```
DONE: 섬유공학기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**FAIL 시**: `RETRY: 섬유공학기술자 사유: {...}`

> ⚠️ enhance는 DB만 변경 — git/deploy 불필요
```

---

# 세션 5 (리포터 worktree) — 2직업

### 세션 5 — 직업 1/2: 토목공학기술자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 토목공학기술자 (id=1765283388857592)
- URL: https://careerwiki.org/job/토목공학기술자
- 사고 패턴 (deep audit 2026-04-29): rawURL×1 / selfCite×4
  - rawURL 위치: trivia#4
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=19, externalHosts=15, uniqueHosts=6
- 핵심 작업: _sources.text가 raw URL 1건 (기관명 교체)

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성

**🚨 Phase 0-SYNC**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD 43a0f03 이상 확인. 미만이면 git pull origin main
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고):
- wagework은 외부 host 카운트에 절대 포함 금지
- Phase 2 validate stdout 첨부 강제

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준
3. **Phase 1**: 17필드 draft 작성
4. **Phase 1-PRE**: `lookup.cjs --type=cert|org` 먼저
5. **Phase 2**: `validate-job-edit.cjs` PASS + stdout 첨부
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283388857592/edit` (Node.js fetch + UTF-8)
7. **Phase 4**: `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=토목공학기술자 --apply`
9. **Phase 5-AUDIT-DEEP**: `audit-sources-deep.cjs --slug=토목공학기술자`, 9패턴+originDomain=0
10. **END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12-19. selfDomain / **originDomain (wagework 1건이라도 FAIL)** / listPageURL / brokenRef / orphanSrc / text=기관명 / sal-수정금지 / homonym + careerTree 정치인

### 🆕 Cycle 정책
20. detailReady 항목별 [N] + _sources 등록 필수
21. 외부 host minimum 3+ (origin 카운트 안 됨)
22. careerTree 손대지 않음
23. Phase 4-SRC URL fetch + 키워드 매칭 검증

### 종료 후 보고
**clean 시**:
```
DONE: 토목공학기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**FAIL 시**: `RETRY: 토목공학기술자 사유: {...}`

> ⚠️ enhance는 DB만 변경 — git/deploy 불필요
```

### 세션 5 — 직업 2/2: 항공공학기술자

```
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### 항공공학기술자 (id=1765283444621492)
- URL: https://careerwiki.org/job/항공공학기술자
- 사고 패턴 (deep audit 2026-04-29): brokenRef×1 / dup×4 / selfCite×2
  - brokenRef: [{"field":"overviewProspect.main","idx":2}]
  - selfCite hosts: www.career.go.kr
- audit 메트릭: totalUrls=5, externalHosts=3, uniqueHosts=3
- 핵심 작업: 본문 [N] vs _sources 길이 mismatch 1건

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL
- validate FAIL 시 본문 재작성

**🚨 Phase 0-SYNC**:
```bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD 43a0f03 이상 확인. 미만이면 git pull origin main
```

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고):
- wagework은 외부 host 카운트에 절대 포함 금지
- Phase 2 validate stdout 첨부 강제

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: `merged_profile_json` 기준
3. **Phase 1**: 17필드 draft 작성
4. **Phase 1-PRE**: `lookup.cjs --type=cert|org` 먼저
5. **Phase 2**: `validate-job-edit.cjs` PASS + stdout 첨부
6. **Phase 3**: `POST https://careerwiki.org/api/job/1765283444621492/edit` (Node.js fetch + UTF-8)
7. **Phase 4**: `full-quality-audit.cjs` PASS
8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=항공공학기술자 --apply`
9. **Phase 5-AUDIT-DEEP**: `audit-sources-deep.cjs --slug=항공공학기술자`, 9패턴+originDomain=0
10. **END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12-19. selfDomain / **originDomain (wagework 1건이라도 FAIL)** / listPageURL / brokenRef / orphanSrc / text=기관명 / sal-수정금지 / homonym + careerTree 정치인

### 🆕 Cycle 정책
20. detailReady 항목별 [N] + _sources 등록 필수
21. 외부 host minimum 3+ (origin 카운트 안 됨)
22. careerTree 손대지 않음
23. Phase 4-SRC URL fetch + 키워드 매칭 검증

### 종료 후 보고
**clean 시**:
```
DONE: 항공공학기술자 rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
```

**FAIL 시**: `RETRY: 항공공학기술자 사유: {...}`

> ⚠️ enhance는 DB만 변경 — git/deploy 불필요
```

---
