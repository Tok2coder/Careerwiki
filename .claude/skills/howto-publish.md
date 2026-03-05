# HowTo 가이드 발행 스킬

유저가 "HowTo 발행"이라고 말하면 이 스킬을 실행한다.
CareerWiki HowTo 가이드를 기획 → 작성 → 이미지 생성 → 발행 → 검증하는 전체 워크플로우.
---

## 0. 주제 선정 기준

### 기본 원칙
- 기존 발행 글과 겹치지 않는 실용적인 진로/취업 관련 주제
- **시의성 우선**: 최근 핫한 이슈·정책 변화와 연결된 주제를 우선 선택한다

### 주제 발굴 방법
1. **최신 이슈 기반**: 웹 검색으로 최근 진로/취업/교육 관련 뉴스를 확인한다
   - 예: 의대 증원 발표 → 의사가 되는 과정 중 특정 스텝(의사국시, 레지던트 지원 등)을 주제로
   - 예: AI 붐 → 비전공자 AI 직무 전환 방법
   - 예: 공무원 채용 변화 → 특정 공무원 시험 과목별 공부법
2. **직업 상세 페이지 → 세부 스텝 딥다이브**: careerwiki.org의 직업 상세 페이지에는 "되는 법"이 개괄적으로 있다. 그 안의 수많은 스텝 중 **하나를 골라** 구체적 팁·공부법·노하우를 다룬다
   - 의사 → 의사국시 공부법, USMLE 준비법, 레지던트 매칭 전략 등
   - 변호사 → 변호사시험 과목별 전략, 로스쿨 면접 준비 등
   - 약사 → 약사국시 과목별 공부법, 약대 편입 준비 등
3. **다양한 카테고리 로테이션**: 연속으로 같은 분야(예: 시험 가이드만 3개 연속)를 발행하지 않는다

### 주제 선정 프로세스
```
[1] 기존 발행글 목록 확인 (겹침 방지)
[2] 웹 검색: "최근 진로 취업 교육 이슈 2026" 등으로 트렌드 파악
[3] 이슈와 연결된 구체적 세부 주제 도출
[4] 주제 확정 후 리서치 시작
```

### 제목 작성 규칙
- **자유 형식**: 매번 다른 톤과 구조의 제목을 사용한다
- **금지**: 매번 "OO 합격 가이드: OO" 같은 동일 패턴 반복
- 제목 예시 (다양하게):
  - "의사국시, 이렇게 공부하면 된다"
  - "비전공자의 데이터 분석가 전환 로드맵"
  - "로스쿨 면접 완전 정복 A to Z"
  - "소방공무원 체력시험, 3개월 컷 넘는 훈련법"
  - "공인중개사 시험 독학 가이드: 회차별 난이도와 전략"
  - "웹 개발자 포트폴리오, 이것만은 꼭 넣어라"
  - "간호사에서 전문간호사로: 자격 취득부터 연봉까지"

---

## 1. 전체 작업 순서

```
[1] 주제 선정 (위 기준 참조) & 리서치
[2] Tiptap JSON 콘텐츠 작성
[3] 썸네일 이미지 생성 (evolink API)
[4] 인라인 이미지 생성 (필수, 1~2개)
[5] 관련 직업/전공 매핑
[6] publish-direct API 호출
[7] 배포 후 검증
```

---

## 2. 콘텐츠 작성 기준

### 대상 독자
- 한국 고등학생~대학생 (진로 탐색 중)

### 톤 & 문체
- **~하다/있다** 체 (비격식 서술체)
- 교과서적 나열 X → 실질적 도움이 되는 정보
- 통계/수치는 반드시 출처(footnote) 명시

### 구조 가이드
```
H2: 대제목 (3~5개)
  H3: 소제목 (필요시)
  paragraph: 본문
  table: 데이터 (점수표, 일정 등)
  bulletList/orderedList: 나열
  checkpointBox: 핵심 규칙/주의사항
  conclusionBox: 섹션 요약/핵심 정리
  qnaBlock: 자주 묻는 질문
  footnote: 출처 (본문 중 인라인)
```

### 분량
- 최소 800자, 최대 3000자
- H2 기준 3~5개 섹션

---

## 3. Tiptap JSON 포맷 (필수 참조)

### 문서 루트
```json
{
  "type": "doc",
  "content": [ /* 노드 배열 */ ]
}
```

### 기본 노드
```json
// 제목 (level 2~3만 사용, H1은 페이지 타이틀이므로 쓰지 않음)
{ "type": "heading", "attrs": { "level": 2 }, "content": [{ "type": "text", "text": "제목" }] }

// 문단
{ "type": "paragraph", "content": [{ "type": "text", "text": "본문 내용" }] }

// 볼드
{ "type": "text", "text": "강조", "marks": [{ "type": "bold" }] }

// 내부 링크 (문장 안에서만 사용)
{ "type": "text", "text": "경찰관", "marks": [{ "type": "link", "attrs": { "href": "/job/경찰관" } }] }

// 글머리 목록
{ "type": "bulletList", "content": [
  { "type": "listItem", "content": [
    { "type": "paragraph", "content": [{ "type": "text", "text": "항목" }] }
  ] }
] }

// 번호 목록
{ "type": "orderedList", "content": [
  { "type": "listItem", "content": [
    { "type": "paragraph", "content": [{ "type": "text", "text": "항목" }] }
  ] }
] }

// 테이블
{ "type": "table", "content": [
  { "type": "tableRow", "content": [
    { "type": "tableHeader", "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "헤더" }] }] },
    { "type": "tableHeader", "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "헤더" }] }] }
  ] },
  { "type": "tableRow", "content": [
    { "type": "tableCell", "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "셀" }] }] },
    { "type": "tableCell", "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "셀" }] }] }
  ] }
] }

// 구분선
{ "type": "horizontalRule" }
```

### 커스텀 노드

```json
// 체크포인트 박스 (핵심 규칙/주의사항) — ✓ 아이콘
{ "type": "checkpointBox", "content": [
  { "type": "heading", "attrs": { "level": 3 }, "content": [{ "type": "text", "text": "핵심 규칙" }] },
  { "type": "bulletList", "content": [
    { "type": "listItem", "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "내용" }] }] }
  ] }
] }

// 결론 박스 (섹션 요약) — 💡 아이콘
{ "type": "conclusionBox", "content": [
  { "type": "heading", "attrs": { "level": 3 }, "content": [{ "type": "text", "text": "핵심 정리" }] },
  { "type": "bulletList", "content": [
    { "type": "listItem", "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "내용" }] }] }
  ] }
] }

// QnA 블록 (자주 묻는 질문)
{ "type": "qnaBlock", "content": [
  { "type": "qnaQuestion", "content": [
    { "type": "paragraph", "content": [{ "type": "text", "text": "질문 내용?" }] }
  ] },
  { "type": "qnaAnswer", "content": [
    { "type": "paragraph", "content": [{ "type": "text", "text": "답변 내용." }] }
  ] }
] }

// 각주 (출처) — 반드시 NODE 타입, mark가 아님!
{ "type": "footnote", "attrs": {
  "id": 1,
  "text": "경찰청, 2025 경찰공무원 체력시험 기준표",
  "url": "https://example.com/source"
} }

// 이미지
{ "type": "image", "attrs": {
  "src": "https://files.evolink.ai/...",
  "alt": "설명 텍스트",
  "width": 720,
  "align": "center"
} }
```

### 각주 사용 예시 (문단 안에 인라인 배치)
```json
{ "type": "paragraph", "content": [
  { "type": "text", "text": "2025년 기준 경찰 체력시험 합격률은 78.3%이다" },
  { "type": "footnote", "attrs": { "id": 1, "text": "경찰청 통계연보 2025", "url": "https://..." } },
  { "type": "text", "text": "." }
] }
```

---

## 4. 절대 하지 말아야 할 것 (자주 하는 실수)

### 실수 1: 이미지 생성 시 직업/전공 slug 사용
```
# 절대 금지! 기존 직업 페이지 썸네일을 덮어씀
POST /api/image/generate
{ "type": "jobs", "slug": "경찰관" }  ← 경찰관 페이지 썸네일 덮어씀!

# 올바른 방법: HowTo 전용 slug 또는 promptOverride만 사용
POST /api/image/generate
{ "type": "jobs", "slug": "howto-경찰체력시험-thumb", "promptOverride": "..." }
```
**원리**: evolink API의 /api/image/save는 `type+slug` 조합으로 R2 키를 생성 → `jobs/job-경찰관.webp` 같은 키로 기존 이미지를 삭제하고 덮어씀. 한번 덮어쓰면 복구 불가.

### 실수 2: 각주를 mark 타입으로 작성
```json
// 틀림 — extractFootnotes()가 인식 못함
{ "type": "text", "text": "[1]", "marks": [{ "type": "footnote", "attrs": {...} }] }

// 맞음 — NODE 타입이어야 함
{ "type": "footnote", "attrs": { "id": 1, "text": "출처명", "url": "..." } }
```

### 실수 3: careerList 블록 사용
```json
// 하지 마세요 — 관련 직업은 사이드바에 자동 표시됨
{ "type": "careerList", "content": [...] }

// 대신: 본문 문장 안에 자연스럽게 링크
{ "type": "text", "text": "경찰관", "marks": [{ "type": "link", "attrs": { "href": "/job/경찰관" } }] }
```

### 실수 4: relatedJobs에 name 필드 누락
```json
// 틀림 — 사이드바에서 빈칸으로 표시
{ "slug": "경찰관" }

// 맞음
{ "slug": "경찰관", "name": "경찰관" }
```

### 실수 5: H1 사용
H1은 페이지 타이틀(title 필드)이 자동 렌더링하므로 콘텐츠 내에서 H1 사용 금지. H2부터 시작.

### 실수 6: 수동 출처 섹션 작성
```json
// 하지 마세요 — "출처" 섹션이 중복됨
{ "type": "heading", "attrs": { "level": 2 }, "content": [{ "type": "text", "text": "출처" }] }
{ "type": "orderedList", "content": [...] }

// 맞음: footnote 노드만 본문에 배치하면 extractFootnotes()가 자동으로 "출처" 섹션 생성
```

### 실수 7: deploy 시 UTF-8 커밋 메시지 에러
```bash
# wrangler pages deploy가 한글 커밋 메시지에서 UTF-8 에러 발생 가능
npm run deploy  # ← 실패할 수 있음

# 해결: 영문 커밋 메시지 명시
npx wrangler pages deploy dist --project-name careerwiki --commit-message "feat: add howto guide"
```

### 실수 8: publish-direct 후 편집 모드에서 빈 콘텐츠/썸네일

**증상**: publish-direct로 발행 또는 업데이트한 글에서 "편집" 클릭 → 에디터가 빈 상태로 열림

**원인**: 편집 버튼 클릭 시 `howto_drafts` 테이블에 draft를 생성하는데,
publish-direct로 페이지를 업데이트해도 기존 draft는 갱신되지 않았음.
→ 다음에 편집 클릭하면 **구버전 draft**(빈 콘텐츠/빈 썸네일)로 리다이렉트.

**해결 (코드에 이미 반영됨)**:
1. `publish-direct`에서 `updatePageId`로 페이지 업데이트 시, 연결된 기존 draft 자동 삭제
2. `/:slug/edit` 라우트에서 기존 draft가 원본 페이지보다 오래되면 → 최신 데이터로 draft 동기화

**관련 코드**:
- `src/routes/howto-editor.ts`: publish-direct 후 stale draft 삭제
- `src/routes/howto.ts`: edit 라우트에서 draft vs page 타임스탬프 비교 후 동기화

### 실수 9: 각주 ID 순서가 등장 순서와 불일치

**증상**: 본문에서 각주가 [4], [1], [5], [3], [2] 같이 뒤죽박죽 순서로 표시됨

**원인**: 콘텐츠 작성 시 각주의 `id` 값을 출처 목록 순서로 미리 붙여놓고, 본문 안에 배치할 때 등장 순서를 고려하지 않음

**올바른 방법**: 각주 id는 반드시 **본문 위에서부터 아래로 등장하는 순서대로** 1, 2, 3, 4, 5 부여.
- 먼저 본문의 어느 위치에 어떤 출처를 넣을지 결정한다
- 위에서부터 순서대로 id=1, id=2, ... 를 부여한다

**작성 후 검증 방법**:
```javascript
// Tiptap JSON에서 footnote 등장 순서 확인
let counter = 0;
function check(node) {
  if (node.type === 'footnote') {
    counter++;
    if (node.attrs.id !== counter) console.error('순서 불일치!', node.attrs.id, '→ should be', counter);
  }
  if (node.content) node.content.forEach(check);
}
check(doc);
```

---

## 5. 썸네일 & 인라인 이미지 생성

### 5-1. 썸네일 생성

```bash
# Step 1: 이미지 생성 요청 (HowTo 전용 slug 사용!)
curl -X POST https://careerwiki.org/api/image/generate \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{
    "type": "jobs",
    "slug": "howto-TOPIC-thumb",
    "promptOverride": "[아래 스타일 풀에서 랜덤 선택] + [주제 설명]"
  }'
# → { "taskId": "task-unified-...", "estimatedTime": 32 }

# Step 2: 30~40초 대기 후 상태 확인
curl https://careerwiki.org/api/image/status/TASK_ID \
  -H "Cookie: session_token=SESSION_TOKEN"
# → { "status": "completed", "imageUrl": "https://files.evolink.ai/..." }
```

**중요 — R2 저장 필수!**: evolink URL은 4~5일 후 만료된다. 반드시 `/api/image/save`를 호출하여 R2에 영구 저장해야 한다.

```bash
# Step 3: R2에 영구 저장 (필수!)
curl -X POST https://careerwiki.org/api/image/save \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{
    "taskId": "TASK_ID",
    "type": "jobs",
    "slug": "HowTo-TOPIC",
    "imageUrl": "https://files.evolink.ai/.../image.webp"
  }'
# → { "imageUrl": "/uploads/jobs/job-HowTo-TOPIC.webp?v=..." }
# 이 /uploads/... 경로를 thumbnailUrl로 사용한다
```

publish body의 `thumbnailUrl`에는 R2 경로(`/uploads/jobs/job-HowTo-TOPIC.webp`)를 넣거나, 발행 후 DB를 `json_set(meta_data, '$.thumbnailUrl', R2경로)`로 업데이트한다.

### 5-1b. 이미지 스타일 풀 (매번 다른 스타일 사용!)

**규칙**: 매 HowTo마다 이전 글과 다른 스타일을 선택한다. 기존 발행글의 썸네일 스타일과 겹치지 않게 로테이션.

| # | 스타일명 | promptOverride 템플릿 | 분위기 |
|---|---------|----------------------|--------|
| 1 | **Isometric 3D** | `Isometric 3D illustration of [주제], vibrant colors, soft shadows, white background, game-like aesthetic` | 귀엽고 입체적 |
| 2 | **Flat Vector** | `Minimal flat vector illustration of [주제], bold geometric shapes, limited color palette of 4 colors, no outlines` | 깔끔 모던 |
| 3 | **Watercolor** | `Watercolor painting style illustration of [주제], soft pastel tones, artistic brush strokes, dreamy atmosphere` | 감성적 |
| 4 | **Retro Pop** | `Retro pop art style illustration of [주제], halftone dots, bold primary colors, comic book aesthetic, vintage feel` | 복고 에너지 |
| 5 | **Neon Gradient** | `Futuristic neon gradient illustration of [주제], dark background, glowing edges, cyberpunk-inspired, purple and teal tones` | 미래지향 |
| 6 | **Line Art** | `Elegant line art illustration of [주제], single continuous line style, minimal detail, white background, gold accent color` | 세련 미니멀 |
| 7 | **Paper Cut** | `Paper cut layered illustration of [주제], depth effect with shadows between layers, craft-like texture, warm colors` | 공예 느낌 |
| 8 | **Pixel Art** | `Pixel art illustration of [주제], 16-bit retro game style, bright colors, nostalgic, clean pixel grid` | 레트로 게임 |

**사용 예시**: 기존에 1(Isometric)과 2(Flat Vector)를 썼으면, 다음 글은 3~8 중에서 선택.

**주제와 스타일 매칭 가이드**:
- 체력/스포츠 주제 → Retro Pop, Isometric 3D
- 시험/공부 주제 → Flat Vector, Line Art
- 기술/IT 주제 → Neon Gradient, Pixel Art
- 예술/감성 주제 → Watercolor, Paper Cut

### 5-2. 인라인 이미지 생성 (필수)

모든 HowTo 가이드에는 본문 중간에 인포그래픽/상황 이미지를 **1~2개 필수**로 포함한다.
텍스트만 있는 글은 가독성이 떨어지고 시각적 흥미가 부족하다.

#### 프롬프트 작성 가이드

**기본 프롬프트** (간단한 아이콘/인포그래픽):
```
An infographic showing [내용], clean vector style, white background
```

**고화질 프롬프트** (매 2~3개 글 중 최소 1개는 이 수준으로 작성):
장면 묘사, 조명, 구도, 분위기를 구체적으로 지정하면 훨씬 퀄리티 높은 이미지가 나온다.

```
예시 1 (시험 공부 장면):
A focused Korean university student studying late at night in a cozy study cafe,
warm desk lamp casting golden light on open textbooks and handwritten notes,
a laptop showing practice exam questions, coffee cup beside the desk,
photorealistic style, shallow depth of field, cinematic lighting,
warm amber and cool blue tones, 4K detail

예시 2 (체력 훈련 장면):
Dynamic action shot of a young Korean athlete sprinting on a red track field,
early morning golden hour sunlight, motion blur on legs suggesting speed,
Olympic-quality stadium in background, determined facial expression,
professional sports photography style, high contrast, vivid colors

예시 3 (직업 현장):
A modern hospital emergency room scene with medical professionals in action,
soft fluorescent lighting, medical equipment and monitors in background,
a young Korean doctor reviewing patient charts on a tablet,
documentary photography style, natural colors, authentic atmosphere

예시 4 (기술/IT):
Aerial view of a developer's dual-monitor workspace with code editor open,
dark theme IDE showing colorful syntax-highlighted code,
mechanical keyboard, succulent plant, and coffee mug on a clean minimal desk,
tech aesthetic, cool blue and purple ambient lighting, ultra-detailed
```

**프롬프트 품질 규칙**:
- 3개 글 연속으로 단순 프롬프트만 쓰지 않는다
- 핵심 이미지(글의 메인 비주얼)는 고화질 프롬프트 권장
- 보조 이미지(표 아래 아이콘 등)는 간단 프롬프트 OK
- 한국인/한국 배경을 포함하면 독자 친근감 상승

```bash
# evolink API로 생성 (slug을 howto 전용으로!)
curl -X POST https://careerwiki.org/api/image/generate \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{
    "type": "jobs",
    "slug": "howto-TOPIC-img1",
    "promptOverride": "여기에 상세 프롬프트 작성"
  }'
```

인라인 이미지도 `/api/image/save`로 R2에 저장한 후, R2 경로를 사용한다:
```json
{ "type": "image", "attrs": {
  "src": "/uploads/jobs/job-howto-TOPIC-img1.webp",
  "alt": "이미지 설명",
  "width": 720,
  "align": "center"
} }
```

**배치 위치**: 테이블 바로 다음, 또는 섹션 전환부에 자연스럽게.

---

## 6. 발행 API 호출

### publish-direct 엔드포인트

```bash
POST https://careerwiki.org/api/howto/publish-direct
Content-Type: application/json
Cookie: session_token=SESSION_TOKEN
```

### 요청 Body

```json
{
  "title": "가이드 제목",
  "summary": "1~2문장 요약",
  "contentJson": "{\"type\":\"doc\",\"content\":[...]}",
  "tags": ["태그1", "태그2"],
  "relatedJobs": [
    { "slug": "경찰관", "name": "경찰관" },
    { "slug": "소방관", "name": "소방관" }
  ],
  "relatedMajors": [
    { "slug": "경찰행정학과", "name": "경찰행정학과" }
  ],
  "thumbnailUrl": "https://files.evolink.ai/.../image.webp"
}
```

### 기존 페이지 업데이트 시

```json
{
  "updatePageId": 3859,
  "title": "수정된 제목",
  "contentJson": "...",
  ...나머지 동일
}
```

### 응답

```json
{
  "success": true,
  "slug": "가이드-제목-slug",
  "pageId": 3859,
  "status": "published"
}
```

---

## 7. 발행 후 검증 체크리스트

발행 후 반드시 확인할 항목:

```
[ ] 페이지 접근 가능: https://careerwiki.org/howto/{slug}
[ ] 썸네일 이미지 표시됨
[ ] H2/H3 제목이 올바르게 렌더링
[ ] 사이드바에 관련 직업/전공 이름이 표시됨 (빈칸 아님)
[ ] 각주 번호가 본문에 [1], [2] 등으로 표시됨
[ ] 각주가 위에서부터 1→2→3→4→5 순서로 등장함 (뒤죽박죽 아님!)
[ ] 페이지 하단 "출처" 접이식 섹션에 각주 목록이 있음
[ ] 인라인 이미지가 1~2개 적절한 위치에 표시됨 (필수!)
[ ] QnA 블록의 Q/A 아이콘이 텍스트와 정렬됨
[ ] checkpointBox/conclusionBox 아이콘이 첫 줄 왼쪽에 위치
[ ] 내부 링크(/job/xxx, /major/xxx)가 작동함
[ ] 기존 직업/전공 페이지 썸네일이 변경되지 않았음 ← 중요!
[ ] 편집 버튼 클릭 시 에디터에 콘텐츠가 로드됨 (빈 상태 아님)
[ ] 편집 모드에서 썸네일 미리보기가 표시됨
```

### 기술 검증 curl 명령어
```bash
# 이미지 존재 확인
curl -s "https://careerwiki.org/howto/SLUG?nocache=1" | grep -c "task-raphael"

# 각주 확인
curl -s "https://careerwiki.org/howto/SLUG?nocache=1" | grep -c "footnote-ref"

# 관련 직업 사이드바 확인
curl -s "https://careerwiki.org/howto/SLUG?nocache=1" | grep "next-action-item\|sidebar-related"

# 편집 모드 검증 (draft 생성 → 콘텐츠 확인)
# 1) edit 리다이렉트 확인
curl -s "https://careerwiki.org/howto/SLUG/edit" -H "Cookie: session_token=TOKEN" -o /dev/null -w "%{redirect_url}"
# → /howto/draft/N 으로 리다이렉트되어야 함

# 2) draft에 썸네일 존재 확인
curl -s "https://careerwiki.org/howto/draft/N" -H "Cookie: session_token=TOKEN" | grep -oE 'field-thumbnail.*value="[^"]*"'
# → value="https://..." (빈 값이면 안됨)

# 3) draft에 콘텐츠 크기 확인
curl -s "https://careerwiki.org/howto/draft/N" -H "Cookie: session_token=TOKEN" | grep -oE "CONTENT_JSON_RAW = [^;]+" | wc -c
# → 최소 수천 바이트 이상이어야 함
```

### 내용 검증 (근거 기반 팩트체크)

기술 검증 후 반드시 **콘텐츠 내용의 정확성**을 검증한다.

**방법**: 발행된 페이지 본문을 가져온 뒤, 리서치 단계에서 수집한 출처 정보와 대조한다.

```bash
# 발행된 페이지의 실제 텍스트 추출
curl -s "https://careerwiki.org/howto/SLUG?nocache=1" | \
  sed -n '/<article/,/<\/article>/p' | \
  sed 's/<[^>]*>//g' | sed '/^$/d' | head -100
```

**검증 체크리스트**:
```
[ ] 수치/통계가 출처와 일치하는가? (합격률, 점수, 비율 등)
[ ] 기관명/기업명이 정확한가? (오타, 잘못된 명칭 없는가)
[ ] 연도가 최신인가? (2024~2026년 기준 정보인가)
[ ] 각주 URL이 실제로 존재하고 접근 가능한가?
[ ] 추천 사항이 현실적인가? (비현실적 기간, 불가능한 조건 없는가)
[ ] 법적/제도적 정보가 현행 기준과 맞는가? (변경된 규정 반영 여부)
```

**검증 프로세스**:
1. 본문에서 수치/통계가 포함된 문장을 추출한다.
2. 해당 수치의 출처(footnote URL)를 WebFetch로 확인한다.
3. 출처 페이지와 본문 수치가 일치하는지 대조한다.
4. 불일치 발견 시 → 본문을 수정하고 updatePageId로 재발행한다.
5. 각주 URL 5개 중 최소 2개는 직접 접근하여 유효성 확인한다.

**검증 결과 보고 포맷**:
```
## 내용 검증 결과
| 항목 | 본문 내용 | 출처 확인 | 결과 |
|------|----------|----------|------|
| [수치1] | 본문에 쓴 값 | 출처에서 확인한 값 | ✅/❌ |
| [수치2] | ... | ... | ... |
| 각주 URL 유효성 | 5개 중 N개 확인 | 접근 가능 여부 | ✅/❌ |
```

---

## 8. 전체 워크플로우 예시 (처음부터 끝까지)

```
1. 주제 결정
   → "경찰 체력시험 합격 가이드"

2. 리서치
   → 웹 검색으로 최신 기준표, 합격률, 훈련 방법 수집
   → 출처 URL 5개 이상 확보

3. Tiptap JSON 작성
   → ~하다/있다 체
   → H2 x 3~5개 섹션
   → footnote NODE 타입으로 출처 삽입
   → checkpointBox/conclusionBox 적절히 배치
   → careerList 사용 금지, 내부 링크는 문장 안에서만

4. 썸네일 생성
   → POST /api/image/generate (slug: "howto-경찰체력시험-thumb")
   → 30초 대기 → status 확인 → evolink URL 획득

5. 인라인 이미지 (필수, 1~2개)
   → POST /api/image/generate (slug: "howto-경찰체력시험-img1")
   → /api/image/save로 R2에 영구 저장
   → Tiptap JSON에 image 노드 삽입 (R2 경로 사용)

6. 관련 직업/전공 매핑
   → relatedJobs: [{ slug, name }] — name 필드 필수!
   → relatedMajors: [{ slug, name }]

7. 발행
   → POST /api/howto/publish-direct
   → contentJson은 JSON.stringify() 된 문자열

8. 검증
   → 페이지 접근, 사이드바, 각주, 이미지 모두 확인
   → 다른 직업 페이지 썸네일 영향 없는지 확인

9. CSS 변경 있었으면
   → npx tsc --noEmit
   → npm run build
   → npx wrangler pages deploy dist --project-name careerwiki --commit-message "영문 메시지"
```

---

## 9. 관련 파일 경로

| 용도 | 파일 경로 |
|------|----------|
| 발행 API & HTML 변환 | `src/routes/howto-editor.ts` |
| 이미지 생성 서비스 | `src/services/imageGenerationService.ts` |
| 이미지 저장 API | `src/routes/upload.ts` |
| 사이드바 변환 | `src/utils/howtoConverter.ts` |
| 페이지 렌더링 | `src/templates/howtoDetail.ts` |
| 콘텐츠 CSS | `public/static/howto-content.css` |
| 에디터 CSS | `public/static/howto-editor.css` |
| 커스텀 노드 정의 | `src/editor/extensions/custom-nodes/` |
| Draft 서비스 | `src/services/draftService.ts` |
| 편집 라우트 (draft 생성) | `src/routes/howto.ts` (/:slug/edit) |

---

## 10. 세션 토큰 사용법

모든 API 호출에 인증 필요:
```
Cookie: session_token=SESSION_TOKEN
```
토큰은 유저에게 확인하거나, 기존 세션에서 재사용.
