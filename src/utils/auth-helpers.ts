/**
 * Phase 3: 인증 헬퍼 함수
 * 
 * D1 데이터베이스와 상호작용하는 인증 관련 유틸리티
 */

import type { D1Database } from '@cloudflare/workers-types'

/**
 * 사용자 타입 (D1 users 테이블)
 */
export interface User {
  id: number
  google_id: string
  email: string
  name: string | null
  picture_url: string | null
  username: string | null  // Phase 3 Day 4: 사용자 아이디
  role: 'user' | 'expert' | 'admin'
  edit_count: number
  comment_count: number
  is_banned: number // SQLite BOOLEAN (0 or 1)
  ban_reason: string | null
  banned_until: number | null
  last_login_at: number | null
  created_at: number | null
  updated_at: number | null
}

/**
 * Google 프로필 정보
 */
export interface GoogleProfile {
  google_id: string
  email: string
  name: string | null
  picture_url: string | null
}

/**
 * D1에서 Google ID로 사용자 조회
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
 * Phase 3 Day 4: 고유한 사용자 아이디 생성
 * 형식: user_XXXXXX (6자리 랜덤 문자열)
 */
async function generateUniqueUsername(db: D1Database): Promise<string> {
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
    
    console.log(`⚠️ [Auth] Username ${username} already exists, retrying...`)
  }
  
  // 최대 시도 횟수 초과 시 타임스탬프 기반 생성
  const timestamp = Date.now().toString(36)
  return `user_${timestamp}`
}

/**
 * D1에 새 사용자 생성
 */
export async function createUser(
  db: D1Database,
  profile: GoogleProfile
): Promise<User> {
  const now = Math.floor(Date.now() / 1000) // UNIX timestamp
  
  console.log('📝 [Auth] Creating new user in D1...')
  console.log('   Google ID:', profile.google_id)
  console.log('   Email:', profile.email)
  console.log('   Name:', profile.name)
  
  // Phase 3 Day 4: 사용자 아이디 생성 (회원가입 절차)
  const username = await generateUniqueUsername(db)
  console.log('   Generated Username:', username)
  
  const result = await db
    .prepare(`
      INSERT INTO users (
        google_id, email, name, picture_url, username, role,
        edit_count, comment_count,
        is_banned, last_login_at, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, 'user', 0, 0, 0, ?, ?, ?)
    `)
    .bind(
      profile.google_id,
      profile.email,
      profile.name,
      profile.picture_url,
      username,
      now, // last_login_at
      now, // created_at
      now  // updated_at
    )
    .run()
  
  if (!result.success) {
    console.error('❌ [Auth] Failed to create user:', result.error)
    throw new Error('Failed to create user in database')
  }
  
  console.log('✅ [Auth] User created, ID:', result.meta.last_row_id)
  console.log('   Username:', username)
  
  // 생성된 사용자 조회
  const user = await getUserById(db, result.meta.last_row_id as number)
  
  if (!user) {
    throw new Error('Failed to retrieve created user')
  }
  
  return user
}

/**
 * D1에서 사용자 정보 업데이트 (last_login_at, 프로필 동기화)
 */
export async function updateUser(
  db: D1Database,
  userId: number,
  profile: Partial<GoogleProfile>
): Promise<void> {
  const now = Math.floor(Date.now() / 1000)
  
  console.log('📝 [Auth] Updating user in D1...')
  console.log('   User ID:', userId)
  
  // 업데이트할 필드만 포함
  const updates: string[] = ['last_login_at = ?', 'updated_at = ?']
  const bindings: any[] = [now, now]
  
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
    console.error('❌ [Auth] Failed to update user:', result.error)
    throw new Error('Failed to update user in database')
  }
  
  console.log('✅ [Auth] User updated')
}

/**
 * 사용자 조회 또는 생성 (OAuth 로그인 시 사용)
 * 
 * 1. Google ID로 사용자 조회
 * 2. 없으면 신규 생성
 * 3. 있으면 last_login_at 및 프로필 업데이트
 */
export async function getOrCreateUser(
  db: D1Database,
  profile: GoogleProfile
): Promise<User> {
  console.log('🔍 [Auth] Looking up user by Google ID:', profile.google_id)
  
  // 1. 기존 사용자 조회
  let user = await getUserByGoogleId(db, profile.google_id)
  
  if (user) {
    console.log('✅ [Auth] Existing user found, ID:', user.id)
    
    // 2. 기존 사용자라면 last_login_at 및 프로필 업데이트
    await updateUser(db, user.id, profile)
    
    // 3. 업데이트된 사용자 정보 다시 조회
    user = await getUserById(db, user.id)
    
    if (!user) {
      throw new Error('Failed to retrieve updated user')
    }
    
    return user
  } else {
    console.log('🆕 [Auth] New user, creating...')
    
    // 4. 신규 사용자 생성
    return await createUser(db, profile)
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
  console.log('📝 [Auth] Updating user role...')
  console.log('   User ID:', userId)
  console.log('   New Role:', role)
  
  const result = await db
    .prepare('UPDATE users SET role = ?, updated_at = ? WHERE id = ?')
    .bind(role, Math.floor(Date.now() / 1000), userId)
    .run()
  
  if (!result.success) {
    console.error('❌ [Auth] Failed to update user role:', result.error)
    throw new Error('Failed to update user role')
  }
  
  console.log('✅ [Auth] User role updated')
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
  console.log('🚫 [Auth] Banning user...')
  console.log('   User ID:', userId)
  console.log('   Reason:', reason)
  console.log('   Until:', bannedUntil ? new Date(bannedUntil * 1000).toISOString() : 'Permanent')
  
  const result = await db
    .prepare(`
      UPDATE users
      SET is_banned = 1, ban_reason = ?, banned_until = ?, updated_at = ?
      WHERE id = ?
    `)
    .bind(reason, bannedUntil, Math.floor(Date.now() / 1000), userId)
    .run()
  
  if (!result.success) {
    console.error('❌ [Auth] Failed to ban user:', result.error)
    throw new Error('Failed to ban user')
  }
  
  console.log('✅ [Auth] User banned')
}

/**
 * 사용자 차단 해제
 */
export async function unbanUser(
  db: D1Database,
  userId: number
): Promise<void> {
  console.log('✅ [Auth] Unbanning user...')
  console.log('   User ID:', userId)
  
  const result = await db
    .prepare(`
      UPDATE users
      SET is_banned = 0, ban_reason = NULL, banned_until = NULL, updated_at = ?
      WHERE id = ?
    `)
    .bind(Math.floor(Date.now() / 1000), userId)
    .run()
  
  if (!result.success) {
    console.error('❌ [Auth] Failed to unban user:', result.error)
    throw new Error('Failed to unban user')
  }
  
  console.log('✅ [Auth] User unbanned')
}

/**
 * Phase 3 Day 4: 사용자 아이디(username) 업데이트
 */
export async function updateUsername(
  db: D1Database,
  userId: number,
  newUsername: string
): Promise<void> {
  console.log('📝 [Auth] Updating username...')
  console.log('   User ID:', userId)
  console.log('   New Username:', newUsername)
  
  // 유효성 검사
  if (!newUsername || newUsername.length < 3 || newUsername.length > 20) {
    throw new Error('Username must be between 3 and 20 characters')
  }
  
  // 영문, 숫자, 언더스코어만 허용
  if (!/^[a-z0-9_]+$/.test(newUsername)) {
    throw new Error('Username can only contain lowercase letters, numbers, and underscores')
  }
  
  // 중복 체크
  const existing = await db
    .prepare('SELECT id FROM users WHERE username = ? AND id != ?')
    .bind(newUsername, userId)
    .first()
  
  if (existing) {
    throw new Error('Username already taken')
  }
  
  const result = await db
    .prepare('UPDATE users SET username = ?, updated_at = ? WHERE id = ?')
    .bind(newUsername, Math.floor(Date.now() / 1000), userId)
    .run()
  
  if (!result.success) {
    console.error('❌ [Auth] Failed to update username:', result.error)
    throw new Error('Failed to update username')
  }
  
  console.log('✅ [Auth] Username updated')
}

