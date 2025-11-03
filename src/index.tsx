import { Hono } from 'hono'
import type { Context } from 'hono'
import { cors } from 'hono/cors'
import { serveStatic } from 'hono/cloudflare-workers'
import { renderer } from './renderer'
import { JOB_CATEGORIES, APTITUDE_TYPES } from './api/careernetAPI'
import { getUnifiedJobDetail, getUnifiedJobDetailWithRawData, getUnifiedMajorDetail, searchUnifiedJobs, searchUnifiedMajors } from './services/profileDataService'
import type { SourceStatusRecord } from './services/profileDataService'
import type { DataSource, UnifiedJobDetail, UnifiedMajorDetail } from './types/unifiedProfiles'
import { renderUnifiedJobDetail, createJobJsonLd } from './templates/unifiedJobDetail'
import { renderDataDebugPage } from './templates/dataDebugTemplate'
import { renderUnifiedMajorDetail, createMajorJsonLd } from './templates/unifiedMajorDetail'
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
import type { ExportedHandlerScheduledHandler } from '@cloudflare/workers-types'
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
  getCommentsBySlug,
  isIpBlocked,
  listIpBlocks,
  releaseIpAddress,
  reportComment,
  setCommentVote
} from './services/commentService'
import type { AnalysisType, PricingTier, RequestStatus } from './types/aiAnalysis'


// Types
type Bindings = {
  DB: D1Database;
  KV: KVNamespace;
  CAREER_NET_API_KEY?: string; // Cloudflare 환경 변수
  PERF_ALERT_WEBHOOK?: string;
}

type Variables = {
  title?: string;
  description?: string;
}

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>()

// Middleware
app.use('*', cors())
app.use('*', renderer)

// Serve static files
app.use('/static/*', serveStatic({ root: './public' }))

let logoIdCounter = 0

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
  }
) => {
  const canonicalUrl = options?.canonical ?? 'https://careerwiki.org'
  const ogUrl = options?.ogUrl ?? canonicalUrl
  const extraHead = options?.extraHead ?? ''

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
            max-width: 1100px;
            margin: 0 auto;
            padding: 24px 0 0;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 12px;
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
            padding: 60px 16px 40px;
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
              padding-top: 80px;
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
                        <a href="/login" class="header-icon-button" title="로그인 또는 회원가입">
                            <i class="fas fa-user-circle text-base"></i>
                        </a>
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
                    <a href="/login" class="header-icon-button" title="로그인 또는 회원가입">
                        <i class="fas fa-user-circle"></i>
                    </a>
                </div>
            </div>
        </div>
        ` : ''}
        
        <!-- Main Content -->
        <main class="${isHomepage ? '' : 'mx-auto px-2 md:px-6 pt-[65px] md:pt-0 py-4 md:py-8'}">
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
        
        <script src="/static/api-client.js"></script>
    </body>
    </html>
  `
}

const SOURCE_LABEL_MAP: Record<DataSource, string> = {
  CAREERNET: '커리어넷',
  GOYONG24: '고용24'
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

// Homepage - Google style with menu buttons
app.get('/', (c) => {
  const content = `
    <div class="w-full">
        <header class="homepage-header">
            <div class="flex items-center gap-3">
                <a href="/help" class="header-icon-button" title="도움말">
                    <i class="fas fa-question-circle text-lg"></i>
                </a>
                <a href="/login" class="header-icon-button" title="로그인 또는 회원가입">
                    <i class="fas fa-user-circle text-lg"></i>
                </a>
            </div>
        </header>

        <section class="hero-shell">
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

        <section class="mt-20 max-w-6xl mx-auto px-4">
            <div class="grid md:grid-cols-2 gap-8">
                <div>
                    <h2 class="text-2xl font-bold mb-6 gradient-text">
                        <i class="fas fa-fire mr-2"></i>인기 직업
                    </h2>
                    <div id="popular-jobs" class="min-h-[200px]">
                        <!-- Jobs will be loaded dynamically -->
                    </div>
                </div>

                <div>
                    <h2 class="text-2xl font-bold mb-6 gradient-text">
                        <i class="fas fa-star mr-2"></i>인기 전공
                    </h2>
                    <div id="popular-majors" class="min-h-[200px]">
                        <!-- Majors will be loaded dynamically -->
                    </div>
                </div>
            </div>
        </section>

        <section class="text-center text-wiki-muted text-sm mt-12 px-4">
            <p>1,000+ 직업 정보 · 500+ 전공 정보 · AI 기반 맞춤 분석</p>
        </section>
    </div>
  `
  
  return c.html(renderLayout(content, 'Careerwiki - AI 진로 분석 플랫폼', 'AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 플랫폼', true))
})

// AI Analyzer Page - Choose between Job or Major
app.get('/analyzer', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
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
  
  return c.html(renderLayout(content, 'AI 커리어 분석기 - Careerwiki'))
})

// AI Job Analyzer
app.get('/analyzer/job', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
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
  
  return c.html(renderLayout(content, 'AI 직업 추천 - Careerwiki'))
})

// AI Major Analyzer
app.get('/analyzer/major', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
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
  
  return c.html(renderLayout(content, 'AI 전공 추천 - Careerwiki'))
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
  const windowLabel = policy.voteWindowHours === 24 ? '24시간' : `${policy.voteWindowHours}시간`
  const voteDetails = [
    `${windowLabel} 동안 공감/비공감은 ${policy.dailyVoteLimit}회까지 가능합니다.`,
    '한도를 초과하면 다음 집계 윈도우가 시작될 때 자동으로 초기화됩니다.',
    '투표 활동은 정책 서명과 함께 텔레메트리로 기록되어 운영팀이 모니터링합니다.'
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
          <p class="text-xs text-wiki-muted/80">제한에 도달하면 안내 메시지가 표시되며 동일 윈도우에서는 추가 상호작용이 차단됩니다.</p>
        </article>
      </section>
      <section class="glass-card p-6 rounded-xl space-y-4">
        <h2 class="text-lg font-semibold text-wiki-text">상호작용 흐름 요약</h2>
        <ol class="space-y-2 text-sm text-wiki-muted list-decimal pl-5">
          <li>비로그인 사용자는 댓글을 열람할 수 있으며, 로그인 후에만 작성·공감·신고가 가능합니다.</li>
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
    renderLayout(
      content,
      '커뮤니티 이용 정책 - Careerwiki',
      'CareerWiki 댓글 커뮤니티 운영 원칙과 BEST/신고/공감 정책 안내',
      false,
      { canonical: canonicalUrl, ogUrl: canonicalUrl }
    )
  )
})

// Job Wiki List Page
app.get('/job', async (c) => {
  const keywordRaw = c.req.query('q') || ''
  const categoryRaw = c.req.query('category') || ''
  const keyword = keywordRaw.trim()
  const category = categoryRaw.trim()
  const includeSources = parseSourcesQuery(c.req.query('sources'))
  const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
  const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 100 })

  const categoryOptions = Object.entries(JOB_CATEGORIES)
    .map(([label, code]) => {
      const escapedCode = escapeHtml(code)
      const isSelected = code === category
      return `<option value="${escapedCode}" ${isSelected ? 'selected' : ''}>${escapeHtml(label)}</option>`
    })
    .join('')

  const perPageOptions = [10, 20, 30, 50]
    .map((size) => `<option value="${size}" ${perPage === size ? 'selected' : ''}>${size}개</option>`)
    .join('')

  const searchParams = new URLSearchParams()
  if (keyword) searchParams.set('q', keyword)
  if (category) searchParams.set('category', category)
  if (includeSources?.length) searchParams.set('sources', includeSources.join(','))
  if (page > 1) searchParams.set('page', String(page))
  if (perPage !== 20) searchParams.set('perPage', String(perPage))

  const canonicalPath = `/job${searchParams.toString() ? `?${searchParams.toString()}` : ''}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)

  const formatSummaryText = (value?: string | null): string => {
    const fallback = '고용24와 커리어넷 데이터를 통합하여 제공하는 직업 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
    if (!value) return fallback
    const normalized = value.replace(/\s+/g, ' ').trim()
    if (!normalized) return fallback
    return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
  }

  const getCategoryLabel = (): string | undefined => {
    const entry = Object.entries(JOB_CATEGORIES).find(([, code]) => code === category)
    return entry ? entry[0] : undefined
  }

  try {
    const forceRefresh = c.req.query('refresh') === '1'
    const { value: result, cacheState } = await withKvCache(
      c.env.KV,
      buildListCacheKey('job', { keyword, category, page, perPage, includeSources }),
      async () =>
        searchUnifiedJobs(
          {
            keyword,
            category,
            page,
            perPage,
            includeSources
          },
          c.env
        ),
      {
        staleSeconds: LIST_CACHE_STALE_SECONDS,
        maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS,
        metadata: {
          type: 'job-list',
          keyword: keyword || null,
          category: category || null,
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
      type: 'job',
      params: {
        keyword,
        category,
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
        freshnessRecordPromise.catch((err) => console.error('[freshness][job]', err))
      )
    } else {
      freshnessRecordPromise.catch((err) => console.error('[freshness][job]', err))
    }

    const jobCards = items.length
      ? items
          .map((entry) => {
            const job = entry.profile
            const display = entry.display ?? {}
            const jobSlug = composeDetailSlug('job', job.name, job.id)
            const jobUrl = `/job/${encodeURIComponent(jobSlug)}`
            const summary = escapeHtml(formatSummaryText(display.summary))
            const categoryName = display.categoryName || job.category?.name
            const statChips = [
              display.salary ? `<span class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted"><i class="fas fa-coins text-green-400"></i>${escapeHtml(display.salary)}</span>` : '',
              display.outlook ? `<span class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted"><i class="fas fa-chart-line text-wiki-secondary"></i>${escapeHtml(display.outlook)}</span>` : '',
              categoryName ? `<span class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted"><i class="fas fa-layer-group text-wiki-primary"></i>${escapeHtml(categoryName)}</span>` : ''
            ].filter(Boolean).join('')

            const sourcesBadges = Array.isArray(job.sources) && job.sources.length
              ? `<div class="flex flex-wrap gap-2 mt-4">${job.sources
                  .map((source) => `<span class="px-3 py-1 rounded-full bg-wiki-primary/10 border border-wiki-primary/40 text-xs text-wiki-primary"><i class="fas fa-database mr-1"></i>${SOURCE_LABEL_MAP[source] ?? source}</span>`)
                  .join('')}</div>`
              : ''

            return `
              <article class="glass-card p-6 rounded-2xl hover-glow transition">
                <div class="flex flex-col gap-4">
                  <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                    <div>
                      <h2 class="text-2xl font-bold text-white">
                        <a href="${jobUrl}" class="hover:text-wiki-secondary transition">${escapeHtml(job.name)}</a>
                      </h2>
                      ${categoryName ? `<p class="text-sm text-wiki-muted">${escapeHtml(categoryName)}</p>` : ''}
                    </div>
                    <a href="${jobUrl}" class="inline-flex items-center gap-2 px-4 py-2 rounded-lg border border-wiki-primary text-wiki-primary hover:bg-wiki-primary/10 transition">
                      <span>상세 보기</span>
                      <i class="fas fa-arrow-right"></i>
                    </a>
                  </div>
                  <p class="text-sm leading-relaxed text-wiki-muted">${summary}</p>
                  ${statChips ? `<div class="flex flex-wrap gap-2">${statChips}</div>` : ''}
                  ${sourcesBadges}
                </div>
              </article>
            `
          })
          .join('')
      : renderSampleJobHighlights()

    const cacheNotice = renderCacheNotice(cacheState, {
      staleSeconds: LIST_CACHE_STALE_SECONDS,
      maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS
    })

    const sourceSummaryHtml = renderSourceStatusSummary(result.meta?.sources, { id: 'job-source-summary' })
    const filterSummaryParts: string[] = []
    if (keyword) {
      filterSummaryParts.push(`"${escapeHtml(keyword)}" 키워드`)
    }
    if (category) {
      const categoryLabel = getCategoryLabel()
      filterSummaryParts.push(`${escapeHtml(categoryLabel ?? category)} 분류`)
    }
    const filterSummary = filterSummaryParts.length ? filterSummaryParts.join(' · ') : '전체 직업'
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
      <div class="max-w-6xl mx-auto">
        <div class="text-center mb-10">
          <h1 class="text-4xl font-bold mb-4 gradient-text">
            <i class="fas fa-briefcase mr-3"></i>${headingLabel}
          </h1>
          <p class="text-wiki-muted max-w-3xl mx-auto">
            고용24와 커리어넷의 최신 데이터를 바탕으로 직업별 연봉, 전망, 필요 역량을 탐색하세요.
          </p>
          <p class="text-xs text-wiki-muted mt-4">${filterSummary} · 총 <span id="job-total-count">${totalCount}</span>건</p>
        </div>

        <form id="job-filter-form" data-hydration-target="job" method="get" class="glass-card rounded-xl p-6 mb-6 grid md:grid-cols-[2fr,1fr,1fr,auto] gap-4 items-end">
          <div>
            <label class="block text-sm text-wiki-muted mb-2" for="job-keyword">키워드</label>
            <input
              id="job-keyword"
              type="text"
              name="q"
              value="${escapeHtml(keyword)}"
              placeholder="예: 데이터 사이언티스트, 간호사"
              class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none"
            />
          </div>
          <div>
            <label class="block text-sm text-wiki-muted mb-2" for="job-category">직무 분류</label>
            <select
              id="job-category"
              name="category"
              class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none"
            >
              <option value="">전체</option>
              ${categoryOptions}
            </select>
          </div>
          <div>
            <label class="block text-sm text-wiki-muted mb-2" for="job-per-page">페이지당</label>
            <select
              id="job-per-page"
              name="perPage"
              class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none"
            >
              ${perPageOptions}
            </select>
          </div>
          <div class="flex gap-2 justify-end">
            <button type="submit" class="px-6 py-3 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-semibold rounded-lg hover-glow transition">
              <i class="fas fa-search mr-2"></i>검색
            </button>
            <a href="/job" class="px-6 py-3 bg-wiki-bg border border-wiki-border text-wiki-muted font-semibold rounded-lg hover:border-wiki-primary transition">초기화</a>
          </div>
        </form>

        <div class="glass-card rounded-xl p-4 mb-6 flex flex-wrap items-center gap-4" id="job-hydration-toolbar">
          <div class="flex items-center gap-2">
            <label for="job-sort-select" class="text-sm text-wiki-muted">정렬</label>
            <select id="job-sort-select" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none">
              <option value="relevance">추천 순 (기본)</option>
              <option value="salary-desc">연봉 높은 순</option>
              <option value="outlook-desc">전망 좋은 순</option>
              <option value="name-asc">이름 오름차순</option>
            </select>
          </div>
          <div class="flex items-center gap-2">
            <label for="job-source-filter" class="text-sm text-wiki-muted">데이터 소스</label>
            <div class="flex items-center gap-3 text-xs text-wiki-muted" id="job-source-filter" aria-live="polite">
              <span class="inline-flex items-center gap-1"><span class="w-2 h-2 rounded-full bg-wiki-secondary"></span>커리어넷</span>
              <span class="inline-flex items-center gap-1"><span class="w-2 h-2 rounded-full bg-wiki-primary"></span>고용24</span>
            </div>
          </div>
          <div class="ml-auto text-xs text-wiki-muted" id="job-hydration-status" aria-live="polite"></div>
        </div>

        ${cacheNotice}

        <section id="job-results" class="space-y-4" aria-live="polite">
          ${jobCards}
        </section>

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
        category,
        includeSources: includeSources ?? null,
        sources: result.meta?.sources ?? null,
        cacheState
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
      renderLayout(
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
    console.error('Job list route error:', error)
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
      renderLayout(
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
  const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 100 })

  const perPageOptions = [10, 20, 30, 50]
    .map((size) => `<option value="${size}" ${perPage === size ? 'selected' : ''}>${size}개</option>`)
    .join('')

  const searchParams = new URLSearchParams()
  if (keyword) searchParams.set('q', keyword)
  if (includeSources?.length) searchParams.set('sources', includeSources.join(','))
  if (page > 1) searchParams.set('page', String(page))
  if (perPage !== 20) searchParams.set('perPage', String(perPage))
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
      buildListCacheKey('major', { keyword, page, perPage, includeSources }),
      async () =>
        searchUnifiedMajors(
          {
            keyword,
            page,
            perPage,
            includeSources
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

    const majorCards = items.length
      ? items
          .map((entry) => {
            const major = entry.profile
            const display = entry.display ?? {}
            const majorSlug = composeDetailSlug('major', major.name, major.id)
            const majorUrl = `/major/${encodeURIComponent(majorSlug)}`
            const summary = escapeHtml(formatSummaryText(display.summary))
            const statChips = [
              display.employmentRate ? `<span class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted"><i class="fas fa-user-graduate text-wiki-secondary"></i>${escapeHtml(display.employmentRate)}</span>` : '',
              display.salaryAfterGraduation ? `<span class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted"><i class="fas fa-coins text-green-400"></i>${escapeHtml(display.salaryAfterGraduation)}</span>` : '',
              display.categoryName ? `<span class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted"><i class="fas fa-layer-group text-wiki-primary"></i>${escapeHtml(display.categoryName)}</span>` : ''
            ].filter(Boolean).join('')

            const sourcesBadges = Array.isArray(major.sources) && major.sources.length
              ? `<div class="flex flex-wrap gap-2 mt-4">${major.sources
                  .map((source) => `<span class="px-3 py-1 rounded-full bg-wiki-primary/10 border border-wiki-primary/40 text-xs text-wiki-primary"><i class="fas fa-database mr-1"></i>${SOURCE_LABEL_MAP[source] ?? source}</span>`)
                  .join('')}</div>`
              : ''

            return `
              <article class="glass-card p-6 rounded-2xl hover-glow transition">
                <div class="flex flex-col gap-4">
                  <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                    <div>
                      <h2 class="text-2xl font-bold text-white">
                        <a href="${majorUrl}" class="hover:text-wiki-secondary transition">${escapeHtml(major.name)}</a>
                      </h2>
                      ${display.categoryName ? `<p class="text-sm text-wiki-muted">${escapeHtml(display.categoryName)}</p>` : ''}
                    </div>
                    <a href="${majorUrl}" class="inline-flex items-center gap-2 px-4 py-2 rounded-lg border border-wiki-primary text-wiki-primary hover:bg-wiki-primary/10 transition">
                      <span>상세 보기</span>
                      <i class="fas fa-arrow-right"></i>
                    </a>
                  </div>
                  <p class="text-sm leading-relaxed text-wiki-muted">${summary}</p>
                  ${statChips ? `<div class="flex flex-wrap gap-2">${statChips}</div>` : ''}
                  ${sourcesBadges}
                </div>
              </article>
            `
          })
          .join('')
      : renderSampleMajorHighlights()

    const cacheNotice = renderCacheNotice(cacheState, {
      staleSeconds: LIST_CACHE_STALE_SECONDS,
      maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS
    })

    const sourceSummaryHtml = renderSourceStatusSummary(result.meta?.sources, { id: 'major-source-summary' })
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
      <div class="max-w-6xl mx-auto">
        <div class="text-center mb-10">
          <h1 class="text-4xl font-bold mb-4 gradient-text">
            <i class="fas fa-university mr-3"></i>${headingLabel}
          </h1>
          <p class="text-wiki-muted max-w-3xl mx-auto">
            전공 커리큘럼, 개설 대학, 관련 직업 정보를 통합 데이터로 제공합니다.
          </p>
          <p class="text-xs text-wiki-muted mt-4">${filterSummary} · 총 <span id="major-total-count">${totalCount}</span>건</p>
        </div>

        <form id="major-filter-form" data-hydration-target="major" method="get" class="glass-card rounded-xl p-6 mb-6 grid md:grid-cols-[2fr,1fr,auto] gap-4 items-end">
          <div>
            <label class="block text-sm text-wiki-muted mb-2" for="major-keyword">키워드</label>
            <input
              id="major-keyword"
              type="text"
              name="q"
              value="${escapeHtml(keyword)}"
              placeholder="예: 인공지능, 간호, 기계"
              class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none"
            />
          </div>
          <div>
            <label class="block text-sm text-wiki-muted mb-2" for="major-per-page">페이지당</label>
            <select
              id="major-per-page"
              name="perPage"
              class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none"
            >
              ${perPageOptions}
            </select>
          </div>
          <div class="flex gap-2 justify-end">
            <button type="submit" class="px-6 py-3 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-semibold rounded-lg hover-glow transition">
              <i class="fas fa-search mr-2"></i>검색
            </button>
            <a href="/major" class="px-6 py-3 bg-wiki-bg border border-wiki-border text-wiki-muted font-semibold rounded-lg hover:border-wiki-primary transition">초기화</a>
          </div>
        </form>

        <div class="glass-card rounded-xl p-4 mb-6 flex flex-wrap items-center gap-4" id="major-hydration-toolbar">
          <div class="flex items-center gap-2">
            <label for="major-sort-select" class="text-sm text-wiki-muted">정렬</label>
            <select id="major-sort-select" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none">
              <option value="relevance">추천 순 (기본)</option>
              <option value="employment-desc">취업률 높은 순</option>
              <option value="salary-desc">연봉 높은 순</option>
              <option value="name-asc">이름 오름차순</option>
            </select>
          </div>
          <div class="ml-auto text-xs text-wiki-muted" id="major-hydration-status" aria-live="polite"></div>
        </div>

        ${cacheNotice}

        <section id="major-results" class="space-y-4" aria-live="polite">
          ${majorCards}
        </section>

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
      renderLayout(
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
    console.error('Major list route error:', error)
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
      renderLayout(
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
    <div class="max-w-6xl mx-auto">
      <header class="text-center mb-10 space-y-3">
        <h1 class="text-4xl font-bold gradient-text flex items-center justify-center gap-3">
          <i class="fas fa-route"></i>HowTo 시리즈
        </h1>
        <p class="text-sm text-wiki-muted max-w-3xl mx-auto">
          Careerwiki Phase 1 샘플 HowTo 가이드는 AI·Growth 실행 전략을 빠르게 검증하기 위한 템플릿입니다.
        </p>
      </header>
      <section class="space-y-6">
        ${cards}
      </section>
    </div>
  `

  return c.html(
    renderLayout(
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
      renderLayout(
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
  
  return c.html(renderLayout(content, '도움말 - Careerwiki'))
})

// Search Page with Relevance-based Results
app.get('/search', (c) => {
  const query = c.req.query('q') || ''
  const normalizedQuery = query.trim().toLowerCase()
  const hasQuery = normalizedQuery.length > 0

  const jobSamples = listSampleJobSummaries()
  const majorSamples = listSampleMajorSummaries()
  const howtoSamples = listSampleHowtoSummaries()

  const calculateScore = (item: { title: string; snippet: string; keywords: string[] }): number => {
    if (!hasQuery) return 0
    let score = 0
    const loweredTitle = item.title.toLowerCase()
    const loweredSnippet = item.snippet.toLowerCase()
    if (loweredTitle.includes(normalizedQuery)) score += 10
    if (loweredSnippet.includes(normalizedQuery)) score += 5
    item.keywords.forEach((keyword) => {
      const loweredKeyword = keyword.toLowerCase()
      if (loweredKeyword.includes(normalizedQuery)) score += 3
      if (normalizedQuery.includes(loweredKeyword)) score += 2
    })
    return score
  }

  const buildResultList = <T extends { slug: string; title: string; snippet: string; keywords: string[] }>(
    items: T[],
    basePath: 'job' | 'major' | 'howto',
    limit: number
  ) => {
    if (!hasQuery) {
      return items.slice(0, limit).map((item) => ({
        slug: item.slug,
        title: item.title,
        snippet: item.snippet,
        keywords: item.keywords,
        href: `/${basePath}/${encodeURIComponent(item.slug)}`
      }))
    }

    return items
      .map((item) => ({ item, score: calculateScore(item) }))
      .filter(({ score }) => score > 0)
      .sort((a, b) => b.score - a.score)
      .slice(0, limit)
      .map(({ item }) => ({
        slug: item.slug,
        title: item.title,
        snippet: item.snippet,
        keywords: item.keywords,
        href: `/${basePath}/${encodeURIComponent(item.slug)}`
      }))
  }

  const jobResults = buildResultList(jobSamples, 'job', 5)
  const majorResults = buildResultList(majorSamples, 'major', 5)
  const howtoResults = buildResultList(howtoSamples, 'howto', 3)

  const renderKeywordBadges = (keywords: string[]): string => {
    if (!keywords || !keywords.length) {
      return ''
    }
    return `<div class="flex flex-wrap gap-2 mt-3">${keywords.slice(0, 3)
      .map((keyword) => `<span class="px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-[11px] text-wiki-muted">${escapeHtml(keyword)}</span>`)
      .join('')}</div>`
  }

  const queryValueAttr = escapeHtml(query)
  const escapedQuery = escapeHtml(query)

  const content = `
    <div class="max-w-4xl mx-auto">
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

        ${jobResults.length > 0 ? `
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-primary mr-3"></span>
                직업위키
            </h2>
            <div class="space-y-3">
                ${jobResults.map(job => `
                    <a href="${job.href}" class="glass-card p-4 rounded-lg hover-glow block transition">
                        <h3 class="text-lg font-semibold text-wiki-text">${escapeHtml(job.title)}</h3>
                        <p class="text-sm text-wiki-muted mt-1 leading-relaxed">${escapeHtml(job.snippet)}</p>
                        ${renderKeywordBadges(job.keywords)}
                    </a>
                `).join('')}
            </div>
        </div>
        ` : ''}

        ${majorResults.length > 0 ? `
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-secondary mr-3"></span>
                전공위키
            </h2>
            <div class="space-y-3">
                ${majorResults.map(major => `
                    <a href="${major.href}" class="glass-card p-4 rounded-lg hover-glow block transition">
                        <h3 class="text-lg font-semibold text-wiki-text">${escapeHtml(major.title)}</h3>
                        <p class="text-sm text-wiki-muted mt-1 leading-relaxed">${escapeHtml(major.snippet)}</p>
                        ${renderKeywordBadges(major.keywords)}
                    </a>
                `).join('')}
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
            </div>
        </div>
        ` : ''}

        ${jobResults.length === 0 && majorResults.length === 0 && howtoResults.length === 0 ? `
        <div class="glass-card p-8 rounded-xl text-center">
            <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">"${escapedQuery}"에 대한 검색 결과가 없습니다.</p>
            <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도하거나 Phase 1 샘플 콘텐츠를 탐색해 보세요.</p>
        </div>
        ` : ''}
    </div>
  `

  const title = hasQuery ? `${query} - Careerwiki 검색` : '검색 - Careerwiki'
  const description = hasQuery
    ? createMetaDescription(`"${query}"와 관련된 Careerwiki 직업, 전공, HowTo 정보를 확인하세요.`)
    : 'Careerwiki에서 직업, 전공, HowTo 샘플 인사이트를 검색해보세요.'

  return c.html(renderLayout(content, escapeHtml(title), escapeHtml(description)))
})

// Unified Job Detail Page (SSR)
app.get('/job/:slug', async (c) => {
  const slug = c.req.param('slug')
  const resolvedId = resolveDetailIdFromSlug('job', slug)
  let careernetId = c.req.query('careernetId') || undefined
  let goyongJobId = c.req.query('goyongJobId') || undefined
  const includeSources = parseSourcesQuery(c.req.query('sources')) || ['CAREERNET', 'GOYONG24'] // Default to both sources
  const debugMode = c.req.query('debug') === 'true' || resolvedId === 'job:C_375'

  const findSampleJobDetail = () => {
    const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
    for (const candidate of candidates) {
      const sample = getSampleJobDetail(candidate)
      if (sample) {
        return sample
      }
    }
    return null
  }

  // Try to extract source IDs from sample data if not provided
  if (!careernetId || !goyongJobId) {
    const sample = findSampleJobDetail()
    if (sample?.profile?.sourceIds) {
      if (!careernetId && sample.profile.sourceIds.careernet) {
        careernetId = sample.profile.sourceIds.careernet
      }
      if (!goyongJobId && sample.profile.sourceIds.goyong24) {
        goyongJobId = sample.profile.sourceIds.goyong24
      }
    }
  }

  try {
    // Cache strategy: Check cache first, fallback to API, cache for 1 hour
    const cacheKey = `job:${resolvedId}:${careernetId || 'none'}:${goyongJobId || 'none'}`
    const cache = caches.default
    const cacheUrl = new URL(c.req.url)
    cacheUrl.pathname = `/cache/${cacheKey}`
    
    let cachedResponse = await cache.match(cacheUrl)
    let result
    
    if (cachedResponse && !debugMode) {
      // Use cached data
      result = await cachedResponse.json()
    } else {
      // Fetch from API
      result = await getUnifiedJobDetailWithRawData(
        {
          id: resolvedId,
          careernetId,
          goyong24JobId: goyongJobId || undefined,
          includeSources
        },
        c.env
      )
      
      // Cache for 1 hour (3600 seconds)
      if (result.profile) {
        const responseToCache = new Response(JSON.stringify(result), {
          headers: {
            'Content-Type': 'application/json',
            'Cache-Control': 'public, max-age=3600'
          }
        })
        c.executionCtx.waitUntil(cache.put(cacheUrl, responseToCache))
      }
    }

    if (!result.profile) {
      const sample = findSampleJobDetail()
      if (sample) {
        // Pass rawApiData even when using sample profile
        return renderSampleJobDetailPageWithRawData(c, sample, result.rawApiData)
      }

      const fallbackHtml = renderDetailFallback({
        icon: 'fa-magnifying-glass',
        title: '직업 정보를 찾을 수 없습니다',
        description: '요청하신 직업 데이터가 CareerWiki 통합 파이프라인에 아직 준비되지 않았습니다.',
        ctaHref: '/job',
        ctaLabel: '직업위키로 돌아가기'
      })
      const sourceSummary = renderSourceStatusSummary(result.sources)
      const pageContent = `${fallbackHtml}${sourceSummary}`
      c.status(404)
      return c.html(
        renderLayout(
          pageContent,
          '직업 정보 없음 - Careerwiki',
          '요청한 직업 정보를 찾을 수 없습니다.'
        )
      )
    }

    const profile = result.profile
    
    // Render debug page if in debug mode
    if (debugMode && 'rawApiData' in result) {
      const debugContent = renderDataDebugPage({
        profile,
        partials: result.partials,
        sources: result.sources,
        rawApiData: result.rawApiData
      })
      
      return c.html(debugContent)
    }
    
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
      createJobJsonLd(profile, canonicalUrl)
    ].filter(Boolean).join('\n')

    const content = renderUnifiedJobDetail({
      profile,
      partials: result.partials,
      sources: result.sources,
      rawApiData: result.rawApiData
    })

    return c.html(
      renderLayout(
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
  } catch (error) {
    console.error('Job detail route error:', error)
    const sample = findSampleJobDetail()
    if (sample) {
      console.warn('Job detail fallback: serving synthetic sample for', slug)
      return renderSampleJobDetailPage(c, sample)
    }
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
      renderLayout(
        fallbackHtml,
        '직업 정보 로드 오류 - Careerwiki',
        '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
      )
    )
  }
})

// Unified Major Detail Page (SSR)
app.get('/major/:slug', async (c) => {
  const slug = c.req.param('slug')
  const resolvedId = resolveDetailIdFromSlug('major', slug)
  const careernetId = c.req.query('careernetId') || undefined
  const majorGbParam = c.req.query('goyongMajorGb')
  const departmentId = c.req.query('goyongDepartmentId') || undefined
  const majorId = c.req.query('goyongMajorId') || undefined
  const includeSources = parseSourcesQuery(c.req.query('sources'))

  const findSampleMajorDetail = () => {
    const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
    for (const candidate of candidates) {
      const sample = getSampleMajorDetail(candidate)
      if (sample) {
        return sample
      }
    }
    return null
  }

  const goyongMajorGb = majorGbParam === '1' ? '1' : majorGbParam === '2' ? '2' : undefined
  const goyongParams = goyongMajorGb && departmentId && majorId
    ? {
        majorGb: goyongMajorGb,
        departmentId,
        majorId
      }
    : undefined

  try {
    const result = await getUnifiedMajorDetail(
      {
        id: resolvedId,
        careernetId,
        goyong24Params: goyongParams,
        includeSources
      },
      c.env
    )

    if (!result.profile) {
      const sample = findSampleMajorDetail()
      if (sample) {
        return renderSampleMajorDetailPage(c, sample)
      }

      const fallbackHtml = renderDetailFallback({
        icon: 'fa-magnifying-glass',
        title: '전공 정보를 찾을 수 없습니다',
        description: '요청하신 전공 데이터가 CareerWiki 통합 파이프라인에 아직 준비되지 않았습니다.',
        ctaHref: '/major',
        ctaLabel: '전공위키로 돌아가기'
      })
      const sourceSummary = renderSourceStatusSummary(result.sources)
      const pageContent = `${fallbackHtml}${sourceSummary}`
      c.status(404)
      return c.html(
        renderLayout(
          pageContent,
          '전공 정보 없음 - Careerwiki',
          '요청한 전공 정보를 찾을 수 없습니다.'
        )
      )
    }

    const profile = result.profile
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
      createMajorJsonLd(profile, canonicalUrl)
    ].filter(Boolean).join('\n')

    const content = renderUnifiedMajorDetail({
      profile,
      partials: result.partials,
      sources: result.sources
    })

    return c.html(
      renderLayout(
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
  } catch (error) {
    console.error('Major detail route error:', error)
    const sample = findSampleMajorDetail()
    if (sample) {
      console.warn('Major detail fallback: serving synthetic sample for', slug)
      return renderSampleMajorDetailPage(c, sample)
    }
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
      renderLayout(
        fallbackHtml,
        '전공 정보 로드 오류 - Careerwiki',
        '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
      )
    )
  }
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
    renderLayout(
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
    renderLayout(
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
    renderLayout(
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

const AUTH_HEADER_USER = 'x-user-id'
const AUTH_HEADER_ROLE = 'x-user-role'
const AUTH_HEADER_NAME = 'x-user-name'

type RequestUser = {
  id: string
  role: UserRole
  name?: string | null
}

const parseUserRole = (value?: string | null): UserRole => {
  const normalized = value?.toLowerCase() ?? ''
  if (normalized === 'super-admin' || normalized === 'super_admin' || normalized === 'owner' || normalized === 'root') {
    return 'super-admin'
  }
  if (normalized === 'operator' || normalized === 'admin' || normalized === 'moderator') {
    return 'operator'
  }
  return 'user'
}

const getOptionalUser = (c: Context): RequestUser | null => {
  const id = c.req.header(AUTH_HEADER_USER)?.trim()
  if (!id) {
    return null
  }
  return {
    id,
    role: parseUserRole(c.req.header(AUTH_HEADER_ROLE)),
    name: c.req.header(AUTH_HEADER_NAME) ?? null
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
  const limit = parseNumberParam(c.req.query('limit'), 50, { min: 1, max: 100 })
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
        viewer: viewer ? { id: viewer.id, role: viewer.role } : null,
        policy: result.policy,
        bestThreshold: result.policy.bestLikeThreshold,
        bestLimit: result.policy.bestLimit,
        reportBlindThreshold: result.policy.reportBlindThreshold
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

  const user = getOptionalUser(c)
  if (!user) {
    return c.json({ success: false, error: 'authentication required' }, 401)
  }

  const slug = slugRaw.trim()
  const ipAddress = c.req.header('cf-connecting-ip') ?? null
  const ipHash = await hashIpAddress(ipAddress)

  if (await isIpBlocked(c.env.DB, ipHash)) {
    return c.json({ success: false, error: 'commenting temporarily restricted' }, 403)
  }

  const anonymousRequested = Boolean(body?.anonymous)
  const nicknameRaw = typeof body?.nickname === 'string' ? body.nickname : null
  const nickname = anonymousRequested ? null : nicknameRaw ?? user.name ?? null
  const displayIp = anonymousRequested ? maskIpForDisplay(ipAddress) : null

  try {
    const comment = await createComment(c.env.DB, {
      slug: buildCommentPageSlug(entityType, slug),
      pageType: entityType,
      title: title || slug,
      summary,
      content: contentRaw,
      nickname,
      parentId,
      authorId: user.id,
      isAnonymous: anonymousRequested,
      ipHash,
      displayIp
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
  const limit = parseNumberParam(c.req.query('limit'), 20, { min: 1, max: 100 })

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
  const limit = parseNumberParam(c.req.query('limit'), 20, { min: 1, max: 100 })
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
      perPage: toIntegerOrNull(body.perPage, { min: 1, max: 100 }),
      results: toIntegerOrNull(body.results, { min: 0, max: 1000 }),
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
    const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 100 })
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
    const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 100 })
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

// 직업 카테고리 목록 API
app.get('/api/categories', async (c) => {
  return c.json({
    success: true,
    jobCategories: JOB_CATEGORIES,
    aptitudeTypes: APTITUDE_TYPES
  })
})

// Admin API: Seed all jobs to D1
app.post('/api/admin/seed-jobs', async (c) => {
  // 보안: Admin 토큰 확인
  const token = c.req.header('Authorization')
  const expectedToken = c.env.ADMIN_SECRET || 'dev-admin-token'
  
  if (token !== `Bearer ${expectedToken}`) {
    return c.json({ error: 'Unauthorized' }, 401)
  }
  
  try {
    // seedAllJobs를 동적 import
    const { seedAllJobs } = await import('./scripts/seedAllJobs')
    
    // 백그라운드로 실행
    const seedPromise = seedAllJobs(c.env).catch(err => {
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
      estimatedTime: 'Test mode',
      note: 'Check console logs'
    })
  } catch (error: any) {
    console.error('❌ Seed start failed:', error)
    return c.json({ 
      error: 'Failed to start seed',
      details: error.message 
    }, 500)
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
