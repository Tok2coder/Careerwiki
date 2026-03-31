/**
 * 관리자 직업 데이터 보완 현황 대시보드
 * - DB 실시간 조회 (user_contributed_json 파싱)
 * - 12개 필드별 완성도
 * - 클라이언트 사이드 필터/정렬/검색/페이지네이션
 */

import { renderAdminLayout } from './adminLayout'

export const EQUALIZE_FIELDS = [
  'way', 'overviewSalary', 'overviewProspect', 'trivia',
  'detailWlb', 'detailReady', 'sidebarJobs', 'sidebarMajors',
  'sidebarCerts', 'heroTags', 'youtubeLinks', '_sources',
] as const

export const EQUALIZE_FIELD_LABELS: Record<string, string> = {
  way: '진입방법',
  overviewSalary: '임금',
  overviewProspect: '전망',
  trivia: '여담',
  detailWlb: '워라밸',
  detailReady: '준비방법',
  sidebarJobs: '관련직업',
  sidebarMajors: '관련전공',
  sidebarCerts: '자격증',
  heroTags: '태그',
  youtubeLinks: 'YouTube',
  _sources: '출처',
}

export const EQUALIZE_FIELD_TOOLTIPS: Record<string, string> = {
  way: 'way 필드 — 직업 진입 경로/방법 정보',
  overviewSalary: 'overviewSalary 필드 — 급여/임금 정보',
  overviewProspect: 'overviewProspect 필드 — 직업 전망 정보',
  trivia: 'trivia 필드 — 여담/재미있는 사실',
  detailWlb: 'detailWlb 필드 — 워라밸 상세 정보',
  detailReady: 'detailReady 필드 — 준비 방법 상세',
  sidebarJobs: 'sidebarJobs 필드 — 관련 직업 목록',
  sidebarMajors: 'sidebarMajors 필드 — 관련 전공 목록',
  sidebarCerts: 'sidebarCerts 필드 — 관련 자격증 목록',
  heroTags: 'heroTags 필드 — 직업 태그 배열',
  youtubeLinks: 'youtubeLinks 필드 — YouTube 관련 영상 링크',
  _sources: '_sources 필드 — 출처 정보 존재 여부',
}

export interface JobEqualizeItem {
  name: string
  slug: string
  fields: boolean[]   // 12 fields in EQUALIZE_FIELDS order
  fieldCount: number   // X/12
  jsonSize: number     // bytes
  sourceCount: number  // 출처 총 항목 수
  urlSourceCount: number // URL이 포함된 출처 수
  youtubeCount: number
}

export interface AdminJobEqualizeProps {
  totalJobs: number
  contributedCount: number
  perfectCount: number    // 12/12
  poorCount: number       // <6
  avgJsonSize: number
  items: JobEqualizeItem[]
}

/** Check if a field has meaningful content */
export function hasField(json: any, key: string): boolean {
  const val = json[key]
  if (val === null || val === undefined) return false
  if (typeof val === 'string') return val.trim().length > 0
  if (Array.isArray(val)) return val.length > 0
  if (typeof val === 'object') return Object.keys(val).length > 0
  return true
}

/**
 * _sources 파싱: 다양한 구조 처리
 * 1. Object: {"way":[{"id":1,"text":"...","url":"..."}]} → 모든 섹션 배열 합산
 * 2. Array: ["워크넷", "한국가스공사"] or [{text, url}] → 배열 길이
 * 3. null/undefined → 0
 */
export function parseSources(sources: any): { sourceCount: number; urlSourceCount: number } {
  if (!sources) return { sourceCount: 0, urlSourceCount: 0 }

  // Case 1: Array (flat list or array of objects)
  if (Array.isArray(sources)) {
    const sourceCount = sources.length
    let urlSourceCount = 0
    for (const s of sources) {
      if (typeof s === 'string' && s.startsWith('http')) {
        urlSourceCount++
      } else if (typeof s === 'object' && s !== null && typeof s.url === 'string' && s.url.startsWith('http')) {
        urlSourceCount++
      }
    }
    return { sourceCount, urlSourceCount }
  }

  // Case 2: Object with section keys (e.g. {"way": [...], "overviewSalary": [...]})
  if (typeof sources === 'object') {
    let sourceCount = 0
    let urlSourceCount = 0
    for (const key of Object.keys(sources)) {
      const arr = sources[key]
      if (Array.isArray(arr)) {
        sourceCount += arr.length
        for (const s of arr) {
          if (typeof s === 'string' && s.startsWith('http')) {
            urlSourceCount++
          } else if (typeof s === 'object' && s !== null && typeof s.url === 'string' && s.url.startsWith('http')) {
            urlSourceCount++
          }
        }
      }
    }
    return { sourceCount, urlSourceCount }
  }

  return { sourceCount: 0, urlSourceCount: 0 }
}

export function renderAdminJobEqualize(props: AdminJobEqualizeProps): string {
  const { totalJobs, contributedCount, perfectCount, poorCount, avgJsonSize, items } = props
  const uncontributed = totalJobs - contributedCount
  const progressPct = totalJobs > 0 ? ((contributedCount / totalJobs) * 100).toFixed(1) : '0.0'

  const itemsJson = JSON.stringify(items)

  const content = `
    <!-- 요약 통계 KPI -->
    <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3 mb-6">
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-blue-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-briefcase text-blue-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">전체 직업</span>
        </div>
        <div class="text-xl font-bold text-white">${totalJobs.toLocaleString()}</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-emerald-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-check-circle text-emerald-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">보완 완료</span>
        </div>
        <div class="text-xl font-bold text-emerald-400">${contributedCount}</div>
        <div class="text-[10px] text-slate-500">${progressPct}%</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-green-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-star text-green-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">완벽 (12/12)</span>
        </div>
        <div class="text-xl font-bold text-green-400">${perfectCount}</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-red-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-exclamation-triangle text-red-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">부실 (&lt;6)</span>
        </div>
        <div class="text-xl font-bold text-red-400">${poorCount}</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-slate-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-minus-circle text-slate-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">미보완</span>
        </div>
        <div class="text-xl font-bold text-slate-400">${uncontributed.toLocaleString()}</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-purple-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-database text-purple-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">평균 JSON</span>
        </div>
        <div class="text-xl font-bold text-purple-400">${avgJsonSize > 1024 ? (avgJsonSize / 1024).toFixed(1) + 'KB' : avgJsonSize + 'B'}</div>
      </div>
    </div>

    <!-- 진행률 바 -->
    <div class="glass-card rounded-xl p-4 mb-6">
      <div class="flex items-center justify-between mb-2">
        <h3 class="text-sm font-semibold text-white">전체 진행률</h3>
        <span class="text-sm font-bold text-emerald-400">${contributedCount} / ${totalJobs.toLocaleString()}</span>
      </div>
      <div class="w-full bg-slate-700/60 rounded-full h-2.5 overflow-hidden">
        <div class="h-2.5 rounded-full bg-gradient-to-r from-emerald-500 to-emerald-400" style="width: ${progressPct}%"></div>
      </div>
    </div>

    <!-- 필터/검색 바 -->
    <div class="glass-card rounded-xl p-4 mb-4">
      <div class="flex flex-wrap items-center gap-3">
        <!-- 검색 -->
        <div class="relative flex-1 min-w-[200px]">
          <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-slate-500 text-xs"></i>
          <input id="searchInput" type="text" placeholder="직업명 검색..."
            class="w-full pl-9 pr-3 py-2 bg-slate-800/60 border border-slate-600/50 rounded-lg text-sm text-white placeholder-slate-500 focus:outline-none focus:border-blue-500/50" />
        </div>
        <!-- 필터 -->
        <select id="filterSelect" class="px-3 py-2 bg-slate-800/60 border border-slate-600/50 rounded-lg text-sm text-white focus:outline-none focus:border-blue-500/50">
          <option value="all">전체 (${contributedCount})</option>
          <option value="perfect">완벽 12/12 (${perfectCount})</option>
          <option value="good">양호 6~11 (${contributedCount - perfectCount - poorCount})</option>
          <option value="poor">부실 &lt;6 (${poorCount})</option>
        </select>
        <!-- 정렬 -->
        <select id="sortSelect" class="px-3 py-2 bg-slate-800/60 border border-slate-600/50 rounded-lg text-sm text-white focus:outline-none focus:border-blue-500/50">
          <option value="name-asc">이름순 ↑</option>
          <option value="name-desc">이름순 ↓</option>
          <option value="field-desc">완성도 높은순</option>
          <option value="field-asc">완성도 낮은순</option>
          <option value="size-desc">JSON 큰순</option>
          <option value="size-asc">JSON 작은순</option>
        </select>
      </div>
      <div class="mt-2 text-xs text-slate-500">
        <span id="resultCount">${contributedCount}</span>개 직업 표시 중
      </div>
    </div>

    <!-- 직업 목록 테이블 -->
    <div class="glass-card rounded-xl overflow-hidden">
      <div class="overflow-x-auto admin-mini-scroll">
        <table class="w-full text-sm">
          <thead>
            <tr class="text-left border-b border-slate-700/50 bg-slate-800/40">
              <th class="px-4 py-3 text-xs text-slate-400 font-medium sticky left-0 bg-slate-800/90 z-10 min-w-[140px]" title="직업명 (클릭하면 프로덕션 페이지로 이동)">직업명</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[60px]" title="12개 필드 중 채워진 필드 수 (n/12)">완성도</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="way 필드 — 직업 진입 경로/방법 정보">방법</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="overviewSalary 필드 — 급여/임금 정보">임금</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="overviewProspect 필드 — 직업 전망 정보">전망</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="trivia 필드 — 여담/재미있는 사실">여담</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="detailWlb 필드 — 워라밸 상세 정보">WLB</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="detailReady 필드 — 준비 방법 상세">준비</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="sidebarJobs 필드 — 관련 직업 목록">직업</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="sidebarMajors 필드 — 관련 전공 목록">전공</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="sidebarCerts 필드 — 관련 자격증 목록">자격</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="heroTags 필드 — 직업 태그 배열">태그</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="youtubeLinks 필드 — YouTube 관련 영상 링크 존재 여부">YT</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" title="_sources 필드 — 출처 정보 존재 여부">출처</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[60px]" title="user_contributed_json 총 바이트 수">JSON</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[40px]" title="_sources 내 총 출처 항목 수 (Object인 경우 모든 섹션 합산, Array인 경우 배열 길이)">출처수</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[40px]" title="출처 중 URL(http로 시작)이 포함된 항목 수">URL</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[40px]" title="youtubeLinks 배열 내 YouTube 링크 수">YT수</th>
            </tr>
          </thead>
          <tbody id="tableBody" class="divide-y divide-slate-700/30">
          </tbody>
        </table>
      </div>
      <!-- 페이지네이션 -->
      <div class="flex items-center justify-between px-4 py-3 border-t border-slate-700/50">
        <span class="text-xs text-slate-500">페이지 <span id="pageInfo">1/1</span></span>
        <div class="flex gap-2">
          <button id="prevBtn" class="px-3 py-1.5 bg-slate-700/50 rounded text-xs text-slate-400 hover:bg-slate-600/50 disabled:opacity-30 disabled:cursor-not-allowed" disabled>
            <i class="fas fa-chevron-left mr-1"></i>이전
          </button>
          <button id="nextBtn" class="px-3 py-1.5 bg-slate-700/50 rounded text-xs text-slate-400 hover:bg-slate-600/50 disabled:opacity-30 disabled:cursor-not-allowed" disabled>
            다음<i class="fas fa-chevron-right ml-1"></i>
          </button>
        </div>
      </div>
    </div>

    <script>
    (function() {
      var ITEMS = ${itemsJson};
      var PAGE_SIZE = 50;
      var currentPage = 1;
      var filtered = ITEMS;

      var searchInput = document.getElementById('searchInput');
      var filterSelect = document.getElementById('filterSelect');
      var sortSelect = document.getElementById('sortSelect');
      var tableBody = document.getElementById('tableBody');
      var resultCount = document.getElementById('resultCount');
      var pageInfo = document.getElementById('pageInfo');
      var prevBtn = document.getElementById('prevBtn');
      var nextBtn = document.getElementById('nextBtn');

      function applyFilters() {
        var query = searchInput.value.trim().toLowerCase();
        var filter = filterSelect.value;
        var sort = sortSelect.value;

        filtered = ITEMS.filter(function(item) {
          if (query && item.name.toLowerCase().indexOf(query) === -1) return false;
          if (filter === 'perfect' && item.fieldCount !== 12) return false;
          if (filter === 'good' && (item.fieldCount < 6 || item.fieldCount >= 12)) return false;
          if (filter === 'poor' && item.fieldCount >= 6) return false;
          return true;
        });

        var parts = sort.split('-');
        var key = parts[0], dir = parts[1];
        filtered.sort(function(a, b) {
          var va, vb;
          if (key === 'name') { va = a.name; vb = b.name; }
          else if (key === 'field') { va = a.fieldCount; vb = b.fieldCount; }
          else if (key === 'size') { va = a.jsonSize; vb = b.jsonSize; }
          if (typeof va === 'string') {
            var cmp = va.localeCompare(vb, 'ko');
            return dir === 'asc' ? cmp : -cmp;
          }
          return dir === 'asc' ? va - vb : vb - va;
        });

        currentPage = 1;
        render();
      }

      function formatSize(bytes) {
        if (bytes > 1024) return (bytes / 1024).toFixed(1) + 'K';
        return bytes + 'B';
      }

      function render() {
        var totalPages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
        if (currentPage > totalPages) currentPage = totalPages;
        var start = (currentPage - 1) * PAGE_SIZE;
        var page = filtered.slice(start, start + PAGE_SIZE);

        resultCount.textContent = filtered.length;
        pageInfo.textContent = currentPage + '/' + totalPages;
        prevBtn.disabled = currentPage <= 1;
        nextBtn.disabled = currentPage >= totalPages;

        var html = '';
        for (var i = 0; i < page.length; i++) {
          var item = page[i];
          var pct = Math.round((item.fieldCount / 12) * 100);
          var barColor = pct === 100 ? 'bg-green-500' : pct >= 50 ? 'bg-emerald-500' : 'bg-red-500';
          var countColor = item.fieldCount === 12 ? 'text-green-400' : item.fieldCount >= 6 ? 'text-emerald-400' : 'text-red-400';

          html += '<tr class="hover:bg-slate-700/20 transition-colors">';
          html += '<td class="px-4 py-2 sticky left-0 bg-slate-900/80 z-10">';
          html += '<a href="https://careerwiki.org/job/' + encodeURIComponent(item.slug) + '" target="_blank" class="text-blue-400 hover:text-blue-300 font-medium text-xs">' + item.name + '</a>';
          html += '</td>';
          html += '<td class="px-3 py-2 text-center">';
          html += '<div class="flex items-center gap-1.5 justify-center">';
          html += '<div class="w-12 bg-slate-700/50 rounded-full h-1.5"><div class="h-1.5 rounded-full ' + barColor + '" style="width:' + pct + '%"></div></div>';
          html += '<span class="text-[11px] font-mono ' + countColor + '">' + item.fieldCount + '</span>';
          html += '</div></td>';

          for (var f = 0; f < 12; f++) {
            var has = item.fields[f];
            html += '<td class="px-2 py-2 text-center">';
            if (has) {
              html += '<i class="fas fa-check text-emerald-400 text-[10px]"></i>';
            } else {
              html += '<i class="fas fa-times text-slate-600 text-[10px]"></i>';
            }
            html += '</td>';
          }

          html += '<td class="px-3 py-2 text-center text-[11px] text-slate-400 font-mono">' + formatSize(item.jsonSize) + '</td>';
          html += '<td class="px-3 py-2 text-center text-[11px] text-slate-400">' + item.sourceCount + '</td>';
          html += '<td class="px-3 py-2 text-center text-[11px]">';
          if (item.urlSourceCount > 0) {
            html += '<span class="text-blue-400">' + item.urlSourceCount + '</span>';
          } else if (item.sourceCount > 0) {
            html += '<span class="text-amber-500" title="출처는 있으나 URL 없음">0</span>';
          } else {
            html += '<span class="text-slate-600">-</span>';
          }
          html += '</td>';
          html += '<td class="px-3 py-2 text-center text-[11px] text-slate-400">' + item.youtubeCount + '</td>';
          html += '</tr>';
        }
        tableBody.innerHTML = html;
      }

      searchInput.addEventListener('input', applyFilters);
      filterSelect.addEventListener('change', applyFilters);
      sortSelect.addEventListener('change', applyFilters);
      prevBtn.addEventListener('click', function() { if (currentPage > 1) { currentPage--; render(); } });
      nextBtn.addEventListener('click', function() { currentPage++; render(); });

      applyFilters();
    })();
    </script>
  `

  return renderAdminLayout({
    title: '데이터 보완 현황',
    currentPath: '/admin/job-equalize',
    children: content,
  })
}
