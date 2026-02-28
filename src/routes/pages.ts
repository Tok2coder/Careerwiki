import { Hono } from 'hono'
import { getCookie, deleteCookie } from 'hono/cookie'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'
import {
  renderUserMenu, getLogoSVG, getOptionalUser,
  renderLayout, renderLayoutWithContext, escapeHtml,
  buildCanonicalUrl, parseSourcesQuery, parseNumberParam,
  renderFooter
} from '../utils/shared-helpers'
import { renderOnboardingPage } from '../templates/onboarding'
import { renderTermsPage } from '../templates/legal/terms'
import { renderPrivacyPage } from '../templates/legal/privacy'
import { renderHelpPage } from '../templates/help'
import { renderAboutPage } from '../templates/about'
import { renderNav, renderNavStyles, renderNavScripts } from '../templates/partials/nav'
import {
  getOnboardingStatus,
  checkNicknameAvailability,
  submitOnboarding,
} from '../services/onboardingService'
import { buildCommentGovernanceItems, resolveCommentPolicy } from '../templates/detailTemplateUtils'
import { renderJobTemplateDesignPage } from '../templates/jobTemplateDesignPage'
import { renderJobETLInspectionPage } from '../templates/jobETLInspectionPage'
import { composeDetailSlug, resolveDetailIdFromSlug } from '../utils/slug'
import { getUnifiedJobDetailWithRawData, getUnifiedMajorDetail, searchUnifiedJobs, searchUnifiedMajors } from '../services/profileDataService'
import type { D1Database } from '@cloudflare/workers-types'
import type { JobSourceRow, MajorSourceRow } from '../types/database'
import type { UnifiedJobDetail, UnifiedMajorDetail } from '../types/unifiedProfiles'

export const pagesRoutes = new Hono<AppEnv>()

pagesRoutes.get('/api/debug/bindings', async (c) => {
  const kvTest = { exists: !!c.env.KV, type: typeof c.env.KV }
  const dbTest = { exists: !!c.env.DB, type: typeof c.env.DB }
  let kvWrite = 'skip'
  if (c.env.KV) {
    try {
      await c.env.KV.put('_test_binding', 'ok', { expirationTtl: 60 })
      const val = await c.env.KV.get('_test_binding')
      kvWrite = val === 'ok' ? 'ok' : `read_mismatch:${val}`
      await c.env.KV.delete('_test_binding')
    } catch (e: any) {
      kvWrite = `error:${e?.message}`
    }
  }
  let dbWrite = 'skip'
  if (c.env.DB) {
    try {
      const r = await c.env.DB.prepare('SELECT 1 as v').first<{v:number}>()
      dbWrite = r?.v === 1 ? 'ok' : `unexpected:${JSON.stringify(r)}`
    } catch (e: any) {
      dbWrite = `error:${e?.message}`
    }
  }
  return c.json({ kv: kvTest, db: dbTest, kvWrite, dbWrite })
})

pagesRoutes.get('/onboarding', requireAuth, async (c) => {
  const user = c.get('user')
  
  // 이미 온보딩 완료한 사용자는 메인으로 리다이렉트
  if (user && (user as any).onboarded === 1) {
    return c.redirect('/')
  }
  
  // 온보딩 완료 후 돌아갈 URL
  const returnUrl = getCookie(c, 'onboarding_return_url') || '/'
  
  const html = renderOnboardingPage({
    userName: user?.name,
    returnUrl
  })
  
  return c.html(html)
})

// 온보딩 상태 조회 API
pagesRoutes.get('/api/me/onboarding', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ error: 'Unauthorized' }, 401)
  }
  
  try {
    const status = await getOnboardingStatus(c.env.DB, user.id)
    return c.json(status)
  } catch (error) {
    return c.json({ error: 'Failed to get onboarding status' }, 500)
  }
})

// 닉네임 가용성 체크 API
pagesRoutes.get('/api/nickname/check', async (c) => {
  const value = c.req.query('value')
  
  if (!value || typeof value !== 'string') {
    return c.json({ ok: false, reason: 'invalid', message: '닉네임을 입력해주세요.' })
  }
  
  try {
    const result = await checkNicknameAvailability(c.env.DB, value)
    return c.json(result)
  } catch (error) {
    return c.json({ ok: false, reason: 'invalid', message: '검증 중 오류가 발생했습니다.' })
  }
})

// 온보딩 제출 API
pagesRoutes.post('/api/onboarding', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'Unauthorized' }, 401)
  }
  
  let body: any
  try {
    body = await c.req.json()
  } catch {
    return c.json({ success: false, error: 'Invalid JSON body' }, 400)
  }
  
  // IP 및 User-Agent 수집
  const ip = c.req.header('CF-Connecting-IP') || c.req.header('X-Forwarded-For')?.split(',')[0] || undefined
  const ua = c.req.header('User-Agent') || undefined
  
  try {
    const result = await submitOnboarding(c.env.DB, user.id, body, { ip, ua })
    
    if (result.success) {
      // 온보딩 완료 후 리턴 URL 쿠키 삭제
      deleteCookie(c, 'onboarding_return_url')
    }
    
    return c.json(result)
  } catch (error) {
    return c.json({ success: false, error: '온보딩 처리 중 오류가 발생했습니다.' }, 500)
  }
})

// 온보딩 상태 조회 API
pagesRoutes.get('/api/me/onboarding', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ error: 'Unauthorized' }, 401)
  }
  
  try {
    const status = await getOnboardingStatus(c.env.DB, user.id)
    return c.json(status)
  } catch (error) {
    return c.json({ error: 'Failed to get onboarding status' }, 500)
  }
})

// 닉네임 가용성 체크 API
pagesRoutes.get('/api/nickname/check', async (c) => {
  const value = c.req.query('value')
  
  if (!value || typeof value !== 'string') {
    return c.json({ ok: false, reason: 'invalid', message: '닉네임을 입력해주세요.' })
  }
  
  try {
    const result = await checkNicknameAvailability(c.env.DB, value)
    return c.json(result)
  } catch (error) {
    return c.json({ ok: false, reason: 'invalid', message: '검증 중 오류가 발생했습니다.' })
  }
})

pagesRoutes.get('/legal/terms', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  return c.html(renderTermsPage({ userMenuHtml }))
})

// 개인정보처리방침 페이지
pagesRoutes.get('/legal/privacy', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  return c.html(renderPrivacyPage({ userMenuHtml }))
})

pagesRoutes.get('/help', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  return c.html(renderHelpPage({ userMenuHtml }))
})

// About 페이지
pagesRoutes.get('/about', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  return c.html(renderAboutPage({ userMenuHtml }))
})

// 릴리즈 노트 (사용자 대상 — feat/fix만 필터링)
pagesRoutes.get('/releases', async (c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)

  // --- GitHub API에서 커밋 가져오기 (cf.cacheTtl로 엣지 캐싱) ---
  interface ReleaseNote { type: 'feat' | 'fix' | 'improve'; message: string; date: string; dateKey: string }

  let notes: ReleaseNote[] = []
  let fetchError = false

  const typeMap: Record<string, ReleaseNote['type']> = {
    feat: 'feat', fix: 'fix', improve: 'improve', update: 'improve', perf: 'improve'
  }

  const KV_RELEASE_KEY = 'release-notes-v5'

  const parseCommitMessage = (msg: string, iso: string): ReleaseNote | null => {
    const firstLine = msg.split('\n')[0].trim()
    const match = firstLine.match(/^(feat|fix|improve|update|perf)(\(.+?\))?:\s*(.+)$/i)
    if (!match) return null
    const rawType = match[1].toLowerCase()
    const type = typeMap[rawType] || 'improve'
    const body = match[3].trim()
    if (!body) return null
    const d = new Date(iso)
    const kst = new Date(d.getTime() + 9 * 60 * 60 * 1000)
    const dateKey = `${kst.getFullYear()}-${String(kst.getMonth() + 1).padStart(2, '0')}`
    return { type, message: body.length > 100 ? body.slice(0, 97) + '...' : body, date: iso, dateKey }
  }

  try {
    // 1) KV 캐시 확인 (가장 안정적)
    const kvData = await c.env.KV.get(KV_RELEASE_KEY).catch(() => null)
    if (kvData) {
      notes = JSON.parse(kvData) as ReleaseNote[]
    } else {
      // 2) GitHub API 호출 (cf.cacheTtl로 Cloudflare 엣지 캐싱 — rate limit 우회)
      const apiUrl = 'https://api.github.com/repos/Tok2coder/Careerwiki/commits?sha=main&per_page=100'
      const ghHeaders: Record<string, string> = { 'Accept': 'application/vnd.github.v3+json', 'User-Agent': 'Careerwiki-Releases' }
      const ghToken = (c.env as any).GITHUB_TOKEN as string | undefined
      if (ghToken) ghHeaders['Authorization'] = `token ${ghToken}`

      const apiRes = await fetch(apiUrl, {
        headers: ghHeaders,
        cf: { cacheTtl: 7200, cacheEverything: true },
      } as any)

      if (apiRes.ok) {
        const commits = await apiRes.json() as any[]
        for (const cm of commits) {
          const msg: string = cm.commit?.message || ''
          const iso = cm.commit?.author?.date || cm.commit?.committer?.date || ''
          const note = parseCommitMessage(msg, iso)
          if (note) notes.push(note)
        }
        // KV에 저장 (24시간)
        if (notes.length > 0) {
          try { await c.env.KV.put(KV_RELEASE_KEY, JSON.stringify(notes), { expirationTtl: 86400 }) } catch {}
        }
      } else {
        fetchError = true
      }
    }
  } catch (e) {
    fetchError = true
  }

  const esc = (s: string): string => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;')

  const typeLabel: Record<string, { icon: string; label: string; color: string; bg: string }> = {
    feat:    { icon: 'fa-wand-magic-sparkles', label: '새 기능',  color: '#a78bfa', bg: 'rgba(167,139,250,0.15)' },
    fix:     { icon: 'fa-bug',      label: '버그 수정', color: '#f87171', bg: 'rgba(248,113,113,0.15)' },
    improve: { icon: 'fa-arrow-up', label: '개선',     color: '#60a5fa', bg: 'rgba(96,165,250,0.15)' },
  }

  // 날짜별 그룹핑
  const grouped = new Map<string, ReleaseNote[]>()
  for (const n of notes) {
    const arr = grouped.get(n.dateKey) || []
    arr.push(n)
    grouped.set(n.dateKey, arr)
  }

  const fmtDateHeader = (key: string): string => {
    const [y, m] = key.split('-').map(Number)
    return `${y}년 ${m}월`
  }

  // 월 목록 (정렬됨: 최신 먼저)
  const monthKeys = [...grouped.keys()]

  // 각 월별 카드 HTML 생성 (data-month 속성으로 JS 토글)
  let sectionsHtml = ''
  if (fetchError || notes.length === 0) {
    sectionsHtml = `
      <div class="glass-card rounded-xl p-8 text-center" style="background:rgba(26,26,46,0.82);border:1px solid rgba(148,163,184,0.22);backdrop-filter:blur(14px);">
        <i class="fas fa-box-open text-3xl text-slate-400 mb-4 block"></i>
        <p class="text-white font-semibold mb-2">${fetchError ? '업데이트 내역을 불러올 수 없습니다' : '아직 업데이트 내역이 없습니다'}</p>
        <p class="text-sm text-slate-400">잠시 후 다시 시도해 주세요.</p>
      </div>`
  } else {
    for (const [dateKey, items] of grouped) {
      const isFirst = dateKey === monthKeys[0]
      const itemsHtml = items.map(n => {
        const t = typeLabel[n.type] || typeLabel.improve
        return `
          <div class="flex items-start gap-3 py-3">
            <span class="flex-shrink-0 mt-0.5 w-7 h-7 rounded-lg flex items-center justify-center text-xs" style="background:${t.bg};color:${t.color};"><i class="fas ${t.icon}"></i></span>
            <div class="flex-1 min-w-0">
              <p class="text-white text-sm sm:text-base leading-relaxed">${esc(n.message)}</p>
            </div>
            <span class="flex-shrink-0 text-xs px-2 py-0.5 rounded-full font-medium" style="background:${t.bg};color:${t.color};">${t.label}</span>
          </div>`
      }).join('<div style="border-top:1px solid rgba(148,163,184,0.1);"></div>')

      const fc = items.filter(n => n.type === 'feat').length
      const xc = items.filter(n => n.type === 'fix').length
      const ic = items.filter(n => n.type === 'improve').length

      sectionsHtml += `
        <div class="rl-month" data-month="${dateKey}" data-feat="${fc}" data-fix="${xc}" data-improve="${ic}" style="${isFirst ? '' : 'display:none;'}">
          <div class="glass-card rounded-xl px-4 sm:px-5" style="background:rgba(26,26,46,0.82);border:1px solid rgba(148,163,184,0.15);backdrop-filter:blur(14px);">
            ${itemsHtml}
          </div>
        </div>`
    }
  }

  // 드롭다운 옵션
  const dropdownOptions = monthKeys.map((k, i) => {
    const [y, m] = k.split('-').map(Number)
    const count = grouped.get(k)!.length
    return `<option value="${k}"${i === 0 ? ' selected' : ''}>${y}년 ${m}월 (${count}건)</option>`
  }).join('')

  return c.html(`<!DOCTYPE html>
  <html lang="ko">
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>업데이트 내역 | Careerwiki</title>
      <link href="/static/style.css" rel="stylesheet" />
      <link rel="stylesheet" href="/static/tailwind.css">
      <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
      ${renderNavStyles()}
    </head>
    <body class="bg-wiki-bg text-wiki-text min-h-screen">
      ${renderNav(userMenuHtml)}
      <main class="max-w-[1400px] mx-auto px-4 pt-20 pb-10 sm:pt-12">
        <header class="mb-8 space-y-3">
          <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
            <i class="fas fa-rocket"></i><span>업데이트 내역</span>
          </div>
          <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
            <h1 class="text-3xl md:text-4xl font-bold text-white">업데이트 내역</h1>
            <p class="text-wiki-muted text-[15px]">Careerwiki에 추가된 새 기능과 개선 사항을 확인하세요.</p>
          </div>
        </header>
        ${monthKeys.length > 0 ? `
        <div class="flex flex-col sm:flex-row items-center justify-between gap-4 mb-6">
          <div id="rlStats" class="flex flex-wrap justify-center gap-3">
          </div>
          <select id="rlMonthSelect" onchange="rlSwitch(this.value)" class="px-4 py-2 rounded-lg text-sm font-medium" style="background:rgba(26,26,46,0.82);border:1px solid rgba(148,163,184,0.25);color:#e6e8f5;">
            ${dropdownOptions}
          </select>
        </div>` : ''}
        <div id="rlSections">
          ${sectionsHtml}
        </div>
      </main>
      ${renderNavScripts()}
      <script>
      function rlSwitch(month){
        document.querySelectorAll('.rl-month').forEach(function(el){
          el.style.display=el.getAttribute('data-month')===month?'':'none';
        });
        var active=document.querySelector('.rl-month[data-month="'+month+'"]');
        if(!active)return;
        var fc=+active.getAttribute('data-feat'),xc=+active.getAttribute('data-fix'),ic=+active.getAttribute('data-improve');
        document.getElementById('rlStats').innerHTML=
          '<div class="flex items-center gap-2 px-3 py-1.5 rounded-full text-xs" style="background:rgba(167,139,250,0.12);color:#a78bfa;"><i class="fas fa-wand-magic-sparkles"></i><span>새 기능 '+fc+'</span></div>'+
          '<div class="flex items-center gap-2 px-3 py-1.5 rounded-full text-xs" style="background:rgba(248,113,113,0.12);color:#f87171;"><i class="fas fa-bug"></i><span>버그 수정 '+xc+'</span></div>'+
          '<div class="flex items-center gap-2 px-3 py-1.5 rounded-full text-xs" style="background:rgba(96,165,250,0.12);color:#60a5fa;"><i class="fas fa-arrow-up"></i><span>개선 '+ic+'</span></div>';
      }
      rlSwitch(document.getElementById('rlMonthSelect')?.value||'');
      </script>
      ${renderFooter()}
    </body>
  </html>`)
})

// Homepage - Google style with menu buttons
pagesRoutes.get('/', (c) => {
  // Phase 3 Day 4: 사용자 정보 가져오기
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  
  const content = `
    <div class="w-full min-h-screen flex flex-col">
        <header class="homepage-header">
            <div class="mx-auto w-full max-w-[1400px] px-3 flex items-center">
                <div class="flex-grow"></div>
                <div class="flex items-center gap-0">
                    <a href="/help" class="header-icon-button px-2" title="도움말">
                        <i class="fas fa-question-circle text-base"></i>
                    </a>
                    ${renderUserMenu(userData)}
                </div>
            </div>
        </header>

        <section class="hero-shell flex-grow">
            <div class="hero-inner">
                <div class="flex justify-center">
                    ${getLogoSVG('large')}
                </div>
                <div class="search-shell">
                    <form action="/search" method="get">
                        <div class="search-bar">
                            <input type="text" name="q" 
                                   placeholder="직업 · 전공 검색" 
                                   autofocus>
                            <button type="submit" class="search-button" aria-label="검색">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                </div>
                <div class="pillar-grid w-full">
                    <a href="/analyzer" class="menu-button text-center group">
                        <i class="fas fa-brain text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                        <div class="text-sm">AI 추천</div>
                    </a>
                    <a href="/job" class="menu-button text-center group">
                        <i class="fas fa-briefcase text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                        <div class="text-sm">직업위키</div>
                    </a>
                    <a href="/major" class="menu-button text-center group">
                        <i class="fas fa-university text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                        <div class="text-sm">전공위키</div>
                    </a>
                    <a href="/howto" class="menu-button text-center group">
                        <i class="fas fa-route text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                        <div class="text-sm">HowTo</div>
                    </a>
                </div>
            </div>
        </section>
    </div>
  `
  
  return c.html(renderLayout(content, 'Careerwiki - AI 진로 분석 플랫폼', 'AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 플랫폼', true, { user: userData, context: c }))
})

// AI Analyzer Page - Choose between Job or Major (로그인 불필요 - 안내만)
pagesRoutes.get('/analyzer', (c) => {
  const user = c.get('user')
  const isLoggedIn = !!user

  const bannerHtml = isLoggedIn
    ? `<div class="mt-8 p-4 rounded-xl border border-amber-500/30 bg-amber-500/10">
            <div class="flex items-center gap-3">
                <i class="fas fa-exclamation-triangle text-amber-400 text-lg"></i>
                <div>
                    <p class="text-amber-300 font-medium">반드시 본인 계정으로 진행해주세요</p>
                    <p class="text-sm text-amber-200/70">입력한 정보는 현재 로그인된 계정에 저장됩니다. 다른 사람의 계정으로 진행하면 데이터가 섞일 수 있어요.</p>
                </div>
            </div>
        </div>`
    : `<div class="mt-8 p-4 bg-amber-500/10 border border-amber-500/30 rounded-xl text-center">
            <p class="text-amber-400 font-semibold mb-1">
                <i class="fas fa-lock mr-2"></i>AI 추천을 받으려면 로그인이 필요합니다
            </p>
            <p class="text-wiki-muted text-sm">
                로그인하시면 분석 결과 저장, 이력서 첨부, 맞춤 추천 등의 기능을 이용하실 수 있습니다.
            </p>
        </div>`

  const content = `
    <div class="max-w-6xl mx-auto px-4 md:px-6 pt-0 md:pt-2">
        <div class="text-center mb-6">
            <h1 class="text-3xl md:text-4xl font-bold text-white">
                <i class="fas fa-brain mr-2 text-wiki-primary"></i>AI 추천
            </h1>
            <p class="text-wiki-muted text-sm md:text-base mt-2 max-w-lg mx-auto leading-relaxed">
                LLM 심층 인터뷰와 벡터 시맨틱 검색으로<br class="hidden md:inline"> 수천 개의 직업·전공 중 나에게 맞는 진로를 찾아드립니다
            </p>
        </div>

        <div class="glass-card p-6 md:p-8 rounded-2xl">
            <h2 class="text-xl md:text-2xl font-bold mb-6 text-center">무엇을 추천받고 싶으신가요?</h2>

            <div class="grid md:grid-cols-2 gap-6 md:gap-8">
                <!-- Job Recommendation -->
                <a href="/analyzer/job" class="glass-card p-8 rounded-xl hover-glow block text-center group relative overflow-hidden">
                    <i class="fas fa-briefcase text-6xl mb-4 text-wiki-secondary group-hover:text-wiki-primary transition"></i>
                    <h3 class="text-2xl font-bold mb-3">직업 추천</h3>
                    <p class="text-wiki-muted">
                        나의 성향, 능력, 가치관을 바탕으로<br>
                        적합한 직업을 AI가 추천해드립니다
                    </p>
                    <div class="mt-4 flex items-center justify-center gap-2">
                        <span class="text-wiki-muted line-through text-sm">₩50,000</span>
                        <span class="text-emerald-400 font-bold text-lg">무료</span>
                    </div>
                    <p class="text-xs text-emerald-400/70 mt-1">베타 기간 한정</p>
                    <div class="mt-4">
                        <span class="px-6 py-3 bg-wiki-primary text-white rounded-lg inline-block group-hover:bg-blue-600 transition">
                            직업 추천받기 →
                        </span>
                    </div>
                </a>

                <!-- Major Recommendation -->
                <a href="/analyzer/major" class="glass-card p-8 rounded-xl hover-glow block text-center group relative overflow-hidden">
                    <i class="fas fa-university text-6xl mb-4 text-wiki-secondary group-hover:text-wiki-primary transition"></i>
                    <h3 class="text-2xl font-bold mb-3">전공 추천</h3>
                    <p class="text-wiki-muted">
                        나의 적성, 흥미, 목표를 분석하여<br>
                        최적의 전공을 AI가 추천해드립니다
                    </p>
                    <div class="mt-4 flex items-center justify-center gap-2">
                        <span class="text-wiki-muted line-through text-sm">₩10,000</span>
                        <span class="text-emerald-400 font-bold text-lg">무료</span>
                    </div>
                    <p class="text-xs text-emerald-400/70 mt-1">베타 기간 한정</p>
                    <div class="mt-4">
                        <span class="px-6 py-3 bg-wiki-primary text-white rounded-lg inline-block group-hover:bg-blue-600 transition">
                            전공 추천받기 →
                        </span>
                    </div>
                </a>
            </div>
            
            ${bannerHtml}
            
            <div class="mt-6 text-center text-wiki-muted text-sm">
                <p>AI 추천은 개인정보를 안전하게 처리하며, 결과는 참고용으로만 활용하시기 바랍니다.</p>
            </div>
        </div>
    </div>
  `
  
  return c.html(renderLayoutWithContext(c, content, 'AI 추천 - Careerwiki', 'AI 기반 맞춤형 직업·전공 추천으로 나에게 맞는 진로를 찾아보세요.', false, {
    canonical: 'https://careerwiki.org/analyzer',
    ogUrl: 'https://careerwiki.org/analyzer'
  }))
})

// Community Guidelines Help Page
pagesRoutes.get('/help/community-guidelines', (c) => {
  const policy = resolveCommentPolicy()
  const governanceItems = buildCommentGovernanceItems(policy)
  const overviewList = governanceItems
    .map((item) => `<li class="flex gap-2 text-sm text-wiki-muted leading-relaxed"><i class="fas fa-check-circle text-wiki-secondary mt-0.5" aria-hidden="true"></i><span>${escapeHtml(item)}</span></li>`)
    .join('')
  const bestDetails = [
    `좋아요 ${policy.bestLikeThreshold}개 이상이면 BEST로 승격됩니다.`,
    `BEST 영역은 최대 ${policy.bestLimit}건으로 유지되며 새로운 BEST가 등록되면 매일 갱신됩니다.`,
    'BEST 댓글은 목록 상단에 고정되어 누구나 빠르게 확인할 수 있습니다.'
  ]
    .map((item) => `<li>${escapeHtml(item)}</li>`)
    .join('')
  const reportDetails = [
    `신고 ${policy.reportBlindThreshold}회 이상 시 댓글이 자동으로 블라인드 처리됩니다.`,
    policy.moderatorIpBlockEnabled
      ? '모더레이터는 신고가 누적된 IP를 차단하여 악성 활동을 선제적으로 막을 수 있습니다.'
      : null,
    `모더레이터 권한 계층: ${policy.moderatorRoles.join(' > ')}`
  ]
    .filter(Boolean)
    .map((item) => `<li>${escapeHtml(String(item))}</li>`)
    .join('')
  const voteDetails = [
    '공감/비공감은 로그인 없이 가능합니다. 신고는 로그인 후 이용해 주세요.',
    '여러 댓글에 공감/비공감을 표시하는 것은 제한이 없습니다.',
    '단, 한 댓글에는 공감 또는 비공감 중 하나만 선택할 수 있습니다.',
    '자신이 작성한 댓글에는 공감/비공감을 할 수 없습니다.',
    '비공감을 남발하거나 집단적으로 특정 댓글을 공격하면 제재될 수 있습니다.'
  ]
    .map((item) => `<li>${escapeHtml(item)}</li>`)
    .join('')

  const commentRules = [
    '댓글은 최대 500자까지 작성할 수 있습니다.',
    '답글은 최대 3단계까지 달 수 있습니다.',
    '익명 댓글 작성 시 4자리 숫자 비밀번호를 설정해야 하며, 수정/삭제 시 필요합니다.',
    '익명 사용자는 하루 최대 5개의 댓글을 작성할 수 있습니다.',
    '로그인 사용자는 댓글 작성 횟수 제한이 없으며, 익명으로도 작성 가능합니다.',
    '욕설, 비방, 광고성 댓글은 자동 필터링되거나 제재 대상이 됩니다.'
  ]
    .map((item) => `<li>${escapeHtml(item)}</li>`)
    .join('')

  const canonicalUrl = buildCanonicalUrl(c.req.url, '/help/community-guidelines')
  const content = `
    <div class="max-w-[1400px] mx-auto px-4 pb-10">
      <section class="space-y-10">
      <header class="mb-8 space-y-3">
        <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
          <i class="fas fa-users-gear"></i><span>커뮤니티 이용 정책</span>
        </div>
        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
          <h1 class="text-3xl md:text-4xl font-bold text-white">커뮤니티 이용 정책</h1>
          <p class="text-wiki-muted text-[15px]">Careerwiki 댓글 커뮤니티 운영 원칙</p>
        </div>
      </header>
      <section class="grid gap-6 md:grid-cols-2">
        <article class="glass-card p-6 rounded-xl space-y-4">
          <h2 class="text-lg font-semibold text-wiki-text">기본 운영 원칙</h2>
          <ul class="space-y-3">${overviewList}</ul>
        </article>
        <article class="glass-card p-6 rounded-xl space-y-4">
          <h2 class="text-lg font-semibold text-wiki-text">댓글 작성 규칙</h2>
          <ul class="space-y-2 text-sm text-wiki-muted">${commentRules}</ul>
        </article>
        <article class="glass-card p-6 rounded-xl space-y-4">
          <h2 class="text-lg font-semibold text-wiki-text">BEST 댓글 정책</h2>
          <ul class="space-y-2 text-sm text-wiki-muted">${bestDetails}</ul>
        </article>
        <article class="glass-card p-6 rounded-xl space-y-4">
          <h2 class="text-lg font-semibold text-wiki-text">신고 &amp; 모더레이션</h2>
          <ul class="space-y-2 text-sm text-wiki-muted">${reportDetails}</ul>
          <p class="text-xs text-wiki-muted/80">블라인드 처리 이후 모더레이터 검토에서 복구 또는 제재 여부가 확정됩니다.</p>
        </article>
        <article class="glass-card p-6 rounded-xl space-y-4 md:col-span-2">
          <h2 class="text-lg font-semibold text-wiki-text">공감/비공감 정책</h2>
          <ul class="space-y-2 text-sm text-wiki-muted">${voteDetails}</ul>
        </article>
      </section>
      <section class="glass-card p-6 rounded-xl space-y-4">
        <h2 class="text-lg font-semibold text-wiki-text">상호작용 흐름 요약</h2>
        <ol class="space-y-2 text-sm text-wiki-muted list-decimal pl-5">
          <li>로그인 없이 댓글을 작성할 수 있습니다. 익명 작성 시 4자리 숫자 비밀번호가 필요하며, 하루 최대 5개까지 작성 가능합니다.</li>
          <li>로그인 사용자는 댓글 작성 횟수 제한 없이 자유롭게 작성할 수 있으며, 원하면 익명으로도 작성할 수 있습니다.</li>
          <li>답글은 최대 3단계까지 달 수 있으며, 댓글 한 건당 최대 500자까지 작성 가능합니다.</li>
          <li>좋아요 ${policy.bestLikeThreshold}개 이상을 받은 댓글은 BEST로 승격되어 목록 상단에 고정됩니다.</li>
          <li>신고 ${policy.reportBlindThreshold}회 이상 누적 시 자동으로 블라인드 처리되며, 모더레이터가 최종 검토합니다.</li>
        </ol>
        <p class="text-xs text-wiki-muted">정책은 서비스 개선을 위해 주기적으로 업데이트되며, 변경 사항은 이 페이지에 먼저 반영됩니다.</p>
      </section>
      <footer class="text-xs text-wiki-muted">
        <p>정책 관련 문의는 <a href="mailto:contact@careerwiki.org" class="text-wiki-primary hover:text-wiki-secondary">contact@careerwiki.org</a>로 연락해 주세요.</p>
      </footer>
      </section>
    </div>
  `

  return c.html(
    renderLayoutWithContext(c,
      content,
      '커뮤니티 이용 정책 - Careerwiki',
      'Careerwiki 댓글 커뮤니티 운영 원칙과 BEST/신고/공감 정책 안내',
      false,
      { canonical: canonicalUrl, ogUrl: canonicalUrl }
    )
  )
})

// Job Template Design Page
pagesRoutes.get('/job-template-design', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    // 변호사 데이터 가져오기
    const jobRow = await db.prepare(`
      SELECT id, name FROM jobs WHERE name = '변호사' LIMIT 1
    `).first<{ id: string; name: string }>()

    if (!jobRow) {
      c.status(404)
      return c.text('변호사 데이터를 찾을 수 없습니다. ETL 시딩을 먼저 실행해주세요.')
    }

    // job_sources 가져오기
    // job_id로 먼저 시도
    let sources = await db.prepare(`
      SELECT * FROM job_sources WHERE job_id = ?
    `).bind(jobRow.id).all<JobSourceRow>()
    
    // job_id가 null인 경우 이름으로 직접 매칭 (더 정확하게)
    if (!sources.results || sources.results.length === 0) {
      
      // JSON_EXTRACT로 직접 매칭 (SQLite 지원)
      // normalized_payload와 raw_payload 모두 확인
      try {
        sources = await db.prepare(`
          SELECT * FROM job_sources 
          WHERE JSON_EXTRACT(normalized_payload, '$.name') = ?
             OR JSON_EXTRACT(raw_payload, '$.dJobNm') = ?
             OR JSON_EXTRACT(raw_payload, '$.jobNm') = ?
             OR JSON_EXTRACT(raw_payload, '$.duty.job_nm') = ?
        `).bind(jobRow.name, jobRow.name, jobRow.name, jobRow.name).all<JobSourceRow>()
      } catch (e) {
        // JSON_EXTRACT 안되면 전체 검색
        const allSources = await db.prepare(`
          SELECT * FROM job_sources WHERE normalized_payload LIKE ? OR raw_payload LIKE ?
        `).bind(`%"name":"${jobRow.name}"%`, `%"${jobRow.name}"%`).all<JobSourceRow>()
        
        const matchedSources = allSources.results?.filter(source => {
          try {
            const normalized = JSON.parse(source.normalized_payload || '{}')
            const raw = JSON.parse(source.raw_payload || '{}')
            return normalized.name === jobRow.name || 
                   raw.dJobNm === jobRow.name || 
                   raw.jobNm === jobRow.name ||
                   raw.duty?.job_nm === jobRow.name
          } catch {
            return false
          }
        }) || []
        
        sources = { results: matchedSources, success: true, meta: allSources.meta }
      }
    }
    

    if (!sources.results || sources.results.length === 0) {
      c.status(404)
      return c.text('변호사의 소스 데이터를 찾을 수 없습니다.')
    }

    const html = renderJobTemplateDesignPage(jobRow.name, sources.results)
    return c.html(html)
  } catch (error) {
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// Job Merge Designer Page (드래그 앤 드롭 병합 규칙 설계)
pagesRoutes.get('/job-template-design2', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    // 실제 DB에 있는 직업들의 소스 데이터 가져오기 (다양한 예시 확보)
    // 각 소스 시스템에서 균등하게 샘플링
    // SQLite에서는 UNION ALL 안의 각 SELECT에 ORDER BY를 사용할 수 없으므로 서브쿼리로 감싸야 함
    const allSources = await db.prepare(`
      SELECT js.*, 
             COALESCE(
               j.name,
               JSON_EXTRACT(js.normalized_payload, '$.name'),
               JSON_EXTRACT(js.raw_payload, '$.dJobNm'),
               JSON_EXTRACT(js.raw_payload, '$.jobNm')
             ) as job_name
      FROM (
        -- 커리어넷 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM job_sources 
          WHERE source_system = 'CAREERNET' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
        
        UNION ALL
        
        -- 고용24 직업정보 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM job_sources 
          WHERE source_system = 'WORK24_JOB' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
        
        UNION ALL
        
        -- 고용24 직업사전 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM job_sources 
          WHERE source_system = 'WORK24_DJOB' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
      ) js
      LEFT JOIN jobs j ON js.job_id = j.id
    `).all<JobSourceRow & { job_name: string }>()


    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text('샘플 직업 데이터를 찾을 수 없습니다. ETL 시딩을 먼저 실행해주세요.')
    }

    // 소스별로 데이터 통합
    const careernetSamples: any[] = []
    const work24JobSamples: any[] = []
    const work24DJobSamples: any[] = []

    allSources.results.forEach(row => {
      try {
        const rawData = JSON.parse(row.raw_payload || '{}')
        if (!rawData || Object.keys(rawData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...rawData, _jobName: row.job_name })
        } else if (row.source_system === 'WORK24_JOB') {
          work24JobSamples.push({ ...rawData, _jobName: row.job_name })
        } else if (row.source_system === 'WORK24_DJOB') {
          work24DJobSamples.push({ ...rawData, _jobName: row.job_name })
        }
      } catch (e) {
      }
    })

    const { renderJobMergeDesigner } = await import('../templates/jobMergeDesigner')
    const html = renderJobMergeDesigner(careernetSamples, work24JobSamples, work24DJobSamples)
    return c.html(html)
  } catch (error) {
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// 직업별 디자이너 페이지: /job-template-design2/:slug
pagesRoutes.get('/job-template-design2/:slug', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    const slug = decodeURIComponent(c.req.param('slug'))
    
    // slug로 직업 찾기
    const job = await db.prepare(`
      SELECT id, name, slug FROM jobs WHERE slug = ? LIMIT 1
    `).bind(slug).first<{ id: string; name: string; slug: string }>()
    
    if (!job) {
      c.status(404)
      return c.text(`직업 "${slug}"을 찾을 수 없습니다.`)
    }

    // 해당 직업의 모든 소스 데이터 가져오기
    const allSources = await db.prepare(`
      SELECT js.*, 
             COALESCE(
               j.name,
               JSON_EXTRACT(js.normalized_payload, '$.name'),
               JSON_EXTRACT(js.raw_payload, '$.dJobNm'),
               JSON_EXTRACT(js.raw_payload, '$.jobNm')
             ) as job_name
      FROM job_sources js
      LEFT JOIN jobs j ON js.job_id = j.id
      WHERE (
        js.job_id = ?
        OR JSON_EXTRACT(js.normalized_payload, '$.name') = ?
        OR (js.source_system = 'WORK24_DJOB' AND JSON_EXTRACT(js.raw_payload, '$.dJobNm') = ?)
        OR (js.source_system = 'WORK24_JOB' AND JSON_EXTRACT(js.raw_payload, '$.jobNm') = ?)
      )
    `).bind(job.id, job.name, job.name, job.name).all<JobSourceRow & { job_name: string }>()


    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text(`직업 "${job.name}"의 소스 데이터를 찾을 수 없습니다.`)
    }

    // 다른 직업들의 예시 데이터 가져오기 (현재 직업에 없는 필드용)
    // 각 소스별로 균등하게 샘플링하여 모든 필드에 예시 데이터가 있도록 함
    const otherSamples = await db.prepare(`
      SELECT source_system, raw_payload, job_name FROM (
        -- CAREERNET 샘플 15개
        SELECT js.source_system, js.raw_payload,
               COALESCE(j.name, JSON_EXTRACT(js.normalized_payload, '$.name')) as job_name
        FROM job_sources js
        LEFT JOIN jobs j ON js.job_id = j.id
        WHERE js.source_system = 'CAREERNET'
          AND js.job_id != ?
          AND js.raw_payload IS NOT NULL 
          AND js.raw_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 15
      )
      UNION ALL
      SELECT source_system, raw_payload, job_name FROM (
        -- WORK24_JOB 샘플 15개
        SELECT js.source_system, js.raw_payload,
               COALESCE(j.name, JSON_EXTRACT(js.raw_payload, '$.jobNm')) as job_name
        FROM job_sources js
        LEFT JOIN jobs j ON js.job_id = j.id
        WHERE js.source_system = 'WORK24_JOB'
          AND js.job_id != ?
          AND js.raw_payload IS NOT NULL 
          AND js.raw_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 15
      )
      UNION ALL
      SELECT source_system, raw_payload, job_name FROM (
        -- WORK24_DJOB 샘플 20개 (필드가 많아서 더 많이)
        SELECT js.source_system, js.raw_payload,
               COALESCE(j.name, JSON_EXTRACT(js.raw_payload, '$.dJobNm')) as job_name
        FROM job_sources js
        LEFT JOIN jobs j ON js.job_id = j.id
        WHERE js.source_system = 'WORK24_DJOB'
          AND js.job_id != ?
          AND js.raw_payload IS NOT NULL 
          AND js.raw_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 20
      )
    `).bind(job.id, job.id, job.id).all<{ source_system: string; raw_payload: string; job_name: string }>()

    // 소스별로 데이터 통합
    const careernetSamples: any[] = []
    const work24JobSamples: any[] = []
    const work24DJobSamples: any[] = []

    // 현재 직업 데이터 추가 (우선 표시)
    allSources.results.forEach(row => {
      try {
        const rawData = JSON.parse(row.raw_payload || '{}')
        if (!rawData || Object.keys(rawData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...rawData, _jobName: row.job_name, _isCurrentJob: true })
        } else if (row.source_system === 'WORK24_JOB') {
          work24JobSamples.push({ ...rawData, _jobName: row.job_name, _isCurrentJob: true })
        } else if (row.source_system === 'WORK24_DJOB') {
          work24DJobSamples.push({ ...rawData, _jobName: row.job_name, _isCurrentJob: true })
        }
      } catch (e) {
      }
    })

    // 다른 직업 예시 데이터 추가 (예시용)
    otherSamples.results?.forEach(row => {
      try {
        const rawData = JSON.parse(row.raw_payload || '{}')
        if (!rawData || Object.keys(rawData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...rawData, _jobName: `[예시] ${row.job_name}`, _isCurrentJob: false })
        } else if (row.source_system === 'WORK24_JOB') {
          work24JobSamples.push({ ...rawData, _jobName: `[예시] ${row.job_name}`, _isCurrentJob: false })
        } else if (row.source_system === 'WORK24_DJOB') {
          work24DJobSamples.push({ ...rawData, _jobName: `[예시] ${row.job_name}`, _isCurrentJob: false })
        }
      } catch (e) {
      }
    })

    const { renderJobMergeDesigner } = await import('../templates/jobMergeDesigner')
    const html = renderJobMergeDesigner(
      careernetSamples,
      work24JobSamples,
      work24DJobSamples,
      job.name,
      job.slug
    )
    return c.html(html)
  } catch (error) {
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// Major Merge Designer Page (전공 데이터 필드 병합 규칙 설계)
pagesRoutes.get('/major-template-design', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    // 실제 DB에 있는 전공들의 소스 데이터 가져오기
    const allSources = await db.prepare(`
      SELECT ms.*, 
             COALESCE(
               m.name,
               JSON_EXTRACT(ms.normalized_payload, '$.name'),
               JSON_EXTRACT(ms.raw_payload, '$.major'),
               JSON_EXTRACT(ms.raw_payload, '$.majorName')
             ) as major_name
      FROM (
        -- 커리어넷 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM major_sources 
          WHERE source_system = 'CAREERNET' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
        
        UNION ALL
        
        -- 고용24 학과정보 샘플 (20개)
        SELECT * FROM (
          SELECT * FROM major_sources 
          WHERE source_system = 'WORK24_MAJOR' 
          ORDER BY RANDOM() 
          LIMIT 20
        )
      ) ms
      LEFT JOIN majors m ON ms.major_id = m.id
    `).all<MajorSourceRow & { major_name: string }>()


    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text('샘플 전공 데이터를 찾을 수 없습니다. ETL 시딩을 먼저 실행해주세요.')
    }

    // 소스별로 데이터 통합
    const careernetSamples: any[] = []
    const work24MajorSamples: any[] = []

    // normalized_payload 사용 (병합 로직과 동일한 필드명 표시)
    allSources.results.forEach(row => {
      try {
        const normalizedData = JSON.parse(row.normalized_payload || '{}')
        if (!normalizedData || Object.keys(normalizedData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...normalizedData, _majorName: row.major_name })
        } else if (row.source_system === 'WORK24_MAJOR') {
          work24MajorSamples.push({ ...normalizedData, _majorName: row.major_name })
        }
      } catch (e) {
      }
    })

    const { renderMajorMergeDesigner } = await import('../templates/majorMergeDesigner')
    const html = renderMajorMergeDesigner(careernetSamples, work24MajorSamples)
    return c.html(html)
  } catch (error) {
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// 전공별 디자이너 페이지: /major-template-design/:slug
pagesRoutes.get('/major-template-design/:slug', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    const slug = decodeURIComponent(c.req.param('slug'))
    
    // slug로 전공 찾기
    const major = await db.prepare(`
      SELECT id, name, slug FROM majors WHERE slug = ? LIMIT 1
    `).bind(slug).first<{ id: string; name: string; slug: string }>()
    
    if (!major) {
      c.status(404)
      return c.text(`전공 "${slug}"을 찾을 수 없습니다.`)
    }

    // 해당 전공의 모든 소스 데이터 가져오기
    const allSources = await db.prepare(`
      SELECT ms.*, 
             COALESCE(
               m.name,
               JSON_EXTRACT(ms.normalized_payload, '$.name'),
               JSON_EXTRACT(ms.raw_payload, '$.major'),
               JSON_EXTRACT(ms.raw_payload, '$.majorName')
             ) as major_name
      FROM major_sources ms
      LEFT JOIN majors m ON ms.major_id = m.id
      WHERE (
        ms.major_id = ?
        OR JSON_EXTRACT(ms.normalized_payload, '$.name') = ?
        OR JSON_EXTRACT(ms.raw_payload, '$.major') = ?
        OR JSON_EXTRACT(ms.raw_payload, '$.majorName') = ?
      )
    `).bind(major.id, major.name, major.name, major.name).all<MajorSourceRow & { major_name: string }>()


    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text(`전공 "${major.name}"의 소스 데이터를 찾을 수 없습니다.`)
    }

    // 다른 전공들의 예시 데이터 가져오기 (normalized_payload 사용)
    const otherSamples = await db.prepare(`
      SELECT source_system, normalized_payload, major_name FROM (
        SELECT ms.source_system, ms.normalized_payload,
               COALESCE(m.name, JSON_EXTRACT(ms.normalized_payload, '$.name')) as major_name
        FROM major_sources ms
        LEFT JOIN majors m ON ms.major_id = m.id
        WHERE ms.source_system = 'CAREERNET'
          AND ms.major_id != ?
          AND ms.normalized_payload IS NOT NULL 
          AND ms.normalized_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 15
      )
      UNION ALL
      SELECT source_system, normalized_payload, major_name FROM (
        SELECT ms.source_system, ms.normalized_payload,
               COALESCE(m.name, JSON_EXTRACT(ms.normalized_payload, '$.name')) as major_name
        FROM major_sources ms
        LEFT JOIN majors m ON ms.major_id = m.id
        WHERE ms.source_system = 'WORK24_MAJOR'
          AND ms.major_id != ?
          AND ms.normalized_payload IS NOT NULL 
          AND ms.normalized_payload != '{}'
        ORDER BY RANDOM()
        LIMIT 15
      )
    `).bind(major.id, major.id).all<{ source_system: string; normalized_payload: string; major_name: string }>()

    // 소스별로 데이터 통합
    const careernetSamples: any[] = []
    const work24MajorSamples: any[] = []

    // 현재 전공 데이터 추가 (우선 표시) - normalized_payload 사용
    allSources.results.forEach(row => {
      try {
        const normalizedData = JSON.parse(row.normalized_payload || '{}')
        if (!normalizedData || Object.keys(normalizedData).length === 0) return

        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...normalizedData, _majorName: row.major_name, _isCurrentMajor: true })
        } else if (row.source_system === 'WORK24_MAJOR') {
          work24MajorSamples.push({ ...normalizedData, _majorName: row.major_name, _isCurrentMajor: true })
        }
      } catch (e) {
      }
    })

    // 다른 전공의 예시 데이터 추가 (필드 예시용) - normalized_payload 사용
    otherSamples.results?.forEach(row => {
      try {
        const normalizedData = JSON.parse(row.normalized_payload || '{}')
        if (!normalizedData || Object.keys(normalizedData).length === 0) return

        const displayName = `[예시] ${row.major_name}`
        if (row.source_system === 'CAREERNET') {
          careernetSamples.push({ ...normalizedData, _majorName: displayName, _isCurrentMajor: false })
        } else if (row.source_system === 'WORK24_MAJOR') {
          work24MajorSamples.push({ ...normalizedData, _majorName: displayName, _isCurrentMajor: false })
        }
      } catch (e) {
        // Skip invalid JSON
      }
    })

    const { renderMajorMergeDesigner } = await import('../templates/majorMergeDesigner')
    const html = renderMajorMergeDesigner(
      careernetSamples, 
      work24MajorSamples,
      major.name,
      major.slug
    )
    return c.html(html)
  } catch (error) {
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// ETL 병합 로직 점검 페이지: /job-template-design3/:slug
pagesRoutes.get('/job-template-design3/:slug', async (c) => {
  try {
    const db = c.env.DB as D1Database
    if (!db) {
      throw new Error('DB not available')
    }

    const slug = decodeURIComponent(c.req.param('slug'))
    
    // slug로 직업 찾기
    const job = await db.prepare(`
      SELECT id, name, slug, merged_profile_json FROM jobs WHERE slug = ? LIMIT 1
    `).bind(slug).first<{ id: string; name: string; slug: string; merged_profile_json: string | null }>()
    
    if (!job) {
      c.status(404)
      return c.text(`직업 "${slug}"을 찾을 수 없습니다.`)
    }

    // 해당 직업의 모든 소스 데이터 가져오기
    const allSources = await db.prepare(`
      SELECT js.*, 
             COALESCE(
               j.name,
               JSON_EXTRACT(js.normalized_payload, '$.name'),
               JSON_EXTRACT(js.raw_payload, '$.dJobNm'),
               JSON_EXTRACT(js.raw_payload, '$.jobNm')
             ) as job_name
      FROM job_sources js
      LEFT JOIN jobs j ON js.job_id = j.id
      WHERE (
        js.job_id = ?
        OR JSON_EXTRACT(js.normalized_payload, '$.name') = ?
        OR (js.source_system = 'WORK24_DJOB' AND JSON_EXTRACT(js.raw_payload, '$.dJobNm') = ?)
        OR (js.source_system = 'WORK24_JOB' AND JSON_EXTRACT(js.raw_payload, '$.jobNm') = ?)
      )
    `).bind(job.id, job.name, job.name, job.name).all<JobSourceRow & { job_name: string }>()


    if (!allSources.results || allSources.results.length === 0) {
      c.status(404)
      return c.text(`직업 "${job.name}"의 소스 데이터를 찾을 수 없습니다.`)
    }

    // Merged profile 파싱
    let mergedProfile: UnifiedJobDetail | null = null
    if (job.merged_profile_json) {
      try {
        mergedProfile = JSON.parse(job.merged_profile_json) as UnifiedJobDetail
      } catch (e) {
      }
    }

    const html = renderJobETLInspectionPage(
      job.name,
      job.id,
      allSources.results,
      mergedProfile
    )
    return c.html(html)
  } catch (error) {
    c.status(500)
    return c.text('오류가 발생했습니다: ' + (error instanceof Error ? error.message : String(error)))
  }
})

// 로그인 페이지 (Google OAuth로 리다이렉트)
pagesRoutes.get('/login', (c) => {
  const queryRedirect = c.req.query('redirect')
  const referer = c.req.header('Referer')
  const loginError = c.req.query('error')
  let redirect = queryRedirect || '/'

  // Referer가 있고 내부 URL이면 사용
  if (!queryRedirect && referer) {
    try {
      const refererUrl = new URL(referer)
      const currentUrl = new URL(c.req.url)
      // 같은 도메인이면 Referer 사용
      if (refererUrl.origin === currentUrl.origin && refererUrl.pathname !== '/login') {
        redirect = refererUrl.pathname + refererUrl.search
      }
    } catch (e) {
      // URL 파싱 실패 시 기본값 사용
    }
  }

  const user = getOptionalUser(c)

  // 이미 로그인한 경우 리다이렉트
  if (user) {
    return c.redirect(redirect)
  }

  const errorMsg = loginError === '1' ? '아이디 또는 비밀번호가 일치하지 않습니다.'
    : loginError === '2' ? '로그인 처리 중 오류가 발생했습니다. 다시 시도해주세요.'
    : ''

  const content = `
    <div class="min-h-[60vh] flex items-center justify-center px-4 pt-16 md:pt-0">
      <div class="max-w-md w-full">
        <div class="bg-wiki-card/60 border border-wiki-border/40 rounded-2xl p-8 text-center backdrop-blur-sm">
          <!-- 로고/아이콘 -->
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-wiki-primary/10 mb-6">
            <i class="fas fa-user-circle text-3xl text-wiki-primary"></i>
          </div>

          <h1 class="text-2xl font-bold text-white mb-2">로그인</h1>
          <p class="text-wiki-muted mb-6">계속하려면 로그인해주세요</p>

          <!-- Google 로그인 버튼 -->
          <a href="/auth/google?return_url=${encodeURIComponent(redirect)}"
             class="flex items-center justify-center gap-3 w-full px-6 py-3.5 bg-white hover:bg-gray-50 text-gray-800 font-medium rounded-xl transition shadow-sm">
            <svg class="w-5 h-5" viewBox="0 0 24 24">
              <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
              <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
              <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
              <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
            </svg>
            <span>Google로 계속하기</span>
          </a>

          <!-- 구분선 -->
          <div class="flex items-center gap-3 my-6">
            <div class="flex-1 h-px bg-wiki-border/40"></div>
            <span class="text-xs text-wiki-muted">또는</span>
            <div class="flex-1 h-px bg-wiki-border/40"></div>
          </div>

          <!-- 테스트 계정 로그인 -->
          <form method="POST" action="/auth/test-login" class="text-left">
            <input type="hidden" name="redirect" value="${redirect.replace(/"/g, '&quot;')}" />

            <div class="space-y-3">
              <div>
                <label class="block text-xs text-wiki-muted mb-1.5">아이디</label>
                <input type="text" name="id" autocomplete="username"
                  class="w-full px-4 py-2.5 bg-wiki-bg/80 border border-wiki-border/50 rounded-lg text-white text-sm placeholder-wiki-muted/60 focus:border-wiki-primary focus:outline-none transition"
                  placeholder="아이디를 입력하세요" />
              </div>
              <div>
                <label class="block text-xs text-wiki-muted mb-1.5">비밀번호</label>
                <input type="password" name="pw" autocomplete="current-password"
                  class="w-full px-4 py-2.5 bg-wiki-bg/80 border border-wiki-border/50 rounded-lg text-white text-sm placeholder-wiki-muted/60 focus:border-wiki-primary focus:outline-none transition"
                  placeholder="비밀번호를 입력하세요" />
              </div>
            </div>

            ${errorMsg ? `
              <p class="mt-3 text-xs text-red-400 text-center">
                <i class="fas fa-exclamation-circle mr-1"></i>${errorMsg}
              </p>
            ` : ''}

            <button type="submit"
              class="w-full mt-4 px-6 py-2.5 bg-wiki-primary hover:bg-wiki-primary/80 text-white font-medium rounded-lg transition text-sm">
              로그인
            </button>
          </form>

          <p class="text-xs text-wiki-muted mt-6 leading-relaxed">
            로그인하면 <a href="/terms" class="text-wiki-primary hover:underline py-1 inline-block">이용약관</a> 및
            <a href="/privacy" class="text-wiki-primary hover:underline py-1 inline-block">개인정보처리방침</a>에 동의하게 됩니다.
          </p>
        </div>
      </div>
    </div>
  `
  
  return c.html(
    renderLayoutWithContext(c,
      content,
      '로그인 - Careerwiki',
      'Careerwiki에 로그인하세요'
    )
  )
})

// 이용약관 페이지 (레거시 URL → /legal/terms 리다이렉트)
pagesRoutes.get('/terms', (c) => c.redirect('/legal/terms', 301))

// 개인정보처리방침 페이지 (레거시 URL → /legal/privacy 리다이렉트)
pagesRoutes.get('/privacy', (c) => c.redirect('/legal/privacy', 301))

// SEO skeleton (dev/local only)
pagesRoutes.get('/robots.txt', (c) => {
  const url = new URL(c.req.url)
  const origin = `${url.protocol}//${url.host}`
  const body = `User-agent: *

Allow: /
Sitemap: ${origin}/sitemap.xml
`
  return c.text(body, 200, { 'content-type': 'text/plain; charset=utf-8' })
})

pagesRoutes.get('/sitemap.xml', async (c) => {
  const origin = buildCanonicalUrl(c.req.url, '')

  const staticPaths = [
    '/',
    '/job',
    '/major',
    '/howto',
    '/help',
    '/analyzer',
    '/feedback',
    '/legal/terms',
    '/legal/privacy',
  ]

  const entries: Array<{ loc: string; lastmod?: string }> = staticPaths.map((p) => ({ loc: `${origin}${p}` }))

  try {
    const [jobRows, majorRows, howtoRows] = await Promise.all([
      c.env.DB.prepare('SELECT id, name FROM jobs WHERE is_active = 1').all<{ id: string; name: string }>(),
      c.env.DB.prepare('SELECT id, name FROM majors WHERE is_active = 1').all<{ id: string; name: string }>(),
      c.env.DB.prepare(
        "SELECT slug, updated_at FROM pages WHERE page_type = 'guide' AND status IN ('published', 'draft_published')"
      ).all<{ slug: string; updated_at: string | null }>(),
    ])

    for (const row of jobRows.results) {
      const slug = composeDetailSlug('job', row.name, row.id)
      entries.push({ loc: `${origin}/job/${encodeURIComponent(slug)}` })
    }

    for (const row of majorRows.results) {
      const slug = composeDetailSlug('major', row.name, row.id)
      entries.push({ loc: `${origin}/major/${encodeURIComponent(slug)}` })
    }

    for (const row of howtoRows.results) {
      if (row.slug) {
        entries.push({
          loc: `${origin}/howto/${encodeURIComponent(row.slug)}`,
          lastmod: row.updated_at ? row.updated_at.split('T')[0] : undefined,
        })
      }
    }
  } catch {
    // DB unavailable — return static pages only
  }

  const urlTags = entries
    .map((e) => {
      const lastmod = e.lastmod ? `<lastmod>${e.lastmod}</lastmod>` : ''
      return `<url><loc>${e.loc}</loc>${lastmod}</url>`
    })
    .join('\n')

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urlTags}
</urlset>`
  return c.text(xml, 200, {
    'content-type': 'application/xml; charset=utf-8',
    'cache-control': 'public, max-age=3600',
  })
})
