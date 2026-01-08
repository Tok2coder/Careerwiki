import { renderAdminLayout } from './adminLayout'
import { escapeHtml } from '../detailTemplateUtils'

export interface AdminFeedbackItem {
  id: number
  title: string
  body: string
  type: string
  status: string
  is_private: boolean
  created_at: number
  user_id: number
  link_url?: string | null
  has_admin_comment?: boolean
  reply: {
    body: string
    admin_id: number
    created_at: number
  } | null
}

export interface AdminFeedbackPageProps {
  page: number
  total: number
  pageSize: number
  items: AdminFeedbackItem[]
}

const TYPE_LABEL: Record<string, string> = {
  bug: '버그',
  suggestion: '기능건의',
  question: '질문',
  other: '기타',
}

export function renderAdminFeedbackPage(props: AdminFeedbackPageProps): string {
  const { page, total, pageSize, items } = props
  const totalPages = Math.max(1, Math.ceil(total / pageSize))

  const rows = items
    .map((f) => {
      const hasAdmin = Boolean(f.reply || f.has_admin_comment)
      const replyBadge = hasAdmin
        ? '<span class="px-2 py-1 rounded text-[11px] bg-emerald-600/30 text-emerald-100">답변 완료</span>'
        : '<span class="px-2 py-1 rounded text-[11px] bg-slate-700 text-slate-200">미답변</span>'
      return `
        <tr class="border-b border-slate-800/60 hover:bg-slate-800/40 cursor-pointer min-h-[56px]" onclick="location.href='/admin/feedback/${f.id}'">
          <td class="p-3 align-top text-sm text-slate-300">
            <div class="font-semibold text-white">${escapeHtml(f.title)}</div>
            <div class="text-xs text-slate-400 mt-1">#${f.id} · user_${f.user_id}</div>
            ${f.link_url ? `<span class="text-[11px] text-blue-300">링크 있음</span>` : ''}
            <div class="sm:hidden mt-1 flex flex-wrap gap-1">
              <span class="px-2 py-0.5 rounded text-[11px] bg-slate-700/70">${TYPE_LABEL[f.type] || f.type}</span>
              ${replyBadge}
            </div>
          </td>
          <td class="p-3 align-top text-xs text-slate-300 hidden sm:table-cell">
            <div class="px-2 py-1 rounded inline-flex items-center gap-2 bg-slate-700/70">${TYPE_LABEL[f.type] || f.type}</div>
          </td>
          <td class="p-3 align-top text-xs">
            <span class="px-2 py-1 rounded inline-flex items-center gap-2 ${f.status === 'closed' ? 'bg-slate-700 text-slate-200' : 'bg-emerald-700/50 text-emerald-100'}">${f.status.toUpperCase()}</span>
            ${f.is_private ? '<div class="text-[11px] text-pink-200 mt-1">관리자 전용</div>' : ''}
          </td>
          <td class="p-3 align-top text-xs hidden sm:table-cell">
            ${replyBadge}
          </td>
          <td class="p-3 align-top text-xs text-slate-400 hidden md:table-cell">${formatDate(f.created_at)}</td>
        </tr>
      `
    })
    .join('')

  const pagination = `
    <div class="flex flex-col sm:flex-row items-center justify-between text-sm text-slate-300 mt-4 gap-3">
      <span>총 ${total}건 · 페이지 ${page}/${totalPages}</span>
      <div class="flex gap-2">
        <a class="min-w-[44px] min-h-[44px] px-4 py-2 flex items-center justify-center rounded bg-slate-800 border border-slate-700 ${page <= 1 ? 'opacity-50 pointer-events-none' : ''}" href="/admin/feedback?page=${Math.max(1, page - 1)}">이전</a>
        <a class="min-w-[44px] min-h-[44px] px-4 py-2 flex items-center justify-center rounded bg-slate-800 border border-slate-700 ${page >= totalPages ? 'opacity-50 pointer-events-none' : ''}" href="/admin/feedback?page=${Math.min(totalPages, page + 1)}">다음</a>
      </div>
    </div>
  `

  const content = `
    <div class="space-y-6">
      <header class="flex items-center justify-between">
        <div>
          <p class="text-xs text-slate-400 uppercase tracking-[0.2em]">Admin</p>
          <h1 class="text-2xl font-bold text-white">피드백 관리</h1>
        </div>
        <span class="text-sm text-slate-400">피드백을 클릭하여 상세 내용을 확인하세요.</span>
      </header>

      <div class="glass-card rounded-xl border border-slate-700/50 overflow-x-auto">
        <table class="min-w-full text-left">
          <thead class="bg-slate-900/60 text-xs text-slate-400">
            <tr>
              <th class="p-3">제목/작성자</th>
              <th class="p-3 hidden sm:table-cell">유형</th>
              <th class="p-3">상태</th>
              <th class="p-3 hidden sm:table-cell">답변</th>
              <th class="p-3 hidden md:table-cell">작성일</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-800">
            ${rows || '<tr><td colspan="5" class="p-4 text-center text-slate-400">피드백이 없습니다.</td></tr>'}
          </tbody>
        </table>
      </div>
      ${pagination}
    </div>
  `

  return renderAdminLayout({
    title: '피드백 관리',
    currentPath: '/admin/feedback',
    children: content,
  })
}

function formatDate(ts: number): string {
  if (!ts) return ''
  try {
    return new Date(ts * 1000).toLocaleString('ko-KR', { dateStyle: 'medium', timeStyle: 'short' })
  } catch {
    return ''
  }
}
