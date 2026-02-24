/**
 * 통합 검색 서비스
 * - 직업, 전공, HowTo 자동완성 검색 (DB에서만 검색)
 * - 선택 강제형 (존재 검증)
 */

export type SearchDomain = 'jobs' | 'majors' | 'howtos' | 'tags'

export interface SearchResult {
  id: string | number
  name: string
  slug: string
  snippet?: string
  category?: string
}

export interface SearchOptions {
  domain: SearchDomain
  query: string
  limit?: number
  typeahead?: boolean  // 자동완성 모드 (prefix 매칭)
}

/**
 * 통합 검색
 */
export async function search(
  db: D1Database,
  options: SearchOptions
): Promise<{ success: boolean; results?: SearchResult[]; error?: string }> {
  const { domain, query, limit = 10, typeahead = true } = options
  
  if (!query || query.trim().length < 1) {
    return { success: true, results: [] }
  }
  
  const searchQuery = query.trim()
  const likePattern = typeahead ? `%${searchQuery}%` : `%${searchQuery}%`
  
  try {
    switch (domain) {
      case 'jobs':
        return await searchJobs(db, searchQuery, likePattern, limit)
      case 'majors':
        return await searchMajors(db, searchQuery, likePattern, limit)
      case 'howtos':
        return await searchHowtos(db, searchQuery, likePattern, limit)
      case 'tags':
        return await searchTags(db, searchQuery, likePattern, limit)
      default:
        return { success: false, error: '지원하지 않는 검색 도메인입니다' }
    }
  } catch (error) {
    return { success: false, error: '검색 중 오류가 발생했습니다' }
  }
}

/**
 * 직업 검색 - jobs 테이블에서 id, name 검색
 */
async function searchJobs(
  db: D1Database,
  query: string,
  likePattern: string,
  limit: number
): Promise<{ success: boolean; results?: SearchResult[]; error?: string }> {
  try {
    const result = await db.prepare(`
      SELECT id, name
      FROM jobs
      WHERE name LIKE ?
      ORDER BY 
        CASE WHEN name = ? THEN 0
             WHEN name LIKE ? THEN 1
             ELSE 2
        END,
        name
      LIMIT ?
    `).bind(likePattern, query, `${query}%`, limit).all<{
      id: string
      name: string
    }>()
    
    const results: SearchResult[] = (result.results ?? []).map(row => ({
      id: row.id,
      name: row.name,
      slug: row.name  // slug로 name 사용 (링크용)
    }))
    
    return { success: true, results }
  } catch (error) {
    return { success: true, results: [] }  // 오류 시 빈 배열 반환
  }
}

/**
 * 전공 검색 - majors 테이블에서 id, name 검색
 */
async function searchMajors(
  db: D1Database,
  query: string,
  likePattern: string,
  limit: number
): Promise<{ success: boolean; results?: SearchResult[]; error?: string }> {
  try {
    const result = await db.prepare(`
      SELECT id, name
      FROM majors
      WHERE name LIKE ?
      ORDER BY 
        CASE WHEN name = ? THEN 0
             WHEN name LIKE ? THEN 1
             ELSE 2
        END,
        name
      LIMIT ?
    `).bind(likePattern, query, `${query}%`, limit).all<{
      id: string
      name: string
    }>()
    
    const results: SearchResult[] = (result.results ?? []).map(row => ({
      id: row.id,
      name: row.name,
      slug: row.name  // slug로 name 사용 (링크용)
    }))
    
    return { success: true, results }
  } catch (error) {
    return { success: true, results: [] }
  }
}

/**
 * HowTo 검색 - pages 테이블에서 page_type='howto' 검색
 */
async function searchHowtos(
  db: D1Database,
  query: string,
  likePattern: string,
  limit: number
): Promise<{ success: boolean; results?: SearchResult[]; error?: string }> {
  try {
    const result = await db.prepare(`
      SELECT id, slug, title
      FROM pages
      WHERE page_type = 'howto'
        AND status = 'published'
        AND title LIKE ?
      ORDER BY 
        CASE WHEN title = ? THEN 0
             WHEN title LIKE ? THEN 1
             ELSE 2
        END,
        updated_at DESC
      LIMIT ?
    `).bind(likePattern, query, `${query}%`, limit).all<{
      id: number
      slug: string
      title: string
    }>()
    
    const results: SearchResult[] = (result.results ?? []).map(row => ({
      id: row.id,
      name: row.title,
      slug: row.slug
    }))
    
    return { success: true, results }
  } catch (error) {
    return { success: true, results: [] }
  }
}

/**
 * 태그 검색
 */
async function searchTags(
  db: D1Database,
  query: string,
  likePattern: string,
  limit: number
): Promise<{ success: boolean; results?: SearchResult[]; error?: string }> {
  try {
    const result = await db.prepare(`
      SELECT id, name, slug, usage_count
      FROM tags
      WHERE name LIKE ?
      ORDER BY 
        CASE WHEN name = ? THEN 0
             WHEN name LIKE ? THEN 1
             ELSE 2
        END,
        usage_count DESC
      LIMIT ?
    `).bind(likePattern, query, `${query}%`, limit).all<{
      id: number
      name: string
      slug: string
      usage_count: number
    }>()
    
    const results: SearchResult[] = (result.results ?? []).map(row => ({
      id: row.id,
      name: row.name,
      slug: row.slug,
      snippet: `${row.usage_count}개 글에서 사용`
    }))
    
    return { success: true, results }
  } catch (error) {
    return { success: true, results: [] }
  }
}

/**
 * ID로 존재 검증 (선택 강제형)
 */
export async function validateExists(
  db: D1Database,
  domain: SearchDomain,
  id: string | number
): Promise<{ exists: boolean; data?: SearchResult }> {
  try {
    switch (domain) {
      case 'jobs': {
        const row = await db.prepare(`SELECT id, name FROM jobs WHERE id = ?`).bind(id).first<{ id: string; name: string }>()
        return row ? { exists: true, data: { id: row.id, name: row.name, slug: row.name } } : { exists: false }
      }
      case 'majors': {
        const row = await db.prepare(`SELECT id, name FROM majors WHERE id = ?`).bind(id).first<{ id: string; name: string }>()
        return row ? { exists: true, data: { id: row.id, name: row.name, slug: row.name } } : { exists: false }
      }
      case 'howtos': {
        const row = await db.prepare(`SELECT id, title, slug FROM pages WHERE id = ? AND page_type = 'howto' AND status = 'published'`).bind(id).first<{ id: number; title: string; slug: string }>()
        return row ? { exists: true, data: { id: row.id, name: row.title, slug: row.slug } } : { exists: false }
      }
      case 'tags': {
        const row = await db.prepare(`SELECT id, name, slug FROM tags WHERE id = ?`).bind(id).first<{ id: number; name: string; slug: string }>()
        return row ? { exists: true, data: { id: row.id, name: row.name, slug: row.slug } } : { exists: false }
      }
      default:
        return { exists: false }
    }
  } catch (error) {
    return { exists: false }
  }
}

/**
 * 인기 태그 조회
 */
export async function getPopularTags(
  db: D1Database,
  limit: number = 20
): Promise<{ success: boolean; tags?: SearchResult[]; error?: string }> {
  try {
    const result = await db.prepare(`
      SELECT id, name, slug, usage_count
      FROM tags
      WHERE usage_count > 0
      ORDER BY usage_count DESC
      LIMIT ?
    `).bind(limit).all<{
      id: number
      name: string
      slug: string
      usage_count: number
    }>()
    
    const tags: SearchResult[] = (result.results ?? []).map(row => ({
      id: row.id,
      name: row.name,
      slug: row.slug,
      snippet: `${row.usage_count}회 사용`
    }))
    
    return { success: true, tags }
  } catch (error) {
    return { success: false, error: '인기 태그 조회 중 오류가 발생했습니다' }
  }
}
