# CLAUDE.md — CareerWiki Project Guide

> **글로벌 일반 원칙**: `~/.claude/CLAUDE.md` (forrestchang/andrej-karpathy-skills 기반 — Think before / Simplicity / Surgical / Goal-driven).
> 이 파일은 **CareerWiki 특화 룰 + 컨텍스트**. 글로벌과 충돌 시 이 파일 우선.

## Project Overview

- **이름**: CareerWiki (한국어 진로 정보 위키)
- **Production**: https://careerwiki.org
- **데이터**: 608 majors / 6,945 jobs
- **Repo**: `C:\Users\user\Careerwiki`

## 🚨 dispatcher 새 세션 진입 시 (직업 데이터 보완/배치 — 절대 첫 단계)

> **이 섹션은 메모리 시스템 작동 여부와 무관하게 git-tracked 파일로 100% 보장된다.**
> Cowork dispatcher 메모리(`agent/memory/`)는 새 세션 system prompt에 자동 inject 되지 **않으므로**, 진행 상태는 반드시 아래 git-tracked 자산으로 복구한다. (2026-05-28 새 세션이 작업 못 찾은 사고 후속)

dispatcher가 **"현재 진행 상황/현황 확인하고 master 스킬로 배치 이어서 진행"** 류 prompt를 받으면:

1. **이 CLAUDE.md 전체 읽기** (repo 진입 시 자동 로드 — 현재 단계)
2. **`node scripts/master-cycle-helper.cjs --status`** 실행 → 현재 master 카운트(A/B) + 마지막 처리 cycle + 다음 cycle 시작 위치 (DB 진리값)
3. **`data/cycle/_dispatcher_manual.md` 읽기** → ENTRY POINT 6 step 실행 매뉴얼 (self-contained, 메모리 불필요)
4. **`data/cycle/_dispatch_template_v5.md` 읽기** → sub-session prompt STRICT 20 룰 (**v5 = 5직업-1세션 배치 복원**, Jason 결정 2026-06-13 — 토큰 효율 회귀 수습. v4=1직업-1세션은 cycle당 고정비 ~5배·캐시 파괴로 폐기. v3/v4는 보존용)
5. (보조) dispatcher 메모리 `agent/memory/project_careerwiki_cycle_progress.md` 접근되면 추가로 읽기 — 단 위 1~4로 이미 충분
6. 매뉴얼 6 step 따라: `--next-cycle`(또는 `--cycle=N`) 생성 → **5직업-1세션 ×5 배치 전량 일괄 enqueue (sonnet, 데몬 워커풀 동시성 7 연속 투입). 직업당 순차 POST 체크포인트(idempotent 경계)** → 결과 수집 → **검증 세션 1 (sonnet — 결정적 게이트 237ec3b + master-verify-cycle 전수 실측 + 다중 rev 전수 확인)** → 보고 → 메모리 갱신 + 사용자 ping (자동 다음 cycle X)

진행 상태 요약 (자세한 건 `--status` + 매뉴얼이 진리):
- 마지막 완료: **R65** (반도체화학적기계적연마장비부분품연구원~발전계전연구원 25직업, 반도체확산·발사체·발전 계열 major + 반려동물/반응로/반죽 등 niche 혼합, 2026-06-24). KPI **2032** (admin job-equalize 단일진실 기준, 2007→2032 +25 정확 일치, DB 독립 재실측 2회 + 25직업 전수 latest=MASTER 집합검증 master25/25). max master rev **19996**(dead URL 교체 4직업 +4 rev). 25/25 처리. 검증 전수 PASS(opus). distinct 최소 10(major 계열 18~23, niche 계열 10~14), totalE 전건≥21, 마커 전건 OK, sal 미접촉, abilityList 빈문자열 0. 복붙 Jaccard 대체로 3~34%(역할분리), 예외 반죽분할기조작원↔반죽혼합원 way=64%(동일 진입경로 직업특성, duties 9%로 직무 분리 — 허용). opus 검증 중 dead URL 4직업 11건 교체(반죽분할/반죽혼합/발광관조립/발렛파킹 — moel view.do·saramin/jobkorea list·hani 404 → law.go.kr·경향·etnews·최저임금위 라이브). **★ R65도 foreground 5배치 병렬 + foreground opus 검증으로 죽음 0회 완주.** **⚠️ url-liveness.cjs(HEAD) soft-404 맹점은 node GET+본문검사 backstop으로 보완했으나, 그 검사기도 봇차단403·SPA·SOFT404 거짓양성 많아 WebFetch 2차검증 필수. ⚠️ R64 prev: R62~R64 history backfill 미완(Code측 메모리 R61에 stale했음 — R65서 정렬).**
- **🔴🔴 실행모델 (서연이 데몬코드서 원인확정 + R64 실증, 2026-06-23): 데몬은 `1 task=1 turn=1 child 수명` — `run_in_background:true`로 띄운 Workflow/Agent는 메인 turn 종료 시 프로세스와 함께 죽는다(R62~R63서 4~5회 사망 원인). 반면 heartbeat가 active turn lease를 30초마다 갱신 → `run_in_background` 없는(foreground) Agent는 long turn도 데몬이 안 죽인다(R64 5배치+검증 전부 foreground로 무중단 완주 실증). → 배치·검증 모두 foreground Agent로 띄워 결과를 그 turn 안에서 수령(spawn 원칙 유지=직접 작업 아님). background 배치 금지. ⚠️ turn 과도히 길면 compaction 위험 — 필요시 cycle을 청크로.**
- **다음: R66** (R65 다음 가나다 순, 발전계전연구원 이후). `--cycle=66`로 5 배치 prompt 생성. preflight: KPI 2032·max rev 19996 대조. **🔴 go-gate: 매 cycle Jason go 대기, 자동 연속 금지.** 품질 게이트 불변(직업당 validate/audit + opus 검증세션 전수 + dispatcher node fetch 거짓양성/진짜dead 판별 + 명단 entity_id 집합검증 master=25). ⚠️ preflight서 KPI가 2032와 다르면 DB 기준 재구성 후 진행. **⚠️ 중단 시 `--resume=N`으로 미완분만 재배치(완료분 dup 가드 필수).**
- master_list: `data/cycle/master_list_R7_R229.jsonl` (223 cycle / 5575 직업).

## Tech Stack

- **Runtime**: Cloudflare Workers (Pages)
- **Framework**: Hono (TypeScript, JSX)
- **Database**: Cloudflare D1 (SQLite)
- **Storage**: R2 (이미지) / KV (세션)
- **Vector**: Cloudflare Vectorize (OpenAI text-embedding-3-small, 1536d, cosine)
- **AI/LLM**: Workers AI / OpenAI GPT-4o-mini
- **Frontend**: TailwindCSS 3 + TipTap editor
- **Build**: Vite + TypeScript strict

## Cloudflare Bindings (wrangler.jsonc)

| Binding | Resource |
|---|---|
| `DB` | D1 database (careerwiki-kr) |
| `BUCKET` | R2 bucket (careerwiki-uploads) |
| `KV` | KV namespace |
| `VECTORIZE` | Vectorize index (careerwiki-embeddings) |
| `AI` | Workers AI |

## Database

핵심 테이블: `jobs` (6,945 row), `majors` (608 row), `job_sources`, `major_sources`, `wiki_pages`, `page_revisions`, `comments`, `users`, `user_sessions`, `job_attributes`, `major_attributes`, `narrative_facts`, `embedding_metadata`

- **마이그레이션**: `migrations/` (0001~0057+). 컬럼·인덱스 디테일은 항상 `migrations/*.sql` 직접 read (drift 방지).
- **page_revisions**: 직업 편집 이력. `change_summary`에 `[job-data-master]` (또는 레거시 `[job-data-enhance]`) 마커 있는 row의 DISTINCT `entity_id`가 enhance 적용된 직업 목록. SQL은 `LIKE '%[job-data-master]%' OR LIKE '%[job-data-enhance]%'` 양쪽 매치 권장.
- **DB query**: `wrangler d1 execute careerwiki-kr --remote --command "SELECT ..."` (또는 `--json` 추가).

## Project Structure

```
src/
├── index.tsx                     # 메인 엔트리
├── services/
│   ├── ai-analyzer/              # AI 추천 (50+ 파일)
│   │   ├── routes.ts
│   │   ├── vectorize-pipeline.ts # Multi-Query 벡터 검색
│   │   ├── llm-interviewer.ts
│   │   ├── llm-judge.ts
│   │   ├── llm-reporter.ts
│   │   └── personalized-scoring.ts
│   ├── profileDataService.ts
│   ├── rag-search.ts
│   ├── editService.ts
│   └── cacheService.ts
├── templates/
├── types/
├── utils/
├── api/                          # CareerNet, Work24
├── routes/                       # auth, admin 등 (admin.ts 주의 — CPU 한도)
└── middleware/
migrations/                       # 0001~0057+
scripts/                          # ETL + quality harness
scripts/skill-cache/              # 스킬 임시 산출물 + audit-sources-deep.cjs
.claude/skills/job-data-master/   # 메인 직업 데이터 통합 스킬 (enhance + cleanup)
.claude/skills/job-data-create/   # 신규 직업 추가
.claude/skills/howto-publish/     # HowTo 가이드
.claude/skills/_archive/          # archive (job-data-enhance / job-data-cleanup 보존)
.claude/hooks/                    # 자동 hook (.md, hookify 형식)
```

## Key Commands

```bash
npm run dev               # 로컬 (단, Cloudflare 바인딩 동작 X — 테스트 금지)
npm run build             # 프로덕션 빌드
npm run deploy            # safe-deploy.cjs: tsc → build → deploy
npm run db:migrate:local
npm run db:migrate:prod
npm run build:editor      # TipTap 에디터 번들
npx tsc --noEmit          # 타입 체크

# DB 직접 query
wrangler d1 execute careerwiki-kr --remote --command "SELECT ..." --json

# 직업 편집 API
curl -X POST https://careerwiki.org/api/job/{id}/edit \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @file.json
```

## CareerWiki-Specific Rules

### URL/API
| 항목 | 값 |
|---|---|
| 직업 페이지 | `https://careerwiki.org/job/{슬러그}` (`.kr` / `/jobs` 절대 X) |
| 편집 API | `POST https://careerwiki.org/api/job/{id}/edit` |
| 인증 헤더 | `X-Admin-Secret: careerwiki-admin-2026` |
| prod URL 검증 | preview URL 신뢰 X. `careerwiki.org` 도메인에서 직접 fetch 후 키워드 매칭 |

### 데이터 페이로드
| 항목 | 룰 |
|---|---|
| `way` 타입 | **반드시 string** — 배열 보내면 즉시 500 |
| R2 이미지 키 | `jobs/job-{slug}.webp` (`uploads/` prefix 절대 X) |
| DB image_url | `/uploads/jobs/job-{slug}.webp?v={timestamp}` |
| `overviewSalary.wage` | **절대 덮어쓰기 금지** — 바 차트 데이터 |
| `sources` 키 | 필드명 그대로 (`way`, `overviewSalary.sal`, `detailWlb.wlbDetail`) — `way_sources` 등 X |
| sources 전송 | fields + sources 함께 — 누락 시 각주 깨짐 |

### Vectorize
- topK 쿼리 시 Vectorize 상한 100개 → Multi-Query 배치로 우회

### 배포
- **main 브랜치만** — worktree 배포 시 다음 main 배포에서 롤백됨
- `safe-deploy.cjs`가 tsc → build → deploy 한 번에 실행
- `--no-verify`로 pre-commit hook 우회 절대 금지 (`scripts/check-secrets.cjs`가 비밀키 차단)

## Validation Loops (CareerWiki)

### Code 변경 시 — 4 step (압축 X)

**Step 1: 기본 검증**
- `npx tsc --noEmit` — 타입 에러 0개
- `npm run build` — 빌드 성공
- 변경 코드 `Read`로 다시 열어 의도대로인지 재확인

**Step 2: 충돌/회귀 검증**
- 변경 함수 `Grep` 검색 → import/호출 모든 파일 호환성 확인 — 특히 `services/ai-analyzer/` 내부 cross-reference
- API 경로 변경 → 프론트엔드 호출 코드 일치 확인
- 공유 타입/유틸 변경 → 영향 모듈 전체 파악
- DB 스키마 변경 → 해당 컬럼 참조 모든 쿼리 확인

**Step 3: 과거 실수 대조**
- `memory/lessons-learned.md` 확인 — 동일/유사 실수 반복 여부

**Step 4: 오류 탐지**
- edge case 누락, null/undefined 처리, SQL injection 가능성
- TailwindCSS 클래스 오타, JSX 닫힘 태그 누락, 이벤트 핸들러 누락

### Production 배포 시
- main → `npm run deploy` → `careerwiki.org` 도메인 직접 fetch (preview X)
- HTTP 200 + 본문 키워드 매칭으로 배포 확인
- 직접 접속 못 하면 명시적으로 "검증 못 함" 보고

### Data 변경 시 (DB·prod 직업 페이지)
- 변경 전 row 백업 (revision history는 `page_revisions`에 자동 저장됨)
- POST 직후 GET으로 readback (prod 페이지 fetch + 변경 본문 grep)
- `audit-sources-deep.cjs --slug=X` 실행 → 9 패턴 (origin / orphan / dup / rawURL / brokenRef / markerCluster / listPage / mojibake / idxGap) 통과
- URL HEAD verify (BROKEN 0 보장)

### LLM Agent (subagent / dispatch) 사용 시
- WebFetch tool_uses ≥ verified URL 카운트 강제 (hallucination 방지)
- 자가 "LLM 검증 1줄"로 통과 금지 — 결정적 스크립트 (validate-job-edit / audit-sources-deep) 별도 실행
- 자기 보고 "DONE"은 신뢰하지 말고 별도 verify

## Source Priority (한국 직업 페이지)

직업 페이지 출처 우선순위:

1. **한국 1차 출처** — 정부 .go.kr (정책 deep page) / 협회·학회 .or.kr (deep page) / 한국 기업 .co.kr (채용·IR) / 한국 학교 .ac.kr
2. **한국 미디어** — 한국경제·전자신문·연합뉴스·KBS·SBS·MBC·JTBC deep article
3. **한국 위키** — ko.wikipedia.org
4. **외국 fallback** — en.wikipedia.org / 외국 1차 출처 (한국 출처 부재 시만)

**금지 패턴**:
- 협회/기업 root URL을 구체 fact 출처로 등록 (예: `kfb.or.kr/` 메인 → 은행 통계 출처 X)
- search/list URL (`/search?query=`, `/articleList?sc_word=`) — 검색 페이지는 직업-specific X
- 자기 사이트 (`careerwiki.org`) 인용
- **정부 직업포털 origin** (`career.go.kr` / `work.go.kr` / `wagework.go.kr` / `work24.go.kr` / `job.go.kr`) — 데이터 원본 자기인용

## Body-Source Coherence (본문-출처 1:1 정합성)

본문 구체 fact (회사명·통계·연도·순위·금액)가 있으면 그 fact를 직접 cover하는 출처 매핑:

- 본문 "삼성전자·SK하이닉스 R&D 채용" → 그 회사들 채용 페이지 deep URL
- 본문 "2024 시장 N억원" → 그 통계 발표 페이지 deep URL
- cover 못 하면:
  1. 더 구체적 출처 찾기 (WebFetch 검증)
  2. 본문 일반화 (회사명 → 산업 표현)
  3. fact 자체 제거

**한 sentence = 한 마커 max** — `[1][2][3]` 연속 X. 다중 출처 시 sentence 분리.

## Failure Modes (Auto Block / Recurring)

다음 사고 패턴은 자동 차단 / 인지:

### URL Hallucination
- LLM 일반 지식으로 URL 추정 → fabricated URL prod 등록
- 차단: WebFetch tool_uses ≥ URL 카운트 강제. 못 fetch하면 등록 X
- 사고 사례: `kgta.or.kr` (캐디), `k-lpn.or.kr` (간호조무사), `kpba.co.kr` (동물조련사) 등

### Origin Self-Cite
- 데이터 원본 (career.go.kr 등) / `careerwiki.org` 자기자신 → 출처 등록 X
- 차단: `pre-bash-origin-block.md` hook + `audit-sources-deep.cjs` Gate `[originDomain]` FAIL

### Marker Cluster
- 본문 한 sentence에 `[1][2][3][4]` 연속 마커
- 차단: `audit-sources-deep.cjs` Gate `[markerCluster]` FAIL
- 한 sentence 1 마커 max

### Decorative Source
- 본문에 구체 서사·통계 + 출처가 협회 메인 root → fact cover X
- 차단: Gate `[decorativeSource]` WARN. 의미적 cover 검증 (단순 키워드 hit X)

### Mojibake (Windows curl)
- Windows bash에서 `curl -d '{"name":"한글"}'` → mojibake (한글 깨져서 prod 저장)
- 강제: 파일 기반 `curl -d @file.json`만
- 자동 차단: `pre-bash-mojibake-block.md` hook

### Admin Worker CPU 1102
- 거대 쿼리 (jobs 전체 JOIN, narrative_facts 대량 집계)가 admin 라우트에서 CPU 한도 (50ms) 초과 → 1102 에러
- 회피: 페이지네이션 / chunking / cron 작업으로 분리
- 영향 영역: `src/routes/admin.ts` 신규 endpoint 추가 시 항상 검토

### Worktree 배포 롤백
- `.claude/worktrees/*`에서 deploy → 다음 main 배포 시 롤백됨
- 강제: 배포는 main 체크아웃 후만

### Pre-commit Hook 우회
- `--no-verify`로 `scripts/check-secrets.cjs` 우회 시 .dev.vars 등 비밀키 노출 위험
- 강제: hook fail 시 원인 fix, skip 절대 금지

### 자작 Cycle/Generic 스크립트 (2026-05-24 사고)
- P1~P5 5세션이 `_cyclegeneric.cjs` 자작 → WebFetch 우회 + 동일 보일러플레이트 6,440 직업에 박음. audit hook 무력화 (wrangler `--json` flag 에러).
- **차단**: `.claude/hooks/cycle-script-block.cjs` (PreToolUse Write|Edit|MultiEdit) — 파일명 `_cycle*`, `_generic*`, `_bulk*`, `_pool*`, `_mass*`, `_force-enhance*` 등 매치 시 exit 2.
- **강제**: 직업 데이터 작업은 반드시 `.claude/skills/job-data-master/SKILL.md` 사용. 별도 dispatcher 필요 시 cleanup-only 목적 + 사용자 명시 승인 후만.
- **무한 cycle 금지**: 자동 cycle 프롬프트는 명시적 N개 처리 후 STOP. 사용자 ping 없이 cycle 자동 반복 X. 위반 시 즉시 abort + 보고.
- **audit hook --json 사용 금지**: `wrangler d1 execute` 호출 시 `--json` flag 사용 X. plain stdout regex parse 사용 (Windows wrangler 호환).

### Sub-agent Cycle 위반 + PowerShell (2026-05-25 사고)
- R8 spawn 시 sub-agent들이 명시 5 직업 외 강·갱·거·소 60+ 직업 자동 박음 (NULL 풀 가나다순 다음 자동 SELECT). P1도 PITR 후에도 살아남아 추가 master 적용.
- 한 sub-agent는 Windows default shell PowerShell 자체 선택 → `Invoke-RestMethod` 시도 → 사용자 prompt deny.
- **조치**: 62 직업 unmark dispatch (master 마커 제거, UCJ 보존) + Rpri1-3 cycle로 재처리.
- **차단**: `.claude/hooks/powershell-block.cjs` (PreToolUse PowerShell|powershell|pwsh) — 매치 시 exit 2. Bash (Git Bash, WSL) 만 사용 강제.
- **SKILL.md 룰 28/29 추가**: cycle 단위 호출 (자기 batch 외 X) + PowerShell 절대 금지.
- **sub-agent prompt template 강제**: dispatcher가 spawn 시 STRICT 헤더 (5 직업 명단 외 X, PowerShell X, 자작 X, 5 직업 처리 끝나면 즉시 종료) 의무 명시.

## Quality Harness

배포 전·후 데이터 품질 검증 스크립트.

| 스크립트 | 역할 | 시점 |
|---|---|---|
| `scripts/safe-deploy.cjs` | tsc → build → deploy 래퍼 | `npm run deploy` 자동 |
| `scripts/validate-job-edit.cjs` | 편집 JSON 10개 룰 검증 | enhance Phase 2 |
| `scripts/full-quality-audit.cjs` | 직업 페이지 전체 품질 감사 | enhance Phase 4 |
| `scripts/skill-cache/audit-sources-deep.cjs` | 9 패턴 deep audit | 편집 직후 |
| `scripts/data-health-report.cjs` | 전체 DB 건강 보고 | 정기 모니터링 |

```bash
node scripts/validate-job-edit.cjs data.json
node scripts/skill-cache/audit-sources-deep.cjs --slug=소프트웨어개발자
node scripts/full-quality-audit.cjs --slug=소프트웨어개발자
node scripts/data-health-report.cjs --top-missing=20
```

## 스킬 시스템

| 스킬 | 상태 | 용도 |
|---|---|---|
| `job-data-master` | **메인** | 직업 데이터 enhance + cleanup + fact 정정 + 산문 영역 보강 통합 (자동 분기) |
| `job-data-create` | 사용 | 신규 직업 추가 |
| `howto-publish` | 사용 | HowTo 가이드 워크플로우 |
| `_archive/job-data-enhance` | ARCHIVED | → master로 통합 (2026-05-08) |
| `_archive/job-data-cleanup` | ARCHIVED | → master로 통합 (2026-05-08) |
| `job-supplement` | DEPRECATED | → master 통합 |
| `job-data-equalize` | DEPRECATED | → master 통합 |

키워드("데이터 보완", "균등화", "부실 직업", "NULL 직업", "audit FAIL fix", "rootURL 수정", "fact 정정", "산문 영역 보강")는 **반드시 `job-data-master`** 사용.

## Hooks (.claude/hooks/ + settings.json)

네이티브 Claude Code hooks — `.claude/settings.json`에 등록, 실행 스크립트는 `.claude/hooks/*.cjs`:

| Hook script | Trigger | Action |
|---|---|---|
| `origin-block.cjs` | PreToolUse Bash | edit API payload에 origin domain (career/wagework/work24/work/job.go.kr / careerwiki.org) 매칭 시 exit 2 차단 |
| `mojibake-block.cjs` | PreToolUse Bash | `curl ... -d '...'` 인라인 한글 매칭 시 exit 2 차단 |
| `tsc-check.cjs` | PostToolUse Edit/Write/MultiEdit | `*.ts*` 파일 변경 시 `npx tsc --noEmit` 실행, 에러 시 stderr 출력 |
| `audit-after-edit.cjs` | PostToolUse Bash | `POST /api/job/{id}/edit` exit 0 후 `audit-sources-deep.cjs --slug=X` 자동, WARN/FAIL alert |
| `stop-validate.cjs` | Stop | 코드 변경 감지 시 최근 draft validate-job-edit + git status + tsc |

기존 LLM Stop hook (자가검증 prompt) 그대로 병행 — `type: prompt`와 `type: command`가 같은 Stop event 안에 공존.

## Testing Rules

- **로컬 dev 서버 금지** — Cloudflare 바인딩(D1/Vectorize/AI/KV/R2)이 로컬 동작 X. `npm run dev` / `preview_start` 사용 X.
- **`npm run deploy` 후 prod 도메인에서 직접 검증**
- **검증은 `curl` / `WebFetch`** — HTML fetch 후 grep
- **MCP 도구 전체 금지** — `mcp__playwright__*`, `mcp__Claude_in_Chrome__*`, `preview_*` 등 일체 사용 X. curl/WebFetch로 충분.

## Coding Conventions

- 파일명: camelCase (`profileDataService.ts`)
- 타입/인터페이스: PascalCase (`UnifiedJobDetail`)
- 상수: UPPER_SNAKE_CASE (`MIN_VECTOR_SCORE`)
- DB 컬럼: snake_case (`raw_payload`)
- 커밋: `feat/fix/chore: [한국어 설명]`
- **자동 커밋 (Jason 지시 2026-06-10)**: git-tracked 자산(코드·스킬·매뉴얼·스크립트·CLAUDE.md) 변경 시 사용자 요청을 기다리지 말고 **그 턴 안에 즉시 커밋**. working tree에 작업 산출물을 미커밋으로 남기지 않는다. (push는 별도 — 기존 룰대로)
- TS strict mode, async/await, functional style

## Design Doc Protocol

다음 중 하나 이상 → 코드 작성 전 설계서 작성 (Plan Mode):
- 새 기능 (3+ 파일 변경)
- DB 스키마 변경
- API 엔드포인트 추가/변경
- UI 페이지/레이아웃 신규/대폭 변경

설계서 항목: 기능 정의 (목적·범위) / UI 목업 / 동작 명세 (정상·엣지·에러) / 영향 분석. 유저 승인 후 구현.

## Environment Variables

`.dev.vars` (절대 커밋 금지):
- `CAREER_NET_API_KEY`, `GOYONG24_MAJOR_API_KEY`, `GOYONG24_JOB_API_KEY`
- `ADMIN_SECRET`, `JWT_SECRET`
- `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`
- `OPENAI_API_KEY`, `CLOUDFLARE_API_TOKEN`

## See Also

- 🎯 **CareerWiki Deck (작업 시작 진입점)**: `~/.claude/projects/C--Users-user-Careerwiki/memory/deck/README.md` — 14 룰 / audit 도구 / dispatch v3 / 사고 history latest (시점 누적 recap과 별개로 항상 최신 유지)
- 🔄 **직업 보완 cycle 진행 상태 (dispatcher entry point)**: `project_careerwiki_cycle_progress.md` (Code측: `~/.claude/projects/C--Users-user-Careerwiki/memory/` / Dispatcher측: `local-agent-mode-sessions/.../agent/memory/`) — R-cycle 진행, 다음 시작 위치, 누적 카운트, 자산 path
- 📋 **Dispatcher 매뉴얼**: `data/cycle/_dispatcher_manual.md` — 사용자 prompt → 6 step action (현황 검증 → batch 준비 → spawn → 보고 → 메모리 갱신)
- ⚙️ **Cycle 자동화 helper**: `scripts/master-cycle-helper.cjs` — `--status` (DB 현황) / `--cycle=N` / `--next-cycle` (batch list + prompt 자동 생성) / `--resume=N` (리밋 사망 후 미완 직업 배치별 산출 — 완료분 재처리 가드용, 미착수 cycle 명단 미리보기도 됨) / `--reset-delay="resets H:MMam (Asia/Seoul)"` (리밋 메시지 → 리셋까지 ScheduleWakeup delay 계산, KST/Date.now()=UTC 기준, 1h초과 시 멀티홉 안내). ⚠️ 파일명 `cycle-helper`는 cycle-script-block hook(`/^_?cycle/`)에 차단됨 → `master-` 접두 필수
- 글로벌 일반 원칙: `~/.claude/CLAUDE.md`
<!-- Serena MCP 비활성화됨 (2026-05-25 사용자 명시 — ~/.claude.json mcpServers.serena 제거) -->
- 메모리: `agent/memory/` (없으면 생성 — feedback / project / reference / user)
