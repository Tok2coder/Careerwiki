/**
 * 운영자 enforcement 작업 페이지 (단일 파일에 3개 페이지 통합)
 * - /admin/sanctions      : 제재 부과 + 사용자 활성 제재 조회
 * - /admin/appeals        : 이의제기·소명 검토
 * - /admin/company-replies: 회사 답글 승인
 */

import { renderNav, renderNavStyles, renderNavScripts } from '../partials/nav'
import { renderFooter } from '../../utils/shared-helpers'

const SHARED_HEAD = `
  <link rel="stylesheet" href="/static/tailwind.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #0f0f23; color: #e0e0e0; }
    .glass-card { background: rgba(26,26,46,0.82); border:1px solid rgba(148,163,184,0.22); }
    .ops-table { width:100%; border-collapse:collapse; font-size:0.88rem; }
    .ops-table th { text-align:left; color:#94a3b8; font-size:0.74rem; text-transform:uppercase; letter-spacing:0.06em; padding:10px 8px; border-bottom:1px solid rgba(148,163,184,0.2); }
    .ops-table td { padding:10px 8px; border-top:1px solid rgba(148,163,184,0.12); vertical-align: top; }
    .pill { padding:3px 10px; border-radius:8px; font-size:0.74rem; font-weight:700; }
    .btn-row { display:flex; gap:6px; flex-wrap:wrap; }
    .btn { padding:5px 9px; border-radius:6px; font-size:0.78rem; cursor:pointer; border:1px solid; background:transparent; }
    .btn-keep    { background:rgba(22,163,74,0.13); color:#86efac; border-color:rgba(22,163,74,0.4); }
    .btn-warn    { background:rgba(202,138,4,0.13); color:#fde047; border-color:rgba(202,138,4,0.4); }
    .btn-delete  { background:rgba(220,38,38,0.13); color:#fca5a5; border-color:rgba(220,38,38,0.4); }
    .btn-revise  { background:rgba(2,132,199,0.13); color:#7dd3fc; border-color:rgba(2,132,199,0.4); }
    .btn-primary { background:rgba(99,102,241,0.18); color:#c7d2fe; border-color:rgba(99,102,241,0.4); }
    .flash-success { padding:12px 16px; border-radius:12px; border:1px solid rgba(52,211,153,0.4); background:rgba(52,211,153,0.1); color:#a7f3d0; margin-bottom:18px; }
    .flash-error   { padding:12px 16px; border-radius:12px; border:1px solid rgba(248,113,113,0.4); background:rgba(248,113,113,0.1); color:#fecaca; margin-bottom:18px; }
  </style>
`

const flashHtml = (flash?: { type: 'success' | 'error'; message: string }) =>
  flash
    ? `<div class="${flash.type === 'success' ? 'flash-success' : 'flash-error'}">${escapeHtml(flash.message)}</div>`
    : ''

// ============================================================================
// /admin/sanctions
// ============================================================================

export type SanctionsPageProps = {
  userMenuHtml?: string
  recentSanctions: Array<{
    id: number
    user_id: number
    stage: string
    reason_category: string
    reason_detail: string | null
    started_at: string
    ends_at: string | null
    status: string
    issued_by: number | null
  }>
  flash?: { type: 'success' | 'error'; message: string }
}

export function renderSanctionsAdminPage(props: SanctionsPageProps): string {
  const userMenuHtml = props.userMenuHtml || ''
  const rows = props.recentSanctions.map(s => `
    <tr>
      <td><code>#${s.id}</code></td>
      <td>user #${s.user_id}</td>
      <td><span class="pill" style="background:rgba(220,38,38,0.18); color:#fca5a5;">${escapeHtml(s.stage)}</span></td>
      <td><span class="pill" style="background:rgba(99,102,241,0.18); color:#c7d2fe;">${escapeHtml(s.reason_category)}</span></td>
      <td style="max-width:300px; word-break:break-word;">${escapeHtml(s.reason_detail || '')}</td>
      <td style="font-size:0.78rem; color:#94a3b8;">${escapeHtml(s.started_at)} → ${escapeHtml(s.ends_at || '영구')}</td>
      <td><span class="pill" style="${s.status === 'active' ? 'background:rgba(248,113,113,0.18); color:#fca5a5;' : 'background:rgba(148,163,184,0.18); color:#cbd5e1;'}">${escapeHtml(s.status)}</span></td>
      <td>
        ${s.status === 'active' ? `
          <form method="POST" action="/admin/sanctions/${s.id}/lift" style="display:inline;">
            <button class="btn btn-keep" type="submit">해제</button>
          </form>` : ''}
      </td>
    </tr>
  `).join('')

  return `<!DOCTYPE html>
<html lang="ko"><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>제재 부과 | Careerwiki Admin</title>
  ${SHARED_HEAD}
  ${renderNavStyles()}
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}
  <main class="max-w-[1400px] mx-auto px-3 md:px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-6">
      <p class="text-xs text-rose-300 font-semibold uppercase tracking-[0.2em]">관리자 — 제재</p>
      <h1 class="text-3xl font-bold text-white mt-2">제재 부과·관리</h1>
      <p class="text-wiki-muted mt-2 text-sm">정책 <a href="/policy/enforcement#phase5" class="text-blue-300 hover:underline">enforcement §6</a> 단계제 적용 · 직접 부과 또는 신고 큐에서 단계 자동 결정.</p>
    </header>
    ${flashHtml(props.flash)}

    <section class="glass-card rounded-2xl p-5 md:p-6 mb-6">
      <h2 class="text-lg font-bold text-white mb-3">새 제재 부과</h2>
      <form method="POST" action="/admin/sanctions" style="display:grid; gap:12px; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));">
        <input type="number" name="user_id" required placeholder="대상 user_id" class="px-3 py-2 bg-wiki-bg border border-wiki-border rounded-lg text-sm">
        <select name="stage" class="px-3 py-2 bg-wiki-bg border border-wiki-border rounded-lg text-sm">
          <option value="">자동 (누적 카운트)</option>
          <option value="warn">경고 (1차)</option>
          <option value="suspend_7d">7일 정지 (2차)</option>
          <option value="suspend_30d">30일 정지 (3차)</option>
          <option value="permanent">영구 (4차)</option>
        </select>
        <select name="reason_category" required class="px-3 py-2 bg-wiki-bg border border-wiki-border rounded-lg text-sm">
          <option value="hate">혐오·차별</option>
          <option value="abuse">욕설·인신공격</option>
          <option value="misinfo">허위·명예훼손</option>
          <option value="privacy">개인정보 노출</option>
          <option value="spam">스팸·광고</option>
          <option value="csam">아동성착취 (즉시 영구)</option>
          <option value="threat">폭력 협박 (즉시 영구)</option>
          <option value="evasion">차단 회피 (즉시 영구)</option>
          <option value="malware">악성코드 (즉시 영구)</option>
          <option value="repeated_falsehood">반복 허위사실</option>
          <option value="other">기타</option>
        </select>
        <input type="text" name="reason_detail" placeholder="상세 사유 (선택)" class="px-3 py-2 bg-wiki-bg border border-wiki-border rounded-lg text-sm" style="grid-column: span 2;">
        <label style="display:flex; align-items:center; gap:6px; font-size:0.84rem; color:#cbd5e1;">
          <input type="checkbox" name="is_immediate" value="1"> 즉시 영구 (단계 건너뜀)
        </label>
        <button type="submit" class="btn btn-primary" style="padding:8px 14px;">부과</button>
      </form>
    </section>

    <section class="glass-card rounded-2xl p-5 md:p-6">
      <h2 class="text-lg font-bold text-white mb-3">최근 제재 (50건)</h2>
      <div style="overflow-x:auto;">
        <table class="ops-table">
          <thead><tr><th>ID</th><th>대상</th><th>단계</th><th>사유</th><th>상세</th><th>기간</th><th>상태</th><th>조치</th></tr></thead>
          <tbody>${rows || '<tr><td colspan="8" style="text-align:center; padding:30px; color:#94a3b8;">제재 기록이 없습니다.</td></tr>'}</tbody>
        </table>
      </div>
    </section>
  </main>
  ${renderNavScripts()}
  ${renderFooter()}
</body></html>`
}

// ============================================================================
// /admin/appeals
// ============================================================================

export type AppealsPageProps = {
  userMenuHtml?: string
  appeals: Array<{
    id: number
    user_id: number
    target_type: string
    target_id: number
    reason: string
    evidence: string | null
    status: string
    created_at: string
    temp_action_ends_at: string | null
    review_note: string | null
  }>
  flash?: { type: 'success' | 'error'; message: string }
}

export function renderAppealsAdminPage(props: AppealsPageProps): string {
  const userMenuHtml = props.userMenuHtml || ''
  const statusBadge = (s: string) => {
    const colors: Record<string, string> = {
      pending: 'background:rgba(251,191,36,0.18); color:#fde047;',
      reviewing: 'background:rgba(96,165,250,0.18); color:#bfdbfe;',
      accepted: 'background:rgba(52,211,153,0.18); color:#86efac;',
      rejected: 'background:rgba(248,113,113,0.18); color:#fca5a5;',
      partially_accepted: 'background:rgba(251,146,60,0.18); color:#fed7aa;',
      expired: 'background:rgba(148,163,184,0.18); color:#cbd5e1;'
    }
    return `<span class="pill" style="${colors[s] || colors.pending}">${escapeHtml(s)}</span>`
  }

  const rows = props.appeals.map(a => `
    <tr>
      <td><code>#${a.id}</code></td>
      <td>user #${a.user_id}</td>
      <td><code style="font-size:0.78rem;">${escapeHtml(a.target_type)} #${a.target_id}</code></td>
      <td style="max-width:380px; word-break:break-word; white-space:pre-wrap;">${escapeHtml(a.reason).slice(0, 300)}${a.reason.length > 300 ? '…' : ''}</td>
      <td>${statusBadge(a.status)}</td>
      <td style="font-size:0.78rem; color:#94a3b8;">${escapeHtml(a.created_at)}</td>
      <td>
        ${a.status === 'pending' || a.status === 'reviewing' ? `
        <form method="POST" action="/admin/appeals/${a.id}/decide" class="btn-row">
          <button class="btn btn-keep" name="status" value="accepted" type="submit">인용</button>
          <button class="btn btn-warn" name="status" value="partially_accepted" type="submit">일부 인용</button>
          <button class="btn btn-delete" name="status" value="rejected" type="submit">기각</button>
        </form>` : escapeHtml(a.review_note || '-')}
      </td>
    </tr>
  `).join('')

  return `<!DOCTYPE html>
<html lang="ko"><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>이의제기 검토 | Careerwiki Admin</title>
  ${SHARED_HEAD}
  ${renderNavStyles()}
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}
  <main class="max-w-[1400px] mx-auto px-3 md:px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-6">
      <p class="text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">관리자 — 이의제기</p>
      <h1 class="text-3xl font-bold text-white mt-2">이의제기·소명 검토</h1>
      <p class="text-wiki-muted mt-2 text-sm">정책 <a href="/policy/enforcement#phase4" class="text-blue-300 hover:underline">enforcement §5</a> Phase 4. 본인 사안 결정자 회피.</p>
    </header>
    ${flashHtml(props.flash)}
    <section class="glass-card rounded-2xl p-5 md:p-6">
      <div style="overflow-x:auto;">
        <table class="ops-table">
          <thead><tr><th>ID</th><th>신청인</th><th>대상</th><th>사유</th><th>상태</th><th>접수</th><th>결정</th></tr></thead>
          <tbody>${rows || '<tr><td colspan="7" style="text-align:center; padding:30px; color:#94a3b8;">대기 중인 이의제기가 없습니다.</td></tr>'}</tbody>
        </table>
      </div>
    </section>
  </main>
  ${renderNavScripts()}
  ${renderFooter()}
</body></html>`
}

// ============================================================================
// /admin/company-replies
// ============================================================================

export type CompanyRepliesPageProps = {
  userMenuHtml?: string
  replies: Array<{
    id: number
    comment_id: number
    company_name: string
    responder_name: string | null
    reply_content: string
    status: string
    created_at: string
  }>
  flash?: { type: 'success' | 'error'; message: string }
}

export function renderCompanyRepliesAdminPage(props: CompanyRepliesPageProps): string {
  const userMenuHtml = props.userMenuHtml || ''
  const rows = props.replies.map(r => `
    <tr>
      <td><code>#${r.id}</code></td>
      <td><a href="#" class="text-blue-300 hover:underline">댓글 #${r.comment_id}</a></td>
      <td><strong>${escapeHtml(r.company_name)}</strong>${r.responder_name ? '<br><span style="font-size:0.78rem; color:#94a3b8;">' + escapeHtml(r.responder_name) + '</span>' : ''}</td>
      <td style="max-width:420px; word-break:break-word; white-space:pre-wrap;">${escapeHtml(r.reply_content).slice(0, 400)}${r.reply_content.length > 400 ? '…' : ''}</td>
      <td><span class="pill" style="${r.status === 'pending' ? 'background:rgba(251,191,36,0.18); color:#fde047;' : r.status === 'approved' ? 'background:rgba(52,211,153,0.18); color:#86efac;' : 'background:rgba(248,113,113,0.18); color:#fca5a5;'}">${escapeHtml(r.status)}</span></td>
      <td style="font-size:0.78rem; color:#94a3b8;">${escapeHtml(r.created_at)}</td>
      <td>
        ${r.status === 'pending' ? `
        <form method="POST" action="/admin/company-replies/${r.id}/decide" class="btn-row">
          <button class="btn btn-keep" name="status" value="approved" type="submit">승인</button>
          <button class="btn btn-delete" name="status" value="rejected" type="submit">거부</button>
        </form>` : '-'}
      </td>
    </tr>
  `).join('')

  return `<!DOCTYPE html>
<html lang="ko"><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회사 답글 승인 | Careerwiki Admin</title>
  ${SHARED_HEAD}
  ${renderNavStyles()}
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}
  <main class="max-w-[1400px] mx-auto px-3 md:px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-6">
      <p class="text-xs text-emerald-300 font-semibold uppercase tracking-[0.2em]">관리자 — 회사 답글</p>
      <h1 class="text-3xl font-bold text-white mt-2">회사 답글 승인</h1>
      <p class="text-wiki-muted mt-2 text-sm">Glassdoor 모델 — 정책 <a href="/policy/community#company-review" class="text-blue-300 hover:underline">community §6-B</a>. 댓글당 1회 답글 가능, 운영자 신원 검증 후 승인.</p>
    </header>
    ${flashHtml(props.flash)}
    <section class="glass-card rounded-2xl p-5 md:p-6">
      <div style="overflow-x:auto;">
        <table class="ops-table">
          <thead><tr><th>ID</th><th>댓글</th><th>회사·응답자</th><th>답글</th><th>상태</th><th>접수</th><th>결정</th></tr></thead>
          <tbody>${rows || '<tr><td colspan="7" style="text-align:center; padding:30px; color:#94a3b8;">대기 중인 회사 답글이 없습니다.</td></tr>'}</tbody>
        </table>
      </div>
    </section>
  </main>
  ${renderNavScripts()}
  ${renderFooter()}
</body></html>`
}

function escapeHtml(text: string | null | undefined): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text ?? '').replace(/[&<>"']/g, (m) => map[m])
}
