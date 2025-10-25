import type { D1Database } from '@cloudflare/workers-types'

export type PageType = 'job' | 'major' | 'guide'
export type CommentStatus = 'visible' | 'blinded' | 'deleted'
export type VoteDirection = 'up' | 'down' | 'clear'
export type VoteValue = -1 | 0 | 1
export type UserRole = 'super-admin' | 'operator' | 'user'

const DEFAULT_PAGE_CONTENT = '# Synthetic placeholder\n\nThis placeholder record enables comments for SSR pages.'

const BEST_LIKE_THRESHOLD = 8
const BEST_LIMIT = 10
export const REPORT_BLIND_THRESHOLD = 5
const DAILY_VOTE_LIMIT = 5
const VOTE_WINDOW_HOURS = 24
const DEFAULT_IP_DISPLAY_MODE: 'masked' = 'masked'
const MODERATOR_IP_BLOCK_ENABLED = true
const MODERATOR_ROLE_ORDER: ReadonlyArray<UserRole> = ['super-admin', 'operator']
const BLINDED_PLACEHOLDER = '신고 누적으로 블라인드 처리된 댓글입니다.'

const MODERATOR_ROLES: ReadonlySet<UserRole> = new Set(['super-admin', 'operator'])

interface PageRecordRow {
  id: number
  slug: string
  title: string
  page_type: PageType
  summary: string | null
  meta_data: string | null
}

export interface PageRecord extends PageRecordRow {}

export interface CommentRecord {
  id: number
  pageId: number
  parentId: number | null
  authorId: string | null
  nickname: string
  content: string
  likeCount: number
  dislikeCount: number
  reportCount: number
  status: CommentStatus
  isAnonymous: boolean
  displayIp: string | null
  createdAt: string
  viewerVote: VoteValue
}

export interface CommentThread extends CommentRecord {
  replies: CommentRecord[]
  isBest: boolean
}

export interface CommentListResult {
  page: PageRecord
  comments: CommentThread[]
  totalCount: number
  policy: {
    bestLikeThreshold: number
    bestLimit: number
    reportBlindThreshold: number
    requiresAuth: boolean
    dailyVoteLimit: number
    voteWindowHours: number
    ipDisplayMode: 'hash' | 'masked' | 'hidden'
    moderatorIpBlockEnabled: boolean
    moderatorRoles: UserRole[]
  }
}

export interface CreateCommentPayload {
  slug: string
  pageType: PageType
  title: string
  summary?: string | null
  content: string
  nickname?: string | null
  parentId?: number | null
  authorId: string
  isAnonymous?: boolean
  ipHash?: string | null
  displayIp?: string | null
}

export interface VotePayload {
  commentId: number
  userId: string
  direction: VoteDirection
}

export interface ReportPayload {
  commentId: number
  reporterId: string
  reporterIpHash?: string | null
  reason?: string | null
}

export interface IpBlockRecord {
  id: number
  ipHash: string
  reason: string | null
  status: 'active' | 'released'
  blockedBy: string | null
  createdAt: string
  releasedAt: string | null
}

const normalizeNickname = (value: string | null | undefined): string => {
  if (!value) return '익명'
  const trimmed = value.trim()
  return trimmed.length ? trimmed.slice(0, 40) : '익명'
}

const normalizeContent = (value: string): string => value.trim().slice(0, 1000)

const normalizeDisplayIp = (value: string | null | undefined): string | null => {
  if (!value) return null
  return value.trim().slice(0, 80)
}

const sanitizeReason = (value: string | null | undefined, maxLength = 200): string | null => {
  if (!value) return null
  const trimmed = value.trim()
  if (!trimmed) return null
  return trimmed.slice(0, maxLength)
}

const isModeratorRole = (role: UserRole | null | undefined): boolean => (role ? MODERATOR_ROLES.has(role) : false)

const applyViewerPolicy = (record: CommentRecord, role: UserRole): CommentRecord => {
  const allowIp = isModeratorRole(role) ? record.displayIp : record.isAnonymous ? record.displayIp : null
  if (role === 'user' && record.status !== 'visible') {
    return {
      ...record,
      content: BLINDED_PLACEHOLDER,
      displayIp: allowIp,
      likeCount: record.likeCount,
      dislikeCount: record.dislikeCount
    }
  }
  return {
    ...record,
    displayIp: allowIp
  }
}

const mapRowToIpBlock = (row: any): IpBlockRecord => ({
  id: Number(row.id),
  ipHash: String(row.ip_hash),
  reason: typeof row.reason === 'string' ? row.reason : null,
  status: row.status === 'released' ? 'released' : 'active',
  blockedBy: typeof row.blocked_by === 'string' ? row.blocked_by : null,
  createdAt: typeof row.created_at === 'string' ? row.created_at : new Date().toISOString(),
  releasedAt: typeof row.released_at === 'string' ? row.released_at : null
})

const mapRowToComment = (row: any): CommentRecord => {
  const voteRaw = Number(row.viewer_vote ?? 0)
  const viewerVote: VoteValue = voteRaw === 1 ? 1 : voteRaw === -1 ? -1 : 0

  return {
    id: Number(row.id),
    pageId: Number(row.page_id),
    parentId: row.parent_id !== null ? Number(row.parent_id) : null,
    authorId: typeof row.author_id === 'string' ? row.author_id : null,
    nickname: typeof row.nickname === 'string' && row.nickname.trim() ? row.nickname.trim() : '익명',
    content: typeof row.content === 'string' ? row.content : '',
    likeCount: Number(row.likes ?? 0),
    dislikeCount: Number(row.dislike_count ?? 0),
    reportCount: Number(row.report_count ?? 0),
    status: (row.status as CommentStatus) ?? 'visible',
    isAnonymous: Number(row.is_anonymous ?? 0) === 1,
    displayIp: row.display_ip ?? null,
    createdAt: typeof row.created_at === 'string' ? row.created_at : new Date().toISOString(),
    viewerVote
  }
}

const toThreads = (records: CommentRecord[], bestSet: Set<number>): CommentThread[] => {
  const byId = new Map<number, CommentThread>()
  const roots: CommentThread[] = []

  records.forEach((record) => {
    byId.set(record.id, {
      ...record,
      replies: [],
      isBest: bestSet.has(record.id)
    })
  })

  byId.forEach((comment) => {
    if (comment.parentId && byId.has(comment.parentId)) {
      const parent = byId.get(comment.parentId)!
      parent.replies.push(comment)
    } else {
      roots.push(comment)
    }
  })

  byId.forEach((comment) => {
    comment.replies.sort((a, b) => (a.createdAt < b.createdAt ? 1 : -1))
  })

  return roots
}

const recalcCommentVotes = async (db: D1Database, commentId: number): Promise<void> => {
  const counts = await db
    .prepare<{ likes: number; dislikes: number }>(
      `SELECT
         SUM(CASE WHEN vote = 1 THEN 1 ELSE 0 END) AS likes,
         SUM(CASE WHEN vote = -1 THEN 1 ELSE 0 END) AS dislikes
       FROM comment_votes
       WHERE comment_id = ?`
    )
    .bind(commentId)
    .first()

  const likeCount = Number(counts?.likes ?? 0)
  const dislikeCount = Number(counts?.dislikes ?? 0)

  await db
    .prepare(
      `UPDATE comments
       SET likes = ?, dislike_count = ?, flagged = CASE WHEN status = 'visible' THEN 0 ELSE 1 END
       WHERE id = ?`
    )
    .bind(likeCount, dislikeCount, commentId)
    .run()
}

const recalcCommentReports = async (db: D1Database, commentId: number): Promise<void> => {
  const countRow = await db
    .prepare<{ reports: number }>('SELECT COUNT(*) AS reports FROM comment_reports WHERE comment_id = ?')
    .bind(commentId)
    .first()

  const reportCount = Number(countRow?.reports ?? 0)
  let status: CommentStatus | null = null

  if (reportCount >= REPORT_BLIND_THRESHOLD) {
    status = 'blinded'
  }

  const queryParts = ['UPDATE comments SET report_count = ?']
  const bindings: Array<number | string> = [reportCount]

  if (status) {
    queryParts.push(", status = ?, flagged = 1")
    bindings.push(status)
  }

  queryParts.push(' WHERE id = ?')
  bindings.push(commentId)

  await db.prepare(queryParts.join('')).bind(...bindings).run()
}

export const ensurePageRecord = async (
  db: D1Database,
  page: { slug: string; title: string; pageType: PageType; summary?: string | null; meta?: Record<string, unknown> | null }
): Promise<PageRecord> => {
  const existing = await db
    .prepare<PageRecordRow>('SELECT id, slug, title, page_type, summary, meta_data FROM pages WHERE slug = ? LIMIT 1')
    .bind(page.slug)
    .first()

  if (existing) {
    return existing
  }

  const metaJson = page.meta ? JSON.stringify(page.meta) : null

  const result = await db
    .prepare(
      `INSERT INTO pages (slug, title, page_type, content, summary, meta_data)
       VALUES (?, ?, ?, ?, ?, ?)`
    )
    .bind(page.slug, page.title, page.pageType, DEFAULT_PAGE_CONTENT, page.summary ?? null, metaJson)
    .run()

  const pageId = Number(result.meta?.last_row_id)

  return {
    id: pageId,
    slug: page.slug,
    title: page.title,
    page_type: page.pageType,
    summary: page.summary ?? null,
    meta_data: metaJson
  }
}

export const getCommentsForPage = async (
  db: D1Database,
  options: { pageId: number; limit?: number; viewerId?: string | null; viewerRole?: UserRole; includeModerated?: boolean }
): Promise<{ comments: CommentThread[]; totalCount: number }> => {
  const limit = Math.min(Math.max(options.limit ?? 50, 1), 200)
  const viewerId = options.viewerId && options.viewerId.trim().length ? options.viewerId.trim() : null
  const viewerRole = options.viewerRole ?? 'user'
  const includeModerated = options.includeModerated ?? isModeratorRole(viewerRole)

  const selectSql = viewerId
    ? `SELECT c.id, c.page_id, c.parent_id, c.author_id, c.nickname, c.content, c.likes, c.dislike_count, c.report_count,
             c.status, c.is_anonymous, c.display_ip, c.created_at, v.vote AS viewer_vote
       FROM comments c
       LEFT JOIN comment_votes v ON v.comment_id = c.id AND v.user_id = ?
       WHERE c.page_id = ? ${includeModerated ? '' : "AND c.status = 'visible'"}
       ORDER BY c.created_at DESC
       LIMIT ?`
    : `SELECT c.id, c.page_id, c.parent_id, c.author_id, c.nickname, c.content, c.likes, c.dislike_count, c.report_count,
             c.status, c.is_anonymous, c.display_ip, c.created_at, 0 AS viewer_vote
       FROM comments c
       WHERE c.page_id = ? ${includeModerated ? '' : "AND c.status = 'visible'"}
       ORDER BY c.created_at DESC
       LIMIT ?`

  const rows = viewerId
    ? await db.prepare(selectSql).bind(viewerId, options.pageId, limit).all()
    : await db.prepare(selectSql).bind(options.pageId, limit).all()

  const rawRecords = Array.isArray(rows.results) ? rows.results.map(mapRowToComment) : []
  const records = rawRecords.map((record) => applyViewerPolicy(record, viewerRole))

  const bestCandidates = rawRecords
    .filter((record) => record.parentId === null && record.likeCount >= BEST_LIKE_THRESHOLD && record.status === 'visible')
    .sort((a, b) => (a.likeCount < b.likeCount ? 1 : a.likeCount > b.likeCount ? -1 : a.createdAt < b.createdAt ? 1 : -1))
    .slice(0, BEST_LIMIT)

  const bestSet = new Set(bestCandidates.map((comment) => comment.id))
  const threads = toThreads(records, bestSet)

  const bestThreads = threads.filter((thread) => bestSet.has(thread.id))
  const otherThreads = threads
    .filter((thread) => !bestSet.has(thread.id))
    .sort((a, b) => (a.createdAt < b.createdAt ? 1 : -1))

  const orderedThreads = [...bestThreads, ...otherThreads]

  const countRow = await db
    .prepare<{ total: number }>(
      includeModerated
        ? 'SELECT COUNT(*) AS total FROM comments WHERE page_id = ?'
        : "SELECT COUNT(*) AS total FROM comments WHERE page_id = ? AND status = 'visible'"
    )
    .bind(options.pageId)
    .first()

  return {
    comments: orderedThreads,
    totalCount: Number(countRow?.total ?? records.length),
    policy: {
      bestLikeThreshold: BEST_LIKE_THRESHOLD,
      bestLimit: BEST_LIMIT,
      reportBlindThreshold: REPORT_BLIND_THRESHOLD,
      requiresAuth: true,
      dailyVoteLimit: DAILY_VOTE_LIMIT,
      voteWindowHours: VOTE_WINDOW_HOURS,
      ipDisplayMode: DEFAULT_IP_DISPLAY_MODE,
      moderatorIpBlockEnabled: MODERATOR_IP_BLOCK_ENABLED,
      moderatorRoles: [...MODERATOR_ROLE_ORDER]
    }
  }
}

export const getCommentsBySlug = async (
  db: D1Database,
  options: {
    slug: string
    pageType: PageType
    title: string
    summary?: string | null
    limit?: number
    viewerId?: string | null
    viewerRole?: UserRole
    includeModerated?: boolean
  }
): Promise<CommentListResult> => {
  const page = await ensurePageRecord(db, {
    slug: options.slug,
    title: options.title,
    pageType: options.pageType,
    summary: options.summary ?? null
  })

  const { comments, totalCount, policy } = await getCommentsForPage(db, {
    pageId: page.id,
    limit: options.limit,
    viewerId: options.viewerId,
    viewerRole: options.viewerRole,
    includeModerated: options.includeModerated
  })

  return {
    page,
    comments,
    totalCount,
    policy
  }
}

export const createComment = async (db: D1Database, payload: CreateCommentPayload): Promise<CommentRecord> => {
  const trimmedContent = normalizeContent(payload.content)
  if (!trimmedContent) {
    throw new Error('EMPTY_CONTENT')
  }

  if (!payload.authorId || !payload.authorId.trim()) {
    throw new Error('AUTHOR_REQUIRED')
  }

  const nickname = normalizeNickname(payload.nickname)
  const page = await ensurePageRecord(db, {
    slug: payload.slug,
    title: payload.title,
    pageType: payload.pageType,
    summary: payload.summary ?? null
  })

  if (payload.parentId) {
    const parent = await db
      .prepare('SELECT id FROM comments WHERE id = ? AND page_id = ? LIMIT 1')
      .bind(payload.parentId, page.id)
      .first()

    if (!parent) {
      throw new Error('INVALID_PARENT')
    }
  }

  const result = await db
    .prepare(
      `INSERT INTO comments (page_id, parent_id, author_id, nickname, content, ip_hash, is_anonymous, display_ip, status)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'visible')`
    )
    .bind(
      page.id,
      payload.parentId ?? null,
      payload.authorId,
      nickname,
      trimmedContent,
      payload.ipHash ?? null,
      payload.isAnonymous ? 1 : 0,
      normalizeDisplayIp(payload.displayIp)
    )
    .run()

  const commentId = Number(result.meta?.last_row_id)

  const row = await db
    .prepare(
      `SELECT id, page_id, parent_id, author_id, nickname, content, likes, dislike_count, report_count,
              status, is_anonymous, display_ip, created_at, 0 AS viewer_vote
       FROM comments WHERE id = ? LIMIT 1`
    )
    .bind(commentId)
    .first()

  if (!row) {
    throw new Error('COMMENT_NOT_FOUND')
  }

  return mapRowToComment(row)
}

export const setCommentVote = async (db: D1Database, payload: VotePayload): Promise<CommentRecord | null> => {
  if (!payload.userId || !payload.userId.trim()) {
    throw new Error('USER_REQUIRED')
  }

  const voteValue: VoteValue = payload.direction === 'up' ? 1 : payload.direction === 'down' ? -1 : 0

  const target = await db
    .prepare<{ author_id: string | null }>('SELECT author_id FROM comments WHERE id = ? LIMIT 1')
    .bind(payload.commentId)
    .first()

  if (!target) {
    throw new Error('COMMENT_NOT_FOUND')
  }

  if (target.author_id && target.author_id === payload.userId && voteValue !== 0) {
    throw new Error('SELF_VOTE_NOT_ALLOWED')
  }

  const existing = await db
    .prepare<{ id: number; vote: number }>('SELECT id, vote FROM comment_votes WHERE comment_id = ? AND user_id = ? LIMIT 1')
    .bind(payload.commentId, payload.userId)
    .first()

  if (!existing && voteValue !== 0) {
    const limitRow = await db
      .prepare<{ count: number }>('SELECT COUNT(*) AS count FROM comment_votes WHERE user_id = ? AND created_at >= datetime(\'now\', ?)')
      .bind(payload.userId, `-${VOTE_WINDOW_HOURS} hours`)
      .first()
    if (Number(limitRow?.count ?? 0) >= DAILY_VOTE_LIMIT) {
      throw new Error('VOTE_LIMIT_REACHED')
    }
  }

  if (voteValue === 0) {
    if (existing) {
      await db.prepare('DELETE FROM comment_votes WHERE id = ?').bind(existing.id).run()
    }
  } else if (!existing) {
    await db
      .prepare('INSERT INTO comment_votes (comment_id, user_id, vote) VALUES (?, ?, ?)')
      .bind(payload.commentId, payload.userId, voteValue)
      .run()
  } else if (existing.vote !== voteValue) {
    await db
      .prepare('UPDATE comment_votes SET vote = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?')
      .bind(voteValue, existing.id)
      .run()
  }

  await recalcCommentVotes(db, payload.commentId)

  const row = await db
    .prepare(
      `SELECT id, page_id, parent_id, author_id, nickname, content, likes, dislike_count, report_count,
              status, is_anonymous, display_ip, created_at, ? AS viewer_vote
       FROM comments WHERE id = ? LIMIT 1`
    )
    .bind(voteValue, payload.commentId)
    .first()

  return row ? mapRowToComment(row) : null
}

export const reportComment = async (db: D1Database, payload: ReportPayload): Promise<CommentRecord | null> => {
  if (!payload.reporterId || !payload.reporterId.trim()) {
    throw new Error('REPORTER_REQUIRED')
  }

  const target = await db
    .prepare('SELECT id FROM comments WHERE id = ? LIMIT 1')
    .bind(payload.commentId)
    .first()

  if (!target) {
    throw new Error('COMMENT_NOT_FOUND')
  }

  const existing = await db
    .prepare('SELECT id FROM comment_reports WHERE comment_id = ? AND reporter_id = ? LIMIT 1')
    .bind(payload.commentId, payload.reporterId)
    .first()

  if (existing) {
    throw new Error('REPORT_ALREADY_FILED')
  }

  await db
    .prepare(
      `INSERT INTO comment_reports (comment_id, reporter_id, reporter_ip_hash, reason)
       VALUES (?, ?, ?, ?)`
    )
    .bind(payload.commentId, payload.reporterId, payload.reporterIpHash ?? null, sanitizeReason(payload.reason, 300))
    .run()

  await recalcCommentReports(db, payload.commentId)

  const row = await db
    .prepare(
      `SELECT id, page_id, parent_id, author_id, nickname, content, likes, dislike_count, report_count,
              status, is_anonymous, display_ip, created_at, 0 AS viewer_vote
       FROM comments WHERE id = ? LIMIT 1`
    )
    .bind(payload.commentId)
    .first()

  return row ? mapRowToComment(row) : null
}

export const isIpBlocked = async (db: D1Database, ipHash: string | null | undefined): Promise<boolean> => {
  if (!ipHash) return false
  const row = await db
    .prepare<{ count: number }>('SELECT COUNT(*) AS count FROM ip_blocks WHERE ip_hash = ? AND status = "active"')
    .bind(ipHash)
    .first()
  return Number(row?.count ?? 0) > 0
}

export const listIpBlocks = async (
  db: D1Database,
  options?: { includeReleased?: boolean }
): Promise<IpBlockRecord[]> => {
  const includeReleased = Boolean(options?.includeReleased)
  const sql = includeReleased
    ? 'SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks ORDER BY created_at DESC'
    : 'SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks WHERE status = "active" ORDER BY created_at DESC'

  const rows = await db.prepare(sql).all()
  return Array.isArray(rows.results) ? rows.results.map(mapRowToIpBlock) : []
}

export const blockIpAddress = async (
  db: D1Database,
  payload: { ipHash: string | null | undefined; reason?: string | null; blockedBy: string }
): Promise<IpBlockRecord> => {
  const ipHash = payload.ipHash?.trim().toLowerCase()
  if (!ipHash) {
    throw new Error('IP_HASH_REQUIRED')
  }
  if (!payload.blockedBy || !payload.blockedBy.trim()) {
    throw new Error('BLOCK_ACTOR_REQUIRED')
  }

  const reason = sanitizeReason(payload.reason)

  const existing = await db
    .prepare<{ id: number; status: string }>('SELECT id, status FROM ip_blocks WHERE ip_hash = ? LIMIT 1')
    .bind(ipHash)
    .first()

  if (existing) {
    if (existing.status === 'active') {
      throw new Error('IP_ALREADY_BLOCKED')
    }
    await db
      .prepare('UPDATE ip_blocks SET status = "active", reason = ?, blocked_by = ?, created_at = CURRENT_TIMESTAMP, released_at = NULL WHERE id = ?')
      .bind(reason, payload.blockedBy.trim(), existing.id)
      .run()
  } else {
    await db
      .prepare('INSERT INTO ip_blocks (ip_hash, reason, status, blocked_by) VALUES (?, ?, "active", ?)')
      .bind(ipHash, reason, payload.blockedBy.trim())
      .run()
  }

  const row = await db
    .prepare('SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks WHERE ip_hash = ? LIMIT 1')
    .bind(ipHash)
    .first()

  if (!row) {
    throw new Error('IP_BLOCK_NOT_FOUND')
  }

  return mapRowToIpBlock(row)
}

export const releaseIpAddress = async (
  db: D1Database,
  payload: { ipHash: string | null | undefined; releasedBy: string; reason?: string | null }
): Promise<IpBlockRecord | null> => {
  const ipHash = payload.ipHash?.trim().toLowerCase()
  if (!ipHash) {
    throw new Error('IP_HASH_REQUIRED')
  }
  if (!payload.releasedBy || !payload.releasedBy.trim()) {
    throw new Error('RELEASE_ACTOR_REQUIRED')
  }

  const record = await db
    .prepare<{ id: number; status: string }>('SELECT id, status FROM ip_blocks WHERE ip_hash = ? LIMIT 1')
    .bind(ipHash)
    .first()

  if (!record) {
    return null
  }

  if (record.status === 'released') {
    const row = await db
      .prepare('SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks WHERE id = ?')
      .bind(record.id)
      .first()
    return row ? mapRowToIpBlock(row) : null
  }

  const reason = sanitizeReason(payload.reason)

  await db
    .prepare('UPDATE ip_blocks SET status = "released", released_at = CURRENT_TIMESTAMP, reason = COALESCE(?, reason) WHERE id = ?')
    .bind(reason, record.id)
    .run()

  const row = await db
    .prepare('SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks WHERE id = ?')
    .bind(record.id)
    .first()

  return row ? mapRowToIpBlock(row) : null
}
