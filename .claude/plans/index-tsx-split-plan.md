# index.tsx 안전 분리 계획서

## 현재 상태
- **파일**: `src/index.tsx` — **35,453줄**
- **라우트 수**: 204개 (GET/POST/PUT/DELETE/PATCH)
- **이미 분리된 것**: `routes/auth.ts`, `services/ai-analyzer/routes.ts` + 하위 5개
- **목표**: index.tsx를 ~2,000줄(라우트 등록 + 미들웨어)로 축소

---

## 선행 작업: 공유 모듈 추출 (Phase 0)

> **왜 먼저?**: 모든 라우트 파일이 공유 함수/타입을 import해야 하므로, 이것을 먼저 만들지 않으면 순환 참조나 누락이 발생함.

### 0-1. `src/types/app.ts` — 앱 공통 타입 추출

index.tsx에서 정의된 타입들을 추출:

```typescript
// src/types/app.ts (신규 생성)
import type { D1Database, KVNamespace, R2Bucket, VectorizeIndex, Ai } from '@cloudflare/workers-types'

export type Bindings = {
  DB: D1Database;
  KV: KVNamespace;
  UPLOADS: R2Bucket;
  VECTORIZE: VectorizeIndex;
  AI: Ai;
  CAREER_NET_API_KEY?: string;
  GOYONG24_MAJOR_API_KEY?: string;
  GOYONG24_JOB_API_KEY?: string;
  PERF_ALERT_WEBHOOK?: string;
  ADMIN_SECRET?: string;
  ENVIRONMENT?: string;
  EVOLINK_API_KEY?: string;
  GOOGLE_CLIENT_ID: string;
  GOOGLE_CLIENT_SECRET: string;
  GOOGLE_CALLBACK_URL: string;
  JWT_SECRET: string;
  CLOUDFLARE_ACCOUNT_ID?: string;
  CLOUDFLARE_API_TOKEN?: string;
  CF_ACCOUNT_ID?: string;
  CF_ZONE_ID?: string;
  CF_PAGES_API_TOKEN?: string;
  GITHUB_TOKEN?: string;
  GOOGLE_SITE_VERIFICATION?: string;
  OPENAI_API_KEY?: string;
}

export interface User {
  id: number;
  google_id: string;
  provider?: string;
  provider_user_id?: string;
  email: string;
  name: string | null;
  picture_url: string | null;
  custom_picture_url: string | null;
  role: 'user' | 'expert' | 'admin';
  username: string | null;
  ban_reason: string | null;
  onboarded?: number;
  created_at: string;
  updated_at: string;
}

export type Variables = {
  title?: string;
  description?: string;
  user?: User | null;
  mark?: (key: string) => void;
}

export type AppEnv = { Bindings: Bindings; Variables: Variables }

export type RequestUser = {
  id: string;
  role: import('../services/commentService').UserRole;
  name?: string | null;
  username?: string | null;
  picture_url?: string | null;
  custom_picture_url?: string | null;
}
```

**index.tsx 변경**: 타입 정의 삭제 → `import type { Bindings, Variables, User, AppEnv } from './types/app'`

**검증 포인트**:
- `const app = new Hono<AppEnv>()` — 기존과 동일하게 동작
- `routes/auth.ts`가 현재 `CloudflareBindings`를 쓰고 있으므로 영향 없음 (별도 타입)
- `services/ai-analyzer/routes.ts`도 자체 `Bindings` 인터페이스를 쓰므로 영향 없음

---

### 0-2. `src/utils/shared-helpers.ts` — 공유 유틸리티 함수 추출

**15개 이상의 라우트에서 사용되는 함수들** (반드시 공유 모듈로):

| 함수명 | 현재 위치 (line) | 사용 횟수 | 사용 라우트 그룹 |
|--------|-----------------|----------|-----------------|
| `renderLayout()` | 1274 | 2 | Homepage, Analyzer intro |
| `renderLayoutWithContext()` | 2460 | 52+ | 거의 모든 페이지 |
| `renderUserMenu()` | 1201 | 9 | Legal, Feedback, Releases, Layout |
| `getLogoImage()` | 1258 | 3 | Layout 내부 |
| `getLogoSVG` | 1268 | alias | Layout 내부 |
| `isAdminRole()` | 1270 | 6 | Feedback, Analyzer, Admin |
| `escapeHtml()` | 24315 | 70+ | 거의 모든 페이지 |
| `buildCanonicalUrl()` | 2333 | 11 | List, Detail, Search |
| `getOptionalUser()` | 25272 | 17 | List, Detail, Comments, Edit |
| `getClientIp()` | 2376 | 4 | Comments, Client IP API |
| `parseNumberParam()` | 24241 | 21 | 모든 페이징 라우트 |
| `parseSourcesQuery()` | 24224 | 12 | Job/Major List, Detail, API |
| `createMetaDescription()` | 24328 | 10 | List, Detail, Search |
| `serializeForScript()` | 24322 | 3 | Job/Major/HowTo List |
| `formatDateSafe()` | 24307 | 3 | Drafts, Comments |
| `hashIpAddress()` + `toHex()` | 25306/25313 | 8 | Comments, Perf, Edit |
| `maskIpForDisplay()` | 25290 | 2 | Comments |

**5개 미만 라우트에서만 쓰이는 함수 (해당 라우트 파일에 이동)**:

| 함수명 | 현재 위치 | 이동 목적지 |
|--------|----------|-----------|
| `mapRoleForComments()` | 25250 | → `routes/comments.ts` |
| `formatPerfAlertLine()` | 25320 | → `routes/api-misc.ts` |
| `sendPerfAlertsToSlack()` | 25338 | → `routes/api-misc.ts` |
| `renderShareCard()` | 465 | → `routes/share.ts` |
| `renderShareGonePage()` | 686 | → `routes/share.ts` |
| `renderOgSvg()` | 769 | → `routes/share.ts` |
| `translateTag()` | 454 | → `routes/share.ts` |

---

### 0-3. `src/utils/card-renderers.ts` — 카드/렌더링 함수 추출

| 함수명 | 현재 위치 | 사용 라우트 |
|--------|----------|-----------|
| `renderJobCard()` | 24424 | `/job`, `/search`, `/api/job/cards` |
| `renderMajorCard()` | 24645 | `/major`, `/howto`, `/search`, `/api/major/cards` |
| `renderDetailFallback()` | 24831 | `/howto/:slug`, `/job/:slug`, `/major/:slug`, `/majors/:id` |
| `renderSampleHighlightBadges()` | 24863 | Homepage |
| `renderSampleHighlightCards()` | 24872 | Homepage |
| `renderSampleJobDetailPage()` | 25056 | Sample pages |
| `renderSampleMajorDetailPage()` | 25107 | Sample pages |
| `renderSampleHowtoDetailPage()` | 25149 | Sample pages |
| `createHowtoJsonLd()` | 25195 | HowTo detail |
| `createKeywordsMetaTag()` | 25042 | Detail pages |
| `createArticleModifiedMeta()` | 25049 | Detail pages |
| `formatJobSummaryText()` | 24364 | Job card |
| `formatMajorSummaryText()` | 24373 | Major card |
| `formatSkillYear()` | 24382 | Job detail |
| `formatEmploymentRate()` | 24284 | Job detail |
| `getSatisfactionGrade()` | 24346 | Job detail |
| `toIntegerOrNull()` | 24265 | Helper |
| `describeSkipReason()` | 24938 | Error pages |
| `renderSourceStatusSummary()` | 24953 | (commented out, 보류) |
| `renderCacheNotice()` | 24994 | (commented out, 보류) |
| `SampleHighlight` type | 24856 | Homepage |

---

### 0-4. `src/utils/constants.ts` — 공유 상수 추출

| 상수명 | 현재 위치 | 사용 라우트 |
|--------|----------|-----------|
| `SOURCE_LABEL_MAP` | 2320 | Detail pages |
| `DEFAULT_CANONICAL_ORIGIN` | 2331 | buildCanonicalUrl() |
| `BOT_UA_PATTERN` | 326 | → `routes/share.ts`로 이동 (share 전용) |

---

## Phase 0 완료 검증

```
Phase 0 완료 후 index.tsx 상태:
- 타입 정의 제거됨 (→ types/app.ts)
- 공유 함수 제거됨 (→ utils/shared-helpers.ts, utils/card-renderers.ts, utils/constants.ts)
- 라우트 핸들러는 그대로
- 빌드/타입체크 통과 확인 필수
```

**검증 명령**:
```bash
npx tsc --noEmit    # 타입 에러 없음
npm run build       # 빌드 성공
npm run deploy      # 배포 후 careerwiki.org 정상 확인
```

---

## Phase 1: 저위험 라우트 추출 (~10,000줄 제거)

### 1-1. `src/routes/share.ts` (~400줄)

**추출 라우트**:
| Method | Path | Line | Middleware |
|--------|------|------|-----------|
| GET | `/share/:token` | 328 | None |
| GET | `/share/:token/og.png` | 722 | None |

**함께 이동하는 함수**: `translateTag()`, `renderShareCard()`, `renderShareGonePage()`, `renderOgSvg()`, `BOT_UA_PATTERN`, `SHARE_TAG_LABELS`

**의존성**:
- `svgToPng`, `getCachedOgImage`, `cacheOgImage` ← `services/ogImageService`
- `getAnalysisRequestWithResult` ← `services/aiAnalysisService`
- `renderLayoutWithContext` ← `utils/shared-helpers`
- `escapeHtml` ← `utils/shared-helpers`
- `Bindings`, `Variables`, `AppEnv` ← `types/app`

**패턴**: `const shareRoutes = new Hono<AppEnv>()`

**index.tsx 변경**: `app.route('', shareRoutes)` (prefix 없음, 경로가 `/share/...`로 시작하므로)

---

### 1-2. `src/routes/comments.ts` (~700줄)

**추출 라우트**:
| Method | Path | Line | Middleware |
|--------|------|------|-----------|
| GET | `/api/comments` | 25664 | None |
| POST | `/api/comments` | 25725 | None |
| POST | `/api/comments/:id/like` | 25812 | None |
| PATCH | `/api/comments/:id` | 25868 | None |
| DELETE | `/api/comments/:id` | 25919 | None |
| POST | `/api/comments/:id/flag` | 25964 | None |
| GET | `/api/comments/ip-blocks` | 26017 | None |
| POST | `/api/comments/ip-blocks` | 26033 | None |
| POST | `/api/comments/ip-blocks/:hash/release` | 26076 | None |

**함께 이동하는 함수**: `mapRoleForComments()`

**의존성**:
- `getOptionalUser`, `getClientIp`, `hashIpAddress`, `maskIpForDisplay`, `escapeHtml` ← `utils/shared-helpers`
- `buildCommentGovernanceItems`, `resolveCommentPolicy` ← `templates/detailTemplateUtils`
- Comment service functions ← `services/commentService`

**주의**: Comments는 미들웨어 없이 내부에서 `getOptionalUser()`로 직접 인증 체크. 이 패턴 유지 필수.

---

### 1-3. `src/routes/feedback.ts` (~500줄)

**추출 라우트**:
| Method | Path | Line | Middleware |
|--------|------|------|-----------|
| GET | `/feedback` | 930 | None |
| GET | `/feedback/:id` | 965 | None |
| POST | `/api/feedback` | 25435 | requireAuth |
| GET | `/api/feedback` | 25461 | None |
| GET | `/api/feedback/:id` | 25492 | None |
| POST | `/api/feedback/:id/reply` | 25512 | requireAdmin |
| PUT | `/api/feedback/:id/reply` | 25536 | requireAdmin |
| DELETE | `/api/feedback/:id/reply` | 25560 | requireAdmin |
| DELETE | `/api/admin/feedback/:id` | 25574 | requireAdmin |
| POST | `/api/feedback/:id/comments` | 25588 | requireAuth |
| DELETE | `/api/feedback/comments/:id` | 25627 | requireAuth |
| PATCH | `/api/feedback/:id/visibility` | 25649 | requireAdmin |
| PATCH | `/api/admin/feedback/:id/status` | 34840 | requireAdmin |

**의존성**:
- `renderLayoutWithContext`, `renderUserMenu`, `escapeHtml`, `isAdminRole`, `parseNumberParam` ← 공유 모듈
- `requireAuth`, `requireAdmin` ← `middleware/auth`
- Feedback service ← `services/feedbackService`

---

### 1-4. `src/routes/upload.ts` (~700줄)

**추출 라우트**:
| Method | Path | Line | Middleware |
|--------|------|------|-----------|
| POST | `/api/upload` | 33094 | requireAuth |
| POST | `/api/upload/prepare` | 33151 | requireAuth |
| POST | `/api/upload/file` | 33196 | requireAuth |
| GET | `/uploads/*` | 33252 | None |
| POST | `/api/image/generate` | 33355 | requireAuth |
| GET | `/api/image/status/:taskId` | 33459 | requireAuth |
| POST | `/api/image/save` | 33502 | requireAuth |
| POST | `/webhooks/image-completed` | 33661 | None |

**의존성**:
- `requireAuth` ← `middleware/auth`
- R2 upload 로직은 자체 완결적

---

### 1-5. `src/routes/content-editor.ts` (~4,800줄)

**추출 라우트**: Job/Major/HowTo 편집 관련 모든 API

| Category | Routes | Lines |
|----------|--------|-------|
| User Settings | PATCH `/api/user/username` | 29842 |
| Admin Seed | POST `/api/admin/seed-jobs`, `/api/admin/reseed-empty-majors` | 29870, 29925 |
| Job CRUD | POST `/api/job/create`, `/api/job/:id/edit`, DELETE, restore, hidden | 30057-30494 |
| Major CRUD | POST `/api/major/create`, `/api/major/:id/edit`, DELETE, restore, hidden | 30686-31162 |
| Admin Job/Major | POST `/api/admin/job`, `/api/admin/major` | 31009, 31091 |
| HowTo CRUD | POST/GET/PUT/DELETE `/api/howto/drafts/*` | 31723-32201 |
| HowTo Publish | POST `/api/howto/publish-direct`, etc. | 32224-32627 |
| Slug/Search validation | GET `/api/slug/*`, `/api/search/*` | 31597-31682 |
| Check names | GET `/api/howto/check-title`, `/api/job/check-name`, `/api/major/check-name` | 31799-31997 |
| HowTo operations | POST `/api/howto`, `/api/howto/:slug/edit`, `/api/howto/:slug/report` | 31474-33767 |
| Admin HowTo | GET/POST `/api/admin/howto/*` | 33004-33897 |
| Revisions | GET/POST `/api/revision/*`, `/api/job/:id/revisions`, etc. | 33921-34267 |
| Job refetch | POST `/api/job/:id/refetch-api-data`, `/api/job/:id/reset-contributions` | 34456-34573 |
| Name mappings | GET/POST/DELETE `/api/name-mappings/*` | 35369-35432 |

**의존성**:
- `requireAuth`, `requireAdmin`, `requireJobMajorEdit`, `requireHowToEdit` ← `middleware/auth`
- `getOptionalUser`, `escapeHtml`, `parseNumberParam` ← 공유 모듈
- `editService`, `profileDataService` ← services

---

### 1-6. `src/routes/admin.ts` (~700줄)

**추출 라우트**: Admin 페이지 (HTML) + Admin API

| Method | Path | Line | Middleware |
|--------|------|------|-----------|
| GET | `/admin` | 34659 | requireAdmin |
| GET | `/admin/ai-analyzer` | 34738 | None* |
| GET | `/admin/feedback` | 34785 | requireAdmin |
| GET | `/admin/feedback/:id` | 34805 | requireAdmin |
| GET | `/admin/users` | 34859 | requireAdmin |
| GET | `/admin/users/:id` | 34889 | requireAdmin |
| GET | `/api/admin/users/:id/comments` | 34992 | requireAdmin |
| PATCH | `/api/admin/users/:id` | 35028 | requireAdmin |
| GET | `/admin/content` | 35058 | requireAdmin |
| GET | `/api/admin/revisions` | 35165 | requireAdmin |
| GET | `/admin/stats` | 35296 | requireAdmin |
| GET | `/api/admin/stats` | 35314 | requireAdmin |
| Admin comments moderation (6개) | `/api/admin/comments/*` | 35190-35268 | requireAdmin |
| Admin revision restore | POST `/api/admin/revisions/:id/restore` | 35278 | requireAdmin |

*주의: `/admin/ai-analyzer`는 미들웨어가 없어 보이지만, `adminAiApi`를 `app.route()`로 마운트하면서 admin 체크가 포함됨

---

### Phase 1 완료 후 예상 상태

```
index.tsx: 35,453 → ~18,000줄 (약 17,000줄 제거)
제거된 라우트: ~80개
새 파일: 6개
```

**Phase 1 검증**:
```bash
npx tsc --noEmit
npm run build
npm run deploy
# careerwiki.org에서 다음 확인:
# - /share/[토큰] 페이지 정상
# - /feedback 페이지 정상
# - /api/comments 댓글 CRUD 정상
# - /api/upload 이미지 업로드 정상
# - /api/job/create 등 편집 API 정상
# - /admin 페이지 정상
```

---

## Phase 2: 콘텐츠 페이지 추출 (~6,000줄 제거)

### 2-1. `src/routes/howto.ts` (~3,600줄)

**추출 라우트**:
| Method | Path | Line |
|--------|------|------|
| GET | `/howto` | 19548 |
| GET | `/howto/my-drafts` | 19997 |
| GET | `/howto/write` | 20230 |
| GET | `/howto/draft/:id` | 21342 |
| GET | `/howto/:slug/edit` | 22875 |
| GET | `/howto/:slug` | 23065 |
| PUT | `/api/howto/:id/update` | 19399 |
| DELETE | `/api/howto/:id` | 19474 |

**주의사항**:
- `/howto/write`와 `/howto/draft/:id`는 TipTap 에디터 포함 (큰 인라인 HTML)
- 이 라우트들의 순서가 중요: `/howto/my-drafts`, `/howto/write` 같은 정적 경로가 `/howto/:slug` 동적 경로보다 먼저 등록되어야 함
- Hono는 `app.route('/howto', howtoRoutes)` 시 prefix를 붙이므로, 내부에서는 `/`, `/my-drafts`, `/write`, `/draft/:id`, `/:slug/edit`, `/:slug` 순으로 등록

---

### 2-2. `src/routes/search.ts` (~700줄)

**추출 라우트**:
| Method | Path | Line |
|--------|------|------|
| GET | `/search` | 23191 |

**의존성**: `renderJobCard`, `renderMajorCard` ← `utils/card-renderers`

---

### 2-3. `src/routes/job-detail.ts` (~600줄) + `src/routes/major-detail.ts` (~600줄)

| Method | Path | Line |
|--------|------|------|
| GET | `/job/:slug` | 23516 |
| GET | `/major/:slug` | 23872 |
| GET | `/majors/:id` | 27628 |

**의존성**: ISR 캐시 로직, `renderUnifiedJobDetail`, `renderUnifiedMajorDetail`

---

### 2-4. `src/routes/job-list.ts` (~500줄) + `src/routes/major-list.ts` (~500줄)

| Method | Path | Line |
|--------|------|------|
| GET | `/job` | 18297 |
| GET | `/major` | 18750 |

---

### Phase 2 완료 후 예상 상태

```
index.tsx: ~18,000 → ~12,000줄 (약 6,000줄 제거)
새 파일: 6개 (Phase 1의 6개 + Phase 2의 6개 = 총 12개)
```

---

## Phase 3: 대형 분석기 페이지 추출 (~15,000줄 제거)

### 3-1. `src/routes/analyzer-job-page.ts` (~10,000줄)

| Method | Path | Line |
|--------|------|------|
| GET | `/analyzer/job` | 2573 |

**핵심 난점**:
- 단일 핸들러 안에 10,000줄짜리 template literal
- 클라이언트 JS가 `<script>` 태그 안에 인라인으로 포함
- 상태 관리, API 호출, UI 렌더링이 모두 하나의 문자열 안에 있음
- 추출은 "파일 이동"이지 "리팩토링"이 아님 — 단순히 handler를 새 파일로 이동

**전략**: 핸들러 전체를 새 파일의 단일 route handler로 이동. 내부 구조는 변경하지 않음.

```typescript
// src/routes/analyzer-job-page.ts
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'
// ... 필요한 imports

const analyzerJobPage = new Hono<AppEnv>()

analyzerJobPage.get('/', requireAuth, async (c) => {
  // 기존 핸들러 전체 복사
})

export { analyzerJobPage }
```

**index.tsx**: `app.route('/analyzer/job', analyzerJobPage)`

---

### 3-2. `src/routes/analyzer-major-page.ts` (~5,000줄)

동일한 전략으로 `/analyzer/major` 핸들러 이동.

**함께 이동하는 상수**: `STAGE_LABELS_M`, `VALUE_LABELS_M`, `WORKSTYLE_LABELS_M`, `INTEREST_LABELS_M`, `STRENGTH_LABELS_M`, `DRAIN_LABELS_M`, `SACRIFICE_LABELS_M`, `CONSTRAINT_LABELS_M`

---

### 3-3. 기타 잔여 라우트 정리

남은 라우트들을 몇 개의 파일로 그룹화:

**`src/routes/user.ts`** (~1,500줄):
- `/user`, `/user/profile`, `/user/ai-results`, `/user/comments`, `/user/bookmarks`, `/user/settings`
- `/api/user/*` (profile image, sessions, etc.)
- `/api/bookmark/*`

**`src/routes/api-data.ts`** (~1,500줄):
- `/api/jobs/*`, `/api/majors/*`
- `/api/categories`
- `/api/tags/popular`

**`src/routes/api-misc.ts`** (~500줄):
- `/api/me`, `/api/client-ip`, `/api/perf-metrics`
- `/api/serp-interactions/*`, `/api/freshness/*`
- `/api/analyzer/sessions/*`, `/api/analyzer/requests/*`

**`src/routes/pages.ts`** (~500줄):
- `/`, `/analyzer`, `/login`, `/legal/*`, `/help`, `/releases`, `/feedback/*` 페이지
- `/onboarding`, `/similar-names`
- `/robots.txt`, `/sitemap.xml`

---

### Phase 3 완료 후 최종 상태

```
index.tsx: ~12,000 → ~500줄 (라우트 등록 + 미들웨어 + export만)
총 새 파일: ~16개
```

**최종 index.tsx 구조**:
```typescript
import { Hono } from 'hono'
import type { AppEnv } from './types/app'
// middleware imports
// route imports

const app = new Hono<AppEnv>()

// Global middleware (순서 중요!)
app.use('*', cors())
app.use('*', renderer)
app.use('*', errorLoggingMiddleware)
app.use('*', timingMiddleware)
app.use('*', apiCacheHintMiddleware)
app.use('/static/*', serveStatic({ root: './public' }))
app.use('/images/*', serveStatic({ root: './public' }))
app.use('*', authMiddleware)

// Route registration
app.route('/auth', auth)
app.route('/api/ai-analyzer', analyzerRoutes)
app.route('', shareRoutes)           // /share/*
app.route('', commentsRoutes)        // /api/comments/*
app.route('', feedbackRoutes)        // /feedback/*, /api/feedback/*
app.route('', uploadRoutes)          // /api/upload/*, /uploads/*
app.route('', contentEditorRoutes)   // /api/job/*, /api/major/*, /api/howto/*
app.route('', adminRoutes)           // /admin/*, /api/admin/*
app.route('/howto', howtoRoutes)     // /howto/*
app.route('', searchRoutes)          // /search
app.route('', jobDetailRoutes)       // /job/:slug
app.route('', majorDetailRoutes)     // /major/:slug
app.route('', jobListRoutes)         // /job
app.route('', majorListRoutes)       // /major
app.route('/analyzer/job', analyzerJobPage)   // /analyzer/job
app.route('/analyzer/major', analyzerMajorPage) // /analyzer/major
app.route('', userRoutes)            // /user/*
app.route('', apiDataRoutes)         // /api/jobs/*, /api/majors/*
app.route('', apiMiscRoutes)         // /api/me, /api/perf-metrics, etc.
app.route('', pagesRoutes)           // /, /login, /legal/*, etc.

export default app
export { scheduled }
```

---

## 위험 요소 및 대응 방안

### 위험 1: 미들웨어 순서 변경
**문제**: `app.route('', subApp)` 시 global middleware가 정상 적용되는가?
**대응**: Hono에서 `app.use('*', ...)` 후 `app.route('', subApp)`하면 글로벌 미들웨어가 먼저 실행됨. 이미 `auth`와 `analyzerRoutes`가 이 패턴으로 동작 중이므로 안전.
**검증**: 배포 후 인증이 필요한 라우트에서 로그인 안 한 상태로 접근 → 401 또는 리다이렉트 확인.

### 위험 2: 라우트 등록 순서
**문제**: Hono는 등록 순서대로 매칭함. `/howto/write`가 `/howto/:slug`보다 먼저 와야 함.
**대응**: `app.route('/howto', howtoRoutes)` 내부에서 정적 경로를 먼저 등록. HowTo 관련 라우트를 하나의 파일로 묶어서 순서 제어.
**검증**: `/howto/write`, `/howto/my-drafts` 접근 시 404가 아닌 정상 페이지 표시 확인.

### 위험 3: 함수 누락
**문제**: index.tsx에서 함수를 추출했는데 어딘가에서 호출하는 곳을 놓침.
**대응**: Phase 0에서 공유 함수를 먼저 추출하고 `npx tsc --noEmit`으로 컴파일 에러 확인. TypeScript strict mode이므로 미참조 함수는 즉시 에러.
**검증**: 각 Phase 후 반드시 `npx tsc --noEmit` → `npm run build` → `npm run deploy` → 프로덕션 확인.

### 위험 4: `c.get('user')` 타입 불일치
**문제**: 새 route 파일에서 `c.get('user')`의 반환 타입이 `User | null | undefined`와 일치하는가?
**대응**: `AppEnv` 타입에 `Variables`가 `user?: User | null`을 포함하므로, `new Hono<AppEnv>()`로 생성하면 자동으로 일치.
**검증**: 타입 체크 통과로 확인.

### 위험 5: Prefix 충돌
**문제**: `app.route('/howto', howtoRoutes)` 하면 내부 route path에 `/howto`가 prefix로 붙음. 혼동 가능.
**대응**:
  - prefix 있는 경우: `app.route('/howto', howtoRoutes)` → 내부에서 `get('/')`, `get('/:slug')` 등록
  - prefix 없는 경우: `app.route('', pagesRoutes)` → 내부에서 `get('/feedback')`, `get('/login')` 등 full path 등록
  - 명확한 규칙: 동일 prefix를 공유하는 라우트 그룹만 prefix 사용, 나머지는 '' prefix

### 위험 6: scheduled export 분리
**문제**: `export const scheduled`가 index.tsx에 있어야 Cloudflare Workers cron이 동작.
**대응**: scheduled handler는 index.tsx에 유지. 내부 로직이 길면 별도 함수로 추출하되 export는 index.tsx에서.

---

## 실행 순서 요약

```
Phase 0 (선행 - 공유 모듈)  ← 먼저. 다른 Phase의 전제 조건
  → types/app.ts
  → utils/shared-helpers.ts
  → utils/card-renderers.ts
  → utils/constants.ts
  → tsc + build + deploy 검증
  ↓
Phase 1 (저위험 라우트)  ← 독립적인 API/페이지 추출
  → routes/share.ts
  → routes/comments.ts
  → routes/feedback.ts
  → routes/upload.ts
  → routes/content-editor.ts
  → routes/admin.ts
  → tsc + build + deploy 검증
  ↓
Phase 2 (콘텐츠 페이지)  ← 인라인 HTML 포함 페이지
  → routes/howto.ts
  → routes/search.ts
  → routes/job-detail.ts
  → routes/major-detail.ts
  → routes/job-list.ts
  → routes/major-list.ts
  → tsc + build + deploy 검증
  ↓
Phase 3 (대형 + 잔여)  ← 가장 큰 페이지 + 마무리
  → routes/analyzer-job-page.ts
  → routes/analyzer-major-page.ts
  → routes/user.ts
  → routes/api-data.ts
  → routes/api-misc.ts
  → routes/pages.ts
  → tsc + build + deploy 검증
```

**총 예상 작업량**: 각 Phase당 1회 세션 (총 4회 세션)
**각 Phase 완료 후 필수**: commit → deploy → careerwiki.org 검증 → 다음 Phase

---

## 검증 체크리스트 (매 Phase 후)

- [ ] `npx tsc --noEmit` — 타입 에러 0개
- [ ] `npm run build` — 빌드 성공
- [ ] `npm run deploy` — 배포 성공
- [ ] careerwiki.org 홈페이지 로딩
- [ ] /analyzer/job 접근 (로그인 필요)
- [ ] /analyzer/major 접근 (로그인 필요)
- [ ] /job 목록 페이지
- [ ] /major 목록 페이지
- [ ] /howto 목록 페이지
- [ ] /job/[아무슬러그] 상세 페이지
- [ ] /search?q=프로그래머 검색
- [ ] /feedback 피드백 페이지
- [ ] /admin 관리자 페이지 (admin 계정)
- [ ] 댓글 작성/수정/삭제
- [ ] 이미지 업로드
- [ ] API: /api/jobs, /api/majors
