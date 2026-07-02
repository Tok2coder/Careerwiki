# Dispatcher 매뉴얼 — CareerWiki 데이터 보완 cycle (SSOT)

> 🔒 **SSOT 선언 (Jason 승인 2026-07-02)**: 오케스트레이션 **절차의 진리 원본은 이 파일 1곳**이다. CLAUDE.md 🚨섹션·데몬 스킬(master-cycle-dispatch)·persona 요약은 포인터/압축본 — 이 파일과 충돌 시 이 파일이 우선. **상태**(완료 cycle·KPI·max rev)의 진리는 **DB(`--status`)** + dispatcher 메모리 복제본이며, 이 파일에 상태 스냅샷을 적지 않는다 (과거 스냅샷 stale로 R41 중복 재시작 직전·R45 drift 사고).
> **갱신 의무 (5곳→2곳 축소)**: ①cycle 종료 시 상태 2곳 = STORE_MEMORY(영구 메모리) + 복제본 파일(`C:/Users/user/Downloads/memory_replica_careerwiki_*_progress.md`) ②절차·함정 변경 시 이 파일 1곳 + **그 턴 즉시 커밋**.
> 적용 도메인: 직업 **R-cycle** + 전공 **M-cycle** (§M 치환표). 이 파일은 self-contained — 메모리 접근 불가여도 이 파일 + helper `--status`만으로 진행 가능.

## 0. 실행 환경 — wikicomu daemon 도구 매핑 + 실행모델 (R64~R67 실증)

- 배치/검증 세션 = `Agent` 도구(general-purpose, model 명시). **반드시 `run_in_background:false` 명시** — 2.1.195(2026-06-28~)부터 Agent 기본이 async라 background는 메인 turn 종료 시 전멸(R66 5배치 2회 전멸). 한 메시지에 여러 false를 보내면 병렬 완주(FOREGROUND_SYNC_OK). foreground long turn은 heartbeat lease 갱신으로 안 죽음(R64·R65 실증). compaction 위험 시 cycle 청크.
- 세션 재개 = `SendMessage`(agentId). 단 리밋 사망 세션은 재개 불가 — DB 실측 후 미완분만 새 소형 세션(idempotent 가드 명시).
- KPI 실측 = `npx wrangler d1 execute careerwiki-kr --remote --command "..."` (admin.ts 단일진실 쿼리 원문). 한글 입력 회피 — slug 대신 rev 범위 JOIN 필터.
- prod 상태 확인 = **node fetch** (Windows curl은 정상 200도 000/schannel — 000은 5xx 아님). 한글 페이로드 = 파일 기반 `curl -d @file.json`(인라인 금지, mojibake). 32K 출력한도 = payload 통 echo 금지, 필드별 작은 파일 Write→node 조립, 턴당 출력 2000자 이내.
- API 인증: `X-Admin-Secret: careerwiki-admin-2026`, `Content-Type: application/json; charset=utf-8`. edit POST는 prod D1 즉시 기록 — deploy 불필요. id 404면 slug 조회(slug가 진리).
- activity 가시화: helper가 base 이벤트 파일 생성(`{r|m}{N}_activity/`). **cycle 마감 시 dispatcher가 전 유닛(B1..+verify) done을 조건 없이 재emit**(`node scripts/emit-activity.cjs --file <f> --status done --detail "..."`) — 워커 측 emit은 신뢰 불가(BRIDGE_SECRET 부재 silent skip, R50·R51 재발).

## 1. 절대 룰 (사고 실증 — 예외 없음)

1. **sub-session 결과는 완료 확인 후에만 인용.** running 상태 결과를 추측으로 보고 금지 (dispatcher 환각 사고 7~8회).
2. **rev·카운트·완료수·전공/직업명은 helper `--status`/DB 쿼리/[result] 원문에서 복사만.** 추측·기억 채움 금지.
3. **spawn 타임아웃 ≠ 실패** — 실제 미생성 확인 + 사용자 "다시 띄워줘" 후만 1회 재spawn (중복 POST 사고 2회).
4. **cycle "완료" 선언은 검증 PASS + KPI 정확 일치(+예상=직전+N) 후에만.** 부분은 정확히 N/25로만.
5. **KPI 불일치 시 임의 종료 금지** — 차이 건수·해당 entity 규명, 원인 3분류(이번 cycle 결함=수습 / 외부 요인=별도 트랙 / 쿼리 맹점=패치+회귀).
6. **go-gate: 매 cycle Jason go. 자동 연속 금지** (명시 승인 시만 §5 자동연속 패턴).
7. **워커 자가보고 불신** — 슬러그명·"완료" 라벨 신뢰 금지. **명단 entity_id 집합검증(latest=master COUNT=N)이 완료 게이트** (R58 오기재·R59 batch 응답≠landing).
8. **helper A/B 카운트는 사용자 보고에 사용 금지** — admin KPI 쿼리 하나만.
9. URL은 careerwiki.org 도메인만. sal/wage(직업)·보호영역(전공) 미접촉. 명단 밖 entity SELECT/POST/audit 금지.

## 2. ENTRY — cycle 절차 (v5: 준비1 + 배치5(5건/세션) + 검증1)

1. **go 확인** → **preflight 3종 실측**: ①KPI(admin 쿼리) ②max master rev ③기록상 max rev **이후** master rev 존재 여부(25건+이면 그 cycle 이미 완료). 영구 메모리·복제본과 불일치 시 시작 금지, DB 기준 재구성 후 사용자 보고.
2. 준비 Agent(sonnet, fg): `--cycle=N`(helper) 실행 + 명단 name|id|slug 산출만 — 작업·POST 금지.
3. dispatcher가 명단을 배치 프롬프트 표에 직접 삽입(세션이 스스로 찾게 하지 않음) + **{도메인 주의} 작성**: 계열 복붙쌍(배치 간 분리), 동음이의, 분류 후보.
4. B1~B5 Agent(sonnet, **run_in_background:false**, 한 메시지 동시 spawn) — 각 세션 prompt = `{r|m}{N}_prompts/*_B{n}_prompt.md`(STRICT 전문+5건 표). **건당 순차 POST 체크포인트**(idempotent 경계 — 죽어도 완료분 보존).
5. 완료마다 결과 기록 + **의심 포인트 번호 적립**(totalE/class/마커 미보고, 부등호 보고, 최소기준 hugging, 균일값, WARN→INFO 합리화).
6. 검증 Agent(**opus**, fg): `{master|major}-verify-cycle.cjs --cycle=N` 전수 실측 + 의심#n 명시 + 수정 권한 + KPI 쿼리 원문. **검증자도 불신** — 기준 미달 임의 PASS는 §5-C 위반, 수습 세션 추가.
7. 잔여 결함 0 + KPI 정확 일치 → §4 보고 → **종료 갱신 2곳(같은 턴)** → activity done 재emit → 정지(다음 go 대기).

## 3. 수습 패턴 (실증 적립)

- **리밋/세션 사망**: batch 응답 유무가 아니라 **DB landing 실측**(명단 entity_id별 latest=master)으로 미완 식별(R59) → `--resume=N`으로 미완만 재배치(재개 prompt에 POST 전 latest 마커 dup 가드 주입) → 중복 POST 0 (R48·R56·R57·R59 실증). transcript 0바이트 ≠ 미수행 — prod rev 실측으로만 판정(R41). DB created_at은 UTC(KST-9h).
- `--reset-delay="<리밋 메시지>"` → 리셋까지 ScheduleWakeup delaySeconds 계산(1h 초과 시 멀티홉).
- **URL 판별 3분류(R48·R49·R65·R67)**: ①TLS off 200/브라우저 UA 200 = anti-bot 거짓양성(유지) ②루트 생존+페이지 404/soft-404 = 진짜 dead 환각(한국 1차 live로 교체) ③검색리스트(`/jobs?q=`·`/search?`)·`_csrf` 세션·로그인게이트 stub = **정책위반(교체)**. 판별 = dispatcher가 node GET(`rejectUnauthorized:false`, 리다이렉트 추적) + WebFetch 2차 — verify 자가 FAIL/WARN 라벨 불신.
- url-liveness(HEAD)는 soft-404 200 오판 맹점 → node GET+본문검사 backstop(R65).

## 4. 보고 — §6 고정 포맷

한 일 / 결과(N/N, audit, totalE min, distinct, 복붙, URL, origin) / 사고와 수습 / 부작용 없음(baseline 이탈 0, 보호영역 미접촉) / KPI 수치(예상 대비) / 확인 방법(admin URL + prod 페이지 표본 2~3) / "다음 cycle은 go 주면 시작". 보고서 `data/cycle/{R|M}{N}_report.md` 저장.

## §M — 전공 M-cycle 치환표 (설계서: `data/cycle/major_cycle_design_v1.md`)

| 항목 | 직업 R-cycle | 전공 M-cycle |
|---|---|---|
| helper | `scripts/master-cycle-helper.cjs` | `scripts/major-cycle-helper.cjs` |
| 명단 | `master_list_R7_R229.jsonl` (223c/5575) | `major_list_M0_M25.jsonl` (M0 파일럿5 + M1~M25, 607전공) |
| 템플릿 | `_dispatch_template_v5.md` | `_major_dispatch_template_v1.md` |
| 작업 스킬 | job-data-master | major-data-master |
| 게이트 3종 | validate-job-edit / audit-via-api / master-verify-cycle | validate-major-edit / audit-major-via-api / major-verify-cycle |
| 마커 | `[job-data-master]`(+legacy enhance) | `[major-data-master]` (legacy 없음) |
| API·페이지 | /api/job/{id}/edit · /job/{slug} | /api/major/{id}/edit · /major/{slug} |
| KPI | admin job-equalize (tab=job) | admin job-equalize?tab=major (동일 CTE, entity_type='major') |
| 게이트 수치 | totalE≥19 · distinct 18(major)/10(niche) | totalE≥12 · distinct≥8 단일 + 산문3필드(whatStudy/howPrepare/jobProspect) 각≥300자 — **M0 후 확정** |
| 보호영역 | sal/wage · careerTree | chartData·employmentRate·salaryAfterGraduation·universities·recruitmentStatus (+relatedJobs/relatedMajors/sources/sourceIds/aptitude/property/careerAct/relateSubject/mainSubject) |
| 특화 함정 | abilityList 타입·way string | 🔴 **trivia 전송 절대 금지**(major-editor.ts:551·652 레거시 — patch에 trivia 키 있으면 서버가 jobProspect 삭제) · **summary=canonical**(보강 허용·출처 등록 금지) · edit-data API가 howPrepare/jobProspect 미노출 → 감사는 GET 2개 병용(audit-major-via-api 반영됨) · _sources id는 max+1 연속 부여(재POST 최소화) |
| 분류 | major/niche 이원 | 단일 티어 + **환각 게이트**: 대학별 상이 fact(커리큘럼·입결)는 "일반적 경향" 서술 강제, 특정 대학 fact는 해당 .ac.kr deep 출처 필수 |
| 출처 우선순위 | .go.kr/.or.kr/.co.kr deep | **.ac.kr 학과 페이지 deep 최우선** → .go.kr deep(origin 금지: career/work/work24/wagework/job.go.kr + CAREERNET/WORK24 자기인용) → 학회 .or.kr → 한국 미디어 deep |
| M0 파일럿 | — | 정식 cycle 전 필수: API first-blood(실사용 0)·merge 반영·각주 실렌더·KPI +5 일치·보호영역 diff 0·게이트 수치 확정 (설계서 §7) |

## 5. 자동연속 운영 (Jason 명시 승인 시만 — R59~R61 적립)

각 cycle 완료 통지 시 한 턴에: ①독립 KPI 재실측 + 집합검증 + prod 표본 ②§4 보고 ③종료 갱신 2곳 ④즉시 다음 preflight+명단+spawn 연쇄. 승인 범위 마지막 cycle 후 go-gate 복원. 리밋 재발 시 DB landing→`--resume`.

## 6. per-spawn 사전 분류·URL pool (직업 R 전용)

- **industry_class**: major(default — 금융·IT·법조·항공·의료·교육·건설 등 광범위 산업, distinct≥18 강제) / niche(단일 회사·공장·공정·폐지 자격증, distinct 6+ 허용). 모호 시 major. minor 분류는 폐지(R45).
- **URL pool hint 5+ site**: 산업별 default pool 표는 helper가 프롬프트에 자동 주입(hint 구체화 d08a704). 주요 pool: 금융=fss/fsc/kafa, IT=kisa/pipc/nia, 의료=mohw/kma/koreanurse, 교육=moe/kice/kedi, 건설=molit/kict, 식품=mfds/kfia, 에너지=kepco/khnp, 반도체=ksia, 농축산=rda/mafra, 안전=kosha/moel + 각 위키. 추가 발굴은 세션 몫.
- 사전 분류 누락 = lazy abort 사고 재발 위험(Rpri1_B3).

## 7. 함정·사고 적립 아카이브 (요약 — 상세는 git log)

- **2026-05-24~25**: 자작 cycle 스크립트(hook 차단)·자동 cycle 위반(60+ 침범→unmark)·PowerShell(hook 차단)·lazy abort(분류 룰 강화).
- **2026-05-29 R12/13**: running 추측 보고 재발 → 절대 룰 1~6 성문화.
- **R39**: changeSummary fields 중첩 → 무마커 rev KPI 탈락. top-level 필수 + POST 후 마커 실존 확인.
- **R41**: 종료 갱신 누락→중복 재시작 직전. URL 생존 게이트 신설(urlDead/urlUnverified). totalE=18 hugging 적발.
- **R42~R45**: 계정 리밋 동시 사망 수습 정착(DB 실측→잔여만 재개, 중복0). 부등호 보고=실결함. v4 1직업-1세션 실험.
- **R46**: v4 토큰 회귀 발각(2.88M) → **v5 배치 복원(Jason 2026-06-13)**. KPI 쿼리 함정(jobs에 unified_career_json 없음 — marker+sidebar-fill skip CTE가 진리).
- **R47~R57**: v5 안정(709K, ~75%↓). R48 리밋 2단 재개. R49 namu.wiki 환각 URL 수습(node fetch 판별 정착). R55 환각 47건 backstop. R56~57 `--resume` 정착. go-gate 복원(2026-06-14).
- **R58~R61**: 집합검증 상시화(오기재 적발). DB landing≠batch 응답(R59). 유사직군 복붙 게이트(Jaccard). verify class 라벨 부정확(배치 보고가 진리).
- **R62~R66**: 실행모델 전환 — background 전멸→**foreground run_in_background:false**(2.1.195 async 기본). R66 abilityList='' 500 hotfix(bd4625f)+타입게이트. (abilityList="" 21건 정합성 후속 미착수)
- **R67**: B3 Overloaded 사망→DB landing 24/25 확정→1건만 재spawn(중복0). urlUnverified 중 검색URL/`_csrf`/로그인게이트 = 정책위반 판별·교체 룰.
- **2026-07-02 (M-cycle 빌드)**: 전공 607 전원 UCJ NULL·산문 전량 공백 실측. major edit API 실사용 0 → M0 first-blood 필수. trivia→jobProspect 삭제 레거시 발견(룰로 차단). howPrepare 렌더 부재 발견→렌더 추가. SSOT 정리(이 파일 승격, 갱신 5곳→2곳).
