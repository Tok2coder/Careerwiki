/**
 * Google Indexing API 유틸리티
 * 편집 저장 후 자동으로 Google에 URL 업데이트 알림을 보냄
 */

async function createGoogleJWT(email: string, privateKeyPem: string, scope: string): Promise<string> {
  const header = { alg: 'RS256', typ: 'JWT' }
  const now = Math.floor(Date.now() / 1000)
  const payload = {
    iss: email,
    scope,
    aud: 'https://oauth2.googleapis.com/token',
    iat: now,
    exp: now + 3600,
  }

  const enc = (obj: any) => btoa(JSON.stringify(obj)).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '')
  const headerB64 = enc(header)
  const payloadB64 = enc(payload)
  const signingInput = `${headerB64}.${payloadB64}`

  const pemBody = privateKeyPem
    .replace(/-----BEGIN (?:RSA )?PRIVATE KEY-----/g, '')
    .replace(/-----END (?:RSA )?PRIVATE KEY-----/g, '')
    .replace(/\\n/g, '')
    .replace(/\s/g, '')
  const binaryDer = Uint8Array.from(atob(pemBody), c => c.charCodeAt(0))
  const cryptoKey = await crypto.subtle.importKey(
    'pkcs8', binaryDer.buffer,
    { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
    false, ['sign']
  )

  const signature = await crypto.subtle.sign(
    'RSASSA-PKCS1-v1_5',
    cryptoKey,
    new TextEncoder().encode(signingInput)
  )
  const sigB64 = btoa(String.fromCharCode(...new Uint8Array(signature)))
    .replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '')

  return `${signingInput}.${sigB64}`
}

export async function getGoogleAccessToken(email: string, privateKey: string, scope: string): Promise<string> {
  const jwt = await createGoogleJWT(email, privateKey, scope)
  const resp = await fetch('https://oauth2.googleapis.com/token', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: `grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=${jwt}`,
  })
  const data = await resp.json() as any
  if (!data.access_token) throw new Error(`Google OAuth failed: ${JSON.stringify(data)}`)
  return data.access_token
}

/**
 * Google Indexing API에 URL 업데이트 알림 (fire-and-forget)
 * 실패해도 편집 저장에 영향 없음
 */
export async function notifyGoogleIndexing(
  env: { GOOGLE_SERVICE_ACCOUNT_EMAIL?: string; GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY?: string },
  url: string
): Promise<void> {
  try {
    const email = env.GOOGLE_SERVICE_ACCOUNT_EMAIL
    const privateKey = env.GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY
    if (!email || !privateKey) return // 크레덴셜 없으면 무시

    const accessToken = await getGoogleAccessToken(email, privateKey, 'https://www.googleapis.com/auth/indexing')
    await fetch('https://indexing.googleapis.com/v3/urlNotifications:publish', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${accessToken}`,
      },
      body: JSON.stringify({ url, type: 'URL_UPDATED' }),
    })
  } catch {
    // 실패해도 무시 — 편집 저장이 더 중요
  }
}
