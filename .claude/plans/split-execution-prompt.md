# index.tsx 분리 실행 프롬프트 (최종)

> Agent Teams 사용하지 말 것. 단일 에이전트가 순차 작업해야 충돌 없음.
> 각 Phase는 별도 세션에서 실행. 유저가 프로덕션 확인 후 다음 Phase 진행.

---

## Phase 0 — 공유 모듈 추출

```
## 목표
src/index.tsx (35,000줄+)를 여러 파일로 안전하게 분리하는 프로젝트의 Phase 0.
공유 타입과 유틸리티 함수를 별도 모듈로 추출해서, 이후 Phase에서 라우트 파일을 분리할 기반을 만든다.

## 작업 전 필수 확인
1. `.claude/plans/index-tsx-split-plan.md` 를 읽어서 전체 계획 파악
2. `src/index.tsx`를 읽어서 현재 코드 상태 파악 (라인 번호는 계획서와 다를 수 있음)
3. 기존 추출 패턴 참고: `src/routes/auth.ts`와 `src/services/ai-analyzer/routes.ts` 를 읽어

## 작업 절차 (이 순서를 반드시 따라)

### Step 1: `src/types/app.ts` 생성

index.tsx에서 다음 타입/인터페이스 **정의를 찾아서** 새 파일로 이동:
- `type Bindings = { DB: D1Database; ... }` — Cloudflare 바인딩 타입 전체
- `interface User { id: number; ... }` — 사용자 인터페이스 전체
- `type Variables = { title?: string; ... }` — Hono context variables
- `type RequestUser = { id: string; ... }` — 댓글 시스템용 사용자 타입

추가로 정의:
```typescript
export type AppEnv = { Bindings: Bindings; Variables: Variables }
```

index.tsx에서 해당 정의 삭제 후 import로 대체:
```typescript
import type { Bindings, Variables, User, AppEnv, RequestUser } from './types/app'
```

`const app = new Hono<{ Bindings: Bindings; Variables: Variables }>()` → `const app = new Hono<AppEnv>()` 로 변경.

**검증**: `npx tsc --noEmit` 통과 확인. 실패하면 수정 후 재확인.

### Step 2: `src/utils/shared-helpers.ts` 생성

index.tsx에서 다음 함수/상수들을 **이름으로 grep해서 찾아** 새 파일로 이동.
함수명 목록 (이름으로 검색해서 정의 위치를 찾을 것):

**미들웨어/인프라 함수:**
- `isDevEnv`

**레이아웃/UI 함수:**
- `renderUserMenu` — 주의: 내부에서 User 타입 사용
- `getLogoImage`
- `getLogoSVG` (getLogoImage의 alias)
- `isAdminRole`
- `renderLayout` — 주의: 내부에서 renderUserMenu, getLogoImage 호출. 같은 파일에 있어야 함
- `renderLayoutWithContext` — renderLayout의 래퍼. 반드시 같은 파일에

**URL/SEO 함수:**
- `SOURCE_LABEL_MAP` (상수)
- `DEFAULT_CANONICAL_ORIGIN` (상수)
- `buildCanonicalUrl`

**타입 가드:**
- `isAnalysisType`, `isPricingTier`, `isRequestStatus`, `isPageType`

**유틸리티:**
- `buildCommentPageSlug`, `cleanGuidePrefix`, `toParentId`
- `getClientIp`
- `parseSourcesQuery`, `parseNumberParam`, `toIntegerOrNull`
- `formatEmploymentRate`, `formatDateSafe`
- `escapeHtml` — 주의: index.tsx 내에 여러 번 정의될 수 있음. 모두 찾아서 하나로 통합
- `serializeForScript`, `createMetaDescription`
- `getOptionalUser` — RequestUser 타입 의존
- `maskIpForDisplay`, `toHex`, `hashIpAddress`

각 함수가 index.tsx 내에서 호출되는 모든 곳에 import 추가.

**검증**: `npx tsc --noEmit` 통과 확인.

### Step 3: `src/utils/card-renderers.ts` 생성

다음 함수들을 index.tsx에서 이동 (함수명으로 grep):

- `SampleHighlight` (타입)
- `getSatisfactionGrade`, `formatJobSummaryText`, `formatMajorSummaryText`, `formatSkillYear`
- `renderJobCard`, `renderMajorCard`
- `renderDetailFallback`
- `renderSampleHighlightBadges`, `renderSampleHighlightCards`
- `describeSkipReason`
- `renderSourceStatusSummary`, `renderCacheNotice` (commented out이라도 보존)
- `createKeywordsMetaTag`, `createArticleModifiedMeta`
- `renderSampleJobDetailPage`, `renderSampleMajorDetailPage`, `renderSampleHowtoDetailPage`
- `createHowtoJsonLd`

이 함수들이 shared-helpers.ts의 함수들(escapeHtml 등)을 사용하면 해당 import 추가.

**검증**: `npx tsc --noEmit` 통과 확인.

### Step 4: 최종 검증 및 커밋

```bash
npx tsc --noEmit     # 타입 에러 0개
npm run build        # 빌드 성공
npm run deploy       # 배포
```

커밋 메시지: `refactor: Phase 0 - 공유 타입/유틸리티를 별도 모듈로 추출`

배포 후 careerwiki.org에서 최소 확인:
- 홈페이지 `/` 정상 로딩
- `/job` 목록 페이지 정상
- `/analyzer` 페이지 정상
- 아무 직업 상세 페이지 정상

## 핵심 원칙
- **동작 변경 금지**: 코드 이동만. 리팩토링/개선/정리 하지 마.
- **tsc 실패 시 즉시 수정**: 다음 Step으로 넘어가지 마.
- **확신 없으면 물어봐**: 순환 참조나 의존성이 복잡하면 나에게 확인.
- **라인 번호 의존 금지**: 반드시 함수명/타입명으로 검색해서 현재 위치 확인.
```

---

## Phase 1 — 저위험 라우트 추출

```
## 목표
Phase 0에서 공유 모듈을 추출했으니, 이제 독립적인 API/페이지 라우트를 별도 파일로 추출한다.
6개 파일을 하나씩 만들고, 매번 tsc 체크. 전부 완료 후 빌드+배포.

## 작업 전 필수 확인
1. `.claude/plans/index-tsx-split-plan.md` 전체 계획서 읽기
2. `src/index.tsx` 현재 상태 읽기 (Phase 0 이후 변경됨)
3. `src/types/app.ts`, `src/utils/shared-helpers.ts`, `src/utils/card-renderers.ts` 확인 (Phase 0 결과물)
4. `src/routes/auth.ts` 읽어서 기존 추출 패턴 확인

## 새 라우트 파일 공통 패턴

```typescript
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
// 필요한 middleware, service, utils import

const xxxRoutes = new Hono<AppEnv>()

xxxRoutes.get('/path', async (c) => { ... })
// ... 라우트 핸들러들

export { xxxRoutes }
```

index.tsx에서 등록: `app.route('', xxxRoutes)` (prefix 없이 full path 유지)
또는: `app.route('/prefix', xxxRoutes)` (prefix 있으면 내부에서 상대 경로)

## 작업 순서 (하나씩 순서대로)

### 1-1. `src/routes/share.ts`

index.tsx에서 검색해서 추출:
- `app.get('/share/:token'` 핸들러
- `app.get('/share/:token/og.png'` 핸들러
- 관련 로컬 함수: `translateTag`, `renderShareCard`, `renderShareGonePage`, `renderOgSvg`
- 관련 상수: `BOT_UA_PATTERN`, `SHARE_TAG_LABELS`

index.tsx에서 삭제 후 `app.route('', shareRoutes)` 추가.
**tsc 확인** 후 다음으로.

### 1-2. `src/routes/comments.ts`

index.tsx에서 검색해서 추출:
- `/api/comments` 관련 모든 라우트 (GET/POST/PATCH/DELETE)
- `/api/comments/ip-blocks` 관련 모든 라우트
- 관련 로컬 함수: `mapRoleForComments`

주의: 이 라우트들은 미들웨어(requireAuth 등) 없이, 내부에서 `getOptionalUser()`로 직접 인증 체크함. 이 패턴 그대로 유지.
**tsc 확인** 후 다음으로.

### 1-3. `src/routes/feedback.ts`

index.tsx에서 검색해서 추출:
- `app.get('/feedback'` 페이지 2개 (목록, 상세)
- `/api/feedback` 관련 모든 API 라우트
- `/api/admin/feedback` 관련 라우트도 포함

**tsc 확인** 후 다음으로.

### 1-4. `src/routes/upload.ts`

index.tsx에서 검색해서 추출:
- `/api/upload` 관련 3개 라우트
- `/uploads/*` GET (R2 파일 서빙)
- `/api/image/*` 관련 라우트 (generate, status, save)
- `/webhooks/image-completed` 핸들러

**tsc 확인** 후 다음으로.

### 1-5. `src/routes/content-editor.ts`

가장 큰 추출. index.tsx에서 검색해서 추출:
- `/api/user/username` PATCH
- `/api/admin/seed-jobs`, `/api/admin/reseed-empty-majors`
- `/api/job/create`, `/api/job/:id/edit`, DELETE, restore, hidden
- `/api/major/create`, `/api/major/:id/edit`, DELETE, restore, hidden
- `/api/admin/job`, `/api/admin/major`
- `/api/howto` POST, `/api/howto/:slug/edit` POST, `/api/howto/:slug/report`
- `/api/slug/*`, `/api/search/*` 유효성 검증 라우트
- `/api/tags/popular`
- `/api/howto/drafts/*` 전체 (CRUD)
- `/api/howto/publish-direct`, `/api/howto/:pageId/publish-final`, `/api/howto/save-publish`
- `/api/howto/check-title`, `/api/job/check-name`, `/api/major/check-name`
- `/api/admin/howto/*` 전체
- `/api/revision/*` 전체, `/api/job/:id/revisions`, `/api/major/:id/revisions`, `/api/howto/:slug/revisions`
- `/api/job/:id/refetch-api-data`, `/api/job/:id/reset-contributions`
- `/similar-names` GET, `/api/similar-names/*`, `/api/name-mappings/*`
- `/api/job/categories`, `/api/major/categories`

이 라우트들을 한번에 추출하기 어려우면 2~3번에 나눠서 해도 됨. 중요한 건 매번 tsc 통과.
**tsc 확인** 후 다음으로.

### 1-6. `src/routes/admin.ts`

index.tsx에서 검색해서 추출:
- `/admin` GET (메인 대시보드 페이지)
- `/admin/ai-analyzer` GET — 주의: `adminAiApi`를 `.route()`로 마운트하는 부분 포함
- `/admin/feedback`, `/admin/feedback/:id` GET 페이지
- `/admin/users`, `/admin/users/:id` GET 페이지
- `/api/admin/users/:id/comments` GET, `/api/admin/users/:id` PATCH
- `/admin/content` GET 페이지
- `/api/admin/revisions` GET
- `/api/admin/comments/*` 관련 6개 moderation 라우트
- `/api/admin/revisions/:id/restore`
- `/admin/stats` GET, `/api/admin/stats` GET

**tsc 확인** 후 최종 검증.

### 최종 검증 및 커밋

```bash
npx tsc --noEmit     # 타입 에러 0개
npm run build        # 빌드 성공
npm run deploy       # 배포
```

커밋 메시지: `refactor: Phase 1 - 저위험 라우트 6개 파일로 추출`

배포 후 확인해야 할 것:
- /feedback 페이지 → 피드백 작성
- /admin 관리자 페이지
- 아무 직업/전공 상세 페이지에서 댓글 작성/삭제
- /api/jobs 응답
- 이미지 업로드 (직업 편집 페이지에서)

결과 보고해줘.

## 핵심 원칙 (반복)
- **동작 변경 금지**: 코드 이동만.
- **tsc 실패 시 즉시 수정**.
- **라인 번호 의존 금지**: 함수명/경로 문자열로 검색.
- **라우트 등록 순서 주의**: 정적 경로가 동적 경로(:param)보다 먼저 등록되어야 함.
- **Hono sub-app의 미들웨어**: global middleware(authMiddleware 등)는 메인 app에 이미 등록되어 있으므로 sub-app에서도 `c.get('user')`가 동작함. 단, `requireAuth` 같은 개별 미들웨어는 각 라우트에 명시적으로 붙여야 함.
```

---

## Phase 2 — 콘텐츠 페이지 추출

```
## 목표
Phase 0(공유 모듈), Phase 1(저위험 API)이 완료된 상태.
이제 HTML을 렌더링하는 콘텐츠 페이지들을 추출한다. 6개 파일.

## 작업 전 필수 확인
1. `.claude/plans/index-tsx-split-plan.md` 전체 계획서 읽기
2. `src/index.tsx` 현재 상태 읽기
3. Phase 0-1에서 만든 파일들 확인: `types/app.ts`, `utils/shared-helpers.ts`, `utils/card-renderers.ts`, `routes/*.ts`

## 작업 순서

### 2-1. `src/routes/howto.ts` (가장 큰 추출, ~3,600줄)

index.tsx에서 `/howto` 관련 모든 페이지 라우트 추출:
- `app.get('/howto'` — 목록 페이지
- `app.get('/howto/my-drafts'` — 내 초안
- `app.get('/howto/write'` — 작성 (TipTap 에디터 포함, 큰 핸들러)
- `app.get('/howto/draft/:id'` — 초안 편집 (큰 핸들러)
- `app.get('/howto/:slug/edit'` — 게시글 편집
- `app.get('/howto/:slug'` — 상세 페이지

`app.route('/howto', howtoRoutes)` 로 마운트하므로, 내부 경로에서 `/howto` 제거:
```typescript
howtoRoutes.get('/', ...)           // /howto
howtoRoutes.get('/my-drafts', ...)  // /howto/my-drafts
howtoRoutes.get('/write', ...)      // /howto/write
howtoRoutes.get('/draft/:id', ...)  // /howto/draft/:id
howtoRoutes.get('/:slug/edit', ...) // /howto/:slug/edit
howtoRoutes.get('/:slug', ...)      // /howto/:slug
```

**경고 - 라우트 순서 중요!**: `/my-drafts`, `/write` 같은 정적 경로가 `/:slug` 동적 경로보다 먼저 등록되어야 "my-drafts"가 slug로 잡히지 않음.

`/user/drafts` GET (리다이렉트)은 howto와 무관하게 user 라우트이므로 여기 포함하지 마.

주의: `/api/howto/*` API 라우트들은 이미 Phase 1에서 content-editor.ts로 이동했음. 여기서는 페이지(GET HTML) 라우트만 추출.

**tsc 확인** 후 다음으로.

### 2-2. `src/routes/search.ts` (~700줄)

- `app.get('/search'` 핸들러

의존성: `renderJobCard`, `renderMajorCard`는 `card-renderers.ts`에서 import.
`ragSearchUnified`는 `services/rag-search`에서 import.

**tsc 확인** 후 다음으로.

### 2-3. `src/routes/job-detail.ts` (~600줄)

- `app.get('/job/:slug'` 핸들러

ISR 캐시 로직(`withKvCache` 등), `renderUnifiedJobDetail`, `createJobJsonLd` import 필요.

**tsc 확인** 후 다음으로.

### 2-4. `src/routes/major-detail.ts` (~600줄)

- `app.get('/major/:slug'` 핸들러
- `app.get('/majors/:id'` 레거시 리다이렉트 핸들러

**tsc 확인** 후 다음으로.

### 2-5. `src/routes/job-list.ts` (~500줄)

- `app.get('/job'` 핸들러 (목록 페이지, `/job/:slug`와 다름)

**tsc 확인** 후 다음으로.

### 2-6. `src/routes/major-list.ts` (~500줄)

- `app.get('/major'` 핸들러 (목록 페이지)

**tsc 확인** 후 최종 검증.

### 최종 검증 및 커밋

```bash
npx tsc --noEmit && npm run build && npm run deploy
```

커밋: `refactor: Phase 2 - 콘텐츠 페이지 6개 파일로 추출`

확인 항목:
- /howto → /howto/write (로그인 후) → /howto/[아무슬러그]
- /search?q=개발자
- /job → /job/[아무슬러그]
- /major → /major/[아무슬러그]
- 각 페이지 OG meta 태그 정상 (view-source로)

결과 보고해줘.

## 핵심 원칙 (반복)
- 동작 변경 금지. 코드 이동만.
- tsc 실패 시 즉시 수정.
- 라우트 등록 순서 주의.
```

---

## Phase 3 — 대형 분석기 + 잔여 라우트 + 마무리

```
## 목표
Phase 0-2 완료 후, 남은 모든 라우트를 추출하여 index.tsx를 ~300줄로 축소. 최종 마무리.

## 작업 전 필수 확인
1. `.claude/plans/index-tsx-split-plan.md` 전체 계획서 읽기
2. `src/index.tsx` 현재 상태 읽기 — 어떤 라우트가 남아있는지 확인
3. 기존 `src/routes/` 파일들 목록 확인

## 작업 순서

### 3-1. `src/routes/analyzer-job-page.ts` (약 10,000줄)

index.tsx에서 `app.get('/analyzer/job'` 핸들러 전체를 새 파일로 이동.

**절대 주의**: 이 핸들러는 10,000줄짜리 거대한 template literal을 포함. 내부 구조는 한 글자도 변경하지 마. 있는 그대로 복사-이동만.

```typescript
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'

const analyzerJobPage = new Hono<AppEnv>()
analyzerJobPage.get('/', requireAuth, async (c) => {
  // 기존 핸들러 본문 전체
})
export { analyzerJobPage }
```

index.tsx: `app.route('/analyzer/job', analyzerJobPage)`

핸들러 내부에서 사용하는 모든 import를 새 파일 상단에 추가해야 함. 특히:
- `career-tree-types` 상수들 (ROLE_IDENTITY_OPTIONS 등)
- `ai-analyzer` 서비스 함수들
- `profileDataService` 함수들
- `shared-helpers`와 `card-renderers`에서 필요한 것들

**tsc 확인** 후 다음으로.

### 3-2. `src/routes/analyzer-major-page.ts` (약 5,000줄)

index.tsx에서 `app.get('/analyzer/major'` 핸들러 + 관련 상수들(STAGE_LABELS_M 등) 이동.
동일한 전략. 내부 변경 금지.

**tsc 확인** 후 다음으로.

### 3-3. `src/routes/user.ts` (약 1,500줄)

index.tsx에서 `/user/*` 관련 페이지 + API 추출:
- `app.get('/user'`, `/user/profile`, `/user/ai-results`, `/user/comments`, `/user/bookmarks`, `/user/settings`, `/user/security`
- `app.post('/api/user/profile-image'`, `app.delete('/api/user/profile-image'`
- `/api/user/sessions/*` 라우트들
- `/api/bookmark/*` 라우트들
- `/user/drafts` GET (리다이렉트)

**tsc 확인** 후 다음으로.

### 3-4. `src/routes/api-data.ts` (약 1,500줄)

index.tsx에서 데이터 조회 API 추출:
- `/api/jobs`, `/api/jobs/search`, `/api/jobs/:id`
- `/api/majors`, `/api/majors/search`, `/api/majors/:id`
- `/api/job/:id/edit-data`, `/api/major/:id/edit-data`
- `/api/categories`
- `/api/job/cards`, `/api/major/cards`

**tsc 확인** 후 다음으로.

### 3-5. `src/routes/api-misc.ts` (약 500줄)

남은 API 라우트:
- `/api/me`, `/api/client-ip`, `/api/perf-metrics`
- `/api/serp-interactions/*`, `/api/freshness/*`
- `/api/analyzer/sessions/*`, `/api/analyzer/requests/*`
- 함께 이동: `formatPerfAlertLine`, `sendPerfAlertsToSlack`

**tsc 확인** 후 다음으로.

### 3-6. `src/routes/pages.ts` (약 500줄)

남은 페이지 라우트 전부:
- `/` 홈페이지
- `/analyzer` 인트로
- `/login`
- `/legal/terms`, `/legal/privacy`
- `/help`, `/help/community-guidelines`
- `/onboarding` + `/api/me/onboarding` + `/api/onboarding` + `/api/nickname/check`
- `/releases`
- `/terms`, `/privacy` 리다이렉트
- `/robots.txt`, `/sitemap.xml`
- template-design 실험용 라우트들
- `/api/debug/bindings`

**tsc 확인** 후 다음으로.

### 3-7. index.tsx 최종 정리

index.tsx에 남아야 하는 것:
1. Hono + middleware import
2. 모든 route 파일 import
3. `const app = new Hono<AppEnv>()`
4. Global middleware 등록 (순서 유지!):
   - www→non-www 리다이렉트
   - cors()
   - renderer
   - errorLoggingMiddleware
   - timingMiddleware
   - apiCacheHintMiddleware
   - static file serving (/static/*, /images/*)
   - authMiddleware
5. `app.route(...)` 호출들 (~20개)
6. `export default app`
7. `export const scheduled` (cron handler — 이건 index.tsx에 유지)

**나머지 코드가 있으면 안 됨.** 라우트 핸들러, 함수 정의, 상수 정의가 남아있지 않은지 꼼꼼히 확인.

### 최종 검증

```bash
npx tsc --noEmit && npm run build && npm run deploy
```

커밋: `refactor: Phase 3 - index.tsx 35K→300줄 분리 완료`

전체 기능 확인:
- 홈페이지 `/`
- /analyzer/job (로그인 후 Step 1~4 전체 플로우)
- /analyzer/major (로그인 후)
- /job, /major, /howto 목록
- /job/[slug], /major/[slug], /howto/[slug] 상세
- /search?q=프로그래머
- /feedback
- /admin (admin 로그인)
- /user (일반 로그인)
- 댓글 CRUD
- 이미지 업로드
- /robots.txt, /sitemap.xml

결과 보고해줘. 이걸로 전체 프로젝트 완료!

## 핵심 원칙 (최종)
- 동작 변경 금지. 코드 이동만.
- tsc 실패 시 즉시 수정.
- 분석기 페이지 핸들러 내부 절대 변경 금지.
- scheduled handler는 index.tsx에 유지.
```

---

## 롤백 방법 (문제 발생 시)

```bash
# 해당 Phase 커밋 되돌리기
git revert HEAD
npm run build && npm run deploy

# 더 심각한 경우
git log --oneline -5
git checkout [이전커밋] -- src/
npm run build && npm run deploy
```
