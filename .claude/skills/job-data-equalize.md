---
name: job-data-equalize
description: 직업/전공 정보보완(데이터 균등화) 스킬. 대상 직업/전공의 빈 필드를 리서치하여 출처와 함께 채우고, 기존 데이터의 최신성을 검증하여 업데이트한다. 유저가 "정보보완", "데이터 균등화", "데이터 보완", "빈 필드 채워", "정보 수준 평준화", "직업 데이터 보완", "job data equalize" 등을 말하거나, 특정 직업/전공의 데이터가 부족하다고 언급할 때 반드시 이 스킬을 사용한다. 직업 페이지의 way, prospect, salary, trivia, wlb 등 필드가 비어있다는 이야기가 나올 때도 트리거한다.
---

# 직업 정보 수준 평준화 스킬

대상 직업(들)의 **모든 필드**를 점검하고, 기존 데이터의 최신성을 검증하며, 빈 필드를 리서치하여 채우고, 출처와 함께 편집 API로 업데이트하는 전체 워크플로우.

---

## ⚠️ 최우선 원칙 1: 출처 없으면 안 넣는다 + sources 필수 전송

**모든 데이터에는 반드시 출처가 있어야 한다.** 이것은 절대 원칙이다.

- 공식 통계를 **최대한** 찾아서 넣되, 찾을 수 없으면 **해당 필드를 비워둔다**
- 추정값, AI가 생성한 수치, 근거 없는 데이터는 **절대 넣지 않는다**
- 텍스트 필드든 구조화 데이터 필드든 동일한 원칙 적용
- 이 원칙은 "빈 필드보다 잘못된 데이터가 더 나쁘다"는 판단에 기반함

**⚠️ sources 전송 필수**: 본문에 `[N]` 각주를 넣었으면 편집 API에 반드시 `sources` 객체도 함께 전송. sources 누락 시 각주가 깨짐. (원칙 3 참고)

---

## ⚠️ 최우선 원칙 2: 저작권 검증 후 사용

정보를 가져올 때 **반드시 해당 사이트의 이용약관/저작권 정책을 확인**하고, 안전한 것만 사용한다.

### 저작권 검증 불필요 (자유 사용 가능)
아래 유형은 저작권 보호 대상이 아니므로 별도 검증 없이 사용 가능:
- **정부/공공 데이터**: 커리어넷, 고용24, 인사혁신처, 교육부, 국가법령정보센터, 통계청, e-나라지표 등 (공공누리/저작권법 제24조의2)
- **통계/사실 데이터**: 임금 수치, 합격률, 종사자 수, 경쟁률 등 팩트 자체
- **자격증/교육과정 정보**: Q-net, 대학 교과과정, 시험 과목 등 공개 정보
- **공인의 공개 경력**: 커리어트리용 공인 인물의 공개된 이력 사실

### 저작권 검증 필수 (사용 전 반드시 확인)
위 유형에 해당하지 않는 출처(언론사, 블로그, 민간 보고서, 백과사전 등)는 **반드시 아래 절차를 거쳐야** 한다:

**검증 절차:**
1. 해당 사이트의 이용약관(Terms of Use) 또는 저작권 안내 페이지를 WebFetch로 확인
2. 아래 기준으로 판단:

| 판단 | 조건 | 예시 |
|------|------|------|
| ✅ 사용 가능 | CC 라이선스(CC-BY, CC-BY-SA 등), 공공누리, "자유롭게 인용 가능" 명시, robots.txt에서 허용 | 위키백과(CC-BY-SA), 공공기관 보도자료 |
| ⚠️ 팩트만 추출 | "무단 전재/재배포 금지" 명시되었으나 사실 정보는 저작권 대상 아님 | 언론사 기사 → 수치/사실만 추출, 자체 문장으로 재작성 |
| ❌ 사용 금지 | "크롤링 금지", "API 외 접근 불가", 유료 콘텐츠, 로그인 필요 콘텐츠 | 유료 보고서, 구독제 기사 |

**핵심 규칙:**
- 어떤 출처든 **원문을 그대로 복사하지 않는다** — 반드시 사실을 추출하고 자체 문장으로 재작성
- 나무위키(CC-BY-NC-SA): 사실 참고만 가능, 문장 복사 금지 (NC=비상업적 조건)
- 언론 기사: 보도된 사실/수치는 사용 가능, 기사 문장 자체는 복사 금지
- 판단이 애매한 경우 → **사용하지 않고 다른 출처를 찾는다**

---

## ⚠️ 최우선 원칙 3: fields와 sources는 반드시 함께 전송

**편집 API 호출 시 fields만 보내고 sources를 빠뜨리면 각주가 깨진다.** 이것이 가장 빈번한 치명적 실수.

```
✅ 올바름: { "fields": { "way": "..." }, "sources": { "way": [...] }, "changeSummary": "..." }
❌ 치명적 실수: { "fields": { "way": "..." }, "changeSummary": "..." }  ← sources 누락!
```

- 본문에 `[1]`, `[2]` 각주를 넣었으면 **반드시 해당 필드의 sources도 함께 전송**
- sources가 없으면 각주가 클릭 불가능한 깨진 텍스트로 표시됨

---

## ⚠️ 최우선 원칙 4: 필드별 판단 매트릭스 (무엇을 채우고 무엇을 건드리지 않을지)

CareerWiki 직업에는 이미 커리어넷/고용24 API 데이터가 `merged_profile_json`에 있다. 필드마다 처리가 다르다:

### 항상 새로 작성 (API에 대응 데이터 없음 — 가장 중요!)

| 필드 | API 상태 | 행동 | 우선순위 |
|------|---------|------|---------|
| **`way`** (되는 방법) | API에는 학력분포 숫자만 있음 | **반드시 서술형 가이드 작성** (자격요건, 시험, 진입경로) | ★★★ |
| **`detailReady`** | API에 간략한 리스트만 | **curriculum/recruit/training 구체화** | ★★★ |
| **`trivia`** | API에 없음 | **흥미로운 사실 1개** | ★★ |
| **`detailWlb.wlbDetail`** | API에 등급만 | **상세 서술 작성** | ★★ |
| **`detailWlb.socialDetail`** | API에 등급만 | **상세 서술 작성** | ★★ |
| **커리어트리** | API에 없음 | **wrangler d1 execute로 DB INSERT** | ★★ |

### 보강 가능 (API 데이터 있지만 부족할 수 있음)

| 필드 | API 상태 | 행동 |
|------|---------|------|
| `sidebarCerts` | 1~2개만 | 실제 유용한 자격증 추가. DB 검증 필수 |
| `sidebarMajors` | 일부만 | 관련 학과 추가. DB 검증 필수 |
| `overviewSalary.sal` | 수치만 | 이미 user_contributed_json에 서술이 있으면 유지. 없으면 맥락 서술 추가 |
| `overviewProspect.main` | 전망 텍스트 있음 | 이미 user_contributed_json에 서술이 있으면 유지. 없으면 최신 트렌드 추가 |

### API에 있으면 스킵, 없으면 **공식 출처가 있을 때만** 채움

아래 필드들은 보통 API에서 제공되지만, **마이너 직업은 API 데이터가 없을 수 있다.**

| 필드 | API 있을 때 | API 없을 때 (null) |
|------|-----------|-------------------|
| `overviewWork.main` | 스킵 | 수행 직무 서술형 작성 (출처 필수) |
| `overviewAbilities.technKnow` | 스킵 | 서술형 텍스트 작성 가능 (출처+각주 필수) |
| `detailWlb.wlb` / `detailWlb.social` | 스킵 | **등급 + Detail 모두 작성 필수** (출처 필수) — `wlb`와 `social`은 페이지 상단 요약 카드에 크게 표시되므로 누락 시 공란으로 렌더링됨 |

**⚠️ 아래 필드는 공식 통계만 허용 — 추정값/AI 생성 수치 절대 금지:**

| 필드 | 허용 출처 | 출처 없으면 |
|------|----------|-----------|
| `overviewAbilities.abilityList` (점수) | 커리어넷 KNOW 데이터만 | **null 유지 (채우지 않음)** |
| `overviewAptitude` (적성/흥미/만족도) | 커리어넷 재직자 조사만 | **null 유지 (채우지 않음)** |
| `detailEducation` (학력/전공 분포 %) | 고용24 재직자 조사만 | **null 유지 (채우지 않음)** |

이 필드들은 수치/퍼센트이므로 출처 없이 지어내면 거짓 정보가 됨. **빈 칸이 거짓 정보보다 100배 낫다.**

**확인 방법**: merged_profile_json에서 해당 키가 null이거나 빈 객체이면 → 공식 출처 있을 때만 채움, 없으면 null 유지

### 판단 순서
```
1. user_contributed_json에 이미 해당 필드가 있는가?
   → YES + 내용 충분 → 건드리지 않음
   → YES + 내용 부실 → 보강
   → NO → 아래 진행

2. merged_profile_json에 API 데이터가 있는가?
   → "항상 새로 작성" 필드 → API와 무관하게 작성
   → "보강 가능" 필드 → API가 충분하면 스킵, 부족하면 보강
   → "API에 있으면 스킵" 필드 → API 데이터 있으면 스킵, **없으면(null) 리서치해서 채움**

⚠️ 마이너 직업은 API 데이터가 대부분 비어있을 수 있다. "스킵" 판단 전 반드시 실제 데이터 유무를 확인할 것.
```

**핵심: "이 직업이 되고 싶은 학생/취준생에게 실질적으로 도움이 되는 정보"를 최우선으로 채운다.** trivia/wlb만 채우고 끝내면 **실패**.

---

## 0. 사전 준비

### 인증 방식 (둘 중 하나 선택)

**방법 1: X-Admin-Secret 헤더 (권장 — 세션 만료 걱정 없음)**
```
X-Admin-Secret: careerwiki-admin-2026
```
`.dev.vars`의 `ADMIN_SECRET` 값 사용. curl 예시: `-H "X-Admin-Secret: careerwiki-admin-2026"`

**방법 2: Cookie 세션 토큰 (기존 방식)**
```
Cookie: session_token=SESSION_TOKEN
```
토큰은 유저에게 요청하거나 기존 대화에서 재사용.

### 대상 직업 결정
유저가 직업명을 지정하면 해당 직업만, 지정하지 않으면 아래 SQL로 빈 필드가 많은 직업 중 인지도 높은 것을 선별:

```sql
-- 빈 필드 많은 직업 조회 (인지도 우선)
SELECT id, name, slug,
  (CASE WHEN json_extract(merged_profile_json, '$.way') IS NULL OR json_extract(merged_profile_json, '$.way') = '' THEN 1 ELSE 0 END) +
  (CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NULL THEN 1 ELSE 0 END) +
  (CASE WHEN json_extract(merged_profile_json, '$.overviewProspect.main') IS NULL OR json_extract(merged_profile_json, '$.overviewProspect.main') = '' THEN 1 ELSE 0 END) +
  (CASE WHEN json_extract(merged_profile_json, '$.trivia') IS NULL THEN 1 ELSE 0 END)
  as missing_count
FROM jobs WHERE is_active = 1
HAVING missing_count >= 2
ORDER BY missing_count DESC, name
LIMIT 30
```

### DB 쿼리 실행 방법
```bash
npx wrangler d1 execute careerwiki-kr --remote --command "SQL문"
```

---

## 1. 현황 분석 (Analyst)

### 1-1. 대상 직업 데이터 **전수 점검**

**모든 필드를 체크한다** — 빈 필드만이 아니라 기존 데이터도 최신성 확인.

```sql
SELECT id, name, slug,
  substr(json_extract(merged_profile_json, '$.way'), 1, 200) as way_preview,
  substr(json_extract(merged_profile_json, '$.overviewProspect.main'), 1, 200) as prospect_preview,
  json_extract(merged_profile_json, '$.overviewSalary.sal') as salary,
  json_extract(merged_profile_json, '$.trivia') as trivia,
  json_extract(user_contributed_json, '$._sources') IS NOT NULL as has_sources
FROM jobs WHERE name IN ('직업명1', '직업명2') AND is_active = 1
```

### 1-2. 점검 항목 (텍스트 필드)

| 필드 | 점검 내용 |
|------|----------|
| `summary` | 정확성, 최신성, 충분한 분량인지 |
| `overviewWork.main` | 수행직무 누락/구식 여부 |
| `way` | 최신 자격요건, 교육과정, 합격률 |
| `overviewSalary.sal` | 최신 통계 여부 (연도 확인) |
| `overviewProspect.main` | 최신 고용 전망 |
| `trivia` | 있는지, 내용이 흥미로운지 |
| `_sources` | 출처가 있는지, URL이 유효한지 |

### 1-2a. 점검 항목 (사이드바 필드 — 출처 불필요)

이 필드들은 사이트 내부 링크이므로 출처가 필요없지만, **DB에 실제 존재하는 항목만** 넣어야 한다.

| 필드 | JSON 경로 | 데이터 타입 | 검증 방법 |
|------|----------|------------|----------|
| 관련 직업 | `sidebarJobs` | `string[]` | `SELECT name FROM jobs WHERE is_active=1 AND name IN (...)` |
| 관련 전공 | `sidebarMajors` | `string[]` | `SELECT name FROM majors WHERE is_active=1 AND name IN (...)` |
| 추천 자격증 | `sidebarCerts` | `[{name:string, url:string\|null}]` | 아래 기준 참고 |

**sidebarCerts 선정 기준:**
- ✅ **필수 자격증**: 이 직업을 하려면 반드시 필요 (예: 변호사→"변호사 자격증", 간호사→"간호사 면허")
- ✅ **추천 자격증**: 있으면 경쟁력 상승하는 관련 자격 (예: 변호사→"법무사", "변리사")
- ❌ **시험 자체**: 자격증이 아닌 시험은 넣지 않음 (예: LEET, 사법시험, TOEIC)
- ❌ **명칭**: "~시험"이 아닌 "~자격증", "~면허", "~자격" 형태로 (예: "변호사시험" ❌ → "변호사 자격증" ✅)

**관련 직업/전공 선정 기준:**
- **핵심만** — 7~12개 이내로 정말 관련 있는 것만
- **DB 존재 필수** — `is_active=1`인 것만. 존재하지 않는 직업/전공은 절대 넣지 않음
- 같은 산업/분야 + 유사 직무/역할 기준으로 선정
- 노이즈 배제 (이름만 비슷하고 실제 관련 없는 직업 제외)
- **⚠️ 기존 데이터도 반드시 검증·개선**: API 자동 매칭으로 들어간 관련 직업/전공이 이미 있더라도 그대로 두지 말고:
  1. **수량 점검** — 15개 이상이면 관련성 낮은 것 제거하여 7~12개로 정리
  2. **관련성 점검** — 이름만 비슷하고 실제 관련 없는 항목 제거 (예: 가정교사에 "수산업교사"는 관련성 낮음)
  3. **누락 점검** — 해당 직업의 핵심 연관 직업/전공이 빠져 있으면 추가 (예: 가정교사에 "영양교사" 누락)
  4. **DB 존재 재확인** — 직업/전공이 삭제되었거나 비활성화되었을 수 있음

**heroTags도 기존 데이터 검증 필수:**
- 기존 태그가 부실하거나 의미 없으면 개선 (예: "중등 교육기관" 같은 모호한 태그 → "가정과교사" 같은 구체적 별칭으로 교체)
- 해당 직업의 **별칭/다른 이름**, **세부 분류**, **영문명** 등이 빠져 있으면 추가

**DB 검증 쿼리 패턴:**
```sql
-- 관련 직업 후보 검색
SELECT name FROM jobs WHERE is_active=1 AND (
  name LIKE '%키워드1%' OR name LIKE '%키워드2%'
) ORDER BY name

-- 관련 전공 후보 검색
SELECT name FROM majors WHERE is_active=1 AND (
  name LIKE '%키워드1%' OR name LIKE '%키워드2%'
) ORDER BY name

-- 최종 검증 (넣으려는 항목이 실제 존재하는지)
SELECT name FROM jobs WHERE is_active=1 AND name IN ('직업1','직업2','직업3')
```

### 1-3. 점검 항목 (구조화 데이터 필드)

이 필드들도 편집 API로 넣을 수 있다. **단, 공식 출처가 있는 경우에만.**

| 필드 | JSON 경로 | 데이터 타입 | 출처 요건 |
|------|----------|------------|----------|
| 적성 목록 | `overviewAptitude.aptitudeList` | `[{name:string}]` | 커리어넷/워크넷 공식 데이터 |
| 흥미 목록 | `overviewAptitude.interestList` | `[{name:string}]` | 커리어넷/워크넷 공식 데이터 |
| 직업 만족도 | `overviewAptitude.satisfaction.value` | `number (0~100)` | 커리어넷 재직자 조사 통계만 |
| 핵심 역량 | `overviewAbilities.abilityList` | `[{name:string, score?:number}]` | 커리어넷 KNOW 데이터만 |
| 활용 기술 | `overviewAbilities.technKnow` | `string` | 공식 직업사전 또는 검증된 출처 |
| 학력 분포 | `detailEducation.educationDistribution` | `{highSchool:string, college:string, ...}` | 고용24 재직자 조사 통계만 |
| 전공 분포 | `detailEducation.majorDistribution` | `{natural:string, education:string, ...}` | 고용24 재직자 조사 통계만 |
| 워라밸 등급 | `detailWlb.wlb` | `string` (짧은 등급: 보통미만/보통이상/좋음/매우좋음) | 고용24 재직자 조사 |
| 워라밸 상세 | `detailWlb.wlbDetail` | `string` **130~200자** (인라인 각주 지원) — 근무 시간·강도·야근·교대 여부 서술. 임금 정보 절대 포함 금지 | 검증된 출처 |
| 사회적 기여 등급 | `detailWlb.social` | `string` (짧은 등급) | 고용24 재직자 조사 |
| 사회적 기여 상세 | `detailWlb.socialDetail` | `string` **100~160자** (인라인 각주 지원) — **사회에 미치는 영향·공익적 역할**만. 근무환경·협업문화·취업전망 절대 금지 | 검증된 출처 |
| 정규 교육과정 | `detailReady.curriculum` | `string[]` | 대학 교과과정, 양성기관 커리큘럼 공식 페이지 |
| 채용 정보 | `detailReady.recruit` | `string[]` | 실제 채용 공고/채용 채널 |
| 필요 훈련 | `detailReady.training` | `string[]` | 공식 양성과정, 교육기관 정보 |
| 진로 탐색 활동 | `detailReady.researchList` | `[{title:string}]` | 실제 프로그램/기관명 |
| 관련 영상 | `youtubeLinks` | `[{url:string, title?:string}]` | 유튜브 영상 URL. 해당 직업 소개/인터뷰/다큐 등. 공식 채널 우선 |
| 직업지표 | `detailIndicators` | `{chartType:"horizontalBar", items:[{label:string, value:number}], unit:"점"}` | 고용24 재직자 조사만 허용. 항목: 융합성/대인관계/창의성/일가정균형/소득수준/고용유지/사회공헌 (0~100점) |
| 커스텀 차트 | `customCharts` | `[{title:string, chartType:string, items:[{label:string, value:number}], unit:string}]` | 해당 직업 특유의 시각화. 예: 연차별 연봉, 분야별 취업률 등. 공식 통계만 |

**youtubeLinks 수집 방법 (YouTube Data API 사용):**
```bash
curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&q={직업명}+직업+소개&type=video&maxResults=5&relevanceLanguage=ko&key=YOUTUBE_API_KEY"
```
- `.dev.vars`의 `YOUTUBE_API_KEY` 사용
- 결과에서 **공식 채널(EBS/KBS/MBC 등), 다큐, 현직자 인터뷰** 우선 선별 (1~3개)
- URL 형식: `https://youtube.com/watch?v={videoId}`
- ❌ 광고/홍보, 비공식 re-upload, 저품질 채널 제외
- **웹 검색이나 기억으로 URL을 추측하지 않는다** — 반드시 API 결과만 사용

### 1-4. 구조화 데이터 전송 시 주의사항

편집 API는 `user_contributed_json`에 deepMerge로 저장한다. 배열/객체는 **실제 JSON 타입으로** 보내야 한다 (문자열화 X).

```json
// ✅ 올바른 형태 — 배열을 실제 배열로
"overviewAbilities.abilityList": [{"name":"구두 표현력","score":75}]

// ❌ 잘못된 형태 — 배열을 문자열로
"overviewAbilities.abilityList": "[{\"name\":\"구두 표현력\",\"score\":75}]"
```

**`overviewAptitude`는 점 표기법 불가** — 통째로 객체로 보내야 한다:
```json
"overviewAptitude": {
  "aptitudeList": [{"name":"언어력"}],
  "interestList": [{"name":"자연"}],
  "satisfaction": {"value": 62}
}
```

**`detailEducation`도 통째로 객체로:**
```json
"detailEducation": {
  "educationDistribution": {"highSchool":"15","college":"25","university":"50","graduate":"10"},
  "majorDistribution": {"natural":"35","education":"20"}
}
```

**`detailWlb`도 통째로 객체로 (등급 + 상세 설명 분리):**
```json
"detailWlb": {
  "wlb": "보통이상",
  "social": "좋음",
  "wlbDetail": "주 5일, 일 8시간 근무가 기본이다.[1] 계절성 근무 구조이다.[2]",  // ← 130~200자, 근무강도/야근/교대 서술. 임금 정보 절대 금지
  "socialDetail": "산림교육 수혜자 1,782만 명으로 증가했다.[1] 다층적 역할을 수행한다.[2]"  // ← 100~160자, 사회적 영향/공익만. 근무환경·협업·취업전망 금지
}
```

**`detailReady`도 통째로 객체로:**
```json
"detailReady": {
  "curriculum": ["산림교육론 (12시간 이상)", "산림생태계 (42시간 이상)"],
  "recruit": ["한국산림복지진흥원 채용 게시판 (fowi.or.kr)", "산림청 채용정보 게시판"]
}
```

### 1-5. 각주 렌더링 지원 필드 (formatRichText 적용)

아래 필드들은 인라인 `[N]` 각주가 자동으로 클릭 가능한 superscript + 툴팁으로 변환된다:
- `way`, `overviewProspect.main`, `overviewSalary.sal`, `trivia`, `summary` (기존)
- `detailWlb.wlbDetail`, `detailWlb.socialDetail` (2026-03-17 적용, wlb/social은 짧은 등급이므로 각주 불필요)
- `overviewAbilities.technKnow` (2026-03-15 적용)

**curriculum, recruit, training은 배열이므로 각주 없이 항목만 나열한다.**

---

## 2. 리서치 (Researcher)

### 2-1. 수집 대상 필드

| 필드 | 포맷 | 분량 | 주의사항 |
|------|------|------|---------|
| `way` | 줄바꿈(\n) 단락 구분 | 200-500자 | 학력→자격증→단계별 경로→실무 팁 |
| `overviewSalary.sal` | 공식 형식이면 차트, 아니면 서술형 텍스트+각주 | 200-300자 | 공식 형식: "하위(25%) N만원, 평균(50%) N만원, 상위(25%) N만원" → 차트 렌더링. 비공식: 자유 텍스트 → 서술형+각주로 표시. 둘 다 출처 필수 |
| `overviewProspect.main` | 단락 텍스트 | 200-400자 | "~전망됩니다" 객관적 톤 |
| `trivia` | 순수 문자열 | **1개** | 아래 "trivia 작성 가이드" 참고 |

#### trivia 작성 가이드 — "이 직업을 진지하게 생각하게 만드는 정보"

trivia는 단순 잡학이 아니라, **이 직업에 관심 있는 사람이 읽고 "아, 이런 면도 있구나" 하고 진지하게 생각하게 되는 정보**를 넣는 곳이다. 기존 필드(way/salary/prospect/wlb)에 안 맞지만 알면 도움 되는 정보가 여기 들어간다.

**좋은 trivia 예시:**
- 업계 현실: "변호사 10명 중 3명은 개업 3년 내 폐업한다" (출처: 대한변호사협회)
- 진입 전 알았으면 좋았을 것: "경찰 순경 공채가 최근 미달 사태를 겪고 있다" (출처: 경찰청 통계)
- 이직률/번아웃: "간호사 신규 입직 1년 내 이직률은 45.5%이다" (출처: 병원간호사회)
- 업계에서만 아는 현실: "수의사 중 반려동물 진료가 아닌 축산/검역 분야 종사자가 더 많다" (출처: 대한수의사회)
- 의외의 통계/사실: "소방관 순직 원인 1위는 화재 현장이 아니라 심장질환이다" (출처: 소방청)

**나쁜 trivia (금지):**
- ❌ 인물 이력: "이태영은 최초 여성 변호사" → 커리어트리 영역
- ❌ 학문적 기원: "auteur 개념은 1950년대 프랑스에서 탄생" → 직업 현실과 무관
- ❌ 뻔한 정보: "간호사는 병원에서 일한다" → 누구나 아는 것
- ❌ 출처 없는 주장: "이 직업은 스트레스가 매우 높다" → 수치/출처 필수

**핵심: 출처가 명확한 검증된 사실이면서, 이 직업을 고려하는 사람에게 현실적 통찰을 주는 정보.**

### 2-2. 기존 데이터 검증 및 최신화 절차 (고도화 핵심!)

**새 필드를 채우는 것(평준화)만큼, 기존 데이터를 검증하고 최신화하는 것(고도화)도 중요하다.**

#### Step 1: 기존 데이터 연도 파악
```
각 텍스트 필드(way, salary, prospect, wlb 등)에서:
1. 본문에 명시된 연도 추출 (예: "2023년 기준", "2022년 조사")
2. sources의 URL을 WebFetch로 열어서 출처 데이터의 기준 연도 확인
3. 연도 미명시 + 출처도 연도 불분명 → 최신 데이터로 교체 대상
```

#### Step 2: 최신화 판단 기준
| 상태 | 행동 |
|------|------|
| **2년 이상 된 수치** (현재 2026년 → 2024년 이전 데이터) | 최신 공식 통계로 교체. 없으면 연도 그대로 유지하되 "최신 데이터 미확인" 표시 불필요 |
| **출처 URL이 404/접속 불가** | 같은 데이터의 최신 URL로 교체. URL만 변경된 경우 내용은 유지하고 URL만 갱신 |
| **출처는 살아있지만 수치가 변경됨** | 최신 수치로 교체 + 출처 URL 갱신 + 연도 명시 |
| **서술이 부실** (한두 줄, 구체성 부족) | 같은 출처에서 더 많은 팩트를 추출하거나 추가 출처로 보강 |
| **내용은 정확하고 충분** | 건드리지 않음 |

#### Step 3: 최신화 리서치
```
기존 데이터의 핵심 키워드로 재검색:
- salary: "{직업명} 연봉 2025" "{직업명} 임금 통계 최신"
- prospect: "{직업명} 전망 2025" "{직업명} 고용 동향"
- way: "{직업명} 자격요건 변경" "{직업명} 시험 합격률 최신"
→ 최신 공식 통계가 있으면 교체, 없으면 기존 유지
```

#### 수치 데이터 일반 원칙
- 같은 지표에 여러 연도 데이터가 있으면 **가장 최신 것**을 사용
- 본문에 연도를 명시한다 (예: "2025년 기준", "2024년 말 기준")
- 채용공고 급여 정보는 **최근 1년 이내** 것만 사용 (오래된 공고의 급여는 현재와 크게 다를 수 있음)

### 2-3. 리서치 범위

**커리어넷/워크넷에만 의존하지 않는다. 웹 전체에서 실질적으로 도움되는 정보를 수집한다.**

리서치 순서:
1. **웹 검색으로 광범위 수집**: `"{직업명}" 되는법`, `"{직업명}" 연봉`, `"{직업명}" 전망 2025` 등으로 검색
2. **다양한 출처 활용**: 공식 통계뿐 아니라 협회, 뉴스, 실무자 인터뷰, 업계 보고서 등
3. **실질적 가치 우선**: 단순 개론보다 현장감 있는 정보 (취업 루트, 실제 연봉 범위, 업계 트렌드 등)
4. **⚠️ 내용 대조 검증 필수**: 리서치 에이전트가 수집한 데이터는 반드시 `WebFetch`로 출처 페이지를 직접 읽어서 해당 수치/사실이 **실제로 존재하는지** 대조해야 한다. URL 접속 가능 여부(200 OK)만으로는 부족하다. 에이전트가 출처를 섞거나 없는 수치를 생성하는 경우가 실제로 발생함

#### 출처 유형별 가이드

| 우선순위 | 출처 유형 | 예시 | 수집 정보 |
|---------|----------|------|----------|
| 1 | **해당 직업 협회/단체** | 대한간호협회, 한국바리스타협회 등 | 자격요건, 회원 현황, 교육과정 |
| 2 | **정부 통계/공식 사이트** | 커리어넷, 워크넷, KOSIS, KEIS | 임금 통계, 고용 전망 |
| 3 | **뉴스/보도자료** | 주요 언론사, 업계 전문 매체 | 업계 트렌드, 정책 변화, 시장 동향 |
| 4 | **대학/교육기관** | 관련 학과, 자격증 시험원 | 교육과정, 자격시험 정보 |
| 5 | **커뮤니티/후기** | 블로그, 지식인 (참고만) | 실무 경험, 현실적 조언 (팩트체크 필수) |

#### 출처 URL 수집 규칙
- **반드시 실제 세부 페이지 URL**을 수집한다. 메인 도메인만 기록하면 안 됨
- 모든 URL은 `curl -s -o /dev/null -w "%{http_code} %{redirect_url}"` 로 접속+리다이렉트 검증
- **구글 검색 결과의 URL을 맹신하지 않는다** — 사이트 리뉴얼로 URL이 변경되었을 수 있음

#### 커리어넷 URL 형식
- 정확한 형식: `https://www.career.go.kr/cloud/w/job/view?seq={job_cd}`
- **금지**: 구버전 `/cnet/front/base/job/jobView.do?SEQ=` (목록 페이지로 리다이렉트됨)
- DB에서 `careernet_job_cd` 확인하여 seq 파라미터로 사용

### 2-4. 인라인 각주 시스템 (핵심!)

**모든 사실/통계에 인라인 각주 `[N]`을 달아야 한다.** 렌더링 시 자동으로 클릭 가능한 superscript로 변환됨.

#### 텍스트 + 각주 작성 규칙
1. **각주는 마침표 뒤에 붙인다**: `합격해야 합니다.[1]` (O) / `합격해야 합니다[1].` (X)
2. 같은 필드 안에서 번호는 1부터 순서대로
3. 출처 텍스트는 `[N] 출처명` 형식 (URL은 별도 필드)
4. **한 필드에 최소 1개, 최대 6개 이내 각주**
5. **⚠️ 같은 각주 번호는 본문에 절대 1회만** (가장 흔한 실수!):
   - 같은 출처에서 나온 여러 사실 → **반드시 한 문장으로 합쳐서** [N]을 1회만 달기
   - ❌ 금지: `...249만 원입니다.[1] ...348만 원입니다.[1]` ← [1]이 2번 등장
   - ✅ 올바름: `...초임 249만 원이며, 20호봉은 348만 원입니다.[1]` ← [1]이 1번만 등장
   - **편집 API 호출 직전** 최종 텍스트에서 `[N]` regex로 중복 검사 필수: 각 번호가 정확히 1회 등장하는지 확인
6. 렌더링에서 `다[N].` → `다.[N]` 자동 정규화가 있지만, 처음부터 올바른 위치에 작성할 것

#### 예시
```
## 간호사 (ID: 1765283280202496)

### way (되는 방법)
간호사가 되려면 4년제 간호학과 또는 3년제 간호전문대학을 졸업하고 간호사 국가시험에 합격해야 합니다.[1] 2024년 간호사 국가시험 합격률은 95.4%로 매년 높은 합격률을 유지하고 있습니다.[2] 면허 취득 후 대부분 종합병원에서 1~2년간 신규간호사 과정을 거치며 실무를 익힙니다.[3]

### overviewProspect.main (전망)
향후 10년간 간호사 고용은 연평균 2.8% 증가할 것으로 전망됩니다.[1] 인구 고령화로 간호 수요가 급증하고 있습니다.[2]

### 출처 (필드별 분리)
way 출처:
- [1] 대한간호협회 간호사 되기 안내 | URL: https://www.koreanurse.or.kr/about_KNA/nurse.php
- [2] 한국보건의료인국가시험원 2024 통계 | URL: https://www.kuksiwon.or.kr/...

prospect 출처:
- [1] 한국고용정보원 중장기 인력수급전망 | URL: https://www.keis.or.kr/...
```

### 2-5. 콘텐츠 작성 원칙 — "모든 필드 전수 점검, 빠짐없이 채우기"

**목표**: 이 직업에 관심 있는 유저가 한 페이지에서 필요한 모든 정보를 얻을 수 있게 한다. 모든 필드를 체계적으로 점검하고, 빈 것은 채우고, 오래된 것은 최신화한다.

#### 필드별 처리 기준

| 상태 | 처리 |
|------|------|
| **빈 필드 (null)** | 반드시 채운다. 출처를 찾을 수 없는 경우에만 비워둠 |
| **API 데이터만 있음** | API 데이터는 학력분포/수치 위주. **서술형 보강이 필요한 필드(way, prospect, salary 등)는 현장감 있는 텍스트를 추가** |
| **이미 user_contributed_json에 있음** | 내용이 충분하면 건드리지 않음. 오래됐거나(2년+) 부실하면 최신화 |

#### 필수 채워야 할 필드 (건너뛰면 안 됨)

1. **way** (되는 방법) — 가장 중요. 구체적 진입 루트, 시험 정보, 자격요건, 현실적 경로
2. **detailReady** — curriculum(교과목), recruit(채용경로), training(양성과정)
3. **sidebarCerts** — 관련 자격증 + URL (DB 존재 확인)
4. **sidebarMajors** — 관련 전공 (DB 존재 확인)
5. **커리어트리** — 한국인 공인만. wrangler d1 execute로 career_trees + career_tree_job_links INSERT
6. **trivia** — 흥미로운 사실 1개
7. **detailWlb** — wlbDetail + socialDetail 서술형
8. **overviewSalary.sal** — API 수치만 있으면 맥락 있는 서술 추가
9. **overviewProspect.main** — API 전망만 있으면 최신 트렌드/이슈 추가

#### 추가할 정보의 기준 — "유저에게 실질적 도움이 되는가?"
- **현장 실무 정보**: 실제 취업 루트, 신규 입사 과정, 실무 팁
- **최신 통계/트렌드**: 최근 합격률, 취업률, 업계 변화
- **법/제도 변경**: 관련 법률 개정, 자격 제도 변화
- **현실적 조언**: 필요 경력, 실제 연봉 범위, 커리어 패스
- **해외/대안 경로**: 해외 취업, 비전통적 진입 경로

**출처 URL이 실제로 접근 가능한지 curl로 검증 필수. 404면 대체 URL 찾기.**

---

## 3. 편집 API 호출 (Implementer)

### 3-1. API 스펙
```
POST https://careerwiki.org/api/job/{id}/edit
Content-Type: application/json
X-Admin-Secret: careerwiki-admin-2026        ← 권장 (세션 만료 없음)
# 또는
Cookie: session_token=SESSION_TOKEN          ← 기존 방식
```

### 3-2. 요청 Body (인라인 각주 포함)

**중요: sources의 `text`와 `url`은 반드시 분리하여 전송한다.**

```json
{
  "fields": {
    "way": "간호사가 되려면 4년제 간호학과를 졸업하고 국가시험에 합격해야 합니다.[1] 2024년 합격률은 95.4%입니다.[2]\n\n면허 취득 후 종합병원에서 1~2년간 신규간호사 과정을 거칩니다.[3]",
    "overviewProspect.main": "향후 10년간 고용은 연평균 2.8% 증가 전망입니다.[1]",
    "trivia": "치과의사 한 명이 평생 진료하는 환자 수는 약 15만 명에 달한다.[1]"
  },
  "sources": {
    "way": [
      {"text": "[1] 대한간호협회 간호사 되기 안내", "url": "https://www.koreanurse.or.kr/about_KNA/nurse.php"},
      {"text": "[2] 한국보건의료인국가시험원 2024 통계", "url": "https://www.kuksiwon.or.kr/peryear/fixExamResultList.do"},
      {"text": "[3] 서울대학교병원 간호부", "url": "https://nursing.snuh.org/content/nursing/recruit.do"}
    ],
    "overviewProspect.main": [
      {"text": "[1] 한국고용정보원 인력수급전망", "url": "https://www.keis.or.kr/..."}
    ]
  },
  "changeSummary": "way 최신 합격률 보완, prospect 최신 전망 업데이트, trivia 1개 추가"
}
```

> **⚠️ 출처 형식 필수사항**: `text`에는 출처 설명만, `url`에는 링크만 분리 저장.
> - ✅ `{"text": "[1] 대한간호협회 안내", "url": "https://..."}`
> - ❌ `{"text": "[1] 대한간호협회 안내 https://..."}`  ← URL이 text에 합쳐지면 렌더링 시 링크 안 됨

### 3-3. 필드별 주의사항

| 필드 | 포맷 | 주의 |
|------|------|------|
| `way` | string (줄바꿈 \n 포함) | 기존보다 나은 내용이면 덮어쓰기 가능. changeSummary에 사유 기록 |
| `overviewSalary.sal` | string | 공식 형식(하위25%/평균50%/상위25%) → 차트. 비공식 텍스트 → 서술형+각주. 출처 필수 |
| `overviewProspect.main` | string | 기존보다 최신 데이터면 덮어쓰기 가능 |
| `trivia` | 순수 문자열 | **최대 1개만**. 유저 기여용 공간 |

### 3-4. 출처 소스 키 매핑 (⚠️ 반드시 이 키 이름을 사용!)

| 소스 키 | 한국어 라벨 (렌더링) | 설명 |
|---------|---------------------|------|
| `way` | 되는 방법 | 되는 방법 필드의 출처 |
| `overviewSalary.sal` | 임금 정보 | 임금 필드의 출처 |
| `overviewProspect.main` | 전망 정보 | 전망 필드의 출처 |
| `trivia` | 여담 | 여담 필드의 출처 |
| `summary` | 직업 설명 | 요약 필드의 출처 |
| `detailWlb.wlbDetail` | 워라밸 상세 | 워라밸 상세 필드의 출처 |
| `detailWlb.socialDetail` | 사회적 기여 상세 | 사회적 기여 상세 필드의 출처 |

> **⚠️ 절대 금지 — sources 키에 대한 흔한 실수:**
> - ❌ `way_sources` → ✅ `way`
> - ❌ `overviewSalary_sources` → ✅ `overviewSalary.sal`
> - ❌ `detailWlb_sources` → ✅ `detailWlb.wlbDetail`
> - ❌ 숫자 키 `"1"`, `"2"` → ✅ 필드명 키 `way`, `trivia`
> - sources 객체의 키는 **반드시 위 표의 소스 키**와 정확히 일치해야 한다
> - 서버에서 잘못된 키 형식을 일부 자동 보정하지만, 처음부터 올바른 키를 사용할 것

> **각주 source.text의 [N] prefix 규칙:**
> - `[N]`의 N은 **해당 필드 내 로컬 순서 번호** (1부터 시작)
> - `source.id`는 서버가 자동 부여하므로 전송 시 생략 가능
> - 예: way 출처 3개 → `[1] 설명A`, `[2] 설명B`, `[3] 설명C`
> - 예: trivia 출처 1개 → `[1] 설명X` (way와 별개로 1부터 시작)

### 3-5. 기존 소스 삭제
불필요한 기존 소스 키를 삭제하려면:
```json
{
  "fields": {},
  "sources": {
    "summary": {"delete": true}
  },
  "changeSummary": "불필요한 summary 소스 삭제"
}
```

---

### 3-6. Google Indexing 자동 알림

편집 API로 저장이 성공하면 **자동으로** Google Indexing API에 URL 업데이트 알림이 전송된다.
- 별도 작업 불필요 — 코드에서 `waitUntil`로 백그라운드 처리
- 실패해도 편집 저장에 영향 없음
- Google이 보통 수 시간~1일 내에 크롤링하여 인덱스 업데이트

---

## 4. 출처 내용 대조 검증 (⚠️ 필수 — 편집 API 호출 전)

**리서치 에이전트가 수집한 모든 데이터를 편집 API에 넣기 전에, 아래 검증을 반드시 수행한다.**
이 절차를 생략하면 출처에 없는 허위 데이터가 들어갈 수 있다 (실제 사례: 숲해설사).

### 4-1. 출처별 내용 대조 (WebFetch 필수)

리서치 에이전트가 수집한 **모든** 출처 URL에 대해:

```
각 출처 URL마다:
1. WebFetch(url, "이 페이지에서 [넣으려는 구체적 수치/사실]을 원문 그대로 찾아줘")
2. 페이지에 실제로 해당 내용이 있는지 확인
3. 없으면 → 해당 데이터 제거 또는 다른 출처 찾기
```

**대조 체크리스트** (모든 텍스트 필드에 적용):
```
각 문장에 대해:
[ ] 이 문장에 인용된 출처 URL을 WebFetch로 직접 읽었는가?
[ ] 해당 수치/사실이 출처 페이지에 실제로 존재하는가?
[ ] 수치가 출처와 정확히 일치하는가? (반올림/변환 없이)
[ ] 출처에서 사용한 연도/기준이 본문에 올바르게 반영되었는가?
```

### 4-2. 각주 중복 검증 (⚠️ 가장 빈번한 오류 — 반드시 자동 검사)

**편집 API 호출 직전**, 모든 텍스트 필드에 대해 아래 코드로 중복 검사:

```javascript
// 각 필드의 텍스트에서 [N] 중복 검사
function validateFootnotes(text, fieldName) {
  const matches = text.match(/\[(\d+)\]/g) || [];
  const counts = {};
  matches.forEach(m => { counts[m] = (counts[m] || 0) + 1; });
  const dupes = Object.entries(counts).filter(([_, c]) => c > 1);
  if (dupes.length > 0) {
    throw new Error(`${fieldName}: 각주 중복 발견! ${dupes.map(([n,c]) => `${n}이 ${c}회`).join(', ')} — 같은 출처의 여러 사실을 한 문장으로 합쳐야 합니다`);
  }
}
```

**중복 발견 시 해결법**: 같은 [N]이 2회 등장하면 → 두 문장을 합쳐서 [N]을 1회만 남기기.
- ❌ `초임 249만 원입니다.[1] 20호봉은 348만 원입니다.[1]`
- ✅ `초임 249만 원이며, 20호봉은 348만 원, 40호봉은 621만 원입니다.[1]`

### 4-2b. 각주 품질 검증

```
[ ] 각 [N]이 본문에 1회만 등장하는가? (같은 번호 2번 이상 ✗)
[ ] [N] 번호가 페이지 스크롤 순서대로 증가하는가?
[ ] 각주가 마침표 뒤에 있는가? (합니다.[1] ✓ / 합니다[1]. ✗)
[ ] 모든 출처의 text가 [N]으로 시작하는가?
[ ] 출처의 설명이 실제 페이지 내용을 정확히 반영하는가?
```

### 4-3. URL 접속 검증

```bash
# 모든 URL에 대해 실행
curl -s -o /dev/null -w "%{http_code}" "출처URL"
# 200 또는 301/302만 허용. 400/404/500 → 대체 URL 찾기 또는 제거
```

---

## 5. 프로덕션 검증 (편집 API 호출 후)

편집 API 호출 후 반드시 프로덕션에서 확인:

### 5-1. curl로 확인
```bash
curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep "확인할 키워드"
```

### 5-2. 확인 항목
```
[ ] way(되는 방법): "과정" 탭에 표시됨
[ ] salary: 임금 정보가 정상 렌더링
[ ] prospect: "커리어 전망" 섹션에 표시됨
[ ] trivia: 여담 섹션에 1개 불릿으로 표시됨
[ ] 구조화 데이터: 적성/흥미/학력분포 등 해당 섹션에 렌더링됨
[ ] 출처: 필드별 그룹핑 + 클릭 가능한 URL
[ ] 인라인 각주: 마침표 뒤에 [N] superscript — 스타일이 모두 동일한가?
[ ] 각주 tooltip: hover 시 출처 설명 표시
[ ] 각주 번호: 페이지 스크롤 순서대로 1~N, 중복 없음, 겹침 없음
[ ] 기존 데이터 유지: 다른 필드가 사라지지 않았음
```

---

## 5-3. 커리어트리 추가 (Career Tree)

직업 상세 페이지에 **"이 직업에 도달하기까지의 실제 경로 지도"**를 표시하는 기능. 게임의 스킬트리처럼, 유저가 보고 **"이 루트를 따라가면 되겠구나"** 참고할 수 있어야 한다.

### 5-3a. 인물 선정 기준

- **한국인만**: 반드시 한국 국적의 인물만 추가. 외국인은 절대 추가하지 않음
- **공인/유명인만**: 위키피디아에 등재되었거나 공식 프로필이 확인 가능한 인물
- **정확한 경력만**: 추정/소문이 아닌 **공식 출처로 확인 가능한** 경력 사항만 입력
- **다양성**: 같은 직업에 2~3명 정도, 가급적 다른 시대/분야/성별 배경
- **⚠️ 마땅한 한국인 인물이 없으면 안 넣는다** — 지어내거나 억지로 넣지 않음
- **사생활 침해 금지**: 논란이 있거나 사생활 노출 우려가 있는 경력은 제외
- **정치적 중립**: 특정 정치 성향으로 편향되지 않도록 인물 선정. 정치인 출신은 가급적 피하고, 해당 직업 자체로 유명한 인물 우선. 부득이하게 정치인을 넣을 경우 진보/보수 균형 맞출 것

### 5-3a-1. 스테이지 작성 기준 (핵심!)

커리어트리는 **업적 나열이 아니라 진입 과정과 성장 경로**를 보여줘야 한다.

**올바른 스테이지 구성:**
1. **진입 전 준비** — 어떤 학교, 어떤 전공, 왜 이 길을 선택했는지
2. **진입 과정** — 시험, 훈련, 자격 취득, 수습 과정
3. **초기 커리어** — 첫 직장, 신입 시절, 적응 과정
4. **성장 단계** — 승진, 전문화, 역량 확장
5. **현재/정점** — 해당 직업 내에서의 현재 위치

**필수 규칙:**
- **반드시 하나의 스테이지에 해당 직업 페이지의 직업이 포함되어야 함** (job_slug 연결)
- 해당 직업 이후의 전직(감독, 정치인 등)은 **제외** — 이 페이지는 그 직업에 관한 것
- 수상/업적 자체를 스테이지로 만들지 않음 — description에 간략히 언급만
- "대학 졸업" 같은 모호한 스테이지 금지 — "서울대 체육교육과 졸업 (자전거 선수 출신)" 처럼 구체적으로

**❌ 잘못된 예시 (업적 나열):**
```
1. 대학 졸업 (2005)
2. 데뷔 (2006)
3. 금메달 수상 (2010)
4. 47연승 (2015)
5. 감독 취임 (2020)  ← 전직이므로 제외
```

**✅ 올바른 예시 (진입 경로):**
```
1. 용인체육고 자전거부 (2000-2003) — "중학교 자전거대회 입상 후 체육고 진학"
2. 경륜훈련원 입소 (2003-2004) — "11개월 합숙 훈련, 실기·필기 검정 통과"
3. 경륜선수 데뷔 (2004) — "광명경륜장 첫 출주, C급에서 시작" ← job_slug: 경륜선수
4. A급 승격 (2007) — "3년 만에 최상위 등급, 연간 승률 35%"
5. 국가대표 선발 (2010) — "아시안게임 대표, 트랙사이클 종목"
```

### 5-3b. 데이터 구조

```typescript
interface CareerTreeStage {
  order: number           // 정렬 순서 (0-based)
  title: string           // 직함/역할 (예: '수학교사', '교장')
  organization?: string   // 소속 (예: '서울과학고등학교')
  years?: string          // 기간 (예: '1998-2011')
  description?: string    // 한 줄 설명
  job_slug?: string | null // CW 직업 페이지 슬러그 (있으면 링크 생성)
}
```

### 5-3c. DB 직접 삽입 방법

Admin API에 관리자 권한이 필요하므로, **wrangler d1로 직접 삽입**:

```bash
# 1. career_trees 테이블에 인물 삽입
cd C:/Users/PC/Careerwiki && npx wrangler d1 execute careerwiki-kr --remote --command "INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json, display_priority, is_active, created_at, updated_at) VALUES ('인물명', '영문명 또는 NULL', '한 줄 소개', NULL, '[{\"order\":0,\"title\":\"직함\",\"organization\":\"소속\",\"years\":\"기간\",\"job_slug\":\"직업슬러그\"}]', 100, 1, 시간밀리초, 시간밀리초)"

# 2. 삽입된 ID 확인
npx wrangler d1 execute careerwiki-kr --remote --command "SELECT id FROM career_trees WHERE person_name='인물명' ORDER BY id DESC LIMIT 1"

# 3. career_tree_job_links에 직업 연결 (stage_index = 해당 직업에 해당하는 stages 배열 인덱스)
npx wrangler d1 execute careerwiki-kr --remote --command "INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES (ID, '직업슬러그', 스테이지인덱스)"
```

### 5-3d. job_slug 매칭 규칙

- `job_slug`는 jobs 테이블의 `slug` 컬럼 값 (보통 직업명과 동일)
- stages 배열에서 CW에 존재하는 직업에만 `job_slug` 설정 → 해당 직업 페이지에서 하이라이트
- 존재 여부 확인: `SELECT slug FROM jobs WHERE slug='슬러그' AND is_active=1`
- **⚠️ `job_slug`는 해당 직업에 처음 진입하는 스테이지에만 설정** — 이전 스테이지(학생 시절, 타 직업 등)에는 반드시 `null`
  - ❌ 잘못: 대학 재학 스테이지(order=0)에 job_slug 설정 → 프로덕션에서 엉뚱한 스테이지가 강조됨
  - ✅ 올바름: "직업명 취업/입사/데뷔" 스테이지(order=N)에만 job_slug 설정

### 5-3e. 리서치 절차

1. WebSearch로 `"{인물명}" 경력 이력` 검색
2. 위키피디아, 나무위키, 공식 프로필 등에서 경력 단계 확인
3. **반드시 2개 이상 출처로 교차 검증** — 한 출처만으로 경력 입력 금지
4. 불확실한 경력 단계는 제외

---

## 6. 실행 패턴

### 단일 직업
```
[평준화] 빈 필드 채우기
1. DB에서 해당 직업의 현재 데이터 전수 점검 (빈 필드 + 기존 데이터 연도/출처 상태)
2. 원칙 4 매트릭스에 따라 채울 필드 결정
3. 웹 리서치 — 빈 필드 채우기 + 출처 수집
4. 세부 출처 URL 수집 + curl 검증

[고도화] 기존 데이터 검증 + 최신화
5. 기존 텍스트 필드의 연도 파악 (Section 2-2 Step 1)
6. 2년 이상 된 수치 → 최신 공식 통계로 교체 리서치
7. 기존 출처 URL 접속 검증 → 404면 최신 URL로 교체
8. trivia 점검 — 현실적 통찰을 주는 내용인지 확인, 부실하면 더 나은 팩트로 교체

[검증 + 저장]
9. 출처 내용 대조 검증 (Section 4) — WebFetch로 모든 출처의 실제 내용 확인
10. ⚠️ 각주 중복 검증 (Section 4-2) — 모든 텍스트 필드에서 [N] 중복 검사
11. validate-job-edit.cjs로 자동 검증 — PASS 확인 후에만 API 호출:
    node scripts/validate-job-edit.cjs < draft.json  → FAIL이면 수정 후 재실행
12. 편집 API 호출 — ⚠️ fields와 sources 반드시 함께! (changeSummary에 변경 사유 상세 기록)
13. 커리어트리 인물 리서치 + DB 삽입 (Section 5-3) — 한국인만, 적합한 인물이 있는 경우만

[재검토 — 이 단계 없이 다음 직업으로 넘어가면 안 됨]
14. validate-job-edit.cjs 재검증 — 편집 API 호출 후에도 한 번 더 (DB에서 직접 읽어서)
15. 프로덕션 curl 확인 (Section 5) — 각주 순서, 마크다운 잔류, sources 대응 확인
16. ⚠️ full-quality-audit.cjs 단건 실행 → PASS 확인:
    node scripts/full-quality-audit.cjs --slug={직업slug}
    → FAIL이면 수정 후 재실행 → PASS될 때까지 반복
```

### 대량 (10개 이상) — 2단계 분리 패턴

**핵심: Researcher는 리서치만, 팀 리더가 검증+API 호출.**

```
Phase 1: 팀 리더 — 대상 선별
  - DB 쿼리로 빈 필드 많은 직업 선별
  - 직업별 현재 데이터 상태 요약 (빈 필드, 기존 데이터 연도)

Phase 2: Researcher Agent (3개 병렬, 각 1~2개 직업)
  - 역할: 리서치 + JSON 초안 반환 ONLY
  - ⚠️ API 호출 금지 — JSON 결과만 반환
  - 프롬프트: 아래 6-1 축소 템플릿 사용

Phase 3: 팀 리더 — 검증 + API 호출
  - validate-job-edit.cjs로 자동 검증:
    node scripts/validate-job-edit.cjs < researcher_output.json
  - FAIL → 수정 후 재검증 → PASS될 때까지 반복
  - PASS → 편집 API 호출 (Section 3)
  - sidebarJobs/sidebarMajors DB 존재 확인 (SQL)
  - 출처 URL curl 접속 검증

Phase 4: 프로덕션 확인 + 단건 재검토 ← 이 단계 없이 다음 직업으로 넘어가면 안 됨
  - curl로 각주 순서, 마크다운 잔류, sources 대응 확인 (Section 5)
  - ⚠️ 직업별 단건 full-quality-audit 실행 → PASS 확인:
    node scripts/full-quality-audit.cjs --slug={직업slug}
  - FAIL이면 즉시 수정 후 재실행 → PASS될 때까지 반복
  - 전체 배치 완료 후 QA 스크립트 실행 (Section 6-2)
```

### 6-1. Researcher 에이전트 프롬프트 (축소판 — 이 템플릿만 복사)

병렬 에이전트에게 넘길 때 아래 템플릿을 그대로 복사하고, `{변수}`만 교체한다.

**⚠️ 이 에이전트는 API 호출을 하지 않는다. JSON 결과만 반환한다.**

```
직업 "{직업명}" (Job ID: {JOB_ID}) 리서치 및 데이터 초안 작성.

⚠️ 너는 편집 API를 호출하지 않는다. 리서치 결과를 JSON으로 반환만 한다.

## 현재 데이터 상태
{팀 리더가 DB에서 조회한 현재 데이터 요약을 여기에 붙여넣기}

## 작업 지시
1. 빈 필드를 검증된 정보로 채워라. 출처 없으면 절대 넣지 마라
2. 기존 데이터의 연도를 확인하고 2년+ 된 수치는 최신 통계로 교체
3. sidebarJobs/sidebarMajors/sidebarCerts/heroTags — 기존 데이터도 검증하고 개선
4. 커리어트리는 한국인만. 적합 인물 없으면 null

## 채울 필드 목록
- **way**: 되는 방법 200-500자. 각주 [N] 필수
- **overviewSalary.sal**: 임금 서술. 각주 필수. 이미 user_contributed에 서술이 있으면 유지, 없거나 부실하면 작성
- **overviewProspect.main**: 전망 서술. 각주 필수. 이미 user_contributed에 서술이 있으면 유지, 없거나 부실하면 작성
- **trivia**: 이 직업을 진지하게 생각하게 만드는 검증된 팩트 1개
- **detailWlb**: {wlb:"등급", social:"등급", wlbDetail:"서술[N]", socialDetail:"서술[N]"}
- **detailReady**: {curriculum:[5개+], recruit:[채용경로], training:[양성과정]}
- **sidebarCerts**: [{name, url}]. 자격증만(시험 아님). "~시험" 금지
- **sidebarMajors**: string[]. DB 존재 확인: SELECT name FROM majors WHERE is_active=1 AND name IN (...)
- **sidebarJobs**: 7~12개. DB 존재 확인. 관련성 낮은 것 제거, 핵심 연관 직업 추가
- **heroTags**: 3~10개, 2~15자 명사구. 별칭/세부분류/영문명 포함. 기존 태그가 부실하면 교체
- **overviewWork.main**: API 데이터 없으면 수행 직무 서술 (출처+각주 필수)
- **overviewAbilities.technKnow**: API 데이터 없으면 활용 기술 서술 (출처+각주 필수)
- **youtubeLinks**: [{url, title}]. YouTube Data API로 검색. 공식채널 우선 1~3개
- **detailIndicators**: 고용24 재직자 조사 7항목. **공식 통계만!** 없으면 null
- **customCharts**: 해당 직업 특유 시각화 (연차별 연봉 등). **공식 통계만!** 없으면 null
- workStrong/workPlace/physicalAct: **짧은 라벨만** (20자 이하). 문장 금지

## 절대 금지
- abilityList/aptitude/education에 공식 통계 없이 수치 넣기 → null 유지
- 출처 없는 데이터, 추정값, AI 생성 수치
- 커리어트리에 외국인, 전직 스테이지
- **커리어트리 job_slug를 이전 스테이지(학생/타직업)에 설정** — 해당 직업 첫 진입 스테이지에만 설정
- **wlb/social 등급 누락** — detailWlb.wlb와 detailWlb.social은 페이지 요약 카드에 표시되므로 반드시 포함
- **서술 필드에 sources 누락** — way/salary/prospect/trivia/wlbDetail/socialDetail에 각주가 있으면 반드시 sources도 함께 전송
- **마크다운 볼드(\*\*text\*\*) 서술 필드 사용** — 텍스트 필드에 \*\*...\*\* 절대 금지. 렌더링 시 별표가 그대로 노출됨
- **같은 [N] 번호 한 필드에 2회 이상 사용** — 반드시 1회만
- **sources 배열 길이 < 본문 최대 [N]** — 반드시 일치시킬 것

## 커리어트리 상세 (null이 아닌 경우)
- **진입 경로 중심 5단계**: 준비→진입→초기→성장→정점
- **수상/기록은 description에만** (독립 스테이지 금지)
- **정치적 균형**: 특정 성향 편중 금지. 가급적 비정치인
- **person_title**: 해당 직업 내 정체성만 (전직 직함 제외)

## 각주 규칙
- 필드별 [1]부터 순차 (1, 2, 3...). 건너뛰기 금지 ([1][3] ← 금지)
- 같은 [N] 번호 한 필드에 **정확히 1회만** (2회 이상 = 치명적 오류)
- sources 배열 길이 = 본문 최대 [N] 번호 (반드시 일치)
- 마침표 뒤에: 합니다.[1] (O) / 합니다[1]. (X)

## 출처 규칙
- sources text: "[N] 출처설명" 형식. text에 URL 포함 금지
- 각 출처를 개별 {text, url} 객체로. blob 금지
- sources 키: way→"way", salary→"overviewSalary.sal", prospect→"overviewProspect.main", trivia→"trivia", wlbDetail→"detailWlb.wlbDetail", socialDetail→"detailWlb.socialDetail"

## 반환 형식 (이 JSON을 마지막에 출력)
{
  "jobName": "{직업명}",
  "jobId": "{JOB_ID}",
  "fields": { ... },
  "sources": { ... },
  "careerTree": { "person_name": "...", "stages_json": [...], ... } | null,
  "changeSummary": "변경 사유 상세"
}
```

### 6-3. 단건 재검토 절차 (편집 API 호출 후 필수 — 다음 직업 전 반드시 완료)

편집 API 호출 후, **다음 직업으로 넘어가기 전에 반드시** 아래 4단계를 수행한다.

```
Step 1: validate-job-edit.cjs 재검증
  - DB에서 직접 직업 데이터를 읽어 validate:
    npx wrangler d1 execute careerwiki-kr --remote --json \
      --command "SELECT user_contributed_json FROM jobs WHERE slug='{slug}'" \
      | node -e "..." | node scripts/validate-job-edit.cjs
  - FAIL이면 해당 직업 데이터 수정 후 재호출 → 다시 Step 1부터

Step 2: 프로덕션 curl 확인
  curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep -E "data-source-id|마크다운체크"
  확인 항목:
  [ ] 각주 superscript가 페이지에 보임 (data-source-id 속성)
  [ ] **볼드** 텍스트가 렌더링에 없음 (** 잔류 = 텍스트 버그)
  [ ] way/salary/prospect에 각주 링크 있음

Step 3: full-quality-audit.cjs 단건 실행
  node scripts/full-quality-audit.cjs --slug={직업slug}

  결과:
  ✅ [PASS] 직업명 → 다음 직업으로 넘어가도 됨
  ❌ [FAIL] → 이슈 확인 후 수정 → Step 1부터 재시작

Step 4: PASS 확인 후에만 다음 직업으로 진행
  - PASS 없이 다음 직업으로 넘어가는 것은 절대 금지
```

### 6-2. QA 자동 검증 스크립트

배치 완료 후 전체 직업에 대해 실행:
```bash
# 각주 순서 검증
for job in {직업1} {직업2} {직업3}; do
  nums=$(curl -s "https://careerwiki.org/job/$job?nocache=1" | grep -o 'data-source-id="[0-9]*"' | sed 's/data-source-id="//;s/"//' | tr '\n' ',')
  count=$(echo "$nums" | tr ',' '\n' | grep -c '[0-9]')
  prev=0; ok="OK"
  for n in $(echo "$nums" | tr ',' ' '); do
    if [ "$n" -lt "$prev" ] 2>/dev/null; then ok="FAIL"; break; fi
    prev=$n
  done
  echo "$job: ${count}개 $ok ($nums)"
done
```

**FAIL인 직업 = 각주 순서 역전. 즉시 수정 필요.**
**번호 빠짐 (예: 1,2,5) = sources와 본문 [N]이 불일치. 데이터 수정 필요.**

---

## 7. 성공/실패 예시

### ✅ 성공 예시 (A급 — 노무사)
- way: 응시자격, 1차5과목/2차4과목, 합격기준, 2025년 합격률, 6개월 실무수습까지 구체 서술 (각주 4개)
- detailReady: curriculum 10과목, recruit 6경로, training 5개
- sidebarCerts: 공인노무사 (URL 포함)
- sidebarMajors: 5개 (전부 DB 존재 확인)
- trivia: 1984년 제도 도입 역사 등 4개 팩트
- wlbDetail/socialDetail: 각각 상세 서술
- 커리어트리: 이관수 (한국인, 노무사 출신 정치인)
- sources: 모든 필드에 [N] prefix 포함, 총 19개 출처
- **결과: 각주 1→19 완벽 순차**

### ❌ 실패 예시 (D급 — 배치6 세무사 초기버전)
- trivia만 채움, wlbDetail/socialDetail만 채움
- way 안 채움 ("merged_profile_json에 이미 있다"고 판단 — 실제로는 API 수치뿐)
- detailReady 안 채움
- sidebarCerts 안 채움
- 커리어트리 안 채움 ("admin API 필요"라고 스킵 — 실제로는 wrangler d1 execute 가능)
- **결과: 유저에게 실질적 도움 0, 시간만 낭비**

### ❌ 실패 예시 (sources 누락 — 영화감독)
- fields에 trivia, salary, prospect, wlb 텍스트 + [1]~[5] 각주 잘 넣음
- **sources 객체를 API에 안 보냄** → _sources가 null
- **결과: 각주가 클릭 불가, 번호 깨짐, 출처 링크 없음**

---

## 8. 절대 금지

- **출처 없는 데이터 입력 (텍스트든 구조화 데이터든)** ← 최우선 원칙
- **추정값/AI 생성 수치 입력** (만족도, 학력분포 %, 역량 점수, 적성/흥미 등을 근거 없이 추정하면 **거짓 정보**)
- **abilityList 점수, aptitudeList, interestList, satisfaction, educationDistribution, majorDistribution을 공식 통계 없이 채우기** — 커리어넷 KNOW 또는 고용24 재직자 조사에서 직접 확인된 수치만 허용. 출처 못 찾으면 **null 유지**
- 출처 없는 통계/수치 입력
- 메인 도메인만 출처로 기록 (https://www.career.go.kr ← 이렇게 하면 안 됨)
- salary에 추정치 입력 (출처 있는 데이터만)
- trivia 2개 이상 작성 (유저 기여용 공간이므로 1개만)
- 각주를 마침표 앞에 배치 (`합니다[1].` ← 금지. `합니다.[1]`이 올바른 형식)
- **마크다운 볼드(\*\*text\*\*) 서술 필드에 사용** — way/wlbDetail/socialDetail 등 텍스트 필드에 \*\*...\*\* 금지. 렌더링 시 볼드 처리 안 되고 별표가 그대로 노출됨
- **같은 [N] 각주 번호를 한 필드에 2회 이상 사용** — 같은 출처의 여러 사실은 한 문장으로 합쳐서 [N] 1회만 사용
- **[N] 번호가 1부터 순차적이지 않은 것 사용** — 각 필드 내에서 반드시 [1][2][3]... 순서. [2][3]으로 시작하거나 [1][3] 건너뛰기 금지
- **sources 개수 < 본문 최대 [N] 번호** — sources 배열 길이와 본문 최대 각주 번호가 반드시 일치해야 함
- **재검토 없이 다음 직업으로 넘어가기** — 편집 API 호출 후 full-quality-audit.cjs --slug 단건 실행하여 PASS 확인 없이 다음 직업으로 넘어가면 안 됨 (Section 6-3 참고)
- **validate-job-edit.cjs PASS 없이 편집 API 호출** — 반드시 PASS 후 API 호출
- `.dev.vars` 커밋, `DROP TABLE`, `DELETE FROM` (WHERE 없이)

---

## 9. API 인증 방법

모든 API 호출에 인증 필요. 둘 중 하나 선택:

**X-Admin-Secret 헤더 (권장)** — 세션 만료 걱정 없음:
```
-H "X-Admin-Secret: careerwiki-admin-2026"
```
`.dev.vars`의 `ADMIN_SECRET=careerwiki-admin-2026` 값 사용.

**Cookie 세션 토큰 (기존 방식)**:
```
Cookie: session_token=SESSION_TOKEN
```
토큰은 유저에게 요청하거나, 기존 대화에서 재사용.
