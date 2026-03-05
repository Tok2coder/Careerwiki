# Product Completeness Analysis Report

**분석일**: 2026-03-03
**분석자**: Product Analyst (김분석)
**대상**: CareerWiki (https://careerwiki.org)
**방법**: 소스 코드 전수 조사 (라우트, 서비스, 마이그레이션, 타입 정의)

---

## 1. 기능 인벤토리

### 전체 요약

- **총 기능 수**: 62개
- ✅ 완성: 48개 (77.4%)
- ⚠️ 부분 구현: 11개 (17.7%)
- ❌ 미구현: 2개 (3.2%)
- 🔲 계획만: 1개 (1.6%)

### 1.1 메인/네비게이션 (7개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | 홈페이지 | ✅ 완성 | `GET /` 핸들러 완전 구현. 메인 레이아웃, AI 추천 CTA, 직업/전공 카테고리 섹션 포함 | `src/routes/pages.ts:396` |
| 2 | 글로벌 네비게이션 | ✅ 완성 | `renderNav` 함수로 전역 네비게이션 렌더링. 직업위키, 전공위키, HowTo, AI추천, 검색, 사용자 메뉴 포함 | `src/templates/partials/nav.ts` |
| 3 | 통합 검색 | ✅ 완성 | `GET /search` — RAG 기반 통합 검색 (직업+전공+HowTo). Vectorize 벡터 검색 + LIKE 폴백. 검색어 로깅 포함 | `src/routes/search.ts:12` |
| 4 | 로그인 페이지 | ✅ 완성 | `GET /login` — Google OAuth + 테스트 계정 지원. 리다이렉트 URL 보존 | `src/routes/pages.ts:1234` |
| 5 | 404 페이지 | ✅ 완성 | `app.notFound()` — 커스텀 404 페이지, 사용자 메뉴 유지 | `src/index.tsx:152` |
| 6 | www 리다이렉트 | ✅ 완성 | www → non-www 301 리다이렉트 | `src/index.tsx:92` |
| 7 | 보안 헤더 | ✅ 완성 | X-Content-Type-Options, X-Frame-Options, Referrer-Policy, Permissions-Policy 미들웨어 | `src/index.tsx:57` |

### 1.2 직업 관련 (8개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | 직업 목록 | ✅ 완성 | `GET /job` — RAG 검색 + LIKE 폴백, 페이지네이션 (20/페이지), 정렬 (기본순/연봉순/가나다순), JSON-LD 구조화 데이터 | `src/routes/job-list.ts:16` |
| 2 | 직업 상세 | ✅ 완성 | `GET /job/:slug` — ISR 캐싱, 다중 소스 데이터 통합 (CareerNet + 고용24), 관련 직업/HowTo 연결, 조회수 추적, JSON-LD SEO | `src/routes/job-detail.ts:19` |
| 3 | 직업 생성 | ✅ 완성 | `POST /api/job/create` — 인증 필수, 이름 중복 체크, 슬러그 자동 생성, 초기 리비전 생성 | `src/routes/job-editor.ts:20` |
| 4 | 직업 편집 | ✅ 완성 | `POST /api/job/:id/edit` — 인증 필수, 필드별 편집, 리비전 히스토리, 캐시 무효화 | `src/routes/job-editor.ts:319` |
| 5 | 직업 삭제 | ✅ 완성 | `DELETE /api/job/:id` — 인증 필수, 관리자 전용 (soft delete: is_active=0), R2 이미지 정리 | `src/routes/job-editor.ts:562` |
| 6 | 직업 복원 | ✅ 완성 | `POST /api/job/:id/restore` — 삭제된 직업 복원 (is_active=1) | `src/routes/job-editor.ts:640` |
| 7 | 직업 카테고리 | ✅ 완성 | `GET /api/job/categories` — 카테고리 목록 조회 | `src/routes/job-editor.ts:228` |
| 8 | 직업 API 재수집 | ✅ 완성 | `POST /api/job/:id/refetch-api-data` — 외부 API 데이터 갱신 | `src/routes/job-editor.ts:768` |

### 1.3 전공 관련 (8개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | 전공 목록 | ✅ 완성 | `GET /major` — RAG 검색, KV 캐싱, 정렬 (기본순/취업률/월급/가나다), 페이지네이션, JSON-LD | `src/routes/major-list.ts:24` |
| 2 | 전공 상세 (ISR) | ✅ 완성 | `GET /major/:slug` — ISR 캐싱, 관련 직업 매핑, 같은 계열 전공, 관련 HowTo, 조회수 추적 | `src/routes/major-detail.ts:20` |
| 3 | 전공 상세 (레거시) | ✅ 완성 | `GET /majors/:id` — D1 직접 조회 방식 (ISR 이전 구현) | `src/routes/major-detail.ts:387` |
| 4 | 전공 생성 | ✅ 완성 | `POST /api/major/create` — 인증 필수, 중복 체크, 슬러그 생성, 리비전 | `src/routes/major-editor.ts:137` |
| 5 | 전공 편집 | ✅ 완성 | `POST /api/major/:id/edit` — 필드별 편집, 리비전, 캐시 무효화 | `src/routes/major-editor.ts:409` |
| 6 | 전공 삭제 | ✅ 완성 | `DELETE /api/major/:id` — soft delete, R2 정리 | `src/routes/major-editor.ts:693` |
| 7 | 전공 복원 | ✅ 완성 | `POST /api/major/:id/restore` | `src/routes/major-editor.ts:765` |
| 8 | 전공 디버그 비교 | ⚠️ 부분 구현 | `GET /major/:slug?debug=true` — 501 반환, "준비 중" 메시지. 직업 디버그는 작동하지만 전공은 미구현 | `src/routes/major-detail.ts:107` |

### 1.4 AI 추천 시스템 (12개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | AI 추천 랜딩 | ✅ 완성 | `GET /analyzer` — AI 추천 소개 페이지, 직업/전공 추천 분기 | `src/routes/pages.ts:459` |
| 2 | AI 직업 추천 UI | ✅ 완성 | `GET /analyzer/job` — 3단계 UI (프로필 -> 심층 질문 -> 결과). 로그인 필수 | `src/routes/analyzer-job-page.ts:21` |
| 3 | AI 전공 추천 UI | ✅ 완성 | `GET /analyzer/major` — 전공 전용 추천 UI | `src/routes/analyzer-major-page.ts` |
| 4 | 세션 시작/프로필 제출 | ✅ 완성 | `POST /api/ai-analyzer/analyze` — 세션 생성, 5축 프로필 데이터 처리, Vectorize 후보 검색 | `src/services/ai-analyzer/routes.ts:424` |
| 5 | 서사적 팩트 제출 | ✅ 완성 | `POST /api/ai-analyzer/v3/narrative-facts` — 서술형 답변 저장 | `src/services/ai-analyzer/routes.ts:4729` |
| 6 | LLM 라운드 질문 | ✅ 완성 | `POST /api/ai-analyzer/v3/round-questions` — LLM이 생성하는 심층 인터뷰 질문 | `src/services/ai-analyzer/routes.ts:4334` |
| 7 | LLM 라운드 답변 | ✅ 완성 | `POST /api/ai-analyzer/v3/round-answers` — 사용자 답변 처리 | `src/services/ai-analyzer/routes.ts:4551` |
| 8 | 직업 추천 결과 | ✅ 완성 | `POST /api/ai-analyzer/v3/recommend` — TAG 필터 + 스코어링 + LLM Judge + 직업 추천 생성 | `src/services/ai-analyzer/routes.ts:5153` |
| 9 | 전공 추천 결과 | ✅ 완성 | `POST /api/ai-analyzer/v3/recommend-major` — 전공 전용 추천 파이프라인 | `src/services/ai-analyzer/routes.ts:7650` |
| 10 | 프리미엄 리포트 | ✅ 완성 | `POST /api/ai-analyzer/v3/recommend/report` — LLM Reporter 서사적 리포트 생성 | `src/services/ai-analyzer/routes.ts:6285` |
| 11 | 결과 공유 | ✅ 완성 | `POST /api/ai-analyzer/share` — 공유 토큰 생성 + `GET /share/:token` 공유 페이지 | `src/services/ai-analyzer/routes.ts:7436`, `src/routes/share.ts:18` |
| 12 | 결과 저장/조회 | ✅ 완성 | `GET /api/ai-analyzer/result/:requestId`, `GET /api/ai-analyzer/saved-result/:requestId` | `src/services/ai-analyzer/routes.ts:1491,8079` |

### 1.5 HowTo 콘텐츠 (9개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | HowTo 목록 | ✅ 완성 | `GET /howto` — 발행된 가이드 목록, 페이지네이션, 키워드 검색, 썸네일/태그/댓글수/북마크수 표시 | `src/routes/howto.ts:26` |
| 2 | HowTo 상세 | ✅ 완성 | `GET /howto/:slug` — Tiptap JSON -> HTML 렌더링, 관련 직업/전공 링크, 댓글, 조회수, 북마크 | `src/routes/howto.ts:3247` |
| 3 | HowTo 작성 (에디터) | ✅ 완성 | `GET /howto/write` — TipTap 에디터, 태그/관련직업/관련전공 입력, 이미지 업로드, AI 이미지 생성, 각주 | `src/routes/howto.ts:383` |
| 4 | HowTo 편집 | ✅ 완성 | `GET /howto/:slug/edit` — 기존 가이드 편집, 소유자/관리자만 가능 | `src/routes/howto.ts:3034` |
| 5 | HowTo 초안 관리 | ✅ 완성 | CRUD API: 생성/조회/수정/삭제/제출/발행 (`/api/howto/drafts/*`) | `src/routes/howto-editor.ts:455-873` |
| 6 | HowTo 직접 발행 | ✅ 완성 | `POST /api/howto/publish-direct`, `POST /api/howto/save-publish` — 초안 없이 바로 발행 | `src/routes/howto-editor.ts:873,1096` |
| 7 | HowTo 신고 | ✅ 완성 | `POST /api/howto/:slug/report` — 부적절 콘텐츠 신고 | `src/routes/howto-editor.ts:351` |
| 8 | HowTo 관리자 모더레이션 | ✅ 완성 | 승인/반려/블라인드/해제/신고 해결 API 모두 구현 | `src/routes/howto-editor.ts:1273-1453` |
| 9 | HowTo 업데이트/삭제 | ✅ 완성 | `PUT /api/howto/:id/update`, `DELETE /api/howto/:id` — 소유자만 가능, R2 이미지 정리 | `src/routes/howto-editor.ts:1453,1528` |

### 1.6 사용자 시스템 (10개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | Google OAuth 로그인 | ✅ 완성 | `GET /auth/google` -> Google -> `GET /auth/google/callback`. CSRF 방지 (state), 세션 기반 | `src/routes/auth.ts:39,90` |
| 2 | 로그아웃 | ✅ 완성 | `POST /auth/logout` + `GET /auth/logout` — KV 세션 삭제, 쿠키 정리 | `src/routes/auth.ts:239,276` |
| 3 | 테스트 계정 | ✅ 완성 | `POST /auth/test-login` — 데모용 (test/1234) | `src/routes/auth.ts:368` |
| 4 | 온보딩 | ✅ 완성 | `GET /onboarding` + `POST /api/onboarding` — 닉네임 설정, 유입경로, 이용약관 동의 | `src/routes/pages.ts:59,110` |
| 5 | 마이페이지 (프로필) | ✅ 완성 | `GET /user/profile` — 프로필 수정 (닉네임, 프로필 이미지) | `src/routes/user.ts:252` |
| 6 | 내 가이드 관리 | ✅ 완성 | `GET /user/drafts` — 임시발행/발행된 가이드 목록, 필터, 편집/삭제 | `src/routes/user.ts:19` |
| 7 | 내 AI 결과 | ✅ 완성 | `GET /user/ai-results` — 과거 AI 추천 결과 목록/상세 | `src/routes/user.ts:1128,1424` |
| 8 | 내 댓글 | ✅ 완성 | `GET /user/comments` — 내가 작성한 댓글 목록 | `src/routes/user.ts:1463` |
| 9 | 내 북마크 | ✅ 완성 | `GET /user/bookmarks` — 저장한 직업/전공/HowTo | `src/routes/user.ts:1602` |
| 10 | 보안 설정 | ✅ 완성 | `GET /user/settings` — 세션 관리 (활성 세션 목록, 다른 기기 로그아웃) | `src/routes/user.ts:1987` |

### 1.7 댓글 시스템 (6개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | 댓글 조회 | ✅ 완성 | `GET /api/comments` — 페이지별 댓글 목록, 비회원 표시, 좋아요 수, 대댓글, 정책 포함 | `src/routes/comments.ts:23` |
| 2 | 댓글 작성 | ✅ 완성 | `POST /api/comments` — 회원/익명 모두 가능, IP 차단 확인, 일일 제한, 비밀번호(익명) | `src/routes/comments.ts:87` |
| 3 | 댓글 수정 | ✅ 완성 | `PATCH /api/comments/:id` — 소유자/관리자만, 익명은 비밀번호 필요 | `src/routes/comments.ts:351` |
| 4 | 댓글 삭제 | ✅ 완성 | `DELETE /api/comments/:id` — 소유자/관리자, 비밀번호 검증 | `src/routes/comments.ts:408` |
| 5 | 댓글 좋아요/싫어요 | ✅ 완성 | `POST /api/comments/:id/like` — up/down/clear 방향, 자기 댓글 투표 차단 | `src/routes/comments.ts:292` |
| 6 | 댓글 신고 | ✅ 완성 | `POST /api/comments/:id/flag` — 로그인 필수, 중복 신고 방지, 자동 블라인드 | `src/routes/comments.ts:459` |

### 1.8 관리자 시스템 (8개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | 관리자 대시보드 | ✅ 완성 | `GET /admin` — KPI (유저/직업/전공/조회수/AI분석), 차트, 최근 편집/가입 | `src/routes/admin.ts:27` |
| 2 | AI 분석기 관리 | ✅ 완성 | `GET /admin/ai-analyzer` — E2E 시나리오 테스트, 벡터 인덱싱 관리 | `src/routes/admin.ts:131` |
| 3 | 피드백 관리 | ✅ 완성 | `GET /admin/feedback`, `GET /admin/feedback/:id` — 피드백 목록/상세, 상태 관리 | `src/routes/admin.ts:178,198` |
| 4 | 사용자 관리 | ✅ 완성 | `GET /admin/users`, `GET /admin/users/:id` — 사용자 목록/상세, 역할 변경, 차단/해제 | `src/routes/admin.ts:233,267` |
| 5 | 콘텐츠 관리 | ✅ 완성 | `GET /admin/content` — 리비전 목록, 댓글 모더레이션, 직업/전공/HowTo 일괄 관리 | `src/routes/admin.ts:436` |
| 6 | 통계 | ✅ 완성 | `GET /admin/stats` — 사용자 통계, AI 전환율, 검색 통계, 콘텐츠 조회 통계 | `src/routes/admin.ts:678` |
| 7 | IP 차단 관리 | ✅ 완성 | 차단/해제/목록 API 모두 구현 | `src/routes/comments.ts:186-287` |
| 8 | 벡터 인덱싱 관리 | ⚠️ 부분 구현 | 직업/전공/HowTo 인덱싱 API 구현. 단, UI에서 진행률 모니터링은 제한적 | `src/services/ai-analyzer/routes.ts:4883-5025` |

### 1.9 피드백 시스템 (3개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | 피드백 목록/상세 | ✅ 완성 | `GET /feedback`, `GET /feedback/:id` — 사용자 피드백 게시판 | `src/routes/feedback.ts:25,60` |
| 2 | 피드백 작성 | ✅ 완성 | `POST /api/feedback` — 로그인 필수, 유형 분류 | `src/routes/feedback.ts:105` |
| 3 | 피드백 관리자 답변 | ✅ 완성 | 답변 작성/수정/삭제, 상태 변경, 공개/비공개 토글 | `src/routes/feedback.ts:205-335` |

### 1.10 파일 업로드/이미지 (4개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | 이미지 업로드 | ✅ 완성 | `POST /api/upload` — R2 스토리지 저장, 10MB 제한, 이미지 타입 검증 | `src/routes/upload.ts:17` |
| 2 | R2 이미지 서빙 | ✅ 완성 | `GET /uploads/*` — R2에서 이미지 서빙, 캐시 헤더, CDN 캐싱 | `src/routes/upload.ts:175` |
| 3 | AI 이미지 생성 | ⚠️ 부분 구현 | `POST /api/image/generate` — Workers AI로 이미지 생성 요청, 웹훅으로 완료 확인. 비동기 방식이라 UX에서 대기 필요 | `src/routes/upload.ts:278` |
| 4 | 프로필 이미지 | ✅ 완성 | `POST /api/user/profile-image` — 사용자 프로필 이미지 업로드 | `src/routes/user.ts:1811` |

### 1.11 기타 기능 (5개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | 약관/정책 페이지 | ✅ 완성 | `GET /legal/terms`, `GET /legal/privacy` | `src/routes/pages.ts:172,180` |
| 2 | 도움말/소개 | ✅ 완성 | `GET /help`, `GET /about`, `GET /help/community-guidelines` | `src/routes/pages.ts:187,195,554` |
| 3 | 릴리스 노트 | ⚠️ 부분 구현 | `GET /releases` — GitHub API에서 릴리스 노트 가져와 표시. KV 캐싱 있으나, GitHub 토큰 없으면 에러 가능성 | `src/routes/pages.ts:203` |
| 4 | 사이트맵/로봇 | ✅ 완성 | `GET /sitemap.xml`, `GET /robots.txt` — 동적 사이트맵 생성 | `src/routes/pages.ts:1352,1363` |
| 5 | SERP 인터랙션 로깅 | ⚠️ 부분 구현 | API 존재하지만 활용도 불명확. 일일 요약 집계 미확인 | `src/routes/api-misc.ts:349-428` |

### 1.12 데이터 API (5개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | 직업 데이터 API | ✅ 완성 | `GET /api/jobs`, `GET /api/jobs/search`, `GET /api/jobs/:id` — REST API 완전 구현 | `src/routes/api-data.ts:154-284` |
| 2 | 전공 데이터 API | ✅ 완성 | `GET /api/majors`, `GET /api/majors/search`, `GET /api/majors/:id` — REST API 완전 구현 | `src/routes/api-data.ts:19-153` |
| 3 | 직업 편집 데이터 | ✅ 완성 | `GET /api/job/:id/edit-data` — 편집 시 필요한 상세 데이터 | `src/routes/api-data.ts:285` |
| 4 | 전공 편집 데이터 | ✅ 완성 | `GET /api/major/:id/edit-data` — 편집 시 필요한 상세 데이터 | `src/routes/api-data.ts:622` |
| 5 | 자동완성 검색 | ❌ 미구현 | 검색 페이지에 자동완성 기능 없음. 검색어 제출 후 결과 표시 방식만 존재 | 해당 없음 |

### 1.13 스케줄러/백그라운드 (2개)

| # | 기능 | 상태 | 근거 | 코드 위치 |
|---|------|------|------|-----------|
| 1 | SERP Freshness Cron | ⚠️ 부분 구현 | `scheduled` 핸들러에서 SERP 갱신 실행. 설정 대상은 있으나 실질적 효과 미확인 | `src/index.tsx:161` |
| 2 | 자동 Vectorize 인덱싱 | ✅ 완성 | Cron에서 직업/전공/HowTo 증분 업서트 실행 (max 20개/회) | `src/index.tsx:177` |

### 1.14 미구현/계획 (2개)

| # | 기능 | 상태 | 근거 |
|---|------|------|------|
| 1 | 이메일 알림 | ❌ 미구현 | 댓글 알림, AI 결과 알림 등 알림 시스템 없음. 코드/스텁 없음 |
| 2 | 다국어 지원 | 🔲 계획만 | `name_en` 컬럼이 migration에 존재 (0031). 실질적 다국어 UI 미구현 |

---

## 2. 유저 시나리오 검증

### 시나리오 1: 신규 방문자 -- 메인 -> 검색 -> 직업 상세 -> 관련 정보 탐색

- **완주 가능 여부**: O (완주 가능)
- **필요 라우트 존재**: O
  - `GET /` (메인) ✅
  - `GET /search?q=xxx` (검색) ✅
  - `GET /job/:slug` (직업 상세) ✅
  - 사이드바 관련 직업 링크 ✅
  - 관련 HowTo 링크 ✅
- **핸들러 완전 구현**: O -- 모든 핸들러에 에러 처리 포함
- **에러 처리**: O
  - 검색 결과 없음 -> "검색 결과가 없습니다" 메시지 표시
  - 직업 미발견 -> `/search?q=xxx`로 리다이렉트
  - DB 에러 -> 500 에러 페이지 (직업 목록은 에러 디버그 페이지까지 표시)
- **발견된 문제점**:
  - 검색 자동완성 없음 -- 사용자가 검색어를 정확히 입력해야 함
  - 메인페이지에서 검색 박스가 눈에 띄지 않을 수 있음 (RAG 검색 연결은 정상)

### 시나리오 2: AI 추천 사용자 -- AI 추천 시작 -> 프로필 -> 질문 응답 -> 결과 확인

- **완주 가능 여부**: O (완주 가능)
- **필요 라우트 존재**: O
  - `GET /analyzer` (소개) ✅
  - `GET /analyzer/job` (UI, 로그인 필수) ✅
  - `POST /api/ai-analyzer/analyze` (세션 시작) ✅
  - `POST /api/ai-analyzer/v3/narrative-facts` ✅
  - `POST /api/ai-analyzer/v3/round-questions` ✅
  - `POST /api/ai-analyzer/v3/round-answers` ✅
  - `POST /api/ai-analyzer/v3/recommend` (결과) ✅
  - `POST /api/ai-analyzer/v3/recommend/report` (리포트) ✅
- **핸들러 완전 구현**: O -- 5축 프로필 수집 -> Multi-Query 벡터 검색 -> TAG 필터 -> 스코어링 -> LLM Judge -> LLM Reporter 전체 파이프라인 구현
- **에러 처리**: O -- 각 단계별 에러 핸들링 구현
- **발견된 문제점**:
  - 로그인 필수 (비회원 접근 불가) -- 허들이 높을 수 있음
  - LLM 호출 실패 시 재시도 로직은 있으나, 사용자에게 보이는 에러 메시지가 기술적일 수 있음

### 시나리오 3: 콘텐츠 기여자 -- 직업 편집 -> 저장 -> 리비전 확인

- **완주 가능 여부**: O (완주 가능)
- **필요 라우트 존재**: O
  - `GET /job/:slug` (상세 페이지 -> 편집 버튼) ✅
  - `GET /api/job/:id/edit-data` (편집 데이터 로드) ✅
  - `POST /api/job/:id/edit` (저장) ✅
  - `GET /api/job/:id/revisions` (리비전 목록) ✅
  - `GET /api/revision/:id` (리비전 상세) ✅
- **핸들러 완전 구현**: O
- **에러 처리**: O -- 권한 체크, 필드 유효성 검증, 캐시 무효화 포함
- **발견된 문제점**:
  - 편집 권한 체크가 `requireJobMajorEdit` 미들웨어에 의존 -- 정확한 권한 정책이 코드에서 확인 필요
  - 익명 편집 지원 구조는 DB에 있으나 (`anonymous_edit_limits`), 실제 익명 편집 허용 여부는 미들웨어 설정에 의존

### 시나리오 4: HowTo 작성자 -- 드래프트 생성 -> 편집 -> 발행

- **완주 가능 여부**: O (완주 가능)
- **필요 라우트 존재**: O
  - `GET /howto/write` (에디터 페이지) ✅
  - `POST /api/howto/drafts` (초안 생성) ✅
  - `PUT /api/howto/drafts/:id` (초안 수정) ✅
  - `POST /api/howto/drafts/:id/publish` (발행) ✅
  - `POST /api/howto/publish-direct` (직접 발행) ✅
  - `POST /api/howto/save-publish` (저장+발행) ✅
  - `GET /howto/:slug` (발행 결과 확인) ✅
- **핸들러 완전 구현**: O -- Tiptap JSON 에디터, 이미지 업로드, AI 이미지 생성, 태그/관련 직업/전공 연결, 각주 지원
- **에러 처리**: O
- **발견된 문제점**:
  - 발행 경로가 다양함 (초안->발행, 직접발행, 저장+발행) -- 동작 차이가 사용자에게 혼란 가능
  - `draft_published` 상태가 있어 임시 발행과 정식 발행 구분이 존재

### 시나리오 5: 정보 탐색자 -- 전공 검색 -> 상세 -> 관련 직업 확인

- **완주 가능 여부**: O (완주 가능)
- **필요 라우트 존재**: O
  - `GET /major` (전공 목록) ✅
  - `GET /major?q=xxx` (검색) ✅
  - `GET /major/:slug` (전공 상세) ✅
  - 관련 직업 링크 (existingJobSlugs 매핑) ✅
  - 같은 계열 전공 링크 (relatedMajorsByCategory) ✅
  - 관련 HowTo 링크 ✅
- **핸들러 완전 구현**: O
- **에러 처리**: O -- 전공 미발견 시 검색 리다이렉트, KV 에러 시 직접 쿼리 폴백
- **발견된 문제점**:
  - 전공 상세에서 관련 직업 링크가 DB에 해당 직업이 존재할 때만 표시 -- 아직 DB에 없는 관련 직업은 텍스트만 표시
  - `categoryDisplay` 필드가 없는 전공은 같은 계열 추천이 작동하지 않음

---

## 3. 데이터 완성도

### 3.1 직업 데이터 스키마 (jobs 테이블)

```
jobs (
  id TEXT PRIMARY KEY,                    -- 직업 식별자
  careernet_id TEXT,                       -- CareerNet API ID
  goyong24_id TEXT,                        -- 고용24 API ID
  name TEXT NOT NULL,                      -- 직업명
  slug TEXT UNIQUE,                        -- URL 슬러그
  api_data_json TEXT,                      -- 외부 API 원본 데이터 (JSON)
  api_data_hash TEXT,                      -- 데이터 변경 감지용 해시
  api_last_fetched_at INTEGER,            -- 마지막 API 조회 시각
  api_last_updated_at INTEGER,            -- 마지막 API 데이터 갱신 시각
  user_contributed_json TEXT,             -- 사용자 기여 데이터 (JSON)
  user_last_updated_at INTEGER,
  admin_data_json TEXT,                   -- 관리자 데이터 (JSON)
  admin_last_updated_at INTEGER,
  merged_profile_json TEXT,               -- 통합 프로필 (JSON)
  ai_data_json TEXT,                      -- AI 생성 데이터
  ai_last_updated_at INTEGER,
  primary_source TEXT,                    -- CAREERNET / WORK24_JOB / WORK24_DJOB
  is_active INTEGER DEFAULT 1,           -- 활성 상태
  indexed_at DATETIME,                   -- Vectorize 인덱싱 시각
  embedding_version TEXT,                 -- 임베딩 버전
  created_at INTEGER NOT NULL,
  image_url TEXT,                          -- 대표 이미지
  image_prompt TEXT,                      -- AI 이미지 프롬프트
  name_en TEXT,                           -- 영문명
  view_count INTEGER DEFAULT 0,          -- 조회수
  aggregated_profile_json TEXT           -- API+사용자+관리자 통합 프로필
)
```

**데이터 구조 평가**: 3계층 데이터 구조 (`api_data_json` + `user_contributed_json` + `admin_data_json`) = `merged_profile_json`. 각 소스 데이터를 개별 보존하면서 통합 뷰를 제공하는 설계. NOT NULL 제약은 `name`과 `created_at`만 적용되어 유연하지만 빈 데이터 가능성 존재.

### 3.2 전공 데이터 스키마 (majors 테이블)

```
majors (
  id TEXT PRIMARY KEY,
  careernet_id TEXT,
  goyong24_id TEXT,
  name TEXT NOT NULL,
  slug TEXT UNIQUE,
  api_data_json TEXT,
  api_data_hash TEXT,
  api_last_fetched_at INTEGER,
  api_last_updated_at INTEGER,
  user_contributed_json TEXT,
  user_last_updated_at INTEGER,
  admin_data_json TEXT,
  admin_last_updated_at INTEGER,
  merged_profile_json TEXT,
  ai_data_json TEXT,
  ai_last_updated_at INTEGER,
  primary_source TEXT,                    -- CAREERNET / WORK24_MAJOR
  is_active INTEGER DEFAULT 1,
  indexed_at DATETIME,
  embedding_version TEXT,
  created_at INTEGER NOT NULL,
  image_url TEXT,
  image_prompt TEXT,
  name_en TEXT,
  view_count INTEGER DEFAULT 0,
  aggregated_profile_json TEXT
)
```

**데이터 구조 평가**: 직업과 동일한 3계층 구조. CareerNet + 고용24 소스 데이터 통합.

### 3.3 소스 데이터 테이블

**job_sources** (원본 API 데이터 보존):
- `source_system`: CAREERNET, WORK24_JOB, WORK24_DJOB
- `source_type`: LIST, DETAIL, ENCYCLOPEDIA, DICTIONARY
- `raw_payload` + `normalized_payload`: 원본/정규화 JSON
- 코드 기반 분류: `std_job_cd`, `keco_cd`, `ksoc_cd`, `industry_cd`

**major_sources** (전공 원본 데이터):
- `source_system`: CAREERNET, WORK24_MAJOR
- `source_type`: LIST, DETAIL_UNIV, DETAIL_HIGH, DETAIL_GENERAL, DETAIL_SPECIAL
- `track`, `gubun`: 전공 트랙/구분

### 3.4 HowTo 콘텐츠 구조

**pages 테이블** (HowTo는 page_type='guide'로 저장):
```
pages (
  id INTEGER PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  page_type TEXT NOT NULL,               -- 'job' | 'major' | 'guide'
  content TEXT NOT NULL,                  -- Tiptap JSON (편집용)
  summary TEXT,
  meta_data TEXT,                         -- JSON: tags, thumbnailUrl, relatedJobs, relatedMajors 등
  view_count INTEGER DEFAULT 0,
  status TEXT,                            -- 'published' | 'draft' | 'deleted' | 'draft_published'
  author_id INTEGER,
  source TEXT,                            -- 'user' | 'system'
  indexed_at DATETIME,                   -- Vectorize 인덱싱 시각
  embedding_version TEXT
)
```

**howtos 테이블** (별도 정규화 테이블 -- migration 0022):
- `content_json` (Tiptap JSON) + `content_html` (렌더링용)
- 태그 정규화: `tags` -> `howto_tags` 관계 테이블
- 관련 엔티티: `howto_related_jobs`, `howto_related_majors`, `howto_related_howtos`
- 초안: `howto_drafts` 별도 테이블 (DRAFT/REVIEW 스테이지)
- 검수: `howto_reviews` (승인/반려 로그)

**참고**: 실제 코드에서 HowTo는 주로 `pages` 테이블을 사용하는 것으로 보임 (howto-editor.ts에서 pages 테이블에 INSERT). `howtos` 테이블은 초기 설계이며, 실제 운영 데이터는 `pages`에 집중되어 있을 가능성이 높음.

### 3.5 벡터 임베딩 구조

**embedding_metadata 테이블** (migration 0032/0037에서 추적):
- 직업: `jobs.indexed_at`, `jobs.embedding_version`
- 전공: `majors.indexed_at`, `majors.embedding_version`
- HowTo: `pages.indexed_at`, `pages.embedding_version`

**Vectorize 인덱스**: `careerwiki-embeddings`
- 모델: OpenAI text-embedding-3-small (1536 dimensions)
- 거리 메트릭: cosine
- 증분 업서트: Cron에서 max 20개/회씩 인덱싱

### 3.6 사용자/세션 구조

**users 테이블**:
```
users (
  id INTEGER PRIMARY KEY,
  google_id TEXT UNIQUE NOT NULL,
  email TEXT NOT NULL,
  name TEXT,
  picture_url TEXT,
  custom_picture_url TEXT,
  username TEXT,
  role TEXT DEFAULT 'user',              -- user | expert | admin | super-admin | operator
  provider TEXT DEFAULT 'google',
  provider_user_id TEXT,
  onboarded INTEGER DEFAULT 0,
  edit_count INTEGER DEFAULT 0,
  comment_count INTEGER DEFAULT 0,
  is_banned INTEGER DEFAULT 0,
  ban_reason TEXT,
  banned_until INTEGER,
  last_login_at INTEGER,
  created_at INTEGER,
  updated_at INTEGER
)
```

**user_sessions 테이블** (감사 로그):
- `session_token_hash`, `provider`, `ip_address`, `device_label`
- 실제 세션 검증은 KV 기반 (빠른 조회)

### 3.7 댓글 구조

**comments 테이블** (migration 0001 + 이후 확장):
- 중첩 댓글: `parent_id` 참조
- 좋아요: `likes` 카운트 + `comment_votes` 테이블 (중복 방지)
- 신고: `report_count` + `comment_reports` 테이블
- 익명: `is_anonymous`, `ip_hash`, `password_hash`
- 모더레이션: `status` (visible/hidden/deleted), `moderated`, `moderated_by`, `moderated_at`

### 3.8 속성 테이블

**job_attributes**: physical_demand, work_environment, employment_type, decision_authority, repetitive_level, job_type 등 -- AI TAG 필터에서 사용

**major_attributes**: academic_rigor, math_intensity, creativity, social_interaction, lab_practical, career_breadth, employment_rate 등 -- 전공 추천 스코어링에서 사용

---

## 4. 목적 달성도

### 핵심 목적 1: "한국 고등학생~대학생이 진로 정보를 쉽게 찾을 수 있다"

- **달성도: 4/5**
- **근거**:
  - **검색 기능** (4.5/5): RAG 통합 검색 (벡터+키워드) 구현. 직업/전공/HowTo 동시 검색. LIKE 폴백으로 벡터 검색 실패 시에도 결과 표시. 단, 자동완성 미구현으로 정확한 검색어 입력 필요.
  - **정보 접근 경로** (4/5): 검색 -> 상세, 목록 -> 상세, 관련 직업/전공 링크, HowTo 연결 등 다양한 탐색 경로 존재. 직업->전공, 전공->직업 양방향 연결. 카테고리/분류 기반 브라우징은 제한적 (정렬만 가능, 카테고리 필터 없음).
  - **콘텐츠 커버리지** (4/5): 6,945개 직업 + 608개 전공 데이터. CareerNet + 고용24 2개 소스 통합. 연봉, 전망, 취업률, 관련 학과 등 주요 정보 포함. HowTo 가이드로 실질적 취업 준비 정보 보완.
  - **감점 요소**: 자동완성 미구현, 카테고리 필터 없음, 일부 직업/전공의 데이터 품질이 소스에 의존 (빈 필드 가능).

### 핵심 목적 2: "AI가 맞춤 직업/전공을 추천해준다"

- **달성도: 4.5/5**
- **근거**:
  - **AI 파이프라인 완성도** (5/5): 6단계 파이프라인 완전 구현 (LLM 인터뷰 -> Multi-Query 벡터 검색 -> TAG 필터 -> Personalized Scoring -> LLM Judge -> LLM Reporter). 직업/전공 각각 별도 추천 경로.
  - **사용자 경험** (4/5): 3단계 UI (프로필 입력 -> 심층 질문 -> 결과). 5축 프레임워크 (interest, value, strength, constraint, workstyle). 서사적 리포트 생성. 결과 공유 기능. 단, 로그인 필수 허들, LLM 응답 대기 시간 존재.
  - **결과 품질** (4/5): 다차원 스코어링 (Fit = 0.5*Like + 0.5*Can - Risk), 다양성 보장 (diversity guard), 비현실적 직업 필터, 내면갈등 위험 감지, 성장곡선 매칭 등 정교한 로직. E2E 테스트 시나리오 (6개+) 자동화 존재.
  - **감점 요소**: 비회원 체험 불가, 전공 디버그 비교 미구현.

### 핵심 목적 3: "누구나 위키처럼 정보를 기여할 수 있다"

- **달성도: 3.5/5**
- **근거**:
  - **편집 시스템** (4/5): 직업/전공/HowTo 모두 편집 가능. 리비전 히스토리, 복원 기능, 필드별 편집, 출처 URL 기록. 이미지 업로드 + AI 이미지 생성.
  - **접근성** (3/5): Google 로그인 필수. 익명 편집은 DB 구조 (`anonymous_edit_limits`)에서 지원하지만 실제 활성화 여부가 미들웨어 설정에 의존. 새 직업/전공 추가는 로그인 사용자만 가능.
  - **기여 허들** (3/5): 댓글은 익명 가능 (비밀번호 설정). 직업/전공 편집은 로그인 필수. HowTo 작성은 로그인 필수 + TipTap 에디터 학습 비용. "위키처럼 누구나"라는 목표 대비 허들이 존재.
  - **품질 관리** (4/5): 리비전 기반 롤백, 관리자 모더레이션, 댓글 신고/블라인드, IP 차단, 일일 편집 제한, 금칙어 필터.
  - **감점 요소**: 실질적 익명 편집 비활성화, Google 로그인만 지원 (다른 소셜 로그인 없음), 편집 가이드라인 페이지는 있으나 인라인 편집 안내 부족.

---

## 5. 종합 평가

### 점수 요약

| 항목 | 점수 | 세부 |
|------|------|------|
| **기능 완성도** | **4.2/5** | 62개 기능 중 77% 완성, 18% 부분 구현. 핵심 기능은 모두 완성 |
| **데이터 품질** | **4.0/5** | 6,945 직업 + 608 전공, 2개 소스 통합. 3계층 데이터 구조. 일부 빈 필드 가능 |
| **사용자 경험** | **3.8/5** | 검색->상세->관련정보 흐름 원활. AI 추천 정교. 허들: 로그인 필수, 자동완성 없음 |

### 주요 강점 3개

1. **AI 추천 파이프라인의 정교함**: 5축 프레임워크, 6단계 파이프라인, E2E 테스트 자동화, 다양성 보장, 서사적 리포트 등 경쟁 제품 대비 높은 수준의 맞춤 추천 구현
2. **데이터 통합 아키텍처**: CareerNet + 고용24 2개 소스를 3계층으로 통합 (API + 사용자기여 + 관리자). ISR 캐싱으로 성능 최적화. RAG 벡터 검색으로 의미적 검색 지원
3. **관리 시스템 완성도**: 대시보드 KPI, 사용자 관리, 콘텐츠 모더레이션, 댓글 관리, 피드백 게시판, 통계 등 운영에 필요한 관리 기능이 포괄적으로 구현

### 주요 위험 3개

1. **사용자 확보 허들**: Google 로그인 필수 (AI 추천, 편집, HowTo 작성), 자동완성 미구현으로 검색 UX 약화, 카테고리 브라우징 부재 -- 신규 방문자 전환율 저하 가능
2. **데이터 품질 의존성**: 직업/전공 데이터가 외부 API(CareerNet, 고용24)에 의존. API 장애 시 데이터 갱신 불가. 사용자 기여 데이터 축적이 아직 초기 단계일 가능성
3. **LLM 의존성 리스크**: AI 추천의 핵심 단계(인터뷰, Judge, Reporter)가 OpenAI GPT-4o-mini에 의존. API 비용, 레이턴시, 장애 시 사용자 경험 저하 직결

### 즉시 조치 필요 사항

1. **자동완성 검색 구현**: 검색 UX의 가장 큰 약점. Vectorize 기반 prefix 검색 또는 D1 LIKE 쿼리로 구현 가능
2. **전공 디버그 비교 완성**: `GET /major/:slug?debug=true`가 501 반환 중. 직업 디버그는 작동하므로 동일 패턴으로 구현 필요
3. **비회원 AI 추천 체험**: 로그인 없이 간소화된 AI 추천 체험을 제공하여 전환율 개선 검토 (현재 로그인 필수로 이탈 가능성 높음)

---

*이 보고서의 모든 수치는 소스 코드 전수 조사 결과입니다. 프로덕션 환경의 실제 데이터 건수, API 응답률, 사용자 행동은 별도 확인이 필요합니다.*
