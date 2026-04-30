/**
 * 토론·분쟁 페이지 (/dispute/:id) — D2~D8 통합 UI
 * 정책 dispute §1~§8
 */

import { renderNav, renderNavStyles, renderNavScripts } from '../partials/nav'
import { renderFooter } from '../../utils/shared-helpers'

type Proposal = {
  id: number
  proposed_text: string
  proposed_evidence: string | null
  status: string
  agreement_count: number
  objection_window_starts_at: string | null
  objection_window_ends_at: string | null
  objection_extensions: number
  created_at: string
}

type Thread = {
  id: number
  target_type: string
  target_id: string
  target_field: string | null
  opener_position: string | null
  opener_evidence: string | null
  frozen_text: string | null
  status: string
  resolution: string | null
  created_at: string
  parent_thread_id: number | null
}

export type DisputeViewPageProps = {
  userMenuHtml?: string
  thread: Thread
  proposals: Proposal[]
  isLoggedIn: boolean
  flash?: { type: 'success' | 'error'; message: string }
}

export function renderDisputeViewPage(props: DisputeViewPageProps): string {
  const userMenuHtml = props.userMenuHtml || ''
  const t = props.thread
  const proposals = props.proposals || []

  const targetLink = (() => {
    if (t.target_type === 'job') return `<a href="/job/${encodeURIComponent(t.target_id)}" class="text-blue-300 hover:underline">${escapeHtml(t.target_id)}</a>`
    if (t.target_type === 'major') return `<a href="/major/${encodeURIComponent(t.target_id)}" class="text-blue-300 hover:underline">${escapeHtml(t.target_id)}</a>`
    if (t.target_type === 'howto') return `<a href="/howto/${encodeURIComponent(t.target_id)}" class="text-blue-300 hover:underline">${escapeHtml(t.target_id)}</a>`
    return `<code>${escapeHtml(t.target_type)}/${escapeHtml(t.target_id)}</code>`
  })()

  const flashHtml = props.flash
    ? `<div class="mb-6 p-4 rounded-xl border ${props.flash.type === 'success' ? 'border-emerald-400/40 bg-emerald-500/10 text-emerald-200' : 'border-rose-400/40 bg-rose-500/10 text-rose-200'}">${escapeHtml(props.flash.message)}</div>`
    : ''

  const proposalsHtml = proposals.map(p => {
    const remainingMs = p.objection_window_ends_at
      ? Date.parse(p.objection_window_ends_at) - Date.now()
      : null
    const remainingHours = remainingMs != null ? Math.floor(remainingMs / 3600_000) : null
    const remainingLabel = remainingMs == null
      ? ''
      : remainingMs < 0
      ? '<span style="color:#86efac;">이의 제기 기간 종료</span>'
      : `<span style="color:#fde047;">⏱ 이의 제기 기간 ${remainingHours}시간 남음 (갱신 ${p.objection_extensions}/2회)</span>`

    const statusColors: Record<string, string> = {
      pending: 'background:#475569; color:#cbd5e1;',
      awaiting_objection: 'background:rgba(251,191,36,0.2); color:#fde047;',
      agreed: 'background:rgba(52,211,153,0.2); color:#86efac;',
      rejected: 'background:rgba(248,113,113,0.2); color:#fca5a5;',
      invalidated: 'background:#475569; color:#94a3b8;'
    }
    const statusLabels: Record<string, string> = {
      pending: '대기',
      awaiting_objection: '이의 기간',
      agreed: '합의 성립',
      rejected: '반려',
      invalidated: '무효화'
    }
    const status = statusLabels[p.status] || p.status

    return `
      <article class="glass-card rounded-xl p-5 mb-4">
        <header class="flex items-center justify-between mb-3">
          <div class="flex items-center gap-2">
            <span style="padding:3px 10px; border-radius:8px; font-size:0.78rem; font-weight:600; ${statusColors[p.status] || statusColors.pending}">${escapeHtml(status)}</span>
            <span class="text-xs text-slate-400">동의 ${p.agreement_count}명</span>
          </div>
          <span class="text-xs text-slate-500">${escapeHtml(p.created_at)}</span>
        </header>
        <div class="prose prose-invert max-w-none">
          <h4 class="text-sm font-semibold text-white mb-2">제안 내용</h4>
          <p style="white-space:pre-wrap; color:#cbd5e1;">${escapeHtml(p.proposed_text)}</p>
          ${p.proposed_evidence ? `<h4 class="text-sm font-semibold text-white mt-3 mb-2">근거</h4><p style="white-space:pre-wrap; color:#94a3b8; font-size:0.88rem;">${escapeHtml(p.proposed_evidence)}</p>` : ''}
        </div>
        ${remainingLabel ? `<div class="mt-3 text-sm">${remainingLabel}</div>` : ''}
        ${props.isLoggedIn && p.status === 'awaiting_objection' ? `
        <div class="mt-4 flex gap-2 flex-wrap">
          <form method="POST" action="/dispute/${t.id}/proposal/${p.id}/vote" style="display:inline;">
            <input type="hidden" name="vote_type" value="agree">
            <button type="submit" class="px-3 py-1.5 rounded-lg text-sm" style="background:rgba(52,211,153,0.15); color:#86efac; border:1px solid rgba(52,211,153,0.4); cursor:pointer;">👍 동의</button>
          </form>
          <form method="POST" action="/dispute/${t.id}/proposal/${p.id}/vote" style="display:inline;">
            <input type="hidden" name="vote_type" value="object">
            <button type="submit" class="px-3 py-1.5 rounded-lg text-sm" style="background:rgba(248,113,113,0.15); color:#fca5a5; border:1px solid rgba(248,113,113,0.4); cursor:pointer;">⚠️ 이의제기 (+6h)</button>
          </form>
        </div>` : ''}
      </article>
    `
  }).join('')

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>토론 #${t.id} | Careerwiki</title>
  <link rel="stylesheet" href="/static/tailwind.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #0f0f23; color: #e0e0e0; }
    .glass-card { background: rgba(26, 26, 46, 0.82); border: 1px solid rgba(148, 163, 184, 0.22); }
  </style>
  ${renderNavStyles()}
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}
  <main class="max-w-[1100px] mx-auto px-3 md:px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-8">
      <div class="flex items-center gap-2 text-xs text-purple-300 font-semibold uppercase tracking-[0.2em]">
        <i class="fas fa-comments"></i><span>토론</span>
      </div>
      <h1 class="text-3xl font-bold text-white mt-2">토론 #${t.id}</h1>
      <p class="text-wiki-muted mt-2">대상: ${targetLink}${t.target_field ? ' · 필드 <code>' + escapeHtml(t.target_field) + '</code>' : ''}</p>
      <p class="text-xs text-slate-500 mt-1">발제일 ${escapeHtml(t.created_at)} · 상태 <strong>${escapeHtml(t.status)}</strong>${t.parent_thread_id ? ` · <a href="/dispute/${t.parent_thread_id}" class="text-blue-300 hover:underline">이전 토론 보기</a>` : ''}</p>
    </header>

    ${flashHtml}

    <section class="glass-card rounded-2xl p-5 md:p-7 mb-6">
      <h2 class="text-lg font-bold text-white mb-3">발제</h2>
      ${t.opener_position ? `<p style="white-space:pre-wrap; color:#cbd5e1; line-height:1.65;">${escapeHtml(t.opener_position)}</p>` : ''}
      ${t.opener_evidence ? `<details class="mt-3"><summary class="cursor-pointer text-sm text-slate-400">근거·출처 보기</summary><p style="white-space:pre-wrap; color:#94a3b8; font-size:0.88rem; margin-top:8px;">${escapeHtml(t.opener_evidence)}</p></details>` : ''}
      ${t.frozen_text ? `<div class="mt-4 p-3 rounded-lg" style="background:rgba(15,23,42,0.5); border:1px solid rgba(148,163,184,0.18);">
        <p class="text-xs text-slate-400 mb-1">서술 시점 고정 (분쟁 대상 원본)</p>
        <pre style="white-space:pre-wrap; color:#94a3b8; font-size:0.85rem; margin:0;">${escapeHtml(t.frozen_text)}</pre>
      </div>` : ''}
    </section>

    <section class="mb-6">
      <h2 class="text-lg font-bold text-white mb-3">합의안 ${proposals.length > 0 ? `(${proposals.length})` : ''}</h2>
      ${proposals.length === 0
        ? '<p class="text-slate-400">아직 합의안이 제시되지 않았습니다.</p>'
        : proposalsHtml}
    </section>

    ${props.isLoggedIn && t.status !== 'closed_consensus' && t.status !== 'closed_no_consensus' && t.status !== 'invalidated' ? `
    <section class="glass-card rounded-2xl p-5 md:p-7">
      <h2 class="text-lg font-bold text-white mb-3">합의안 제시</h2>
      <form method="POST" action="/dispute/${t.id}/propose" class="space-y-3">
        <textarea name="proposed_text" required minlength="20" rows="5"
          class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg text-sm resize-y"
          placeholder="합의 후 본문에 적용될 텍스트를 작성하세요. (최소 20자)"></textarea>
        <textarea name="proposed_evidence" rows="3"
          class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg text-sm resize-y"
          placeholder="근거·출처 (선택)"></textarea>
        <button type="submit" class="px-5 py-2.5 bg-wiki-primary text-white rounded-lg font-semibold">합의안 제출</button>
      </form>
    </section>` : ''}

    <p class="text-xs text-slate-500 mt-8">
      절차 규정 → <a href="/policy/dispute" class="text-blue-300 hover:underline">토론·합의 절차서</a> ·
      관련 정책 → <a href="/policy/source-tier" class="text-blue-300 hover:underline">출처 등급</a>
    </p>
  </main>
  ${renderNavScripts()}
  ${renderFooter()}
</body>
</html>`
}

export type DisputeOpenPageProps = {
  userMenuHtml?: string
  prefilled?: { target_type?: string; target_id?: string; target_field?: string }
  flash?: { type: 'success' | 'error'; message: string }
}

export function renderDisputeOpenPage(props: DisputeOpenPageProps): string {
  const userMenuHtml = props.userMenuHtml || ''
  const flashHtml = props.flash
    ? `<div class="mb-6 p-4 rounded-xl border ${props.flash.type === 'success' ? 'border-emerald-400/40 bg-emerald-500/10 text-emerald-200' : 'border-rose-400/40 bg-rose-500/10 text-rose-200'}">${escapeHtml(props.flash.message)}</div>`
    : ''

  const pf = props.prefilled || {}
  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>토론 발제 | Careerwiki</title>
  <link rel="stylesheet" href="/static/tailwind.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #0f0f23; color: #e0e0e0; }
    .glass-card { background: rgba(26, 26, 46, 0.82); border: 1px solid rgba(148, 163, 184, 0.22); }
  </style>
  ${renderNavStyles()}
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}
  <main class="max-w-[900px] mx-auto px-3 md:px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-6">
      <p class="text-xs text-purple-300 font-semibold uppercase tracking-[0.2em]">토론 발제</p>
      <h1 class="text-2xl md:text-3xl font-bold text-white mt-2">새 토론 발제</h1>
      <p class="text-wiki-muted mt-2">절차는 <a href="/policy/dispute" class="text-blue-300 hover:underline">토론·합의 절차서</a>를 따릅니다.</p>
    </header>
    ${flashHtml}
    <form method="POST" action="/dispute/open" class="glass-card rounded-2xl p-5 md:p-7 space-y-4">
      <div>
        <label class="block text-sm text-slate-300 mb-2">대상 종류</label>
        <select name="target_type" required class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm">
          <option value="job" ${pf.target_type === 'job' ? 'selected' : ''}>직업 페이지</option>
          <option value="major" ${pf.target_type === 'major' ? 'selected' : ''}>전공 페이지</option>
          <option value="howto" ${pf.target_type === 'howto' ? 'selected' : ''}>HowTo</option>
          <option value="comment" ${pf.target_type === 'comment' ? 'selected' : ''}>댓글</option>
          <option value="policy" ${pf.target_type === 'policy' ? 'selected' : ''}>정책 문서</option>
        </select>
      </div>
      <div>
        <label class="block text-sm text-slate-300 mb-2">대상 ID·슬러그</label>
        <input type="text" name="target_id" value="${escapeHtml(pf.target_id || '')}" required
          class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm font-mono"
          placeholder="예) 소프트웨어개발자 (직업), 가이드-슬러그 (HowTo)">
      </div>
      <div>
        <label class="block text-sm text-slate-300 mb-2">분쟁 필드 (선택)</label>
        <input type="text" name="target_field" value="${escapeHtml(pf.target_field || '')}"
          class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm font-mono"
          placeholder="예) salary, way, trivia">
      </div>
      <div>
        <label class="block text-sm text-slate-300 mb-2">발제자 입장 <span class="text-rose-400">*</span></label>
        <textarea name="opener_position" required minlength="30" rows="6"
          class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm resize-y"
          placeholder="어떤 부분이 분쟁이고 본인은 어떻게 생각하는지 적어주세요. (최소 30자)"></textarea>
      </div>
      <div>
        <label class="block text-sm text-slate-300 mb-2">근거·출처</label>
        <textarea name="opener_evidence" rows="3"
          class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm resize-y"
          placeholder="출처 URL, 1차 자료, 통계 등"></textarea>
      </div>
      <div>
        <label class="block text-sm text-slate-300 mb-2">서술 시점 고정 (분쟁 대상 원본 텍스트)</label>
        <textarea name="frozen_text" rows="3"
          class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm resize-y"
          placeholder="현재 본문에 있는 분쟁 텍스트를 그대로 복사해 붙여넣어 주세요. 토론 진행 중 변경되지 않도록 보존됩니다."></textarea>
      </div>
      <button type="submit" class="w-full sm:w-auto px-6 py-3 bg-wiki-primary text-white rounded-lg font-semibold">토론 발제</button>
    </form>
  </main>
  ${renderNavScripts()}
  ${renderFooter()}
</body>
</html>`
}

function escapeHtml(text: string | null | undefined): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text ?? '').replace(/[&<>"']/g, (m) => map[m])
}
