import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import type { D1Database } from '@cloudflare/workers-types'
import type { JobSourceRow } from '../types/database'
import { getUnifiedJobDetailWithRawData } from '../services/profileDataService'
import { getOrGeneratePage } from '../utils/page-cache'
import { renderUnifiedJobDetail, createJobJsonLd } from '../templates/unifiedJobDetail'
import { renderJobTemplateDesignPage } from '../templates/jobTemplateDesignPage'
import { renderDetailFallback, renderSampleJobDetailPage } from '../utils/card-renderers'
import { composeDetailSlug, resolveDetailIdFromSlug } from '../utils/slug'
import {
  buildCanonicalUrl, createMetaDescription, escapeHtml, renderLayoutWithContext, parseSourcesQuery
} from '../utils/shared-helpers'
import { getSampleJobDetail } from '../data/sampleRegistry'

const jobDetailRoutes = new Hono<AppEnv>()

jobDetailRoutes.get('/job/:slug', async (c) => {
  const mark = c.get('mark') as ((k: string) => void) | undefined
  mark?.('route-start')
  const rawSlug = c.req.param('slug')
  const normalizedSlug = decodeURIComponent(rawSlug).normalize('NFC')
  const slug = normalizedSlug
  let resolvedId = resolveDetailIdFromSlug('job', slug)

  // 🆕 If resolvedId doesn't contain ':', try to find by name in D1
  if (!resolvedId.includes(':') && c.env.DB) {
    try {
      const db = c.env.DB
      // Decode URL-encoded slug back to Korean
      const decodedSlug = normalizedSlug

      // 관리자 여부 확인 (숨겨진 직업 접근 허용)
      const user = c.get('user')
      const role = user?.role as string | undefined
      const isAdmin = user && (role === 'super-admin' || role === 'operator' || role === 'admin')
      const activeCondition = isAdmin ? '' : 'AND is_active = 1'

      // 1. 먼저 slug 필드로 직접 조회 (가장 정확)
      let result = await db.prepare(
        `SELECT id, name, is_active FROM jobs WHERE slug = ? ${activeCondition} LIMIT 1`
      ).bind(decodedSlug).first() as { id: string; name: string; is_active: number } | null

      // 2. slug로 못 찾으면 정규화된 slug로 검색 (하이픈 제거)
      if (!result) {
        const normalizedSlug = decodedSlug.toLowerCase().replace(/-/g, '')

        result = await db.prepare(
          `SELECT id, name, is_active FROM jobs WHERE LOWER(REPLACE(slug, "-", "")) = ? ${activeCondition} LIMIT 1`
        ).bind(normalizedSlug).first() as { id: string; name: string; is_active: number } | null
      }

      // 3. 여전히 못 찾으면 이름으로 검색
      if (!result) {
        const normalized = decodedSlug.toLowerCase().replace(/-/g, '')

        result = await db.prepare(
          `SELECT id, name, is_active FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? ${activeCondition} LIMIT 1`
        ).bind(normalized).first() as { id: string; name: string; is_active: number } | null
      }

      if (result?.id) {
        resolvedId = result.id as string
      } else {
        // Only show "NO MATCH FOUND" if actually no match

        // Try to find similar names for debugging
        const firstWord = decodedSlug.split('-')[0]
        if (firstWord && firstWord.length > 1) {
          const similarJobs = await db.prepare(
            'SELECT id, name FROM jobs WHERE name LIKE ? LIMIT 5'
          ).bind(`${firstWord}%`).all() as { results: Array<{ id: string; name: string }> }

          if (similarJobs.results?.length > 0) {
            similarJobs.results.forEach((job, idx) => {
            })
          }
        }
      }
    } catch (error) {
    }
  }

  // Check for debug mode first (bypass ISR cache for debugging)
  // 병합 설계 시스템: 이름이 완전히 같은 직업만 동일 엔티티로 간주
  const debugMode = c.req.query('debug') === 'true'
  if (debugMode) {
    try {
      // 1. 데이터베이스에서 job_sources 가져오기 (이름으로 검색)
      const db = c.env.DB as D1Database
      if (!db) {
        throw new Error('DB not available')
      }

      // resolvedId를 직업명으로 사용 (slug에서 변환된 이름)
      const jobName = resolvedId

      // 통합 job 엔티티에서 job_id 찾기
      const jobRow = await db.prepare(`
        SELECT id, name FROM jobs WHERE id = ? OR name = ? LIMIT 1
      `).bind(jobName, jobName).first<{ id: string; name: string }>()

      if (!jobRow) {
        // 직업을 못 찾으면 검색 페이지로 리다이렉트
        const searchQuery = decodeURIComponent(slug).replace(/-/g, ' ')
        return c.redirect(`/search?q=${encodeURIComponent(searchQuery)}`)
      }

      // 2. 해당 job_id의 모든 소스 가져오기
      let sources = await db.prepare(`
        SELECT * FROM job_sources WHERE job_id = ?
      `).bind(jobRow.id).all<JobSourceRow>()

      // job_id가 null인 경우 이름으로 직접 매칭
      if (!sources.results || sources.results.length === 0) {

        // normalized와 raw 둘 다 검색
        const normalizedSources = await db.prepare(`
          SELECT * FROM job_sources
          WHERE JSON_EXTRACT(normalized_payload, '$.name') = ?
        `).bind(jobRow.name).all<JobSourceRow>()

        const rawSources = await db.prepare(`
          SELECT * FROM job_sources
          WHERE JSON_EXTRACT(raw_payload, '$.dJobNm') = ?
          OR raw_payload LIKE ?
        `).bind(jobRow.name, `%"dJobNm":"${jobRow.name}"%`).all<JobSourceRow>()

        // 두 결과 합치기 (중복 제거)
        const allResults = [...(normalizedSources.results || []), ...(rawSources.results || [])]
        const uniqueResults = Array.from(new Map(allResults.map(item => [item.source_key, item])).values())

        sources = { results: uniqueResults, success: true, meta: normalizedSources.meta }
      }

      if (!sources.results || sources.results.length === 0) {
        const fallbackHtml = renderDetailFallback({
          icon: 'fa-database',
          title: '소스 데이터가 없습니다',
          description: '이 직업에 대한 원본 데이터를 찾을 수 없습니다.',
          ctaHref: '/jobs',
          ctaLabel: '직업 목록으로'
        })
        c.status(404)
        return c.html(renderLayoutWithContext(c, fallbackHtml, '소스 데이터 없음 - Careerwiki'))
      }

      // 3. 템플릿 디자인 페이지 렌더링
      const debugContent = renderJobTemplateDesignPage(jobRow.name, sources.results)

      return c.html(debugContent)
    } catch (error) {
      c.status(500)
      return c.html(renderLayoutWithContext(c, renderDetailFallback({
        icon: 'fa-circle-exclamation',
        iconColor: 'text-red-500',
        title: '디버그 데이터 로드 실패',
        description: '일시적인 오류가 발생했습니다.',
        ctaHref: '/job',
        ctaLabel: '직업위키로 돌아가기'
      }), '오류 - Careerwiki'))
    }
  }

  // 🆕 ISR (Incremental Static Regeneration) with wiki_pages cache
  return getOrGeneratePage(
    slug,
    'job',
    {
      // Step 1: Fetch data
      fetchData: async (slug, env) => {
        mark?.('fetch-start')
        let careernetId = c.req.query('careernetId') || undefined
        let goyongJobId = c.req.query('goyongJobId') || undefined
        const includeSources = parseSourcesQuery(c.req.query('sources')) || ['CAREERNET', 'GOYONG24']

        // 🆕 Redirect to clean URL if query parameters are present
        if (careernetId || goyongJobId) {
          const cleanUrl = `/job/${encodeURIComponent(slug)}`
          // Note: Redirect is handled by returning early, but we'll let ISR handle it
        }

        const findSampleJobDetail = () => {
          const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
          for (const candidate of candidates) {
            const sample = getSampleJobDetail(candidate)
            if (sample) return sample
          }
          return null
        }

        // ⚠️ ISR에서는 sample data의 sourceIds를 사용하지 않음
        // → D1 병합 로직이 자동으로 실행되도록 함
        // (쿼리 파라미터는 이미 위에서 undefined로 설정됨)

        const result = await getUnifiedJobDetailWithRawData(
          {
            id: resolvedId,
            careernetId: undefined,  // ⚠️ 명시적으로 undefined (D1 병합 활성화)
            goyong24JobId: undefined,  // ⚠️ 명시적으로 undefined (D1 병합 활성화)
            includeSources
          },
          env
        )
        mark?.('db-fetch')

        if (!result.profile) {
          // Try sample data fallback
          const sample = findSampleJobDetail()
          if (sample) {
            throw new Error('SAMPLE_FALLBACK') // Signal to use sample rendering
          }

          throw new Error('PROFILE_NOT_FOUND')
        }

        // 관련 직업 중 DB에 존재하는 직업 매핑 조회
        let existingJobSlugs = new Map<string, string>()
        const sidebarJobs = result.profile.sidebarJobs
        if (sidebarJobs?.length && env?.DB) {
          try {
            // 관련 직업 이름 추출
            const jobNames = sidebarJobs
              .map((job: any) => job?.name?.trim() || job?.jobNm?.trim() || (typeof job === 'string' ? job.trim() : ''))
              .filter((name: string) => name)
              .slice(0, 20) // 최대 20개만 조회

            if (jobNames.length > 0) {
              const placeholders = jobNames.map(() => '?').join(',')
              const query = `SELECT name, slug FROM jobs WHERE name IN (${placeholders})`
              const { results } = await env.DB.prepare(query).bind(...jobNames).all() as { results: Array<{ name: string; slug: string }> | null }
              if (results) {
                for (const row of results) {
                  existingJobSlugs.set(row.name.toLowerCase(), row.slug)
                }
              }
            }
          } catch (e) {
          }
        }

        // 이 직업을 참조하는 HowTo 가이드 조회
        let relatedHowtos: Array<{ slug: string; title: string; summary: string }> = []
        try {
          if (env?.DB && result.profile?.name) {
            const namePattern = `%"relatedJobs":%"name":"${result.profile.name.replace(/[%_"\\]/g, '')}"%`
            const { results: howtoResults } = await env.DB.prepare(`
              SELECT slug, title, summary FROM pages
              WHERE page_type = 'guide'
                AND status IN ('published', 'draft_published')
                AND meta_data LIKE ?
              LIMIT 10
            `).bind(namePattern).all() as { results: Array<{ slug: string; title: string; summary: string }> }
            if (howtoResults) relatedHowtos = howtoResults
          }
        } catch {
        }

        return {
          ...result,
          existingJobSlugs,
          relatedHowtos
        }
      },

      // Step 2: Render HTML
      renderHTML: (result) => {
        mark?.('render-start')
        const profile = result.profile!  // Non-null assertion (we already checked in fetchData)
        const canonicalSlug = composeDetailSlug('job', profile.name, profile.id ?? resolvedId)
        const canonicalPath = `/job/${encodeURIComponent(canonicalSlug)}`
        const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
        const title = `${profile.name} 직업 정보 - Careerwiki`
        const description = createMetaDescription(
          profile.summary,
          profile.duties,
          profile.prospect,
          profile.salary
        )
        const extraHead = [
          '<meta property="article:modified_time" content="' + new Date().toISOString() + '">',
          createJobJsonLd(profile, canonicalUrl)
        ].filter(Boolean).join('\n')

        const content = renderUnifiedJobDetail({
          profile,
          partials: result.partials,
          sources: result.sources,
          rawApiData: result.rawApiData,
          existingJobSlugs: result.existingJobSlugs,
          relatedHowtos: result.relatedHowtos
        })
        mark?.('render-done')

        const jobOgImage = (profile as any).image_url || undefined
        return renderLayoutWithContext(c,
          content,
          escapeHtml(title),
          escapeHtml(description),
          false,
          {
            canonical: canonicalUrl,
            ogUrl: canonicalUrl,
            ogType: 'article',
            ogImage: jobOgImage,
            extraHead
          }
        )
      },

      // Step 3: Extract metadata
      extractMetadata: (result) => {
        const profile = result.profile!  // Non-null assertion (we already checked in fetchData)
        return {
          title: `${profile.name} 직업 정보 - Careerwiki`,
          description: createMetaDescription(
            profile.summary,
            profile.duties,
            profile.prospect,
            profile.salary
          ),
          og_image_url: undefined // Add later if needed
        }
      }
    },
    c
  ).catch((error) => {
    // Error handling

    // Try sample fallback
    if (error.message === 'SAMPLE_FALLBACK') {
      const findSampleJobDetail = () => {
        const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
        for (const candidate of candidates) {
          const sample = getSampleJobDetail(candidate)
          if (sample) return sample
        }
        return null
      }

      const sample = findSampleJobDetail()
      if (sample) {
        return renderSampleJobDetailPage(c, sample)
      }
    }

    // 404 for missing profiles -> 검색 페이지로 리다이렉트
    if (error.message === 'PROFILE_NOT_FOUND') {
      const searchQuery = decodeURIComponent(slug).replace(/-/g, ' ')
      return c.redirect(`/search?q=${encodeURIComponent(searchQuery)}`)
    }

    // 500 for other errors
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-exclamation-circle',
      iconColor: 'text-red-500',
      title: '직업 정보를 불러오지 못했습니다',
      description: '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ctaHref: '/job',
      ctaLabel: '직업위키로 돌아가기'
    })
    c.status(500)
    return c.html(
      renderLayoutWithContext(c,
        fallbackHtml,
        '직업 정보 로드 오류 - Careerwiki',
        '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
      )
    )
  })
})

export { jobDetailRoutes }
