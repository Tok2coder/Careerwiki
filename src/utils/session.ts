/**
 * 서버 세션 관리 모듈
 *
 * JWT를 대체하는 Opaque Session Token 기반 인증
 * - KV: 세션 데이터 저장 (Redis 대체)
 * - D1: 세션 감사 로그
 * - Sliding window: 활동 시 세션 자동 연장
 */

import type { KVNamespace, D1Database } from '@cloudflare/workers-types'
import type { OAuthProvider } from './auth-helpers'

// =============================================================================
// 상수
// =============================================================================

/** 세션 유휴 타임아웃 (7일, 초) */
const SESSION_IDLE_TTL = 7 * 24 * 60 * 60 // 604800

/** 세션 절대 최대 수명 (30일, 초) */
const SESSION_ABSOLUTE_MAX = 30 * 24 * 60 * 60 // 2592000

/** 세션 쿠키 maxAge (30일, 초) — 실제 만료는 KV TTL이 제어 */
export const SESSION_COOKIE_MAX_AGE = 30 * 24 * 60 * 60

/** Sliding window 갱신 디바운스 간격 (5분, 초) */
const SESSION_TOUCH_INTERVAL = 5 * 60 // 300

/** user-sessions 인덱스 최대 세션 수 */
const MAX_SESSIONS_PER_USER = 10

// =============================================================================
// 타입
// =============================================================================

export interface SessionData {
  userId: number
  createdAt: number       // Unix seconds
  lastActiveAt: number    // Sliding window용
  ip: string
  userAgent: string
  provider: string
  deviceLabel: string
}

export interface SessionSummary {
  tokenPrefix: string     // 토큰 앞 8자 (식별용)
  createdAt: number
  lastActiveAt: number
  deviceLabel: string
  ip: string
  isCurrent: boolean
}

interface UserSessionEntry {
  token: string
  createdAt: number
  lastActiveAt: number
  deviceLabel: string
  ip: string
}

// =============================================================================
// 세션 생성
// =============================================================================

/**
 * 새 세션을 생성하고 KV에 저장한다.
 *
 * @returns 세션 토큰 문자열
 */
export async function createSession(
  kv: KVNamespace,
  db: D1Database,
  userId: number,
  metadata: { ip: string; userAgent: string; provider: OAuthProvider }
): Promise<string> {
  const token = `${crypto.randomUUID()}-${crypto.randomUUID()}`
  const now = Math.floor(Date.now() / 1000)

  const sessionData: SessionData = {
    userId,
    createdAt: now,
    lastActiveAt: now,
    ip: maskIp(metadata.ip),
    userAgent: metadata.userAgent.slice(0, 200),
    provider: metadata.provider,
    deviceLabel: deriveDeviceLabel(metadata.userAgent),
  }

  // KV에 세션 저장
  await kv.put(
    `session:${token}`,
    JSON.stringify(sessionData),
    { expirationTtl: SESSION_IDLE_TTL }
  )

  // user-sessions 인덱스 업데이트
  await addToUserSessionIndex(kv, userId, {
    token,
    createdAt: now,
    lastActiveAt: now,
    deviceLabel: sessionData.deviceLabel,
    ip: sessionData.ip,
  })

  // D1 감사 로그
  try {
    const tokenHash = await hashToken(token)
    await db.prepare(`
      INSERT INTO user_sessions (user_id, session_token_hash, provider, ip_address, device_label, last_active_at)
      VALUES (?, ?, ?, ?, ?, ?)
    `).bind(userId, tokenHash, metadata.provider, sessionData.ip, sessionData.deviceLabel, now).run()
  } catch {
    // 감사 로그 실패는 세션 생성을 막지 않음
  }

  return token
}

// =============================================================================
// 세션 검증
// =============================================================================

/**
 * KV에서 세션을 조회하고 유효성을 확인한다.
 *
 * @returns 유효하면 SessionData, 아니면 null
 */
export async function validateSession(
  kv: KVNamespace,
  token: string
): Promise<SessionData | null> {
  const raw = await kv.get(`session:${token}`)
  if (!raw) return null

  const session: SessionData = JSON.parse(raw)
  const now = Math.floor(Date.now() / 1000)

  // 절대 최대 수명 초과 확인
  if (now - session.createdAt > SESSION_ABSOLUTE_MAX) {
    await kv.delete(`session:${token}`)
    return null
  }

  return session
}

// =============================================================================
// Sliding Window 갱신
// =============================================================================

/**
 * 세션의 lastActiveAt을 갱신하고 KV TTL을 리셋한다.
 * 5분 디바운스로 KV 쓰기를 최소화한다.
 */
export async function touchSession(
  kv: KVNamespace,
  token: string,
  session: SessionData
): Promise<void> {
  const now = Math.floor(Date.now() / 1000)

  // 5분 이내 재갱신 방지
  if (now - session.lastActiveAt < SESSION_TOUCH_INTERVAL) {
    return
  }

  session.lastActiveAt = now

  // 세션 KV와 인덱스를 병렬로 갱신
  await Promise.all([
    kv.put(
      `session:${token}`,
      JSON.stringify(session),
      { expirationTtl: SESSION_IDLE_TTL }
    ),
    updateSessionIndexLastActive(kv, session.userId, token, now),
  ])
}

// =============================================================================
// 세션 삭제
// =============================================================================

/**
 * 단일 세션을 삭제한다.
 *
 * @param knownUserId - 이미 userId를 알고 있으면 전달 (KV 읽기 1회 절감)
 */
export async function destroySession(
  kv: KVNamespace,
  db: D1Database,
  token: string,
  reason: string,
  knownUserId?: number
): Promise<void> {
  // userId가 없으면 KV에서 세션을 조회해서 얻기
  let userId = knownUserId
  if (userId === undefined) {
    const raw = await kv.get(`session:${token}`)
    if (raw) {
      userId = (JSON.parse(raw) as SessionData).userId
    }
  }

  // 세션 KV 삭제 + 인덱스 업데이트 병렬 실행
  const tasks: Promise<unknown>[] = [kv.delete(`session:${token}`)]
  if (userId !== undefined) {
    tasks.push(removeFromUserSessionIndex(kv, userId, token))
  }
  await Promise.all(tasks)

  // 감사 로그 업데이트
  try {
    const tokenHash = await hashToken(token)
    const now = Math.floor(Date.now() / 1000)
    await db.prepare(`
      UPDATE user_sessions SET expired_at = ?, logout_reason = ? WHERE session_token_hash = ? AND expired_at IS NULL
    `).bind(now, reason, tokenHash).run()
  } catch {
    // 감사 로그 실패는 무시
  }
}

/**
 * 특정 유저의 모든 세션을 삭제한다.
 *
 * @returns 삭제된 세션 수
 */
export async function destroyAllUserSessions(
  kv: KVNamespace,
  db: D1Database,
  userId: number,
  reason: string
): Promise<number> {
  const entries = await getUserSessionEntries(kv, userId)

  // 모든 세션 KV에서 삭제
  await Promise.all(entries.map(e => kv.delete(`session:${e.token}`)))

  // 인덱스 삭제
  await kv.delete(`user-sessions:${userId}`)

  // 감사 로그 일괄 업데이트
  try {
    const now = Math.floor(Date.now() / 1000)
    await db.prepare(`
      UPDATE user_sessions SET expired_at = ?, logout_reason = ? WHERE user_id = ? AND expired_at IS NULL
    `).bind(now, reason, userId).run()
  } catch {
    // 감사 로그 실패는 무시
  }

  return entries.length
}

// =============================================================================
// 세션 목록 조회
// =============================================================================

/**
 * 유저의 활성 세션 목록을 반환한다.
 */
export async function listUserSessions(
  kv: KVNamespace,
  userId: number,
  currentToken?: string
): Promise<SessionSummary[]> {
  const entries = await getUserSessionEntries(kv, userId)

  return entries.map(e => ({
    tokenPrefix: e.token.substring(0, 8),
    createdAt: e.createdAt,
    lastActiveAt: e.lastActiveAt,
    deviceLabel: e.deviceLabel,
    ip: e.ip,
    isCurrent: currentToken ? e.token === currentToken : false,
  }))
}

// =============================================================================
// 유저-세션 인덱스 관리 (내부)
// =============================================================================

export async function getUserSessionEntries(kv: KVNamespace, userId: number): Promise<UserSessionEntry[]> {
  const raw = await kv.get(`user-sessions:${userId}`)
  if (!raw) return []

  try {
    const data = JSON.parse(raw) as { sessions: UserSessionEntry[] }
    return data.sessions || []
  } catch {
    return []
  }
}

async function addToUserSessionIndex(
  kv: KVNamespace,
  userId: number,
  entry: UserSessionEntry
): Promise<void> {
  let entries = await getUserSessionEntries(kv, userId)

  // 같은 기기(deviceLabel)의 이전 세션 제거 (같은 기기에서 재로그인 시 중복 방지)
  const duplicates = entries.filter(e => e.deviceLabel === entry.deviceLabel)
  for (const dup of duplicates) {
    await kv.delete(`session:${dup.token}`)
  }
  entries = entries.filter(e => e.deviceLabel !== entry.deviceLabel)

  // 최대 세션 수 초과 시 가장 오래된 세션 제거
  if (entries.length >= MAX_SESSIONS_PER_USER) {
    const oldest = entries.sort((a, b) => a.lastActiveAt - b.lastActiveAt)[0]
    if (oldest) {
      await kv.delete(`session:${oldest.token}`)
      entries = entries.filter(e => e.token !== oldest.token)
    }
  }

  entries.push(entry)

  await kv.put(
    `user-sessions:${userId}`,
    JSON.stringify({ sessions: entries }),
    { expirationTtl: SESSION_ABSOLUTE_MAX }
  )
}

async function removeFromUserSessionIndex(
  kv: KVNamespace,
  userId: number,
  token: string
): Promise<void> {
  const entries = await getUserSessionEntries(kv, userId)
  const filtered = entries.filter(e => e.token !== token)

  if (filtered.length === 0) {
    await kv.delete(`user-sessions:${userId}`)
  } else {
    await kv.put(
      `user-sessions:${userId}`,
      JSON.stringify({ sessions: filtered }),
      { expirationTtl: SESSION_ABSOLUTE_MAX }
    )
  }
}

async function updateSessionIndexLastActive(
  kv: KVNamespace,
  userId: number,
  token: string,
  lastActiveAt: number
): Promise<void> {
  const entries = await getUserSessionEntries(kv, userId)
  const entry = entries.find(e => e.token === token)
  if (!entry) return

  entry.lastActiveAt = lastActiveAt

  await kv.put(
    `user-sessions:${userId}`,
    JSON.stringify({ sessions: entries }),
    { expirationTtl: SESSION_ABSOLUTE_MAX }
  )
}

// =============================================================================
// 유틸리티
// =============================================================================

/**
 * User-Agent → 기기/브라우저 라벨 변환
 */
export function deriveDeviceLabel(ua: string): string {
  if (!ua) return 'Unknown'

  // 브라우저 판별
  let browser = 'Browser'
  if (ua.includes('Edg/')) browser = 'Edge'
  else if (ua.includes('OPR/') || ua.includes('Opera')) browser = 'Opera'
  else if (ua.includes('Chrome/') && !ua.includes('Edg/')) browser = 'Chrome'
  else if (ua.includes('Firefox/')) browser = 'Firefox'
  else if (ua.includes('Safari/') && !ua.includes('Chrome/')) browser = 'Safari'

  // OS 판별
  let os = ''
  if (ua.includes('iPhone') || ua.includes('iPad')) os = 'iOS'
  else if (ua.includes('Android')) os = 'Android'
  else if (ua.includes('Windows')) os = 'Windows'
  else if (ua.includes('Mac OS')) os = 'macOS'
  else if (ua.includes('Linux')) os = 'Linux'

  return os ? `${browser} on ${os}` : browser
}

/**
 * IP를 마스킹한다 (뒷부분 숨김).
 * IPv4: 1.2.3.* / IPv6: 앞 4블록만
 */
function maskIp(ip: string): string {
  if (!ip || ip === 'unknown') return 'unknown'

  if (ip.includes(':')) {
    // IPv6: 앞 4블록만 표시
    const parts = ip.split(':')
    return parts.slice(0, 4).join(':') + ':*'
  }

  // IPv4: 마지막 옥텟 마스킹
  const parts = ip.split('.')
  if (parts.length === 4) {
    parts[3] = '*'
    return parts.join('.')
  }

  return ip
}

/**
 * 세션 토큰의 SHA-256 해시 (감사 로그용)
 */
async function hashToken(token: string): Promise<string> {
  const data = new TextEncoder().encode(token)
  const hash = await crypto.subtle.digest('SHA-256', data)
  return Array.from(new Uint8Array(hash))
    .map(b => b.toString(16).padStart(2, '0'))
    .join('')
}
