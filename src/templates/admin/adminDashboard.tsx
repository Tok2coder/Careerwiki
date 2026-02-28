/**
 * 관리자 대시보드 메인 페이지 v2
 * - KPI: 사용자 / 총 직업 / 총 전공 / 누적 방문 / 누적 분석
 * - 차트: 기간 필터(24h/7d/30d) + dual Y-axis(조회수+분석수) + 데이터 테이블
 * - 최근 편집: 변경 필드 표시
 */

import { renderAdminLayout } from './adminLayout'
import type { DashboardChartData } from '../../services/adminService'

export interface DashboardStats {
  totalUsers: number
  totalJobs: number
  totalMajors: number
  cumulativeViews: number
  cumulativeAnalyses: number
}

export interface RecentEdit {
  id: number
  entityType: string
  entityId: string
  entityName: string
  editorName: string
  editorType: string
  changeType: string | null
  changedFields: string | null
  createdAt: string
}

export interface RecentUser {
  id: number
  name: string | null
  email: string
  role: string
  createdAt: string
}

export interface AdminDashboardProps {
  stats: DashboardStats
  recentEdits: RecentEdit[]
  recentUsers: RecentUser[]
  chartData?: DashboardChartData
}

const FIELD_LABELS: Record<string, string> = {
  summary: '요약', duties: '직무내용', requirements: '자격요건',
  salary: '연봉', outlook: '전망', education: '학력',
  content: '본문', title: '제목', curriculum: '교육과정',
  career_path: '진로', certifications: '자격증', work_environment: '근무환경',
  related_jobs: '관련 직업', related_majors: '관련 전공',
}

function formatChangedFields(changedFields: string | null): string {
  if (!changedFields) return ''
  try {
    const fields = JSON.parse(changedFields) as string[]
    if (!Array.isArray(fields) || fields.length === 0) return ''
    const labels = fields.map(f => FIELD_LABELS[f] || f).slice(0, 3)
    const suffix = fields.length > 3 ? ` 외 ${fields.length - 3}개` : ''
    return labels.join(', ') + suffix + ' 수정'
  } catch { return '' }
}

function getChangeTypeBadge(changeType: string | null): string {
  if (changeType === 'initial') return '<span class="px-1.5 py-0.5 rounded text-[10px] bg-emerald-500/20 text-emerald-400">신규</span>'
  if (changeType === 'restore') return '<span class="px-1.5 py-0.5 rounded text-[10px] bg-amber-500/20 text-amber-400">복원</span>'
  return ''
}

export function renderAdminDashboard(props: AdminDashboardProps): string {
  const { stats, recentEdits, recentUsers, chartData } = props

  const content = `
    <!-- KPI 카드 (클릭 시 해당 탭 이동) -->
    <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-2 sm:gap-4 mb-6 sm:mb-8">
      <a href="/admin/users" class="stat-card glass-card rounded-xl p-3 sm:p-5 block">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-green-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-users text-green-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.totalUsers.toLocaleString()}</p>
            <p class="text-slate-400 text-xs sm:text-sm">사용자</p>
          </div>
        </div>
      </a>

      <a href="/admin/content" class="stat-card glass-card rounded-xl p-3 sm:p-5 block">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-blue-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-briefcase text-blue-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.totalJobs.toLocaleString()}</p>
            <p class="text-slate-400 text-xs sm:text-sm">총 직업</p>
          </div>
        </div>
      </a>

      <a href="/admin/content" class="stat-card glass-card rounded-xl p-3 sm:p-5 block">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-purple-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-graduation-cap text-purple-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.totalMajors.toLocaleString()}</p>
            <p class="text-slate-400 text-xs sm:text-sm">총 전공</p>
          </div>
        </div>
      </a>

      <a href="/admin/stats" class="stat-card glass-card rounded-xl p-3 sm:p-5 block">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-amber-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-eye text-amber-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.cumulativeViews.toLocaleString()}</p>
            <p class="text-slate-400 text-xs sm:text-sm">누적 방문</p>
          </div>
        </div>
      </a>

      <a href="/admin/ai-analyzer" class="stat-card glass-card rounded-xl p-3 sm:p-5 block col-span-2 sm:col-span-1">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-cyan-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-brain text-cyan-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.cumulativeAnalyses.toLocaleString()}</p>
            <p class="text-slate-400 text-xs sm:text-sm">누적 분석</p>
          </div>
        </div>
      </a>
    </div>

    <!-- 조회수/분석 추이 차트 -->
    <div class="glass-card rounded-xl p-4 sm:p-5 mb-6 sm:mb-8">
      <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mb-4">
        <h3 class="text-lg font-semibold flex items-center gap-2">
          <i class="fas fa-chart-area text-blue-400"></i>
          조회수 & 분석 추이
        </h3>
        <div class="flex items-center gap-2">
          <div class="flex bg-slate-700/50 rounded-lg p-0.5" id="chartPeriodBtns">
            <button data-days="1" class="px-3 py-1 text-xs rounded-md transition-colors text-slate-400 hover:text-white">24시간</button>
            <button data-days="7" class="px-3 py-1 text-xs rounded-md transition-colors bg-blue-500/20 text-blue-400">7일</button>
            <button data-days="30" class="px-3 py-1 text-xs rounded-md transition-colors text-slate-400 hover:text-white">30일</button>
          </div>
        </div>
      </div>

      <!-- 요약 스탯 -->
      <div class="flex items-center gap-4 sm:gap-6 mb-3 text-sm" id="chartSummary">
        <span class="text-slate-400">기간 조회: <span class="text-white font-medium" id="summaryViews">${chartData?.summary.totalViews.toLocaleString() || '0'}</span></span>
        <span class="text-slate-400">일평균: <span class="text-white font-medium" id="summaryAvg">${chartData?.summary.avgDaily.toLocaleString() || '0'}</span></span>
        <span class="text-slate-400">분석: <span class="text-orange-300 font-medium" id="summaryAnalyses">${chartData?.summary.totalAnalyses.toLocaleString() || '0'}</span></span>
        ${chartData?.summary.maxDay ? `<span class="text-slate-400 hidden sm:inline">최고: <span class="text-emerald-300 font-medium" id="summaryMax">${chartData.summary.maxDay.views.toLocaleString()}</span> <span id="summaryMaxDate">(${chartData.summary.maxDay.date.slice(5)})</span></span>` : '<span class="hidden sm:inline" id="summaryMaxWrap"></span>'}
      </div>

      <!-- 차트 캔버스 -->
      <div class="h-48 sm:h-64">
        <canvas id="dashboardChart" aria-label="조회수 및 분석 추이"></canvas>
      </div>

      <!-- 데이터 테이블 -->
      <div class="mt-4 overflow-x-auto">
        <table class="w-full text-xs sm:text-sm" id="chartDataTable">
          <thead>
            <tr class="text-slate-400 border-b-2 border-slate-600">
              <th class="text-left py-2 px-2 font-medium">날짜</th>
              <th class="text-right py-2 px-2 font-medium">직업</th>
              <th class="text-right py-2 px-2 font-medium">전공</th>
              <th class="text-right py-2 px-2 font-medium">HowTo</th>
              <th class="text-right py-2 px-2 font-medium">합계</th>
              <th class="text-right py-2 px-2 font-medium text-orange-400">분석</th>
            </tr>
          </thead>
          <tbody id="chartTableBody">
            ${(chartData?.daily || []).slice().reverse().map((d, idx) => `
              <tr class="border-b border-slate-700/20 hover:bg-slate-700/20 ${idx % 2 === 1 ? 'bg-slate-800/20' : ''}">
                <td class="py-1.5 px-2 text-slate-300">${d.date.slice(5)}</td>
                <td class="py-1.5 px-2 text-right text-blue-300">${d.job}</td>
                <td class="py-1.5 px-2 text-right text-purple-300">${d.major}</td>
                <td class="py-1.5 px-2 text-right text-emerald-300">${d.howto}</td>
                <td class="py-1.5 px-2 text-right text-white font-medium">${d.total}</td>
                <td class="py-1.5 px-2 text-right text-orange-300">${d.analyses}</td>
              </tr>
            `).join('')}
          </tbody>
          <tfoot>
            <tr class="border-t-2 border-slate-600 font-medium bg-slate-700/20">
              <td class="py-2 px-2 text-slate-300">합계</td>
              <td class="py-2 px-2 text-right text-blue-300">${(chartData?.daily || []).reduce((s, d) => s + d.job, 0)}</td>
              <td class="py-2 px-2 text-right text-purple-300">${(chartData?.daily || []).reduce((s, d) => s + d.major, 0)}</td>
              <td class="py-2 px-2 text-right text-emerald-300">${(chartData?.daily || []).reduce((s, d) => s + d.howto, 0)}</td>
              <td class="py-2 px-2 text-right text-white">${chartData?.summary.totalViews || 0}</td>
              <td class="py-2 px-2 text-right text-orange-300">${chartData?.summary.totalAnalyses || 0}</td>
            </tr>
          </tfoot>
        </table>
      </div>
    </div>

    <!-- 최근 활동 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- 최근 편집 -->
      <div class="glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700/50 flex items-center justify-between">
          <h3 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-history text-amber-400"></i>
            최근 편집
          </h3>
          <a href="/admin/content" class="text-sm text-blue-400 hover:text-blue-300">전체 보기 &rarr;</a>
        </div>
        <div class="divide-y divide-slate-700/30">
          ${recentEdits.length > 0 ? recentEdits.map(edit => {
            const changeInfo = formatChangedFields(edit.changedFields)
            const typeBadge = getChangeTypeBadge(edit.changeType)
            return `
            <div class="p-4 hover:bg-slate-700/20 transition-colors">
              <div class="flex items-start justify-between">
                <div class="min-w-0 flex-1">
                  <div class="flex items-center gap-2 mb-1 flex-wrap">
                    <span class="px-2 py-0.5 rounded text-xs ${
                      edit.entityType === 'job' ? 'bg-blue-500/20 text-blue-400' :
                      edit.entityType === 'major' ? 'bg-purple-500/20 text-purple-400' :
                      'bg-green-500/20 text-green-400'
                    }">${edit.entityType}</span>
                    ${typeBadge}
                    <span class="text-white font-medium truncate">${escapeHtml(edit.entityName)}</span>
                  </div>
                  <div class="text-sm text-slate-400 flex items-center gap-2">
                    <span class="${
                      edit.editorType === 'admin' ? 'text-amber-400' :
                      edit.editorType === 'anonymous' ? 'text-slate-500' :
                      'text-slate-300'
                    }">${escapeHtml(edit.editorName)}</span>
                    ${changeInfo ? `<span class="text-slate-500 text-xs">${escapeHtml(changeInfo)}</span>` : ''}
                  </div>
                </div>
                <span class="text-xs text-slate-500 shrink-0 ml-2">${formatRelativeTime(edit.createdAt)}</span>
              </div>
            </div>
          `}).join('') : `
            <div class="p-8 text-center text-slate-400">
              <i class="fas fa-inbox text-3xl mb-2"></i>
              <p>최근 편집이 없습니다.</p>
            </div>
          `}
        </div>
      </div>

      <!-- 최근 가입 사용자 -->
      <div class="glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700/50 flex items-center justify-between">
          <h3 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-user-plus text-green-400"></i>
            최근 가입
          </h3>
          <a href="/admin/users" class="text-sm text-blue-400 hover:text-blue-300">전체 보기 &rarr;</a>
        </div>
        <div class="divide-y divide-slate-700/30">
          ${recentUsers.length > 0 ? recentUsers.map(user => `
            <div class="p-4 hover:bg-slate-700/20 transition-colors">
              <div class="flex items-center justify-between">
                <div class="flex items-center gap-3">
                  <div class="w-10 h-10 bg-slate-600 rounded-full flex items-center justify-center">
                    <i class="fas fa-user text-slate-400"></i>
                  </div>
                  <div>
                    <div class="flex items-center gap-2">
                      <span class="text-white font-medium">${escapeHtml(user.name || '이름 없음')}</span>
                      <span class="px-2 py-0.5 rounded text-xs ${
                        user.role === 'admin' ? 'bg-amber-500/20 text-amber-400' :
                        user.role === 'expert' ? 'bg-purple-500/20 text-purple-400' :
                        'bg-slate-500/20 text-slate-400'
                      }">${user.role}</span>
                    </div>
                    <p class="text-sm text-slate-400">${escapeHtml(user.email)}</p>
                  </div>
                </div>
                <span class="text-xs text-slate-500">${formatRelativeTime(user.createdAt)}</span>
              </div>
            </div>
          `).join('') : `
            <div class="p-8 text-center text-slate-400">
              <i class="fas fa-users text-3xl mb-2"></i>
              <p>최근 가입 사용자가 없습니다.</p>
            </div>
          `}
        </div>
      </div>
    </div>
  `

  return renderAdminLayout({
    title: '운영 현황',
    currentPath: '/admin',
    children: `
    ${content}
    <script>
      (() => {
        // ─── 차트 초기화 ───
        const ctx = document.getElementById('dashboardChart');
        if (!ctx) return;
        let chartData = ${JSON.stringify(chartData?.daily || [])};
        let dashChart = null;

        function buildChart(data) {
          if (dashChart) dashChart.destroy();
          dashChart = new Chart(ctx, {
            type: 'bar',
            data: {
              labels: data.map(d => d.date.slice(5)),
              datasets: [
                {
                  type: 'line', label: '직업', yAxisID: 'y',
                  data: data.map(d => d.job),
                  borderColor: '#60a5fa', backgroundColor: 'rgba(96,165,250,0.1)',
                  fill: true, tension: 0.3, borderWidth: 2, pointRadius: 2, order: 1,
                },
                {
                  type: 'line', label: '전공', yAxisID: 'y',
                  data: data.map(d => d.major),
                  borderColor: '#a78bfa', backgroundColor: 'rgba(167,139,250,0.1)',
                  fill: true, tension: 0.3, borderWidth: 2, pointRadius: 2, order: 2,
                },
                {
                  type: 'line', label: 'HowTo', yAxisID: 'y',
                  data: data.map(d => d.howto),
                  borderColor: '#34d399', backgroundColor: 'rgba(52,211,153,0.1)',
                  fill: true, tension: 0.3, borderWidth: 2, pointRadius: 2, order: 3,
                },
                {
                  type: 'bar', label: '분석', yAxisID: 'y1',
                  data: data.map(d => d.analyses),
                  backgroundColor: 'rgba(251,146,60,0.5)', borderColor: '#fb923c',
                  borderWidth: 1, borderRadius: 3, barPercentage: 0.4, order: 4,
                }
              ]
            },
            options: {
              responsive: true,
              maintainAspectRatio: false,
              interaction: { mode: 'index', intersect: false },
              plugins: {
                legend: {
                  display: true,
                  labels: { color: '#94a3b8', usePointStyle: true, padding: 16, font: { size: 12 } }
                },
                tooltip: {
                  callbacks: {
                    footer: (items) => {
                      const views = items.filter(i => i.datasetIndex < 3).reduce((s, i) => s + (i.parsed.y || 0), 0);
                      return '조회 합계: ' + views.toLocaleString();
                    }
                  }
                }
              },
              scales: {
                x: { ticks: { color: '#94a3b8', maxTicksLimit: 10 }, grid: { color: 'rgba(148,163,184,0.08)' } },
                y: {
                  type: 'linear', position: 'left', beginAtZero: true,
                  ticks: { color: '#94a3b8' }, grid: { color: 'rgba(148,163,184,0.08)' },
                  title: { display: false }
                },
                y1: {
                  type: 'linear', position: 'right', beginAtZero: true,
                  ticks: { color: '#fb923c', stepSize: 1 },
                  grid: { drawOnChartArea: false },
                  title: { display: false }
                }
              }
            }
          });
        }

        buildChart(chartData);

        // ─── 기간 필터 ───
        const btnWrap = document.getElementById('chartPeriodBtns');
        if (btnWrap) {
          btnWrap.addEventListener('click', async (e) => {
            const btn = e.target.closest('button[data-days]');
            if (!btn) return;
            const days = btn.dataset.days;

            // 버튼 활성화 상태
            btnWrap.querySelectorAll('button').forEach(b => {
              b.className = 'px-3 py-1 text-xs rounded-md transition-colors text-slate-400 hover:text-white';
            });
            btn.className = 'px-3 py-1 text-xs rounded-md transition-colors bg-blue-500/20 text-blue-400';

            try {
              const resp = await fetch('/api/admin/dashboard-chart?days=' + days);
              if (!resp.ok) return;
              const json = await resp.json();

              // 차트 업데이트
              chartData = json.daily || [];
              buildChart(chartData);

              // 요약 업데이트
              const s = json.summary || {};
              const elViews = document.getElementById('summaryViews');
              const elAvg = document.getElementById('summaryAvg');
              const elAn = document.getElementById('summaryAnalyses');
              if (elViews) elViews.textContent = (s.totalViews || 0).toLocaleString();
              if (elAvg) elAvg.textContent = (s.avgDaily || 0).toLocaleString();
              if (elAn) elAn.textContent = (s.totalAnalyses || 0).toLocaleString();

              // 테이블 업데이트
              const tbody = document.getElementById('chartTableBody');
              if (tbody) {
                const rows = (json.daily || []).slice().reverse();
                tbody.innerHTML = rows.map(d => '<tr class="border-b border-slate-700/20 hover:bg-slate-700/10">'
                  + '<td class="py-1.5 px-2 text-slate-300">' + d.date.slice(5) + '</td>'
                  + '<td class="py-1.5 px-2 text-right text-blue-300">' + d.job + '</td>'
                  + '<td class="py-1.5 px-2 text-right text-purple-300">' + d.major + '</td>'
                  + '<td class="py-1.5 px-2 text-right text-emerald-300">' + d.howto + '</td>'
                  + '<td class="py-1.5 px-2 text-right text-white font-medium">' + d.total + '</td>'
                  + '<td class="py-1.5 px-2 text-right text-orange-300">' + d.analyses + '</td>'
                  + '</tr>').join('');
              }
            } catch (err) {
              console.error('Chart fetch error:', err);
            }
          });
        }
      })();
    </script>
  `
  })
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, m => map[m])
}

function formatRelativeTime(dateInput: string | number): string {
  let date: Date

  // Unix timestamp (초 단위) 처리
  if (typeof dateInput === 'number') {
    date = dateInput < 10000000000
      ? new Date(dateInput * 1000)
      : new Date(dateInput)
  } else {
    const num = Number(dateInput)
    if (!isNaN(num) && num > 0) {
      date = num < 10000000000
        ? new Date(num * 1000)
        : new Date(num)
    } else {
      date = new Date(dateInput)
    }
  }

  const now = new Date()
  const diffMs = now.getTime() - date.getTime()
  const diffMins = Math.floor(diffMs / 60000)
  const diffHours = Math.floor(diffMs / 3600000)
  const diffDays = Math.floor(diffMs / 86400000)

  if (diffMins < 1) return '방금 전'
  if (diffMins < 60) return `${diffMins}분 전`
  if (diffHours < 24) return `${diffHours}시간 전`
  if (diffDays < 7) return `${diffDays}일 전`
  return date.toLocaleDateString('ko-KR')
}
