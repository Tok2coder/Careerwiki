---
name: job-data-create
description: 새 직업 생성 스킬. CareerWiki에 완전히 새로운 직업을 추가할 때 사용한다. "새 직업 추가", "직업 생성", "직업 만들어줘", "job create", "없는 직업 추가", "스텁 생성", "직업 추가해줘" 등이 나오면 반드시 이 스킬을 사용한다. 기존 직업의 빈 필드를 채우는 작업은 job-data-equalize 스킬 사용.
---

# 새 직업 생성 스킬

새로운 직업을 **처음부터** CareerWiki에 추가하는 전체 워크플로우.

---

## ⚠️ 최우선 원칙 (7개)

| # | 원칙 | 핵심 규칙 |
|---|------|----------|
| 1 | **출처 없으면 안 넣는다** | 추정값·AI 생성 수치 금지. 없으면 null 유지 |
| 2 | **저작권 검증 후 사용** | 정부/공공 데이터는 자유 사용. "무단전재금지"는 팩트만 추출·재작성 |
| 3 | **fields + sources 반드시 함께 전송** | ✅ `{fields:{...}, sources:{...}}` / ❌ sources 누락 = 각주 깨짐 |
| 4 | **필드 우선순위** | ★★★ summary/way/detailReady · ★★ salary/prospect/wlb/trivia · ★ sidebar/tags |
| 5 | **이미지 생성은 필수** | 직업 생성 후 Section 5 이미지 확인 단계를 반드시 실행. 자동 생성 실패 시 수동 처리 |
| 6 | **raw [N] 마커 절대 금지** | merged_profile_json 등 외부 텍스트에서 가져올 때 `[1]`, `[2]` 형식의 raw 각주 마커 포함 여부를 반드시 확인·제거. sources에 매핑되지 않은 [N]은 절대 본문에 남기지 않는다 |
| 7 | **sources id = 본문 등장 순서** | 각 필드의 sources 배열 순서가 본문의 [1], [2], [3] 등장 순서와 일치해야 한다. 순서 불일치 = 잘못된 tooltip 표시 |

공유 소스 키 규칙 → `../shared/source-key-mapping.md` 참조
각주 검증 규칙 → `../shared/footnote-validation.md` 참조
커리어트리 인물 기준 → `../shared/career-tree.md` 참조

---

## 0. 사전 준비

**인증**: `X-Admin-Secret: careerwiki-admin-2026` (권장) 또는 `Cookie: session_token=SESSION_TOKEN`

**이름 중복 확인**: `curl -s "https://careerwiki.org/api/job/check-name?name={직업명}"` → `{"available":true}` → 진행 / `false` → 중단

---

## 1. 직업 실존 검증

### 1-0. 고유 통계 존재 여부 (최우선 게이트)
> 이 직업명만의 **공식 임금·고용 전망 통계**가 커리어넷/고용24/워크넷에 독립 수록되는가?

| 판정 | 조건 | 행동 |
|------|------|------|
| ✅ 생성 진행 | 해당 직업명 고유 통계 + 최소 3개 필드 차별화 데이터 확보 가능 | 아래 단계 계속 |
| ❌ 생성 불필요 | 통계 없음·상위 카테고리 통계 공유·3개 미만 차별화 | 기존 유사 직업 heroTags/summary 보강으로 전환 |

> **실패 사례**: "백엔드 개발자"는 채용공고 2,659건이지만 커리어넷/고용24에 독립 통계 없음 → 기각.

### 1-1. DB 중복 확인
```bash
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id, name, slug, is_active FROM jobs WHERE name LIKE '%{직업명}%' ORDER BY is_active DESC"
```
활성 동일 이름 → **중단** (equalize로 전환) / 비활성 → 재활성화 검토 / 유사 이름 → heroTags 처리 검토

### 1-2. 공식 DB 실존 확인
```bash
# WebFetch: https://www.career.go.kr/cloud/w/job/search?searchText={직업명}
# WebFetch: https://www.work.go.kr/empInfo/occupationInfo/occupList.do
```
신생 직업 허용 기준: 뉴스 독립 보도 / 협회 공식 인정 / 채용공고 5개 이상

### 1-3. slug 충돌 확인 + ⚠️ create API에 직업명 띄어쓰기 금지
```bash
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id, slug FROM jobs WHERE slug='{예상슬러그}'"
```
> `"name": "디지털포렌식수사관"` (O) / `"디지털 포렌식 수사관"` → slug에 하이픈 삽입 (X)

---

## 2. summary 작성 기준

| 항목 | 기준 |
|------|------|
| 분량 | 100-300자 (짧으면 임베딩 품질 저하) |
| 필수 포함 | 주요 업무 + 활동 영역/직장 + 필요 역량 |
| 금지 | "좋은 직업", "미래 유망", 가치 판단, 마크다운 `**` |

임베딩 폴백: `heroIntro → summary → description → category` → **생성 시 summary를 충분히 작성하는 것이 매우 중요.**

---

## 3. 직업 스텁 생성

```bash
curl -X POST https://careerwiki.org/api/job/create \
  -H "Content-Type: application/json" -H "X-Admin-Secret: careerwiki-admin-2026" \
  -d '{"name":"직업명","summary":"100-300자 설명","heroTags":["태그1","태그2"],"heroCategory":"대분류/소분류"}'
# 응답: {"success":true,"id":"U_xxx","slug":"직업명","imageUrl":"https://...","imagePrompt":"..."}
```
- **이미지**: 동기 처리 최대 60초. `imageUrl` 없으면 Section 5에서 수동 처리
- **백그라운드** 1-3분: 자동 태깅 → 분류 → Vectorize 인덱싱

**heroCategory — 표준 10개 대분류** (정확히 이 문자열):
```
경영·사무·금융·보험직 / IT·연구직 및 공학 기술직 / 교육·법률·사회복지·경찰·소방직 및 군인
보건·의료직 / 예술·디자인·방송·스포츠직 / 미용·여행·숙박·음식·경비·청소직
영업·판매·운전·운송직 / 설치·정비·생산직 / 건설·채굴직 / 농림어업직
```

**생성 후 확인** (3분 후):
```bash
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id, name, slug, image_url FROM jobs WHERE name='{직업명}'"
```

---

## 4. 현황 분석 — 채울 필드 결정

```bash
npx wrangler d1 execute careerwiki-kr --remote --command "SELECT id, name,
  substr(json_extract(user_contributed_json,'$.summary'),1,80) as summary,
  json_extract(user_contributed_json,'$.way') IS NOT NULL as has_way,
  json_extract(user_contributed_json,'$.overviewSalary') IS NOT NULL as has_salary,
  json_extract(user_contributed_json,'$.detailWlb') IS NOT NULL as has_wlb,
  image_url IS NOT NULL as has_image FROM jobs WHERE name='{직업명}' AND is_active=1"
```

**사이드바 필드** (출처 불필요, DB 존재 확인 필수):
- `sidebarJobs`: 7~12개, 15개 초과 금지. `SELECT name FROM jobs WHERE is_active=1 AND name IN (...)`
- `sidebarMajors`: `SELECT name FROM majors WHERE is_active=1 AND name IN (...)`
- `sidebarCerts`: `[{name, url}]` — 자격증/면허만 ("~시험" 형태 금지)

**각주 지원 필드**: `way`, `overviewProspect.main`, `overviewSalary.sal`, `trivia`, `summary`, `detailWlb.wlbDetail`, `detailWlb.socialDetail`, `overviewAbilities.technKnow`

---

## 5~7. 이미지·분류·Vectorize 확인

```bash
# [5] 이미지 확인 (3분 후)
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT image_url FROM jobs WHERE name='{직업명}'"
curl -s -o /dev/null -w "%{http_code}" "{image_url}"   # 200=정상, 404/000=실패
# ⚠️ image_url이 'https://images.careerwiki.org/...' 형식이면 R2에 파일이 실제 존재하는지 검증:
npx wrangler r2 object get "careerwiki-uploads/jobs/job-{slug}.webp" --remote 2>&1
# "The specified key does not exist" 에러 → 이미지가 생성되지 않은 것 → 아래 단계로 재생성
```

### 이미지 생성 실패 시 수동 생성 워크플로우 (API 3단계)

```bash
# Step 1: 이미지 생성 요청 (세션 토큰 또는 admin secret 필요)
curl -X POST https://careerwiki.org/api/image/generate \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{"type":"jobs","slug":"{slug}"}'
# 응답: {"success":true,"taskId":"xxx","estimatedTime":10}

# Step 2: 완료 폴링 (5~30초)
curl -s "https://careerwiki.org/api/image/status/{taskId}" \
  -H "Cookie: session_token=SESSION_TOKEN"
# 응답: {"status":"completed","imageUrl":"https://..."}

# Step 3: 이미지 저장 (이미지URL을 DB에 반영)
curl -X POST https://careerwiki.org/api/image/save \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{"type":"jobs","slug":"{slug}","imageUrl":"{생성된 이미지 URL}"}'
```

> ⚠️ `/api/image/generate`는 `requireAuth` 미들웨어를 사용하므로 X-Admin-Secret 헤더가 아닌 **세션 쿠키(session_token)**가 필요하다. admin 계정으로 로그인 후 쿠키를 사용하거나, 아래 wrangler 직접 업로드 방식을 사용한다.

### 대안: wrangler로 직접 R2 업로드 + DB 갱신
```bash
# 이미지를 로컬에 다운로드한 후:
npx wrangler r2 object put careerwiki-uploads/uploads/jobs/job-{slug}.webp \
  --file ./image.webp --content-type image/webp --remote
# DB 갱신:
npx wrangler d1 execute careerwiki-kr --remote --command \
  "UPDATE jobs SET image_url='/uploads/jobs/job-{slug}.webp' WHERE name='{직업명}'"
```

> R2 경로 주의: `uploads/jobs/job-{slug}.webp` (prefix `uploads/` 포함), 공개 URL은 `/uploads/jobs/job-{slug}.webp`

# [6] 분류 확인 (3분 후) — 없으면 수동 삽입
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT large_category, medium_category, confidence FROM job_categories WHERE job_id='{JOB_ID}'"
# 수동: INSERT OR REPLACE INTO job_categories ... VALUES ('{JOB_ID}','대분류','중분류','manual',1.0,...)

# [7] Vectorize 확인 (5분 후) — 없으면 수동 재시도
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT entity_id, version FROM embedding_metadata WHERE entity_id='{JOB_ID}'"
# 실패 시: npx tsx scripts/vectorize-content.ts --job-id {JOB_ID}
```

---

## 8. 리서치 범위 + 수집 필드

**순서**: ①커리어넷/워크넷/KNOW → ②웹 검색 → ③협회/기관 → ④WebFetch로 내용 대조 검증 (필수)

| 필드 | 분량 | 주의사항 |
|------|------|---------|
| `summary` | 100-300자 | 벡터 임베딩 기준 텍스트 |
| `way` | 200-500자 | 학력→자격증→진입경로→팁. 각주 필수 |
| `overviewWork.main` | 100-300자 | 수행 직무 설명 |
| `overviewSalary.sal` | 200-300자 | 공식 형식(하위/평균/상위) 또는 서술형. 출처 필수 |
| `overviewProspect.main` | 200-400자 | "~전망됩니다" 객관적 톤. 각주 필수 |
| `trivia` | 1개 | 업계 현실/의외의 통계. 출처 필수. 인물이력/학문기원 금지 |
| `detailWlb.wlb` / `.social` | 등급 | 보통미만/보통이상/좋음/매우좋음. **페이지 상단 카드 — 반드시 포함** |
| `detailWlb.wlbDetail` | 130~200자 | 근무시간·강도·야근·교대. 임금 정보 절대 금지 |
| `detailWlb.socialDetail` | 100~160자 | 사회적 영향·공익 역할만. 근무환경·취업전망 금지 |

---

## 9. 편집 API — 데이터 보완

```
POST https://careerwiki.org/api/job/{id}/edit
X-Admin-Secret: careerwiki-admin-2026  /  Content-Type: application/json
```

```json
{
  "fields": {
    "summary": "풍부한 직업 설명",
    "way": "자격요건...[1]\n\n진입경로...[2]",
    "overviewWork.main": "수행 직무.[1]",
    "overviewSalary.sal": "하위(25%) 2,800만원, 평균(50%) 4,200만원, 상위(25%) 6,500만원.[1]",
    "overviewProspect.main": "전망.[1]",
    "trivia": "팩트 1개.[1]",
    "detailWlb": {"wlb":"보통이상","social":"좋음","wlbDetail":"근무 서술.[1]","socialDetail":"사회적 영향.[1]"},
    "detailReady": {"curriculum":["과목1"],"recruit":["경로1"],"training":["과정1"]},
    "sidebarJobs": ["관련직업1"], "sidebarMajors": ["관련전공1"],
    "sidebarCerts": [{"name":"자격증명","url":"https://..."}],
    "heroTags": ["태그1","별칭","영문명"],
    "youtubeLinks": [{"url":"https://youtube.com/watch?v=xxx","title":"영상 제목"}]
  },
  "sources": {
    "way": [{"text":"[1] 출처명","url":"https://..."},{"text":"[2] 출처명","url":"https://..."}],
    "overviewSalary.sal": [{"text":"[1] 출처명","url":"https://..."}],
    "overviewProspect.main": [{"text":"[1] 출처명","url":"https://..."}],
    "trivia": [{"text":"[1] 출처명","url":"https://..."}]
  },
  "changeSummary": "신규 직업 전체 데이터 보완: way/work/salary/prospect/wlb/detailReady"
}
```

**sources 키 오류 절대 금지**: ❌ `way_sources` → ✅ `way` / ❌ `overviewSalary_sources` → ✅ `overviewSalary.sal` / ❌ 숫자 키 `"1","2"` / ❌ sources 없이 fields만 전송

**구조화 데이터 주의**: `detailWlb`, `detailReady`, `overviewAptitude`, `detailEducation`은 점 표기법 불가 → 통째 객체로. 배열/객체는 실제 JSON 타입 (문자열화 X).

편집 성공 시 Google Indexing API 알림 자동 전송 (백그라운드).

---

## 10. 출처 내용 대조 검증 (편집 API 호출 전 필수)

모든 출처 URL → `WebFetch(url, "이 페이지에서 [수치/사실]을 원문으로 찾아줘")` → 없으면 제거/다른 출처

```
[ ] 각 [N]이 본문에 1회만 등장?  [ ] [N] 번호 1부터 순차?  [ ] 각주 마침표 뒤: 합니다.[1] ✓
[ ] sources text가 "[N] 출처명" 형식?  [ ] sources 배열 길이 = 본문 최대 [N] 번호?
[ ] URL 접속: curl -s -o /dev/null -w "%{http_code}" "출처URL"  → 200/301만 허용
```

### ⚠️ raw [N] 마커 제거 체크리스트

merged_profile_json 또는 다른 소스에서 텍스트를 복사할 때:

1. **텍스트 내 `[1]`, `[2]` 검사**: 가져온 텍스트에 `[숫자]` 패턴이 있으면 반드시 처리
   - sources에 해당 필드의 `[N]` 매핑이 있으면 → 올바른 sources 항목 추가 (`text: "[N] 출처명"`)
   - 매핑할 sources가 없으면 → 텍스트에서 `[N]` 마커 제거 (빈 sources보다 깔끔한 텍스트가 낫다)
   - **절대 금지**: sources 없이 [N]이 있는 텍스트를 그대로 저장

2. **sources 키 주의**: `_sources`에서 `overviewWork.main` (`.main` 포함) 사용. `overviewWork`만 사용하면 footnoteMap 매핑 실패로 [N]이 raw 텍스트로 노출됨
   - ✅ `sources: {"overviewWork.main": [...]}`
   - ❌ `sources: {"overviewWork": [...]}`

3. **sources 순서 = 본문 순서**: 필드 내 [1], [2], [3]이 나오는 순서대로 sources 배열 작성
   - ✅ `"way": [{"text":"[1] 출처A","url":"..."}, {"text":"[2] 출처B","url":"..."}]` → way 텍스트에서 [1] 먼저, [2] 나중에 등장
   - ❌ sources 배열을 임의 순서로 작성하면 tooltip이 잘못 표시됨

4. **전역 각주 번호는 자동 계산됨**: 각 필드의 [1], [2]는 로컬 번호. 페이지 렌더링 시 UI 스크롤 순서대로 전역 번호가 자동 부여됨. 직접 전역 번호를 지정할 필요 없음

---

## 12. 프로덕션 검증

```bash
curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep "확인할 키워드"
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT name, image_url, substr(json_extract(merged_profile_json,'$.summary'),1,80) as s,
   (SELECT large_category FROM job_categories WHERE job_id=jobs.id) as cat
   FROM jobs WHERE name='{직업명}'"
# 각주 순서 QA
slug={slug}; nums=$(curl -s "https://careerwiki.org/job/$slug?nocache=1" | \
  grep -o 'data-source-id="[0-9]*"' | sed 's/data-source-id="//;s/"//' | tr '\n' ',')
echo "$slug: $(echo "$nums" | tr ',' '\n' | grep -c '[0-9]')개 각주"
```

```
□ 직업명 타이틀 / □ 썸네일 이미지 / □ summary / □ way 과정 탭
□ salary / □ prospect / □ trivia 여담 1개 / □ 각주 superscript + hover tooltip
□ 대분류/중분류 / □ 관련 직업 링크 / □ full-quality-audit.cjs PASS:
  node scripts/full-quality-audit.cjs --slug={slug}
```

---

## 15. equalize 스킬과의 차이점

| 항목 | job-data-create | job-data-equalize |
|------|-----------------|-------------------|
| 전제 | DB에 직업 없음 | DB에 직업 존재 |
| Phase 1 | 실존 검증 + slug 확인 필수 | 없음 |
| Phase 2 | 스텁 생성 (POST /api/job/create) | 없음 |
| 리서치·이미지·분류·Vectorize | 처음부터 / 자동 처리 결과 검증 | 빈 필드만 / 보통 이미 있음 |

---

## 16. 잠재적 위험 및 주의사항

1. **slug 충돌**: `check-name` API + SQL LIKE 검색으로 반드시 확인
2. **이미지 생성 실패**: `imageUrl` 없으면 Section 5에서 수동 처리
3. **분류/Vectorize 지연**: 백그라운드 처리 → 각각 3분/5분 후 확인
4. **sources 누락**: fields + sources 항상 함께 전송 (가장 빈번한 치명적 실수)
5. **공식 출처 없는 신생 직업**: 뉴스/채용공고 근거 없으면 추가 자체를 재검토
6. **sidebarJobs 미존재 직업**: DB 존재 확인 없이 추가하면 broken link
7. **summary 부실**: 짧거나 마케팅 문구이면 Vectorize 추천 품질 저하

---

## 참조 파일

- **단일 직업 리서치 에이전트 프롬프트 + 대량 생성 패턴** → `references/research-agent-prompt.md`
- **출처 소스 키 매핑** → `../shared/source-key-mapping.md` *(다른 태스크에서 생성 예정)*
- **각주 검증 함수** → `../shared/footnote-validation.md` *(다른 태스크에서 생성 예정)*
- **커리어트리 인물 기준** → `../shared/career-tree.md` *(다른 태스크에서 생성 예정)*
