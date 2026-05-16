# Enhance Fields Spec — 21+ 영역 (WL-KILL 자동 enumerate) + careerTree + 각주 수선

> ENHANCE 모드 진입 시 21+ 영역 작성 spec + Phase 3.6 careerTree + Phase 5 각주 수선 절차.
> 본 doc은 reference 전용 — enhance 사이클 실행 시 참조.
> **2026-05-16 WL-KILL 강화**: 화이트리스트 17필드 폐기 → 21+ 영역 자동 enumerate 강제.

---

## 21+ 영역 요약 (Self-Report 자동 enumerate, WL-KILL 룰)

**핵심**: 진단·Self-Report·patch 계획은 화이트리스트 enumerate 금지. `merged_profile_json`의 모든 prose body + sidebar + 보조 영역을 자동 enumerate.

### Prose Body 14 영역 (audit-via-api OMEGA가 자동 검출)

| # | 필드 | 분량/형식 | 우선순위 |
|---|---|---|---|
| 1 | `way` | 200~500자, **string** (배열 X) | 항상 작성 |
| 2 | `summary` | 80~200자 string (admin 영역 있으면 보존) | 보강 가능 |
| 3 | `trivia` | 출처 있는 팩트 1개 (마지막 sentence 끝 [N]) | 항상 작성 |
| 4 | `overviewWork.main` | 100~300자 string (careernet 원본 있으면 보존) | 보강 가능 |
| 5 | `overviewProspect.main` | 기존 있으면 유지, 없으면 보강 | 보강 가능 |
| 6 | `overviewAbilities.technKnow` | 100~250자 string (NULL이면 신규 작성 의무) | **항상 작성** ⚠️ 신규 강화 |
| 7 | `detailWlb.wlbDetail` | 130~200자 | 항상 작성 |
| 8 | `detailWlb.socialDetail` | 100~160자 | 항상 작성 |
| 9 | `detailReady.curriculum` | 5개+ plain string 배열 | 항상 작성 |
| 10 | `detailReady.recruit` | 3개+ plain string 배열 | 항상 작성 |
| 11 | `detailReady.training` | 2개+ plain string 배열 | 항상 작성 |
| 12 | `detailReady.researchList` | 기존 보존 (CareerNet 원본) | 수정 X |
| 13 | `detailReady.certificate` | 기존 보존 | 수정 X |
| 14 | `detailReady.pathExplore` | 기존 보존 | 수정 X |

> ⚠️ **🔒 절대 수정 금지**: `overviewSalary.sal` (sal/wage/wageSource 전체) — `[sal-readonly]` strict 차단. 진단 단계에서도 sal 영역은 skip.

### Sidebar 4 영역

| # | 필드 | 분량/형식 |
|---|---|---|
| 15 | `sidebarJobs` | 7~12개 plain string, **DB 실존 확인** |
| 16 | `sidebarMajors` | 3~8개 plain string, **DB 실존 확인** |
| 17 | `sidebarCerts` | 2~5개 `[{name, url}]` object 배열 |
| 18 | `sidebarOrgs` | 1~3개 `[{name, url}]` object 배열 |

### 등급 + 보조 영역

| # | 필드 | 형식 |
|---|---|---|
| 19 | `detailWlb.wlb` (등급) | "높음" / "보통 이상" / "보통" / "보통 이하" / "낮음" |
| 20 | `detailWlb.social` (등급) | 동일 |
| 21 | `heroTags` | 4~8개 plain string |
| 22 | `youtubeLinks` | 1~3개 `[{url, title}]` object 배열 (한국어만) |
| 23 | `careerTree` | 한국인 공인 인물 (없으면 `null` + `_careerTreeNote`) |

### WL-KILL 자동 진단 SQL (Phase 0-DIAG 의무)

```sql
SELECT
  -- Prose body 14 영역 (sal 제외)
  json_type(merged_profile_json,'$.way') AS way_t, length(json_extract(merged_profile_json,'$.way')) AS way_l,
  json_type(merged_profile_json,'$.summary') AS summary_t, length(json_extract(merged_profile_json,'$.summary')) AS summary_l,
  json_type(merged_profile_json,'$.trivia') AS trivia_t, length(json_extract(merged_profile_json,'$.trivia')) AS trivia_l,
  json_type(merged_profile_json,'$.overviewWork.main') AS duties_t, length(json_extract(merged_profile_json,'$.overviewWork.main')) AS duties_l,
  json_type(merged_profile_json,'$.overviewProspect.main') AS prospect_t, length(json_extract(merged_profile_json,'$.overviewProspect.main')) AS prospect_l,
  json_type(merged_profile_json,'$.overviewAbilities.technKnow') AS abil_t, length(json_extract(merged_profile_json,'$.overviewAbilities.technKnow')) AS abil_l,
  json_type(merged_profile_json,'$.detailWlb.wlbDetail') AS wlb_t, length(json_extract(merged_profile_json,'$.detailWlb.wlbDetail')) AS wlb_l,
  json_type(merged_profile_json,'$.detailWlb.socialDetail') AS social_t, length(json_extract(merged_profile_json,'$.detailWlb.socialDetail')) AS social_l,
  -- Sidebar 4 영역
  json_array_length(merged_profile_json,'$.sidebarJobs') AS sb_jobs,
  json_array_length(merged_profile_json,'$.sidebarMajors') AS sb_majors,
  json_array_length(merged_profile_json,'$.sidebarCerts') AS sb_certs,
  json_array_length(merged_profile_json,'$.sidebarOrgs') AS sb_orgs,
  -- 보조 영역
  json_array_length(merged_profile_json,'$.heroTags') AS hero,
  json_array_length(merged_profile_json,'$.youtubeLinks') AS yt,
  -- _sources 보유 키
  json_extract(user_contributed_json,'$._sources') AS sources_json
FROM jobs WHERE slug=?;
```

→ 각 영역의 length=0 또는 NULL이면 force-enhance 작성 의무. patch 계획에 누락 시 WL-KILL 위반.

### Self-Report 자동 enumerate 보고 형식

```
[직업명] WL-KILL Self-Report (21+ 영역):
[1] way 248자 ✅ / [2] summary 0자 ❌ (작성 필요) / [3] trivia 104자 ✅ / [4] duties 0자 ❌ (작성 필요)
[5] prospect 240자 ✅ / [6] abilities 0자 ❌ (작성 필요 — 사고 잔존 영역) / [7] wlb 137자 ✅ ...
[patch 계획] way (skip — 충실) / abilities (작성) / summary (작성) / duties (보존 — careernet 원본 있음) / ...
[skip 사유] researchList/certificate/pathExplore (careernet 원본 보존)
```

→ 21+ 영역 중 patch도 skip도 없으면 WL-KILL 위반 자동 차단.

---

## 필드별 상세 spec

### 1. way (되는 방법)

- **타입**: `string` (배열 절대 X — 즉시 500 에러)
- **분량**: 200~500자
- **내용**: 서술형 진로 경로 (자격요건·시험·진입경로). 교육과정 목록 나열 X (그건 detailReady).
- **각주**: 산문 필드 룰 — 같은 출처 연속 문장 블록 마지막 문장 마침표 뒤 [N] 1회.

**예시**:
```
"수의사가 되려면 수의예과 2년 + 수의학과 4년 (총 6년) 학부 과정을 수료한 뒤 한국수의사회가 주관하는 수의사 국가시험에 합격해야 한다.[1] 시험은 매년 1월 시행되며 응시자격은 수의학사 학위 소지자에 한정된다.[2]"
```

### 2~4. detailReady (curriculum / recruit / training)

- **타입**: plain string 배열. 각 항목 = 단일 sentence per item.
- **분량**: curriculum 5개+ / recruit 3개+ / training 2개+
- **각주**: UCJ 룰 A — 모든 항목에 [N] 마커 의무. 항목별 다른 출처면 각자 [N]. 연속 동일 출처면 마지막 항목에만.
- **금지**:
  - `{text: "...", url: "..."}` object 형식 — UI 도메인 노출 버그
  - 인라인 URL/도메인 표기 (`"(worker.co.kr)"` 등)
  - 검색결과 페이지 URL을 _sources에 등록
  - `detailReady.researchList` 수정 (CareerNet 원본)
  - `detailReady.certificate` 본문 추천 자격증 추가 (sidebarCerts에서만)
- **한 항목 = 단일 sentence**: ". " 다음 두번째 문장 합치기 절대 X (validate `[detailReady.{sub}[i] 한 array 항목에 두 문장 합쳐짐]`로 차단).

### 5. trivia (여담)

- **타입**: string
- **각주 위치 룰** ⚠️: 마지막 sentence 마침표 뒤 [N]. 첫/중간 sentence 뒤 [N] + 후속 sentence 절대 X (`[trivia-각주중간]` FAIL 자동 차단).

```
✅ "문장A. 문장B. 문장C.[1]"
❌ "문장A.[1] 문장B. 문장C."   // [1]이 중간에 박힘
```

### 6~9. detailWlb

- `wlb` / `social` 등급: **반드시 띄어쓰기 포함** ("보통 이상" — `"보통이상"` 붙여쓰기 X). validate FAIL.
- `wlbDetail` (130~200자): 근무시간·야근·교대. **임금 정보 절대 X** (sal-protection).
- `socialDetail` (100~160자): 사회적 영향·공익만. 근무환경·취업전망 X.

### 10. overviewProspect.main (전망)

- **🔒 prospect 원문 보존 규칙** — `merged_profile_json.overviewProspect.forecastList` 또는 CareerNet 원본 우선. 원문 강도 (증가/유지/감소) 그대로 유지.
- **금지**:
  - "유지하거나 다소 증가" → "증가 전망" (과장)
  - "감소" → "보통 수준" (완화)
  - 원문에 없는 긍정 전망 추가 (DX/AI/ESG 트렌드 미출처 삽입 X)

### 11. sidebarJobs

- 7~12개 plain string
- **DB 실존 확인 필수**:
```sql
SELECT name FROM jobs WHERE is_active=1 AND name IN ('직업A', '직업B');
```
- DB에 없는 항목은 제거하되, 키워드가 heroTags에 없으면 heroTags에 추가 (정보 손실 방지).
- `[N]` 마커 금지 (UI 노출).

### 12. sidebarMajors

- 3~8개 plain string `["전공명1", ...]`
- **DB 실존 확인 필수**:
```sql
SELECT name FROM majors WHERE is_active=1 AND name IN ('전공A', '전공B');
```
- `merged_profile_json.sidebarMajors` 우선 활용 + 부족분만 보강.
- `[N]` 마커 금지.

### 13. sidebarCerts

- 2~5개 `[{"name": "자격증명", "url": "https://..."}]` object 배열
- Q-net URL 우선 (`scripts/skill-cache/cert-org-mapping.json` 사전 lookup → 미발견 시 LLM 리서치).
- "~시험" 금지 — LEET·사법시험·TOEIC 등은 시험이지 자격증 X.
- `[N]` 마커 금지.

### 14. sidebarOrgs

- 1~3개 `[{"name": "기관명", "url": "https://..."}]` object 배열
- `merged_profile_json.sidebarOrgs` 우선 + 부족분만 보강.
- URL 모르면 `"url": null`.
- `[N]` 마커 금지.

### 15. heroTags

- 4~8개 plain string. 별칭/세부분류/영문명 포함.
- 조사/어미로 끝나면 FAIL (`~의`, `~이` 등). 단 "강의", "설비", "기여", "관리" 등 명사는 예외 (validate 룰에 예외 list).
- 15자 초과 FAIL.

### 16. youtubeLinks

- 1~3개 `[{"url": "https://youtube.com/watch?v=...", "title": "영상 제목"}]` object 배열
- 문자열 배열 (`["url"]`) 절대 X (UI 썸네일/제목 안 뜸).
- **한국어 영상만** 허용. 영어/외국어 영상 X. 한국어 영상 부재 시 빈 배열 + `_youtubeSearchNote`.
- oembed verify 의무 (200 응답 + title 매칭 + 직업 관련 키워드).
- title HTML entity (`&#39; &amp;`) 디코딩 의무. 디코딩 불가 시 YouTube 페이지에서 직접 복사.
- title 인코딩 깨짐 시 `--data-binary @file.json` 방식만 허용.

**`_youtubeSearchNote` 형식** (빈 배열 제출 시 의무):
```
"_youtubeSearchNote": "KEIS '직업명' 검색 0건, '직업명 현직자인터뷰' 검색 0건 (2026-04-16)"
```
- 작은따옴표 탐색어 ≥6개 OR 카테고리 ≥3개 커버 (현직자·인터뷰 / 직무·실무 / 강의·교육 / 진로·면접). 미달 시 `[YouTubeNote얕음]` FAIL.

### 17. careerTree

상세 — 아래 Phase 3.6 절차 참조.

---

## Resume Safety Check (이전 세션 재개 시)

> **신규 작업이면 바로 Phase 0으로. 이전 세션 재개 시에만 확인.**

```
[ ] 이전 세션 Self-Report 17필드 체크리스트 완성?
    → 없으면: Phase 1 처음부터 재시작
[ ] DB 현재 데이터 다시 조회 + draft와 비교?
    → 다른 세션이 중간 저장 가능 — 최신 상태 확인
[ ] validate-job-edit.cjs 미실행 + API 호출 안 했는지?
    → draft validate 통과해도 재확인 필수
```

**중단 지점별 재개**:
- Phase 0 미완료 → Phase 0-A부터 재시작
- Phase 1 진행 중 → Self-Report에서 미완료 필드부터
- Phase 2 통과 전 → validate 재실행
- Phase 3 직전 → Phase 3.5 Self-check부터

---

## Phase 3.6 — 커리어트리 생성

### 인물 선정 기준

- **한국인만** — 외국인 절대 X
- **공인만** — 위키피디아 등재 또는 공식 프로필 확인 가능
- **검증 가능한 경력만** — 공식 출처 (위키피디아·나무위키·공식 사이트) 교차 확인. 추정/소문 X
- **다양성** — 같은 직업 2~3명, 시대·분야·성별 다양
- **적합 인물 없으면 건너뛰기** — 지어내거나 억지로 X
- **살아있거나 최소 2000년 이후 경력** — 역사적 위인 X
- **🚫 역대 대통령 절대 금지** — 이승만/윤보선/박정희/최규하/전두환/노태우/김영삼/김대중/노무현/이명박/박근혜/문재인/윤석열 (validate FAIL)
- **정치인 일반** — 비대통령 정치인 (국회의원·장관) 포함 가능. 단 직업 본업 출신 우선.

### 스테이지 작성 룰

- **권장 구조**: 사전준비 → 입직 → 초기경력 → 성장 → 현재(본업)
- **반드시 하나의 스테이지에 `job_slug` 포함** — 처음 진입 스테이지에만
- 이전 스테이지 (학생, 타직업)는 `job_slug: null`
- **전직 (다른 분야로 빠짐)은 마지막 스테이지에 X** — 감독·정치인·교수 등은 제외
- **구체적 타이틀**: "서울대 체육교육과 졸업" (O) / "대학 졸업" (X)
- 수상·업적 자체를 스테이지로 만들지 X — description에 간략히 언급만

### stage_index 하이라이트

`career_tree_job_links.stage_index` = 현재 직업 페이지에서 강조될 스테이지 인덱스 (0-based):
- `job_slug` 있는 스테이지 인덱스 지정
- 본업이 여러 스테이지에 걸치면 **처음 입직한 스테이지**
- 마지막 스테이지가 전직이면 → 그 **직전의 본업 스테이지** 인덱스

### `_careerTreeNote` (null 제출 시 의무)

```
"_careerTreeNote": "조사한 인물: 홍길동(현직 작가, 해당 직업 직접 경력 없음), 김영희(2000년 이전 경력 종료). 적합 인물 없음."
```

- 이름(이유) 형식 후보 ≥5명 OR 카테고리 ≥3개 커버 (재벌·대기업 / 컨설팅 / 공공·정부 / 학계·연구 / 스타트업·CxO).
- 미달 시 `[CareerTreeNote얕음]` FAIL.

### DB 저장 (wrangler d1 직접 — Admin API 미지원)

```bash
# 1. 인물 삽입
cd C:/Users/user/Careerwiki && npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json, display_priority, is_active, created_at, updated_at)
   VALUES ('인물명', '영문명', '한 줄 소개', NULL,
   '[{\"order\":0,\"title\":\"직함\",\"organization\":\"소속\",\"years\":\"기간\",\"description\":\"설명\",\"job_slug\":null}]',
   0, 1, unixepoch()*1000, unixepoch()*1000)"

# 2. ID 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id FROM career_trees WHERE person_name='인물명' ORDER BY id DESC LIMIT 1"

# 3. 직업 연결
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES ({ID}, '{slug}', {index})"
```

### 중복 검사 (필수)

```sql
SELECT career_tree_id, job_slug, COUNT(*) as cnt
FROM career_tree_job_links WHERE job_slug = '{slug}'
GROUP BY career_tree_id HAVING cnt > 1;
-- 결과 있으면 중복 — DELETE 후 재삽입
```

stage_index 검증:
- `stage_index`가 가리키는 스테이지 타이틀이 해당 직업명 또는 입직 내용
- `stage_index === stages.length - 1`이면 거장·전직 스테이지 강조 의심 → 수정

### dedup sweep (Phase 5-DEDUP)

```bash
node scripts/skill-cache/auto-dedup-sweep.cjs --slug={slug}        # dry-run
node scripts/skill-cache/auto-dedup-sweep.cjs --slug={slug} --apply # apply
```

본 직업 self-promotion (max stage_index link) 자동 정리. 글로벌 동명이인은 보고만.

---

## Phase 5 — 각주·출처 수선 (5종 진단 코드)

Phase 4 검증 완료 직후 바로 실행. 방금 보완한 직업의 각주 번호·출처 키 상태 점검.

| 코드 | 문제 | 수선 방식 |
|---|---|---|
| **GN** | 전역 번호: 필드 내 첫 [N]이 [1]이 아님 | 자동 — 재번호 |
| **FP** | 마침표 앞 마커: `[N].` → `.[N]` | 자동 — 위치 교정 |
| **SK** | sources 키 오류: `way_sources` 등 | 자동 — 키 매핑 |
| **OM** | 고아 마커: 본문 [N]에 src 없음 | 수동 — 출처 추가 or 마커 제거 |
| **OS** | 고아 출처: src 있지만 본문 [N] 없음 | 수동 — 마커 삽입 or src 제거 |

> ⚠️ OM은 절대 자동 삭제 X. SK 때문에 src 못 찾을 수 있음. SK 수선 후 재진단.

### 5-1. 진단 (필드별 독립 판정)

```
필드마다:
  markers = 본문 [N] 번호들       (예: {4, 5, 6, 7})
  src_len = _sources[필드키] 길이  (예: 4)

  GN: min(markers) ≠ 1               → 🔴 전역번호
  FP: 텍스트에 /\[\d+\]\./ 존재       → 🟡 마침표 위치
  SK: _sources에 비표준 키 존재        → 🔴 키 오류
  OM: max(markers) > src_len          → 🔴 고아 마커
  OS: src_len > 0 AND markers 비어있음 → 🔴 고아 출처
```

### 5-2. 수선 순서 (엄수)

**SK → GN → FP → OM → OS**

(키 오류 먼저 고쳐야 고아 마커 줄어듦. GN 고쳐야 OM 판정 정확.)

```
GN 수선:
  trivia에 [4][5][6][7], sources.trivia = [{id:4..7}]
  1. 매핑 {4→1, 5→2, 6→3, 7→4}
  2. 텍스트 치환 (큰 번호부터): "[7]"→"[4]" → "[6]"→"[3]" → "[5]"→"[2]" → "[4]"→"[1]"
  3. sources id 갱신: {id:4}→{id:1}, ...

FP 수선:
  text.replace(/\[(\d+)\]\./g, '.[$1]')
  "증가했다[1]." → "증가했다.[1]"
```

### 5-3. minimal POST (변경 필드만)

```bash
curl -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @수선.json
```

`changeSummary`: `"[job-data-master] Phase 5 수선 — trivia GN 재번호"`.

---

## 주석 위치 룰 (산문 vs 리스트)

### 산문체 필드 (way / sal / prospect / trivia / wlbDetail / socialDetail / summary / technKnow)

같은 출처 연속 문장 블록의 **마지막 문장 마침표 뒤**에만 [N] 1회.

```
✅ GOOD: "A 사실이다. B 현상이 있다.[1] C 통계에 따르면 D이다.[2]"
✅ GOOD (3문장 same): "A 사실. B 현상. C 현황.[1]"
❌ BAD (중복): "A 사실이다.[1] B 현상이 있다.[1]"
❌ BAD (첫 문장만 같은 출처): "A 사실이다.[1] B 현상이 있다."
❌ BAD (마침표 앞): "활용된다. 시뮬레이션이 가능하다[1]."
```

### 리스트형 항목 (detailReady array)

마침표 없이 항목 끝에 바로 [N] 허용.

```
✅ "배관공사 관련 안전보건교육 이수[1]"
✅ "관련 학과를 졸업한다.[1]"   (마침표 있으면 마침표 뒤)
❌ "배관공사 관련 안전보건교육 이수.[1]"   (억지 마침표 X)
❌ "배관공사[1] 관련 안전보건교육 이수"    (중간 삽입 X)
```

핵심: [N]은 필드 내 1회만 (validate Rule 5 차단).

---

## 출처 등급 분류

### ✅ 1등급 (외부 핵심 — 적극 활용)
- 한국고용정보원 (keis.or.kr) — 직업전망보고서
- 한국직업능력연구원 (krivet.re.kr)
- KOSIS (kosis.kr) — 통계청
- Q-Net (q-net.or.kr) — 자격증
- 한국산업인력공단 (hrdkorea.or.kr)
- 정부 부처 정책 페이지 (moel/mohw/moe 정책 deep page)
- 협회·학회 deep page (kna/koreanbar 등)
- 대학 학과 소개 페이지

### ✅ 2등급 (적극 활용 권장)
- 업계 보고서, 통계청 별도 페이지
- 전문 미디어 (한경/매경/IT조선)
- 학술논문 (RISS/KISS/DBpia)

### 🚫 절대 금지
- **origin 도메인** (career.go.kr / work.go.kr / work24.go.kr / wagework.go.kr / job.go.kr) — 1건이라도 FAIL
- **자기 사이트** (careerwiki.org / careerwiki.kr) — 1건이라도 FAIL
- **list-page URL** — 검색결과·카테고리 페이지 (식별자 없음)
- **블라인드 / 디시인사이드 / 개인 블로그 단독**

상세 등급 + 화이트리스트: `safety-rules.md` 참조.

---

## sources 키 매핑

| sources 키 | 대상 필드 |
|---|---|
| `way` | 되는 방법 |
| `overviewSalary.sal` | 임금 (master는 수정 X) |
| `overviewProspect.main` | 전망 |
| `trivia` | 여담 |
| `summary` | 직업 설명 |
| `detailWlb.wlbDetail` | 워라밸 상세 |
| `detailWlb.socialDetail` | 사회적 기여 상세 |
| `overviewAbilities.technKnow` | 활용 기술 |
| `detailReady.curriculum` | 교육과정 배열 |
| `detailReady.recruit` | 채용 배열 |
| `detailReady.training` | 훈련 배열 |
| `detailReady.pathExplore` | 진로탐색 배열 |

흔한 키 실수:
- ❌ `way_sources` → ✅ `way`
- ❌ 숫자 키 `"1"`, `"2"` → ✅ 필드명 키
- ❌ `overviewSalary_sources` → ✅ master는 사용 X (sal-readonly)

---

## __SOURCE_FIELD_MAP__ 등록

리스트 배열 필드 (curriculum/recruit/training/certificate/researchList 등) heading 각주는 클라이언트 JS가 동적 부착. `src/templates/unifiedJobDetail.ts`의 `window.__SOURCE_FIELD_MAP__`에 fieldKey 등록 필수.

**현재 등록 필드**: `detailReady.curriculum`, `detailReady.recruit`, `detailReady.training`, `detailReady.researchList`, `detailReady.certificate`, `sidebarJobs`, `sidebarMajors`.

미등록 필드에 sources 저장 시 heading 각주 렌더링 안 됨.

---

## 차단 사이트 폴백 체인

한국 공공기관·공기업 사이트 (.go.kr, .or.kr 등)가 WebFetch에서 차단되는 경우:

1. **WebFetch 직접** — 가장 저렴
2. **Jina Reader 경유** — `https://r.jina.ai/https://TARGET_URL`
3. **Wayback Machine** — `https://web.archive.org/web/2025/URL`
4. **WebSearch** — 기관명·URL 패턴·일부 본문 추출
5. **Chrome MCP** — 최후 수단 (worktree 환경 X — 본 스킬 사용 안 함)

토큰 효율: WebFetch > WebSearch > 그 외.

---

## Phase 5-AUDIT (사후 사고 감사)

각 직업 enhance 사이클 종료 직전, 본 직업의 _sources에 사고 패턴 잔존 검사:

```bash
node scripts/skill-cache/audit-sources.cjs --pattern=mojibake --json | grep "{slug}"
node scripts/skill-cache/audit-sources.cjs --pattern=bracket_prefix --json | grep "{slug}"
node scripts/skill-cache/audit-sources.cjs --pattern=raw_url --json | grep "{slug}"
node scripts/skill-cache/audit-sources.cjs --pattern=sources_NULL --json | grep "{slug}"
```

또는 더 간단히 `audit-via-api.cjs --exclude-sal` 1회 실행으로 전체 패턴 검증.

PASS 받기 전 종료 X. 1+ 패턴 본 직업 발견 → 즉시 Phase 1 다시 (단축 처리 절대 X).

---

## 흔한 실수 카탈로그 (lessons)

- way를 배열로 작성 → 즉시 500
- detailReady 항목 `{text:..., url:...}` 객체 → UI 도메인 노출 버그
- trivia 첫/중간 sentence 뒤 [N] + 후속 sentence → `[trivia-각주중간]` FAIL
- sidebarCerts에 "~시험" 등록 → validate FAIL
- 등급 붙여쓰기 ("보통이상") → validate FAIL
- prospect 원문 강도 변경 (감소→증가) → 사실 왜곡
- careerTree에 역대 대통령 → validate FAIL
- 출처 .text에 raw URL 박기 → `[출처형식]` FAIL
- _sources["sidebarCerts"] 등록 → 룰 L FAIL
- detailReady array에 글로벌 idx [N] → 룰 J FAIL
- Windows curl 인라인 한글 → CP949 mojibake → 룰 [Mojibake] FAIL

상세 사고 history는 `_archive/job-data-enhance/references/lessons.md` 참조.
