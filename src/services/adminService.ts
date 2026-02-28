/**
 * 관리자 서비스 - DB 쿼리 함수 모음
 */

import type { D1Database, KVNamespace } from '@cloudflare/workers-types'
import { destroyAllUserSessions } from '../utils/session'

// =============================================================================
// 통계 제외 계정 (관리자/테스트)
// =============================================================================

/** 통계에서 제외할 관리자 계정 username 목록 (사용자 수 제외) */
export const EXCLUDED_USERNAMES = ['Tok2', 'imgroot']

/** SQL 서브쿼리: 제외 대상 user id 목록 */
const EXCLUDED_USER_IDS_SUBQUERY = `SELECT id FROM users WHERE username IN ('Tok2', 'imgroot')`

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
  saves?: number
  comments?: number
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
  reason?: string,
  kv?: KVNamespace
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

  // 밴 시 해당 유저의 모든 세션 즉시 파괴
  if (result.meta.changes > 0 && kv) {
    try {
      await destroyAllUserSessions(kv, db, userId, 'ban')
    } catch (error) {
    }
  }

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

  // 활성 사용자 (로그인 사용자, 관리자 제외)
  const activeRow = await db
    .prepare(`SELECT COUNT(*) as count FROM users WHERE last_login_at BETWEEN ? AND ? AND id NOT IN (${EXCLUDED_USER_IDS_SUBQUERY})`)
    .bind(startTs, endTs)
    .first<{ count: number }>()
  const activeUsers = activeRow?.count || 0

  // 신규 가입자 (관리자 제외)
  const newRow = await db
    .prepare(`SELECT COUNT(*) as count FROM users WHERE created_at BETWEEN ? AND ? AND id NOT IN (${EXCLUDED_USER_IDS_SUBQUERY})`)
    .bind(startTs, endTs)
    .first<{ count: number }>()
  const newUsers = newRow?.count || 0

  const mau = activeUsers
  const loginConversion = visits > 0 ? (activeUsers / visits) * 100 : 0
  const bounceRate = null // 데이터 소스 부재로 미집계

  const topJobsResult = await db
    .prepare(`
      SELECT j.slug, j.name, 'job' as type, COALESCE(j.view_count, 0) as views,
        (SELECT COUNT(*) FROM user_bookmarks WHERE item_type = 'job' AND item_slug = j.slug) as saves,
        (SELECT COUNT(*) FROM comments c JOIN pages p ON c.page_id = p.id WHERE p.page_type = 'job' AND p.slug = j.slug AND c.status = 'visible') as comments
      FROM jobs j
      WHERE j.is_active = 1
      ORDER BY j.view_count DESC
      LIMIT ?
    `)
    .bind(topLimit)
    .all<TopPage>()

  const topMajorsResult = await db
    .prepare(`
      SELECT m.slug, m.name, 'major' as type, COALESCE(m.view_count, 0) as views,
        (SELECT COUNT(*) FROM user_bookmarks WHERE item_type = 'major' AND item_slug = m.slug) as saves,
        (SELECT COUNT(*) FROM comments c JOIN pages p ON c.page_id = p.id WHERE p.page_type = 'major' AND p.slug = m.slug AND c.status = 'visible') as comments
      FROM majors m
      WHERE m.is_active = 1
      ORDER BY m.view_count DESC
      LIMIT ?
    `)
    .bind(topLimit)
    .all<TopPage>()

  const topHowtoResult = await db
    .prepare(`
      SELECT p2.slug, p2.title as name, 'howto' as type, COALESCE(p2.view_count, 0) as views,
        (SELECT COUNT(*) FROM user_bookmarks WHERE item_type = 'howto' AND item_slug = p2.slug) as saves,
        (SELECT COUNT(*) FROM comments c WHERE c.page_id = p2.id AND c.status = 'visible') as comments
      FROM pages p2
      WHERE p2.page_type = 'guide'
        AND p2.slug NOT LIKE 'guide:%'
      ORDER BY p2.view_count DESC
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
 * AI 분석기 전환율 통계
 */
export interface AiConversionStats {
  totalRequests: number
  completedRequests: number
  conversionRate: number
  dailyTrend: Array<{ date: string; started: number; completed: number; rate: number }>
}

export async function getAiConversionStats(db: D1Database, params: { startDate: string; endDate: string }): Promise<AiConversionStats> {
  const { startDate, endDate } = params

  // 전체 전환율
  const totalRow = await db.prepare(`
    SELECT
      COUNT(*) as total,
      SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed
    FROM ai_analysis_requests
    WHERE parent_request_id IS NULL
      AND DATE(requested_at) BETWEEN ? AND ?
      AND CAST(user_id AS INTEGER) NOT IN (${EXCLUDED_USER_IDS_SUBQUERY})
  `).bind(startDate, endDate).first<{ total: number; completed: number }>()

  const totalRequests = totalRow?.total || 0
  const completedRequests = totalRow?.completed || 0
  const conversionRate = totalRequests > 0 ? (completedRequests / totalRequests) * 100 : 0

  // 일별 추이
  const dailyRows = await db.prepare(`
    SELECT
      DATE(requested_at) as date,
      COUNT(*) as started,
      SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed
    FROM ai_analysis_requests
    WHERE parent_request_id IS NULL
      AND DATE(requested_at) BETWEEN ? AND ?
      AND CAST(user_id AS INTEGER) NOT IN (${EXCLUDED_USER_IDS_SUBQUERY})
    GROUP BY DATE(requested_at)
    ORDER BY date DESC
    LIMIT 30
  `).bind(startDate, endDate).all<{ date: string; started: number; completed: number }>()

  const dailyTrend = (dailyRows.results || []).map(r => ({
    date: r.date,
    started: r.started || 0,
    completed: r.completed || 0,
    rate: r.started > 0 ? Math.round((r.completed / r.started) * 1000) / 10 : 0
  }))

  return { totalRequests, completedRequests, conversionRate, dailyTrend }
}

/**
 * 콘텐츠 커버리지 통계
 */
export interface CoverageStats {
  jobs: { total: number; edited: number; rate: number }
  majors: { total: number; edited: number; rate: number }
  priorityJobs: Array<{ slug: string; name: string; viewCount: number }>
  priorityMajors: Array<{ slug: string; name: string; viewCount: number }>
}

export async function getCoverageStats(db: D1Database): Promise<CoverageStats> {
  const [jobCoverage, majorCoverage, priorityJobs, priorityMajors] = await Promise.all([
    db.prepare(`
      SELECT
        COUNT(*) as total,
        SUM(CASE WHEN user_contributed_json IS NOT NULL AND user_contributed_json != '{}' THEN 1 ELSE 0 END) as edited
      FROM jobs WHERE is_active = 1
    `).first<{ total: number; edited: number }>(),

    db.prepare(`
      SELECT
        COUNT(*) as total,
        SUM(CASE WHEN user_contributed_json IS NOT NULL AND user_contributed_json != '{}' THEN 1 ELSE 0 END) as edited
      FROM majors WHERE is_active = 1
    `).first<{ total: number; edited: number }>(),

    db.prepare(`
      SELECT slug, name, COALESCE(view_count, 0) as viewCount
      FROM jobs
      WHERE is_active = 1
        AND (user_contributed_json IS NULL OR user_contributed_json = '{}')
      ORDER BY COALESCE(view_count, 0) DESC
      LIMIT 10
    `).all<{ slug: string; name: string; viewCount: number }>(),

    db.prepare(`
      SELECT slug, name, COALESCE(view_count, 0) as viewCount
      FROM majors
      WHERE is_active = 1
        AND (user_contributed_json IS NULL OR user_contributed_json = '{}')
      ORDER BY COALESCE(view_count, 0) DESC
      LIMIT 10
    `).all<{ slug: string; name: string; viewCount: number }>()
  ])

  const jTotal = jobCoverage?.total || 0
  const jEdited = jobCoverage?.edited || 0
  const mTotal = majorCoverage?.total || 0
  const mEdited = majorCoverage?.edited || 0

  return {
    jobs: { total: jTotal, edited: jEdited, rate: jTotal > 0 ? (jEdited / jTotal) * 100 : 0 },
    majors: { total: mTotal, edited: mEdited, rate: mTotal > 0 ? (mEdited / mTotal) * 100 : 0 },
    priorityJobs: (priorityJobs.results || []) as Array<{ slug: string; name: string; viewCount: number }>,
    priorityMajors: (priorityMajors.results || []) as Array<{ slug: string; name: string; viewCount: number }>
  }
}

/**
 * 검색어 통계
 */
export interface SearchStats {
  topQueries: Array<{ query: string; count: number }>
  failedQueries: Array<{ query: string; count: number }>
  totalSearches: number
  failedSearches: number
}

export async function getSearchStats(db: D1Database, params: { startDate: string; endDate: string }): Promise<SearchStats> {
  const { startDate, endDate } = params

  try {
    const [topResult, failedResult, totalResult] = await Promise.all([
      // 인기 검색어 TOP 20
      db.prepare(`
        SELECT query, SUM(count) as total
        FROM search_query_daily
        WHERE stat_date BETWEEN ? AND ?
        GROUP BY query
        ORDER BY total DESC
        LIMIT 20
      `).bind(startDate, endDate).all<{ query: string; total: number }>(),

      // 실패 검색어 TOP 20 (결과 0건)
      db.prepare(`
        SELECT query, SUM(zero_result_count) as fails
        FROM search_query_daily
        WHERE stat_date BETWEEN ? AND ?
          AND zero_result_count > 0
        GROUP BY query
        ORDER BY fails DESC
        LIMIT 20
      `).bind(startDate, endDate).all<{ query: string; fails: number }>(),

      // 전체 검색 수 + 실패 수
      db.prepare(`
        SELECT
          COALESCE(SUM(count), 0) as totalSearches,
          COALESCE(SUM(zero_result_count), 0) as failedSearches
        FROM search_query_daily
        WHERE stat_date BETWEEN ? AND ?
      `).bind(startDate, endDate).first<{ totalSearches: number; failedSearches: number }>()
    ])

    return {
      topQueries: (topResult.results || []).map(r => ({ query: r.query, count: r.total || 0 })),
      failedQueries: (failedResult.results || []).map(r => ({ query: r.query, count: r.fails || 0 })),
      totalSearches: totalResult?.totalSearches || 0,
      failedSearches: totalResult?.failedSearches || 0
    }
  } catch (_e) {
    // search_query_daily 테이블이 아직 없을 경우 빈 데이터 반환
    return {
      topQueries: [],
      failedQueries: [],
      totalSearches: 0,
      failedSearches: 0
    }
  }
}

/**
 * 일별 조회수 추이 통계
 */
export interface DailyViewStatsResult {
  daily: Array<{
    date: string
    job: number
    major: number
    howto: number
    total: number
  }>
  summary: {
    totalViews: number
    avgDaily: number
    maxDay: { date: string; views: number } | null
  }
}

export async function getDailyViewStats(db: D1Database, days: number = 30): Promise<DailyViewStatsResult> {
  try {
    const result = await db.prepare(`
      SELECT stat_date, entity_type, total_views
      FROM daily_view_stats
      WHERE stat_date >= date('now', '-${days} days')
      ORDER BY stat_date ASC
    `).all<{ stat_date: string; entity_type: string; total_views: number }>()

    // 일별로 그룹핑
    const dayMap = new Map<string, { job: number; major: number; howto: number; share: number }>()
    for (const row of (result.results || [])) {
      if (!dayMap.has(row.stat_date)) {
        dayMap.set(row.stat_date, { job: 0, major: 0, howto: 0, share: 0 })
      }
      const entry = dayMap.get(row.stat_date)!
      if (row.entity_type === 'job') entry.job = row.total_views
      else if (row.entity_type === 'major') entry.major = row.total_views
      else if (row.entity_type === 'howto') entry.howto = row.total_views
      else if (row.entity_type === 'share') entry.share = row.total_views
    }

    const daily = Array.from(dayMap.entries()).map(([date, counts]) => ({
      date,
      job: counts.job,
      major: counts.major,
      howto: counts.howto,
      total: counts.job + counts.major + counts.howto + counts.share
    }))

    const totalViews = daily.reduce((sum, d) => sum + d.total, 0)
    const avgDaily = daily.length > 0 ? Math.round(totalViews / daily.length) : 0
    const maxEntry = daily.reduce((max, d) => d.total > (max?.views || 0) ? { date: d.date, views: d.total } : max, null as { date: string; views: number } | null)

    return { daily, summary: { totalViews, avgDaily, maxDay: maxEntry } }
  } catch {
    return { daily: [], summary: { totalViews: 0, avgDaily: 0, maxDay: null } }
  }
}

/**
 * 대시보드 요약 통계 (KPI 카드 데이터)
 */
export async function getDashboardStats(db: D1Database) {
  const [jobs, majors, users, cumulativeViews, cumulativeAnalyses] = await Promise.all([
    db.prepare('SELECT COUNT(*) as count FROM jobs WHERE is_active = 1').first<{ count: number }>(),
    db.prepare('SELECT COUNT(*) as count FROM majors WHERE is_active = 1').first<{ count: number }>(),
    db.prepare('SELECT COUNT(*) as count FROM users').first<{ count: number }>(),
    // 누적 방문 (전체 페이지뷰 합산)
    db.prepare(`
      SELECT
        (SELECT COALESCE(SUM(view_count), 0) FROM jobs WHERE is_active = 1) +
        (SELECT COALESCE(SUM(view_count), 0) FROM majors WHERE is_active = 1) +
        (SELECT COALESCE(SUM(view_count), 0) FROM pages) as totalViews
    `).first<{ totalViews: number }>(),
    // 누적 분석 (관리자/E2E 제외)
    db.prepare(`
      SELECT COUNT(*) as count
      FROM ai_analysis_requests
      WHERE parent_request_id IS NULL
        AND user_id IS NOT NULL
        AND CAST(user_id AS INTEGER) NOT IN (${EXCLUDED_USER_IDS_SUBQUERY})
    `).first<{ count: number }>()
  ])

  return {
    totalUsers: users?.count || 0,
    totalJobs: jobs?.count || 0,
    totalMajors: majors?.count || 0,
    cumulativeViews: cumulativeViews?.totalViews || 0,
    cumulativeAnalyses: cumulativeAnalyses?.count || 0,
  }
}

/**
 * 대시보드 차트 데이터 (일별 조회수 + 분석 수)
 */
export interface DashboardChartData {
  daily: Array<{
    date: string
    job: number
    major: number
    howto: number
    total: number
    analyses: number
  }>
  summary: {
    totalViews: number
    avgDaily: number
    maxDay: { date: string; views: number } | null
    totalAnalyses: number
  }
}

export async function getDashboardChartData(db: D1Database, days: number = 7): Promise<DashboardChartData> {
  try {
    const [viewResult, analysisResult] = await Promise.all([
      // 일별 조회수
      db.prepare(`
        SELECT stat_date, entity_type, total_views
        FROM daily_view_stats
        WHERE stat_date >= date('now', '-${days} days')
        ORDER BY stat_date ASC
      `).all<{ stat_date: string; entity_type: string; total_views: number }>(),
      // 일별 분석 수 (관리자/E2E 제외)
      db.prepare(`
        SELECT DATE(requested_at) as stat_date, COUNT(*) as count
        FROM ai_analysis_requests
        WHERE parent_request_id IS NULL
          AND user_id IS NOT NULL
          AND CAST(user_id AS INTEGER) NOT IN (${EXCLUDED_USER_IDS_SUBQUERY})
          AND requested_at >= date('now', '-${days} days')
        GROUP BY DATE(requested_at)
        ORDER BY stat_date ASC
      `).all<{ stat_date: string; count: number }>()
    ])

    // 일별 조회수 그룹핑
    const dayMap = new Map<string, { job: number; major: number; howto: number; share: number }>()
    for (const row of (viewResult.results || [])) {
      if (!dayMap.has(row.stat_date)) {
        dayMap.set(row.stat_date, { job: 0, major: 0, howto: 0, share: 0 })
      }
      const entry = dayMap.get(row.stat_date)!
      if (row.entity_type === 'job') entry.job = row.total_views
      else if (row.entity_type === 'major') entry.major = row.total_views
      else if (row.entity_type === 'howto') entry.howto = row.total_views
      else if (row.entity_type === 'share') entry.share = row.total_views
    }

    // 분석 수 맵
    const analysisMap = new Map<string, number>()
    for (const row of (analysisResult.results || [])) {
      analysisMap.set(row.stat_date, row.count)
    }

    // 전체 날짜 범위 생성 (빈 날짜도 0으로 채움)
    const allDates: string[] = []
    const now = new Date()
    for (let i = days; i >= 0; i--) {
      const d = new Date(now)
      d.setDate(d.getDate() - i)
      allDates.push(d.toISOString().split('T')[0])
    }

    const daily = allDates.map(date => {
      const counts = dayMap.get(date) || { job: 0, major: 0, howto: 0, share: 0 }
      return {
        date,
        job: counts.job,
        major: counts.major,
        howto: counts.howto,
        total: counts.job + counts.major + counts.howto + counts.share,
        analyses: analysisMap.get(date) || 0,
      }
    })

    const totalViews = daily.reduce((sum, d) => sum + d.total, 0)
    const totalAnalyses = daily.reduce((sum, d) => sum + d.analyses, 0)
    const avgDaily = allDates.length > 0 ? Math.round(totalViews / allDates.length) : 0
    const maxEntry = daily.reduce(
      (max, d) => d.total > (max?.views || 0) ? { date: d.date, views: d.total } : max,
      null as { date: string; views: number } | null
    )

    return { daily, summary: { totalViews, avgDaily, maxDay: maxEntry, totalAnalyses } }
  } catch {
    return { daily: [], summary: { totalViews: 0, avgDaily: 0, maxDay: null, totalAnalyses: 0 } }
  }
}

/**
 * 사용자 유입경로/관심/커리어 통계
 */
export interface UserAttributionStats {
  channelDistribution: Array<{ channel: string; count: number }>
  interestDistribution: Array<{ state: string; count: number }>
  careerDistribution: Array<{ state: string; count: number }>
  totalWithAttribution: number
}

export async function getUserAttributionStats(db: D1Database): Promise<UserAttributionStats> {
  try {
    const [channels, interests, careers, total] = await Promise.all([
      db.prepare(`
        SELECT self_channel as channel, COUNT(*) as count
        FROM user_attributions
        WHERE self_channel IS NOT NULL
        GROUP BY self_channel
        ORDER BY count DESC
      `).all<{ channel: string; count: number }>(),
      db.prepare(`
        SELECT interest_state as state, COUNT(*) as count
        FROM user_attributions
        WHERE interest_state IS NOT NULL
        GROUP BY interest_state
        ORDER BY count DESC
      `).all<{ state: string; count: number }>(),
      db.prepare(`
        SELECT career_state as state, COUNT(*) as count
        FROM user_attributions
        WHERE career_state IS NOT NULL
        GROUP BY career_state
        ORDER BY count DESC
      `).all<{ state: string; count: number }>(),
      db.prepare('SELECT COUNT(*) as count FROM user_attributions').first<{ count: number }>()
    ])
    return {
      channelDistribution: (channels.results || []) as Array<{ channel: string; count: number }>,
      interestDistribution: (interests.results || []) as Array<{ state: string; count: number }>,
      careerDistribution: (careers.results || []) as Array<{ state: string; count: number }>,
      totalWithAttribution: total?.count || 0
    }
  } catch {
    return { channelDistribution: [], interestDistribution: [], careerDistribution: [], totalWithAttribution: 0 }
  }
}

/**
 * 콘텐츠별 조회수/저장수 TOP 통계
 */
export interface ContentViewStats {
  topJobs: Array<{ slug: string; name: string; views: number; bookmarks: number }>
  topMajors: Array<{ slug: string; name: string; views: number; bookmarks: number }>
  topHowtos: Array<{ slug: string; name: string; views: number; bookmarks: number }>
}

export async function getContentViewStats(db: D1Database, limit: number = 20): Promise<ContentViewStats> {
  try {
    const [topJobs, topMajors, topHowtos] = await Promise.all([
      db.prepare(`
        SELECT j.slug, j.name, COALESCE(j.view_count, 0) as views,
          (SELECT COUNT(*) FROM user_bookmarks WHERE item_type = 'job' AND item_slug = j.slug) as bookmarks
        FROM jobs j WHERE j.is_active = 1
        ORDER BY j.view_count DESC LIMIT ?
      `).bind(limit).all<{ slug: string; name: string; views: number; bookmarks: number }>(),
      db.prepare(`
        SELECT m.slug, m.name, COALESCE(m.view_count, 0) as views,
          (SELECT COUNT(*) FROM user_bookmarks WHERE item_type = 'major' AND item_slug = m.slug) as bookmarks
        FROM majors m WHERE m.is_active = 1
        ORDER BY m.view_count DESC LIMIT ?
      `).bind(limit).all<{ slug: string; name: string; views: number; bookmarks: number }>(),
      db.prepare(`
        SELECT p.slug, p.title as name, COALESCE(p.view_count, 0) as views,
          (SELECT COUNT(*) FROM user_bookmarks WHERE item_type = 'howto' AND item_slug = p.slug) as bookmarks
        FROM pages p WHERE p.page_type = 'guide' AND p.slug NOT LIKE 'guide:%'
        ORDER BY p.view_count DESC LIMIT ?
      `).bind(limit).all<{ slug: string; name: string; views: number; bookmarks: number }>()
    ])
    return {
      topJobs: (topJobs.results || []) as Array<{ slug: string; name: string; views: number; bookmarks: number }>,
      topMajors: (topMajors.results || []) as Array<{ slug: string; name: string; views: number; bookmarks: number }>,
      topHowtos: (topHowtos.results || []) as Array<{ slug: string; name: string; views: number; bookmarks: number }>
    }
  } catch {
    return { topJobs: [], topMajors: [], topHowtos: [] }
  }
}




