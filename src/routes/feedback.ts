/**
 * 피드백 게시판 라우트 (페이지 + API)
 * Phase 1-3: index.tsx에서 추출
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAuth, requireAdmin } from '../middleware/auth'
import {
  createFeedback, getFeedbackById, listFeedback, deleteFeedback,
  upsertReply, deleteReply, setVisibility, validateFeedbackInput,
  isValidFeedbackStatus, updateFeedbackStatus,
  listFeedbackWithCommentCount, listComments, addComment,
  deleteComment as deleteFeedbackComment, getCommentById,
  autoCloseFeedback,
} from '../services/feedbackService'
import { renderFeedbackPage } from '../templates/feedback'
import { renderFeedbackDetailPage } from '../templates/feedbackDetail'
import { renderUserMenu, isAdminRole, parseNumberParam } from '../utils/shared-helpers'

const feedbackRoutes = new Hono<AppEnv>()

// ── 페이지 라우트 ──────────────────────────────────────────────

// Feedback Board
feedbackRoutes.get('/feedback', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
  const pageSize = parseNumberParam(c.req.query('pageSize'), 20, { min: 1, max: 50 })
  const typeParam = c.req.query('type') || undefined
  const statusParam = c.req.query('status') || undefined
  const type = typeParam && ['bug', 'suggestion', 'question', 'other'].includes(typeParam) ? (typeParam as any) : undefined
  const status = statusParam && ['open', 'closed'].includes(statusParam) ? (statusParam as any) : undefined

  // 자동 종료 처리 (14일 미활동)
  await autoCloseFeedback(c.env.DB, 14)

  const list = await listFeedbackWithCommentCount(c.env.DB, {
    page,
    pageSize,
    type,
    status,
    includePrivate: false,
    userId: user?.id,
  })
  return c.html(
    renderFeedbackPage({
      userMenuHtml,
      isLoggedIn: Boolean(user),
      posts: list.items as any,
      page,
      total: list.total,
      pageSize,
    }),
  )
})

// 피드백 상세
feedbackRoutes.get('/feedback/:id', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  const isAdmin = isAdminRole(user?.role)
  const id = Number(c.req.param('id'))

  if (!Number.isFinite(id)) return c.redirect('/feedback')

  const feedback = await getFeedbackById(c.env.DB, id, { includePrivate: true })
  if (!feedback) return c.redirect('/feedback')

  // 비공개 피드백은 작성자 또는 관리자만 열람 가능
  if (feedback.is_private && !isAdmin && user?.id !== feedback.user_id) {
    return c.redirect('/feedback')
  }

  // 작성자 정보 조회
  const authorRow = await c.env.DB.prepare(
    `SELECT name, username, picture_url FROM users WHERE id = ?`
  ).bind(feedback.user_id).first<{ name: string | null; username: string | null; picture_url: string | null }>()

  const comments = await listComments(c.env.DB, id)
  const hasAdminComment = comments.some((c) => c.is_admin)

  return c.html(
    renderFeedbackDetailPage({
      userMenuHtml,
      isLoggedIn: Boolean(user),
      currentUserId: user?.id,
      isAdmin: Boolean(isAdmin),
      post: {
        ...feedback,
        author_name: authorRow?.username || authorRow?.name || `user_${feedback.user_id}`,
        author_picture: authorRow?.picture_url || null,
        last_activity_at: feedback.last_activity_at || feedback.created_at,
      },
      comments,
      hasAdminComment,
    }),
  )
})

// ── API 라우트 ──────────────────────────────────────────────

feedbackRoutes.post('/api/feedback', requireAuth, async (c) => {
  try {
    const user = c.get('user')
    const body = await c.req.json()
    const validation = validateFeedbackInput(body)
    if (!validation.ok) {
      return c.json({ success: false, error: validation.errors.join(' ') }, 400)
    }

    const isPrivate = Boolean(body?.is_private)

    const post = await createFeedback(c.env.DB, {
      userId: user!.id,
      title: validation.title,
      body: validation.body,
      type: validation.type,
      status: validation.status,
      isPrivate,
      linkUrl: validation.linkUrl,
    })
    return c.json({ success: true, data: post })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_create' }, 500)
  }
})

feedbackRoutes.get('/api/feedback', async (c) => {
  try {
    const user = c.get('user')
    const isAdmin = isAdminRole(user?.role)
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const pageSize = parseNumberParam(c.req.query('pageSize'), 20, { min: 1, max: 50 })
    const typeParam = c.req.query('type') || undefined
    const statusParam = c.req.query('status') || undefined

    const type =
      typeParam && ['bug', 'suggestion', 'question', 'other'].includes(typeParam)
        ? (typeParam as any)
        : undefined
    const status =
      statusParam && ['open', 'closed'].includes(statusParam)
        ? (statusParam as any)
        : undefined

    const result = await listFeedback(c.env.DB, {
      page,
      pageSize,
      type,
      status,
      includePrivate: isAdmin,
    })
    return c.json({ success: true, data: result.items, total: result.total, page, pageSize })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_list' }, 500)
  }
})

// NOTE: static path /api/feedback/comments/:id must come before dynamic /api/feedback/:id
feedbackRoutes.delete('/api/feedback/comments/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const commentId = Number(c.req.param('id'))
    if (!Number.isFinite(commentId)) return c.json({ success: false, error: 'invalid_id' }, 400)

    const comment = await getCommentById(c.env.DB, commentId)
    if (!comment) return c.json({ success: false, error: 'not_found' }, 404)

    // 본인 댓글 또는 관리자만 삭제 가능
    const isAdmin = isAdminRole(user.role)
    if (!isAdmin && comment.user_id !== user.id) {
      return c.json({ success: false, error: 'not_authorized' }, 403)
    }

    await deleteFeedbackComment(c.env.DB, commentId)
    return c.json({ success: true })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_delete_comment' }, 500)
  }
})

feedbackRoutes.get('/api/feedback/:id', async (c) => {
  try {
    const user = c.get('user')
    const isAdmin = isAdminRole(user?.role)
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)

    const item = await getFeedbackById(c.env.DB, id, { includePrivate: isAdmin })
    if (!item) return c.json({ success: false, error: 'not_found' }, 404)

    if (item.is_private && !isAdmin) {
      return c.json({ success: false, error: 'not_found' }, 404)
    }

    return c.json({ success: true, data: item })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_get' }, 500)
  }
})

feedbackRoutes.post('/api/feedback/:id/reply', requireAdmin, async (c) => {
  try {
    const admin = c.get('user')!
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const body = await c.req.json()
    const replyBody = (body?.body || '').trim()
    if (replyBody.length < 3 || replyBody.length > 4000) {
      return c.json({ success: false, error: '답변은 3~4000자여야 합니다.' }, 400)
    }
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)

    const updated = await upsertReply(c.env.DB, {
      postId: id,
      adminId: admin.id,
      body: replyBody,
    })
    return c.json({ success: true, data: updated })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_save_reply' }, 500)
  }
})

feedbackRoutes.put('/api/feedback/:id/reply', requireAdmin, async (c) => {
  try {
    const admin = c.get('user')!
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const body = await c.req.json()
    const replyBody = (body?.body || '').trim()
    if (replyBody.length < 3 || replyBody.length > 4000) {
      return c.json({ success: false, error: '답변은 3~4000자여야 합니다.' }, 400)
    }
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)

    const updated = await upsertReply(c.env.DB, {
      postId: id,
      adminId: admin.id,
      body: replyBody,
    })
    return c.json({ success: true, data: updated })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_save_reply' }, 500)
  }
})

feedbackRoutes.delete('/api/feedback/:id/reply', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)
    await deleteReply(c.env.DB, id)
    return c.json({ success: true })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_delete_reply' }, 500)
  }
})

// 관리자용 피드백 삭제
feedbackRoutes.delete('/api/admin/feedback/:id', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)
    await deleteFeedback(c.env.DB, id)
    return c.json({ success: true })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_delete' }, 500)
  }
})

// 피드백 댓글 추가 (스레드)
feedbackRoutes.post('/api/feedback/:id/comments', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const postId = Number(c.req.param('id'))
    if (!Number.isFinite(postId)) return c.json({ success: false, error: 'invalid_id' }, 400)

    const feedback = await getFeedbackById(c.env.DB, postId, { includePrivate: true })
    if (!feedback) return c.json({ success: false, error: 'not_found' }, 404)

    // 종료된 피드백에는 댓글 불가
    if (feedback.status === 'closed') {
      return c.json({ success: false, error: 'feedback_closed' }, 400)
    }

    // 비공개 피드백은 작성자 또는 관리자만 댓글 가능
    const isAdmin = isAdminRole(user.role)
    if (feedback.is_private && !isAdmin && user.id !== feedback.user_id) {
      return c.json({ success: false, error: 'not_authorized' }, 403)
    }

    const { body } = await c.req.json()
    if (!body || typeof body !== 'string' || body.trim().length < 3 || body.trim().length > 2000) {
      return c.json({ success: false, error: 'invalid_body' }, 400)
    }

    const comment = await addComment(c.env.DB, {
      postId,
      userId: user.id,
      isAdmin: Boolean(isAdmin),
      body: body.trim(),
    })

    return c.json({ success: true, data: comment })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_add_comment' }, 500)
  }
})

feedbackRoutes.patch('/api/feedback/:id/visibility', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const body = await c.req.json()
    const isPrivate = Boolean(body?.is_private)
    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)
    const updated = await setVisibility(c.env.DB, id, isPrivate)
    return c.json({ success: true, data: updated })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_update_visibility' }, 500)
  }
})

// 관리자 - 피드백 상태 변경
feedbackRoutes.patch('/api/admin/feedback/:id/status', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.json({ success: false, error: 'invalid_id' }, 400)
    const body = await c.req.json().catch(() => ({}))
    const status = typeof body.status === 'string' ? body.status.trim() : ''
    if (!isValidFeedbackStatus(status)) return c.json({ success: false, error: 'invalid_status' }, 400)

    const exists = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!exists) return c.json({ success: false, error: 'not_found' }, 404)

    const updated = await updateFeedbackStatus(c.env.DB, id, status)
    return c.json({ success: true, status: updated?.status })
  } catch (error) {
    return c.json({ success: false, error: 'failed_to_update_status' }, 500)
  }
})

export { feedbackRoutes }
