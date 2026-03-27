/**
 * 관리자 직업 데이터 보완 현황 페이지
 * - 전체 직업 수 vs 보완 완료 수 (진행률)
 * - 최근 보완 목록
 * - 일별 보완 추이 차트
 * - 필드별 완성도 통계
 */

import { renderAdminLayout } from './adminLayout'

export interface JobEqualizeEntry {
  id: string
  name: string
  slug: string
  productionUrl: string
  completedAt: string
  revision: number
  fieldsUpdated: string[]
  careerTree: string[]
}

export interface AdminJobEqualizeProps {
  totalJobs: number
  logEntries: JobEqualizeEntry[]
  completedCount?: number
}

const FIELD_LABELS: Record<string, string> = {
  way: '진입방법',
  'overviewSalary.sal': '임금정보',
  'overviewProspect.main': '전망',
  trivia: '특이사항',
  'detailWlb.wlbDetail': '워라밸',
  'detailWlb.socialDetail': '사회적 인식',
  detailReady: '준비방법',
  sidebarCerts: '자격증',
  sidebarMajors: '관련 전공',
  sidebarJobs: '관련 직업',
  heroTags: '태그',
  youtubeLinks: 'YouTube 링크',
}

function formatDate(iso: string): string {
  const d = new Date(iso)
  const mm = String(d.getMonth() + 1).padStart(2, '0')
  const dd = String(d.getDate()).padStart(2, '0')
  const hh = String(d.getHours()).padStart(2, '0')
  const min = String(d.getMinutes()).padStart(2, '0')
  return `${mm}/${dd} ${hh}:${min}`
}

export function renderAdminJobEqualize(props: AdminJobEqualizeProps): string {
  const { totalJobs, logEntries, completedCount: completedCountProp } = props

  const completedCount = completedCountProp ?? logEntries.length
  const progressPct = totalJobs > 0 ? ((completedCount / totalJobs) * 100).toFixed(1) : '0.0'
  const remainingCount = totalJobs - completedCount

  // 최근 보완 10건 (날짜 내림차순)
  const recent = [...logEntries]
    .sort((a, b) => new Date(b.completedAt).getTime() - new Date(a.completedAt).getTime())
    .slice(0, 15)

  // 일별 보완 통계 (최근 30일)
  const byDate: Record<string, number> = {}
  logEntries.forEach(e => {
    const date = e.completedAt.slice(0, 10)
    byDate[date] = (byDate[date] || 0) + 1
  })
  const dateEntries = Object.entries(byDate).sort(([a], [b]) => a.localeCompare(b))
  const chartLabels = JSON.stringify(dateEntries.map(([d]) => {
    const [, mm, dd] = d.split('-')
    return `${parseInt(mm)}/${parseInt(dd)}`
  }))
  const chartData = JSON.stringify(dateEntries.map(([, v]) => v))

  // 필드별 등장 횟수
  const fieldCount: Record<string, number> = {}
  logEntries.forEach(e => {
    e.fieldsUpdated.forEach(f => {
      fieldCount[f] = (fieldCount[f] || 0) + 1
    })
  })
  const topFields = Object.entries(fieldCount)
    .sort(([, a], [, b]) => b - a)
    .slice(0, 12)

  // 커리어트리 있는 직업 수
  const withCareerTree = logEntries.filter(e => e.careerTree && e.careerTree.length > 0).length

  const content = `
    <!-- KPI 카드 -->
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 sm:gap-4 mb-6">
      <div class="glass-card rounded-xl p-4">
        <div class="flex items-center gap-3 mb-2">
          <div class="w-9 h-9 bg-blue-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-briefcase text-blue-400 text-sm"></i>
          </div>
          <span class="text-xs text-slate-400">전체 직업</span>
        </div>
        <div class="text-2xl font-bold text-white">${totalJobs.toLocaleString()}</div>
        <div class="text-xs text-slate-500 mt-1">활성 직업 총계</div>
      </div>

      <div class="glass-card rounded-xl p-4">
        <div class="flex items-center gap-3 mb-2">
          <div class="w-9 h-9 bg-emerald-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-check-circle text-emerald-400 text-sm"></i>
          </div>
          <span class="text-xs text-slate-400">보완 완료</span>
        </div>
        <div class="text-2xl font-bold text-emerald-400">${completedCount}</div>
        <div class="text-xs text-slate-500 mt-1">${progressPct}% 진행</div>
      </div>

      <div class="glass-card rounded-xl p-4">
        <div class="flex items-center gap-3 mb-2">
          <div class="w-9 h-9 bg-amber-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-clock text-amber-400 text-sm"></i>
          </div>
          <span class="text-xs text-slate-400">잔여</span>
        </div>
        <div class="text-2xl font-bold text-amber-400">${remainingCount.toLocaleString()}</div>
        <div class="text-xs text-slate-500 mt-1">미완료 직업</div>
      </div>

      <div class="glass-card rounded-xl p-4">
        <div class="flex items-center gap-3 mb-2">
          <div class="w-9 h-9 bg-purple-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-sitemap text-purple-400 text-sm"></i>
          </div>
          <span class="text-xs text-slate-400">커리어트리</span>
        </div>
        <div class="text-2xl font-bold text-purple-400">${withCareerTree}</div>
        <div class="text-xs text-slate-500 mt-1">인물 등록 직업</div>
      </div>
    </div>

    <!-- 진행률 바 -->
    <div class="glass-card rounded-xl p-5 mb-6">
      <div class="flex items-center justify-between mb-3">
        <h3 class="text-sm font-semibold text-white">전체 진행률</h3>
        <span class="text-sm font-bold text-emerald-400">${completedCount} / ${totalJobs.toLocaleString()} (${progressPct}%)</span>
      </div>
      <div class="w-full bg-slate-700/60 rounded-full h-3 overflow-hidden">
        <div class="h-3 rounded-full bg-gradient-to-r from-emerald-500 to-emerald-400 transition-all"
             style="width: ${progressPct}%"></div>
      </div>
      <div class="flex justify-between text-xs text-slate-500 mt-2">
        <span>0</span>
        <span>${Math.round(totalJobs * 0.25).toLocaleString()}</span>
        <span>${Math.round(totalJobs * 0.5).toLocaleString()}</span>
        <span>${Math.round(totalJobs * 0.75).toLocaleString()}</span>
        <span>${totalJobs.toLocaleString()}</span>
      </div>
    </div>

    <!-- 차트 + 필드 통계 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-4 mb-6">
      <!-- 일별 보완 추이 차트 -->
      <div class="glass-card rounded-xl p-5">
        <h3 class="text-sm font-semibold text-white mb-4">
          <i class="fas fa-chart-bar text-blue-400 mr-2"></i>일별 보완 현황
        </h3>
        <div class="relative h-48">
          <canvas id="dailyChart"></canvas>
        </div>
      </div>

      <!-- 필드별 완성도 -->
      <div class="glass-card rounded-xl p-5">
        <h3 class="text-sm font-semibold text-white mb-4">
          <i class="fas fa-list-check text-purple-400 mr-2"></i>보완된 필드 현황
        </h3>
        <div class="space-y-2 overflow-y-auto admin-mini-scroll" style="max-height: 192px">
          ${topFields.map(([field, count]) => {
            const label = FIELD_LABELS[field] || field
            const pct = completedCount > 0 ? Math.round((count / completedCount) * 100) : 0
            return `
            <div>
              <div class="flex justify-between text-xs mb-1">
                <span class="text-slate-300">${label}</span>
                <span class="text-slate-400">${count}건 (${pct}%)</span>
              </div>
              <div class="w-full bg-slate-700/50 rounded-full h-1.5">
                <div class="h-1.5 rounded-full bg-purple-500/70" style="width: ${pct}%"></div>
              </div>
            </div>`
          }).join('')}
        </div>
      </div>
    </div>

    <!-- 최근 보완 직업 목록 -->
    <div class="glass-card rounded-xl p-5">
      <h3 class="text-sm font-semibold text-white mb-4">
        <i class="fas fa-history text-emerald-400 mr-2"></i>최근 보완 직업 (최신 15건)
      </h3>
      <div class="overflow-x-auto admin-mini-scroll">
        <table class="w-full text-sm">
          <thead>
            <tr class="text-left border-b border-slate-700/50">
              <th class="pb-3 text-xs text-slate-400 font-medium pr-4">직업명</th>
              <th class="pb-3 text-xs text-slate-400 font-medium pr-4 hidden sm:table-cell">완료 일시</th>
              <th class="pb-3 text-xs text-slate-400 font-medium pr-4 hidden md:table-cell">보완 필드</th>
              <th class="pb-3 text-xs text-slate-400 font-medium pr-4 hidden lg:table-cell">커리어트리</th>
              <th class="pb-3 text-xs text-slate-400 font-medium">revision</th>
              <th class="pb-3 text-xs text-slate-400 font-medium text-right">링크</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-700/30">
            ${recent.map(entry => `
            <tr class="hover:bg-slate-700/20 transition-colors">
              <td class="py-2.5 pr-4">
                <span class="text-white font-medium">${entry.name}</span>
              </td>
              <td class="py-2.5 pr-4 hidden sm:table-cell">
                <span class="text-slate-400 text-xs">${formatDate(entry.completedAt)}</span>
              </td>
              <td class="py-2.5 pr-4 hidden md:table-cell">
                <span class="inline-flex items-center px-2 py-0.5 rounded text-xs bg-emerald-500/15 text-emerald-400">
                  ${entry.fieldsUpdated.length}개 필드
                </span>
              </td>
              <td class="py-2.5 pr-4 hidden lg:table-cell">
                ${entry.careerTree && entry.careerTree.length > 0
                  ? `<span class="text-xs text-purple-400">${entry.careerTree.slice(0, 2).join(', ')}${entry.careerTree.length > 2 ? ` 외 ${entry.careerTree.length - 2}명` : ''}</span>`
                  : `<span class="text-xs text-slate-600">-</span>`
                }
              </td>
              <td class="py-2.5 pr-4">
                <span class="text-xs text-slate-500">r${entry.revision}</span>
              </td>
              <td class="py-2.5 text-right">
                <a href="${entry.productionUrl}" target="_blank" rel="noopener"
                   class="inline-flex items-center gap-1 px-2 py-1 rounded text-xs bg-blue-500/15 text-blue-400 hover:bg-blue-500/25 transition-colors">
                  <i class="fas fa-external-link-alt text-[10px]"></i>
                  <span class="hidden sm:inline">보기</span>
                </a>
              </td>
            </tr>
            `).join('')}
          </tbody>
        </table>
      </div>
    </div>

    <script>
    (function() {
      const labels = ${chartLabels};
      const data = ${chartData};

      const ctx = document.getElementById('dailyChart');
      if (!ctx) return;

      new Chart(ctx, {
        type: 'bar',
        data: {
          labels,
          datasets: [{
            label: '보완 완료 직업 수',
            data,
            backgroundColor: 'rgba(52, 211, 153, 0.4)',
            borderColor: 'rgba(52, 211, 153, 0.8)',
            borderWidth: 1,
            borderRadius: 4,
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              callbacks: {
                label: ctx => ctx.parsed.y + '개 직업 보완'
              }
            }
          },
          scales: {
            x: {
              ticks: { color: '#94a3b8', font: { size: 11 } },
              grid: { color: 'rgba(148,163,184,0.1)' }
            },
            y: {
              beginAtZero: true,
              ticks: { color: '#94a3b8', font: { size: 11 }, stepSize: 5 },
              grid: { color: 'rgba(148,163,184,0.1)' }
            }
          }
        }
      });
    })();
    </script>
  `

  return renderAdminLayout({
    title: '데이터 보완 현황',
    currentPath: '/admin/job-equalize',
    children: content,
  })
}
