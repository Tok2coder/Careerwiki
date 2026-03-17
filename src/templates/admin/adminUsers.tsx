/**
 * 관리자 - 사용자 관리 페이지
 */

import { renderAdminLayout } from './adminLayout'
import type { UserAttributionStats, VisitorRecord, EditorRevisionRecord, VisitorPageView, RefererDistribution } from '../../services/adminService'

export interface UserRecord {
  id: number
  username?: string | null
  email: string
  name: string | null
  role: string
  editCount: number
  commentCount: number
  isBanned: boolean
  banReason: string | null
  bannedUntil: number | null
  lastLoginAt: number | null
  createdAt: number
}

export interface AdminUsersProps {
  activeTab: 'users' | 'visitors' | 'revisions' | 'visitor-detail'
  users: UserRecord[]
  total: number
  page: number
  perPage: number
  totalPages: number
  filters: {
    search: string
    role: string
    status: string
  }
  attributionStats?: UserAttributionStats
  // 방문자 탭
  visitors?: VisitorRecord[]
  visitorsTotal?: number
  visitorsPage?: number
  visitorsTotalPages?: number
  visitorSort?: string
  // 편집 이력 탭
  editorRevisions?: EditorRevisionRecord[]
  editorRevisionsTotal?: number
  editorRevisionsPage?: number
  editorRevisionsTotalPages?: number
  editorLabel?: string  // "사용자 #5" or "IP abc123"
  editorId?: string
  editorIpHash?: string
  // 방문자 상세
  visitorDetail?: VisitorPageView[]
  visitorDetailIp?: string
  // 유입경로 분포
  refererDistribution?: RefererDistribution[]
}

const CHANNEL_LABELS: Record<string, string> = {
  google_search: '구글 검색', naver_search: '네이버 검색', kakao_share: '카카오 공유',
  instagram: '인스타그램', youtube: '유튜브', community: '커뮤니티',
  school_academy: '학교/학원', friend_referral: '지인 추천', other: '기타'
}

const INTEREST_LABELS: Record<string, string> = {
  job_search: '직업 탐색', major_search: '전공 탐색', career_change: '이직/전직',
  consult_interest: '상담 관심', browsing: '둘러보기'
}

const CAREER_LABELS: Record<string, string> = {
  high_school: '고등학생', university: '대학생', job_seeker: '구직자',
  employed: '재직자', transition: '전환기', other: '기타'
}

function renderAttributionCharts(stats: UserAttributionStats): string {
  if (stats.totalWithAttribution === 0) return ''

  const chartColors = ['#60a5fa', '#34d399', '#fcd34d', '#f87171', '#a78bfa', '#38bdf8', '#f97316', '#ec4899', '#6ee7b7']

  return `
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 mb-6">
      <div class="glass-card rounded-xl p-4">
        <h4 class="text-sm font-medium text-slate-400 mb-3"><i class="fas fa-route text-blue-400 mr-1.5"></i>유입 경로</h4>
        <div class="h-48"><canvas id="channelChart"></canvas></div>
        <div class="mt-2 space-y-1 text-xs text-slate-400 admin-mini-scroll max-h-24 overflow-y-auto">
          ${stats.channelDistribution.map(c => `<div class="flex justify-between"><span>${CHANNEL_LABELS[c.channel] || c.channel}</span><span class="text-white">${c.count}</span></div>`).join('')}
        </div>
      </div>
      <div class="glass-card rounded-xl p-4">
        <h4 class="text-sm font-medium text-slate-400 mb-3"><i class="fas fa-compass text-emerald-400 mr-1.5"></i>관심 상태</h4>
        <div class="h-48"><canvas id="interestChart"></canvas></div>
        <div class="mt-2 space-y-1 text-xs text-slate-400 admin-mini-scroll max-h-24 overflow-y-auto">
          ${stats.interestDistribution.map(c => `<div class="flex justify-between"><span>${INTEREST_LABELS[c.state] || c.state}</span><span class="text-white">${c.count}</span></div>`).join('')}
        </div>
      </div>
      <div class="glass-card rounded-xl p-4">
        <h4 class="text-sm font-medium text-slate-400 mb-3"><i class="fas fa-user-graduate text-purple-400 mr-1.5"></i>커리어 상태</h4>
        <div class="h-48"><canvas id="careerChart"></canvas></div>
        <div class="mt-2 space-y-1 text-xs text-slate-400 admin-mini-scroll max-h-24 overflow-y-auto">
          ${stats.careerDistribution.map(c => `<div class="flex justify-between"><span>${CAREER_LABELS[c.state] || c.state}</span><span class="text-white">${c.count}</span></div>`).join('')}
        </div>
      </div>
    </div>
    <script>
    (() => {
      const colors = ${JSON.stringify(chartColors)};
      const opts = { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } };
      function mkDoughnut(id, labels, data) {
        const el = document.getElementById(id);
        if (!el || data.every(v => v === 0)) return;
        new Chart(el, { type: 'doughnut', data: { labels, datasets: [{ data, backgroundColor: labels.map((_,i) => colors[i % colors.length]), borderWidth: 1 }] }, options: opts });
      }
      mkDoughnut('channelChart', ${JSON.stringify(stats.channelDistribution.map(c => CHANNEL_LABELS[c.channel] || c.channel))}, ${JSON.stringify(stats.channelDistribution.map(c => c.count))});
      mkDoughnut('interestChart', ${JSON.stringify(stats.interestDistribution.map(c => INTEREST_LABELS[c.state] || c.state))}, ${JSON.stringify(stats.interestDistribution.map(c => c.count))});
      mkDoughnut('careerChart', ${JSON.stringify(stats.careerDistribution.map(c => CAREER_LABELS[c.state] || c.state))}, ${JSON.stringify(stats.careerDistribution.map(c => c.count))});
    })();
    </script>
  `
}

function renderRefererChart(dist: RefererDistribution[]): string {
  if (!dist || dist.length === 0) return `
    <div class="glass-card rounded-xl p-4 mb-6">
      <h4 class="text-sm font-medium text-slate-400 mb-3"><i class="fas fa-chart-pie text-teal-400 mr-1.5"></i>유입 경로 분포</h4>
      <p class="text-slate-500 text-sm py-8 text-center">아직 유입경로 데이터가 수집되지 않았습니다. 방문자가 페이지를 조회하면 자동으로 집계됩니다.</p>
    </div>
  `
  const chartColors = ['#60a5fa', '#34d399', '#fcd34d', '#f87171', '#a78bfa', '#38bdf8', '#f97316', '#ec4899', '#6ee7b7', '#94a3b8']
  const labels = dist.map(d => d.referer)
  const data = dist.map(d => d.count)
  const total = data.reduce((a, b) => a + b, 0)

  return `
    <div class="glass-card rounded-xl p-4 mb-6">
      <h4 class="text-sm font-medium text-slate-400 mb-3"><i class="fas fa-chart-pie text-teal-400 mr-1.5"></i>유입 경로 분포 <span class="text-slate-500">(총 ${total.toLocaleString()}건)</span></h4>
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-4 items-center">
        <div class="h-56 flex justify-center"><canvas id="refererChart"></canvas></div>
        <div class="space-y-1.5 text-sm admin-mini-scroll max-h-56 overflow-y-auto">
          ${dist.map((d, i) => {
            const pct = total > 0 ? ((d.count / total) * 100).toFixed(1) : '0'
            return `<div class="flex items-center gap-2">
              <span class="w-3 h-3 rounded-full flex-shrink-0" style="background:${chartColors[i % chartColors.length]}"></span>
              <span class="text-slate-300 flex-1 truncate">${escapeHtml(d.referer)}</span>
              <span class="text-white font-medium">${d.count.toLocaleString()}</span>
              <span class="text-slate-500 text-xs w-12 text-right">${pct}%</span>
            </div>`
          }).join('')}
        </div>
      </div>
    </div>
    <script>
    (() => {
      const el = document.getElementById('refererChart');
      if (!el) return;
      new Chart(el, {
        type: 'doughnut',
        data: {
          labels: ${JSON.stringify(labels)},
          datasets: [{ data: ${JSON.stringify(data)}, backgroundColor: ${JSON.stringify(chartColors.slice(0, dist.length))}, borderWidth: 1 }]
        },
        options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
      });
    })();
    </script>
  `
}

function renderVisitorsTab(props: AdminUsersProps): string {
  const { visitors = [], visitorsTotal = 0, visitorsPage = 1, visitorsTotalPages = 0, visitorSort = 'recent', refererDistribution } = props

  return `
    <!-- 유입경로 차트 -->
    ${renderRefererChart(refererDistribution || [])}

    <!-- 정렬 옵션 -->
    <div class="glass-card rounded-xl p-4 mb-6">
      <div class="flex items-center gap-3">
        <span class="text-sm text-slate-400">정렬:</span>
        <a href="?tab=visitors&sort=recent" class="px-3 py-1.5 rounded-lg text-sm transition-colors ${visitorSort === 'recent' ? 'bg-blue-600 text-white' : 'bg-slate-700 text-slate-300 hover:bg-slate-600'}">최근 방문</a>
        <a href="?tab=visitors&sort=frequent" class="px-3 py-1.5 rounded-lg text-sm transition-colors ${visitorSort === 'frequent' ? 'bg-blue-600 text-white' : 'bg-slate-700 text-slate-300 hover:bg-slate-600'}">방문 빈도</a>
        <a href="?tab=visitors&sort=edits" class="px-3 py-1.5 rounded-lg text-sm transition-colors ${visitorSort === 'edits' ? 'bg-blue-600 text-white' : 'bg-slate-700 text-slate-300 hover:bg-slate-600'}">편집 수</a>
      </div>
    </div>

    <!-- 방문자 테이블 -->
    <div class="glass-card rounded-xl overflow-hidden mb-6">
      <div class="p-4 border-b border-slate-700/50">
        <h3 class="text-lg font-semibold">
          <i class="fas fa-globe text-teal-400 mr-2"></i>
          방문자 목록 <span class="text-slate-400 font-normal">(${visitorsTotal.toLocaleString()}명)</span>
        </h3>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-slate-800/50">
            <tr>
              <th class="px-4 py-3 text-left text-slate-400 font-medium">IP 해시</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium">방문 일수</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium">페이지뷰</th>
              <th class="px-4 py-3 text-left text-slate-400 font-medium">유입 경로</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium">마지막 방문</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium">편집</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium">작업</th>
            </tr>
          </thead>
          <tbody>
            ${visitors.length > 0 ? visitors.map(v => `
              <tr class="border-t border-slate-700/50 hover:bg-slate-700/20">
                <td class="px-4 py-3">
                  <a href="?tab=visitor-detail&ip=${encodeURIComponent(String(v.ipHash))}" class="hover:underline">
                    <code class="text-sm text-blue-300 bg-slate-800 px-2 py-0.5 rounded">${escapeHtml(String(v.ipHash))}</code>
                  </a>
                </td>
                <td class="px-4 py-3 text-center text-white">${v.visitDays}일</td>
                <td class="px-4 py-3 text-center text-white">${Number(v.pageViews) || 0}</td>
                <td class="px-4 py-3 text-sm text-slate-400 max-w-[180px] truncate">
                  ${v.topReferer ? `<i class="fas fa-external-link-alt text-xs mr-1 text-slate-500"></i>${escapeHtml(String(v.topReferer))}` : '<span class="text-slate-600">직접 방문</span>'}
                </td>
                <td class="px-4 py-3 text-center text-sm text-slate-400">${v.lastVisit}</td>
                <td class="px-4 py-3 text-center">
                  ${Number(v.editCount) > 0
                    ? `<a href="?tab=revisions&ip=${encodeURIComponent(String(v.ipHash))}" class="text-amber-400 font-medium hover:underline">${v.editCount}</a>`
                    : `<span class="text-slate-500">0</span>`}
                </td>
                <td class="px-4 py-3 text-center">
                  <a href="?tab=visitor-detail&ip=${encodeURIComponent(String(v.ipHash))}"
                     class="px-3 py-1 bg-slate-600 hover:bg-slate-500 rounded text-xs text-white transition-colors">
                    <i class="fas fa-eye mr-1"></i>상세
                  </a>
                </td>
              </tr>
            `).join('') : `
              <tr>
                <td colspan="7" class="px-4 py-12 text-center text-slate-400">
                  <i class="fas fa-ghost text-3xl mb-2"></i>
                  <p>방문자 데이터가 없습니다. 데이터 수집이 시작되면 여기에 표시됩니다.</p>
                </td>
              </tr>
            `}
          </tbody>
        </table>
      </div>
    </div>

    ${visitorsTotalPages > 1 ? `
      <div class="flex flex-wrap items-center justify-center gap-2">
        ${visitorsPage > 1 ? `
          <a href="?tab=visitors&sort=${visitorSort}&page=${visitorsPage - 1}"
             class="min-w-[44px] min-h-[44px] px-3 py-2 flex items-center justify-center bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors">
            <i class="fas fa-chevron-left"></i>
          </a>
        ` : ''}
        ${generatePagination(visitorsPage, visitorsTotalPages).map(p => p === '...' ? `
          <span class="min-w-[44px] min-h-[44px] px-3 py-2 flex items-center justify-center text-slate-500">...</span>
        ` : `
          <a href="?tab=visitors&sort=${visitorSort}&page=${p}"
             class="min-w-[44px] min-h-[44px] px-3 py-2 flex items-center justify-center ${Number(p) === visitorsPage ? 'bg-blue-600 text-white' : 'bg-slate-700 hover:bg-slate-600 text-white'} rounded transition-colors">
            ${p}
          </a>
        `).join('')}
        ${visitorsPage < visitorsTotalPages ? `
          <a href="?tab=visitors&sort=${visitorSort}&page=${visitorsPage + 1}"
             class="min-w-[44px] min-h-[44px] px-3 py-2 flex items-center justify-center bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors">
            <i class="fas fa-chevron-right"></i>
          </a>
        ` : ''}
      </div>
    ` : ''}
  `
}

function renderRevisionsTab(props: AdminUsersProps): string {
  const { editorRevisions = [], editorRevisionsTotal = 0, editorLabel = '', editorId, editorIpHash } = props

  const changeTypeLabel: Record<string, string> = {
    initial: '최초', edit: '편집', restore: '복원', merge: '병합'
  }
  const entityTypeLabel: Record<string, string> = {
    job: '직업', major: '전공', howto: 'HowTo'
  }

  return `
    <div class="glass-card rounded-xl p-4 mb-6">
      <div class="flex items-center justify-between">
        <div>
          <h3 class="text-lg font-semibold text-white">
            <i class="fas fa-history text-amber-400 mr-2"></i>
            ${escapeHtml(editorLabel)}의 편집 이력
            <span class="text-slate-400 font-normal">(${editorRevisionsTotal}건)</span>
          </h3>
          <p class="text-sm text-slate-400 mt-1">
            <a href="?tab=${editorId ? 'users' : 'visitors'}" class="text-blue-400 hover:text-blue-300">
              <i class="fas fa-arrow-left mr-1"></i>목록으로 돌아가기
            </a>
          </p>
        </div>
        ${editorRevisionsTotal > 0 ? `
          <button id="bulkRevertBtn"
            class="px-4 py-2 bg-red-600 hover:bg-red-500 rounded-lg text-sm text-white transition-colors"
            data-editor-id="${editorId || ''}"
            data-ip-hash="${editorIpHash || ''}"
            data-count="${editorRevisionsTotal}">
            <i class="fas fa-undo mr-1.5"></i>전체 되돌리기
          </button>
        ` : ''}
      </div>
    </div>

    ${editorRevisions.length > 0 ? `
      <div class="glass-card rounded-xl overflow-hidden mb-6">
        <div class="overflow-x-auto">
          <table class="w-full">
            <thead class="bg-slate-800/50">
              <tr>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">유형</th>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">대상</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium">리비전</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium">변경 유형</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium">변경 필드</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium">일시</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium">작업</th>
              </tr>
            </thead>
            <tbody>
              ${editorRevisions.map(r => {
                const entityUrl = r.entityType === 'job' ? `/job/${r.entityId}`
                  : r.entityType === 'major' ? `/major/${r.entityId}`
                  : `/howto/${r.entityId}`
                return `
                  <tr class="border-t border-slate-700/50 hover:bg-slate-700/20">
                    <td class="px-4 py-3">
                      <span class="px-2 py-0.5 rounded text-xs ${
                        r.entityType === 'job' ? 'bg-blue-500/20 text-blue-300' :
                        r.entityType === 'major' ? 'bg-purple-500/20 text-purple-300' :
                        'bg-emerald-500/20 text-emerald-300'
                      }">${entityTypeLabel[r.entityType] || r.entityType}</span>
                    </td>
                    <td class="px-4 py-3">
                      <a href="${entityUrl}" class="text-blue-400 hover:text-blue-300 text-sm" target="_blank">
                        ${escapeHtml(String(r.entityName || r.entityId))}
                      </a>
                    </td>
                    <td class="px-4 py-3 text-center text-sm text-slate-300">r${r.revisionNumber}</td>
                    <td class="px-4 py-3 text-center">
                      <span class="text-xs text-slate-400">${changeTypeLabel[r.changeType || ''] || r.changeType || '-'}</span>
                    </td>
                    <td class="px-4 py-3 text-center text-xs text-slate-500 max-w-[200px] truncate">
                      ${r.changedFields || '-'}
                    </td>
                    <td class="px-4 py-3 text-center text-xs text-slate-400 whitespace-nowrap">${r.createdAt}</td>
                    <td class="px-4 py-3 text-center">
                      <button class="revert-btn px-2 py-1 bg-amber-600 hover:bg-amber-500 rounded text-xs text-white transition-colors"
                        data-revision-id="${r.id}">
                        <i class="fas fa-undo mr-1"></i>되돌리기
                      </button>
                    </td>
                  </tr>
                `
              }).join('')}
            </tbody>
          </table>
        </div>
      </div>
    ` : `
      <div class="glass-card rounded-xl p-12 text-center text-slate-400">
        <i class="fas fa-check-circle text-3xl mb-2 text-green-400"></i>
        <p>편집 이력이 없습니다.</p>
      </div>
    `}

    <!-- 되돌리기 스크립트 -->
    <div id="toastContainer" class="fixed bottom-4 right-4 z-50 space-y-2"></div>
    <script>
      function showToast(message, type) {
        const container = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        const bgClass = type === 'success' ? 'bg-green-600' : type === 'error' ? 'bg-red-600' : 'bg-blue-600';
        toast.className = bgClass + ' text-white px-4 py-3 rounded-lg shadow-lg flex items-center gap-2';
        toast.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i><span>' + message + '</span>';
        container.appendChild(toast);
        setTimeout(() => toast.remove(), 4000);
      }

      // 개별 되돌리기
      document.querySelectorAll('.revert-btn').forEach(btn => {
        btn.addEventListener('click', async () => {
          if (!confirm('이 리비전의 이전 상태로 되돌리시겠습니까?')) return;
          const revId = btn.dataset.revisionId;
          try {
            const res = await fetch('/api/admin/revert-revision', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ revisionId: Number(revId) })
            });
            const data = await res.json();
            if (data.success) {
              showToast('되돌리기 완료', 'success');
              btn.disabled = true;
              btn.classList.add('opacity-50');
            } else {
              showToast(data.error || '되돌리기 실패', 'error');
            }
          } catch (e) {
            showToast('요청 실패: ' + e.message, 'error');
          }
        });
      });

      // 전체 되돌리기
      const bulkBtn = document.getElementById('bulkRevertBtn');
      if (bulkBtn) {
        bulkBtn.addEventListener('click', async () => {
          const count = bulkBtn.dataset.count;
          if (!confirm('이 편집자의 모든 편집(' + count + '건)을 되돌리시겠습니까? 각 엔티티의 가장 이전 리비전으로 복원됩니다.')) return;
          bulkBtn.disabled = true;
          bulkBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-1.5"></i>처리 중...';
          try {
            const body = {};
            if (bulkBtn.dataset.editorId) body.editorId = bulkBtn.dataset.editorId;
            if (bulkBtn.dataset.ipHash) body.ipHash = bulkBtn.dataset.ipHash;
            const res = await fetch('/api/admin/bulk-revert', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify(body)
            });
            const data = await res.json();
            if (data.success) {
              showToast('총 ' + data.revertedCount + '건 되돌리기 완료', 'success');
              setTimeout(() => location.reload(), 1500);
            } else {
              showToast(data.error || '되돌리기 실패', 'error');
              bulkBtn.disabled = false;
              bulkBtn.innerHTML = '<i class="fas fa-undo mr-1.5"></i>전체 되돌리기';
            }
          } catch (e) {
            showToast('요청 실패: ' + e.message, 'error');
            bulkBtn.disabled = false;
            bulkBtn.innerHTML = '<i class="fas fa-undo mr-1.5"></i>전체 되돌리기';
          }
        });
      }
    </script>
  `
}

function renderVisitorDetailTab(props: AdminUsersProps): string {
  const { visitorDetail = [], visitorDetailIp = '' } = props

  const pageTypeLabel: Record<string, string> = {
    job: '직업', major: '전공', howto: 'HowTo', share: '공유'
  }
  const pageTypeBadge: Record<string, string> = {
    job: 'bg-blue-500/20 text-blue-300',
    major: 'bg-purple-500/20 text-purple-300',
    howto: 'bg-emerald-500/20 text-emerald-300',
    share: 'bg-amber-500/20 text-amber-300',
  }

  return `
    <div class="glass-card rounded-xl p-4 mb-6">
      <div class="flex items-center justify-between">
        <div>
          <h3 class="text-lg font-semibold text-white">
            <i class="fas fa-eye text-teal-400 mr-2"></i>
            방문자 <code class="text-sm text-blue-300 bg-slate-800 px-2 py-0.5 rounded">${escapeHtml(visitorDetailIp)}</code> 활동 내역
            <span class="text-slate-400 font-normal">(최근 ${visitorDetail.length}건)</span>
          </h3>
          <p class="text-sm text-slate-400 mt-1">
            <a href="?tab=visitors" class="text-blue-400 hover:text-blue-300">
              <i class="fas fa-arrow-left mr-1"></i>방문자 목록으로
            </a>
          </p>
        </div>
      </div>
    </div>

    ${visitorDetail.length > 0 ? `
      <div class="glass-card rounded-xl overflow-hidden mb-6">
        <div class="overflow-x-auto">
          <table class="w-full">
            <thead class="bg-slate-800/50">
              <tr>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">유형</th>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">페이지</th>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">유입 경로</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium">시간</th>
              </tr>
            </thead>
            <tbody>
              ${visitorDetail.map(pv => {
                const url = pv.pageType === 'job' ? `/job/${pv.pageId}`
                  : pv.pageType === 'major' ? `/major/${pv.pageId}`
                  : pv.pageType === 'howto' ? `/howto/${pv.pageId}`
                  : '#'
                return `
                  <tr class="border-t border-slate-700/50 hover:bg-slate-700/20">
                    <td class="px-4 py-3">
                      <span class="px-2 py-0.5 rounded text-xs ${pageTypeBadge[pv.pageType] || 'bg-slate-500/20 text-slate-300'}">${pageTypeLabel[pv.pageType] || pv.pageType}</span>
                    </td>
                    <td class="px-4 py-3">
                      <a href="${url}" class="text-blue-400 hover:text-blue-300 text-sm" target="_blank">
                        ${escapeHtml(String(pv.pageName || pv.pageId))}
                      </a>
                    </td>
                    <td class="px-4 py-3 text-sm text-slate-400 max-w-[200px] truncate">
                      ${pv.referer ? escapeHtml(String(pv.referer)) : '<span class="text-slate-600">직접 방문</span>'}
                    </td>
                    <td class="px-4 py-3 text-center text-xs text-slate-400 whitespace-nowrap">${pv.createdAt}</td>
                  </tr>
                `
              }).join('')}
            </tbody>
          </table>
        </div>
      </div>
    ` : `
      <div class="glass-card rounded-xl p-12 text-center text-slate-400">
        <i class="fas fa-hourglass text-3xl mb-2"></i>
        <p>아직 페이지뷰 데이터가 없습니다. 데이터 수집이 시작되면 여기에 표시됩니다.</p>
      </div>
    `}
  `
}

export function renderAdminUsers(props: AdminUsersProps): string {
  const { activeTab, users, total, page, perPage, totalPages, filters, attributionStats } = props

  // 탭 내비게이션
  const tabs = `
    <div class="flex items-center gap-1 mb-6 border-b border-slate-700/50 pb-0">
      <a href="?tab=users"
         class="px-4 py-3 text-sm font-medium border-b-2 transition-colors ${activeTab === 'users' ? 'border-blue-500 text-white' : 'border-transparent text-slate-400 hover:text-white'}">
        <i class="fas fa-users mr-1.5"></i>사용자
      </a>
      <a href="?tab=visitors"
         class="px-4 py-3 text-sm font-medium border-b-2 transition-colors ${activeTab === 'visitors' ? 'border-teal-500 text-white' : 'border-transparent text-slate-400 hover:text-white'}">
        <i class="fas fa-globe mr-1.5"></i>방문자
      </a>
      ${activeTab === 'revisions' ? `
        <span class="px-4 py-3 text-sm font-medium border-b-2 border-amber-500 text-white">
          <i class="fas fa-history mr-1.5"></i>편집 이력
        </span>
      ` : ''}
    </div>
  `

  // 탭별 콘텐츠
  if (activeTab === 'visitors') {
    return renderAdminLayout({
      title: '사용자 관리',
      currentPath: '/admin/users',
      children: tabs + renderVisitorsTab(props)
    })
  }

  if (activeTab === 'revisions') {
    return renderAdminLayout({
      title: '사용자 관리',
      currentPath: '/admin/users',
      children: tabs + renderRevisionsTab(props)
    })
  }

  if (activeTab === 'visitor-detail') {
    return renderAdminLayout({
      title: '사용자 관리',
      currentPath: '/admin/users',
      children: tabs + renderVisitorDetailTab(props)
    })
  }

  const content = tabs + `
    <!-- 유입경로/관심/커리어 통계 -->
    ${attributionStats ? renderAttributionCharts(attributionStats) : ''}

    <!-- 필터 바 -->
    <div class="glass-card rounded-xl p-4 mb-6">
      <form id="filterForm" class="flex flex-wrap items-center gap-4">
        <!-- 검색 -->
        <div class="flex-1 min-w-[200px]">
          <div class="relative">
            <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-slate-400"></i>
            <input 
              type="text" 
              name="search" 
              value="${escapeHtml(filters.search)}"
              placeholder="닉네임, 이메일, 이름으로 검색..."
              class="w-full pl-10 pr-4 py-2.5 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white placeholder-slate-400 focus:outline-none focus:border-blue-500"
              style="font-size: 16px;"
            >
          </div>
        </div>
        
        <!-- 역할 필터 -->
        <select name="role" class="px-4 py-2.5 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white" style="font-size: 16px;">
          <option value="all" ${filters.role === 'all' ? 'selected' : ''}>모든 역할</option>
          <option value="user" ${filters.role === 'user' ? 'selected' : ''}>사용자</option>
          <option value="expert" ${filters.role === 'expert' ? 'selected' : ''}>전문가</option>
          <option value="admin" ${filters.role === 'admin' ? 'selected' : ''}>관리자</option>
        </select>
        
        <!-- 상태 필터 -->
        <select name="status" class="px-4 py-2.5 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white" style="font-size: 16px;">
          <option value="all" ${filters.status === 'all' ? 'selected' : ''}>모든 상태</option>
          <option value="active" ${filters.status === 'active' ? 'selected' : ''}>활성</option>
          <option value="banned" ${filters.status === 'banned' ? 'selected' : ''}>차단됨</option>
        </select>
        
        <!-- 페이지당 개수 -->
        <select name="perPage" class="px-4 py-2.5 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white hidden sm:block" style="font-size: 16px;">
          <option value="20" ${perPage === 20 ? 'selected' : ''}>20개</option>
          <option value="50" ${perPage === 50 ? 'selected' : ''}>50개</option>
          <option value="100" ${perPage === 100 ? 'selected' : ''}>100개</option>
        </select>
        
        <button type="submit" class="px-5 py-2.5 min-h-[44px] bg-blue-600 hover:bg-blue-500 rounded-lg text-white transition-colors">
          <i class="fas fa-filter mr-2"></i>적용
        </button>
      </form>
    </div>
    
    <!-- 사용자 테이블 -->
    <div class="glass-card rounded-xl overflow-hidden mb-6">
      <div class="p-4 border-b border-slate-700/50 flex items-center justify-between">
        <h3 class="text-lg font-semibold">
          <i class="fas fa-users text-green-400 mr-2"></i>
          사용자 목록 <span class="text-slate-400 font-normal">(${total.toLocaleString()}명)</span>
        </h3>
      </div>
      
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-slate-800/50">
            <tr>
              <th class="px-2 sm:px-4 py-3 text-left text-slate-400 font-medium whitespace-nowrap">사용자</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium whitespace-nowrap">역할</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium whitespace-nowrap">편집</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium whitespace-nowrap">댓글</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium whitespace-nowrap">상태</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium whitespace-nowrap hidden md:table-cell">마지막 로그인</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium whitespace-nowrap hidden md:table-cell">가입일</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium whitespace-nowrap">작업</th>
            </tr>
          </thead>
          <tbody>
            ${users.length > 0 ? users.map(user => `
              <tr class="border-t border-slate-700/50 hover:bg-slate-700/20 transition-colors">
                <td class="px-2 sm:px-4 py-3">
                  <a href="/admin/users/${user.id}" class="flex items-center gap-2 sm:gap-3 hover:text-blue-300 transition-colors">
                    <div class="w-8 h-8 sm:w-10 sm:h-10 bg-slate-600 rounded-full flex items-center justify-center shrink-0">
                      <i class="fas fa-user text-slate-400 text-xs sm:text-base"></i>
                    </div>
                    <div class="min-w-0">
                      <p class="text-white font-semibold text-sm sm:text-base truncate">${escapeHtml(user.username || '닉네임 없음')}</p>
                      <p class="text-xs sm:text-sm text-slate-400 truncate">${escapeHtml(user.email)}</p>
                      ${user.name ? `<p class="text-xs text-slate-500 mt-0.5 truncate">${escapeHtml(user.name)}</p>` : ''}
                    </div>
                  </a>
                </td>
                <td class="px-2 sm:px-4 py-3 text-center whitespace-nowrap">
                  <select
                    class="role-select px-1.5 sm:px-2 py-1 bg-slate-700 border border-slate-600 rounded text-xs sm:text-sm text-white"
                    data-user-id="${user.id}"
                    data-current-role="${user.role}"
                  >
                    <option value="user" ${user.role === 'user' ? 'selected' : ''}>사용자</option>
                    <option value="expert" ${user.role === 'expert' ? 'selected' : ''}>전문가</option>
                    <option value="admin" ${user.role === 'admin' ? 'selected' : ''}>관리자</option>
                  </select>
                </td>
                <td class="px-2 sm:px-4 py-3 text-center text-white whitespace-nowrap">${user.editCount}</td>
                <td class="px-2 sm:px-4 py-3 text-center text-white whitespace-nowrap">${user.commentCount}</td>
                <td class="px-2 sm:px-4 py-3 text-center whitespace-nowrap">
                  ${user.isBanned ? `
                    <span class="px-1.5 sm:px-2 py-1 bg-red-500/20 text-red-400 rounded text-xs whitespace-nowrap">
                      차단됨${user.bannedUntil ? ` (${formatBanExpiry(user.bannedUntil)})` : ' (영구)'}
                    </span>
                  ` : `
                    <span class="px-1.5 sm:px-2 py-1 bg-green-500/20 text-green-400 rounded text-xs whitespace-nowrap">활성</span>
                  `}
                </td>
                <td class="px-2 sm:px-4 py-3 text-center text-sm text-slate-400 whitespace-nowrap hidden md:table-cell">
                  ${user.lastLoginAt ? formatTimestamp(user.lastLoginAt) : '-'}
                </td>
                <td class="px-2 sm:px-4 py-3 text-center text-sm text-slate-400 whitespace-nowrap hidden md:table-cell">
                  ${formatTimestamp(user.createdAt)}
                </td>
                <td class="px-2 sm:px-4 py-3 text-center whitespace-nowrap">
                  <div class="flex items-center justify-center gap-1.5">
                    ${user.editCount > 0 ? `
                      <a href="?tab=revisions&editor=${user.id}"
                         class="px-2 py-1 bg-slate-600 hover:bg-slate-500 rounded text-xs text-white transition-colors"
                         title="편집 이력">
                        <i class="fas fa-history"></i>
                      </a>
                    ` : ''}
                    ${user.isBanned ? `
                      <button
                        class="unban-btn px-2 sm:px-3 py-1 bg-green-600 hover:bg-green-500 rounded text-xs sm:text-sm text-white transition-colors whitespace-nowrap"
                        data-user-id="${user.id}"
                      >
                        <i class="fas fa-unlock mr-1"></i>해제
                      </button>
                    ` : `
                      <button
                        class="ban-btn px-2 sm:px-3 py-1 bg-red-600 hover:bg-red-500 rounded text-xs sm:text-sm text-white transition-colors whitespace-nowrap"
                        data-user-id="${user.id}"
                        data-user-name="${escapeHtml(user.name || user.email)}"
                      >
                        <i class="fas fa-ban mr-1"></i>차단
                      </button>
                    `}
                  </div>
                </td>
              </tr>
            `).join('') : `
              <tr>
                <td colspan="8" class="px-4 py-12 text-center text-slate-400">
                  <i class="fas fa-search text-3xl mb-2"></i>
                  <p>조건에 맞는 사용자가 없습니다.</p>
                </td>
              </tr>
            `}
          </tbody>
        </table>
      </div>
    </div>
    
    <!-- 페이지네이션 -->
    ${totalPages > 1 ? `
      <div class="flex flex-wrap items-center justify-center gap-2">
        ${page > 1 ? `
          <a href="?page=${page - 1}&perPage=${perPage}&search=${encodeURIComponent(filters.search)}&role=${filters.role}&status=${filters.status}" 
             class="min-w-[44px] min-h-[44px] px-3 py-2 flex items-center justify-center bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors">
            <i class="fas fa-chevron-left"></i>
          </a>
        ` : ''}
        
        ${generatePagination(page, totalPages).map(p => p === '...' ? `
          <span class="min-w-[44px] min-h-[44px] px-3 py-2 flex items-center justify-center text-slate-500">...</span>
        ` : `
          <a href="?page=${p}&perPage=${perPage}&search=${encodeURIComponent(filters.search)}&role=${filters.role}&status=${filters.status}" 
             class="min-w-[44px] min-h-[44px] px-3 py-2 flex items-center justify-center ${Number(p) === page ? 'bg-blue-600 text-white' : 'bg-slate-700 hover:bg-slate-600 text-white'} rounded transition-colors">
            ${p}
          </a>
        `).join('')}
        
        ${page < totalPages ? `
          <a href="?page=${page + 1}&perPage=${perPage}&search=${encodeURIComponent(filters.search)}&role=${filters.role}&status=${filters.status}" 
             class="min-w-[44px] min-h-[44px] px-3 py-2 flex items-center justify-center bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors">
            <i class="fas fa-chevron-right"></i>
          </a>
        ` : ''}
      </div>
    ` : ''}
    
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
      // Toast 표시
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
      document.querySelectorAll('.role-select').forEach(select => {
        select.addEventListener('change', async (e) => {
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
      });
      
      // 차단 모달 열기
      document.querySelectorAll('.ban-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          document.getElementById('banUserId').value = btn.dataset.userId;
          document.getElementById('banUserName').textContent = btn.dataset.userName;
          document.getElementById('banDuration').value = '7d';
          document.getElementById('banReason').value = '';
          document.getElementById('banModal').classList.remove('hidden');
          document.getElementById('banModal').classList.add('flex');
        });
      });
      
      // 차단 모달 닫기
      document.getElementById('cancelBan').addEventListener('click', () => {
        document.getElementById('banModal').classList.add('hidden');
        document.getElementById('banModal').classList.remove('flex');
      });
      
      // 차단 확인
      document.getElementById('confirmBan').addEventListener('click', async () => {
        const userId = document.getElementById('banUserId').value;
        const duration = document.getElementById('banDuration').value;
        const reason = document.getElementById('banReason').value;
        
        try {
          const res = await fetch('/api/admin/users/' + userId, {
            method: 'PATCH',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ 
              action: 'ban',
              duration,
              reason: reason || undefined
            })
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
    title: '사용자 관리',
    currentPath: '/admin/users',
    children: content
  })
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, m => map[m])
}

function formatTimestamp(ts: number): string {
  const date = new Date(ts * 1000)
  return date.toLocaleDateString('ko-KR', { year: '2-digit', month: 'short', day: 'numeric' })
}

function formatBanExpiry(ts: number): string {
  const date = new Date(ts * 1000)
  const now = new Date()
  const diffDays = Math.ceil((date.getTime() - now.getTime()) / 86400000)
  if (diffDays <= 0) return '만료됨'
  if (diffDays === 1) return '1일 남음'
  return `${diffDays}일 남음`
}

function generatePagination(current: number, total: number): (number | string)[] {
  const pages: (number | string)[] = []
  const delta = 2
  
  for (let i = 1; i <= total; i++) {
    if (i === 1 || i === total || (i >= current - delta && i <= current + delta)) {
      pages.push(i)
    } else if (pages[pages.length - 1] !== '...') {
      pages.push('...')
    }
  }
  
  return pages
}




