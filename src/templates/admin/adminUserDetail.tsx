/**
 * 관리자 - 사용자 상세 페이지
 */

import { renderAdminLayout } from './adminLayout'
import {
  getChannelLabel,
  getInterestStateLabel,
  getCareerStateLabel
} from '../../services/onboardingService'

export interface UserDetailRecord {
  id: number
  email: string
  name: string | null
  username: string | null
  pictureUrl: string | null
  provider: string
  providerUserId?: string | null
  googleId?: string | null
  role: string
  editCount: number
  commentCount: number
  isBanned: boolean
  banReason: string | null
  bannedUntil: number | null
  onboarded: boolean
  lastLoginAt: number | null
  createdAt: number
}

export interface UserAttribution {
  selfChannel: string
  selfChannelOther?: string
  interestState?: string
  careerState?: string
  utmSource?: string
  utmMedium?: string
  utmCampaign?: string
  referrer?: string
  firstTouchAt: number
}

export interface UserConsent {
  type: string
  version: string
  consentedAt: number
  ip?: string
  ua?: string
}

export interface UserComment {
  id: number
  pageType: string
  slug: string
  content: string
  moderated: boolean
  originalContent?: string
  createdAt: string
  status: string
}

export interface AdminUserDetailProps {
  user: UserDetailRecord
  attribution: UserAttribution | null
  consents: UserConsent[]
  comments: UserComment[]
  latestIp?: string | null
}

export function renderAdminUserDetail(props: AdminUserDetailProps): string {
  const { user, attribution, consents, comments, latestIp } = props

  const content = `
    <!-- 뒤로가기 -->
    <div class="mb-6">
      <a href="/admin/users" class="text-slate-400 hover:text-white transition-colors">
        <i class="fas fa-arrow-left mr-2"></i>사용자 목록으로
      </a>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <!-- 왼쪽: 프로필 -->
      <div class="lg:col-span-1 space-y-6">
        <!-- 기본 정보 카드 -->
        <div class="glass-card rounded-xl p-6">
          <div class="text-center mb-6">
            ${user.pictureUrl ? `
              <img src="${escapeHtml(user.pictureUrl)}" alt="" class="w-20 h-20 rounded-full mx-auto mb-4 border-2 border-slate-600">
            ` : `
              <div class="w-20 h-20 bg-slate-700 rounded-full mx-auto mb-4 flex items-center justify-center">
                <i class="fas fa-user text-3xl text-slate-500"></i>
              </div>
            `}
            <h2 class="text-2xl font-bold text-white">${escapeHtml(user.username || '닉네임 없음')}</h2>
            <p class="text-slate-300 text-sm">${escapeHtml(user.email)}</p>
            ${user.name ? `<p class="text-slate-400 text-xs mt-1">${escapeHtml(user.name)}</p>` : ''}
          </div>

          <div class="space-y-3 text-sm">
            <div class="flex justify-between">
              <span class="text-slate-400">ID</span>
              <span class="text-white font-mono">#${user.id}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">역할</span>
              <span class="px-2 py-0.5 rounded text-xs ${getRoleBadgeClass(user.role)}">${getRoleLabel(user.role)}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">온보딩</span>
              <span class="${user.onboarded ? 'text-green-400' : 'text-yellow-400'}">
                ${user.onboarded ? '완료' : '미완료'}
              </span>
            </div>
            <div class="flex justify-between">
              <span class="text-slate-400">상태</span>
              ${user.isBanned ? `
                <span class="text-red-400">차단됨</span>
              ` : `
                <span class="text-green-400">활성</span>
              `}
            </div>
          </div>

          <div class="border-t border-slate-700 mt-4 pt-4 grid grid-cols-2 gap-4 text-center">
            <div>
              <p class="text-2xl font-bold text-blue-400">${user.editCount}</p>
              <p class="text-xs text-slate-400">편집</p>
            </div>
            <div>
              <p class="text-2xl font-bold text-purple-400">${user.commentCount}</p>
              <p class="text-xs text-slate-400">댓글</p>
            </div>
          </div>
        </div>

        <!-- 차단 정보 (차단된 경우) -->
        ${user.isBanned ? `
          <div class="glass-card rounded-xl p-6 border border-red-500/30">
            <h3 class="text-lg font-semibold text-red-400 mb-4">
              <i class="fas fa-ban mr-2"></i>차단 정보
            </h3>
            <div class="space-y-2 text-sm">
              <div>
                <span class="text-slate-400">사유:</span>
                <p class="text-white mt-1">${escapeHtml(user.banReason || '사유 없음')}</p>
              </div>
              <div>
                <span class="text-slate-400">해제일:</span>
                <span class="text-white ml-2">${user.bannedUntil ? formatDate(user.bannedUntil) : '영구'}</span>
              </div>
            </div>
            <button
              class="unban-btn mt-4 w-full py-2 bg-green-600 hover:bg-green-500 rounded text-white text-sm transition-colors"
              data-user-id="${user.id}"
            >
              차단 해제
            </button>
          </div>
        ` : ''}

        <!-- 관리 버튼 -->
        <div class="glass-card rounded-xl p-6">
          <h3 class="text-lg font-semibold text-white mb-4">
            <i class="fas fa-cog mr-2 text-slate-400"></i>관리
          </h3>
          
          <div class="space-y-3">
            <!-- 역할 변경 -->
            <div>
              <label class="text-sm text-slate-400 block mb-2">역할 변경</label>
              <select
                id="role-select"
                class="w-full px-3 py-2 bg-slate-700/50 border border-slate-600 rounded text-white text-sm"
                data-user-id="${user.id}"
                data-current-role="${user.role}"
              >
                <option value="user" ${user.role === 'user' ? 'selected' : ''}>사용자</option>
                <option value="expert" ${user.role === 'expert' ? 'selected' : ''}>전문가</option>
                <option value="admin" ${user.role === 'admin' ? 'selected' : ''}>관리자</option>
              </select>
            </div>

            ${!user.isBanned ? `
              <button
                class="ban-btn w-full py-2 bg-red-600 hover:bg-red-500 rounded text-white text-sm transition-colors"
                data-user-id="${user.id}"
                data-user-name="${escapeHtml(user.username || user.email)}"
              >
                <i class="fas fa-ban mr-2"></i>사용자 차단
              </button>
            ` : ''}
          </div>
        </div>

        <!-- 계정 정보 -->
        <div class="glass-card rounded-xl p-6">
          <h3 class="text-lg font-semibold text-white mb-4">
            <i class="fas fa-id-card mr-2 text-slate-300"></i>계정 정보
          </h3>
          <div class="space-y-2 text-sm">
            <div class="flex justify-between"><span class="text-slate-400">닉네임</span><span class="text-white">${escapeHtml(user.username || '닉네임 없음')}</span></div>
            <div class="flex justify-between"><span class="text-slate-400">이메일</span><span class="text-white">${escapeHtml(user.email)}</span></div>
            <div class="flex justify-between"><span class="text-slate-400">이름</span><span class="text-white">${escapeHtml(user.name || '-')}</span></div>
            <div class="flex justify-between"><span class="text-slate-400">프로바이더</span><span class="text-white capitalize">${escapeHtml(user.provider)}</span></div>
            <div class="flex justify-between"><span class="text-slate-400">Provider User ID</span><span class="text-white font-mono text-xs">${escapeHtml(user.providerUserId || '-')}</span></div>
            <div class="flex justify-between"><span class="text-slate-400">Google ID</span><span class="text-white font-mono text-xs">${escapeHtml(user.googleId || '-')}</span></div>
            <div class="flex justify-between"><span class="text-slate-400">가입일</span><span class="text-white">${formatDate(user.createdAt)}</span></div>
            <div class="flex justify-between"><span class="text-slate-400">마지막 로그인</span><span class="text-white">${user.lastLoginAt ? formatDateTime(user.lastLoginAt) : '-'}</span></div>
            <div class="flex justify-between"><span class="text-slate-400">최근 IP</span><span class="text-white">${latestIp ? escapeHtml(latestIp) : '-'}</span></div>
          </div>
        </div>
      </div>

      <!-- 오른쪽: 상세 정보 -->
      <div class="lg:col-span-2 space-y-6">
        <!-- 활동 요약 -->
        <div class="glass-card rounded-xl p-6">
          <h3 class="text-lg font-semibold text-white mb-4">
            <i class="fas fa-chart-pie mr-2 text-blue-300"></i>활동 요약
          </h3>
          <div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
            <div class="p-3 rounded-lg bg-slate-800/50 border border-slate-700/60">
              <p class="text-2xl font-bold text-purple-400">${user.commentCount}</p>
              <p class="text-xs text-slate-400 mt-1">댓글 작성</p>
            </div>
            <div class="p-3 rounded-lg bg-slate-800/50 border border-slate-700/60">
              <p class="text-2xl font-bold text-blue-400">${user.editCount}</p>
              <p class="text-xs text-slate-400 mt-1">편집</p>
            </div>
            <div class="p-3 rounded-lg bg-slate-800/50 border border-slate-700/60">
              <p class="text-xl font-semibold text-slate-200">-</p>
              <p class="text-xs text-slate-400 mt-1">HowTo 작성</p>
            </div>
            <div class="p-3 rounded-lg bg-slate-800/50 border border-slate-700/60">
              <p class="text-xl font-semibold text-slate-200">-</p>
              <p class="text-xs text-slate-400 mt-1">편집 이력</p>
            </div>
          </div>
        </div>

        <!-- 유입경로 -->
        <div class="glass-card rounded-xl p-6">
          <h3 class="text-lg font-semibold text-white mb-4">
            <i class="fas fa-route mr-2 text-blue-400"></i>유입경로
          </h3>
          ${attribution ? `
            <div class="grid grid-cols-2 md:grid-cols-3 gap-4 text-sm">
              <div>
                <span class="text-slate-400 block mb-1">유입 경로</span>
                <span class="text-white">${getChannelLabel(attribution.selfChannel)}</span>
                ${attribution.selfChannelOther ? `
                  <span class="text-slate-400 ml-1">(${escapeHtml(attribution.selfChannelOther)})</span>
                ` : ''}
              </div>
              ${attribution.interestState ? `
                <div>
                  <span class="text-slate-400 block mb-1">관심 상태</span>
                  <span class="text-white">${getInterestStateLabel(attribution.interestState)}</span>
                </div>
              ` : ''}
              ${attribution.careerState ? `
                <div>
                  <span class="text-slate-400 block mb-1">커리어 상태</span>
                  <span class="text-white">${getCareerStateLabel(attribution.careerState)}</span>
                </div>
              ` : ''}
              ${attribution.utmSource ? `
                <div>
                  <span class="text-slate-400 block mb-1">UTM Source</span>
                  <span class="text-white font-mono text-xs">${escapeHtml(attribution.utmSource)}</span>
                </div>
              ` : ''}
              ${attribution.utmMedium ? `
                <div>
                  <span class="text-slate-400 block mb-1">UTM Medium</span>
                  <span class="text-white font-mono text-xs">${escapeHtml(attribution.utmMedium)}</span>
                </div>
              ` : ''}
              ${attribution.referrer ? `
                <div class="col-span-2 md:col-span-3">
                  <span class="text-slate-400 block mb-1">Referrer</span>
                  <span class="text-white font-mono text-xs break-all">${escapeHtml(attribution.referrer)}</span>
                </div>
              ` : ''}
              <div>
                <span class="text-slate-400 block mb-1">최초 접속</span>
                <span class="text-white">${formatDate(attribution.firstTouchAt)}</span>
              </div>
            </div>
          ` : `
            <p class="text-slate-500">유입경로 정보가 없습니다.</p>
          `}
        </div>

        <!-- 동의 이력 -->
        <div class="glass-card rounded-xl p-6">
          <h3 class="text-lg font-semibold text-white mb-4">
            <i class="fas fa-file-contract mr-2 text-green-400"></i>동의 이력
          </h3>
          ${consents.length > 0 ? `
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead>
                  <tr class="text-slate-400 border-b border-slate-700">
                    <th class="text-left py-2">유형</th>
                    <th class="text-left py-2">버전</th>
                    <th class="text-left py-2">동의일시</th>
                    <th class="text-left py-2">IP</th>
                  </tr>
                </thead>
                <tbody>
                  ${consents.map(consent => `
                    <tr class="border-b border-slate-700/50">
                      <td class="py-2 text-white">${consent.type === 'terms' ? '이용약관' : '개인정보처리방침'}</td>
                      <td class="py-2 text-slate-300 font-mono text-xs">${escapeHtml(consent.version)}</td>
                      <td class="py-2 text-slate-300">${formatDateTime(consent.consentedAt)}</td>
                      <td class="py-2 text-slate-400 font-mono text-xs">${consent.ip || '-'}</td>
                    </tr>
                  `).join('')}
                </tbody>
              </table>
            </div>
          ` : `
            <p class="text-slate-500">동의 이력이 없습니다.</p>
          `}
        </div>

        <!-- 최근 댓글 -->
        <div class="glass-card rounded-xl p-6">
          <h3 class="text-lg font-semibold text-white mb-4">
            <i class="fas fa-comments mr-2 text-purple-400"></i>최근 댓글
            <span class="text-slate-400 font-normal text-sm ml-2">(최근 20개)</span>
          </h3>
          ${comments.length > 0 ? `
            <div class="space-y-4">
              ${comments.map(comment => `
                <div class="border-b border-slate-700/50 pb-4 last:border-0 last:pb-0">
                  <div class="flex items-center justify-between mb-2">
                    <div class="flex items-center gap-2">
                      <span class="px-2 py-0.5 bg-slate-700 rounded text-xs text-slate-300">
                        ${comment.pageType}
                      </span>
                      <a href="/${comment.pageType}/${comment.slug}" target="_blank" class="text-blue-400 hover:underline text-sm">
                        ${escapeHtml(comment.slug)}
                      </a>
                    </div>
                    <div class="flex items-center gap-2">
                      ${comment.moderated ? `
                        <span class="px-2 py-0.5 bg-yellow-500/20 text-yellow-400 rounded text-xs">
                          <i class="fas fa-filter mr-1"></i>필터됨
                        </span>
                      ` : ''}
                      <span class="text-xs text-slate-500">${comment.createdAt}</span>
                    </div>
                  </div>
                  <p class="text-white text-sm">${escapeHtml(comment.content)}</p>
                  ${comment.moderated && comment.originalContent ? `
                    <details class="mt-2">
                      <summary class="text-xs text-slate-500 cursor-pointer hover:text-slate-400">원본 보기</summary>
                      <p class="mt-1 text-xs text-red-400/80 bg-red-500/10 p-2 rounded">${escapeHtml(comment.originalContent)}</p>
                    </details>
                  ` : ''}
                </div>
              `).join('')}
            </div>
          ` : `
            <p class="text-slate-500">댓글이 없습니다.</p>
          `}
        </div>
      </div>
    </div>

    <!-- 차단 모달 -->
    <div id="banModal" class="fixed inset-0 z-50 hidden items-center justify-center" style="background: rgba(0,0,0,0.7);">
      <div class="glass-card rounded-xl p-6 w-full max-w-md mx-4">
        <h3 class="text-xl font-semibold text-white mb-4">
          <i class="fas fa-ban text-red-400 mr-2"></i>사용자 차단
        </h3>
        <p class="text-slate-400 mb-4">
          <span id="banUserName" class="text-white font-medium"></span>님을 차단하시겠습니까?
        </p>
        
        <input type="hidden" id="banUserId">
        
        <div class="mb-4">
          <label class="block text-sm text-slate-400 mb-2">차단 기간</label>
          <select id="banDuration" class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white">
            <option value="1d">1일</option>
            <option value="7d">7일</option>
            <option value="30d">30일</option>
            <option value="permanent">영구</option>
          </select>
        </div>
        
        <div class="mb-6">
          <label class="block text-sm text-slate-400 mb-2">차단 사유 (선택)</label>
          <textarea 
            id="banReason" 
            rows="3"
            placeholder="차단 사유를 입력하세요..."
            class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white placeholder-slate-400 resize-none"
          ></textarea>
        </div>
        
        <div class="flex justify-end gap-3">
          <button id="cancelBan" class="px-4 py-2 bg-slate-600 hover:bg-slate-500 rounded-lg text-white transition-colors">
            취소
          </button>
          <button id="confirmBan" class="px-4 py-2 bg-red-600 hover:bg-red-500 rounded-lg text-white transition-colors">
            차단
          </button>
        </div>
      </div>
    </div>

    <!-- Toast 컨테이너 -->
    <div id="toastContainer" class="fixed bottom-4 right-4 z-50 space-y-2"></div>

    <script>
      function showToast(message, type = 'info') {
        const container = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        const bgClass = type === 'success' ? 'bg-green-600' : type === 'error' ? 'bg-red-600' : 'bg-blue-600';
        toast.className = bgClass + ' text-white px-4 py-3 rounded-lg shadow-lg flex items-center gap-2';
        toast.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle') + '"></i><span>' + message + '</span>';
        container.appendChild(toast);
        setTimeout(() => toast.remove(), 3000);
      }

      // 역할 변경
      const roleSelect = document.getElementById('role-select');
      if (roleSelect) {
        roleSelect.addEventListener('change', async (e) => {
          const userId = e.target.dataset.userId;
          const newRole = e.target.value;
          const currentRole = e.target.dataset.currentRole;
          
          if (newRole === currentRole) return;
          
          try {
            const res = await fetch('/api/admin/users/' + userId, {
              method: 'PATCH',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ role: newRole })
            });
            
            const data = await res.json();
            
            if (data.success) {
              e.target.dataset.currentRole = newRole;
              showToast('역할이 변경되었습니다.', 'success');
            } else {
              e.target.value = currentRole;
              showToast(data.error || '역할 변경에 실패했습니다.', 'error');
            }
          } catch (err) {
            e.target.value = currentRole;
            showToast('요청 실패: ' + err.message, 'error');
          }
        });
      }

      // 차단 모달
      const banBtn = document.querySelector('.ban-btn');
      if (banBtn) {
        banBtn.addEventListener('click', () => {
          document.getElementById('banUserId').value = banBtn.dataset.userId;
          document.getElementById('banUserName').textContent = banBtn.dataset.userName;
          document.getElementById('banDuration').value = '7d';
          document.getElementById('banReason').value = '';
          document.getElementById('banModal').classList.remove('hidden');
          document.getElementById('banModal').classList.add('flex');
        });
      }

      document.getElementById('cancelBan')?.addEventListener('click', () => {
        document.getElementById('banModal').classList.add('hidden');
        document.getElementById('banModal').classList.remove('flex');
      });

      document.getElementById('confirmBan')?.addEventListener('click', async () => {
        const userId = document.getElementById('banUserId').value;
        const duration = document.getElementById('banDuration').value;
        const reason = document.getElementById('banReason').value;
        
        try {
          const res = await fetch('/api/admin/users/' + userId, {
            method: 'PATCH',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ action: 'ban', duration, reason: reason || undefined })
          });
          
          const data = await res.json();
          
          if (data.success) {
            showToast('사용자가 차단되었습니다.', 'success');
            setTimeout(() => location.reload(), 1000);
          } else {
            showToast(data.error || '차단에 실패했습니다.', 'error');
          }
        } catch (err) {
          showToast('요청 실패: ' + err.message, 'error');
        }
        
        document.getElementById('banModal').classList.add('hidden');
        document.getElementById('banModal').classList.remove('flex');
      });

      // 차단 해제
      document.querySelectorAll('.unban-btn').forEach(btn => {
        btn.addEventListener('click', async () => {
          if (!confirm('차단을 해제하시겠습니까?')) return;
          
          const userId = btn.dataset.userId;
          
          try {
            const res = await fetch('/api/admin/users/' + userId, {
              method: 'PATCH',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ action: 'unban' })
            });
            
            const data = await res.json();
            
            if (data.success) {
              showToast('차단이 해제되었습니다.', 'success');
              setTimeout(() => location.reload(), 1000);
            } else {
              showToast(data.error || '차단 해제에 실패했습니다.', 'error');
            }
          } catch (err) {
            showToast('요청 실패: ' + err.message, 'error');
          }
        });
      });
    </script>
  `

  return renderAdminLayout({
    title: `사용자 상세 - ${user.username || user.email}`,
    currentPath: '/admin/users',
    children: content
  })
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, m => map[m])
}

function formatDate(ts: number): string {
  const date = new Date(ts * 1000)
  return date.toLocaleDateString('ko-KR', { year: 'numeric', month: 'short', day: 'numeric' })
}

function formatDateTime(ts: number): string {
  const date = new Date(ts * 1000)
  return date.toLocaleString('ko-KR', { year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' })
}

function getRoleBadgeClass(role: string): string {
  switch (role) {
    case 'admin': return 'bg-red-500/20 text-red-400'
    case 'expert': return 'bg-purple-500/20 text-purple-400'
    default: return 'bg-slate-500/20 text-slate-400'
  }
}

function getRoleLabel(role: string): string {
  switch (role) {
    case 'admin': return '관리자'
    case 'expert': return '전문가'
    default: return '사용자'
  }
}

