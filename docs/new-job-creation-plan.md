# 새 직업 추가 워크플로우 계획서

> 작성일: 2026-03-27
> 분석 기준 코드: `src/routes/job-editor.ts`, `src/services/editService.ts`, `migrations/`, `.claude/skills/job-data-equalize.md`

---

## 1. 개요

기존 CareerWiki 직업은 두 가지 경로로 추가되었다:
- **ETL 경로**: CareerNet/Work24 API → scripts/etl/ → D1 bulk import
- **사용자 생성 경로**: `POST /api/job/create` → 최소 데이터만 있는 스텁(stub) 생성

**완전한 새 직업 추가** = 스텁 생성(Step 1-2) + 데이터 보완(Step 3-6)의 두 단계 작업이다.

---

## 2. 데이터 구조 참조

### 2-1. jobs 테이블 핵심 컬럼

| 컬럼 | NOT NULL | 기본값 | 설명 |
|------|----------|--------|------|
| `id` | YES | — | PK, ETL: `job:G_K000000890`, 사용자 생성: `U_{slug}_{base36 timestamp}` |
| `name` | YES | — | 직업명 (고유값으로 중복 체크됨) |
| `slug` | UNIQUE | — | URL slug. 생성 시 `name.replace(/[\s]+/g, '-').toLowerCase()` |
| `created_at` | YES | — | Unix timestamp (ms) |
| `is_active` | NO | 1 | 0이면 숨겨짐 |
| `primary_source` | NO | NULL | `'USER'` / `'CAREERNET'` / `'WORK24_JOB'` |
| `user_contributed_json` | NO | NULL | 사용자 편집 데이터 JSON |
| `merged_profile_json` | NO | NULL | 최종 병합 프로필 JSON (검색/렌더링 기준) |
| `image_url` | NO | NULL | 썸네일 이미지 URL (R2 CDN URL) |
| `image_prompt` | NO | NULL | AI 이미지 생성 프롬프트 |
| `view_count` | NO | 0 | 조회수 |

### 2-2. 데이터 병합 우선순위
```
admin_data_json > user_contributed_json > api_data_json
merged_profile_json = 세 소스를 deepMerge한 최종 결과
```

### 2-3. 이미지 경로 패턴
- **R2 키**: `jobs/{slug}-{timestamp}.{ext}`
- **공개 URL**: `https://careerwiki.org/images/jobs/{slug}-{timestamp}.{ext}` (또는 R2 public URL)
- **크기**: 1280×720 (16:9) — Evolink Z-Image Turbo API 고정

---

## 3. 새 직업 추가 단계별 워크플로우

### Step 1: 중복 확인 (필수 — 생략 금지)

```bash
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id, name, slug, is_active FROM jobs WHERE name LIKE '%직업명%'"
```

- **활성 직업 중복**: 추가 중단. 기존 직업 보완으로 전환.
- **비활성(is_active=0) 중복**: 재활성화 여부 검토 후 결정.
- **유사 이름 존재**: heroTags에 별칭 추가로 커버 가능한지 검토.

---

### Step 2: 스텁(Stub) 생성

**방법 A: API 호출 (권장, 로그인 필요)**

```bash
curl -X POST https://careerwiki.org/api/job/create \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{
    "name": "직업명",
    "summary": "직업에 대한 기본 설명 (2자 이상)",
    "heroTags": ["태그1", "태그2"],
    "heroCategory": "대분류/소분류"
  }'
```

**응답값 (저장 필요)**:
```json
{
  "success": true,
  "id": "U_직업명_abc123",
  "slug": "직업명",
  "imageUrl": "https://...",
  "imagePrompt": "..."
}
```

**방법 B: 관리자 SQL INSERT (로그인 불가 시)**

```sql
INSERT INTO jobs (id, name, slug, user_contributed_json, merged_profile_json, user_last_updated_at, created_at, is_active, primary_source)
VALUES (
  'U_직업명_' || lower(hex(randomblob(4))),
  '직업명',
  '직업명',  -- 공백→하이픈 처리 필요
  '{"summary":"설명"}',
  '{"id":"U_직업명_xxx","name":"직업명","summary":"설명","source":"USER"}',
  unixepoch('now') * 1000,
  unixepoch('now') * 1000,
  1,
  'USER'
);
```

**방법 A vs B 비교**:
| 항목 | API (A) | 직접 SQL (B) |
|------|---------|------------|
| 이미지 자동 생성 | ✅ (Gemini+Evolink) | ❌ (수동 업로드 필요) |
| 자동 태깅 | ✅ (waitUntil) | ❌ (별도 실행 필요) |
| 자동 벡터라이제이션 | ✅ (waitUntil) | ❌ (별도 실행 필요) |
| 자동 분류 | ✅ (waitUntil) | ❌ (별도 실행 필요) |
| 권한 필요 | 로그인 세션 | wrangler 접근권 |

→ **방법 A 사용 권장**. 백그라운드 처리가 완료되는 데 1-3분 소요.

---

### Step 3: 데이터 보완 (job-data-equalize 스킬 실행)

스텁 생성 후 `/job-data-equalize` 스킬로 모든 필드를 채운다. 이 단계가 가장 큰 작업량이다.

**필수 채워야 하는 필드 (우선순위 순)**:

| 순위 | 필드 | 포맷 | 비고 |
|------|------|------|------|
| ★★★ | `way` | 서술형 텍스트 (200-500자, 각주 지원) | 되는 방법: 자격요건, 교육경로, 진입방법 |
| ★★★ | `overviewWork.main` | 서술형 텍스트 | 수행 직무 설명 |
| ★★★ | `detailReady` | 구조화 객체 (curriculum/recruit/training) | 준비 방법 상세 |
| ★★ | `overviewSalary.sal` | 텍스트 또는 공식 형식 | 임금 정보 (공식 통계 필수) |
| ★★ | `overviewProspect.main` | 서술형 텍스트 (200-400자) | 고용 전망 |
| ★★ | `trivia` | 순수 문자열 1개 | 업계 현실/의외의 통계 |
| ★★ | `detailWlb` | 구조화 객체 (wlb/social/wlbDetail/socialDetail) | 워라밸/사회공헌 |
| ★ | `sidebarJobs` | `string[]` | 관련 직업 (DB 존재 검증 필수) |
| ★ | `sidebarMajors` | `string[]` | 관련 전공 (DB 존재 검증 필수) |
| ★ | `sidebarCerts` | `[{name, url}]` | 관련 자격증 |
| ★ | `youtubeLinks` | `[{url, title}]` | YouTube API로 수집 |

**편집 API 호출 방법**:
```bash
curl -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{
    "fields": {
      "way": "자격요건 서술...[1]\n\n진입 경로...[2]",
      "trivia": "이 직업의 흥미로운 사실.[1]"
    },
    "sources": {
      "way": [
        {"url": "https://example.com/source1", "title": "출처 1"},
        {"url": "https://example.com/source2", "title": "출처 2"}
      ],
      "trivia": [
        {"url": "https://example.com/source3", "title": "출처 3"}
      ]
    },
    "changeSummary": "새 직업 데이터 보완"
  }'
```

⚠️ **sources 없이 fields만 보내면 각주가 깨짐** — 반드시 함께 전송.

---

### Step 4: 커리어트리 추가 (선택사항)

대표적인 실존 인물의 커리어 경로가 있을 때 추가. **반드시 한국인만**.

```sql
-- 커리어트리 인물 추가
INSERT INTO career_trees (person_name, person_name_en, person_title, stages_json, display_priority, is_active, created_at, updated_at)
VALUES (
  '인물명',
  'Person Name',
  '직함/설명',
  '[{"stage":"~대학교","year":"1995"},{"stage":"~회사 입사","year":"2000"}]',
  100,
  1,
  unixepoch('now') * 1000,
  unixepoch('now') * 1000
);

-- 커리어트리-직업 연결 (slug 기준)
INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index)
VALUES (last_insert_rowid(), '직업-slug', 2);  -- stage_index: 하이라이트할 단계
```

```bash
npx wrangler d1 execute careerwiki-kr --remote --file scripts/insert-커리어트리.sql
```

---

### Step 5: 이미지 검증 및 업로드 (필요 시)

Step 2 API 응답에 `imageUrl`이 있으면 자동 생성 성공 → 스킵 가능.

**이미지 없는 경우 수동 업로드**:
```bash
# 1. 이미지 파일 준비 (1280×720 권장)
# 2. R2 업로드
npx wrangler r2 object put careerwiki-uploads/jobs/{slug}-{timestamp}.jpg \
  --file ./path/to/image.jpg --content-type image/jpeg

# 3. DB 업데이트
npx wrangler d1 execute careerwiki-kr --remote --command \
  "UPDATE jobs SET image_url='https://images.careerwiki.org/jobs/{slug}-{timestamp}.jpg' WHERE name='직업명'"
```

---

### Step 6: 벡터라이제이션 검증

API 생성(방법 A)이면 자동으로 처리됨. 1-3분 후 확인:

```bash
# 벡터 인덱스에 등록됐는지 간접 확인 (추천 검색에서 뜨는지)
curl -s "https://careerwiki.org/api/ai-analyzer/search?q=직업명키워드" | head -200
```

SQL INSERT(방법 B)를 사용했거나 벡터 인덱싱에 실패했으면:
```bash
# 수동 벡터라이제이션 (스크립트 직접 실행 필요 — 로컬 환경에서)
npx tsx scripts/vectorize-content.ts --job-id U_직업명_xxx
```

---

### Step 7: 최종 검증

```bash
# 직업 페이지 접근 확인
curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep -o "<title>[^<]*</title>"

# 핵심 필드 채워졌는지 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT name, slug, image_url,
     substr(json_extract(merged_profile_json, '$.way'), 1, 100) as way_preview,
     json_extract(merged_profile_json, '$.overviewSalary.sal') as salary,
     json_extract(merged_profile_json, '$.trivia') as trivia
   FROM jobs WHERE name = '직업명'"
```

---

## 4. 기존 보완 스킬(job-data-equalize)과의 차이점

| 항목 | 기존 보완 (equalize) | 새 직업 추가 |
|------|---------------------|------------|
| 전제 | DB에 이미 직업 레코드 존재 | DB에 직업 없음 |
| 추가 작업 | 없음 | **Step 1-2 (스텁 생성)** 필요 |
| 공유 부분 | — | Step 3 (데이터 보완)은 동일 스킬 사용 |
| 이미지 | 기존 이미지 있을 수 있음 | 없음 (Step 2 API에서 자동 생성 시도) |
| 커리어트리 | 추가 가능 | 추가 가능 (Step 4) |
| 벡터라이제이션 | 기존 인덱스 존재 | 없음 → Step 6 확인 필요 |

**핵심**: Step 3 이후는 **완전히 동일**. 새 직업 추가 = 스텁 생성 → equalize 스킬 실행.

---

## 5. 자동화 가능 vs 수동 작업

### 자동화 가능 (API + 백그라운드)
- ✅ DB 레코드 생성 (`POST /api/job/create`)
- ✅ 썸네일 이미지 생성 (Gemini+Evolink, waitUntil)
- ✅ heroTags 자동 태깅 (OpenAI, waitUntil)
- ✅ MECE 분류 (OpenAI, waitUntil)
- ✅ 벡터라이제이션 (OpenAI embedding + Vectorize, waitUntil)

### 수동 작업 필요
- ❌ `way`, `overviewProspect.main`, `overviewSalary.sal` 등 서술형 필드 — 공식 출처 리서치 필요
- ❌ `sidebarJobs`, `sidebarMajors` — DB 존재 검증 후 선별 필요
- ❌ `youtubeLinks` — YouTube API 검색 후 수동 선별
- ❌ 커리어트리 인물 — 인물 선정 + SQL INSERT
- ❌ 이미지 자동 생성 실패 시 — 수동 이미지 업로드

---

## 6. 잠재적 위험 및 주의사항

### 6-1. Slug 충돌
- 문제: `name.replace(/[\s]+/g, '-').toLowerCase()` 처리 후 동일 slug 발생 가능
  - 예: "웹 디자이너" → `웹-디자이너`, "웹디자이너" → `웹디자이너` (다름)
  - 예: "회계사" vs "회계사 (공인)" → 두 번째가 `회계사-(공인)` → 다름
- 예방: Step 1에서 유사 이름까지 미리 확인

### 6-2. 이미지 생성 실패
- Evolink API 타임아웃(60초) 또는 프롬프트 오류 시 이미지 없이 생성됨
- `imagePrompt`는 저장되므로 나중에 재시도 가능
- `image_prompt` 컬럼에 프롬프트가 있으면 Evolink 단독 재호출 가능

### 6-3. 벡터라이제이션 타이밍
- `waitUntil`은 비동기라 즉시 완료되지 않음 (최대 1-3분)
- 생성 직후 AI 추천 검색에서 안 뜨는 것은 정상

### 6-4. sources 누락 각주 깨짐
- 편집 API 호출 시 `sources` 키 없이 본문에 `[N]` 각주를 넣으면 클릭 불가 텍스트로 표시됨
- **항상 fields + sources 동시 전송** (job-data-equalize 원칙 1)

### 6-5. DB 미존재 직업/전공 링크
- `sidebarJobs`, `sidebarMajors` 에 DB에 없는 이름을 넣으면 broken link
- **반드시 `SELECT name FROM jobs WHERE is_active=1 AND name IN (...)`로 검증 후 추가**

### 6-6. 관리자 SQL 직접 사용 시 누락 항목
- 방법 B(SQL INSERT)로 생성 시 자동 태깅/분류/벡터라이제이션 모두 누락됨
- 생성 후 수동으로 각 백그라운드 작업 실행 필요 (스크립트 별도 존재)

---

## 7. 전체 체크리스트

```
□ Step 1: 중복 확인 (활성/비활성 포함)
□ Step 2: 스텁 생성 (API 방법 A 권장)
  □ 응답에서 id, slug 저장
  □ imageUrl 확인 (없으면 Step 5 필요)
□ Step 3: 데이터 보완 (job-data-equalize 스킬)
  □ way 작성 (출처 필수)
  □ overviewWork.main 작성
  □ detailReady (curriculum/recruit/training)
  □ overviewSalary.sal (공식 통계)
  □ overviewProspect.main
  □ trivia (1개, 출처 필수)
  □ detailWlb (wlb/social/wlbDetail/socialDetail)
  □ sidebarJobs (DB 검증 후 7-12개)
  □ sidebarMajors (DB 검증 후)
  □ sidebarCerts
  □ youtubeLinks (YouTube API로 수집)
□ Step 4: 커리어트리 추가 (선택, 한국인만)
□ Step 5: 이미지 없으면 수동 업로드
□ Step 6: 벡터라이제이션 확인 (1-3분 후)
□ Step 7: careerwiki.org/job/{slug}에서 최종 확인
```

---

## 8. 예상 작업 시간

| 단계 | 작업 유형 | 예상 소요 |
|------|----------|---------|
| Step 1-2 | API 호출 + 확인 | 5분 |
| Step 3 | 리서치 + 편집 API | 30-60분 (직업 복잡도 따라 다름) |
| Step 4 | 커리어트리 조사 + SQL | 10-20분 (선택) |
| Step 5 | 이미지 업로드 | 5분 (필요 시만) |
| Step 6-7 | 검증 | 5분 |
| **합계** | | **50-90분** |

가장 시간이 많이 걸리는 부분은 Step 3의 공식 출처 리서치이다.
