/**
 * 관리자 페이지 공통 레이아웃
 * 왼쪽 고정 사이드바 + 메인 콘텐츠 영역
 */

export interface AdminLayoutProps {
  title: string
  currentPath: string
  children: string
}

const navItems = [
  { path: '/admin/users', label: '사용자 관리', icon: 'fa-users' },
  { path: '/admin/content', label: '콘텐츠 관리', icon: 'fa-edit' },
  { path: '/admin/feedback', label: '피드백', icon: 'fa-comment-dots' },
  { path: '/admin/stats', label: '통계', icon: 'fa-chart-bar' },
  { path: '/admin/ai-analyzer', label: 'AI 추천', icon: 'fa-robot' },
]

export function renderAdminLayout({ title, currentPath, children }: AdminLayoutProps): string {
  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${title} | Careerwiki 관리자</title>
  <link rel="stylesheet" href="/static/tailwind.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body { 
      background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); 
      min-height: 100vh; 
    }
    .glass-card {
      background: rgba(30, 41, 59, 0.8);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(148, 163, 184, 0.1);
    }
    .sidebar-link {
      transition: all 0.2s ease;
    }
    .sidebar-link:hover {
      background: rgba(59, 130, 246, 0.1);
    }
    .sidebar-link.active {
      background: rgba(59, 130, 246, 0.2);
      border-right: 3px solid #3b82f6;
    }
    .stat-card {
      transition: transform 0.2s ease;
    }
    .stat-card:hover {
      transform: translateY(-2px);
    }
    /* 모바일 사이드바 */
    .sidebar-overlay {
      background: rgba(0, 0, 0, 0.5);
      backdrop-filter: blur(4px);
    }
    @media (max-width: 1023px) {
      .sidebar {
        transform: translateX(-100%);
        transition: transform 0.3s ease;
      }
      .sidebar.open {
        transform: translateX(0);
      }
    }
  </style>
</head>
<body class="text-slate-200">
  <!-- 모바일 오버레이 -->
  <div id="sidebarOverlay" class="sidebar-overlay fixed inset-0 z-40 hidden lg:hidden" onclick="toggleSidebar()"></div>
  
  <!-- 사이드바 -->
  <aside id="sidebar" class="sidebar fixed left-0 top-0 h-full w-64 glass-card z-50 flex flex-col lg:translate-x-0">
    <!-- 로고 -->
    <div class="p-6 border-b border-slate-700/50">
      <a href="/admin" class="flex items-center gap-3">
        <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-600 rounded-lg flex items-center justify-center">
          <i class="fas fa-briefcase text-white"></i>
        </div>
        <div>
          <h1 class="font-bold text-white">Careerwiki</h1>
          <span class="text-xs text-slate-400">관리자 패널</span>
        </div>
      </a>
    </div>
    
    <!-- 네비게이션 -->
    <nav class="flex-1 p-4 space-y-1">
      ${navItems.map(item => `
        <a href="${item.path}" 
           class="sidebar-link flex items-center gap-3 px-4 py-3 min-h-[48px] rounded-lg text-sm ${currentPath === item.path ? 'active text-white' : 'text-slate-400 hover:text-white'}">
          <i class="fas ${item.icon} w-5 text-center"></i>
          <span>${item.label}</span>
        </a>
      `).join('')}
    </nav>
    
    <!-- 하단 링크 -->
    <div class="p-4 border-t border-slate-700/50">
      <a href="/" class="flex items-center gap-3 px-4 py-3 min-h-[48px] rounded-lg text-sm text-slate-400 hover:text-white hover:bg-slate-700/50 transition-colors">
        <i class="fas fa-arrow-left w-5 text-center"></i>
        <span>사이트로 돌아가기</span>
      </a>
    </div>
  </aside>
  
  <!-- 메인 콘텐츠 -->
  <main class="lg:ml-64 min-h-screen">
    <!-- 상단 헤더 -->
    <header class="sticky top-0 z-30 glass-card border-b border-slate-700/50">
      <div class="flex items-center justify-between px-3 sm:px-6 py-3 sm:py-4 gap-2">
        <!-- 모바일 햄버거 -->
        <button id="menuBtn" class="lg:hidden p-2 min-w-[44px] min-h-[44px] flex items-center justify-center text-slate-400 hover:text-white shrink-0" onclick="toggleSidebar()">
          <i class="fas fa-bars text-xl"></i>
        </button>
        
        <h2 class="text-base sm:text-xl font-semibold text-white truncate">${title}</h2>
        
        <div class="flex items-center gap-2 sm:gap-4 shrink-0">
          <span class="text-xs sm:text-sm text-slate-400 whitespace-nowrap">
            <i class="fas fa-clock mr-1 sm:mr-2 hidden sm:inline"></i>
            <span id="currentTime"></span>
          </span>
        </div>
      </div>
    </header>
    
    <!-- 페이지 콘텐츠 -->
    <div class="p-6">
      ${children}
    </div>
  </main>
  
  <script>
    // 사이드바 토글
    function toggleSidebar() {
      const sidebar = document.getElementById('sidebar');
      const overlay = document.getElementById('sidebarOverlay');
      sidebar.classList.toggle('open');
      overlay.classList.toggle('hidden');
    }
    
    // 현재 시간 표시
    function updateTime() {
      const now = new Date();
      const timeStr = now.toLocaleString('ko-KR', { 
        month: 'short', 
        day: 'numeric', 
        hour: '2-digit', 
        minute: '2-digit' 
      });
      document.getElementById('currentTime').textContent = timeStr;
    }
    updateTime();
    setInterval(updateTime, 60000);
  </script>
</body>
</html>`
}



