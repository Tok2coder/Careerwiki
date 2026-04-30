/**
 * 관리자 페이지 + API 라우트
 * Phase 1-6: index.tsx에서 추출
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAdmin } from '../middleware/auth'
import { adminAiApi } from '../services/ai-analyzer/admin-api'
import { careerTreeAdminRoutes } from './admin-career-tree'
import { renderAdminDashboard } from '../templates/admin/adminDashboard'
import { renderAdminAiAnalyzer } from '../templates/admin/adminAiAnalyzer'
import { renderAdminFeedbackPage } from '../templates/admin/adminFeedback'
import { renderAdminFeedbackDetail } from '../templates/admin/adminFeedbackDetail'
import { renderAdminUsers } from '../templates/admin/adminUsers'
import { renderAdminUserDetail } from '../templates/admin/adminUserDetail'
import { renderAdminContent } from '../templates/admin/adminContent'
import { renderModerationQueuePage } from '../templates/admin/moderationQueue'
import { listPendingModerationQueue, applyModerationDecision, issueSanction, reviewAppeal, type SanctionStage, type SanctionReasonCategory } from '../services/enforcementService'
import { renderSanctionsAdminPage, renderAppealsAdminPage, renderCompanyRepliesAdminPage } from '../templates/admin/enforcementOps'
import { renderUserMenu } from '../utils/shared-helpers'
import { renderAdminStats } from '../templates/admin/adminStats'
import { renderAdminJobEqualize, hasField, parseSources, EQUALIZE_FIELDS, type JobEqualizeItem, type EqualizeTab } from '../templates/admin/adminJobEqualize'
import { getUsers, updateUserRole, banUser, unbanUser, getRevisions, restoreRevision as restoreRevisionAdmin, getStats, getAnalyticsStats, getAiConversionStats, getSearchStats, getDashboardChartData, getUserAttributionStats, getContentViewStats, getUniqueVisitorStats, getVisitorList, getRevisionsByEditor, getVisitorPageViews, getRefererDistribution, getAiUsageDistribution, banIp, unbanIp } from '../services/adminService'
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

    // KPI + 차트 + 최근 활동 + UV 통계 병렬 조회
    const [kpiStats, chartData, recentEdits, recentUsers, uvStats] = await Promise.all([
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
      `).all(),

      // 순방문자 통계
      getUniqueVisitorStats(db)
    ])

    return c.html(renderAdminDashboard({
      stats: kpiStats,
      recentEdits: (recentEdits.results || []) as any[],
      recentUsers: (recentUsers.results || []) as any[],
      chartData,
      uvStats
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
adminRoutes.route('', careerTreeAdminRoutes)

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
    const tab = (c.req.query('tab') || 'users') as 'users' | 'visitors' | 'revisions' | 'visitor-detail'
    const page = parseInt(c.req.query('page') || '1')

    // 방문자 상세 탭
    if (tab === 'visitor-detail') {
      const ipHash = c.req.query('ip') || ''
      const pageViews = await getVisitorPageViews(c.env.DB, ipHash, 100)
      return c.html(renderAdminUsers({
        activeTab: 'visitor-detail',
        users: [], total: 0, page: 1, perPage: 20, totalPages: 0,
        filters: { search: '', role: 'all', status: 'all' },
        visitorDetail: pageViews,
        visitorDetailIp: ipHash,
      }))
    }

    // 편집 이력 탭
    if (tab === 'revisions') {
      const editorId = c.req.query('editor') || undefined
      const ipHash = c.req.query('ip') || undefined
      const result = await getRevisionsByEditor(c.env.DB, { editorId, ipHash, page, perPage: 50 })

      let editorLabel = ''
      if (editorId) {
        const user = await c.env.DB.prepare('SELECT username, email FROM users WHERE id = ?').bind(editorId).first<{ username: string | null; email: string }>()
        editorLabel = user ? (user.username || user.email) : `사용자 #${editorId}`
      } else if (ipHash) {
        editorLabel = `IP ${ipHash}`
      }

      return c.html(renderAdminUsers({
        activeTab: 'revisions',
        users: [], total: 0, page: 1, perPage: 20, totalPages: 0,
        filters: { search: '', role: 'all', status: 'all' },
        editorRevisions: result.revisions,
        editorRevisionsTotal: result.total,
        editorRevisionsPage: result.page,
        editorRevisionsTotalPages: result.totalPages,
        editorLabel,
        editorId,
        editorIpHash: ipHash,
      }))
    }

    // 방문자 탭
    if (tab === 'visitors') {
      const sort = (c.req.query('sort') || 'recent') as 'recent' | 'frequent' | 'edits'
      const [result, refererDist] = await Promise.all([
        getVisitorList(c.env.DB, { page, perPage: 30, sort }),
        getRefererDistribution(c.env.DB, 10),
      ])
      return c.html(renderAdminUsers({
        activeTab: 'visitors',
        users: [], total: 0, page: 1, perPage: 20, totalPages: 0,
        filters: { search: '', role: 'all', status: 'all' },
        visitors: result.visitors,
        visitorsTotal: result.total,
        visitorsPage: result.page,
        visitorsTotalPages: result.totalPages,
        visitorSort: sort,
        refererDistribution: refererDist,
      }))
    }

    // 사용자 탭 (기본)
    const perPage = parseInt(c.req.query('perPage') || '20')
    const search = c.req.query('search') || ''
    const role = c.req.query('role') || 'all'
    const status = c.req.query('status') || 'all'

    const [result, attrStats, aiUsageDist] = await Promise.all([
      getUsers(c.env.DB, {
        page,
        perPage,
        search,
        role: role as any,
        status: status as any
      }),
      getUserAttributionStats(c.env.DB),
      getAiUsageDistribution(c.env.DB),
    ])

    return c.html(renderAdminUsers({
      activeTab: 'users',
      users: result.users as any[],
      total: result.total,
      page: result.page,
      perPage: result.perPage,
      totalPages: result.totalPages,
      filters: { search, role, status },
      attributionStats: attrStats,
      aiUsageDistribution: aiUsageDist,
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
    const activeTab = (c.req.query('tab') || 'revisions') as 'revisions' | 'archive' | 'comments' | 'reports'
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
      // archive 탭에서는 howtoReports 로드하지 않음 (reports 탭으로 이동)
    } else if (activeTab === 'reports') {
      // HowTo 탭: 신고된 HowTo만 로드
      const reports = await listHowtoReports(c.env.DB, { status: 'pending', limit: 100, offset: 0 })
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
        page: 1,
        perPage: 100,
        totalPages: 1
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

    const contentViewStats = await getContentViewStats(c.env.DB, 10)

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
      contentViewStats
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

// 관리자 API - 개별 리비전 되돌리기 (편집 이력 탭에서 사용)
adminRoutes.post('/api/admin/revert-revision', requireAdmin, async (c) => {
  try {
    const user = c.get('user')
    if (!user) return c.json({ success: false, error: 'Unauthorized' }, 401)
    const body = await c.req.json<{ revisionId: number }>()
    const success = await restoreRevisionAdmin(c.env.DB, body.revisionId, user.id)
    return c.json({ success })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to revert' }, 500)
  }
})

// 관리자 API - 편집자별 전체 되돌리기
adminRoutes.post('/api/admin/bulk-revert', requireAdmin, async (c) => {
  try {
    const user = c.get('user')
    if (!user) return c.json({ success: false, error: 'Unauthorized' }, 401)
    const body = await c.req.json<{ editorId?: string; ipHash?: string }>()

    if (!body.editorId && !body.ipHash) {
      return c.json({ success: false, error: 'editorId or ipHash required' }, 400)
    }

    // 해당 편집자의 모든 편집 리비전 조회 (edit 타입만, initial/restore 제외)
    let where: string
    const binds: any[] = []
    if (body.editorId) {
      where = "editor_id = ? AND change_type = 'edit'"
      binds.push(body.editorId)
    } else {
      where = "ip_hash = ? AND change_type = 'edit'"
      binds.push(body.ipHash)
    }

    const revisions = await c.env.DB.prepare(`
      SELECT id, entity_type, entity_id FROM page_revisions
      WHERE ${where}
      ORDER BY created_at ASC
    `).bind(...binds).all<{ id: number; entity_type: string; entity_id: string }>()

    const revisionRows = revisions.results || []
    if (revisionRows.length === 0) {
      return c.json({ success: true, revertedCount: 0 })
    }

    // 각 엔티티별로 가장 오래된 리비전의 이전 버전으로 복원
    // → 해당 편집자가 처음 편집하기 전 상태로 되돌림
    const entityMap = new Map<string, number>()
    for (const r of revisionRows) {
      const key = `${r.entity_type}:${r.entity_id}`
      if (!entityMap.has(key)) {
        // 이 편집자의 첫 편집 직전 리비전 찾기
        const prevRevision = await c.env.DB.prepare(`
          SELECT id FROM page_revisions
          WHERE entity_type = ? AND entity_id = ? AND id < ?
          ORDER BY revision_number DESC LIMIT 1
        `).bind(r.entity_type, r.entity_id, r.id).first<{ id: number }>()
        if (prevRevision) {
          entityMap.set(key, prevRevision.id)
        }
      }
    }

    let revertedCount = 0
    for (const [, prevRevId] of entityMap) {
      try {
        await restoreRevisionAdmin(c.env.DB, prevRevId, user.id)
        revertedCount++
      } catch { /* skip failed */ }
    }

    return c.json({ success: true, revertedCount })
  } catch (error) {
    return c.json({ success: false, error: 'Bulk revert failed' }, 500)
  }
})

// 관리자 API - IP 차단
adminRoutes.post('/api/admin/ban-ip', requireAdmin, async (c) => {
  try {
    const user = c.get('user')
    if (!user) return c.json({ success: false, error: 'Unauthorized' }, 401)
    const body = await c.req.json<{ ipHash: string; reason?: string }>()
    if (!body.ipHash) return c.json({ success: false, error: 'ipHash required' }, 400)
    const success = await banIp(c.env.DB, body.ipHash, body.reason || null, user.id)
    return c.json({ success })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to ban IP' }, 500)
  }
})

// 관리자 API - IP 차단 해제
adminRoutes.post('/api/admin/unban-ip', requireAdmin, async (c) => {
  try {
    const body = await c.req.json<{ ipHash: string }>()
    if (!body.ipHash) return c.json({ success: false, error: 'ipHash required' }, 400)
    const success = await unbanIp(c.env.DB, body.ipHash)
    return c.json({ success })
  } catch (error) {
    return c.json({ success: false, error: 'Failed to unban IP' }, 500)
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

// ─── Google Search Console 재인덱싱 API ───
import { notifyGoogleIndexing, getGoogleAccessToken } from '../utils/google-indexing'

// POST /admin/api/reindex — 최근 수정된 직업/전공 URL을 Google에 재인덱싱 요청
adminRoutes.post('/admin/api/reindex', async (c) => {
  // requireAdmin OR X-Admin-Secret header
  const user = c.get('user')
  const isAdminUser = user && ((user.role as string) === 'admin' || (user.role as string) === 'super-admin' || (user.role as string) === 'operator')
  const secretHeader = c.req.header('X-Admin-Secret')
  const hasSecretAuth = secretHeader && c.env.ADMIN_SECRET && secretHeader === c.env.ADMIN_SECRET
  if (!isAdminUser && !hasSecretAuth) {
    return c.json({ error: 'Admin authentication required' }, 401)
  }
  const email = c.env.GOOGLE_SERVICE_ACCOUNT_EMAIL
  const privateKey = c.env.GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY
  if (!email || !privateKey) {
    return c.json({ success: false, error: 'Google 서비스 계정 미설정 (GOOGLE_SERVICE_ACCOUNT_EMAIL, GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY)' }, 400)
  }

  try {
    const body = await c.req.json<{ urls?: string[] }>()
    let urls = body.urls || []

    // URL 지정 없으면 최근 7일 내 수정된 직업/전공 자동 수집
    if (urls.length === 0) {
      const sevenDaysAgo = Date.now() - 7 * 24 * 60 * 60 * 1000
      const [jobs, majors] = await Promise.all([
        c.env.DB.prepare('SELECT name FROM jobs WHERE is_active = 1 AND user_last_updated_at > ?').bind(sevenDaysAgo).all<{ name: string }>(),
        c.env.DB.prepare('SELECT name FROM majors WHERE is_active = 1 AND user_last_updated_at > ?').bind(sevenDaysAgo).all<{ name: string }>(),
      ])
      for (const r of jobs.results) urls.push(`https://careerwiki.org/job/${encodeURIComponent(r.name)}`)
      for (const r of majors.results) urls.push(`https://careerwiki.org/major/${encodeURIComponent(r.name)}`)
    }

    if (urls.length === 0) {
      return c.json({ success: true, message: '재인덱싱할 URL이 없습니다', submitted: 0 })
    }

    // Google Indexing API access token
    const accessToken = await getGoogleAccessToken(email, privateKey, 'https://www.googleapis.com/auth/indexing')

    const results: Array<{ url: string; status: string }> = []
    // 배치로 전송 (Google 할당량: ~200/일)
    for (const url of urls.slice(0, 200)) {
      try {
        const resp = await fetch('https://indexing.googleapis.com/v3/urlNotifications:publish', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${accessToken}`,
          },
          body: JSON.stringify({ url, type: 'URL_UPDATED' }),
        })
        const data = await resp.json() as any
        results.push({ url, status: resp.ok ? 'submitted' : (data.error?.message || `HTTP ${resp.status}`) })
      } catch (e: any) {
        results.push({ url, status: `error: ${e.message}` })
      }
    }

    const successCount = results.filter(r => r.status === 'submitted').length
    return c.json({
      success: true,
      message: `${successCount}/${results.length}개 URL 인덱싱 요청 완료`,
      submitted: successCount,
      total: results.length,
      results,
    })
  } catch (error: any) {
    return c.json({ success: false, error: error.message }, 500)
  }
})

// GET /admin/api/reindex/status — 최근 수정된 페이지 목록 확인
adminRoutes.get('/admin/api/reindex/status', async (c) => {
  const user = c.get('user')
  const isAdminUser = user && ((user.role as string) === 'admin' || (user.role as string) === 'super-admin' || (user.role as string) === 'operator')
  const secretHeader = c.req.header('X-Admin-Secret')
  const hasSecretAuth = secretHeader && c.env.ADMIN_SECRET && secretHeader === c.env.ADMIN_SECRET
  if (!isAdminUser && !hasSecretAuth) {
    return c.json({ error: 'Admin authentication required' }, 401)
  }
  try {
    const sevenDaysAgo = Date.now() - 7 * 24 * 60 * 60 * 1000
    const [jobs, majors] = await Promise.all([
      c.env.DB.prepare('SELECT name, user_last_updated_at FROM jobs WHERE is_active = 1 AND user_last_updated_at > ? ORDER BY user_last_updated_at DESC').bind(sevenDaysAgo).all<{ name: string; user_last_updated_at: number }>(),
      c.env.DB.prepare('SELECT name, user_last_updated_at FROM majors WHERE is_active = 1 AND user_last_updated_at > ? ORDER BY user_last_updated_at DESC').bind(sevenDaysAgo).all<{ name: string; user_last_updated_at: number }>(),
    ])

    const safeDate = (ts: number | null | undefined): string => {
      if (!ts) return 'unknown'
      try { return new Date(ts).toISOString() } catch { return String(ts) }
    }
    const pages = [
      ...jobs.results.map(r => ({ type: 'job', name: r.name, url: `https://careerwiki.org/job/${encodeURIComponent(r.name)}`, updatedAt: safeDate(r.user_last_updated_at) })),
      ...majors.results.map(r => ({ type: 'major', name: r.name, url: `https://careerwiki.org/major/${encodeURIComponent(r.name)}`, updatedAt: safeDate(r.user_last_updated_at) })),
    ]

    return c.json({
      success: true,
      hasCredentials: !!(c.env.GOOGLE_SERVICE_ACCOUNT_EMAIL && c.env.GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY),
      recentlyUpdated: pages.length,
      pages,
    })
  } catch (error: any) {
    return c.json({ success: false, error: error.message }, 500)
  }
})

// ============================================
// 직업/전공 데이터 보완 현황 페이지
// ============================================
adminRoutes.get('/admin/job-equalize', requireAdmin, async (c) => {
  try {
    const db = c.env.DB

    // 탭 선택 (기본: 직업)
    const rawTab = c.req.query('tab')
    const tab: EqualizeTab = rawTab === 'major' ? 'major' : 'job'
    const isJob = tab === 'job'
    const tableName = isJob ? 'jobs' : 'majors'
    const entityType = isJob ? 'job' : 'major'
    const skillMarker = isJob ? '[job-data-enhance]' : '[major-data-enhance]'
    const skillMarkerLike = `%${skillMarker}%`

    // 1. 전체 활성 수 + 품질 경보 카운트 + 스킬 적용 수 — 병렬 조회
    // 정책: production-accurate — 대부분 검사는 merged_profile_json 기준 (사용자 페이지 노출 데이터).
    //   - wayIsArray: UCJ 데이터 무결성 버그 (UCJ에서 way가 array면 API fail) — UCJ 검사 유지
    //   - imageUrlBad: image_url 컬럼 — 변경 없음
    //   - wayTrunc / srcOrderBad / ytLow: production 노출 기준 → merged 검사
    const [
      totalResult,
      alertWayIsArrayResult,
      alertImageUrlBadResult,
      alertWayTruncResult,
      alertSrcOrderBadResult,
      alertYtLowResult,
      skillAppliedResult,
    ] = await Promise.all([
      db.prepare(`SELECT COUNT(*) as count FROM ${tableName} WHERE is_active = 1`).first<{ count: number }>(),
      db.prepare(`SELECT COUNT(*) as count FROM ${tableName} WHERE is_active=1 AND user_contributed_json IS NOT NULL AND json_type(user_contributed_json,'$.way')='array'`).first<{ count: number }>(),
      db.prepare(`SELECT COUNT(*) as count FROM ${tableName} WHERE is_active=1 AND image_url IS NOT NULL AND image_url != '' AND image_url NOT LIKE '/uploads/%' AND image_url NOT LIKE 'https://%' AND image_url NOT LIKE 'http://%'`).first<{ count: number }>(),
      db.prepare(`SELECT COUNT(*) as count FROM ${tableName} WHERE is_active=1 AND merged_profile_json IS NOT NULL AND json_extract(merged_profile_json,'$.way') IS NOT NULL AND length(json_extract(merged_profile_json,'$.way')) > 20 AND json_extract(merged_profile_json,'$.way') NOT GLOB '*[.!?다요죠음임됨니까세]' AND json_extract(merged_profile_json,'$.way') NOT GLOB '*[.!?다요죠음임됨니까세][[]*[]]'`).first<{ count: number }>(),
      db.prepare(`SELECT COUNT(*) as count FROM ${tableName} WHERE is_active=1 AND merged_profile_json IS NOT NULL AND json_extract(merged_profile_json,'$._sources') IS NOT NULL AND json_array_length(json_extract(merged_profile_json,'$._sources')) > 0 AND json_extract(merged_profile_json,'$._sources[0].text') NOT LIKE '%커리어넷%' AND json_extract(merged_profile_json,'$._sources[0].text') NOT LIKE '%career%'`).first<{ count: number }>(),
      db.prepare(`SELECT COUNT(*) as count FROM ${tableName} WHERE is_active=1 AND merged_profile_json IS NOT NULL AND (json_extract(merged_profile_json,'$.youtubeLinks') IS NULL OR json_array_length(json_extract(merged_profile_json,'$.youtubeLinks')) = 0) AND (json_extract(merged_profile_json,'$._youtubeSearchNote') IS NULL OR length(json_extract(merged_profile_json,'$._youtubeSearchNote'))=0)`).first<{ count: number }>(),
      db.prepare(`SELECT COUNT(DISTINCT entity_id) as count FROM page_revisions WHERE entity_type = ? AND change_summary LIKE ?`).bind(entityType, skillMarkerLike).first<{ count: number }>(),
    ])

    const totalJobs = totalResult?.count || 0
    const qualityAlerts = {
      wayIsArray: alertWayIsArrayResult?.count || 0,
      imageUrlBad: alertImageUrlBadResult?.count || 0,
      wayTrunc: alertWayTruncResult?.count || 0,
      srcOrderBad: alertSrcOrderBadResult?.count || 0,
      ytLow: alertYtLowResult?.count || 0,
    }
    const skillAppliedCount = skillAppliedResult?.count || 0

    // 2. 스킬 적용된 entity_id → 최근 적용 시각 맵 조회 (skillApplied + 정렬용)
    //    created_at은 'YYYY-MM-DD HH:MM:SS' 포맷이라 문자열 비교로 시간순 정렬 가능
    const skillAppliedMap = new Map<string, string>()
    {
      let offset = 0
      while (true) {
        const batch = await db.prepare(
          `SELECT entity_id, MAX(created_at) as last_at FROM page_revisions
           WHERE entity_type = ? AND change_summary LIKE ?
           GROUP BY entity_id
           ORDER BY entity_id LIMIT 500 OFFSET ?`
        ).bind(entityType, skillMarkerLike, offset).all<{ entity_id: string; last_at: string }>()
        const rows = batch.results || []
        for (const r of rows) {
          if (r.entity_id) skillAppliedMap.set(r.entity_id, r.last_at ?? '')
        }
        if (rows.length < 500) break
        offset += 500
      }
    }

    // 3. 엔티티 목록 — D1 SQL이 12-field 카운팅·quality flag 모두 계산해 scalar로 반환
    //    Worker CPU 한도 회피: merged_profile_json bulk JSON.parse 제거.
    //    parseSources만 _sources 추출분 위에서 JS 실행 (작은 blob).
    //    필터: is_active=1 AND user_contributed_json IS NOT NULL (UCJ 보유 entity = admin 보완 대상)
    type Row = {
      id: string
      name: string
      slug: string
      image_url: string | null
      json_size: number
      sources_blob: string | null
      ucj_sources_blob: string | null  // user_contributed_json._sources (unique URL count 산출용)
      // 12 fields presence (merged 기준)
      f_way: number; f_sal: number; f_pro: number; f_tv: number
      f_wlb: number; f_rdy: number; f_sj: number; f_sm: number
      f_sc: number; f_ht: number; f_yt: number; f_src: number
      yt_count: number
      // quality flags
      way_is_array: number  // UCJ 데이터 무결성
      way_trunc: number      // merged.way 잘림 의심
      src_order_bad: number  // merged._sources 첫 항목
      yt_low: number         // merged.youtubeLinks 0 + note 없음
    }
    const allRows: Row[] = []
    {
      let offset = 0
      // SQL — 모든 무거운 로직을 D1에서 처리
      const SELECT_SQL = `
        SELECT id, name, slug, image_url,
          length(user_contributed_json) AS json_size,
          json_extract(merged_profile_json,'$._sources') AS sources_blob,
          json_extract(user_contributed_json,'$._sources') AS ucj_sources_blob,
          CASE WHEN json_type(merged_profile_json,'$.way') IS NOT NULL AND length(json_extract(merged_profile_json,'$.way'))>0 THEN 1 ELSE 0 END AS f_way,
          CASE WHEN json_type(merged_profile_json,'$.overviewSalary') IN ('object','array') AND length(json_extract(merged_profile_json,'$.overviewSalary'))>2 THEN 1 ELSE 0 END AS f_sal,
          CASE WHEN json_type(merged_profile_json,'$.overviewProspect') IN ('object','array') AND length(json_extract(merged_profile_json,'$.overviewProspect'))>2 THEN 1 ELSE 0 END AS f_pro,
          CASE WHEN json_type(merged_profile_json,'$.trivia') IS NOT NULL AND length(json_extract(merged_profile_json,'$.trivia'))>0 THEN 1 ELSE 0 END AS f_tv,
          CASE WHEN json_type(merged_profile_json,'$.detailWlb') IN ('object','array') AND length(json_extract(merged_profile_json,'$.detailWlb'))>2 THEN 1 ELSE 0 END AS f_wlb,
          CASE WHEN json_type(merged_profile_json,'$.detailReady') IS NOT NULL AND length(json_extract(merged_profile_json,'$.detailReady'))>0 THEN 1 ELSE 0 END AS f_rdy,
          CASE WHEN COALESCE(json_array_length(merged_profile_json,'$.sidebarJobs'),0)>0 THEN 1 ELSE 0 END AS f_sj,
          CASE WHEN COALESCE(json_array_length(merged_profile_json,'$.sidebarMajors'),0)>0 THEN 1 ELSE 0 END AS f_sm,
          CASE WHEN COALESCE(json_array_length(merged_profile_json,'$.sidebarCerts'),0)>0 THEN 1 ELSE 0 END AS f_sc,
          CASE WHEN COALESCE(json_array_length(merged_profile_json,'$.heroTags'),0)>0 THEN 1 ELSE 0 END AS f_ht,
          CASE WHEN COALESCE(json_array_length(merged_profile_json,'$.youtubeLinks'),0)>0 THEN 1 ELSE 0 END AS f_yt,
          CASE WHEN json_type(merged_profile_json,'$._sources') IN ('object','array') AND length(json_extract(merged_profile_json,'$._sources'))>2 THEN 1 ELSE 0 END AS f_src,
          COALESCE(json_array_length(merged_profile_json,'$.youtubeLinks'),0) AS yt_count,
          CASE WHEN json_type(user_contributed_json,'$.way')='array' THEN 1 ELSE 0 END AS way_is_array,
          CASE WHEN length(json_extract(merged_profile_json,'$.way'))>20
                AND json_extract(merged_profile_json,'$.way') NOT GLOB '*[.!?다요죠음임됨니까세]'
                AND json_extract(merged_profile_json,'$.way') NOT GLOB '*[.!?다요죠음임됨니까세][[]*[]]'
               THEN 1 ELSE 0 END AS way_trunc,
          CASE WHEN json_type(merged_profile_json,'$._sources[0].text')='text'
                AND json_extract(merged_profile_json,'$._sources[0].text') NOT LIKE '%커리어넷%'
                AND json_extract(merged_profile_json,'$._sources[0].text') NOT LIKE '%career%'
               THEN 1 ELSE 0 END AS src_order_bad,
          CASE WHEN COALESCE(json_array_length(merged_profile_json,'$.youtubeLinks'),0)=0
                AND (json_type(merged_profile_json,'$._youtubeSearchNote') IS NULL OR length(json_extract(merged_profile_json,'$._youtubeSearchNote'))=0)
               THEN 1 ELSE 0 END AS yt_low
        FROM ${tableName}
        WHERE is_active = 1 AND user_contributed_json IS NOT NULL
        ORDER BY name LIMIT 500 OFFSET ?`
      while (true) {
        const batch = await db.prepare(SELECT_SQL).bind(offset).all<Row>()
        const rows = batch.results || []
        allRows.push(...rows)
        if (rows.length < 500) break
        offset += 500
      }
    }

    // 4. Worker는 scalar만 가공 — JSON.parse는 _sources 전용 (작은 blob)
    let perfectCount = 0
    let poorCount = 0
    let totalJsonSize = 0

    const items: JobEqualizeItem[] = allRows.map(row => {
      const jsonSize = row.json_size || 0
      totalJsonSize += jsonSize

      const fields = [
        !!row.f_way, !!row.f_sal, !!row.f_pro, !!row.f_tv,
        !!row.f_wlb, !!row.f_rdy, !!row.f_sj, !!row.f_sm,
        !!row.f_sc, !!row.f_ht, !!row.f_yt, !!row.f_src,
      ]
      const fieldCount = fields.filter(Boolean).length

      // 출처 분석 — _sources blob만 parse (작음, 보통 < 5KB)
      // merged._sources → 출처수/URL수/사고 패턴 (production 노출 기준)
      let merged: any = null
      if (row.sources_blob) {
        try { merged = JSON.parse(row.sources_blob) } catch {}
      }
      const mergedParsed = parseSources(merged)

      // UCJ._sources → unique URL 수 (스킬이 기록한 출처 기준)
      let ucj: any = null
      if (row.ucj_sources_blob) {
        try { ucj = JSON.parse(row.ucj_sources_blob) } catch {}
      }
      // UCJ._sources 가 아예 없으면 null (마커 없는 직업) — 화면에서 '-' 표시
      const uniqueUrlCount = ucj ? parseSources(ucj).uniqueUrlCount : null

      const imgUrl = row.image_url || ''
      const imageUrlBad = imgUrl.length > 0 && !imgUrl.startsWith('/uploads/') && !imgUrl.startsWith('https://') && !imgUrl.startsWith('http://')

      const skillLastAppliedAt = skillAppliedMap.get(row.id) ?? null
      const skillApplied = skillLastAppliedAt !== null

      if (fieldCount === 12) perfectCount++
      if (fieldCount < 6) poorCount++

      return {
        name: row.name, slug: row.slug, fields, fieldCount, jsonSize,
        sourceCount: mergedParsed.sourceCount,
        urlSourceCount: mergedParsed.urlSourceCount,
        uniqueUrlCount,
        youtubeCount: row.yt_count || 0,
        skillApplied, skillLastAppliedAt,
        wayIsArray: !!row.way_is_array,
        imageUrlBad,
        wayTrunc: !!row.way_trunc,
        srcOrderBad: !!row.src_order_bad,
        ytLow: !!row.yt_low,
        srcRawURL: mergedParsed.hasRawURL,
        srcBracket: mergedParsed.hasBracket,
        srcMojibake: mergedParsed.hasMojibake,
      }
    })

    const contributedCount = items.length
    const avgJsonSize = contributedCount > 0 ? Math.round(totalJsonSize / contributedCount) : 0

    return c.html(renderAdminJobEqualize({
      tab, totalJobs, contributedCount, perfectCount, poorCount, avgJsonSize,
      items, qualityAlerts, skillAppliedCount,
    }))
  } catch (error: any) {
    console.error('Job equalize page error:', error)
    return c.text(`데이터 보완 현황을 불러오는데 실패했습니다. Error: ${error?.message || String(error)}`, 500)
  }
})

// POST /admin/api/update-related-jobs — 관련직업 재계산 (v2: heroTags + keyword + domain)
import { updateRelatedJobs } from '../scripts/etl/updateRelatedJobs'

adminRoutes.post('/admin/api/update-related-jobs', async (c) => {
  const user = c.get('user')
  const isAdminUser = user && ((user.role as string) === 'admin' || (user.role as string) === 'super-admin' || (user.role as string) === 'operator')
  const secretHeader = c.req.header('X-Admin-Secret')
  const hasSecretAuth = secretHeader && c.env.ADMIN_SECRET && secretHeader === c.env.ADMIN_SECRET
  if (!isAdminUser && !hasSecretAuth) {
    return c.json({ error: 'Admin authentication required' }, 401)
  }

  try {
    const body = await c.req.json<{ dryRun?: boolean; limit?: number }>().catch(() => ({}))
    const result = await updateRelatedJobs(c.env.DB, {
      dryRun: (body as any)?.dryRun ?? false,
      limit: (body as any)?.limit,
    })
    return c.json({
      success: true,
      total: result.total,
      updated: result.updated,
      skipped: result.skipped,
      errors: result.errors.length,
      errorDetails: result.errors.slice(0, 20),
      durationSec: ((Date.now() - result.startTime) / 1000).toFixed(1),
    })
  } catch (error: any) {
    return c.json({ success: false, error: error.message }, 500)
  }
})

const buildAdminUserMenu = (c: any) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  return renderUserMenu(userData)
}

// === 신고 검토 큐 (정책 enforcement §4 Phase 3, B2) ===
adminRoutes.get('/admin/moderation', requireAdmin, async (c) => {
  const items = await listPendingModerationQueue(c.env.DB, { limit: 100 })
  return c.html(renderModerationQueuePage({ userMenuHtml: buildAdminUserMenu(c), items }))
})

adminRoutes.post('/admin/moderation/:id/decide', requireAdmin, async (c) => {
  const user = c.get('user')
  if (!user) return c.redirect('/admin/moderation')
  const queueId = parseInt(c.req.param('id'), 10)
  if (!Number.isFinite(queueId)) return c.redirect('/admin/moderation')
  const form = await c.req.formData()
  const decision = String(form.get('decision') || '') as any
  const note = String(form.get('note') || '') || undefined
  const valid = ['keep', 'delete', 'warn_keep', 'request_revision']
  if (!valid.includes(decision)) return c.redirect('/admin/moderation')

  // 1) 결정 기록
  await applyModerationDecision(c.env.DB, { queueId, decision, decidedBy: user.id, note })

  // 2) 후속 처리 (큐 결정에 따라 실제 콘텐츠 상태 변경)
  try {
    const queueRow = await c.env.DB.prepare(
      `SELECT target_type, target_id FROM moderation_decisions WHERE id = ? LIMIT 1`
    ).bind(queueId).first<{ target_type: string; target_id: number }>()
    if (queueRow) {
      if (decision === 'delete' && queueRow.target_type === 'comment') {
        // 댓글 status를 deleted로
        await c.env.DB.prepare(
          `UPDATE comments SET status = 'deleted' WHERE id = ?`
        ).bind(queueRow.target_id).run()
      } else if (decision === 'keep' && queueRow.target_type === 'comment') {
        // 자동 블라인드된 댓글 복구
        await c.env.DB.prepare(
          `UPDATE comments SET status = 'visible', flagged = 0 WHERE id = ? AND status = 'blinded'`
        ).bind(queueRow.target_id).run()
      } else if (decision === 'warn_keep' && queueRow.target_type === 'comment') {
        // 작성자에게 1차 경고 부과 (단계제 진입)
        const commentRow = await c.env.DB.prepare(
          `SELECT author_id FROM comments WHERE id = ? LIMIT 1`
        ).bind(queueRow.target_id).first<{ author_id: string | null }>()
        const authorIdNum = commentRow?.author_id ? parseInt(commentRow.author_id, 10) : null
        if (authorIdNum && Number.isFinite(authorIdNum)) {
          await issueSanction(c.env.DB, {
            userId: authorIdNum,
            stage: 'warn',
            reasonCategory: 'other' as SanctionReasonCategory,
            reasonDetail: '운영자 큐 결정: warn_keep' + (note ? ' / ' + note : ''),
            sourceDecisionId: queueId,
            issuedBy: user.id
          })
        }
      } else if (decision === 'request_revision' && queueRow.target_type === 'comment') {
        // 작성자에게 수정 요청 — moderation_decisions.decision_reason에 이미 기록됨
        // (사용자는 마이페이지에서 본인 결정 이력 확인 가능)
      }
    }
  } catch (err: any) {
    console.error('[moderation/decide] follow-up failed:', err)
  }

  return c.redirect('/admin/moderation')
})

// === 제재 부과·관리 (B4 단계제 + B5 즉시 영구) ===
adminRoutes.get('/admin/sanctions', requireAdmin, async (c) => {
  const result = await c.env.DB.prepare(
    `SELECT id, user_id, stage, reason_category, reason_detail, started_at, ends_at, status, issued_by
     FROM user_sanctions ORDER BY started_at DESC LIMIT 50`
  ).all<any>()
  const flashType = c.req.query('flash')
  const flash = flashType === 'success'
    ? { type: 'success' as const, message: '제재가 부과되었습니다.' }
    : flashType === 'lifted'
    ? { type: 'success' as const, message: '제재가 해제되었습니다.' }
    : flashType === 'error'
    ? { type: 'error' as const, message: '처리에 실패했습니다.' }
    : undefined
  return c.html(renderSanctionsAdminPage({
    userMenuHtml: buildAdminUserMenu(c),
    recentSanctions: (result.results as any[]) || [],
    flash
  }))
})

adminRoutes.post('/admin/sanctions', requireAdmin, async (c) => {
  const user = c.get('user')
  if (!user) return c.redirect('/admin/sanctions?flash=error')
  const form = await c.req.formData()
  const userId = parseInt(String(form.get('user_id') || '0'), 10)
  const stageRaw = String(form.get('stage') || '').trim() as SanctionStage | ''
  const reasonCategory = String(form.get('reason_category') || '') as SanctionReasonCategory
  const reasonDetail = String(form.get('reason_detail') || '').trim() || undefined
  const isImmediate = String(form.get('is_immediate') || '') === '1'
  if (!Number.isFinite(userId) || userId <= 0 || !reasonCategory) {
    return c.redirect('/admin/sanctions?flash=error')
  }
  try {
    await issueSanction(c.env.DB, {
      userId,
      stage: stageRaw || undefined as any,
      isImmediate,
      reasonCategory,
      reasonDetail,
      issuedBy: user.id
    })
    return c.redirect('/admin/sanctions?flash=success')
  } catch (e: any) {
    console.error('[admin/sanctions] failed:', e)
    return c.redirect('/admin/sanctions?flash=error')
  }
})

adminRoutes.post('/admin/sanctions/:id/lift', requireAdmin, async (c) => {
  const id = parseInt(c.req.param('id'), 10)
  if (!Number.isFinite(id)) return c.redirect('/admin/sanctions?flash=error')
  await c.env.DB.prepare(`UPDATE user_sanctions SET status = 'lifted' WHERE id = ?`).bind(id).run()
  return c.redirect('/admin/sanctions?flash=lifted')
})

// === 이의제기 검토 (B3 / 정책 enforcement §5) ===
adminRoutes.get('/admin/appeals', requireAdmin, async (c) => {
  const result = await c.env.DB.prepare(
    `SELECT id, user_id, target_type, target_id, reason, evidence, status, created_at, temp_action_ends_at, review_note
     FROM user_appeals ORDER BY created_at DESC LIMIT 100`
  ).all<any>()
  const flashType = c.req.query('flash')
  const flash = flashType === 'decided'
    ? { type: 'success' as const, message: '결정이 기록되었습니다.' }
    : flashType === 'error'
    ? { type: 'error' as const, message: '처리에 실패했습니다.' }
    : flashType === 'same_decider'
    ? { type: 'error' as const, message: '본인이 1차 결정한 사안은 본인이 검토할 수 없습니다 (이해충돌 회피).' }
    : undefined
  return c.html(renderAppealsAdminPage({
    userMenuHtml: buildAdminUserMenu(c),
    appeals: (result.results as any[]) || [],
    flash
  }))
})

adminRoutes.post('/admin/appeals/:id/decide', requireAdmin, async (c) => {
  const user = c.get('user')
  if (!user) return c.redirect('/admin/appeals?flash=error')
  const id = parseInt(c.req.param('id'), 10)
  if (!Number.isFinite(id)) return c.redirect('/admin/appeals?flash=error')
  const form = await c.req.formData()
  const status = String(form.get('status') || '') as any
  const note = String(form.get('note') || '') || undefined
  if (!['accepted', 'rejected', 'partially_accepted'].includes(status)) {
    return c.redirect('/admin/appeals?flash=error')
  }
  try {
    await reviewAppeal(c.env.DB, { appealId: id, reviewedBy: user.id, status, note })
    return c.redirect('/admin/appeals?flash=decided')
  } catch (e: any) {
    if (e?.message === 'APPEAL_SAME_DECIDER') {
      return c.redirect('/admin/appeals?flash=same_decider')
    }
    return c.redirect('/admin/appeals?flash=error')
  }
})

// === 회사 답글 승인 (D7 / Glassdoor 모델) ===
adminRoutes.get('/admin/company-replies', requireAdmin, async (c) => {
  const result = await c.env.DB.prepare(
    `SELECT id, comment_id, company_name, responder_name, reply_content, status, created_at
     FROM company_replies ORDER BY created_at DESC LIMIT 100`
  ).all<any>()
  const flashType = c.req.query('flash')
  const flash = flashType === 'decided'
    ? { type: 'success' as const, message: '결정이 기록되었습니다.' }
    : flashType === 'error'
    ? { type: 'error' as const, message: '처리에 실패했습니다.' }
    : undefined
  return c.html(renderCompanyRepliesAdminPage({
    userMenuHtml: buildAdminUserMenu(c),
    replies: (result.results as any[]) || [],
    flash
  }))
})

adminRoutes.post('/admin/company-replies/:id/decide', requireAdmin, async (c) => {
  const user = c.get('user')
  if (!user) return c.redirect('/admin/company-replies?flash=error')
  const id = parseInt(c.req.param('id'), 10)
  if (!Number.isFinite(id)) return c.redirect('/admin/company-replies?flash=error')
  const form = await c.req.formData()
  const status = String(form.get('status') || '') as any
  if (!['approved', 'rejected'].includes(status)) {
    return c.redirect('/admin/company-replies?flash=error')
  }
  await c.env.DB.prepare(
    `UPDATE company_replies SET status = ?, approved_by = ?, approved_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP WHERE id = ?`
  ).bind(status, user.id, id).run()
  return c.redirect('/admin/company-replies?flash=decided')
})

export { adminRoutes }
