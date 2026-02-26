/**
 * CareerWiki API Client
 * 프론트엔드에서 API 호출을 위한 클라이언트
 */

// API Base URL (현재 도메인 사용)
const API_BASE = window.location.origin + '/api';
const TELEMETRY_VERSION = 'phase1-task3';

// Phase 4: 편집 시스템 클라이언트
const EditSystem = {
  currentModal: null,
  currentEntity: null,
  currentHistoryModal: null,
  currentHistoryEntity: null, // 현재 열린 역사 모달의 엔티티 정보 { entityType, entityId }
  editMode: false,
  editData: {},
  tempEdits: {}, // 임시 저장된 편집 내용 { fieldKey: { content, editType, sources } }

  /**
   * 편집 시스템 초기화
   * 편집 모드 UI는 edit-mode.js에서 처리 (api-client.js는 역사/일반 모드만 담당)
   */
  init() {
    // 편집 모드는 edit-mode.js에서 처리하므로 여기서는 스킵
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('edit') === 'true') {
      // edit-mode.js가 처리함 - 여기서는 아무것도 안 함
      return;
    }

    // 일반 모드 이벤트 리스너 등록 (역사 버튼, 편집 버튼 트리거 등)
    this.initNormalModeEventListeners();
  },

  /**
   * 일반 모드 이벤트 리스너 등록
   */
  initNormalModeEventListeners() {
    // 편집 모드 트리거 버튼 (히어로 섹션)
    document.addEventListener('click', (e) => {
      const editModeTrigger = e.target.closest('[data-edit-mode-trigger]');
      if (editModeTrigger) {
        e.preventDefault();
        this.handleEditModeClick(editModeTrigger);
      }
      
      // 문서 역사 트리거 버튼
      const historyTrigger = e.target.closest('[data-history-trigger]');
      if (historyTrigger) {
        e.preventDefault();
        this.handleHistoryClick(historyTrigger);
      }
      
      // 섹션별 편집 버튼 (기존)
      const editButton = e.target.closest('[data-edit-button]');
      if (editButton) {
        e.preventDefault();
        this.handleEditClick(editButton);
      }

      // 모달 닫기 버튼
      const closeBtn = e.target.closest('[data-edit-modal-close]');
      if (closeBtn) {
        e.preventDefault();
        this.closeModal();
      }

      // 문서 역사 모달 닫기 버튼
      const historyCloseBtn = e.target.closest('[data-history-modal-close]');
      if (historyCloseBtn) {
        e.preventDefault();
        this.closeHistoryModal();
      }

      // 백드롭 클릭으로 닫기
      const backdrop = e.target.closest('[data-edit-modal-backdrop]');
      if (backdrop && e.target === backdrop) {
        this.closeModal();
      }

      const historyBackdrop = e.target.closest('[data-history-modal-backdrop]');
      if (historyBackdrop && e.target === historyBackdrop) {
        this.closeHistoryModal();
      }

      // 되돌리기 버튼
      const restoreBtn = e.target.closest('[data-restore-revision]');
      if (restoreBtn) {
        e.preventDefault();
        const revisionId = restoreBtn.getAttribute('data-restore-revision');
        this.handleRestoreRevision(revisionId);
      }

      // 비교 버튼
      const compareBtn = e.target.closest('[data-compare-revision]');
      if (compareBtn) {
        e.preventDefault();
        const revisionId = compareBtn.getAttribute('data-compare-revision');
        this.handleCompareRevision(revisionId);
      }
      
      // 페이지네이션 버튼
      const pageBtn = e.target.closest('[data-history-page]');
      if (pageBtn) {
        e.preventDefault();
        const page = parseInt(pageBtn.getAttribute('data-history-page'), 10);
        const { entityType, entityId } = this.currentHistoryEntity || {};
        if (entityType && entityId) {
          this.loadRevisions({ entityType, entityId, page, limit: 10 });
        }
      }
    });
  },

  /**
   * 편집 모드 이벤트 리스너 등록
   */
  initEditModeEventListeners() {
    // 중복 등록 방지
    if (this._editListenersAttached) return;
    this._editListenersAttached = true;

    // 편집 모드 저장/취소 버튼
    document.addEventListener('click', (e) => {
      const saveBtn = e.target.closest('[data-edit-save]');
      if (saveBtn) {
        e.preventDefault();
        this.handleSave();
      }

      const cancelBtn = e.target.closest('[data-edit-cancel]');
      if (cancelBtn) {
        e.preventDefault();
        this.exitEditMode();
      }
    });

    // ESC 키로 편집 모드 종료
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && this.editMode) {
        this.exitEditMode();
      }
    });
  },

  /**
   * 편집 모드 진입
   */
  async enterEditMode() {
    this.editMode = true;
    
    // 현재 페이지에서 엔티티 정보 추출
    const pathname = window.location.pathname;
    let entityType = null;
    let entityId = null;

    if (pathname.startsWith('/job/')) {
      entityType = 'job';
      let slug = pathname.replace('/job/', '');
      // URL 인코딩된 slug 디코딩
      try {
        slug = decodeURIComponent(slug);
      } catch (e) {
        // 디코딩 실패 시 원본 사용
      }
      const jobIdElement = document.querySelector('[data-job-id]');
      entityId = jobIdElement?.getAttribute('data-job-id') || slug;
    } else if (pathname.startsWith('/major/')) {
      entityType = 'major';
      let slug = pathname.replace('/major/', '');
      // URL 인코딩된 slug 디코딩
      try {
        slug = decodeURIComponent(slug);
      } catch (e) {
        // 디코딩 실패 시 원본 사용
      }
      // URL slug를 우선 사용 (data-major-id는 fallback)
      // URL slug가 실제 페이지의 전공을 정확히 나타내므로 우선순위가 높음
      const majorIdElement = document.querySelector('[data-major-id]');
      entityId = slug || majorIdElement?.getAttribute('data-major-id');
    } else if (pathname.startsWith('/howto/') || pathname.startsWith('/guide/')) {
      entityType = 'howto';
      let slug = pathname.replace(/^\/(howto|guide)\//, '');
      // URL 인코딩된 slug 디코딩
      try {
        slug = decodeURIComponent(slug);
      } catch (e) {
        // 디코딩 실패 시 원본 사용
      }
      entityId = slug;
    }

    if (!entityType || !entityId) {
      return;
    }

    this.currentEntity = { entityType, entityId };

    // 서버에서 편집 데이터 로드
    await this.loadEditData();
    
    // 편집 모드 UI 생성
    this.renderEditMode();
    
    // 필드별 편집 이벤트 리스너 초기화
    setTimeout(() => {
      this.initFieldEditListeners();
    }, 200);
  },

  /**
   * 서버에서 편집 데이터 로드
   */
  async loadEditData() {
    const { entityType, entityId } = this.currentEntity;
    
    try {
      let endpoint;
      // entityId가 이미 URL 인코딩되어 있을 수 있으므로, 
      // decodeURIComponent로 디코딩한 후 다시 인코딩하여 일관성 유지
      let normalizedEntityId = entityId;
      try {
        // 이미 인코딩된 경우 디코딩 시도
        const decoded = decodeURIComponent(entityId);
        // 디코딩이 성공하고 결과가 다르면 인코딩된 것이었음
        if (decoded !== entityId) {
          normalizedEntityId = decoded;
        }
      } catch (e) {
        // 디코딩 실패 시 원본 사용 (이미 디코딩된 상태)
        normalizedEntityId = entityId;
      }
      
      if (entityType === 'job') {
        endpoint = `${API_BASE}/job/${encodeURIComponent(normalizedEntityId)}/edit-data`;
      } else if (entityType === 'major') {
        endpoint = `${API_BASE}/major/${encodeURIComponent(normalizedEntityId)}/edit-data`;
      } else {
        return;
      }

      const response = await fetch(endpoint);
      const result = await response.json();

      if (!response.ok || !result.success) {
        throw new Error(result.error || '편집 데이터 로드 실패');
      }

      // 데이터 검증
      if (!result.data) {
        this.editData = {};
      } else {
        this.editData = result.data;
        const dataKeys = Object.keys(this.editData);
        const nonEmptyKeys = dataKeys.filter(key => {
          const value = this.editData[key];
          return value !== null && value !== undefined && value !== '';
        });
      }
      
      // entityId 업데이트 (edit-data API에서 반환하는 실제 ID 사용)
      if (result.entityId) {
        this.currentEntity.entityId = result.entityId;
      } else {
      }
    } catch (error) {
      alert('편집 데이터를 불러오는데 실패했습니다: ' + (error.message || '알 수 없는 오류'));
      // 에러 발생 시 편집 모드 종료
      this.exitEditMode();
    }
  },

  /**
   * 편집 모드 UI 렌더링
   */
  renderEditMode() {
    // 기존 페이지 전체 숨기기
    const body = document.body;
    
    // 원본 페이지를 숨김
    body.style.display = 'none';
    body.setAttribute('data-original-page-hidden', 'true');

    // 편집 모드 UI 생성
    const editModeHtml = this.createEditModeHtml();
    
    // body 내용을 편집 모드로 교체
    body.style.display = '';
    body.innerHTML = editModeHtml;
    body.setAttribute('data-edit-mode', 'true');

    // 편집 모드 이벤트 리스너 등록 (body 교체 후)
    this.initEditModeEventListeners();
  },

  /**
   * 편집 모드 HTML 생성 (섹션별로 나눔)
   */
  createEditModeHtml() {
    const { entityType } = this.currentEntity;
    
    // 섹션별 필드 그룹화
    const sections = this.groupFieldsBySection(entityType);

    const sectionsHtml = sections.map(section => {
      const fieldsHtml = section.fields.map(field => {
        const value = this.editData[field.key] || '';
        const label = field.label;
        const isTextarea = field.type === 'textarea';

        return `
          <div class="space-y-3 border-b border-wiki-border/30 pb-4 last:border-0" data-field-container="${field.key}">
            <div class="flex items-center justify-between">
              <label class="block text-sm font-medium text-white">
                ${this.escapeHtml(label)}
              </label>
              <button
                type="button"
                data-field-edit-btn="${field.key}"
                class="px-3 py-1.5 text-xs rounded-lg border border-wiki-border/60 bg-transparent text-wiki-muted hover:text-white hover:bg-wiki-border/30 transition"
              >
                <i class="fas fa-edit mr-1"></i>편집
              </button>
            </div>
            
            <!-- 읽기 전용 표시 영역 -->
            <div id="display-${field.key}" class="min-h-[60px] px-4 py-3 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-white whitespace-pre-wrap">
              ${value ? this.escapeHtml(value) : '<span class="text-wiki-muted">내용 없음</span>'}
            </div>
            
            <!-- 편집 영역 (초기에는 숨김) -->
            <div id="edit-${field.key}" class="hidden space-y-3">
              ${isTextarea ? `
                <textarea
                  id="input-${field.key}"
                  rows="6"
                  class="w-full px-4 py-3 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-wiki-primary focus:border-transparent resize-y"
                  data-edit-field="${field.key}"
                >${this.escapeHtml(value)}</textarea>
              ` : `
                <input
                  type="text"
                  id="input-${field.key}"
                  class="w-full px-4 py-3 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-wiki-primary focus:border-transparent"
                  value="${this.escapeHtml(value)}"
                  data-edit-field="${field.key}"
                />
              `}
              
              <!-- 수정 유형 선택 -->
              <div class="space-y-2">
                <div class="flex items-center gap-4">
                  <label class="flex items-center gap-2 text-sm text-white cursor-pointer">
                    <input type="radio" name="edit-type-${field.key}" value="simple" checked class="text-wiki-primary">
                    <span>단순 수정</span>
                  </label>
                  <label class="flex items-center gap-2 text-sm text-white cursor-pointer">
                    <input type="radio" name="edit-type-${field.key}" value="source" class="text-wiki-primary">
                    <span>출처 입력</span>
                  </label>
                </div>
                
                <!-- 출처 입력 영역 (출처 입력 선택 시 표시) -->
                <div id="sources-${field.key}" class="hidden space-y-2">
                  <div class="sources-list-${field.key} space-y-2"></div>
                  <button
                    type="button"
                    data-add-source="${field.key}"
                    class="px-3 py-1.5 text-xs rounded-lg border border-wiki-border/60 bg-transparent text-wiki-muted hover:text-white hover:bg-wiki-border/30 transition"
                  >
                    <i class="fas fa-plus mr-1"></i>출처 추가
                  </button>
                </div>
              </div>
              
              <!-- 임시 저장/취소 버튼 -->
              <div class="flex items-center gap-2">
                <button
                  type="button"
                  data-field-temp-save="${field.key}"
                  class="px-4 py-2 text-sm rounded-lg bg-wiki-primary/70 text-white hover:bg-wiki-primary transition"
                >
                  임시 저장
                </button>
                <button
                  type="button"
                  data-field-cancel="${field.key}"
                  class="px-4 py-2 text-sm rounded-lg border border-wiki-border/60 bg-transparent text-wiki-muted hover:text-white hover:bg-wiki-border/30 transition"
                >
                  취소
                </button>
              </div>
            </div>
          </div>
        `;
      }).join('');

      return `
        <div class="bg-wiki-bg/50 border border-wiki-border/60 rounded-xl p-6 space-y-4">
          <h3 class="text-lg font-semibold text-white mb-4 flex items-center gap-2">
            <i class="fas ${section.icon}" aria-hidden="true"></i>
            ${this.escapeHtml(section.title)}
          </h3>
          <div class="space-y-6">
            ${fieldsHtml}
          </div>
        </div>
      `;
    }).join('');

    const isJob = this.currentEntity.entityType === 'job';
    const gradientFrom = isJob ? 'wiki-primary' : 'wiki-secondary';
    const gradientTo = isJob ? 'blue-500' : 'purple-500';
    const entityLabel = isJob ? '직업' : '전공';
    
    return `
      <div class="h-screen flex flex-col bg-wiki-bg overflow-hidden">
        <!-- 편집 모드 헤더 -->
        <div class="flex-shrink-0 bg-gradient-to-b from-wiki-card to-wiki-card/95 backdrop-blur-md border-b border-${gradientFrom}/20 shadow-lg shadow-black/20">
          <div class="max-w-[1600px] mx-auto">
            <!-- 상단: 편집 상태 표시 바 -->
            <div class="px-4 sm:px-6 py-1.5 bg-gradient-to-r from-${gradientFrom}/10 to-${gradientTo}/10 border-b border-${gradientFrom}/10">
              <div class="flex items-center gap-2 text-xs text-${gradientFrom}">
                <i class="fas fa-edit"></i>
                <span class="font-medium">${entityLabel} 편집 중</span>
              </div>
            </div>
            
            <!-- 메인: 제목 + 액션 버튼 -->
            <div class="px-4 sm:px-6 py-3 sm:py-4">
              <div class="flex items-center justify-between gap-4">
                <!-- 왼쪽: 뒤로가기 + 제목 -->
                <div class="flex items-center gap-3 min-w-0 flex-1">
                  <button
                    type="button"
                    data-edit-cancel
                    class="shrink-0 w-10 h-10 sm:w-11 sm:h-11 flex items-center justify-center text-wiki-muted hover:text-white hover:bg-wiki-border/30 rounded-xl transition"
                    title="편집 취소"
                  >
                    <i class="fas fa-arrow-left text-lg"></i>
                  </button>
                  <div class="min-w-0 flex-1">
                    <h1 class="text-xl sm:text-2xl font-bold text-white leading-tight">편집 모드</h1>
                    <p class="text-xs sm:text-sm text-wiki-muted mt-0.5 hidden sm:block">필드를 수정하고 저장하세요</p>
                  </div>
                </div>
                
                <!-- 오른쪽: 저장 버튼 -->
                <button
                  type="button"
                  data-edit-save-all
                  class="shrink-0 px-5 sm:px-6 py-2.5 sm:py-3 min-h-[44px] bg-gradient-to-r from-${gradientFrom} to-${gradientTo} text-white font-semibold rounded-xl hover:shadow-lg hover:shadow-${gradientFrom}/30 active:scale-[0.98] transition-all duration-200 text-sm sm:text-base"
                >
                  <i class="fas fa-check mr-2 hidden sm:inline"></i>
                  <span>저장</span>
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- 편집 모드 본문 (단일 컬럼) -->
        <div class="flex-1 overflow-hidden max-w-[1200px] mx-auto w-full px-6 py-6">
          <div class="bg-wiki-bg/50 border border-wiki-border/60 rounded-xl p-6 flex flex-col h-full">
            <h2 class="text-lg font-semibold text-white mb-4 flex-shrink-0">편집창</h2>
            <div class="flex-1 overflow-y-auto space-y-6 pr-2">
              ${sectionsHtml}
            </div>
          </div>
        </div>
      </div>
    `;
  },

  /**
   * 필드를 섹션별로 그룹화
   */
  groupFieldsBySection(entityType) {
    if (entityType === 'major') {
      return [
        {
          title: '히어로 섹션',
          icon: 'fa-star',
          fields: [
            { key: 'name', label: '전공명', type: 'text' },
            { key: 'summary', label: '전공 소개', type: 'textarea' }
          ]
        },
        {
          title: '개요 탭',
          icon: 'fa-circle-info',
          fields: [
            { key: 'overview.summary', label: '전공 개요', type: 'textarea' },
            { key: 'property', label: '전공 특성', type: 'textarea' },
            { key: 'aptitude', label: '이 전공에 어울리는 사람', type: 'textarea' }
          ]
        },
        {
          title: '상세정보 탭',
          icon: 'fa-layer-group',
          fields: [
            { key: 'whatStudy', label: '무엇을 배우나', type: 'textarea' },
            { key: 'howPrepare', label: '어떻게 준비하나', type: 'textarea' },
            { key: 'enterField', label: '졸업 후 진출 분야', type: 'textarea' }
          ]
        }
      ]
    } else if (entityType === 'job') {
      return [
        {
          title: '히어로 섹션',
          icon: 'fa-star',
          fields: [
            { key: 'name', label: '직업명', type: 'text' },
            { key: 'summary', label: '직업 소개 (히어로 설명)', type: 'textarea' },
            { key: 'tags', label: '태그', type: 'textarea' }
          ]
        },
        {
          title: '개요 탭',
          icon: 'fa-circle-info',
          fields: [
            { key: 'duties', label: '주요 업무', type: 'textarea' },
            { key: 'way', label: '되는 방법', type: 'textarea' },
            { key: 'salary', label: '임금 정보', type: 'textarea' },
            { key: 'prospect', label: '전망', type: 'textarea' },
            { key: 'satisfaction', label: '만족도', type: 'textarea' },
            { key: 'status', label: '고용 형태', type: 'textarea' }
          ]
        },
        {
          title: '상세정보 탭',
          icon: 'fa-layer-group',
          fields: [
            { key: 'knowledge', label: '지식', type: 'textarea' },
            { key: 'environment', label: '환경', type: 'textarea' },
            { key: 'technKnow', label: '기술/지식', type: 'textarea' },
            { key: 'aptitude', label: '적성', type: 'textarea' },
            { key: 'educationDistribution', label: '학력 분포', type: 'textarea' },
            { key: 'majorDistribution', label: '전공 분포', type: 'textarea' }
          ]
        },
        {
          title: '업무특성 탭',
          icon: 'fa-chart-pie',
          fields: [
            { key: 'abilities', label: '능력', type: 'textarea' },
            { key: 'personality', label: '성격', type: 'textarea' },
            { key: 'interests', label: '흥미', type: 'textarea' },
            { key: 'values', label: '가치관', type: 'textarea' },
            { key: 'activitiesImportance', label: '활동 중요도', type: 'textarea' },
            { key: 'activitiesLevels', label: '활동 수준', type: 'textarea' }
          ]
        }
      ];
    }
    return [];
  },

  /**
   * 편집 가능한 필드 목록 가져오기
   */
  getEditableFields(entityType) {
    if (entityType === 'job') {
      return [
        { key: 'name', label: '직업명', type: 'text' },
        { key: 'summary', label: '직업 소개', type: 'textarea' },
        { key: 'duties', label: '주요 업무', type: 'textarea' },
        { key: 'salary', label: '임금 정보', type: 'textarea' },
        { key: 'prospect', label: '전망', type: 'textarea' },
        { key: 'way', label: '되는 방법', type: 'textarea' },
        { key: 'abilities', label: '능력', type: 'textarea' },
        { key: 'knowledge', label: '지식', type: 'textarea' },
        { key: 'environment', label: '환경', type: 'textarea' },
        { key: 'personality', label: '성격', type: 'textarea' },
        { key: 'interests', label: '흥미', type: 'textarea' },
        { key: 'values', label: '가치관', type: 'textarea' }
      ];
    } else if (entityType === 'major') {
      return [
        // 히어로 섹션
        { key: 'name', label: '전공명', type: 'text' },
        { key: 'heroSummary', label: '전공 설명', type: 'textarea' },
        { key: 'heroTags', label: '관련 학과 태그', type: 'tags' },
        { key: 'categoryName', label: '계열', type: 'text' },
        // 개요
        { key: 'overview.summary', label: '전공 개요', type: 'textarea' },
        { key: 'property', label: '전공 특성', type: 'textarea' },
        { key: 'aptitude', label: '이 전공에 어울리는 사람', type: 'textarea' },
        { key: 'enterField', label: '졸업 후 진출 분야', type: 'pairList' },
        { key: 'trivia', label: '여담', type: 'list' },
        // 상세정보
        { key: 'whatStudy', label: '배우는 내용', type: 'textarea' },
        { key: 'mainSubject', label: '주요 교과목', type: 'tags' },
        { key: 'relateSubject', label: '고교 추천 교과목', type: 'tags' },
        { key: 'careerAct', label: '진로 탐색 활동', type: 'pairList' },
        // 사이드바
        { key: 'sidebarJobs', label: '관련 직업', type: 'autocomplete' },
        { key: 'sidebarMajors', label: '관련 전공', type: 'autocomplete' },
        { key: 'sidebarHowtos', label: '관련 HowTo', type: 'autocomplete' }
      ];
    } else if (entityType === 'howto') {
      return [
        { key: 'title', label: '제목', type: 'text' },
        { key: 'content', label: '내용', type: 'textarea' }
      ];
    }
    return [];
  },

  /**
   * 필드별 편집 이벤트 리스너 초기화
   */
  initFieldEditListeners() {
    // 편집 버튼 클릭
    document.addEventListener('click', (e) => {
      const editBtn = e.target.closest('[data-field-edit-btn]');
      if (editBtn) {
        const fieldKey = editBtn.getAttribute('data-field-edit-btn');
        this.enterFieldEditMode(fieldKey);
      }

      // 출처 추가 버튼
      const addSourceBtn = e.target.closest('[data-add-source]');
      if (addSourceBtn) {
        const fieldKey = addSourceBtn.getAttribute('data-add-source');
        this.addSourceInput(fieldKey);
      }

      // 필드 임시 저장 버튼
      const tempSaveBtn = e.target.closest('[data-field-temp-save]');
      if (tempSaveBtn) {
        const fieldKey = tempSaveBtn.getAttribute('data-field-temp-save');
        this.tempSaveField(fieldKey);
      }

      // 최종 저장 버튼
      const saveAllBtn = e.target.closest('[data-edit-save-all]');
      if (saveAllBtn) {
        e.preventDefault();
        this.saveAllEdits();
      }

      // 필드 취소 버튼
      const cancelBtn = e.target.closest('[data-field-cancel]');
      if (cancelBtn) {
        const fieldKey = cancelBtn.getAttribute('data-field-cancel');
        this.cancelFieldEdit(fieldKey);
      }
    });

    // 수정 유형 라디오 버튼 변경
    document.addEventListener('change', (e) => {
      if (e.target.matches('input[name^="edit-type-"]')) {
        const fieldKey = e.target.name.replace('edit-type-', '');
        const editType = e.target.value;
        const sourcesDiv = document.getElementById(`sources-${fieldKey}`);
        if (sourcesDiv) {
          sourcesDiv.classList.toggle('hidden', editType !== 'source');
        }
      }
    });

    // 실시간 미리보기 업데이트 (편집 중인 필드만)
    // 실시간 미리보기 업데이트 제거 - 임시 저장 시에만 업데이트
    // document.addEventListener('input', (e) => {
    //   if (e.target.matches('[data-edit-field]')) {
    //     this.updatePreviewDebounced();
    //   }
    // });
  },

  /**
   * 필드 편집 모드 진입
   */
  enterFieldEditMode(fieldKey) {
    const displayDiv = document.getElementById(`display-${fieldKey}`);
    const editDiv = document.getElementById(`edit-${fieldKey}`);
    const editBtn = document.querySelector(`[data-field-edit-btn="${fieldKey}"]`);
    
    if (displayDiv && editDiv && editBtn) {
      displayDiv.classList.add('hidden');
      editDiv.classList.remove('hidden');
      editBtn.classList.add('hidden');
      
      // 입력 필드에 포커스 및 임시 저장된 내용 복원
      const input = document.getElementById(`input-${fieldKey}`);
      if (input) {
        // 임시 저장된 내용이 있으면 복원
        if (this.tempEdits[fieldKey]) {
          input.value = this.tempEdits[fieldKey].content;
          
          // 수정 유형 복원
          const editType = this.tempEdits[fieldKey].editType;
          const editTypeRadio = document.querySelector(`input[name="edit-type-${fieldKey}"][value="${editType}"]`);
          if (editTypeRadio) {
            editTypeRadio.checked = true;
            
            // 출처 입력 선택 시 출처 복원
            if (editType === 'source' && this.tempEdits[fieldKey].sources.length > 0) {
              const sourcesDiv = document.getElementById(`sources-${fieldKey}`);
              if (sourcesDiv) {
                sourcesDiv.classList.remove('hidden');
                const sourcesList = document.querySelector(`.sources-list-${fieldKey}`);
                if (sourcesList) {
                  // 기존 출처 입력 필드 제거 후 재생성
                  sourcesList.innerHTML = '';
                  this.tempEdits[fieldKey].sources.forEach((source) => {
                    this.addSourceInput(fieldKey);
                    const inputs = sourcesList.querySelectorAll('input');
                    if (inputs[inputs.length - 1]) {
                      inputs[inputs.length - 1].value = source;
                    }
                  });
                }
              }
            }
          }
        }
        setTimeout(() => input.focus(), 100);
      }
    }
  },

  /**
   * 필드 편집 취소
   */
  cancelFieldEdit(fieldKey) {
    const displayDiv = document.getElementById(`display-${fieldKey}`);
    const editDiv = document.getElementById(`edit-${fieldKey}`);
    const editBtn = document.querySelector(`[data-field-edit-btn="${fieldKey}"]`);
    const input = document.getElementById(`input-${fieldKey}`);
    
    if (displayDiv && editDiv && editBtn && input) {
      // 임시 저장된 값이 있으면 그것을 사용, 없으면 원래 값 사용
      const valueToShow = this.tempEdits[fieldKey] 
        ? this.tempEdits[fieldKey].content 
        : (this.editData[fieldKey] || '');
      
      // 입력 필드는 임시 저장된 값으로 설정 (다시 편집할 때를 위해)
      if (this.tempEdits[fieldKey]) {
        input.value = this.tempEdits[fieldKey].content;
      } else {
        input.value = this.editData[fieldKey] || '';
      }
      
      // 출처 입력 영역 초기화
      const sourcesList = document.querySelector(`.sources-list-${fieldKey}`);
      if (sourcesList) {
        sourcesList.innerHTML = '';
      }
      const sourcesDiv = document.getElementById(`sources-${fieldKey}`);
      if (sourcesDiv) {
        sourcesDiv.classList.add('hidden');
      }
      
      // 라디오 버튼 초기화
      const simpleRadio = document.querySelector(`input[name="edit-type-${fieldKey}"][value="simple"]`);
      if (simpleRadio) {
        simpleRadio.checked = true;
      }
      
      // 표시 영역 업데이트
      displayDiv.innerHTML = valueToShow 
        ? this.escapeHtml(valueToShow) 
        : '<span class="text-wiki-muted">내용 없음</span>';
      
      // 임시 저장된 필드는 표시
      if (this.tempEdits[fieldKey]) {
        displayDiv.classList.add('border-wiki-primary/50');
      } else {
        displayDiv.classList.remove('border-wiki-primary/50');
      }
      
      displayDiv.classList.remove('hidden');
      editDiv.classList.add('hidden');
      editBtn.classList.remove('hidden');
    }
  },

  /**
   * 출처 입력 필드 추가
   */
  addSourceInput(fieldKey) {
    const sourcesList = document.querySelector(`.sources-list-${fieldKey}`);
    if (!sourcesList) return;
    
    const sourceIndex = sourcesList.children.length;
    const sourceHtml = `
      <div class="flex items-center gap-2" data-source-item="${fieldKey}-${sourceIndex}">
        <input
          type="url"
          placeholder="https://example.com/article"
          class="flex-1 px-3 py-2 text-sm rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-wiki-primary focus:border-transparent"
          data-source-url="${fieldKey}"
        />
        <button
          type="button"
          data-remove-source="${fieldKey}-${sourceIndex}"
          class="px-2 py-2 text-sm rounded-lg border border-wiki-border/60 bg-transparent text-wiki-muted hover:text-white hover:bg-wiki-border/30 transition"
        >
          <i class="fas fa-times"></i>
        </button>
      </div>
    `;
    
    sourcesList.insertAdjacentHTML('beforeend', sourceHtml);
    
    // 삭제 버튼 이벤트
    const removeBtn = sourcesList.querySelector(`[data-remove-source="${fieldKey}-${sourceIndex}"]`);
    if (removeBtn) {
      removeBtn.addEventListener('click', () => {
        const item = document.querySelector(`[data-source-item="${fieldKey}-${sourceIndex}"]`);
        if (item) item.remove();
      });
    }
  },

  /**
   * 필드 임시 저장 (로컬에만 저장)
   */
  tempSaveField(fieldKey) {
    const input = document.getElementById(`input-${fieldKey}`);
    if (!input) return;
    
    const content = input.value.trim();
    if (!content) {
      alert('내용을 입력해주세요.');
      return;
    }
    
    const editType = document.querySelector(`input[name="edit-type-${fieldKey}"]:checked`)?.value || 'simple';
    const sourcesList = document.querySelectorAll(`input[data-source-url="${fieldKey}"]`);
    const sources = Array.from(sourcesList).map(input => input.value.trim()).filter(Boolean);
    
    // 출처 입력 선택 시 출처 필수
    if (editType === 'source' && sources.length === 0) {
      alert('출처를 최소 1개 이상 입력해주세요.');
      return;
    }
    
    // 임시 저장 (로컬 상태에만 저장)
    this.tempEdits[fieldKey] = {
      content,
      editType,
      sources
    };
    
    
    // UI 업데이트
    this.editData[fieldKey] = content;
    const displayDiv = document.getElementById(`display-${fieldKey}`);
    if (displayDiv) {
      displayDiv.innerHTML = content ? this.escapeHtml(content) : '<span class="text-wiki-muted">내용 없음</span>';
      displayDiv.classList.add('border-wiki-primary/50'); // 임시 저장 표시
    }
    
    // 편집 모드 종료 (읽기 모드로 전환)
    this.cancelFieldEdit(fieldKey);
    
    // 미리보기 업데이트
    this.updatePreview();
    
    // 성공 메시지
    const tempSaveBtn = document.querySelector(`[data-field-temp-save="${fieldKey}"]`);
    if (tempSaveBtn) {
      const originalText = tempSaveBtn.innerHTML;
      tempSaveBtn.innerHTML = '<i class="fas fa-check mr-1"></i>임시 저장됨';
      tempSaveBtn.classList.add('bg-green-600');
      setTimeout(() => {
        tempSaveBtn.innerHTML = originalText;
        tempSaveBtn.classList.remove('bg-green-600');
      }, 2000);
    }
  },

  /**
   * 모든 편집 내용 최종 저장 (서버에 저장)
   */
  async saveAllEdits() {
    const editKeys = Object.keys(this.tempEdits);
    
    if (editKeys.length === 0) {
      alert('저장할 편집 내용이 없습니다.');
      return;
    }
    
    const { entityType, entityId } = this.currentEntity;
    
    try {
      // 모든 필드에 대해 서버에 저장
      const savePromises = editKeys.map(fieldKey => {
        const edit = this.tempEdits[fieldKey];
        const sourceToSend = edit.editType === 'source' ? edit.sources[0] : '';
        
        let endpoint;
        if (entityType === 'job') {
          endpoint = `${API_BASE}/job/${entityId}/edit`;
        } else if (entityType === 'major') {
          endpoint = `${API_BASE}/major/${entityId}/edit`;
        } else if (entityType === 'howto') {
          endpoint = `${API_BASE}/howto/${entityId}/edit`;
        } else {
          throw new Error('지원하지 않는 엔티티 타입입니다.');
        }
        
        return fetch(endpoint, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            field: fieldKey,
            content: edit.content,
            source: sourceToSend
          })
        }).then(res => res.json());
      });
      
      const results = await Promise.all(savePromises);
      
      // 에러 확인
      const errors = results.filter(r => !r.success);
      if (errors.length > 0) {
        throw new Error(errors[0].error || '저장 중 오류가 발생했습니다.');
      }
      
      // 성공 시 임시 저장 내용 초기화
      this.tempEdits = {};
      
      // 편집 모드 종료 (저장 후이므로 캐시 우회 필요)
      alert('모든 편집 내용이 저장되었습니다.');
      this.exitEditMode(true); // forceRefresh = true
    } catch (error) {
      alert(error.message || '저장 중 오류가 발생했습니다.');
    }
  },

  /**
   * 편집 모드 종료
   */
  exitEditMode(forceRefresh = false) {
    const url = new URL(window.location.href);
    url.searchParams.delete('edit');
    
    if (forceRefresh) {
      // 저장 후: 캐시 우회를 위해 _t 파라미터 추가 후 새로고침
      url.searchParams.set('_t', Date.now().toString());
      window.location.href = url.toString();
    } else {
      // 취소: URL 파라미터만 제거
      url.searchParams.delete('_t');
      window.location.replace(url.toString());
    }
  },

  /**
   * 저장 처리
   */
  async handleSave() {
    const form = document.getElementById('edit-form');
    if (!form) return;

    const formData = new FormData(form);
    const editType = formData.get('edit-type') || 'source';
    const source = formData.get('source')?.trim() || '';

    // 수정 유형 검증: 출처 입력 선택 시 출처 URL 필수
    if (editType === 'source' && !source) {
      alert('출처 URL을 입력해주세요.');
      return;
    }

    const { entityType, entityId } = this.currentEntity;
    const edits = {};
    const originalData = this.editData || {};

    // 편집된 필드 수집 (편집 필드는 document에서 찾아야 함)
    document.querySelectorAll('[data-edit-field]').forEach(input => {
      const key = input.getAttribute('data-edit-field');
      const currentValue = input.value.trim();
      const originalValue = originalData[key] || '';
      
      // 값이 변경된 경우에만 추가 (빈 값이 아니거나 원래 값과 다른 경우)
      if (currentValue && currentValue !== originalValue) {
        edits[key] = currentValue;
      }
    });

    if (Object.keys(edits).length === 0) {
      alert('편집할 내용이 없습니다. 내용을 입력하거나 변경해주세요.');
      return;
    }

    try {
      // 각 필드별로 편집 API 호출
      const editPromises = Object.entries(edits).map(([field, content]) => {
        let endpoint;
        if (entityType === 'job') {
          endpoint = `${API_BASE}/job/${entityId}/edit`;
        } else if (entityType === 'major') {
          endpoint = `${API_BASE}/major/${entityId}/edit`;
        } else if (entityType === 'howto') {
          endpoint = `${API_BASE}/howto/${entityId}/edit`;
        } else {
          throw new Error('지원하지 않는 엔티티 타입입니다.');
        }

        // 단순 수정일 때는 source를 빈 문자열로 전송
        const sourceToSend = editType === 'simple' ? '' : source;
        
        return fetch(endpoint, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            field,
            content,
            source: sourceToSend
          })
        });
      });

      const responses = await Promise.all(editPromises);
      const results = await Promise.all(responses.map(r => r.json()));

      // 에러 확인
      const errors = results.filter(r => !r.success);
      if (errors.length > 0) {
        throw new Error(errors[0].error || '저장 중 오류가 발생했습니다.');
      }

      // 성공 시 편집 모드 종료 (저장 후이므로 캐시 우회 필요)
      alert('저장되었습니다.');
      this.exitEditMode(true); // forceRefresh = true

    } catch (error) {
      alert(error.message || '저장 중 오류가 발생했습니다.');
    }
  },

  /**
   * 편집 모드 트리거 클릭 핸들러 (히어로 섹션)
   */
  handleEditModeClick(button) {
    const entityType = button.dataset.entityType;
    const entityId = button.dataset.entityId;

    if (!entityType || !entityId) {
      return;
    }

    // 편집 모드 진입 (URL 파라미터 추가)
    const currentUrl = new URL(window.location.href);
    currentUrl.searchParams.set('edit', 'true');
    window.location.href = currentUrl.toString();
  },

  /**
   * 섹션별 편집 버튼 클릭 핸들러
   */
  handleEditClick(button) {
    const entityType = button.dataset.entityType;
    const entityId = button.dataset.entityId;
    const field = button.dataset.field;

    if (!entityType || !entityId || !field) {
      return;
    }

    // 특정 필드 편집 모달 열기
    this.openEditModal({ entityType, entityId, field });
  },

  /**
   * 편집 모달 열기
   */
  openEditModal({ entityType, entityId, field = null }) {
    // 기존 모달이 있으면 닫기
    if (this.currentModal) {
      this.closeModal();
    }

    this.currentEntity = { entityType, entityId, field };

    // 모달 HTML 생성
    const modalHtml = this.createModalHtml({ entityType, entityId, field });
    
    // 모달을 body에 추가
    const modalContainer = document.createElement('div');
    modalContainer.innerHTML = modalHtml;
    const modal = modalContainer.firstElementChild;
    document.body.appendChild(modal);
    this.currentModal = modal;

    // 모달 초기화
    this.initModal(modal);

    // 애니메이션을 위해 약간의 지연 후 표시
    requestAnimationFrame(() => {
      modal.classList.remove('opacity-0');
      modal.classList.add('opacity-100');
      const dialog = modal.querySelector('[data-edit-modal-dialog]');
      if (dialog) {
        dialog.classList.remove('scale-95');
        dialog.classList.add('scale-100');
      }
    });

    // 첫 번째 입력 필드에 포커스
    const firstInput = modal.querySelector('textarea, input[type="text"], input[type="url"]');
    if (firstInput) {
      setTimeout(() => firstInput.focus(), 100);
    }
  },

  /**
   * 편집 모달 HTML 생성
   */
  createModalHtml({ entityType, entityId, field }) {
    const fieldLabel = field ? this.getFieldLabel(entityType, field) : '전체 편집';
    const isAnonymous = !this.isLoggedIn();

    return `
      <div 
        data-edit-modal-backdrop
        class="fixed inset-0 z-[9999] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm opacity-0 transition-opacity duration-200"
        role="dialog"
        aria-modal="true"
        aria-labelledby="edit-modal-title"
      >
        <div 
          data-edit-modal-dialog
          class="w-full max-w-2xl max-h-[90vh] bg-wiki-bg/95 border border-wiki-border/60 rounded-2xl shadow-2xl scale-95 transition-transform duration-200 overflow-hidden flex flex-col"
        >
          <!-- 헤더 -->
          <div class="flex items-center justify-between px-6 py-4 border-b border-wiki-border/60">
            <h2 id="edit-modal-title" class="text-lg font-semibold text-white">
              ${this.escapeHtml(fieldLabel)} 편집
            </h2>
            <button 
              type="button"
              data-edit-modal-close
              class="text-wiki-muted hover:text-white transition p-1 rounded-lg hover:bg-wiki-border/30"
              aria-label="닫기"
            >
              <i class="fas fa-times text-lg" aria-hidden="true"></i>
            </button>
          </div>

          <!-- 본문 -->
          <form data-edit-form class="flex-1 overflow-y-auto px-6 py-4 space-y-4">
            <!-- 내용 입력 -->
            <div>
              <label for="edit-content" class="block text-sm font-medium text-white mb-2">
                내용 <span class="text-wiki-muted">(필수)</span>
              </label>
              <textarea
                id="edit-content"
                name="content"
                rows="8"
                class="w-full px-4 py-3 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-wiki-primary focus:border-transparent resize-y"
                placeholder="편집할 내용을 입력하세요..."
                required
              ></textarea>
            </div>

            <!-- 출처 입력 -->
            <div>
              <label for="edit-source" class="block text-sm font-medium text-white mb-2">
                출처 URL <span class="text-wiki-muted">(필수)</span>
              </label>
              <input
                type="url"
                id="edit-source"
                name="source"
                class="w-full px-4 py-3 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-wiki-primary focus:border-transparent"
                placeholder="https://example.com/article"
                required
              />
              <p class="mt-1 text-xs text-wiki-muted">편집 내용의 출처를 명시해주세요.</p>
            </div>

            <!-- 익명 편집 옵션 (로그인하지 않은 경우) -->
            ${isAnonymous ? `
              <div class="space-y-3 p-4 rounded-lg bg-wiki-bg/50 border border-wiki-border/40">
                <label class="flex items-center gap-2 cursor-pointer">
                  <input
                    type="checkbox"
                    id="edit-anonymous"
                    name="anonymous"
                    class="w-4 h-4 rounded border-wiki-border/60 bg-wiki-bg/70 text-wiki-primary focus:ring-wiki-primary"
                  />
                  <span class="text-sm text-white">익명으로 편집</span>
                </label>
                <div id="edit-password-section" class="hidden space-y-2">
                  <label for="edit-password" class="block text-sm font-medium text-white">
                    비밀번호 <span class="text-wiki-muted">(4자리 숫자)</span>
                  </label>
                  <input
                    type="password"
                    id="edit-password"
                    name="password"
                    class="w-full px-4 py-3 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-white placeholder-wiki-muted focus:outline-none focus:ring-2 focus:ring-wiki-primary focus:border-transparent"
                    placeholder="0000"
                    maxlength="4"
                    pattern="[0-9]{4}"
                    inputmode="numeric"
                  />
                  <p class="text-xs text-wiki-muted">나중에 수정하거나 되돌리기 위해 필요합니다.</p>
                </div>
              </div>
            ` : ''}

            <!-- 에러 메시지 -->
            <div id="edit-error" class="hidden p-3 rounded-lg bg-red-500/20 border border-red-500/40">
              <p class="text-sm text-red-300"></p>
            </div>

            <!-- 성공 메시지 -->
            <div id="edit-success" class="hidden p-3 rounded-lg bg-green-500/20 border border-green-500/40">
              <p class="text-sm text-green-300"></p>
            </div>
          </form>

          <!-- 푸터 -->
          <div class="flex items-center justify-end gap-3 px-6 py-4 border-t border-wiki-border/60">
            <button
              type="button"
              data-edit-modal-close
              class="px-4 py-2 rounded-lg border border-wiki-border/60 bg-transparent text-wiki-muted hover:text-white hover:bg-wiki-border/30 transition"
            >
              취소
            </button>
            <button
              type="submit"
              data-edit-submit
              class="px-4 py-2 rounded-lg bg-wiki-primary text-white hover:bg-blue-600 transition disabled:opacity-50 disabled:cursor-not-allowed"
            >
              저장
            </button>
          </div>
        </div>
      </div>
    `;
  },

  /**
   * 필드 라벨 가져오기
   */
  getFieldLabel(entityType, field) {
    const labels = {
      job: {
        summary: '직업 소개',
        duties: '주요 업무',
        salary: '임금 정보',
        prospect: '전망',
        education: '학력',
        experience: '경력'
      },
      major: {
        summary: '전공 소개',
        career: '진로',
        curriculum: '교과과정'
      },
      howto: {
        content: '내용'
      }
    };
    return labels[entityType]?.[field] || field;
  },

  /**
   * 로그인 여부 확인
   */
  isLoggedIn() {
    // window.__USER__는 shared-helpers.ts의 /api/me 호출로 설정됨
    return !!(window.__USER__ && window.__USER__.id);
  },

  /**
   * 모달 초기화
   */
  initModal(modal) {
    const form = modal.querySelector('[data-edit-form]');
    const anonymousCheckbox = modal.querySelector('#edit-anonymous');
    const passwordSection = modal.querySelector('#edit-password-section');
    const submitBtn = modal.querySelector('[data-edit-submit]');

    // 익명 편집 체크박스 토글
    if (anonymousCheckbox && passwordSection) {
      anonymousCheckbox.addEventListener('change', (e) => {
        if (e.target.checked) {
          passwordSection.classList.remove('hidden');
          const passwordInput = passwordSection.querySelector('#edit-password');
          if (passwordInput) {
            passwordInput.required = true;
            passwordInput.focus();
          }
        } else {
          passwordSection.classList.add('hidden');
          const passwordInput = passwordSection.querySelector('#edit-password');
          if (passwordInput) {
            passwordInput.required = false;
            passwordInput.value = '';
          }
        }
      });
    }

    // 폼 제출
    if (form) {
      form.addEventListener('submit', async (e) => {
        e.preventDefault();
        await this.handleSubmit(form);
      });
    }
  },

  /**
   * 폼 제출 처리
   */
  async handleSubmit(form) {
    const submitBtn = form.querySelector('[data-edit-submit]');
    const errorDiv = form.querySelector('#edit-error');
    const successDiv = form.querySelector('#edit-success');
    const { entityType, entityId, field } = this.currentEntity;

    // 에러/성공 메시지 숨기기
    if (errorDiv) errorDiv.classList.add('hidden');
    if (successDiv) successDiv.classList.add('hidden');

    // 폼 데이터 수집
    const formData = new FormData(form);
    const content = formData.get('content')?.trim() || '';
    const source = formData.get('source')?.trim() || '';
    const anonymous = formData.get('anonymous') === 'on';
    const password = formData.get('password')?.trim() || '';

    // 유효성 검사
    if (!content) {
      this.showError(form, '내용을 입력해주세요.');
      return;
    }
    if (!source) {
      this.showError(form, '출처 URL을 입력해주세요.');
      return;
    }
    if (anonymous && !password) {
      this.showError(form, '비밀번호를 입력해주세요.');
      return;
    }
    if (password && !/^\d{4}$/.test(password)) {
      this.showError(form, '비밀번호는 4자리 숫자여야 합니다.');
      return;
    }

    // 제출 버튼 비활성화
    if (submitBtn) {
      submitBtn.disabled = true;
      submitBtn.textContent = '저장 중...';
    }

    try {
      // API 엔드포인트 결정
      let endpoint;
      if (entityType === 'job') {
        endpoint = `${API_BASE}/job/${entityId}/edit`;
      } else if (entityType === 'major') {
        endpoint = `${API_BASE}/major/${entityId}/edit`;
      } else if (entityType === 'howto') {
        endpoint = `${API_BASE}/howto/${entityId}/edit`;
      } else {
        throw new Error('지원하지 않는 엔티티 타입입니다.');
      }

      // 요청 본문 구성
      const payload = {
        field: field || null,
        content,
        source
      };

      if (anonymous && password) {
        payload.password = password;
      }

      // API 호출
      const response = await fetch(endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
      });

      const result = await response.json();

      if (!response.ok) {
        throw new Error(result.error || result.message || '편집 저장에 실패했습니다.');
      }

      // 성공 메시지 표시
      this.showSuccess(form, '편집이 저장되었습니다. 페이지를 새로고침합니다...');

      // 페이지 새로고침 (캐시 우회)
      setTimeout(() => {
        const url = new URL(window.location.href);
        url.searchParams.set('_t', Date.now().toString());
        window.location.replace(url.toString());
      }, 1500);

    } catch (error) {
      this.showError(form, error.message || '편집 저장 중 오류가 발생했습니다.');
      
      // 제출 버튼 다시 활성화
      if (submitBtn) {
        submitBtn.disabled = false;
        submitBtn.textContent = '저장';
      }
    }
  },

  /**
   * 에러 메시지 표시
   */
  showError(form, message) {
    const errorDiv = form.querySelector('#edit-error');
    if (errorDiv) {
      const errorText = errorDiv.querySelector('p');
      if (errorText) {
        errorText.textContent = message;
      }
      errorDiv.classList.remove('hidden');
      errorDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
  },

  /**
   * 성공 메시지 표시
   */
  showSuccess(form, message) {
    const successDiv = form.querySelector('#edit-success');
    if (successDiv) {
      const successText = successDiv.querySelector('p');
      if (successText) {
        successText.textContent = message;
      }
      successDiv.classList.remove('hidden');
      successDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
  },

  /**
   * 모달 닫기
   */
  /**
   * 문서 역사 클릭 핸들러
   */
  async handleHistoryClick(button) {
    const entityType = button.dataset.entityType;
    const entityId = button.dataset.entityId;

    if (!entityType || !entityId) {
      return;
    }

    this.currentEntity = { entityType, entityId };
    await this.openHistoryModal({ entityType, entityId });
  },

  /**
   * 문서 역사 모달 열기
   */
  async openHistoryModal({ entityType, entityId }) {
    // 모달 HTML 생성
    const modalHtml = this.createHistoryModalHtml({ entityType, entityId });
    
    // 모달을 body에 추가
    const modalContainer = document.createElement('div');
    modalContainer.innerHTML = modalHtml;
    const modal = modalContainer.firstElementChild;
    document.body.appendChild(modal);
    
    this.currentHistoryModal = modal;

    // 애니메이션
    setTimeout(() => {
      modal.classList.remove('opacity-0');
      modal.classList.add('opacity-100');
    }, 10);

    // 현재 엔티티 정보 저장
    this.currentHistoryEntity = { entityType, entityId };
    
    // Revision 목록 로드 (첫 페이지, 10개씩)
    await this.loadRevisions({ entityType, entityId, page: 1, limit: 10 });
  },

  /**
   * 문서 역사 모달 HTML 생성
   */
  createHistoryModalHtml({ entityType, entityId }) {
    const entityTypeLabel = entityType === 'job' ? '직업' : entityType === 'major' ? '전공' : '가이드';
    
    return `
      <div 
        class="fixed inset-0 z-[1000] flex items-center justify-center p-4 opacity-0 transition-opacity duration-200"
        data-history-modal-backdrop
      >
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" data-history-modal-backdrop></div>
        <div class="relative w-full max-w-4xl max-h-[90vh] bg-wiki-bg/95 border border-wiki-border/60 rounded-2xl shadow-2xl flex flex-col overflow-hidden">
          <!-- 헤더 -->
          <div class="flex items-center justify-between px-6 py-4 border-b border-wiki-border/60">
            <h2 class="text-xl font-bold text-white flex items-center gap-2">
              <i class="fas fa-history" aria-hidden="true"></i>
              역사
            </h2>
            <button 
              type="button" 
              class="text-wiki-muted hover:text-white transition p-2"
              data-history-modal-close
              aria-label="닫기"
            >
              <i class="fas fa-times text-lg" aria-hidden="true"></i>
            </button>
          </div>
          
          <!-- 내용 -->
          <div class="flex-1 overflow-y-auto px-6 py-4">
            <div id="history-loading" class="text-center py-8">
              <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-wiki-primary"></div>
              <p class="mt-4 text-wiki-muted">편집 이력을 불러오는 중...</p>
            </div>
            <div id="history-content" class="hidden">
              <!-- Revision 목록이 여기에 동적으로 추가됨 -->
            </div>
            <div id="history-error" class="hidden text-center py-8">
              <p class="text-red-400">편집 이력을 불러올 수 없습니다.</p>
            </div>
          </div>
        </div>
      </div>
    `;
  },

  /**
   * Revision 목록 로드
   */
  async loadRevisions({ entityType, entityId, page = 1, limit = 10 }) {
    const loadingEl = document.getElementById('history-loading');
    const contentEl = document.getElementById('history-content');
    const errorEl = document.getElementById('history-error');

    try {
      let endpoint;
      if (entityType === 'job') {
        endpoint = `${API_BASE}/job/${entityId}/revisions?limit=${limit}&offset=${(page - 1) * limit}`;
      } else if (entityType === 'major') {
        endpoint = `${API_BASE}/major/${entityId}/revisions?limit=${limit}&offset=${(page - 1) * limit}`;
      } else {
        throw new Error('지원하지 않는 엔티티 타입입니다.');
      }

      const response = await fetch(endpoint);
      const result = await response.json();

      if (!response.ok || !result.success) {
        throw new Error(result.error || '편집 이력을 불러올 수 없습니다.');
      }

      const { revisions, total } = result.data || { revisions: [], total: 0 };
      const totalPages = Math.ceil(total / limit);

      // 🆕 DB에서 이미 is_current = 1인 revision이 있으므로 가상의 현재 버전을 추가하지 않음
      // is_current = 1인 revision이 없으면 가상의 현재 버전 추가
      const hasCurrentRevision = revisions.some(r => r.isCurrent === true);
      let allRevisions = revisions;
      
      // revision이 없거나 현재 버전이 없으면 가상의 현재 버전 추가 (첫 페이지에서만)
      // revision이 없으면 항상 r1로 표시
      if ((revisions.length === 0 || !hasCurrentRevision) && page === 1) {
        // revision이 없으면 r1로 시작, 있으면 최대값 + 1
        const maxRevisionNumber = revisions.length > 0 
          ? Math.max(...revisions.map(r => r.revisionNumber || 0))
          : 0;
        const currentRevisionNumber = revisions.length === 0 ? 1 : maxRevisionNumber + 1;
        
        const currentRevision = {
          id: 'current',
          revisionNumber: currentRevisionNumber,
          isCurrent: true,
          editorName: '운영자',
          editorType: 'admin',
          changeSummary: '현재 버전',
          changedFields: [],
          createdAt: new Date().toISOString(),
          dataSnapshot: '{}'
        };
        allRevisions = [currentRevision, ...revisions];
      }

      // 캐시에 저장 (비교 기능에서 사용)
      this.cachedRevisions = allRevisions;
      
      // 로딩 숨기기
      if (loadingEl) loadingEl.classList.add('hidden');
      if (errorEl) errorEl.classList.add('hidden');
      if (contentEl) {
        contentEl.classList.remove('hidden');
        // 실제 편집 이력 수 계산 (현재 버전 제외)
        const actualRevisionCount = revisions.filter(r => r.id !== 'current').length
        const displayTotal = actualRevisionCount > 0 ? total : 0
        contentEl.innerHTML = this.renderRevisionsList(allRevisions, displayTotal, page, totalPages, limit);
      }
    } catch (error) {
      if (loadingEl) loadingEl.classList.add('hidden');
      if (contentEl) contentEl.classList.add('hidden');
      if (errorEl) {
        errorEl.classList.remove('hidden');
        errorEl.querySelector('p').textContent = error.message || '편집 이력을 불러올 수 없습니다.';
      }
    }
  },

  /**
   * Revision 목록 렌더링 (페이지네이션 포함)
   */
  renderRevisionsList(revisions, total, currentPage = 1, totalPages = 1, limit = 10) {
    // 실제 편집 이력이 없는 경우 (현재 버전만 있고 실제 revision이 없는 경우)
    const actualRevisions = revisions.filter(r => r.id !== 'current')
    const hasVirtualCurrent = revisions.some(r => r.id === 'current')
    
    // revision이 하나도 없고 가상의 현재 버전도 없을 때만 "아직 편집 이력이 없습니다" 표시
    if (!revisions || revisions.length === 0) {
      return `
        <div class="text-center py-8">
          <p class="text-wiki-muted">아직 편집 이력이 없습니다.</p>
        </div>
      `;
    }
    
    // 가상의 현재 버전이 있으면 표시 (r1로 표시됨)

    const revisionsHtml = revisions.map((rev, index) => {
      const date = new Date(rev.createdAt);
      const dateStr = date.toLocaleString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
      });

      const editorName = rev.editorName || '알 수 없음';
      const isCurrent = rev.isCurrent;
      
      // 편집자 프로필 이미지
      const editorPictureHtml = rev.editorPictureUrl
        ? `<img src="${this.escapeHtml(rev.editorPictureUrl)}" alt="${this.escapeHtml(editorName)}" class="w-5 h-5 rounded-full object-cover flex-shrink-0" />`
        : `<div class="w-5 h-5 rounded-full bg-wiki-card flex items-center justify-center flex-shrink-0"><i class="fas fa-user-circle text-xs text-wiki-muted"></i></div>`;

      return `
        <div class="border-b border-wiki-border/40 py-3 ${isCurrent ? 'bg-wiki-primary/5' : ''}">
          <div class="flex items-center gap-4">
            <!-- 왼쪽: r번호 + 현재버전 배지 (고정 너비로 배지 유무 상관없이 동일) -->
            <div class="flex items-center gap-2 w-36 shrink-0">
              <span class="text-sm font-mono text-wiki-primary w-6">r${rev.revisionNumber}</span>
              ${isCurrent ? '<span class="px-2 py-0.5 text-xs font-semibold rounded bg-wiki-primary/20 text-wiki-primary border border-wiki-primary/30">현재 버전</span>' : ''}
            </div>
            <!-- 중앙: 날짜 + 프로필 + 유저명 -->
            <div class="flex items-center gap-3 flex-1 min-w-0">
              <span class="text-sm text-wiki-muted shrink-0">${dateStr}</span>
              ${editorPictureHtml}
              <span class="text-sm text-white font-medium truncate">${this.escapeHtml(editorName)}</span>
            </div>
            <!-- 오른쪽: 버튼들 (grid로 고정 위치) -->
            <div class="grid grid-cols-2 gap-2 shrink-0" style="grid-template-columns: 64px 80px;">
              <div class="flex justify-end">
                ${rev.revisionNumber > 1 ? `
                  <button
                    type="button"
                    class="px-3 py-1.5 text-xs rounded-lg border border-wiki-border/60 bg-wiki-bg/40 hover:bg-wiki-bg/60 text-white transition whitespace-nowrap"
                    data-compare-revision="${rev.id}"
                    title="이전 버전과 비교"
                  >
                    <i class="fas fa-code-compare" aria-hidden="true"></i>
                    비교
                  </button>
                ` : ''}
              </div>
              <div class="flex justify-end">
                ${!isCurrent && rev.id !== 'current' ? `
                  <button
                    type="button"
                    class="px-3 py-1.5 text-xs rounded-lg border border-wiki-border/60 bg-wiki-bg/40 hover:bg-wiki-bg/60 text-white transition whitespace-nowrap"
                    data-restore-revision="${rev.id}"
                    title="이 버전으로 되돌리기"
                  >
                    <i class="fas fa-undo" aria-hidden="true"></i>
                    되돌리기
                  </button>
                ` : ''}
              </div>
            </div>
          </div>
        </div>
      `;
    }).join('');

    // 페이지네이션 HTML 생성
    let paginationHtml = '';
    if (totalPages > 1) {
      const paginationButtons = [];
      
      // 이전 페이지 버튼
      if (currentPage > 1) {
        paginationButtons.push(`
          <button
            type="button"
            class="px-3 py-1.5 text-sm rounded-lg border border-wiki-border/60 bg-wiki-bg/40 hover:bg-wiki-bg/60 text-white transition"
            data-history-page="${currentPage - 1}"
            title="이전 페이지"
          >
            <i class="fas fa-chevron-left" aria-hidden="true"></i>
          </button>
        `);
      }
      
      // 페이지 번호 버튼들
      const startPage = Math.max(1, currentPage - 2);
      const endPage = Math.min(totalPages, currentPage + 2);
      
      if (startPage > 1) {
        paginationButtons.push(`
          <button
            type="button"
            class="px-3 py-1.5 text-sm rounded-lg border border-wiki-border/60 bg-wiki-bg/40 hover:bg-wiki-bg/60 text-white transition"
            data-history-page="1"
          >
            1
          </button>
        `);
        if (startPage > 2) {
          paginationButtons.push(`<span class="px-2 text-wiki-muted">...</span>`);
        }
      }
      
      for (let i = startPage; i <= endPage; i++) {
        const isActive = i === currentPage;
        paginationButtons.push(`
          <button
            type="button"
            class="px-3 py-1.5 text-sm rounded-lg transition ${
              isActive
                ? 'bg-wiki-primary text-white border border-wiki-primary'
                : 'border border-wiki-border/60 bg-wiki-bg/40 hover:bg-wiki-bg/60 text-white'
            }"
            data-history-page="${i}"
          >
            ${i}
          </button>
        `);
      }
      
      if (endPage < totalPages) {
        if (endPage < totalPages - 1) {
          paginationButtons.push(`<span class="px-2 text-wiki-muted">...</span>`);
        }
        paginationButtons.push(`
          <button
            type="button"
            class="px-3 py-1.5 text-sm rounded-lg border border-wiki-border/60 bg-wiki-bg/40 hover:bg-wiki-bg/60 text-white transition"
            data-history-page="${totalPages}"
          >
            ${totalPages}
          </button>
        `);
      }
      
      // 다음 페이지 버튼
      if (currentPage < totalPages) {
        paginationButtons.push(`
          <button
            type="button"
            class="px-3 py-1.5 text-sm rounded-lg border border-wiki-border/60 bg-wiki-bg/40 hover:bg-wiki-bg/60 text-white transition"
            data-history-page="${currentPage + 1}"
            title="다음 페이지"
          >
            <i class="fas fa-chevron-right" aria-hidden="true"></i>
          </button>
        `);
      }
      
      paginationHtml = `
        <div class="flex items-center justify-between px-6 py-4 border-t border-wiki-border/60">
          <div class="text-sm text-wiki-muted">
            총 ${total}개 중 ${(currentPage - 1) * limit + 1}-${Math.min(currentPage * limit, total)}개 표시
          </div>
          <div class="flex items-center gap-2">
            ${paginationButtons.join('')}
          </div>
        </div>
      `;
    }

    return `
      <div class="space-y-0">
        <div class="mb-4 pb-2 border-b border-wiki-border/60">
          <p class="text-sm text-wiki-muted">총 ${total}개의 편집 이력</p>
        </div>
        ${revisionsHtml}
      </div>
      ${paginationHtml}
    `;
  },

  /**
   * 변경량 계산 (간단한 추정)
   */
  calculateChangeSize(revision) {
    // dataSnapshot의 크기를 기반으로 변경량 추정
    try {
      const snapshot = JSON.parse(revision.dataSnapshot || '{}');
      const snapshotSize = JSON.stringify(snapshot).length;
      
      // 이전 revision과 비교하여 변경량 계산 (간단한 추정)
      // 실제로는 이전 revision의 snapshot과 비교해야 하지만,
      // 여기서는 snapshot 크기만으로 추정
      return snapshotSize > 1000 ? snapshotSize - 1000 : 0;
    } catch {
      return null;
    }
  },

  /**
   * 편집자 타입 라벨
   */
  getEditorTypeLabel(type) {
    const labels = {
      'anonymous': '익명',
      'user': '사용자',
      'expert': '전문가',
      'admin': '관리자',
      'system': '시스템'
    };
    return labels[type] || type;
  },

  /**
   * 문서 역사 모달 닫기
   */
  closeHistoryModal() {
    if (!this.currentHistoryModal) return;

    // 애니메이션
    this.currentHistoryModal.classList.remove('opacity-100');
    this.currentHistoryModal.classList.add('opacity-0');

    setTimeout(() => {
      if (this.currentHistoryModal && this.currentHistoryModal.parentNode) {
        this.currentHistoryModal.parentNode.removeChild(this.currentHistoryModal);
      }
      this.currentHistoryModal = null;
      this.currentHistoryEntity = null; // 엔티티 정보도 초기화
    }, 200);
  },

  /**
   * 되돌리기 처리
   */
  async handleRestoreRevision(revisionId) {
    if (!revisionId) return;
    
    // revisionId가 'current'인 경우 처리하지 않음
    if (revisionId === 'current') {
      alert('현재 버전으로는 되돌릴 수 없습니다.');
      return;
    }

    const confirmed = confirm('이 버전으로 되돌리시겠습니까? 현재 버전도 이력에 저장됩니다.');
    if (!confirmed) return;

    try {
      // revisionId가 숫자가 아닌 경우 처리
      const numericRevisionId = parseInt(revisionId, 10);
      if (isNaN(numericRevisionId) || numericRevisionId <= 0) {
        throw new Error('유효하지 않은 revision ID입니다.');
      }
      
      const response = await fetch(`${API_BASE}/revision/${numericRevisionId}/restore`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
      });

      const result = await response.json();

      if (!response.ok || !result.success) {
        // 에러 메시지 처리
        let errorMessage = result.error || '되돌리기에 실패했습니다.';
        if (result.error === 'PASSWORD_REQUIRED') {
          const password = prompt('이 편집은 비밀번호가 필요합니다. 비밀번호를 입력하세요:');
          if (password) {
            // 비밀번호와 함께 다시 시도
            const retryResponse = await fetch(`${API_BASE}/revision/${numericRevisionId}/restore`, {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json'
              },
              body: JSON.stringify({ password })
            });
            const retryResult = await retryResponse.json();
            if (!retryResponse.ok || !retryResult.success) {
              throw new Error(retryResult.error || '비밀번호가 올바르지 않습니다.');
            }
            // 성공 시 아래 코드로 진행
          } else {
            throw new Error('비밀번호가 필요합니다.');
          }
        } else {
          throw new Error(errorMessage);
        }
      }

      alert('되돌리기가 완료되었습니다.');
      this.closeHistoryModal();
      
      // 페이지 전체 새로고침하여 변경사항 반영 (캐시 우회)
      window.location.reload();
    } catch (error) {
      alert(error.message || '되돌리기에 실패했습니다.');
    }
  },

  /**
   * 비교 처리 (선택한 버전과 바로 이전 버전 비교)
   */
  async handleCompareRevision(revisionId) {
    if (!revisionId) return;

    const { entityType, entityId } = this.currentHistoryEntity || {};
    if (!entityType || !entityId) {
      alert('엔티티 정보를 찾을 수 없습니다.');
      return;
    }

    try {
      // 로딩 표시
      const loadingModal = this.createCompareModalHtml({ loading: true });
      const loadingContainer = document.createElement('div');
      loadingContainer.innerHTML = loadingModal;
      const loadingElement = loadingContainer.firstElementChild;
      document.body.appendChild(loadingElement);
      
      // 'current' (현재 버전)인 경우 특별 처리
      if (revisionId === 'current') {
        // 현재 edit-data 가져오기
        const currentEndpoint = entityType === 'job' 
          ? `${API_BASE}/job/${entityId}/edit-data`
          : `${API_BASE}/major/${entityId}/edit-data`;
        
        const currentResponse = await fetch(currentEndpoint);
        const currentResult = await currentResponse.json();
        
        if (!currentResponse.ok || !currentResult.success) {
          throw new Error('현재 데이터를 불러올 수 없습니다.');
        }
        
        // 이전 버전 (가장 최근 DB revision) 찾기
        const cachedDbRevisions = (this.cachedRevisions || []).filter(r => r.id !== 'current');
        if (cachedDbRevisions.length === 0) {
          if (loadingElement && loadingElement.parentNode) {
            loadingElement.parentNode.removeChild(loadingElement);
          }
          alert('이전 버전이 없습니다.');
          return;
        }
        
        const previousRevision = cachedDbRevisions[0]; // 가장 최근 DB revision
        
        // 이전 버전 데이터 가져오기
        const prevResponse = await fetch(`${API_BASE}/revision/${previousRevision.id}?fullData=true&formatForEdit=true`);
        const prevResult = await prevResponse.json();
        
        if (!prevResponse.ok || !prevResult.success) {
          throw new Error('이전 버전 데이터를 불러올 수 없습니다.');
        }
        
        const prevRevisionFull = prevResult.data;
        let previousRevisionData = prevRevisionFull.editFormattedData || prevRevisionFull.fullData;
        if (!previousRevisionData) {
          try {
            const snapshot = JSON.parse(prevRevisionFull.dataSnapshot);
            if (snapshot.changedFields !== undefined && snapshot.changes) {
              previousRevisionData = snapshot.changes;
            } else {
              previousRevisionData = snapshot;
            }
          } catch {
            previousRevisionData = {};
          }
        }
        
        // 로딩 모달 제거
        if (loadingElement && loadingElement.parentNode) {
          loadingElement.parentNode.removeChild(loadingElement);
        }
        
        // 현재 버전의 가상 revision 객체 생성
        const currentRevisionInfo = this.cachedRevisions?.find(r => r.id === 'current') || {
          revisionNumber: (previousRevision.revisionNumber || 0) + 1,
          editorName: '현재 상태',
          createdAt: new Date().toISOString(),
          changedFields: []
        };
        
        // 비교 모달 표시
        const compareModal = this.createCompareModalHtml({
          currentData: currentResult.data,
          revisionData: previousRevisionData,
          revision: currentRevisionInfo,
          previousRevision: previousRevision,
          comparePrevious: true
        });
        const modalContainer = document.createElement('div');
        modalContainer.innerHTML = compareModal;
        const modalElement = modalContainer.firstElementChild;
        document.body.appendChild(modalElement);
        
        setTimeout(() => {
          modalElement.classList.remove('opacity-0');
          modalElement.classList.add('opacity-100');
        }, 10);
        
        const closeBtn = modalElement.querySelector('[data-compare-modal-close]');
        const backdrop = modalElement.querySelector('[data-compare-modal-backdrop]');
        if (closeBtn) {
          closeBtn.addEventListener('click', () => this.closeCompareModal(modalElement));
        }
        if (backdrop) {
          backdrop.addEventListener('click', (e) => {
            if (e.target === backdrop) this.closeCompareModal(modalElement);
          });
        }
        return;
      }
      
      // 일반 revision 처리
      const numericRevisionId = parseInt(revisionId, 10);
      if (isNaN(numericRevisionId) || numericRevisionId <= 0) {
        throw new Error('유효하지 않은 revision ID입니다.');
      }
      
      const revisionResponse = await fetch(`${API_BASE}/revision/${numericRevisionId}?fullData=true&formatForEdit=true`);
      const revisionResult = await revisionResponse.json();
      
      if (!revisionResponse.ok || !revisionResult.success) {
        throw new Error('Revision 데이터를 불러올 수 없습니다.');
      }
      
      const revision = revisionResult.data;
      
      // r1 (첫 번째 버전)인 경우 비교 불가
      if (revision.revisionNumber === 1) {
        if (loadingElement && loadingElement.parentNode) {
          loadingElement.parentNode.removeChild(loadingElement);
        }
        alert('첫 번째 버전은 이전 버전이 없어 비교할 수 없습니다.');
        return;
      }
      
      // dataSnapshot에서 changes와 previousValues 추출 시도
      let currentRevisionData = null;
      let previousRevisionData = null;
      let useDeltaComparison = false;
      
      try {
        const snapshot = JSON.parse(revision.dataSnapshot);
        
        // 변경사항만 저장된 경우 (changes + previousValues)
        if (snapshot.changedFields !== undefined && snapshot.changes) {
          currentRevisionData = snapshot.changes;  // 새 값
          previousRevisionData = snapshot.previousValues || {};  // 이전 값
          useDeltaComparison = true;
        } else {
          // 전체 스냅샷인 경우
          currentRevisionData = snapshot;
        }
      } catch (error) {
      }
      
      // editFormattedData나 fullData가 있으면 우선 사용 (전체 데이터 비교)
      if (!useDeltaComparison && (revision.editFormattedData || revision.fullData)) {
        currentRevisionData = revision.editFormattedData || revision.fullData;
      }
      
      // delta 비교가 가능하면 이전 버전 조회 불필요
      let previousRevision = null;
      if (useDeltaComparison) {
        // previousValues가 있으므로 이전 revision 조회 불필요
        // 가상의 previousRevision 객체 생성
        previousRevision = {
          revisionNumber: revision.revisionNumber - 1,
          editorName: '이전 버전',
          createdAt: revision.createdAt
        };
      } else {
        // 전체 데이터 비교가 필요한 경우 이전 버전 조회
        // 현재 로드된 revisions에서 이전 버전 찾기
        if (this.cachedRevisions && this.cachedRevisions.length > 0) {
          const currentIdx = this.cachedRevisions.findIndex(r => r.id === numericRevisionId);
          if (currentIdx >= 0 && currentIdx < this.cachedRevisions.length - 1) {
            previousRevision = this.cachedRevisions[currentIdx + 1];
          }
        }
      }
      
      // delta 비교 모드가 아니면 이전 버전 데이터 조회 필요
      if (!useDeltaComparison) {
        // 이전 버전이 없으면 API로 조회 (revisionNumber - 1)
        if (!previousRevision) {
          const prevRevisionNumber = revision.revisionNumber - 1;
          // revision 목록에서 해당 revisionNumber 찾기
          const revisionsEndpoint = entityType === 'job' 
            ? `${API_BASE}/job/${entityId}/revisions`
            : `${API_BASE}/major/${entityId}/revisions`;
          
          const revisionsResponse = await fetch(revisionsEndpoint);
          const revisionsResult = await revisionsResponse.json();
          
          if (revisionsResponse.ok && revisionsResult.success) {
            previousRevision = revisionsResult.data.revisions.find(r => r.revisionNumber === prevRevisionNumber);
          }
        }
        
        if (!previousRevision) {
          if (loadingElement && loadingElement.parentNode) {
            loadingElement.parentNode.removeChild(loadingElement);
          }
          alert('이전 버전을 찾을 수 없습니다.');
          return;
        }
        
        // 이전 버전 데이터 가져오기
        const prevResponse = await fetch(`${API_BASE}/revision/${previousRevision.id}?fullData=true&formatForEdit=true`);
        const prevResult = await prevResponse.json();
        
        if (!prevResponse.ok || !prevResult.success) {
          throw new Error('이전 버전 데이터를 불러올 수 없습니다.');
        }
        
        const prevRevisionFull = prevResult.data;
        previousRevisionData = prevRevisionFull.editFormattedData || prevRevisionFull.fullData;
        if (!previousRevisionData) {
          try {
            const snapshot = JSON.parse(prevRevisionFull.dataSnapshot);
            if (snapshot.changedFields !== undefined && snapshot.changes) {
              previousRevisionData = snapshot.changes;
            } else if (snapshot.changedFields === undefined) {
              previousRevisionData = snapshot;
            } else {
              previousRevisionData = {};
            }
          } catch (error) {
            previousRevisionData = {};
          }
        }
      }
      
      // 로딩 모달 제거
      if (loadingElement && loadingElement.parentNode) {
        loadingElement.parentNode.removeChild(loadingElement);
      }
      
      // 비교 모달 표시 (이전 버전 vs 선택한 버전)
      const compareModal = this.createCompareModalHtml({
        currentData: currentRevisionData,  // 선택한 버전 (새 버전)
        revisionData: previousRevisionData, // 이전 버전 (구 버전)
        revision: revision,
        previousRevision: previousRevision,
        comparePrevious: true  // 이전 버전과 비교 플래그
      });
      const modalContainer = document.createElement('div');
      modalContainer.innerHTML = compareModal;
      const modalElement = modalContainer.firstElementChild;
      document.body.appendChild(modalElement);
      
      // 애니메이션
      setTimeout(() => {
        modalElement.classList.remove('opacity-0');
        modalElement.classList.add('opacity-100');
      }, 10);
      
      // 모달 닫기 이벤트 리스너
      const closeBtn = modalElement.querySelector('[data-compare-modal-close]');
      const backdrop = modalElement.querySelector('[data-compare-modal-backdrop]');
      
      if (closeBtn) {
        closeBtn.addEventListener('click', () => {
          this.closeCompareModal(modalElement);
        });
      }
      
      if (backdrop) {
        backdrop.addEventListener('click', (e) => {
          if (e.target === backdrop) {
            this.closeCompareModal(modalElement);
          }
        });
      }
      
    } catch (error) {
      alert(error.message || '비교 중 오류가 발생했습니다.');
      
      // 로딩 모달 제거
      const loadingModal = document.querySelector('[data-compare-modal-backdrop]');
      if (loadingModal && loadingModal.parentNode) {
        loadingModal.parentNode.removeChild(loadingModal);
      }
    }
  },
  
  /**
   * 비교 모달 HTML 생성
   */
  createCompareModalHtml({ loading = false, currentData = null, revisionData = null, revision = null, previousRevision = null, comparePrevious = false }) {
    if (loading) {
      return `
        <div 
          class="fixed inset-0 z-[1001] flex items-center justify-center p-4 opacity-0 transition-opacity duration-200"
          data-compare-modal-backdrop
        >
          <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" data-compare-modal-backdrop></div>
          <div class="relative w-full max-w-6xl max-h-[90vh] bg-wiki-bg/95 border border-wiki-border/60 rounded-2xl shadow-2xl">
            <div class="flex items-center justify-center py-20">
              <div class="text-center">
                <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-wiki-primary mx-auto mb-4"></div>
                <p class="text-wiki-muted">비교 데이터를 불러오는 중...</p>
              </div>
            </div>
          </div>
        </div>
      `;
    }
    
    if (!currentData || !revisionData || !revision) {
      return '';
    }
    
    // 필드 비교 - 모든 필드를 비교하여 실제 차이가 있는 것만 표시
    const fields = this.getEditableFields(this.currentHistoryEntity?.entityType || 'job');
    
    // 값을 배열로 변환하는 함수
    const toArray = (val) => {
      if (val === null || val === undefined) return [];
      if (typeof val === 'function') return [];
      if (Array.isArray(val)) {
        return val.filter(v => v !== null && v !== undefined && typeof v !== 'function').map(v => {
          if (typeof v === 'object') return v.name || v.title || JSON.stringify(v);
          return String(v).trim();
        }).filter(s => s.length > 0); // 빈 문자열만 필터링, 한 글자는 OK
      }
      if (typeof val === 'object') {
        if (val.name) return [val.name];
        if (val.title) return [val.title];
        return [];
      }
      // 문자열인 경우 줄바꿈 또는 쉼표로 분리
      const str = String(val).trim();
      if (!str) return [];
      if (str.includes('\n')) return str.split('\n').map(s => s.trim()).filter(s => s.length > 0);
      if (str.includes(',')) return str.split(',').map(s => s.trim()).filter(s => s.length > 0);
      return [str];
    };
    
    // 값을 보기 좋게 변환하는 함수
    const formatValue = (val) => {
      const arr = toArray(val);
      return arr.join(', ');
    };
    
    // 비교용 정규화 함수
    const normalizeForCompare = (val) => {
      const arr = toArray(val);
      return arr.map(s => s.toLowerCase().replace(/\s+/g, ' ').trim()).sort().join('|');
    };
    
    // diff 계산 함수 (추가/삭제/유지 구분)
    const calculateDiff = (newVal, oldVal) => {
      const newArr = toArray(newVal);
      const oldArr = toArray(oldVal);
      
      const newSet = new Set(newArr.map(s => s.toLowerCase().trim()));
      const oldSet = new Set(oldArr.map(s => s.toLowerCase().trim()));
      
      const added = newArr.filter(item => !oldSet.has(item.toLowerCase().trim()));
      const removed = oldArr.filter(item => !newSet.has(item.toLowerCase().trim()));
      const kept = newArr.filter(item => oldSet.has(item.toLowerCase().trim()));
      
      return { added, removed, kept, newArr, oldArr };
    };
    
    
    const comparisons = fields.map(field => {
      // 둘 다 동일한 방식으로 값 추출
      let currentValue = this.getFieldValue(currentData, field.key);
      let revisionValue = this.getFieldValue(revisionData, field.key);
      
      // 디버그 로그 (overview.summary 등 주요 필드만)
      if (field.key.includes('overview') || field.key === 'property' || field.key === 'aptitude') {
      }
      
      const currentStr = normalizeForCompare(currentValue);
      const revisionStr = normalizeForCompare(revisionValue);
      const isChanged = currentStr !== revisionStr;
      
      // diff 계산
      const diff = calculateDiff(currentValue, revisionValue);
      
      return {
        ...field,
        currentValue: currentValue,
        revisionValue: revisionValue,
        diff,
        isChanged
      };
    }).filter(comp => {
      // 변경된 필드만 표시
      return comp.isChanged && (comp.diff.newArr.length > 0 || comp.diff.oldArr.length > 0);
    });
    
    // 변경된 필드가 있는지 확인
    const hasChanges = comparisons.some(comp => comp.isChanged);
    
    const revisionDate = new Date(revision.createdAt);
    const revisionDateStr = revisionDate.toLocaleString('ko-KR', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    });
    
    // 이전 버전 날짜 (comparePrevious 모드일 때)
    let prevRevisionDateStr = '';
    if (previousRevision) {
      const prevDate = new Date(previousRevision.createdAt);
      prevRevisionDateStr = prevDate.toLocaleString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
      });
    }
    
    // 헤더 레이블 설정
    const leftHeader = comparePrevious 
      ? { title: `r${revision.revisionNumber} (선택한 버전)`, subtitle: `${revisionDateStr} · ${this.escapeHtml(revision.editorName || '알 수 없음')}`, color: 'text-wiki-primary' }
      : { title: '현재 버전', subtitle: '최신 데이터', color: 'text-wiki-primary' };
    const rightHeader = comparePrevious && previousRevision
      ? { title: `r${previousRevision.revisionNumber} (이전 버전)`, subtitle: `${prevRevisionDateStr} · ${this.escapeHtml(previousRevision.editorName || '알 수 없음')}`, color: 'text-wiki-muted' }
      : { title: `r${revision.revisionNumber}`, subtitle: `${revisionDateStr} · ${this.escapeHtml(revision.editorName || '알 수 없음')}`, color: 'text-wiki-muted' };
    
    return `
      <div 
        class="fixed inset-0 z-[1001] flex items-center justify-center p-4 opacity-0 transition-opacity duration-200"
        data-compare-modal-backdrop
      >
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" data-compare-modal-backdrop></div>
        <div class="relative w-full max-w-6xl max-h-[90vh] bg-wiki-bg/95 border border-wiki-border/60 rounded-2xl shadow-2xl flex flex-col overflow-hidden">
          <!-- 헤더 -->
          <div class="flex items-center justify-between px-6 py-4 border-b border-wiki-border/60 flex-shrink-0">
            <h2 class="text-xl font-bold text-white flex items-center gap-2">
              <i class="fas fa-code-compare" aria-hidden="true"></i>
              버전 비교 ${comparePrevious ? `(r${previousRevision?.revisionNumber || '?'} → r${revision.revisionNumber})` : ''}
            </h2>
            <button 
              type="button" 
              class="text-wiki-muted hover:text-white transition p-2"
              data-compare-modal-close
              aria-label="닫기"
            >
              <i class="fas fa-times text-lg" aria-hidden="true"></i>
            </button>
          </div>
          
          <!-- 비교 헤더 -->
          <div class="px-6 py-3 border-b border-wiki-border/60 bg-wiki-bg/50 flex-shrink-0">
            <div class="grid grid-cols-2 gap-4">
              <div>
                <h3 class="text-sm font-semibold ${leftHeader.color} mb-1">${leftHeader.title}</h3>
                <p class="text-xs text-wiki-muted">${leftHeader.subtitle}</p>
              </div>
              <div>
                <h3 class="text-sm font-semibold ${rightHeader.color} mb-1">${rightHeader.title}</h3>
                <p class="text-xs text-wiki-muted">${rightHeader.subtitle}</p>
              </div>
            </div>
          </div>
          
          <!-- 비교 내용 -->
          <div class="flex-1 overflow-y-auto px-6 py-4">
            ${!hasChanges ? `
              <div class="text-center py-12">
                <div class="mb-4">
                  <i class="fas fa-check-circle text-green-400 text-4xl mb-3"></i>
                </div>
                <p class="text-white text-lg font-semibold mb-2">${comparePrevious ? '이전 버전과 동일합니다' : '현재 버전과 동일합니다'}</p>
                <p class="text-wiki-muted text-sm">${comparePrevious ? '선택한 버전과 이전 버전 사이에 변경사항이 없습니다.' : '이 revision과 현재 버전 사이에는 변경사항이 없습니다.'}</p>
              </div>
            ` : comparisons.length === 0 ? `
              <div class="text-center py-12">
                <p class="text-wiki-muted">변경된 필드가 없습니다.</p>
              </div>
            ` : `
              <div class="space-y-6">
                ${comparisons.filter(comp => comp.isChanged).map(comp => {
                  const diff = comp.diff;
                  
                  // 변경 후 표시 (추가된 것은 녹색 하이라이트)
                  const renderNewValue = () => {
                    if (diff.newArr.length === 0) return '<span class="text-wiki-muted italic">내용 없음</span>';
                    return diff.newArr.map(item => {
                      const isAdded = diff.added.some(a => a.toLowerCase().trim() === item.toLowerCase().trim());
                      if (isAdded) {
                        return '<span class="inline-block px-2 py-0.5 rounded bg-green-500/30 text-green-300 font-semibold mr-1 mb-1">' + this.escapeHtml(item) + ' <i class="fas fa-plus text-xs ml-1"></i></span>';
                      }
                      return '<span class="inline-block px-2 py-0.5 rounded bg-wiki-bg/50 text-white mr-1 mb-1">' + this.escapeHtml(item) + '</span>';
                    }).join('');
                  };
                  
                  // 변경 전 표시 (삭제된 것은 취소선 + 빨간색)
                  const renderOldValue = () => {
                    if (diff.oldArr.length === 0) return '<span class="text-wiki-muted italic">내용 없음</span>';
                    return diff.oldArr.map(item => {
                      const isRemoved = diff.removed.some(r => r.toLowerCase().trim() === item.toLowerCase().trim());
                      if (isRemoved) {
                        return '<span class="inline-block px-2 py-0.5 rounded bg-red-500/30 text-red-300 line-through mr-1 mb-1">' + this.escapeHtml(item) + ' <i class="fas fa-minus text-xs ml-1"></i></span>';
                      }
                      return '<span class="inline-block px-2 py-0.5 rounded bg-wiki-bg/50 text-white mr-1 mb-1">' + this.escapeHtml(item) + '</span>';
                    }).join('');
                  };
                  
                  // 변경 요약
                  const summaryParts = [];
                  if (diff.added.length > 0) summaryParts.push('<span class="text-green-400"><i class="fas fa-plus mr-1"></i>' + diff.added.length + '개 추가</span>');
                  if (diff.removed.length > 0) summaryParts.push('<span class="text-red-400"><i class="fas fa-minus mr-1"></i>' + diff.removed.length + '개 삭제</span>');
                  if (diff.kept.length > 0) summaryParts.push('<span class="text-wiki-muted">' + diff.kept.length + '개 유지</span>');
                  const summary = summaryParts.join(' · ');
                  
                  return `
                  <div class="border border-wiki-border/40 rounded-xl overflow-hidden">
                    <!-- 필드명 헤더 -->
                    <div class="bg-wiki-primary/10 px-4 py-2 border-b border-wiki-border/40 flex items-center justify-between">
                      <h4 class="text-sm font-bold text-wiki-primary">${this.escapeHtml(comp.label)}</h4>
                      <div class="text-xs">${summary}</div>
                    </div>
                    
                    <div class="p-4 space-y-4">
                      <!-- 변경 후 (새 값) -->
                      <div>
                        <div class="flex items-center gap-2 mb-2">
                          <span class="px-2 py-0.5 text-xs font-semibold rounded bg-green-500/20 text-green-400 border border-green-500/30">변경 후</span>
                          <span class="text-xs text-wiki-muted">r${revision.revisionNumber}</span>
                        </div>
                        <div class="px-4 py-3 rounded-lg bg-green-500/5 border border-green-500/30 text-sm leading-relaxed flex flex-wrap">
                          ${renderNewValue()}
                        </div>
                      </div>
                      
                      <!-- 화살표 -->
                      <div class="flex justify-center">
                        <i class="fas fa-arrow-up text-wiki-muted"></i>
                      </div>
                      
                      <!-- 변경 전 (이전 값) -->
                      <div>
                        <div class="flex items-center gap-2 mb-2">
                          <span class="px-2 py-0.5 text-xs font-semibold rounded bg-red-500/20 text-red-400 border border-red-500/30">변경 전</span>
                          <span class="text-xs text-wiki-muted">r${(revision.revisionNumber || 1) - 1}</span>
                        </div>
                        <div class="px-4 py-3 rounded-lg bg-red-500/5 border border-red-500/30 text-sm leading-relaxed flex flex-wrap">
                          ${renderOldValue()}
                        </div>
                      </div>
                    </div>
                  </div>
                `;
                }).join('')}
              </div>
            `}
          </div>
        </div>
      </div>
    `;
  },
  
  /**
   * 비교 모달 닫기
   */
  closeCompareModal(modalElement) {
    if (!modalElement) return;
    
    modalElement.classList.remove('opacity-100');
    modalElement.classList.add('opacity-0');
    
    setTimeout(() => {
      if (modalElement && modalElement.parentNode) {
        modalElement.parentNode.removeChild(modalElement);
      }
    }, 200);
  },
  
  /**
   * 편집 가능한 필드 목록 가져오기
   */
  getEditableFields(entityType) {
    if (entityType === 'job') {
      return [
        // 히어로 섹션
        { key: 'name', label: '직업명', type: 'text' },
        { key: 'summary', label: '직업 설명', type: 'textarea' },
        { key: 'heroTags', label: '태그', type: 'tags' },
        { key: 'heroCategory', label: '직업 분류', type: 'text' },
        // 개요
        { key: 'overviewWork.main', label: '수행 직무', type: 'textarea' },
        { key: 'overviewAbilities.abilityList', label: '핵심 역량', type: 'tags' },
        { key: 'overviewAbilities.technKnow', label: '활용 기술', type: 'textarea' },
        { key: 'overviewAptitude.aptitudeList', label: '적성', type: 'tags' },
        { key: 'overviewAptitude.interestList', label: '흥미', type: 'tags' },
        { key: 'trivia', label: '여담', type: 'textarea' },
        // 상세정보 - 직업 준비하기
        { key: 'detailReady.curriculum', label: '정규 교육과정', type: 'list' },
        { key: 'detailReady.recruit', label: '채용 정보', type: 'list' },
        { key: 'detailReady.training', label: '필요 교육/훈련', type: 'list' },
        { key: 'detailReady.researchList', label: '진로 탐색 활동', type: 'list' },
        // 사이드바
        { key: 'sidebarJobs', label: '관련 직업', type: 'autocomplete' },
        { key: 'sidebarMajors', label: '관련 학과', type: 'autocomplete' },
        { key: 'sidebarCerts', label: '추천 자격증', type: 'tags' },
        // 기존 필드 (호환성)
        { key: 'duties', label: '주요 업무 (기존)', type: 'textarea' },
        { key: 'way', label: '되는 방법', type: 'textarea' },
        { key: 'salary', label: '임금 정보', type: 'text' },
        { key: 'prospect', label: '직업 전망', type: 'textarea' },
        { key: 'satisfaction', label: '직업 만족도', type: 'textarea' },
        { key: 'abilities', label: '업무수행능력', type: 'textarea' },
        { key: 'knowledge', label: '필요 지식', type: 'textarea' },
        { key: 'environment', label: '업무 환경', type: 'textarea' },
        { key: 'personality', label: '직업 성격', type: 'textarea' },
        { key: 'interests', label: '직업 흥미', type: 'textarea' },
        { key: 'values', label: '직업 가치관', type: 'textarea' },
        { key: 'technKnow', label: '기술 지식', type: 'textarea' },
        { key: 'aptitude', label: '적성 (기존)', type: 'textarea' }
      ];
    } else if (entityType === 'major') {
      return [
        // 히어로 섹션
        { key: 'name', label: '전공명', type: 'text' },
        { key: 'summary', label: '전공 설명', type: 'textarea' },
        { key: 'heroTags', label: '관련 학과 태그', type: 'tags' },
        { key: 'categoryName', label: '계열', type: 'text' },
        // 개요
        { key: 'overview.summary', label: '전공 개요', type: 'textarea' },
        { key: 'property', label: '전공 특성', type: 'textarea' },
        { key: 'aptitude', label: '이 전공에 어울리는 사람', type: 'textarea' },
        { key: 'enterField', label: '졸업 후 진출 분야', type: 'pairList' },
        { key: 'jobProspect', label: '여담', type: 'list' },
        // 상세정보
        { key: 'whatStudy', label: '배우는 내용', type: 'textarea' },
        { key: 'mainSubject', label: '주요 교과목', type: 'tags' },
        { key: 'relateSubject', label: '고교 추천 교과목', type: 'tags' },
        { key: 'careerAct', label: '진로 탐색 활동', type: 'pairList' },
        // 사이드바
        { key: 'sidebarJobs', label: '관련 직업', type: 'autocomplete' },
        { key: 'sidebarMajors', label: '관련 전공', type: 'autocomplete' },
        { key: 'sidebarHowtos', label: '관련 HowTo', type: 'autocomplete' }
      ];
    }
    return [];
  },
  
  /**
   * Revision 데이터에서 필드 값 추출
   * 배열은 그대로 반환, null/undefined는 빈 값으로 변환
   */
  getFieldValue(revisionData, fieldKey) {
    if (!revisionData || typeof revisionData !== 'object') {
      return '';
    }
    
    // 1. flat 키로 직접 접근 (예: 'overview.summary' 문자열 키)
    if (revisionData[fieldKey] !== undefined) {
      const value = revisionData[fieldKey];
      if (value === null || value === undefined) return '';
      if (Array.isArray(value)) return value;
      return value;
    }
    
    // 2. nested 경로로 접근 (예: overview.summary → revisionData.overview.summary)
    if (fieldKey.includes('.')) {
      const parts = fieldKey.split('.');
      let current = revisionData;
      for (const part of parts) {
        if (current && typeof current === 'object' && part in current) {
          current = current[part];
        } else {
          current = undefined;
          break;
        }
      }
      if (current !== undefined) {
        if (current === null) return '';
        if (Array.isArray(current)) return current;
        return current;
      }
    }
    
    // 3. 중첩된 객체 내부에서 찾기 (원본 구조인 경우를 위한 fallback)
    for (const key in revisionData) {
      if (typeof revisionData[key] === 'object' && revisionData[key] !== null) {
        if (revisionData[key][fieldKey] !== undefined) {
          const value = revisionData[key][fieldKey];
          if (value === null || value === undefined) return '';
          if (Array.isArray(value)) return value;
          return value;
        }
      }
    }
    
    return '';
  },

  closeModal() {
    if (!this.currentModal) return;

    // 애니메이션
    this.currentModal.classList.remove('opacity-100');
    this.currentModal.classList.add('opacity-0');
    const dialog = this.currentModal.querySelector('[data-edit-modal-dialog]');
    if (dialog) {
      dialog.classList.remove('scale-100');
      dialog.classList.add('scale-95');
    }

    // DOM에서 제거
    setTimeout(() => {
      if (this.currentModal && this.currentModal.parentNode) {
        this.currentModal.parentNode.removeChild(this.currentModal);
      }
      this.currentModal = null;
      this.currentEntity = null;
    }, 200);
  },

  /**
   * HTML 이스케이프
   */
  escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
  }
};

// 페이지 로드 시 편집 시스템 초기화
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => EditSystem.init());
} else {
  EditSystem.init();
}

// API 호출 함수들
const CareerAPI = {
  // 학과 검색
  async searchMajors(keyword = '', page = 1, perPage = 20, options = {}) {
    try {
      const params = new URLSearchParams({
        keyword,
        page: String(page),
        perPage: String(perPage)
      });

      if (options.sources && options.sources.length) {
        params.set('sources', options.sources.join(','));
      }

      const response = await fetch(`${API_BASE}/majors?${params}`);
      const payload = await response.json();

      if (!payload.success) {
        throw new Error(payload.error || '학과 검색 실패');
      }

      return {
        items: Array.isArray(payload.data) ? payload.data : [],
        meta: payload.meta || {}
      };
    } catch (error) {
      return {
        items: [],
        meta: {
          error: error instanceof Error ? error.message : '학과 검색 실패'
        }
      };
    }
  },

  // 학과 상세 정보
  async getMajorDetail(id, options = {}) {
    try {
      if (!id) {
        throw new Error('학과 식별자가 필요합니다.');
      }

      const params = new URLSearchParams();

      if (options.careernetId) {
        params.set('careernetId', options.careernetId);
      }

      if (options.goyong24) {
        const { majorGb, departmentId, majorId } = options.goyong24;
        if (majorGb && departmentId && majorId) {
          params.set('goyongMajorGb', majorGb);
          params.set('goyongDepartmentId', departmentId);
          params.set('goyongMajorId', majorId);
        }
      }

      if (options.sources && options.sources.length) {
        params.set('sources', options.sources.join(','));
      }

      const query = params.toString();
      const response = await fetch(`${API_BASE}/majors/${encodeURIComponent(id)}${query ? `?${query}` : ''}`);
      const payload = await response.json();

      if (!payload.success) {
        throw new Error(payload.error || '학과 정보 조회 실패');
      }

      return {
        profile: payload.data,
        partials: payload.partials || {},
        sources: payload.sources || {}
      };
    } catch (error) {
      return null;
    }
  },

  // 직업 검색
  async searchJobs(keyword = '', category = '', page = 1, perPage = 20, options = {}) {
    try {
      const params = new URLSearchParams({
        keyword,
        category,
        page: String(page),
        perPage: String(perPage)
      });

      if (!category) {
        params.delete('category');
      }

      if (options.sources && options.sources.length) {
        params.set('sources', options.sources.join(','));
      }

      const response = await fetch(`${API_BASE}/jobs?${params}`);
      const payload = await response.json();

      if (!payload.success) {
        throw new Error(payload.error || '직업 검색 실패');
      }

      return {
        items: Array.isArray(payload.data) ? payload.data : [],
        meta: payload.meta || {},
        categories: payload.categories || {}
      };
    } catch (error) {
      return {
        items: [],
        meta: {
          error: error instanceof Error ? error.message : '직업 검색 실패'
        },
        categories: {}
      };
    }
  },

  // 직업 상세 정보
  async getJobDetail(id, options = {}) {
    try {
      if (!id) {
        throw new Error('직업 식별자가 필요합니다.');
      }

      const params = new URLSearchParams();

      if (options.careernetId) {
        params.set('careernetId', options.careernetId);
      }

      if (options.goyong24JobId) {
        params.set('goyongJobId', options.goyong24JobId);
      }

      if (options.sources && options.sources.length) {
        params.set('sources', options.sources.join(','));
      }

      const query = params.toString();
      const response = await fetch(`${API_BASE}/jobs/${encodeURIComponent(id)}${query ? `?${query}` : ''}`);
      const payload = await response.json();

      if (!payload.success) {
        throw new Error(payload.error || '직업 정보 조회 실패');
      }

      return {
        profile: payload.data,
        partials: payload.partials || {},
        sources: payload.sources || {}
      };
    } catch (error) {
      return null;
    }
  },

  // 카테고리 정보
  async getCategories() {
    try {
      const response = await fetch(`${API_BASE}/categories`);
      const payload = await response.json();

      if (!payload.success) {
        throw new Error(payload.error || '카테고리 정보 조회 실패');
      }

      return payload;
    } catch (error) {
      return {
        jobCategories: {},
        aptitudeTypes: {},
        error: error instanceof Error ? error.message : '카테고리 조회 실패'
      };
    }
  }
};

const SOURCE_LABEL_MAP = {
  CAREERNET: '커리어넷',
  GOYONG24: '고용24'
};

const JOB_SORT_LABELS = {
  relevance: '기본 순',
  'salary-desc': '연봉 높은 순',
  'name-asc': '가나다 순'
};

const MAJOR_SORT_LABELS = {
  relevance: '기본 순',
  'employment-desc': '취업률 높은 순',
  'salary-desc': '월급 높은 순'
};

const OUTLOOK_SCORE_MAP = {
  '매우 좋음': 5,
  '아주 좋음': 5,
  '좋음': 4,
  '보통': 3,
  '보통 이상': 3,
  '보통 이하': 2,
  '나쁨': 1,
  '불명': 0
};

const parseJsonScript = (id) => {
  const el = document.getElementById(id);
  if (!el) return null;
  try {
    return JSON.parse(el.textContent || '{}');
  } catch (error) {
    return null;
  }
};

const parseNumberFromText = (value) => {
  if (!value) return 0;
  const numeric = String(value).replace(/[^0-9.,-]/g, '').replace(/,/g, '');
  if (!numeric) return 0;
  const parsed = parseFloat(numeric);
  return Number.isFinite(parsed) ? parsed : 0;
};

// 취업률 포맷 함수: "70% 이상" 같은 텍스트에서 숫자 추출 후 소수점 1자리까지 반올림
const formatEmploymentRate = (rate) => {
  if (!rate) return null;
  // HTML 태그 제거 및 공백 정리
  const cleaned = String(rate).replace(/<[^>]*>/g, '').trim();
  // 숫자 추출 (정수 또는 소수)
  const match = cleaned.match(/([\d.]+)/);
  if (!match) return cleaned;
  const num = parseFloat(match[1]);
  if (isNaN(num)) return cleaned;
  // 소수점 1자리까지 반올림, 정수면 정수로 표시
  const rounded = Math.round(num * 10) / 10;
  return Number.isInteger(rounded) ? `${rounded}%` : `${rounded.toFixed(1)}%`;
};

const computeOutlookScore = (value) => {
  if (!value) return 0;
  const normalized = value.trim();
  if (OUTLOOK_SCORE_MAP[normalized] !== undefined) {
    return OUTLOOK_SCORE_MAP[normalized];
  }
  if (/우수|호조|긍정/i.test(normalized)) return 4;
  if (/양호|보통/i.test(normalized)) return 3;
  if (/불리|부정|악화/i.test(normalized)) return 1;
  return 2;
};

const computePolicySignature = (policy) => {
  if (!policy || typeof policy !== 'object') {
    return null;
  }
  try {
    const canonical = {
      ...policy,
      moderatorRoles: Array.isArray(policy.moderatorRoles)
        ? [...policy.moderatorRoles].sort()
        : []
    };
    const json = JSON.stringify(canonical);
    let hash = 0;
    for (let i = 0; i < json.length; i += 1) {
      hash = (hash << 5) - hash + json.charCodeAt(i);
      hash |= 0;
    }
    return `policy-${Math.abs(hash)}`;
  } catch (error) {
    return null;
  }
};

const formatDateTime = (epochSeconds) => {
  if (!epochSeconds) return '';
  const date = new Date(epochSeconds * 1000);
  const pad = (num) => String(num).padStart(2, '0');
  return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())} ${pad(date.getHours())}:${pad(date.getMinutes())}`;
};

const TelemetryContext = (() => {
  let sessionId;

  const ensureSessionId = () => {
    if (sessionId) {
      return sessionId;
    }
    if (typeof crypto !== 'undefined' && typeof crypto.randomUUID === 'function') {
      sessionId = crypto.randomUUID();
    } else {
      sessionId = `cw-${Date.now()}-${Math.random().toString(16).slice(2)}`;
    }
    return sessionId;
  };

  const getLanguage = () => {
    if (typeof document !== 'undefined' && document.documentElement && document.documentElement.lang) {
      return document.documentElement.lang;
    }
    if (typeof navigator !== 'undefined') {
      if (Array.isArray(navigator.languages) && navigator.languages.length) {
        return navigator.languages[0];
      }
      return navigator.language || null;
    }
    return null;
  };

  const getTimezone = () => {
    try {
      if (typeof Intl !== 'undefined' && typeof Intl.DateTimeFormat === 'function') {
        const options = Intl.DateTimeFormat().resolvedOptions();
        return options && options.timeZone ? options.timeZone : null;
      }
    } catch (_) {
      // no-op
    }
    return null;
  };

  const getViewport = () => {
    if (typeof window === 'undefined') {
      return { width: null, height: null };
    }
    return {
      width: typeof window.innerWidth === 'number' ? window.innerWidth : null,
      height: typeof window.innerHeight === 'number' ? window.innerHeight : null
    };
  };

  const getReducedMotion = () => {
    if (typeof window === 'undefined' || typeof window.matchMedia !== 'function') {
      return null;
    }
    try {
      return window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'reduce' : 'no-preference';
    } catch (_) {
      return null;
    }
  };

  const build = (overrides = {}) => ({
    version: TELEMETRY_VERSION,
    path: typeof window !== 'undefined' ? window.location.pathname : null,
    query: typeof window !== 'undefined' ? window.location.search || '' : '',
    hash: typeof window !== 'undefined' ? window.location.hash || '' : '',
    origin: typeof window !== 'undefined' ? window.location.origin || null : null,
    referrer: typeof document !== 'undefined' ? document.referrer || null : null,
    language: getLanguage(),
    timezone: getTimezone(),
    visibility: typeof document !== 'undefined' ? document.visibilityState || null : null,
    viewport: getViewport(),
    reducedMotion: getReducedMotion(),
    sessionId: ensureSessionId(),
    userAgent: typeof navigator !== 'undefined' ? navigator.userAgent : null,
    emittedAt: Date.now(),
    ...overrides
  });

  return {
    build,
    ensureSessionId
  };
})();

const buildSourceSummaryContent = (sources) => {
  if (!sources) return '';
  const entries = Object.entries(sources);
  if (!entries.length) return '';
  const items = entries
    .map(([source, status]) => {
      const label = SOURCE_LABEL_MAP[source] || source;
      let message = '데이터 없음';
      if (status?.error) {
        message = `오류: ${status.error}`;
      } else if (typeof status?.count === 'number' && status.count > 0) {
        message = `데이터 ${status.count}건 수신`;
      } else if (status?.attempted) {
        message = '호출되었으나 제공 가능한 데이터가 없습니다.';
      } else if (status?.skippedReason) {
        message = `생략: ${status.skippedReason}`;
      }
      return `
        <li class="flex items-start justify-between gap-4">
          <span class="text-sm font-semibold text-wiki-text">${label}</span>
          <span class="text-xs text-wiki-muted text-right">${message}</span>
        </li>
      `;
    })
    .join('');
  if (!items) return '';
  return `
    <h2 class="text-lg font-semibold text-wiki-text mb-3">데이터 수집 상태</h2>
    <ul class="space-y-2">${items}</ul>
  `;
};

const updateSourceSummary = (elementId, sources) => {
  const container = document.getElementById(elementId);
  if (!container) return;
  const content = buildSourceSummaryContent(sources);
  if (content) {
    container.className = 'glass-card p-6 rounded-xl mt-8';
    container.innerHTML = content;
  } else {
    container.className = '';
    container.innerHTML = '';
  }
};

const updateSourceFilterStatus = (elementId, sources) => {
  const container = document.getElementById(elementId);
  if (!container) return;
  if (!sources) {
    container.innerHTML = '<span class="text-wiki-muted">데이터 소스 정보 없음</span>';
    return;
  }
  const entries = Object.entries(sources);
  if (!entries.length) {
    container.innerHTML = '<span class="text-wiki-muted">데이터 소스 정보 없음</span>';
    return;
  }
  container.innerHTML = entries
    .map(([source, status]) => {
      const label = SOURCE_LABEL_MAP[source] || source;
      const countBadge = typeof status?.count === 'number' && status.count > 0 ? ` (${status.count})` : '';
      const stateClass = status?.error
        ? 'text-red-400'
        : typeof status?.count === 'number' && status.count > 0
          ? 'text-wiki-secondary'
          : 'text-wiki-muted';
      return `<span class="inline-flex items-center gap-1 ${stateClass}"><i class="fas fa-database"></i>${label}${countBadge}</span>`;
    })
    .join('<span class="text-wiki-border">·</span>');
};

const updateHydrationStatus = (elementId, meta, sortKey, sortLabels) => {
  const el = document.getElementById(elementId);
  if (!el) return;
  const parts = [];
  if (typeof meta?.total === 'number') {
    parts.push(`총 ${meta.total}건`);
  }
  if (sortKey && sortLabels[sortKey]) {
    parts.push(`정렬: ${sortLabels[sortKey]}`);
  }
  if (meta?.cacheState?.status) {
    parts.push(`SSR 캐시: ${meta.cacheState.status}`);
  }
  if (meta?.cacheState?.cachedAt) {
    parts.push(`캐시 시각: ${formatDateTime(meta.cacheState.cachedAt)}`);
  }
  el.textContent = parts.length ? parts.join(' · ') : '';
};

const Hydration = (() => {
  const createState = (initialItems, initialMeta = {}) => ({
    baseItems: Array.isArray(initialItems) ? initialItems.slice() : [],
    meta: { ...initialMeta },
    sort: initialMeta.sort || 'relevance',
    isHydrated: false
  });

  const now = () => (typeof performance !== 'undefined' ? performance.now() : Date.now());

  const summarizeHydrationState = (state) => {
    if (!state || typeof state !== 'object') {
      return null;
    }
    const meta = state.meta || {};
    const includeSources =
      Array.isArray(meta.includeSources) && meta.includeSources.length
        ? meta.includeSources.slice()
        : meta.sources && typeof meta.sources === 'object'
          ? Object.keys(meta.sources)
          : null;
    const cacheState = meta.cacheState && typeof meta.cacheState === 'object' ? meta.cacheState : null;
    const cachedAt = cacheState && typeof cacheState.cachedAt === 'number' ? cacheState.cachedAt : null;
    const cacheAgeSeconds = cachedAt ? Math.max(Math.round(Date.now() / 1000 - cachedAt), 0) : null;
    return {
      sort: state.sort ?? null,
      total: typeof meta.total === 'number' ? meta.total : null,
      page: typeof meta.page === 'number' ? meta.page : null,
      perPage: typeof meta.perPage === 'number' ? meta.perPage : null,
      keyword: typeof meta.keyword === 'string' ? meta.keyword : null,
      category: typeof meta.category === 'string' && meta.category.length ? meta.category : null,
      includeSources,
      cacheStatus: cacheState?.status ?? null,
      cacheAgeSeconds
    };
  };

  const emitHydrationAction = (page, action, payload = {}, state) => {
    const component = typeof payload?.component === 'string' && payload.component.length ? payload.component : `${page}-serp`;
    const payloadWithComponent = { ...payload, component };
    const stateSnapshot = summarizeHydrationState(state);
    window.dispatchEvent(new CustomEvent('cw-hydration-action', {
      detail: {
        version: TELEMETRY_VERSION,
        source: 'hydration',
        page,
        component,
        action,
        payload: payloadWithComponent,
        state: stateSnapshot,
        context: TelemetryContext.build({ component, source: 'hydration', page }),
        at: now()
      }
    }));
  };

  const ensureMetaDefaults = (meta, fallbackLength) => ({
    total: typeof meta?.total === 'number' ? meta.total : fallbackLength,
    page: typeof meta?.page === 'number' ? meta.page : 1,
    perPage: typeof meta?.perPage === 'number' ? meta.perPage : fallbackLength,
    keyword: meta?.keyword || '',
    category: meta?.category || '',
    includeSources: meta?.includeSources || null,
    sources: meta?.sources || null,
    cacheState: meta?.cacheState || null,
    sort: meta?.sort || 'relevance' // 정렬 기준 유지
  });

  const emptyJobMessage = `
    <div class="glass-card p-12 rounded-2xl text-center">
      <i class="fas fa-circle-info text-4xl text-wiki-secondary mb-4"></i>
      <h2 class="text-2xl font-semibold text-white mb-2">검색 결과가 없습니다</h2>
      <p class="text-sm text-wiki-muted">검색어 또는 필터를 변경하여 다시 시도해 주세요. CareerWiki는 매일 새로운 직업 데이터를 수집하고 있습니다.</p>
    </div>
  `;

  const emptyMajorMessage = `
    <div class="glass-card p-12 rounded-2xl text-center">
      <i class="fas fa-circle-info text-4xl text-wiki-secondary mb-4"></i>
      <h2 class="text-2xl font-semibold text-white mb-2">검색 결과가 없습니다</h2>
      <p class="text-sm text-wiki-muted">검색어를 변경하여 다시 시도해 주세요. CareerWiki는 지속적으로 새로운 전공 데이터를 수집하고 있습니다.</p>
    </div>
  `;

  // 데이터 풍부도 계산 함수 (display 객체의 유효한 필드 개수)
  const calculateJobDataRichness = (item) => {
    if (!item?.display) return 0;
    const d = item.display;
    let score = 0;
    // 중요 필드에 가중치 부여
    if (d.salary) score += 3;
    if (d.satisfaction) score += 2;
    if (d.wlb) score += 2;
    if (d.outlook) score += 2;
    if (d.summary) score += 1;
    if (d.categoryName) score += 1;
    if (d.workStrong) score += 1;
    if (d.skillYear) score += 1;
    return score;
  };

  const calculateMajorDataRichness = (item) => {
    if (!item?.display) return 0;
    const d = item.display;
    let score = 0;
    // 중요 필드에 가중치 부여
    if (d.employmentRate) score += 3;
    if (d.firstJobSalary || d.salaryAfterGraduation) score += 3;
    if (d.firstJobSatisfaction) score += 2;
    if (d.summary) score += 1;
    if (d.categoryName) score += 1;
    return score;
  };

  const applyJobSort = (items, sortKey) => {
    if (!Array.isArray(items)) return [];
    const cloned = items.slice();
    switch (sortKey) {
      case 'salary-desc':
        return cloned.sort((a, b) => parseNumberFromText(b?.display?.salary) - parseNumberFromText(a?.display?.salary));
      case 'name-asc':
        return cloned.sort((a, b) => (a?.profile?.name || '').localeCompare(b?.profile?.name || ''));
      default:
        // 기본 순: 데이터 풍부도 기준 정렬 (데이터 많은 순)
        return cloned.sort((a, b) => calculateJobDataRichness(b) - calculateJobDataRichness(a));
    }
  };

  const applyMajorSort = (items, sortKey) => {
    if (!Array.isArray(items)) return [];
    const cloned = items.slice();
    switch (sortKey) {
      case 'employment-desc':
        return cloned.sort((a, b) => parseNumberFromText(b?.display?.employmentRate) - parseNumberFromText(a?.display?.employmentRate));
      case 'salary-desc':
        return cloned.sort((a, b) => parseNumberFromText(b?.display?.salaryAfterGraduation) - parseNumberFromText(a?.display?.salaryAfterGraduation));
      case 'name-asc':
        return cloned.sort((a, b) => (a?.profile?.name || '').localeCompare(b?.profile?.name || ''));
      default:
        // 기본 순: 데이터 풍부도 기준 정렬 (데이터 많은 순)
        return cloned.sort((a, b) => calculateMajorDataRichness(b) - calculateMajorDataRichness(a));
    }
  };

  // 페이지네이션 업데이트 함수
  const updatePagination = (containerId, total, currentPage, perPage, baseUrl, keyword) => {
    // 결과 섹션과 페이지네이션 요소 찾기
    const resultsSection = document.getElementById(containerId);
    if (!resultsSection) return;
    
    // aria-label로 페이지네이션 nav 찾기 (SSR에서 렌더링된 요소)
    let nav = document.querySelector('nav[aria-label="페이지네이션"]');
    
    // 페이지네이션 정보 텍스트 요소 찾기 (nav 다음의 p.text-center)
    let paginationInfo = nav ? nav.nextElementSibling : null;
    if (paginationInfo && paginationInfo.tagName !== 'P') {
      paginationInfo = null;
    }
    
    const totalPages = Math.ceil(total / perPage);
    
    // 페이지가 1개 이하면 페이지네이션 숨기기
    if (totalPages <= 1) {
      if (nav) nav.style.display = 'none';
      if (paginationInfo) paginationInfo.style.display = 'none';
      return;
    }
    
    // nav 요소가 없으면 생성
    if (!nav) {
      nav = document.createElement('nav');
      nav.className = 'mt-8 flex justify-center items-center gap-2 flex-wrap';
      nav.setAttribute('aria-label', '페이지네이션');
      resultsSection.parentNode.insertBefore(nav, resultsSection.nextSibling);
    }
    nav.style.display = '';
    
    // 페이지 URL 생성 함수
    const buildPageUrl = (pageNum) => {
      const params = new URLSearchParams();
      if (keyword) params.set('q', keyword);
      if (pageNum > 1) params.set('page', String(pageNum));
      return `${baseUrl}${params.toString() ? `?${params.toString()}` : ''}`;
    };
    
    // 페이지 버튼 생성
    const maxPageButtons = 7;
    let startPage = Math.max(1, currentPage - Math.floor(maxPageButtons / 2));
    let endPage = Math.min(totalPages, startPage + maxPageButtons - 1);
    
    if (endPage - startPage < maxPageButtons - 1) {
      startPage = Math.max(1, endPage - maxPageButtons + 1);
    }
    
    const pageButtons = [];
    
    // 이전 페이지 버튼
    if (currentPage > 1) {
      pageButtons.push(`<a href="${buildPageUrl(currentPage - 1)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition"><i class="fas fa-chevron-left"></i></a>`);
    }
    
    // 첫 페이지
    if (startPage > 1) {
      pageButtons.push(`<a href="${buildPageUrl(1)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">1</a>`);
      if (startPage > 2) {
        pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`);
      }
    }
    
    // 페이지 번호들
    for (let i = startPage; i <= endPage; i++) {
      const isActive = i === currentPage;
      pageButtons.push(`<a href="${buildPageUrl(i)}" class="px-4 py-2 rounded-lg transition ${isActive ? 'bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold' : 'bg-wiki-bg border border-wiki-border hover:border-wiki-primary'}">${i}</a>`);
    }
    
    // 마지막 페이지
    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`);
      }
      pageButtons.push(`<a href="${buildPageUrl(totalPages)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">${totalPages}</a>`);
    }
    
    // 다음 페이지 버튼
    if (currentPage < totalPages) {
      pageButtons.push(`<a href="${buildPageUrl(currentPage + 1)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition"><i class="fas fa-chevron-right"></i></a>`);
    }
    
    nav.innerHTML = pageButtons.join('');
    
    // 페이지네이션 정보 업데이트
    if (!paginationInfo) {
      paginationInfo = document.createElement('p');
      paginationInfo.className = 'text-center text-xs text-wiki-muted mt-4';
      nav.parentNode.insertBefore(paginationInfo, nav.nextSibling);
    }
    paginationInfo.style.display = '';
    paginationInfo.textContent = `${currentPage}페이지 / 총 ${totalPages}페이지 (${total}개 항목)`;
  };

  const hydrateJobSerp = () => {
    const container = document.getElementById('job-results');
    if (!container) return;
    const page = 'job';
    const component = `${page}-serp`;
    const hydrationStartedAt = now();
    const json = parseJsonScript('job-hydration-data');
    const state = createState(json?.items || [], ensureMetaDefaults(json?.meta || {}, (json?.items || []).length));
    
    // 원본 SSR 데이터 보존 (기본 순 복원용)
    state.originalItems = state.baseItems.slice();

    // 전체 DB 정렬 + 즉각 반응 (AJAX)
    const render = async (skipFetch = false) => {
      // skipFetch가 true면 현재 데이터만 렌더링 (첫 로드용)
      if (!skipFetch && state.sort !== 'relevance') {
        // 로딩 표시
        container.innerHTML = '<div class="flex justify-center py-8"><i class="fas fa-spinner fa-spin text-2xl text-wiki-primary"></i></div>';
        
        try {
          // 서버에서 정렬된 데이터 가져오기
          const params = new URLSearchParams();
          if (state.meta.keyword) params.set('q', state.meta.keyword);
          params.set('sort', state.sort);
          params.set('perPage', '20'); // 성능 최적화: 50 → 20
          
          const response = await fetch(`/api/jobs/search?${params.toString()}`);
          const result = await response.json();
          
          if (result.success && Array.isArray(result.data)) {
            state.baseItems = result.data;
            if (result.meta) {
              state.meta.total = result.meta.total;
            }
          }
        } catch (error) {
        }
      }
      
      // 기본 순: 원본 SSR 데이터 그대로 사용 (재정렬 없음)
      // 다른 정렬: 서버 API 결과 사용
      const items = state.sort === 'relevance' 
        ? state.originalItems  // 원본 그대로 (서버에서 이미 기본 순 정렬됨)
        : state.baseItems;     // 서버 API 결과
      
      if (items.length) {
        container.innerHTML = items.map(item => DOMUtils.createJobCard(item)).join('');
      } else {
        container.innerHTML = emptyJobMessage;
      }
      updateSourceSummary('job-source-summary', state.meta.sources);
      updateSourceFilterStatus('job-source-filter', state.meta.sources);
      updateHydrationStatus('job-hydration-status', state.meta, state.sort, JOB_SORT_LABELS);
      
      const totalEl = document.getElementById('job-total-count');
      if (totalEl && typeof state.meta.total === 'number') {
        totalEl.textContent = String(state.meta.total);
      }
      
      if (!state.isHydrated) {
        const duration = Math.max(now() - hydrationStartedAt, 0);
        const stateSnapshot = summarizeHydrationState(state);
        window.dispatchEvent(new CustomEvent('cw-hydration-complete', {
          detail: {
            version: TELEMETRY_VERSION,
            source: 'hydration',
            page,
            component,
            payload: { total: stateSnapshot?.total ?? null, results: items.length, sort: stateSnapshot?.sort ?? null, duration },
            state: stateSnapshot,
            duration,
            context: TelemetryContext.build({ component, source: 'hydration', page })
          }
        }));
        state.isHydrated = true;
      }
    };

    const form = document.getElementById('job-filter-form');
    const sortSelect = document.getElementById('job-sort-select');
    
    // 커스텀 드롭다운 초기화
    const initCustomDropdown = () => {
      const trigger = document.getElementById('job-sort-trigger');
      const menu = document.getElementById('job-sort-menu');
      const label = document.getElementById('job-sort-label');
      const chevron = document.getElementById('job-sort-chevron');
      const options = menu?.querySelectorAll('.sort-option');
      
      if (!trigger || !menu || !label || !options) return;
      
      // 현재 값 표시
      const updateLabel = (value) => {
        const labels = { relevance: '기본 순', 'salary-desc': '연봉 높은 순', 'name-asc': '가나다 순' };
        label.textContent = labels[value] || '기본 순';
        options.forEach(opt => {
          opt.classList.toggle('active', opt.dataset.sort === value);
        });
      };
      updateLabel(state.sort);
      
      // 토글
      const toggleMenu = (show) => {
        if (show) {
          menu.classList.remove('opacity-0', 'invisible', 'translate-y-1');
          menu.classList.add('opacity-100', 'visible', 'translate-y-0');
          chevron?.classList.add('rotate-180');
        } else {
          menu.classList.add('opacity-0', 'invisible', 'translate-y-1');
          menu.classList.remove('opacity-100', 'visible', 'translate-y-0');
          chevron?.classList.remove('rotate-180');
        }
      };
      
      trigger.addEventListener('click', (e) => {
        e.stopPropagation();
        const isOpen = menu.classList.contains('opacity-100');
        toggleMenu(!isOpen);
      });
      
      options.forEach(opt => {
        opt.addEventListener('click', () => {
          const value = opt.dataset.sort;
          state.sort = value;
          if (sortSelect) sortSelect.value = value;
          updateLabel(value);
          toggleMenu(false);
          render(); // 즉각 정렬
        });
      });
      
      // 외부 클릭 시 닫기
      document.addEventListener('click', () => toggleMenu(false));
    };
    initCustomDropdown();

    if (sortSelect) {
      sortSelect.value = state.sort;
      sortSelect.addEventListener('change', () => {
        state.sort = sortSelect.value;
        render(); // 즉각 정렬
      });
    }

    // 검색 폼은 기본 동작(페이지 새로고침)으로 SSR 결과를 받음
  };

  const hydrateMajorSerp = () => {
    const container = document.getElementById('major-results');
    if (!container) return;
    const page = 'major';
    const component = `${page}-serp`;
    const hydrationStartedAt = now();
    const json = parseJsonScript('major-hydration-data');
    const state = createState(json?.items || [], ensureMetaDefaults(json?.meta || {}, (json?.items || []).length));
    
    // 원본 SSR 데이터 보존 (기본 순 복원용)
    state.originalItems = state.baseItems.slice();

    // 전체 DB 정렬 + 즉각 반응 (AJAX)
    const render = async (skipFetch = false) => {
      // skipFetch가 true면 현재 데이터만 렌더링 (첫 로드용)
      if (!skipFetch && state.sort !== 'relevance') {
        // 로딩 표시
        container.innerHTML = '<div class="flex justify-center py-8"><i class="fas fa-spinner fa-spin text-2xl text-wiki-primary"></i></div>';
        
        try {
          // 서버에서 정렬된 데이터 가져오기
          const params = new URLSearchParams();
          if (state.meta.keyword) params.set('q', state.meta.keyword);
          params.set('sort', state.sort);
          params.set('perPage', '20'); // 성능 최적화: 50 → 20
          
          const response = await fetch(`/api/majors/search?${params.toString()}`);
          const result = await response.json();
          
          if (result.success && Array.isArray(result.data)) {
            state.baseItems = result.data;
            if (result.meta) {
              state.meta.total = result.meta.total;
            }
          }
        } catch (error) {
        }
      }
      
      // 기본 순: 원본 SSR 데이터 그대로 사용 (재정렬 없음)
      // 다른 정렬: 서버 API 결과 사용
      const items = state.sort === 'relevance' 
        ? state.originalItems  // 원본 그대로 (서버에서 이미 기본 순 정렬됨)
        : state.baseItems;     // 서버 API 결과
      
      if (items.length) {
        container.innerHTML = items.map(item => DOMUtils.createMajorCard(item)).join('');
      } else {
        container.innerHTML = emptyMajorMessage;
      }
      updateSourceSummary('major-source-summary', state.meta.sources);
      updateHydrationStatus('major-hydration-status', state.meta, state.sort, MAJOR_SORT_LABELS);
      
      const totalEl = document.getElementById('major-total-count');
      if (totalEl && typeof state.meta.total === 'number') {
        totalEl.textContent = String(state.meta.total);
      }
      
      if (!state.isHydrated) {
        const duration = Math.max(now() - hydrationStartedAt, 0);
        const stateSnapshot = summarizeHydrationState(state);
        window.dispatchEvent(new CustomEvent('cw-hydration-complete', {
          detail: {
            version: TELEMETRY_VERSION,
            source: 'hydration',
            page,
            component,
            payload: { total: stateSnapshot?.total ?? null, results: items.length, sort: stateSnapshot?.sort ?? null, duration },
            state: stateSnapshot,
            duration,
            context: TelemetryContext.build({ component, source: 'hydration', page })
          }
        }));
        state.isHydrated = true;
      }
    };

    const form = document.getElementById('major-filter-form');
    const sortSelect = document.getElementById('major-sort-select');
    
    // 커스텀 드롭다운 초기화
    const initCustomDropdown = () => {
      const trigger = document.getElementById('major-sort-trigger');
      const menu = document.getElementById('major-sort-menu');
      const label = document.getElementById('major-sort-label');
      const chevron = document.getElementById('major-sort-chevron');
      const options = menu?.querySelectorAll('.sort-option');
      
      if (!trigger || !menu || !label || !options) return;
      
      // 현재 값 표시
      const updateLabel = (value) => {
        const labels = { relevance: '기본 순', 'employment-desc': '취업률 높은 순', 'salary-desc': '연봉 높은 순', 'name-asc': '가나다 순' };
        label.textContent = labels[value] || '기본 순';
        options.forEach(opt => {
          opt.classList.toggle('active', opt.dataset.sort === value);
        });
      };
      updateLabel(state.sort);
      
      // 토글
      const toggleMenu = (show) => {
        if (show) {
          menu.classList.remove('opacity-0', 'invisible', 'translate-y-1');
          menu.classList.add('opacity-100', 'visible', 'translate-y-0');
          chevron?.classList.add('rotate-180');
        } else {
          menu.classList.add('opacity-0', 'invisible', 'translate-y-1');
          menu.classList.remove('opacity-100', 'visible', 'translate-y-0');
          chevron?.classList.remove('rotate-180');
        }
      };
      
      trigger.addEventListener('click', (e) => {
        e.stopPropagation();
        const isOpen = menu.classList.contains('opacity-100');
        toggleMenu(!isOpen);
      });
      
      options.forEach(opt => {
        opt.addEventListener('click', () => {
          const value = opt.dataset.sort;
          state.sort = value;
          if (sortSelect) sortSelect.value = value;
          updateLabel(value);
          toggleMenu(false);
          render(); // 즉각 정렬
        });
      });
      
      // 외부 클릭 시 닫기
      document.addEventListener('click', () => toggleMenu(false));
    };
    initCustomDropdown();

    if (sortSelect) {
      sortSelect.value = state.sort;
      sortSelect.addEventListener('change', () => {
        state.sort = sortSelect.value;
        render(); // 즉각 정렬
      });
    }

    // 검색 폼은 기본 동작(페이지 새로고침)으로 SSR 결과를 받음
  };

  return {
    initJobSerp: hydrateJobSerp,
    initMajorSerp: hydrateMajorSerp
  };
})();

const DetailTelemetry = (() => {
  let cachedMeta
  let autoObserver
  const handledElements = new WeakSet()

  const now = () => (typeof performance !== 'undefined' ? performance.now() : Date.now())

  const parseDatasetValue = (value) => {
    if (value === undefined || value === null) {
      return value ?? undefined
    }
    if (typeof value !== 'string') {
      return value
    }
    const trimmed = value.trim()
    if (trimmed === '') {
      return ''
    }
    if (trimmed === 'true') {
      return true
    }
    if (trimmed === 'false') {
      return false
    }
    if (/^-?[0-9]+$/.test(trimmed)) {
      const intValue = Number.parseInt(trimmed, 10)
      if (Number.isSafeInteger(intValue)) {
        return intValue
      }
    }
    if (/^-?[0-9]*\.[0-9]+$/.test(trimmed)) {
      const floatValue = Number.parseFloat(trimmed)
      if (!Number.isNaN(floatValue)) {
        return floatValue
      }
    }
    if ((trimmed.startsWith('{') && trimmed.endsWith('}')) || (trimmed.startsWith('[') && trimmed.endsWith(']'))) {
      try {
        return JSON.parse(trimmed)
      } catch (_) {
        // fall through to returning the raw string
      }
    }
    return trimmed
  }

  const sanitizeDataset = (element) => {
    if (!element || !element.dataset) {
      return {}
    }
    const entries = Object.entries(element.dataset).filter(
      ([key]) => key !== 'cwTelemetryAction' && key !== 'cwTelemetryComponent' && key !== 'cwTelemetryScope' && key !== 'cwTelemetryAuto'
    )
    return entries.reduce((acc, [key, raw]) => {
      acc[key] = parseDatasetValue(raw)
      return acc
    }, {})
  }

  const getMeta = () => {
    if (cachedMeta !== undefined) {
      return cachedMeta
    }
    const parsed = parseJsonScript('cw-detail-meta')
    cachedMeta = parsed && typeof parsed === 'object' ? parsed : null
    return cachedMeta
  }

  const getGovernanceContext = () => {
    const meta = getMeta()
    const extra = meta?.extra
    if (!extra || typeof extra !== 'object' || Array.isArray(extra)) {
      return null
    }
    const comments = extra.comments
    if (!comments || typeof comments !== 'object' || Array.isArray(comments)) {
      return null
    }
    const policy = comments.policy
    if (!policy || typeof policy !== 'object' || Array.isArray(policy)) {
      return null
    }
    const signature = computePolicySignature(policy)
    const roles = Array.isArray(policy.moderatorRoles) ? policy.moderatorRoles.slice() : []
    return {
      requiresAuth: typeof policy.requiresAuth === 'boolean' ? policy.requiresAuth : null,
      dailyVoteLimit: typeof policy.dailyVoteLimit === 'number' ? policy.dailyVoteLimit : null,
      voteWindowHours: typeof policy.voteWindowHours === 'number' ? policy.voteWindowHours : null,
      ipDisplayMode: typeof policy.ipDisplayMode === 'string' ? policy.ipDisplayMode : null,
      bestLikeThreshold: typeof policy.bestLikeThreshold === 'number' ? policy.bestLikeThreshold : null,
      reportBlindThreshold: typeof policy.reportBlindThreshold === 'number' ? policy.reportBlindThreshold : null,
      moderatorRoles: roles,
      signature,
      source: 'meta'
    }
  }

  const emit = (action, payload = {}) => {
    const meta = getMeta()
    const component = typeof payload?.component === 'string' && payload.component.length
      ? payload.component
      : (typeof payload?.scope === 'string' && payload.scope.length ? payload.scope : action)
    let basePayload = payload && typeof payload === 'object' && !Array.isArray(payload)
      ? { ...payload }
      : payload === undefined
        ? {}
        : { value: payload }
    let governanceOverride
    if (basePayload && typeof basePayload === 'object' && 'governance' in basePayload) {
      governanceOverride = basePayload.governance
      basePayload = { ...basePayload }
      delete basePayload.governance
    }
    const payloadWithComponent = { ...basePayload, component }
    const governanceContext = governanceOverride ?? getGovernanceContext()
    const detail = {
      version: TELEMETRY_VERSION,
      source: 'detail',
      component,
      action,
      payload: payloadWithComponent,
      entity: meta?.entity ?? null,
      tabs: Array.isArray(meta?.tabs) ? meta.tabs : [],
      sourceStatus: Array.isArray(meta?.sourceStatus) ? meta.sourceStatus : [],
      partials: Array.isArray(meta?.partials) ? meta.partials : [],
      extra: meta?.extra ?? null,
      governance: governanceContext ?? null,
      context: TelemetryContext.build({
        component,
        source: 'detail',
        entityType: meta?.entity?.type ?? null,
        entityId: meta?.entity?.id ?? null,
        entitySlug: meta?.entity?.slug ?? null
      }),
      at: now()
    }
    window.dispatchEvent(new CustomEvent('cw-detail-action', { detail }))
  }

  const autoEmit = (element) => {
    if (!(element instanceof HTMLElement)) {
      return
    }
    if (handledElements.has(element)) {
      return
    }
    const action = element.dataset.cwTelemetryAction
    if (!action || element.dataset.cwTelemetryAuto === 'manual') {
      return
    }
    handledElements.add(element)
    const dataset = sanitizeDataset(element)
    const scope = element.dataset.cwTelemetryScope || null
    const component =
      element.dataset.cwTelemetryComponent ||
      dataset.cwTelemetryComponent ||
      scope ||
      dataset.cwTelemetryScope ||
      dataset.component ||
      'detail-component'
    const entityType = element.getAttribute('data-entity-type') || dataset.entityType || null
    const entityId = element.getAttribute('data-entity-id') || dataset.entityId || null
    emit(action, {
      component,
      scope,
      entityType,
      entityId,
      dataset,
      observed: true
    })
  }

  const scanForTelemetryTargets = (root) => {
    if (!(root instanceof HTMLElement)) {
      return
    }
    if (root.dataset && root.dataset.cwTelemetryAction) {
      autoEmit(root)
    }
    root.querySelectorAll('[data-cw-telemetry-action]').forEach((element) => autoEmit(element))
  }

  const observeDom = () => {
    if (typeof document === 'undefined') {
      return
    }
    scanForTelemetryTargets(document.documentElement)
    if (autoObserver || typeof MutationObserver === 'undefined') {
      return
    }
    autoObserver = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        mutation.addedNodes.forEach((node) => {
          if (node instanceof HTMLElement) {
            scanForTelemetryTargets(node)
          }
        })
      })
    })
    autoObserver.observe(document.documentElement, { childList: true, subtree: true })
  }

  const markReady = () => {
    const meta = getMeta()
    emit('ready', {
      component: 'detail-page',
      entityType: meta?.entity?.type ?? null,
      entityId: meta?.entity?.id ?? null,
      entitySlug: meta?.entity?.slug ?? null,
      tabCount: Array.isArray(meta?.tabs) ? meta.tabs.length : 0
    })
  }

  return {
    emit,
    getMeta,
    markReady,
    observeDom
  }
})()

const DetailTabs = (() => {
  // md: 접두사가 있는 클래스도 토글해야 함
  const ACTIVE_CLASSES = ['text-white', 'border-wiki-primary', 'md:bg-wiki-border/30']
  const INACTIVE_CLASSES = ['text-wiki-muted', 'border-transparent', 'bg-transparent']

  const setTriggerState = (trigger, active) => {
    trigger.setAttribute('aria-selected', active ? 'true' : 'false')
    trigger.classList.toggle('is-active', active)
    ACTIVE_CLASSES.forEach((cls) => trigger.classList.toggle(cls, active))
    INACTIVE_CLASSES.forEach((cls) => trigger.classList.toggle(cls, !active))
    trigger.setAttribute('tabindex', active ? '0' : '-1')
  }

  const setPanelState = (panel, active) => {
    panel.classList.toggle('is-active', active)
    panel.hidden = !active
    panel.setAttribute('aria-hidden', active ? 'false' : 'true')
    panel.setAttribute('tabindex', active ? '0' : '-1')
  }

  const initTabset = (tabset) => {
    const entityType = tabset.getAttribute('data-entity-type') || 'detail'
    const triggers = Array.from(tabset.querySelectorAll('[data-cw-tab-trigger]'))
    const panels = Array.from(tabset.querySelectorAll('[data-cw-tab-panel]'))

    if (!triggers.length || !panels.length) {
      return
    }

    const triggerById = new Map(triggers.map((trigger) => [trigger.getAttribute('data-tab-id'), trigger]))
    const panelById = new Map(panels.map((panel) => [panel.getAttribute('data-tab-id'), panel]))

    let activeId = tabset.getAttribute('data-tab-default')
    if (!activeId || !triggerById.has(activeId) || !panelById.has(activeId)) {
      const firstTrigger = triggers.find((trigger) => trigger.getAttribute('data-tab-id'))
      activeId = firstTrigger ? firstTrigger.getAttribute('data-tab-id') : null
    }

    const activate = (nextId, source = 'init') => {
      if (!nextId || !triggerById.has(nextId) || !panelById.has(nextId)) {
        return
      }
      const previousId = tabset.dataset.activeTab ?? null
      if (previousId === nextId && source === 'user') {
        return
      }

      tabset.dataset.activeTab = nextId
      triggerById.forEach((trigger, id) => setTriggerState(trigger, id === nextId))
      panelById.forEach((panel, id) => setPanelState(panel, id === nextId))

      if (source === 'user') {
        DetailTelemetry.emit('tab-change', {
          component: 'tabset',
          entityType,
          tabId: nextId,
          previousTab: previousId,
          totalTabs: triggerById.size
        })
      }
    }

    if (activeId) {
      activate(activeId, 'init')
    } else {
      const iterator = triggerById.keys()
      const firstId = iterator.next().value
      if (firstId) {
        activate(firstId, 'init')
      }
    }

    triggers.forEach((trigger, index) => {
      if (trigger.dataset.tabBound === '1') {
        return
      }
      trigger.dataset.tabBound = '1'

      trigger.addEventListener('click', (event) => {
        event.preventDefault()
        const targetId = trigger.getAttribute('data-tab-id')
        if (targetId) {
          activate(targetId, 'user')
          trigger.focus()
        }
      })

      trigger.addEventListener('keydown', (event) => {
        const key = event.key
        if (key === 'ArrowRight' || key === 'ArrowDown') {
          event.preventDefault()
          const nextIndex = (index + 1) % triggers.length
          const nextTrigger = triggers[nextIndex]
          if (nextTrigger) {
            nextTrigger.focus()
            const nextId = nextTrigger.getAttribute('data-tab-id')
            if (nextId) {
              activate(nextId, 'user')
            }
          }
        } else if (key === 'ArrowLeft' || key === 'ArrowUp') {
          event.preventDefault()
          const prevIndex = (index - 1 + triggers.length) % triggers.length
          const prevTrigger = triggers[prevIndex]
          if (prevTrigger) {
            prevTrigger.focus()
            const prevId = prevTrigger.getAttribute('data-tab-id')
            if (prevId) {
              activate(prevId, 'user')
            }
          }
        } else if (key === 'Home') {
          event.preventDefault()
          const firstTrigger = triggers[0]
          firstTrigger?.focus()
          const firstId = firstTrigger?.getAttribute('data-tab-id')
          if (firstId) {
            activate(firstId, 'user')
          }
        } else if (key === 'End') {
          event.preventDefault()
          const lastTrigger = triggers[triggers.length - 1]
          lastTrigger?.focus()
          const lastId = lastTrigger?.getAttribute('data-tab-id')
          if (lastId) {
            activate(lastId, 'user')
          }
        } else if (key === 'Enter' || key === ' ') {
          event.preventDefault()
          trigger.click()
        }
      })
    })

    // 📱 모바일 스와이프로 탭 전환
    const panelsContainer = tabset.querySelector('[data-cw-tab-panels]')
    if (panelsContainer && triggers.length > 1) {
      let touchStartX = 0
      let touchStartY = 0
      let touchEndX = 0
      let touchEndY = 0
      const SWIPE_THRESHOLD = 50  // 최소 스와이프 거리
      const SWIPE_ANGLE_THRESHOLD = 30  // 수평 스와이프 판정 각도

      panelsContainer.addEventListener('touchstart', (e) => {
        touchStartX = e.changedTouches[0].screenX
        touchStartY = e.changedTouches[0].screenY
      }, { passive: true })

      panelsContainer.addEventListener('touchend', (e) => {
        touchEndX = e.changedTouches[0].screenX
        touchEndY = e.changedTouches[0].screenY
        
        const diffX = touchEndX - touchStartX
        const diffY = touchEndY - touchStartY
        const absDiffX = Math.abs(diffX)
        const absDiffY = Math.abs(diffY)
        
        // 수평 스와이프인지 확인 (각도 체크)
        if (absDiffX < SWIPE_THRESHOLD || absDiffY > absDiffX * Math.tan(SWIPE_ANGLE_THRESHOLD * Math.PI / 180)) {
          return
        }
        
        const currentId = tabset.dataset.activeTab
        const currentTrigger = triggers.find(t => t.getAttribute('data-tab-id') === currentId)
        
        // iconOnly 탭에서는 스와이프 비활성화
        if (currentTrigger?.hasAttribute('data-icon-only')) {
          return
        }
        
        // 스와이프 가능한 탭들만 필터링 (iconOnly 제외)
        const swipeableTriggers = triggers.filter(t => !t.hasAttribute('data-icon-only'))
        const currentSwipeIndex = swipeableTriggers.findIndex(t => t.getAttribute('data-tab-id') === currentId)
        
        if (currentSwipeIndex === -1 || swipeableTriggers.length <= 1) {
          return
        }
        
        let nextSwipeIndex
        if (diffX > 0) {
          // 오른쪽으로 스와이프 → 이전 탭
          nextSwipeIndex = (currentSwipeIndex - 1 + swipeableTriggers.length) % swipeableTriggers.length
        } else {
          // 왼쪽으로 스와이프 → 다음 탭
          nextSwipeIndex = (currentSwipeIndex + 1) % swipeableTriggers.length
        }
        
        const nextTrigger = swipeableTriggers[nextSwipeIndex]
        const nextId = nextTrigger?.getAttribute('data-tab-id')
        if (nextId) {
          activate(nextId, 'user')
          // 탭 버튼을 화면에 보이게 스크롤
          nextTrigger.scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'center' })
        }
      }, { passive: true })
    }

    DetailTelemetry.emit('tab-ready', {
      component: 'tabset',
      entityType,
      tabId: tabset.dataset.activeTab ?? null,
      totalTabs: triggerById.size
    })
  }

  const init = (entityType) => {
    const tabsets = document.querySelectorAll(`[data-cw-tabset][data-entity-type="${entityType}"]`)
    tabsets.forEach((tabset) => {
      initTabset(tabset)
    })
  }

  return { init }
})()

const DetailComments = (() => {
  const SECTION_STATE = new WeakMap()
  const MAX_CONTENT_LENGTH = 1000
  const MAX_NICKNAME_LENGTH = 40
  const DEFAULT_MODERATOR_ROLES = ['super-admin', 'operator']
  const DEFAULT_POLICY = {
    requiresAuth: true,
    bestLikeThreshold: 8,
    bestLimit: 10,
    reportBlindThreshold: 5,
    dailyVoteLimit: 5,
    voteWindowHours: 24,
    ipDisplayMode: 'masked',
    moderatorIpBlockEnabled: true,
    moderatorRoles: [...DEFAULT_MODERATOR_ROLES]
  }

  // 토스트 알림 함수
  const showToast = (message, type = 'info', duration = 3000) => {
    // 기존 토스트 컨테이너가 없으면 생성
    let container = document.getElementById('cw-toast-container')
    if (!container) {
      container = document.createElement('div')
      container.id = 'cw-toast-container'
      container.className = 'fixed bottom-4 right-4 z-[9999] flex flex-col gap-2'
      document.body.appendChild(container)
    }
    
    const toast = document.createElement('div')
    const bgColor = type === 'success' ? 'bg-green-600' : type === 'error' ? 'bg-red-600' : 'bg-wiki-primary'
    const icon = type === 'success' ? 'fa-check-circle' : type === 'error' ? 'fa-exclamation-circle' : 'fa-info-circle'
    toast.className = `${bgColor} text-white px-4 py-3 rounded-lg shadow-lg flex items-center gap-2 text-sm transform translate-x-full opacity-0 transition-all duration-300`
    toast.innerHTML = `<i class="fas ${icon}"></i>`
    const msgSpan = document.createElement('span')
    msgSpan.textContent = message
    toast.appendChild(msgSpan)
    container.appendChild(toast)
    
    // 애니메이션으로 표시
    requestAnimationFrame(() => {
      toast.classList.remove('translate-x-full', 'opacity-0')
    })
    
    // 자동 제거
    setTimeout(() => {
      toast.classList.add('translate-x-full', 'opacity-0')
      setTimeout(() => toast.remove(), 300)
    }, duration)
  }

  const normalizePolicy = (policy) => {
    const next = { ...DEFAULT_POLICY, moderatorRoles: [...DEFAULT_MODERATOR_ROLES] }
    if (!policy || typeof policy !== 'object') {
      return next
    }

    if (typeof policy.requiresAuth === 'boolean') {
      next.requiresAuth = policy.requiresAuth
    }

    const assignNumber = (key, value) => {
      const numeric = typeof value === 'string' ? Number(value) : value
      if (Number.isFinite(numeric)) {
        next[key] = Number(numeric)
      }
    }

    assignNumber('bestLikeThreshold', policy.bestLikeThreshold)
    assignNumber('bestLimit', policy.bestLimit)
    assignNumber('reportBlindThreshold', policy.reportBlindThreshold)
    assignNumber('dailyVoteLimit', policy.dailyVoteLimit)
    assignNumber('voteWindowHours', policy.voteWindowHours)

    if (typeof policy.ipDisplayMode === 'string' && ['hash', 'masked', 'hidden'].includes(policy.ipDisplayMode)) {
      next.ipDisplayMode = policy.ipDisplayMode
    }

    if (typeof policy.moderatorIpBlockEnabled === 'boolean') {
      next.moderatorIpBlockEnabled = policy.moderatorIpBlockEnabled
    }

    if (Array.isArray(policy.moderatorRoles)) {
      const roles = policy.moderatorRoles
        .map((role) => (typeof role === 'string' ? role.trim() : ''))
        .filter((role) => role.length)
      next.moderatorRoles = roles.length ? Array.from(new Set(roles)) : [...DEFAULT_MODERATOR_ROLES]
    }

    return next
  }

  const policiesEqual = (a, b) => JSON.stringify(a ?? null) === JSON.stringify(b ?? null)

  const readPolicyFromDataset = (section) => {
    const policyJson = section?.dataset?.commentPolicyJson
    if (!policyJson) {
      return null
    }
    try {
      const parsed = JSON.parse(policyJson)
      return normalizePolicy(parsed)
    } catch (error) {
      return null
    }
  }

  const buildGovernancePayload = (policy, signature) => {
    if (!policy || typeof policy !== 'object') {
      return null
    }
    const roles = Array.isArray(policy.moderatorRoles) ? policy.moderatorRoles : []
    return {
      requiresAuth: Boolean(policy.requiresAuth),
      bestLikeThreshold: typeof policy.bestLikeThreshold === 'number' ? policy.bestLikeThreshold : null,
      bestLimit: typeof policy.bestLimit === 'number' ? policy.bestLimit : null,
      reportBlindThreshold: typeof policy.reportBlindThreshold === 'number' ? policy.reportBlindThreshold : null,
      dailyVoteLimit: typeof policy.dailyVoteLimit === 'number' ? policy.dailyVoteLimit : null,
      voteWindowHours: typeof policy.voteWindowHours === 'number' ? policy.voteWindowHours : null,
      ipDisplayMode: typeof policy.ipDisplayMode === 'string' ? policy.ipDisplayMode : null,
      moderatorIpBlockEnabled: Boolean(policy.moderatorIpBlockEnabled),
      moderatorRoles: roles,
      signature: signature ?? computePolicySignature(policy)
    }
  }

  const getGovernanceFromState = (state) => buildGovernancePayload(state?.policy, state?.policySignature)

  const escapeHtml = (value = '') =>
    String(value)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;')

  const formatContent = (value = '') => {
    if (!value) return ''
    // 내부 링크 파싱: [[job:slug]], [[major:slug]], [[howto:slug]] 형식 지원
    let formatted = escapeHtml(value)
      .replace(/\[\[job:([^\]]+)\]\]/g, '<a href="/job/$1" class="text-wiki-primary hover:text-wiki-secondary underline">$1</a>')
      .replace(/\[\[major:([^\]]+)\]\]/g, '<a href="/major/$1" class="text-wiki-primary hover:text-wiki-secondary underline">$1</a>')
      .replace(/\[\[howto:([^\]]+)\]\]/g, '<a href="/howto/$1" class="text-wiki-primary hover:text-wiki-secondary underline">$1</a>')
      .replace(/(?:\r\n|\n\r|\n|\r)/g, '<br>')
    return formatted
  }

  const formatDate = (value) => {
    if (!value) {
      return ''
    }
    const date = new Date(value)
    if (Number.isNaN(date.getTime())) {
      return ''
    }
    try {
      return date.toLocaleString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
      })
    } catch (error) {
      return ''
    }
  }

  const setStatus = (section, message, tone = 'neutral') => {
    const statusEl = section.querySelector('[data-cw-comment-status]')
    if (!statusEl) return
    statusEl.textContent = message || ''
    statusEl.dataset.tone = tone
  }

  const setPasswordWarning = (section, message, tone = 'info') => {
    const warningEl = section.querySelector('[data-cw-comment-password-warning]')
    if (!warningEl) return
    warningEl.textContent = message || ''
    const hasMessage = Boolean(message)
    warningEl.hidden = !hasMessage
    warningEl.dataset.tone = tone
    warningEl.classList.remove('text-wiki-muted', 'text-amber-300', 'text-red-400', 'text-wiki-text')
    if (!hasMessage) {
      return
    }
    if (tone === 'error') {
      warningEl.classList.add('text-red-400')
    } else if (tone === 'warn') {
      warningEl.classList.add('text-amber-300')
    } else {
      warningEl.classList.add('text-wiki-text')
    }
  }

  const showReplyIndicator = (section, target) => {
    const indicator = section.querySelector('[data-cw-comment-reply-indicator]')
    const label = section.querySelector('[data-cw-comment-reply-label]')
    if (!indicator || !label) return
    if (!target) {
      indicator.hidden = true
      indicator.setAttribute('hidden', '')
      label.textContent = ''
      return
    }
    label.textContent = target.label || ''
    indicator.hidden = false
    indicator.removeAttribute('hidden')
  }

  const closeReplyBoxes = (section, state) => {
    section.querySelectorAll('[data-cw-reply-box]').forEach((box) => {
      box.classList.add('hidden')
      const warning = box.querySelector('[data-cw-reply-warning]')
      const password = box.querySelector('[data-cw-reply-password]')
      const textarea = box.querySelector('[data-cw-reply-content]')
      if (warning) {
        warning.textContent = ''
        warning.setAttribute('hidden', '')
      }
      if (password instanceof HTMLInputElement) {
        password.value = ''
      }
      if (textarea instanceof HTMLTextAreaElement) {
        textarea.value = ''
      }
    })
    state.replyOpenId = null
  }

  const openReplyBox = (section, state, commentId, label) => {
    closeReplyBoxes(section, state)
    const box = section.querySelector(`[data-cw-reply-box][data-parent-id="${commentId}"]`)
    if (!box) return
    box.classList.remove('hidden')
    const textarea = box.querySelector('[data-cw-reply-content]')
    const password = box.querySelector('[data-cw-reply-password]')
    const warning = box.querySelector('[data-cw-reply-warning]')
    const identity = box.querySelector('[data-cw-reply-identity]')
    if (identity) {
      if (state.viewer?.id) {
        identity.textContent = state.viewer?.username || state.viewer?.id
      } else {
        identity.textContent = state.viewerIp ? `익명 (${state.viewerIp})` : '익명'
      }
    }
    if (warning) {
      warning.textContent = ''
      warning.setAttribute('hidden', '')
    }
    if (password instanceof HTMLInputElement) {
      password.value = ''
      // 비로그인 시 표시, 로그인 시 숨김
      if (state.viewer?.id) {
        password.classList.add('hidden')
        password.setAttribute('aria-hidden', 'true')
      } else {
        password.classList.remove('hidden')
        password.removeAttribute('aria-hidden')
      }
    }
    if (textarea instanceof HTMLTextAreaElement) {
      textarea.value = ''
      textarea.focus()
    }
    state.replyOpenId = commentId
  }

  const clearReplyTarget = (section, state) => {
    closeReplyBoxes(section, state)
  }

  const setReplyWarning = (box, message, tone = 'error') => {
    const warning = box.querySelector('[data-cw-reply-warning]')
    if (!warning) return
    warning.textContent = message || ''
    const has = Boolean(message)
    if (has) {
      warning.removeAttribute('hidden')
      warning.classList.remove('text-amber-300', 'text-wiki-text')
      if (tone === 'warn') {
        warning.classList.add('text-amber-300')
      } else {
        warning.classList.add('text-red-400')
      }
    } else {
      warning.setAttribute('hidden', '')
    }
  }

  const handleReplySubmit = async (section, state, button) => {
    const box = button.closest('[data-cw-reply-box]')
    if (!box) return
    const parentId = Number(box.getAttribute('data-parent-id'))
    if (!Number.isFinite(parentId) || parentId <= 0) {
      return
    }

    const textarea = box.querySelector('[data-cw-reply-content]')
    const passwordInput = box.querySelector('[data-cw-reply-password]')
    const content = textarea instanceof HTMLTextAreaElement ? textarea.value.trim() : ''
    const password = passwordInput instanceof HTMLInputElement ? passwordInput.value.trim() : ''

    if (!content) {
      setReplyWarning(box, '답글 내용을 입력해주세요.')
      return
    }

    if (!state.viewer?.id) {
      if (!password) {
        setReplyWarning(box, '익명 답글은 숫자 4자리 비밀번호가 필요합니다.')
        return
      }
      if (!/^\d{4}$/.test(password)) {
        setReplyWarning(box, '비밀번호는 숫자 4자리로 입력해주세요.')
        return
      }
    }

    setReplyWarning(box, '')
    button.disabled = true
    try {
      const response = await fetch('/api/comments', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          entityType: state.entityType,
          slug: state.entitySlug,
          title: state.entityName || state.entitySlug,
          summary: state.entitySummary || null,
          nickname: state.viewer?.id ? (state.viewer?.username ?? state.viewer?.id ?? null) : undefined,
          content,
          parentId,
          password: state.viewer?.id ? undefined : (password || undefined)
        })
      })
      const payload = await response.json().catch(() => ({}))
      if (!response.ok || !payload?.success) {
        throw new Error((payload && payload.error) || `HTTP ${response.status}`)
      }
      closeReplyBoxes(section, state)
      setStatus(section, '답글이 등록되었습니다.', 'success')
      await loadComments(section, state, { silent: true })
    } catch (error) {
      setReplyWarning(box, '답글 등록에 실패했습니다. 잠시 후 다시 시도해주세요.')
    } finally {
      button.disabled = false
    }
  }

  const closeMenus = (section, state) => {
    section.querySelectorAll('[data-cw-comment-menu-panel]').forEach((panel) => {
      panel.classList.add('hidden')
      panel.setAttribute('aria-hidden', 'true')
    })
    section.querySelectorAll('[data-cw-comment-menu]').forEach((btn) => {
      btn.setAttribute('aria-expanded', 'false')
    })
    section.querySelectorAll('[data-comment-id]').forEach((card) => {
      card.style.zIndex = ''
      card.style.position = ''
    })
    state.openMenuId = null
  }

  const toggleMenu = (section, state, menuId) => {
    const panel = section.querySelector(`[data-cw-comment-menu-panel][data-menu-id="${menuId}"]`)
    const button = section.querySelector(`[data-cw-comment-menu][data-menu-id="${menuId}"]`)
    if (!panel || !button) return
    const isOpen = state.openMenuId === menuId && !panel.classList.contains('hidden')
    closeMenus(section, state)
    if (isOpen) return
    
    // 해당 댓글 카드의 z-index를 높여서 메뉴가 다른 카드에 가려지지 않도록 함
    const commentCard = button.closest('[data-comment-id]')
    if (commentCard) {
      commentCard.style.position = 'relative'
      commentCard.style.zIndex = '50'
    }

    panel.classList.remove('hidden')
    panel.setAttribute('aria-hidden', 'false')
    button.setAttribute('aria-expanded', 'true')
    state.openMenuId = menuId
  }

  const toggleLoading = (section, isLoading) => {
    const loader = section.querySelector('[data-cw-comments-loading]')
    if (loader) {
      // hidden 속성과 style.display 모두 설정하여 확실히 숨김/표시
      if (isLoading) {
        loader.hidden = false
        loader.style.display = 'flex'
        loader.removeAttribute('hidden')
      } else {
        loader.hidden = true
        loader.style.display = 'none'
        loader.setAttribute('hidden', '')
      }
    }
    const bodyRegion = section.querySelector('[data-cw-comments-body]')
    if (bodyRegion) {
      bodyRegion.setAttribute('aria-busy', isLoading ? 'true' : 'false')
    }
  }

  const updateEmptyState = (section, hasComments) => {
    const legacyEmpty = section.querySelector('[data-cw-comments-empty]')
    const legacyList = section.querySelector('[data-cw-comments-list]')
    if (legacyEmpty) {
      legacyEmpty.hidden = hasComments
      legacyEmpty.style.display = hasComments ? 'none' : ''
      if (hasComments) {
        legacyEmpty.setAttribute('aria-hidden', 'true')
      } else {
        legacyEmpty.removeAttribute('aria-hidden')
      }
    }
    if (legacyList) {
      legacyList.hidden = !hasComments
      legacyList.style.display = hasComments ? '' : 'none'
    }
    section.querySelectorAll('[data-comment-empty]').forEach((el) => {
      const type = el.getAttribute('data-comment-empty')
      // BEST 비어있음 상태는 전체 댓글 존재 여부와 무관하게 표시 제어
      if (type === 'best') {
        return
      }
      el.hidden = hasComments
      el.style.display = hasComments ? 'none' : ''
      if (hasComments) {
        el.setAttribute('aria-hidden', 'true')
      } else {
        el.removeAttribute('aria-hidden')
      }
    })
  }

  const hideAllEmptyStates = (section) => {
    updateEmptyState(section, true)
  }

  const ensureBestThreshold = (state) => {
    if (state && typeof state.bestThreshold === 'number' && Number.isFinite(state.bestThreshold) && state.bestThreshold >= 0) {
      return state.bestThreshold
    }
    if (state?.policy && typeof state.policy.bestLikeThreshold === 'number' && Number.isFinite(state.policy.bestLikeThreshold)) {
      state.bestThreshold = state.policy.bestLikeThreshold
      return state.bestThreshold
    }
    state.bestThreshold = DEFAULT_POLICY.bestLikeThreshold
    return state.bestThreshold
  }

  const sortCommentList = (comments, sortKey) => {
    if (!Array.isArray(comments)) {
      return []
    }
    const cloned = comments.slice()
    if (sortKey === 'likes') {
      cloned.sort((a, b) => {
        const likeDiff = (b?.likes ?? 0) - (a?.likes ?? 0)
        if (likeDiff !== 0) {
          return likeDiff
        }
        const dislikeDiff = (a?.dislikes ?? 0) - (b?.dislikes ?? 0)
        if (dislikeDiff !== 0) {
          return dislikeDiff
        }
        const dateDiff = new Date(b?.createdAt ?? 0).getTime() - new Date(a?.createdAt ?? 0).getTime()
        return Number.isNaN(dateDiff) ? 0 : dateDiff
      })
    } else {
      cloned.sort((a, b) => new Date(b?.createdAt ?? 0).getTime() - new Date(a?.createdAt ?? 0).getTime())
    }
    return cloned
  }

  const summarizeCommentCollections = (state) => {
    const comments = Array.isArray(state?.comments) ? state.comments.slice() : []
    const bestThreshold = ensureBestThreshold(state)
    const sortKey = state?.sort === 'likes' ? 'likes' : 'latest'
    const bestCandidates = bestThreshold > 0
      ? comments.filter((comment) => (comment?.likes ?? 0) >= bestThreshold)
      : []
    const sortedAll = sortCommentList(comments, sortKey)
    const sortedBest = sortCommentList(bestCandidates, 'likes')
    return { comments, sortedAll, sortedBest, bestThreshold, sortKey }
  }

  const setInlineActionError = (section, commentId, message = '', durationMs = 0) => {
    const spans = section.querySelectorAll(`[data-cw-like-error][data-comment-id="${commentId}"]`)
    spans.forEach((el) => {
      el.textContent = message || ''
      el.hidden = !message
      if (message && durationMs > 0) {
        window.setTimeout(() => {
          el.textContent = ''
          el.hidden = true
        }, durationMs)
      }
    })
  }

  const updateSortButtons = (section, state) => {
    const buttons = section.querySelectorAll('[data-comment-sort]')
    const activeKey = state?.sort === 'likes' ? 'likes' : 'latest'
    buttons.forEach((button) => {
      const target = button.getAttribute('data-comment-sort') === 'likes' ? 'likes' : 'latest'
      const isActive = target === activeKey
      button.setAttribute('aria-pressed', isActive ? 'true' : 'false')
      // 활성 상태: 파란 배경 + 흰 텍스트
      button.classList.toggle('bg-wiki-primary', isActive)
      button.classList.toggle('text-white', isActive)
      button.classList.toggle('shadow-sm', isActive)
      button.classList.toggle('border-wiki-primary/60', isActive)
      // 비활성 상태: 투명 배경 + 회색 텍스트 (배경과 대비되도록)
      button.classList.toggle('bg-transparent', !isActive)
      button.classList.toggle('text-gray-300', !isActive)
      button.classList.toggle('border-transparent', !isActive)
      // 기존 text-wiki-muted 제거 (배경과 비슷해서 안 보임)
      button.classList.remove('text-wiki-muted')
      button.classList.remove('text-wiki-primary')
    })
  }

  const updateTabButtons = (section, state) => {
    const triggers = section.querySelectorAll('[data-comment-tab]')
    const activeTab = state?.activeTab === 'best' ? 'best' : 'all'
    if (section instanceof HTMLElement) {
      section.dataset.commentActiveTab = activeTab
    }
    triggers.forEach((trigger) => {
      const target = trigger.getAttribute('data-comment-tab') === 'best' ? 'best' : 'all'
      const isActive = target === activeTab
      trigger.setAttribute('aria-selected', isActive ? 'true' : 'false')
      // 활성 상태: 파란 배경 + 흰 텍스트
      trigger.classList.toggle('bg-wiki-primary', isActive)
      trigger.classList.toggle('text-white', isActive)
      trigger.classList.toggle('shadow-sm', isActive)
      trigger.classList.toggle('border-wiki-primary/50', isActive)
      // 비활성 상태: 밝은 회색 텍스트 (배경과 대비)
      trigger.classList.toggle('text-gray-300', !isActive)
      trigger.classList.toggle('border-transparent', !isActive)
      // 기존 스타일 제거
      trigger.classList.remove('text-wiki-muted')
    })
    const panels = section.querySelectorAll('[data-comment-panel]')
    panels.forEach((panel) => {
      const target = panel.getAttribute('data-comment-panel') === 'best' ? 'best' : 'all'
      const isActive = target === activeTab
      panel.hidden = !isActive
      panel.setAttribute('aria-hidden', isActive ? 'false' : 'true')
    })
  }

  const refreshScoreboardCopy = (section, state) => {
    // scoreboard 제거 - 사용자 요청에 따라 정보 박스 제거
    const scoreboard = section.querySelector('[data-cw-comment-scoreboard]')
    if (scoreboard) {
      scoreboard.hidden = true
    }
  }

  const computeCommentStats = (comments) => {
    if (!Array.isArray(comments) || !comments.length) {
      return { total: Array.isArray(comments) ? comments.length : 0, best: 0, blinded: 0 }
    }
    let best = 0
    let blinded = 0
    comments.forEach((comment) => {
      if (!comment || typeof comment !== 'object') {
        return
      }
      if (comment.isBest) {
        best += 1
      }
      if (comment.status && comment.status !== 'visible') {
        blinded += 1
      }
      if (Array.isArray(comment.replies) && comment.replies.length) {
        comment.replies.forEach((reply) => {
          if (reply && reply.status && reply.status !== 'visible') {
            blinded += 1
          }
        })
      }
    })
    return { total: comments.length, best, blinded }
  }

  const updateScoreboard = (section, state, stats) => {
    // scoreboard 제거 - 사용자 요청에 따라 정보 박스 제거
    const scoreboard = section.querySelector('[data-cw-comment-scoreboard]')
    if (scoreboard) {
      scoreboard.hidden = true
    }
  }

  const updateAuthCta = (section, state) => {
    // 익명 사용자도 댓글 작성 가능하므로 CTA 항상 숨김
    const cta = section.querySelector('[data-cw-comment-auth-cta]')
    if (cta) {
      cta.hidden = true
    }
  }

  const updateGuidance = (section, state, stats) => {
    const guidanceEl = section.querySelector('[data-cw-comment-guidance]')
    if (!guidanceEl) return

    // 정책 안내 문구 제거 - 사용자 요청에 따라 모든 안내 문구 제거
    guidanceEl.hidden = true
    guidanceEl.textContent = ''
  }

  const updatePolicySummary = (section, policy) => {
    const el = section.querySelector('[data-cw-comment-policy]')
    if (!el) return
    // 정책 안내 문구 제거 - 사용자 요청에 따라 모든 안내 문구 제거
    el.hidden = true
    el.textContent = ''
  }

  const isModeratorRole = (role, state) => {
    if (!role) {
      return false
    }
    const roles = Array.isArray(state?.policy?.moderatorRoles) && state.policy.moderatorRoles.length
      ? state.policy.moderatorRoles
      : DEFAULT_MODERATOR_ROLES
    return roles.includes(role)
  }

  const applyAuthState = (section, state) => {
    const form = section.querySelector('[data-cw-comment-form]')
    const authNotice = section.querySelector('[data-cw-comment-auth]')
    const authCta = section.querySelector('[data-cw-comment-auth-cta]')
    const globalUser = (typeof window !== 'undefined' && window.__USER__) ? window.__USER__ : null
    const effectiveViewer = state.viewer ?? globalUser ?? null
    const effectiveRole = effectiveViewer?.role || state.viewerRole || 'user'
    const hasViewer = Boolean(effectiveViewer?.id) || effectiveRole === 'admin'

    // 로그인 CTA 숨기기 (익명 사용자도 댓글 작성 가능)
    if (authCta) {
      authCta.hidden = true
    }

    if (form) {
      // 폼은 항상 활성화 (익명 사용자도 작성 가능)
      const controls = form.querySelectorAll('input, textarea, button')
      controls.forEach((control) => {
        if (control instanceof HTMLButtonElement || control instanceof HTMLInputElement || control instanceof HTMLTextAreaElement) {
          control.disabled = false
        }
      })

      const nicknameWrapper = form.querySelector('[data-cw-comment-nickname-wrapper]')
      const nicknameInput = form.querySelector('[data-cw-comment-nickname]')
      const nicknameDisplay = form.querySelector('[data-cw-comment-nickname-display]')
      const ipDisplay = form.querySelector('[data-cw-comment-ip-display]')
      const anonymousLabel = form.querySelector('[data-cw-comment-anonymous-label]')
      const anonymousNumberEl = form.querySelector('[data-cw-comment-anonymous-number]')
      const anonIpEl = form.querySelector('[data-cw-comment-current-ip]')
      const passwordInput = form.querySelector('[data-cw-comment-password]')
      const contentTextarea = form.querySelector('[data-cw-comment-content]')
      const charCountEl = form.querySelector('[data-cw-comment-char-count]')

      const nicknamePrefill = nicknameInput instanceof HTMLInputElement ? (nicknameInput.value || '').trim() : ''
      const derivedHasViewer = hasViewer || Boolean(nicknamePrefill && nicknamePrefill !== '익명')

      // 익명 사용자: 닉네임 입력 필드 숨김, 익명 번호 표시
      // 로그인 사용자: 닉네임 표시, 비밀번호 숨김
      if (!derivedHasViewer) {
        // 익명 사용자 - 닉네임 입력 필드 숨김, 익명 번호 표시
        if (nicknameWrapper instanceof HTMLElement) {
          nicknameWrapper.hidden = true
        }
        if (nicknameInput instanceof HTMLInputElement) {
          nicknameInput.required = false
          nicknameInput.removeAttribute('aria-required')
        }
        if (anonymousLabel instanceof HTMLElement) {
          anonymousLabel.hidden = false
          anonymousLabel.style.display = ''
          if (anonymousNumberEl) {
            anonymousNumberEl.textContent = '익명'
          }
          if (anonIpEl instanceof HTMLElement) {
            anonIpEl.textContent = state.viewerIp ? `(${state.viewerIp})` : ''
            anonIpEl.hidden = !state.viewerIp
          }
          // 비밀번호 입력칸을 익명 번호와 같은 컨테이너에 있으므로 자동으로 표시됨
          if (passwordInput instanceof HTMLInputElement) {
            passwordInput.required = true
            passwordInput.setAttribute('aria-required', 'true')
            passwordInput.hidden = false
          }
          if (nicknameDisplay instanceof HTMLElement) {
            nicknameDisplay.hidden = true
            nicknameDisplay.textContent = ''
          }
          if (ipDisplay instanceof HTMLElement) {
            ipDisplay.hidden = true
            ipDisplay.textContent = ''
          }
        }
      } else {
        // 로그인/관리자 사용자
        if (nicknameWrapper instanceof HTMLElement) {
          nicknameWrapper.hidden = false
        }
        if (nicknameInput instanceof HTMLInputElement) {
          nicknameInput.hidden = true
          nicknameInput.required = false
          nicknameInput.removeAttribute('aria-required')
          nicknameInput.placeholder = ''
          nicknameInput.value = ''
          // 닉네임 소스가 없다면 입력 허용
          const hasViewerNickname = Boolean(effectiveViewer?.username)
          if (!hasViewerNickname && !nicknamePrefill) {
            nicknameInput.hidden = false
            nicknameInput.placeholder = '닉네임을 입력하세요'
            nicknameInput.value = ''
          }
        }
        if (nicknameDisplay instanceof HTMLElement) {
          const fallbackName =
            nicknamePrefill ||
            effectiveViewer?.username ||
            (effectiveRole === 'admin'
              ? '관리자'
              : (effectiveViewer?.id ? `user_${effectiveViewer.id}` : ''))
          nicknameDisplay.textContent = fallbackName
          nicknameDisplay.hidden = false
          nicknameDisplay.classList.remove('hidden')
        }
        // 프로필 이미지 표시
        const avatarEl = form.querySelector('[data-cw-comment-author-avatar]')
        if (avatarEl instanceof HTMLElement) {
          const pictureUrl = effectiveViewer?.pictureUrl
          if (pictureUrl) {
            avatarEl.innerHTML = `<img src="${escapeHtml(pictureUrl)}" alt="프로필" class="w-6 h-6 rounded-full object-cover" />`
          } else {
            avatarEl.innerHTML = `<i class="fas fa-user-circle text-sm text-wiki-muted"></i>`
          }
          avatarEl.hidden = false
          avatarEl.classList.remove('hidden')
          avatarEl.style.display = ''
        }
        if (ipDisplay instanceof HTMLElement) {
          ipDisplay.textContent = state.viewerIp ? `(${state.viewerIp})` : ''
          ipDisplay.hidden = !state.viewerIp
          if (state.viewerIp) {
            ipDisplay.classList.remove('hidden')
          } else {
            ipDisplay.classList.add('hidden')
          }
        }
        if (anonymousLabel instanceof HTMLElement) {
          anonymousLabel.hidden = true
          anonymousLabel.style.display = 'none'
        }
        if (anonIpEl instanceof HTMLElement) {
          anonIpEl.textContent = ''
          anonIpEl.hidden = true
        }
        if (passwordInput instanceof HTMLInputElement) {
          passwordInput.required = false
          passwordInput.removeAttribute('aria-required')
          passwordInput.hidden = true
        }
        const adminBadge = form.querySelector('[data-cw-comment-admin-badge]')
        if (adminBadge instanceof HTMLElement) {
          adminBadge.hidden = effectiveRole !== 'admin'
        }
        if (nicknameDisplay instanceof HTMLElement) {
          nicknameDisplay.hidden = false
        }
        if (ipDisplay instanceof HTMLElement) {
          ipDisplay.hidden = !state.viewerIp
        }
      }

      setPasswordWarning(section, '')

      // 글자 수 카운터
      if (contentTextarea instanceof HTMLTextAreaElement && charCountEl) {
        const updateCharCount = () => {
          const length = contentTextarea.value.length
          charCountEl.textContent = `${length} / 500자`
          if (length > 500) {
            charCountEl.classList.add('text-red-400')
            charCountEl.classList.remove('text-wiki-muted')
          } else {
            charCountEl.classList.remove('text-red-400')
            charCountEl.classList.add('text-wiki-muted')
          }
        }
        contentTextarea.addEventListener('input', updateCharCount)
        updateCharCount()
      }

      delete form.dataset.commentDisabled
    }

    if (authNotice) {
      authNotice.hidden = true
      authNotice.textContent = ''
    }

    updateAuthCta(section, state)
    updateGuidance(section, state, computeCommentStats(state.comments))
  }

  const renderThread = (comment, state, depth = 0) => {
    const createdAt = formatDate(comment.createdAt)
    const baseClasses =
      depth === 0
        ? 'glass-card p-4 rounded-xl border border-wiki-border bg-wiki-bg/70'
        : 'p-3 rounded-lg border border-wiki-border/50 bg-wiki-bg/50'
    const containerClasses = comment.isBest ? `${baseClasses} ring-1 ring-wiki-secondary/50` : baseClasses
    const badges = []
    if (comment.isBest) {
      badges.push('<span class="px-2 py-0.5 text-[11px] font-semibold text-wiki-secondary bg-wiki-secondary/10 rounded-full">BEST<span class="sr-only"> · 추천 많은 댓글</span></span>')
    }
    if (comment.status !== 'visible') {
      badges.push('<span class="px-2 py-0.5 text-[11px] font-semibold text-amber-300 bg-amber-500/10 rounded-full">블라인드<span class="sr-only"> · 신고 누적으로 숨겨진 댓글</span></span>')
    }
    if (comment.isEdited) {
      badges.push('<span class="px-2 py-0.5 text-[11px] font-semibold text-wiki-muted bg-wiki-border/40 rounded-full">수정됨</span>')
    }

    const statusLabels = []
    if (comment.isBest) {
      statusLabels.push('베스트 댓글')
    }
    if (comment.status !== 'visible') {
      statusLabels.push('블라인드 처리됨')
    }
    if (comment.isEdited) {
      statusLabels.push('수정됨')
    }
    const srStatusText = statusLabels.length ? `<span class="sr-only">(${statusLabels.join(', ')})</span>` : ''

    const moderatorInfo = isModeratorRole(state.viewerRole, state)
      ? `<span class="inline-flex items-center gap-1 text-[11px] text-wiki-muted" aria-label="신고 ${comment.reportCount ?? 0}회"><i class="fas fa-flag" aria-hidden="true"></i>${comment.reportCount ?? 0}</span>`
      : ''

    const isAdmin =
      state.viewerRole === 'admin' ||
      state.viewerRole === 'super-admin' ||
      state.viewerRole === 'operator'
    const isOwner = comment.authorId && state.viewer?.id && String(state.viewer.id) === String(comment.authorId)
    const isAnonymousOwner = comment.isAnonymous && !comment.authorId
    const canEditOrDelete = isAdmin || isOwner || isAnonymousOwner

    const contentHtml = comment.status === 'blinded'
      ? `<div class="text-sm text-wiki-muted leading-relaxed italic" data-cw-comment-body>일시적으로 블라인드 처리 되었습니다.</div>`
      : (comment.status === 'visible'
        ? `<div class="text-sm text-wiki-text leading-relaxed" data-cw-comment-body>${formatContent(comment.content || '')}</div>`
        : `<div class="text-sm text-wiki-muted leading-relaxed italic" data-cw-comment-body>${formatContent(comment.content || '')}</div>`)

    const replies =
      Array.isArray(comment.replies) && comment.replies.length
        ? `<ul class="mt-3 space-y-3 border-l border-wiki-border/50 pl-4">${comment.replies
            .map((reply) => renderThread(reply, state, depth + 1))
            .join('')}</ul>`
        : ''

    const likeActive = comment.viewerVote === 1
    const dislikeActive = comment.viewerVote === -1
    const editedAt = comment.editedAt ? formatDate(comment.editedAt) : null
    const isAuthorOperator = comment.authorRole === 'admin' || comment.authorRole === 'super-admin' || comment.authorRole === 'operator'
    const displayNickname = comment.nickname || (comment.isAnonymous && comment.anonymousNumber ? `익명 ${comment.anonymousNumber}` : '익명')
    const adminBadge = isAuthorOperator
      ? '<span class="px-2 py-0.5 text-[11px] font-semibold text-white bg-red-500/20 rounded-full">운영자</span>'
      : ''
    const commentLabelParts = [
      `${displayNickname}님의 댓글`,
      createdAt ? `작성 ${createdAt}` : null,
      editedAt && comment.isEdited ? `수정 ${editedAt}` : null,
      statusLabels.length ? statusLabels.join(', ') : null
    ].filter(Boolean)
    const commentAriaLabel = escapeHtml(commentLabelParts.join(', '))

    const menuId = `comment-menu-${comment.id}`
    // 익명 댓글에만 IP 표시 (괄호 형식)
    const displayIpTag = comment.isAnonymous && comment.displayIp
      ? `<span class="text-[11px] text-wiki-muted">(${escapeHtml(comment.displayIp)})</span>`
      : ''

    // 프로필 이미지: 로그인 유저의 경우 authorPictureUrl, 익명은 기본 아이콘
    const profileImageHtml = comment.authorPictureUrl && !comment.isAnonymous
      ? `<img src="${escapeHtml(comment.authorPictureUrl)}" alt="${escapeHtml(displayNickname)}" class="w-6 h-6 rounded-full object-cover flex-shrink-0" />`
      : `<div class="w-6 h-6 rounded-full bg-wiki-card flex items-center justify-center flex-shrink-0"><i class="fas fa-user-circle text-sm text-wiki-muted"></i></div>`

    return `
      <li id="comment-${comment.id}" data-comment-id="${comment.id}" data-comment-status="${comment.status}" data-comment-best="${comment.isBest ? '1' : '0'}" class="${containerClasses}" aria-label="${commentAriaLabel}">
        <article class="space-y-3">
          <header class="flex items-start justify-between gap-2 text-xs text-wiki-muted">
            <div style="min-width:0;flex:1">
              <div class="flex flex-wrap items-center gap-x-2 gap-y-1">
                ${profileImageHtml}
                <span class="font-bold text-wiki-text text-sm">${escapeHtml(displayNickname)}</span>
                ${adminBadge}
                ${displayIpTag}
                ${createdAt ? `<time class="text-wiki-muted" datetime="${escapeHtml(comment.createdAt)}">${escapeHtml(createdAt)}</time>` : ''}
                ${srStatusText}
              </div>
              ${badges.length ? `<div class="flex flex-wrap gap-1 mt-1">${badges.join('')}</div>` : ''}
            </div>
            <div class="relative flex items-center gap-2" style="flex-shrink:0">
              ${moderatorInfo}
              <button type="button" class="p-1 text-wiki-muted hover:text-wiki-text" data-cw-comment-menu data-menu-id="${menuId}" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-ellipsis-v"></i>
              </button>
              <div class="rounded-lg border border-wiki-border bg-wiki-bg shadow-lg hidden" style="position:absolute;right:0;top:100%;margin-top:4px;width:144px;z-index:9000;white-space:nowrap;" data-cw-comment-menu-panel data-menu-id="${menuId}" role="menu">
                <button type="button" class="w-full text-left px-3 py-2 text-sm hover:bg-wiki-border/30 flex items-center gap-2" data-cw-comment-flag data-comment-id="${comment.id}" data-requires-auth="1" role="menuitem">
                  <i class="fas fa-flag"></i>신고
                </button>
                ${isModeratorRole(state.viewerRole, state) ? `
                  <button type="button" class="w-full text-left px-3 py-2 text-sm hover:bg-wiki-border/30 flex items-center gap-2" data-cw-comment-admin-blind data-admin-blind-action="${comment.status === 'blinded' ? 'unblind' : 'blind'}" data-comment-id="${comment.id}" role="menuitem">
                    <i class="fas fa-eye-slash"></i>${comment.status === 'blinded' ? '블라인드 해제' : '블라인드'}
                  </button>
                ` : ''}
                ${canEditOrDelete ? `
                  <button type="button" class="w-full text-left px-3 py-2 text-sm hover:bg-wiki-border/30 flex items-center gap-2" data-cw-comment-edit data-comment-id="${comment.id}" role="menuitem">
                    <i class="fas fa-pen"></i>수정
                  </button>
                  <button type="button" class="w-full text-left px-3 py-2 text-sm hover:bg-wiki-border/30 flex items-center gap-2 text-red-400" data-cw-comment-delete data-comment-id="${comment.id}" role="menuitem">
                    <i class="fas fa-trash"></i>삭제
                  </button>
                ` : ''}
              </div>
            </div>
          </header>
          ${contentHtml}
          <footer class="flex items-center gap-4 text-xs">
            <button type="button" class="inline-flex items-center gap-1 ${likeActive ? 'text-wiki-primary' : 'text-wiki-muted hover:text-wiki-primary transition'}" data-cw-comment-like data-comment-id="${comment.id}" data-requires-auth="1" aria-pressed="${likeActive ? 'true' : 'false'}" aria-label="공감 ${comment.likes ?? 0}회" title="공감 ${comment.likes ?? 0}">
              <i class="fas fa-thumbs-up"></i><span data-cw-comment-like-count>${comment.likes ?? comment.likeCount ?? 0}</span>
            </button>
            <button type="button" class="inline-flex items-center gap-1 ${dislikeActive ? 'text-rose-300' : 'text-wiki-muted hover:text-wiki-text transition'}" data-cw-comment-dislike data-comment-id="${comment.id}" data-requires-auth="1" aria-pressed="${dislikeActive ? 'true' : 'false'}" aria-label="비공감 ${comment.dislikes ?? 0}회" title="비공감 ${comment.dislikes ?? 0}">
              <i class="fas fa-thumbs-down"></i><span data-cw-comment-dislike-count>${comment.dislikes ?? comment.dislikeCount ?? 0}</span>
            </button>
            <button type="button" class="inline-flex items-center gap-1 text-wiki-muted hover:text-wiki-text transition" data-cw-comment-reply data-comment-id="${comment.id}" data-comment-label="${escapeHtml(displayNickname)}">
              <i class="fas fa-reply"></i>답글
            </button>
            <span class="text-xs text-red-400" data-cw-like-error data-comment-id="${comment.id}" hidden></span>
          </footer>
        </article>
        <div class="mt-3 space-y-2 hidden" data-cw-reply-box data-parent-id="${comment.id}">
          <form data-cw-reply-form class="space-y-2">
            <input type="text" name="username" autocomplete="username" aria-hidden="true" tabindex="-1" class="sr-only pointer-events-none" style="position:absolute;left:-9999px;width:1px;height:1px;opacity:0;">
            <textarea rows="3" maxlength="500" class="w-full px-3 py-2 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none text-sm" data-cw-reply-content aria-label="답글 입력"></textarea>
            <div class="flex flex-wrap items-center justify-between gap-3 text-xs text-wiki-muted">
              <div class="flex items-center gap-2 flex-1 min-w-[240px]">
                <span class="text-sm text-wiki-text" data-cw-reply-identity>익명</span>
                <input type="password" maxlength="4" pattern="[0-9]{4}" autocomplete="new-password" placeholder="비밀번호(익명 4자리)" class="px-3 py-2 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none text-sm" data-cw-reply-password aria-label="비밀번호">
                <span class="text-red-400 text-xs" data-cw-reply-warning hidden></span>
              </div>
              <div class="flex items-center gap-2">
                <button type="button" class="px-3 py-1 rounded-md border border-wiki-border text-wiki-text hover:border-wiki-primary" data-cw-reply-cancel>취소</button>
                <button type="submit" class="px-3 py-1 rounded-md bg-wiki-primary text-white hover:bg-blue-600" data-cw-reply-submit data-comment-id="${comment.id}">등록</button>
              </div>
            </div>
          </form>
        </div>
        ${replies}
      </li>
    `
  }

  const renderPagination = (section, state, { total, totalPages }) => {
    const container = section.querySelector('[data-cw-pagination]')
    if (!container) return
    if (totalPages <= 1) {
      container.innerHTML = ''
      container.hidden = true
      return
    }
    container.hidden = false
    const currentPage = state.page && state.page > 0 ? state.page : 1
    const startPage = Math.max(1, currentPage - 2)
    const endPage = Math.min(totalPages, currentPage + 2)

    const buttons = []
    const addBtn = (page, label, disabled = false, extraClass = '') => {
      buttons.push(`
        <button type="button"
          class="px-2 py-1 text-xs rounded border ${disabled ? 'border-wiki-border text-wiki-muted cursor-not-allowed' : 'border-wiki-border hover:border-wiki-primary transition'} ${extraClass}"
          ${disabled ? 'disabled' : ''}
          data-cw-page="${page}">
          ${label}
        </button>
      `)
    }

    addBtn(Math.max(1, currentPage - 1), '&laquo;', currentPage === 1)

    if (startPage > 1) {
      addBtn(1, '1')
      if (startPage > 2) {
        buttons.push(`<span class="px-1 text-wiki-muted">...</span>`)
      }
    }

    for (let p = startPage; p <= endPage; p++) {
      const active = p === currentPage
      addBtn(p, String(p), false, active ? 'bg-wiki-primary text-white border-wiki-primary' : '')
    }

    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        buttons.push(`<span class="px-1 text-wiki-muted">...</span>`)
      }
      addBtn(totalPages, String(totalPages))
    }

    addBtn(Math.min(totalPages, currentPage + 1), '&raquo;', currentPage === totalPages)

    container.innerHTML = `
      <div class="flex items-center justify-between px-4 py-3 border-t border-wiki-border/60">
        <div class="text-xs text-wiki-muted">총 ${total}개 · ${currentPage}/${totalPages}페이지</div>
        <div class="flex items-center gap-2">${buttons.join('')}</div>
      </div>
    `

    container.querySelectorAll('[data-cw-page]').forEach((btn) => {
      if (btn.dataset.cwPageBound === '1') return
      btn.dataset.cwPageBound = '1'
      btn.addEventListener('click', (e) => {
        e.preventDefault()
        const page = Number(btn.getAttribute('data-cw-page'))
        if (!Number.isFinite(page) || page < 1 || page > totalPages) return
        state.page = page
        renderComments(section, state)
      })
    })
  }

  const renderComments = (section, state) => {
    refreshScoreboardCopy(section, state)
    const PAGE_SIZE = 20
    const { sortedAll, sortedBest, bestThreshold, sortKey } = summarizeCommentCollections(state)

    const total = sortedAll.length
    const totalPages = Math.max(1, Math.ceil(total / PAGE_SIZE))
    if (!state.page || state.page < 1) state.page = 1
    if (state.page > totalPages) state.page = totalPages
    const start = (state.page - 1) * PAGE_SIZE
    const end = start + PAGE_SIZE
    const pagedAll = sortedAll.slice(start, end)

    const listAll = section.querySelector('[data-comment-list="all"]')
    if (listAll) {
      listAll.innerHTML = pagedAll.map((comment) => renderThread(comment, state)).join('')
    }

    const listBest = section.querySelector('[data-comment-list="best"]')
    if (listBest) {
      listBest.innerHTML = sortedBest.map((comment) => renderThread(comment, state)).join('')
    }

    renderPagination(section, state, { total, totalPages })

    const allEmptyEls = section.querySelectorAll('[data-comment-empty="all"]')
    allEmptyEls.forEach((el) => {
      const hasItems = sortedAll.length > 0
      el.hidden = hasItems
      if (hasItems) {
        el.setAttribute('aria-hidden', 'true')
      } else {
        el.removeAttribute('aria-hidden')
      }
    })

    const bestEmptyEls = section.querySelectorAll('[data-comment-empty="best"]')
    bestEmptyEls.forEach((el) => {
      const hasItems = sortedBest.length > 0
      el.hidden = hasItems
      if (hasItems) {
        el.setAttribute('aria-hidden', 'true')
      } else {
        el.removeAttribute('aria-hidden')
      }
    })

    const hasAny = sortedAll.length > 0 || sortedBest.length > 0
    updateEmptyState(section, hasAny)

    const stats = computeCommentStats(sortedAll)
    const scoreboard = section.querySelector('[data-cw-comment-scoreboard]')
    if (scoreboard) {
      scoreboard.hidden = stats.total === 0
      if (stats.total === 0) {
        scoreboard.setAttribute('aria-hidden', 'true')
      } else {
        scoreboard.removeAttribute('aria-hidden')
      }
    }
    updateScoreboard(section, state, stats)
    updateGuidance(section, state, stats)
    updateSortButtons(section, state)
    updateTabButtons(section, state)

    if (section instanceof HTMLElement) {
      section.dataset.commentAllCount = String(sortedAll.length)
      section.dataset.commentBestCount = String(sortedBest.length)
      section.dataset.commentBestThreshold = String(bestThreshold)
    }

    const visibleCount = state?.activeTab === 'best' ? sortedBest.length : sortedAll.length

    DetailTelemetry.emit('comments-render', {
      component: 'comments',
      entityType: state.entityType,
      entityId: state.entityId,
      count: stats.total,
      bestCount: sortedBest.length,
      blindedCount: stats.blinded,
      viewerRole: state.viewerRole,
      policySignature: state.policySignature ?? null,
      governance: getGovernanceFromState(state),
      sortKey,
      activeTab: state?.activeTab === 'best' ? 'best' : 'all',
      visibleCount
    })
  }

  const changeSort = (section, state, sortKey, source = 'user') => {
    const normalized = sortKey === 'likes' ? 'likes' : 'latest'
    const previous = state?.sort === 'likes' ? 'likes' : 'latest'
    if (normalized === previous) {
      updateSortButtons(section, state)
      return
    }
    state.sort = normalized
    renderComments(section, state)
    if (source === 'user') {
      const summary = summarizeCommentCollections(state)
      DetailTelemetry.emit('comments-sort-change', {
        component: 'comments-toolbar',
        entityType: state.entityType,
        entityId: state.entityId,
        sortKey: normalized,
        previousSort: previous,
        activeTab: state?.activeTab === 'best' ? 'best' : 'all',
        allCount: summary.sortedAll.length,
        bestCount: summary.sortedBest.length,
        policySignature: state.policySignature ?? null,
        governance: getGovernanceFromState(state)
      })
    }
  }

  const changeTab = (section, state, tabId, source = 'user') => {
    const normalized = tabId === 'best' ? 'best' : 'all'
    const previous = state?.activeTab === 'best' ? 'best' : 'all'
    if (normalized === previous) {
      updateTabButtons(section, state)
      return
    }
    state.sort = normalized === 'best' ? 'likes' : 'latest'
    state.activeTab = normalized
    renderComments(section, state)
    if (source === 'user') {
      const summary = summarizeCommentCollections(state)
      const visibleCount = normalized === 'best' ? summary.sortedBest.length : summary.sortedAll.length
      DetailTelemetry.emit('comments-tab-change', {
        component: 'comments-toolbar',
        entityType: state.entityType,
        entityId: state.entityId,
        tabId: normalized,
        previousTab: previous,
        visibleCount,
        allCount: summary.sortedAll.length,
        bestCount: summary.sortedBest.length,
        policySignature: state.policySignature ?? null,
        governance: getGovernanceFromState(state)
      })
    }
  }

  const bindSortButtons = (section, state) => {
    section.querySelectorAll('[data-comment-sort]').forEach((button) => {
      if (button.dataset.commentSortBound === '1') {
        return
      }
      button.dataset.commentSortBound = '1'
      button.addEventListener('click', () => {
        const sortKey = button.getAttribute('data-comment-sort') || 'latest'
        changeSort(section, state, sortKey, 'user')
      })
    })
  }

  const bindTabButtons = (section, state) => {
    section.querySelectorAll('[data-comment-tab]').forEach((button) => {
      if (button.dataset.commentTabBound === '1') {
        return
      }
      button.dataset.commentTabBound = '1'
      button.addEventListener('click', () => {
        const target = button.getAttribute('data-comment-tab') || 'all'
        changeTab(section, state, target, 'user')
      })
    })
  }

  const loadComments = async (section, state, options = {}) => {
    const silent = Boolean(options.silent)
    if (state.loading || !state.entitySlug) {
      return
    }
    state.loading = true
    if (!silent) {
      section.dataset.commentsStatus = 'loading'
      toggleLoading(section, true)
      setStatus(section, '')
    }
    if (state.policy && !state.policySignature) {
      state.policySignature = computePolicySignature(state.policy)
    }
    DetailTelemetry.emit('comments-load', {
      component: 'comments',
      entityType: state.entityType,
      entityId: state.entityId,
      phase: 'start',
      policySource: state.policy ? 'dataset' : 'unknown',
      policySignature: state.policySignature ?? null,
      governance: getGovernanceFromState(state)
    })

    try {
      const params = new URLSearchParams({
        entityType: state.entityType,
        slug: state.entitySlug,
        limit: '50'
      })
      if (state.entityName) {
        params.set('title', state.entityName)
      }
      if (state.entitySummary) {
        params.set('summary', state.entitySummary)
      }

      const controller = typeof AbortController !== 'undefined' ? new AbortController() : null
      const timeoutId = typeof window !== 'undefined' && controller ? window.setTimeout(() => {
        try {
          controller.abort()
        } catch (err) {
        }
      }, 10000) : null

      let response
      try {
        response = await fetch(`/api/comments?${params.toString()}`, {
          headers: { Accept: 'application/json', 'Cache-Control': 'no-cache' },
          cache: 'no-store',
          signal: controller ? controller.signal : undefined
        })
      } finally {
        if (timeoutId) {
          clearTimeout(timeoutId)
        }
      }

      let payload
      try {
        payload = await response.json()
      } catch (err) {
        throw new Error(`Invalid response: ${response.status}`)
      }
      
    if (!response.ok || !payload?.success) {
        const errorMsg = payload?.error || `HTTP ${response.status}`
        throw new Error(errorMsg)
      }

    state.comments = Array.isArray(payload.data)
      ? payload.data.map((c) => ({
          ...c,
          likes: typeof c.likes === 'number' ? c.likes : (typeof c.likeCount === 'number' ? c.likeCount : 0),
          dislikes: typeof c.dislikes === 'number' ? c.dislikes : (typeof c.dislikeCount === 'number' ? c.dislikeCount : 0)
        }))
      : []
    state.meta = payload.meta || null
    const globalUser = (typeof window !== 'undefined' && window.__USER__) ? window.__USER__ : null
    state.viewer = payload.meta?.viewer ?? (globalUser ? {
      id: globalUser.id,
      username: globalUser.username ?? null,
      role: globalUser.role ?? 'user',
      pictureUrl: globalUser.pictureUrl ?? null
    } : null)
    state.viewerRole = state.viewer?.role ?? (globalUser?.role ?? 'user')
      state.nextAnonymousNumber = typeof payload.meta?.nextAnonymousNumber === 'number' ? payload.meta.nextAnonymousNumber : null
      state.viewerIp = typeof payload.meta?.viewerIp === 'string' ? payload.meta.viewerIp : null
      closeReplyBoxes(section, state)

      let policyChanged = false
      let policySource = state.policy ? 'dataset' : 'unknown'
      if (payload.meta && Object.prototype.hasOwnProperty.call(payload.meta, 'policy')) {
        const nextPolicy = normalizePolicy(payload.meta.policy)
        policyChanged = !policiesEqual(state.policy, nextPolicy)
        state.policy = nextPolicy
        state.policySignature = computePolicySignature(nextPolicy)
        if (typeof nextPolicy.bestLikeThreshold === 'number' && Number.isFinite(nextPolicy.bestLikeThreshold)) {
          state.bestThreshold = nextPolicy.bestLikeThreshold
        }
        policySource = 'api'
      } else if (state.policy && !state.policySignature) {
        state.policySignature = computePolicySignature(state.policy)
      }

      // Best 탭 기본값 설정: Best 댓글이 있으면 'best' 탭이 기본, 없으면 'all' 탭이 기본
      const bestComments = state.comments.filter((comment) => comment.isBest === true)
      if (bestComments.length > 0 && state.activeTab === 'all') {
        state.activeTab = 'best'
      } else if (bestComments.length === 0 && state.activeTab === 'best') {
        state.activeTab = 'all'
      }

      updatePolicySummary(section, state.policy)
      refreshScoreboardCopy(section, state)
      applyAuthState(section, state)
      
      // URL hash에 해당하는 댓글이 있으면 해당 페이지로 먼저 이동
      let targetCommentId = null
      if (window.location.hash && window.location.hash.startsWith('#comment-')) {
        targetCommentId = parseInt(window.location.hash.replace('#comment-', ''), 10)
        if (Number.isFinite(targetCommentId) && state.comments && state.comments.length > 0) {
          // 정렬된 댓글 목록에서 해당 댓글의 인덱스 찾기
          const PAGE_SIZE = 20
          const { sortedAll } = summarizeCommentCollections(state)
          const commentIndex = sortedAll.findIndex(c => c.id === targetCommentId)
          if (commentIndex >= 0) {
            // 해당 댓글이 있는 페이지 계산 (1-indexed)
            const targetPage = Math.floor(commentIndex / PAGE_SIZE) + 1
            state.page = targetPage
          }
        }
      }
      
      renderComments(section, state)
      section.dataset.commentsStatus = 'ready'
      
      // 로딩 상태 명시적으로 해제
      if (!silent) {
      toggleLoading(section, false)
      }
      
      // URL hash에 해당하는 댓글로 스크롤
      if (targetCommentId) {
        setTimeout(() => {
          const targetEl = document.getElementById('comment-' + targetCommentId)
          if (targetEl) {
            targetEl.scrollIntoView({ behavior: 'smooth', block: 'center' })
            // 하이라이트 효과
            targetEl.classList.add('ring-2', 'ring-wiki-primary', 'ring-offset-2', 'ring-offset-wiki-bg')
            setTimeout(() => {
              targetEl.classList.remove('ring-2', 'ring-wiki-primary', 'ring-offset-2', 'ring-offset-wiki-bg')
            }, 3000)
          }
        }, 150)
      }
      const stats = computeCommentStats(state.comments)

      if (policyChanged) {
        DetailTelemetry.emit('comments-policy-sync', {
          component: 'comments',
          entityType: state.entityType,
          entityId: state.entityId,
          policySource,
          policySignature: state.policySignature ?? null,
          governance: getGovernanceFromState(state)
        })
      }

      DetailTelemetry.emit('comments-load', {
        component: 'comments',
        entityType: state.entityType,
        entityId: state.entityId,
        phase: 'success',
        count: stats.total,
        bestCount: stats.best,
        blindedCount: stats.blinded,
        totalCount: typeof state.meta?.total === 'number' ? state.meta.total : stats.total,
        viewerRole: state.viewerRole,
        policyChanged,
        policySource,
        policySignature: state.policySignature ?? null,
        governance: getGovernanceFromState(state)
      })
    } catch (error) {
      section.dataset.commentsStatus = 'error'
      const message = error && error.name === 'AbortError'
        ? '댓글 응답이 지연되어 연결을 종료했습니다. 네트워크 상태를 확인한 후 다시 시도해주세요.'
        : '댓글을 불러오지 못했습니다. 잠시 후 다시 시도해주세요.'
      setStatus(section, message, 'error')
      
      // 에러 발생 시에도 빈 댓글 목록 표시
      state.comments = []
      renderComments(section, state)
      
      DetailTelemetry.emit('comments-load', {
        component: 'comments',
        entityType: state.entityType,
        entityId: state.entityId,
        phase: 'error',
        message: error instanceof Error ? error.message : String(error),
        policySource: 'api',
        policySignature: state.policySignature ?? null,
        governance: getGovernanceFromState(state)
      })
    } finally {
      state.loading = false
      section.dataset.commentsStatus = state.comments.length > 0 ? 'ready' : 'empty'
      if (!silent) {
        toggleLoading(section, false)
      }
      applyAuthState(section, state)
      if (state.comments.length > 0) {
        hideAllEmptyStates(section)
      }
      
      // 로딩 요소가 확실히 숨겨지도록
      const loader = section.querySelector('[data-cw-comments-loading]')
      if (loader) {
        loader.hidden = true
      }
    }
  }

  const bindIntentButtons = (section, state) => {
    section.querySelectorAll('[data-cw-feedback-intent]').forEach((button) => {
      if (button.dataset.feedbackBound === '1') {
        return
      }
      button.dataset.feedbackBound = '1'
      button.addEventListener('click', () => {
        DetailTelemetry.emit('comments-feedback-intent', {
          component: 'comments-actions',
          entityType: state.entityType,
          entityId: state.entityId,
          policySignature: state.policySignature ?? null,
          governance: getGovernanceFromState(state)
        })
        setStatus(section, '우선 적용 의견 접수 기능은 준비 중입니다.', 'info')
      })
    })

    section.querySelectorAll('[data-cw-notify-comments]').forEach((button) => {
      if (button.dataset.notifyBound === '1') {
        return
      }
      button.dataset.notifyBound = '1'
      button.addEventListener('click', () => {
        DetailTelemetry.emit('comments-notify', {
          component: 'comments-actions',
          entityType: state.entityType,
          entityId: state.entityId,
          policySignature: state.policySignature ?? null,
          governance: getGovernanceFromState(state)
        })
        setStatus(section, '알림 기능은 Phase 2에서 제공될 예정입니다.', 'info')
      })
    })

    section.querySelectorAll('[data-cw-comment-login-intent]').forEach((element) => {
      if (!(element instanceof HTMLElement)) {
        return
      }
      if (element.dataset.commentLoginBound === '1') {
        return
      }
      element.dataset.commentLoginBound = '1'
      element.addEventListener('click', () => {
        const destination = element.getAttribute('href') || element.dataset.authTarget || null
        DetailTelemetry.emit('comment-login-intent', {
          component: 'comment-auth',
          entityType: state.entityType,
          entityId: state.entityId,
          target: destination,
          policySignature: state.policySignature ?? null,
          governance: getGovernanceFromState(state)
        })
      })
    })

    section.querySelectorAll('[data-cw-comment-signup-intent]').forEach((element) => {
      if (!(element instanceof HTMLElement)) {
        return
      }
      if (element.dataset.commentSignupBound === '1') {
        return
      }
      element.dataset.commentSignupBound = '1'
      element.addEventListener('click', () => {
        const destination = element.getAttribute('href') || element.dataset.authTarget || null
        DetailTelemetry.emit('comment-signup-intent', {
          component: 'comment-auth',
          entityType: state.entityType,
          entityId: state.entityId,
          target: destination,
          policySignature: state.policySignature ?? null,
          governance: getGovernanceFromState(state)
        })
      })
    })
  }

  const bindForm = (section, state) => {
    const form = section.querySelector('[data-cw-comment-form]')
    if (!form || form.dataset.commentFormBound === '1') {
      return
    }
    form.dataset.commentFormBound = '1'
    const submitButton = form.querySelector('[data-cw-comment-submit]')

    form.addEventListener('submit', async (event) => {
      event.preventDefault()
      if (state.submitting) {
        return
      }

      // Phase 3 Day 3: requiresAuth가 false이면 익명 사용자도 댓글 작성 가능
      if (state.policy?.requiresAuth && !state.viewer?.id) {
        setStatus(section, '로그인 후 댓글을 남길 수 있습니다.', 'error')
        setPasswordWarning(section, '')
        return
      }

      const formData = new FormData(form)
      const rawContent = (formData.get('content') || '').toString().trim()
      if (!rawContent) {
        setStatus(section, '댓글 내용을 입력해주세요.', 'error')
        setPasswordWarning(section, '')
        return
      }
      
      // 익명 사용자는 닉네임 입력하지 않음 (익명 번호는 서버에서 자동 배정)
      const isAnonymous = !state.viewer?.id
      const nickname = isAnonymous ? null : ((formData.get('nickname') || '').toString().trim().slice(0, MAX_NICKNAME_LENGTH) || null)
      const password = isAnonymous ? (formData.get('password') || '').toString().trim() : ''
      if (isAnonymous) {
        if (!password) {
          const msg = '익명 댓글은 숫자 4자리 비밀번호를 입력해야 등록됩니다.'
          setStatus(section, '')
          setPasswordWarning(section, msg, 'error')
          return
        }
        if (!/^\d{4}$/.test(password)) {
          const msg = '비밀번호는 숫자 4자리로 입력해주세요.'
          setStatus(section, '')
          setPasswordWarning(section, msg, 'error')
          return
        }
      } else {
        setPasswordWarning(section, '')
      }
      
      // 멘션 추출: @댓글ID 또는 @익명번호 형식
      const mentionMatches = rawContent.match(/@(\d+)|@익명\s*(\d+)/g) || []
      const mentions = mentionMatches.map((match) => {
        const idMatch = match.match(/\d+/)
        return idMatch ? idMatch[0] : null
      }).filter(Boolean).slice(0, 10)  // 최대 10개 멘션
      
      const content = rawContent.slice(0, MAX_CONTENT_LENGTH)

      const currentPolicySignature = state.policySignature ?? (state.policy ? computePolicySignature(state.policy) : null)
      if (!state.policySignature && currentPolicySignature) {
        state.policySignature = currentPolicySignature
      }

      state.submitting = true
      if (submitButton) {
        submitButton.disabled = true
      }
      setStatus(section, '댓글을 등록하는 중입니다...', 'info')
      DetailTelemetry.emit('comment-submit', {
        component: 'comment-form',
        entityType: state.entityType,
        entityId: state.entityId,
        phase: 'start',
        contentLength: content.length,
        hasNickname: Boolean(nickname),
        policySignature: currentPolicySignature,
        governance: getGovernanceFromState(state)
      })

      try {
        const response = await fetch('/api/comments', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            entityType: state.entityType,
            slug: state.entitySlug,
            title: state.entityName || state.entitySlug,
            summary: state.entitySummary || null,
            nickname: nickname || undefined,  // 익명 사용자는 nickname 없음 (익명 번호는 서버에서 자동 배정)
            content,
            mentions: mentions.length > 0 ? mentions : undefined,
            password: isAnonymous ? password : undefined,
            parentId: state.replyTarget?.id ? Number(state.replyTarget.id) : undefined
          })
        })
        const payload = await response.json().catch(() => ({}))
        if (!response.ok || !payload?.success) {
          throw new Error((payload && payload.error) || `HTTP ${response.status}`)
        }

        form.reset()
        setPasswordWarning(section, '')
        clearReplyTarget(section, state)
        showToast('댓글이 등록되었습니다.', 'success')
        DetailTelemetry.emit('comment-submit', {
          component: 'comment-form',
          entityType: state.entityType,
          entityId: state.entityId,
          phase: 'success',
          commentId: payload?.data?.id ?? null,
          policySignature: state.policySignature ?? currentPolicySignature,
          governance: getGovernanceFromState(state)
        })

        await loadComments(section, state)
      } catch (error) {
        const rawMessage = error instanceof Error ? error.message : String(error || '')
        const normalized = rawMessage.toUpperCase()
        if (normalized.includes('PASSWORD_REQUIRED') || normalized.includes('PASSWORD IS REQUIRED')) {
          const msg = '익명 댓글은 숫자 4자리 비밀번호를 입력해야 등록됩니다.'
          setStatus(section, '')
          setPasswordWarning(section, msg, 'error')
        } else if (normalized.includes('INVALID_PASSWORD') || normalized.includes('INVALID PASSWORD')) {
          const msg = '비밀번호는 숫자 4자리로 입력해주세요.'
          setStatus(section, '')
          setPasswordWarning(section, msg, 'error')
        } else {
          setStatus(section, '댓글 등록에 실패했습니다. 잠시 후 다시 시도해주세요.', 'error')
          setPasswordWarning(section, '')
        }
        DetailTelemetry.emit('comment-submit', {
          component: 'comment-form',
          entityType: state.entityType,
          entityId: state.entityId,
          phase: 'error',
          message: rawMessage,
          policySignature: state.policySignature ?? currentPolicySignature,
          governance: getGovernanceFromState(state)
        })
      } finally {
        state.submitting = false
        if (submitButton) {
          submitButton.disabled = false
        }
      }
    })

    const replyCancel = form.querySelector('[data-cw-comment-reply-cancel]')
    if (replyCancel instanceof HTMLButtonElement) {
      replyCancel.addEventListener('click', (e) => {
        e.preventDefault()
        clearReplyTarget(section, state)
      })
    }

    clearReplyTarget(section, state)
  }

  const handleLike = async (section, state, button) => {
    if (button.dataset.commentBusy === '1') {
      return
    }

    const commentId = Number(button.getAttribute('data-comment-id'))
    if (!Number.isFinite(commentId) || commentId <= 0) {
      return
    }
    const target = Array.isArray(state.comments) ? state.comments.find((c) => Number(c.id) === commentId) : null
    if (target) {
      // 로그인 사용자 자기 글 차단
      if (state.viewer?.id && target.authorId && String(target.authorId) === String(state.viewer.id)) {
        const msg = '내 댓글에는 공감할 수 없습니다.'
        setInlineActionError(section, commentId, msg, 5000)
        return
      }
      // 익명 작성자 자기 글 차단 (표시용 IP 비교)
      if (!state.viewer?.id && target.isAnonymous && !target.authorId && target.displayIp && state.viewerIp && target.displayIp === state.viewerIp) {
        const msg = '내 댓글에는 공감할 수 없습니다.'
        setInlineActionError(section, commentId, msg, 5000)
        return
      }
    }

    const policySignature = state.policySignature ?? (state.policy ? computePolicySignature(state.policy) : null)
    if (!state.policySignature && policySignature) {
      state.policySignature = policySignature
    }

    button.dataset.commentBusy = '1'
    DetailTelemetry.emit('comment-like', {
      component: 'comment-engagement',
      entityType: state.entityType,
      entityId: state.entityId,
      commentId,
      phase: 'start',
      outcome: 'start',
      viewerRole: state.viewerRole,
      policySignature,
      governance: getGovernanceFromState(state)
    })
    try {
      const response = await fetch(`/api/comments/${commentId}/like`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ direction: 'up' })
      })
      const payload = await response.json().catch(() => ({}))
      if (!response.ok || !payload?.success) {
        const msg = (payload && payload.error) || `HTTP ${response.status}`
        throw new Error(msg)
      }

      DetailTelemetry.emit('comment-like', {
        component: 'comment-engagement',
        entityType: state.entityType,
        entityId: state.entityId,
        commentId,
        phase: 'success',
        outcome: 'success',
        likes: payload?.data?.likes ?? null,
        viewerRole: state.viewerRole,
        policySignature,
        governance: getGovernanceFromState(state)
      })

      await loadComments(section, state, { silent: true })
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error)
      let uiMessage = '공감 처리에 실패했습니다. 잠시 후 다시 시도해주세요.'
      if (typeof message === 'string') {
        const upper = message.toUpperCase()
        if (upper.includes('SELF_VOTE_NOT_ALLOWED')) {
          uiMessage = '내 댓글에는 공감할 수 없습니다.'
        } else if (upper.includes('VOTE_LIMIT_REACHED')) {
          uiMessage = '하루 공감 한도를 초과했습니다. 내일 다시 시도해주세요.'
        } else if (upper.includes('COMMENT_NOT_FOUND')) {
          uiMessage = '댓글을 찾지 못했습니다.'
        } else if (upper.includes('AUTHENTICATION')) {
          uiMessage = '로그인이 필요합니다.'
        } else if (upper.startsWith('HTTP ')) {
          uiMessage = `공감 처리 오류: ${message}`
        }
      }
      // 글로벌 메시지는 중복 노출을 피하기 위해 사용하지 않음
      setInlineActionError(section, commentId, uiMessage, 5000)
      DetailTelemetry.emit('comment-like', {
        component: 'comment-engagement',
        entityType: state.entityType,
        entityId: state.entityId,
        commentId,
        phase: 'error',
        outcome: 'error',
        message,
        viewerRole: state.viewerRole,
        policySignature,
        governance: getGovernanceFromState(state)
      })
    } finally {
      delete button.dataset.commentBusy
      // 실패 시에도 기존 댓글 목록 유지, 메시지만 표시
    }
  }

  const handleDislike = async (section, state, button) => {
    if (button.dataset.commentBusy === '1') {
      return
    }

    const commentId = Number(button.getAttribute('data-comment-id'))
    if (!Number.isFinite(commentId) || commentId <= 0) {
      return
    }
    const target = Array.isArray(state.comments) ? state.comments.find((c) => Number(c.id) === commentId) : null
    if (target) {
      // 로그인 사용자 자기 글 차단
      if (state.viewer?.id && target.authorId && String(target.authorId) === String(state.viewer.id)) {
        const msg = '내 댓글에는 비공감을 할 수 없습니다.'
        setInlineActionError(section, commentId, msg, 5000)
        return
      }
      // 익명 작성자 자기 글 차단 (표시용 IP 비교)
      if (!state.viewer?.id && target.isAnonymous && !target.authorId && target.displayIp && state.viewerIp && target.displayIp === state.viewerIp) {
        const msg = '내 댓글에는 비공감을 할 수 없습니다.'
        setInlineActionError(section, commentId, msg, 5000)
        return
      }
    }

    const policySignature = state.policySignature ?? (state.policy ? computePolicySignature(state.policy) : null)
    if (!state.policySignature && policySignature) {
      state.policySignature = policySignature
    }

    button.dataset.commentBusy = '1'
    DetailTelemetry.emit('comment-dislike', {
      component: 'comment-engagement',
      entityType: state.entityType,
      entityId: state.entityId,
      commentId,
      phase: 'start',
      outcome: 'start',
      viewerRole: state.viewerRole,
      policySignature,
      governance: getGovernanceFromState(state)
    })
    try {
      const response = await fetch(`/api/comments/${commentId}/like`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ direction: 'down' })
      })
      const payload = await response.json().catch(() => ({}))
      if (!response.ok || !payload?.success) {
        const msg = (payload && payload.error) || `HTTP ${response.status}`
        throw new Error(msg)
      }

      DetailTelemetry.emit('comment-dislike', {
        component: 'comment-engagement',
        entityType: state.entityType,
        entityId: state.entityId,
        commentId,
        phase: 'success',
        outcome: 'success',
        dislikes: payload?.data?.dislikes ?? null,
        viewerRole: state.viewerRole,
        policySignature,
        governance: getGovernanceFromState(state)
      })

      await loadComments(section, state)
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error)
      let uiMessage = '비공감 처리에 실패했습니다. 잠시 후 다시 시도해주세요.'
      if (typeof message === 'string') {
        const upper = message.toUpperCase()
        if (upper.includes('SELF_VOTE_NOT_ALLOWED')) {
          uiMessage = '내 댓글에는 비공감을 할 수 없습니다.'
        } else if (upper.includes('VOTE_LIMIT_REACHED')) {
          uiMessage = '하루 비공감 한도를 초과했습니다. 내일 다시 시도해주세요.'
        } else if (upper.includes('COMMENT_NOT_FOUND')) {
          uiMessage = '댓글을 찾지 못했습니다.'
        } else if (upper.includes('AUTHENTICATION')) {
          uiMessage = '로그인이 필요합니다.'
        } else if (upper.startsWith('HTTP ')) {
          uiMessage = `비공감 처리 오류: ${message}`
        }
      }
      // 글로벌 메시지는 중복 노출을 피하기 위해 사용하지 않음
      setInlineActionError(section, commentId, uiMessage, 5000)
      DetailTelemetry.emit('comment-dislike', {
        component: 'comment-engagement',
        entityType: state.entityType,
        entityId: state.entityId,
        commentId,
        phase: 'error',
        outcome: 'error',
        message,
        viewerRole: state.viewerRole,
        policySignature,
        governance: getGovernanceFromState(state)
      })
    } finally {
      delete button.dataset.commentBusy
    }
  }

  const handleAdminBlind = async (section, state, button) => {
    if (button.dataset.commentBusy === '1') {
      return
    }
    const commentId = Number(button.getAttribute('data-comment-id'))
    const action = button.getAttribute('data-admin-blind-action') === 'unblind' ? 'unblind' : 'blind'
    if (!Number.isFinite(commentId) || commentId <= 0) {
      return
    }
    button.dataset.commentBusy = '1'
    const originalLabel = button.textContent || ''
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i>'
    try {
      const res = await fetch(`/api/admin/comments/${commentId}/${action === 'blind' ? 'blind' : 'unblind'}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
      })
      const payload = await res.json().catch(() => ({}))
      if (!res.ok || !payload?.success) {
        const msg = (payload && payload.error) || `HTTP ${res.status}`
        setInlineActionError(section, commentId, msg, 5000)
        return
      }
      await loadComments(section, state, { silent: true })
    } catch (error) {
      setInlineActionError(section, commentId, '블라인드 처리에 실패했습니다.', 5000)
    } finally {
      delete button.dataset.commentBusy
      button.textContent = originalLabel
    }
  }

  const reportModalCache = new WeakMap()

  const ensureReportModal = (section, state) => {
    let cached = reportModalCache.get(section)
    if (cached) {
      cached.state = state
      return cached
    }
    const modal = section.querySelector('[data-cw-comment-report-modal]')
    if (!modal) return null
    const form = modal.querySelector('[data-cw-comment-report-form]')
    const reason = modal.querySelector('[data-cw-comment-report-reason]')
    const detail = modal.querySelector('[data-cw-comment-report-detail]')
    const msg = modal.querySelector('[data-cw-comment-report-message]')
    const closeButtons = modal.querySelectorAll('[data-cw-comment-report-close], [data-cw-comment-report-backdrop]')
    const submit = modal.querySelector('[data-cw-comment-report-submit]')
    if (!form || !reason || !msg || !submit) return null

    const setMessage = (text, type) => {
      msg.textContent = text || ''
      msg.classList.remove('hidden', 'text-rose-400', 'text-emerald-400', 'text-wiki-muted')
      if (!text) {
        msg.classList.add('hidden')
      } else if (type === 'error') {
        msg.classList.add('text-rose-400')
      } else if (type === 'success') {
        msg.classList.add('text-emerald-400')
      } else {
        msg.classList.add('text-wiki-muted')
      }
    }

    const close = () => {
      modal.classList.add('hidden')
      modal.removeAttribute('data-comment-id')
      setMessage('', '')
      submit.disabled = false
    }

    closeButtons.forEach((btn) => btn.addEventListener('click', close))

    form.addEventListener('submit', async (event) => {
      event.preventDefault()
      const commentId = Number(modal.dataset.commentId)
      if (!Number.isFinite(commentId) || commentId <= 0) {
        setMessage('신고 대상을 찾을 수 없습니다.', 'error')
        return
      }
      const reasonValue = reason.value
      if (!reasonValue) {
        setMessage('신고 사유를 선택해주세요.', 'error')
        return
      }
      const detailText = (detail?.value || '').trim().slice(0, 300)
      const combinedReason = detailText ? `${reasonValue} | ${detailText}` : reasonValue
      if (submit.disabled) return
      submit.disabled = true
      submit.innerHTML = '<i class="fas fa-spinner fa-spin"></i>'

      const policySignature = state?.policySignature ?? (state?.policy ? computePolicySignature(state.policy) : null)
      if (state && !state.policySignature && policySignature) {
        state.policySignature = policySignature
      }

      DetailTelemetry.emit('comment-flag', {
        component: 'comment-engagement',
        entityType: state?.entityType,
        entityId: state?.entityId,
        commentId,
        phase: 'start',
        outcome: 'start',
        viewerRole: state?.viewerRole,
        policySignature,
        governance: getGovernanceFromState(state)
      })

      try {
        const response = await fetch(`/api/comments/${commentId}/flag`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ reason: combinedReason })
        })
        const payload = await response.json().catch(() => ({}))
        if (!response.ok || !payload?.success) {
          const errMsg = (payload && payload.error) || `HTTP ${response.status}`
          throw new Error(errMsg)
        }

        DetailTelemetry.emit('comment-flag', {
          component: 'comment-engagement',
          entityType: state?.entityType,
          entityId: state?.entityId,
          commentId,
          phase: 'success',
          outcome: 'success',
          viewerRole: state?.viewerRole,
          policySignature,
          governance: getGovernanceFromState(state)
        })

        setMessage('신고 요청이 접수되었습니다.', 'success')
        setStatus(section, '신고 요청이 접수되었습니다.', 'success')
        // 잠시 메시지를 보여준 뒤 닫기 (3초)
        setTimeout(() => close(), 3000)
        await loadComments(section, state, { silent: true })
      } catch (error) {
        const message = error instanceof Error ? error.message : String(error)
        if (typeof message === 'string' && message.toLowerCase().includes('duplicate')) {
          setMessage('이미 신고한 댓글입니다.', 'error')
        } else if (typeof message === 'string' && message.toLowerCase().includes('authentication')) {
          setMessage('로그인 후 신고할 수 있습니다.', 'error')
        } else {
          setMessage('신고 처리에 실패했습니다. 잠시 후 다시 시도해주세요.', 'error')
        }
        DetailTelemetry.emit('comment-flag', {
          component: 'comment-engagement',
          entityType: state?.entityType,
          entityId: state?.entityId,
          commentId,
          phase: 'error',
          outcome: 'error',
          message: error instanceof Error ? error.message : String(error),
          viewerRole: state?.viewerRole,
          policySignature,
          governance: getGovernanceFromState(state)
        })
      } finally {
        submit.disabled = false
        submit.textContent = '신고하기'
      }
    })

    cached = { modal, form, reason, detail, msg, submit, close, setMessage, state }
    reportModalCache.set(section, cached)
    return cached
  }

  const openReportModal = (section, state, commentId) => {
    const controls = ensureReportModal(section, state)
    if (!controls) {
      setStatus(section, '신고 창을 불러오지 못했습니다.', 'error')
      return
    }
    controls.reason.value = ''
    if (controls.detail) controls.detail.value = ''
    controls.setMessage('', '')
    controls.modal.dataset.commentId = String(commentId)
    controls.modal.classList.remove('hidden')
    controls.reason.focus()
  }

  const handleFlag = async (section, state, button) => {
    const commentId = Number(button.getAttribute('data-comment-id'))
    if (!Number.isFinite(commentId) || commentId <= 0) {
      return
    }
    if (!state.viewer?.id) {
      setStatus(section, '로그인 후 신고할 수 있습니다.', 'info')
      return
    }
    openReportModal(section, state, commentId)
  }

  const needsPasswordForComment = (comment) => comment?.isAnonymous && !comment?.authorId

  const closeEditBoxes = (section) => {
    section.querySelectorAll('[data-cw-edit-box]').forEach((box) => {
      const li = box.closest('li[data-comment-id]')
      const content = li?.querySelector('[data-cw-comment-body]')
      if (content) content.hidden = false
      box.remove()
    })
  }

  const openEditBox = (section, state, comment) => {
    if (!comment) return
    closeEditBoxes(section)
    const li = section.querySelector(`li[data-comment-id="${comment.id}"]`)
    if (!li) return
    const content = li.querySelector('[data-cw-comment-body]')
    if (!content) return
    content.hidden = true

    const box = document.createElement('div')
    box.dataset.cwEditBox = '1'
    const needsPw = needsPasswordForComment(comment)
    const identityLabel = comment.nickname || (comment.isAnonymous && comment.anonymousNumber ? `익명 ${comment.anonymousNumber}` : '익명')
    box.innerHTML = `
      <div class="mt-2 space-y-2 border border-wiki-border rounded-lg p-3 bg-wiki-bg/80">
        <div class="flex items-center justify-between text-xs text-wiki-muted">
          <span>${escapeHtml(identityLabel)} · 수정하기</span>
        </div>
        <div class="text-xs min-h-[18px]" data-cw-edit-status></div>
        <textarea class="w-full px-3 py-2 rounded border border-wiki-border bg-wiki-bg text-sm focus:border-wiki-primary focus:outline-none" rows="3" data-cw-edit-textarea>${escapeHtml(comment.content || '')}</textarea>
        ${needsPw ? `
          <div class="flex items-center gap-2 text-sm">
            <input type="password" maxlength="4" pattern="[0-9]{4}" placeholder="비밀번호 (4자리 숫자)" class="px-3 py-2 rounded border border-wiki-border bg-wiki-bg text-sm focus:border-wiki-primary focus:outline-none" data-cw-edit-password />
            <span class="text-xs text-wiki-muted">익명 댓글은 비밀번호가 필요합니다.</span>
          </div>
        ` : ''}
        <div class="flex items-center gap-2 text-xs">
          <button type="button" class="px-3 py-2 rounded bg-wiki-primary text-white hover:bg-wiki-secondary transition" data-cw-edit-submit>수정</button>
          <button type="button" class="px-3 py-2 rounded border border-wiki-border text-wiki-muted hover:text-wiki-text transition" data-cw-edit-cancel>취소</button>
        </div>
      </div>
    `

    const textarea = box.querySelector('[data-cw-edit-textarea]')
    const passwordInput = box.querySelector('[data-cw-edit-password]')
    const submitBtn = box.querySelector('[data-cw-edit-submit]')
    const cancelBtn = box.querySelector('[data-cw-edit-cancel]')
    const editStatusEl = box.querySelector('[data-cw-edit-status]')

    const setEditStatus = (message = '', tone = 'neutral') => {
      if (!editStatusEl) return
      editStatusEl.textContent = message || ''
      editStatusEl.classList.remove('text-red-400', 'text-green-400', 'text-wiki-muted')
      if (!message) return
      if (tone === 'error') {
        editStatusEl.classList.add('text-red-400')
      } else if (tone === 'success') {
        editStatusEl.classList.add('text-green-400')
      } else {
        editStatusEl.classList.add('text-wiki-muted')
      }
    }

    const validatePasswordInput = () => {
      if (!needsPw) return true
      const val = passwordInput?.value?.trim() || ''
      if (!/^\d{4}$/.test(val)) {
        setEditStatus('비밀번호는 숫자 4자리로 입력해주세요.', 'error')
        return false
      }
      return true
    }

    const doSubmit = async () => {
      const value = textarea?.value?.trim() || ''
      if (!value) {
        setEditStatus('수정할 내용을 입력해주세요.', 'error')
        return
      }
      if (!validatePasswordInput()) {
        return
      }
      submitBtn.dataset.commentBusy = '1'
      try {
        const response = await fetch(`/api/comments/${comment.id}`, {
          method: 'PATCH',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            content: value,
            password: needsPw ? (passwordInput?.value?.trim() || undefined) : undefined
          })
        })
        const payload = await response.json().catch(() => ({}))
        if (!response.ok || !payload?.success) {
          const msg = (payload && payload.error) || `HTTP ${response.status}`
          if (typeof msg === 'string' && msg.toUpperCase().includes('INVALID_PASSWORD')) {
            setEditStatus('비밀번호가 올바르지 않습니다.', 'error')
            return
          }
          if (typeof msg === 'string' && msg.toUpperCase().includes('PASSWORD_REQUIRED')) {
            setEditStatus('익명 댓글은 비밀번호가 필요합니다.', 'error')
            return
          }
          if (typeof msg === 'string' && msg.toUpperCase().includes('AUTHOR_REQUIRED')) {
            setEditStatus('본인 댓글만 수정할 수 있습니다.', 'error')
            return
          }
          throw new Error(msg)
        }
        setEditStatus('댓글이 수정되었습니다.', 'success')
        closeEditBoxes(section)
        await loadComments(section, state)
      } catch (error) {
        setEditStatus('댓글 수정에 실패했습니다. 잠시 후 다시 시도해주세요.', 'error')
      } finally {
        delete submitBtn.dataset.commentBusy
      }
    }

    submitBtn?.addEventListener('click', (e) => {
      e.preventDefault()
      doSubmit()
    })
    cancelBtn?.addEventListener('click', (e) => {
      e.preventDefault()
      closeEditBoxes(section)
      const originalContent = li.querySelector('[data-cw-comment-body]')
      if (originalContent) originalContent.hidden = false
    })

    content.insertAdjacentElement('afterend', box)
    textarea?.focus()
  }

  const handleEdit = async (section, state, button) => {
    if (button.dataset.commentBusy === '1') {
      return
    }
    const commentId = Number(button.getAttribute('data-comment-id'))
    if (!Number.isFinite(commentId) || commentId <= 0) {
      setStatus(section, '잘못된 댓글 ID입니다.', 'error')
      return
    }

    const target = (state.comments || []).find((c) => Number(c.id) === commentId)
    if (!target) {
      setStatus(section, '댓글을 찾지 못했습니다.', 'error')
      return
    }

    openEditBox(section, state, target)
  }

  // 익명/로그인 여부에 따라 비밀번호 필요 여부 판단 (삭제/수정 공용)
  const requestPasswordIfNeeded = (comment) => {
    if (comment?.authorId && String(comment.authorId).trim()) {
      // 로그인 사용자가 작성한 댓글: 비밀번호 불필요
      return ''
    }
    if (!comment?.isAnonymous) {
      // 익명이 아니면 비밀번호 불필요
      return ''
    }
    const password = window.prompt('익명 댓글 비밀번호 4자리를 입력하세요.')
    if (password === null) {
      return null
    }
    const trimmed = password.trim()
    if (!/^\d{4}$/.test(trimmed)) {
      return false
    }
    return trimmed
  }

  const handleDelete = async (section, state, button) => {
    if (button.dataset.commentBusy === '1') {
      return
    }
    const commentId = Number(button.getAttribute('data-comment-id'))
    if (!Number.isFinite(commentId) || commentId <= 0) {
      setStatus(section, '잘못된 댓글 ID입니다.', 'error')
      return
    }

    const target = (state.comments || []).find((c) => Number(c.id) === commentId)
    if (!target) {
      setStatus(section, '댓글을 찾지 못했습니다.', 'error')
      return
    }

    if (!window.confirm('이 댓글을 삭제하시겠습니까?')) {
      return
    }

    // 관리자/운영자는 비밀번호 없이 삭제 가능
    const password = isModeratorRole(state.viewerRole, state) ? '' : requestPasswordIfNeeded(target)
    if (password === false) {
      setStatus(section, '비밀번호는 숫자 4자리로 입력해주세요.', 'error')
      return
    }
    if (password === null) {
      return
    }

    button.dataset.commentBusy = '1'
    try {
      const response = await fetch(`/api/comments/${commentId}`, {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ password: password || undefined })
      })
      const payload = await response.json().catch(() => ({}))
      if (!response.ok || !payload?.success) {
        const msg = (payload && payload.error) || `HTTP ${response.status}`
        if (typeof msg === 'string' && msg.toUpperCase().includes('INVALID_PASSWORD')) {
          setStatus(section, '비밀번호가 올바르지 않습니다.', 'error')
          return
        }
        if (typeof msg === 'string' && msg.toUpperCase().includes('PASSWORD_REQUIRED')) {
          setStatus(section, '익명 댓글은 비밀번호가 필요합니다.', 'error')
          return
        }
        throw new Error(msg)
      }
      await loadComments(section, state)
      showToast('댓글이 삭제되었습니다.', 'success')
    } catch (error) {
      setStatus(section, '댓글 삭제에 실패했습니다. 잠시 후 다시 시도해주세요.', 'error')
    } finally {
      delete button.dataset.commentBusy
    }
  }

  const bindListActions = (section, state) => {
    if (section.dataset.commentActionsBound === '1') {
      return
    }
    section.dataset.commentActionsBound = '1'

    section.addEventListener('click', (event) => {
      const target = event.target
      if (!(target instanceof HTMLElement)) {
        return
      }
      const likeBtn = target.closest('[data-cw-comment-like]')
      if (likeBtn instanceof HTMLElement) {
        handleLike(section, state, likeBtn)
        return
      }
      const dislikeBtn = target.closest('[data-cw-comment-dislike]')
      if (dislikeBtn instanceof HTMLElement) {
        handleDislike(section, state, dislikeBtn)
        return
      }
      const flagBtn = target.closest('[data-cw-comment-flag]')
      if (flagBtn instanceof HTMLElement) {
        handleFlag(section, state, flagBtn)
        return
      }
      const replyBtn = target.closest('[data-cw-comment-reply]')
      if (replyBtn instanceof HTMLElement) {
        const commentId = Number(replyBtn.getAttribute('data-comment-id'))
        const label = replyBtn.getAttribute('data-comment-label') || '댓글'
        if (Number.isFinite(commentId) && commentId > 0) {
          openReplyBox(section, state, commentId, label)
        }
        return
      }
      const menuBtn = target.closest('[data-cw-comment-menu]')
      if (menuBtn instanceof HTMLElement) {
        const menuId = menuBtn.getAttribute('data-menu-id')
        if (menuId) {
          toggleMenu(section, state, menuId)
        }
        return
      }
      const editBtn = target.closest('[data-cw-comment-edit]')
      if (editBtn instanceof HTMLElement) {
        handleEdit(section, state, editBtn)
        return
      }
      const deleteBtn = target.closest('[data-cw-comment-delete]')
      if (deleteBtn instanceof HTMLElement) {
        handleDelete(section, state, deleteBtn)
        return
      }
      const adminBlindBtn = target.closest('[data-cw-comment-admin-blind]')
      if (adminBlindBtn instanceof HTMLElement) {
        handleAdminBlind(section, state, adminBlindBtn)
        return
      }
      const replySubmit = target.closest('[data-cw-reply-submit]')
      if (replySubmit instanceof HTMLElement) {
        handleReplySubmit(section, state, replySubmit)
        return
      }
      const replyCancel = target.closest('[data-cw-reply-cancel]')
      if (replyCancel instanceof HTMLElement) {
        closeReplyBoxes(section, state)
        return
      }
      const menuPanel = target.closest('[data-cw-comment-menu-panel]')
      if (!menuPanel) {
        closeMenus(section, state)
      }
    })

    section.addEventListener('submit', (event) => {
      const target = event.target
      if (!(target instanceof HTMLFormElement)) return
      if (target.matches('[data-cw-reply-form]')) {
        event.preventDefault()
        const submitBtn = target.querySelector('[data-cw-reply-submit]')
        if (submitBtn instanceof HTMLElement) {
          handleReplySubmit(section, state, submitBtn)
        }
      }
    })

    document.addEventListener('click', (evt) => {
      const within = section.contains(evt.target)
      if (!within) {
        closeMenus(section, state)
      }
    })

    const replyIndicator = section.querySelector('[data-cw-comment-reply-indicator]')
    if (replyIndicator instanceof HTMLElement) {
      replyIndicator.remove()
    }
  }

  const initSection = (section, entityType) => {
    const meta = DetailTelemetry.getMeta() || {}
    const fallbackEntity = meta.entity || {}

    const state = {
      entityType,
      entityId: section.getAttribute('data-entity-id') || fallbackEntity.id || null,
      entitySlug: section.getAttribute('data-entity-slug') || fallbackEntity.slug || '',
      entityName: section.getAttribute('data-entity-name') || fallbackEntity.name || '',
      entitySummary: section.getAttribute('data-entity-summary') || fallbackEntity.summary || '',
      comments: [],
      meta: null,
      viewer: null,
      viewerRole: 'user',
      policy: null,
      nextAnonymousNumber: null,
      policySignature: null,
      loading: false,
      submitting: false,
      sort: 'latest',
      activeTab: 'all',
      bestThreshold: DEFAULT_POLICY.bestLikeThreshold,
      replyTarget: null,
      openMenuId: null
    }

    // 전역 __USER__로 viewer/role 초기 보정 (관리자 역할 인식)
    const globalUser = (typeof window !== 'undefined' && window.__USER__) ? window.__USER__ : null
    if (globalUser) {
      state.viewer = {
        id: globalUser.id,
        username: globalUser.username ?? null,
        role: globalUser.role ?? 'user',
        pictureUrl: globalUser.pictureUrl ?? null
      }
      state.viewerRole = globalUser.role ?? 'user'
    }

    SECTION_STATE.set(section, state)

    const datasetPolicy = readPolicyFromDataset(section)
    if (datasetPolicy) {
      state.policy = datasetPolicy
      state.policySignature = computePolicySignature(datasetPolicy)
      if (typeof datasetPolicy.bestLikeThreshold === 'number' && Number.isFinite(datasetPolicy.bestLikeThreshold)) {
        state.bestThreshold = datasetPolicy.bestLikeThreshold
      }
      updatePolicySummary(section, state.policy)
      applyAuthState(section, state)
      DetailTelemetry.emit('comments-policy-bootstrap', {
        component: 'comments',
        entityType: state.entityType,
        entityId: state.entityId,
        policySource: 'dataset',
        policySignature: state.policySignature ?? null,
        governance: getGovernanceFromState(state)
      })
    }

    refreshScoreboardCopy(section, state)
    updateTabButtons(section, state)
    updateSortButtons(section, state)
    bindTabButtons(section, state)
    bindSortButtons(section, state)
    applyAuthState(section, state)

    bindIntentButtons(section, state)
    bindForm(section, state)
    bindListActions(section, state)

    DetailTelemetry.emit('comments-placeholder', {
      component: 'comments',
      entityType: state.entityType,
      entityId: state.entityId,
      status: section.getAttribute('data-comments-status') || null,
      policySource: datasetPolicy ? 'dataset' : 'unknown',
      policySignature: state.policySignature ?? null,
      governance: getGovernanceFromState(state)
    })

    loadComments(section, state)
  }

  const init = (entityType) => {
    document
      .querySelectorAll(`[data-cw-comments][data-entity-type="${entityType}"]`)
      .forEach((section) => {
        if (!SECTION_STATE.has(section)) {
          initSection(section, entityType)
        }
      })
  }
  
  // 사용자 인증 상태 변경 시 댓글 폼 업데이트
  const refreshAuthState = (user) => {
    document.querySelectorAll('[data-cw-comments]').forEach(section => {
      const state = SECTION_STATE.get(section)
      if (!state) return
      
      // state.viewer 업데이트
      if (user && user.id) {
        state.viewer = {
          id: user.id,
          username: user.username ?? null,
          role: user.role ?? 'user',
          pictureUrl: user.pictureUrl ?? null
        }
        state.viewerRole = user.role ?? 'user'
      } else {
        state.viewer = null
        state.viewerRole = 'user'
      }
      
      // 폼 UI 업데이트
      applyAuthState(section, state)
    })
  }
  
  // cw-refresh-auth-state 이벤트 수신
  window.addEventListener('cw-refresh-auth-state', (event) => {
    refreshAuthState(event.detail)
  })

  return { init, refreshAuthState }
})()

const DetailPage = (() => {
  const initialized = new Set()

  const setupCtas = (entityType) => {
    document.querySelectorAll('[data-cw-cta]').forEach((element) => {
      if (element.dataset.ctaBound === '1') {
        return
      }
      element.dataset.ctaBound = '1'
      element.addEventListener('click', () => {
        const entityId = element.getAttribute('data-entity-id') || null
        const ctaType = element.getAttribute('data-cta-type') || null
        const variant = element.getAttribute('data-cta-variant') || null
        const indexAttr = element.getAttribute('data-cta-index')
        const index = typeof indexAttr === 'string' ? Number(indexAttr) : Number.NaN
        const label = element.getAttribute('data-cta-label') || (element.textContent ? element.textContent.trim() : null)
        DetailTelemetry.emit('cta-click', {
          component: 'cta-link',
          entityType,
          entityId,
          ctaType,
          href: element instanceof HTMLAnchorElement ? element.href : null,
          variant,
          label,
          index: Number.isFinite(index) ? index : null
        })
      })
    })
  }

  const setupComments = (entityType) => {
    DetailComments.init(entityType)
  }

  const setupShareButtons = (entityType) => {
    document.querySelectorAll('[data-share="true"]').forEach((button) => {
      if (button.dataset.shareBound === '1') {
        return
      }
      button.dataset.shareBound = '1'
      button.addEventListener('click', async (event) => {
        event.preventDefault()
        const entityId = button.getAttribute('data-entity-id') || null
        let method = 'none'
        let outcome = 'unavailable'

        if (navigator.share) {
          method = 'web-share'
          try {
            await navigator.share({
              title: document.title,
              text: document.title,
              url: window.location.href
            })
            outcome = 'success'
          } catch (error) {
            outcome = error && error.name === 'AbortError' ? 'cancel' : 'error'
          }
        } else if (navigator.clipboard && navigator.clipboard.writeText) {
          method = 'clipboard'
          try {
            await navigator.clipboard.writeText(window.location.href)
            outcome = 'success'
            button.dataset.shareStatus = 'copied'
            window.setTimeout(() => {
              delete button.dataset.shareStatus
            }, 2000)
          } catch (error) {
            outcome = 'error'
          }
        } else {
          method = 'link'
          outcome = 'fallback'
        }

        DetailTelemetry.emit('share', {
          component: 'share',
          entityType,
          entityId,
          method,
          outcome
        })
      })
    })
  }

  const setupHeroAnchors = (entityType) => {
    document.querySelectorAll('[data-cw-telemetry-action="hero-comment-anchor"]').forEach((anchor) => {
      if (anchor.dataset.heroAnchorBound === '1') {
        return
      }
      anchor.dataset.heroAnchorBound = '1'
      anchor.addEventListener('click', () => {
        const entityId = anchor.getAttribute('data-entity-id') || null
        const meta = DetailTelemetry.getMeta()
        const policy = meta?.extra && typeof meta.extra === 'object' && meta.extra !== null ? meta.extra.comments?.policy : null
        const governance = policy && typeof policy === 'object' && !Array.isArray(policy)
          ? {
              signature: computePolicySignature(policy),
              requiresAuth: typeof policy.requiresAuth === 'boolean' ? policy.requiresAuth : null,
              reportBlindThreshold: typeof policy.reportBlindThreshold === 'number' ? policy.reportBlindThreshold : null
            }
          : null
        DetailTelemetry.emit('hero-comment-anchor', {
          component: 'howto-hero-actions',
          entityType,
          entityId,
          target: '#cw-comments',
          governance
        })
      })
    })
  }

  const init = (entityType) => {
    if (initialized.has(entityType)) {
      return
    }
    initialized.add(entityType)

    DetailTabs.init(entityType)
    setupCtas(entityType)
    setupComments(entityType)
    setupShareButtons(entityType)
    setupHeroAnchors(entityType)
    DetailTelemetry.observeDom()
    DetailTelemetry.markReady()
  }

  return { init }
})()

// DOM 조작 유틸리티
const DOMUtils = {
  buildMajorUrl(entry) {
    if (!entry) return '#';
    const profile = entry.profile || entry;
    
    // ✅ 한글 이름이 있으면 한글 슬러그 사용, 없으면 ID 사용
    const nameSlug = this.slugifyName(profile.name);
    const slug = nameSlug || profile.id || profile.sourceIds?.careernet;
    
    if (!slug) return '#';

    // 🔄 쿼리 파라미터 제거: 병합된 데이터는 전공명으로만 접근
    return `/major/${encodeURIComponent(slug)}`;
  },
  
  buildMajorUrlOld(entry) {
    if (!entry) return '#';
    const profile = entry.profile || entry;
    const sourceMeta = entry.sourceMeta || {};
    const sourceIds = profile.sourceIds || {};
    const params = new URLSearchParams();

    if (sourceIds.careernet) {
      params.set('careernetId', sourceIds.careernet);
    }

    if (sourceMeta.goyong24) {
      const { majorGb, departmentId, majorId } = sourceMeta.goyong24;
      if (majorGb && departmentId && majorId) {
        params.set('goyongMajorGb', majorGb);
        params.set('goyongDepartmentId', departmentId);
        params.set('goyongMajorId', majorId);
      }
    }

    // ✅ 한글 이름이 있으면 한글 슬러그 사용, 없으면 ID 사용
    const nameSlug = this.slugifyName(profile.name);
    const slug = nameSlug || profile.id || sourceIds.careernet;
    
    if (!slug) return '#';

    const query = params.toString();
    return `/major/${encodeURIComponent(slug)}${query ? `?${query}` : ''}`;
  },

  // 한글 슬러그 생성 함수 (서버의 composeDetailSlug와 동일한 로직)
  slugifyName(value) {
    if (!value) return '';
    const HANGUL_SEPARATOR_REGEX = /[·•]/g;
    const SLUG_INVALID_REGEX = /[^0-9a-z\u3131-\u314e\u314f-\u3163가-힣-]+/gi;
    
    const normalized = value.normalize ? value.normalize('NFKC') : value;
    const slug = normalized
      .replace(HANGUL_SEPARATOR_REGEX, '-')
      .trim()
      .toLowerCase()
      .replace(/\s+/g, '-')
      .replace(SLUG_INVALID_REGEX, '-')
      .replace(/-+/g, '-')
      .replace(/^-+|-+$/g, '');
    
    // 최대 길이 140자로 제한
    return slug.length <= 140 ? slug : slug.slice(0, 140).replace(/-+$/g, '');
  },

  buildJobUrl(entry) {
    if (!entry) return '#';
    const profile = entry.profile || entry;
    
    // ✅ 한글 이름이 있으면 한글 슬러그 사용, 없으면 ID 사용
    const nameSlug = this.slugifyName(profile.name);
    const slug = nameSlug || profile.id || profile.sourceIds?.careernet;
    
    if (!slug) return '#';

    // 🔄 쿼리 파라미터 제거: 병합된 데이터는 직업명으로만 접근
    return `/job/${encodeURIComponent(slug)}`;
  },

  normalizeMajorItem(item) {
    if (!item) return null;

    if (item.profile) {
      const profile = item.profile;
      const normalized = {
        profile,
        display: item.display || {},
        sourceMeta: item.sourceMeta || {}
      };
      normalized.url = this.buildMajorUrl(normalized);
      return normalized;
    }

    const profile = {
      id: item.id || (item.majorSeq ? `major:C_${item.majorSeq}` : undefined),
      name: item.name || item.major || '학과명 없음',
      sourceIds: {
        careernet: item.sourceIds?.careernet || item.majorSeq
      },
      sources: item.sources || ['CAREERNET']
    };

    const normalized = {
      profile,
      display: {
        summary: item.summary,
        categoryName: item.department,
        employmentRate: item.employmentRate,
        salaryAfterGraduation: item.salaryAfterGraduation
      },
      sourceMeta: {
        careernet: {
          majorSeq: item.sourceIds?.careernet || item.majorSeq
        }
      }
    };

    normalized.url = this.buildMajorUrl(normalized);
    return normalized;
  },

  normalizeJobItem(item) {
    if (!item) return null;

    if (item.profile) {
      const profile = item.profile;
      const normalized = {
        profile,
        display: item.display || {},
        sourceMeta: item.sourceMeta || {}
      };
      normalized.url = this.buildJobUrl(normalized);
      return normalized;
    }

    const profile = {
      id: item.id || (item.jobdicSeq ? `job:C_${item.jobdicSeq}` : undefined),
      name: item.name || item.jobName || '직업명 없음',
      sourceIds: {
        careernet: item.sourceIds?.careernet || item.jobdicSeq
      },
      sources: item.sources || ['CAREERNET']
    };

    const normalized = {
      profile,
      display: {
        summary: item.summary,
        salary: item.avgSalary || item.salaryRange,
        outlook: item.jobOutlook,
        categoryName: item.jobCategoryName
      },
      sourceMeta: {
        careernet: {
          jobdicSeq: item.sourceIds?.careernet || item.jobdicSeq
        }
      }
    };

    normalized.url = this.buildJobUrl(normalized);
    return normalized;
  },

  // 로딩 표시
  showLoading(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
      element.innerHTML = `
        <div class="text-center py-8">
          <i class="fas fa-spinner fa-spin text-3xl text-wiki-secondary"></i>
          <p class="mt-4 text-wiki-muted">데이터를 불러오는 중...</p>
        </div>
      `;
    }
  },

  // 오류 표시
  showError(elementId, message) {
    const element = document.getElementById(elementId);
    if (element) {
      element.innerHTML = `
        <div class="text-center py-8">
          <i class="fas fa-exclamation-triangle text-3xl text-red-500"></i>
          <p class="mt-4 text-wiki-muted">${message}</p>
        </div>
      `;
    }
  },

  // 학과 카드 생성 (클라이언트 정렬용)
  createMajorCard(major) {
    const normalized = this.normalizeMajorItem(major);
    if (!normalized) return '';
    const { profile, display, url } = normalized;
    const summary = display.summary || '설명 없음';
    const categoryName = display.categoryName && display.categoryName.split(',').length <= 2 ? display.categoryName : undefined;
    
    const satisfactionGrade = (() => {
      if (!display.firstJobSatisfaction) return null;
      const score = parseFloat(display.firstJobSatisfaction) || 0;
      if (score >= 80) return { level: '매우 좋음', bg: 'bg-green-500/10', border: 'border-green-500/20', iconColor: 'text-green-400', textColor: 'text-green-300', textMuted: 'text-green-300/80' };
      if (score >= 60) return { level: '좋음', bg: 'bg-sky-500/10', border: 'border-sky-500/20', iconColor: 'text-sky-400', textColor: 'text-sky-300', textMuted: 'text-sky-300/80' };
      if (score >= 40) return { level: '보통', bg: 'bg-yellow-500/10', border: 'border-yellow-500/20', iconColor: 'text-yellow-400', textColor: 'text-yellow-300', textMuted: 'text-yellow-300/80' };
      if (score >= 20) return { level: '별로', bg: 'bg-orange-500/10', border: 'border-orange-500/20', iconColor: 'text-orange-400', textColor: 'text-orange-300', textMuted: 'text-orange-300/80' };
      return { level: '매우 별로', bg: 'bg-red-500/10', border: 'border-red-500/20', iconColor: 'text-red-400', textColor: 'text-red-300', textMuted: 'text-red-300/80' };
    })();
    
    const metricBoxes = [];
    if (display.employmentRate) {
      const rateText = formatEmploymentRate(display.employmentRate) || '';
      metricBoxes.push({ priority: 1, html: `<div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-blue-500/10 backdrop-blur-sm border border-blue-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0"><i class="fas fa-chart-line text-blue-400 text-base sm:text-lg"></i><span class="text-[9px] sm:text-[10px] font-medium text-blue-300/70">취업률</span><span class="text-[11px] sm:text-[13px] font-bold text-blue-300 text-center leading-tight px-1">${rateText}</span></div>` });
    }
    if (display.firstJobSalary) {
      const salaryText = display.firstJobSalary.includes('만원') ? display.firstJobSalary : `${display.firstJobSalary}만원`;
      metricBoxes.push({ priority: 2, html: `<div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0"><i class="fas fa-won-sign text-emerald-400 text-base sm:text-lg"></i><span class="text-[9px] sm:text-[10px] font-medium text-emerald-300/70">평균 월급</span><span class="text-[11px] sm:text-[13px] font-bold text-emerald-300 text-center leading-tight px-1">${salaryText}</span></div>` });
    }
    if (display.firstJobSatisfaction && satisfactionGrade) {
      metricBoxes.push({ priority: 3, html: `<div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0"><i class="fas fa-smile ${satisfactionGrade.iconColor} text-base sm:text-lg"></i><span class="text-[9px] sm:text-[10px] font-medium ${satisfactionGrade.textMuted}">만족도</span><span class="text-[11px] sm:text-[13px] font-bold ${satisfactionGrade.textColor}">${satisfactionGrade.level}</span></div>` });
    }
    if (categoryName) {
      metricBoxes.push({ priority: 4, html: `<div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-purple-500/10 backdrop-blur-sm border border-purple-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0"><i class="fas fa-graduation-cap text-purple-400 text-base sm:text-lg"></i><span class="text-[9px] sm:text-[10px] font-medium text-purple-300/70">계열</span><span class="text-[11px] sm:text-[13px] font-bold text-purple-300 text-center leading-tight px-1">${categoryName.length > 10 ? categoryName.substring(0, 10) + '...' : categoryName}</span></div>` });
    }
    const sortedBoxes = metricBoxes.sort((a, b) => a.priority - b.priority).slice(0, 3);
    const metrics = sortedBoxes.map((box, i) => i === 2 ? `<div class="hidden sm:flex">${box.html}</div>` : box.html).join('');
    
    // 썸네일 HTML 생성 (메트릭 박스와 같거나 큰 크기, 수직 중앙 정렬)
    const imageUrl = display.imageUrl;
    const thumbnailHtml = imageUrl 
      ? `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl overflow-hidden bg-wiki-card/60 border border-wiki-border/30"><img src="${imageUrl}" alt="${profile.name || ''}" class="w-full h-full object-cover" loading="lazy" onerror="this.parentElement.innerHTML='<div class=\\'flex items-center justify-center w-full h-full text-wiki-muted\\' aria-hidden=\\'true\\'><i class=\\'fas fa-graduation-cap text-3xl\\'></i></div>'" /></div>`
      : `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl bg-gradient-to-br from-wiki-secondary/10 to-wiki-primary/10 border border-wiki-border/30 flex items-center justify-center"><i class="fas fa-graduation-cap text-3xl text-wiki-muted" aria-hidden="true"></i></div>`;

    return `<article class="group relative"><a href="${url}" class="block"><div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1"><div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"><div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div><div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div></div><div class="relative flex gap-3 sm:gap-4">${thumbnailHtml}<div class="flex-1 space-y-3 sm:space-y-4 min-w-0 max-w-[60%]"><div class="space-y-1.5 sm:space-y-2"><h2 class="text-lg sm:text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">${profile.name || '학과명 없음'}</h2></div><p class="text-[13px] sm:text-[15px] leading-relaxed text-wiki-muted/90 line-clamp-2">${summary}</p></div>${metrics ? `<div class="flex gap-2 sm:gap-2.5 items-center justify-end flex-shrink-0 ml-auto">${metrics}</div>` : ''}</div></div></a></article>`;
  },

  // 숙련기간 포맷팅: 단위가 같을 때 앞 단위 제거 (예: "1년~2년" → "1~2년")
  formatSkillYear(value) {
    if (!value) return '';
    let trimmed = String(value).trim();
    if (!trimmed) return '';
    
    // "초과", "이하" 제거
    trimmed = trimmed
      .replace(/\s*초과\s*/g, ' ')
      .replace(/\s*이하\s*/g, '')
      .replace(/\s+/g, ' ')
      .trim();
    
    // "~" 또는 "-"로 구분된 범위 형식인지 확인 (공백 무시)
    const rangeMatch = trimmed.match(/^(.+?)\s*([~-])\s*(.+)$/);
    if (!rangeMatch) return trimmed; // 범위 형식이 아니면 그대로 반환
    
    const [, start, separator, end] = rangeMatch;
    
    // 단위 추출 (년, 개월 등) - 앞뒤 공백 제거
    const startTrimmed = start.trim();
    const unitMatch = startTrimmed.match(/(\d+)\s*(년|개월|월)$/);
    if (!unitMatch) return trimmed; // 단위가 없으면 그대로 반환
    
    const [, startNum, unit] = unitMatch;
    
    // 끝 부분에서 같은 단위가 있는지 확인 - 앞뒤 공백 제거
    const endTrimmed = end.trim();
    const endMatch = endTrimmed.match(/^(\d+)\s*(년|개월|월)$/);
    if (!endMatch) return trimmed; // 끝 부분에 단위가 없으면 그대로 반환
    
    const [, endNum, endUnit] = endMatch;
    
    // 단위가 같으면 앞 단위 제거
    if (unit === endUnit) {
      return `${startNum}${separator}${endNum}${unit}`;
    }
    
    // 단위가 다르면 그대로 반환
    return trimmed;
  },

  // 직업 카드 생성 (클라이언트 정렬용)
  createJobCard(job) {
    const normalized = this.normalizeJobItem(job);
    if (!normalized) return '';
    const { profile, display, url } = normalized;
    const summary = display.summary || '설명 없음';
    
    const satisfactionGrade = (() => {
      if (!display.satisfaction) return null;
      const score = parseFloat(display.satisfaction) || 0;
      if (score >= 80) return { level: '매우 좋음', bg: 'bg-green-500/10', border: 'border-green-500/20', iconColor: 'text-green-400', textColor: 'text-green-300', textMuted: 'text-green-300/80' };
      if (score >= 60) return { level: '좋음', bg: 'bg-sky-500/10', border: 'border-sky-500/20', iconColor: 'text-sky-400', textColor: 'text-sky-300', textMuted: 'text-sky-300/80' };
      if (score >= 40) return { level: '보통', bg: 'bg-yellow-500/10', border: 'border-yellow-500/20', iconColor: 'text-yellow-400', textColor: 'text-yellow-300', textMuted: 'text-yellow-300/80' };
      if (score >= 20) return { level: '별로', bg: 'bg-orange-500/10', border: 'border-orange-500/20', iconColor: 'text-orange-400', textColor: 'text-orange-300', textMuted: 'text-orange-300/80' };
      return { level: '매우 별로', bg: 'bg-red-500/10', border: 'border-red-500/20', iconColor: 'text-red-400', textColor: 'text-red-300', textMuted: 'text-red-300/80' };
    })();
    
    const metricBoxes = [];
    if (display.salary) {
      const salaryText = (display.salary || '').replace(/평균\s*/g, '');
      metricBoxes.push({ priority: 1, html: `<div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0"><i class="fas fa-won-sign text-emerald-400 text-base sm:text-lg"></i><span class="text-[9px] sm:text-[10px] font-medium text-emerald-300/70">평균 연봉</span><span class="text-[11px] sm:text-[13px] font-bold text-emerald-300 text-center leading-tight px-1">${salaryText}</span></div>` });
    }
    if (display.satisfaction && satisfactionGrade) {
      metricBoxes.push({ priority: 2, html: `<div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0"><i class="fas fa-smile ${satisfactionGrade.iconColor} text-base sm:text-lg"></i><span class="text-[9px] sm:text-[10px] font-medium ${satisfactionGrade.textMuted}">만족도</span><span class="text-[11px] sm:text-[13px] font-bold ${satisfactionGrade.textColor}">${satisfactionGrade.level}</span></div>` });
    }
    if (display.wlb) {
      metricBoxes.push({ priority: 3, html: `<div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-purple-500/10 backdrop-blur-sm border border-purple-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0"><i class="fas fa-balance-scale text-purple-400 text-base sm:text-lg"></i><span class="text-[9px] sm:text-[10px] font-medium text-purple-300/70">워라벨</span><span class="text-[11px] sm:text-[13px] font-bold text-purple-300 text-center leading-tight">${display.wlb}</span></div>` });
    }
    if (display.workStrong) {
      metricBoxes.push({ priority: 4, html: `<div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-amber-500/10 backdrop-blur-sm border border-amber-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0"><i class="fas fa-dumbbell text-amber-400 text-base sm:text-lg"></i><span class="text-[9px] sm:text-[10px] font-medium text-amber-300/70">작업 강도</span><span class="text-[11px] sm:text-[13px] font-bold text-amber-300 text-center leading-tight">${display.workStrong}</span></div>` });
    }
    if (display.skillYear) {
      const formattedSkillYear = this.formatSkillYear(display.skillYear);
      metricBoxes.push({ priority: 5, html: `<div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-cyan-500/10 backdrop-blur-sm border border-cyan-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0"><i class="fas fa-clock text-cyan-400 text-base sm:text-lg"></i><span class="text-[9px] sm:text-[10px] font-medium text-cyan-300/70">숙련기간</span><span class="text-[11px] sm:text-[13px] font-bold text-cyan-300 text-center leading-tight">${formattedSkillYear}</span></div>` });
    }
    const sortedBoxes = metricBoxes.sort((a, b) => a.priority - b.priority).slice(0, 3);
    const metrics = sortedBoxes.map((box, i) => i === 2 ? `<div class="hidden sm:flex">${box.html}</div>` : box.html).join('');
    
    // 썸네일 HTML 생성 (메트릭 박스와 같거나 큰 크기, 수직 중앙 정렬)
    const imageUrl = display.imageUrl;
    const thumbnailHtml = imageUrl 
      ? `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl overflow-hidden bg-wiki-card/60 border border-wiki-border/30"><img src="${imageUrl}" alt="${profile.name || ''}" class="w-full h-full object-cover" loading="lazy" onerror="this.parentElement.innerHTML='<div class=\\'flex items-center justify-center w-full h-full text-wiki-muted\\' aria-hidden=\\'true\\'><i class=\\'fas fa-briefcase text-3xl\\'></i></div>'" /></div>`
      : `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl bg-gradient-to-br from-wiki-primary/10 to-wiki-secondary/10 border border-wiki-border/30 flex items-center justify-center"><i class="fas fa-briefcase text-3xl text-wiki-muted" aria-hidden="true"></i></div>`;

    return `<article class="group relative"><a href="${url}" class="block"><div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1"><div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500"><div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div><div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div></div><div class="relative flex gap-3 sm:gap-4">${thumbnailHtml}<div class="flex-1 space-y-3 sm:space-y-4 min-w-0 max-w-[60%]"><div class="space-y-1.5 sm:space-y-2">${display.categoryName ? `<div class="flex items-center gap-2"><span class="inline-flex items-center gap-1 sm:gap-1.5 px-1.5 sm:px-2 py-0.5 rounded-md text-[9px] sm:text-[10px] font-semibold uppercase tracking-wider bg-wiki-secondary/10 text-wiki-secondary/80 border border-wiki-secondary/20"><i class="fas fa-folder text-[7px] sm:text-[8px]"></i>${display.categoryName}</span></div>` : ''}<h2 class="text-lg sm:text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">${profile.name || '직업명 없음'}</h2></div><p class="text-[13px] sm:text-[15px] leading-relaxed text-wiki-muted/90 line-clamp-2">${summary}</p></div>${metrics ? `<div class="flex gap-2 sm:gap-2.5 items-center justify-end flex-shrink-0 ml-auto">${metrics}</div>` : ''}</div></div></a></article>`;
  }
};

// 페이지별 초기화 함수
const PageInit = {
  // 홈페이지 초기화
  async initHome() {
  },

  // 검색 결과 페이지
  async initSearchResults() {
    const urlParams = new URLSearchParams(window.location.search);
    const keyword = urlParams.get('q') || '';
    
    if (!keyword) return;
    
    // 직업 검색 결과
    const jobResults = document.getElementById('job-search-results');
    if (jobResults) {
      DOMUtils.showLoading('job-search-results');
      const jobResult = await CareerAPI.searchJobs(keyword, '', 1, 5);
      const jobs = Array.isArray(jobResult.items) ? jobResult.items : [];
      
      if (jobs.length > 0) {
        jobResults.innerHTML = `
          <h2 class="text-2xl font-bold mb-4 gradient-text">직업 검색 결과</h2>
          <div class="grid gap-4">
            ${jobs.map(job => DOMUtils.createJobCard(job)).join('')}
          </div>
          ${jobs.length >= 5 ? `<a href="/job?q=${encodeURIComponent(keyword)}" class="text-wiki-primary hover:underline mt-4 inline-block">더 보기 →</a>` : ''}
        `;
      } else {
        jobResults.innerHTML = '';
      }
    }
    
    // 학과 검색 결과
    const majorResults = document.getElementById('major-search-results');
    if (majorResults) {
      DOMUtils.showLoading('major-search-results');
      const majorResult = await CareerAPI.searchMajors(keyword, 1, 5);
      const majors = Array.isArray(majorResult.items) ? majorResult.items : [];
      
      if (majors.length > 0) {
        majorResults.innerHTML = `
          <h2 class="text-2xl font-bold mb-4 gradient-text">학과 검색 결과</h2>
          <div class="grid gap-4">
            ${majors.map(major => DOMUtils.createMajorCard(major)).join('')}
          </div>
          ${majors.length >= 5 ? `<a href="/major?q=${encodeURIComponent(keyword)}" class="text-wiki-primary hover:underline mt-4 inline-block">더 보기 →</a>` : ''}
        `;
      } else {
        majorResults.innerHTML = '';
      }
    }
  }
};

// 직업 상세 공유 & 데모 인터랙션 모듈
const DemoDetailEnhancements = (() => {
  const escapeHtml = (value = '') =>
    String(value)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;')

  const formatDate = (value) => {
    if (!value) return ''
    const date = new Date(value)
    if (Number.isNaN(date.getTime())) {
      return ''
    }
    try {
      return date.toLocaleString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
      })
    } catch (_) {
      return ''
    }
  }

  const renderCommentItem = (comment, highlightBest = false) => {
    const likes = Number.isFinite(comment.likes) ? comment.likes : 0
    const dislikes = Number.isFinite(comment.dislikes) ? comment.dislikes : 0
    const badge = comment.badge ? `<span class="px-2 py-1 bg-wiki-secondary/20 text-wiki-secondary text-[11px] rounded-full">${escapeHtml(comment.badge)}</span>` : ''
    const roles = comment.role === 'expert' ? '<span class="px-2 py-1 bg-green-500/15 text-green-300 text-[11px] rounded-full">전문가</span>' : ''
    const statusLabel = highlightBest
      ? '<span class="px-2 py-1 bg-wiki-primary/20 text-wiki-primary text-[11px] rounded-full">BEST</span>'
      : ''

    return `
      <li class="border border-wiki-border/70 rounded-xl bg-wiki-bg/60 p-5 space-y-4" data-demo-comment>
        <header class="flex flex-wrap items-start justify-between gap-3">
          <div>
            <p class="text-sm font-semibold text-white flex items-center gap-2">
              ${escapeHtml(comment.author)}
              ${badge}
              ${roles}
              ${statusLabel}
            </p>
            <p class="text-[11px] text-wiki-muted">${formatDate(comment.createdAt)}</p>
          </div>
          <div class="flex items-center gap-3 text-xs text-wiki-muted">
            <span class="inline-flex items-center gap-1"><i class="fas fa-thumbs-up text-green-400" aria-hidden="true"></i>${likes}</span>
            <span class="inline-flex items-center gap-1"><i class="fas fa-thumbs-down text-rose-300" aria-hidden="true"></i>${dislikes}</span>
          </div>
        </header>
        <p class="text-sm leading-relaxed text-wiki-text">${escapeHtml(comment.content).replace(/\n/g, '<br>')}</p>
      </li>
    `
  }

  const sortComments = (comments, sortKey) => {
    const cloned = comments.slice()
    if (sortKey === 'likes') {
      cloned.sort((a, b) => {
        const likeDiff = (b.likes || 0) - (a.likes || 0)
        if (likeDiff !== 0) return likeDiff
        const dislikeDiff = (a.dislikes || 0) - (b.dislikes || 0)
        if (dislikeDiff !== 0) return dislikeDiff
        return new Date(b.createdAt || 0) - new Date(a.createdAt || 0)
      })
    } else {
      cloned.sort((a, b) => new Date(b.createdAt || 0) - new Date(a.createdAt || 0))
    }
    return cloned
  }

  const renderComments = (section, state) => {
    const allList = section.querySelector('[data-comment-list="all"]')
    const allEmpty = section.querySelector('[data-comment-empty="all"]')
    const bestList = section.querySelector('[data-comment-list="best"]')
    const bestEmpty = section.querySelector('[data-comment-empty="best"]')

    const sortedAll = sortComments(state.comments, state.sort)
    const bestCandidates = state.comments.filter((comment) => (comment.likes || 0) >= state.bestThreshold)
    const sortedBest = sortComments(bestCandidates, 'likes')

    if (allList) {
      allList.innerHTML = sortedAll.map((comment) => renderCommentItem(comment, (comment.likes || 0) >= state.bestThreshold)).join('')
    }
    if (allEmpty) {
      allEmpty.hidden = sortedAll.length > 0
    }

    if (bestList) {
      bestList.innerHTML = sortedBest.map((comment) => renderCommentItem(comment, true)).join('')
    }
    if (bestEmpty) {
      bestEmpty.hidden = sortedBest.length > 0
      bestEmpty.style.display = sortedBest.length > 0 ? 'none' : ''
    }
  }

  const activateTab = (section, state, tabId) => {
    const triggers = Array.from(section.querySelectorAll('[data-comment-tab]'))
    const panels = Array.from(section.querySelectorAll('[data-comment-panel]'))
    state.activeTab = tabId
    state.sort = tabId === 'best' ? 'likes' : 'latest'
    renderComments(section, state)
    triggers.forEach((trigger) => {
      const target = trigger.getAttribute('data-comment-tab')
      const isActive = target === tabId
      trigger.setAttribute('aria-selected', isActive ? 'true' : 'false')
      // 활성 상태: 파란 배경 + 흰 텍스트
      trigger.classList.toggle('bg-wiki-primary', isActive)
      trigger.classList.toggle('text-white', isActive)
      trigger.classList.toggle('shadow-sm', isActive)
      trigger.classList.toggle('border-wiki-primary/50', isActive)
      // 비활성 상태: 밝은 회색 텍스트
      trigger.classList.toggle('text-gray-300', !isActive)
      trigger.classList.toggle('border-transparent', !isActive)
      // 기존 스타일 제거
      trigger.classList.remove('text-wiki-muted')
    })
    panels.forEach((panel) => {
      const target = panel.getAttribute('data-comment-panel')
      panel.hidden = target !== tabId
    })
  }

  const bindTabs = (section, state) => {
    section.querySelectorAll('[data-comment-tab]').forEach((button) => {
      button.addEventListener('click', () => {
        const target = button.getAttribute('data-comment-tab') || 'all'
        activateTab(section, state, target)
      })
    })
  }

  const bindSortButtons = (section, state) => {
    section.querySelectorAll('[data-comment-sort]').forEach((button) => {
      button.addEventListener('click', () => {
        const sortKey = button.getAttribute('data-comment-sort') || 'latest'
        state.sort = sortKey
        section.querySelectorAll('[data-comment-sort]').forEach((other) => {
          const isActive = other === button
          other.setAttribute('aria-pressed', isActive ? 'true' : 'false')
          // 활성 상태: 파란 배경 + 흰 텍스트
          other.classList.toggle('bg-wiki-primary', isActive)
          other.classList.toggle('text-white', isActive)
          other.classList.toggle('shadow-sm', isActive)
          other.classList.toggle('border-wiki-primary/60', isActive)
          // 비활성 상태: 투명 배경 + 밝은 회색 텍스트
          other.classList.toggle('bg-transparent', !isActive)
          other.classList.toggle('text-gray-300', !isActive)
          other.classList.toggle('border-transparent', !isActive)
          // 기존 스타일 제거
          other.classList.remove('text-wiki-muted')
          other.classList.remove('text-wiki-primary')
          other.classList.remove('border-wiki-border')
        })
        renderComments(section, state)
      })
    })
  }

  const initComments = () => {
    document.querySelectorAll('[data-cw-comments][data-comment-demo="true"]').forEach((section) => {
      if (!(section instanceof HTMLElement)) {
        return
      }
      const raw = section.dataset.commentSample
      if (!raw) {
        return
      }
      let parsed = []
      try {
        parsed = JSON.parse(raw)
      } catch (error) {
        parsed = []
      }
      if (!Array.isArray(parsed) || !parsed.length) {
        return
      }
      const threshold = Number(section.dataset.commentBestThreshold) || 8
      const state = {
        comments: parsed,
        sort: 'latest',
        activeTab: 'all',
        bestThreshold: threshold
      }
      section.dataset.commentsStatus = 'demo'
      renderComments(section, state)
      activateTab(section, state, 'all')
      bindTabs(section, state)
      bindSortButtons(section, state)

      // 숨겨둔 기본 플레이스홀더 비활성화
      const legacyEmpty = section.querySelector('[data-cw-comments-empty]')
      if (legacyEmpty) {
        legacyEmpty.hidden = true
      }
      const legacyList = section.querySelector('[data-cw-comments-list]')
      if (legacyList) {
        legacyList.hidden = true
      }
    })
  }

  const initShare = () => {
    const overlay = document.getElementById('share-modal-overlay')
    const modal = document.getElementById('share-modal-global')
    const urlInput = document.getElementById('share-modal-url')
    const ogImg = document.getElementById('share-modal-og-img')
    const ogTitleEl = document.getElementById('share-modal-og-title')
    const thumbnail = document.getElementById('share-modal-thumbnail')

    if (!overlay || !modal || !urlInput) return

    let currentUrl = ''
    let currentTitle = ''
    let currentOgImage = ''

    const openModal = (url, title, ogImageUrl) => {
      currentUrl = url
      currentTitle = title
      currentOgImage = ogImageUrl || ''
      urlInput.value = url
      if (ogTitleEl) ogTitleEl.textContent = title

      if (ogImg && thumbnail) {
        if (ogImageUrl) {
          ogImg.src = ogImageUrl
          ogImg.alt = title
          thumbnail.classList.remove('hidden')
        } else {
          thumbnail.classList.add('hidden')
        }
      }

      overlay.classList.remove('hidden')
      modal.classList.remove('hidden')
      document.body.style.overflow = 'hidden'
    }

    // AI 결과 등 외부에서 글로벌 공유 모달을 열 수 있도록 노출
    window.__openShareModal = openModal

    const closeModal = () => {
      overlay.classList.add('hidden')
      modal.classList.add('hidden')
      document.body.style.overflow = ''
    }

    // 닫기: 오버레이 + X 버튼
    document.querySelectorAll('[data-share-modal-close]').forEach(function (el) {
      el.addEventListener('click', closeModal)
    })

    // ESC 키
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && !modal.classList.contains('hidden')) closeModal()
    })

    // 트리거 버튼들 (data-share-root 패턴)
    document.querySelectorAll('[data-share-root]').forEach(function (root) {
      var trigger = root.querySelector('[data-share-trigger]')
      if (!trigger) return

      trigger.addEventListener('click', function (e) {
        e.preventDefault()
        var path = trigger.getAttribute('data-share-path') || window.location.pathname
        var title = trigger.getAttribute('data-share-title') || document.title
        var ogImage = trigger.getAttribute('data-share-og-image') || ''
        try {
          var url = new URL(path, window.location.origin).toString()
        } catch (_) {
          var url = window.location.origin + path
        }
        openModal(url, title, ogImage)
      })
    })

    // 복사 버튼
    var copyBtn = document.querySelector('[data-share-modal-copy]')
    if (copyBtn) {
      copyBtn.addEventListener('click', async function () {
        try {
          await navigator.clipboard.writeText(currentUrl)
          copyBtn.textContent = '복사됨!'
          copyBtn.classList.add('bg-green-600')
          copyBtn.classList.remove('bg-wiki-primary')
          setTimeout(function () {
            copyBtn.textContent = '복사'
            copyBtn.classList.remove('bg-green-600')
            copyBtn.classList.add('bg-wiki-primary')
          }, 1500)
        } catch (err) {
          urlInput.select()
        }
      })
    }

    // SNS: X (Twitter)
    var xBtn = document.querySelector('[data-share-x]')
    if (xBtn) {
      xBtn.addEventListener('click', function () {
        window.open('https://twitter.com/intent/tweet?url=' + encodeURIComponent(currentUrl) + '&text=' + encodeURIComponent(currentTitle), '_blank', 'width=550,height=420')
      })
    }

    // SNS: Facebook
    var fbBtn = document.querySelector('[data-share-facebook]')
    if (fbBtn) {
      fbBtn.addEventListener('click', function () {
        window.open('https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(currentUrl), '_blank', 'width=550,height=420')
      })
    }

    // SNS: LinkedIn
    var linkedinBtn = document.querySelector('[data-share-linkedin]')
    if (linkedinBtn) {
      linkedinBtn.addEventListener('click', function () {
        window.open('https://www.linkedin.com/sharing/share-offsite/?url=' + encodeURIComponent(currentUrl), '_blank', 'width=550,height=420')
      })
    }

    // SNS: 카카오톡
    var kakaoBtn = document.querySelector('[data-share-kakao]')
    if (kakaoBtn) {
      kakaoBtn.addEventListener('click', function () {
        if (window.Kakao && window.Kakao.Share) {
          var imgUrl = currentOgImage
          if (imgUrl && !imgUrl.startsWith('http')) {
            imgUrl = new URL(imgUrl, window.location.origin).toString()
          }
          window.Kakao.Share.sendDefault({
            objectType: 'feed',
            content: {
              title: currentTitle,
              description: 'Careerwiki에서 자세히 보기',
              imageUrl: imgUrl || 'https://careerwiki.org/images/og-default.png',
              link: { mobileWebUrl: currentUrl, webUrl: currentUrl }
            },
            buttons: [{
              title: '자세히 보기',
              link: { mobileWebUrl: currentUrl, webUrl: currentUrl }
            }]
          })
        } else {
          // SDK 미로드 시 fallback
          if (navigator.share) {
            navigator.share({ title: currentTitle, url: currentUrl }).catch(function(){})
          } else {
            alert('링크가 클립보드에 복사되었습니다.')
            navigator.clipboard.writeText(currentUrl).catch(function(){})
          }
        }
      })
    }

    // 모바일 네이티브 공유 (더보기)
    var nativeBtn = document.querySelector('[data-share-native]')
    if (nativeBtn) {
      nativeBtn.addEventListener('click', async function () {
        if (navigator.share) {
          try {
            await navigator.share({ title: currentTitle, url: currentUrl })
          } catch (_) { /* user cancelled */ }
        }
      })
    }
  }

  const initSources = () => {
    document.querySelectorAll('[data-source-collapsible]').forEach((container) => {
      const button = container.querySelector('[data-source-toggle]')
      const panel = container.querySelector('[data-source-panel]')
      if (!button || !panel) {
        return
      }
      button.addEventListener('click', () => {
        const isHidden = panel.classList.contains('hidden')
        if (isHidden) {
          panel.classList.remove('hidden')
          button.setAttribute('aria-expanded', 'true')
          const icon = button.querySelector('i.fa-chevron-down')
          if (icon) {
            icon.style.transform = 'rotate(180deg)'
          }
        } else {
          panel.classList.add('hidden')
          button.setAttribute('aria-expanded', 'false')
          const icon = button.querySelector('i.fa-chevron-down')
          if (icon) {
            icon.style.transform = 'rotate(0deg)'
          }
        }
      })
    })
  }

  const init = () => {
    initShare()
    initComments()
    initSources()
  }

  return { init, initShare, initComments, initSources }
})()

// ============================================
// 관리자용 이미지 관리 모듈
// ============================================
const AdminImageManager = (() => {
  let isAdmin = false;

  // XSS 방지용 HTML 이스케이프
  const esc = (v = '') => String(v).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');

  // 관리자 여부 확인
  const checkAdminStatus = async () => {
    try {
      const resp = await fetch('/api/me');
      if (!resp.ok) return false;
      const data = await resp.json();
      return data?.user?.role === 'admin';
    } catch (e) {
      return false;
    }
  };

  // 이미지 재생성 모달 표시
  const showRegenerateModal = (type, slug, title) => {
    // 기존 모달 제거
    const existingModal = document.getElementById('cw-image-regen-modal');
    if (existingModal) existingModal.remove();

    const modalHtml = `
      <div id="cw-image-regen-modal" class="fixed inset-0 z-[9999] flex items-center justify-center p-4" style="background: rgba(0,0,0,0.8);">
        <div class="bg-wiki-card border border-wiki-border rounded-2xl p-6 max-w-lg w-full shadow-2xl">
          <h3 class="text-xl font-bold text-white mb-4">
            <i class="fas fa-image mr-2 text-wiki-primary"></i>
            이미지 재생성
          </h3>
          <p class="text-wiki-muted text-sm mb-4">
            "${title}" 이미지를 새로 생성합니다.
          </p>
          <div class="mb-4">
            <details class="group">
              <summary class="cursor-pointer text-sm text-wiki-muted hover:text-wiki-text transition-colors flex items-center gap-1">
                <i class="fas fa-chevron-right text-xs transition-transform group-open:rotate-90"></i>
                직접 프롬프트 입력 (선택사항)
              </summary>
              <textarea
                id="image-prompt-input"
                class="w-full mt-2 px-4 py-3 bg-wiki-bg border border-wiki-border rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:border-wiki-primary resize-none"
                rows="3"
                placeholder="비워두면 AI가 자동으로 프롬프트를 생성합니다"
              ></textarea>
            </details>
          </div>
          <div class="flex gap-3 justify-end">
            <button type="button" class="px-4 py-2 rounded-lg border border-wiki-border text-wiki-muted hover:text-white hover:border-wiki-text transition-colors" data-action="cancel">
              취소
            </button>
            <button type="button" class="px-4 py-2 rounded-lg bg-wiki-primary text-white hover:bg-wiki-primary/80 transition-colors flex items-center gap-2" data-action="generate">
              <i class="fas fa-magic"></i>
              자동 생성
            </button>
          </div>
          <div id="image-regen-status" class="mt-4 hidden">
            <div class="flex items-center gap-3 p-3 rounded-lg bg-wiki-bg border border-wiki-border">
              <i class="fas fa-spinner fa-spin text-wiki-primary"></i>
              <span class="text-sm text-wiki-muted">이미지 생성 중... (약 10-30초 소요)</span>
            </div>
          </div>
        </div>
      </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalHtml);

    const modal = document.getElementById('cw-image-regen-modal');
    const promptInput = document.getElementById('image-prompt-input');
    const statusDiv = document.getElementById('image-regen-status');

    // 취소 버튼
    modal.querySelector('[data-action="cancel"]').addEventListener('click', () => {
      modal.remove();
    });

    // 배경 클릭 시 닫기
    modal.addEventListener('click', (e) => {
      if (e.target === modal) modal.remove();
    });

    // 폴링으로 이미지 생성 상태 확인 후 저장
    const pollAndSaveImage = async (taskId, type, slug) => {
      const maxAttempts = 120; // 최대 120회 (약 2분)
      const pollInterval = 1000; // 1초 간격 (더 빠른 응답)
      
      for (let i = 0; i < maxAttempts; i++) {
        statusDiv.innerHTML = `
          <div class="flex items-center gap-3 p-3 rounded-lg bg-wiki-bg border border-wiki-border">
            <i class="fas fa-spinner fa-spin text-wiki-primary"></i>
            <span class="text-sm text-wiki-muted">이미지 생성 중... (${i}초 경과)</span>
          </div>
        `;
        
        try {
          const statusResp = await fetch(`/api/image/status/${taskId}`);
          const statusData = await statusResp.json();
          
          if (!statusData.success) {
            throw new Error(statusData.error || '상태 조회 실패');
          }
          
          if (statusData.status === 'failed') {
            throw new Error('이미지 생성 실패');
          }
          
          if (statusData.status === 'completed' && statusData.imageUrl) {
            // 이미지 저장 API 호출
            statusDiv.innerHTML = `
              <div class="flex items-center gap-3 p-3 rounded-lg bg-wiki-bg border border-wiki-border">
                <i class="fas fa-spinner fa-spin text-wiki-primary"></i>
                <span class="text-sm text-wiki-muted">이미지 저장 중...</span>
              </div>
            `;
            
            const saveResp = await fetch('/api/image/save', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({
                taskId,
                type,
                slug,
                imageUrl: statusData.imageUrl
              })
            });
            
            const saveData = await saveResp.json();
            
            if (!saveData.success) {
              throw new Error(saveData.error || '이미지 저장 실패');
            }
            
            // 성공!
            return saveData;
          }
        } catch (pollError) {
          throw pollError;
        }
        
        // 대기
        await new Promise(resolve => setTimeout(resolve, pollInterval));
      }
      
      throw new Error('이미지 생성 시간 초과 (2분)');
    };

    // 생성 버튼
    modal.querySelector('[data-action="generate"]').addEventListener('click', async () => {
      const prompt = promptInput ? promptInput.value.trim() : '';

      // 버튼 비활성화 및 상태 표시
      const generateBtn = modal.querySelector('[data-action="generate"]');
      generateBtn.disabled = true;
      generateBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 요청 중...';
      statusDiv.classList.remove('hidden');

      try {
        // 1. 이미지 생성 요청
        const resp = await fetch('/api/image/generate', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            type,
            slug,
            ...(prompt ? { promptOverride: prompt } : {})
          })
        });

        const result = await resp.json();

        if (!result.success) {
          throw new Error(result.error || '이미지 생성 요청 실패');
        }

        // 2. 폴링으로 완료 대기 후 저장
        const saveResult = await pollAndSaveImage(result.taskId, type, slug);

        // 성공 메시지
        console.log('[ImageRegen] Save result:', JSON.stringify(saveResult));
        const dbg = saveResult.debug || {};
        const debugInfo = saveResult.debug ? `
          <div class="mt-2 p-2 rounded bg-black/40 text-xs font-mono text-emerald-400/70 space-y-1">
            <p>R2 Key: ${esc(dbg.fileKey)}</p>
            <p>Download: ${esc(String(dbg.downloadSize))} bytes (${esc(dbg.actualContentType)})</p>
            <p>Source: ${esc((dbg.sourceUrl || '').substring(0, 80))}...</p>
            <p>DB changes: ${esc(String(dbg.dbChanges))}</p>
          </div>` : '';
        statusDiv.innerHTML = `
          <div class="p-3 rounded-lg bg-emerald-500/20 border border-emerald-500/40">
            <div class="flex items-center gap-3">
              <i class="fas fa-check-circle text-emerald-400"></i>
              <div>
                <p class="text-sm text-emerald-300 font-medium">이미지가 성공적으로 교체되었습니다!</p>
                <p class="text-xs text-emerald-400/70 mt-1">
                  <span id="regen-countdown">8</span>초 후 새로고침됩니다...
                </p>
              </div>
            </div>
            ${debugInfo}
          </div>
        `;

        // 8초 카운트다운 후 새로고침 (디버그 확인 가능)
        let countdown = 8;
        const countdownEl = document.getElementById('regen-countdown');
        const countdownInterval = setInterval(() => {
          countdown--;
          if (countdownEl) countdownEl.textContent = countdown;
          if (countdown <= 0) {
            clearInterval(countdownInterval);
            const url = new URL(window.location.href);
            url.searchParams.set('_t', Date.now());
            window.location.href = url.toString();
          }
        }, 1000);

      } catch (err) {
        statusDiv.innerHTML = `
          <div class="flex items-center gap-3 p-3 rounded-lg bg-red-500/20 border border-red-500/40">
            <i class="fas fa-exclamation-circle text-red-400"></i>
            <span class="text-sm text-red-300">${esc(err.message)}</span>
          </div>
        `;
        generateBtn.disabled = false;
        generateBtn.innerHTML = '<i class="fas fa-magic"></i> 다시 시도';
      }
    });
  };

  // 관리자 컨트롤 초기화
  const init = async () => {
    isAdmin = await checkAdminStatus();
    if (!isAdmin) return;

    // 관리자용 이미지 컨트롤 표시
    document.querySelectorAll('[data-admin-image-controls]').forEach((controls) => {
      controls.classList.remove('hidden');
      
      const type = controls.dataset.imageType;
      const slug = controls.dataset.imageSlug;
      const title = controls.dataset.imageTitle;

      const regenBtn = controls.querySelector('[data-action="regenerate-image"]');
      if (regenBtn) {
        regenBtn.addEventListener('click', (e) => {
          e.preventDefault();
          e.stopPropagation();
          showRegenerateModal(type, slug, title);
        });
      }
    });
  };

  return { init, showRegenerateModal };
})();

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', () => {
  const { pathname } = window.location;
  const normalizedPath = pathname.replace(/\/+$/, '') || '/';

  if (normalizedPath === '/') {
    PageInit.initHome();
  }

  if (normalizedPath === '/job') {
    Hydration.initJobSerp();
  }

  if (normalizedPath === '/major') {
    Hydration.initMajorSerp();
  }

  if (/^\/job\//.test(normalizedPath)) {
    DetailPage.init('job');
    DemoDetailEnhancements.init();
    AdminImageManager.init(); // 관리자 이미지 관리 초기화
  }

  if (/^\/major\//.test(normalizedPath)) {
    DetailPage.init('major');
    DemoDetailEnhancements.init();
    AdminImageManager.init(); // 관리자 이미지 관리 초기화
  }

  if (/^\/howto\//.test(normalizedPath)) {
    DetailPage.init('guide');
    DemoDetailEnhancements.init();
  }

  // AI 추천 결과 페이지: 글로벌 공유 모달 초기화
  if (/^\/analyzer\/(job|major)/.test(normalizedPath)) {
    DemoDetailEnhancements.initShare();
  }

  if (normalizedPath === '/search') {
    PageInit.initSearchResults();
  }
});

// bfcache 복원 시 인증 상태 재확인
window.addEventListener('pageshow', (event) => {
  if (event.persisted) {
    // bfcache에서 복원됨 - 인증 상태 재확인
    fetch('/api/me', { credentials: 'same-origin', cache: 'no-store', headers: { 'Cache-Control': 'no-store' } })
      .then(r => r.json())
      .then(data => {
        const prevUser = window.__USER__;
        window.__USER__ = data.user;
        window.__USER_LOADED__ = true;
        
        // 로그인 상태가 변경되었으면 페이지 새로고침
        const prevId = prevUser?.id;
        const newId = data.user?.id;
        if (prevId !== newId) {
          // 로그인/로그아웃 상태 변경됨 - 페이지 새로고침
          window.location.reload();
        }
      })
      .catch(() => {});
  }
});

// 헤더 유저 아이콘 업데이트 함수
const updateHeaderUserIcon = (user) => {
  const userMenuBtns = document.querySelectorAll('#user-menu-btn');
  userMenuBtns.forEach(btn => {
    if (user && user.id) {
      const pictureUrl = user.pictureUrl || user.picture_url || user.custom_picture_url;
      if (pictureUrl) {
        btn.innerHTML = `<img src="${pictureUrl}" alt="사용자" class="w-full h-full object-cover rounded-full">`;
      } else {
        btn.innerHTML = `<i class="fas fa-user-circle text-base"></i>`;
      }
    } else {
      btn.innerHTML = `<i class="fas fa-user-circle text-base"></i>`;
    }
  });
};

// 사용자 로드 이벤트 수신 - 헤더 및 UI 업데이트
window.addEventListener('userLoaded', (event) => {
  const user = event.detail;
  updateHeaderUserIcon(user);
  // 댓글 섹션은 DetailComments.refreshAuthState 이벤트로 처리
  window.dispatchEvent(new CustomEvent('cw-refresh-auth-state', { detail: user }));
});

// 페이지 로드 시 이미 사용자 정보가 로드되었으면 헤더 아이콘 업데이트
if (typeof window !== 'undefined' && window.__USER_LOADED__ && window.__USER__) {
  updateHeaderUserIcon(window.__USER__);
}