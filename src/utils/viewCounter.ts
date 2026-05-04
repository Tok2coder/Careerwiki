/**
 * 조회수 추적 유틸리티
 * - 15분 시간 윈도우 중복 방지 (KV 기반)
 * - 봇 트래픽 필터링
 * - 로그인 유저: user_id 기반, 비로그인: IP hash 기반
 */
import type { D1Database, KVNamespace } from '@cloudflare/workers-types'

const BOT_UA_PATTERN = /bot|crawl|spider|slack|facebook|twitter|kakao|discord|telegram|line|preview|fetch|curl|wget|python|ruby|java|php|go-http/i

const VIEW_DEDUP_TTL = 900 // 15분 (초)

/**
 * 순방문자 기록 (일별 IP 해시 기반, INSERT OR IGNORE로 중복 무시)
 */
async function recordUniqueVisitor(db: D1Database, ip: string): Promise<void> {
  const ipH = hashIp(ip)
  try {
    await db.prepare(
      `INSERT OR IGNORE INTO unique_visitor_daily (stat_date, ip_hash) VALUES (date('now'), ?)`
    ).bind(ipH).run()
  } catch { /* 테이블 없으면 무시 */ }
}

/**
 * Referer URL에서 도메인 + path 추출 (쿼리스트링은 PII 위험으로 제거)
 * 브라우저 Referrer-Policy로 path가 잘려 hostname만 오는 경우도 많음
 */
function extractRefererDomain(referer?: string): string | null {
  if (!referer) return null
  try {
    const url = new URL(referer)
    const path = url.pathname || ''
    if (path && path !== '/') {
      // 80자 초과 시 절단
      const cleanPath = path.length > 80 ? path.slice(0, 80) + '…' : path
      return url.hostname + cleanPath
    }
    return url.hostname
  } catch {
    return referer.slice(0, 120) // URL 파싱 실패 시 앞부분만
  }
}

/**
 * 방문 페이지뷰 상세 기록 (visitor_page_views 테이블)
 */
async function recordPageView(db: D1Database, ip: string, pageType: string, pageId: string, referer?: string): Promise<void> {
  const ipH = hashIp(ip)
  const ref = extractRefererDomain(referer)
  try {
    await db.prepare(
      `INSERT INTO visitor_page_views (ip_hash, page_type, page_id, referer) VALUES (?, ?, ?, ?)`
    ).bind(ipH, pageType, pageId, ref).run()
  } catch { /* 테이블 없으면 무시 */ }
}

/**
 * IP를 간단한 해시로 변환 (개인정보 보호)
 */
function hashIp(ip: string): string {
  let hash = 0
  for (let i = 0; i < ip.length; i++) {
    const char = ip.charCodeAt(i)
    hash = ((hash << 5) - hash) + char
    hash |= 0 // 32-bit integer
  }
  return Math.abs(hash).toString(36)
}

function getIdentity(userId?: number, ip?: string): string {
  return userId ? `u${userId}` : `ip${hashIp(ip || 'unknown')}`
}

interface ViewContext {
  db: D1Database
  kv: KVNamespace
  userAgent: string
  userId?: number
  ip: string
  role?: string  // 'admin' 이면 통계에서 제외
  referer?: string  // HTTP Referer 헤더
}

/**
 * pages 테이블 조회수 추적 (HowTo 가이드용)
 */
export async function trackPageView(ctx: ViewContext & { pageId: number }): Promise<boolean> {
  if (BOT_UA_PATTERN.test(ctx.userAgent)) return false
  if (ctx.role === 'admin') return false

  const kvKey = `pv:${ctx.pageId}:${getIdentity(ctx.userId, ctx.ip)}`
  if (await ctx.kv.get(kvKey)) return false

  await Promise.all([
    ctx.kv.put(kvKey, '1', { expirationTtl: VIEW_DEDUP_TTL }),
    ctx.db.prepare('UPDATE pages SET view_count = view_count + 1 WHERE id = ?')
      .bind(ctx.pageId).run(),
    ctx.db.prepare(`
      INSERT INTO daily_view_stats (stat_date, entity_type, total_views)
      VALUES (date('now'), 'howto', 1)
      ON CONFLICT (stat_date, entity_type)
      DO UPDATE SET total_views = total_views + 1
    `).run(),
    recordUniqueVisitor(ctx.db, ctx.ip),
    recordPageView(ctx.db, ctx.ip, 'howto', String(ctx.pageId), ctx.referer),
  ])
  return true
}

/**
 * jobs 테이블 조회수 추적 (직업 상세 페이지)
 */
export async function trackJobView(ctx: ViewContext & { slug: string }): Promise<boolean> {
  if (BOT_UA_PATTERN.test(ctx.userAgent)) return false
  if (ctx.role === 'admin') return false

  const kvKey = `jv:${ctx.slug}:${getIdentity(ctx.userId, ctx.ip)}`
  if (await ctx.kv.get(kvKey)) return false

  await Promise.all([
    ctx.kv.put(kvKey, '1', { expirationTtl: VIEW_DEDUP_TTL }),
    ctx.db.prepare('UPDATE jobs SET view_count = view_count + 1 WHERE slug = ?')
      .bind(ctx.slug).run(),
    ctx.db.prepare(`
      INSERT INTO daily_view_stats (stat_date, entity_type, total_views)
      VALUES (date('now'), 'job', 1)
      ON CONFLICT (stat_date, entity_type)
      DO UPDATE SET total_views = total_views + 1
    `).run(),
    recordUniqueVisitor(ctx.db, ctx.ip),
    recordPageView(ctx.db, ctx.ip, 'job', ctx.slug, ctx.referer),
  ])
  return true
}

/**
 * majors 테이블 조회수 추적 (전공 상세 페이지)
 */
export async function trackMajorView(ctx: ViewContext & { slug: string }): Promise<boolean> {
  if (BOT_UA_PATTERN.test(ctx.userAgent)) return false
  if (ctx.role === 'admin') return false

  const kvKey = `mv:${ctx.slug}:${getIdentity(ctx.userId, ctx.ip)}`
  if (await ctx.kv.get(kvKey)) return false

  await Promise.all([
    ctx.kv.put(kvKey, '1', { expirationTtl: VIEW_DEDUP_TTL }),
    ctx.db.prepare('UPDATE majors SET view_count = view_count + 1 WHERE slug = ?')
      .bind(ctx.slug).run(),
    ctx.db.prepare(`
      INSERT INTO daily_view_stats (stat_date, entity_type, total_views)
      VALUES (date('now'), 'major', 1)
      ON CONFLICT (stat_date, entity_type)
      DO UPDATE SET total_views = total_views + 1
    `).run(),
    recordUniqueVisitor(ctx.db, ctx.ip),
    recordPageView(ctx.db, ctx.ip, 'major', ctx.slug, ctx.referer),
  ])
  return true
}

/**
 * share_tokens 테이블 조회수 추적
 */
export async function trackShareView(ctx: ViewContext & { token: string }): Promise<boolean> {
  if (BOT_UA_PATTERN.test(ctx.userAgent)) return false
  if (ctx.role === 'admin') return false

  const kvKey = `sv:${ctx.token}:${getIdentity(ctx.userId, ctx.ip)}`
  if (await ctx.kv.get(kvKey)) return false

  await Promise.all([
    ctx.kv.put(kvKey, '1', { expirationTtl: VIEW_DEDUP_TTL }),
    ctx.db.prepare(`
      UPDATE share_tokens SET view_count = view_count + 1, last_viewed_at = CURRENT_TIMESTAMP
      WHERE share_token = ?
    `).bind(ctx.token).run(),
    ctx.db.prepare(`
      INSERT INTO daily_view_stats (stat_date, entity_type, total_views)
      VALUES (date('now'), 'share', 1)
      ON CONFLICT (stat_date, entity_type)
      DO UPDATE SET total_views = total_views + 1
    `).run(),
    recordUniqueVisitor(ctx.db, ctx.ip),
    recordPageView(ctx.db, ctx.ip, 'share', ctx.token, ctx.referer),
  ])
  return true
}
