# 자주 하는 실수 10가지

## 실수 1: 이미지 생성 시 직업/전공 slug 사용

```bash
# 절대 금지! 기존 직업 페이지 썸네일을 덮어씀
POST /api/image/generate
{ "type": "jobs", "slug": "경찰관" }  ← 경찰관 페이지 썸네일 덮어씀!

# 올바른 방법: HowTo 전용 slug 사용
POST /api/image/generate
{ "type": "jobs", "slug": "howto-경찰체력시험-thumb", "promptOverride": "..." }
```

**원리**: evolink API의 `/api/image/save`는 `type+slug` 조합으로 R2 키를 생성.
`jobs/job-경찰관.webp` 키로 기존 이미지를 삭제하고 덮어씀. **한번 덮어쓰면 복구 불가.**

---

## 실수 2: 각주를 mark 타입으로 작성

```json
// 틀림 — extractFootnotes()가 인식 못함
{ "type": "text", "text": "[1]", "marks": [{ "type": "footnote", "attrs": {...} }] }

// 맞음 — NODE 타입이어야 함
{ "type": "footnote", "attrs": { "id": 1, "text": "출처명", "url": "..." } }
```

---

## 실수 3: careerList 블록 사용

```json
// 하지 마세요 — 관련 직업은 사이드바에 자동 표시됨
{ "type": "careerList", "content": [...] }

// 대신: 본문 문장 안에 자연스럽게 링크
{ "type": "text", "text": "경찰관", "marks": [{ "type": "link", "attrs": { "href": "/job/경찰관" } }] }
```

---

## 실수 4: relatedJobs에 name 필드 누락

```json
// 틀림 — 사이드바에서 빈칸으로 표시
{ "slug": "경찰관" }

// 맞음
{ "slug": "경찰관", "name": "경찰관" }
```

---

## 실수 5: H1 사용

H1은 페이지 타이틀(`title` 필드)이 자동 렌더링하므로 콘텐츠 내에서 H1 사용 금지. **H2부터 시작.**

---

## 실수 6: 수동 출처 섹션 작성

```json
// 하지 마세요 — "출처" 섹션이 중복됨
{ "type": "heading", "attrs": { "level": 2 }, "content": [{ "type": "text", "text": "출처" }] }
{ "type": "orderedList", "content": [...] }

// 맞음: footnote 노드만 본문에 배치하면 extractFootnotes()가 자동으로 "출처" 섹션 생성
```

---

## 실수 7: deploy 시 UTF-8 커밋 메시지 에러

```bash
# wrangler pages deploy가 한글 커밋 메시지에서 UTF-8 에러 발생 가능
npm run deploy  # ← 실패할 수 있음

# 해결: 영문 커밋 메시지 명시
npx wrangler pages deploy dist --project-name careerwiki --commit-message "feat: add howto guide"
```

---

## 실수 8: publish-direct 후 편집 모드에서 빈 콘텐츠/썸네일

**증상**: publish-direct로 발행/업데이트한 글에서 "편집" 클릭 → 에디터가 빈 상태로 열림

**원인**: 편집 버튼 클릭 시 `howto_drafts` 테이블에 draft를 생성하는데,
publish-direct로 페이지를 업데이트해도 기존 draft는 갱신되지 않았음.
→ 다음 편집 클릭 시 **구버전 draft**(빈 콘텐츠/빈 썸네일)로 리다이렉트.

**해결 (코드에 이미 반영됨)**:
1. `publish-direct`에서 `updatePageId`로 페이지 업데이트 시, 연결된 기존 draft 자동 삭제
2. `/:slug/edit` 라우트에서 기존 draft가 원본 페이지보다 오래되면 → 최신 데이터로 draft 동기화

**관련 코드**:
- `src/routes/howto-editor.ts`: publish-direct 후 stale draft 삭제
- `src/routes/howto.ts`: edit 라우트에서 draft vs page 타임스탬프 비교 후 동기화

---

## 실수 9: 각주 ID 순서가 등장 순서와 불일치

**증상**: 본문에서 각주가 [4], [1], [5], [3], [2] 같이 뒤죽박죽 순서로 표시됨

**원인**: 콘텐츠 작성 시 각주 `id` 값을 출처 목록 순서로 미리 붙여놓고, 본문 배치 시 등장 순서를 고려하지 않음

**올바른 방법**: 각주 id는 반드시 **본문 위에서부터 아래로 등장하는 순서대로** 1, 2, 3, 4, 5 부여.
1. 먼저 본문의 어느 위치에 어떤 출처를 넣을지 결정한다
2. 위에서부터 순서대로 id=1, id=2, ... 를 부여한다

**작성 후 검증**:
```javascript
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

## 실수 10: checkpointBox / conclusionBox를 여러 개 사용

```json
// 틀림 — 한 글에 checkpointBox 3개
{ "type": "checkpointBox", ... }  // 첫 번째
...
{ "type": "checkpointBox", ... }  // 두 번째 ← 금지!
...
{ "type": "checkpointBox", ... }  // 세 번째 ← 금지!

// 맞음 — 한 글에 checkpointBox 딱 1개, conclusionBox 딱 1개
```

**규칙**: `checkpointBox`와 `conclusionBox`는 **각각 글 전체에서 딱 1개씩만** 사용.
- checkpointBox: 글의 가장 핵심적인 규칙/주의사항 1곳에만 배치
- conclusionBox: 글 마지막 요약/정리에 1곳에만 배치
- 중간 섹션 주의사항 강조 시 → **볼드 텍스트 + bulletList** 또는 **H3 + bulletList**로 대체
