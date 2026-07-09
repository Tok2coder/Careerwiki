# 🚨 master skill spawn STRICT prompt template (v5, 2026-06-13)

dispatcher가 sub-session spawn 시 이 헤더를 prompt 맨 앞에 그대로 prepend.

v5 변경 (v4.1 대비) — **N직업-1세션 배치 복원 (기본 5직업/세션), Jason 결정 2026-06-13** (토큰 효율 회귀 수습):
- 배경: v4(1직업-1세션, 2026-06-11)는 사망 반경 축소가 목적이었으나, 세션당 고정비(SKILL.md ~16.6K + CLAUDE.md ~8K + 템플릿/프롬프트 ~9K ≈ 40K 토큰)를 25번 재지불 + **prompt 캐시 파괴**로 cycle당 토큰이 ~5배(고정비 ~200K→~1M). "5h에 3 cycle"→"1 cycle도 미완"의 직접 원인. R46 실측 enhance 2.88M 토큰.
- **복원: 5직업/세션 × 5세션** — 고정비를 세션당 1회로 amortize + SKILL.md 1회 로드 후 5직업 캐시 재사용.
- **품질 불변(Jason 제약 "퀄리티 이상없게")**: 품질 게이트 전부 유지 — 직업당 validate pre-POST FAIL 3종(237ec3b) + audit-via-api CLEAN + 검증세션(sonnet) master-verify-cycle 전수 실측. 배치 크기는 폭발 반경에만 영향, 품질 하한은 스크립트가 강제.
- **폭발 반경 수습 = 직업당 POST 체크포인트 + idempotent 재spawn**: 5직업을 1건씩 순차 POST(각 직업 완료 즉시 DB 기록). 세션이 중간 사망해도 완료분은 prod에 남고, 검증세션 전수 실측이 미완 직업을 식별 → 그 직업만 재spawn(중복 0). R44/R45/R46에서 검증된 패턴.
- v4의 20룰 전부 유지 (직업 수 표현만 "할당 직업(아래 표 N건)" 으로 count-agnostic 치환). 검증 세션 sonnet 유지.

```
# 🚨 STRICT — 절대 룰 (위반 시 즉시 abort + 보고)

1. **이 세션 할당 직업(아래 "처리 대상" 표의 직업) 외 직업 SELECT/POST/audit 절대 X.**
   - NULL 풀에서 가나다순 다음 직업 자동 SELECT 절대 X.
   - 할당된 표의 직업 전부 처리 끝나면 즉시 종료. 새 cycle / Phase 재진입으로 자동 다른 직업 X.
   - 직업은 **1건씩 순차** 처리 (POST 체크포인트). 다음 직업으로 넘어가기 전 현재 직업을 POST·검증 완료.

2. **PowerShell 절대 X. Bash 만 사용.**
   - Windows 환경도 Bash (Git Bash, WSL). PowerShell / pwsh / Invoke-RestMethod 호출 X.
   - PreToolUse hook `.claude/hooks/powershell-block.cjs` 가 차단함 — exit 2.

3. **자작 스크립트 X.**
   - `_cycle*.cjs` `_generic*.cjs` `_bulk*.cjs` `_pool*.cjs` `_mass*.cjs` `_force-enhance*.cjs` 등 차단됨.
   - PreToolUse hook `.claude/hooks/cycle-script-block.cjs` 가 차단함 — exit 2.
   - 모든 작업 = `.claude/skills/job-data-master/SKILL.md` Phase 0~7 흐름만.

4. **WebFetch 우회 X.**
   - URL 등록 전 WebFetch 검증 의무. fabricated URL 등록 절대 X.
   - distinct URL ≥ 18 (룰 Z).

5. **subagent 병렬 X.**
   - 본 sub-session 내부 직렬 처리. fan-out 사고 (75 fan-out / 172M token) 재발 방지.

6. **sal/wage 미접촉.**
   - `fields.overviewSalary` / `sources["overviewSalary.sal"]` 절대 손대지 X.

7. **AskUser X.**
   - 막힘 시 텍스트로 상태 보고 후 abort. user 응답 대기 형태 prompt X.

8. **직업당 처리 후 1줄**: `slug | rev_id | distinct_url | totalE(정확 수치) | industry_class (niche/minor/major) | audit_status | 마커OK`. 세션 마지막에 `JOBS DONE: N/N ok` (또는 미완 시 `JOBS: M/N ok, 미완=<slug 목록 + 사유>`).

9. **🚨 산업 분류 + distinct URL 강제** (SKILL.md 룰 30):
   - industry_class 명시: `niche` (단일 공정·공장 직업) / `minor` (소규모 산업) / `major` (금융·IT·법조·항공·항만·반도체·자동차·통신·에너지·의료·교육 등 광범위)
   - **major 산업 = distinct ≥ 18 발굴 의무. lazy 절충 X.**
   - niche 절충 (distinct <18 허용) 은 단일 회사·공정 + URL pool 8~10개 모두 시도 후만 가능. **niche여도 distinct <10 금지.**
   - **산업 분류 모호 시 default = major** (pool 발굴 시도 의무, niche 절충 default 금지)

10. **🚨 URL pool hint 활용 의무 + alternate 발굴 (lazy 포기 X)**:
    - dispatcher가 prepend한 URL pool hint site는 **모두 시도 의무**
    - 1-2 ECONNREFUSED / 404 만나도 즉시 포기 X — 다른 deep page / alternate URL 시도
    - hint site의 다른 페이지 (예: 메인 404면 deep article·정책 페이지·통계 페이지 등) 시도
    - 산업 표준 기관·정부 deep page·deep article·자격증 페이지·학회 발표자료 등 alternate pool 활용
    - hint 외 추가 발굴도 OK (한국 1차 출처 우선)

11. **🚨 Lazy abort 방지** (2026-05-25, 사용자 명시):
    - 작업 시작 전 "niche 같음" / "scope 비현실적" 자체 판단 → **사전 abort 절대 X**
    - 1차 시도 URL pool 부족 → 즉시 pool-limited 절충 X. **추가 8~10개 site 시도 의무**.
    - 막힘 발생 시 텍스트 보고 + 해당 직업 skip 가능. 단 **작업 시작 전 / 1차 시도 후 사전 abort 절대 X**.
    - "alternate URL 없음" 결론 전 minimum 10 site 시도 의무.

12. **🚨 본문 보강 의무화** (2026-05-25):
    - `way="" or trivia="" / overviewProspect.main="" / detailWlb.wlbDetail="" / detailWlb.socialDetail="" / overviewWork.main="" / overviewAbilities.technKnow="" / summary=""` 빈 영역은 **반드시 신규 작성** (output-only patch X)
    - **9 prose 영역 모두 100자+ 작성 의무** (way·trivia·overviewProspect.main·detailWlb.wlbDetail·detailWlb.socialDetail·overviewWork.main·overviewAbilities.technKnow·summary·overviewAbilities.abilityList)
    - **출처만 추가하고 본문 안 채우는 minimal patch 절대 금지** (룰 ZZ FAIL 트리거)

13. **🚨 Audit 명확화** (2026-05-25):
    - `audit-via-api` 의 `urlCountInsufficient(N<18)` WARN 감지 시 **즉시 자기 인지 + 추가 발굴**
    - patch distinct 와 audit count는 1 offset 가능 → **patch 19개 분배 권장 (안전 마진, distinct 19 → audit 18)**
    - audit WARN 무시 X (FAIL 아니라도 distinct 부족 신호 = 즉시 추가 발굴 trigger)
    - audit 통과 (WARN 0 / FAIL 0) 가 완료 조건

14. **🚨 youtubeLinks 영역 omit 금지** (2026-05-26):
    - 모든 master enhance patch는 `youtubeLinks` 영역 **의무 포함**:
      a. 적합 한국어 영상 있음 → `youtubeLinks: [{url, title}]` (1~3개, oembed 200 + title 매칭 verify, 한국어만)
      b. 한국어 영상 부재 → `youtubeLinks: []` + `_youtubeSearchNote` (탐색어 ≥6개 OR 카테고리 ≥3개 / 현직자·인터뷰·직무·실무·강의·교육·진로·면접)
    - validate `[YouTube-영역누락]` FAIL — omit 시 차단됨.
    - 면제: change_summary에 `yt-fill` / `cleanup` / `--field-only=` 명시 부분 보강 모드만.

15. **🚨 totalEntries ≥ 19 강제** (2026-05-27):
    - `_sources` 총 entry 수 (모든 fieldKey의 entry 합산) **≥ 19** 필수.
    - distinct URL ≥ 18과 별개로, 본문 [N] 인용 위치 수 자체를 늘리거나 새 출처 항목 추가로 ≥19 달성.
    - minimal patch (totalEntries 변동 없음) 금지.
    - 보강 패턴: (a) distinct URL 추가 (1차) (b) 본문 [N] 마커 추가 인용 (1 URL → 2-3 위치 분산) (c) detailReady array 항목 추가 시 항목별 [N] (d) 9 prose 영역 본문 expand + [N] 추가.

16. **🚨 AskUser tool 호출 절대 금지** (2026-05-28, R11_B2 사고 후속):
    - 작업 규모 클 거라고 우려 보고 X
    - "단일 응답 안에서 안전한지" 평가 X — 그냥 직진 처리
    - 단일 응답으로 안되면 multi-turn으로 처리하되 AskUser는 절대 X
    - 진행 방식 결정 X — prompt 지시 그대로 따름
    - 위반 시 dispatcher 재지시 받기 전까지 job fail로 간주

17. **🔴 룰 A — POST 전 신규 URL 생존 확인 의무** (2026-06-10, R41 broken URL 사고):
    - POST payload의 **모든 신규 `_sources[].url`을 node fetch (브라우저 UA) 로 생존 확인** 후에만 POST.
    - **404 / 410 / DNS실패(NXDOMAIN) = 사용 금지 → 반드시 교체.**
    - **000 · 403 · timeout · TLS 오류 = 거짓양성 가능 (Windows schannel·anti-bot) — 타 방법으로 재검, 즉시 폐기 X.**
    - 200 · 30x = OK.
    - 검증: `node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal` (`urlDead`=FAIL / `urlUnverified`=WARN) — `urlDead` 발견 시 즉시 RETRY.
    - **생존 확인은 URL 목록 일괄 1회 node 호출로** (URL당 개별 Bash 호출 금지 — 18+ URL이면 18+ 콜 낭비, 룰 20 tool-call 경제. WebFetch 내용 검증 의무와는 별개 — 둘 다 수행하되 생존 체크만 일괄화).
    - **🚫 dead-redirect 도메인 하드 블랙리스트 (WebFetch·등록 절대 금지)** — apex는 빠르게 301 응답하지만 리다이렉트 목적지가 무응답 black hole이라 WebFetch가 **하드 타임아웃 없이 물려 세션이 무한 정지·사망**하는 도메인. 접근 시도 자체를 하지 마라:
      - `jmi.re.kr` / `www.jmi.re.kr` (apex 301 → `https://www.jmi.re.kr/` 7s+ TIMEOUT, R71 버섯연구원 B3 세션 사망 원인, 2026-07-09)
      - 신규 발견 시 이 목록에 추가. dead-redirect 의심(apex 301인데 www/목적지 응답 지연) 시 **먼저 HEAD 프로브(하드 timeout 7s)로 목적지 생존 확인 후** WebFetch, 죽었으면 즉시 대체 출처로.

18. **🔴 룰 B — 보고 7열 전 칸 의무 + 모호 표기 금지** (2026-06-10, R41 보고 형식 위반):
    - 완료 보고는 **7열 모두** 기재: `직업 | rev | distinct | totalE(정확 수치) | class | CLEAN | 마커OK`.
    - **totalE는 실측 정확 숫자** (`≥19` 부등호 X). `node scripts/master-verify-cycle.cjs --cycle=N` 이 정확 카운트 + 마커 OK 일괄 검증.
    - **"(이전 세션)" / "(기존 처리됨)" 류 모호 표기 절대 금지** — 실측 rev id 기재.
    - **부등호 보고 = 미완료(실결함 신호) 간주** (2026-06-11 격상): R43 디엠(DM)발송원 "≥19" 보고가 실측 15 미달이었음. 부등호로 보고한 직업은 검증 세션 전수 실측 1순위.
    - **동일 직업 재POST가 있었으면 모든 rev id를 보고에 기재** (최종 rev만 기재 금지 — R44에서 잉여 rev 9건이 보고 누락돼 디스패처 DB 실측으로만 발견됨).

19. **🔴 룰 C — POST 직업당 1회 원칙 + POST 전 셀프 게이트** (2026-06-11, R43 사고):
    - **POST 전 distinct·totalE 셀프 카운트 의무 — 기준 미달 상태로 POST 절대 금지** (보강 완료 후 1회 POST). "일단 POST 하고 패치"는 잉여 rev + 재작업 낭비.
    - **결정적 강제 (237ec3b)**: validate 호출은 반드시 `node scripts/validate-job-edit.cjs payload.json --class=<디스패처 지정 분류(major|niche)>` — `[totalEntries미달]`(<19) / `[prose영역미달]`(9영역 <100자) / `[distinct미달]`(major<18, niche<10) 게이트가 풀 enhance 모드에서 FAIL로 차단. 작업자 모델의 자가 카운트 보고와 무관하게 스크립트가 판정.
    - **동일 payload(동일 changeSummary) 반복 POST 금지.** POST 성공(revisionId 반환) 후 같은 직업 재POST는 audit FAIL 수정 시에만, **fix POST 최대 1회 — 결함들을 한 payload에 묶어 1회로 해소** (2026-07-03 효율화 ③, R68 fix 3연속 사례). 1회로 못 고치면 skip+사유 보고 → 검증 세션이 수습. 재POST 전 latest rev 확인(이미 반영됐으면 skip).
    - **재전송·mojibake 판정은 D1 직접 조회로만** (2026-07-03 효율화 ②): edge 캐시된 edit-data 재조회는 stale 응답으로 mojibake 허상·재검 루프 유발(R68 tool_uses 504 사고). 저장 확인은 `wrangler d1` SELECT — 허상 의심 재POST 금지.

20. **🔴 룰 D — tool-call 경제 (세션 사망 방지, 배치 모드 특히 중요)** (2026-06-11 R43 / 2026-06-13 v5 배치 복원 강화):
    - prose 필드 임시 파일 분할 시 **인접 2~3필드를 한 파일에 묶기, 직업당 임시 파일 ~6개 이내**. 과도 세분화 금지.
    - 턴당 출력 2000자·payload 통째 echo 금지 (32K 한도 방지 — 품질 게이트는 깎지 않는다).
    - **직업 1건 = POST 전 validate 1회 + POST 1회 + POST 후 audit 1회 + 마커 확인 1회 = 단 1라운드.** 통과 즉시 다음 직업으로(과검증 재조회 루프 금지). FAIL 시에만 해당 직업 재실행(최대 2회, 룰 19).
    - **배치 5직업 누적 tool-call 관리**: 직업당 ~40 tool-call 목표(5직업 ≈ 200 이내). R45 J12가 단일 직업 POST 후 검증 루프를 206 tool-call까지 돌다 session limit 사망 — 과검증이 사망 주원인. 배치 모드에선 직업당 검증 1라운드 엄수가 세션 생존의 핵심.
    - 한 직업 막히면(10 site 시도 후) 텍스트로 사유 보고 + 그 직업 skip하고 **다음 직업 계속** (세션 전체 abort 금지). 검증세션이 skip분 식별 → 재spawn.

21. **🔴 룰 E — prod fetch 오류만으로 site-wide 장애 단정·전체 abort 금지** (2026-07-08, R70 B5 오탐 사고):
    - Phase 0/6에서 `careerwiki.org` 페이지가 500/000/타임아웃으로 떠도 **그것만으로 "site-wide 장애"라 판단해 배치 전체를 0건 abort하지 말 것.**
    - **Windows curl은 정상 200도 000(schannel TLS)로 떨어지고, edge 캐시 일시 blip·anti-bot으로 500/403이 뜰 수 있다.** 반드시 **node fetch(브라우저 UA)**로 재확인: `node -e 'fetch("https://careerwiki.org/job/<slug>",{headers:{"User-Agent":"Mozilla/5.0"}}).then(r=>r.text()).then(t=>console.log(r.status,t.length))'`. 대조군(소프트웨어개발자 등 무관 직업)도 같이 찍어 진짜 전역 장애인지 판별.
    - node fetch로 200 확인되면 오탐 → **정상 진행.** 여러 직업·대조군이 node fetch로도 확정적으로 5xx일 때만 텍스트 보고 후 abort(그때도 데이터 손상 아님 — POST 안 했으면 marker=0, 재spawn으로 복구).

---

# 처리 대상 직업 (N직업-1세션 배치)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
| 1 | <name> | <id> | <slug> | <niche/minor/major> | site1, site2, ... (5+) |
| 2 | ... | ... | ... | ... | ... |

# 처리 절차

`.claude/skills/job-data-master/SKILL.md` Phase 0~7 흐름 따라 표의 직업을 **1건씩 순차** master 적용.
POST endpoint: `https://careerwiki.org/api/job/{id}/edit`  /  인증: `X-Admin-Secret: careerwiki-admin-2026`
직업 1건: 발굴 → 본문/출처 작성 → URL 생존 일괄 확인(룰 A) → validate(룰 C) → POST → audit+마커 1라운드(룰 D) → 1줄 보고 → 다음 직업.
표의 직업 전부 끝나면 즉시 종료. 자동 다음 cycle 진입 X.
```
