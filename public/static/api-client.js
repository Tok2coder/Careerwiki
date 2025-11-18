/**
 * CareerWiki API Client
 * 프론트엔드에서 API 호출을 위한 클라이언트
 */

// API Base URL (현재 도메인 사용)
const API_BASE = window.location.origin + '/api';
const TELEMETRY_VERSION = 'phase1-task3';

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
      console.error('학과 검색 오류:', error);
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
      console.error('학과 정보 조회 오류:', error);
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
      console.error('직업 검색 오류:', error);
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
      console.error('직업 정보 조회 오류:', error);
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
      console.error('카테고리 조회 오류:', error);
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
  relevance: '추천 순',
  'salary-desc': '연봉 높은 순',
  'outlook-desc': '전망 좋은 순',
  'name-asc': '이름 오름차순'
};

const MAJOR_SORT_LABELS = {
  relevance: '추천 순',
  'employment-desc': '취업률 높은 순',
  'salary-desc': '연봉 높은 순',
  'name-asc': '이름 오름차순'
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
    console.warn(`[hydration] JSON parse 실패: ${id}`, error);
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
    console.warn('[telemetry] failed to compute policy signature', error);
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
    sort: 'relevance',
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
    cacheState: meta?.cacheState || null
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

  const applyJobSort = (items, sortKey) => {
    if (!Array.isArray(items)) return [];
    const cloned = items.slice();
    switch (sortKey) {
      case 'salary-desc':
        return cloned.sort((a, b) => parseNumberFromText(b?.display?.salary) - parseNumberFromText(a?.display?.salary));
      case 'outlook-desc':
        return cloned.sort((a, b) => computeOutlookScore(b?.display?.outlook) - computeOutlookScore(a?.display?.outlook));
      case 'name-asc':
        return cloned.sort((a, b) => (a?.profile?.name || '').localeCompare(b?.profile?.name || ''));
      default:
        return cloned;
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
        return cloned;
    }
  };

  const hydrateJobSerp = () => {
    const container = document.getElementById('job-results');
    if (!container) return;
    const page = 'job';
    const component = `${page}-serp`;
    const hydrationStartedAt = now();
    const json = parseJsonScript('job-hydration-data');
    const state = createState(json?.items || [], ensureMetaDefaults(json?.meta || {}, (json?.items || []).length));

    const render = () => {
      const items = applyJobSort(state.baseItems, state.sort);
      if (items.length) {
        // ✅ 서버 렌더링 HTML 재활용 - DOM 순서만 재배치 (재렌더링 X)
        const existingCards = Array.from(container.children);
        
        // 초기 로드 또는 검색 후: 카드 개수가 다르면 재렌더링 필요
        if (existingCards.length !== items.length) {
          container.innerHTML = items.map((item) => DOMUtils.createJobCard(item)).join('');
        } else {
          // 정렬만 변경: 기존 DOM 요소 순서 재배치
          const cardMap = new Map();
          existingCards.forEach(card => {
            const link = card.querySelector('a[href^="/job/"]');
            if (link) {
              const slug = link.getAttribute('href');
              cardMap.set(slug, card);
            }
          });
          
          // 정렬된 순서대로 DOM 재배치
          items.forEach((item) => {
            const normalized = DOMUtils.normalizeJobItem(item);
            if (!normalized) return;
            
            const card = cardMap.get(normalized.url);
            if (card) {
              container.appendChild(card); // 자동으로 순서 재배치됨
            }
          });
        }
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
      emitHydrationAction(page, 'render', {
        results: Array.isArray(items) ? items.length : 0,
        sortKey: state.sort,
        total: typeof state.meta.total === 'number' ? state.meta.total : null,
        cacheStatus: state.meta?.cacheState?.status ?? null
      }, state);
      if (!state.isHydrated) {
        const duration = Math.max(now() - hydrationStartedAt, 0);
        const stateSnapshot = summarizeHydrationState(state);
        const completionPayload = {
          total: stateSnapshot?.total ?? null,
          results: Array.isArray(items) ? items.length : 0,
          sort: stateSnapshot?.sort ?? null,
          duration,
          cacheStatus: stateSnapshot?.cacheStatus ?? null,
          filters: {
            keyword: stateSnapshot?.keyword ?? null,
            category: stateSnapshot?.category ?? null,
            includeSources: stateSnapshot?.includeSources ?? null
          },
          pagination: {
            page: stateSnapshot?.page ?? null,
            perPage: stateSnapshot?.perPage ?? null
          },
          cacheAgeSeconds: stateSnapshot?.cacheAgeSeconds ?? null
        };
        window.dispatchEvent(new CustomEvent('cw-hydration-complete', {
          detail: {
            version: TELEMETRY_VERSION,
            source: 'hydration',
            page,
            component,
            payload: completionPayload,
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
    const perPageSelect = document.getElementById('job-per-page');

    if (sortSelect) {
      sortSelect.value = state.sort;
      sortSelect.addEventListener('change', () => {
        state.sort = sortSelect.value;
        emitHydrationAction(page, 'sort-change', { sortKey: state.sort }, state);
        render();
      });
    }

    if (form) {
      form.addEventListener('submit', async (event) => {
        event.preventDefault();
        const formData = new FormData(form);
        const keyword = (formData.get('q') || '').toString();
        const category = (formData.get('category') || '').toString();
        const perPageRaw = (formData.get('perPage') || '20').toString();
        const perPage = parseInt(perPageRaw, 10) || 20;
        const keywordLength = keyword.trim().length;
        const sanitizedCategory = category || null;
        const startTime = now();

        emitHydrationAction(page, 'filter-submit', {
          phase: 'start',
          keywordLength,
          category: sanitizedCategory,
          perPage
        }, state);

        DOMUtils.showLoading('job-results');
        updateHydrationStatus('job-hydration-status', { total: state.meta.total }, state.sort, JOB_SORT_LABELS);

        try {
          const result = await CareerAPI.searchJobs(keyword, category, 1, perPage, {
            sources: Array.isArray(state.meta.includeSources) ? state.meta.includeSources : undefined
          });
          const items = Array.isArray(result.items) ? result.items : [];
          state.baseItems = items;
          state.meta = ensureMetaDefaults(result.meta || {}, items.length);
          state.meta.keyword = keyword;
          state.meta.category = category;
          state.meta.includeSources = state.meta.includeSources || (result.meta?.sources ? Object.keys(result.meta.sources) : null);
          state.meta.cacheState = null;
          state.sort = sortSelect ? sortSelect.value : 'relevance';

          if (perPageSelect) {
            perPageSelect.value = String(perPage);
          }

          const params = new URLSearchParams();
          if (keyword) params.set('q', keyword);
          if (category) params.set('category', category);
          if (perPage !== 20) params.set('perPage', String(perPage));
          window.history.replaceState({}, '', `${window.location.pathname}${params.toString() ? `?${params.toString()}` : ''}`);

          emitHydrationAction(page, 'filter-submit', {
            phase: 'complete',
            keywordLength,
            category: sanitizedCategory,
            perPage,
            duration: Math.max(now() - startTime, 0),
            results: items.length,
            cacheStatus: result.meta?.cacheState?.status ?? null
          }, state);
        } catch (error) {
          console.error('[hydration][job] 검색 실패', error);
          state.baseItems = [];
          emitHydrationAction(page, 'filter-submit', {
            phase: 'error',
            keywordLength,
            category: sanitizedCategory,
            perPage,
            duration: Math.max(now() - startTime, 0)
          }, state);
        } finally {
          render();
        }
      });
    }

    if (perPageSelect && form) {
      perPageSelect.addEventListener('change', () => {
        const nextPerPage = parseInt(perPageSelect.value, 10) || 20;
        emitHydrationAction(page, 'per-page-change', { perPage: nextPerPage }, state);
        form.requestSubmit();
      });
    }

    render();
  };

  const hydrateMajorSerp = () => {
    const container = document.getElementById('major-results');
    if (!container) return;
    const page = 'major';
    const component = `${page}-serp`;
    const hydrationStartedAt = now();
    const json = parseJsonScript('major-hydration-data');
    const state = createState(json?.items || [], ensureMetaDefaults(json?.meta || {}, (json?.items || []).length));

    const render = () => {
      const items = applyMajorSort(state.baseItems, state.sort);
      if (items.length) {
        container.innerHTML = items.map((item) => DOMUtils.createMajorCard(item)).join('');
      } else {
        container.innerHTML = emptyMajorMessage;
      }
      updateSourceSummary('major-source-summary', state.meta.sources);
      updateHydrationStatus('major-hydration-status', state.meta, state.sort, MAJOR_SORT_LABELS);
      const totalEl = document.getElementById('major-total-count');
      if (totalEl && typeof state.meta.total === 'number') {
        totalEl.textContent = String(state.meta.total);
      }
      emitHydrationAction(page, 'render', {
        results: Array.isArray(items) ? items.length : 0,
        sortKey: state.sort,
        total: typeof state.meta.total === 'number' ? state.meta.total : null,
        cacheStatus: state.meta?.cacheState?.status ?? null
      }, state);
      if (!state.isHydrated) {
        const duration = Math.max(now() - hydrationStartedAt, 0);
        const stateSnapshot = summarizeHydrationState(state);
        const completionPayload = {
          total: stateSnapshot?.total ?? null,
          results: Array.isArray(items) ? items.length : 0,
          sort: stateSnapshot?.sort ?? null,
          duration,
          cacheStatus: stateSnapshot?.cacheStatus ?? null,
          filters: {
            keyword: stateSnapshot?.keyword ?? null,
            category: stateSnapshot?.category ?? null,
            includeSources: stateSnapshot?.includeSources ?? null
          },
          pagination: {
            page: stateSnapshot?.page ?? null,
            perPage: stateSnapshot?.perPage ?? null
          },
          cacheAgeSeconds: stateSnapshot?.cacheAgeSeconds ?? null
        };
        window.dispatchEvent(new CustomEvent('cw-hydration-complete', {
          detail: {
            version: TELEMETRY_VERSION,
            source: 'hydration',
            page,
            component,
            payload: completionPayload,
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
    const perPageSelect = document.getElementById('major-per-page');

    if (sortSelect) {
      sortSelect.value = state.sort;
      sortSelect.addEventListener('change', () => {
        state.sort = sortSelect.value;
        emitHydrationAction(page, 'sort-change', { sortKey: state.sort }, state);
        render();
      });
    }

    if (form) {
      form.addEventListener('submit', async (event) => {
        event.preventDefault();
        const formData = new FormData(form);
        const keyword = (formData.get('q') || '').toString();
        const perPageRaw = (formData.get('perPage') || '20').toString();
        const perPage = parseInt(perPageRaw, 10) || 20;
        const keywordLength = keyword.trim().length;
        const startTime = now();

        emitHydrationAction(page, 'filter-submit', {
          phase: 'start',
          keywordLength,
          perPage
        }, state);

        DOMUtils.showLoading('major-results');
        updateHydrationStatus('major-hydration-status', { total: state.meta.total }, state.sort, MAJOR_SORT_LABELS);
        try {
          const result = await CareerAPI.searchMajors(keyword, 1, perPage, {
            sources: Array.isArray(state.meta.includeSources) ? state.meta.includeSources : undefined
          });
          const items = Array.isArray(result.items) ? result.items : [];
          state.baseItems = items;
          state.meta = ensureMetaDefaults(result.meta || {}, items.length);
          state.meta.keyword = keyword;
          state.meta.includeSources = state.meta.includeSources || (result.meta?.sources ? Object.keys(result.meta.sources) : null);
          state.meta.cacheState = null;
          state.sort = sortSelect ? sortSelect.value : 'relevance';

          if (perPageSelect) {
            perPageSelect.value = String(perPage);
          }

          const params = new URLSearchParams();
          if (keyword) params.set('q', keyword);
          if (perPage !== 20) params.set('perPage', String(perPage));
          window.history.replaceState({}, '', `${window.location.pathname}${params.toString() ? `?${params.toString()}` : ''}`);

          emitHydrationAction(page, 'filter-submit', {
            phase: 'complete',
            keywordLength,
            perPage,
            duration: Math.max(now() - startTime, 0),
            results: items.length,
            cacheStatus: result.meta?.cacheState?.status ?? null
          }, state);
        } catch (error) {
          console.error('[hydration][major] 검색 실패', error);
          state.baseItems = [];
          emitHydrationAction(page, 'filter-submit', {
            phase: 'error',
            keywordLength,
            perPage,
            duration: Math.max(now() - startTime, 0)
          }, state);
        } finally {
          render();
        }
      });
    }

    if (perPageSelect && form) {
      perPageSelect.addEventListener('change', () => {
        const nextPerPage = parseInt(perPageSelect.value, 10) || 20;
        emitHydrationAction(page, 'per-page-change', { perPage: nextPerPage }, state);
        form.requestSubmit();
      });
    }

    render();
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
  const ACTIVE_CLASSES = ['text-white', 'border-wiki-primary', 'bg-wiki-border/30']
  const INACTIVE_CLASSES = ['text-wiki-muted', 'border-transparent']

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

    // console.log('[DetailTabs] initTabset:', {
    //   tabsetId: tabset.id,
    //   entityType,
    //   triggersFound: triggers.length,
    //   panelsFound: panels.length
    // })

    if (!triggers.length || !panels.length) {
      console.warn('[DetailTabs] No triggers or panels found, skipping initialization')
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
        // console.log('[DetailTabs] Tab clicked:', targetId, 'Current active:', tabset.dataset.activeTab)
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

    DetailTelemetry.emit('tab-ready', {
      component: 'tabset',
      entityType,
      tabId: tabset.dataset.activeTab ?? null,
      totalTabs: triggerById.size
    })
  }

  const init = (entityType) => {
    const tabsets = document.querySelectorAll(`[data-cw-tabset][data-entity-type="${entityType}"]`)
    // console.log('[DetailTabs] Initializing tabs for entityType:', entityType, 'Found:', tabsets.length, 'tabsets')
    tabsets.forEach((tabset) => {
      // console.log('[DetailTabs] Initializing tabset:', tabset.id, tabset.dataset)
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
      console.warn('[comments] failed to parse policy dataset', error)
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
    const emptyEl = section.querySelector('[data-cw-comments-empty]')
    const listEl = section.querySelector('[data-cw-comments-list]')
    if (emptyEl) {
      emptyEl.hidden = hasComments
    }
    if (listEl) {
      listEl.hidden = !hasComments
    }
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

  const updateSortButtons = (section, state) => {
    const buttons = section.querySelectorAll('[data-comment-sort]')
    const activeKey = state?.sort === 'likes' ? 'likes' : 'latest'
    buttons.forEach((button) => {
      const target = button.getAttribute('data-comment-sort') === 'likes' ? 'likes' : 'latest'
      const isActive = target === activeKey
      button.setAttribute('aria-pressed', isActive ? 'true' : 'false')
      button.classList.toggle('bg-wiki-primary', isActive)
      button.classList.toggle('text-white', isActive)
      button.classList.toggle('shadow-sm', isActive)
      button.classList.toggle('border-wiki-primary/60', isActive)
      button.classList.toggle('text-wiki-muted', !isActive)
      button.classList.toggle('border-transparent', !isActive)
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
      trigger.classList.toggle('bg-wiki-primary', isActive)
      trigger.classList.toggle('text-white', isActive)
      trigger.classList.toggle('shadow-sm', isActive)
      trigger.classList.toggle('border-wiki-primary/50', isActive)
      trigger.classList.toggle('text-wiki-muted', !isActive)
      trigger.classList.toggle('border-transparent', !isActive)
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
    const hasViewer = Boolean(state.viewer?.id)

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
      const anonymousLabel = form.querySelector('[data-cw-comment-anonymous-label]')
      const anonymousNumberEl = form.querySelector('[data-cw-comment-anonymous-number]')
      const passwordInput = form.querySelector('[data-cw-comment-password]')
      const contentTextarea = form.querySelector('[data-cw-comment-content]')
      const charCountEl = form.querySelector('[data-cw-comment-char-count]')

      // 익명 사용자: 닉네임 입력 필드 숨김, 익명 번호 표시
      // 로그인 사용자: 닉네임 선택, 비밀번호 숨김
      if (!hasViewer) {
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
          const nextNumber = typeof state.nextAnonymousNumber === 'number' ? state.nextAnonymousNumber : 1
          if (anonymousNumberEl) {
            anonymousNumberEl.textContent = `익명 ${nextNumber}`
          }
          // 비밀번호 입력칸을 익명 번호와 같은 컨테이너에 있으므로 자동으로 표시됨
          if (passwordInput instanceof HTMLInputElement) {
            passwordInput.required = true
            passwordInput.setAttribute('aria-required', 'true')
            passwordInput.hidden = false
          }
        }
      } else {
        // 로그인 사용자
        if (nicknameWrapper instanceof HTMLElement) {
          nicknameWrapper.hidden = false
        }
        if (nicknameInput instanceof HTMLInputElement) {
          nicknameInput.required = false
          nicknameInput.removeAttribute('aria-required')
          nicknameInput.placeholder = '닉네임 (선택, 익명으로 작성 시)'
          // 로그인 사용자의 ID를 기본값으로 설정
          if (state.viewer?.id && !nicknameInput.value) {
            nicknameInput.value = String(state.viewer.id)
          }
        }
        if (anonymousLabel instanceof HTMLElement) {
          anonymousLabel.hidden = true
        }
        if (passwordInput instanceof HTMLInputElement) {
          passwordInput.required = false
          passwordInput.removeAttribute('aria-required')
          passwordInput.hidden = true
        }
      }

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

    // 익명 번호 및 IP 표시: 익명 댓글은 익명 번호와 마스킹된 IP 표시
    const showIp = comment.isAnonymous && comment.displayIp
      ? `<span class="px-2 py-0.5 text-[11px] text-wiki-muted bg-wiki-border/40 rounded-full">${escapeHtml(comment.displayIp)}</span>`
      : (comment.displayIp && isModeratorRole(state.viewerRole, state))
        ? `<span class="px-2 py-0.5 text-[11px] text-wiki-muted bg-wiki-border/40 rounded-full">IP ${escapeHtml(comment.displayIp)}</span>`
        : ''

    const moderatorInfo = isModeratorRole(state.viewerRole, state)
      ? `<span class="inline-flex items-center gap-1 text-[11px] text-wiki-muted" aria-label="신고 ${comment.reportCount ?? 0}회"><i class="fas fa-flag" aria-hidden="true"></i>${comment.reportCount ?? 0}</span>`
      : ''

    const contentHtml = comment.status === 'visible'
      ? `<div class="text-sm text-wiki-text leading-relaxed">${formatContent(comment.content || '')}</div>`
      : `<div class="text-sm text-wiki-muted leading-relaxed italic">${formatContent(comment.content || '')}</div>`

    const replies =
      Array.isArray(comment.replies) && comment.replies.length
        ? `<ul class="mt-3 space-y-3 border-l border-wiki-border/50 pl-4">${comment.replies
            .map((reply) => renderThread(reply, state, depth + 1))
            .join('')}</ul>`
        : ''

    const likeActive = comment.viewerVote === 1
    const editedAt = comment.editedAt ? formatDate(comment.editedAt) : null
    const displayNickname = comment.nickname || (comment.isAnonymous && comment.anonymousNumber ? `익명 ${comment.anonymousNumber}` : '익명')
    const commentLabelParts = [
      `${displayNickname}님의 댓글`,
      createdAt ? `작성 ${createdAt}` : null,
      editedAt && comment.isEdited ? `수정 ${editedAt}` : null,
      statusLabels.length ? statusLabels.join(', ') : null
    ].filter(Boolean)
    const commentAriaLabel = escapeHtml(commentLabelParts.join(', '))

    return `
      <li data-comment-id="${comment.id}" data-comment-status="${comment.status}" data-comment-best="${comment.isBest ? '1' : '0'}" class="${containerClasses}" aria-label="${commentAriaLabel}">
        <article class="space-y-3">
          <header class="flex flex-wrap items-center justify-between gap-2 text-xs text-wiki-muted">
            <div class="flex flex-wrap items-center gap-2">
              <span class="font-semibold text-wiki-text text-sm">${escapeHtml(displayNickname)}</span>
              ${showIp}
              ${badges.join('')}
              ${srStatusText}
            </div>
            <div class="flex items-center gap-3">
              ${moderatorInfo}
              ${createdAt ? `<time datetime="${escapeHtml(comment.createdAt)}">${escapeHtml(createdAt)}</time>` : ''}
            </div>
          </header>
          ${contentHtml}
          <footer class="flex items-center gap-4 text-xs">
            <button type="button" class="inline-flex items-center gap-1 ${likeActive ? 'text-wiki-primary' : 'text-wiki-muted hover:text-wiki-primary transition'}" data-cw-comment-like data-comment-id="${comment.id}" data-requires-auth="1" aria-pressed="${likeActive ? 'true' : 'false'}" aria-label="공감 ${comment.likes ?? 0}회" title="공감 ${comment.likes ?? 0}회">
              <i class="fas fa-thumbs-up"></i><span data-cw-comment-like-count>${comment.likes ?? 0}</span>
            </button>
            <button type="button" class="inline-flex items-center gap-1 text-wiki-muted hover:text-red-400 transition" data-cw-comment-flag data-comment-id="${comment.id}" data-requires-auth="1">
              <i class="fas fa-flag"></i>신고
            </button>
          </footer>
        </article>
        ${replies}
      </li>
    `
  }

  const renderComments = (section, state) => {
    refreshScoreboardCopy(section, state)
    const { comments, sortedAll, sortedBest, bestThreshold, sortKey } = summarizeCommentCollections(state)

    const listAll = section.querySelector('[data-comment-list="all"]')
    if (listAll) {
      listAll.innerHTML = sortedAll.map((comment) => renderThread(comment, state)).join('')
    }

    const listBest = section.querySelector('[data-comment-list="best"]')
    if (listBest) {
      listBest.innerHTML = sortedBest.map((comment) => renderThread(comment, state)).join('')
    }

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

    const stats = computeCommentStats(comments)
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

  const loadComments = async (section, state) => {
    if (state.loading || !state.entitySlug) {
      return
    }
    state.loading = true
    section.dataset.commentsStatus = 'loading'
    toggleLoading(section, true)
    setStatus(section, '')
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
          console.warn('[comments] abort controller fallback', err)
        }
      }, 10000) : null

      let response
      try {
        response = await fetch(`/api/comments?${params.toString()}`, {
          headers: { Accept: 'application/json' },
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
        console.error('[comments] JSON parse error', err, response.status, response.statusText)
        throw new Error(`Invalid response: ${response.status}`)
      }
      
      if (!response.ok || !payload?.success) {
        const errorMsg = payload?.error || `HTTP ${response.status}`
        console.error('[comments] API error', errorMsg, payload)
        throw new Error(errorMsg)
      }

      state.comments = Array.isArray(payload.data) ? payload.data : []
      state.meta = payload.meta || null
      state.viewer = payload.meta?.viewer ?? null
      state.viewerRole = state.viewer?.role ?? 'user'
      state.nextAnonymousNumber = typeof payload.meta?.nextAnonymousNumber === 'number' ? payload.meta.nextAnonymousNumber : null

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
      renderComments(section, state)
      section.dataset.commentsStatus = 'ready'
      
      // 로딩 상태 명시적으로 해제
      toggleLoading(section, false)
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
      console.error('[comments] loadComments error', error)
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
      toggleLoading(section, false)
      applyAuthState(section, state)
      
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
        return
      }

      const formData = new FormData(form)
      const rawContent = (formData.get('content') || '').toString().trim()
      if (!rawContent) {
        setStatus(section, '댓글 내용을 입력해주세요.', 'error')
        return
      }
      
      // 익명 사용자는 닉네임 입력하지 않음 (익명 번호는 서버에서 자동 배정)
      const isAnonymous = !state.viewer?.id
      const nickname = isAnonymous ? null : ((formData.get('nickname') || '').toString().trim().slice(0, MAX_NICKNAME_LENGTH) || null)
      
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
            password: isAnonymous ? (formData.get('password') || '').toString().trim() || undefined : undefined
          })
        })
        const payload = await response.json().catch(() => ({}))
        if (!response.ok || !payload?.success) {
          throw new Error((payload && payload.error) || `HTTP ${response.status}`)
        }

        form.reset()
        setStatus(section, '댓글이 등록되었습니다.', 'success')
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
        setStatus(section, '댓글 등록에 실패했습니다. 잠시 후 다시 시도해주세요.', 'error')
        DetailTelemetry.emit('comment-submit', {
          component: 'comment-form',
          entityType: state.entityType,
          entityId: state.entityId,
          phase: 'error',
          message: error instanceof Error ? error.message : String(error),
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
  }

  const handleLike = async (section, state, button) => {
    if (button.dataset.commentBusy === '1') {
      return
    }

    const commentId = Number(button.getAttribute('data-comment-id'))
    if (!Number.isFinite(commentId) || commentId <= 0) {
      return
    }

    const policySignature = state.policySignature ?? (state.policy ? computePolicySignature(state.policy) : null)
    if (!state.policySignature && policySignature) {
      state.policySignature = policySignature
    }

    if (state.policy?.requiresAuth && !state.viewer?.id) {
      setStatus(section, '로그인 후 댓글에 공감할 수 있습니다.', 'info')
      DetailTelemetry.emit('comment-like', {
        component: 'comment-engagement',
        entityType: state.entityType,
        entityId: state.entityId,
        commentId,
        phase: 'blocked',
        outcome: 'blocked',
        reason: 'auth-required',
        viewerRole: state.viewerRole,
        policySignature,
        governance: getGovernanceFromState(state)
      })
      return
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
        throw new Error((payload && payload.error) || `HTTP ${response.status}`)
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

      await loadComments(section, state)
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error)
      if (typeof message === 'string' && message.toLowerCase().includes('vote limit')) {
        setStatus(section, '하루 공감 한도를 초과했습니다. 내일 다시 시도해주세요.', 'info')
      } else {
        setStatus(section, '공감 처리에 실패했습니다. 잠시 후 다시 시도해주세요.', 'error')
      }
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
    }
  }

  const handleFlag = async (section, state, button) => {
    if (button.dataset.commentBusy === '1') {
      return
    }

    const commentId = Number(button.getAttribute('data-comment-id'))
    if (!Number.isFinite(commentId) || commentId <= 0) {
      return
    }

    const policySignature = state.policySignature ?? (state.policy ? computePolicySignature(state.policy) : null)
    if (!state.policySignature && policySignature) {
      state.policySignature = policySignature
    }

    if (state.policy?.requiresAuth && !state.viewer?.id) {
      setStatus(section, '로그인 후 신고할 수 있습니다.', 'info')
      DetailTelemetry.emit('comment-flag', {
        component: 'comment-engagement',
        entityType: state.entityType,
        entityId: state.entityId,
        commentId,
        phase: 'blocked',
        outcome: 'blocked',
        reason: 'auth-required',
        viewerRole: state.viewerRole,
        policySignature,
        governance: getGovernanceFromState(state)
      })
      return
    }

    button.dataset.commentBusy = '1'
    DetailTelemetry.emit('comment-flag', {
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
      const response = await fetch(`/api/comments/${commentId}/flag`, {
        method: 'POST'
      })
      const payload = await response.json().catch(() => ({}))
      if (!response.ok || !payload?.success) {
        throw new Error((payload && payload.error) || `HTTP ${response.status}`)
      }

      DetailTelemetry.emit('comment-flag', {
        component: 'comment-engagement',
        entityType: state.entityType,
        entityId: state.entityId,
        commentId,
        phase: 'success',
        outcome: 'success',
        viewerRole: state.viewerRole,
        policySignature,
        governance: getGovernanceFromState(state)
      })

      setStatus(section, '신고 요청이 접수되었습니다.', 'success')
      await loadComments(section, state)
    } catch (error) {
      setStatus(section, '신고 처리에 실패했습니다. 잠시 후 다시 시도해주세요.', 'error')
      DetailTelemetry.emit('comment-flag', {
        component: 'comment-engagement',
        entityType: state.entityType,
        entityId: state.entityId,
        commentId,
        phase: 'error',
        outcome: 'error',
        message: error instanceof Error ? error.message : String(error),
        viewerRole: state.viewerRole,
        policySignature,
        governance: getGovernanceFromState(state)
      })
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
      const flagBtn = target.closest('[data-cw-comment-flag]')
      if (flagBtn instanceof HTMLElement) {
        handleFlag(section, state, flagBtn)
      }
    })
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
      bestThreshold: DEFAULT_POLICY.bestLikeThreshold
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

  return { init }
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

  // 학과 카드 생성
  createMajorCard(major) {
    const normalized = this.normalizeMajorItem(major);
    if (!normalized) return '';

    const { profile, display, url } = normalized;
    const summary = display.summary || '설명 없음';
    // categoryName은 제목 위에 표시하지 않고 메트릭 박스로만 표시
    const categoryName = undefined;
    
    // 첫 직장 만족도 등급 계산 (서버와 동일한 로직)
    const getSatisfactionGrade = (satisfaction) => {
      if (!satisfaction) return null;
      const score = parseFloat(satisfaction) || 0;
      
      if (score >= 80) {
        return { 
          level: '매우 좋음', 
          bg: 'bg-green-500/10', 
          border: 'border-green-500/20', 
          iconColor: 'text-green-400',
          textColor: 'text-green-300',
          textMuted: 'text-green-300/80'
        };
      } else if (score >= 60) {
        return { 
          level: '좋음', 
          bg: 'bg-sky-500/10', 
          border: 'border-sky-500/20', 
          iconColor: 'text-sky-400',
          textColor: 'text-sky-300',
          textMuted: 'text-sky-300/80'
        };
      } else if (score >= 40) {
        return { 
          level: '보통', 
          bg: 'bg-yellow-500/10', 
          border: 'border-yellow-500/20', 
          iconColor: 'text-yellow-400',
          textColor: 'text-yellow-300',
          textMuted: 'text-yellow-300/80'
        };
      } else if (score >= 20) {
        return { 
          level: '별로', 
          bg: 'bg-orange-500/10', 
          border: 'border-orange-500/20', 
          iconColor: 'text-orange-400',
          textColor: 'text-orange-300',
          textMuted: 'text-orange-300/80'
        };
      } else {
        return { 
          level: '매우 별로', 
          bg: 'bg-red-500/10', 
          border: 'border-red-500/20', 
          iconColor: 'text-red-400',
          textColor: 'text-red-300',
          textMuted: 'text-red-300/80'
        };
      }
    };
    
    const satisfactionGrade = getSatisfactionGrade(display.firstJobSatisfaction);
    
    // 메트릭 박스들
    // 커리어넷 데이터: 취업률, 첫직장임금(월), 첫 직장 만족도
    // categoryName: 계열 (모든 경우에 메트릭 박스로 표시)
    const metrics = (() => {
      // categoryName 추출 (쉼표가 2개 이상이면 관련 학과명 리스트로 판단하여 제거)
      const categoryNameForMetric = display.categoryName && display.categoryName.split(',').length <= 2
        ? display.categoryName
        : undefined;
      
      // 커리어넷 데이터 메트릭 박스들
      const careernetMetrics = [
        display.employmentRate ? `
          <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-blue-500/10 backdrop-blur-sm border border-blue-500/20 w-24 h-24 flex-shrink-0">
            <i class="fas fa-user-graduate text-blue-400 text-base"></i>
            <span class="text-[9px] font-medium text-blue-300/70 mt-0.5">취업률</span>
            <span class="text-[11px] font-bold text-blue-300 text-center leading-tight px-1 overflow-hidden text-ellipsis whitespace-nowrap max-w-full">${display.employmentRate}</span>
          </div>
        ` : '',
        display.firstJobSalary ? `
          <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-24 h-24 flex-shrink-0">
            <i class="fas fa-won-sign text-emerald-400 text-base"></i>
            <span class="text-[9px] font-medium text-emerald-300/70 mt-0.5">평균 월봉</span>
            <span class="text-[11px] font-bold text-emerald-300 text-center leading-tight px-1 overflow-hidden text-ellipsis whitespace-nowrap max-w-full">${display.firstJobSalary.includes('만원') ? display.firstJobSalary : `${display.firstJobSalary}만원`}</span>
          </div>
        ` : '',
        display.firstJobSatisfaction && satisfactionGrade ? `
          <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-24 h-24 flex-shrink-0">
            <i class="fas fa-smile ${satisfactionGrade.iconColor} text-base"></i>
            <span class="text-[9px] font-medium ${satisfactionGrade.textMuted} mt-0.5">만족도</span>
            <span class="text-[11px] font-bold ${satisfactionGrade.textColor}">${satisfactionGrade.level}</span>
          </div>
        ` : ''
      ].filter(Boolean);
      
      // categoryName 메트릭 박스 추가
      if (categoryNameForMetric) {
        careernetMetrics.push(`
          <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-indigo-500/10 backdrop-blur-sm border border-indigo-500/20 w-24 h-24 flex-shrink-0">
            <i class="fas fa-layer-group text-indigo-400 text-base"></i>
            <span class="text-[9px] font-medium text-indigo-300/70 mt-0.5">계열</span>
            <span class="text-[11px] font-bold text-indigo-300 text-center leading-tight px-1 overflow-hidden text-ellipsis whitespace-nowrap max-w-full">${(categoryNameForMetric.length > 8 ? categoryNameForMetric.substring(0, 8) + '...' : categoryNameForMetric)}</span>
          </div>
        `);
      }
      
      return careernetMetrics.join('');
    })();

    return `
      <article class="group relative">
        <a href="${url}" class="block">
          <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
            <!-- 배경 그라데이션 글로우 -->
            <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500">
              <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
              <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
            </div>
            
            <div class="relative flex gap-4">
              <!-- 왼쪽: 전공 정보 (최대 너비 60% 제한) -->
              <div class="flex-1 space-y-4 min-w-0 max-w-[60%]">
                <!-- 헤더: 카테고리 + 전공명 -->
                <div class="space-y-2">
                  ${categoryName ? `
                    <div class="flex items-center gap-2">
                      <span class="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-md text-[10px] font-semibold uppercase tracking-wider bg-wiki-secondary/10 text-wiki-secondary/80 border border-wiki-secondary/20">
                        <i class="fas fa-folder text-[8px]"></i>
                        ${categoryName}
                      </span>
                    </div>
                  ` : ''}
                  
                  <h2 class="text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">
                    ${profile.name || '학과명 없음'}
                  </h2>
                </div>
                
                <!-- 설명 -->
                <p class="text-sm leading-relaxed text-wiki-muted/90 line-clamp-2">
                  ${summary}
                </p>
              </div>
              
              <!-- 오른쪽: 메트릭 박스들 (정사각형, 고정 크기, 오른쪽 끝 정렬) -->
              ${metrics ? `
                <div class="flex gap-2 items-center justify-end flex-shrink-0 ml-auto">
                  ${metrics}
                </div>
              ` : ''}
            </div>
          </div>
        </a>
      </article>
    `;
  },

  // 직업 카드 생성
  createJobCard(job) {
    const normalized = this.normalizeJobItem(job);
    if (!normalized) return '';

    const { profile, display, url } = normalized;
    const summary = display.summary || '설명 없음';
    
    // 직업 만족도 등급 계산 (서버와 동일한 로직)
    const getSatisfactionGrade = (satisfaction) => {
      if (!satisfaction) return null;
      const score = parseFloat(satisfaction) || 0;
      
      if (score >= 80) {
        return { 
          level: '매우 좋음', 
          bg: 'bg-green-500/10', 
          border: 'border-green-500/20', 
          iconColor: 'text-green-400',
          textColor: 'text-green-300',
          textMuted: 'text-green-300/80',
          percentColor: 'text-green-300/60'
        };
      } else if (score >= 60) {
        return { 
          level: '좋음', 
          bg: 'bg-sky-500/10', 
          border: 'border-sky-500/20', 
          iconColor: 'text-sky-400',
          textColor: 'text-sky-300',
          textMuted: 'text-sky-300/80',
          percentColor: 'text-sky-300/60'
        };
      } else if (score >= 40) {
        return { 
          level: '보통', 
          bg: 'bg-yellow-500/10', 
          border: 'border-yellow-500/20', 
          iconColor: 'text-yellow-400',
          textColor: 'text-yellow-300',
          textMuted: 'text-yellow-300/80',
          percentColor: 'text-yellow-300/60'
        };
      } else if (score >= 20) {
        return { 
          level: '별로', 
          bg: 'bg-orange-500/10', 
          border: 'border-orange-500/20', 
          iconColor: 'text-orange-400',
          textColor: 'text-orange-300',
          textMuted: 'text-orange-300/80',
          percentColor: 'text-orange-300/60'
        };
      } else {
        return { 
          level: '매우 별로', 
          bg: 'bg-red-500/10', 
          border: 'border-red-500/20', 
          iconColor: 'text-red-400',
          textColor: 'text-red-300',
          textMuted: 'text-red-300/80',
          percentColor: 'text-red-300/60'
        };
      }
    };
    
    const satisfactionGrade = getSatisfactionGrade(display.satisfaction);
    
    // 메트릭 박스들 (연봉, 만족도, 워라벨, 계열) - 정사각형
    const metrics = [
      display.salary ? `
        <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-24 h-24 flex-shrink-0">
          <i class="fas fa-won-sign text-emerald-400 text-base"></i>
          <span class="text-[9px] font-medium text-emerald-300/70 mt-0.5">평균 연봉</span>
          <span class="text-[11px] font-bold text-emerald-300 text-center leading-tight px-1 overflow-hidden text-ellipsis whitespace-nowrap max-w-full">${(display.salary || '').replace(/평균\s*/g, '')}</span>
        </div>
      ` : '',
      display.satisfaction && satisfactionGrade ? `
        <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-24 h-24 flex-shrink-0">
          <i class="fas fa-smile ${satisfactionGrade.iconColor} text-base"></i>
          <span class="text-[9px] font-medium ${satisfactionGrade.textMuted} mt-0.5">만족도</span>
          <span class="text-[11px] font-bold ${satisfactionGrade.textColor}">${satisfactionGrade.level}</span>
        </div>
      ` : '',
      display.wlb ? `
        <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-purple-500/10 backdrop-blur-sm border border-purple-500/20 w-24 h-24 flex-shrink-0">
          <i class="fas fa-balance-scale text-purple-400 text-base"></i>
          <span class="text-[9px] font-medium text-purple-300/70 mt-0.5">워라벨</span>
          <span class="text-[11px] font-bold text-purple-300 text-center leading-tight">${display.wlb}</span>
        </div>
      ` : '',
      display.departmentName ? `
        <div class="flex flex-col items-center justify-center gap-0.5 p-2 rounded-lg bg-indigo-500/10 backdrop-blur-sm border border-indigo-500/20 w-24 h-24 flex-shrink-0">
          <i class="fas fa-layer-group text-indigo-400 text-base"></i>
          <span class="text-[9px] font-medium text-indigo-300/70 mt-0.5">계열</span>
          <span class="text-[11px] font-bold text-indigo-300 text-center leading-tight px-1 overflow-hidden text-ellipsis whitespace-nowrap max-w-full">${(display.departmentName.length > 8 ? display.departmentName.substring(0, 8) + '...' : display.departmentName)}</span>
        </div>
      ` : ''
    ].filter(Boolean).join('');

    return `
      <article class="group relative">
        <a href="${url}" class="block">
          <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
            <!-- 배경 그라데이션 글로우 -->
            <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500">
              <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
              <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
            </div>
            
            <div class="relative flex gap-4">
              <!-- 왼쪽: 직업 정보 (최대 너비 60% 제한) -->
              <div class="flex-1 space-y-4 min-w-0 max-w-[60%]">
                <!-- 헤더: 카테고리 + 직업명 -->
                <div class="space-y-2">
                  ${display.categoryName ? `
                    <div class="flex items-center gap-2">
                      <span class="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-md text-[10px] font-semibold uppercase tracking-wider bg-wiki-secondary/10 text-wiki-secondary/80 border border-wiki-secondary/20">
                        <i class="fas fa-folder text-[8px]"></i>
                        ${display.categoryName}
                      </span>
                    </div>
                  ` : ''}
                  
                  <h2 class="text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">
                    ${profile.name || '직업명 없음'}
                  </h2>
                </div>
                
                <!-- 설명 -->
                <p class="text-sm leading-relaxed text-wiki-muted/90 line-clamp-2">
                  ${summary}
                </p>
              </div>
              
              <!-- 오른쪽: 메트릭 박스들 (정사각형, 고정 크기, 오른쪽 끝 정렬) -->
              ${metrics ? `
                <div class="flex gap-2 items-center justify-end flex-shrink-0 ml-auto">
                  ${metrics}
                </div>
              ` : ''}
            </div>
          </div>
        </a>
      </article>
    `;
  }
};

// 페이지별 초기화 함수
const PageInit = {
  // 홈페이지 초기화
  async initHome() {
    // 인기 직업/전공 섹션 제거됨 (향후 리뉴얼 예정)
    // console.log('Home page initialized');
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
      trigger.classList.toggle('bg-wiki-primary', isActive)
      trigger.classList.toggle('text-white', isActive)
      trigger.classList.toggle('text-wiki-muted', !isActive)
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
          other.classList.toggle('bg-wiki-primary', isActive)
          other.classList.toggle('text-white', isActive)
          other.classList.toggle('border', !isActive)
          other.classList.toggle('border-wiki-border', !isActive)
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
        console.warn('[demo-comments] failed to parse sample comments', error)
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
    document.querySelectorAll('[data-share-root]').forEach((root) => {
      if (!(root instanceof HTMLElement)) {
        return
      }
      const trigger = root.querySelector('[data-share-trigger]')
      const panel = root.querySelector('[data-share-panel]')
      const closeBtn = root.querySelector('[data-share-close]')
      const copyBtn = root.querySelector('[data-share-copy]')
      const urlInput = root.querySelector('[data-share-url]')
      if (!trigger || !panel || !urlInput) {
        return
      }

      const resolveUrl = () => {
        const path = trigger.getAttribute('data-share-path') || urlInput.value || window.location.pathname
        try {
          const absolute = new URL(path, window.location.origin)
          urlInput.value = absolute.toString()
          return absolute.toString()
        } catch (_) {
          urlInput.value = path
          return path
        }
      }

      const hidePanel = () => {
        panel.classList.add('hidden')
        trigger.setAttribute('aria-expanded', 'false')
      }

      const showPanel = () => {
        resolveUrl()
        panel.classList.remove('hidden')
        trigger.setAttribute('aria-expanded', 'true')
      }

      trigger.addEventListener('click', (event) => {
        event.preventDefault()
        const isHidden = panel.classList.contains('hidden')
        if (isHidden) {
          showPanel()
        } else {
          hidePanel()
        }
      })

      if (closeBtn) {
        closeBtn.addEventListener('click', (event) => {
          event.preventDefault()
          hidePanel()
        })
      }

      let originalCopyHtml = ''
      if (copyBtn) {
        originalCopyHtml = copyBtn.innerHTML
        copyBtn.addEventListener('click', async (event) => {
          event.preventDefault()
          const url = resolveUrl()
          try {
            await navigator.clipboard.writeText(url)
            copyBtn.classList.remove('bg-rose-600')
            copyBtn.classList.add('bg-green-600')
            copyBtn.innerHTML = '<i class="fas fa-check mr-1" aria-hidden="true"></i>복사됨'
            setTimeout(() => {
              copyBtn.classList.remove('bg-green-600')
              copyBtn.innerHTML = originalCopyHtml
            }, 1600)
          } catch (error) {
            console.warn('[share] clipboard write failed', error)
            urlInput.select()
            copyBtn.classList.remove('bg-green-600')
            copyBtn.classList.add('bg-rose-600')
            copyBtn.innerHTML = '<i class="fas fa-exclamation mr-1" aria-hidden="true"></i>복사 실패'
            setTimeout(() => {
              copyBtn.classList.remove('bg-rose-600')
              copyBtn.innerHTML = originalCopyHtml
            }, 1600)
          }
        })
      }

      document.addEventListener('click', (event) => {
        if (!root.contains(event.target) && !panel.classList.contains('hidden')) {
          hidePanel()
        }
      })

      document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape' && !panel.classList.contains('hidden')) {
          hidePanel()
        }
      })
    })
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
  }

  if (/^\/major\//.test(normalizedPath)) {
    DetailPage.init('major');
  }

  if (/^\/howto\//.test(normalizedPath)) {
    DetailPage.init('guide');
  }

  if (normalizedPath === '/search') {
    PageInit.initSearchResults();
  }
});