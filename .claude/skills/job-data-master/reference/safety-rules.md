# Safety Rules — 13 안전 룰 + 보호 영역 + 블랙리스트 + 화이트리스트

> SKILL.md Safety Rules 13개의 확장본. 본 doc은 reference 전용 — 실행 중 의문 발생 시 참조.

---

## 1. WebFetch 강제

**원칙**: `_sources` URL 등록 *전* WebFetch tool_use ≥ 1회. tool_uses 카운트 < new URL 카운트면 작업 무효.

**왜?** LLM 일반 지식으로 URL 추정 → hallucination 발생. 실제 존재하지 않는 deep page 박는 사고 다수.

**적용**: 신규 URL 등록 (rootURL → deep URL 교체, listPage → article 교체, enhance 신규 _sources 등록) 모두 해당. URL 단순 REMOVE는 WebFetch 불필요.

**검증**: 작업 후 `WebFetch tool_uses ≥ new URL count` self-report 의무. 미달 시 RETRY.

---

## 2. Hallucinated 도메인 블랙리스트

다음 도메인은 LLM이 자주 hallucinate. 등록 전 WebFetch 의무 (정상 응답 + 본문 fact 매칭 확인 둘 다):

| 가짜 도메인 | LLM 오인 | 실제 |
|---|---|---|
| `kgta.or.kr` | "한국캐디협회" | 경기도화물자동차운송사업협회. 캐디 협회 사실상 부재 |
| `k-lpn.or.kr` | "대한간호조무사협회" | **klpna.or.kr** (단 SSL 만료) |
| `kpba.co.kr` | "한국애견연맹" | **kkc.or.kr** / **thekkf.or.kr** |
| `kindergarten.go.kr` | "유치원알리미" | **e-childschoolinfo.moe.go.kr** |
| `humanrights.go.kr/.../boardid={랜덤}` | 인권위 boardid 추정 | WebSearch로만 확인 가능 |
| `learn.unity.com/pathway/junior-programmer` | Unity 학습 deep path | **learn.unity.com** root만 |
| `careers.nexon.com/recruit/intro` | 넥슨 채용 deep path | **careers.nexon.com** root만 |
| `unrealengine.com/ko/onlinelearning-courses/...` | 언리얼 학습 deep path | **unrealengine.com** root만 |
| `kocca.kr/kocca/bbs/list/B0000{숫자}.do` | KOCCA BBS ID | WebSearch verified만 |
| `gamejob.co.kr/Library/Content_View.asp` | 게임잡 ASP path | **gamejob.co.kr** root만 |
| `moe.go.kr/.../boardSeq={round 숫자}` | 교육부 보도자료 ID | round number 즉시 의심 |
| `law.go.kr/.../lsiSeq={round 숫자}` | 법령 ID | WebSearch verified만 |
| `surgery.or.kr/surgery/middle_surgery/sub/...html` | 외과학회 deep path | **surgery.or.kr** root만 |
| `krta.or.kr/bbs/board.php?bo_table=sub01_03` | 방사선사협회 BBS path | root + WebSearch verified만 |

**일반 원칙**: 모든 URL WebFetch 필수. 위 도메인 + round number + ASP/PHP/JSP path 추정 패턴 = 의심.

---

## 3. Phase 0-SYNC 필수

```bash
git fetch origin main
git log --oneline -1 origin/main      # MAIN_HEAD_MIN 이상 확인
git pull origin main                  # 미만이면
```

**왜?** 옛 main HEAD에서 작업 → 새 룰 모르는 상태 → audit FAIL 잔존 또는 새 사고.

`MAIN_HEAD_MIN`은 본 스킬 머지 시점 hash로 갱신. PR 4 머지 시 dispatch-prompt-v3.cjs도 같이 bump.

---

## 4. sal-protection 절대 (가장 중요)

**원칙**: `fields.overviewSalary` / `sources["overviewSalary.sal"]` 어떤 식으로든 손대지 X.

**대상**:
- `overviewSalary.sal` (본문)
- `overviewSalary.wage` (바 차트 데이터)
- `overviewSalary.wageSource`
- `_sources["overviewSalary.sal"]`

**왜?**
- `feedback_sal_protection_strict.md` 룰 박힘 (2026-05-07 사고 후 strict 복원)
- validate-job-edit.cjs `[sal-readonly]` strict로 sources 단독 전송도 FAIL
- 사용자 명시: "sal/wage 영역 데이터·출처·룰 모두 절대 건드리지 마"

**audit 처리**: `audit-via-api.cjs --exclude-sal` 옵션으로 sal 영역 검증 skip. sal에 origin/listPage/rootURL 잔존해도 audit PASS — 의도된 trade-off. sal 정비는 별도 사이클.

**검증**: payload에 sal 영역 키 들어가 있는지 grep:
```bash
grep -E "overviewSalary|wageSource" payload.json && echo "FAIL: sal 영역" && exit 1
```

---

## 5. careerTree 보호

**원칙**: `fields.careerTree` 어떤 식으로든 손대지 X.

**예외**: enhance 모드의 신규 careerTree 생성 (Phase 3.6 절차) — `wrangler d1 execute` 직접 INSERT (`career_trees` + `career_tree_job_links` 테이블). payload에 포함 X. 기존 careerTree 수정/삭제는 절대 X.

**왜?** careerTree는 별도 사이클이 처리. 다른 직업과 공유될 수 있음 (인물 기반).

**역대 대통령 절대 금지** — 이승만, 윤보선, 박정희, 최규하, 전두환, 노태우, 김영삼, 김대중, 노무현, 이명박, 박근혜, 문재인, 윤석열 등은 `is_active=0` 처리된 인물. validate가 이름 패턴으로 FAIL 처리.

---

## 6. 본문 fact 보존

**원칙**: 출처 정리만, 본문 단어/숫자/구체정보는 그대로.

**예외 1**: 출처 deep page 발굴 실패 후 fact 자체가 cover 안 되면 일반화 (회사명 → 산업 표현, 연도/금액 → 범위 표현).

**예외 2** (NEW, fact verification): WebSearch cross-check에서 mismatch 검출 시 정확한 값으로 정정 + 출처 등록. evidence 의무 (검색 결과 + 출처 페이지 직접 등장 확인).

**우선순위**:
1. deep page 발굴 (WebFetch)
2. 다른 출처에서 1:1 cover (WebFetch)
3. fact 정확성 검증 (WebSearch — mismatch면 정정)
4. 출처 src REMOVE + 본문 마커 제거
5. **fact 자체 일반화 (마지막 수단)**

**일반화는 사용 가치를 떨어뜨림**. "삼성전자·SK하이닉스 R&D 채용" → "반도체 산업 채용"으로 일반화하면 정보 손실. 일반화 전 deep page 시도 의무.

---

## 7. minimal POST

**원칙**: 변경된 field만 payload. 미변경 field 미포함.

**왜?**
- 미변경 field 동봉 → 의도치 않은 덮어쓰기 위험 (concurrent edit 충돌)
- payload 크기 증가
- change_summary와 실제 변경 내역 불일치 → audit 추적 어려움

**예외**: changeSummary만 부착하고 fields/sources 둘 다 비어있으면 server side `[minimalPOST]` FAIL. 실제 변경 1건 이상 필수.

**예외 2** (idxGap 호환 — 2026-05-09 충돌 해소): server (`src/routes/job-editor.ts:renumberSourceIds`)가 SOURCE_FIELD_ORDER 기준 글로벌 id 1..N **자동 재할당**. patch 안 보낸 fieldKey의 _sources는 **보존**. 따라서 minimal POST 시:
- 변경 fieldKey만 patch에 포함 (안 보낸 fieldKey는 server가 그대로 둠)
- **patch sources의 id를 1부터 차례대로 부여** (글로벌 id 유지 시도 X — server가 어차피 재정렬)
- validate idxGap은 patch 평탄화 1..N만 검사 → PASS

상세 패턴 + 코드 예시는 `reference/fix-patterns.md` `[idxGap]` 섹션.

---

## 8. DONE/RETRY 포맷 강제

**원칙**: LLM 자가검증 1줄 통과 절대 금지. `audit-via-api.cjs --exclude-sal` 결정적 검증만 진리.

**금지 패턴**:
- "검증 완료" 1줄
- "CLEAN" 라벨만
- self-report 만족도 표시

**의무 패턴**: SKILL.md DONE/RETRY 섹션 참조.

---

## 9. main branch에서만 deploy

**원칙**: cleanup이 코드 변경 동반 시 main 브랜치에서만 deploy. worktree에서 deploy 시 다음 main 배포에서 롤백.

**일반 cleanup/enhance**: DB만 수정 — deploy 불필요. POST API만으로 prod 즉시 반영.

**예외**: 스크립트 수정/도구 추가 등 코드 변경 동반 → 별도 PR로 main 머지 후 `npm run deploy` (main repo에서).

---

## 10. Pre-commit hook 우회 금지

**원칙**: `--no-verify` 절대 X.

**왜?** `scripts/check-secrets.cjs`가 .dev.vars / 비밀키 노출 차단. 우회 시 비밀키 commit 사고.

**hook 실패 시**: 원인 fix → 재 commit. skip은 절대 옵션 X.

---

## 11. subagent fan-out 금지

**원칙**: 본 세션 직접 처리. subagent / Agent fan-out 절대 X.

**왜?** 어제 사고 (2026-04-29 + 본 세션 직전): polling 1줄 → orchestrator dispatch에 status → subagent 75 fan-out → 172M token 폭주.

**polling**: orchestrator가 직접 bash로 처리. session jsonl tail. subagent 띄우지 X.

**예외**: 없음. 직업당 single-job 처리 — 병렬화 시 subagent보다 multiple sessions로 분산 (orchestrator 통제).

---

## 12. 사고 발견 시 즉시 STOP

**원칙**: retry 1회 후도 FAIL이면 STOP + 보고. 자체 판단으로 추가 retry 진행 X.

**STOP 조건**:
- audit-via-api FAIL 2회 연속 (동일 직업, 동일 룰)
- WebFetch 차단 다수 (URL count vs tool_uses 격차 > 50%)
- Phase 0-SYNC main HEAD < `MAIN_HEAD_MIN`
- sal 영역 의도치 않은 접촉 발견 (payload에 sal 키)
- 새 사고 패턴 발견 (기존 룰 매핑 X)
- prod 200이지만 본문 키워드 미반영
- 사용자 명시 STOP / 중단 / 즉시 메시지

→ 즉시 STOP + 사고 보고 (root cause + attempted + blocker). 사용자 결정 받기 전 추가 진행 X.

`feedback_stop_message_priority.md`: "STOP / 중단 / 즉시 / 사용자 결정 변경 키워드 감지 시 즉시 멈춤. 다음 단계 진입 X."

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

## 14. detailReady array 항목 마침표 금지 (룰 X — 2026-05-09)

**원칙**: `detailReady.{curriculum,recruit,training}` array 항목 끝에 마침표(`.`) X. `[N]` 출처 마커가 항목 종결자 역할.

**Why**: array 항목은 한 줄 한 항목 표시 — 마침표는 시각적으로 redundant, [N] 마커가 자연스러운 끝맺음.

**적용**:
- `detailReady.curriculum` / `detailReady.recruit` / `detailReady.training` 항목
- 산문 영역 (way / trivia / overviewWork.main 등) 종결 마침표는 보존 — array만 적용

**잘못 vs 올바른 예**:
```
❌ "사람인·인크루트 등 채용 포털 활용.[1]"
✅ "사람인·인크루트 등 채용 포털 활용 [1]"

❌ "Unity 학습 + C# 프로그래밍 실습.[2]"
✅ "Unity 학습 + C# 프로그래밍 실습 [2]"
```

**현재**: SKILL 명시 룰. validate 자동 검사 X (다음 phase에서 audit gate 추가). cleanup 시 수동 검사 + fix.

상세 fix 절차는 `reference/fix-patterns.md` `[arrayItemPeriod]` 섹션.

---

## 15. 출처 마지막 줄 몰아놓기 금지 (룰 Y — 2026-05-09)

**원칙**: detailReady array N개 항목이 1개 출처에만 통째로 의존하면서 마지막 항목에만 [N] 박는 패턴 금지. **1 항목 = 1 [N] 마커** (그 항목 fact가 그 출처 페이지에 직접 등장 시).

**Why**: 마지막 항목에만 [N] 박으면 사용자가 페이지에서 "[1] 출처가 어떤 항목들을 cover하는지" 파악 불가. 1 출처가 5 항목 cover한다고 표시되지만 실제로는 1 출처가 fact specifically cover 못 함 (decorative source).

**적용**:
- detailReady array — 항목별 fact 추출 → 출처 매핑 1:1
- 5 항목 모두 1 출처에만 의존 + 마지막 항목에만 [N] = FAIL

**fix 옵션 (우선순위 순)**:
1. **출처 더 발굴** — 항목별 deep page WebFetch (선호) — 1 항목 = 1 [N], N 출처
2. **4단계 fallback** — `fix-patterns.md` 4단계 fallback (URL 교체 → 일반화 → merge → 인정)
3. **항목 일반화** — 1 출처 cover 가능한 일반 표현으로 약화 (정보 가치 ↓ — 마지막 수단)

**잘못 vs 올바른 예**: `reference/fix-patterns.md` `[sourcePositionCluster]` 섹션 코드 참조.

**현재**: SKILL 명시 룰. validate 자동 검사 X (다음 phase에서 audit gate 추가). cleanup 시 수동 검사 + 4단계 fallback 적용.

---

## 보호 영역 명시

| 영역 | 정책 | 비고 |
|---|---|---|
| `overviewSalary.sal` (본문) | **절대 X** | sal-protection strict |
| `overviewSalary.wage` (그래프) | **절대 X** | 바 차트 데이터 |
| `overviewSalary.wageSource` | **절대 X** | sal-protection |
| `_sources["overviewSalary.sal"]` | **절대 X** | `[sal-readonly]` strict |
| `careerTree` (기존값) | **절대 X** | 별도 사이클. enhance 모드 신규 작성만 예외 (Phase 3.6) |
| `merged_profile_json.career_tree_*` | DB 직접 INSERT 만 | API 미지원 |
| `detailReady.researchList` | **수정 X** | CareerNet 원본 데이터 |
| `detailReady.certificate` 본문 | enhance 추가 X | sidebarCerts에서만 추천 자격증 보강 |
| `detailIndicators` (지표) | 공식 통계만 | 추정값 절대 X |
| `educationDistribution` (학력) | 공식 통계만 | 추정값 절대 X |

---

## 검증된 진짜 도메인 화이트리스트 (참고)

다음 호스트는 검증된 권위 출처. WebFetch tool_uses ≥ URL 카운트 룰은 그대로 적용하되, root 페이지 또는 WebSearch가 직접 반환한 path는 신뢰성 ↑:

- **정부/통계**: kosis.kr · korea.kr (정책브리핑) · law.go.kr · index.go.kr · data.go.kr · molit.go.kr · mohw.go.kr · moel.go.kr · mafra.go.kr · msit.go.kr · moe.go.kr · customs.go.kr · kdca.go.kr · nfa.go.kr · scourt.go.kr · kipo.go.kr · iros.go.kr
- **공기업/연구원**: kocca.kr · krict.re.kr · kigam.re.kr · etri.re.kr · krri.re.kr · nipa.kr · sw.or.kr · spri.kr · kdata.or.kr · kait.or.kr · krivet.re.kr · kcue.or.kr · kice.re.kr · neti.go.kr · nrf.re.kr
- **학회/협회**: kma.org · surgery.or.kr · kams.or.kr · kafm.or.kr · kpta.co.kr · kdha.or.kr · kdtech.or.kr · kamt.or.kr · krta.or.kr · kao.or.kr · kafa.or.kr · kshpa.or.kr · kashm.org · k-his.or.kr · khima.or.kr · kemco.or.kr · ksgis.or.kr · snak.or.kr · kila.or.kr · kasf.or.kr · kspa.or.kr · kuksiwon.or.kr · q-net.or.kr · license.korcham.net · license.kofia.or.kr · misi.knia.or.kr
- **언론**: hankyung.com · doctorsnews.co.kr · medicaltimes.com · etnews.com · medigatenews.com · bosa.co.kr · journalist.or.kr · madtimes.org · seoul.co.kr · pressian.com · korea.kr · khan.co.kr · pmg.co.kr
- **위키/직업정보**: ko.wikipedia.org · en.wikipedia.org (단 ko가 우선) · namu.wiki (fetch 차단 잦음) · jobkorea.co.kr · saramin.co.kr · wanted.co.kr · job.asamaru.net · adiga.kr · majormap.net · hibrain.net
- **글로벌**: oecd.org · ifr.org · idc.com · hbr.org · mckinsey.com · stackoverflow.co · linuxfoundation.org · cisco.com · cfasociety.org · bis.org · stat.kita.net

---

## 검증 체크리스트 (작업 종료 직전)

- [ ] payload에 `overviewSalary` / `wageSource` 키 0건
- [ ] payload에 `careerTree` 키 0건 (enhance 모드 신규 작성은 wrangler d1 직접)
- [ ] WebFetch tool_uses ≥ new URL count
- [ ] validate-job-edit.cjs PASS (sal-readonly 차단 안 걸림)
- [ ] audit-via-api.cjs --exclude-sal CLEAN (또는 4단계 인정만 잔존)
- [ ] prod GET 200 + 본문 키워드 매칭
- [ ] change_summary `[job-data-master]` 마커 부착
- [ ] DONE/RETRY 형식 출력 (LLM 1줄 자가검증 X)

체크리스트 미통과 항목 1+ → DONE 출력 금지. RETRY 또는 STOP.
