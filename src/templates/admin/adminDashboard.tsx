/**
 * 관리자 대시보드 메인 페이지
 */

import { renderAdminLayout } from './adminLayout'
import type { DailyViewStatsResult } from '../../services/adminService'

export interface DashboardStats {
  totalJobs: number
  totalMajors: number
  totalUsers: number
  todayEdits: number
  cacheHitRate: number
}

export interface RecentEdit {
  id: number
  entityType: string
  entityId: string
  entityName: string
  editorName: string
  editorType: string
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
  dailyViews?: DailyViewStatsResult
}

export function renderAdminDashboard(props: AdminDashboardProps): string {
  const { stats, recentEdits, recentUsers, dailyViews } = props
  
  const content = `
    <!-- 통계 카드 -->
    <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-2 sm:gap-4 mb-6 sm:mb-8">
      <div class="stat-card glass-card rounded-xl p-3 sm:p-5">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-blue-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-briefcase text-blue-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.totalJobs.toLocaleString()}</p>
            <p class="text-slate-400 text-xs sm:text-sm">총 직업</p>
          </div>
        </div>
      </div>
      
      <div class="stat-card glass-card rounded-xl p-3 sm:p-5">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-purple-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-graduation-cap text-purple-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.totalMajors.toLocaleString()}</p>
            <p class="text-slate-400 text-xs sm:text-sm">총 전공</p>
          </div>
        </div>
      </div>
      
      <div class="stat-card glass-card rounded-xl p-3 sm:p-5">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-green-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-users text-green-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.totalUsers.toLocaleString()}</p>
            <p class="text-slate-400 text-xs sm:text-sm">사용자</p>
          </div>
        </div>
      </div>
      
      <div class="stat-card glass-card rounded-xl p-3 sm:p-5">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-amber-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-edit text-amber-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.todayEdits}</p>
            <p class="text-slate-400 text-xs sm:text-sm">오늘 편집</p>
          </div>
        </div>
      </div>
      
      <div class="stat-card glass-card rounded-xl p-3 sm:p-5 col-span-2 sm:col-span-1">
        <div class="flex items-center gap-2 sm:gap-3">
          <div class="w-9 h-9 sm:w-12 sm:h-12 bg-cyan-500/20 rounded-lg flex items-center justify-center shrink-0">
            <i class="fas fa-bolt text-cyan-400 text-base sm:text-xl"></i>
          </div>
          <div class="min-w-0">
            <p class="text-lg sm:text-2xl font-bold text-white truncate">${stats.cacheHitRate.toFixed(1)}%</p>
            <p class="text-slate-400 text-xs sm:text-sm">캐시 히트율</p>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 방문자 추이 (일별 조회수) -->
    ${dailyViews && dailyViews.daily.length > 0 ? `
    <div class="glass-card rounded-xl p-4 sm:p-5 mb-6 sm:mb-8">
      <div class="flex items-center justify-between mb-4">
        <h3 class="text-lg font-semibold flex items-center gap-2">
          <i class="fas fa-chart-area text-blue-400"></i>
          일별 조회수 추이 (최근 30일)
        </h3>
        <div class="flex items-center gap-3 text-sm">
          <span class="text-slate-400">일평균: <span class="text-white font-medium">${dailyViews.summary.avgDaily.toLocaleString()}</span></span>
          ${dailyViews.summary.maxDay ? `
            <span class="text-slate-400">최고: <span class="text-emerald-300 font-medium">${dailyViews.summary.maxDay.views.toLocaleString()}</span> (${dailyViews.summary.maxDay.date.slice(5)})</span>
          ` : ''}
        </div>
      </div>
      <div class="h-48 sm:h-64">
        <canvas id="dailyViewChart" aria-label="일별 조회수 추이"></canvas>
      </div>
      <div class="flex items-center gap-4 mt-3 text-xs text-slate-400">
        <span><span class="inline-block w-3 h-1.5 rounded bg-blue-500 mr-1"></span>직업</span>
        <span><span class="inline-block w-3 h-1.5 rounded bg-purple-500 mr-1"></span>전공</span>
        <span><span class="inline-block w-3 h-1.5 rounded bg-emerald-500 mr-1"></span>HowTo</span>
      </div>
    </div>` : ''}

    <!-- 최근 활동 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- 최근 편집 -->
      <div class="glass-card rounded-xl overflow-hidden">
        <div class="p-4 border-b border-slate-700/50 flex items-center justify-between">
          <h3 class="text-lg font-semibold flex items-center gap-2">
            <i class="fas fa-history text-amber-400"></i>
            최근 편집
          </h3>
          <a href="/admin/content" class="text-sm text-blue-400 hover:text-blue-300">전체 보기 →</a>
        </div>
        <div class="divide-y divide-slate-700/30">
          ${recentEdits.length > 0 ? recentEdits.map(edit => `
            <div class="p-4 hover:bg-slate-700/20 transition-colors">
              <div class="flex items-start justify-between">
                <div>
                  <div class="flex items-center gap-2 mb-1">
                    <span class="px-2 py-0.5 rounded text-xs ${
                      edit.entityType === 'job' ? 'bg-blue-500/20 text-blue-400' :
                      edit.entityType === 'major' ? 'bg-purple-500/20 text-purple-400' :
                      'bg-green-500/20 text-green-400'
                    }">${edit.entityType}</span>
                    <span class="text-white font-medium">${escapeHtml(edit.entityName)}</span>
                  </div>
                  <div class="text-sm text-slate-400">
                    <span class="${
                      edit.editorType === 'admin' ? 'text-amber-400' :
                      edit.editorType === 'anonymous' ? 'text-slate-500' :
                      'text-slate-300'
                    }">${escapeHtml(edit.editorName)}</span>
                  </div>
                </div>
                <span class="text-xs text-slate-500">${formatRelativeTime(edit.createdAt)}</span>
              </div>
            </div>
          `).join('') : `
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
          <a href="/admin/users" class="text-sm text-blue-400 hover:text-blue-300">전체 보기 →</a>
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
    ${dailyViews && dailyViews.daily.length > 0 ? `
    <script>
      (() => {
        const ctx = document.getElementById('dailyViewChart');
        if (!ctx) return;
        const data = ${JSON.stringify(dailyViews.daily)};
        new Chart(ctx, {
          type: 'line',
          data: {
            labels: data.map(d => d.date.slice(5)),
            datasets: [
              {
                label: '직업',
                data: data.map(d => d.job),
                borderColor: '#60a5fa',
                backgroundColor: 'rgba(96,165,250,0.1)',
                fill: true,
                tension: 0.3,
                borderWidth: 2,
                pointRadius: 2,
              },
              {
                label: '전공',
                data: data.map(d => d.major),
                borderColor: '#a78bfa',
                backgroundColor: 'rgba(167,139,250,0.1)',
                fill: true,
                tension: 0.3,
                borderWidth: 2,
                pointRadius: 2,
              },
              {
                label: 'HowTo',
                data: data.map(d => d.howto),
                borderColor: '#34d399',
                backgroundColor: 'rgba(52,211,153,0.1)',
                fill: true,
                tension: 0.3,
                borderWidth: 2,
                pointRadius: 2,
              }
            ]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: { mode: 'index', intersect: false },
            plugins: {
              legend: { display: false },
              tooltip: {
                callbacks: {
                  footer: (items) => '합계: ' + items.reduce((s, i) => s + (i.parsed.y || 0), 0).toLocaleString()
                }
              }
            },
            scales: {
              x: { ticks: { color: '#94a3b8', maxTicksLimit: 10 }, grid: { color: 'rgba(148,163,184,0.08)' } },
              y: { beginAtZero: true, ticks: { color: '#94a3b8' }, grid: { color: 'rgba(148,163,184,0.08)' } }
            }
          }
        });
      })();
    </script>` : ''}
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
    // 10자리면 초 단위, 13자리면 밀리초 단위
    date = dateInput < 10000000000 
      ? new Date(dateInput * 1000)  // 초 → 밀리초
      : new Date(dateInput)
  } else {
    // 문자열인 경우 숫자로 변환 시도
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



