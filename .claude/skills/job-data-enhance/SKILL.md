---
name: job-data-enhance
description: >
  CareerWiki 직업 데이터 고도화 스킬 (ultimate). job-supplement + job-data-equalize 통합판.
  직업 데이터 현황 자동 진단 → 12개 필드 보완 → 4중 품질 게이트(각주/완결성/유튜브/출처순서) →
  편집 API 저장 → 프로덕션 검증까지 전체 워크플로우를 실행한다.
  유저가 "데이터 보완", "직업 보완", "균등화", "equalize", "부실 직업", "NULL 직업", "데이터 채워줘",
  "직업 데이터 업데이트", "배치 처리", "품질 고도화", "job data enhance", "정보보완",
  "way/salary/trivia 비어있어", "user_contributed_json", "직업 데이터 개선" 등을 언급하면
  반드시 이 스킬을 사용한다. 단일 직업이든 수백 개 배치든 이 스킬이 처리한다.
---

# CareerWiki 직업 데이터 고도화 스킬

두 스킬(job-supplement, job-data-equalize)을 통합한 최종 워크플로우.
**Phase 0 진단 → Phase 1 보완 → Phase 2 품질 게이트 → Phase 3 저장 → Phase 4 검증** 순서로 진행.

---

## ⚡ 핵심 기술 규칙 (항상 적용)

| 규칙 | 내용 |
|------|------|
| `way` 타입 | **반드시 string** — 배열이면 즉시 500 에러 |
| 편집 API URL | `POST https://careerwiki.org/api/job/{id}/edit` |
| 직업 페이지 URL | `https://careerwiki.org/job/슬러그` (`.kr` 또는 `/jobs` 절대 금지) |
| R2 이미지 키 | `jobs/job-{slug}.webp` — `uploads/` prefix 절대 금지 |
| DB image_url | `/uploads/jobs/job-{slug}.webp?v={timestamp}` |
| 인증 헤더 | `-H "X-Admin-Secret: careerwiki-admin-2026"` |
| 배포 | **반드시 main 브랜치** — worktree에서 배포하면 다음 main 배포 시 롤백됨 |
| DB 명령 | `npx wrangler d1 execute careerwiki-kr --remote --command "SQL문"` |
| 프로젝트 경로 | `C:\Users\PC\Careerwiki` |

---

## ⚠️ 필드별 판단 원칙 (작업 전 숙지)

```
1. user_contributed_json에 이미 해당 필드가 있는가?
   → 내용 충분 → 건드리지 않음
   → 부실·2년+ 됐으면 → 보강/최신화
   → 없음 → 아래로

2. merged_profile_json에 API 데이터가 있는가?
   → "항상 새로 작성" (way/detailReady/trivia/wlbDetail/socialDetail/커리어트리)
      → API와 무관하게 반드시 작성
   → "보강 가능" (sidebarCerts/sidebarMajors/overviewSalary.sal/overviewProspect.main)
      → API 충분하면 스킵, 부족하면 보강
   → "API에 있으면 스킵" (overviewWork.main/overviewAbilities.technKnow/detailWlb.wlb 등)
      → API 있으면 스킵, null이면 리서치하여 채움
   → "공식 통계만 허용" (abilityList/aptitude/satisfaction/educationDistribution 등)
      → 공식 통계 있으면 채움, 없으면 null 유지 (추정값 절대 금지)

⚠️ 마이너 직업은 API 데이터가 대부분 비어있을 수 있다. "스킵" 판단 전 실제 데이터 유무 확인.
```

→ 전체 판단 매트릭스: `references/field-decision-matrix.md`

---

## Phase 0: 현황 진단 (항상 먼저 실행)

작업 전 대상 직업의 현재 상태를 자동 진단한다. 기존 데이터를 덮어쓰는 사고를 막는다.

### 0-A. 대상 선택

유저가 직업을 지정하면 해당 직업 조회, 아니면 아래 SQL로 선별:

```sql
SELECT id, name, slug,
  (CASE WHEN json_extract(merged_profile_json,'$.way') IS NULL OR json_extract(merged_profile_json,'$.way')='' THEN 1 ELSE 0 END) +
  (CASE WHEN json_extract(merged_profile_json,'$.overviewSalary.sal') IS NULL THEN 1 ELSE 0 END) +
  (CASE WHEN json_extract(merged_profile_json,'$.overviewProspect.main') IS NULL THEN 1 ELSE 0 END) +
  (CASE WHEN json_extract(merged_profile_json,'$.trivia') IS NULL THEN 1 ELSE 0 END) as missing_count
FROM jobs WHERE is_active=1 HAVING missing_count>=2 ORDER BY missing_count DESC LIMIT 30;
```

### 0-B. 현황 분석 쿼리

```sql
SELECT id, name, slug,
  substr(json_extract(merged_profile_json,'$.way'),1,200) as way_preview,
  json_extract(merged_profile_json,'$.overviewSalary.sal') as salary_preview,
  json_extract(merged_profile_json,'$.overviewProspect.main') as prospect_preview,
  json_extract(merged_profile_json,'$.trivia') as trivia_preview,
  json_extract(user_contributed_json,'$._sources') IS NOT NULL as has_sources,
  LENGTH(user_contributed_json) as ucj_len
FROM jobs WHERE name IN ('직업명') AND is_active=1;
```

### 0-C. 진단 결과 보고 형식

```
[직업명] 진단 결과:
✅ way: 존재 (350자) / ❌ way: 없음
✅ salary: 기존 wage 차트 있음 → sal 텍스트만 보강 가능
❌ prospect: 없음 → 작성 필요
⚠️  trivia: 2022년 데이터 → 최신화 필요
❌ detailWlb: wlb/social 등급 없음 → 요약 카드 공란 렌더링 중
✅ youtubeLinks: 2개 (oembed 검증 필요)
⚠️  _sources: 구형 포맷 → A등급으로 업그레이드 필요
```

**기존 데이터 변경 금지 원칙**: `overviewSalary.wage` + 구조화 포맷이 있으면 절대 덮어쓰지 않는다.
임금 바 차트가 사라지기 때문. `sal` 텍스트 보강만 허용.

---

## Phase 1: 필드 보완 (리서치 + 데이터 작성)

→ 필드별 타입/길이/포맷 상세: `references/fields.md`
→ 필드별 처리 판단(API 데이터 활용 여부): `references/field-decision-matrix.md`

### 필수 채울 필드 (항상 새로 작성, 건너뛰면 안 됨)

| 필드 | 분량 | 핵심 주의 |
|------|------|----------|
| `way` | 200~500자, string | **배열 절대 금지**. 서술형 진로 경로 (자격요건·시험·진입경로). 교육과정 목록 나열 금지 → detailReady |
| `detailReady` | curriculum 5개+, recruit 3+, training 2+ | 교육과정/채용/훈련 **배열** (way와 혼동 금지) |
| `trivia` | 출처 있는 팩트 1개 | 뻔한 직업 설명 금지. 의외의 통계/현실 |
| `detailWlb.wlbDetail` | 130~200자 | 근무시간·야근·교대. **임금 정보 절대 금지** |
| `detailWlb.socialDetail` | 100~160자 | 사회적 영향·공익만. 근무환경·취업전망 금지 |
| `detailWlb.wlb` / `.social` | 등급 string | **반드시 포함** — 누락 시 페이지 요약 카드 공란. 유효값: 높음/보통이상/보통/보통이하/낮음 |

### 보강 가능 필드

| 필드 | 판단 기준 |
|------|----------|
| `overviewSalary.sal` | 기존 서술 있으면 유지. 없거나 2년+ 됐으면 최신화. wage는 절대 덮어쓰지 않음 |
| `overviewProspect.main` | 기존 서술 있으면 유지. 없거나 부실하면 보강 |
| `overviewWork.main` | API 데이터 없을 때(null)만 — 수행 직무 서술형 (출처+각주 필수) |
| `overviewAbilities.technKnow` | API 데이터 없을 때(null)만 — 활용 기술 서술형 (출처+각주 필수) |
| `sidebarJobs` | 7~12개, **반드시 DB 실존 확인** |
| `sidebarMajors` | 3~5개, **반드시 DB 실존 확인** |
| `sidebarCerts` | 2~4개, `[{name, url}]` 형식, "~시험" 금지, 자격증명만 |
| `heroTags` | 4~8개, 별칭/세부분류/영문명 포함 |
| `youtubeLinks` | 1~3개, oembed 검증 필수 |

**DB 실존 확인 쿼리:**
```sql
SELECT name FROM jobs WHERE is_active=1 AND name IN ('직업A', '직업B', '직업C');
SELECT name FROM majors WHERE is_active=1 AND name IN ('전공A', '전공B');
```
> ⚠️ 사이드바에 DB에 없는 직업/전공을 넣으면 404 링크가 생성됨

### 출처 수집 규칙

**우선순위:**
1등급: 커리어넷(career.go.kr) · 워크넷(work.go.kr) · 한국고용정보원(keis.or.kr) · KOSIS · Q-net
2등급: 직업백과(job.asamaru.net) · 협회·학회 공식 사이트 · 대학 학과 소개
❌ 금지: 블라인드, 디시인사이드, 블로그 단독 출처

**커리어넷 URL (신형만 사용):**
```
https://www.career.go.kr/cloud/w/job/view?seq={job_cd}   ← 반드시 이 형식
```
구버전(`/cnet/front/base/job/jobView.do`) 사용 금지 — 링크가 깨지는 경우 있음

**저작권 원칙 (비공공 출처 사용 시):**
- CC/공공누리 표시 → 사용 가능
- "무단전재 금지" → 수치/사실만 **자체 문장으로 재작성** (원문 복사 금지)
- 크롤링 금지/유료 → 사용 금지
- 어떤 출처든 **원문 그대로 복사 금지**

**반드시 WebFetch로 내용 대조**: 출처 URL에 해당 수치/사실이 실제로 존재하는지 확인. "이 URL이면 이 내용이 있겠지" 추정 금지.

→ 출처 등급/포맷 상세: `references/sources.md`
→ sources 키 매핑: `../shared/source-key-mapping.md`

---

## Phase 2: 품질 게이트 (4가지 — 전부 PASS해야 저장 가능)

이 단계는 건너뛸 수 없다. 4개 게이트를 모두 통과한 뒤에만 Phase 3으로 진행.

### Gate 1: 각주 검증 (Footnote Validation)

→ 상세: `../shared/footnote-validation.md`

```javascript
// 필드별 [N] 중복 검사 (반드시 실행)
function validateFootnotes(text, fieldName) {
  const counts = {};
  (text.match(/\[(\d+)\]/g)||[]).forEach(m => { counts[m] = (counts[m]||0)+1; });
  const dupes = Object.entries(counts).filter(([_,c])=>c>1);
  if (dupes.length) throw new Error(`${fieldName}: [N] 중복 — ${dupes.map(([n,c])=>`${n}이 ${c}회`).join(', ')}`);
}
```

체크리스트:
- [ ] 각 `[N]`이 해당 필드에서 1회만 등장하는가?
- [ ] `[N]` 번호가 **필드별** 1부터 순차 증가하는가? (건너뛰기 금지: `[1][3]` ← 불가)
  - ⚠️ **주의**: 번호는 필드 간 공유 안 함. way=[1][2], sal=[1], trivia=[1][2] 각각 독립 번호 사용
  - editService가 저장 시 자동으로 전역 ID를 재할당 → 페이지에 [3],[4] 등으로 표시됨
- [ ] 각주 위치: `합니다.[1]` (O) / `합니다[1].` (X) — 마침표 **뒤**에
- [ ] sources[필드키] 배열 길이 = 해당 필드 최대 `[N]` 번호와 일치하는가?
  - 예: sal에 `[1]` → sources["overviewSalary.sal"] = 1개 / trivia에 `[1][2]` → sources["trivia"] = 2개
- [ ] sources 내 `id` 값도 per-field [1]부터 시작 (`{"id":1,...}`, `{"id":2,...}`)

### Gate 2: 텍스트 완결성 검증 (절단 문장 감지)

서술형 필드(`way`, `trivia`, `overviewSalary.sal`, `overviewProspect.main`, `detailWlb.wlbDetail`, `detailWlb.socialDetail`)에서 문장이 중간에 잘렸는지 검사.

**잘린 문장 패턴 (발견 시 반드시 수정):**
- 조사/어미로 끝남: `"...부상 시"`, `"...으로 인해"`, `"...경우에는"`, `"...에 따르면"`
- 동사 어간으로 끝남: `"...가능하"`, `"...필요하"`, `"...이루어지"`
- 숫자/단위로 끝남: `"...2024년"`, `"...억 원"`, `"...% 이상"`

검증법: 마지막 문장이 `마침표(.)` 또는 `~습니다/~입니다/~됩니다/~합니다` 등 완성형 어미로 끝나는지 확인.

### Gate 3: YouTube 제목 관련성 체크

youtubeLinks의 모든 영상에 대해:

```bash
curl -s "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=VIDEO_ID&format=json"
```

체크리스트:
- [ ] oembed 200 응답인가? (삭제/비공개 영상 제외)
- [ ] `title` 필드가 존재하는가? (없으면 UI에 URL이 그대로 노출됨)
- [ ] 영상 제목에 직업명 또는 관련 키워드가 포함되어 있는가?
  - ✅ "간호사 되는 법", "간호사 현직자 인터뷰", "간호 국시 준비 방법"
  - ❌ "내 하루 브이로그", "2024 맛집 추천" (직업명/관련 키워드 없음)
- [ ] 진로 탐색 목적 영상인가? (진로 가이드 > 현직자 인터뷰 > 전망 > vlog)

### Gate 4: 출처 ID 순서 검증

각 필드의 sources 배열 내 id가 해당 필드의 [N] 등장 순서와 일치하는지 확인.

**검증 절차 (per-field 방식):**
각 필드별로 독립 검증:
- way에 `[1]`, `[2]` → sources["way"] = [{id:1,...}, {id:2,...}] ✅
- sal에 `[1]` → sources["overviewSalary.sal"] = [{id:1,...}] ✅
- trivia에 `[1]`, `[2]` → sources["trivia"] = [{id:1,...}, {id:2,...}] ✅

```
❌ 구버전 (전역 번호 — full-quality-audit FAIL):
sal: "[3]" sources["overviewSalary.sal"]: [{id:3}]  ← FAIL

✅ 현행 (per-field 번호):
sal: "[1]" sources["overviewSalary.sal"]: [{id:1}]  ← PASS
```

> 💡 editService가 저장 시 자동으로 전역 ID를 재할당하므로, 페이지에서는 [3],[4] 등 전역 번호가 표시되는 것이 정상.

---

## Phase 3: 저장 (편집 API 호출)

### 3-A. 사전 검증 스크립트 실행

```bash
# PASS 확인 후에만 API 호출 (FAIL이면 수정 후 재실행)
node scripts/validate-job-edit.cjs < draft.json
```

### 3-B. 편집 API 호출

**fields + sources는 반드시 함께 전송.** sources 없이 fields만 보내면 각주가 깨진다.

```bash
curl -s -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "Content-Type: application/json" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -d '{
    "fields": {
      "way": "...[1] ...[2]",
      "trivia": "...[1]",
      "detailWlb": {"wlb":"보통이하","social":"높음","wlbDetail":"...[1]","socialDetail":"...[2]"}
    },
    "sources": {
      "way": [
        {"text": "[1] 커리어넷 직업백과", "url": "https://www.career.go.kr/..."},
        {"text": "[2] 워크넷 직업정보", "url": "https://www.work.go.kr/..."}
      ],
      "trivia": [{"text": "[1] 한국고용정보원", "url": "https://www.keis.or.kr/..."}],
      "detailWlb.wlbDetail": [{"text": "[1] 직업백과", "url": "https://job.asamaru.net/..."}],
      "detailWlb.socialDetail": [{"text": "[2] 워크넷", "url": "https://www.work.go.kr/..."}]
    },
    "changeSummary": "way·trivia·detailWlb 최신 정보로 보완"
  }'
# 응답: {"success": true} 확인. false이면 오류 메시지 확인 후 수정
```

**sources 키 오류 주의** (→ 전체: `../shared/source-key-mapping.md`):
- ❌ `way_sources` → ✅ `way`
- ❌ `overviewSalary_sources` → ✅ `overviewSalary.sal`
- ❌ `detailWlb_sources` → ✅ `detailWlb.wlbDetail`
- ❌ 숫자 키 `"1"`, `"2"` → ✅ 필드명 키

**구조화 데이터는 통째로 전송** (점 표기법 불가):
```json
"detailWlb": {"wlb":"보통이하","social":"높음","wlbDetail":"...","socialDetail":"..."}
```

### 3-C. 커리어트리 연결 (선택 — 한국인 공인만)

→ 인물 선정 기준·스테이지 작성·DB 삽입 상세: `../shared/career-tree.md`

삽입 방법 요약 (직접 wrangler d1 사용 — Admin API 미지원):
```bash
# 1. 인물 삽입
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json, display_priority, is_active, created_at, updated_at) VALUES ('인물명', '영문명', '한 줄 소개', NULL, '[{\"order\":0,\"title\":\"직함\",\"job_slug\":null}]', 100, 1, unixepoch()*1000, unixepoch()*1000)"

# 2. 삽입된 ID 확인 후 직업 연결
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES ({ID}, '{slug}', {해당직업스테이지인덱스})"
```

> ⚠️ `job_slug`는 해당 직업에 **처음 진입하는 스테이지에만** 설정. 이전 스테이지(학생, 타직업)는 반드시 null.

---

## Phase 4: 프로덕션 검증

```bash
# 1. 기본 접속 확인
curl -s -o /dev/null -w "%{http_code}" "https://careerwiki.org/job/{slug}"
# 200 = 정상 / 500 = JSON 파싱 에러 (way 배열 여부, 따옴표 이스케이프 확인)

# 2. 캐시 우회 후 내용 확인
curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep "확인할키워드"

# 3. 전체 품질 감사 (PASS 없이 다음 직업으로 넘어가는 것 절대 금지)
node scripts/full-quality-audit.cjs --slug={직업slug}
# FAIL → 이슈 수정 → validate 재검증 → API 재호출 → PASS 확인 후 다음 직업
```

**확인 항목:**
- [ ] HTTP 200 응답
- [ ] way/salary/prospect/trivia 텍스트가 페이지에 표시되는가?
- [ ] 각주 번호 클릭 시 올바른 출처로 이동하는가?
- [ ] youtubeLinks 영상 제목이 올바르게 표시되는가? (URL 문자열 노출 아닌지)
- [ ] `**볼드 잔류 없음**` — 서술 필드에 마크다운 `**...**` 텍스트가 남아있지 않은가?
- [ ] 기존에 있던 데이터가 사라지지 않았는가?

---

## 배치 처리 (10개+ 직업)

대량 처리는 **3단계 분리** 패턴을 사용한다.

### 단계 1: 팀 리더 — 대상 선별 + 현황 요약
Phase 0 쿼리로 대상 목록 생성. 각 직업의 현재 데이터 상태 요약.

### 단계 2: Researcher Agent × 3 병렬 (리서치만, API 호출 금지)
→ 에이전트 프롬프트 템플릿: `references/researcher-agent-prompt.md`

```
병렬 에이전트 분배 예시 (30개 배치):
- Agent A: 직업 1~10
- Agent B: 직업 11~20
- Agent C: 직업 21~30
⚠️ 각 에이전트는 JSON + qualityGates 결과만 반환. 편집 API 호출 금지.
```

### 단계 3: 팀 리더 — 검증 + API 호출 + 프로덕션 확인
1. 에이전트 결과 JSON 수집
2. **Phase 2 품질 게이트 4개** 전부 PASS 확인 (FAIL 직업은 수동 수정 후 재처리)
3. sidebarJobs/sidebarMajors DB 실존 확인
4. validate-job-edit.cjs PASS 후 편집 API 호출
5. full-quality-audit.cjs PASS 확인

### 배치 완료 보고 형식

```
처리 완료: X개 (성공 Y개 / 실패 Z개)
성공: [직업명1, 직업명2, ...]
실패: [직업명A (원인), 직업명B (원인)]
커버리지: N → M / 6,945
```

---

## 체크리스트

### 작업 전
- [ ] Phase 0 진단 완료 (각 직업 현황 파악)
- [ ] `references/lessons.md` 확인 (과거 실수 반복 방지)

### 각 직업 완료 후
- [ ] Gate 1: 각주 중복 없음, 1부터 순차, 마침표 뒤 위치
- [ ] Gate 2: 모든 서술 필드가 완성된 문장으로 끝남
- [ ] Gate 3: YouTube oembed 200 + title 포함 + 직업 관련 키워드 포함
- [ ] Gate 4: _sources id 순서 = 본문 [N] 첫 등장 순서
- [ ] way는 string 타입 (배열 아님)
- [ ] detailWlb.wlb + .social 등급 포함 (높음/보통이상/보통/보통이하/낮음 중 하나)
- [ ] sidebarCerts `[{name, url}]` 포맷 사용
- [ ] fields + sources 함께 전송
- [ ] 기존 overviewSalary.wage 건드리지 않음
- [ ] validate-job-edit.cjs PASS
- [ ] HTTP 200 + full-quality-audit.cjs PASS

### 배치 완료 후
- [ ] 처리 건수 보고
- [ ] 실패 건 원인 분석
- [ ] 커버리지 변화 보고

---

## 참조 파일

| 파일 | 내용 |
|------|------|
| `references/fields.md` | 12개 필드 타입·길이·포맷 상세 스펙 |
| `references/sources.md` | 출처 등급 분류 + A등급 포맷 예시 |
| `references/field-decision-matrix.md` | API 데이터 있을 때 필드별 처리 판단 매트릭스 |
| `references/researcher-agent-prompt.md` | 병렬 리서치 에이전트 프롬프트 템플릿 |
| `references/lessons.md` | 과거 실수 교훈 모음 (새 작업 전 필독) |
| `../shared/career-tree.md` | 커리어트리 인물 선정·스테이지 작성·DB 삽입 상세 |
| `../shared/footnote-validation.md` | 각주 검증 시스템 상세 |
| `../shared/source-key-mapping.md` | sources 소스 키 전체 매핑표 |
