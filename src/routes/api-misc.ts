import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import {
  isAnalysisType, isPricingTier, isRequestStatus,
  parseNumberParam, getClientIp, toIntegerOrNull, hashIpAddress
} from '../utils/shared-helpers'
import { storePerfMetrics, type PerfMetricsPayload, type PerfAlert } from '../services/perfMetricsService'
import {
  createOrUpdateSession,
  createAnalysisRequest,
  createAnalysisResult,
  getAnalysisRequestWithResult,
  getSession as getAiSession,
  listRequestsBySession,
  updateRequestStatus
} from '../services/aiAnalysisService'
import {
  recordSerpInteraction,
  getDailySerpSummary,
  listRecentSerpInteractions
} from '../services/serpInteractionService'
import { attemptScheduledRefresh, getFreshnessStatus, resolveFreshnessTargetById } from '../services/freshnessService'

export const apiMiscRoutes = new Hono<AppEnv>()

const formatPerfAlertLine = (alert: PerfAlert): string => {
  const severityIcon = alert.severity === 'critical' ? '🚨' : '⚠️'
  const isScoreMetric = alert.metric.toLowerCase().includes('cls')
  const rounding = (value: number) => (isScoreMetric ? value.toFixed(2) : `${Math.round(value)}ms`)
  const contextParts: string[] = []
  if (alert.context?.page) {
    contextParts.push(`page=${alert.context.page}`)
  }
  if (alert.context?.action) {
    contextParts.push(`action=${alert.context.action}`)
  }
  if (alert.context?.category) {
    contextParts.push(`cat=${alert.context.category}`)
  }
  const contextSuffix = contextParts.length ? ` (${contextParts.join(' · ')})` : ''
  return `${severityIcon} ${alert.metric}: ${rounding(alert.value)} > ${rounding(alert.threshold)}${contextSuffix}`
}

const sendPerfAlertsToSlack = async (
  webhook: string,
  options: {
    alerts: PerfAlert[]
    url?: string
    reason?: string
    id: string
  }
): Promise<void> => {
  try {
    const header = options.reason ? `Perf alert (${options.reason})` : 'Perf alert detected'
    const urlLine = options.url ? `URL: ${options.url}` : null
    const lines = options.alerts.slice(0, 6).map((alert) => formatPerfAlertLine(alert))
    const bodyLines = [header, `Log ID: ${options.id}`, ...(urlLine ? [urlLine] : []), ...lines]
    const payload = { text: bodyLines.join('\n') }
    await fetch(webhook, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    })
  } catch (error) {
  }
}

// 현재 로그인 사용자 정보 조회 (클라이언트에서 동적으로 확인용)
apiMiscRoutes.get('/api/me', async (c) => {
  const user = c.get('user')
  
  if (!user) {
    return c.json({ user: null })
  }
  
  return c.json({
    user: {
      id: user.id,
      name: user.name,
      username: user.username,
      role: user.role,
      pictureUrl: user.custom_picture_url || user.picture_url || null
    }
  })
})


apiMiscRoutes.post('/api/perf-metrics', async (c) => {
  let payload: PerfMetricsPayload
  try {
    payload = await c.req.json<PerfMetricsPayload>()
  } catch (error) {
    return c.json({ success: false, error: 'invalid json body' }, 400)
  }

  try {
    // 로컬 개발 환경에서는 KV가 없을 수 있음
    if (!c.env.KV) {
      return c.json({
        success: true,
        data: { id: 'local-dev-skip' },
        alerts: []
      })
    }

    const rawIp = c.req.header('cf-connecting-ip') ?? null
    const ipHash = await hashIpAddress(rawIp)
    const result = await storePerfMetrics(c.env.KV, payload, { ip: ipHash ?? undefined })

    if (result.alerts && result.alerts.length && c.env.PERF_ALERT_WEBHOOK) {
      c.executionCtx.waitUntil(
        sendPerfAlertsToSlack(c.env.PERF_ALERT_WEBHOOK, {
          alerts: result.alerts,
          url: payload.url,
          reason: payload.reason,
          id: result.id
        })
      )
    }

    return c.json({
      success: true,
      data: {
        id: result.id
      },
      alerts: result.alerts ?? []
    })
  } catch (error) {
    return c.json({ success: false, error: 'failed to store metrics' }, 500)
  }
})

// Phase 3 Day 4: 클라이언트 IP 주소 반환 API
apiMiscRoutes.get('/api/client-ip', (c) => {
  const ipAddress = getClientIp(c)
  return c.json({ ip: ipAddress || '127.0.0.1' })
})

// Phase 3 Day 4: 클라이언트 IP 주소 반환 API
apiMiscRoutes.get('/api/client-ip', (c) => {
  const ipAddress = getClientIp(c)
  return c.json({ ip: ipAddress || '127.0.0.1' })
})

apiMiscRoutes.post('/api/analyzer/sessions', async (c) => {
  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  if (!body || typeof body !== 'object') {
    return c.json({ success: false, error: 'invalid body' }, 400)
  }

  try {
    const session = await createOrUpdateSession(c.env.DB, {
      sessionId: typeof body.sessionId === 'string' ? body.sessionId : undefined,
      userIdentifier: typeof body.userIdentifier === 'string' ? body.userIdentifier : undefined,
      traitsSnapshot: body.traits ?? body.traitsSnapshot
    })

    const includeRequests = Boolean(body.includeRequests)
    const response: Record<string, unknown> = { session }

    if (includeRequests) {
      const limitInput = typeof body.requestLimit === 'number' ? Math.floor(body.requestLimit) : 10
      const limit = Number.isFinite(limitInput) ? Math.min(Math.max(limitInput, 1), 100) : 10
      const requests = await listRequestsBySession(c.env.DB, session.id, limit)
      response.requests = requests
    }

    return c.json({ success: true, data: response })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'session upsert failed'
    return c.json({ success: false, error: message }, 500)
  }
})

apiMiscRoutes.get('/api/analyzer/sessions/:id', async (c) => {
  const sessionId = c.req.param('id')
  const includeRequests = c.req.query('includeRequests') === '1'
  const limit = parseNumberParam(c.req.query('limit'), 20, { min: 1, max: 50 })

  const session = await getAiSession(c.env.DB, sessionId)
  if (!session) {
    return c.json({ success: false, error: 'session not found' }, 404)
  }

  const result: Record<string, unknown> = { session }
  if (includeRequests) {
    const requests = await listRequestsBySession(c.env.DB, sessionId, limit)
    result.requests = requests
  }

  return c.json({ success: true, data: result })
})


apiMiscRoutes.post('/api/analyzer/requests', async (c) => {
  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  const sessionId = typeof body.sessionId === 'string' ? body.sessionId : ''
  const analysisType = body.analysisType
  const promptPayload = body.promptPayload

  if (!sessionId) {
    return c.json({ success: false, error: 'sessionId is required' }, 400)
  }

  if (!isAnalysisType(analysisType)) {
    return c.json({ success: false, error: 'analysisType must be "job" or "major"' }, 400)
  }

  if (promptPayload === undefined) {
    return c.json({ success: false, error: 'promptPayload is required' }, 400)
  }

  const session = await getAiSession(c.env.DB, sessionId)
  if (!session) {
    return c.json({ success: false, error: 'session not found' }, 404)
  }

  const pricingTier = isPricingTier(body.pricingTier) ? body.pricingTier : 'free'
  const initialStatus = isRequestStatus(body.status) ? body.status : 'pending'

  try {
    const request = await createAnalysisRequest(c.env.DB, {
      sessionId,
      analysisType,
      pricingTier,
      promptPayload,
      status: initialStatus
    })

    return c.json({ success: true, data: { request } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to create analysis request'
    return c.json({ success: false, error: message }, 500)
  }
})


apiMiscRoutes.get('/api/analyzer/requests/:id', async (c) => {
  const requestId = Number(c.req.param('id'))
  if (Number.isNaN(requestId)) {
    return c.json({ success: false, error: 'invalid request id' }, 400)
  }

  const record = await getAnalysisRequestWithResult(c.env.DB, requestId)
  if (!record) {
    return c.json({ success: false, error: 'request not found' }, 404)
  }

  return c.json({ success: true, data: record })
})


apiMiscRoutes.post('/api/analyzer/requests/:id/result', async (c) => {
  const requestId = Number(c.req.param('id'))
  if (Number.isNaN(requestId)) {
    return c.json({ success: false, error: 'invalid request id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  if (typeof body.provider !== 'string' || !body.provider) {
    return c.json({ success: false, error: 'provider is required' }, 400)
  }

  if (body.responsePayload === undefined) {
    return c.json({ success: false, error: 'responsePayload is required' }, 400)
  }

  const requestStatus = body.requestStatus
  if (requestStatus !== undefined && !isRequestStatus(requestStatus)) {
    return c.json({ success: false, error: 'invalid requestStatus' }, 400)
  }

  try {
    const { request, result } = await createAnalysisResult(c.env.DB, {
      requestId,
      provider: body.provider,
      model: typeof body.model === 'string' ? body.model : null,
      completionTokens: typeof body.completionTokens === 'number' ? body.completionTokens : null,
      promptTokens: typeof body.promptTokens === 'number' ? body.promptTokens : null,
      totalTokens: typeof body.totalTokens === 'number' ? body.totalTokens : null,
      latencyMs: typeof body.latencyMs === 'number' ? body.latencyMs : null,
      responseSummary: typeof body.responseSummary === 'string' ? body.responseSummary : null,
      responsePayload: body.responsePayload,
      requestStatus
    })

    return c.json({ success: true, data: { request, result } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to store analysis result'
    return c.json({ success: false, error: message }, 500)
  }
})

apiMiscRoutes.post('/api/analyzer/requests/:id/status', async (c) => {
  const requestId = Number(c.req.param('id'))
  if (Number.isNaN(requestId)) {
    return c.json({ success: false, error: 'invalid request id' }, 400)
  }

  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  if (!isRequestStatus(body.status)) {
    return c.json({ success: false, error: 'invalid status' }, 400)
  }

  const processedAt = typeof body.processedAt === 'string'
    ? body.processedAt
    : (body.status === 'completed' || body.status === 'failed' ? new Date().toISOString() : null)

  try {
    const request = await updateRequestStatus(c.env.DB, requestId, body.status, processedAt)
    return c.json({ success: true, data: { request } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to update status'
    return c.json({ success: false, error: message }, 500)
  }
})

apiMiscRoutes.get('/api/analyzer/sessions/:id/requests', async (c) => {
  const sessionId = c.req.param('id')
  const limit = parseNumberParam(c.req.query('limit'), 20, { min: 1, max: 50 })
  const requests = await listRequestsBySession(c.env.DB, sessionId, limit)
  return c.json({ success: true, data: { requests } })
})

apiMiscRoutes.post('/api/serp-interactions', async (c) => {
  let body: any
  try {
    body = await c.req.json()
  } catch {
    body = {}
  }

  if (!isAnalysisType(body.pageType)) {
    return c.json({ success: false, error: 'pageType must be "job" or "major"' }, 400)
  }

  if (typeof body.action !== 'string' || !body.action.trim()) {
    return c.json({ success: false, error: 'action is required' }, 400)
  }

  try {
    const record = await recordSerpInteraction(c.env.DB, {
      pageType: body.pageType,
      action: body.action,
      keywordLength: toIntegerOrNull(body.keywordLength, { min: 0 }),
      category: typeof body.category === 'string' ? body.category : null,
      perPage: toIntegerOrNull(body.perPage, { min: 1, max: 50 }),
      results: toIntegerOrNull(body.results, { min: 0, max: 500 }),
      cacheStatus: typeof body.cacheStatus === 'string' ? body.cacheStatus : null,
      durationMs: toIntegerOrNull(body.durationMs, { min: 0 }),
      sampled: typeof body.sampled === 'boolean' ? body.sampled : null,
      source: typeof body.source === 'string' ? body.source : null
    })

    return c.json({ success: true, data: { record } })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to record interaction'
    return c.json({ success: false, error: message }, 500)
  }
})

apiMiscRoutes.get('/api/serp-interactions/recent', async (c) => {
  const limit = parseNumberParam(c.req.query('limit'), 50, { min: 1, max: 200 })
  const records = await listRecentSerpInteractions(c.env.DB, limit)
  return c.json({ success: true, data: { records } })
})

apiMiscRoutes.get('/api/serp-interactions/summary', async (c) => {
  const startDate = c.req.query('startDate') || undefined
  const endDate = c.req.query('endDate') || undefined
  const pageType = c.req.query('pageType') as ('job' | 'major') | undefined
  const action = c.req.query('action') || undefined
  const limit = parseNumberParam(c.req.query('limit'), 50, { min: 1, max: 200 })

  const summaries = await getDailySerpSummary(c.env.DB, {
    startDate,
    endDate,
    pageType,
    action,
    limit
  })

  return c.json({ success: true, data: { summaries } })
})

apiMiscRoutes.get('/api/freshness/status', async (c) => {
  try {
    const status = await getFreshnessStatus(c.env.KV)
    return c.json({
      success: true,
      data: status
    })
  } catch (error) {
    return c.json(
      {
        success: false,
        error: error instanceof Error ? error.message : 'freshness status fetch failed'
      },
      500
    )
  }
})

apiMiscRoutes.post('/api/freshness/run', async (c) => {
  try {
    let body: { targetId?: string; force?: boolean; reason?: string } = {}
    try {
      body = await c.req.json<{ targetId?: string; force?: boolean; reason?: string }>()
    } catch {
      body = {}
    }

    const targetId = body.targetId || c.req.query('targetId')
    if (!targetId) {
      return c.json({ success: false, error: 'targetId required' }, 400)
    }

    const target = resolveFreshnessTargetById(targetId)
    if (!target) {
      return c.json({ success: false, error: 'unknown targetId' }, 404)
    }

    const result = await attemptScheduledRefresh(c.env.KV, c.env, target, {
      force: body.force ?? c.req.query('force') === '1',
      reason: body.reason || 'manual-trigger'
    })

    return c.json({
      success: result.outcome === 'success',
      result
    })
  } catch (error) {
    return c.json(
      {
        success: false,
        error: error instanceof Error ? error.message : 'freshness run failed'
      },
      500
    )
  }
})
