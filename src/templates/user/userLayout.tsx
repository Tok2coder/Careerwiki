/**
 * 유저 마이페이지 컨텐츠 레이아웃
 * 기존 사이트 레이아웃(renderLayoutWithContext) 내에서 동작
 * 좌측 네비게이션 + 우측 컨텐츠 영역
 */

export interface UserLayoutProps {
  title: string
  currentPath: string
  children: string
  username?: string
  pictureUrl?: string | null
  role?: string | null
}

const navItems = [
  { path: '/user/ai-results', label: 'AI 추천', icon: 'fa-robot', color: 'text-emerald-400' },
  { path: '/user/drafts', label: '작성 가이드', icon: 'fa-file-alt', color: 'text-wiki-primary' },
  { path: '/user/comments', label: '작성 댓글', icon: 'fa-comments', color: 'text-wiki-secondary' },
  { path: '/user/bookmarks', label: '저장함', icon: 'fa-bookmark', color: 'text-amber-400' },
  { path: '/user/settings', label: '개인 설정', icon: 'fa-cog', color: 'text-slate-400' },
]

export function renderUserLayoutContent({ title, currentPath, children, username, pictureUrl, role }: UserLayoutProps): string {
  const initial = username ? username.charAt(0).toUpperCase() : 'U'
  
  // 역할 텍스트 결정
  const roleText = role === 'admin' || role === 'super-admin' || role === 'operator' 
    ? '관리자' 
    : role === 'expert' 
      ? '전문가' 
      : '일반 회원'
  
  return `
    <div class="max-w-[1400px] mx-auto px-4 pt-4 pb-10 sm:pt-8">
      <div class="flex flex-col lg:flex-row gap-6">
        
        <!-- 좌측 사이드바 (모바일: 가로 스크롤 탭, 데스크톱: 세로 메뉴) -->
        <aside class="lg:w-64 shrink-0">
          <!-- 사용자 정보 -->
          <div class="glass-card p-4 rounded-xl mb-4">
            <div class="flex items-center gap-3">
              ${pictureUrl ? `
                <img src="${pictureUrl}" alt="${username || '사용자'}" class="w-12 h-12 rounded-full object-cover border-2 border-wiki-border" />
              ` : `
                <div class="w-12 h-12 rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center text-white font-bold text-lg">
                  ${initial}
                </div>
              `}
              <div class="flex-1 min-w-0">
                <p class="font-semibold text-white truncate">${username || '사용자'}</p>
                <p class="text-xs text-wiki-muted">${roleText}</p>
              </div>
            </div>
          </div>
          
          <!-- 네비게이션 (모바일: 가로, 데스크톱: 세로) -->
          <nav class="glass-card rounded-xl overflow-hidden">
            <!-- 모바일: 가로 스크롤 -->
            <div class="lg:hidden flex overflow-x-auto gap-1 p-2" style="scrollbar-width: none; -ms-overflow-style: none;">
              ${navItems.map(item => `
                <a href="${item.path}" 
                   class="flex items-center gap-2 px-3 py-2 rounded-lg text-sm whitespace-nowrap transition ${
                     currentPath === item.path || currentPath.startsWith(item.path + '/') 
                       ? 'bg-wiki-primary/20 text-white' 
                       : 'text-wiki-muted hover:text-white hover:bg-wiki-primary/10'
                   }">
                  <i class="fas ${item.icon} ${item.color}"></i>
                  <span>${item.label}</span>
                </a>
              `).join('')}
            </div>
            
            <!-- 데스크톱: 세로 메뉴 -->
            <div class="hidden lg:block p-2 space-y-1">
              ${navItems.map(item => `
                <a href="${item.path}" 
                   class="flex items-center gap-3 px-4 py-3 rounded-lg text-sm transition ${
                     currentPath === item.path || currentPath.startsWith(item.path + '/') 
                       ? 'bg-wiki-primary/15 text-white border-l-3 border-wiki-primary' 
                       : 'text-wiki-muted hover:text-white hover:bg-wiki-primary/10'
                   }"
                   style="${currentPath === item.path || currentPath.startsWith(item.path + '/') ? 'border-left: 3px solid var(--wiki-primary, #4361ee);' : ''}">
                  <i class="fas ${item.icon} w-5 text-center ${item.color}"></i>
                  <span>${item.label}</span>
                </a>
              `).join('')}
            </div>
          </nav>
        </aside>
        
        <!-- 우측 메인 컨텐츠 -->
        <main class="flex-1 min-w-0">
          <!-- 페이지 헤더 -->
          <header class="mb-6 pb-4 border-b border-wiki-border/30">
            <h1 class="text-2xl font-bold text-white flex items-center gap-3">
              <span class="w-1.5 h-8 rounded-full bg-gradient-to-b from-wiki-primary to-wiki-secondary"></span>
              ${title}
            </h1>
          </header>
          
          <!-- 페이지 내용 -->
          <div class="glass-card rounded-xl p-4 sm:p-6">
            ${children}
          </div>
        </main>
        
      </div>
    </div>
    
    <style>
      /* 모바일 탭 스크롤바 숨기기 */
      .lg\\:hidden::-webkit-scrollbar {
        display: none;
      }
    </style>
  `
}
