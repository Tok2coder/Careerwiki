# Cycle Prompt Template v3 (옵션 B' — 최소 안전 절감)

**Generated**: 2026-05-06
**Goal**: dispatch subagent token 1.18M → ~0.85M (~25%↓), 사고 0
**Source**: cycle1/2/3 압축 + 7 안전 룰 prompt 박음 (SKILL.md 의존 X)

## v3 vs cycle1/2/3 비교

| 측정 | cycle1 | cycle2 | cycle3 | v3 (목표) |
|---|---|---|---|---|
| avg lines | 102 | 99 | 64 | ~50 |
| est tokens | 2015 | 1726 | 882 | ~660 |

## 절대 빼지 않은 안전 룰 (prompt 박음)
1. WebFetch 강제 — _sources URL 등록 *전* tool_use ≥ 1회. tool_uses < URL → DONE 무효
2. hallucinated 도메인 블랙리스트
3. Phase 0-SYNC (origin/main HEAD 확인 + pull)
4. Phase 4-SRC-FACT (본문 fact ↔ 출처 1:1, 협회 root X)
5. Phase 5-AUDIT-DEEP (9패턴 + originDomain 0 / 1+ 발견 시 Phase 1 재시작)
6. DONE/RETRY 형식 강제
7. 자가검증 1줄 통과 차단 — 결정적 스크립트 별도 실행

## 빠진 verbose (절감 출처)
- 사고 학습 long form ("2026-04-29 origin-bulk batch 후반..." 같은 history) → 1줄 hallucination 블랙리스트로 압축
- Phase 별 verbose 설명 (각 5~10줄) → 1줄 핵심 + SKILL.md 참조
- master list / 다른 cycle 결과 / completed jobs metadata 제거 (1직업 정보만)
- 도구 사용법 반복 제거 (audit-sources-deep, lookup.cjs 등 한 줄 reference)
- 같은 룰 prompt 안 2~3번 반복 케이스 단일화

---

## v3 Template (parameterized)

```
/job-data-enhance 1직업 풀 사이클 — 단축 절대 금지

### {slug} (id={id})
- URL: https://careerwiki.org/job/{slug}
- 사고 패턴 (deep audit {date}): {tags}
{detail_lines}
- audit 메트릭: totalUrls={N}, externalHosts={N}, uniqueHosts={N}
- fact-source 분류: {classification} (suspectFacts={S} generalDomain={G})
- 핵심 작업: {summary}

## 안전 룰 (prompt 박음 — SKILL.md 의존 X)

**🚨 WebFetch 강제** — 모든 _sources URL은 등록 *전* WebFetch tool_use ≥ 1회 필수. tool_uses 카운트 < URL 카운트 → DONE 무효. LLM 일반 지식으로 URL 추정 절대 금지.

**🚨 hallucinated 도메인 블랙리스트 (등록 전 WebFetch 의무)** — kgta.or.kr / k-lpn.or.kr / kpba.co.kr / kindergarten.go.kr boardid 추정 / humanrights.go.kr boardid 추정 / gamejob.co.kr ASP path / careers.* deep path / learn.unity.com pathway 추정 등.

**🚨 Phase 0-SYNC 필수** — `git fetch origin main && git log --oneline origin/main | head -3`. main HEAD 5f75996 이상 확인. 미만이면 즉시 `git pull origin main`.

**🚨 origin 도메인 절대 금지** — `career.go.kr` / `work.go.kr` / `work24.go.kr` / **`wagework.go.kr`** / `job.go.kr` 1건이라도 즉시 FAIL. wagework은 외부 host 카운트 X. validate `[originDomain]` 0건 stdout 첨부 필수.

**🚨 Phase 4-SRC-FACT** — 본문 구체 fact (회사명·통계·연도·금액·순위) ↔ 출처 1:1 정합성. 협회 root URL은 fact cover X. 매핑 못 하면 (a) deep URL 찾기 (b) fact 일반화 (c) fact 제거. 한 sentence 1 마커 max.

**🚨 Phase 5-AUDIT-DEEP** — `node scripts/skill-cache/audit-sources-deep.cjs --slug={slug}`. 9패턴 + originDomain 모두 0 확인. 1+ 발견 시 Phase 1 재시작 (단축 금지).

**🚨 LLM 자가검증 1줄로 통과 절대 금지** — validate-job-edit.cjs / audit-sources-deep.cjs / Node.js fetch 키워드 매칭 등 결정적 스크립트로만 검증. self-report 라벨 ("CLEAN", "DONE")만으로 통과 X.

**🔴 단축 처리 금지** — 토큰 부족 ≠ minimal POST 사유. validate FAIL 시 본문 재작성. minimal POST (마커만 부착) → server-side `[minimalPOST]` FAIL.

## Phase 핵심 (자세히는 SKILL.md Phase 0~5)
1. **Phase 0-PRE** START_TRACKING bash 직접 실행
2. **Phase 0-DIAG** `merged_profile_json` 기준 + `json_type` 분기
3. **Phase 1** 17필드 draft (lookup.cjs --type=cert|org 먼저, WebFetch 강제)
4. **Phase 2** `scripts/validate-job-edit.cjs` PASS + stdout 첨부 ([originDomain] 0 확인)
5. **Phase 3** POST `https://careerwiki.org/api/job/{id}/edit` + `X-Admin-Secret: careerwiki-admin-2026` (Node.js fetch + UTF-8 / curl 절대 X)
6. **Phase 4** `full-quality-audit.cjs` PASS + Phase 4-SRC-FACT 매핑 검증
7. **Phase 5-DEDUP** `auto-dedup-sweep.cjs --slug={slug} --apply`
8. **Phase 5-AUDIT-DEEP** CLEAN + END_TRACKING + UCJ 17필드 self-report + `[job-data-enhance]` 마커 부착

**필수 만족**: 외부 host ≥ 3 (origin 카운트 X) / careerTree 손대지 X (별도 사이클) / detailReady 항목별 [N]+_sources

## DONE/RETRY 형식

**clean 시**:
```
DONE: {slug} rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처: WebFetch tool_uses={K} ≥ URL count={N} / fact-source 잔여={S→0 또는 일반화 처리}
```

**FAIL 시**: `RETRY: {slug} 사유: {validate FAIL pattern 또는 deep-audit pattern 상세}`

> enhance = DB만 — git/deploy 불필요.
```

---

## 운영 룰 (Polling 패턴 차단)

**과거 사고**: "v4 audit 끝났어?" 한 줄 polling → orchestrator가 dispatch에 status 한 줄 전달 → subagent 띄워 transcript 분석 → 75 fan-out → 172M token (6.5%)

**새 룰**:
- orchestrator는 polling을 직접 bash로 처리:
  - `tail -n 50 ~/.claude/projects/{repo}/{sessionId}.jsonl | grep '"role":"assistant"'` 직접 grep
  - 사고 자동 발견은 hook (`audit-after-edit.cjs`)이 담당
  - status 1초 안에 끝나야 — subagent 띄우지 말 것
- subagent dispatch는 새 직업 작업 시작 시점만, polling은 절대 X
