import type { D1Database } from '@cloudflare/workers-types'

type FeedbackType = 'bug' | 'suggestion' | 'question' | 'other'
type FeedbackStatus = 'open' | 'closed'

const ALLOWED_TYPES: FeedbackType[] = ['bug', 'suggestion', 'question', 'other']
const ALLOWED_STATUS: FeedbackStatus[] = ['open', 'closed']

export function isValidFeedbackStatus(value: string): value is FeedbackStatus {
  return ALLOWED_STATUS.includes(value as FeedbackStatus)
}

export function validateFeedbackInput(input: {
  title?: string
  body?: string
  type?: string
  status?: string
  link_url?: string | null
}) {
  const errors: string[] = []
  const title = (input.title || '').trim()
  const body = (input.body || '').trim()
  const type = (input.type || 'suggestion').trim() as FeedbackType
  const status = (input.status || 'open').trim() as FeedbackStatus
  const linkUrl = (input.link_url || '').trim() || null

  if (title.length < 3 || title.length > 120) {
    errors.push('제목은 3~120자여야 합니다.')
  }
  if (body.length < 5 || body.length > 4000) {
    errors.push('내용은 5~4000자여야 합니다.')
  }
  if (!ALLOWED_TYPES.includes(type)) {
    errors.push('유효하지 않은 유형입니다.')
  }
  if (!ALLOWED_STATUS.includes(status)) {
    errors.push('유효하지 않은 상태입니다.')
  }
  if (linkUrl && linkUrl.length > 500) {
    errors.push('링크는 500자 이내여야 합니다.')
  }
  if (linkUrl && !linkUrl.startsWith('http://') && !linkUrl.startsWith('https://')) {
    errors.push('유효한 URL 형식이 아닙니다.')
  }

  return {
    ok: errors.length === 0,
    errors,
    title,
    body,
    type,
    status,
    linkUrl,
  }
}

export async function createFeedback(
  db: D1Database,
  params: {
    userId: number
    title: string
    body: string
    type: FeedbackType
    status: FeedbackStatus
    isPrivate?: boolean
    linkUrl?: string | null
  },
) {
  const isPrivate = params.isPrivate ? 1 : 0
  const linkUrl = params.linkUrl || null
  
  // link_url 컬럼이 있으면 포함, 없으면 기본 INSERT (마이그레이션 미적용 대비)
  let stmt
  try {
    stmt = await db
      .prepare(
        `INSERT INTO feedback_posts (user_id, title, body, type, status, is_private, link_url)
         VALUES (?, ?, ?, ?, ?, ?, ?)`,
      )
      .bind(params.userId, params.title, params.body, params.type, params.status, isPrivate, linkUrl)
      .run()
  } catch (e: any) {
    // link_url 컬럼이 없는 경우 fallback (마이그레이션 미적용)
    if (e?.message?.includes('link_url') || e?.message?.includes('no column')) {
      stmt = await db
        .prepare(
          `INSERT INTO feedback_posts (user_id, title, body, type, status, is_private)
           VALUES (?, ?, ?, ?, ?, ?)`,
        )
        .bind(params.userId, params.title, params.body, params.type, params.status, isPrivate)
        .run()
    } else {
      throw e
    }
  }

  const id = (stmt as any).lastInsertRowId ?? (stmt as any).meta?.last_row_id
  return getFeedbackById(db, id, { includePrivate: true })
}

export async function updateFeedbackStatus(db: D1Database, id: number, status: FeedbackStatus) {
  await db.prepare(`UPDATE feedback_posts SET status = ? WHERE id = ?`).bind(status, id).run()
  return getFeedbackById(db, id, { includePrivate: true })
}

export async function listFeedback(
  db: D1Database,
  params: {
    page: number
    pageSize: number
    type?: FeedbackType
    status?: FeedbackStatus
    includePrivate?: boolean
    userId?: number // 본인이 작성한 비공개 피드백도 볼 수 있게
  },
) {
  const offset = (params.page - 1) * params.pageSize
  const filters: string[] = []
  const binds: any[] = []

  if (params.type) {
    filters.push('type = ?')
    binds.push(params.type)
  }
  if (params.status) {
    filters.push('status = ?')
    binds.push(params.status)
  }
  // 비공개 피드백 필터: 관리자가 아니면 공개 피드백 + 본인의 비공개 피드백만
  if (!params.includePrivate) {
    if (params.userId) {
      filters.push('(is_private = 0 OR user_id = ?)')
      binds.push(params.userId)
    } else {
      filters.push('is_private = 0')
    }
  }

  const where = filters.length ? `WHERE ${filters.join(' AND ')}` : ''
  const totalQuery = await db
    .prepare(`SELECT COUNT(*) as count FROM feedback_posts ${where}`)
    .bind(...binds)
    .first<{ count: number }>()

  const rows = await db
    .prepare(
      `SELECT p.*, r.id as reply_id, r.admin_id as reply_admin_id, r.body as reply_body, r.created_at as reply_created_at, r.updated_at as reply_updated_at,
              (SELECT COUNT(*) FROM feedback_comments c WHERE c.post_id = p.id AND c.is_admin = 1) as admin_comment_count
       FROM feedback_posts p
       LEFT JOIN feedback_replies r ON r.post_id = p.id
       ${where}
       ORDER BY p.created_at DESC
       LIMIT ? OFFSET ?`,
    )
    .bind(...binds, params.pageSize, offset)
    .all()

  return {
    total: totalQuery?.count || 0,
    items: rows.results?.map(mapFeedbackRow) || [],
  }
}

export async function getFeedbackById(
  db: D1Database,
  id: number,
  opts?: { includePrivate?: boolean },
) {
  const row = await db
    .prepare(
      `SELECT p.*, r.id as reply_id, r.admin_id as reply_admin_id, r.body as reply_body, r.created_at as reply_created_at, r.updated_at as reply_updated_at,
              (SELECT COUNT(*) FROM feedback_comments c WHERE c.post_id = p.id AND c.is_admin = 1) as admin_comment_count
       FROM feedback_posts p
       LEFT JOIN feedback_replies r ON r.post_id = p.id
       WHERE p.id = ?`,
    )
    .bind(id)
    .first()

  if (!row) return null
  const mapped = mapFeedbackRow(row)
  if (mapped.is_private && !opts?.includePrivate) return null
  return mapped
}

export async function upsertReply(
  db: D1Database,
  params: { postId: number; adminId: number; body: string },
) {
  const now = Math.floor(Date.now() / 1000)
  await db
    .prepare(
      `INSERT INTO feedback_replies (post_id, admin_id, body, created_at, updated_at)
       VALUES (?, ?, ?, ?, ?)
       ON CONFLICT(post_id) DO UPDATE SET
         body=excluded.body,
         admin_id=excluded.admin_id,
         updated_at=excluded.updated_at`,
    )
    .bind(params.postId, params.adminId, params.body, now, now)
    .run()
  return getFeedbackById(db, params.postId, { includePrivate: true })
}

export async function deleteReply(db: D1Database, postId: number) {
  await db.prepare(`DELETE FROM feedback_replies WHERE post_id = ?`).bind(postId).run()
}

export async function deleteFeedback(db: D1Database, postId: number) {
  await db.prepare(`DELETE FROM feedback_posts WHERE id = ?`).bind(postId).run()
}

export async function setVisibility(db: D1Database, postId: number, isPrivate: boolean) {
  const now = Math.floor(Date.now() / 1000)
  await db
    .prepare(`UPDATE feedback_posts SET is_private = ?, updated_at = ? WHERE id = ?`)
    .bind(isPrivate ? 1 : 0, now, postId)
    .run()
  return getFeedbackById(db, postId, { includePrivate: true })
}

function mapFeedbackRow(row: any) {
  return {
    id: Number(row.id),
    user_id: Number(row.user_id),
    title: String(row.title),
    body: String(row.body),
    link_url: row.link_url ? String(row.link_url) : null,
    type: String(row.type) as FeedbackType,
    status: String(row.status) as FeedbackStatus,
    is_private: Number(row.is_private) === 1,
    created_at: Number(row.created_at),
    updated_at: Number(row.updated_at),
    last_activity_at: row.last_activity_at ? Number(row.last_activity_at) : Number(row.created_at),
    has_admin_comment: Number(row.admin_comment_count || 0) > 0,
    reply: row.reply_id
      ? {
          id: Number(row.reply_id),
          admin_id: Number(row.reply_admin_id),
          body: String(row.reply_body),
          created_at: Number(row.reply_created_at),
          updated_at: Number(row.reply_updated_at),
        }
      : null,
  }
}

// ============ 댓글 (스레드) 관련 함수 ============

export interface FeedbackComment {
  id: number
  post_id: number
  user_id: number | null
  is_admin: boolean
  body: string
  created_at: number
  updated_at: number
  user_name?: string | null
  user_picture?: string | null
}

export async function listComments(db: D1Database, postId: number): Promise<FeedbackComment[]> {
  const rows = await db
    .prepare(
      `SELECT c.*, COALESCE(u.username, u.name) as user_name, u.picture_url as user_picture
       FROM feedback_comments c
       LEFT JOIN users u ON c.user_id = u.id
       WHERE c.post_id = ?
       ORDER BY c.created_at ASC`,
    )
    .bind(postId)
    .all()

  return (rows.results || []).map((row: any) => ({
    id: Number(row.id),
    post_id: Number(row.post_id),
    user_id: row.user_id ? Number(row.user_id) : null,
    is_admin: Number(row.is_admin) === 1,
    body: String(row.body),
    created_at: Number(row.created_at),
    updated_at: Number(row.updated_at),
    user_name: row.user_name ? String(row.user_name) : null,
    user_picture: row.user_picture ? String(row.user_picture) : null,
  }))
}

export async function addComment(
  db: D1Database,
  params: { postId: number; userId: number; isAdmin: boolean; body: string },
) {
  const now = Math.floor(Date.now() / 1000)
  const stmt = await db
    .prepare(
      `INSERT INTO feedback_comments (post_id, user_id, is_admin, body, created_at, updated_at)
       VALUES (?, ?, ?, ?, ?, ?)`,
    )
    .bind(params.postId, params.userId, params.isAdmin ? 1 : 0, params.body, now, now)
    .run()

  // 마지막 활동 시간 업데이트
  await updateLastActivity(db, params.postId)

  const id = (stmt as any).lastInsertRowId ?? (stmt as any).meta?.last_row_id
  return { id, ...params, created_at: now, updated_at: now }
}

export async function deleteComment(db: D1Database, commentId: number) {
  await db.prepare(`DELETE FROM feedback_comments WHERE id = ?`).bind(commentId).run()
}

export async function getCommentById(db: D1Database, commentId: number) {
  const row = await db
    .prepare(`SELECT * FROM feedback_comments WHERE id = ?`)
    .bind(commentId)
    .first()

  if (!row) return null
  return {
    id: Number(row.id),
    post_id: Number(row.post_id),
    user_id: row.user_id ? Number(row.user_id) : null,
    is_admin: Number(row.is_admin) === 1,
    body: String(row.body),
    created_at: Number(row.created_at),
    updated_at: Number(row.updated_at),
  }
}

export async function updateLastActivity(db: D1Database, postId: number) {
  const now = Math.floor(Date.now() / 1000)
  try {
    await db
      .prepare(`UPDATE feedback_posts SET last_activity_at = ? WHERE id = ?`)
      .bind(now, postId)
      .run()
  } catch {
    // last_activity_at 컬럼이 없을 수 있음 (마이그레이션 미적용)
  }
}

// 일정 기간(days) 동안 활동이 없으면 자동 CLOSE
export async function autoCloseFeedback(db: D1Database, inactiveDays: number = 14) {
  const now = Math.floor(Date.now() / 1000)
  const threshold = now - inactiveDays * 24 * 60 * 60

  try {
    const result = await db
      .prepare(
        `UPDATE feedback_posts
         SET status = 'closed'
         WHERE status = 'open'
           AND (last_activity_at IS NULL AND created_at < ?)
            OR (last_activity_at IS NOT NULL AND last_activity_at < ?)`,
      )
      .bind(threshold, threshold)
      .run()

    return (result as any).changes ?? 0
  } catch {
    // last_activity_at 컬럼이 없을 수 있음
    return 0
  }
}

// 댓글 수 포함한 피드백 목록 조회
export async function listFeedbackWithCommentCount(
  db: D1Database,
  params: {
    page: number
    pageSize: number
    type?: FeedbackType
    status?: FeedbackStatus
    includePrivate?: boolean
    userId?: number
  },
) {
  const offset = (params.page - 1) * params.pageSize
  const filters: string[] = []
  const binds: any[] = []

  if (params.type) {
    filters.push('p.type = ?')
    binds.push(params.type)
  }
  if (params.status) {
    filters.push('p.status = ?')
    binds.push(params.status)
  }
  if (!params.includePrivate) {
    if (params.userId) {
      filters.push('(p.is_private = 0 OR p.user_id = ?)')
      binds.push(params.userId)
    } else {
      filters.push('p.is_private = 0')
    }
  }

  const where = filters.length ? `WHERE ${filters.join(' AND ')}` : ''
  const totalQuery = await db
    .prepare(`SELECT COUNT(*) as count FROM feedback_posts p ${where}`)
    .bind(...binds)
    .first<{ count: number }>()

  const rows = await db
    .prepare(
      `SELECT p.*,
              u.name as author_name, u.username as author_username, u.picture_url as author_picture,
              (SELECT COUNT(*) FROM feedback_comments c WHERE c.post_id = p.id) as comment_count,
              (SELECT COUNT(*) FROM feedback_comments c WHERE c.post_id = p.id AND c.is_admin = 1) as admin_comment_count
       FROM feedback_posts p
       LEFT JOIN users u ON p.user_id = u.id
       ${where}
       ORDER BY p.created_at DESC
       LIMIT ? OFFSET ?`,
    )
    .bind(...binds, params.pageSize, offset)
    .all()

  return {
    total: totalQuery?.count || 0,
    items: (rows.results || []).map((row: any) => ({
      id: Number(row.id),
      user_id: Number(row.user_id),
      title: String(row.title),
      body: String(row.body),
      link_url: row.link_url ? String(row.link_url) : null,
      type: String(row.type) as FeedbackType,
      status: String(row.status) as FeedbackStatus,
      is_private: Number(row.is_private) === 1,
      created_at: Number(row.created_at),
      updated_at: Number(row.updated_at),
      last_activity_at: row.last_activity_at ? Number(row.last_activity_at) : Number(row.created_at),
      comment_count: Number(row.comment_count || 0),
      author_name: row.author_username || row.author_name || `user_${row.user_id}`,
      author_picture: row.author_picture || null,
      has_admin_comment: Number(row.admin_comment_count || 0) > 0,
    })),
  }
}

