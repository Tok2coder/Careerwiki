# 직업 정보 수준 평준화 스킬

유저가 "정보 수준 평준화", "직업 데이터 보완", "job data equalize" 등을 말하면 이 스킬을 실행한다.
대상 직업(들)의 **모든 필드**를 점검하고, 기존 데이터의 최신성을 검증하며, 빈 필드를 리서치하여 채우고, 출처와 함께 편집 API로 업데이트하는 전체 워크플로우.

---

## ⚠️ 최우선 원칙: 출처 없으면 안 넣는다

**모든 데이터에는 반드시 출처가 있어야 한다.** 이것은 절대 원칙이다.

- 공식 통계를 **최대한** 찾아서 넣되, 찾을 수 없으면 **해당 필드를 비워둔다**
- 추정값, AI가 생성한 수치, 근거 없는 데이터는 **절대 넣지 않는다**
- 텍스트 필드든 구조화 데이터 필드든 동일한 원칙 적용
- 이 원칙은 "빈 필드보다 잘못된 데이터가 더 나쁘다"는 판단에 기반함

---

## 0. 사전 준비

### 세션 토큰
편집 API 호출에 필요. 유저에게 요청하거나 기존 대화에서 재사용.
```
Cookie: session_token=SESSION_TOKEN
```

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
| 워라밸 | `detailWlb.wlb` | `string` | 고용24 재직자 조사 또는 검증된 출처 |
| 사회적 기여 | `detailWlb.social` | `string` | 고용24 재직자 조사 또는 검증된 출처 |
| 정규 교육과정 | `detailReady.curriculum` | `string[]` | 대학 교과과정, 양성기관 커리큘럼 공식 페이지 |
| 채용 정보 | `detailReady.recruit` | `string[]` | 실제 채용 공고/채용 채널 |
| 필요 훈련 | `detailReady.training` | `string[]` | 공식 양성과정, 교육기관 정보 |
| 진로 탐색 활동 | `detailReady.researchList` | `[{title:string}]` | 실제 프로그램/기관명 |

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

---

## 2. 리서치 (Researcher)

### 2-1. 수집 대상 필드

| 필드 | 포맷 | 분량 | 주의사항 |
|------|------|------|---------|
| `way` | 줄바꿈(\n) 단락 구분 | 200-500자 | 학력→자격증→단계별 경로→실무 팁 |
| `overviewSalary.sal` | 공식 형식이면 차트, 아니면 서술형 텍스트+각주 | 200-300자 | 공식 형식: "하위(25%) N만원, 평균(50%) N만원, 상위(25%) N만원" → 차트 렌더링. 비공식: 자유 텍스트 → 서술형+각주로 표시. 둘 다 출처 필수 |
| `overviewProspect.main` | 단락 텍스트 | 200-400자 | "~전망됩니다" 객관적 톤 |
| `trivia` | 순수 문자열 | **1개만** | 유저 기여용 공간이므로 최소한으로. 가장 흥미로운 사실 하나만 |

### 2-2. 리서치 범위 (핵심!)

**커리어넷/워크넷에만 의존하지 않는다. 웹 전체에서 실질적으로 도움되는 정보를 수집한다.**

리서치 순서:
1. **웹 검색으로 광범위 수집**: `"{직업명}" 되는법`, `"{직업명}" 연봉`, `"{직업명}" 전망 2025` 등으로 검색
2. **다양한 출처 활용**: 공식 통계뿐 아니라 협회, 뉴스, 실무자 인터뷰, 업계 보고서 등
3. **실질적 가치 우선**: 단순 개론보다 현장감 있는 정보 (취업 루트, 실제 연봉 범위, 업계 트렌드 등)

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

### 2-3. 인라인 각주 시스템 (핵심!)

**모든 사실/통계에 인라인 각주 `[N]`을 달아야 한다.** 렌더링 시 자동으로 클릭 가능한 superscript로 변환됨.

#### 텍스트 + 각주 작성 규칙
1. **각주는 마침표 뒤에 붙인다**: `합격해야 합니다.[1]` (O) / `합격해야 합니다[1].` (X)
2. 같은 필드 안에서 번호는 1부터 순서대로
3. 출처 텍스트는 `[N] 출처명` 형식 (URL은 별도 필드)
4. **한 필드에 최소 2개 이상, 최대 6개 이내 각주**
5. 렌더링에서 `다[N].` → `다.[N]` 자동 정규화가 있지만, 처음부터 올바른 위치에 작성할 것

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

### 2-4. 콘텐츠 작성 원칙

**API에 이미 있는 정보를 반복하지 않는다.** 커리어넷/워크넷 데이터는 이미 페이지에 표시 중.

**기존 데이터가 있을 때**: 더 최신이거나 더 정확한 정보가 있으면 덮어쓸 수 있다. 단, changeSummary에 "기존 데이터 대비 변경 사유" 기록 필수.

새로 추가할 정보:
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
Cookie: session_token=SESSION_TOKEN
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

### 3-4. 출처 소스 키 매핑

| 소스 키 | 한국어 라벨 (렌더링) | 설명 |
|---------|---------------------|------|
| `way` | 되는 방법 | 되는 방법 필드의 출처 |
| `overviewSalary.sal` | 임금 정보 | 임금 필드의 출처 |
| `overviewProspect.main` | 전망 정보 | 전망 필드의 출처 |
| `trivia` | 여담 | 여담 필드의 출처 |
| `summary` | 직업 설명 | 요약 필드의 출처 |

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

## 4. 프로덕션 검증

편집 API 호출 후 반드시 프로덕션에서 확인:

### 4-1. curl로 확인
```bash
curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep "확인할 키워드"
```

### 4-2. 확인 항목
```
[ ] way(되는 방법): "과정" 탭에 표시됨
[ ] salary: 임금 차트가 정상 렌더링 (하위/평균/상위 바 차트)
[ ] prospect: "커리어 전망" 섹션에 표시됨
[ ] trivia: 여담 섹션에 1개 불릿으로 표시됨
[ ] 구조화 데이터: 적성/흥미/학력분포 등 해당 섹션에 렌더링됨
[ ] 출처: 필드별 그룹핑 + 클릭 가능한 URL
[ ] 인라인 각주: 마침표 뒤에 [N] superscript 표시
[ ] 각주 tooltip: hover 시 출처 설명 표시
[ ] 각주 번호 매칭: 텍스트의 [N]과 출처의 [N]이 일치
[ ] 기존 데이터 유지: 다른 필드가 사라지지 않았음
```

---

## 5. 실행 패턴

### 단일 직업
```
1. DB에서 해당 직업의 현재 데이터 전수 점검 (빈 필드 + 기존 데이터 최신성)
2. 웹 리서치 (기존 데이터 검증 + 빈 필드 채우기)
3. 세부 출처 URL 수집 + curl 검증
4. 편집 API 호출 (changeSummary에 변경 사유 상세 기록)
5. 프로덕션 확인
```

### 대량 (10개 이상)
```
1. Analyst Agent → 전체 현황 분석 + 대상 선별
2. Researcher Agent(들) → 병렬 리서치 (3-5개씩 배치)
   - 각 Agent가 리서치 + 편집 API 호출까지 직접 수행
3. QA Agent → 랜덤 3-5개 프로덕션 확인
4. 결과 보고
```

---

## 6. 절대 금지

- **출처 없는 데이터 입력 (텍스트든 구조화 데이터든)** ← 최우선 원칙
- **추정값/AI 생성 수치 입력** (만족도, 학력분포 %, 역량 점수 등을 근거 없이 추정 금지)
- 출처 없는 통계/수치 입력
- 메인 도메인만 출처로 기록 (https://www.career.go.kr ← 이렇게 하면 안 됨)
- salary에 추정치 입력 (출처 있는 데이터만)
- trivia 2개 이상 작성 (유저 기여용 공간이므로 1개만)
- 각주를 마침표 앞에 배치 (`합니다[1].` ← 금지. `합니다.[1]`이 올바른 형식)
- `.dev.vars` 커밋, `DROP TABLE`, `DELETE FROM` (WHERE 없이)

---

## 7. 세션 토큰 사용법

모든 API 호출에 인증 필요:
```
Cookie: session_token=SESSION_TOKEN
```
토큰은 유저에게 요청하거나, 기존 대화에서 재사용.
