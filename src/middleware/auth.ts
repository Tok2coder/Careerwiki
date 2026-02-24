/**
 * 인증 Middleware
 *
 * Dual-Mode: 세션 토큰 우선, JWT fallback (마이그레이션 기간)
 * - session_token 쿠키 → KV 세션 검증
 * - access_token 쿠키 → JWT 검증 (fallback, 자동 세션 마이그레이션)
 */

import { createMiddleware } from 'hono/factory'
import { getCookie, setCookie, deleteCookie } from 'hono/cookie'
import type { Context } from 'hono'
import type { CloudflareBindings } from '../../worker-configuration'
import { verifyAccessToken } from '../utils/jwt'
import { getUserById } from '../utils/auth-helpers'
import type { User, OAuthProvider } from '../utils/auth-helpers'
import { validateSession, touchSession, destroySession, createSession, SESSION_COOKIE_MAX_AGE } from '../utils/session'

/**
 * Context Variables 타입 확장
 */
declare module 'hono' {
  interface ContextVariableMap {
    user: User | null
    sessionToken: string | null
  }
}

/**
 * 인증 Middleware
 *
 * 1. session_token 쿠키 → KV 세션 검증 (새 방식)
 * 2. access_token 쿠키 → JWT 검증 + 자동 세션 발급 (마이그레이션)
 * 3. 둘 다 없으면 비로그인
 */
export const authMiddleware = createMiddleware<{ Bindings: CloudflareBindings }>(
  async (c, next) => {
    const sessionToken = getCookie(c, 'session_token')
    const isHttps = c.req.header('x-forwarded-proto') === 'https' || c.req.url.startsWith('https://')

    // ──────────── 1. 세션 토큰 검증 (새 방식) ────────────
    if (sessionToken && c.env.KV) {
      const session = await validateSession(c.env.KV, sessionToken)

      if (session) {
        const user = await getUserById(c.env.DB, session.userId)

        if (user && user.is_banned !== 1) {
          c.set('user', user)
          c.set('sessionToken', sessionToken)

          // Sliding window 갱신 (비동기, 응답 차단하지 않음)
          c.executionCtx.waitUntil(touchSession(c.env.KV, sessionToken, session))

          return next()
        }

        // 밴 유저 또는 삭제된 유저 → 세션 파괴
        if (user && user.is_banned === 1) {
          c.executionCtx.waitUntil(
            destroySession(c.env.KV, c.env.DB, sessionToken, 'ban')
          )
        }
        deleteCookie(c, 'session_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
      } else {
        // KV에 세션 없음 (만료) → 쿠키 정리
        deleteCookie(c, 'session_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
      }
    }

    // ──────────── 2. JWT fallback (마이그레이션) ────────────
    const accessToken = getCookie(c, 'access_token')

    if (accessToken) {
      const payload = await verifyAccessToken(accessToken, c.env.JWT_SECRET)

      if (payload) {
        const user = await getUserById(c.env.DB, payload.userId)

        if (user && user.is_banned !== 1) {
          c.set('user', user)
          c.set('sessionToken', null)

          // 자동 세션 마이그레이션: JWT 유저에게 세션 토큰 발급
          if (c.env.KV) {
            try {
              const newToken = await createSession(c.env.KV, c.env.DB, user.id, {
                ip: c.req.header('cf-connecting-ip') || 'unknown',
                userAgent: c.req.header('user-agent') || 'unknown',
                provider: (user.provider as OAuthProvider) || 'google',
              })
              setCookie(c, 'session_token', newToken, {
                httpOnly: true,
                secure: isHttps,
                sameSite: 'Lax',
                maxAge: SESSION_COOKIE_MAX_AGE,
                path: '/',
              })
              c.set('sessionToken', newToken)

              // 기존 JWT 쿠키 정리
              deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
              deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
            } catch {
              // 세션 생성 실패해도 JWT로 계속 진행
            }
          }

          return next()
        }
      }

      // JWT 검증 실패 → 쿠키 정리
      c.set('user', null)
      c.set('sessionToken', null)
      deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
      deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
      return next()
    }

    // ──────────── 3. 비로그인 ────────────
    c.set('user', null)
    c.set('sessionToken', null)
    return next()
  }
)

/**
 * 로그인 필수 Middleware
 * 
 * 로그인하지 않은 경우 Google 로그인 페이지로 리다이렉트합니다.
 */
export const requireAuth = createMiddleware<{ Bindings: CloudflareBindings }>(
  async (c, next) => {
    const user = c.get('user')
    
    if (!user) {
      
      // 현재 URL을 return_url로 저장
      const url = new URL(c.req.url)
      const pathWithQuery = url.pathname + url.search
      const returnUrl = encodeURIComponent(pathWithQuery || '/')
      return c.redirect(`/login?redirect=${returnUrl}`)
    }
    
    return next()
  }
)

/**
 * 특정 역할 필수 Middleware
 * 
 * @param minRole - 최소 필요 역할 ('user', 'expert', 'admin')
 */
export const requireRole = (minRole: 'user' | 'expert' | 'admin') => {
  return createMiddleware<{ Bindings: CloudflareBindings }>(async (c, next) => {
    const user = c.get('user')
    
    if (!user) {
      return c.json({ error: 'Authentication required' }, 401)
    }
    
    // 역할 계층 구조
    const roleHierarchy: Record<string, number> = {
      user: 1,
      expert: 2,
      admin: 3
    }
    
    const userLevel = roleHierarchy[user.role] || 0
    const requiredLevel = roleHierarchy[minRole] || 0
    
    if (userLevel < requiredLevel) {
      
      return c.json({ 
        error: 'Insufficient permissions',
        required: minRole,
        current: user.role
      }, 403)
    }
    
    
    return next()
  })
}

/**
 * Admin 전용 Middleware
 * 
 * admin 역할만 접근 가능합니다.
 */
export const requireAdmin = requireRole('admin')

/**
 * Expert 이상 Middleware
 * 
 * expert 또는 admin 역할만 접근 가능합니다.
 */
export const requireExpert = requireRole('expert')

/**
 * 직업/전공 페이지 편집 권한 체크
 * 
 * Phase 4: 익명 편집 허용
 * - 로그인 사용자: 모든 역할 허용
 * - 익명 사용자: 비밀번호 검증은 API 엔드포인트에서 처리
 */
export const requireJobMajorEdit = createMiddleware<{ Bindings: CloudflareBindings }>(
  async (c, next) => {
    const user = c.get('user')
    
    // 익명 사용자도 허용 (비밀번호 검증은 API 엔드포인트에서 처리)
    if (user) {
    } else {
    }
    
    return next()
  }
)

/**
 * HowTo 편집 권한 체크
 * 
 * 로그인 필수, 본인 글만 편집 가능 (admin 제외)
 * - 로그인 사용자: user/expert/admin 모두 편집 가능
 * - 익명 사용자: 편집 불가
 * - 작성자 확인은 API 엔드포인트에서 수행
 */
export const requireHowToEdit = createMiddleware<{ Bindings: CloudflareBindings }>(
  async (c, next) => {
    const user = c.get('user')
    
    // 로그인 필수
    if (!user) {
      return c.json({ error: 'LOGIN_REQUIRED', message: 'HowTo 편집은 로그인이 필요합니다.' }, 401)
    }
    
    
    return next()
  }
)

