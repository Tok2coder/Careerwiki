import type { KVNamespace } from '@cloudflare/workers-types'

const PERF_LOG_PREFIX = 'perf:log:'
const PERF_LOG_INDEX_KEY = 'perf:log:index'
const PERF_LOG_TTL_SECONDS = 60 * 60 * 24 * 7 // 7일 보관
const PERF_INDEX_MAX = 200

export type PerfNavigationMetrics = {
  ttfb?: number | null
  domInteractive?: number | null
  domContentLoaded?: number | null
  loadEvent?: number | null
  transferSize?: number | null
  encodedBodySize?: number | null
  decodedBodySize?: number | null
}

export type PerfVitalsMetrics = {
  fp?: { value: number; reportedAt?: number | null }
  fcp?: { value: number; reportedAt?: number | null }
  lcp?: { value: number; size?: number | null; reportedAt?: number | null }
  cls?: { value: number; reportedAt?: number | null }
  fid?: { value: number; reportedAt?: number | null; event?: string | null }
}

export type PerfHydrationMetrics = Record<
  string,
  {
    duration?: number | null
    completedAt?: number | null
    detail?: {
      totalItems?: number | null
      sortKey?: string | null
    }
  }
>

export type PerfMetricsEvent = {
  type: string
  page?: string | null
  at?: number | null
  detail?: unknown
  action?: string | null
  entityType?: string | null
  entityId?: string | null
  entityName?: string | null
  entityCategory?: string | null
  entitySources?: string[]
  tabId?: string | null
  previousTab?: string | null
  totalTabs?: number | null
  tabCount?: number | null
  duration?: number | null
  perPage?: number | null
  results?: number | null
  keywordLength?: number | null
  phase?: string | null
  sortKey?: string | null
  cacheStatus?: string | null
  ctaType?: string | null
  href?: string | null
  method?: string | null
  outcome?: string | null
  status?: string | null
  intent?: string | null
  visible?: boolean
  expanded?: boolean
  tabs?: string[]
  partials?: string[]
  sourceStatus?: string[]
}

export type PerfMetricsEvents = PerfMetricsEvent[]

export type PerfMetricsPayload = {
  timestamp?: string
  reason?: string
  url?: string
  userAgent?: string
  sampleRate?: number
  sampled?: boolean
  metrics?: {
    nav?: PerfNavigationMetrics
    vitals?: PerfVitalsMetrics
    hydration?: PerfHydrationMetrics
    marks?: Record<string, unknown>
    events?: PerfMetricsEvents
  }
}

export type PerfMetricsRecord = {
  id: string
  receivedAt: number
  clientTimestamp?: string
  reason?: string
  url?: string
  userAgent?: string
  sampleRate?: number
  sampled?: boolean
  metrics: {
    nav?: PerfNavigationMetrics
    vitals?: PerfVitalsMetrics
    hydration?: PerfHydrationMetrics
  }
  marks?: Record<string, unknown>
  events?: PerfMetricsEvents
  alerts?: PerfAlert[]
  meta: {
    ip?: string
    userAgentHash?: string
  }
}

export type PerfAlertSeverity = 'warning' | 'critical'

export type PerfAlert = {
  key: string
  metric: string
  value: number
  threshold: number
  severity: PerfAlertSeverity
  context?: Record<string, unknown>
}

type PerfMetricsIndexEntry = {
  id: string
  receivedAt: number
  reason?: string
  url?: string
}

type PerfMetricsIndex = {
  entries: PerfMetricsIndexEntry[]
  updatedAt: number
}

const PERF_NAV_THRESHOLDS: Record<string, number> = {
  ttfb: 800,
  domInteractive: 3000,
  domContentLoaded: 3500,
  loadEvent: 5000
}

const PERF_VITAL_THRESHOLDS: Record<string, number> = {
  fp: 1800,
  fcp: 2000,
  lcp: 2500,
  cls: 0.1,
  fid: 100
}

const PERF_HYDRATION_THRESHOLD_MS = 1500

const resolveSeverity = (value: number, threshold: number): PerfAlertSeverity =>
  value >= threshold * 1.5 ? 'critical' : 'warning'

const truncate = (value: string | undefined | null, max = 500): string | undefined => {
  if (!value) return undefined
  return value.length > max ? `${value.slice(0, max)}…` : value
}

const hashUserAgent = async (ua: string | undefined | null): Promise<string | undefined> => {
  if (!ua || typeof crypto?.subtle === 'undefined') return undefined
  const encoder = new TextEncoder()
  const data = encoder.encode(ua)
  const digest = await crypto.subtle.digest('SHA-256', data)
  const bytes = Array.from(new Uint8Array(digest))
  return bytes.map((b) => b.toString(16).padStart(2, '0')).join('').slice(0, 32)
}

const sanitizeMetrics = (payload: PerfMetricsPayload): PerfMetricsRecord['metrics'] => {
  const result: PerfMetricsRecord['metrics'] = {}
  if (payload.metrics?.nav) {
    result.nav = payload.metrics.nav
  }
  if (payload.metrics?.vitals) {
    result.vitals = payload.metrics.vitals
  }
  if (payload.metrics?.hydration) {
    result.hydration = payload.metrics.hydration
  }
  return result
}

const sanitizeMarks = (marks: Record<string, unknown> | undefined): Record<string, unknown> | undefined => {
  if (!marks) return undefined
  const allowed: Record<string, unknown> = {}
  for (const [key, value] of Object.entries(marks)) {
    if (typeof value === 'number' || typeof value === 'string') {
      allowed[key] = value
    }
  }
  return Object.keys(allowed).length ? allowed : undefined
}

const sanitizeEventString = (value: unknown, max = 200): string | undefined => {
  if (typeof value !== 'string') return undefined
  const trimmed = value.trim()
  if (!trimmed) return undefined
  return truncate(trimmed, max)
}

const sanitizeEventNumber = (value: unknown): number | undefined => {
  if (typeof value !== 'number' || !Number.isFinite(value)) return undefined
  return value
}

const sanitizeEventBoolean = (value: unknown): boolean | undefined => {
  if (typeof value !== 'boolean') return undefined
  return value
}

const sanitizeEventStringArray = (
  value: unknown,
  options: { maxItems?: number; maxLength?: number } = {}
): string[] | undefined => {
  if (!Array.isArray(value)) return undefined
  const maxItems = options.maxItems ?? 12
  const maxLength = options.maxLength ?? 120
  const items = value
    .filter((item): item is string => typeof item === 'string')
    .map((item) => sanitizeEventString(item, maxLength))
    .filter((item): item is string => !!item)
    .slice(0, maxItems)
  return items.length ? items : undefined
}

const sanitizeEventDetail = (value: unknown, depth = 0): unknown => {
  if (depth > 3) return undefined
  if (typeof value === 'string') {
    return sanitizeEventString(value, 500)
  }
  if (typeof value === 'number') {
    return sanitizeEventNumber(value)
  }
  if (typeof value === 'boolean') {
    return value
  }
  if (!value || typeof value !== 'object') {
    return undefined
  }
  if (Array.isArray(value)) {
    const items = value
      .map((item) => sanitizeEventDetail(item, depth + 1))
      .filter((item) => item !== undefined)
      .slice(0, 20)
    return items.length ? items : undefined
  }
  const result: Record<string, unknown> = {}
  for (const [key, val] of Object.entries(value as Record<string, unknown>)) {
    const sanitized = sanitizeEventDetail(val, depth + 1)
    if (sanitized !== undefined) {
      result[key] = sanitized
    }
  }
  return Object.keys(result).length ? result : undefined
}

const sanitizeEventEntry = (entry: unknown): PerfMetricsEvent | undefined => {
  if (!entry || typeof entry !== 'object') {
    return undefined
  }
  const raw = entry as Record<string, unknown>
  const type = sanitizeEventString(raw.type, 80) ?? 'unknown'
  const result: PerfMetricsEvent = { type }

  const page = sanitizeEventString(raw.page, 200)
  if (page !== undefined) {
    result.page = page
  }

  const at = sanitizeEventNumber(raw.at)
  if (at !== undefined) {
    result.at = at
  }

  const detail = sanitizeEventDetail(raw.detail)
  if (detail !== undefined) {
    result.detail = detail
  }

  const rawPayload =
    raw.payload && typeof raw.payload === 'object' && raw.payload !== null
      ? (raw.payload as Record<string, unknown>)
      : undefined

  const action =
    sanitizeEventString(raw.action, 200) ?? (rawPayload ? sanitizeEventString(rawPayload.action, 200) : undefined)
  if (action !== undefined) {
    result.action = action
  }

  const rawEntity =
    raw.entity && typeof raw.entity === 'object' && raw.entity !== null
      ? (raw.entity as Record<string, unknown>)
      : undefined

  const entityType =
    sanitizeEventString(raw.entityType, 60) ?? (rawEntity ? sanitizeEventString(rawEntity.type, 60) : undefined)
  if (entityType !== undefined) {
    result.entityType = entityType
  }

  const entityId =
    sanitizeEventString(raw.entityId, 120) ?? (rawEntity ? sanitizeEventString(rawEntity.id, 120) : undefined)
  if (entityId !== undefined) {
    result.entityId = entityId
  }

  const entityName =
    sanitizeEventString(raw.entityName, 120) ?? (rawEntity ? sanitizeEventString(rawEntity.name, 120) : undefined)
  if (entityName !== undefined) {
    result.entityName = entityName
  }

  const entityCategory =
    sanitizeEventString(raw.entityCategory, 120) ?? (rawEntity ? sanitizeEventString(rawEntity.category, 120) : undefined)
  if (entityCategory !== undefined) {
    result.entityCategory = entityCategory
  }

  const entitySources = sanitizeEventStringArray(
    raw.entitySources ?? (rawEntity ? rawEntity.sources : undefined),
    { maxItems: 10, maxLength: 60 }
  )
  if (entitySources !== undefined) {
    result.entitySources = entitySources
  }


  const tabId =
    sanitizeEventString(raw.tabId, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.tabId, 60) : undefined)
  if (tabId !== undefined) {
    result.tabId = tabId
  }

  const previousTab =
    sanitizeEventString(raw.previousTab, 60) ??
    (rawPayload ? sanitizeEventString(rawPayload.previousTab, 60) : undefined)
  if (previousTab !== undefined) {
    result.previousTab = previousTab
  }

  const totalTabs =
    sanitizeEventNumber(raw.totalTabs) ?? (rawPayload ? sanitizeEventNumber(rawPayload.totalTabs) : undefined)
  if (totalTabs !== undefined) {
    result.totalTabs = totalTabs
  }

  const tabCount =
    sanitizeEventNumber(raw.tabCount) ?? (rawPayload ? sanitizeEventNumber(rawPayload.tabCount) : undefined)
  if (tabCount !== undefined) {
    result.tabCount = tabCount
  }

  const duration =
    sanitizeEventNumber(raw.duration) ?? (rawPayload ? sanitizeEventNumber(rawPayload.duration) : undefined)
  if (duration !== undefined) {
    result.duration = duration
  }

  const perPage =
    sanitizeEventNumber(raw.perPage) ?? (rawPayload ? sanitizeEventNumber(rawPayload.perPage) : undefined)
  if (perPage !== undefined) {
    result.perPage = perPage
  }

  const resultsValue =
    sanitizeEventNumber(raw.results) ?? (rawPayload ? sanitizeEventNumber(rawPayload.results) : undefined)
  if (resultsValue !== undefined) {
    result.results = resultsValue
  }

  const keywordLength =
    sanitizeEventNumber(raw.keywordLength) ??
    (rawPayload ? sanitizeEventNumber(rawPayload.keywordLength) : undefined)
  if (keywordLength !== undefined) {
    result.keywordLength = keywordLength
  }

  const phase =
    sanitizeEventString(raw.phase, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.phase, 60) : undefined)
  if (phase !== undefined) {
    result.phase = phase
  }

  const sortKey =
    sanitizeEventString(raw.sortKey, 120) ?? (rawPayload ? sanitizeEventString(rawPayload.sortKey, 120) : undefined)
  if (sortKey !== undefined) {
    result.sortKey = sortKey
  }

  const cacheStatus =
    sanitizeEventString(raw.cacheStatus, 60) ??
    (rawPayload ? sanitizeEventString(rawPayload.cacheStatus, 60) : undefined)
  if (cacheStatus !== undefined) {
    result.cacheStatus = cacheStatus
  }

  const ctaType =
    sanitizeEventString(raw.ctaType, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.ctaType, 60) : undefined)
  if (ctaType !== undefined) {
    result.ctaType = ctaType
  }

  const href =
    sanitizeEventString(raw.href, 500) ?? (rawPayload ? sanitizeEventString(rawPayload.href, 500) : undefined)
  if (href !== undefined) {
    result.href = href
  }

  const method =
    sanitizeEventString(raw.method, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.method, 60) : undefined)
  if (method !== undefined) {
    result.method = method
  }

  const outcome =
    sanitizeEventString(raw.outcome, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.outcome, 60) : undefined)
  if (outcome !== undefined) {
    result.outcome = outcome
  }

  const status =
    sanitizeEventString(raw.status, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.status, 60) : undefined)
  if (status !== undefined) {
    result.status = status
  }

  const intent =
    sanitizeEventString(raw.intent, 120) ?? (rawPayload ? sanitizeEventString(rawPayload.intent, 120) : undefined)
  if (intent !== undefined) {
    result.intent = intent
  }

  const visible =
    sanitizeEventBoolean(raw.visible) ?? (rawPayload ? sanitizeEventBoolean(rawPayload.visible) : undefined)
  if (visible !== undefined) {
    result.visible = visible
  }

  const expanded =
    sanitizeEventBoolean(raw.expanded) ?? (rawPayload ? sanitizeEventBoolean(rawPayload.expanded) : undefined)
  if (expanded !== undefined) {
    result.expanded = expanded
  }

  const tabs = sanitizeEventStringArray(raw.tabs ?? (rawPayload ? rawPayload.tabs : undefined), {
    maxItems: 16,
    maxLength: 60
  })
  if (tabs !== undefined) {
    result.tabs = tabs
  }

  const partials = sanitizeEventStringArray(raw.partials ?? (rawPayload ? rawPayload.partials : undefined), {
    maxItems: 16,
    maxLength: 60
  })
  if (partials !== undefined) {
    result.partials = partials
  }

  const sourceStatus = sanitizeEventStringArray(
    raw.sourceStatus ?? (rawPayload ? rawPayload.sourceStatus : undefined),
    { maxItems: 16, maxLength: 60 }
  )
  if (sourceStatus !== undefined) {
    result.sourceStatus = sourceStatus
  }

  return result
}

const sanitizeEvents = (events: unknown): PerfMetricsEvents | undefined => {
  if (!Array.isArray(events) || events.length === 0) {
    return undefined
  }
  const rawEvents = events as unknown[]
  const sanitized = rawEvents
    .slice(0, 100)
    .map((entry) => sanitizeEventEntry(entry))
    .filter((entry): entry is PerfMetricsEvent => entry !== undefined)
  return sanitized.length ? sanitized : undefined
}

export const evaluatePerfAlerts = (
  metrics: PerfMetricsRecord['metrics'],
  events?: PerfMetricsEvents
): PerfAlert[] => {
  const alerts: PerfAlert[] = []

  const navMetrics = metrics.nav
  if (navMetrics) {
    for (const [key, threshold] of Object.entries(PERF_NAV_THRESHOLDS)) {
      const value = navMetrics[key as keyof typeof navMetrics]
      if (typeof value === 'number' && value > threshold) {
        alerts.push({
          key: `nav:${key}`,
          metric: key,
          value,
          threshold,
          severity: resolveSeverity(value, threshold),
          context: { category: 'navigation' }
        })
      }
    }
  }

  const vitals = metrics.vitals
  if (vitals) {
    (['fp', 'fcp', 'lcp', 'cls', 'fid'] as Array<keyof typeof PERF_VITAL_THRESHOLDS>).forEach((metricKey) => {
      const threshold = PERF_VITAL_THRESHOLDS[metricKey]
      const entry = vitals[metricKey]
      const value = typeof entry?.value === 'number' ? entry.value : undefined
      if (value !== undefined && value > threshold) {
        alerts.push({
          key: `vital:${metricKey}`,
          metric: metricKey,
          value,
          threshold,
          severity: resolveSeverity(value, threshold),
          context: { category: 'web-vitals' }
        })
      }
    })
  }

  const hydration = metrics.hydration
  if (hydration) {
    Object.entries(hydration).forEach(([page, detail]) => {
      const duration = typeof detail?.duration === 'number' ? detail.duration : undefined
      if (duration !== undefined && duration > PERF_HYDRATION_THRESHOLD_MS) {
        alerts.push({
          key: `hydration:${page}`,
          metric: 'hydrationDuration',
          value: duration,
          threshold: PERF_HYDRATION_THRESHOLD_MS,
          severity: resolveSeverity(duration, PERF_HYDRATION_THRESHOLD_MS),
          context: { category: 'hydration', page }
        })
      }
    })
  }

  if (events) {
    events
      .filter((event) => event.type === 'hydration-action' && typeof event.duration === 'number')
      .forEach((event) => {
        if (event.duration && event.duration > PERF_HYDRATION_THRESHOLD_MS) {
          alerts.push({
            key: `hydration-action:${event.page ?? 'unknown'}`,
            metric: 'hydrationActionDuration',
            value: event.duration,
            threshold: PERF_HYDRATION_THRESHOLD_MS,
            severity: resolveSeverity(event.duration, PERF_HYDRATION_THRESHOLD_MS),
            context: {
              category: 'hydration-action',
              page: event.page ?? null,
              action: event.action ?? null,
              phase: event.phase ?? null
            }
          })
        }
      })
  }

  return alerts
}

export const storePerfMetrics = async (
  kv: KVNamespace,
  payload: PerfMetricsPayload,
  options: { ip?: string } = {}
): Promise<{ id: string; alerts?: PerfAlert[] }> => {
  if (!payload || typeof payload !== 'object') {
    throw new Error('Invalid payload')
  }

  const receivedAt = Date.now()
  const uniqueSuffix = typeof crypto?.randomUUID === 'function' ? crypto.randomUUID() : Math.random().toString(36).slice(2)
  const id = `${receivedAt}-${uniqueSuffix}`

  const userAgent = truncate(payload.userAgent, 500)
  const metrics = sanitizeMetrics(payload)

  if (!metrics.nav && !metrics.vitals && !metrics.hydration) {
    throw new Error('No metrics provided')
  }

  const sanitizedEvents = sanitizeEvents(payload.metrics?.events)
  const alerts = evaluatePerfAlerts(metrics, sanitizedEvents)

  const record: PerfMetricsRecord = {
    id,
    receivedAt,
    clientTimestamp: payload.timestamp,
    reason: truncate(payload.reason, 120),
    url: truncate(payload.url, 500),
    userAgent,
    sampleRate: payload.sampleRate,
    sampled: payload.sampled,
    metrics,
    marks: sanitizeMarks(payload.metrics?.marks),
    events: sanitizedEvents,
    alerts: alerts.length ? alerts : undefined,
    meta: {
      ip: options.ip,
      userAgentHash: userAgent ? await hashUserAgent(userAgent) : undefined
    }
  }

  const storageKey = `${PERF_LOG_PREFIX}${id}`
  await kv.put(storageKey, JSON.stringify(record), { expirationTtl: PERF_LOG_TTL_SECONDS })
  await updatePerfMetricsIndex(kv, {
    id,
    receivedAt,
    reason: record.reason,
    url: record.url
  })

  return { id, alerts: alerts.length ? alerts : undefined }
}

const updatePerfMetricsIndex = async (kv: KVNamespace, entry: PerfMetricsIndexEntry) => {
  let current: PerfMetricsIndex = {
    entries: [],
    updatedAt: Date.now()
  }

  try {
    const raw = await kv.get(PERF_LOG_INDEX_KEY)
    if (raw) {
      const parsed = JSON.parse(raw) as PerfMetricsIndex
      if (Array.isArray(parsed.entries)) {
        current.entries = parsed.entries
      }
    }
  } catch (error) {
  }

  current.entries = [entry, ...current.entries].slice(0, PERF_INDEX_MAX)
  current.updatedAt = Date.now()

  await kv.put(PERF_LOG_INDEX_KEY, JSON.stringify(current), { expirationTtl: PERF_LOG_TTL_SECONDS })
}
