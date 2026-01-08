/**
 * 관리자 - 통계/애널리틱스 대시보드
 */
import { renderAdminLayout } from './adminLayout'

export interface AnalyticsProps {
  filters: {
    startDate: string
    endDate: string
    topLimit: number
  }
  overall: {
    visits: number
    activeUsers: number
    newUsers: number
    mau: number
    loginConversion: number
    bounceRate: number | null
    byType: { type: string; views: number }[]
  }
  jobs: {
    topPages: { slug: string; name: string; type: string; views: number }[]
  }
  majors: {
    topPages: { slug: string; name: string; type: string; views: number }[]
  }
  howtos: {
    topPages: { slug: string; name: string; type: string; views: number }[]
  }
  channels: Array<{ channel: string; visits: number; conversions: number; cvr: number }>
}

const metricCard = (label: string, value: string, tone: 'blue' | 'green' | 'amber' | 'red' | 'slate' = 'slate') => {
  const toneMap: Record<string, string> = {
    blue: 'text-blue-300 bg-blue-500/10',
    green: 'text-emerald-300 bg-emerald-500/10',
    amber: 'text-amber-300 bg-amber-500/10',
    red: 'text-rose-300 bg-rose-500/10',
    slate: 'text-slate-200 bg-slate-500/10'
  }
  return `
    <div class="glass-card rounded-xl p-4 border border-wiki-border/60">
      <div class="text-sm text-slate-400 mb-1">${label}</div>
      <div class="text-2xl font-bold ${toneMap[tone]} px-2 py-1 rounded-lg inline-block">${value}</div>
    </div>
  `
}

const renderTopTable = (title: string, items: { slug: string; name: string; type: string; views: number }[]) => `
  <div class="glass-card rounded-xl overflow-hidden">
    <div class="p-4 border-b border-wiki-border/70 flex items-center gap-2">
      <i class="fas fa-list-ol text-amber-400"></i>
      <h3 class="text-lg font-semibold">${title}</h3>
    </div>
    <div class="max-h-80 overflow-y-auto">
      <table class="w-full">
        <thead class="bg-wiki-card sticky top-0">
          <tr>
            <th class="px-4 py-3 text-left text-slate-400 font-medium w-12">#</th>
            <th class="px-4 py-3 text-left text-slate-400 font-medium">페이지</th>
            <th class="px-4 py-3 text-right text-slate-400 font-medium">조회</th>
          </tr>
        </thead>
        <tbody>
          ${items.length ? items.map((p, idx) => `
            <tr class="border-t border-wiki-border/60 hover:bg-wiki-card/60">
              <td class="px-4 py-2 text-white">${idx + 1}</td>
              <td class="px-4 py-2 text-slate-200">
                <div class="flex items-center gap-2">
                  <span class="px-2 py-0.5 text-[11px] rounded bg-slate-700/70 text-slate-200 uppercase">${p.type}</span>
                  <span>${p.name || p.slug}</span>
                </div>
                <div class="text-xs text-slate-500">${p.slug}</div>
              </td>
              <td class="px-4 py-2 text-right text-slate-200">${(p.views || 0).toLocaleString()}</td>
            </tr>
          `).join('') : `
            <tr>
              <td colspan="3" class="px-4 py-8 text-center text-slate-400">데이터가 없습니다.</td>
            </tr>
          `}
        </tbody>
      </table>
    </div>
  </div>
`

export function renderAdminStats(props: AnalyticsProps): string {
  const { filters, overall, jobs, majors, howtos, channels } = props

  const defaultEndDate = new Date().toISOString().split('T')[0]
  const defaultStartDate = new Date(Date.now() - 30 * 86400000).toISOString().split('T')[0]

  const channelRows = channels.length
    ? channels.map((c) => `
      <tr class="border-t border-wiki-border/70 hover:bg-wiki-card/60">
        <td class="px-4 py-2 text-slate-200">${c.channel}</td>
        <td class="px-4 py-2 text-right text-slate-200">${c.visits.toLocaleString()}</td>
        <td class="px-4 py-2 text-right text-slate-200">${c.conversions.toLocaleString()}</td>
        <td class="px-4 py-2 text-right text-slate-200">${c.cvr.toFixed(1)}%</td>
      </tr>
    `).join('')
    : `
      <tr>
        <td colspan="4" class="px-4 py-6 text-center text-slate-400">채널별 전환 데이터가 없습니다.</td>
      </tr>
    `

  const content = `
    <div class="glass-card rounded-xl p-3 sm:p-4 mb-4">
      <form id="analytics-filter" class="space-y-3 sm:space-y-0 sm:flex sm:flex-wrap sm:items-center sm:gap-4">
        <!-- 기간 필터 -->
        <div class="flex items-center gap-2">
          <input type="date" name="startDate" value="${filters.startDate || defaultStartDate}" 
            class="flex-1 sm:flex-none px-3 py-2 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white text-sm" 
            style="font-size: 16px;">
          <span class="text-slate-400 shrink-0">~</span>
          <input type="date" name="endDate" value="${filters.endDate || defaultEndDate}" 
            class="flex-1 sm:flex-none px-3 py-2 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white text-sm" 
            style="font-size: 16px;">
        </div>
        
        <!-- TOP & 적용 버튼 -->
        <div class="flex gap-2">
          <select name="topLimit" class="px-3 py-2 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white text-sm" style="font-size: 16px;">
            <option value="5" ${filters.topLimit === 5 ? 'selected' : ''}>TOP 5</option>
            <option value="10" ${filters.topLimit === 10 ? 'selected' : ''}>TOP 10</option>
            <option value="20" ${filters.topLimit === 20 ? 'selected' : ''}>TOP 20</option>
          </select>
          
          <button type="submit" class="px-4 py-2 min-h-[44px] bg-blue-600 hover:bg-blue-500 rounded-lg text-white transition-colors text-sm whitespace-nowrap">
            <i class="fas fa-sync-alt mr-1.5"></i>적용
          </button>
        </div>
      </form>
    </div>

    <div class="glass-card rounded-xl p-2 mb-4 overflow-x-auto">
      <div class="flex gap-2 min-w-max sm:min-w-0" data-analytics-tabs>
        <button type="button" data-tab="dashboard" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-primary text-white text-sm font-semibold whitespace-nowrap">대시보드</button>
        <button type="button" data-tab="job" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-card text-slate-200 text-sm whitespace-nowrap">직업</button>
        <button type="button" data-tab="major" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-card text-slate-200 text-sm whitespace-nowrap">전공</button>
        <button type="button" data-tab="howto" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-card text-slate-200 text-sm whitespace-nowrap">HowTo</button>
      </div>
    </div>

    <!-- Dashboard -->
    <section data-tab-panel="dashboard" class="space-y-4">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
        ${metricCard('방문(조회)', (overall.visits || 0).toLocaleString(), 'blue')}
        ${metricCard('활성 사용자(로그인)', (overall.activeUsers || 0).toLocaleString(), 'green')}
        ${metricCard('신규 가입자', (overall.newUsers || 0).toLocaleString(), 'amber')}
        ${metricCard('MAU(로그인)', (overall.mau || 0).toLocaleString(), 'blue')}
        ${metricCard('로그인 전환율', `${overall.loginConversion.toFixed(1)}%`, 'green')}
        ${metricCard('이탈율', overall.bounceRate === null ? '데이터 없음' : `${overall.bounceRate.toFixed(1)}%`, 'red')}
      </div>

      <div class="glass-card rounded-xl p-4 space-y-3">
        <h3 class="text-lg font-semibold text-slate-100 flex items-center gap-2"><i class="fas fa-layer-group text-blue-400"></i> 페이지 유형별 조회</h3>
        <div class="space-y-2">
          ${overall.byType.length ? overall.byType.map((t) => `
            <div class="flex items-center justify-between text-sm text-slate-200 bg-wiki-card rounded-lg px-3 py-2 border border-wiki-border/60">
              <span class="uppercase">${t.type}</span>
              <span>${(t.views || 0).toLocaleString()}</span>
            </div>
          `).join('') : '<div class="text-sm text-slate-400">데이터가 없습니다.</div>'}
        </div>
        <div class="h-64">
          <canvas id="byTypeChart" aria-label="페이지 유형별 조회 비율"></canvas>
        </div>
      </div>

      <div class="glass-card rounded-xl overflow-hidden mt-4">
        <div class="p-4 border-b border-wiki-border/70 flex items-center gap-2">
          <i class="fas fa-route text-cyan-400"></i>
          <h3 class="text-lg font-semibold text-slate-100">유입 채널별 전환</h3>
        </div>
        <div>
          <table class="w-full">
            <thead class="bg-wiki-card">
              <tr>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">채널</th>
                <th class="px-4 py-3 text-right text-slate-400 font-medium">방문</th>
                <th class="px-4 py-3 text-right text-slate-400 font-medium">전환</th>
                <th class="px-4 py-3 text-right text-slate-400 font-medium">CVR</th>
              </tr>
            </thead>
            <tbody>
              ${channelRows}
            </tbody>
          </table>
        </div>
      </div>
    </section>

    <!-- Jobs -->
    <section data-tab-panel="job" class="space-y-4 hidden">
      ${renderTopTable('인기 직업 TOP', jobs.topPages || [])}
    </section>

    <!-- Majors -->
    <section data-tab-panel="major" class="space-y-4 hidden">
      ${renderTopTable('인기 전공 TOP', majors.topPages || [])}
    </section>

    <!-- HowTo -->
    <section data-tab-panel="howto" class="space-y-4 hidden">
      ${renderTopTable('인기 HowTo', howtos.topPages || [])}
    </section>

    <!-- Channels moved under dashboard -->
    <div class="glass-card rounded-xl overflow-hidden mt-6 sm:mt-8">
      <div class="p-4 border-b border-wiki-border/70 flex items-center gap-2">
        <i class="fas fa-route text-cyan-400"></i>
        <h3 class="text-lg font-semibold text-slate-100">유입 채널별 전환</h3>
      </div>
      <div>
        <table class="w-full">
          <thead class="bg-wiki-card">
            <tr>
              <th class="px-4 py-3 text-left text-slate-400 font-medium">채널</th>
              <th class="px-4 py-3 text-right text-slate-400 font-medium">방문</th>
              <th class="px-4 py-3 text-right text-slate-400 font-medium">전환</th>
              <th class="px-4 py-3 text-right text-slate-400 font-medium">CVR</th>
            </tr>
          </thead>
          <tbody>
            ${channelRows}
          </tbody>
        </table>
      </div>
    </div>
  `

  return renderAdminLayout({
    title: '통계 · 대시보드',
    currentPath: '/admin/stats',
    children: `
      ${content}
      <script>
        (() => {
          const tabs = Array.from(document.querySelectorAll('[data-analytics-tabs] [data-tab]'));
          const panels = Array.from(document.querySelectorAll('[data-tab-panel]'));
          const activate = (key) => {
            tabs.forEach(btn => {
              const active = btn.dataset.tab === key;
              btn.classList.toggle('bg-wiki-primary', active);
              btn.classList.toggle('text-white', active);
              btn.classList.toggle('bg-wiki-card', !active);
              btn.classList.toggle('text-slate-200', !active);
            });
            panels.forEach(p => {
              p.classList.toggle('hidden', p.dataset.tabPanel !== key);
            });
            localStorage.setItem('admin-analytics-tab', key);
          };
          tabs.forEach(btn => btn.addEventListener('click', () => activate(btn.dataset.tab)));
          const saved = localStorage.getItem('admin-analytics-tab');
          if (saved) activate(saved);
          else activate('dashboard');

          // 파이 차트: 페이지 유형별 조회
          const byTypeCtx = document.getElementById('byTypeChart');
          if (byTypeCtx) {
            const labels = ${JSON.stringify((props.overall.byType || []).map((t) => t.type || '기타'))};
            const data = ${JSON.stringify((props.overall.byType || []).map((t) => t.views || 0))};
            const colors = ['#60a5fa','#34d399','#fcd34d','#f87171','#a78bfa','#38bdf8','#f97316'];
            new Chart(byTypeCtx, {
              type: 'doughnut',
              data: {
                labels,
                datasets: [{
                  data,
                  backgroundColor: labels.map((_, i) => colors[i % colors.length]),
                  borderWidth: 1,
                }]
              },
              options: {
                plugins: { legend: { labels: { color: '#e2e8f0' } } }
              }
            });
          }
        })();
      </script>
    `
  })
}
/**
 * 관리자 - 통계 대시보드 페이지
 */

import { renderAdminLayout } from './adminLayout'

export interface DailyStats {
  date: string
  count: number
  value?: number
}

export interface SearchPattern {
  keyword: string
  count: number
}

export interface TopPage {
  slug: string
  name: string
  type: string
  views: number
}

export interface AdminStatsProps {
  serpInteractions: DailyStats[]
  searchPatterns: SearchPattern[]
  cacheStats: DailyStats[]
  topPages: TopPage[]
  filters: {
    startDate: string
    endDate: string
    topLimit: number
  }
}

export function renderAdminStatsLegacy(props: AdminStatsProps): string {
  const { serpInteractions, searchPatterns, cacheStats, topPages, filters } = props
  
  // 기본 날짜 설정 (최근 30일)
  const defaultEndDate = new Date().toISOString().split('T')[0]
  const defaultStartDate = new Date(Date.now() - 30 * 86400000).toISOString().split('T')[0]
  
  // 차트 데이터 준비
  const serpLabels = serpInteractions.map(s => s.date.slice(5))
  const serpData = serpInteractions.map(s => s.count)
  const cacheLabels = cacheStats.map(s => s.date.slice(5))
  const cacheData = cacheStats.map(s => s.value || 0)
  
  const content = `
    <style>
      /* 달력 아이콘을 밝게 표시 */
      #filterForm input[type="date"]::-webkit-calendar-picker-indicator {
        filter: invert(1);
      }
    </style>
    <!-- 필터 바 -->
    <div class="glass-card rounded-xl p-4 mb-6">
      <form id="filterForm" class="flex flex-wrap items-center gap-4">
        <!-- 날짜 범위 -->
        <div class="flex items-center gap-2">
          <span class="text-slate-400">기간:</span>
          <input 
            type="date" 
            name="startDate"
            value="${filters.startDate || defaultStartDate}"
            class="px-3 py-2 bg-slate-800 border border-wiki-border rounded-lg text-white placeholder:text-slate-400"
          >
          <span class="text-slate-400">~</span>
          <input 
            type="date" 
            name="endDate"
            value="${filters.endDate || defaultEndDate}"
            class="px-3 py-2 bg-slate-800 border border-wiki-border rounded-lg text-white placeholder:text-slate-400"
          >
        </div>
        
        <!-- TOP 개수 -->
        <div class="flex items-center gap-2">
          <span class="text-slate-400">TOP:</span>
          <select name="topLimit" class="px-4 py-2 bg-slate-700/50 border border-slate-600 rounded-lg text-white">
            <option value="5" ${filters.topLimit === 5 ? 'selected' : ''}>5개</option>
            <option value="10" ${filters.topLimit === 10 ? 'selected' : ''}>10개</option>
            <option value="20" ${filters.topLimit === 20 ? 'selected' : ''}>20개</option>
          </select>
        </div>
        
        <button type="submit" class="px-4 py-2 bg-blue-600 hover:bg-blue-500 rounded-lg text-white transition-colors">
          <i class="fas fa-sync mr-2"></i>새로고침
        </button>
      </form>
    </div>
    
    <!-- 차트 영역 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
      <!-- SERP 인터랙션 차트 -->
      <div class="glass-card rounded-xl p-4">
        <h3 class="text-lg font-semibold mb-4 flex items-center gap-2">
          <i class="fas fa-chart-line text-blue-400"></i>
          SERP 인터랙션 (일별)
        </h3>
        <div class="h-64">
          <canvas id="serpChart"></canvas>
        </div>
      </div>
      
      <!-- 캐시 히트율 차트 -->
      <div class="glass-card rounded-xl p-4">
        <h3 class="text-lg font-semibold mb-4 flex items-center gap-2">
          <i class="fas fa-bolt text-cyan-400"></i>
          캐시 히트율 (일별)
        </h3>
        <div class="h-64">
          <canvas id="cacheChart"></canvas>
        </div>
      </div>
    </div>
    
    <!-- 테이블 영역 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
      <!-- SERP 인터랙션 표 -->
      <div class="glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700/50">
          <h3 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-table text-blue-400"></i>
            SERP 인터랙션 상세
          </h3>
        </div>
        <div class="max-h-80 overflow-y-auto">
          <table class="w-full">
            <thead class="bg-slate-800/50 sticky top-0">
              <tr>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">날짜</th>
                <th class="px-4 py-3 text-right text-slate-400 font-medium">횟수</th>
              </tr>
            </thead>
            <tbody>
              ${serpInteractions.length > 0 ? serpInteractions.map(s => `
                <tr class="border-t border-slate-700/50 hover:bg-slate-700/20">
                  <td class="px-4 py-2 text-white">${s.date}</td>
                  <td class="px-4 py-2 text-right text-slate-300">${s.count.toLocaleString()}</td>
                </tr>
              `).join('') : `
                <tr>
                  <td colspan="2" class="px-4 py-8 text-center text-slate-400">데이터가 없습니다.</td>
                </tr>
              `}
            </tbody>
          </table>
        </div>
      </div>
      
      <!-- 캐시 히트율 표 -->
      <div class="glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700/50">
          <h3 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-table text-cyan-400"></i>
            캐시 히트율 상세
          </h3>
        </div>
        <div class="max-h-80 overflow-y-auto">
          <table class="w-full">
            <thead class="bg-slate-800/50 sticky top-0">
              <tr>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">날짜</th>
                <th class="px-4 py-3 text-right text-slate-400 font-medium">총 요청</th>
                <th class="px-4 py-3 text-right text-slate-400 font-medium">히트율</th>
              </tr>
            </thead>
            <tbody>
              ${cacheStats.length > 0 ? cacheStats.map(s => `
                <tr class="border-t border-slate-700/50 hover:bg-slate-700/20">
                  <td class="px-4 py-2 text-white">${s.date}</td>
                  <td class="px-4 py-2 text-right text-slate-300">${s.count.toLocaleString()}</td>
                  <td class="px-4 py-2 text-right">
                    <span class="${(s.value || 0) >= 80 ? 'text-green-400' : (s.value || 0) >= 50 ? 'text-yellow-400' : 'text-red-400'}">
                      ${(s.value || 0).toFixed(1)}%
                    </span>
                  </td>
                </tr>
              `).join('') : `
                <tr>
                  <td colspan="3" class="px-4 py-8 text-center text-slate-400">데이터가 없습니다.</td>
                </tr>
              `}
            </tbody>
          </table>
        </div>
      </div>
    </div>
    
    <!-- 하단 테이블 영역 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- 검색 패턴 (카테고리) -->
      <div class="glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700/50">
          <h3 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-search text-purple-400"></i>
            인기 카테고리 TOP ${filters.topLimit}
          </h3>
        </div>
        <div class="max-h-80 overflow-y-auto">
          <table class="w-full">
            <thead class="bg-slate-800/50 sticky top-0">
              <tr>
                <th class="px-4 py-3 text-left text-slate-400 font-medium w-12">#</th>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">카테고리</th>
                <th class="px-4 py-3 text-right text-slate-400 font-medium">횟수</th>
              </tr>
            </thead>
            <tbody>
              ${searchPatterns.length > 0 ? searchPatterns.map((s, i) => `
                <tr class="border-t border-slate-700/50 hover:bg-slate-700/20">
                  <td class="px-4 py-2 text-slate-500">${i + 1}</td>
                  <td class="px-4 py-2 text-white">${escapeHtml(s.keyword || '(없음)')}</td>
                  <td class="px-4 py-2 text-right text-slate-300">${s.count.toLocaleString()}</td>
                </tr>
              `).join('') : `
                <tr>
                  <td colspan="3" class="px-4 py-8 text-center text-slate-400">데이터가 없습니다.</td>
                </tr>
              `}
            </tbody>
          </table>
        </div>
      </div>
      
      <!-- TOP 페이지 -->
      <div class="glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700/50">
          <h3 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-fire text-orange-400"></i>
            인기 페이지 TOP ${filters.topLimit}
          </h3>
        </div>
        <div class="max-h-80 overflow-y-auto">
          <table class="w-full">
            <thead class="bg-slate-800/50 sticky top-0">
              <tr>
                <th class="px-4 py-3 text-left text-slate-400 font-medium w-12">#</th>
                <th class="px-4 py-3 text-left text-slate-400 font-medium">페이지</th>
                <th class="px-4 py-3 text-center text-slate-400 font-medium w-20">타입</th>
                <th class="px-4 py-3 text-right text-slate-400 font-medium">조회</th>
              </tr>
            </thead>
            <tbody>
              ${topPages.length > 0 ? topPages.map((p, i) => `
                <tr class="border-t border-slate-700/50 hover:bg-slate-700/20">
                  <td class="px-4 py-2 text-slate-500">${i + 1}</td>
                  <td class="px-4 py-2">
                    <a href="/${p.type}/${p.slug}" class="text-blue-400 hover:text-blue-300" target="_blank">
                      ${escapeHtml(p.name || p.slug)}
                    </a>
                  </td>
                  <td class="px-4 py-2 text-center">
                    <span class="px-2 py-1 rounded text-xs ${
                      p.type === 'job' ? 'bg-blue-500/20 text-blue-400' :
                      p.type === 'major' ? 'bg-purple-500/20 text-purple-400' :
                      'bg-green-500/20 text-green-400'
                    }">${p.type}</span>
                  </td>
                  <td class="px-4 py-2 text-right text-slate-300">${p.views.toLocaleString()}</td>
                </tr>
              `).join('') : `
                <tr>
                  <td colspan="4" class="px-4 py-8 text-center text-slate-400">데이터가 없습니다.</td>
                </tr>
              `}
            </tbody>
          </table>
        </div>
      </div>
    </div>
    
    <script>
      // Chart.js 차트 생성
      document.addEventListener('DOMContentLoaded', function() {
        // SERP 인터랙션 차트
        const serpCtx = document.getElementById('serpChart').getContext('2d');
        new Chart(serpCtx, {
          type: 'line',
          data: {
            labels: ${JSON.stringify(serpLabels)},
            datasets: [{
              label: 'SERP 인터랙션',
              data: ${JSON.stringify(serpData)},
              borderColor: 'rgb(59, 130, 246)',
              backgroundColor: 'rgba(59, 130, 246, 0.1)',
              fill: true,
              tension: 0.3
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: { display: false }
            },
            scales: {
              x: {
                grid: { color: 'rgba(148, 163, 184, 0.1)' },
                ticks: { color: 'rgb(148, 163, 184)' }
              },
              y: {
                grid: { color: 'rgba(148, 163, 184, 0.1)' },
                ticks: { color: 'rgb(148, 163, 184)' },
                beginAtZero: true
              }
            }
          }
        });
        
        // 캐시 히트율 차트
        const cacheCtx = document.getElementById('cacheChart').getContext('2d');
        new Chart(cacheCtx, {
          type: 'bar',
          data: {
            labels: ${JSON.stringify(cacheLabels)},
            datasets: [{
              label: '캐시 히트율 (%)',
              data: ${JSON.stringify(cacheData)},
              backgroundColor: 'rgba(34, 211, 238, 0.6)',
              borderColor: 'rgb(34, 211, 238)',
              borderWidth: 1
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: { display: false }
            },
            scales: {
              x: {
                grid: { color: 'rgba(148, 163, 184, 0.1)' },
                ticks: { color: 'rgb(148, 163, 184)' }
              },
              y: {
                grid: { color: 'rgba(148, 163, 184, 0.1)' },
                ticks: { color: 'rgb(148, 163, 184)' },
                beginAtZero: true,
                max: 100
              }
            }
          }
        });
      });
    </script>
  `
  
  return renderAdminLayout({
    title: '통계',
    currentPath: '/admin/stats',
    children: content
  })
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, m => map[m])
}




