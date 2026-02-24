/**
 * 직업/전공 편집 시스템
 * 
 * Phase 3: 전체 편집 모드 UI
 * - 새 문서 생성 모달
 * - 전체 페이지 편집 모드
 * - 필드별 편집 UI
 */

const EditMode = {
  // 현재 상태
  isEditMode: false,
  entityType: null,  // 'job' | 'major'
  entityId: null,
  editData: {},      // 서버에서 로드한 원본 데이터
  tempEdits: {},     // 편집 중인 임시 데이터
  sources: {},       // 출처 데이터 { fieldKey: { id, text, url } }
  
  // 모달 참조
  createModal: null,
  
  /**
   * 초기화
   */
  init() {
    // 이미 초기화되었으면 스킵 (중복 초기화 방지)
    if (this._initialized) return;
    this._initialized = true;
    
    this.bindEvents();
    
    // URL에서 편집 모드 확인
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('edit') === 'true') {
      this.detectEntityFromUrl();
      if (this.entityType && this.entityId) {
        this.enterEditMode();
      }
    }
  },
  
  /**
   * URL에서 엔티티 정보 추출
   */
  detectEntityFromUrl() {
    const pathname = window.location.pathname;
    
    if (pathname.startsWith('/job/')) {
      this.entityType = 'job';
      let slug = pathname.replace('/job/', '');
      try { slug = decodeURIComponent(slug); } catch(e) {}
      // data-job-id 속성에서 실제 ID 가져오기
      const jobIdEl = document.querySelector('[data-job-id]');
      this.entityId = jobIdEl?.getAttribute('data-job-id') || slug;
    } else if (pathname.startsWith('/major/')) {
      this.entityType = 'major';
      let slug = pathname.replace('/major/', '');
      try { slug = decodeURIComponent(slug); } catch(e) {}
      const majorIdEl = document.querySelector('[data-major-id]');
      this.entityId = majorIdEl?.getAttribute('data-major-id') || slug;
    }
  },
  
  /**
   * 이벤트 바인딩
   */
  bindEvents() {
    document.addEventListener('click', (e) => {
      // 새 문서 추가 버튼
      const createBtn = e.target.closest('[data-create-entity]');
      if (createBtn) {
        e.preventDefault();
        const entityType = createBtn.getAttribute('data-create-entity');
        this.showCreateModal(entityType);
      }
      
      // 편집 모드 트리거 버튼
      const editTrigger = e.target.closest('[data-edit-mode-trigger]');
      if (editTrigger) {
        e.preventDefault();
        this.detectEntityFromUrl();
        if (this.entityType && this.entityId) {
          window.location.href = window.location.pathname + '?edit=true';
        }
      }
      
      // 모달 닫기
      const closeBtn = e.target.closest('[data-modal-close]');
      if (closeBtn) {
        e.preventDefault();
        this.closeCreateModal();
      }
      
      // 모달 백드롭 클릭
      const backdrop = e.target.closest('[data-modal-backdrop]');
      if (backdrop && e.target === backdrop) {
        this.closeCreateModal();
      }
    });
  },
  
  /**
   * 새 문서 생성 모달 표시
   */
  showCreateModal(entityType) {
    // 로그인 확인 (간단한 체크)
    const userInfo = this.getUserInfo();
    if (!userInfo) {
      alert('로그인이 필요합니다. 로그인 후 다시 시도해주세요.');
      window.location.href = '/login?redirect=' + encodeURIComponent(window.location.href);
      return;
    }
    
    const isJob = entityType === 'job';
    const title = isJob ? '새 직업 추가' : '새 전공 추가';
    const namePlaceholder = isJob ? '예: 소프트웨어 개발자' : '예: 컴퓨터공학과';
    const summaryPlaceholder = isJob 
      ? '이 직업에 대한 간단한 설명을 입력하세요 (최소 2자)' 
      : '이 전공에 대한 간단한 설명을 입력하세요 (최소 2자)';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    const gradientTo = isJob ? 'blue-500' : 'purple-500';
    
    const modalHtml = `
      <div id="create-modal" class="fixed inset-0 z-50 flex items-center justify-center p-4" data-modal-backdrop>
        <!-- 백드롭 -->
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm"></div>
        
        <!-- 모달 컨텐츠 -->
        <div class="relative w-full max-w-lg bg-wiki-card border border-wiki-border/50 rounded-2xl shadow-2xl overflow-hidden">
          <!-- 헤더 -->
          <div class="px-6 py-4 border-b border-wiki-border/30 bg-gradient-to-r from-${gradientFrom}/10 to-${gradientTo}/10">
            <div class="flex items-center justify-between">
              <h2 class="text-xl font-bold text-white">${title}</h2>
              <button type="button" data-modal-close class="p-2 text-wiki-muted hover:text-white transition">
                <i class="fas fa-times"></i>
              </button>
            </div>
          </div>
          
          <!-- 폼 -->
          <form id="create-entity-form" class="p-6 space-y-5">
            <input type="hidden" name="entityType" value="${entityType}">
            
            <!-- 이름 (필수) -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-white">
                ${isJob ? '직업명' : '전공명'} <span class="text-red-400">*</span>
              </label>
              <div class="relative">
                <input
                  type="text"
                  name="name"
                  id="create-name-input"
                  required
                  minlength="2"
                  maxlength="100"
                  placeholder="${namePlaceholder}"
                  class="w-full px-4 py-3 pr-10 bg-wiki-bg/70 border border-wiki-border/60 rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition"
                >
                <span id="name-check" class="absolute right-3 top-1/2 -translate-y-1/2 text-lg hidden">
                  <i class="fas fa-spinner fa-spin text-wiki-muted" id="name-loading"></i>
                  <i class="fas fa-check-circle text-green-500 hidden" id="name-ok"></i>
                  <i class="fas fa-times-circle text-red-500 hidden" id="name-error-icon"></i>
                </span>
              </div>
              <p id="name-error-msg" class="text-xs text-red-400 hidden"></p>
            </div>
            
            <!-- 설명 (필수) -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-white">
                ${isJob ? '직업 설명' : '전공 설명'} <span class="text-red-400">*</span>
              </label>
              <textarea
                name="summary"
                required
                minlength="2"
                maxlength="7000"
                rows="4"
                placeholder="${summaryPlaceholder}"
                class="w-full px-4 py-3 bg-wiki-bg/70 border border-wiki-border/60 rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition resize-y"
              ></textarea>
              <p class="text-xs text-wiki-muted">나머지 정보는 등록 후 편집에서 추가할 수 있습니다.</p>
            </div>
            
            <!-- 태그 (선택) -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-white">
                태그 <span class="text-wiki-muted text-xs">(선택, Enter 또는 쉼표로 추가)</span>
              </label>
              <input
                type="text"
                id="create-tags-input"
                placeholder="태그 입력 후 Enter 또는 쉼표(,)"
                class="w-full px-4 py-3 bg-wiki-bg/70 border border-wiki-border/60 rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition"
              >
              <div id="create-tags-container" class="flex flex-wrap gap-2"></div>
            </div>
            
            <!-- 분류/계열 (선택) -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-white">
                ${isJob ? '직업 분류' : '계열'} <span class="text-wiki-muted text-xs">(선택, 하나만 선택)</span>
              </label>
              <div class="relative">
                <input
                  type="text"
                  id="create-category-input"
                  autocomplete="off"
                  placeholder="${isJob ? '분류 검색...' : '계열 검색...'}"
                  class="w-full px-4 py-3 bg-wiki-bg/70 border border-wiki-border/60 rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition"
                >
                <div id="create-category-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto"></div>
                <div id="create-category-selected" class="mt-2"></div>
              </div>
            </div>
            
            <!-- 에러 메시지 영역 -->
            <div id="create-error" class="hidden p-3 bg-red-500/10 border border-red-500/30 rounded-lg text-red-400 text-sm"></div>
            
            <!-- 버튼 -->
            <div class="flex items-center justify-end gap-3 pt-2">
              <button
                type="button"
                data-modal-close
                class="px-5 py-2.5 text-wiki-muted hover:text-white transition"
              >
                취소
              </button>
              <button
                type="submit"
                class="px-6 py-2.5 bg-gradient-to-r from-${gradientFrom} to-${gradientTo} text-white font-medium rounded-xl hover:shadow-lg hover:shadow-${gradientFrom}/25 active:scale-95 transition-all duration-200"
              >
                <i class="fas fa-check mr-2"></i>등록
              </button>
            </div>
          </form>
        </div>
      </div>
    `;
    
    // DOM에 추가
    document.body.insertAdjacentHTML('beforeend', modalHtml);
    this.createModal = document.getElementById('create-modal');
    
    // 폼 제출 이벤트
    const form = document.getElementById('create-entity-form');
    form.addEventListener('submit', (e) => this.handleCreateSubmit(e));
    
    // 이름 중복 체크 이벤트
    this.isNameAvailable = false;
    this.nameCheckTimer = null;
    const nameInput = document.getElementById('create-name-input');
    nameInput?.addEventListener('input', (e) => this.handleNameCheck(e, entityType));
    
    // 태그 이벤트 초기화
    this.selectedTags = [];
    this.initTagsInput();
    
    // 분류/계열 자동완성 초기화
    this.selectedCategory = null;
    this.initCategoryAutocomplete(entityType);
    
    // ESC 키로 닫기
    document.addEventListener('keydown', this.handleEscKey);
    
    // 첫 입력 필드에 포커스
    setTimeout(() => {
      form.querySelector('input[name="name"]')?.focus();
    }, 100);
  },
  
  /**
   * 태그 입력 초기화
   */
  initTagsInput() {
    const input = document.getElementById('create-tags-input');
    const container = document.getElementById('create-tags-container');
    if (!input || !container) return;
    
    input.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ',') {
        e.preventDefault();
        const tag = input.value.replace(/,/g, '').trim();
        if (tag && !this.selectedTags.includes(tag)) {
          this.selectedTags.push(tag);
          this.addTagChip(container, tag);
        }
        input.value = '';
      }
    });
  },
  
  /**
   * 태그 칩 추가
   */
  addTagChip(container, tag) {
    const chip = document.createElement('span');
    chip.className = 'inline-flex items-center gap-1 px-3 py-1 bg-wiki-primary/10 text-wiki-primary rounded-full text-sm';
    chip.dataset.tag = tag;
    chip.innerHTML = `${this.escapeHtml(tag)}<button type="button" class="hover:text-red-400 ml-1"><i class="fas fa-times text-xs"></i></button>`;
    
    chip.querySelector('button').addEventListener('click', () => {
      this.selectedTags = this.selectedTags.filter(t => t !== tag);
      chip.remove();
    });
    
    container.appendChild(chip);
  },
  
  /**
   * 분류/계열 자동완성 초기화
   */
  initCategoryAutocomplete(entityType) {
    const input = document.getElementById('create-category-input');
    const dropdown = document.getElementById('create-category-dropdown');
    const selectedContainer = document.getElementById('create-category-selected');
    if (!input || !dropdown || !selectedContainer) return;
    
    let debounceTimer = null;
    const isJob = entityType === 'job';
    
    input.addEventListener('input', () => {
      clearTimeout(debounceTimer);
      const q = input.value.trim();
      
      if (q.length < 1) {
        dropdown.classList.add('hidden');
        return;
      }
      
      debounceTimer = setTimeout(async () => {
        try {
          const endpoint = isJob ? '/api/job/categories' : '/api/major/categories';
          const res = await fetch(`${endpoint}?q=${encodeURIComponent(q)}&limit=10`);
          const data = await res.json();
          
          if (data.success && data.categories && data.categories.length > 0) {
            dropdown.innerHTML = data.categories.map(cat => 
              `<div class="autocomplete-item px-3 py-2 hover:bg-wiki-primary/10 cursor-pointer text-white text-sm" data-value="${this.escapeHtml(cat)}">${this.escapeHtml(cat)}</div>`
            ).join('');
            dropdown.classList.remove('hidden');
          } else {
            // 검색 결과가 없으면 입력값 자체를 옵션으로 표시
            dropdown.innerHTML = `<div class="autocomplete-item px-3 py-2 hover:bg-wiki-primary/10 cursor-pointer text-white text-sm" data-value="${this.escapeHtml(q)}"><span class="text-wiki-muted">새로 추가:</span> ${this.escapeHtml(q)}</div>`;
            dropdown.classList.remove('hidden');
          }
        } catch (err) {
          dropdown.classList.add('hidden');
        }
      }, 300);
    });
    
    // 드롭다운 항목 클릭
    dropdown.addEventListener('click', (e) => {
      const item = e.target.closest('.autocomplete-item');
      if (item) {
        const value = item.dataset.value;
        this.selectCategory(value, selectedContainer, input);
        dropdown.classList.add('hidden');
      }
    });
    
    // 포커스 아웃 시 드롭다운 숨김
    input.addEventListener('blur', () => {
      setTimeout(() => dropdown.classList.add('hidden'), 200);
    });
    
    // Enter로 첫 번째 항목 선택 또는 직접 입력
    input.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        e.preventDefault();
        const firstItem = dropdown.querySelector('.autocomplete-item');
        if (firstItem && !dropdown.classList.contains('hidden')) {
          const value = firstItem.dataset.value;
          this.selectCategory(value, selectedContainer, input);
          dropdown.classList.add('hidden');
        } else if (input.value.trim()) {
          this.selectCategory(input.value.trim(), selectedContainer, input);
        }
      }
    });
  },
  
  /**
   * 분류/계열 선택
   */
  selectCategory(value, container, input) {
    this.selectedCategory = value;
    container.innerHTML = `
      <span class="inline-flex items-center gap-2 px-3 py-1.5 bg-wiki-secondary/10 text-wiki-secondary rounded-lg text-sm border border-wiki-secondary/30">
        ${this.escapeHtml(value)}
        <button type="button" class="hover:text-red-400"><i class="fas fa-times text-xs"></i></button>
      </span>
    `;
    
    container.querySelector('button').addEventListener('click', () => {
      this.selectedCategory = null;
      container.innerHTML = '';
      input.value = '';
    });
    
    input.value = '';
  },
  
  /**
   * 이름 중복 체크 핸들러
   */
  async handleNameCheck(e, entityType) {
    const nameInput = e.target;
    const name = nameInput.value.trim();
    
    const nameCheck = document.getElementById('name-check');
    const nameLoading = document.getElementById('name-loading');
    const nameOk = document.getElementById('name-ok');
    const nameErrorIcon = document.getElementById('name-error-icon');
    const nameErrorMsg = document.getElementById('name-error-msg');
    
    // 기존 타이머 취소
    if (this.nameCheckTimer) {
      clearTimeout(this.nameCheckTimer);
    }
    
    // 빈 값이면 숨김
    if (!name) {
      nameCheck.classList.add('hidden');
      nameErrorMsg.classList.add('hidden');
      this.isNameAvailable = false;
      return;
    }
    
    // 2자 미만이면 바로 에러
    if (name.length < 2) {
      nameCheck.classList.remove('hidden');
      nameLoading.classList.add('hidden');
      nameOk.classList.add('hidden');
      nameErrorIcon.classList.remove('hidden');
      nameErrorMsg.textContent = entityType === 'job' 
        ? '직업명은 최소 2자 이상이어야 합니다' 
        : '전공명은 최소 2자 이상이어야 합니다';
      nameErrorMsg.classList.remove('hidden');
      this.isNameAvailable = false;
      return;
    }
    
    // 로딩 표시
    nameCheck.classList.remove('hidden');
    nameLoading.classList.remove('hidden');
    nameOk.classList.add('hidden');
    nameErrorIcon.classList.add('hidden');
    nameErrorMsg.classList.add('hidden');
    
    // 500ms 후 API 호출 (디바운싱)
    this.nameCheckTimer = setTimeout(async () => {
      try {
        const res = await fetch(`/api/${entityType}/check-name?name=` + encodeURIComponent(name));
        const data = await res.json();
        
        nameLoading.classList.add('hidden');
        
        if (data.success && data.available) {
          nameOk.classList.remove('hidden');
          nameErrorIcon.classList.add('hidden');
          nameErrorMsg.classList.add('hidden');
          this.isNameAvailable = true;
        } else {
          nameOk.classList.add('hidden');
          nameErrorIcon.classList.remove('hidden');
          nameErrorMsg.textContent = data.reason || '사용할 수 없는 이름입니다';
          nameErrorMsg.classList.remove('hidden');
          this.isNameAvailable = false;
        }
      } catch (err) {
        nameLoading.classList.add('hidden');
        nameOk.classList.add('hidden');
        nameErrorIcon.classList.remove('hidden');
        nameErrorMsg.textContent = '확인 중 오류가 발생했습니다';
        nameErrorMsg.classList.remove('hidden');
        this.isNameAvailable = false;
      }
    }, 500);
  },
  
  /**
   * ESC 키 핸들러
   */
  handleEscKey(e) {
    if (e.key === 'Escape') {
      EditMode.closeCreateModal();
    }
  },
  
  /**
   * 생성 모달 닫기
   */
  closeCreateModal() {
    if (this.createModal) {
      this.createModal.remove();
      this.createModal = null;
      document.removeEventListener('keydown', this.handleEscKey);
    }
  },
  
  /**
   * 생성 폼 제출 처리
   */
  async handleCreateSubmit(e) {
    e.preventDefault();
    
    const form = e.target;
    const formData = new FormData(form);
    const entityType = formData.get('entityType');
    const submitBtn = form.querySelector('button[type="submit"]');
    const errorDiv = document.getElementById('create-error');
    
    // 데이터 수집
    const payload = {
      name: formData.get('name')?.toString().trim(),
      summary: formData.get('summary')?.toString().trim(),
    };
    
    // 태그 처리 (selectedTags 배열 사용)
    if (this.selectedTags && this.selectedTags.length > 0) {
      payload.heroTags = [...new Set(this.selectedTags)];
    }
    
    // 분류/계열 (selectedCategory 사용)
    if (this.selectedCategory) {
      const categoryField = entityType === 'job' ? 'heroCategory' : 'categoryName';
      payload[categoryField] = this.selectedCategory;
    }
    
    // 유효성 검사
    if (!payload.name || payload.name.length < 2) {
      this.showCreateError('이름은 최소 2자 이상이어야 합니다.');
      return;
    }
    if (!payload.summary || payload.summary.length < 2) {
      this.showCreateError('설명은 최소 2자 이상이어야 합니다.');
      return;
    }
    
    // 이름 중복 체크 확인
    if (!this.isNameAvailable) {
      const nameLabel = entityType === 'job' ? '직업명' : '전공명';
      this.showCreateError(`${nameLabel}이 사용 가능한지 확인해주세요. 이미 존재하는 이름이거나 확인이 완료되지 않았습니다.`);
      return;
    }
    
    // 로딩 상태
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>등록 중...';
    errorDiv.classList.add('hidden');
    
    try {
      const endpoint = `/api/${entityType}/create`;
      const response = await fetch(endpoint, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      
      const result = await response.json();
      
      if (!response.ok || !result.success) {
        throw new Error(result.error || '생성에 실패했습니다.');
      }
      
      // 성공 - 새로 생성된 페이지로 이동
      const slug = result.slug || result.id;
      window.location.href = `/${entityType}/${encodeURIComponent(slug)}`;
      
    } catch (error) {
      this.showCreateError(error.message || '생성 중 오류가 발생했습니다.');
      
      submitBtn.disabled = false;
      submitBtn.innerHTML = '<i class="fas fa-check mr-2"></i>등록';
    }
  },
  
  /**
   * 생성 에러 표시
   */
  showCreateError(message) {
    const errorDiv = document.getElementById('create-error');
    if (errorDiv) {
      errorDiv.textContent = message;
      errorDiv.classList.remove('hidden');
    }
  },
  
  /**
   * 사용자 정보 가져오기
   */
  getUserInfo() {
    // 1. 전역 변수에서 확인 (서버에서 주입)
    if (window.__USER__) {
      return window.__USER__;
    }
    
    // 2. 페이지에서 로그인 상태 확인 (data 속성)
    const authEl = document.querySelector('[data-user-authenticated="true"]');
    if (authEl) {
      return { authenticated: true };
    }
    
    // 3. 헤더의 사용자 메뉴 확인 (로그인 상태면 프로필 드롭다운이 있음)
    const userMenu = document.querySelector('[data-user-menu]');
    if (userMenu) {
      return { authenticated: true };
    }
    
    // 4. 로그인 버튼이 없으면 로그인 상태
    const loginBtn = document.querySelector('a[href^="/login"]');
    const logoutBtn = document.querySelector('a[href="/logout"]');
    if (logoutBtn && !loginBtn) {
      return { authenticated: true };
    }
    
    return null;
  },
  
  // ============================================
  // 편집 모드 (상세 페이지)
  // ============================================
  
  /**
   * 편집 모드 진입
   */
  async enterEditMode() {
    
    // 사용자 정보 로드 대기 (ISR 캐시 대응)
    if (!window.__USER_LOADED__) {
      await new Promise(resolve => {
        const checkUser = () => {
          if (window.__USER_LOADED__) {
            resolve();
          } else {
            window.addEventListener('userLoaded', resolve, { once: true });
            // 타임아웃 (3초 후 강제 진행)
            setTimeout(resolve, 3000);
          }
        };
        checkUser();
      });
    }
    
    this.isEditMode = true;
    
    // 편집 데이터 로드
    await this.loadEditData();
    
    if (Object.keys(this.editData).length === 0) {
      alert('편집 데이터를 불러오는데 실패했습니다.');
      this.exitEditMode();
      return;
    }
    
    // 편집 모드 UI 렌더링
    this.renderEditModeUI();
  },
  
  /**
   * 편집 데이터 로드
   */
  async loadEditData() {
    try {
      const endpoint = `/api/${this.entityType}/${encodeURIComponent(this.entityId)}/edit-data`;
      const response = await fetch(endpoint, {
        cache: 'no-store',
        headers: {
          'Cache-Control': 'no-cache'
        }
      });
      const result = await response.json();
      
      if (!response.ok || !result.success) {
        throw new Error(result.error || '데이터 로드 실패');
      }
      
      this.editData = result.data || {};
      
      // entityId 업데이트 (서버에서 반환한 실제 ID)
      if (result.entityId) {
        this.entityId = result.entityId;
      }
      
      
    } catch (error) {
      this.editData = {};
    }
  },
  
  /**
   * 편집 모드 UI 렌더링
   */
  renderEditModeUI() {
    // 기존 페이지 내용을 저장
    const originalContent = document.body.innerHTML;
    
    // 편집 모드 UI 생성
    const editModeHtml = this.createEditModeHtml();
    
    // body 교체
    document.body.innerHTML = editModeHtml;
    document.body.setAttribute('data-edit-mode', 'true');
    
    // 이벤트 리스너 등록
    this.bindEditModeEvents();
    
    // 원본 저장 (취소 시 복원용)
    this._originalContent = originalContent;
  },
  
  /**
   * 편집 모드 HTML 생성
   */
  createEditModeHtml() {
    const isJob = this.entityType === 'job';
    const title = this.editData.name || (isJob ? '직업' : '전공');
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    const gradientTo = isJob ? 'blue-500' : 'purple-500';
    
    // 필드 설정 가져오기
    const fieldGroups = this.getFieldGroups();
    
    return `
      <div class="min-h-screen bg-wiki-bg text-white">
        <!-- 상단 편집 바 -->
        <div class="sticky top-0 z-40 bg-gradient-to-b from-wiki-card to-wiki-card/95 backdrop-blur-md border-b border-${gradientFrom}/20 shadow-lg shadow-black/20">
          <div class="max-w-6xl mx-auto">
            <!-- 상단: 편집 상태 표시 바 -->
            <div class="px-4 py-1.5 bg-gradient-to-r from-${gradientFrom}/10 to-${gradientTo}/10 border-b border-${gradientFrom}/10">
              <div class="flex items-center justify-between">
                <div class="flex items-center gap-2 text-xs text-${gradientFrom}">
                  <i class="fas fa-edit"></i>
                  <span class="font-medium">${isJob ? '직업' : '전공'} 편집 중</span>
                </div>
                ${this.isAdmin() ? `
                <div class="flex items-center gap-1">
                  <button
                    type="button"
                    id="edit-hide-btn"
                    class="px-2 py-1 text-[11px] text-yellow-500/80 hover:text-yellow-400 hover:bg-yellow-500/10 rounded transition flex items-center gap-1"
                    title="${isJob ? '직업' : '전공'} 숨기기"
                  >
                    <i class="fas fa-eye-slash text-[10px]"></i>
                    <span>숨기기</span>
                  </button>
                  <span class="text-wiki-border/50">|</span>
                  <button
                    type="button"
                    id="edit-delete-btn"
                    class="px-2 py-1 text-[11px] text-red-500/80 hover:text-red-400 hover:bg-red-500/10 rounded transition flex items-center gap-1"
                    title="${isJob ? '직업' : '전공'} 삭제"
                  >
                    <i class="fas fa-trash-alt text-[10px]"></i>
                    <span>삭제</span>
                  </button>
                </div>
                ` : ''}
              </div>
            </div>
            
            <!-- 메인: 제목 + 액션 버튼 -->
            <div class="px-4 py-3 sm:py-4">
              <div class="flex items-center justify-between gap-4">
                <!-- 왼쪽: 뒤로가기 + 제목 (제목이 주인공) -->
                <div class="flex items-center gap-3 min-w-0 flex-1">
                  <button
                    type="button"
                    id="edit-cancel-btn"
                    class="shrink-0 w-10 h-10 sm:w-11 sm:h-11 flex items-center justify-center text-wiki-muted hover:text-white hover:bg-wiki-border/30 rounded-xl transition"
                    title="편집 취소"
                  >
                    <i class="fas fa-arrow-left text-lg"></i>
                  </button>
                  <div class="min-w-0 flex-1">
                    <h1 class="text-xl sm:text-2xl md:text-[26px] font-bold text-white leading-tight truncate">${this.escapeHtml(title)}</h1>
                    <p class="text-xs sm:text-sm text-wiki-muted mt-0.5 hidden sm:block">아래 필드를 수정하고 저장하세요</p>
                  </div>
                </div>
                
                <!-- 오른쪽: 저장 버튼 (항상 눈에 띄게) -->
                <button
                  type="button"
                  id="edit-save-btn"
                  class="shrink-0 px-5 sm:px-6 py-2.5 sm:py-3 min-h-[44px] bg-gradient-to-r from-${gradientFrom} to-${gradientTo} text-white font-semibold rounded-xl hover:shadow-lg hover:shadow-${gradientFrom}/30 active:scale-[0.98] transition-all duration-200 text-sm sm:text-base"
                >
                  <i class="fas fa-check mr-2 hidden sm:inline"></i>
                  <span>저장</span>
                </button>
              </div>
            </div>
          </div>
        </div>
        
        <!-- 메인 컨텐츠 -->
        <div class="max-w-4xl mx-auto px-4 py-8">
          <!-- 읽기 전용 필드 (이름) -->
          <div class="mb-8 p-4 bg-wiki-card/50 border border-wiki-border/30 rounded-xl">
            <label class="block text-xs font-medium text-wiki-muted mb-2">
              ${isJob ? '직업명' : '전공명'} <span class="text-yellow-500">(수정 불가)</span>
            </label>
            <div class="text-lg font-semibold text-white/70">${this.escapeHtml(title)}</div>
          </div>
          
          <!-- 편집 가능 필드들 -->
          ${fieldGroups.map(group => this.renderFieldGroup(group)).join('')}
        </div>
      </div>
    `;
  },
  
  /**
   * 필드 그룹 정보 가져오기
   */
  getFieldGroups() {
    const isJob = this.entityType === 'job';
    
    if (isJob) {
      return [
        {
          title: '히어로 섹션',
          section: 'hero',
          fields: [
            { key: 'summary', label: '직업 설명', type: 'textarea', examples: [
              '소프트웨어 개발자는 컴퓨터 프로그램과 애플리케이션을 설계, 개발, 테스트하는 전문가입니다.',
              '데이터 분석가는 대용량 데이터를 수집, 처리, 분석하여 비즈니스 인사이트를 도출하는 전문가입니다.',
              '간호사는 환자의 건강 상태를 관찰하고, 의료진과 협력하여 치료 및 간호 서비스를 제공합니다.'
            ]},
            { key: 'heroTags', label: '태그', type: 'tags', examples: [
              '프로그래밍, IT, 개발, 소프트웨어',
              '의료, 헬스케어, 환자케어, 병원',
              '금융, 투자, 분석, 컨설팅'
            ]},
            { key: 'heroCategory', label: '직업 분류', type: 'text', examples: ['IT/소프트웨어', '의료/보건', '금융/경제'] }
          ]
        },
        {
          title: '개요 - 주요 업무',
          section: 'overview',
          fields: [
            { key: 'overviewWork.main', label: '수행 직무', type: 'list', examples: [
              '소프트웨어 요구사항 분석 및 설계\n프로그램 코드 작성 및 디버깅\n시스템 테스트 및 품질 관리',
              '환자 상태 관찰 및 기록\n투약 및 주사 시행\n의료진과 협력하여 치료 계획 수립',
              '재무제표 분석 및 보고서 작성\n투자 포트폴리오 관리\n고객 상담 및 금융 상품 추천'
            ]},
            { key: 'overviewWork.workStrong', label: '작업강도', type: 'text', examples: ['보통 (앉아서 하는 업무 중심)', '높음 (신체 활동 많음)', '낮음 (정적인 업무)'] },
            { key: 'overviewWork.workPlace', label: '작업장소', type: 'text', examples: ['실내 (사무실, 재택근무 가능)', '병원/의료시설', '현장 및 사무실 병행'] },
            { key: 'overviewWork.physicalAct', label: '육체활동', type: 'text', examples: ['가벼운 활동 (컴퓨터 작업 위주)', '중간 활동 (이동, 서서 일함)', '높은 활동 (중량물 취급)'] }
          ]
        },
        // 커리어 전망은 API 데이터 기반이므로 편집 불가 (제외)
        {
          title: '개요 - 핵심 능력·자격',
          section: 'overview',
          fields: [
            { key: 'overviewAbilities.abilityList', label: '핵심 역량', type: 'tags', examples: [
              '논리적 사고력, 문제해결능력, 프로그래밍',
              '의사소통, 공감능력, 응급상황 대처',
              '분석력, 수리능력, 리서치 역량'
            ]},
            { key: 'overviewAbilities.technKnow', label: '활용 기술', type: 'textarea', examples: [
              'Python, JavaScript, Java, SQL, Git, Docker, AWS 등',
              '전자의무기록(EMR), 의료장비 조작, 감염관리 시스템',
              'Excel, SAP, ERP 시스템, 데이터 분석 도구'
            ]},
            { key: 'overviewAbilities.eduLevel', label: '학력 수준', type: 'text', examples: ['대졸 이상 (컴퓨터공학 등)', '전문대졸 이상 (간호학과)', '고졸 이상 (자격증 필수)'] },
            { key: 'overviewAbilities.skillYear', label: '숙련 기간', type: 'text', examples: ['2~5년 (경력에 따라 다름)', '1~3년 (수습 기간 포함)', '3~7년 (전문 분야 형성)'] }
          ]
        },
        {
          title: '개요 - 적성 및 흥미',
          section: 'overview',
          fields: [
            { key: 'overviewAptitude.aptitudeList', label: '적성', type: 'tags', examples: [
              '분석력, 논리적 사고, 창의성, 집중력',
              '꼼꼼함, 책임감, 봉사정신, 체력',
              '소통능력, 설득력, 협상력'
            ]},
            { key: 'overviewAptitude.interestList', label: '흥미', type: 'tags', examples: [
              '탐구형, 현실형',
              '사회형, 관습형',
              '예술형, 진취형'
            ]}
          ]
        },
        {
          title: '개요 - 여담',
          section: 'overview',
          fields: [
            { key: 'trivia', label: '여담', type: 'list', examples: [
              '소프트웨어 개발자는 원격 근무가 가능한 직업 중 하나입니다',
              '최근 코로나19 이후 많은 기업들이 재택근무를 도입하면서 개발자들의 워라밸이 크게 개선되었습니다',
              '개발자 커뮤니티 활동이 활발하며, 오픈소스 기여나 기술 블로그 운영이 경력 발전에 도움이 됩니다'
            ]}
          ]
        },
        {
          title: '상세정보 - 직업 준비하기',
          section: 'details',
          fields: [
            { key: 'detailReady.curriculum', label: '정규 교육과정', type: 'list', examples: [
              '대학교 컴퓨터공학과 4년 과정\n전문대 소프트웨어학과 2~3년 과정\n학점은행제 정보처리 학위 과정',
              '4년제 대학 간호학과 졸업\n3년제 전문대 간호과 졸업\n간호사 국가시험 합격',
              '경영학 또는 경제학 학사 이상\nMBA 또는 금융 관련 석사\n금융 관련 자격증 취득 과정'
            ]},
            { key: 'detailReady.recruit', label: '채용 정보', type: 'list', examples: [
              '주요 IT기업, 스타트업에서 상시 채용\n원티드, 로켓펀치 등 플랫폼 활용\n기업 공채 및 수시 채용',
              '대학병원, 종합병원에서 정기 채용\n요양시설 상시 채용\n간호사 전문 채용 사이트 활용',
              '금융권 공채 및 수시채용\n금융권 취업 카페 활용\nLinkedIn 네트워킹'
            ]},
            { key: 'detailReady.training', label: '필요 교육/훈련', type: 'list', examples: [
              '국비지원 부트캠프 수강\n온라인 강의(인프런, 유데미) 수강\n기업 인턴십 참여',
              '간호학과 4년제/3년제 과정 이수\n병원 실습 경험\n전문간호사 과정 이수',
              '금융권 연수원 교육 이수\nMBA 과정 진학\n금융 관련 온라인 과정 수강'
            ]},
            { key: 'detailReady.researchList', label: '진로 탐색 활동', type: 'list', examples: [
              '프로그래밍 동아리 활동\n해커톤, 코딩 대회 참가\nIT 기업 인턴십\n개인 프로젝트 및 포트폴리오',
              '병원 봉사활동\n보건 관련 동아리\n응급처치 교육 이수\n의료기관 견학',
              '모의투자 대회 참가\n금융 관련 학회 활동\n증권사 인턴십\n재무 분석 프로젝트'
            ]}
          ]
        },
        {
          title: '사이드바 - 연관 정보',
          section: 'sidebar',
          fields: [
            { key: 'sidebarJobs', label: '관련 직업', type: 'autocomplete', domain: 'jobs', examples: [
              '백엔드 개발자, 프론트엔드 개발자, 풀스택 개발자',
              '내과 간호사, 수술실 간호사, 응급실 간호사',
              '펀드매니저, 증권 분석가, 리스크 관리자'
            ]},
            { key: 'sidebarMajors', label: '관련 학과', type: 'autocomplete', domain: 'majors', examples: [
              '컴퓨터공학과, 소프트웨어공학과, 정보통신공학과',
              '간호학과, 보건학과, 의료공학과',
              '경영학과, 경제학과, 금융학과'
            ]},
            { key: 'sidebarCerts', label: '추천 자격증', type: 'tags', examples: [
              '정보처리기사, SQLD, AWS Certified Developer',
              '간호사 면허, BLS, ACLS',
              'CFA, FRM, 투자자산운용사'
            ]}
          ]
        }
      ];
    } else {
      // 전공
      return [
        {
          title: '히어로 섹션',
          section: 'hero',
          fields: [
            { key: 'heroSummary', label: '전공 설명', type: 'textarea', examples: [
              '컴퓨터공학과는 컴퓨터 시스템의 하드웨어와 소프트웨어를 설계하고 개발하는 학문입니다.',
              '경영학과는 기업 경영에 필요한 이론과 실무를 배우며, 마케팅, 재무, 인사 등 다양한 분야를 학습합니다.',
              '간호학과는 인체의 구조와 기능, 질병의 예방과 치료에 관한 지식을 바탕으로 전문 간호사를 양성합니다.'
            ]},
            { key: 'heroTags', label: '관련 학과 태그', type: 'tags', examples: [
              '컴퓨터공학, 소프트웨어공학, 정보통신공학',
              '경영학, 무역학, 회계학, 경제학',
              '간호학, 보건학, 의료정보학'
            ]},
            { key: 'categoryName', label: '계열', type: 'text', examples: ['공학계열', '상경계열', '의약계열'] }
          ]
        },
        {
          title: '개요 - 전공 개요',
          section: 'overview',
          fields: [
            { key: 'overview.summary', label: '전공 개요', type: 'textarea', examples: [
              '4차 산업혁명 핵심 기술을 학습하여 소프트웨어와 하드웨어를 아우르는 융합 인재를 양성합니다.',
              '경영 이론과 실무를 균형 있게 학습해 다양한 산업에서 요구되는 비즈니스 역량을 기릅니다.',
              '보건의료 지식을 바탕으로 환자 중심의 전문 간호 인력을 양성합니다.'
            ]}
          ]
        },
        {
          title: '개요 - 전공 특성',
          section: 'overview',
          fields: [
            { key: 'property', label: '전공 특성', type: 'textarea', examples: [
              '이론과 실습이 균형 있게 진행되며, 프로젝트 기반 학습이 활발합니다.',
              '현장 중심 교육으로 졸업 후 바로 실무에 투입될 수 있는 역량을 기릅니다.'
            ]}
          ]
        },
        {
          title: '개요 - 이 전공에 어울리는 사람',
          section: 'overview',
          fields: [
            { key: 'aptitude', label: '이 전공에 어울리는 사람', type: 'textarea', examples: [
              '논리적 사고력과 문제 해결 능력이 뛰어난 사람, 새로운 기술에 호기심이 강한 사람',
              '사람들과 소통하고 협력하는 것을 좋아하며, 리더십을 발휘하고 싶은 사람'
            ]}
          ]
        },
        {
          title: '개요 - 졸업 후 진출 분야',
          section: 'overview',
          fields: [
            { key: 'enterField', label: '졸업 후 진출 분야', type: 'pairList', examples: [
              '기업 및 산업체: 안경원, 콘택트렌즈 업체, 안경·광학 기기 유통, 렌즈/안경테 업체, 광통신·광정보 업체, 귀금속 도금 업체',
              '정부 및 공공기관: 과학기술정보통신부 등 공공기관',
              '연구기관: 시력보정/광학 관련 연구소'
            ]}
          ]
        },
        {
          title: '개요 - 여담',
          section: 'overview',
          fields: [
            { key: 'trivia', label: '여담 (한 줄씩)', type: 'list', examples: [
              '졸업 동문 멘토링을 통해 취업 정보를 실시간으로 공유합니다.',
              '산학협력 캡스톤 프로젝트가 매 학기 진행되어 현장 경험을 쌓을 수 있습니다.',
              '전공 동아리에서 업계 전문가 초청 세미나를 정기적으로 개최합니다.'
            ]}
          ]
        },
        {
          title: '상세정보 - 교육과정',
          section: 'details',
          fields: [
            { key: 'whatStudy', label: '배우는 내용', type: 'textarea', examples: [
              '프로그래밍 언어, 자료구조, 알고리즘, 데이터베이스, 네트워크, 운영체제',
              '경영학원론, 마케팅, 재무관리, 회계학, 조직행동론, 경영전략',
              '기초간호학, 성인간호학, 아동간호학, 정신간호학, 지역사회간호학'
            ]},
            { key: 'basicSubjects', label: '기초과목', type: 'tags', examples: [
              '일반선택과목: 영어 I · II, 영어 독해와 작문',
              '과학 과목: 화학 I, 생명과학 I',
              '교양과목: 심리학'
            ], hint: '기초 과목을 하나씩 입력하세요' },
            { key: 'advancedSubjects', label: '심화과목', type: 'tags', examples: [
              '광학기기종합설계 등 안경광학과 과목',
              '물리광학, 광학기기설계, 안경광학, 콘택트렌즈',
              '안기능검사/실습, 임상검안학/실습'
            ], hint: '심화 과목을 하나씩 입력하세요' },
            { key: 'mainSubject', label: '대학 주요 교과목 상세', type: 'pairList', examples: [
              '공동과목: 영어, 과학',
              '일반선택과목: 영어 I · II, 영어 독해와 작문',
              '전문과목: 광학기기설계, 안광학, 임상검안학 실습'
            ], hint: '과목명과 설명을 입력하세요' },
            { key: 'relateSubject', label: '고교 추천 교과목', type: 'pairList', examples: [
              '공통과목: 영어, 과학',
              '일반선택과목: 영어 I · II, 영어 독해와 작문 / 과학 과목: 화학 I, 생명과학 I / 교양과목: 심리학',
              '진로선택과목: 화학Ⅱ, 생명과학Ⅱ',
              '전문교과 I: 고급 화학, 화학 실험, 고급 생명과학, 생명과학 실험, 과학과제 연구',
              '전문교과 II: 인체 구조와 기능, 기초 간호 임상 실무, 보건 간호, 광학 재료'
            ], hint: '과목명과 설명을 입력하세요' }
          ]
        },
        {
          title: '상세정보 - 진로 탐색 활동',
          section: 'details',
          fields: [
            { key: 'careerAct', label: '진로 탐색 활동', type: 'pairList', examples: [
              '프로젝트 경험: 해커톤/캡스톤 디자인으로 실전 경험 쌓기',
              '현장 체험: 산업체 인턴십, 병원 실습, 기업 견학',
              '커뮤니티 활동: 학회/스터디/멘토링 참여로 네트워킹 확대'
            ]}
          ]
        },
        {
          title: '사이드바 - 연관 정보',
          section: 'details',
          fields: [
            { key: 'sidebarJobs', label: '관련 직업', type: 'autocomplete', domain: 'jobs', examples: [
              '소프트웨어 개발자, 데이터 분석가, 보안 전문가',
              '경영 컨설턴트, 마케터, 재무 분석가',
              '간호사, 보건교육사, 의료정보관리사'
            ]},
            { key: 'sidebarMajors', label: '관련 전공', type: 'autocomplete', domain: 'majors', examples: [
              '소프트웨어학과, 정보보안학과, 인공지능학과',
              '국제통상학과, 금융학과, 벤처경영학과',
              '물리치료학과, 임상병리학과, 의료공학과'
            ]},
            { key: 'sidebarHowtos', label: '관련 HowTo', type: 'autocomplete', domain: 'howtos', examples: [
              '백엔드 개발자 로드맵, 데이터 분석 포트폴리오 만들기, 보안 엔지니어 되기',
              '스타트업 마케팅 전략, 재무제표 읽기, 컨설팅 케이스 인터뷰 준비',
              '간호사 국가고시 준비, 병원 실습 가이드, 보건직 공무원 준비'
            ]}
          ]
        }
      ];
    }
  },
  
  /**
   * 필드 그룹 렌더링
   */
  renderFieldGroup(group) {
    const isJob = this.entityType === 'job';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    
    const fieldsHtml = group.fields.map(field => this.renderField(field)).join('');
    
    return `
      <div class="mb-8">
        <h3 class="text-xl font-bold text-white mb-5 flex items-center gap-3 pb-3 border-b border-${gradientFrom}/30">
          <span class="w-2 h-6 rounded-sm bg-gradient-to-b from-${gradientFrom} to-${gradientFrom}/50"></span>
          ${group.title}
        </h3>
        <div class="space-y-6 p-5 bg-wiki-card/30 border border-wiki-border/20 rounded-2xl">
          ${fieldsHtml}
        </div>
      </div>
    `;
  },
  
  /**
   * 개별 필드 렌더링
   */
  renderField(field) {
    const value = this.getNestedValue(this.editData, field.key) || '';
    const isJob = this.entityType === 'job';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    
    let inputHtml;
    
    if (field.type === 'list') {
      // 리스트 필드: 한 문장씩 추가/삭제
      let items = [];
      if (Array.isArray(value)) {
        items = value;
      } else if (typeof value === 'string' && value.trim()) {
        // • 또는 줄바꿈으로 분리
        items = value.split(/\n|•/).map(s => s.trim()).filter(Boolean);
      }
      
      // 빈 상태면 최소 하나의 입력 칸 표시
      if (items.length === 0) {
        items = [''];
      }
      
      const itemsHtml = items.map((item, idx) => `
        <div class="flex items-start gap-2 edit-list-item" data-index="${idx}">
          <span class="flex-shrink-0 w-6 h-6 flex items-center justify-center rounded-full bg-${gradientFrom}/20 text-${gradientFrom} text-xs font-bold mt-2">${idx + 1}</span>
          <input
            type="text"
            value="${this.escapeHtml(item)}"
            placeholder="내용을 입력하세요"
            class="flex-1 px-4 py-2 bg-wiki-bg/70 border border-wiki-border/60 rounded-lg text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 transition"
          >
          <button type="button" class="flex-shrink-0 w-8 h-8 mt-1 flex items-center justify-center text-wiki-muted hover:text-red-400 hover:bg-red-400/10 rounded-lg transition remove-list-item-btn">
            <i class="fas fa-trash-alt text-sm"></i>
          </button>
        </div>
      `).join('');
      
      inputHtml = `
        <div id="list-container-${field.key}" data-field-key="${field.key}" data-field-type="list" class="space-y-2">
          ${itemsHtml}
        </div>
        <button
          type="button"
          data-add-list-item="${field.key}"
          class="mt-3 px-4 py-2 text-sm font-medium text-${gradientFrom} bg-${gradientFrom}/10 hover:bg-${gradientFrom}/20 rounded-lg transition flex items-center gap-2"
        >
          <i class="fas fa-plus"></i>
          항목 추가
        </button>
      `;
    } else if (field.type === 'pairList') {
      // 제목+설명 쌍 리스트
      let items = [];
      if (Array.isArray(value)) {
        items = value.map(v => ({ title: v.title || v.name || '', description: v.description || v.desc || v.text || '' }));
      } else if (typeof value === 'string' && value.trim()) {
        items = [{ title: value.trim(), description: '' }];
      }
      if (items.length === 0) items = [{ title: '', description: '' }];
      
      const itemsHtml = items.map((item, idx) => `
        <div class="space-y-2 edit-list-item" data-index="${idx}">
          <div class="flex items-start gap-2">
            <span class="flex-shrink-0 w-6 h-6 flex items-center justify-center rounded-full bg-${gradientFrom}/20 text-${gradientFrom} text-xs font-bold mt-2">${idx + 1}</span>
            <input
              type="text"
              value="${this.escapeHtml(item.title || '')}"
              placeholder="제목을 입력하세요"
              class="flex-1 px-4 py-2 bg-wiki-bg/70 border border-wiki-border/60 rounded-lg text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 transition"
            >
            <button type="button" class="flex-shrink-0 w-8 h-8 mt-1 flex items-center justify-center text-wiki-muted hover:text-red-400 hover:bg-red-400/10 rounded-lg transition remove-list-item-btn">
              <i class="fas fa-trash-alt text-sm"></i>
            </button>
          </div>
          <textarea
            rows="3"
            placeholder="설명을 입력하세요"
            class="w-full px-4 py-2 bg-wiki-bg/70 border border-wiki-border/60 rounded-lg text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition resize-y"
          >${this.escapeHtml(item.description || '')}</textarea>
        </div>
      `).join('');
      
      inputHtml = `
        <div id="pairlist-container-${field.key}" data-field-key="${field.key}" data-field-type="pairList" class="space-y-3">
          ${itemsHtml}
        </div>
        <button
          type="button"
          data-add-pair-item="${field.key}"
          class="mt-3 px-4 py-2 text-sm font-medium text-${gradientFrom} bg-${gradientFrom}/10 hover:bg-${gradientFrom}/20 rounded-lg transition flex items-center gap-2"
        >
          <i class="fas fa-plus"></i>
          항목 추가
        </button>
      `;
    } else if (field.type === 'autocomplete') {
      // 자동완성 필드: 기존 직업/학과에서 검색하여 선택
      const items = Array.isArray(value) ? value : [];
      const itemsHtml = items.map(item => {
        const name = typeof item === 'string' ? item : (item?.name || '');
        const slug = typeof item === 'string' ? item : (item?.slug || item?.name || '');
        if (!name) return '';
        return `
          <span class="inline-flex items-center gap-1 px-3 py-1.5 bg-${gradientFrom}/10 border border-${gradientFrom}/30 text-${gradientFrom} rounded-lg text-sm edit-autocomplete-chip" 
                data-name="${this.escapeHtml(name)}" data-slug="${this.escapeHtml(slug)}">
            <i class="fas ${field.domain === 'jobs' ? 'fa-briefcase' : 'fa-graduation-cap'} text-xs opacity-70"></i>
            ${this.escapeHtml(name)}
            <button type="button" class="hover:text-red-400 ml-1 remove-autocomplete-btn"><i class="fas fa-times text-xs"></i></button>
          </span>
        `;
      }).filter(Boolean).join('');
      
      const placeholder = field.domain === 'jobs' ? '직업 검색...' : '학과 검색...';
      inputHtml = `
        <div class="relative" data-autocomplete-wrap="${field.key}">
          <input
            type="text"
            id="field-${field.key}"
            data-field-key="${field.key}"
            data-field-type="autocomplete"
            data-domain="${field.domain}"
            autocomplete="off"
            placeholder="${placeholder}"
            class="w-full px-4 py-3 bg-wiki-bg/70 border border-wiki-border/60 rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition"
          >
          <div id="dropdown-${field.key}" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto"></div>
        </div>
        <div id="autocomplete-container-${field.key}" class="flex flex-wrap gap-2 mt-3">${itemsHtml}</div>
      `;
    } else if (field.type === 'tags') {
      // 태그 필드: 칩 형태로 표시
      const tags = Array.isArray(value) ? value : (typeof value === 'string' && value ? value.split(',').map(t => t.trim()).filter(Boolean) : []);
      const tagsHtml = tags.map(tag => `
        <span class="inline-flex items-center gap-1 px-3 py-1.5 bg-${gradientFrom}/10 text-${gradientFrom} rounded-full text-sm edit-tag-chip" data-tag="${this.escapeHtml(tag)}">
          ${this.escapeHtml(tag)}
          <button type="button" class="hover:text-red-400 ml-1 remove-tag-btn"><i class="fas fa-times text-xs"></i></button>
        </span>
      `).join('');
      
      const placeholder = field.hint || field.placeholder || '태그 입력 후 Enter 또는 쉼표(,)';
      inputHtml = `
        <input
          type="text"
          id="field-${field.key}"
          data-field-key="${field.key}"
          data-field-type="tags"
          placeholder="${this.escapeHtml(placeholder)}"
          class="w-full px-4 py-3 bg-wiki-bg/70 border border-wiki-border/60 rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition"
        >
        <div id="tags-container-${field.key}" class="flex flex-wrap gap-2 mt-3">${tagsHtml}</div>
      `;
    } else if (field.type === 'textarea') {
      const displayValue = Array.isArray(value) ? value.join(', ') : value;
      inputHtml = `
        <textarea
          id="field-${field.key}"
          data-field-key="${field.key}"
          rows="4"
          placeholder="${field.label}을(를) 입력하세요"
          class="w-full px-4 py-3 bg-wiki-bg/70 border border-wiki-border/60 rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition resize-y"
        >${this.escapeHtml(displayValue)}</textarea>
      `;
    } else {
      const displayValue = Array.isArray(value) ? value.join(', ') : value;
      
      // heroCategory가 breadcrumb 형식이면 읽기 전용으로 표시
      const isBreadcrumb = field.key === 'heroCategory' && this.editData.isCategoryBreadcrumb;
      
      if (isBreadcrumb) {
        inputHtml = `
          <div 
            class="w-full px-4 py-3 bg-wiki-bg/30 border border-wiki-border/40 rounded-xl text-wiki-muted cursor-not-allowed"
            title="API 데이터로 설정된 분류는 수정할 수 없습니다"
          >
            <span class="flex items-center gap-2">
              <i class="fas fa-lock text-xs"></i>
              ${this.escapeHtml(displayValue)}
              <span class="text-xs text-wiki-muted/60 ml-auto">(수정 불가)</span>
            </span>
          </div>
        `;
      } else {
        inputHtml = `
          <input
            type="text"
            id="field-${field.key}"
            data-field-key="${field.key}"
            value="${this.escapeHtml(displayValue)}"
            placeholder="${field.label}을(를) 입력하세요"
            class="w-full px-4 py-3 bg-wiki-bg/70 border border-wiki-border/60 rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition"
          >
        `;
      }
    }
    
    // 히어로 섹션 및 사이드바 필드는 출처 추가 불가
    const noSourceFields = [
      'name', 'summary', 'heroSummary', 'heroCategory', 'heroTags', 'categoryName',  // 히어로 필드
      'sidebarJobs', 'sidebarMajors', 'sidebarHowtos', 'sidebarCerts'  // 사이드바 필드
    ];
    const isNoSourceField = noSourceFields.includes(field.key);
    
    // 기존 출처 표시 + 새 출처 입력 필드 (리스트 형태) - 히어로/사이드바 필드 제외
    let sourceHtml = '';
    if (!isNoSourceField) {
      const existingSource = this.editData?._sources?.[field.key];
      const existingSourceTexts = Array.isArray(existingSource)
        ? existingSource.map(s => s?.text || s?.url || '').filter(Boolean)
        : (existingSource ? [existingSource.text || existingSource.url || ''] : []);
      
      // 기존 출처가 있으면 표시, 없으면 빈 input 하나 미리 추가
      const sourceItems = existingSourceTexts.length > 0 
        ? existingSourceTexts 
        : [''];  // 빈 input 하나 미리 추가
      
      const sourceItemsHtml = sourceItems.map((text, idx) => `
        <div class="flex items-center gap-2 edit-source-item" data-source-index="${idx}">
          <i class="fas fa-bookmark text-xs text-${gradientFrom}/60"></i>
          <input
            type="text"
            value="${this.escapeHtml(text)}"
            placeholder="출처를 입력하세요"
            class="flex-1 px-3 py-1.5 text-sm bg-wiki-bg/50 border border-wiki-border/40 rounded-lg text-white placeholder-wiki-muted focus:outline-none focus:ring-1 focus:ring-${gradientFrom}/30 transition"
          >
          <button type="button" class="text-wiki-muted hover:text-red-400 transition remove-source-btn">
            <i class="fas fa-times text-xs"></i>
          </button>
        </div>
      `).join('');
      
      sourceHtml = `
        <div class="mt-2" data-source-container="${field.key}">
          <button
            type="button"
            data-source-toggle="${field.key}"
            class="text-xs text-wiki-muted hover:text-${gradientFrom} transition flex items-center gap-1"
          >
            <i class="fas fa-link"></i>
            출처 ${existingSourceTexts.length > 0 ? `(${existingSourceTexts.length})` : '추가'}
          </button>
          <div id="source-${field.key}" class="${existingSourceTexts.length > 0 ? '' : 'hidden '}mt-2 space-y-2" data-source-list="${field.key}">
            ${sourceItemsHtml}
            <button
              type="button"
              data-add-source="${field.key}"
              class="text-xs text-${gradientFrom} hover:text-${gradientFrom}/80 transition flex items-center gap-1 py-1"
            >
              <i class="fas fa-plus"></i>
              출처 추가
            </button>
          </div>
        </div>
      `;
    }
    
    // 예시 영역 (배열 또는 단일 문자열 지원)
    const examples = field.examples || (field.example ? [field.example] : []);
    const exampleHtml = examples.length > 0 ? `
      <div class="mt-2">
        <button
          type="button"
          data-example-toggle="${field.key}"
          class="text-xs text-wiki-muted hover:text-${gradientFrom} transition flex items-center gap-1.5 py-1"
        >
          <i class="fas fa-lightbulb text-yellow-500/70"></i>
          <span>예시 ${examples.length}개 보기</span>
          <i class="fas fa-chevron-down text-[10px] transition-transform" data-example-icon="${field.key}"></i>
        </button>
        <div id="example-${field.key}" class="hidden mt-3 space-y-2">
          ${examples.map((ex, idx) => `
            <div class="p-3 bg-${gradientFrom}/5 border border-${gradientFrom}/20 rounded-lg">
              <div class="flex items-start gap-2">
                <span class="flex-shrink-0 w-5 h-5 flex items-center justify-center rounded-full bg-${gradientFrom}/20 text-${gradientFrom} text-[10px] font-bold">${idx + 1}</span>
                <p class="text-xs text-wiki-muted leading-relaxed whitespace-pre-line flex-1">${this.escapeHtml(ex)}</p>
              </div>
            </div>
          `).join('')}
        </div>
      </div>
    ` : '';

    return `
      <div class="space-y-3 pb-5 border-b border-wiki-border/10 last:border-b-0 last:pb-0">
        <label class="flex items-center gap-2 text-base font-semibold text-white/95">
          <span class="w-1 h-4 rounded-full bg-${gradientFrom}/40"></span>
          ${field.label}
        </label>
        ${inputHtml}
        ${exampleHtml}
        ${sourceHtml}
      </div>
    `;
  },
  
  /**
   * 객체에서 값 가져오기 (flat 키 우선, 없으면 nested 경로로 탐색)
   */
  getNestedValue(obj, path) {
    // 먼저 flat 키로 시도 (예: 'overview.summary' 문자열 키)
    if (obj && path in obj) {
      return obj[path];
    }
    // flat 키가 없으면 nested 경로로 탐색 (예: obj.overview.summary)
    return path.split('.').reduce((current, key) => current?.[key], obj);
  },
  
  /**
   * 편집 모드 이벤트 바인딩
   */
  bindEditModeEvents() {
    // 취소 버튼
    document.getElementById('edit-cancel-btn')?.addEventListener('click', () => {
      this.exitEditMode();
    });
    
    // 저장 버튼
    document.getElementById('edit-save-btn')?.addEventListener('click', () => {
      this.handleSave();
    });
    
    // 숨기기 버튼 (관리자 전용)
    document.getElementById('edit-hide-btn')?.addEventListener('click', () => {
      this.handleHide();
    });
    
    // 삭제 버튼 (관리자 전용)
    document.getElementById('edit-delete-btn')?.addEventListener('click', () => {
      this.handleDelete();
    });
    
    // 예시 토글
    document.querySelectorAll('[data-example-toggle]').forEach(btn => {
      btn.addEventListener('click', () => {
        const key = btn.getAttribute('data-example-toggle');
        const exampleDiv = document.getElementById(`example-${key}`);
        const icon = document.querySelector(`[data-example-icon="${key}"]`);
        exampleDiv?.classList.toggle('hidden');
        icon?.classList.toggle('rotate-180');
      });
    });
    
    // 출처 토글
    document.querySelectorAll('[data-source-toggle]').forEach(btn => {
      btn.addEventListener('click', () => {
        const key = btn.getAttribute('data-source-toggle');
        const sourceDiv = document.getElementById(`source-${key}`);
        sourceDiv?.classList.toggle('hidden');
      });
    });
    
    // 출처 추가 이벤트
    document.querySelectorAll('[data-add-source]').forEach(btn => {
      btn.addEventListener('click', () => {
        const key = btn.getAttribute('data-add-source');
        const sourceList = document.querySelector(`[data-source-list="${key}"]`);
        if (sourceList) {
          this.addSourceItem(sourceList, key, '');
        }
      });
    });
    
    // 출처 삭제 이벤트 (이벤트 위임)
    document.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.remove-source-btn');
      if (removeBtn) {
        const sourceItem = removeBtn.closest('.edit-source-item');
        if (sourceItem) {
          sourceItem.remove();
        }
      }
    });
    
    // 태그 입력 이벤트
    document.querySelectorAll('[data-field-type="tags"]').forEach(input => {
      const key = input.getAttribute('data-field-key');
      const container = document.getElementById(`tags-container-${key}`);
      
      input.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ',') {
          e.preventDefault();
          const tag = input.value.replace(/,/g, '').trim();
          if (tag && container) {
            // 중복 체크
            const existing = container.querySelector(`[data-tag="${tag}"]`);
            if (!existing) {
              this.addEditTagChip(container, tag, key);
            }
            input.value = '';
          }
        }
      });
    });
    
    // 리스트 항목 추가 이벤트
    document.querySelectorAll('[data-add-list-item]').forEach(btn => {
      btn.addEventListener('click', () => {
        const key = btn.getAttribute('data-add-list-item');
        const container = document.getElementById(`list-container-${key}`);
        if (container) {
          this.addListItem(container, key, '');
        }
      });
    });
    // 제목+설명 쌍 리스트 항목 추가 이벤트
    document.querySelectorAll('[data-add-pair-item]').forEach(btn => {
      btn.addEventListener('click', () => {
        const key = btn.getAttribute('data-add-pair-item');
        const container = document.getElementById(`pairlist-container-${key}`);
        if (container) {
          this.addPairItem(container, key, '', '');
        }
      });
    });
    
    // 리스트 항목 삭제 이벤트 (이벤트 위임)
    document.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.remove-list-item-btn');
      if (removeBtn) {
        const item = removeBtn.closest('.edit-list-item');
        if (item) {
          item.remove();
          // 인덱스 재정렬
          const container = item.closest('[data-field-type="list"], [data-field-type="pairList"]');
          if (container) {
            this.reindexListItems(container);
          }
        }
      }
    });
    
    // 태그 삭제 이벤트 (이벤트 위임)
    document.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.remove-tag-btn');
      if (removeBtn) {
        const chip = removeBtn.closest('.edit-tag-chip');
        if (chip) {
          chip.remove();
        }
      }
    });
    
    // 자동완성 필드 초기화
    this.initAutocompleteFields();
    
    // 자동완성 칩 삭제 이벤트 (이벤트 위임)
    document.addEventListener('click', (e) => {
      const removeBtn = e.target.closest('.remove-autocomplete-btn');
      if (removeBtn) {
        const chip = removeBtn.closest('.edit-autocomplete-chip');
        if (chip) {
          chip.remove();
        }
      }
    });
    
    // ESC로 취소
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && this.isEditMode) {
        this.exitEditMode();
      }
    });
  },
  
  /**
   * 자동완성 필드 초기화
   */
  initAutocompleteFields() {
    const self = this;
    const isJob = this.entityType === 'job';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    
    document.querySelectorAll('[data-field-type="autocomplete"]').forEach(input => {
      const key = input.getAttribute('data-field-key');
      const domain = input.getAttribute('data-domain');
      const dropdown = document.getElementById(`dropdown-${key}`);
      const container = document.getElementById(`autocomplete-container-${key}`);
      const wrap = input.closest('[data-autocomplete-wrap]');
      
      if (!dropdown || !container) return;
      
      let debounceTimer = null;
      let abortController = null;
      let lastSearchValue = '';
      
      // 검색 실행 함수
      const doSearch = async (q) => {
        if (q.length < 2) {
          dropdown.classList.add('hidden');
          dropdown.innerHTML = '';
          return;
        }
        
        if (q === lastSearchValue) return;
        lastSearchValue = q;
        
        try {
          if (abortController) abortController.abort();
          abortController = new AbortController();
          
          const res = await fetch(`/api/search?domain=${domain}&q=${encodeURIComponent(q)}&limit=10`, {
            signal: abortController.signal
          });
          const data = await res.json();
          
          if (data.success && data.results && data.results.length > 0) {
            const icon = domain === 'jobs' ? 'fa-briefcase' : 'fa-graduation-cap';
            dropdown.innerHTML = data.results.map(r => `
              <div class="autocomplete-item px-3 py-2 hover:bg-${gradientFrom}/10 cursor-pointer transition flex items-center gap-2" 
                   data-name="${self.escapeHtml(r.name || r.title)}" 
                   data-slug="${self.escapeHtml(r.slug || r.name)}">
                <i class="fas ${icon} text-${gradientFrom} text-xs"></i>
                <span class="text-white">${self.escapeHtml(r.name || r.title)}</span>
              </div>
            `).join('');
            dropdown.classList.remove('hidden');
          } else {
            dropdown.innerHTML = `<div class="px-3 py-2 text-wiki-muted text-sm">검색 결과가 없습니다</div>`;
            dropdown.classList.remove('hidden');
          }
        } catch (err) {
          if (err?.name !== 'AbortError') {
          }
        }
      };
      
      // 입력 이벤트
      input.addEventListener('input', () => {
        clearTimeout(debounceTimer);
        const q = input.value.trim();
        debounceTimer = setTimeout(() => doSearch(q), 300);
      });
      
      // 드롭다운 아이템 클릭
      dropdown.addEventListener('pointerdown', (e) => {
        const el = e.target.closest('.autocomplete-item');
        if (!el) return;
        e.preventDefault();
        e.stopPropagation();
        
        const item = { name: el.dataset.name, slug: el.dataset.slug };
        
        // 중복 체크
        const existing = container.querySelector(`[data-name="${item.name}"]`);
        if (!existing) {
          self.addAutocompleteChip(container, item, domain);
        }
        
        input.value = '';
        dropdown.innerHTML = '';
        dropdown.classList.add('hidden');
        input.focus();
      });
      
      // 포커스 아웃 시 드롭다운 숨김
      const handleFocusOut = (evt) => {
        const next = evt.relatedTarget;
        const isInside = wrap ? wrap.contains(next) : (input === next || dropdown.contains(next));
        if (!isInside) {
          setTimeout(() => dropdown.classList.add('hidden'), 150);
        }
      };
      (wrap || input).addEventListener('focusout', handleFocusOut);
    });
  },
  
  /**
   * 자동완성 칩 추가
   */
  addAutocompleteChip(container, item, domain) {
    const isJob = this.entityType === 'job';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    const icon = domain === 'jobs' ? 'fa-briefcase' : 'fa-graduation-cap';
    
    const chip = document.createElement('span');
    chip.className = `inline-flex items-center gap-1 px-3 py-1.5 bg-${gradientFrom}/10 border border-${gradientFrom}/30 text-${gradientFrom} rounded-lg text-sm edit-autocomplete-chip`;
    chip.dataset.name = item.name;
    chip.dataset.slug = item.slug || item.name;
    chip.innerHTML = `
      <i class="fas ${icon} text-xs opacity-70"></i>
      ${this.escapeHtml(item.name)}
      <button type="button" class="hover:text-red-400 ml-1 remove-autocomplete-btn"><i class="fas fa-times text-xs"></i></button>
    `;
    
    container.appendChild(chip);
  },
  
  /**
   * 편집 모드에서 태그 칩 추가
   */
  addEditTagChip(container, tag, fieldKey) {
    const isJob = this.entityType === 'job';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    
    const chip = document.createElement('span');
    chip.className = `inline-flex items-center gap-1 px-3 py-1.5 bg-${gradientFrom}/10 text-${gradientFrom} rounded-full text-sm edit-tag-chip`;
    chip.dataset.tag = tag;
    chip.innerHTML = `${this.escapeHtml(tag)}<button type="button" class="hover:text-red-400 ml-1 remove-tag-btn"><i class="fas fa-times text-xs"></i></button>`;
    
    container.appendChild(chip);
  },
  
  /**
   * 출처 항목 추가
   */
  addSourceItem(sourceList, fieldKey, value = '') {
    const isJob = this.entityType === 'job';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    const idx = sourceList.querySelectorAll('.edit-source-item').length;
    
    const item = document.createElement('div');
    item.className = 'flex items-center gap-2 edit-source-item';
    item.dataset.sourceIndex = idx;
    item.innerHTML = `
      <i class="fas fa-bookmark text-xs text-${gradientFrom}/60"></i>
      <input
        type="text"
        value="${this.escapeHtml(value)}"
        placeholder="출처를 입력하세요"
        class="flex-1 px-3 py-1.5 text-sm bg-wiki-bg/50 border border-wiki-border/40 rounded-lg text-white placeholder-wiki-muted focus:outline-none focus:ring-1 focus:ring-${gradientFrom}/30 transition"
      >
      <button type="button" class="text-wiki-muted hover:text-red-400 transition remove-source-btn">
        <i class="fas fa-times text-xs"></i>
      </button>
    `;
    
    // "출처 추가" 버튼 앞에 삽입
    const addBtn = sourceList.querySelector('[data-add-source]');
    if (addBtn) {
      sourceList.insertBefore(item, addBtn);
    } else {
      sourceList.appendChild(item);
    }
    
    // 새로 추가된 input에 포커스
    item.querySelector('input')?.focus();
  },

  /**
   * 리스트 항목 추가
   */
  addListItem(container, fieldKey, value = '') {
    const isJob = this.entityType === 'job';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    const idx = container.querySelectorAll('.edit-list-item').length;
    
    const item = document.createElement('div');
    item.className = 'flex items-start gap-2 edit-list-item';
    item.dataset.index = idx;
    item.innerHTML = `
      <span class="flex-shrink-0 w-6 h-6 flex items-center justify-center rounded-full bg-${gradientFrom}/20 text-${gradientFrom} text-xs font-bold mt-2">${idx + 1}</span>
      <input
        type="text"
        value="${this.escapeHtml(value)}"
        placeholder="내용을 입력하세요"
        class="flex-1 px-4 py-2 bg-wiki-bg/70 border border-wiki-border/60 rounded-lg text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 transition"
      >
      <button type="button" class="flex-shrink-0 w-8 h-8 mt-1 flex items-center justify-center text-wiki-muted hover:text-red-400 hover:bg-red-400/10 rounded-lg transition remove-list-item-btn">
        <i class="fas fa-trash-alt text-sm"></i>
      </button>
    `;
    
    container.appendChild(item);
    // 새로 추가된 input에 포커스
    item.querySelector('input')?.focus();
  },

  /**
   * 제목+설명 쌍 리스트 항목 추가
   */
  addPairItem(container, fieldKey, title = '', description = '') {
    const isJob = this.entityType === 'job';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    const idx = container.querySelectorAll('.edit-list-item').length;
    
    const item = document.createElement('div');
    item.className = 'space-y-2 edit-list-item';
    item.dataset.index = idx;
    item.innerHTML = `
      <div class="flex items-start gap-2">
        <span class="flex-shrink-0 w-6 h-6 flex items-center justify-center rounded-full bg-${gradientFrom}/20 text-${gradientFrom} text-xs font-bold mt-2">${idx + 1}</span>
        <input
          type="text"
          value="${this.escapeHtml(title)}"
          placeholder="제목을 입력하세요"
          class="flex-1 px-4 py-2 bg-wiki-bg/70 border border-wiki-border/60 rounded-lg text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 transition"
        >
        <button type="button" class="flex-shrink-0 w-8 h-8 mt-1 flex items-center justify-center text-wiki-muted hover:text-red-400 hover:bg-red-400/10 rounded-lg transition remove-list-item-btn">
          <i class="fas fa-trash-alt text-sm"></i>
        </button>
      </div>
      <textarea
        rows="3"
        placeholder="설명을 입력하세요"
        class="w-full px-4 py-2 bg-wiki-bg/70 border border-wiki-border/60 rounded-lg text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-${gradientFrom}/50 focus:border-transparent transition resize-y"
      >${this.escapeHtml(description)}</textarea>
    `;
    
    container.appendChild(item);
    item.querySelector('input')?.focus();
  },
  
  /**
   * 리스트 항목 인덱스 재정렬
   */
  reindexListItems(container) {
    container.querySelectorAll('.edit-list-item').forEach((item, idx) => {
      item.dataset.index = idx;
      const badge = item.querySelector('span');
      if (badge) {
        badge.textContent = idx + 1;
      }
    });
  },
  
  /**
   * 숨기기 처리 (관리자 전용) - Soft Delete
   */
  async handleHide() {
    const isJob = this.entityType === 'job';
    const entityName = isJob ? '직업' : '전공';
    const title = this.editData?.name || this.editData?.heroTitle || '항목';
    
    // 확인 대화상자
    const confirmMessage = `"${title}" ${entityName}을(를) 숨기시겠습니까?\n\n• 일반 유저에게 안보이게 됩니다\n• 검색에서 제외됩니다\n• 관리자만 볼 수 있습니다\n• 나중에 다시 복원할 수 있습니다`;
    if (!confirm(confirmMessage)) {
      return;
    }
    
    const hideBtn = document.getElementById('edit-hide-btn');
    if (hideBtn) {
      hideBtn.disabled = true;
      hideBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-1.5"></i>숨기는 중...';
    }
    
    try {
      const endpoint = isJob 
        ? `/api/job/${this.entityId}`
        : `/api/major/${this.entityId}`;
      
      const response = await fetch(endpoint, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json'
        }
      });
      
      const result = await response.json();
      
      if (result.success) {
        alert(result.message || `${entityName}이(가) 숨겨졌습니다.`);
        // 목록 페이지로 이동
        window.location.href = isJob ? '/job' : '/major';
      } else {
        const errorMsg = result.error === 'ADMIN_ONLY' 
          ? '관리자만 숨길 수 있습니다.'
          : result.error === 'JOB_NOT_FOUND' || result.error === 'MAJOR_NOT_FOUND'
          ? `해당 ${entityName}을(를) 찾을 수 없습니다.`
          : result.error || '숨기기에 실패했습니다.';
        alert(`숨기기 실패: ${errorMsg}`);
      }
    } catch (error) {
      alert('숨기기 중 오류가 발생했습니다.');
    } finally {
      if (hideBtn) {
        hideBtn.disabled = false;
        hideBtn.innerHTML = '<i class="fas fa-eye-slash mr-1.5"></i>숨기기';
      }
    }
  },
  
  /**
   * 완전 삭제 처리 (관리자 전용) - Hard Delete, 복구 불가
   */
  async handleDelete() {
    const isJob = this.entityType === 'job';
    const entityName = isJob ? '직업' : '전공';
    const title = this.editData?.name || this.editData?.heroTitle || '항목';
    
    // 경고 대화상자
    const warningMessage = `⚠️ 경고: 완전 삭제\n\n"${title}" ${entityName}을(를) 완전히 삭제하시겠습니까?\n\n• 모든 데이터가 DB에서 삭제됩니다\n• 수정 기록(역사)도 모두 삭제됩니다\n• 이 작업은 복구할 수 없습니다!`;
    if (!confirm(warningMessage)) {
      return;
    }
    
    // 최종 확인 - 이름 입력
    const finalConfirm = prompt(`완전 삭제를 확인하려면 "${title}"을(를) 정확히 입력하세요:`);
    if (finalConfirm !== title) {
      alert('입력이 일치하지 않습니다. 삭제가 취소되었습니다.');
      return;
    }
    
    // 마지막 확인
    if (!confirm('정말로 완전히 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다!')) {
      return;
    }
    
    const deleteBtn = document.getElementById('edit-delete-btn');
    if (deleteBtn) {
      deleteBtn.disabled = true;
      deleteBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-1.5"></i>삭제 중...';
    }
    
    try {
      const endpoint = isJob 
        ? `/api/job/${this.entityId}?permanent=true`
        : `/api/major/${this.entityId}?permanent=true`;
      
      const response = await fetch(endpoint, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json'
        }
      });
      
      const result = await response.json();
      
      if (result.success) {
        alert(result.message || `${entityName}이(가) 완전히 삭제되었습니다.`);
        // 목록 페이지로 이동
        window.location.href = isJob ? '/job' : '/major';
      } else {
        const errorMsg = result.error === 'ADMIN_ONLY' 
          ? '관리자만 삭제할 수 있습니다.'
          : result.error === 'JOB_NOT_FOUND' || result.error === 'MAJOR_NOT_FOUND'
          ? `해당 ${entityName}을(를) 찾을 수 없습니다.`
          : result.error || '삭제에 실패했습니다.';
        alert(`삭제 실패: ${errorMsg}`);
      }
    } catch (error) {
      alert('삭제 중 오류가 발생했습니다.');
    } finally {
      if (deleteBtn) {
        deleteBtn.disabled = false;
        deleteBtn.innerHTML = '<i class="fas fa-trash-alt mr-1.5"></i>삭제';
      }
    }
  },
  
  /**
   * 저장 처리
   */
  async handleSave() {
    const saveBtn = document.getElementById('edit-save-btn');
    
    // 변경된 필드 수집
    const changedFields = {};
    const sources = {};
    
    document.querySelectorAll('[data-field-key]').forEach(element => {
      const key = element.getAttribute('data-field-key');
      const fieldType = element.getAttribute('data-field-type');
      const originalValue = this.getNestedValue(this.editData, key);
      let newValue;
      
      // 리스트 타입 필드 (수행 직무 등) - 배열로 저장
      if (fieldType === 'list') {
        // data-index 순서대로 정렬하여 순서 보장
        const listItems = Array.from(element.querySelectorAll('.edit-list-item'));
        listItems.sort((a, b) => parseInt(a.dataset.index || '0') - parseInt(b.dataset.index || '0'));
        const items = listItems
          .map(item => (item.querySelector('input')?.value || '').trim())
          .filter(v => v.length > 0);
        newValue = items; // 배열로 저장 (템플릿에서 Array.isArray 체크)
      }
      // 제목+설명 쌍 리스트
      else if (fieldType === 'pairList') {
        const listItems = Array.from(element.querySelectorAll('.edit-list-item'));
        listItems.sort((a, b) => parseInt(a.dataset.index || '0') - parseInt(b.dataset.index || '0'));
        const items = listItems
          .map(item => {
            const title = (item.querySelector('input')?.value || '').trim();
            const desc = (item.querySelector('textarea')?.value || '').trim();
            if (!title && !desc) return null;
            return { title, description: desc };
          })
          .filter(Boolean);
        newValue = items;
      }
      // 자동완성 타입 필드 (관련 직업, 관련 학과)
      else if (fieldType === 'autocomplete') {
        const container = document.getElementById(`autocomplete-container-${key}`);
        if (container) {
          const items = Array.from(container.querySelectorAll('.edit-autocomplete-chip')).map(chip => ({
            name: chip.dataset.name,
            slug: chip.dataset.slug
          }));
          newValue = items;
        } else {
          newValue = [];
        }
      }
      // 태그 타입 필드
      else if (fieldType === 'tags') {
        const container = document.getElementById(`tags-container-${key}`);
        if (container) {
          const tags = Array.from(container.querySelectorAll('.edit-tag-chip')).map(chip => chip.dataset.tag);
          newValue = [...new Set(tags.filter(t => t))]; // 중복 제거
        } else {
          newValue = [];
        }
      } else if (element.placeholder?.includes('쉼표로 구분') || key.includes('Majors') || key.includes('Subjects')) {
        // 기타 배열 필드
        newValue = element.value.trim().split(',').map(t => t.trim()).filter(t => t.length > 0);
        newValue = [...new Set(newValue)]; // 중복 제거
      } else {
        newValue = element.value?.trim() || '';
      }
      
      // 변경 여부 확인 (배열/객체는 JSON 문자열로 비교)
      const normalizeValue = (val) => {
        if (Array.isArray(val)) return JSON.stringify(val);
        if (val && typeof val === 'object') return JSON.stringify(val);
        return val || '';
      };
      const originalStr = normalizeValue(originalValue);
      const newStr = normalizeValue(newValue);
      
      if (originalStr !== newStr) {
        changedFields[key] = newValue;
      }
      
      // 출처 확인 (추가/수정/삭제) - 리스트 형태로 수집
      const sourceList = document.querySelector(`[data-source-list="${key}"]`);
      if (sourceList) {
        const sourceItems = Array.from(sourceList.querySelectorAll('.edit-source-item input'));
        const sourceTexts = sourceItems.map(input => input.value?.trim()).filter(Boolean);
        
        // 기존에 출처가 있었는지 확인
        const hadSources = this.editData?._sources?.[key];
        
        if (sourceTexts.length > 0) {
          sources[key] = sourceTexts.map((text) => ({ text }));
        } else if (hadSources) {
          // 기존 출처가 있었는데 다 삭제된 경우
          sources[key] = { delete: true };
        }
      }
    });
    
    // 변경 없으면 종료
    if (Object.keys(changedFields).length === 0 && Object.keys(sources).length === 0) {
      alert('변경된 내용이 없습니다.');
      return;
    }
    
    
    // 로딩 상태
    saveBtn.disabled = true;
    saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>저장 중...';
    
    try {
      const payload = {
        fields: changedFields,
        sources: Object.keys(sources).length > 0 ? sources : undefined
      };
      
      
      const endpoint = `/api/${this.entityType}/${encodeURIComponent(this.entityId)}/edit`;
      const response = await fetch(endpoint, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      
      const result = await response.json();
      
      if (!response.ok || !result.success) {
        throw new Error(result.error || '저장에 실패했습니다.');
      }
      
      // 성공 - 페이지 새로고침 (편집 모드 종료, 캐시 무효화)
      window.location.href = window.location.pathname + '?_t=' + Date.now();
      
    } catch (error) {
      alert('저장 중 오류가 발생했습니다: ' + error.message);
      
      saveBtn.disabled = false;
      saveBtn.innerHTML = '<i class="fas fa-save mr-2"></i>저장';
    }
  },
  
  /**
   * 편집 모드 종료
   */
  exitEditMode() {
    if (this.isEditMode) {
      // 변경 확인
      const hasChanges = document.querySelectorAll('[data-field-key]').length > 0;
      if (hasChanges) {
        if (!confirm('변경 사항을 저장하지 않고 나가시겠습니까?')) {
          return;
        }
      }
    }
    
    // URL에서 edit 파라미터 제거 (캐시 무효화)
    window.location.href = window.location.pathname + '?_t=' + Date.now();
  },
  
  /**
   * 관리자 여부 확인
   */
  isAdmin() {
    const user = window.__USER__;
    if (!user) return false;
    return user.role === 'super-admin' || user.role === 'operator' || user.role === 'admin';
  },
  
  /**
   * HTML 이스케이프
   */
  escapeHtml(str) {
    if (!str) return '';
    return String(str)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }
};

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', () => {
  EditMode.init();
});

