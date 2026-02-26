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
}

/**
 * pages 테이블 조회수 추적 (HowTo 가이드용)
 */
export async function trackPageView(ctx: ViewContext & { pageId: number }): Promise<boolean> {
  if (BOT_UA_PATTERN.test(ctx.userAgent)) return false

  const kvKey = `pv:${ctx.pageId}:${getIdentity(ctx.userId, ctx.ip)}`
  if (await ctx.kv.get(kvKey)) return false

  await Promise.all([
    ctx.kv.put(kvKey, '1', { expirationTtl: VIEW_DEDUP_TTL }),
    ctx.db.prepare('UPDATE pages SET view_count = view_count + 1 WHERE id = ?')
      .bind(ctx.pageId).run(),
  ])
  return true
}

/**
 * jobs 테이블 조회수 추적 (직업 상세 페이지)
 */
export async function trackJobView(ctx: ViewContext & { slug: string }): Promise<boolean> {
  if (BOT_UA_PATTERN.test(ctx.userAgent)) return false

  const kvKey = `jv:${ctx.slug}:${getIdentity(ctx.userId, ctx.ip)}`
  if (await ctx.kv.get(kvKey)) return false

  await Promise.all([
    ctx.kv.put(kvKey, '1', { expirationTtl: VIEW_DEDUP_TTL }),
    ctx.db.prepare('UPDATE jobs SET view_count = view_count + 1 WHERE slug = ?')
      .bind(ctx.slug).run(),
  ])
  return true
}

/**
 * majors 테이블 조회수 추적 (전공 상세 페이지)
 */
export async function trackMajorView(ctx: ViewContext & { slug: string }): Promise<boolean> {
  if (BOT_UA_PATTERN.test(ctx.userAgent)) return false

  const kvKey = `mv:${ctx.slug}:${getIdentity(ctx.userId, ctx.ip)}`
  if (await ctx.kv.get(kvKey)) return false

  await Promise.all([
    ctx.kv.put(kvKey, '1', { expirationTtl: VIEW_DEDUP_TTL }),
    ctx.db.prepare('UPDATE majors SET view_count = view_count + 1 WHERE slug = ?')
      .bind(ctx.slug).run(),
  ])
  return true
}

/**
 * share_tokens 테이블 조회수 추적
 */
export async function trackShareView(ctx: ViewContext & { token: string }): Promise<boolean> {
  if (BOT_UA_PATTERN.test(ctx.userAgent)) return false

  const kvKey = `sv:${ctx.token}:${getIdentity(ctx.userId, ctx.ip)}`
  if (await ctx.kv.get(kvKey)) return false

  await Promise.all([
    ctx.kv.put(kvKey, '1', { expirationTtl: VIEW_DEDUP_TTL }),
    ctx.db.prepare(`
      UPDATE share_tokens SET view_count = view_count + 1, last_viewed_at = CURRENT_TIMESTAMP
      WHERE share_token = ?
    `).bind(ctx.token).run(),
  ])
  return true
}
