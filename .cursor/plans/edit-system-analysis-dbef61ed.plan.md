<!-- dbef61ed-5707-4a47-915c-2076ac688d81 9e628cff-af5a-4c7e-8825-07e8ddcb7506 -->
# HowTo 렌더링 통합 및 각주 시스템

## 1. 각주(Footnote) 시스템 추가

### 에디터 확장

- `src/editor/extensions/custom-nodes/footnote.ts` 생성
- 본문에 `<sup class="footnote-ref"><a href="#fn-1">[1]</a></sup>` 형태로 삽입
- 슬래시 메뉴에 "각주 추가" 옵션 추가

### 각주 UI

- 에디터 하단에 각주 입력 영역 추가 (번호 + 출처 URL/설명)
- 각주 추가/삭제/편집 기능

### HTML 변환

- `convertTiptapToHtml`에 footnote 노드 처리 추가
- 본문 하단에 `<section class="footnotes">` 렌더링

## 2. 발행 데이터 저장 확장

### `POST /api/howto/drafts/:id/publish` 수정 (`src/index.tsx` ~10200줄)

- `meta_data`에 저장할 데이터:
  - `relatedJobs`: `[{name, slug}]`
  - `relatedMajors`: `[{name, slug}]`
  - `relatedHowtos`: `[{name, slug}]`
  - `footnotes`: `[{id, text, url?}]`
  - `tags`, `difficulty`, `duration`, `authorName`

### 초안 저장 API 수정

- `PUT /api/howto/drafts/:id`에서 관련 콘텐츠 데이터도 저장

## 3. DB → HowtoGuideDetail 변환

### 변환 함수 생성 (`src/utils/howtoConverter.ts`)

```typescript
function dbRowToHowtoGuideDetail(row, metaData): HowtoGuideDetail {
  return {
    slug: row.slug,
    title: row.title,
    summary: row.summary,
    tags: metaData.tags || [],
    authorName: metaData.authorName,
    // 관련 직업/전공 → nextActions 매핑
    nextActions: [
      ...metaData.relatedJobs.map(j => ({ label: j.name, href: `/job/${j.slug}`, type: 'job' })),
      ...metaData.relatedMajors.map(m => ({ label: m.name, href: `/major/${m.slug}`, type: 'major' }))
    ],
    // 관련 HowTo → relatedContent 매핑
    relatedContent: metaData.relatedHowtos.map(h => ({ title: h.name, slug: h.slug })),
    // 본문 HTML → steps로 변환 (또는 rawHtml 필드 추가)
    steps: [],
    // 각주 → resources 매핑
    resources: metaData.footnotes.map(f => ({ label: f.text, url: f.url || '#' })),
    ...
  }
}
```

## 4. HowtoGuideDetail 타입 확장

### `src/types/howto.ts` 수정

- `rawHtml?: string` 필드 추가 (자유 형식 본문용)
- 또는 steps가 없으면 rawHtml 사용하도록 템플릿 수정

## 5. 템플릿 수정

### `src/templates/howtoDetail.ts` 수정

- `guide.rawHtml`이 있으면 steps 대신 rawHtml 렌더링
- 각주 섹션 렌더링 추가 (`resources` 활용 또는 별도 `footnotes` 필드)

## 6. 상세 페이지 라우트 수정

### `GET /howto/:slug` 수정 (`src/index.tsx` ~4920줄)

- DB 결과를 `dbRowToHowtoGuideDetail()`로 변환
- `renderHowtoGuideDetail()` 템플릿 사용
- 기존 단순 HTML 렌더링 코드 제거

## 7. 미리보기 동기화

### 에디터 미리보기 수정 (`src/index.tsx` ~4307줄)

- 미리보기도 `renderHowtoGuideDetail` 스타일과 동일하게 조정
- 또는 서버 API로 미리보기 HTML 요청

## 파일 변경 요약

- `src/editor/extensions/custom-nodes/footnote.ts` (신규)
- `src/editor/extensions/index.ts` (수정)
- `src/editor/ui/slash-menu.ts` (수정)
- `src/utils/howtoConverter.ts` (신규)
- `src/types/howto.ts` (수정)
- `src/templates/howtoDetail.ts` (수정)
- `src/index.tsx` (발행 API, 상세 페이지 라우트, 미리보기)
- `public/static/howto-editor.css` (각주 스타일)

### To-dos

- [ ] Tiptap 관련 npm 패키지 설치
- [ ] vite.editor.config.ts 생성 및 빌드 스크립트 추가
- [ ] src/editor/ 폴더 구조 및 에디터 코어 클래스 구현
- [ ] Custom Nodes 4종 구현 (Checkpoint, Conclusion, QnA, CareerList)
- [ ] Slash Command 확장 및 UI 구현
- [ ] 이미지 업로드 연동 (드래그앤드롭, 붙여넣기 포함)
- [ ] 서버 템플릿 업데이트 (/howto/write 페이지)
- [ ] 에디터 CSS 스타일 완성
- [ ] Tiptap 각주(footnote) 커스텀 노드 확장 생성
- [ ] 에디터에 각주 입력 UI 추가 (슬래시 메뉴 + 하단 목록)
- [ ] 발행 API에서 relatedJobs/Majors/Howtos/footnotes를 meta_data에 저장
- [ ] DB row → HowtoGuideDetail 변환 함수 생성
- [ ] HowtoGuideDetail 타입에 rawHtml 필드 추가
- [ ] howtoDetail 템플릿에서 rawHtml/footnotes 렌더링 지원
- [ ] GET /howto/:slug에서 renderHowtoGuideDetail 템플릿 사용
- [ ] 미리보기를 발행 결과와 동일하게 동기화