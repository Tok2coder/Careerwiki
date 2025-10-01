/**
 * CareerWiki API Client
 * 프론트엔드에서 API 호출을 위한 클라이언트
 */

// API Base URL (현재 도메인 사용)
const API_BASE = window.location.origin + '/api';

// API 호출 함수들
const CareerAPI = {
  // 학과 검색
  async searchMajors(keyword = '', page = 1, perPage = 20) {
    try {
      const params = new URLSearchParams({
        keyword,
        page: page.toString(),
        perPage: perPage.toString()
      });
      
      const response = await fetch(`${API_BASE}/majors?${params}`);
      const data = await response.json();
      
      if (!data.success) {
        throw new Error(data.error || '학과 검색 실패');
      }
      
      return data.data || [];
    } catch (error) {
      console.error('학과 검색 오류:', error);
      return [];
    }
  },

  // 학과 상세 정보
  async getMajorDetail(majorSeq) {
    try {
      const response = await fetch(`${API_BASE}/majors/${majorSeq}`);
      const data = await response.json();
      
      if (!data.success) {
        throw new Error(data.error || '학과 정보 조회 실패');
      }
      
      return data.data;
    } catch (error) {
      console.error('학과 정보 조회 오류:', error);
      return null;
    }
  },

  // 직업 검색
  async searchJobs(keyword = '', category = '', page = 1, perPage = 20) {
    try {
      const params = new URLSearchParams({
        keyword,
        category,
        page: page.toString(),
        perPage: perPage.toString()
      });
      
      const response = await fetch(`${API_BASE}/jobs?${params}`);
      const data = await response.json();
      
      if (!data.success) {
        throw new Error(data.error || '직업 검색 실패');
      }
      
      return data.data || [];
    } catch (error) {
      console.error('직업 검색 오류:', error);
      return [];
    }
  },

  // 직업 상세 정보
  async getJobDetail(jobdicSeq) {
    try {
      const response = await fetch(`${API_BASE}/jobs/${jobdicSeq}`);
      const data = await response.json();
      
      if (!data.success) {
        throw new Error(data.error || '직업 정보 조회 실패');
      }
      
      return data.data;
    } catch (error) {
      console.error('직업 정보 조회 오류:', error);
      return null;
    }
  },

  // 카테고리 정보
  async getCategories() {
    try {
      const response = await fetch(`${API_BASE}/categories`);
      const data = await response.json();
      
      if (!data.success) {
        throw new Error('카테고리 정보 조회 실패');
      }
      
      return data;
    } catch (error) {
      console.error('카테고리 조회 오류:', error);
      return { jobCategories: {}, aptitudeTypes: {} };
    }
  }
};

// DOM 조작 유틸리티
const DOMUtils = {
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
    return `
      <a href="/major/${major.majorSeq}" class="glass-card p-6 rounded-lg hover-glow block">
        <h3 class="text-xl font-bold mb-2 text-white">${major.major || '학과명 없음'}</h3>
        <p class="text-wiki-muted text-sm mb-4 line-clamp-2">${major.summary || '설명 없음'}</p>
        <div class="flex flex-wrap gap-2 text-xs">
          ${major.employmentRate ? `<span class="px-2 py-1 bg-wiki-primary/20 text-wiki-primary rounded">취업률 ${major.employmentRate}</span>` : ''}
          ${major.department ? `<span class="px-2 py-1 bg-wiki-secondary/20 text-wiki-secondary rounded">${major.department}</span>` : ''}
        </div>
      </a>
    `;
  },

  // 직업 카드 생성
  createJobCard(job) {
    return `
      <a href="/job/${job.jobdicSeq}" class="glass-card p-6 rounded-lg hover-glow block">
        <h3 class="text-xl font-bold mb-2 text-white">${job.jobName || '직업명 없음'}</h3>
        <p class="text-wiki-muted text-sm mb-4 line-clamp-2">${job.summary || '설명 없음'}</p>
        <div class="flex flex-wrap gap-2 text-xs">
          ${job.avgSalary ? `<span class="px-2 py-1 bg-green-500/20 text-green-400 rounded">${job.avgSalary}</span>` : ''}
          ${job.jobOutlook ? `<span class="px-2 py-1 bg-wiki-primary/20 text-wiki-primary rounded">전망: ${job.jobOutlook}</span>` : ''}
          ${job.jobCategoryName ? `<span class="px-2 py-1 bg-wiki-secondary/20 text-wiki-secondary rounded">${job.jobCategoryName}</span>` : ''}
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
      const jobs = await CareerAPI.searchJobs('', '', 1, 6);
      
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
      const majors = await CareerAPI.searchMajors('', 1, 6);
      
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
    
    const jobs = await CareerAPI.searchJobs(keyword, category, page, 20);
    
    if (jobs.length > 0) {
      container.innerHTML = `
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          ${jobs.map(job => DOMUtils.createJobCard(job)).join('')}
        </div>
      `;
    } else {
      DOMUtils.showError('job-list', '검색 결과가 없습니다.');
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
    
    const majors = await CareerAPI.searchMajors(keyword, page, 20);
    
    if (majors.length > 0) {
      container.innerHTML = `
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          ${majors.map(major => DOMUtils.createMajorCard(major)).join('')}
        </div>
      `;
    } else {
      DOMUtils.showError('major-list', '검색 결과가 없습니다.');
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
      const jobs = await CareerAPI.searchJobs(keyword, '', 1, 5);
      
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
      const majors = await CareerAPI.searchMajors(keyword, 1, 5);
      
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