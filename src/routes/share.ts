/**
 * 공유 미니카드 페이지 (공개, 로그인 불필요)
 *
 * Phase 1-1: index.tsx에서 추출
 * - GET /share/:token — 공유 카드 페이지
 * - GET /share/:token/og.png — OG 이미지 생성
 */

import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { svgToPng, getCachedOgImage, cacheOgImage } from '../services/ogImageService'

const shareRoutes = new Hono<AppEnv>()

const BOT_UA_PATTERN = /bot|crawl|spider|slack|facebook|twitter|kakao|discord|preview|whatsapp|telegram|line|naver/i

shareRoutes.get('/share/:token', async (c) => {
  const db = c.env.DB
  const token = c.req.param('token')

  if (!token || token.length < 8 || token.length > 32) {
    return c.html(renderShareGonePage(), 410, {
      'X-Robots-Tag': 'noindex, nofollow',
    })
  }

  try {
    const row = await db.prepare(`
      SELECT share_token, share_data_json, share_version, is_revoked, expires_at
      FROM share_tokens WHERE share_token = ?
    `).bind(token).first<{
      share_token: string
      share_data_json: string
      share_version: number
      is_revoked: number
      expires_at: string | null
    }>()

    if (!row) {
      return c.html(renderShareGonePage(), 410, {
        'X-Robots-Tag': 'noindex, nofollow',
      })
    }

    // revoked / expired 확인
    const isExpired = !row.expires_at || new Date(row.expires_at) < new Date()
    if (row.is_revoked || isExpired) {
      return c.html(renderShareGonePage(), 410, {
        'X-Robots-Tag': 'noindex, nofollow',
      })
    }

    // 봇이 아니면 view_count 증가 (atomic)
    const ua = c.req.header('user-agent') || ''
    if (!BOT_UA_PATTERN.test(ua)) {
      c.executionCtx.waitUntil(
        db.prepare(`
          UPDATE share_tokens SET view_count = view_count + 1, last_viewed_at = CURRENT_TIMESTAMP
          WHERE share_token = ?
        `).bind(token).run()
      )
    }

    // share_data_json 파싱 + 렌더
    const data = JSON.parse(row.share_data_json) as {
      v: number
      type?: 'job' | 'major'
      jobs: Array<{ name: string; fit: number; slug: string; image_url?: string }>
      vision: string
      meta: {
        strengths: string[]
        values: string[]
        cautions: string[]
        likes: string[]
        avoid: string[]
      }
      createdAt: string
    }

    // 이미지 없는 항목이 있으면 DB에서 slug로 조회하여 보강
    const itemsMissingImage = data.jobs.filter((j: any) => !j.image_url && j.slug)
    if (itemsMissingImage.length > 0) {
      const slugs = itemsMissingImage.map((j: any) => j.slug)
      const placeholders = slugs.map(() => '?').join(',')
      const table = data.type === 'major' ? 'majors' : 'jobs'
      const rows = await db.prepare(
        `SELECT slug, image_url FROM ${table} WHERE slug IN (${placeholders}) AND image_url IS NOT NULL`
      ).bind(...slugs).all<{ slug: string; image_url: string }>()
      if (rows.results) {
        const imageMap = new Map(rows.results.map(r => [r.slug, r.image_url]))
        for (const job of data.jobs) {
          if (!job.image_url && job.slug && imageMap.has(job.slug)) {
            job.image_url = imageMap.get(job.slug)
          }
        }
      }
    }

    const html = renderShareCard(data, token)
    return c.html(html, 200, {
      'X-Robots-Tag': 'noindex, nofollow',
      'Cache-Control': 'public, max-age=300',
    })

  } catch (error) {
    return c.html(renderShareGonePage(), 500, {
      'X-Robots-Tag': 'noindex, nofollow',
    })
  }
})

// 미니카드 HTML 렌더링
// 서버사이드 태그 번역 맵 (클라이언트 translateToKorean 라벨과 동기화)
const SHARE_TAG_LABELS: Record<string, string> = {
  // 강점
  analytical: '분석력', creative: '창의력', communication: '소통력',
  structured_execution: '실행력', persistence: '끈기', fast_learning: '학습력',
  leadership: '리더십', detail_oriented: '꼼꼼함', patience: '인내심',
  empathy: '공감 능력', organization: '체계적 정리', adaptability: '적응력',
  perseverance: '끈기', creativity: '창의성', strategic: '전략적 사고',
  teamwork: '팀워크', independence: '독립적 업무',
  // 가치
  recognition: '인정/영향력', stability: '안정성', income: '높은 수입',
  growth: '성장', autonomy: '자율성', meaning: '의미/사회 기여',
  wlb: '워라밸', balance: '워라밸', expertise: '전문성',
  // 관심
  problem_solving: '문제 해결', data_numbers: '데이터/숫자', tech: '기술/IT',
  people: '사람/소통', helping: '돌봄/봉사', business: '비즈니스',
  nature: '자연/환경', physical: '신체 활동', research: '연구/탐구',
  teaching: '교육/가르침', analysis: '분석', design: '디자인',
  writing: '글쓰기', hands_on: '손으로 만들기', helping_teaching: '교육/돌봄',
  // 주의 (스트레스 트리거)
  people_drain: '대인 스트레스', cognitive_drain: '인지 피로',
  time_pressure_drain: '시간 압박', responsibility_drain: '책임 스트레스',
  repetition_drain: '반복 피로', unpredictability_drain: '불확실성 스트레스',
  // 제약/회피
  time_constraint: '시간 제약', income_constraint: '수입 조건',
  location_constraint: '위치 제약', physical_constraint: '체력 제약',
  no_travel: '출장 불가', no_overtime: '야근 불가', remote_preferred: '재택 선호',
  prefer_remote: '재택 선호', no_shift: '교대근무 불가',
}

function translateTag(tag: string): string {
  if (!tag) return tag
  // 정확 일치
  if (SHARE_TAG_LABELS[tag]) return SHARE_TAG_LABELS[tag]
  // 이미 한국어면 그대로
  if (/[가-힣]/.test(tag)) return tag
  // 언더스코어를 공백으로 바꿔서 재시도
  const normalized = tag.replace(/_/g, ' ')
  return SHARE_TAG_LABELS[normalized] || tag
}

function renderShareCard(data: any, token: string): string {
  const jobs = data.jobs || []
  const meta = data.meta || {}
  const vision = data.vision || ''
  const isMajor = data.type === 'major'

  const pageTitle = isMajor ? '전공 적성 분석' : '커리어 분석'
  const ogTitle = isMajor ? 'AI 전공 적성 분석 — 커리어위키' : 'AI 커리어 분석 — 커리어위키'
  const itemLabel = isMajor ? '추천 전공' : '추천 직업'
  const ctaText = isMajor ? '전공 추천 받기' : '직업 추천 받기'
  const ctaHref = isMajor
    ? '/analyzer/major?utm_source=share&utm_medium=og&utm_campaign=ai_report'
    : '/analyzer?utm_source=share&utm_medium=og&utm_campaign=ai_report'
  const fallbackIcon = isMajor ? 'fa-graduation-cap' : 'fa-briefcase'

  const ogDesc = jobs.length > 0
    ? `Top 추천: ${jobs.slice(0, 2).map((j: any) => `${j.name}(${j.fit}점)`).join(' · ')} 나도 무료로 해보기 →`
    : `AI가 분석한 나의 ${isMajor ? '전공 적성' : '커리어'} — 나도 무료로 해보기 →`

  // 순위별 배지 색상 (OG 이미지와 동일)
  const badgeColors = ['#fbbf24', '#94a3b8', '#cd7f32', '#6366f1', '#6366f1']
  const badgeBgs = ['rgba(251,191,36,0.15)', 'rgba(148,163,184,0.15)', 'rgba(205,127,50,0.15)', 'rgba(99,102,241,0.12)', 'rgba(99,102,241,0.12)']

  const jobsHtml = jobs.map((j: any, i: number) => {
    const fitColor = j.fit >= 85 ? '#818cf8' : j.fit >= 70 ? '#60a5fa' : '#9ca3af'
    const rankBadge = `<div style="width:22px;height:22px;border-radius:50%;background:${badgeColors[i]};display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:800;color:#1e1b4b;flex-shrink:0;">${i + 1}</div>`
    const imageHtml = j.image_url
      ? `<img src="${j.image_url}" alt="${j.name}" style="width:44px;height:44px;border-radius:10px;object-fit:cover;flex-shrink:0;">`
      : `<div style="width:44px;height:44px;border-radius:10px;background:linear-gradient(135deg,${badgeColors[i]}40,${badgeColors[i]}20);display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:16px;color:#94a3b8;"><i class="fas ${fallbackIcon}"></i></div>`
    return `
    <div style="display:flex;align-items:center;gap:10px;padding:10px 14px;border-radius:12px;background:rgba(255,255,255,0.04);margin-bottom:${i < jobs.length - 1 ? '8px' : '0'};">
      ${rankBadge}
      ${imageHtml}
      <div style="flex:1;min-width:0;">
        <div style="font-size:15px;font-weight:600;color:#e2e8f0;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">${j.name}</div>
      </div>
      <div style="font-size:18px;font-weight:800;color:${fitColor};flex-shrink:0;">${j.fit}<span style="font-size:12px;font-weight:600;">점</span></div>
    </div>`
  }).join('')

  // 태그 렌더 (다크 테마 + 한국어 번역)
  const renderTags = (items: string[], bgColor: string, textColor: string) =>
    items.filter(Boolean).map(t => {
      const translated = translateTag(t)
      return `<span style="display:inline-block;padding:4px 10px;border-radius:20px;font-size:12px;font-weight:500;background:${bgColor};color:${textColor};margin:2px 4px 2px 0;">#${translated}</span>`
    }).join('')

  const strengthTags = renderTags(meta.strengths || [], 'rgba(34,197,94,0.15)', '#86efac')
  const valueTags = renderTags(meta.values || [], 'rgba(99,102,241,0.15)', '#a5b4fc')
  const likeTags = renderTags(meta.likes || [], 'rgba(168,85,247,0.15)', '#d8b4fe')
  const cautionTags = renderTags(meta.cautions || [], 'rgba(251,146,60,0.15)', '#fdba74')
  const avoidTags = renderTags(meta.avoid || [], 'rgba(239,68,68,0.15)', '#fca5a5')

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${ogTitle}</title>
  <meta property="og:title" content="${ogTitle}">
  <meta property="og:description" content="${ogDesc}">
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://careerwiki.org/share/${token}">
  <meta property="og:image" content="https://careerwiki.org/share/${token}/og.png">
  <meta property="og:image:width" content="800">
  <meta property="og:image:height" content="418">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="${ogTitle}">
  <meta name="twitter:description" content="${ogDesc}">
  <meta name="twitter:image" content="https://careerwiki.org/share/${token}/og.png">
  <meta name="robots" content="noindex, nofollow">
  <link rel="canonical" href="https://careerwiki.org/share/${token}">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: linear-gradient(135deg, #1e1b4b 0%, #312e81 50%, #1e1b4b 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 16px;
    }
    .card {
      width: 100%;
      max-width: 480px;
      background: rgba(26, 26, 46, 0.85);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(99, 102, 241, 0.2);
      border-radius: 24px;
      overflow: hidden;
      box-shadow: 0 25px 80px rgba(0, 0, 0, 0.5), 0 0 40px rgba(99, 102, 241, 0.1);
    }
    .header {
      background: linear-gradient(135deg, #6366f1, #a855f7);
      padding: 28px 24px;
      text-align: center;
    }
    .header-sub { font-size: 12px; color: rgba(255,255,255,0.7); letter-spacing: 3px; margin-bottom: 6px; }
    .header-title { font-size: 24px; font-weight: 800; color: white; }
    .body { padding: 24px; }
    .section { margin-bottom: 24px; }
    .section-title {
      font-size: 13px;
      font-weight: 700;
      color: #94a3b8;
      text-transform: uppercase;
      letter-spacing: 1.5px;
      margin-bottom: 14px;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .section-title i { font-size: 14px; }
    .vision-box {
      background: rgba(99, 102, 241, 0.08);
      border: 1px solid rgba(99, 102, 241, 0.15);
      border-radius: 14px;
      padding: 16px 18px;
      font-size: 14px;
      line-height: 1.6;
      color: #c4b5fd;
      font-style: italic;
    }
    .tag-row { margin-bottom: 8px; display: flex; flex-wrap: wrap; align-items: center; gap: 4px; }
    .tag-label { font-size: 12px; color: #64748b; min-width: 36px; flex-shrink: 0; }
    .notice {
      text-align: center;
      font-size: 11px;
      color: #4b5563;
      padding: 12px 0 0;
      border-top: 1px solid rgba(99, 102, 241, 0.1);
    }
    .cta {
      display: block;
      margin: 0 24px 24px;
      text-align: center;
      background: linear-gradient(135deg, #6366f1, #a855f7);
      color: white;
      font-weight: 700;
      font-size: 16px;
      padding: 16px;
      border-radius: 16px;
      text-decoration: none;
      box-shadow: 0 8px 30px rgba(99, 102, 241, 0.3);
      transition: opacity 0.2s;
    }
    .cta:hover { opacity: 0.9; }
    .footer {
      text-align: center;
      padding: 16px 0;
      font-size: 12px;
    }
    .footer a { color: #6366f1; text-decoration: none; }
    .footer a:hover { color: #818cf8; }
  </style>
</head>
<body>
  <div style="width:100%;max-width:480px;">
    <div class="card">
      <div class="header">
        <div class="header-sub">AI CAREER ANALYSIS</div>
        <div class="header-title">${pageTitle}</div>
      </div>

      <div class="body">
        ${jobs.length > 0 ? `
        <div class="section">
          <div class="section-title">
            <i class="fas fa-trophy" style="color:#fbbf24;"></i> ${itemLabel} TOP ${Math.min(jobs.length, 5)}
          </div>
          ${jobsHtml}
        </div>
        ` : ''}

        ${vision ? `
        <div class="section">
          <div class="section-title">
            <i class="fas fa-star" style="color:#a78bfa;"></i> ${isMajor ? '전공 비전' : '커리어 비전'}
          </div>
          <div class="vision-box">"${vision}"</div>
        </div>
        ` : ''}

        <div class="section">
          <div class="section-title">
            <i class="fas fa-dna" style="color:#c084fc;"></i> 커리어 DNA
          </div>
          ${strengthTags ? `<div class="tag-row"><span class="tag-label">강점</span>${strengthTags}</div>` : ''}
          ${valueTags ? `<div class="tag-row"><span class="tag-label">가치</span>${valueTags}</div>` : ''}
          ${likeTags ? `<div class="tag-row"><span class="tag-label">관심</span>${likeTags}</div>` : ''}
          ${cautionTags ? `<div class="tag-row"><span class="tag-label">주의</span>${cautionTags}</div>` : ''}
          ${avoidTags ? `<div class="tag-row"><span class="tag-label">회피</span>${avoidTags}</div>` : ''}
        </div>

        <div class="notice">
          <i class="fas fa-info-circle"></i>
          이 페이지는 요약본이며, 상세 분석 내용은 포함되지 않습니다.
        </div>
      </div>

      <div style="margin:0 24px 24px;text-align:center;">
        <a href="${ctaHref}" class="cta" style="margin:0;">
          <i class="fas fa-rocket" style="margin-right:6px;"></i> ${ctaText}
        </a>
        <div style="margin-top:8px;font-size:11px;color:#6366f1;">
          <i class="fas fa-gift" style="margin-right:3px;"></i> 베타 기간 무료
        </div>
      </div>
    </div>

    <div class="footer">
      <a href="/">careerwiki.org</a>
    </div>
  </div>
</body>
</html>`
}

// 410 Gone 페이지 (OG 태그 포함!)
function renderShareGonePage(): string {
  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공유 링크 만료 — 커리어위키</title>
  <meta property="og:title" content="AI 커리어 분석 — 커리어위키">
  <meta property="og:description" content="나도 무료로 AI 커리어 DNA 분석 받아보기 →">
  <meta property="og:image" content="https://careerwiki.org/images/og-share-card.png">
  <meta name="robots" content="noindex, nofollow">
  <link rel="stylesheet" href="/static/tailwind.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body class="bg-gradient-to-br from-gray-50 via-white to-gray-100 min-h-screen flex items-center justify-center p-4">
  <div class="w-full max-w-md text-center">
    <div class="bg-white rounded-2xl shadow-lg px-8 py-10">
      <div class="text-5xl mb-4 text-gray-300"><i class="fas fa-link-slash"></i></div>
      <h1 class="text-xl font-bold text-gray-700 mb-2">이 공유 링크는 만료되었습니다</h1>
      <p class="text-gray-400 text-sm mb-8">링크가 해제되었거나 유효기간이 지났습니다.</p>
      <a href="/ai-analyzer?utm_source=share&utm_medium=expired&utm_campaign=ai_report"
         class="inline-block bg-gradient-to-r from-indigo-500 to-purple-600 text-white font-bold px-8 py-3 rounded-xl hover:opacity-90 transition-opacity">
        <i class="fas fa-rocket mr-1"></i> 나도 무료로 커리어 DNA 보기
      </a>
    </div>
    <div class="mt-4 text-xs text-gray-400">
      <a href="/" class="hover:text-gray-600">careerwiki.org</a>
    </div>
  </div>
</body>
</html>`
}

// ============================================
// 공유 OG 이미지 (동적 SVG)
// ============================================
shareRoutes.get('/share/:token/og.png', async (c) => {
  const db = c.env.DB
  const r2 = c.env.UPLOADS
  const token = c.req.param('token')

  if (!token) {
    return c.redirect('/images/og-default.png', 302)
  }

  try {
    // 1. R2 캐시 확인
    const cached = await getCachedOgImage(r2, token)
    if (cached) {
      return new Response(cached.buffer as ArrayBuffer, {
        status: 200,
        headers: { 'Content-Type': 'image/png', 'Cache-Control': 'public, max-age=86400' },
      })
    }

    // 2. D1에서 share_data 조회
    const row = await db.prepare(`
      SELECT share_data_json FROM share_tokens
      WHERE share_token = ? AND is_revoked = 0
    `).bind(token).first<{ share_data_json: string }>()

    if (!row) {
      return c.redirect('/images/og-default.png', 302)
    }

    // 3. SVG 생성 → PNG 변환
    const data = JSON.parse(row.share_data_json)
    const svg = renderOgSvg(data.jobs || [], data.vision || '')
    const png = await svgToPng(svg, r2)

    // 4. R2에 캐시 저장 (non-blocking)
    c.executionCtx.waitUntil(cacheOgImage(r2, token, png))

    // 5. PNG 반환
    return new Response(png.buffer as ArrayBuffer, {
      status: 200,
      headers: { 'Content-Type': 'image/png', 'Cache-Control': 'public, max-age=86400' },
    })
  } catch (err) {
    return c.redirect('/images/og-default.png', 302)
  }
})

function renderOgSvg(jobs: Array<{ name: string; fit: number }>, vision = ''): string {
  const rankColors = ['#fbbf24', '#94a3b8', '#cd7f32', '#9ca3af', '#9ca3af']
  const jobLines = jobs.slice(0, 5).map((j, i) => {
    const y = 195 + i * 44
    const rank = `${i + 1}`
    const fitColor = j.fit >= 85 ? '#818cf8' : j.fit >= 70 ? '#60a5fa' : '#9ca3af'
    const badgeColor = rankColors[i] || '#9ca3af'
    return `<circle cx="65" cy="${y - 7}" r="13" fill="${badgeColor}" opacity="0.9"/>
    <text x="65" y="${y - 2}" font-size="13" fill="#1e1b4b" font-weight="bold" font-family="Noto Sans KR, sans-serif" text-anchor="middle">${rank}</text>
    <text x="90" y="${y}" font-size="24" fill="#e0e0e0" font-family="Noto Sans KR, sans-serif">${j.name}</text>
    <text x="720" y="${y}" font-size="24" fill="${fitColor}" font-weight="bold" font-family="Noto Sans KR, sans-serif" text-anchor="end">${j.fit}점</text>`
  }).join('\n    ')

  const visionLine = vision
    ? `<text x="400" y="${195 + Math.min(jobs.length, 5) * 44 + 30}" font-size="16" fill="#a5b4fc" font-family="Noto Sans KR, sans-serif" text-anchor="middle" opacity="0.8">"${vision.slice(0, 60)}${vision.length > 60 ? '...' : ''}"</text>`
    : ''

  return `<svg xmlns="http://www.w3.org/2000/svg" width="800" height="418" viewBox="0 0 800 418">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#1e1b4b"/>
      <stop offset="100%" style="stop-color:#312e81"/>
    </linearGradient>
  </defs>
  <rect width="800" height="418" fill="url(#bg)" rx="0"/>

  <!-- Header -->
  <text x="400" y="50" font-size="15" fill="#a5b4fc" font-family="Noto Sans KR, sans-serif" text-anchor="middle" letter-spacing="3">AI CAREER ANALYSIS</text>
  <text x="400" y="90" font-size="32" fill="white" font-weight="bold" font-family="Noto Sans KR, sans-serif" text-anchor="middle">나의 커리어 DNA</text>

  <!-- Divider -->
  <line x1="200" y1="110" x2="600" y2="110" stroke="#4338ca" stroke-width="1" opacity="0.5"/>

  <!-- Subtitle -->
  <text x="400" y="145" font-size="16" fill="#c4b5fd" font-family="Noto Sans KR, sans-serif" text-anchor="middle">AI 추천 직업</text>

  <!-- Job List -->
  ${jobLines}

  <!-- Vision -->
  ${visionLine}

  <!-- Footer -->
  <text x="400" y="405" font-size="13" fill="#6366f1" font-family="Noto Sans KR, sans-serif" text-anchor="middle">careerwiki.org</text>
</svg>`
}

export { shareRoutes }
