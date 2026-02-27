/**
 * 관리자 - 콘텐츠/편집 관리 페이지
 */

import { renderAdminLayout } from './adminLayout'
import type { CoverageStats } from '../../services/adminService'

export interface RevisionRecord {
  id: number
  entityType: string
  entityId: string
  entityName: string | null
  revisionNumber: number
  isCurrent: boolean
  editorId: string | null
  editorType: string
  editorName: string | null
  changeType: string | null
  changedFields: string | null
  createdAt: string
}

export interface HiddenItem {
  id: string
  name: string
  slug: string | null
  primarySource: string
  hiddenAt: number
}

export interface AdminContentProps {
  activeTab: 'revisions' | 'archive' | 'comments'
  revisions: RevisionRecord[]
  total: number
  page: number
  perPage: number
  totalPages: number
  filters: {
    entityType: string
    editorType: string
    startDate: string
    endDate: string
  }
  hiddenJobs: HiddenItem[]
  hiddenMajors: HiddenItem[]
  moderation?: {
    items: Array<{
      id: number
      parentId: number | null
      pageType: 'job' | 'major' | 'guide'
      slug: string
      title: string
      content: string
      nickname: string | null
      isAnonymous: boolean
      displayIp: string | null
      status: 'visible' | 'blinded' | 'deleted'
      reportCount: number
      likes: number
      dislikes: number
      createdAt: string
    }>
    total: number
    page: number
    perPage: number
    totalPages: number
  }
  howtoReports?: {
    items: Array<{
      id: number
      pageId: number
      pageSlug: string
      pageTitle: string
      reasonType: string
      reasonDetail: string | null
      status: string
      reporterId: number | null
      reporterIpHash: string | null
      createdAt: string
    }>
    total: number
    page: number
    perPage: number
    totalPages: number
  }
  coverage?: CoverageStats
}

export function renderAdminContent(props: AdminContentProps): string {
  const { activeTab, revisions, total, page, perPage, totalPages, filters, hiddenJobs, hiddenMajors, coverage } = props

  // 기본 날짜 설정 (최근 30일)
  const defaultEndDate = new Date().toISOString().split('T')[0]
  const defaultStartDate = new Date(Date.now() - 30 * 86400000).toISOString().split('T')[0]

  const coverageSection = coverage ? `
    <div class="glass-card rounded-xl p-4 mb-4">
      <h3 class="text-lg font-semibold mb-3 flex items-center gap-2 text-slate-100">
        <i class="fas fa-map text-emerald-400"></i> 콘텐츠 커버리지
      </h3>
      <!-- 직업 -->
      <div class="mb-3">
        <div class="flex justify-between text-sm mb-1">
          <span class="text-slate-300">직업 (${coverage.jobs.total}개)</span>
          <span class="text-emerald-400">${coverage.jobs.edited}개 편집됨 (${coverage.jobs.rate.toFixed(1)}%)</span>
        </div>
        <div class="bg-slate-700/50 rounded-full h-2">
          <div class="bg-blue-500 h-2 rounded-full" style="width: ${Math.min(coverage.jobs.rate, 100)}%"></div>
        </div>
      </div>
      <!-- 전공 -->
      <div class="mb-3">
        <div class="flex justify-between text-sm mb-1">
          <span class="text-slate-300">전공 (${coverage.majors.total}개)</span>
          <span class="text-emerald-400">${coverage.majors.edited}개 편집됨 (${coverage.majors.rate.toFixed(1)}%)</span>
        </div>
        <div class="bg-slate-700/50 rounded-full h-2">
          <div class="bg-purple-500 h-2 rounded-full" style="width: ${Math.min(coverage.majors.rate, 100)}%"></div>
        </div>
      </div>

      <!-- 편집 우선순위 TOP 10 -->
      <h4 class="text-sm font-medium text-slate-300 mt-4 mb-2">미편집 + 고조회수 TOP 10 (편집 우선순위)</h4>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-2">
        <!-- 직업 -->
        <div class="space-y-1">
          <div class="text-xs text-blue-400 font-medium mb-1">직업</div>
          ${coverage.priorityJobs.map((j, i) => `
            <a href="/job/${j.slug}/edit" class="flex items-center justify-between text-sm bg-wiki-card/60 rounded px-3 py-1.5 hover:bg-wiki-card transition-colors">
              <span class="text-slate-200 truncate">${i + 1}. ${escapeHtml(j.name)}</span>
              <span class="text-slate-400 text-xs shrink-0 ml-2">${(j.viewCount || 0).toLocaleString()}회</span>
            </a>
          `).join('')}
        </div>
        <!-- 전공 -->
        <div class="space-y-1">
          <div class="text-xs text-purple-400 font-medium mb-1">전공</div>
          ${coverage.priorityMajors.map((m, i) => `
            <a href="/major/${m.slug}/edit" class="flex items-center justify-between text-sm bg-wiki-card/60 rounded px-3 py-1.5 hover:bg-wiki-card transition-colors">
              <span class="text-slate-200 truncate">${i + 1}. ${escapeHtml(m.name)}</span>
              <span class="text-slate-400 text-xs shrink-0 ml-2">${(m.viewCount || 0).toLocaleString()}회</span>
            </a>
          `).join('')}
        </div>
      </div>
    </div>
  ` : ''

  const content = `
    ${coverageSection}
    <!-- 탭 네비게이션 -->
    <div class="flex items-center gap-2 mb-6 overflow-x-auto pb-2">
      <a href="/admin/content?tab=revisions" 
         class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg transition-colors whitespace-nowrap text-sm sm:text-base flex items-center ${activeTab === 'revisions' 
           ? 'bg-blue-600 text-white' 
           : 'bg-slate-700 text-slate-300 hover:bg-slate-600'}">
        <i class="fas fa-history mr-1.5 sm:mr-2"></i><span class="hidden sm:inline">편집 </span>이력
      </a>
      <a href="/admin/content?tab=archive" 
         class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg transition-colors whitespace-nowrap text-sm sm:text-base flex items-center ${activeTab === 'archive' 
           ? 'bg-amber-600 text-white' 
           : 'bg-slate-700 text-slate-300 hover:bg-slate-600'}">
        <i class="fas fa-archive mr-1.5 sm:mr-2"></i>페이지
        ${(hiddenJobs.length + hiddenMajors.length) > 0 ? `<span class="ml-1.5 sm:ml-2 px-1.5 sm:px-2 py-0.5 bg-red-500 text-white text-xs rounded-full">${hiddenJobs.length + hiddenMajors.length}</span>` : ''}
      </a>
      <a href="/admin/content?tab=comments" 
         class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg transition-colors whitespace-nowrap text-sm sm:text-base flex items-center ${activeTab === 'comments' 
           ? 'bg-rose-600 text-white' 
           : 'bg-slate-700 text-slate-300 hover:bg-slate-600'}">
        <i class="fas fa-comments mr-1.5 sm:mr-2"></i>댓글
        ${props.moderation && props.moderation.total > 0 ? `<span class="ml-1.5 sm:ml-2 px-1.5 sm:px-2 py-0.5 bg-red-500 text-white text-xs rounded-full">${props.moderation.total}</span>` : ''}
      </a>
    </div>
    
    ${activeTab === 'revisions' ? renderRevisionsTab(revisions, total, page, perPage, totalPages, filters, defaultStartDate, defaultEndDate) : ''}
    ${activeTab === 'archive' ? renderArchiveTab(hiddenJobs, hiddenMajors) : ''}
    ${activeTab === 'comments' ? renderCommentsModerationTab(props.moderation) : ''}
    ${activeTab === 'archive' ? renderHowtoReports(props.howtoReports) : ''}
    
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
      
      // 복원 모달 열기 (편집 이력 탭)
      document.querySelectorAll('.restore-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          document.getElementById('restoreRevisionId').value = btn.dataset.revisionId;
          document.getElementById('restoreEntityName').textContent = btn.dataset.entityName;
          document.getElementById('restoreRevisionNumber').textContent = 'r' + btn.dataset.revisionNumber;
          document.getElementById('restoreReason').value = '';
          document.getElementById('restoreModal').classList.remove('hidden');
          document.getElementById('restoreModal').classList.add('flex');
        });
      });
      
      // 복원 모달 닫기
      document.getElementById('cancelRestore')?.addEventListener('click', () => {
        document.getElementById('restoreModal').classList.add('hidden');
        document.getElementById('restoreModal').classList.remove('flex');
      });
      
      // 복원 확인 (편집 이력 탭)
      document.getElementById('confirmRestore')?.addEventListener('click', async () => {
        const revisionId = document.getElementById('restoreRevisionId').value;
        const reason = document.getElementById('restoreReason').value;
        
        try {
          const res = await fetch('/api/admin/revisions/' + revisionId + '/restore', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ reason: reason || undefined })
          });
          
          const data = await res.json();
          
          if (data.success) {
            showToast('리비전이 복원되었습니다.', 'success');
            setTimeout(() => location.reload(), 1000);
          } else {
            showToast(data.error || '복원에 실패했습니다.', 'error');
          }
        } catch (err) {
          showToast('요청 실패: ' + err.message, 'error');
        }
        
        document.getElementById('restoreModal').classList.add('hidden');
        document.getElementById('restoreModal').classList.remove('flex');
      });
      
      // 아카이브 복구 버튼
      document.querySelectorAll('.archive-restore-btn').forEach(btn => {
        btn.addEventListener('click', async () => {
          const entityType = btn.dataset.entityType;
          const entityId = btn.dataset.entityId;
          const entityName = btn.dataset.entityName;
          
          if (!confirm(entityName + '을(를) 복구하시겠습니까?\\n\\n복구하면 다시 일반 유저에게 보이게 됩니다.')) {
            return;
          }
          
          btn.disabled = true;
          btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-1"></i>복구 중...';
          
          try {
            const res = await fetch('/api/' + entityType + '/' + entityId + '/restore', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' }
            });
            
            const data = await res.json();
            
            if (data.success) {
              showToast(data.message || '복구되었습니다.', 'success');
              setTimeout(() => location.reload(), 1000);
            } else {
              showToast(data.error || '복구에 실패했습니다.', 'error');
              btn.disabled = false;
              btn.innerHTML = '<i class="fas fa-undo mr-1"></i>복구';
            }
          } catch (err) {
            showToast('요청 실패: ' + err.message, 'error');
            btn.disabled = false;
            btn.innerHTML = '<i class="fas fa-undo mr-1"></i>복구';
          }
        });
      });
      
      // 아카이브 완전 삭제 버튼
      document.querySelectorAll('.archive-delete-btn').forEach(btn => {
        btn.addEventListener('click', async () => {
          const entityType = btn.dataset.entityType;
          const entityId = btn.dataset.entityId;
          const entityName = btn.dataset.entityName;
          
          if (!confirm('⚠️ 경고: 완전 삭제\\n\\n"' + entityName + '"을(를) 완전히 삭제하시겠습니까?\\n\\n• 모든 데이터가 DB에서 삭제됩니다\\n• 수정 기록(역사)도 모두 삭제됩니다\\n• 이 작업은 복구할 수 없습니다!')) {
            return;
          }
          
          const finalConfirm = prompt('완전 삭제를 확인하려면 "' + entityName + '"을(를) 정확히 입력하세요:');
          if (finalConfirm !== entityName) {
            alert('입력이 일치하지 않습니다. 삭제가 취소되었습니다.');
            return;
          }
          
          btn.disabled = true;
          btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-1"></i>삭제 중...';
          
          try {
            const res = await fetch('/api/' + entityType + '/' + entityId + '?permanent=true', {
              method: 'DELETE',
              headers: { 'Content-Type': 'application/json' }
            });
            
            const data = await res.json();
            
            if (data.success) {
              showToast(data.message || '완전히 삭제되었습니다.', 'success');
              // 행을 새로고침하지 않고 "삭제됨"으로 표시
              const row = btn.closest('tr');
              if (row) {
                const actionCell = row.querySelector('td:last-child');
                if (actionCell) {
                  actionCell.innerHTML = '<span class="px-3 py-1 bg-red-500/20 text-red-400 rounded text-sm"><i class="fas fa-check mr-1"></i>삭제됨</span>';
                }
                row.classList.add('opacity-50');
              }
            } else {
              showToast(data.error || '삭제에 실패했습니다.', 'error');
              btn.disabled = false;
              btn.innerHTML = '<i class="fas fa-trash-alt mr-1"></i>삭제';
            }
          } catch (err) {
            showToast('요청 실패: ' + err.message, 'error');
            btn.disabled = false;
            btn.innerHTML = '<i class="fas fa-trash-alt mr-1"></i>삭제';
          }
        });
      });
    </script>
  `
  
  return renderAdminLayout({
    title: '콘텐츠 관리',
    currentPath: '/admin/content',
    children: content
  })
}

function renderRevisionsTab(
  revisions: RevisionRecord[], 
  total: number, 
  page: number, 
  perPage: number, 
  totalPages: number, 
  filters: { entityType: string; editorType: string; startDate: string; endDate: string },
  defaultStartDate: string,
  defaultEndDate: string
): string {
  return `
    <!-- 필터 바 -->
    <div class="glass-card rounded-xl p-3 sm:p-4 mb-6">
      <form id="filterForm" class="space-y-3 sm:space-y-0 sm:flex sm:flex-wrap sm:items-center sm:gap-4">
        <input type="hidden" name="tab" value="revisions">
        
        <!-- 타입 & 편집자 필터 -->
        <div class="flex gap-2">
          <select name="entityType" class="flex-1 px-3 py-2 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white text-sm" style="font-size: 16px;">
            <option value="all" ${filters.entityType === 'all' ? 'selected' : ''}>모든 타입</option>
            <option value="job" ${filters.entityType === 'job' ? 'selected' : ''}>직업</option>
            <option value="major" ${filters.entityType === 'major' ? 'selected' : ''}>전공</option>
            <option value="howto" ${filters.entityType === 'howto' ? 'selected' : ''}>HowTo</option>
          </select>
          
          <select name="editorType" class="flex-1 px-3 py-2 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white text-sm" style="font-size: 16px;">
            <option value="all" ${filters.editorType === 'all' ? 'selected' : ''}>모든 편집자</option>
            <option value="anonymous" ${filters.editorType === 'anonymous' ? 'selected' : ''}>익명</option>
            <option value="user" ${filters.editorType === 'user' ? 'selected' : ''}>사용자</option>
            <option value="admin" ${filters.editorType === 'admin' ? 'selected' : ''}>관리자</option>
          </select>
        </div>
        
        <!-- 날짜 범위 -->
        <div class="flex items-center gap-2">
          <input 
            type="date" 
            name="startDate"
            value="${filters.startDate || defaultStartDate}"
            class="flex-1 px-2 sm:px-3 py-2 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white text-sm"
            style="font-size: 16px;"
          >
          <span class="text-slate-400">~</span>
          <input 
            type="date" 
            name="endDate"
            value="${filters.endDate || defaultEndDate}"
            class="flex-1 px-2 sm:px-3 py-2 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white text-sm"
            style="font-size: 16px;"
          >
        </div>
        
        <!-- 페이지당 개수 & 버튼 -->
        <div class="flex gap-2">
          <select name="perPage" class="px-3 py-2 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white text-sm hidden sm:block" style="font-size: 16px;">
            <option value="20" ${perPage === 20 ? 'selected' : ''}>20개</option>
            <option value="50" ${perPage === 50 ? 'selected' : ''}>50개</option>
            <option value="100" ${perPage === 100 ? 'selected' : ''}>100개</option>
          </select>
          
          <button type="submit" class="px-4 py-2 min-h-[44px] bg-blue-600 hover:bg-blue-500 rounded-lg text-white transition-colors text-sm sm:text-base whitespace-nowrap">
            <i class="fas fa-filter mr-1 sm:mr-2"></i>적용
          </button>
        </div>
      </form>
    </div>
    
    <!-- 편집 이력 테이블 -->
    <div class="glass-card rounded-xl overflow-hidden mb-6">
      <div class="p-4 border-b border-slate-700/50 flex items-center justify-between">
        <h3 class="text-lg font-semibold">
          <i class="fas fa-history text-amber-400 mr-2"></i>
          편집 이력 <span class="text-slate-400 font-normal">(${total.toLocaleString()}건)</span>
        </h3>
      </div>
      
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-slate-800/50">
            <tr>
              <th class="px-4 py-3 text-left text-slate-400 font-medium w-20">#</th>
              <th class="px-4 py-3 text-left text-slate-400 font-medium">페이지</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium w-20">타입</th>
              <th class="px-4 py-3 text-left text-slate-400 font-medium">편집자</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium w-24">변경 유형</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium w-20">현재</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium w-36">일시</th>
              <th class="px-4 py-3 text-center text-slate-400 font-medium w-28">작업</th>
            </tr>
          </thead>
          <tbody>
            ${revisions.length > 0 ? revisions.map(rev => `
              <tr class="border-t border-slate-700/50 hover:bg-slate-700/20 transition-colors">
                <td class="px-4 py-3 text-slate-400 font-mono text-sm">
                  r${rev.revisionNumber}
                </td>
                <td class="px-4 py-3">
                  <div>
                    <a href="/${rev.entityType}/${rev.entityId}" 
                       class="text-blue-400 hover:text-blue-300 font-medium"
                       target="_blank">
                      ${escapeHtml(rev.entityName || rev.entityId)}
                    </a>
                  </div>
                  ${rev.changedFields ? `
                    <div class="text-xs text-slate-500 mt-1">
                      변경: ${formatChangedFields(rev.changedFields)}
                    </div>
                  ` : ''}
                </td>
                <td class="px-4 py-3 text-center">
                  <span class="px-2 py-1 rounded text-xs ${
                    rev.entityType === 'job' ? 'bg-blue-500/20 text-blue-400' :
                    rev.entityType === 'major' ? 'bg-purple-500/20 text-purple-400' :
                    'bg-green-500/20 text-green-400'
                  }">${rev.entityType}</span>
                </td>
                <td class="px-4 py-3">
                  <span class="${
                    rev.editorType === 'admin' ? 'text-amber-400' :
                    rev.editorType === 'anonymous' ? 'text-slate-500' :
                    'text-slate-300'
                  }">
                    ${escapeHtml(rev.editorName || '익명')}
                  </span>
                  <span class="text-xs text-slate-500 ml-1">(${rev.editorType})</span>
                </td>
                <td class="px-4 py-3 text-center">
                  <span class="px-2 py-1 rounded text-xs ${
                    rev.changeType === 'initial' ? 'bg-green-500/20 text-green-400' :
                    rev.changeType === 'restore' ? 'bg-amber-500/20 text-amber-400' :
                    'bg-slate-500/20 text-slate-400'
                  }">${formatChangeType(rev.changeType)}</span>
                </td>
                <td class="px-4 py-3 text-center">
                  ${rev.isCurrent ? `
                    <span class="px-2 py-1 bg-green-500/20 text-green-400 rounded text-xs">현재</span>
                  ` : `
                    <span class="text-slate-500">-</span>
                  `}
                </td>
                <td class="px-4 py-3 text-center text-sm text-slate-400">
                  ${formatDateTime(rev.createdAt)}
                </td>
                <td class="px-4 py-3 text-center">
                  ${!rev.isCurrent ? `
                    <button 
                      class="restore-btn px-3 py-1 bg-amber-600 hover:bg-amber-500 rounded text-sm text-white transition-colors"
                      data-revision-id="${rev.id}"
                      data-revision-number="${rev.revisionNumber}"
                      data-entity-name="${escapeHtml(rev.entityName || rev.entityId)}"
                    >
                      <i class="fas fa-undo mr-1"></i>복원
                    </button>
                  ` : `
                    <span class="text-slate-500 text-sm">-</span>
                  `}
                </td>
              </tr>
            `).join('') : `
              <tr>
                <td colspan="8" class="px-4 py-12 text-center text-slate-400">
                  <i class="fas fa-inbox text-3xl mb-2"></i>
                  <p>조건에 맞는 편집 이력이 없습니다.</p>
                </td>
              </tr>
            `}
          </tbody>
        </table>
      </div>
    </div>
    
    <!-- 페이지네이션 -->
    ${totalPages > 1 ? `
      <div class="flex items-center justify-center gap-2">
        ${page > 1 ? `
          <a href="?tab=revisions&page=${page - 1}&perPage=${perPage}&entityType=${filters.entityType}&editorType=${filters.editorType}&startDate=${filters.startDate}&endDate=${filters.endDate}" 
             class="px-3 py-2 bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors">
            <i class="fas fa-chevron-left"></i>
          </a>
        ` : ''}
        
        ${generatePagination(page, totalPages).map(p => p === '...' ? `
          <span class="px-3 py-2 text-slate-500">...</span>
        ` : `
          <a href="?tab=revisions&page=${p}&perPage=${perPage}&entityType=${filters.entityType}&editorType=${filters.editorType}&startDate=${filters.startDate}&endDate=${filters.endDate}" 
             class="px-3 py-2 ${Number(p) === page ? 'bg-blue-600 text-white' : 'bg-slate-700 hover:bg-slate-600 text-white'} rounded transition-colors">
            ${p}
          </a>
        `).join('')}
        
        ${page < totalPages ? `
          <a href="?tab=revisions&page=${page + 1}&perPage=${perPage}&entityType=${filters.entityType}&editorType=${filters.editorType}&startDate=${filters.startDate}&endDate=${filters.endDate}" 
             class="px-3 py-2 bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors">
            <i class="fas fa-chevron-right"></i>
          </a>
        ` : ''}
      </div>
    ` : ''}
    
    <!-- 복원 모달 -->
    <div id="restoreModal" class="fixed inset-0 z-50 hidden items-center justify-center" style="background: rgba(0,0,0,0.7);">
      <div class="glass-card rounded-xl p-6 w-full max-w-md mx-4">
        <h3 class="text-xl font-semibold text-white mb-4">
          <i class="fas fa-undo text-amber-400 mr-2"></i>리비전 복원
        </h3>
        <p class="text-slate-400 mb-4">
          <span id="restoreEntityName" class="text-white font-medium"></span>을(를) 
          <span id="restoreRevisionNumber" class="text-amber-400 font-medium"></span> 버전으로 복원하시겠습니까?
        </p>
        
        <input type="hidden" id="restoreRevisionId">
        
        <div class="mb-6">
          <label class="block text-sm text-slate-400 mb-2">복원 사유 (선택)</label>
          <textarea 
            id="restoreReason" 
            rows="3"
            placeholder="복원 사유를 입력하세요..."
            class="w-full px-4 py-2 bg-slate-700 border border-slate-600 rounded-lg text-white placeholder-slate-400 resize-none"
          ></textarea>
        </div>
        
        <div class="flex justify-end gap-3">
          <button id="cancelRestore" class="px-4 py-2 bg-slate-600 hover:bg-slate-500 rounded-lg text-white transition-colors">
            취소
          </button>
          <button id="confirmRestore" class="px-4 py-2 bg-amber-600 hover:bg-amber-500 rounded-lg text-white transition-colors">
            복원
          </button>
        </div>
      </div>
    </div>
  `
}

function renderArchiveTab(hiddenJobs: HiddenItem[], hiddenMajors: HiddenItem[]): string {
  return `
    <div class="space-y-6">
      <!-- 숨겨진 직업 -->
      <div class="glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700/50">
          <h3 class="text-lg font-semibold">
            <i class="fas fa-briefcase text-blue-400 mr-2"></i>
            숨겨진 직업 <span class="text-slate-400 font-normal">(${hiddenJobs.length}건)</span>
          </h3>
        </div>
        
        ${hiddenJobs.length > 0 ? `
          <div class="overflow-x-auto">
            <table class="w-full">
              <thead class="bg-slate-800/50">
                <tr>
                  <th class="px-4 py-3 text-left text-slate-400 font-medium">직업명</th>
                  <th class="px-4 py-3 text-center text-slate-400 font-medium w-28">출처</th>
                  <th class="px-4 py-3 text-center text-slate-400 font-medium w-36">숨긴 일시</th>
                  <th class="px-4 py-3 text-center text-slate-400 font-medium w-44">작업</th>
                </tr>
              </thead>
              <tbody>
                ${hiddenJobs.map(job => `
                  <tr class="border-t border-slate-700/50 hover:bg-slate-700/20 transition-colors">
                    <td class="px-4 py-3">
                      <span class="text-white font-medium">${escapeHtml(job.name)}</span>
                      <span class="text-xs text-slate-500 ml-2">${escapeHtml(job.id)}</span>
                    </td>
                    <td class="px-4 py-3 text-center">
                      <span class="px-2 py-1 rounded text-xs ${
                        job.primarySource === 'USER' ? 'bg-green-500/20 text-green-400' :
                        job.primarySource === 'CAREERNET' ? 'bg-blue-500/20 text-blue-400' :
                        'bg-purple-500/20 text-purple-400'
                      }">${job.primarySource}</span>
                    </td>
                    <td class="px-4 py-3 text-center text-sm text-slate-400">
                      ${formatTimestamp(job.hiddenAt)}
                    </td>
                    <td class="px-4 py-3 text-center">
                      <div class="flex items-center justify-center gap-2">
                        <button 
                          class="archive-restore-btn px-3 py-1 bg-green-600 hover:bg-green-500 rounded text-sm text-white transition-colors"
                          data-entity-type="job"
                          data-entity-id="${escapeHtml(job.id)}"
                          data-entity-name="${escapeHtml(job.name)}"
                        >
                          <i class="fas fa-undo mr-1"></i>복구
                        </button>
                        <button 
                          class="archive-delete-btn px-3 py-1 bg-red-600 hover:bg-red-500 rounded text-sm text-white transition-colors"
                          data-entity-type="job"
                          data-entity-id="${escapeHtml(job.id)}"
                          data-entity-name="${escapeHtml(job.name)}"
                        >
                          <i class="fas fa-trash-alt mr-1"></i>삭제
                        </button>
                      </div>
                    </td>
                  </tr>
                `).join('')}
              </tbody>
            </table>
          </div>
        ` : `
          <div class="p-8 text-center text-slate-400">
            <i class="fas fa-check-circle text-3xl mb-2 text-green-400"></i>
            <p>숨겨진 직업이 없습니다.</p>
          </div>
        `}
      </div>
      
      <!-- 숨겨진 전공 -->
      <div class="glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700/50">
          <h3 class="text-lg font-semibold">
            <i class="fas fa-graduation-cap text-purple-400 mr-2"></i>
            숨겨진 전공 <span class="text-slate-400 font-normal">(${hiddenMajors.length}건)</span>
          </h3>
        </div>
        
        ${hiddenMajors.length > 0 ? `
          <div class="overflow-x-auto">
            <table class="w-full">
              <thead class="bg-slate-800/50">
                <tr>
                  <th class="px-4 py-3 text-left text-slate-400 font-medium">전공명</th>
                  <th class="px-4 py-3 text-center text-slate-400 font-medium w-28">출처</th>
                  <th class="px-4 py-3 text-center text-slate-400 font-medium w-36">숨긴 일시</th>
                  <th class="px-4 py-3 text-center text-slate-400 font-medium w-44">작업</th>
                </tr>
              </thead>
              <tbody>
                ${hiddenMajors.map(major => `
                  <tr class="border-t border-slate-700/50 hover:bg-slate-700/20 transition-colors">
                    <td class="px-4 py-3">
                      <span class="text-white font-medium">${escapeHtml(major.name)}</span>
                      <span class="text-xs text-slate-500 ml-2">${escapeHtml(major.id)}</span>
                    </td>
                    <td class="px-4 py-3 text-center">
                      <span class="px-2 py-1 rounded text-xs ${
                        major.primarySource === 'USER' ? 'bg-green-500/20 text-green-400' :
                        major.primarySource === 'CAREERNET' ? 'bg-blue-500/20 text-blue-400' :
                        'bg-purple-500/20 text-purple-400'
                      }">${major.primarySource}</span>
                    </td>
                    <td class="px-4 py-3 text-center text-sm text-slate-400">
                      ${formatTimestamp(major.hiddenAt)}
                    </td>
                    <td class="px-4 py-3 text-center">
                      <div class="flex items-center justify-center gap-2">
                        <button 
                          class="archive-restore-btn px-3 py-1 bg-green-600 hover:bg-green-500 rounded text-sm text-white transition-colors"
                          data-entity-type="major"
                          data-entity-id="${escapeHtml(major.id)}"
                          data-entity-name="${escapeHtml(major.name)}"
                        >
                          <i class="fas fa-undo mr-1"></i>복구
                        </button>
                        <button 
                          class="archive-delete-btn px-3 py-1 bg-red-600 hover:bg-red-500 rounded text-sm text-white transition-colors"
                          data-entity-type="major"
                          data-entity-id="${escapeHtml(major.id)}"
                          data-entity-name="${escapeHtml(major.name)}"
                        >
                          <i class="fas fa-trash-alt mr-1"></i>삭제
                        </button>
                      </div>
                    </td>
                  </tr>
                `).join('')}
              </tbody>
            </table>
          </div>
        ` : `
          <div class="p-8 text-center text-slate-400">
            <i class="fas fa-check-circle text-3xl mb-2 text-green-400"></i>
            <p>숨겨진 전공이 없습니다.</p>
          </div>
        `}
      </div>
    </div>
  `
}

function renderHowtoReports(howtoReports?: AdminContentProps['howtoReports']): string {
  if (!howtoReports) return ''
  const items = howtoReports.items || []
  const total = howtoReports.total || 0
  const page = howtoReports.page || 1
  const totalPages = howtoReports.totalPages || 1

  return `
    <div class="glass-card rounded-xl overflow-hidden mt-6 sm:mt-8">
      <div class="p-4 border-b border-slate-700/50 flex items-center justify-between">
        <h3 class="text-lg font-semibold flex items-center gap-2">
          <i class="fas fa-flag text-rose-400"></i>
          신고된 HowTo <span class="text-slate-400 font-normal">(${total.toLocaleString()}건)</span>
        </h3>
        <div class="text-xs text-slate-400">상태: pending</div>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-slate-800/50">
            <tr>
              <th class="px-4 py-3 text-left text-slate-400 font-medium w-16">ID</th>
              <th class="px-4 py-3 text-left text-slate-400 font-medium">제목</th>
              <th class="px-4 py-3 text-left text-slate-400 font-medium w-32">신고 사유</th>
              <th class="px-4 py-3 text-left text-slate-400 font-medium w-48">세부 사유</th>
              <th class="px-4 py-3 text-left text-slate-400 font-medium w-28">일시</th>
              <th class="px-4 py-3 text-left text-slate-400 font-medium w-28">상태</th>
            </tr>
          </thead>
          <tbody>
            ${items.length ? items.map((item) => `
              <tr class="border-t border-slate-700/50 hover:bg-slate-700/20 transition-colors">
                <td class="px-4 py-3 text-slate-400 text-sm">${item.id}</td>
                <td class="px-4 py-3">
                  <a href="/howto/${item.pageSlug}" target="_blank" class="text-blue-400 hover:text-blue-300 font-medium">
                    ${escapeHtml(item.pageTitle || item.pageSlug)}
                  </a>
                </td>
                <td class="px-4 py-3 text-slate-200 text-sm">${escapeHtml(item.reasonType || '')}</td>
                <td class="px-4 py-3 text-slate-300 text-sm max-w-xs truncate" title="${escapeHtml(item.reasonDetail || '')}">
                  ${item.reasonDetail ? escapeHtml(item.reasonDetail) : '<span class="text-slate-500">-</span>'}
                </td>
                <td class="px-4 py-3 text-slate-400 text-sm">${formatDateTime(item.createdAt)}</td>
                <td class="px-4 py-3 text-slate-300 text-sm">${escapeHtml(item.status || 'pending')}</td>
              </tr>
            `).join('') : `
              <tr>
                <td colspan="6" class="px-4 py-12 text-center text-slate-400">
                  <i class="fas fa-inbox text-3xl mb-2"></i>
                  <p>신고된 HowTo가 없습니다.</p>
                </td>
              </tr>
            `}
          </tbody>
        </table>
      </div>
      ${totalPages > 1 ? `
        <div class="flex items-center justify-center gap-2 py-4">
          ${page > 1 ? `<a href="?tab=archive&page=${page - 1}" class="px-3 py-2 bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors"><i class="fas fa-chevron-left"></i></a>` : ''}
          ${generatePagination(page, totalPages).map(p => p === '...' ? '<span class="px-3 py-2 text-slate-500">...</span>' : `
            <a href="?tab=archive&page=${p}" class="px-3 py-2 ${Number(p) === page ? 'bg-amber-600 text-white' : 'bg-slate-700 hover:bg-slate-600 text-white'} rounded transition-colors">${p}</a>
          `).join('')}
          ${page < totalPages ? `<a href="?tab=archive&page=${page + 1}" class="px-3 py-2 bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors"><i class="fas fa-chevron-right"></i></a>` : ''}
        </div>
      ` : ''}
    </div>
  `
}

function renderCommentsModerationTab(moderation?: AdminContentProps['moderation']): string {
  const items = moderation?.items || []
  const total = moderation?.total || 0
  const page = moderation?.page || 1
  const perPage = moderation?.perPage || 20
  const totalPages = moderation?.totalPages || 1

  const pageLink = (item: NonNullable<AdminContentProps['moderation']>['items'][number]) => {
    if (item.pageType === 'job') return '/job/' + item.slug
    if (item.pageType === 'major') return '/major/' + item.slug
    return '/howto/' + item.slug
  }

  return `
    <div class="glass-card rounded-xl overflow-hidden mb-6">
      <div class="p-4 border-b border-slate-700/50">
        <h3 class="text-lg font-semibold flex items-center gap-2 mb-2 whitespace-nowrap">
          <i class="fas fa-comments text-rose-400"></i>
          댓글 모더레이션 <span class="text-slate-400 font-normal">(${total.toLocaleString()}건)</span>
        </h3>
        <div class="text-xs sm:text-sm text-slate-400">
          블라인드 또는 신고 누적된 댓글/대댓글 목록입니다.
        </div>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full min-w-[800px]">
          <thead class="bg-slate-800/50">
            <tr>
              <th class="px-2 sm:px-4 py-3 text-left text-slate-400 font-medium text-xs sm:text-sm whitespace-nowrap">ID</th>
              <th class="px-2 sm:px-4 py-3 text-left text-slate-400 font-medium text-xs sm:text-sm">내용</th>
              <th class="px-2 sm:px-4 py-3 text-left text-slate-400 font-medium text-xs sm:text-sm whitespace-nowrap">작성자</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium text-xs sm:text-sm whitespace-nowrap">상태</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium text-xs sm:text-sm whitespace-nowrap">신고</th>
              <th class="px-2 sm:px-4 py-3 text-center text-slate-400 font-medium text-xs sm:text-sm whitespace-nowrap">작업</th>
            </tr>
          </thead>
          <tbody>
            ${items.length ? items.map((item) => `
              <tr class="border-t border-slate-700/50 hover:bg-slate-700/20 transition-colors">
                <td class="px-2 sm:px-4 py-3 text-slate-400 text-xs sm:text-sm">${item.id}</td>
                <td class="px-2 sm:px-4 py-3">
                  <div class="text-slate-200 text-xs sm:text-sm line-clamp-2">${escapeHtml(item.content || '') || '<span class="text-slate-500">내용 없음</span>'}</div>
                  <div class="text-xs text-slate-500 mt-1 flex items-center gap-2 flex-wrap">
                    <a href="${pageLink(item)}#comments" target="_blank" class="text-blue-400 hover:text-blue-300">
                      <i class="fas fa-link mr-1"></i>${escapeHtml(item.title || item.slug)}
                    </a>
                    ${item.parentId ? '<span class="px-2 py-0.5 bg-slate-600/50 text-slate-300 rounded whitespace-nowrap">대댓글</span>' : '<span class="px-2 py-0.5 bg-slate-600/50 text-slate-300 rounded whitespace-nowrap">원댓글</span>'}
                  </div>
                </td>
                <td class="px-2 sm:px-4 py-3 text-slate-300 text-xs sm:text-sm">
                  <div class="font-medium whitespace-nowrap">${escapeHtml(item.nickname || (item.isAnonymous ? '익명' : '사용자'))}</div>
                  ${item.displayIp ? `<div class="text-xs text-slate-500">${escapeHtml(item.displayIp)}</div>` : ''}
                </td>
                <td class="px-2 sm:px-4 py-3 text-center">
                  <span class="px-2 py-1 rounded text-xs whitespace-nowrap ${
                    item.status === 'blinded'
                      ? 'bg-red-500/20 text-red-300'
                      : item.status === 'deleted'
                        ? 'bg-slate-600/50 text-slate-300'
                        : 'bg-green-500/20 text-green-300'
                  }">${item.status}</span>
                </td>
                <td class="px-2 sm:px-4 py-3 text-center text-xs sm:text-sm text-slate-200 whitespace-nowrap">${item.reportCount}</td>
                <td class="px-2 sm:px-4 py-3 text-center">
                  <div class="flex items-center justify-center gap-1 sm:gap-2 flex-wrap">
                    ${item.status === 'blinded' ? `
                      <button class="mod-action px-2 sm:px-3 py-1 text-[10px] sm:text-xs bg-emerald-600 hover:bg-emerald-500 text-white rounded whitespace-nowrap" data-action="unblind" data-id="${item.id}">
                        <span class="hidden sm:inline">블라인드 해제</span>
                        <span class="sm:hidden">해제</span>
                      </button>
                    ` : `
                      <button class="mod-action px-2 sm:px-3 py-1 text-[10px] sm:text-xs bg-amber-600 hover:bg-amber-500 text-white rounded whitespace-nowrap" data-action="blind" data-id="${item.id}">
                        블라인드
                      </button>
                    `}
                    <button class="mod-action px-2 sm:px-3 py-1 text-[10px] sm:text-xs bg-slate-700 hover:bg-slate-600 text-white rounded whitespace-nowrap" data-action="reset" data-id="${item.id}">
                      <span class="hidden sm:inline">신고 초기화</span>
                      <span class="sm:hidden">초기화</span>
                    </button>
                    <button class="mod-action px-2 sm:px-3 py-1 text-[10px] sm:text-xs bg-red-600 hover:bg-red-500 text-white rounded whitespace-nowrap" data-action="delete" data-id="${item.id}">
                      삭제
                    </button>
                  </div>
                </td>
              </tr>
            `).join('') : `
              <tr>
                <td colspan="6" class="px-2 sm:px-4 py-12 text-center text-slate-400">
                  <i class="fas fa-inbox text-3xl mb-2"></i>
                  <p class="text-sm sm:text-base">블라인드/신고된 댓글이 없습니다.</p>
                </td>
              </tr>
            `}
          </tbody>
        </table>
      </div>
    </div>

    ${totalPages > 1 ? `
      <div class="flex items-center justify-center gap-2 mb-6">
        ${page > 1 ? `<a href="?tab=comments&page=${page - 1}&perPage=${perPage}" class="px-3 py-2 bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors"><i class="fas fa-chevron-left"></i></a>` : ''}
        ${generatePagination(page, totalPages).map(p => p === '...' ? '<span class="px-3 py-2 text-slate-500">...</span>' : `
          <a href="?tab=comments&page=${p}&perPage=${perPage}" class="px-3 py-2 ${Number(p) === page ? 'bg-rose-600 text-white' : 'bg-slate-700 hover:bg-slate-600 text-white'} rounded transition-colors">${p}</a>
        `).join('')}
        ${page < totalPages ? `<a href="?tab=comments&page=${page + 1}&perPage=${perPage}" class="px-3 py-2 bg-slate-700 hover:bg-slate-600 rounded text-white transition-colors"><i class="fas fa-chevron-right"></i></a>` : ''}
      </div>
    ` : ''}

    <script>
      async function runModAction(action, id, btn) {
        const endpoints = {
          blind: '/api/admin/comments/' + id + '/blind',
          unblind: '/api/admin/comments/' + id + '/unblind',
          reset: '/api/admin/comments/' + id + '/reset-reports',
          delete: '/api/admin/comments/' + id
        };
        const method = action === 'delete' ? 'DELETE' : 'POST';
        try {
          btn.disabled = true;
          btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
          const res = await fetch(endpoints[action], { method, headers: { "Content-Type": "application/json" } });
          const data = await res.json().catch(() => ({}));
          if (!data.success) {
            alert(data.error || '실패했습니다.');
            btn.disabled = false;
            btn.innerHTML = btn.dataset.original || btn.textContent;
            return;
          }
          location.reload();
        } catch (err) {
          alert('요청 실패: ' + err.message);
          btn.disabled = false;
          btn.innerHTML = btn.dataset.original || btn.textContent;
        }
      }

      document.querySelectorAll('.mod-action').forEach(btn => {
        btn.dataset.original = btn.textContent;
        btn.addEventListener('click', () => {
          const action = btn.dataset.action;
          const id = btn.dataset.id;
          if (action === 'delete') {
            if (!confirm('해당 댓글을 삭제하시겠습니까? (대댓글 포함)')) return;
          }
          runModAction(action, id, btn);
        });
      });
    </script>
  `
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, m => map[m])
}

function formatDateTime(dateStr: string): string {
  const date = new Date(dateStr)
  return date.toLocaleDateString('ko-KR', { 
    month: 'short', 
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

function formatTimestamp(ts: number): string {
  if (!ts) return '-'
  const date = new Date(ts)
  return date.toLocaleDateString('ko-KR', { 
    month: 'short', 
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

function formatChangeType(type: string | null): string {
  const types: Record<string, string> = {
    initial: '최초',
    edit: '편집',
    restore: '복원',
    merge: '병합'
  }
  return types[type || ''] || type || '편집'
}

function formatChangedFields(fieldsJson: string): string {
  try {
    const fields = JSON.parse(fieldsJson)
    if (Array.isArray(fields)) {
      return fields.slice(0, 3).join(', ') + (fields.length > 3 ? ` 외 ${fields.length - 3}개` : '')
    }
  } catch {
    // ignore
  }
  return fieldsJson
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
