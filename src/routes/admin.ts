/**
 * 관리자 페이지 + API 라우트
 * Phase 1-6: index.tsx에서 추출
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAdmin } from '../middleware/auth'
import { adminAiApi } from '../services/ai-analyzer/admin-api'
import { renderAdminDashboard } from '../templates/admin/adminDashboard'
import { renderAdminAiAnalyzer } from '../templates/admin/adminAiAnalyzer'
import { renderAdminFeedbackPage } from '../templates/admin/adminFeedback'
import { renderAdminFeedbackDetail } from '../templates/admin/adminFeedbackDetail'
import { renderAdminUsers } from '../templates/admin/adminUsers'
import { renderAdminUserDetail } from '../templates/admin/adminUserDetail'
import { renderAdminContent } from '../templates/admin/adminContent'
import { renderAdminStats } from '../templates/admin/adminStats'
import { getUsers, updateUserRole, banUser, unbanUser, getRevisions, restoreRevision as restoreRevisionAdmin, getStats, getAnalyticsStats, getAiConversionStats, getCoverageStats, getSearchStats, getDashboardChartData } from '../services/adminService'
import { listFeedbackWithCommentCount, listComments, getFeedbackById } from '../services/feedbackService'
import { listFlaggedComments, setCommentStatus, resetCommentReports, deleteComment, deleteOrphanReplies } from '../services/commentService'
import { listHowtoReports } from '../services/howtoReportService'
import { getUserAttribution, getUserConsents } from '../services/onboardingService'
import { parseNumberParam } from '../utils/shared-helpers'

const adminRoutes = new Hono<AppEnv>()

// 관리자 대시보드 메인
adminRoutes.get('/admin', requireAdmin, async (c) => {
  try {
    const db = c.env.DB

    // KPI + 차트 + 최근 활동 병렬 조회
    const [kpiStats, chartData, recentEdits, recentUsers] = await Promise.all([
      // KPI 카드 데이터
      (async () => {
        const [jobs, majors, users, cViews, cAnalyses] = await Promise.all([
          db.prepare('SELECT COUNT(*) as count FROM jobs WHERE is_active = 1').first<{ count: number }>(),
          db.prepare('SELECT COUNT(*) as count FROM majors WHERE is_active = 1').first<{ count: number }>(),
          db.prepare('SELECT COUNT(*) as count FROM users').first<{ count: number }>(),
          db.prepare(`
            SELECT
              (SELECT COALESCE(SUM(view_count), 0) FROM jobs WHERE is_active = 1) +
              (SELECT COALESCE(SUM(view_count), 0) FROM majors WHERE is_active = 1) +
              (SELECT COALESCE(SUM(view_count), 0) FROM pages) as totalViews
          `).first<{ totalViews: number }>(),
          db.prepare(`
            SELECT COUNT(*) as count FROM ai_analysis_requests
            WHERE parent_request_id IS NULL
              AND user_id IS NOT NULL
              AND CAST(user_id AS INTEGER) NOT IN (
                SELECT id FROM users WHERE username IN ('Tok2', 'imgroot')
              )
          `).first<{ count: number }>()
        ])
        return {
          totalUsers: users?.count || 0,
          totalJobs: jobs?.count || 0,
          totalMajors: majors?.count || 0,
          cumulativeViews: cViews?.totalViews || 0,
          cumulativeAnalyses: cAnalyses?.count || 0,
        }
      })(),

      // 차트 데이터 (기본 7일)
      getDashboardChartData(db, 7),

      // 최근 편집 5건 (관리자 계정 편집 제외)
      db.prepare(`
        SELECT
          pr.id,
          pr.entity_type as entityType,
          pr.entity_id as entityId,
          COALESCE(j.name, m.name, pr.entity_id) as entityName,
          COALESCE(pr.editor_name, '익명') as editorName,
          COALESCE(pr.editor_type, 'anonymous') as editorType,
          pr.change_type as changeType,
          pr.changed_fields as changedFields,
          pr.created_at as createdAt
        FROM page_revisions pr
        LEFT JOIN jobs j ON pr.entity_type = 'job' AND pr.entity_id = j.id
        LEFT JOIN majors m ON pr.entity_type = 'major' AND pr.entity_id = m.id
        WHERE (pr.editor_id IS NULL OR CAST(pr.editor_id AS INTEGER) NOT IN (
          SELECT id FROM users WHERE username IN ('Tok2', 'imgroot')
        ))
        ORDER BY pr.created_at DESC
        LIMIT 5
      `).all(),

      // 최근 가입 사용자 5명
      db.prepare(`
        SELECT id, name, email, role, created_at as createdAt
        FROM users
        ORDER BY created_at DESC
        LIMIT 5
      `).all()
    ])

    return c.html(renderAdminDashboard({
      stats: kpiStats,
      recentEdits: (recentEdits.results || []) as any[],
      recentUsers: (recentUsers.results || []) as any[],
      chartData
    }))
  } catch (error) {
    console.error('Admin dashboard error:', error)
    return c.text('관리자 대시보드를 불러오는데 실패했습니다.', 500)
  }
})

// ============================================
// 대시보드 차트 API (기간 필터)
// ============================================
adminRoutes.get('/api/admin/dashboard-chart', requireAdmin, async (c) => {
  try {
    const days = parseInt(c.req.query('days') || '7', 10)
    const safeDays = [1, 7, 30].includes(days) ? days : 7
    const data = await getDashboardChartData(c.env.DB, safeDays)
    return c.json(data)
  } catch (error) {
    return c.json({ daily: [], summary: { totalViews: 0, avgDaily: 0, maxDay: null, totalAnalyses: 0 } })
  }
})

// ============================================
// AI Analyzer 관제판
// ============================================

// Admin API 마운트
adminRoutes.route('/admin/api/ai', adminAiApi)

// AI Analyzer 관제판 페이지 (개발환경: localhost 접근 시 인증 우회)
adminRoutes.get('/admin/ai-analyzer', async (c, next) => {
  // 개발환경(localhost)에서는 인증 우회
  const host = c.req.header('host') || ''
  const isLocalhost = host.startsWith('localhost') || host.startsWith('127.0.0.1')
  if (isLocalhost) {
    return next()
  }
  return requireAdmin(c as any, next)
}, async (c) => {
  const db = c.env.DB

  try {
    // AI 추천 핵심 통계 수집
    const [
      totalCompleted, totalRequests, reanalysisCount,
      analysisLast24h, followupLast24h, totalSessions
    ] = await Promise.all([
      db.prepare("SELECT COUNT(*) as count FROM ai_analysis_requests WHERE status = 'completed'").first<{ count: number }>().catch(() => ({ count: 0 })),
      db.prepare("SELECT COUNT(*) as count FROM ai_analysis_requests").first<{ count: number }>().catch(() => ({ count: 0 })),
      db.prepare("SELECT COUNT(*) as count FROM ai_analysis_requests WHERE parent_request_id IS NOT NULL").first<{ count: number }>().catch(() => ({ count: 0 })),
      db.prepare("SELECT COUNT(*) as count FROM ai_analysis_requests WHERE requested_at >= datetime('now', '-24 hours')").first<{ count: number }>().catch(() => ({ count: 0 })),
      db.prepare("SELECT COUNT(*) as count FROM facts WHERE collected_at >= datetime('now', '-24 hours')").first<{ count: number }>().catch(() => ({ count: 0 })),
      db.prepare("SELECT COUNT(DISTINCT session_id) as count FROM ai_analysis_requests").first<{ count: number }>().catch(() => ({ count: 0 })),
    ])

    const { VERSIONS } = await import('../services/ai-analyzer/types')

    return c.html(renderAdminAiAnalyzer({
      overview: {
        totalCompletedAnalyses: totalCompleted?.count || 0,
        totalRequests: totalRequests?.count || 0,
        reanalysisCount: reanalysisCount?.count || 0,
        analysisRequestsLast24h: analysisLast24h?.count || 0,
        followupsLast24h: followupLast24h?.count || 0,
        totalSessions: totalSessions?.count || 0,
        engineVersions: {
          scoring: VERSIONS.scoring,
          recipe: VERSIONS.recipe,
        },
      },
    }))
  } catch (error) {
    return c.text('AI Analyzer 관제판을 불러오는데 실패했습니다: ' + (error instanceof Error ? error.message : 'Unknown'), 500)
  }
})

// 관리자 - 피드백 관리
adminRoutes.get('/admin/feedback', requireAdmin, async (c) => {
  try {
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const pageSize = 20
    const result = await listFeedbackWithCommentCount(c.env.DB, { page, pageSize, includePrivate: true })

    return c.html(
      renderAdminFeedbackPage({
        page,
        total: result.total,
        pageSize,
        items: result.items as any,
      })
    )
  } catch (error) {
    return c.text('피드백 목록을 불러오는데 실패했습니다.', 500)
  }
})

// 피드백 상세
adminRoutes.get('/admin/feedback/:id', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) return c.redirect('/admin/feedback')

    const feedback = await getFeedbackById(c.env.DB, id, { includePrivate: true })
    if (!feedback) return c.redirect('/admin/feedback')

    // 작성자 정보 조회
    const authorRow = await c.env.DB.prepare(
      `SELECT name, username, picture_url FROM users WHERE id = ?`
    ).bind(feedback.user_id).first<{ name: string | null; username: string | null; picture_url: string | null }>()

    // 댓글 목록 조회
    const comments = await listComments(c.env.DB, id)
    const hasAdminComment = comments.some((c) => c.is_admin)

    return c.html(
      renderAdminFeedbackDetail({
        feedback: {
          ...feedback,
          author_name: authorRow?.name || authorRow?.username || `user_${feedback.user_id}`,
          author_picture: authorRow?.picture_url || null,
          last_activity_at: (feedback as any).last_activity_at || feedback.created_at,
        } as any,
        comments,
        hasAdminComment,
      })
    )
  } catch (error) {
    return c.text('피드백을 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 - 사용자 관리 페이지
adminRoutes.get('/admin/users', requireAdmin, async (c) => {
  try {
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    const search = c.req.query('search') || ''
    const role = c.req.query('role') || 'all'
    const status = c.req.query('status') || 'all'

    const result = await getUsers(c.env.DB, {
      page,
      perPage,
      search,
      role: role as any,
      status: status as any
    })

    return c.html(renderAdminUsers({
      users: result.users as any[],
      total: result.total,
      page: result.page,
      perPage: result.perPage,
      totalPages: result.totalPages,
      filters: { search, role, status }
    }))
  } catch (error) {
    return c.text('사용자 목록을 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 - 사용자 상세 페이지
adminRoutes.get('/admin/users/:id', requireAdmin, async (c) => {
  try {
    const userId = parseInt(c.req.param('id'))

    // 사용자 정보 조회
    const userRow = await c.env.DB
      .prepare(`SELECT * FROM users WHERE id = ?`)
      .bind(userId)
      .first()

    if (!userRow) {
      return c.text('사용자를 찾을 수 없습니다.', 404)
    }

    const user = {
      id: Number(userRow.id),
      email: String(userRow.email),
      name: userRow.name ? String(userRow.name) : null,
      username: userRow.username ? String(userRow.username) : null,
      pictureUrl: userRow.picture_url ? String(userRow.picture_url) : null,
      provider: userRow.provider ? String(userRow.provider) : 'google',
      providerUserId: userRow.provider_user_id ? String(userRow.provider_user_id) : null,
      googleId: userRow.google_id ? String(userRow.google_id) : null,
      role: String(userRow.role),
      editCount: Number(userRow.edit_count || 0),
      commentCount: Number(userRow.comment_count || 0),
      isBanned: Number(userRow.is_banned) === 1,
      banReason: userRow.ban_reason ? String(userRow.ban_reason) : null,
      bannedUntil: userRow.banned_until ? Number(userRow.banned_until) : null,
      onboarded: Number(userRow.onboarded || 0) === 1,
      lastLoginAt: userRow.last_login_at ? Number(userRow.last_login_at) : null,
      createdAt: Number(userRow.created_at)
    }

    // 유입경로 조회
    const attributionRow = await getUserAttribution(c.env.DB, userId)
    const attribution = attributionRow ? {
      selfChannel: attributionRow.self_channel,
      selfChannelOther: attributionRow.self_channel_other,
      interestState: attributionRow.interest_state,
      careerState: attributionRow.career_state,
      utmSource: attributionRow.utm_source,
      utmMedium: attributionRow.utm_medium,
      utmCampaign: attributionRow.utm_campaign,
      referrer: attributionRow.referrer,
      firstTouchAt: Math.floor(Date.now() / 1000) // 실제 값으로 교체 필요
    } : null

    // 최근 IP (댓글 기준)
    const latestIpRow = await c.env.DB
      .prepare(`SELECT display_ip FROM comments WHERE author_id = ? AND display_ip IS NOT NULL ORDER BY created_at DESC LIMIT 1`)
      .bind(String(userId))
      .first<{ display_ip: string | null }>()
    const latestIp = latestIpRow?.display_ip ? String(latestIpRow.display_ip) : null

    // 동의 이력 조회
    const consentsData = await getUserConsents(c.env.DB, userId)
    const consents = consentsData.map(consent => ({
      type: consent.type,
      version: consent.version,
      consentedAt: consent.consented_at,
      ip: consent.ip,
      ua: consent.ua
    }))

    // 최근 댓글 조회
    const commentsResult = await c.env.DB
      .prepare(`
        SELECT c.id, c.content, c.moderated, c.original_content, c.created_at, c.status,
               p.page_type, p.slug
        FROM comments c
        JOIN pages p ON p.id = c.page_id
        WHERE c.author_id = ?
        ORDER BY c.created_at DESC
        LIMIT 20
      `)
      .bind(String(userId))
      .all()

    const comments = (commentsResult.results || []).map((row: any) => ({
      id: Number(row.id),
      pageType: String(row.page_type),
      slug: String(row.slug),
      content: String(row.content),
      moderated: Number(row.moderated || 0) === 1,
      originalContent: row.original_content ? String(row.original_content) : undefined,
      createdAt: String(row.created_at),
      status: String(row.status)
    }))

    return c.html(renderAdminUserDetail({
      user,
      attribution,
      consents,
      comments,
      latestIp
    }))
  } catch (error) {
    return c.text('사용자 정보를 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 API - 사용자 댓글 목록
adminRoutes.get('/api/admin/users/:id/comments', requireAdmin, async (c) => {
  try {
    const userId = parseInt(c.req.param('id'))
    const limit = parseInt(c.req.query('limit') || '20')

    const commentsResult = await c.env.DB
      .prepare(`
        SELECT c.id, c.content, c.moderated, c.original_content, c.created_at, c.status,
               p.page_type, p.slug
        FROM comments c
        JOIN pages p ON p.id = c.page_id
        WHERE c.author_id = ?
        ORDER BY c.created_at DESC
        LIMIT ?
      `)
      .bind(String(userId), limit)
      .all()

    const comments = (commentsResult.results || []).map((row: any) => ({
      id: Number(row.id),
      pageType: String(row.page_type),
      slug: String(row.slug),
      content: String(row.content),
      moderated: Number(row.moderated || 0) === 1,
      originalContent: row.original_content ? String(row.original_content) : undefined,
      createdAt: String(row.created_at),
      status: String(row.status)
    }))

    return c.json({ success: true, data: comments })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to get user comments' }, 500)
  }
})

// 관리자 API - 사용자 관리
adminRoutes.patch('/api/admin/users/:id', requireAdmin, async (c) => {
  try {
    const userId = parseInt(c.req.param('id'))
    const body = await c.req.json()

    // 역할 변경
    if (body.role) {
      const success = await updateUserRole(c.env.DB, userId, body.role)
      return c.json({ success })
    }

    // 차단
    if (body.action === 'ban') {
      const success = await banUser(c.env.DB, userId, body.duration, body.reason, c.env.KV)
      return c.json({ success })
    }

    // 차단 해제
    if (body.action === 'unban') {
      const success = await unbanUser(c.env.DB, userId)
      return c.json({ success })
    }

    return c.json({ success: false, error: 'Invalid action' }, 400)
  } catch (error) {
    return c.json({ success: false, error: 'Failed to update user' }, 500)
  }
})

// 관리자 - 콘텐츠/편집 관리 페이지
adminRoutes.get('/admin/content', requireAdmin, async (c) => {
  try {
    const activeTab = (c.req.query('tab') || 'revisions') as 'revisions' | 'archive' | 'comments'
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    const entityType = c.req.query('entityType') || 'all'
    const editorType = c.req.query('editorType') || 'all'
    const startDate = c.req.query('startDate') || ''
    const endDate = c.req.query('endDate') || ''

    // 편집 이력 가져오기
    const result = await getRevisions(c.env.DB, {
      page,
      perPage,
      entityType: entityType as any,
      editorType: editorType as any,
      startDate: startDate || undefined,
      endDate: endDate || undefined
    })

    let moderation: any = null
    let howtoReports = null
    if (activeTab === 'comments') {
      const modPage = page
      const modPerPage = perPage
      const flagged = await listFlaggedComments(c.env.DB, modPage, modPerPage)
      moderation = {
        items: flagged.items,
        total: flagged.total,
        page: modPage,
        perPage: modPerPage,
        totalPages: Math.max(1, Math.ceil(flagged.total / modPerPage))
      }
    } else if (activeTab === 'archive') {
      const rptPage = page
      const rptPerPage = perPage
      const reports = await listHowtoReports(c.env.DB, { status: 'pending', limit: rptPerPage, offset: (rptPage - 1) * rptPerPage })
      howtoReports = {
        items: reports.reports.map((r: any) => ({
          id: r.id,
          pageId: r.page_id,
          pageSlug: r.page_slug,
          pageTitle: r.page_title,
          reasonType: r.reason_type,
          reasonDetail: r.reason_detail,
          status: r.status,
          reporterId: r.reporter_id,
          reporterIpHash: r.reporter_ip_hash,
          createdAt: r.created_at
        })),
        total: reports.total,
        page: rptPage,
        perPage: rptPerPage,
        totalPages: Math.max(1, Math.ceil(reports.total / rptPerPage))
      }
    }

    // 숨겨진 직업/전공 목록 가져오기
    const hiddenJobsResult = await c.env.DB.prepare(`
      SELECT id, name, slug, primary_source, user_last_updated_at
      FROM jobs
      WHERE is_active = 0
      ORDER BY user_last_updated_at DESC
    `).all<{ id: string; name: string; slug: string | null; primary_source: string; user_last_updated_at: number }>()

    const hiddenMajorsResult = await c.env.DB.prepare(`
      SELECT id, name, slug, primary_source, user_last_updated_at
      FROM majors
      WHERE is_active = 0
      ORDER BY user_last_updated_at DESC
    `).all<{ id: string; name: string; slug: string | null; primary_source: string; user_last_updated_at: number }>()

    const hiddenJobs = (hiddenJobsResult.results || []).map(job => ({
      id: job.id,
      name: job.name,
      slug: job.slug,
      primarySource: job.primary_source,
      hiddenAt: job.user_last_updated_at
    }))

    const hiddenMajors = (hiddenMajorsResult.results || []).map(major => ({
      id: major.id,
      name: major.name,
      slug: major.slug,
      primarySource: major.primary_source,
      hiddenAt: major.user_last_updated_at
    }))

    const coverage = await getCoverageStats(c.env.DB)

    return c.html(renderAdminContent({
      activeTab,
      revisions: result.revisions as any[],
      total: result.total,
      page: result.page,
      perPage: result.perPage,
      totalPages: result.totalPages,
      filters: { entityType, editorType, startDate, endDate },
      hiddenJobs,
      hiddenMajors,
      howtoReports: howtoReports ?? undefined,
      moderation: moderation ?? undefined,
      coverage
    }))
  } catch (error) {
    return c.text('편집 이력을 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 API - 리비전 목록
adminRoutes.get('/api/admin/revisions', requireAdmin, async (c) => {
  try {
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    const entityType = c.req.query('entityType') || 'all'
    const editorType = c.req.query('editorType') || 'all'
    const startDate = c.req.query('startDate') || ''
    const endDate = c.req.query('endDate') || ''

    const result = await getRevisions(c.env.DB, {
      page,
      perPage,
      entityType: entityType as any,
      editorType: editorType as any,
      startDate: startDate || undefined,
      endDate: endDate || undefined
    })

    return c.json({ success: true, data: result })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to fetch revisions' }, 500)
  }
})

// 관리자 API - 신고/블라인드 댓글 목록 (static path BEFORE dynamic :id routes)
adminRoutes.get('/api/admin/comments/moderation', requireAdmin, async (c) => {
  try {
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    const result = await listFlaggedComments(c.env.DB, page, perPage)
    const totalPages = Math.max(1, Math.ceil(result.total / perPage))
    return c.json({
      success: true,
      data: {
        items: result.items,
        total: result.total,
        page,
        perPage,
        totalPages
      }
    })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to fetch comments' }, 500)
  }
})

// 관리자 API - 고아 대댓글 정리 (1회성) (static path BEFORE dynamic :id routes)
adminRoutes.post('/api/admin/comments/cleanup-orphans', requireAdmin, async (c) => {
  try {
    const deleted = await deleteOrphanReplies(c.env.DB)
    return c.json({ success: true, deleted })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to cleanup orphans' }, 500)
  }
})

// 관리자 API - 댓글 블라인드
adminRoutes.post('/api/admin/comments/:id/blind', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) {
      return c.json({ success: false, error: 'invalid id' }, 400)
    }
    await setCommentStatus(c.env.DB, id, 'blinded')
    return c.json({ success: true })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to blind comment' }, 500)
  }
})

// 관리자 API - 댓글 블라인드 해제
adminRoutes.post('/api/admin/comments/:id/unblind', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) {
      return c.json({ success: false, error: 'invalid id' }, 400)
    }
    await setCommentStatus(c.env.DB, id, 'visible')
    return c.json({ success: true })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to unblind comment' }, 500)
  }
})

// 관리자 API - 신고 카운트 초기화
adminRoutes.post('/api/admin/comments/:id/reset-reports', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) {
      return c.json({ success: false, error: 'invalid id' }, 400)
    }
    await resetCommentReports(c.env.DB, id)
    return c.json({ success: true })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to reset reports' }, 500)
  }
})

// 관리자 API - 댓글 삭제 (대댓글 포함)
adminRoutes.delete('/api/admin/comments/:id', requireAdmin, async (c) => {
  try {
    const id = Number(c.req.param('id'))
    if (!Number.isFinite(id)) {
      return c.json({ success: false, error: 'invalid id' }, 400)
    }
    await deleteComment(c.env.DB, { commentId: id, userId: 'admin', userRole: 'admin' })
    return c.json({ success: true })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to delete comment' }, 500)
  }
})

// 관리자 API - 리비전 복원
adminRoutes.post('/api/admin/revisions/:id/restore', requireAdmin, async (c) => {
  try {
    const revisionId = parseInt(c.req.param('id'))
    const user = c.get('user')
    const body = await c.req.json()

    if (!user) {
      return c.json({ success: false, error: 'Unauthorized' }, 401)
    }

    const success = await restoreRevisionAdmin(c.env.DB, revisionId, user.id, body.reason)
    return c.json({ success })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to restore revision' }, 500)
  }
})

// 관리자 - 통계 대시보드 페이지
adminRoutes.get('/admin/stats', requireAdmin, async (c) => {
  try {
    const endDate = c.req.query('endDate') || new Date().toISOString().split('T')[0]
    const startDate = c.req.query('startDate') || new Date(Date.now() - 30 * 86400000).toISOString().split('T')[0]
    const topLimit = parseInt(c.req.query('topLimit') || '10')

    const [stats, aiConversion, searchStats] = await Promise.all([
      getAnalyticsStats(c.env.DB, { startDate, endDate, topLimit }),
      getAiConversionStats(c.env.DB, { startDate, endDate }),
      getSearchStats(c.env.DB, { startDate, endDate })
    ])

    return c.html(renderAdminStats({
      filters: { startDate, endDate, topLimit },
      ...stats,
      aiConversion,
      searchStats
    }))
  } catch (error) {
    return c.text('통계를 불러오는데 실패했습니다.', 500)
  }
})

// 관리자 API - 통계 데이터
adminRoutes.get('/api/admin/stats', requireAdmin, async (c) => {
  try {
    const endDate = c.req.query('endDate') || new Date().toISOString().split('T')[0]
    const startDate = c.req.query('startDate') || new Date(Date.now() - 30 * 86400000).toISOString().split('T')[0]
    const topLimit = parseInt(c.req.query('topLimit') || '10')

    const [stats, searchStats] = await Promise.all([
      getAnalyticsStats(c.env.DB, { startDate, endDate, topLimit }),
      getSearchStats(c.env.DB, { startDate, endDate })
    ])

    return c.json({ success: true, data: { ...stats, searchStats } })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to fetch stats' }, 500)
  }
})

export { adminRoutes }
