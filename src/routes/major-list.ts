import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { ragSearchMajors } from '../services/rag-search'
import { searchUnifiedMajors } from '../services/profileDataService'
import type { UnifiedSearchResult, UnifiedMajorSummaryEntry } from '../services/profileDataService'
import { renderMajorCard, renderDetailFallback } from '../utils/card-renderers'
import { composeDetailSlug } from '../utils/slug'
import {
  withKvCache,
  buildListCacheKey,
  type CacheState
} from '../services/cacheService'
import { LIST_CACHE_STALE_SECONDS, LIST_CACHE_MAX_AGE_SECONDS } from '../config/cachePolicy'
import { recordListFreshness } from '../services/freshnessService'
import {
  parseSourcesQuery, parseNumberParam, buildCanonicalUrl,
  createMetaDescription, escapeHtml, renderLayoutWithContext,
  serializeForScript, getOptionalUser
} from '../utils/shared-helpers'
import { logSearchQuery } from '../services/searchQueryLogger'
import { MAJOR_FIELD_LABELS, MAJOR_CATEGORIES } from '../constants/classification'

const majorListRoutes = new Hono<AppEnv>()

majorListRoutes.get('/major', async (c) => {
  const keywordRaw = c.req.query('q') || ''
  const keyword = keywordRaw.trim()
  const category = c.req.query('category') || ''
  const includeSources = parseSourcesQuery(c.req.query('sources'))
  const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
  const perPage = 20 // 성능 최적화: 50 → 20 (이미지 로딩 시간 단축)
  const sort = c.req.query('sort') || 'relevance' // 정렬 옵션

  // 모바일 감지
  const userAgent = c.req.header('user-agent') || ''
  const isMobile = /Mobile|Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent)

  const searchParams = new URLSearchParams()
  if (keyword) searchParams.set('q', keyword)
  if (category) searchParams.set('category', category)
  if (includeSources?.length) searchParams.set('sources', includeSources.join(','))
  if (page > 1) searchParams.set('page', String(page))
  if (sort && sort !== 'relevance') searchParams.set('sort', sort)
  const canonicalPath = `/major${searchParams.toString() ? `?${searchParams.toString()}` : ''}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)

  const formatSummaryText = (value?: string | null): string => {
    const fallback = '고용24와 커리어넷 데이터를 통합하여 제공하는 전공 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
    if (!value) return fallback
    const normalized = value.replace(/\s+/g, ' ').trim()
    if (!normalized) return fallback
    return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
  }

  // 로그인 상태 확인
  const user = getOptionalUser(c)
  const isLoggedIn = !!user

  try {
    const forceRefresh = c.req.query('refresh') === '1'
    // 카테고리 필터가 있으면 RAG를 건너뛰고 D1 직접 쿼리
    const useRag = !!(keyword && sort === 'relevance' && !category)

    let result: UnifiedSearchResult<UnifiedMajorSummaryEntry>
    let cacheState: CacheState | undefined

    if (useRag) {
      // RAG 검색 (벡터 + LIKE 폴백) - 자체 KV 임베딩 캐시 사용
      result = await ragSearchMajors(c.env, keyword, { page, perPage })
      cacheState = undefined
    } else {
      // 기존 LIKE 검색 + KV 결과 캐시
      const cached = await withKvCache(
        c.env.KV,
        buildListCacheKey('major', { keyword, page, perPage, includeSources, sort, category }),
        async () =>
          searchUnifiedMajors(
            { keyword, category, page, perPage, includeSources, sort },
            c.env
          ),
        {
          staleSeconds: LIST_CACHE_STALE_SECONDS,
          maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS,
          metadata: {
            type: 'major-list',
            keyword: keyword || null,
            page,
            perPage,
            includeSources: includeSources ?? []
          },
          forceRefresh
        }
      )
      result = cached.value
      cacheState = cached.cacheState
    }

    const items = result.items
    const totalCount = typeof result.meta?.total === 'number' ? result.meta.total : items.length

    // 검색어 로깅 (비동기)
    if (keyword && c.executionCtx && 'waitUntil' in c.executionCtx) {
      c.executionCtx.waitUntil(
        logSearchQuery(c.env.DB, {
          query: keyword,
          resultCount: totalCount,
          searchType: 'major',
          role: (c.get('user') as { role?: string } | undefined)?.role,
        })
      )
    }

    try {
    } catch (_) {}

    const freshnessRecordPromise = recordListFreshness(c.env.KV, {
      type: 'major',
      params: {
        keyword,
        page,
        perPage,
        includeSources
      },
      trigger: 'runtime',
      cacheState,
      totalItems: items.length,
      reportedTotal: result.meta?.total,
      sources: result.meta?.sources
    })

    if (c.executionCtx && 'waitUntil' in c.executionCtx) {
      c.executionCtx.waitUntil(
        freshnessRecordPromise.catch(() => {})
      )
    } else {
      freshnessRecordPromise.catch(() => {})
    }

    // 공통 함수 renderMajorCard 사용
    const majorCards = items.length
      ? items.map((entry) => renderMajorCard(entry)).join('')
      : keyword || category
        ? `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
            <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">${category ? `"${escapeHtml(category)}" 계열에` : ''} ${keyword ? `"${escapeHtml(keyword)}"에` : ''} 해당하는 전공이 없습니다.</p>
            <p class="text-sm text-wiki-muted mt-2">${category ? '<a href="/major" class="text-wiki-primary hover:underline">전체 전공 보기</a>' : '다른 검색어를 시도해보세요.'}</p>
          </div>`
        : `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
            <i class="fas fa-graduation-cap text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">등록된 전공이 없습니다.</p>
          </div>`

    // 🆕 캐시 알림 제거 (사용자에게 보이지 않도록)
    const cacheNotice = '' // renderCacheNotice(cacheState, { staleSeconds: LIST_CACHE_STALE_SECONDS, maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS })

    const sourceSummaryHtml = '' // 데이터 수집 상태 제거
    const filterSummary = category
      ? `${escapeHtml(category)}${keyword ? ` · "${escapeHtml(keyword)}"` : ''}`
      : keyword ? `"${escapeHtml(keyword)}" 키워드` : '전체 전공'
    const headingLabel = category
      ? escapeHtml(category)
      : keyword ? `"${escapeHtml(keyword)}" 관련 전공` : '전공위키'

    const jsonLdItems = items.map((entry, index) => {
      const slug = composeDetailSlug('major', entry.profile.name, entry.profile.id)
      return {
        '@type': 'ListItem',
        position: (page - 1) * perPage + index + 1,
        url: buildCanonicalUrl(c.req.url, `/major/${encodeURIComponent(slug)}`),
        name: entry.profile.name
      }
    })
    const jsonLd = jsonLdItems.length
      ? `<script type="application/ld+json">${JSON.stringify({
          '@context': 'https://schema.org',
          '@type': 'ItemList',
          name: keyword ? `${keyword} 관련 전공 목록` : 'Careerwiki 전공 목록',
          numberOfItems: jsonLdItems.length,
          itemListOrder: 'https://schema.org/ItemListOrderAscending',
          itemListElement: jsonLdItems
        }).replace(/</g, '\\u003C')}</script>`
      : ''

    const extraHead = ['<style>:root{--wp:16 185 129;--ws:45 212 191}</style>', jsonLd].filter(Boolean).join('\n')

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
            <span class="bg-gradient-to-r from-wiki-primary via-wiki-secondary to-wiki-primary bg-clip-text text-transparent drop-shadow-[0_2px_8px_rgba(16,185,129,0.3)]">
            ${headingLabel}
            </span>
          </h1>

          <p class="text-lg md:text-xl text-wiki-text/90 max-w-2xl mx-auto font-medium leading-relaxed">
            전문성을 키우는 첫 걸음, 지금 시작하세요
          </p>

          <div class="flex items-center justify-center gap-3 text-sm">
            <span class="px-3 py-1.5 rounded-lg bg-wiki-bg/60 text-wiki-muted">${filterSummary}</span>
            <span class="px-3 py-1.5 rounded-lg bg-gradient-to-r from-wiki-primary/20 to-wiki-secondary/20 border border-wiki-primary/30 text-white font-semibold">
              <span id="major-total-count">${totalCount}</span>개
            </span>
          </div>
        </div>

        <form id="major-filter-form" data-hydration-target="major" method="get" class="mb-3">
          <div class="flex flex-row gap-2 sm:gap-3">
            <!-- 검색창 - 글래스모피즘 + 인셋 아이콘 -->
            <div class="flex-1 relative group min-w-0">
              <div class="absolute inset-0 bg-gradient-to-r from-wiki-primary/20 via-wiki-secondary/20 to-wiki-primary/20 rounded-2xl blur-xl opacity-0 group-focus-within:opacity-100 transition-opacity duration-500"></div>
              <div class="relative flex items-center bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl overflow-hidden transition-all duration-300 group-focus-within:border-wiki-primary/50 group-focus-within:shadow-lg group-focus-within:shadow-wiki-primary/10">
                <span class="pl-3 sm:pl-4 pr-1 sm:pr-2 text-wiki-muted/60 group-focus-within:text-wiki-primary transition-colors duration-300">
                  <i class="fas fa-search text-sm"></i>
                </span>
                <input
                  id="major-keyword"
                  type="text"
                  name="q"
                  value="${escapeHtml(keyword)}"
                  placeholder="전공 검색..."
                  class="flex-1 px-1 sm:px-2 py-2 sm:py-3.5 bg-transparent border-none focus:outline-none text-base text-white placeholder:text-wiki-muted/50 min-w-0"
                  style="font-size: 16px;"
                />
                <button type="submit" class="m-1 sm:m-1.5 px-3 sm:px-5 py-2 sm:py-2.5 min-h-[40px] sm:min-h-[44px] bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-primary/25 active:scale-95 transition-all duration-200">
                  <i class="fas fa-search sm:hidden"></i>
                  <span class="hidden sm:inline">검색</span>
                </button>
              </div>
            </div>
            <!-- 정렬 + 새 전공 추가 버튼 -->
            <div class="flex items-stretch gap-2 shrink-0" id="major-hydration-toolbar">
              <div class="relative" data-dropdown="major-sort">
                <button type="button" id="major-sort-trigger" class="flex items-center justify-center gap-2 h-full px-3 sm:pl-4 sm:pr-3 bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl text-sm font-medium text-white/70 hover:border-wiki-primary/30 focus:outline-none focus:border-wiki-primary/40 transition-all duration-200 cursor-pointer min-w-[44px] sm:min-w-[130px]">
                  <i class="fas fa-sliders-h text-xs sm:hidden"></i>
                  <span id="major-sort-label" class="hidden sm:inline">${sort === 'employment-desc' ? '취업률 높은 순' : sort === 'salary-desc' ? '월급 높은 순' : sort === 'name-asc' ? '가나다 순' : '기본 순'}</span>
                  <i class="fas fa-chevron-down text-[9px] text-white/40 ml-auto transition-transform duration-200 hidden sm:inline" id="major-sort-chevron"></i>
                </button>
                <div id="major-sort-menu" class="absolute right-0 top-full mt-2 w-44 py-1.5 bg-[#1c2333]/95 backdrop-blur-xl border border-white/[0.08] rounded-xl shadow-2xl shadow-black/40 opacity-0 invisible translate-y-1 transition-all duration-200 z-50">
                  <div class="px-2 py-1.5 text-[10px] font-medium text-white/30 uppercase tracking-wider">정렬 기준</div>
                  <button type="button" data-sort="relevance" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'relevance' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>기본 순</span>
                  </button>
                  <button type="button" data-sort="employment-desc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'employment-desc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>취업률 높은 순</span>
                  </button>
                  <button type="button" data-sort="salary-desc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'salary-desc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>월급 높은 순</span>
                  </button>
                  <button type="button" data-sort="name-asc" class="sort-option w-full px-3 py-2.5 text-left text-sm text-white/70 hover:bg-white/[0.06] hover:text-white transition-colors duration-150 flex items-center gap-2.5 group ${sort === 'name-asc' ? 'active' : ''}">
                    <span class="w-1.5 h-1.5 rounded-full bg-wiki-primary opacity-0 group-[.active]:opacity-100 transition-opacity"></span>
                    <span>가나다 순</span>
                  </button>
                </div>
                <select id="major-sort-select" class="sr-only">
                  <option value="relevance">기본 순</option>
                  <option value="employment-desc">취업률 높은 순</option>
                  <option value="salary-desc">월급 높은 순</option>
                  <option value="name-asc">가나다 순</option>
                </select>
              </div>
              ${isLoggedIn ? `
              <!-- 새 전공 추가 버튼 (로그인 시에만 표시) -->
              <button
                type="button"
                id="create-major-btn"
                data-create-entity="major"
                class="flex items-center justify-center gap-1.5 h-full px-3 sm:px-3.5 bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl text-sm font-medium text-wiki-primary hover:border-wiki-primary/40 hover:bg-wiki-primary/10 active:scale-95 transition-all duration-200 whitespace-nowrap cursor-pointer"
              >
                <i class="fas fa-plus text-xs"></i>
                <span class="hidden sm:inline">추가</span>
              </button>
              ` : ''}
            </div>
          </div>
        </form>

        <!-- 카테고리 필터 -->
        <div class="mb-6 overflow-x-auto scrollbar-hide">
          <div class="flex gap-1.5 min-w-max">
            <a href="/major${keyword ? `?q=${encodeURIComponent(keyword)}` : ''}"
               class="px-3 py-1.5 rounded-full text-sm whitespace-nowrap transition-all duration-200 ${
                 !category
                   ? 'bg-wiki-primary/15 text-wiki-primary border border-wiki-primary/40 font-semibold'
                   : 'text-white/50 hover:text-white/80 hover:bg-white/[0.06]'
               }">전체</a>
            ${MAJOR_CATEGORIES.map(cat => {
              const isActive = category === cat
              const catUrl = `/major?category=${encodeURIComponent(cat)}${keyword ? `&q=${encodeURIComponent(keyword)}` : ''}`
              return `<a href="${catUrl}"
                 class="px-3 py-1.5 rounded-full text-sm whitespace-nowrap transition-all duration-200 ${
                   isActive
                     ? 'bg-wiki-primary/15 text-wiki-primary border border-wiki-primary/40 font-semibold'
                     : 'text-white/50 hover:text-white/80 hover:bg-white/[0.06]'
                 }">${escapeHtml(cat)}</a>`
            }).join('\n            ')}
          </div>
        </div>

        ${cacheNotice}

        <section id="major-results" class="space-y-4" aria-live="polite">
          ${majorCards}
        </section>

        ${(() => {
          // 실제 병합된 아이템 수를 기준으로 페이지네이션 계산
          const actualTotalCount = typeof result.meta?.total === 'number' ? result.meta.total : items.length
          const totalPages = Math.ceil(actualTotalCount / perPage)
          if (totalPages <= 1) return ''

          const buildPageUrl = (pageNum: number) => {
            const params = new URLSearchParams()
            if (keyword) params.set('q', keyword)
            if (category) params.set('category', category)
            if (includeSources?.length) params.set('sources', includeSources.join(','))
            if (pageNum > 1) params.set('page', String(pageNum))
            return `/major${params.toString() ? `?${params.toString()}` : ''}`
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

          // 페이지 번호들 (최대 7개만 표시)
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
              ${page}페이지 / 총 ${totalPages}페이지 (${actualTotalCount}개 전공)
            </p>
          `
        })()}

        ${sourceSummaryHtml}
      </div>
    `

    const hydrationScript = `<script id="major-hydration-data" type="application/json">${serializeForScript({
      items,
      meta: {
        total: totalCount,
        page,
        perPage,
        keyword,
        sort,
        includeSources: includeSources ?? null,
        sources: result.meta?.sources ?? null,
        cacheState
      }
    })}</script>`

    // 전공위키 정렬 드롭다운 이벤트 핸들러 스크립트
    const sortScript = `<script>
(function() {
  const currentSort = '${sort}';
  const sortLabels = { 'relevance': '기본 순', 'employment-desc': '취업률 높은 순', 'salary-desc': '월급 높은 순', 'name-asc': '가나다 순' };

  // 초기 라벨 설정
  const labelEl = document.getElementById('major-sort-label');
  if (labelEl) labelEl.textContent = sortLabels[currentSort] || '기본 순';

  // 커스텀 드롭다운 토글
  const trigger = document.getElementById('major-sort-trigger');
  const menu = document.getElementById('major-sort-menu');
  const chevron = document.getElementById('major-sort-chevron');

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
  document.querySelectorAll('#major-sort-menu .sort-option[data-sort]').forEach(function(btn) {
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
  const selectEl = document.getElementById('major-sort-select');
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

    const pageTitle = category
      ? `${category} 전공 목록 - Careerwiki`
      : keyword ? `${keyword} 전공 검색 결과 - Careerwiki` : '전공위키 - Careerwiki'
    const description = category
      ? createMetaDescription(`${category} 관련 전공의 취업률, 평균 월급, 만족도 정보를 확인하세요.`)
      : keyword
        ? createMetaDescription(`"${keyword}" 관련 전공의 취업률, 평균 월급, 만족도 정보를 확인하세요.`)
        : '다양한 전공의 취업률, 평균 월급, 만족도 정보를 한눈에 확인하세요. Careerwiki 전공위키.'

    return c.html(
      renderLayoutWithContext(c,
        hydratedContent,
        escapeHtml(pageTitle),
        escapeHtml(description),
        false,
        {
          canonical: canonicalUrl,
          ogUrl: canonicalUrl,
          extraHead,
          ...(keyword ? { robots: 'noindex, follow' } : {})
        }
      )
    )
    } catch (error) {
      // KV 연결 실패 등 네트워크 에러는 캐시 없이 직접 조회 시도
      if (error instanceof Error && (error.message.includes('fetch failed') || error.message.includes('ECONNRESET') || error.message.includes('ECONNREFUSED') || error.message.includes('terminated'))) {
        try {
          // 로컬 개발 환경에서는 KV가 없을 수 있으므로 조용히 처리
          const isLocalDev = !c.env.KV && !c.env.DB
          if (!isLocalDev) {
          }
          const directResult = await searchUnifiedMajors(
          {
            keyword,
            page,
            perPage,
            includeSources
          },
          c.env
        )

        const items = directResult.items
        const totalCount = typeof directResult.meta?.total === 'number' ? directResult.meta.total : items.length

        // 공통 함수 renderMajorCard 사용
        const majorCards = items.length
          ? items.map((entry) => renderMajorCard(entry)).join('')
          : keyword
            ? `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
                <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
                <p class="text-lg text-wiki-muted">"${escapeHtml(keyword)}"에 해당하는 전공이 없습니다.</p>
                <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도해보세요.</p>
              </div>`
            : `<div class="glass-card p-8 rounded-2xl text-center col-span-full">
                <i class="fas fa-graduation-cap text-4xl text-wiki-muted mb-4"></i>
                <p class="text-lg text-wiki-muted">등록된 전공이 없습니다.</p>
              </div>`

        const totalPages = Math.ceil(totalCount / perPage)

        // 모바일 감지
        const userAgent = c.req.header('user-agent') || ''
        const isMobile = /Mobile|Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent)

        const buildPageUrl = (pageNum: number) => {
          const params = new URLSearchParams()
          if (keyword) params.set('q', keyword)
          if (includeSources?.length) params.set('sources', includeSources.join(','))
          if (pageNum > 1) params.set('page', String(pageNum))
          return `/major${params.toString() ? `?${params.toString()}` : ''}`
          }

          // 화면 크기에 따라 버튼 수 조정 (모바일: 3개, 데스크톱: 7개)
          const maxPageButtons = isMobile ? 3 : 7
          let startPage = Math.max(1, page - Math.floor(maxPageButtons / 2))
        let endPage = Math.min(totalPages, startPage + maxPageButtons - 1)
        if (endPage - startPage < maxPageButtons - 1) {
          startPage = Math.max(1, endPage - maxPageButtons + 1)
        }

        const pageButtons = []
        if (page > 1) {
          pageButtons.push(`<a href="${buildPageUrl(page - 1)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition"><i class="fas fa-chevron-left"></i></a>`)
        }
        if (startPage > 1) {
          pageButtons.push(`<a href="${buildPageUrl(1)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">1</a>`)
          if (startPage > 2) pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`)
        }
        for (let i = startPage; i <= endPage; i++) {
          const isActive = i === page
          pageButtons.push(`<a href="${buildPageUrl(i)}" class="px-4 py-2 rounded-lg transition ${isActive ? 'bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold' : 'bg-wiki-bg border border-wiki-border hover:border-wiki-primary'}">${i}</a>`)
        }
        if (endPage < totalPages) {
          if (endPage < totalPages - 1) pageButtons.push(`<span class="px-2 text-wiki-muted">...</span>`)
          pageButtons.push(`<a href="${buildPageUrl(totalPages)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition">${totalPages}</a>`)
        }
        if (page < totalPages) {
          pageButtons.push(`<a href="${buildPageUrl(page + 1)}" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg hover:border-wiki-primary transition"><i class="fas fa-chevron-right"></i></a>`)
        }

        const paginationHtml = totalPages > 1 ? `
          <nav class="mt-8 flex justify-center items-center gap-2 flex-wrap" aria-label="페이지네이션">
            ${pageButtons.join('')}
          </nav>
          <p class="text-center text-xs text-wiki-muted mt-4">
            ${page}페이지 / 총 ${totalPages}페이지 (${totalCount}개 전공)
          </p>
        ` : ''

        const content = `
          <div class="max-w-[1400px] mx-auto px-4 md:px-6 md:mt-8">
            <div class="relative text-center pt-12 pb-12 mb-16 space-y-7">
              <div class="absolute inset-0 -z-10 overflow-hidden">
                <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[300px] bg-wiki-primary/5 rounded-full blur-[100px]"></div>
              </div>
              <h1 class="text-[42px] md:text-[48px] lg:text-6xl font-extrabold leading-tight mb-2">
                <span class="bg-gradient-to-r from-wiki-primary via-wiki-secondary to-wiki-primary bg-clip-text text-transparent drop-shadow-[0_2px_8px_rgba(16,185,129,0.3)]">
                ${keyword ? `"${escapeHtml(keyword)}" 관련 전공` : '전공위키'}
                </span>
              </h1>
              <p class="text-lg md:text-xl text-wiki-text/90 max-w-2xl mx-auto font-medium leading-relaxed">
                전공별 커리큘럼과 진로 정보를 통합 데이터로 확인하세요.
              </p>
              <div class="flex items-center justify-center gap-4 text-sm text-wiki-muted">
                <span class="px-3 py-1.5 rounded-lg bg-gradient-to-r from-wiki-primary/20 to-wiki-secondary/20 border border-wiki-primary/30 text-white font-semibold">
                  <span id="major-total-count">${totalCount}</span>개 전공
                </span>
              </div>
            </div>
            <form method="get" action="/major" class="glass-card rounded-xl p-6 mb-6" id="major-filter-form">
              <div class="flex flex-col md:flex-row gap-4 items-end">
                <div class="flex-1 w-full">
                  <label for="major-keyword" class="block text-sm text-wiki-muted mb-2">검색어</label>
                  <input type="text" id="major-keyword" name="q" value="${escapeHtml(keyword)}" placeholder="전공명으로 검색..." class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none" />
                </div>
                <div class="flex gap-2 justify-end">
                  <button type="submit" class="px-6 py-3 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-semibold rounded-lg hover-glow transition">
                    <i class="fas fa-search mr-2"></i>검색
                  </button>
                  <a href="/major" class="px-6 py-3 bg-wiki-bg border border-wiki-border text-wiki-muted font-semibold rounded-lg hover:border-wiki-primary transition">초기화</a>
                </div>
              </div>
            </form>
            <div class="glass-card rounded-xl p-4 mb-6 flex flex-wrap items-center gap-4" id="major-hydration-toolbar">
              <div class="flex items-center gap-2">
                <label for="major-sort-select" class="text-sm text-wiki-muted">정렬</label>
                <select id="major-sort-select" class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none">
                  <option value="relevance">기본 순</option>
                  <option value="employment-desc">취업률 높은 순</option>
                  <option value="salary-desc">월급 높은 순</option>
                </select>
              </div>
              <div class="ml-auto text-xs text-wiki-muted" id="major-hydration-status" aria-live="polite"></div>
            </div>
            <section id="major-results" class="space-y-4" aria-live="polite">
              ${majorCards}
            </section>
            ${paginationHtml}
          </div>
        `

        const hydrationScript = `<script id="major-hydration-data" type="application/json">${serializeForScript({
          items,
          meta: {
            total: totalCount,
            page,
            perPage,
            keyword,
            includeSources: includeSources ?? null,
            sources: directResult.meta?.sources ?? null
          }
        })}</script>`

        return c.html(
          renderLayoutWithContext(c,
            `${content}${hydrationScript}`,
            keyword ? `${keyword} 전공 검색 결과 - Careerwiki` : '전공위키 - Careerwiki',
            keyword ? `${keyword} 관련 전공 정보를 확인하세요.` : '전공별 커리큘럼과 진로 정보를 통합 데이터로 확인하세요.',
            false,
            { extraHead: '<style>:root{--wp:16 185 129;--ws:45 212 191}</style>' }
          )
        )
      } catch (fallbackError) {
        // 로컬 개발 환경에서는 D1이 없을 수 있으므로 조용히 처리
        const isLocalDev = !c.env.KV && !c.env.DB
        if (!isLocalDev) {
        }
      }
    }

    // 로컬 개발 환경에서는 D1이 없을 수 있으므로 조용히 처리
    const isLocalDev = !c.env.KV && !c.env.DB
    if (!isLocalDev) {
    }
    c.status(500)
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-circle-exclamation',
      iconColor: 'text-red-500',
      title: '전공 목록을 불러오지 못했습니다',
      description: '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ctaHref: '/',
      ctaLabel: '홈으로 돌아가기'
    })
    return c.html(
      renderLayoutWithContext(c,
        fallbackHtml,
        '전공 목록 오류 - Careerwiki',
        '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
      )
    )
  }
})

export { majorListRoutes }
