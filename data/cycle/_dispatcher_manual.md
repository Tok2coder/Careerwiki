# Dispatcher 매뉴얼 — CareerWiki 직업 보완 cycle 진행

2026-05-25 신규 (per-spawn 4 step) / 2026-05-29 보강 (entry-point 6 step + helper script 연결).

---

# ⭐ ENTRY POINT — 사용자 prompt → 6 step action

## 트리거 키워드

사용자가 다음과 같이 말하면 본 흐름 진입:
- "현재 직업 보완 현황 확인하고 master 스킬 사용해서 배치 이어서 진행해줘"
- "다음 cycle 진행", "R{N} 진행", "배치 이어서", "직업 데이터 보완 이어가"
- "cycle 돌려", "master 배치 진행"

## Step 1 — 메모리 entry point 읽기

```
agent/memory/project_careerwiki_cycle_progress.md   (dispatcher 메모리)
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

생성물:
- `data/cycle/R{N}_B{1..5}.txt` (5 batch list)
- `data/cycle/r{N}_prompts/R{N}_B{1..5}_prompt.md` (STRICT 16룰 + 직업표 + 보고형식 — `_dispatch_template_v3.md` single source 자동 prepend)
- stdout: 5 spawn 명령 + cross-check 경고 (이미 처리된 직업 있으면 표시)

## Step 4 — 5 sub-session spawn (`start_code_task` × 5)

helper stdout의 명령대로 각 sub-session에 prompt 파일 내용 전달:
```
session 1: data/cycle/r{N}_prompts/R{N}_B1_prompt.md 내용 → prompt
session 2: ... R{N}_B2_prompt.md
session 3: ... R{N}_B3_prompt.md
session 4: ... R{N}_B4_prompt.md
session 5: ... R{N}_B5_prompt.md
```

⚠️ sub-agent로 spawn (Agent tool) X → **`start_code_task` × 5 로 진짜 세션 분리** (메모리 `feedback_dispatcher_subsession_pattern.md`). 각 sub-session 내부 5 직업 직렬.
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
