import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { ragSearchUnified } from '../services/rag-search'
import { renderJobCard, renderMajorCard } from '../utils/card-renderers'
import {
  escapeHtml, createMetaDescription, renderLayoutWithContext, cleanGuidePrefix
} from '../utils/shared-helpers'
import { logSearchQuery } from '../services/searchQueryLogger'

const searchRoutes = new Hono<AppEnv>()

searchRoutes.get('/search', async (c) => {
  const query = c.req.query('q') || ''
  const keyword = query.trim()

  const renderKeywordBadges = (keywords: string[]): string => {
    if (!keywords || !keywords.length) {
      return ''
    }
    return `<div class="flex flex-wrap gap-2 mt-3">${keywords.slice(0, 3)
      .map((keyword) => `<span class="px-3 py-1.5 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted">${escapeHtml(keyword)}</span>`)
      .join('')}</div>`
  }

  const queryValueAttr = escapeHtml(keyword)
  const escapedQuery = escapeHtml(keyword)

  // 실제 D1 데이터 검색
  let jobCardsHtml = ''
  let majorCardsHtml = ''
  let howtoResults: Array<{ href: string; title: string; summary?: string; thumbnailUrl?: string; tags?: string[] }> = []

  // 요약 텍스트 포맷팅 함수
  const formatSummaryText = (value?: string | null, type: 'job' | 'major' = 'job'): string => {
    const fallback = type === 'job'
      ? '고용24와 커리어넷 데이터를 통합하여 제공하는 직업 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
      : '고용24와 커리어넷 데이터를 통합하여 제공하는 전공 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
    if (!value) return fallback
    const normalized = value.replace(/\s+/g, ' ').trim()
    if (!normalized) return fallback
    return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
  }

  if (keyword && c.env?.DB) {
    try {
      // RAG 통합 검색 (임베딩 1회, Vectorize 1회, D1 병렬 보강)
      const ragResult = await ragSearchUnified(c.env, keyword, {
        jobsLimit: 5,
        majorsLimit: 5,
        howtosLimit: 5,
      })

      jobCardsHtml = ragResult.jobs.items
        .slice(0, 5)
        .map((entry) => renderJobCard(entry))
        .join('')

      majorCardsHtml = ragResult.majors.items
        .slice(0, 5)
        .map((entry) => renderMajorCard(entry))
        .join('')

      // RAG howto 결과를 기존 howtoResults 형식으로 변환
      howtoResults = ragResult.howtos.map(h => ({
        href: `/howto/${h.slug}`,
        title: h.title,
        summary: h.summary,
        thumbnailUrl: h.thumbnailUrl,
        tags: h.tags,
      }))

      // 검색어 로깅 (비동기, 응답 블로킹 없음)
      const totalResults = ragResult.jobs.items.length + ragResult.majors.items.length + ragResult.howtos.length
      if (c.executionCtx && 'waitUntil' in c.executionCtx) {
        c.executionCtx.waitUntil(
          logSearchQuery(c.env.DB, {
            query: keyword,
            resultCount: totalResults,
            searchType: 'all',
            role: (c.get('user') as { role?: string } | undefined)?.role,
          })
        )
      }
    } catch (error) {
    }
  }

  // HowTo 검색 - D1 pages 테이블에서만 검색
  // 🔍 HowTo 키워드 토큰화 함수
  const tokenizeHowtoKeyword = (kw: string): string[] => {
    const tokens: string[] = []
    const normalizedKw = kw.toLowerCase().replace(/\s+/g, '')

    // 1. 취업/커리어 관련 키워드 추출
    const careerKeywords = ['취업', '면접', '자소서', '자기소개서', '이력서', '포트폴리오', '자격증', '스펙', '준비', '방법', '팁', '가이드', '합격', '불합격', '서류', '채용', '지원', '경력', '신입', '인턴', '공채', '수시', '연봉', '협상', '퇴사', '이직', '전직', '직무', '직업', '진로', '커리어']
    for (const ck of careerKeywords) {
      if (normalizedKw.includes(ck) && normalizedKw !== ck) {
        tokens.push(ck)
      }
    }

    // 2. 직무/분야 키워드 추출
    const fieldKeywords = ['개발자', '디자이너', '기획자', '마케터', '영업', '인사', '회계', '재무', '법무', '공무원', '대기업', '중소기업', '스타트업', 'it', '금융', '의료', '교육', '건설', '제조', '서비스']
    for (const fk of fieldKeywords) {
      if (normalizedKw.includes(fk) && normalizedKw !== fk) {
        tokens.push(fk)
      }
    }

    // 중복 제거, 원본 키워드 제외
    return [...new Set(tokens)].filter(t => t !== normalizedKw && t.length >= 2)
  }

  if (keyword && c.env?.DB && howtoResults.length === 0) {
    // RAG 결과가 없을 때만 LIKE 폴백으로 HowTo 검색
    try {
      const db = c.env.DB as any
      const howtoTokens = tokenizeHowtoKeyword(keyword)

      // 토큰 검색 조건 생성
      let tokenConditions = ''
      const tokenBindings: string[] = []
      if (howtoTokens.length > 0) {
        const tokenClauses = howtoTokens.map(() => `title LIKE ?`).join(' OR ')
        tokenConditions = ` OR (${tokenClauses})`
        for (const token of howtoTokens) {
          tokenBindings.push(`%${token}%`)
        }
      }

      // 우선순위 기반 정렬 쿼리 (guide: prefix가 붙은 corrupted slug 제외)
      const howtoQuery = `
        SELECT id, slug, title, summary,
          COALESCE(json_extract(meta_data, '$.thumbnailUrl'), '') as thumbnail_url,
          COALESCE(json_extract(meta_data, '$.tags'), '[]') as tags_json,
          CASE
            WHEN LOWER(title) = LOWER(?) THEN 0
            WHEN LOWER(title) LIKE LOWER(?) THEN 1
            WHEN LOWER(title) LIKE LOWER(?) THEN 2
            ELSE 3
          END as priority
        FROM pages
        WHERE page_type = 'guide'
          AND status = 'published'
          AND slug NOT LIKE 'guide:%'
          AND (title LIKE ? OR summary LIKE ?${tokenConditions})
        ORDER BY priority, updated_at DESC
        LIMIT 5
      `

      const howtoResult = await db.prepare(howtoQuery).bind(
        keyword,                    // 완전 일치
        `${keyword}%`,              // 시작 일치
        `%${keyword}%`,             // 부분 일치
        `%${keyword}%`,             // WHERE title
        `%${keyword}%`,             // WHERE summary
        ...tokenBindings            // 토큰 검색
      ).all()

      howtoResults = (howtoResult.results || []).map((row: any) => {
        let tags: string[] = []
        try {
          tags = JSON.parse(row.tags_json || '[]')
        } catch { tags = [] }

        // slug에서 guide: prefix 제거
        const cleanSlug = cleanGuidePrefix(row.slug || '')

        return {
          href: `/howto/${encodeURIComponent(cleanSlug)}`,
          title: row.title,
          summary: row.summary || '',
          thumbnailUrl: row.thumbnail_url || '',
          tags: Array.isArray(tags) ? tags : []
        }
      })
    } catch (error) {
      howtoResults = []
    }
  } else if (c.env?.DB && !keyword) {
    // 검색어 없을 때만 최신 HowTo 표시 (검색어 있으면 RAG 결과 유지)
    try {
      const db = c.env.DB as any
      const defaultQuery = `
        SELECT id, slug, title, summary,
          COALESCE(json_extract(meta_data, '$.thumbnailUrl'), '') as thumbnail_url,
          COALESCE(json_extract(meta_data, '$.tags'), '[]') as tags_json
        FROM pages
        WHERE page_type = 'guide' AND status = 'published' AND slug NOT LIKE 'guide:%'
        ORDER BY updated_at DESC
        LIMIT 3
      `
      const defaultResult = await db.prepare(defaultQuery).all()

      howtoResults = (defaultResult.results || []).map((row: any) => {
        let tags: string[] = []
        try {
          tags = JSON.parse(row.tags_json || '[]')
        } catch { tags = [] }

        return {
          href: `/howto/${encodeURIComponent(row.slug)}`,
          title: row.title,
          summary: row.summary || '',
          thumbnailUrl: row.thumbnail_url || '',
          tags: Array.isArray(tags) ? tags : []
        }
      })
    } catch (error) {
      howtoResults = []
    }
  }

  const content = `
    <div class="max-w-[1400px] mx-auto px-[2px] md:px-6 pt-4 md:pt-8 md:mt-8">
        <div class="mb-8">
            <form action="/search" method="get" class="relative">
                <input
                    type="text"
                    name="q"
                    value="${queryValueAttr}"
                    placeholder="검색어를 입력하세요"
                    class="w-full px-6 py-4 bg-wiki-bg border border-wiki-border rounded-full text-base md:text-lg focus:outline-none focus:border-wiki-primary transition"
                    style="font-size: 16px;"
                >
                <button type="submit" class="absolute right-2 top-1/2 -translate-y-1/2 px-5 py-3 min-h-[44px] bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white rounded-full hover:scale-105 transition text-sm md:text-base font-medium">
                    <i class="fas fa-search mr-1.5"></i>검색
                </button>
            </form>
        </div>

        ${jobCardsHtml ? `
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-primary mr-3"></span>
                직업위키
            </h2>
            <div class="space-y-4">
                ${jobCardsHtml}
                ${jobCardsHtml.split('</article>').length - 1 >= 5 ? `
                <a href="/job?q=${encodeURIComponent(keyword)}" class="block glass-card py-4 px-6 rounded-xl hover-glow transition text-center min-h-[48px] flex items-center justify-center">
                    <span class="text-sm font-medium text-wiki-text">직업 결과 더보기</span>
                </a>
                ` : ''}
            </div>
        </div>
        ` : ''}

        ${majorCardsHtml ? `
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-secondary mr-3"></span>
                전공위키
            </h2>
            <div class="space-y-4">
                ${majorCardsHtml}
                ${majorCardsHtml.split('</article>').length - 1 >= 5 ? `
                <a href="/major?q=${encodeURIComponent(keyword)}" class="block glass-card py-4 px-6 rounded-xl hover-glow transition text-center min-h-[48px] flex items-center justify-center">
                    <span class="text-sm font-medium text-wiki-text">전공 결과 더보기</span>
                </a>
                ` : ''}
            </div>
        </div>
        ` : ''}

        ${howtoResults.length > 0 ? `
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-amber-500 mr-3"></span>
                HowTo 가이드
            </h2>
            <div class="space-y-4">
                ${howtoResults.map(howto => `
                    <article class="group relative">
                      <a href="${howto.href}" class="block">
                        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-5 transition-all duration-500 ease-out hover:border-amber-500/40 hover:shadow-xl hover:shadow-amber-500/5 hover:-translate-y-1">
                          <div class="flex gap-4">
                            <!-- 왼쪽: 텍스트 콘텐츠 -->
                            <div class="flex-1 min-w-0 space-y-2">
                              <div class="flex items-center gap-2">
                                <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-md text-[10px] font-semibold uppercase tracking-wider bg-amber-500/10 text-amber-400/80 border border-amber-500/20">
                                  <i class="fas fa-book-open text-[8px]"></i>
                                  HowTo
                                </span>
                              </div>
                              <h3 class="text-lg sm:text-xl font-bold text-white group-hover:text-amber-400 transition-colors line-clamp-2">${escapeHtml(howto.title)}</h3>
                              <p class="text-[13px] sm:text-[14px] leading-relaxed text-wiki-muted/90 line-clamp-2">${escapeHtml(howto.summary || '가이드 요약이 없습니다.')}</p>
                              ${howto.tags && howto.tags.length > 0 ? `
                                <div class="flex flex-wrap gap-1.5 pt-1">
                                  ${howto.tags.slice(0, 4).map((tag: string) => `
                                    <span class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-amber-500/10 border border-amber-500/20 text-amber-300/80 text-xs font-medium">
                                      <i class="fas fa-tag text-[8px]"></i>
                                      ${escapeHtml(tag)}
                                    </span>
                                  `).join('')}
                                </div>
                              ` : ''}
                            </div>
                            <!-- 오른쪽: 썸네일 -->
                            ${howto.thumbnailUrl ? `
                              <div class="flex items-center justify-center flex-shrink-0">
                                <div class="w-[74px] h-[74px] sm:w-28 sm:h-28 rounded-xl overflow-hidden border border-wiki-border/30 bg-wiki-bg/50">
                                  <img
                                    src="${escapeHtml(howto.thumbnailUrl)}"
                                    alt="${escapeHtml(howto.title)}"
                                    class="w-full h-full object-cover"
                                    loading="lazy"
                                    onerror="this.parentElement.innerHTML='<div class=\\'w-full h-full flex items-center justify-center bg-wiki-card/50\\'><i class=\\'fas fa-book-open text-xl sm:text-2xl text-amber-400/40\\'></i></div>'"
                                  >
                                </div>
                              </div>
                            ` : `
                              <div class="flex items-center justify-center flex-shrink-0">
                                <div class="w-[74px] h-[74px] sm:w-28 sm:h-28 rounded-xl overflow-hidden border border-wiki-border/30 bg-wiki-card/50 flex items-center justify-center">
                                  <i class="fas fa-book-open text-xl sm:text-3xl text-amber-400/30"></i>
                                </div>
                              </div>
                            `}
                          </div>
                        </div>
                      </a>
                    </article>
                `).join('')}
                ${howtoResults.length >= 3 ? `
                <a href="/howto${keyword ? `?q=${encodeURIComponent(keyword)}` : ''}" class="block glass-card py-4 px-6 rounded-xl hover-glow transition text-center min-h-[48px] flex items-center justify-center">
                    <span class="text-sm font-medium text-wiki-text">HowTo 가이드 더보기</span>
                </a>
                ` : ''}
            </div>
        </div>
        ` : ''}

        ${keyword && !jobCardsHtml && !majorCardsHtml && howtoResults.length === 0 ? `
        <div class="glass-card p-8 rounded-xl text-center">
            <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">"${escapedQuery}"에 대한 검색 결과가 없습니다.</p>
            <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도해보세요.</p>
        </div>
        ` : ''}
    </div>
  `

  const title = keyword ? `${keyword} - Careerwiki 검색` : '검색 - Careerwiki'
  const description = keyword
    ? createMetaDescription(`"${keyword}"와 관련된 Careerwiki 직업, 전공 정보를 확인하세요.`)
    : 'Careerwiki에서 직업, 전공, HowTo 정보를 검색해보세요.'

  return c.html(renderLayoutWithContext(c, content, escapeHtml(title), escapeHtml(description)))
})

export { searchRoutes }
