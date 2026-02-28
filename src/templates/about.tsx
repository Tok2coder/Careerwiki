/**
 * About 페이지 — 서비스 소개 + 연락처
 */

import { renderNav, renderNavStyles, renderNavScripts } from './partials/nav'
import { renderFooter } from '../utils/shared-helpers'

type AboutPageOptions = {
  userMenuHtml?: string
}

export function renderAboutPage(options?: AboutPageOptions): string {
  const userMenuHtml = options?.userMenuHtml || ''

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>소개 | Careerwiki</title>
  <meta name="description" content="Careerwiki는 AI 기반 진로 탐색 플랫폼입니다. 직업위키, 전공위키, AI 추천, HowTo 가이드를 통해 데이터 기반 진로 정보를 제공합니다.">
  <link href="/static/style.css" rel="stylesheet" />
  <link rel="stylesheet" href="/static/tailwind.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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
  ${renderNavStyles()}
  <style>
    body { background-color: #0b1220; color: #dee3ff; }
    .glass-card { background: rgba(26, 26, 46, 0.8); border: 1px solid rgba(67, 97, 238, 0.2); backdrop-filter: blur(12px); }
  </style>
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}

  <main class="max-w-[1400px] mx-auto px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-8 space-y-3">
      <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
        <i class="fas fa-info-circle"></i><span>About Us</span>
      </div>
      <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <h1 class="text-3xl md:text-4xl font-bold text-white">Careerwiki 소개</h1>
        <p class="text-wiki-muted text-[15px]">AI 기반 진로 탐색 플랫폼</p>
      </div>
    </header>

    <div class="glass-card rounded-2xl p-4 sm:p-6 md:p-8">
      <div class="prose prose-invert prose-slate max-w-none space-y-8">

        <!-- 미션 -->
        <section>
          <h2 class="text-lg font-semibold text-white mb-3">우리의 미션</h2>
          <p class="text-slate-300 leading-relaxed">
            Careerwiki는 <strong class="text-white">데이터와 AI를 활용해 누구나 쉽게 진로를 탐색할 수 있는 플랫폼</strong>을 만듭니다.
            공공 데이터를 기반으로 정확한 직업·전공 정보를 제공하고, AI 기술을 통해 개인 맞춤형 진로 추천과 실용적인 커리어 가이드를 제공합니다.
          </p>
        </section>

        <!-- 제공 서비스 -->
        <section>
          <h2 class="text-lg font-semibold text-white mb-4">제공 서비스</h2>
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div class="rounded-xl p-4" style="background:rgba(167,139,250,0.08);border:1px solid rgba(167,139,250,0.2);">
              <div class="flex items-center gap-3 mb-2">
                <span class="w-9 h-9 rounded-lg flex items-center justify-center" style="background:rgba(167,139,250,0.2);"><i class="fas fa-briefcase text-sm" style="color:#a78bfa;"></i></span>
                <h3 class="text-base font-semibold text-white">직업위키</h3>
              </div>
              <p class="text-sm text-slate-300">연봉, 만족도, 워라벨, 전망 등 공공데이터 기반 직업 정보를 상세하게 제공합니다.</p>
            </div>
            <div class="rounded-xl p-4" style="background:rgba(96,165,250,0.08);border:1px solid rgba(96,165,250,0.2);">
              <div class="flex items-center gap-3 mb-2">
                <span class="w-9 h-9 rounded-lg flex items-center justify-center" style="background:rgba(96,165,250,0.2);"><i class="fas fa-graduation-cap text-sm" style="color:#60a5fa;"></i></span>
                <h3 class="text-base font-semibold text-white">전공위키</h3>
              </div>
              <p class="text-sm text-slate-300">취업률, 첫월급, 만족도, 관련 직업 등 전공별 상세 정보를 제공합니다.</p>
            </div>
            <div class="rounded-xl p-4" style="background:rgba(52,211,153,0.08);border:1px solid rgba(52,211,153,0.2);">
              <div class="flex items-center gap-3 mb-2">
                <span class="w-9 h-9 rounded-lg flex items-center justify-center" style="background:rgba(52,211,153,0.2);"><i class="fas fa-robot text-sm" style="color:#34d399;"></i></span>
                <h3 class="text-base font-semibold text-white">AI 진로 추천</h3>
              </div>
              <p class="text-sm text-slate-300">AI가 사용자의 관심사, 강점, 가치관을 분석하여 맞춤형 직업·전공을 추천합니다.</p>
            </div>
            <div class="rounded-xl p-4" style="background:rgba(251,191,36,0.08);border:1px solid rgba(251,191,36,0.2);">
              <div class="flex items-center gap-3 mb-2">
                <span class="w-9 h-9 rounded-lg flex items-center justify-center" style="background:rgba(251,191,36,0.2);"><i class="fas fa-book-open text-sm" style="color:#fbbf24;"></i></span>
                <h3 class="text-base font-semibold text-white">HowTo 가이드</h3>
              </div>
              <p class="text-sm text-slate-300">취업 준비, 면접, 자격증 등 커리어 관련 실용 가이드를 제공합니다.</p>
            </div>
          </div>
        </section>

        <!-- 데이터 규모 -->
        <section>
          <h2 class="text-lg font-semibold text-white mb-3">데이터 규모</h2>
          <div class="flex flex-wrap gap-4">
            <div class="flex items-center gap-3 rounded-xl px-5 py-3" style="background:rgba(99,102,241,0.1);border:1px solid rgba(99,102,241,0.2);">
              <span class="text-2xl font-bold text-indigo-300">6,945</span>
              <span class="text-sm text-slate-400">직업 정보</span>
            </div>
            <div class="flex items-center gap-3 rounded-xl px-5 py-3" style="background:rgba(99,102,241,0.1);border:1px solid rgba(99,102,241,0.2);">
              <span class="text-2xl font-bold text-indigo-300">608</span>
              <span class="text-sm text-slate-400">전공 정보</span>
            </div>
          </div>
          <p class="text-sm text-slate-400 mt-3">데이터 출처: 한국고용정보원(커리어넷), 고용노동부(고용24) 등 공공데이터</p>
        </section>

        <!-- 연락처 -->
        <section>
          <h2 class="text-lg font-semibold text-white mb-3">연락처 (Contact Us)</h2>
          <div class="rounded-xl p-4" style="background:rgba(99,102,241,0.08);border:1px solid rgba(99,102,241,0.2);">
            <div class="space-y-3 text-slate-300">
              <div class="flex items-center gap-3">
                <i class="fas fa-envelope text-indigo-400 w-5 text-center"></i>
                <a href="mailto:contact@careerwiki.org" class="text-blue-300 hover:text-blue-200 transition-colors">contact@careerwiki.org</a>
              </div>
              <div class="flex items-center gap-3">
                <i class="fas fa-globe text-indigo-400 w-5 text-center"></i>
                <a href="https://careerwiki.org" class="text-blue-300 hover:text-blue-200 transition-colors">careerwiki.org</a>
              </div>
              <div class="flex items-center gap-3">
                <i class="fas fa-comments text-indigo-400 w-5 text-center"></i>
                <a href="/feedback" class="text-blue-300 hover:text-blue-200 transition-colors">피드백 게시판</a>
              </div>
            </div>
          </div>
          <p class="text-sm text-slate-400 mt-3">서비스 이용 관련 문의, 버그 제보, 기능 제안은 이메일 또는 피드백 게시판으로 보내주세요.</p>
        </section>

      </div>
    </div>
  </main>

  ${renderNavScripts()}
  ${renderFooter()}
</body>
</html>`
}
