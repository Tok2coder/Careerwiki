# 직업 정보 수준 평준화 스킬

유저가 "정보 수준 평준화", "직업 데이터 보완", "job data equalize" 등을 말하면 이 스킬을 실행한다.
지정된 직업(들)의 빈 필드를 리서치하여 채우고, 출처와 함께 편집 API로 업데이트하는 전체 워크플로우.

---

## 0. 사전 준비

### 세션 토큰
편집 API 호출에 필요. 유저에게 요청하거나 기존 대화에서 재사용.
```
Cookie: session=SESSION_TOKEN
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

---

## 1. 현황 분석 (Analyst)

### 1-1. 대상 직업 데이터 확인
```sql
SELECT id, name, slug,
  CASE WHEN json_extract(merged_profile_json, '$.way') IS NOT NULL AND json_extract(merged_profile_json, '$.way') != '' THEN 'O' ELSE 'X' END as has_way,
  CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NOT NULL THEN 'O' ELSE 'X' END as has_salary,
  CASE WHEN json_extract(merged_profile_json, '$.overviewProspect.main') IS NOT NULL AND json_extract(merged_profile_json, '$.overviewProspect.main') != '' THEN 'O' ELSE 'X' END as has_prospect,
  CASE WHEN json_extract(merged_profile_json, '$.trivia') IS NOT NULL THEN 'O' ELSE 'X' END as has_trivia,
  json_extract(api_data_json, '$.careernet.encyclopedia.baseInfo.job_cd') as careernet_job_cd,
  json_extract(api_data_json, '$.careernet.encyclopedia.baseInfo.emp_job_cd') as emp_job_cd
FROM jobs WHERE name IN ('직업명1', '직업명2') AND is_active = 1
```

### 1-2. 기존 데이터 "모범 사례" 확인
빈 필드가 없는 직업 2-3개를 찾아 **실제 포맷/톤/깊이**를 파악:
```sql
SELECT name,
  substr(json_extract(merged_profile_json, '$.way'), 1, 200) as way_sample,
  substr(json_extract(merged_profile_json, '$.overviewProspect.main'), 1, 200) as prospect_sample
FROM jobs WHERE is_active = 1
  AND json_extract(merged_profile_json, '$.way') IS NOT NULL AND json_extract(merged_profile_json, '$.way') != ''
  AND json_extract(merged_profile_json, '$.overviewSalary.sal') IS NOT NULL
  AND json_extract(merged_profile_json, '$.overviewProspect.main') IS NOT NULL
LIMIT 3
```

---

## 2. 리서치 (Researcher)

### 2-1. 수집 대상 필드

| 필드 | 포맷 | 분량 | 주의사항 |
|------|------|------|---------|
| `way` | 줄바꿈(\n) 단락 구분 | 200-500자 | 학력→자격증→단계별 경로→실무 팁 |
| `overviewSalary.sal` | "조사년도:YYYY년, 임금 하위(25%) N만원, 평균(50%) N만원, 상위(25%) N만원" | 정확한 형식 필수 | 25th/50th/75th 백분위 공식 통계만. 없으면 건너뜀 |
| `overviewProspect.main` | 단락 텍스트 | 200-400자 | "~전망됩니다" 객관적 톤 |
| `trivia` | string[] (JSON 배열) | 3-5개 항목 | 흥미로운 사실, 업계 에피소드 |

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

### 2-3. 리서치 결과 포맷

직업별로 아래 형태로 정리:
```
## 간호사 (ID: 1765283280202496)

### way (되는 방법)
[작성할 텍스트]

### overviewSalary.sal (임금)
조사년도:2022년, 임금 하위(25%) 255만원, 평균(50%) 295만원, 상위(25%) 363만원
※ 공식 25/50/75 백분위 수치가 없으면 "없음"

### overviewProspect.main (전망)
[작성할 텍스트]

### trivia (여담)
["항목1", "항목2", "항목3"]

### 출처 (세부 URL 필수!)
- way: 커리어넷 간호사 직업정보 https://www.career.go.kr/cloud/w/job/view?seq=354
- way: 워크넷 간호사 https://www.work24.go.kr/wk/a/b/1500/acdmcrProfDtl.do?profSeq=3040
- salary: 한국고용정보원 KNOW 간호사 https://know.work.go.kr/職업명/임금
- prospect: 한국직업전망 2023 https://www.keis.or.kr/...
```

**출처 URL이 실제로 접근 가능한지 WebFetch로 검증 필수. 404면 대체 URL 찾기.**

---

## 3. 편집 API 호출 (Implementer)

### 3-1. API 스펙
```
POST https://careerwiki.org/api/job/{id}/edit
Content-Type: application/json
Cookie: session=SESSION_TOKEN
```

### 3-2. 요청 Body

```json
{
  "fields": {
    "way": "이 직업이 되기 위해서는...\n\n필요한 학력...",
    "overviewSalary.sal": "조사년도:2022년, 임금 하위(25%) 255만원, 평균(50%) 295만원, 상위(25%) 363만원",
    "overviewProspect.main": "향후 5~10년간...",
    "trivia": "[\"사실1\", \"사실2\", \"사실3\"]"
  },
  "sources": {
    "way": [
      {"text": "커리어넷 간호사 직업정보 https://www.career.go.kr/cloud/w/job/view?seq=354"},
      {"text": "워크넷 간호사 https://www.work24.go.kr/wk/a/b/1500/acdmcrProfDtl.do?profSeq=3040"}
    ],
    "overviewSalary.sal": [
      {"text": "한국고용정보원 KNOW https://know.work.go.kr/..."}
    ],
    "overviewProspect.main": [
      {"text": "한국직업전망 2023 https://www.keis.or.kr/..."}
    ]
  },
  "changeSummary": "way, salary, prospect, trivia 필드 보완"
}
```

### 3-3. 필드별 주의사항

| 필드 | 포맷 | 주의 |
|------|------|------|
| `way` | string (줄바꿈 \n 포함) | 기존 `way` 데이터 있으면 **덮어쓰지 말고** 보완만 |
| `overviewSalary.sal` | 정확한 형식 문자열 | "조사년도:YYYY년, 임금 하위(25%) N만원, 평균(50%) N만원, 상위(25%) N만원" — 이 형식이 아니면 차트 깨짐 |
| `overviewProspect.main` | string | 기존 전망 있으면 보완만 |
| `trivia` | JSON 문자열화된 배열 | `"[\"항목1\", \"항목2\"]"` 형태로 전송 |

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

## 4. 프로덕션 검증

편집 API 호출 후 반드시 프로덕션에서 확인:

### 4-1. Playwright MCP로 확인
```
1. browser_navigate → https://careerwiki.org/job/{slug}
2. browser_snapshot → 페이지 구조 확인
3. "출처" 버튼 클릭 → 사용자 추가 출처 확인
```

### 4-2. 확인 항목
```
[ ] way(되는 방법): "과정" 탭에 표시됨
[ ] salary: 임금 차트가 정상 렌더링 (하위/평균/상위 바 차트)
[ ] prospect: "커리어 전망" 섹션에 표시됨
[ ] trivia: 여담 섹션에 불릿 리스트로 표시됨
[ ] 출처: 한국어 라벨 ([되는 방법], [임금 정보] 등) + 클릭 가능한 URL
[ ] 기존 데이터 유지: 기존에 있던 다른 필드가 사라지지 않았음
```

---

## 5. 실행 패턴

### 단일 직업
```
1. DB에서 해당 직업의 현재 데이터 확인 (빈 필드 파악)
2. 빈 필드만 리서치 (이미 채워진 필드는 건드리지 않음)
3. 세부 출처 URL 수집 + WebFetch 검증
4. 편집 API 호출
5. 프로덕션 확인
```

### 대량 (10개 이상)
```
1. Analyst Agent → 전체 현황 분석 + 대상 선별
2. Researcher Agent(들) → 병렬 리서치 (5-7개씩 배치)
3. Content Creator Agent → 포맷 가공 (기존 모범 사례와 톤 일치)
4. Team Leader → 품질 검수 (출처 URL 유효성, 포맷 일관성)
5. Implementer Agent(들) → 병렬 API 호출 (5-7개씩 배치)
6. 프로덕션 샘플 검증 (배치당 1-2개)
```

---

## 6. 절대 금지

- 출처 없는 통계/수치 입력
- 기존 데이터 덮어쓰기 (기존 데이터가 있으면 보완만)
- 메인 도메인만 출처로 기록 (https://www.career.go.kr ← 이렇게 하면 안 됨)
- salary 형식 미준수 (차트 깨짐)
- 공식 25/50/75 백분위 수치 없는 직업에 salary 추정치 입력
- `.dev.vars` 커밋, `DROP TABLE`, `DELETE FROM` (WHERE 없이)

---

## 7. 세션 토큰 사용법

모든 API 호출에 인증 필요:
```
Cookie: session=SESSION_TOKEN
```
토큰은 유저에게 요청하거나, 기존 대화에서 재사용.
