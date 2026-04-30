/**
 * 운영자 신고 검토 큐 — /admin/moderation
 * 정책 enforcement §4 Phase 3 (B2)
 */

import { renderNav, renderNavStyles, renderNavScripts } from '../partials/nav'
import { renderFooter } from '../../utils/shared-helpers'
import type { ModerationQueueItem } from '../../services/enforcementService'

export type ModerationQueuePageProps = {
  userMenuHtml?: string
  items: ModerationQueueItem[]
}

export function renderModerationQueuePage(props: ModerationQueuePageProps): string {
  const userMenuHtml = props.userMenuHtml || ''
  const items = props.items || []

  const priorityBadge = (p: string) => {
    const colors: Record<string, string> = {
      urgent: 'background: #dc2626; color: white;',
      high: 'background: #ea580c; color: white;',
      normal: 'background: #475569; color: #e2e8f0;',
      low: 'background: #334155; color: #94a3b8;'
    }
    return `<span style="padding:3px 8px; border-radius:6px; font-size:0.75rem; font-weight:700; ${colors[p] || colors.normal}">${escapeHtml(p.toUpperCase())}</span>`
  }

  const slaIndicator = (deadline: string | null) => {
    if (!deadline) return ''
    const deadlineMs = Date.parse(deadline)
    const remainingMs = deadlineMs - Date.now()
    const remainingHours = Math.floor(remainingMs / 3600_000)
    if (remainingMs < 0) {
      return `<span style="color:#fca5a5; font-weight:700;">⏰ SLA 초과 ${Math.abs(remainingHours)}시간</span>`
    }
    return `<span style="color:${remainingHours < 2 ? '#fbbf24' : '#94a3b8'};">SLA ${remainingHours}시간 남음</span>`
  }

  const rows = items.map(item => `
    <tr style="border-top: 1px solid rgba(148,163,184,0.15);">
      <td style="padding: 10px 8px;">${priorityBadge(item.priority)}</td>
      <td style="padding: 10px 8px;">
        <code style="font-size: 0.85rem; color: #c7d2fe;">${escapeHtml(item.target_type)}</code>
        <span style="color:#94a3b8; margin-left:6px;">#${item.target_id}</span>
      </td>
      <td style="padding: 10px 8px;">
        ${item.auto_flagged ? '<span style="color:#fbbf24;">⚙️ 자동</span>' : '<span style="color:#94a3b8;">사용자</span>'}
        ${item.source_report_id ? ` · <span style="color:#94a3b8; font-size:0.82rem;">${escapeHtml(item.source_report_type || '')} #${item.source_report_id}</span>` : ''}
      </td>
      <td style="padding: 10px 8px; font-size: 0.85rem;">${slaIndicator(item.sla_deadline)}</td>
      <td style="padding: 10px 8px; font-size: 0.82rem; color:#94a3b8;">${escapeHtml(item.created_at)}</td>
      <td style="padding: 10px 8px;">
        <form method="POST" action="/admin/moderation/${item.id}/decide" style="display:inline-flex; gap:6px; flex-wrap:wrap;">
          <button name="decision" value="keep" style="padding:5px 9px; border-radius:6px; background:#16a34a22; color:#86efac; border:1px solid #16a34a44; cursor:pointer; font-size:0.82rem;">유지</button>
          <button name="decision" value="warn_keep" style="padding:5px 9px; border-radius:6px; background:#ca8a0422; color:#fde047; border:1px solid #ca8a0444; cursor:pointer; font-size:0.82rem;">경고+유지</button>
          <button name="decision" value="request_revision" style="padding:5px 9px; border-radius:6px; background:#0284c722; color:#7dd3fc; border:1px solid #0284c744; cursor:pointer; font-size:0.82rem;">수정요청</button>
          <button name="decision" value="delete" style="padding:5px 9px; border-radius:6px; background:#dc262622; color:#fca5a5; border:1px solid #dc262644; cursor:pointer; font-size:0.82rem;">삭제</button>
        </form>
      </td>
    </tr>
  `).join('')

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>신고 검토 큐 | Careerwiki Admin</title>
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
  <main class="max-w-[1400px] mx-auto px-3 md:px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-8">
      <p class="text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">관리자</p>
      <h1 class="text-3xl font-bold text-white mt-2">신고 검토 큐</h1>
      <p class="text-wiki-muted mt-2">정책 <a href="/policy/enforcement" class="text-blue-300 hover:underline">신고·이의·제재 절차서</a> §4 Phase 3에 따라 4결과(유지/삭제/경고+유지/수정요청) 중 하나로 결정합니다. 자살자해(URGENT)는 2시간 SLA.</p>
    </header>
    <div class="glass-card rounded-2xl p-4 sm:p-6 overflow-x-auto">
      ${items.length === 0
        ? `<div style="text-align:center; padding:60px 20px; color:#94a3b8;">대기 중인 신고가 없습니다. ✨</div>`
        : `<table style="width:100%; border-collapse:collapse;">
            <thead>
              <tr style="text-align:left; color:#94a3b8; font-size:0.78rem; text-transform:uppercase; letter-spacing:0.06em;">
                <th style="padding:10px 8px;">우선순위</th>
                <th style="padding:10px 8px;">대상</th>
                <th style="padding:10px 8px;">출처</th>
                <th style="padding:10px 8px;">SLA</th>
                <th style="padding:10px 8px;">접수</th>
                <th style="padding:10px 8px;">결정</th>
              </tr>
            </thead>
            <tbody>${rows}</tbody>
          </table>`}
    </div>
  </main>
  ${renderNavScripts()}
  ${renderFooter()}
</body>
</html>`
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text ?? '').replace(/[&<>"']/g, (m) => map[m])
}
