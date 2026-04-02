# Tiptap JSON 포맷 스펙

## 문서 루트
```json
{
  "type": "doc",
  "content": [ /* 노드 배열 */ ]
}
```

## 기본 노드

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

## 커스텀 노드

```json
// 체크포인트 박스 (핵심 규칙/주의사항) — ✓ 아이콘
// ⚠️ 글 전체에서 딱 1개만 사용!
{ "type": "checkpointBox", "content": [
  { "type": "heading", "attrs": { "level": 3 }, "content": [{ "type": "text", "text": "핵심 규칙" }] },
  { "type": "bulletList", "content": [
    { "type": "listItem", "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "내용" }] }] }
  ] }
] }

// 결론 박스 (섹션 요약) — 💡 아이콘
// ⚠️ 글 전체에서 딱 1개만 사용!
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
  "src": "/uploads/jobs/job-howto-TOPIC-img1.webp",
  "alt": "설명 텍스트",
  "width": 720,
  "align": "center"
} }
```

## 각주 사용 예시 (문단 안에 인라인 배치)

```json
{ "type": "paragraph", "content": [
  { "type": "text", "text": "2025년 기준 경찰 체력시험 합격률은 78.3%이다" },
  { "type": "footnote", "attrs": { "id": 1, "text": "경찰청 통계연보 2025", "url": "https://..." } },
  { "type": "text", "text": "." }
] }
```

## 각주 순서 규칙

각주 id는 반드시 **본문 위에서부터 아래로 등장하는 순서대로** 1, 2, 3, 4, 5 부여.

검증 방법:
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

## 핵심 제약

| 규칙 | 내용 |
|------|------|
| H1 사용 금지 | 페이지 타이틀이 자동 렌더링됨. H2부터 시작 |
| footnote 타입 | NODE 타입만 유효. mark 타입으로 쓰면 extractFootnotes()가 인식 못함 |
| careerList 금지 | 관련 직업은 사이드바 자동 표시. 문장 안 link로 대체 |
| 출처 섹션 수동 작성 금지 | footnote 노드만 배치하면 자동으로 "출처" 섹션 생성 |
| checkpointBox | 글 전체에서 딱 1개만 |
| conclusionBox | 글 전체에서 딱 1개만 |
| relatedJobs name 필수 | `{ "slug": "경찰관", "name": "경찰관" }` — name 빠지면 사이드바 빈칸 |
