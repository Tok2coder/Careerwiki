/**
 * 유사 이름 병합 관리 UI
 * /similar-names 페이지
 * 데이터는 클라이언트에서 비동기로 로드
 */

interface AdminSimilarNamesProps {
  type: 'job' | 'major'
}

export function renderAdminSimilarNamesPage({ type }: AdminSimilarNamesProps): string {
  const typeLabel = type === 'job' ? '직업' : '전공'

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>유사 이름 병합 관리 - ${typeLabel} | Careerwiki</title>
  <link rel="stylesheet" href="/static/tailwind.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); min-height: 100vh; }
    .glass-card {
      background: rgba(30, 41, 59, 0.8);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(148, 163, 184, 0.1);
    }
    .highlight-row:hover { background: rgba(59, 130, 246, 0.1); }
    .checkbox-custom:checked { background-color: #3b82f6; border-color: #3b82f6; }
    .loading-spinner {
      border: 3px solid rgba(59, 130, 246, 0.3);
      border-top-color: #3b82f6;
      animation: spin 1s linear infinite;
    }
    @keyframes spin { to { transform: rotate(360deg); } }
  </style>
</head>
<body class="text-slate-200">
  <div class="container mx-auto px-4 py-8 max-w-7xl">
    <!-- Header -->
    <div class="flex items-center justify-between mb-8">
      <div>
        <h1 class="text-3xl font-bold text-white mb-2">
          <i class="fas fa-code-merge mr-3 text-blue-400"></i>
          유사 이름 병합 관리
        </h1>
        <p class="text-slate-400">
          이름이 유사하지만 별도로 저장된 ${typeLabel} 데이터를 찾아 병합합니다.
        </p>
      </div>
      <a href="/" class="px-4 py-2 bg-slate-700 hover:bg-slate-600 rounded-lg transition-colors">
        <i class="fas fa-home mr-2"></i>홈으로
      </a>
    </div>

    <!-- Tab Navigation -->
    <div class="flex gap-2 mb-6">
      <a href="/similar-names?type=job" 
         class="px-6 py-3 rounded-lg font-medium transition-all ${type === 'job' 
           ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' 
           : 'bg-slate-700 text-slate-300 hover:bg-slate-600'}">
        <i class="fas fa-briefcase mr-2"></i>직업
      </a>
      <a href="/similar-names?type=major" 
         class="px-6 py-3 rounded-lg font-medium transition-all ${type === 'major' 
           ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' 
           : 'bg-slate-700 text-slate-300 hover:bg-slate-600'}">
        <i class="fas fa-graduation-cap mr-2"></i>전공
      </a>
    </div>

    <!-- Error Container (hidden by default) -->
    <div id="errorContainer" class="hidden glass-card rounded-xl p-6 mb-6 border-red-500/30 bg-red-500/10">
      <div class="flex items-center gap-3">
        <i class="fas fa-exclamation-circle text-red-400 text-xl"></i>
        <div>
          <h3 class="font-semibold text-red-300">오류가 발생했습니다</h3>
          <p id="errorMessage" class="text-slate-400"></p>
        </div>
      </div>
    </div>

    <!-- Loading State -->
    <div id="loadingState" class="glass-card rounded-xl p-12 text-center">
      <div class="loading-spinner w-12 h-12 rounded-full mx-auto mb-4"></div>
      <p class="text-slate-400">데이터를 분석하는 중... (직업/전공 수에 따라 시간이 걸릴 수 있습니다)</p>
    </div>

    <!-- Content Container (hidden until data loads) -->
    <div id="contentContainer" class="hidden">
      <!-- Stats Cards -->
      <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
        <div class="glass-card rounded-xl p-5">
          <div class="flex items-center gap-3">
            <div class="w-12 h-12 bg-blue-500/20 rounded-lg flex items-center justify-center">
              <i class="fas fa-database text-blue-400 text-xl"></i>
            </div>
            <div>
              <p id="statTotalNames" class="text-2xl font-bold text-white">-</p>
              <p class="text-slate-400 text-sm">총 ${typeLabel} 이름</p>
            </div>
          </div>
        </div>
        <div class="glass-card rounded-xl p-5">
          <div class="flex items-center gap-3">
            <div class="w-12 h-12 bg-yellow-500/20 rounded-lg flex items-center justify-center">
              <i class="fas fa-random text-yellow-400 text-xl"></i>
            </div>
            <div>
              <p id="statSimilarPairs" class="text-2xl font-bold text-white">-</p>
              <p class="text-slate-400 text-sm">유사 후보 쌍</p>
            </div>
          </div>
        </div>
        <div class="glass-card rounded-xl p-5">
          <div class="flex items-center gap-3">
            <div class="w-12 h-12 bg-purple-500/20 rounded-lg flex items-center justify-center">
              <i class="fas fa-clone text-purple-400 text-xl"></i>
            </div>
            <div>
              <p id="statDuplicates" class="text-2xl font-bold text-white">-</p>
              <p class="text-slate-400 text-sm">정규화 중복</p>
            </div>
          </div>
        </div>
        <div class="glass-card rounded-xl p-5">
          <div class="flex items-center gap-3">
            <div class="w-12 h-12 bg-green-500/20 rounded-lg flex items-center justify-center">
              <i class="fas fa-link text-green-400 text-xl"></i>
            </div>
            <div>
              <p id="statMappings" class="text-2xl font-bold text-white">-</p>
              <p class="text-slate-400 text-sm">저장된 매핑</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Filter Bar -->
      <div class="glass-card rounded-xl p-4 mb-4 flex items-center gap-6">
        <span class="text-slate-400 text-sm">필터:</span>
        <label class="flex items-center gap-2 cursor-pointer">
          <input type="checkbox" id="filterSingleSource" class="w-4 h-4 rounded border-slate-500 bg-slate-700 checkbox-custom">
          <span class="text-sm">소스 1개씩만 (병합 대상)</span>
        </label>
        <span id="filteredCount" class="text-slate-500 text-sm ml-auto"></span>
      </div>

      <!-- Action Bar -->
      <div class="glass-card rounded-xl p-4 mb-6 flex items-center justify-between">
        <div class="flex items-center gap-4">
          <span id="selectedCount" class="text-slate-400">0개 선택됨</span>
          <button id="selectAllBtn" class="px-3 py-1.5 bg-slate-600 hover:bg-slate-500 rounded text-sm transition-colors">
            <i class="fas fa-check-double mr-1"></i>전체 선택
          </button>
          <button id="deselectAllBtn" class="px-3 py-1.5 bg-slate-600 hover:bg-slate-500 rounded text-sm transition-colors">
            <i class="fas fa-times mr-1"></i>선택 해제
          </button>
        </div>
        <button id="copyMappingsBtn" class="px-5 py-2.5 bg-green-600 hover:bg-green-500 rounded-lg font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed" disabled>
          <i class="fas fa-copy mr-2"></i>선택한 매핑 복사
        </button>
      </div>

      <!-- Similar Pairs Table -->
      <div class="glass-card rounded-xl overflow-hidden mb-8">
        <div class="p-4 border-b border-slate-700">
          <h2 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-random text-yellow-400"></i>
            유사 이름 후보
          </h2>
        </div>
        <div class="overflow-x-auto">
          <table class="w-full">
            <thead class="bg-slate-800/50">
              <tr>
                <th class="px-4 py-3 text-left text-slate-400 font-medium w-12">
                  <input type="checkbox" id="headerCheckbox" class="w-4 h-4 rounded border-slate-500 bg-slate-700 checkbox-custom">
                </th>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">이름 1</th>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">이름 2</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium w-24">유사도</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium w-28">매칭 유형</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium w-32">소스</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium w-24">방향</th>
              </tr>
            </thead>
            <tbody id="pairsTableBody">
              <!-- Filled by JavaScript -->
            </tbody>
          </table>
        </div>
      </div>

      <!-- Normalized Duplicates -->
      <div id="duplicatesSection" class="hidden glass-card rounded-xl overflow-hidden mb-8">
        <div class="p-4 border-b border-slate-700">
          <h2 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-clone text-purple-400"></i>
            정규화 후 중복 (띄어쓰기/특수문자 제거 시 동일)
          </h2>
          <p class="text-sm text-slate-400 mt-1">
            기존 ETL에서 이미 병합되었어야 하지만 놓친 항목들입니다.
          </p>
        </div>
        <div id="duplicatesContent" class="p-4 space-y-3">
          <!-- Filled by JavaScript -->
        </div>
      </div>

      <!-- Existing Mappings -->
      <div id="mappingsSection" class="hidden glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700">
          <h2 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-link text-green-400"></i>
            저장된 매핑 (<span id="mappingsCount">0</span>개)
          </h2>
        </div>
        <div class="overflow-x-auto">
          <table class="w-full">
            <thead class="bg-slate-800/50">
              <tr>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">Source → Target</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium w-24">유사도</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium w-28">매칭 유형</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium w-40">생성일</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium w-20">삭제</th>
              </tr>
            </thead>
            <tbody id="mappingsTableBody">
              <!-- Filled by JavaScript -->
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Toast Container -->
  <div id="toastContainer" class="fixed bottom-4 right-4 z-50 space-y-2"></div>

  <script>
    const TYPE = '${type}';
    let pairsData = [];

    // Helper functions
    function escapeHtml(text) {
      const map = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' };
      return String(text).replace(/[&<>"']/g, m => map[m]);
    }

    function formatScore(score) {
      return (score * 100).toFixed(1) + '%';
    }

    function getScoreColor(score) {
      if (score >= 0.95) return 'text-green-400';
      if (score >= 0.85) return 'text-emerald-400';
      if (score >= 0.75) return 'text-yellow-400';
      return 'text-orange-400';
    }

    function getMatchTypeLabel(matchType) {
      const labels = { exact: '완전 일치', normalized: '정규화 일치', contains: '포함 관계', levenshtein: '레벤슈타인', keyword: '키워드 유사' };
      return labels[matchType] || matchType;
    }

    function getMatchTypeBadgeClass(matchType) {
      const classes = { exact: 'bg-green-500/20 text-green-400', normalized: 'bg-blue-500/20 text-blue-400', contains: 'bg-purple-500/20 text-purple-400', levenshtein: 'bg-yellow-500/20 text-yellow-400', keyword: 'bg-orange-500/20 text-orange-400' };
      return classes[matchType] || 'bg-gray-500/20 text-gray-400';
    }

    function formatSource(source) {
      const labels = { CAREERNET: '커리어넷', WORK24_JOB: '고용24직업', WORK24_DJOB: '고용24사전', WORK24_MAJOR: '고용24전공' };
      return labels[source] || source;
    }

    function formatSources(sources) {
      return (sources || []).map(formatSource).join(', ');
    }

    function showToast(message, type = 'info') {
      const container = document.getElementById('toastContainer');
      const toast = document.createElement('div');
      const bgClass = type === 'success' ? 'bg-green-600' : type === 'error' ? 'bg-red-600' : 'bg-blue-600';
      toast.className = bgClass + ' text-white px-4 py-3 rounded-lg shadow-lg flex items-center gap-2';
      toast.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle') + '"></i><span>' + message + '</span>';
      container.appendChild(toast);
      setTimeout(() => toast.remove(), 3000);
    }

    function showError(message) {
      document.getElementById('loadingState').classList.add('hidden');
      document.getElementById('errorContainer').classList.remove('hidden');
      document.getElementById('errorMessage').textContent = message;
    }

    function updateSelectedCount() {
      const checkboxes = document.querySelectorAll('.pair-checkbox:checked:not(:disabled)');
      const count = checkboxes.length;
      document.getElementById('selectedCount').textContent = count + '개 선택됨';
      document.getElementById('copyMappingsBtn').disabled = count === 0;
    }

    function renderPairsTable(pairs) {
      const tbody = document.getElementById('pairsTableBody');
      if (pairs.length === 0) {
        tbody.innerHTML = '<tr><td colspan="7" class="px-4 py-8 text-center text-slate-400"><i class="fas fa-check-circle text-green-400 text-2xl mb-2"></i><p>유사도 60% 이상인 후보가 없습니다.</p></td></tr>';
        return;
      }

      tbody.innerHTML = pairs.map((pair, index) => {
        const defaultDir = (pair.sourceCount1 || 0) < (pair.sourceCount2 || 0) ? '1to2' : '2to1';
        const srcLen1 = (pair.sources1 && pair.sources1.length) || 0;
        const srcLen2 = (pair.sources2 && pair.sources2.length) || 0;
        return '<tr class="border-t border-slate-700/50 highlight-row ' + (pair.alreadyMapped ? 'opacity-50' : '') + '" data-index="' + index + '">' +
          '<td class="px-4 py-3"><input type="checkbox" class="pair-checkbox w-4 h-4 rounded border-slate-500 bg-slate-700 checkbox-custom" data-index="' + index + '" ' + (pair.alreadyMapped ? 'disabled title="이미 매핑됨"' : '') + '></td>' +
          '<td class="px-4 py-3"><span class="font-medium text-white">' + escapeHtml(pair.name1) + '</span>' + (srcLen1 ? '<span class="ml-2 text-xs text-slate-500">(' + srcLen1 + ')</span>' : '') + '</td>' +
          '<td class="px-4 py-3"><span class="font-medium text-white">' + escapeHtml(pair.name2) + '</span>' + (srcLen2 ? '<span class="ml-2 text-xs text-slate-500">(' + srcLen2 + ')</span>' : '') + '</td>' +
          '<td class="px-4 py-3 text-center"><span class="font-mono ' + getScoreColor(pair.score) + '">' + formatScore(pair.score) + '</span></td>' +
          '<td class="px-4 py-3 text-center"><span class="px-2 py-1 rounded text-xs ' + getMatchTypeBadgeClass(pair.matchType) + '">' + getMatchTypeLabel(pair.matchType) + '</span></td>' +
          '<td class="px-4 py-3 text-center text-xs">' + 
            '<div class="text-blue-300">' + formatSources(pair.sources1) + '</div>' +
            '<div class="text-green-300">' + formatSources(pair.sources2) + '</div>' +
          '</td>' +
          '<td class="px-4 py-3 text-center"><select class="direction-select bg-slate-700 border border-slate-600 rounded px-2 py-1 text-sm" data-index="' + index + '">' +
            '<option value="1to2" ' + (defaultDir === '1to2' ? 'selected' : '') + '>' + escapeHtml(pair.name1).substring(0, 8) + '→' + escapeHtml(pair.name2).substring(0, 8) + '</option>' +
            '<option value="2to1" ' + (defaultDir === '2to1' ? 'selected' : '') + '>' + escapeHtml(pair.name2).substring(0, 8) + '→' + escapeHtml(pair.name1).substring(0, 8) + '</option>' +
          '</select></td>' +
        '</tr>';
      }).join('');

      // Add event listeners
      document.querySelectorAll('.pair-checkbox').forEach(cb => {
        cb.addEventListener('change', updateSelectedCount);
      });
    }

    function renderDuplicates(duplicates) {
      if (duplicates.length === 0) return;
      
      document.getElementById('duplicatesSection').classList.remove('hidden');
      document.getElementById('duplicatesContent').innerHTML = duplicates.map(dup => 
        '<div class="bg-slate-800/50 rounded-lg p-3">' +
          '<div class="text-xs text-slate-500 mb-2">정규화: ' + escapeHtml(dup.normalized) + '</div>' +
          '<div class="flex flex-wrap gap-2">' +
            dup.originals.map(orig => '<span class="px-2 py-1 bg-purple-500/20 text-purple-300 rounded text-sm">' + escapeHtml(orig) + '</span>').join('') +
          '</div>' +
        '</div>'
      ).join('');
    }

    function renderMappings(mappings) {
      if (mappings.length === 0) return;
      
      document.getElementById('mappingsSection').classList.remove('hidden');
      document.getElementById('mappingsCount').textContent = mappings.length;
      document.getElementById('mappingsTableBody').innerHTML = mappings.map(m =>
        '<tr class="border-t border-slate-700/50 highlight-row">' +
          '<td class="px-4 py-3"><span class="text-orange-300">' + escapeHtml(m.sourceName) + '</span><i class="fas fa-arrow-right mx-2 text-slate-500"></i><span class="text-green-300">' + escapeHtml(m.targetName) + '</span></td>' +
          '<td class="px-4 py-3 text-center">' + (m.similarityScore ? '<span class="font-mono ' + getScoreColor(m.similarityScore) + '">' + formatScore(m.similarityScore) + '</span>' : '-') + '</td>' +
          '<td class="px-4 py-3 text-center">' + (m.matchReason ? '<span class="px-2 py-1 rounded text-xs ' + getMatchTypeBadgeClass(m.matchReason) + '">' + getMatchTypeLabel(m.matchReason) + '</span>' : '-') + '</td>' +
          '<td class="px-4 py-3 text-center text-slate-400 text-sm">' + new Date(m.createdAt).toLocaleDateString('ko-KR') + '</td>' +
          '<td class="px-4 py-3 text-center"><button class="delete-mapping-btn text-red-400 hover:text-red-300 transition-colors" data-id="' + m.id + '"><i class="fas fa-trash"></i></button></td>' +
        '</tr>'
      ).join('');

      // Add delete listeners
      document.querySelectorAll('.delete-mapping-btn').forEach(btn => {
        btn.addEventListener('click', async () => {
          if (!confirm('이 매핑을 삭제하시겠습니까?')) return;
          try {
            const response = await fetch('/api/name-mappings/' + btn.dataset.id, { method: 'DELETE' });
            const result = await response.json();
            if (result.success) {
              showToast('매핑이 삭제되었습니다.', 'success');
              btn.closest('tr').remove();
            } else {
              showToast('삭제 실패: ' + result.error, 'error');
            }
          } catch (err) {
            showToast('요청 실패: ' + err.message, 'error');
          }
        });
      });
    }

    // Load data
    async function loadData() {
      try {
        const response = await fetch('/api/similar-names/' + TYPE + '?minScore=0.6');
        const result = await response.json();

        if (!result.success) {
          showError(result.error || '데이터를 불러오는데 실패했습니다.');
          return;
        }

        const data = result.data;
        pairsData = data.similarPairs;

        // Update stats
        document.getElementById('statTotalNames').textContent = data.totalNames.toLocaleString();
        document.getElementById('statSimilarPairs').textContent = data.similarPairs.length;
        document.getElementById('statDuplicates').textContent = data.normalizedDuplicates.length;
        document.getElementById('statMappings').textContent = data.existingMappings.length;

        // Render tables
        renderPairsTable(data.similarPairs);
        renderDuplicates(data.normalizedDuplicates);
        renderMappings(data.existingMappings);

        // Show content
        document.getElementById('loadingState').classList.add('hidden');
        document.getElementById('contentContainer').classList.remove('hidden');

      } catch (err) {
        showError('데이터 로드 실패: ' + err.message);
      }
    }

    // Filter function
    function applyFilter() {
      const filterSingleSource = document.getElementById('filterSingleSource').checked;
      const rows = document.querySelectorAll('#pairsTableBody tr[data-index]');
      let visibleCount = 0;
      
      rows.forEach((row) => {
        const index = parseInt(row.getAttribute('data-index'));
        const pair = pairsData[index];
        if (!pair) return;
        
        // 소스 시스템 개수로 필터 (sourceCount가 아니라 sources 배열의 길이)
        // sources1.length = 소스 시스템 수 (예: ['CAREERNET'] = 1, ['CAREERNET', 'WORK24_MAJOR'] = 2)
        const src1Len = (pair.sources1 && pair.sources1.length) || 0;
        const src2Len = (pair.sources2 && pair.sources2.length) || 0;
        const isSingleSource = (src1Len === 1) && (src2Len === 1);
        
        if (filterSingleSource && !isSingleSource) {
          row.style.display = 'none';
        } else {
          row.style.display = '';
          visibleCount++;
        }
      });
      
      document.getElementById('filteredCount').textContent = filterSingleSource ? 
        visibleCount + '개 표시 중' : '';
    }

    document.getElementById('filterSingleSource')?.addEventListener('change', applyFilter);

    // Event listeners
    document.getElementById('headerCheckbox')?.addEventListener('change', (e) => {
      document.querySelectorAll('.pair-checkbox:not(:disabled)').forEach(cb => { 
        if (cb.closest('tr').style.display !== 'none') {
          cb.checked = e.target.checked; 
        }
      });
      updateSelectedCount();
    });

    document.getElementById('selectAllBtn')?.addEventListener('click', () => {
      document.querySelectorAll('.pair-checkbox:not(:disabled)').forEach(cb => { 
        if (cb.closest('tr').style.display !== 'none') {
          cb.checked = true; 
        }
      });
      document.getElementById('headerCheckbox').checked = true;
      updateSelectedCount();
    });

    document.getElementById('deselectAllBtn')?.addEventListener('click', () => {
      document.querySelectorAll('.pair-checkbox').forEach(cb => { cb.checked = false; });
      document.getElementById('headerCheckbox').checked = false;
      updateSelectedCount();
    });

    document.getElementById('copyMappingsBtn')?.addEventListener('click', async () => {
      const mappings = [];
      document.querySelectorAll('.pair-checkbox:checked:not(:disabled)').forEach(cb => {
        const index = parseInt(cb.dataset.index);
        const row = cb.closest('tr');
        const direction = row.querySelector('.direction-select').value;
        const pair = pairsData[index];
        
        if (pair) {
          const sourceName = direction === '1to2' ? pair.name1 : pair.name2;
          const targetName = direction === '1to2' ? pair.name2 : pair.name1;
          mappings.push({ type: TYPE, sourceName, targetName, score: pair.score, matchType: pair.matchType });
        }
      });

      // JSON 형식으로 클립보드에 복사
      const text = JSON.stringify(mappings, null, 2);
      try {
        await navigator.clipboard.writeText(text);
        showToast(mappings.length + '개 매핑이 클립보드에 복사되었습니다.', 'success');
      } catch (err) {
        // 폴백: 텍스트 영역으로 복사
        const textarea = document.createElement('textarea');
        textarea.value = text;
        document.body.appendChild(textarea);
        textarea.select();
        document.execCommand('copy');
        document.body.removeChild(textarea);
        showToast(mappings.length + '개 매핑이 클립보드에 복사되었습니다.', 'success');
      }
    });

    // Start loading
    loadData();
  </script>
</body>
</html>`
}
