/**
 * 관리자 - 통계/애널리틱스 대시보드
 */
import { renderAdminLayout } from './adminLayout'
import type { AiConversionStats, SearchStats } from '../../services/adminService'

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
  aiConversion?: AiConversionStats
  searchStats?: SearchStats
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

const renderTopTable = (title: string, items: { slug: string; name: string; type: string; views: number }[]) => {
  const maxViews = Math.max(...items.map(i => i.views || 0), 1)
  return `
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
            <th class="px-4 py-3 text-slate-400 font-medium w-32 hidden sm:table-cell"></th>
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
              <td class="px-4 py-2 hidden sm:table-cell">
                <div class="bg-slate-700/50 rounded-full h-1.5">
                  <div class="bg-blue-500 h-1.5 rounded-full" style="width: ${maxViews > 0 ? Math.round(((p.views || 0) / maxViews) * 100) : 0}%"></div>
                </div>
              </td>
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
`}

export function renderAdminStats(props: AnalyticsProps): string {
  const { filters, overall, jobs, majors, howtos, channels, aiConversion, searchStats } = props

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

  // 검색 패널 HTML
  const maxQueryCount = Math.max(...(searchStats?.topQueries || []).map(q => q.count), 1)
  const maxFailCount = Math.max(...(searchStats?.failedQueries || []).map(q => q.count), 1)

  const searchPanel = `
    <section data-tab-panel="search" class="space-y-4 hidden">
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
        ${metricCard('총 검색', (searchStats?.totalSearches || 0).toLocaleString(), 'blue')}
        ${metricCard('실패 검색 (0결과)', (searchStats?.failedSearches || 0).toLocaleString(), 'red')}
        ${metricCard('실패율', searchStats && searchStats.totalSearches > 0 ? ((searchStats.failedSearches / searchStats.totalSearches) * 100).toFixed(1) + '%' : '0%', 'amber')}
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-4">
        <!-- 인기 검색어 TOP 20 -->
        <div class="glass-card rounded-xl overflow-hidden">
          <div class="p-4 border-b border-wiki-border/70 flex items-center gap-2">
            <i class="fas fa-fire text-amber-400"></i>
            <h3 class="text-lg font-semibold text-slate-100">인기 검색어 TOP 20</h3>
          </div>
          <div class="max-h-96 overflow-y-auto">
            <table class="w-full">
              <thead class="bg-wiki-card sticky top-0">
                <tr>
                  <th class="px-4 py-3 text-left text-slate-400 font-medium w-10">#</th>
                  <th class="px-4 py-3 text-left text-slate-400 font-medium">검색어</th>
                  <th class="px-4 py-3 text-right text-slate-400 font-medium w-20">횟수</th>
                  <th class="px-4 py-3 text-slate-400 font-medium w-28 hidden sm:table-cell"></th>
                </tr>
              </thead>
              <tbody>
                ${(searchStats?.topQueries || []).length ? (searchStats?.topQueries || []).map((q, i) => `
                  <tr class="border-t border-wiki-border/60 hover:bg-wiki-card/60">
                    <td class="px-4 py-2 text-slate-500">${i + 1}</td>
                    <td class="px-4 py-2 text-slate-200">${q.query}</td>
                    <td class="px-4 py-2 text-right text-slate-200">${q.count.toLocaleString()}</td>
                    <td class="px-4 py-2 hidden sm:table-cell">
                      <div class="bg-slate-700/50 rounded-full h-1.5">
                        <div class="bg-blue-500 h-1.5 rounded-full" style="width: ${maxQueryCount > 0 ? Math.round((q.count / maxQueryCount) * 100) : 0}%"></div>
                      </div>
                    </td>
                  </tr>
                `).join('') : '<tr><td colspan="4" class="px-4 py-8 text-center text-slate-400">검색 데이터가 없습니다. 검색이 발생하면 여기에 표시됩니다.</td></tr>'}
              </tbody>
            </table>
          </div>
        </div>

        <!-- 실패 키워드 (결과 0건) -->
        <div class="glass-card rounded-xl overflow-hidden">
          <div class="p-4 border-b border-wiki-border/70 flex items-center gap-2">
            <i class="fas fa-exclamation-triangle text-rose-400"></i>
            <h3 class="text-lg font-semibold text-slate-100">실패 키워드 (결과 0건)</h3>
          </div>
          <div class="max-h-96 overflow-y-auto">
            <table class="w-full">
              <thead class="bg-wiki-card sticky top-0">
                <tr>
                  <th class="px-4 py-3 text-left text-slate-400 font-medium w-10">#</th>
                  <th class="px-4 py-3 text-left text-slate-400 font-medium">검색어</th>
                  <th class="px-4 py-3 text-right text-slate-400 font-medium w-20">횟수</th>
                  <th class="px-4 py-3 text-slate-400 font-medium w-28 hidden sm:table-cell"></th>
                </tr>
              </thead>
              <tbody>
                ${(searchStats?.failedQueries || []).length ? (searchStats?.failedQueries || []).map((q, i) => `
                  <tr class="border-t border-wiki-border/60 hover:bg-wiki-card/60">
                    <td class="px-4 py-2 text-slate-500">${i + 1}</td>
                    <td class="px-4 py-2 text-rose-300">${q.query}</td>
                    <td class="px-4 py-2 text-right text-slate-200">${q.count.toLocaleString()}</td>
                    <td class="px-4 py-2 hidden sm:table-cell">
                      <div class="bg-slate-700/50 rounded-full h-1.5">
                        <div class="bg-rose-500 h-1.5 rounded-full" style="width: ${maxFailCount > 0 ? Math.round((q.count / maxFailCount) * 100) : 0}%"></div>
                      </div>
                    </td>
                  </tr>
                `).join('') : '<tr><td colspan="4" class="px-4 py-8 text-center text-slate-400">실패 검색어가 없습니다.</td></tr>'}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </section>
  `

  // AI 퍼널 패널 HTML
  const aiTrend = aiConversion?.dailyTrend || []
  const aiPanel = `
    <section data-tab-panel="ai-funnel" class="space-y-4 hidden">
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
        ${metricCard('총 분석 요청', (aiConversion?.totalRequests || 0).toLocaleString(), 'blue')}
        ${metricCard('완료', (aiConversion?.completedRequests || 0).toLocaleString(), 'green')}
        ${metricCard('전환율', (aiConversion?.conversionRate || 0).toFixed(1) + '%', (aiConversion?.conversionRate || 0) >= 50 ? 'green' : 'amber')}
      </div>

      <div class="glass-card rounded-xl p-4">
        <h3 class="text-lg font-semibold text-slate-100 flex items-center gap-2 mb-3">
          <i class="fas fa-chart-line text-violet-400"></i> 일별 전환율 추이
        </h3>
        <div class="h-64">
          <canvas id="aiConversionChart"></canvas>
        </div>
      </div>
    </section>
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

    <div class="glass-card rounded-xl p-2 mb-4">
      <!-- 모바일: select 드롭다운 -->
      <select class="sm:hidden w-full px-3 py-2 min-h-[44px] bg-slate-700/50 border border-slate-600 rounded-lg text-white text-sm" style="font-size: 16px;" data-analytics-mobile-select>
        <option value="dashboard">대시보드</option>
        <option value="job">직업</option>
        <option value="major">전공</option>
        <option value="howto">HowTo</option>
        <option value="ai-funnel">AI 퍼널</option>
        <option value="search">검색</option>
      </select>
      <!-- 데스크톱: 탭 버튼 -->
      <div class="hidden sm:flex gap-2" data-analytics-tabs>
        <button type="button" data-tab="dashboard" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-primary text-white text-sm font-semibold whitespace-nowrap">대시보드</button>
        <button type="button" data-tab="job" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-card text-slate-200 text-sm whitespace-nowrap">직업</button>
        <button type="button" data-tab="major" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-card text-slate-200 text-sm whitespace-nowrap">전공</button>
        <button type="button" data-tab="howto" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-card text-slate-200 text-sm whitespace-nowrap">HowTo</button>
        <button type="button" data-tab="ai-funnel" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-card text-slate-200 text-sm whitespace-nowrap">AI 퍼널</button>
        <button type="button" data-tab="search" class="px-3 sm:px-4 py-2 min-h-[40px] rounded-lg bg-wiki-card text-slate-200 text-sm whitespace-nowrap">검색</button>
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

    <!-- AI 퍼널 -->
    ${aiPanel}

    <!-- 검색 -->
    ${searchPanel}
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
              btn.classList.toggle('font-semibold', active);
              btn.classList.toggle('bg-wiki-card', !active);
              btn.classList.toggle('text-slate-200', !active);
            });
            panels.forEach(p => {
              p.classList.toggle('hidden', p.dataset.tabPanel !== key);
            });
            // 모바일 select 동기화
            const sel = document.querySelector('[data-analytics-mobile-select]');
            if (sel) sel.value = key;
            localStorage.setItem('admin-analytics-tab', key);
          };
          tabs.forEach(btn => btn.addEventListener('click', () => activate(btn.dataset.tab)));
          // 모바일 select 동기화
          const mobileSelect = document.querySelector('[data-analytics-mobile-select]');
          if (mobileSelect) {
            mobileSelect.addEventListener('change', (e) => activate(e.target.value));
          }
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

          // AI 전환율 차트
          const aiCtx = document.getElementById('aiConversionChart');
          if (aiCtx) {
            const aiData = ${JSON.stringify(aiTrend.slice().reverse())};
            new Chart(aiCtx, {
              type: 'line',
              data: {
                labels: aiData.map(d => d.date.slice(5)),
                datasets: [
                  {
                    label: '완료 수',
                    data: aiData.map(d => d.completed),
                    borderColor: '#34d399',
                    backgroundColor: 'rgba(52,211,153,0.1)',
                    fill: true,
                    tension: 0.3,
                    yAxisID: 'y'
                  },
                  {
                    label: '전환율(%)',
                    data: aiData.map(d => d.rate),
                    borderColor: '#a78bfa',
                    backgroundColor: 'transparent',
                    tension: 0.3,
                    yAxisID: 'y1'
                  }
                ]
              },
              options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                  y: { beginAtZero: true, ticks: { color: '#94a3b8' }, grid: { color: 'rgba(148,163,184,0.1)' } },
                  y1: { position: 'right', beginAtZero: true, max: 100, ticks: { color: '#94a3b8' }, grid: { drawOnChartArea: false } }
                },
                plugins: { legend: { labels: { color: '#e2e8f0' } } }
              }
            });
          }
        })();
      </script>
    `
  })
}
