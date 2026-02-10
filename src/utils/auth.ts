/**
 * 인증 유틸리티 함수
 *
 * Context에서 사용자 정보를 가져오는 헬퍼 함수들
 */

import type { Context } from 'hono'
import type { User } from './auth-helpers'

/**
 * Context에서 사용자 ID 가져오기
 *
 * @param c - Hono Context
 * @returns 사용자 ID 또는 null (비로그인 시)
 */
export function getUserIdFromContext(c: Context): number | null {
  const user = c.get('user') as User | null
  return user?.id ?? null
}

/**
 * Context에서 사용자 정보 가져오기
 *
 * @param c - Hono Context
 * @returns User 객체 또는 null (비로그인 시)
 */
export function getUserFromContext(c: Context): User | null {
  return c.get('user') as User | null
}

/**
 * 로그인 여부 확인
 *
 * @param c - Hono Context
 * @returns true면 로그인 상태
 */
export function isLoggedIn(c: Context): boolean {
  return getUserFromContext(c) !== null
}

/**
 * 특정 역할 이상인지 확인
 *
 * @param c - Hono Context
 * @param minRole - 최소 필요 역할
 * @returns true면 해당 역할 이상
 */
export function hasRole(c: Context, minRole: 'user' | 'expert' | 'admin'): boolean {
  const user = getUserFromContext(c)
  if (!user) return false

  const roleHierarchy: Record<string, number> = {
    user: 1,
    expert: 2,
    admin: 3,
  }

  const userLevel = roleHierarchy[user.role] || 0
  const requiredLevel = roleHierarchy[minRole] || 0

  return userLevel >= requiredLevel
}
