/**
 * 댓글 API 라우트
 * Phase 1-2: index.tsx에서 추출
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import {
  createComment, getCommentsBySlug, updateComment, deleteComment,
  setCommentVote, reportComment, isIpBlocked,
  blockIpAddress, releaseIpAddress, listIpBlocks,
  type PageType, type UserRole,
} from '../services/commentService'
import {
  getOptionalUser, getClientIp, hashIpAddress, maskIpForDisplay,
  isPageType, buildCommentPageSlug, toParentId, parseNumberParam,
} from '../utils/shared-helpers'

const commentRoutes = new Hono<AppEnv>()

// ============================================
// 댓글 목록 조회
// ============================================
commentRoutes.get('/api/comments', async (c) => {
  const entityTypeRaw = c.req.query('entityType')
  const slugRaw = c.req.query('slug')

  if (!isPageType(entityTypeRaw)) {
    return c.json({ success: false, error: 'entityType must be job, major, or guide' }, 400)
  }

  if (!slugRaw || !slugRaw.trim()) {
    return c.json({ success: false, error: 'slug is required' }, 400)
  }

  const slug = slugRaw.trim()
  const limit = parseNumberParam(c.req.query('limit'), 50, { min: 1, max: 50 })
  const titleParam = c.req.query('title')
  const summaryParam = c.req.query('summary')
  const title = typeof titleParam === 'string' && titleParam.trim().length ? titleParam.trim() : slug
  const summary = typeof summaryParam === 'string' && summaryParam.trim().length ? summaryParam.trim().slice(0, 400) : null
  const viewer = getOptionalUser(c)
  const rawIp = getClientIp(c)
  const ipHash = await hashIpAddress(rawIp)

  try {
    const result = await getCommentsBySlug(c.env.DB, {
      slug: buildCommentPageSlug(entityTypeRaw, slug),
      pageType: entityTypeRaw,
      title,
      summary,
      limit,
      viewerId: viewer?.id ?? null,
      viewerRole: viewer?.role ?? 'user',
      includeModerated: viewer ? viewer.role !== 'user' : false,
      ipHash
    })

    return c.json({
      success: true,
      data: result.comments,
      meta: {
        total: result.totalCount,
        page: {
          id: result.page.id,
          slug: result.page.slug,
          title: result.page.title,
          pageType: result.page.page_type,
          summary: result.page.summary
        },
        viewer: viewer ? { id: viewer.id, name: viewer.name, username: viewer.username, role: viewer.role, pictureUrl: viewer.custom_picture_url || viewer.picture_url || null } : null,
        viewerIp: maskIpForDisplay(rawIp),
        policy: result.policy,
        bestThreshold: result.policy.bestLikeThreshold,
        bestLimit: result.policy.bestLimit,
        reportBlindThreshold: result.policy.reportBlindThreshold,
        nextAnonymousNumber: result.nextAnonymousNumber ?? null
      }
    })
  } catch (error) {
    return c.json({ success: false, error: 'failed to load comments' }, 500)
  }
})

// ============================================
// 댓글 작성
// ============================================
commentRoutes.post('/api/comments', async (c) => {
  let body: any
  try {
    body = await c.req.json()
  } catch {
    return c.json({ success: false, error: 'invalid json body' }, 400)
  }

  const entityType = body?.entityType
  const slugRaw = typeof body?.slug === 'string' ? body.slug : ''
  const contentRaw = typeof body?.content === 'string' ? body.content : ''
  const title = typeof body?.title === 'string' && body.title.trim().length ? body.title.trim() : slugRaw.trim()
  const summary = typeof body?.summary === 'string' && body.summary.trim().length ? body.summary.trim().slice(0, 400) : null
  const parentId = toParentId(body?.parentId)

  if (!isPageType(entityType)) {
    return c.json({ success: false, error: 'entityType must be job, major, or guide' }, 400)
  }

  if (!slugRaw || !slugRaw.trim()) {
    return c.json({ success: false, error: 'slug is required' }, 400)
  }

  if (!contentRaw || !contentRaw.trim()) {
    return c.json({ success: false, error: 'content is required' }, 400)
  }

  // Phase 3 Day 3: 익명 사용자도 댓글 작성 가능
  const user = getOptionalUser(c)

  const slug = slugRaw.trim()
  const ipAddress = getClientIp(c)
  const ipHash = await hashIpAddress(ipAddress)

  if (await isIpBlocked(c.env.DB, ipHash)) {
    return c.json({ success: false, error: 'commenting temporarily restricted' }, 403)
  }

  const anonymousRequested = Boolean(body?.anonymous)
  const nicknameRaw = typeof body?.nickname === 'string' ? body.nickname : null

  // 익명 사용자는 닉네임 입력하지 않음 (익명 번호는 서버에서 자동 배정)
  // 로그인 사용자가 익명으로 작성하는 경우에만 nicknameRaw 사용
  const nickname = anonymousRequested && user
    ? nicknameRaw  // 로그인 사용자가 익명으로 작성하는 경우
    : (user
        ? (nicknameRaw
            ?? user?.username
            ?? (user?.id ? String(user.id) : null))
        : null)  // 로그인 사용자는 닉네임 입력값 → username → id 순서 사용, 익명 사용자는 null
  const displayIp = (anonymousRequested || !user) ? maskIpForDisplay(ipAddress) : null

  try {
    const comment = await createComment(c.env.DB, {
      slug: buildCommentPageSlug(entityType, slug),
      pageType: entityType,
      title: title || slug,
      summary,
      content: contentRaw,
      nickname: nickname,  // 익명 사용자는 null (익명 번호는 서버에서 자동 배정)
      parentId,
      authorId: user?.id ?? null,  // 익명 사용자는 null
      isAnonymous: anonymousRequested || !user,  // 로그인 안 했으면 익명으로 처리
      ipHash,
      displayIp,
      password: body?.password || null  // 익명 사용자는 비밀번호 필요
    })

    return c.json({ success: true, data: { ...comment, authorRole: user?.role ?? null } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'COMMENT_ERROR'
    if (message === 'EMPTY_CONTENT') {
      return c.json({ success: false, error: 'content is required' }, 400)
    }
    if (message === 'INVALID_PARENT') {
      return c.json({ success: false, error: 'invalid parentId' }, 400)
    }
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'AUTHOR_REQUIRED') {
      return c.json({ success: false, error: 'authentication required' }, 401)
    }
    return c.json({ success: false, error: 'failed to create comment' }, 500)
  }
})

// ============================================
// IP 차단 관리 (static routes — must come before :id routes)
// ============================================
commentRoutes.get('/api/comments/ip-blocks', async (c) => {
  const user = getOptionalUser(c)
  if (!user || user.role === 'user') {
    return c.json({ success: false, error: 'moderator access required' }, 403)
  }

  const includeReleased = c.req.query('includeReleased') === '1'

  try {
    const records = await listIpBlocks(c.env.DB, { includeReleased })
    return c.json({ success: true, data: records })
  } catch (error) {
    return c.json({ success: false, error: 'failed to list ip blocks' }, 500)
  }
})

commentRoutes.post('/api/comments/ip-blocks', async (c) => {
  const user = getOptionalUser(c)
  if (!user || user.role === 'user') {
    return c.json({ success: false, error: 'moderator access required' }, 403)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const ipHashRaw = typeof body?.ipHash === 'string' ? body.ipHash.trim() : ''
  const ipRaw = typeof body?.ip === 'string' ? body.ip.trim() : ''
  const ipHash = ipHashRaw || (await hashIpAddress(ipRaw))

  if (!ipHash) {
    return c.json({ success: false, error: 'ip or ipHash is required' }, 400)
  }

  try {
    const record = await blockIpAddress(c.env.DB, {
      ipHash,
      reason: typeof body?.reason === 'string' ? body.reason : null,
      blockedBy: user.id
    })
    return c.json({ success: true, data: record })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to block ip'
    if (message === 'IP_ALREADY_BLOCKED') {
      return c.json({ success: false, error: 'ip already blocked' }, 409)
    }
    if (message === 'IP_HASH_REQUIRED') {
      return c.json({ success: false, error: 'ipHash required' }, 400)
    }
    if (message === 'BLOCK_ACTOR_REQUIRED') {
      return c.json({ success: false, error: 'moderator identifier required' }, 400)
    }
    return c.json({ success: false, error: 'failed to block ip' }, 500)
  }
})

commentRoutes.post('/api/comments/ip-blocks/:hash/release', async (c) => {
  const user = getOptionalUser(c)
  if (!user || user.role === 'user') {
    return c.json({ success: false, error: 'moderator access required' }, 403)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const hashParam = c.req.param('hash')
  const ipHash = typeof hashParam === 'string' ? hashParam.trim() : ''

  if (!ipHash) {
    return c.json({ success: false, error: 'ip hash required' }, 400)
  }

  try {
    const record = await releaseIpAddress(c.env.DB, {
      ipHash,
      releasedBy: user.id,
      reason: typeof body?.reason === 'string' ? body.reason : null
    })

    if (!record) {
      return c.json({ success: false, error: 'ip block not found' }, 404)
    }

    return c.json({ success: true, data: record })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to release ip block'
    if (message === 'IP_HASH_REQUIRED') {
      return c.json({ success: false, error: 'ip hash required' }, 400)
    }
    if (message === 'RELEASE_ACTOR_REQUIRED') {
      return c.json({ success: false, error: 'moderator identifier required' }, 400)
    }
    return c.json({ success: false, error: 'failed to release ip block' }, 500)
  }
})

// ============================================
// 댓글 좋아요/투표
// ============================================
commentRoutes.post('/api/comments/:id/like', async (c) => {
  const commentId = Number(c.req.param('id'))
  if (!Number.isFinite(commentId) || commentId <= 0) {
    return c.json({ success: false, error: 'invalid comment id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const user = getOptionalUser(c)
  const rawIp = getClientIp(c)
  const ipHash = await hashIpAddress(rawIp)
  const voterId = user?.id ?? (ipHash ? `ip:${ipHash}` : null)
  if (!voterId) {
    return c.json({ success: false, error: 'authentication required' }, 401)
  }

  const directionRaw = typeof body?.direction === 'string' ? body.direction.toLowerCase() : 'up'
  const direction = directionRaw === 'down' || directionRaw === 'dislike'
    ? 'down'
    : directionRaw === 'clear' || directionRaw === 'remove'
      ? 'clear'
      : 'up'

  try {
    const comment = await setCommentVote(c.env.DB, {
      commentId,
      userId: voterId,
      direction
    })
    if (!comment) {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    return c.json({ success: true, data: { ...comment, authorRole: user?.role ?? null } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to update like state'
    if (message === 'USER_REQUIRED') {
      return c.json({ success: false, error: 'authentication required' }, 401)
    }
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'SELF_VOTE_NOT_ALLOWED') {
      return c.json({ success: false, error: 'authors cannot vote on their own comments' }, 403)
    }
    if (message === 'VOTE_LIMIT_REACHED') {
      return c.json({ success: false, error: 'vote limit reached' }, 429)
    }
    return c.json({ success: false, error: 'failed to update like state' }, 500)
  }
})

// ============================================
// 댓글 수정
// ============================================
commentRoutes.patch('/api/comments/:id', async (c) => {
  const commentId = Number(c.req.param('id'))
  if (!Number.isFinite(commentId) || commentId <= 0) {
    return c.json({ success: false, error: 'invalid comment id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    return c.json({ success: false, error: 'invalid json body' }, 400)
  }

  const contentRaw = typeof body?.content === 'string' ? body.content : ''
  if (!contentRaw || !contentRaw.trim()) {
    return c.json({ success: false, error: 'content is required' }, 400)
  }

  const user = getOptionalUser(c)
  const passwordRaw = typeof body?.password === 'string' ? body.password : null

  try {
    const comment = await updateComment(c.env.DB, {
      commentId,
      content: contentRaw,
      userId: user?.id ?? null,
      password: passwordRaw ?? null,
      userRole: user?.role as 'user' | 'expert' | 'admin' | null ?? null
    })
    return c.json({ success: true, data: comment })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'COMMENT_ERROR'
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'UNAUTHORIZED') {
      return c.json({ success: false, error: 'unauthorized' }, 403)
    }
    if (message === 'PASSWORD_REQUIRED') {
      return c.json({ success: false, error: 'password is required for anonymous comments' }, 400)
    }
    if (message === 'INVALID_PASSWORD') {
      return c.json({ success: false, error: 'invalid password' }, 403)
    }
    if (message === 'EMPTY_CONTENT') {
      return c.json({ success: false, error: 'content is required' }, 400)
    }
    return c.json({ success: false, error: 'failed to update comment' }, 500)
  }
})

// ============================================
// 댓글 삭제
// ============================================
commentRoutes.delete('/api/comments/:id', async (c) => {
  const commentId = Number(c.req.param('id'))
  if (!Number.isFinite(commentId) || commentId <= 0) {
    return c.json({ success: false, error: 'invalid comment id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json().catch(() => ({}))
  } catch {
    body = {}
  }

  const user = getOptionalUser(c)
  const passwordRaw = typeof body?.password === 'string' ? body.password : null

  try {
    const success = await deleteComment(c.env.DB, {
      commentId,
      userId: user?.id ?? null,
      password: passwordRaw ?? null,
      userRole: user?.role as 'user' | 'expert' | 'admin' | 'super-admin' | 'operator' | null ?? null
    })
    if (!success) {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    return c.json({ success: true })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'COMMENT_ERROR'
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'UNAUTHORIZED') {
      return c.json({ success: false, error: 'unauthorized' }, 403)
    }
    if (message === 'PASSWORD_REQUIRED') {
      return c.json({ success: false, error: 'password is required for anonymous comments' }, 400)
    }
    if (message === 'INVALID_PASSWORD') {
      return c.json({ success: false, error: 'invalid password' }, 403)
    }
    return c.json({ success: false, error: 'failed to delete comment' }, 500)
  }
})

// ============================================
// 댓글 신고
// ============================================
commentRoutes.post('/api/comments/:id/flag', async (c) => {
  const commentId = Number(c.req.param('id'))
  if (!Number.isFinite(commentId) || commentId <= 0) {
    return c.json({ success: false, error: 'invalid comment id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const user = getOptionalUser(c)
  if (!user) {
    return c.json({ success: false, error: 'authentication required' }, 401)
  }

  const ipAddress = c.req.header('cf-connecting-ip') ?? null
  const ipHash = await hashIpAddress(ipAddress)

  try {
    const comment = await reportComment(c.env.DB, {
      commentId,
      reporterId: user.id,
      reporterIpHash: ipHash,
      reason: typeof body?.reason === 'string' ? body.reason.slice(0, 200) : null
    })
    if (!comment) {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    return c.json({
      success: true,
      data: {
        ...comment,
        blinded: comment.status !== 'visible'
      }
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to flag comment'
    if (message === 'REPORTER_REQUIRED') {
      return c.json({ success: false, error: 'authentication required' }, 401)
    }
    if (message === 'COMMENT_NOT_FOUND') {
      return c.json({ success: false, error: 'comment not found' }, 404)
    }
    if (message === 'REPORT_ALREADY_FILED') {
      return c.json({ success: false, error: 'duplicate report not allowed' }, 409)
    }
    return c.json({ success: false, error: 'failed to flag comment' }, 500)
  }
})

export { commentRoutes }
