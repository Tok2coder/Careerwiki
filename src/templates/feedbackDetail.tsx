/**
 * 피드백 상세 페이지 (공개용)
 * - 피드백 내용
 * - 댓글 스레드 (관리자 답변 + 사용자 답글)
 */

import type { FeedbackComment } from '../services/feedbackService'
import { renderNav, renderNavStyles, renderNavScripts } from './partials/nav'

export interface FeedbackDetailPost {
  id: number
  user_id: number
  title: string
  body: string
  type: string
  status: string
  is_private: boolean
  link_url: string | null
  created_at: number
  last_activity_at: number
  author_name: string
  author_picture: string | null
}

export interface FeedbackDetailPageProps {
  userMenuHtml: string
  isLoggedIn: boolean
  currentUserId?: number
  isAdmin: boolean
  post: FeedbackDetailPost
  comments: FeedbackComment[]
  hasAdminComment?: boolean
}

const TYPE_LABEL: Record<string, string> = {
  bug: '버그',
  suggestion: '기능건의',
  question: '질문',
  other: '기타',
}

export function renderFeedbackDetailPage(props: FeedbackDetailPageProps): string {
  const { userMenuHtml, isLoggedIn, currentUserId, isAdmin, post, comments } = props

  const typeBadge = `<span class="px-2 py-1 rounded-full text-xs bg-wiki-card border border-wiki-border text-wiki-muted">${TYPE_LABEL[post.type] || post.type}</span>`
  const statusBadge = post.status === 'closed'
    ? `<span class="px-2 py-1 rounded-full text-xs bg-slate-600/30 text-slate-300 border border-slate-500/30">종료됨</span>`
    : `<span class="px-2 py-1 rounded-full text-xs bg-emerald-500/20 text-emerald-300 border border-emerald-500/30">진행 중</span>`
  const privateBadge = post.is_private
    ? `<span class="px-2 py-1 rounded-full text-xs bg-pink-500/15 text-pink-200 border border-pink-500/30">비공개</span>`
    : ''

  const isAuthor = currentUserId === post.user_id

  // 댓글 렌더링
  const commentsHtml = comments.length > 0
    ? comments.map((c) => {
        const isCommentAuthor = currentUserId === c.user_id
        const canDelete = isAdmin || isCommentAuthor
        const adminLabel = c.is_admin
          ? `<span class="ml-2 px-2 py-0.5 rounded text-[10px] bg-blue-500/20 text-blue-300 border border-blue-500/30">관리자</span>`
          : ''
        const authorLabel = c.user_id === post.user_id
          ? `<span class="ml-2 px-2 py-0.5 rounded text-[10px] bg-emerald-500/20 text-emerald-300 border border-emerald-500/30">작성자</span>`
          : ''

        return `
          <div class="p-4 sm:p-5 rounded-lg ${c.is_admin ? 'bg-blue-900/10 border border-blue-500/20' : 'bg-wiki-card/50 border border-wiki-border/50'}">
            <div class="flex items-start sm:items-center justify-between mb-3 gap-2">
              <div class="flex items-center gap-2 flex-wrap">
                ${c.user_picture ? `<img src="${escapeHtml(c.user_picture)}" class="w-7 h-7 rounded-full">` : '<div class="w-7 h-7 rounded-full bg-wiki-muted/20 flex items-center justify-center"><i class="fas fa-user text-xs text-wiki-muted"></i></div>'}
                <span class="text-[15px] font-medium text-wiki-text">${escapeHtml(c.user_name || `user_${c.user_id}`)}</span>
                ${adminLabel}${authorLabel}
              </div>
              <div class="flex items-center gap-3 flex-shrink-0">
                <span class="text-[13px] text-wiki-muted">${formatDate(c.created_at)}</span>
                ${canDelete ? `<button data-delete-comment="${c.id}" class="w-9 h-9 min-w-[36px] min-h-[36px] flex items-center justify-center text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-lg transition"><i class="fas fa-trash text-sm"></i></button>` : ''}
              </div>
            </div>
            <div class="text-[15px] text-wiki-text whitespace-pre-wrap leading-relaxed">${escapeHtml(c.body)}</div>
          </div>
        `
      }).join('')
    : `<div class="text-center py-8 text-wiki-muted">아직 댓글이 없습니다.</div>`

  // 댓글 입력 폼 (로그인 필수, 종료된 피드백은 불가)
  const commentFormHtml = post.status === 'closed'
    ? `<div class="text-center py-6 text-wiki-muted text-[15px]">종료된 피드백에는 댓글을 달 수 없습니다.</div>`
    : isLoggedIn
      ? `
        <form id="comment-form" class="space-y-4">
          <textarea
            name="body"
            rows="4"
            required
            minlength="3"
            maxlength="2000"
            class="w-full px-4 py-3 rounded-lg bg-wiki-bg border border-wiki-border text-wiki-text text-[16px] placeholder-wiki-muted resize-none focus:border-wiki-primary focus:ring-1 focus:ring-wiki-primary outline-none transition-colors leading-relaxed"
            placeholder="댓글을 입력하세요..."
          ></textarea>
          <div class="flex justify-end">
            <button type="submit" class="px-5 py-3 min-h-[48px] rounded-lg bg-gradient-to-r from-blue-500 to-indigo-500 text-white text-[15px] font-semibold hover:opacity-90 transition">
              댓글 작성
            </button>
          </div>
        </form>
      `
      : `<div class="text-center py-6 text-wiki-muted text-[15px]">댓글을 작성하려면 <a href="/login" class="text-blue-400 hover:text-blue-300 font-semibold">로그인</a>이 필요합니다.</div>`

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${escapeHtml(post.title)} - 피드백 | Careerwiki</title>
  <meta name="robots" content="noindex, nofollow">
  <link href="/static/style.css" rel="stylesheet" />
  <link rel="stylesheet" href="/static/tailwind.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  ${renderNavStyles()}
  <style>
    body { background-color: #0b1220; color: #dee3ff; }
    .glass-card {
      background: rgba(26, 26, 46, 0.8);
      border: 1px solid rgba(67, 97, 238, 0.2);
      backdrop-filter: blur(12px);
    }
  </style>
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}

  <main class="max-w-[1400px] mx-auto px-4 pt-20 pb-10 sm:pt-12">
    <div class="max-w-4xl mx-auto">
    <!-- 뒤로가기 -->
    <div class="mb-6">
      <a href="/feedback" class="inline-flex items-center gap-2 px-3 py-2 min-h-[44px] text-wiki-muted hover:text-white hover:bg-wiki-card/50 rounded-lg transition-colors text-[15px]">
        <i class="fas fa-arrow-left"></i>
        <span>피드백 목록</span>
      </a>
    </div>

    <!-- 피드백 본문 -->
    <article class="glass-card rounded-xl border border-wiki-border/60 p-6 mb-6">
      <header class="mb-4">
        <div class="flex flex-wrap items-center gap-2 mb-3">
          ${typeBadge}
          ${statusBadge}
          ${privateBadge}
        </div>
        <h1 class="text-2xl font-bold text-white mb-2">${escapeHtml(post.title)}</h1>
        <div class="flex flex-col gap-1 text-sm text-wiki-muted">
          <div class="flex items-center gap-3 flex-wrap">
            <div class="flex items-center gap-2">
              ${post.author_picture ? `<img src="${escapeHtml(post.author_picture)}" class="w-5 h-5 rounded-full">` : ''}
              <span>${escapeHtml(post.author_name)}</span>
            </div>
            <span>·</span>
            <span>${formatDate(post.created_at)}</span>
          </div>
          ${post.link_url ? `
            <div class="flex items-center gap-2 text-xs text-wiki-text">
              <span class="px-2 py-1 rounded bg-wiki-card border border-wiki-border/60 text-wiki-muted">관련 링크</span>
              <span class="font-mono text-[12px] text-wiki-text break-all">${escapeHtml(post.link_url)}</span>
            </div>
          ` : ''}
        </div>
      </header>
      <div class="text-wiki-text whitespace-pre-wrap leading-relaxed">${escapeHtml(post.body)}</div>
    </article>

    <!-- 댓글 섹션 -->
    <section class="glass-card rounded-xl border border-wiki-border/60 p-6">
      <h2 class="text-lg font-semibold text-white mb-4">
        <i class="fas fa-comments mr-2 text-wiki-muted"></i>댓글 <span class="text-wiki-muted font-normal">(${comments.length})</span>
      </h2>

      <!-- 댓글 목록 -->
      <div class="space-y-3 mb-6">
        ${commentsHtml}
      </div>

      <!-- 댓글 입력 -->
      ${commentFormHtml}
    </section>
    </div>
  </main>

  <!-- Toast 컨테이너 -->
  <div id="toastContainer" class="fixed bottom-4 right-4 z-50 space-y-2"></div>

  <script>
    function showToast(message, type) {
      type = type || 'info';
      var container = document.getElementById('toastContainer');
      var toast = document.createElement('div');
      var bgClass = type === 'success' ? 'bg-green-600' : type === 'error' ? 'bg-red-600' : 'bg-blue-600';
      var icon = type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle';
      toast.className = bgClass + ' text-white px-4 py-3 rounded-lg shadow-lg flex items-center gap-2';
      var span = document.createElement('span');
      span.textContent = message;
      toast.innerHTML = '<i class="fas fa-' + icon + '"></i>';
      toast.appendChild(span);
      container.appendChild(toast);
      setTimeout(function() { toast.remove(); }, 3000);
    }

    // 댓글 작성
    var form = document.getElementById('comment-form');
    if (form) {
      form.addEventListener('submit', async function(e) {
        e.preventDefault();
        var textarea = form.querySelector('textarea[name="body"]');
        var body = textarea.value.trim();
        if (body.length < 3) {
          showToast('댓글은 3자 이상 입력해 주세요.', 'error');
          return;
        }

        var btn = form.querySelector('button[type="submit"]');
        btn.disabled = true;
        btn.textContent = '작성 중...';

        try {
          var res = await fetch('/api/feedback/${post.id}/comments', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ body: body }),
            credentials: 'same-origin'
          });
          var json = await res.json();
          if (!res.ok || json.success === false) {
            showToast(json.error || '댓글 작성에 실패했습니다.', 'error');
            btn.disabled = false;
            btn.textContent = '댓글 작성';
            return;
          }
          showToast('댓글이 작성되었습니다.', 'success');
          setTimeout(function() { location.reload(); }, 500);
        } catch (err) {
          showToast('댓글 작성에 실패했습니다.', 'error');
          btn.disabled = false;
          btn.textContent = '댓글 작성';
        }
      });
    }

    // 댓글 삭제
    document.querySelectorAll('[data-delete-comment]').forEach(function(btn) {
      btn.addEventListener('click', async function() {
        var commentId = btn.getAttribute('data-delete-comment');
        if (!confirm('댓글을 삭제하시겠습니까?')) return;

        try {
          var res = await fetch('/api/feedback/comments/' + commentId, {
            method: 'DELETE',
            credentials: 'same-origin'
          });
          var json = await res.json();
          if (!res.ok || json.success === false) {
            showToast(json.error || '삭제에 실패했습니다.', 'error');
            return;
          }
          showToast('댓글이 삭제되었습니다.', 'success');
          setTimeout(function() { location.reload(); }, 500);
        } catch (err) {
          showToast('삭제에 실패했습니다.', 'error');
        }
      });
    });
  </script>

  ${renderNavScripts()}
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
    return new Date(ts * 1000).toLocaleString('ko-KR', { dateStyle: 'medium', timeStyle: 'short' })
  } catch {
    return ''
  }
}

