import { renderNav, renderNavStyles, renderNavScripts } from './partials/nav'

export type FeedbackListItem = {
  id: number
  user_id: number
  title: string
  body: string
  link_url: string | null
  is_private: boolean
  type: string
  status: string
  created_at: number
  comment_count: number
  author_name: string
  author_picture: string | null
}

type FeedbackPageOptions = {
  userMenuHtml?: string
  isLoggedIn?: boolean
  isAdmin?: boolean
  posts?: FeedbackListItem[]
  page?: number
  total?: number
  pageSize?: number
}

const TYPE_LABEL: Record<string, string> = {
  bug: '버그',
  suggestion: '기능건의',
  question: '질문',
  other: '기타',
}

export function renderFeedbackPage(options?: FeedbackPageOptions): string {
  const userMenuHtml = options?.userMenuHtml || ''
  const isLoggedIn = options?.isLoggedIn ?? false
  const posts = options?.posts || []
  const page = options?.page || 1
  const total = options?.total || 0
  const pageSize = options?.pageSize || 20
  const totalPages = Math.max(1, Math.ceil(total / pageSize))

  const startIndex = (page - 1) * pageSize
  const listRows = posts.length === 0
    ? `<tr><td colspan="6" class="p-8 text-center text-wiki-muted">등록된 피드백이 없습니다.</td></tr>`
    : posts.map((p, idx) => {
        const typeBadge = p.type === 'bug'
          ? 'bg-red-500/15 text-red-300 border-red-500/30'
          : p.type === 'question'
            ? 'bg-amber-500/15 text-amber-200 border-amber-500/30'
            : 'bg-blue-500/15 text-blue-200 border-blue-500/30'
        const statusBadge = p.status === 'closed'
          ? 'bg-slate-500/15 text-slate-300 border-slate-500/30'
          : 'bg-emerald-500/15 text-emerald-300 border-emerald-500/30'
        const privateBadge = p.is_private
          ? `<span class="ml-2 px-1.5 py-0.5 rounded text-[10px] bg-pink-500/15 text-pink-200 border border-pink-500/30">비공개</span>`
          : ''

        const displayNo = Math.max(1, total - (startIndex + idx))

        return `
          <tr class="border-b border-wiki-border/40 hover:bg-wiki-card/50 cursor-pointer transition-colors" onclick="location.href='/feedback/${p.id}'">
            <td class="p-3 sm:p-4 text-sm text-wiki-muted w-12 text-center hidden sm:table-cell">${displayNo}</td>
            <td class="p-3 sm:p-4">
              <span class="px-2.5 py-1.5 rounded text-xs border ${typeBadge}">${TYPE_LABEL[p.type] || p.type}</span>
            </td>
            <td class="p-3 sm:p-4">
              <div class="flex flex-col sm:flex-row sm:items-center gap-1.5 sm:gap-2">
                <span class="text-wiki-text text-[15px] sm:text-base font-medium hover:text-wiki-primary line-clamp-2">${escapeHtml(p.title)}</span>
                <span class="flex items-center gap-2 flex-shrink-0">
                  ${p.comment_count > 0 ? `<span class="text-xs text-wiki-primary font-medium">[${p.comment_count}]</span>` : ''}
                  ${privateBadge}
                </span>
                <span class="text-[13px] text-wiki-muted sm:hidden mt-1">${escapeHtml(p.author_name)} · ${formatDate(p.created_at)}</span>
              </div>
            </td>
            <td class="p-3 sm:p-4 text-sm text-wiki-muted hidden md:table-cell">${escapeHtml(p.author_name)}</td>
            <td class="p-3 sm:p-4 text-sm text-wiki-muted hidden md:table-cell">${formatDate(p.created_at)}</td>
            <td class="p-3 sm:p-4 text-center hidden sm:table-cell">
              <span class="inline-block px-2.5 py-1.5 rounded text-xs border ${statusBadge}">${p.status === 'closed' ? '종료' : '진행중'}</span>
            </td>
          </tr>
        `
      }).join('')

  const pagination = `
    <div class="flex flex-col sm:flex-row items-center justify-between text-sm text-wiki-muted mt-4 gap-3">
      <span>총 ${total}건 · 페이지 ${page}/${totalPages}</span>
      <div class="flex gap-2">
        <a class="px-4 py-2.5 min-h-[44px] min-w-[44px] flex items-center justify-center rounded bg-wiki-card border border-wiki-border ${page <= 1 ? 'opacity-50 pointer-events-none' : 'hover:bg-wiki-border/50'}" href="/feedback?page=${Math.max(1, page - 1)}">이전</a>
        <a class="px-4 py-2.5 min-h-[44px] min-w-[44px] flex items-center justify-center rounded bg-wiki-card border border-wiki-border ${page >= totalPages ? 'opacity-50 pointer-events-none' : 'hover:bg-wiki-border/50'}" href="/feedback?page=${Math.min(totalPages, page + 1)}">다음</a>
      </div>
    </div>
  `

  const formBlock = isLoggedIn
    ? `
      <form id="feedback-form" class="glass-card rounded-xl border border-wiki-border/60 p-4 sm:p-5 space-y-4">
        <div class="flex flex-col md:flex-row gap-4">
          <label class="flex-1 text-[16px] text-wiki-muted space-y-1.5">
            <span class="text-wiki-text font-semibold text-[16px]">제목</span>
            <input type="text" name="title" required class="w-full px-4 py-3 min-h-[48px] rounded-lg bg-wiki-bg border border-wiki-border text-wiki-text text-[16px]" placeholder="[버그] 또는 [제안]을 포함해 주세요" maxlength="120">
          </label>
          <label class="w-full md:w-40 text-[16px] text-wiki-muted space-y-1.5">
            <span class="text-wiki-text font-semibold text-[16px]">유형</span>
            <select name="type" class="w-full px-4 py-3 min-h-[48px] rounded-lg bg-wiki-bg border border-wiki-border text-wiki-text text-[16px]">
              <option value="bug">버그</option>
              <option value="suggestion">기능건의</option>
              <option value="question">질문</option>
              <option value="other">기타</option>
            </select>
          </label>
        </div>
        <label class="block text-[16px] text-wiki-muted space-y-1.5">
          <span class="text-wiki-text font-semibold text-[16px]">내용</span>
          <textarea name="body" rows="5" required class="w-full px-4 py-3 rounded-lg bg-wiki-bg border border-wiki-border text-wiki-text text-[16px] leading-relaxed" placeholder="재현 단계 / 기대 결과 / 실제 결과 또는 제안과 기대효과를 적어주세요." maxlength="4000"></textarea>
        </label>
        <label class="block text-[16px] text-wiki-muted space-y-1.5">
          <span class="text-wiki-text font-semibold text-[16px]">관련 링크 <span class="text-wiki-muted font-normal">(선택)</span></span>
          <input type="url" name="link_url" class="w-full px-4 py-3 min-h-[48px] rounded-lg bg-wiki-bg border border-wiki-border text-wiki-text text-[16px]" placeholder="https://careerwiki.org/job/..." maxlength="500">
        </label>
        <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 pt-2">
          <label class="text-[16px] text-wiki-muted inline-flex items-center gap-3 min-h-[48px] cursor-pointer">
            <input type="checkbox" class="h-6 w-6 rounded border-wiki-border" name="is_private">
            <span>관리자에게만 보이게 하기</span>
          </label>
          <button type="submit" class="w-full sm:w-auto px-6 py-3.5 min-h-[48px] rounded-lg bg-gradient-to-r from-blue-500 to-indigo-500 text-white text-base font-semibold hover:opacity-90 transition">피드백 작성</button>
        </div>
      </form>
    `
    : `
      <div class="glass-card rounded-xl border border-wiki-border/60 p-4 text-sm text-wiki-muted">
        피드백 작성은 <a href="/auth/google" data-login-link class="text-blue-400 hover:text-blue-300 font-semibold no-underline">로그인</a> 후 가능합니다.
      </div>
    `

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>피드백 게시판 | 직업위키</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            'wiki-bg': '#0a0a0f',
            'wiki-card': '#12121a',
            'wiki-border': '#2a2a3a',
            'wiki-text': '#e4e4e7',
            'wiki-muted': '#71717a',
            'wiki-primary': '#6366f1',
          }
        }
      }
    }
  </script>
  ${renderNavStyles()}
  <style>
    body { background-color: #0b1220; color: #dee3ff; }
    .glass-card { background: rgba(26, 26, 46, 0.8); border: 1px solid rgba(67, 97, 238, 0.2); backdrop-filter: blur(12px); }
  </style>
</head>
<body class="min-h-screen text-wiki-text">
  ${renderNav(userMenuHtml)}

  <main class="max-w-[1400px] mx-auto px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-8 space-y-3">
      <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
        <i class="fas fa-comments"></i><span>피드백</span>
      </div>
      <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <h1 class="text-3xl md:text-4xl font-bold text-white">피드백 게시판</h1>
        <p class="text-wiki-muted text-[15px] md:text-[15px]">버그 제보, 기능 건의, 질문을 남겨주세요. 14일간 활동이 없으면 자동 종료됩니다.</p>
      </div>
    </header>

    <!-- 피드백 작성 폼 -->
    <section class="mb-8">
      ${formBlock}
    </section>

    <!-- 피드백 목록 -->
    <section>
      <div class="glass-card rounded-xl border border-wiki-border/60 overflow-x-auto">
        <table class="min-w-full text-left">
          <thead class="bg-wiki-card/80 text-xs text-wiki-muted border-b border-wiki-border/60">
            <tr>
              <th class="p-3 w-14 text-center hidden sm:table-cell">번호</th>
              <th class="p-3 w-24">유형</th>
              <th class="p-3">제목</th>
              <th class="p-3 w-28 hidden md:table-cell">작성자</th>
              <th class="p-3 w-32 hidden md:table-cell">작성일</th>
              <th class="p-3 w-20 hidden sm:table-cell">상태</th>
            </tr>
          </thead>
          <tbody>
            ${listRows}
          </tbody>
        </table>
      </div>
      ${pagination}
    </section>
  </main>

  <!-- Toast -->
  <div id="toastContainer" class="fixed bottom-4 right-4 z-50 space-y-2"></div>

  ${renderNavScripts()}
  <script>
    function showToast(message, type) {
      type = type || 'info';
      var container = document.getElementById('toastContainer');
      var toast = document.createElement('div');
      var bgClass = type === 'success' ? 'bg-green-600' : type === 'error' ? 'bg-red-600' : 'bg-blue-600';
      toast.className = bgClass + ' text-white px-4 py-3 rounded-lg shadow-lg flex items-center gap-2';
      toast.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i><span>' + message + '</span>';
      container.appendChild(toast);
      setTimeout(function() { toast.remove(); }, 3000);
    }

    // 피드백 작성
    var form = document.getElementById('feedback-form');
    if (form) {
      form.addEventListener('submit', async function(e) {
        e.preventDefault();
        var data = new FormData(form);
        var linkUrl = (data.get('link_url') || '').trim();
        var payload = {
          title: data.get('title'),
          body: data.get('body'),
          type: data.get('type') || 'suggestion',
          link_url: linkUrl || null,
          is_private: data.get('is_private') === 'on',
        };
        if (!payload.title || !payload.body) {
          showToast('제목과 내용을 입력해주세요.', 'error');
          return;
        }

        var btn = form.querySelector('button[type="submit"]');
        btn.disabled = true;
        btn.textContent = '작성 중...';

        try {
          var res = await fetch('/api/feedback', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload),
            credentials: 'same-origin'
          });
          var json = await res.json();
          if (!res.ok || json.success === false) {
            showToast(json.error || '작성에 실패했습니다.', 'error');
            btn.disabled = false;
            btn.textContent = '피드백 작성';
            return;
          }
          showToast('피드백이 등록되었습니다.', 'success');
          setTimeout(function() { location.href = '/feedback/' + json.data.id; }, 500);
        } catch (err) {
          showToast('작성에 실패했습니다.', 'error');
          btn.disabled = false;
          btn.textContent = '피드백 작성';
        }
      });
    }
  </script>
</body>
</html>`
}

function escapeHtml(text: string): string {
  if (!text) return ''
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
}

function formatDate(ts: number): string {
  if (!ts) return ''
  try {
    const d = new Date(ts * 1000)
    const now = new Date()

    const isSameDay =
      d.getFullYear() === now.getFullYear() &&
      d.getMonth() === now.getMonth() &&
      d.getDate() === now.getDate()

    if (isSameDay) {
      // 오늘 작성: 오전/오후 hh:mm
      return d.toLocaleTimeString('ko-KR', {
        hour: 'numeric',
        minute: '2-digit',
        hour12: true,
      })
    }

    // 오늘 이전: YYYY.MM.DD 또는 M월 D일
    return d.toLocaleDateString('ko-KR', { month: 'long', day: 'numeric' })
  } catch {
    return ''
  }
}
