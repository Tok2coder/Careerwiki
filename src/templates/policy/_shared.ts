/**
 * Shared policy/help page renderer
 * - 모든 정책 문서가 동일한 톤과 레이아웃으로 보이도록 단일 헬퍼 사용
 * - terms.tsx의 디자인을 일반화 — id/title/content 섹션 + sticky TOC + 헤더 메타
 */

import { renderNav, renderNavStyles, renderNavScripts } from '../partials/nav'
import { renderFooter } from '../../utils/shared-helpers'

export type PolicySection = {
  id: string
  title: string
  content: string
}

export type PolicyPageMeta = {
  /** 헤더 위 라벨 (예: "정책", "도움말") */
  kicker: string
  /** Font Awesome 아이콘 이름 (fa-shield-halved 등) */
  icon: string
  /** 페이지 타이틀 (h1) */
  title: string
  /** 헤더 우측에 표시할 부제·메타 (예: "버전 1.0 · 시행 2026-04-30") */
  subtitle?: string
  /** <title> 태그용 */
  pageTitle: string
  /** 본문 시작 전 안내 문단 (선택) */
  intro?: string
  /** 본문 마지막 부칙 텍스트 (선택) */
  addendum?: string
}

export type PolicyPageOptions = {
  userMenuHtml?: string
}

/**
 * 정책 페이지 공용 렌더러
 * — 모든 정책·도움말·운영문서가 이 함수를 호출해 일관된 디자인을 갖는다.
 */
export function renderPolicyPage(
  meta: PolicyPageMeta,
  sections: PolicySection[],
  options?: PolicyPageOptions
): string {
  const userMenuHtml = options?.userMenuHtml || ''

  const tocHtml = sections.map((s, i) =>
    `<a href="#${s.id}" class="toc-item group flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all duration-200 hover:bg-white/5">
      <span class="flex-shrink-0 w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold transition-all duration-200" style="background:rgba(99,102,241,0.15);color:#818cf8;">
        ${i + 1}
      </span>
      <span class="text-sm text-slate-400 group-hover:text-white transition-colors">${escapeHtml(s.title)}</span>
    </a>`
  ).join('')

  const sectionsHtml = sections.map(s => `
    <section id="${s.id}" class="scroll-mt-24">
      <h2 class="text-lg font-semibold text-white mt-8 mb-3">${escapeHtml(s.title)}</h2>
      <div class="text-slate-300 space-y-2 leading-relaxed">${s.content}</div>
    </section>
  `).join('')

  const subtitleHtml = meta.subtitle
    ? `<p class="text-wiki-muted text-[15px]">${escapeHtml(meta.subtitle)}</p>`
    : ''

  const introHtml = meta.intro
    ? `<p class="text-slate-300 mb-6 leading-relaxed">${meta.intro}</p>`
    : ''

  const addendumHtml = meta.addendum
    ? `<section id="addendum" class="scroll-mt-24">
        <h2 class="text-lg font-semibold text-white mt-8 mb-3">부칙</h2>
        <p class="text-slate-300">${escapeHtml(meta.addendum)}</p>
      </section>`
    : ''

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${escapeHtml(meta.pageTitle)} | Careerwiki</title>
  <meta name="description" content="${escapeHtml(meta.title)} - Careerwiki 운영 정책 및 도움말">
  <link href="/static/style.css" rel="stylesheet" />
  <link rel="stylesheet" href="/static/tailwind.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #0f0f23; color: #e0e0e0; }
    .glass-card { background: rgba(26, 26, 46, 0.82); border: 1px solid rgba(148, 163, 184, 0.22); backdrop-filter: blur(14px); -webkit-backdrop-filter: blur(14px); }
    .policy-prose ol.list-decimal > li { margin: 0.4em 0; }
    .policy-prose ul.list-disc > li { margin: 0.3em 0; }
    .policy-prose strong { color: #e2e8f0; }
    .policy-prose code { background: rgba(99, 102, 241, 0.12); color: #c7d2fe; padding: 1px 6px; border-radius: 4px; font-size: 0.9em; }
    .policy-prose .callout { border: 1px solid rgba(99, 102, 241, 0.28); background: rgba(99, 102, 241, 0.06); padding: 12px 16px; border-radius: 12px; margin: 10px 0; }
    .policy-prose .callout-warn { border-color: rgba(251, 146, 60, 0.35); background: rgba(251, 146, 60, 0.07); }
    .policy-prose .callout-danger { border-color: rgba(248, 113, 113, 0.4); background: rgba(248, 113, 113, 0.06); }
    .policy-prose .callout-good { border-color: rgba(52, 211, 153, 0.35); background: rgba(52, 211, 153, 0.06); }
    .policy-prose table { width: 100%; border-collapse: collapse; margin: 12px 0; font-size: 0.9em; }
    .policy-prose th, .policy-prose td { border: 1px solid rgba(148, 163, 184, 0.2); padding: 8px 10px; text-align: left; vertical-align: top; }
    .policy-prose th { background: rgba(99, 102, 241, 0.08); color: #e2e8f0; font-weight: 600; }
  </style>
  <!-- Google Analytics 4 -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-H9R83SJRRY"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-H9R83SJRRY');
  </script>
  ${renderNavStyles()}
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}

  <main class="max-w-[1400px] mx-auto px-2 md:px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-8 space-y-3">
      <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
        <i class="fas ${escapeHtml(meta.icon)}"></i><span>${escapeHtml(meta.kicker)}</span>
      </div>
      <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <h1 class="text-3xl md:text-4xl font-bold text-white">${escapeHtml(meta.title)}</h1>
        ${subtitleHtml}
      </div>
      <div class="flex flex-wrap gap-2 pt-2 text-xs">
        <a href="/policy" class="px-3 py-1.5 rounded-full border border-slate-700 text-slate-300 hover:border-blue-500 hover:text-white transition-colors">← 정책 인덱스</a>
        <a href="/help" class="px-3 py-1.5 rounded-full border border-slate-700 text-slate-300 hover:border-blue-500 hover:text-white transition-colors">도움말</a>
        <a href="/feedback" class="px-3 py-1.5 rounded-full border border-slate-700 text-slate-300 hover:border-blue-500 hover:text-white transition-colors">피드백</a>
      </div>
    </header>

    <details class="mb-6 glass-card rounded-2xl overflow-hidden md:open" open>
      <summary class="px-5 py-4 cursor-pointer select-none flex items-center justify-between gap-3 hover:bg-white/[0.03] transition-colors">
        <div class="flex items-center gap-3">
          <span class="w-8 h-8 rounded-lg flex items-center justify-center" style="background:linear-gradient(135deg,rgba(99,102,241,0.25),rgba(139,92,246,0.25));">
            <i class="fas fa-list-ol text-sm" style="color:#a78bfa;"></i>
          </span>
          <span class="text-sm font-semibold text-slate-200">목차</span>
          <span class="text-xs text-slate-500">${sections.length}개 항목</span>
        </div>
        <i class="fas fa-chevron-down text-xs text-slate-500 transition-transform"></i>
      </summary>
      <div class="px-4 pb-4 grid grid-cols-1 sm:grid-cols-2 gap-1">
        ${tocHtml}
      </div>
    </details>

    <div class="glass-card rounded-2xl p-4 sm:p-6 md:p-8">
      ${introHtml}
      <div class="prose prose-invert prose-slate max-w-none policy-prose">
        ${sectionsHtml}
        ${addendumHtml}
      </div>
    </div>
  </main>

  ${renderNavScripts()}
  ${renderFooter()}
</body>
</html>`
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, (m) => map[m])
}
