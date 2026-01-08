/**
 * Phase 3 Day 2: 인증 Middleware
 * 
 * - authMiddleware: 모든 요청에서 JWT 검증, 사용자 정보를 Context에 저장
 * - requireAuth: 로그인 필수 체크
 * - requireRole: 특정 역할 필수 체크
 */

import { createMiddleware } from 'hono/factory'
import { getCookie } from 'hono/cookie'
import type { Context } from 'hono'
import type { CloudflareBindings } from '../../worker-configuration'
import { verifyAccessToken } from '../utils/jwt'
import { getUserById } from '../utils/auth-helpers'
import type { User } from '../utils/auth-helpers'

/**
 * Context Variables 타입 확장
 */
declare module 'hono' {
  interface ContextVariableMap {
    user: User | null
  }
}

/**
 * 인증 Middleware
 * 
 * 모든 요청에서 JWT Access Token을 검증하고,
 * 유효한 경우 Context에 사용자 정보를 저장합니다.
 * 
 * 로그인하지 않은 경우에도 요청은 계속 진행됩니다. (user = null)
 */
export const authMiddleware = createMiddleware<{ Bindings: CloudflareBindings }>(
  async (c, next) => {
    const accessToken = getCookie(c, 'access_token')
    
    // Access Token이 없으면 비로그인 상태
    if (!accessToken) {
      c.set('user', null)
      return next()
    }
    
    // JWT 검증
    const payload = await verifyAccessToken(accessToken, c.env.JWT_SECRET)
    
    if (!payload) {
      // JWT 검증 실패 (만료 또는 변조)
      c.set('user', null)
      return next()
    }
    
    // D1에서 사용자 정보 조회 (역할 변경 등을 위해)
    const user = await getUserById(c.env.DB, payload.userId)
    
    if (!user) {
      // 사용자가 DB에 없음 (삭제됨)
      c.set('user', null)
      return next()
    }
    
    // 사용자 차단 확인
    if (user.is_banned === 1) {
      console.log('🚫 [Auth] Banned user attempted access')
      console.log('   User ID:', user.id)
      console.log('   Reason:', user.ban_reason)
      
      c.set('user', null)
      return next()
    }
    
    // Context에 사용자 정보 저장
    c.set('user', user)
    
    console.log('✅ [Auth] User authenticated')
    console.log('   User ID:', user.id)
    console.log('   Email:', user.email)
    console.log('   Role:', user.role)
    
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
      console.log('⛔ [Auth] Authentication required')
      console.log('   Path:', c.req.path)
      
      // 현재 URL을 return_url로 저장
      const url = new URL(c.req.url)
      const pathWithQuery = url.pathname + url.search
      const returnUrl = encodeURIComponent(pathWithQuery || '/')
      return c.redirect(`/auth/google?return_url=${returnUrl}`)
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
      console.log('⛔ [Auth] Authentication required for role check')
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
      console.log('⛔ [Auth] Insufficient permissions')
      console.log('   User Role:', user.role, `(Level ${userLevel})`)
      console.log('   Required Role:', minRole, `(Level ${requiredLevel})`)
      
      return c.json({ 
        error: 'Insufficient permissions',
        required: minRole,
        current: user.role
      }, 403)
    }
    
    console.log('✅ [Auth] Role check passed')
    console.log('   User Role:', user.role)
    console.log('   Required Role:', minRole)
    
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
      console.log('✅ [Auth] Job/Major edit permission granted')
      console.log('   User Role:', user.role)
    } else {
      console.log('✅ [Auth] Anonymous edit allowed (password verification in API)')
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
      console.log('⛔ [Auth] HowTo edit requires login')
      return c.json({ error: 'LOGIN_REQUIRED', message: 'HowTo 편집은 로그인이 필요합니다.' }, 401)
    }
    
      console.log('✅ [Auth] HowTo edit permission granted')
    console.log('   User ID:', user.id)
    console.log('   User Role:', user.role)
    
    return next()
  }
)

