---
name: job-supplement
description: "⚠️ DEPRECATED — job-data-enhance로 통합되었습니다. 이 스킬은 더 이상 사용하지 않습니다. 직업 데이터 보완 작업은 job-data-enhance 스킬을 사용하세요."
---

> ⚠️ DEPRECATED: 이 스킬은 `job-data-enhance`로 통합되었습니다. job-data-enhance를 사용하세요.

# Careerwiki 직업 데이터 보완 스킬

이 스킬은 careerwiki.org의 직업 데이터를 체계적으로 보완하는 워크플로우를 정의한다.
모든 직업은 동일한 12개 필드 + 출처 기준을 따르며, 하나의 일관된 프로세스로 처리된다.

## 핵심 원칙

1. **한 직업 = 한 SQL UPDATE** — 12개 필드를 모두 채운 뒤 단일 SQL로 실행
2. **출처가 곧 신뢰** — _sources 없는 데이터는 의미 없다
3. **실행 전 검증, 실행 후 확인** — 반드시 프로덕션 HTTP 200 확인
4. **같은 실수 반복 금지** — references/lessons.md 숙지 필수
5. **기존 데이터 함부로 변경 금지** — 이미 잘 작동하는 데이터(특히 `overviewSalary.wage`)를 덮어쓰면 안 됨. 변경 시 반드시 기존보다 공신력 있는 출처 필요. `overviewSalary.wage` + 구조화 포맷이 있으면 바 차트가 표시되므로, 이를 서술형으로 바꾸면 차트가 사라짐

## DB 접근

```bash
npx wrangler d1 execute careerwiki-kr --remote --command "SQL문"
```

- 프로젝트 경로: `C:\Users\PC\Careerwiki`
- 테이블: `jobs`
- 대상 컬럼: `user_contributed_json` (TEXT, JSON 문자열)
- 직업 조회: `SELECT id, title FROM jobs WHERE user_contributed_json IS NULL LIMIT 10`

## 워크플로우 (5단계)

### Step 1: 대상 직업 선택

```sql
-- NULL 직업 조회
SELECT id, title FROM jobs WHERE user_contributed_json IS NULL LIMIT 10;

-- 특정 직업 조회
SELECT id, title, LENGTH(user_contributed_json) as json_len
FROM jobs WHERE title LIKE '%키워드%';
```

배치 처리 시 10개 단위로 끊어서 진행한다. 각 직업의 id와 title을 기록해 둔다.

### Step 2: 데이터 수집 및 JSON 생성

각 직업에 대해 12개 필드를 모두 채운 JSON을 생성한다.
필드 상세 스펙은 `references/fields.md`를 읽어라.

**12개 필드 요약:**

| # | 필드 | 타입 | 핵심 규칙 |
|---|------|------|-----------|
| 1 | way | string | 반드시 문자열! 배열 금지 (500에러 유발) |
| 2 | overviewSalary | string | 구체적 연봉 범위 포함 |
| 3 | overviewProspect | string | 성장률/전망 수치 포함 |
| 4 | trivia | string | 흥미로운 사실 3개 이상 |
| 5 | detailWlb | string | 워라밸 실태 구체적 서술 |
| 6 | detailReady | string | 준비 과정 단계별 서술 |
| 7 | sidebarJobs | string[] | DB에 존재하는 관련 직업 3~5개 |
| 8 | sidebarMajors | string[] | 관련 전공 3~5개 |
| 9 | sidebarCerts | string[] | 관련 자격증 2~4개 |
| 10 | heroTags | string[] | 핵심 키워드 태그 4~6개 |
| 11 | youtubeLinks | object[] | 실존하는 YouTube 영상 1~3개 |
| 12 | _sources | object | 출처 정보 (A등급 포맷 필수) |

**중요:** 필드 상세 스펙과 예시는 반드시 `references/fields.md`에서 확인한다.

### Step 3: SQL 실행

```sql
UPDATE jobs
SET user_contributed_json = '{"way":"...","overviewSalary":"...","overviewProspect":"...","trivia":"...","detailWlb":"...","detailReady":"...","sidebarJobs":["..."],"sidebarMajors":["..."],"sidebarCerts":["..."],"heroTags":["..."],"youtubeLinks":[{"title":"...","url":"https://youtube.com/watch?v=...","channel":"..."}],"_sources":{"way":[{"id":1,"text":"출처명","url":"https://..."}],"overviewSalary":[{"id":1,"text":"출처명","url":"https://..."}]}}'
WHERE id = '직업ID';
```

실행 방법:
```bash
npx wrangler d1 execute careerwiki-kr --remote --command "UPDATE jobs SET user_contributed_json = '...' WHERE id = '직업ID';"
```

**SQL 실행 규칙:**
- Python 스크립트나 SQL 파일을 만들지 마라. `--command`로 직접 실행
- JSON 내부 작은따옴표는 두 개('')로 이스케이프
- 한 직업씩 순차 실행 (배치여도 10개를 하나씩)

### Step 4: 프로덕션 검증

각 직업 업데이트 후 반드시 프로덕션 URL을 확인:

```bash
curl -s -o /dev/null -w "%{http_code}" "https://careerwiki.org/job/직업슬러그"
```

> ⚠️ URL 형식: `/job/슬러그` (careerwiki.**kr** 아님, `/jobs` 아님)

- **200**: 정상
- **302**: URL에 하이픈이 있으면 라우터가 공백으로 치환 → 리다이렉트 (기존 이슈, 데이터 문제 아님)
- **500**: JSON 파싱 에러 가능성 → way가 배열인지, 따옴표 이스케이프 확인

### Step 5: 배치 완료 보고

배치 작업 완료 시 다음을 보고:
- 처리한 직업 수와 목록
- 성공/실패 건수
- 500 에러 발생 시 원인과 수정 내역
- 전체 커버리지 변화 (예: 657 → 667 / 6,959)

## 품질 등급 (Phase 1~5)

모든 직업은 아래 단계를 순차적으로 통과해야 한다.
새 직업은 처음부터 Phase 5 수준으로 생성하는 것이 목표.

| Phase | 이름 | 기준 |
|-------|------|------|
| 1 | 기본 보완 | 12개 필드 모두 존재, json ≥ 500자 |
| 2 | 출처 풍부화 | youtubeLinks 실존 영상 1개+, _sources에 실제 URL 3개+ |
| 3 | 콘텐츠 심화 | way ≥ 200자, trivia 3개+, overviewSalary에 구체적 수치 |
| 4 | 연결성 강화 | sidebarJobs 모두 DB에 실존하는 직업 |
| 5 | 최종 검증 | _sources A등급 포맷, 모든 URL 접근 가능, 포맷 통일 |

## 출처 규칙 (_sources)

출처 품질은 데이터 신뢰의 핵심이다. 상세 기준은 `references/sources.md`를 읽어라.

**A등급 포맷 (필수):**
```json
{
  "_sources": {
    "way": [{"id": 1, "text": "한국고용정보원", "url": "https://..."}],
    "overviewSalary": [{"id": 1, "text": "워크넷", "url": "https://..."}]
  }
}
```

- Object 형태, dot-notation 키 (way, overviewSalary 등)
- 각 값은 `{id, text, url}` 객체 배열
- 구형 포맷 (`URL=텍스트` 문자열)은 사용 금지

**순서 규칙 (필수):**
- `_sources`의 각 필드별 id는 반드시 본문에서 `[N]` 참조가 **처음 등장하는 순서**와 일치해야 한다
- 예: 본문에서 [1]이 먼저, [2]가 나중에 나오면 sources 배열도 id:1 먼저, id:2 나중
- 검증 방법: 본문 텍스트를 위에서 아래로 스캔하며 새 [N]이 등장할 때마다 목록에 기록 → 그 순서 == sources id 순서인지 확인

## YouTube 링크 규칙

```json
"youtubeLinks": [
  {
    "title": "영상 제목",
    "url": "https://www.youtube.com/watch?v=VIDEO_ID",
    "channel": "채널명"
  }
]
```

> ⚠️ **`title` 필드 필수** — title 없으면 UI에 URL 문자열이 그대로 제목으로 노출됨. oembed 응답의 `title` 값을 사용하라.

**필수 검증:** 모든 YouTube URL은 oembed API로 실존 확인:
```bash
curl -s "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=VIDEO_ID&format=json"
```
- 200 응답 = 실존
- 비어있거나 에러 = 사용 금지

**영상 선택 기준:**
- 최신 영상 우선 (1~2년 이내)
- **진로 탐색 중인 사용자 관점** 우선: "이 직업이 뭔지", "어떻게 되는지", "전망은 어떤지" 영상
- 단순 일과 vlog보다 **진로 가이드·인터뷰·전망 영상** 선호
- 한국어 영상 우선

## 교훈 (Lessons Learned)

과거 작업에서 발견된 실수와 해결법은 `references/lessons.md`에 정리되어 있다.
작업 시작 전에 반드시 한번 읽고, 같은 실수를 반복하지 마라.

핵심 교훈 7가지:
1. **way 필드는 반드시 string** — 배열로 저장하면 formatRichText TypeError → 500 에러
2. **Python 스크립트/SQL 파일 금지** — `--command`로 직접 실행이 가장 안정적
3. **worktree에서 배포 금지** — 반드시 main 브랜치에서 작업 + 배포
4. **_sources id 순서 = 본문 [N] 등장 순서** — 불일치 시 프론트엔드 참조번호 클릭이 엉뚱한 출처를 가리킴
5. **기존 overviewSalary.wage 변경 금지** — wage + 구조화 포맷이 있으면 바 차트 렌더링됨. 이를 서술형으로 바꾸면 차트가 사라짐. 더 나은 출처 없으면 건드리지 마라
6. **youtubeLinks title 필수** — title 없으면 URL이 제목으로 노출됨. oembed 응답 title 값 사용
7. **way vs detailReady 구분** — `way`는 페이지에서 "되는 방법" 섹션으로 렌더링됨 (서술형 진로 경로). `detailReady`는 교육과정/채용/훈련 섹션으로 렌더링됨 (구조화된 준비 단계). 혼동 금지

## 체크리스트

### 작업 전
- [ ] 대상 직업 ID와 title 확인
- [ ] references/fields.md 필드 스펙 확인
- [ ] references/lessons.md 교훈 숙지

### 각 직업 완료 후
- [ ] 12개 필드 모두 존재하는지 확인
- [ ] way가 string인지 확인 (배열 아닌지)
- [ ] _sources가 A등급 Object 포맷인지 확인
- [ ] _sources id 순서가 본문 [N] 등장 순서와 일치하는지 확인 (본문 위→아래 스캔)
- [ ] youtubeLinks: title 포함 여부 확인 (없으면 URL이 제목으로 노출됨)
- [ ] youtubeLinks: oembed 검증 완료
- [ ] youtubeLinks: 진로 가이드/인터뷰/전망 영상인지 확인 (단순 vlog 지양)
- [ ] 기존 overviewSalary.wage 있으면 덮어쓰지 않았는지 확인
- [ ] SQL 실행 성공
- [ ] 프로덕션 HTTP 200 확인 (`https://careerwiki.org/job/슬러그`)

### 배치 완료 후
- [ ] 처리 건수 보고
- [ ] 실패 건 원인 분석
- [ ] 커버리지 변화 보고
