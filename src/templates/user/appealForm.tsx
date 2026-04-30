/**
 * 사용자 이의제기/소명 폼 — /user/appeal
 * 정책 enforcement §5 (B3) + §7 (B6 소명)
 */

import { renderNav, renderNavStyles, renderNavScripts } from '../partials/nav'
import { renderFooter } from '../../utils/shared-helpers'

export type AppealFormPageProps = {
  userMenuHtml?: string
  /** 기존 이의제기 목록 */
  myAppeals?: Array<{
    id: number
    target_type: string
    target_id: number
    reason: string
    status: string
    created_at: string
    temp_action_ends_at?: string | null
    review_note?: string | null
    resubmit_blocked_until?: string | null
  }>
  prefilled?: {
    target_type?: string
    target_id?: number
  }
  flash?: { type: 'success' | 'error'; message: string }
}

export function renderAppealFormPage(props: AppealFormPageProps): string {
  const userMenuHtml = props.userMenuHtml || ''
  const myAppeals = props.myAppeals || []
  const flash = props.flash

  const flashHtml = flash
    ? `<div class="mb-6 p-4 rounded-xl border ${flash.type === 'success' ? 'border-emerald-400/40 bg-emerald-500/10 text-emerald-200' : 'border-rose-400/40 bg-rose-500/10 text-rose-200'}">${escapeHtml(flash.message)}</div>`
    : ''

  const appealRows = myAppeals.map(a => {
    const statusColor: Record<string, string> = {
      pending: '#fbbf24',
      reviewing: '#93c5fd',
      accepted: '#86efac',
      rejected: '#fca5a5',
      partially_accepted: '#fdba74',
      expired: '#94a3b8'
    }
    const statusLabel: Record<string, string> = {
      pending: '대기 중',
      reviewing: '검토 중',
      accepted: '인용됨',
      rejected: '기각됨',
      partially_accepted: '일부 인용',
      expired: '기간 만료'
    }
    return `<tr style="border-top: 1px solid rgba(148,163,184,0.15);">
      <td style="padding: 10px 8px;"><code style="font-size: 0.82rem; color:#c7d2fe;">${escapeHtml(a.target_type)} #${a.target_id}</code></td>
      <td style="padding: 10px 8px; max-width: 360px; word-break: break-word;">${escapeHtml(a.reason).slice(0, 200)}${a.reason.length > 200 ? '…' : ''}</td>
      <td style="padding: 10px 8px;"><span style="color: ${statusColor[a.status] || '#94a3b8'}; font-weight:600;">${escapeHtml(statusLabel[a.status] || a.status)}</span></td>
      <td style="padding: 10px 8px; font-size: 0.82rem; color:#94a3b8;">${escapeHtml(a.created_at)}</td>
      <td style="padding: 10px 8px; font-size: 0.78rem; color:#fca5a5;">${a.resubmit_blocked_until ? '재소명 ' + escapeHtml(a.resubmit_blocked_until) + ' 까지 차단' : ''}</td>
    </tr>`
  }).join('')

  const prefilledTargetType = props.prefilled?.target_type ?? ''
  const prefilledTargetId = props.prefilled?.target_id ?? ''

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>이의제기·소명 | Careerwiki</title>
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
      <p class="text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">이의제기·소명</p>
      <h1 class="text-3xl font-bold text-white mt-2">이의제기·소명 신청</h1>
      <p class="text-wiki-muted mt-3 leading-relaxed">
        본인의 게시물·계정에 대한 운영팀 결정이 부당하다고 판단되시면 이 폼을 통해 이의제기 또는 소명을 제출할 수 있습니다.
        절차는 <a href="/policy/enforcement#phase4" class="text-blue-300 hover:underline">신고·이의·제재 절차서 §5</a>를 따릅니다.
      </p>
    </header>

    ${flashHtml}

    <section class="glass-card rounded-2xl p-5 md:p-7 mb-8">
      <h2 class="text-xl font-bold text-white mb-4">새 이의제기 / 소명</h2>
      <form method="POST" action="/user/appeal" class="space-y-4">
        <div>
          <label class="block text-sm text-slate-300 mb-2">대상 종류</label>
          <select name="target_type" required class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm">
            <option value="comment_takedown" ${prefilledTargetType === 'comment_takedown' ? 'selected' : ''}>댓글 임시조치(블라인드/삭제)</option>
            <option value="sanction" ${prefilledTargetType === 'sanction' ? 'selected' : ''}>제재(경고/정지/영구)</option>
            <option value="content_removal" ${prefilledTargetType === 'content_removal' ? 'selected' : ''}>HowTo·위키 콘텐츠 삭제</option>
          </select>
        </div>
        <div>
          <label class="block text-sm text-slate-300 mb-2">대상 ID</label>
          <input type="number" name="target_id" value="${prefilledTargetId}" required min="1"
            class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm font-mono"
            placeholder="결정 통지 메일에 적힌 ID 또는 통지 페이지의 번호">
        </div>
        <div>
          <label class="block text-sm text-slate-300 mb-2">사유 <span class="text-rose-400">*</span> (50자 이상 권장)</label>
          <textarea name="reason" required minlength="20" rows="6"
            class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm resize-y"
            placeholder="결정에 동의하지 않는 이유를 구체적으로 적어주세요. 본인의 입장, 관련 사실, 출처 등."></textarea>
        </div>
        <div>
          <label class="block text-sm text-slate-300 mb-2">증빙 (선택)</label>
          <textarea name="evidence" rows="3"
            class="w-full px-4 py-2.5 bg-wiki-bg border border-wiki-border rounded-lg text-sm resize-y"
            placeholder="외부 링크·공식 출처·캡처 URL 등 텍스트로"></textarea>
        </div>
        <div class="flex items-start gap-3 p-3 rounded-lg bg-amber-500/8 border border-amber-400/30">
          <i class="fas fa-info-circle text-amber-300 mt-1"></i>
          <div class="text-sm text-amber-200">
            제출 즉시 <strong>30일 임시조치 상태</strong>로 진입합니다. 운영팀이 검토 후 결과를 통지하며,
            기각 시 동일 사안 재소명은 <strong>30일간 제한</strong>됩니다.
          </div>
        </div>
        <button type="submit"
          class="w-full sm:w-auto px-6 py-3 bg-wiki-primary text-white rounded-lg font-semibold hover:brightness-110 transition">
          이의제기 제출
        </button>
      </form>
    </section>

    <section class="glass-card rounded-2xl p-5 md:p-7">
      <h2 class="text-xl font-bold text-white mb-4">내 이의제기 이력</h2>
      ${myAppeals.length === 0
        ? `<p class="text-slate-400">제출한 이의제기가 없습니다.</p>`
        : `<div style="overflow-x:auto;">
            <table style="width:100%; border-collapse:collapse;">
              <thead>
                <tr style="text-align:left; color:#94a3b8; font-size:0.78rem; text-transform:uppercase;">
                  <th style="padding:10px 8px;">대상</th>
                  <th style="padding:10px 8px;">사유</th>
                  <th style="padding:10px 8px;">상태</th>
                  <th style="padding:10px 8px;">접수일</th>
                  <th style="padding:10px 8px;">재소명 제한</th>
                </tr>
              </thead>
              <tbody>${appealRows}</tbody>
            </table>
          </div>`}
    </section>
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
