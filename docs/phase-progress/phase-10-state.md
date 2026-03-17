# Phase 10 완료 보고서
마지막 갱신: 2026-03-17

## 상태: 완료 (Phase 10 버그 수정 + Phase 10-B 도구 완성)

## 팀 구성
- **Team Leader**: Opus (메인 세션) — 조율, 코드 리뷰 승인, 프로덕션 테스트
- **Analyst**: Sonnet — 10개 점검 항목별 코드 분석, 부작용 검증
- **Researcher**: Sonnet — TipTap v3 API/버그/마이그레이션 리서치
- **Designer**: Sonnet — 모바일 UX, 에러 메시지 한국어화, 사용자 흐름 분석

## 실행 결과

### 팀 분석 → 이슈 식별
| 출처 | Critical | High | Medium | Low |
|------|----------|------|--------|-----|
| Analyst | 0 | 7 | 9 | 7 |
| Researcher | 0 | 1(P0) | 1(P1) | 2 |
| Designer | 0 | 5 | 5 | 3 |

### 수정된 버그 (8건 + 코드 리뷰 1건, 커밋 1개)

#### Commit: `ba238a6` — Phase 10 HowTo 에디터 버그 8건 수정

| Tier | 버그 | 파일 | 수정 내용 |
|------|------|------|----------|
| 1 | codeBlock 멀티라인 변환 — 첫 줄만 저장 | howto-editor.ts:153 | `content?.[0]?.text` → `content.map().join('')` + language class |
| 1 | Table colspan/rowspan 미반영 | howto-editor.ts:182-188 | tableCell/tableHeader에 colspan/rowspan 속성 추가 |
| 1 | TipTap v3 `history` → `undoRedo` 키 이름 | editor.ts:278 | StarterKit 옵션 키 이름 변경 |
| 1 | Footnote HTML data-footnote 속성 누락 | howto-editor.ts:211 | `<sup>` + `<a>` 태그에 data-footnote 계열 속성 추가 |
| 2 | save-publish UPDATE 결과 미확인 | howto-editor.ts:1147 | `.run()` 결과 success 확인 + 실패 시 500 반환 |
| 2 | 이미지 업로드 validateImageFile 미호출 | editor.ts:1433 | 파일 검증 호출 추가 (10MB, MIME 체크) |
| 3 | 영어 에러 메시지 8건 | howto-editor.ts | 한국어화 (`title is required` → `제목을 입력해주세요` 등) |
| 3 | R2 삭제 순서 오류 + 에러 무시 | howto-editor.ts:674-697 | DB 삭제 먼저 → R2 삭제 후, console.error 로그 추가 |

#### 코드 리뷰 게이트 발견 (Analyst)
| 이슈 | 파일 | 수정 내용 |
|------|------|----------|
| Footnote `<a>` 태그 data-footnote-id 누락 | howto-editor.ts:225 | `<a>` 태그에 data-footnote-id 속성 복원 |

### 설계 결정 (이번에 수정하지 않음 — 향후 Phase)

| 이슈 | 이유 |
|------|------|
| 발행 전 미리보기 엔드포인트 | 신규 기능 추가 → 별도 Phase로 |
| 이미지 리사이즈 touch 이벤트 | 모바일 에디터 대규모 UX 개선의 일부 |
| 크롭/모자이크 base64 → R2 업로드 | DB 비대화 리스크이나 기존 기능 변경 범위 큼 |
| 모바일 툴바 재구성 | UI 대규모 변경 → 별도 Phase로 |
| "임시저장" 명칭 변경 | UX 워딩 변경은 PM 확인 필요 |
| alert()/confirm() → 커스텀 UI | 프론트엔드 컴포넌트 추가 필요 |
| 자동저장 비활성 안내 UI | draftId 없을 때 안내 배너 추가 필요 |

## 프로덕션 테스트 결과

| 시나리오 | 결과 | 확인 방법 |
|---------|------|----------|
| HowTo 상세 페이지 렌더링 | ✅ | curl로 HTML 확인 |
| Footnote 셀렉터 호환 | ✅ | `footnote-ref a[data-footnote-id]` 셀렉터 존재 확인 |
| 에디터 페이지 접근 | ✅ | 302 (로그인 리다이렉트) 정상 |
| 에디터 번들 빌드 | ✅ | `npm run build:editor` 성공 |
| 전체 빌드 | ✅ | `npm run build` 성공 |

## 변경 파일 목록
```
src/routes/howto-editor.ts       — Tiptap→HTML 변환 5건 수정 + 에러 한국어화 + R2 순서
src/editor/editor.ts             — undoRedo 키 + validateImageFile 호출
public/static/editor.bundle.iife.js — 에디터 번들 리빌드
```

---

## Phase 10-B: 에디터 도구 완성 + WYSIWYG 일치

### Commit: `4dfe3aa` — HowTo 에디터 도구 완성 + WYSIWYG 일치

#### Batch 1: 누락 버튼 추가
| 항목 | 수정 |
|------|------|
| 인라인 코드 버튼 | 툴바에 `<i class="fas fa-code">` 버튼 추가 |
| 형광펜(하이라이트) | 5색 드롭다운 (노랑/초록/파랑/분홍/보라) + 제거 |
| 양쪽 정렬 | alignJustify 버튼 추가 |
| 커리어 목록 | 블록 드롭다운에 추가 |

#### Batch 2: WYSIWYG CSS 불일치 수정
| 항목 | 변경 |
|------|------|
| 내부 링크 색상 | `#00d4aa` → `#64b5f6` (발행 페이지와 통일) |
| Table 스타일 | 배경/border-radius/패딩 통일 |
| Code Block 배경 | `#000000` → `rgba(0,0,0,0.3)` |
| Task List | howto-content.css 스타일을 에디터에도 적용 |

#### Batch 3: convertTiptapToHtml 누락
| 항목 | 수정 |
|------|------|
| tableHeader 배경색 | backgroundColor + style 속성 추가 |
| image figcaption | caption 있으면 `<figcaption>` 생성 |

#### Batch 4-6: 새 기능 3건
| 기능 | Extension | 툴바 | HTML 변환 | CSS |
|------|-----------|------|----------|-----|
| YouTube 임베드 | youtube-embed.ts | 미디어 그룹 + 슬래시 메뉴 | `<div class="youtube-embed"><iframe>` | 16:9 반응형 |
| 콜아웃 박스 | callout-box.ts | 블록 드롭다운 (팁/주의/위험) + 슬래시 메뉴 | `<div class="callout-box callout-{type}">` | 4종 그라디언트 |
| 토글/접기 | toggle-block.ts | 블록 드롭다운 + 슬래시 메뉴 | `<details class="toggle-block">` | 화살표 애니메이션 |

#### Batch 7: 이미지 캡션
- resizable-image.ts에 `caption` 속성 추가
- NodeView에 editable `<figcaption>` 렌더링
- convertTiptapToHtml에서 figcaption 생성

#### Batch 8: 목차(TOC) 자동생성
- howtoDetail.ts에 `generateTocFromHtml()` 함수 추가
- h2/h3 3개 이상일 때 자동 TOC 삽입
- 접기/펼치기 가능한 `<details open>` 구조

### 변경 파일 목록 (Phase 10-B)
```
src/routes/howto.ts                      — 툴바 버튼 추가 (양쪽 에디터)
src/routes/howto-editor.ts               — convertTiptapToHtml 노드 3건 + figcaption
src/editor/editor.ts                     — 새 extension 등록 + 액션 핸들러 + 메서드
src/editor/extensions/youtube-embed.ts   — [신규] YouTube 임베드 노드
src/editor/extensions/callout-box.ts     — [신규] 콜아웃 노드
src/editor/extensions/toggle-block.ts    — [신규] 토글/접기 노드
src/editor/extensions/resizable-image.ts — caption 속성 + figcaption UI
src/editor/ui/slash-menu.ts              — 슬래시 메뉴 5개 항목 추가
src/templates/howtoDetail.ts             — TOC 자동생성 함수
public/static/howto-editor.css           — CSS 통일 + 새 노드 에디터 스타일
public/static/howto-content.css          — 새 노드 발행 스타일 + TOC
public/static/editor.bundle.iife.js      — 에디터 번들 리빌드
```

### 프로덕션 테스트 결과 (Phase 10-B)
| 시나리오 | 결과 | 확인 방법 |
|---------|------|----------|
| howto-content.css 새 스타일 배포 | ✅ | curl로 youtube-embed, callout-box, toggle-block, howto-toc, figcaption 확인 |
| howto-editor.css 새 스타일 배포 | ✅ | curl로 youtube-embed, callout-box, toggle-block, image-caption 확인 |
| 에디터 페이지 접근 | ✅ | 302 (로그인 리다이렉트) 정상 |
| 에디터 번들 빌드 | ✅ | `npm run build:editor` 성공 (464KB) |
| 전체 빌드 | ✅ | `npm run build` 성공 |
| 배포 | ✅ | Cloudflare Pages 배포 완료 |

---

## 미수정 잔여 이슈 (다음 Phase 후보)

### High
- 모바일 툴바 과다 버튼 → 기본 7~8개 + "더보기" 시트
- 자동저장 비활성 안내 (draftId 없을 때)
- 이미지 업로드 피드백 (placeholder 노드 + 스피너)
- 발행 흐름 명칭 혼란 ("임시저장" → "초안 저장")
- 버전 충돌 다이얼로그 (#conflict-dialog HTML 누락 여부)

### Medium
- 임시 발행 배지 권한 체크 (canEdit 조건)
- 모바일 오버레이 메뉴 iOS safe-area
- 메타 필드 인지 부하 (접힘 처리)
- 미리보기 기능 추가
- 크롭/모자이크 base64 → R2 업로드 전환
