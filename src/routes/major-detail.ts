import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import type { D1Database } from '@cloudflare/workers-types'
import type { MajorSourceRow } from '../types/database'
import type { UnifiedMajorDetail } from '../types/unifiedProfiles'
import { getUnifiedMajorDetail } from '../services/profileDataService'
import { getOrGeneratePage } from '../utils/page-cache'
import { renderUnifiedMajorDetail, createMajorJsonLd } from '../templates/unifiedMajorDetail'
import { renderDetailFallback, renderSampleMajorDetailPage } from '../utils/card-renderers'
import { composeDetailSlug, resolveDetailIdFromSlug } from '../utils/slug'
import {
  buildCanonicalUrl, createMetaDescription, escapeHtml, renderLayoutWithContext, parseSourcesQuery
} from '../utils/shared-helpers'
import { getSampleMajorDetail } from '../data/sampleRegistry'
import { trackMajorView } from '../utils/viewCounter'

const majorDetailRoutes = new Hono<AppEnv>()

// Route 1: /major/:slug (ISR-based unified major detail page)
majorDetailRoutes.get('/major/:slug', async (c) => {
  const mark = c.get('mark') as ((k: string) => void) | undefined
  mark?.('route-start')
  const rawSlug = c.req.param('slug')
  const normalizedSlug = decodeURIComponent(rawSlug).normalize('NFC')
  const slug = normalizedSlug
  let resolvedId = resolveDetailIdFromSlug('major', slug)

  // 🆕 If resolvedId doesn't contain ':', try to find by name in D1 (직업 페이지와 동일)
  if (!resolvedId.includes(':') && c.env.DB) {
    try {
      const db = c.env.DB
      // Decode URL-encoded slug back to Korean
      const decodedSlug = decodeURIComponent(slug)

      // 관리자 여부 확인 (숨겨진 전공 접근 허용)
      const user = c.get('user')
      const role = user?.role as string | undefined
      const isAdmin = user && (role === 'super-admin' || role === 'operator' || role === 'admin')
      const activeCondition = isAdmin ? '' : 'AND is_active = 1'

      // slug도 DB 쿼리와 동일한 정규화 적용 (하이픈, 괄호, 특수문자 제거)
      const normalized = decodedSlug.toLowerCase()
        .replace(/-/g, '')
        .replace(/,/g, '')
        .replace(/·/g, '')
        .replace(/ㆍ/g, '')
        .replace(/\//g, '')
        .replace(/\s/g, '')
        .replace(/\(/g, '')
        .replace(/\)/g, '')

      const result = await db.prepare(
        `SELECT id, name, is_active FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? ${activeCondition} ORDER BY CASE WHEN merged_profile_json IS NOT NULL AND merged_profile_json != '{}' THEN 0 ELSE 1 END LIMIT 1`
      ).bind(normalized).first() as { id: string; name: string; is_active: number } | null

      if (result?.id) {
        resolvedId = result.id as string
      } else {
      }
    } catch (error) {
    }
  }

  // Check for debug mode first (bypass ISR cache for debugging)
  // 병합 설계 시스템: 이름이 완전히 같은 전공만 동일 엔티티로 간주
  const debugMode = c.req.query('debug') === 'true'
  if (debugMode) {
    try {
      // 1. 데이터베이스에서 major_sources 가져오기 (이름으로 검색)
      const db = c.env.DB as D1Database
      if (!db) {
        throw new Error('DB not available')
      }

      // resolvedId를 전공명으로 사용 (slug에서 변환된 이름)
      const majorName = resolvedId

      // 통합 major 엔티티에서 major_id 찾기
      const majorRow = await db.prepare(`
        SELECT id, name FROM majors WHERE id = ? OR name = ? LIMIT 1
      `).bind(majorName, majorName).first<{ id: string; name: string }>()

      if (!majorRow) {
        // 전공을 못 찾으면 검색 페이지로 리다이렉트
        const searchQuery = decodeURIComponent(slug).replace(/-/g, ' ')
        return c.redirect(`/search?q=${encodeURIComponent(searchQuery)}`)
      }

      // 2. 해당 major_id의 모든 소스 가져오기
      const sources = await db.prepare(`
        SELECT * FROM major_sources WHERE major_id = ?
      `).bind(majorRow.id).all<MajorSourceRow>()

      if (!sources.results || sources.results.length === 0) {
        const fallbackHtml = renderDetailFallback({
          icon: 'fa-database',
          title: '소스 데이터가 없습니다',
          description: '이 전공에 대한 원본 데이터를 찾을 수 없습니다.',
          ctaHref: '/majors',
          ctaLabel: '전공 목록으로'
        })
        c.status(404)
        return c.html(renderLayoutWithContext(c, fallbackHtml, '소스 데이터 없음 - Careerwiki'))
      }

      // 3. 필드 비교 (전공은 아직 미구현)
      c.status(501)
      const fallbackHtml = renderDetailFallback({
        icon: 'fa-tools',
        title: '전공 필드 비교 준비 중',
        description: '전공 필드 비교 기능은 아직 구현 중입니다. 직업 필드 비교를 먼저 확인해주세요.',
        ctaHref: '/majors',
        ctaLabel: '전공 목록으로'
      })
      return c.html(renderLayoutWithContext(c, fallbackHtml, '준비 중 - Careerwiki'))
    } catch (error) {
      c.status(500)
      return c.html(renderLayoutWithContext(c, renderDetailFallback({
        icon: 'fa-circle-exclamation',
        iconColor: 'text-red-500',
        title: '디버그 데이터 로드 실패',
        description: error instanceof Error ? error.message : '일시적인 오류가 발생했습니다.',
        ctaHref: '/major',
        ctaLabel: '전공 목록으로'
      }), '오류 - Careerwiki'))
    }
  }

  // 조회수 추적 (비동기, 페이지 렌더링 차단하지 않음)
  const user = c.get('user') as { id?: number; role?: string } | undefined
  c.executionCtx.waitUntil(
    trackMajorView({
      db: c.env.DB,
      kv: c.env.KV,
      slug,
      userAgent: c.req.header('user-agent') || '',
      userId: user?.id,
      ip: c.req.header('cf-connecting-ip') || 'unknown',
      role: user?.role,
    }).catch(() => {})
  )

  // 🆕 ISR (Incremental Static Regeneration) with wiki_pages cache
  return getOrGeneratePage(
    slug,
    'major',
    {
      // Step 1: Fetch data
      fetchData: async (slug, env) => {
        mark?.('fetch-start')
        const careernetId = c.req.query('careernetId') || undefined
        const majorGbParam = c.req.query('goyongMajorGb')
        const departmentId = c.req.query('goyongDepartmentId') || undefined
        const majorId = c.req.query('goyongMajorId') || undefined
        const includeSources = parseSourcesQuery(c.req.query('sources'))

        const goyongMajorGb = majorGbParam === '1' ? '1' as const : majorGbParam === '2' ? '2' as const : undefined
        const goyongParams = goyongMajorGb && departmentId && majorId
          ? { majorGb: goyongMajorGb, departmentId, majorId } as { majorGb: '1' | '2'; departmentId: string; majorId: string }
          : undefined


        const result = await getUnifiedMajorDetail(
          {
            id: resolvedId,
            careernetId,
            goyong24Params: goyongParams,
            includeSources
          },
          env
        )
        mark?.('db-fetch')


        if (!result.profile) {

          // Try sample data fallback
          const findSampleMajorDetail = () => {
            const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
            for (const candidate of candidates) {
              const sample = getSampleMajorDetail(candidate)
              if (sample) return sample
            }
            return null
          }

          const sample = findSampleMajorDetail()
          if (sample) {
            throw new Error('SAMPLE_FALLBACK') // Signal to use sample rendering
          }

          throw new Error('PROFILE_NOT_FOUND')
        }

        // 실제 DB ID 찾기 (resolvedId 사용, 이미 DB ID로 해결됨)
        let actualDbId = resolvedId

        // profile.id가 composite ID인 경우 실제 DB ID로 업데이트
        if (result.profile.id && result.profile.id.includes(':')) {
        }

        // 실제 DB ID로 프로필 업데이트

        // 관련 직업 중 DB에 존재하는 직업 매핑 조회
        let existingJobSlugs = new Map<string, string>()
        if (result.profile.relatedJobs?.length && env?.DB) {
          try {
            const jobNames = result.profile.relatedJobs.slice(0, 20) // 최대 20개만 조회
            const placeholders = jobNames.map(() => '?').join(',')
            const query = `SELECT name, slug FROM jobs WHERE name IN (${placeholders})`
            const { results } = await env.DB.prepare(query).bind(...jobNames).all() as { results: Array<{ name: string; slug: string }> | null }
            if (results) {
              for (const row of results) {
                existingJobSlugs.set(row.name, row.slug)
              }
            }
          } catch (e) {
          }
        }

        // 같은 계열 전공 조회 (관련 전공)
        let relatedMajorsByCategory: Array<{ id: string; name: string; slug: string }> = []
        const categoryDisplay = (result.profile as any).categoryDisplay
        if (categoryDisplay && env?.DB) {
          try {
            // 같은 계열의 다른 전공 조회 (자기 자신 제외, 최대 15개)
            const query = `
              SELECT id, name, slug
              FROM majors
              WHERE json_extract(merged_profile_json, '$.categoryDisplay') = ?
                AND id != ?
                AND is_active = 1
              ORDER BY name
              LIMIT 15
            `
            const { results } = await env.DB.prepare(query)
              .bind(categoryDisplay, actualDbId)
              .all() as { results: Array<{ id: string; name: string; slug: string }> | null }
            if (results) {
              relatedMajorsByCategory = results.map(row => ({
                id: row.id,
                name: row.name,
                slug: row.slug
              }))
            }
          } catch (e) {
          }
        }

        // 이 전공을 참조하는 HowTo 가이드 조회
        let relatedHowtos: Array<{ slug: string; title: string; summary: string }> = []
        try {
          if (env?.DB && result.profile?.name) {
            const namePattern = `%"relatedMajors":%"name":"${result.profile.name.replace(/[%_"\\]/g, '')}"%`
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
          profile: {
            ...result.profile,
            id: actualDbId
          },
          existingJobSlugs,
          relatedMajorsByCategory,
          relatedHowtos
        }
      },

      // Step 2: Render HTML
      renderHTML: (result) => {
        mark?.('render-start')
        const profile = result.profile!  // Non-null assertion (we already checked in fetchData)
        const canonicalSlug = composeDetailSlug('major', profile.name, profile.id ?? resolvedId)
        const canonicalPath = `/major/${encodeURIComponent(canonicalSlug)}`
        const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
        const title = `${profile.name} 전공 정보 - Careerwiki`
        const description = createMetaDescription(
          profile.summary,
          profile.employmentRate,
          profile.salaryAfterGraduation,
          profile.jobProspect
        )
        const extraHead = [
          '<meta property="article:modified_time" content="' + new Date().toISOString() + '">',
          createMajorJsonLd(profile, canonicalUrl)
        ].filter(Boolean).join('\n')

        const content = renderUnifiedMajorDetail({
          profile,
          partials: result.partials,
          sources: result.sources,
          existingJobSlugs: result.existingJobSlugs,
          relatedMajorsByCategory: result.relatedMajorsByCategory,
          relatedHowtos: result.relatedHowtos
        })
        mark?.('render-done')

        const majorOgImage = (profile as any).image_url || undefined
        return renderLayoutWithContext(c,
          content,
          escapeHtml(title),
          escapeHtml(description),
          false,
          {
            canonical: canonicalUrl,
            ogUrl: canonicalUrl,
            ogType: 'article',
            ogImage: majorOgImage,
            extraHead
          }
        )
      },

      // Step 3: Extract metadata
      extractMetadata: (result) => {
        const profile = result.profile!  // Non-null assertion (we already checked in fetchData)
        return {
          title: `${profile.name} 전공 정보 - Careerwiki`,
          description: createMetaDescription(
            profile.summary,
            profile.employmentRate,
            profile.salaryAfterGraduation,
            profile.jobProspect
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
      const findSampleMajorDetail = () => {
        const candidates = resolvedId !== slug ? [slug, resolvedId] : [slug]
        for (const candidate of candidates) {
          const sample = getSampleMajorDetail(candidate)
          if (sample) return sample
        }
        return null
      }

      const sample = findSampleMajorDetail()
      if (sample) {
        return renderSampleMajorDetailPage(c, sample)
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
      title: '전공 정보를 불러오지 못했습니다',
      description: '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ctaHref: '/major',
      ctaLabel: '전공위키로 돌아가기'
    })
    c.status(500)
    return c.html(
      renderLayoutWithContext(c,
        fallbackHtml,
        '전공 정보 로드 오류 - Careerwiki',
        '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
      )
    )
  })
})

// Route 2: /majors/:id (legacy D1-based simple major detail page)
majorDetailRoutes.get('/majors/:id', async (c) => {
  const id = c.req.param('id')
  const { DB } = c.env
  const debugMode = c.req.query('debug') === 'true'

  try {
    // D1에서 직접 전공 상세 데이터 조회
    const row = await DB.prepare('SELECT id, name, api_data_json FROM majors WHERE id = ?')
      .bind(id).first<{ id: string; name: string; api_data_json: string }>()

    if (!row || !row.api_data_json) {
      const fallbackHtml = renderDetailFallback({
        icon: 'fa-magnifying-glass',
        title: '전공 정보를 찾을 수 없습니다',
        description: '요청하신 전공 데이터가 존재하지 않거나 삭제되었습니다.',
        ctaHref: '/major',
        ctaLabel: '전공위키로 돌아가기'
      })
      return c.html(renderLayoutWithContext(c,
        fallbackHtml,
        '전공 정보 없음 - Careerwiki',
        '요청하신 전공 정보를 찾을 수 없습니다.'
      ), 404)
    }

    // Parse API data from D1
    const apiData = JSON.parse(row.api_data_json)

    // UnifiedMajorDetail 형식으로 변환
    const profile: UnifiedMajorDetail = {
      id: row.id,
      sourceIds: apiData.merged?.sourceIds || {},
      name: apiData.merged?.name || row.name,
      categoryId: apiData.merged?.categoryId,
      categoryName: apiData.merged?.categoryName,
      summary: apiData.merged?.summary,
      aptitude: apiData.merged?.aptitude,
      relatedMajors: apiData.merged?.relatedMajors,
      mainSubjects: apiData.merged?.mainSubjects,
      licenses: apiData.merged?.licenses,
      universities: apiData.merged?.universities,
      recruitmentStatus: apiData.merged?.recruitmentStatus,
      relatedJobs: apiData.merged?.relatedJobs,
      whatStudy: apiData.merged?.whatStudy,
      howPrepare: apiData.merged?.howPrepare,
      jobProspect: apiData.merged?.jobProspect,
      salaryAfterGraduation: apiData.merged?.salaryAfterGraduation,
      employmentRate: apiData.merged?.employmentRate,
      sources: apiData.merged?.sources || []
    }

    const majorName = profile.name || '전공 정보'
    const summary = profile.summary?.substring(0, 120) || '전공 정보를 제공합니다.'

    // Note: 디버그 모드는 ISR 캐시를 우회하는 별도 라우트에서 처리됩니다.
    // 이 함수는 ISR 캐시 생성용이므로 디버그 모드를 지원하지 않습니다.

    // SEO 최적화된 메타 정보
    const pageTitle = `${majorName} 전공 정보 - 대학 학과, 진로, 취업 | Careerwiki`
    const metaDescription = `${summary}. ${profile.mainSubjects?.length || 0}개 주요 과목, ${profile.relatedJobs?.length || 0}개 관련 직업, ${profile.universities?.length || 0}개 대학 정보 제공.`
    const canonicalUrl = `https://careerwiki.org/majors/${id}`

    // renderUnifiedMajorDetail 템플릿 사용
    const content = renderUnifiedMajorDetail({
      profile,
      partials: apiData.partials || {},
      sources: apiData.sources || {}
    })

    // Schema.org JSON-LD 생성
    const extraHead = [
      createMajorJsonLd(profile, canonicalUrl)
    ].filter(Boolean).join('\n')

    return c.html(renderLayoutWithContext(c,
      content,
      escapeHtml(pageTitle),
      escapeHtml(metaDescription),
      false,
      {
        canonical: canonicalUrl,
        ogUrl: canonicalUrl,
        ogType: 'article',
        extraHead
      }
    ))

  } catch (error) {
    const fallbackHtml = renderDetailFallback({
      icon: 'fa-exclamation-circle',
      iconColor: 'text-red-500',
      title: '전공 정보를 불러오지 못했습니다',
      description: '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
      ctaHref: '/major',
      ctaLabel: '전공위키로 돌아가기'
    })
    c.status(500)
    return c.html(renderLayoutWithContext(c,
      fallbackHtml,
      '전공 정보 로드 오류 - Careerwiki',
      '일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
    ))
  }
})

export { majorDetailRoutes }
