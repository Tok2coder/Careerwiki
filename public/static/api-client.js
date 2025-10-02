/**
 * CareerWiki API Client
 * 프론트엔드에서 API 호출을 위한 클라이언트
 */

// API Base URL (현재 도메인 사용)
const API_BASE = window.location.origin + '/api';

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

// DOM 조작 유틸리티
const DOMUtils = {
  buildMajorUrl(entry) {
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

    const id = profile.id || sourceIds.careernet;
    if (!id) return '#';

    const query = params.toString();
    return `/major/${encodeURIComponent(id)}${query ? `?${query}` : ''}`;
  },

  buildJobUrl(entry) {
    if (!entry) return '#';
    const profile = entry.profile || entry;
    const sourceMeta = entry.sourceMeta || {};
    const sourceIds = profile.sourceIds || {};
    const params = new URLSearchParams();

    if (sourceIds.careernet) {
      params.set('careernetId', sourceIds.careernet);
    }

    if (sourceMeta.goyong24?.jobCd) {
      params.set('goyongJobId', sourceMeta.goyong24.jobCd);
    }

    const id = profile.id || sourceIds.careernet;
    if (!id) return '#';

    const query = params.toString();
    return `/job/${encodeURIComponent(id)}${query ? `?${query}` : ''}`;
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

    return `
      <a href="${url}" class="glass-card p-6 rounded-lg hover-glow block">
        <h3 class="text-xl font-bold mb-2 text-white">${profile.name || '학과명 없음'}</h3>
        <p class="text-wiki-muted text-sm mb-4 line-clamp-2">${summary}</p>
        <div class="flex flex-wrap gap-2 text-xs">
          ${display.employmentRate ? `<span class="px-2 py-1 bg-wiki-primary/20 text-wiki-primary rounded">취업률 ${display.employmentRate}</span>` : ''}
          ${display.salaryAfterGraduation ? `<span class="px-2 py-1 bg-green-500/20 text-green-400 rounded">${display.salaryAfterGraduation}</span>` : ''}
          ${display.categoryName ? `<span class="px-2 py-1 bg-wiki-secondary/20 text-wiki-secondary rounded">${display.categoryName}</span>` : ''}
        </div>
      </a>
    `;
  },

  // 직업 카드 생성
  createJobCard(job) {
    const normalized = this.normalizeJobItem(job);
    if (!normalized) return '';

    const { profile, display, url } = normalized;
    const summary = display.summary || '설명 없음';

    return `
      <a href="${url}" class="glass-card p-6 rounded-lg hover-glow block">
        <h3 class="text-xl font-bold mb-2 text-white">${profile.name || '직업명 없음'}</h3>
        <p class="text-wiki-muted text-sm mb-4 line-clamp-2">${summary}</p>
        <div class="flex flex-wrap gap-2 text-xs">
          ${display.salary ? `<span class="px-2 py-1 bg-green-500/20 text-green-400 rounded">${display.salary}</span>` : ''}
          ${display.outlook ? `<span class="px-2 py-1 bg-wiki-primary/20 text-wiki-primary rounded">전망: ${display.outlook}</span>` : ''}
          ${display.categoryName ? `<span class="px-2 py-1 bg-wiki-secondary/20 text-wiki-secondary rounded">${display.categoryName}</span>` : ''}
        </div>
      </a>
    `;
  }
};

// 페이지별 초기화 함수
const PageInit = {
  // 홈페이지 초기화
  async initHome() {
    // 인기 직업 로드
    const jobsContainer = document.getElementById('popular-jobs');
    if (jobsContainer) {
      DOMUtils.showLoading('popular-jobs');
      const jobResult = await CareerAPI.searchJobs('', '', 1, 6);
      const jobs = Array.isArray(jobResult.items) ? jobResult.items.slice(0, 6) : [];
      
      if (jobs.length > 0) {
        jobsContainer.innerHTML = `
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            ${jobs.map(job => DOMUtils.createJobCard(job)).join('')}
          </div>
        `;
      } else {
        jobsContainer.innerHTML = '<p class="text-wiki-muted">인기 직업 정보를 불러올 수 없습니다.</p>';
      }
    }

    // 인기 학과 로드
    const majorsContainer = document.getElementById('popular-majors');
    if (majorsContainer) {
      DOMUtils.showLoading('popular-majors');
      const majorResult = await CareerAPI.searchMajors('', 1, 6);
      const majors = Array.isArray(majorResult.items) ? majorResult.items.slice(0, 6) : [];
      
      if (majors.length > 0) {
        majorsContainer.innerHTML = `
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            ${majors.map(major => DOMUtils.createMajorCard(major)).join('')}
          </div>
        `;
      } else {
        majorsContainer.innerHTML = '<p class="text-wiki-muted">인기 학과 정보를 불러올 수 없습니다.</p>';
      }
    }
  },

  // 직업 페이지 초기화
  async initJobPage() {
    const container = document.getElementById('job-list');
    if (!container) return;

    DOMUtils.showLoading('job-list');
    
    // URL에서 검색어 추출
    const urlParams = new URLSearchParams(window.location.search);
    const keyword = urlParams.get('q') || '';
    const category = urlParams.get('category') || '';
    const page = parseInt(urlParams.get('page') || '1');
    
    const jobResult = await CareerAPI.searchJobs(keyword, category, page, 20);
    const jobs = Array.isArray(jobResult.items) ? jobResult.items : [];
    
    if (jobs.length > 0) {
      container.innerHTML = `
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          ${jobs.map(job => DOMUtils.createJobCard(job)).join('')}
        </div>
      `;
    } else {
      const message = jobResult.meta?.error || '검색 결과가 없습니다.';
      DOMUtils.showError('job-list', message);
    }
  },

  // 학과 페이지 초기화
  async initMajorPage() {
    const container = document.getElementById('major-list');
    if (!container) return;

    DOMUtils.showLoading('major-list');
    
    // URL에서 검색어 추출
    const urlParams = new URLSearchParams(window.location.search);
    const keyword = urlParams.get('q') || '';
    const page = parseInt(urlParams.get('page') || '1');
    
    const majorResult = await CareerAPI.searchMajors(keyword, page, 20);
    const majors = Array.isArray(majorResult.items) ? majorResult.items : [];
    
    if (majors.length > 0) {
      container.innerHTML = `
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          ${majors.map(major => DOMUtils.createMajorCard(major)).join('')}
        </div>
      `;
    } else {
      const message = majorResult.meta?.error || '검색 결과가 없습니다.';
      DOMUtils.showError('major-list', message);
    }
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

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', () => {
  const path = window.location.pathname;
  
  if (path === '/') {
    PageInit.initHome();
  } else if (path === '/job' || path.startsWith('/job/')) {
    PageInit.initJobPage();
  } else if (path === '/major' || path.startsWith('/major/')) {
    PageInit.initMajorPage();
  } else if (path === '/search') {
    PageInit.initSearchResults();
  }
});