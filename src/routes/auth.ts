/**
 * Phase 3: 인증 라우트
 * 
 * Google OAuth 2.0 인증 플로우:
 * 1. /auth/google → Google 로그인 페이지로 리다이렉트
 * 2. 사용자가 Google에서 로그인
 * 3. /auth/google/callback → 인증 코드 받아서 토큰 교환
 * 4. 사용자 정보 조회 → D1에 저장
 * 5. 메인 페이지로 리다이렉트
 */

import { Hono } from 'hono'
import { getCookie, setCookie, deleteCookie } from 'hono/cookie'
import type { CloudflareBindings } from '../../worker-configuration'
import { getOrCreateUser, getUserById, getUserByGoogleId } from '../utils/auth-helpers'
import { generateAccessToken, generateRefreshToken, verifyAccessToken } from '../utils/jwt'
import { createSession, destroySession, SESSION_COOKIE_MAX_AGE } from '../utils/session'

const auth = new Hono<{ Bindings: CloudflareBindings }>()

const isHttpsRequest = (req: Request) =>
  req.header('x-forwarded-proto') === 'https' || req.url.startsWith('https://')

/**
 * Google OAuth 로그인 시작
 * GET /auth/google
 */
auth.get('/google', async (c) => {
  const env = c.env
  
  const isHttps = isHttpsRequest(c.req)
  
  // 이미 로그인되어 있는지 체크 (세션 방식)
  const user = c.get('user')
  if (user) {
    const returnUrl = c.req.query('return_url') || '/'
    return c.redirect(returnUrl)
  }
  
  // OAuth State (CSRF 방지)
  const state = crypto.randomUUID()
  
  // State를 임시 쿠키에 저장 (5분 TTL)
  setCookie(c, 'oauth_state', state, {
    httpOnly: true,
    secure: isHttps,
    sameSite: 'Lax',
    maxAge: 300, // 5분
    path: '/'
  })
  
  // Return URL 저장 (로그인 후 돌아갈 페이지)
  const returnUrl = c.req.query('return_url') || '/'
  setCookie(c, 'oauth_return_url', returnUrl, {
    httpOnly: true,
    secure: isHttps,
    sameSite: 'Lax',
    maxAge: 300, // 5분
    path: '/'
  })
  
  // Google OAuth URL 생성
  const authUrl = new URL('https://accounts.google.com/o/oauth2/v2/auth')
  authUrl.searchParams.set('client_id', env.GOOGLE_CLIENT_ID)
  authUrl.searchParams.set('redirect_uri', env.GOOGLE_CALLBACK_URL)
  authUrl.searchParams.set('response_type', 'code')
  authUrl.searchParams.set('scope', 'openid email profile')
  authUrl.searchParams.set('state', state)
  authUrl.searchParams.set('access_type', 'offline')
  authUrl.searchParams.set('prompt', 'select_account') // 매번 계정 선택 표시
  
  
  return c.redirect(authUrl.toString())
})

/**
 * Google OAuth 콜백
 * GET /auth/google/callback
 */
auth.get('/google/callback', async (c) => {
  const env = c.env
  const code = c.req.query('code')
  const state = c.req.query('state')
  const isHttps = isHttpsRequest(c.req)
  
  
  // 1. State 검증 (CSRF 방지)
  const savedState = getCookie(c, 'oauth_state')
  if (!savedState || savedState !== state) {
    return c.html(`
      <html>
        <body>
          <h1>로그인 실패</h1>
          <p>보안 검증에 실패했습니다. 다시 시도해주세요.</p>
          <a href="/login?redirect=${encodeURIComponent(c.req.path + c.req.search || '/')}">다시 로그인</a>
        </body>
      </html>
    `, 400)
  }
  
  // 2. Authorization Code가 없으면 에러
  if (!code) {
    return c.html(`
      <html>
        <body>
          <h1>로그인 실패</h1>
          <p>인증 코드를 받지 못했습니다. 다시 시도해주세요.</p>
          <a href="/login?redirect=${encodeURIComponent(c.req.path + c.req.search || '/')}">다시 로그인</a>
        </body>
      </html>
    `, 400)
  }
  
  try {
    // 3. Authorization Code → Access Token 교환
    const tokenRes = await fetch('https://oauth2.googleapis.com/token', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        code,
        client_id: env.GOOGLE_CLIENT_ID,
        client_secret: env.GOOGLE_CLIENT_SECRET,
        redirect_uri: env.GOOGLE_CALLBACK_URL,
        grant_type: 'authorization_code'
      })
    })
    
    if (!tokenRes.ok) {
      const error = await tokenRes.text()
      throw new Error(`Token exchange failed: ${tokenRes.status}`)
    }
    
    const tokens = await tokenRes.json() as { 
      access_token: string
      id_token: string
      refresh_token?: string
    }
    
    
    // 4. Access Token → 사용자 정보 조회
    const userRes = await fetch('https://www.googleapis.com/oauth2/v2/userinfo', {
      headers: { Authorization: `Bearer ${tokens.access_token}` }
    })
    
    if (!userRes.ok) {
      throw new Error(`User info fetch failed: ${userRes.status}`)
    }
    
    const profile = await userRes.json() as {
      id: string
      email: string
      name?: string
      picture?: string
    }
    
    
    // 5. D1에서 사용자 조회/생성
    const user = await getOrCreateUser(env.DB, {
      google_id: profile.id,
      email: profile.email,
      name: profile.name || null,
      picture_url: profile.picture || null
    })
    
    
    // 6. 세션 토큰 생성 (KV 저장)
    const sessionToken = await createSession(env.KV, env.DB, user.id, {
      ip: c.req.header('cf-connecting-ip') || 'unknown',
      userAgent: c.req.header('user-agent') || 'unknown',
      provider: 'google',
    })

    // 7. HttpOnly Cookie 설정 (세션 토큰 1개만)
    setCookie(c, 'session_token', sessionToken, {
      httpOnly: true,
      secure: isHttps,
      sameSite: 'Lax',
      maxAge: SESSION_COOKIE_MAX_AGE,
      path: '/',
    })

    // 기존 JWT 쿠키가 남아있으면 정리
    deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
    deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })

    
    // 9. Return URL 처리
    const returnUrl = getCookie(c, 'oauth_return_url') || '/'
    
    // OAuth 쿠키 삭제
    deleteCookie(c, 'oauth_state')
    deleteCookie(c, 'oauth_return_url')
    
    // 10. 온보딩 체크 - 신규 사용자는 온보딩 페이지로
    if (user.onboarded === 0) {
      // 원래 가려던 URL을 쿠키에 저장 (온보딩 완료 후 사용)
      setCookie(c, 'onboarding_return_url', returnUrl, {
        httpOnly: true,
        secure: true,
        sameSite: 'Lax',
        maxAge: 43200, // 12시간
        path: '/'
      })
      return c.redirect('/onboarding')
    }
    
    // 기존 사용자는 원래 페이지로 리다이렉트
    return c.redirect(returnUrl)
    
  } catch (error) {
    
    return c.html(`
      <html>
        <body>
          <h1>로그인 실패</h1>
          <p>Google 로그인 중 오류가 발생했습니다.</p>
          <p style="color: #ef4444; font-family: monospace;">${error instanceof Error ? error.message : '알 수 없는 오류'}</p>
          <a href="/login?redirect=${encodeURIComponent(c.req.path + c.req.search || '/')}">다시 로그인</a>
        </body>
      </html>
    `, 500)
  }
})

/**
 * 로그아웃
 * POST /auth/logout
 */
auth.post('/logout', async (c) => {
  const sessionToken = getCookie(c, 'session_token')
  const refreshToken = getCookie(c, 'refresh_token')
  const isHttps = isHttpsRequest(c.req)


  // 세션 삭제 (새 방식)
  if (sessionToken && c.env.KV) {
    try {
      await destroySession(c.env.KV, c.env.DB, sessionToken, 'user_logout')
    } catch (error) {
    }
  }

  // 레거시 Refresh Token 정리
  if (refreshToken && c.env.KV) {
    try {
      await c.env.KV.delete(`refresh:${refreshToken}`)
    } catch {}
  }

  // 모든 쿠키 삭제
  deleteCookie(c, 'session_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
  deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
  deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })


  const body = await c.req.parseBody()
  const returnUrl = (body.return_url as string) || c.req.query('return_url') || '/'
  const safeUrl = returnUrl.startsWith('/') ? returnUrl : '/'

  return c.redirect(safeUrl)
})

/**
 * 로그아웃 (GET 방식도 지원)
 * GET /auth/logout
 */
auth.get('/logout', async (c) => {
  const sessionToken = getCookie(c, 'session_token')
  const refreshToken = getCookie(c, 'refresh_token')
  const isHttps = isHttpsRequest(c.req)


  if (sessionToken && c.env.KV) {
    try {
      await destroySession(c.env.KV, c.env.DB, sessionToken, 'user_logout')
    } catch {}
  }

  if (refreshToken && c.env.KV) {
    try {
      await c.env.KV.delete(`refresh:${refreshToken}`)
    } catch {}
  }

  deleteCookie(c, 'session_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
  deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
  deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })


  const returnUrl = c.req.query('return_url') || '/'
  const safeUrl = returnUrl.startsWith('/') ? returnUrl : '/'

  return c.redirect(safeUrl)
})

/**
 * 토큰 갱신 (레거시 — 세션 방식에서는 sliding window로 대체됨)
 * POST /auth/refresh
 */
auth.post('/refresh', async (c) => {
  // 세션 토큰이 이미 있으면 갱신 불필요
  const sessionToken = getCookie(c, 'session_token')
  if (sessionToken) {
    return c.json({ success: true, message: 'Session active, no refresh needed' })
  }

  const refreshToken = getCookie(c, 'refresh_token')

  if (!refreshToken || !c.env.KV) {
    return c.json({ error: 'No refresh token' }, 401)
  }

  try {
    const data = await c.env.KV.get(`refresh:${refreshToken}`)
    if (!data) {
      deleteCookie(c, 'access_token')
      deleteCookie(c, 'refresh_token')
      return c.json({ error: 'Invalid refresh token' }, 401)
    }

    const parsed = JSON.parse(data) as { userId: number; createdAt: number }
    const user = await getUserById(c.env.DB, parsed.userId)

    if (!user || user.is_banned === 1) {
      await c.env.KV.delete(`refresh:${refreshToken}`)
      deleteCookie(c, 'access_token')
      deleteCookie(c, 'refresh_token')
      return c.json({ error: user ? 'User is banned' : 'User not found' }, user ? 403 : 404)
    }

    // 레거시 유저를 세션으로 마이그레이션
    const isHttps = isHttpsRequest(c.req)
    const newSessionToken = await createSession(c.env.KV, c.env.DB, user.id, {
      ip: c.req.header('cf-connecting-ip') || 'unknown',
      userAgent: c.req.header('user-agent') || 'unknown',
      provider: (user.provider as any) || 'google',
    })

    setCookie(c, 'session_token', newSessionToken, {
      httpOnly: true,
      secure: isHttps,
      sameSite: 'Lax',
      maxAge: SESSION_COOKIE_MAX_AGE,
      path: '/',
    })

    // 레거시 토큰 정리
    await c.env.KV.delete(`refresh:${refreshToken}`)
    deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
    deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })

    return c.json({ success: true, message: 'Migrated to session' })
  } catch (error) {
    return c.json({ error: 'Token refresh failed' }, 500)
  }
})

/**
 * 테스트 계정 로그인 (해커톤 데모용)
 * POST /auth/test-login
 */
auth.post('/test-login', async (c) => {
  try {
    const body = await c.req.parseBody()
    const id = (body.id as string)?.trim()
    const pw = body.pw as string
    const redirect = (body.redirect as string) || '/'
    const safeRedirect = redirect.startsWith('/') ? redirect : '/'

    // 자격증명 검증
    if (id !== 'test' || pw !== '1234') {
      return c.redirect(`/login?error=1&redirect=${encodeURIComponent(safeRedirect)}`)
    }

    const now = Math.floor(Date.now() / 1000)
    const isHttps = isHttpsRequest(c.req)

    // 테스트 유저 조회
    let user = await getUserByGoogleId(c.env.DB, 'test-account')

    if (!user) {
      // 테스트 유저 생성 (onboarded=1로 온보딩 스킵)
      await c.env.DB.prepare(`
        INSERT INTO users (
          google_id, provider, provider_user_id,
          email, name, picture_url, username, role,
          edit_count, comment_count, is_banned,
          onboarded, last_login_at, created_at, updated_at
        ) VALUES ('test-account', 'google', 'test-account',
          'test@careerwiki.org', '테스트 사용자', '/images/test-avatar.svg', 'test_user', 'user',
          0, 0, 0, 1, ?, ?, ?)
      `).bind(now, now, now).run()

      user = await getUserByGoogleId(c.env.DB, 'test-account')
    }

    if (!user) {
      return c.redirect(`/login?error=2&redirect=${encodeURIComponent(safeRedirect)}`)
    }

    // last_login_at 갱신 + 프로필 이미지 보정
    await c.env.DB.prepare('UPDATE users SET last_login_at = ?, picture_url = COALESCE(picture_url, ?) WHERE id = ?')
      .bind(now, '/images/test-avatar.svg', user.id).run()

    // 세션 생성
    const token = await createSession(c.env.KV, c.env.DB, user.id, {
      ip: c.req.header('cf-connecting-ip') || 'unknown',
      userAgent: c.req.header('user-agent') || 'unknown',
      provider: 'google' as const,
    })

    setCookie(c, 'session_token', token, {
      httpOnly: true,
      secure: isHttps,
      sameSite: 'Lax',
      maxAge: SESSION_COOKIE_MAX_AGE,
      path: '/',
    })

    return c.redirect(safeRedirect)
  } catch (error) {
    const redirect = (await c.req.parseBody().catch(() => ({}))).redirect as string || '/'
    return c.redirect(`/login?error=2&redirect=${encodeURIComponent(redirect)}`)
  }
})

export default auth

