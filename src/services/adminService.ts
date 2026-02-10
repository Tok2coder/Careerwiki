/**
 * 관리자 서비스 - DB 쿼리 함수 모음
 */

import type { D1Database } from '@cloudflare/workers-types'

// =============================================================================
// 타입 정의
// =============================================================================

export interface UserListParams {
  page?: number
  perPage?: number
  search?: string
  role?: 'user' | 'expert' | 'admin' | 'all'
  status?: 'active' | 'banned' | 'all'
}

export interface UserListResult {
  users: UserRecord[]
  total: number
  page: number
  perPage: number
  totalPages: number
}

export interface UserRecord {
  id: number
  googleId: string
  provider?: string
  providerUserId?: string
  email: string
  name: string | null
  username?: string | null
  pictureUrl: string | null
  role: string
  editCount: number
  commentCount: number
  isBanned: boolean
  banReason: string | null
  bannedUntil: number | null
  lastLoginAt: number | null
  createdAt: number
}

export interface RevisionListParams {
  page?: number
  perPage?: number
  entityType?: 'job' | 'major' | 'howto' | 'all'
  editorType?: 'anonymous' | 'user' | 'admin' | 'all'
  startDate?: string
  endDate?: string
}

export interface RevisionListResult {
  revisions: RevisionRecord[]
  total: number
  page: number
  perPage: number
  totalPages: number
}

export interface RevisionRecord {
  id: number
  entityType: string
  entityId: string
  entityName: string | null
  revisionNumber: number
  isCurrent: boolean
  editorId: string | null
  editorType: string
  editorName: string | null
  changeType: string | null
  changedFields: string | null
  createdAt: string
}

export interface StatsParams {
  startDate: string
  endDate: string
  topLimit?: number
}

export interface StatsResult {
  serpInteractions: DailyStats[]
  searchPatterns: SearchPattern[]
  cacheStats: DailyStats[]
  topPages: TopPage[]
}

export interface AnalyticsMetrics {
  visits: number
  activeUsers: number
  newUsers: number
  mau: number
  loginConversion: number
  bounceRate: number | null
  byType: { type: string; views: number }[]
}

export interface AnalyticsSection {
  topPages: TopPage[]
}

export interface AnalyticsResult {
  overall: AnalyticsMetrics
  jobs: AnalyticsSection
  majors: AnalyticsSection
  howtos: AnalyticsSection
  channels: Array<{ channel: string; visits: number; conversions: number; cvr: number }>
}

type AnalyticsCacheEntry = {
  key: string
  expires: number
  data: AnalyticsResult
}

const ANALYTICS_CACHE_TTL_MS = 5 * 60 * 1000 // 5분
let analyticsCache: AnalyticsCacheEntry | null = null

export interface DailyStats {
  date: string
  count: number
  value?: number
}

export interface SearchPattern {
  keyword: string
  count: number
  category?: string
}

export interface TopPage {
  slug: string
  name: string
  type: string
  views: number
}

// =============================================================================
// 사용자 관리 함수
// =============================================================================

/**
 * 사용자 목록 조회
 */
export async function getUsers(db: D1Database, params: UserListParams): Promise<UserListResult> {
  const page = params.page || 1
  const perPage = params.perPage || 20
  const offset = (page - 1) * perPage
  
  let whereClause = '1=1'
  const queryParams: any[] = []
  
  // 검색
  if (params.search) {
    whereClause += ' AND (email LIKE ? OR name LIKE ? OR username LIKE ?)'
    queryParams.push(`%${params.search}%`, `%${params.search}%`, `%${params.search}%`)
  }
  
  // 역할 필터
  if (params.role && params.role !== 'all') {
    whereClause += ' AND role = ?'
    queryParams.push(params.role)
  }
  
  // 상태 필터
  if (params.status === 'banned') {
    whereClause += ' AND is_banned = 1'
  } else if (params.status === 'active') {
    whereClause += ' AND is_banned = 0'
  }
  
  // 총 개수 조회
  const countResult = await db.prepare(`
    SELECT COUNT(*) as total FROM users WHERE ${whereClause}
  `).bind(...queryParams).first<{ total: number }>()
  
  const total = countResult?.total || 0
  
  // 사용자 목록 조회
  const result = await db.prepare(`
    SELECT 
      id, google_id as googleId, provider, provider_user_id as providerUserId,
      email, name, username, picture_url as pictureUrl,
      role, edit_count as editCount, comment_count as commentCount,
      is_banned as isBanned, ban_reason as banReason, banned_until as bannedUntil,
      last_login_at as lastLoginAt, created_at as createdAt
    FROM users 
    WHERE ${whereClause}
    ORDER BY created_at DESC
    LIMIT ? OFFSET ?
  `).bind(...queryParams, perPage, offset).all()
  
  return {
    users: (result.results || []).map(u => ({
      ...u,
      isBanned: Boolean(u.isBanned)
    })) as UserRecord[],
    total,
    page,
    perPage,
    totalPages: Math.ceil(total / perPage)
  }
}

/**
 * 사용자 역할 변경
 */
export async function updateUserRole(
  db: D1Database, 
  userId: number, 
  role: 'user' | 'expert' | 'admin'
): Promise<boolean> {
  const result = await db.prepare(`
    UPDATE users 
    SET role = ?, updated_at = strftime('%s','now')
    WHERE id = ?
  `).bind(role, userId).run()
  
  return result.meta.changes > 0
}

/**
 * 사용자 차단
 */
export async function banUser(
  db: D1Database,
  userId: number,
  duration: '1d' | '7d' | '30d' | 'permanent',
  reason?: string
): Promise<boolean> {
  let bannedUntil: number | null = null
  
  if (duration !== 'permanent') {
    const now = Math.floor(Date.now() / 1000)
    const durationMap: Record<string, number> = {
      '1d': 86400,
      '7d': 604800,
      '30d': 2592000
    }
    bannedUntil = now + durationMap[duration]
  }
  
  const result = await db.prepare(`
    UPDATE users 
    SET is_banned = 1, 
        ban_reason = ?, 
        banned_until = ?,
        updated_at = strftime('%s','now')
    WHERE id = ?
  `).bind(reason || null, bannedUntil, userId).run()
  
  return result.meta.changes > 0
}

/**
 * 사용자 차단 해제
 */
export async function unbanUser(db: D1Database, userId: number): Promise<boolean> {
  const result = await db.prepare(`
    UPDATE users 
    SET is_banned = 0, 
        ban_reason = NULL, 
        banned_until = NULL,
        updated_at = strftime('%s','now')
    WHERE id = ?
  `).bind(userId).run()
  
  return result.meta.changes > 0
}

// =============================================================================
// 편집 이력 관리 함수
// =============================================================================

/**
 * 편집 이력 목록 조회
 */
export async function getRevisions(db: D1Database, params: RevisionListParams): Promise<RevisionListResult> {
  const page = params.page || 1
  const perPage = params.perPage || 20
  const offset = (page - 1) * perPage
  
  let whereClause = '1=1'
  const queryParams: any[] = []
  
  // 엔티티 타입 필터
  if (params.entityType && params.entityType !== 'all') {
    whereClause += ' AND pr.entity_type = ?'
    queryParams.push(params.entityType)
  }
  
  // 편집자 유형 필터
  if (params.editorType && params.editorType !== 'all') {
    whereClause += ' AND pr.editor_type = ?'
    queryParams.push(params.editorType)
  }
  
  // 날짜 범위 필터
  if (params.startDate) {
    whereClause += ' AND pr.created_at >= ?'
    queryParams.push(params.startDate)
  }
  if (params.endDate) {
    whereClause += ' AND pr.created_at <= ?'
    queryParams.push(params.endDate + ' 23:59:59')
  }
  
  // 총 개수 조회
  const countResult = await db.prepare(`
    SELECT COUNT(*) as total FROM page_revisions pr WHERE ${whereClause}
  `).bind(...queryParams).first<{ total: number }>()
  
  const total = countResult?.total || 0
  
  // 리비전 목록 조회
  const result = await db.prepare(`
    SELECT 
      pr.id,
      pr.entity_type as entityType,
      pr.entity_id as entityId,
      COALESCE(j.name, m.name, pr.entity_id) as entityName,
      pr.revision_number as revisionNumber,
      pr.is_current as isCurrent,
      pr.editor_id as editorId,
      pr.editor_type as editorType,
      pr.editor_name as editorName,
      pr.change_type as changeType,
      pr.changed_fields as changedFields,
      pr.created_at as createdAt
    FROM page_revisions pr
    LEFT JOIN jobs j ON pr.entity_type = 'job' AND pr.entity_id = j.id
    LEFT JOIN majors m ON pr.entity_type = 'major' AND pr.entity_id = m.id
    WHERE ${whereClause}
    ORDER BY pr.created_at DESC
    LIMIT ? OFFSET ?
  `).bind(...queryParams, perPage, offset).all()
  
  return {
    revisions: (result.results || []).map(r => ({
      ...r,
      isCurrent: Boolean(r.isCurrent)
    })) as RevisionRecord[],
    total,
    page,
    perPage,
    totalPages: Math.ceil(total / perPage)
  }
}

/**
 * 리비전 상세 조회
 */
export async function getRevisionById(db: D1Database, revisionId: number): Promise<any | null> {
  const result = await db.prepare(`
    SELECT 
      pr.*,
      COALESCE(j.name, m.name, pr.entity_id) as entityName
    FROM page_revisions pr
    LEFT JOIN jobs j ON pr.entity_type = 'job' AND pr.entity_id = j.id
    LEFT JOIN majors m ON pr.entity_type = 'major' AND pr.entity_id = m.id
    WHERE pr.id = ?
  `).bind(revisionId).first()
  
  return result
}

/**
 * 리비전 복원
 */
export async function restoreRevision(
  db: D1Database,
  revisionId: number,
  adminUserId: number,
  reason?: string
): Promise<boolean> {
  // 복원할 리비전 조회
  const revision = await getRevisionById(db, revisionId)
  if (!revision) return false
  
  // 현재 리비전 해제
  await db.prepare(`
    UPDATE page_revisions 
    SET is_current = 0 
    WHERE entity_type = ? AND entity_id = ? AND is_current = 1
  `).bind(revision.entity_type, revision.entity_id).run()
  
  // 새 리비전 번호 계산
  const maxRevision = await db.prepare(`
    SELECT MAX(revision_number) as maxNum 
    FROM page_revisions 
    WHERE entity_type = ? AND entity_id = ?
  `).bind(revision.entity_type, revision.entity_id).first<{ maxNum: number }>()
  
  const newRevisionNumber = (maxRevision?.maxNum || 0) + 1
  
  // 복원 리비전 생성
  await db.prepare(`
    INSERT INTO page_revisions (
      entity_type, entity_id, revision_number, is_current,
      editor_id, editor_type, editor_name,
      change_type, data_snapshot, created_at
    ) VALUES (?, ?, ?, 1, ?, 'admin', ?, 'restore', ?, datetime('now'))
  `).bind(
    revision.entity_type,
    revision.entity_id,
    newRevisionNumber,
    String(adminUserId),
    reason || `리비전 #${revision.revision_number}에서 복원`,
    revision.data_snapshot
  ).run()
  
  // 실제 데이터 복원 (data_snapshot이 있는 경우)
  if (revision.data_snapshot) {
    const snapshot = JSON.parse(revision.data_snapshot)
    
    if (revision.entity_type === 'job') {
      await db.prepare(`
        UPDATE jobs 
        SET user_contributed_json = ?,
            user_last_updated_at = strftime('%s','now')
        WHERE id = ?
      `).bind(JSON.stringify(snapshot.userContributed || {}), revision.entity_id).run()
    } else if (revision.entity_type === 'major') {
      await db.prepare(`
        UPDATE majors 
        SET user_contributed_json = ?,
            user_last_updated_at = strftime('%s','now')
        WHERE id = ?
      `).bind(JSON.stringify(snapshot.userContributed || {}), revision.entity_id).run()
    }
  }
  
  return true
}

// =============================================================================
// 통계 함수
// =============================================================================

/**
 * 통계 데이터 조회
 */
export async function getStats(db: D1Database, params: StatsParams): Promise<StatsResult> {
  const { startDate, endDate, topLimit = 10 } = params
  
  // SERP 인터랙션 일별 추이
  const serpResult = await db.prepare(`
    SELECT 
      DATE(recorded_at) as date,
      COUNT(*) as count
    FROM serp_interaction_logs
    WHERE DATE(recorded_at) BETWEEN ? AND ?
    GROUP BY DATE(recorded_at)
    ORDER BY date
  `).bind(startDate, endDate).all()
  
  // 검색 패턴 (카테고리별)
  const searchResult = await db.prepare(`
    SELECT 
      category as keyword,
      COUNT(*) as count
    FROM serp_interaction_logs
    WHERE DATE(recorded_at) BETWEEN ? AND ?
      AND category IS NOT NULL
    GROUP BY category
    ORDER BY count DESC
    LIMIT ?
  `).bind(startDate, endDate, topLimit).all()
  
  // 캐시 히트율 일별
  const cacheResult = await db.prepare(`
    SELECT 
      DATE(recorded_at) as date,
      COUNT(*) as total,
      SUM(CASE WHEN cache_status = 'HIT' THEN 1 ELSE 0 END) as hits
    FROM serp_interaction_logs
    WHERE DATE(recorded_at) BETWEEN ? AND ?
    GROUP BY DATE(recorded_at)
    ORDER BY date
  `).bind(startDate, endDate).all()
  
  // TOP 페이지 (wiki_pages DROP됨 → serp_interaction_logs 기반으로 변경)
  const topPagesResult = await db.prepare(`
    SELECT
      sil.page_slug as slug,
      COALESCE(j.name, m.name, sil.page_slug) as name,
      sil.page_type as type,
      COUNT(sil.id) as views
    FROM serp_interaction_logs sil
    LEFT JOIN jobs j ON sil.page_type = 'job' AND sil.page_slug = j.slug
    LEFT JOIN majors m ON sil.page_type = 'major' AND sil.page_slug = m.slug
    WHERE sil.recorded_at BETWEEN ? AND ?
    GROUP BY sil.page_slug, sil.page_type
    ORDER BY views DESC
    LIMIT ?
  `).bind(startDate, endDate, topLimit).all()
  
  return {
    serpInteractions: (serpResult.results || []) as DailyStats[],
    searchPatterns: (searchResult.results || []) as SearchPattern[],
    cacheStats: (cacheResult.results || []).map((r: any) => ({
      date: r.date,
      count: r.total,
      value: r.total > 0 ? (r.hits / r.total) * 100 : 0
    })) as DailyStats[],
    topPages: (topPagesResult.results || []) as TopPage[]
  }
}

/**
 * 확장된 관리자 분석 데이터
 */
export async function getAnalyticsStats(db: D1Database, params: StatsParams): Promise<AnalyticsResult> {
  const { startDate, endDate, topLimit = 10 } = params

  const cacheKey = `${startDate}:${endDate}:${topLimit}`
  const now = Date.now()
  if (analyticsCache && analyticsCache.key === cacheKey && analyticsCache.expires > now) {
    return analyticsCache.data
  }

  // 날짜 범위 UNIX seconds
  const startTs = Math.floor(new Date(`${startDate}T00:00:00Z`).getTime() / 1000)
  const endTs = Math.floor(new Date(`${endDate}T23:59:59Z`).getTime() / 1000)

  // 방문 수 (serp 로그)
  const visitsRow = await db
    .prepare(`SELECT COUNT(*) as count FROM serp_interaction_logs WHERE DATE(recorded_at) BETWEEN ? AND ?`)
    .bind(startDate, endDate)
    .first<{ count: number }>()
  const visits = visitsRow?.count || 0

  // 페이지 타입별 뷰
  const byTypeRows = await db
    .prepare(`
      SELECT page_type as type, COUNT(*) as views
      FROM serp_interaction_logs
      WHERE DATE(recorded_at) BETWEEN ? AND ?
      GROUP BY page_type
    `)
    .bind(startDate, endDate)
    .all<{ type: string; views: number }>()
  const byType = (byTypeRows.results || []).map((r) => ({ type: r.type || 'unknown', views: r.views || 0 }))

  // 활성 사용자 (로그인 사용자)
  const activeRow = await db
    .prepare(`SELECT COUNT(*) as count FROM users WHERE last_login_at BETWEEN ? AND ?`)
    .bind(startTs, endTs)
    .first<{ count: number }>()
  const activeUsers = activeRow?.count || 0

  // 신규 가입자
  const newRow = await db
    .prepare(`SELECT COUNT(*) as count FROM users WHERE created_at BETWEEN ? AND ?`)
    .bind(startTs, endTs)
    .first<{ count: number }>()
  const newUsers = newRow?.count || 0

  const mau = activeUsers
  const loginConversion = visits > 0 ? (activeUsers / visits) * 100 : 0
  const bounceRate = null // 데이터 소스 부재로 미집계

  const topJobsResult = await db
    .prepare(`
      SELECT slug, title as name, 'job' as type, COALESCE(view_count, 0) as views
      FROM pages
      WHERE page_type = 'job'
      ORDER BY view_count DESC
      LIMIT ?
    `)
    .bind(topLimit)
    .all<TopPage>()

  const topMajorsResult = await db
    .prepare(`
      SELECT slug, title as name, 'major' as type, COALESCE(view_count, 0) as views
      FROM pages
      WHERE page_type = 'major'
      ORDER BY view_count DESC
      LIMIT ?
    `)
    .bind(topLimit)
    .all<TopPage>()

  const topHowtoResult = await db
    .prepare(`
      SELECT slug, title as name, 'howto' as type, COALESCE(view_count, 0) as views
      FROM pages
      WHERE page_type = 'guide'
        AND slug NOT LIKE 'guide:%'
      ORDER BY view_count DESC
      LIMIT ?
    `)
    .bind(topLimit)
    .all<TopPage>()

  const result: AnalyticsResult = {
    overall: {
      visits,
      activeUsers,
      newUsers,
      mau,
      loginConversion,
      bounceRate,
      byType
    },
    jobs: { topPages: (topJobsResult.results || []) as TopPage[] },
    majors: { topPages: (topMajorsResult.results || []) as TopPage[] },
    howtos: { topPages: (topHowtoResult.results || []) as TopPage[] },
    channels: [] // 채널별 CVR 데이터 소스 없음
  }

  analyticsCache = {
    key: cacheKey,
    expires: now + ANALYTICS_CACHE_TTL_MS,
    data: result
  }

  return result
}

/**
 * 대시보드 요약 통계
 */
export async function getDashboardStats(db: D1Database) {
  const [jobs, majors, users, todayEdits, cacheStats] = await Promise.all([
    db.prepare('SELECT COUNT(*) as count FROM jobs WHERE is_active = 1').first<{ count: number }>(),
    db.prepare('SELECT COUNT(*) as count FROM majors WHERE is_active = 1').first<{ count: number }>(),
    db.prepare('SELECT COUNT(*) as count FROM users').first<{ count: number }>(),
    db.prepare(`
      SELECT COUNT(*) as count FROM page_revisions 
      WHERE created_at >= datetime('now', '-1 day')
    `).first<{ count: number }>(),
    db.prepare(`
      SELECT 
        COUNT(*) as total,
        SUM(CASE WHEN cache_status = 'HIT' THEN 1 ELSE 0 END) as hits
      FROM serp_interaction_logs
      WHERE recorded_at >= datetime('now', '-1 day')
    `).first<{ total: number; hits: number }>()
  ])
  
  return {
    totalJobs: jobs?.count || 0,
    totalMajors: majors?.count || 0,
    totalUsers: users?.count || 0,
    todayEdits: todayEdits?.count || 0,
    cacheHitRate: cacheStats && cacheStats.total > 0 
      ? (cacheStats.hits / cacheStats.total) * 100 
      : 0
  }
}




