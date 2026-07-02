# 🚨 major master skill spawn STRICT prompt template (v1, 2026-07-02)

dispatcher가 전공(major) 배치 sub-session spawn 시 이 헤더를 prompt 맨 앞에 그대로 prepend.

v1 출생 (job `_dispatch_template_v5.md` 포크 — 설계 진리: `data/cycle/major_cycle_design_v1.md`):
- **v5 구조 그대로 승계**: 5전공-1세션 배치(고정비 amortize + prompt 캐시 재사용), 전공당 순차 POST 체크포인트(idempotent 재spawn 경계), 검증세션 전수 실측. v5 20룰 전부 유지하고 직업→전공 치환 + 전공 특화 룰 21~24 신설.
- **품질 패리티 (Jason 지시)**: 직업 데이터 보완과 동등 수준 — 산문 깊이(문단 서술), deep URL 강제, WebFetch 검증 강제, 각주 양방향 정합 전부 동일 강도. 게이트 수치만 전공 필드 수에 맞게 조정 (totalE≥14 / distinct≥8 — §2 설계서, M0 확정 + trivia 편입 2026-07-02).
- **네임스페이스**: M-cycle (M0=파일럿, M1~M25). 마커 `[major-data-master]`. 직업 R-cycle 자산과 절대 혼용 금지.
- helper: `scripts/major-cycle-helper.cjs` buildBatchPrompt가 아래 ``` 펜스 내부 `# 🚨 STRICT` ~ `# 처리 대상` 구간을 추출 — 헤더 구조 변경 금지.
- 게이트 확정(M0 실측): totalE≥14(trivia 편입 상향) / distinct≥8 / 산문 3필드 300자. 렌더는 `scripts/major-render-gate.cjs`가 결정적 검증.

```
# 🚨 STRICT — 절대 룰 (위반 시 즉시 abort + 보고)

1. **이 세션 할당 전공(아래 "처리 대상" 표의 전공) 외 전공 SELECT/POST/audit 절대 X.**
   - NULL 풀에서 가나다순/카테고리순 다음 전공 자동 SELECT 절대 X.
   - 할당된 표의 전공 전부 처리 끝나면 즉시 종료. 새 cycle / Phase 재진입으로 자동 다른 전공 X.
   - 전공은 **1건씩 순차** 처리 (POST 체크포인트). 다음 전공으로 넘어가기 전 현재 전공을 POST·검증 완료.
   - 🔴 직업(job) 엔티티 접근 절대 X — 본 세션은 major 전용. `/api/job/*` POST·jobs 테이블 수정 금지.

2. **PowerShell 절대 X. Bash 만 사용.**
   - Windows 환경도 Bash (Git Bash, WSL). PowerShell / pwsh / Invoke-RestMethod 호출 X.
   - PreToolUse hook `.claude/hooks/powershell-block.cjs` 가 차단함 — exit 2.

3. **자작 스크립트 X.**
   - `_cycle*.cjs` `_generic*.cjs` `_bulk*.cjs` `_pool*.cjs` `_mass*.cjs` `_force-enhance*.cjs` 등 차단됨.
   - PreToolUse hook `.claude/hooks/cycle-script-block.cjs` 가 차단함 — exit 2.
   - 모든 작업 = `.claude/skills/major-data-master/SKILL.md` Phase 0~7 흐름만.

4. **WebFetch 우회 X.**
   - URL 등록 전 WebFetch 검증 의무. fabricated URL 등록 절대 X. WebFetch tool_uses ≥ 신규 URL 수.
   - distinct URL ≥ 8 (전공 단일 기준 — 직업의 niche/major 구분 없음).

5. **subagent 병렬 X.**
   - 본 sub-session 내부 직렬 처리. fan-out 사고 (75 fan-out / 172M token) 재발 방지.

6. **🔴 보호영역 절대 미접촉 (전공판 sal-protection).**
   - `chartData` / `employmentRate` / `salaryAfterGraduation` (취업률·급여 차트, API 원천)
   - `universities` / `recruitmentStatus` (대학정보 탭, API 원천)
   - `relatedJobs` / `relatedMajors` / `sources`(origin) / `sourceIds` (시스템 생성)
   - `aptitude` / `property` / `careerAct` / `relateSubject` / `mainSubject`(단수형 레거시)
   - fields에도 sources에도 위 키 절대 포함 금지. POST 후 readback에서 보호영역 diff 0 확인.

7. **AskUser X.**
   - 막힘 시 텍스트로 상태 보고 후 abort. user 응답 대기 형태 prompt X.

8. **전공당 처리 후 1줄**: `slug | rev_id | distinct_url | totalE(정확 수치) | audit_status | 마커OK`. 세션 마지막에 `MAJORS DONE: N/N ok` (또는 미완 시 `MAJORS: M/N ok, 미완=<slug 목록 + 사유>`).

9. **🚨 전공 환각 리스크 게이트 (커리큘럼·자격증은 대학별로 다르다)**:
   - 교과목·커리큘럼·자격증·입시 fact는 대학마다 다름 — **"일반적 경향" 서술 강제** ("~대학에 따라 다르나 일반적으로", "다수 대학에서" 등).
   - **특정 대학 fact (특정 학교 커리큘럼·트랙·연계과정) 언급 시 그 대학 `.ac.kr` deep 출처 필수** — 없으면 그 fact 제거 또는 일반화.
   - 특정 자격증 응시자격·시험과목은 시행처 deep 페이지(q-net 등)로 cover — cover 못 하면 일반화.

10. **🚨 URL pool hint 활용 의무 + alternate 발굴 (lazy 포기 X)**:
    - dispatcher가 prepend한 URL pool hint site는 **모두 시도 의무**
    - **대학 `.ac.kr` 학과 페이지 deep이 최우선 pool** — 학과 소개/커리큘럼/진로 페이지 (루트·검색 URL 금지)
    - 1-2 ECONNREFUSED / 404 만나도 즉시 포기 X — 다른 deep page / alternate URL / 타 대학 동일 학과 시도
    - 정부 `.go.kr` deep·학회 `.or.kr` deep·한국 미디어 deep article 등 alternate pool 활용
    - hint 외 추가 발굴도 OK (한국 1차 출처 우선)

11. **🚨 Lazy abort 방지**:
    - 작업 시작 전 "정보 부족할 것 같음" / "scope 비현실적" 자체 판단 → **사전 abort 절대 X**
    - 1차 시도 URL pool 부족 → 즉시 절충 X. **추가 8~10개 site 시도 의무** (동일 학과 개설 대학은 전국 수십 곳 — pool 고갈 변명 성립 어려움).
    - 막힘 발생 시 텍스트 보고 + 해당 전공 skip 가능. 단 **작업 시작 전 / 1차 시도 후 사전 abort 절대 X**.
    - "alternate URL 없음" 결론 전 minimum 10 site 시도 의무.

12. **🚨 산문 3필드 신규 작성 의무 (output-only patch X)**:
    - `whatStudy`(배우는 내용) / `howPrepare`(준비 방법) / `jobProspect`(진로 전망) — **각 300자 이상 문단 수준 산문 + 본문 [N] 각주 필수** (607 전공 전원 현재 공백 — 사실상 전부 신규 작성).
    - 🔴 **각주 [N]은 필드-로컬** — 각 필드에서 [1]부터 (그 필드의 N번째 출처). 서버 _sources 전역 id를 본문에 절대 쓰지 마라 — 템플릿이 필드-로컬→전역 표시번호로 매핑하며, 전역 번호 사용 시 raw `[N]` 텍스트 노출 (M0 렌더 사고 컨벤션 확정).
    - `summary`는 **보강만** (careernet API 원문 존중, 전면 재작성 X) + **`_sources["summary"]` 출처 등록 절대 금지** (careernet canonical — job 룰 25 승계).
    - `mainSubjects` / `enterField` / `licenses`는 기존 API 값 있으면 보강 (기존 항목 삭제 X, 타입 유지 — array는 array로).
    - **출처만 추가하고 본문 안 채우는 minimal patch 절대 금지.**
    - ⚠️ `jobProspect`는 렌더가 `\n` 단위 bullet 분리 — 3~5개 문장 블록으로 `\n` 구분 작성 (한 덩어리 금지).

13. **🚨 Audit 명확화**:
    - `node scripts/skill-cache/audit-major-via-api.cjs <slug>` 의 distinct 부족 WARN 감지 시 **즉시 자기 인지 + 추가 발굴**
    - patch distinct 와 audit count는 1 offset 가능 → **patch 9개 분배 권장 (안전 마진, distinct 9 → audit 8)**
    - audit WARN 무시 X (FAIL 아니라도 distinct 부족 신호 = 즉시 추가 발굴 trigger)
    - audit 통과 (WARN 0 / FAIL 0) 가 완료 조건

14. **🚨 youtubeLinks 영역 omit 금지**:
    - 모든 major enhance patch는 `youtubeLinks` 영역 **의무 포함**:
      a. 적합 한국어 영상 있음 → `youtubeLinks: [{url, title}]` (1~3개, oembed 200 + title 매칭 verify, 한국어만 — 학과 소개·전공 브이로그·교수 인터뷰·진로 특강)
      b. 한국어 영상 부재 → `youtubeLinks: []` + `_youtubeSearchNote` (탐색어 ≥6개 OR 카테고리 ≥3개 / 학과소개·전공소개·커리큘럼·진로·브이로그·인터뷰)
    - validate `[YouTube-영역누락]` FAIL — omit 시 차단됨.

15. **🚨 totalEntries ≥ 14 강제** (M0 확정 + trivia 편입 상향, 2026-07-02):
    - `_sources` 총 entry 수 (모든 fieldKey의 entry 합산) **≥ 14** 필수.
    - distinct URL ≥ 8과 별개로, 본문 [N] 인용 위치 수 자체를 늘리거나 새 출처 항목 추가로 ≥14 달성.
    - minimal patch (totalEntries 변동 없음) 금지.
    - 보강 패턴: (a) distinct URL 추가 (1차) (b) 본문 [N] 마커 추가 인용 (1 URL → 2-3 위치 분산) (c) 산문 3필드 본문 expand + [N] 추가.

16. **🚨 AskUser tool 호출 절대 금지**:
    - 작업 규모 클 거라고 우려 보고 X
    - "단일 응답 안에서 안전한지" 평가 X — 그냥 직진 처리
    - 단일 응답으로 안되면 multi-turn으로 처리하되 AskUser는 절대 X
    - 진행 방식 결정 X — prompt 지시 그대로 따름
    - 위반 시 dispatcher 재지시 받기 전까지 major fail로 간주

17. **🔴 룰 A — POST 전 신규 URL 생존 확인 의무**:
    - POST payload의 **모든 신규 `_sources[].url`을 node fetch (브라우저 UA) 로 생존 확인** 후에만 POST.
    - **404 / 410 / DNS실패(NXDOMAIN) = 사용 금지 → 반드시 교체.**
    - **000 · 403 · timeout · TLS 오류 = 거짓양성 가능 (Windows schannel·anti-bot) — 타 방법으로 재검, 즉시 폐기 X.**
    - 200 · 30x = OK.
    - 🔴 **검색/리스트/세션 URL 금지 (R67 교훈)**: `?q=` / `/jobs?q=` / `_csrf` 파라미터 / 로그인 게이트 stub — 200이어도 정책위반, verify-cycle urlUnverified 검출 대상.
    - **생존 확인은 URL 목록 일괄 1회 node 호출로** (URL당 개별 Bash 호출 금지 — 룰 20 tool-call 경제. WebFetch 내용 검증 의무와는 별개 — 둘 다 수행하되 생존 체크만 일괄화).

18. **🔴 룰 B — 보고 6열 전 칸 의무 + 모호 표기 금지**:
    - 완료 보고는 **6열 모두** 기재: `전공 | rev | distinct | totalE(정확 수치) | CLEAN | 마커OK`.
    - **totalE는 실측 정확 숫자** (`≥12` 부등호 X). `node scripts/major-verify-cycle.cjs --cycle=N` 이 정확 카운트 + 마커 OK 일괄 검증.
    - **"(이전 세션)" / "(기존 처리됨)" 류 모호 표기 절대 금지** — 실측 rev id 기재.
    - **부등호 보고 = 미완료(실결함 신호) 간주** — 부등호로 보고한 전공은 검증 세션 전수 실측 1순위.
    - **동일 전공 재POST가 있었으면 모든 rev id를 보고에 기재** (최종 rev만 기재 금지).

19. **🔴 룰 C — POST 전공당 1회 원칙 + POST 전 셀프 게이트**:
    - **POST 전 distinct·totalE·산문 3필드 300자 셀프 카운트 의무 — 기준 미달 상태로 POST 절대 금지** (보강 완료 후 1회 POST). "일단 POST 하고 패치"는 잉여 rev + 재작업 낭비.
    - **결정적 강제**: validate 호출은 반드시 `node scripts/validate-major-edit.cjs payload.json` — totalE(<14) / 산문 3필드(<300자) / distinct(<8) / 보호영역 접촉 게이트가 FAIL로 차단. 작업자 모델의 자가 카운트 보고와 무관하게 스크립트가 판정.
    - **동일 payload(동일 changeSummary) 반복 POST 금지.** POST 성공(revisionId 반환) 후 같은 전공 재POST는 audit FAIL 수정 시에만, **최대 2회**. 재POST 전 latest rev 확인(이미 반영됐으면 skip).
    - changeSummary는 **top-level** (fields 안에 중첩 금지 — R39 교훈, 중첩 시 마커 미생성 → KPI 탈락).

20. **🔴 룰 D — tool-call 경제 (세션 사망 방지, 배치 모드 특히 중요)**:
    - **32K 출력 한도 대응**: 산문 필드는 필드별 작은 파일 Write → `node -e` 로 payload.json 조립 (payload 통째 1회 Write 금지). 인접 2~3필드를 한 파일에 묶기, 전공당 임시 파일 ~6개 이내(`_tmp_*` prefix, `scripts/skill-cache/` 하위). 과도 세분화 금지.
    - 턴당 출력 2000자·payload 통째 echo 금지.
    - **전공 1건 = POST 전 validate 1회 + POST 1회 + POST 후 audit 1회 + 마커 확인 1회 = 단 1라운드.** 통과 즉시 다음 전공으로(과검증 재조회 루프 금지). FAIL 시에만 해당 전공 재실행(최대 2회, 룰 19).
    - **배치 5전공 누적 tool-call 관리**: 전공당 ~40 tool-call 목표(5전공 ≈ 200 이내). 과검증이 세션 사망 주원인 — 전공당 검증 1라운드 엄수.
    - 한 전공 막히면(10 site 시도 후) 텍스트로 사유 보고 + 그 전공 skip하고 **다음 전공 계속** (세션 전체 abort 금지). 검증세션이 skip분 식별 → 재spawn.

21. **🔴 룰 E (개정 2026-07-02 — Jason 승인) — `trivia`(여담) 작성 의무**:
    - (구 버전의 "전송 금지"는 폐지 — 서버 레거시(trivia 키 → jobProspect 삭제)가 **제거 배포됨**. 이제 전송 안전.)
    - **여담 3~5개 bullet 작성** (직업 페이지 여담과 동일 스타일): 흥미로운 사실·통계·인식 교정 등, 항목별 완결 문장. 개요 탭 마지막 "여담" 섹션에 렌더.
    - 각 항목에 [N] 각주(필드-로컬) + `sources["trivia"]` 등록 — 신규 출처 2~3건, WebFetch 검증 의무 동일.
    - 🔴 **POST 후 readback에서 `jobProspect` 잔존 확인 의무** (레거시 회귀 감지) — 사라졌으면 즉시 abort + 보고.

22. **🔴 룰 F (전공 신설) — `_sources[].text` 한글 제목 필수 (서버 silent fallback 주의)**:
    - major-editor 서버는 `text: text || url` silent fallback — text 누락 시 raw URL이 그대로 사이드바 노출 (job R1 109건 사고 패턴 동일).
    - 모든 `_sources[fk][i].text`는 **"기관명 — 페이지 제목" 형식 한글 제목** (최소 5자 이상 한글). `text === url` / `http` 시작 절대 금지.
    - 본문 [N] ↔ `_sources` 양방향 정합: _sources 등록 fieldKey는 본문 [N] 동반 필수, 본문 [N]은 _sources 범위 내. **한 sentence = 한 마커 max** (`[1][2][3]` 연속 금지 — 다중 출처 시 sentence 분리).

23. **🔴 룰 G (전공 신설) — 필드값 7000자 한도 + 파일 기반 POST**:
    - major-editor 서버가 필드당 7000자 초과 시 400 reject — 산문 3필드 각 300~1500자 권장 범위 내 작성.
    - POST는 **파일 기반 curl만**: `curl -d @payload.json` (인라인 한글 = mojibake hook 차단). 또는 Node fetch + UTF-8.
    - POST 직후 **마커 실존 확인**: page_revisions에서 해당 rev의 change_summary에 `[major-data-master]` 포함 실측 (자가 보고 X).

24. **🔴 룰 H (전공 신설) — 출처 정책 (전공 특화 우선순위 + origin 금지)**:
    - 우선순위: ① 대학 `.ac.kr` 학과 페이지 deep (소개·커리큘럼·진로) → ② 정부 `.go.kr` deep → ③ 학회·협회 `.or.kr` deep → ④ 한국 미디어 deep article → ⑤ ko.wikipedia deep (보조).
    - 🔴 **origin 자기인용 금지 (전공 확장판)**: `career.go.kr` / `work.go.kr` / `wagework.go.kr` / `work24.go.kr` / `job.go.kr` — **majors 데이터 원천 = CAREERNET/WORK24_MAJOR 자기인용 절대 금지**. `careerwiki.org` 자기인용 금지.
    - root URL·검색 URL(`?q=`, `/search`)·리스트 URL·로그인게이트 stub 금지.
    - ⚠️ M0 렌더 잠정 확인 항목: `howPrepare`·`jobProspect` fieldKey는 `__SOURCE_FIELD_MAP__` 헤딩 배지 매핑 미등록 상태 — 출처 리스트에는 표시되나 헤딩 각주 배지 부착이 안 될 수 있음. M0 파일럿 prod 육안 확인 결과에 따름 (그래도 _sources 등록 + 본문 [N]은 의무 — 데이터 정합이 우선).

# 처리 대상 전공 (N전공-1세션 배치)

| # | name | id | slug | URL pool hint |
|---|---|---|---|---|
| 1 | <name> | <id> | <slug> | site1, site2, ... (5+ — 학과 개설 대학 .ac.kr 우선) |
| 2 | ... | ... | ... | ... |

# 처리 절차

`.claude/skills/major-data-master/SKILL.md` Phase 0~7 흐름 따라 표의 전공을 **1건씩 순차** master 적용.
POST endpoint: `https://careerwiki.org/api/major/{id}/edit`  /  인증: `X-Admin-Secret: careerwiki-admin-2026`
페이지 URL: `https://careerwiki.org/major/{slug}` (careerwiki.org 도메인만 — `.kr` / `.com` 절대 X)
전공 1건: 발굴 → 산문 3필드+보강 필드 작성 → URL 생존 일괄 확인(룰 17) → validate(룰 19) → POST → audit+마커 1라운드(룰 20) → 1줄 보고 → 다음 전공.
표의 전공 전부 끝나면 즉시 종료. 자동 다음 cycle 진입 X.
```
