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
  
  // Step 1: Check cache (with version validation) - Production only
  let cached: CachedPage | null = null
  
  if (!devMode && c.env?.DB) {
    const result = await c.env.DB.prepare(`
      SELECT content, cache_version, title, description, og_image_url, created_at, updated_at
      FROM wiki_pages
      WHERE slug = ? AND page_type = ?
    `).bind(slug, pageType).first()
    cached = (result as CachedPage | null) || null
    
    // Step 2: Cache hit + version match → instant return
    if (cached && cached.cache_version === currentVersion) {
      // Set cache headers for crawler optimization
      c.header('Cache-Control', 'public, max-age=86400, s-maxage=86400, stale-while-revalidate=604800')
      c.header('X-Cache-Status', 'HIT')
      c.header('X-Template-Version', currentVersion.toString())
      
      return c.html(cached.content)
    }
  }
  
  // Step 3: Cache miss or version mismatch → regenerate
  
  try {
    // Fetch data
    const data = await generator.fetchData(slug, c.env)
    
    // Render HTML
    const html = await generator.renderHTML(data)
    
    // Extract metadata
    const metadata = generator.extractMetadata(data)
    
    // Store in cache (only in production mode)
    if (!devMode && c.env?.DB) {
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
    }
    
    // Set cache headers
    if (devMode) {
      c.header('Cache-Control', 'no-cache, no-store, must-revalidate')
      c.header('X-Cache-Status', 'DEV-BYPASS')
    } else {
      c.header('Cache-Control', 'public, max-age=86400, s-maxage=86400, stale-while-revalidate=604800')
      c.header('X-Cache-Status', cacheStatus)
    }
    c.header('X-Template-Version', currentVersion.toString())
    
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
  }
): Promise<number> {
  const { slug, pageType } = options
  
  let query = 'DELETE FROM wiki_pages WHERE 1=1'
  const bindings: string[] = []
  
  if (slug) {
    query += ' AND slug = ?'
    bindings.push(slug)
  }
  
  if (pageType) {
    query += ' AND page_type = ?'
    bindings.push(pageType)
  }
  
  const result = await db.prepare(query).bind(...bindings).run()
  
  console.log(`[ISR Invalidate] Deleted ${result.meta.changes} cache entries`)
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
