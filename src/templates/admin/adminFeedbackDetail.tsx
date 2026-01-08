import { renderAdminLayout } from './adminLayout'
import { escapeHtml } from '../detailTemplateUtils'
import type { FeedbackComment } from '../../services/feedbackService'

export interface AdminFeedbackDetailItem {
  id: number
  title: string
  body: string
  type: string
  status: string
  is_private: boolean
  created_at: number
  user_id: number
  link_url?: string | null
  last_activity_at?: number
  author_name?: string
  author_picture?: string | null
}

export interface AdminFeedbackDetailProps {
  feedback: AdminFeedbackDetailItem
  comments: FeedbackComment[]
  hasAdminComment: boolean
}

const TYPE_LABEL: Record<string, string> = {
  bug: '버그',
  suggestion: '기능건의',
  question: '질문',
  other: '기타',
}

export function renderAdminFeedbackDetail(props: AdminFeedbackDetailProps): string {
  const { feedback: f, comments, hasAdminComment } = props

  // 댓글 렌더링
  const commentsHtml = comments.length > 0
    ? comments.map((c) => {
        const adminLabel = c.is_admin
          ? `<span class="ml-2 px-2 py-0.5 rounded text-[10px] bg-blue-500/20 text-blue-300 border border-blue-500/30">관리자</span>`
          : ''
        const authorLabel = c.user_id === f.user_id
          ? `<span class="ml-2 px-2 py-0.5 rounded text-[10px] bg-emerald-500/20 text-emerald-300 border border-emerald-500/30">작성자</span>`
          : ''

        return `
          <div class="p-4 rounded-lg ${c.is_admin ? 'bg-blue-900/20 border border-blue-500/30' : 'bg-slate-800/50 border border-slate-700/50'}">
            <div class="flex items-center justify-between mb-2">
              <div class="flex items-center gap-2">
                ${c.user_picture ? `<img src="${escapeHtml(c.user_picture)}" class="w-6 h-6 rounded-full">` : '<div class="w-6 h-6 rounded-full bg-slate-700 flex items-center justify-center"><i class="fas fa-user text-xs text-slate-500"></i></div>'}
                <span class="text-sm font-medium text-white">${escapeHtml(c.user_name || `user_${c.user_id}`)}</span>
                ${adminLabel}${authorLabel}
              </div>
              <div class="flex items-center gap-2">
                <span class="text-xs text-slate-400">${formatDate(c.created_at)}</span>
                <button data-delete-comment="${c.id}" class="text-xs text-red-400 hover:text-red-300"><i class="fas fa-trash"></i></button>
              </div>
            </div>
            <div class="text-sm text-slate-200 whitespace-pre-wrap">${escapeHtml(c.body)}</div>
          </div>
        `
      }).join('')
    : `<div class="text-center py-8 text-slate-400">아직 댓글이 없습니다.</div>`

  // 댓글 입력 폼 (종료된 피드백도 관리자는 댓글 가능)
  const commentFormHtml = `
    <form id="comment-form" class="space-y-3">
      <textarea
        name="body"
        rows="3"
        required
        minlength="3"
        maxlength="2000"
        class="w-full p-3 bg-slate-900 border border-slate-700 rounded-lg text-sm text-slate-100 placeholder-slate-400 resize-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 outline-none transition-colors"
        placeholder="관리자 댓글을 입력하세요..."
      ></textarea>
      <div class="flex justify-end">
        <button type="submit" class="px-4 py-2 rounded-lg bg-blue-600 hover:bg-blue-500 text-white text-sm font-semibold transition-colors">
          댓글 작성
        </button>
      </div>
    </form>
  `

  const content = `
    <!-- 뒤로가기 -->
    <div class="mb-6">
      <a href="/admin/feedback" class="text-slate-400 hover:text-white transition-colors">
        <i class="fas fa-arrow-left mr-2"></i>피드백 목록
      </a>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <!-- 왼쪽: 피드백 정보 -->
      <div class="lg:col-span-1 space-y-6">
        <!-- 기본 정보 카드 -->
        <div class="glass-card rounded-xl p-6">
          <div class="mb-6">
            <p class="text-xs text-slate-400 uppercase tracking-wider mb-2">피드백 정보</p>
            <h2 class="text-xl font-bold text-white break-words">${escapeHtml(f.title)}</h2>
          </div>
          <div class="space-y-3 text-sm">
            <div class="flex justify-between">
              <span class="text-slate-400">ID</span>
              <span class="text-white font-mono">#${f.id}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">작성자</span>
              <a href="/admin/users/${f.user_id}" class="text-blue-400 hover:text-blue-300">${escapeHtml(f.author_name || `user_${f.user_id}`)}</a>
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">유형</span>
              <span class="px-2 py-0.5 rounded text-xs bg-slate-700/70 text-slate-200">${TYPE_LABEL[f.type] || f.type}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">상태</span>
              <span id="status-badge" class="px-2 py-0.5 rounded text-xs ${f.status === 'closed' ? 'bg-slate-700 text-slate-200' : 'bg-emerald-700/50 text-emerald-100'}">${f.status.toUpperCase()}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">답변 여부</span>
              ${hasAdminComment
                ? '<span class="px-2 py-0.5 rounded text-xs bg-emerald-600/30 text-emerald-100">답변 완료</span>'
                : '<span class="px-2 py-0.5 rounded text-xs bg-slate-700 text-slate-200">미답변</span>'
              }
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">공개 여부</span>
              ${f.is_private
                ? '<span class="px-2 py-0.5 rounded text-xs bg-pink-700/40 text-pink-100">비공개</span>'
                : '<span class="text-slate-200">공개</span>'
              }
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">작성일</span>
              <span class="text-white">${formatDate(f.created_at)}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">마지막 활동</span>
              <span class="text-white">${formatDate(f.last_activity_at || f.created_at)}</span>
            </div>
            ${f.link_url ? `
              <div class="flex justify-between items-start gap-2">
                <span class="text-slate-400">관련 링크</span>
                <span class="text-xs text-slate-200 font-mono break-all max-w-[220px]">${escapeHtml(f.link_url)}</span>
              </div>
            ` : ''}
          </div>
        </div>

        <!-- 관리 카드 -->
        <div class="glass-card rounded-xl p-6">
          <h3 class="text-lg font-semibold text-white mb-4">
            <i class="fas fa-cog mr-2 text-slate-300"></i>관리
          </h3>
          <div class="space-y-4">
            <div class="space-y-2">
              <label class="block text-sm text-slate-300">상태 변경</label>
              <div class="flex items-center gap-3">
                <select
                  id="status-select"
                  class="px-3 py-2 bg-slate-800 border border-slate-700 rounded-lg text-sm text-white"
                >
                  <option value="open" ${f.status === 'open' ? 'selected' : ''}>OPEN (진행 중)</option>
                  <option value="closed" ${f.status === 'closed' ? 'selected' : ''}>CLOSED (종료)</option>
                </select>
                <button
                  id="save-status"
                  data-id="${f.id}"
                  class="px-4 py-2 bg-slate-700 hover:bg-slate-600 rounded-lg text-white text-sm transition-colors"
                >
                  저장
                </button>
              </div>
            </div>
            <button
              id="delete-feedback"
              data-id="${f.id}"
              class="w-full py-2 bg-red-600 hover:bg-red-500 rounded text-white text-sm transition-colors"
            >
              <i class="fas fa-trash mr-2"></i>피드백 삭제
            </button>
          </div>
        </div>
      </div>

      <!-- 오른쪽: 내용 + 댓글 스레드 -->
      <div class="lg:col-span-2 space-y-6">
        <!-- 피드백 내용 -->
        <div class="glass-card rounded-xl p-6">
          <h3 class="text-lg font-semibold text-white mb-4">
            <i class="fas fa-comment-alt mr-2 text-slate-300"></i>피드백 내용
          </h3>
          <div class="p-4 rounded-lg bg-slate-900/60 border border-slate-800 text-slate-200 whitespace-pre-wrap">${escapeHtml(f.body)}</div>
        </div>

        <!-- 댓글 스레드 -->
        <div class="glass-card rounded-xl p-6">
          <h3 class="text-lg font-semibold text-white mb-4">
            <i class="fas fa-comments mr-2 text-slate-300"></i>댓글 <span class="text-slate-400 font-normal">(${comments.length})</span>
          </h3>

          <!-- 댓글 목록 -->
          <div class="space-y-3 mb-6">
            ${commentsHtml}
          </div>

          <!-- 댓글 입력 -->
          ${commentFormHtml}
        </div>
      </div>
    </div>

    <!-- Toast 컨테이너 -->
    <div id="toastContainer" class="fixed bottom-4 right-4 z-50 space-y-2"></div>

    <script>
      function showToast(message, type) {
        type = type || 'info';
        var container = document.getElementById('toastContainer');
        var toast = document.createElement('div');
        var bgClass = type === 'success' ? 'bg-green-600' : type === 'error' ? 'bg-red-600' : 'bg-blue-600';
        var icon = type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle';
        toast.className = bgClass + ' text-white px-4 py-3 rounded-lg shadow-lg flex items-center gap-2 animate-slide-up';
        toast.innerHTML = '<i class="fas fa-' + icon + '"></i><span>' + message + '</span>';
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
            var res = await fetch('/api/feedback/${f.id}/comments', {
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
          if (!confirm('이 댓글을 삭제하시겠습니까?')) return;

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

      // 피드백 삭제
      var deleteBtn = document.getElementById('delete-feedback');
      if (deleteBtn) {
        deleteBtn.addEventListener('click', async function() {
          var id = deleteBtn.getAttribute('data-id');
          if (!id) return;
          if (!confirm('이 피드백을 삭제하시겠습니까?\\n삭제된 피드백은 복구할 수 없습니다.')) return;

          try {
            var res = await fetch('/api/admin/feedback/' + id, {
              method: 'DELETE',
              credentials: 'same-origin'
            });
            var json = await res.json();
            if (!res.ok || json.success === false) {
              showToast(json.error || '삭제에 실패했습니다.', 'error');
              return;
            }
            showToast('피드백이 삭제되었습니다.', 'success');
            setTimeout(function() { location.href = '/admin/feedback'; }, 1000);
          } catch (e) {
            showToast('삭제에 실패했습니다.', 'error');
          }
        });
      }

      // 상태 저장
      var statusBtn = document.getElementById('save-status');
      if (statusBtn) {
        statusBtn.addEventListener('click', async function() {
          var id = statusBtn.getAttribute('data-id');
          var select = document.getElementById('status-select');
          if (!id || !(select instanceof HTMLSelectElement)) return;
          var status = select.value;
          if (!status) return;

          var originalText = statusBtn.textContent;
          statusBtn.textContent = '저장 중...';
          statusBtn.disabled = true;
          statusBtn.classList.add('opacity-50');

          try {
            var res = await fetch('/api/admin/feedback/' + id + '/status', {
              method: 'PATCH',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ status: status }),
              credentials: 'same-origin'
            });
            var json = await res.json();
            if (!res.ok || json.success === false) {
              showToast(json.error || '상태 변경에 실패했습니다.', 'error');
              statusBtn.textContent = originalText;
              statusBtn.disabled = false;
              statusBtn.classList.remove('opacity-50');
              return;
            }
            showToast('상태가 업데이트되었습니다.', 'success');
            var badge = document.getElementById('status-badge');
            if (badge) {
              badge.textContent = status.toUpperCase();
              badge.className = 'px-2 py-1 rounded text-xs ' + (status === 'closed' ? 'bg-slate-700 text-slate-200' : 'bg-emerald-700/50 text-emerald-100');
            }
            statusBtn.textContent = originalText;
            statusBtn.disabled = false;
            statusBtn.classList.remove('opacity-50');
          } catch (e) {
            showToast('상태 변경 중 오류가 발생했습니다.', 'error');
            statusBtn.textContent = originalText;
            statusBtn.disabled = false;
            statusBtn.classList.remove('opacity-50');
          }
        });
      }
    </script>

    <style>
      @keyframes slide-up {
        from { transform: translateY(20px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
      }
      .animate-slide-up { animation: slide-up 0.3s ease-out; }
    </style>
  `

  return renderAdminLayout({
    title: `피드백 상세 - #${f.id}`,
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
