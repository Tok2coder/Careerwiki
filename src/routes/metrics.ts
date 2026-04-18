/**
 * /api/admin/metrics/v1 — read-only aggregate metrics for wikicomu-site
 *
 * 스펙: docs/api-metrics-spec.md
 *
 * 격리 원칙 (RISKS §f3):
 * - 이 파일은 admin.ts 와 완전히 독립. requireAdmin / ADMIN_SECRET 공유 금지.
 * - 전용 환경 변수 METRICS_SECRET 만 사용. X-Admin-Secret 는 폴백 없이 거절.
 * - 별도 Hono 라우터로 index.tsx 에 마운트.
 */

import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import type { D1Database, KVNamespace } from '@cloudflare/workers-types'
import { EQUALIZE_FIELDS, hasField } from '../templates/admin/adminJobEqualize'

export const metricsRoutes = new Hono<AppEnv>()

const CACHE_TTL_SEC = 60
const RL_IP_PER_MIN = 60
const RL_GLOBAL_PER_MIN = 600
const RL_FRESH_PER_HOUR = 10

type Scope = 'jobs' | 'majors' | 'all'

interface QualityBuckets {
  contributed: number
  perfect: number
  poor: number
  avg_json_size: number
}

interface MetricsV1Response {
  success: true
  version: 'v1'
  generated_at: string
  cache: { hit: boolean; age_seconds: number }
  totals: { jobs_active: number; majors_active: number }
  enhance: {
    jobs_applied: number
    majors_applied: number
    jobs_today: number
    majors_today: number
    last_applied_at: string | null
  }
  quality: { jobs: QualityBuckets; majors: QualityBuckets }
  youtube_links: {
    jobs_sufficient: number
    jobs_low: number
    majors_sufficient: number
    majors_low: number
  }
  phase_progress: { jobs_pct: number; majors_pct: number }
}

function err(c: any, status: number, code: string, message: string, extraHeaders?: Record<string, string>) {
  if (extraHeaders) for (const [k, v] of Object.entries(extraHeaders)) c.header(k, v)
  return c.json({ success: false, error: message, code }, status)
}

/** SQLite 'YYYY-MM-DD HH:MM:SS' (UTC) → ISO-8601 with Z */
function sqliteToIso(s: string | null | undefined): string | null {
  if (!s) return null
  const normalized = s.includes('T') ? s : s.replace(' ', 'T')
  const withZ = normalized.endsWith('Z') ? normalized : `${normalized}Z`
  const d = new Date(withZ)
  if (isNaN(d.getTime())) return null
  return d.toISOString()
}

/** Asia/Seoul 기준 오늘 자정을 UTC ISO 로 환산 */
const KST_TODAY_START_EXPR = "datetime('now', '+9 hours', 'start of day', '-9 hours')"

async function checkRateLimit(
  kv: KVNamespace,
  ip: string,
  fresh: boolean
): Promise<{ allowed: true } | { allowed: false; retryAfter: number; reason: string }> {
  const now = Date.now()
  const minuteBucket = Math.floor(now / 60_000)
  const hourBucket = Math.floor(now / 3_600_000)

  const ipKey = `rl:metrics:ip:${ip}:${minuteBucket}`
  const globalKey = `rl:metrics:global:${minuteBucket}`
  const freshKey = `rl:metrics:fresh:${ip}:${hourBucket}`

  const [ipRaw, globalRaw, freshRaw] = await Promise.all([
    kv.get(ipKey),
    kv.get(globalKey),
    fresh ? kv.get(freshKey) : Promise.resolve(null),
  ])
  const ipCount = Number(ipRaw) || 0
  const globalCount = Number(globalRaw) || 0
  const freshCount = Number(freshRaw) || 0

  if (ipCount >= RL_IP_PER_MIN) {
    const retryAfter = Math.max(1, 60 - Math.floor((now % 60_000) / 1000))
    return { allowed: false, retryAfter, reason: 'per-IP rate limit (60/min) exceeded' }
  }
  if (globalCount >= RL_GLOBAL_PER_MIN) {
    const retryAfter = Math.max(1, 60 - Math.floor((now % 60_000) / 1000))
    return { allowed: false, retryAfter, reason: 'global rate limit (600/min) exceeded' }
  }
  if (fresh && freshCount >= RL_FRESH_PER_HOUR) {
    const retryAfter = Math.max(1, 3600 - Math.floor((now % 3_600_000) / 1000))
    return { allowed: false, retryAfter, reason: 'fresh bypass rate limit (10/hour) exceeded' }
  }

  // Increment (race acceptable per spec §7)
  await Promise.all([
    kv.put(ipKey, String(ipCount + 1), { expirationTtl: 120 }),
    kv.put(globalKey, String(globalCount + 1), { expirationTtl: 120 }),
    fresh ? kv.put(freshKey, String(freshCount + 1), { expirationTtl: 7200 }) : Promise.resolve(),
  ])

  return { allowed: true }
}

async function countActive(db: D1Database, table: 'jobs' | 'majors'): Promise<number> {
  const row = await db.prepare(`SELECT COUNT(*) as count FROM ${table} WHERE is_active = 1`).first<{ count: number }>()
  return row?.count || 0
}

async function countEnhanceApplied(db: D1Database, entityType: 'job' | 'major'): Promise<number> {
  const marker = entityType === 'job' ? '%[job-data-enhance]%' : '%[major-data-enhance]%'
  const row = await db.prepare(
    `SELECT COUNT(DISTINCT entity_id) as count
     FROM page_revisions
     WHERE entity_type = ? AND change_summary LIKE ?`
  ).bind(entityType, marker).first<{ count: number }>()
  return row?.count || 0
}

async function countEnhanceToday(db: D1Database, entityType: 'job' | 'major'): Promise<number> {
  const marker = entityType === 'job' ? '%[job-data-enhance]%' : '%[major-data-enhance]%'
  const row = await db.prepare(
    `SELECT COUNT(DISTINCT entity_id) as count
     FROM page_revisions
     WHERE entity_type = ?
       AND change_summary LIKE ?
       AND datetime(created_at) >= ${KST_TODAY_START_EXPR}`
  ).bind(entityType, marker).first<{ count: number }>()
  return row?.count || 0
}

async function lastAppliedAt(db: D1Database, markers: Array<'job' | 'major'>): Promise<string | null> {
  if (markers.length === 0) return null
  // OR 조합으로 조회
  const conditions = markers
    .map(() => `(entity_type = ? AND change_summary LIKE ?)`)
    .join(' OR ')
  const binds: any[] = []
  for (const m of markers) {
    binds.push(m)
    binds.push(m === 'job' ? '%[job-data-enhance]%' : '%[major-data-enhance]%')
  }
  const row = await db.prepare(
    `SELECT MAX(created_at) as max_at FROM page_revisions WHERE ${conditions}`
  ).bind(...binds).first<{ max_at: string | null }>()
  return sqliteToIso(row?.max_at)
}

async function countYoutubeSufficient(db: D1Database, table: 'jobs' | 'majors'): Promise<number> {
  const row = await db.prepare(
    `SELECT COUNT(*) as count FROM ${table}
     WHERE is_active = 1
       AND user_contributed_json IS NOT NULL
       AND json_extract(user_contributed_json, '$.youtubeLinks') IS NOT NULL
       AND json_array_length(json_extract(user_contributed_json, '$.youtubeLinks')) >= 3`
  ).first<{ count: number }>()
  return row?.count || 0
}

async function computeQuality(db: D1Database, table: 'jobs' | 'majors'): Promise<QualityBuckets> {
  let contributed = 0
  let perfect = 0
  let poor = 0
  let totalSize = 0
  let offset = 0

  while (true) {
    const batch = await db.prepare(
      `SELECT user_contributed_json FROM ${table}
       WHERE is_active = 1 AND user_contributed_json IS NOT NULL
       ORDER BY id LIMIT 500 OFFSET ?`
    ).bind(offset).all<{ user_contributed_json: string }>()
    const rows = batch.results || []
    for (const r of rows) {
      const raw = r.user_contributed_json
      if (!raw) continue
      contributed++
      totalSize += raw.length
      let count = 0
      try {
        const parsed = JSON.parse(raw)
        for (const f of EQUALIZE_FIELDS) if (hasField(parsed, f)) count++
      } catch {
        // parse 실패 → 완성도 0 으로 간주
      }
      if (count === EQUALIZE_FIELDS.length) perfect++
      if (count < 6) poor++
    }
    if (rows.length < 500) break
    offset += 500
  }

  return {
    contributed,
    perfect,
    poor,
    avg_json_size: contributed > 0 ? Math.round(totalSize / contributed) : 0,
  }
}

async function aggregate(db: D1Database, scope: Scope): Promise<MetricsV1Response> {
  const includeJobs = scope === 'jobs' || scope === 'all'
  const includeMajors = scope === 'majors' || scope === 'all'

  const jobsActiveP = includeJobs ? countActive(db, 'jobs') : Promise.resolve(0)
  const majorsActiveP = includeMajors ? countActive(db, 'majors') : Promise.resolve(0)

  const jobsAppliedP = includeJobs ? countEnhanceApplied(db, 'job') : Promise.resolve(0)
  const majorsAppliedP = includeMajors ? countEnhanceApplied(db, 'major') : Promise.resolve(0)

  const jobsTodayP = includeJobs ? countEnhanceToday(db, 'job') : Promise.resolve(0)
  const majorsTodayP = includeMajors ? countEnhanceToday(db, 'major') : Promise.resolve(0)

  const lastAppliedMarkers: Array<'job' | 'major'> = []
  if (includeJobs) lastAppliedMarkers.push('job')
  if (includeMajors) lastAppliedMarkers.push('major')
  const lastAppliedP = lastAppliedAt(db, lastAppliedMarkers)

  const jobsYtP = includeJobs ? countYoutubeSufficient(db, 'jobs') : Promise.resolve(0)
  const majorsYtP = includeMajors ? countYoutubeSufficient(db, 'majors') : Promise.resolve(0)

  const jobsQualityP = includeJobs
    ? computeQuality(db, 'jobs')
    : Promise.resolve<QualityBuckets>({ contributed: 0, perfect: 0, poor: 0, avg_json_size: 0 })
  const majorsQualityP = includeMajors
    ? computeQuality(db, 'majors')
    : Promise.resolve<QualityBuckets>({ contributed: 0, perfect: 0, poor: 0, avg_json_size: 0 })

  const [
    jobsActive, majorsActive,
    jobsApplied, majorsApplied,
    jobsToday, majorsToday,
    lastApplied,
    jobsYt, majorsYt,
    jobsQuality, majorsQuality,
  ] = await Promise.all([
    jobsActiveP, majorsActiveP,
    jobsAppliedP, majorsAppliedP,
    jobsTodayP, majorsTodayP,
    lastAppliedP,
    jobsYtP, majorsYtP,
    jobsQualityP, majorsQualityP,
  ])

  const jobsPct = jobsActive > 0 ? Math.round((jobsApplied / jobsActive) * 100) : 0
  const majorsPct = majorsActive > 0 ? Math.round((majorsApplied / majorsActive) * 100) : 0

  return {
    success: true,
    version: 'v1',
    generated_at: new Date().toISOString(),
    cache: { hit: false, age_seconds: 0 },
    totals: { jobs_active: jobsActive, majors_active: majorsActive },
    enhance: {
      jobs_applied: jobsApplied,
      majors_applied: majorsApplied,
      jobs_today: jobsToday,
      majors_today: majorsToday,
      last_applied_at: lastApplied,
    },
    quality: { jobs: jobsQuality, majors: majorsQuality },
    youtube_links: {
      jobs_sufficient: jobsYt,
      jobs_low: Math.max(0, jobsActive - jobsYt),
      majors_sufficient: majorsYt,
      majors_low: Math.max(0, majorsActive - majorsYt),
    },
    phase_progress: { jobs_pct: jobsPct, majors_pct: majorsPct },
  }
}

metricsRoutes.get('/api/admin/metrics/v1', async (c) => {
  const env = c.env

  // §4 Auth
  if (!env.METRICS_SECRET) {
    return err(c, 503, 'NOT_CONFIGURED', 'metrics endpoint not configured')
  }
  const provided = c.req.header('X-Metrics-Secret')
  if (!provided) {
    return err(c, 401, 'AUTH_MISSING', 'X-Metrics-Secret header required')
  }
  if (provided !== env.METRICS_SECRET) {
    return err(c, 403, 'AUTH_INVALID', 'invalid metrics secret')
  }

  // §3 Query params
  const rawScope = c.req.query('scope') || 'all'
  const scope: Scope = rawScope === 'jobs' || rawScope === 'majors' ? rawScope : 'all'
  const fresh = c.req.query('fresh') === '1'

  // §7 Rate limit
  const ip = c.req.header('cf-connecting-ip') || c.req.header('x-forwarded-for') || 'unknown'
  if (!env.KV) {
    return err(c, 503, 'NOT_CONFIGURED', 'metrics cache (KV) not configured')
  }
  const rl = await checkRateLimit(env.KV, ip, fresh)
  if (!rl.allowed) {
    return err(c, 429, 'RATE_LIMITED', rl.reason, { 'Retry-After': String(rl.retryAfter) })
  }

  const cacheKey = `metrics:v1:${scope}`

  // §6.1 Cache read (fresh=1 skip)
  if (!fresh) {
    try {
      const cached = await env.KV.get(cacheKey, 'json') as (MetricsV1Response & { _cached_at?: number }) | null
      if (cached && cached._cached_at) {
        const age = Math.max(0, Math.floor((Date.now() - cached._cached_at) / 1000))
        const resp: MetricsV1Response = {
          ...cached,
          cache: { hit: true, age_seconds: age },
        }
        delete (resp as any)._cached_at
        return c.json(resp)
      }
    } catch {
      // 캐시 실패 시 fresh 경로로 폴백
    }
  }

  // §5 Aggregate fresh
  try {
    const payload = await aggregate(env.DB, scope)
    const cacheValue = { ...payload, _cached_at: Date.now() }
    c.executionCtx.waitUntil(
      env.KV.put(cacheKey, JSON.stringify(cacheValue), { expirationTtl: CACHE_TTL_SEC })
    )
    return c.json(payload)
  } catch (e: any) {
    console.error('[metrics/v1] aggregation failed:', e?.message, e?.stack)
    return err(c, 500, 'QUERY_FAILED', e?.message || 'aggregation failed')
  }
})
