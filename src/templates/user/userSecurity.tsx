/**
 * 보안 설정 페이지 — 활성 세션 관리
 * 구글 계정의 "기기 관리"와 유사한 UI
 */

export function renderSecurityPage(): string {
  return `
    <div class="space-y-6">
      <!-- 세션 관리 섹션 -->
      <div class="bg-wiki-bg/50 p-4 sm:p-6 rounded-xl border border-wiki-border">
        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 mb-4">
          <div>
            <h2 class="text-lg sm:text-xl font-semibold text-wiki-text flex items-center gap-2">
              <i class="fas fa-shield-alt text-emerald-400"></i>
              로그인된 기기
            </h2>
            <p class="text-sm text-wiki-muted mt-1">현재 이 계정에 로그인된 기기 목록입니다.</p>
          </div>
          <button
            id="logoutOthersBtn"
            class="text-sm px-4 py-2.5 rounded-lg bg-red-500/10 text-red-400 hover:bg-red-500/20 transition hidden w-full sm:w-auto"
          >
            <i class="fas fa-sign-out-alt mr-1"></i>
            다른 기기 전체 로그아웃
          </button>
        </div>

        <!-- 로딩 -->
        <div id="sessionsLoading" class="flex items-center justify-center py-8">
          <div class="animate-spin w-6 h-6 border-2 border-wiki-primary border-t-transparent rounded-full"></div>
          <span class="ml-3 text-wiki-muted">세션 정보를 불러오는 중...</span>
        </div>

        <!-- 세션 목록 -->
        <div id="sessionsList" class="space-y-3 hidden"></div>

        <!-- 빈 상태 -->
        <div id="sessionsEmpty" class="text-center py-8 text-wiki-muted hidden">
          <i class="fas fa-info-circle text-2xl mb-2"></i>
          <p>활성 세션이 없습니다.</p>
        </div>
      </div>

      <!-- 안내 -->
      <div class="bg-wiki-bg/30 p-3 sm:p-4 rounded-xl border border-wiki-border/50">
        <h3 class="text-sm font-semibold text-wiki-muted mb-2">
          <i class="fas fa-info-circle mr-1"></i> 세션 안내
        </h3>
        <ul class="text-xs text-wiki-muted/70 space-y-1">
          <li>- 7일간 활동이 없으면 자동으로 로그아웃됩니다.</li>
          <li>- 활동 중에는 세션이 자동으로 연장됩니다 (최대 30일).</li>
          <li>- 의심스러운 기기가 있으면 해당 세션을 로그아웃하세요.</li>
        </ul>
      </div>
    </div>

    <script>
      (function() {
        const listEl = document.getElementById('sessionsList');
        const loadingEl = document.getElementById('sessionsLoading');
        const emptyEl = document.getElementById('sessionsEmpty');
        const logoutOthersBtn = document.getElementById('logoutOthersBtn');

        function hideLoading() {
          if (loadingEl) loadingEl.classList.add('hidden');
        }

        function showError(msg) {
          hideLoading();
          if (listEl) {
            listEl.classList.remove('hidden');
            listEl.innerHTML = '<p class="text-red-400 text-sm text-center py-4">' + (msg || '세션 정보를 불러오지 못했습니다.') + '</p>';
          }
        }

        async function loadSessions() {
          try {
            const res = await fetch('/api/user/sessions', { redirect: 'manual' });

            // requireAuth가 리다이렉트를 반환하면 세션 만료
            if (res.type === 'opaqueredirect' || res.status === 0 || (res.status >= 300 && res.status < 400)) {
              showError('세션이 만료되었습니다. 새로고침 후 다시 시도해주세요.');
              return;
            }

            if (!res.ok) throw new Error('HTTP ' + res.status);

            const contentType = res.headers.get('content-type') || '';
            if (!contentType.includes('application/json')) {
              throw new Error('Invalid response type');
            }

            const data = await res.json();
            const sessions = data.sessions;

            hideLoading();

            if (!sessions || sessions.length === 0) {
              if (emptyEl) emptyEl.classList.remove('hidden');
              return;
            }

            // 다른 기기가 있으면 전체 로그아웃 버튼 표시
            if (sessions.length > 1 && logoutOthersBtn) {
              logoutOthersBtn.classList.remove('hidden');
            }

            if (listEl) {
              listEl.classList.remove('hidden');
              listEl.innerHTML = sessions
                .sort((a, b) => (b.isCurrent ? 1 : 0) - (a.isCurrent ? 1 : 0) || b.lastActiveAt - a.lastActiveAt)
                .map(s => renderSession(s))
                .join('');
            }
          } catch (e) {
            showError();
          }
        }

        function renderSession(s) {
          const icon = getDeviceIcon(s.deviceLabel);
          const timeAgo = formatTimeAgo(s.lastActiveAt);
          const createdDate = new Date(s.createdAt * 1000).toLocaleDateString('ko-KR');

          return '<div class="session-card flex flex-col sm:flex-row sm:items-center gap-3 sm:gap-4 p-3 sm:p-4 rounded-xl border ' +
            (s.isCurrent ? 'border-emerald-500/30 bg-emerald-500/5' : 'border-wiki-border bg-wiki-bg/30') +
            '">' +
            '<div class="flex items-center gap-3">' +
            '<div class="w-10 h-10 shrink-0 rounded-full flex items-center justify-center text-lg ' +
            (s.isCurrent ? 'bg-emerald-500/20 text-emerald-400' : 'bg-wiki-bg text-wiki-muted') +
            '">' +
            '<i class="fas ' + icon + '"></i>' +
            '</div>' +
            '<div class="flex-1 min-w-0">' +
            '<div class="flex items-center gap-2 flex-wrap">' +
            '<span class="font-medium text-wiki-text text-sm">' + escapeHtml(s.deviceLabel) + '</span>' +
            (s.isCurrent ? '<span class="text-xs px-2 py-0.5 rounded-full bg-emerald-500/20 text-emerald-400 font-medium">이 기기</span>' : '') +
            '</div>' +
            '<div class="text-xs text-wiki-muted mt-0.5">' +
            'IP ' + escapeHtml(s.ip) + ' &middot; ' + timeAgo +
            ' &middot; 로그인: ' + createdDate +
            '</div>' +
            '</div>' +
            '</div>' +
            (s.isCurrent ? '' :
              '<button onclick="logoutSession(\\'' + s.tokenPrefix + '\\', this)" ' +
              'class="text-xs px-3 py-2 sm:py-1.5 rounded-lg bg-red-500/10 text-red-400 hover:bg-red-500/20 transition whitespace-nowrap w-full sm:w-auto text-center">' +
              '<i class="fas fa-sign-out-alt mr-1"></i>로그아웃' +
              '</button>'
            ) +
            '</div>';
        }

        function getDeviceIcon(label) {
          if (!label) return 'fa-globe';
          const l = label.toLowerCase();
          if (l.includes('iphone') || l.includes('ipad') || l.includes('ios')) return 'fa-apple-alt';
          if (l.includes('android')) return 'fa-mobile-alt';
          if (l.includes('windows')) return 'fa-desktop';
          if (l.includes('mac')) return 'fa-laptop';
          if (l.includes('linux')) return 'fa-linux';
          return 'fa-globe';
        }

        function formatTimeAgo(ts) {
          const diff = Math.floor(Date.now() / 1000) - ts;
          if (diff < 60) return '방금 전';
          if (diff < 3600) return Math.floor(diff / 60) + '분 전';
          if (diff < 86400) return Math.floor(diff / 3600) + '시간 전';
          return Math.floor(diff / 86400) + '일 전';
        }

        function escapeHtml(str) {
          const div = document.createElement('div');
          div.textContent = str || '';
          return div.innerHTML;
        }

        window.logoutSession = async function(prefix, btn) {
          if (!confirm('이 기기를 로그아웃하시겠습니까?')) return;
          btn.disabled = true;
          btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';

          try {
            const res = await fetch('/api/user/sessions/' + prefix, { method: 'DELETE' });
            if (!res.ok) throw new Error();
            btn.closest('.session-card').remove();

            // 남은 세션이 1개 이하면 전체 로그아웃 버튼 숨김
            if (listEl) {
              const remaining = listEl.querySelectorAll('.session-card');
              if (remaining.length <= 1 && logoutOthersBtn) logoutOthersBtn.classList.add('hidden');
            }
          } catch {
            btn.disabled = false;
            btn.innerHTML = '<i class="fas fa-sign-out-alt mr-1"></i>로그아웃';
            alert('로그아웃에 실패했습니다.');
          }
        };

        if (logoutOthersBtn) {
          logoutOthersBtn.addEventListener('click', async function() {
            if (!confirm('다른 모든 기기에서 로그아웃하시겠습니까?')) return;
            logoutOthersBtn.disabled = true;
            logoutOthersBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-1"></i>처리 중...';

            try {
              const res = await fetch('/api/user/sessions/logout-others', { method: 'POST' });
              if (!res.ok) throw new Error();
              loadSessions(); // 새로고침
            } catch {
              alert('처리에 실패했습니다.');
            } finally {
              logoutOthersBtn.disabled = false;
              logoutOthersBtn.innerHTML = '<i class="fas fa-sign-out-alt mr-1"></i>다른 기기 전체 로그아웃';
            }
          });
        }

        loadSessions();
      })();
    </script>
  `
}
