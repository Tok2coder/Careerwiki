/**
 * Phase 3: 인증 헬퍼 함수
 * 
 * D1 데이터베이스와 상호작용하는 인증 관련 유틸리티
 * 
 * 업데이트 (2025-12-09): provider 방식 지원 (Google/Kakao/Naver 등)
 */

import type { D1Database } from '@cloudflare/workers-types'

/**
 * 지원하는 OAuth Provider 타입
 */
export type OAuthProvider = 'google' | 'kakao' | 'naver'

/**
 * 사용자 타입 (D1 users 테이블)
 */
export interface User {
  id: number
  // 레거시 호환 (마이그레이션 후에도 기존 google_id 컬럼 유지)
  google_id: string
  // 새로운 provider 방식
  provider: OAuthProvider
  provider_user_id: string
  email: string
  name: string | null
  picture_url: string | null
  custom_picture_url: string | null  // 사용자가 직접 업로드한 프로필 이미지
  username: string | null  // 닉네임으로 사용
  role: 'user' | 'expert' | 'admin'
  edit_count: number
  comment_count: number
  is_banned: number // SQLite BOOLEAN (0 or 1)
  ban_reason: string | null
  banned_until: number | null
  onboarded: number  // 온보딩 완료 여부 (0 or 1)
  last_login_at: number | null
  created_at: number | null
  updated_at: number | null
}

/**
 * OAuth 프로필 정보 (모든 provider 공통)
 */
export interface OAuthProfile {
  provider: OAuthProvider
  provider_user_id: string
  email: string
  name: string | null
  picture_url: string | null
}

/**
 * 레거시 Google 프로필 (하위 호환)
 */
export interface GoogleProfile {
  google_id: string
  email: string
  name: string | null
  picture_url: string | null
}

/**
 * D1에서 provider + provider_user_id로 사용자 조회
 */
export async function getUserByProvider(
  db: D1Database,
  provider: OAuthProvider,
  providerUserId: string
): Promise<User | null> {
  const result = await db
    .prepare('SELECT * FROM users WHERE provider = ? AND provider_user_id = ?')
    .bind(provider, providerUserId)
    .first<User>()
  
  return result || null
}

/**
 * D1에서 Google ID로 사용자 조회 (레거시 호환)
 */
export async function getUserByGoogleId(
  db: D1Database,
  googleId: string
): Promise<User | null> {
  const result = await db
    .prepare('SELECT * FROM users WHERE google_id = ?')
    .bind(googleId)
    .first<User>()
  
  return result || null
}

/**
 * D1에서 User ID로 사용자 조회
 */
export async function getUserById(
  db: D1Database,
  userId: number
): Promise<User | null> {
  const result = await db
    .prepare('SELECT * FROM users WHERE id = ?')
    .bind(userId)
    .first<User>()
  
  return result || null
}

/**
 * D1에서 Email로 사용자 조회
 */
export async function getUserByEmail(
  db: D1Database,
  email: string
): Promise<User | null> {
  const result = await db
    .prepare('SELECT * FROM users WHERE email = ?')
    .bind(email)
    .first<User>()
  
  return result || null
}

/**
 * D1에서 닉네임(username)으로 사용자 조회
 */
export async function getUserByUsername(
  db: D1Database,
  username: string
): Promise<User | null> {
  const result = await db
    .prepare('SELECT * FROM users WHERE username = ?')
    .bind(username)
    .first<User>()
  
  return result || null
}

/**
 * 고유한 임시 사용자 아이디 생성
 * 형식: user_XXXXXX (6자리 랜덤 문자열)
 * 온보딩 전 임시 닉네임으로 사용
 */
async function generateTempUsername(db: D1Database): Promise<string> {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
  const maxAttempts = 10
  
  for (let attempt = 0; attempt < maxAttempts; attempt++) {
    // 6자리 랜덤 문자열 생성
    let randomPart = ''
    for (let i = 0; i < 6; i++) {
      randomPart += chars[Math.floor(Math.random() * chars.length)]
    }
    
    const username = `user_${randomPart}`
    
    // 중복 체크
    const existing = await db
      .prepare('SELECT id FROM users WHERE username = ?')
      .bind(username)
      .first()
    
    if (!existing) {
      return username
    }
    
  }
  
  // 최대 시도 횟수 초과 시 타임스탬프 기반 생성
  const timestamp = Date.now().toString(36)
  return `user_${timestamp}`
}

/**
 * D1에 새 사용자 생성 (OAuth 프로필 기반)
 */
export async function createUserFromOAuth(
  db: D1Database,
  profile: OAuthProfile
): Promise<User> {
  const now = Math.floor(Date.now() / 1000) // UNIX timestamp
  
  
  // 임시 닉네임 생성 (온보딩에서 변경)
  const tempUsername = await generateTempUsername(db)
  
  // google_id는 레거시 호환을 위해 provider_user_id와 동일하게 설정 (Google인 경우)
  const googleIdValue = profile.provider === 'google' ? profile.provider_user_id : ''
  
  const result = await db
    .prepare(`
      INSERT INTO users (
        google_id, provider, provider_user_id,
        email, name, picture_url, username, role,
        edit_count, comment_count, is_banned,
        onboarded, last_login_at, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, 'user', 0, 0, 0, 0, ?, ?, ?)
    `)
    .bind(
      googleIdValue,
      profile.provider,
      profile.provider_user_id,
      profile.email,
      profile.name,
      profile.picture_url,
      tempUsername,
      now, // last_login_at
      now, // created_at
      now  // updated_at
    )
    .run()
  
  if (!result.success) {
    throw new Error('Failed to create user in database')
  }
  
  
  // 생성된 사용자 조회
  const user = await getUserById(db, result.meta.last_row_id as number)
  
  if (!user) {
    throw new Error('Failed to retrieve created user')
  }
  
  return user
}

/**
 * D1에 새 사용자 생성 (레거시 GoogleProfile 호환)
 */
export async function createUser(
  db: D1Database,
  profile: GoogleProfile
): Promise<User> {
  // GoogleProfile을 OAuthProfile로 변환
  const oauthProfile: OAuthProfile = {
    provider: 'google',
    provider_user_id: profile.google_id,
    email: profile.email,
    name: profile.name,
    picture_url: profile.picture_url
  }
  
  return createUserFromOAuth(db, oauthProfile)
}

/**
 * D1에서 사용자 정보 업데이트 (last_login_at, 프로필 동기화)
 */
export async function updateUser(
  db: D1Database,
  userId: number,
  profile: Partial<OAuthProfile>
): Promise<void> {
  const now = Math.floor(Date.now() / 1000)
  
  
  // 업데이트할 필드만 포함
  const updates: string[] = ['last_login_at = ?', 'updated_at = ?']
  const bindings: (string | number | null)[] = [now, now]
  
  if (profile.name !== undefined) {
    updates.push('name = ?')
    bindings.push(profile.name)
  }
  
  if (profile.picture_url !== undefined) {
    updates.push('picture_url = ?')
    bindings.push(profile.picture_url)
  }
  
  if (profile.email !== undefined) {
    updates.push('email = ?')
    bindings.push(profile.email)
  }
  
  bindings.push(userId) // WHERE 조건
  
  const result = await db
    .prepare(`
      UPDATE users
      SET ${updates.join(', ')}
      WHERE id = ?
    `)
    .bind(...bindings)
    .run()
  
  if (!result.success) {
    throw new Error('Failed to update user in database')
  }
  
}

/**
 * 사용자 조회 또는 생성 (OAuth 로그인 시 사용)
 * 
 * 1. provider + provider_user_id로 사용자 조회
 * 2. 없으면 신규 생성 (onboarded=0)
 * 3. 있으면 last_login_at 및 프로필 업데이트
 */
export async function getOrCreateUserFromOAuth(
  db: D1Database,
  profile: OAuthProfile
): Promise<User> {
  
  // 1. 기존 사용자 조회 (새 방식)
  let user = await getUserByProvider(db, profile.provider, profile.provider_user_id)
  
  // 레거시 호환: Google 로그인인데 새 방식으로 못 찾으면 google_id로 재시도
  if (!user && profile.provider === 'google') {
    user = await getUserByGoogleId(db, profile.provider_user_id)
    
    // 레거시 사용자 발견 시 provider 필드 업데이트
    if (user && (!user.provider || !user.provider_user_id)) {
      await db
        .prepare('UPDATE users SET provider = ?, provider_user_id = ? WHERE id = ?')
        .bind('google', profile.provider_user_id, user.id)
        .run()
    }
  }
  
  if (user) {
    
    // 2. 기존 사용자라면 last_login_at 및 프로필 업데이트
    await updateUser(db, user.id, profile)
    
    // 3. 업데이트된 사용자 정보 다시 조회
    user = await getUserById(db, user.id)
    
    if (!user) {
      throw new Error('Failed to retrieve updated user')
    }
    
    return user
  } else {
    
    // 4. 신규 사용자 생성 (onboarded=0)
    return await createUserFromOAuth(db, profile)
  }
}

/**
 * 사용자 조회 또는 생성 (레거시 GoogleProfile 호환)
 */
export async function getOrCreateUser(
  db: D1Database,
  profile: GoogleProfile
): Promise<User> {
  // GoogleProfile을 OAuthProfile로 변환
  const oauthProfile: OAuthProfile = {
    provider: 'google',
    provider_user_id: profile.google_id,
    email: profile.email,
    name: profile.name,
    picture_url: profile.picture_url
  }
  
  return getOrCreateUserFromOAuth(db, oauthProfile)
}

/**
 * 온보딩 완료 처리
 */
export async function completeOnboarding(
  db: D1Database,
  userId: number
): Promise<void> {
  
  const result = await db
    .prepare('UPDATE users SET onboarded = 1, updated_at = ? WHERE id = ?')
    .bind(Math.floor(Date.now() / 1000), userId)
    .run()
  
  if (!result.success) {
    throw new Error('Failed to complete onboarding')
  }
  
}

/**
 * 닉네임 업데이트 (온보딩 시 사용)
 */
export async function updateNickname(
  db: D1Database,
  userId: number,
  nickname: string
): Promise<void> {
  
  const result = await db
    .prepare('UPDATE users SET username = ?, updated_at = ? WHERE id = ?')
    .bind(nickname, Math.floor(Date.now() / 1000), userId)
    .run()
  
  if (!result.success) {
    throw new Error('Failed to update nickname')
  }
  
}

/**
 * 사용자의 역할(role) 업데이트 (관리자 전용)
 */
export async function updateUserRole(
  db: D1Database,
  userId: number,
  role: 'user' | 'expert' | 'admin'
): Promise<void> {
  
  const result = await db
    .prepare('UPDATE users SET role = ?, updated_at = ? WHERE id = ?')
    .bind(role, Math.floor(Date.now() / 1000), userId)
    .run()
  
  if (!result.success) {
    throw new Error('Failed to update user role')
  }
  
}

/**
 * 사용자 편집 횟수 증가
 */
export async function incrementEditCount(
  db: D1Database,
  userId: number
): Promise<void> {
  await db
    .prepare('UPDATE users SET edit_count = edit_count + 1, updated_at = ? WHERE id = ?')
    .bind(Math.floor(Date.now() / 1000), userId)
    .run()
}

/**
 * 사용자 댓글 횟수 증가
 */
export async function incrementCommentCount(
  db: D1Database,
  userId: number
): Promise<void> {
  await db
    .prepare('UPDATE users SET comment_count = comment_count + 1, updated_at = ? WHERE id = ?')
    .bind(Math.floor(Date.now() / 1000), userId)
    .run()
}

/**
 * 사용자 차단
 */
export async function banUser(
  db: D1Database,
  userId: number,
  reason: string,
  bannedUntil: number | null = null
): Promise<void> {
  
  const result = await db
    .prepare(`
      UPDATE users
      SET is_banned = 1, ban_reason = ?, banned_until = ?, updated_at = ?
      WHERE id = ?
    `)
    .bind(reason, bannedUntil, Math.floor(Date.now() / 1000), userId)
    .run()
  
  if (!result.success) {
    throw new Error('Failed to ban user')
  }
  
}

/**
 * 사용자 차단 해제
 */
export async function unbanUser(
  db: D1Database,
  userId: number
): Promise<void> {
  
  const result = await db
    .prepare(`
      UPDATE users
      SET is_banned = 0, ban_reason = NULL, banned_until = NULL, updated_at = ?
      WHERE id = ?
    `)
    .bind(Math.floor(Date.now() / 1000), userId)
    .run()
  
  if (!result.success) {
    throw new Error('Failed to unban user')
  }
  
}

/**
 * 사용자 아이디(username) 업데이트 (레거시 호환)
 */
export async function updateUsername(
  db: D1Database,
  userId: number,
  newUsername: string
): Promise<void> {
  return updateNickname(db, userId, newUsername)
  }
