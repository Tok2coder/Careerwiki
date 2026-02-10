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
import { getOrCreateUser, getUserById } from '../utils/auth-helpers'
import { generateAccessToken, generateRefreshToken, verifyAccessToken } from '../utils/jwt'

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
  
  // 이미 로그인되어 있는지 체크
  const accessToken = getCookie(c, 'access_token')
  if (accessToken) {
    const payload = await verifyAccessToken(accessToken, env.JWT_SECRET)
    if (payload) {
      // DB에 사용자 존재 여부까지 확인 (없으면 쿠키 정리 후 재로그인 진행)
      const user = await getUserById(env.DB, payload.userId)
      if (user) {
      console.log('ℹ️ [OAuth] User already logged in, redirecting to home')
      console.log('   User ID:', payload.userId)
      const returnUrl = c.req.query('return_url') || '/'
      return c.redirect(returnUrl)
      } else {
        console.log('⚠️ [OAuth] Token valid but user not found, clearing cookies')
        deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
        deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
      }
    } else {
      // 토큰 검증 실패 시도 역시 쿠키 정리
      deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
      deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
    }
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
  
  console.log('🔐 [OAuth] Starting Google OAuth flow')
  console.log('   Client ID:', env.GOOGLE_CLIENT_ID?.substring(0, 20) + '...')
  console.log('   Redirect URI:', env.GOOGLE_CALLBACK_URL)
  console.log('   State:', state)
  
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
  
  console.log('🔐 [OAuth] Callback received')
  console.log('   Code:', code?.substring(0, 20) + '...')
  console.log('   State:', state)
  
  // 1. State 검증 (CSRF 방지)
  const savedState = getCookie(c, 'oauth_state')
  if (!savedState || savedState !== state) {
    console.error('❌ [OAuth] State mismatch:', { savedState, receivedState: state })
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
    console.error('❌ [OAuth] No authorization code received')
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
    console.log('🔐 [OAuth] Exchanging code for token...')
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
      console.error('❌ [OAuth] Token exchange failed:', error)
      throw new Error(`Token exchange failed: ${tokenRes.status}`)
    }
    
    const tokens = await tokenRes.json() as { 
      access_token: string
      id_token: string
      refresh_token?: string
    }
    
    console.log('✅ [OAuth] Token received')
    
    // 4. Access Token → 사용자 정보 조회
    console.log('🔐 [OAuth] Fetching user info...')
    const userRes = await fetch('https://www.googleapis.com/oauth2/v2/userinfo', {
      headers: { Authorization: `Bearer ${tokens.access_token}` }
    })
    
    if (!userRes.ok) {
      console.error('❌ [OAuth] User info fetch failed:', userRes.status)
      throw new Error(`User info fetch failed: ${userRes.status}`)
    }
    
    const profile = await userRes.json() as {
      id: string
      email: string
      name?: string
      picture?: string
    }
    
    console.log('✅ [OAuth] User info received')
    console.log('   Google ID:', profile.id)
    console.log('   Email:', profile.email)
    console.log('   Name:', profile.name)
    
    // 5. D1에서 사용자 조회/생성
    console.log('🔐 [OAuth] Creating or updating user in D1...')
    const user = await getOrCreateUser(env.DB, {
      google_id: profile.id,
      email: profile.email,
      name: profile.name || null,
      picture_url: profile.picture || null
    })
    
    console.log('✅ [OAuth] User created/updated in D1')
    console.log('   User ID:', user.id)
    console.log('   Role:', user.role)
    
    // 6. JWT Access Token 생성
    const accessToken = await generateAccessToken(
      {
        userId: user.id,
        role: user.role,
        email: user.email
      },
      env.JWT_SECRET
    )
    
    // 7. Refresh Token 생성 (Day 2에서는 KV 없이)
    const refreshToken = await generateRefreshToken(user.id, env.KV)
    
    // 8. HttpOnly Cookie 설정
    setCookie(c, 'access_token', accessToken, {
      httpOnly: true,
      secure: isHttps, // HTTPS에서만 전송 (로컬/프리뷰에서는 false)
      sameSite: 'Lax',
      maxAge: 43200, // 12시간 (초 단위)
      path: '/'
    })
    
    setCookie(c, 'refresh_token', refreshToken, {
      httpOnly: true,
      secure: isHttps,
      sameSite: 'Lax',
      maxAge: 604800, // 7일 (초 단위)
      path: '/'
    })
    
    console.log('🎉 [OAuth] Login successful!')
    console.log('   Access Token set (1 hour)')
    console.log('   Refresh Token set (7 days)')
    console.log('   Onboarded:', user.onboarded === 1)
    
    // 9. Return URL 처리
    const returnUrl = getCookie(c, 'oauth_return_url') || '/'
    
    // OAuth 쿠키 삭제
    deleteCookie(c, 'oauth_state')
    deleteCookie(c, 'oauth_return_url')
    
    // 10. 온보딩 체크 - 신규 사용자는 온보딩 페이지로
    if (user.onboarded === 0) {
      console.log('🆕 [OAuth] New user, redirecting to onboarding...')
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
    console.error('❌ [OAuth] Error:', error)
    
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
  const refreshToken = getCookie(c, 'refresh_token')
  const isHttps = isHttpsRequest(c.req)
  
  console.log('🚪 [Auth] Logout requested')
  
  // KV에서 Refresh Token 삭제 (있는 경우)
  if (refreshToken && c.env.KV) {
    try {
      await c.env.KV.delete(`refresh:${refreshToken}`)
      console.log('✅ [Auth] Refresh Token deleted from KV')
    } catch (error) {
      console.error('❌ [Auth] Failed to delete refresh token:', error)
    }
  }
  
  // Cookie 삭제
  deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
  deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
  
  console.log('✅ [Auth] Cookies cleared')
  console.log('🎉 [Auth] Logout successful')
  
  // POST body에서 return_url 가져오기, 없으면 쿼리 파라미터, 없으면 메인 페이지
  const body = await c.req.parseBody()
  const returnUrl = (body.return_url as string) || c.req.query('return_url') || '/'
  
  // 보안: 같은 도메인 내의 경로만 허용 (외부 URL 리다이렉트 방지)
  const safeUrl = returnUrl.startsWith('/') ? returnUrl : '/'
  
  return c.redirect(safeUrl)
})

/**
 * 로그아웃 (GET 방식도 지원)
 * GET /auth/logout
 */
auth.get('/logout', async (c) => {
  // POST와 동일한 로직
  const refreshToken = getCookie(c, 'refresh_token')
  const isHttps = isHttpsRequest(c.req)
  
  console.log('🚪 [Auth] Logout requested (GET)')
  
  if (refreshToken && c.env.KV) {
    try {
      await c.env.KV.delete(`refresh:${refreshToken}`)
      console.log('✅ [Auth] Refresh Token deleted from KV')
    } catch (error) {
      console.error('❌ [Auth] Failed to delete refresh token:', error)
    }
  }
  
  deleteCookie(c, 'access_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
  deleteCookie(c, 'refresh_token', { path: '/', secure: isHttps, sameSite: 'Lax' })
  
  console.log('✅ [Auth] Cookies cleared')
  console.log('🎉 [Auth] Logout successful')
  
  // 쿼리 파라미터에서 return_url 가져오기, 없으면 메인 페이지
  const returnUrl = c.req.query('return_url') || '/'
  
  // 보안: 같은 도메인 내의 경로만 허용 (외부 URL 리다이렉트 방지)
  const safeUrl = returnUrl.startsWith('/') ? returnUrl : '/'
  
  return c.redirect(safeUrl)
})

/**
 * 토큰 갱신
 * POST /auth/refresh
 */
auth.post('/refresh', async (c) => {
  const refreshToken = getCookie(c, 'refresh_token')
  
  console.log('🔄 [Auth] Token refresh requested')
  
  if (!refreshToken) {
    console.log('❌ [Auth] No refresh token provided')
    return c.json({ error: 'No refresh token' }, 401)
  }
  
  // KV가 설정되어 있지 않으면 에러
  if (!c.env.KV) {
    console.log('❌ [Auth] KV not configured')
    return c.json({ error: 'Refresh token storage not configured' }, 500)
  }
  
  try {
    // KV에서 Refresh Token 조회
    const data = await c.env.KV.get(`refresh:${refreshToken}`)
    
    if (!data) {
      console.log('❌ [Auth] Invalid refresh token')
      
      // 유효하지 않은 Refresh Token이면 쿠키 삭제
      deleteCookie(c, 'access_token')
      deleteCookie(c, 'refresh_token')
      
      return c.json({ error: 'Invalid refresh token' }, 401)
    }
    
    const parsed = JSON.parse(data) as { userId: number; createdAt: number }
    
    console.log('✅ [Auth] Refresh Token valid')
    console.log('   User ID:', parsed.userId)
    
    // D1에서 사용자 정보 조회
    const user = await getUserById(c.env.DB, parsed.userId)
    
    if (!user) {
      console.log('❌ [Auth] User not found')
      
      // 사용자가 없으면 Refresh Token 삭제
      await c.env.KV.delete(`refresh:${refreshToken}`)
      deleteCookie(c, 'access_token')
      deleteCookie(c, 'refresh_token')
      
      return c.json({ error: 'User not found' }, 404)
    }
    
    // 사용자 차단 확인
    if (user.is_banned === 1) {
      console.log('❌ [Auth] User is banned')
      
      // 차단된 사용자면 Refresh Token 삭제
      await c.env.KV.delete(`refresh:${refreshToken}`)
      deleteCookie(c, 'access_token')
      deleteCookie(c, 'refresh_token')
      
      return c.json({ error: 'User is banned' }, 403)
    }
    
    // 새 Access Token 발급
    const accessToken = await generateAccessToken(
      {
        userId: user.id,
        role: user.role,
        email: user.email
      },
      c.env.JWT_SECRET
    )
    
    // Cookie 업데이트
    setCookie(c, 'access_token', accessToken, {
      httpOnly: true,
      secure: true,
      sameSite: 'Lax',
      maxAge: 43200, // 12시간
      path: '/'
    })
    
    console.log('✅ [Auth] New Access Token issued')
    console.log('   User ID:', user.id)
    console.log('   Role:', user.role)
    
    return c.json({ success: true, message: 'Token refreshed' })
    
  } catch (error) {
    console.error('❌ [Auth] Token refresh failed:', error)
    return c.json({ error: 'Token refresh failed' }, 500)
  }
})

export default auth

