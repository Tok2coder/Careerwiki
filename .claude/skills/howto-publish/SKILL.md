---
name: howto-publish
description: >
  CareerWiki HowTo 가이드를 기획·작성·이미지 생성·발행·검증하는 전체 워크플로우.
  "HowTo 발행", "HowTo 써줘", "가이드 작성", "howto 작성해줘", "HowTo 가이드 만들어줘",
  "가이드 발행", "howto 발행", "진로 가이드 써줘" 키워드에 반드시 트리거.
  사용자가 HowTo 관련 콘텐츠 작업을 요청하면 무조건 이 스킬을 실행하라.
---

유저가 "HowTo 발행" 또는 유사 키워드를 말하면 이 스킬을 실행한다.

---

## 0. 주제 선정 기준

### 기본 원칙
- 기존 발행 글과 겹치지 않는 실용적 진로/취업 관련 주제
- **시의성 우선**: 최근 핫한 이슈·정책 변화와 연결

### 주제 발굴 방법
1. **최신 이슈 기반**: 웹 검색으로 최근 진로/취업/교육 뉴스 확인
2. **직업 세부 스텝 딥다이브**: careerwiki.org 직업 페이지의 "되는 법" 스텝 중 하나를 골라 팁/노하우 심층 작성
3. **카테고리 로테이션**: 연속으로 같은 분야 3개 이상 발행 금지

### ⚠️ 중복 방지 (주제 선정 전 필수!)
```sql
SELECT id, title, slug FROM pages
WHERE page_type = 'guide' AND status = 'published'
ORDER BY id DESC;
```
- 같은 시험/자격증/직업 다루는 글 이미 존재 → **발행 금지**
- 핵심 내용 80% 이상 겹치면 중복

### 제목 규칙
- **자유 형식** — 매번 다른 톤/구조 사용
- 금지: "OO 합격 가이드: OO" 같은 동일 패턴 반복
- 예시: "의사국시, 이렇게 공부하면 된다" / "비전공자의 데이터 분석가 전환 로드맵" / "로스쿨 면접 완전 정복 A to Z"

---

## 1. 전체 작업 순서

```
[1] 주제 선정 & 리서치 (섹션 0 참조)
[2] Tiptap JSON 콘텐츠 작성 (섹션 2 + references/tiptap-format.md)
[3] 썸네일 이미지 생성 (references/image-generation.md)
[4] 인라인 이미지 생성 1~2개 (필수! references/image-generation.md)
[5] 관련 직업/전공 매핑
[6] publish-direct API 호출 (섹션 6)
[7] 배포 후 검증 (섹션 7)
```

---

## 2. 콘텐츠 작성 기준

### 대상 독자
- 한국 고등학생~대학생 (진로 탐색 중)

### 톤 & 문체
- **~하다/있다** 체 (비격식 서술체)
- 통계/수치는 반드시 출처(footnote) 명시

### 구조 가이드
```
H2: 대제목 (3~5개)
  H3: 소제목 (필요시)
  paragraph: 본문
  table: 데이터 (점수표, 일정 등)
  bulletList/orderedList: 나열
  checkpointBox: 핵심 규칙/주의사항 (**글 전체 딱 1개만!**)
  conclusionBox: 섹션 요약/핵심 정리 (**글 전체 딱 1개만!**)
  qnaBlock: 자주 묻는 질문
  footnote: 출처 (본문 중 인라인 NODE 타입)
```

### 분량 기준
- HTML 기준 최소 8,000자 (순수 텍스트 4,000자 이상)
- H2 기준 5~8개 섹션, QnA 최소 4개, 테이블 최소 2개

### 리서치 깊이 (필수)
공식 정보만으로는 부족하다. 반드시 합격자 후기·커뮤니티 노하우를 웹 검색으로 수집:
- "[주제] 합격 후기", "[주제] 독학 꿀팁", "[주제] 난이도 체감", "[주제] 교재 추천"
- **금지**: 공식 사이트 정보만 나열하는 개론 수준의 글

> Tiptap JSON 상세 포맷은 **references/tiptap-format.md** 참조

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
    { "slug": "경찰관", "name": "경찰관" }
  ],
  "relatedMajors": [
    { "slug": "경찰행정학과", "name": "경찰행정학과" }
  ],
  "thumbnailUrl": "/uploads/jobs/job-howto-TOPIC.webp"
}
```

### 기존 페이지 업데이트 시
`"updatePageId": 3859` 필드 추가, 나머지 동일.

### 응답
```json
{ "success": true, "slug": "가이드-제목-slug", "pageId": 3859, "status": "published" }
```

---

## 7. 발행 후 검증 체크리스트

> ⚠️ **URL 형식**: `https://careerwiki.org/howto/{slug}` (careerwiki.**kr** 아님)

```
[ ] 페이지 접근: https://careerwiki.org/howto/{slug}
[ ] 썸네일 이미지 표시
[ ] H2/H3 제목 올바른 렌더링
[ ] 사이드바 관련 직업/전공 이름 표시 (빈칸 아님)
[ ] 각주 번호 [1], [2] 등 본문에 표시
[ ] 각주 순서: 위에서부터 1→2→3→4→5 (뒤죽박죽 아님!)
[ ] 페이지 하단 "출처" 접이식 섹션 존재
[ ] 인라인 이미지 1~2개 표시 (필수!) — 각 이미지가 해당 섹션 주제와 관련 있는지 확인
[ ] QnA 블록 아이콘 정렬
[ ] checkpointBox/conclusionBox 아이콘 위치
[ ] 내부 링크 (/job/xxx, /major/xxx) 작동
[ ] 기존 직업/전공 페이지 썸네일 변경 안 됨 ← 중요!
[ ] 편집 버튼 클릭 시 에디터에 콘텐츠 로드 (빈 상태 아님)
```

### 기술 검증 curl
```bash
curl -s "https://careerwiki.org/howto/SLUG?nocache=1" | grep -c "footnote-ref"
curl -s "https://careerwiki.org/howto/SLUG?nocache=1" | grep "next-action-item\|sidebar-related"
```

### 내용 검증 (팩트체크)
```bash
curl -s "https://careerwiki.org/howto/SLUG?nocache=1" | \
  sed -n '/<article/,/<\/article>/p' | sed 's/<[^>]*>//g' | sed '/^$/d' | head -100
```
수치/통계 → 각주 URL을 WebFetch로 확인 → 출처와 대조. 불일치 시 updatePageId로 재발행.

---

## 8. 전체 워크플로우 예시

```
1. 주제: "경찰 체력시험 합격 가이드"
2. 리서치: 웹 검색으로 기준표, 합격률, 훈련법 수집, 출처 URL 5개+
3. Tiptap JSON 작성: ~하다 체, H2 x 3~5개, footnote NODE, checkpoint/conclusionBox 각 1개
4. 썸네일: POST /api/image/generate (slug: "howto-경찰체력시험-thumb") → 30초 대기 → status → R2 저장
5. 인라인 이미지 (필수): slug "howto-경찰체력시험-img1" → R2 저장 → Tiptap image 노드 삽입
6. relatedJobs: [{ slug, name }] — name 필드 필수!
7. 발행: POST /api/howto/publish-direct, contentJson은 JSON.stringify() 문자열
8. 검증: 페이지, 사이드바, 각주, 이미지, 타 직업 썸네일 영향 없음 확인
9. CSS 변경 있으면: tsc --noEmit → build → wrangler pages deploy (영문 커밋 메시지)
```

> 자주 하는 실수 10가지 → **references/common-mistakes.md**
> 이미지 생성 상세 가이드 → **references/image-generation.md**

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

## 10. 세션 토큰

모든 API 호출에 인증 필요:
```
Cookie: session_token=SESSION_TOKEN
```
토큰은 유저에게 확인하거나 기존 세션에서 재사용.
