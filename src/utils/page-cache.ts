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
  
  // D1 캐시 비활성화 (2026-02-09): wiki_pages 테이블 DROP됨
  // CDN 캐싱(s-maxage=86400)으로 대체
  
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
    
    // D1 캐시 쓰기 비활성화 (2026-02-09)
    // CDN 캐싱(s-maxage=86400)으로 충분하며, D1 캐시는 500MB 한도 중 181MB를 차지하므로 비활성화
    // 다시 활성화하려면 아래 주석을 해제
    // if (!devMode && !bypassCache && c.env?.DB && isValidPage) {
    //   const now = Math.floor(Date.now() / 1000)
    //   await c.env.DB.prepare(`
    //     INSERT OR REPLACE INTO wiki_pages
    //     (slug, page_type, content, cache_version, title, description, og_image_url, created_at, updated_at)
    //     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    //   `).bind(slug, pageType, html, currentVersion, metadata.title, metadata.description || null, metadata.og_image_url || null, cached?.created_at || now, now).run()
    // }
    
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
    throw error
  }
}

/**
 * Invalidate cache for specific page(s)
 * Useful for manual cache clearing if needed
 */
// wiki_pages 테이블 DROP됨 (2026-02-10) - no-op
export async function invalidatePageCache(
  _db: D1Database,
  _options: {
    slug?: string
    pageType?: 'major' | 'job' | 'guide'
    jobId?: string
    majorId?: string
  }
): Promise<number> {
  return 0
}

/**
 * Get cache statistics
 * Useful for monitoring and debugging
 */
// wiki_pages 테이블 DROP됨 (2026-02-10) - no-op
export async function getCacheStats(_db: D1Database): Promise<{
  total: number
  byType: Record<string, number>
  byVersion: Record<string, number>
}> {
  return { total: 0, byType: {}, byVersion: {} }
}
