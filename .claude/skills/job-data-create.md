---
name: job-data-create
description: 새 직업 생성 스킬. CareerWiki에 완전히 새로운 직업을 추가할 때 사용한다. 직업 실존 검증 → DB 스텁 생성 → 전체 데이터 보완 → 이미지/분류/벡터 확인까지의 전체 워크플로우를 수행한다. 유저가 "새 직업 추가", "직업 생성", "직업 만들어줘", "job create", "없는 직업 추가" 등을 말할 때 이 스킬을 사용한다.
---

# 새 직업 생성 스킬

새로운 직업을 **처음부터** CareerWiki에 추가하는 전체 워크플로우.
기존 직업의 빈 필드를 채우는 작업은 `/job-data-equalize` 스킬을 사용한다.

---

## ⚠️ 최우선 원칙 1: 출처 없으면 안 넣는다 + sources 필수 전송

**모든 데이터에는 반드시 출처가 있어야 한다.** 이것은 절대 원칙이다.

- 공식 통계를 **최대한** 찾아서 넣되, 찾을 수 없으면 **해당 필드를 비워둔다**
- 추정값, AI가 생성한 수치, 근거 없는 데이터는 **절대 넣지 않는다**
- 텍스트 필드든 구조화 데이터 필드든 동일한 원칙 적용

**⚠️ sources 전송 필수**: 본문에 `[N]` 각주를 넣었으면 편집 API에 반드시 `sources` 객체도 함께 전송. sources 누락 시 각주가 깨짐.

---

## ⚠️ 최우선 원칙 2: 저작권 검증 후 사용

정보를 가져올 때 **반드시 해당 사이트의 이용약관/저작권 정책을 확인**하고, 안전한 것만 사용한다.

### 저작권 검증 불필요 (자유 사용 가능)
- **정부/공공 데이터**: 커리어넷, 고용24, 인사혁신처, 교육부, 국가법령정보센터, 통계청 등 (공공누리/저작권법 제24조의2)
- **통계/사실 데이터**: 임금 수치, 합격률, 종사자 수 등 팩트 자체
- **자격증/교육과정 정보**: Q-net, 대학 교과과정, 시험 과목 등 공개 정보

### 저작권 검증 필수 (사용 전 반드시 확인)

| 판단 | 조건 |
|------|------|
| ✅ 사용 가능 | CC 라이선스, 공공누리, "자유롭게 인용 가능" 명시 |
| ⚠️ 팩트만 추출 | "무단 전재/재배포 금지" 명시 → 수치/사실만 추출, 자체 문장으로 재작성 |
| ❌ 사용 금지 | "크롤링 금지", 유료 콘텐츠, 로그인 필요 콘텐츠 |

---

## ⚠️ 최우선 원칙 3: fields와 sources는 반드시 함께 전송

```
✅ 올바름: { "fields": { "way": "..." }, "sources": { "way": [...] }, "changeSummary": "..." }
❌ 치명적 실수: { "fields": { "way": "..." }, "changeSummary": "..." }  ← sources 누락!
```

---

## ⚠️ 최우선 원칙 4: 필드별 판단 매트릭스

새 직업은 API 데이터가 전혀 없다. 모든 필드를 처음부터 채워야 한다.

| 우선순위 | 필드 | 비고 |
|---------|------|------|
| ★★★ | `summary` (직업 설명) | 생성 시 필수. 벡터 임베딩의 핵심 텍스트 |
| ★★★ | `way` (되는 방법) | 자격요건, 시험, 진입경로 |
| ★★★ | `detailReady` | curriculum/recruit/training |
| ★★ | `overviewWork.main` | 수행 직무 |
| ★★ | `overviewSalary.sal` | 임금 (공식 통계 필수) |
| ★★ | `overviewProspect.main` | 고용 전망 |
| ★★ | `trivia` | 흥미로운 사실 1개 |
| ★★ | `detailWlb` | 워라밸/사회공헌 |
| ★ | `sidebarJobs` | 관련 직업 (DB 존재 검증 필수) |
| ★ | `sidebarMajors` | 관련 전공 (DB 존재 검증 필수) |
| ★ | `sidebarCerts` | 관련 자격증 |
| ★ | `heroTags` | 검색/태그용. 별칭/영문명 포함 |
| ★ | `youtubeLinks` | YouTube API로 수집 |

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

### 이름 중복 사전 확인 API
```bash
curl -s "https://careerwiki.org/api/job/check-name?name={직업명}"
# 사용 가능: {"success":true,"available":true}
# 중복:     {"success":true,"available":false,"reason":"이미 같은 이름의 직업이 존재합니다: \"직업명\"","existingId":"U_xxx","existingName":"직업명"}
```

---

## 1. 직업 실존 검증 (신규 단계 — equalize에 없음)

새 직업 추가 전 **반드시** 수행. 이 단계를 생략하면 중복·허위 직업이 생성될 수 있다.

### 1-1. DB 중복 확인

```bash
# 정확한 이름 + 유사 이름 모두 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id, name, slug, is_active FROM jobs WHERE name LIKE '%{직업명}%' ORDER BY is_active DESC, name"
```

**판단 기준:**

| 결과 | 행동 |
|------|------|
| 활성(is_active=1) 동일 이름 존재 | **중단** — 새 직업 생성 불필요. `/job-data-equalize`로 데이터 보완만 |
| 비활성(is_active=0) 동일 이름 존재 | 재활성화 여부 검토: `UPDATE jobs SET is_active=1 WHERE id=?` |
| 유사 이름 다수 존재 | 새 직업이 기존 직업과 실질적으로 다른지 검토. 별칭이면 heroTags로 처리 |
| 없음 | 아래 공식 DB 검증으로 진행 |

### 1-2. 공식 직업 DB에서 실존 여부 확인

직업이 실제로 존재하는지 공식 출처에서 검증:

```bash
# 1. 커리어넷 직업 검색 (한국직업사전)
# WebFetch: https://www.career.go.kr/cloud/w/job/search?searchText={직업명}&searchType=KOR

# 2. 워크넷 직업·직종 검색
# WebFetch: https://www.work.go.kr/empInfo/occupationInfo/occupList.do

# 3. 한국고용직업분류(KECO) 기준표
# WebFetch: https://www.keis.or.kr/main/publish/qatitles/list.do
```

**신생/신규 직업인 경우 허용 기준:**
- ✅ 뉴스 기사에서 독립 직업으로 보도된 사례
- ✅ 관련 협회나 기관이 공식 인정한 직종
- ✅ 채용 공고에서 정식 직함으로 사용되는 경우 (5개 이상)
- ❌ 커뮤니티 속어, 아직 공식화되지 않은 개념

**신생 직업 근거 자료 수집:**
```bash
# 관련 뉴스 검색
WebSearch: '"{직업명}" 직업 채용' 또는 '"{직업명}" 직종 전문가'
```

### 1-3. slug 충돌 사전 확인

```bash
# 생성될 slug 미리 계산: 직업명의 공백을 '-'로, 소문자 변환
# 예: "AI 프롬프트 엔지니어" → "ai-프롬프트-엔지니어"

npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id, name, slug FROM jobs WHERE slug = '{예상슬러그}'"
```

slug가 이미 존재하면 → 직업명을 더 구체적으로 작성 (예: "영양사" → "임상영양사")

---

## 2. 직업 설명(summary) 작성 가이드

`summary`는 단순한 개요가 아니라 **벡터 임베딩의 핵심 텍스트**다. AI 추천 시스템이 이 텍스트를 기반으로 유저와 매칭하므로, 아래 가이드를 반드시 따른다.

### 2-1. 작성 기준

| 항목 | 기준 |
|------|------|
| **분량** | 100-300자 (너무 짧으면 임베딩 품질 저하) |
| **톤** | 객관적, 설명적 (유저 모집 문구 X) |
| **필수 포함** | 주요 업무, 활동 영역/직장, 필요 역량 한 줄 |
| **금지** | "좋은 직업", "미래 유망", 가치 판단 표현 |

### 2-2. 작성 예시

```
✅ 좋은 예시:
"데이터 엔지니어는 대규모 데이터 파이프라인을 설계·구축하고, 데이터 웨어하우스와
데이터 레이크를 관리하는 전문가다. IT 기업, 금융, 제조 등 다양한 산업에서
데이터 인프라 구축을 담당하며, 프로그래밍(Python, SQL), 클라우드 플랫폼,
ETL 도구 역량이 필요하다."

❌ 나쁜 예시:
"미래 유망 직업으로, 데이터를 다루는 전문가입니다. 연봉이 높고 취업이 잘 됩니다."
```

### 2-3. summary vs description 차이 (중요)

`jobs` 테이블에는 별도의 `description` 컬럼이 없다. 모든 설명 텍스트는 `merged_profile_json` 내 필드로 관리된다.

벡터 임베딩 텍스트 우선순위:
```
heroIntro → summary → description → category 순으로 폴백
```

`POST /api/job/create`에 전달하는 `summary`가 초기 임베딩 텍스트가 되므로, **생성 시 summary를 충분히 작성하는 것이 매우 중요하다.**

---

## 3. 직업 스텁 생성 (신규 단계 — equalize에 없음)

데이터 보완 전에 DB에 직업 레코드를 먼저 만든다.

### 3-1. API 호출 (권장)

```bash
curl -X POST https://careerwiki.org/api/job/create \
  -H "Content-Type: application/json" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -d '{
    "name": "직업명",
    "summary": "100-300자 직업 설명",
    "heroTags": ["태그1", "태그2", "태그3"],
    "heroCategory": "대분류/소분류"
  }'
```

**응답 (반드시 저장):**
```json
{
  "success": true,
  "id": "U_직업명_abc123",
  "slug": "직업명",
  "imageUrl": "https://...",
  "imagePrompt": "..."
}
```

**이미지 생성은 동기 처리 (최대 60초 블록 — API 응답 전에 완료됨):**
- Gemini → 이미지 프롬프트 생성 → Evolink → 이미지 생성 → R2 업로드 → DB 업데이트
- 성공 시 응답에 `imageUrl` 포함. 60초 초과 또는 API 오류 시 `null`

**백그라운드 처리 (waitUntil — API 응답 후 비동기, 1-3분 소요):**
1. OpenAI → heroTags 자동 태깅 → job_attributes 업데이트
2. OpenAI → MECE 대분류/중분류 자동 분류 → job_categories INSERT
3. OpenAI embedding → Vectorize 인덱싱

**응답에 `imageUrl`이 없거나 `null`이면** → 이미지 생성 실패. Section 5에서 수동 처리.

### 3-2. heroCategory 선택 가이드

**반드시 아래 10개 표준 대분류 중 하나를 정확히 입력:**

```
경영·사무·금융·보험직
IT·연구직 및 공학 기술직
교육·법률·사회복지·경찰·소방직 및 군인
보건·의료직
예술·디자인·방송·스포츠직
미용·여행·숙박·음식·경비·청소직
영업·판매·운전·운송직
설치·정비·생산직
건설·채굴직
농림어업직
```

**중분류 예시 (대분류별 주요 항목 발췌):**

| 대분류 | 중분류 예시 |
|--------|-----------|
| 경영·사무·금융·보험직 | 회계·세무·감정 전문가, 금융·보험 전문가, 경영·인사 전문가 |
| IT·연구직 및 공학 기술직 | 소프트웨어 개발자, 정보통신 연구개발직, 자연과학 연구원 |
| 교육·법률·사회복지·경찰·소방직 및 군인 | 학교 교사, 법률 전문가, 사회복지사 및 상담사 |
| 보건·의료직 | 의사, 간호사, 치료·재활사, 의료기사 |
| 예술·디자인·방송·스포츠직 | 시각디자이너, 작가·번역가, 스포츠·레크리에이션 관련 전문가 |

### 3-3. 생성 후 확인

```bash
# 1. 직업 레코드 생성 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id, name, slug, image_url, image_prompt, created_at FROM jobs WHERE name = '{직업명}'"

# 2. 직업 페이지 접근 가능 여부 확인 (3분 후)
curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep -o "<title>[^<]*</title>"
```

---

## 4. 현황 분석 — 채울 필드 결정

스텁 생성 직후 현재 데이터 상태를 전수 점검한다.

```sql
SELECT id, name, slug,
  substr(json_extract(user_contributed_json, '$.summary'), 1, 100) as summary_preview,
  json_extract(user_contributed_json, '$.way') IS NOT NULL as has_way,
  json_extract(user_contributed_json, '$.overviewWork') IS NOT NULL as has_work,
  json_extract(user_contributed_json, '$.overviewSalary') IS NOT NULL as has_salary,
  json_extract(user_contributed_json, '$.overviewProspect') IS NOT NULL as has_prospect,
  json_extract(user_contributed_json, '$.trivia') IS NOT NULL as has_trivia,
  json_extract(user_contributed_json, '$.detailWlb') IS NOT NULL as has_wlb,
  image_url IS NOT NULL as has_image
FROM jobs WHERE name = '{직업명}' AND is_active = 1
```

### 4-1. 점검 항목 (사이드바 필드 — 출처 불필요)

이 필드들은 사이트 내부 링크이므로 출처가 필요없지만, **DB에 실제 존재하는 항목만** 넣어야 한다.

| 필드 | JSON 경로 | 데이터 타입 | 검증 방법 |
|------|----------|------------|----------|
| 관련 직업 | `sidebarJobs` | `string[]` | `SELECT name FROM jobs WHERE is_active=1 AND name IN (...)` |
| 관련 전공 | `sidebarMajors` | `string[]` | `SELECT name FROM majors WHERE is_active=1 AND name IN (...)` |
| 추천 자격증 | `sidebarCerts` | `[{name:string, url:string\|null}]` | 아래 기준 참고 |

**sidebarJobs 수량 기준:**
- **권장**: 7~12개 (핵심 연관 직업만)
- **최대**: 15개 초과 금지 — 15개 이상이면 관련성 낮은 것 제거
- **DB 존재 필수**: `is_active=1`인 직업만. 없는 직업 넣으면 broken link

**sidebarCerts 선정 기준:**
- ✅ **필수 자격증**: 이 직업을 하려면 반드시 필요
- ✅ **추천 자격증**: 있으면 경쟁력 상승하는 관련 자격
- ❌ **시험 자체**: "~시험"이 아닌 "~자격증", "~면허" 형태로

### 4-2. 점검 항목 (구조화 데이터 필드)

| 필드 | JSON 경로 | 데이터 타입 | 출처 요건 |
|------|----------|------------|----------|
| 적성 목록 | `overviewAptitude.aptitudeList` | `[{name:string}]` | 커리어넷/워크넷 공식 데이터 |
| 흥미 목록 | `overviewAptitude.interestList` | `[{name:string}]` | 커리어넷/워크넷 공식 데이터 |
| 직업 만족도 | `overviewAptitude.satisfaction.value` | `number (0~100)` | 커리어넷 재직자 조사만 |
| 핵심 역량 | `overviewAbilities.abilityList` | `[{name:string, score?:number}]` | 커리어넷 KNOW 데이터만 |
| 활용 기술 | `overviewAbilities.technKnow` | `string` | 공식 직업사전 또는 검증된 출처 |
| 학력 분포 | `detailEducation.educationDistribution` | `{highSchool:string, ...}` | 고용24 재직자 조사 통계만 |
| 워라밸 등급 | `detailWlb.wlb` | `string` (보통미만/보통이상/좋음/매우좋음) | 고용24 재직자 조사 |
| 워라밸 상세 | `detailWlb.wlbDetail` | `string` **130~200자** (인라인 각주 지원) — 근무 시간·강도·야근·교대 여부 서술. 임금 정보 절대 포함 금지 | 검증된 출처 |
| 사회적 기여 등급 | `detailWlb.social` | `string` | 고용24 재직자 조사 |
| 사회적 기여 상세 | `detailWlb.socialDetail` | `string` **100~160자** (인라인 각주 지원) — **사회에 미치는 영향·공익적 역할**만. 근무환경·협업문화·취업전망 절대 금지 | 검증된 출처 |
| 정규 교육과정 | `detailReady.curriculum` | `string[]` | 대학 교과과정, 양성기관 |
| 채용 정보 | `detailReady.recruit` | `string[]` | 실제 채용 공고/채널 |
| 필요 훈련 | `detailReady.training` | `string[]` | 공식 양성과정 |
| 관련 영상 | `youtubeLinks` | `[{url:string, title?:string}]` | YouTube API 결과만 |
| 직업지표 | `detailIndicators` | `{chartType:"horizontalBar", items:[...], unit:"점"}` | 고용24 재직자 조사만 |

**⚠️ 아래 필드는 공식 통계만 허용 — 없으면 null 유지:**
- `overviewAbilities.abilityList` (점수)
- `overviewAptitude` (적성/흥미/만족도)
- `detailEducation` (학력/전공 분포 %)

### 4-3. 각주 렌더링 지원 필드

아래 필드들은 인라인 `[N]` 각주가 자동으로 클릭 가능한 superscript로 변환된다:
- `way`, `overviewProspect.main`, `overviewSalary.sal`, `trivia`, `summary`
- `detailWlb.wlbDetail`, `detailWlb.socialDetail`
- `overviewAbilities.technKnow`

---

## 5. 이미지 검증 및 수동 업로드

### 5-1. 이미지 자동 생성 결과 확인

생성 후 3분이 지나면 R2 URL로 직접 접근:

```bash
# DB에서 image_url 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id, name, image_url, image_prompt FROM jobs WHERE name = '{직업명}'"

# image_url이 있으면 실제 접근 가능한지 확인
curl -s -o /dev/null -w "%{http_code}" "{image_url 값}"
# 200이면 정상. 404/403이면 업로드 실패
```

**이미지 경로 패턴 (R2):**
- **R2 키**: `jobs/job-{slug}.{ext}` (타임스탬프 없음, `job-` 접두사 있음)
- **DB 저장 값**: `/uploads/jobs/job-{slug}.{ext}` (상대 경로)
- **이미지 크기**: 1280×720 (16:9) — Evolink 고정
- **포맷**: WebP (기본), PNG/JPEG (Evolink 응답 포맷에 따라)

### 5-2. 이미지 생성 실패 시 수동 업로드

```bash
# 1. 이미지 파일 준비 (1280×720, WebP 권장)

# 2. R2에 업로드 — R2 키 형식: jobs/job-{slug}.webp
cd C:/Users/PC/Careerwiki && npx wrangler r2 object put careerwiki-uploads/jobs/job-{slug}.webp \
  --file ./path/to/image.webp --content-type image/webp

# 3. DB의 image_url 업데이트 — DB 저장값은 상대 경로
npx wrangler d1 execute careerwiki-kr --remote --command \
  "UPDATE jobs SET image_url='/uploads/jobs/job-{slug}.webp' WHERE name='{직업명}'"
```

### 5-3. image_prompt만 있고 imageUrl이 없는 경우

API 응답에 `imagePrompt`가 있으면 프롬프트는 저장된 상태. Evolink만 재호출하면 된다:

```bash
# image_prompt로 재시도 (Evolink API 직접 호출 방식)
# 또는 직업 편집 화면에서 "이미지 재생성" 기능 사용 (있는 경우)
```

---

## 6. 분류 검증 및 수정

### 6-1. 자동 분류 결과 확인 (생성 3분 후)

```bash
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT job_id, large_category, medium_category, source, confidence
   FROM job_categories WHERE job_id = '{JOB_ID}'"
```

**confidence 기준:**
- `0.8` = 직접 매칭 (신뢰 높음)
- `0.6` = 퍼지 매칭 (검토 필요)
- 레코드 없음 = 분류 실패 → 수동 입력 필요

### 6-2. 분류가 잘못됐거나 없는 경우 수동 수정

```bash
# 올바른 대분류/중분류로 직접 삽입
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT OR REPLACE INTO job_categories (job_id, large_category, medium_category, source, confidence, created_at, updated_at)
   VALUES ('{JOB_ID}', '대분류명', '중분류명', 'manual', 1.0, unixepoch()*1000, unixepoch()*1000)"
```

**유효한 대분류 10개 (반드시 정확히 이 문자열 사용):**
```
경영·사무·금융·보험직
IT·연구직 및 공학 기술직
교육·법률·사회복지·경찰·소방직 및 군인
보건·의료직
예술·디자인·방송·스포츠직
미용·여행·숙박·음식·경비·청소직
영업·판매·운전·운송직
설치·정비·생산직
건설·채굴직
농림어업직
```

---

## 7. Vectorize 인덱싱 확인

### 7-1. 인덱싱 성공 여부 간접 확인

직접 Vectorize API를 조회할 수 없으므로, 추천 검색으로 간접 확인한다 (생성 5분 후):

```bash
# 방법 1: 직업명으로 검색했을 때 나오는지 확인
curl -s "https://careerwiki.org/api/search?q={직업명키워드}&type=job" | \
  python3 -c "import sys,json; data=json.load(sys.stdin); print([r.get('name') for r in data.get('results',[])])"

# 방법 2: embedding_metadata 테이블 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT entity_id, entity_type, version, created_at FROM embedding_metadata WHERE entity_id = '{JOB_ID}'"
```

**embedding_metadata에 레코드가 있으면** → Vectorize 인덱싱 성공.

### 7-2. 인덱싱 실패 시 수동 재시도

```bash
# 로컬에서 직접 벡터라이제이션 스크립트 실행
cd C:/Users/PC/Careerwiki && npx tsx scripts/vectorize-content.ts --job-id {JOB_ID}

# 또는 전체 리인덱스 스크립트 (주의: 시간 오래 걸림)
# npx tsx scripts/reindex-vectorize-step1-export.mjs
```

---

## 8. 리서치 (신규 직업 전용)

### 8-1. 리서치 범위

**새 직업은 API 데이터가 전혀 없다. 모든 것을 처음부터 수집해야 한다.**

리서치 순서:
1. **공식 직업 DB 우선**: 커리어넷 직업사전, 워크넷 직업정보, 한국직업정보(KNOW)
2. **웹 검색으로 보완**: `"{직업명}" 되는법`, `"{직업명}" 연봉 2025`, `"{직업명}" 전망`
3. **협회/기관**: 해당 직업 관련 협회나 공식 기관 사이트
4. **⚠️ 내용 대조 검증 필수**: 리서치 에이전트가 수집한 데이터는 `WebFetch`로 출처 페이지를 직접 읽어서 해당 수치/사실이 **실제로 존재하는지** 대조해야 한다

#### 출처 유형별 가이드

| 우선순위 | 출처 유형 | 예시 | 수집 정보 |
|---------|----------|------|----------|
| 1 | **해당 직업 협회/단체** | 각 직종 협회 | 자격요건, 회원 현황, 교육과정 |
| 2 | **정부 통계/공식 사이트** | 커리어넷, 워크넷, KOSIS | 임금 통계, 고용 전망 |
| 3 | **뉴스/보도자료** | 주요 언론사, 업계 전문 매체 | 업계 트렌드, 정책 변화 |
| 4 | **대학/교육기관** | 관련 학과, 자격증 시험원 | 교육과정, 자격시험 정보 |
| 5 | **커뮤니티/후기** | 블로그, 지식인 (참고만) | 실무 경험 (팩트체크 필수) |

#### 출처 URL 수집 규칙
- **반드시 실제 세부 페이지 URL** 수집. 메인 도메인만 기록 금지
- 모든 URL은 접속 가능 여부 검증
- **구글 검색 결과의 URL을 맹신하지 않는다** — URL이 변경되었을 수 있음

### 8-2. 수집 대상 필드

| 필드 | 포맷 | 분량 | 주의사항 |
|------|------|------|---------|
| `summary` | 객관적 서술형 | 100-300자 | 벡터 임베딩 기준 텍스트 |
| `way` | 줄바꿈(\n) 단락 구분 | 200-500자 | 학력→자격증→단계별 경로→실무 팁 |
| `overviewWork.main` | 서술형 텍스트 | 100-300자 | 수행 직무 설명 |
| `overviewSalary.sal` | 공식 형식 또는 서술형 | 200-300자 | 공식 형식이면 차트 렌더링. 출처 필수 |
| `overviewProspect.main` | 단락 텍스트 | 200-400자 | "~전망됩니다" 객관적 톤 |
| `trivia` | 순수 문자열 | **1개** | 업계 현실/의외의 통계. 출처 필수 |

#### trivia 작성 가이드

trivia는 **이 직업에 관심 있는 사람이 읽고 진지하게 생각하게 되는 정보**를 넣는 곳이다.

**좋은 trivia 예시:**
- 업계 현실: "이 직업 종사자 10명 중 N명은 입직 N년 내 이직한다" (출처: 협회 통계)
- 진입 전 알았으면 좋았을 것: 실제 합격률, 소득 분포의 현실
- 업계에서만 아는 현실: 공식 통계로 뒷받침된 의외의 사실

**나쁜 trivia (금지):**
- ❌ 인물 이력 → 커리어트리 영역
- ❌ 학문적 기원 → 직업 현실과 무관
- ❌ 뻔한 정보, 출처 없는 주장

### 8-3. 인라인 각주 시스템 (핵심!)

**모든 사실/통계에 인라인 각주 `[N]`을 달아야 한다.**

1. **각주는 마침표 뒤에 붙인다**: `합격해야 합니다.[1]` (O) / `합격해야 합니다[1].` (X)
2. 같은 필드 안에서 번호는 1부터 순서대로
3. **같은 각주 번호는 본문에 절대 1회만**:
   - ❌ `...249만 원입니다.[1] ...348만 원입니다.[1]` ← [1]이 2번 등장
   - ✅ `...초임 249만 원이며, 20호봉은 348만 원입니다.[1]` ← [1]이 1번만
4. **편집 API 호출 직전** 모든 텍스트에서 [N] 중복 검사 필수

---

## 9. 편집 API 호출 — 데이터 보완

스텁 생성 후 전체 데이터를 채우는 단계. equalize 스킬과 동일한 편집 API를 사용한다.

### 9-1. API 스펙

```
POST https://careerwiki.org/api/job/{id}/edit
Content-Type: application/json
X-Admin-Secret: careerwiki-admin-2026        ← 권장 (세션 만료 없음)
# 또는
Cookie: session_token=SESSION_TOKEN          ← 기존 방식
```

### 9-2. 요청 Body

```json
{
  "fields": {
    "summary": "업데이트된 직업 설명 (초기 생성 시보다 더 풍부하게)",
    "way": "자격요건 서술...[1]\n\n진입 경로...[2]",
    "overviewWork.main": "수행 직무 설명.[1]",
    "overviewSalary.sal": "하위(25%) 2,800만원, 평균(50%) 4,200만원, 상위(25%) 6,500만원.[1]",
    "overviewProspect.main": "향후 전망 서술.[1]",
    "trivia": "흥미로운 사실 1개.[1]",
    "detailWlb": {
      "wlb": "보통이상",
      "social": "좋음",
      "wlbDetail": "근무 시간·강도·야간근무 여부 서술.[1]",  // 130~200자. 임금 정보 절대 금지
      "socialDetail": "사회에 미치는 영향·공익적 역할 서술.[1]"  // 100~160자. 근무환경·협업·취업전망 절대 금지
    },
    "detailReady": {
      "curriculum": ["과목1", "과목2"],
      "recruit": ["채용경로1", "채용경로2"],
      "training": ["양성과정1"]
    },
    "sidebarJobs": ["관련직업1", "관련직업2"],
    "sidebarMajors": ["관련전공1"],
    "sidebarCerts": [{"name": "자격증명", "url": "https://..."}],
    "heroTags": ["태그1", "태그2", "별칭"],
    "youtubeLinks": [{"url": "https://youtube.com/watch?v=xxx", "title": "영상 제목"}]
  },
  "sources": {
    "way": [
      {"text": "[1] 출처명", "url": "https://..."},
      {"text": "[2] 출처명", "url": "https://..."}
    ],
    "overviewSalary.sal": [{"text": "[1] 출처명", "url": "https://..."}],
    "overviewProspect.main": [{"text": "[1] 출처명", "url": "https://..."}],
    "trivia": [{"text": "[1] 출처명", "url": "https://..."}]
  },
  "changeSummary": "신규 직업 전체 데이터 보완: way/work/salary/prospect/wlb/detailReady 작성"
}
```

### 9-3. 출처 소스 키 매핑 (반드시 이 키 이름 사용)

| 소스 키 | 설명 |
|---------|------|
| `way` | 되는 방법 필드의 출처 |
| `overviewSalary.sal` | 임금 필드의 출처 |
| `overviewProspect.main` | 전망 필드의 출처 |
| `trivia` | 여담 필드의 출처 |
| `summary` | 직업 설명 필드의 출처 |
| `detailWlb.wlbDetail` | 워라밸 상세 필드의 출처 |
| `detailWlb.socialDetail` | 사회적 기여 상세 필드의 출처 |
| `overviewAbilities.technKnow` | 활용 기술 필드의 출처 |

> **⚠️ sources 키 오류 패턴 — 절대 금지:**
> - ❌ `way_sources` → ✅ `way` (접미사 `_sources` 금지)
> - ❌ `overviewSalary_sources` → ✅ `overviewSalary.sal`
> - ❌ `detailWlb_sources` → ✅ `detailWlb.wlbDetail`
> - ❌ 숫자 키 `"1"`, `"2"`, `"3"` → ✅ 반드시 필드명 키 (`way`, `trivia` 등)
> - sources 없이 fields만 전송 금지 (각주 깨짐)
>
> 서버에서 잘못된 키 형식을 일부 자동 보정하지만, 처음부터 올바른 키를 사용할 것.

### 9-3b. Google Indexing 자동 알림

편집 API로 저장이 성공하면 **자동으로** Google Indexing API에 URL 업데이트 알림이 전송된다.
- 별도 작업 불필요 — 코드에서 `waitUntil`로 백그라운드 처리
- 실패해도 편집 저장에 영향 없음
- Google이 보통 수 시간~1일 내에 크롤링하여 인덱스 업데이트

### 9-4. 구조화 데이터 전송 시 주의사항

배열/객체는 **실제 JSON 타입으로** 보내야 한다 (문자열화 X).

```json
// ✅ 올바른 형태
"overviewAbilities.abilityList": [{"name":"구두 표현력","score":75}]

// ❌ 잘못된 형태
"overviewAbilities.abilityList": "[{\"name\":\"구두 표현력\",\"score\":75}]"
```

`overviewAptitude`, `detailEducation`, `detailWlb`, `detailReady`는 점 표기법 불가 → 통째로 객체로 전송.

---

## 10. 출처 내용 대조 검증 (편집 API 호출 전 필수)

### 10-1. 출처별 내용 대조 (WebFetch 필수)

모든 출처 URL에 대해:
```
1. WebFetch(url, "이 페이지에서 [넣으려는 수치/사실]을 원문 그대로 찾아줘")
2. 페이지에 실제로 해당 내용이 있는지 확인
3. 없으면 → 해당 데이터 제거 또는 다른 출처 찾기
```

### 10-2. 각주 중복 검증 (편집 API 호출 직전 반드시 실행)

```javascript
function validateFootnotes(text, fieldName) {
  const matches = text.match(/\[(\d+)\]/g) || [];
  const counts = {};
  matches.forEach(m => { counts[m] = (counts[m] || 0) + 1; });
  const dupes = Object.entries(counts).filter(([_, c]) => c > 1);
  if (dupes.length > 0) {
    throw new Error(`${fieldName}: 각주 중복! ${dupes.map(([n,c]) => `${n}이 ${c}회`).join(', ')}`);
  }
}
```

### 10-2b. 각주 품질 체크리스트

```
[ ] 각 [N]이 본문에 1회만 등장하는가? (같은 번호 2번 이상 ✗)
[ ] [N] 번호가 필드 내에서 1부터 순차 증가하는가? (빠진 번호 없음)
[ ] 각주가 마침표 뒤에 있는가? (합니다.[1] ✓ / 합니다[1]. ✗)
[ ] 모든 sources의 text가 [N]으로 시작하는가? ("[1] 출처명" 형식)
[ ] sources의 text에 URL이 섞이지 않았는가? (text와 url은 분리)
[ ] sources 키 이름이 올바른가? (숫자 키 "1","2" 금지, 필드명 키 사용)
```

### 10-3. URL 접속 검증

```bash
curl -s -o /dev/null -w "%{http_code}" "출처URL"
# 200 또는 301/302만 허용. 400/404/500 → 대체 URL 찾기 또는 제거
```

---

## 11. 커리어트리 추가 (선택사항)

### 11-1. 인물 선정 기준

- **한국인만**: 반드시 한국 국적의 인물만 추가. 외국인은 절대 추가하지 않음
- **공인/유명인만**: 위키피디아에 등재되었거나 공식 프로필이 확인 가능한 인물
- **정확한 경력만**: 공식 출처로 확인 가능한 경력만 입력
- **마땅한 한국인 인물이 없으면 안 넣는다**

### 11-2. 스테이지 작성 기준

커리어트리는 **업적 나열이 아니라 진입 과정과 성장 경로**를 보여줘야 한다.

```typescript
interface CareerTreeStage {
  order: number           // 정렬 순서 (0-based)
  title: string           // 직함/역할
  organization?: string   // 소속
  years?: string          // 기간
  description?: string    // 한 줄 설명
  job_slug?: string | null // 현재 직업 페이지 슬러그 (있으면 링크 생성)
}
```

**필수 규칙:**
- 반드시 하나의 스테이지에 해당 직업의 `job_slug`를 연결
- 전직(감독, 정치인 등)은 스테이지에서 제외
- 수상/업적 자체는 스테이지 금지 → description에만 간략히

### 11-3. DB 삽입

```bash
# 1. career_trees 인물 삽입
cd C:/Users/PC/Careerwiki && npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json, display_priority, is_active, created_at, updated_at)
   VALUES ('인물명', '영문명', '한 줄 소개', NULL,
   '[{\"order\":0,\"title\":\"직함\",\"organization\":\"소속\",\"years\":\"기간\",\"description\":\"설명\",\"job_slug\":\"직업슬러그\"}]',
   100, 1, unixepoch()*1000, unixepoch()*1000)"

# 2. 삽입된 ID 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id FROM career_trees WHERE person_name='인물명' ORDER BY id DESC LIMIT 1"

# 3. 직업 연결
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES ({ID}, '{직업슬러그}', {스테이지인덱스})"
```

---

## 12. 프로덕션 검증

편집 API 호출 및 커리어트리 추가 후 프로덕션에서 확인:

### 12-1. curl로 전체 확인

```bash
# 페이지 렌더링 확인
curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep "확인할 키워드"

# 핵심 필드 DB 상태 최종 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT name, slug, image_url,
     substr(json_extract(merged_profile_json, '$.summary'), 1, 100) as summary_preview,
     substr(json_extract(merged_profile_json, '$.way'), 1, 100) as way_preview,
     json_extract(merged_profile_json, '$.overviewSalary.sal') IS NOT NULL as has_salary,
     json_extract(merged_profile_json, '$.trivia') IS NOT NULL as has_trivia,
     (SELECT large_category FROM job_categories WHERE job_id=jobs.id) as category
   FROM jobs WHERE name = '{직업명}'"
```

### 12-2. 확인 항목

```
□ 페이지 타이틀이 올바른 직업명인가?
□ 썸네일 이미지가 표시되는가?
□ summary(직업 설명)가 렌더링되는가?
□ way(되는 방법): "과정" 탭에 표시되는가?
□ salary: 임금 정보가 정상 렌더링되는가?
□ prospect: "커리어 전망" 섹션에 표시되는가?
□ trivia: 여담 섹션에 1개 불릿으로 표시되는가?
□ 출처: 필드별 그룹핑 + 클릭 가능한 URL인가?
□ 인라인 각주: 마침표 뒤에 [N] superscript인가?
□ 각주 hover: tooltip에 출처 설명이 표시되는가?
□ 대분류/중분류 분류가 올바른가?
□ 커리어트리: 해당 직업 페이지에 표시되는가? (추가한 경우)
□ 관련 직업 링크가 정상 동작하는가?
```

### 12-3. QA 스크립트 (각주 순서 검증)

```bash
slug={직업슬러그}
nums=$(curl -s "https://careerwiki.org/job/$slug?nocache=1" | grep -o 'data-source-id="[0-9]*"' | sed 's/data-source-id="//;s/"//' | tr '\n' ',')
count=$(echo "$nums" | tr ',' '\n' | grep -c '[0-9]')
prev=0; ok="OK"
for n in $(echo "$nums" | tr ',' ' '); do
  if [ "$n" -lt "$prev" ] 2>/dev/null; then ok="FAIL"; break; fi
  prev=$n
done
echo "$slug: ${count}개 $ok ($nums)"
```

**FAIL = 각주 순서 역전. 즉시 수정 필요.**

---

## 13. 전체 실행 패턴

```
[Phase 1: 실존 검증]
1. DB 중복 확인 (exact match + LIKE 검색)
2. 공식 직업 DB에서 실존 여부 확인 (커리어넷, 워크넷)
3. slug 충돌 사전 확인

[Phase 2: 스텁 생성]
4. summary 초안 작성 (100-300자)
5. heroTags 선정 (별칭, 분류, 영문명 포함)
6. heroCategory 선택 (표준 10개 대분류)
7. POST /api/job/create 호출 → id, slug 저장
8. 응답에서 imageUrl 확인 (없으면 Phase 4에서 수동 처리)

[Phase 3: 리서치]
9. 공식 DB + 웹 검색으로 모든 필드 리서치
10. 출처 URL curl 접속 검증
11. 수집한 데이터 WebFetch로 내용 대조 검증

[Phase 4: 데이터 보완]
12. 각주 중복 검증 (validateFootnotes)
12b. validate-job-edit.cjs 자동 검증: node scripts/validate-job-edit.cjs < researcher_output.json
    FAIL → 수정 후 재검증. PASS → 다음 단계
13. 편집 API 호출 (fields + sources 함께)
14. 이미지 없으면 수동 업로드 (Section 5)

[Phase 5: 자동 처리 확인 (5분 후)]
15. 분류 확인 → 오류 시 수동 수정 (Section 6)
16. Vectorize 인덱싱 확인 → 실패 시 수동 재시도 (Section 7)

[Phase 6: 커리어트리 (선택)]
17. 한국인 공인 인물 선정 + 경력 검증
18. DB INSERT (career_trees + career_tree_job_links)

[Phase 7: 프로덕션 검증]
19. curl로 페이지 렌더링 확인
20. QA 각주 순서 스크립트 실행
```

---

## 14. 대량 생성 패턴 (5개 이상 동시 추가)

5개 이상의 직업을 한 번에 추가할 때는 **3단계 분리 패턴**을 사용한다.

### 핵심 원칙
- **팀 리더(이 대화)**: 실존 검증, 스텁 생성, 검증+API 호출 담당
- **Researcher Agent**: 리서치+JSON 초안 반환만. API 호출 절대 금지
- 병렬 에이전트 최대 3개. 각 1~2개 직업 담당

```
Phase 1: 팀 리더 — 사전 검증 (전체 직업 일괄 처리)
  - check-name API로 각 직업명 중복 확인
  - DB LIKE 검색으로 유사 이름 확인
  - 커리어넷/워크넷에서 실존 여부 일괄 확인
  - 문제없는 직업만 Phase 2로 진행

Phase 2: 팀 리더 — 스텁 일괄 생성
  - 각 직업별 POST /api/job/create 순차 호출
  - 이미지 생성이 동기(최대 60초)이므로 직업당 60-70초 소요
  - 응답에서 id, slug, imageUrl 기록

Phase 3: Researcher Agent (3개 병렬, 각 1~2개 직업)
  - 역할: 리서치 + JSON 초안 반환 ONLY
  - ⚠️ API 호출 금지 — JSON 결과만 반환
  - 프롬프트: Section 15 템플릿 사용

Phase 4: 팀 리더 — 검증 + API 호출 (직업별 순차)
  - validate-job-edit.cjs로 자동 검증:
    node scripts/validate-job-edit.cjs < researcher_output.json
  - FAIL → 수정 후 재검증
  - PASS → 편집 API 호출 (Section 9)
  - sidebarJobs/sidebarMajors DB 존재 확인 (SQL)
  - 출처 URL curl 접속 검증

Phase 5: 프로덕션 확인 (전체 직업 일괄)
  - curl로 각 직업 페이지 렌더링 확인
  - QA 각주 순서 스크립트 일괄 실행 (Section 12-3)
  - 분류/Vectorize 일괄 확인 (약 5분 후)
```

### 주의사항
- 이미지 생성이 동기 처리라 스텁 생성 직렬 실행 불가 — 직업당 ~70초 예상
- 스텁 5개 생성에 5-6분, 10개에 10-12분 소요
- 병렬 에이전트 결과는 팀 리더가 하나씩 검증 후 API 호출 (병렬 API 호출 금지)

---

## 15. 에이전트 프롬프트 템플릿 (단일 직업용)

병렬 에이전트에게 넘길 때 아래 템플릿을 그대로 복사하고, `{변수}`만 교체한다.

**⚠️ 이 에이전트는 편집 API를 호출하지 않는다. JSON 결과만 반환한다.**

```
새 직업 "{직업명}" 생성을 위한 리서치 및 데이터 초안 작성.
직업 ID: {JOB_ID} (이미 POST /api/job/create로 스텁 생성 완료)

⚠️ 너는 편집 API를 호출하지 않는다. 리서치 결과를 JSON으로 반환만 한다.

## 실존 검증 결과
{실존 확인된 출처 URL 또는 신생 직업 근거 자료 요약}

## 현재 DB 상태
{팀 리더가 조회한 현재 user_contributed_json 요약 — 스텁이므로 summary만 있을 것}

## 작업 지시
1. 아래 모든 필드를 처음부터 작성하라. 출처 없으면 절대 넣지 마라
2. 새 직업이므로 API 데이터 없음 — 공식 DB + 웹 검색으로 전량 수집
3. sidebarJobs/sidebarMajors — DB에 실제 존재하는 항목만
4. 커리어트리는 한국인 공인만. 적합 인물 없으면 null

## 채울 필드 목록
- **summary**: 100-300자 직업 설명. 수행 직무 + 활동 영역 + 필요 역량
- **way**: 되는 방법 200-500자. 자격요건→교육→진입경로→실무팁. 각주 [N] 필수
- **overviewWork.main**: 수행 직무 100-300자. 각주 필수
- **overviewSalary.sal**: 임금 서술. 공식 형식(하위/평균/상위) 또는 텍스트+각주
- **overviewProspect.main**: 전망 서술 200-400자. 각주 필수
- **trivia**: 이 직업을 진지하게 생각하게 만드는 검증된 팩트 1개
- **detailWlb**: {wlb:"등급", social:"등급", wlbDetail:"서술[N]", socialDetail:"서술[N]"}
- **detailReady**: {curriculum:[5개+], recruit:[채용경로], training:[양성과정]}
- **sidebarCerts**: [{name, url}]. 자격증만(시험 아님). "~시험" 금지
- **sidebarMajors**: string[]. DB 존재 확인: SELECT name FROM majors WHERE is_active=1 AND name IN (...)
- **sidebarJobs**: 7~12개. DB 존재 확인. 핵심 연관 직업만
- **heroTags**: 3~10개, 2~15자 명사구. 별칭/세부분류/영문명 포함
- **overviewAbilities.technKnow**: 활용 기술 서술 (출처+각주 필수)
- **youtubeLinks**: [{url, title}]. YouTube Data API로 검색. 공식채널 우선 1~3개
- **detailIndicators**: 고용24 재직자 조사 7항목. 없으면 null
- **customCharts**: 해당 직업 특유 시각화. 공식 통계만. 없으면 null

## 절대 금지
- abilityList/aptitude/education에 공식 통계 없이 수치 넣기 → null 유지
- 출처 없는 데이터, 추정값, AI 생성 수치
- 커리어트리에 외국인, 전직 스테이지, 수상 독립 스테이지

## 각주 규칙
- 필드별 [1]부터 순차. 같은 [N] 2회 등장 금지
- 마침표 뒤에: 합니다.[1] (O)

## 출처 규칙
- sources text: "[N] 출처설명" 형식. text에 URL 포함 금지
- 각 출처를 개별 {text, url} 객체로
- sources 키: way→"way", salary→"overviewSalary.sal", prospect→"overviewProspect.main", trivia→"trivia", wlbDetail→"detailWlb.wlbDetail", socialDetail→"detailWlb.socialDetail"

## 반환 형식 (이 JSON을 마지막에 출력)
{
  "jobName": "{직업명}",
  "jobId": "{JOB_ID}",
  "fields": { ... },
  "sources": { ... },
  "careerTree": { "person_name": "...", "stages_json": [...], "person_title": "..." } | null,
  "changeSummary": "신규 직업 생성: 전체 데이터 보완 [변경 사유 상세]"
}
```

---

## 15. equalize 스킬과의 차이점 요약

| 항목 | job-data-create (이 스킬) | job-data-equalize |
|------|--------------------------|-------------------|
| 전제 | DB에 직업 없음 | DB에 직업 존재 |
| Phase 1 | 실존 검증 + slug 확인 (필수) | 없음 |
| Phase 2 | 스텁 생성 (POST /api/job/create) | 없음 |
| 리서치 | 모든 필드를 처음부터 | 빈 필드 + 기존 최신화 |
| 이미지 | 자동 생성 확인 + 수동 업로드 | 보통 이미 있음 |
| 분류 확인 | 자동 분류 결과 검증 필수 | 보통 이미 있음 |
| Vectorize | 신규 인덱싱 확인 필수 | 이미 인덱스 존재 |
| Phase 3+ | equalize와 동일한 편집 API + 커리어트리 | 동일 |

---

## 16. 잠재적 위험 및 주의사항

1. **slug 충돌**: 생성 전 `check-name` API + SQL LIKE 검색으로 반드시 확인
2. **이미지 생성 실패**: 응답에 `imageUrl` 없으면 Section 5에서 수동 처리 필요
3. **분류 타임아웃**: waitUntil 처리라 즉시 완료 안 됨 — 3분 후 확인
4. **Vectorize 지연**: 인덱싱도 비동기 — 5분 후 확인
5. **sources 누락**: fields + sources 항상 함께 전송 (가장 빈번한 치명적 실수)
6. **공식 출처 없는 신생 직업**: 근거 자료(뉴스/채용공고) 없으면 추가 자체를 재검토
7. **sidebarJobs에 미존재 직업**: DB 존재 확인 없이 추가하면 broken link
8. **summary 부실**: 짧거나 마케팅 문구이면 Vectorize 추천 품질 저하
