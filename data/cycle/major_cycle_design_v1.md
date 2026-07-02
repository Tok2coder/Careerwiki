# 전공(major) 데이터 보완 배치 사이클 — 설계서 v1

> 작성: 강한결 (2026-07-02). 직업 master enhance cycle(R-cycle)의 전공 이식 설계.
> 승인 전 상태 — Jason go 후 빌드 착수. 빌드 순서는 §8.

## 0. 실측 근거 (2026-07-02, prod D1 직접 쿼리)

| 항목 | 실측값 |
|---|---|
| 활성 전공 | **607** (is_active=1) |
| user_contributed_json | **전원 NULL (0/607)** — 편집 이력 0, 순수 API 데이터 |
| whatStudy / howPrepare / jobProspect | **607/607 공백** (<50자) — 상세정보 탭 산문 전량 비어있음 |
| youtubeLinks / _sources | **607/607 없음** |
| summary | 605/607 존재 (API 원천, 평균 ~250자) — 보강 대상이지 신규 아님 |
| merged 크기 상위권 | universities(대학목록, 최대 43K)가 부풀린 것 — 콘텐츠 정보량 지표 아님 |

**결론**: "가장 정보 많은 전공"조차 산문 콘텐츠는 사실상 0. 벤치마크는 기존 전공이 아니라 **직업 페이지 품질 기준을 전공 필드로 번역**해서 세운다.

### 인프라 준비 상태 (전부 이미 구현됨 — 코드 신규 개발 최소)
| 인프라 | 상태 | 근거 |
|---|---|---|
| 편집 API `POST /api/major/:id/edit` | ✅ 존재 | `src/routes/major-editor.ts` — fields/sources/changeSummary/baseTimestamp, Rule 26(text 필수), 충돌 409 — job과 동일 구조 |
| page_revisions | ✅ entity_type='major' 지원 | migrations/0010 |
| 각주(_sources) 렌더 | ✅ 구현됨 | `unifiedMajorDetail.ts:751,2645,2847` — 직업 템플릿과 동일 |
| whatStudy/jobProspect 렌더 | ✅ 값 있으면 렌더 | `unifiedMajorDetail.ts:1842,2081~` |
| howPrepare 렌더 | ⚠️ v1 초판 오기(렌더 없었음) → **2026-07-02 렌더 신설** | whatStudy 패턴 미러 + __SOURCE_FIELD_MAP__에 howPrepare·jobProspect 등록 (빌드 로그 §10) |
| admin KPI major 탭 | ⚠️ 구조 있음, `masterMarker=null` | `admin.ts:1044~` "major-data-master 추가 시 분기 추가" 주석 — **B1 코드 변경 필요** |

## 1. KPI 정의 (단일 진실 — 절대 규율)

- **마커**: `[major-data-master]` (changeSummary top-level — fields 중첩 금지, R39 교훈 동일)
- **KPI 쿼리** (admin.ts CTE와 동일 구조, entity_type='major'):
  latest content rev(`NOT LIKE '%[sidebar-fill]%'`)가 `[major-data-master]` 마커 + `user_contributed_json IS NOT NULL`인 DISTINCT entity 수
- 매 cycle 예상 KPI = 직전 + 25 (파일럿 M0은 +5). 1이라도 어긋나면 완료 선언 금지 — 직업 cycle 규율 그대로.
- helper 카운트는 보조, 사용자 보고는 KPI 쿼리 하나만.

## 2. enhance 필드 스펙 (직업 12필드의 전공 번역)

### 채우는 필드 (렌더 확인된 것만 — 렌더 안 되는 필드에 쓰지 않는다)
| 필드 | 내용 | 비고 |
|---|---|---|
| `whatStudy` | 배우는 내용 산문 | 607 전원 신규. 핵심 |
| `howPrepare` | 준비 방법 산문 | 〃 |
| `jobProspect` | 진로 전망 산문 | 〃 |
| `summary` | 학과 소개 보강 | API 원문 존중, 보강만 |
| `mainSubjects` | 주요 교과목 보강 | API 값 있으면 보강 |
| `enterField` | 진출 분야 보강 | 〃 |
| `licenses` | 추천 자격증 보강 | 〃 |
| `youtubeLinks` | 관련 영상 1~3 | 없으면 `_youtubeSearchNote` (무언 스킵 금지 룰 동일) |
| `heroTags` | 태그 | 있으면 유지 |
| `_sources` | 출처 (각주 [N] 양방향 정합) | text 필수(Rule 26), 본문 마커 동반 |

### 🔴 보호영역 (전공판 sal — 절대 미접촉)
- `chartData` / `employmentRate` / `salaryAfterGraduation` — 취업률·급여 차트 (API 원천)
- `universities` / `recruitmentStatus` — 대학정보 탭 (API 원천)
- `relatedJobs` / `relatedMajors` / `sourceIds` / `sources`(origin) — 시스템 생성
- `aptitude` / `property` / `careerAct` / `relateSubject` / `mainSubject`(단수형 레거시) — API 원천, v1에서 미접촉

### 게이트 수치 (✅ M0 파일럿 실측으로 확정, 2026-07-02 — opus 평가: 전건 통과, totalE 12~14·distinct 8~10·산문 508~707자 실측. 현행 유지)
- totalEntries(출처 등록 건) ≥ **12** (직업 19보다 낮게 시작 — 필드 수가 적음. 파일럿 실측 후 조정)
- distinct URL ≥ **8** (전공은 niche/major 구분 대신 단일 기준으로 시작)
- 산문 3필드(whatStudy/howPrepare/jobProspect) 각 300자 이상 + 각주 보유

## 3. 출처 정책 (전공 특화)

직업 정책(CLAUDE.md Source Priority) 승계 + 전공 특화:
1. **대학 학과 페이지** `.ac.kr` deep (학과 소개·커리큘럼 페이지 — 루트 금지)
2. 정부 `.go.kr` deep (단, **origin 금지 목록에 careernet 계열 추가**: `career.go.kr`·`work24.go.kr` 등 기존 + majors 원천 = CAREERNET/WORK24_MAJOR 자기인용 금지)
3. 학회·협회 `.or.kr` deep / 한국 미디어 deep article
4. 금지: 검색/리스트 URL(`/jobs?q=`·`_csrf` 세션 URL — R67 교훈), root URL, careerwiki.org 자기인용
- WebFetch tool_uses ≥ URL 수 강제 (환각 차단), 한 sentence 1 마커 max — 전부 동일 승계.

## 4. cycle 구조 (직업 7세션 패턴 이식)

- **1 cycle = 준비 1(sonnet, 명단만) + 배치 B1~B5(sonnet ×5, 각 5전공) + 검증 1(opus, 전수 실측+KPI)** — 25전공/cycle
- go-gate: 매 cycle Jason go. 자동 연속 금지.
- 실행모델: Agent `run_in_background:false` 명시 (R66 교훈).
- cycle 명명: **M-cycle** (M0=파일럿, M1~M25). 직업 R-cycle과 네임스페이스 분리.
- 총 규모: 607전공 = 파일럿 5 + 25전공×~25 cycle.
- 순서(제안, Jason 결정 필요): 대분류(major_categories)별 대표·인기 전공 우선 → 이후 가나다순. (대안: 순수 가나다순)

## 5. 3단 게이트 (validate → POST → audit)

| 게이트 | 자산 | 빌드 방식 |
|---|---|---|
| 사전 | `scripts/validate-major-edit.cjs` | validate-job-edit.cjs 포크 — ALLOWED_SOURCE_FIELDS·PROSE_BODY_FIELDS·보호영역을 §2로 치환, 게이트 수치 §2 |
| POST | 기존 major-editor API | 파일 기반 curl(@file.json), 한글 인라인 금지, POST 후 마커 실존 확인 |
| 사후 | `scripts/skill-cache/audit-major-via-api.cjs` | audit-via-api.cjs 포크 — SAL_PROTECTED→§2 보호영역, origin 도메인 목록 치환 |
| cycle 검증 | `scripts/major-verify-cycle.cjs` | master-verify-cycle.cjs 포크 — entity_type='major', 마커, threshold 치환 |

## 6. 빌드 자산 목록 (MECE — 이것 외 없음)

| # | 자산 | 방식 | 상태 |
|---|---|---|---|
| B1 | admin.ts major 마커 분기(`[major-data-master]`) + 배포 | 코드 수정 (주석에 예고된 분기) | 미착수 |
| B2 | `scripts/validate-major-edit.cjs` | 포크+치환 | 미착수 |
| B3 | `scripts/skill-cache/audit-major-via-api.cjs` | 포크+치환 | 미착수 |
| B4 | `scripts/major-verify-cycle.cjs` | 포크+치환 | 미착수 |
| B5 | `scripts/major-cycle-helper.cjs` (--status/--cycle/--resume/KPI) | 포크+치환 (⚠️ 파일명 `cycle-` 시작 금지 — hook 차단) | 미착수 |
| B6 | `data/cycle/major_list_M1_M25.jsonl` (607 전공 명단) | DB에서 생성 | 미착수 |
| B7 | `data/cycle/_major_dispatch_template_v1.md` (STRICT 블록) | v5 포크+§2·§3 치환 | 미착수 |
| B8 | `.claude/skills/major-data-master/SKILL.md` | job-data-master 포크 — Phase 0~7 유지, 필드·보호영역·출처 치환 | 미착수 |
| B9 | 진행 상태 복제본 `memory_replica_careerwiki_major_cycle_progress.md` | 신규 (직업판 포맷) | 미착수 |

## 7. 파일럿 M0 (P0 검증 — 정식 cycle 전 필수)

전공 5개 1배치 + opus 검증 1. 정식 25개 cycle 진입 전 다음을 실측 PASS해야 함:
1. major edit API 실전 first-blood — **한 번도 실사용된 적 없음** (UCJ 전원 NULL). POST→readback→merged 반영→prod 페이지 렌더까지 전 구간.
2. merge 우선순위 (user > api 확인 — whatStudy 등 신규 키가 merged에 뜨는지)
3. 각주 [N] 실렌더 (careerwiki.org/major/{slug} fetch로 육안 등가 확인)
4. 마커 rev 생성 + KPI 쿼리 +5 정확 일치
5. 보호영역 비접촉 (chartData 등 diff 0)
6. 게이트 수치(totalE≥12/distinct≥8) 현실성 → 확정
7. 사고 패턴 게이트 동작 (validate FAIL 유도 테스트 1건)

## 8. 빌드 순서 (각 단계 verify 포함)

1. B6 명단 생성 → verify: 607 전원 포함, slug 중복 0, 집합검증
2. B2/B3/B4 게이트 3종 → verify: 직업 CLEAN 케이스 이식 테스트 + 의도 FAIL 케이스
3. B5 helper → verify: --status가 KPI 0 정확 보고
4. B7/B8 템플릿·스킬 → verify: 프롬프트 생성 dry-run
5. B1 admin 분기 → tsc+build+deploy+prod 확인 (파일럿 후로 미뤄도 무방 — KPI는 B5 직접 쿼리로 측정 가능)
6. M0 파일럿 (go-gate: Jason go 필요) → §7 P0 전수 PASS → 게이트 수치 확정 → 정식 M1~

## 9. 리스크 등록부

| 리스크 | 대응 |
|---|---|
| major API 미실전 (첫 POST에서 미지 버그) | M0 파일럿 1건씩 순차 POST + 즉시 readback |
| 렌더 안 되는 필드에 콘텐츠 낭비 | §2는 렌더 라인 실측 필드만. 파일럿서 prod 육안 확인 |
| 전공 산문의 환각 (커리큘럼·자격증은 대학별 상이) | "일반적 경향" 서술 강제 + 특정 대학 fact는 해당 .ac.kr deep 출처 필수 |
| 게이트 수치 과소/과대 | v1은 잠정, M0 후 확정 (조정 이력 이 문서에 기록) |
| 직업 cycle과 자산 혼선 | M-네임스페이스 분리, helper·리스트·템플릿 전부 major_ 접두 |

## 10. 빌드 로그 (v1.1, 2026-07-02 — B1~B9 빌드 완료, M0 go 대기)

| # | 자산 | 상태 | 비고 |
|---|---|---|---|
| B1 | admin.ts major 마커 분기 | ✅ 구현(tsc 0·build OK) | job 경로 SQL 바이트 동일 확인. 배포는 dispatcher |
| B2 | validate-major-edit.cjs (1,162줄) | ✅ | valid PASS + FAIL 3종(보호영역/중첩/300자미달) 발화 실측 |
| B3 | audit-major-via-api.cjs (528줄) | ✅ | 원본 29패턴 승계 + 보호영역 2룰 신설. 🔍 발견: edit-data API가 howPrepare/jobProspect 미노출 → GET 2개 병용 |
| B4 | major-verify-cycle.cjs (297줄) | ✅ | a~e + (f)보호영역 비접촉. --cycle 로더 중첩형식 fix 후 M0 네거티브 5/5 FAIL 정확 검출 |
| B5 | major-cycle-helper.cjs (545줄) | ✅ | --status KPI 0/607 실측. --cycle=0 M0 프롬프트 생성 스모크 PASS |
| B6 | major_list_M0_M25.jsonl | ✅ | 122줄·607전공·distinct 607·26 cycle. M0=컴퓨터공학과·기계공학과·사회복지학과·유아교육학과·식품영양학과(대표 5, 계열 분산) |
| B7 | _major_dispatch_template_v1.md (162줄) | ✅ | v5 룰 1~20 승계 + 21~24 신설(trivia 금지/text 한글/7000자/.ac.kr) |
| B8 | .claude/skills/major-data-master/SKILL.md (372줄) | ✅ | Phase 0~7 + 22룰 압축 자족 수록 |
| B9 | 진행 복제본 memory_replica_careerwiki_major_cycle_progress.md | ✅ | Downloads |
| + | howPrepare 렌더 신설 (unifiedMajorDetail.ts) | ✅ tsc 0·build OK | §0 오기 정정분. fieldLabels·fieldOrder·__SOURCE_FIELD_MAP__·detailFields 등록 |

빌드 중 발견 함정 (템플릿·스킬·SSOT 매뉴얼 §M에 반영됨):
- 🔴 **trivia 전송 절대 금지**: major-editor.ts:551·652 — patch에 trivia 키 존재 시 서버가 jobProspect를 UCJ·merged에서 삭제하는 레거시.
- summary는 careernet canonical — 보강 허용·출처 등록 금지 (validate `[summaryCanonical]` 게이트).
- _sources id는 max+1 연속 부여(job의 renumber와 다름) — 재POST 최소화.
