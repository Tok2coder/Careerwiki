<!-- 21ee76db-0ce6-4ed7-b21c-04c2d4f22295 e795116b-5c1a-4b55-908b-6ce96e6e4036 -->
# 건의사항 게시판 구현 계획

1) DB 스키마

- feedback_posts: id, user_id, title, body, type(bug/suggestion/etc), status(open/closed), is_private (관리자만 보기), created_at/updated_at, INDEX on created_at/status/is_private
- feedback_replies: id, post_id FK, admin_id, body, created_at/updated_at (포스트당 1개 유지)

2) 서비스/검증

- 게시글: 생성(로그인), 목록(페이지네이션, 최신순, 관리자면 private 포함/비관리자는 공개만), 단건 조회
- 관리자 답변: 등록/수정/삭제(관리자 전용), 포스트당 1개 제한
- 검증: 제목/본문 길이, type/status enum, XSS escape

3) API

- POST /api/feedback (auth)
- GET /api/feedback (list: page, pageSize, type?, status?, include_private?=admin만)
- GET /api/feedback/:id
- POST/PUT/DELETE /api/feedback/:id/reply (admin)
- PATCH /api/feedback/:id/visibility (admin, is_private 토글)

4) UI (src/templates/feedback.tsx)

- 작성 폼 → /api/feedback 호출, 작성자만
- 목록 표시: 공개 글, 관리자면 비공개까지 표시 + 배지
- 답변 블록: 관리자만 작성/수정/삭제, 일반 사용자에겐 읽기 전용
- is_private 토글 UI: 관리자만, 목록/상세에 표시
- 기본 로딩/에러 토스트 단순 처리, 헤더/스타일은 기존 파셜 재사용

5) 권한/보안

- 작성: 로그인 필요, 답변/비공개 토글: 관리자 필요
- 서버 측 escape/길이 제한, no-store 캐시 헤더, CSRF 기존 정책 준수

6) 캐시/ISR

- 동적 API만 사용, 템플릿 버전 영향 없음

### To-dos

- [ ] feedback_posts/replies 스키마 추가
- [ ] 피드백 CRUD/리스트 API 구현
- [ ] 관리자 답변 API(등록/수정/삭제)
- [ ] 피드백 비공개 토글 API(관리자)
- [ ] 피드백 페이지 UI+API 연동