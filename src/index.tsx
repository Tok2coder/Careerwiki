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
  KVNamespace
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
  updateComment
} from './services/commentService'
import type { AnalysisType, PricingTier, RequestStatus } from './types/aiAnalysis'
import { getOrGeneratePage, invalidatePageCache } from './utils/page-cache'
import { editJob, editMajor, editHowTo } from './services/editService'
import { getRevisionById, listRevisions, restoreRevision } from './services/revisionService'
import { validateUrl } from './utils/editValidation'
import { findSimilarNames, saveNameMappings, deleteNameMapping, getExistingMappings } from './services/similarNamesService'
import { renderAdminSimilarNamesPage } from './templates/adminSimilarNames'


// Types
type Bindings = {
  DB: D1Database;
  KV: KVNamespace;
  CAREER_NET_API_KEY?: string;
  GOYONG24_MAJOR_API_KEY?: string;
  GOYONG24_JOB_API_KEY?: string;
  PERF_ALERT_WEBHOOK?: string;
  ADMIN_SECRET?: string;
  ENVIRONMENT?: string;
  // Phase 3: Google OAuth 환경 변수
  GOOGLE_CLIENT_ID: string;
  GOOGLE_CLIENT_SECRET: string;
  GOOGLE_CALLBACK_URL: string;
  JWT_SECRET: string;
}

type Variables = {
  title?: string;
  description?: string;
}

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>()

// Middleware
app.use('*', cors())
app.use('*', renderer)

// Serve static files from public directory
// All static assets including JS, CSS, images are served from /static/* path
// @ts-ignore - Cloudflare Workers types mismatch
app.use('/static/*', serveStatic({ root: './public' }))

// Phase 3: 인증 Middleware (모든 라우트에 적용)
app.use('*', authMiddleware)

// Phase 3: 인증 라우트
app.route('/auth', auth)

let logoIdCounter = 0

// Phase 3 Day 4: 사용자 정보에 따른 헤더 UI 생성 함수
const renderUserMenu = (
  user: { id: number; name: string | null; email: string; role: string; picture_url: string | null; username: string | null } | null,
  ipAddress: string | null = null
) => {
  // 로그인 여부와 관계없이 유저 아이콘 버튼 표시
  const menuHtml = `
    <!-- 유저 메뉴 드롭다운 -->
    <div class="relative" id="user-menu-container">
      <button 
        id="user-menu-btn" 
        class="header-icon-button" 
        title="사용자 메뉴"
        aria-label="사용자 메뉴"
        aria-expanded="false"
        aria-haspopup="true"
      >
        <i class="fas fa-user-circle text-base"></i>
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
        
        <!-- 설정 -->
        <a href="/user/settings" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem">
          <div class="flex items-center gap-3">
            <i class="fas fa-cog text-xs w-4 text-center"></i>
            <span>설정</span>
          </div>
        </a>
        
        <!-- 로그아웃 -->
        <form action="/auth/logout" method="POST">
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
        <a href="/auth/google" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem">
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

// Helper function for logo SVG (옵션 7: 플레이풀 둥근 폰트)
const getLogoSVG = (size: 'large' | 'small' = 'large') => {
  logoIdCounter += 1
  const gradientId = `logoGrad-${size}-${logoIdCounter}`
  const fontSize = size === 'large' ? 56 : 28
  const width = size === 'large' ? 360 : 180
  const height = size === 'large' ? 90 : 40
  const baselineOffset = size === 'large' ? 14 : 10
  const centerX = width / 2
  const centerY = height / 2 + baselineOffset

  return `
    <svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${width} ${height}" role="img" aria-label="Careerwiki 로고">
      <defs>
        <linearGradient id="${gradientId}" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" stop-color="#4361ee" />
          <stop offset="100%" stop-color="#64b5f6" />
        </linearGradient>
      </defs>
      <text
        x="${centerX}"
        y="${centerY}"
        font-family="'Comic Sans MS', 'Chalkboard SE', 'Marker Felt', cursive"
        font-size="${fontSize}"
        font-weight="bold"
        text-anchor="middle"
        fill="url(#${gradientId})"
        stroke="rgba(15, 23, 42, 0.35)"
        stroke-width="1"
        paint-order="stroke fill"
      >Careerwiki</text>
    </svg>
  `
}

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
    user?: { id: number; name: string | null; email: string; role: string; picture_url: string | null; username: string | null } | null
    context?: Context  // Phase 3 Day 4: Context를 통해 사용자 정보 자동 가져오기
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
          .menu-button {
            background: rgba(26, 26, 46, 0.9);
            border: 1px solid rgba(67, 97, 238, 0.3);
            padding: 14px 20px;
            border-radius: 12px;
            transition: all 0.3s;
          }
          .menu-button:hover {
            background: #4361ee;
            border-color: #4361ee;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(67, 97, 238, 0.4);
          }
          .homepage-header {
            width: 100%;
            padding: 10px 0;
          }
          .homepage-header > div {
            display: flex;
            align-items: center;
          }
          .header-icon-button {
            width: 36px;
            height: 36px;
            border-radius: 9999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: rgba(26, 26, 46, 0.55);
            border: 1px solid rgba(100, 181, 246, 0.2);
            color: #c3ccff;
            box-shadow: none;
            transition: background 0.2s ease, color 0.2s ease, border 0.2s ease;
          }
          .header-icon-button:hover {
            background: rgba(67, 97, 238, 0.25);
            color: #ffffff;
            border-color: rgba(100, 181, 246, 0.4);
          }
          .header-icon-button:focus-visible {
            outline: 2px solid #64b5f6;
            outline-offset: 3px;
          }
          .nav-search-shell {
            width: 100%;
          }
          .nav-search-bar {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 4px 10px 4px 14px;
            border-radius: 9999px;
            background: rgba(26, 26, 46, 0.55);
            border: 1px solid rgba(100, 181, 246, 0.25);
            transition: border 0.2s ease, box-shadow 0.2s ease;
          }
          .nav-search-bar:focus-within {
            border-color: #4361ee;
            box-shadow: 0 10px 26px rgba(67, 97, 238, 0.25);
          }
          .nav-search-input {
            flex: 1;
            background: transparent;
            border: none;
            color: #dee3ff;
            font-size: 13px;
            line-height: 1.4;
          }
          .nav-search-input::placeholder {
            color: #7f88a8;
          }
          .nav-search-input:focus {
            outline: none;
          }
          .nav-search-button {
            width: 32px;
            height: 32px;
            border-radius: 9999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
            background: linear-gradient(135deg, #4361ee 0%, #64b5f6 100%);
            color: #ffffff;
            font-size: 14px;
            box-shadow: 0 6px 14px rgba(67, 97, 238, 0.25);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            cursor: pointer;
          }
          .nav-search-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 12px 24px rgba(67, 97, 238, 0.35);
          }
          .nav-search-button:focus-visible {
            outline: 2px solid #64b5f6;
            outline-offset: 2px;
          }
          .nav-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 14px;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 600;
            letter-spacing: 0.01em;
            color: #d8dcff;
            background: rgba(26, 26, 46, 0.45);
            border: 1px solid transparent;
            transition: background 0.2s ease, color 0.2s ease, border 0.2s ease, transform 0.2s ease;
          }
          .nav-link:hover {
            color: #ffffff;
            background: linear-gradient(135deg, rgba(67, 97, 238, 0.65) 0%, rgba(100, 181, 246, 0.55) 100%);
            border-color: rgba(100, 181, 246, 0.45);
            transform: translateY(-1px);
          }
          .nav-link:focus-visible {
            outline: 2px solid #64b5f6;
            outline-offset: 3px;
          }
          .nav-link .nav-icon {
            font-size: 0.9rem;
          }
          .nav-link-mobile {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px 18px;
            background: rgba(26, 26, 46, 0.65);
            border-radius: 12px;
            border: 1px solid rgba(100, 181, 246, 0.25);
            text-align: center;
          }
          .mobile-menu-divider {
            border-top: 1px solid rgba(67, 97, 238, 0.25);
            padding-top: 12px;
            margin-top: 12px;
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
            gap: 10px;
            padding: 8px 12px 8px 18px;
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
            font-size: 16px;
            line-height: 1.5;
            padding: 0;
          }
          .search-shell input::placeholder {
            color: #8188a6;
          }
          .search-shell input:focus {
            outline: none;
          }
          .search-button {
            width: 42px;
            height: 42px;
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
          .pillar-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px;
            width: 100%;
            max-width: 520px;
          }
          @media (min-width: 768px) {
            .pillar-grid {
              grid-template-columns: repeat(4, minmax(0, 1fr));
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
    </head>
    <body class="bg-wiki-bg text-wiki-text min-h-screen">
        ${!isHomepage ? `
        <!-- Navigation (Not on homepage) -->
        <nav id="main-nav" class="glass-card fixed top-0 left-0 right-0 z-50 border-b border-wiki-border transition-transform duration-300">
            <div class="mx-auto w-full max-w-[1400px] px-3 py-2.5">
                <!-- Mobile Navigation - Single Line -->
                <div class="flex items-center gap-2 md:hidden">
                    <a href="/" class="flex items-center shrink-0 scale-75">
                        ${getLogoSVG('small')}
                    </a>
                    <form action="/search" method="get" class="flex-1 min-w-0 max-w-[calc(100%-140px)]">
                        <div class="nav-search-bar">
                            <i class="fas fa-search text-wiki-muted text-sm"></i>
                            <input type="text" name="q" 
                                   placeholder="검색..." 
                                   class="nav-search-input">
                            <button type="submit" class="sr-only" aria-label="검색">검색</button>
                        </div>
                    </form>
                    <button id="mobile-menu-btn" class="text-wiki-text shrink-0 w-10 h-10 flex items-center justify-center" aria-label="모바일 메뉴 열기">
                        <i class="fas fa-bars text-xl"></i>
                    </button>
                </div>

                <!-- Desktop Navigation -->
                <div class="hidden md:flex w-full items-center gap-4 flex-nowrap">
                    <a href="/" class="flex items-center shrink-0">
                        ${getLogoSVG('small')}
                    </a>
                    <form action="/search" method="get" class="nav-search-shell min-w-[240px] max-w-md">
                        <div class="nav-search-bar">
                            <input type="text" name="q" 
                                   placeholder="직업, 전공, 진로를 검색하세요..." 
                                   class="nav-search-input">
                            <button type="submit" class="nav-search-button" aria-label="검색">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                    <div class="flex-grow"></div>
                    <div class="flex items-center gap-4">
                        <a href="/analyzer" class="nav-link">
                            <i class="fas fa-brain nav-icon"></i>
                            <span>AI 분석</span>
                        </a>
                        <a href="/howto" class="nav-link">
                            <i class="fas fa-route nav-icon"></i>
                            <span>HowTo</span>
                        </a>
                        <a href="/help" class="header-icon-button" title="도움말">
                            <i class="fas fa-question-circle text-base"></i>
                        </a>
                        ${renderUserMenu(user)}
                    </div>
                </div>
            </div>
        </nav>
        
        <!-- Mobile Menu -->
        <div id="mobile-menu" class="hidden md:hidden glass-card border-b border-wiki-border fixed top-[57px] left-0 right-0 z-40">
            <div class="mx-auto w-full max-w-[1400px] py-3 px-6 space-y-2">
                <div class="flex items-center gap-2">
                    <a href="/analyzer" class="nav-link nav-link-mobile flex-1">
                        <i class="fas fa-brain mr-2"></i>AI 분석
                    </a>
                    <a href="/howto" class="nav-link nav-link-mobile flex-1">
                        <i class="fas fa-route mr-2"></i>HowTo
                    </a>
                </div>
                <div class="mobile-menu-divider flex items-center gap-3 justify-end pt-2">
                    <a href="/help" class="header-icon-button" title="도움말">
                        <i class="fas fa-question-circle"></i>
                    </a>
                    ${renderUserMenu(user)}
                </div>
            </div>
        </div>
        ` : ''}
        
        <!-- Main Content -->
        <main class="${isHomepage ? '' : 'mx-auto pt-[65px] md:pt-0'}">
            ${content}
        </main>
        
        <!-- Footer - Minimal & Trendy -->
        <footer class="border-t border-wiki-border mt-16">
            <div class="container mx-auto px-6 py-6">
                <div class="flex flex-col md:flex-row items-center justify-between gap-4">
                    <!-- Left: Logo & Links -->
                    <div class="flex items-center gap-6">
                        <div class="shrink-0">
                            ${getLogoSVG('small')}
                        </div>
                        <div class="hidden md:flex items-center gap-4 text-sm">
                            <a href="/analyzer" class="text-wiki-muted hover:text-wiki-primary transition">AI 분석</a>
                            <span class="text-wiki-border">·</span>
                            <a href="/job" class="text-wiki-muted hover:text-wiki-primary transition">직업위키</a>
                            <span class="text-wiki-border">·</span>
                            <a href="/major" class="text-wiki-muted hover:text-wiki-primary transition">전공위키</a>
                            <span class="text-wiki-border">·</span>
                            <a href="/howto" class="text-wiki-muted hover:text-wiki-primary transition">HowTo</a>
                            <span class="text-wiki-border">·</span>
                            <a href="/help" class="text-wiki-muted hover:text-wiki-primary transition">도움말</a>
                        </div>
                    </div>
                    
                    <!-- Right: Contact & Copyright -->
                    <div class="flex items-center gap-4 text-sm text-wiki-muted">
                        <a href="mailto:contact@careerwiki.org" class="hover:text-wiki-primary transition">
                            <i class="fas fa-envelope mr-1"></i>contact@careerwiki.org
                        </a>
                        <span class="hidden md:inline text-wiki-border">|</span>
                        <span>© 2024 Careerwiki</span>
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
        
        <!-- Phase 3 Day 4: 유저 메뉴 드롭다운 전역 스크립트 -->
        <script>
          (function() {
            function initUserMenu() {
              const btn = document.getElementById('user-menu-btn');
              const dropdown = document.getElementById('user-menu-dropdown');
              if (!btn || !dropdown) return;
              
              // 클릭 이벤트 리스너 추가
              btn.addEventListener('click', function(e) {
                e.stopPropagation();
                const isOpen = !dropdown.classList.contains('hidden');
                dropdown.classList.toggle('hidden', isOpen);
                btn.setAttribute('aria-expanded', String(!isOpen));
              });
              
              // 외부 클릭 시 드롭다운 닫기
              document.addEventListener('click', function(e) {
                if (!btn.contains(e.target) && !dropdown.contains(e.target)) {
                  dropdown.classList.add('hidden');
                  btn.setAttribute('aria-expanded', 'false');
                }
              });
            }
            
            // DOM 로드 완료 시 실행
            if (document.readyState === 'loading') {
              document.addEventListener('DOMContentLoaded', initUserMenu);
            } else {
              initUserMenu();
            }
          })();
        </script>
        
        <script src="/static/api-client.js?v=${Date.now()}"></script>
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
const getClientIp = (c: Context): string | null => {
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
  
  // 로컬 환경에서는 클라이언트 측에서 가져오도록 빈 문자열 반환
  return null
}

// Homepage - Google style with menu buttons
app.get('/', (c) => {
  // Phase 3 Day 4: 사용자 정보 가져오기
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, username: user.username } : null
  
  const content = `
    <div class="w-full min-h-screen flex flex-col">
        <header class="homepage-header">
            <div class="mx-auto w-full max-w-[1400px] px-3 flex items-center">
                <div class="flex-grow"></div>
                <div class="flex items-center gap-4">
                    <a href="/help" class="header-icon-button" title="도움말">
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
                                   placeholder="직업 · 전공 · 진로 인사이트를 검색하세요..." 
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
    user?: { id: number; name: string | null; email: string; role: string; picture_url: string | null; username: string | null } | null
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

// AI Job Analyzer
app.get('/analyzer/job', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto px-4 md:mt-8">
        <h1 class="text-3xl font-bold mb-8 text-center">
            <i class="fas fa-briefcase mr-3 text-wiki-secondary"></i>AI 직업 추천
        </h1>
        
        <div class="glass-card p-8 rounded-2xl">
            <form id="job-analyzer-form" class="space-y-6">
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
                
                <!-- Resume Upload -->
                <div>
                    <label class="block text-lg font-semibold mb-3">이력서를 업로드 해주세요 (선택)</label>
                    <input type="file" name="resume" 
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Current Job/Field -->
                <div>
                    <label class="block text-lg font-semibold mb-3">현재 직무 또는 관심 분야</label>
                    <input type="text" name="current_field" 
                           placeholder="예: 마케팅, 개발, 디자인, 영업 등"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Values -->
                <div>
                    <label class="block text-lg font-semibold mb-3">추구하는 가치</label>
                    <input type="text" name="values" 
                           placeholder="예: 워라밸, 성장, 안정성, 창의성"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Life Goals -->
                <div>
                    <label class="block text-lg font-semibold mb-3">인생 목표</label>
                    <textarea name="goals" rows="3" 
                              placeholder="10년 후 어떤 모습이 되고 싶으신가요?"
                              class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none"></textarea>
                </div>
                
                <!-- Skills -->
                <div>
                    <label class="block text-lg font-semibold mb-3">자신 있는 능력</label>
                    <input type="text" name="skills" 
                           placeholder="예: 커뮤니케이션, 분석력, 창의력, 리더십"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Weaknesses -->
                <div>
                    <label class="block text-lg font-semibold mb-3">약점 또는 피하고 싶은 것</label>
                    <input type="text" name="weaknesses" 
                           placeholder="예: 야근, 출장, 단순반복, 체력소모"
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
                                    <li>✓ 기본 직업 분석</li>
                                    <li>✓ 포지션 추천 3개</li>
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
                                    <li>✓ 심층 직업 분석</li>
                                    <li>✓ 포지션 추천 10개</li>
                                    <li>✓ 스킬 갭 분석</li>
                                    <li>✓ 학습 로드맵</li>
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
        document.getElementById('job-analyzer-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const pricing = document.querySelector('input[name="pricing"]:checked').value;
            alert('AI ' + (pricing === 'pro' ? 'Pro' : '무료') + ' 직업 분석이 시작되었습니다. 2-3분 내에 결과를 받아보실 수 있습니다.');
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
    '여러 댓글에 공감/비공감을 표시하는 것은 제한이 없습니다.',
    '단, 한 댓글에는 공감 또는 비공감 중 하나만 선택할 수 있습니다.',
    '자신이 작성한 댓글에는 공감/비공감을 할 수 없습니다.'
  ]
    .map((item) => `<li>${escapeHtml(item)}</li>`)
    .join('')

  const canonicalUrl = buildCanonicalUrl(c.req.url, '/help/community-guidelines')
  const content = `
    <section class="max-w-5xl mx-auto space-y-10 py-8">
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
        <p>정책 관련 문의는 <a href="mailto:hello@careerwiki.org" class="text-wiki-primary hover:text-wiki-secondary">hello@careerwiki.org</a>로 연락해 주세요.</p>
      </footer>
    </section>
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
  const perPage = 50 // 고정값
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

    // 공통 함수 renderJobCard 사용
    const jobCards = items.length
      ? items.map((entry) => renderJobCard(entry)).join('')
      : renderSampleJobHighlights()

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

    const extraHead = [jsonLd].filter(Boolean).join('\n')

    const content = `
      <div class="max-w-[1400px] mx-auto md:px-6">
        <!-- 히어로 섹션 with 그라데이션 블렌딩 -->
        <div class="relative text-center pb-12 mb-6 space-y-7">
          <!-- 배경 글로우 + 하단 페이드 -->
          <div class="absolute inset-0 -z-10 overflow-hidden">
            <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[800px] h-[400px] bg-gradient-to-b from-wiki-primary/8 via-wiki-primary/5 to-transparent rounded-full blur-[120px]"></div>
          </div>
          <!-- 하단 그라데이션 페이드 -->
          <div class="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-wiki-bg to-transparent -z-10"></div>
          
          <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-r from-wiki-primary/10 to-blue-500/10 border border-wiki-primary/20 backdrop-blur-sm">
            <span class="text-xs font-semibold text-wiki-primary">💼 JOB WIKI</span>
          </div>
          
          <h1 class="text-[38px] md:text-[42px] lg:text-5xl font-bold gradient-text leading-tight">
            ${headingLabel}
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
          <div class="flex flex-col sm:flex-row gap-3">
            <!-- 검색창 - 글래스모피즘 + 인셋 아이콘 -->
            <div class="flex-1 relative group">
              <div class="absolute inset-0 bg-gradient-to-r from-wiki-primary/20 via-wiki-secondary/20 to-wiki-primary/20 rounded-2xl blur-xl opacity-0 group-focus-within:opacity-100 transition-opacity duration-500"></div>
              <div class="relative flex items-center bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl overflow-hidden transition-all duration-300 group-focus-within:border-wiki-primary/50 group-focus-within:shadow-lg group-focus-within:shadow-wiki-primary/10">
                <span class="pl-4 pr-2 text-wiki-muted/60 group-focus-within:text-wiki-primary transition-colors duration-300">
                  <i class="fas fa-search text-sm"></i>
                </span>
                <input
                  id="job-keyword"
                  type="text"
                  name="q"
                  value="${escapeHtml(keyword)}"
                  placeholder="어떤 직업을 찾고 계신가요?"
                  class="flex-1 px-2 py-3.5 bg-transparent border-none focus:outline-none text-sm text-white placeholder:text-wiki-muted/50"
                />
                <button type="submit" class="m-1.5 px-5 py-2 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-primary/25 active:scale-95 transition-all duration-200">
                  검색
                </button>
              </div>
            </div>
            <!-- 정렬 - 커스텀 드롭다운 -->
            <div class="flex items-center" id="job-hydration-toolbar">
              <div class="relative" data-dropdown="job-sort">
                <button type="button" id="job-sort-trigger" class="flex items-center gap-2 pl-4 pr-3 py-3 bg-white/[0.03] border border-white/[0.06] rounded-xl text-sm text-white/70 hover:bg-white/[0.06] hover:border-white/[0.1] focus:outline-none focus:border-wiki-primary/40 transition-all duration-200 cursor-pointer min-w-[130px]">
                  <span id="job-sort-label">기본 순</span>
                  <i class="fas fa-chevron-down text-[10px] text-white/40 ml-auto transition-transform duration-200" id="job-sort-chevron"></i>
                </button>
                <div id="job-sort-menu" class="absolute right-0 top-full mt-2 w-44 py-1.5 bg-[#1c2333]/95 backdrop-blur-xl border border-white/[0.08] rounded-xl shadow-2xl shadow-black/40 opacity-0 invisible translate-y-1 transition-all duration-200 z-50">
                  <div class="px-2 py-1.5 text-[10px] font-medium text-white/30 uppercase tracking-wider">정렬 기준</div>
                  <button type="button" data-sort="relevance" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>기본 순</span>
                  </button>
                  <button type="button" data-sort="salary-desc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>연봉 높은 순</span>
                  </button>
                  <button type="button" data-sort="name-asc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>이름순</span>
                  </button>
                </div>
                <select id="job-sort-select" class="sr-only">
                  <option value="relevance">기본 순</option>
                  <option value="salary-desc">연봉 높은 순</option>
                  <option value="name-asc">이름순</option>
                </select>
              </div>
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
          
          const maxPageButtons = 7
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
                 class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                <i class="fas fa-chevron-left"></i>
              </a>
            `)
          }
          
          // 첫 페이지
          if (startPage > 1) {
            pageButtons.push(`
              <a href="${buildPageUrl(1)}" 
                 class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                1
              </a>
            `)
            if (startPage > 2) {
              pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`)
            }
          }
          
          // 페이지 번호들
          for (let i = startPage; i <= endPage; i++) {
            const isActive = i === page
            pageButtons.push(`
              <a href="${buildPageUrl(i)}" 
                 class="px-4 py-2 rounded-lg transition ${
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
              pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`)
            }
            pageButtons.push(`
              <a href="${buildPageUrl(totalPages)}" 
                 class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                ${totalPages}
              </a>
            `)
          }
          
          // 다음 페이지 버튼
          if (page < totalPages) {
            pageButtons.push(`
              <a href="${buildPageUrl(page + 1)}" 
                 class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
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
    const hydratedContent = `${content}${hydrationScript}`

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
  const perPage = 50 // 고정값
  const sort = c.req.query('sort') || 'relevance' // 정렬 옵션

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
      : renderSampleMajorHighlights()

    // 🆕 캐시 알림 제거 (사용자에게 보이지 않도록)
    const cacheNotice = '' // renderCacheNotice(cacheState, { staleSeconds: LIST_CACHE_STALE_SECONDS, maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS })

    const sourceSummaryHtml = '' // 데이터 수집 상태 제거
    const filterSummary = keyword ? `"${escapeHtml(keyword)}" 키워드` : '전체 전공'
    const headingLabel = keyword ? `“${escapeHtml(keyword)}” 관련 전공` : '전공위키'

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
      <div class="max-w-[1400px] mx-auto md:px-6">
        <!-- 히어로 섹션 with 그라데이션 블렌딩 -->
        <div class="relative text-center pb-12 mb-6 space-y-7">
          <!-- 배경 글로우 + 하단 페이드 -->
          <div class="absolute inset-0 -z-10 overflow-hidden">
            <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[800px] h-[400px] bg-gradient-to-b from-wiki-secondary/8 via-wiki-secondary/5 to-transparent rounded-full blur-[120px]"></div>
          </div>
          <!-- 하단 그라데이션 페이드 -->
          <div class="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-wiki-bg to-transparent -z-10"></div>
          
          <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-r from-wiki-secondary/10 to-purple-500/10 border border-wiki-secondary/20 backdrop-blur-sm">
            <span class="text-xs font-semibold text-wiki-secondary">🎓 MAJOR WIKI</span>
          </div>
          
          <h1 class="text-[38px] md:text-[42px] lg:text-5xl font-bold gradient-text leading-tight">
            ${headingLabel}
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
          <div class="flex flex-col sm:flex-row gap-3">
            <!-- 검색창 - 글래스모피즘 + 인셋 아이콘 -->
            <div class="flex-1 relative group">
              <div class="absolute inset-0 bg-gradient-to-r from-wiki-secondary/20 via-purple-500/20 to-wiki-secondary/20 rounded-2xl blur-xl opacity-0 group-focus-within:opacity-100 transition-opacity duration-500"></div>
              <div class="relative flex items-center bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl overflow-hidden transition-all duration-300 group-focus-within:border-wiki-secondary/50 group-focus-within:shadow-lg group-focus-within:shadow-wiki-secondary/10">
                <span class="pl-4 pr-2 text-wiki-muted/60 group-focus-within:text-wiki-secondary transition-colors duration-300">
                  <i class="fas fa-search text-sm"></i>
                </span>
                <input
                  id="major-keyword"
                  type="text"
                  name="q"
                  value="${escapeHtml(keyword)}"
                  placeholder="어떤 학과를 찾고 계신가요?"
                  class="flex-1 px-2 py-3.5 bg-transparent border-none focus:outline-none text-sm text-white placeholder:text-wiki-muted/50"
                />
                <button type="submit" class="m-1.5 px-5 py-2 bg-gradient-to-r from-wiki-secondary to-purple-500 text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-secondary/25 active:scale-95 transition-all duration-200">
                  검색
                </button>
              </div>
            </div>
            <!-- 정렬 - 커스텀 드롭다운 -->
            <div class="flex items-center" id="major-hydration-toolbar">
              <div class="relative" data-dropdown="major-sort">
                <button type="button" id="major-sort-trigger" class="flex items-center gap-2 pl-4 pr-3 py-3 bg-white/[0.03] border border-white/[0.06] rounded-xl text-sm text-white/70 hover:bg-white/[0.06] hover:border-white/[0.1] focus:outline-none focus:border-wiki-secondary/40 transition-all duration-200 cursor-pointer min-w-[140px]">
                  <span id="major-sort-label">기본 순</span>
                  <i class="fas fa-chevron-down text-[10px] text-white/40 ml-auto transition-transform duration-200" id="major-sort-chevron"></i>
                </button>
                <div id="major-sort-menu" class="absolute right-0 top-full mt-2 w-44 py-1.5 bg-[#1c2333]/95 backdrop-blur-xl border border-white/[0.08] rounded-xl shadow-2xl shadow-black/40 opacity-0 invisible translate-y-1 transition-all duration-200 z-50">
                  <div class="px-2 py-1.5 text-[10px] font-medium text-white/30 uppercase tracking-wider">정렬 기준</div>
                  <button type="button" data-sort="relevance" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-secondary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>기본 순</span>
                  </button>
                  <button type="button" data-sort="employment-desc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-secondary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>취업률 높은 순</span>
                  </button>
                  <button type="button" data-sort="salary-desc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-secondary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>월급 높은 순</span>
                  </button>
                </div>
                <select id="major-sort-select" class="sr-only">
                  <option value="relevance">기본 순</option>
                  <option value="employment-desc">취업률 높은 순</option>
                  <option value="salary-desc">월급 높은 순</option>
                </select>
              </div>
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
          
          const maxPageButtons = 7
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
                 class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                <i class="fas fa-chevron-left"></i>
              </a>
            `)
          }
          
          // 첫 페이지
          if (startPage > 1) {
            pageButtons.push(`
              <a href="${buildPageUrl(1)}" 
                 class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                1
              </a>
            `)
            if (startPage > 2) {
              pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`)
            }
          }
          
          // 페이지 번호들 (최대 7개만 표시)
          for (let i = startPage; i <= endPage; i++) {
            const isActive = i === page
            pageButtons.push(`
              <a href="${buildPageUrl(i)}" 
                 class="px-4 py-2 rounded-lg transition ${
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
              pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`)
            }
            pageButtons.push(`
              <a href="${buildPageUrl(totalPages)}" 
                 class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                ${totalPages}
              </a>
            `)
          }
          
          // 다음 페이지 버튼
          if (page < totalPages) {
            pageButtons.push(`
              <a href="${buildPageUrl(page + 1)}" 
                 class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
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
    const hydratedContent = `${content}${hydrationScript}`

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
          : renderSampleMajorHighlights()
        
        const totalPages = Math.ceil(totalCount / perPage)
        const buildPageUrl = (pageNum: number) => {
          const params = new URLSearchParams()
          if (keyword) params.set('q', keyword)
          if (includeSources?.length) params.set('sources', includeSources.join(','))
          if (pageNum > 1) params.set('page', String(pageNum))
          return `/major${params.toString() ? `?${params.toString()}` : ''}`
        }
        
        const maxPageButtons = 7
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
          <div class="max-w-[1400px] mx-auto md:px-6 md:mt-8">
            <div class="relative text-center mb-16 space-y-7">
              <div class="absolute inset-0 -z-10 overflow-hidden">
                <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[300px] bg-wiki-secondary/5 rounded-full blur-[100px]"></div>
              </div>
              <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-r from-wiki-secondary/10 to-purple-500/10 border border-wiki-secondary/20 backdrop-blur-sm">
                <span class="text-xs font-semibold text-wiki-secondary">🎓 MAJOR WIKI</span>
              </div>
              <h1 class="text-[38px] md:text-[42px] lg:text-5xl font-bold gradient-text leading-tight">
                ${keyword ? `"${escapeHtml(keyword)}" 관련 전공` : '전공위키'}
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

// HowTo Sample Pages
app.get('/howto', (c) => {
  const howtoSummaries = listSampleHowtoSummaries()
  const cards = howtoSummaries.length
    ? howtoSummaries
        .map((howto) => {
          const tags = howto.tags && howto.tags.length
            ? `<div class="flex flex-wrap gap-2 mt-3">${howto.tags
                .map((tag) => `<span class="px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted">${escapeHtml(tag)}</span>`)
                .join('')}</div>`
            : ''
          return `
            <article class="glass-card p-6 rounded-2xl hover-glow transition block">
              <div class="space-y-4">
                <div class="flex items-center gap-3">
                  <span class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-wiki-primary/15 text-wiki-primary"><i class="fas fa-route"></i></span>
                  <h3 class="text-xl font-bold text-white">
                    <a href="/howto/${encodeURIComponent(howto.slug)}" class="hover:text-wiki-secondary transition">
                      ${escapeHtml(howto.title)}
                    </a>
                  </h3>
                </div>
                <p class="text-sm text-wiki-muted leading-relaxed">${escapeHtml(howto.snippet)}</p>
                ${tags}
                <div class="flex items-center justify-between pt-4 border-t border-wiki-border/60">
                  <span class="text-xs text-wiki-muted uppercase tracking-wide">Phase 1 샘플 가이드</span>
                  <a href="/howto/${encodeURIComponent(howto.slug)}" class="inline-flex items-center gap-2 px-4 py-2 text-sm border border-wiki-border rounded-lg text-wiki-muted hover:text-wiki-primary hover:border-wiki-primary transition">
                    상세 보기<i class="fas fa-arrow-right"></i>
                  </a>
                </div>
              </div>
            </article>
          `
        })
        .join('')
    : `
      <div class="glass-card p-12 rounded-2xl text-center">
        <i class="fas fa-route text-4xl text-wiki-secondary mb-4"></i>
        <h2 class="text-2xl font-semibold text-white mb-2">등록된 HowTo가 없습니다</h2>
        <p class="text-sm text-wiki-muted">Phase 1 합성 가이드를 준비 중입니다. 곧 업데이트될 예정입니다.</p>
      </div>
    `

  const content = `
    <div class="max-w-[1400px] mx-auto md:px-6">
      <!-- 히어로 섹션 with 그라데이션 블렌딩 -->
      <header class="relative text-center pb-12 mb-6 space-y-7">
        <!-- 배경 글로우 + 하단 페이드 -->
        <div class="absolute inset-0 -z-10 overflow-hidden">
          <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[800px] h-[400px] bg-gradient-to-b from-amber-500/8 via-amber-500/5 to-transparent rounded-full blur-[120px]"></div>
        </div>
        <!-- 하단 그라데이션 페이드 -->
        <div class="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-wiki-bg to-transparent -z-10"></div>
        
        <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-gradient-to-r from-amber-500/10 to-orange-500/10 border border-amber-500/20 backdrop-blur-sm">
          <span class="text-xs font-semibold text-amber-400">🚀 HOWTO GUIDE</span>
        </div>
        
        <h1 class="text-[38px] md:text-[42px] lg:text-5xl font-bold gradient-text leading-tight">
          실전 HowTo 가이드
        </h1>
        
        <p class="text-lg md:text-xl text-wiki-text/90 max-w-2xl mx-auto font-medium leading-relaxed">
          먼저 간 사람들의 진짜 노하우를 배우세요
        </p>
      </header>
      <section class="space-y-6">
        ${cards}
      </section>
    </div>
  `

  return c.html(
    renderLayoutWithContext(c,
      content,
      'HowTo 시리즈 - Careerwiki',
      'Careerwiki Phase 1 샘플 HowTo 컬렉션으로 Growth 실행 가이드를 확인하세요.'
    )
  )
})

app.get('/howto/:slug', (c) => {
  const slug = c.req.param('slug')
  const sample = getSampleHowtoGuide(slug)

  if (!sample) {
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
  }

  return renderSampleHowtoDetailPage(c, sample)
})

// Help Page
app.get('/help', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
        <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
            <i class="fas fa-question-circle mr-3"></i>도움말
        </h1>
        
        <div class="grid md:grid-cols-2 gap-6 mb-8">
            <div class="glass-card p-6 rounded-xl">
                <h3 class="text-xl font-bold mb-3">이용가이드</h3>
                <p class="text-wiki-muted">Careerwiki는 진로·진학 정보공유 플랫폼입니다. 간단한 설문조사를 통해 AI가 나에게 맞는 정보를 추천해줍니다.</p>
            </div>
            <div class="glass-card p-6 rounded-xl">
                <h3 class="text-xl font-bold mb-3">FAQ</h3>
                <p class="text-wiki-muted">자주 묻는 질문과 답변을 확인하세요.</p>
            </div>
            <div class="glass-card p-6 rounded-xl">
                <h3 class="text-xl font-bold mb-3">건의사항</h3>
                <p class="text-wiki-muted">사이트 개선을 위한 의견을 보내주세요.</p>
            </div>
            <div class="glass-card p-6 rounded-xl">
                <h3 class="text-xl font-bold mb-3">저작권 관련</h3>
                <p class="text-wiki-muted">권리침해 및 저작권 관련 문의사항</p>
            </div>
        </div>
        
        <!-- FAQ Section -->
        <div class="glass-card p-8 rounded-2xl">
            <h2 class="text-2xl font-bold mb-6">자주 묻는 질문</h2>
            <div class="space-y-6">
                <div>
                    <h4 class="font-semibold mb-2">Q. AI 분석은 얼마나 정확한가요?</h4>
                    <p class="text-wiki-muted">A. AI 분석은 수많은 데이터를 기반으로 하지만, 참고용으로만 활용하시기 바랍니다. 최종 결정은 본인의 판단이 중요합니다.</p>
                </div>
                <div>
                    <h4 class="font-semibold mb-2">Q. 위키 내용을 수정할 수 있나요?</h4>
                    <p class="text-wiki-muted">A. 네, 회원가입 후 수정 제안을 하실 수 있으며, 관리자 검토 후 반영됩니다.</p>
                </div>
                <div>
                    <h4 class="font-semibold mb-2">Q. Pro 버전의 차이점은 무엇인가요?</h4>
                    <p class="text-wiki-muted">A. Pro 버전은 더 심층적인 분석과 많은 추천, 맞춤형 로드맵을 제공합니다.</p>
                </div>
            </div>
        </div>
    </div>
  `
  
  return c.html(renderLayoutWithContext(c, content, '도움말 - Careerwiki'))
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
      .map((keyword) => `<span class="px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-[11px] text-wiki-muted">${escapeHtml(keyword)}</span>`)
      .join('')}</div>`
  }

  const queryValueAttr = escapeHtml(keyword)
  const escapedQuery = escapeHtml(keyword)

  // 실제 D1 데이터 검색
  let jobCardsHtml = ''
  let majorCardsHtml = ''
  let howtoResults: Array<{ href: string; title: string; snippet: string; keywords: string[] }> = []

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
      const jobSearchResult = await searchUnifiedJobs(
        { keyword, page: 1, perPage: 5 },
        c.env
      )
      
      // 직업 만족도 등급 계산 함수
      const getSatisfactionGrade = (satisfaction: string | undefined) => {
        if (!satisfaction) return null
        const score = parseFloat(satisfaction) || 0
        
        if (score >= 80) {
          return { 
            level: '매우 좋음', 
            bg: 'bg-green-500/10', 
            border: 'border-green-500/20', 
            iconColor: 'text-green-400',
            textColor: 'text-green-300',
            textMuted: 'text-green-300/80'
          }
        } else if (score >= 60) {
          return { 
            level: '좋음', 
            bg: 'bg-sky-500/10', 
            border: 'border-sky-500/20', 
            iconColor: 'text-sky-400',
            textColor: 'text-sky-300',
            textMuted: 'text-sky-300/80'
          }
        } else if (score >= 40) {
          return { 
            level: '보통', 
            bg: 'bg-yellow-500/10', 
            border: 'border-yellow-500/20', 
            iconColor: 'text-yellow-400',
            textColor: 'text-yellow-300',
            textMuted: 'text-yellow-300/80'
          }
        } else if (score >= 20) {
          return { 
            level: '별로', 
            bg: 'bg-orange-500/10', 
            border: 'border-orange-500/20', 
            iconColor: 'text-orange-400',
            textColor: 'text-orange-300',
            textMuted: 'text-orange-300/80'
          }
        } else {
          return { 
            level: '매우 별로', 
            bg: 'bg-red-500/10', 
            border: 'border-red-500/20', 
            iconColor: 'text-red-400',
            textColor: 'text-red-300',
            textMuted: 'text-red-300/80'
          }
        }
      }
      
      jobCardsHtml = jobSearchResult.items.slice(0, 5).map((entry) => {
        const job = entry.profile
        const display = entry.display ?? {}
        const jobSlug = composeDetailSlug('job', job.name, job.id)
        const jobUrl = `/job/${encodeURIComponent(jobSlug)}`
        const summary = escapeHtml(formatSummaryText(display.summary, 'job'))
        const categoryName = display.categoryName
        
        const satisfactionGrade = getSatisfactionGrade(display.satisfaction)
        
        // 메트릭 박스들
        const metrics = [
          display.salary ? `
            <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-24 h-24 flex-shrink-0">
              <i class="fas fa-won-sign text-emerald-400 text-base"></i>
              <span class="text-[9px] font-medium text-emerald-300/70 mt-0.5">평균 연봉</span>
              <span class="text-[11px] font-bold text-emerald-300 text-center leading-tight px-1 overflow-hidden text-ellipsis whitespace-nowrap max-w-full">${escapeHtml(display.salary.replace(/평균\s*/g, ''))}</span>
            </div>
          ` : '',
          display.satisfaction && satisfactionGrade ? `
            <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-24 h-24 flex-shrink-0">
              <i class="fas fa-smile ${satisfactionGrade.iconColor} text-base"></i>
              <span class="text-[9px] font-medium ${satisfactionGrade.textMuted} mt-0.5">만족도</span>
              <span class="text-[11px] font-bold ${satisfactionGrade.textColor}">${escapeHtml(satisfactionGrade.level)}</span>
            </div>
          ` : '',
          display.wlb ? `
            <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-purple-500/10 backdrop-blur-sm border border-purple-500/20 w-24 h-24 flex-shrink-0">
              <i class="fas fa-balance-scale text-purple-400 text-base"></i>
              <span class="text-[9px] font-medium text-purple-300/70 mt-0.5">워라벨</span>
              <span class="text-[11px] font-bold text-purple-300 text-center leading-tight">${escapeHtml(display.wlb)}</span>
            </div>
          ` : '',
          display.departmentName ? `
            <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-indigo-500/10 backdrop-blur-sm border border-indigo-500/20 w-24 h-24 flex-shrink-0">
              <i class="fas fa-layer-group text-indigo-400 text-base"></i>
              <span class="text-[9px] font-medium text-indigo-300/70 mt-0.5">계열</span>
              <span class="text-[11px] font-bold text-indigo-300 text-center leading-tight px-1 overflow-hidden text-ellipsis whitespace-nowrap max-w-full">${escapeHtml(display.departmentName.length > 8 ? display.departmentName.substring(0, 8) + '...' : display.departmentName)}</span>
            </div>
          ` : ''
        ].filter(Boolean).join('')
        
        return `
          <article class="group relative">
            <a href="${jobUrl}" class="block">
              <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
                <!-- 배경 그라데이션 글로우 -->
                <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500">
                  <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
                  <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
                </div>
                
                <div class="relative flex gap-4">
                  <!-- 왼쪽: 직업 정보 (최대 너비 60% 제한) -->
                  <div class="flex-1 space-y-4 min-w-0 max-w-[60%]">
                    <!-- 헤더: 카테고리 + 직업명 -->
                    <div class="space-y-2">
                      ${categoryName ? `
                        <div class="flex items-center gap-2">
                          <span class="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-md text-[10px] font-semibold uppercase tracking-wider bg-wiki-secondary/10 text-wiki-secondary/80 border border-wiki-secondary/20">
                            <i class="fas fa-folder text-[8px]"></i>
                            ${escapeHtml(categoryName)}
                          </span>
                        </div>
                      ` : ''}
                      
                      <h2 class="text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">
                        ${escapeHtml(job.name)}
                      </h2>
                    </div>
                    
                    <!-- 설명 -->
                    <p class="text-sm leading-relaxed text-wiki-muted/90 line-clamp-2">
                      ${summary}
                    </p>
                  </div>
                  
                  <!-- 오른쪽: 메트릭 박스들 (정사각형, 고정 크기, 오른쪽 끝 정렬) -->
                  ${metrics ? `
                    <div class="flex gap-2 items-center justify-end flex-shrink-0 ml-auto">
                      ${metrics}
                    </div>
                  ` : ''}
                </div>
              </div>
            </a>
          </article>
        `
      }).join('')

      // 전공 검색
      const majorSearchResult = await searchUnifiedMajors(
        { keyword, page: 1, perPage: 5 },
        c.env
      )
      
      // 전공 만족도 등급 계산 함수
      const getMajorSatisfactionGrade = (satisfaction: string | undefined) => {
        if (!satisfaction) return null
        const score = parseFloat(satisfaction) || 0
        
        if (score >= 80) {
          return { 
            level: '매우 좋음', 
            bg: 'bg-green-500/10', 
            border: 'border-green-500/20', 
            iconColor: 'text-green-400',
            textColor: 'text-green-300',
            textMuted: 'text-green-300/80'
          }
        } else if (score >= 60) {
          return { 
            level: '좋음', 
            bg: 'bg-sky-500/10', 
            border: 'border-sky-500/20', 
            iconColor: 'text-sky-400',
            textColor: 'text-sky-300',
            textMuted: 'text-sky-300/80'
          }
        } else if (score >= 40) {
          return { 
            level: '보통', 
            bg: 'bg-yellow-500/10', 
            border: 'border-yellow-500/20', 
            iconColor: 'text-yellow-400',
            textColor: 'text-yellow-300',
            textMuted: 'text-yellow-300/80'
          }
        } else if (score >= 20) {
          return { 
            level: '별로', 
            bg: 'bg-orange-500/10', 
            border: 'border-orange-500/20', 
            iconColor: 'text-orange-400',
            textColor: 'text-orange-300',
            textMuted: 'text-orange-300/80'
          }
        } else {
          return { 
            level: '매우 별로', 
            bg: 'bg-red-500/10', 
            border: 'border-red-500/20', 
            iconColor: 'text-red-400',
            textColor: 'text-red-300',
            textMuted: 'text-red-300/80'
          }
        }
      }
      
      majorCardsHtml = majorSearchResult.items.slice(0, 5).map((entry) => {
        const major = entry.profile
        const display = entry.display ?? {}
        const majorSlug = composeDetailSlug('major', major.name, major.id)
        const majorUrl = `/major/${encodeURIComponent(majorSlug)}`
        const summary = escapeHtml(formatSummaryText(display.summary, 'major'))
        const categoryName = undefined // categoryName은 제목 위에 표시하지 않고 메트릭 박스로만 표시
        
        const satisfactionGrade = getMajorSatisfactionGrade(display.firstJobSatisfaction)
        
        // 메트릭 박스들 (우선순위: 취업률 > 평균월급 > 만족도 > 계열, 최대 3개)
        const categoryNameForMetric = display.categoryName && display.categoryName.split(',').length <= 2
          ? display.categoryName
          : undefined
        
        type HomeMetricBox = { html: string; priority: number }
        const homeMetricBoxes: HomeMetricBox[] = []
        
        if (display.employmentRate) {
          const rateText = formatEmploymentRate(display.employmentRate) || ''
          homeMetricBoxes.push({
            priority: 1,
            html: `
              <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-blue-500/10 backdrop-blur-sm border border-blue-500/20 w-20 h-20 sm:w-24 sm:h-24 flex-shrink-0">
                <i class="fas fa-chart-line text-blue-400 text-sm sm:text-base"></i>
                <span class="text-[8px] sm:text-[9px] font-medium text-blue-300/70 mt-0.5">취업률</span>
                <span class="text-[10px] sm:text-[11px] font-bold text-blue-300 text-center leading-tight px-1 truncate max-w-full">${escapeHtml(rateText)}</span>
              </div>
            `
          })
        }
        
        if (display.firstJobSalary) {
          const salaryText = display.firstJobSalary.includes('만원') ? display.firstJobSalary : `${display.firstJobSalary}만원`
          homeMetricBoxes.push({
            priority: 2,
            html: `
              <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-20 h-20 sm:w-24 sm:h-24 flex-shrink-0">
                <i class="fas fa-won-sign text-emerald-400 text-sm sm:text-base"></i>
                <span class="text-[8px] sm:text-[9px] font-medium text-emerald-300/70 mt-0.5">평균 월급</span>
                <span class="text-[10px] sm:text-[11px] font-bold text-emerald-300 text-center leading-tight px-1 truncate max-w-full">${escapeHtml(salaryText)}</span>
              </div>
            `
          })
        }
        
        if (display.firstJobSatisfaction && satisfactionGrade) {
          homeMetricBoxes.push({
            priority: 3,
            html: `
              <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-20 h-20 sm:w-24 sm:h-24 flex-shrink-0">
                <i class="fas fa-smile ${satisfactionGrade.iconColor} text-sm sm:text-base"></i>
                <span class="text-[8px] sm:text-[9px] font-medium ${satisfactionGrade.textMuted} mt-0.5">만족도</span>
                <span class="text-[10px] sm:text-[11px] font-bold ${satisfactionGrade.textColor}">${escapeHtml(satisfactionGrade.level)}</span>
              </div>
            `
          })
        }
        
        if (categoryNameForMetric) {
          homeMetricBoxes.push({
            priority: 4,
            html: `
              <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-purple-500/10 backdrop-blur-sm border border-purple-500/20 w-20 h-20 sm:w-24 sm:h-24 flex-shrink-0">
                <i class="fas fa-graduation-cap text-purple-400 text-sm sm:text-base"></i>
                <span class="text-[8px] sm:text-[9px] font-medium text-purple-300/70 mt-0.5">계열</span>
                <span class="text-[10px] sm:text-[11px] font-bold text-purple-300 text-center leading-tight px-1 truncate max-w-full">${escapeHtml(categoryNameForMetric.length > 8 ? categoryNameForMetric.substring(0, 8) + '...' : categoryNameForMetric)}</span>
              </div>
            `
          })
        }
        
        const sortedHomeBoxes = homeMetricBoxes.sort((a, b) => a.priority - b.priority).slice(0, 3)
        const metrics = sortedHomeBoxes.map((box, index) => {
          if (index === 2) return `<div class="hidden sm:flex">${box.html}</div>`
          return box.html
        }).join('')
        
        return `
          <article class="group relative">
            <a href="${majorUrl}" class="block">
              <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
                <!-- 배경 그라데이션 글로우 -->
                <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500">
                  <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
                  <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
                </div>
                
                <div class="relative flex gap-4">
                  <!-- 왼쪽: 전공 정보 (최대 너비 60% 제한) -->
                  <div class="flex-1 space-y-4 min-w-0 max-w-[60%]">
                    <!-- 헤더: 카테고리 + 전공명 -->
                    <div class="space-y-2">
                      ${categoryName ? `
                        <div class="flex items-center gap-2">
                          <span class="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-md text-[10px] font-semibold uppercase tracking-wider bg-wiki-secondary/10 text-wiki-secondary/80 border border-wiki-secondary/20">
                            <i class="fas fa-folder text-[8px]"></i>
                            ${escapeHtml(categoryName)}
                          </span>
                        </div>
                      ` : ''}
                      
                      <h2 class="text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">
                        ${escapeHtml(major.name)}
                      </h2>
                    </div>
                    
                    <!-- 설명 -->
                    <p class="text-sm leading-relaxed text-wiki-muted/90 line-clamp-2">
                      ${summary}
                    </p>
                  </div>
                  
                  <!-- 오른쪽: 메트릭 박스들 (정사각형, 고정 크기, 오른쪽 끝 정렬) -->
                  ${metrics ? `
                    <div class="flex gap-2 items-center justify-end flex-shrink-0 ml-auto">
                      ${metrics}
                    </div>
                  ` : ''}
                </div>
              </div>
            </a>
          </article>
        `
      }).join('')
    } catch (error) {
      console.error('검색 오류:', error)
    }
  }

  // HowTo는 샘플 데이터 사용
  const howtoSamples = listSampleHowtoSummaries()
  if (keyword) {
    const normalizedQuery = keyword.toLowerCase()
    howtoResults = howtoSamples
      .filter((item) => {
        const title = item.title.toLowerCase()
        const snippet = item.snippet.toLowerCase()
        return title.includes(normalizedQuery) || snippet.includes(normalizedQuery)
      })
      .slice(0, 3)
      .map((item) => ({
        href: `/howto/${encodeURIComponent(item.slug)}`,
        title: item.title,
        snippet: item.snippet,
        keywords: item.keywords
      }))
  } else {
    howtoResults = howtoSamples.slice(0, 3).map((item) => ({
      href: `/howto/${encodeURIComponent(item.slug)}`,
      title: item.title,
      snippet: item.snippet,
      keywords: item.keywords
    }))
  }

  const content = `
    <div class="max-w-[1400px] mx-auto md:px-6 md:mt-8">
        <div class="mb-8">
            <form action="/search" method="get" class="relative">
                <input 
                    type="text" 
                    name="q" 
                    value="${queryValueAttr}"
                    placeholder="검색어를 입력하세요" 
                    class="w-full px-6 py-4 bg-wiki-bg border border-wiki-border rounded-full text-lg focus:outline-none focus:border-wiki-primary transition"
                >
                <button type="submit" class="absolute right-2 top-1/2 -translate-y-1/2 px-6 py-2 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white rounded-full hover:scale-105 transition">
                    <i class="fas fa-search mr-2"></i>검색
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
                <a href="/job?q=${encodeURIComponent(keyword)}" class="block glass-card py-3 px-6 rounded-xl hover-glow transition text-center">
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
                <a href="/major?q=${encodeURIComponent(keyword)}" class="block glass-card py-3 px-6 rounded-xl hover-glow transition text-center">
                    <span class="text-sm font-medium text-wiki-text">전공 결과 더보기</span>
                </a>
                ` : ''}
            </div>
        </div>
        ` : ''}

        ${howtoResults.length > 0 ? `
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-green-500 mr-3"></span>
                HowTo
            </h2>
            <div class="space-y-3">
                ${howtoResults.map(howto => `
                    <a href="${howto.href}" class="glass-card p-4 rounded-lg hover-glow block transition">
                        <h3 class="text-lg font-semibold text-wiki-text">${escapeHtml(howto.title)}</h3>
                        <p class="text-sm text-wiki-muted mt-1 leading-relaxed">${escapeHtml(howto.snippet)}</p>
                        ${renderKeywordBadges(howto.keywords)}
                    </a>
                `).join('')}
                ${howtoResults.length >= 3 ? `
                <a href="/howto" class="block glass-card py-3 px-6 rounded-xl hover-glow transition text-center">
                    <span class="text-sm font-medium text-wiki-text">HowTo 결과 더보기</span>
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
  const slug = c.req.param('slug')
  let resolvedId = resolveDetailIdFromSlug('job', slug)
  
  // 🆕 If resolvedId doesn't contain ':', try to find by name in D1
  if (!resolvedId.includes(':') && c.env.DB) {
    try {
      const db = c.env.DB
      // Decode URL-encoded slug back to Korean
      const decodedSlug = decodeURIComponent(slug)
      
      
      // 1. 먼저 slug 필드로 직접 조회 (가장 정확)
      let result = await db.prepare(
        'SELECT id, name FROM jobs WHERE slug = ? LIMIT 1'
      ).bind(decodedSlug).first() as { id: string; name: string } | null
      
      // 2. slug로 못 찾으면 정규화된 slug로 검색 (하이픈 제거)
      if (!result) {
        const normalizedSlug = decodedSlug.toLowerCase().replace(/-/g, '')
        
        result = await db.prepare(
          'SELECT id, name FROM jobs WHERE LOWER(REPLACE(slug, "-", "")) = ? LIMIT 1'
        ).bind(normalizedSlug).first() as { id: string; name: string } | null
      }
      
      // 3. 여전히 못 찾으면 이름으로 검색
      if (!result) {
        const normalized = decodedSlug.toLowerCase().replace(/-/g, '')
        
        result = await db.prepare(
          'SELECT id, name FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? LIMIT 1'
        ).bind(normalized).first() as { id: string; name: string } | null
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
        
        if (!result.profile) {
          // Try sample data fallback
          const sample = findSampleJobDetail()
          if (sample) {
            throw new Error('SAMPLE_FALLBACK') // Signal to use sample rendering
          }
          
          throw new Error('PROFILE_NOT_FOUND')
        }
        
        return result
      },
      
      // Step 2: Render HTML
      renderHTML: (result) => {
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
          rawApiData: result.rawApiData
        })
        
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
  const slug = c.req.param('slug')
  let resolvedId = resolveDetailIdFromSlug('major', slug)
  
  // 🆕 If resolvedId doesn't contain ':', try to find by name in D1 (직업 페이지와 동일)
  if (!resolvedId.includes(':') && c.env.DB) {
    try {
      const db = c.env.DB
      // Decode URL-encoded slug back to Korean
      const decodedSlug = decodeURIComponent(slug)
      
      
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
        'SELECT id, name FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
      ).bind(normalized).first() as { id: string; name: string } | null
      
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

// 직업 카드 HTML 렌더링
const renderJobCard = (entry: { profile: any; display?: any }): string => {
  const job = entry.profile
  const display = entry.display ?? {}
  const jobSlug = composeDetailSlug('job', job.name, job.id)
  const jobUrl = `/job/${encodeURIComponent(jobSlug)}`
  const summary = escapeHtml(formatJobSummaryText(display.summary))
  const categoryName = display.categoryName || job.category?.name
  
  const satisfactionGrade = getSatisfactionGrade(display.satisfaction)
  
  // 메트릭 박스 생성 (우선순위: 평균 연봉 > 만족도 > 워라벨 > 작업 강도 > 숙련기간)
  type MetricBox = { html: string; priority: number }
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
      `
    })
  }
  
  // 5. 숙련기간 (직업사전)
  if (display.skillYear) {
    metricBoxes.push({
      priority: 5,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-cyan-500/10 backdrop-blur-sm border border-cyan-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-clock text-cyan-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-cyan-300/70">숙련기간</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-cyan-300 text-center leading-tight">${escapeHtml(display.skillYear)}</span>
        </div>
      `
    })
  }
  
  // 우선순위 정렬 후 최대 3개 선택
  const sortedBoxes = metricBoxes.sort((a, b) => a.priority - b.priority).slice(0, 3)
  
  // 메트릭 박스 HTML 생성 (3번째 박스는 모바일에서 숨김)
  const metricsHtml = sortedBoxes.map((box, index) => {
    if (index === 2) {
      return `<div class="hidden sm:flex">${box.html}</div>`
    }
    return box.html
  }).join('')

  return `
    <article class="group relative">
      <a href="${jobUrl}" class="block">
        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
          <!-- 배경 그라데이션 글로우 -->
          <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500">
            <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
            <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
          </div>
          
          <div class="relative flex gap-3 sm:gap-4">
            <!-- 왼쪽: 직업 정보 (최대 너비 60% 제한) -->
            <div class="flex-1 space-y-3 sm:space-y-4 min-w-0 max-w-[60%]">
              <!-- 헤더: 카테고리 + 직업명 -->
              <div class="space-y-1.5 sm:space-y-2">
                ${categoryName ? `
                  <div class="flex items-center gap-2">
                    <span class="inline-flex items-center gap-1 sm:gap-1.5 px-1.5 sm:px-2 py-0.5 rounded-md text-[9px] sm:text-[10px] font-semibold uppercase tracking-wider bg-wiki-secondary/10 text-wiki-secondary/80 border border-wiki-secondary/20">
                      <i class="fas fa-folder text-[7px] sm:text-[8px]"></i>
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
            
            <!-- 오른쪽: 메트릭 박스들 (최대 3개, 모바일에서 2개) -->
            ${metricsHtml ? `
              <div class="flex gap-2 sm:gap-2.5 items-center justify-end flex-shrink-0 ml-auto">
                ${metricsHtml}
              </div>
            ` : ''}
          </div>
        </div>
      </a>
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
  // 계열 이름: 콤마가 2개 이하인 경우에만 표시 (클라이언트 로직과 통일)
  const categoryName = display.categoryName && display.categoryName.split(',').length <= 2
    ? display.categoryName
    : undefined
  
  const satisfactionGrade = getSatisfactionGrade(display.firstJobSatisfaction)
  
  // 메트릭 박스 생성 (우선순위: 취업률 > 첫직장월급 > 만족도 > 계열)
  type MetricBox = { html: string; priority: number }
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
      `
    })
  }
  
  // 우선순위 정렬 후 최대 3개 선택
  const sortedBoxes = metricBoxes.sort((a, b) => a.priority - b.priority).slice(0, 3)
  
  // 메트릭 박스 HTML 생성 (3번째 박스는 모바일에서 숨김)
  const metricsHtml = sortedBoxes.map((box, index) => {
    if (index === 2) {
      return `<div class="hidden sm:flex">${box.html}</div>`
    }
    return box.html
  }).join('')

  return `
    <article class="group relative">
      <a href="${majorUrl}" class="block">
        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
          <!-- 배경 그라데이션 글로우 -->
          <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500">
            <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
            <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
          </div>
          
          <div class="relative flex gap-3 sm:gap-4">
            <!-- 왼쪽: 전공 정보 (최대 너비 60% 제한) -->
            <div class="flex-1 space-y-3 sm:space-y-4 min-w-0 max-w-[60%]">
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
            
            <!-- 오른쪽: 메트릭 박스들 (최대 3개, 모바일에서 2개) -->
            ${metricsHtml ? `
              <div class="flex gap-2 sm:gap-2.5 items-center justify-end flex-shrink-0 ml-auto">
                ${metricsHtml}
              </div>
            ` : ''}
          </div>
        </div>
      </a>
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

  const content = renderHowtoGuideDetail(sample.guide)

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
const getOptionalUser = (c: Context): RequestUser | null => {
  // authMiddleware에서 설정한 user 가져오기
  const user = c.get('user')
  
  if (!user) {
    return null  // 비로그인 사용자
  }
  
  return {
    id: user.id.toString(),
    role: mapRoleForComments(user.role),
    name: user.name
  }
}

const maskIpForDisplay = (ip: string | null | undefined): string | null => {
  if (!ip) return null
  if (ip.includes(':')) {
    const segments = ip.split(':').slice(0, 4)
    return `${segments.join(':')}::`
  }
  const parts = ip.split('.')
  if (parts.length !== 4) {
    return ip
  }
  return `${parts[0]}.${parts[1]}.*.*`
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

  try {
    const result = await getCommentsBySlug(c.env.DB, {
      slug: buildCommentPageSlug(entityTypeRaw, slug),
      pageType: entityTypeRaw,
      title,
      summary,
      limit,
      viewerId: viewer?.id ?? null,
      viewerRole: viewer?.role ?? 'user',
      includeModerated: viewer ? viewer.role !== 'user' : false
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
        viewer: viewer ? { id: viewer.id, name: viewer.name, role: viewer.role } : null,
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
  const ipAddress = c.req.header('cf-connecting-ip') ?? null
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
    : (user ? (nicknameRaw ?? user?.name ?? null) : null)  // 로그인 사용자는 nickname 또는 이름 사용, 익명 사용자는 null
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

    return c.json({ success: true, data: comment })
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
  if (!user) {
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
      userId: user.id,
      direction
    })
    if (!comment) {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    return c.json({ success: true, data: comment })
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
      password: passwordRaw ?? null
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
      password: passwordRaw ?? null
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
    const keyword = c.req.query('keyword') || ''
    const category = c.req.query('category') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 50 })
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const result = await searchUnifiedJobs({
      keyword,
      category,
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
    const id = c.req.param('id')
    
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
    let rawApiData = result.rawApiData || { careernet: null, goyong24: null }
    
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
    
    // 히어로 설명: 템플릿과 동일한 로직
    // 템플릿: const heroDescription = profile.summary?.split('\n')[0]?.trim() || rawApiData?.goyong24?.duty?.jobSum?.trim()
    // 편집 모드에서는 전체 summary를 편집할 수 있도록 profile.summary 전체를 사용
    const heroDescriptionFirstLine = profile.summary?.split('\n')[0]?.trim() 
      || rawApiData?.goyong24?.duty?.jobSum?.trim() || ''
    
    // summary 필드: 전체 profile.summary를 사용 (없으면 고용24의 duty.jobSum 사용)
    // 템플릿에서는 heroDescription만 사용하지만, 편집 모드에서는 전체 summary를 편집 가능하게
    const summaryForEdit = profile.summary || rawApiData?.goyong24?.duty?.jobSum || ''

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

    // 편집 가능한 필드만 추출 (실제 렌더링에 사용되는 값들)
    // 🆕 summary는 전체 profile.summary를 사용 (히어로 설명은 첫 줄만 표시되지만 편집은 전체를 편집)
    // profile.summary가 없으면 고용24의 duty.jobSum을 사용
    const editData = {
      name: profile.name || '',
      summary: summaryForEdit, // 전체 summary (히어로 설명은 첫 줄만 표시되지만 편집은 전체)
      duties: duties, // 실제 "하는 일" 섹션에 표시되는 주요 업무
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
      activitiesImportance: profile.activitiesImportance || '',
      activitiesLevels: profile.activitiesLevels || '',
      // 추가 필드들
      technKnow: profile.technKnow || '',
      aptitude: profile.aptitudeList?.map((item: any) => item.name || '').join('\n') || '',
      educationDistribution: profile.educationDistribution ? JSON.stringify(profile.educationDistribution, null, 2) : '',
      majorDistribution: profile.majorDistribution ? JSON.stringify(profile.majorDistribution, null, 2) : '',
      tags: tagText, // 태그 목록
      workSummary: workSummary // 전체 직업 소개 (히어로 설명과 다를 수 있음)
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
    const id = c.req.param('id')
    
    // 전공 상세페이지와 동일한 ID 해결 로직 사용
    const resolvedId = resolveDetailIdFromSlug('major', id)
    
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
              console.warn(`[major edit-data] Could not resolve DB ID from composite ID, using resolvedId: ${resolvedId}`)
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
            console.warn(`[major edit-data] Could not resolve DB ID, using resolvedId: ${resolvedId}`)
            actualDbId = resolvedId
          }
        }
      } catch (dbError) {
        console.error('[major edit-data] Failed to resolve DB ID:', dbError)
        // DB 조회 실패 시 resolvedId 사용
        actualDbId = resolvedId
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
          const editData = {
            name: profile.name || '',
            summary: profile.summary || '',
            property: profile.property || '',
            aptitude: profile.aptitude || '',
            whatStudy: profile.whatStudy || '',
            howPrepare: profile.howPrepare || '',
            enterField: profile.enterField ? JSON.stringify(profile.enterField, null, 2) : ''
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
    
    // 편집 가능한 필드만 추출
    const editData = {
      name: profile.name || '',
      summary: profile.summary || '',
      property: profile.property || '',
      aptitude: profile.aptitude || '',
      whatStudy: profile.whatStudy || '',
      howPrepare: profile.howPrepare || '',
      enterField: profile.enterField ? JSON.stringify(profile.enterField, null, 2) : ''
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

// 편집 모드 미리보기 API
app.post('/api/job/:id/preview', async (c) => {
  try {
    const id = c.req.param('id')
    const body = await c.req.json() as Record<string, string>

    // 현재 데이터 조회
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

    // 편집된 데이터로 프로필 업데이트
    const editedProfile: UnifiedJobDetail = {
      ...result.profile,
      name: body.name !== undefined ? body.name : result.profile.name,
      summary: body.summary !== undefined ? body.summary : result.profile.summary,
      duties: body.duties !== undefined ? body.duties : result.profile.duties,
      way: body.way !== undefined ? body.way : result.profile.way,
      salary: body.salary !== undefined ? body.salary : result.profile.salary,
      prospect: body.prospect !== undefined ? body.prospect : result.profile.prospect,
      satisfaction: body.satisfaction !== undefined ? body.satisfaction : result.profile.satisfaction,
      status: body.status !== undefined ? body.status : result.profile.status,
      abilities: body.abilities !== undefined ? body.abilities : result.profile.abilities,
      knowledge: body.knowledge !== undefined ? body.knowledge : result.profile.knowledge,
      environment: body.environment !== undefined ? body.environment : result.profile.environment,
      personality: body.personality !== undefined ? body.personality : result.profile.personality,
      interests: body.interests !== undefined ? body.interests : result.profile.interests,
      values: body.values !== undefined ? body.values : result.profile.values,
      activitiesImportance: body.activitiesImportance !== undefined ? body.activitiesImportance : result.profile.activitiesImportance,
      activitiesLevels: body.activitiesLevels !== undefined ? body.activitiesLevels : result.profile.activitiesLevels,
      technKnow: body.technKnow !== undefined ? body.technKnow : result.profile.technKnow
    }
    
    // aptitude는 aptitudeList로 변환 (필요한 경우)
    if (body.aptitude !== undefined && body.aptitude.trim()) {
      const aptitudeNames = body.aptitude.split('\n').filter(a => a.trim()).map(a => a.trim())
      editedProfile.aptitudeList = aptitudeNames.map(name => ({ name, score: 0 }))
    }
    
    // 태그 업데이트 (rawApiData에 반영)
    let updatedRawApiData = { ...result.rawApiData }
    if (body.tags !== undefined && updatedRawApiData?.careernet?.encyclopedia) {
      const tagList = body.tags.split('\n').filter(t => t.trim()).map(t => t.trim())
      updatedRawApiData = {
        ...updatedRawApiData,
        careernet: {
          ...updatedRawApiData.careernet,
          encyclopedia: {
            ...updatedRawApiData.careernet.encyclopedia,
            tagList
          }
        }
      }
    }

    // 실제 페이지 HTML 렌더링
    const previewHtml = renderUnifiedJobDetail({
      profile: editedProfile,
      partials: result.partials,
      sources: result.sources,
      rawApiData: updatedRawApiData
    })

    return c.json({
      success: true,
      html: previewHtml
    })
  } catch (error) {
    console.error('[preview] Error:', error)
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '미리보기 생성 실패'
    }, 500)
  }
})

// 전공 편집 모드 미리보기 API
app.post('/api/major/:id/preview', async (c) => {
  try {
    const id = c.req.param('id')
    const body = await c.req.json() as Record<string, string>

    // edit-data API와 동일한 ID 해결 로직 사용
    // ID가 G23_, C23_ 등으로 시작하면 실제 DB ID로 간주
    const isActualDbId = id && (id.match(/^[GC]\d+_/) !== null)
    
    let actualDbId = id
    if (c.env.DB && !isActualDbId) {
      try {
        // slug로 조회 시도
        const decodedSlug = decodeURIComponent(id)
        const normalizedSlug = decodedSlug.toLowerCase()
        const dbResult = await c.env.DB.prepare(
          'SELECT id FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first() as { id: string } | null
        
        if (!dbResult) {
          const dbResult2 = await c.env.DB.prepare(
            'SELECT id FROM majors WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first() as { id: string } | null
          
          if (dbResult2) {
            actualDbId = dbResult2.id
          }
        } else {
          actualDbId = dbResult.id
        }
        
      } catch (dbError) {
        console.error('[major preview] Failed to resolve DB ID:', dbError)
      }
    }
    
    const searchId = actualDbId

    // 현재 데이터 조회
    const result = await getUnifiedMajorDetail(
      {
        id: searchId, // 실제 DB ID 또는 resolvedId
        careernetId: undefined,
        goyong24Params: undefined
      },
      c.env
    )

    if (!result.profile) {
      console.error(`[major preview] Profile not found for searchId: ${searchId}`)
      return c.json({
        success: false,
        error: '전공 정보를 찾을 수 없습니다.'
      }, 404)
    }

    // 편집된 데이터로 프로필 업데이트 (직업 상세페이지와 동일한 로직)
    const editedProfile: UnifiedMajorDetail = {
      ...result.profile,
      name: body.name !== undefined ? body.name : result.profile.name,
      summary: body.summary !== undefined ? body.summary : result.profile.summary,
      property: body.property !== undefined ? body.property : result.profile.property,
      aptitude: body.aptitude !== undefined ? body.aptitude : result.profile.aptitude,
      whatStudy: body.whatStudy !== undefined ? body.whatStudy : result.profile.whatStudy,
      howPrepare: body.howPrepare !== undefined ? body.howPrepare : result.profile.howPrepare
    }
    
    // enterField는 JSON 문자열로 받아서 파싱
    if (body.enterField !== undefined && body.enterField.trim()) {
      try {
        editedProfile.enterField = JSON.parse(body.enterField)
      } catch (e) {
        // 파싱 실패 시 원본 유지
      }
    }

    // 실제 페이지 HTML 렌더링 (partials 제거하여 editedProfile이 우선 적용되도록)
    const { renderUnifiedMajorDetail } = await import('./templates/unifiedMajorDetail')
    const previewHtml = renderUnifiedMajorDetail({
      profile: editedProfile,
      partials: undefined,  // 편집된 profile만 사용
      sources: result.sources
    })

    return c.json({
      success: true,
      html: previewHtml
    })
  } catch (error) {
    console.error('[major preview] Error:', error)
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '미리보기 생성 실패'
    }, 500)
  }
})

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

// Phase 3 Day 4: 개인 설정 페이지
app.get('/user/settings', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/auth/google')
  }
  
  const userData = {
    id: user.id,
    name: user.name,
    email: user.email,
    username: user.username,
    picture_url: user.picture_url,
    role: user.role,
    created_at: user.created_at
  }
  
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
            <div class="flex items-center gap-4">
              <div class="w-20 h-20 rounded-full overflow-hidden border-2 border-wiki-border">
                <img 
                  src="${userData.picture_url || 'https://ui-avatars.com/api/?name=' + encodeURIComponent(userData.name || userData.email) + '&background=4361ee&color=fff'}" 
                  alt="${userData.name || 'User'}"
                  class="w-full h-full object-cover"
                />
              </div>
              <div>
                <p class="text-sm text-wiki-muted">프로필 사진은 Google 계정에서 변경할 수 있습니다.</p>
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
              <form id="username-form" class="flex gap-2">
                <input
                  type="text"
                  id="username"
                  name="username"
                  value="${userData.username || ''}"
                  placeholder="user_abc123"
                  pattern="[a-z0-9_]{3,20}"
                  class="flex-1 px-4 py-2 bg-wiki-card border border-wiki-border rounded-lg text-wiki-text focus:outline-none focus:border-wiki-primary focus:ring-1 focus:ring-wiki-primary"
                  required
                />
                <button
                  type="submit"
                  class="px-6 py-2 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition-colors font-medium"
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
                ${userData.created_at ? new Date(userData.created_at * 1000).toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' }) : '알 수 없음'}
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

// 직업 편집
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
    
    // Source URL 검증 (source가 제공된 경우에만 검증)
    if (source && !validateUrl(source)) {
      return c.json({ success: false, error: 'Invalid source URL. Must be a valid http/https URL' }, 400)
    }
    
    // IP 해시 생성
    const ipAddress = c.req.header('cf-connecting-ip') ?? null
    const ipHash = await hashIpAddress(ipAddress)
    
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
    
    // 캐시 무효화 (editJob 내부에서 이미 처리되지만, 중복 호출해도 안전)
    // editJob 내부에서 이미 invalidatePageCache를 호출하므로 여기서는 생략 가능
    // 하지만 API 엔드포인트에서도 호출하여 확실하게 처리
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

// 전공 편집
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
    
    // Source URL 검증 (source가 제공된 경우에만 검증)
    if (source && !validateUrl(source)) {
      return c.json({ success: false, error: 'Invalid source URL. Must be a valid http/https URL' }, 400)
    }
    
    // 실제 DB ID로 변환 (editJob과 동일한 로직)
    let majorId = majorIdParam
    let major = await c.env.DB.prepare('SELECT id FROM majors WHERE id = ? AND is_active = 1')
      .bind(majorId)
      .first<{ id: string }>()
    
    // ID로 찾지 못한 경우 slug로 시도
    if (!major) {
      // major:G_xxx 같은 형식에서 실제 ID 추출 시도
      let extractedId = majorId
      if (majorId.includes(':')) {
        const parts = majorId.split(':')
        if (parts.length > 1) {
          extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          major = await c.env.DB.prepare('SELECT id FROM majors WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first<{ id: string }>()
          
          if (major) {
            majorId = extractedId
          }
        }
      }
      
      // 여전히 찾지 못한 경우 slug로 시도
      if (!major) {
        const decodedSlug = decodeURIComponent(majorId)
        const normalizedSlug = decodedSlug.toLowerCase()
        
        major = await c.env.DB.prepare(
          'SELECT id FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first<{ id: string }>()
        
        if (!major) {
          major = await c.env.DB.prepare(
            'SELECT id FROM majors WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first<{ id: string }>()
        }
        
        if (!major) {
          major = await c.env.DB.prepare(
            'SELECT id FROM majors WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(decodedSlug).first<{ id: string }>()
        }
        
        if (major) {
          majorId = major.id
        }
      }
    }
    
    if (!major) {
      console.error(`[major edit] Major not found. Searched with: ${majorIdParam}`)
      return c.json({ success: false, error: 'MAJOR_NOT_FOUND' }, 404)
    }
    
    
    const ipAddress = c.req.header('cf-connecting-ip') ?? null
    const ipHash = await hashIpAddress(ipAddress)
    
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

// HowTo 편집
app.post('/api/howto/:slug/edit', requireHowToEdit, async (c) => {
  try {
    const slug = c.req.param('slug')
    const user = getOptionalUser(c)
    let body: any
    
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }
    
    const content = typeof body.content === 'string' ? body.content : ''
    const source = typeof body.source === 'string' ? body.source : undefined
    const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined
    const anonymous = Boolean(body.anonymous)
    const password = typeof body.password === 'string' ? body.password : undefined
    
    if (!content) {
      return c.json({ success: false, error: 'content is required' }, 400)
    }
    
    const ipAddress = c.req.header('cf-connecting-ip') ?? null
    const ipHash = await hashIpAddress(ipAddress)
    
    const result = await editHowTo(c.env.DB, slug, {
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
    const status = message.includes('NOT_FOUND') ? 404 
      : message.includes('REQUIRED') || message.includes('INVALID') ? 400
      : message.includes('LIMIT') ? 403
      : 500
    
    return c.json({ success: false, error: message }, status)
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
          
          editFormattedData = {
            name: profile.name || '',
            summary: summaryForEdit,
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
      password
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
    const user = c.get('user') as { id: string; email: string } | undefined
    const createdBy = user?.id ?? user?.email ?? 'admin'
    
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
