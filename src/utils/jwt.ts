/**
 * Phase 3 Day 2: JWT 유틸리티 함수
 * 
 * JWT (JSON Web Token) 생성, 검증, 갱신 기능 제공
 * - Access Token: 1시간 TTL (짧게)
 * - Refresh Token: 7일 TTL (길게)
 * 
 * jose 라이브러리 사용 (Cloudflare Workers 호환)
 */

import { SignJWT, jwtVerify } from 'jose'
import type { KVNamespace } from '@cloudflare/workers-types'

/**
 * JWT Payload 타입
 */
export interface JWTPayload {
  userId: number
  role: 'user' | 'expert' | 'admin'
  email: string
}

/**
 * JWT Secret을 TextEncoder로 변환
 */
function getSecretKey(secret: string): Uint8Array {
  return new TextEncoder().encode(secret)
}

/**
 * Access Token 생성 (1시간 TTL)
 * 
 * @param payload - 사용자 정보 (userId, role, email)
 * @param secret - JWT Secret Key
 * @returns JWT Access Token
 */
export async function generateAccessToken(
  payload: JWTPayload,
  secret: string
): Promise<string> {
  const secretKey = getSecretKey(secret)
  
  const token = await new SignJWT({
    userId: payload.userId,
    role: payload.role,
    email: payload.email
  })
    .setProtectedHeader({ alg: 'HS256' })
    .setIssuedAt()
    .setExpirationTime('1h') // 1시간
    .sign(secretKey)
  
  console.log('🔐 [JWT] Access Token generated')
  console.log('   User ID:', payload.userId)
  console.log('   Role:', payload.role)
  console.log('   Expires: 1 hour')
  
  return token
}

/**
 * Refresh Token 생성 및 KV 저장 (7일 TTL)
 * 
 * @param userId - 사용자 ID
 * @param kv - KV Namespace (선택 사항, Day 2에서는 미사용)
 * @returns Refresh Token (UUID)
 */
export async function generateRefreshToken(
  userId: number,
  kv?: KVNamespace
): Promise<string> {
  // UUID 생성 (Refresh Token)
  const refreshToken = crypto.randomUUID()
  
  // KV에 저장 (Day 2에서는 선택 사항)
  if (kv) {
    const data = {
      userId,
      createdAt: Date.now()
    }
    
    // 7일 TTL (60 * 60 * 24 * 7 = 604800초)
    await kv.put(
      `refresh:${refreshToken}`,
      JSON.stringify(data),
      { expirationTtl: 604800 }
    )
    
    console.log('🔐 [JWT] Refresh Token stored in KV')
    console.log('   User ID:', userId)
    console.log('   Token:', refreshToken.substring(0, 20) + '...')
    console.log('   Expires: 7 days')
  } else {
    console.log('🔐 [JWT] Refresh Token generated (KV not configured)')
    console.log('   User ID:', userId)
    console.log('   Token:', refreshToken.substring(0, 20) + '...')
  }
  
  return refreshToken
}

/**
 * Access Token 검증
 * 
 * @param token - JWT Access Token
 * @param secret - JWT Secret Key
 * @returns Payload 또는 null (검증 실패 시)
 */
export async function verifyAccessToken(
  token: string,
  secret: string
): Promise<JWTPayload | null> {
  try {
    const secretKey = getSecretKey(secret)
    const { payload } = await jwtVerify(token, secretKey)
    
    console.log('✅ [JWT] Access Token verified')
    console.log('   User ID:', payload.userId)
    console.log('   Role:', payload.role)
    
    return {
      userId: payload.userId as number,
      role: payload.role as 'user' | 'expert' | 'admin',
      email: payload.email as string
    }
  } catch (error) {
    console.log('❌ [JWT] Access Token verification failed')
    console.log('   Error:', error instanceof Error ? error.message : 'Unknown error')
    return null
  }
}

/**
 * Refresh Token 검증 및 사용자 정보 조회
 * 
 * @param refreshToken - Refresh Token (UUID)
 * @param kv - KV Namespace
 * @returns 사용자 ID 또는 null (검증 실패 시)
 */
export async function verifyRefreshToken(
  refreshToken: string,
  kv: KVNamespace
): Promise<number | null> {
  try {
    const data = await kv.get(`refresh:${refreshToken}`)
    
    if (!data) {
      console.log('❌ [JWT] Refresh Token not found in KV')
      return null
    }
    
    const parsed = JSON.parse(data) as { userId: number; createdAt: number }
    
    console.log('✅ [JWT] Refresh Token verified')
    console.log('   User ID:', parsed.userId)
    console.log('   Created:', new Date(parsed.createdAt).toISOString())
    
    return parsed.userId
  } catch (error) {
    console.log('❌ [JWT] Refresh Token verification failed')
    console.log('   Error:', error instanceof Error ? error.message : 'Unknown error')
    return null
  }
}

/**
 * Refresh Token 삭제 (로그아웃 시)
 * 
 * @param refreshToken - Refresh Token (UUID)
 * @param kv - KV Namespace
 */
export async function deleteRefreshToken(
  refreshToken: string,
  kv: KVNamespace
): Promise<void> {
  await kv.delete(`refresh:${refreshToken}`)
  
  console.log('🗑️ [JWT] Refresh Token deleted from KV')
  console.log('   Token:', refreshToken.substring(0, 20) + '...')
}


