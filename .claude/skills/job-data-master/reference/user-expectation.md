# 사용자가 기대할 수 있는 것 — `/job-data-master <slug>` 호출 시

> 본 스킬을 호출했을 때 무슨 일이 일어나는지, 결과물·비용·안전 영역·검증 방법을 풀어서 설명한다.

---

## 입력 → 출력 한 줄 요약

```
/job-data-master <slug>           # 직업 데이터 진단·보완·정리·검증 자동 실행
                                  # 직업 상태에 따라 enhance / cleanup / idle 자동 분기
```

---

## 시나리오 3종 (자동 분기)

### 1. 신규 직업 (마커 미보유) — ENHANCE 모드 풀 사이클

**대상**: page_revisions에 `[job-data-master]` 또는 `[job-data-enhance]` 마커가 없는 활성 직업.

**무슨 일이 일어나나**:
- Phase 0: 12 필드 진단 (way / detailReady / trivia / wlbDetail / sidebar / heroTags / youtubeLinks / careerTree)
- Phase 1: 1차 출처 발굴 (정부/협회/학회 deep page) + WebSearch 광범위 리서치
- Phase 2: 12 필드 작성 + 17필드 self-report 체크리스트
- Phase 3: validate-job-edit.cjs PASS 후 minimal POST
- Phase 4: change_summary `[job-data-master] enhance — way·trivia·...`
- Phase 5: audit-via-api CLEAN + prod 200 + 본문 키워드 매칭
- Phase 6: careerTree 신규 작성 (한국인 공인 1~3명, wrangler d1 직접 INSERT)

**결과물**:
- DB rev +1
- 본문 12 필드 신규 작성 (출처 [N] 포함)
- _sources[fieldKey] 등록 (1차 출처 + WebFetch verify)
- careerTree 신규 (인물 1~3명, 적합 인물 부재 시 null + `_careerTreeNote`)
- sidebar 4종 보강 (Cert/Org/Major/Job)

**비용 추정**:
- ~50K~80K tokens / 직업
- ~10~15분 (병렬 5세션 시 5직업 동시 = ~10분 wall-clock)

### 2. 이미 enhance + audit FAIL — CLEANUP 모드 (+ 산문 영역 보강 / fact 정정)

**대상**: 마커 보유 직업이지만 audit-via-api FAIL 1건+.

**무슨 일이 일어나나**:
- Phase 0: skip (진단 X — 이미 enhance 완료)
- Phase 1: audit-via-api 실행 → FAIL flag 파싱 (rootURL / origin / listPage / wikiQuota / sidebarSources / arrayBrokenRef / orderViolation / proseBodyOrphan 등)
- Phase 1-B (NEW): 본문 fact 정확성 사전 검증 (WebSearch cross-check) — mismatch 검출 시 fact 정정 작업도 포함
- Phase 2: 영역 분류 (산문 / detailReady array / sidebar) → 룰별 fix 패턴 결정 + 4단계 fallback
- Phase 3: minimal payload (변경 영역만)
- Phase 4: validate PASS
- Phase 5: POST + change_summary `[job-data-master] cleanup — rootURL=2→0, ...`
- Phase 6: audit-via-api 재실행 → CLEAN (또는 4단계 인정만 잔존)

**결과물**:
- DB rev +1
- 출처 정리 (rootURL deep page 교체 / origin 제거 / sidebarSources DELETE / wikiQuota wiki src 일부 REMOVE 등)
- 본문 fact 정정 (NEW, mismatch 발견 시 — 예: 방사선사 0.6 → 0.82 mSv)
- 산문 영역 [N] 마커 정합화 (proseBodyOrphan)
- 본문 fact 보존 (단, 4단계 fallback의 일반화는 마지막 수단)

**비용 추정**:
- ~10K~30K tokens / 직업 (cleanup 단순 / 4단계 fallback 깊이 따라)
- ~3~8분

### 3. 이미 enhance + audit CLEAN — IDLE

**대상**: 마커 보유 + audit-via-api CLEAN.

**무슨 일이 일어나나**:
- Phase 1까지 진행 (audit 1회) → CLEAN 확인 → DONE 즉시
- 본문 / 출처 / 마커 어떤 것도 변경 X

**결과물**:
- DB rev 무변경 (작업 자체 X)
- DONE 보고 1줄

**비용 추정**:
- ~3K~5K tokens / 직업 (audit 1회)
- ~30초~1분

### 4. force re-do (`--force-enhance`) — quality 재처리 (2026-05-09 신규)

**대상**: audit CLEAN이지만 quality 부족 — cluster 패턴 / 출처 0 / 옛 룰 박힌 데이터 retroactive 보강.

**진입 신호**:
- `/job-data-master <slug> --force-enhance` 명시 flag
- 또는 prompt에 "force re-do" / "재처리" / "quality 회복" / "enhance 강제"
- 또는 audit `arrayItemPeriod(N)` / `sourcePositionCluster(N)` WARN 검출 + quality 회복 요청

**무슨 일이 일어나나**:
- Phase 0-A 자동 분기 skip — ENHANCE 모드 직진 (Phase 1.5)
- 기존 데이터 조사 (12 필드 진단) → cluster / 마침표 / 출처 0 항목 식별
- 보강 대상 항목별 deep URL 발굴 (WebFetch verify)
- 1:1 출처 매핑 + 마침표 제거 + 항목 [N] 정합 + 출처 N개 보강
- POST → audit 재검증 → CLEAN

**결과물**:
- DB rev 1건 변경 (`[job-data-master] enhance — force-enhance: detailReady·sources`)
- detailReady 항목별 [N] 마커 1:1 매핑
- _sources 부족분 deep URL 보강 (WebFetch verified)
- 마침표 제거 + cluster 해소
- 보호 영역 (sal/careerTree) 미접촉

**비용 추정**:
- 항목당 1 deep URL 발굴 = WebFetch 1회 + WebSearch 0.5회
- 직업당 평균 9-12 항목 — WebFetch ~10회, WebSearch ~5회
- 토큰 ~50K-100K / 직업
- ~5-10분 / 직업 (sequential)

**use case 예시** (2026-05-09 5 직업 발견 경위):
- 가구조립원 / 가축사육종사원 / 가구조립-및-검사원: 1 출처 + 3-4 항목 + 마지막에만 [N] cluster → force-enhance로 1:1 매핑 회복
- 감정평가사 / 경찰관: detailReady 출처 0개 → force-enhance로 출처 N개 발굴

**일반 ENHANCE 모드와 차이**:
- 마커 이미 보유 (재 enhance) — change_summary `force-enhance:` 접두
- careerTree 신규 작성 X — 기존 careerTree 보존 (force-enhance는 데이터 보강 한정)
- Self-Report 17필드 풀 체크 X — 보강 영역만 부분 체크리스트
- 보호 영역 (sal/careerTree) 더욱 엄격

---

## 절대 안 건드리는 것 (보호 영역)

| 영역 | 정책 | 이유 |
|---|---|---|
| `overviewSalary.sal` (본문) | **절대 X** | sal-protection strict (사용자 명시 룰) |
| `overviewSalary.wage` (그래프) | **절대 X** | 바 차트 데이터 |
| `overviewSalary.wageSource` | **절대 X** | sal 영역 |
| `_sources["overviewSalary.sal"]` | **절대 X** | `[sal-readonly]` strict |
| `careerTree` (기존값) | **절대 X** | 별도 사이클 (수정/삭제 금지). enhance 모드 신규 작성만 예외 |
| `detailReady.researchList` | **수정 X** | CareerNet 원본 |
| sidebar 본문 항목 자체 | **수정 X** | sidebar `_sources` 정리 시 항목 미접촉 |
| 기존 본문 fact (정확하면) | **수정 X** | 출처 정리만, 본문 보존. (단 fact verification mismatch면 정정) |

---

## 사고 시 어떻게 알 수 있는지 (RETRY 형식)

작업 실패 시 DONE 대신 RETRY 출력:

```
RETRY: 게임-기획자 root cause: rootURL(6) detailReady array 영역
attempted: 1단계 deep page 시도 (kgames.or.kr/kr/about/index.php)
blocker: 본문 fact "컴퓨터공학·게임학과 진학" cover 못 함 + deep URL hallucination 위험
next: 4단계 인정 + memory deck/04-pending.md 기록 (다음 사이클 재시도)
```

**즉시 STOP 조건**:
- audit-via-api FAIL 2회 연속 (동일 룰)
- WebFetch 차단 다수 (URL count vs tool_uses 격차 > 50%)
- Phase 0-SYNC main HEAD < `MAIN_HEAD_MIN`
- sal 영역 의도치 않은 접촉 발견
- 새 사고 패턴 발견 (기존 룰 매핑 X)
- prod 200이지만 본문 키워드 미반영

→ 즉시 STOP + 보고. 사용자 결정 받기 전 추가 진행 X.

---

## 사용자가 직접 검증 가능한 것

### 1. prod URL fetch + 본문 키워드 매칭

```bash
curl -s "https://careerwiki.org/job/<slug>" | grep -o "변경 키워드"
```

HTTP 200 + 본문 키워드 등장 = 정상 반영.

### 2. DB rev 확인

```sql
SELECT id, change_summary, created_at FROM page_revisions
WHERE entity_type='job' AND entity_id=CAST(? AS TEXT)
ORDER BY id DESC LIMIT 5;
```

`change_summary`에 `[job-data-master]` 마커 + 변경 요약.

### 3. audit 명령

```bash
node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal
```

`OK <slug> clean` 또는 `FAIL <slug> 룰명(N)` 출력.

### 4. validate 명령 (payload 검증)

```bash
node scripts/validate-job-edit.cjs payload.json
```

errors 0 + warnings 모두 의도된 것 확인.

### 5. 수동 spot-check

prod 페이지에서 다음 확인:
- 출처 섹션 [N] 마커가 본문 [N]과 매핑되는지
- sidebar 항목 url click 시 deep page로 이동하는지
- youtubeLinks 영상 썸네일 + 한국어 제목 표시되는지
- careerTree 인물이 한국인 공인이고 추정/소문 X인지
- 본문 통계/숫자가 출처 페이지에 직접 등장하는지 (fact verification)

---

## 배치 처리 (332+ 직업)

```
/job-data-master 슬러그1 슬러그2 슬러그3 ...
```

또는 dispatch builder 활용 (별도):
```bash
node scripts/skill-cache/build-cycle-v3.cjs --slugs=A,B,C,D,E --sessions=5
```

**비용 추정**:
- 신규 enhance 332 직업: ~32M tokens / ~7~8시간 (5세션 병렬)
- cleanup 만 332 직업: ~10M tokens / ~2~3시간
- 단일 세션은 5x 시간 소요

각 직업당 DONE/RETRY 출력 + 배치 종료 시 Summary:

```
=== Batch Result ===
DONE 5/5
- 가수 rev=14270 mode=cleanup audit=CLEAN
- 가축사육자 rev=14264 mode=cleanup audit=CLEAN
- ...
```

---

## 자주 묻는 질문 (FAQ)

### Q. 임금 정보가 부정확하면?

A. master 스킬은 sal 영역 **절대 손대지 X** (사용자 명시 룰). 별도 sal 정비 사이클 (현재 미설계) 필요. audit는 `--exclude-sal` 옵션으로 sal 검증 skip — sal에 root URL이나 origin 잔존해도 audit PASS로 본다 (의도된 trade-off).

### Q. careerTree 인물이 잘못된 경우?

A. master 스킬은 기존 careerTree **절대 손대지 X**. 별도 careerTree 정비 사이클 필요. enhance 모드의 신규 careerTree 생성 (인물 0명 → 1~3명 추가)만 예외.

### Q. audit FAIL 1건 잔존해도 DONE이라고 하나?

A. **4단계 fallback의 인정+pending 케이스**만 잔존 허용. 그 외 FAIL은 RETRY 또는 STOP. 인정 케이스는 `memory/deck/04-pending.md`에 직업명 + 룰 + 잔존 finding 기록 + 사용자에게 명시 보고 (다음 사이클 또는 별도 enhance 사이클로 이관).

### Q. 본문 fact를 정정하면 의도와 다를 수 있는데?

A. fact verification은 **WebSearch + WebFetch evidence 의무**. 정정된 값이 출처 페이지에 직접 등장하는지 확인 후만 적용. mismatch 발견 시 정정 + 새 출처 등록 + change_summary에 명시 (`factCorrected=N`). 사용자가 검증 가능.

### Q. 산문 영역 [N] 마커가 본문 0개인데 _sources만 등록된 경우?

A. **proseBodyOrphan** (PR 14 활성화) 검출 → cleanup 모드 fix:
1. 본문 fact가 src URL을 cover하면 본문 [N] 추가
2. 의미 없으면 src REMOVE

### Q. 빈 trivia + sidebarOrgs URL 부재 등 미보강 상태인데?

A. enhance 모드라면 12 필드 모두 작성 시도. cleanup 모드라면 미보강 영역 손대지 X (별도 enhance 사이클 필요). 본 스킬은 audit FAIL 영역만 fix.

### Q. 검증 못 한 URL을 _sources에 박는 사고?

A. **WebFetch 강제** 룰 1 — 신규 URL 등록 *전* WebFetch tool_use ≥ 1회. tool_uses < new URL count → 작업 무효. RETRY. 사용자 보고. hallucinated 도메인 블랙리스트 (kgta / k-lpn / kpba 등) 별도 차단.

---

## 기존 두 스킬과의 차이 (job-data-enhance / job-data-cleanup)

| 항목 | enhance 스킬 | cleanup 스킬 | **master 스킬** (NEW) |
|---|---|---|---|
| 진입 모드 | 풀 사이클 강제 (12 필드) | cleanup 만 (FAIL fix) | **자동 분기** (enhance / cleanup / idle) |
| audit 시점 | Phase 5 (사후) | Phase 1 (사전) | **Phase 1** (사전 + 모드 결정) |
| 산문 영역 audit | validate Gate만 | audit-via-api 미작동 (PR 14 전) | **PR 14 활성화** (proseBodyOrphan 검출) |
| fact verification | 부분 (Phase 4-SRC-FACT) | X | **NEW (Phase 1-B WebSearch cross-check)** |
| sal-protection | 강제 | 강제 | **강제** (변동 X) |
| careerTree | 신규 작성 (Phase 3.6) | X (보호) | **enhance 모드만 신규**, cleanup은 보호 |
| 단일 entry point | X (cleanup과 분리) | X | **✅** |
| 배치 처리 | 가능 | 가능 | **가능** (자동 분기 통합) |

기존 두 스킬은 `.claude/skills/_archive/job-data-enhance/` + `.claude/skills/_archive/job-data-cleanup/`에 archive 보존. 새 작업은 본 스킬만 사용.

---

## 한눈에 (10 lines)

1. `/job-data-master <slug>` 호출 → 직업 상태 자동 판정
2. 마커 미보유 + active → ENHANCE (12 필드 신규 작성, ~50K tokens)
3. 마커 보유 + audit FAIL → CLEANUP (출처 정리 + fact 정정, ~20K tokens)
4. 마커 보유 + audit CLEAN → IDLE (DONE 즉시, ~3K tokens)
5. **절대 안 건드림**: sal 영역 / careerTree 기존값 / sidebar 본문 항목
6. **신규 fact verification**: WebSearch cross-check, mismatch면 정정 + 출처
7. **산문 영역 audit 활성화** (PR 14): orphanSrc / brokenRef / dup 9 필드 검사
8. 사고 시 RETRY 형식으로 보고 — 자가 "DONE" 1줄 X
9. 검증: prod URL fetch / DB rev / audit 명령 / spot-check
10. 배치 처리 가능, 사용자 명시 STOP / 사고 시 즉시 멈춤
