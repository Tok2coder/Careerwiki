/**
 * HowTo 가이드 라우트
 * index.tsx에서 추출: HowTo 목록, 작성, 초안 편집, 편집, 상세
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'
import {
  getOptionalUser, renderLayoutWithContext, escapeHtml,
  parseNumberParam, cleanGuidePrefix
} from '../utils/shared-helpers'
import {
  renderDetailFallback, renderSampleHowtoDetailPage
} from '../utils/card-renderers'
import {
  getSampleHowtoGuide
} from '../data/sampleRegistry'

const howtoRoutes = new Hono<AppEnv>()

// ============================================================================
// HowTo 가이드 목록 (GET /)
// ============================================================================
// HowTo Sample Pages - 블로그 스타일
howtoRoutes.get('/', async (c) => {
  try {
  const user = getOptionalUser(c)
  const keywordRaw = c.req.query('q') || ''
  const keyword = keywordRaw.trim()
  const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
  const perPage = 12
  
  // 모바일 감지
  const userAgent = c.req.header('user-agent') || ''
  const isMobile = /Mobile|Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(userAgent)
  
  // 검색 조건
  const searchCondition = keyword 
    ? `AND (p.title LIKE ? OR p.summary LIKE ? OR p.meta_data LIKE ?)` 
    : ''
  const searchParams = keyword 
    ? [`%${keyword}%`, `%${keyword}%`, `%${keyword}%`] 
    : []
  
  // 전체 개수 조회 (source = 'user'로 실제 유저가 작성한 HowTo만, guide: prefix 제외)
  const countQuery = `
    SELECT COUNT(*) as total
    FROM pages p
    WHERE p.page_type = 'guide' AND p.status = 'published' 
      AND p.source = 'user' AND p.slug NOT LIKE 'guide:%'
    ${searchCondition}
  `
  const countResult = keyword 
    ? await c.env.DB.prepare(countQuery).bind(...searchParams).first<{ total: number }>()
    : await c.env.DB.prepare(countQuery).first<{ total: number }>()
  const totalCount = countResult?.total || 0
  const totalPages = Math.ceil(totalCount / perPage)
  
  // DB에서 발행된 HowTo 가져오기 (페이지네이션 적용, source = 'user'만)
  const offset = (page - 1) * perPage
  const dbQuery = `
    SELECT p.id, p.slug, p.title, p.summary, p.meta_data, p.author_id, p.created_at, p.updated_at,
           u.username AS author_username, u.picture_url AS author_picture_url, u.custom_picture_url AS author_custom_picture_url,
           (SELECT COUNT(*) FROM comments WHERE page_id = p.id) AS comment_count,
           (SELECT COUNT(*) FROM user_bookmarks WHERE item_type = 'howto' AND item_slug = p.slug) AS bookmark_count
    FROM pages p
    LEFT JOIN users u ON u.id = p.author_id
    WHERE p.page_type = 'guide' AND p.status = 'published' 
      AND p.source = 'user' AND p.slug NOT LIKE 'guide:%'
    ${searchCondition}
    ORDER BY p.created_at DESC
    LIMIT ? OFFSET ?
  `
  const dbHowtos = keyword
    ? await c.env.DB.prepare(dbQuery).bind(...searchParams, perPage, offset).all()
    : await c.env.DB.prepare(dbQuery).bind(perPage, offset).all()
  
  // DB 결과를 형식으로 변환
  const dbSummaries = (dbHowtos.results || []).map((row: any) => {
    let metaData: any = {}
    try {
      if (row.meta_data) metaData = JSON.parse(row.meta_data)
    } catch {}
    return {
      slug: row.slug,
      title: row.title,
      snippet: row.summary || '',
      tags: metaData.tags || [],
      keywords: [],
      thumbnailUrl: metaData.thumbnailUrl || '',
      authorName: metaData.authorName || row.author_username || '작성자',
      authorPictureUrl: row.author_custom_picture_url || row.author_picture_url || null,
      updatedAt: row.updated_at || row.created_at,
      commentCount: row.comment_count || 0,
      bookmarkCount: row.bookmark_count || 0
    }
  })
  
  // 샘플 데이터 제거 - DB 데이터만 사용
  const howtoSummaries: Array<{
    slug: string
    title: string
    snippet: string
    tags: string[]
    keywords: string[]
    thumbnailUrl?: string
    authorName?: string
    authorPictureUrl?: string | null
    updatedAt: string | number
    commentCount: number
    bookmarkCount: number
  }> = dbSummaries
  
  // 블로그 스타일 카드 생성
  const cards = howtoSummaries.length
    ? howtoSummaries
        .map((howto) => {
          const tagsHtml = howto.tags && howto.tags.length
            ? howto.tags.slice(0, 3).map((tag: string) => 
                `<span class="inline-flex items-center px-1.5 sm:px-2 py-0.5 rounded-md text-[9px] sm:text-[10px] font-semibold uppercase tracking-wider bg-wiki-primary/10 text-wiki-primary/80 border border-wiki-primary/20">${escapeHtml(tag)}</span>`
              ).join('')
            : ''
          
          // 데스크탑용 썸네일 (상단)
          const thumbnailDesktop = howto.thumbnailUrl 
            ? `<div class="hidden sm:block aspect-[16/9] overflow-hidden">
                <img src="${escapeHtml(howto.thumbnailUrl)}" 
                     alt="${escapeHtml(howto.title)}" 
                     class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                     loading="lazy" />
              </div>`
            : `<div class="hidden sm:flex aspect-[16/9] bg-gradient-to-br from-wiki-primary/20 to-amber-500/10 items-center justify-center">
                <i class="fas fa-book-open text-5xl text-wiki-primary/40"></i>
              </div>`
          
          // 모바일용 썸네일 (오른쪽)
          const thumbnailMobile = howto.thumbnailUrl 
            ? `<div class="sm:hidden w-20 h-20 shrink-0 rounded-xl overflow-hidden">
                <img src="${escapeHtml(howto.thumbnailUrl)}" 
                     alt="${escapeHtml(howto.title)}" 
                     class="w-full h-full object-cover"
                     loading="lazy" />
              </div>`
            : `<div class="sm:hidden w-20 h-20 shrink-0 rounded-xl bg-gradient-to-br from-wiki-primary/20 to-amber-500/10 flex items-center justify-center">
                <i class="fas fa-book-open text-2xl text-wiki-primary/40"></i>
              </div>`
          
          const dateStr = howto.updatedAt 
            ? new Date(howto.updatedAt).toLocaleDateString('ko-KR', { year: 'numeric', month: 'short', day: 'numeric' })
            : ''
          
          // 댓글/저장 갯수 표시
          const statsHtml = `
            <div class="flex items-center gap-2.5 text-[13px] text-wiki-muted/60">
              <span class="inline-flex items-center gap-1">
                <i class="far fa-comment text-xs"></i>
                <span class="font-medium">${howto.commentCount}</span>
              </span>
              <span class="inline-flex items-center gap-1">
                <i class="far fa-bookmark text-xs"></i>
                <span class="font-medium">${howto.bookmarkCount}</span>
              </span>
            </div>
          `
          
          return `
            <article class="group bg-wiki-card/50 border border-wiki-border/40 rounded-2xl overflow-hidden hover:border-wiki-primary/40 hover:shadow-lg hover:shadow-wiki-primary/5 transition-all duration-300">
              <a href="/howto/${encodeURIComponent(howto.slug)}" class="block">
                <!-- 데스크탑: 썸네일 상단 -->
                ${thumbnailDesktop}
                
                <div class="p-4 sm:p-5">
                  <!-- 모바일: 가로 레이아웃 (텍스트 왼쪽 + 썸네일 오른쪽) -->
                  <div class="flex sm:block gap-3">
                    <div class="flex-1 min-w-0 space-y-1.5 sm:space-y-3">
                      <!-- 태그 -->
                      ${tagsHtml ? `<div class="flex flex-wrap gap-1.5 sm:gap-2">${tagsHtml}</div>` : ''}
                      
                      <!-- 제목 -->
                      <h2 class="text-lg sm:text-xl font-bold text-white group-hover:text-wiki-primary transition-colors line-clamp-2">
                        ${escapeHtml(howto.title)}
                      </h2>
                      
                      <!-- 설명 -->
                      <p class="text-[13px] sm:text-[15px] text-wiki-muted/90 line-clamp-2 leading-relaxed">${escapeHtml(howto.snippet)}</p>
                    </div>
                    
                    <!-- 모바일: 썸네일 오른쪽 -->
                    ${thumbnailMobile}
                  </div>
                  
                  <!-- 하단 정보 (글쓴이, 날짜, 댓글/저장 수) -->
                  <div class="flex items-center justify-between pt-3 mt-3 border-t border-wiki-border/30">
                    <div class="flex items-center gap-1.5 text-[13px] text-wiki-muted/70">
                      <span class="inline-flex items-center gap-1">
                        ${howto.authorPictureUrl 
                          ? `<img src="${escapeHtml(howto.authorPictureUrl)}" alt="${escapeHtml(howto.authorName || '운영자')}" class="w-4 h-4 sm:w-5 sm:h-5 rounded-full object-cover" />`
                          : `<i class="fas fa-user-circle text-wiki-primary/60 text-sm"></i>`}
                        <span class="font-medium">${escapeHtml(howto.authorName || '운영자')}</span>
                      </span>
                      ${dateStr ? `<span class="text-wiki-border/50">·</span><span class="font-normal">${dateStr}</span>` : ''}
                    </div>
                    ${statsHtml}
                  </div>
                </div>
              </a>
            </article>
          `
        })
        .join('')
    : ''
  
  // 비어있을 때 표시
  const emptyState = !howtoSummaries.length ? `
    <div class="col-span-full text-center py-16">
      <div class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-wiki-primary/10 mb-6">
        <i class="fas fa-pen-nib text-3xl text-wiki-primary/60"></i>
      </div>
      <h3 class="text-xl font-semibold text-white mb-2">아직 작성된 가이드가 없어요</h3>
      <p class="text-wiki-muted mb-6">첫 번째 HowTo 가이드를 작성해보세요!</p>
      <a href="${user ? '/howto/write' : '/login?redirect=/howto/write'}" 
         class="inline-flex items-center gap-2 px-6 py-3 min-h-[48px] bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
        <i class="fas fa-plus"></i>
        가이드 작성하기
      </a>
    </div>
  ` : ''

  // 페이지네이션 생성
  const maxPageButtons = isMobile ? 3 : 7
  const halfMax = Math.floor(maxPageButtons / 2)
  let startPage = Math.max(1, page - halfMax)
  let endPage = Math.min(totalPages, startPage + maxPageButtons - 1)
  if (endPage - startPage + 1 < maxPageButtons) {
    startPage = Math.max(1, endPage - maxPageButtons + 1)
  }
  
  const buildPageUrl = (p: number) => {
    const params = new URLSearchParams()
    if (keyword) params.set('q', keyword)
    if (p > 1) params.set('page', String(p))
    return `/howto${params.toString() ? `?${params.toString()}` : ''}`
  }
  
  const paginationHtml = totalPages > 1 ? `
    <nav class="flex justify-center items-center gap-2 flex-wrap" aria-label="페이지네이션">
      ${page > 1 ? `
        <a href="${buildPageUrl(page - 1)}" class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg bg-wiki-card border border-wiki-border hover:border-wiki-primary/50 hover:bg-wiki-primary/10 transition" aria-label="이전 페이지">
          <i class="fas fa-chevron-left text-sm text-wiki-muted"></i>
        </a>
      ` : `
        <span class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg bg-wiki-card/50 border border-wiki-border/50 opacity-50 cursor-not-allowed">
          <i class="fas fa-chevron-left text-sm text-wiki-muted"></i>
        </span>
      `}
      ${Array.from({ length: endPage - startPage + 1 }, (_, i) => {
        const p = startPage + i
        const isActive = p === page
        return `
          <a href="${buildPageUrl(p)}" 
             class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg text-sm font-medium transition ${isActive 
               ? 'bg-wiki-primary text-white' 
               : 'bg-wiki-card border border-wiki-border text-wiki-muted hover:border-wiki-primary/50 hover:text-white'}"
             ${isActive ? 'aria-current="page"' : ''}>
            ${p}
          </a>
        `
      }).join('')}
      ${page < totalPages ? `
        <a href="${buildPageUrl(page + 1)}" class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg bg-wiki-card border border-wiki-border hover:border-wiki-primary/50 hover:bg-wiki-primary/10 transition" aria-label="다음 페이지">
          <i class="fas fa-chevron-right text-sm text-wiki-muted"></i>
        </a>
      ` : `
        <span class="min-w-[44px] min-h-[44px] flex items-center justify-center rounded-lg bg-wiki-card/50 border border-wiki-border/50 opacity-50 cursor-not-allowed">
          <i class="fas fa-chevron-right text-sm text-wiki-muted"></i>
        </span>
      `}
    </nav>
    <p class="text-center text-sm text-wiki-muted mt-4">${page}페이지 / 총 ${totalPages}페이지 (${totalCount}개 가이드)</p>
  ` : ''

  const content = `
    <div class="max-w-[1400px] mx-auto px-4 pb-8">
      <!-- 헤더 섹션 -->
      <header class="mb-8 space-y-3">
        <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
          <i class="fas fa-book-open"></i><span>${keyword ? '검색 결과' : 'HowTo'}</span>
        </div>
        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
          <div>
            <h1 class="text-3xl md:text-4xl font-bold text-white">${keyword ? `"${escapeHtml(keyword)}" 검색 결과` : 'HowTo 가이드'}</h1>
            <p class="text-wiki-muted text-[15px] mt-1">${keyword ? `${totalCount}개의 가이드를 찾았습니다` : '실전 경험에서 나온 진짜 노하우를 공유합니다'}</p>
          </div>
        <a href="${user ? '/howto/write' : '/login?redirect=/howto/write'}" 
           class="inline-flex items-center gap-1.5 sm:gap-2 px-3 sm:px-5 py-2 sm:py-3 min-h-[40px] sm:min-h-[44px] bg-wiki-primary/70 hover:bg-wiki-primary/80 text-white text-sm sm:text-base font-medium rounded-xl transition shrink-0 self-end md:self-center"
           ${!user ? 'data-require-login="true"' : ''}>
          <i class="fas fa-plus text-xs sm:text-sm"></i>
          <span>가이드 작성</span>
        </a>
      </header>
      
      <!-- 검색창 -->
      <form action="/howto" method="get" class="mb-6">
        <div class="flex flex-row gap-2 sm:gap-3">
          <div class="flex-1 relative group min-w-0">
            <div class="relative flex items-center bg-wiki-bg/40 backdrop-blur-xl border border-white/20 rounded-2xl overflow-hidden transition-all duration-300 group-focus-within:border-wiki-primary/50 group-focus-within:shadow-lg group-focus-within:shadow-wiki-primary/10">
              <span class="pl-3 sm:pl-4 pr-1 sm:pr-2 text-wiki-muted/60 group-focus-within:text-wiki-primary transition-colors duration-300">
                <i class="fas fa-search text-sm"></i>
              </span>
              <input
                type="text"
                name="q"
                value="${escapeHtml(keyword)}"
                placeholder="가이드 검색..."
                class="flex-1 px-1 sm:px-2 py-2 sm:py-3.5 bg-transparent border-none focus:outline-none text-base text-white placeholder:text-wiki-muted/50 min-w-0"
                style="font-size: 16px;"
              />
              <button type="submit" class="m-1 sm:m-1.5 px-3 sm:px-5 py-2 sm:py-2.5 min-h-[40px] sm:min-h-[44px] bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white text-sm font-medium rounded-xl hover:shadow-lg hover:shadow-wiki-primary/25 active:scale-95 transition-all duration-200">
                <i class="fas fa-search sm:hidden"></i>
                <span class="hidden sm:inline">검색</span>
              </button>
            </div>
          </div>
        </div>
      </form>
      
      <!-- 가이드 목록 (그리드) -->
      <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
        ${cards}
        ${emptyState}
      </section>
      
      <!-- 페이지네이션 -->
      ${paginationHtml}
    </div>
  `

  const title = keyword ? `"${keyword}" - HowTo 가이드 검색 - Careerwiki` : 'HowTo 가이드 - Careerwiki'
  const description = keyword 
    ? `"${keyword}" 검색 결과 - ${totalCount}개의 HowTo 가이드를 찾았습니다.`
    : '실전 경험에서 나온 진짜 노하우를 공유하는 HowTo 가이드 모음입니다.'

  return c.html(
    renderLayoutWithContext(c,
      content,
      title,
      description
    )
  )
  } catch (error) {
    return c.text('HowTo 페이지를 불러오는 중 오류가 발생했습니다.', 500)
  }
})

// ============================================================================
// 내 작성 가이드 목록 리다이렉트 (GET /my-drafts)
// ============================================================================
// 내 작성 가이드 목록 페이지 - /user/drafts로 리다이렉트
howtoRoutes.get('/my-drafts', requireAuth, (c) => {
  const filter = c.req.query('filter')
  return c.redirect(filter ? `/user/drafts?filter=${filter}` : '/user/drafts')
})

// ============================================================================
// HowTo 작성 페이지 (GET /write)
// ============================================================================
// HowTo 작성 페이지 (로그인 필수) - Tiptap 에디터
// 페이지 접속 시에는 초안 생성하지 않음. 저장 버튼 클릭 시에만 초안 생성
howtoRoutes.get('/write', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=/howto/write')
  }
  
  // 초안 없이 빈 에디터 페이지 렌더링
    const content = `
    <!-- Tiptap CDN -->
    <link rel="stylesheet" href="/static/howto-editor.css">
    
    <div class="max-w-6xl mx-auto px-3 sm:px-4 py-4 sm:py-6">
      <!-- 헤더 -->
      <header class="mb-6">
        <!-- 상단: 뒤로가기 + 제목 -->
        <div class="flex items-center gap-3 mb-3">
          <a href="/howto" class="flex items-center justify-center w-10 h-10 min-w-[44px] min-h-[44px] text-wiki-muted hover:text-white hover:bg-wiki-border/30 rounded-xl transition shrink-0">
            <i class="fas fa-arrow-left text-lg"></i>
          </a>
          <div class="min-w-0 flex-1">
            <h1 class="text-xl sm:text-2xl font-bold text-white leading-tight">가이드 작성</h1>
            <p class="text-xs sm:text-sm text-wiki-muted mt-0.5" id="save-status">
              <span class="text-gray-400">●</span> 새 문서
            </p>
          </div>
        </div>
        
        <!-- 하단: 액션 버튼 (모바일에서도 텍스트 표시) -->
        <div class="flex items-center gap-2 sm:gap-3">
          <button type="button" id="btn-save" class="flex-1 sm:flex-none px-4 py-2.5 min-h-[44px] border border-wiki-border/60 text-wiki-muted hover:text-white hover:bg-wiki-border/20 rounded-xl transition text-sm font-medium flex items-center justify-center gap-2">
            <i class="fas fa-save"></i>
            <span>임시저장</span>
          </button>
          <button type="button" id="btn-publish" class="flex-1 sm:flex-none px-4 sm:px-5 py-2.5 min-h-[44px] bg-gradient-to-r from-wiki-primary to-blue-500 hover:from-wiki-primary/90 hover:to-blue-500/90 text-white rounded-xl transition text-sm font-medium flex items-center justify-center gap-2 shadow-lg shadow-wiki-primary/20">
            <i class="fas fa-paper-plane"></i>
            <span>발행하기</span>
          </button>
        </div>
      </header>
      
      <!-- 메타 필드 -->
      <div class="grid gap-4 mb-6">
        <!-- 제목 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">제목 *</label>
          <div class="relative">
            <input type="text" id="field-title" maxlength="100"
                   class="w-full px-4 py-3 pr-10 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white text-lg font-semibold placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                   placeholder="가이드 제목을 입력하세요"
                   value="" />
            <span id="title-check" class="absolute right-3 top-1/2 -translate-y-1/2 text-lg" style="display:none">
              <i class="fas fa-spinner fa-spin text-wiki-muted" id="title-loading"></i>
              <i class="fas fa-check-circle text-green-500" id="title-ok" style="display:none"></i>
              <i class="fas fa-times-circle text-red-500" id="title-error" style="display:none"></i>
            </span>
          </div>
          <p id="title-error-msg" class="mt-1 text-xs text-red-400" style="display:none"></p>
        </div>
        
        <!-- 요약 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">요약</label>
          <textarea id="field-summary" maxlength="300" rows="2"
                    class="w-full px-4 py-3 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition resize-none"
                    placeholder="이 가이드가 어떤 내용을 다루는지 간략히 설명해주세요"></textarea>
        </div>
        
        <!-- 썸네일 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">썸네일 <span class="text-wiki-muted font-normal">(선택)</span></label>
          <div id="thumbnail-upload-area" class="border-2 border-dashed border-wiki-border/40 rounded-xl p-4 text-center hover:border-wiki-primary/50 transition cursor-pointer">
            <div id="thumbnail-placeholder" class="space-y-2">
              <i class="fas fa-image text-3xl text-wiki-muted"></i>
              <p class="text-sm text-wiki-muted">클릭하여 이미지 업로드 또는 드래그 앤 드롭</p>
              <p class="text-xs text-wiki-muted/60">없으면 본문의 첫 번째 이미지가 자동으로 사용됩니다</p>
            </div>
            <div id="thumbnail-preview" class="hidden">
              <img id="thumbnail-img" src="" alt="썸네일 미리보기" class="max-h-48 mx-auto rounded-lg" />
              <button type="button" id="thumbnail-remove" class="mt-2 text-sm text-red-400 hover:text-red-300">
                <i class="fas fa-times mr-1"></i>썸네일 제거
              </button>
            </div>
          </div>
          <input type="file" id="thumbnail-input" accept="image/*" class="hidden" />
          <input type="hidden" id="field-thumbnail" value="" />
        </div>
        
        <!-- 태그 & 관련 콘텐츠 -->
        <div class="grid md:grid-cols-2 gap-4">
          <!-- 태그 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">태그</label>
            <div class="relative">
              <input type="text" id="field-tags"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="태그 입력 후 Enter 또는 쉼표(,)"
                     data-tags='[]' />
              <div id="tags-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
          
          <!-- 관련 직업 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 직업</label>
            <div class="relative">
              <input type="text" id="field-jobs" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="직업 검색..."
                     data-items='[]' />
              <div id="jobs-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="jobs-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
        </div>
        
        <div class="grid md:grid-cols-2 gap-4">
          <!-- 관련 전공 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 전공</label>
            <div class="relative">
              <input type="text" id="field-majors" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="전공 검색..."
                     data-items='[]' />
              <div id="majors-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="majors-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
          
          <!-- 관련 HowTo -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 HowTo</label>
            <div class="relative">
              <input type="text" id="field-howtos" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="HowTo 검색..."
                     data-items='[]' />
              <div id="howtos-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="howtos-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 본문 영역 -->
      <div>
        <label class="block text-sm font-medium text-wiki-text mb-2">본문 *</label>
        
        <!-- 에디터 툴바 -->
        <div id="toolbar" class="howto-editor-toolbar bg-wiki-card/50 border border-wiki-border/40 rounded-t-xl px-3 py-2">
          <div class="toolbar-group">
            <button type="button" data-action="bold" title="굵게 (Ctrl+B)"><i class="fas fa-bold"></i></button>
            <button type="button" data-action="italic" title="기울임 (Ctrl+I)"><i class="fas fa-italic"></i></button>
            <button type="button" data-action="underline" title="밑줄 (Ctrl+U)"><i class="fas fa-underline"></i></button>
            <button type="button" data-action="strike" title="취소선"><i class="fas fa-strikethrough"></i></button>
          </div>
          <div class="toolbar-group">
            <!-- 폰트 -->
            <div class="toolbar-dropdown font-dropdown">
              <button type="button" title="폰트" class="toolbar-btn flex items-center gap-1.5"><span class="current-font-name">기본</span><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="font-menu hidden">
                <button type="button" data-font="inherit" class="is-active">기본</button>
                <button type="button" data-font="sans-serif">Sans-serif (샌즈)</button>
                <button type="button" data-font="serif">Serif (세리프)</button>
                <button type="button" data-font="monospace">Monospace (코드)</button>
                <button type="button" data-font="'Nanum Gothic', sans-serif">나눔고딕</button>
                <button type="button" data-font="'Nanum Myeongjo', serif">나눔명조</button>
              </div>
            </div>
            <!-- 폰트 크기 -->
            <div class="toolbar-dropdown size-dropdown">
              <button type="button" title="글자 크기" class="toolbar-btn size-input-btn">
                <input type="number" class="size-input" value="15" min="6" max="72" title="글자 크기 (px)">
                <i class="fas fa-chevron-down text-[10px] opacity-60"></i>
              </button>
              <div class="size-menu hidden">
                <button type="button" data-size="8px">8</button>
                <button type="button" data-size="12px">12</button>
                <button type="button" data-size="14px">14</button>
                <button type="button" data-size="15px" class="is-default">15</button>
                <button type="button" data-size="16px">16</button>
                <button type="button" data-size="18px">18</button>
                <button type="button" data-size="20px">20</button>
                <button type="button" data-size="24px">24</button>
                <button type="button" data-size="28px">28</button>
                <button type="button" data-size="32px">32</button>
                <button type="button" data-size="36px">36</button>
              </div>
            </div>
            <!-- 폰트 색상 -->
            <div class="toolbar-dropdown color-dropdown">
              <button type="button" title="글자 색상" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-palette"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="color-menu hidden">
                <div class="color-grid">
                  <button type="button" data-color="#ffffff" style="background:#ffffff" title="흰색"></button>
                  <button type="button" data-color="#f59e0b" style="background:#f59e0b" title="주황"></button>
                  <button type="button" data-color="#ef4444" style="background:#ef4444" title="빨강"></button>
                  <button type="button" data-color="#22c55e" style="background:#22c55e" title="초록"></button>
                  <button type="button" data-color="#3b82f6" style="background:#3b82f6" title="파랑"></button>
                  <button type="button" data-color="#8b5cf6" style="background:#8b5cf6" title="보라"></button>
                  <button type="button" data-color="#ec4899" style="background:#ec4899" title="분홍"></button>
                  <button type="button" data-color="#6b7280" style="background:#6b7280" title="회색"></button>
                </div>
                <button type="button" data-color="" class="color-reset">기본 색상</button>
              </div>
            </div>
          </div>
          <div class="toolbar-group">
            <!-- 정렬 -->
            <div class="toolbar-dropdown align-dropdown">
              <button type="button" title="정렬" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-align-left"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="align-menu hidden">
                <button type="button" data-action="alignLeft"><i class="fas fa-align-left"></i> 왼쪽</button>
                <button type="button" data-action="alignCenter"><i class="fas fa-align-center"></i> 중앙</button>
                <button type="button" data-action="alignRight"><i class="fas fa-align-right"></i> 오른쪽</button>
              </div>
            </div>
            <!-- 커스텀 블록 -->
            <div class="toolbar-dropdown custom-block-dropdown">
              <button type="button" title="커스텀 블록" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-cube"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="toolbar-dropdown-content custom-block-menu hidden">
                <button type="button" data-action="blockquote"><i class="fas fa-quote-left text-sky-400"></i> 인용구</button>
                <button type="button" data-action="horizontalRule"><i class="fas fa-minus text-purple-400"></i> 구분선</button>
                <button type="button" data-action="checkpointBox"><i class="fas fa-check-circle text-green-500"></i> 체크포인트</button>
                <button type="button" data-action="conclusionBox"><i class="fas fa-lightbulb text-wiki-primary"></i> 결론 박스</button>
                <button type="button" data-action="qnaBlock"><i class="fas fa-question-circle text-amber-500"></i> Q&A</button>
              </div>
            </div>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="h1" title="제목 1">H1</button>
            <button type="button" data-action="h2" title="제목 2">H2</button>
            <button type="button" data-action="h3" title="제목 3">H3</button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="bulletList" title="글머리 기호"><i class="fas fa-list-ul"></i></button>
            <button type="button" data-action="orderedList" title="번호 매기기"><i class="fas fa-list-ol"></i></button>
            <button type="button" data-action="taskList" title="체크리스트"><i class="fas fa-tasks"></i></button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="link" title="외부 링크"><i class="fas fa-link"></i></button>
            <button type="button" data-action="internalLink" title="내부 링크 (직업/전공/HowTo)"><i class="fas fa-sitemap"></i></button>
            <button type="button" data-action="footnote" title="각주 (출처)"><i class="fas fa-asterisk"></i></button>
            <button type="button" data-action="image" title="이미지"><i class="fas fa-image"></i></button>
            <button type="button" data-action="table" title="표"><i class="fas fa-table"></i></button>
            <button type="button" data-action="codeBlock" title="코드 블록"><i class="fas fa-code"></i></button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="undo" title="실행 취소 (Ctrl+Z)"><i class="fas fa-undo"></i></button>
            <button type="button" data-action="redo" title="다시 실행 (Ctrl+Y)"><i class="fas fa-redo"></i></button>
          </div>
        </div>
        
        <!-- 표 편집 툴바 (압축형) -->
        <div id="table-toolbar" class="table-toolbar">
          <div class="toolbar-dropdown row-dropdown">
            <button type="button" title="행 추가" class="toolbar-btn"><i class="fas fa-plus"></i> 행</button>
            <div class="row-menu hidden">
              <button type="button" data-action="addRowBefore"><i class="fas fa-arrow-up"></i> 위에 추가</button>
              <button type="button" data-action="addRowAfter"><i class="fas fa-arrow-down"></i> 아래에 추가</button>
            </div>
          </div>
          <div class="toolbar-dropdown col-dropdown">
            <button type="button" title="열 추가" class="toolbar-btn"><i class="fas fa-plus"></i> 열</button>
            <div class="col-menu hidden">
              <button type="button" data-action="addColBefore"><i class="fas fa-arrow-left"></i> 왼쪽에 추가</button>
              <button type="button" data-action="addColAfter"><i class="fas fa-arrow-right"></i> 오른쪽에 추가</button>
            </div>
          </div>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="deleteRow" title="행 삭제"><i class="fas fa-trash-alt"></i></button>
          <button type="button" data-action="deleteCol" title="열 삭제"><i class="fas fa-columns"></i></button>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="mergeCells" title="셀 병합"><i class="fas fa-compress-alt"></i></button>
          <button type="button" data-action="splitCell" title="셀 분할"><i class="fas fa-expand-alt"></i></button>
          <!-- 셀 배경색 -->
          <span class="toolbar-divider"></span>
          <div class="toolbar-dropdown cell-color-dropdown">
            <button type="button" title="셀 배경색" class="toolbar-btn"><i class="fas fa-fill-drip"></i></button>
            <div class="cell-color-menu hidden">
              <div class="color-grid">
                <button type="button" data-cell-bg="" style="background:transparent;border:1px dashed #666" title="없음"></button>
                <button type="button" data-cell-bg="rgba(79,143,255,0.15)" style="background:rgba(79,143,255,0.4)" title="파랑"></button>
                <button type="button" data-cell-bg="rgba(34,197,94,0.15)" style="background:rgba(34,197,94,0.4)" title="초록"></button>
                <button type="button" data-cell-bg="rgba(245,158,11,0.15)" style="background:rgba(245,158,11,0.4)" title="주황"></button>
                <button type="button" data-cell-bg="rgba(239,68,68,0.15)" style="background:rgba(239,68,68,0.4)" title="빨강"></button>
                <button type="button" data-cell-bg="rgba(139,92,246,0.15)" style="background:rgba(139,92,246,0.4)" title="보라"></button>
              </div>
            </div>
          </div>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="deleteTable" title="표 삭제" class="text-red-400"><i class="fas fa-times"></i></button>
        </div>
        
        <!-- 에디터 본문 -->
        <div id="editor" class="howto-editor-content bg-wiki-card/50 border border-wiki-border/40 border-t-0 rounded-b-xl"></div>
      </div>
      
      <!-- 출처 섹션 -->
      <div id="footnotes-section" class="editor-footnotes-section">
        <h4><i class="fas fa-book-open"></i> 출처</h4>
        <div id="footnotes-list" class="editor-footnotes-list">
          <div class="editor-footnotes-empty">
            <i class="fas fa-quote-right"></i>
            <p>각주를 추가하면 여기에 출처가 표시됩니다.</p>
          </div>
        </div>
      </div>
      
      <div id="editor-message" class="hidden mt-4"></div>
    </div>
    
    <!-- Tiptap 에디터 번들 -->
    <script src="/static/editor.bundle.iife.js"></script>
    
    <script>
      // 에디터 데이터 (초안 없음)
      let DRAFT_ID = null;
      let currentVersion = 1;
      let hasUnsavedChanges = false;
      let tiptapEditor = null;
      
      // 페이지 나가기 경고
      const beforeUnloadHandler = (e) => {
        if (hasUnsavedChanges) {
          e.preventDefault();
          e.returnValue = '저장하지 않은 변경사항이 있습니다. 정말 나가시겠습니까?';
          return e.returnValue;
        }
      };
      window.addEventListener('beforeunload', beforeUnloadHandler);
      
      // 에디터 초기화
      document.addEventListener('DOMContentLoaded', async () => {
        if (window.HowToEditor) {
          tiptapEditor = new window.HowToEditor({
            container: '#editor',
            draftId: null, // 초안 없음
            version: 1,
            initialContent: '<p></p>',
            onSave: (data) => {
              if (data.success) {
                currentVersion = data.version;
                hasUnsavedChanges = false;
                updateSaveStatus('saved');
              }
            },
            onError: (err) => {
              showMessage('error', err.message);
              updateSaveStatus('error');
            },
            onUpdate: () => {
              hasUnsavedChanges = true;
              updateSaveStatus('unsaved');
            }
          });
          window.HowToEditorInstance = tiptapEditor;
        }
        
        initAutocomplete();
        initTags();
        initThumbnail();
        setupToolbarDropdowns();
        initTitleCheck();
        
        // 저장 버튼
        document.getElementById('btn-save')?.addEventListener('click', saveDraft);
        
        // 발행 버튼
        document.getElementById('btn-publish')?.addEventListener('click', publishGuide);
        
        // 각주 목록 업데이트 이벤트 수신
        window.addEventListener('footnotes-updated', function(e) {
          var footnotes = e.detail.footnotes || [];
          var container = document.getElementById('footnotes-list');
          if (!container) return;
          
          function esc(str) {
            if (!str) return '';
            return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
          }
          
          if (footnotes.length === 0) {
            container.innerHTML = '<div class="editor-footnotes-empty"><i class="fas fa-quote-right"></i><p>각주를 추가하면 여기에 출처가 표시됩니다.</p></div>';
          } else {
            container.innerHTML = footnotes.map(function(f) {
              var urlHtml = f.url ? '<a href="' + esc(f.url) + '" target="_blank" class="editor-footnote-url">' + esc(f.url) + '</a>' : '';
              return '<div class="editor-footnote-item" data-id="' + f.id + '">' +
                '<span class="editor-footnote-id">' + f.id + '</span>' +
                '<div class="editor-footnote-content">' +
                  '<div class="editor-footnote-text">' + esc(f.text) + '</div>' +
                  urlHtml +
                '</div>' +
              '</div>';
            }).join('');
          }
        });
      });
      
      // 툴바 드롭다운 설정
      function setupToolbarDropdowns() {
        const menuSelector = '.align-menu, .font-menu, .custom-block-menu, .color-menu, .size-menu, .row-menu, .col-menu, .cell-color-menu, .border-style-menu';
        
        document.querySelectorAll('.toolbar-dropdown').forEach(dropdown => {
          const btn = dropdown.querySelector('.toolbar-btn');
          const menu = dropdown.querySelector(menuSelector);
          if (!btn || !menu) return;
          
          let isOpen = false;
          let hoverTimeout = null;
          
          btn.addEventListener('click', (e) => {
            e.stopPropagation();
            isOpen = !isOpen;
            dropdown.classList.toggle('is-open', isOpen);
            if (isOpen) {
              menu.classList.remove('hidden');
              document.querySelectorAll('.toolbar-dropdown').forEach(other => {
                if (other !== dropdown) {
                  other.classList.remove('is-open');
                  const otherMenu = other.querySelector(menuSelector);
                  if (otherMenu) otherMenu.classList.add('hidden');
                }
              });
            } else {
              menu.classList.add('hidden');
            }
          });
          
          dropdown.addEventListener('mouseenter', () => {
            clearTimeout(hoverTimeout);
            menu.classList.remove('hidden');
          });
          
          dropdown.addEventListener('mouseleave', () => {
            if (!isOpen) {
              hoverTimeout = setTimeout(() => {
                menu.classList.add('hidden');
              }, 300);
            }
          });
          
          menu.addEventListener('click', (e) => {
            if (e.target.closest('button')) {
              isOpen = false;
              dropdown.classList.remove('is-open');
              setTimeout(() => menu.classList.add('hidden'), 100);
            }
          });
        });
        
        document.addEventListener('click', (e) => {
          if (!e.target.closest('.toolbar-dropdown')) {
            document.querySelectorAll('.toolbar-dropdown').forEach(dropdown => {
              dropdown.classList.remove('is-open');
              const menu = dropdown.querySelector(menuSelector);
              if (menu) menu.classList.add('hidden');
            });
          }
        });
        
        // 폰트/크기 관련 이벤트는 에디터에서 처리
      }
      
      function updateSaveStatus(status) {
        const el = document.getElementById('save-status');
        if (!el) return;
        switch(status) {
          case 'saving':
            el.innerHTML = '<span class="text-blue-400">●</span> 저장 중...';
            break;
          case 'saved':
            el.innerHTML = '<span class="text-green-400">●</span> 저장됨';
            break;
          case 'unsaved':
            el.innerHTML = '<span class="text-amber-400">●</span> 저장되지 않음';
            break;
          case 'error':
            el.innerHTML = '<span class="text-red-400">●</span> 저장 실패';
            break;
        }
      }
      
      function showMessage(type, msg) {
        const el = document.getElementById('editor-message');
        if (!el) return;
        el.className = 'mt-4 p-4 rounded-lg text-sm ' + 
          (type === 'error' ? 'bg-red-500/10 border border-red-500/30 text-red-400' : 
           type === 'success' ? 'bg-green-500/10 border border-green-500/30 text-green-400' : 
           'bg-blue-500/10 border border-blue-500/30 text-blue-400');
        el.textContent = msg;
        el.classList.remove('hidden');
        setTimeout(() => el.classList.add('hidden'), 5000);
      }
      
      // 필드별 에러 표시
      function showFieldError(fieldId, msg) {
        clearFieldError(fieldId);
        const field = document.getElementById(fieldId);
        if (!field) return;
        field.dataset.error = 'true';
        field.style.borderColor = 'rgba(239, 68, 68, 0.6)';
        const errorEl = document.createElement('p');
        errorEl.className = 'field-error text-red-400 text-xs mt-1';
        errorEl.textContent = msg;
        field.parentElement.appendChild(errorEl);
      }
      
      function clearFieldError(fieldId) {
        const field = document.getElementById(fieldId);
        if (!field) return;
        delete field.dataset.error;
        field.style.borderColor = '';
        const existingError = field.parentElement.querySelector('.field-error');
        if (existingError) existingError.remove();
      }
      
      function clearAllFieldErrors() {
        document.querySelectorAll('.field-error').forEach(el => el.remove());
        document.querySelectorAll('[data-error="true"]').forEach(el => {
          delete el.dataset.error;
          el.style.borderColor = '';
        });
      }
      
      // 유효성 검사 (초성만 입력 등 체크)
      function validateTitle(title) {
        if (!title) return '제목을 입력해주세요.';
        if (title.length < 2) return '제목은 2자 이상이어야 합니다.';
        // 초성만 있는지 체크 (ㄱ-ㅎ만으로 이루어진 경우)
        if (/^[ㄱ-ㅎ]+$/.test(title)) return '제목에 초성만 입력할 수 없습니다.';
        return null;
      }
      
      function validateContent(html) {
        if (!html || html === '<p></p>' || html === '<p><br></p>') return '본문을 입력해주세요.';
        // 초성만 있는지 체크
        const textOnly = html.replace(/<[^>]*>/g, '').trim();
        if (/^[ㄱ-ㅎ\s]+$/.test(textOnly)) return '본문에 초성만 입력할 수 없습니다.';
        return null;
      }
      
      // 제목 중복 체크 상태
      let titleCheckTimer = null;
      let titleCheckAbort = null;
      let isTitleAvailable = true;

      function initTitleCheck() {
        const titleInput = document.getElementById('field-title');
        const titleCheck = document.getElementById('title-check');
        const titleLoading = document.getElementById('title-loading');
        const titleOk = document.getElementById('title-ok');
        const titleError = document.getElementById('title-error');
        const titleErrorMsg = document.getElementById('title-error-msg');

        if (!titleInput) return;

        // style.display 사용 (FA 아이콘에 hidden 클래스가 작동하지 않음)
        function show(el) { if (el) el.style.display = ''; }
        function hide(el) { if (el) el.style.display = 'none'; }

        titleInput.addEventListener('input', () => {
          hasUnsavedChanges = true;
          updateSaveStatus('unsaved');

          clearTimeout(titleCheckTimer);
          if (titleCheckAbort) { titleCheckAbort.abort(); titleCheckAbort = null; }
          const title = titleInput.value.trim();

          // 빈 값이면 숨김
          if (!title) {
            hide(titleCheck);
            hide(titleErrorMsg);
            isTitleAvailable = true;
            return;
          }

          // 2자 미만이면 바로 에러
          if (title.length < 2) {
            show(titleCheck);
            hide(titleLoading);
            hide(titleOk);
            show(titleError);
            titleErrorMsg.textContent = '제목은 최소 2자 이상이어야 합니다';
            show(titleErrorMsg);
            isTitleAvailable = false;
            return;
          }

          // 로딩 표시
          show(titleCheck);
          show(titleLoading);
          hide(titleOk);
          hide(titleError);
          hide(titleErrorMsg);

          // 500ms 후 API 호출
          titleCheckTimer = setTimeout(async () => {
            const ac = new AbortController();
            titleCheckAbort = ac;
            const timeout = setTimeout(() => ac.abort(), 8000);
            try {
              const res = await fetch('/api/howto/check-title?title=' + encodeURIComponent(title), { signal: ac.signal });
              clearTimeout(timeout);
              if (ac.signal.aborted) return;
              const data = await res.json();

              hide(titleLoading);

              if (data.success && data.available) {
                show(titleOk);
                hide(titleError);
                hide(titleErrorMsg);
                isTitleAvailable = true;
              } else {
                hide(titleOk);
                show(titleError);
                titleErrorMsg.textContent = data.reason || '사용할 수 없는 제목입니다';
                show(titleErrorMsg);
                isTitleAvailable = false;
              }
            } catch (err) {
              clearTimeout(timeout);
              if (ac.signal.aborted) {
                if (titleCheckAbort !== ac) return;
              }
              hide(titleLoading);
              hide(titleOk);
              show(titleError);
              titleErrorMsg.textContent = '제목 확인에 실패했습니다. 잠시 후 다시 시도해주세요.';
              show(titleErrorMsg);
              isTitleAvailable = false;
            }
          }, 500);
        });
      }

      // 초안 저장 (없으면 새로 생성)
      async function saveDraft() {
        clearAllFieldErrors();
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          return false;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          return false;
        }
        
        const contentHtml = tiptapEditor?.editor?.getHTML();
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          return false;
        }
        
        updateSaveStatus('saving');
        
        const content = tiptapEditor?.editor?.getJSON();
        const tags = getSelectedTags();
        const relatedJobs = getSelectedItems('jobs');
        const relatedMajors = getSelectedItems('majors');
        const relatedHowtos = getSelectedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          // 저장 시 임시 발행 상태로 저장 (draft_published)
          const res = await fetch('/api/howto/save-publish', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              draftId: DRAFT_ID,
              title,
              summary,
              contentJson: JSON.stringify(content),
              contentHtml,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              thumbnailUrl: thumbnail
            })
          });
          const data = await res.json();
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '저장되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
            return true;
          } else {
            throw new Error(data.error || '저장 실패');
          }
        } catch (err) {
          showMessage('error', err.message || '저장 중 오류가 발생했습니다.');
          updateSaveStatus('error');
          return false;
        }
      }
      
      // 바로 발행하기
      async function publishGuide() {
        clearAllFieldErrors();
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          return;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          return;
        }
        
        const contentHtml = tiptapEditor?.editor?.getHTML();
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          return;
        }
        
        if (!confirm('이 가이드를 바로 발행하시겠습니까?\\n발행하면 목록에 공개됩니다.')) return;
        
        updateSaveStatus('saving');
        
        const content = tiptapEditor?.editor?.getJSON();
        const tags = getSelectedTags();
        const relatedJobs = getSelectedItems('jobs');
        const relatedMajors = getSelectedItems('majors');
        const relatedHowtos = getSelectedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          const publishBtn = document.getElementById('btn-publish');
          if (publishBtn) {
            publishBtn.disabled = true;
            publishBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>발행 중...';
          }
          
          // 바로 발행 API 호출
          const res = await fetch('/api/howto/publish-direct', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              title,
              summary,
              contentJson: JSON.stringify(content),
              contentHtml,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              thumbnailUrl: thumbnail
            })
          });
          const data = await res.json();
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '발행되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
          } else {
            throw new Error(data.error || '발행 실패');
          }
        } catch (err) {
          showMessage('error', err.message || '발행 중 오류가 발생했습니다.');
          const publishBtn = document.getElementById('btn-publish');
          if (publishBtn) {
            publishBtn.disabled = false;
            publishBtn.innerHTML = '<i class="fas fa-globe mr-2"></i>발행';
          }
        }
      }
      
      function escapeHtml(str) {
        if (!str) return '';
        return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
      }
      
      // 자동완성 초기화 (pointerdown + 이벤트 위임 + focusout 방식 + IME 지원)
      function initAutocomplete() {
        ['jobs', 'majors', 'howtos'].forEach(domain => {
          const input = document.getElementById('field-' + domain);
          const dropdown = document.getElementById(domain + '-dropdown');
          const container = document.getElementById(domain + '-container');
          if (!input || !dropdown || !container) return;
          const wrap = input.parentElement;
          
          let items = [];
          try {
            items = JSON.parse(input.dataset.items || '[]');
          } catch (e) {}
          
          items.forEach(item => addItemChip(container, item, domain));
          
          let debounceTimer = null;
          let composingTimer = null;
          let abortController = null;
          let lastSearchValue = '';
          
          // 검색 실행 함수
          const doSearch = async (q) => {
            if (q.length < 2) {
              dropdown.classList.add('hidden');
              dropdown.innerHTML = '';
              return;
            }
            
            // 이미 같은 값으로 검색했으면 스킵
            if (q === lastSearchValue) return;
            lastSearchValue = q;
            
            try {
              if (abortController) abortController.abort();
              abortController = new AbortController();
              
              const res = await fetch('/api/search?domain=' + domain + '&q=' + encodeURIComponent(q) + '&limit=10', {
                signal: abortController.signal
              });
              const data = await res.json();
              
              if (data.success && data.results && data.results.length > 0) {
                dropdown.innerHTML = data.results.map(r => 
                  '<div class="autocomplete-item" data-id="' + (r.id || r.slug) + '" data-name="' + escapeHtml(r.name || r.title) + '" data-slug="' + escapeHtml(r.slug || r.name) + '">' +
                  '<span class="text-white">' + escapeHtml(r.name || r.title) + '</span>' +
                  (r.snippet ? '<br><span class="text-xs text-wiki-muted">' + escapeHtml(r.snippet) + '</span>' : '') +
                  '</div>'
                ).join('');
                dropdown.classList.remove('hidden');
              } else {
                dropdown.classList.add('hidden');
                dropdown.innerHTML = '';
              }
            } catch (err) {
              if (err?.name !== 'AbortError') {
              }
            }
          };
          
          // 모든 입력에 대해 1초 후 자동 검색 (한글 조합 중에도)
          input.addEventListener('input', () => {
            clearTimeout(debounceTimer);
            clearTimeout(composingTimer);
            const q = input.value.trim();
            
            // 1초 후 자동 검색 (한글 조합 중에도 동작)
            composingTimer = setTimeout(() => doSearch(q), 1000);
            
            // 영어 등 비조합 입력은 300ms 후 빠르게 검색
            debounceTimer = setTimeout(() => {
              const currentQ = input.value.trim();
              if (currentQ.length >= 2) {
                doSearch(currentQ);
              }
            }, 300);
          });
          
          dropdown.addEventListener('pointerdown', (e) => {
            const el = e.target.closest('.autocomplete-item');
            if (!el) return;
            e.preventDefault();
            e.stopPropagation();
            
            const item = { id: el.dataset.id, name: el.dataset.name, slug: el.dataset.slug };
            
            // 중복 체크
            const existing = container.querySelector('[data-id="' + item.id + '"]');
            if (!existing) {
              addItemChip(container, item, domain);
            }
            
            input.value = '';
            dropdown.innerHTML = '';
            dropdown.classList.add('hidden');
            input.focus();
          });
          
          const handleFocusOut = (evt) => {
            const next = evt.relatedTarget;
            const isInside = wrap ? wrap.contains(next) : (input === next || dropdown.contains(next));
            if (!isInside) {
              dropdown.classList.add('hidden');
            }
          };
          (wrap || input).addEventListener('focusout', handleFocusOut);
        });
      }
      
      function addItemChip(container, item, domain) {
        // 중복 체크
        const existingChip = container.querySelector('[data-id="' + item.id + '"]');
        if (existingChip) return;
        
        const chip = document.createElement('span');
        chip.className = 'inline-flex items-center gap-1 px-2 py-1 bg-wiki-primary/10 border border-wiki-primary/30 rounded-lg text-xs text-wiki-primary';
        chip.dataset.id = item.id;
        chip.dataset.name = item.name || item.title || '';
        chip.dataset.slug = item.slug || '';
        chip.innerHTML = escapeHtml(item.name || item.title) + '<button type="button" class="hover:text-red-400 ml-1">&times;</button>';
        
        chip.querySelector('button').addEventListener('click', () => {
          chip.remove();
        });
        
        container.appendChild(chip);
      }
      
      function getSelectedItems(domain) {
        const container = document.getElementById(domain + '-container');
        if (!container) return [];
        return Array.from(container.querySelectorAll('span[data-id]')).map(chip => ({
          id: chip.dataset.id,
          name: chip.dataset.name,
          slug: chip.dataset.slug
        }));
      }
      
      function getThumbnailUrl() {
        return thumbnailUrl;
      }
      
      // 태그 관련
      let selectedTags = [];
      
      function initTags() {
        const input = document.getElementById('field-tags');
        if (!input) return;
        
        try {
          selectedTags = JSON.parse(input.dataset.tags || '[]');
          selectedTags.forEach(tag => addTagChip(tag));
        } catch(e) {}
        
        input.addEventListener('keydown', (e) => {
          if (e.key === 'Enter' || e.key === ',') {
            e.preventDefault();
            const tag = input.value.replace(/,/g, '').trim();
            if (tag && !selectedTags.includes(tag)) {
              selectedTags.push(tag);
              addTagChip(tag);
              hasUnsavedChanges = true;
              updateSaveStatus('unsaved');
            }
            input.value = '';
          }
        });
      }
      
      function addTagChip(tag) {
        const container = document.getElementById('tags-container');
        if (!container) return;
        const chip = document.createElement('span');
        chip.className = 'inline-flex items-center gap-1 px-3 py-1 bg-wiki-primary/10 text-wiki-primary rounded-full text-sm';
        chip.innerHTML = escapeHtml(tag) + '<button type="button" class="hover:text-red-400 ml-1" onclick="removeTag(this, \\'' + escapeHtml(tag.replace(/'/g, "\\\\'")) + '\\')"><i class="fas fa-times text-xs"></i></button>';
        container.appendChild(chip);
      }
      
      function removeTag(btn, tag) {
        selectedTags = selectedTags.filter(t => t !== tag);
        btn.parentElement.remove();
        hasUnsavedChanges = true;
        updateSaveStatus('unsaved');
      }
      
      function getSelectedTags() {
        return selectedTags;
      }
      
      // 썸네일 업로드
      let thumbnailUrl = '';
      let thumbnailInitialized = false;
      
      function initThumbnail() {
        if (thumbnailInitialized) return;
        thumbnailInitialized = true;
        
        const uploadArea = document.getElementById('thumbnail-upload-area');
        const fileInput = document.getElementById('thumbnail-input');
        const placeholder = document.getElementById('thumbnail-placeholder');
        const preview = document.getElementById('thumbnail-preview');
        const thumbnailImg = document.getElementById('thumbnail-img');
        const removeBtn = document.getElementById('thumbnail-remove');
        const hiddenField = document.getElementById('field-thumbnail');
        
        if (!uploadArea || !fileInput) return;
        
        // 클릭 시 파일 선택 (이벤트 버블링 방지)
        uploadArea.addEventListener('click', (e) => {
          // fileInput 클릭이나 removeBtn 클릭은 무시
          if (e.target === fileInput || e.target.closest('#thumbnail-remove')) return;
          e.stopPropagation();
          fileInput.click();
        }, { capture: true });
        
        // 드래그 앤 드롭
        uploadArea.addEventListener('dragover', (e) => {
          e.preventDefault();
          uploadArea.classList.add('border-wiki-primary');
        });
        uploadArea.addEventListener('dragleave', () => {
          uploadArea.classList.remove('border-wiki-primary');
        });
        uploadArea.addEventListener('drop', (e) => {
          e.preventDefault();
          uploadArea.classList.remove('border-wiki-primary');
          const file = e.dataTransfer?.files?.[0];
          if (file && file.type.startsWith('image/')) {
            handleThumbnailUpload(file);
          }
        });
        
        // 파일 선택
        fileInput.addEventListener('change', (e) => {
          const file = e.target.files?.[0];
          if (file) {
            handleThumbnailUpload(file);
          }
          // 같은 파일 재선택 가능하도록 value 리셋
          e.target.value = '';
        });
        
        // 기존 이미지 로드
        if (hiddenField && hiddenField.value) {
          thumbnailUrl = hiddenField.value;
          if (preview) preview.classList.remove('hidden');
          if (placeholder) placeholder.classList.add('hidden');
          if (thumbnailImg) thumbnailImg.src = thumbnailUrl;
          if (removeBtn) removeBtn.classList.remove('hidden');
        }
        
        // 삭제 버튼
        if (removeBtn) {
          removeBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            thumbnailUrl = '';
            if (hiddenField) hiddenField.value = '';
            if (preview) preview.classList.add('hidden');
            if (placeholder) placeholder.classList.remove('hidden');
            if (removeBtn) removeBtn.classList.add('hidden');
            hasUnsavedChanges = true;
            updateSaveStatus('unsaved');
          });
        }
      }
      
      function handleThumbnailUpload(file) {
        const formData = new FormData();
        formData.append('file', file);
        
        fetch('/api/upload', {
          method: 'POST',
          body: formData
        })
        .then(res => res.json())
        .then(data => {
          if (data.success && data.url) {
            thumbnailUrl = data.url;
            const hiddenField = document.getElementById('field-thumbnail');
            if (hiddenField) hiddenField.value = data.url;
            const preview = document.getElementById('thumbnail-preview');
            const placeholder = document.getElementById('thumbnail-placeholder');
            const thumbnailImg = document.getElementById('thumbnail-img');
            const removeBtn = document.getElementById('thumbnail-remove');
            if (preview) preview.classList.remove('hidden');
            if (placeholder) placeholder.classList.add('hidden');
            if (thumbnailImg) thumbnailImg.src = data.url;
            if (removeBtn) removeBtn.classList.remove('hidden');
            hasUnsavedChanges = true;
            updateSaveStatus('unsaved');
          } else {
            alert('썸네일 업로드 실패: ' + (data.error || '알 수 없는 오류'));
          }
        })
        .catch(err => {
          alert('썸네일 업로드 중 오류가 발생했습니다.');
        });
      }
      
      function getThumbnailUrl() {
        return thumbnailUrl;
      }
      
      // 초기화
      document.addEventListener('DOMContentLoaded', function() {
        initTags();
        initThumbnail();
      });
    </script>
  `
  
  return c.html(
    renderLayoutWithContext(c, content, 'HowTo 가이드 작성 - Careerwiki', '새 가이드를 작성합니다')
  )
})

// ============================================================================
// HowTo 초안 편집 페이지 (GET /draft/:id)
// ============================================================================
// HowTo 초안 편집 페이지
howtoRoutes.get('/draft/:id', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=' + encodeURIComponent(c.req.path))
  }
  
  const draftId = parseInt(c.req.param('id'))
  if (!Number.isFinite(draftId)) {
    return c.redirect('/howto')
  }
  
  // 초안 조회
  const { getDraft } = await import('../services/draftService')
  const draftResult = await getDraft(c.env.DB, draftId, user.id)
  
  if (!draftResult.success) {
    const content = `
      <div class="max-w-2xl mx-auto px-4 py-16 text-center">
        <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-amber-500/10 mb-6">
          <i class="fas fa-file-alt text-3xl text-amber-400"></i>
        </div>
        <h1 class="text-2xl font-bold text-white mb-2">초안을 찾을 수 없습니다</h1>
        <p class="text-wiki-muted mb-6">삭제되었거나 접근 권한이 없습니다.</p>
        <a href="/howto/write" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
          새 글 작성
        </a>
      </div>
    `
    return c.html(renderLayoutWithContext(c, content, '초안 없음 - Careerwiki', ''))
  }
  
  const draft = draftResult.draft!
  
  // 발행 이력 확인 (published_page_id가 있는지)
  const publishedPageInfo = await c.env.DB.prepare(`
    SELECT published_page_id, 
           (SELECT slug FROM pages WHERE id = published_page_id) as published_slug,
           (SELECT status FROM pages WHERE id = published_page_id) as page_status
    FROM howto_drafts WHERE id = ?
  `).bind(draftId).first<{ published_page_id: number | null; published_slug: string | null; page_status: string | null }>()
  
  const hasPublishedVersion = !!publishedPageInfo?.published_page_id
  const pageStatus = publishedPageInfo?.page_status || ''
  const isPublished = pageStatus === 'published'
  const isDraftPublished = pageStatus === 'draft_published'
  const publishedSlug = publishedPageInfo?.published_slug || ''
  
  const content = `
    <!-- Tiptap CDN -->
    <link rel="stylesheet" href="/static/howto-editor.css">
    
    <div class="max-w-6xl mx-auto px-3 sm:px-4 py-4 sm:py-6">
      <!-- 헤더 -->
      <header class="mb-6">
        <!-- 상단: 뒤로가기 + 제목 + 삭제 -->
        <div class="flex items-center gap-3 mb-3">
          <a href="/howto" class="flex items-center justify-center w-10 h-10 min-w-[44px] min-h-[44px] text-wiki-muted hover:text-white hover:bg-wiki-border/30 rounded-xl transition shrink-0">
            <i class="fas fa-arrow-left text-lg"></i>
          </a>
          <div class="min-w-0 flex-1">
            <h1 class="text-xl sm:text-2xl font-bold text-white leading-tight">${hasPublishedVersion ? '가이드 편집' : '가이드 작성'}</h1>
            <p class="text-xs sm:text-sm text-wiki-muted mt-0.5" id="save-status">
              <span class="text-amber-400">●</span> 저장되지 않음
            </p>
          </div>
          <button type="button" id="btn-delete" class="shrink-0 w-10 h-10 sm:w-auto sm:h-auto sm:px-3 sm:py-2 flex items-center justify-center text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-xl transition" title="삭제">
            <i class="fas fa-trash-alt sm:mr-1.5"></i>
            <span class="hidden sm:inline text-sm">삭제</span>
          </button>
        </div>
        
        <!-- 하단: 액션 버튼 -->
        <div class="flex items-center gap-2 sm:gap-3">
          <button type="button" id="btn-save" class="flex-1 sm:flex-none px-4 py-2.5 min-h-[44px] border border-wiki-border/60 text-wiki-muted hover:text-white hover:bg-wiki-border/20 rounded-xl transition text-sm font-medium flex items-center justify-center gap-2">
            <i class="fas fa-save"></i>
            <span>임시저장</span>
          </button>
          ${isPublished ? `
            <button type="button" id="btn-update" class="flex-1 sm:flex-none px-4 sm:px-5 py-2.5 min-h-[44px] bg-gradient-to-r from-emerald-500 to-teal-500 hover:from-emerald-500/90 hover:to-teal-500/90 text-white rounded-xl transition text-sm font-medium flex items-center justify-center gap-2 shadow-lg shadow-emerald-500/20">
              <i class="fas fa-sync-alt"></i>
              <span>업데이트</span>
            </button>
          ` : `
            <button type="button" id="btn-publish" class="flex-1 sm:flex-none px-4 sm:px-5 py-2.5 min-h-[44px] bg-gradient-to-r from-wiki-primary to-blue-500 hover:from-wiki-primary/90 hover:to-blue-500/90 text-white rounded-xl transition text-sm font-medium flex items-center justify-center gap-2 shadow-lg shadow-wiki-primary/20">
              <i class="fas fa-paper-plane"></i>
              <span>발행하기</span>
            </button>
          `}
        </div>
      </header>
      
      <!-- 메타 필드 -->
      <div class="grid gap-4 mb-6">
        <!-- 제목 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">제목 *</label>
          <div class="relative">
            <input type="text" id="field-title" maxlength="100"
                   class="w-full px-4 py-3 pr-10 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white text-lg font-semibold placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                   placeholder="가이드 제목을 입력하세요"
                   value="${escapeHtml(draft.title || '')}" />
            <span id="title-check" class="absolute right-3 top-1/2 -translate-y-1/2 text-lg" style="display:none">
              <i class="fas fa-spinner fa-spin text-wiki-muted" id="title-loading"></i>
              <i class="fas fa-check-circle text-green-500" id="title-ok" style="display:none"></i>
              <i class="fas fa-times-circle text-red-500" id="title-error" style="display:none"></i>
            </span>
          </div>
          <p id="title-error-msg" class="mt-1 text-xs text-red-400" style="display:none"></p>
        </div>
        
        <!-- 요약 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">요약</label>
          <textarea id="field-summary" maxlength="300" rows="2"
                    class="w-full px-4 py-3 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition resize-none"
                    placeholder="이 가이드가 어떤 내용을 다루는지 간략히 설명해주세요">${escapeHtml(draft.summary || '')}</textarea>
        </div>
        
        <!-- 썸네일 -->
        <div>
          <label class="block text-sm font-medium text-wiki-text mb-2">썸네일 <span class="text-wiki-muted font-normal">(선택)</span></label>
          <div id="thumbnail-upload-area" class="border-2 border-dashed border-wiki-border/40 rounded-xl p-4 text-center hover:border-wiki-primary/50 transition cursor-pointer">
            <div id="thumbnail-placeholder" class="${(draft as any).thumbnailUrl ? 'hidden' : ''} space-y-2">
              <i class="fas fa-image text-3xl text-wiki-muted"></i>
              <p class="text-sm text-wiki-muted">클릭하여 이미지 업로드 또는 드래그 앤 드롭</p>
              <p class="text-xs text-wiki-muted/60">없으면 본문의 첫 번째 이미지가 자동으로 사용됩니다</p>
            </div>
            <div id="thumbnail-preview" class="${(draft as any).thumbnailUrl ? '' : 'hidden'}">
              <img id="thumbnail-img" src="${escapeHtml((draft as any).thumbnailUrl || '')}" alt="썸네일 미리보기" class="max-h-48 mx-auto rounded-lg" />
              <button type="button" id="thumbnail-remove" class="mt-2 text-sm text-red-400 hover:text-red-300">
                <i class="fas fa-times mr-1"></i>썸네일 제거
              </button>
            </div>
          </div>
          <input type="file" id="thumbnail-input" accept="image/*" class="hidden" />
          <input type="hidden" id="field-thumbnail" value="${escapeHtml((draft as any).thumbnailUrl || '')}" />
        </div>
        
        <!-- 태그 & 관련 콘텐츠 -->
        <div class="grid md:grid-cols-2 gap-4">
          <!-- 태그 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">태그</label>
            <div class="relative">
              <input type="text" id="field-tags"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="태그 입력 후 Enter 또는 쉼표(,)"
                     data-tags='${escapeHtml(JSON.stringify(draft.tags || []))}' />
              <div id="tags-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
          
          <!-- 관련 직업 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 직업</label>
            <div class="relative">
              <input type="text" id="field-jobs" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="직업 검색..."
                     data-items='${escapeHtml(JSON.stringify(draft.relatedJobs || []))}' />
              <div id="jobs-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="jobs-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
        </div>
        
        <div class="grid md:grid-cols-2 gap-4">
          <!-- 관련 전공 -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 전공</label>
            <div class="relative">
              <input type="text" id="field-majors" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="전공 검색..."
                     data-items='${escapeHtml(JSON.stringify(draft.relatedMajors || []))}' />
              <div id="majors-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="majors-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
          
          <!-- 관련 HowTo -->
          <div>
            <label class="block text-sm font-medium text-wiki-text mb-2">관련 HowTo</label>
            <div class="relative">
              <input type="text" id="field-howtos" autocomplete="off"
                     class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/40 rounded-xl text-white placeholder-wiki-muted focus:border-wiki-primary outline-none transition"
                     placeholder="HowTo 검색..."
                     data-items='${escapeHtml(JSON.stringify(draft.relatedHowtos || []))}' />
              <div id="howtos-dropdown" class="absolute top-full left-0 right-0 mt-1 bg-wiki-bg border border-wiki-border/60 rounded-lg shadow-xl z-50 hidden max-h-48 overflow-y-auto" tabindex="-1"></div>
              <div id="howtos-container" class="flex flex-wrap gap-2 mt-2"></div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 본문 영역 -->
      <div>
        <label class="block text-sm font-medium text-wiki-text mb-2">본문 *</label>
        
        <!-- 에디터 툴바 -->
        <div id="toolbar" class="howto-editor-toolbar bg-wiki-card/50 border border-wiki-border/40 rounded-t-xl px-3 py-2">
          <div class="toolbar-group">
            <button type="button" data-action="bold" title="굵게 (Ctrl+B)"><i class="fas fa-bold"></i></button>
            <button type="button" data-action="italic" title="기울임 (Ctrl+I)"><i class="fas fa-italic"></i></button>
            <button type="button" data-action="underline" title="밑줄 (Ctrl+U)"><i class="fas fa-underline"></i></button>
            <button type="button" data-action="strike" title="취소선"><i class="fas fa-strikethrough"></i></button>
          </div>
          <div class="toolbar-group">
            <!-- 폰트 -->
            <div class="toolbar-dropdown font-dropdown">
              <button type="button" title="폰트" class="toolbar-btn flex items-center gap-1.5"><span class="current-font-name">기본</span><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="font-menu hidden">
                <button type="button" data-font="inherit" class="is-active">기본</button>
                <button type="button" data-font="sans-serif">Sans-serif (샌즈)</button>
                <button type="button" data-font="serif">Serif (세리프)</button>
                <button type="button" data-font="monospace">Monospace (코드)</button>
                <button type="button" data-font="'Nanum Gothic', sans-serif">나눔고딕</button>
                <button type="button" data-font="'Nanum Myeongjo', serif">나눔명조</button>
              </div>
            </div>
            <!-- 폰트 크기 -->
            <div class="toolbar-dropdown size-dropdown">
              <button type="button" title="글자 크기" class="toolbar-btn size-input-btn">
                <input type="number" class="size-input" value="15" min="6" max="72" title="글자 크기 (px)">
                <i class="fas fa-chevron-down text-[10px] opacity-60"></i>
              </button>
              <div class="size-menu hidden">
                <button type="button" data-size="8px">8</button>
                <button type="button" data-size="12px">12</button>
                <button type="button" data-size="14px">14</button>
                <button type="button" data-size="15px" class="is-default">15</button>
                <button type="button" data-size="16px">16</button>
                <button type="button" data-size="18px">18</button>
                <button type="button" data-size="20px">20</button>
                <button type="button" data-size="24px">24</button>
                <button type="button" data-size="28px">28</button>
                <button type="button" data-size="32px">32</button>
                <button type="button" data-size="36px">36</button>
              </div>
            </div>
            <!-- 폰트 색상 -->
            <div class="toolbar-dropdown color-dropdown">
              <button type="button" title="글자 색상" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-palette"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="color-menu hidden">
                <div class="color-grid">
                  <button type="button" data-color="#ffffff" style="background:#ffffff" title="흰색"></button>
                  <button type="button" data-color="#f59e0b" style="background:#f59e0b" title="주황"></button>
                  <button type="button" data-color="#ef4444" style="background:#ef4444" title="빨강"></button>
                  <button type="button" data-color="#22c55e" style="background:#22c55e" title="초록"></button>
                  <button type="button" data-color="#3b82f6" style="background:#3b82f6" title="파랑"></button>
                  <button type="button" data-color="#8b5cf6" style="background:#8b5cf6" title="보라"></button>
                  <button type="button" data-color="#ec4899" style="background:#ec4899" title="분홍"></button>
                  <button type="button" data-color="#6b7280" style="background:#6b7280" title="회색"></button>
                </div>
                <button type="button" data-color="" class="color-reset">기본 색상</button>
              </div>
            </div>
          </div>
          <div class="toolbar-group">
            <!-- 정렬 -->
            <div class="toolbar-dropdown align-dropdown">
              <button type="button" title="정렬" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-align-left"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="align-menu hidden">
                <button type="button" data-action="alignLeft"><i class="fas fa-align-left"></i> 왼쪽</button>
                <button type="button" data-action="alignCenter"><i class="fas fa-align-center"></i> 중앙</button>
                <button type="button" data-action="alignRight"><i class="fas fa-align-right"></i> 오른쪽</button>
              </div>
            </div>
            <!-- 커스텀 블록 -->
            <div class="toolbar-dropdown custom-block-dropdown">
              <button type="button" title="커스텀 블록" class="toolbar-btn flex items-center gap-1.5"><i class="fas fa-cube"></i><i class="fas fa-chevron-down text-[10px] opacity-60"></i></button>
              <div class="toolbar-dropdown-content custom-block-menu hidden">
                <button type="button" data-action="blockquote"><i class="fas fa-quote-left text-sky-400"></i> 인용구</button>
                <button type="button" data-action="horizontalRule"><i class="fas fa-minus text-purple-400"></i> 구분선</button>
                <button type="button" data-action="checkpointBox"><i class="fas fa-check-circle text-green-500"></i> 체크포인트</button>
                <button type="button" data-action="conclusionBox"><i class="fas fa-lightbulb text-wiki-primary"></i> 결론 박스</button>
                <button type="button" data-action="qnaBlock"><i class="fas fa-question-circle text-amber-500"></i> Q&A</button>
              </div>
            </div>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="h1" title="제목 1">H1</button>
            <button type="button" data-action="h2" title="제목 2">H2</button>
            <button type="button" data-action="h3" title="제목 3">H3</button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="bulletList" title="글머리 기호"><i class="fas fa-list-ul"></i></button>
            <button type="button" data-action="orderedList" title="번호 매기기"><i class="fas fa-list-ol"></i></button>
            <button type="button" data-action="taskList" title="체크리스트"><i class="fas fa-tasks"></i></button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="link" title="외부 링크"><i class="fas fa-link"></i></button>
            <button type="button" data-action="internalLink" title="내부 링크 (직업/전공/HowTo)"><i class="fas fa-sitemap"></i></button>
            <button type="button" data-action="footnote" title="각주 (출처)"><i class="fas fa-asterisk"></i></button>
            <button type="button" data-action="image" title="이미지"><i class="fas fa-image"></i></button>
            <button type="button" data-action="table" title="표"><i class="fas fa-table"></i></button>
            <button type="button" data-action="codeBlock" title="코드 블록"><i class="fas fa-code"></i></button>
          </div>
          <div class="toolbar-group">
            <button type="button" data-action="undo" title="실행 취소 (Ctrl+Z)"><i class="fas fa-undo"></i></button>
            <button type="button" data-action="redo" title="다시 실행 (Ctrl+Y)"><i class="fas fa-redo"></i></button>
          </div>
        </div>
        
        <!-- 표 편집 툴바 (압축형) -->
        <div id="table-toolbar" class="table-toolbar">
          <div class="toolbar-dropdown row-dropdown">
            <button type="button" title="행 추가" class="toolbar-btn"><i class="fas fa-plus"></i> 행</button>
            <div class="row-menu hidden">
              <button type="button" data-action="addRowBefore"><i class="fas fa-arrow-up"></i> 위에 추가</button>
              <button type="button" data-action="addRowAfter"><i class="fas fa-arrow-down"></i> 아래에 추가</button>
            </div>
          </div>
          <div class="toolbar-dropdown col-dropdown">
            <button type="button" title="열 추가" class="toolbar-btn"><i class="fas fa-plus"></i> 열</button>
            <div class="col-menu hidden">
              <button type="button" data-action="addColBefore"><i class="fas fa-arrow-left"></i> 왼쪽에 추가</button>
              <button type="button" data-action="addColAfter"><i class="fas fa-arrow-right"></i> 오른쪽에 추가</button>
            </div>
          </div>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="deleteRow" title="행 삭제"><i class="fas fa-trash-alt"></i></button>
          <button type="button" data-action="deleteCol" title="열 삭제"><i class="fas fa-columns"></i></button>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="mergeCells" title="셀 병합"><i class="fas fa-compress-alt"></i></button>
          <button type="button" data-action="splitCell" title="셀 분할"><i class="fas fa-expand-alt"></i></button>
          <!-- 셀 배경색 -->
          <span class="toolbar-divider"></span>
          <div class="toolbar-dropdown cell-color-dropdown">
            <button type="button" title="셀 배경색" class="toolbar-btn"><i class="fas fa-fill-drip"></i></button>
            <div class="cell-color-menu hidden">
              <div class="color-grid">
                <button type="button" data-cell-bg="" style="background:transparent;border:1px dashed #666" title="없음"></button>
                <button type="button" data-cell-bg="rgba(79,143,255,0.15)" style="background:rgba(79,143,255,0.4)" title="파랑"></button>
                <button type="button" data-cell-bg="rgba(34,197,94,0.15)" style="background:rgba(34,197,94,0.4)" title="초록"></button>
                <button type="button" data-cell-bg="rgba(245,158,11,0.15)" style="background:rgba(245,158,11,0.4)" title="주황"></button>
                <button type="button" data-cell-bg="rgba(239,68,68,0.15)" style="background:rgba(239,68,68,0.4)" title="빨강"></button>
                <button type="button" data-cell-bg="rgba(139,92,246,0.15)" style="background:rgba(139,92,246,0.4)" title="보라"></button>
              </div>
            </div>
          </div>
          <span class="toolbar-divider"></span>
          <button type="button" data-action="deleteTable" title="표 삭제" class="text-red-400"><i class="fas fa-times"></i></button>
        </div>
        
        <!-- 에디터 본문 (Tiptap 마운트) -->
        <div id="editor" class="howto-editor-content bg-wiki-card/50 border border-wiki-border/40 border-t-0 rounded-b-xl"></div>
      </div>
      
      <!-- 출처 섹션 -->
      <div id="footnotes-section" class="editor-footnotes-section">
        <h4><i class="fas fa-book-open"></i> 출처</h4>
        <div id="footnotes-list" class="editor-footnotes-list">
          <div class="editor-footnotes-empty">
            <i class="fas fa-quote-right"></i>
            <p>각주를 추가하면 여기에 출처가 표시됩니다.</p>
          </div>
        </div>
      </div>
      
      <!-- 메시지 -->
      <div id="editor-message" class="hidden mt-4"></div>
    </div>
    
    <!-- 충돌 다이얼로그 -->
    <div id="conflict-dialog" class="hidden">
      <div class="backdrop"></div>
      <div class="content">
        <h3 class="text-lg font-semibold text-white mb-4">버전 충돌 발생</h3>
        <p class="text-wiki-muted mb-4">
          다른 곳에서 이 초안이 수정되었습니다.<br>
          서버 버전: <span data-server-version>-</span> / 내 버전: <span data-local-version>-</span>
        </p>
        <div class="flex gap-3">
          <button type="button" id="conflict-reload" class="flex-1 px-4 py-2 bg-wiki-primary text-white rounded-lg">
            서버 버전 불러오기
          </button>
          <button type="button" id="conflict-overwrite" class="flex-1 px-4 py-2 border border-wiki-border text-wiki-muted rounded-lg">
            내 버전으로 덮어쓰기
          </button>
        </div>
      </div>
    </div>
    
    <!-- Tiptap 에디터 번들 -->
    <script src="/static/editor.bundle.iife.js"></script>
    
    <script>
      // 에디터 데이터
      const DRAFT_ID = ${draftId};
      const DRAFT_VERSION = ${draft.version};
      const PAGE_STATUS = '${pageStatus}';
      const IS_PUBLISHED = ${isPublished};
      const HAS_PUBLISHED_VERSION = ${hasPublishedVersion};
      const PUBLISHED_PAGE_ID = ${publishedPageInfo?.published_page_id || 'null'};
      // contentJson이 있으면 JSON으로, 없으면 HTML로 초기화
      const CONTENT_JSON_RAW = ${JSON.stringify(draft.contentJson || null)};
      const CONTENT_JSON = (CONTENT_JSON_RAW && CONTENT_JSON_RAW.length > 10 && CONTENT_JSON_RAW !== '{}') ? JSON.parse(CONTENT_JSON_RAW) : null;
      const CONTENT_HTML = ${JSON.stringify(draft.contentHtml || '<p></p>')};
      const INITIAL_CONTENT = CONTENT_JSON || CONTENT_HTML;
      let currentVersion = DRAFT_VERSION;
      let hasUnsavedChanges = false;
      let tiptapEditor = null;  // Tiptap 에디터 인스턴스
      
      // 페이지 나가기 경고
      const beforeUnloadHandler = (e) => {
        if (hasUnsavedChanges) {
          e.preventDefault();
          e.returnValue = '저장하지 않은 변경사항이 있습니다. 정말 나가시겠습니까?';
          return e.returnValue;
        }
      };
      window.addEventListener('beforeunload', beforeUnloadHandler);
      
      // 에디터 초기화
      document.addEventListener('DOMContentLoaded', async () => {
        // Tiptap 에디터 초기화
        if (window.HowToEditor) {
          tiptapEditor = new window.HowToEditor({
            container: '#editor',
            draftId: DRAFT_ID,
            version: DRAFT_VERSION,
            initialContent: INITIAL_CONTENT,
            onSave: (data) => {
              if (data.success) {
                currentVersion = data.version;
                hasUnsavedChanges = false;
                updateSaveStatus('saved');
              }
            },
            onError: (err) => {
              showMessage('error', err.message);
              updateSaveStatus('error');
            },
            onUpdate: () => {
              hasUnsavedChanges = true;
              updateSaveStatus('unsaved');
            }
          });
          window.HowToEditorInstance = tiptapEditor;
        } else {
        }
        
        // 자동완성 초기화
        initAutocomplete();
        
        // 태그 초기화
        initTags();
        
        // 썸네일 초기화
        initThumbnail();
        
        // 제목 중복 체크 초기화
        initTitleCheck();
        
        // 툴바 드롭다운 설정
        function setupToolbarDropdowns() {
          const menuSelector = '.align-menu, .font-menu, .custom-block-menu, .color-menu, .size-menu, .row-menu, .col-menu, .cell-color-menu, .border-style-menu';
          
          document.querySelectorAll('.toolbar-dropdown').forEach(dropdown => {
            const btn = dropdown.querySelector('.toolbar-btn');
            const menu = dropdown.querySelector(menuSelector);
            if (!btn || !menu) return;
            
            let isOpen = false;
            let hoverTimeout = null;
            
            btn.addEventListener('click', (e) => {
              e.stopPropagation();
              isOpen = !isOpen;
              dropdown.classList.toggle('is-open', isOpen);
              if (isOpen) {
                menu.classList.remove('hidden');
                document.querySelectorAll('.toolbar-dropdown').forEach(other => {
                  if (other !== dropdown) {
                    other.classList.remove('is-open');
                    const otherMenu = other.querySelector(menuSelector);
                    if (otherMenu) otherMenu.classList.add('hidden');
                  }
                });
              } else {
                menu.classList.add('hidden');
              }
            });
            
            dropdown.addEventListener('mouseenter', () => {
              clearTimeout(hoverTimeout);
              menu.classList.remove('hidden');
            });
            
            dropdown.addEventListener('mouseleave', () => {
              if (!isOpen) {
                hoverTimeout = setTimeout(() => {
                  menu.classList.add('hidden');
                }, 300);
              }
            });
            
            menu.addEventListener('click', (e) => {
              if (e.target.closest('button')) {
                isOpen = false;
                dropdown.classList.remove('is-open');
                setTimeout(() => menu.classList.add('hidden'), 100);
              }
            });
          });
          
          document.addEventListener('click', (e) => {
            if (!e.target.closest('.toolbar-dropdown')) {
              document.querySelectorAll('.toolbar-dropdown').forEach(dropdown => {
                dropdown.classList.remove('is-open');
                const menu = dropdown.querySelector(menuSelector);
                if (menu) menu.classList.add('hidden');
              });
            }
          });
        }
        
        // 툴바 드롭다운 초기화
        setupToolbarDropdowns();
        
        // 저장 버튼
        document.getElementById('btn-save').addEventListener('click', async () => {
          await saveDraft();
        });
        
        // 발행 버튼 (임시 발행 → 정식 발행)
        document.getElementById('btn-publish')?.addEventListener('click', async () => {
          await publishFromDraft();
        });
        
        // 업데이트 버튼 (발행된 페이지 업데이트)
        document.getElementById('btn-update')?.addEventListener('click', async () => {
          await updatePublished();
        });
        
        // 삭제 버튼
        document.getElementById('btn-delete')?.addEventListener('click', async () => {
          const title = document.getElementById('field-title')?.value || '제목 없음';
          const confirmMsg = HAS_PUBLISHED_VERSION && PUBLISHED_PAGE_ID
            ? '정말 "' + title + '" 가이드를 삭제하시겠습니까?\\n삭제된 가이드는 복구할 수 없습니다.'
            : '정말 "' + title + '" 초안을 삭제하시겠습니까?\\n삭제된 초안은 복구할 수 없습니다.';
          
          if (!confirm(confirmMsg)) {
            return;
          }
          
          const btn = document.getElementById('btn-delete');
          const originalHtml = btn.innerHTML;
          btn.disabled = true;
          btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>삭제 중...';
          
          try {
            // 발행된 페이지가 있으면 페이지 삭제 API, 없으면 초안 삭제 API 호출
            const deleteUrl = HAS_PUBLISHED_VERSION && PUBLISHED_PAGE_ID
              ? '/api/howto/' + PUBLISHED_PAGE_ID
              : '/api/howto/drafts/' + DRAFT_ID;
            
            const response = await fetch(deleteUrl, {
              method: 'DELETE',
              credentials: 'include'
            });
            
            const result = await response.json();
            
            if (result.success) {
              alert('삭제되었습니다.');
              window.location.href = '/howto/my-drafts';
            } else {
              alert('삭제 실패: ' + (result.error || '알 수 없는 오류'));
              btn.disabled = false;
              btn.innerHTML = originalHtml;
            }
          } catch (err) {
            alert('삭제 중 오류가 발생했습니다.');
            btn.disabled = false;
            btn.innerHTML = originalHtml;
          }
        });
        
        // 커스텀 블록 드롭다운 (호버/클릭 제어)
        document.querySelectorAll('.custom-block-dropdown').forEach(dropdown => {
          const btn = dropdown.querySelector('.toolbar-btn');
          const menu = dropdown.querySelector('.custom-block-menu');
          if (!btn || !menu) return;
          
          let isOpen = false;
          let hoverTimeout = null;
          
          // 호버 시 표시
          dropdown.addEventListener('mouseenter', () => {
            if (!isOpen) {
              clearTimeout(hoverTimeout);
              menu.classList.remove('hidden');
            }
          });
          
          // 호버 아웃 시 숨김 (열려있지 않을 때만)
          dropdown.addEventListener('mouseleave', () => {
            if (!isOpen) {
              hoverTimeout = setTimeout(() => {
                menu.classList.add('hidden');
              }, 200);
            }
          });
          
          // 클릭 시 토글
          btn.addEventListener('click', (e) => {
            e.stopPropagation();
            isOpen = !isOpen;
            if (isOpen) {
              menu.classList.remove('hidden');
            } else {
              menu.classList.add('hidden');
            }
          });
          
          // 메뉴 아이템 클릭 시 닫기
          menu.querySelectorAll('button').forEach(item => {
            item.addEventListener('click', () => {
              isOpen = false;
              menu.classList.add('hidden');
            });
          });
        });
        
        // 외부 클릭 시 모든 드롭다운 닫기
        document.addEventListener('click', (e) => {
          if (!e.target.closest('.custom-block-dropdown')) {
            document.querySelectorAll('.custom-block-dropdown').forEach(dropdown => {
              const menu = dropdown.querySelector('.custom-block-menu');
              if (menu) menu.classList.add('hidden');
            });
          }
          if (!e.target.closest('.align-dropdown')) {
            document.querySelectorAll('.align-menu').forEach(m => m.classList.add('hidden'));
          }
          if (!e.target.closest('.font-dropdown')) {
            document.querySelectorAll('.font-menu').forEach(m => m.classList.add('hidden'));
          }
        });
        
        // 정렬 드롭다운 제어
        document.querySelectorAll('.align-dropdown').forEach(dropdown => {
          const btn = dropdown.querySelector('.toolbar-btn');
          const menu = dropdown.querySelector('.align-menu');
          if (!btn || !menu) return;
          
          btn.addEventListener('click', (e) => {
            e.stopPropagation();
            menu.classList.toggle('hidden');
            menu.classList.toggle('visible');
          });
          
          menu.querySelectorAll('button').forEach(item => {
            item.addEventListener('click', () => {
              menu.classList.add('hidden');
              menu.classList.remove('visible');
            });
          });
        });
        
        // 폰트/크기 관련 이벤트는 에디터에서 처리
        // 드롭다운 열기/닫기만 처리
        document.querySelectorAll('.font-dropdown').forEach(dropdown => {
          const btn = dropdown.querySelector('.toolbar-btn');
          const menu = dropdown.querySelector('.font-menu');
          if (!btn || !menu) return;
          
          btn.addEventListener('click', (e) => {
            e.stopPropagation();
            menu.classList.toggle('hidden');
            menu.classList.toggle('visible');
          });
          
          menu.querySelectorAll('button').forEach(item => {
            item.addEventListener('click', () => {
              menu.classList.add('hidden');
              menu.classList.remove('visible');
            });
          });
        });
        
        // 표 툴바 제어 (표 안에 커서 있을 때만 표시)
        const tableToolbar = document.getElementById('table-toolbar');
        if (tableToolbar && tiptapEditor) {
          // 에디터 선택 변경 시 표 상태 확인
          const checkTableState = () => {
            if (tiptapEditor.isInTable && tiptapEditor.isInTable()) {
              tableToolbar.classList.add('visible');
            } else {
              tableToolbar.classList.remove('visible');
            }
          };
          
          // 주기적 확인 (더 나은 방법은 에디터 이벤트 사용)
          document.getElementById('editor').addEventListener('click', checkTableState);
          document.getElementById('editor').addEventListener('keyup', checkTableState);
          
          // 표 툴바 버튼 이벤트
          tableToolbar.querySelectorAll('[data-action]').forEach(btn => {
            btn.addEventListener('click', () => {
              const action = btn.dataset.action;
              if (tiptapEditor && typeof tiptapEditor.executeToolbarAction === 'function') {
                tiptapEditor.executeToolbarAction(action);
              }
            });
          });
        }
        
        // 각주 목록 업데이트 이벤트 수신
        window.addEventListener('footnotes-updated', (e) => {
          const footnotes = e.detail.footnotes || [];
          const container = document.getElementById('footnotes-list');
          if (!container) return;
          
          if (footnotes.length === 0) {
            container.innerHTML = '<div class="editor-footnotes-empty"><i class="fas fa-quote-right"></i><p>각주를 추가하면 여기에 출처가 표시됩니다.</p></div>';
          } else {
            container.innerHTML = footnotes.map(function(f) {
              var urlHtml = f.url ? '<a href="' + escapeHtml(f.url) + '" target="_blank" class="editor-footnote-url">' + escapeHtml(f.url) + '</a>' : '';
              return '<div class="editor-footnote-item" data-id="' + f.id + '">' +
                '<span class="editor-footnote-id">' + f.id + '</span>' +
                '<div class="editor-footnote-content">' +
                  '<div class="editor-footnote-text">' + escapeHtml(f.text) + '</div>' +
                  urlHtml +
                '</div>' +
                '<div class="editor-footnote-actions">' +
                  '<button type="button" class="btn-edit" data-id="' + f.id + '" title="편집"><i class="fas fa-edit"></i></button>' +
                  '<button type="button" class="btn-delete" data-id="' + f.id + '" title="삭제"><i class="fas fa-trash"></i></button>' +
                '</div>' +
              '</div>';
            }).join('');
            
            // 편집/삭제 버튼 이벤트
            container.querySelectorAll('.btn-edit').forEach(btn => {
              btn.addEventListener('click', () => {
                const id = parseInt(btn.dataset.id);
                const f = footnotes.find(x => x.id === id);
                if (f && tiptapEditor && typeof tiptapEditor.showFootnoteModal === 'function') {
                  tiptapEditor.showFootnoteModal(id, f.text, f.url);
                }
              });
            });
            
            container.querySelectorAll('.btn-delete').forEach(btn => {
              btn.addEventListener('click', () => {
                const id = parseInt(btn.dataset.id);
                if (confirm('이 각주를 삭제하시겠습니까?') && tiptapEditor && typeof tiptapEditor.deleteFootnote === 'function') {
                  tiptapEditor.deleteFootnote(id);
                }
              });
            });
          }
        });
        
        // 요약 변경 추적
        document.getElementById('field-summary').addEventListener('input', () => {
          hasUnsavedChanges = true;
          updateSaveStatus('unsaved');
        });
      });
      
      // 제목 중복 체크 상태
      let titleCheckTimer = null;
      let titleCheckAbort = null;
      let isTitleAvailable = true;
      const EXCLUDE_PAGE_ID = HAS_PUBLISHED_VERSION ? PUBLISHED_PAGE_ID : null;

      function initTitleCheck() {
        const titleInput = document.getElementById('field-title');
        const titleCheck = document.getElementById('title-check');
        const titleLoading = document.getElementById('title-loading');
        const titleOk = document.getElementById('title-ok');
        const titleError = document.getElementById('title-error');
        const titleErrorMsg = document.getElementById('title-error-msg');

        if (!titleInput) return;

        // style.display 사용 (FA 아이콘에 hidden 클래스가 작동하지 않음)
        function show(el) { if (el) el.style.display = ''; }
        function hide(el) { if (el) el.style.display = 'none'; }

        titleInput.addEventListener('input', () => {
          hasUnsavedChanges = true;
          updateSaveStatus('unsaved');

          clearTimeout(titleCheckTimer);
          if (titleCheckAbort) { titleCheckAbort.abort(); titleCheckAbort = null; }
          const title = titleInput.value.trim();

          // 빈 값이면 숨김
          if (!title) {
            hide(titleCheck);
            hide(titleErrorMsg);
            isTitleAvailable = true;
            return;
          }

          // 2자 미만이면 바로 에러
          if (title.length < 2) {
            show(titleCheck);
            hide(titleLoading);
            hide(titleOk);
            show(titleError);
            titleErrorMsg.textContent = '제목은 최소 2자 이상이어야 합니다';
            show(titleErrorMsg);
            isTitleAvailable = false;
            return;
          }

          // 로딩 표시
          show(titleCheck);
          show(titleLoading);
          hide(titleOk);
          hide(titleError);
          hide(titleErrorMsg);

          // 500ms 후 API 호출
          titleCheckTimer = setTimeout(async () => {
            const ac = new AbortController();
            titleCheckAbort = ac;
            const timeout = setTimeout(() => ac.abort(), 8000);
            try {
              let url = '/api/howto/check-title?title=' + encodeURIComponent(title);
              if (EXCLUDE_PAGE_ID) {
                url += '&excludeId=' + EXCLUDE_PAGE_ID;
              }
              const res = await fetch(url, { signal: ac.signal });
              clearTimeout(timeout);
              if (ac.signal.aborted) return;
              const data = await res.json();

              hide(titleLoading);

              if (data.success && data.available) {
                show(titleOk);
                hide(titleError);
                hide(titleErrorMsg);
                isTitleAvailable = true;
              } else {
                hide(titleOk);
                show(titleError);
                titleErrorMsg.textContent = data.reason || '사용할 수 없는 제목입니다';
                show(titleErrorMsg);
                isTitleAvailable = false;
              }
            } catch (err) {
              clearTimeout(timeout);
              if (ac.signal.aborted) {
                if (titleCheckAbort !== ac) return;
              }
              hide(titleLoading);
              hide(titleOk);
              show(titleError);
              titleErrorMsg.textContent = '제목 확인에 실패했습니다. 잠시 후 다시 시도해주세요.';
              show(titleErrorMsg);
              isTitleAvailable = false;
            }
          }, 500);
        });
      }
      
      // 저장 (임시 발행 상태로 저장)
      async function saveDraft() {
        clearAllFieldErrors();
        
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        const contentHtml = tiptapEditor ? tiptapEditor.getHTML() : '';
        const contentJson = tiptapEditor ? JSON.stringify(tiptapEditor.getContent()) : '{}';
        
        // 유효성 검사
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          updateSaveStatus('error');
          return;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          updateSaveStatus('error');
          return;
        }
        
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          updateSaveStatus('error');
          return;
        }
        
        // 발행된 문서를 저장하면 임시 발행 상태로 전환됨을 경고
        if (IS_PUBLISHED) {
          const confirmed = confirm('⚠️ 주의: 이미 발행된 문서입니다.\\n\\n저장하면 임시 발행 상태로 전환되어 비공개 처리됩니다.\\n(목록에서 사라지고 작성자만 볼 수 있게 됩니다)\\n\\n공개 상태를 유지하려면 "업데이트" 버튼을 사용하세요.\\n\\n계속하시겠습니까?');
          if (!confirmed) {
            return;
          }
        }
        
        updateSaveStatus('saving');
        
        // 태그 수집
        const tags = [];
        document.querySelectorAll('#tags-container span').forEach(chip => {
          const text = chip.textContent.replace('×', '').trim();
          if (text) tags.push(text);
        });
        
        // 관련 콘텐츠 수집
        const relatedJobs = getRelatedItems('jobs');
        const relatedMajors = getRelatedItems('majors');
        const relatedHowtos = getRelatedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          // 임시 발행 API 호출 (발행된 문서도 draft_published로 전환)
          const res = await fetch('/api/howto/save-publish', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              draftId: DRAFT_ID,
              title,
              summary,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              contentHtml,
              contentJson,
              thumbnailUrl: thumbnail,
              forceDraftPublished: true  // 항상 draft_published로 저장
            })
          });
          
          const data = await res.json();
          
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '임시 저장되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
          } else {
            updateSaveStatus('error');
            showMessage('error', data.error || '저장 실패');
          }
        } catch (err) {
          updateSaveStatus('error');
          showMessage('error', '네트워크 오류');
        }
      }
      
      // 발행 (draft_published → published)
      async function publishFromDraft() {
        clearAllFieldErrors();
        
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        const contentHtml = tiptapEditor ? tiptapEditor.getHTML() : '';
        const contentJson = tiptapEditor ? JSON.stringify(tiptapEditor.getContent()) : '{}';
        
        // 유효성 검사
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          return;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          return;
        }
        
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          return;
        }
        
        if (!confirm('이 가이드를 정식 발행하시겠습니까?\\n발행 후 HowTo 목록에 공개됩니다.')) {
          return;
        }
        
        updateSaveStatus('saving');
        
        // 태그 수집
        const tags = [];
        document.querySelectorAll('#tags-container span').forEach(chip => {
          const text = chip.textContent.replace('×', '').trim();
          if (text) tags.push(text);
        });
        
        // 관련 콘텐츠 수집
        const relatedJobs = getRelatedItems('jobs');
        const relatedMajors = getRelatedItems('majors');
        const relatedHowtos = getRelatedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          const res = await fetch('/api/howto/publish-direct', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              draftId: DRAFT_ID,
              title,
              summary,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              contentHtml,
              contentJson,
              thumbnailUrl: thumbnail
            })
          });
          
          const data = await res.json();
          
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '발행되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
          } else {
            updateSaveStatus('error');
            showMessage('error', data.error || '발행 실패');
          }
        } catch (err) {
          updateSaveStatus('error');
          showMessage('error', '네트워크 오류');
        }
      }
      
      // 업데이트 (published 페이지 업데이트)
      async function updatePublished() {
        clearAllFieldErrors();
        
        const title = document.getElementById('field-title').value.trim();
        const summary = document.getElementById('field-summary').value.trim();
        const contentHtml = tiptapEditor ? tiptapEditor.getHTML() : '';
        const contentJson = tiptapEditor ? JSON.stringify(tiptapEditor.getContent()) : '{}';
        
        // 유효성 검사
        const titleError = validateTitle(title);
        if (titleError) {
          showFieldError('field-title', titleError);
          showMessage('error', titleError);
          return;
        }
        
        // 제목 중복 체크 결과 확인
        if (!isTitleAvailable) {
          showMessage('error', '이미 같은 제목의 가이드가 존재합니다. 다른 제목을 입력해주세요.');
          document.getElementById('field-title').focus();
          return;
        }
        
        const contentError = validateContent(contentHtml);
        if (contentError) {
          showMessage('error', contentError);
          return;
        }
        
        updateSaveStatus('saving');
        
        // 태그 수집
        const tags = [];
        document.querySelectorAll('#tags-container span').forEach(chip => {
          const text = chip.textContent.replace('×', '').trim();
          if (text) tags.push(text);
        });
        
        // 관련 콘텐츠 수집
        const relatedJobs = getRelatedItems('jobs');
        const relatedMajors = getRelatedItems('majors');
        const relatedHowtos = getRelatedItems('howtos');
        const thumbnail = getThumbnailUrl();
        
        try {
          const res = await fetch('/api/howto/save-publish', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              draftId: DRAFT_ID,
              title,
              summary,
              tags,
              relatedJobs,
              relatedMajors,
              relatedHowtos,
              contentHtml,
              contentJson,
              thumbnailUrl: thumbnail
            })
          });
          
          const data = await res.json();
          
          if (data.success) {
            hasUnsavedChanges = false;
            window.removeEventListener('beforeunload', beforeUnloadHandler);
            window.onbeforeunload = null;
            showMessage('success', '업데이트되었습니다! 잠시 후 이동합니다...');
            setTimeout(() => { window.location.href = '/howto/' + data.slug; }, 100);
          } else {
            updateSaveStatus('error');
            showMessage('error', data.error || '업데이트 실패');
          }
        } catch (err) {
          updateSaveStatus('error');
          showMessage('error', '네트워크 오류');
        }
      }
      
      // 썸네일 업로드
      let thumbnailUrl = document.getElementById('field-thumbnail')?.value || '';
      let thumbnailInitialized = false;
      
      function initThumbnail() {
        if (thumbnailInitialized) return;
        thumbnailInitialized = true;
        
        const uploadArea = document.getElementById('thumbnail-upload-area');
        const fileInput = document.getElementById('thumbnail-input');
        const placeholder = document.getElementById('thumbnail-placeholder');
        const preview = document.getElementById('thumbnail-preview');
        const thumbnailImg = document.getElementById('thumbnail-img');
        const removeBtn = document.getElementById('thumbnail-remove');
        const hiddenField = document.getElementById('field-thumbnail');
        
        if (!uploadArea || !fileInput) return;
        
        // 클릭 시 파일 선택 (이벤트 버블링 방지)
        uploadArea.addEventListener('click', (e) => {
          // fileInput 클릭이나 removeBtn 클릭은 무시
          if (e.target === fileInput || e.target.closest('#thumbnail-remove')) return;
          e.stopPropagation();
          fileInput.click();
        }, { capture: true });
        
        // 드래그 앤 드롭
        uploadArea.addEventListener('dragover', (e) => {
          e.preventDefault();
          uploadArea.classList.add('border-wiki-primary');
        });
        uploadArea.addEventListener('dragleave', () => {
          uploadArea.classList.remove('border-wiki-primary');
        });
        uploadArea.addEventListener('drop', (e) => {
          e.preventDefault();
          uploadArea.classList.remove('border-wiki-primary');
          const file = e.dataTransfer?.files?.[0];
          if (file && file.type.startsWith('image/')) {
            handleThumbnailUpload(file);
          }
        });
        
        // 파일 선택
        fileInput.addEventListener('change', (e) => {
          const file = e.target.files?.[0];
          if (file) {
            handleThumbnailUpload(file);
          }
          // 같은 파일 재선택 가능하도록 value 리셋
          e.target.value = '';
        });
        
        // 썸네일 제거
        removeBtn?.addEventListener('click', (e) => {
          e.stopPropagation();
          thumbnailUrl = '';
          hiddenField.value = '';
          placeholder.classList.remove('hidden');
          preview.classList.add('hidden');
          thumbnailImg.src = '';
          hasUnsavedChanges = true;
        });
      }
      
      async function handleThumbnailUpload(file) {
        const placeholder = document.getElementById('thumbnail-placeholder');
        const preview = document.getElementById('thumbnail-preview');
        const thumbnailImg = document.getElementById('thumbnail-img');
        const hiddenField = document.getElementById('field-thumbnail');
        
        // 파일 크기 체크 (5MB)
        if (file.size > 5 * 1024 * 1024) {
          showMessage('error', '이미지 크기는 5MB 이하여야 합니다.');
          return;
        }
        
        try {
          // 로딩 표시
          placeholder.classList.remove('hidden');
          placeholder.innerHTML = '<i class="fas fa-spinner fa-spin text-3xl text-wiki-primary"></i><p class="text-sm text-wiki-muted">업로드 중...</p>';
          
          // FormData로 업로드
          const formData = new FormData();
          formData.append('file', file);
          
          const res = await fetch('/api/upload', {
            method: 'POST',
            body: formData
          });
          
          const data = await res.json();
          
          if (data.success && data.url) {
            thumbnailUrl = data.url;
            hiddenField.value = data.url;
            thumbnailImg.src = data.url;
            placeholder.classList.add('hidden');
            preview.classList.remove('hidden');
            hasUnsavedChanges = true;
          } else {
            throw new Error(data.error || '업로드 실패');
          }
        } catch (err) {
          // 원래 상태로 복구
          placeholder.innerHTML = '<i class="fas fa-image text-3xl text-wiki-muted"></i><p class="text-sm text-wiki-muted">클릭하여 이미지 업로드 또는 드래그 앤 드롭</p><p class="text-xs text-wiki-muted/60">없으면 본문의 첫 번째 이미지가 자동으로 사용됩니다</p>';
          showMessage('error', err.message || '썸네일 업로드에 실패했습니다.');
        }
      }
      
      function getThumbnailUrl() {
        return thumbnailUrl || document.getElementById('field-thumbnail')?.value || '';
      }
      
      // 관련 아이템 수집
      function getRelatedItems(domain) {
        const items = [];
        document.querySelectorAll('#' + domain + '-container span[data-id]').forEach(chip => {
          items.push({
            id: chip.dataset.id,
            name: chip.dataset.name,
            slug: chip.dataset.slug
          });
        });
        return items;
      }
      
      // 충돌 다이얼로그 표시
      function showConflictDialog(serverVersion, localVersion) {
        const dialog = document.getElementById('conflict-dialog');
        dialog.querySelector('[data-server-version]').textContent = serverVersion;
        dialog.querySelector('[data-local-version]').textContent = localVersion;
        dialog.classList.remove('hidden');
        
        document.getElementById('conflict-reload').onclick = () => {
          location.reload();
        };
        
        document.getElementById('conflict-overwrite').onclick = async () => {
          currentVersion = serverVersion;
          dialog.classList.add('hidden');
          await saveDraft();
        };
      }
      
      // 저장 상태 업데이트
      function updateSaveStatus(status) {
        const el = document.getElementById('save-status');
        switch (status) {
          case 'saving':
            el.innerHTML = '<span class="text-amber-400">●</span> 저장 중...';
            break;
          case 'saved':
            el.innerHTML = '<span class="text-green-400">●</span> 저장됨 · ' + new Date().toLocaleTimeString('ko-KR');
            break;
          case 'error':
            el.innerHTML = '<span class="text-red-400">●</span> 저장 실패';
            break;
          default:
            el.innerHTML = '<span class="text-amber-400">●</span> 저장되지 않음';
        }
      }
      
      // 메시지 표시
      function showMessage(type, text) {
        const el = document.getElementById('editor-message');
        el.className = type === 'success'
          ? 'p-4 bg-green-500/10 border border-green-500/30 rounded-xl text-green-400'
          : 'p-4 bg-red-500/10 border border-red-500/30 rounded-xl text-red-400';
        el.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check' : 'exclamation') + '-circle mr-2"></i>' + text;
        el.classList.remove('hidden');
        setTimeout(() => el.classList.add('hidden'), 5000);
      }
      
      // 필드별 에러 표시
      function showFieldError(fieldId, msg) {
        clearFieldError(fieldId);
        const field = document.getElementById(fieldId);
        if (!field) return;
        field.dataset.error = 'true';
        field.style.borderColor = 'rgba(239, 68, 68, 0.6)';
        const errorEl = document.createElement('p');
        errorEl.className = 'field-error text-red-400 text-xs mt-1';
        errorEl.textContent = msg;
        field.parentElement.appendChild(errorEl);
      }
      
      function clearFieldError(fieldId) {
        const field = document.getElementById(fieldId);
        if (!field) return;
        delete field.dataset.error;
        field.style.borderColor = '';
        const existingError = field.parentElement.querySelector('.field-error');
        if (existingError) existingError.remove();
      }
      
      function clearAllFieldErrors() {
        document.querySelectorAll('.field-error').forEach(el => el.remove());
        document.querySelectorAll('[data-error="true"]').forEach(el => {
          delete el.dataset.error;
          el.style.borderColor = '';
        });
      }
      
      // 유효성 검사 (초성만 입력 등 체크)
      function validateTitle(title) {
        if (!title) return '제목을 입력해주세요.';
        if (title.length < 2) return '제목은 2자 이상이어야 합니다.';
        if (/^[ㄱ-ㅎ]+$/.test(title)) return '제목에 초성만 입력할 수 없습니다.';
        return null;
      }
      
      function validateContent(html) {
        if (!html || html === '<p></p>' || html === '<p><br></p>') return '본문을 입력해주세요.';
        var textOnly = html.replace(/<[^>]*>/g, '').trim();
        if (/^[ㄱ-ㅎ \\t\\n]+$/.test(textOnly)) return '본문에 초성만 입력할 수 없습니다.';
        return null;
      }
      
      // 자동완성 초기화 (pointerdown + 이벤트 위임 + focusout 방식 + IME 지원)
      function initAutocomplete() {
        ['jobs', 'majors', 'howtos'].forEach(domain => {
          const input = document.getElementById('field-' + domain);
          const dropdown = document.getElementById(domain + '-dropdown');
          const container = document.getElementById(domain + '-container');
          if (!input || !dropdown || !container) return;
          const wrap = input.parentElement;
          
          let items = [];
          try {
            items = JSON.parse(input.dataset.items || '[]');
          } catch (e) {}
          
          // 기존 아이템 렌더링
          items.forEach(item => addItemChip(container, item, domain));
          
          let debounceTimer = null;
          let composingTimer = null;
          let abortController = null;
          let lastSearchValue = '';
          
          // 검색 실행 함수
          const doSearch = async (q) => {
            if (q.length < 2) {
              dropdown.classList.add('hidden');
              dropdown.innerHTML = '';
              return;
            }
            
            // 이미 같은 값으로 검색했으면 스킵
            if (q === lastSearchValue) return;
            lastSearchValue = q;
            
            try {
              if (abortController) abortController.abort();
              abortController = new AbortController();
              
              const res = await fetch('/api/search?domain=' + domain + '&q=' + encodeURIComponent(q) + '&limit=10', {
                signal: abortController.signal
              });
              const data = await res.json();
              
              if (data.success && data.results && data.results.length > 0) {
                dropdown.innerHTML = data.results.map(r => 
                  '<div class="autocomplete-item" data-id="' + (r.id || r.slug) + '" data-name="' + escapeHtml(r.name || r.title) + '" data-slug="' + escapeHtml(r.slug || r.name) + '">' +
                  '<span class="text-white">' + escapeHtml(r.name || r.title) + '</span>' +
                  (r.snippet ? '<br><span class="text-xs text-wiki-muted">' + escapeHtml(r.snippet) + '</span>' : '') +
                  '</div>'
                ).join('');
                dropdown.classList.remove('hidden');
              } else {
                dropdown.classList.add('hidden');
                dropdown.innerHTML = '';
              }
            } catch (err) {
              if (err?.name !== 'AbortError') {
              }
            }
          };
          
          // 모든 입력에 대해 1초 후 자동 검색 (한글 조합 중에도)
          input.addEventListener('input', () => {
            clearTimeout(debounceTimer);
            clearTimeout(composingTimer);
            const q = input.value.trim();
            
            // 1초 후 자동 검색 (한글 조합 중에도 동작)
            composingTimer = setTimeout(() => doSearch(q), 1000);
            
            // 영어 등 비조합 입력은 300ms 후 빠르게 검색
            debounceTimer = setTimeout(() => {
              const currentQ = input.value.trim();
              if (currentQ.length >= 2) {
                doSearch(currentQ);
              }
            }, 300);
          });
          
          // 항목 선택: pointerdown에서 처리 (blur보다 먼저 발생)
          dropdown.addEventListener('pointerdown', (e) => {
            const el = e.target.closest('.autocomplete-item');
            if (!el) return;
            e.preventDefault();
            e.stopPropagation();
            
            const item = { id: el.dataset.id, name: el.dataset.name, slug: el.dataset.slug };
            
            // 중복 체크
            const existing = container.querySelector('[data-id="' + item.id + '"]');
            if (!existing) {
              addItemChip(container, item, domain);
            }
            
            input.value = '';
            dropdown.innerHTML = '';
            dropdown.classList.add('hidden');
            input.focus();
          });
          
          // focusout으로 외부 클릭 감지
          const handleFocusOut = (evt) => {
            const next = evt.relatedTarget;
            const isInside = wrap ? wrap.contains(next) : (input === next || dropdown.contains(next));
            if (!isInside) {
              dropdown.classList.add('hidden');
            }
          };
          (wrap || input).addEventListener('focusout', handleFocusOut);
        });
      }
      
      // 아이템 칩 추가
      function addItemChip(container, item, domain) {
        // 중복 체크
        const existingChip = container.querySelector('[data-id="' + item.id + '"]');
        if (existingChip) return;
        
        const chip = document.createElement('span');
        chip.className = 'inline-flex items-center gap-1 px-2 py-1 bg-wiki-primary/10 border border-wiki-primary/30 rounded-lg text-xs text-wiki-primary';
        chip.dataset.id = item.id;
        chip.dataset.name = item.name || item.title || '';
        chip.dataset.slug = item.slug || '';
        chip.innerHTML = escapeHtml(item.name || item.title) + '<button type="button" class="hover:text-red-400 ml-1">&times;</button>';
        
        chip.querySelector('button').addEventListener('click', () => {
          chip.remove();
        });
        
        container.appendChild(chip);
      }
      
      // 태그 초기화
      function initTags() {
        const input = document.getElementById('field-tags');
        const container = document.getElementById('tags-container');
        
        let tags = [];
        try {
          tags = JSON.parse(input.dataset.tags || '[]');
        } catch (e) {}
        
        tags.forEach(tag => addTagChip(container, tag));
        
        input.addEventListener('keydown', (e) => {
          if (e.key === 'Enter' || e.key === ',') {
            e.preventDefault();
            const tag = input.value.trim().replace(/,/g, '');
            if (tag) {
              addTagChip(container, tag);
              input.value = '';
            }
          }
        });
      }
      
      // 태그 칩 추가
      function addTagChip(container, tag) {
        const chip = document.createElement('span');
        chip.className = 'inline-flex items-center gap-1 px-2 py-1 bg-wiki-card/50 border border-wiki-border/40 rounded-lg text-xs text-wiki-text';
        chip.innerHTML = escapeHtml(tag) + '<button type="button" class="hover:text-red-400 ml-1">&times;</button>';
        
        chip.querySelector('button').addEventListener('click', () => {
          chip.remove();
        });
        
        container.appendChild(chip);
      }
      
      // HTML 이스케이프
      function escapeHtml(str) {
        if (!str) return '';
        return String(str).replace(/[&<>"']/g, c => ({
          '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
        })[c]);
      }
    </script>
  `
  
  return c.html(
    renderLayoutWithContext(c,
      content,
      'HowTo 작성 - Careerwiki',
      '새 HowTo 가이드를 작성합니다',
      false,
      { extraHead: '<link rel="stylesheet" href="/static/howto-editor.css">' }
    )
  )
})

// ============================================================================
// HowTo 편집 페이지 (GET /:slug/edit)
// ============================================================================
// HowTo 편집 페이지 (작성자 또는 관리자만) - draft로 복사 후 리다이렉트
howtoRoutes.get('/:slug/edit', requireAuth, async (c) => {
  const rawSlug = c.req.param('slug')
  const user = c.get('user')
  
  // guide: prefix가 있으면 정상 slug로 리다이렉트
  const slug = cleanGuidePrefix(rawSlug)
  if (slug !== rawSlug) {
    return c.redirect(`/howto/${encodeURIComponent(slug)}/edit`, 301)
  }
  
  if (!user) {
    return c.redirect(`/login?redirect=/howto/${encodeURIComponent(slug)}/edit`)
  }
  
  // DB에서 HowTo 조회 (page_type = 'guide', published 또는 draft_published)
  const page = await c.env.DB.prepare(`
    SELECT id, slug, title, summary, content, meta_data, author_id, status 
    FROM pages 
    WHERE slug = ? AND page_type = 'guide' AND status IN ('published', 'draft_published')
  `).bind(slug).first<{ id: number; slug: string; title: string; summary: string; content: string; meta_data: string; author_id: number | null; status: string }>()
  
  // 샘플 데이터 확인 (DB에 없는 경우)
  const sample = getSampleHowtoGuide(slug)
  
  if (!page && !sample) {
    return c.redirect('/howto')
  }
  
  // 권한 확인 (작성자 또는 관리자만)
  if (page) {
    const isAuthor = page.author_id && user.id === page.author_id
    const isAdmin = user.role === 'admin'
    
    if (!isAuthor && !isAdmin) {
      const content = `
        <div class="max-w-2xl mx-auto px-4 py-16 text-center">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-red-500/10 mb-6">
            <i class="fas fa-lock text-3xl text-red-400"></i>
          </div>
          <h1 class="text-2xl font-bold text-white mb-2">편집 권한이 없습니다</h1>
          <p class="text-wiki-muted mb-6">본인이 작성한 글만 편집할 수 있습니다.</p>
          <a href="/howto/${escapeHtml(slug)}" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
            돌아가기
          </a>
        </div>
      `
      return c.html(
        renderLayoutWithContext(c, content, '편집 권한 없음 - Careerwiki', '편집 권한이 없습니다')
      )
    }
    
    // 발행된 페이지를 draft로 복사
    let metaData: any = {}
    try {
      if (page.meta_data) {
        metaData = JSON.parse(page.meta_data)
      }
    } catch {}
    
    // 이 페이지에 연결된 기존 draft가 있는지 확인
    const existingDraft = await c.env.DB.prepare(`
      SELECT id FROM howto_drafts 
      WHERE user_id = ? AND published_page_id = ?
      ORDER BY updated_at DESC
      LIMIT 1
    `).bind(user.id, page.id).first<{ id: number }>()
    
    if (existingDraft) {
      // 기존 draft가 있으면 그것으로 이동
      return c.redirect(`/howto/draft/${existingDraft.id}`)
    }
    
    // 새 draft 생성 (발행된 페이지 데이터 복사)
    const { createDraft, updateDraft } = await import('../services/draftService')
    
    // contentJson 및 contentHtml 처리
    // metaData.contentJson이 있으면 문자열로 전달, 없으면 빈 상태로 두어 contentHtml이 사용되도록 함
    let contentJson = ''
    if (metaData.contentJson && metaData.contentJson !== '{}') {
      contentJson = typeof metaData.contentJson === 'string' 
        ? metaData.contentJson 
        : JSON.stringify(metaData.contentJson)
    }
    const contentHtml = page.content || ''
    
    // 디버그 로그
    
    const result = await createDraft(c.env.DB, {
      userId: user.id,
      title: page.title,
      summary: page.summary || '',
      contentJson: contentJson,
      contentHtml: contentHtml,
      thumbnailUrl: metaData.thumbnailUrl || ''
    })
    
    if (!result.success || !result.draftId) {
      // draft 생성 실패 시 에러 페이지
      const content = `
        <div class="max-w-2xl mx-auto px-4 py-16 text-center">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-red-500/10 mb-6">
            <i class="fas fa-exclamation-triangle text-3xl text-red-400"></i>
          </div>
          <h1 class="text-2xl font-bold text-white mb-2">편집 모드로 전환할 수 없습니다</h1>
          <p class="text-wiki-muted mb-6">초안 생성에 실패했습니다. 잠시 후 다시 시도해주세요.</p>
          <a href="/howto/${escapeHtml(slug)}" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
            돌아가기
          </a>
        </div>
      `
      return c.html(renderLayoutWithContext(c, content, '편집 실패 - Careerwiki', ''))
    }
    
    // draft에 원본 페이지 ID 기록
    await c.env.DB.prepare(`
      UPDATE howto_drafts SET published_page_id = ? WHERE id = ?
    `).bind(page.id, result.draftId).run()
    
    // 관련 항목들 저장 (직접 DB에 삽입)
    const draftId = result.draftId
    
    // 태그 저장
    const tags = metaData.tags || []
    for (const tagName of tags) {
      if (!tagName || !tagName.trim()) continue
      const trimmed = tagName.trim()
      
      // 태그 조회 또는 생성
      let tag = await c.env.DB.prepare(`SELECT id FROM tags WHERE name = ?`).bind(trimmed).first<{ id: number }>()
      if (!tag) {
        const tagSlug = trimmed.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9가-힣-]/g, '')
        const tagResult = await c.env.DB.prepare(`INSERT INTO tags (name, slug) VALUES (?, ?)`).bind(trimmed, tagSlug).run()
        tag = { id: Number(tagResult.meta.last_row_id) }
      }
      await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_tags (draft_id, tag_id) VALUES (?, ?)`).bind(draftId, tag.id).run()
    }
    
    // 관련 직업 저장
    const relatedJobs = metaData.relatedJobs || []
    for (let i = 0; i < relatedJobs.length; i++) {
      const job = relatedJobs[i]
      const jobId = job.id || job.slug || job.name
      if (jobId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_jobs (draft_id, job_id, display_order) VALUES (?, ?, ?)`).bind(draftId, jobId, i).run()
      }
    }
    
    // 관련 전공 저장
    const relatedMajors = metaData.relatedMajors || []
    for (let i = 0; i < relatedMajors.length; i++) {
      const major = relatedMajors[i]
      const majorId = major.id || major.slug || major.name
      if (majorId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_majors (draft_id, major_id, display_order) VALUES (?, ?, ?)`).bind(draftId, majorId, i).run()
      }
    }
    
    // 관련 HowTo 저장
    const relatedHowtos = metaData.relatedHowtos || []
    for (let i = 0; i < relatedHowtos.length; i++) {
      const howto = relatedHowtos[i]
      const howtoId = howto.id || howto.slug || howto.name
      if (howtoId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_howtos (draft_id, howto_id, display_order) VALUES (?, ?, ?)`).bind(draftId, howtoId, i).run()
      }
    }
    
    return c.redirect(`/howto/draft/${draftId}`)
  }
  
  // 샘플 데이터 편집 (불가)
  const content = `
    <div class="max-w-2xl mx-auto px-4 py-16 text-center">
      <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-amber-500/10 mb-6">
        <i class="fas fa-info-circle text-3xl text-amber-400"></i>
      </div>
      <h1 class="text-2xl font-bold text-white mb-2">샘플 콘텐츠입니다</h1>
      <p class="text-wiki-muted mb-6">샘플 콘텐츠는 편집할 수 없습니다.</p>
      <a href="/howto/${escapeHtml(slug)}" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
        돌아가기
      </a>
    </div>
  `
  return c.html(renderLayoutWithContext(c, content, '편집 불가 - Careerwiki', ''))
})

// ============================================================================
// HowTo 상세 페이지 (GET /:slug) - MUST BE LAST
// ============================================================================
howtoRoutes.get('/:slug', async (c) => {
  const rawSlug = c.req.param('slug')
  
  // guide: prefix가 있으면 정상 slug로 리다이렉트 (301 Permanent Redirect)
  const cleanedSlug = cleanGuidePrefix(rawSlug)
  if (cleanedSlug !== rawSlug) {
    return c.redirect(`/howto/${encodeURIComponent(cleanedSlug)}`, 301)
  }
  
  const slug = cleanedSlug
  
  // 먼저 DB에서 HowTo 검색 (page_type = 'guide', published 또는 draft_published)
  // 작성자 프로필 이미지도 함께 조회
  const dbResult = await c.env.DB.prepare(`
    SELECT p.id, p.slug, p.title, p.summary, p.content, p.meta_data, p.author_id, p.status, p.view_count, p.created_at, p.updated_at,
           u.picture_url AS author_picture_url, u.custom_picture_url AS author_custom_picture_url
    FROM pages p
    LEFT JOIN users u ON u.id = p.author_id
    WHERE p.page_type = 'guide' AND p.slug = ? AND p.status IN ('published', 'draft_published')
    LIMIT 1
  `).bind(slug).first()
  
  if (dbResult) {
    const status = dbResult.status as string
    const pageId = dbResult.id as number
    const user = getOptionalUser(c)
    const isAuthor = user && String(user.id) === String(dbResult.author_id)
    const isAdmin = user && (user.role === 'super-admin' || user.role === 'operator')
    
    // draft_published 상태는 작성자 또는 관리자만 접근 가능
    if (status === 'draft_published' && !isAuthor && !isAdmin) {
      // 404 처리 - 간단한 인라인 404 메시지
      const notFoundContent = `
        <div class="flex flex-col items-center justify-center min-h-[50vh] text-center px-4">
          <div class="w-20 h-20 mb-6 rounded-full bg-wiki-card flex items-center justify-center">
            <i class="fas fa-file-alt text-3xl text-wiki-muted"></i>
          </div>
          <h1 class="text-2xl font-bold text-white mb-2">찾을 수 없는 가이드입니다</h1>
          <p class="text-wiki-muted mb-6">요청하신 페이지를 찾을 수 없습니다.</p>
          <a href="/howto" class="px-6 py-3 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-xl transition">
            HowTo 목록으로
          </a>
        </div>
      `
      return c.html(renderLayoutWithContext(c, notFoundContent, '페이지를 찾을 수 없습니다 - Careerwiki', ''), 404)
    }
    
    // 조회수 증가 (비동기, 에러 무시)
    c.env.DB.prepare(`UPDATE pages SET view_count = view_count + 1 WHERE id = ?`).bind(pageId).run().catch(() => {})
    
    // 북마크 수 조회 (user_bookmarks 테이블 사용)
    const bookmarkResult = await c.env.DB.prepare(`
      SELECT COUNT(*) as count FROM user_bookmarks WHERE item_type = 'howto' AND item_slug = ?
    `).bind(slug).first<{ count: number }>()
    const bookmarkCount = bookmarkResult?.count || 0
    
    // DB에서 찾은 경우 - 변환 함수를 사용하여 HowtoGuideDetail로 변환
    const { dbRowToHowtoGuideDetail } = await import('../utils/howtoConverter')
    
    const guideDetail = dbRowToHowtoGuideDetail({
      id: dbResult.id as number,
      slug: dbResult.slug as string,
      title: dbResult.title as string,
      summary: dbResult.summary as string | null,
      content: dbResult.content as string | null,
      meta_data: dbResult.meta_data as string | null,
      author_id: dbResult.author_id as number | null,
      author_picture_url: dbResult.author_picture_url as string | null,
      author_custom_picture_url: dbResult.author_custom_picture_url as string | null,
      status: dbResult.status as string,
      created_at: dbResult.created_at as string,
      updated_at: dbResult.updated_at as string,
      view_count: (dbResult.view_count as number || 0) + 1, // 현재 조회 포함
      bookmark_count: bookmarkCount
    })
    
    // renderHowtoGuideDetail 템플릿 사용
    const { renderHowtoGuideDetail } = await import('../templates/howtoDetail')
    
    // CSS 링크 추가
    const cssLink = '<link rel="stylesheet" href="/static/howto-editor.css">'
    
    const content = cssLink + renderHowtoGuideDetail(guideDetail, {
      currentUserId: user?.id ? parseInt(user.id) : null,
      currentUserRole: user?.role || null,
      authorId: dbResult.author_id as number | null,
      pageId: dbResult.id as number,
      isBlinded: false,
      blindReason: null,
      isDraftPublished: status === 'draft_published'
    })
    
    const howtoOgImage = guideDetail.thumbnailUrl || undefined
    return c.html(
      renderLayoutWithContext(c, content, `${dbResult.title} - Careerwiki`, dbResult.summary as string || '', false, {
        ogImage: howtoOgImage
      })
    )
  }
  
  // DB에 없으면 샘플 데이터에서 검색 (기존 템플릿 사용)
  const sample = getSampleHowtoGuide(slug)
  if (sample) {
    return renderSampleHowtoDetailPage(c, sample)
  }

  // 둘 다 없으면 404
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-route',
      title: 'HowTo 정보를 찾을 수 없습니다',
      description: '요청하신 HowTo 가이드가 아직 등록되지 않았습니다.',
      ctaHref: '/howto',
      ctaLabel: 'HowTo 목록으로 돌아가기'
    })
    c.status(404)
    return c.html(
      renderLayoutWithContext(c,
        fallbackHtml,
        'HowTo 정보 없음 - Careerwiki',
        '요청한 HowTo 가이드를 찾을 수 없습니다.'
      )
    )
})

export { howtoRoutes }

