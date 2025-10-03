import { Hono } from 'hono'
import { cors } from 'hono/cors'
import { serveStatic } from 'hono/cloudflare-workers'
import { renderer } from './renderer'
import { JOB_CATEGORIES, APTITUDE_TYPES } from './api/careernetAPI'
import { getUnifiedJobDetail, getUnifiedMajorDetail, searchUnifiedJobs, searchUnifiedMajors } from './services/profileDataService'
import type { SourceStatusRecord } from './services/profileDataService'
import type { DataSource } from './types/unifiedProfiles'
import { renderUnifiedJobDetail, createJobJsonLd } from './templates/unifiedJobDetail'
import { renderUnifiedMajorDetail, createMajorJsonLd } from './templates/unifiedMajorDetail'

// Types
type Bindings = {
  DB: D1Database;
  KV: KVNamespace;
  CAREER_NET_API_KEY?: string; // Cloudflare 환경 변수
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

// Helper function for logo SVG (옵션 7: 플레이풀 둥근 폰트)
const getLogoSVG = (size: 'large' | 'small' = 'large') => {
  const fontSize = size === 'large' ? '56' : '28';
  const width = size === 'large' ? '360' : '180';
  const height = size === 'large' ? '90' : '40';
  const baselineOffset = size === 'large' ? 14 : 10;
  
  return `
    <svg width="${width}" height="${height}" viewBox="0 0 ${width} ${height}">
      <defs>
        <linearGradient id="logoGrad" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" style="stop-color:#4361ee;stop-opacity:1" />
          <stop offset="100%" style="stop-color:#64b5f6;stop-opacity:1" />
        </linearGradient>
      </defs>
      <text x="${parseInt(width)/2}" y="${parseInt(height)/2 + baselineOffset}" 
            font-family="'Comic Sans MS', 'Chalkboard SE', 'Marker Felt', cursive" 
            font-size="${fontSize}" font-weight="bold" 
            fill="url(#logoGrad)" text-anchor="middle">Careerwiki</text>
    </svg>
  `;
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
        ${extraHead}
        <style>
          body { background: #0f0f23; color: #e0e0e0; }
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
            padding: 24px 20px 0;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 12px;
          }
          .header-icon-button {
            width: 42px;
            height: 42px;
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
            padding: 6px 12px 6px 16px;
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
            font-size: 14px;
            line-height: 1.4;
          }
          .nav-search-input::placeholder {
            color: #7f88a8;
          }
          .nav-search-input:focus {
            outline: none;
          }
          .nav-search-button {
            width: 36px;
            height: 36px;
            border-radius: 9999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
            background: linear-gradient(135deg, #4361ee 0%, #64b5f6 100%);
            color: #ffffff;
            font-size: 15px;
            box-shadow: 0 8px 18px rgba(67, 97, 238, 0.25);
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
            gap: 10px;
            padding: 8px 18px;
            border-radius: 9999px;
            font-size: 0.9rem;
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
            font-size: 1rem;
          }
          .nav-link-mobile {
            display: flex;
            width: 100%;
            justify-content: center;
            padding: 10px 18px;
            background: rgba(26, 26, 46, 0.65);
            border-radius: 12px;
            border: 1px solid rgba(100, 181, 246, 0.25);
          }
          .nav-link-mobile:not(:last-child) {
            margin-bottom: 6px;
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
              padding: 32px 24px 0;
            }
            .hero-shell {
              padding-top: 80px;
              padding-bottom: 60px;
            }
          }
        </style>
    </head>
    <body class="bg-wiki-bg text-wiki-text min-h-screen">
        ${!isHomepage ? `
        <!-- Navigation (Not on homepage) -->
        <nav class="glass-card sticky top-0 z-50 border-b border-wiki-border">
            <div class="container mx-auto px-4 py-4">
                <div class="flex items-center gap-4">
                    <a href="/" class="shrink-0 hidden md:flex items-center">
                        ${getLogoSVG('small')}
                    </a>

                    <div class="hidden md:flex flex-1 max-w-2xl">
                        <form action="/search" method="get" class="nav-search-shell">
                            <div class="nav-search-bar">
                                <input type="text" name="q" 
                                       placeholder="직업, 전공, 진로를 검색하세요..." 
                                       class="nav-search-input">
                                <button type="submit" class="nav-search-button" aria-label="검색">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>

                    <div class="hidden md:flex items-center gap-4">
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

                    <button id="mobile-menu-btn" class="md:hidden text-wiki-text">
                        <i class="fas fa-bars text-xl"></i>
                    </button>
                </div>

                <div class="md:hidden mt-4">
                    <form action="/search" method="get" class="nav-search-shell">
                        <div class="nav-search-bar">
                            <input type="text" name="q" 
                                   placeholder="검색어를 입력하세요..." 
                                   class="nav-search-input">
                            <button type="submit" class="nav-search-button" aria-label="검색">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </nav>
        
        <!-- Mobile Menu -->
        <div id="mobile-menu" class="hidden md:hidden glass-card border-b border-wiki-border">
            <div class="container mx-auto px-4 py-4 space-y-3">
                <a href="/analyzer" class="nav-link nav-link-mobile">
                    <i class="fas fa-brain mr-2"></i>AI 분석
                </a>
                <a href="/howto" class="nav-link nav-link-mobile">
                    <i class="fas fa-route mr-2"></i>HowTo
                </a>
                <div class="mobile-menu-divider flex items-center gap-3">
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
        <main class="${isHomepage ? '' : 'container mx-auto px-4 py-8'}">
            ${content}
        </main>
        
        <!-- Footer - Minimal & Trendy -->
        <footer class="border-t border-wiki-border mt-16">
            <div class="container mx-auto px-4 py-6">
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
            // Mobile menu toggle
            const menuBtn = document.getElementById('mobile-menu-btn');
            if(menuBtn) {
                menuBtn.addEventListener('click', () => {
                    document.getElementById('mobile-menu').classList.toggle('hidden');
                });
            }
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

// Job Wiki List Page
app.get('/job', async (c) => {
  const keywordRaw = c.req.query('q') || ''
  const categoryRaw = c.req.query('category') || ''
  const keyword = keywordRaw.trim()
  const category = categoryRaw.trim()
  const includeSources = parseSourcesQuery(c.req.query('sources'))
  const page = parseNumberParam(c.req.query('page'), 1)
  const perPage = parseNumberParam(c.req.query('perPage'), 20)

  const categoryOptions = Object.entries(JOB_CATEGORIES)
    .map(([label, code]) => {
      const escapedCode = escapeHtml(code)
      const isSelected = code === category
      return `<option value="${escapedCode}" ${isSelected ? 'selected' : ''}>${escapeHtml(label)}</option>`
    })
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
    const result = await searchUnifiedJobs(
      {
        keyword,
        category,
        page,
        perPage,
        includeSources
      },
      c.env
    )

    const items = result.items
    const totalCount = typeof result.meta?.total === 'number' ? result.meta.total : items.length

    const jobCards = items.length
      ? items
          .map((entry) => {
            const job = entry.profile
            const display = entry.display ?? {}
            const jobUrl = `/job/${encodeURIComponent(job.id)}`
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
      : `
        <div class="glass-card p-12 rounded-2xl text-center">
          <i class="fas fa-circle-info text-4xl text-wiki-secondary mb-4"></i>
          <h2 class="text-2xl font-semibold text-white mb-2">검색 결과가 없습니다</h2>
          <p class="text-sm text-wiki-muted">검색어 또는 필터를 변경하여 다시 시도해 주세요. CareerWiki는 매일 새로운 직업 데이터를 수집하고 있습니다.</p>
        </div>
      `

    const sourceSummary = renderSourceStatusSummary(result.meta?.sources)
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

    const jsonLdItems = items.map((entry, index) => ({
      '@type': 'ListItem',
      position: (page - 1) * perPage + index + 1,
      url: buildCanonicalUrl(c.req.url, `/job/${encodeURIComponent(entry.profile.id)}`),
      name: entry.profile.name
    }))
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

    const content = `
      <div class="max-w-6xl mx-auto">
        <div class="text-center mb-10">
          <h1 class="text-4xl font-bold mb-4 gradient-text">
            <i class="fas fa-briefcase mr-3"></i>${headingLabel}
          </h1>
          <p class="text-wiki-muted max-w-3xl mx-auto">
            고용24와 커리어넷의 최신 데이터를 바탕으로 직업별 연봉, 전망, 필요 역량을 탐색하세요.
          </p>
          <p class="text-xs text-wiki-muted mt-4">${filterSummary} · 총 ${totalCount}건</p>
        </div>

        <form method="get" class="glass-card rounded-xl p-6 mb-10 grid md:grid-cols-[2fr,1fr,auto] gap-4 items-end">
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
          <div class="flex gap-2">
            <button type="submit" class="px-6 py-3 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-semibold rounded-lg hover-glow transition">
              <i class="fas fa-search mr-2"></i>검색
            </button>
            <a href="/job" class="px-6 py-3 bg-wiki-bg border border-wiki-border text-wiki-muted font-semibold rounded-lg hover:border-wiki-primary transition">초기화</a>
          </div>
        </form>

        <section class="space-y-4" aria-live="polite">
          ${jobCards}
        </section>

        ${sourceSummary}
      </div>
    `

    const pageTitle = keyword ? `${keyword} 직업 검색 결과 - Careerwiki` : '직업위키 - Careerwiki'
    const description = createMetaDescription(
      keyword ? `${keyword} 관련 직업 정보를 확인하세요.` : undefined,
      items[0]?.display?.summary,
      '직업 연봉과 전망, 필요 역량을 한눈에 확인하세요.'
    )

    return c.html(
      renderLayout(
        content,
        escapeHtml(pageTitle),
        escapeHtml(description),
        false,
        {
          canonical: canonicalUrl,
          ogUrl: canonicalUrl,
          extraHead: jsonLd
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
  const page = parseNumberParam(c.req.query('page'), 1)
  const perPage = parseNumberParam(c.req.query('perPage'), 20)

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
    const result = await searchUnifiedMajors(
      {
        keyword,
        page,
        perPage,
        includeSources
      },
      c.env
    )

    const items = result.items
    const totalCount = typeof result.meta?.total === 'number' ? result.meta.total : items.length

    const majorCards = items.length
      ? items
          .map((entry) => {
            const major = entry.profile
            const display = entry.display ?? {}
            const majorUrl = `/major/${encodeURIComponent(major.id)}`
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
      : `
        <div class="glass-card p-12 rounded-2xl text-center">
          <i class="fas fa-circle-info text-4xl text-wiki-secondary mb-4"></i>
          <h2 class="text-2xl font-semibold text-white mb-2">검색 결과가 없습니다</h2>
          <p class="text-sm text-wiki-muted">검색어를 변경하여 다시 시도해 주세요. CareerWiki는 지속적으로 새로운 전공 데이터를 수집하고 있습니다.</p>
        </div>
      `

    const sourceSummary = renderSourceStatusSummary(result.meta?.sources)
    const filterSummary = keyword ? `"${escapeHtml(keyword)}" 키워드` : '전체 전공'
    const headingLabel = keyword ? `“${escapeHtml(keyword)}” 관련 전공` : '전공위키'

    const jsonLdItems = items.map((entry, index) => ({
      '@type': 'ListItem',
      position: (page - 1) * perPage + index + 1,
      url: buildCanonicalUrl(c.req.url, `/major/${encodeURIComponent(entry.profile.id)}`),
      name: entry.profile.name
    }))
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

    const content = `
      <div class="max-w-6xl mx-auto">
        <div class="text-center mb-10">
          <h1 class="text-4xl font-bold mb-4 gradient-text">
            <i class="fas fa-university mr-3"></i>${headingLabel}
          </h1>
          <p class="text-wiki-muted max-w-3xl mx-auto">
            전공 커리큘럼, 개설 대학, 관련 직업 정보를 통합 데이터로 제공합니다.
          </p>
          <p class="text-xs text-wiki-muted mt-4">${filterSummary} · 총 ${totalCount}건</p>
        </div>

        <form method="get" class="glass-card rounded-xl p-6 mb-10 grid md:grid-cols-[2fr,auto] gap-4 items-end">
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
          <div class="flex gap-2">
            <button type="submit" class="px-6 py-3 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-semibold rounded-lg hover-glow transition">
              <i class="fas fa-search mr-2"></i>검색
            </button>
            <a href="/major" class="px-6 py-3 bg-wiki-bg border border-wiki-border text-wiki-muted font-semibold rounded-lg hover:border-wiki-primary transition">초기화</a>
          </div>
        </form>

        <section class="space-y-4" aria-live="polite">
          ${majorCards}
        </section>

        ${sourceSummary}
      </div>
    `

    const pageTitle = keyword ? `${keyword} 전공 검색 결과 - Careerwiki` : '전공위키 - Careerwiki'
    const description = createMetaDescription(
      keyword ? `${keyword} 관련 전공 정보를 확인하세요.` : undefined,
      items[0]?.display?.summary,
      items[0]?.display?.employmentRate,
      '전공별 커리큘럼과 진로 정보를 통합 데이터로 확인하세요.'
    )

    return c.html(
      renderLayout(
        content,
        escapeHtml(pageTitle),
        escapeHtml(description),
        false,
        {
          canonical: canonicalUrl,
          ogUrl: canonicalUrl,
          extraHead: jsonLd
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

// HowTo Page
app.get('/howto', (c) => {
  const content = `
    <div class="max-w-6xl mx-auto">
        <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
            <i class="fas fa-route mr-3"></i>HowTo 시리즈
        </h1>
        

        <div class="grid md:grid-cols-2 gap-6">
            <a href="/howto/law-school" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">로스쿨 들어가는 법</h3>
                <p class="text-sm text-wiki-muted">법학전문대학원 입학 준비부터 합격까지의 완벽 가이드</p>
                <div class="flex gap-2 mt-3">
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">법학</span>
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">대학원</span>
                </div>
            </a>
            <a href="/howto/cpa" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">회계사 되는 법</h3>
                <p class="text-sm text-wiki-muted">공인회계사 시험 준비와 합격 전략</p>
                <div class="flex gap-2 mt-3">
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">회계</span>
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">자격증</span>
                </div>
            </a>
            <a href="/howto/chemical-engineer-career" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">화학공학 전공으로 취직하는 법</h3>
                <p class="text-sm text-wiki-muted">화공 전공자를 위한 진로 선택과 취업 전략</p>
                <div class="flex gap-2 mt-3">
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">화학공학</span>
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">취업</span>
                </div>
            </a>
            <a href="/howto/startup" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">스타트업 창업하는 법</h3>
                <p class="text-sm text-wiki-muted">아이디어부터 투자 유치까지 스타트업 창업 가이드</p>
                <div class="flex gap-2 mt-3">
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">창업</span>
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">비즈니스</span>
                </div>
            </a>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, 'HowTo 시리즈 - Careerwiki'))
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
  const normalizedQuery = query.toLowerCase()
  
  // Mock data with relevance scoring
  const jobs = [
    { id: 'software-engineer', title: '소프트웨어 엔지니어', desc: '소프트웨어를 설계, 개발, 테스트하는 전문가. 프로그래밍, 코딩, 알고리즘 활용', keywords: ['코딩', '프로그래밍', '개발', '소프트웨어', '엔지니어', '알고리즘', 'IT'] },
    { id: 'data-scientist', title: '데이터 사이언티스트', desc: '데이터 분석과 머신러닝으로 인사이트를 도출하는 전문가. 파이썬 코딩 활용', keywords: ['데이터', '분석', '머신러닝', 'AI', '통계', '코딩', '파이썬'] },
    { id: 'security-consultant', title: '보안 컨설턴트', desc: '시스템 보안 취약점 분석 및 해결. 보안 코딩과 침투 테스트 수행', keywords: ['보안', '해킹', '네트워크', '시스템', '코딩', '취약점'] },
    { id: 'frontend-engineer', title: '프론트엔드 엔지니어', desc: '웹 인터페이스 개발 전문가. HTML, CSS, JavaScript 코딩', keywords: ['프론트엔드', '웹', 'UI', 'UX', '코딩', '자바스크립트', '리액트'] },
    { id: 'chemical-engineer', title: '화학공학 엔지니어', desc: '화학 공정 설계와 최적화를 담당하는 전문가', keywords: ['화학', '공정', '제조', '플랜트', '엔지니어'] },
  ]
  
  const majors = [
    { id: 'computer-science', title: '컴퓨터공학과', desc: '컴퓨터 시스템과 소프트웨어 개발을 배우는 학과. 프로그래밍과 코딩이 핵심', keywords: ['컴퓨터', '프로그래밍', '코딩', '알고리즘', '소프트웨어', 'IT'] },
    { id: 'information-science', title: '정보과학과', desc: '정보 시스템과 데이터 처리를 다루는 학과. 코딩과 데이터베이스 학습', keywords: ['정보', '데이터', '시스템', '코딩', '데이터베이스'] },
    { id: 'design', title: '디자인학과', desc: '시각 디자인과 UX/UI 디자인을 배우는 학과. 웹 코딩 기초 포함', keywords: ['디자인', 'UI', 'UX', '그래픽', '웹디자인', '코딩'] },
    { id: 'chemical-engineering', title: '화학공학과', desc: '화학 원리를 산업에 응용하는 공학 분야', keywords: ['화학', '공학', '공정', '재료', '에너지'] },
    { id: 'electrical-engineering', title: '전기전자공학과', desc: '전기, 전자 시스템과 임베디드 시스템 개발. 펌웨어 코딩 포함', keywords: ['전기', '전자', '회로', '임베디드', '코딩', '펌웨어'] },
  ]
  
  const howtos = [
    { id: 'career-exploration', title: '진로 탐색 가이드', desc: 'IT 직업과 코딩 교육 포함한 진로 탐색 방법', keywords: ['진로', '탐색', '직업', '코딩', 'IT', '교육'] },
    { id: 'coding-bootcamp', title: '코딩 부트캠프 선택 가이드', desc: '코딩 부트캠프 비교와 선택 방법', keywords: ['코딩', '부트캠프', '교육', '프로그래밍', '취업'] },
    { id: 'interview-prep', title: '기술 면접 준비하기', desc: '코딩 테스트와 기술 면접 준비 전략', keywords: ['면접', '코딩', '테스트', '알고리즘', '기술'] },
  ]
  
  // Calculate relevance score
  const calculateScore = (item) => {
    let score = 0
    const itemText = (item.title + ' ' + item.desc + ' ' + item.keywords.join(' ')).toLowerCase()
    
    // Exact match in title
    if (item.title.toLowerCase().includes(normalizedQuery)) score += 10
    
    // Match in description
    if (item.desc.toLowerCase().includes(normalizedQuery)) score += 5
    
    // Match in keywords
    item.keywords.forEach(keyword => {
      if (keyword.toLowerCase().includes(normalizedQuery)) score += 3
      if (normalizedQuery.includes(keyword.toLowerCase())) score += 2
    })
    
    return score
  }
  
  // Filter and sort results
  const jobResults = jobs
    .map(job => ({ ...job, score: calculateScore(job) }))
    .filter(job => job.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 5)
  
  const majorResults = majors
    .map(major => ({ ...major, score: calculateScore(major) }))
    .filter(major => major.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 5)
  
  const howtoResults = howtos
    .map(howto => ({ ...howto, score: calculateScore(howto) }))
    .filter(howto => howto.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 3)
  
  const content = `
    <div class="max-w-4xl mx-auto">
        <!-- Search Bar with Query -->
        <div class="mb-8">
            <form action="/search" method="get" class="relative">
                <input 
                    type="text" 
                    name="q" 
                    value="${query}"
                    placeholder="검색어를 입력하세요" 
                    class="w-full px-6 py-4 bg-wiki-bg border border-wiki-border rounded-full text-lg focus:outline-none focus:border-wiki-primary transition"
                >
                <button type="submit" class="absolute right-2 top-1/2 -translate-y-1/2 px-6 py-2 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white rounded-full hover:scale-105 transition">
                    <i class="fas fa-search mr-2"></i>검색
                </button>
            </form>
        </div>
        
        ${jobResults.length > 0 ? `
        <!-- Job Results Section -->
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-primary mr-3"></span>
                직업위키
            </h2>
            <div class="space-y-3">
                ${jobResults.map(job => `
                    <a href="/job/${job.id}" class="glass-card p-4 rounded-lg hover-glow block transition">
                        <h3 class="text-lg font-semibold text-wiki-text">${job.title}</h3>
                        <p class="text-sm text-wiki-muted mt-1">${job.desc}</p>
                    </a>
                `).join('')}
            </div>
        </div>
        ` : ''}
        
        ${majorResults.length > 0 ? `
        <!-- Major Results Section -->
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-secondary mr-3"></span>
                전공위키
            </h2>
            <div class="space-y-3">
                ${majorResults.map(major => `
                    <a href="/major/${major.id}" class="glass-card p-4 rounded-lg hover-glow block transition">
                        <h3 class="text-lg font-semibold text-wiki-text">${major.title}</h3>
                        <p class="text-sm text-wiki-muted mt-1">${major.desc}</p>
                    </a>
                `).join('')}
            </div>
        </div>
        ` : ''}
        
        ${howtoResults.length > 0 ? `
        <!-- HowTo Results Section -->
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-green-500 mr-3"></span>
                HowTo
            </h2>
            <div class="space-y-3">
                ${howtoResults.map(howto => `
                    <a href="/howto/${howto.id}" class="glass-card p-4 rounded-lg hover-glow block transition">
                        <h3 class="text-lg font-semibold text-wiki-text">${howto.title}</h3>
                        <p class="text-sm text-wiki-muted mt-1">${howto.desc}</p>
                    </a>
                `).join('')}
            </div>
        </div>
        ` : ''}
        
        ${jobResults.length === 0 && majorResults.length === 0 && howtoResults.length === 0 ? `
        <div class="glass-card p-8 rounded-xl text-center">
            <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">"${query}"에 대한 검색 결과가 없습니다.</p>
            <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도해보세요.</p>
        </div>
        ` : ''}
    </div>
  `
  
  return c.html(renderLayout(content, `${query ? query + ' - ' : ''}검색 - Careerwiki`))
})

// Unified Job Detail Page (SSR)
app.get('/job/:slug', async (c) => {
  const slug = c.req.param('slug')
  const careernetId = c.req.query('careernetId') || undefined
  const goyongJobId = c.req.query('goyongJobId') || undefined
  const includeSources = parseSourcesQuery(c.req.query('sources'))

  try {
    const result = await getUnifiedJobDetail(
      {
        id: slug,
        careernetId,
        goyong24JobId: goyongJobId || undefined,
        includeSources
      },
      c.env
    )

    if (!result.profile) {
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
    const canonicalSlug = profile.id || slug
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
    console.error('Job detail route error:', error)
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
  const careernetId = c.req.query('careernetId') || undefined
  const majorGbParam = c.req.query('goyongMajorGb')
  const departmentId = c.req.query('goyongDepartmentId') || undefined
  const majorId = c.req.query('goyongMajorId') || undefined
  const includeSources = parseSourcesQuery(c.req.query('sources'))

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
        id: slug,
        careernetId,
        goyong24Params: goyongParams,
        includeSources
      },
      c.env
    )

    if (!result.profile) {
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
    const canonicalSlug = profile.id || slug
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

const parseNumberParam = (value: string | undefined, fallback: number): number => {
  if (!value) return fallback
  const parsed = Number(value)
  return Number.isFinite(parsed) && parsed > 0 ? parsed : fallback
}

const escapeHtml = (value: string): string =>
  value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')

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

const renderSourceStatusSummary = (sources?: SourceStatusRecord): string => {
  if (!sources) return ''
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
  if (!rows) return ''
  return `
    <div class="glass-card p-6 rounded-xl mt-8">
      <h2 class="text-lg font-semibold text-wiki-text mb-3">데이터 수집 상태</h2>
      <ul class="space-y-2">${rows}</ul>
    </div>
  `
}

// API 엔드포인트들

// 학과정보 검색 API
app.get('/api/majors', async (c) => {
  try {
    const keyword = c.req.query('keyword') || ''
    const page = parseNumberParam(c.req.query('page'), 1)
    const perPage = parseNumberParam(c.req.query('perPage'), 20)
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
    const page = parseNumberParam(c.req.query('page'), 1)
    const perPage = parseNumberParam(c.req.query('perPage'), 20)
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

export default app