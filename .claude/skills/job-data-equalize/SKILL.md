---
name: job-data-equalize
description: >
  직업/전공 정보보완(데이터 균등화·고도화) 스킬. 유저가 "데이터 균등화", "equalize", "정보보완",
  "기존 직업 품질 개선", "직업 데이터 고도화", "데이터 보완", "빈 필드 채워", "직업 데이터 업데이트",
  "부실 직업", "배치 처리", "user_contributed_json", "NULL 직업", "way/prospect/salary/trivia 비어있어",
  "job data equalize" 등을 말하거나 특정 직업 데이터가 부족하다고 언급할 때 반드시 이 스킬을 사용한다.
---

# 직업 정보 수준 평준화 스킬

대상 직업의 **모든 필드**를 점검하고, 기존 데이터를 최신화하며, 빈 필드를 리서치하여 출처와 함께 편집 API로 업데이트하는 전체 워크플로우.

---

## ⚠️ 원칙 0: URL 형식

- 직업 페이지: `https://careerwiki.org/job/슬러그` (careerwiki.**kr** 아님, `/jobs` 아님)
- 전공 페이지: `https://careerwiki.org/major/슬러그`
- 검증 curl, 사용자 보고 모두 이 형식 사용

---

## ⚠️ 원칙 0-B: 기존 데이터 변경 금지

- **이미 잘 작동하는 데이터는 건드리지 마라** — 특히 `overviewSalary.wage` + 구조화 포맷이 있으면 임금 바 차트가 렌더링됨. 서술형으로 바꾸면 차트가 사라짐
- 변경 시 반드시 기존보다 **공신력 있는 출처(정부기관, 공식 통계)** 필요
- 보완 전 기존 `user_contributed_json`의 해당 필드가 이미 있는지 확인 후 판단

---

## ⚠️ 원칙 1: 출처 없으면 안 넣는다 + sources 필수

- 추정값·AI 생성 수치 **절대 금지**. 출처 없으면 해당 필드를 **비워둔다**
- `fields`에 `[N]` 각주를 넣으면 `sources`도 **반드시 함께 전송** — sources 누락 시 각주 깨짐 (가장 빈번한 치명적 실수)

---

## ⚠️ 원칙 2: 저작권 검증 후 사용

- **검증 불필요**: 공공 데이터(커리어넷·고용24·통계청 등), 통계/사실 수치 자체, 공인의 공개 경력
- **검증 필수 (비공공 출처)**: 이용약관 확인 → CC/공공누리면 사용, "무단전재 금지"면 사실/수치만 **자체 문장으로 재작성**, 크롤링 금지/유료이면 사용 금지
- 어떤 출처든 **원문 그대로 복사 금지**

---

## ⚠️ 원칙 3: fields와 sources는 반드시 함께 전송

```
✅ { "fields": {"way":"..."}, "sources": {"way":[...]}, "changeSummary":"..." }
❌ { "fields": {"way":"..."}, "changeSummary":"..." }  ← sources 누락! 각주 깨짐
```

---

## ⚠️ 원칙 4: 필드별 판단 순서

```
1. user_contributed_json에 이미 해당 필드가 있는가?
   → 내용 충분 → 건드리지 않음 / 부실·2년+ → 보강/최신화 / 없음 → 아래 진행

2. merged_profile_json에 API 데이터가 있는가?
   → "항상 새로 작성" (way/detailReady/trivia/wlbDetail/socialDetail/커리어트리)
      → API와 무관하게 작성
   → "보강 가능" (sidebarCerts/sidebarMajors/overviewSalary.sal/overviewProspect.main)
      → API 충분하면 스킵, 부족하면 보강
   → "API에 있으면 스킵" (overviewWork.main/overviewAbilities.technKnow/detailWlb.wlb등)
      → API 있으면 스킵, null이면 리서치하여 채움
   → "공식 통계만 허용" (abilityList/aptitude/satisfaction/educationDistribution 등)
      → 공식 통계 있으면 채움, 없으면 null 유지 (추정값 절대 금지)

⚠️ 마이너 직업은 API 데이터가 대부분 비어있을 수 있다. "스킵" 판단 전 실제 데이터 유무 확인.
```

→ 전체 판단 매트릭스 상세: [`references/field-decision-matrix.md`](references/field-decision-matrix.md)

---

## 0. 사전 준비

**인증** (둘 중 하나): `-H "X-Admin-Secret: careerwiki-admin-2026"` (권장) 또는 `Cookie: session_token=TOKEN`

**대상 결정** — 유저 지정 없으면 아래 SQL로 선별:
```sql
SELECT id, name, slug,
  (CASE WHEN json_extract(merged_profile_json,'$.way') IS NULL OR json_extract(merged_profile_json,'$.way')='' THEN 1 ELSE 0 END) +
  (CASE WHEN json_extract(merged_profile_json,'$.overviewSalary.sal') IS NULL THEN 1 ELSE 0 END) +
  (CASE WHEN json_extract(merged_profile_json,'$.overviewProspect.main') IS NULL THEN 1 ELSE 0 END) +
  (CASE WHEN json_extract(merged_profile_json,'$.trivia') IS NULL THEN 1 ELSE 0 END) as missing_count
FROM jobs WHERE is_active=1 HAVING missing_count>=2 ORDER BY missing_count DESC LIMIT 30
```
실행: `npx wrangler d1 execute careerwiki-kr --remote --command "SQL문"`

---

## 1. 현황 분석

**전수 점검 쿼리:**
```sql
SELECT id, name, slug,
  substr(json_extract(merged_profile_json,'$.way'),1,200) as way_preview,
  json_extract(merged_profile_json,'$.overviewSalary.sal') as salary,
  json_extract(merged_profile_json,'$.trivia') as trivia,
  json_extract(user_contributed_json,'$._sources') IS NOT NULL as has_sources
FROM jobs WHERE name IN ('직업명') AND is_active=1
```

**점검 항목**: `way` (자격요건·합격률), `overviewSalary.sal` (연도 확인), `overviewProspect.main` (최신 전망), `trivia` (현실적 통찰), `_sources` (URL 유효성)

**사이드바 필드** (출처 불필요, DB 존재 확인 필수):
- `sidebarJobs`: 7~12개. `SELECT name FROM jobs WHERE is_active=1 AND name IN (...)`
  - ⚠️ **직업명은 DB의 `name` 컬럼 값을 그대로 사용** — URL 인코딩·슬러그 변환 금지 (프론트엔드가 처리)
- `sidebarMajors`: `SELECT name FROM majors WHERE is_active=1 AND name IN (...)`
- `sidebarCerts`: 자격증만 (`"~시험"` 금지). `[{name, url}]`
- **기존 데이터도 검증**: 15개+ → 7~12개로 정리, 관련성 낮은 것 제거, 핵심 누락 추가
- **heroTags도 검증**: 부실하면 개선 (별칭/세부분류/영문명 추가)

---

## 2. 리서치

**필수 채울 필드** (건너뛰면 안 됨):

> ⚠️ **way vs detailReady 구분**: `way`는 페이지 "되는 방법" 섹션에 서술형으로 렌더링. `detailReady`는 교육과정/채용/훈련 섹션에 배열 구조로 렌더링. 혼동 금지.

| 필드 | 분량 | 주의 |
|------|------|------|
| `way` | 200-500자, `\n` 단락 | **"되는 방법" 서술형 텍스트**. 자격요건·시험·진입경로·실무팁. 교육과정 목록 나열 금지 (→ detailReady) |
| `detailReady.curriculum` | `string[]` 5개+ | **교육과정** 배열 목록 |
| `detailReady.recruit` | `string[]` | 채용경로 |
| `overviewSalary.sal` | 200-300자 | 공식 형식(하위25%/평균/상위25%) → 차트. 비공식 → 서술형+각주 |
| `overviewProspect.main` | 200-400자 | "~전망됩니다" 톤 |
| `trivia` | **1개만** | 업계 현실·이직률·의외의 통계. 출처 없으면 금지 |
| `detailWlb.wlbDetail` | 130~200자 | 근무시간·야근·교대. **임금 정보 금지** |
| `detailWlb.socialDetail` | 100~160자 | 사회적 영향·공익만. **근무환경·취업전망 금지** |
| `youtubeLinks` | 2~3개 | 해당 직업 관련 YouTube 영상. oembed 실존 확인 필수. 최신(1~2년 이내) 우선. **title 필수** (없으면 URL이 제목으로 노출) |
| 커리어트리 | DB INSERT | 한국인만. → `../shared/career-tree.md` |

**youtubeLinks 보완 절차**:
1. YouTube 검색(`youtube.com/results?search_query=직업명`) 또는 WebSearch로 관련 영상 후보 수집
2. 각 후보 영상을 `https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v={VIDEO_ID}&format=json` 로 **실존 확인** — 200 응답이어야 함
3. **진로 탐색 목적 영상 우선**: 진로 가이드·현직자 인터뷰·전망 분석 > 단순 일과 vlog
4. 최신(1~2년 이내) 영상 우선; shorts 영상도 허용
5. `youtubeLinks`: **`[{url, title}]` 형식** — `title` 반드시 포함 (oembed 응답 `title` 값 사용). 출처 불필요

**기존 데이터 최신화**: 2년+ 된 수치 → 최신 통계로 교체. 출처 URL 404 → 최신 URL로 교체.

**출처 수집**: 협회/단체 → 정부통계(커리어넷/워크넷/KOSIS) → 뉴스 → 대학. 반드시 **세부 페이지 URL** 수집. WebFetch로 수치가 실제로 존재하는지 **내용 대조 필수**.

커리어넷 URL: `https://www.career.go.kr/cloud/w/job/view?seq={job_cd}` (구버전 금지)

**각주 핵심** (→ 상세: `../shared/footnote-validation.md`):
- `합니다.[1]` (O) / `합니다[1].` (X) — 마침표 **뒤**에 각주
- 같은 `[N]` 한 필드에 **정확히 1회만**. 필드별 `[1]`부터 순차. sources 배열 길이 = 본문 최대 `[N]`

---

## 3. 편집 API 호출

```
POST https://careerwiki.org/api/job/{id}/edit
Content-Type: application/json
X-Admin-Secret: careerwiki-admin-2026
```

**요청 Body:**
```json
{
  "fields": {
    "way": "간호학과 졸업 후 국가시험에 합격해야 합니다.[1] 2024년 합격률은 95.4%입니다.[2]",
    "trivia": "간호사 신규 입직 1년 내 이직률은 45.5%이다.[1]"
  },
  "sources": {
    "way": [
      {"text": "[1] 대한간호협회 간호사 되기 안내", "url": "https://www.koreanurse.or.kr/about_KNA/nurse.php"},
      {"text": "[2] 한국보건의료인국가시험원 2024 통계", "url": "https://www.kuksiwon.or.kr/peryear/fixExamResultList.do"}
    ],
    "trivia": [{"text": "[1] 병원간호사회 신규간호사 실태조사", "url": "https://..."}]
  },
  "changeSummary": "way 최신 합격률 보완, trivia 1개 추가"
}
```

**sources 키 매핑** (→ 전체: `../shared/source-key-mapping.md`):
- ❌ `way_sources` → ✅ `way` / ❌ `overviewSalary_sources` → ✅ `overviewSalary.sal`
- ❌ `detailWlb_sources` → ✅ `detailWlb.wlbDetail` / ❌ 숫자 키 → ✅ 필드명 키
- `text`에 URL 포함 금지 — `{"text": "[1] 출처명", "url": "https://..."}` 반드시 분리

**구조화 데이터**: `overviewAptitude`, `detailEducation`, `detailWlb`, `detailReady`는 **통째로 객체로** 전송 (점 표기법 불가):
```json
"detailWlb": {"wlb":"보통이상","social":"좋음","wlbDetail":"주 5일 근무.[1]","socialDetail":"사회적 역할.[1]"}
```

---

## 4. 출처 검증 (편집 API 호출 전 필수)

```
각 출처 URL마다:
[ ] WebFetch로 직접 읽어 해당 수치/사실이 실제로 존재하는지 확인
[ ] 수치가 출처와 정확히 일치하는가? (연도·기준도 확인)
[ ] curl -s -o /dev/null -w "%{http_code}" "URL" → 200/301/302만 허용
```

**각주 중복 자동 검사** (필수):
```javascript
function validateFootnotes(text, fieldName) {
  const counts = {};
  (text.match(/\[(\d+)\]/g)||[]).forEach(m => { counts[m] = (counts[m]||0)+1; });
  const dupes = Object.entries(counts).filter(([_,c])=>c>1);
  if (dupes.length) throw new Error(`${fieldName}: [N] 중복 — ${dupes.map(([n,c])=>`${n}이 ${c}회`).join(', ')}`);
}
```
중복 발견 시: 두 문장을 합쳐 `[N]` 1회만 남기기.

**validate-job-edit.cjs 실행** (PASS 확인 후에만 API 호출):
```bash
node scripts/validate-job-edit.cjs < draft.json   # FAIL → 수정 후 재실행
```

---

## 5. 프로덕션 검증 (편집 API 호출 후)

```bash
curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep "확인할 키워드"
```

**확인 항목**: way/salary/prospect/trivia 표시 확인 | 출처 클릭 가능 URL | 각주 1~N 순차 + hover 툴팁 | `**볼드 잔류 없음**` | 기존 데이터 유지 | youtubeLinks title 있는지 확인

**full-quality-audit.cjs 단건 실행** (⚠️ PASS 없이 다음 직업으로 넘어가는 것 절대 금지):
```bash
node scripts/full-quality-audit.cjs --slug={직업slug}
# FAIL → 이슈 수정 → validate 재검증 → API 재호출 → PASS 확인 후 다음 직업
```

---

## 6. 실행 패턴

### 단일 직업
```
[평준화] 전수 점검 → 원칙4 매트릭스로 필드 결정 → 웹 리서치 → URL 검증
[고도화] 기존 데이터 연도 파악 → 2년+ 수치 최신화 → 404 URL 교체 → trivia 점검
[저장]  WebFetch 출처 대조 → 각주 중복 검사 → validate PASS
        → 편집 API (fields+sources 함께) → 커리어트리 INSERT (한국인만)
[재검토] validate 재검증 → curl 확인 → full-quality-audit PASS → 다음 직업 진행
```

### 대량 (10개+) — 2단계 분리
```
Phase 1 [팀 리더]: DB 쿼리로 대상 선별 + 현재 데이터 상태 요약

Phase 2 [Researcher Agent × 3 병렬]:
  ⚠️ API 호출 금지 — JSON 결과만 반환
  → 프롬프트: references/researcher-agent-prompt.md

Phase 3 [팀 리더 — 검증+API]:
  validate PASS → 편집 API → sidebarJobs/Majors DB 확인 → 출처 URL curl 검증

Phase 4 [프로덕션 확인]:
  curl + full-quality-audit PASS → 다음 직업 진행
  배치 완료 후 QA 스크립트 실행 (각주 순서 자동 검증)
```

---

## 참조 파일

| 파일 | 내용 |
|------|------|
| [`references/field-decision-matrix.md`](references/field-decision-matrix.md) | 원칙 4 전체 판단 매트릭스 + 구조화 데이터 타입 |
| [`references/researcher-agent-prompt.md`](references/researcher-agent-prompt.md) | Researcher 에이전트 복사용 프롬프트 + 성공/실패 예시 |
| [`../shared/career-tree.md`](../shared/career-tree.md) | 커리어트리 인물 선정·스테이지 작성·DB 삽입 가이드 |
| [`../shared/footnote-validation.md`](../shared/footnote-validation.md) | 각주 검증 시스템 상세 (중복 검사·품질 체크리스트) |
| [`../shared/source-key-mapping.md`](../shared/source-key-mapping.md) | sources 소스 키 전체 매핑표 |

> ⚠️ `shared/` 파일들은 별도 태스크에서 생성 예정. 미존재 시 이 파일의 관련 섹션 참고.
