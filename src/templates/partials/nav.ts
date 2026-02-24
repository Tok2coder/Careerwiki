/**
 * Shared navigation bar (same as non-home pages in index.tsx)
 * Accepts userMenuHtml (rendered by renderUserMenu)
 */

// 헤더 로고 (PNG 이미지)
const getNavLogoImage = () => {
  return `<img src="/images/CWheaderlogo.png" alt="Careerwiki" width="180" height="40" style="object-fit: contain;" />`
}

export function renderNav(userMenuHtml: string): string {
  return `
  <nav id="main-nav" class="glass-card fixed top-0 left-0 right-0 z-50 border-b border-wiki-border transition-transform duration-300">
    <div class="mx-auto w-full max-w-[1400px] px-3 py-2.5">
      <!-- Mobile Navigation -->
      <div class="flex items-center justify-between md:hidden relative h-[42px]">
        <!-- 기본 상태: 로고 (왼쪽) + 검색/햄버거 (오른쪽) -->
        <div id="mobile-nav-default" class="flex items-center justify-between w-full">
          <a href="/" class="flex items-center shrink-0 scale-75">
            ${getNavLogoImage()}
          </a>
          <div class="flex items-center gap-1 shrink-0">
            <button id="mobile-search-btn" class="w-11 h-11 flex items-center justify-center rounded-lg text-wiki-muted hover:text-white hover:bg-wiki-primary/10 transition-all" aria-label="검색 열기">
              <i class="fas fa-search text-lg"></i>
            </button>
            <button id="mobile-menu-btn" class="w-11 h-11 flex items-center justify-center rounded-lg text-wiki-muted hover:text-white hover:bg-wiki-primary/10 transition-all" aria-label="메뉴 열기">
              <i class="fas fa-bars text-xl"></i>
            </button>
          </div>
        </div>
        
        <!-- 검색 상태: 검색창 + 햄버거 (햄버거 위치 고정) -->
        <div id="mobile-nav-search" class="flex items-center justify-between w-full gap-1" style="display: none;">
          <div class="flex items-center gap-1 flex-1 min-w-0">
            <button type="button" id="mobile-search-close" class="w-10 h-10 flex items-center justify-center rounded-lg text-wiki-muted hover:text-white transition-all shrink-0" aria-label="검색 닫기">
              <i class="fas fa-times text-lg"></i>
            </button>
            <form action="/search" method="get" class="flex items-center gap-1 flex-1 min-w-0">
              <input 
                type="text" 
                name="q" 
                id="mobile-search-input"
                placeholder="검색..." 
                class="flex-1 min-w-0 px-3 py-2 bg-wiki-card/60 border border-wiki-border/50 rounded-xl text-white placeholder:text-wiki-muted focus:outline-none focus:border-wiki-primary/50 transition-all"
                style="font-size: 16px;"
              >
              <button type="submit" class="w-10 h-10 flex items-center justify-center rounded-xl bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white shrink-0" aria-label="검색">
                <i class="fas fa-search text-sm"></i>
              </button>
            </form>
          </div>
          <button id="mobile-menu-btn-search" class="w-11 h-11 flex items-center justify-center rounded-lg text-wiki-muted hover:text-white hover:bg-wiki-primary/10 transition-all shrink-0" aria-label="메뉴 열기">
            <i class="fas fa-bars text-xl"></i>
          </button>
        </div>
      </div>

      <!-- Desktop Navigation -->
      <div class="hidden md:flex w-full items-center gap-4 flex-nowrap">
        <a href="/" class="flex items-center shrink-0">
          ${getNavLogoImage()}
        </a>
        <form action="/search" method="get" class="nav-search-shell min-w-[240px] max-w-md">
          <div class="nav-search-bar">
            <input type="text" name="q" placeholder="직업, 전공, 진로를 검색하세요..." class="nav-search-input">
            <button type="submit" class="nav-search-button" aria-label="검색">
              <i class="fas fa-search"></i>
            </button>
          </div>
        </form>
        <div class="flex-grow"></div>
        <div class="flex items-center gap-1">
          <a href="/analyzer" class="nav-link">
            <i class="fas fa-brain nav-icon"></i><span>AI 추천</span>
          </a>
          <a href="/howto" class="nav-link">
            <i class="fas fa-route nav-icon"></i><span>HowTo</span>
          </a>
          <div class="w-px h-5 bg-wiki-border/40 mx-2"></div>
          <a href="/help" class="header-icon-button" title="도움말">
            <i class="fas fa-question-circle"></i>
          </a>
          ${userMenuHtml}
        </div>
      </div>
    </div>
  </nav>
  
  <!-- Mobile Menu (햄버거 클릭 시 표시) -->
  <div id="mobile-menu" class="fixed top-[57px] left-0 right-0 bottom-0 z-40 overflow-y-auto" style="display: none; background: rgba(11, 18, 32, 0.98); backdrop-filter: blur(20px);">
    <div class="mx-auto w-full max-w-[1400px] py-4 px-4">
      
      <!-- 1) 사용자 정보 (IP 또는 사용자 ID) -->
      <div class="mb-4 px-4 py-3 rounded-xl" style="background: rgba(26, 26, 46, 0.6); border: 1px solid rgba(100, 181, 246, 0.1);">
        <div class="flex items-center gap-3">
          <div id="mobile-user-avatar" class="w-10 h-10 rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center text-white font-bold text-lg">
            <i class="fas fa-user"></i>
          </div>
          <div class="flex-1 min-w-0">
            <span class="text-sm font-medium text-white block truncate" id="mobile-user-id-display">로딩 중...</span>
            <span class="text-xs text-wiki-muted" id="mobile-user-role-label">아이피</span>
          </div>
        </div>
      </div>
      
      <!-- 2) 메인 메뉴: AI 추천, HowTo -->
      <div class="flex gap-2 mb-4">
        <a href="/analyzer" class="flex-1 flex items-center justify-center gap-2 py-3 px-4 rounded-xl text-white font-medium transition-all" style="background: rgba(26, 26, 46, 0.6); border: 1px solid rgba(100, 181, 246, 0.15);">
          <i class="fas fa-brain text-emerald-400"></i>
          <span>AI 추천</span>
        </a>
        <a href="/howto" class="flex-1 flex items-center justify-center gap-2 py-3 px-4 rounded-xl text-white font-medium transition-all" style="background: rgba(26, 26, 46, 0.6); border: 1px solid rgba(100, 181, 246, 0.15);">
          <i class="fas fa-route text-amber-400"></i>
          <span>HowTo</span>
        </a>
      </div>
      
      <!-- 3) 사용자 메뉴 (로그인 상태에 따라 변경) -->
      <div id="mobile-user-menu-section" class="mb-4 rounded-xl overflow-hidden" style="background: rgba(26, 26, 46, 0.6); border: 1px solid rgba(100, 181, 246, 0.1);">
        <!-- JavaScript로 동적 렌더링 -->
      </div>
      
      <!-- 4) 하단: 개인설정, 도움말, 로그아웃 -->
      <div id="mobile-bottom-section" class="rounded-xl overflow-hidden" style="background: rgba(26, 26, 46, 0.6); border: 1px solid rgba(100, 181, 246, 0.1);">
        <div id="mobile-settings-section">
          <!-- JavaScript로 동적 렌더링 -->
        </div>
      </div>
      
    </div>
  </div>
  `
}

// Shared nav styles (copied from index.tsx non-home pages)
export function renderNavStyles(): string {
  return `
  <style id="nav-shared-styles">
    /* Fallback theme tokens for pages that don't load full app CSS */
    .bg-wiki-bg { background-color: #0b1220; }
    .text-wiki-text { color: #e6e8f5; }
    .text-wiki-muted { color: #9aa3c5; }
    .border-wiki-border { border-color: rgba(148, 163, 184, 0.25); }
    .glass-card { background: rgba(26, 26, 46, 0.82); border: 1px solid rgba(148, 163, 184, 0.22); backdrop-filter: blur(14px); }
    .header-icon-button { width: 38px; height: 38px; border-radius: 10px; display: inline-flex; align-items: center; justify-content: center; background: transparent; border: none; color: rgba(200, 210, 255, 0.7); transition: all 0.2s ease; }
    .header-icon-button:hover { color: #ffffff; background: rgba(100, 181, 246, 0.15); }
    .header-icon-button:focus-visible { outline: 2px solid #64b5f6; outline-offset: 2px; }
    /* 유저 아이콘 일관성: 모든 페이지에서 동일한 크기 보장 */
    #user-menu-btn { width: 38px; height: 38px; padding: 7px; }
    #user-menu-btn img,
    .header-icon-button img {
      display: block;
      width: 24px;
      height: 24px;
      min-width: 24px;
      min-height: 24px;
      max-width: 24px;
      max-height: 24px;
      flex: 0 0 24px;
      border-radius: 9999px;
      object-fit: cover;
    }
    #user-menu-btn > div {
      width: 24px;
      height: 24px;
      min-width: 24px;
      min-height: 24px;
      font-size: 12px;
    }
    #user-menu-btn > i {
      font-size: 16px;
    }
    #user-menu-dropdown { background: rgba(15, 19, 35, 0.96); border: 1px solid rgba(100, 116, 139, 0.22); }
    #user-menu-dropdown .border-wiki-border\\/30 { border-color: rgba(100, 116, 139, 0.18) !important; }
    #user-menu-dropdown .border-wiki-border\\/50 { border-color: rgba(100, 116, 139, 0.18) !important; }
    .nav-search-shell { width: 100%; }
    .nav-search-bar { display: flex; align-items: center; gap: 8px; padding: 4px 10px 4px 14px; border-radius: 9999px; background: rgba(26, 26, 46, 0.55); border: 1px solid rgba(100, 181, 246, 0.25); transition: border 0.2s ease, box-shadow 0.2s ease; }
    .nav-search-bar:focus-within { border-color: #4361ee; box-shadow: 0 10px 26px rgba(67, 97, 238, 0.25); }
    .nav-search-input { flex: 1; background: transparent; border: none; color: #dee3ff; font-size: 13px; line-height: 1.4; }
    .nav-search-input::placeholder { color: #7f88a8; }
    .nav-search-input:focus { outline: none; }
    .nav-search-button { width: 32px; height: 32px; border-radius: 9999px; display: inline-flex; align-items: center; justify-content: center; border: none; background: linear-gradient(135deg, #4361ee 0%, #64b5f6 100%); color: #ffffff; font-size: 14px; box-shadow: 0 6px 14px rgba(67, 97, 238, 0.25); transition: transform 0.2s ease, box-shadow 0.2s ease; cursor: pointer; }
    .nav-search-button:hover { transform: translateY(-1px); box-shadow: 0 12px 24px rgba(67, 97, 238, 0.35); }
    .nav-search-button:focus-visible { outline: 2px solid #64b5f6; outline-offset: 2px; }
    .nav-link { display: inline-flex; align-items: center; gap: 6px; padding: 8px 14px; border-radius: 8px; font-size: 0.8125rem; font-weight: 500; letter-spacing: 0.02em; color: rgba(200, 210, 255, 0.85); background: transparent; border: none; transition: all 0.2s ease; position: relative; white-space: nowrap; }
    .nav-link::after { content: ''; position: absolute; bottom: 4px; left: 14px; right: 14px; height: 2px; background: linear-gradient(90deg, #4361ee, #64b5f6); border-radius: 1px; transform: scaleX(0); transition: transform 0.2s ease; }
    .nav-link:hover { color: #ffffff; background: rgba(100, 181, 246, 0.1); }
    .nav-link:hover::after { transform: scaleX(1); }
    .nav-link:focus-visible { outline: 2px solid #64b5f6; outline-offset: 2px; }
    .nav-link .nav-icon { font-size: 0.875rem; opacity: 0.85; }
    
    /* Mobile Menu Item Styles */
    .mobile-menu-link {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 16px;
      color: #e6e8f5;
      font-size: 14px;
      transition: all 0.2s ease;
    }
    .mobile-menu-link:hover, .mobile-menu-link:active {
      background: rgba(67, 97, 238, 0.1);
    }
    .mobile-menu-link i {
      width: 18px;
      text-align: center;
      font-size: 14px;
    }
    
    @media (min-width: 768px) { 
      #main-nav { position: sticky !important; transform: translateY(0) !important; }
      #mobile-menu { display: none !important; }
    }
  </style>
  `
}

// Shared nav scripts (user menu + mobile toggle + return_url + IP for guest)
export function renderNavScripts(): string {
  return `
  <script>
    (function() {
      // Mobile search toggle
      const searchBtn = document.getElementById('mobile-search-btn');
      const searchClose = document.getElementById('mobile-search-close');
      const navDefault = document.getElementById('mobile-nav-default');
      const navSearch = document.getElementById('mobile-nav-search');
      const searchInput = document.getElementById('mobile-search-input');
      
      function openSearch() {
        if (navDefault) navDefault.style.display = 'none';
        if (navSearch) navSearch.style.display = 'flex';
        if (searchInput) setTimeout(function() { searchInput.focus(); }, 100);
      }
      
      function closeSearch() {
        if (navDefault) navDefault.style.display = 'flex';
        if (navSearch) navSearch.style.display = 'none';
      }
      
      if (searchBtn) searchBtn.addEventListener('click', openSearch);
      if (searchClose) searchClose.addEventListener('click', closeSearch);
      
      document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && navSearch && navSearch.style.display !== 'none') {
          closeSearch();
        }
      });
      
      // Mobile menu toggle
      const menuBtn = document.getElementById('mobile-menu-btn');
      const menuBtnSearch = document.getElementById('mobile-menu-btn-search');
      const mobileMenu = document.getElementById('mobile-menu');
      
      function toggleMenu() {
        if (!mobileMenu) return;
        const isOpen = mobileMenu.style.display !== 'none' && mobileMenu.style.display !== '';
        if (isOpen) {
          mobileMenu.style.display = 'none';
          document.body.style.overflow = '';
          if (menuBtn) menuBtn.innerHTML = '<i class="fas fa-bars text-xl"></i>';
          if (menuBtnSearch) menuBtnSearch.innerHTML = '<i class="fas fa-bars text-xl"></i>';
        } else {
          mobileMenu.style.display = 'block';
          document.body.style.overflow = 'hidden';
          if (menuBtn) menuBtn.innerHTML = '<i class="fas fa-times text-xl"></i>';
          if (menuBtnSearch) menuBtnSearch.innerHTML = '<i class="fas fa-times text-xl"></i>';
        }
      }
      
      if (menuBtn) menuBtn.addEventListener('click', toggleMenu);
      if (menuBtnSearch) menuBtnSearch.addEventListener('click', toggleMenu);

      // User menu toggle (Desktop)
      function initUserMenu() {
        const btn = document.getElementById('user-menu-btn');
        const dropdown = document.getElementById('user-menu-dropdown');
        if (!btn || !dropdown) return;
        btn.addEventListener('click', function(e) {
          e.stopPropagation();
          const isOpen = !dropdown.classList.contains('hidden');
          dropdown.classList.toggle('hidden', isOpen);
          btn.setAttribute('aria-expanded', String(!isOpen));
        });
        document.addEventListener('click', function(e) {
          if (!btn.contains(e.target) && !dropdown.contains(e.target)) {
            dropdown.classList.add('hidden');
            btn.setAttribute('aria-expanded', 'false');
          }
        });
      }

      // Mobile menu content rendering
      function renderMobileMenuLoggedIn(user) {
        const roleText = user.role === 'admin' || user.role === 'super-admin' || user.role === 'operator' ? '관리자' : user.role === 'expert' ? '전문가' : '일반 회원';
        
        // Update user info display
        const roleLabel = document.getElementById('mobile-user-role-label');
        const idDisplay = document.getElementById('mobile-user-id-display');
        const avatar = document.getElementById('mobile-user-avatar');
        if (roleLabel) roleLabel.textContent = roleText;
        if (idDisplay) idDisplay.textContent = user.username || 'user_' + user.id;
        if (avatar) {
          const initial = (user.username || user.email || 'U').charAt(0).toUpperCase();
          avatar.innerHTML = initial;
        }
        
        // User menu section (작성 가이드, 작성 댓글, 저장함)
        const userMenuSection = document.getElementById('mobile-user-menu-section');
        if (userMenuSection) {
          let adminLink = '';
          if (user.role === 'admin' || user.role === 'super-admin' || user.role === 'operator') {
            adminLink = '<a href="/admin" class="mobile-menu-link"><i class="fas fa-shield-alt text-amber-400"></i><span>관리자</span></a>';
          }
          userMenuSection.innerHTML = adminLink +
            '<a href="/user/ai-results" class="mobile-menu-link"><i class="fas fa-robot text-emerald-400"></i><span>AI 추천</span></a>' +
            '<a href="/user/drafts" class="mobile-menu-link"><i class="fas fa-file-alt text-wiki-primary"></i><span>작성 가이드</span></a>' +
            '<a href="/user/comments" class="mobile-menu-link"><i class="fas fa-comments text-wiki-secondary"></i><span>작성 댓글</span></a>' +
            '<a href="/user/bookmarks" class="mobile-menu-link"><i class="fas fa-bookmark text-amber-400"></i><span>저장함</span></a>';
        }
        
        // Settings section (개인설정, 도움말, 로그아웃)
        const settingsSection = document.getElementById('mobile-settings-section');
        if (settingsSection) {
          settingsSection.innerHTML = 
            '<a href="/user/settings" class="mobile-menu-link"><i class="fas fa-cog"></i><span>개인 설정</span></a>' +
            '<a href="/help" class="mobile-menu-link"><i class="fas fa-question-circle text-wiki-muted"></i><span>도움말</span></a>' +
            '<form action="/auth/logout" method="POST" class="logout-form">' +
              '<input type="hidden" name="return_url" class="logout-return-url" value="' + (window.location.pathname + window.location.search) + '">' +
              '<button type="submit" class="mobile-menu-link w-full text-left"><i class="fas fa-sign-out-alt"></i><span>로그아웃</span></button>' +
            '</form>';
        }
        
        // Show bottom section when logged in
        const bottomSection = document.getElementById('mobile-bottom-section');
        if (bottomSection) {
          bottomSection.style.display = 'block';
        }
      }

      function renderMobileMenuLoggedOut(ip) {
        // Update user info display
        const roleLabel = document.getElementById('mobile-user-role-label');
        const idDisplay = document.getElementById('mobile-user-id-display');
        if (roleLabel) roleLabel.textContent = '아이피';
        if (idDisplay) idDisplay.textContent = ip || '로딩 중...';
        
        // User menu section (로그인 버튼 + 도움말)
        const userMenuSection = document.getElementById('mobile-user-menu-section');
        if (userMenuSection) {
          userMenuSection.innerHTML = 
            '<a href="/login" data-login-link class="mobile-menu-link"><i class="fas fa-sign-in-alt"></i><span>로그인</span></a>' +
            '<a href="/help" class="mobile-menu-link"><i class="fas fa-question-circle text-wiki-muted"></i><span>도움말</span></a>';
        }
        
        // Settings section (비로그인 시 숨김)
        const settingsSection = document.getElementById('mobile-settings-section');
        if (settingsSection) {
          settingsSection.innerHTML = '';
        }
        
        // Hide bottom section when logged out
        const bottomSection = document.getElementById('mobile-bottom-section');
        if (bottomSection) {
          bottomSection.style.display = 'none';
        }
      }

      function renderLoggedInMenu(user) {
        const roleText = user.role === 'admin' || user.role === 'super-admin' || user.role === 'operator' ? '관리자' : user.role === 'expert' ? '전문가' : '일반 회원';
        const initial = (user.username || user.email || 'U').charAt(0).toUpperCase();
        const profileImg = user.pictureUrl || user.custom_picture_url || user.picture_url;
        const avatarHtml = profileImg 
          ? '<img src="' + profileImg + '" alt="' + (user.username || 'User') + '" class="w-10 h-10 rounded-full object-cover border border-wiki-border/50" style="width:2.5rem;height:2.5rem;flex-shrink:0;" onerror="this.style.display=\\'none\\';this.nextElementSibling.style.display=\\'flex\\';"/><div class="w-10 h-10 rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center text-white font-bold" style="width:2.5rem;height:2.5rem;flex-shrink:0;display:none;">' + initial + '</div>'
          : '<div class="w-10 h-10 rounded-full bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center text-white font-bold" style="width:2.5rem;height:2.5rem;flex-shrink:0;">' + initial + '</div>';
        const adminMenu = (user.role === 'admin' || user.role === 'super-admin' || user.role === 'operator') ?
          '<a href="/admin" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem"><div class="flex items-center gap-3"><i class="fas fa-shield-alt text-xs w-4 text-center text-amber-400"></i><span>관리자</span></div></a>' : '';
        return (
          '<div class="px-4 py-3 border-b border-wiki-border/30">' +
            '<div class="flex items-center gap-3">' +
              avatarHtml +
              '<div class="flex-1 min-w-0">' +
                '<span class="text-sm font-medium text-white block truncate">' + (user.username || 'user_' + user.id) + '</span>' +
                '<span class="text-xs text-wiki-muted">' + roleText + '</span>' +
              '</div>' +
            '</div>' +
          '</div>' +
          adminMenu +
          '<a href="/user/ai-results" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem"><div class="flex items-center gap-3"><i class="fas fa-robot text-xs w-4 text-center text-emerald-400"></i><span>AI 추천</span></div></a>' +
          '<a href="/user/drafts" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem"><div class="flex items-center gap-3"><i class="fas fa-file-alt text-xs w-4 text-center text-wiki-primary"></i><span>작성 가이드</span></div></a>' +
          '<a href="/user/comments" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem"><div class="flex items-center gap-3"><i class="fas fa-comments text-xs w-4 text-center text-wiki-secondary"></i><span>작성 댓글</span></div></a>' +
          '<a href="/user/bookmarks" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem"><div class="flex items-center gap-3"><i class="fas fa-bookmark text-xs w-4 text-center text-amber-400"></i><span>저장함</span></div></a>' +
          '<div class="border-t border-wiki-border/30 my-1"></div>' +
          '<a href="/user/settings" class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem"><div class="flex items-center gap-3"><i class="fas fa-cog text-xs w-4 text-center"></i><span>개인 설정</span></div></a>' +
          '<form action="/auth/logout" method="POST" class="logout-form">' +
            '<input type="hidden" name="return_url" class="logout-return-url" value="">' +
            '<button type="submit" class="w-full text-left px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors flex items-center gap-3" role="menuitem">' +
              '<i class="fas fa-sign-out-alt text-xs w-4 text-center"></i><span>로그아웃</span>' +
            '</button>' +
          '</form>'
        );
      }

      function renderLoggedOutMenu(ip) {
        return (
          '<div class="px-4 py-2.5 border-b border-wiki-border/30">' +
            '<div class="flex items-center justify-between">' +
              '<span class="text-xs text-wiki-muted">아이피</span>' +
              '<span id="user-ip-display" class="text-xs font-mono text-wiki-text font-medium">' + (ip || '로딩 중...') + '</span>' +
            '</div>' +
          '</div>' +
          '<a href="/login" data-login-link class="block px-4 py-2.5 text-sm text-wiki-text hover:bg-wiki-primary/10 transition-colors" role="menuitem">' +
            '<div class="flex items-center gap-3">' +
              '<i class="fas fa-sign-in-alt text-xs w-4 text-center"></i>' +
              '<span>로그인</span>' +
            '</div>' +
          '</a>'
        );
      }

      function fetchAndSetIp() {
        const ipDisplay = document.getElementById('user-ip-display');
        const mobileIpDisplay = document.getElementById('mobile-user-id-display');
        
        fetch('/api/client-ip')
          .then(res => res.json())
          .then(data => {
            if (data && data.ip) {
              if (ipDisplay) ipDisplay.textContent = data.ip;
              if (mobileIpDisplay && mobileIpDisplay.textContent === '로딩 중...') {
                mobileIpDisplay.textContent = data.ip;
              }
            }
          })
          .catch(() => {
            if (ipDisplay) ipDisplay.textContent = '127.0.0.1';
            if (mobileIpDisplay && mobileIpDisplay.textContent === '로딩 중...') {
              mobileIpDisplay.textContent = '127.0.0.1';
            }
          });
      }

      function hydrateUserMenu() {
        fetch('/api/me', {
          credentials: 'same-origin',
          cache: 'no-store',
          headers: { 'Cache-Control': 'no-store' }
        })
          .then(function(res) { return res.json(); })
          .then(function(data) {
            window.__setUserMenu(data && typeof data === 'object' ? data.user || null : null);
          })
          .catch(function() {
            window.__setUserMenu(null);
          });
      }

      function updateLoginLinks() {
        const currentPath = window.location.pathname + window.location.search;
        document.querySelectorAll('[data-login-link]').forEach(function(link) {
          link.setAttribute('href', '/login?redirect=' + encodeURIComponent(currentPath));
        });
      }

      window.__setUserMenu = function(user) {
        // Desktop dropdown
        const dropdown = document.getElementById('user-menu-dropdown');
        if (dropdown) {
          dropdown.innerHTML = user ? renderLoggedInMenu(user) : renderLoggedOutMenu();
        }
        
        // Mobile menu
        if (user) {
          renderMobileMenuLoggedIn(user);
        } else {
          fetchAndSetIp();
          renderMobileMenuLoggedOut();
        }
        
        document.querySelectorAll('.logout-return-url').forEach(input => {
          input.value = window.location.pathname + window.location.search;
        });
        updateLoginLinks();
      }

      initUserMenu();
      
      // Initialize mobile menu with logged out state
      renderMobileMenuLoggedOut('로딩 중...');

      document.querySelectorAll('.logout-return-url').forEach(input => {
        input.value = window.location.pathname + window.location.search;
      });
      updateLoginLinks();
      fetchAndSetIp();
      hydrateUserMenu();
      window.addEventListener('userLoaded', function(e) {
        window.__setUserMenu(e.detail || null);
      });
      window.addEventListener('pageshow', function(e) {
        if (e.persisted) {
          hydrateUserMenu();
        }
      });
    })();
  </script>
  `
}
