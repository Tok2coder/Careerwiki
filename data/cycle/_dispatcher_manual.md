# Dispatcher 매뉴얼 — CareerWiki 직업 보완 cycle 진행

2026-05-25 신규 (per-spawn 4 step) / 2026-05-29 보강 (entry-point 6 step + helper script 연결).

> 📌 **이 파일은 self-contained** — 메모리 시스템 접근 불가해도 이 파일 + helper script만으로 진행 가능. (2026-05-28 새 세션이 메모리 못 읽어 작업 못 찾은 사고 후속)

## 📊 현재 진행 상태 (스냅샷 — 라이브 진리값은 `--status`)

- 마지막 완료: **R24** (25/25, 끝=광통신연구원, rev 17039~17105, sonnet+정정) — detailReady 9직업 opus 정정완료, 하네스 강화 커밋 bfc1dcf·6c87d17. distinct<18 1건(광점퍼코드조립원 10, niche)
- **다음: R25** (시작=광트랜시버모듈개발자) — `--cycle=25`로 batch/prompt 생성
- 누적 master: A=1016(전체 마커) / B=947(enhance 풀 사이클) — 2026-05-31 **예상치(미확정)**: R16~R24 **9 cycle 연속 wrangler 토큰 만료로 DB 직접 쿼리 미검증**, R15 확정값(791/722)+225 추정. 토큰 복구 후 일괄 재검증 필요
- master_list: `data/cycle/master_list_R7_R229.jsonl` (223 cycle / 5575 직업, R7~R229 사전할당)

> ⚠️ 위 숫자는 스냅샷. **항상 `node scripts/master-cycle-helper.cjs --status` 로 라이브 확인** (DB 진리값 — 마지막 cycle/다음 cycle 자동 탐지).
> ⚠️ **wrangler 토큰 만료 주의 (2026-05-30 발생)**: `wrangler d1 execute` / `whoami`가 `Authentication error 10000` / `Max auth failures 9109`로 실패. A/B DB 카운트 검증 막힘. 재개 전 `wrangler login` 또는 `CLOUDFLARE_API_TOKEN` 갱신 필요. (audit-via-api / prod fetch는 공개 API라 토큰 없이 동작)

---

# ⚠️ 절대 룰 — sub-session 결과 인용·완료 판정 (2026-05-29 사고 재발방지)

> 2026-05-29 R12/R13 dispatch 중 sub-session이 "전부 완료"를 반복 보고했으나 DB 실측은 매번 미달(5/25→20/25→25/25, 1/25→14/25→21/25→23/25). running 상태 결과 인용 + 추측 rev/카운트 + 가짜 session_id + 타임아웃 오판 + 부분완료 보고가 원인. 아래는 예외 없이 강제.

1. **sub-session 결과는 `idle` / `[result]` 확인 후에만 인용.** `running` 상태 세션의 결과를 완료로 보고 금지.
2. **rev·카운트·완료수·직업명은 `master-cycle-helper.cjs --status` / DB 쿼리 / `[result]` 원문에서 복사만.** 추측·기억으로 채우기 절대 금지.
3. **session_id는 `start_code_task` 반환값 또는 `list_sessions`에서만 취득.** 손으로 만들거나 추정 금지.
4. **`start_code_task` 타임아웃 ≠ 실패.** 타임아웃이 떠도 세션은 생성됨. 재시도 전 반드시 `list_sessions`로 실제 생성·중복 확인. 같은 제목 2개+면 즉시 중복 → 잉여 세션 STOP.
5. **소규모 후속 작업은 기존 `idle` 세션에 `send_message`로 지시** — 새 `start_code_task`보다 타임아웃·중복 회피.
6. **cycle "완료"는 helper `--status`가 25/25일 때만.** 부분(N/25) 상태를 "완료"로 보고 금지 — 정확히 `N/25`로만 표기.

---

# ⭐ ENTRY POINT — 사용자 prompt → 6 step action

## 트리거 키워드

사용자가 다음과 같이 말하면 본 흐름 진입:
- "현재 직업 보완 현황 확인하고 master 스킬 사용해서 배치 이어서 진행해줘"
- "다음 cycle 진행", "R{N} 진행", "배치 이어서", "직업 데이터 보완 이어가"
- "cycle 돌려", "master 배치 진행"

## Step 1 — 현황 파악 (메모리 의존 X)

먼저 `node scripts/master-cycle-helper.cjs --status` 실행 (Step 2와 동일 — 라이브 DB 진리값). 보조로 메모리 접근되면 읽되, **없어도 됨**:
```
(보조, optional) agent/memory/project_careerwiki_cycle_progress.md   (dispatcher 메모리 — 자동 inject 안 될 수 있음)
```

여기서 파악: 마지막 완료 cycle (예: R11), 다음 시작 위치 (예: R12=검표원·게임 series), 누적 master 카운트 (A 정의 679), 잔존 부실 직업, 자산 경로.

병행 reference: `agent/memory/reference_careerwiki_cycle_assets.md` (모든 자산 path).

## Step 2 — 현황 DB 검증 (drift 체크)

```bash
node scripts/master-cycle-helper.cjs --status
```

출력: A (모든 master 마커, 메모리 정의) + B (enhance 풀 사이클만). A 값을 메모리 "누적 진행" 표와 비교. drift 있으면 메모리 먼저 갱신.

## Step 3 — 다음 cycle batch 준비 (helper 자동 생성)

```bash
# 자동 (미처리 다음 cycle 결정):
node scripts/master-cycle-helper.cjs --next-cycle
# 또는 명시:
node scripts/master-cycle-helper.cjs --cycle=12
```

생성물 (**v5, 2026-06-13 — 5직업-1세션 배치 복원**, Jason 결정. v4 1직업-1세션은 토큰 회귀로 폐기):
- `data/cycle/R{N}_queue.txt` (배치 큐 — B1~B5 × 5직업 enqueue 순서)
- `data/cycle/r{N}_prompts/R{N}_B{1..5}_prompt.md` (STRICT 20룰 + 5직업 표 + 보고형식 — `_dispatch_template_v5.md` single source 자동 prepend)
- stdout: 5 배치 spawn 명령(일괄 투입 안내) + cross-check 경고 (이미 처리된 직업 있으면 표시)

## Step 4 — sub-session spawn (5직업-1세션 × 5 배치, 전량 일괄 enqueue)

helper stdout의 명령대로 **5개 배치 세션을 한 번에 작업큐에 투입**한다(Agent bg ×5 또는 Workflow parallel 권장). 데몬 워커풀(동시성 7)이 슬롯 비는 대로 연속 처리:
```
session B1~B5: data/cycle/r{N}_prompts/R{N}_B{n}_prompt.md 내용 → prompt (5개 동시 enqueue)
```

🟢 **활동 가시화 (옵션 A, wave 단위 — Jason 확정 2026-06-14)**: helper가 `data/cycle/r{N}_activity/b{1..5}.json` + `verify.json` base 이벤트 파일을 자동 생성하고, 각 배치 prompt 맨 앞에 STEP0(running)/STEP_LAST(done) emit 명령을 박는다. 따라서 **각 배치 세션이 시작/종료 시 스스로 emit** → 대시보드 '세부 작업'에 B1~B5가 개별 행으로 실시간 표시(같은 group_key `cycle-R{N}-{date}`로 한 그룹 묶임). 검증 세션은 spawn 시 prompt에 아래 2줄을 직접 포함시킬 것(검증=6번째 유닛):
```bash
# 검증 세션 prompt 안에 포함 (시작 시 / 종료 시)
node scripts/emit-activity.cjs --file data/cycle/r{N}_activity/verify.json --status running
node scripts/emit-activity.cjs --file data/cycle/r{N}_activity/verify.json --status done --detail "25/25 PASS, KPI {n}"
```

⚠️ **세션당 직업 5건, 1건씩 순차 POST 체크포인트** (Jason 결정 2026-06-13 v5 배치 복원 — v4 1직업-1세션은 cycle당 고정비 ~5배·prompt 캐시 파괴로 토큰 회귀, R46 enhance 2.88M 실측). 폭발반경은 직업당 POST 체크포인트(완료분 prod 보존) + 검증세션 미완분 식별 → idempotent 재spawn으로 수습. 품질 게이트 불변.
⚠️ **검증 세션 모델 = sonnet** (Jason 결정 2026-06-11, opus→sonnet 전환. 전제 = 모델 무관 결정적 게이트: validate pre-POST FAIL 3종(237ec3b) + `master-verify-cycle.cjs` 전수 실측. 작업자≠검증자 세션 분리 원칙 유지).
spawn 시 per-spawn 4 step (아래 섹션) 준수 — 단, helper가 prompt를 이미 생성했으면 industry_class는 sub-agent 자체 분류로 위임됨 (helper placeholder).

## Step 5 — 결과 수집 + 통합 보고

5 batch 완료 후:
```bash
# rev 수집
npx wrangler d1 execute careerwiki-kr --remote --command "SELECT j.slug, MAX(pr.id) rev FROM page_revisions pr JOIN jobs j ON CAST(j.id AS TEXT)=pr.entity_id WHERE pr.entity_type='job' AND pr.change_summary LIKE '%[job-data-master]%enhance%' AND j.slug IN (...25 slug...) GROUP BY j.slug;"
# audit
for s in <25 slug>; do node scripts/skill-cache/audit-via-api.cjs "$s" --exclude-sal; done
# youtubeLinks 게이트 통과 확인 (룰 14)
```

**활동행(대시보드) done 재emit — cycle 마감 필수·무조건 실행** (2026-06-15 R50 B4 / 2026-06-18 R51 6유닛 재발): 워커 측 STEP_LAST emit은 **신뢰 불가**. ① 워커가 'BRIDGE_SECRET 없으면 무해'라며 자의 생략 ② **Agent 도구로 띄운 서브에이전트는 BRIDGE_SECRET이 env에 없어 emit이 silent skip**(daemon 워커풀과 달리) → 워커가 "emit done" 보고해도 대시보드엔 안 닿아 행이 `running`에 영구 멈춤. base 파일 `data/cycle/r{N}_activity/*.json`은 항상 `status:running` 고정(파일만 봐선 모름). **따라서 dispatcher가 cycle 마감 때 6유닛(B1~B5+verify) done을 조건 없이 전부 재emit**(idempotent upsert이라 워커가 이미 done 보냈어도 무해):
```bash
for X in b1 b2 b3 b4 b5; do node scripts/emit-activity.cjs --file data/cycle/r{N}_activity/$X.json --status done --detail "5/5 done"; done
node scripts/emit-activity.cjs --file data/cycle/r{N}_activity/verify.json --status done --detail "25/25 PASS, KPI {n}"
```
(BRIDGE_SECRET·DAEMON_ID·BRIDGE_BASE_URL은 dispatcher 환경에 set돼 있어 재emit 가능. 각 200 `{"ok":true,"written":1}` 확인.)

보고 형식 (사용자에게): KPI before/after (A 카운트) + 25 직업 표 (slug | rev | distinct | totalE | audit | class) + 25 `careerwiki.org/job/{slug}` 링크 + 누적 진행. `data/cycle/R{N}_report.md` 저장.

## Step 6 — 메모리 갱신 + 사용자 ping (자동 진입 X)

1. **메모리 갱신 의무**: `agent/memory/project_careerwiki_cycle_progress.md` 의 "누적 진행" 표 + "사이클 완료 history" 표에 이번 cycle row 추가 (Edit 도구). 누적 카운트 갱신.
2. **자동 다음 cycle 진입 절대 X** — 사용자 ping 받아 R{N+1} 결정 (무한 cycle 금지, 메모리 `feedback_auto_cycle_generic_script.md`).

---

## 매 spawn 시 4 step (per-spawn 디테일 — Step 4 보조)

### Step 1: 5 직업 industry_class 사전 분류

dispatcher가 spawn 전에 각 직업의 산업을 분류. 분류 휴리스틱:

**major (대부분 직업, default)** — distinct ≥ 18 강제
- 키워드: 금융 (자산·재무·은행·증권·보험·신용·투자), IT (개발·보안·데이터·AI·SW), 법조 (변호사·법무사·검사·판사), 항공 (조종·관제·승무·정비), 항만 (선원·하역·크레인·물류), 반도체 (공정·설계·제조), 자동차 (엔진·차체·검사), 통신 (네트워크·5G·방송), 에너지 (발전·전력·원자력·재생), 의료 (의사·간호·약사·재활), 교육 (교사·교수·강사·교육행정), 농업·축산 (작물·축산·재배), 건설 (시공·설계·감리), 식품 (제조·가공·검사·조리), 디자인 (제품·UI·UX·시각), 미디어 (방송·콘텐츠·기자·작가), 행정 (공무원·정책·국세·세무)

**minor (소규모 산업)** — distinct 12~17 허용 (목표는 18)
- 특수 직군이지만 산업 자체는 살아있음 (학회·협회·정부 부처 별도 존재)
- 예: 가축수매사무원 (축산 + 사무), 가향기조작원 (KT&G 외 일부 한국 담배 회사 존재)

**niche (단일 회사·공장·공정)** — distinct 6+ 허용
- 단일 회사 또는 폐지 자격증 또는 jmCd 부재
- 예: 단일 공장 화학물질 처리원, KT&G 가향기 (단일 회사 한정)
- 명백한 경우만 분류. 모호 시 default = major.

**SQL 또는 휴리스틱으로 분류**:
- 직업명 키워드 매치 (위 major 키워드 list)
- jmCd 존재 여부 (`SELECT jmCd FROM jobs WHERE id=?`)
- careernet API jobType 컬럼 (있으면)
- 직업명 단어 수 (예: "강관면취기조작원" 같은 specific 직업은 niche 의심, "재무설계사" 같은 광범위 직업은 major)

### Step 2: 각 직업 URL pool hint 5+ site 사전 제공

직업별 한국 1차 출처 5+ site list. 산업별 default pool:

| 산업 | Default URL pool |
|---|---|
| 금융 (자산·재무) | FPSB Korea (fpsbkorea.org), 금융감독원 (fss.or.kr), KAFA (kafa.or.kr), 한국FP협회 (kafa.kr), 한국재무설계전문가협회 (kfp.or.kr), 금융위원회 (fsc.go.kr), 한국경제 deep article (hankyung.com), 매일경제 deep article (mk.co.kr), 위키 (ko.wikipedia.org) |
| IT/보안 | PIPC (pipc.go.kr), KISA (kisa.or.kr), NIA (nia.or.kr), 정부24 (gov.kr), 국가법령정보센터 (law.go.kr), 한국정보보호학회 (kiisc.org), 위키, 정보처리·정보보안 자격증 |
| 법조 | 대한변호사협회 (koreanbar.or.kr), 법무부 (moj.go.kr), 국가법령정보센터, 대법원 (scourt.go.kr), 위키 |
| 항공 | 인천국제공항공사 (airport.kr), 대한항공 (koreanair.com), 아시아나항공 (flyasiana.com), 한국공항공사 (airport.co.kr), ICAO (icao.int), IATA (iata.org), 위키 |
| 항만 | 부산항만공사 (busanpa.com), 인천항만공사 (icpa.or.kr), KMOU (kmou.ac.kr), 한국항만물류협회 (kphla.or.kr), HMM (hmm21.com), 산업안전보건공단 (kosha.or.kr), 위키 |
| 반도체 | KSIA (한국반도체산업협회 ksia.or.kr), 삼성전자, SK하이닉스, 한국전자기술연구원 (keti.re.kr), 위키 |
| 자동차 | KAMA (한국자동차산업협회 kama.or.kr), 현대자동차, 기아, 한국교통안전공단 (kotsa.or.kr), 위키 |
| 통신 | KCC (방송통신위원회 kcc.go.kr), KTOA (한국통신사업자연합회 ktoa.or.kr), KISA, 위키 |
| 에너지 | 한국전력공사 (kepco.co.kr), 한국수력원자력 (khnp.co.kr), KOMIPO (komipo.co.kr), 한국에너지공단 (energy.or.kr), 위키 |
| 의료 | 보건복지부 (mohw.go.kr), 의료기관평가인증원 (koiha.or.kr), 대한의사협회 (kma.org), 대한간호협회 (koreanurse.or.kr), 위키 |
| 교육 | 교육부 (moe.go.kr), 한국교육과정평가원 (kice.re.kr), 한국교육개발원 (kedi.re.kr), 위키 |
| 광업/지질 | KIGAM (한국지질자원연구원 kigam.re.kr), 광물공사 (kores.or.kr), 산업통상자원부, 위키 |
| 농축산 | 농촌진흥청 (rda.go.kr), 한국농수산식품유통공사 (at.or.kr), 농림축산식품부 (mafra.go.kr), 위키 |
| 건설 | 국토교통부 (molit.go.kr), 한국건설기술연구원 (kict.re.kr), 한국토지주택공사 (lh.or.kr), 위키 |
| 디자인 | 한국디자인진흥원 (kidp.or.kr), 한국디자이너협회, 위키 |
| 미디어 | 방송통신위원회 (kcc.go.kr), 한국언론진흥재단 (kpf.or.kr), 위키 |
| 식품 | 식품의약품안전처 (mfds.go.kr), 한국식품산업협회 (kfia.or.kr), 위키 |
| 안전·산업 | 산업안전보건공단 (kosha.or.kr), 고용노동부 (moel.go.kr), 산업안전관리공단, 위키 |

→ 산업 분류 → default pool 적용 → 추가 시 sub-agent가 직접 발굴.

### Step 3: spawn prompt 헤더 = `_dispatch_template_v3.md` 통째 prepend

`_dispatch_template_v3.md` 의 STRICT 13 룰 + 직업 5개 table (industry_class + URL pool hint 포함) + 처리 절차를 그대로 sub-session prompt 맨 앞에 prepend.

각 sub-session prompt 구조:
```
[_dispatch_template_v3.md 통째]

# 처리 대상 5 직업

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
| 1 | <name> | <id> | <slug> | major | site1, site2, ..., site5+ |
| ... |

# 추가 컨텍스트 (선택)
- 이전 cycle 사고 컨텍스트 (있으면 명시)
- 특수 처리 요청 (있으면 명시)
```

### Step 4: 종료 후 결과 형식 강제 확인

sub-session 응답 검증:
- `slug | rev_id | distinct_url | industry_class | audit_status` 5줄 + `BATCH DONE: 5/5 ok, 0 fail` 형식 매치
- distinct < 18 인 직업 + industry_class=major 면 **재처리 의무** (다음 cycle 우선처리 풀에 등록)
- distinct 0 또는 rev_id null 인 직업 = **간판설치원 같은 누락 사고** → 단독 재처리

## 사고 history (재발 방지 참조)

- **2026-05-24 P1~P5 자작 cycle 사고**: cycle-script-block hook 차단 + SKILL.md 룰 명시
- **2026-05-24 sub-agent 자동 cycle 위반**: 60+ 직업 자동 박힘 → unmark + Rpri 재처리. dispatch_template v2 STRICT 룰 1.
- **2026-05-25 PowerShell 사용 시도**: powershell-block hook 차단 + 룰 29.
- **2026-05-25 Rpri1_B3 lazy abort**: 5 메이저 직업을 niche로 오분류 → distinct 6-7 종료. v3 룰 9~13 강화 (산업 분류 default major + lazy abort 방지 + URL pool hint alternate + audit WARN 자기인지 + 본문 보강 의무).

## 사용 형식

dispatcher가 spawn 시 매번 이 4 step 따라가야. **사전 분류 누락 = lazy abort 사고 재발 위험**.
