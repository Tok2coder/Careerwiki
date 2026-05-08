# Safety Rules — cleanup 스킬 보호 영역 + 블랙리스트

> SKILL.md Safety Rules 13개의 확장본. 본 doc은 reference 전용 — 실행 중 의문 발생 시 참고.

---

## 1. WebFetch 강제

**원칙**: `_sources` URL 등록 *전* WebFetch tool_use ≥ 1회. tool_uses 카운트 < new URL 카운트면 cleanup 무효.

**왜?** LLM 일반 지식으로 URL을 추정하면 hallucination 발생. 실제 존재하지 않는 deep page를 박는 사고가 다수.

**적용**: cleanup이 신규 URL을 등록하는 경우 (rootURL → deep URL 교체, listPage → article 교체) 모두 해당. URL 단순 REMOVE는 WebFetch 불필요.

**검증**: cleanup 작업 후 `WebFetch tool_uses ≥ new URL count` self-report 의무. 미달 시 RETRY.

---

## 2. Hallucinated 도메인 블랙리스트

다음 도메인은 LLM이 자주 hallucinate하는 패턴이므로 등록 전 WebFetch 의무 (정상 응답 + 본문 fact 매칭 확인 둘 다):

- `kgta.or.kr` (캐디 — 사고 사례)
- `k-lpn.or.kr` (간호조무사 — 사고 사례)
- `kpba.co.kr` (동물조련사 — 사고 사례)
- `kindergarten.go.kr` boardid 추정
- `humanrights.go.kr` boardid 추정
- `gamejob.co.kr` ASP path
- `careers.*` deep path (대기업 채용 페이지 — 동적 ASP/JSP path 추정 위험)
- `learn.unity.com` pathway 추정

**일반 원칙**: 모든 URL은 WebFetch 필수. 위 도메인은 특히 자주 사고 발생하므로 강조.

---

## 3. Phase 0-SYNC 필수

**원칙**: 작업 시작 전 main HEAD ≥ `MAIN_HEAD_MIN`.

```bash
git fetch origin main
git log --oneline -1 origin/main
# 384ce33 (현재 minimum) 이상 확인
git pull origin main    # 미만이면 즉시
```

**왜?** 옛 main HEAD에서 작업하면 새로 추가된 룰을 모르는 상태로 cleanup 진행 → audit FAIL 잔존 또는 새 사고 발생.

`MAIN_HEAD_MIN`은 새 룰/PR이 머지될 때마다 갱신. 현재(2026-05-07) `384ce33` (`--exclude-sal` 머지 후).

---

## 4. sal-protection 절대 (가장 중요)

**원칙**: `fields.overviewSalary` / `sources["overviewSalary.sal"]` 어떤 식으로든 손대지 X.

**대상**:
- `overviewSalary.sal` (본문)
- `overviewSalary.wage` (바 차트 데이터)
- `overviewSalary.wageSource`
- `_sources["overviewSalary.sal"]` 

**왜?** 
- `feedback_sal_protection_strict.md` 룰 박힘 (2026-05-07 사고 후 strict 복원 — `2af54bf` revert)
- validate-job-edit.cjs `[sal-readonly]` strict로 sources 단독 전송도 FAIL
- 사용자 명시: "sal/wage 영역 데이터·출처·룰 모두 절대 건드리지 마"

**audit 처리**: `audit-via-api.cjs --exclude-sal` 옵션으로 sal 영역 검증을 skip한다. 즉 sal에 origin/listPage/rootURL이 잔존해도 audit는 PASS로 본다. 이건 의도된 trade-off — sal 정비는 별도 사이클이 처리.

**검증**: payload에 sal 영역 키가 들어가 있는지 grep:
```bash
grep -E "overviewSalary|wageSource" payload.json && echo "FAIL: sal 영역 발견" && exit 1
```

---

## 5. careerTree 보호

**원칙**: `fields.careerTree` 어떤 식으로든 손대지 X.

**왜?** careerTree는 별도 사이클 (예: `career-tree-fill` 또는 enhance Phase 5의 careerTree subagent)이 처리. cleanup 범위 외.

**예외**: 없음. careerTree에 audit FAIL이 발견되어도 cleanup은 스킵 — 별도 보고만.

---

## 6. 본문 fact 보존

**원칙**: 출처 정리만, 본문 단어/숫자/구체정보는 그대로.

**예외**: 출처 deep page 발굴 실패 후 fact 자체가 cover 안 되면 일반화 (회사명 → 산업 표현, 연도/금액 → 범위 표현).

**우선순위**:
1. deep page 발굴 (WebFetch)
2. 다른 출처에서 1:1 cover (WebFetch)
3. 출처 src REMOVE + 본문 마커 제거
4. **fact 자체 일반화 (마지막 수단)**

**왜?** 일반화는 사용 가치를 떨어뜨림. "삼성전자·SK하이닉스 R&D 채용" → "반도체 산업 채용"으로 일반화하면 정보 손실. 일반화 전 deep page 시도 의무.

---

## 7. minimal POST

**원칙**: 변경된 field만 payload. 미변경 field는 미포함.

**왜?** 
- 미변경 field 동봉 → 의도치 않은 덮어쓰기 위험 (concurrent edit 시 충돌)
- payload 크기 증가
- change_summary와 실제 변경 내역 불일치 → audit 추적 어려움

**예외**: changeSummary만 부착하고 fields/sources 둘 다 비어있으면 server side가 `[minimalPOST]` FAIL — 즉 실제 변경 1건 이상 필수.

---

## 8. DONE/RETRY 포맷 강제

**원칙**: LLM 자가검증 1줄 통과 절대 금지. `audit-via-api.cjs --exclude-sal` 결정적 검증만 진리.

**금지 패턴**:
- "검증 완료" 1줄
- "CLEAN" 라벨만
- self-report 만족도 표시

**의무 패턴**:
- DONE: 형식 (audit 명령 + 결과 + WebFetch count + 변경 카운트)
- RETRY: 형식 (사고 분석 + attempted + blocker)

---

## 9. main branch에서만 deploy

**원칙**: cleanup이 코드 변경을 포함하면 main 브랜치에서만 deploy. worktree에서 deploy 시 다음 main 배포에서 롤백됨.

**일반 cleanup**: DB만 수정 — deploy 불필요. POST API만으로 prod 즉시 반영.

**예외**: cleanup이 스크립트 수정/도구 추가 등 코드 변경 동반 → 별도 PR로 main 머지 후 deploy.

---

## 10. Pre-commit hook 우회 금지

**원칙**: `--no-verify` 절대 X.

**왜?** `scripts/check-secrets.cjs`가 .dev.vars / 비밀키 노출 차단. 우회 시 비밀키 commit 사고.

**hook 실패 시**: 원인 fix → 재 commit. skip은 절대 옵션 X.

---

## 11. subagent fan-out 금지

**원칙**: 본 세션이 직접 처리. subagent / Agent fan-out 절대 X.

**왜?** 어제 사고 (2026-04-29 + 본 세션 직전): polling 1줄 → orchestrator dispatch에 status → subagent 75 fan-out → 172M token 폭주.

**polling**: orchestrator가 직접 bash로 처리. session jsonl tail. subagent 띄우지 X.

**예외**: 없음. cleanup은 직업당 single-job 처리 — 병렬화 시 subagent보다 multiple sessions로 분산 (orchestrator 통제).

---

## 12. 사고 발견 시 즉시 STOP

**원칙**: retry 1회 후도 FAIL이면 STOP + 보고. 자체 판단으로 추가 retry 진행 X.

**STOP 조건**:
- audit-via-api FAIL 2회 연속 (동일 직업, 동일 룰)
- WebFetch 차단 다수 (URL count vs tool_uses 격차 > 50%)
- Phase 0-SYNC main HEAD < `MAIN_HEAD_MIN`
- sal 영역 의도치 않은 접촉 발견 (payload에 sal 키 박힘)
- 새 사고 패턴 발견 (기존 룰에 매핑 안 됨)
- prod 200이지만 본문 키워드 미반영

→ 즉시 STOP + 사고 보고 (root cause + attempted + blocker). 사용자 결정 받기 전 추가 진행 X.

---

## 13. 일반화는 사용 가치 떨어뜨림

**원칙**: deep page 시도 우선. 일반화는 마지막 수단.

**판단 절차**:
1. 본문 fact 추출 (회사명·통계·연도·금액·순위)
2. 그 fact를 cover하는 deep URL 발굴 (WebFetch search + 후보 fetch)
3. cover 강한 deep page → url 교체
4. cover 약한 deep page → 더 권위 있는 출처 시도
5. 모든 deep 시도 실패 → 본문 fact 일반화 (구체 정보 → 범주 정보)
6. 일반화로 cover 가능한 출처 (협회 root, 산업 통계 등) → src 교체

**일반화 예시**:
- "삼성전자 채용 2024년 1,200명" → "반도체 대기업 채용 (2024)"
- "한국게임산업협회 발표 19조원" → "한국 게임 산업 시장 규모"

**일반화 금지 케이스**: 본문이 직업의 정체성을 정의하는 fact (예: "한국게임산업협회"가 반복 인용되면 출처 제거 시 본문이 의미 잃음). 이 경우 deep page 발굴 의무.

---

## 14. 영역 분류 우선 — UCJ array vs 산문 필드

**원칙**: rootURL/origin/listPage fix 시작 전 finding이 **detailReady array** 영역인지 **산문 필드** 영역인지 먼저 분류 (SKILL.md Phase 2.0).

**왜?** detailReady.{curriculum,recruit,training} 항목은 validate 룰 A `[UCJ각주항목누락]`으로 **모든 항목에 [N] 마커 필수**. src REMOVE → body [N] 제거 패턴이 산문 필드에서는 PASS지만 array 항목에서는 즉시 FAIL.

**산문 필드** (`trivia`, `overviewProspect.main`, `way`, `summary`, `detailWlb.*`, `overviewWork.main`, `overviewAbilities.technKnow`):
- src REMOVE + body [N] 제거 + RE-INDEX → 정상 작동
- 본문 fact는 출처 없이 잔존 가능 (UCJ 룰 적용 안 됨)

**detailReady array** (`detailReady.curriculum`, `detailReady.recruit`, `detailReady.training`):
- 단순 REMOVE 금지
- **4단계 fallback** 적용: URL 교체 → 본문 일반화 → 항목 merge → 인정+pending
- 1단계 (URL 교과) 우선 시도 의무. WebFetch ≥ 1회 per 신규 URL.

**사이드바** (`sidebarCerts._sources`, `sidebarOrgs._sources`, `sidebarMajors._sources`, `sidebarJobs._sources`):
- UCJ 룰 적용 안 됨. 통째 DELETE (`{delete: true}`) 안전
- 본문 sidebar 항목 자체는 미접촉

**방사선사 cleanup (테스트 1, 2026-05-08)**: trivia 산문 필드 → src REMOVE + body [1] 제거 PASS.
**게임-프로그래머 cleanup (테스트 2)**: curriculum/recruit array → 산문 필드 패턴 적용 시 [UCJ각주항목누락] FAIL. 4단계 fallback 적용 의무.

---

## 검증 체크리스트 (cleanup 작업 종료 직전)

- [ ] payload에 `overviewSalary` / `wageSource` 키 0건
- [ ] payload에 `careerTree` 키 0건
- [ ] WebFetch tool_uses ≥ new URL count
- [ ] validate-job-edit.cjs PASS (sal-readonly 차단 안 걸림)
- [ ] audit-via-api.cjs --exclude-sal CLEAN
- [ ] prod GET 200 + 본문 키워드 매칭
- [ ] change_summary `[job-data-cleanup]` 마커 부착
- [ ] DONE/RETRY 형식 출력 (LLM 1줄 자가검증 X)

체크리스트 미통과 항목 1+ → DONE 출력 금지. RETRY 또는 STOP.
