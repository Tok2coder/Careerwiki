import { Hono } from 'hono'
import type { Context } from 'hono'
import { cors } from 'hono/cors'
import { serveStatic } from 'hono/cloudflare-workers'
import { renderer } from './renderer'
import auth from './routes/auth'
import { authMiddleware, requireAuth, requireAdmin, requireRole, requireJobMajorEdit, requireHowToEdit } from './middleware/auth'
import { JOB_CATEGORIES, APTITUDE_TYPES } from './api/careernetAPI'
import { getUnifiedJobDetail, getUnifiedJobDetailWithRawData, getUnifiedMajorDetail, searchUnifiedJobs, searchUnifiedMajors } from './services/profileDataService'
import type { SourceStatusRecord } from './services/profileDataService'
import type { DataSource, UnifiedJobDetail, UnifiedMajorDetail } from './types/unifiedProfiles'
import { renderUnifiedJobDetail, createJobJsonLd } from './templates/unifiedJobDetail'
import { renderJobTemplateDesignPage } from './templates/jobTemplateDesignPage'
import { renderJobETLInspectionPage } from './templates/jobETLInspectionPage'
import { renderUnifiedMajorDetail, createMajorJsonLd } from './templates/unifiedMajorDetail'
import type { JobSourceRow, MajorSourceRow } from './types/database'
import { renderHowtoGuideDetail } from './templates/howtoDetail'
import { buildCommentGovernanceItems, resolveCommentPolicy } from './templates/detailTemplateUtils'
import {
  getSampleJobDetail,
  getSampleMajorDetail,
  listSampleJobSummaries,
  listSampleMajorSummaries,
  listSampleHowtoSummaries,
  getSampleHowtoGuide
} from './data/sampleRegistry'
import { composeDetailSlug, resolveDetailIdFromSlug } from './utils/slug'
import {
  withKvCache,
  buildListCacheKey,
  secondsToHuman,
  formatTimestamp,
  type CacheState
} from './services/cacheService'
import type { 
  ExportedHandlerScheduledHandler,
  D1Database,
  KVNamespace,
  R2Bucket
} from '@cloudflare/workers-types'
import { LIST_CACHE_STALE_SECONDS, LIST_CACHE_MAX_AGE_SECONDS } from './config/cachePolicy'
import { recordListFreshness, attemptScheduledRefresh, getFreshnessStatus, resolveFreshnessTargetById } from './services/freshnessService'
import { SERP_FRESHNESS_TARGETS } from './config/freshnessConfig'
import { storePerfMetrics, type PerfMetricsPayload, type PerfAlert } from './services/perfMetricsService'
import {
  createOrUpdateSession,
  createAnalysisRequest,
  createAnalysisResult,
  getAnalysisRequestWithResult,
  getSession as getAiSession,
  listRequestsBySession,
  updateRequestStatus
} from './services/aiAnalysisService'
// Phase 0: AI Analyzer Service (scoring-v0.2.1-final)
import { analyzerRoutes } from './services/ai-analyzer'
import {
  recordSerpInteraction,
  getDailySerpSummary,
  listRecentSerpInteractions
} from './services/serpInteractionService'
import {
  type PageType,
  type UserRole,
  blockIpAddress,
  createComment,
  deleteComment,
  getCommentsBySlug,
  isIpBlocked,
  listIpBlocks,
  releaseIpAddress,
  reportComment,
  setCommentVote,
  updateComment,
  listFlaggedComments,
  setCommentStatus,
  resetCommentReports,
  deleteOrphanReplies
} from './services/commentService'
import { listHowtoReports } from './services/howtoReportService'
import type { AnalysisType, PricingTier, RequestStatus } from './types/aiAnalysis'
import { getOrGeneratePage, invalidatePageCache } from './utils/page-cache'
import { editJob, editMajor, editHowTo, createHowTo, createJob, createMajor } from './services/editService'
import { getRevisionById, listRevisions, restoreRevision } from './services/revisionService'
import { validateUrl } from './utils/editValidation'
import { findSimilarNames, saveNameMappings, deleteNameMapping, getExistingMappings } from './services/similarNamesService'
import { renderAdminSimilarNamesPage } from './templates/adminSimilarNames'
import { renderAdminDashboard } from './templates/admin/adminDashboard'
import { renderAdminUsers } from './templates/admin/adminUsers'
import { renderAdminUserDetail } from './templates/admin/adminUserDetail'
import { renderAdminFeedbackPage } from './templates/admin/adminFeedback'
import { renderAdminFeedbackDetail } from './templates/admin/adminFeedbackDetail'
import {
  isValidFeedbackStatus,
  updateFeedbackStatus,
  listFeedbackWithCommentCount,
  listComments,
  addComment,
  deleteComment as deleteFeedbackComment,
  getCommentById,
  updateLastActivity,
  autoCloseFeedback,
} from './services/feedbackService'
import { renderFeedbackDetailPage } from './templates/feedbackDetail'
import { renderOnboardingPage } from './templates/onboarding'
import { renderTermsPage } from './templates/legal/terms'
import { renderPrivacyPage } from './templates/legal/privacy'
import { renderHelpPage } from './templates/help'
import { renderFeedbackPage } from './templates/feedback'
import { renderNav, renderNavStyles, renderNavScripts } from './templates/partials/nav'
import { renderNotFoundPage } from './templates/notFound'
import {
  createFeedback,
  deleteReply,
  deleteFeedback,
  getFeedbackById,
  listFeedback,
  setVisibility,
  upsertReply,
  validateFeedbackInput,
} from './services/feedbackService'
import {
  getOnboardingStatus,
  checkNicknameAvailability,
  submitOnboarding,
  getUserAttribution,
  getUserConsents
} from './services/onboardingService'
import { renderAdminContent } from './templates/admin/adminContent'
import { renderAdminStats } from './templates/admin/adminStats'
import { getUsers, updateUserRole, banUser, unbanUser, getRevisions, restoreRevision as restoreRevisionAdmin, getStats, getAnalyticsStats } from './services/adminService'
import { weakETag, toNFC, matchETag } from './utils/etag'
import { TEMPLATE_VERSIONS } from './constants/template-versions'

// Dev-only helpers (instrumentation, safety)
const isDevEnv = (env?: any) => {
  const flag = env?.ENVIRONMENT || process?.env?.ENVIRONMENT || process?.env?.NODE_ENV
  return !flag || ['dev', 'development', 'local'].includes(String(flag).toLowerCase())
}

const timingMiddleware = async (c: any, next: any) => {
  if (!isDevEnv(c?.env)) {
    await next()
    return
  }
  const t0 = Date.now()
  const marks: Record<string, number> = {}
  c.set('mark', (k: string) => {
    marks[k] = Date.now()
  })
  await next()
  const parts = Object.entries(marks).map(([k, v]) => `${k};dur=${Date.now() - Number(v)}`)
  if (parts.length > 0) {
    c.header('Server-Timing', parts.join(', '))
  }
  c.header('X-Response-Duration', String(Date.now() - t0))
}

const apiCacheHintMiddleware = async (c: any, next: any) => {
  await next()
  const path = c.req.path || ''
  if (path.startsWith('/api/') && !c.res.headers.get('Cache-Control')) {
    c.header('Cache-Control', 'public, max-age=60, stale-while-revalidate=30')
  }
}

const errorLoggingMiddleware = async (c: any, next: any) => {
  try {
    await next()
  } catch (e: any) {
    console.error(
      JSON.stringify({
        ts: new Date().toISOString(),
        route: c?.req?.path,
        msg: String(e),
        stack: e?.stack,
      })
    )
    return c.text('Internal Error', 500)
  }
}


// Types
type Bindings = {
  DB: D1Database;
  KV: KVNamespace;
  UPLOADS: R2Bucket;  // R2 이미지 업로드
  VECTORIZE?: VectorizeIndex;  // Vectorize 인덱스 (AI 분석기 후보 검색)
  AI?: Ai;  // Workers AI (임베딩 생성)
  CAREER_NET_API_KEY?: string;
  GOYONG24_MAJOR_API_KEY?: string;
  GOYONG24_JOB_API_KEY?: string;
  PERF_ALERT_WEBHOOK?: string;
  ADMIN_SECRET?: string;
  ENVIRONMENT?: string;
  // Z-Image Turbo API (이미지 생성)
  EVOLINK_API_KEY?: string;
  // Phase 3: Google OAuth 환경 변수
  GOOGLE_CLIENT_ID: string;
  GOOGLE_CLIENT_SECRET: string;
  GOOGLE_CALLBACK_URL: string;
  JWT_SECRET: string;
}

// User 타입 (auth-helpers에서 정의)
interface User {
  id: number;
  google_id: string;
  provider?: string;
  provider_user_id?: string;
  email: string;
  name: string | null;
  picture_url: string | null;
  custom_picture_url: string | null;  // 사용자가 직접 업로드한 프로필 이미지
  role: 'user' | 'expert' | 'admin';
  username: string | null;
  ban_reason: string | null;
  onboarded?: number;  // 온보딩 완료 여부 (0 or 1)
  created_at: string;
  updated_at: string;
}

type Variables = {
  title?: string;
  description?: string;
  user?: User | null;
  mark?: (key: string) => void;
}

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>()

// Middleware
app.use('*', cors())
app.use('*', renderer)
app.use('*', errorLoggingMiddleware)
app.use('*', timingMiddleware)
app.use('*', apiCacheHintMiddleware)

// Serve static files from public directory
// All static assets including JS, CSS, images are served from /static/* path
// @ts-ignore - Cloudflare Workers types mismatch
app.use('/static/*', serveStatic({ root: './public' }))

// Serve images from public/images directory
// @ts-ignore - Cloudflare Workers types mismatch
app.use('/images/*', serveStatic({ root: './public' }))

// Phase 3: 인증 Middleware (모든 라우트에 적용)
app.use('*', authMiddleware)

// Phase 3: 인증 라우트
app.route('/auth', auth)

// ============================================
// Phase 0: AI Analyzer API (scoring-v0.2.1-final)
// POST /api/ai-analyzer/analyze   - 분석 요청
// POST /api/ai-analyzer/followup  - follow-up 응답
// GET  /api/ai-analyzer/result/:id - 결과 조회
// GET  /api/ai-analyzer/session/:id - 세션 이력
// ============================================
app.route('/api/ai-analyzer', analyzerRoutes)

// ============================================
// 온보딩 라우트
// ============================================

// 온보딩 페이지 (첫 로그인 사용자)
import { getCookie, deleteCookie } from 'hono/cookie'

app.get('/onboarding', requireAuth, async (c) => {
  const user = c.get('user')
  
  // 이미 온보딩 완료한 사용자는 메인으로 리다이렉트
  if (user && (user as any).onboarded === 1) {
    return c.redirect('/')
  }
  
  // 온보딩 완료 후 돌아갈 URL
  const returnUrl = getCookie(c, 'onboarding_return_url') || '/'
  
  const html = renderOnboardingPage({
    userName: user?.name,
    returnUrl
  })
  
  return c.html(html)
})

// 온보딩 상태 조회 API
app.get('/api/me/onboarding', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ error: 'Unauthorized' }, 401)
  }
  
  try {
    const status = await getOnboardingStatus(c.env.DB, user.id)
    return c.json(status)
  } catch (error) {
    console.error('[Onboarding] Error getting status:', error)
    return c.json({ error: 'Failed to get onboarding status' }, 500)
  }
})

// 닉네임 가용성 체크 API
app.get('/api/nickname/check', async (c) => {
  const value = c.req.query('value')
  
  if (!value || typeof value !== 'string') {
    return c.json({ ok: false, reason: 'invalid', message: '닉네임을 입력해주세요.' })
  }
  
  try {
    const result = await checkNicknameAvailability(c.env.DB, value)
    return c.json(result)
  } catch (error) {
    console.error('[Onboarding] Error checking nickname:', error)
    return c.json({ ok: false, reason: 'invalid', message: '검증 중 오류가 발생했습니다.' })
  }
})

// 온보딩 제출 API
app.post('/api/onboarding', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'Unauthorized' }, 401)
  }
  
  let body: any
  try {
    body = await c.req.json()
  } catch {
    return c.json({ success: false, error: 'Invalid JSON body' }, 400)
  }
  
  // IP 및 User-Agent 수집
  const ip = c.req.header('CF-Connecting-IP') || c.req.header('X-Forwarded-For')?.split(',')[0] || undefined
  const ua = c.req.header('User-Agent') || undefined
  
  try {
    const result = await submitOnboarding(c.env.DB, user.id, body, { ip, ua })
    
    if (result.success) {
      // 온보딩 완료 후 리턴 URL 쿠키 삭제
      deleteCookie(c, 'onboarding_return_url')
    }
    
    return c.json(result)
  } catch (error) {
    console.error('[Onboarding] Error submitting:', error)
    return c.json({ success: false, error: '온보딩 처리 중 오류가 발생했습니다.' }, 500)
  }
})

// 약관 페이지
app.get('/legal/terms', async (c) => {
  return c.html(renderTermsPage())
})

// 개인정보처리방침 페이지
app.get('/legal/privacy', async (c) => {
  return c.html(renderPrivacyPage())
})

// Help Center
app.get('/help', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  return c.html(renderHelpPage({ userMenuHtml }))
})

// Feedback Board
app.get('/feedback', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
  const pageSize = parseNumberParam(c.req.query('pageSize'), 20, { min: 1, max: 50 })
  const typeParam = c.req.query('type') || undefined
  const statusParam = c.req.query('status') || undefined
  const type = typeParam && ['bug', 'suggestion', 'question', 'other'].includes(typeParam) ? (typeParam as any) : undefined
  const status = statusParam && ['open', 'closed'].includes(statusParam) ? (statusParam as any) : undefined

  // 자동 종료 처리 (14일 미활동)
  await autoCloseFeedback(c.env.DB, 14)

  const list = await listFeedbackWithCommentCount(c.env.DB, {
    page,
    pageSize,
    type,
    status,
    includePrivate: false,
    userId: user?.id,
  })
  return c.html(
    renderFeedbackPage({
      userMenuHtml,
      isLoggedIn: Boolean(user),
      posts: list.items as any,
      page,
      total: list.total,
      pageSize,
    }),
  )
})

// 피드백 상세
app.get('/feedback/:id', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  const isAdmin = isAdminRole(user?.role)
  const id = Number(c.req.param('id'))

  if (!Number.isFinite(id)) return c.redirect('/feedback')

  const feedback = await getFeedbackById(c.env.DB, id, { includePrivate: true })
  if (!feedback) return c.redirect('/feedback')

  // 비공개 피드백은 작성자 또는 관리자만 열람 가능
  if (feedback.is_private && !isAdmin && user?.id !== feedback.user_id) {
    return c.redirect('/feedback')
  }

  // 작성자 정보 조회
  const authorRow = await c.env.DB.prepare(
    `SELECT name, username, picture_url FROM users WHERE id = ?`
  ).bind(feedback.user_id).first<{ name: string | null; username: string | null; picture_url: string | null }>()

  const comments = await listComments(c.env.DB, id)
  const hasAdminComment = comments.some((c) => c.is_admin)

  return c.html(
    renderFeedbackDetailPage({
      userMenuHtml,
      isLoggedIn: Boolean(user),
      currentUserId: user?.id,
      isAdmin: Boolean(isAdmin),
      post: {
        ...feedback,
        author_name: authorRow?.username || authorRow?.name || `user_${feedback.user_id}`,
        author_picture: authorRow?.picture_url || null,
        last_activity_at: feedback.last_activity_at || feedback.created_at,
      },
      comments,
      hasAdminComment,
    }),
  )
})

// Releases placeholder (with shared header)
app.get('/releases', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  return c.html(`<!DOCTYPE html>
  <html lang="ko">
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>릴리즈 노트 | CareerWiki</title>
      <link href="/static/style.css" rel="stylesheet" />
      <script src="https://cdn.tailwindcss.com"></script>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
      ${renderNavStyles()}
    </head>
    <body class="bg-wiki-bg text-wiki-text min-h-screen" style="background-color:#0b1220;color:#e6e8f5;">
      ${renderNav(userMenuHtml)}
      <main class="max-w-[1200px] mx-auto px-4 pt-20 pb-20 text-center space-y-5 sm:pt-12">
        <p class="text-xs uppercase tracking-[0.2em] text-blue-300 font-semibold">Releases</p>
        <h1 class="text-3xl md:text-4xl font-bold text-white">릴리즈 노트 준비 중</h1>
        <p class="text-sm text-wiki-muted">배포 이력 페이지를 곧 제공합니다. 최신 문의는 <a class="text-wiki-link" href="mailto:contact@careerwiki.org">contact@careerwiki.org</a>로 연락주세요.</p>
        <div class="flex flex-wrap justify-center gap-3 pt-2">
          <a href="/help" class="px-5 py-3 min-h-[44px] flex items-center rounded-lg border border-wiki-border text-sm text-wiki-text hover:bg-wiki-surface">도움말로 돌아가기</a>
          <a href="/feedback" class="px-5 py-3 min-h-[44px] flex items-center rounded-lg bg-gradient-to-r from-blue-500 to-indigo-500 text-white text-sm font-semibold hover:opacity-90">건의사항</a>
        </div>
      </main>
      ${renderNavScripts()}
    </body>
  </html>`)
})

// Phase 3 Day 4: 사용자 정보에 따른 헤더 UI 생성 함수
const renderUserMenu = (
  user: { id: number; name: string | null; email: string; role: string; picture_url: string | null; custom_picture_url?: string | null; username: string | null } | null,
  ipAddress: string | null = null
) => {
  // 프로필 이미지 우선순위: custom > OAuth > 기본 아이콘
  const profileImageUrl = user ? (user.custom_picture_url || user.picture_url) : null
  
  // 프로필 이미지 또는 기본 아이콘 렌더링
  const userIconHtml = profileImageUrl
    ? `<img src="${profileImageUrl}" alt="${user?.name || 'User'}" class="rounded-full object-cover" />`
    : `<i class="fas fa-user-circle text-base"></i>`
  
  // 로그인 여부와 관계없이 유저 아이콘 버튼 표시
  const menuHtml = `
    <!-- 유저 메뉴 드롭다운 -->
    <div class="relative" id="user-menu-container">
      <button 
        id="user-menu-btn" 
        class="header-icon-button flex items-center justify-center" 
        title="사용자 메뉴"
        aria-label="사용자 메뉴"
        aria-expanded="false"
        aria-haspopup="true"
      >
        ${userIconHtml}
      </button>
      <div 
        id="user-menu-dropdown" 
        class="hidden absolute right-0 top-full mt-1 w-56 glass-card rounded-lg border border-wiki-border/50 shadow-xl py-1 z-50"
        role="menu"
        style="background: rgba(26, 26, 46, 0.98); backdrop-filter: blur(16px);"
      >
        ${user ? `
        <!-- 로그인된 사용자: 권한에 따른 표시 -->
        <div class="px-4 py-2.5 border-b border-wiki-border/30">
          <div class="flex items-center justify-between">
            <span class="text-xs text-wiki-muted">${user.role === 'admin' ? '관리자' : user.role === 'expert' ? '전문가' : '사용자'}</span>
            <span class="text-xs font-mono text-wiki-text font-medium">${user.username || 'user_' + user.id}</span>
          </div>
        </div>
        
        ${user.role === 'admin' ? `
        <!-- 관리자 메뉴 -->
        <a href="/admin" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem">
          <div class="flex items-center gap-3">
            <i class="fas fa-shield-alt text-xs w-4 text-center text-amber-400"></i>
            <span>관리자</span>
          </div>
        </a>
        ` : ''}
        
        <!-- 작성 가이드 -->
        <a href="/howto/my-drafts" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem">
          <div class="flex items-center gap-3">
            <i class="fas fa-file-alt text-xs w-4 text-center text-wiki-primary"></i>
            <span>작성 가이드</span>
          </div>
        </a>
        
        <!-- 작성 댓글 -->
        <a href="/user/comments" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem">
          <div class="flex items-center gap-3">
            <i class="fas fa-comments text-xs w-4 text-center text-wiki-secondary"></i>
            <span>작성 댓글</span>
          </div>
        </a>
        
        <!-- 저장함 -->
        <a href="/user/bookmarks" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem">
          <div class="flex items-center gap-3">
            <i class="fas fa-bookmark text-xs w-4 text-center text-amber-400"></i>
            <span>저장함</span>
          </div>
        </a>
        
        <div class="border-t border-wiki-border/30 my-1"></div>
        
        <!-- 개인 설정 -->
        <a href="/user/settings" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem">
          <div class="flex items-center gap-3">
            <i class="fas fa-cog text-xs w-4 text-center"></i>
            <span>개인 설정</span>
          </div>
        </a>
        
        <!-- 로그아웃 -->
        <form action="/auth/logout" method="POST" class="logout-form">
          <input type="hidden" name="return_url" class="logout-return-url" value="">
          <button type="submit" class="w-full text-left px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors flex items-center gap-3" role="menuitem">
            <i class="fas fa-sign-out-alt text-xs w-4 text-center"></i>
            <span>로그아웃</span>
          </button>
        </form>
        ` : `
        <!-- 비로그인 사용자: IP 주소 표시 -->
        <div class="px-4 py-2.5 border-b border-wiki-border/30">
          <div class="flex items-center justify-between">
            <span class="text-xs text-wiki-muted">아이피</span>
            <span id="user-ip-display" class="text-xs font-mono text-wiki-text font-medium">${ipAddress || '로딩 중...'}</span>
          </div>
        </div>
        
        <!-- 로그인 -->
        <a href="/auth/google" data-login-link class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem">
          <div class="flex items-center gap-3">
            <i class="fab fa-google text-xs w-4 text-center"></i>
            <span>로그인</span>
          </div>
        </a>
        `}
      </div>
    </div>
  `
  
  // 비로그인 상태일 때 IP 로딩 스크립트 추가
  if (!user) {
    return menuHtml + `
    <script>
      (function() {
        const ipDisplay = document.getElementById('user-ip-display');
        if (ipDisplay && ipDisplay.textContent === '로딩 중...') {
          fetch('/api/client-ip')
            .then(res => res.json())
            .then(data => {
              if (data.ip && ipDisplay) {
                ipDisplay.textContent = data.ip;
              }
            })
            .catch(() => {
              if (ipDisplay) {
                ipDisplay.textContent = '127.0.0.1';
              }
            });
        }
      })();
    </script>
    `
  }
  
  return menuHtml
}

// Helper function for logo image (PNG 파일 사용)
const getLogoImage = (size: 'large' | 'small' = 'large') => {
  const isLarge = size === 'large'
  const src = isLarge ? '/images/CWmainlogo.png' : '/images/CWheaderlogo.png'
  const width = isLarge ? 360 : 180
  const height = isLarge ? 90 : 40
  
  return `<img src="${src}" alt="Careerwiki" width="${width}" height="${height}" class="logo-image" style="object-fit: contain;" />`
}

// Legacy alias for backward compatibility
const getLogoSVG = getLogoImage

const isAdminRole = (role?: string | null) =>
  role === 'admin' || role === 'super-admin' || role === 'operator'

// Helper function to render layout
const renderLayout = (
  content: string,
  title = 'Careerwiki - AI 진로 분석 플랫폼',
  description = 'AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 플랫폼',
  isHomepage = false,
  options?: {
    extraHead?: string
    canonical?: string
    ogUrl?: string
    user?: { id: number; name: string | null; email: string; role: string; picture_url: string | null; custom_picture_url?: string | null; username: string | null } | null
    context?: Context<{ Bindings: Bindings; Variables: Variables }>  // Phase 3 Day 4: Context를 통해 사용자 정보 자동 가져오기
    ipAddress?: string | null  // Phase 3 Day 4: IP 주소 (비로그인 상태에서 표시)
  }
) => {
  const canonicalUrl = options?.canonical ?? 'https://careerwiki.org'
  const ogUrl = options?.ogUrl ?? canonicalUrl
  const extraHead = options?.extraHead ?? ''
  
  // Phase 3 Day 4: 사용자 정보 가져오기 (options.user 우선, 없으면 context에서 가져오기)
  let user = options?.user ?? null
  if (!user && options?.context) {
    const contextUser = options.context.get('user')
    if (contextUser) {
      user = {
        id: contextUser.id,
        name: contextUser.name,
        email: contextUser.email,
        role: contextUser.role,
        picture_url: contextUser.picture_url,
        custom_picture_url: contextUser.custom_picture_url,
        username: contextUser.username
      }
    }
  }
  
  // 디버깅: 사용자 정보 확인
  // console.log('[renderLayout] User:', user ? { id: user.id, username: user.username } : 'null')

  return `
    <!DOCTYPE html>
    <html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title}</title>
        <meta name="description" content="${description}">
        <meta property="og:title" content="${title}">
        <meta property="og:description" content="${description}">
        <meta property="og:type" content="website">
        <meta property="og:url" content="${ogUrl}">
        <meta name="robots" content="index, follow">
        <link rel="canonical" href="${canonicalUrl}">
        <link rel="icon" type="image/png" href="/images/CWfavicon.png">
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.0/css/all.min.css" rel="stylesheet">
        <script src="https://unpkg.com/lucide@latest"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
        <script>
          tailwind.config = {
            darkMode: 'class',
            theme: {
              extend: {
                colors: {
                  'wiki-bg': '#0f0f23',
                  'wiki-card': '#1a1a2e',
                  'wiki-border': '#2a2a3e',
                  'wiki-primary': '#4361ee',
                  'wiki-secondary': '#64b5f6',
                  'wiki-text': '#e0e0e0',
                  'wiki-muted': '#9ca3af',
                }
              }
            }
          }
        </script>
        <script>
          // 서버에서 주입하는 사용자 정보 (초기값, ISR 캐시 페이지에서는 null일 수 있음)
          window.__USER__ = ${user ? JSON.stringify({ id: user.id, username: user.username, role: user.role, pictureUrl: user.custom_picture_url || user.picture_url || null }) : 'null'};
          window.__USER_LOADED__ = false;
          
          // 클라이언트에서 동적으로 로그인 상태 확인 (ISR 캐시 페이지 대응)
          (function() {
            fetch('/api/me', { credentials: 'same-origin', cache: 'no-store', headers: { 'Cache-Control': 'no-store' } })
              .then(function(r) { return r.json(); })
              .then(function(data) {
                window.__USER__ = data.user;
                window.__USER_LOADED__ = true;
                // 로그인 상태 변경 이벤트 발생
                window.dispatchEvent(new CustomEvent('userLoaded', { detail: data.user }));
              })
              .catch(function() {
                window.__USER_LOADED__ = true;
              });
          })();
        </script>
        <script src="/static/perf-metrics.js" defer></script>
        ${extraHead}
        <style>
          body { background: #0f0f23; color: #e0e0e0; }
          
          /* 기본 콘텐츠 폰트 크기 정의 */
          .content-text { 
            font-size: 15px; 
            line-height: 1.7;
            color: #d1d5db;
          }
          
          /* 소제목 스타일 - 명확하고 구분되게, 풀너비 얇은 보더 */
          .content-heading { 
            font-size: 16px;
            font-weight: 700;
            color: #f3f4f6;
            letter-spacing: 0.02em;
            text-transform: uppercase;
            margin-bottom: 12px;
            padding-bottom: 8px;
            border-bottom: 1px solid rgba(100, 181, 246, 0.15);
            display: block;
            width: 100%;
          }
          
          /* 섹션 제목 - 더 강조되고 트렌디하게, 풀너비 굵은 보더 */
          .section-title { 
            font-size: 20px;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.01em;
            margin-bottom: 16px;
            padding-bottom: 12px;
            border-bottom: 2px solid rgba(100, 181, 246, 0.3);
            width: 100%;
          }
          
          /* 모바일 최적화 */
          @media (max-width: 768px) {
            .section-title {
              font-size: 18px;
            }
            .content-heading {
              font-size: 16px;
            }
            /* 모바일 네비게이션 로고 크기 조정 */
            nav img[alt*="로고"] {
              max-width: 120px;
              height: auto;
            }
            /* 모바일 홈페이지 로고 크기 - 검색창 너비의 60% */
            .hero-inner > div:first-child {
              width: 60%;
              max-width: 60%;
            }
            .hero-inner > div:first-child svg {
              width: 100%;
              height: auto;
            }
          }
          
          /* 탭 패널 표시/숨김 - SEO 최적화: hidden 속성 대신 CSS 사용 */
          .cw-tab-panel.is-hidden {
            display: none;
          }
          .cw-tab-panel.is-active {
            display: block;
          }
          
          /* 플로팅 네비게이션 버튼 */
          .floating-nav {
            position: fixed;
            right: 24px;
            bottom: 24px;
            z-index: 1000;
            display: flex;
            flex-direction: column;
            gap: 12px;
          }
          .floating-nav.hidden {
            display: none;
          }
          .floating-nav-scroll-top {
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.3s ease;
          }
          .floating-nav-scroll-top.visible {
            opacity: 1;
            pointer-events: auto;
          }
          .floating-nav-btn {
            width: 52px;
            height: 52px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(26, 26, 46, 0.75);
            border: 1px solid rgba(100, 181, 246, 0.3);
            color: #64b5f6;
            font-size: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            position: relative;
          }
          .floating-nav-btn:hover {
            background: rgba(67, 97, 238, 0.85);
            border-color: rgba(100, 181, 246, 0.6);
            color: #ffffff;
            transform: translateX(-4px);
            box-shadow: 0 6px 20px rgba(67, 97, 238, 0.4);
          }
          .floating-nav-btn .label {
            position: absolute;
            right: 64px;
            white-space: nowrap;
            padding: 8px 14px;
            background: rgba(26, 26, 46, 0.95);
            border: 1px solid rgba(100, 181, 246, 0.4);
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            color: #e0e0e0;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.3s ease;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
          }
          .floating-nav-btn:hover .label {
            opacity: 1;
          }
          
          .gradient-text {
            background: linear-gradient(135deg, #4361ee 0%, #64b5f6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
          }
          .glass-card {
            background: rgba(26, 26, 46, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(67, 97, 238, 0.2);
          }
          .hover-glow:hover {
            box-shadow: 0 0 30px rgba(67, 97, 238, 0.3);
            transition: all 0.3s ease;
          }
          .wiki-link {
            color: #64b5f6;
            text-decoration: none;
            transition: all 0.2s;
          }
          .wiki-link:hover {
            color: #4361ee;
            text-decoration: underline;
          }
          .scrollbar-hide {
            -ms-overflow-style: none;
            scrollbar-width: none;
          }
          .scrollbar-hide::-webkit-scrollbar {
            display: none;
          }
          nav[aria-label="페이지네이션"]::-webkit-scrollbar,
          div:has(nav[aria-label="페이지네이션"])::-webkit-scrollbar {
            display: none;
          }
          .menu-button {
            background: rgba(26, 26, 46, 0.9);
            border: 1px solid rgba(67, 97, 238, 0.3);
            padding: 16px 20px;
            border-radius: 12px;
            transition: all 0.3s;
            min-height: 80px;
          }
          .menu-button:hover {
            background: #4361ee;
            border-color: #4361ee;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(67, 97, 238, 0.4);
          }
          .menu-button:focus-visible {
            outline: 2px solid #64b5f6;
            outline-offset: 2px;
          }
          /* 모바일에서 AI 분석(첫 번째)만 가로 배치 */
          @media (max-width: 479px) {
            .pillar-grid > a:first-child.menu-button {
              display: flex;
              flex-direction: row;
              align-items: center;
              justify-content: center;
              gap: 12px;
              padding: 10px 18px;
              min-height: auto;
              text-align: center;
            }
            .pillar-grid > a:first-child.menu-button i {
              margin-bottom: 0 !important;
              font-size: 1.25rem !important;
            }
            .pillar-grid > a:first-child.menu-button div {
              font-size: 0.9rem;
            }
            /* 나머지(직업위키, 전공위키, HowTo)는 세로 배치 */
            .pillar-grid > a:not(:first-child).menu-button {
              display: flex;
              flex-direction: column;
              align-items: center;
              justify-content: center;
              gap: 8px;
              padding: 12px 8px;
              min-height: auto;
              text-align: center;
            }
            .pillar-grid > a:not(:first-child).menu-button i {
              margin-bottom: 0 !important;
              font-size: 1.5rem !important;
            }
            .pillar-grid > a:not(:first-child).menu-button div {
              font-size: 0.75rem;
            }
          }
          .homepage-header {
            width: 100%;
            padding: 12px 0;
          }
          .homepage-header > div {
            display: flex;
            align-items: center;
          }
          @media (max-width: 767px) {
            .homepage-header {
              padding: 8px 0;
            }
          }
          .hero-shell {
            min-height: calc(100vh - 260px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 16px 40px;
          }
          .hero-inner {
            max-width: 640px;
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 36px;
            align-items: center;
            text-align: center;
          }
          .search-shell {
            width: 100%;
            max-width: 820px;
          }
          .search-shell form {
            width: 100%;
          }
          .search-shell .search-bar {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 10px 6px 16px;
            border-radius: 9999px;
            background: rgba(26, 26, 46, 0.6);
            border: 1px solid rgba(100, 181, 246, 0.28);
            box-shadow: 0 10px 28px rgba(15, 15, 35, 0.35);
            transition: border 0.2s ease, box-shadow 0.2s ease;
          }
          .search-shell .search-bar:focus-within {
            border-color: #4361ee;
            box-shadow: 0 16px 40px rgba(67, 97, 238, 0.25);
          }
          .search-shell input {
            flex: 1;
            background: transparent;
            border: none;
            color: #e0e0e0;
            font-size: 15px;
            line-height: 1.4;
            padding: 0;
          }
          .search-shell input::placeholder {
            color: #a0a8c0;
            font-size: 14px;
          }
          .search-shell input:focus {
            outline: none;
          }
          .search-button {
            width: 40px;
            height: 40px;
            min-width: 40px;
            min-height: 40px;
            border-radius: 9999px;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            background: linear-gradient(135deg, #4361ee 0%, #64b5f6 100%);
            color: #ffffff;
            box-shadow: 0 10px 22px rgba(67, 97, 238, 0.3);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            cursor: pointer;
          }
          .search-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 32px rgba(67, 97, 238, 0.45);
          }
          .search-button:focus-visible {
            outline: 2px solid #64b5f6;
            outline-offset: 3px;
          }
          /* 헤더 아이콘 버튼 - 터치 타겟 44px 보장 */
          .header-icon-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
            min-height: 44px;
            padding: 10px;
            border-radius: 8px;
            color: #9ca3af;
            transition: color 0.2s ease, background-color 0.2s ease;
          }
          .header-icon-button:hover {
            color: #e0e0e0;
            background-color: rgba(67, 97, 238, 0.1);
          }
          .header-icon-button:focus-visible {
            outline: 2px solid #64b5f6;
            outline-offset: 2px;
          }
          .header-icon-button {
            padding: 8px;
          }
          #user-menu-btn img,
          .header-icon-button img {
            display: block;
            width: 24px;
            height: 24px;
            min-width: 24px;
            min-height: 24px;
            flex: 0 0 24px;
          }
          .pillar-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 12px;
            width: 100%;
            max-width: 520px;
          }
          .pillar-grid > a:first-child {
            grid-column: 1 / -1;
          }
          @media (min-width: 480px) {
            .pillar-grid {
              gap: 16px;
            }
          }
          @media (min-width: 768px) {
            .pillar-grid {
              grid-template-columns: repeat(4, minmax(0, 1fr));
            }
            .pillar-grid > a:first-child {
              grid-column: auto;
            }
            .homepage-header {
              padding: 32px 0 0;
            }
            .hero-shell {
              padding-top: 40px;
              padding-bottom: 60px;
            }
            #main-nav {
              position: sticky !important;
              transform: translateY(0) !important;
            }
          }
        </style>
        ${renderNavStyles()}
    </head>
    <body class="bg-wiki-bg text-wiki-text min-h-screen">
        ${!isHomepage ? `${renderNav(renderUserMenu(user))}` : ''}
        
        <!-- Main Content -->
        <main class="${isHomepage ? '' : 'mx-auto pt-[65px] md:pt-0'}">
            ${content}
        </main>
        ${renderNavScripts()}
        
        <!-- Footer - Minimal with Beaver Nest Style -->
        <style>
            .footer-nav-link {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 14px;
                border-radius: 8px;
                font-size: 0.8125rem;
                font-weight: 500;
                letter-spacing: 0.02em;
                color: rgba(200, 210, 255, 0.85);
                background: transparent;
                border: none;
                transition: all 0.2s ease;
                position: relative;
                white-space: nowrap;
            }
            .footer-nav-link::after {
                content: '';
                position: absolute;
                bottom: 4px;
                left: 14px;
                right: 14px;
                height: 2px;
                background: linear-gradient(90deg, #4361ee, #64b5f6);
                border-radius: 1px;
                transform: scaleX(0);
                transition: transform 0.2s ease;
            }
            .footer-nav-link:hover {
                color: #ffffff;
                background: rgba(100, 181, 246, 0.1);
            }
            .footer-nav-link:hover::after {
                transform: scaleX(1);
            }
        </style>
        <footer class="relative mt-20 border-t border-wiki-border/30">
            <div class="max-w-6xl mx-auto px-6 py-10">
                <!-- Mobile: Logo top, Buttons in 2x2 grid below -->
                <div class="flex md:hidden flex-col gap-6">
                    <!-- Logo - centered (모바일에서 숨김) -->
                    <a href="/" class="hidden mx-auto opacity-80 hover:opacity-100 transition-opacity">
                        ${getLogoSVG('small')}
                    </a>
                    
                    <!-- Navigation Links - Single row on mobile -->
                    <nav class="flex flex-wrap items-center justify-center gap-2">
                        <a href="/analyzer" class="footer-nav-link">AI 분석</a>
                        <a href="/job" class="footer-nav-link">직업위키</a>
                        <a href="/major" class="footer-nav-link">전공위키</a>
                        <a href="/howto" class="footer-nav-link">HowTo</a>
                    </nav>
                </div>
                    
                <!-- Mobile: Copyright & Links (below) -->
                <div class="flex md:hidden flex-col items-center gap-3 pt-6 border-t border-wiki-border/20">
                    <div class="flex items-center gap-4 text-wiki-muted/60" style="font-size: 14px;">
                        <a href="/terms" class="hover:text-wiki-muted transition-colors">이용약관</a>
                        <span class="text-wiki-muted/30">|</span>
                        <a href="/privacy" class="hover:text-wiki-muted transition-colors">개인정보처리방침</a>
                    </div>
                    <span class="text-wiki-text font-semibold" style="font-size: 15px;">© 2025 Careerwiki</span>
                </div>
                
                <!-- Desktop: Original horizontal layout -->
                <div class="hidden md:flex items-center justify-between gap-8">
                    <!-- Logo -->
                    <a href="/" class="shrink-0 opacity-80 hover:opacity-100 transition-opacity">
                        ${getLogoSVG('small')}
                    </a>
                    
                    <!-- Navigation Links - Horizontal -->
                    <nav class="flex flex-wrap items-center gap-4">
                        <a href="/analyzer" class="footer-nav-link">AI 분석</a>
                        <a href="/job" class="footer-nav-link">직업위키</a>
                        <a href="/major" class="footer-nav-link">전공위키</a>
                        <a href="/howto" class="footer-nav-link">HowTo</a>
                    </nav>
                    
                    <!-- Copyright & Links -->
                    <div class="flex flex-col items-end gap-2">
                        <div class="flex items-center gap-4 text-wiki-muted/60" style="font-size: 14px;">
                            <a href="/terms" class="hover:text-wiki-muted transition-colors">이용약관</a>
                            <span class="text-wiki-muted/30">|</span>
                            <a href="/privacy" class="hover:text-wiki-muted transition-colors">개인정보처리방침</a>
                        </div>
                        <span class="text-wiki-text font-semibold" style="font-size: 15px;">© 2025 Careerwiki</span>
                    </div>
                </div>
            </div>
        </footer>
        
        <script>
            // Mobile header auto-hide on scroll
            let lastScrollTop = 0;
            let isNavVisible = true;
            const nav = document.getElementById('main-nav');
            const mobileMenu = document.getElementById('mobile-menu');
            const isMobile = window.innerWidth < 768;
            
            if (isMobile && nav) {
                window.addEventListener('scroll', () => {
                    const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
                    
                    if (scrollTop > lastScrollTop && scrollTop > 100) {
                        // Scrolling down & past 100px
                        nav.style.transform = 'translateY(-100%)';
                        isNavVisible = false;
                        if (mobileMenu) mobileMenu.classList.add('hidden');
                    } else if (scrollTop < lastScrollTop) {
                        // Scrolling up
                        nav.style.transform = 'translateY(0)';
                        isNavVisible = true;
                    }
                    
                    lastScrollTop = scrollTop;
                });
                
                // Show nav on empty area tap
                document.addEventListener('click', (e) => {
                    if (!isNavVisible && 
                        !e.target.closest('a') && 
                        !e.target.closest('button') && 
                        !e.target.closest('input') && 
                        !e.target.closest('nav')) {
                        nav.style.transform = 'translateY(0)';
                        isNavVisible = true;
                    }
                });
            }
            
            // Mobile menu toggle
            const menuBtn = document.getElementById('mobile-menu-btn');
            if(menuBtn) {
                menuBtn.addEventListener('click', () => {
                    mobileMenu.classList.toggle('hidden');
                });
            }
            
            // 로그아웃 시 현재 페이지로 돌아오도록 return_url 설정
            document.querySelectorAll('.logout-return-url').forEach(input => {
                input.value = window.location.pathname + window.location.search;
            });
        </script>
        
        <!-- 플로팅 네비게이션 버튼 -->
        <div class="floating-nav" id="floating-nav">
            <button class="floating-nav-btn floating-nav-scroll-top" id="scroll-top-btn" onclick="scrollToTop()" aria-label="맨 위로 이동">
                <i class="fas fa-arrow-up"></i>
                <span class="label">맨 위로</span>
            </button>
            <button class="floating-nav-btn" id="toc-btn" onclick="scrollToTOC()" aria-label="목차로 이동">
                <i class="fas fa-list"></i>
                <span class="label">목차</span>
            </button>
            <button class="floating-nav-btn" id="comments-btn" onclick="scrollToComments()" aria-label="댓글로 이동">
                <i class="fas fa-comment"></i>
                <span class="label">댓글</span>
            </button>
        </div>
        
        <script>
            // 플로팅 네비게이션 함수
            function scrollToTop() {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
            
            function scrollToTOC() {
                // 탭 네비게이션 (개요 상세정보 탭)으로 이동
                const tablist = document.querySelector('[role="tablist"][aria-label*="직업"][aria-label*="탭"], [role="tablist"][aria-label*="전공"][aria-label*="탭"]');
                if (tablist) {
                    // 헤더 높이 고려 (약 80px + 여유 20px)
                    const headerOffset = 100;
                    const elementPosition = tablist.getBoundingClientRect().top;
                    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                    
                    window.scrollTo({
                        top: offsetPosition,
                        behavior: 'smooth'
                    });
                } else {
                    // 탭리스트가 없으면 첫 번째 카드로
                    const firstCard = document.querySelector('[data-cw-detail-card]');
                    if (firstCard) {
                        const headerOffset = 100;
                        const elementPosition = firstCard.getBoundingClientRect().top;
                        const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                        
                        window.scrollTo({
                            top: offsetPosition,
                            behavior: 'smooth'
                        });
                    } else {
                        scrollToTop();
                    }
                }
            }
            
            function scrollToComments() {
                const comments = document.getElementById('cw-comments');
                if (comments) {
                    // 헤더 높이 고려 (약 80px + 여유 20px)
                    const headerOffset = 100;
                    const elementPosition = comments.getBoundingClientRect().top;
                    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                    
                    window.scrollTo({
                        top: offsetPosition,
                        behavior: 'smooth'
                    });
                } else {
                    // 댓글이 없으면 페이지 하단으로
                    window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
                }
            }
            
            // 페이지 타입 감지 및 플로팅 네비게이션 설정
            (function() {
                const path = window.location.pathname;
                const isDetailPage = path.startsWith('/job/') || path.startsWith('/major/') || path.startsWith('/howto/');
                
                const scrollTopBtn = document.getElementById('scroll-top-btn');
                const tocBtn = document.getElementById('toc-btn');
                const commentsBtn = document.getElementById('comments-btn');
                
                if (!isDetailPage) {
                    // 상세 페이지가 아니면 목차와 댓글 버튼 숨기기
                    if (tocBtn) tocBtn.style.display = 'none';
                    if (commentsBtn) commentsBtn.style.display = 'none';
                    
                    // 맨위로 버튼은 스크롤 시 표시
                    if (scrollTopBtn) {
                        scrollTopBtn.classList.remove('floating-nav-scroll-top');
                        scrollTopBtn.style.display = 'none';
                        
                        window.addEventListener('scroll', function() {
                            if (window.pageYOffset > 300) {
                                scrollTopBtn.style.display = 'flex';
                            } else {
                                scrollTopBtn.style.display = 'none';
                            }
                        });
                    }
                } else {
                    // 상세 페이지에서는 맨위로 버튼 스크롤에 따라 표시
                    if (scrollTopBtn) {
                        window.addEventListener('scroll', function() {
                            if (window.pageYOffset > 300) {
                                scrollTopBtn.classList.add('visible');
                            } else {
                                scrollTopBtn.classList.remove('visible');
                            }
                        });
                    }
            }
          })();
        </script>
        
        <script src="/static/api-client.js?v=${Date.now()}"></script>
        
        <!-- 편집 시스템 -->
        <link rel="stylesheet" href="/static/edit-mode.css?v=${Date.now()}">
        <script src="/static/edit-mode.js?v=${Date.now()}"></script>
        
        <!-- 북마크(저장) 기능 -->
        <script>
          (function() {
            const SAVED_CLASS = 'bookmark-saved';
            const SAVED_COLOR = 'text-amber-400';
            const SAVED_BORDER = 'border-amber-400/50';
            
            async function initBookmarks() {
              const btns = document.querySelectorAll('[data-bookmark-btn]');
              if (btns.length === 0) return;
              
              // 각 버튼의 저장 상태 확인
              for (const btn of btns) {
                const type = btn.dataset.bookmarkType;
                const slug = btn.dataset.bookmarkSlug;
                if (!type || !slug) continue;
                
                try {
                  const res = await fetch('/api/bookmark/' + type + '/' + encodeURIComponent(slug));
                  const data = await res.json();
                  if (data.saved) {
                    markAsSaved(btn, true);
                  }
                } catch (e) {
                  // 무시
                }
              }
              
              // 클릭 이벤트 등록
              document.addEventListener('click', handleBookmarkClick);
            }
            
            async function handleBookmarkClick(e) {
              const btn = e.target.closest('[data-bookmark-btn]');
              if (!btn) return;
              
              const type = btn.dataset.bookmarkType;
              const slug = btn.dataset.bookmarkSlug;
              const title = btn.dataset.bookmarkTitle;
              
              if (!type || !slug) return;
              
              // 비로그인 사용자 체크
              btn.disabled = true;
              
              try {
                const res = await fetch('/api/bookmark', {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json' },
                  body: JSON.stringify({ type, slug, title })
                });
                
                const data = await res.json();
                
                if (data.error === 'not_logged_in') {
                  alert('로그인이 필요합니다.');
                  const currentPath = window.location.pathname + window.location.search;
                  window.location.href = '/auth/google?return_url=' + encodeURIComponent(currentPath);
                  return;
                }
                
                if (data.success) {
                  // saved가 true면 +1, false면 -1
                  const countDelta = data.saved ? 1 : -1;
                  markAsSaved(btn, data.saved, countDelta);
                }
              } catch (e) {
                console.error('[bookmark]', e);
                alert('저장 중 오류가 발생했습니다.');
              } finally {
                btn.disabled = false;
              }
            }
            
            function markAsSaved(btn, saved, countDelta = 0) {
              const icon = btn.querySelector('i.fa-bookmark');
              const countEl = btn.querySelector('[data-bookmark-count]');
              
              // 카운트 업데이트
              if (countEl && countDelta !== 0) {
                const currentCount = parseInt(countEl.textContent) || 0;
                countEl.textContent = Math.max(0, currentCount + countDelta);
              }
              
              if (saved) {
                btn.classList.add(SAVED_CLASS, SAVED_COLOR, SAVED_BORDER);
                btn.classList.remove('text-wiki-muted', 'border-wiki-border/40');
                if (icon) icon.classList.add(SAVED_COLOR);
                btn.title = '저장 해제';
              } else {
                btn.classList.remove(SAVED_CLASS, SAVED_COLOR, SAVED_BORDER);
                btn.classList.add('text-wiki-muted', 'border-wiki-border/40');
                if (icon) icon.classList.remove(SAVED_COLOR);
                btn.title = '저장함에 추가';
              }
            }
            
            // 초기화
            if (document.readyState === 'loading') {
              document.addEventListener('DOMContentLoaded', initBookmarks);
            } else {
              initBookmarks();
            }
          })();
        </script>
    </body>
    </html>
  `
}

const SOURCE_LABEL_MAP: Record<DataSource, string> = {
  CAREERNET: '커리어넷',
  GOYONG24: '고용24',
  WORK24_JOB: '고용24 직업정보',
  WORK24_DJOB: '고용24 직업사전',
  WORK24_MAJOR: '고용24 학과정보',
  AI: 'AI 생성',
  USER_CONTRIBUTED: '사용자 기여',
  ADMIN_OVERRIDE: '관리자'
}

const DEFAULT_CANONICAL_ORIGIN = 'https://careerwiki.org'

const buildCanonicalUrl = (requestUrl: string, path: string): string => {
  try {
    const url = new URL(requestUrl)
    const { protocol, host, hostname } = url
    if (hostname === 'localhost' || hostname === '127.0.0.1') {
      return `${protocol}//${host}${path}`
    }
    if (hostname.endsWith('.pages.dev') || hostname === 'careerwiki.org' || hostname.endsWith('.careerwiki.org')) {
      return `${protocol}//${host}${path}`
    }
  } catch {
    // Ignore parsing errors and fall back to default origin
  }
  return `${DEFAULT_CANONICAL_ORIGIN}${path}`
}

const isAnalysisType = (value: unknown): value is AnalysisType => value === 'job' || value === 'major'
const isPricingTier = (value: unknown): value is PricingTier => value === 'free' || value === 'pro'
const isRequestStatus = (value: unknown): value is RequestStatus =>
  value === 'pending' || value === 'processing' || value === 'completed' || value === 'failed'
const isPageType = (value: unknown): value is PageType => value === 'job' || value === 'major' || value === 'guide'
const buildCommentPageSlug = (type: PageType, slug: string): string => `${type}:${slug.trim()}`
// slug에서 guide: prefix를 제거하는 헬퍼 함수
const cleanGuidePrefix = (slug: string): string => slug ? slug.replace(/^(guide:)+/g, '') : ''
const toParentId = (value: unknown): number | null => {
  if (value === null || value === undefined) {
    return null
  }
  const parsed = Number(value)
  if (!Number.isFinite(parsed)) {
    return null
  }
  const normalized = Math.floor(parsed)
  return normalized > 0 ? normalized : null
}

// Phase 3 Day 4: IP 주소 가져오기 헬퍼 함수
const getClientIp = (c: Context): string => {
  // Cloudflare Workers에서는 CF-Connecting-IP 사용
  const cfIp = c.req.header('cf-connecting-ip')
  if (cfIp) return cfIp
  
  // X-Forwarded-For 헤더 확인 (첫 번째 IP만 사용)
  const forwarded = c.req.header('x-forwarded-for')
  if (forwarded) {
    const ips = forwarded.split(',').map(ip => ip.trim()).filter(Boolean)
    if (ips.length > 0) return ips[0]
  }
  
  // X-Real-IP 헤더 확인
  const realIp = c.req.header('x-real-ip')
  if (realIp) return realIp
  
  // 로컬 환경 fallback - 127.0.0.1 사용
  return '127.0.0.1'
}

// Homepage - Google style with menu buttons
app.get('/', (c) => {
  // Phase 3 Day 4: 사용자 정보 가져오기
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  
  const content = `
    <div class="w-full min-h-screen flex flex-col">
        <header class="homepage-header">
            <div class="mx-auto w-full max-w-[1400px] px-3 flex items-center">
                <div class="flex-grow"></div>
                <div class="flex items-center gap-0">
                    <a href="/help" class="header-icon-button px-2" title="도움말">
                        <i class="fas fa-question-circle text-base"></i>
                    </a>
                    ${renderUserMenu(userData)}
                </div>
            </div>
        </header>

        <section class="hero-shell flex-grow">
            <div class="hero-inner">
                <div class="flex justify-center">
                    ${getLogoSVG('large')}
                </div>
                <div class="search-shell">
                    <form action="/search" method="get">
                        <div class="search-bar">
                            <input type="text" name="q" 
                                   placeholder="직업 · 전공 검색" 
                                   autofocus>
                            <button type="submit" class="search-button" aria-label="검색">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                </div>
                <div class="pillar-grid w-full">
                    <a href="/analyzer" class="menu-button text-center group">
                        <i class="fas fa-brain text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                        <div class="text-sm">AI 분석</div>
                    </a>
                    <a href="/job" class="menu-button text-center group">
                        <i class="fas fa-briefcase text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                        <div class="text-sm">직업위키</div>
                    </a>
                    <a href="/major" class="menu-button text-center group">
                        <i class="fas fa-university text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                        <div class="text-sm">전공위키</div>
                    </a>
                    <a href="/howto" class="menu-button text-center group">
                        <i class="fas fa-route text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                        <div class="text-sm">HowTo</div>
                    </a>
                </div>
            </div>
        </section>
    </div>
  `
  
  return c.html(renderLayout(content, 'Careerwiki - AI 진로 분석 플랫폼', 'AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 플랫폼', true, { user: userData }))
})

// Phase 3 Day 4: renderLayout 헬퍼 함수 (자동으로 context 전달)
const renderLayoutWithContext = (
  c: Context,
  content: string,
  title?: string,
  description?: string,
  isHomepage?: boolean,
  options?: {
    extraHead?: string
    canonical?: string
    ogUrl?: string
    user?: { id: number; name: string | null; email: string; role: string; picture_url: string | null; custom_picture_url?: string | null; username: string | null } | null
  }
) => {
  return renderLayout(content, title, description, isHomepage, { ...options, context: c })
}

// AI Analyzer Page - Choose between Job or Major
app.get('/analyzer', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto px-4 md:mt-8">
        <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
            <i class="fas fa-brain mr-3"></i>AI 커리어 분석기
        </h1>
        
        <div class="glass-card p-8 rounded-2xl">
            <h2 class="text-2xl font-bold mb-6 text-center">무엇을 추천받고 싶으신가요?</h2>
            
            <div class="grid md:grid-cols-2 gap-8 mt-8">
                <!-- Job Recommendation -->
                <a href="/analyzer/job" class="glass-card p-8 rounded-xl hover-glow block text-center group">
                    <i class="fas fa-briefcase text-6xl mb-4 text-wiki-secondary group-hover:text-wiki-primary transition"></i>
                    <h3 class="text-2xl font-bold mb-3">직업 추천</h3>
                    <p class="text-wiki-muted">
                        나의 성향, 능력, 가치관을 바탕으로<br>
                        적합한 직업을 AI가 추천해드립니다
                    </p>
                    <div class="mt-6">
                        <span class="px-6 py-3 bg-wiki-primary text-white rounded-lg inline-block group-hover:bg-blue-600 transition">
                            직업 추천받기 →
                        </span>
                    </div>
                </a>
                
                <!-- Major Recommendation -->
                <a href="/analyzer/major" class="glass-card p-8 rounded-xl hover-glow block text-center group">
                    <i class="fas fa-university text-6xl mb-4 text-wiki-secondary group-hover:text-wiki-primary transition"></i>
                    <h3 class="text-2xl font-bold mb-3">전공 추천</h3>
                    <p class="text-wiki-muted">
                        나의 적성, 흥미, 목표를 분석하여<br>
                        최적의 전공을 AI가 추천해드립니다
                    </p>
                    <div class="mt-6">
                        <span class="px-6 py-3 bg-wiki-primary text-white rounded-lg inline-block group-hover:bg-blue-600 transition">
                            전공 추천받기 →
                        </span>
                    </div>
                </a>
            </div>
            
            <div class="mt-12 text-center text-wiki-muted text-sm">
                <p>AI 분석은 개인정보를 안전하게 처리하며, 결과는 참고용으로만 활용하시기 바랍니다.</p>
            </div>
        </div>
    </div>
  `
  
  return c.html(renderLayoutWithContext(c, content, 'AI 커리어 분석기 - Careerwiki'))
})

// AI Job Analyzer v2.0.0 (Stage-based Universal Intake + Follow-up)
app.get('/analyzer/job', (c) => {
  const debugMode = c.req.query('debug') === 'true'
  
  // Universal Questions 데이터 (서버 사이드)
  const universalQuestionsJson = JSON.stringify([
    { id: 'univ_interest', order: 1, text: '어떤 것에 관심이 있거나 재미있다고 느끼나요?', ui_type: 'chips', options: [
      { value: 'tech', label: '기술/IT', emoji: '💻' }, { value: 'art', label: '예술/창작', emoji: '🎨' },
      { value: 'people', label: '사람/소통', emoji: '👥' }, { value: 'nature', label: '자연/환경', emoji: '🌿' },
      { value: 'numbers', label: '숫자/분석', emoji: '📊' }, { value: 'health', label: '건강/의료', emoji: '🏥' },
      { value: 'business', label: '비즈니스', emoji: '💼' }, { value: 'education', label: '교육/가르침', emoji: '📚' },
      { value: 'sports', label: '스포츠/활동', emoji: '⚽' }, { value: 'media', label: '미디어/콘텐츠', emoji: '📱' },
    ], allow_unknown: true, unknown_label: '잘 모르겠어요', fact_key: 'profile.interest.keywords', required: true, max_selections: 5 },
    { id: 'univ_dislike', order: 2, text: '이건 피하고 싶다고 느끼는 게 있나요?', ui_type: 'chips', options: [
      { value: 'overtime', label: '야근/긴 근무', emoji: '🌙' }, { value: 'meeting', label: '회의 많음', emoji: '🗣️' },
      { value: 'sales', label: '영업/설득', emoji: '🤝' }, { value: 'routine', label: '단순 반복', emoji: '🔄' },
      { value: 'pressure', label: '압박/마감', emoji: '⏰' }, { value: 'travel', label: '잦은 출장', emoji: '✈️' },
      { value: 'physical', label: '육체적 힘듦', emoji: '💪' }, { value: 'conflict', label: '갈등/대립', emoji: '⚡' },
      { value: 'public', label: '발표/앞에 서기', emoji: '🎤' }, { value: 'uncertainty', label: '불확실함', emoji: '❓' },
    ], allow_unknown: true, unknown_label: '딱히 없어요', fact_key: 'profile.dislike.keywords', required: true, max_selections: 5 },
    { id: 'univ_workstyle_social', order: 3, text: '뭔가를 할 때, 어떤 방식이 더 편한가요?', ui_type: 'radio', options: [
      { value: 'solo', label: '혼자 집중하는 게 좋아요', emoji: '🧘' }, { value: 'team', label: '여럿이 함께하는 게 좋아요', emoji: '👫' },
      { value: 'mixed', label: '상황에 따라 달라요', emoji: '🔀' },
    ], allow_unknown: true, unknown_label: '모르겠어요', fact_key: 'profile.workstyle.social', required: true },
    { id: 'univ_workstyle_structure', order: 4, text: '일이나 공부할 때, 어떤 환경이 더 맞나요?', ui_type: 'radio', options: [
      { value: 'structured', label: '정해진 규칙/절차가 있는 게 좋아요', emoji: '📋' }, { value: 'flexible', label: '자유롭게 스스로 정하는 게 좋아요', emoji: '🦋' },
      { value: 'mixed', label: '상황에 따라 달라요', emoji: '🔀' },
    ], allow_unknown: true, unknown_label: '모르겠어요', fact_key: 'profile.workstyle.structure', required: true },
    { id: 'univ_priority', order: 5, text: '일(또는 미래 직업)에서 가장 중요하게 생각하는 건 뭔가요?', ui_type: 'radio', options: [
      { value: 'growth', label: '배우고 성장하는 것', emoji: '🌱' }, { value: 'stability', label: '안정적이고 예측 가능한 것', emoji: '🏠' },
      { value: 'wlb', label: '일과 생활의 균형', emoji: '⚖️' }, { value: 'income', label: '높은 수입', emoji: '💰' },
      { value: 'meaning', label: '의미 있는 일, 사회 기여', emoji: '🌍' }, { value: 'recognition', label: '인정받고 영향력 발휘', emoji: '⭐' },
    ], allow_unknown: true, unknown_label: '아직 모르겠어요', fact_key: 'priority.top1', required: true },
    { id: 'univ_constraint_time', order: 6, text: '시간/근무 관련해서 꼭 피해야 하는 조건이 있나요?', ui_type: 'checkbox', options: [
      { value: 'work_hours_strict', label: '야근/긴 근무 절대 불가' }, { value: 'shift_work_no', label: '교대근무 불가' }, { value: 'weekend_no', label: '주말근무 불가' },
    ], allow_unknown: true, unknown_label: '해당 없음', fact_key: 'profile.constraints.time', required: false },
    { id: 'univ_constraint_location', order: 7, text: '장소/이동 관련해서 꼭 피해야 하는 조건이 있나요?', ui_type: 'checkbox', options: [
      { value: 'remote_only', label: '재택/원격만 가능' }, { value: 'travel_no', label: '출장 불가' }, { value: 'region_fixed', label: '특정 지역만 가능' },
    ], allow_unknown: true, unknown_label: '해당 없음', fact_key: 'profile.constraints.location', required: false },
    { id: 'univ_strength', order: 9, text: '스스로 잘한다고 느끼거나, 남들이 인정해준 적 있는 것이 있나요?', ui_type: 'chips', options: [
      { value: 'analysis', label: '분석/논리', emoji: '🧠' }, { value: 'creative', label: '창의/아이디어', emoji: '💡' },
      { value: 'communication', label: '소통/설명', emoji: '💬' }, { value: 'organization', label: '정리/계획', emoji: '📑' },
      { value: 'persistence', label: '끈기/인내', emoji: '🏋️' }, { value: 'learning', label: '빠른 학습', emoji: '📖' },
      { value: 'empathy', label: '공감/배려', emoji: '❤️' }, { value: 'leadership', label: '리더십', emoji: '👑' },
    ], allow_unknown: true, unknown_label: '잘 모르겠어요', fact_key: 'profile.strength.keywords', required: false, max_selections: 4 },
    { id: 'univ_life_constraint', order: 12, text: '현재 특별히 고려해야 할 상황이 있나요?', ui_type: 'checkbox', options: [
      { value: 'health', label: '건강 상 제약', emoji: '🏥' }, { value: 'disability', label: '장애', emoji: '♿' },
      { value: 'caregiving', label: '돌봄 (가족/자녀)', emoji: '👨‍👩‍👧' }, { value: 'military', label: '군 복무 관련', emoji: '🎖️' },
      { value: 'finance_pressure', label: '경제적 압박', emoji: '💵' },
    ], allow_unknown: true, unknown_label: '해당 없음', fact_key: 'profile.life_constraint', required: false },
  ])
  
  // Job Stages 메타데이터
  const jobStagesJson = JSON.stringify([
    { id: 'job_explore', label: '탐색 단계', description: '아직 경험이 거의 없어요', emoji: '🔍' },
    { id: 'job_student', label: '학생 (전공 연계)', description: '현재 학생이에요', emoji: '🎓' },
    { id: 'job_prepare', label: '취업 준비 중', description: '곧 취업 예정이에요', emoji: '📝' },
    { id: 'job_early', label: '초기 커리어 (0~3년)', description: '일 시작한 지 얼마 안 됐어요', emoji: '🌱' },
    { id: 'job_mid', label: '경력자 (3년+)', description: '경력이 좀 쌓였어요', emoji: '🚀' },
    { id: 'job_transition', label: '전환/복귀', description: '업종 전환 또는 재취업', emoji: '🔄' },
    { id: 'job_second', label: '세컨드 커리어', description: '은퇴 후 새 시작', emoji: '🌅' },
  ])
  
  // 미성년/탐색 단계 목록
  const minorStages = ['job_explore', 'major_child', 'major_elementary', 'major_middle']
  
  const content = `
    <div class="max-w-4xl mx-auto px-4 md:mt-8">
        <h1 class="text-3xl font-bold mb-6 text-center">
            <i class="fas fa-briefcase mr-3 text-wiki-secondary"></i>AI 직업 추천
            ${debugMode ? '<span class="ml-2 text-sm bg-yellow-500 text-black px-2 py-1 rounded">DEBUG MODE</span>' : ''}
        </h1>
        
        <!-- Step Indicator -->
        <div class="flex justify-center items-center gap-2 mb-8" id="step-indicator">
            <div class="step-dot flex flex-col items-center active" data-step="0">
                <span class="w-8 h-8 flex items-center justify-center bg-wiki-primary text-white rounded-full font-bold text-sm">0</span>
                <span class="text-xs mt-1 hidden md:block">유형</span>
            </div>
            <div class="w-6 h-0.5 bg-wiki-border"></div>
            <div class="step-dot flex flex-col items-center" data-step="1">
                <span class="w-8 h-8 flex items-center justify-center bg-wiki-border text-wiki-muted rounded-full font-bold text-sm">1</span>
                <span class="text-xs mt-1 hidden md:block">단계</span>
            </div>
            <div class="w-6 h-0.5 bg-wiki-border"></div>
            <div class="step-dot flex flex-col items-center" data-step="2">
                <span class="w-8 h-8 flex items-center justify-center bg-wiki-border text-wiki-muted rounded-full font-bold text-sm">2</span>
                <span class="text-xs mt-1 hidden md:block">기본</span>
            </div>
            <div class="w-6 h-0.5 bg-wiki-border"></div>
            <div class="step-dot flex flex-col items-center" data-step="3">
                <span class="w-8 h-8 flex items-center justify-center bg-wiki-border text-wiki-muted rounded-full font-bold text-sm">3</span>
                <span class="text-xs mt-1 hidden md:block">심화</span>
            </div>
            <div class="w-6 h-0.5 bg-wiki-border"></div>
            <div class="step-dot flex flex-col items-center" data-step="4">
                <span class="w-8 h-8 flex items-center justify-center bg-wiki-border text-wiki-muted rounded-full font-bold text-sm">4</span>
                <span class="text-xs mt-1 hidden md:block">결과</span>
            </div>
        </div>
        
        <!-- ============================================ -->
        <!-- Step 0: 분석 유형 선택 -->
        <!-- ============================================ -->
        <div id="step0" class="step-content glass-card p-8 rounded-2xl mb-6">
            <h2 class="text-2xl font-bold mb-6 text-center">무엇을 추천받고 싶으세요?</h2>
            <div class="grid md:grid-cols-2 gap-6">
                <button type="button" onclick="selectAnalysisType('job')"
                        class="analysis-type-btn p-8 bg-wiki-bg rounded-2xl border-2 border-wiki-border hover:border-wiki-primary transition group">
                    <div class="text-5xl mb-4">💼</div>
                    <div class="text-xl font-bold mb-2 group-hover:text-wiki-primary">직업 추천</div>
                    <div class="text-sm text-wiki-muted">나에게 맞는 직업을 찾아보세요</div>
                </button>
                <a href="/analyzer/major"
                   class="analysis-type-btn p-8 bg-wiki-bg rounded-2xl border-2 border-wiki-border hover:border-wiki-secondary transition group block text-center">
                    <div class="text-5xl mb-4">🎓</div>
                    <div class="text-xl font-bold mb-2 group-hover:text-wiki-secondary">전공 추천</div>
                    <div class="text-sm text-wiki-muted">나에게 맞는 전공을 찾아보세요</div>
                </a>
            </div>
        </div>
        
        <!-- ============================================ -->
        <!-- Step 1: Stage 선택 -->
        <!-- ============================================ -->
        <div id="step1" class="step-content hidden glass-card p-8 rounded-2xl mb-6">
            <h2 class="text-2xl font-bold mb-2 text-center">현재 상황을 선택해주세요</h2>
            <p class="text-center text-wiki-muted mb-6">더 정확한 질문과 추천을 위해 필요해요</p>
            
            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-4" id="stage-options">
                <!-- JS로 동적 생성 -->
            </div>
            
            <div class="text-center mt-6">
                <button type="button" onclick="goToStep(0)" class="text-wiki-muted hover:text-white text-sm">
                    <i class="fas fa-arrow-left mr-1"></i>이전으로
                </button>
            </div>
        </div>
        
        <div id="step2" class="step-content hidden glass-card p-8 rounded-2xl mb-6">
            <h2 class="text-xl font-bold mb-2 text-center">
                <i class="fas fa-rocket text-wiki-primary mr-2"></i>기본 정보 (30~60초)
            </h2>
            <p class="text-center text-wiki-muted mb-6 text-sm">
                경험이 없어도 괜찮아요! 느낌대로 선택하시면 됩니다.
            </p>
            
            <form id="universal-form">
                <div id="universal-questions" class="space-y-6">
                    <!-- JS로 동적 생성 -->
                </div>
                
                <div class="flex justify-center gap-4 pt-6">
                    <button type="button" onclick="goToStep(1)"
                            class="px-6 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg transition">
                        <i class="fas fa-arrow-left mr-2"></i>이전
                    </button>
                    <button type="button" onclick="submitUniversalAndContinue()"
                            class="px-8 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-primary transition">
                        <i class="fas fa-forward mr-2"></i>더 정확한 추천 받기
                    </button>
                    <button type="button" onclick="submitUniversalAndAnalyze()" id="analyze-btn-quick"
                            class="px-10 py-4 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold rounded-xl hover-glow transition">
                        <i class="fas fa-magic mr-2"></i>바로 결과 보기
                    </button>
                </div>
            </form>
        </div>
        
        <!-- ============================================ -->
        <!-- Step 3: Stage-based Follow-up -->
        <!-- ============================================ -->
        <div id="step3" class="step-content hidden glass-card p-8 rounded-2xl mb-6">
            <h2 class="text-xl font-bold mb-2 text-center">
                <i class="fas fa-user-astronaut text-purple-400 mr-2"></i>심화 질문 (2~4분)
            </h2>
            <p class="text-center text-wiki-muted mb-6 text-sm" id="step3-subtitle">
                더 정확한 추천을 위해 몇 가지 더 알려주세요. (스킵 가능)
            </p>
            
            <div id="followup-questions-form" class="space-y-6">
                <!-- JS로 동적 생성 -->
            </div>
            
            <div class="flex justify-center gap-4 pt-6">
                <button type="button" onclick="goToStep(2)"
                        class="px-6 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg transition">
                    <i class="fas fa-arrow-left mr-2"></i>이전
                </button>
                <button type="button" onclick="submitFollowupsAndAnalyze()" id="analyze-btn"
                        class="px-12 py-4 bg-gradient-to-r from-purple-500 to-wiki-secondary text-white font-bold rounded-xl hover-glow transition transform hover:scale-105">
                    <i class="fas fa-magic mr-2"></i>AI 분석 시작하기
                </button>
            </div>
        </div>
        
        <!-- ============================================ -->
        <!-- Step 4: 결과 영역 -->
        <!-- ============================================ -->
        <div id="step4" class="step-content hidden">
            <!-- User Insight 카드 -->
            <div id="user-insight-card" class="glass-card p-6 rounded-2xl mb-6 border border-purple-500/50 hidden">
                <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
                    <span class="text-2xl">✨</span>
                    <span class="bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">
                        당신에 대한 인사이트
                    </span>
                </h2>
                <p id="insight-summary" class="text-lg mb-4">-</p>
                
                <div id="insight-traits" class="space-y-3 mb-4">
                    <!-- JS로 채워짐 -->
                </div>
                
                <div id="insight-applied-facts" class="text-sm text-wiki-muted border-t border-wiki-border pt-3 hidden">
                    <span class="font-semibold">적용된 정보:</span>
                    <span id="insight-facts-list">-</span>
                </div>
            </div>
            
            <!-- TOP3 추천 결과 -->
            <div class="glass-card p-8 rounded-2xl mb-6">
                <h2 class="text-2xl font-bold mb-6 text-center">
                    <i class="fas fa-trophy text-yellow-400 mr-2"></i>TOP 3 추천 직업
                </h2>
                <div id="top3-results" class="grid md:grid-cols-3 gap-4">
                    <!-- JS로 채워짐 -->
                </div>
            </div>
            
            <!-- 디버그 패널 (debug=true일 때만) -->
            ${debugMode ? `
            <div class="glass-card p-6 rounded-2xl mb-6 border border-yellow-500/50">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-lg font-bold text-yellow-400">
                        <i class="fas fa-bug mr-2"></i>디버그 패널 (Stage-based V3)
                    </h3>
                    <button onclick="toggleDebugPanel()" class="text-sm text-wiki-muted hover:text-white">접기/펼치기</button>
                </div>
                <div id="debug-panel-content">
                    <!-- 1. Candidate Source -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-database mr-1"></i>1. Candidate Source
                        </h4>
                        <div id="debug-candidate-source" class="text-white font-mono text-sm">-</div>
                    </div>
                    
                    <!-- 2. 점수 분해 -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-chart-bar mr-1"></i>2. 점수 분해 (TOP3)
                        </h4>
                        <div id="debug-score-breakdown" class="text-white font-mono text-xs overflow-x-auto">-</div>
                    </div>
                    
                    <!-- 3. Follow-up 근거 -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-question mr-1"></i>3. Follow-up 근거
                        </h4>
                        <div id="debug-followup-rationale" class="text-white font-mono text-sm">-</div>
                    </div>
                    
                    <!-- 4. Rank Change -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-exchange-alt mr-1"></i>4. Rank Change
                        </h4>
                        <div id="debug-rank-change" class="text-white font-mono text-sm">-</div>
                    </div>
                    
                    <!-- 5. Applied Facts & Rules -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-cog mr-1"></i>5. Applied Facts & Rules
                        </h4>
                        <div id="debug-applied-facts" class="text-white font-mono text-xs max-h-32 overflow-y-auto">-</div>
                    </div>
                    
                    <!-- 6. 버전 정보 -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-code-branch mr-1"></i>6. 버전 정보
                        </h4>
                        <div id="debug-versions" class="text-white font-mono text-sm">-</div>
                    </div>
                    
                    <!-- Diversity/Phase4 상태 -->
                    <div class="p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-shield-alt mr-1"></i>Phase4 상태
                        </h4>
                        <div id="debug-phase4-status" class="text-white font-mono text-sm">-</div>
                    </div>
                </div>
            </div>
            ` : ''}
            
            <!-- 추가 Follow-up 질문 (결과 후) -->
            <div id="result-followup-section" class="glass-card p-6 rounded-2xl mb-6 hidden">
                <h3 class="text-xl font-bold mb-4">
                    <i class="fas fa-question-circle text-blue-400 mr-2"></i>더 정확한 추천을 위해
                </h3>
                <p id="result-followup-question" class="text-lg mb-4">-</p>
                <div id="result-followup-options" class="flex flex-wrap gap-3">
                    <!-- JS로 채워짐 -->
                </div>
            </div>
            
            <!-- 새 분석 버튼 -->
            <div class="text-center">
                <button onclick="resetAnalysis()" class="px-6 py-3 bg-wiki-card text-white rounded-lg hover:bg-wiki-primary transition">
                    <i class="fas fa-redo mr-2"></i>새로 분석하기
                </button>
            </div>
        </div>
    </div>
    
    <script>
        // ============================================
        // V3 Stage-based AI Analyzer
        // ============================================
        const DEBUG_MODE = ${debugMode};
        const UNIVERSAL_QUESTIONS = ${universalQuestionsJson};
        const JOB_STAGES = ${jobStagesJson};
        const MINOR_STAGES = ${JSON.stringify(minorStages)};
        
        // 상태 관리
        let currentStep = 0;
        let selectedAnalysisType = 'job';
        let selectedStage = null;
        let universalAnswers = {};
        let followupAnswers = {};
        let currentSessionId = null;
        let currentRequestId = null;
        let previousTop3 = [];
        
        // ============================================
        // Step 네비게이션
        // ============================================
        function goToStep(step) {
            currentStep = step;
            document.querySelectorAll('.step-content').forEach(el => el.classList.add('hidden'));
            const stepEl = document.getElementById('step' + step);
            if (stepEl) stepEl.classList.remove('hidden');
            
            // 인디케이터 업데이트
            document.querySelectorAll('.step-dot').forEach((el, idx) => {
                const circle = el.querySelector('span:first-child');
                if (idx <= step) {
                    circle.classList.remove('bg-wiki-border', 'text-wiki-muted');
                    circle.classList.add('bg-wiki-primary', 'text-white');
                } else {
                    circle.classList.add('bg-wiki-border', 'text-wiki-muted');
                    circle.classList.remove('bg-wiki-primary', 'text-white');
                }
            });
        }
        
        // ============================================
        // Step 0: 분석 유형 선택
        // ============================================
        function selectAnalysisType(type) {
            selectedAnalysisType = type;
            if (type === 'job') {
                renderStageOptions();
                goToStep(1);
            }
        }
        
        // ============================================
        // Step 1: Stage 선택
        // ============================================
        function renderStageOptions() {
            const container = document.getElementById('stage-options');
            container.innerHTML = JOB_STAGES.map(s => \`
                <button type="button" onclick="selectStage('\${s.id}')"
                        class="stage-btn p-4 bg-wiki-bg rounded-xl border border-wiki-border hover:border-wiki-primary transition text-left">
                    <div class="text-2xl mb-2">\${s.emoji}</div>
                    <div class="font-bold">\${s.label}</div>
                    <div class="text-xs text-wiki-muted">\${s.description}</div>
                </button>
            \`).join('');
        }
        
        function selectStage(stageId) {
            selectedStage = stageId;
            renderUniversalQuestions();
            goToStep(2);
        }
        
        // ============================================
        // Step 2: Universal Questions 렌더링
        // ============================================
        function renderUniversalQuestions() {
            const container = document.getElementById('universal-questions');
            const isMinor = MINOR_STAGES.includes(selectedStage);
            
            // 미성년 단계에서는 오픈텍스트 질문 숨김
            const filteredQuestions = UNIVERSAL_QUESTIONS.filter(q => {
                if (isMinor && q.ui_type === 'text') return false;
                return true;
            });
            
            container.innerHTML = filteredQuestions.map(q => renderUniversalQuestion(q, isMinor)).join('');
        }
        
        function renderUniversalQuestion(q, isMinor) {
            let optionsHtml = '';
            const requiredMark = q.required ? '<span class="text-red-400 ml-1">*</span>' : '';
            
            if (q.ui_type === 'chips' || q.ui_type === 'checkbox') {
                optionsHtml = \`
                    <div class="flex flex-wrap gap-2">
                        \${(q.options || []).map(opt => \`
                            <label class="chip-btn inline-flex items-center gap-1 px-3 py-2 bg-wiki-bg rounded-lg border border-wiki-border cursor-pointer hover:border-wiki-primary transition text-sm">
                                <input type="checkbox" name="\${q.id}" value="\${opt.value}" class="accent-wiki-primary hidden peer">
                                <span class="peer-checked:text-wiki-primary peer-checked:font-bold">\${opt.emoji || ''} \${opt.label}</span>
                            </label>
                        \`).join('')}
                        \${q.allow_unknown ? \`
                            <label class="chip-btn inline-flex items-center gap-1 px-3 py-2 bg-wiki-bg rounded-lg border border-wiki-border cursor-pointer hover:border-gray-500 transition text-sm">
                                <input type="checkbox" name="\${q.id}" value="_unknown" class="accent-gray-500 hidden peer">
                                <span class="peer-checked:text-gray-400 peer-checked:font-bold">❓ \${q.unknown_label}</span>
                            </label>
                        \` : ''}
                    </div>
                    \${q.max_selections ? \`<p class="text-xs text-wiki-muted mt-1">최대 \${q.max_selections}개 선택 가능</p>\` : ''}
                \`;
            } else if (q.ui_type === 'radio') {
                optionsHtml = \`
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-2">
                        \${(q.options || []).map(opt => \`
                            <label class="radio-btn flex items-center gap-2 p-3 bg-wiki-bg rounded-lg border border-wiki-border cursor-pointer hover:border-wiki-primary transition">
                                <input type="radio" name="\${q.id}" value="\${opt.value}" class="accent-wiki-primary">
                                <span>\${opt.emoji || ''} \${opt.label}</span>
                            </label>
                        \`).join('')}
                        \${q.allow_unknown ? \`
                            <label class="radio-btn flex items-center gap-2 p-3 bg-wiki-bg rounded-lg border border-wiki-border cursor-pointer hover:border-gray-500 transition">
                                <input type="radio" name="\${q.id}" value="_unknown" class="accent-gray-500">
                                <span>❓ \${q.unknown_label}</span>
                            </label>
                        \` : ''}
                    </div>
                \`;
            } else if (q.ui_type === 'text') {
                const privacyWarning = isMinor ? \`
                    <p class="text-xs text-yellow-400 mt-1">⚠️ 민감한 개인정보(주소/학교 이름/연락처/실명 등)는 작성하지 마세요.</p>
                \` : '';
                optionsHtml = \`
                    <textarea name="\${q.id}" rows="2" placeholder="\${q.placeholder || ''}"
                              class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none resize-none"></textarea>
                    \${privacyWarning}
                \`;
            }
            
            return \`
                <div class="question-block mb-6">
                    <label class="block text-lg font-semibold mb-3">\${q.text}\${requiredMark}</label>
                    \${optionsHtml}
                </div>
            \`;
        }
        
        // ============================================
        // Universal 답변 수집
        // ============================================
        function collectUniversalAnswers() {
            universalAnswers = {};
            UNIVERSAL_QUESTIONS.forEach(q => {
                if (q.ui_type === 'chips' || q.ui_type === 'checkbox') {
                    const checked = document.querySelectorAll(\`input[name="\${q.id}"]:checked\`);
                    const values = Array.from(checked).map(cb => cb.value).filter(v => v !== '_unknown');
                    if (values.length > 0) universalAnswers[q.id] = values;
                } else if (q.ui_type === 'radio') {
                    const selected = document.querySelector(\`input[name="\${q.id}"]:checked\`);
                    if (selected && selected.value !== '_unknown') universalAnswers[q.id] = selected.value;
                } else if (q.ui_type === 'text') {
                    const textarea = document.querySelector(\`textarea[name="\${q.id}"]\`);
                    if (textarea && textarea.value.trim()) universalAnswers[q.id] = textarea.value.trim();
                }
            });
            return universalAnswers;
        }
        
        // ============================================
        // Step 2 → Step 3 or Step 4
        // ============================================
        async function submitUniversalAndContinue() {
            collectUniversalAnswers();
            
            // API 호출하여 follow-up 질문 받기
            try {
                currentSessionId = 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        universal_answers: universalAnswers,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                console.log('Analysis response (for followups):', data);
                
                if (data.result?.followup_questions?.length > 0) {
                    renderFollowupQuestions(data.result.followup_questions);
                    goToStep(3);
                } else {
                    // Follow-up 질문이 없으면 바로 결과로
                    currentRequestId = data.request_id;
                    displayResults(data);
                    goToStep(4);
                }
            } catch (error) {
                console.error('Error:', error);
                alert('오류가 발생했습니다: ' + error.message);
            }
        }
        
        async function submitUniversalAndAnalyze() {
            collectUniversalAnswers();
            const btn = document.getElementById('analyze-btn-quick');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>분석 중...';
            
            try {
                currentSessionId = 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        universal_answers: universalAnswers,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                console.log('Analysis response:', data);
                
                if (!response.ok) throw new Error(data.error || 'API 오류');
                
                currentRequestId = data.request_id;
                displayResults(data);
                goToStep(4);
            } catch (error) {
                console.error('Error:', error);
                alert('분석 중 오류가 발생했습니다: ' + error.message);
            } finally {
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-magic mr-2"></i>바로 결과 보기';
            }
        }
        
        // ============================================
        // Step 3: Follow-up Questions 렌더링
        // ============================================
        function renderFollowupQuestions(questions) {
            const container = document.getElementById('followup-questions-form');
            container.innerHTML = questions.slice(0, 5).map((q, idx) => \`
                <div class="followup-question mb-6 p-4 bg-wiki-bg/50 rounded-lg">
                    <label class="block text-lg font-semibold mb-3">\${idx + 1}. \${q.question}</label>
                    <div class="flex flex-wrap gap-2">
                        \${(q.options || []).map(opt => \`
                            <label class="inline-flex items-center gap-1 px-4 py-2 bg-wiki-bg rounded-lg border border-wiki-border cursor-pointer hover:border-wiki-primary transition">
                                <input type="radio" name="followup_\${q.id}" value="\${opt.value}" data-fact-key="\${q.fact_key}" class="accent-wiki-primary">
                                <span>\${opt.label}</span>
                            </label>
                        \`).join('')}
                    </div>
                </div>
            \`).join('');
        }
        
        async function submitFollowupsAndAnalyze() {
            const btn = document.getElementById('analyze-btn');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>분석 중...';
            
            // Followup 답변 수집 및 제출
            try {
                const followupInputs = document.querySelectorAll('#followup-questions-form input[type="radio"]:checked');
                for (const input of followupInputs) {
                    const factKey = input.dataset.factKey;
                    const answer = input.value;
                    const questionId = input.name.replace('followup_', '');
                    
                    await fetch('/api/ai-analyzer/followup', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            session_id: currentSessionId,
                            question_id: questionId,
                            fact_key: factKey,
                            answer: answer,
                        })
                    });
                }
                
                // 재분석
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        universal_answers: universalAnswers,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                if (!response.ok) throw new Error(data.error || 'API 오류');
                
                currentRequestId = data.request_id;
                displayResults(data);
                goToStep(4);
            } catch (error) {
                console.error('Error:', error);
                alert('분석 중 오류가 발생했습니다: ' + error.message);
            } finally {
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-magic mr-2"></i>AI 분석 시작하기';
            }
        }
        
        // ============================================
        // Step 4: 결과 표시
        // ============================================
        function displayResults(data) {
            const result = data.result;
            const top3 = result.fit_top3 || [];
            
            // User Insight 표시
            displayUserInsight(result.user_insight);
            
            // TOP3 표시
            const top3Html = top3.map((job, idx) => \`
                <div class="bg-wiki-bg p-4 rounded-xl border border-wiki-border hover:border-wiki-primary transition">
                    <div class="flex items-center gap-2 mb-2">
                        <span class="text-2xl">\${idx === 0 ? '🥇' : idx === 1 ? '🥈' : '🥉'}</span>
                        <span class="text-lg font-bold">\${job.job_name}</span>
                    </div>
                    <div class="text-sm text-wiki-muted mb-2">Fit: \${job.fit_score}</div>
                    <div class="flex gap-2 text-xs">
                        <span class="px-2 py-1 bg-green-500/20 text-green-400 rounded">Like: \${job.like_score}</span>
                        <span class="px-2 py-1 bg-blue-500/20 text-blue-400 rounded">Can: \${job.can_score}</span>
                    </div>
                </div>
            \`).join('');
            document.getElementById('top3-results').innerHTML = top3Html || '<p class="text-wiki-muted col-span-3 text-center">추천 결과가 없습니다.</p>';
            
            // 디버그 패널 (debug=true)
            if (DEBUG_MODE) {
                updateDebugPanel(result, data);
            }
            
            // 추가 Follow-up 질문 (있으면)
            if (result.followup_questions?.length > 0) {
                displayResultFollowup(result.followup_questions[0]);
            }
            
            previousTop3 = top3.map(j => j.job_name);
        }
        
        function displayUserInsight(insight) {
            const card = document.getElementById('user-insight-card');
            if (!insight || !insight.summary) {
                card.classList.add('hidden');
                return;
            }
            
            card.classList.remove('hidden');
            document.getElementById('insight-summary').textContent = insight.summary;
            
            const traitsHtml = (insight.key_traits || []).map(t => \`
                <div class="flex items-start gap-3 p-3 bg-purple-500/10 rounded-lg">
                    <span class="text-xl">💡</span>
                    <div>
                        <div class="font-semibold text-purple-300">\${t.trait}</div>
                        <div class="text-sm text-wiki-muted">\${t.evidence}</div>
                        <div class="text-xs text-green-400 mt-1">→ \${t.score_impact}</div>
                    </div>
                </div>
            \`).join('');
            document.getElementById('insight-traits').innerHTML = traitsHtml;
            
            if (insight.applied_facts?.length > 0) {
                document.getElementById('insight-applied-facts').classList.remove('hidden');
                document.getElementById('insight-facts-list').textContent = 
                    insight.applied_facts.map(f => f.effect_summary).join(', ');
            }
        }
        
        function updateDebugPanel(result, data) {
            const debugInfo = result.debug_info;
            
            // 1. Candidate Source
            const sourceEl = document.getElementById('debug-candidate-source');
            if (sourceEl) {
                if (debugInfo) {
                    const sourceLabel = {
                        'tagged': '🏷️ tagged (DB)',
                        'sample_fallback': '⚠️ sample_fallback',
                        'vector': '🔍 vector',
                        'random': '🎲 random'
                    }[debugInfo.candidate_source] || debugInfo.candidate_source;
                    sourceEl.innerHTML = \`
                        <span class="text-yellow-400">\${sourceLabel}</span> | 
                        Stage: <span class="text-blue-400">\${selectedStage || '-'}</span> | 
                        Tagged: <span class="text-green-400">\${debugInfo.tagged_count}</span> / 
                        Total: <span class="text-white">\${debugInfo.total_in_db}</span>
                    \`;
                } else {
                    sourceEl.textContent = \`Stage: \${selectedStage || '-'}, Candidates: \${result.total_candidates || 0}\`;
                }
            }
            
            // 2. 점수 분해 (TOP3)
            const scoreEl = document.getElementById('debug-score-breakdown');
            if (scoreEl) {
                if (debugInfo?.score_breakdown) {
                    scoreEl.innerHTML = debugInfo.score_breakdown.map((s, i) => \`
                        <div class="mb-2 pb-2 \${i < 2 ? 'border-b border-slate-700' : ''}">
                            <div class="flex justify-between">
                                <span class="text-yellow-300">\${i+1}. \${s.job_name}</span>
                                <span class="text-green-400">Fit: \${s.final_fit}</span>
                            </div>
                            <div class="text-slate-400 text-xs">
                                Base: L\${s.base_like}/C\${s.base_can}/R\${s.base_risk} → 
                                Final: L\${s.final_like}/C\${s.final_can}/R\${s.final_risk}
                            </div>
                            \${s.like_boosts.length > 0 ? \`<div class="text-green-300 text-xs">Like ↑: \${s.like_boosts.map(b => b.rule).join(', ')}</div>\` : ''}
                            \${s.can_boosts.length > 0 ? \`<div class="text-blue-300 text-xs">Can ↑: \${s.can_boosts.map(b => b.rule).join(', ')}</div>\` : ''}
                            \${s.risk_boosts.length > 0 ? \`<div class="text-red-300 text-xs">Risk ↑: \${s.risk_boosts.map(b => b.rule).join(', ')}</div>\` : ''}
                        </div>
                    \`).join('');
                } else {
                    const top1 = result.fit_top3?.[0];
                    if (top1) {
                        scoreEl.innerHTML = \`Like: \${top1.like_score}, Can: \${top1.can_score}, Fit: \${top1.fit_score}\`;
                    }
                }
            }
            
            // 3. Follow-up 근거
            const followupEl = document.getElementById('debug-followup-rationale');
            if (followupEl) {
                if (debugInfo?.followup_rationale) {
                    const fr = debugInfo.followup_rationale;
                    followupEl.innerHTML = \`
                        <span class="text-purple-400">Split Attr:</span> \${fr.split_attribute} | 
                        <span class="text-yellow-400">Gain:</span> \${fr.split_gain.toFixed(2)} | 
                        <span class="text-slate-400">\${fr.reason}</span>
                    \`;
                } else if (result.followup_questions?.[0]) {
                    const fq = result.followup_questions[0];
                    followupEl.innerHTML = \`질문: "\${fq.question.slice(0, 40)}..." → \${fq.fact_key}\`;
                } else {
                    followupEl.textContent = '추가 질문 없음';
                }
            }
            
            // 4. Rank Change
            const rankEl = document.getElementById('debug-rank-change');
            if (rankEl) {
                if (debugInfo?.rank_changes) {
                    const rc = debugInfo.rank_changes;
                    rankEl.innerHTML = \`
                        <div class="text-slate-400">Before: \${rc.before.join(' → ')}</div>
                        <div class="text-green-400">After: \${rc.after.join(' → ')}</div>
                        <div class="text-yellow-400">Changes: \${rc.changes.join(', ') || '없음'}</div>
                    \`;
                } else if (previousTop3.length > 0) {
                    const currentTop3 = (result.fit_top3 || []).map(j => j.job_name);
                    rankEl.innerHTML = \`
                        <div class="text-slate-400">Before: \${previousTop3.join(' → ')}</div>
                        <div class="text-green-400">After: \${currentTop3.join(' → ')}</div>
                    \`;
                } else {
                    rankEl.textContent = '첫 분석 (비교 대상 없음)';
                }
            }
            
            // 5. Applied Facts & Rules
            const factsEl = document.getElementById('debug-applied-facts');
            if (factsEl) {
                if (debugInfo?.applied_facts) {
                    factsEl.innerHTML = debugInfo.applied_facts.map(f => \`
                        <div class="py-1 border-b border-slate-700/50">
                            <span class="text-blue-300">\${f.fact_key}</span>: 
                            <span class="text-white">\${f.value}</span>
                            <span class="text-slate-500">(\${f.effect})</span>
                        </div>
                    \`).join('');
                } else {
                    factsEl.innerHTML = \`Facts: \${result.input_summary?.facts_applied || 0}개, Rules: \${(result.input_summary?.applied_rules || []).join(', ') || '없음'}\`;
                }
            }
            
            // 6. 버전 정보
            const versionsEl = document.getElementById('debug-versions');
            if (versionsEl) {
                const v = debugInfo?.versions || result.versions || {};
                versionsEl.innerHTML = \`
                    <span class="text-slate-400">recipe:</span> \${v.recipe || '-'} | 
                    <span class="text-slate-400">tagger:</span> \${v.tagger || '-'} | 
                    <span class="text-slate-400">scoring:</span> \${v.scoring || '-'} | 
                    <span class="text-slate-400">embedding:</span> \${v.embedding || 'none'}
                \`;
            }
            
            // Phase4 상태
            const phase4El = document.getElementById('debug-phase4-status');
            if (phase4El) {
                const diversityApplied = debugInfo?.diversity_guard_triggered || result.diversity_guard_active;
                const biasCapApplied = debugInfo?.research_bias_cap_applied || false;
                phase4El.innerHTML = \`
                    <span class="\${diversityApplied ? 'text-green-400' : 'text-slate-500'}">
                        Diversity Guard: \${diversityApplied ? '✓ 적용됨' : '✗ 미적용'}
                    </span> | 
                    <span class="\${biasCapApplied ? 'text-yellow-400' : 'text-slate-500'}">
                        Research Bias Cap: \${biasCapApplied ? '✓ 적용됨' : '✗ 미적용'}
                    </span>
                    \${result.diversity_changes?.length > 0 ? \`<div class="text-xs text-yellow-300 mt-1">변경: \${result.diversity_changes.join(', ')}</div>\` : ''}
                \`;
            }
        }
        
        function displayResultFollowup(question) {
            const section = document.getElementById('result-followup-section');
            section.classList.remove('hidden');
            document.getElementById('result-followup-question').textContent = question.question;
            
            document.getElementById('result-followup-options').innerHTML = (question.options || []).map(opt => \`
                <button onclick="submitResultFollowup('\${question.id}', '\${question.fact_key}', '\${opt.value}')"
                        class="px-4 py-2 bg-wiki-primary hover:bg-blue-600 text-white rounded-lg transition">
                    \${opt.label}
                </button>
            \`).join('');
        }
        
        async function submitResultFollowup(qId, factKey, answer) {
            try {
                await fetch('/api/ai-analyzer/followup', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        question_id: qId,
                        fact_key: factKey,
                        answer: answer,
                    })
                });
                
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        universal_answers: universalAnswers,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                displayResults(data);
            } catch (error) {
                console.error('Error:', error);
            }
        }
        
        function toggleDebugPanel() {
            const panel = document.getElementById('debug-panel-content');
            if (panel) panel.classList.toggle('hidden');
        }
        
        function resetAnalysis() {
            universalAnswers = {};
            followupAnswers = {};
            currentSessionId = null;
            currentRequestId = null;
            previousTop3 = [];
            selectedStage = null;
            goToStep(0);
        }
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', () => {
            goToStep(0);
        });
    </script>
  `
  
  return c.html(renderLayoutWithContext(c, content, 'AI 직업 추천 - Careerwiki'))
})

// AI Major Analyzer
app.get('/analyzer/major', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto px-4 md:mt-8">
        <h1 class="text-3xl font-bold mb-8 text-center">
            <i class="fas fa-university mr-3 text-wiki-secondary"></i>AI 전공 추천
        </h1>
        
        <div class="glass-card p-8 rounded-2xl">
            <form id="major-analyzer-form" class="space-y-6">
                <!-- MBTI -->
                <div>
                    <label class="block text-lg font-semibold mb-3">당신의 MBTI 유형을 선택해주세요</label>
                    <div class="grid grid-cols-4 gap-3">
                        ${['INTJ', 'INTP', 'ENTJ', 'ENTP', 'INFJ', 'INFP', 'ENFJ', 'ENFP', 
                           'ISTJ', 'ISFJ', 'ESTJ', 'ESFJ', 'ISTP', 'ISFP', 'ESTP', 'ESFP'].map(mbti => `
                            <button type="button" class="mbti-btn p-3 bg-wiki-bg rounded-lg border border-wiki-border hover:border-wiki-primary transition text-sm">
                                ${mbti}
                            </button>
                        `).join('')}
                    </div>
                    <input type="hidden" name="mbti" id="mbti-input">
                </div>
                
                <!-- Current Status -->
                <div>
                    <label class="block text-lg font-semibold mb-3">현재 상태</label>
                    <select name="status" 
                            class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                        <option value="">선택해주세요</option>
                        <option value="high">고등학생</option>
                        <option value="freshman">대학 신입생</option>
                        <option value="student">대학 재학생</option>
                        <option value="transfer">전과 희망</option>
                        <option value="graduate">대학원 진학 희망</option>
                    </select>
                </div>
                
                <!-- Favorite Subjects -->
                <div>
                    <label class="block text-lg font-semibold mb-3">자신 있는 과목</label>
                    <input type="text" name="good_subjects" 
                           placeholder="예: 수학, 물리, 영어, 역사, 미술"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Weak Subjects -->
                <div>
                    <label class="block text-lg font-semibold mb-3">싫어하는 과목</label>
                    <input type="text" name="weak_subjects" 
                           placeholder="예: 국어, 화학, 체육"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Interests -->
                <div>
                    <label class="block text-lg font-semibold mb-3">관심 분야</label>
                    <input type="text" name="interests" 
                           placeholder="예: AI, 게임, 의료, 환경, 금융"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Values -->
                <div>
                    <label class="block text-lg font-semibold mb-3">추구하는 가치</label>
                    <input type="text" name="values" 
                           placeholder="예: 사회공헌, 창의성, 안정성, 높은 연봉"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Career Goals -->
                <div>
                    <label class="block text-lg font-semibold mb-3">희망 진로</label>
                    <textarea name="career_goals" rows="3" 
                              placeholder="졸업 후 어떤 일을 하고 싶으신가요?"
                              class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none"></textarea>
                </div>
                
                <!-- Special Notes -->
                <div>
                    <label class="block text-lg font-semibold mb-3">특이사항</label>
                    <input type="text" name="notes" 
                           placeholder="예: 유학 희망, 복수전공 고려, 편입 계획"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Pricing Options at the End -->
                <div class="border-t border-wiki-border pt-6">
                    <h3 class="text-xl font-bold mb-4 text-center">분석 옵션을 선택하세요</h3>
                    <div class="grid md:grid-cols-2 gap-6">
                        <!-- Free Option -->
                        <label class="glass-card p-6 rounded-xl cursor-pointer hover:border-wiki-primary border-2 border-transparent transition">
                            <input type="radio" name="pricing" value="free" class="hidden peer" checked>
                            <div class="text-center">
                                <h4 class="text-lg font-bold mb-2">무료 분석</h4>
                                <p class="text-2xl font-bold gradient-text mb-3">₩0</p>
                                <ul class="text-sm text-wiki-muted space-y-1">
                                    <li>✓ 기본 전공 분석</li>
                                    <li>✓ 전공 추천 3개</li>
                                    <li>✓ PDF 리포트</li>
                                </ul>
                            </div>
                        </label>
                        
                        <!-- Pro Option -->
                        <label class="glass-card p-6 rounded-xl cursor-pointer hover:border-wiki-primary border-2 border-wiki-primary transition">
                            <input type="radio" name="pricing" value="pro" class="hidden peer">
                            <div class="text-center">
                                <span class="bg-wiki-primary text-white px-3 py-1 rounded-full text-xs">추천</span>
                                <h4 class="text-lg font-bold mb-2 mt-2">Pro 분석</h4>
                                <p class="text-2xl font-bold gradient-text mb-3">₩9,900</p>
                                <ul class="text-sm text-wiki-muted space-y-1">
                                    <li>✓ 심층 전공 분석</li>
                                    <li>✓ 전공 추천 10개</li>
                                    <li>✓ 커리큘럼 분석</li>
                                    <li>✓ 진로 로드맵</li>
                                    <li>✓ 1:1 피드백 (예정)</li>
                                </ul>
                            </div>
                        </label>
                    </div>
                </div>
                
                <!-- Submit Button -->
                <div class="text-center pt-6">
                    <button type="submit" 
                            class="px-12 py-4 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold rounded-xl hover-glow transition transform hover:scale-105">
                        <i class="fas fa-magic mr-2"></i>AI 분석 시작하기
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // MBTI Selection
        document.querySelectorAll('.mbti-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.mbti-btn').forEach(b => b.classList.remove('bg-wiki-primary', 'text-white'));
                btn.classList.add('bg-wiki-primary', 'text-white');
                document.getElementById('mbti-input').value = btn.textContent.trim();
            });
        });
        
        // Form submission
        document.getElementById('major-analyzer-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const pricing = document.querySelector('input[name="pricing"]:checked').value;
            alert('AI ' + (pricing === 'pro' ? 'Pro' : '무료') + ' 전공 분석이 시작되었습니다. 2-3분 내에 결과를 받아보실 수 있습니다.');
        });
    </script>
  `
  
  return c.html(renderLayoutWithContext(c, content, 'AI 전공 추천 - Careerwiki'))
})

// Community Guidelines Help Page
app.get('/help/community-guidelines', (c) => {
  const policy = resolveCommentPolicy()
  const governanceItems = buildCommentGovernanceItems(policy)
  const overviewList = governanceItems
    .map((item) => `<li class="flex gap-2 text-sm text-wiki-muted leading-relaxed"><i class="fas fa-check-circle text-wiki-secondary mt-0.5" aria-hidden="true"></i><span>${escapeHtml(item)}</span></li>`)
    .join('')
  const bestDetails = [
    `좋아요 ${policy.bestLikeThreshold}개 이상이면 BEST로 승격됩니다.`,
    `BEST 영역은 최대 ${policy.bestLimit}건으로 유지되며 새로운 BEST가 등록되면 매일 갱신됩니다.`,
    'BEST 댓글은 목록 상단에 고정되어 누구나 빠르게 확인할 수 있습니다.'
  ]
    .map((item) => `<li>${escapeHtml(item)}</li>`)
    .join('')
  const reportDetails = [
    `신고 ${policy.reportBlindThreshold}회 이상 시 댓글이 자동으로 블라인드 처리됩니다.`,
    policy.moderatorIpBlockEnabled
      ? '모더레이터는 신고가 누적된 IP를 차단하여 악성 활동을 선제적으로 막을 수 있습니다.'
      : null,
    `모더레이터 권한 계층: ${policy.moderatorRoles.join(' > ')}`
  ]
    .filter(Boolean)
    .map((item) => `<li>${escapeHtml(String(item))}</li>`)
    .join('')
  const voteDetails = [
    '공감/비공감은 로그인 없이 가능합니다. 신고는 로그인 후 이용해 주세요.',
    '여러 댓글에 공감/비공감을 표시하는 것은 제한이 없습니다.',
    '단, 한 댓글에는 공감 또는 비공감 중 하나만 선택할 수 있습니다.',
    '자신이 작성한 댓글에는 공감/비공감을 할 수 없습니다.',
    '비공감을 남발하거나 집단적으로 특정 댓글을 공격하면 제재될 수 있습니다.'
  ]
    .map((item) => `<li>${escapeHtml(item)}</li>`)
    .join('')

  const canonicalUrl = buildCanonicalUrl(c.req.url, '/help/community-guidelines')
  const content = `
    <div class="max-w-[1400px] mx-auto px-4 pt-4 pb-10 sm:pt-12">
      <section class="space-y-10">
      <header class="space-y-3">
        <p class="text-xs uppercase tracking-widest text-wiki-secondary">CareerWiki Community</p>
        <h1 class="text-3xl font-bold text-white">커뮤니티 이용 정책</h1>
        <p class="text-sm text-wiki-muted">CareerWiki 댓글 커뮤니티의 기본 운영 원칙과 BEST/신고/공감 정책을 한눈에 확인하세요.</p>
      </header>
      <section class="grid gap-6 md:grid-cols-2">
        <article class="glass-card p-6 rounded-xl space-y-4">
          <h2 class="text-lg font-semibold text-wiki-text">기본 운영 원칙</h2>
          <ul class="space-y-3">${overviewList}</ul>
        </article>
        <article class="glass-card p-6 rounded-xl space-y-4">
          <h2 class="text-lg font-semibold text-wiki-text">BEST 댓글 정책</h2>
          <ul class="space-y-2 text-sm text-wiki-muted">${bestDetails}</ul>
          <p class="text-xs text-wiki-muted/80">승격, 고정, 갱신 이벤트는 <code class="px-2 py-1 rounded bg-wiki-bg/70 border border-wiki-border text-[11px] text-wiki-secondary">cw-detail-action</code> 텔레메트리로 추적됩니다.</p>
        </article>
        <article class="glass-card p-6 rounded-xl space-y-4">
          <h2 class="text-lg font-semibold text-wiki-text">신고 &amp; 모더레이션</h2>
          <ul class="space-y-2 text-sm text-wiki-muted">${reportDetails}</ul>
          <p class="text-xs text-wiki-muted/80">블라인드 처리 이후 모더레이터 검토에서 복구 또는 제재 여부가 확정됩니다.</p>
        </article>
        <article class="glass-card p-6 rounded-xl space-y-4">
          <h2 class="text-lg font-semibold text-wiki-text">공감/비공감 정책</h2>
          <ul class="space-y-2 text-sm text-wiki-muted">${voteDetails}</ul>
        </article>
      </section>
      <section class="glass-card p-6 rounded-xl space-y-4">
        <h2 class="text-lg font-semibold text-wiki-text">상호작용 흐름 요약</h2>
        <ol class="space-y-2 text-sm text-wiki-muted list-decimal pl-5">
          <li>익명 사용자도 댓글을 작성할 수 있으며, 4자리 숫자 비밀번호가 필요합니다. 익명 사용자는 하루 최대 5개의 댓글을 작성할 수 있습니다.</li>
          <li>로그인 사용자는 댓글 작성 제한이 없으며, 익명으로 작성할 수도 있습니다.</li>
          <li>댓글 등록과 상호작용에는 정책 스냅샷이 포함되어 운영팀에서 변동 이력을 추적합니다.</li>
          <li>모더레이터는 신고 현황과 BEST 승격 로그를 기준으로 대응합니다.</li>
        </ol>
        <p class="text-xs text-wiki-muted">정책은 서비스 개선을 위해 주기적으로 업데이트되며, 변경 사항은 이 페이지에 먼저 반영됩니다.</p>
      </section>
      <footer class="text-xs text-wiki-muted">
        <p>정책 관련 문의는 <a href="mailto:contact@careerwiki.org" class="text-wiki-primary hover:text-wiki-secondary">contact@careerwiki.org</a>로 연락해 주세요.</p>
      </footer>
      </section>
    </div>
  `

  return c.html(
    renderLayoutWithContext(c,
      content,
      '커뮤니티 이용 정책 - Careerwiki',
      'CareerWiki 댓글 커뮤니티 운영 원칙과 BEST/신고/공감 정책 안내',
      false,
      { canonical: canonicalUrl, ogUrl: canonicalUrl }
    )
  )
})

// Job Template Design Page
app.get('/job-template-design', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    // 변호사 데이터 가져오기
    const jobRow = await db.prepare(`
      SELECT id, name FROM jobs WHERE name = '변호사' LIMIT 1
    `).first<{ id: string; name: string }>()

    if (!jobRow) {
      c.status(404)
      return c.text('변호사 데이터를 찾을 수 없습니다. ETL 시딩을 먼저 실행해주세요.')
    }

    // job_sources 가져오기
    // job_id로 먼저 시도
    let sources = await db.prepare(`
      SELECT * FROM job_sources WHERE job_id = ?
    `).bind(jobRow.id).all<JobSourceRow>()
    
    // job_id가 null인 경우 이름으로 직접 매칭 (더 정확하게)
    if (!sources.results || sources.results.length === 0) {
      console.log('job_id로 찾기 실패, 이름으로 매칭 시도:', jobRow.name)
      
      // JSON_EXTRACT로 직접 매칭 (SQLite 지원)
      // normalized_payload와 raw_payload 모두 확인
      try {
        sources = await db.prepare(`
          SELECT * FROM job_sources 
          WHERE JSON_EXTRACT(normalized_payload, '$.name') = ?
             OR JSON_EXTRACT(raw_payload, '$.dJobNm') = ?
             OR JSON_EXTRACT(raw_payload, '$.jobNm') = ?
             OR JSON_EXTRACT(raw_payload, '$.duty.job_nm') = ?
        `).bind(jobRow.name, jobRow.name, jobRow.name, jobRow.name).all<JobSourceRow>()
      } catch (e) {
        console.error('JSON_EXTRACT 실패, 수동 필터링:', e)
        // JSON_EXTRACT 안되면 전체 검색
        const allSources = await db.prepare(`
          SELECT * FROM job_sources WHERE normalized_payload LIKE ? OR raw_payload LIKE ?
        `).bind(`%"name":"${jobRow.name}"%`, `%"${jobRow.name}"%`).all<JobSourceRow>()
        
        const matchedSources = allSources.results?.filter(source => {
          try {
            const normalized = JSON.parse(source.normalized_payload || '{}')
            const raw = JSON.parse(source.raw_payload || '{}')
            return normalized.name === jobRow.name || 
                   raw.dJobNm === jobRow.name || 
                   raw.jobNm === jobRow.name ||
                   raw.duty?.job_nm === jobRow.name
          } catch {
            return false
          }
        }) || []
        
        sources = { results: matchedSources, success: true, meta: allSources.meta }
      }
    }
    
    console.log(`찾은 소스: ${sources.results?.length || 0}개`)

    if (!sources.results || sources.results.length === 0) {
      c.status(404)
      return c.text('변호사의 소스 데이터를 찾을 수 없습니다.')
    }

    const html = renderJobTemplateDesignPage(jobRow.name, sources.results)
    return c.html(html)
  } catch (error) {
    console.error('Template design page error:', error)
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// Job Merge Designer Page (드래그 앤 드롭 병합 규칙 설계)
app.get('/job-template-design2', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    // 실제 DB에 있는 직업들의 소스 데이터 가져오기 (다양한 예시 확보)
    // 각 소스 시스템에서 균등하게 샘플링
    // SQLite에서는 UNION ALL 안의 각 SELECT에 ORDER BY를 사용할 수 없으므로 서브쿼리로 감싸야 함
    const allSources = await db.prepare(`
      SELECT js.*, 
             COALESCE(
               j.name,
               JSON_EXTRACT(js.normalized_payload, '$.name'),
               JSON_EXTRACT(js.raw_payload, '$.dJobNm'),
               JSON_EXTRACT(js.raw_payload, '$.jobNm')
             ) as job_name
      FROM (
        -- 커리어넷 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM job_sources 
          WHERE source_system = 'CAREERNET' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
        
        UNION ALL
        
        -- 고용24 직업정보 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM job_sources 
          WHERE source_system = 'WORK24_JOB' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
        
        UNION ALL
        
        -- 고용24 직업사전 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM job_sources 
          WHERE source_system = 'WORK24_DJOB' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
      ) js
      LEFT JOIN jobs j ON js.job_id = j.id
    `).all<JobSourceRow & { job_name: string }>()

    console.log(`Found ${allSources.results?.length || 0} source records`)

    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text('샘플 직업 데이터를 찾을 수 없습니다. ETL 시딩을 먼저 실행해주세요.')
    }

    // 소스별로 데이터 통합
    const careernetSamples: any[] = []
    const work24JobSamples: any[] = []
    const work24DJobSamples: any[] = []

    allSources.results.forEach(row => {
      try {
        const rawData = JSON.parse(row.raw_payload || '{}')
        if (!rawData || Object.keys(rawData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...rawData, _jobName: row.job_name })
        } else if (row.source_system === 'WORK24_JOB') {
          work24JobSamples.push({ ...rawData, _jobName: row.job_name })
        } else if (row.source_system === 'WORK24_DJOB') {
          work24DJobSamples.push({ ...rawData, _jobName: row.job_name })
        }
      } catch (e) {
        console.error(`Failed to parse ${row.source_system} for ${row.job_name}:`, e)
      }
    })

    const { renderJobMergeDesigner } = await import('./templates/jobMergeDesigner')
    const html = renderJobMergeDesigner(careernetSamples, work24JobSamples, work24DJobSamples)
    return c.html(html)
  } catch (error) {
    console.error('Job merge designer error:', error)
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// 직업별 디자이너 페이지: /job-template-design2/:slug
app.get('/job-template-design2/:slug', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    const slug = decodeURIComponent(c.req.param('slug'))
    
    // slug로 직업 찾기
    const job = await db.prepare(`
      SELECT id, name, slug FROM jobs WHERE slug = ? LIMIT 1
    `).bind(slug).first<{ id: string; name: string; slug: string }>()
    
    if (!job) {
      c.status(404)
      return c.text(`직업 "${slug}"을 찾을 수 없습니다.`)
    }

    // 해당 직업의 모든 소스 데이터 가져오기
    const allSources = await db.prepare(`
      SELECT js.*, 
             COALESCE(
               j.name,
               JSON_EXTRACT(js.normalized_payload, '$.name'),
               JSON_EXTRACT(js.raw_payload, '$.dJobNm'),
               JSON_EXTRACT(js.raw_payload, '$.jobNm')
             ) as job_name
      FROM job_sources js
      LEFT JOIN jobs j ON js.job_id = j.id
      WHERE (
        js.job_id = ?
        OR JSON_EXTRACT(js.normalized_payload, '$.name') = ?
        OR (js.source_system = 'WORK24_DJOB' AND JSON_EXTRACT(js.raw_payload, '$.dJobNm') = ?)
        OR (js.source_system = 'WORK24_JOB' AND JSON_EXTRACT(js.raw_payload, '$.jobNm') = ?)
      )
    `).bind(job.id, job.name, job.name, job.name).all<JobSourceRow & { job_name: string }>()

    console.log(`Found ${allSources.results?.length || 0} source records for job: ${job.name}`)

    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text(`직업 "${job.name}"의 소스 데이터를 찾을 수 없습니다.`)
    }

    // 다른 직업들의 예시 데이터 가져오기 (현재 직업에 없는 필드용)
    // 각 소스별로 균등하게 샘플링하여 모든 필드에 예시 데이터가 있도록 함
    const otherSamples = await db.prepare(`
      SELECT source_system, raw_payload, job_name FROM (
        -- CAREERNET 샘플 15개
        SELECT js.source_system, js.raw_payload,
               COALESCE(j.name, JSON_EXTRACT(js.normalized_payload, '$.name')) as job_name
        FROM job_sources js
        LEFT JOIN jobs j ON js.job_id = j.id
        WHERE js.source_system = 'CAREERNET'
          AND js.job_id != ?
          AND js.raw_payload IS NOT NULL 
          AND js.raw_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 15
      )
      UNION ALL
      SELECT source_system, raw_payload, job_name FROM (
        -- WORK24_JOB 샘플 15개
        SELECT js.source_system, js.raw_payload,
               COALESCE(j.name, JSON_EXTRACT(js.raw_payload, '$.jobNm')) as job_name
        FROM job_sources js
        LEFT JOIN jobs j ON js.job_id = j.id
        WHERE js.source_system = 'WORK24_JOB'
          AND js.job_id != ?
          AND js.raw_payload IS NOT NULL 
          AND js.raw_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 15
      )
      UNION ALL
      SELECT source_system, raw_payload, job_name FROM (
        -- WORK24_DJOB 샘플 20개 (필드가 많아서 더 많이)
        SELECT js.source_system, js.raw_payload,
               COALESCE(j.name, JSON_EXTRACT(js.raw_payload, '$.dJobNm')) as job_name
        FROM job_sources js
        LEFT JOIN jobs j ON js.job_id = j.id
        WHERE js.source_system = 'WORK24_DJOB'
          AND js.job_id != ?
          AND js.raw_payload IS NOT NULL 
          AND js.raw_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 20
      )
    `).bind(job.id, job.id, job.id).all<{ source_system: string; raw_payload: string; job_name: string }>()

    // 소스별로 데이터 통합
    const careernetSamples: any[] = []
    const work24JobSamples: any[] = []
    const work24DJobSamples: any[] = []

    // 현재 직업 데이터 추가 (우선 표시)
    allSources.results.forEach(row => {
      try {
        const rawData = JSON.parse(row.raw_payload || '{}')
        if (!rawData || Object.keys(rawData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...rawData, _jobName: row.job_name, _isCurrentJob: true })
        } else if (row.source_system === 'WORK24_JOB') {
          work24JobSamples.push({ ...rawData, _jobName: row.job_name, _isCurrentJob: true })
        } else if (row.source_system === 'WORK24_DJOB') {
          work24DJobSamples.push({ ...rawData, _jobName: row.job_name, _isCurrentJob: true })
        }
      } catch (e) {
        console.error(`Failed to parse ${row.source_system} for ${row.job_name}:`, e)
      }
    })

    // 다른 직업 예시 데이터 추가 (예시용)
    otherSamples.results?.forEach(row => {
      try {
        const rawData = JSON.parse(row.raw_payload || '{}')
        if (!rawData || Object.keys(rawData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...rawData, _jobName: `[예시] ${row.job_name}`, _isCurrentJob: false })
        } else if (row.source_system === 'WORK24_JOB') {
          work24JobSamples.push({ ...rawData, _jobName: `[예시] ${row.job_name}`, _isCurrentJob: false })
        } else if (row.source_system === 'WORK24_DJOB') {
          work24DJobSamples.push({ ...rawData, _jobName: `[예시] ${row.job_name}`, _isCurrentJob: false })
        }
      } catch (e) {
        console.error(`Failed to parse sample ${row.source_system}:`, e)
      }
    })

    const { renderJobMergeDesigner } = await import('./templates/jobMergeDesigner')
    const html = renderJobMergeDesigner(
      careernetSamples,
      work24JobSamples,
      work24DJobSamples,
      job.name,
      job.slug
    )
    return c.html(html)
  } catch (error) {
    console.error('Job merge designer error:', error)
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// Major Merge Designer Page (전공 데이터 필드 병합 규칙 설계)
app.get('/major-template-design', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    // 실제 DB에 있는 전공들의 소스 데이터 가져오기
    const allSources = await db.prepare(`
      SELECT ms.*, 
             COALESCE(
               m.name,
               JSON_EXTRACT(ms.normalized_payload, '$.name'),
               JSON_EXTRACT(ms.raw_payload, '$.major'),
               JSON_EXTRACT(ms.raw_payload, '$.majorName')
             ) as major_name
      FROM (
        -- 커리어넷 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM major_sources 
          WHERE source_system = 'CAREERNET' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
        
        UNION ALL
        
        -- 고용24 학과정보 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM major_sources 
          WHERE source_system = 'WORK24_MAJOR' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
      ) ms
      LEFT JOIN majors m ON ms.major_id = m.id
    `).all<MajorSourceRow & { major_name: string }>()

    console.log(`Found ${allSources.results?.length || 0} major source records`)

    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text('샘플 전공 데이터를 찾을 수 없습니다. ETL 시딩을 먼저 실행해주세요.')
    }

    // 소스별로 데이터 통합
    const careernetSamples: any[] = []
    const work24MajorSamples: any[] = []

    // normalized_payload 사용 (병합 로직과 동일한 필드명 표시)
    allSources.results.forEach(row => {
      try {
        const normalizedData = JSON.parse(row.normalized_payload || '{}')
        if (!normalizedData || Object.keys(normalizedData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...normalizedData, _majorName: row.major_name })
        } else if (row.source_system === 'WORK24_MAJOR') {
          work24MajorSamples.push({ ...normalizedData, _majorName: row.major_name })
        }
      } catch (e) {
        console.error(`Failed to parse ${row.source_system} for ${row.major_name}:`, e)
      }
    })

    const { renderMajorMergeDesigner } = await import('./templates/majorMergeDesigner')
    const html = renderMajorMergeDesigner(careernetSamples, work24MajorSamples)
    return c.html(html)
  } catch (error) {
    console.error('Major merge designer error:', error)
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// 전공별 디자이너 페이지: /major-template-design/:slug
app.get('/major-template-design/:slug', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    const slug = decodeURIComponent(c.req.param('slug'))
    
    // slug로 전공 찾기
    const major = await db.prepare(`
      SELECT id, name, slug FROM majors WHERE slug = ? LIMIT 1
    `).bind(slug).first<{ id: string; name: string; slug: string }>()
    
    if (!major) {
      c.status(404)
      return c.text(`전공 "${slug}"을 찾을 수 없습니다.`)
    }

    // 해당 전공의 모든 소스 데이터 가져오기
    const allSources = await db.prepare(`
      SELECT ms.*, 
             COALESCE(
               m.name,
               JSON_EXTRACT(ms.normalized_payload, '$.name'),
               JSON_EXTRACT(ms.raw_payload, '$.major'),
               JSON_EXTRACT(ms.raw_payload, '$.majorName')
             ) as major_name
      FROM major_sources ms
      LEFT JOIN majors m ON ms.major_id = m.id
      WHERE (
        ms.major_id = ?
        OR JSON_EXTRACT(ms.normalized_payload, '$.name') = ?
        OR JSON_EXTRACT(ms.raw_payload, '$.major') = ?
        OR JSON_EXTRACT(ms.raw_payload, '$.majorName') = ?
      )
    `).bind(major.id, major.name, major.name, major.name).all<MajorSourceRow & { major_name: string }>()

    console.log(`Found ${allSources.results?.length || 0} source records for major: ${major.name}`)

    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text(`전공 "${major.name}"의 소스 데이터를 찾을 수 없습니다.`)
    }

    // 다른 전공들의 예시 데이터 가져오기 (normalized_payload 사용)
    const otherSamples = await db.prepare(`
      SELECT source_system, normalized_payload, major_name FROM (
        SELECT ms.source_system, ms.normalized_payload,
               COALESCE(m.name, JSON_EXTRACT(ms.normalized_payload, '$.name')) as major_name
        FROM major_sources ms
        LEFT JOIN majors m ON ms.major_id = m.id
        WHERE ms.source_system = 'CAREERNET'
          AND ms.major_id != ?
          AND ms.normalized_payload IS NOT NULL 
          AND ms.normalized_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 15
      )
      UNION ALL
      SELECT source_system, normalized_payload, major_name FROM (
        SELECT ms.source_system, ms.normalized_payload,
               COALESCE(m.name, JSON_EXTRACT(ms.normalized_payload, '$.name')) as major_name
        FROM major_sources ms
        LEFT JOIN majors m ON ms.major_id = m.id
        WHERE ms.source_system = 'WORK24_MAJOR'
          AND ms.major_id != ?
          AND ms.normalized_payload IS NOT NULL 
          AND ms.normalized_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 15
      )
    `).bind(major.id, major.id).all<{ source_system: string; normalized_payload: string; major_name: string }>()

    // 소스별로 데이터 통합
    const careernetSamples: any[] = []
    const work24MajorSamples: any[] = []

    // 현재 전공 데이터 추가 (우선 표시) - normalized_payload 사용
    allSources.results.forEach(row => {
      try {
        const normalizedData = JSON.parse(row.normalized_payload || '{}')
        if (!normalizedData || Object.keys(normalizedData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...normalizedData, _majorName: row.major_name, _isCurrentMajor: true })
        } else if (row.source_system === 'WORK24_MAJOR') {
          work24MajorSamples.push({ ...normalizedData, _majorName: row.major_name, _isCurrentMajor: true })
        }
      } catch (e) {
        console.error(`Failed to parse ${row.source_system} for ${row.major_name}:`, e)
      }
    })

    // 다른 전공의 예시 데이터 추가 (필드 예시용) - normalized_payload 사용
    otherSamples.results?.forEach(row => {
      try {
        const normalizedData = JSON.parse(row.normalized_payload || '{}')
        if (!normalizedData || Object.keys(normalizedData).length === 0) return

        const displayName = `[예시] ${row.major_name}`
        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...normalizedData, _majorName: displayName, _isCurrentMajor: false })
        } else if (row.source_system === 'WORK24_MAJOR') {
          work24MajorSamples.push({ ...normalizedData, _majorName: displayName, _isCurrentMajor: false })
        }
      } catch (e) {
        // Skip invalid JSON
      }
    })

    const { renderMajorMergeDesigner } = await import('./templates/majorMergeDesigner')
    const html = renderMajorMergeDesigner(
      careernetSamples, 
      work24MajorSamples,
      major.name,
      major.slug
    )
    return c.html(html)
  } catch (error) {
    console.error('Major merge designer error:', error)
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// ETL 병합 로직 점검 페이지: /job-template-design3/:slug
app.get('/job-template-design3/:slug', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    const slug = decodeURIComponent(c.req.param('slug'))
    
    // slug로 직업 찾기
    const job = await db.prepare(`
      SELECT id, name, slug, merged_profile_json FROM jobs WHERE slug = ? LIMIT 1
    `).bind(slug).first<{ id: string; name: string; slug: string; merged_profile_json: string | null }>()
    
    if (!job) {
      c.status(404)
      return c.text(`직업 "${slug}"을 찾을 수 없습니다.`)
    }

    // 해당 직업의 모든 소스 데이터 가져오기
    const allSources = await db.prepare(`
      SELECT js.*, 
             COALESCE(
               j.name,
               JSON_EXTRACT(js.normalized_payload, '$.name'),
               JSON_EXTRACT(js.raw_payload, '$.dJobNm'),
               JSON_EXTRACT(js.raw_payload, '$.jobNm')
             ) as job_name
      FROM job_sources js
      LEFT JOIN jobs j ON js.job_id = j.id
      WHERE (
        js.job_id = ?
        OR JSON_EXTRACT(js.normalized_payload, '$.name') = ?
        OR (js.source_system = 'WORK24_DJOB' AND JSON_EXTRACT(js.raw_payload, '$.dJobNm') = ?)
        OR (js.source_system = 'WORK24_JOB' AND JSON_EXTRACT(js.raw_payload, '$.jobNm') = ?)
      )
    `).bind(job.id, job.name, job.name, job.name).all<JobSourceRow & { job_name: string }>()

    console.log(`Found ${allSources.results?.length || 0} source records for job: ${job.name}`)

    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text(`직업 "${job.name}"의 소스 데이터를 찾을 수 없습니다.`)
    }

    // Merged profile 파싱
    let mergedProfile: UnifiedJobDetail | null = null
    if (job.merged_profile_json) {
      try {
        mergedProfile = JSON.parse(job.merged_profile_json) as UnifiedJobDetail
      } catch (e) {
        console.error('Failed to parse merged_profile_json:', e)
      }
    }

    const html = renderJobETLInspectionPage(
      job.name,
      job.id,
      allSources.results,
      mergedProfile
    )
    return c.html(html)
  } catch (error) {
    console.error('ETL inspection page error:', error)
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// Job Wiki List Page
app.get('/job', async (c) => {
  const keywordRaw = c.req.query('q') || ''
  const keyword = keywordRaw.trim()
  const includeSources = parseSourcesQuery(c.req.query('sources'))
  const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
  const perPage = 20 // 성능 최적화: 50 → 20 (이미지 로딩 시간 단축)
  
  // 모바일 감지
  const userAgent = c.req.header('user-agent') || ''
  const isMobile = /Mobile|Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent)
  const sort = c.req.query('sort') || 'relevance' // 정렬 옵션

  const searchParams = new URLSearchParams()
  if (keyword) searchParams.set('q', keyword)
  if (includeSources?.length) searchParams.set('sources', includeSources.join(','))
  if (page > 1) searchParams.set('page', String(page))
  if (sort && sort !== 'relevance') searchParams.set('sort', sort)

  const canonicalPath = `/job${searchParams.toString() ? `?${searchParams.toString()}` : ''}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)

  const formatSummaryText = (value?: string | null): string => {
    const fallback = '고용24와 커리어넷 데이터를 통합하여 제공하는 직업 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
    if (!value) return fallback
    const normalized = value.replace(/\s+/g, ' ').trim()
    if (!normalized) return fallback
    return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
  }

  // 로그인 상태 확인
  const user = getOptionalUser(c)
  const isLoggedIn = !!user

  try {
    // Direct D1 query - no KV cache
    const result = await searchUnifiedJobs(
      {
        keyword,
        page,
        perPage,
        includeSources,
        sort
      },
      c.env
    )

    const items = result.items
    const totalCount = typeof result.meta?.total === 'number' ? result.meta.total : items.length

    try {
      console.log('[job-list]', {
        keyword: keyword || '(all)',
        page,
        perPage,
        count: items.length,
        total: totalCount
      })
    } catch (_) {}

    // 공통 함수 renderJobCard 사용
    const jobCards = items.length
      ? items.map((entry) => renderJobCard(entry)).join('')
      : keyword
        ? `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
            <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">"${escapeHtml(keyword)}"에 해당하는 직업이 없습니다.</p>
            <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도해보세요.</p>
          </div>`
        : `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
            <i class="fas fa-briefcase text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">등록된 직업이 없습니다.</p>
          </div>`

    // 🆕 캐시 알림 제거 (사용자에게 보이지 않도록)
    const cacheNotice = '' // renderCacheNotice(cacheState, { staleSeconds: LIST_CACHE_STALE_SECONDS, maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS })

    // 🆕 데이터 소스 요약 제거 (사용자에게 혼란을 줄 수 있음)
    const sourceSummaryHtml = '' // renderSourceStatusSummary(result.meta?.sources, { id: 'job-source-summary' })
    const filterSummary = keyword ? `"${escapeHtml(keyword)}" 키워드` : '전체 직업'
    const headingLabel = keyword ? `“${escapeHtml(keyword)}” 관련 직업` : '직업위키'

    const jsonLdItems = items.map((entry, index) => {
      const slug = composeDetailSlug('job', entry.profile.name, entry.profile.id)
      return {
        '@type': 'ListItem',
        position: (page - 1) * perPage + index + 1,
        url: buildCanonicalUrl(c.req.url, `/job/${encodeURIComponent(slug)}`),
        name: entry.profile.name
      }
    })
    const jsonLd = jsonLdItems.length
      ? `<script type="application/ld+json">${JSON.stringify({
          '@context': 'https://schema.org',
          '@type': 'ItemList',
          name: keyword ? `${keyword} 관련 직업 목록` : 'Careerwiki 직업 목록',
          numberOfItems: jsonLdItems.length,
          itemListOrder: 'https://schema.org/ItemListOrderAscending',
          itemListElement: jsonLdItems
        }).replace(/</g, '\\u003C')}</script>`
      : ''

    // 모바일 메트릭 스크롤 스타일 (스크롤바 숨기기)
    const mobileScrollStyle = `<style>.mobile-metric-scroll::-webkit-scrollbar{display:none;}</style>`
    const extraHead = [jsonLd, mobileScrollStyle].filter(Boolean).join('\n')

    const content = `
      <div class="max-w-[1400px] mx-auto px-4 md:px-6">
        <!-- 히어로 섹션 with 그라데이션 블렌딩 -->
        <div class="relative text-center pt-12 pb-12 mb-6 space-y-7">
          <!-- 배경 글로우 + 하단 페이드 -->
          <div class="absolute inset-0 -z-10 overflow-hidden">
            <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[800px] h-[400px] bg-gradient-to-b from-wiki-primary/8 via-wiki-primary/5 to-transparent rounded-full blur-[120px]"></div>
          </div>
          <!-- 하단 그라데이션 페이드 -->
          <div class="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-wiki-bg to-transparent -z-10"></div>
          
          <h1 class="text-[42px] md:text-[48px] lg:text-6xl font-extrabold leading-tight mb-2">
            <span class="bg-gradient-to-r from-wiki-primary via-blue-400 to-wiki-secondary bg-clip-text text-transparent drop-shadow-[0_2px_8px_rgba(59,130,246,0.3)]">
            ${headingLabel}
            </span>
          </h1>
          
          <p class="text-lg md:text-xl text-wiki-text/90 max-w-2xl mx-auto font-medium leading-relaxed">
            당신의 다음 커리어를 여기서 확인하세요
          </p>
          
          <div class="flex items-center justify-center gap-3 text-sm">
            <span class="px-3 py-1.5 rounded-lg bg-wiki-bg/60 text-wiki-muted">${filterSummary}</span>
            <span class="px-3 py-1.5 rounded-lg bg-gradient-to-r from-wiki-primary/20 to-blue-500/20 border border-wiki-primary/30 text-white font-semibold">
              <span id="job-total-count">${totalCount}</span>개
            </span>
          </div>
        </div>

        <form id="job-filter-form" data-hydration-target="job" method="get" class="mb-6">
          <div class="flex flex-row gap-2 sm:gap-3">
            <!-- 검색창 - 글래스모피즘 + 인셋 아이콘 -->
            <div class="flex-1 relative group min-w-0">
              <div class="absolute inset-0 bg-gradient-to-r from-wiki-primary/20 via-wiki-secondary/20 to-wiki-primary/20 rounded-2xl blur-xl opacity-0 group-focus-within:opacity-100 transition-opacity duration-500"></div>
              <div class="relative flex items-center bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl overflow-hidden transition-all duration-300 group-focus-within:border-wiki-primary/50 group-focus-within:shadow-lg group-focus-within:shadow-wiki-primary/10">
                <span class="pl-3 sm:pl-4 pr-1 sm:pr-2 text-wiki-muted/60 group-focus-within:text-wiki-primary transition-colors duration-300">
                  <i class="fas fa-search text-sm"></i>
                </span>
                <input
                  id="job-keyword"
                  type="text"
                  name="q"
                  value="${escapeHtml(keyword)}"
                  placeholder="직업 검색..."
                  class="flex-1 px-1 sm:px-2 py-2 sm:py-3.5 bg-transparent border-none focus:outline-none text-base text-white placeholder:text-wiki-muted/50 min-w-0"
                  style="font-size: 16px;"
                />
                <button type="submit" class="m-1 sm:m-1.5 px-3 sm:px-5 py-2 sm:py-2.5 min-h-[40px] sm:min-h-[44px] bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-primary/25 active:scale-95 transition-all duration-200">
                  <i class="fas fa-search sm:hidden"></i>
                  <span class="hidden sm:inline">검색</span>
                </button>
              </div>
            </div>
            <!-- 정렬 + 새 직업 추가 버튼 -->
            <div class="flex items-center gap-2 shrink-0" id="job-hydration-toolbar">
              <div class="relative" data-dropdown="job-sort">
                <button type="button" id="job-sort-trigger" class="flex items-center justify-center gap-2 px-3 sm:pl-4 sm:pr-3 py-2 sm:py-3 bg-white/[0.03] border border-white/[0.06] rounded-xl text-sm text-white/70 hover:bg-white/[0.06] hover:border-white/[0.1] focus:outline-none focus:border-wiki-primary/40 transition-all duration-200 cursor-pointer min-w-[44px] sm:min-w-[130px] min-h-[44px]">
                  <i class="fas fa-sliders-h sm:hidden"></i>
                  <span id="job-sort-label" class="hidden sm:inline">${sort === 'salary-desc' ? '연봉 높은 순' : sort === 'name-asc' ? '가나다 순' : '기본 순'}</span>
                  <i class="fas fa-chevron-down text-[10px] text-white/40 ml-auto transition-transform duration-200 hidden sm:inline" id="job-sort-chevron"></i>
                </button>
                <div id="job-sort-menu" class="absolute right-0 top-full mt-2 w-44 py-1.5 bg-[#1c2333]/95 backdrop-blur-xl border border-white/[0.08] rounded-xl shadow-2xl shadow-black/40 opacity-0 invisible translate-y-1 transition-all duration-200 z-50">
                  <div class="px-2 py-1.5 text-[10px] font-medium text-white/30 uppercase tracking-wider">정렬 기준</div>
                  <button type="button" data-sort="relevance" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'relevance' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>기본 순</span>
                  </button>
                  <button type="button" data-sort="salary-desc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'salary-desc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>연봉 높은 순</span>
                  </button>
                  <button type="button" data-sort="name-asc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'name-asc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>가나다 순</span>
                  </button>
                </div>
                <select id="job-sort-select" class="sr-only">
                  <option value="relevance">기본 순</option>
                  <option value="salary-desc">연봉 높은 순</option>
                  <option value="name-asc">가나다 순</option>
                </select>
              </div>
              ${isLoggedIn ? `
              <!-- 새 직업 추가 버튼 (로그인 시에만 표시) -->
              <button
                type="button"
                id="create-job-btn"
                data-create-entity="job"
                class="flex items-center gap-1.5 px-4 py-3 bg-gradient-to-r from-wiki-primary to-blue-500 text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-primary/25 active:scale-95 transition-all duration-200 whitespace-nowrap"
              >
                <i class="fas fa-plus text-xs"></i>
                추가
              </button>
              ` : ''}
            </div>
          </div>
        </form>

        ${cacheNotice}

        <section id="job-results" class="space-y-4" aria-live="polite">
          ${jobCards}
        </section>

        ${(() => {
          const totalPages = Math.ceil(totalCount / perPage)
          if (totalPages <= 1) return ''
          
          const buildPageUrl = (pageNum: number) => {
            const params = new URLSearchParams()
            if (keyword) params.set('q', keyword)
            if (includeSources?.length) params.set('sources', includeSources.join(','))
            if (pageNum > 1) params.set('page', String(pageNum))
            return `/job${params.toString() ? `?${params.toString()}` : ''}`
          }
          
          // 화면 크기에 따라 버튼 수 조정 (모바일: 3개, 데스크톱: 7개)
          const maxPageButtons = isMobile ? 3 : 7
          let startPage = Math.max(1, page - Math.floor(maxPageButtons / 2))
          let endPage = Math.min(totalPages, startPage + maxPageButtons - 1)
          
          if (endPage - startPage < maxPageButtons - 1) {
            startPage = Math.max(1, endPage - maxPageButtons + 1)
          }
          
          const pageButtons = []
          
          // 이전 페이지 버튼
          if (page > 1) {
            pageButtons.push(`
              <a href="${buildPageUrl(page - 1)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                <i class="fas fa-chevron-left"></i>
              </a>
            `)
          }
          
          // 첫 페이지
          if (startPage > 1) {
            pageButtons.push(`
              <a href="${buildPageUrl(1)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                1
              </a>
            `)
            if (startPage > 2) {
              pageButtons.push(`<span class="px-1 text-wiki-muted">...</span>`)
            }
          }
          
          // 페이지 번호들
          for (let i = startPage; i <= endPage; i++) {
            const isActive = i === page
            pageButtons.push(`
              <a href="${buildPageUrl(i)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center rounded-lg transition ${
                   isActive
                     ? 'bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold'
                     : 'bg-wiki-bg border border-wiki-border hover:border-wiki-primary'
                 }">
                ${i}
              </a>
            `)
          }
          
          // 마지막 페이지
          if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
              pageButtons.push(`<span class="px-1 text-wiki-muted">...</span>`)
            }
            pageButtons.push(`
              <a href="${buildPageUrl(totalPages)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                ${totalPages}
              </a>
            `)
          }
          
          // 다음 페이지 버튼
          if (page < totalPages) {
            pageButtons.push(`
              <a href="${buildPageUrl(page + 1)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                <i class="fas fa-chevron-right"></i>
              </a>
            `)
          }
          
          return `
            <nav class="mt-8 flex justify-center items-center gap-2 flex-wrap" aria-label="페이지네이션">
              ${pageButtons.join('')}
            </nav>
            <p class="text-center text-xs text-wiki-muted mt-4">
              ${page}페이지 / 총 ${totalPages}페이지 (${totalCount}개 직업)
            </p>
          `
        })()}

        ${sourceSummaryHtml}
      </div>
    `

    const hydrationScript = `<script id="job-hydration-data" type="application/json">${serializeForScript({
      items,
      meta: {
        total: totalCount,
        page,
        perPage,
        keyword,
        sort,
        includeSources: includeSources ?? null,
        sources: result.meta?.sources ?? null
      }
    })}</script>`
    
    // 정렬 드롭다운 이벤트 핸들러 스크립트
    const sortScript = `<script>
(function() {
  const currentSort = '${sort}';
  const sortLabels = { 'relevance': '기본 순', 'salary-desc': '연봉 높은 순', 'name-asc': '가나다 순' };
  
  // 초기 라벨 설정
  const labelEl = document.getElementById('job-sort-label');
  if (labelEl) labelEl.textContent = sortLabels[currentSort] || '기본 순';
  
  // 커스텀 드롭다운 토글
  const trigger = document.getElementById('job-sort-trigger');
  const menu = document.getElementById('job-sort-menu');
  const chevron = document.getElementById('job-sort-chevron');
  
  if (trigger && menu) {
    trigger.addEventListener('click', function(e) {
      e.preventDefault();
      const isOpen = !menu.classList.contains('invisible');
      if (isOpen) {
        menu.classList.add('invisible', 'opacity-0', 'translate-y-1');
        chevron?.classList.remove('rotate-180');
      } else {
        menu.classList.remove('invisible', 'opacity-0', 'translate-y-1');
        chevron?.classList.add('rotate-180');
      }
    });
    
    // 메뉴 외부 클릭 시 닫기
    document.addEventListener('click', function(e) {
      if (!trigger.contains(e.target) && !menu.contains(e.target)) {
        menu.classList.add('invisible', 'opacity-0', 'translate-y-1');
        chevron?.classList.remove('rotate-180');
      }
    });
  }
  
  // 정렬 옵션 클릭 이벤트
  document.querySelectorAll('.sort-option[data-sort]').forEach(function(btn) {
    const sortValue = btn.getAttribute('data-sort');
    if (sortValue === currentSort) btn.classList.add('active');
    
    btn.addEventListener('click', function() {
      const url = new URL(window.location.href);
      if (sortValue === 'relevance') {
        url.searchParams.delete('sort');
      } else {
        url.searchParams.set('sort', sortValue);
      }
      url.searchParams.delete('page'); // 정렬 변경 시 첫 페이지로
      window.location.href = url.toString();
    });
  });
  
  // select 요소 변경 이벤트 (모바일용)
  const selectEl = document.getElementById('job-sort-select');
  if (selectEl) {
    selectEl.value = currentSort;
    selectEl.addEventListener('change', function() {
      const url = new URL(window.location.href);
      if (this.value === 'relevance') {
        url.searchParams.delete('sort');
      } else {
        url.searchParams.set('sort', this.value);
      }
      url.searchParams.delete('page');
      window.location.href = url.toString();
    });
  }
})();
</script>`
    
    const hydratedContent = `${content}${hydrationScript}${sortScript}`

    const pageTitle = keyword ? `${keyword} 직업 검색 결과 - Careerwiki` : '직업위키 - Careerwiki'
    const description = createMetaDescription(
      keyword ? `${keyword} 관련 직업 정보를 확인하세요.` : undefined,
      items[0]?.display?.summary,
      '직업 연봉과 전망, 필요 역량을 한눈에 확인하세요.'
    )

    return c.html(
      renderLayoutWithContext(c,
        hydratedContent,
        escapeHtml(pageTitle),
        escapeHtml(description),
        false,
        {
          canonical: canonicalUrl,
          ogUrl: canonicalUrl,
          extraHead
        }
      )
    )
  } catch (error) {
    // 로컬 개발 환경에서는 D1이 없을 수 있으므로 조용히 처리
    const isLocalDev = !c.env.KV && !c.env.DB
    if (!isLocalDev) {
      console.error('Job list route error:', error)
    }
    c.status(500)
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-circle-exclamation',
      iconColor: 'text-red-500',
      title: '직업 목록을 불러오지 못했습니다',
      description: '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ctaHref: '/',
      ctaLabel: '홈으로 돌아가기'
    })
    return c.html(
      renderLayoutWithContext(c,
        fallbackHtml,
        '직업 목록 오류 - Careerwiki',
        '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
      )
    )
  }
})

// Major Wiki List Page
app.get('/major', async (c) => {
  const keywordRaw = c.req.query('q') || ''
  const keyword = keywordRaw.trim()
  const includeSources = parseSourcesQuery(c.req.query('sources'))
  const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
  const perPage = 20 // 성능 최적화: 50 → 20 (이미지 로딩 시간 단축)
  const sort = c.req.query('sort') || 'relevance' // 정렬 옵션
  
  // 모바일 감지
  const userAgent = c.req.header('user-agent') || ''
  const isMobile = /Mobile|Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent)

  const searchParams = new URLSearchParams()
  if (keyword) searchParams.set('q', keyword)
  if (includeSources?.length) searchParams.set('sources', includeSources.join(','))
  if (page > 1) searchParams.set('page', String(page))
  if (sort && sort !== 'relevance') searchParams.set('sort', sort)
  const canonicalPath = `/major${searchParams.toString() ? `?${searchParams.toString()}` : ''}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)

  const formatSummaryText = (value?: string | null): string => {
    const fallback = '고용24와 커리어넷 데이터를 통합하여 제공하는 전공 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
    if (!value) return fallback
    const normalized = value.replace(/\s+/g, ' ').trim()
    if (!normalized) return fallback
    return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
  }

  // 로그인 상태 확인
  const user = getOptionalUser(c)
  const isLoggedIn = !!user

  try {
    const forceRefresh = c.req.query('refresh') === '1'
    const { value: result, cacheState } = await withKvCache(
      c.env.KV,
      buildListCacheKey('major', { keyword, page, perPage, includeSources, sort }),
      async () =>
        searchUnifiedMajors(
          {
            keyword,
            page,
            perPage,
            includeSources,
            sort
          },
          c.env
        ),
      {
        staleSeconds: LIST_CACHE_STALE_SECONDS,
        maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS,
        metadata: {
          type: 'major-list',
          keyword: keyword || null,
          page,
          perPage,
          includeSources: includeSources ?? []
        },
        forceRefresh
      }
    )

    const items = result.items
    const totalCount = typeof result.meta?.total === 'number' ? result.meta.total : items.length

    try {
      console.log('[major-list]', {
        keyword: keyword || '(all)',
        page,
        perPage,
        count: items.length,
        total: totalCount
      })
    } catch (_) {}

    const freshnessRecordPromise = recordListFreshness(c.env.KV, {
      type: 'major',
      params: {
        keyword,
        page,
        perPage,
        includeSources
      },
      trigger: 'runtime',
      cacheState,
      totalItems: items.length,
      reportedTotal: result.meta?.total,
      sources: result.meta?.sources
    })

    if (c.executionCtx && 'waitUntil' in c.executionCtx) {
      c.executionCtx.waitUntil(
        freshnessRecordPromise.catch((err) => console.error('[freshness][major]', err))
      )
    } else {
      freshnessRecordPromise.catch((err) => console.error('[freshness][major]', err))
    }

    // 공통 함수 renderMajorCard 사용
    const majorCards = items.length
      ? items.map((entry) => renderMajorCard(entry)).join('')
      : keyword
        ? `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
            <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">"${escapeHtml(keyword)}"에 해당하는 전공이 없습니다.</p>
            <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도해보세요.</p>
          </div>`
        : `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
            <i class="fas fa-graduation-cap text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">등록된 전공이 없습니다.</p>
          </div>`

    // 🆕 캐시 알림 제거 (사용자에게 보이지 않도록)
    const cacheNotice = '' // renderCacheNotice(cacheState, { staleSeconds: LIST_CACHE_STALE_SECONDS, maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS })

    const sourceSummaryHtml = '' // 데이터 수집 상태 제거
    const filterSummary = keyword ? `"${escapeHtml(keyword)}" 키워드` : '전체 전공'
    const headingLabel = keyword ? `"${escapeHtml(keyword)}" 관련 전공` : '전공위키'

    const jsonLdItems = items.map((entry, index) => {
      const slug = composeDetailSlug('major', entry.profile.name, entry.profile.id)
      return {
        '@type': 'ListItem',
        position: (page - 1) * perPage + index + 1,
        url: buildCanonicalUrl(c.req.url, `/major/${encodeURIComponent(slug)}`),
        name: entry.profile.name
      }
    })
    const jsonLd = jsonLdItems.length
      ? `<script type="application/ld+json">${JSON.stringify({
          '@context': 'https://schema.org',
          '@type': 'ItemList',
          name: keyword ? `${keyword} 관련 전공 목록` : 'Careerwiki 전공 목록',
          numberOfItems: jsonLdItems.length,
          itemListOrder: 'https://schema.org/ItemListOrderAscending',
          itemListElement: jsonLdItems
        }).replace(/</g, '\\u003C')}</script>`
      : ''

    const extraHead = [jsonLd].filter(Boolean).join('\n')

    const content = `
      <div class="max-w-[1400px] mx-auto px-4 md:px-6">
        <!-- 히어로 섹션 with 그라데이션 블렌딩 -->
        <div class="relative text-center pt-12 pb-12 mb-6 space-y-7">
          <!-- 배경 글로우 + 하단 페이드 -->
          <div class="absolute inset-0 -z-10 overflow-hidden">
            <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[800px] h-[400px] bg-gradient-to-b from-wiki-secondary/8 via-wiki-secondary/5 to-transparent rounded-full blur-[120px]"></div>
          </div>
          <!-- 하단 그라데이션 페이드 -->
          <div class="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-wiki-bg to-transparent -z-10"></div>
          
          <h1 class="text-[42px] md:text-[48px] lg:text-6xl font-extrabold leading-tight mb-2">
            <span class="bg-gradient-to-r from-wiki-secondary via-purple-400 to-pink-400 bg-clip-text text-transparent drop-shadow-[0_2px_8px_rgba(168,85,247,0.3)]">
            ${headingLabel}
            </span>
          </h1>
          
          <p class="text-lg md:text-xl text-wiki-text/90 max-w-2xl mx-auto font-medium leading-relaxed">
            전문성을 키우는 첫 걸음, 지금 시작하세요
          </p>
          
          <div class="flex items-center justify-center gap-3 text-sm">
            <span class="px-3 py-1.5 rounded-lg bg-wiki-bg/60 text-wiki-muted">${filterSummary}</span>
            <span class="px-3 py-1.5 rounded-lg bg-gradient-to-r from-wiki-secondary/20 to-purple-500/20 border border-wiki-secondary/30 text-white font-semibold">
              <span id="major-total-count">${totalCount}</span>개
            </span>
          </div>
        </div>

        <form id="major-filter-form" data-hydration-target="major" method="get" class="mb-6">
          <div class="flex flex-row gap-2 sm:gap-3">
            <!-- 검색창 - 글래스모피즘 + 인셋 아이콘 -->
            <div class="flex-1 relative group min-w-0">
              <div class="absolute inset-0 bg-gradient-to-r from-wiki-secondary/20 via-purple-500/20 to-wiki-secondary/20 rounded-2xl blur-xl opacity-0 group-focus-within:opacity-100 transition-opacity duration-500"></div>
              <div class="relative flex items-center bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl overflow-hidden transition-all duration-300 group-focus-within:border-wiki-secondary/50 group-focus-within:shadow-lg group-focus-within:shadow-wiki-secondary/10">
                <span class="pl-3 sm:pl-4 pr-1 sm:pr-2 text-wiki-muted/60 group-focus-within:text-wiki-secondary transition-colors duration-300">
                  <i class="fas fa-search text-sm"></i>
                </span>
                <input
                  id="major-keyword"
                  type="text"
                  name="q"
                  value="${escapeHtml(keyword)}"
                  placeholder="전공 검색..."
                  class="flex-1 px-1 sm:px-2 py-2 sm:py-3.5 bg-transparent border-none focus:outline-none text-base text-white placeholder:text-wiki-muted/50 min-w-0"
                  style="font-size: 16px;"
                />
                <button type="submit" class="m-1 sm:m-1.5 px-3 sm:px-5 py-2 sm:py-2.5 min-h-[40px] sm:min-h-[44px] bg-gradient-to-r from-wiki-secondary to-purple-500 text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-secondary/25 active:scale-95 transition-all duration-200">
                  <i class="fas fa-search sm:hidden"></i>
                  <span class="hidden sm:inline">검색</span>
                </button>
              </div>
            </div>
            <!-- 정렬 + 새 전공 추가 버튼 -->
            <div class="flex items-center gap-2 shrink-0" id="major-hydration-toolbar">
              <div class="relative" data-dropdown="major-sort">
                <button type="button" id="major-sort-trigger" class="flex items-center justify-center gap-2 px-3 sm:pl-4 sm:pr-3 py-2 sm:py-3 bg-white/[0.03] border border-white/[0.06] rounded-xl text-sm text-white/70 hover:bg-white/[0.06] hover:border-white/[0.1] focus:outline-none focus:border-wiki-secondary/40 transition-all duration-200 cursor-pointer min-w-[44px] sm:min-w-[130px] min-h-[44px]">
                  <i class="fas fa-sliders-h sm:hidden"></i>
                  <span id="major-sort-label" class="hidden sm:inline">${sort === 'employment-desc' ? '취업률 높은 순' : sort === 'salary-desc' ? '월급 높은 순' : sort === 'name-asc' ? '가나다 순' : '기본 순'}</span>
                  <i class="fas fa-chevron-down text-[10px] text-white/40 ml-auto transition-transform duration-200 hidden sm:inline" id="major-sort-chevron"></i>
                </button>
                <div id="major-sort-menu" class="absolute right-0 top-full mt-2 w-44 py-1.5 bg-[#1c2333]/95 backdrop-blur-xl border border-white/[0.08] rounded-xl shadow-2xl shadow-black/40 opacity-0 invisible translate-y-1 transition-all duration-200 z-50">
                  <div class="px-2 py-1.5 text-[10px] font-medium text-white/30 uppercase tracking-wider">정렬 기준</div>
                  <button type="button" data-sort="relevance" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'relevance' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-secondary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>기본 순</span>
                  </button>
                  <button type="button" data-sort="employment-desc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'employment-desc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-secondary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>취업률 높은 순</span>
                  </button>
                  <button type="button" data-sort="salary-desc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'salary-desc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-secondary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>월급 높은 순</span>
                  </button>
                  <button type="button" data-sort="name-asc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'name-asc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-secondary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>가나다 순</span>
                  </button>
                </div>
                <select id="major-sort-select" class="sr-only">
                  <option value="relevance">기본 순</option>
                  <option value="employment-desc">취업률 높은 순</option>
                  <option value="salary-desc">월급 높은 순</option>
                  <option value="name-asc">가나다 순</option>
                </select>
              </div>
              ${isLoggedIn ? `
              <!-- 새 전공 추가 버튼 (로그인 시에만 표시) -->
              <button
                type="button"
                id="create-major-btn"
                data-create-entity="major"
                class="flex items-center gap-1.5 px-4 py-3 bg-gradient-to-r from-wiki-secondary to-purple-500 text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-secondary/25 active:scale-95 transition-all duration-200 whitespace-nowrap"
              >
                <i class="fas fa-plus text-xs"></i>
                추가
              </button>
              ` : ''}
            </div>
          </div>
        </form>

        ${cacheNotice}

        <section id="major-results" class="space-y-4" aria-live="polite">
          ${majorCards}
        </section>

        ${(() => {
          // 실제 병합된 아이템 수를 기준으로 페이지네이션 계산
          const actualTotalCount = typeof result.meta?.total === 'number' ? result.meta.total : items.length
          const totalPages = Math.ceil(actualTotalCount / perPage)
          if (totalPages <= 1) return ''
          
          const buildPageUrl = (pageNum: number) => {
            const params = new URLSearchParams()
            if (keyword) params.set('q', keyword)
            if (includeSources?.length) params.set('sources', includeSources.join(','))
            if (pageNum > 1) params.set('page', String(pageNum))
            return `/major${params.toString() ? `?${params.toString()}` : ''}`
          }
          
          // 화면 크기에 따라 버튼 수 조정 (모바일: 3개, 데스크톱: 7개)
          const maxPageButtons = isMobile ? 3 : 7
          let startPage = Math.max(1, page - Math.floor(maxPageButtons / 2))
          let endPage = Math.min(totalPages, startPage + maxPageButtons - 1)
          
          if (endPage - startPage < maxPageButtons - 1) {
            startPage = Math.max(1, endPage - maxPageButtons + 1)
          }
          
          const pageButtons = []
          
          // 이전 페이지 버튼
          if (page > 1) {
            pageButtons.push(`
              <a href="${buildPageUrl(page - 1)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                <i class="fas fa-chevron-left"></i>
              </a>
            `)
          }
          
          // 첫 페이지
          if (startPage > 1) {
            pageButtons.push(`
              <a href="${buildPageUrl(1)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                1
              </a>
            `)
            if (startPage > 2) {
              pageButtons.push(`<span class="px-1 text-wiki-muted">...</span>`)
            }
          }
          
          // 페이지 번호들 (최대 7개만 표시)
          for (let i = startPage; i <= endPage; i++) {
            const isActive = i === page
            pageButtons.push(`
              <a href="${buildPageUrl(i)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center rounded-lg transition ${
                   isActive
                     ? 'bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold'
                     : 'bg-wiki-bg border border-wiki-border hover:border-wiki-primary'
                 }">
                ${i}
              </a>
            `)
          }
          
          // 마지막 페이지
          if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
              pageButtons.push(`<span class="px-1 text-wiki-muted">...</span>`)
            }
            pageButtons.push(`
              <a href="${buildPageUrl(totalPages)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                ${totalPages}
              </a>
            `)
          }
          
          // 다음 페이지 버튼
          if (page < totalPages) {
            pageButtons.push(`
              <a href="${buildPageUrl(page + 1)}" 
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                <i class="fas fa-chevron-right"></i>
              </a>
            `)
          }
          
          return `
            <nav class="mt-8 flex justify-center items-center gap-2 flex-wrap" aria-label="페이지네이션">
              ${pageButtons.join('')}
            </nav>
            <p class="text-center text-xs text-wiki-muted mt-4">
              ${page}페이지 / 총 ${totalPages}페이지 (${actualTotalCount}개 전공)
            </p>
          `
        })()}

        ${sourceSummaryHtml}
      </div>
    `

    const hydrationScript = `<script id="major-hydration-data" type="application/json">${serializeForScript({
      items,
      meta: {
        total: totalCount,
        page,
        perPage,
        keyword,
        sort,
        includeSources: includeSources ?? null,
        sources: result.meta?.sources ?? null,
        cacheState
      }
    })}</script>`
    
    // 전공위키 정렬 드롭다운 이벤트 핸들러 스크립트
    const sortScript = `<script>
(function() {
  const currentSort = '${sort}';
  const sortLabels = { 'relevance': '기본 순', 'employment-desc': '취업률 높은 순', 'salary-desc': '월급 높은 순', 'name-asc': '가나다 순' };
  
  // 초기 라벨 설정
  const labelEl = document.getElementById('major-sort-label');
  if (labelEl) labelEl.textContent = sortLabels[currentSort] || '기본 순';
  
  // 커스텀 드롭다운 토글
  const trigger = document.getElementById('major-sort-trigger');
  const menu = document.getElementById('major-sort-menu');
  const chevron = document.getElementById('major-sort-chevron');
  
  if (trigger && menu) {
    trigger.addEventListener('click', function(e) {
      e.preventDefault();
      const isOpen = !menu.classList.contains('invisible');
      if (isOpen) {
        menu.classList.add('invisible', 'opacity-0', 'translate-y-1');
        chevron?.classList.remove('rotate-180');
      } else {
        menu.classList.remove('invisible', 'opacity-0', 'translate-y-1');
        chevron?.classList.add('rotate-180');
      }
    });
    
    // 메뉴 외부 클릭 시 닫기
    document.addEventListener('click', function(e) {
      if (!trigger.contains(e.target) && !menu.contains(e.target)) {
        menu.classList.add('invisible', 'opacity-0', 'translate-y-1');
        chevron?.classList.remove('rotate-180');
      }
    });
  }
  
  // 정렬 옵션 클릭 이벤트
  document.querySelectorAll('#major-sort-menu .sort-option[data-sort]').forEach(function(btn) {
    const sortValue = btn.getAttribute('data-sort');
    if (sortValue === currentSort) btn.classList.add('active');
    
    btn.addEventListener('click', function() {
      const url = new URL(window.location.href);
      if (sortValue === 'relevance') {
        url.searchParams.delete('sort');
      } else {
        url.searchParams.set('sort', sortValue);
      }
      url.searchParams.delete('page'); // 정렬 변경 시 첫 페이지로
      window.location.href = url.toString();
    });
  });
  
  // select 요소 변경 이벤트 (모바일용)
  const selectEl = document.getElementById('major-sort-select');
  if (selectEl) {
    selectEl.value = currentSort;
    selectEl.addEventListener('change', function() {
      const url = new URL(window.location.href);
      if (this.value === 'relevance') {
        url.searchParams.delete('sort');
      } else {
        url.searchParams.set('sort', this.value);
      }
      url.searchParams.delete('page');
      window.location.href = url.toString();
    });
  }
})();
</script>`
    
    const hydratedContent = `${content}${hydrationScript}${sortScript}`

    const pageTitle = keyword ? `${keyword} 전공 검색 결과 - Careerwiki` : '전공위키 - Careerwiki'
    const description = createMetaDescription(
      keyword ? `${keyword} 관련 전공 정보를 확인하세요.` : undefined,
      items[0]?.display?.summary,
      items[0]?.display?.employmentRate,
      '전공별 커리큘럼과 진로 정보를 통합 데이터로 확인하세요.'
    )

    return c.html(
      renderLayoutWithContext(c,
        hydratedContent,
        escapeHtml(pageTitle),
        escapeHtml(description),
        false,
        {
          canonical: canonicalUrl,
          ogUrl: canonicalUrl,
          extraHead
        }
      )
    )
    } catch (error) {
      // KV 연결 실패 등 네트워크 에러는 캐시 없이 직접 조회 시도
      if (error instanceof Error && (error.message.includes('fetch failed') || error.message.includes('ECONNRESET') || error.message.includes('ECONNREFUSED') || error.message.includes('terminated'))) {
        try {
          // 로컬 개발 환경에서는 KV가 없을 수 있으므로 조용히 처리
          const isLocalDev = !c.env.KV && !c.env.DB
          if (!isLocalDev) {
            console.warn('KV cache failed, attempting direct D1 query:', error.message)
          }
          const directResult = await searchUnifiedMajors(
          {
            keyword,
            page,
            perPage,
            includeSources
          },
          c.env
        )
        
        const items = directResult.items
        const totalCount = typeof directResult.meta?.total === 'number' ? directResult.meta.total : items.length
        
        // 공통 함수 renderMajorCard 사용
        const majorCards = items.length
          ? items.map((entry) => renderMajorCard(entry)).join('')
          : keyword
            ? `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
                <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
                <p class="text-lg text-wiki-muted">"${escapeHtml(keyword)}"에 해당하는 전공이 없습니다.</p>
                <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도해보세요.</p>
              </div>`
            : `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
                <i class="fas fa-graduation-cap text-4xl text-wiki-muted mb-4"></i>
                <p class="text-lg text-wiki-muted">등록된 전공이 없습니다.</p>
              </div>`
        
        const totalPages = Math.ceil(totalCount / perPage)
        
        // 모바일 감지
        const userAgent = c.req.header('user-agent') || ''
        const isMobile = /Mobile|Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent)
        
        const buildPageUrl = (pageNum: number) => {
          const params = new URLSearchParams()
          if (keyword) params.set('q', keyword)
          if (includeSources?.length) params.set('sources', includeSources.join(','))
          if (pageNum > 1) params.set('page', String(pageNum))
          return `/major${params.toString() ? `?${params.toString()}` : ''}`
          }
          
          // 화면 크기에 따라 버튼 수 조정 (모바일: 3개, 데스크톱: 7개)
          const maxPageButtons = isMobile ? 3 : 7
          let startPage = Math.max(1, page - Math.floor(maxPageButtons / 2))
        let endPage = Math.min(totalPages, startPage + maxPageButtons - 1)
        if (endPage - startPage < maxPageButtons - 1) {
          startPage = Math.max(1, endPage - maxPageButtons + 1)
        }
        
        const pageButtons = []
        if (page > 1) {
          pageButtons.push(`<a href="${buildPageUrl(page - 1)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition"><i class="fas fa-chevron-left"></i></a>`)
        }
        if (startPage > 1) {
          pageButtons.push(`<a href="${buildPageUrl(1)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">1</a>`)
          if (startPage > 2) pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`)
        }
        for (let i = startPage; i <= endPage; i++) {
          const isActive = i === page
          pageButtons.push(`<a href="${buildPageUrl(i)}" class="px-4 py-2 rounded-lg transition ${isActive ? 'bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold' : 'bg-wiki-bg border border-wiki-border hover:border-wiki-primary'}">${i}</a>`)
        }
        if (endPage < totalPages) {
          if (endPage < totalPages - 1) pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`)
          pageButtons.push(`<a href="${buildPageUrl(totalPages)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">${totalPages}</a>`)
        }
        if (page < totalPages) {
          pageButtons.push(`<a href="${buildPageUrl(page + 1)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition"><i class="fas fa-chevron-right"></i></a>`)
        }
        
        const paginationHtml = totalPages > 1 ? `
          <nav class="mt-8 flex justify-center items-center gap-2 flex-wrap" aria-label="페이지네이션">
            ${pageButtons.join('')}
          </nav>
          <p class="text-center text-xs text-wiki-muted mt-4">
            ${page}페이지 / 총 ${totalPages}페이지 (${totalCount}개 전공)
          </p>
        ` : ''
        
        const content = `
          <div class="max-w-[1400px] mx-auto px-4 md:px-6 md:mt-8">
            <div class="relative text-center pt-12 pb-12 mb-16 space-y-7">
              <div class="absolute inset-0 -z-10 overflow-hidden">
                <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[300px] bg-wiki-secondary/5 rounded-full blur-[100px]"></div>
              </div>
              <h1 class="text-[42px] md:text-[48px] lg:text-6xl font-extrabold leading-tight mb-2">
                <span class="bg-gradient-to-r from-wiki-secondary via-purple-400 to-pink-400 bg-clip-text text-transparent drop-shadow-[0_2px_8px_rgba(168,85,247,0.3)]">
                ${keyword ? `"${escapeHtml(keyword)}" 관련 전공` : '전공위키'}
                </span>
              </h1>
              <p class="text-lg md:text-xl text-wiki-text/90 max-w-2xl mx-auto font-medium leading-relaxed">
                전공별 커리큘럼과 진로 정보를 통합 데이터로 확인하세요.
              </p>
              <div class="flex items-center justify-center gap-4 text-sm text-wiki-muted">
                <span class="px-3 py-1.5 rounded-lg bg-gradient-to-r from-wiki-primary/20 to-blue-500/20 border border-wiki-primary/30 text-white font-semibold">
                  <span id="major-total-count">${totalCount}</span>개 전공
                </span>
              </div>
            </div>
            <form method="get" action="/major" class="glass-card rounded-xl p-6 mb-6" id="major-filter-form">
              <div class="flex flex-col md:flex-row gap-4 items-end">
                <div class="flex-1 w-full">
                  <label for="major-keyword" class="block text-sm text-wiki-muted mb-2">검색어</label>
                  <input type="text" id="major-keyword" name="q" value="${escapeHtml(keyword)}" placeholder="전공명으로 검색..." class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none" />
                </div>
                <div class="flex gap-2 justify-end">
                  <button type="submit" class="px-6 py-3 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-semibold rounded-lg hover-glow transition">
                    <i class="fas fa-search mr-2"></i>검색
                  </button>
                  <a href="/major" class="px-6 py-3 bg-wiki-bg border border-wiki-border text-wiki-muted font-semibold rounded-lg hover:border-wiki-primary transition">초기화</a>
                </div>
              </div>
            </form>
            <div class="glass-card rounded-xl p-4 mb-6 flex flex-wrap items-center gap-4" id="major-hydration-toolbar">
              <div class="flex items-center gap-2">
                <label for="major-sort-select" class="text-sm text-wiki-muted">정렬</label>
                <select id="major-sort-select" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none">
                  <option value="relevance">기본 순</option>
                  <option value="employment-desc">취업률 높은 순</option>
                  <option value="salary-desc">월급 높은 순</option>
                </select>
              </div>
              <div class="ml-auto text-xs text-wiki-muted" id="major-hydration-status" aria-live="polite"></div>
            </div>
            <section id="major-results" class="space-y-4" aria-live="polite">
              ${majorCards}
            </section>
            ${paginationHtml}
          </div>
        `
        
        const hydrationScript = `<script id="major-hydration-data" type="application/json">${serializeForScript({
          items,
          meta: {
            total: totalCount,
            page,
            perPage,
            keyword,
            includeSources: includeSources ?? null,
            sources: directResult.meta?.sources ?? null
          }
        })}</script>`
        
        return c.html(
          renderLayoutWithContext(c,
            `${content}${hydrationScript}`,
            keyword ? `${keyword} 전공 검색 결과 - Careerwiki` : '전공위키 - Careerwiki',
            keyword ? `${keyword} 관련 전공 정보를 확인하세요.` : '전공별 커리큘럼과 진로 정보를 통합 데이터로 확인하세요.'
          )
        )
      } catch (fallbackError) {
        // 로컬 개발 환경에서는 D1이 없을 수 있으므로 조용히 처리
        const isLocalDev = !c.env.KV && !c.env.DB
        if (!isLocalDev) {
          console.error('Direct D1 query also failed:', fallbackError)
        }
      }
    }
    
    // 로컬 개발 환경에서는 D1이 없을 수 있으므로 조용히 처리
    const isLocalDev = !c.env.KV && !c.env.DB
    if (!isLocalDev) {
      console.error('Major list route error:', error)
    }
    c.status(500)
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-circle-exclamation',
      iconColor: 'text-red-500',
      title: '전공 목록을 불러오지 못했습니다',
      description: '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ctaHref: '/',
      ctaLabel: '홈으로 돌아가기'
    })
    return c.html(
      renderLayoutWithContext(c,
        fallbackHtml,
        '전공 목록 오류 - Careerwiki',
        '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
      )
    )
  }
})

// HowTo 업데이트 API (발행된 HowTo 수정)
app.put('/api/howto/:id/update', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const pageId = parseInt(c.req.param('id'))
    
    if (!Number.isFinite(pageId)) {
      return c.json({ success: false, error: '유효하지 않은 ID입니다' }, 400)
    }
    
    // 권한 확인 (작성자 또는 관리자만)
    const page = await c.env.DB.prepare(
      'SELECT author_id FROM pages WHERE id = ? AND page_type = ?'
    ).bind(pageId, 'guide').first<{ author_id: number | null }>()
    
    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }
    
    const isAuthor = page.author_id && user.id === page.author_id
    const isAdmin = user.role === 'admin'
    
    if (!isAuthor && !isAdmin) {
      return c.json({ success: false, error: '편집 권한이 없습니다' }, 403)
    }
    
    const body = await c.req.json()
    const { title, summary, contentHtml, contentJson, tags, relatedJobs, relatedMajors, relatedHowtos, thumbnailUrl, footnotes } = body
    
    if (!title || !title.trim()) {
      return c.json({ success: false, error: '제목을 입력해주세요' }, 400)
    }
    
    // 첫 번째 이미지 추출 (썸네일이 명시적으로 설정되지 않은 경우)
    let finalThumbnailUrl = thumbnailUrl || ''
    let extractedFootnotes = footnotes || []
    if (contentJson) {
      try {
        const contentObj = JSON.parse(contentJson)
        if (!finalThumbnailUrl) {
          finalThumbnailUrl = extractFirstImage(contentObj)
        }
        // 각주 추출 (클라이언트에서 안 보내면 서버에서 추출)
        if (!footnotes || footnotes.length === 0) {
          extractedFootnotes = extractFootnotes(contentObj)
        }
      } catch {}
    }
    
    // meta_data 구성
    const metaData = JSON.stringify({
      contentJson,
      tags: tags || [],
      relatedJobs: relatedJobs || [],
      relatedMajors: relatedMajors || [],
      relatedHowtos: relatedHowtos || [],
      footnotes: extractedFootnotes,
      authorName: user.username || user.email?.split('@')[0] || '작성자',
      thumbnailUrl: finalThumbnailUrl
    })
    
    // 업데이트
    const now = new Date().toISOString()
    await c.env.DB.prepare(`
      UPDATE pages 
      SET title = ?, summary = ?, content = ?, meta_data = ?, updated_at = ?
      WHERE id = ?
    `).bind(title.trim(), summary || '', contentHtml || '', metaData, now, pageId).run()
    
    return c.json({ success: true, message: '저장되었습니다' })
  } catch (error) {
    console.error('[update howto] Error:', error)
    return c.json({ success: false, error: '저장 중 오류가 발생했습니다' }, 500)
  }
})

// HowTo 삭제 API
app.delete('/api/howto/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const pageId = parseInt(c.req.param('id'))
    
    if (!Number.isFinite(pageId)) {
      return c.json({ success: false, error: '유효하지 않은 ID입니다' }, 400)
    }
    
    // 권한 확인 (작성자 또는 관리자만)
    const page = await c.env.DB.prepare(
      'SELECT author_id FROM pages WHERE id = ? AND page_type = ?'
    ).bind(pageId, 'guide').first<{ author_id: number | null }>()
    
    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }
    
    const isAuthor = page.author_id && user.id === page.author_id
    const isAdmin = user.role === 'admin'
    
    if (!isAuthor && !isAdmin) {
      return c.json({ success: false, error: '삭제 권한이 없습니다' }, 403)
    }
    
    // 삭제
    await c.env.DB.prepare('DELETE FROM pages WHERE id = ?').bind(pageId).run()
    
    return c.json({ success: true, message: '삭제되었습니다' })
  } catch (error) {
    console.error('[delete howto] Error:', error)
    return c.json({ success: false, error: '삭제 중 오류가 발생했습니다' }, 500)
  }
})

// HowTo Sample Pages - 블로그 스타일
app.get('/howto', async (c) => {
  const user = getOptionalUser(c)
  const keywordRaw = c.req.query('q') || ''
  const keyword = keywordRaw.trim()
  const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
  const perPage = 12
  
  // 모바일 감지
  const userAgent = c.req.header('user-agent') || ''
  const isMobile = /Mobile|Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent)
  
  // 검색 조건
  const searchCondition = keyword 
    ? `AND (p.title LIKE ? OR p.summary LIKE ? OR p.meta_data LIKE ?)` 
    : ''
  const searchParams = keyword 
    ? [`%${keyword}%`, `%${keyword}%`, `%${keyword}%`] 
    : []
  
  // 전체 개수 조회
  const countQuery = `
    SELECT COUNT(*) as total
    FROM pages p
    WHERE p.page_type = 'guide' AND p.status = 'published' AND p.author_id IS NOT NULL
    ${searchCondition}
  `
  const countResult = keyword 
    ? await c.env.DB.prepare(countQuery).bind(...searchParams).first<{ total: number }>()
    : await c.env.DB.prepare(countQuery).first<{ total: number }>()
  const totalCount = countResult?.total || 0
  const totalPages = Math.ceil(totalCount / perPage)
  
  // DB에서 발행된 HowTo 가져오기 (페이지네이션 적용)
  const offset = (page - 1) * perPage
  const dbQuery = `
    SELECT p.id, p.slug, p.title, p.summary, p.meta_data, p.author_id, p.created_at, p.updated_at,
           u.username AS author_username, u.picture_url AS author_picture_url, u.custom_picture_url AS author_custom_picture_url,
           (SELECT COUNT(*) FROM comments WHERE page_id = p.id) AS comment_count,
           (SELECT COUNT(*) FROM user_bookmarks WHERE item_type = 'howto' AND item_slug = p.slug) AS bookmark_count
    FROM pages p
    LEFT JOIN users u ON u.id = p.author_id
    WHERE p.page_type = 'guide' AND p.status = 'published' AND p.author_id IS NOT NULL
    ${searchCondition}
    ORDER BY p.created_at DESC
    LIMIT ? OFFSET ?
  `
  const dbHowtos = keyword
    ? await c.env.DB.prepare(dbQuery).bind(...searchParams, perPage, offset).all()
    : await c.env.DB.prepare(dbQuery).bind(perPage, offset).all()
  
  // DB 결과를 형식으로 변환
  const dbSummaries = (dbHowtos.results || []).map((row: any) => {
    let metaData: any = {}
    try {
      if (row.meta_data) metaData = JSON.parse(row.meta_data)
    } catch {}
    return {
      slug: row.slug,
      title: row.title,
      snippet: row.summary || '',
      tags: metaData.tags || [],
      keywords: [],
      thumbnailUrl: metaData.thumbnailUrl || '',
      authorName: metaData.authorName || row.author_username || '작성자',
      authorPictureUrl: row.author_custom_picture_url || row.author_picture_url || null,
      updatedAt: row.updated_at || row.created_at,
      commentCount: row.comment_count || 0,
      bookmarkCount: row.bookmark_count || 0
    }
  })
  
  // 샘플 데이터 제거 - DB 데이터만 사용
  const howtoSummaries: Array<{
    slug: string
    title: string
    snippet: string
    tags: string[]
    keywords: string[]
    thumbnailUrl?: string
    authorName?: string
    authorPictureUrl?: string | null
    updatedAt: string | number
    commentCount: number
    bookmarkCount: number
  }> = dbSummaries
  
  // 블로그 스타일 카드 생성
  const cards = howtoSummaries.length
    ? howtoSummaries
        .map((howto) => {
          const tagsHtml = howto.tags && howto.tags.length
            ? howto.tags.slice(0, 3).map((tag: string) => 
                `<span class="inline-flex items-center px-1.5 sm:px-2 py-0.5 rounded-md text-[9px] sm:text-[10px] font-semibold uppercase tracking-wider bg-wiki-primary/10 text-wiki-primary/80 border border-wiki-primary/20">${escapeHtml(tag)}</span>`
              ).join('')
            : ''
          
          // 데스크탑용 썸네일 (상단)
          const thumbnailDesktop = howto.thumbnailUrl 
            ? `<div class="hidden sm:block aspect-[16/9] overflow-hidden">
                <img src="${escapeHtml(howto.thumbnailUrl)}" 
                     alt="${escapeHtml(howto.title)}" 
                     class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                     loading="lazy" />
              </div>`
            : `<div class="hidden sm:flex aspect-[16/9] bg-gradient-to-br from-wiki-primary/20 to-amber-500/10 items-center justify-center">
                <i class="fas fa-book-open text-5xl text-wiki-primary/40"></i>
              </div>`
          
          // 모바일용 썸네일 (오른쪽)
          const thumbnailMobile = howto.thumbnailUrl 
            ? `<div class="sm:hidden w-20 h-20 shrink-0 rounded-xl overflow-hidden">
                <img src="${escapeHtml(howto.thumbnailUrl)}" 
                     alt="${escapeHtml(howto.title)}" 
                     class="w-full h-full object-cover"
                     loading="lazy" />
              </div>`
            : `<div class="sm:hidden w-20 h-20 shrink-0 rounded-xl bg-gradient-to-br from-wiki-primary/20 to-amber-500/10 flex items-center justify-center">
                <i class="fas fa-book-open text-2xl text-wiki-primary/40"></i>
              </div>`
          
          const dateStr = howto.updatedAt 
            ? new Date(howto.updatedAt).toLocaleDateString('ko-KR', { year: 'numeric', month: 'short', day: 'numeric' })
            : ''
          
          // 댓글/저장 갯수 표시
          const statsHtml = `
            <div class="flex items-center gap-2.5 text-[13px] text-wiki-muted/60">
              <span class="inline-flex items-center gap-1">
                <i class="far fa-comment text-xs"></i>
                <span class="font-medium">${howto.commentCount}</span>
              </span>
              <span class="inline-flex items-center gap-1">
                <i class="far fa-bookmark text-xs"></i>
                <span class="font-medium">${howto.bookmarkCount}</span>
              </span>
            </div>
          `
          
          return `
            <article class="group bg-wiki-card/50 border border-wiki-border/40 rounded-2xl overflow-hidden hover:border-wiki-primary/40 hover:shadow-lg hover:shadow-wiki-primary/5 transition-all duration-300">
              <a href="/howto/${encodeURIComponent(howto.slug)}" class="block">
                <!-- 데스크탑: 썸네일 상단 -->
                ${thumbnailDesktop}
                
                <div class="p-4 sm:p-5">
                  <!-- 모바일: 가로 레이아웃 (텍스트 왼쪽 + 썸네일 오른쪽) -->
                  <div class="flex sm:block gap-3">
                    <div class="flex-1 min-w-0 space-y-1.5 sm:space-y-3">
                      <!-- 태그 -->
                      ${tagsHtml ? `<div class="flex flex-wrap gap-1.5 sm:gap-2">${tagsHtml}</div>` : ''}
                      
                      <!-- 제목 -->
                      <h2 class="text-lg sm:text-xl font-bold text-white group-hover:text-wiki-primary transition-colors line-clamp-2">
                        ${escapeHtml(howto.title)}
                      </h2>
                      
                      <!-- 설명 -->
                      <p class="text-[13px] sm:text-[15px] text-wiki-muted/90 line-clamp-2 leading-relaxed">${escapeHtml(howto.snippet)}</p>
                    </div>
                    
                    <!-- 모바일: 썸네일 오른쪽 -->
                    ${thumbnailMobile}
                  </div>
                  
                  <!-- 하단 정보 (글쓴이, 날짜, 댓글/저장 수) -->
                  <div class="flex items-center justify-between pt-3 mt-3 border-t border-wiki-border/30">
                    <div class="flex items-center gap-1.5 text-[13px] text-wiki-muted/70">
                      <span class="inline-flex items-center gap-1">
                        ${howto.authorPictureUrl 
                          ? `<img src="${escapeHtml(howto.authorPictureUrl)}" alt="${escapeHtml(howto.authorName || '운영자')}" class="w-4 h-4 sm:w-5 sm:h-5 rounded-full object-cover" />`
                          : `<i class="fas fa-user-circle text-wiki-primary/60 text-sm"></i>`}
                        <span class="font-medium">${escapeHtml(howto.authorName || '운영자')}</span>
                      </span>
                      ${dateStr ? `<span class="text-wiki-border/50">·</span><span class="font-normal">${dateStr}</span>` : ''}
                    </div>
                    ${statsHtml}
                  </div>
                </div>
              </a>
            </article>
          `
        })
        .join('')
    : ''
  
  // 비어있을 때 표시
  const emptyState = !howtoSummaries.length ? `
    <div class="col-span-full text-center py-16">
      <div class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-wiki-primary/10 mb-6">
        <i class="fas fa-pen-nib text-3xl text-wiki-primary/60"></i>
      </div>
      <h3 class="text-xl font-semibold text-white mb-2">아직 작성된 가이드가 없어요</h3>
      <p class="text-wiki-muted mb-6">첫 번째 HowTo 가이드를 작성해보세요!</p>
      <a href="${user ? '/howto/write' : '/login?redirect=/howto/write'}" 
         class="inline-flex items-center gap-2 px-6 py-3 min-h-[48px] bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
        <i class="fas fa-plus"></i>
        가이드 작성하기
      </a>
    </div>
  ` : ''

  // 페이지네이션 생성
  const maxPageButtons = isMobile ? 3 : 7
  const halfMax = Math.floor(maxPageButtons / 2)
  let startPage = Math.max(1, page - halfMax)
  let endPage = Math.min(totalPages, startPage + maxPageButtons - 1)
  if (endPage - startPage + 1 < maxPageButtons) {
    startPage = Math.max(1, endPage - maxPageButtons + 1)
  }
  
  const buildPageUrl = (p: number) => {
    const params = new URLSearchParams()
    if (keyword) params.set('q', keyword)
    if (p > 1) params.set('page', String(p))
    return `/howto${params.toString() ? `?${params.toString()}` : ''}`
  }
  
  const paginationHtml = totalPages > 1 ? `
    <nav class="flex justify-center items-center gap-2 flex-wrap" aria-label="페이지네이션">
      ${page > 1 ? `
        <a href="${buildPageUrl(page - 1)}" class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg bg-wiki-card border border-wiki-border hover:border-wiki-primary/50 hover:bg-wiki-primary/10 transition" aria-label="이전 페이지">
          <i class="fas fa-chevron-left text-sm text-wiki-muted"></i>
        </a>
      ` : `
        <span class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg bg-wiki-card/50 border border-wiki-border/50 opacity-50 cursor-not-allowed">
          <i class="fas fa-chevron-left text-sm text-wiki-muted"></i>
        </span>
      `}
      ${Array.from({ length: endPage - startPage + 1 }, (_, i) => {
        const p = startPage + i
        const isActive = p === page
        return `
          <a href="${buildPageUrl(p)}" 
             class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg text-sm font-medium transition ${isActive 
               ? 'bg-wiki-primary text-white' 
               : 'bg-wiki-card border border-wiki-border text-wiki-muted hover:border-wiki-primary/50 hover:text-white'}"
             ${isActive ? 'aria-current="page"' : ''}>
            ${p}
          </a>
        `
      }).join('')}
      ${page < totalPages ? `
        <a href="${buildPageUrl(page + 1)}" class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg bg-wiki-card border border-wiki-border hover:border-wiki-primary/50 hover:bg-wiki-primary/10 transition" aria-label="다음 페이지">
          <i class="fas fa-chevron-right text-sm text-wiki-muted"></i>
        </a>
      ` : `
        <span class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg bg-wiki-card/50 border border-wiki-border/50 opacity-50 cursor-not-allowed">
          <i class="fas fa-chevron-right text-sm text-wiki-muted"></i>
        </span>
      `}
    </nav>
    <p class="text-center text-sm text-wiki-muted mt-4">${page}페이지 / 총 ${totalPages}페이지 (${totalCount}개 가이드)</p>
  ` : ''

  const content = `
    <div class="max-w-6xl mx-auto px-4 py-8">
      <!-- 헤더 섹션 -->
      <header class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 sm:gap-6 mb-6">
        <div>
          <h1 class="text-3xl md:text-4xl font-bold text-white mb-2">${keyword ? `"${escapeHtml(keyword)}" 검색 결과` : 'HowTo 가이드'}</h1>
          <p class="text-wiki-muted">${keyword ? `${totalCount}개의 가이드를 찾았습니다` : '실전 경험에서 나온 진짜 노하우를 공유합니다'}</p>
        </div>
        <a href="${user ? '/howto/write' : '/login?redirect=/howto/write'}" 
           class="inline-flex items-center gap-1.5 sm:gap-2 px-3 sm:px-5 py-2 sm:py-3 min-h-[40px] sm:min-h-[44px] bg-wiki-primary/70 hover:bg-wiki-primary/80 text-white text-sm sm:text-base font-medium rounded-xl transition shrink-0 self-end md:self-center"
           ${!user ? 'data-require-login="true"' : ''}>
          <i class="fas fa-plus text-xs sm:text-sm"></i>
          <span>가이드 작성</span>
        </a>
      </header>
      
      <!-- 검색창 -->
      <form action="/howto" method="get" class="mb-6">
        <div class="flex flex-row gap-2 sm:gap-3">
          <div class="flex-1 relative group min-w-0">
            <div class="relative flex items-center bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl overflow-hidden transition-all duration-300 group-focus-within:border-wiki-primary/50 group-focus-within:shadow-lg group-focus-within:shadow-wiki-primary/10">
              <span class="pl-3 sm:pl-4 pr-1 sm:pr-2 text-wiki-muted/60 group-focus-within:text-wiki-primary transition-colors duration-300">
                <i class="fas fa-search text-sm"></i>
              </span>
              <input
                type="text"
                name="q"
                value="${escapeHtml(keyword)}"
                placeholder="가이드 검색..."
                class="flex-1 px-1 sm:px-2 py-2 sm:py-3.5 bg-transparent border-none focus:outline-none text-base text-white placeholder:text-wiki-muted/50 min-w-0"
                style="font-size: 16px;"
              />
              <button type="submit" class="m-1 sm:m-1.5 px-3 sm:px-5 py-2 sm:py-2.5 min-h-[40px] sm:min-h-[44px] bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-primary/25 active:scale-95 transition-all duration-200">
                <i class="fas fa-search sm:hidden"></i>
                <span class="hidden sm:inline">검색</span>
              </button>
            </div>
          </div>
        </div>
      </form>
      
      <!-- 가이드 목록 (그리드) -->
      <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
        ${cards}
        ${emptyState}
      </section>
      
      <!-- 페이지네이션 -->
      ${paginationHtml}
    </div>
  `

  const title = keyword ? `"${keyword}" - HowTo 가이드 검색 - Careerwiki` : 'HowTo 가이드 - Careerwiki'
  const description = keyword 
    ? `"${keyword}" 검색 결과 - ${totalCount}개의 HowTo 가이드를 찾았습니다.`
    : '실전 경험에서 나온 진짜 노하우를 공유하는 HowTo 가이드 모음입니다.'

  return c.html(
    renderLayoutWithContext(c,
      content,
      title,
      description
    )
  )
})

// 로그인 페이지 (Google OAuth로 리다이렉트)
app.get('/login', (c) => {
  const queryRedirect = c.req.query('redirect')
  const referer = c.req.header('Referer')
  let redirect = queryRedirect || '/'
  
  // Referer가 있고 내부 URL이면 사용
  if (!queryRedirect && referer) {
    try {
      const refererUrl = new URL(referer)
      const currentUrl = new URL(c.req.url)
      // 같은 도메인이면 Referer 사용
      if (refererUrl.origin === currentUrl.origin && refererUrl.pathname !== '/login') {
        redirect = refererUrl.pathname + refererUrl.search
      }
    } catch (e) {
      // URL 파싱 실패 시 기본값 사용
    }
  }
  
  const user = getOptionalUser(c)
  
  // 이미 로그인한 경우 리다이렉트
  if (user) {
    return c.redirect(redirect)
  }
  
  const content = `
    <div class="min-h-[60vh] flex items-center justify-center px-4 pt-16 md:pt-0">
      <div class="max-w-md w-full">
        <div class="bg-wiki-card/60 border border-wiki-border/40 rounded-2xl p-8 text-center backdrop-blur-sm">
          <!-- 로고/아이콘 -->
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-wiki-primary/10 mb-6">
            <i class="fas fa-user-circle text-3xl text-wiki-primary"></i>
          </div>
          
          <h1 class="text-2xl font-bold text-white mb-2">로그인이 필요합니다</h1>
          <p class="text-wiki-muted mb-8">계속하려면 로그인해주세요</p>
          
          <!-- Google 로그인 버튼 -->
          <a href="/auth/google?return_url=${encodeURIComponent(redirect)}" 
             class="flex items-center justify-center gap-3 w-full px-6 py-3.5 bg-white hover:bg-gray-50 text-gray-800 font-medium rounded-xl transition shadow-sm">
            <svg class="w-5 h-5" viewBox="0 0 24 24">
              <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
              <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
              <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
              <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
            </svg>
            <span>Google로 계속하기</span>
          </a>
          
          <p class="text-xs text-wiki-muted mt-6 leading-relaxed">
            로그인하면 <a href="/terms" class="text-wiki-primary hover:underline py-1 inline-block">이용약관</a> 및 
            <a href="/privacy" class="text-wiki-primary hover:underline py-1 inline-block">개인정보처리방침</a>에 동의하게 됩니다.
          </p>
        </div>
      </div>
    </div>
  `
  
  return c.html(
    renderLayoutWithContext(c,
      content,
      '로그인 - Careerwiki',
      'Careerwiki에 로그인하세요'
    )
  )
})

// 이용약관 페이지
app.get('/terms', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto px-4 py-12">
      <header class="mb-10">
        <h1 class="text-3xl font-bold text-white mb-3">이용약관</h1>
        <p class="text-wiki-muted">최종 수정일: 2024년 11월 30일</p>
      </header>
      
      <div class="prose prose-invert max-w-none space-y-8 text-wiki-text">
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제1조 (목적)</h2>
          <p class="leading-relaxed">
            이 약관은 CareerWiki(이하 "회사")가 제공하는 커리어 정보 서비스(이하 "서비스")의 이용조건 및 절차, 
            회사와 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.
          </p>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제2조 (정의)</h2>
          <ul class="list-disc list-inside space-y-2">
            <li><strong>"서비스"</strong>란 회사가 제공하는 직업·전공 정보, HowTo 가이드, 커뮤니티 기능 등 일체의 서비스를 의미합니다.</li>
            <li><strong>"이용자"</strong>란 이 약관에 따라 회사가 제공하는 서비스를 이용하는 회원 및 비회원을 말합니다.</li>
            <li><strong>"회원"</strong>이란 회사에 개인정보를 제공하여 회원등록을 한 자로서, 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</li>
            <li><strong>"콘텐츠"</strong>란 회원이 서비스 내에 게시한 글, 댓글, 이미지 등 모든 정보를 말합니다.</li>
          </ul>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제3조 (약관의 효력 및 변경)</h2>
          <ol class="list-decimal list-inside space-y-2">
            <li>이 약관은 서비스 화면에 게시하거나 기타의 방법으로 이용자에게 공지함으로써 효력이 발생합니다.</li>
            <li>회사는 필요하다고 인정되는 경우 이 약관을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 공지합니다.</li>
            <li>이용자는 변경된 약관에 동의하지 않을 경우 서비스 이용을 중단하고 탈퇴할 수 있습니다.</li>
          </ol>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제4조 (회원가입)</h2>
          <ol class="list-decimal list-inside space-y-2">
            <li>회원가입은 이용자가 약관에 동의한 후 소셜 로그인(Google)을 통해 가입 신청을 하고, 회사가 이를 승낙함으로써 체결됩니다.</li>
            <li>회사는 다음 각 호에 해당하는 신청에 대해서는 승낙하지 않거나 사후에 이용계약을 해지할 수 있습니다.
              <ul class="list-disc list-inside ml-4 mt-2 space-y-1">
                <li>타인의 정보를 도용한 경우</li>
                <li>허위 정보를 기재한 경우</li>
                <li>서비스 운영을 방해하거나 방해할 우려가 있는 경우</li>
              </ul>
            </li>
          </ol>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제5조 (서비스 이용)</h2>
          <ol class="list-decimal list-inside space-y-2">
            <li>서비스는 회사의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간 제공함을 원칙으로 합니다.</li>
            <li>회사는 서비스 개선, 시스템 점검 등의 사유로 서비스를 일시 중단할 수 있습니다.</li>
            <li>회사는 무료로 제공하는 서비스의 일부 또는 전부를 변경, 중단, 종료할 수 있습니다.</li>
          </ol>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제6조 (회원의 의무)</h2>
          <p class="mb-3">회원은 다음 각 호의 행위를 하여서는 안 됩니다.</p>
          <ul class="list-disc list-inside space-y-2">
            <li>타인의 정보 도용</li>
            <li>회사가 게시한 정보의 무단 변경</li>
            <li>회사가 허용하지 않은 정보의 송신 또는 게시</li>
            <li>회사 및 제3자의 저작권 등 지적재산권 침해</li>
            <li>회사 및 제3자의 명예를 손상시키거나 업무를 방해하는 행위</li>
            <li>음란·폭력적인 콘텐츠 게시</li>
            <li>서비스의 안정적인 운영을 방해하는 행위</li>
          </ul>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제7조 (콘텐츠의 관리)</h2>
          <ol class="list-decimal list-inside space-y-2">
            <li>회원이 게시한 콘텐츠의 저작권은 해당 회원에게 귀속됩니다.</li>
            <li>회사는 회원이 게시한 콘텐츠가 다음 각 호에 해당하는 경우 사전 통지 없이 삭제하거나 블라인드 처리할 수 있습니다.
              <ul class="list-disc list-inside ml-4 mt-2 space-y-1">
                <li>타인의 명예를 훼손하거나 권리를 침해하는 내용</li>
                <li>불법 정보 또는 음란물</li>
                <li>영리 목적의 광고성 게시물</li>
                <li>기타 관련 법령 또는 이 약관에 위반되는 내용</li>
              </ul>
            </li>
          </ol>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제8조 (면책조항)</h2>
          <ol class="list-decimal list-inside space-y-2">
            <li>회사는 천재지변, 전쟁, 기간통신사업자의 서비스 중단 등 불가항력으로 인한 서비스 중단에 대해 책임을 지지 않습니다.</li>
            <li>회사는 이용자가 서비스를 이용하여 기대하는 결과를 얻지 못한 것에 대해 책임을 지지 않습니다.</li>
            <li>회사는 이용자가 게시한 정보의 신뢰성, 정확성에 대해 책임을 지지 않습니다.</li>
            <li>회사가 제공하는 직업·전공 정보는 참고용이며, 실제 의사결정에 대한 책임은 이용자에게 있습니다.</li>
          </ol>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제9조 (분쟁 해결)</h2>
          <ol class="list-decimal list-inside space-y-2">
            <li>회사와 이용자 간에 발생한 분쟁에 관한 소송은 대한민국 서울중앙지방법원을 관할 법원으로 합니다.</li>
            <li>회사와 이용자 간의 분쟁에는 대한민국 법을 적용합니다.</li>
          </ol>
        </section>
        
        <section class="pt-6 border-t border-wiki-border/40">
          <p class="text-sm text-wiki-muted">
            <strong>부칙</strong><br>
            이 약관은 2024년 11월 30일부터 시행합니다.
          </p>
        </section>
      </div>
    </div>
  `
  
  return c.html(
    renderLayoutWithContext(c, content, '이용약관 - Careerwiki', 'Careerwiki 서비스 이용약관')
  )
})

// 개인정보처리방침 페이지
app.get('/privacy', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto px-4 py-12">
      <header class="mb-10">
        <h1 class="text-3xl font-bold text-white mb-3">개인정보처리방침</h1>
        <p class="text-wiki-muted">최종 수정일: 2024년 11월 30일</p>
      </header>
      
      <div class="prose prose-invert max-w-none space-y-8 text-wiki-text">
        <section>
          <p class="leading-relaxed">
            CareerWiki(이하 "회사")는 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 
            관련 법령에 따라 이용자의 개인정보를 보호하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 
            다음과 같이 개인정보처리방침을 수립·공개합니다.
          </p>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제1조 (수집하는 개인정보 항목)</h2>
          <p class="mb-3">회사는 서비스 제공을 위해 다음의 개인정보를 수집합니다.</p>
          
          <div class="bg-wiki-card/30 border border-wiki-border/40 rounded-xl p-5 space-y-4">
            <div>
              <h4 class="font-semibold text-white mb-2">1. 회원가입 시 (Google 소셜 로그인)</h4>
              <ul class="list-disc list-inside text-sm space-y-1">
                <li><strong>필수항목:</strong> 이메일 주소, 이름(닉네임), 프로필 이미지</li>
                <li><strong>자동수집:</strong> 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보</li>
              </ul>
            </div>
            <div>
              <h4 class="font-semibold text-white mb-2">2. 서비스 이용 과정</h4>
              <ul class="list-disc list-inside text-sm space-y-1">
                <li>게시글, 댓글 작성 시: 작성 내용, 작성 시간</li>
                <li>익명 게시 시: IP 주소 해시값 (복호화 불가)</li>
              </ul>
            </div>
          </div>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제2조 (개인정보의 수집 및 이용목적)</h2>
          <ul class="list-disc list-inside space-y-2">
            <li><strong>회원 관리:</strong> 회원제 서비스 이용에 따른 본인확인, 개인식별, 불량회원 관리</li>
            <li><strong>서비스 제공:</strong> 콘텐츠 제공, 맞춤형 서비스 제공</li>
            <li><strong>서비스 개선:</strong> 서비스 이용 통계 분석, 신규 서비스 개발</li>
            <li><strong>고객 응대:</strong> 문의사항 처리, 공지사항 전달</li>
          </ul>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제3조 (개인정보의 보유 및 이용기간)</h2>
          <p class="mb-3">회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.</p>
          
          <div class="bg-wiki-card/30 border border-wiki-border/40 rounded-xl p-5 space-y-3">
            <div class="flex items-start gap-3">
              <span class="px-2 py-1 bg-wiki-primary/20 text-wiki-primary text-xs font-medium rounded">회원 탈퇴 시</span>
              <span class="text-sm">즉시 파기 (단, 관계 법령에 따라 보존이 필요한 경우 해당 기간까지 보관)</span>
            </div>
            <div class="flex items-start gap-3">
              <span class="px-2 py-1 bg-wiki-primary/20 text-wiki-primary text-xs font-medium rounded">접속 기록</span>
              <span class="text-sm">3개월 (통신비밀보호법)</span>
            </div>
            <div class="flex items-start gap-3">
              <span class="px-2 py-1 bg-wiki-primary/20 text-wiki-primary text-xs font-medium rounded">계약/청약철회 기록</span>
              <span class="text-sm">5년 (전자상거래법)</span>
            </div>
          </div>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제4조 (개인정보의 제3자 제공)</h2>
          <p class="leading-relaxed">
            회사는 원칙적으로 이용자의 개인정보를 외부에 제공하지 않습니다. 
            다만, 다음의 경우에는 예외로 합니다.
          </p>
          <ul class="list-disc list-inside space-y-2 mt-3">
            <li>이용자가 사전에 동의한 경우</li>
            <li>법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우</li>
          </ul>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제5조 (개인정보 처리의 위탁)</h2>
          <p class="mb-3">회사는 서비스 제공을 위해 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.</p>
          
          <div class="overflow-x-auto">
            <table class="w-full text-sm border border-wiki-border/40 rounded-xl overflow-hidden">
              <thead class="bg-wiki-card/50">
                <tr>
                  <th class="px-4 py-3 text-left font-semibold text-white">수탁업체</th>
                  <th class="px-4 py-3 text-left font-semibold text-white">위탁 업무</th>
                </tr>
              </thead>
              <tbody>
                <tr class="border-t border-wiki-border/40">
                  <td class="px-4 py-3">Google LLC</td>
                  <td class="px-4 py-3">소셜 로그인 인증</td>
                </tr>
                <tr class="border-t border-wiki-border/40">
                  <td class="px-4 py-3">Cloudflare Inc.</td>
                  <td class="px-4 py-3">서비스 호스팅, CDN 제공</td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제6조 (이용자의 권리와 행사방법)</h2>
          <p class="mb-3">이용자는 언제든지 다음의 권리를 행사할 수 있습니다.</p>
          <ul class="list-disc list-inside space-y-2">
            <li><strong>열람권:</strong> 자신의 개인정보에 대한 열람을 요청할 수 있습니다.</li>
            <li><strong>정정권:</strong> 자신의 개인정보에 오류가 있을 경우 정정을 요청할 수 있습니다.</li>
            <li><strong>삭제권:</strong> 자신의 개인정보 삭제를 요청할 수 있습니다.</li>
            <li><strong>처리정지권:</strong> 자신의 개인정보 처리 정지를 요청할 수 있습니다.</li>
          </ul>
          <p class="mt-3 text-sm text-wiki-muted">
            위 권리 행사는 서비스 내 설정 메뉴 또는 이메일(contact@careerwiki.org)을 통해 가능합니다.
          </p>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제7조 (쿠키의 사용)</h2>
          <ol class="list-decimal list-inside space-y-2">
            <li><strong>쿠키 사용 목적:</strong> 로그인 상태 유지, 이용자 맞춤형 서비스 제공</li>
            <li><strong>쿠키 관리:</strong> 이용자는 웹 브라우저 설정을 통해 쿠키 저장을 거부하거나 삭제할 수 있습니다. 다만, 쿠키 저장을 거부할 경우 일부 서비스 이용에 제한이 있을 수 있습니다.</li>
          </ol>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제8조 (개인정보의 안전성 확보조치)</h2>
          <p class="mb-3">회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.</p>
          <ul class="list-disc list-inside space-y-2">
            <li>개인정보 암호화 저장 및 전송 시 SSL/TLS 암호화</li>
            <li>해킹 등에 대비한 기술적 대책</li>
            <li>개인정보 접근 권한 최소화</li>
            <li>정기적인 보안 점검</li>
          </ul>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제9조 (개인정보 보호책임자)</h2>
          <div class="bg-wiki-card/30 border border-wiki-border/40 rounded-xl p-5">
            <p class="mb-2"><strong>개인정보 보호책임자</strong></p>
            <ul class="text-sm space-y-1">
              <li>담당: CareerWiki 개인정보보호팀</li>
              <li>이메일: contact@careerwiki.org</li>
            </ul>
            <p class="mt-4 text-sm text-wiki-muted">
              개인정보 처리에 관한 불만 처리 및 피해 구제를 위해 아래 기관에 문의하실 수 있습니다.
            </p>
            <ul class="text-sm mt-2 space-y-1">
              <li>개인정보침해신고센터: (국번없이) 118</li>
              <li>개인정보분쟁조정위원회: 1833-6972</li>
            </ul>
          </div>
        </section>
        
        <section>
          <h2 class="text-xl font-semibold text-white mb-4">제10조 (방침의 변경)</h2>
          <p class="leading-relaxed">
            이 개인정보처리방침은 법령·정책 또는 보안기술의 변경에 따라 내용이 추가·삭제 및 수정될 수 있으며, 
            변경 시에는 서비스 내 공지사항을 통해 고지합니다.
          </p>
        </section>
        
        <section class="pt-6 border-t border-wiki-border/40">
          <p class="text-sm text-wiki-muted">
            <strong>부칙</strong><br>
            이 개인정보처리방침은 2024년 11월 30일부터 시행합니다.
          </p>
        </section>
      </div>
    </div>
  `
  
  return c.html(
    renderLayoutWithContext(c, content, '개인정보처리방침 - Careerwiki', 'Careerwiki 개인정보처리방침')
  )
})

// 내 작성 가이드 목록 페이지
app.get('/howto/my-drafts', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=/howto/my-drafts')
  }
  
  const filter = c.req.query('filter') || 'all'
  
  // 내 가이드 조회 (draft_published + published)
  const allGuidesResult = await c.env.DB.prepare(`
    SELECT id, slug, title, summary, status, created_at, updated_at
    FROM pages 
    WHERE page_type = 'guide' AND author_id = ? AND status IN ('published', 'draft_published')
    ORDER BY created_at DESC
  `).bind(user.id).all()
  const allGuides = allGuidesResult.results || []
  const draftPublished = allGuides.filter((p: any) => p.status === 'draft_published')
  const published = allGuides.filter((p: any) => p.status === 'published')
  
  // 필터 적용
  const showDraftPublished = filter === 'all' || filter === 'draft_published'
  const showPublished = filter === 'all' || filter === 'published'
  
  const content = `
    <div class="max-w-4xl mx-auto px-4 py-8">
      <header class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
        <div>
          <h1 class="text-2xl font-bold text-white mb-2">내 작성 가이드</h1>
          <p class="text-wiki-muted">임시 발행 및 발행한 가이드를 관리합니다</p>
        </div>
        <a href="/howto/write" class="px-4 py-2 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-lg transition flex items-center gap-2 shrink-0">
          <i class="fas fa-plus"></i>
          새 가이드 작성
        </a>
      </header>
      
      <!-- 필터 탭 -->
      <div class="flex items-center gap-2 mb-6 border-b border-wiki-border/40 pb-4">
        <a href="/howto/my-drafts?filter=all" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition ${filter === 'all' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          전체 <span class="ml-1 opacity-70">(${allGuides.length})</span>
        </a>
        <a href="/howto/my-drafts?filter=draft_published" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition ${filter === 'draft_published' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          임시 발행 <span class="ml-1 opacity-70">(${draftPublished.length})</span>
        </a>
        <a href="/howto/my-drafts?filter=published" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition ${filter === 'published' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          발행됨 <span class="ml-1 opacity-70">(${published.length})</span>
        </a>
      </div>
      
        <div class="space-y-4">
        <!-- 임시 발행된 가이드 -->
        ${showDraftPublished && draftPublished.length > 0 ? draftPublished.map((p: any) => `
          <div class="p-4 bg-wiki-card/50 border border-wiki-border/40 rounded-xl hover:border-wiki-primary/50 transition group">
            <div class="flex items-start justify-between gap-4">
              <a href="/howto/${p.slug}" class="flex-1 min-w-0">
                <h3 class="text-lg font-semibold text-white group-hover:text-wiki-primary transition truncate">
                  ${escapeHtml(p.title || '제목 없음')}
                </h3>
                ${p.summary ? `<p class="text-sm text-wiki-muted mt-1 line-clamp-2">${escapeHtml(p.summary)}</p>` : ''}
                <div class="flex items-center gap-3 mt-2 text-xs text-wiki-muted">
                  <span>
                    <i class="far fa-clock mr-1"></i>
                    ${p.created_at ? formatDateSafe(p.created_at) : '날짜 없음'}
                  </span>
                  <span class="px-2 py-0.5 rounded-full bg-purple-500/10 text-purple-400 border border-purple-500/30">
                    <i class="fas fa-eye-slash mr-1"></i>임시 발행
                  </span>
                </div>
              </a>
              <div class="flex items-center gap-2">
                <a href="/howto/${p.slug}/edit" class="p-2 text-wiki-muted hover:text-amber-400 transition" title="편집">
                  <i class="fas fa-edit text-sm"></i>
                </a>
                <button type="button" onclick="deletePublished(${p.id}, '${escapeHtml(p.title || '제목 없음').replace(/'/g, "\\'")}', this)" class="p-2 text-wiki-muted hover:text-red-400 transition" title="삭제">
                  <i class="fas fa-trash text-sm"></i>
                </button>
              </div>
            </div>
          </div>
        `).join('') : ''}
        
        <!-- 발행된 가이드 -->
        ${showPublished && published.length > 0 ? published.map((p: any) => `
          <div class="p-4 bg-wiki-card/50 border border-wiki-border/40 rounded-xl hover:border-wiki-primary/50 transition group">
            <div class="flex items-start justify-between gap-4">
              <a href="/howto/${p.slug}" class="flex-1 min-w-0">
                <h3 class="text-lg font-semibold text-white group-hover:text-wiki-primary transition truncate">
                  ${escapeHtml(p.title || '제목 없음')}
                </h3>
                ${p.summary ? `<p class="text-sm text-wiki-muted mt-1 line-clamp-2">${escapeHtml(p.summary)}</p>` : ''}
                <div class="flex items-center gap-3 mt-2 text-xs text-wiki-muted">
                  <span>
                    <i class="far fa-clock mr-1"></i>
                    ${p.created_at ? formatDateSafe(p.created_at) : '날짜 없음'}
                  </span>
                  ${p.status === 'draft_published' ? `
                    <span class="px-2 py-0.5 rounded-full bg-purple-500/10 text-purple-400 border border-purple-500/30">
                      <i class="fas fa-eye-slash mr-1"></i>임시 발행
                    </span>
                  ` : `
                    <span class="px-2 py-0.5 rounded-full bg-green-500/10 text-green-400 border border-green-500/30">
                      <i class="fas fa-check-circle mr-1"></i>발행됨
                    </span>
                  `}
                </div>
              </a>
              <div class="flex items-center gap-2">
                <a href="/howto/${p.slug}/edit" class="p-2 text-wiki-muted hover:text-amber-400 transition" title="편집">
                  <i class="fas fa-edit text-sm"></i>
                </a>
                <button type="button" onclick="deletePublished(${p.id}, '${escapeHtml(p.title?.replace(/'/g, "\\'") || '')}', this)" 
                        class="p-2 text-wiki-muted hover:text-red-400 transition" title="삭제">
                  <i class="fas fa-trash text-sm"></i>
                </button>
              </div>
            </div>
          </div>
        `).join('') : ''}
        
        <!-- 빈 상태 -->
        ${allGuides.length === 0 || (filter === 'draft_published' && draftPublished.length === 0) || (filter === 'published' && published.length === 0) ? `
          <div class="text-center py-16">
            <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-wiki-card/50 mb-4">
              <i class="fas fa-file-alt text-2xl text-wiki-muted"></i>
            </div>
            <h3 class="text-lg font-semibold text-white mb-2">
              ${filter === 'draft_published' ? '임시 발행된 가이드가 없습니다' : filter === 'published' ? '발행된 가이드가 없습니다' : '아직 작성한 가이드가 없습니다'}
            </h3>
            <p class="text-wiki-muted">위의 "새 가이드 작성" 버튼을 눌러 시작하세요!</p>
          </div>
        ` : ''}
        </div>
        
        <script>
          async function deleteDraft(draftId, title, btn) {
            if (!confirm('정말 "' + title + '" 초안을 삭제하시겠습니까?\\n삭제된 초안은 복구할 수 없습니다.')) {
              return;
            }
            
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin text-sm"></i>';
            
            try {
              const res = await fetch('/api/howto/drafts/' + draftId, {
                method: 'DELETE'
              });
              const data = await res.json();
              
              if (data.success) {
                const card = btn.closest('[data-draft-id]');
                card.style.opacity = '0';
                card.style.transform = 'translateX(-20px)';
                card.style.transition = 'all 0.3s ease';
                setTimeout(() => {
                  card.remove();
                if (!document.querySelector('[data-draft-id]') && !document.querySelector('.space-y-4 > div:not([data-draft-id])')) {
                    location.reload();
                  }
                }, 300);
              } else {
                alert(data.error || '삭제에 실패했습니다.');
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-trash text-sm"></i>';
              }
            } catch (err) {
              alert('네트워크 오류가 발생했습니다.');
              btn.disabled = false;
              btn.innerHTML = '<i class="fas fa-trash text-sm"></i>';
            }
          }
        
        async function deletePublished(pageId, title, btn) {
          if (!confirm('정말 "' + title + '" 가이드를 삭제하시겠습니까?\\n삭제된 가이드는 복구할 수 없습니다.')) {
            return;
          }
          
          btn.disabled = true;
          btn.innerHTML = '<i class="fas fa-spinner fa-spin text-sm"></i>';
          
          try {
            const res = await fetch('/api/howto/' + pageId, {
              method: 'DELETE'
            });
            const data = await res.json();
            
            if (data.success) {
              const card = btn.closest('.bg-wiki-card\\\\/50');
              if (card) {
                card.style.opacity = '0';
                card.style.transform = 'translateX(-20px)';
                card.style.transition = 'all 0.3s ease';
                setTimeout(() => {
                  card.remove();
                  location.reload();
                }, 300);
              } else {
                location.reload();
              }
            } else {
              alert(data.error || '삭제에 실패했습니다.');
              btn.disabled = false;
              btn.innerHTML = '<i class="fas fa-trash text-sm"></i>';
            }
          } catch (err) {
            alert('네트워크 오류가 발생했습니다.');
            btn.disabled = false;
            btn.innerHTML = '<i class="fas fa-trash text-sm"></i>';
          }
        }
        </script>
    </div>
  `
  
  return c.html(
    renderLayoutWithContext(c, content, '내 작성 가이드 - Careerwiki', '내 초안과 가이드를 관리합니다')
  )
})

// HowTo 작성 페이지 (로그인 필수) - Tiptap 에디터
// 페이지 접속 시에는 초안 생성하지 않음. 저장 버튼 클릭 시에만 초안 생성
app.get('/howto/write', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=/howto/write')
  }
  
  // 초안 없이 빈 에디터 페이지 렌더링
    const content = `
    <!-- Tiptap CDN -->
    <link rel="stylesheet" href="/static/howto-editor.css">
    
    <div class="max-w-6xl mx-auto px-3 sm:px-4 py-4 sm:py-6">
      <!-- 헤더 -->
      <header class="mb-6">
        <!-- 상단: 뒤로가기 + 제목 -->
        <div class="flex items-center gap-3 mb-3">
          <a href="/howto" class="flex items-center justify-center w-10 h-10 min-w-[44px] min-h-[44px] text-wiki-muted hover:text-white hover:bg-wiki-border/30 rounded-xl transition shrink-0">
            <i class="fas fa-arrow-left text-lg"></i>
          </a>
          <div class="min-w-0 flex-1">
            <h1 class="text-xl sm:text-2xl font-bold text-white leading-tight">가이드 작성</h1>
            <p class="text-xs sm:text-sm text-wiki-muted mt-0.5" id="save-status">
              <span class="text-gray-400">●</span> 새 문서
            </p>
          </div>
        </div>
        
        <!-- 하단: 액션 버튼 (모바일에서도 텍스트 표시) -->
        <div class="flex items-center gap-2 sm:gap-3">
          <button type="button" id="btn-save" class="flex-1 sm:flex-none px-4 py-2.5 min-h-[44px] border border-wiki-border/60 text-wiki-muted hover:text-white hover:bg-wiki-border/20 rounded-xl transition text-sm font-medium flex items-center justify-center gap-2">
            <i class="fas fa-save"></i>
            <span>임시저장</span>
          </button>
          <button type="button" id="btn-publish" class="flex-1 sm:flex-none px-4 sm:px-5 py-2.5 min-h-[44px] bg-gradient-to-r from-wiki-primary to-blue-500 hover:from-wiki-primary/90 hover:to-blue-500/90 text-white rounded-xl transition text-sm font-medium flex items-center justify-center gap-2 shadow-lg shadow-wiki-primary/20">
            <i class="fas fa-paper-plane"></i>
            <span>발행하기</span>
          </button>
        </div>
      </header>
      
      <!-- 메타 필드 -->
      <div class="grid gap-4 mb-6">
        <!-- 제목 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">제목 *</label>
          <div class="relative">
            <input type="text" id="field-title" maxlength="100"
                   class="w-full px-4 py-3 pr-10 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white text-lg font-semibold placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                   placeholder="가이드 제목을 입력하세요"
                   value="" />
            <span id="title-check" class="absolute right-3 top-1/2 -translate-y-1/2 text-lg hidden">
              <i class="fas fa-spinner fa-spin text-wiki-muted" id="title-loading"></i>
              <i class="fas fa-check-circle text-green-500 hidden" id="title-ok"></i>
              <i class="fas fa-times-circle text-red-500 hidden" id="title-error"></i>
            </span>
          </div>
          <p id="title-error-msg" class="mt-1 text-xs text-red-400 hidden"></p>
        </div>
        
        <!-- 요약 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">요약</label>
          <textarea id="field-summary" maxlength="300" rows="2"
                    class="w-full px-4 py-3 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition resize-none"
                    placeholder="이 가이드가 어떤 내용을 다루는지 간략히 설명해주세요"></textarea>
        </div>
        
        <!-- 썸네일 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">썸네일 <span class="text-wiki-muted font-normal">(선택)</span></label>
          <div id="thumbnail-upload-area" class="border-2 border-dashed border-wiki-border/40 rounded-xl p-4 text-center hover:border-wiki-primary/50 transition cursor-pointer">
            <div id="thumbnail-placeholder" class="space-y-2">
              <i class="fas fa-image text-3xl text-wiki-muted"></i>
              <p class="text-sm text-wiki-muted">클릭하여 이미지 업로드 또는 드래그 앤 드롭</p>
              <p class="text-xs text-wiki-muted/60">없으면 본문의 첫 번째 이미지가 자동으로 사용됩니다</p>
            </div>
            <div id="thumbnail-preview" class="hidden">
              <img id="thumbnail-img" src="" alt="썸네일 미리보기" class="max-h-48 mx-auto rounded-lg" />
              <button type="button" id="thumbnail-remove" class="mt-2 text-sm text-red-400 hover:text-red-300">
                <i class="fas fa-times mr-1"></i>썸네일 제거
              </button>
            </div>
          </div>
          <input type="file" id="thumbnail-input" accept="image/*" class="hidden" />
          <input type="hidden" id="field-thumbnail" value="" />
        </div>
        
        <!-- 태그 & 관련 콘텐츠 -->
        <div class="grid md:grid-cols-2 gap-4">
          <!-- 태그 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">태그</label>
            <div class="relative">
              <input type="text" id="field-tags"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="태그 입력 후 Enter 또는 쉼표(,)"
                     data-tags='[]' />
              <div id="tags-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
          
          <!-- 관련 직업 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 직업</label>
            <div class="relative">
              <input type="text" id="field-jobs" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="직업 검색..."
                     data-items='[]' />
              <div id="jobs-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="jobs-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
        </div>
        
        <div class="grid md:grid-cols-2 gap-4">
          <!-- 관련 전공 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 전공</label>
            <div class="relative">
              <input type="text" id="field-majors" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="전공 검색..."
                     data-items='[]' />
              <div id="majors-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="majors-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
          
          <!-- 관련 HowTo -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 HowTo</label>
            <div class="relative">
              <input type="text" id="field-howtos" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="HowTo 검색..."
                     data-items='[]' />
              <div id="howtos-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="howtos-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 본문 영역 -->
      <div>
        <label class="block text-sm font-medium text-wiki-text mb-2">본문 *</label>
        
        <!-- 에디터 툴바 -->
        <div id="toolbar" class="howto-editor-toolbar bg-wiki-card/50 border border-wiki-border/40 rounded-t-xl px-3 py-2">
          <div class="toolbar-group">
            <button type="button" data-action="bold" title="굵게 (Ctrl+B)"><i class="fas fa-bold"></i></button>
            <button type="button" data-action="italic" title="기울임 (Ctrl+I)"><i class="fas fa-italic"></i></button>
            <button type="button" data-action="underline" title="밑줄 (Ctrl+U)"><i class="fas fa-underline"></i></button>
            <button type="button" data-action="strike" title="취소선"><i class="fas fa-strikethrough"></i></button>
          </div>
          <div class="toolbar-group">
            <!-- 폰트 -->
            <div class="toolbar-dropdown font-dropdown">
              <button type="button" title="폰트" class="toolbar-btn flex items-center gap-1.5"><span class="current-font-name">기본</span><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="font-menu hidden">
                <button type="button" data-font="inherit" class="is-active">기본</button>
                <button type="button" data-font="sans-serif">Sans-serif (샌즈)</button>
                <button type="button" data-font="serif">Serif (세리프)</button>
                <button type="button" data-font="monospace">Monospace (코드)</button>
                <button type="button" data-font="'Nanum Gothic', sans-serif">나눔고딕</button>
                <button type="button" data-font="'Nanum Myeongjo', serif">나눔명조</button>
              </div>
            </div>
            <!-- 폰트 크기 -->
            <div class="toolbar-dropdown size-dropdown">
              <button type="button" title="글자 크기" class="toolbar-btn size-input-btn">
                <input type="number" class="size-input" value="15" min="6" max="72" title="글자 크기 (px)">
                <i class="fas fa-chevron-down text-[10px] opacity-60"></i>
              </button>
              <div class="size-menu hidden">
                <button type="button" data-size="8px">8</button>
                <button type="button" data-size="12px">12</button>
                <button type="button" data-size="14px">14</button>
                <button type="button" data-size="15px" class="is-default">15</button>
                <button type="button" data-size="16px">16</button>
                <button type="button" data-size="18px">18</button>
                <button type="button" data-size="20px">20</button>
                <button type="button" data-size="24px">24</button>
                <button type="button" data-size="28px">28</button>
                <button type="button" data-size="32px">32</button>
                <button type="button" data-size="36px">36</button>
              </div>
            </div>
            <!-- 폰트 색상 -->
            <div class="toolbar-dropdown color-dropdown">
              <button type="button" title="글자 색상" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-palette"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="color-menu hidden">
                <div class="color-grid">
                  <button type="button" data-color="#ffffff" style="background:#ffffff" title="흰색"></button>
                  <button type="button" data-color="#f59e0b" style="background:#f59e0b" title="주황"></button>
                  <button type="button" data-color="#ef4444" style="background:#ef4444" title="빨강"></button>
                  <button type="button" data-color="#22c55e" style="background:#22c55e" title="초록"></button>
                  <button type="button" data-color="#3b82f6" style="background:#3b82f6" title="파랑"></button>
                  <button type="button" data-color="#8b5cf6" style="background:#8b5cf6" title="보라"></button>
                  <button type="button" data-color="#ec4899" style="background:#ec4899" title="분홍"></button>
                  <button type="button" data-color="#6b7280" style="background:#6b7280" title="회색"></button>
                </div>
                <button type="button" data-color="" class="color-reset">기본 색상</button>
              </div>
            </div>
          </div>
          <div class="toolbar-group">
            <!-- 정렬 -->
            <div class="toolbar-dropdown align-dropdown">
              <button type="button" title="정렬" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-align-left"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="align-menu hidden">
                <button type="button" data-action="alignLeft"><i class="fas fa-align-left"></i> 왼쪽</button>
                <button type="button" data-action="alignCenter"><i class="fas fa-align-center"></i> 중앙</button>
                <button type="button" data-action="alignRight"><i class="fas fa-align-right"></i> 오른쪽</button>
              </div>
            </div>
            <!-- 커스텀 블록 -->
            <div class="toolbar-dropdown custom-block-dropdown">
              <button type="button" title="커스텀 블록" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-cube"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="toolbar-dropdown-content custom-block-menu hidden">
                <button type="button" data-action="blockquote"><i class="fas fa-quote-left text-sky-400"></i> 인용구</button>
                <button type="button" data-action="horizontalRule"><i class="fas fa-minus text-purple-400"></i> 구분선</button>
                <button type="button" data-action="checkpointBox"><i class="fas fa-check-circle text-green-500"></i> 체크포인트</button>
                <button type="button" data-action="conclusionBox"><i class="fas fa-lightbulb text-wiki-primary"></i> 결론 박스</button>
                <button type="button" data-action="qnaBlock"><i class="fas fa-question-circle text-amber-500"></i> Q&A</button>
              </div>
            </div>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="h1" title="제목 1">H1</button>
            <button type="button" data-action="h2" title="제목 2">H2</button>
            <button type="button" data-action="h3" title="제목 3">H3</button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="bulletList" title="글머리 기호"><i class="fas fa-list-ul"></i></button>
            <button type="button" data-action="orderedList" title="번호 매기기"><i class="fas fa-list-ol"></i></button>
            <button type="button" data-action="taskList" title="체크리스트"><i class="fas fa-tasks"></i></button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="link" title="외부 링크"><i class="fas fa-link"></i></button>
            <button type="button" data-action="internalLink" title="내부 링크 (직업/전공/HowTo)"><i class="fas fa-sitemap"></i></button>
            <button type="button" data-action="footnote" title="각주 (출처)"><i class="fas fa-asterisk"></i></button>
            <button type="button" data-action="image" title="이미지"><i class="fas fa-image"></i></button>
            <button type="button" data-action="table" title="표"><i class="fas fa-table"></i></button>
            <button type="button" data-action="codeBlock" title="코드 블록"><i class="fas fa-code"></i></button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="undo" title="실행 취소 (Ctrl+Z)"><i class="fas fa-undo"></i></button>
            <button type="button" data-action="redo" title="다시 실행 (Ctrl+Y)"><i class="fas fa-redo"></i></button>
          </div>
        </div>
        
        <!-- 표 편집 툴바 (압축형) -->
        <div id="table-toolbar" class="table-toolbar">
          <div class="toolbar-dropdown row-dropdown">
            <button type="button" title="행 추가" class="toolbar-btn"><i class="fas fa-plus"></i> 행</button>
            <div class="row-menu hidden">
              <button type="button" data-action="addRowBefore"><i class="fas fa-arrow-up"></i> 위에 추가</button>
              <button type="button" data-action="addRowAfter"><i class="fas fa-arrow-down"></i> 아래에 추가</button>
            </div>
          </div>
          <div class="toolbar-dropdown col-dropdown">
            <button type="button" title="열 추가" class="toolbar-btn"><i class="fas fa-plus"></i> 열</button>
            <div class="col-menu hidden">
              <button type="button" data-action="addColBefore"><i class="fas fa-arrow-left"></i> 왼쪽에 추가</button>
              <button type="button" data-action="addColAfter"><i class="fas fa-arrow-right"></i> 오른쪽에 추가</button>
            </div>
          </div>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="deleteRow" title="행 삭제"><i class="fas fa-trash-alt"></i></button>
          <button type="button" data-action="deleteCol" title="열 삭제"><i class="fas fa-columns"></i></button>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="mergeCells" title="셀 병합"><i class="fas fa-compress-alt"></i></button>
          <button type="button" data-action="splitCell" title="셀 분할"><i class="fas fa-expand-alt"></i></button>
          <!-- 셀 배경색 -->
          <span class="toolbar-divider"></span>
          <div class="toolbar-dropdown cell-color-dropdown">
            <button type="button" title="셀 배경색" class="toolbar-btn"><i class="fas fa-fill-drip"></i></button>
            <div class="cell-color-menu hidden">
              <div class="color-grid">
                <button type="button" data-cell-bg="" style="background:transparent;border:1px dashed #666" title="없음"></button>
                <button type="button" data-cell-bg="rgba(79,143,255,0.15)" style="background:rgba(79,143,255,0.4)" title="파랑"></button>
                <button type="button" data-cell-bg="rgba(34,197,94,0.15)" style="background:rgba(34,197,94,0.4)" title="초록"></button>
                <button type="button" data-cell-bg="rgba(245,158,11,0.15)" style="background:rgba(245,158,11,0.4)" title="주황"></button>
                <button type="button" data-cell-bg="rgba(239,68,68,0.15)" style="background:rgba(239,68,68,0.4)" title="빨강"></button>
                <button type="button" data-cell-bg="rgba(139,92,246,0.15)" style="background:rgba(139,92,246,0.4)" title="보라"></button>
              </div>
            </div>
          </div>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="deleteTable" title="표 삭제" class="text-red-400"><i class="fas fa-times"></i></button>
        </div>
        
        <!-- 에디터 본문 -->
        <div id="editor" class="howto-editor-content bg-wiki-card/50 border border-wiki-border/40 border-t-0 rounded-b-xl"></div>
      </div>
      
      <!-- 출처 섹션 -->
      <div id="footnotes-section" class="editor-footnotes-section">
        <h4><i class="fas fa-book-open"></i> 출처</h4>
        <div id="footnotes-list" class="editor-footnotes-list">
          <div class="editor-footnotes-empty">
            <i class="fas fa-quote-right"></i>
            <p>각주를 추가하면 여기에 출처가 표시됩니다.</p>
          </div>
        </div>
      </div>
      
      <div id="editor-message" class="hidden mt-4"></div>
    </div>
    
    <!-- Tiptap 에디터 번들 -->
    <script src="/static/editor.bundle.iife.js"></script>
    
    <script>
      // 에디터 데이터 (초안 없음)
      let DRAFT_ID = null;
      let currentVersion = 1;
      let hasUnsavedChanges = false;
      let tiptapEditor = null;
      
      // 페이지 나가기 경고
      const beforeUnloadHandler = (e) => {
        if (hasUnsavedChanges) {
          e.preventDefault();
          e.returnValue = '저장하지 않은 변경사항이 있습니다. 정말 나가시겠습니까?';
          return e.returnValue;
        }
      };
      window.addEventListener('beforeunload', beforeUnloadHandler);
      
      // 에디터 초기화
      document.addEventListener('DOMContentLoaded', async () => {
        if (window.HowToEditor) {
          tiptapEditor = new window.HowToEditor({
            container: '#editor',
            draftId: null, // 초안 없음
            version: 1,
            initialContent: '<p></p>',
            onSave: (data) => {
              if (data.success) {
                currentVersion = data.version;
                hasUnsavedChanges = false;
                updateSaveStatus('saved');
              }
            },
            onError: (err) => {
              showMessage('error', err.message);
              updateSaveStatus('error');
            },
            onUpdate: () => {
              hasUnsavedChanges = true;
              updateSaveStatus('unsaved');
            }
          });
          window.HowToEditorInstance = tiptapEditor;
        }
        
        initAutocomplete();
        initTags();
        initThumbnail();
        setupToolbarDropdowns();
        initTitleCheck();
        
        // 저장 버튼
        document.getElementById('btn-save')?.addEventListener('click', saveDraft);
        
        // 발행 버튼
        document.getElementById('btn-publish')?.addEventListener('click', publishGuide);
        
        // 각주 목록 업데이트 이벤트 수신
        window.addEventListener('footnotes-updated', function(e) {
          var footnotes = e.detail.footnotes || [];
          var container = document.getElementById('footnotes-list');
          if (!container) return;
          
          function esc(str) {
            if (!str) return '';
            return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
          }
          
          if (footnotes.length === 0) {
            container.innerHTML = '<div class="editor-footnotes-empty"><i class="fas fa-quote-right"></i><p>각주를 추가하면 여기에 출처가 표시됩니다.</p></div>';
          } else {
            container.innerHTML = footnotes.map(function(f) {
              var urlHtml = f.url ? '<a href="' + esc(f.url) + '" target="_blank" class="editor-footnote-url">' + esc(f.url) + '</a>' : '';
              return '<div class="editor-footnote-item" data-id="' + f.id + '">' +
                '<span class="editor-footnote-id">' + f.id + '</span>' +
                '<div class="editor-footnote-content">' +
                  '<div class="editor-footnote-text">' + esc(f.text) + '</div>' +
                  urlHtml +
                '</div>' +
              '</div>';
            }).join('');
          }
        });
      });
      
      // 툴바 드롭다운 설정
      function setupToolbarDropdowns() {
        const menuSelector = '.align-menu, .font-menu, .custom-block-menu, .color-menu, .size-menu, .row-menu, .col-menu, .cell-color-menu, .border-style-menu';
        
        document.querySelectorAll('.toolbar-dropdown').forEach(dropdown => {
          const btn = dropdown.querySelector('.toolbar-btn');
          const menu = dropdown.querySelector(menuSelector);
          if (!btn || !menu) return;
          
          let isOpen = false;
          let hoverTimeout = null;
          
          btn.addEventListener('click', (e) => {
            e.stopPropagation();
            isOpen = !isOpen;
            dropdown.classList.toggle('is-open', isOpen);
            if (isOpen) {
              menu.classList.remove('hidden');
              document.querySelectorAll('.toolbar-dropdown').forEach(other => {
                if (other !== dropdown) {
                  other.classList.remove('is-open');
                  const otherMenu = other.querySelector(menuSelector);
                  if (otherMenu) otherMenu.classList.add('hidden');
                }
              });
            } else {
              menu.classList.add('hidden');
            }
          });
          
          dropdown.addEventListener('mouseenter', () => {
            clearTimeout(hoverTimeout);
            menu.classList.remove('hidden');
          });
          
          dropdown.addEventListener('mouseleave', () => {
            if (!isOpen) {
              hoverTimeout = setTimeout(() => {
                menu.classList.add('hidden');
              }, 300);
            }
          });
          
          menu.addEventListener('click', (e) => {
            if (e.target.closest('button')) {
              isOpen = false;
              dropdown.classList.remove('is-open');
              setTimeout(() => menu.classList.add('hidden'), 100);
            }
          });
        });
        
        document.addEventListener('click', (e) => {
          if (!e.target.closest('.toolbar-dropdown')) {
            document.querySelectorAll('.toolbar-dropdown').forEach(dropdown => {
              dropdown.classList.remove('is-open');
              const menu = dropdown.querySelector(menuSelector);
              if (menu) menu.classList.add('hidden');
            });
          }
        });
        
        // 폰트/크기 관련 이벤트는 에디터에서 처리
      }
      
      function updateSaveStatus(status) {
        const el = document.getElementById('save-status');
        if (!el) return;
        switch(status) {
          case 'saving':
            el.innerHTML = '<span class="text-blue-400">●</span> 저장 중...';
            break;
          case 'saved':
            el.innerHTML = '<span class="text-green-400">●</span> 저장됨';
            break;
          case 'unsaved':
            el.innerHTML = '<span class="text-amber-400">●</span> 저장되지 않음';
            break;
          case 'error':
            el.innerHTML = '<span class="text-red-400">●</span> 저장 실패';
            break;
        }
      }
      
      function showMessage(type, msg) {
        const el = document.getElementById('editor-message');
        if (!el) return;
        el.className = 'mt-4 p-4 rounded-lg text-sm ' + 
          (type === 'error' ? 'bg-red-500/10 border border-red-500/30 text-red-400' : 
           type === 'success' ? 'bg-green-500/10 border border-green-500/30 text-green-400' : 
           'bg-blue-500/10 border border-blue-500/30 text-blue-400');
        el.textContent = msg;
        el.classList.remove('hidden');
        setTimeout(() => el.classList.add('hidden'), 5000);
      }
      
      // 필드별 에러 표시
      function showFieldError(fieldId, msg) {
        clearFieldError(fieldId);
        const field = document.getElementById(fieldId);
        if (!field) return;
        field.dataset.error = 'true';
        field.style.borderColor = 'rgba(239, 68, 68, 0.6)';
        const errorEl = document.createElement('p');
        errorEl.className = 'field-error text-red-400 text-xs mt-1';
        errorEl.textContent = msg;
        field.parentElement.appendChild(errorEl);
      }
      
      function clearFieldError(fieldId) {
        const field = document.getElementById(fieldId);
        if (!field) return;
        delete field.dataset.error;
        field.style.borderColor = '';
        const existingError = field.parentElement.querySelector('.field-error');
        if (existingError) existingError.remove();
      }
      
      function clearAllFieldErrors() {
        document.querySelectorAll('.field-error').forEach(el => el.remove());
        document.querySelectorAll('[data-error="true"]').forEach(el => {
          delete el.dataset.error;
          el.style.borderColor = '';
        });
      }
      
      // 유효성 검사 (초성만 입력 등 체크)
      function validateTitle(title) {
        if (!title) return '제목을 입력해주세요.';
        if (title.length < 2) return '제목은 2자 이상이어야 합니다.';
        // 초성만 있는지 체크 (ㄱ-ㅎ만으로 이루어진 경우)
        if (/^[ㄱ-ㅎ]+$/.test(title)) return '제목에 초성만 입력할 수 없습니다.';
        return null;
      }
      
      function validateContent(html) {
        if (!html || html === '<p></p>' || html === '<p><br></p>') return '본문을 입력해주세요.';
        // 초성만 있는지 체크
        const textOnly = html.replace(/<[^>]*>/g, '').trim();
        if (/^[ㄱ-ㅎ\s]+$/.test(textOnly)) return '본문에 초성만 입력할 수 없습니다.';
        return null;
      }
      
      // 제목 중복 체크 상태
      let titleCheckTimer = null;
      let isTitleAvailable = true;
      
      function initTitleCheck() {
        const titleInput = document.getElementById('field-title');
        const titleCheck = document.getElementById('title-check');
        const titleLoading = document.getElementById('title-loading');
        const titleOk = document.getElementById('title-ok');
        const titleError = document.getElementById('title-error');
        const titleErrorMsg = document.getElementById('title-error-msg');
        
        if (!titleInput) return;
        
        titleInput.addEventListener('input', () => {
          hasUnsavedChanges = true;
          updateSaveStatus('unsaved');
          
          clearTimeout(titleCheckTimer);
          const title = titleInput.value.trim();
          
          // 빈 값이면 숨김
          if (!title) {
            titleCheck.classList.add('hidden');
            titleErrorMsg.classList.add('hidden');
            isTitleAvailable = true;
            return;
          }
          
          // 2자 미만이면 바로 에러
          if (title.length < 2) {
            titleCheck.classList.remove('hidden');
            titleLoading.classList.add('hidden');
            titleOk.classList.add('hidden');
            titleError.classList.remove('hidden');
            titleErrorMsg.textContent = '제목은 최소 2자 이상이어야 합니다';
            titleErrorMsg.classList.remove('hidden');
            isTitleAvailable = false;
            return;
          }
          
          // 로딩 표시
          titleCheck.classList.remove('hidden');
          titleLoading.classList.remove('hidden');
          titleOk.classList.add('hidden');
          titleError.classList.add('hidden');
          titleErrorMsg.classList.add('hidden');
          
          // 500ms 후 API 호출
          titleCheckTimer = setTimeout(async () => {
            try {
              const res = await fetch('/api/howto/check-title?title=' + encodeURIComponent(title));
              const data = await res.json();
              
              titleLoading.classList.add('hidden');
              
              if (data.success && data.available) {
                titleOk.classList.remove('hidden');
                titleError.classList.add('hidden');
                titleErrorMsg.classList.add('hidden');
                isTitleAvailable = true;
              } else {
                titleOk.classList.add('hidden');
                titleError.classList.remove('hidden');
                titleErrorMsg.textContent = data.reason || '사용할 수 없는 제목입니다';
                titleErrorMsg.classList.remove('hidden');
                isTitleAvailable = false;
              }
            } catch (err) {
              titleLoading.classList.add('hidden');
              titleOk.classList.add('hidden');
              titleError.classList.remove('hidden');
              titleErrorMsg.textContent = '제목 확인 중 오류가 발생했습니다';
              titleErrorMsg.classList.remove('hidden');
              isTitleAvailable = false;
            }
          }, 500);
        });
      }
      
      // 초안 저장 (없으면 새로 생성)
      async function saveDraft() {
        clearAllFieldErrors();
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          return false;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          return false;
        }
        
        const contentHtml = tiptapEditor?.editor?.getHTML();
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          return false;
        }
        
        updateSaveStatus('saving');
        
        const content = tiptapEditor?.editor?.getJSON();
        const tags = getSelectedTags();
        const relatedJobs = getSelectedItems('jobs');
        const relatedMajors = getSelectedItems('majors');
        const relatedHowtos = getSelectedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          // 저장 시 임시 발행 상태로 저장 (draft_published)
          const res = await fetch('/api/howto/save-publish', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              draftId: DRAFT_ID,
              title,
              summary,
              contentJson: JSON.stringify(content),
              contentHtml,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              thumbnailUrl: thumbnail
            })
          });
          const data = await res.json();
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '저장되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
            return true;
          } else {
            throw new Error(data.error || '저장 실패');
          }
        } catch (err) {
          showMessage('error', err.message || '저장 중 오류가 발생했습니다.');
          updateSaveStatus('error');
          return false;
        }
      }
      
      // 바로 발행하기
      async function publishGuide() {
        clearAllFieldErrors();
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          return;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          return;
        }
        
        const contentHtml = tiptapEditor?.editor?.getHTML();
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          return;
        }
        
        if (!confirm('이 가이드를 바로 발행하시겠습니까?\\n발행하면 목록에 공개됩니다.')) return;
        
        updateSaveStatus('saving');
        
        const content = tiptapEditor?.editor?.getJSON();
        const tags = getSelectedTags();
        const relatedJobs = getSelectedItems('jobs');
        const relatedMajors = getSelectedItems('majors');
        const relatedHowtos = getSelectedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          const publishBtn = document.getElementById('btn-publish');
          if (publishBtn) {
            publishBtn.disabled = true;
            publishBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>발행 중...';
          }
          
          // 바로 발행 API 호출
          const res = await fetch('/api/howto/publish-direct', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              title,
              summary,
              contentJson: JSON.stringify(content),
              contentHtml,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              thumbnailUrl: thumbnail
            })
          });
          const data = await res.json();
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '발행되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
          } else {
            throw new Error(data.error || '발행 실패');
          }
        } catch (err) {
          showMessage('error', err.message || '발행 중 오류가 발생했습니다.');
          const publishBtn = document.getElementById('btn-publish');
          if (publishBtn) {
            publishBtn.disabled = false;
            publishBtn.innerHTML = '<i class="fas fa-globe mr-2"></i>발행';
          }
        }
      }
      
      function escapeHtml(str) {
        if (!str) return '';
        return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
      }
      
      // 자동완성 초기화 (pointerdown + 이벤트 위임 + focusout 방식 + IME 지원)
      function initAutocomplete() {
        ['jobs', 'majors', 'howtos'].forEach(domain => {
          const input = document.getElementById('field-' + domain);
          const dropdown = document.getElementById(domain + '-dropdown');
          const container = document.getElementById(domain + '-container');
          if (!input || !dropdown || !container) return;
          const wrap = input.parentElement;
          
          let items = [];
          try {
            items = JSON.parse(input.dataset.items || '[]');
          } catch (e) {}
          
          items.forEach(item => addItemChip(container, item, domain));
          
          let debounceTimer = null;
          let composingTimer = null;
          let abortController = null;
          let lastSearchValue = '';
          
          // 검색 실행 함수
          const doSearch = async (q) => {
            if (q.length < 2) {
              dropdown.classList.add('hidden');
              dropdown.innerHTML = '';
              return;
            }
            
            // 이미 같은 값으로 검색했으면 스킵
            if (q === lastSearchValue) return;
            lastSearchValue = q;
            
            try {
              if (abortController) abortController.abort();
              abortController = new AbortController();
              
              const res = await fetch('/api/search?domain=' + domain + '&q=' + encodeURIComponent(q) + '&limit=10', {
                signal: abortController.signal
              });
              const data = await res.json();
              
              if (data.success && data.results && data.results.length > 0) {
                dropdown.innerHTML = data.results.map(r => 
                  '<div class="autocomplete-item" data-id="' + (r.id || r.slug) + '" data-name="' + escapeHtml(r.name || r.title) + '" data-slug="' + escapeHtml(r.slug || r.name) + '">' +
                  '<span class="text-white">' + escapeHtml(r.name || r.title) + '</span>' +
                  (r.snippet ? '<br><span class="text-xs text-wiki-muted">' + escapeHtml(r.snippet) + '</span>' : '') +
                  '</div>'
                ).join('');
                dropdown.classList.remove('hidden');
              } else {
                dropdown.classList.add('hidden');
                dropdown.innerHTML = '';
              }
            } catch (err) {
              if (err?.name !== 'AbortError') {
                console.error('[autocomplete] Error:', err);
              }
            }
          };
          
          // 모든 입력에 대해 1초 후 자동 검색 (한글 조합 중에도)
          input.addEventListener('input', () => {
            clearTimeout(debounceTimer);
            clearTimeout(composingTimer);
            const q = input.value.trim();
            
            // 1초 후 자동 검색 (한글 조합 중에도 동작)
            composingTimer = setTimeout(() => doSearch(q), 1000);
            
            // 영어 등 비조합 입력은 300ms 후 빠르게 검색
            debounceTimer = setTimeout(() => {
              const currentQ = input.value.trim();
              if (currentQ.length >= 2) {
                doSearch(currentQ);
              }
            }, 300);
          });
          
          dropdown.addEventListener('pointerdown', (e) => {
            const el = e.target.closest('.autocomplete-item');
            if (!el) return;
            e.preventDefault();
            e.stopPropagation();
            
            const item = { id: el.dataset.id, name: el.dataset.name, slug: el.dataset.slug };
            
            // 중복 체크
            const existing = container.querySelector('[data-id="' + item.id + '"]');
            if (!existing) {
              addItemChip(container, item, domain);
            }
            
            input.value = '';
            dropdown.innerHTML = '';
            dropdown.classList.add('hidden');
            input.focus();
          });
          
          const handleFocusOut = (evt) => {
            const next = evt.relatedTarget;
            const isInside = wrap ? wrap.contains(next) : (input === next || dropdown.contains(next));
            if (!isInside) {
              dropdown.classList.add('hidden');
            }
          };
          (wrap || input).addEventListener('focusout', handleFocusOut);
        });
      }
      
      function addItemChip(container, item, domain) {
        // 중복 체크
        const existingChip = container.querySelector('[data-id="' + item.id + '"]');
        if (existingChip) return;
        
        const chip = document.createElement('span');
        chip.className = 'inline-flex items-center gap-1 px-2 py-1 bg-wiki-primary/10 border border-wiki-primary/30 rounded-lg text-xs text-wiki-primary';
        chip.dataset.id = item.id;
        chip.dataset.name = item.name || item.title || '';
        chip.dataset.slug = item.slug || '';
        chip.innerHTML = escapeHtml(item.name || item.title) + '<button type="button" class="hover:text-red-400 ml-1">&times;</button>';
        
        chip.querySelector('button').addEventListener('click', () => {
          chip.remove();
        });
        
        container.appendChild(chip);
      }
      
      function getSelectedItems(domain) {
        const container = document.getElementById(domain + '-container');
        if (!container) return [];
        return Array.from(container.querySelectorAll('span[data-id]')).map(chip => ({
          id: chip.dataset.id,
          name: chip.dataset.name,
          slug: chip.dataset.slug
        }));
      }
      
      function getThumbnailUrl() {
        return thumbnailUrl;
      }
      
      // 태그 관련
      let selectedTags = [];
      
      function initTags() {
        const input = document.getElementById('field-tags');
        if (!input) return;
        
        try {
          selectedTags = JSON.parse(input.dataset.tags || '[]');
          selectedTags.forEach(tag => addTagChip(tag));
        } catch(e) {}
        
        input.addEventListener('keydown', (e) => {
          if (e.key === 'Enter' || e.key === ',') {
            e.preventDefault();
            const tag = input.value.replace(/,/g, '').trim();
            if (tag && !selectedTags.includes(tag)) {
              selectedTags.push(tag);
              addTagChip(tag);
              hasUnsavedChanges = true;
              updateSaveStatus('unsaved');
            }
            input.value = '';
          }
        });
      }
      
      function addTagChip(tag) {
        const container = document.getElementById('tags-container');
        if (!container) return;
        const chip = document.createElement('span');
        chip.className = 'inline-flex items-center gap-1 px-3 py-1 bg-wiki-primary/10 text-wiki-primary rounded-full text-sm';
        chip.innerHTML = escapeHtml(tag) + '<button type="button" class="hover:text-red-400 ml-1" onclick="removeTag(this, \\'' + escapeHtml(tag.replace(/'/g, "\\\\'")) + '\\')"><i class="fas fa-times text-xs"></i></button>';
        container.appendChild(chip);
      }
      
      function removeTag(btn, tag) {
        selectedTags = selectedTags.filter(t => t !== tag);
        btn.parentElement.remove();
        hasUnsavedChanges = true;
        updateSaveStatus('unsaved');
      }
      
      function getSelectedTags() {
        return selectedTags;
      }
      
      // 썸네일 업로드
      let thumbnailUrl = '';
      let thumbnailInitialized = false;
      
      function initThumbnail() {
        if (thumbnailInitialized) return;
        thumbnailInitialized = true;
        
        const uploadArea = document.getElementById('thumbnail-upload-area');
        const fileInput = document.getElementById('thumbnail-input');
        const placeholder = document.getElementById('thumbnail-placeholder');
        const preview = document.getElementById('thumbnail-preview');
        const thumbnailImg = document.getElementById('thumbnail-img');
        const removeBtn = document.getElementById('thumbnail-remove');
        const hiddenField = document.getElementById('field-thumbnail');
        
        if (!uploadArea || !fileInput) return;
        
        // 클릭 시 파일 선택 (이벤트 버블링 방지)
        uploadArea.addEventListener('click', (e) => {
          // fileInput 클릭이나 removeBtn 클릭은 무시
          if (e.target === fileInput || e.target.closest('#thumbnail-remove')) return;
          e.stopPropagation();
          fileInput.click();
        }, { capture: true });
        
        // 드래그 앤 드롭
        uploadArea.addEventListener('dragover', (e) => {
          e.preventDefault();
          uploadArea.classList.add('border-wiki-primary');
        });
        uploadArea.addEventListener('dragleave', () => {
          uploadArea.classList.remove('border-wiki-primary');
        });
        uploadArea.addEventListener('drop', (e) => {
          e.preventDefault();
          uploadArea.classList.remove('border-wiki-primary');
          const file = e.dataTransfer?.files?.[0];
          if (file && file.type.startsWith('image/')) {
            handleThumbnailUpload(file);
          }
        });
        
        // 파일 선택
        fileInput.addEventListener('change', (e) => {
          const file = e.target.files?.[0];
          if (file) {
            handleThumbnailUpload(file);
          }
          // 같은 파일 재선택 가능하도록 value 리셋
          e.target.value = '';
        });
        
        // 기존 이미지 로드
        if (hiddenField && hiddenField.value) {
          thumbnailUrl = hiddenField.value;
          if (preview) preview.classList.remove('hidden');
          if (placeholder) placeholder.classList.add('hidden');
          if (thumbnailImg) thumbnailImg.src = thumbnailUrl;
          if (removeBtn) removeBtn.classList.remove('hidden');
        }
        
        // 삭제 버튼
        if (removeBtn) {
          removeBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            thumbnailUrl = '';
            if (hiddenField) hiddenField.value = '';
            if (preview) preview.classList.add('hidden');
            if (placeholder) placeholder.classList.remove('hidden');
            if (removeBtn) removeBtn.classList.add('hidden');
            hasUnsavedChanges = true;
            updateSaveStatus('unsaved');
          });
        }
      }
      
      function handleThumbnailUpload(file) {
        const formData = new FormData();
        formData.append('file', file);
        
        fetch('/api/upload', {
          method: 'POST',
          body: formData
        })
        .then(res => res.json())
        .then(data => {
          if (data.success && data.url) {
            thumbnailUrl = data.url;
            const hiddenField = document.getElementById('field-thumbnail');
            if (hiddenField) hiddenField.value = data.url;
            const preview = document.getElementById('thumbnail-preview');
            const placeholder = document.getElementById('thumbnail-placeholder');
            const thumbnailImg = document.getElementById('thumbnail-img');
            const removeBtn = document.getElementById('thumbnail-remove');
            if (preview) preview.classList.remove('hidden');
            if (placeholder) placeholder.classList.add('hidden');
            if (thumbnailImg) thumbnailImg.src = data.url;
            if (removeBtn) removeBtn.classList.remove('hidden');
            hasUnsavedChanges = true;
            updateSaveStatus('unsaved');
          } else {
            alert('썸네일 업로드 실패: ' + (data.error || '알 수 없는 오류'));
          }
        })
        .catch(err => {
          console.error('썸네일 업로드 오류:', err);
          alert('썸네일 업로드 중 오류가 발생했습니다.');
        });
      }
      
      function getThumbnailUrl() {
        return thumbnailUrl;
      }
      
      // 초기화
      document.addEventListener('DOMContentLoaded', function() {
        initTags();
        initThumbnail();
      });
    </script>
  `
  
  return c.html(
    renderLayoutWithContext(c, content, 'HowTo 가이드 작성 - Careerwiki', '새 가이드를 작성합니다')
  )
})

// HowTo 초안 편집 페이지
app.get('/howto/draft/:id', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=' + encodeURIComponent(c.req.path))
  }
  
  const draftId = parseInt(c.req.param('id'))
  if (!Number.isFinite(draftId)) {
    return c.redirect('/howto')
  }
  
  // 초안 조회
  const { getDraft } = await import('./services/draftService')
  const draftResult = await getDraft(c.env.DB, draftId, user.id)
  
  if (!draftResult.success) {
    const content = `
      <div class="max-w-2xl mx-auto px-4 py-16 text-center">
        <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-amber-500/10 mb-6">
          <i class="fas fa-file-alt text-3xl text-amber-400"></i>
        </div>
        <h1 class="text-2xl font-bold text-white mb-2">초안을 찾을 수 없습니다</h1>
        <p class="text-wiki-muted mb-6">삭제되었거나 접근 권한이 없습니다.</p>
        <a href="/howto/write" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
          새 글 작성
        </a>
      </div>
    `
    return c.html(renderLayoutWithContext(c, content, '초안 없음 - Careerwiki', ''))
  }
  
  const draft = draftResult.draft!
  
  // 발행 이력 확인 (published_page_id가 있는지)
  const publishedPageInfo = await c.env.DB.prepare(`
    SELECT published_page_id, 
           (SELECT slug FROM pages WHERE id = published_page_id) as published_slug,
           (SELECT status FROM pages WHERE id = published_page_id) as page_status
    FROM howto_drafts WHERE id = ?
  `).bind(draftId).first<{ published_page_id: number | null; published_slug: string | null; page_status: string | null }>()
  
  const hasPublishedVersion = !!publishedPageInfo?.published_page_id
  const pageStatus = publishedPageInfo?.page_status || ''
  const isPublished = pageStatus === 'published'
  const isDraftPublished = pageStatus === 'draft_published'
  const publishedSlug = publishedPageInfo?.published_slug || ''
  
  const content = `
    <!-- Tiptap CDN -->
    <link rel="stylesheet" href="/static/howto-editor.css">
    
    <div class="max-w-6xl mx-auto px-3 sm:px-4 py-4 sm:py-6">
      <!-- 헤더 -->
      <header class="mb-6">
        <!-- 상단: 뒤로가기 + 제목 + 삭제 -->
        <div class="flex items-center gap-3 mb-3">
          <a href="/howto" class="flex items-center justify-center w-10 h-10 min-w-[44px] min-h-[44px] text-wiki-muted hover:text-white hover:bg-wiki-border/30 rounded-xl transition shrink-0">
            <i class="fas fa-arrow-left text-lg"></i>
          </a>
          <div class="min-w-0 flex-1">
            <h1 class="text-xl sm:text-2xl font-bold text-white leading-tight">${hasPublishedVersion ? '가이드 편집' : '가이드 작성'}</h1>
            <p class="text-xs sm:text-sm text-wiki-muted mt-0.5" id="save-status">
              <span class="text-amber-400">●</span> 저장되지 않음
            </p>
          </div>
          <button type="button" id="btn-delete" class="shrink-0 w-10 h-10 sm:w-auto sm:h-auto sm:px-3 sm:py-2 flex items-center justify-center text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-xl transition" title="삭제">
            <i class="fas fa-trash-alt sm:mr-1.5"></i>
            <span class="hidden sm:inline text-sm">삭제</span>
          </button>
        </div>
        
        <!-- 하단: 액션 버튼 -->
        <div class="flex items-center gap-2 sm:gap-3">
          <button type="button" id="btn-save" class="flex-1 sm:flex-none px-4 py-2.5 min-h-[44px] border border-wiki-border/60 text-wiki-muted hover:text-white hover:bg-wiki-border/20 rounded-xl transition text-sm font-medium flex items-center justify-center gap-2">
            <i class="fas fa-save"></i>
            <span>임시저장</span>
          </button>
          ${isPublished ? `
            <button type="button" id="btn-update" class="flex-1 sm:flex-none px-4 sm:px-5 py-2.5 min-h-[44px] bg-gradient-to-r from-emerald-500 to-teal-500 hover:from-emerald-500/90 hover:to-teal-500/90 text-white rounded-xl transition text-sm font-medium flex items-center justify-center gap-2 shadow-lg shadow-emerald-500/20">
              <i class="fas fa-sync-alt"></i>
              <span>업데이트</span>
            </button>
          ` : `
            <button type="button" id="btn-publish" class="flex-1 sm:flex-none px-4 sm:px-5 py-2.5 min-h-[44px] bg-gradient-to-r from-wiki-primary to-blue-500 hover:from-wiki-primary/90 hover:to-blue-500/90 text-white rounded-xl transition text-sm font-medium flex items-center justify-center gap-2 shadow-lg shadow-wiki-primary/20">
              <i class="fas fa-paper-plane"></i>
              <span>발행하기</span>
            </button>
          `}
        </div>
      </header>
      
      <!-- 메타 필드 -->
      <div class="grid gap-4 mb-6">
        <!-- 제목 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">제목 *</label>
          <div class="relative">
            <input type="text" id="field-title" maxlength="100"
                   class="w-full px-4 py-3 pr-10 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white text-lg font-semibold placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                   placeholder="가이드 제목을 입력하세요"
                   value="${escapeHtml(draft.title || '')}" />
            <span id="title-check" class="absolute right-3 top-1/2 -translate-y-1/2 text-lg hidden">
              <i class="fas fa-spinner fa-spin text-wiki-muted" id="title-loading"></i>
              <i class="fas fa-check-circle text-green-500 hidden" id="title-ok"></i>
              <i class="fas fa-times-circle text-red-500 hidden" id="title-error"></i>
            </span>
          </div>
          <p id="title-error-msg" class="mt-1 text-xs text-red-400 hidden"></p>
        </div>
        
        <!-- 요약 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">요약</label>
          <textarea id="field-summary" maxlength="300" rows="2"
                    class="w-full px-4 py-3 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition resize-none"
                    placeholder="이 가이드가 어떤 내용을 다루는지 간략히 설명해주세요">${escapeHtml(draft.summary || '')}</textarea>
        </div>
        
        <!-- 썸네일 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">썸네일 <span class="text-wiki-muted font-normal">(선택)</span></label>
          <div id="thumbnail-upload-area" class="border-2 border-dashed border-wiki-border/40 rounded-xl p-4 text-center hover:border-wiki-primary/50 transition cursor-pointer">
            <div id="thumbnail-placeholder" class="${(draft as any).thumbnailUrl ? 'hidden' : ''} space-y-2">
              <i class="fas fa-image text-3xl text-wiki-muted"></i>
              <p class="text-sm text-wiki-muted">클릭하여 이미지 업로드 또는 드래그 앤 드롭</p>
              <p class="text-xs text-wiki-muted/60">없으면 본문의 첫 번째 이미지가 자동으로 사용됩니다</p>
            </div>
            <div id="thumbnail-preview" class="${(draft as any).thumbnailUrl ? '' : 'hidden'}">
              <img id="thumbnail-img" src="${escapeHtml((draft as any).thumbnailUrl || '')}" alt="썸네일 미리보기" class="max-h-48 mx-auto rounded-lg" />
              <button type="button" id="thumbnail-remove" class="mt-2 text-sm text-red-400 hover:text-red-300">
                <i class="fas fa-times mr-1"></i>썸네일 제거
              </button>
            </div>
          </div>
          <input type="file" id="thumbnail-input" accept="image/*" class="hidden" />
          <input type="hidden" id="field-thumbnail" value="${escapeHtml((draft as any).thumbnailUrl || '')}" />
        </div>
        
        <!-- 태그 & 관련 콘텐츠 -->
        <div class="grid md:grid-cols-2 gap-4">
          <!-- 태그 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">태그</label>
            <div class="relative">
              <input type="text" id="field-tags"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="태그 입력 후 Enter 또는 쉼표(,)"
                     data-tags='${escapeHtml(JSON.stringify(draft.tags || []))}' />
              <div id="tags-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
          
          <!-- 관련 직업 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 직업</label>
            <div class="relative">
              <input type="text" id="field-jobs" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="직업 검색..."
                     data-items='${escapeHtml(JSON.stringify(draft.relatedJobs || []))}' />
              <div id="jobs-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="jobs-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
        </div>
        
        <div class="grid md:grid-cols-2 gap-4">
          <!-- 관련 전공 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 전공</label>
            <div class="relative">
              <input type="text" id="field-majors" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="전공 검색..."
                     data-items='${escapeHtml(JSON.stringify(draft.relatedMajors || []))}' />
              <div id="majors-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="majors-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
          
          <!-- 관련 HowTo -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 HowTo</label>
            <div class="relative">
              <input type="text" id="field-howtos" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="HowTo 검색..."
                     data-items='${escapeHtml(JSON.stringify(draft.relatedHowtos || []))}' />
              <div id="howtos-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="howtos-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 본문 영역 -->
      <div>
        <label class="block text-sm font-medium text-wiki-text mb-2">본문 *</label>
        
        <!-- 에디터 툴바 -->
        <div id="toolbar" class="howto-editor-toolbar bg-wiki-card/50 border border-wiki-border/40 rounded-t-xl px-3 py-2">
          <div class="toolbar-group">
            <button type="button" data-action="bold" title="굵게 (Ctrl+B)"><i class="fas fa-bold"></i></button>
            <button type="button" data-action="italic" title="기울임 (Ctrl+I)"><i class="fas fa-italic"></i></button>
            <button type="button" data-action="underline" title="밑줄 (Ctrl+U)"><i class="fas fa-underline"></i></button>
            <button type="button" data-action="strike" title="취소선"><i class="fas fa-strikethrough"></i></button>
          </div>
          <div class="toolbar-group">
            <!-- 폰트 -->
            <div class="toolbar-dropdown font-dropdown">
              <button type="button" title="폰트" class="toolbar-btn flex items-center gap-1.5"><span class="current-font-name">기본</span><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="font-menu hidden">
                <button type="button" data-font="inherit" class="is-active">기본</button>
                <button type="button" data-font="sans-serif">Sans-serif (샌즈)</button>
                <button type="button" data-font="serif">Serif (세리프)</button>
                <button type="button" data-font="monospace">Monospace (코드)</button>
                <button type="button" data-font="'Nanum Gothic', sans-serif">나눔고딕</button>
                <button type="button" data-font="'Nanum Myeongjo', serif">나눔명조</button>
              </div>
            </div>
            <!-- 폰트 크기 -->
            <div class="toolbar-dropdown size-dropdown">
              <button type="button" title="글자 크기" class="toolbar-btn size-input-btn">
                <input type="number" class="size-input" value="15" min="6" max="72" title="글자 크기 (px)">
                <i class="fas fa-chevron-down text-[10px] opacity-60"></i>
              </button>
              <div class="size-menu hidden">
                <button type="button" data-size="8px">8</button>
                <button type="button" data-size="12px">12</button>
                <button type="button" data-size="14px">14</button>
                <button type="button" data-size="15px" class="is-default">15</button>
                <button type="button" data-size="16px">16</button>
                <button type="button" data-size="18px">18</button>
                <button type="button" data-size="20px">20</button>
                <button type="button" data-size="24px">24</button>
                <button type="button" data-size="28px">28</button>
                <button type="button" data-size="32px">32</button>
                <button type="button" data-size="36px">36</button>
              </div>
            </div>
            <!-- 폰트 색상 -->
            <div class="toolbar-dropdown color-dropdown">
              <button type="button" title="글자 색상" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-palette"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="color-menu hidden">
                <div class="color-grid">
                  <button type="button" data-color="#ffffff" style="background:#ffffff" title="흰색"></button>
                  <button type="button" data-color="#f59e0b" style="background:#f59e0b" title="주황"></button>
                  <button type="button" data-color="#ef4444" style="background:#ef4444" title="빨강"></button>
                  <button type="button" data-color="#22c55e" style="background:#22c55e" title="초록"></button>
                  <button type="button" data-color="#3b82f6" style="background:#3b82f6" title="파랑"></button>
                  <button type="button" data-color="#8b5cf6" style="background:#8b5cf6" title="보라"></button>
                  <button type="button" data-color="#ec4899" style="background:#ec4899" title="분홍"></button>
                  <button type="button" data-color="#6b7280" style="background:#6b7280" title="회색"></button>
                </div>
                <button type="button" data-color="" class="color-reset">기본 색상</button>
              </div>
            </div>
          </div>
          <div class="toolbar-group">
            <!-- 정렬 -->
            <div class="toolbar-dropdown align-dropdown">
              <button type="button" title="정렬" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-align-left"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="align-menu hidden">
                <button type="button" data-action="alignLeft"><i class="fas fa-align-left"></i> 왼쪽</button>
                <button type="button" data-action="alignCenter"><i class="fas fa-align-center"></i> 중앙</button>
                <button type="button" data-action="alignRight"><i class="fas fa-align-right"></i> 오른쪽</button>
              </div>
            </div>
            <!-- 커스텀 블록 -->
            <div class="toolbar-dropdown custom-block-dropdown">
              <button type="button" title="커스텀 블록" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-cube"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="toolbar-dropdown-content custom-block-menu hidden">
                <button type="button" data-action="blockquote"><i class="fas fa-quote-left text-sky-400"></i> 인용구</button>
                <button type="button" data-action="horizontalRule"><i class="fas fa-minus text-purple-400"></i> 구분선</button>
                <button type="button" data-action="checkpointBox"><i class="fas fa-check-circle text-green-500"></i> 체크포인트</button>
                <button type="button" data-action="conclusionBox"><i class="fas fa-lightbulb text-wiki-primary"></i> 결론 박스</button>
                <button type="button" data-action="qnaBlock"><i class="fas fa-question-circle text-amber-500"></i> Q&A</button>
              </div>
            </div>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="h1" title="제목 1">H1</button>
            <button type="button" data-action="h2" title="제목 2">H2</button>
            <button type="button" data-action="h3" title="제목 3">H3</button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="bulletList" title="글머리 기호"><i class="fas fa-list-ul"></i></button>
            <button type="button" data-action="orderedList" title="번호 매기기"><i class="fas fa-list-ol"></i></button>
            <button type="button" data-action="taskList" title="체크리스트"><i class="fas fa-tasks"></i></button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="link" title="외부 링크"><i class="fas fa-link"></i></button>
            <button type="button" data-action="internalLink" title="내부 링크 (직업/전공/HowTo)"><i class="fas fa-sitemap"></i></button>
            <button type="button" data-action="footnote" title="각주 (출처)"><i class="fas fa-asterisk"></i></button>
            <button type="button" data-action="image" title="이미지"><i class="fas fa-image"></i></button>
            <button type="button" data-action="table" title="표"><i class="fas fa-table"></i></button>
            <button type="button" data-action="codeBlock" title="코드 블록"><i class="fas fa-code"></i></button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="undo" title="실행 취소 (Ctrl+Z)"><i class="fas fa-undo"></i></button>
            <button type="button" data-action="redo" title="다시 실행 (Ctrl+Y)"><i class="fas fa-redo"></i></button>
          </div>
        </div>
        
        <!-- 표 편집 툴바 (압축형) -->
        <div id="table-toolbar" class="table-toolbar">
          <div class="toolbar-dropdown row-dropdown">
            <button type="button" title="행 추가" class="toolbar-btn"><i class="fas fa-plus"></i> 행</button>
            <div class="row-menu hidden">
              <button type="button" data-action="addRowBefore"><i class="fas fa-arrow-up"></i> 위에 추가</button>
              <button type="button" data-action="addRowAfter"><i class="fas fa-arrow-down"></i> 아래에 추가</button>
            </div>
          </div>
          <div class="toolbar-dropdown col-dropdown">
            <button type="button" title="열 추가" class="toolbar-btn"><i class="fas fa-plus"></i> 열</button>
            <div class="col-menu hidden">
              <button type="button" data-action="addColBefore"><i class="fas fa-arrow-left"></i> 왼쪽에 추가</button>
              <button type="button" data-action="addColAfter"><i class="fas fa-arrow-right"></i> 오른쪽에 추가</button>
            </div>
          </div>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="deleteRow" title="행 삭제"><i class="fas fa-trash-alt"></i></button>
          <button type="button" data-action="deleteCol" title="열 삭제"><i class="fas fa-columns"></i></button>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="mergeCells" title="셀 병합"><i class="fas fa-compress-alt"></i></button>
          <button type="button" data-action="splitCell" title="셀 분할"><i class="fas fa-expand-alt"></i></button>
          <!-- 셀 배경색 -->
          <span class="toolbar-divider"></span>
          <div class="toolbar-dropdown cell-color-dropdown">
            <button type="button" title="셀 배경색" class="toolbar-btn"><i class="fas fa-fill-drip"></i></button>
            <div class="cell-color-menu hidden">
              <div class="color-grid">
                <button type="button" data-cell-bg="" style="background:transparent;border:1px dashed #666" title="없음"></button>
                <button type="button" data-cell-bg="rgba(79,143,255,0.15)" style="background:rgba(79,143,255,0.4)" title="파랑"></button>
                <button type="button" data-cell-bg="rgba(34,197,94,0.15)" style="background:rgba(34,197,94,0.4)" title="초록"></button>
                <button type="button" data-cell-bg="rgba(245,158,11,0.15)" style="background:rgba(245,158,11,0.4)" title="주황"></button>
                <button type="button" data-cell-bg="rgba(239,68,68,0.15)" style="background:rgba(239,68,68,0.4)" title="빨강"></button>
                <button type="button" data-cell-bg="rgba(139,92,246,0.15)" style="background:rgba(139,92,246,0.4)" title="보라"></button>
              </div>
            </div>
          </div>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="deleteTable" title="표 삭제" class="text-red-400"><i class="fas fa-times"></i></button>
        </div>
        
        <!-- 에디터 본문 (Tiptap 마운트) -->
        <div id="editor" class="howto-editor-content bg-wiki-card/50 border border-wiki-border/40 border-t-0 rounded-b-xl"></div>
      </div>
      
      <!-- 출처 섹션 -->
      <div id="footnotes-section" class="editor-footnotes-section">
        <h4><i class="fas fa-book-open"></i> 출처</h4>
        <div id="footnotes-list" class="editor-footnotes-list">
          <div class="editor-footnotes-empty">
            <i class="fas fa-quote-right"></i>
            <p>각주를 추가하면 여기에 출처가 표시됩니다.</p>
          </div>
        </div>
      </div>
      
      <!-- 메시지 -->
      <div id="editor-message" class="hidden mt-4"></div>
    </div>
    
    <!-- 충돌 다이얼로그 -->
    <div id="conflict-dialog" class="hidden">
      <div class="backdrop"></div>
      <div class="content">
        <h3 class="text-lg font-semibold text-white mb-4">버전 충돌 발생</h3>
        <p class="text-wiki-muted mb-4">
          다른 곳에서 이 초안이 수정되었습니다.<br>
          서버 버전: <span data-server-version>-</span> / 내 버전: <span data-local-version>-</span>
        </p>
        <div class="flex gap-3">
          <button type="button" id="conflict-reload" class="flex-1 px-4 py-2 bg-wiki-primary text-white rounded-lg">
            서버 버전 불러오기
          </button>
          <button type="button" id="conflict-overwrite" class="flex-1 px-4 py-2 border border-wiki-border text-wiki-muted rounded-lg">
            내 버전으로 덮어쓰기
          </button>
        </div>
      </div>
    </div>
    
    <!-- Tiptap 에디터 번들 -->
    <script src="/static/editor.bundle.iife.js"></script>
    
    <script>
      // 에디터 데이터
      const DRAFT_ID = ${draftId};
      const DRAFT_VERSION = ${draft.version};
      const PAGE_STATUS = '${pageStatus}';
      const IS_PUBLISHED = ${isPublished};
      const HAS_PUBLISHED_VERSION = ${hasPublishedVersion};
      const PUBLISHED_PAGE_ID = ${publishedPageInfo?.published_page_id || 'null'};
      // contentJson이 있으면 JSON으로, 없으면 HTML로 초기화
      const CONTENT_JSON_RAW = ${JSON.stringify(draft.contentJson || null)};
      const CONTENT_JSON = (CONTENT_JSON_RAW && CONTENT_JSON_RAW.length > 10 && CONTENT_JSON_RAW !== '{}') ? JSON.parse(CONTENT_JSON_RAW) : null;
      const CONTENT_HTML = ${JSON.stringify(draft.contentHtml || '<p></p>')};
      const INITIAL_CONTENT = CONTENT_JSON || CONTENT_HTML;
      console.log('[draft] CONTENT_JSON:', CONTENT_JSON ? 'exists' : 'null', 'CONTENT_HTML length:', CONTENT_HTML.length);
      let currentVersion = DRAFT_VERSION;
      let hasUnsavedChanges = false;
      let tiptapEditor = null;  // Tiptap 에디터 인스턴스
      
      // 페이지 나가기 경고
      const beforeUnloadHandler = (e) => {
        if (hasUnsavedChanges) {
          e.preventDefault();
          e.returnValue = '저장하지 않은 변경사항이 있습니다. 정말 나가시겠습니까?';
          return e.returnValue;
        }
      };
      window.addEventListener('beforeunload', beforeUnloadHandler);
      
      // 에디터 초기화
      document.addEventListener('DOMContentLoaded', async () => {
        // Tiptap 에디터 초기화
        if (window.HowToEditor) {
          tiptapEditor = new window.HowToEditor({
            container: '#editor',
            draftId: DRAFT_ID,
            version: DRAFT_VERSION,
            initialContent: INITIAL_CONTENT,
            onSave: (data) => {
              if (data.success) {
                currentVersion = data.version;
                hasUnsavedChanges = false;
                updateSaveStatus('saved');
              }
            },
            onError: (err) => {
              showMessage('error', err.message);
              updateSaveStatus('error');
            },
            onUpdate: () => {
              hasUnsavedChanges = true;
              updateSaveStatus('unsaved');
            }
          });
          window.HowToEditorInstance = tiptapEditor;
        } else {
          console.error('Tiptap 에디터 번들이 로드되지 않았습니다');
        }
        
        // 자동완성 초기화
        initAutocomplete();
        
        // 태그 초기화
        initTags();
        
        // 썸네일 초기화
        initThumbnail();
        
        // 제목 중복 체크 초기화
        initTitleCheck();
        
        // 툴바 드롭다운 설정
        function setupToolbarDropdowns() {
          const menuSelector = '.align-menu, .font-menu, .custom-block-menu, .color-menu, .size-menu, .row-menu, .col-menu, .cell-color-menu, .border-style-menu';
          
          document.querySelectorAll('.toolbar-dropdown').forEach(dropdown => {
            const btn = dropdown.querySelector('.toolbar-btn');
            const menu = dropdown.querySelector(menuSelector);
            if (!btn || !menu) return;
            
            let isOpen = false;
            let hoverTimeout = null;
            
            btn.addEventListener('click', (e) => {
              e.stopPropagation();
              isOpen = !isOpen;
              dropdown.classList.toggle('is-open', isOpen);
              if (isOpen) {
                menu.classList.remove('hidden');
                document.querySelectorAll('.toolbar-dropdown').forEach(other => {
                  if (other !== dropdown) {
                    other.classList.remove('is-open');
                    const otherMenu = other.querySelector(menuSelector);
                    if (otherMenu) otherMenu.classList.add('hidden');
                  }
                });
              } else {
                menu.classList.add('hidden');
              }
            });
            
            dropdown.addEventListener('mouseenter', () => {
              clearTimeout(hoverTimeout);
              menu.classList.remove('hidden');
            });
            
            dropdown.addEventListener('mouseleave', () => {
              if (!isOpen) {
                hoverTimeout = setTimeout(() => {
                  menu.classList.add('hidden');
                }, 300);
              }
            });
            
            menu.addEventListener('click', (e) => {
              if (e.target.closest('button')) {
                isOpen = false;
                dropdown.classList.remove('is-open');
                setTimeout(() => menu.classList.add('hidden'), 100);
              }
            });
          });
          
          document.addEventListener('click', (e) => {
            if (!e.target.closest('.toolbar-dropdown')) {
              document.querySelectorAll('.toolbar-dropdown').forEach(dropdown => {
                dropdown.classList.remove('is-open');
                const menu = dropdown.querySelector(menuSelector);
                if (menu) menu.classList.add('hidden');
              });
            }
          });
        }
        
        // 툴바 드롭다운 초기화
        setupToolbarDropdowns();
        
        // 저장 버튼
        document.getElementById('btn-save').addEventListener('click', async () => {
          await saveDraft();
        });
        
        // 발행 버튼 (임시 발행 → 정식 발행)
        document.getElementById('btn-publish')?.addEventListener('click', async () => {
          await publishFromDraft();
        });
        
        // 업데이트 버튼 (발행된 페이지 업데이트)
        document.getElementById('btn-update')?.addEventListener('click', async () => {
          await updatePublished();
        });
        
        // 삭제 버튼
        document.getElementById('btn-delete')?.addEventListener('click', async () => {
          const title = document.getElementById('field-title')?.value || '제목 없음';
          const confirmMsg = HAS_PUBLISHED_VERSION && PUBLISHED_PAGE_ID
            ? '정말 "' + title + '" 가이드를 삭제하시겠습니까?\\n삭제된 가이드는 복구할 수 없습니다.'
            : '정말 "' + title + '" 초안을 삭제하시겠습니까?\\n삭제된 초안은 복구할 수 없습니다.';
          
          if (!confirm(confirmMsg)) {
            return;
          }
          
          const btn = document.getElementById('btn-delete');
          const originalHtml = btn.innerHTML;
          btn.disabled = true;
          btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>삭제 중...';
          
          try {
            // 발행된 페이지가 있으면 페이지 삭제 API, 없으면 초안 삭제 API 호출
            const deleteUrl = HAS_PUBLISHED_VERSION && PUBLISHED_PAGE_ID
              ? '/api/howto/' + PUBLISHED_PAGE_ID
              : '/api/howto/drafts/' + DRAFT_ID;
            
            const response = await fetch(deleteUrl, {
              method: 'DELETE',
              credentials: 'include'
            });
            
            const result = await response.json();
            
            if (result.success) {
              alert('삭제되었습니다.');
              window.location.href = '/howto/my-drafts';
            } else {
              alert('삭제 실패: ' + (result.error || '알 수 없는 오류'));
              btn.disabled = false;
              btn.innerHTML = originalHtml;
            }
          } catch (err) {
            alert('삭제 중 오류가 발생했습니다.');
            btn.disabled = false;
            btn.innerHTML = originalHtml;
          }
        });
        
        // 커스텀 블록 드롭다운 (호버/클릭 제어)
        document.querySelectorAll('.custom-block-dropdown').forEach(dropdown => {
          const btn = dropdown.querySelector('.toolbar-btn');
          const menu = dropdown.querySelector('.custom-block-menu');
          if (!btn || !menu) return;
          
          let isOpen = false;
          let hoverTimeout = null;
          
          // 호버 시 표시
          dropdown.addEventListener('mouseenter', () => {
            if (!isOpen) {
              clearTimeout(hoverTimeout);
              menu.classList.remove('hidden');
            }
          });
          
          // 호버 아웃 시 숨김 (열려있지 않을 때만)
          dropdown.addEventListener('mouseleave', () => {
            if (!isOpen) {
              hoverTimeout = setTimeout(() => {
                menu.classList.add('hidden');
              }, 200);
            }
          });
          
          // 클릭 시 토글
          btn.addEventListener('click', (e) => {
            e.stopPropagation();
            isOpen = !isOpen;
            if (isOpen) {
              menu.classList.remove('hidden');
            } else {
              menu.classList.add('hidden');
            }
          });
          
          // 메뉴 아이템 클릭 시 닫기
          menu.querySelectorAll('button').forEach(item => {
            item.addEventListener('click', () => {
              isOpen = false;
              menu.classList.add('hidden');
            });
          });
        });
        
        // 외부 클릭 시 모든 드롭다운 닫기
        document.addEventListener('click', (e) => {
          if (!e.target.closest('.custom-block-dropdown')) {
            document.querySelectorAll('.custom-block-dropdown').forEach(dropdown => {
              const menu = dropdown.querySelector('.custom-block-menu');
              if (menu) menu.classList.add('hidden');
            });
          }
          if (!e.target.closest('.align-dropdown')) {
            document.querySelectorAll('.align-menu').forEach(m => m.classList.add('hidden'));
          }
          if (!e.target.closest('.font-dropdown')) {
            document.querySelectorAll('.font-menu').forEach(m => m.classList.add('hidden'));
          }
        });
        
        // 정렬 드롭다운 제어
        document.querySelectorAll('.align-dropdown').forEach(dropdown => {
          const btn = dropdown.querySelector('.toolbar-btn');
          const menu = dropdown.querySelector('.align-menu');
          if (!btn || !menu) return;
          
          btn.addEventListener('click', (e) => {
            e.stopPropagation();
            menu.classList.toggle('hidden');
            menu.classList.toggle('visible');
          });
          
          menu.querySelectorAll('button').forEach(item => {
            item.addEventListener('click', () => {
              menu.classList.add('hidden');
              menu.classList.remove('visible');
            });
          });
        });
        
        // 폰트/크기 관련 이벤트는 에디터에서 처리
        // 드롭다운 열기/닫기만 처리
        document.querySelectorAll('.font-dropdown').forEach(dropdown => {
          const btn = dropdown.querySelector('.toolbar-btn');
          const menu = dropdown.querySelector('.font-menu');
          if (!btn || !menu) return;
          
          btn.addEventListener('click', (e) => {
            e.stopPropagation();
            menu.classList.toggle('hidden');
            menu.classList.toggle('visible');
          });
          
          menu.querySelectorAll('button').forEach(item => {
            item.addEventListener('click', () => {
              menu.classList.add('hidden');
              menu.classList.remove('visible');
            });
          });
        });
        
        // 표 툴바 제어 (표 안에 커서 있을 때만 표시)
        const tableToolbar = document.getElementById('table-toolbar');
        if (tableToolbar && tiptapEditor) {
          // 에디터 선택 변경 시 표 상태 확인
          const checkTableState = () => {
            if (tiptapEditor.isInTable && tiptapEditor.isInTable()) {
              tableToolbar.classList.add('visible');
            } else {
              tableToolbar.classList.remove('visible');
            }
          };
          
          // 주기적 확인 (더 나은 방법은 에디터 이벤트 사용)
          document.getElementById('editor').addEventListener('click', checkTableState);
          document.getElementById('editor').addEventListener('keyup', checkTableState);
          
          // 표 툴바 버튼 이벤트
          tableToolbar.querySelectorAll('[data-action]').forEach(btn => {
            btn.addEventListener('click', () => {
              const action = btn.dataset.action;
              if (tiptapEditor && typeof tiptapEditor.executeToolbarAction === 'function') {
                tiptapEditor.executeToolbarAction(action);
              }
            });
          });
        }
        
        // 각주 목록 업데이트 이벤트 수신
        window.addEventListener('footnotes-updated', (e) => {
          const footnotes = e.detail.footnotes || [];
          const container = document.getElementById('footnotes-list');
          if (!container) return;
          
          if (footnotes.length === 0) {
            container.innerHTML = '<div class="editor-footnotes-empty"><i class="fas fa-quote-right"></i><p>각주를 추가하면 여기에 출처가 표시됩니다.</p></div>';
          } else {
            container.innerHTML = footnotes.map(function(f) {
              var urlHtml = f.url ? '<a href="' + escapeHtml(f.url) + '" target="_blank" class="editor-footnote-url">' + escapeHtml(f.url) + '</a>' : '';
              return '<div class="editor-footnote-item" data-id="' + f.id + '">' +
                '<span class="editor-footnote-id">' + f.id + '</span>' +
                '<div class="editor-footnote-content">' +
                  '<div class="editor-footnote-text">' + escapeHtml(f.text) + '</div>' +
                  urlHtml +
                '</div>' +
                '<div class="editor-footnote-actions">' +
                  '<button type="button" class="btn-edit" data-id="' + f.id + '" title="편집"><i class="fas fa-edit"></i></button>' +
                  '<button type="button" class="btn-delete" data-id="' + f.id + '" title="삭제"><i class="fas fa-trash"></i></button>' +
                '</div>' +
              '</div>';
            }).join('');
            
            // 편집/삭제 버튼 이벤트
            container.querySelectorAll('.btn-edit').forEach(btn => {
              btn.addEventListener('click', () => {
                const id = parseInt(btn.dataset.id);
                const f = footnotes.find(x => x.id === id);
                if (f && tiptapEditor && typeof tiptapEditor.showFootnoteModal === 'function') {
                  tiptapEditor.showFootnoteModal(id, f.text, f.url);
                }
              });
            });
            
            container.querySelectorAll('.btn-delete').forEach(btn => {
              btn.addEventListener('click', () => {
                const id = parseInt(btn.dataset.id);
                if (confirm('이 각주를 삭제하시겠습니까?') && tiptapEditor && typeof tiptapEditor.deleteFootnote === 'function') {
                  tiptapEditor.deleteFootnote(id);
                }
              });
            });
          }
        });
        
        // 요약 변경 추적
        document.getElementById('field-summary').addEventListener('input', () => {
          hasUnsavedChanges = true;
          updateSaveStatus('unsaved');
        });
      });
      
      // 제목 중복 체크 상태
      let titleCheckTimer = null;
      let isTitleAvailable = true;
      const EXCLUDE_PAGE_ID = HAS_PUBLISHED_VERSION ? PUBLISHED_PAGE_ID : null;
      
      function initTitleCheck() {
        const titleInput = document.getElementById('field-title');
        const titleCheck = document.getElementById('title-check');
        const titleLoading = document.getElementById('title-loading');
        const titleOk = document.getElementById('title-ok');
        const titleError = document.getElementById('title-error');
        const titleErrorMsg = document.getElementById('title-error-msg');
        
        if (!titleInput) return;
        
        titleInput.addEventListener('input', () => {
          hasUnsavedChanges = true;
          updateSaveStatus('unsaved');
          
          clearTimeout(titleCheckTimer);
          const title = titleInput.value.trim();
          
          // 빈 값이면 숨김
          if (!title) {
            titleCheck.classList.add('hidden');
            titleErrorMsg.classList.add('hidden');
            isTitleAvailable = true;
            return;
          }
          
          // 2자 미만이면 바로 에러
          if (title.length < 2) {
            titleCheck.classList.remove('hidden');
            titleLoading.classList.add('hidden');
            titleOk.classList.add('hidden');
            titleError.classList.remove('hidden');
            titleErrorMsg.textContent = '제목은 최소 2자 이상이어야 합니다';
            titleErrorMsg.classList.remove('hidden');
            isTitleAvailable = false;
            return;
          }
          
          // 로딩 표시
          titleCheck.classList.remove('hidden');
          titleLoading.classList.remove('hidden');
          titleOk.classList.add('hidden');
          titleError.classList.add('hidden');
          titleErrorMsg.classList.add('hidden');
          
          // 500ms 후 API 호출
          titleCheckTimer = setTimeout(async () => {
            try {
              let url = '/api/howto/check-title?title=' + encodeURIComponent(title);
              if (EXCLUDE_PAGE_ID) {
                url += '&excludeId=' + EXCLUDE_PAGE_ID;
              }
              const res = await fetch(url);
              const data = await res.json();
              
              titleLoading.classList.add('hidden');
              
              if (data.success && data.available) {
                titleOk.classList.remove('hidden');
                titleError.classList.add('hidden');
                titleErrorMsg.classList.add('hidden');
                isTitleAvailable = true;
              } else {
                titleOk.classList.add('hidden');
                titleError.classList.remove('hidden');
                titleErrorMsg.textContent = data.reason || '사용할 수 없는 제목입니다';
                titleErrorMsg.classList.remove('hidden');
                isTitleAvailable = false;
              }
            } catch (err) {
              titleLoading.classList.add('hidden');
              titleOk.classList.add('hidden');
              titleError.classList.remove('hidden');
              titleErrorMsg.textContent = '제목 확인 중 오류가 발생했습니다';
              titleErrorMsg.classList.remove('hidden');
              isTitleAvailable = false;
            }
          }, 500);
        });
      }
      
      // 저장 (임시 발행 상태로 저장)
      async function saveDraft() {
        clearAllFieldErrors();
        
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        const contentHtml = tiptapEditor ? tiptapEditor.getHTML() : '';
        const contentJson = tiptapEditor ? JSON.stringify(tiptapEditor.getContent()) : '{}';
        
        // 유효성 검사
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          updateSaveStatus('error');
          return;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          updateSaveStatus('error');
          return;
        }
        
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          updateSaveStatus('error');
          return;
        }
        
        // 발행된 문서를 저장하면 임시 발행 상태로 전환됨을 경고
        if (IS_PUBLISHED) {
          const confirmed = confirm('⚠️ 주의: 이미 발행된 문서입니다.\\n\\n저장하면 임시 발행 상태로 전환되어 비공개 처리됩니다.\\n(목록에서 사라지고 작성자만 볼 수 있게 됩니다)\\n\\n공개 상태를 유지하려면 "업데이트" 버튼을 사용하세요.\\n\\n계속하시겠습니까?');
          if (!confirmed) {
            return;
          }
        }
        
        updateSaveStatus('saving');
        
        // 태그 수집
        const tags = [];
        document.querySelectorAll('#tags-container span').forEach(chip => {
          const text = chip.textContent.replace('×', '').trim();
          if (text) tags.push(text);
        });
        
        // 관련 콘텐츠 수집
        const relatedJobs = getRelatedItems('jobs');
        const relatedMajors = getRelatedItems('majors');
        const relatedHowtos = getRelatedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          // 임시 발행 API 호출 (발행된 문서도 draft_published로 전환)
          const res = await fetch('/api/howto/save-publish', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              draftId: DRAFT_ID,
              title,
              summary,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              contentHtml,
              contentJson,
              thumbnailUrl: thumbnail,
              forceDraftPublished: true  // 항상 draft_published로 저장
            })
          });
          
          const data = await res.json();
          
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '임시 저장되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
          } else {
            updateSaveStatus('error');
            showMessage('error', data.error || '저장 실패');
          }
        } catch (err) {
          updateSaveStatus('error');
          showMessage('error', '네트워크 오류');
        }
      }
      
      // 발행 (draft_published → published)
      async function publishFromDraft() {
        clearAllFieldErrors();
        
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        const contentHtml = tiptapEditor ? tiptapEditor.getHTML() : '';
        const contentJson = tiptapEditor ? JSON.stringify(tiptapEditor.getContent()) : '{}';
        
        // 유효성 검사
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          return;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          return;
        }
        
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          return;
        }
        
        if (!confirm('이 가이드를 정식 발행하시겠습니까?\\n발행 후 HowTo 목록에 공개됩니다.')) {
          return;
        }
        
        updateSaveStatus('saving');
        
        // 태그 수집
        const tags = [];
        document.querySelectorAll('#tags-container span').forEach(chip => {
          const text = chip.textContent.replace('×', '').trim();
          if (text) tags.push(text);
        });
        
        // 관련 콘텐츠 수집
        const relatedJobs = getRelatedItems('jobs');
        const relatedMajors = getRelatedItems('majors');
        const relatedHowtos = getRelatedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          const res = await fetch('/api/howto/publish-direct', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              draftId: DRAFT_ID,
              title,
              summary,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              contentHtml,
              contentJson,
              thumbnailUrl: thumbnail
            })
          });
          
          const data = await res.json();
          
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '발행되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
          } else {
            updateSaveStatus('error');
            showMessage('error', data.error || '발행 실패');
          }
        } catch (err) {
          updateSaveStatus('error');
          showMessage('error', '네트워크 오류');
        }
      }
      
      // 업데이트 (published 페이지 업데이트)
      async function updatePublished() {
        clearAllFieldErrors();
        
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        const contentHtml = tiptapEditor ? tiptapEditor.getHTML() : '';
        const contentJson = tiptapEditor ? JSON.stringify(tiptapEditor.getContent()) : '{}';
        
        // 유효성 검사
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          return;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          return;
        }
        
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          return;
        }
        
        updateSaveStatus('saving');
        
        // 태그 수집
        const tags = [];
        document.querySelectorAll('#tags-container span').forEach(chip => {
          const text = chip.textContent.replace('×', '').trim();
          if (text) tags.push(text);
        });
        
        // 관련 콘텐츠 수집
        const relatedJobs = getRelatedItems('jobs');
        const relatedMajors = getRelatedItems('majors');
        const relatedHowtos = getRelatedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          const res = await fetch('/api/howto/save-publish', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              draftId: DRAFT_ID,
              title,
              summary,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              contentHtml,
              contentJson,
              thumbnailUrl: thumbnail
            })
          });
          
          const data = await res.json();
          
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '업데이트되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
          } else {
            updateSaveStatus('error');
            showMessage('error', data.error || '업데이트 실패');
          }
        } catch (err) {
          updateSaveStatus('error');
          showMessage('error', '네트워크 오류');
        }
      }
      
      // 썸네일 업로드
      let thumbnailUrl = document.getElementById('field-thumbnail')?.value || '';
      let thumbnailInitialized = false;
      
      function initThumbnail() {
        if (thumbnailInitialized) return;
        thumbnailInitialized = true;
        
        const uploadArea = document.getElementById('thumbnail-upload-area');
        const fileInput = document.getElementById('thumbnail-input');
        const placeholder = document.getElementById('thumbnail-placeholder');
        const preview = document.getElementById('thumbnail-preview');
        const thumbnailImg = document.getElementById('thumbnail-img');
        const removeBtn = document.getElementById('thumbnail-remove');
        const hiddenField = document.getElementById('field-thumbnail');
        
        if (!uploadArea || !fileInput) return;
        
        // 클릭 시 파일 선택 (이벤트 버블링 방지)
        uploadArea.addEventListener('click', (e) => {
          // fileInput 클릭이나 removeBtn 클릭은 무시
          if (e.target === fileInput || e.target.closest('#thumbnail-remove')) return;
          e.stopPropagation();
          fileInput.click();
        }, { capture: true });
        
        // 드래그 앤 드롭
        uploadArea.addEventListener('dragover', (e) => {
          e.preventDefault();
          uploadArea.classList.add('border-wiki-primary');
        });
        uploadArea.addEventListener('dragleave', () => {
          uploadArea.classList.remove('border-wiki-primary');
        });
        uploadArea.addEventListener('drop', (e) => {
          e.preventDefault();
          uploadArea.classList.remove('border-wiki-primary');
          const file = e.dataTransfer?.files?.[0];
          if (file && file.type.startsWith('image/')) {
            handleThumbnailUpload(file);
          }
        });
        
        // 파일 선택
        fileInput.addEventListener('change', (e) => {
          const file = e.target.files?.[0];
          if (file) {
            handleThumbnailUpload(file);
          }
          // 같은 파일 재선택 가능하도록 value 리셋
          e.target.value = '';
        });
        
        // 썸네일 제거
        removeBtn?.addEventListener('click', (e) => {
          e.stopPropagation();
          thumbnailUrl = '';
          hiddenField.value = '';
          placeholder.classList.remove('hidden');
          preview.classList.add('hidden');
          thumbnailImg.src = '';
          hasUnsavedChanges = true;
        });
      }
      
      async function handleThumbnailUpload(file) {
        const placeholder = document.getElementById('thumbnail-placeholder');
        const preview = document.getElementById('thumbnail-preview');
        const thumbnailImg = document.getElementById('thumbnail-img');
        const hiddenField = document.getElementById('field-thumbnail');
        
        // 파일 크기 체크 (5MB)
        if (file.size > 5 * 1024 * 1024) {
          showMessage('error', '이미지 크기는 5MB 이하여야 합니다.');
          return;
        }
        
        try {
          // 로딩 표시
          placeholder.classList.remove('hidden');
          placeholder.innerHTML = '<i class="fas fa-spinner fa-spin text-3xl text-wiki-primary"></i><p class="text-sm text-wiki-muted">업로드 중...</p>';
          
          // FormData로 업로드
          const formData = new FormData();
          formData.append('file', file);
          
          const res = await fetch('/api/upload', {
            method: 'POST',
            body: formData
          });
          
          const data = await res.json();
          
          if (data.success && data.url) {
            thumbnailUrl = data.url;
            hiddenField.value = data.url;
            thumbnailImg.src = data.url;
            placeholder.classList.add('hidden');
            preview.classList.remove('hidden');
            hasUnsavedChanges = true;
          } else {
            throw new Error(data.error || '업로드 실패');
          }
        } catch (err) {
          // 원래 상태로 복구
          placeholder.innerHTML = '<i class="fas fa-image text-3xl text-wiki-muted"></i><p class="text-sm text-wiki-muted">클릭하여 이미지 업로드 또는 드래그 앤 드롭</p><p class="text-xs text-wiki-muted/60">없으면 본문의 첫 번째 이미지가 자동으로 사용됩니다</p>';
          showMessage('error', err.message || '썸네일 업로드에 실패했습니다.');
        }
      }
      
      function getThumbnailUrl() {
        return thumbnailUrl || document.getElementById('field-thumbnail')?.value || '';
      }
      
      // 관련 아이템 수집
      function getRelatedItems(domain) {
        const items = [];
        document.querySelectorAll('#' + domain + '-container span[data-id]').forEach(chip => {
          items.push({
            id: chip.dataset.id,
            name: chip.dataset.name,
            slug: chip.dataset.slug
          });
        });
        return items;
      }
      
      // 충돌 다이얼로그 표시
      function showConflictDialog(serverVersion, localVersion) {
        const dialog = document.getElementById('conflict-dialog');
        dialog.querySelector('[data-server-version]').textContent = serverVersion;
        dialog.querySelector('[data-local-version]').textContent = localVersion;
        dialog.classList.remove('hidden');
        
        document.getElementById('conflict-reload').onclick = () => {
          location.reload();
        };
        
        document.getElementById('conflict-overwrite').onclick = async () => {
          currentVersion = serverVersion;
          dialog.classList.add('hidden');
          await saveDraft();
        };
      }
      
      // 저장 상태 업데이트
      function updateSaveStatus(status) {
        const el = document.getElementById('save-status');
        switch (status) {
          case 'saving':
            el.innerHTML = '<span class="text-amber-400">●</span> 저장 중...';
            break;
          case 'saved':
            el.innerHTML = '<span class="text-green-400">●</span> 저장됨 · ' + new Date().toLocaleTimeString('ko-KR');
            break;
          case 'error':
            el.innerHTML = '<span class="text-red-400">●</span> 저장 실패';
            break;
          default:
            el.innerHTML = '<span class="text-amber-400">●</span> 저장되지 않음';
        }
      }
      
      // 메시지 표시
      function showMessage(type, text) {
        const el = document.getElementById('editor-message');
        el.className = type === 'success'
          ? 'p-4 bg-green-500/10 border border-green-500/30 rounded-xl text-green-400'
          : 'p-4 bg-red-500/10 border border-red-500/30 rounded-xl text-red-400';
        el.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check' : 'exclamation') + '-circle mr-2"></i>' + text;
        el.classList.remove('hidden');
        setTimeout(() => el.classList.add('hidden'), 5000);
      }
      
      // 필드별 에러 표시
      function showFieldError(fieldId, msg) {
        clearFieldError(fieldId);
        const field = document.getElementById(fieldId);
        if (!field) return;
        field.dataset.error = 'true';
        field.style.borderColor = 'rgba(239, 68, 68, 0.6)';
        const errorEl = document.createElement('p');
        errorEl.className = 'field-error text-red-400 text-xs mt-1';
        errorEl.textContent = msg;
        field.parentElement.appendChild(errorEl);
      }
      
      function clearFieldError(fieldId) {
        const field = document.getElementById(fieldId);
        if (!field) return;
        delete field.dataset.error;
        field.style.borderColor = '';
        const existingError = field.parentElement.querySelector('.field-error');
        if (existingError) existingError.remove();
      }
      
      function clearAllFieldErrors() {
        document.querySelectorAll('.field-error').forEach(el => el.remove());
        document.querySelectorAll('[data-error="true"]').forEach(el => {
          delete el.dataset.error;
          el.style.borderColor = '';
        });
      }
      
      // 유효성 검사 (초성만 입력 등 체크)
      function validateTitle(title) {
        if (!title) return '제목을 입력해주세요.';
        if (title.length < 2) return '제목은 2자 이상이어야 합니다.';
        if (/^[ㄱ-ㅎ]+$/.test(title)) return '제목에 초성만 입력할 수 없습니다.';
        return null;
      }
      
      function validateContent(html) {
        if (!html || html === '<p></p>' || html === '<p><br></p>') return '본문을 입력해주세요.';
        var textOnly = html.replace(/<[^>]*>/g, '').trim();
        if (/^[ㄱ-ㅎ \\t\\n]+$/.test(textOnly)) return '본문에 초성만 입력할 수 없습니다.';
        return null;
      }
      
      // 자동완성 초기화 (pointerdown + 이벤트 위임 + focusout 방식 + IME 지원)
      function initAutocomplete() {
        ['jobs', 'majors', 'howtos'].forEach(domain => {
          const input = document.getElementById('field-' + domain);
          const dropdown = document.getElementById(domain + '-dropdown');
          const container = document.getElementById(domain + '-container');
          if (!input || !dropdown || !container) return;
          const wrap = input.parentElement;
          
          let items = [];
          try {
            items = JSON.parse(input.dataset.items || '[]');
          } catch (e) {}
          
          // 기존 아이템 렌더링
          items.forEach(item => addItemChip(container, item, domain));
          
          let debounceTimer = null;
          let composingTimer = null;
          let abortController = null;
          let lastSearchValue = '';
          
          // 검색 실행 함수
          const doSearch = async (q) => {
            if (q.length < 2) {
              dropdown.classList.add('hidden');
              dropdown.innerHTML = '';
              return;
            }
            
            // 이미 같은 값으로 검색했으면 스킵
            if (q === lastSearchValue) return;
            lastSearchValue = q;
            
            try {
              if (abortController) abortController.abort();
              abortController = new AbortController();
              
              const res = await fetch('/api/search?domain=' + domain + '&q=' + encodeURIComponent(q) + '&limit=10', {
                signal: abortController.signal
              });
              const data = await res.json();
              
              if (data.success && data.results && data.results.length > 0) {
                dropdown.innerHTML = data.results.map(r => 
                  '<div class="autocomplete-item" data-id="' + (r.id || r.slug) + '" data-name="' + escapeHtml(r.name || r.title) + '" data-slug="' + escapeHtml(r.slug || r.name) + '">' +
                  '<span class="text-white">' + escapeHtml(r.name || r.title) + '</span>' +
                  (r.snippet ? '<br><span class="text-xs text-wiki-muted">' + escapeHtml(r.snippet) + '</span>' : '') +
                  '</div>'
                ).join('');
                dropdown.classList.remove('hidden');
              } else {
                dropdown.classList.add('hidden');
                dropdown.innerHTML = '';
              }
            } catch (err) {
              if (err?.name !== 'AbortError') {
                console.error('[autocomplete] Error:', err);
              }
            }
          };
          
          // 모든 입력에 대해 1초 후 자동 검색 (한글 조합 중에도)
          input.addEventListener('input', () => {
            clearTimeout(debounceTimer);
            clearTimeout(composingTimer);
            const q = input.value.trim();
            
            // 1초 후 자동 검색 (한글 조합 중에도 동작)
            composingTimer = setTimeout(() => doSearch(q), 1000);
            
            // 영어 등 비조합 입력은 300ms 후 빠르게 검색
            debounceTimer = setTimeout(() => {
              const currentQ = input.value.trim();
              if (currentQ.length >= 2) {
                doSearch(currentQ);
              }
            }, 300);
          });
          
          // 항목 선택: pointerdown에서 처리 (blur보다 먼저 발생)
          dropdown.addEventListener('pointerdown', (e) => {
            const el = e.target.closest('.autocomplete-item');
            if (!el) return;
            e.preventDefault();
            e.stopPropagation();
            
            const item = { id: el.dataset.id, name: el.dataset.name, slug: el.dataset.slug };
            
            // 중복 체크
            const existing = container.querySelector('[data-id="' + item.id + '"]');
            if (!existing) {
              addItemChip(container, item, domain);
            }
            
            input.value = '';
            dropdown.innerHTML = '';
            dropdown.classList.add('hidden');
            input.focus();
          });
          
          // focusout으로 외부 클릭 감지
          const handleFocusOut = (evt) => {
            const next = evt.relatedTarget;
            const isInside = wrap ? wrap.contains(next) : (input === next || dropdown.contains(next));
            if (!isInside) {
              dropdown.classList.add('hidden');
            }
          };
          (wrap || input).addEventListener('focusout', handleFocusOut);
        });
      }
      
      // 아이템 칩 추가
      function addItemChip(container, item, domain) {
        // 중복 체크
        const existingChip = container.querySelector('[data-id="' + item.id + '"]');
        if (existingChip) return;
        
        const chip = document.createElement('span');
        chip.className = 'inline-flex items-center gap-1 px-2 py-1 bg-wiki-primary/10 border border-wiki-primary/30 rounded-lg text-xs text-wiki-primary';
        chip.dataset.id = item.id;
        chip.dataset.name = item.name || item.title || '';
        chip.dataset.slug = item.slug || '';
        chip.innerHTML = escapeHtml(item.name || item.title) + '<button type="button" class="hover:text-red-400 ml-1">&times;</button>';
        
        chip.querySelector('button').addEventListener('click', () => {
          chip.remove();
        });
        
        container.appendChild(chip);
      }
      
      // 태그 초기화
      function initTags() {
        const input = document.getElementById('field-tags');
        const container = document.getElementById('tags-container');
        
        let tags = [];
        try {
          tags = JSON.parse(input.dataset.tags || '[]');
        } catch (e) {}
        
        tags.forEach(tag => addTagChip(container, tag));
        
        input.addEventListener('keydown', (e) => {
          if (e.key === 'Enter' || e.key === ',') {
            e.preventDefault();
            const tag = input.value.trim().replace(/,/g, '');
            if (tag) {
              addTagChip(container, tag);
              input.value = '';
            }
          }
        });
      }
      
      // 태그 칩 추가
      function addTagChip(container, tag) {
        const chip = document.createElement('span');
        chip.className = 'inline-flex items-center gap-1 px-2 py-1 bg-wiki-card/50 border border-wiki-border/40 rounded-lg text-xs text-wiki-text';
        chip.innerHTML = escapeHtml(tag) + '<button type="button" class="hover:text-red-400 ml-1">&times;</button>';
        
        chip.querySelector('button').addEventListener('click', () => {
          chip.remove();
        });
        
        container.appendChild(chip);
      }
      
      // HTML 이스케이프
      function escapeHtml(str) {
        if (!str) return '';
        return String(str).replace(/[&<>"']/g, c => ({
          '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
        })[c]);
      }
    </script>
  `
  
  return c.html(
    renderLayoutWithContext(c,
      content,
      'HowTo 작성 - Careerwiki',
      '새 HowTo 가이드를 작성합니다',
      false,
      { extraHead: '<link rel="stylesheet" href="/static/howto-editor.css">' }
    )
  )
})

// HowTo 편집 페이지 (작성자 또는 관리자만) - draft로 복사 후 리다이렉트
app.get('/howto/:slug/edit', requireAuth, async (c) => {
  const rawSlug = c.req.param('slug')
  const user = c.get('user')
  
  // guide: prefix가 있으면 정상 slug로 리다이렉트
  const slug = cleanGuidePrefix(rawSlug)
  if (slug !== rawSlug) {
    return c.redirect(`/howto/${encodeURIComponent(slug)}/edit`, 301)
  }
  
  if (!user) {
    return c.redirect(`/login?redirect=/howto/${encodeURIComponent(slug)}/edit`)
  }
  
  // DB에서 HowTo 조회 (page_type = 'guide', published 또는 draft_published)
  const page = await c.env.DB.prepare(`
    SELECT id, slug, title, summary, content, meta_data, author_id, status 
    FROM pages 
    WHERE slug = ? AND page_type = 'guide' AND status IN ('published', 'draft_published')
  `).bind(slug).first<{ id: number; slug: string; title: string; summary: string; content: string; meta_data: string; author_id: number | null; status: string }>()
  
  // 샘플 데이터 확인 (DB에 없는 경우)
  const sample = getSampleHowtoGuide(slug)
  
  if (!page && !sample) {
    return c.redirect('/howto')
  }
  
  // 권한 확인 (작성자 또는 관리자만)
  if (page) {
    const isAuthor = page.author_id && user.id === page.author_id
    const isAdmin = user.role === 'admin'
    
    if (!isAuthor && !isAdmin) {
      const content = `
        <div class="max-w-2xl mx-auto px-4 py-16 text-center">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-red-500/10 mb-6">
            <i class="fas fa-lock text-3xl text-red-400"></i>
          </div>
          <h1 class="text-2xl font-bold text-white mb-2">편집 권한이 없습니다</h1>
          <p class="text-wiki-muted mb-6">본인이 작성한 글만 편집할 수 있습니다.</p>
          <a href="/howto/${escapeHtml(slug)}" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
            돌아가기
          </a>
        </div>
      `
      return c.html(
        renderLayoutWithContext(c, content, '편집 권한 없음 - Careerwiki', '편집 권한이 없습니다')
      )
    }
    
    // 발행된 페이지를 draft로 복사
    let metaData: any = {}
    try {
      if (page.meta_data) {
        metaData = JSON.parse(page.meta_data)
      }
    } catch {}
    
    // 이 페이지에 연결된 기존 draft가 있는지 확인
    const existingDraft = await c.env.DB.prepare(`
      SELECT id FROM howto_drafts 
      WHERE user_id = ? AND published_page_id = ?
      ORDER BY updated_at DESC
      LIMIT 1
    `).bind(user.id, page.id).first<{ id: number }>()
    
    if (existingDraft) {
      // 기존 draft가 있으면 그것으로 이동
      return c.redirect(`/howto/draft/${existingDraft.id}`)
    }
    
    // 새 draft 생성 (발행된 페이지 데이터 복사)
    const { createDraft, updateDraft } = await import('./services/draftService')
    
    // contentJson 및 contentHtml 처리
    // metaData.contentJson이 있으면 문자열로 전달, 없으면 빈 상태로 두어 contentHtml이 사용되도록 함
    let contentJson = ''
    if (metaData.contentJson && metaData.contentJson !== '{}') {
      contentJson = typeof metaData.contentJson === 'string' 
        ? metaData.contentJson 
        : JSON.stringify(metaData.contentJson)
    }
    const contentHtml = page.content || ''
    
    // 디버그 로그
    console.log('[edit] page.id:', page.id, 'slug:', slug)
    console.log('[edit] metaData keys:', Object.keys(metaData))
    console.log('[edit] contentJson length:', contentJson.length, 'contentHtml length:', contentHtml.length)
    console.log('[edit] tags:', metaData.tags?.length || 0, 'relatedJobs:', metaData.relatedJobs?.length || 0)
    
    const result = await createDraft(c.env.DB, {
      userId: user.id,
      title: page.title,
      summary: page.summary || '',
      contentJson: contentJson,
      contentHtml: contentHtml,
      thumbnailUrl: metaData.thumbnailUrl || ''
    })
    
    if (!result.success || !result.draftId) {
      // draft 생성 실패 시 에러 페이지
      const content = `
        <div class="max-w-2xl mx-auto px-4 py-16 text-center">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-red-500/10 mb-6">
            <i class="fas fa-exclamation-triangle text-3xl text-red-400"></i>
          </div>
          <h1 class="text-2xl font-bold text-white mb-2">편집 모드로 전환할 수 없습니다</h1>
          <p class="text-wiki-muted mb-6">초안 생성에 실패했습니다. 잠시 후 다시 시도해주세요.</p>
          <a href="/howto/${escapeHtml(slug)}" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
            돌아가기
          </a>
        </div>
      `
      return c.html(renderLayoutWithContext(c, content, '편집 실패 - Careerwiki', ''))
    }
    
    // draft에 원본 페이지 ID 기록
    await c.env.DB.prepare(`
      UPDATE howto_drafts SET published_page_id = ? WHERE id = ?
    `).bind(page.id, result.draftId).run()
    
    // 관련 항목들 저장 (직접 DB에 삽입)
    const draftId = result.draftId
    
    // 태그 저장
    const tags = metaData.tags || []
    for (const tagName of tags) {
      if (!tagName || !tagName.trim()) continue
      const trimmed = tagName.trim()
      
      // 태그 조회 또는 생성
      let tag = await c.env.DB.prepare(`SELECT id FROM tags WHERE name = ?`).bind(trimmed).first<{ id: number }>()
      if (!tag) {
        const tagSlug = trimmed.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9가-힣-]/g, '')
        const tagResult = await c.env.DB.prepare(`INSERT INTO tags (name, slug) VALUES (?, ?)`).bind(trimmed, tagSlug).run()
        tag = { id: Number(tagResult.meta.last_row_id) }
      }
      await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_tags (draft_id, tag_id) VALUES (?, ?)`).bind(draftId, tag.id).run()
    }
    
    // 관련 직업 저장
    const relatedJobs = metaData.relatedJobs || []
    for (let i = 0; i < relatedJobs.length; i++) {
      const job = relatedJobs[i]
      const jobId = job.id || job.slug || job.name
      if (jobId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_jobs (draft_id, job_id, display_order) VALUES (?, ?, ?)`).bind(draftId, jobId, i).run()
      }
    }
    
    // 관련 전공 저장
    const relatedMajors = metaData.relatedMajors || []
    for (let i = 0; i < relatedMajors.length; i++) {
      const major = relatedMajors[i]
      const majorId = major.id || major.slug || major.name
      if (majorId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_majors (draft_id, major_id, display_order) VALUES (?, ?, ?)`).bind(draftId, majorId, i).run()
      }
    }
    
    // 관련 HowTo 저장
    const relatedHowtos = metaData.relatedHowtos || []
    for (let i = 0; i < relatedHowtos.length; i++) {
      const howto = relatedHowtos[i]
      const howtoId = howto.id || howto.slug || howto.name
      if (howtoId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_howtos (draft_id, howto_id, display_order) VALUES (?, ?, ?)`).bind(draftId, howtoId, i).run()
      }
    }
    
    return c.redirect(`/howto/draft/${draftId}`)
  }
  
  // 샘플 데이터 편집 (불가)
  const content = `
    <div class="max-w-2xl mx-auto px-4 py-16 text-center">
      <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-amber-500/10 mb-6">
        <i class="fas fa-info-circle text-3xl text-amber-400"></i>
      </div>
      <h1 class="text-2xl font-bold text-white mb-2">샘플 콘텐츠입니다</h1>
      <p class="text-wiki-muted mb-6">샘플 콘텐츠는 편집할 수 없습니다.</p>
      <a href="/howto/${escapeHtml(slug)}" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
        돌아가기
      </a>
    </div>
  `
  return c.html(renderLayoutWithContext(c, content, '편집 불가 - Careerwiki', ''))
})

// HowTo 삭제 API (작성자 또는 관리자만)



app.get('/howto/:slug', async (c) => {
  const rawSlug = c.req.param('slug')
  
  // guide: prefix가 있으면 정상 slug로 리다이렉트 (301 Permanent Redirect)
  const cleanedSlug = cleanGuidePrefix(rawSlug)
  if (cleanedSlug !== rawSlug) {
    return c.redirect(`/howto/${encodeURIComponent(cleanedSlug)}`, 301)
  }
  
  const slug = cleanedSlug
  
  // 먼저 DB에서 HowTo 검색 (page_type = 'guide', published 또는 draft_published)
  // 작성자 프로필 이미지도 함께 조회
  const dbResult = await c.env.DB.prepare(`
    SELECT p.id, p.slug, p.title, p.summary, p.content, p.meta_data, p.author_id, p.status, p.view_count, p.created_at, p.updated_at,
           u.picture_url AS author_picture_url, u.custom_picture_url AS author_custom_picture_url
    FROM pages p
    LEFT JOIN users u ON u.id = p.author_id
    WHERE p.page_type = 'guide' AND p.slug = ? AND p.status IN ('published', 'draft_published')
    LIMIT 1
  `).bind(slug).first()
  
  if (dbResult) {
    const status = dbResult.status as string
    const pageId = dbResult.id as number
    const user = getOptionalUser(c)
    const isAuthor = user && String(user.id) === String(dbResult.author_id)
    const isAdmin = user && (user.role === 'super-admin' || user.role === 'operator')
    
    // draft_published 상태는 작성자 또는 관리자만 접근 가능
    if (status === 'draft_published' && !isAuthor && !isAdmin) {
      // 404 처리 - 간단한 인라인 404 메시지
      const notFoundContent = `
        <div class="flex flex-col items-center justify-center min-h-[50vh] text-center px-4">
          <div class="w-20 h-20 mb-6 rounded-full bg-wiki-card flex items-center justify-center">
            <i class="fas fa-file-alt text-3xl text-wiki-muted"></i>
          </div>
          <h1 class="text-2xl font-bold text-white mb-2">찾을 수 없는 가이드입니다</h1>
          <p class="text-wiki-muted mb-6">요청하신 페이지를 찾을 수 없습니다.</p>
          <a href="/howto" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
            HowTo 목록으로
          </a>
        </div>
      `
      return c.html(renderLayoutWithContext(c, notFoundContent, '페이지를 찾을 수 없습니다 - Careerwiki', ''), 404)
    }
    
    // 조회수 증가 (비동기, 에러 무시)
    c.env.DB.prepare(`UPDATE pages SET view_count = view_count + 1 WHERE id = ?`).bind(pageId).run().catch(() => {})
    
    // 북마크 수 조회 (user_bookmarks 테이블 사용)
    const bookmarkResult = await c.env.DB.prepare(`
      SELECT COUNT(*) as count FROM user_bookmarks WHERE item_type = 'howto' AND item_slug = ?
    `).bind(slug).first<{ count: number }>()
    const bookmarkCount = bookmarkResult?.count || 0
    
    // DB에서 찾은 경우 - 변환 함수를 사용하여 HowtoGuideDetail로 변환
    const { dbRowToHowtoGuideDetail } = await import('./utils/howtoConverter')
    
    const guideDetail = dbRowToHowtoGuideDetail({
      id: dbResult.id as number,
      slug: dbResult.slug as string,
      title: dbResult.title as string,
      summary: dbResult.summary as string | null,
      content: dbResult.content as string | null,
      meta_data: dbResult.meta_data as string | null,
      author_id: dbResult.author_id as number | null,
      author_picture_url: dbResult.author_picture_url as string | null,
      author_custom_picture_url: dbResult.author_custom_picture_url as string | null,
      status: dbResult.status as string,
      created_at: dbResult.created_at as string,
      updated_at: dbResult.updated_at as string,
      view_count: (dbResult.view_count as number || 0) + 1, // 현재 조회 포함
      bookmark_count: bookmarkCount
    })
    
    // renderHowtoGuideDetail 템플릿 사용
    const { renderHowtoGuideDetail } = await import('./templates/howtoDetail')
    
    // CSS 링크 추가
    const cssLink = '<link rel="stylesheet" href="/static/howto-editor.css">'
    
    const content = cssLink + renderHowtoGuideDetail(guideDetail, {
      currentUserId: user?.id ? parseInt(user.id) : null,
      currentUserRole: user?.role || null,
      authorId: dbResult.author_id as number | null,
      pageId: dbResult.id as number,
      isBlinded: false,
      blindReason: null,
      isDraftPublished: status === 'draft_published'
    })
    
    return c.html(
      renderLayoutWithContext(c, content, `${dbResult.title} - Careerwiki`, dbResult.summary as string || '')
    )
  }
  
  // DB에 없으면 샘플 데이터에서 검색 (기존 템플릿 사용)
  const sample = getSampleHowtoGuide(slug)
  if (sample) {
    return renderSampleHowtoDetailPage(c, sample)
  }

  // 둘 다 없으면 404
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-route',
      title: 'HowTo 정보를 찾을 수 없습니다',
      description: '요청하신 HowTo 가이드가 아직 등록되지 않았습니다.',
      ctaHref: '/howto',
      ctaLabel: 'HowTo 목록으로 돌아가기'
    })
    c.status(404)
    return c.html(
      renderLayoutWithContext(c,
        fallbackHtml,
        'HowTo 정보 없음 - Careerwiki',
        '요청한 HowTo 가이드를 찾을 수 없습니다.'
      )
    )
})


// Search Page - 실제 D1 데이터 검색
app.get('/search', async (c) => {
  const query = c.req.query('q') || ''
  const keyword = query.trim()
  
  const renderKeywordBadges = (keywords: string[]): string => {
    if (!keywords || !keywords.length) {
      return ''
    }
    return `<div class="flex flex-wrap gap-2 mt-3">${keywords.slice(0, 3)
      .map((keyword) => `<span class="px-3 py-1.5 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted">${escapeHtml(keyword)}</span>`)
      .join('')}</div>`
  }

  const queryValueAttr = escapeHtml(keyword)
  const escapedQuery = escapeHtml(keyword)

  // 실제 D1 데이터 검색
  let jobCardsHtml = ''
  let majorCardsHtml = ''
  let howtoResults: Array<{ href: string; title: string; summary?: string; thumbnailUrl?: string; tags?: string[] }> = []

  // 요약 텍스트 포맷팅 함수
  const formatSummaryText = (value?: string | null, type: 'job' | 'major' = 'job'): string => {
    const fallback = type === 'job' 
      ? '고용24와 커리어넷 데이터를 통합하여 제공하는 직업 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
      : '고용24와 커리어넷 데이터를 통합하여 제공하는 전공 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
    if (!value) return fallback
    const normalized = value.replace(/\s+/g, ' ').trim()
    if (!normalized) return fallback
    return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
  }

  if (keyword && c.env?.DB) {
    try {
      // 직업 검색
      console.log('[/search] 직업 검색 시작:', keyword)
      const jobSearchResult = await searchUnifiedJobs(
        { keyword, page: 1, perPage: 5 },
        c.env
      )
      console.log('[/search] 직업 검색 결과:', jobSearchResult.items.length, '개')
      
      jobCardsHtml = jobSearchResult.items
        .slice(0, 5)
        .map((entry) => renderJobCard(entry))
        .join('')

      // 전공 검색
      const majorSearchResult = await searchUnifiedMajors(
        { keyword, page: 1, perPage: 5 },
        c.env
      )
      
      majorCardsHtml = majorSearchResult.items
        .slice(0, 5)
        .map((entry) => renderMajorCard(entry))
        .join('')
    } catch (error) {
      console.error('검색 오류:', error)
    }
  }

  // HowTo 검색 - D1 pages 테이블에서만 검색
  // 🔍 HowTo 키워드 토큰화 함수
  const tokenizeHowtoKeyword = (kw: string): string[] => {
    const tokens: string[] = []
    const normalizedKw = kw.toLowerCase().replace(/\s+/g, '')
    
    // 1. 취업/커리어 관련 키워드 추출
    const careerKeywords = ['취업', '면접', '자소서', '자기소개서', '이력서', '포트폴리오', '자격증', '스펙', '준비', '방법', '팁', '가이드', '합격', '불합격', '서류', '채용', '지원', '경력', '신입', '인턴', '공채', '수시', '연봉', '협상', '퇴사', '이직', '전직', '직무', '직업', '진로', '커리어']
    for (const ck of careerKeywords) {
      if (normalizedKw.includes(ck) && normalizedKw !== ck) {
        tokens.push(ck)
      }
    }
    
    // 2. 직무/분야 키워드 추출
    const fieldKeywords = ['개발자', '디자이너', '기획자', '마케터', '영업', '인사', '회계', '재무', '법무', '공무원', '대기업', '중소기업', '스타트업', 'it', '금융', '의료', '교육', '건설', '제조', '서비스']
    for (const fk of fieldKeywords) {
      if (normalizedKw.includes(fk) && normalizedKw !== fk) {
        tokens.push(fk)
      }
    }
    
    // 중복 제거, 원본 키워드 제외
    return [...new Set(tokens)].filter(t => t !== normalizedKw && t.length >= 2)
  }
  
  if (keyword && c.env?.DB) {
    try {
      const db = c.env.DB as any
      const howtoTokens = tokenizeHowtoKeyword(keyword)
      
      // 토큰 검색 조건 생성
      let tokenConditions = ''
      const tokenBindings: string[] = []
      if (howtoTokens.length > 0) {
        const tokenClauses = howtoTokens.map(() => `title LIKE ?`).join(' OR ')
        tokenConditions = ` OR (${tokenClauses})`
        for (const token of howtoTokens) {
          tokenBindings.push(`%${token}%`)
        }
      }
      
      // 우선순위 기반 정렬 쿼리 (guide: prefix가 붙은 corrupted slug 제외)
      const howtoQuery = `
        SELECT id, slug, title, summary,
          COALESCE(json_extract(meta_data, '$.thumbnailUrl'), '') as thumbnail_url,
          COALESCE(json_extract(meta_data, '$.tags'), '[]') as tags_json,
          CASE 
            WHEN LOWER(title) = LOWER(?) THEN 0
            WHEN LOWER(title) LIKE LOWER(?) THEN 1
            WHEN LOWER(title) LIKE LOWER(?) THEN 2
            ELSE 3
          END as priority
        FROM pages
        WHERE page_type = 'guide'
          AND status = 'published'
          AND slug NOT LIKE 'guide:%'
          AND (title LIKE ? OR summary LIKE ?${tokenConditions})
        ORDER BY priority, updated_at DESC
        LIMIT 5
      `
      
      const howtoResult = await db.prepare(howtoQuery).bind(
        keyword,                    // 완전 일치
        `${keyword}%`,              // 시작 일치
        `%${keyword}%`,             // 부분 일치
        `%${keyword}%`,             // WHERE title
        `%${keyword}%`,             // WHERE summary
        ...tokenBindings            // 토큰 검색
      ).all()
      
      howtoResults = (howtoResult.results || []).map((row: any) => {
        let tags: string[] = []
        try {
          tags = JSON.parse(row.tags_json || '[]')
        } catch { tags = [] }
        
        // slug에서 guide: prefix 제거
        const cleanSlug = cleanGuidePrefix(row.slug || '')
        
        return {
          href: `/howto/${encodeURIComponent(cleanSlug)}`,
          title: row.title,
          summary: row.summary || '',
          thumbnailUrl: row.thumbnail_url || '',
          tags: Array.isArray(tags) ? tags : []
        }
      })
    } catch (error) {
      console.error('HowTo 검색 오류:', error)
      howtoResults = []
    }
  } else if (c.env?.DB) {
    // 검색어 없을 때 최신 HowTo 표시
    try {
      const db = c.env.DB as any
      const defaultQuery = `
        SELECT id, slug, title, summary,
          COALESCE(json_extract(meta_data, '$.thumbnailUrl'), '') as thumbnail_url,
          COALESCE(json_extract(meta_data, '$.tags'), '[]') as tags_json
        FROM pages
        WHERE page_type = 'guide' AND status = 'published' AND slug NOT LIKE 'guide:%'
        ORDER BY updated_at DESC
        LIMIT 3
      `
      const defaultResult = await db.prepare(defaultQuery).all()
      
      howtoResults = (defaultResult.results || []).map((row: any) => {
        let tags: string[] = []
        try {
          tags = JSON.parse(row.tags_json || '[]')
        } catch { tags = [] }
        
        return {
          href: `/howto/${encodeURIComponent(row.slug)}`,
          title: row.title,
          summary: row.summary || '',
          thumbnailUrl: row.thumbnail_url || '',
          tags: Array.isArray(tags) ? tags : []
        }
      })
    } catch (error) {
      console.error('HowTo 기본 조회 오류:', error)
      howtoResults = []
    }
  }

  const content = `
    <div class="max-w-[1400px] mx-auto px-[2px] md:px-6 pt-4 md:pt-8 md:mt-8">
        <div class="mb-8">
            <form action="/search" method="get" class="relative">
                <input 
                    type="text" 
                    name="q" 
                    value="${queryValueAttr}"
                    placeholder="검색어를 입력하세요" 
                    class="w-full px-6 py-4 bg-wiki-bg border border-wiki-border rounded-full text-base md:text-lg focus:outline-none focus:border-wiki-primary transition"
                    style="font-size: 16px;"
                >
                <button type="submit" class="absolute right-2 top-1/2 -translate-y-1/2 px-5 py-3 min-h-[44px] bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white rounded-full hover:scale-105 transition text-sm md:text-base font-medium">
                    <i class="fas fa-search mr-1.5"></i>검색
                </button>
            </form>
        </div>

        ${jobCardsHtml ? `
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-primary mr-3"></span>
                직업위키
            </h2>
            <div class="space-y-4">
                ${jobCardsHtml}
                ${jobCardsHtml.split('</article>').length - 1 >= 5 ? `
                <a href="/job?q=${encodeURIComponent(keyword)}" class="block glass-card py-4 px-6 rounded-xl hover-glow transition text-center min-h-[48px] flex items-center justify-center">
                    <span class="text-sm font-medium text-wiki-text">직업 결과 더보기</span>
                </a>
                ` : ''}
            </div>
        </div>
        ` : ''}

        ${majorCardsHtml ? `
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-secondary mr-3"></span>
                전공위키
            </h2>
            <div class="space-y-4">
                ${majorCardsHtml}
                ${majorCardsHtml.split('</article>').length - 1 >= 5 ? `
                <a href="/major?q=${encodeURIComponent(keyword)}" class="block glass-card py-4 px-6 rounded-xl hover-glow transition text-center min-h-[48px] flex items-center justify-center">
                    <span class="text-sm font-medium text-wiki-text">전공 결과 더보기</span>
                </a>
                ` : ''}
            </div>
        </div>
        ` : ''}

        ${howtoResults.length > 0 ? `
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-amber-500 mr-3"></span>
                HowTo 가이드
            </h2>
            <div class="space-y-4">
                ${howtoResults.map(howto => `
                    <article class="group relative">
                      <a href="${howto.href}" class="block">
                        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-5 transition-all duration-500 ease-out hover:border-amber-500/40 hover:shadow-xl hover:shadow-amber-500/5 hover:-translate-y-1">
                          <div class="flex gap-4">
                            <!-- 왼쪽: 텍스트 콘텐츠 -->
                            <div class="flex-1 min-w-0 space-y-2">
                              <div class="flex items-center gap-2">
                                <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-md text-[10px] font-semibold uppercase tracking-wider bg-amber-500/10 text-amber-400/80 border border-amber-500/20">
                                  <i class="fas fa-book-open text-[8px]"></i>
                                  HowTo
                                </span>
                              </div>
                              <h3 class="text-lg sm:text-xl font-bold text-white group-hover:text-amber-400 transition-colors line-clamp-2">${escapeHtml(howto.title)}</h3>
                              <p class="text-[13px] sm:text-[14px] leading-relaxed text-wiki-muted/90 line-clamp-2">${escapeHtml(howto.summary || '가이드 요약이 없습니다.')}</p>
                              ${howto.tags && howto.tags.length > 0 ? `
                                <div class="flex flex-wrap gap-1.5 pt-1">
                                  ${howto.tags.slice(0, 4).map((tag: string) => `
                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-amber-500/10 border border-amber-500/20 text-amber-300/80 text-xs font-medium">
                                      <i class="fas fa-tag text-[8px]"></i>
                                      ${escapeHtml(tag)}
                                    </span>
                                  `).join('')}
                                </div>
                              ` : ''}
                            </div>
                            <!-- 오른쪽: 썸네일 -->
                            ${howto.thumbnailUrl ? `
                              <div class="flex items-center justify-center flex-shrink-0">
                                <div class="w-[74px] h-[74px] sm:w-28 sm:h-28 rounded-xl overflow-hidden border border-wiki-border/30 bg-wiki-bg/50">
                                  <img 
                                    src="${escapeHtml(howto.thumbnailUrl)}" 
                                    alt="${escapeHtml(howto.title)}"
                                    class="w-full h-full object-cover"
                                    loading="lazy"
                                    onerror="this.parentElement.innerHTML='<div class=\\'w-full h-full flex items-center justify-center bg-wiki-card/50\\'><i class=\\'fas fa-book-open text-xl sm:text-2xl text-amber-400/40\\'></i></div>'"
                                  >
                                </div>
                              </div>
                            ` : `
                              <div class="flex items-center justify-center flex-shrink-0">
                                <div class="w-[74px] h-[74px] sm:w-28 sm:h-28 rounded-xl overflow-hidden border border-wiki-border/30 bg-wiki-card/50 flex items-center justify-center">
                                  <i class="fas fa-book-open text-xl sm:text-3xl text-amber-400/30"></i>
                                </div>
                              </div>
                            `}
                          </div>
                        </div>
                      </a>
                    </article>
                `).join('')}
                ${howtoResults.length >= 3 ? `
                <a href="/howto${keyword ? `?q=${encodeURIComponent(keyword)}` : ''}" class="block glass-card py-4 px-6 rounded-xl hover-glow transition text-center min-h-[48px] flex items-center justify-center">
                    <span class="text-sm font-medium text-wiki-text">HowTo 가이드 더보기</span>
                </a>
                ` : ''}
            </div>
        </div>
        ` : ''}

        ${keyword && !jobCardsHtml && !majorCardsHtml && howtoResults.length === 0 ? `
        <div class="glass-card p-8 rounded-xl text-center">
            <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">"${escapedQuery}"에 대한 검색 결과가 없습니다.</p>
            <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도해보세요.</p>
        </div>
        ` : ''}
    </div>
  `

  const title = keyword ? `${keyword} - Careerwiki 검색` : '검색 - Careerwiki'
  const description = keyword
    ? createMetaDescription(`"${keyword}"와 관련된 Careerwiki 직업, 전공 정보를 확인하세요.`)
    : 'Careerwiki에서 직업, 전공, HowTo 정보를 검색해보세요.'

  return c.html(renderLayoutWithContext(c, content, escapeHtml(title), escapeHtml(description)))
})

// Unified Job Detail Page (ISR)
app.get('/job/:slug', async (c) => {
  const mark = c.get('mark') as ((k: string) => void) | undefined
  mark?.('route-start')
  const rawSlug = c.req.param('slug')
  const normalizedSlug = decodeURIComponent(rawSlug).normalize('NFC')
  const slug = normalizedSlug
  let resolvedId = resolveDetailIdFromSlug('job', slug)
  
  // 🆕 If resolvedId doesn't contain ':', try to find by name in D1
  if (!resolvedId.includes(':') && c.env.DB) {
    try {
      const db = c.env.DB
      // Decode URL-encoded slug back to Korean
      const decodedSlug = normalizedSlug
      
      // 관리자 여부 확인 (숨겨진 직업 접근 허용)
      const user = c.get('user')
      const role = user?.role as string | undefined
      const isAdmin = user && (role === 'super-admin' || role === 'operator' || role === 'admin')
      const activeCondition = isAdmin ? '' : 'AND is_active = 1'
      
      // 1. 먼저 slug 필드로 직접 조회 (가장 정확)
      let result = await db.prepare(
        `SELECT id, name, is_active FROM jobs WHERE slug = ? ${activeCondition} LIMIT 1`
      ).bind(decodedSlug).first() as { id: string; name: string; is_active: number } | null
      
      // 2. slug로 못 찾으면 정규화된 slug로 검색 (하이픈 제거)
      if (!result) {
        const normalizedSlug = decodedSlug.toLowerCase().replace(/-/g, '')
        
        result = await db.prepare(
          `SELECT id, name, is_active FROM jobs WHERE LOWER(REPLACE(slug, "-", "")) = ? ${activeCondition} LIMIT 1`
        ).bind(normalizedSlug).first() as { id: string; name: string; is_active: number } | null
      }
      
      // 3. 여전히 못 찾으면 이름으로 검색
      if (!result) {
        const normalized = decodedSlug.toLowerCase().replace(/-/g, '')
        
        result = await db.prepare(
          `SELECT id, name, is_active FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? ${activeCondition} LIMIT 1`
        ).bind(normalized).first() as { id: string; name: string; is_active: number } | null
      }
      
      if (result?.id) {
        resolvedId = result.id as string
      } else {
        // Only show "NO MATCH FOUND" if actually no match
        
        // Try to find similar names for debugging
        const firstWord = decodedSlug.split('-')[0]
        if (firstWord && firstWord.length > 1) {
          const similarJobs = await db.prepare(
            'SELECT id, name FROM jobs WHERE name LIKE ? LIMIT 5'
          ).bind(`${firstWord}%`).all() as { results: Array<{ id: string; name: string }> }
          
          if (similarJobs.results?.length > 0) {
            similarJobs.results.forEach((job, idx) => {
              console.log(`  ${idx + 1}. "${job.name}" (${job.id})`)
            })
          }
        }
      }
    } catch (error) {
      console.error('D1 이름 검색 오류:', error)
    }
  }
  
  // Check for debug mode first (bypass ISR cache for debugging)
  // 병합 설계 시스템: 이름이 완전히 같은 직업만 동일 엔티티로 간주
  const debugMode = c.req.query('debug') === 'true'
  if (debugMode) {
    try {
      // 1. 데이터베이스에서 job_sources 가져오기 (이름으로 검색)
      const db = c.env.DB as D1Database
      if (!db) {
        throw new Error('DB not available')
      }

      // resolvedId를 직업명으로 사용 (slug에서 변환된 이름)
      const jobName = resolvedId

      // 통합 job 엔티티에서 job_id 찾기
      const jobRow = await db.prepare(`
        SELECT id, name FROM jobs WHERE id = ? OR name = ? LIMIT 1
      `).bind(jobName, jobName).first<{ id: string; name: string }>()

      if (!jobRow) {
        // 직업을 못 찾으면 검색 페이지로 리다이렉트
        const searchQuery = decodeURIComponent(slug).replace(/-/g, ' ')
        return c.redirect(`/search?q=${encodeURIComponent(searchQuery)}`)
      }

      // 2. 해당 job_id의 모든 소스 가져오기
      let sources = await db.prepare(`
        SELECT * FROM job_sources WHERE job_id = ?
      `).bind(jobRow.id).all<JobSourceRow>()
      
      // job_id가 null인 경우 이름으로 직접 매칭
      if (!sources.results || sources.results.length === 0) {
        console.log('job_id로 찾기 실패, 이름으로 매칭 시도:', jobRow.name)
        
        // normalized와 raw 둘 다 검색
        const normalizedSources = await db.prepare(`
          SELECT * FROM job_sources 
          WHERE JSON_EXTRACT(normalized_payload, '$.name') = ?
        `).bind(jobRow.name).all<JobSourceRow>()
        
        const rawSources = await db.prepare(`
          SELECT * FROM job_sources 
          WHERE JSON_EXTRACT(raw_payload, '$.dJobNm') = ?
          OR raw_payload LIKE ?
        `).bind(jobRow.name, `%"dJobNm":"${jobRow.name}"%`).all<JobSourceRow>()
        
        // 두 결과 합치기 (중복 제거)
        const allResults = [...(normalizedSources.results || []), ...(rawSources.results || [])]
        const uniqueResults = Array.from(new Map(allResults.map(item => [item.source_key, item])).values())
        
        sources = { results: uniqueResults, success: true, meta: normalizedSources.meta }
        console.log(`매칭된 소스: ${uniqueResults.length}개`)
      }

      if (!sources.results || sources.results.length === 0) {
        const fallbackHtml = renderDetailFallback({
          icon: 'fa-database',
          title: '소스 데이터가 없습니다',
          description: '이 직업에 대한 원본 데이터를 찾을 수 없습니다.',
          ctaHref: '/jobs',
          ctaLabel: '직업 목록으로'
        })
        c.status(404)
        return c.html(renderLayoutWithContext(c, fallbackHtml, '소스 데이터 없음 - Careerwiki'))
      }

      // 3. 템플릿 디자인 페이지 렌더링
      const debugContent = renderJobTemplateDesignPage(jobRow.name, sources.results)
      
      return c.html(debugContent)
    } catch (error) {
      console.error('Debug mode error:', error)
      c.status(500)
      return c.html(renderLayoutWithContext(c, renderDetailFallback({
        icon: 'fa-circle-exclamation',
        iconColor: 'text-red-500',
        title: '디버그 데이터 로드 실패',
        description: '일시적인 오류가 발생했습니다.',
        ctaHref: '/job',
        ctaLabel: '직업위키로 돌아가기'
      }), '오류 - Careerwiki'))
    }
  }
  
  // 🆕 ISR (Incremental Static Regeneration) with wiki_pages cache
  return getOrGeneratePage(
    slug,
    'job',
    {
      // Step 1: Fetch data
      fetchData: async (slug, env) => {
        mark?.('fetch-start')
        let careernetId = c.req.query('careernetId') || undefined
        let goyongJobId = c.req.query('goyongJobId') || undefined
        const includeSources = parseSourcesQuery(c.req.query('sources')) || ['CAREERNET', 'GOYONG24']
        
        // 🆕 Redirect to clean URL if query parameters are present
        if (careernetId || goyongJobId) {
          const cleanUrl = `/job/${encodeURIComponent(slug)}`
          // Note: Redirect is handled by returning early, but we'll let ISR handle it
        }
        
        const findSampleJobDetail = () => {
          const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
          for (const candidate of candidates) {
            const sample = getSampleJobDetail(candidate)
            if (sample) return sample
          }
          return null
        }
        
        // ⚠️ ISR에서는 sample data의 sourceIds를 사용하지 않음
        // → D1 병합 로직이 자동으로 실행되도록 함
        // (쿼리 파라미터는 이미 위에서 undefined로 설정됨)
        
        const result = await getUnifiedJobDetailWithRawData(
          {
            id: resolvedId,
            careernetId: undefined,  // ⚠️ 명시적으로 undefined (D1 병합 활성화)
            goyong24JobId: undefined,  // ⚠️ 명시적으로 undefined (D1 병합 활성화)
            includeSources
          },
          env
        )
        mark?.('db-fetch')
        
        if (!result.profile) {
          // Try sample data fallback
          const sample = findSampleJobDetail()
          if (sample) {
            throw new Error('SAMPLE_FALLBACK') // Signal to use sample rendering
          }
          
          throw new Error('PROFILE_NOT_FOUND')
        }
        
        // 관련 직업 중 DB에 존재하는 직업 매핑 조회
        let existingJobSlugs = new Map<string, string>()
        const sidebarJobs = result.profile.sidebarJobs
        if (sidebarJobs?.length && env?.DB) {
          try {
            // 관련 직업 이름 추출
            const jobNames = sidebarJobs
              .map((job: any) => job?.name?.trim() || job?.jobNm?.trim() || (typeof job === 'string' ? job.trim() : ''))
              .filter((name: string) => name)
              .slice(0, 20) // 최대 20개만 조회
            
            if (jobNames.length > 0) {
              const placeholders = jobNames.map(() => '?').join(',')
              const query = `SELECT name, slug FROM jobs WHERE name IN (${placeholders})`
              const { results } = await env.DB.prepare(query).bind(...jobNames).all() as { results: Array<{ name: string; slug: string }> | null }
              if (results) {
                for (const row of results) {
                  existingJobSlugs.set(row.name.toLowerCase(), row.slug)
                }
              }
            }
          } catch (e) {
            console.error('[Job ISR fetchData] Failed to query existing jobs:', e)
          }
        }
        
        return {
          ...result,
          existingJobSlugs
        }
      },
      
      // Step 2: Render HTML
      renderHTML: (result) => {
        mark?.('render-start')
        const profile = result.profile!  // Non-null assertion (we already checked in fetchData)
        const canonicalSlug = composeDetailSlug('job', profile.name, profile.id ?? resolvedId)
        const canonicalPath = `/job/${encodeURIComponent(canonicalSlug)}`
        const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
        const title = `${profile.name} 직업 정보 - Careerwiki`
        const description = createMetaDescription(
          profile.summary,
          profile.duties,
          profile.prospect,
          profile.salary
        )
        const extraHead = [
          '<meta property="og:type" content="article">',
          '<meta property="article:modified_time" content="' + new Date().toISOString() + '">',
          createJobJsonLd(profile, canonicalUrl)
        ].filter(Boolean).join('\n')
        
        const content = renderUnifiedJobDetail({
          profile,
          partials: result.partials,
          sources: result.sources,
          rawApiData: result.rawApiData,
          existingJobSlugs: result.existingJobSlugs
        })
        mark?.('render-done')
        
        return renderLayoutWithContext(c,
          content,
          escapeHtml(title),
          escapeHtml(description),
          false,
          {
            canonical: canonicalUrl,
            ogUrl: canonicalUrl,
            extraHead
          }
        )
      },
      
      // Step 3: Extract metadata
      extractMetadata: (result) => {
        const profile = result.profile!  // Non-null assertion (we already checked in fetchData)
        return {
          title: `${profile.name} 직업 정보 - Careerwiki`,
          description: createMetaDescription(
            profile.summary,
            profile.duties,
            profile.prospect,
            profile.salary
          ),
          og_image_url: undefined // Add later if needed
        }
      }
    },
    c
  ).catch((error) => {
    // Error handling
    console.error('Job detail route error:', error)
    
    // Try sample fallback
    if (error.message === 'SAMPLE_FALLBACK') {
      const findSampleJobDetail = () => {
        const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
        for (const candidate of candidates) {
          const sample = getSampleJobDetail(candidate)
          if (sample) return sample
        }
        return null
      }
      
      const sample = findSampleJobDetail()
      if (sample) {
        console.warn('Job detail fallback: serving synthetic sample for', slug)
        return renderSampleJobDetailPage(c, sample)
      }
    }
    
    // 404 for missing profiles -> 검색 페이지로 리다이렉트
    if (error.message === 'PROFILE_NOT_FOUND') {
      const searchQuery = decodeURIComponent(slug).replace(/-/g, ' ')
      return c.redirect(`/search?q=${encodeURIComponent(searchQuery)}`)
    }
    
    // 500 for other errors
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-exclamation-circle',
      iconColor: 'text-red-500',
      title: '직업 정보를 불러오지 못했습니다',
      description: '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ctaHref: '/job',
      ctaLabel: '직업위키로 돌아가기'
    })
    c.status(500)
    return c.html(
      renderLayoutWithContext(c,
        fallbackHtml,
        '직업 정보 로드 오류 - Careerwiki',
        '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
      )
    )
  })
})

// Unified Major Detail Page (SSR)
app.get('/major/:slug', async (c) => {
  const mark = c.get('mark') as ((k: string) => void) | undefined
  mark?.('route-start')
  const rawSlug = c.req.param('slug')
  const normalizedSlug = decodeURIComponent(rawSlug).normalize('NFC')
  const slug = normalizedSlug
  let resolvedId = resolveDetailIdFromSlug('major', slug)
  
  // 🆕 If resolvedId doesn't contain ':', try to find by name in D1 (직업 페이지와 동일)
  if (!resolvedId.includes(':') && c.env.DB) {
    try {
      const db = c.env.DB
      // Decode URL-encoded slug back to Korean
      const decodedSlug = decodeURIComponent(slug)
      
      // 관리자 여부 확인 (숨겨진 전공 접근 허용)
      const user = c.get('user')
      const role = user?.role as string | undefined
      const isAdmin = user && (role === 'super-admin' || role === 'operator' || role === 'admin')
      const activeCondition = isAdmin ? '' : 'AND is_active = 1'
      
      // slug도 DB 쿼리와 동일한 정규화 적용 (하이픈, 괄호, 특수문자 제거)
      const normalized = decodedSlug.toLowerCase()
        .replace(/-/g, '')
        .replace(/,/g, '')
        .replace(/·/g, '')
        .replace(/ㆍ/g, '')
        .replace(/\//g, '')
        .replace(/\s/g, '')
        .replace(/\(/g, '')
        .replace(/\)/g, '')
      
      const result = await db.prepare(
        `SELECT id, name, is_active FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? ${activeCondition} LIMIT 1`
      ).bind(normalized).first() as { id: string; name: string; is_active: number } | null
      
      if (result?.id) {
        resolvedId = result.id as string
      } else {
      }
    } catch (error) {
      console.error('[Major Slug Resolution] D1 이름 검색 오류:', error)
    }
  }
  
  // Check for debug mode first (bypass ISR cache for debugging)
  // 병합 설계 시스템: 이름이 완전히 같은 전공만 동일 엔티티로 간주
  const debugMode = c.req.query('debug') === 'true'
  if (debugMode) {
    try {
      // 1. 데이터베이스에서 major_sources 가져오기 (이름으로 검색)
      const db = c.env.DB as D1Database
      if (!db) {
        throw new Error('DB not available')
      }

      // resolvedId를 전공명으로 사용 (slug에서 변환된 이름)
      const majorName = resolvedId

      // 통합 major 엔티티에서 major_id 찾기
      const majorRow = await db.prepare(`
        SELECT id, name FROM majors WHERE id = ? OR name = ? LIMIT 1
      `).bind(majorName, majorName).first<{ id: string; name: string }>()

      if (!majorRow) {
        // 전공을 못 찾으면 검색 페이지로 리다이렉트
        const searchQuery = decodeURIComponent(slug).replace(/-/g, ' ')
        return c.redirect(`/search?q=${encodeURIComponent(searchQuery)}`)
      }

      // 2. 해당 major_id의 모든 소스 가져오기
      const sources = await db.prepare(`
        SELECT * FROM major_sources WHERE major_id = ?
      `).bind(majorRow.id).all<MajorSourceRow>()

      if (!sources.results || sources.results.length === 0) {
        const fallbackHtml = renderDetailFallback({
          icon: 'fa-database',
          title: '소스 데이터가 없습니다',
          description: '이 전공에 대한 원본 데이터를 찾을 수 없습니다.',
          ctaHref: '/majors',
          ctaLabel: '전공 목록으로'
        })
        c.status(404)
        return c.html(renderLayoutWithContext(c, fallbackHtml, '소스 데이터 없음 - Careerwiki'))
      }

      // 3. 필드 비교 (전공은 아직 미구현)
      c.status(501)
      const fallbackHtml = renderDetailFallback({
        icon: 'fa-tools',
        title: '전공 필드 비교 준비 중',
        description: '전공 필드 비교 기능은 아직 구현 중입니다. 직업 필드 비교를 먼저 확인해주세요.',
        ctaHref: '/majors',
        ctaLabel: '전공 목록으로'
      })
      return c.html(renderLayoutWithContext(c, fallbackHtml, '준비 중 - Careerwiki'))
    } catch (error) {
      console.error('Debug mode error:', error)
      c.status(500)
      return c.html(renderLayoutWithContext(c, renderDetailFallback({
        icon: 'fa-circle-exclamation',
        iconColor: 'text-red-500',
        title: '디버그 데이터 로드 실패',
        description: error instanceof Error ? error.message : '일시적인 오류가 발생했습니다.',
        ctaHref: '/major',
        ctaLabel: '전공 목록으로'
      }), '오류 - Careerwiki'))
    }
  }
  
  // 🆕 ISR (Incremental Static Regeneration) with wiki_pages cache
  return getOrGeneratePage(
    slug,
    'major',
    {
      // Step 1: Fetch data
      fetchData: async (slug, env) => {
        mark?.('fetch-start')
        const careernetId = c.req.query('careernetId') || undefined
        const majorGbParam = c.req.query('goyongMajorGb')
        const departmentId = c.req.query('goyongDepartmentId') || undefined
        const majorId = c.req.query('goyongMajorId') || undefined
        const includeSources = parseSourcesQuery(c.req.query('sources'))

        const goyongMajorGb = majorGbParam === '1' ? '1' as const : majorGbParam === '2' ? '2' as const : undefined
        const goyongParams = goyongMajorGb && departmentId && majorId
          ? { majorGb: goyongMajorGb, departmentId, majorId } as { majorGb: '1' | '2'; departmentId: string; majorId: string }
          : undefined

        
        const result = await getUnifiedMajorDetail(
          {
            id: resolvedId,
            careernetId,
            goyong24Params: goyongParams,
            includeSources
          },
          env
        )
        mark?.('db-fetch')
        
        
        if (!result.profile) {
          console.error(`[Major ISR fetchData] Profile not found for resolvedId: "${resolvedId}"`)
          
          // Try sample data fallback
          const findSampleMajorDetail = () => {
            const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
            for (const candidate of candidates) {
              const sample = getSampleMajorDetail(candidate)
              if (sample) return sample
            }
            return null
          }
          
          const sample = findSampleMajorDetail()
          if (sample) {
            throw new Error('SAMPLE_FALLBACK') // Signal to use sample rendering
          }
          
          throw new Error('PROFILE_NOT_FOUND')
        }

        // 실제 DB ID 찾기 (resolvedId 사용, 이미 DB ID로 해결됨)
        let actualDbId = resolvedId
        
        // profile.id가 composite ID인 경우 실제 DB ID로 업데이트
        if (result.profile.id && result.profile.id.includes(':')) {
        }
        
        // 실제 DB ID로 프로필 업데이트
        
        // 관련 직업 중 DB에 존재하는 직업 매핑 조회
        let existingJobSlugs = new Map<string, string>()
        if (result.profile.relatedJobs?.length && env?.DB) {
          try {
            const jobNames = result.profile.relatedJobs.slice(0, 20) // 최대 20개만 조회
            const placeholders = jobNames.map(() => '?').join(',')
            const query = `SELECT name, slug FROM jobs WHERE name IN (${placeholders})`
            const { results } = await env.DB.prepare(query).bind(...jobNames).all() as { results: Array<{ name: string; slug: string }> | null }
            if (results) {
              for (const row of results) {
                existingJobSlugs.set(row.name, row.slug)
              }
            }
          } catch (e) {
            console.error('[Major ISR fetchData] Failed to query existing jobs:', e)
          }
        }
        
        // 같은 계열 전공 조회 (관련 전공)
        let relatedMajorsByCategory: Array<{ id: string; name: string; slug: string }> = []
        const categoryDisplay = (result.profile as any).categoryDisplay
        if (categoryDisplay && env?.DB) {
          try {
            // 같은 계열의 다른 전공 조회 (자기 자신 제외, 최대 15개)
            const query = `
              SELECT id, name, slug 
              FROM majors 
              WHERE json_extract(merged_profile_json, '$.categoryDisplay') = ? 
                AND id != ? 
                AND is_active = 1
              ORDER BY name
              LIMIT 15
            `
            const { results } = await env.DB.prepare(query)
              .bind(categoryDisplay, actualDbId)
              .all() as { results: Array<{ id: string; name: string; slug: string }> | null }
            if (results) {
              relatedMajorsByCategory = results.map(row => ({
                id: row.id,
                name: row.name,
                slug: row.slug
              }))
            }
          } catch (e) {
            console.error('[Major ISR fetchData] Failed to query related majors by category:', e)
          }
        }
        
        return {
          ...result,
          profile: {
            ...result.profile,
            id: actualDbId
          },
          existingJobSlugs,
          relatedMajorsByCategory
        }
      },

      // Step 2: Render HTML
      renderHTML: (result) => {
        mark?.('render-start')
        const profile = result.profile!  // Non-null assertion (we already checked in fetchData)
        const canonicalSlug = composeDetailSlug('major', profile.name, profile.id ?? resolvedId)
        const canonicalPath = `/major/${encodeURIComponent(canonicalSlug)}`
        const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
        const title = `${profile.name} 전공 정보 - Careerwiki`
        const description = createMetaDescription(
          profile.summary,
          profile.employmentRate,
          profile.salaryAfterGraduation,
          profile.jobProspect
        )
        const extraHead = [
          '<meta property="og:type" content="article">',
          '<meta property="article:modified_time" content="' + new Date().toISOString() + '">',
          createMajorJsonLd(profile, canonicalUrl)
        ].filter(Boolean).join('\n')

        const content = renderUnifiedMajorDetail({
          profile,
          partials: result.partials,
          sources: result.sources,
          existingJobSlugs: result.existingJobSlugs,
          relatedMajorsByCategory: result.relatedMajorsByCategory
        })
        mark?.('render-done')

        return renderLayoutWithContext(c,
          content,
          escapeHtml(title),
          escapeHtml(description),
          false,
          {
            canonical: canonicalUrl,
            ogUrl: canonicalUrl,
            extraHead
          }
        )
      },

      // Step 3: Extract metadata
      extractMetadata: (result) => {
        const profile = result.profile!  // Non-null assertion (we already checked in fetchData)
        return {
          title: `${profile.name} 전공 정보 - Careerwiki`,
          description: createMetaDescription(
            profile.summary,
            profile.employmentRate,
            profile.salaryAfterGraduation,
            profile.jobProspect
          ),
          og_image_url: undefined // Add later if needed
        }
      }
    },
    c
  ).catch((error) => {
    // Error handling
    console.error('Major detail route error:', error)
    
    // Try sample fallback
    if (error.message === 'SAMPLE_FALLBACK') {
      const findSampleMajorDetail = () => {
        const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
        for (const candidate of candidates) {
          const sample = getSampleMajorDetail(candidate)
          if (sample) return sample
        }
        return null
      }
      
      const sample = findSampleMajorDetail()
      if (sample) {
        console.warn('Major detail fallback: serving synthetic sample for', slug)
        return renderSampleMajorDetailPage(c, sample)
      }
    }
    
    // 404 for missing profiles -> 검색 페이지로 리다이렉트
    if (error.message === 'PROFILE_NOT_FOUND') {
      const searchQuery = decodeURIComponent(slug).replace(/-/g, ' ')
      return c.redirect(`/search?q=${encodeURIComponent(searchQuery)}`)
    }
    
    // 500 for other errors
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-exclamation-circle',
      iconColor: 'text-red-500',
      title: '전공 정보를 불러오지 못했습니다',
      description: '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ctaHref: '/major',
      ctaLabel: '전공위키로 돌아가기'
    })
    c.status(500)
    return c.html(
      renderLayoutWithContext(c,
        fallbackHtml,
        '전공 정보 로드 오류 - Careerwiki',
        '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
      )
    )
  })
})

const parseSourcesQuery = (value?: string | null): DataSource[] | undefined => {
  if (!value) return undefined
  const tokens = value
    .split(',')
    .map((token) => token.trim().toUpperCase())
    .filter((token) => token.length > 0) as (DataSource | string)[]
  const validSources: DataSource[] = []
  tokens.forEach((token) => {
    if (token === 'CAREERNET' || token === 'GOYONG24') {
      if (!validSources.includes(token)) {
        validSources.push(token)
      }
    }
  })
  return validSources.length ? validSources : undefined
}

const parseNumberParam = (
  value: string | undefined,
  fallback: number,
  options?: { min?: number; max?: number }
): number => {
  if (!value) return fallback
  const parsed = Number(value)
  if (!Number.isFinite(parsed)) {
    return fallback
  }

  let result = Math.floor(parsed)
  if (options?.min !== undefined && result < options.min) {
    result = options.min
  }
  if (options?.max !== undefined && result > options.max) {
    result = options.max
  }
  if (options?.min === undefined && result <= 0) {
    return fallback
  }
  return result
}

const toIntegerOrNull = (
  value: unknown,
  options?: { min?: number; max?: number }
): number | null => {
  if (typeof value !== 'number' || !Number.isFinite(value)) {
    return null
  }

  let result = Math.floor(value)
  if (options?.min !== undefined && result < options.min) {
    result = options.min
  }
  if (options?.max !== undefined && result > options.max) {
    result = options.max
  }
  return result
}

// 취업률 포맷 함수: "70% 이상" 같은 텍스트에서 숫자 추출 후 소수점 1자리까지 반올림
const formatEmploymentRate = (rate: string | undefined): string | undefined => {
  if (!rate) return undefined
  // HTML 태그 제거 및 공백 정리
  const cleaned = rate.replace(/<[^>]*>/g, '').trim()
  // 숫자 추출 (정수 또는 소수)
  const match = cleaned.match(/([\d.]+)/)
  if (!match) return cleaned
  const num = parseFloat(match[1])
  if (isNaN(num)) return cleaned
  // 소수점 1자리까지 반올림, 정수면 정수로 표시
  const rounded = Math.round(num * 10) / 10
  return Number.isInteger(rounded) ? `${rounded}%` : `${rounded.toFixed(1)}%`
}

const escapeHtml = (value: string): string =>
  value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')

// 안전한 날짜 포맷팅 함수 (Unix timestamp 초 단위 또는 DATETIME 문자열 모두 처리)
const formatDateSafe = (dateValue: string | number | null | undefined): string => {
  if (!dateValue) return ''
  try {
    // 숫자인 경우 Unix timestamp (초 단위)로 간주하고 밀리초로 변환
    if (typeof dateValue === 'number' || (typeof dateValue === 'string' && /^\d+$/.test(dateValue))) {
      const timestamp = typeof dateValue === 'number' ? dateValue : parseInt(dateValue, 10)
      return new Date(timestamp * 1000).toLocaleDateString('ko-KR')
    }
    // 문자열인 경우 DATETIME 형식으로 간주
    return new Date(dateValue).toLocaleDateString('ko-KR')
  } catch {
    return ''
  }
}

const serializeForScript = (value: unknown): string =>
  JSON.stringify(value)
    .replace(/</g, '\\u003C')
    .replace(/>/g, '\\u003E')
    .replace(/&/g, '\\u0026')

const createMetaDescription = (...candidates: Array<string | undefined | null>): string => {
  for (const candidate of candidates) {
    if (!candidate) continue
    const normalized = candidate.replace(/\s+/g, ' ').trim()
    if (!normalized) continue
    if (normalized.length <= 160) {
      return normalized
    }
    return `${normalized.slice(0, 157)}…`
  }
  return 'Careerwiki는 고용24와 커리어넷 데이터를 통합해 제공하는 진로 정보 플랫폼입니다.'
}

// ============================================================================
// 카드 렌더링 공통 함수 (SSR + API 공유)
// ============================================================================

// 만족도 등급 계산 (직업/전공 공통)
const getSatisfactionGrade = (satisfaction: string | undefined) => {
  if (!satisfaction) return null
  const score = parseFloat(satisfaction) || 0
  
  if (score >= 80) {
    return { level: '매우 좋음', bg: 'bg-green-500/10', border: 'border-green-500/20', iconColor: 'text-green-400', textColor: 'text-green-300', textMuted: 'text-green-300/80' }
  } else if (score >= 60) {
    return { level: '좋음', bg: 'bg-sky-500/10', border: 'border-sky-500/20', iconColor: 'text-sky-400', textColor: 'text-sky-300', textMuted: 'text-sky-300/80' }
  } else if (score >= 40) {
    return { level: '보통', bg: 'bg-yellow-500/10', border: 'border-yellow-500/20', iconColor: 'text-yellow-400', textColor: 'text-yellow-300', textMuted: 'text-yellow-300/80' }
  } else if (score >= 20) {
    return { level: '별로', bg: 'bg-orange-500/10', border: 'border-orange-500/20', iconColor: 'text-orange-400', textColor: 'text-orange-300', textMuted: 'text-orange-300/80' }
  } else {
    return { level: '매우 별로', bg: 'bg-red-500/10', border: 'border-red-500/20', iconColor: 'text-red-400', textColor: 'text-red-300', textMuted: 'text-red-300/80' }
  }
}

// 직업 요약 텍스트 포맷
const formatJobSummaryText = (value?: string | null): string => {
  const fallback = '고용24와 커리어넷 데이터를 통합하여 제공하는 직업 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
  if (!value) return fallback
  const normalized = value.replace(/\s+/g, ' ').trim()
  if (!normalized) return fallback
  return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
}

// 전공 요약 텍스트 포맷
const formatMajorSummaryText = (value?: string | null): string => {
  const fallback = '고용24와 커리어넷 데이터를 통합하여 제공하는 학과 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
  if (!value) return fallback
  const normalized = value.replace(/\s+/g, ' ').trim()
  if (!normalized) return fallback
  return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
}

// 숙련기간 포맷팅: 단위가 같을 때 앞 단위 제거 (예: "1년~2년" → "1~2년")
const formatSkillYear = (value?: string | null): string => {
  if (!value) return ''
  let trimmed = String(value).trim()
  if (!trimmed) return ''
  
  // "초과", "이하" 제거
  trimmed = trimmed
    .replace(/\s*초과\s*/g, ' ')
    .replace(/\s*이하\s*/g, '')
    .replace(/\s+/g, ' ')
    .trim()
  
  // "~" 또는 "-"로 구분된 범위 형식인지 확인 (공백 무시)
  const rangeMatch = trimmed.match(/^(.+?)\s*([~-])\s*(.+)$/)
  if (!rangeMatch) return trimmed // 범위 형식이 아니면 그대로 반환
  
  const [, start, separator, end] = rangeMatch
  
  // 단위 추출 (년, 개월 등) - 앞뒤 공백 제거
  const startTrimmed = start.trim()
  const unitMatch = startTrimmed.match(/(\d+)\s*(년|개월|월)$/)
  if (!unitMatch) return trimmed // 단위가 없으면 그대로 반환
  
  const [, startNum, unit] = unitMatch
  
  // 끝 부분에서 같은 단위가 있는지 확인 - 앞뒤 공백 제거
  const endTrimmed = end.trim()
  const endMatch = endTrimmed.match(/^(\d+)\s*(년|개월|월)$/)
  if (!endMatch) return trimmed // 끝 부분에 단위가 없으면 그대로 반환
  
  const [, endNum, endUnit] = endMatch
  
  // 단위가 같으면 앞 단위 제거
  if (unit === endUnit) {
    return `${startNum}${separator}${endNum}${unit}`
  }
  
  // 단위가 다르면 그대로 반환
  return trimmed
}

// 직업 카드 HTML 렌더링
const renderJobCard = (entry: { profile: any; display?: any }): string => {
  const job = entry.profile
  const display = entry.display ?? {}
  const jobSlug = composeDetailSlug('job', job.name, job.id)
  const jobUrl = `/job/${encodeURIComponent(jobSlug)}`
  const summary = escapeHtml(formatJobSummaryText(display.summary))
  // categoryName이 객체일 수 있으므로 문자열 추출
  const rawCategoryName = display.categoryName || job.category?.name
  const normalizeCategory = (value: any): string => {
    let cat =
      typeof value === 'string'
        ? value
        : (value?.value || value?.large || value?.name || value?.medium || value?.small || '')
    if (cat.includes('›')) cat = cat.split('›')[0].trim()
    else if (cat.includes('>')) cat = cat.split('>')[0].trim()
    return cat
  }
  const categoryName = normalizeCategory(rawCategoryName)
  
  const satisfactionGrade = getSatisfactionGrade(display.satisfaction)
  
  // 메트릭 박스 생성 (우선순위: 평균 연봉 > 만족도 > 워라벨 > 작업 강도 > 숙련기간)
  type MetricBox = { html: string; mobileHtml: string; priority: number }
  const metricBoxes: MetricBox[] = []
  
  // 1. 평균 연봉 (최우선)
  if (display.salary) {
    const salaryText = display.salary.replace(/평균\s*/g, '')
    metricBoxes.push({
      priority: 1,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-won-sign text-emerald-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-emerald-300/70">평균 연봉</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-emerald-300 text-center leading-tight px-1">${escapeHtml(salaryText)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-won-sign text-[10px]"></i>
          <span>평균 연봉: ${escapeHtml(salaryText)}</span>
        </span>
      `
    })
  }
  
  // 2. 만족도
  if (display.satisfaction && satisfactionGrade) {
    metricBoxes.push({
      priority: 2,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-smile ${satisfactionGrade.iconColor} text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium ${satisfactionGrade.textMuted}">만족도</span>
          <span class="text-[11px] sm:text-[13px] font-bold ${satisfactionGrade.textColor}">${escapeHtml(satisfactionGrade.level)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full ${satisfactionGrade.bg} border ${satisfactionGrade.border} ${satisfactionGrade.textColor} text-xs font-medium whitespace-nowrap">
          <i class="fas fa-smile text-[10px]"></i>
          <span>만족도: ${escapeHtml(satisfactionGrade.level)}</span>
        </span>
      `
    })
  }
  
  // 3. 워라벨
  if (display.wlb) {
    metricBoxes.push({
      priority: 3,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-purple-500/10 backdrop-blur-sm border border-purple-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-balance-scale text-purple-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-purple-300/70">워라벨</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-purple-300 text-center leading-tight">${escapeHtml(display.wlb)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-purple-500/10 border border-purple-500/20 text-purple-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-balance-scale text-[10px]"></i>
          <span>워라벨: ${escapeHtml(display.wlb)}</span>
        </span>
      `
    })
  }
  
  // 4. 작업 강도 (직업사전)
  if (display.workStrong) {
    metricBoxes.push({
      priority: 4,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-amber-500/10 backdrop-blur-sm border border-amber-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-dumbbell text-amber-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-amber-300/70">작업 강도</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-amber-300 text-center leading-tight">${escapeHtml(display.workStrong)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-amber-500/10 border border-amber-500/20 text-amber-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-dumbbell text-[10px]"></i>
          <span>작업 강도: ${escapeHtml(display.workStrong)}</span>
        </span>
      `
    })
  }
  
  // 5. 숙련기간 (직업사전)
  if (display.skillYear) {
    const formattedSkillYear = formatSkillYear(display.skillYear)
    metricBoxes.push({
      priority: 5,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-cyan-500/10 backdrop-blur-sm border border-cyan-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-clock text-cyan-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-cyan-300/70">숙련기간</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-cyan-300 text-center leading-tight">${escapeHtml(formattedSkillYear)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-cyan-500/10 border border-cyan-500/20 text-cyan-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-clock text-[10px]"></i>
          <span>숙련기간: ${escapeHtml(formattedSkillYear)}</span>
        </span>
      `
    })
  }
  
  // 우선순위 정렬
  const sortedBoxes = metricBoxes.sort((a, b) => a.priority - b.priority)
  
  // 데스크톱용 메트릭 박스 HTML (최대 3개, 3번째 박스는 모바일에서 숨김)
  const desktopBoxes = sortedBoxes.slice(0, 3)
  const metricsHtml = desktopBoxes.map((box, index) => {
    if (index === 2) {
      return `<div class="hidden sm:flex">${box.html}</div>`
    }
    return box.html
  }).join('')
  
  // 모바일용 메트릭 태그 HTML (모든 메트릭 표시)
  const mobileMetricsHtml = sortedBoxes.map(box => box.mobileHtml).join('')

  // 썸네일 이미지 URL (메트릭 박스와 같거나 큰 크기, 수직 중앙 정렬)
  const imageUrl = display.imageUrl
  const thumbnailHtml = imageUrl 
    ? `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl overflow-hidden bg-wiki-card/60 border border-wiki-border/30">
         <img src="${escapeHtml(imageUrl)}" alt="${escapeHtml(job.name)}" class="w-full h-full object-cover" loading="lazy" onerror="this.parentElement.innerHTML='<div class=\\'flex items-center justify-center w-full h-full text-wiki-muted\\' aria-hidden=\\'true\\'><i class=\\'fas fa-briefcase text-3xl\\'></i></div>'" />
       </div>`
    : `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl bg-gradient-to-br from-wiki-primary/10 to-wiki-secondary/10 border border-wiki-border/30 flex items-center justify-center">
         <i class="fas fa-briefcase text-3xl text-wiki-muted" aria-hidden="true"></i>
       </div>`

  return `
    <article class="group relative">
        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
          <!-- 배경 그라데이션 글로우 -->
        <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none">
            <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
            <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
          </div>
          
        <!-- 클릭 가능한 링크 영역 -->
        <a href="${jobUrl}" class="block">
          <div class="relative flex gap-3 sm:gap-4 items-center">
            <!-- 썸네일 (데스크톱: 왼쪽, 중간 정렬) -->
            <div class="hidden sm:block flex-shrink-0 self-center">
            ${thumbnailHtml}
            </div>
            
            <!-- 직업 정보 -->
            <div class="flex-1 space-y-3 sm:space-y-4 min-w-0 sm:max-w-[60%] pr-[84px] sm:pr-0">
              <!-- 헤더: 카테고리 + 직업명 -->
              <div class="space-y-1.5 sm:space-y-2">
                ${categoryName ? `
                  <div class="flex items-center gap-2">
                    <span class="inline-flex items-center gap-1 sm:gap-1.5 px-1.5 sm:px-2 py-0.5 sm:py-0.5 rounded-md sm:rounded-md rounded-full sm:rounded-md text-[9px] sm:text-[10px] text-xs sm:text-[10px] font-semibold sm:font-semibold font-medium sm:font-semibold uppercase tracking-wider bg-wiki-secondary/10 text-wiki-secondary/80 border border-wiki-secondary/20">
                      <i class="fas fa-folder text-[7px] sm:text-[8px] text-[10px] sm:text-[8px]"></i>
                      ${escapeHtml(categoryName)}
                    </span>
                  </div>
                ` : ''}
                
                <h2 class="text-lg sm:text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">
                  ${escapeHtml(job.name)}
                </h2>
              </div>
              
              <!-- 설명 -->
              <p class="text-[13px] sm:text-[15px] leading-relaxed text-wiki-muted/90 line-clamp-2">
                ${summary}
              </p>
            </div>
            
            <!-- 썸네일 (모바일: 오른쪽, 태그 영역 제외한 중간 정렬) -->
            <div class="sm:hidden absolute right-0 top-1/2 -translate-y-1/2 flex-shrink-0" style="transform: translateY(-50%);">
              ${thumbnailHtml}
            </div>
            
            <!-- 데스크톱: 오른쪽 메트릭 박스들 (최대 3개) -->
            ${metricsHtml ? `
              <div class="hidden sm:flex gap-2 sm:gap-2.5 items-center justify-end flex-shrink-0 ml-auto">
                ${metricsHtml}
              </div>
            ` : ''}
        </div>
      </a>
        
        <!-- 모바일: 메트릭 태그들 가로 스크롤 (a 태그 바깥) -->
        ${mobileMetricsHtml ? `
          <div class="sm:hidden mt-3 overflow-x-auto" style="-webkit-overflow-scrolling: touch; scrollbar-width: none;">
            <div class="flex gap-2 w-max">
              ${mobileMetricsHtml}
            </div>
          </div>
        ` : ''}
      </div>
    </article>
  `
}

// 전공 카드 HTML 렌더링
const renderMajorCard = (entry: { profile: any; display?: any }): string => {
  const major = entry.profile
  const display = entry.display ?? {}
  const majorSlug = composeDetailSlug('major', major.name, major.id)
  const majorUrl = `/major/${encodeURIComponent(majorSlug)}`
  const summary = escapeHtml(formatMajorSummaryText(display.summary))
  // 계열 이름: 객체일 수 있으므로 문자열 추출, 콤마가 2개 이하인 경우에만 표시
  const rawCategoryName = typeof display.categoryName === 'string' 
    ? display.categoryName 
    : (display.categoryName?.value || display.categoryName?.large || display.categoryName?.name || '')
  const categoryName = rawCategoryName && rawCategoryName.split(',').length <= 2
    ? rawCategoryName
    : undefined
  
  const satisfactionGrade = getSatisfactionGrade(display.firstJobSatisfaction)
  
  // 메트릭 박스 생성 (우선순위: 취업률 > 첫직장월급 > 만족도 > 계열)
  type MetricBox = { html: string; mobileHtml: string; priority: number }
  const metricBoxes: MetricBox[] = []
  
  // 1. 취업률 (최우선)
  if (display.employmentRate) {
    const rateText = formatEmploymentRate(display.employmentRate) || ''
    metricBoxes.push({
      priority: 1,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-blue-500/10 backdrop-blur-sm border border-blue-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-chart-line text-blue-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-blue-300/70">취업률</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-blue-300 text-center leading-tight px-1">${escapeHtml(rateText)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-chart-line text-[10px]"></i>
          <span>취업률: ${escapeHtml(rateText)}</span>
        </span>
      `
    })
  }
  
  // 2. 평균 월급
  if (display.firstJobSalary) {
    const salaryText = display.firstJobSalary.includes('만원') ? display.firstJobSalary : `${display.firstJobSalary}만원`
    metricBoxes.push({
      priority: 2,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-won-sign text-emerald-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-emerald-300/70">평균 월급</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-emerald-300 text-center leading-tight px-1">${escapeHtml(salaryText)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-won-sign text-[10px]"></i>
          <span>평균 월급: ${escapeHtml(salaryText)}</span>
        </span>
      `
    })
  }
  
  // 3. 만족도
  if (display.firstJobSatisfaction && satisfactionGrade) {
    metricBoxes.push({
      priority: 3,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-smile ${satisfactionGrade.iconColor} text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium ${satisfactionGrade.textMuted}">만족도</span>
          <span class="text-[11px] sm:text-[13px] font-bold ${satisfactionGrade.textColor}">${escapeHtml(satisfactionGrade.level)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full ${satisfactionGrade.bg} border ${satisfactionGrade.border} ${satisfactionGrade.textColor} text-xs font-medium whitespace-nowrap">
          <i class="fas fa-smile text-[10px]"></i>
          <span>만족도: ${escapeHtml(satisfactionGrade.level)}</span>
        </span>
      `
    })
  }
  
  // 4. 계열
  if (categoryName) {
    metricBoxes.push({
      priority: 4,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-purple-500/10 backdrop-blur-sm border border-purple-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-graduation-cap text-purple-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-purple-300/70">계열</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-purple-300 text-center leading-tight px-1">${escapeHtml(categoryName.length > 10 ? categoryName.substring(0, 10) + '...' : categoryName)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-purple-500/10 border border-purple-500/20 text-purple-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-graduation-cap text-[10px]"></i>
          <span>계열: ${escapeHtml(categoryName)}</span>
        </span>
      `
    })
  }
  
  // 우선순위 정렬
  const sortedBoxes = metricBoxes.sort((a, b) => a.priority - b.priority)
  
  // 데스크톱용 메트릭 박스 HTML (최대 3개, 3번째 박스는 모바일에서 숨김)
  const desktopBoxes = sortedBoxes.slice(0, 3)
  const metricsHtml = desktopBoxes.map((box, index) => {
    if (index === 2) {
      return `<div class="hidden sm:flex">${box.html}</div>`
    }
    return box.html
  }).join('')
  
  // 모바일용 메트릭 태그 HTML (모든 메트릭 표시)
  const mobileMetricsHtml = sortedBoxes.map(box => box.mobileHtml).join('')

  // 썸네일 이미지 URL (메트릭 박스와 같거나 큰 크기, 수직 중앙 정렬)
  const imageUrl = display.imageUrl
  const thumbnailHtml = imageUrl 
    ? `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl overflow-hidden bg-wiki-card/60 border border-wiki-border/30">
         <img src="${escapeHtml(imageUrl)}" alt="${escapeHtml(major.name)}" class="w-full h-full object-cover" loading="lazy" onerror="this.parentElement.innerHTML='<div class=\\'flex items-center justify-center w-full h-full text-wiki-muted\\' aria-hidden=\\'true\\'><i class=\\'fas fa-graduation-cap text-3xl\\'></i></div>'" />
       </div>`
    : `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl bg-gradient-to-br from-wiki-secondary/10 to-wiki-primary/10 border border-wiki-border/30 flex items-center justify-center">
         <i class="fas fa-graduation-cap text-3xl text-wiki-muted" aria-hidden="true"></i>
       </div>`

  return `
    <article class="group relative">
      <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
        <!-- 배경 그라데이션 글로우 -->
        <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none">
          <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
          <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
        </div>
        
        <!-- 클릭 가능한 링크 영역 -->
        <a href="${majorUrl}" class="block">
          <div class="relative flex gap-3 sm:gap-4 items-center">
            <!-- 썸네일 (데스크톱: 왼쪽, 중간 정렬) -->
            <div class="hidden sm:block flex-shrink-0 self-center">
              ${thumbnailHtml}
            </div>
            
            <!-- 전공 정보 -->
            <div class="flex-1 space-y-3 sm:space-y-4 min-w-0 sm:max-w-[60%] pr-[84px] sm:pr-0">
              <!-- 헤더: 전공명 -->
              <div class="space-y-1.5 sm:space-y-2">
                <h2 class="text-lg sm:text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">
                  ${escapeHtml(major.name)}
                </h2>
              </div>
              
              <!-- 설명 -->
              <p class="text-[13px] sm:text-[15px] leading-relaxed text-wiki-muted/90 line-clamp-2">
                ${summary}
              </p>
            </div>
            
            <!-- 썸네일 (모바일: 오른쪽, 수직 중앙 정렬) -->
            <div class="sm:hidden absolute right-0 top-1/2 -translate-y-1/2 flex-shrink-0" style="transform: translateY(-50%);">
              ${thumbnailHtml}
            </div>
            
            <!-- 데스크톱: 오른쪽 메트릭 박스들 (최대 3개) -->
            ${metricsHtml ? `
              <div class="hidden sm:flex gap-2 sm:gap-2.5 items-center justify-end flex-shrink-0 ml-auto">
                ${metricsHtml}
              </div>
            ` : ''}
          </div>
        </a>
        
        <!-- 모바일: 메트릭 태그 가로 스크롤 (카드 패딩 내부) -->
        ${mobileMetricsHtml ? `
          <div class="sm:hidden mt-3 overflow-x-auto" style="-webkit-overflow-scrolling: touch; scrollbar-width: none;">
            <div class="flex gap-2 w-max">
              ${mobileMetricsHtml}
            </div>
          </div>
        ` : ''}
      </div>
    </article>
  `
}

const renderDetailFallback = (options: {
  icon: string
  title: string
  description: string
  ctaHref: string
  ctaLabel: string
  iconColor?: string
  note?: string
}): string => {
  const { icon, title, description, ctaHref, ctaLabel, iconColor = 'text-wiki-muted', note } = options
  return `
    <div class="max-w-3xl mx-auto text-center py-20">
      <div class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-wiki-border/30 mb-6">
        <i class="fas ${icon} ${iconColor} text-3xl"></i>
      </div>
      <h1 class="text-3xl font-bold mb-4 text-white">${escapeHtml(title)}</h1>
      <p class="text-wiki-muted mb-6">${escapeHtml(description)}</p>
      ${note ? `<p class="text-xs text-wiki-muted mb-6">${escapeHtml(note)}</p>` : ''}
      <a href="${escapeHtml(ctaHref)}" class="inline-flex items-center gap-2 px-6 py-3 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
        <i class="fas fa-arrow-left"></i><span>${escapeHtml(ctaLabel)}</span>
      </a>
    </div>
  `
}

type SampleHighlight = {
  slug: string
  title: string
  snippet: string
  keywords: string[]
}

const renderSampleHighlightBadges = (keywords: string[] | undefined): string => {
  if (!keywords || keywords.length === 0) return ''
  const chips = keywords
    .slice(0, 6)
    .map((keyword) => `<span class="px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted">${escapeHtml(keyword)}</span>`)
    .join('')
  return `<div class="flex flex-wrap gap-2">${chips}</div>`
}

const renderSampleHighlightCards = (
  samples: SampleHighlight[],
  basePath: 'job' | 'major',
  notice: { title: string; description: string; badge: string }
): string => {
  if (!samples.length) {
    return `
      <div class="glass-card p-12 rounded-2xl text-center">
        <i class="fas fa-lightbulb text-4xl text-wiki-secondary mb-4"></i>
        <h2 class="text-2xl font-semibold text-white mb-2">${escapeHtml(notice.title)}</h2>
        <p class="text-sm text-wiki-muted">${escapeHtml(notice.description)}</p>
      </div>
    `
  }

  const cards = samples
    .map((sample) => {
      const href = `/${basePath}/${encodeURIComponent(sample.slug)}`
      const badges = renderSampleHighlightBadges(sample.keywords)
      return `
        <article class="glass-card h-full p-6 rounded-2xl border border-wiki-border/60 bg-wiki-bg/70">
          <div class="flex flex-col h-full gap-4">
            <div>
              <h3 class="text-xl font-semibold text-white">
                <a href="${href}" class="hover:text-wiki-secondary transition">${escapeHtml(sample.title)}</a>
              </h3>
              <p class="text-xs text-wiki-muted uppercase tracking-wide mt-1">${escapeHtml(notice.badge)}</p>
            </div>
            <p class="text-sm text-wiki-muted leading-relaxed flex-1">${escapeHtml(sample.snippet)}</p>
            ${badges}
            <div class="pt-2">
              <a href="${href}" class="inline-flex items-center gap-2 text-sm text-wiki-primary hover:text-wiki-secondary transition">
                자세히 보기<i class="fas fa-arrow-right"></i>
              </a>
            </div>
          </div>
        </article>
      `
    })
    .join('')

  return `
    <section class="space-y-6">
      <div class="glass-card p-8 rounded-2xl border border-wiki-border/60 bg-wiki-bg/60 text-center">
        <h2 class="text-2xl font-semibold text-white mb-2">${escapeHtml(notice.title)}</h2>
        <p class="text-sm text-wiki-muted">${escapeHtml(notice.description)}</p>
      </div>
      <div class="grid gap-4 md:grid-cols-3">${cards}</div>
    </section>
  `
}

const renderSampleJobHighlights = (limit = 3): string =>
  renderSampleHighlightCards(listSampleJobSummaries().slice(0, limit), 'job', {
    title: 'Phase 1 샘플 직업 살펴보기',
    description: 'CareerWiki 통합 데이터가 준비되는 동안 합성 직업 샘플을 참고해 주세요.',
    badge: 'Phase 1 Synthetic Sample'
  })

const renderSampleMajorHighlights = (limit = 3): string =>
  renderSampleHighlightCards(listSampleMajorSummaries().slice(0, limit), 'major', {
    title: 'Phase 1 샘플 전공 미리보기',
    description: 'CareerWiki가 제공할 전공 데이터를 Phase 1 합성 샘플로 먼저 확인해 보세요.',
    badge: 'Phase 1 Synthetic Sample'
  })

const describeSkipReason = (reason?: string): string => {
  switch (reason) {
    case 'missing-id':
      return '식별자 정보가 부족해 호출되지 않았습니다.'
    case 'missing-params':
      return '필수 파라미터가 부족해 호출되지 않았습니다.'
    case 'keyword-required':
      return '키워드가 없어 호출되지 않았습니다.'
    case 'excluded':
      return '요청한 데이터 소스에서 제외되었습니다.'
    default:
      return reason ? `호출되지 않음 (${reason})` : '호출되지 않았습니다.'
  }
}

const renderSourceStatusSummary = (
  sources?: SourceStatusRecord,
  options?: { id?: string }
): string => {
  const idAttr = options?.id ? ` id="${escapeHtml(options.id)}"` : ''
  if (!sources) {
    return options?.id ? `<div${idAttr}></div>` : ''
  }
  const entries = Object.entries(sources) as Array<[DataSource, SourceStatusRecord[DataSource]]>
  const rows = entries
    .map(([source, status]) => {
      const label = SOURCE_LABEL_MAP[source] ?? source
      let message: string
      if (status?.error) {
        message = `오류: ${status.error}`
      } else if (typeof status?.count === 'number' && status.count > 0) {
        message = `데이터 ${status.count}건 수신`
      } else if (status?.attempted) {
        message = '호출되었으나 제공 가능한 데이터가 없습니다.'
      } else {
        message = describeSkipReason(status?.skippedReason)
      }
      return `
        <li class="flex items-start justify-between gap-4">
          <span class="text-sm font-semibold text-wiki-text">${escapeHtml(label)}</span>
          <span class="text-xs text-wiki-muted text-right">${escapeHtml(message)}</span>
        </li>
      `
    })
    .join('')
  if (!rows) {
    return options?.id ? `<div${idAttr}></div>` : ''
  }
  return `
    <div${idAttr} class="glass-card p-6 rounded-xl mt-8">
      <h2 class="text-lg font-semibold text-wiki-text mb-3">데이터 수집 상태</h2>
      <ul class="space-y-2">${rows}</ul>
    </div>
  `
}

const renderCacheNotice = (
  state?: CacheState,
  options?: { staleSeconds: number; maxAgeSeconds: number }
): string => {
  if (!state || state.status === 'bypass') return ''

  const statusLabels: Record<CacheState['status'], string> = {
    miss: 'Cloudflare KV에 새로 저장된 데이터',
    hit: 'Cloudflare KV 캐시 적중',
    revalidated: '캐시 재검증 완료',
    stale: '임시 캐시 데이터 제공',
    bypass: '캐시 미사용'
  }

  const accentClasses: Record<CacheState['status'], string> = {
    miss: 'text-wiki-secondary',
    hit: 'text-wiki-secondary',
    revalidated: 'text-green-400',
    stale: 'text-yellow-300',
    bypass: 'text-wiki-muted'
  }

  const statusLabel = statusLabels[state.status] ?? '캐시 상태'
  const accent = accentClasses[state.status] ?? 'text-wiki-muted'

  const detailText = [
    `캐시 생성: ${formatTimestamp(state.cachedAt)}`,
    `재검증 예정: ${formatTimestamp(state.staleAt)}`,
    `만료 예정: ${formatTimestamp(state.expiresAt)}`
  ].join(' · ')

  const durationText = options
    ? `재검증 주기 ${secondsToHuman(options.staleSeconds)}, 최대 보존 ${secondsToHuman(options.maxAgeSeconds)}`
    : undefined

  return `
    <div class="glass-card p-4 rounded-xl mb-6 border border-wiki-border/70 bg-wiki-bg/70">
      <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <div>
          <p class="text-sm font-semibold ${accent}"><i class="fas fa-cloud mr-2"></i>${escapeHtml(statusLabel)}</p>
          <p class="text-xs text-wiki-muted mt-1">${escapeHtml(detailText)}</p>
        </div>
        ${durationText ? `<p class="text-xs text-wiki-muted">${escapeHtml(durationText)}</p>` : ''}
      </div>
    </div>
  `
}

const createKeywordsMetaTag = (keywords?: string[]): string => {
  if (!keywords || keywords.length === 0) {
    return ''
  }
  return `<meta name="keywords" content="${escapeHtml(keywords.join(', '))}">`
}

const createArticleModifiedMeta = (updatedAt?: string): string => {
  if (!updatedAt) {
    return ''
  }
  return `<meta property="article:modified_time" content="${escapeHtml(updatedAt)}">`
}

function renderSampleJobDetailPage(
  c: Context<{ Bindings: Bindings; Variables: Variables }>,
  sample: NonNullable<ReturnType<typeof getSampleJobDetail>>
) {
  return renderSampleJobDetailPageWithRawData(c, sample, undefined)
}

function renderSampleJobDetailPageWithRawData(
  c: Context<{ Bindings: Bindings; Variables: Variables }>,
  sample: NonNullable<ReturnType<typeof getSampleJobDetail>>,
  rawApiData?: { careernet?: any; goyong24?: any }
) {
  const canonicalSlug = sample.meta?.canonicalSlug ?? composeDetailSlug('job', sample.profile.name, sample.profile.id)
  const canonicalPath = `/job/${encodeURIComponent(canonicalSlug)}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
  const title = sample.meta?.title ?? `${sample.profile.name} 직업 정보 - Careerwiki`
  const description = createMetaDescription(
    sample.meta?.description,
    sample.profile.summary,
    sample.profile.prospect,
    sample.snippet
  )
  const extraHead = [
    '<meta property="og:type" content="article">',
    createJobJsonLd(sample.profile, canonicalUrl),
    createKeywordsMetaTag(sample.meta?.keywords),
    createArticleModifiedMeta(sample.meta?.updatedAt)
  ].filter(Boolean).join('\n')

  const content = renderUnifiedJobDetail({
    profile: sample.profile,
    partials: sample.partials ?? {},
    sources: sample.sources,
    rawApiData // Pass rawApiData even for sample pages
  })

  return c.html(
    renderLayoutWithContext(c,
      content,
      escapeHtml(title),
      escapeHtml(description),
      false,
      {
        canonical: canonicalUrl,
        ogUrl: canonicalUrl,
        extraHead
      }
    )
  )
}

function renderSampleMajorDetailPage(
  c: Context<{ Bindings: Bindings; Variables: Variables }>,
  sample: NonNullable<ReturnType<typeof getSampleMajorDetail>>
) {
  const canonicalSlug = sample.meta?.canonicalSlug ?? composeDetailSlug('major', sample.profile.name, sample.profile.id)
  const canonicalPath = `/major/${encodeURIComponent(canonicalSlug)}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
  const title = sample.meta?.title ?? `${sample.profile.name} 전공 정보 - Careerwiki`
  const description = createMetaDescription(
    sample.meta?.description,
    sample.profile.summary,
    sample.profile.jobProspect,
    sample.snippet
  )
  const extraHead = [
    '<meta property="og:type" content="article">',
    createMajorJsonLd(sample.profile, canonicalUrl),
    createKeywordsMetaTag(sample.meta?.keywords),
    createArticleModifiedMeta(sample.meta?.updatedAt)
  ].filter(Boolean).join('\n')

  const content = renderUnifiedMajorDetail({
    profile: sample.profile,
    partials: sample.partials ?? {},
    sources: sample.sources
  })

  return c.html(
    renderLayoutWithContext(c,
      content,
      escapeHtml(title),
      escapeHtml(description),
      false,
      {
        canonical: canonicalUrl,
        ogUrl: canonicalUrl,
        extraHead
      }
    )
  )
}

function renderSampleHowtoDetailPage(
  c: Context<{ Bindings: Bindings; Variables: Variables }>,
  sample: NonNullable<ReturnType<typeof getSampleHowtoGuide>>
) {
  const authUser = c.get('user')  // User 타입 (id: number)
  const canonicalSlug = sample.meta?.canonicalSlug ?? sample.slug
  const canonicalPath = `/howto/${encodeURIComponent(canonicalSlug)}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
  const title = sample.meta?.title ?? `${sample.guide.title} - Careerwiki HowTo`
  const description = createMetaDescription(
    sample.meta?.description,
    sample.guide.summary,
    sample.snippet
  )
  const extraHead = [
    '<meta property="og:type" content="article">',
    createKeywordsMetaTag(sample.meta?.keywords),
    createArticleModifiedMeta(sample.meta?.updatedAt),
    createHowtoJsonLd(sample.guide, canonicalUrl)
  ].filter(Boolean).join('\n')

  // 샘플 데이터는 DB 페이지가 없으므로 편집 불가, 신고만 가능
  const content = renderHowtoGuideDetail(sample.guide, {
    currentUserId: authUser?.id ?? null,
    currentUserRole: authUser?.role ?? null,
    authorId: null,  // 샘플 데이터는 작성자 없음
    pageId: null,    // 샘플 데이터는 DB ID 없음
    isBlinded: false,
    blindReason: null
  })

  return c.html(
    renderLayoutWithContext(c,
      content,
      escapeHtml(title),
      escapeHtml(description),
      false,
      {
        canonical: canonicalUrl,
        ogUrl: canonicalUrl,
        extraHead
      }
    )
  )
}

function createHowtoJsonLd(
  guide: NonNullable<ReturnType<typeof getSampleHowtoGuide>>['guide'],
  canonicalUrl: string
): string {
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'HowTo',
    name: guide.title,
    description: guide.summary,
    url: canonicalUrl,
    totalTime: guide.estimatedDuration,
    difficulty: guide.difficulty,
    audience: guide.audience,
    supply: guide.prerequisites?.map((item) => ({
      '@type': 'HowToSupply',
      name: item
    })),
    tool: guide.resources?.map((resource) => ({
      '@type': 'HowToTool',
      name: resource.label,
      url: resource.url
    })),
    step: guide.steps?.map((step) => ({
      '@type': 'HowToStep',
      name: step.title,
      url: `${canonicalUrl}#${encodeURIComponent(step.id)}`,
      text: step.description,
      itemListElement: step.keyActions?.map((action) => ({
        '@type': 'HowToDirection',
        text: action
      }))
    }))
  }

  const script = JSON.stringify(jsonLd).replace(/</g, '\\u003C')
  return `<script type="application/ld+json">${script}</script>`
}

// Phase 3 Day 3: 기존 헤더 기반 인증을 JWT 기반으로 변경
// 기존 코드 호환을 위한 타입 유지
type RequestUser = {
  id: string
  role: UserRole
  name?: string | null
  username?: string | null
  picture_url?: string | null
  custom_picture_url?: string | null
}

/**
 * Phase 3 Day 3: 새로운 역할 시스템을 기존 댓글 시스템 역할로 매핑
 * 
 * 기존: 'super-admin' | 'operator' | 'user'
 * 신규: 'anonymous' | 'user' | 'expert' | 'admin'
 */
const mapRoleForComments = (newRole: string | null | undefined): UserRole => {
  if (!newRole || newRole === 'anonymous') {
    return 'user'  // 익명 유저도 댓글 작성 가능
  }
  
  switch (newRole) {
    case 'admin':
      return 'super-admin'
    case 'expert':
      return 'operator'
    case 'user':
    default:
      return 'user'
  }
}

/**
 * Phase 3 Day 3: authMiddleware에서 설정한 사용자 정보를 기존 형식으로 변환
 * 
 * Context에서 user를 가져와서 RequestUser 형식으로 반환
 * 로그인하지 않은 경우 null 반환 (익명 사용자)
 */
const getOptionalUser = (c: Context<{ Bindings: Bindings; Variables: Variables }>): RequestUser | null => {
  // authMiddleware에서 설정한 user 가져오기
  const user = c.get('user')
  
  if (!user) {
    return null  // 비로그인 사용자
  }
  
  return {
    id: user.id.toString(),
    role: mapRoleForComments(user.role),
    name: user.name,
    username: user.username,  // 편집 기록용 사용자 아이디
    picture_url: user.picture_url,
    custom_picture_url: user.custom_picture_url
  }
}

const maskIpForDisplay = (ip: string | null | undefined): string | null => {
  if (!ip) return null
  if (ip.includes(':')) {
    const segments = ip.split(':').filter(Boolean)
    const first = segments.slice(0, 2).join(':')
    return `${first}:`
  }
  const parts = ip.split('.')
  if (parts.length !== 4) {
    const a = parts[0] || '0'
    const b = parts[1] || '0'
    return `${a}.${b}.`
  }
  return `${parts[0]}.${parts[1]}.`
}

const toHex = (buffer: ArrayBuffer): string => {
  const bytes = new Uint8Array(buffer)
  return Array.from(bytes)
    .map((byte) => byte.toString(16).padStart(2, '0'))
    .join('')
}

const hashIpAddress = async (ip: string | null | undefined): Promise<string | null> => {
  if (!ip) return null
  const encoder = new TextEncoder()
  const digest = await crypto.subtle.digest('SHA-256', encoder.encode(ip))
  return toHex(digest)
}

const formatPerfAlertLine = (alert: PerfAlert): string => {
  const severityIcon = alert.severity === 'critical' ? '🚨' : '⚠️'
  const isScoreMetric = alert.metric.toLowerCase().includes('cls')
  const rounding = (value: number) => (isScoreMetric ? value.toFixed(2) : `${Math.round(value)}ms`)
  const contextParts: string[] = []
  if (alert.context?.page) {
    contextParts.push(`page=${alert.context.page}`)
  }
  if (alert.context?.action) {
    contextParts.push(`action=${alert.context.action}`)
  }
  if (alert.context?.category) {
    contextParts.push(`cat=${alert.context.category}`)
  }
  const contextSuffix = contextParts.length ? ` (${contextParts.join(' · ')})` : ''
  return `${severityIcon} ${alert.metric}: ${rounding(alert.value)} > ${rounding(alert.threshold)}${contextSuffix}`
}

const sendPerfAlertsToSlack = async (
  webhook: string,
  options: {
    alerts: PerfAlert[]
    url?: string
    reason?: string
    id: string
  }
): Promise<void> => {
  try {
    const header = options.reason ? `Perf alert (${options.reason})` : 'Perf alert detected'
    const urlLine = options.url ? `URL: ${options.url}` : null
    const lines = options.alerts.slice(0, 6).map((alert) => formatPerfAlertLine(alert))
    const bodyLines = [header, `Log ID: ${options.id}`, ...(urlLine ? [urlLine] : []), ...lines]
    const payload = { text: bodyLines.join('\n') }
    await fetch(webhook, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    })
  } catch (error) {
    console.error('[perf-alert] slack notification failed', error)
  }
}

// API 엔드포인트들

// 현재 로그인 사용자 정보 조회 (클라이언트에서 동적으로 확인용)
app.get('/api/me', async (c) => {
  const user = c.get('user')
  
  if (!user) {
    return c.json({ user: null })
  }
  
  return c.json({
    user: {
      id: user.id,
      name: user.name,
      username: user.username,
      role: user.role,
      pictureUrl: user.custom_picture_url || user.picture_url || null
    }
  })
})

app.post('/api/perf-metrics', async (c) => {
  let payload: PerfMetricsPayload
  try {
    payload = await c.req.json<PerfMetricsPayload>()
  } catch (error) {
    return c.json({ success: false, error: 'invalid json body' }, 400)
  }

  try {
    // 로컬 개발 환경에서는 KV가 없을 수 있음
    if (!c.env.KV) {
      console.warn('[perf-metrics] KV not available, skipping storage')
      return c.json({
        success: true,
        data: { id: 'local-dev-skip' },
        alerts: []
      })
    }

    const rawIp = c.req.header('cf-connecting-ip') ?? null
    const ipHash = await hashIpAddress(rawIp)
    const result = await storePerfMetrics(c.env.KV, payload, { ip: ipHash ?? undefined })

    if (result.alerts && result.alerts.length && c.env.PERF_ALERT_WEBHOOK) {
      c.executionCtx.waitUntil(
        sendPerfAlertsToSlack(c.env.PERF_ALERT_WEBHOOK, {
          alerts: result.alerts,
          url: payload.url,
          reason: payload.reason,
          id: result.id
        })
      )
    }

    return c.json({
      success: true,
      data: {
        id: result.id
      },
      alerts: result.alerts ?? []
    })
  } catch (error) {
    console.error('[perf-metrics] failed to store', error)
    return c.json({ success: false, error: 'failed to store metrics' }, 500)
  }
})

// Phase 3 Day 4: 클라이언트 IP 주소 반환 API
app.get('/api/client-ip', (c) => {
  const ipAddress = getClientIp(c)
  return c.json({ ip: ipAddress || '127.0.0.1' })
})

// Feedback APIs
app.post('/api/feedback', requireAuth, async (c) => {
  try {
    const user = c.get('user')
    const body = await c.req.json()
    const validation = validateFeedbackInput(body)
    if (!validation.ok) {
      return c.json({ success: false, error: validation.errors.join(' ') }, 400)
    }

    const isPrivate = Boolean(body?.is_private)

    const post = await createFeedback(c.env.DB, {
      userId: user!.id,
      title: validation.title,
      body: validation.body,
      type: validation.type,
      status: validation.status,
      isPrivate,
      linkUrl: validation.linkUrl,
    })
    return c.json({ success: true, data: post })
  } catch (error) {
    console.error('[feedback] create error', error)
    return c.json({ success: false, error: 'failed_to_create' }, 500)
  }
})

app.get('/api/feedback', async (c) => {
  try {
    const user = c.get('user')
    const isAdmin = isAdminRole(user?.role)
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const pageSize = parseNumberParam(c.req.query('pageSize'), 20, { min: 1, max: 50 })
    const typeParam = c.req.query('type') || undefined
    const statusParam = c.req.query('status') || undefined

    const type =
      typeParam && ['bug', 'suggestion', 'question', 'other'].includes(typeParam)
        ? (typeParam as any)
        : undefined
    const status =
      statusParam && ['open', 'closed'].includes(statusParam)
        ? (statusParam as any)
        : undefined

    const result = await listFeedback(c.env.DB, {
      page,
      pageSize,
      type,
      status,
      includePrivate: isAdmin,
    })
    return c.json({ success: true, data: result.items, total: result.total, page, pageSize })
  } catch (error) {
    console.error('[feedback] list error', error)
    return c.json({ success: false, error: 'failed_to_list' }, 500)
  }
})

app.get('/api/feedback/:id', async (c) => {
  try {
    const user = c.get('user')
    const isAdmin = isAdminRole(user?.role)
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)

    const item = await getFeedbackById(c.env.DB, id, { includePrivate: isAdmin })
    if (!item) return c.json({ success: false, error: 'not_found' }, 404)

    if (item.is_private && !isAdmin) {
      return c.json({ success: false, error: 'not_found' }, 404)
    }

    return c.json({ success: true, data: item })
  } catch (error) {
    console.error('[feedback] detail error', error)
    return c.json({ success: false, error: 'failed_to_get' }, 500)
  }
})

app.post('/api/feedback/:id/reply', requireAdmin, async (c) => {
  try {
    const admin = c.get('user')!
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const body = await c.req.json()
    const replyBody = (body?.body || '').trim()
    if (replyBody.length < 3 || replyBody.length > 4000) {
      return c.json({ success: false, error: '답변은 3~4000자여야 합니다.' }, 400)
    }
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)

    const updated = await upsertReply(c.env.DB, {
      postId: id,
      adminId: admin.id,
      body: replyBody,
    })
    return c.json({ success: true, data: updated })
  } catch (error) {
    console.error('[feedback] reply upsert error', error)
    return c.json({ success: false, error: 'failed_to_save_reply' }, 500)
  }
})

app.put('/api/feedback/:id/reply', requireAdmin, async (c) => {
  try {
    const admin = c.get('user')!
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const body = await c.req.json()
    const replyBody = (body?.body || '').trim()
    if (replyBody.length < 3 || replyBody.length > 4000) {
      return c.json({ success: false, error: '답변은 3~4000자여야 합니다.' }, 400)
    }
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)

    const updated = await upsertReply(c.env.DB, {
      postId: id,
      adminId: admin.id,
      body: replyBody,
    })
    return c.json({ success: true, data: updated })
  } catch (error) {
    console.error('[feedback] reply update error', error)
    return c.json({ success: false, error: 'failed_to_save_reply' }, 500)
  }
})

app.delete('/api/feedback/:id/reply', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)
    await deleteReply(c.env.DB, id)
    return c.json({ success: true })
  } catch (error) {
    console.error('[feedback] reply delete error', error)
    return c.json({ success: false, error: 'failed_to_delete_reply' }, 500)
  }
})

// 관리자용 피드백 삭제
app.delete('/api/admin/feedback/:id', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)
    await deleteFeedback(c.env.DB, id)
    return c.json({ success: true })
  } catch (error) {
    console.error('[feedback] delete error', error)
    return c.json({ success: false, error: 'failed_to_delete' }, 500)
  }
})

// 피드백 댓글 추가 (스레드)
app.post('/api/feedback/:id/comments', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const postId = Number(c.req.param('id'))
    if (!Number.isFinite(postId)) return c.json({ success: false, error: 'invalid_id' }, 400)

    const feedback = await getFeedbackById(c.env.DB, postId, { includePrivate: true })
    if (!feedback) return c.json({ success: false, error: 'not_found' }, 404)

    // 종료된 피드백에는 댓글 불가
    if (feedback.status === 'closed') {
      return c.json({ success: false, error: 'feedback_closed' }, 400)
    }

    // 비공개 피드백은 작성자 또는 관리자만 댓글 가능
    const isAdmin = isAdminRole(user.role)
    if (feedback.is_private && !isAdmin && user.id !== feedback.user_id) {
      return c.json({ success: false, error: 'not_authorized' }, 403)
    }

    const { body } = await c.req.json()
    if (!body || typeof body !== 'string' || body.trim().length < 3 || body.trim().length > 2000) {
      return c.json({ success: false, error: 'invalid_body' }, 400)
    }

    const comment = await addComment(c.env.DB, {
      postId,
      userId: user.id,
      isAdmin: Boolean(isAdmin),
      body: body.trim(),
    })

    return c.json({ success: true, data: comment })
  } catch (error) {
    console.error('[feedback] add comment error', error)
    return c.json({ success: false, error: 'failed_to_add_comment' }, 500)
  }
})

// 피드백 댓글 삭제
app.delete('/api/feedback/comments/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const commentId = Number(c.req.param('id'))
    if (!Number.isFinite(commentId)) return c.json({ success: false, error: 'invalid_id' }, 400)

    const comment = await getCommentById(c.env.DB, commentId)
    if (!comment) return c.json({ success: false, error: 'not_found' }, 404)

    // 본인 댓글 또는 관리자만 삭제 가능
    const isAdmin = isAdminRole(user.role)
    if (!isAdmin && comment.user_id !== user.id) {
      return c.json({ success: false, error: 'not_authorized' }, 403)
    }

    await deleteFeedbackComment(c.env.DB, commentId)
    return c.json({ success: true })
  } catch (error) {
    console.error('[feedback] delete comment error', error)
    return c.json({ success: false, error: 'failed_to_delete_comment' }, 500)
  }
})

app.patch('/api/feedback/:id/visibility', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const body = await c.req.json()
    const isPrivate = Boolean(body?.is_private)
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)
    const updated = await setVisibility(c.env.DB, id, isPrivate)
    return c.json({ success: true, data: updated })
  } catch (error) {
    console.error('[feedback] visibility error', error)
    return c.json({ success: false, error: 'failed_to_update_visibility' }, 500)
  }
})

app.get('/api/comments', async (c) => {
  const entityTypeRaw = c.req.query('entityType')
  const slugRaw = c.req.query('slug')

  if (!isPageType(entityTypeRaw)) {
    return c.json({ success: false, error: 'entityType must be job, major, or guide' }, 400)
  }

  if (!slugRaw || !slugRaw.trim()) {
    return c.json({ success: false, error: 'slug is required' }, 400)
  }

  const slug = slugRaw.trim()
  const limit = parseNumberParam(c.req.query('limit'), 50, { min: 1, max: 50 })
  const titleParam = c.req.query('title')
  const summaryParam = c.req.query('summary')
  const title = typeof titleParam === 'string' && titleParam.trim().length ? titleParam.trim() : slug
  const summary = typeof summaryParam === 'string' && summaryParam.trim().length ? summaryParam.trim().slice(0, 400) : null
  const viewer = getOptionalUser(c)
  const rawIp = getClientIp(c)
  const ipHash = await hashIpAddress(rawIp)

  try {
    const result = await getCommentsBySlug(c.env.DB, {
      slug: buildCommentPageSlug(entityTypeRaw, slug),
      pageType: entityTypeRaw,
      title,
      summary,
      limit,
      viewerId: viewer?.id ?? null,
      viewerRole: viewer?.role ?? 'user',
      includeModerated: viewer ? viewer.role !== 'user' : false,
      ipHash
    })

    return c.json({
      success: true,
      data: result.comments,
      meta: {
        total: result.totalCount,
        page: {
          id: result.page.id,
          slug: result.page.slug,
          title: result.page.title,
          pageType: result.page.page_type,
          summary: result.page.summary
        },
        viewer: viewer ? { id: viewer.id, name: viewer.name, username: viewer.username, role: viewer.role, pictureUrl: viewer.custom_picture_url || viewer.picture_url || null } : null,
        viewerIp: maskIpForDisplay(rawIp),
        policy: result.policy,
        bestThreshold: result.policy.bestLikeThreshold,
        bestLimit: result.policy.bestLimit,
        reportBlindThreshold: result.policy.reportBlindThreshold,
        nextAnonymousNumber: result.nextAnonymousNumber ?? null
      }
    })
  } catch (error) {
    console.error('[comments:list] failed', error)
    return c.json({ success: false, error: 'failed to load comments' }, 500)
  }
})

app.post('/api/comments', async (c) => {
  let body: any
  try {
    body = await c.req.json()
  } catch {
    return c.json({ success: false, error: 'invalid json body' }, 400)
  }

  const entityType = body?.entityType
  const slugRaw = typeof body?.slug === 'string' ? body.slug : ''
  const contentRaw = typeof body?.content === 'string' ? body.content : ''
  const title = typeof body?.title === 'string' && body.title.trim().length ? body.title.trim() : slugRaw.trim()
  const summary = typeof body?.summary === 'string' && body.summary.trim().length ? body.summary.trim().slice(0, 400) : null
  const parentId = toParentId(body?.parentId)

  if (!isPageType(entityType)) {
    return c.json({ success: false, error: 'entityType must be job, major, or guide' }, 400)
  }

  if (!slugRaw || !slugRaw.trim()) {
    return c.json({ success: false, error: 'slug is required' }, 400)
  }

  if (!contentRaw || !contentRaw.trim()) {
    return c.json({ success: false, error: 'content is required' }, 400)
  }

  // Phase 3 Day 3: 익명 사용자도 댓글 작성 가능
  const user = getOptionalUser(c)
  
  const slug = slugRaw.trim()
  const ipAddress = getClientIp(c)
  const ipHash = await hashIpAddress(ipAddress)

  if (await isIpBlocked(c.env.DB, ipHash)) {
    return c.json({ success: false, error: 'commenting temporarily restricted' }, 403)
  }

  const anonymousRequested = Boolean(body?.anonymous)
  const nicknameRaw = typeof body?.nickname === 'string' ? body.nickname : null
  
  // 익명 사용자는 닉네임 입력하지 않음 (익명 번호는 서버에서 자동 배정)
  // 로그인 사용자가 익명으로 작성하는 경우에만 nicknameRaw 사용
  const nickname = anonymousRequested && user
    ? nicknameRaw  // 로그인 사용자가 익명으로 작성하는 경우
    : (user
        ? (nicknameRaw
            ?? user?.username
            ?? (user?.id ? String(user.id) : null))
        : null)  // 로그인 사용자는 닉네임 입력값 → username → id 순서 사용, 익명 사용자는 null
  const displayIp = (anonymousRequested || !user) ? maskIpForDisplay(ipAddress) : null

  try {
    const comment = await createComment(c.env.DB, {
      slug: buildCommentPageSlug(entityType, slug),
      pageType: entityType,
      title: title || slug,
      summary,
      content: contentRaw,
      nickname: nickname,  // 익명 사용자는 null (익명 번호는 서버에서 자동 배정)
      parentId,
      authorId: user?.id ?? null,  // 익명 사용자는 null
      isAnonymous: anonymousRequested || !user,  // 로그인 안 했으면 익명으로 처리
      ipHash,
      displayIp,
      password: body?.password || null  // 익명 사용자는 비밀번호 필요
    })

    return c.json({ success: true, data: { ...comment, authorRole: user?.role ?? null } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'COMMENT_ERROR'
    if (message === 'EMPTY_CONTENT') {
      return c.json({ success: false, error: 'content is required' }, 400)
    }
    if (message === 'INVALID_PARENT') {
      return c.json({ success: false, error: 'invalid parentId' }, 400)
    }
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'AUTHOR_REQUIRED') {
      return c.json({ success: false, error: 'authentication required' }, 401)
    }
    console.error('[comments:create] failed', error)
    return c.json({ success: false, error: 'failed to create comment' }, 500)
  }
})

app.post('/api/comments/:id/like', async (c) => {
  const commentId = Number(c.req.param('id'))
  if (!Number.isFinite(commentId) || commentId <= 0) {
    return c.json({ success: false, error: 'invalid comment id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const user = getOptionalUser(c)
  const rawIp = getClientIp(c)
  const ipHash = await hashIpAddress(rawIp)
  const voterId = user?.id ?? (ipHash ? `ip:${ipHash}` : null)
  if (!voterId) {
    return c.json({ success: false, error: 'authentication required' }, 401)
  }

  const directionRaw = typeof body?.direction === 'string' ? body.direction.toLowerCase() : 'up'
  const direction = directionRaw === 'down' || directionRaw === 'dislike'
    ? 'down'
    : directionRaw === 'clear' || directionRaw === 'remove'
      ? 'clear'
      : 'up'

  try {
    const comment = await setCommentVote(c.env.DB, {
      commentId,
      userId: voterId,
      direction
    })
    if (!comment) {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    return c.json({ success: true, data: { ...comment, authorRole: user?.role ?? null } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to update like state'
    if (message === 'USER_REQUIRED') {
      return c.json({ success: false, error: 'authentication required' }, 401)
    }
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'SELF_VOTE_NOT_ALLOWED') {
      return c.json({ success: false, error: 'authors cannot vote on their own comments' }, 403)
    }
    if (message === 'VOTE_LIMIT_REACHED') {
      return c.json({ success: false, error: 'vote limit reached' }, 429)
    }
    console.error('[comments:like] failed', error)
    return c.json({ success: false, error: 'failed to update like state' }, 500)
  }
})

app.patch('/api/comments/:id', async (c) => {
  const commentId = Number(c.req.param('id'))
  if (!Number.isFinite(commentId) || commentId <= 0) {
    return c.json({ success: false, error: 'invalid comment id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    return c.json({ success: false, error: 'invalid json body' }, 400)
  }

  const contentRaw = typeof body?.content === 'string' ? body.content : ''
  if (!contentRaw || !contentRaw.trim()) {
    return c.json({ success: false, error: 'content is required' }, 400)
  }

  const user = getOptionalUser(c)
  const passwordRaw = typeof body?.password === 'string' ? body.password : null

  try {
    const comment = await updateComment(c.env.DB, {
      commentId,
      content: contentRaw,
      userId: user?.id ?? null,
      password: passwordRaw ?? null,
      userRole: user?.role as 'user' | 'expert' | 'admin' | null ?? null
    })
    return c.json({ success: true, data: comment })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'COMMENT_ERROR'
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'UNAUTHORIZED') {
      return c.json({ success: false, error: 'unauthorized' }, 403)
    }
    if (message === 'PASSWORD_REQUIRED') {
      return c.json({ success: false, error: 'password is required for anonymous comments' }, 400)
    }
    if (message === 'INVALID_PASSWORD') {
      return c.json({ success: false, error: 'invalid password' }, 403)
    }
    if (message === 'EMPTY_CONTENT') {
      return c.json({ success: false, error: 'content is required' }, 400)
    }
    console.error('[comments:update] failed', error)
    return c.json({ success: false, error: 'failed to update comment' }, 500)
  }
})

app.delete('/api/comments/:id', async (c) => {
  const commentId = Number(c.req.param('id'))
  if (!Number.isFinite(commentId) || commentId <= 0) {
    return c.json({ success: false, error: 'invalid comment id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json().catch(() => ({}))
  } catch {
    body = {}
  }

  const user = getOptionalUser(c)
  const passwordRaw = typeof body?.password === 'string' ? body.password : null

  try {
    const success = await deleteComment(c.env.DB, {
      commentId,
      userId: user?.id ?? null,
      password: passwordRaw ?? null,
      userRole: user?.role as 'user' | 'expert' | 'admin' | 'super-admin' | 'operator' | null ?? null
    })
    if (!success) {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    return c.json({ success: true })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'COMMENT_ERROR'
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'UNAUTHORIZED') {
      return c.json({ success: false, error: 'unauthorized' }, 403)
    }
    if (message === 'PASSWORD_REQUIRED') {
      return c.json({ success: false, error: 'password is required for anonymous comments' }, 400)
    }
    if (message === 'INVALID_PASSWORD') {
      return c.json({ success: false, error: 'invalid password' }, 403)
    }
    console.error('[comments:delete] failed', error)
    return c.json({ success: false, error: 'failed to delete comment' }, 500)
  }
})

app.post('/api/comments/:id/flag', async (c) => {
  const commentId = Number(c.req.param('id'))
  if (!Number.isFinite(commentId) || commentId <= 0) {
    return c.json({ success: false, error: 'invalid comment id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const user = getOptionalUser(c)
  if (!user) {
    return c.json({ success: false, error: 'authentication required' }, 401)
  }

  const ipAddress = c.req.header('cf-connecting-ip') ?? null
  const ipHash = await hashIpAddress(ipAddress)

  try {
    const comment = await reportComment(c.env.DB, {
      commentId,
      reporterId: user.id,
      reporterIpHash: ipHash,
      reason: typeof body?.reason === 'string' ? body.reason.slice(0, 200) : null
    })
    if (!comment) {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    return c.json({
      success: true,
      data: {
        ...comment,
        blinded: comment.status !== 'visible'
      }
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to flag comment'
    if (message === 'REPORTER_REQUIRED') {
      return c.json({ success: false, error: 'authentication required' }, 401)
    }
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'REPORT_ALREADY_FILED') {
      return c.json({ success: false, error: 'duplicate report not allowed' }, 409)
    }
    console.error('[comments:flag] failed', error)
    return c.json({ success: false, error: 'failed to flag comment' }, 500)
  }
})

app.get('/api/comments/ip-blocks', async (c) => {
  const user = getOptionalUser(c)
  if (!user || user.role === 'user') {
    return c.json({ success: false, error: 'moderator access required' }, 403)
  }

  const includeReleased = c.req.query('includeReleased') === '1'

  try {
    const records = await listIpBlocks(c.env.DB, { includeReleased })
    return c.json({ success: true, data: records })
  } catch (error) {
    console.error('[comments:ip-blocks:list] failed', error)
    return c.json({ success: false, error: 'failed to list ip blocks' }, 500)
  }
})

app.post('/api/comments/ip-blocks', async (c) => {
  const user = getOptionalUser(c)
  if (!user || user.role === 'user') {
    return c.json({ success: false, error: 'moderator access required' }, 403)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const ipHashRaw = typeof body?.ipHash === 'string' ? body.ipHash.trim() : ''
  const ipRaw = typeof body?.ip === 'string' ? body.ip.trim() : ''
  const ipHash = ipHashRaw || (await hashIpAddress(ipRaw))

  if (!ipHash) {
    return c.json({ success: false, error: 'ip or ipHash is required' }, 400)
  }

  try {
    const record = await blockIpAddress(c.env.DB, {
      ipHash,
      reason: typeof body?.reason === 'string' ? body.reason : null,
      blockedBy: user.id
    })
    return c.json({ success: true, data: record })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to block ip'
    if (message === 'IP_ALREADY_BLOCKED') {
      return c.json({ success: false, error: 'ip already blocked' }, 409)
    }
    if (message === 'IP_HASH_REQUIRED') {
      return c.json({ success: false, error: 'ipHash required' }, 400)
    }
    if (message === 'BLOCK_ACTOR_REQUIRED') {
      return c.json({ success: false, error: 'moderator identifier required' }, 400)
    }
    console.error('[comments:ip-blocks:block] failed', error)
    return c.json({ success: false, error: 'failed to block ip' }, 500)
  }
})

app.post('/api/comments/ip-blocks/:hash/release', async (c) => {
  const user = getOptionalUser(c)
  if (!user || user.role === 'user') {
    return c.json({ success: false, error: 'moderator access required' }, 403)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const hashParam = c.req.param('hash')
  const ipHash = typeof hashParam === 'string' ? hashParam.trim() : ''

  if (!ipHash) {
    return c.json({ success: false, error: 'ip hash required' }, 400)
  }

  try {
    const record = await releaseIpAddress(c.env.DB, {
      ipHash,
      releasedBy: user.id,
      reason: typeof body?.reason === 'string' ? body.reason : null
    })

    if (!record) {
      return c.json({ success: false, error: 'ip block not found' }, 404)
    }

    return c.json({ success: true, data: record })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to release ip block'
    if (message === 'IP_HASH_REQUIRED') {
      return c.json({ success: false, error: 'ip hash required' }, 400)
    }
    if (message === 'RELEASE_ACTOR_REQUIRED') {
      return c.json({ success: false, error: 'moderator identifier required' }, 400)
    }
    console.error('[comments:ip-blocks:release] failed', error)
    return c.json({ success: false, error: 'failed to release ip block' }, 500)
  }
})

app.post('/api/perf-metrics', async (c) => {
  let body: PerfMetricsPayload
  try {
    body = await c.req.json<PerfMetricsPayload>()
  } catch (error) {
    return c.json({ success: false, error: 'invalid json body' }, 400)
  }

  try {
    // 로컬 개발 환경에서는 KV가 없을 수 있음
    if (!c.env.KV) {
      console.warn('[perf-metrics] KV not available, skipping storage')
      return c.json({ success: true, id: 'local-dev-skip' })
    }

    const ip = c.req.header('cf-connecting-ip') ?? undefined
    const { id } = await storePerfMetrics(c.env.KV, body, { ip })
    return c.json({ success: true, id })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'perf metrics store failed'
    const status = message === 'Invalid payload' || message === 'No metrics provided' ? 400 : 500
    return c.json({ success: false, error: message }, status)
  }
})

app.post('/api/analyzer/sessions', async (c) => {
  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  if (!body || typeof body !== 'object') {
    return c.json({ success: false, error: 'invalid body' }, 400)
  }

  try {
    const session = await createOrUpdateSession(c.env.DB, {
      sessionId: typeof body.sessionId === 'string' ? body.sessionId : undefined,
      userIdentifier: typeof body.userIdentifier === 'string' ? body.userIdentifier : undefined,
      traitsSnapshot: body.traits ?? body.traitsSnapshot
    })

    const includeRequests = Boolean(body.includeRequests)
    const response: Record<string, unknown> = { session }

    if (includeRequests) {
      const limitInput = typeof body.requestLimit === 'number' ? Math.floor(body.requestLimit) : 10
      const limit = Number.isFinite(limitInput) ? Math.min(Math.max(limitInput, 1), 100) : 10
      const requests = await listRequestsBySession(c.env.DB, session.id, limit)
      response.requests = requests
    }

    return c.json({ success: true, data: response })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'session upsert failed'
    return c.json({ success: false, error: message }, 500)
  }
})

app.get('/api/analyzer/sessions/:id', async (c) => {
  const sessionId = c.req.param('id')
  const includeRequests = c.req.query('includeRequests') === '1'
  const limit = parseNumberParam(c.req.query('limit'), 20, { min: 1, max: 50 })

  const session = await getAiSession(c.env.DB, sessionId)
  if (!session) {
    return c.json({ success: false, error: 'session not found' }, 404)
  }

  const result: Record<string, unknown> = { session }
  if (includeRequests) {
    const requests = await listRequestsBySession(c.env.DB, sessionId, limit)
    result.requests = requests
  }

  return c.json({ success: true, data: result })
})

app.post('/api/analyzer/requests', async (c) => {
  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const sessionId = typeof body.sessionId === 'string' ? body.sessionId : ''
  const analysisType = body.analysisType
  const promptPayload = body.promptPayload

  if (!sessionId) {
    return c.json({ success: false, error: 'sessionId is required' }, 400)
  }

  if (!isAnalysisType(analysisType)) {
    return c.json({ success: false, error: 'analysisType must be "job" or "major"' }, 400)
  }

  if (promptPayload === undefined) {
    return c.json({ success: false, error: 'promptPayload is required' }, 400)
  }

  const session = await getAiSession(c.env.DB, sessionId)
  if (!session) {
    return c.json({ success: false, error: 'session not found' }, 404)
  }

  const pricingTier = isPricingTier(body.pricingTier) ? body.pricingTier : 'free'
  const initialStatus = isRequestStatus(body.status) ? body.status : 'pending'

  try {
    const request = await createAnalysisRequest(c.env.DB, {
      sessionId,
      analysisType,
      pricingTier,
      promptPayload,
      status: initialStatus
    })

    return c.json({ success: true, data: { request } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to create analysis request'
    return c.json({ success: false, error: message }, 500)
  }
})

app.get('/api/analyzer/requests/:id', async (c) => {
  const requestId = Number(c.req.param('id'))
  if (Number.isNaN(requestId)) {
    return c.json({ success: false, error: 'invalid request id' }, 400)
  }

  const record = await getAnalysisRequestWithResult(c.env.DB, requestId)
  if (!record) {
    return c.json({ success: false, error: 'request not found' }, 404)
  }

  return c.json({ success: true, data: record })
})

app.post('/api/analyzer/requests/:id/result', async (c) => {
  const requestId = Number(c.req.param('id'))
  if (Number.isNaN(requestId)) {
    return c.json({ success: false, error: 'invalid request id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  if (typeof body.provider !== 'string' || !body.provider) {
    return c.json({ success: false, error: 'provider is required' }, 400)
  }

  if (body.responsePayload === undefined) {
    return c.json({ success: false, error: 'responsePayload is required' }, 400)
  }

  const requestStatus = body.requestStatus
  if (requestStatus !== undefined && !isRequestStatus(requestStatus)) {
    return c.json({ success: false, error: 'invalid requestStatus' }, 400)
  }

  try {
    const { request, result } = await createAnalysisResult(c.env.DB, {
      requestId,
      provider: body.provider,
      model: typeof body.model === 'string' ? body.model : null,
      completionTokens: typeof body.completionTokens === 'number' ? body.completionTokens : null,
      promptTokens: typeof body.promptTokens === 'number' ? body.promptTokens : null,
      totalTokens: typeof body.totalTokens === 'number' ? body.totalTokens : null,
      latencyMs: typeof body.latencyMs === 'number' ? body.latencyMs : null,
      responseSummary: typeof body.responseSummary === 'string' ? body.responseSummary : null,
      responsePayload: body.responsePayload,
      requestStatus
    })

    return c.json({ success: true, data: { request, result } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to store analysis result'
    return c.json({ success: false, error: message }, 500)
  }
})

app.post('/api/analyzer/requests/:id/status', async (c) => {
  const requestId = Number(c.req.param('id'))
  if (Number.isNaN(requestId)) {
    return c.json({ success: false, error: 'invalid request id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  if (!isRequestStatus(body.status)) {
    return c.json({ success: false, error: 'invalid status' }, 400)
  }

  const processedAt = typeof body.processedAt === 'string'
    ? body.processedAt
    : (body.status === 'completed' || body.status === 'failed' ? new Date().toISOString() : null)

  try {
    const request = await updateRequestStatus(c.env.DB, requestId, body.status, processedAt)
    return c.json({ success: true, data: { request } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to update status'
    return c.json({ success: false, error: message }, 500)
  }
})

app.get('/api/analyzer/sessions/:id/requests', async (c) => {
  const sessionId = c.req.param('id')
  const limit = parseNumberParam(c.req.query('limit'), 20, { min: 1, max: 50 })
  const requests = await listRequestsBySession(c.env.DB, sessionId, limit)
  return c.json({ success: true, data: { requests } })
})

app.post('/api/serp-interactions', async (c) => {
  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  if (!isAnalysisType(body.pageType)) {
    return c.json({ success: false, error: 'pageType must be "job" or "major"' }, 400)
  }

  if (typeof body.action !== 'string' || !body.action.trim()) {
    return c.json({ success: false, error: 'action is required' }, 400)
  }

  try {
    const record = await recordSerpInteraction(c.env.DB, {
      pageType: body.pageType,
      action: body.action,
      keywordLength: toIntegerOrNull(body.keywordLength, { min: 0 }),
      category: typeof body.category === 'string' ? body.category : null,
      perPage: toIntegerOrNull(body.perPage, { min: 1, max: 50 }),
      results: toIntegerOrNull(body.results, { min: 0, max: 500 }),
      cacheStatus: typeof body.cacheStatus === 'string' ? body.cacheStatus : null,
      durationMs: toIntegerOrNull(body.durationMs, { min: 0 }),
      sampled: typeof body.sampled === 'boolean' ? body.sampled : null,
      source: typeof body.source === 'string' ? body.source : null
    })

    return c.json({ success: true, data: { record } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to record interaction'
    return c.json({ success: false, error: message }, 500)
  }
})

app.get('/api/serp-interactions/recent', async (c) => {
  const limit = parseNumberParam(c.req.query('limit'), 50, { min: 1, max: 200 })
  const records = await listRecentSerpInteractions(c.env.DB, limit)
  return c.json({ success: true, data: { records } })
})

app.get('/api/serp-interactions/summary', async (c) => {
  const startDate = c.req.query('startDate') || undefined
  const endDate = c.req.query('endDate') || undefined
  const pageType = c.req.query('pageType') as ('job' | 'major') | undefined
  const action = c.req.query('action') || undefined
  const limit = parseNumberParam(c.req.query('limit'), 50, { min: 1, max: 200 })

  const summaries = await getDailySerpSummary(c.env.DB, {
    startDate,
    endDate,
    pageType,
    action,
    limit
  })

  return c.json({ success: true, data: { summaries } })
})

app.get('/api/freshness/status', async (c) => {
  try {
    const status = await getFreshnessStatus(c.env.KV)
    return c.json({
      success: true,
      data: status
    })
  } catch (error) {
    return c.json(
      {
        success: false,
        error: error instanceof Error ? error.message : 'freshness status fetch failed'
      },
      500
    )
  }
})

app.post('/api/freshness/run', async (c) => {
  try {
    let body: { targetId?: string; force?: boolean; reason?: string } = {}
    try {
      body = await c.req.json<{ targetId?: string; force?: boolean; reason?: string }>()
    } catch {
      body = {}
    }

    const targetId = body.targetId || c.req.query('targetId')
    if (!targetId) {
      return c.json({ success: false, error: 'targetId required' }, 400)
    }

    const target = resolveFreshnessTargetById(targetId)
    if (!target) {
      return c.json({ success: false, error: 'unknown targetId' }, 404)
    }

    const result = await attemptScheduledRefresh(c.env.KV, c.env, target, {
      force: body.force ?? c.req.query('force') === '1',
      reason: body.reason || 'manual-trigger'
    })

    return c.json({
      success: result.outcome === 'success',
      result
    })
  } catch (error) {
    return c.json(
      {
        success: false,
        error: error instanceof Error ? error.message : 'freshness run failed'
      },
      500
    )
  }
})

// 학과정보 검색 API
app.get('/api/majors', async (c) => {
  try {
    const mark = c.get('mark') as ((k: string) => void) | undefined
    mark?.('parse-query')
    const keyword = c.req.query('keyword') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 8, { min: 1, max: 50 })
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const dataVersion = 'v1'
    const seed = `${TEMPLATE_VERSIONS.MAJOR}:${dataVersion}:${toNFC(keyword)}:${page}:${perPage}`
    const etag = weakETag(seed)
    const inm = c.req.header('If-None-Match')
    const hasMatch = matchETag(inm, etag)
    if (hasMatch) {
      c.header('ETag', etag)
      c.header('Cache-Control', 'public, max-age=60, stale-while-revalidate=30')
      c.header('X-Cache-Status', 'HIT')
      return c.body(null, 304)
    }

    mark?.('build-sql')
    const result = await searchUnifiedMajors({
      keyword,
      page,
      perPage,
      includeSources
    }, c.env)
    mark?.('db-read')

    mark?.('post-filter')
    mark?.('serialize')
    // logging removed per request
    c.header('ETag', etag)
    c.header('Cache-Control', 'public, max-age=60, stale-while-revalidate=30')
    return c.json({
      success: true,
      data: result.items,
      meta: {
        ...result.meta,
        keyword,
        page,
        perPage
      }
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '학과 정보 검색 실패'
    }, 500)
  }
})

// 학과 검색 API (별도 엔드포인트) - :id 라우트보다 먼저 정의해야 함
app.get('/api/majors/search', async (c) => {
  try {
    const q = c.req.query('q') || c.req.query('keyword') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 50 })
    const sort = c.req.query('sort') || 'relevance'
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const result = await searchUnifiedMajors({
      keyword: q,
      page,
      perPage,
      sort,
      includeSources
    }, c.env)

    return c.json({
      success: true,
      data: result.items,
      meta: {
        ...result.meta,
        keyword: q,
        page,
        perPage
      }
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '학과 정보 검색 실패'
    }, 500)
  }
})

// 학과 상세 정보 API
app.get('/api/majors/:id', async (c) => {
  try {
    const id = c.req.param('id')
    let userContributedJson: any = {}
    const careernetId = c.req.query('careernetId') || undefined
    const goyongMajorGb = c.req.query('goyongMajorGb') as ('1' | '2') | undefined
    const goyongDepartmentId = c.req.query('goyongDepartmentId') || undefined
    const goyongMajorId = c.req.query('goyongMajorId') || undefined
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const goyongParams = goyongMajorGb && goyongDepartmentId && goyongMajorId
      ? {
          majorGb: goyongMajorGb as '1' | '2',
          departmentId: goyongDepartmentId,
          majorId: goyongMajorId
        }
      : undefined

    const result = await getUnifiedMajorDetail(
      {
        id,
        careernetId,
        goyong24Params: goyongParams,
        includeSources
      },
      c.env
    )

    if (!result.profile) {
      return c.json({
        success: false,
        error: '학과 정보를 찾을 수 없습니다.',
        sources: result.sources
      }, 404)
    }

    return c.json({
      success: true,
      data: result.profile,
      partials: result.partials,
      sources: result.sources
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '학과 정보 조회 실패'
    }, 500)
  }
})

// 직업정보 검색 API
app.get('/api/jobs', async (c) => {
  try {
    const mark = c.get('mark') as ((k: string) => void) | undefined
    mark?.('parse-query')
    const keyword = c.req.query('keyword') || ''
    const category = c.req.query('category') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 8, { min: 1, max: 50 })
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const dataVersion = 'v1'
    const seed = `${TEMPLATE_VERSIONS.JOB}:${dataVersion}:${toNFC(keyword)}:${page}:${perPage}:${category}`
    const etag = weakETag(seed)
    const inm = c.req.header('If-None-Match')
    const hasMatch = matchETag(inm, etag)
    if (hasMatch) {
      c.header('ETag', etag)
      c.header('Cache-Control', 'public, max-age=60, stale-while-revalidate=30')
      c.header('X-Cache-Status', 'HIT')
      return c.body(null, 304)
    }

    mark?.('build-sql')
    const result = await searchUnifiedJobs({
      keyword,
      category,
      page,
      perPage,
      includeSources
    }, c.env)
    mark?.('db-read')

    mark?.('post-filter')
    mark?.('serialize')
    // logging removed per request
    c.header('ETag', etag)
    c.header('Cache-Control', 'public, max-age=60, stale-while-revalidate=30')
    return c.json({
      success: true,
      data: result.items,
      meta: {
        ...result.meta,
        keyword,
        category,
        page,
        perPage
      },
      categories: JOB_CATEGORIES
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '직업 정보 검색 실패'
    }, 500)
  }
})

// 직업 검색 API (별도 엔드포인트) - :id 라우트보다 먼저 정의해야 함
app.get('/api/jobs/search', async (c) => {
  try {
    const q = c.req.query('q') || c.req.query('keyword') || ''
    const category = c.req.query('category') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 50 })
    const sort = c.req.query('sort') || 'relevance'
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const result = await searchUnifiedJobs({
      keyword: q,
      category,
      page,
      perPage,
      sort,
      includeSources
    }, c.env)

    return c.json({
      success: true,
      data: result.items,
      meta: {
        ...result.meta,
        keyword: q,
        category,
        page,
        perPage
      },
      categories: JOB_CATEGORIES
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '직업 정보 검색 실패'
    }, 500)
  }
})

// 직업 상세 정보 API
app.get('/api/jobs/:id', async (c) => {
  try {
    const id = c.req.param('id')
    const careernetId = c.req.query('careernetId') || undefined
    const goyongJobId = c.req.query('goyongJobId') || undefined
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const result = await getUnifiedJobDetail(
      {
        id,
        careernetId,
        goyong24JobId: goyongJobId || undefined,
        includeSources
      },
      c.env
    )

    if (!result.profile) {
      return c.json({
        success: false,
        error: '직업 정보를 찾을 수 없습니다.',
        sources: result.sources
      }, 404)
    }

    return c.json({
      success: true,
      data: result.profile,
      partials: result.partials,
      sources: result.sources
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '직업 정보 조회 실패'
    }, 500)
  }
})

// 편집 모드용 데이터 조회 API (실제 렌더링에 사용되는 데이터 반환)
app.get('/api/job/:id/edit-data', async (c) => {
  try {
    // 캐시 방지 (편집 직후 최신 데이터 보장)
    c.header('Cache-Control', 'no-store')
    c.header('Pragma', 'no-cache')
    c.header('Expires', '0')

    const id = c.req.param('id')
    let userContributedJson: any = {}
    
    const result = await getUnifiedJobDetailWithRawData(
      {
        id,
        careernetId: undefined,
        goyong24JobId: undefined,
        includeSources: ['CAREERNET', 'GOYONG24']
      },
      c.env
    )

    if (!result.profile) {
      return c.json({
        success: false,
        error: '직업 정보를 찾을 수 없습니다.'
      }, 404)
    }

    const profile = result.profile
    const careernetSummary = result.partials?.CAREERNET?.summary
    const goyong24Summary = result.partials?.GOYONG24?.summary
    const heroDescription =
      (profile as any).heroSummary ||
      (profile.summary || careernetSummary || goyong24Summary)?.split('\n')[0]?.trim() ||
      ''
    let rawApiData = result.rawApiData || { careernet: null, goyong24: null }
    
    // 헬퍼 함수: 배열에서 이름/텍스트 추출 (핵심 역량, 적성, 흥미, 관련학과, 교육과정, 진로탐색 등)
    const extractListItems = (list: any[] | null | undefined): string[] => {
      if (!list || !Array.isArray(list)) return []
      return list
        .map((item: any) => {
          if (typeof item === 'string') return item.trim()
          // ETL에서 사용하는 모든 필드명 지원
          return (
            item?.name || 
            item?.majorNm ||           // 고용24 관련학과
            item?.depart_name ||       // 커리어넷 관련학과
            item?.curriculum ||        // 정규교육과정
            item?.research ||          // 진로탐색활동
            item?.recruit ||           // 채용정보
            item?.training ||          // 필요 교육/훈련
            item?.certificate ||       // 자격증
            item?.ability_name ||      // 커리어넷 핵심역량
            item?.aptitude || 
            item?.interest || 
            item?.ability || 
            item?.text || 
            item?.value || 
            ''
          ).trim()
        })
        .filter(Boolean)
    }
    
    // 헬퍼 함수: detailReady 배열에서 텍스트 추출 (채용정보, 교육훈련 등)
    // 템플릿의 extractReadyItem과 동일한 로직
    const extractReadyListItems = (list: any[] | null | undefined, key: string): string[] => {
      if (!list || !Array.isArray(list)) return []
      return list
        .map((item: any) => {
          if (typeof item === 'string') return item.trim()
          if (item && typeof item === 'object') {
            return (item[key] || item.name || item.value || item.title || '').trim()
          }
          return ''
        })
        .filter(Boolean)
    }
    
    // 🆕 api_data_json을 직접 읽어서 rawApiData 보완
    // getUnifiedJobDetailWithRawData가 careernet이 null이면 rawCareernetData를 설정하지 않을 수 있음
    // 하지만 실제 api_data_json에는 { careernet: null, goyong24: {...} } 형식으로 저장되어 있을 수 있음
    if (c.env.DB) {
      try {
        // 실제 DB ID로 조회
        let dbResult = await c.env.DB.prepare(
          'SELECT id, api_data_json FROM jobs WHERE id = ? AND is_active = 1 LIMIT 1'
        ).bind(id).first<{ id: string; api_data_json: string | null }>()
        
        if (!dbResult && id.includes(':')) {
          const parts = id.split(':')
          if (parts.length > 1) {
            const extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
            dbResult = await c.env.DB.prepare(
              'SELECT id, api_data_json FROM jobs WHERE id = ? AND is_active = 1 LIMIT 1'
            ).bind(extractedId).first<{ id: string; api_data_json: string | null }>()
          }
        }
        
        if (!dbResult) {
          const normalizedSlug = id.toLowerCase()
          dbResult = await c.env.DB.prepare(
            'SELECT id, api_data_json FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first<{ id: string; api_data_json: string | null }>()
        }
        
        if (dbResult?.api_data_json) {
          try {
            const apiDataFromDb = JSON.parse(dbResult.api_data_json)
            // api_data_json의 구조를 그대로 사용 (careernet이 null이어도 포함)
            rawApiData = {
              careernet: apiDataFromDb.careernet ?? null,
              goyong24: apiDataFromDb.goyong24 ?? null
            }
            console.log('[edit-data] Loaded rawApiData from api_data_json:', {
              careernet: rawApiData.careernet ? 'exists' : 'null',
              goyong24: rawApiData.goyong24 ? 'exists' : 'null'
            })
          } catch (parseError) {
            console.error('[edit-data] Failed to parse api_data_json:', parseError)
          }
        }
      } catch (dbError) {
        console.error('[edit-data] Failed to read api_data_json from DB:', dbError)
      }
    }

    // 실제 렌더링에 사용되는 병합 데이터 생성
    const { mergeJobData } = await import('./services/jobDataMerger')
    const mergedData = mergeJobData(rawApiData)

    // 🆕 템플릿과 정확히 동일한 로직으로 필드 추출 (renderUnifiedJobDetail과 일치)
    // 템플릿에서는 profile이 이미 user_contributed_json과 admin_data_json이 병합된 결과를 사용
    
    // 히어로 설명: 템플릿과 동일한 우선순위 (heroIntro > summary > goyong24)
    // 템플릿: const heroDescription = profile.heroIntro?.split('\n')[0]?.trim() || profile.summary || ...
    // 편집 모드에서도 실제 표시되는 데이터와 동일하게 표시
    const summaryForEdit = 
      profile.heroIntro ||  // heroIntro가 있으면 이것을 우선 사용
      profile.summary || 
      rawApiData?.goyong24?.duty?.jobSum || ''

    // "하는 일" 섹션: 템플릿과 동일한 로직
    // 템플릿: const workSummary = mergedData.work.summary || profile.summary
    const workSummary = mergedData.work.summary || profile.summary || ''
    
    // 주요 업무: 템플릿과 동일한 로직
    // 템플릿: workSimple이 있으면 그것을 사용, 없으면 profile.duties
    const workSimple = mergedData.work.simple
    let duties = ''
    if (workSimple && Array.isArray(workSimple) && workSimple.length > 0) {
      // workSimple이 있으면 템플릿과 동일하게 처리
      duties = workSimple
        .map((item: any) => {
          const text = typeof item === 'string' ? item : item.work || item.list_content || ''
          return text?.trim() || ''
        })
        .filter(Boolean)
        .join('\n')
    } else if (profile.duties?.trim()) {
      // workSimple이 없으면 profile.duties 사용 (템플릿과 동일)
      duties = profile.duties
    }

    // 태그: 템플릿과 동일한 로직 (rawApiData.careernet.encyclopedia.tagList)
    // 템플릿에서는 tagList를 rawApiData.careernet.encyclopedia.tagList에서 가져옴
    const tagList = rawApiData?.careernet?.encyclopedia?.tagList || []
    const tagText = Array.isArray(tagList) 
      ? tagList.map((tag: any) => {
          // 템플릿과 동일한 로직: string이면 그대로, object면 tag 또는 list_content 추출
          const tagText = typeof tag === 'string' ? tag : (tag?.tag || tag?.list_content || '')
          return tagText?.trim() || ''
        }).filter(Boolean).join('\n')
      : ''

    // 실제 데이터베이스 ID 조회 (profile.id는 API ID일 수 있음)
    let actualDbId = id
    if (c.env.DB) {
      try {
        // slug로 조회 시도
        const normalizedSlug = id.toLowerCase()
        const dbResult = await c.env.DB.prepare(
          'SELECT id FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first<{ id: string }>()
        
        if (dbResult?.id) {
          actualDbId = dbResult.id
        } else {
          // ID로 직접 조회 시도
          const directResult = await c.env.DB.prepare(
            'SELECT id FROM jobs WHERE id = ? AND is_active = 1 LIMIT 1'
          ).bind(id).first<{ id: string }>()
          
          if (directResult?.id) {
            actualDbId = directResult.id
          }
        }
      } catch (dbError) {
        console.error('[edit-data] Failed to resolve DB ID:', dbError)
        // DB 조회 실패 시 원본 id 사용
      }
    }

    // heroTags 처리: profile.heroTags 또는 tagList 사용
    let heroTags: string[] = []
    if (Array.isArray(profile.heroTags)) {
      heroTags = profile.heroTags
    } else if (Array.isArray(tagList) && tagList.length > 0) {
      heroTags = tagList.map((tag: any) => {
        const t = typeof tag === 'string' ? tag : (tag?.tag || tag?.list_content || '')
        return t?.trim() || ''
      }).filter(Boolean)
    }
    
    // heroCategory 처리: breadcrumb 형식인지 확인
    let heroCategory = ''
    let isCategoryBreadcrumb = false
    
    if (typeof profile.heroCategory === 'string') {
      heroCategory = profile.heroCategory
    } else if (profile.heroCategory && typeof profile.heroCategory === 'object') {
      const cat = profile.heroCategory as any
      // breadcrumb 형식: large, medium, small 등 계층 구조가 있는 경우
      if (cat.large || cat.medium || cat.small) {
        isCategoryBreadcrumb = true
        // breadcrumb 전체를 표시 (편집 불가)
        const parts = [cat.large, cat.medium, cat.small].filter(Boolean)
        heroCategory = parts.join(' › ')
      } else if (cat.value) {
        heroCategory = cat.value
      }
    }
    
    // 편집 가능한 필드만 추출 (편집 모드 UI 필드 구조에 맞춤)
    const editData: Record<string, any> = {
      name: profile.name || '',
      summary: summaryForEdit, // 전체 summary (heroIntro > summary > goyong24)
      heroTags: heroTags, // 태그 배열
      heroCategory: heroCategory, // 직업 분류
      isCategoryBreadcrumb: isCategoryBreadcrumb, // breadcrumb 형식 여부 (true면 편집 불가)
      
      // 개요 - 주요 업무
      // main은 문자열 → 배열로 변환 (리스트 편집용)
      // 템플릿의 renderDutyBulletList와 동일한 로직 적용
      overviewWork: {
        main: (() => {
          const raw = profile.overviewWork?.main || duties || ''
          console.log('[Edit Data API] overviewWork.main raw type:', typeof raw, 'isArray:', Array.isArray(raw))
          if (Array.isArray(raw)) {
            console.log('[Edit Data API] overviewWork.main array:', JSON.stringify(raw))
            return raw
          }
          if (typeof raw === 'string' && raw.trim()) {
            const normalized = raw.replace(/\r/g, '\n')
            // 1차: 줄바꿈, 불릿 포인트로 분리
            let sentences = normalized
              .split(/\n+|•|▶|►|■|●|◆/)
              .map((s: string) => s.trim().replace(/^[\d\-\.\)\(]+\s*/, ''))
              .filter(Boolean)
            // 2차: 1줄이면 마침표/느낌표/물음표로 분리
            if (sentences.length <= 1) {
              const sentenceSplit = normalized
                .replace(/([.!?])\s+(?=[^\s])/g, '$1|')
                .split('|')
                .map((s: string) => s.trim().replace(/^[\d\-\.\)\(]+\s*/, ''))
                .filter(Boolean)
              if (sentenceSplit.length > sentences.length) {
                sentences = sentenceSplit
              }
            }
            console.log('[Edit Data API] overviewWork.main split result:', JSON.stringify(sentences))
            return sentences
          }
          return []
        })(),
        workStrong: profile.overviewWork?.workStrong || profile.workStrong || '',
        workPlace: profile.overviewWork?.workPlace || profile.workPlace || '',
        physicalAct: profile.overviewWork?.physicalAct || profile.physicalAct || ''
      },
      
      // 개요 - 커리어 전망
      overviewProspect: {
        main: profile.overviewProspect?.main || mergedData.prospect.primary || profile.prospect || ''
      },
      
      // 개요 - 핵심 능력·자격
      overviewAbilities: {
        abilityList: extractListItems(profile.overviewAbilities?.abilityList) 
          || extractListItems(profile.abilityList),
        technKnow: profile.overviewAbilities?.technKnow || profile.technKnow || '',
        eduLevel: profile.overviewAbilities?.eduLevel || profile.eduLevel || '',
        skillYear: profile.overviewAbilities?.skillYear || profile.skillYear || ''
      },
      
      // 개요 - 적성 및 흥미
      overviewAptitude: {
        aptitudeList: extractListItems(profile.overviewAptitude?.aptitudeList)
          || extractListItems(profile.aptitudeList),
        interestList: extractListItems(profile.overviewAptitude?.interestList)
          || extractListItems(profile.interestList)
      },
      
      // 개요 - 여담 (리스트 형식)
      trivia: typeof profile.trivia === 'string' 
        ? profile.trivia.split(/\n|•/).map((s: string) => s.trim()).filter(Boolean)
        : (Array.isArray(profile.trivia) ? profile.trivia : []),
      
      // 상세정보 - 직업 준비하기
      detailReady: {
        curriculum: extractListItems(profile.detailReady?.curriculum),
        recruit: extractListItems(profile.detailReady?.recruit),
        training: extractListItems(profile.detailReady?.training),
        researchList: extractListItems(profile.detailReady?.researchList)
      },
      
      // 사이드바 - 연관 정보
      sidebarJobs: extractListItems(profile.sidebarJobs),
      sidebarMajors: extractListItems(profile.sidebarMajors),
      sidebarCerts: extractListItems(profile.sidebarCerts),
      
      // 사용자가 추가한 출처 (수정/삭제 가능)
      _sources: (profile as any)._sources || {}
    }

    // 디버깅: 데이터가 비어있는지 확인
    const dataKeys = Object.keys(editData)
    const nonEmptyKeys = dataKeys.filter(key => {
      const value = editData[key as keyof typeof editData]
      return value !== null && value !== undefined && value !== ''
    })
    
    
    return c.json({
      success: true,
      data: editData,
      entityId: actualDbId, // 실제 데이터베이스 ID 사용
      entityType: 'job'
    })
  } catch (error) {
    console.error('[edit-data] Error:', error)
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '편집 데이터 조회 실패'
    }, 500)
  }
})

// 전공 편집 모드용 데이터 조회 API
app.get('/api/major/:id/edit-data', async (c) => {
  try {
    // 캐시 방지 (편집 직후 최신 데이터 보장)
    c.header('Cache-Control', 'no-store')
    c.header('Pragma', 'no-cache')
    c.header('Expires', '0')

    const id = c.req.param('id')
    let userContributedJson: any = {} // 전체 스코프에서 사용할 변수 선언
    
    
    // 사용자 생성 전공 (U_ prefix)은 그대로 사용
    let resolvedId = id
    if (!id.startsWith('U_')) {
      // 전공 상세페이지와 동일한 ID 해결 로직 사용
      resolvedId = resolveDetailIdFromSlug('major', id)
    }
    
    
    // 실제 DB ID 찾기 (전공 상세페이지와 동일한 로직)
    let actualDbId = resolvedId
    if (c.env.DB) {
      try {
        // composite ID인 경우 (major:C_xxx 또는 major:G_xxx)
        if (resolvedId.includes(':')) {
          const parts = resolvedId.split(':')
          if (parts.length > 1) {
            const sourceId = parts[parts.length - 1].replace(/^C_/, '').replace(/^G_/, '')
            // careernet_id나 goyong24_id로 실제 DB ID 찾기
            const dbResult = await c.env.DB.prepare(
              'SELECT id FROM majors WHERE careernet_id = ? OR goyong24_id = ? LIMIT 1'
            ).bind(sourceId, sourceId).first() as { id: string } | null
            if (dbResult?.id) {
              actualDbId = dbResult.id
            } else {
            }
          }
        } else {
          // resolvedId가 composite ID가 아닌 경우 DB에서 찾기
          // ID로 직접 조회 시도
          let dbResult = await c.env.DB.prepare(
            'SELECT id FROM majors WHERE id = ? AND is_active = 1 LIMIT 1'
          ).bind(resolvedId).first() as { id: string } | null
          
          
          if (!dbResult) {
            // slug로 조회 시도 (정규화된 이름으로)
            const decodedSlug = decodeURIComponent(id)
            const normalizedSlug = decodedSlug.toLowerCase()
            
            // 방법 1: 정규화된 이름으로 조회
            dbResult = await c.env.DB.prepare(
              'SELECT id FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
            ).bind(normalizedSlug).first() as { id: string } | null
            
            
            if (!dbResult) {
              // 방법 2: 이름으로 직접 조회 (대소문자 무시)
              dbResult = await c.env.DB.prepare(
                'SELECT id FROM majors WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
              ).bind(normalizedSlug).first() as { id: string } | null
              
            }
            
            if (!dbResult) {
              // 방법 3: 원본 slug로 조회
              dbResult = await c.env.DB.prepare(
                'SELECT id FROM majors WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
              ).bind(decodedSlug).first() as { id: string } | null
              
            }
          }
          
          if (dbResult?.id) {
            actualDbId = dbResult.id
          } else {
            actualDbId = resolvedId
          }
        }
      } catch (dbError) {
        console.error('[major edit-data] Failed to resolve DB ID:', dbError)
        // DB 조회 실패 시 resolvedId 사용
        actualDbId = resolvedId
      }
    }
    
    // 사용자 기여 데이터 우선 로드 (역사/편집 데이터 일치 보장)
    if (c.env.DB) {
      try {
        const ucRow = await c.env.DB.prepare(
          'SELECT user_contributed_json FROM majors WHERE id = ? LIMIT 1'
        ).bind(actualDbId).first<{ user_contributed_json: string | null }>()
        if (ucRow?.user_contributed_json) {
          userContributedJson = JSON.parse(ucRow.user_contributed_json)
        }
      } catch (ucError) {
        console.error('[major edit-data] Failed to load user_contributed_json:', ucError)
      }
    }
    
    // 전공 상세페이지와 동일한 방식으로 데이터 조회
    // actualDbId가 실제 DB ID인 경우 그대로 사용, 아니면 resolvedId 사용
    const searchId = actualDbId !== resolvedId ? actualDbId : resolvedId
    const result = await getUnifiedMajorDetail(
      {
        id: searchId, // 실제 DB ID 또는 resolvedId
        careernetId: undefined,
        goyong24Params: undefined
      },
      c.env
    )

    if (!result.profile) {
      console.error(`[major edit-data] Profile not found for searchId: ${searchId}`)
      // 원본 slug로도 시도 (composite ID가 아닌 경우에만)
      if (searchId !== id && !id.includes(':')) {
        const retryResult = await getUnifiedMajorDetail(
          {
            id: id,
            careernetId: undefined,
            goyong24Params: undefined
          },
          c.env
        )
        if (retryResult.profile) {
          // retryResult 사용
          const profile = retryResult.profile
          
          // 헬퍼 함수: 배열에서 이름/텍스트 추출
          const extractListItems = (list: any[] | undefined): string[] => {
            if (!Array.isArray(list)) return []
            return list
              .map((item: any) => {
                if (typeof item === 'string') return item.trim()
                return (item?.name || item?.value || '').trim()
              })
              .filter(Boolean)
          }
          
          const heroTags = Array.isArray((profile as any).heroTags) ? (profile as any).heroTags : []
          const categoryName = typeof (profile as any).categoryName === 'string' ? (profile as any).categoryName : ((profile as any).categoryName?.value || '')
          
          const editData = {
            name: profile.name || '',
            summary: profile.summary || '',
            heroTags: heroTags,
            categoryName: categoryName,
            property: profile.property || '',
            aptitude: profile.aptitude || '',
            relatedMajors: extractListItems(profile.relatedMajors),
            mainSubjects: extractListItems(profile.mainSubjects),
            relatedJobs: extractListItems(profile.relatedJobs),
            whatStudy: profile.whatStudy || '',
            mainSubject: profile.mainSubject || '',
            relateSubject: profile.relateSubject || '',
            enterField: typeof profile.enterField === 'string' ? profile.enterField : (profile.enterField ? JSON.stringify(profile.enterField, null, 2) : ''),
            jobProspect: profile.jobProspect || '',
            careerAct: profile.careerAct || ''
          }
          
          // 프로필 이름으로 실제 DB ID 찾기
          if (c.env.DB && profile.name) {
            try {
              const dbResult = await c.env.DB.prepare(
                'SELECT id FROM majors WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
              ).bind(profile.name).first() as { id: string } | null
              if (dbResult?.id) {
                actualDbId = dbResult.id
              }
            } catch (e) {
              console.error('[major edit-data] Failed to resolve DB ID from retry:', e)
            }
          }
          
          return c.json({
            success: true,
            data: editData,
            entityId: actualDbId || id,
            entityType: 'major'
          })
        }
      }
      return c.json({
        success: false,
        error: '전공 정보를 찾을 수 없습니다.'
      }, 404)
    }
    
    // 프로필을 찾은 경우, 실제 DB ID를 다시 확인
    if (actualDbId === resolvedId && !actualDbId.includes(':') && c.env.DB) {
      try {
        // 프로필 이름으로 실제 DB ID 찾기
        const profileName = result.profile.name
        if (profileName) {
          const dbResult = await c.env.DB.prepare(
            'SELECT id FROM majors WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(profileName).first() as { id: string } | null
          if (dbResult?.id) {
            actualDbId = dbResult.id
          }
        }
      } catch (e) {
        console.error('[major edit-data] Failed to resolve DB ID from profile name:', e)
      }
    }

    const profile = result.profile
    
    // 헬퍼 함수: 배열에서 이름/텍스트 추출
    const extractListItems = (list: any[] | undefined): string[] => {
      if (!Array.isArray(list)) return []
      return list
        .map((item: any) => {
          if (typeof item === 'string') return item.trim()
          return (item?.name || item?.value || '').trim()
        })
        .filter(Boolean)
    }
    
    // heroTags 처리: profile.heroTags 또는 tagList
    let heroTags: string[] = []
    if (Array.isArray((profile as any).heroTags)) {
      heroTags = (profile as any).heroTags
    }
    
    // categoryName 처리
    let categoryName = ''
    if (typeof (profile as any).categoryName === 'string') {
      categoryName = (profile as any).categoryName
    } else if ((profile as any).categoryName?.value) {
      categoryName = (profile as any).categoryName.value
    }
    
    // 편집 가능한 필드만 추출 (편집 모드 UI 필드 구조에 맞춤)
    const extractListItemsWithSubjects = (list: any[] | undefined): string[] => {
      if (!Array.isArray(list)) return []
      return list
        .map((item: any) => {
          if (typeof item === 'string') return item.trim()
          return (
            item?.name ||
            item?.value ||
            item?.subject_name ||
            item?.SUBJECT_NM ||
            ''
          ).trim()
        })
        .filter(Boolean)
    }
    const toStringList = (val: any): string[] => {
      if (Array.isArray(val)) {
        return val.map(v => (typeof v === 'string' ? v : (v?.text || v?.value || v?.name || ''))).filter(Boolean)
      }
      if (typeof val === 'string') {
        return val.split(/\n+/).map(s => s.trim()).filter(Boolean)
      }
      return []
    }
    
    const toPairList = (list: any): Array<{ title: string; description: string }> => {
      if (!list) return []
      if (typeof list === 'string') {
        return list.split(/\n+/).map(line => line.trim()).filter(Boolean).map(line => ({ title: line, description: '' }))
      }
      if (Array.isArray(list)) {
        return list.map(item => {
          const anyItem = item as any
          const title =
            anyItem.title ||
            anyItem.name ||
            anyItem.gradeuate ||
            anyItem.field_name ||
            anyItem.act_name ||
            anyItem.ACT_NM ||
            anyItem.SBJECT_NM ||    // 커리어넷 실제 키 (U 없음)
            anyItem.SUBJECT_NM ||
            anyItem.subject_name ||
            ''
          const description =
            anyItem.description ||
            anyItem.desc ||
            anyItem.text ||
            anyItem.field_description ||
            anyItem.field_desc ||
            anyItem.act_description ||
            anyItem.ACT_SUMRY ||
            anyItem.SBJECT_SUMRY || // 커리어넷 실제 키 (U 없음)
            anyItem.subject_description ||
            anyItem.SUBJECT_SUMRY ||
            ''
          if (!title && !description) return null
          return { title, description }
        }).filter(Boolean) as Array<{ title: string; description: string }>
      }
      return []
    }
    
    // hero description: 템플릿과 동일 (heroSummary 우선, 없으면 summary/CAREERNET/GOYONG24 첫 문장)
    const heroDescription =
      (profile as any).heroSummary ||
      (profile.summary || result.partials?.CAREERNET?.summary || result.partials?.GOYONG24?.summary)
        ?.split('\n')[0]
        ?.trim() ||
      ''
    
    // overview summary: DB user_contributed_json 우선, 그 다음 merged → summary까지 폴백 (템플릿과 동일)
    const isUserCreatedMajor = (profile.id || '').startsWith('U_')
    const overviewSummary = (userContributedJson?.overview?.summary)
      || (profile as any).overview?.summary
      || profile.summary
      || (isUserCreatedMajor ? profile.summary : '')
      || ''
    // 사이드바 데이터
    const mapAutocompleteItems = (arr: any[] | undefined, type: 'job' | 'major' | 'howto') => {
      if (!Array.isArray(arr)) return []
      return arr.map(item => {
        if (typeof item === 'string') return { name: item, slug: item }
        return { name: item?.name || item?.title || '', slug: item?.slug || item?.id || item?.name || item?.title || '' }
      }).filter(i => i.name)
    }
    
    // 교육과정: 기초/심화 기본값 + mainSubjects 파싱 (템플릿과 동일한 순서)
    let basicSubjectsParsed = extractListItemsWithSubjects((profile as any).basicSubjects)
    let advancedSubjectsParsed = extractListItemsWithSubjects((profile as any).advancedSubjects)
    let relateSubjectParsed = extractListItemsWithSubjects(profile.relateSubject)
    // mainSubjects가 pairList 형태면 제목만 태그로 노출 (상세는 mainSubject pairList로 별도 저장)
    const mainSubjectsRaw = profile.mainSubjects
    if (Array.isArray(mainSubjectsRaw) && mainSubjectsRaw.length > 0) {
      const hasPairListShape = mainSubjectsRaw.some((i: any) => typeof i === 'object' && (i.title || i.subject_name || i.SUBJECT_NM))
      if (hasPairListShape) {
        const titles = mainSubjectsRaw
          .map((i: any) => i.title || i.subject_name || i.SUBJECT_NM || '')
          .filter(Boolean)
          .map((t: string) => t.trim())
          .filter(Boolean)
        if (basicSubjectsParsed.length === 0 && titles.length > 0) {
          basicSubjectsParsed = [...titles]
        }
      } else if (basicSubjectsParsed.length === 0 && advancedSubjectsParsed.length === 0) {
        // 문자열/배열 기반 파싱 (‡ 구분자)
        const firstSubject = mainSubjectsRaw[0]
        if (typeof firstSubject === 'string' && firstSubject.includes('‡')) {
          const sections = firstSubject.split('‡').filter((s: string) => s.trim())
          sections.forEach(section => {
            if (section.includes('기초과목')) {
              const subjects = section.replace(/^.*?기초과목\s*[:：]\s*/i, '')
                .split(/[,、]\s*/)
                .map((s: string) => s.trim())
                .filter((s: string) => s && s !== '등')
              basicSubjectsParsed.push(...subjects)
            } else if (section.includes('심화과목')) {
              const subjects = section.replace(/^.*?심화과목\s*[:：]\s*/i, '')
                .split(/[,、]\s*/)
                .map((s: string) => s.trim())
                .filter((s: string) => s && s !== '등')
              advancedSubjectsParsed.push(...subjects)
            }
          })
        }
      }
    }

    const editData = {
      name: profile.name || '',
      heroSummary: heroDescription || profile.summary || '',  // 히어로 섹션 전용 (개요와 분리)
      heroTags: heroTags,
      categoryName: categoryName,
      
      // 개요
      'overview.summary': overviewSummary,
      property: profile.property || '',
      aptitude: profile.aptitude || '',
      enterField: toPairList(profile.enterField),
      // 여담은 trivia 필드만 사용 (진로전망 jobProspect와 분리)
      trivia: toStringList((profile as any).trivia),
      
      // 상세정보 - 교육과정
      whatStudy: profile.whatStudy || '',
      basicSubjects: basicSubjectsParsed,
      advancedSubjects: advancedSubjectsParsed,
      // 대학 주요 교과목 상세: mainSubject 우선, 없으면 main_subject, 없으면 mainSubjects
      mainSubject: toPairList(
        (profile as any).mainSubject ||
        (profile as any).main_subject ||
        (profile as any).mainSubjects
      ),
      // 고교 추천 교과목: pairList로 제공 (제목/설명), [출처]로 시작하는 항목은 제외
      relateSubject: toPairList(profile.relateSubject || (profile as any).relate_subject).filter(
        (item) => item.title && !item.title.trim().startsWith('[출처')
      ),
      
      // 상세정보 - 진로 탐색 활동
      careerAct: toPairList(profile.careerAct),
      
      // 사이드바
      sidebarJobs: mapAutocompleteItems((profile as any).sidebarJobs || profile.relatedJobs, 'job'),
      sidebarMajors: mapAutocompleteItems((profile as any).sidebarMajors || profile.relatedMajors, 'major'),
      sidebarHowtos: mapAutocompleteItems((profile as any).sidebarHowtos, 'howto'),
      
      // 사용자 출처 (편집창에서 다중 입력 지원)
      _sources: (profile as any)._sources || {}
    }

    return c.json({
      success: true,
      data: editData,
      entityId: actualDbId, // 실제 데이터베이스 ID 사용
      entityType: 'major'
    })
  } catch (error) {
    console.error('[major edit-data] Error:', error)
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '편집 데이터 조회 실패'
    }, 500)
  }
})

// 미리보기 API 제거됨 (편집 모드에서 미리보기 기능 없음)

// 직업 카테고리 목록 API
app.get('/api/categories', async (c) => {
  return c.json({
    success: true,
    jobCategories: JOB_CATEGORIES,
    aptitudeTypes: APTITUDE_TYPES
  })
})

// ============================================================================
// 카드 HTML 렌더링 API (클라이언트 정렬 시 사용)
// ============================================================================

// 직업 카드 HTML 반환 API
app.post('/api/job/cards', async (c) => {
  try {
    const body = await c.req.json<{ items: Array<{ profile: any; display?: any }> }>()
    const items = body.items || []
    
    if (!Array.isArray(items) || items.length === 0) {
      return c.json({ html: '', count: 0 })
    }
    
    const html = items.map((item) => renderJobCard(item)).join('')
    
    return c.json({
      html,
      count: items.length
    })
  } catch (error) {
    console.error('Job cards API error:', error)
    return c.json({
      error: error instanceof Error ? error.message : '카드 렌더링 실패',
      html: '',
      count: 0
    }, 500)
  }
})

// 전공 카드 HTML 반환 API
app.post('/api/major/cards', async (c) => {
  try {
    const body = await c.req.json<{ items: Array<{ profile: any; display?: any }> }>()
    const items = body.items || []
    
    if (!Array.isArray(items) || items.length === 0) {
      return c.json({ html: '', count: 0 })
    }
    
    const html = items.map((item) => renderMajorCard(item)).join('')
    
    return c.json({
      html,
      count: items.length
    })
  } catch (error) {
    console.error('Major cards API error:', error)
    return c.json({
      error: error instanceof Error ? error.message : '카드 렌더링 실패',
      html: '',
      count: 0
    }, 500)
  }
})

// ============================================================================
// 전공(학과) 관련 API
// ============================================================================

// 전공 검색 API
app.get('/api/majors', async (c) => {
  try {
    const keyword = c.req.query('keyword') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 50 })
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const result = await searchUnifiedMajors({
      keyword,
      page,
      perPage,
      includeSources
    }, c.env)

    return c.json({
      success: true,
      data: result.items,
      meta: {
        ...result.meta,
        keyword,
        page,
        perPage
      }
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '전공 정보 검색 실패'
    }, 500)
  }
})

// 전공 상세 정보 API
app.get('/api/majors/:id', async (c) => {
  try {
    const id = c.req.param('id')
    const careernetId = c.req.query('careernetId') || undefined
    const goyong24Params = c.req.query('goyong24Params') 
      ? JSON.parse(c.req.query('goyong24Params') || '{}')
      : undefined
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const result = await getUnifiedMajorDetail(
      {
        id,
        careernetId,
        goyong24Params,
        includeSources
      },
      c.env
    )

    if (!result.profile) {
      return c.json({
        success: false,
        error: '전공 정보를 찾을 수 없습니다.',
        sources: result.sources
      }, 404)
    }

    return c.json({
      success: true,
      data: result.profile,
      partials: result.partials,
      sources: result.sources
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '전공 정보 조회 실패'
    }, 500)
  }
})

// ============================================================================
// 전공 상세 페이지
// ============================================================================

// Simple Major Detail Page (D1-based, SEO optimized)
app.get('/majors/:id', async (c) => {
  const id = c.req.param('id')
  const { DB } = c.env
  const debugMode = c.req.query('debug') === 'true'
  
  try {
    // D1에서 직접 전공 상세 데이터 조회
    const row = await DB.prepare('SELECT id, name, api_data_json FROM majors WHERE id = ?')
      .bind(id).first<{ id: string; name: string; api_data_json: string }>()
    
    if (!row || !row.api_data_json) {
      const fallbackHtml = renderDetailFallback({
        icon: 'fa-magnifying-glass',
        title: '전공 정보를 찾을 수 없습니다',
        description: '요청하신 전공 데이터가 존재하지 않거나 삭제되었습니다.',
        ctaHref: '/major',
        ctaLabel: '전공위키로 돌아가기'
      })
      return c.html(renderLayoutWithContext(c,
        fallbackHtml,
        '전공 정보 없음 - Careerwiki',
        '요청하신 전공 정보를 찾을 수 없습니다.'
      ), 404)
    }
    
    // Parse API data from D1
    const apiData = JSON.parse(row.api_data_json)
    
    // UnifiedMajorDetail 형식으로 변환
    const profile: UnifiedMajorDetail = {
      id: row.id,
      sourceIds: apiData.merged?.sourceIds || {},
      name: apiData.merged?.name || row.name,
      categoryId: apiData.merged?.categoryId,
      categoryName: apiData.merged?.categoryName,
      summary: apiData.merged?.summary,
      aptitude: apiData.merged?.aptitude,
      relatedMajors: apiData.merged?.relatedMajors,
      mainSubjects: apiData.merged?.mainSubjects,
      licenses: apiData.merged?.licenses,
      universities: apiData.merged?.universities,
      recruitmentStatus: apiData.merged?.recruitmentStatus,
      relatedJobs: apiData.merged?.relatedJobs,
      whatStudy: apiData.merged?.whatStudy,
      howPrepare: apiData.merged?.howPrepare,
      jobProspect: apiData.merged?.jobProspect,
      salaryAfterGraduation: apiData.merged?.salaryAfterGraduation,
      employmentRate: apiData.merged?.employmentRate,
      sources: apiData.merged?.sources || []
    }
    
    const majorName = profile.name || '전공 정보'
    const summary = profile.summary?.substring(0, 120) || '전공 정보를 제공합니다.'
    
    // Note: 디버그 모드는 ISR 캐시를 우회하는 별도 라우트에서 처리됩니다.
    // 이 함수는 ISR 캐시 생성용이므로 디버그 모드를 지원하지 않습니다.
    
    // SEO 최적화된 메타 정보
    const pageTitle = `${majorName} 전공 정보 - 대학 학과, 진로, 취업 | CareerWiki`
    const metaDescription = `${summary}. ${profile.mainSubjects?.length || 0}개 주요 과목, ${profile.relatedJobs?.length || 0}개 관련 직업, ${profile.universities?.length || 0}개 대학 정보 제공.`
    const canonicalUrl = `https://careerwiki.org/majors/${id}`
    
    // renderUnifiedMajorDetail 템플릿 사용
    const content = renderUnifiedMajorDetail({
      profile,
      partials: apiData.partials || {},
      sources: apiData.sources || {}
    })
    
    // Schema.org JSON-LD 생성
    const extraHead = [
      '<meta property="og:type" content="article">',
      createMajorJsonLd(profile, canonicalUrl)
    ].filter(Boolean).join('\n')
    
    return c.html(renderLayoutWithContext(c,
      content,
      escapeHtml(pageTitle),
      escapeHtml(metaDescription),
      false,
      {
        canonical: canonicalUrl,
        ogUrl: canonicalUrl,
        extraHead
      }
    ))
    
  } catch (error) {
    console.error('Major detail route error:', error)
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-exclamation-circle',
      iconColor: 'text-red-500',
      title: '전공 정보를 불러오지 못했습니다',
      description: '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ctaHref: '/major',
      ctaLabel: '전공위키로 돌아가기'
    })
    c.status(500)
    return c.html(renderLayoutWithContext(c,
      fallbackHtml,
      '전공 정보 로드 오류 - Careerwiki',
      '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
    ))
  }
})

// ============================================================================
// 사용자 설정 페이지
// ============================================================================

// 내 작성 댓글 페이지
app.get('/user/comments', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=/user/comments')
  }
  
  const filter = c.req.query('filter') || 'all'
  
  // 내 댓글 조회 (pages 테이블과 조인)
  // author_id는 숫자로 저장되므로 CAST로 비교
  const comments = await c.env.DB.prepare(`
    SELECT c.id, c.content, c.created_at, p.page_type, p.slug, p.title as page_title
    FROM comments c
    JOIN pages p ON c.page_id = p.id
    WHERE CAST(c.author_id AS INTEGER) = ? AND c.status != 'deleted'
    ORDER BY c.created_at DESC
    LIMIT 100
  `).bind(user.id).all<{
    id: number; content: string; created_at: string; page_type: string; 
    slug: string; page_title: string | null
  }>()
  
  const allComments = comments.results || []
  
  // 페이지 타입별 분류 (guide는 howto로 취급)
  const jobComments = allComments.filter(c => c.page_type === 'job')
  const majorComments = allComments.filter(c => c.page_type === 'major')
  const guideComments = allComments.filter(c => c.page_type === 'guide' || c.page_type === 'howto')
  
  // 필터 적용
  let filteredComments = allComments
  if (filter === 'job') filteredComments = jobComments
  else if (filter === 'major') filteredComments = majorComments
  else if (filter === 'howto') filteredComments = guideComments
  
  // 페이지 타입에 따른 아이콘과 색상
  const getTypeInfo = (pageType: string) => {
    switch (pageType) {
      case 'job': return { icon: 'fa-briefcase', color: 'text-blue-400', bgColor: 'bg-blue-500/10', borderColor: 'border-blue-500/30', label: '직업' }
      case 'major': return { icon: 'fa-university', color: 'text-emerald-400', bgColor: 'bg-emerald-500/10', borderColor: 'border-emerald-500/30', label: '전공' }
      case 'guide':
      case 'howto': return { icon: 'fa-lightbulb', color: 'text-amber-400', bgColor: 'bg-amber-500/10', borderColor: 'border-amber-500/30', label: 'HowTo' }
      default: return { icon: 'fa-file', color: 'text-wiki-muted', bgColor: 'bg-wiki-card/50', borderColor: 'border-wiki-border/40', label: '기타' }
    }
  }
  
  // slug에서 type prefix 제거하고 실제 URL path 생성
  const getCommentUrl = (pageType: string, slug: string) => {
    // slug가 "guide:some-slug" 또는 "job:some-slug" 형태로 저장됨
    const cleanSlug = slug.replace(/^(guide|job|major):/, '')
    // guide는 howto로 라우팅
    const urlPath = pageType === 'guide' ? 'howto' : pageType
    return `/${urlPath}/${cleanSlug}`
  }
  
  const content = `
    <div class="max-w-4xl mx-auto px-4 py-8">
      <header class="mb-8">
        <h1 class="text-2xl font-bold text-white mb-2">작성 댓글</h1>
        <p class="text-wiki-muted">내가 작성한 댓글들을 확인합니다</p>
      </header>
      
      <!-- 필터 탭 -->
      <div class="flex items-center gap-2 mb-6 border-b border-wiki-border/40 pb-4 overflow-x-auto">
        <a href="/user/comments?filter=all" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'all' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          전체 <span class="ml-1 opacity-70">(${allComments.length})</span>
        </a>
        <a href="/user/comments?filter=job" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'job' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-briefcase mr-1.5"></i>직업 <span class="ml-1 opacity-70">(${jobComments.length})</span>
        </a>
        <a href="/user/comments?filter=major" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'major' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-university mr-1.5"></i>전공 <span class="ml-1 opacity-70">(${majorComments.length})</span>
        </a>
        <a href="/user/comments?filter=howto" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'howto' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-lightbulb mr-1.5"></i>HowTo <span class="ml-1 opacity-70">(${guideComments.length})</span>
        </a>
      </div>
      
      ${filteredComments.length > 0 ? `
        <div class="space-y-4">
          ${filteredComments.map(comment => {
            const typeInfo = getTypeInfo(comment.page_type)
            const commentUrl = getCommentUrl(comment.page_type, comment.slug)
            return `
            <a href="${escapeHtml(commentUrl)}#comment-${comment.id}" 
               class="block p-4 bg-wiki-card/50 border border-wiki-border/40 rounded-xl hover:border-wiki-primary/50 transition group">
              <div class="flex items-start justify-between gap-4 mb-2">
                <div class="flex items-center gap-2 min-w-0">
                  <span class="px-2 py-0.5 rounded-full text-xs ${typeInfo.bgColor} ${typeInfo.color} ${typeInfo.borderColor} border shrink-0">
                    <i class="fas ${typeInfo.icon} mr-1"></i>${typeInfo.label}
                  </span>
                  <span class="text-sm text-wiki-primary group-hover:underline truncate">
                    ${escapeHtml(comment.page_title || comment.slug.replace(/^(guide|job|major):/, ''))}
                  </span>
                </div>
                <span class="text-xs text-wiki-muted shrink-0">${formatDateSafe(comment.created_at)}</span>
              </div>
              <p class="text-wiki-text text-sm line-clamp-2">${escapeHtml(comment.content)}</p>
            </a>
          `}).join('')}
        </div>
      ` : `
        <div class="text-center py-16">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-wiki-card/50 mb-4">
            <i class="fas fa-comments text-2xl text-wiki-muted"></i>
          </div>
          <h3 class="text-lg font-semibold text-white mb-2">
            ${filter === 'all' ? '작성한 댓글이 없습니다' : `작성한 ${filter === 'job' ? '직업' : filter === 'major' ? '전공' : 'HowTo'} 댓글이 없습니다`}
          </h3>
          <p class="text-wiki-muted">
            ${filter === 'all' 
              ? '직업, 전공, HowTo 페이지에서 댓글을 작성해보세요!' 
              : `${filter === 'job' ? '직업위키' : filter === 'major' ? '전공위키' : 'HowTo 가이드'}에서 댓글을 작성해보세요!`}
          </p>
          <div class="mt-4">
            <a href="/${filter === 'all' ? 'job' : (filter === 'howto' ? 'howto' : filter)}" class="inline-flex items-center gap-2 px-4 py-2 bg-wiki-primary hover:bg-wiki-primary/90 text-white rounded-lg text-sm transition">
              <i class="fas fa-arrow-right"></i>
              ${filter === 'job' ? '직업위키' : filter === 'major' ? '전공위키' : filter === 'howto' ? 'HowTo 가이드' : '직업위키'} 둘러보기
            </a>
          </div>
        </div>
      `}
    </div>
  `
  
  return c.html(
    renderLayoutWithContext(c, content, '작성 댓글 - Careerwiki', '내가 작성한 댓글')
  )
})

// 저장함 페이지
app.get('/user/bookmarks', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=/user/bookmarks')
  }
  
  const filter = c.req.query('filter') || 'all'
  
  // 저장된 항목 조회 (테이블이 없을 수 있음)
  let bookmarkList: Array<{ id: number; item_type: string; item_slug: string; item_title: string; created_at: string }> = []
  try {
    const bookmarks = await c.env.DB.prepare(`
      SELECT b.id, b.item_type, b.item_slug, b.item_title, b.created_at
      FROM user_bookmarks b
      WHERE b.user_id = ?
      ORDER BY b.created_at DESC
      LIMIT 100
    `).bind(user.id).all<{
      id: number; item_type: string; item_slug: string; item_title: string; created_at: string
    }>()
    bookmarkList = bookmarks.results || []
  } catch (e) {
    // 테이블이 없으면 빈 배열
    console.log('[bookmarks] Table not found, showing empty')
  }
  
  // 타입별로 분류
  const jobs = bookmarkList.filter(b => b.item_type === 'job')
  const majors = bookmarkList.filter(b => b.item_type === 'major')
  const howtos = bookmarkList.filter(b => b.item_type === 'howto')
  
  // 필터 적용
  let filteredBookmarks = bookmarkList
  if (filter === 'job') filteredBookmarks = jobs
  else if (filter === 'major') filteredBookmarks = majors
  else if (filter === 'howto') filteredBookmarks = howtos
  
  // 타입에 따른 아이콘과 색상
  const getTypeInfo = (itemType: string) => {
    switch (itemType) {
      case 'job': return { icon: 'fa-briefcase', color: 'text-blue-400', bgColor: 'bg-blue-500/10', borderColor: 'border-blue-500/30', label: '직업', path: 'job' }
      case 'major': return { icon: 'fa-university', color: 'text-emerald-400', bgColor: 'bg-emerald-500/10', borderColor: 'border-emerald-500/30', label: '전공', path: 'major' }
      case 'howto': return { icon: 'fa-lightbulb', color: 'text-amber-400', bgColor: 'bg-amber-500/10', borderColor: 'border-amber-500/30', label: 'HowTo', path: 'howto' }
      default: return { icon: 'fa-file', color: 'text-wiki-muted', bgColor: 'bg-wiki-card/50', borderColor: 'border-wiki-border/40', label: '기타', path: '' }
    }
  }
  
  const content = `
    <div class="max-w-4xl mx-auto px-4 py-8">
      <header class="mb-8">
        <h1 class="text-2xl font-bold text-white mb-2">저장함</h1>
        <p class="text-wiki-muted">저장한 직업, 전공, HowTo를 확인합니다</p>
      </header>
      
      <!-- 필터 탭 -->
      <div class="flex items-center gap-2 mb-6 border-b border-wiki-border/40 pb-4 overflow-x-auto">
        <a href="/user/bookmarks?filter=all" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'all' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          전체 <span class="ml-1 opacity-70">(${bookmarkList.length})</span>
        </a>
        <a href="/user/bookmarks?filter=job" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'job' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-briefcase mr-1.5"></i>직업 <span class="ml-1 opacity-70">(${jobs.length})</span>
        </a>
        <a href="/user/bookmarks?filter=major" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'major' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-university mr-1.5"></i>전공 <span class="ml-1 opacity-70">(${majors.length})</span>
        </a>
        <a href="/user/bookmarks?filter=howto" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'howto' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-lightbulb mr-1.5"></i>HowTo <span class="ml-1 opacity-70">(${howtos.length})</span>
        </a>
      </div>
      
      ${filteredBookmarks.length > 0 ? `
        <div class="space-y-4">
          ${filteredBookmarks.map(bookmark => {
            const typeInfo = getTypeInfo(bookmark.item_type)
            return `
            <a href="/${typeInfo.path}/${escapeHtml(bookmark.item_slug)}" 
               class="block p-4 bg-wiki-card/50 border border-wiki-border/40 rounded-xl hover:border-wiki-primary/50 transition group">
              <div class="flex items-center sm:items-start justify-between gap-4">
                <div class="flex items-center gap-3 min-w-0">
                  <span class="px-2 py-0.5 rounded-full text-xs ${typeInfo.bgColor} ${typeInfo.color} ${typeInfo.borderColor} border shrink-0">
                    <i class="fas ${typeInfo.icon} mr-1"></i>${typeInfo.label}
                  </span>
                  <span class="text-wiki-text group-hover:text-wiki-primary transition truncate">
                    ${escapeHtml(bookmark.item_title)}
                  </span>
                </div>
                <div class="flex items-center gap-3 shrink-0">
                  <span class="text-xs text-wiki-muted">${new Date(Number(bookmark.created_at) * 1000).toLocaleDateString('ko-KR')}</span>
                  <i class="fas fa-chevron-right text-wiki-muted text-xs group-hover:text-wiki-primary transition"></i>
                </div>
              </div>
            </a>
          `}).join('')}
        </div>
      ` : `
        <div class="text-center py-16">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-wiki-card/50 mb-4">
            <i class="fas fa-bookmark text-2xl text-wiki-muted"></i>
          </div>
          <h3 class="text-lg font-semibold text-white mb-2">
            ${filter === 'all' ? '저장한 항목이 없습니다' : `저장한 ${filter === 'job' ? '직업' : filter === 'major' ? '전공' : 'HowTo'}이 없습니다`}
          </h3>
          <p class="text-wiki-muted">
            ${filter === 'all' 
              ? '직업, 전공, HowTo 페이지에서 북마크 버튼을 눌러 저장해보세요!' 
              : `${filter === 'job' ? '직업위키' : filter === 'major' ? '전공위키' : 'HowTo 가이드'}에서 북마크 버튼을 눌러 저장해보세요!`}
          </p>
          <div class="mt-4">
            <a href="/${filter === 'all' ? 'job' : filter}" class="inline-flex items-center gap-2 px-4 py-2 bg-wiki-primary hover:bg-wiki-primary/90 text-white rounded-lg text-sm transition">
              <i class="fas fa-arrow-right"></i>
              ${filter === 'job' ? '직업위키' : filter === 'major' ? '전공위키' : filter === 'howto' ? 'HowTo 가이드' : '직업위키'} 둘러보기
            </a>
          </div>
        </div>
      `}
    </div>
  `
  
  return c.html(
    renderLayoutWithContext(c, content, '저장함 - Careerwiki', '저장한 직업, 전공, HowTo')
  )
})

// ============================================================================
// 북마크 API (저장 토글)
// ============================================================================

// 북마크 상태 확인 API
app.get('/api/bookmark/:type/:slug', async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ saved: false, error: 'not_logged_in' })
  }
  
  const { type, slug } = c.req.param()
  if (!['job', 'major', 'howto'].includes(type)) {
    return c.json({ saved: false, error: 'invalid_type' }, 400)
  }
  
  try {
    const existing = await c.env.DB.prepare(`
      SELECT id FROM user_bookmarks WHERE user_id = ? AND item_type = ? AND item_slug = ?
    `).bind(user.id, type, slug).first()
    
    return c.json({ saved: !!existing })
  } catch (e) {
    return c.json({ saved: false, error: 'db_error' }, 500)
  }
})

// 북마크 토글 API (저장/해제)
app.post('/api/bookmark', async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'not_logged_in', message: '로그인이 필요합니다' }, 401)
  }
  
  let body: { type: string; slug: string; title?: string }
  try {
    body = await c.req.json()
  } catch {
    return c.json({ success: false, error: 'invalid_body' }, 400)
  }
  
  const { type, slug, title } = body
  if (!type || !slug) {
    return c.json({ success: false, error: 'missing_params' }, 400)
  }
  if (!['job', 'major', 'howto'].includes(type)) {
    return c.json({ success: false, error: 'invalid_type' }, 400)
  }
  
  try {
    // 기존 북마크 확인
    const existing = await c.env.DB.prepare(`
      SELECT id FROM user_bookmarks WHERE user_id = ? AND item_type = ? AND item_slug = ?
    `).bind(user.id, type, slug).first<{ id: number }>()
    
    if (existing) {
      // 이미 저장됨 -> 삭제 (토글)
      await c.env.DB.prepare(`
        DELETE FROM user_bookmarks WHERE id = ?
      `).bind(existing.id).run()
      
      return c.json({ success: true, saved: false, message: '저장 해제되었습니다' })
    } else {
      // 저장되지 않음 -> 추가
      await c.env.DB.prepare(`
        INSERT INTO user_bookmarks (user_id, item_type, item_slug, item_title)
        VALUES (?, ?, ?, ?)
      `).bind(user.id, type, slug, title || null).run()
      
      return c.json({ success: true, saved: true, message: '저장되었습니다' })
    }
  } catch (e) {
    console.error('[bookmark] Error:', e)
    return c.json({ success: false, error: 'db_error' }, 500)
  }
})

// ===== 프로필 이미지 업로드 API =====
// POST /api/user/profile-image - 프로필 이미지 업로드
app.post('/api/user/profile-image', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'unauthorized' }, 401)
  }
  
  try {
    const formData = await c.req.formData()
    const file = formData.get('image') as File | null
    
    if (!file) {
      return c.json({ success: false, error: '이미지 파일이 필요합니다' }, 400)
    }
    
    // 파일 검증
    const { validateContentType, validateFileSize, validateMagicNumber, uploadToR2 } = await import('./services/uploadService')
    
    const typeResult = validateContentType(file.type)
    if (!typeResult.valid) {
      return c.json({ success: false, error: typeResult.error }, 400)
    }
    
    // 프로필 이미지는 2MB로 제한
    const MAX_PROFILE_SIZE = 2 * 1024 * 1024
    if (file.size > MAX_PROFILE_SIZE) {
      return c.json({ success: false, error: '프로필 이미지는 2MB를 초과할 수 없습니다' }, 400)
    }
    
    const sizeResult = validateFileSize(file.size)
    if (!sizeResult.valid) {
      return c.json({ success: false, error: sizeResult.error }, 400)
    }
    
    // 매직 넘버 검증
    const buffer = await file.arrayBuffer()
    if (!validateMagicNumber(buffer, file.type)) {
      return c.json({ success: false, error: '유효하지 않은 이미지 파일입니다' }, 400)
    }
    
    // 파일 키 생성 (profile/userId/timestamp.ext)
    const now = new Date()
    const timestamp = now.getTime()
    const ext = typeResult.ext || 'jpg'
    const fileKey = `profile/${user.id}/${timestamp}.${ext}`
    
    // R2에 업로드
    const uploadResult = await uploadToR2(
      c.env.UPLOADS,
      fileKey,
      buffer,
      file.type,
      { userId: String(user.id), type: 'profile' }
    )
    
    if (!uploadResult.success) {
      return c.json({ success: false, error: uploadResult.error || '업로드 실패' }, 500)
    }
    
    // 공개 URL 생성
    const publicUrl = `/uploads/${fileKey}`
    
    // DB 업데이트
    await c.env.DB.prepare(`
      UPDATE users SET custom_picture_url = ?, updated_at = ? WHERE id = ?
    `).bind(publicUrl, Math.floor(Date.now() / 1000), user.id).run()
    
    return c.json({ 
      success: true, 
      url: publicUrl,
      message: '프로필 이미지가 업데이트되었습니다' 
    })
  } catch (e) {
    console.error('[profile-image upload] Error:', e)
    return c.json({ success: false, error: '업로드 중 오류가 발생했습니다' }, 500)
  }
})

// DELETE /api/user/profile-image - 프로필 이미지 초기화 (기본 아이콘으로)
app.delete('/api/user/profile-image', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'unauthorized' }, 401)
  }
  
  try {
    // 기존 custom_picture_url이 있으면 R2에서 삭제 시도 (선택적)
    if (user.custom_picture_url && user.custom_picture_url.startsWith('/uploads/')) {
      const fileKey = user.custom_picture_url.replace('/uploads/', '')
      const { deleteFromR2 } = await import('./services/uploadService')
      await deleteFromR2(c.env.UPLOADS, fileKey).catch(() => {})
    }
    
    // DB에서 custom_picture_url 제거
    await c.env.DB.prepare(`
      UPDATE users SET custom_picture_url = NULL, updated_at = ? WHERE id = ?
    `).bind(Math.floor(Date.now() / 1000), user.id).run()
    
    return c.json({ 
      success: true, 
      message: '프로필 이미지가 기본으로 초기화되었습니다' 
    })
  } catch (e) {
    console.error('[profile-image delete] Error:', e)
    return c.json({ success: false, error: '초기화 중 오류가 발생했습니다' }, 500)
  }
})

// Phase 3 Day 4: 개인 설정 페이지
app.get('/user/settings', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect(`/auth/google?return_url=${encodeURIComponent(c.req.path + c.req.query())}`)
  }
  
  const userData = {
    id: user.id,
    name: user.name,
    email: user.email,
    username: user.username,
    picture_url: user.picture_url,
    custom_picture_url: user.custom_picture_url,
    role: user.role,
    created_at: user.created_at
  }
  
  // 프로필 이미지 우선순위: custom > OAuth > 기본 아이콘
  const profileImageUrl = userData.custom_picture_url || userData.picture_url || null
  
  const content = `
    <div class="max-w-4xl mx-auto px-4 md:px-6 py-8">
      <h1 class="text-3xl font-bold mb-8 gradient-text">
        <i class="fas fa-cog mr-3"></i>개인 설정
      </h1>
      
      <div class="space-y-6">
        <!-- 프로필 정보 섹션 -->
        <div class="glass-card p-6 rounded-xl border border-wiki-border">
          <h2 class="text-xl font-semibold mb-4 text-wiki-text">
            <i class="fas fa-user mr-2 text-wiki-primary"></i>프로필 정보
          </h2>
          
          <div class="space-y-4">
            <!-- 프로필 사진 -->
            <div class="flex items-start gap-4">
              <div class="relative group">
                <div 
                  id="profile-image-container"
                  class="w-20 h-20 rounded-full overflow-hidden border-2 border-wiki-border cursor-pointer hover:border-wiki-primary transition-colors"
                  title="클릭하여 프로필 이미지 변경"
                >
                  ${profileImageUrl ? `
                    <img 
                      id="profile-image"
                      src="${profileImageUrl}" 
                      alt="${userData.name || 'User'}"
                      class="w-full h-full object-cover"
                    />
                  ` : `
                    <div id="profile-image" class="w-full h-full bg-wiki-card flex items-center justify-center">
                      <i class="fas fa-user-circle text-4xl text-wiki-muted"></i>
                    </div>
                  `}
                  <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center rounded-full">
                    <i class="fas fa-camera text-white text-xl"></i>
                  </div>
                </div>
                <input 
                  type="file" 
                  id="profile-image-input" 
                  accept="image/jpeg,image/png,image/gif,image/webp"
                  class="hidden"
                />
              </div>
              <div class="flex-1 space-y-2">
                <p class="text-sm text-wiki-text font-medium">프로필 사진</p>
                <p class="text-xs text-wiki-muted">이미지를 클릭하여 변경하세요. (최대 2MB, JPG/PNG/GIF/WEBP)</p>
                <div class="flex flex-wrap gap-2 mt-2">
                  <button 
                    id="profile-image-upload-btn"
                    type="button"
                    class="px-4 py-2.5 min-h-[44px] text-sm bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition-colors"
                  >
                    <i class="fas fa-upload mr-1.5"></i>이미지 변경
                  </button>
                  ${userData.custom_picture_url ? `
                    <button 
                      id="profile-image-reset-btn"
                      type="button"
                      class="px-4 py-2.5 min-h-[44px] text-sm bg-wiki-card border border-wiki-border text-wiki-text rounded-lg hover:bg-wiki-bg transition-colors"
                    >
                      <i class="fas fa-undo mr-1.5"></i>기본으로 초기화
                    </button>
                  ` : ''}
                </div>
                <div id="profile-image-status" class="text-xs mt-2 hidden"></div>
              </div>
            </div>
            
            <!-- 이메일 -->
            <div>
              <label class="block text-sm font-medium text-wiki-text mb-2">이메일</label>
              <div class="px-4 py-2 bg-wiki-card border border-wiki-border rounded-lg text-wiki-text">
                ${userData.email}
              </div>
              <p class="text-xs text-wiki-muted mt-1">Google 계정 이메일입니다.</p>
            </div>
          </div>
        </div>
        
        <!-- 계정 설정 섹션 -->
        <div class="glass-card p-6 rounded-xl border border-wiki-border">
          <h2 class="text-xl font-semibold mb-4 text-wiki-text">
            <i class="fas fa-id-card mr-2 text-wiki-primary"></i>계정 설정
          </h2>
          
          <div class="space-y-4">
            <!-- 사용자 아이디 변경 -->
            <div>
              <label for="username" class="block text-sm font-medium text-wiki-text mb-2">
                사용자 아이디 (닉네임)
              </label>
              <form id="username-form" class="flex flex-col sm:flex-row gap-2">
                <input
                  type="text"
                  id="username"
                  name="username"
                  value="${userData.username || ''}"
                  placeholder="user_abc123"
                  pattern="[a-z0-9_]{3,20}"
                  class="flex-1 px-4 py-3 min-h-[48px] bg-wiki-card border border-wiki-border rounded-lg text-wiki-text focus:outline-none focus:border-wiki-primary focus:ring-1 focus:ring-wiki-primary"
                  style="font-size: 16px;"
                  required
                />
                <button
                  type="submit"
                  class="px-6 py-3 min-h-[48px] bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition-colors font-medium"
                >
                  변경
                </button>
              </form>
              <p class="text-xs text-wiki-muted mt-2">
                3-20자, 영문 소문자, 숫자, 언더스코어(_)만 사용 가능합니다.
              </p>
              <div id="username-message" class="mt-2 text-sm hidden"></div>
            </div>
            
            <!-- 가입일 -->
            <div>
              <label class="block text-sm font-medium text-wiki-text mb-2">가입일</label>
              <div class="px-4 py-2 bg-wiki-card border border-wiki-border rounded-lg text-wiki-text">
                ${userData.created_at ? new Date(Number(userData.created_at) * 1000).toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' }) : '알 수 없음'}
              </div>
            </div>
            
            <!-- 역할 -->
            <div>
              <label class="block text-sm font-medium text-wiki-text mb-2">역할</label>
              <div class="px-4 py-2 bg-wiki-card border border-wiki-border rounded-lg text-wiki-text">
                ${userData.role === 'admin' ? '관리자' : userData.role === 'expert' ? '전문가' : '일반 사용자'}
              </div>
            </div>
          </div>
        </div>
        
        <!-- 보안 섹션 -->
        <div class="glass-card p-6 rounded-xl border border-wiki-border">
          <h2 class="text-xl font-semibold mb-4 text-wiki-text">
            <i class="fas fa-shield-halved mr-2 text-wiki-primary"></i>보안
          </h2>
          
          <div class="space-y-4">
            <div>
              <p class="text-sm text-wiki-muted mb-2">
                Google OAuth를 통해 로그인하므로 별도의 비밀번호가 없습니다.
              </p>
              <p class="text-sm text-wiki-muted">
                계정 보안은 Google 계정 설정에서 관리하세요.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <script>
      (function() {
        const form = document.getElementById('username-form');
        const input = document.getElementById('username');
        const message = document.getElementById('username-message');
        
        if (!form || !input || !message) return;
        
        form.addEventListener('submit', async (e) => {
          e.preventDefault();
          
          const newUsername = input.value.trim().toLowerCase();
          
          // 클라이언트 측 유효성 검사
          if (!/^[a-z0-9_]{3,20}$/.test(newUsername)) {
            message.className = 'mt-2 text-sm text-red-400';
            message.textContent = '사용자 아이디는 3-20자의 영문 소문자, 숫자, 언더스코어만 사용할 수 있습니다.';
            message.classList.remove('hidden');
            return;
          }
          
          // 버튼 비활성화
          const submitBtn = form.querySelector('button[type="submit"]');
          if (submitBtn) {
            submitBtn.disabled = true;
            submitBtn.textContent = '변경 중...';
          }
          
          try {
            const response = await fetch('/api/user/username', {
              method: 'PATCH',
              headers: {
                'Content-Type': 'application/json'
              },
              body: JSON.stringify({ username: newUsername })
            });
            
            const data = await response.json();
            
            if (response.ok && data.success) {
              message.className = 'mt-2 text-sm text-green-400';
              message.textContent = '사용자 아이디가 변경되었습니다.';
              message.classList.remove('hidden');
              
              // 페이지 새로고침
              setTimeout(() => {
                window.location.reload();
              }, 1000);
            } else {
              message.className = 'mt-2 text-sm text-red-400';
              message.textContent = data.error || '사용자 아이디 변경에 실패했습니다.';
              message.classList.remove('hidden');
            }
          } catch (error) {
            message.className = 'mt-2 text-sm text-red-400';
            message.textContent = '네트워크 오류가 발생했습니다.';
            message.classList.remove('hidden');
          } finally {
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.textContent = '변경';
            }
          }
        });
      })();
      
      // 프로필 이미지 업로드 스크립트
      (function() {
        const container = document.getElementById('profile-image-container');
        const imageInput = document.getElementById('profile-image-input');
        const uploadBtn = document.getElementById('profile-image-upload-btn');
        const resetBtn = document.getElementById('profile-image-reset-btn');
        const status = document.getElementById('profile-image-status');
        
        if (!container || !imageInput) return;
        
        // 이미지 컨테이너 클릭 시 파일 선택
        container.addEventListener('click', () => imageInput.click());
        if (uploadBtn) {
          uploadBtn.addEventListener('click', () => imageInput.click());
        }
        
        // 파일 선택 시 업로드
        imageInput.addEventListener('change', async (e) => {
          const file = e.target.files[0];
          if (!file) return;
          
          // 파일 크기 검증 (2MB)
          if (file.size > 2 * 1024 * 1024) {
            showStatus('프로필 이미지는 2MB를 초과할 수 없습니다', 'error');
            return;
          }
          
          // 파일 형식 검증
          const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
          if (!allowedTypes.includes(file.type)) {
            showStatus('지원하지 않는 파일 형식입니다 (JPG/PNG/GIF/WEBP만 가능)', 'error');
            return;
          }
          
          showStatus('업로드 중...', 'loading');
          
          try {
            const formData = new FormData();
            formData.append('image', file);
            
            const response = await fetch('/api/user/profile-image', {
              method: 'POST',
              body: formData
            });
            
            const data = await response.json();
            
            if (response.ok && data.success) {
              showStatus('프로필 이미지가 업데이트되었습니다', 'success');
              // 페이지 새로고침하여 새 이미지 표시
              setTimeout(() => window.location.reload(), 1000);
            } else {
              showStatus(data.error || '업로드에 실패했습니다', 'error');
            }
          } catch (error) {
            showStatus('네트워크 오류가 발생했습니다', 'error');
          }
          
          // 입력 초기화
          imageInput.value = '';
        });
        
        // 초기화 버튼
        if (resetBtn) {
          resetBtn.addEventListener('click', async () => {
            if (!confirm('프로필 이미지를 기본으로 초기화하시겠습니까?')) return;
            
            showStatus('초기화 중...', 'loading');
            
            try {
              const response = await fetch('/api/user/profile-image', {
                method: 'DELETE'
              });
              
              const data = await response.json();
              
              if (response.ok && data.success) {
                showStatus('기본 이미지로 초기화되었습니다', 'success');
                setTimeout(() => window.location.reload(), 1000);
              } else {
                showStatus(data.error || '초기화에 실패했습니다', 'error');
              }
            } catch (error) {
              showStatus('네트워크 오류가 발생했습니다', 'error');
            }
          });
        }
        
        function showStatus(message, type) {
          if (!status) return;
          status.classList.remove('hidden', 'text-green-400', 'text-red-400', 'text-wiki-muted');
          if (type === 'success') {
            status.className = 'text-xs mt-2 text-green-400';
          } else if (type === 'error') {
            status.className = 'text-xs mt-2 text-red-400';
          } else {
            status.className = 'text-xs mt-2 text-wiki-muted';
          }
          status.textContent = message;
        }
      })();
    </script>
  `
  
  return c.html(renderLayoutWithContext(c,
    content,
    '개인 설정 - Careerwiki',
    '계정 설정 및 프로필 관리',
    false,
    { user: userData }
  ))
})

// ============================================================================
// 사용자 API
// ============================================================================

// Phase 3 Day 4: 사용자 아이디 변경 API
app.patch('/api/user/username', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'Unauthorized' }, 401)
  }
  
  try {
    const body = await c.req.json() as { username?: string }
    
    if (!body.username) {
      return c.json({ success: false, error: 'Username is required' }, 400)
    }
    
    const { updateUsername } = await import('./utils/auth-helpers')
    await updateUsername(c.env.DB, user.id, body.username)
    
    return c.json({ success: true, message: 'Username updated successfully' })
  } catch (error) {
    console.error('❌ [User API] Failed to update username:', error)
    const errorMessage = error instanceof Error ? error.message : 'Failed to update username'
    return c.json({ success: false, error: errorMessage }, 400)
  }
})

// ============================================================================
// Admin 관련 API
// ============================================================================

// Admin API: Seed all jobs to D1
app.post('/api/admin/seed-jobs', requireAdmin, async (c) => {
  // Phase 3 Day 3: JWT 기반 인증으로 변경
  // requireAdmin 미들웨어가 이미 권한 체크를 수행함
  // 기존 토큰 기반 인증은 하위 호환성을 위해 유지 (선택 사항)
  
  // background 파라미터로 백그라운드 실행 여부 결정
  const background = c.req.query('background') === 'true'
  
  try {
    // 새 ETL 스크립트 사용 (seedAllJobs는 삭제됨)
    return c.json({ 
      error: 'This endpoint is deprecated. Please use the new ETL scripts in src/scripts/etl/' 
    }, 501)
    
    /*
    if (background) {
      // 백그라운드로 실행
      const seedPromise = Promise.resolve({}).catch((err: unknown) => {
        console.error('❌ Seed failed:', err)
        return {
          total: 0,
          processed: 0,
          inserted: 0,
          updated: 0,
          skipped: 0,
          errors: 1,
          errorDetails: [{ id: 'system', name: 'System', error: err.message }],
          startTime: Date.now()
        }
      })
      
      if (c.executionCtx && 'waitUntil' in c.executionCtx) {
        c.executionCtx.waitUntil(seedPromise)
      }
      
      return c.json({ 
        message: 'Seed started in background',
        estimatedTime: '약 3-5분 (500+ 직업 × 0.5초)',
        note: 'PM2 logs를 확인하세요: pm2 logs careerwiki --nostream'
      })
    } else {
      // 동기 실행 - 완료될 때까지 기다림
      console.log('🌱 Starting seed job synchronously...')
      return c.json({ error: 'Deprecated' }, 501)
    }
    */
  } catch (error: unknown) {
    console.error('❌ Seed start failed:', error)
    const errorMessage = error instanceof Error ? error.message : String(error)
    return c.json({ 
      error: 'Failed to start seed',
      details: errorMessage 
    }, 500)
  }
})

// ============================================
// Phase 4: 편집 시스템 API 엔드포인트
// ============================================

// 직업 편집 (단일 필드 또는 다중 필드 지원)
app.post('/api/job/:id/edit', requireJobMajorEdit, async (c) => {
  try {
    const jobId = c.req.param('id')
    const user = getOptionalUser(c)
    let body: any
    
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }
    
    // IP 해시 생성
    const ipAddress = c.req.header('cf-connecting-ip') ?? null
    const ipHash = await hashIpAddress(ipAddress)
    
    // 다중 필드 편집 (새로운 방식)
    if (body.fields && typeof body.fields === 'object') {
      const fields = body.fields as Record<string, any>
      const sources = body.sources as Record<string, { url?: string; text?: string; delete?: boolean }> | undefined
      const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined
      
      // 디버그: 리스트 필드 순서 확인
      if (fields['overviewWork.main']) {
      }
      
      if (Object.keys(fields).length === 0) {
        return c.json({ success: false, error: 'No fields to update' }, 400)
      }
      
      // 길이 검증 (최대 길이만 체크, 최소 길이는 체크하지 않음 - 빈 필드도 허용)
      for (const [key, value] of Object.entries(fields)) {
        if (typeof value === 'string' && value.length > 7000) {
          return c.json({ success: false, error: `${key}: 최대 7000자까지 입력 가능합니다` }, 400)
        }
      }
      
      // 출처는 URL이 아니어도 됨 (텍스트 출처 허용)
      // URL 검증 제거됨
      
      // 현재 데이터 조회
      const job = await c.env.DB.prepare('SELECT * FROM jobs WHERE id = ? AND is_active = 1')
        .bind(jobId)
        .first()
      
      if (!job) {
        return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
      }
      
      // 기존 user_contributed_json 파싱
      let userData: Record<string, any> = {}
      try {
        userData = job.user_contributed_json ? JSON.parse(job.user_contributed_json as string) : {}
      } catch { userData = {} }
      
      // 중첩 필드 처리 (예: 'overviewWork.main' -> { overviewWork: { main: value } })
      const flattenToNested = (flatFields: Record<string, any>): Record<string, any> => {
        const result: Record<string, any> = {}
        for (const [key, value] of Object.entries(flatFields)) {
          const parts = key.split('.')
          let current = result
          for (let i = 0; i < parts.length - 1; i++) {
            if (!current[parts[i]]) current[parts[i]] = {}
            current = current[parts[i]]
          }
          current[parts[parts.length - 1]] = value
        }
        return result
      }
      
      // 기존 데이터와 병합
      const nestedFields = flattenToNested(fields)
      const deepMerge = (target: any, source: any): any => {
        for (const key of Object.keys(source)) {
          if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
            target[key] = deepMerge(target[key] || {}, source[key])
          } else {
            target[key] = source[key]
          }
        }
        return target
      }
      
      const updatedUserData = deepMerge({ ...userData }, nestedFields)
      
      // 변경 전 값 저장 (비교 기능용)
      const previousValues: Record<string, any> = {}
      for (const key of Object.keys(fields)) {
        // 중첩된 키 처리 (예: overviewWork.main)
        const parts = key.split('.')
        let value: any = userData
        for (const part of parts) {
          value = value?.[part]
        }
        previousValues[key] = value ?? null
      }
      
      // 출처 데이터 저장 (URL 또는 텍스트) - 여러 개 지원
      if (sources && Object.keys(sources).length > 0) {
        updatedUserData._sources = updatedUserData._sources || {}
        // 기존 _sources에서 최대 id 추출 (배열/객체 모두 대응)
        const existingIds: number[] = []
        Object.values(updatedUserData._sources).forEach((val: any) => {
          if (Array.isArray(val)) {
            val.forEach(v => v?.id && existingIds.push(v.id))
          } else if (val?.id) {
            existingIds.push(val.id)
          }
        })
        let nextId = Math.max(0, ...existingIds) + 1

        for (const [key, source] of Object.entries(sources)) {
          if ((source as any)?.delete) {
            delete updatedUserData._sources[key]
            continue
          }

          // 배열 형태로 수신 (여러 개)
          const sourceArray = Array.isArray(source)
            ? source
            : [source]
          const normalized = sourceArray
            .map((s: any) => (s?.text || s?.url || '').trim())
            .filter(Boolean)
            .map(text => ({ id: nextId++, text }))

          if (normalized.length > 0) {
            updatedUserData._sources[key] = normalized
          }
        }
      }
      
      // _sources가 비어있으면 삭제
      if (updatedUserData._sources && Object.keys(updatedUserData._sources).length === 0) {
        delete updatedUserData._sources
      }
      
      const now = Date.now()
      
      // merged_profile_json 업데이트 (user_contributed_json과 병합)
      let currentMerged: any = {}
      try {
        currentMerged = job.merged_profile_json ? JSON.parse(job.merged_profile_json as string) : {}
      } catch { /* ignore */ }
      
      // _sources는 통째로 덮어쓰기 (삭제 반영을 위해)
      if (currentMerged._sources) {
        delete currentMerged._sources
      }
      
      // 깊은 병합 함수
      const deepMergeForUpdate = (target: any, source: any): any => {
        if (!source) return target
        if (!target) return source
        const result = { ...target }
        for (const key of Object.keys(source)) {
          if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
            result[key] = deepMergeForUpdate(result[key] || {}, source[key])
          } else if (source[key] !== undefined) {
            result[key] = source[key]
          }
        }
        return result
      }
      
      const updatedMerged = deepMergeForUpdate(currentMerged, updatedUserData)
      
      // DB 업데이트 (merged_profile_json도 함께 업데이트)
      await c.env.DB.prepare(`
        UPDATE jobs SET user_contributed_json = ?, merged_profile_json = ?, user_last_updated_at = ?
        WHERE id = ?
      `).bind(JSON.stringify(updatedUserData), JSON.stringify(updatedMerged), now, jobId).run()
      
      // Revision 생성
      const { createRevision, getCurrentRevision } = await import('./services/revisionService')
      
      // 기존 리비전이 없으면 원본 상태를 r1으로 먼저 저장
      const existingRevision = await getCurrentRevision(c.env.DB, 'job', jobId)
      if (!existingRevision) {
        // 원본 상태를 r1으로 저장 (편집 전 상태)
        await createRevision(c.env.DB, {
          entityType: 'job',
          entityId: jobId,
          dataSnapshot: previousValues,  // 편집 전 원본 값
          previousValues: {},
          editorId: null,
          editorType: 'system',
          editorName: '원본',
          ipHash: null,
          changeType: 'initial',
          changeSummary: '원본 버전',
          changedFields: Object.keys(previousValues),
          storeFullSnapshot: true
        })
      }
      
      const revision = await createRevision(c.env.DB, {
        entityType: 'job',
        entityId: jobId,
        dataSnapshot: fields,  // 변경된 필드 값만
        previousValues,  // 변경 전 값
        editorId: user?.id?.toString() ?? null,
        editorType: (['user', 'expert', 'admin'].includes(user?.role || '') ? user?.role : 'anonymous') as 'user' | 'expert' | 'admin' | 'anonymous',
        editorName: user?.username ?? (ipHash ? `익명` : '익명 사용자'),
        ipHash: ipHash ?? null,
        changeType: 'edit',
        changeSummary: `${Object.keys(fields).length}개 필드 수정`,
        changedFields: Object.keys(fields),
        storeFullSnapshot: false
      })
      
      // 캐시 무효화
      await invalidatePageCache(c.env.DB, { jobId, pageType: 'job' })
      
      return c.json({
        success: true,
        revisionId: revision.id,
        message: 'Edit saved successfully'
      })
    }
    
    // 단일 필드 편집 (기존 방식 호환)
    const field = typeof body.field === 'string' ? body.field : ''
    const content = typeof body.content === 'string' ? body.content : ''
    const source = typeof body.source === 'string' ? body.source : ''
    const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined
    const anonymous = Boolean(body.anonymous)
    const password = typeof body.password === 'string' ? body.password : undefined
    
    // 필수 필드 검증 (field, content는 필수, source는 선택)
    if (!field || !content) {
      return c.json({ success: false, error: 'field and content are required' }, 400)
    }
    
    // 출처는 URL이 아니어도 됨 (텍스트 출처 허용)
    
    // 편집 서비스 호출
    const result = await editJob(c.env.DB, jobId, {
      field,
      content,
      source,
      changeSummary,
      anonymous,
      password,
      ipHash: ipHash ?? undefined,
      userId: user?.id?.toString(),
      editorType: user?.role as 'user' | 'expert' | 'admin' | undefined
    })
    
    // 캐시 무효화
    await invalidatePageCache(c.env.DB, {
      jobId: jobId,
      pageType: 'job'
    })
    
    return c.json({
      success: true,
      revisionId: result.revisionId,
      message: 'Edit saved successfully'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'edit failed'
    const status = message.includes('NOT_FOUND') ? 404 
      : message.includes('REQUIRED') || message.includes('INVALID') ? 400
      : message.includes('LIMIT') ? 403
      : 500
    
    return c.json({ success: false, error: message }, status)
  }
})

// 직업 숨기기/삭제 (운영자/관리자 전용)
// ?permanent=true 면 완전 삭제 (DB에서 제거), 없으면 숨기기 (soft delete)
app.delete('/api/job/:id', requireAuth, async (c) => {
  try {
    const jobId = c.req.param('id')
    const permanent = c.req.query('permanent') === 'true'
    const user = c.get('user')
    
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    // 운영자/관리자 권한 체크
    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }
    
    // 직업 존재 확인 (숨겨진 것도 포함)
    const job = await c.env.DB.prepare('SELECT id, name, is_active FROM jobs WHERE id = ?')
      .bind(jobId)
      .first<{ id: string; name: string; is_active: number }>()
    
    if (!job) {
      return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
    }
    
    // 캐시 무효화 (먼저 실행)
    await invalidatePageCache(c.env.DB, { jobId, pageType: 'job' })
    
    if (permanent) {
      // 완전 삭제: DB에서 제거 (revisions도 함께 삭제)
      try {
        await c.env.DB.prepare('DELETE FROM revisions WHERE entity_type = ? AND entity_id = ?')
          .bind('job', jobId)
          .run()
      } catch (e) {
        // revisions 테이블이 없어도 무시
        console.log('[Job Delete] Revisions table may not exist, skipping:', e)
      }
      
      await c.env.DB.prepare('DELETE FROM jobs WHERE id = ?')
        .bind(jobId)
        .run()
      
      console.log(`[Job Permanent Delete] Job "${job.name}" (${jobId}) permanently deleted by ${user.username || user.email}`)
      
      return c.json({
        success: true,
        message: `직업 "${job.name}"이(가) 완전히 삭제되었습니다. (복구 불가)`
      })
    } else {
      // 숨기기: soft delete (is_active = 0)
      await c.env.DB.prepare('UPDATE jobs SET is_active = 0, user_last_updated_at = ? WHERE id = ?')
        .bind(Date.now(), jobId)
        .run()
      
      console.log(`[Job Hide] Job "${job.name}" (${jobId}) hidden by ${user.username || user.email}`)
      
      return c.json({
        success: true,
        message: `직업 "${job.name}"이(가) 숨겨졌습니다. (관리자만 볼 수 있음)`
      })
    }
  } catch (error) {
    console.error('[Job Delete] Error:', error)
    return c.json({ success: false, error: 'DELETE_FAILED' }, 500)
  }
})

// 직업 복구 (운영자/관리자 전용) - 숨긴 직업 다시 활성화
app.post('/api/job/:id/restore', requireAuth, async (c) => {
  try {
    const jobId = c.req.param('id')
    const user = c.get('user')
    
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    // 운영자/관리자 권한 체크
    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }
    
    // 숨겨진 직업 확인
    const job = await c.env.DB.prepare('SELECT id, name, is_active FROM jobs WHERE id = ?')
      .bind(jobId)
      .first<{ id: string; name: string; is_active: number }>()
    
    if (!job) {
      return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
    }
    
    if (job.is_active === 1) {
      return c.json({ success: false, error: 'ALREADY_ACTIVE' }, 400)
    }
    
    // 복구 (is_active = 1)
    await c.env.DB.prepare('UPDATE jobs SET is_active = 1, user_last_updated_at = ? WHERE id = ?')
      .bind(Date.now(), jobId)
      .run()
    
    console.log(`[Job Restore] Job "${job.name}" (${jobId}) restored by ${user.username || user.email}`)
    
    return c.json({
      success: true,
      message: `직업 "${job.name}"이(가) 복구되었습니다.`
    })
  } catch (error) {
    console.error('[Job Restore] Error:', error)
    return c.json({ success: false, error: 'RESTORE_FAILED' }, 500)
  }
})

// 숨겨진 직업 목록 조회 (운영자/관리자 전용)
app.get('/api/job/hidden', requireAuth, async (c) => {
  try {
    const user = c.get('user')
    
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    // 운영자/관리자 권한 체크
    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }
    
    const jobs = await c.env.DB.prepare(`
      SELECT id, name, slug, user_last_updated_at 
      FROM jobs 
      WHERE is_active = 0 
      ORDER BY user_last_updated_at DESC
    `).all<{ id: string; name: string; slug: string | null; user_last_updated_at: number }>()
    
    return c.json({
      success: true,
      jobs: jobs.results || []
    })
  } catch (error) {
    console.error('[Job Hidden List] Error:', error)
    return c.json({ success: false, error: 'FETCH_FAILED' }, 500)
  }
})

// 직업 생성 (일반 사용자)
app.post('/api/job/create', requireAuth, async (c) => {
  try {
    const user = c.get('user')
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    let body: any
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }
    
    const name = typeof body.name === 'string' ? body.name.trim() : ''
    const summary = typeof body.summary === 'string' ? body.summary.trim() : ''
    const heroTags = Array.isArray(body.heroTags) ? body.heroTags : []
    const heroCategory = typeof body.heroCategory === 'string' ? body.heroCategory.trim() : ''
    
    // 필수 필드 검증
    if (!name || name.length < 2) {
      return c.json({ success: false, error: '직업명은 최소 2자 이상이어야 합니다' }, 400)
    }
    if (!summary || summary.length < 2) {
      return c.json({ success: false, error: '설명은 최소 2자 이상이어야 합니다' }, 400)
    }
    
    // ID 생성 (이름 기반 slug)
    const slug = name.replace(/[\s\-\/\.·ㆍ,()]+/g, '-').toLowerCase()
    const id = `U_${slug}_${Date.now().toString(36)}`  // U_ prefix for user-created
    
    // 중복 확인
    const existing = await c.env.DB.prepare(
      'SELECT id FROM jobs WHERE name = ? AND is_active = 1'
    ).bind(name).first()
    
    if (existing) {
      return c.json({ success: false, error: '이미 존재하는 직업입니다' }, 400)
    }
    
    // user_contributed_json 데이터 구성
    const userData: Record<string, any> = {
      summary,
      overview: {
        summary
      }
    }
    if (heroTags.length > 0) {
      userData.heroTags = [...new Set(heroTags.filter((t: any) => typeof t === 'string' && t.trim()))]
    }
    if (heroCategory) {
      userData.heroCategory = heroCategory
    }
    
    // merged_profile_json 생성 (페이지 렌더링에 필요)
    const mergedProfile = {
      id,
      name,
      summary,
      heroTags: userData.heroTags || [],
      heroCategory: userData.heroCategory || '',
      source: 'USER' as const
    }
    
    // URL용 slug 생성
    const urlSlug = name.replace(/[\s]+/g, '-').toLowerCase()
    
    const now = Date.now()
    
    // jobs 테이블에 INSERT (merged_profile_json, slug 포함)
    console.log('[API] Inserting job:', { id, name, urlSlug, now })
    try {
      await c.env.DB.prepare(`
        INSERT INTO jobs (id, name, slug, user_contributed_json, merged_profile_json, user_last_updated_at, created_at, is_active, primary_source)
        VALUES (?, ?, ?, ?, ?, ?, ?, 1, 'USER')
      `).bind(
        id,
        name,
        urlSlug,
        JSON.stringify(userData),
        JSON.stringify(mergedProfile),
        now,
        now
      ).run()
      console.log('[API] Job inserted successfully')
    } catch (insertError) {
      console.error('[API] Job INSERT failed:', insertError)
      throw insertError
    }
    
    // 초기 revision 생성
    console.log('[API] Creating revision...')
    try {
      const { createRevision } = await import('./services/revisionService')
      await createRevision(c.env.DB, {
        entityType: 'job',
        entityId: id,
        dataSnapshot: { id, name, ...userData },
        editorId: user.id.toString(),
        editorType: user.role as 'user' | 'expert' | 'admin',
        editorName: user.username || `User ${user.id}`,
        changeType: 'initial',
        changeSummary: '직업 생성',
        changedFields: Object.keys(userData),
        storeFullSnapshot: true
      })
      console.log('[API] Revision created successfully')
    } catch (revisionError) {
      console.error('[API] Revision creation failed:', revisionError)
      throw revisionError
    }
    
    // 자동 이미지 생성 (동기 방식 - API 키가 있는 경우에만)
    let imageUrl: string | undefined
    let imagePrompt: string | undefined
    
    const geminiKey = (c.env as any).GEMINI_API_KEY
    const evolinkKey = (c.env as any).EVOLINK_API_KEY
    const uploadsR2 = (c.env as any).UPLOADS as R2Bucket | undefined
    
    if (geminiKey && evolinkKey && uploadsR2) {
      try {
        console.log(`[API] Starting auto image generation for job: ${name}`)
        const { generateJobImage } = await import('./services/autoImageService')
        const baseUrl = new URL(c.req.url).origin
        
        const imageResult = await generateJobImage(
          { GEMINI_API_KEY: geminiKey, EVOLINK_API_KEY: evolinkKey, UPLOADS: uploadsR2 },
          name,
          urlSlug,
          baseUrl
        )
        
        if (imageResult.success) {
          imageUrl = imageResult.imageUrl
          imagePrompt = imageResult.imagePrompt
          
          // DB 업데이트
          await c.env.DB.prepare(`
            UPDATE jobs SET image_url = ?, image_prompt = ? WHERE id = ?
          `).bind(imageUrl, imagePrompt, id).run()
          
          console.log(`[API] Auto image generated for job ${name}: ${imageUrl}`)
        } else {
          // 이미지 생성 실패해도 프롬프트는 저장
          if (imageResult.imagePrompt) {
            await c.env.DB.prepare(`
              UPDATE jobs SET image_prompt = ? WHERE id = ?
            `).bind(imageResult.imagePrompt, id).run()
            imagePrompt = imageResult.imagePrompt
          }
          console.warn(`[API] Auto image failed for job ${name}: ${imageResult.error}`)
        }
      } catch (imageError) {
        console.error('[API] Auto image generation error:', imageError)
        // 이미지 생성 실패해도 직업 생성은 성공으로 처리
      }
    } else {
      console.log('[API] Skipping auto image: API keys not configured')
    }
    
    return c.json({
      success: true,
      id,
      slug: urlSlug,
      imageUrl,
      imagePrompt,
      message: '직업이 생성되었습니다'
    }, 201)
    
  } catch (error) {
    console.error('[API] Create job error:', error)
    const message = error instanceof Error ? error.message : 'create failed'
    return c.json({ success: false, error: message }, 500)
  }
})

// 전공 숨기기/삭제 (운영자/관리자 전용)
// ?permanent=true 면 완전 삭제 (DB에서 제거), 없으면 숨기기 (soft delete)
app.delete('/api/major/:id', requireAuth, async (c) => {
  try {
    const majorId = c.req.param('id')
    const permanent = c.req.query('permanent') === 'true'
    const user = c.get('user')
    
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    // 운영자/관리자 권한 체크
    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }
    
    // 전공 존재 확인 (숨겨진 것도 포함)
    const major = await c.env.DB.prepare('SELECT id, name, is_active FROM majors WHERE id = ?')
      .bind(majorId)
      .first<{ id: string; name: string; is_active: number }>()
    
    if (!major) {
      return c.json({ success: false, error: 'MAJOR_NOT_FOUND' }, 404)
    }
    
    // 캐시 무효화 (먼저 실행)
    await invalidatePageCache(c.env.DB, { majorId, pageType: 'major' })
    
    if (permanent) {
      // 완전 삭제: DB에서 제거 (revisions도 함께 삭제)
      try {
        await c.env.DB.prepare('DELETE FROM revisions WHERE entity_type = ? AND entity_id = ?')
          .bind('major', majorId)
          .run()
      } catch (e) {
        // revisions 테이블이 없어도 무시
        console.log('[Major Delete] Revisions table may not exist, skipping:', e)
      }
      
      await c.env.DB.prepare('DELETE FROM majors WHERE id = ?')
        .bind(majorId)
        .run()
      
      console.log(`[Major Permanent Delete] Major "${major.name}" (${majorId}) permanently deleted by ${user.username || user.email}`)
      
      return c.json({
        success: true,
        message: `전공 "${major.name}"이(가) 완전히 삭제되었습니다. (복구 불가)`
      })
    } else {
      // 숨기기: soft delete (is_active = 0)
      await c.env.DB.prepare('UPDATE majors SET is_active = 0, user_last_updated_at = ? WHERE id = ?')
        .bind(Date.now(), majorId)
        .run()
      
      console.log(`[Major Hide] Major "${major.name}" (${majorId}) hidden by ${user.username || user.email}`)
      
      return c.json({
        success: true,
        message: `전공 "${major.name}"이(가) 숨겨졌습니다. (관리자만 볼 수 있음)`
      })
    }
  } catch (error) {
    console.error('[Major Delete] Error:', error)
    return c.json({ success: false, error: 'DELETE_FAILED' }, 500)
  }
})

// 전공 복구 (운영자/관리자 전용) - 숨긴 전공 다시 활성화
app.post('/api/major/:id/restore', requireAuth, async (c) => {
  try {
    const majorId = c.req.param('id')
    const user = c.get('user')
    
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    // 운영자/관리자 권한 체크
    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }
    
    // 숨겨진 전공 확인
    const major = await c.env.DB.prepare('SELECT id, name, is_active FROM majors WHERE id = ?')
      .bind(majorId)
      .first<{ id: string; name: string; is_active: number }>()
    
    if (!major) {
      return c.json({ success: false, error: 'MAJOR_NOT_FOUND' }, 404)
    }
    
    if (major.is_active === 1) {
      return c.json({ success: false, error: 'ALREADY_ACTIVE' }, 400)
    }
    
    // 복구 (is_active = 1)
    await c.env.DB.prepare('UPDATE majors SET is_active = 1, user_last_updated_at = ? WHERE id = ?')
      .bind(Date.now(), majorId)
      .run()
    
    console.log(`[Major Restore] Major "${major.name}" (${majorId}) restored by ${user.username || user.email}`)
    
    return c.json({
      success: true,
      message: `전공 "${major.name}"이(가) 복구되었습니다.`
    })
  } catch (error) {
    console.error('[Major Restore] Error:', error)
    return c.json({ success: false, error: 'RESTORE_FAILED' }, 500)
  }
})

// 숨겨진 전공 목록 조회 (운영자/관리자 전용)
app.get('/api/major/hidden', requireAuth, async (c) => {
  try {
    const user = c.get('user')
    
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    // 운영자/관리자 권한 체크
    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }
    
    const majors = await c.env.DB.prepare(`
      SELECT id, name, slug, user_last_updated_at 
      FROM majors 
      WHERE is_active = 0 
      ORDER BY user_last_updated_at DESC
    `).all<{ id: string; name: string; slug: string | null; user_last_updated_at: number }>()
    
    return c.json({
      success: true,
      majors: majors.results || []
    })
  } catch (error) {
    console.error('[Major Hidden List] Error:', error)
    return c.json({ success: false, error: 'FETCH_FAILED' }, 500)
  }
})

// 전공 생성 (일반 사용자)
app.post('/api/major/create', requireAuth, async (c) => {
  try {
    const user = c.get('user')
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    let body: any
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }
    
    const name = typeof body.name === 'string' ? body.name.trim() : ''
    const summary = typeof body.summary === 'string' ? body.summary.trim() : ''
    const heroTags = Array.isArray(body.heroTags) ? body.heroTags : []
    const categoryName = typeof body.categoryName === 'string' ? body.categoryName.trim() : ''
    
    // 필수 필드 검증
    if (!name || name.length < 2) {
      return c.json({ success: false, error: '전공명은 최소 2자 이상이어야 합니다' }, 400)
    }
    if (!summary || summary.length < 2) {
      return c.json({ success: false, error: '설명은 최소 2자 이상이어야 합니다' }, 400)
    }
    
    // ID 생성 (이름 기반 slug)
    const slug = name.replace(/[\s\-\/\.·ㆍ,()]+/g, '-').toLowerCase()
    const id = `U_${slug}_${Date.now().toString(36)}`  // U_ prefix for user-created
    
    // 중복 확인
    const existing = await c.env.DB.prepare(
      'SELECT id FROM majors WHERE name = ? AND is_active = 1'
    ).bind(name).first()
    
    if (existing) {
      return c.json({ success: false, error: '이미 존재하는 전공입니다' }, 400)
    }
    
    // user_contributed_json 데이터 구성
    const userData: Record<string, any> = {
      summary
    }
    if (heroTags.length > 0) {
      userData.heroTags = [...new Set(heroTags.filter((t: any) => typeof t === 'string' && t.trim()))]
    }
    if (categoryName) {
      userData.categoryName = categoryName
    }
    
    // merged_profile_json 생성 (페이지 렌더링에 필요)
    const mergedProfile = {
      id,
      name,
      summary,
      overview: { summary },
      heroTags: userData.heroTags || [],
      categoryName: userData.categoryName || '',
      source: 'USER' as const
    }
    
    // URL용 slug 생성
    const urlSlug = name.replace(/[\s]+/g, '-').toLowerCase()
    
    const now = Date.now()
    
    // majors 테이블에 INSERT (merged_profile_json, slug 포함)
    await c.env.DB.prepare(`
      INSERT INTO majors (id, name, slug, user_contributed_json, merged_profile_json, user_last_updated_at, created_at, is_active, primary_source)
      VALUES (?, ?, ?, ?, ?, ?, ?, 1, 'USER')
    `).bind(
      id,
      name,
      urlSlug,
      JSON.stringify(userData),
      JSON.stringify(mergedProfile),
      now,
      now
    ).run()
    
    // 초기 revision 생성
    const { createRevision } = await import('./services/revisionService')
    await createRevision(c.env.DB, {
      entityType: 'major',
      entityId: id,
      dataSnapshot: { id, name, ...userData },
      editorId: user.id.toString(),
      editorType: user.role as 'user' | 'expert' | 'admin',
      editorName: user.username || `User ${user.id}`,
      changeType: 'initial',
      changeSummary: '전공 생성',
      changedFields: Object.keys(userData),
      storeFullSnapshot: true
    })
    
    // 자동 이미지 생성 (동기 방식 - API 키가 있는 경우에만)
    let imageUrl: string | undefined
    let imagePrompt: string | undefined
    
    const geminiKey = (c.env as any).GEMINI_API_KEY
    const evolinkKey = (c.env as any).EVOLINK_API_KEY
    const uploadsR2 = (c.env as any).UPLOADS as R2Bucket | undefined
    
    if (geminiKey && evolinkKey && uploadsR2) {
      try {
        console.log(`[API] Starting auto image generation for major: ${name}`)
        const { generateMajorImage } = await import('./services/autoImageService')
        const baseUrl = new URL(c.req.url).origin
        
        const imageResult = await generateMajorImage(
          { GEMINI_API_KEY: geminiKey, EVOLINK_API_KEY: evolinkKey, UPLOADS: uploadsR2 },
          name,
          urlSlug,
          baseUrl
        )
        
        if (imageResult.success) {
          imageUrl = imageResult.imageUrl
          imagePrompt = imageResult.imagePrompt
          
          // DB 업데이트
          await c.env.DB.prepare(`
            UPDATE majors SET image_url = ?, image_prompt = ? WHERE id = ?
          `).bind(imageUrl, imagePrompt, id).run()
          
          console.log(`[API] Auto image generated for major ${name}: ${imageUrl}`)
        } else {
          // 이미지 생성 실패해도 프롬프트는 저장
          if (imageResult.imagePrompt) {
            await c.env.DB.prepare(`
              UPDATE majors SET image_prompt = ? WHERE id = ?
            `).bind(imageResult.imagePrompt, id).run()
            imagePrompt = imageResult.imagePrompt
          }
          console.warn(`[API] Auto image failed for major ${name}: ${imageResult.error}`)
        }
      } catch (imageError) {
        console.error('[API] Auto image generation error:', imageError)
        // 이미지 생성 실패해도 전공 생성은 성공으로 처리
      }
    } else {
      console.log('[API] Skipping auto image: API keys not configured')
    }
    
    return c.json({
      success: true,
      id,
      slug: urlSlug,
      imageUrl,
      imagePrompt,
      message: '전공이 생성되었습니다'
    }, 201)
    
  } catch (error) {
    console.error('[API] Create major error:', error)
    const message = error instanceof Error ? error.message : 'create failed'
    return c.json({ success: false, error: message }, 500)
  }
})

// 직업 생성 (관리자 전용)
app.post('/api/admin/job', requireAdmin, async (c) => {
  try {
    const user = c.get('user')
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    let body: any
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }
    
    const id = typeof body.id === 'string' ? body.id.trim() : ''
    const name = typeof body.name === 'string' ? body.name.trim() : ''
    const summary = typeof body.summary === 'string' ? body.summary : undefined
    const duties = typeof body.duties === 'string' ? body.duties : undefined
    const salary = typeof body.salary === 'string' ? body.salary : undefined
    const prospect = typeof body.prospect === 'string' ? body.prospect : undefined
    const way = typeof body.way === 'string' ? body.way : undefined
    
    if (!id) {
      return c.json({ success: false, error: 'id is required' }, 400)
    }
    if (!name) {
      return c.json({ success: false, error: 'name is required' }, 400)
    }
    
    const result = await createJob(c.env.DB, {
      id,
      name,
      summary,
      duties,
      salary,
      prospect,
      way,
      userId: user.id.toString()
    })
    
    return c.json({
      success: true,
      id: result.id,
      revisionId: result.revisionId,
      message: 'Job created successfully'
    }, 201)
  } catch (error) {
    const message = error instanceof Error ? error.message : 'create failed'
    console.error('[admin job create] Error:', error)
    
    const status = message.includes('REQUIRED') ? 400
      : message.includes('ALREADY_EXISTS') ? 409
      : message.includes('LOGIN') ? 401
      : 500
    
    return c.json({ success: false, error: message }, status)
  }
})

// 전공 생성 (관리자 전용)
app.post('/api/admin/major', requireAdmin, async (c) => {
  try {
    const user = c.get('user')
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    let body: any
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }
    
    const id = typeof body.id === 'string' ? body.id.trim() : ''
    const name = typeof body.name === 'string' ? body.name.trim() : ''
    const summary = typeof body.summary === 'string' ? body.summary : undefined
    const property = typeof body.property === 'string' ? body.property : undefined
    const aptitude = typeof body.aptitude === 'string' ? body.aptitude : undefined
    const whatStudy = typeof body.whatStudy === 'string' ? body.whatStudy : undefined
    const howPrepare = typeof body.howPrepare === 'string' ? body.howPrepare : undefined
    const enterField = typeof body.enterField === 'string' ? body.enterField : undefined
    
    if (!id) {
      return c.json({ success: false, error: 'id is required' }, 400)
    }
    if (!name) {
      return c.json({ success: false, error: 'name is required' }, 400)
    }
    
    const result = await createMajor(c.env.DB, {
      id,
      name,
      summary,
      property,
      aptitude,
      whatStudy,
      howPrepare,
      enterField,
      userId: user.id.toString()
    })
    
    return c.json({
      success: true,
      id: result.id,
      revisionId: result.revisionId,
      message: 'Major created successfully'
    }, 201)
  } catch (error) {
    const message = error instanceof Error ? error.message : 'create failed'
    console.error('[admin major create] Error:', error)
    
    const status = message.includes('REQUIRED') ? 400
      : message.includes('ALREADY_EXISTS') ? 409
      : message.includes('LOGIN') ? 401
      : 500
    
    return c.json({ success: false, error: message }, status)
  }
})

// 전공 편집 (단일 필드 또는 다중 필드 지원)
app.post('/api/major/:id/edit', requireJobMajorEdit, async (c) => {
  try {
    const majorIdParam = c.req.param('id')
    const user = getOptionalUser(c)
    let body: any
    
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }
    
    // IP 해시 생성
    const ipAddress = c.req.header('cf-connecting-ip') ?? null
    const ipHash = await hashIpAddress(ipAddress)
    
    // 실제 DB ID로 변환 (공통 로직)
    let majorId = majorIdParam
    let majorRecord = await c.env.DB.prepare('SELECT * FROM majors WHERE id = ? AND is_active = 1')
      .bind(majorId)
      .first()
    
    // ID로 찾지 못한 경우 slug로 시도
    if (!majorRecord) {
      let extractedId = majorId
      if (majorId.includes(':')) {
        const parts = majorId.split(':')
        if (parts.length > 1) {
          extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          majorRecord = await c.env.DB.prepare('SELECT * FROM majors WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first()
          if (majorRecord) majorId = extractedId
        }
      }
      
      if (!majorRecord) {
        const decodedSlug = decodeURIComponent(majorId)
        const normalizedSlug = decodedSlug.toLowerCase()
        
        majorRecord = await c.env.DB.prepare(
          'SELECT * FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first()
        
        if (!majorRecord) {
          majorRecord = await c.env.DB.prepare(
            'SELECT * FROM majors WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first()
        }
        
        if (!majorRecord) {
          majorRecord = await c.env.DB.prepare(
            'SELECT * FROM majors WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(decodedSlug).first()
        }
        
        if (majorRecord) majorId = majorRecord.id as string
      }
    }
    
    if (!majorRecord) {
      console.error(`[major edit] Major not found. Searched with: ${majorIdParam}`)
      return c.json({ success: false, error: 'MAJOR_NOT_FOUND' }, 404)
    }
    
    // 다중 필드 편집 (새로운 방식)
    if (body.fields && typeof body.fields === 'object') {
      const fields = body.fields as Record<string, any>
      const sources = body.sources as Record<string, { url?: string; text?: string; delete?: boolean }> | undefined
      const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined
      
      if (Object.keys(fields).length === 0) {
        return c.json({ success: false, error: 'No fields to update' }, 400)
      }
      
      // 길이 검증 (최대 길이만 체크, 최소 길이는 체크하지 않음 - 빈 필드도 허용)
      for (const [key, value] of Object.entries(fields)) {
        if (typeof value === 'string' && value.length > 7000) {
          return c.json({ success: false, error: `${key}: 최대 7000자까지 입력 가능합니다` }, 400)
        }
      }
      
      // 출처는 URL이 아니어도 됨 (텍스트 출처 허용)
      // URL 검증 제거됨
      
      // 기존 user_contributed_json 파싱
      let userData: Record<string, any> = {}
      try {
        userData = majorRecord.user_contributed_json ? JSON.parse(majorRecord.user_contributed_json as string) : {}
      } catch { userData = {} }
      
      // 중첩 필드 처리
      const flattenToNested = (flatFields: Record<string, any>): Record<string, any> => {
        const result: Record<string, any> = {}
        for (const [key, value] of Object.entries(flatFields)) {
          const parts = key.split('.')
          let current = result
          for (let i = 0; i < parts.length - 1; i++) {
            if (!current[parts[i]]) current[parts[i]] = {}
            current = current[parts[i]]
          }
          current[parts[parts.length - 1]] = value
        }
        return result
      }
      // 기존 데이터와 병합
      const nestedFields = flattenToNested(fields)
      const deepMerge = (target: any, source: any): any => {
        for (const key of Object.keys(source)) {
          if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
            target[key] = deepMerge(target[key] || {}, source[key])
          } else {
            target[key] = source[key]
          }
        }
        return target
      }
      const updatedUserData = deepMerge({ ...userData }, nestedFields)
      // trivia가 저장될 때 기존 jobProspect 제거 (여담/진로전망 분리)
      if (nestedFields.trivia && updatedUserData.jobProspect) {
        delete updatedUserData.jobProspect
      }

      // 변경 전 값 저장 (비교 기능용)
      const previousValues: Record<string, any> = {}
      for (const key of Object.keys(fields)) {
        const parts = key.split('.')
        let value: any = userData
        for (const part of parts) {
          value = value?.[part]
        }
        previousValues[key] = value ?? null
      }
      
      // 출처 데이터 저장 (URL 또는 텍스트) - 여러 개 지원
      if (sources && Object.keys(sources).length > 0) {
        updatedUserData._sources = updatedUserData._sources || {}
        // 기존 _sources에서 최대 id 추출 (배열/객체 모두 대응)
        const existingIds: number[] = []
        Object.values(updatedUserData._sources).forEach((val: any) => {
          if (Array.isArray(val)) {
            val.forEach(v => v?.id && existingIds.push(v.id))
          } else if (val?.id) {
            existingIds.push(val.id)
          }
        })
        let nextId = Math.max(0, ...existingIds) + 1

        for (const [key, source] of Object.entries(sources)) {
          if ((source as any)?.delete) {
            delete updatedUserData._sources[key]
            continue
          }

          // 배열 형태로 수신 (여러 개)
          const sourceArray = Array.isArray(source)
            ? source
            : [source]
          const normalized = sourceArray
            .map((s: any) => (s?.text || s?.url || '').trim())
            .filter(Boolean)
            .map(text => ({ id: nextId++, text }))

          if (normalized.length > 0) {
            updatedUserData._sources[key] = normalized
          }
        }
      }
      
      // _sources가 비어있으면 삭제
      if (updatedUserData._sources && Object.keys(updatedUserData._sources).length === 0) {
        delete updatedUserData._sources
      }
      
      const now = Date.now()
      
      // merged_profile_json 업데이트 (user_contributed_json과 병합)
      let currentMerged: any = {}
      try {
        currentMerged = majorRecord.merged_profile_json ? JSON.parse(majorRecord.merged_profile_json as string) : {}
      } catch { /* ignore */ }
      
      // _sources는 통째로 덮어쓰기 (삭제 반영을 위해)
      if (currentMerged._sources) {
        delete currentMerged._sources
      }
      
      // 깊은 병합 함수
      const deepMergeForUpdate = (target: any, source: any): any => {
        if (!source) return target
        if (!target) return source
        const result = { ...target }
        for (const key of Object.keys(source)) {
          if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
            result[key] = deepMergeForUpdate(result[key] || {}, source[key])
          } else if (source[key] !== undefined) {
            result[key] = source[key]
          }
        }
        return result
      }
      
      const updatedMerged = deepMergeForUpdate(currentMerged, updatedUserData)
      
      // trivia가 있으면 merged에서도 jobProspect 제거 (여담/진로전망 분리)
      if (updatedUserData.trivia && updatedMerged.jobProspect) {
        delete updatedMerged.jobProspect
      }
      
      // DB 업데이트 (merged_profile_json도 함께 업데이트)
      await c.env.DB.prepare(`
        UPDATE majors SET user_contributed_json = ?, merged_profile_json = ?, user_last_updated_at = ?
        WHERE id = ?
      `).bind(JSON.stringify(updatedUserData), JSON.stringify(updatedMerged), now, majorId).run()
      
      // Revision 생성
      const { createRevision, getCurrentRevision } = await import('./services/revisionService')
      
      // 기존 리비전이 없으면 원본 상태를 r1으로 먼저 저장 (전체 스냅샷)
      const existingRevision = await getCurrentRevision(c.env.DB, 'major', majorId)
      if (!existingRevision) {
        const originalSnapshot = currentMerged || {}
        // 원본 상태를 r1으로 저장 (편집 전 상태, 전체 스냅샷)
        await createRevision(c.env.DB, {
          entityType: 'major',
          entityId: majorId,
          dataSnapshot: originalSnapshot,  // 편집 전 전체 값
          previousValues: {},
          editorId: null,
          editorType: 'system',
          editorName: '원본',
          ipHash: null,
          changeType: 'initial',
          changeSummary: '원본 버전',
          changedFields: Object.keys(originalSnapshot),
          storeFullSnapshot: true
        })
      }
      
      const revision = await createRevision(c.env.DB, {
        entityType: 'major',
        entityId: majorId,
        dataSnapshot: updatedMerged,  // 변경 후 전체 값
        previousValues,  // 변경 전 값 (변경된 필드만)
        editorId: user?.id?.toString() ?? null,
        editorType: (['user', 'expert', 'admin'].includes(user?.role || '') ? user?.role : 'anonymous') as 'user' | 'expert' | 'admin' | 'anonymous',
        editorName: user?.username ?? (ipHash ? `익명` : '익명 사용자'),
        ipHash: ipHash ?? null,
        changeType: 'edit',
        changeSummary: `${Object.keys(fields).length}개 필드 수정`,
        changedFields: Object.keys(fields),
        storeFullSnapshot: true
      })
      
      // 캐시 무효화
      await invalidatePageCache(c.env.DB, { majorId, pageType: 'major' })
      
      return c.json({
        success: true,
        revisionId: revision.id,
        message: 'Edit saved successfully'
      })
    }
    
    // 단일 필드 편집 (기존 방식 호환)
    const field = typeof body.field === 'string' ? body.field : ''
    const content = typeof body.content === 'string' ? body.content : ''
    const source = typeof body.source === 'string' ? body.source : ''
    const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined
    const anonymous = Boolean(body.anonymous)
    const password = typeof body.password === 'string' ? body.password : undefined
    
    // 필수 필드 검증
    if (!field || !content) {
      return c.json({ success: false, error: 'field and content are required' }, 400)
    }
    
    // 출처는 URL이 아니어도 됨 (텍스트 출처 허용)
    
    const result = await editMajor(c.env.DB, majorId, {
      field,
      content,
      source,
      changeSummary,
      anonymous,
      password,
      ipHash: ipHash ?? undefined,
      userId: user?.id?.toString(),
      editorType: user?.role as 'user' | 'expert' | 'admin' | undefined
    })
    
    await invalidatePageCache(c.env.DB, {
      majorId: majorId,
      pageType: 'major'
    })
    
    return c.json({
      success: true,
      revisionId: result.revisionId,
      message: 'Edit saved successfully'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'edit failed'
    console.error(`[major edit] Error:`, error)
    const status = message.includes('NOT_FOUND') ? 404 
      : message.includes('REQUIRED') || message.includes('INVALID') ? 400
      : message.includes('LIMIT') ? 403
      : 500
    
    return c.json({ success: false, error: message }, status)
  }
})

// HowTo 생성 (로그인 필수)
app.post('/api/howto', requireAuth, async (c) => {
  try {
    const user = c.get('user')
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    let body: any
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }
    
    const title = typeof body.title === 'string' ? body.title.trim() : ''
    const slug = typeof body.slug === 'string' ? body.slug.trim() : ''
    const summary = typeof body.summary === 'string' ? body.summary.trim() : ''
    const content = typeof body.content === 'string' ? body.content : ''
    
    // 필수 필드 검증
    if (!title) {
      return c.json({ success: false, error: 'title is required' }, 400)
    }
    if (!slug) {
      return c.json({ success: false, error: 'slug is required' }, 400)
    }
    if (!summary) {
      return c.json({ success: false, error: 'summary is required' }, 400)
    }
    if (!content) {
      return c.json({ success: false, error: 'content is required' }, 400)
    }
    
    const result = await createHowTo(c.env.DB, {
      title,
      slug,
      summary,
      content,
      userId: user.id.toString(),
      editorType: user.role as 'user' | 'expert' | 'admin'
    })
    
    return c.json({
      success: true,
      slug: result.slug,
      revisionId: result.revisionId,
      message: 'HowTo created successfully'
    }, 201)
  } catch (error) {
    const message = error instanceof Error ? error.message : 'create failed'
    console.error('[howto create] Error:', error)
    
    const status = message.includes('REQUIRED') ? 400
      : message.includes('INVALID') ? 400
      : message.includes('ALREADY_EXISTS') ? 409
      : message.includes('LOGIN') ? 401
      : 500
    
    return c.json({ success: false, error: message }, status)
  }
})

// HowTo 편집 (로그인 필수, 본인 글만 - admin 제외)
app.post('/api/howto/:slug/edit', requireHowToEdit, async (c) => {
  try {
    const slug = c.req.param('slug')
    const user = c.get('user')  // requireHowToEdit에서 이미 로그인 확인됨
    
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }
    
    let body: any
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }
    
    const content = typeof body.content === 'string' ? body.content : ''
    const source = typeof body.source === 'string' ? body.source : undefined
    const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined
    
    if (!content) {
      return c.json({ success: false, error: 'content is required' }, 400)
    }
    
    const result = await editHowTo(c.env.DB, slug, {
      content,
      source,
      changeSummary,
      userId: user.id.toString(),
      editorType: user.role as 'user' | 'expert' | 'admin'
    })
    
    await invalidatePageCache(c.env.DB, {
      slug,
      pageType: 'guide'
    })
    
    return c.json({
      success: true,
      revisionId: result.revisionId,
      message: 'Edit saved successfully'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'edit failed'
    console.error('[howto edit] Error:', error)
    
    const status = message.includes('NOT_FOUND') ? 404 
      : message.includes('NOT_AUTHOR') ? 403
      : message.includes('LOGIN_REQUIRED') ? 401
      : message.includes('REQUIRED') || message.includes('INVALID') ? 400
      : message.includes('LIMIT') ? 403
      : 500
    
    return c.json({ success: false, error: message }, status)
  }
})

// =====================================================
// 슬러그 API
// =====================================================

// 슬러그 생성 및 중복 체크
app.get('/api/slug/check', authMiddleware, async (c) => {
  try {
    const title = c.req.query('title')
    const excludeId = c.req.query('excludeId')
    
    if (!title) {
      return c.json({ success: false, error: 'title 파라미터가 필요합니다' }, 400)
    }
    
    const { checkAndGenerateUniqueSlug, generateSlug } = await import('./services/slugService')
    
    // 슬러그 생성
    const baseSlug = generateSlug(title)
    
    // 중복 체크
    const result = await checkAndGenerateUniqueSlug(
      c.env.DB, 
      title, 
      excludeId ? parseInt(excludeId) : undefined
    )
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 400)
    }
    
    return c.json({
      success: true,
      baseSlug,
      slug: result.slug,
      isUnique: result.isUnique,
      hasSuffix: result.slug !== baseSlug
    })
  } catch (error) {
    console.error('[slug check] Error:', error)
    return c.json({ success: false, error: '슬러그 생성 중 오류가 발생했습니다' }, 500)
  }
})

// 슬러그 유효성 검증
app.get('/api/slug/validate', authMiddleware, async (c) => {
  try {
    const slug = c.req.query('slug')
    
    if (!slug) {
      return c.json({ success: false, error: 'slug 파라미터가 필요합니다' }, 400)
    }
    
    const { validateSlug } = await import('./services/slugService')
    const result = validateSlug(slug)
    
    return c.json({ success: true, valid: result.valid, error: result.error })
  } catch (error) {
    console.error('[slug validate] Error:', error)
    return c.json({ success: false, error: '검증 중 오류가 발생했습니다' }, 500)
  }
})

// =====================================================
// 통합 검색 API (자동완성)
// =====================================================

// 통합 검색 (domain: jobs, majors, howtos, tags)
app.get('/api/search', authMiddleware, async (c) => {
  try {
    const domain = c.req.query('domain') as 'jobs' | 'majors' | 'howtos' | 'tags'
    const query = c.req.query('q') || ''
    const limit = parseInt(c.req.query('limit') || '10')
    const typeahead = c.req.query('typeahead') !== 'false'
    
    if (!domain || !['jobs', 'majors', 'howtos', 'tags'].includes(domain)) {
      return c.json({ success: false, error: 'domain 파라미터가 필요합니다 (jobs, majors, howtos, tags)' }, 400)
    }
    
    const { search } = await import('./services/searchService')
    const result = await search(c.env.DB, { domain, query, limit, typeahead })
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }
    
    return c.json({ success: true, results: result.results })
  } catch (error) {
    console.error('[search] Error:', error)
    return c.json({ success: false, error: '검색 중 오류가 발생했습니다' }, 500)
  }
})

// 존재 검증 (선택 강제형)
app.get('/api/search/validate', authMiddleware, async (c) => {
  try {
    const domain = c.req.query('domain') as 'jobs' | 'majors' | 'howtos' | 'tags'
    const id = c.req.query('id')
    
    if (!domain || !id) {
      return c.json({ success: false, error: 'domain과 id 파라미터가 필요합니다' }, 400)
    }
    
    const { validateExists } = await import('./services/searchService')
    const result = await validateExists(c.env.DB, domain, id)
    
    return c.json({ success: true, exists: result.exists, data: result.data })
  } catch (error) {
    console.error('[validate] Error:', error)
    return c.json({ success: false, error: '검증 중 오류가 발생했습니다' }, 500)
  }
})

// 인기 태그
app.get('/api/tags/popular', async (c) => {
  try {
    const limit = parseInt(c.req.query('limit') || '20')
    
    const { getPopularTags } = await import('./services/searchService')
    const result = await getPopularTags(c.env.DB, limit)
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }
    
    return c.json({ success: true, tags: result.tags })
  } catch (error) {
    console.error('[popular tags] Error:', error)
    return c.json({ success: false, error: '태그 조회 중 오류가 발생했습니다' }, 500)
  }
})

// =====================================================
// 초안 API (HowTo Editor)
// =====================================================

// 새 초안 생성
app.post('/api/howto/drafts', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const body = await c.req.json()
    
    const { createDraft, updateDraft } = await import('./services/draftService')
    const result = await createDraft(c.env.DB, {
      userId: user.id,
      baseHowtoId: body.baseHowtoId,
      title: body.title,
      slug: body.slug,
      summary: body.summary,
      thumbnailUrl: body.thumbnailUrl,
      contentJson: body.contentJson,
      contentHtml: body.contentHtml
    })
    
    if (!result.success || !result.draftId) {
      return c.json({ success: false, error: result.error }, 400)
    }
    
    // 관련 항목들 저장 (태그, 관련 직업/전공/HowTo)
    const draftId = result.draftId
    const tags = body.tags || []
    const relatedJobs = body.relatedJobs || []
    const relatedMajors = body.relatedMajors || []
    const relatedHowtos = body.relatedHowtos || []
    
    // 태그 저장
    for (const tagName of tags) {
      if (!tagName || !String(tagName).trim()) continue
      const trimmed = String(tagName).trim()
      
      let tag = await c.env.DB.prepare(`SELECT id FROM tags WHERE name = ?`).bind(trimmed).first<{ id: number }>()
      if (!tag) {
        const tagSlug = trimmed.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9가-힣-]/g, '')
        const tagResult = await c.env.DB.prepare(`INSERT INTO tags (name, slug) VALUES (?, ?)`).bind(trimmed, tagSlug).run()
        tag = { id: Number(tagResult.meta.last_row_id) }
      }
      await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_tags (draft_id, tag_id) VALUES (?, ?)`).bind(draftId, tag.id).run()
    }
    
    // 관련 직업 저장
    for (let i = 0; i < relatedJobs.length; i++) {
      const job = relatedJobs[i]
      const jobId = job.id || job.slug || job.name
      if (jobId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_jobs (draft_id, job_id, display_order) VALUES (?, ?, ?)`).bind(draftId, String(jobId), i).run()
      }
    }
    
    // 관련 전공 저장
    for (let i = 0; i < relatedMajors.length; i++) {
      const major = relatedMajors[i]
      const majorId = major.id || major.slug || major.name
      if (majorId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_majors (draft_id, major_id, display_order) VALUES (?, ?, ?)`).bind(draftId, String(majorId), i).run()
      }
    }
    
    // 관련 HowTo 저장
    for (let i = 0; i < relatedHowtos.length; i++) {
      const howto = relatedHowtos[i]
      const howtoId = howto.id || howto.slug || howto.name
      if (howtoId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_howtos (draft_id, howto_id, display_order) VALUES (?, ?, ?)`).bind(draftId, String(howtoId), i).run()
      }
    }
    
    return c.json({ success: true, draftId: draftId }, 201)
  } catch (error) {
    console.error('[create draft] Error:', error)
    return c.json({ success: false, error: '초안 생성 중 오류가 발생했습니다' }, 500)
  }
})

// 제목 중복 체크
app.get('/api/howto/check-title', async (c) => {
  try {
    const title = c.req.query('title')?.trim()
    const excludeId = c.req.query('excludeId')
    
    if (!title) {
      return c.json({ success: false, error: '제목이 필요합니다' }, 400)
    }
    
    if (title.length < 2) {
      return c.json({ 
        success: true, 
        available: false, 
        reason: '제목은 최소 2자 이상이어야 합니다' 
      })
    }
    
    // 정확히 같은 제목이 있는지 확인 (대소문자 무시)
    let query = `
      SELECT id, title FROM pages 
      WHERE page_type = 'guide' 
        AND status IN ('published', 'draft_published')
        AND LOWER(title) = LOWER(?)
    `
    const bindings: any[] = [title]
    
    if (excludeId) {
      query += ` AND id != ?`
      bindings.push(parseInt(excludeId))
    }
    
    query += ` LIMIT 1`
    
    const existing = await c.env.DB.prepare(query).bind(...bindings).first<{ id: number; title: string }>()
    
    if (existing) {
      return c.json({ 
        success: true, 
        available: false, 
        reason: `이미 같은 제목의 가이드가 존재합니다` 
      })
    }
    
    return c.json({ success: true, available: true })
  } catch (error) {
    console.error('[check-title] Error:', error)
    return c.json({ success: false, error: '제목 확인 중 오류가 발생했습니다' }, 500)
  }
})

// 직업 분류 목록 조회
app.get('/api/job/categories', async (c) => {
  try {
    const q = c.req.query('q')?.trim().toLowerCase() || ''
    const limit = parseInt(c.req.query('limit') || '20')
    
    // 직업 분류 목록 (실제 데이터에서 추출)
    // heroCategory, category, jobType 등에서 추출
    let query = `
      SELECT DISTINCT 
        COALESCE(
          JSON_EXTRACT(user_contributed_json, '$.heroCategory'),
          JSON_EXTRACT(admin_data_json, '$.heroCategory'),
          JSON_EXTRACT(api_data_json, '$.category'),
          JSON_EXTRACT(api_data_json, '$.jobType')
        ) as category
      FROM jobs
      WHERE is_active = 1
        AND category IS NOT NULL
        AND category != ''
    `
    
    if (q) {
      query += ` AND LOWER(category) LIKE '%' || ? || '%'`
    }
    
    query += ` ORDER BY category LIMIT ?`
    
    const bindings = q ? [q, limit] : [limit]
    const result = await c.env.DB.prepare(query).bind(...bindings).all<{ category: string }>()
    
    const categories = result.results
      ?.map(r => r.category)
      .filter(c => c && c.trim()) || []
    
    // 기본 분류 목록 추가 (검색어와 매칭되는 것만)
    const defaultCategories = [
      '경영/사무', '영업/마케팅', '연구개발', 'IT/소프트웨어', '디자인', 
      '미디어/콘텐츠', '교육', '의료/보건', '법률/법무', '금융/보험',
      '건설/토목', '제조/생산', '물류/유통', '서비스', '예술/문화',
      '스포츠/레저', '농림어업', '공무원', '군인/경찰', '기타'
    ]
    
    const filtered = q 
      ? defaultCategories.filter(c => c.toLowerCase().includes(q))
      : defaultCategories
    
    // 기존 데이터와 기본 목록 병합 (중복 제거)
    const allCategories = [...new Set([...categories, ...filtered])].slice(0, limit)
    
    return c.json({ success: true, categories: allCategories })
  } catch (error) {
    console.error('[job-categories] Error:', error)
    return c.json({ success: true, categories: [] })
  }
})

// 전공 계열 목록 조회
app.get('/api/major/categories', async (c) => {
  try {
    const q = c.req.query('q')?.trim().toLowerCase() || ''
    const limit = parseInt(c.req.query('limit') || '20')
    
    // 전공 계열 목록 (실제 데이터에서 추출)
    let query = `
      SELECT DISTINCT 
        COALESCE(
          JSON_EXTRACT(user_contributed_json, '$.categoryName'),
          JSON_EXTRACT(admin_data_json, '$.categoryName'),
          JSON_EXTRACT(api_data_json, '$.facilMajorCategory')
        ) as category
      FROM majors
      WHERE is_active = 1
        AND category IS NOT NULL
        AND category != ''
    `
    
    if (q) {
      query += ` AND LOWER(category) LIKE '%' || ? || '%'`
    }
    
    query += ` ORDER BY category LIMIT ?`
    
    const bindings = q ? [q, limit] : [limit]
    const result = await c.env.DB.prepare(query).bind(...bindings).all<{ category: string }>()
    
    const categories = result.results
      ?.map(r => r.category)
      .filter(c => c && c.trim()) || []
    
    // 기본 계열 목록 추가 (검색어와 매칭되는 것만)
    const defaultCategories = [
      '인문계열', '사회계열', '교육계열', '공학계열', '자연계열',
      '의약계열', '예체능계열', '농림수산계열'
    ]
    
    const filtered = q 
      ? defaultCategories.filter(c => c.toLowerCase().includes(q))
      : defaultCategories
    
    // 기존 데이터와 기본 목록 병합 (중복 제거)
    const allCategories = [...new Set([...categories, ...filtered])].slice(0, limit)
    
    return c.json({ success: true, categories: allCategories })
  } catch (error) {
    console.error('[major-categories] Error:', error)
    return c.json({ success: true, categories: [] })
  }
})

// 직업 이름 중복 체크
app.get('/api/job/check-name', async (c) => {
  try {
    const name = c.req.query('name')?.trim()
    
    if (!name) {
      return c.json({ success: false, error: '직업명이 필요합니다' }, 400)
    }
    
    if (name.length < 2) {
      return c.json({ 
        success: true, 
        available: false, 
        reason: '직업명은 최소 2자 이상이어야 합니다' 
      })
    }
    
    // 정확히 같은 이름이 있는지 확인 (대소문자 무시)
    const existing = await c.env.DB.prepare(`
      SELECT id, name FROM jobs 
      WHERE LOWER(name) = LOWER(?) AND is_active = 1
      LIMIT 1
    `).bind(name).first<{ id: string; name: string }>()
    
    if (existing) {
      return c.json({ 
        success: true, 
        available: false, 
        reason: `이미 같은 이름의 직업이 존재합니다: "${existing.name}"`,
        existingId: existing.id,
        existingName: existing.name
      })
    }
    
    return c.json({ success: true, available: true })
  } catch (error) {
    console.error('[check-job-name] Error:', error)
    return c.json({ success: false, error: '직업명 확인 중 오류가 발생했습니다' }, 500)
  }
})

// 전공 이름 중복 체크
app.get('/api/major/check-name', async (c) => {
  try {
    const name = c.req.query('name')?.trim()
    
    if (!name) {
      return c.json({ success: false, error: '전공명이 필요합니다' }, 400)
    }
    
    if (name.length < 2) {
      return c.json({ 
        success: true, 
        available: false, 
        reason: '전공명은 최소 2자 이상이어야 합니다' 
      })
    }
    
    // 정확히 같은 이름이 있는지 확인 (대소문자 무시)
    const existing = await c.env.DB.prepare(`
      SELECT id, name FROM majors 
      WHERE LOWER(name) = LOWER(?) AND is_active = 1
      LIMIT 1
    `).bind(name).first<{ id: string; name: string }>()
    
    if (existing) {
      return c.json({ 
        success: true, 
        available: false, 
        reason: `이미 같은 이름의 전공이 존재합니다: "${existing.name}"`,
        existingId: existing.id,
        existingName: existing.name
      })
    }
    
    return c.json({ success: true, available: true })
  } catch (error) {
    console.error('[check-major-name] Error:', error)
    return c.json({ success: false, error: '전공명 확인 중 오류가 발생했습니다' }, 500)
  }
})

// 내 초안 목록
app.get('/api/howto/drafts', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const limit = parseInt(c.req.query('limit') || '20')
    const offset = parseInt(c.req.query('offset') || '0')
    const stage = c.req.query('stage')
    
    const { listMyDrafts } = await import('./services/draftService')
    const result = await listMyDrafts(c.env.DB, user.id, { limit, offset, stage })
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }
    
    return c.json({ success: true, drafts: result.drafts, total: result.total })
  } catch (error) {
    console.error('[list drafts] Error:', error)
    return c.json({ success: false, error: '초안 목록 조회 중 오류가 발생했습니다' }, 500)
  }
})

// 초안 조회
app.get('/api/howto/drafts/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))
    
    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }
    
    const { getDraft } = await import('./services/draftService')
    const result = await getDraft(c.env.DB, draftId, user.id)
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 404)
    }
    
    return c.json({ success: true, draft: result.draft })
  } catch (error) {
    console.error('[get draft] Error:', error)
    return c.json({ success: false, error: '초안 조회 중 오류가 발생했습니다' }, 500)
  }
})

// 초안 업데이트 (낙관적 락)
app.put('/api/howto/drafts/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))
    const ifMatch = c.req.header('If-Match')
    
    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }
    
    // 버전 헤더 필수
    if (!ifMatch) {
      return c.json({ success: false, error: 'If-Match 헤더가 필요합니다 (버전 관리)' }, 428)
    }
    
    const expectedVersion = parseInt(ifMatch)
    if (!Number.isFinite(expectedVersion)) {
      return c.json({ success: false, error: '유효하지 않은 버전입니다' }, 400)
    }
    
    const body = await c.req.json()
    
    const { updateDraft } = await import('./services/draftService')
    const result = await updateDraft(c.env.DB, draftId, user.id, expectedVersion, {
      title: body.title,
      slug: body.slug,
      summary: body.summary,
      thumbnailUrl: body.thumbnailUrl,
      contentJson: body.contentJson,
      contentHtml: body.contentHtml,
      tags: body.tags,
      relatedJobs: body.relatedJobs,
      relatedMajors: body.relatedMajors,
      relatedHowtos: body.relatedHowtos
    })
    
    if (!result.success) {
      // 버전 충돌
      if (result.error === 'VERSION_CONFLICT') {
        return c.json({ 
          success: false, 
          error: '버전 충돌이 발생했습니다. 다른 곳에서 수정되었습니다.',
          serverVersion: result.serverVersion 
        }, 409)
      }
      return c.json({ success: false, error: result.error }, 400)
    }
    
    return c.json({ success: true, version: result.newVersion })
  } catch (error) {
    console.error('[update draft] Error:', error)
    return c.json({ success: false, error: '초안 업데이트 중 오류가 발생했습니다' }, 500)
  }
})

// 초안 삭제
app.delete('/api/howto/drafts/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))
    
    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }
    
    const { deleteDraft } = await import('./services/draftService')
    const result = await deleteDraft(c.env.DB, draftId, user.id)
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 404)
    }
    
    return c.json({ success: true })
  } catch (error) {
    console.error('[delete draft] Error:', error)
    return c.json({ success: false, error: '초안 삭제 중 오류가 발생했습니다' }, 500)
  }
})

// 검수 요청 (레거시 - 사용 안함)
app.post('/api/howto/drafts/:id/submit', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))
    
    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }
    
    const { submitForReview } = await import('./services/draftService')
    const result = await submitForReview(c.env.DB, draftId, user.id)
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 400)
    }
    
    return c.json({ success: true, message: '검수 요청이 완료되었습니다' })
  } catch (error) {
    console.error('[submit draft] Error:', error)
    return c.json({ success: false, error: '검수 요청 중 오류가 발생했습니다' }, 500)
  }
})

// 바로 발행 API (새 글 작성에서 바로 published 상태로)
app.post('/api/howto/publish-direct', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const body = await c.req.json()
    
    // 사용자 ID 필수 체크 (고아 데이터 방지)
    if (!user || !user.id) {
      console.error('[publish-direct] Error: user.id is missing', user)
      return c.json({ success: false, error: '로그인이 필요합니다' }, 401)
    }
    
    const { draftId, title, summary, contentJson, contentHtml, tags, relatedJobs, relatedMajors, relatedHowtos, thumbnailUrl } = body
    
    // 필수 필드 체크
    if (!title || !title.trim()) {
      return c.json({ success: false, error: '제목을 입력해주세요' }, 400)
    }
    if (!contentJson || contentJson === '{}') {
      return c.json({ success: false, error: '본문을 입력해주세요' }, 400)
    }
    
    const now = new Date().toISOString()
    
    // draft가 있으면 기존 페이지 확인
    let existingPageId: number | null = null
    let existingSlug: string | null = null
    
    console.log('[publish-direct] Input:', { draftId, title, userId: user.id })
    
    if (draftId) {
      const draftInfo = await c.env.DB.prepare(`
        SELECT published_page_id, slug FROM howto_drafts WHERE id = ? AND user_id = ?
      `).bind(draftId, user.id).first<{ published_page_id: number | null; slug: string | null }>()
      
      console.log('[publish-direct] Draft info:', draftInfo)
      
      if (draftInfo?.published_page_id) {
        existingPageId = draftInfo.published_page_id
        existingSlug = draftInfo.slug
      }
    }
    
    console.log('[publish-direct] existingPageId:', existingPageId, 'existingSlug:', existingSlug)
    
    // HTML 생성 (Tiptap JSON → HTML)
    let finalContentHtml = contentHtml || ''
    let footnotes: Array<{ id: number; text: string; url?: string }> = []
    let firstImageUrl = ''
    try {
      const contentObj = JSON.parse(contentJson)
      finalContentHtml = convertTiptapToHtml(contentObj)
      footnotes = extractFootnotes(contentObj)
      firstImageUrl = extractFirstImage(contentObj)
    } catch {}
    
    const finalThumbnail = thumbnailUrl || firstImageUrl || ''
    
    // meta_data 구성
    const metaData = JSON.stringify({
      contentJson,
      tags: tags || [],
      relatedJobs: relatedJobs || [],
      relatedMajors: relatedMajors || [],
      relatedHowtos: relatedHowtos || [],
      footnotes,
      authorName: user.username || user.email?.split('@')[0] || '작성자',
      thumbnailUrl: finalThumbnail
    })
    
    let pageId: number | null = null
    let slug: string
    
    // 슬러그는 항상 제목에서 새로 생성 (corrupted slug 방지)
    const { generateSlug } = await import('./services/slugService')
    let baseSlug = cleanGuidePrefix(generateSlug(title))
    slug = baseSlug
    
    if (existingPageId) {
      // 기존 페이지 업데이트 (status를 published로 변경)
      // 기존 페이지의 슬러그를 유지 (existingSlug 사용)
      slug = cleanGuidePrefix(existingSlug || '') || slug
      
      await c.env.DB.prepare(`
        UPDATE pages SET
          slug = ?, title = ?, summary = ?, content = ?, meta_data = ?,
          status = 'published', updated_at = ?
        WHERE id = ? AND page_type = 'guide'
      `).bind(slug, title, summary || '', finalContentHtml, metaData, now, existingPageId).run()
      pageId = existingPageId
      
      // draft의 slug도 정리
      if (draftId) {
        await c.env.DB.prepare(`
          UPDATE howto_drafts SET slug = ? WHERE id = ?
        `).bind(slug, draftId).run()
      }
    } else {
      // 새 페이지 생성
      let suffix = 2
      
      // 중복 체크
      while (suffix <= 100) {
        const existing = await c.env.DB.prepare(
          `SELECT id FROM pages WHERE page_type = 'guide' AND slug = ? LIMIT 1`
        ).bind(slug).first()
        if (!existing) break
        slug = baseSlug + '-' + suffix
        suffix++
      }
      
      const result = await c.env.DB.prepare(`
        INSERT INTO pages (
          page_type, slug, title, summary, content, meta_data,
          status, author_id, source, created_at, updated_at
        ) VALUES (?, ?, ?, ?, ?, ?, 'published', ?, 'user', ?, ?)
      `).bind('guide', slug, title, summary || '', finalContentHtml, metaData, user.id, now, now).run()
      
      if (!result.success) {
        return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
      }
      
      pageId = result.meta.last_row_id ? Number(result.meta.last_row_id) : null
      
      // draft에 published_page_id 연결
      if (draftId && pageId) {
        await c.env.DB.prepare(`
          UPDATE howto_drafts SET published_page_id = ?, slug = ? WHERE id = ?
        `).bind(pageId, slug, draftId).run()
      }
    }
    
    // 관련 콘텐츠 저장 (page_relations 테이블)
    if (pageId) {
      // 관련 직업 추가
      for (const job of (relatedJobs || [])) {
        if (!job.slug) continue
        const jobPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'job'`).bind(job.slug).first<{ id: number }>()
        if (jobPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_job')`)
            .bind(pageId, jobPage.id).run()
        }
      }
      
      // 관련 전공 추가
      for (const major of (relatedMajors || [])) {
        if (!major.slug) continue
        const majorPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'major'`).bind(major.slug).first<{ id: number }>()
        if (majorPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_major')`)
            .bind(pageId, majorPage.id).run()
        }
      }
      
      // 관련 HowTo 추가
      for (const howto of (relatedHowtos || [])) {
        if (!howto.slug) continue
        const howtoPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'`).bind(howto.slug).first<{ id: number }>()
        if (howtoPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_howto')`)
            .bind(pageId, howtoPage.id).run()
        }
      }
    }
    
    return c.json({ success: true, slug, pageId, status: 'published' })
  } catch (error) {
    console.error('[publish-direct] Error:', error)
    return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
  }
})

// 임시 발행 → 정식 발행 API
app.post('/api/howto/:pageId/publish-final', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const pageId = parseInt(c.req.param('pageId'))
    
    if (!Number.isFinite(pageId)) {
      return c.json({ success: false, error: '유효하지 않은 페이지 ID입니다' }, 400)
    }
    
    // 페이지 정보 확인
    const page = await c.env.DB.prepare(`
      SELECT id, author_id, status FROM pages WHERE id = ? AND page_type = 'guide'
    `).bind(pageId).first<{ id: number; author_id: number; status: string }>()
    
    if (!page) {
      return c.json({ success: false, error: '페이지를 찾을 수 없습니다' }, 404)
    }
    
    // 권한 확인 (작성자 또는 관리자)
    const isAuthor = String(user.id) === String(page.author_id)
    const isAdmin = (user.role as string) === 'super-admin' || (user.role as string) === 'operator'
    
    if (!isAuthor && !isAdmin) {
      return c.json({ success: false, error: '권한이 없습니다' }, 403)
    }
    
    // draft_published 상태 확인
    if (page.status !== 'draft_published') {
      return c.json({ success: false, error: '임시 발행 상태가 아닙니다' }, 400)
    }
    
    // 정식 발행으로 상태 변경
    const now = new Date().toISOString()
    await c.env.DB.prepare(`
      UPDATE pages SET status = 'published', updated_at = ? WHERE id = ?
    `).bind(now, pageId).run()
    
    return c.json({ success: true })
  } catch (error) {
    console.error('[publish-final] Error:', error)
    return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
  }
})

// 저장 시 임시 발행 (draft_published) 또는 업데이트 API
app.post('/api/howto/save-publish', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const body = await c.req.json()
    
    // 사용자 ID 필수 체크 (고아 데이터 방지)
    if (!user || !user.id) {
      console.error('[save-publish] Error: user.id is missing', user)
      return c.json({ success: false, error: '로그인이 필요합니다' }, 401)
    }
    
    const { title, summary, contentJson, contentHtml, tags, relatedJobs, relatedMajors, relatedHowtos, thumbnailUrl, forceDraftPublished } = body
    let draftId = body.draftId
    
    // 필수 필드 체크
    if (!title || !title.trim()) {
      return c.json({ success: false, error: '제목을 입력해주세요' }, 400)
    }
    if (!contentJson || contentJson === '{}') {
      return c.json({ success: false, error: '본문을 입력해주세요' }, 400)
    }
    
    const now = new Date().toISOString()
    
    // draftId가 없으면 새 draft 생성
    if (!draftId) {
      const { createDraft } = await import('./services/draftService')
      const draftResult = await createDraft(c.env.DB, {
        userId: user.id,
        title,
        summary,
        thumbnailUrl,
        contentJson,
        contentHtml
      })
      if (!draftResult.success || !draftResult.draftId) {
        return c.json({ success: false, error: draftResult.error || '초안 생성 실패' }, 400)
      }
      draftId = draftResult.draftId
    } else {
      // 기존 draft 업데이트
      await c.env.DB.prepare(`
        UPDATE howto_drafts SET
          title = ?, summary = ?, content_json = ?, content_html = ?, thumbnail_url = ?,
          updated_at = ?, version = version + 1
        WHERE id = ? AND user_id = ?
      `).bind(title, summary || '', contentJson, contentHtml || '', thumbnailUrl || '', now, draftId, user.id).run()
    }
    
    // 기존 발행 페이지 확인
    console.log('[save-publish] Checking draft:', { draftId, userId: user.id })
    
    const draftInfo = await c.env.DB.prepare(`
      SELECT published_page_id, (SELECT status FROM pages WHERE id = published_page_id) as page_status
      FROM howto_drafts WHERE id = ? AND user_id = ?
    `).bind(draftId, user.id).first<{ published_page_id: number | null; page_status: string | null }>()
    
    console.log('[save-publish] Raw draftInfo:', draftInfo)
    
    const publishedPageId = draftInfo?.published_page_id
    const currentStatus = draftInfo?.page_status || ''
    
    console.log('[save-publish] Draft info:', { draftId, publishedPageId, currentStatus, title, userId: user.id })
    
    // 슬러그 생성 (항상 제목에서 새로 생성, guide: prefix 방지)
    const { generateSlug } = await import('./services/slugService')
    let baseSlug = cleanGuidePrefix(generateSlug(title))
    let slug = baseSlug
    let suffix = 2
    
    console.log('[save-publish] Generated slug:', { baseSlug, slug, publishedPageId })
    
    // 중복 체크
    while (suffix <= 100) {
      const existing = await c.env.DB.prepare(
        `SELECT id FROM pages WHERE page_type = 'guide' AND slug = ? ${publishedPageId ? 'AND id != ?' : ''} LIMIT 1`
      ).bind(...(publishedPageId ? [slug, publishedPageId] : [slug])).first()
      if (!existing) break
      slug = baseSlug + '-' + suffix
      suffix++
    }
    
    // HTML 생성 (Tiptap JSON → HTML)
    let finalContentHtml = contentHtml || ''
    let footnotes: Array<{ id: number; text: string; url?: string }> = []
    let firstImageUrl = ''
    try {
      const contentObj = JSON.parse(contentJson)
      finalContentHtml = convertTiptapToHtml(contentObj)
      footnotes = extractFootnotes(contentObj)
      firstImageUrl = extractFirstImage(contentObj)
    } catch {}
    
    const finalThumbnail = thumbnailUrl || firstImageUrl || ''
    
    // meta_data 구성
    const metaData = JSON.stringify({
      contentJson,
      tags: tags || [],
      relatedJobs: relatedJobs || [],
      relatedMajors: relatedMajors || [],
      relatedHowtos: relatedHowtos || [],
      footnotes,
      authorName: user.username || user.email?.split('@')[0] || '작성자',
      thumbnailUrl: finalThumbnail
    })
    
    // 새 상태 결정: forceDraftPublished면 항상 draft_published, 아니면 기존 상태 유지
    const newStatus = forceDraftPublished ? 'draft_published' : (currentStatus === 'published' ? 'published' : 'draft_published')
    
    let finalPageId = publishedPageId
    
    if (publishedPageId) {
      // 기존 페이지 업데이트 - slug도 정리된 값으로 업데이트
      await c.env.DB.prepare(`
        UPDATE pages SET
          slug = ?, title = ?, summary = ?, content = ?, meta_data = ?,
          status = ?, updated_at = ?
        WHERE id = ? AND page_type = 'guide'
      `).bind(slug, title, summary || '', finalContentHtml, metaData, newStatus, now, publishedPageId).run()
      
      // draft의 slug도 정리된 값으로 업데이트
      await c.env.DB.prepare(`
        UPDATE howto_drafts SET slug = ? WHERE id = ?
      `).bind(slug, draftId).run()
    } else {
      // 새 페이지 생성 (draft_published 상태)
      const result = await c.env.DB.prepare(`
        INSERT INTO pages (
          page_type, slug, title, summary, content, meta_data,
          status, author_id, source, created_at, updated_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'user', ?, ?)
      `).bind('guide', slug, title, summary || '', finalContentHtml, metaData, 'draft_published', user.id, now, now).run()
      
      if (result.success && result.meta.last_row_id) {
        finalPageId = Number(result.meta.last_row_id)
        
        // draft에 published_page_id 연결
        await c.env.DB.prepare(`
          UPDATE howto_drafts SET published_page_id = ?, slug = ? WHERE id = ?
        `).bind(finalPageId, slug, draftId).run()
      }
    }
    
    // 관련 콘텐츠 저장 (page_relations 테이블)
    if (finalPageId) {
      // 기존 관계 삭제
      await c.env.DB.prepare(`DELETE FROM page_relations WHERE page_id = ?`).bind(finalPageId).run()
      
      // 관련 직업 추가
      for (const job of (relatedJobs || [])) {
        if (!job.slug) continue
        const jobPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'job'`).bind(job.slug).first<{ id: number }>()
        if (jobPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_job')`)
            .bind(finalPageId, jobPage.id).run()
        }
      }
      
      // 관련 전공 추가
      for (const major of (relatedMajors || [])) {
        if (!major.slug) continue
        const majorPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'major'`).bind(major.slug).first<{ id: number }>()
        if (majorPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_major')`)
            .bind(finalPageId, majorPage.id).run()
        }
      }
      
      // 관련 HowTo 추가
      for (const howto of (relatedHowtos || [])) {
        if (!howto.slug) continue
        const howtoPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'`).bind(howto.slug).first<{ id: number }>()
        if (howtoPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_howto')`)
            .bind(finalPageId, howtoPage.id).run()
        }
      }
    }
    
    return c.json({ success: true, slug, pageId: finalPageId, status: newStatus })
  } catch (error) {
    console.error('[save-publish] Error:', error)
    return c.json({ success: false, error: '저장 중 오류가 발생했습니다' }, 500)
  }
})

// 바로 발행 API
app.post('/api/howto/drafts/:id/publish', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))
    
    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }
    
    // 클라이언트에서 직접 전송한 데이터 받기 (선택적)
    let clientData: any = {}
    try {
      const body = await c.req.text()
      if (body) {
        clientData = JSON.parse(body)
      }
    } catch {}
    
    const { getDraft } = await import('./services/draftService')
    const draft = await getDraft(c.env.DB, draftId, user.id)
    
    if (!draft.success || !draft.draft) {
      return c.json({ success: false, error: draft.error || '초안을 찾을 수 없습니다' }, 404)
    }
    
    const d = draft.draft
    
    // 필수 필드 체크
    if (!d.title || !d.title.trim()) {
      return c.json({ success: false, error: '제목을 입력해주세요' }, 400)
    }
    if (!d.contentJson || d.contentJson === '{}') {
      return c.json({ success: false, error: '본문을 입력해주세요' }, 400)
    }
    
    // published_page_id 확인 (기존 발행 페이지가 있는지)
    const publishedPageId = d.publishedPageId
    
    // 슬러그 생성/확인 (중복 시 자동으로 -2, -3 추가, guide: prefix 방지)
    const { generateSlug } = await import('./services/slugService')
    let baseSlug = cleanGuidePrefix(d.slug || generateSlug(d.title))
    let slug = baseSlug
    let suffix = 2
    
    // pages 테이블에서 중복 체크 (page_type = 'guide', 자기 자신 제외)
    while (suffix <= 100) {
      const existing = await c.env.DB.prepare(
        `SELECT id FROM pages WHERE page_type = 'guide' AND slug = ? ${publishedPageId ? 'AND id != ?' : ''} LIMIT 1`
      ).bind(...(publishedPageId ? [slug, publishedPageId] : [slug])).first()
      if (!existing) break
      slug = baseSlug + '-' + suffix
      suffix++
    }
    
    // HTML 생성 (Tiptap JSON → HTML)
    let contentHtml = ''
    let footnotes: Array<{ id: number; text: string; url?: string }> = []
    let firstImageUrl = ''
    try {
      const contentObj = JSON.parse(d.contentJson)
      contentHtml = convertTiptapToHtml(contentObj)
      // 각주 추출
      footnotes = extractFootnotes(contentObj)
      // 첫 번째 이미지 추출 (썸네일용)
      firstImageUrl = extractFirstImage(contentObj)
    } catch {
      contentHtml = '<p>내용을 불러올 수 없습니다.</p>'
    }
    
    // 썸네일 URL: 명시적으로 지정된 것 > 첫 번째 이미지 > 빈 문자열
    const thumbnailUrl = d.thumbnailUrl || firstImageUrl || ''
    
    // 관련 콘텐츠: 클라이언트에서 전송한 데이터 우선, 없으면 draft에서 가져오기
    const relatedJobs = (clientData.relatedJobs && clientData.relatedJobs.length > 0) 
      ? clientData.relatedJobs 
      : (d.relatedJobs || [])
    const relatedMajors = (clientData.relatedMajors && clientData.relatedMajors.length > 0) 
      ? clientData.relatedMajors 
      : (d.relatedMajors || [])
    const relatedHowtos = (clientData.relatedHowtos && clientData.relatedHowtos.length > 0) 
      ? clientData.relatedHowtos 
      : (d.relatedHowtos || [])
    const tags = (clientData.tags && clientData.tags.length > 0)
      ? clientData.tags
      : (d.tags || [])
    
    // meta_data 구성 (관련 콘텐츠, 태그, 각주 포함)
    const metaData = JSON.stringify({
      contentJson: d.contentJson,
      tags,
      relatedJobs,
      relatedMajors,
      relatedHowtos,
      footnotes,
      authorName: user.username || user.email?.split('@')[0] || '작성자',
      thumbnailUrl
    })
    
    // pages 테이블에 삽입 또는 업데이트
    const now = new Date().toISOString()
    let result
    let finalPageId = publishedPageId
    
    if (publishedPageId) {
      // 기존 페이지 업데이트
      result = await c.env.DB.prepare(`
        UPDATE pages SET
          slug = ?, title = ?, summary = ?, content = ?, meta_data = ?,
          status = 'published', updated_at = ?
        WHERE id = ? AND page_type = 'guide'
      `).bind(
        slug,
        d.title,
        d.summary || '',
        contentHtml,
        metaData,
        now,
        publishedPageId
      ).run()
    } else {
      // 새 페이지 삽입
      result = await c.env.DB.prepare(`
        INSERT INTO pages (
          page_type, slug, title, summary, content, meta_data,
          status, author_id, source, created_at, updated_at
        ) VALUES (?, ?, ?, ?, ?, ?, 'published', ?, 'user', ?, ?)
      `).bind(
        'guide',
        slug,
        d.title,
        d.summary || '',
        contentHtml,
        metaData,
        user.id,
        now,
        now
      ).run()
      
      if (result.success && result.meta.last_row_id) {
        finalPageId = Number(result.meta.last_row_id)
      }
    }
    
    if (!result.success) {
      return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
    }
    
    // 초안 삭제
    await c.env.DB.prepare('DELETE FROM howto_drafts WHERE id = ?').bind(draftId).run()
    
    return c.json({ 
      success: true, 
      message: '발행이 완료되었습니다',
      slug: slug,
      url: '/howto/' + slug
    })
  } catch (error) {
    console.error('[publish draft] Error:', error)
    return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
  }
})

// Tiptap JSON에서 첫 번째 이미지 URL 추출 (썸네일용)
function extractFirstImage(doc: any): string {
  let firstImage = ''
  
  const traverse = (node: any) => {
    if (firstImage) return // 이미 찾았으면 중단
    if (!node) return
    
    if (node.type === 'image' && node.attrs?.src) {
      firstImage = node.attrs.src
      return
    }
    
    if (node.content && Array.isArray(node.content)) {
      for (const child of node.content) {
        traverse(child)
        if (firstImage) break
      }
    }
  }
  
  traverse(doc)
  return firstImage
}

// Tiptap JSON에서 각주 추출
function extractFootnotes(doc: any): Array<{ id: number; text: string; url?: string }> {
  const footnotes: Array<{ id: number; text: string; url?: string }> = []
  
  const traverse = (node: any) => {
    if (!node) return
    
    if (node.type === 'footnote') {
      footnotes.push({
        id: node.attrs?.id || 0,
        text: node.attrs?.text || '',
        url: node.attrs?.url || undefined
      })
    }
    
    if (node.content && Array.isArray(node.content)) {
      node.content.forEach(traverse)
    }
  }
  
  traverse(doc)
  
  // ID로 정렬 후 반환
  return footnotes.sort((a, b) => a.id - b.id)
}

// Tiptap JSON → HTML 변환 헬퍼
function convertTiptapToHtml(doc: any): string {
  if (!doc || !doc.content) return ''
  
  const processNode = (node: any): string => {
    if (!node) return ''
    
    switch (node.type) {
      case 'paragraph':
        const pContent = node.content?.map(processNode).join('') || ''
        const pAlign = node.attrs?.textAlign
        const pStyle = pAlign && pAlign !== 'left' ? ' style="text-align:' + pAlign + '"' : ''
        return pContent ? '<p' + pStyle + '>' + pContent + '</p>' : '<p><br></p>'
      
      case 'text':
        let text = escapeHtml(node.text || '')
        if (node.marks) {
          for (const mark of node.marks) {
            switch (mark.type) {
              case 'bold': text = '<strong>' + text + '</strong>'; break
              case 'italic': text = '<em>' + text + '</em>'; break
              case 'underline': text = '<u>' + text + '</u>'; break
              case 'strike': text = '<s>' + text + '</s>'; break
              case 'code': text = '<code>' + text + '</code>'; break
              case 'link': {
                let href = mark.attrs?.href || '#'
                // 프로토콜 없이 www.로 시작하면 https:// 추가
                if (href.startsWith('www.')) {
                  href = 'https://' + href
                }
                // 프로토콜 없이 도메인처럼 보이면 (. 포함, /나 #으로 시작 안함) https:// 추가
                else if (!href.startsWith('http') && !href.startsWith('/') && !href.startsWith('#') && !href.startsWith('mailto:') && href.includes('.')) {
                  href = 'https://' + href
                }
                // 외부 링크는 새 탭에서 열기
                const isExternal = href.startsWith('http://') || href.startsWith('https://') || href.startsWith('mailto:')
                const targetAttr = isExternal ? ' target="_blank" rel="noopener noreferrer"' : ''
                text = '<a href="' + escapeHtml(href) + '"' + targetAttr + '>' + text + '</a>'
                break
              }
              case 'textStyle': {
                const styles: string[] = []
                if (mark.attrs?.color) styles.push('color:' + mark.attrs.color)
                if (mark.attrs?.fontSize) styles.push('font-size:' + mark.attrs.fontSize)
                if (mark.attrs?.fontFamily) styles.push('font-family:' + mark.attrs.fontFamily)
                if (styles.length) text = '<span style="' + styles.join(';') + '">' + text + '</span>'
                break
              }
              case 'highlight':
                text = '<mark style="background:' + (mark.attrs?.color || '#ffeb3b') + '">' + text + '</mark>'
                break
            }
          }
        }
        return text
      
      case 'heading':
        const level = node.attrs?.level || 1
        const hContent = node.content?.map(processNode).join('') || ''
        const hAlign = node.attrs?.textAlign
        const hStyle = hAlign && hAlign !== 'left' ? ' style="text-align:' + hAlign + '"' : ''
        return '<h' + level + hStyle + '>' + hContent + '</h' + level + '>'
      
      case 'bulletList':
        return '<ul>' + (node.content?.map(processNode).join('') || '') + '</ul>'
      
      case 'orderedList':
        return '<ol>' + (node.content?.map(processNode).join('') || '') + '</ol>'
      
      case 'listItem':
        return '<li>' + (node.content?.map(processNode).join('') || '') + '</li>'
      
      case 'taskList':
        return '<ul class="task-list" data-type="taskList">' + (node.content?.map(processNode).join('') || '') + '</ul>'
      
      case 'taskItem':
        const checked = node.attrs?.checked ? ' checked' : ''
        const dataChecked = node.attrs?.checked ? ' data-checked="true"' : ''
        return '<li class="task-item"' + dataChecked + '><label><input type="checkbox"' + checked + '></label><div>' + (node.content?.map(processNode).join('') || '') + '</div></li>'
      
      case 'blockquote':
        const bqAlign = node.attrs?.align || 'left'
        const bqSize = node.attrs?.size || 'medium'
        const bqClass = `blockquote-align-${bqAlign} blockquote-size-${bqSize}`
        return '<blockquote class="' + bqClass + '" data-align="' + bqAlign + '" data-size="' + bqSize + '">' + (node.content?.map(processNode).join('') || '') + '</blockquote>'
      
      case 'codeBlock':
        return '<pre><code>' + escapeHtml(node.content?.[0]?.text || '') + '</code></pre>'
      
      case 'horizontalRule':
        return '<hr>'
      
      case 'image':
        const imgSrc = node.attrs?.src || ''
        const imgAlt = node.attrs?.alt || ''
        const imgWidth = node.attrs?.width
        const imgHeight = node.attrs?.height
        const imgAlign = node.attrs?.align || 'center'
        
        let imgStyle = ''
        if (imgWidth) imgStyle += 'width:' + imgWidth + 'px;'
        if (imgHeight) imgStyle += 'height:' + imgHeight + 'px;'
        
        const imgAttrs = ' src="' + escapeHtml(imgSrc) + '" alt="' + escapeHtml(imgAlt) + '"' +
          (imgStyle ? ' style="' + imgStyle + '"' : '') +
          ' loading="lazy" class="rounded-lg"'
        
        return '<figure class="image-wrapper image-align-' + imgAlign + '" data-align="' + imgAlign + '"><img' + imgAttrs + '></figure>'
      
      case 'table':
        return '<table>' + (node.content?.map(processNode).join('') || '') + '</table>'
      
      case 'tableRow':
        return '<tr>' + (node.content?.map(processNode).join('') || '') + '</tr>'
      
      case 'tableCell':
        const cellBg = node.attrs?.backgroundColor
        const cellStyle = cellBg ? ' style="background-color:' + cellBg + '"' : ''
        return '<td' + cellStyle + '>' + (node.content?.map(processNode).join('') || '') + '</td>'
      
      case 'tableHeader':
        return '<th>' + (node.content?.map(processNode).join('') || '') + '</th>'
      
      // 커스텀 노드들
      case 'checkpointBox':
        return '<div class="checkpoint-box">' + (node.content?.map(processNode).join('') || '') + '</div>'
      
      case 'conclusionBox':
        return '<div class="conclusion-box">' + (node.content?.map(processNode).join('') || '') + '</div>'
      
      case 'qnaBlock':
        return '<div class="qna-block">' + (node.content?.map(processNode).join('') || '') + '</div>'
      
      case 'qnaQuestion':
        return '<div class="qna-question"><span class="qna-label-q">Q</span><div class="qna-text">' + (node.content?.map(processNode).join('') || '') + '</div></div>'
      
      case 'qnaAnswer':
        return '<div class="qna-answer"><span class="qna-label-a">A</span><div class="qna-text">' + (node.content?.map(processNode).join('') || '') + '</div></div>'
      
      case 'careerList':
        return '<div class="career-list">' + (node.content?.map(processNode).join('') || '') + '</div>'
      
      case 'careerListItem':
        return '<div class="career-list-item">' + (node.content?.map(processNode).join('') || '') + '</div>'
      
      case 'footnote':
        const fnId = node.attrs?.id || 1
        // 항상 출처 섹션으로 이동하도록 내부 앵커 사용
        return '<sup class="footnote-ref"><a href="#fn-' + fnId + '" id="fnref-' + fnId + '" data-footnote-id="' + fnId + '">' + fnId + '</a></sup>'
      
      case 'hardBreak':
        return '<br>'
      
      default:
        if (node.content) {
          return node.content.map(processNode).join('')
        }
        return ''
    }
  }
  
  return doc.content.map(processNode).join('')
}

// 검수 대기 목록 (관리자)
app.get('/api/admin/howto/pending', requireAdmin, async (c) => {
  try {
    const limit = parseInt(c.req.query('limit') || '20')
    const offset = parseInt(c.req.query('offset') || '0')
    
    const { listPendingReviews } = await import('./services/publishService')
    const result = await listPendingReviews(c.env.DB, { limit, offset })
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }
    
    return c.json({ success: true, drafts: result.drafts, total: result.total })
  } catch (error) {
    console.error('[pending reviews] Error:', error)
    return c.json({ success: false, error: '조회 중 오류가 발생했습니다' }, 500)
  }
})

// 초안 승인 (관리자)
app.post('/api/admin/howto/drafts/:id/approve', requireAdmin, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))
    
    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }
    
    const { approveDraft } = await import('./services/publishService')
    const result = await approveDraft(c.env.DB, draftId, user.id)
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 400)
    }
    
    return c.json({ 
      success: true, 
      howtoId: result.howtoId,
      slug: result.slug,
      message: '승인되어 게시되었습니다'
    })
  } catch (error) {
    console.error('[approve draft] Error:', error)
    return c.json({ success: false, error: '승인 처리 중 오류가 발생했습니다' }, 500)
  }
})

// 초안 반려 (관리자)
app.post('/api/admin/howto/drafts/:id/reject', requireAdmin, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))
    const body = await c.req.json()
    const { reason } = body
    
    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }
    
    if (!reason || typeof reason !== 'string' || reason.trim().length === 0) {
      return c.json({ success: false, error: '반려 사유를 입력해주세요' }, 400)
    }
    
    const { rejectDraft } = await import('./services/publishService')
    const result = await rejectDraft(c.env.DB, draftId, user.id, reason.trim())
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 400)
    }
    
    return c.json({ success: true, message: '반려 처리되었습니다' })
  } catch (error) {
    console.error('[reject draft] Error:', error)
    return c.json({ success: false, error: '반려 처리 중 오류가 발생했습니다' }, 500)
  }
})

// =====================================================
// 파일 업로드 API
// =====================================================

// 간단한 업로드 (FormData 방식)
app.post('/api/upload', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const formData = await c.req.parseBody()
    const file = formData['file'] as File
    
    if (!file || !(file instanceof File)) {
      return c.json({ success: false, error: '파일이 필요합니다' }, 400)
    }
    
    const { validateContentType, validateFileSize, validateMagicNumber, uploadToR2 } = await import('./services/uploadService')
    
    // 콘텐츠 타입 검증
    const typeResult = validateContentType(file.type)
    if (!typeResult.valid) {
      return c.json({ success: false, error: typeResult.error }, 400)
    }
    
    // 파일 크기 검증
    const sizeResult = validateFileSize(file.size)
    if (!sizeResult.valid) {
      return c.json({ success: false, error: sizeResult.error }, 400)
    }
    
    // 파일 데이터 읽기
    const body = await file.arrayBuffer()
    
    // 매직 넘버 검증
    if (!validateMagicNumber(body, file.type)) {
      return c.json({ success: false, error: '파일 형식이 올바르지 않습니다' }, 400)
    }
    
    // 파일 키 생성
    const ext = file.name.split('.').pop()?.toLowerCase() || 'bin'
    const timestamp = Date.now()
    const randomId = Math.random().toString(36).substring(2, 10)
    const fileKey = `howto/${timestamp}-${randomId}.${ext}`
    
    // R2에 업로드
    const uploadResult = await uploadToR2(c.env.UPLOADS, fileKey, body, file.type, {
      uploadedBy: user.id.toString(),
      originalName: file.name
    })
    
    if (!uploadResult.success) {
      return c.json({ success: false, error: uploadResult.error }, 500)
    }
    
    // URL 반환
    const baseUrl = new URL(c.req.url).origin
    const publicUrl = `${baseUrl}/uploads/${fileKey}`
    
    return c.json({ success: true, url: publicUrl })
  } catch (error) {
    console.error('[upload simple] Error:', error)
    return c.json({ success: false, error: '업로드 중 오류가 발생했습니다' }, 500)
  }
})

// 업로드 준비 (파일 키 발급)
app.post('/api/upload/prepare', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const body = await c.req.json()
    const { filename, contentType, contentLength } = body
    
    if (!filename || !contentType || !contentLength) {
      return c.json({ success: false, error: '필수 정보가 누락되었습니다' }, 400)
    }
    
    const { createUploadInfo, validateContentType, validateFileSize } = await import('./services/uploadService')
    
    // 검증
    const typeResult = validateContentType(contentType)
    if (!typeResult.valid) {
      return c.json({ success: false, error: typeResult.error }, 400)
    }
    
    const sizeResult = validateFileSize(contentLength)
    if (!sizeResult.valid) {
      return c.json({ success: false, error: sizeResult.error }, 400)
    }
    
    // 업로드 정보 생성
    const uploadInfo = createUploadInfo({ filename, contentType, contentLength })
    if (!uploadInfo.success) {
      return c.json({ success: false, error: uploadInfo.error }, 400)
    }
    
    // 기본 URL 결정
    const baseUrl = new URL(c.req.url).origin
    
    return c.json({
      success: true,
      fileKey: uploadInfo.data!.fileKey,
      uploadUrl: `${baseUrl}/api/upload/file`,
      publicUrl: `${baseUrl}/uploads/${uploadInfo.data!.fileKey}`,
      expiresIn: 300 // 5분
    })
  } catch (error) {
    console.error('[upload prepare] Error:', error)
    return c.json({ success: false, error: '업로드 준비 중 오류가 발생했습니다' }, 500)
  }
})

// 파일 업로드 (실제 업로드)
app.post('/api/upload/file', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const fileKey = c.req.header('X-File-Key')
    const contentType = c.req.header('Content-Type') || ''
    
    if (!fileKey) {
      return c.json({ success: false, error: '파일 키가 필요합니다' }, 400)
    }
    
    const { validateContentType, validateMagicNumber, uploadToR2, getPublicUrl } = await import('./services/uploadService')
    
    // 콘텐츠 타입 검증
    const typeResult = validateContentType(contentType)
    if (!typeResult.valid) {
      return c.json({ success: false, error: typeResult.error }, 400)
    }
    
    // 파일 본문 읽기
    const body = await c.req.arrayBuffer()
    
    // 매직 넘버 검증
    if (!validateMagicNumber(body, contentType)) {
      return c.json({ success: false, error: '파일 형식이 올바르지 않습니다 (파일 시그니처 불일치)' }, 400)
    }
    
    // R2에 업로드
    const uploadResult = await uploadToR2(c.env.UPLOADS, fileKey, body, contentType, {
      uploadedBy: user.id.toString(),
      originalContentType: contentType
    })
    
    if (!uploadResult.success) {
      return c.json({ success: false, error: uploadResult.error }, 500)
    }
    
    // DB에 메타데이터 저장
    await c.env.DB.prepare(`
      INSERT INTO uploaded_files (user_id, file_key, content_type, file_size)
      VALUES (?, ?, ?, ?)
    `).bind(user.id, fileKey, contentType, body.byteLength).run()
    
    const baseUrl = new URL(c.req.url).origin
    
    return c.json({
      success: true,
      fileKey,
      publicUrl: `${baseUrl}/uploads/${fileKey}`,
      size: body.byteLength
    })
  } catch (error) {
    console.error('[upload file] Error:', error)
    return c.json({ success: false, error: '파일 업로드 중 오류가 발생했습니다' }, 500)
  }
})

// 이미지 서빙 (R2 프록시)
app.get('/uploads/*', async (c) => {
  try {
    // Hono가 URL을 자동 디코딩하므로, 원본 URL에서 경로 추출
    const rawUrl = c.req.raw.url
    const urlObj = new URL(rawUrl)
    // pathname은 인코딩된 상태
    const encodedPath = urlObj.pathname.replace('/uploads/', '')
    const decodedPath = decodeURIComponent(encodedPath)
    
    if (!encodedPath) {
      return c.json({ error: 'Empty path', rawUrl }, 404)
    }
    
    // R2 버킷 바인딩 확인
    if (!c.env.UPLOADS) {
      return c.json({ error: 'R2 bucket not bound', hint: 'Check --r2 flag in wrangler command' }, 500)
    }
    
    // R2 키가 인코딩된 형태 또는 디코딩된 형태일 수 있으므로 여러 가지 시도
    // 1. 먼저 인코딩된 경로로 시도 (기존 이미지들이 인코딩된 키로 저장됨)
    let object = await c.env.UPLOADS.get(encodedPath)
    let usedPath = encodedPath
    
    // 2. 실패하면 디코딩된 경로로 시도 (새로 업로드된 이미지)
    if (!object) {
      object = await c.env.UPLOADS.get(decodedPath)
      usedPath = decodedPath
    }
    
    // 3. 실패하면 파일명의 '/'를 '_'로 변환해서 시도 (UI/UX 같은 슬래시 포함 이름)
    // 예: jobs/job-휴대폰UI/UX개발자.webp → jobs/job-휴대폰UI_UX개발자.webp
    if (!object) {
      // 경로에서 디렉토리와 파일명 분리 (첫 번째 '/' 이후)
      const firstSlashIdx = decodedPath.indexOf('/')
      if (firstSlashIdx !== -1) {
        const dir = decodedPath.substring(0, firstSlashIdx)
        const filename = decodedPath.substring(firstSlashIdx + 1)
        // 파일명에서 '/'를 '_'로 변환
        const safeFilename = filename.replace(/\//g, '_')
        const safePath = `${dir}/${safeFilename}`
        if (safePath !== decodedPath) {
          object = await c.env.UPLOADS.get(safePath)
          usedPath = safePath
        }
      }
    }
    
    if (!object) {
      // 디버그 정보를 JSON으로 반환
      return c.json({
        error: 'File not found in R2',
        tried: {
          encodedPath,
          decodedPath
        },
        rawUrl
      }, 404)
    }
    
    // 확장자 기반 Content-Type 추론 (R2 메타데이터가 없을 경우 대비)
    const getContentTypeByExtension = (filepath: string): string => {
      const ext = filepath.split('.').pop()?.toLowerCase()
      const mimeTypes: Record<string, string> = {
        'webp': 'image/webp',
        'png': 'image/png',
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'gif': 'image/gif',
        'svg': 'image/svg+xml',
        'ico': 'image/x-icon',
        'avif': 'image/avif'
      }
      return mimeTypes[ext || ''] || 'application/octet-stream'
    }
    
    // 캐시 헤더 설정 (1년)
    const headers = new Headers()
    const contentType = object.httpMetadata?.contentType || getContentTypeByExtension(usedPath)
    headers.set('Content-Type', contentType)
    headers.set('Cache-Control', 'public, max-age=31536000, immutable')
    headers.set('ETag', object.httpEtag)
    
    // If-None-Match 헤더 확인 (304 응답)
    const ifNoneMatch = c.req.header('If-None-Match')
    if (ifNoneMatch && ifNoneMatch === object.httpEtag) {
      return new Response(null, { status: 304, headers })
    }
    
    return new Response(object.body as ReadableStream, { headers })
  } catch (error) {
    // 에러 발생 시 상세 정보 반환
    return c.json({
      error: 'R2 proxy error',
      message: error instanceof Error ? error.message : String(error)
    }, 500)
  }
})

// ============================================
// Z-Image Turbo 이미지 생성 API
// ============================================

// 이미지 생성 요청 (관리자 전용)
app.post('/api/image/generate', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    
    // 관리자 권한 확인
    if (user.role !== 'admin') {
      return c.json({ success: false, error: '관리자 권한이 필요합니다' }, 403)
    }
    
    const apiKey = c.env.EVOLINK_API_KEY
    if (!apiKey) {
      return c.json({ success: false, error: 'EVOLINK_API_KEY가 설정되지 않았습니다' }, 500)
    }
    
    const body = await c.req.json()
    const { type, slug, promptOverride } = body as {
      type: 'jobs' | 'majors'
      slug: string
      promptOverride?: string
    }
    
    if (!type || !slug) {
      return c.json({ success: false, error: 'type과 slug가 필요합니다' }, 400)
    }
    
    // DB에서 프롬프트 조회
    let imagePrompt = promptOverride
    if (!imagePrompt) {
      const table = type === 'jobs' ? 'jobs' : 'majors'
      const record = await c.env.DB.prepare(`
        SELECT image_prompt FROM ${table} WHERE slug = ?
      `).bind(slug).first()
      
      if (!record || !record.image_prompt) {
        return c.json({ success: false, error: '해당 항목의 프롬프트를 찾을 수 없습니다' }, 404)
      }
      imagePrompt = record.image_prompt as string
    }
    
    // 콜백 URL 생성
    const baseUrl = new URL(c.req.url).origin
    const callbackUrl = `${baseUrl}/webhooks/image-completed`
    
    // Z-Image Turbo API 호출
    const { requestImageGeneration } = await import('./services/imageGenerationService')
    const result = await requestImageGeneration(apiKey, {
      prompt: imagePrompt,
      size: '16:9',
      callback_url: callbackUrl
    })
    
    if (!result.success || !result.data) {
      return c.json({ success: false, error: result.error || '이미지 생성 요청 실패' }, 500)
    }
    
    // 태스크 정보를 KV에 저장 (콜백 시 사용)
    const taskMeta = {
      type,
      slug,
      prompt: imagePrompt.substring(0, 200), // 프롬프트 요약
      createdAt: Date.now(),
      createdBy: user.id
    }
    
    // KV가 바인딩되어 있으면 저장 (로컬 개발 환경에서는 없을 수 있음)
    if (c.env.KV) {
      await c.env.KV.put(`image-task:${result.data.id}`, JSON.stringify(taskMeta), {
        expirationTtl: 86400 // 24시간
      })
    } else {
      console.warn('[image/generate] KV not bound, task metadata not saved. Callback may not work.')
    }
    
    return c.json({
      success: true,
      taskId: result.data.id,
      status: result.data.status,
      estimatedTime: result.data.task_info?.estimated_time || 10
    })
  } catch (error) {
    console.error('[image/generate] Error:', error)
    return c.json({ success: false, error: '이미지 생성 요청 중 오류 발생' }, 500)
  }
})

// 이미지 생성 상태 조회
app.get('/api/image/status/:taskId', requireAuth, async (c) => {
  try {
    const taskId = c.req.param('taskId')
    const apiKey = c.env.EVOLINK_API_KEY
    
    if (!apiKey) {
      return c.json({ success: false, error: 'EVOLINK_API_KEY가 설정되지 않았습니다' }, 500)
    }
    
    const { queryTaskStatus } = await import('./services/imageGenerationService')
    const result = await queryTaskStatus(apiKey, taskId)
    
    // 🔍 디버그: API 응답 로깅
    console.log('[image/status] Raw response:', JSON.stringify(result.data, null, 2))
    
    if (!result.success || !result.data) {
      return c.json({ success: false, error: result.error || '상태 조회 실패' }, 500)
    }
    
    // 상태 정규화 (다양한 API 응답 형식 처리)
    const rawStatus = (result.data as any).status || (result.data as any).state || ''
    const normalizedStatus = rawStatus.toLowerCase()
    const isCompleted = normalizedStatus === 'completed' || normalizedStatus === 'success' || normalizedStatus === 'done'
    const isFailed = normalizedStatus === 'failed' || normalizedStatus === 'error'

    // results 배열 우선, data.url/urls는 fallback
    const imageUrl = (result.data as any).results?.[0] || (result.data as any).data?.url || (result.data as any).data?.urls?.[0] || (result.data as any).output?.url
    
    console.log('[image/status] Parsed:', { rawStatus, isCompleted, isFailed, hasImageUrl: !!imageUrl })
    
    return c.json({
      success: true,
      taskId: result.data.id,
      status: isCompleted ? 'completed' : (isFailed ? 'failed' : rawStatus),
      progress: result.data.progress,
      imageUrl
    })
  } catch (error) {
    console.error('[image/status] Error:', error)
    return c.json({ success: false, error: '상태 조회 중 오류 발생' }, 500)
  }
})

// 이미지 저장 API (폴링 방식용 - 로컬 환경에서 콜백이 작동하지 않을 때 사용)
app.post('/api/image/save', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    
    // 관리자 권한 확인
    if (user.role !== 'admin') {
      return c.json({ success: false, error: '관리자 권한이 필요합니다' }, 403)
    }
    
    const body = await c.req.json()
    const { taskId, type, slug, imageUrl } = body as {
      taskId: string
      type: 'jobs' | 'majors'
      slug: string
      imageUrl: string
    }
    
    if (!taskId || !type || !slug || !imageUrl) {
      return c.json({ success: false, error: 'taskId, type, slug, imageUrl가 필요합니다' }, 400)
    }
    
    const { downloadImage, generateImageFileKey, getImagePublicUrl } = 
      await import('./services/imageGenerationService')
    const { uploadToR2 } = await import('./services/uploadService')
    
    // 이미지 다운로드
    console.log('[image/save] Downloading image:', imageUrl)
    const downloadResult = await downloadImage(imageUrl)
    if (!downloadResult.success || !downloadResult.data) {
      console.error('[image/save] Download failed:', downloadResult.error)
      return c.json({ success: false, error: downloadResult.error || '이미지 다운로드 실패' }, 500)
    }
    
    // R2에 업로드 (기존 이미지 덮어쓰기)
    const fileKey = generateImageFileKey(type, slug)
    console.log('[image/save] Uploading to R2:', fileKey)
    const uploadResult = await uploadToR2(
      c.env.UPLOADS,
      fileKey,
      downloadResult.data,
      downloadResult.contentType || 'image/png',
      {
        source: 'z-image-turbo',
        taskId,
        slug
      }
    )
    
    if (!uploadResult.success) {
      console.error('[image/save] Upload failed:', uploadResult.error)
      return c.json({ success: false, error: uploadResult.error || 'R2 업로드 실패' }, 500)
    }
    
    // DB 업데이트 (image_url 컬럼 + merged_profile_json 둘 다 업데이트)
    const baseUrl = new URL(c.req.url).origin
    const publicUrl = getImagePublicUrl(fileKey, baseUrl)
    // 캐시 버스터 추가 (브라우저 캐시 우회)
    const publicUrlWithCache = `${publicUrl}?v=${Date.now()}`
    const table = type === 'jobs' ? 'jobs' : 'majors'
    
    // slug로 레코드 찾기 - image_url 컬럼과 merged_profile_json 둘 다 업데이트
    let updateResult = await c.env.DB.prepare(`
      UPDATE ${table}
      SET image_url = ?,
          merged_profile_json = json_set(COALESCE(merged_profile_json, '{}'), '$.image_url', ?)
      WHERE slug = ?
    `).bind(publicUrlWithCache, publicUrlWithCache, slug).run()
    
    // slug로 못 찾으면 name으로 시도
    if (updateResult.meta.changes === 0) {
      updateResult = await c.env.DB.prepare(`
        UPDATE ${table}
        SET image_url = ?,
            merged_profile_json = json_set(COALESCE(merged_profile_json, '{}'), '$.image_url', ?)
        WHERE name = ?
      `).bind(publicUrlWithCache, publicUrlWithCache, slug).run()
    }
    
    console.log('[image/save] DB updated:', table, slug, publicUrl, 'changes:', updateResult.meta.changes)
    
    // ISR 캐시 무효화 (wiki_pages에서 해당 페이지 삭제)
    try {
      const pageType = type === 'jobs' ? 'job' : 'major'
      await c.env.DB.prepare(`
        DELETE FROM wiki_pages WHERE slug LIKE ? AND page_type = ?
      `).bind(`%${slug}%`, pageType).run()
      console.log('[image/save] ISR cache invalidated for:', slug)
    } catch (cacheError) {
      console.warn('[image/save] Cache invalidation failed:', cacheError)
    }
    
    return c.json({ 
      success: true, 
      imageUrl: publicUrl,
      message: '이미지가 성공적으로 저장되었습니다. 페이지를 새로고침해주세요.'
    })
  } catch (error) {
    console.error('[image/save] Error:', error)
    return c.json({ success: false, error: '이미지 저장 중 오류 발생' }, 500)
  }
})

// Z-Image Turbo 콜백 핸들러 (이미지 생성 완료 시 호출됨)
app.post('/webhooks/image-completed', async (c) => {
  try {
    const body = await c.req.json()
    console.log('[webhook/image-completed] Received:', JSON.stringify(body).substring(0, 500))
    
    const { parseCallbackData, downloadImage, generateImageFileKey, getImagePublicUrl } = 
      await import('./services/imageGenerationService')
    const { uploadToR2 } = await import('./services/uploadService')
    
    // 콜백 데이터 파싱
    const taskData = parseCallbackData(body)
    if (!taskData) {
      console.error('[webhook/image-completed] Invalid callback data')
      return c.json({ success: false, error: 'Invalid callback data' }, 400)
    }
    
    const taskId = taskData.id
    const status = taskData.status
    
    // 태스크 메타데이터 조회
    const taskMetaStr = await c.env.KV.get(`image-task:${taskId}`)
    if (!taskMetaStr) {
      console.error('[webhook/image-completed] Task metadata not found:', taskId)
      return c.json({ success: false, error: 'Task metadata not found' }, 404)
    }
    
    const taskMeta = JSON.parse(taskMetaStr) as {
      type: 'jobs' | 'majors'
      slug: string
      prompt: string
      createdAt: number
      createdBy: number
    }
    
    // 실패 처리
    if (status === 'failed') {
      console.error('[webhook/image-completed] Task failed:', taskId, taskData.error)
      // 실패 로그 저장 (선택사항)
      await c.env.KV.put(`image-task-failed:${taskId}`, JSON.stringify({
        ...taskMeta,
        error: taskData.error,
        failedAt: Date.now()
      }), { expirationTtl: 604800 }) // 7일
      return c.json({ success: true, status: 'failed' })
    }
    
    // 완료가 아니면 무시
    if (status !== 'completed') {
      console.log('[webhook/image-completed] Task not completed yet:', taskId, status)
      return c.json({ success: true, status })
    }
    
    // 이미지 URL 추출 (results 배열 우선)
    const imageUrl = taskData.results?.[0] || taskData.data?.url || taskData.data?.urls?.[0]
    if (!imageUrl) {
      console.error('[webhook/image-completed] No image URL in callback:', taskId)
      return c.json({ success: false, error: 'No image URL' }, 400)
    }
    
    // 이미지 다운로드
    const downloadResult = await downloadImage(imageUrl)
    if (!downloadResult.success || !downloadResult.data) {
      console.error('[webhook/image-completed] Download failed:', downloadResult.error)
      return c.json({ success: false, error: downloadResult.error }, 500)
    }
    
    // R2에 업로드
    const fileKey = generateImageFileKey(taskMeta.type, taskMeta.slug)
    const uploadResult = await uploadToR2(
      c.env.UPLOADS,
      fileKey,
      downloadResult.data,
      downloadResult.contentType || 'image/png',
      {
        source: 'z-image-turbo',
        taskId,
        slug: taskMeta.slug
      }
    )
    
    if (!uploadResult.success) {
      console.error('[webhook/image-completed] Upload failed:', uploadResult.error)
      return c.json({ success: false, error: uploadResult.error }, 500)
    }
    
    // DB 업데이트
    const baseUrl = new URL(c.req.url).origin
    const publicUrl = getImagePublicUrl(fileKey, baseUrl)
    const table = taskMeta.type === 'jobs' ? 'jobs' : 'majors'
    
    await c.env.DB.prepare(`
      UPDATE ${table}
      SET image_url = ?, updated_at = datetime('now')
      WHERE slug = ?
    `).bind(publicUrl, taskMeta.slug).run()
    
    console.log('[webhook/image-completed] Success:', taskMeta.type, taskMeta.slug, publicUrl)
    
    // 태스크 메타데이터 삭제
    await c.env.KV.delete(`image-task:${taskId}`)
    
    // 성공 로그 저장 (선택사항)
    await c.env.KV.put(`image-task-completed:${taskId}`, JSON.stringify({
      ...taskMeta,
      imageUrl: publicUrl,
      completedAt: Date.now()
    }), { expirationTtl: 604800 }) // 7일
    
    return c.json({ success: true, status: 'completed', imageUrl: publicUrl })
  } catch (error) {
    console.error('[webhook/image-completed] Error:', error)
    return c.json({ success: false, error: 'Internal error' }, 500)
  }
})

// HowTo 신고 (로그인/익명 모두 가능)
app.post('/api/howto/:slug/report', authMiddleware, async (c) => {
  try {
    const slug = c.req.param('slug')
    const authUser = c.get('user')  // User 타입 (id: number)
    const body = await c.req.json()
    
    const { reasonType, reasonDetail } = body
    
    // 유효한 신고 사유인지 확인
    const validReasons = ['defamation', 'obscene', 'spam', 'copyright', 'false_info', 'other']
    if (!reasonType || !validReasons.includes(reasonType)) {
      return c.json({ success: false, error: '유효한 신고 사유를 선택해주세요' }, 400)
    }
    
    // HowTo 페이지 조회 (page_type='guide')
    const page = await c.env.DB.prepare(`
      SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'
    `).bind(slug).first<{ id: number }>()
    
    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }
    
    // 신고 생성
    const { createHowtoReport } = await import('./services/howtoReportService')
    const clientIp = c.req.header('CF-Connecting-IP') || c.req.header('X-Forwarded-For')?.split(',')[0]?.trim()
    
    const result = await createHowtoReport(c.env.DB, {
      pageId: page.id,
      reporterId: authUser?.id ?? null,
      reporterIp: !authUser ? clientIp : null,
      reasonType,
      reasonDetail: reasonDetail?.slice(0, 500) // 500자 제한
    })
    
    return c.json({
      success: true,
      reportId: result.reportId,
      autoBlinded: result.autoBlinded,
      message: result.autoBlinded 
        ? '신고가 접수되었으며, 신고 누적으로 해당 글이 블라인드 처리되었습니다.'
        : '신고가 접수되었습니다. 관리자 검토 후 조치될 예정입니다.'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error)
    console.error('[howto report] Error:', message)
    
    if (message === 'ALREADY_REPORTED') {
      return c.json({ success: false, error: '이미 신고한 글입니다' }, 400)
    }
    
    return c.json({ success: false, error: '신고 처리 중 오류가 발생했습니다' }, 500)
  }
})

// HowTo 블라인드 처리 (관리자 전용)
app.post('/api/admin/howto/:slug/blind', requireAdmin, async (c) => {
  try {
    const slug = c.req.param('slug')
    const user = c.get('user')!
    const body = await c.req.json()
    const { reason } = body
    
    if (!reason || typeof reason !== 'string' || reason.trim().length === 0) {
      return c.json({ success: false, error: '블라인드 사유를 입력해주세요' }, 400)
    }
    
    // HowTo 페이지 조회 (page_type='guide')
    const page = await c.env.DB.prepare(`
      SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'
    `).bind(slug).first<{ id: number }>()
    
    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }
    
    const { blindHowto } = await import('./services/howtoReportService')
    await blindHowto(c.env.DB, page.id, user.id, reason.trim())
    
    return c.json({ success: true, message: '블라인드 처리되었습니다' })
  } catch (error) {
    console.error('[howto blind] Error:', error)
    return c.json({ success: false, error: '처리 중 오류가 발생했습니다' }, 500)
  }
})

// HowTo 블라인드 해제 (관리자 전용)
app.post('/api/admin/howto/:slug/unblind', requireAdmin, async (c) => {
  try {
    const slug = c.req.param('slug')
    
    // HowTo 페이지 조회 (page_type='guide')
    const page = await c.env.DB.prepare(`
      SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'
    `).bind(slug).first<{ id: number }>()
    
    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }
    
    const { unblindHowto } = await import('./services/howtoReportService')
    await unblindHowto(c.env.DB, page.id)
    
    return c.json({ success: true, message: '블라인드가 해제되었습니다' })
  } catch (error) {
    console.error('[howto unblind] Error:', error)
    return c.json({ success: false, error: '처리 중 오류가 발생했습니다' }, 500)
  }
})

// HowTo 신고 목록 조회 (관리자 전용)
app.get('/api/admin/howto/reports', requireAdmin, async (c) => {
  try {
    const status = c.req.query('status')
    const pageId = c.req.query('pageId')
    const limit = parseInt(c.req.query('limit') || '50')
    const offset = parseInt(c.req.query('offset') || '0')
    
    const { listHowtoReports } = await import('./services/howtoReportService')
    const result = await listHowtoReports(c.env.DB, {
      status: status || undefined,
      pageId: pageId ? parseInt(pageId) : undefined,
      limit,
      offset
    })
    
    return c.json({ success: true, ...result })
  } catch (error) {
    console.error('[howto reports] Error:', error)
    return c.json({ success: false, error: '조회 중 오류가 발생했습니다' }, 500)
  }
})

// HowTo 신고 처리 (관리자 전용)
app.post('/api/admin/howto/reports/:id/resolve', requireAdmin, async (c) => {
  try {
    const reportId = parseInt(c.req.param('id'))
    const user = c.get('user')!
    const body = await c.req.json()
    const { action } = body // 'resolve' or 'dismiss'
    
    if (!['resolve', 'dismiss'].includes(action)) {
      return c.json({ success: false, error: '유효하지 않은 액션입니다' }, 400)
    }
    
    const { resolveHowtoReport } = await import('./services/howtoReportService')
    await resolveHowtoReport(c.env.DB, reportId, user.id, action)
    
    return c.json({ 
      success: true, 
      message: action === 'resolve' ? '신고가 처리되었습니다' : '신고가 기각되었습니다'
    })
  } catch (error) {
    console.error('[howto report resolve] Error:', error)
    return c.json({ success: false, error: '처리 중 오류가 발생했습니다' }, 500)
  }
})

// Revision 상세 조회
app.get('/api/revision/:id', authMiddleware, async (c) => {
  try {
    const revisionId = Number(c.req.param('id'))
    const includeFullData = c.req.query('fullData') === 'true'
    const formatForEdit = c.req.query('formatForEdit') === 'true' // 편집 형식으로 변환
    
    if (!Number.isFinite(revisionId) || revisionId <= 0) {
      return c.json({ success: false, error: 'invalid revision id' }, 400)
    }
    
    const revision = await getRevisionById(c.env.DB, revisionId)
    
    if (!revision) {
      return c.json({ success: false, error: 'revision not found' }, 404)
    }
    
    let fullData = null
    let editFormattedData = null
    
    if (includeFullData) {
      // 전체 데이터 재구성
      const { reconstructFullData } = await import('./services/revisionService')
      try {
        const snapshot = JSON.parse(revision.dataSnapshot)
        
        // 변경사항만 저장된 경우 전체 데이터 재구성 필요
        if (snapshot.changedFields !== undefined) {
          // entityType이 'job' | 'major' | 'howto'인 경우에만 재구성
          if (revision.entityType === 'job' || revision.entityType === 'major' || revision.entityType === 'howto') {
            fullData = await reconstructFullData(
              c.env.DB,
              revision.entityType,
              revision.entityId,
              revision.revisionNumber
            )
          } else {
            // 'guide' 등 다른 타입은 스냅샷 그대로 사용
            fullData = snapshot
          }
        } else {
          // 전체 스냅샷인 경우 그대로 사용
          fullData = snapshot
        }
        
        // 편집 형식으로 변환 요청 시
        if (formatForEdit && revision.entityType === 'job' && fullData) {
          // edit-data API와 동일한 로직으로 필드 추출
          const { mergeJobData } = await import('./services/jobDataMerger')
          
          // fullData가 원본 구조인지 확인 (careernet, goyong24 포함 여부)
          let rawApiData: { careernet: any; goyong24: any } = { careernet: null, goyong24: null }
          if (fullData.careernet !== undefined || fullData.goyong24 !== undefined) {
            rawApiData = {
              careernet: fullData.careernet || null,
              goyong24: fullData.goyong24 || null
            }
          } else {
            // fullData가 이미 병합된 구조인 경우, 원본 구조로 가정
            rawApiData = fullData as any
          }
          
          const mergedData = mergeJobData(rawApiData)
          
          // profile 객체 생성 (fullData에서 직접 필드 추출)
          const profile = {
            name: fullData.name || '',
            summary: fullData.summary || (rawApiData?.goyong24 as any)?.duty?.jobSum || '',
            duties: fullData.duties || '',
            way: fullData.way || '',
            salary: fullData.salary || '',
            prospect: fullData.prospect || '',
            satisfaction: fullData.satisfaction || '',
            status: fullData.status || '',
            abilities: fullData.abilities || '',
            knowledge: fullData.knowledge || '',
            environment: fullData.environment || '',
            personality: fullData.personality || '',
            interests: fullData.interests || '',
            values: fullData.values || '',
            technKnow: fullData.technKnow || '',
            aptitudeList: fullData.aptitudeList || [],
            educationDistribution: fullData.educationDistribution || null,
            majorDistribution: fullData.majorDistribution || null
          }
          
          // edit-data API와 동일한 로직으로 필드 추출
          const summaryForEdit = profile.summary || (rawApiData?.goyong24 as any)?.duty?.jobSum || ''
          const workSummary = mergedData.work.summary || profile.summary || ''
          
          const workSimple = mergedData.work.simple
          let duties = ''
          if (workSimple && Array.isArray(workSimple) && workSimple.length > 0) {
            duties = workSimple
              .map((item: any) => {
                const text = typeof item === 'string' ? item : item.work || item.list_content || ''
                return text?.trim() || ''
              })
              .filter(Boolean)
              .join('\n')
          } else if (profile.duties?.trim()) {
            duties = profile.duties
          }
          
          const tagList = (rawApiData?.careernet as any)?.encyclopedia?.tagList || []
          const tagText = Array.isArray(tagList) 
            ? tagList.map((tag: any) => {
                const tagText = typeof tag === 'string' ? tag : (tag?.tag || tag?.list_content || '')
                return tagText?.trim() || ''
              }).filter(Boolean).join('\n')
            : ''
          
          // heroTags 처리
          let heroTags: string[] = []
          if (Array.isArray(fullData.heroTags)) {
            heroTags = fullData.heroTags
          } else if (Array.isArray(tagList) && tagList.length > 0) {
            heroTags = tagList.map((tag: any) => {
              if (typeof tag === 'string') return tag.trim()
              return (tag?.tag || tag?.list_content || '').trim()
            }).filter(Boolean)
          }
          
          // heroCategory 처리
          let heroCategory = ''
          if (typeof fullData.heroCategory === 'string') {
            heroCategory = fullData.heroCategory
          } else if (fullData.heroCategory?.value) {
            heroCategory = fullData.heroCategory.value
          } else if (fullData.heroCategory?.large) {
            heroCategory = fullData.heroCategory.large
          }
          
          editFormattedData = {
            name: profile.name || '',
            summary: summaryForEdit,
            heroTags: heroTags, // 추가
            heroCategory: heroCategory, // 추가
            duties: duties,
            way: profile.way || '',
            salary: mergedData.salary.primary || profile.salary || '',
            prospect: mergedData.prospect.primary || profile.prospect || '',
            satisfaction: mergedData.satisfaction.primary || profile.satisfaction || '',
            status: profile.status || '',
            abilities: profile.abilities || '',
            knowledge: profile.knowledge || '',
            environment: profile.environment || '',
            personality: profile.personality || '',
            interests: profile.interests || '',
            values: profile.values || '',
            technKnow: profile.technKnow || '',
            aptitude: profile.aptitudeList?.map((item: any) => item.name || '').join('\n') || '',
            educationDistribution: profile.educationDistribution ? JSON.stringify(profile.educationDistribution, null, 2) : '',
            majorDistribution: profile.majorDistribution ? JSON.stringify(profile.majorDistribution, null, 2) : '',
            tags: tagText,
            workSummary: workSummary
          }
        }
      } catch (error) {
        console.error('[revision/:id] Failed to reconstruct full data:', error)
      }
    }
    
    return c.json({
      success: true,
      data: {
        ...revision,
        fullData,
        editFormattedData
      }
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to get revision'
    return c.json({ success: false, error: message }, 500)
  }
})

// Revision 목록 조회
app.get('/api/job/:id/revisions', authMiddleware, async (c) => {
  try {
    const jobIdParam = c.req.param('id')
    const limit = parseInt(c.req.query('limit') || '20', 10)
    const offset = parseInt(c.req.query('offset') || '0', 10)
    
    // 실제 DB ID로 변환 (editJob과 동일한 로직)
    let jobId = jobIdParam
    let job = await c.env.DB.prepare('SELECT id FROM jobs WHERE id = ? AND is_active = 1')
      .bind(jobId)
      .first<{ id: string }>()
    
    // ID로 찾지 못한 경우 slug로 시도
    if (!job) {
      // job:G_K000000890 같은 형식에서 실제 ID 추출 시도
      let extractedId = jobId
      if (jobId.includes(':')) {
        const parts = jobId.split(':')
        if (parts.length > 1) {
          extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          job = await c.env.DB.prepare('SELECT id FROM jobs WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first<{ id: string }>()
          
          if (job) {
            jobId = extractedId
          }
        }
      }
      
      // 여전히 찾지 못한 경우 slug로 시도
      if (!job) {
        const decodedSlug = decodeURIComponent(jobId)
        const normalizedSlug = decodedSlug.toLowerCase()
        
        job = await c.env.DB.prepare(
          'SELECT id FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first<{ id: string }>()
        
        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id FROM jobs WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first<{ id: string }>()
        }
        
        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id FROM jobs WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(decodedSlug).first<{ id: string }>()
        }
        
        if (job) {
          jobId = job.id
        }
      }
    }
    
    if (!job) {
      return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
    }
    
    const result = await listRevisions(c.env.DB, 'job', jobId, {
      limit: Math.min(Math.max(limit, 1), 100),
      offset: Math.max(offset, 0)
    })
    
    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to list revisions'
    return c.json({ success: false, error: message }, 500)
  }
})

app.get('/api/major/:id/revisions', authMiddleware, async (c) => {
  try {
    let majorId = c.req.param('id')
    const limit = parseInt(c.req.query('limit') || '20', 10)
    const offset = parseInt(c.req.query('offset') || '0', 10)
    
    // ID 해결 (직업 상세페이지와 동일한 로직)
    if (c.env.DB && majorId) {
      try {
        const db = c.env.DB
        
        // composite ID인 경우 (major:C_xxx 또는 major:G_xxx)
        if (majorId.includes(':')) {
          const parts = majorId.split(':')
          if (parts.length > 1) {
            const sourceId = parts[parts.length - 1].replace(/^C_/, '').replace(/^G_/, '')
            const dbResult = await db.prepare(
              'SELECT id FROM majors WHERE careernet_id = ? OR goyong24_id = ? LIMIT 1'
            ).bind(sourceId, sourceId).first() as { id: string } | null
            if (dbResult?.id) {
              majorId = dbResult.id
            }
          }
        } else {
          // majorId가 composite ID가 아닌 경우 DB에서 찾기
          let dbResult = await db.prepare(
            'SELECT id FROM majors WHERE id = ? AND is_active = 1 LIMIT 1'
          ).bind(majorId).first() as { id: string } | null
          
          if (!dbResult) {
            // slug로 조회 시도
            const decodedSlug = decodeURIComponent(majorId)
            const normalizedSlug = decodedSlug.toLowerCase()
            dbResult = await db.prepare(
              'SELECT id FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
            ).bind(normalizedSlug).first() as { id: string } | null
            
            if (dbResult?.id) {
              majorId = dbResult.id
            }
          }
        }
      } catch (dbError) {
        console.error('[major revisions] Failed to resolve ID:', dbError)
      }
    }
    
    const result = await listRevisions(c.env.DB, 'major', majorId, {
      limit: Math.min(Math.max(limit, 1), 100),
      offset: Math.max(offset, 0)
    })
    
    
    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to list revisions'
    console.error('[major revisions] Error:', error)
    return c.json({ success: false, error: message }, 500)
  }
})

// HowTo 역사 조회
app.get('/api/howto/:slug/revisions', authMiddleware, async (c) => {
  try {
    const slug = c.req.param('slug')
    const limit = parseInt(c.req.query('limit') || '20', 10)
    const offset = parseInt(c.req.query('offset') || '0', 10)
    
    // HowTo 존재 확인
    const howto = await c.env.DB.prepare(
      'SELECT slug FROM pages WHERE slug = ? AND page_type = \'guide\' AND status = \'published\''
    ).bind(slug).first()
    
    if (!howto) {
      return c.json({ success: false, error: 'HOWTO_NOT_FOUND' }, 404)
    }
    
    const result = await listRevisions(c.env.DB, 'howto', slug, {
      limit: Math.min(Math.max(limit, 1), 100),
      offset: Math.max(offset, 0)
    })
    
    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to list revisions'
    console.error('[howto revisions] Error:', error)
    return c.json({ success: false, error: message }, 500)
  }
})

// 되돌리기
app.post('/api/revision/:id/restore', authMiddleware, async (c) => {
  try {
    const revisionId = Number(c.req.param('id'))
    const user = getOptionalUser(c)
    let body: any
    
    try {
      body = await c.req.json()
    } catch {
      body = {}
    }
    
    if (!Number.isFinite(revisionId) || revisionId <= 0) {
      return c.json({ success: false, error: 'invalid revision id' }, 400)
    }
    
    const password = typeof body.password === 'string' ? body.password : undefined
    
    // 익명 편집인 경우 비밀번호 검증 (passwordHash가 있는 경우에만)
    const targetRevision = await getRevisionById(c.env.DB, revisionId)
    if (targetRevision?.editorType === 'anonymous' && targetRevision.passwordHash) {
      // passwordHash가 있는 경우에만 비밀번호 검증 필요
      if (!password) {
        return c.json({ success: false, error: 'PASSWORD_REQUIRED' }, 403)
      }
      
      const { verifyEditPassword } = await import('./utils/anonymousEdit')
      const isValid = await verifyEditPassword(password, targetRevision.passwordHash)
      if (!isValid) {
        return c.json({ success: false, error: 'INVALID_PASSWORD' }, 403)
      }
    }
    
    // 되돌리기 실행
    const revision = await restoreRevision(
      c.env.DB,
      revisionId,
      user?.id?.toString() ?? null,
      password,
      user?.username ?? user?.name ?? null  // 사용자 닉네임 전달
    )
    
    // 캐시 무효화 (jobId 또는 majorId 사용)
    await invalidatePageCache(c.env.DB, {
      jobId: revision.entityType === 'job' ? revision.entityId : undefined,
      majorId: revision.entityType === 'major' ? revision.entityId : undefined,
      slug: revision.entityType === 'howto' ? revision.entityId : undefined,
      pageType: revision.entityType === 'howto' ? 'guide' : revision.entityType
    })
    
    return c.json({
      success: true,
      revisionId: revision.id,
      message: 'Revision restored successfully'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'restore failed'
    const status = message.includes('NOT_FOUND') ? 404
      : message.includes('REQUIRED') || message.includes('UNAUTHORIZED') ? 403
      : message.includes('INVALID') ? 400
      : 500
    
    return c.json({ success: false, error: message }, status)
  }
})

// SEO skeleton (dev/local only)
app.get('/robots.txt', (c) => {
  const url = new URL(c.req.url)
  const origin = `${url.protocol}//${url.host}`
  const body = `User-agent: *

Allow: /
Sitemap: ${origin}/sitemap.xml
`
  return c.text(body, 200, { 'content-type': 'text/plain; charset=utf-8' })
})

app.get('/sitemap.xml', async (c) => {
  const url = new URL(c.req.url)
  const origin = `${url.protocol}//${url.host}`
  const urls = ['/job/software-developer', '/job/가상현실전문가', '/major/digital-marketing-major']
  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map((u) => `<url><loc>${origin}${encodeURI(u)}</loc></url>`).join('\n')}
</urlset>`
  return c.text(xml, 200, { 'content-type': 'application/xml; charset=utf-8' })
})

// Global 404 fallback
app.notFound((c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  return c.html(renderNotFoundPage({ userMenuHtml, requestedPath: c.req.path }), 404)
})

export default app

export const scheduled: ExportedHandlerScheduledHandler<Bindings> = async (event, env, ctx) => {
  const run = Promise.all(
    SERP_FRESHNESS_TARGETS.map(async (target) => {
      try {
        const result = await attemptScheduledRefresh(env.KV, env, target, {
          reason: event.cron ? `cron:${event.cron}` : 'scheduled-cron'
        })
        if (result.outcome === 'error') {
          console.error('[freshness][scheduled]', target.id, result.error)
        }
      } catch (error) {
        console.error('[freshness][scheduled]', target.id, error)
      }
    })
  )

  ctx.waitUntil(run)
  await run
}

// 🆕 API에서 원본 데이터를 다시 가져와서 api_data_json 업데이트
app.post('/api/job/:id/refetch-api-data', authMiddleware, async (c) => {
  try {
    const jobIdParam = c.req.param('id')
    
    // 실제 DB ID로 변환
    let jobId = jobIdParam
    let job = await c.env.DB.prepare('SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE id = ? AND is_active = 1')
      .bind(jobId)
      .first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()
    
    // ID로 찾지 못한 경우 slug로 시도
    if (!job) {
      let extractedId = jobId
      if (jobId.includes(':')) {
        const parts = jobId.split(':')
        if (parts.length > 1) {
          extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          job = await c.env.DB.prepare('SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()
          
          if (job) {
            jobId = extractedId
          }
        }
      }
      
      if (!job) {
        const decodedSlug = decodeURIComponent(jobId)
        const normalizedSlug = decodedSlug.toLowerCase()
        
        job = await c.env.DB.prepare(
          'SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()
        
        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()
        }
        
        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(decodedSlug).first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()
        }
        
        if (job) {
          jobId = job.id
        }
      }
    }
    
    if (!job) {
      return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
    }
    
    
    // API에서 데이터 가져오기 (명시적으로 source ID 전달하여 강제로 API 호출)
    const { getUnifiedJobDetailWithRawData } = await import('./services/profileDataService')
    const result = await getUnifiedJobDetailWithRawData(
      {
        id: jobId,
        careernetId: job.careernet_id || undefined,
        goyong24JobId: job.goyong24_id || undefined,
        includeSources: ['CAREERNET', 'GOYONG24']
      },
      c.env as any
    )
    
    if (!result.profile) {
      return c.json({ success: false, error: 'Failed to fetch data from API' }, 500)
    }
    
    // api_data_json 업데이트
    // ⚠️ api_data_json에는 원본 API 데이터 구조를 저장해야 함 (rawApiData 사용)
    const rawApiData = result.rawApiData || { careernet: null, goyong24: null }
    
    // DB에 직접 저장 (updateApiData는 UnifiedJobDetail을 받지만, 우리는 rawApiData를 저장해야 함)
    const now = Date.now()
    const apiDataJson = JSON.stringify(rawApiData)
    
    // 해시 생성 (rawApiData 사용) - Web Crypto API 사용 (Cloudflare Workers 호환)
    const normalized = JSON.stringify(rawApiData, Object.keys(rawApiData).sort())
    const encoder = new TextEncoder()
    const dataBuffer = encoder.encode(normalized)
    const hashBuffer = await crypto.subtle.digest('SHA-256', dataBuffer)
    const hashArray = Array.from(new Uint8Array(hashBuffer))
    const dataHash = hashArray.map(b => b.toString(16).padStart(2, '0')).join('')
    
    await c.env.DB.prepare(`
      UPDATE jobs 
      SET api_data_json = ?, api_data_hash = ?, api_last_fetched_at = ?, api_last_updated_at = ?
      WHERE id = ?
    `).bind(apiDataJson, dataHash, now, now, jobId).run()
    
    const updateResult = { updated: true, changedFields: [] }
    
    // 캐시 무효화
    await invalidatePageCache(c.env.DB, {
      jobId: jobId,
      pageType: 'job'
    })
    
    return c.json({
      success: true,
      message: 'API data refetched and saved successfully',
      updated: updateResult.updated,
      changedFields: updateResult.changedFields
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to refetch API data'
    console.error('[refetch-api-data] Error:', error)
    return c.json({ success: false, error: message }, 500)
  }
})

// 🆕 user_contributed_json 비우기 (원본 API 데이터 복구용)
app.post('/api/job/:id/reset-contributions', authMiddleware, async (c) => {
  try {
    const jobIdParam = c.req.param('id')
    
    // 실제 DB ID로 변환 (editJob과 동일한 로직)
    let jobId = jobIdParam
    let job = await c.env.DB.prepare('SELECT id FROM jobs WHERE id = ? AND is_active = 1')
      .bind(jobId)
      .first<{ id: string }>()
    
    // ID로 찾지 못한 경우 slug로 시도
    if (!job) {
      let extractedId = jobId
      if (jobId.includes(':')) {
        const parts = jobId.split(':')
        if (parts.length > 1) {
          extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          job = await c.env.DB.prepare('SELECT id FROM jobs WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first<{ id: string }>()
          
          if (job) {
            jobId = extractedId
          }
        }
      }
      
      if (!job) {
        const decodedSlug = decodeURIComponent(jobId)
        const normalizedSlug = decodedSlug.toLowerCase()
        
        job = await c.env.DB.prepare(
          'SELECT id FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first<{ id: string }>()
        
        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id FROM jobs WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first<{ id: string }>()
        }
        
        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id FROM jobs WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(decodedSlug).first<{ id: string }>()
        }
        
        if (job) {
          jobId = job.id
        }
      }
    }
    
    if (!job) {
      return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
    }
    
    // user_contributed_json을 빈 객체로 설정
    const now = Date.now()
    await c.env.DB.prepare(`
      UPDATE jobs 
      SET user_contributed_json = '{}', user_last_updated_at = ?
      WHERE id = ?
    `).bind(now, jobId).run()
    
    // 캐시 무효화
    await invalidatePageCache(c.env.DB, {
      jobId: jobId,
      pageType: 'job'
    })
    
    return c.json({
      success: true,
      message: 'User contributions cleared. Original API data will now be displayed.'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to reset contributions'
    return c.json({ success: false, error: message }, 500)
  }
})

// ============================================================================
// 관리자 페이지 라우트
// ============================================================================

// 관리자 대시보드 메인
app.get('/admin', requireAdmin, async (c) => {
  try {
    const db = c.env.DB
    
    // 통계 데이터 조회
    const [jobsResult, majorsResult, usersResult, todayEditsResult] = await Promise.all([
      db.prepare('SELECT COUNT(*) as count FROM jobs WHERE is_active = 1').first<{ count: number }>(),
      db.prepare('SELECT COUNT(*) as count FROM majors WHERE is_active = 1').first<{ count: number }>(),
      db.prepare('SELECT COUNT(*) as count FROM users').first<{ count: number }>(),
      db.prepare(`
        SELECT COUNT(*) as count FROM page_revisions 
        WHERE created_at >= datetime('now', '-1 day')
      `).first<{ count: number }>()
    ])
    
    // 캐시 히트율 계산 (최근 24시간 SERP 데이터 기반)
    const cacheStats = await db.prepare(`
      SELECT 
        COUNT(*) as total,
        SUM(CASE WHEN cache_status = 'HIT' THEN 1 ELSE 0 END) as hits
      FROM serp_interaction_logs
      WHERE recorded_at >= datetime('now', '-1 day')
    `).first<{ total: number; hits: number }>()
    
    const cacheHitRate = cacheStats && cacheStats.total > 0 
      ? (cacheStats.hits / cacheStats.total) * 100 
      : 0
    
    // 최근 편집 5건
    const recentEdits = await db.prepare(`
      SELECT 
        pr.id,
        pr.entity_type as entityType,
        pr.entity_id as entityId,
        COALESCE(j.name, m.name, pr.entity_id) as entityName,
        COALESCE(pr.editor_name, '익명') as editorName,
        COALESCE(pr.editor_type, 'anonymous') as editorType,
        pr.created_at as createdAt
      FROM page_revisions pr
      LEFT JOIN jobs j ON pr.entity_type = 'job' AND pr.entity_id = j.id
      LEFT JOIN majors m ON pr.entity_type = 'major' AND pr.entity_id = m.id
      ORDER BY pr.created_at DESC
      LIMIT 5
    `).all()
    
    // 최근 가입 사용자 5명
    const recentUsers = await db.prepare(`
      SELECT id, name, email, role, created_at as createdAt
      FROM users
      ORDER BY created_at DESC
      LIMIT 5
    `).all()
    
    return c.html(renderAdminDashboard({
      stats: {
        totalJobs: jobsResult?.count || 0,
        totalMajors: majorsResult?.count || 0,
        totalUsers: usersResult?.count || 0,
        todayEdits: todayEditsResult?.count || 0,
        cacheHitRate
      },
      recentEdits: (recentEdits.results || []) as any[],
      recentUsers: (recentUsers.results || []) as any[]
    }))
  } catch (error) {
    console.error('Admin dashboard error:', error)
    return c.text('관리자 대시보드를 불러오는데 실패했습니다.', 500)
  }
})

// ============================================
// AI Analyzer 관제판
// ============================================
import { renderAdminAiAnalyzer } from './templates/admin/adminAiAnalyzer'
import { adminAiApi } from './services/ai-analyzer/admin-api'

// Admin API 마운트
app.route('/admin/api/ai', adminAiApi)

// AI Analyzer 관제판 페이지 (개발환경: localhost 접근 시 인증 우회)
app.get('/admin/ai-analyzer', async (c, next) => {
  // 개발환경(localhost)에서는 인증 우회
  const host = c.req.header('host') || ''
  const isLocalhost = host.startsWith('localhost') || host.startsWith('127.0.0.1')
  if (isLocalhost) {
    console.log('⚠️ [Admin] Localhost detected - skipping auth for admin')
    return next()
  }
  return requireAdmin(c, next)
}, async (c) => {
  const db = c.env.DB
  
  try {
    // Overview 데이터 수집
    const [taggedJobs, lowConf, recentRun, analysisCount, followupCount] = await Promise.all([
      db.prepare('SELECT COUNT(*) as count FROM job_attributes').first<{ count: number }>(),
      db.prepare('SELECT COUNT(*) as count FROM job_attributes WHERE _confidence < 0.75').first<{ count: number }>(),
      db.prepare('SELECT run_id, status, processed_jobs, started_at FROM tagger_runs ORDER BY started_at DESC LIMIT 1').first(),
      db.prepare("SELECT COUNT(*) as count FROM ai_analysis_requests WHERE requested_at >= datetime('now', '-24 hours')").first<{ count: number }>(),
      db.prepare("SELECT COUNT(*) as count FROM facts WHERE collected_at >= datetime('now', '-24 hours')").first<{ count: number }>(),
    ])
    
    // Tagger runs
    const taggerRuns = await db.prepare(`
      SELECT run_id, tagger_version, status, total_jobs, processed_jobs, failed_jobs, 
             qa_passed, qa_failed, started_at, completed_at
      FROM tagger_runs
      ORDER BY started_at DESC
      LIMIT 10
    `).all()
    
    // Low confidence jobs
    const lowConfJobs = await db.prepare(`
      SELECT job_id, job_name, _confidence
      FROM job_attributes
      WHERE _confidence < 0.75
      ORDER BY _confidence ASC
      LIMIT 20
    `).all()
    
    // Tagger errors
    const taggerErrors = await db.prepare(`
      SELECT job_id, error_type, error_message, retry_count, created_at
      FROM tagger_errors
      ORDER BY created_at DESC
      LIMIT 20
    `).all()
    
    const { VERSIONS } = await import('./services/ai-analyzer/types')
    const { TAGGER_VERSION } = await import('./services/ai-analyzer/job-attributes-types')
    
    return c.html(renderAdminAiAnalyzer({
      overview: {
        taggedJobsCount: taggedJobs?.count || 0,
        candidatePoolSize: taggedJobs?.count || 0,
        targetPoolSize: 80,
        recentTaggerRun: recentRun as any || null,
        lowConfidenceCount: lowConf?.count || 0,
        analysisRequestsLast24h: analysisCount?.count || 0,
        followupsLast24h: followupCount?.count || 0,
        engineVersions: {
          scoring: VERSIONS.scoring,
          tagger: TAGGER_VERSION,
          recipe: VERSIONS.recipe,
        },
        recentSessionStats: {
          avgQuestionsGenerated: 3,
          avgFactsApplied: 0.5,
          totalSessions: 10,
        },
      },
      taggerRuns: (taggerRuns.results || []) as any[],
      lowConfidenceJobs: (lowConfJobs.results || []) as any[],
      taggerErrors: (taggerErrors.results || []) as any[],
    }))
  } catch (error) {
    console.error('AI Analyzer admin error:', error)
    return c.text('AI Analyzer 관제판을 불러오는데 실패했습니다: ' + (error instanceof Error ? error.message : 'Unknown'), 500)
  }
})

// 관리자 - 피드백 관리
app.get('/admin/feedback', requireAdmin, async (c) => {
  try {
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const pageSize = 20
    const result = await listFeedbackWithCommentCount(c.env.DB, { page, pageSize, includePrivate: true })

    return c.html(
      renderAdminFeedbackPage({
        page,
        total: result.total,
        pageSize,
        items: result.items as any,
      })
    )
  } catch (error) {
    console.error('Admin feedback page error:', error)
    return c.text('피드백 목록을 불러오는데 실패했습니다.', 500)
  }
})

// 피드백 상세
app.get('/admin/feedback/:id', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.redirect('/admin/feedback')

    const feedback = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!feedback) return c.redirect('/admin/feedback')

    // 작성자 정보 조회
    const authorRow = await c.env.DB.prepare(
      `SELECT name, username, picture_url FROM users WHERE id = ?`
    ).bind(feedback.user_id).first<{ name: string | null; username: string | null; picture_url: string | null }>()

    // 댓글 목록 조회
    const comments = await listComments(c.env.DB, id)
    const hasAdminComment = comments.some((c) => c.is_admin)

    return c.html(
      renderAdminFeedbackDetail({
        feedback: {
          ...feedback,
          author_name: authorRow?.name || authorRow?.username || `user_${feedback.user_id}`,
          author_picture: authorRow?.picture_url || null,
          last_activity_at: (feedback as any).last_activity_at || feedback.created_at,
        } as any,
        comments,
        hasAdminComment,
      })
    )
  } catch (error) {
    console.error('Admin feedback detail error:', error)
    return c.text('피드백을 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 - 피드백 상태 업데이트
app.patch('/api/admin/feedback/:id/status', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const body = await c.req.json().catch(() => ({}))
    const status = typeof body.status === 'string' ? body.status.trim() : ''
    if (!isValidFeedbackStatus(status)) return c.json({ success: false, error: 'invalid_status' }, 400)

    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)

    const updated = await updateFeedbackStatus(c.env.DB, id, status)
    return c.json({ success: true, status: updated?.status })
  } catch (error) {
    console.error('[feedback] status update error', error)
    return c.json({ success: false, error: 'failed_to_update_status' }, 500)
  }
})

// 관리자 - 사용자 관리 페이지
app.get('/admin/users', requireAdmin, async (c) => {
  try {
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    const search = c.req.query('search') || ''
    const role = c.req.query('role') || 'all'
    const status = c.req.query('status') || 'all'
    
    const result = await getUsers(c.env.DB, {
      page,
      perPage,
      search,
      role: role as any,
      status: status as any
    })
    
    return c.html(renderAdminUsers({
      users: result.users as any[],
      total: result.total,
      page: result.page,
      perPage: result.perPage,
      totalPages: result.totalPages,
      filters: { search, role, status }
    }))
  } catch (error) {
    console.error('Admin users error:', error)
    return c.text('사용자 목록을 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 - 사용자 상세 페이지
app.get('/admin/users/:id', requireAdmin, async (c) => {
  try {
    const userId = parseInt(c.req.param('id'))
    
    // 사용자 정보 조회
    const userRow = await c.env.DB
      .prepare(`SELECT * FROM users WHERE id = ?`)
      .bind(userId)
      .first()
    
    if (!userRow) {
      return c.text('사용자를 찾을 수 없습니다.', 404)
    }
    
    const user = {
      id: Number(userRow.id),
      email: String(userRow.email),
      name: userRow.name ? String(userRow.name) : null,
      username: userRow.username ? String(userRow.username) : null,
      pictureUrl: userRow.picture_url ? String(userRow.picture_url) : null,
      provider: userRow.provider ? String(userRow.provider) : 'google',
      providerUserId: userRow.provider_user_id ? String(userRow.provider_user_id) : null,
      googleId: userRow.google_id ? String(userRow.google_id) : null,
      role: String(userRow.role),
      editCount: Number(userRow.edit_count || 0),
      commentCount: Number(userRow.comment_count || 0),
      isBanned: Number(userRow.is_banned) === 1,
      banReason: userRow.ban_reason ? String(userRow.ban_reason) : null,
      bannedUntil: userRow.banned_until ? Number(userRow.banned_until) : null,
      onboarded: Number(userRow.onboarded || 0) === 1,
      lastLoginAt: userRow.last_login_at ? Number(userRow.last_login_at) : null,
      createdAt: Number(userRow.created_at)
    }
    
    // 유입경로 조회
    const attributionRow = await getUserAttribution(c.env.DB, userId)
    const attribution = attributionRow ? {
      selfChannel: attributionRow.self_channel,
      selfChannelOther: attributionRow.self_channel_other,
      interestState: attributionRow.interest_state,
      careerState: attributionRow.career_state,
      utmSource: attributionRow.utm_source,
      utmMedium: attributionRow.utm_medium,
      utmCampaign: attributionRow.utm_campaign,
      referrer: attributionRow.referrer,
      firstTouchAt: Math.floor(Date.now() / 1000) // 실제 값으로 교체 필요
    } : null
    
    // 최근 IP (댓글 기준)
    const latestIpRow = await c.env.DB
      .prepare(`SELECT display_ip FROM comments WHERE author_id = ? AND display_ip IS NOT NULL ORDER BY created_at DESC LIMIT 1`)
      .bind(String(userId))
      .first<{ display_ip: string | null }>()
    const latestIp = latestIpRow?.display_ip ? String(latestIpRow.display_ip) : null

    // 동의 이력 조회
    const consentsData = await getUserConsents(c.env.DB, userId)
    const consents = consentsData.map(consent => ({
      type: consent.type,
      version: consent.version,
      consentedAt: consent.consented_at,
      ip: consent.ip,
      ua: consent.ua
    }))
    
    // 최근 댓글 조회
    const commentsResult = await c.env.DB
      .prepare(`
        SELECT c.id, c.content, c.moderated, c.original_content, c.created_at, c.status,
               p.page_type, p.slug
        FROM comments c
        JOIN pages p ON p.id = c.page_id
        WHERE c.author_id = ?
        ORDER BY c.created_at DESC
        LIMIT 20
      `)
      .bind(String(userId))
      .all()
    
    const comments = (commentsResult.results || []).map((row: any) => ({
      id: Number(row.id),
      pageType: String(row.page_type),
      slug: String(row.slug),
      content: String(row.content),
      moderated: Number(row.moderated || 0) === 1,
      originalContent: row.original_content ? String(row.original_content) : undefined,
      createdAt: String(row.created_at),
      status: String(row.status)
    }))
    
    return c.html(renderAdminUserDetail({
      user,
      attribution,
      consents,
      comments,
      latestIp
    }))
  } catch (error) {
    console.error('Admin user detail error:', error)
    return c.text('사용자 정보를 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 API - 사용자 댓글 목록
app.get('/api/admin/users/:id/comments', requireAdmin, async (c) => {
  try {
    const userId = parseInt(c.req.param('id'))
    const limit = parseInt(c.req.query('limit') || '20')
    
    const commentsResult = await c.env.DB
      .prepare(`
        SELECT c.id, c.content, c.moderated, c.original_content, c.created_at, c.status,
               p.page_type, p.slug
        FROM comments c
        JOIN pages p ON p.id = c.page_id
        WHERE c.author_id = ?
        ORDER BY c.created_at DESC
        LIMIT ?
      `)
      .bind(String(userId), limit)
      .all()
    
    const comments = (commentsResult.results || []).map((row: any) => ({
      id: Number(row.id),
      pageType: String(row.page_type),
      slug: String(row.slug),
      content: String(row.content),
      moderated: Number(row.moderated || 0) === 1,
      originalContent: row.original_content ? String(row.original_content) : undefined,
      createdAt: String(row.created_at),
      status: String(row.status)
    }))
    
    return c.json({ success: true, data: comments })
  } catch (error) {
    console.error('Admin user comments error:', error)
    return c.json({ success: false, error: 'Failed to get user comments' }, 500)
  }
})

// 관리자 API - 사용자 관리
app.patch('/api/admin/users/:id', requireAdmin, async (c) => {
  try {
    const userId = parseInt(c.req.param('id'))
    const body = await c.req.json()
    
    // 역할 변경
    if (body.role) {
      const success = await updateUserRole(c.env.DB, userId, body.role)
      return c.json({ success })
    }
    
    // 차단
    if (body.action === 'ban') {
      const success = await banUser(c.env.DB, userId, body.duration, body.reason)
      return c.json({ success })
    }
    
    // 차단 해제
    if (body.action === 'unban') {
      const success = await unbanUser(c.env.DB, userId)
      return c.json({ success })
    }
    
    return c.json({ success: false, error: 'Invalid action' }, 400)
  } catch (error) {
    console.error('Admin user update error:', error)
    return c.json({ success: false, error: 'Failed to update user' }, 500)
  }
})

// 관리자 - 콘텐츠/편집 관리 페이지
app.get('/admin/content', requireAdmin, async (c) => {
  try {
    const activeTab = (c.req.query('tab') || 'revisions') as 'revisions' | 'archive' | 'comments'
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    const entityType = c.req.query('entityType') || 'all'
    const editorType = c.req.query('editorType') || 'all'
    const startDate = c.req.query('startDate') || ''
    const endDate = c.req.query('endDate') || ''
    
    // 편집 이력 가져오기
    const result = await getRevisions(c.env.DB, {
      page,
      perPage,
      entityType: entityType as any,
      editorType: editorType as any,
      startDate: startDate || undefined,
      endDate: endDate || undefined
    })

    let moderation: any = null
    let howtoReports = null
    if (activeTab === 'comments') {
      const modPage = page
      const modPerPage = perPage
      const flagged = await listFlaggedComments(c.env.DB, modPage, modPerPage)
      moderation = {
        items: flagged.items,
        total: flagged.total,
        page: modPage,
        perPage: modPerPage,
        totalPages: Math.max(1, Math.ceil(flagged.total / modPerPage))
      }
    } else if (activeTab === 'archive') {
      const rptPage = page
      const rptPerPage = perPage
      const reports = await listHowtoReports(c.env.DB, { status: 'pending', limit: rptPerPage, offset: (rptPage - 1) * rptPerPage })
      howtoReports = {
        items: reports.reports.map((r: any) => ({
          id: r.id,
          pageId: r.page_id,
          pageSlug: r.page_slug,
          pageTitle: r.page_title,
          reasonType: r.reason_type,
          reasonDetail: r.reason_detail,
          status: r.status,
          reporterId: r.reporter_id,
          reporterIpHash: r.reporter_ip_hash,
          createdAt: r.created_at
        })),
        total: reports.total,
        page: rptPage,
        perPage: rptPerPage,
        totalPages: Math.max(1, Math.ceil(reports.total / rptPerPage))
      }
    }
    
    // 숨겨진 직업/전공 목록 가져오기
    const hiddenJobsResult = await c.env.DB.prepare(`
      SELECT id, name, slug, primary_source, user_last_updated_at 
      FROM jobs 
      WHERE is_active = 0 
      ORDER BY user_last_updated_at DESC
    `).all<{ id: string; name: string; slug: string | null; primary_source: string; user_last_updated_at: number }>()
    
    const hiddenMajorsResult = await c.env.DB.prepare(`
      SELECT id, name, slug, primary_source, user_last_updated_at 
      FROM majors 
      WHERE is_active = 0 
      ORDER BY user_last_updated_at DESC
    `).all<{ id: string; name: string; slug: string | null; primary_source: string; user_last_updated_at: number }>()
    
    const hiddenJobs = (hiddenJobsResult.results || []).map(job => ({
      id: job.id,
      name: job.name,
      slug: job.slug,
      primarySource: job.primary_source,
      hiddenAt: job.user_last_updated_at
    }))
    
    const hiddenMajors = (hiddenMajorsResult.results || []).map(major => ({
      id: major.id,
      name: major.name,
      slug: major.slug,
      primarySource: major.primary_source,
      hiddenAt: major.user_last_updated_at
    }))
    
    return c.html(renderAdminContent({
      activeTab,
      revisions: result.revisions as any[],
      total: result.total,
      page: result.page,
      perPage: result.perPage,
      totalPages: result.totalPages,
      filters: { entityType, editorType, startDate, endDate },
      hiddenJobs,
      hiddenMajors,
      howtoReports: howtoReports ?? undefined,
      moderation: moderation ?? undefined
    }))
  } catch (error) {
    console.error('Admin content error:', error)
    return c.text('편집 이력을 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 API - 리비전 목록
app.get('/api/admin/revisions', requireAdmin, async (c) => {
  try {
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    const entityType = c.req.query('entityType') || 'all'
    const editorType = c.req.query('editorType') || 'all'
    const startDate = c.req.query('startDate') || ''
    const endDate = c.req.query('endDate') || ''
    
    const result = await getRevisions(c.env.DB, {
      page,
      perPage,
      entityType: entityType as any,
      editorType: editorType as any,
      startDate: startDate || undefined,
      endDate: endDate || undefined
    })
    
    return c.json({ success: true, data: result })
  } catch (error) {
    console.error('Admin revisions API error:', error)
    return c.json({ success: false, error: 'Failed to fetch revisions' }, 500)
  }
})

// 관리자 API - 신고/블라인드 댓글 목록
app.get('/api/admin/comments/moderation', requireAdmin, async (c) => {
  try {
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    const result = await listFlaggedComments(c.env.DB, page, perPage)
    const totalPages = Math.max(1, Math.ceil(result.total / perPage))
    return c.json({
      success: true,
      data: {
        items: result.items,
        total: result.total,
        page,
        perPage,
        totalPages
      }
    })
  } catch (error) {
    console.error('Admin comments moderation list error:', error)
    return c.json({ success: false, error: 'Failed to fetch comments' }, 500)
  }
})

// 관리자 API - 댓글 블라인드
app.post('/api/admin/comments/:id/blind', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) {
      return c.json({ success: false, error: 'invalid id' }, 400)
    }
    await setCommentStatus(c.env.DB, id, 'blinded')
    return c.json({ success: true })
  } catch (error) {
    console.error('Admin comment blind error:', error)
    return c.json({ success: false, error: 'Failed to blind comment' }, 500)
  }
})

// 관리자 API - 댓글 블라인드 해제
app.post('/api/admin/comments/:id/unblind', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) {
      return c.json({ success: false, error: 'invalid id' }, 400)
    }
    await setCommentStatus(c.env.DB, id, 'visible')
    return c.json({ success: true })
  } catch (error) {
    console.error('Admin comment unblind error:', error)
    return c.json({ success: false, error: 'Failed to unblind comment' }, 500)
  }
})

// 관리자 API - 신고 카운트 초기화
app.post('/api/admin/comments/:id/reset-reports', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) {
      return c.json({ success: false, error: 'invalid id' }, 400)
    }
    await resetCommentReports(c.env.DB, id)
    return c.json({ success: true })
  } catch (error) {
    console.error('Admin comment reset reports error:', error)
    return c.json({ success: false, error: 'Failed to reset reports' }, 500)
  }
})

// 관리자 API - 댓글 삭제 (대댓글 포함)
app.delete('/api/admin/comments/:id', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) {
      return c.json({ success: false, error: 'invalid id' }, 400)
    }
    await deleteComment(c.env.DB, { commentId: id, userId: 'admin', userRole: 'admin' })
    return c.json({ success: true })
  } catch (error) {
    console.error('Admin comment delete error:', error)
    return c.json({ success: false, error: 'Failed to delete comment' }, 500)
  }
})

// 관리자 API - 고아 대댓글 정리 (1회성)
app.post('/api/admin/comments/cleanup-orphans', requireAdmin, async (c) => {
  try {
    const deleted = await deleteOrphanReplies(c.env.DB)
    return c.json({ success: true, deleted })
  } catch (error) {
    console.error('Admin orphan cleanup error:', error)
    return c.json({ success: false, error: 'Failed to cleanup orphans' }, 500)
  }
})

// 관리자 API - 리비전 복원
app.post('/api/admin/revisions/:id/restore', requireAdmin, async (c) => {
  try {
    const revisionId = parseInt(c.req.param('id'))
    const user = c.get('user')
    const body = await c.req.json()
    
    if (!user) {
      return c.json({ success: false, error: 'Unauthorized' }, 401)
    }
    
    const success = await restoreRevisionAdmin(c.env.DB, revisionId, user.id, body.reason)
    return c.json({ success })
  } catch (error) {
    console.error('Admin restore revision error:', error)
    return c.json({ success: false, error: 'Failed to restore revision' }, 500)
  }
})

// 관리자 - 통계 대시보드 페이지
app.get('/admin/stats', requireAdmin, async (c) => {
  try {
    const endDate = c.req.query('endDate') || new Date().toISOString().split('T')[0]
    const startDate = c.req.query('startDate') || new Date(Date.now() - 30 * 86400000).toISOString().split('T')[0]
    const topLimit = parseInt(c.req.query('topLimit') || '10')
    
    const stats = await getAnalyticsStats(c.env.DB, { startDate, endDate, topLimit })
    
    return c.html(renderAdminStats({
      filters: { startDate, endDate, topLimit },
      ...stats
    }))
  } catch (error) {
    console.error('Admin stats error:', error)
    return c.text('통계를 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 API - 통계 데이터
app.get('/api/admin/stats', requireAdmin, async (c) => {
  try {
    const endDate = c.req.query('endDate') || new Date().toISOString().split('T')[0]
    const startDate = c.req.query('startDate') || new Date(Date.now() - 30 * 86400000).toISOString().split('T')[0]
    const topLimit = parseInt(c.req.query('topLimit') || '10')
    
    const stats = await getAnalyticsStats(c.env.DB, { startDate, endDate, topLimit })
    
    return c.json({ success: true, data: stats })
  } catch (error) {
    console.error('Admin stats API error:', error)
    return c.json({ success: false, error: 'Failed to fetch stats' }, 500)
  }
})

// ============================================================================
// 유사 이름 병합 관리 페이지 및 API
// ============================================================================

// 유사 이름 병합 관리 페이지 (데이터는 클라이언트에서 비동기 로드)
app.get('/similar-names', async (c) => {
  const typeParam = c.req.query('type') || 'job'
  const type = typeParam === 'major' ? 'major' : 'job'
  
  // 빈 페이지 먼저 렌더링, 데이터는 클라이언트에서 API 호출
  return c.html(renderAdminSimilarNamesPage({ type }))
})

// 유사 이름 후보 조회 API
app.get('/api/similar-names/:type', async (c) => {
  try {
    const type = c.req.param('type') as 'job' | 'major'
    if (type !== 'job' && type !== 'major') {
      return c.json({ success: false, error: 'Invalid type. Must be "job" or "major".' }, 400)
    }
    
    const minScoreParam = c.req.query('minScore')
    const minScore = minScoreParam ? parseFloat(minScoreParam) : 0.7
    
    if (isNaN(minScore) || minScore < 0 || minScore > 1) {
      return c.json({ success: false, error: 'minScore must be between 0 and 1' }, 400)
    }
    
    const result = await findSimilarNames(c.env.DB, type, minScore)
    
    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to find similar names'
    console.error('[similar-names] Error:', error)
    return c.json({ success: false, error: message }, 500)
  }
})

// 이름 매핑 저장 API
app.post('/api/name-mappings', async (c) => {
  try {
    const body = await c.req.json<{
      mappings: Array<{
        type: 'job' | 'major'
        sourceName: string
        targetName: string
        similarityScore?: number
        matchReason?: string
      }>
    }>()
    
    if (!body.mappings || !Array.isArray(body.mappings) || body.mappings.length === 0) {
      return c.json({ success: false, error: 'mappings array is required' }, 400)
    }
    
    // 유효성 검사
    for (const mapping of body.mappings) {
      if (!mapping.type || !['job', 'major'].includes(mapping.type)) {
        return c.json({ success: false, error: 'Invalid type in mapping' }, 400)
      }
      if (!mapping.sourceName || !mapping.targetName) {
        return c.json({ success: false, error: 'sourceName and targetName are required' }, 400)
      }
    }
    
    // 현재 사용자 정보 (미들웨어에서 설정)
    const user = c.get('user')
    const createdBy = user ? String(user.id) : 'admin'
    
    const result = await saveNameMappings(c.env.DB, body.mappings, createdBy)
    
    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to save mappings'
    console.error('[name-mappings] Error:', error)
    return c.json({ success: false, error: message }, 500)
  }
})

// 기존 매핑 조회 API
app.get('/api/name-mappings/:type', async (c) => {
  try {
    const type = c.req.param('type') as 'job' | 'major'
    if (type !== 'job' && type !== 'major') {
      return c.json({ success: false, error: 'Invalid type. Must be "job" or "major".' }, 400)
    }
    
    const mappings = await getExistingMappings(c.env.DB, type)
    
    return c.json({
      success: true,
      data: mappings
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to get mappings'
    console.error('[name-mappings] Error:', error)
    return c.json({ success: false, error: message }, 500)
  }
})

// 매핑 삭제 API
app.delete('/api/name-mappings/:id', async (c) => {
  try {
    const idParam = c.req.param('id')
    const id = parseInt(idParam, 10)
    
    if (isNaN(id)) {
      return c.json({ success: false, error: 'Invalid mapping ID' }, 400)
    }
    
    const result = await deleteNameMapping(c.env.DB, id)
    
    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }
    
    return c.json({ success: true })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to delete mapping'
    console.error('[name-mappings] Error:', error)
    return c.json({ success: false, error: message }, 500)
  }
})

