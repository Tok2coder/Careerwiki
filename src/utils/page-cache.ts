/**
 * ISR (Incremental Static Regeneration) Page Cache System
 * 
 * Architecture: Wikipedia/Namu Wiki-style cached dynamic rendering
 * - Cache Hit (99% cases): 50ms (instant return from D1)
 * - Cache Miss (1% cases): 300ms (generate + store + return)
 * - Template Update: Version bump → auto-invalidation → progressive regeneration
 * 
 * Performance:
 * - No pre-build required (0 sec build time)
 * - Scalable to unlimited pages (no build time increase)
 * - Template changes apply instantly (version-based invalidation)
 * 
 * Development Mode:
 * - In development, cache is automatically bypassed to always show latest data
 * - Set DISABLE_ISR_CACHE=true environment variable to disable caching
 */

import type { Context } from 'hono'
import type { D1Database } from '@cloudflare/workers-types'
import { getTemplateVersion } from '../constants/template-versions'
import { weakETag, toNFC } from './etag'
import { matchETag } from './etag'

/**
 * Check if we're in development mode (cache should be disabled)
 * Development mode is detected by:
 * 1. DISABLE_ISR_CACHE environment variable set to 'true'
 * 2. Local development (no Cloudflare Workers env)
 */
function isDevelopmentMode(env?: any): boolean {
  // Check environment variable first
  if (typeof process !== 'undefined' && process.env?.DISABLE_ISR_CACHE === 'true') {
    return true
  }
  
  // Check if running locally (Cloudflare Workers env will have specific bindings)
  // In local dev, env might be undefined or have different structure
  if (!env || typeof env.DB === 'undefined') {
    return true
  }
  
  return false
}

function buildWeakEtag(pageType: string, slug: string, version: number, content: string) {
  const seed = `${version}:${pageType}:${toNFC(slug)}:${content.length}`
  return weakETag(seed)
}

export interface CachedPage {
  content: string
  cache_version: number
  title: string
  description: string | null
  og_image_url: string | null
  created_at: number
  updated_at: number
}

export interface PageGenerator<T> {
  /**
   * Fetch data required for page generation
   */
  fetchData: (slug: string, env: any) => Promise<T>
  
  /**
   * Render HTML from data
   * Should return complete <html> document string
   */
  renderHTML: (data: T) => Promise<string> | string
  
  /**
   * Extract metadata from data for caching
   */
  extractMetadata: (data: T) => {
    title: string
    description?: string
    og_image_url?: string
  }
}

/**
 * Get or generate a wiki-style page with ISR caching
 * 
 * @param slug - URL-friendly page identifier (e.g., 'computer-science')
 * @param pageType - Page category ('major', 'job', 'guide')
 * @param generator - Page generation logic (fetch data + render HTML)
 * @param c - Hono context (for DB access and response)
 * @returns Cached or freshly generated HTML page
 * 
 * @example
 * ```typescript
 * app.get('/major/:slug', async (c) => {
 *   return getOrGeneratePage(
 *     c.req.param('slug'),
 *     'major',
 *     {
 *       fetchData: (slug, env) => getMajorData(slug, env),
 *       renderHTML: (data) => renderToString(<MajorDetailTemplate {...data} />),
 *       extractMetadata: (data) => ({
 *         title: `${data.name} - Careerwiki`,
 *         description: data.overview,
 *       }),
 *     },
 *     c
 *   )
 * })
 * ```
 */
export async function getOrGeneratePage<T>(
  slug: string,
  pageType: 'major' | 'job' | 'guide',
  generator: PageGenerator<T>,
  c: Context
): Promise<Response> {
  const currentVersion = getTemplateVersion(pageType)
  const devMode = isDevelopmentMode(c.env)
  
  // 🆕 캐시 우회 파라미터 확인 (_t 파라미터가 있으면 캐시 무시)
  const bypassCache = c.req.query('_t') !== undefined
  
  // Step 1: Check cache (with version validation) - Production only
  let cached: CachedPage | null = null
  
  if (!devMode && !bypassCache && c.env?.DB) {
    const result = await c.env.DB.prepare(`
      SELECT content, cache_version, title, description, og_image_url, created_at, updated_at
      FROM wiki_pages
      WHERE slug = ? AND page_type = ?
    `).bind(slug, pageType).first()
    cached = (result as CachedPage | null) || null
    
    // Step 2: Cache hit + version match → instant return
    if (cached && cached.cache_version === currentVersion) {
      const etag = buildWeakEtag(pageType, slug, currentVersion, cached.content)
    if (matchETag(c.req.header('If-None-Match'), etag)) {
        c.header('ETag', etag)
        c.header('X-Cache-Status', 'HIT')
        c.status(304)
        return c.body(null)
      }
      // Set cache headers for crawler optimization
      c.header('Cache-Control', 'public, max-age=86400, s-maxage=86400, stale-while-revalidate=604800')
      c.header('X-Cache-Status', 'HIT')
      c.header('X-Template-Version', currentVersion.toString())
      c.header('ETag', etag)
      
      return c.html(cached.content)
    }
  }
  
  // Step 3: Cache miss or version mismatch → regenerate
  
  // Determine cache status for headers
  const cacheStatus = bypassCache ? 'BYPASS' : (cached ? 'VERSION-MISMATCH' : 'MISS')
  
  try {
    // Fetch data
    const data = await generator.fetchData(slug, c.env)
    
    // Render HTML
    const html = await generator.renderHTML(data)
    const etag = buildWeakEtag(pageType, slug, currentVersion, html)
    if (c.req.header('If-None-Match') === etag && !devMode) {
      c.header('ETag', etag)
      c.header('X-Cache-Status', cacheStatus)
      c.status(304)
      return c.body(null)
    }
    
    // Extract metadata
    const metadata = generator.extractMetadata(data)
    
    // 🔧 Validate data before caching
    // Don't cache pages with empty or invalid data
    const isValidPage = metadata.title && 
                        !metadata.title.includes('job:') && 
                        !metadata.title.includes('major:') &&
                        html.length > 10000 && // Minimum HTML size (empty pages are ~5KB)
                        !html.includes('정보가 준비 중입니다')
    
    // Store in cache (only in production mode AND valid data AND not bypassing cache)
    if (!devMode && !bypassCache && c.env?.DB && isValidPage) {
      const now = Math.floor(Date.now() / 1000) // Unix timestamp in seconds
      await c.env.DB.prepare(`
        INSERT OR REPLACE INTO wiki_pages 
        (slug, page_type, content, cache_version, title, description, og_image_url, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      `).bind(
        slug,
        pageType,
        html,
        currentVersion,
        metadata.title,
        metadata.description || null,
        metadata.og_image_url || null,
        cached?.created_at || now, // Preserve original creation time if exists
        now
      ).run()
    } else if (!devMode && !isValidPage) {
      console.warn(`[ISR Skip Cache] Page ${pageType}/${slug} has invalid data, not caching`)
    }
    
    // Set cache headers
    if (devMode || bypassCache) {
      c.header('Cache-Control', 'no-cache, no-store, must-revalidate')
      c.header('X-Cache-Status', bypassCache ? 'BYPASS' : 'DEV-BYPASS')
    } else {
      c.header('Cache-Control', 'public, max-age=86400, s-maxage=86400, stale-while-revalidate=604800')
      c.header('X-Cache-Status', cacheStatus)
    }
    c.header('X-Template-Version', currentVersion.toString())
    c.header('ETag', etag)
    
    return c.html(html)
  } catch (error) {
    console.error(`[ISR Error] ${pageType}/${slug}:`, error)
    
    // If regeneration fails but cache exists, serve stale cache (production only)
    if (!devMode && cached) {
      console.warn(`[ISR Fallback] Serving stale cache for ${pageType}/${slug}`)
      c.header('X-Cache-Status', 'STALE-FALLBACK')
      return c.html(cached.content)
    }
    
    // No cache available, return error
    throw error
  }
}

/**
 * Invalidate cache for specific page(s)
 * Useful for manual cache clearing if needed
 */
export async function invalidatePageCache(
  db: D1Database,
  options: {
    slug?: string
    pageType?: 'major' | 'job' | 'guide'
    jobId?: string  // 🆕 DB ID로 캐시 삭제 지원
    majorId?: string  // 🆕 DB ID로 캐시 삭제 지원
  }
): Promise<number> {
  const { slug, pageType, jobId, majorId } = options
  
  let query = 'DELETE FROM wiki_pages WHERE 1=1'
  const bindings: string[] = []
  
  // 🆕 jobId 또는 majorId가 제공된 경우, 실제 slug를 찾아서 삭제
  if (jobId && pageType === 'job') {
    try {
      // jobId가 복합 형식인 경우 처리
      // - job:G_K000000890 -> K000000890 (Goyong24)
      // - job:C_354 -> C_354 (Careernet) - C_ 유지
      // - job:U_xxx -> U_xxx (User) - U_ 유지
      let dbJobId = jobId
      if (jobId.includes(':')) {
        const parts = jobId.split(':')
        if (parts.length > 1) {
          const lastPart = parts[parts.length - 1]
          // U_나 C_로 시작하면 그대로 사용, G_만 제거
          if (lastPart.startsWith('U_') || lastPart.startsWith('C_')) {
            dbJobId = lastPart
          } else {
            dbJobId = lastPart.replace(/^G_/, '')
          }
        }
      }
      
      // DB에서 실제 job name과 slug를 찾아서 삭제 (is_active 조건 제거 - 삭제된 직업도 캐시 무효화 필요)
      const job = await db.prepare('SELECT name, slug FROM jobs WHERE id = ?')
        .bind(dbJobId)
        .first<{ name: string, slug: string | null }>()
      
      if (job?.name) {
        // name을 slug로 변환 (정규화)
        const normalizedSlug = job.name.toLowerCase()
          .replace(/[-\s,·ㆍ\/()]/g, '')
        
        // 여러 가능한 slug 형식으로 삭제 시도 (DB에 저장된 slug 포함)
        const slugsToDelete = [
          normalizedSlug,
          job.name.toLowerCase(),
          encodeURIComponent(job.name),
          ...(job.slug ? [job.slug] : [])  // DB에 저장된 slug도 시도
        ]
        
        let totalDeleted = 0
        for (const slugToDelete of slugsToDelete) {
          const deleteResult = await db.prepare('DELETE FROM wiki_pages WHERE slug = ? AND page_type = ?')
            .bind(slugToDelete, 'job')
            .run()
          
          if (deleteResult.meta.changes > 0) {
            totalDeleted += deleteResult.meta.changes
          }
        }
        
        // slug로 찾지 못한 경우, pageType만으로 삭제 (fallback)
        if (totalDeleted === 0) {
          console.warn(`[ISR Invalidate] No cache found for jobId: ${jobId}, deleting all job caches as fallback`)
          const result = await db.prepare('DELETE FROM wiki_pages WHERE page_type = ?')
            .bind('job')
            .run()
          totalDeleted = result.meta.changes || 0
        }
        
        return totalDeleted
      }
    } catch (error) {
      console.error('[ISR Invalidate] Failed to find job slug:', error)
    }
  }
  
  if (majorId && pageType === 'major') {
    try {
      // majorId가 복합 형식인 경우 처리 (U_ prefix 유지)
      let dbMajorId = majorId
      if (majorId.includes(':')) {
        const parts = majorId.split(':')
        if (parts.length > 1) {
          const lastPart = parts[parts.length - 1]
          // U_로 시작하면 그대로 사용
          dbMajorId = lastPart.startsWith('U_') ? lastPart : lastPart.replace(/^[A-Z]_/, '')
        }
      }
      
      // majorId로 실제 major name과 slug를 찾아서 삭제 (is_active 조건 제거 - 삭제된 전공도 캐시 무효화 필요)
      const major = await db.prepare('SELECT name, slug FROM majors WHERE id = ?')
        .bind(dbMajorId)
        .first<{ name: string, slug: string | null }>()
      
      if (major?.name) {
        const normalizedSlug = major.name.toLowerCase()
          .replace(/[-\s,·ㆍ\/()]/g, '')
        
        const slugsToDelete = [
          normalizedSlug,
          major.name.toLowerCase(),
          encodeURIComponent(major.name),
          ...(major.slug ? [major.slug] : [])  // DB에 저장된 slug도 시도
        ]
        
        let totalDeleted = 0
        for (const slugToDelete of slugsToDelete) {
          const deleteResult = await db.prepare('DELETE FROM wiki_pages WHERE slug = ? AND page_type = ?')
            .bind(slugToDelete, 'major')
            .run()
          
          if (deleteResult.meta.changes > 0) {
            totalDeleted += deleteResult.meta.changes
          }
        }
        
        return totalDeleted
      }
    } catch (error) {
      console.error('[ISR Invalidate] Failed to find major slug:', error)
    }
  }
  
  // 기존 slug 기반 삭제 로직
  if (slug) {
    query += ' AND slug = ?'
    bindings.push(slug)
  }
  
  if (pageType) {
    query += ' AND page_type = ?'
    bindings.push(pageType)
  }
  
  const result = await db.prepare(query).bind(...bindings).run()
  
  return result.meta.changes || 0
}

/**
 * Get cache statistics
 * Useful for monitoring and debugging
 */
export async function getCacheStats(db: D1Database): Promise<{
  total: number
  byType: Record<string, number>
  byVersion: Record<string, number>
}> {
  const total = await db.prepare('SELECT COUNT(*) as count FROM wiki_pages').first<{ count: number }>()
  
  const byType = await db.prepare(`
    SELECT page_type, COUNT(*) as count 
    FROM wiki_pages 
    GROUP BY page_type
  `).all<{ page_type: string; count: number }>()
  
  const byVersion = await db.prepare(`
    SELECT cache_version, COUNT(*) as count 
    FROM wiki_pages 
    GROUP BY cache_version
  `).all<{ cache_version: number; count: number }>()
  
  return {
    total: total?.count || 0,
    byType: Object.fromEntries(byType.results.map((r: { page_type: string; count: number }) => [r.page_type, r.count])),
    byVersion: Object.fromEntries(byVersion.results.map((r: { cache_version: number; count: number }) => [r.cache_version.toString(), r.count])),
  }
}
