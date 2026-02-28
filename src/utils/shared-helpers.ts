import type { Context } from 'hono'
import type { AppEnv, Bindings, Variables, RequestUser } from '../types/app'
import type { DataSource } from '../types/unifiedProfiles'
import type { AnalysisType, PricingTier, RequestStatus } from '../types/aiAnalysis'
import type { PageType, UserRole } from '../services/commentService'
import { renderNav, renderNavStyles, renderNavScripts } from '../templates/partials/nav'

// Dev-only helpers (instrumentation, safety)
export const isDevEnv = (env?: any) => {
  const flag = env?.ENVIRONMENT || process?.env?.ENVIRONMENT || process?.env?.NODE_ENV
  return !flag || ['dev', 'development', 'local'].includes(String(flag).toLowerCase())
}

// Phase 3 Day 4: 사용자 정보에 따른 헤더 UI 생성 함수
export const renderUserMenu = (
  user: { id: number; name: string | null; email: string; role: string; picture_url: string | null; custom_picture_url?: string | null; username: string | null } | null,
  _ipAddress: string | null = null
) => {
  // 프로필 이미지 우선순위: custom > OAuth > 기본 아이콘
  const profileImageUrl = user ? (user.custom_picture_url || user.picture_url) : null

  // 프로필 이미지 URL이 상대 경로인 경우 절대 경로로 변환
  const getAbsoluteImageUrl = (url: string | null): string | null => {
    if (!url) return null
    if (url.startsWith('http://') || url.startsWith('https://')) return url
    if (url.startsWith('/')) return url
    return `/${url}`
  }

  const absoluteImageUrl = profileImageUrl ? getAbsoluteImageUrl(profileImageUrl) : null

  // 프로필 이미지 또는 기본 아이콘 렌더링 (버튼용 - 24x24 고정)
  const userIconHtml = absoluteImageUrl
    ? `<img src="${absoluteImageUrl}" alt="${user?.name || 'User'}" class="rounded-full object-cover" style="width: 24px; height: 24px;" />`
    : user
      ? `<div class="rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center text-white font-bold" style="width: 24px; height: 24px; font-size: 12px;">${(user.username || user.name || 'U').charAt(0).toUpperCase()}</div>`
      : `<i class="fas fa-user-circle" style="font-size: 16px;"></i>`

  // 유저 아이콘 버튼 + 빈 드롭다운 (내용은 클라이언트에서 nav.ts가 렌더링)
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
        <!-- 드롭다운 내용은 클라이언트에서 nav.ts의 hydrateUserMenu()가 렌더링 -->
        <div class="px-4 py-3 text-center text-wiki-muted text-sm">
          <i class="fas fa-spinner fa-spin mr-2"></i>로딩 중...
        </div>
      </div>
    </div>
  `

  return menuHtml
}


// Helper function for logo image (PNG 파일 사용)
export const getLogoImage = (size: 'large' | 'small' = 'large') => {
  const isLarge = size === 'large'
  const src = isLarge ? '/images/CWmainlogo.png' : '/images/CWheaderlogo.png'
  const width = isLarge ? 360 : 180
  const height = isLarge ? 90 : 40

  return `<img src="${src}" alt="Careerwiki" width="${width}" height="${height}" class="logo-image" style="object-fit: contain;" />`
}

// Legacy alias for backward compatibility
export const getLogoSVG = getLogoImage

export const isAdminRole = (role?: string | null) =>
  role === 'admin' || role === 'super-admin' || role === 'operator'

// Helper function to render layout
export const renderLayout = (
  content: string,
  title = 'Careerwiki - AI 진로 분석 플랫폼',
  description = 'AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 플랫폼',
  isHomepage = false,
  options?: {
    extraHead?: string
    canonical?: string
    ogUrl?: string
    ogImage?: string
    ogImageWidth?: string
    ogImageHeight?: string
    ogType?: string
    robots?: string
    user?: { id: number; name: string | null; email: string; role: string; picture_url: string | null; custom_picture_url?: string | null; username: string | null } | null
    context?: Context<{ Bindings: Bindings; Variables: Variables }>  // Phase 3 Day 4: Context를 통해 사용자 정보 자동 가져오기
    ipAddress?: string | null  // Phase 3 Day 4: IP 주소 (비로그인 상태에서 표시)
  }
) => {
  const canonicalUrl = options?.canonical ?? 'https://careerwiki.org'
  const ogUrl = options?.ogUrl ?? canonicalUrl
  const extraHead = options?.extraHead ?? ''
  const ogImage = (options?.ogImage && options.ogImage.trim()) || 'https://careerwiki.org/images/og-default.png'
  const ogImageWidth = options?.ogImageWidth ?? '1200'
  const ogImageHeight = options?.ogImageHeight ?? '630'
  const ogType = options?.ogType ?? 'website'
  const robots = options?.robots ?? 'index, follow'
  const googleVerification = options?.context?.env?.GOOGLE_SITE_VERIFICATION ?? ''

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
        <meta property="og:type" content="${ogType}">
        <meta property="og:url" content="${ogUrl}">
        <meta property="og:image" content="${ogImage}">
        <meta property="og:image:width" content="${ogImageWidth}">
        <meta property="og:image:height" content="${ogImageHeight}">
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="${title}">
        <meta name="twitter:description" content="${description}">
        <meta name="twitter:image" content="${ogImage}">
        <meta property="og:site_name" content="Careerwiki">
        <meta name="robots" content="${robots}">
        ${googleVerification ? `<meta name="google-site-verification" content="${googleVerification}">` : ''}
        <link rel="canonical" href="${canonicalUrl}">
        <link rel="icon" type="image/png" href="/images/CWfavicon.png">
        <link href="/static/style.css" rel="stylesheet" />
        <link rel="stylesheet" href="/static/tailwind.css">
        <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/css/all.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/lucide@0.474.0/dist/umd/lucide.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
        <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.4/kakao.min.js" crossorigin="anonymous"></script>
        <script>if(window.Kakao&&!Kakao.isInitialized())Kakao.init('79ec886101c6ef4987616900d70beb73');</script>
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
        <!-- Google Analytics 4 -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-H9R83SJRRY"></script>
        <script>
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag('js', new Date());
          gtag('config', 'G-H9R83SJRRY');
        </script>
        <!-- Google AdSense -->
        <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-9810002715600854" crossorigin="anonymous"></script>
        ${extraHead}
        <style>
          body { background-color: #0b1220; color: #dee3ff; }

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

          /* ============================================
           * AI Analyzer Professional UI Styles
           * ============================================ */

          /* 비활성화 스트라이프 패턴 */
          .bg-stripes {
            background: repeating-linear-gradient(
              -45deg,
              transparent,
              transparent 4px,
              rgba(156, 163, 175, 0.15) 4px,
              rgba(156, 163, 175, 0.15) 8px
            );
          }

          /* 선택 카드 애니메이션 */
          .role-card {
            will-change: transform, box-shadow;
          }
          .role-card::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, transparent 0%, rgba(67, 97, 238, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
          }
          .role-card:hover::before {
            opacity: 1;
          }

          /* 제약 카드 펼침 애니메이션 */
          .constraint-card {
            will-change: height;
          }
          .constraint-detail {
            animation: slideDown 0.3s ease-out;
          }
          @keyframes slideDown {
            from {
              opacity: 0;
              transform: translateY(-10px);
            }
            to {
              opacity: 1;
              transform: translateY(0);
            }
          }

          /* 레벨 바 채움 애니메이션 */
          .skill-btn .w-3.h-6 {
            transition: background-color 0.3s ease, transform 0.2s ease;
          }
          .skill-btn:hover .w-3.h-6:not(.bg-gray-200) {
            transform: scaleY(1.1);
          }

          /* 목표 칩 선택 효과 */
          .goal-chip {
            will-change: transform, background;
          }
          .goal-chip:not(:disabled):active {
            transform: scale(0.98);
          }

          /* 제약조건 세부 태그 스타일 */
          .detail-tag {
            background-color: rgba(26,26,46,0.5);
            border-color: rgba(42,42,62,0.5);
            color: rgb(148,163,184);
            transition: all 0.15s ease;
          }
          .detail-tag:hover:not(.selected) {
            /* hover 스타일: 선택 스타일보다 연하게 (구분 가능하도록) */
            background-color: rgba(100,116,139,0.15);
            border-color: rgba(100,116,139,0.4);
            color: rgb(200,210,220);
          }
          .detail-tag.selected {
            background-color: rgba(245,158,11,0.2) !important;
            border-color: rgba(245,158,11,0.5) !important;
            color: #f59e0b !important;
          }

          /* 툴팁 arrow */
          .tooltip-content::after {
            content: '';
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            border-width: 6px;
            border-style: solid;
            border-color: #1f2937 transparent transparent transparent;
          }

          /* 비활성화 요소 호버 시 툴팁 */
          .disabled-tooltip {
            white-space: nowrap;
          }

          /* 전이 신호 카드 스타일 */
          .transition-card {
            background: linear-gradient(135deg, rgba(26, 26, 46, 0.9) 0%, rgba(26, 26, 46, 0.7) 100%);
            border: 1px solid rgba(67, 97, 238, 0.2);
            transition: all 0.3s ease;
          }
          .transition-card:hover {
            border-color: rgba(67, 97, 238, 0.4);
            box-shadow: 0 4px 20px rgba(67, 97, 238, 0.15);
          }

          /* 진행 표시 도트 */
          .progress-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: rgba(156, 163, 175, 0.3);
            transition: all 0.3s ease;
          }
          .progress-dot.active {
            background: #4361ee;
            box-shadow: 0 0 8px rgba(67, 97, 238, 0.5);
          }
          .progress-dot.completed {
            background: #34d399;
          }

          /* 제약 태그 선택 효과 */
          .detail-tag.selected,
          .detail-tag:focus {
            background: #fef3c7 !important;
            border-color: #f59e0b !important;
            color: #92400e !important;
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
          /* 유저 아이콘 크기는 nav.ts renderNavStyles()에서 통합 관리 */
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
        <main class="${isHomepage ? '' : 'mx-auto pt-20 sm:pt-12'}">
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
                        <a href="/analyzer" class="footer-nav-link">AI 추천</a>
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
                    <span class="text-wiki-text font-semibold" style="font-size: 15px;">© 2026 Careerwiki</span>
                </div>

                <!-- Desktop: Original horizontal layout -->
                <div class="hidden md:flex items-center justify-between gap-8">
                    <!-- Logo -->
                    <a href="/" class="shrink-0 opacity-80 hover:opacity-100 transition-opacity">
                        ${getLogoSVG('small')}
                    </a>

                    <!-- Navigation Links - Horizontal -->
                    <nav class="flex flex-wrap items-center gap-4">
                        <a href="/analyzer" class="footer-nav-link">AI 추천</a>
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
                        <span class="text-wiki-text font-semibold" style="font-size: 15px;">© 2026 Careerwiki</span>
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
                  window.location.href = '/login?redirect=' + encodeURIComponent(currentPath);
                  return;
                }

                if (data.success) {
                  // saved가 true면 +1, false면 -1
                  const countDelta = data.saved ? 1 : -1;
                  markAsSaved(btn, data.saved, countDelta);
                }
              } catch (e) {
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

    <!-- 글로벌 공유 모달 -->
    <div id="share-modal-overlay" class="fixed inset-0 bg-black/50 z-[9998] hidden transition-opacity" data-share-modal-close></div>
    <div id="share-modal-global" class="fixed z-[9999] hidden left-0 right-0 bottom-0 rounded-t-2xl md:left-1/2 md:right-auto md:bottom-auto md:top-1/2 md:-translate-x-1/2 md:-translate-y-1/2 md:rounded-2xl md:w-[420px] bg-wiki-bg border border-wiki-border/60 shadow-2xl">
      <div class="md:hidden w-10 h-1 bg-wiki-border/60 rounded-full mx-auto mt-3"></div>
      <div class="flex items-center justify-between px-5 py-4">
        <h3 class="text-lg font-bold text-white">공유</h3>
        <button type="button" data-share-modal-close class="text-wiki-muted hover:text-white transition"><i class="fas fa-times text-lg"></i></button>
      </div>
      <div id="share-modal-thumbnail" class="hidden px-5 pb-3">
        <div class="flex items-center gap-3 p-3 rounded-xl bg-wiki-card/50 border border-wiki-border/30">
          <div class="shrink-0 w-16 h-16 md:w-24 md:h-[62px] rounded-lg overflow-hidden border border-wiki-border/40 bg-wiki-card">
            <img id="share-modal-og-img" src="" alt="" class="w-full h-full object-cover">
          </div>
          <div class="min-w-0 flex-1">
            <p id="share-modal-og-title" class="text-sm font-medium text-white line-clamp-2"></p>
            <p class="text-xs text-wiki-muted mt-0.5">careerwiki.org</p>
          </div>
        </div>
      </div>
      <div class="flex justify-center gap-5 px-5 py-4">
        <button type="button" data-share-kakao class="flex flex-col items-center gap-1.5 group">
          <div class="w-12 h-12 rounded-full bg-[#FEE500] flex items-center justify-center group-hover:scale-105 transition-transform">
            <img src="/images/kakao-icon.svg" class="w-6 h-6" alt="카카오톡">
          </div>
          <span class="text-xs text-wiki-muted">카카오톡</span>
        </button>
        <button type="button" data-share-x class="flex flex-col items-center gap-1.5 group">
          <div class="w-12 h-12 rounded-full bg-black border border-wiki-border/60 flex items-center justify-center group-hover:scale-105 transition-transform">
            <i class="fab fa-x-twitter text-white text-lg"></i>
          </div>
          <span class="text-xs text-wiki-muted">X</span>
        </button>
        <button type="button" data-share-facebook class="flex flex-col items-center gap-1.5 group">
          <div class="w-12 h-12 rounded-full bg-[#1877F2] flex items-center justify-center group-hover:scale-105 transition-transform">
            <i class="fab fa-facebook-f text-white text-lg"></i>
          </div>
          <span class="text-xs text-wiki-muted">Facebook</span>
        </button>
        <button type="button" data-share-linkedin class="flex flex-col items-center gap-1.5 group">
          <div class="w-12 h-12 rounded-full bg-[#0A66C2] flex items-center justify-center group-hover:scale-105 transition-transform">
            <i class="fab fa-linkedin-in text-white text-lg"></i>
          </div>
          <span class="text-xs text-wiki-muted">LinkedIn</span>
        </button>
        <button type="button" data-share-native class="flex flex-col items-center gap-1.5 md:hidden group">
          <div class="w-12 h-12 rounded-full bg-wiki-card border border-wiki-border/60 flex items-center justify-center group-hover:scale-105 transition-transform">
            <i class="fas fa-ellipsis-h text-white text-lg"></i>
          </div>
          <span class="text-xs text-wiki-muted">더보기</span>
        </button>
      </div>
      <div class="px-5 pb-5">
        <div class="flex items-center gap-2 bg-wiki-card border border-wiki-border/60 rounded-lg px-3 py-2.5">
          <input id="share-modal-url" type="text" readonly class="flex-1 bg-transparent text-sm text-white outline-none min-w-0 truncate">
          <button type="button" data-share-modal-copy class="px-3 py-1.5 bg-wiki-primary text-white text-sm rounded-md hover:bg-blue-600 transition shrink-0">복사</button>
        </div>
      </div>
    </div>

    </body>
    </html>
  `
}

export const SOURCE_LABEL_MAP: Record<DataSource, string> = {
  CAREERNET: '커리어넷',
  GOYONG24: '고용24',
  WORK24_JOB: '고용24 직업정보',
  WORK24_DJOB: '고용24 직업사전',
  WORK24_MAJOR: '고용24 학과정보',
  AI: 'AI 생성',
  USER_CONTRIBUTED: '사용자 기여',
  ADMIN_OVERRIDE: '관리자'
}

export const DEFAULT_CANONICAL_ORIGIN = 'https://careerwiki.org'

export const buildCanonicalUrl = (requestUrl: string, path: string): string => {
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

export const isAnalysisType = (value: unknown): value is AnalysisType => value === 'job' || value === 'major'
export const isPricingTier = (value: unknown): value is PricingTier => value === 'free' || value === 'pro'
export const isRequestStatus = (value: unknown): value is RequestStatus =>
  value === 'pending' || value === 'processing' || value === 'completed' || value === 'failed'
export const isPageType = (value: unknown): value is PageType => value === 'job' || value === 'major' || value === 'guide'
// guide 타입은 pages 테이블에 prefix 없이 저장되므로 prefix 붙이지 않음
export const buildCommentPageSlug = (type: PageType, slug: string): string => {
  const trimmedSlug = slug.trim()
  // guide(HowTo)는 실제 페이지가 prefix 없이 저장되므로 그대로 사용
  if (type === 'guide') return trimmedSlug
  return `${type}:${trimmedSlug}`
}
// slug에서 guide: prefix를 제거하는 헬퍼 함수
export const cleanGuidePrefix = (slug: string): string => slug ? slug.replace(/^(guide:)+/g, '') : ''
export const toParentId = (value: unknown): number | null => {
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
export const getClientIp = (c: Context): string => {
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

// Phase 3 Day 4: renderLayout 헬퍼 함수 (자동으로 context 전달)
export const renderLayoutWithContext = (
  c: Context,
  content: string,
  title?: string,
  description?: string,
  isHomepage?: boolean,
  options?: {
    extraHead?: string
    canonical?: string
    ogUrl?: string
    ogImage?: string
    ogImageWidth?: string
    ogImageHeight?: string
    ogType?: string
    robots?: string
    user?: { id: number; name: string | null; email: string; role: string; picture_url: string | null; custom_picture_url?: string | null; username: string | null } | null
  }
) => {
  return renderLayout(content, title, description, isHomepage, { ...options, context: c })
}

export const parseSourcesQuery = (value?: string | null): DataSource[] | undefined => {
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

export const parseNumberParam = (
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

export const toIntegerOrNull = (
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
export const formatEmploymentRate = (rate: string | undefined): string | undefined => {
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

export const escapeHtml = (value: string): string =>
  value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')

// 안전한 날짜 포맷팅 함수 (Unix timestamp 초 단위 또는 DATETIME 문자열 모두 처리)
export const formatDateSafe = (dateValue: string | number | null | undefined): string => {
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

export const serializeForScript = (value: unknown): string =>
  JSON.stringify(value)
    .replace(/</g, '\\u003C')
    .replace(/>/g, '\\u003E')
    .replace(/&/g, '\\u0026')

export const createMetaDescription = (...candidates: Array<string | undefined | null>): string => {
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

/**
 * Phase 3 Day 3: 새로운 역할 시스템을 기존 댓글 시스템 역할로 매핑
 *
 * 기존: 'super-admin' | 'operator' | 'user'
 * 신규: 'anonymous' | 'user' | 'expert' | 'admin'
 */
export const mapRoleForComments = (newRole: string | null | undefined): UserRole => {
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
export const getOptionalUser = (c: Context<{ Bindings: Bindings; Variables: Variables }>): RequestUser | null => {
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

export const maskIpForDisplay = (ip: string | null | undefined): string | null => {
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

export const toHex = (buffer: ArrayBuffer): string => {
  const bytes = new Uint8Array(buffer)
  return Array.from(bytes)
    .map((byte) => byte.toString(16).padStart(2, '0'))
    .join('')
}

export const hashIpAddress = async (ip: string | null | undefined): Promise<string | null> => {
  if (!ip) return null
  const encoder = new TextEncoder()
  const digest = await crypto.subtle.digest('SHA-256', encoder.encode(ip))
  return toHex(digest)
}
