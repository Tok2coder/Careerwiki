import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { ragSearchJobs } from '../services/rag-search'
import { searchUnifiedJobs } from '../services/profileDataService'
import { renderJobCard } from '../utils/card-renderers'
import { composeDetailSlug } from '../utils/slug'
import {
  parseSourcesQuery, parseNumberParam, buildCanonicalUrl,
  createMetaDescription, escapeHtml, renderLayoutWithContext,
  serializeForScript, getOptionalUser
} from '../utils/shared-helpers'
import { logSearchQuery } from '../services/searchQueryLogger'

const jobListRoutes = new Hono<AppEnv>()

jobListRoutes.get('/job', async (c) => {
  const keywordRaw = c.req.query('q') || ''
  const keyword = keywordRaw.trim()
  const includeSources = parseSourcesQuery(c.req.query('sources'))
  const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
  const perPage = 20 // 성능 최적화: 50 → 20 (이미지 로딩 시간 단축)

  // 모바일 감지
  const userAgent = c.req.header('user-agent') || ''
  const isMobile = /Mobile|Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent)
  const sort = c.req.query('sort') || 'relevance' // 정렬 옵션

  const searchParams = new URLSearchParams()
  if (keyword) searchParams.set('q', keyword)
  if (includeSources?.length) searchParams.set('sources', includeSources.join(','))
  if (page > 1) searchParams.set('page', String(page))
  if (sort && sort !== 'relevance') searchParams.set('sort', sort)

  const canonicalPath = `/job${searchParams.toString() ? `?${searchParams.toString()}` : ''}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)

  const formatSummaryText = (value?: string | null): string => {
    const fallback = '고용24와 커리어넷 데이터를 통합하여 제공하는 직업 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
    if (!value) return fallback
    const normalized = value.replace(/\s+/g, ' ').trim()
    if (!normalized) return fallback
    return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
  }

  // 로그인 상태 확인
  const user = getOptionalUser(c)
  const isLoggedIn = !!user

  try {
    // RAG 검색 (키워드 + 기본 정렬) 또는 D1 직접 검색
    const result = keyword && sort === 'relevance'
      ? await ragSearchJobs(c.env, keyword, { page, perPage })
      : await searchUnifiedJobs(
          { keyword, page, perPage, includeSources, sort },
          c.env
        )

    const items = result.items
    const totalCount = typeof result.meta?.total === 'number' ? result.meta.total : items.length

    // 검색어 로깅 (비동기)
    if (keyword && c.executionCtx && 'waitUntil' in c.executionCtx) {
      c.executionCtx.waitUntil(
        logSearchQuery(c.env.DB, {
          query: keyword,
          resultCount: totalCount,
          searchType: 'job',
          role: (c.get('user') as { role?: string } | undefined)?.role,
        })
      )
    }

    try {
    } catch (_) {}

    // 공통 함수 renderJobCard 사용
    const jobCards = items.length
      ? items.map((entry) => renderJobCard(entry)).join('')
      : keyword
        ? `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
            <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">"${escapeHtml(keyword)}"에 해당하는 직업이 없습니다.</p>
            <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도해보세요.</p>
          </div>`
        : `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
            <i class="fas fa-briefcase text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">등록된 직업이 없습니다.</p>
          </div>`

    // 🆕 캐시 알림 제거 (사용자에게 보이지 않도록)
    const cacheNotice = '' // renderCacheNotice(cacheState, { staleSeconds: LIST_CACHE_STALE_SECONDS, maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS })

    // 🆕 데이터 소스 요약 제거 (사용자에게 혼란을 줄 수 있음)
    const sourceSummaryHtml = '' // renderSourceStatusSummary(result.meta?.sources, { id: 'job-source-summary' })
    const filterSummary = keyword ? `"${escapeHtml(keyword)}" 키워드` : '전체 직업'
    const headingLabel = keyword ? `"${escapeHtml(keyword)}" 관련 직업` : '직업위키'

    const jsonLdItems = items.map((entry, index) => {
      const slug = composeDetailSlug('job', entry.profile.name, entry.profile.id)
      return {
        '@type': 'ListItem',
        position: (page - 1) * perPage + index + 1,
        url: buildCanonicalUrl(c.req.url, `/job/${encodeURIComponent(slug)}`),
        name: entry.profile.name
      }
    })
    const jsonLd = jsonLdItems.length
      ? `<script type="application/ld+json">${JSON.stringify({
          '@context': 'https://schema.org',
          '@type': 'ItemList',
          name: keyword ? `${keyword} 관련 직업 목록` : 'Careerwiki 직업 목록',
          numberOfItems: jsonLdItems.length,
          itemListOrder: 'https://schema.org/ItemListOrderAscending',
          itemListElement: jsonLdItems
        }).replace(/</g, '\\u003C')}</script>`
      : ''

    // 모바일 메트릭 스크롤 스타일 (스크롤바 숨기기)
    const mobileScrollStyle = `<style>.mobile-metric-scroll::-webkit-scrollbar{display:none;}</style>`
    const extraHead = [jsonLd, mobileScrollStyle].filter(Boolean).join('\n')

    const content = `
      <div class="max-w-[1400px] mx-auto px-4 md:px-6">
        <!-- 히어로 섹션 with 그라데이션 블렌딩 -->
        <div class="relative text-center pt-2 pb-12 mb-6 space-y-7">
          <!-- 배경 글로우 + 하단 페이드 -->
          <div class="absolute inset-0 -z-10 overflow-hidden">
            <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[800px] h-[400px] bg-gradient-to-b from-wiki-primary/8 via-wiki-primary/5 to-transparent rounded-full blur-[120px]"></div>
          </div>
          <!-- 하단 그라데이션 페이드 -->
          <div class="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-wiki-bg to-transparent -z-10"></div>

          <h1 class="text-[42px] md:text-[48px] lg:text-6xl font-extrabold leading-tight mb-2">
            <span class="bg-gradient-to-r from-wiki-primary via-blue-400 to-wiki-secondary bg-clip-text text-transparent drop-shadow-[0_2px_8px_rgba(59,130,246,0.3)]">
            ${headingLabel}
            </span>
          </h1>

          <p class="text-lg md:text-xl text-wiki-text/90 max-w-2xl mx-auto font-medium leading-relaxed">
            당신의 다음 커리어를 여기서 확인하세요
          </p>

          <div class="flex items-center justify-center gap-3 text-sm">
            <span class="px-3 py-1.5 rounded-lg bg-wiki-bg/60 text-wiki-muted">${filterSummary}</span>
            <span class="px-3 py-1.5 rounded-lg bg-gradient-to-r from-wiki-primary/20 to-blue-500/20 border border-wiki-primary/30 text-white font-semibold">
              <span id="job-total-count">${totalCount}</span>개
            </span>
          </div>
        </div>

        <form id="job-filter-form" data-hydration-target="job" method="get" class="mb-6">
          <div class="flex flex-row gap-2 sm:gap-3">
            <!-- 검색창 - 글래스모피즘 + 인셋 아이콘 -->
            <div class="flex-1 relative group min-w-0">
              <div class="absolute inset-0 bg-gradient-to-r from-wiki-primary/20 via-wiki-secondary/20 to-wiki-primary/20 rounded-2xl blur-xl opacity-0 group-focus-within:opacity-100 transition-opacity duration-500"></div>
              <div class="relative flex items-center bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl overflow-hidden transition-all duration-300 group-focus-within:border-wiki-primary/50 group-focus-within:shadow-lg group-focus-within:shadow-wiki-primary/10">
                <span class="pl-3 sm:pl-4 pr-1 sm:pr-2 text-wiki-muted/60 group-focus-within:text-wiki-primary transition-colors duration-300">
                  <i class="fas fa-search text-sm"></i>
                </span>
                <input
                  id="job-keyword"
                  type="text"
                  name="q"
                  value="${escapeHtml(keyword)}"
                  placeholder="직업 검색..."
                  class="flex-1 px-1 sm:px-2 py-2 sm:py-3.5 bg-transparent border-none focus:outline-none text-base text-white placeholder:text-wiki-muted/50 min-w-0"
                  style="font-size: 16px;"
                />
                <button type="submit" class="m-1 sm:m-1.5 px-3 sm:px-5 py-2 sm:py-2.5 min-h-[40px] sm:min-h-[44px] bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-primary/25 active:scale-95 transition-all duration-200">
                  <i class="fas fa-search sm:hidden"></i>
                  <span class="hidden sm:inline">검색</span>
                </button>
              </div>
            </div>
            <!-- 정렬 + 새 직업 추가 버튼 -->
            <div class="flex items-center gap-2 shrink-0" id="job-hydration-toolbar">
              <div class="relative" data-dropdown="job-sort">
                <button type="button" id="job-sort-trigger" class="flex items-center justify-center gap-2 px-3 sm:pl-4 sm:pr-3 py-2 sm:py-3 bg-white/[0.03] border border-white/[0.06] rounded-xl text-sm text-white/70 hover:bg-white/[0.06] hover:border-white/[0.1] focus:outline-none focus:border-wiki-primary/40 transition-all duration-200 cursor-pointer min-w-[44px] sm:min-w-[130px] min-h-[44px]">
                  <i class="fas fa-sliders-h sm:hidden"></i>
                  <span id="job-sort-label" class="hidden sm:inline">${sort === 'salary-desc' ? '연봉 높은 순' : sort === 'name-asc' ? '가나다 순' : '기본 순'}</span>
                  <i class="fas fa-chevron-down text-[10px] text-white/40 ml-auto transition-transform duration-200 hidden sm:inline" id="job-sort-chevron"></i>
                </button>
                <div id="job-sort-menu" class="absolute right-0 top-full mt-2 w-44 py-1.5 bg-[#1c2333]/95 backdrop-blur-xl border border-white/[0.08] rounded-xl shadow-2xl shadow-black/40 opacity-0 invisible translate-y-1 transition-all duration-200 z-50">
                  <div class="px-2 py-1.5 text-[10px] font-medium text-white/30 uppercase tracking-wider">정렬 기준</div>
                  <button type="button" data-sort="relevance" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'relevance' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>기본 순</span>
                  </button>
                  <button type="button" data-sort="salary-desc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'salary-desc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>연봉 높은 순</span>
                  </button>
                  <button type="button" data-sort="name-asc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'name-asc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>가나다 순</span>
                  </button>
                </div>
                <select id="job-sort-select" class="sr-only">
                  <option value="relevance">기본 순</option>
                  <option value="salary-desc">연봉 높은 순</option>
                  <option value="name-asc">가나다 순</option>
                </select>
              </div>
              ${isLoggedIn ? `
              <!-- 새 직업 추가 버튼 (로그인 시에만 표시) -->
              <button
                type="button"
                id="create-job-btn"
                data-create-entity="job"
                class="flex items-center gap-1.5 px-4 py-3 bg-gradient-to-r from-wiki-primary to-blue-500 text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-primary/25 active:scale-95 transition-all duration-200 whitespace-nowrap"
              >
                <i class="fas fa-plus text-xs"></i>
                추가
              </button>
              ` : ''}
            </div>
          </div>
        </form>

        ${cacheNotice}

        <section id="job-results" class="space-y-4" aria-live="polite">
          ${jobCards}
        </section>

        ${(() => {
          const totalPages = Math.ceil(totalCount / perPage)
          if (totalPages <= 1) return ''

          const buildPageUrl = (pageNum: number) => {
            const params = new URLSearchParams()
            if (keyword) params.set('q', keyword)
            if (includeSources?.length) params.set('sources', includeSources.join(','))
            if (pageNum > 1) params.set('page', String(pageNum))
            return `/job${params.toString() ? `?${params.toString()}` : ''}`
          }

          // 화면 크기에 따라 버튼 수 조정 (모바일: 3개, 데스크톱: 7개)
          const maxPageButtons = isMobile ? 3 : 7
          let startPage = Math.max(1, page - Math.floor(maxPageButtons / 2))
          let endPage = Math.min(totalPages, startPage + maxPageButtons - 1)

          if (endPage - startPage < maxPageButtons - 1) {
            startPage = Math.max(1, endPage - maxPageButtons + 1)
          }

          const pageButtons = []

          // 이전 페이지 버튼
          if (page > 1) {
            pageButtons.push(`
              <a href="${buildPageUrl(page - 1)}"
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                <i class="fas fa-chevron-left"></i>
              </a>
            `)
          }

          // 첫 페이지
          if (startPage > 1) {
            pageButtons.push(`
              <a href="${buildPageUrl(1)}"
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                1
              </a>
            `)
            if (startPage > 2) {
              pageButtons.push(`<span class="px-1 text-wiki-muted">...</span>`)
            }
          }

          // 페이지 번호들
          for (let i = startPage; i <= endPage; i++) {
            const isActive = i === page
            pageButtons.push(`
              <a href="${buildPageUrl(i)}"
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center rounded-lg transition ${
                   isActive
                     ? 'bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold'
                     : 'bg-wiki-bg border border-wiki-border hover:border-wiki-primary'
                 }">
                ${i}
              </a>
            `)
          }

          // 마지막 페이지
          if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
              pageButtons.push(`<span class="px-1 text-wiki-muted">...</span>`)
            }
            pageButtons.push(`
              <a href="${buildPageUrl(totalPages)}"
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                ${totalPages}
              </a>
            `)
          }

          // 다음 페이지 버튼
          if (page < totalPages) {
            pageButtons.push(`
              <a href="${buildPageUrl(page + 1)}"
                 class="min-w-[44px] min-h-[44px] px-3 py-2.5 flex items-center justify-center bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">
                <i class="fas fa-chevron-right"></i>
              </a>
            `)
          }

          return `
            <nav class="mt-8 flex justify-center items-center gap-2 flex-wrap" aria-label="페이지네이션">
              ${pageButtons.join('')}
            </nav>
            <p class="text-center text-xs text-wiki-muted mt-4">
              ${page}페이지 / 총 ${totalPages}페이지 (${totalCount}개 직업)
            </p>
          `
        })()}

        ${sourceSummaryHtml}
      </div>
    `

    const hydrationScript = `<script id="job-hydration-data" type="application/json">${serializeForScript({
      items,
      meta: {
        total: totalCount,
        page,
        perPage,
        keyword,
        sort,
        includeSources: includeSources ?? null,
        sources: result.meta?.sources ?? null
      }
    })}</script>`

    // 정렬 드롭다운 이벤트 핸들러 스크립트
    const sortScript = `<script>
(function() {
  const currentSort = '${sort}';
  const sortLabels = { 'relevance': '기본 순', 'salary-desc': '연봉 높은 순', 'name-asc': '가나다 순' };

  // 초기 라벨 설정
  const labelEl = document.getElementById('job-sort-label');
  if (labelEl) labelEl.textContent = sortLabels[currentSort] || '기본 순';

  // 커스텀 드롭다운 토글
  const trigger = document.getElementById('job-sort-trigger');
  const menu = document.getElementById('job-sort-menu');
  const chevron = document.getElementById('job-sort-chevron');

  if (trigger && menu) {
    trigger.addEventListener('click', function(e) {
      e.preventDefault();
      const isOpen = !menu.classList.contains('invisible');
      if (isOpen) {
        menu.classList.add('invisible', 'opacity-0', 'translate-y-1');
        chevron?.classList.remove('rotate-180');
      } else {
        menu.classList.remove('invisible', 'opacity-0', 'translate-y-1');
        chevron?.classList.add('rotate-180');
      }
    });

    // 메뉴 외부 클릭 시 닫기
    document.addEventListener('click', function(e) {
      if (!trigger.contains(e.target) && !menu.contains(e.target)) {
        menu.classList.add('invisible', 'opacity-0', 'translate-y-1');
        chevron?.classList.remove('rotate-180');
      }
    });
  }

  // 정렬 옵션 클릭 이벤트
  document.querySelectorAll('.sort-option[data-sort]').forEach(function(btn) {
    const sortValue = btn.getAttribute('data-sort');
    if (sortValue === currentSort) btn.classList.add('active');

    btn.addEventListener('click', function() {
      const url = new URL(window.location.href);
      if (sortValue === 'relevance') {
        url.searchParams.delete('sort');
      } else {
        url.searchParams.set('sort', sortValue);
      }
      url.searchParams.delete('page'); // 정렬 변경 시 첫 페이지로
      window.location.href = url.toString();
    });
  });

  // select 요소 변경 이벤트 (모바일용)
  const selectEl = document.getElementById('job-sort-select');
  if (selectEl) {
    selectEl.value = currentSort;
    selectEl.addEventListener('change', function() {
      const url = new URL(window.location.href);
      if (this.value === 'relevance') {
        url.searchParams.delete('sort');
      } else {
        url.searchParams.set('sort', this.value);
      }
      url.searchParams.delete('page');
      window.location.href = url.toString();
    });
  }
})();
</script>`

    const hydratedContent = `${content}${hydrationScript}${sortScript}`

    const pageTitle = keyword ? `${keyword} 직업 검색 결과 - Careerwiki` : '직업위키 - Careerwiki'
    const description = createMetaDescription(
      keyword ? `${keyword} 관련 직업 정보를 확인하세요.` : undefined,
      items[0]?.display?.summary,
      '직업 연봉과 전망, 필요 역량을 한눈에 확인하세요.'
    )

    return c.html(
      renderLayoutWithContext(c,
        hydratedContent,
        escapeHtml(pageTitle),
        escapeHtml(description),
        false,
        {
          canonical: canonicalUrl,
          ogUrl: canonicalUrl,
          extraHead
        }
      )
    )
  } catch (error) {
    // 에러 메시지 추출
    const errorMsg = error instanceof Error ? error.message : String(error)
    const errorStack = error instanceof Error ? error.stack : ''
    c.status(500)

    // 에러를 화면에 표시 (복사 가능)
    const errorHtml = `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <title>500 Error - /job</title>
        <style>
          body { background: #1a1a2e; color: #eee; font-family: monospace; padding: 40px; }
          .error-box { background: #16213e; border: 1px solid #e94560; border-radius: 8px; padding: 20px; max-width: 900px; }
          h1 { color: #e94560; margin-top: 0; }
          .error-msg { background: #0f0f23; padding: 15px; border-radius: 4px; word-break: break-all; cursor: pointer; }
          .error-msg:hover { background: #1a1a3e; }
          .stack { font-size: 12px; color: #888; white-space: pre-wrap; margin-top: 10px; }
          .copy-btn { background: #e94560; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; margin-top: 15px; }
          .copy-btn:hover { background: #ff6b6b; }
          .hint { color: #888; font-size: 12px; margin-top: 10px; }
        </style>
      </head>
      <body>
        <div class="error-box">
          <h1>🚨 /job 500 Error</h1>
          <p>에러 메시지 (클릭하여 복사):</p>
          <div class="error-msg" onclick="copyError()" id="errorMsg">${errorMsg.replace(/</g, '&lt;').replace(/>/g, '&gt;')}</div>
          <div class="stack">${(errorStack || '').replace(/</g, '&lt;').replace(/>/g, '&gt;')}</div>
          <button class="copy-btn" onclick="copyError()">📋 에러 복사</button>
          <p class="hint">클릭하면 클립보드에 복사됩니다. 이 메시지를 공유해주세요.</p>
        </div>
        <script>
          function copyError() {
            const text = ${JSON.stringify(errorMsg + '\\n\\n' + (errorStack || ''))};
            navigator.clipboard.writeText(text).then(() => {
              alert('에러가 클립보드에 복사되었습니다!');
            });
          }
        </script>
      </body>
      </html>
    `
    return c.html(errorHtml)
  }
})

export { jobListRoutes }
