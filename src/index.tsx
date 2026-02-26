import { Hono } from 'hono'
import type { Bindings, AppEnv } from './types/app'
import { isDevEnv, renderUserMenu } from './utils/shared-helpers'
import { cors } from 'hono/cors'
import { serveStatic } from 'hono/cloudflare-workers'
import { renderer } from './renderer'
import auth from './routes/auth'
import { authMiddleware } from './middleware/auth'
import type { ExportedHandlerScheduledHandler } from '@cloudflare/workers-types'
import { attemptScheduledRefresh } from './services/freshnessService'
import { SERP_FRESHNESS_TARGETS } from './config/freshnessConfig'
import { renderNotFoundPage } from './templates/notFound'

// Route imports
import { analyzerRoutes } from './services/ai-analyzer'
import { shareRoutes } from './routes/share'
import { commentRoutes } from './routes/comments'
import { feedbackRoutes } from './routes/feedback'
import { adminRoutes } from './routes/admin'
import { uploadRoutes } from './routes/upload'
import { contentEditorRoutes } from './routes/content-editor'
import { howtoEditorRoutes } from './routes/howto-editor'
import { jobEditorRoutes } from './routes/job-editor'
import { majorEditorRoutes } from './routes/major-editor'
import { howtoRoutes } from './routes/howto'
import { searchRoutes } from './routes/search'
import { jobListRoutes } from './routes/job-list'
import { majorListRoutes } from './routes/major-list'
import { jobDetailRoutes } from './routes/job-detail'
import { majorDetailRoutes } from './routes/major-detail'
import { analyzerJobPage } from './routes/analyzer-job-page'
import { analyzerMajorPage } from './routes/analyzer-major-page'
import { pagesRoutes } from './routes/pages'
import { userRoutes } from './routes/user'
import { apiDataRoutes } from './routes/api-data'
import { apiMiscRoutes } from './routes/api-misc'

// Middleware
const timingMiddleware = async (c: any, next: any) => {
  if (!isDevEnv(c?.env)) {
    await next()
    return
  }
  const t0 = Date.now()
  const marks: Record<string, number> = {}
  c.set('mark', (k: string) => {
    marks[k] = Date.now()
  })
  await next()
  const parts = Object.entries(marks).map(([k, v]) => `${k};dur=${Date.now() - Number(v)}`)
  if (parts.length > 0) {
    c.header('Server-Timing', parts.join(', '))
  }
  c.header('X-Response-Duration', String(Date.now() - t0))
}

const apiCacheHintMiddleware = async (c: any, next: any) => {
  await next()
  const path = c.req.path || ''
  if (path.startsWith('/api/') && !c.res.headers.get('Cache-Control')) {
    // 인증된 API 응답이 CDN에 캐시되지 않도록 private 사용
    // 공개 API만 별도로 public 캐시 설정해야 함
    c.header('Cache-Control', 'private, no-store')
  }
}

const errorLoggingMiddleware = async (c: any, next: any) => {
  try {
    await next()
  } catch (e: any) {
    return c.text('Internal Error', 500)
  }
}

const app = new Hono<AppEnv>()

// Global error handler — 스택 트레이스를 클라이언트에 노출하지 않음
app.onError((err, c) => {
  console.error('[GlobalError]', err?.message, err?.stack)
  return c.text('Internal Server Error', 500)
})

// www → non-www 301 redirect
app.use('*', async (c, next) => {
  const url = new URL(c.req.url)
  if (url.hostname.startsWith('www.')) {
    url.hostname = url.hostname.slice(4)
    return c.redirect(url.toString(), 301)
  }
  return next()
})

// Global middleware
app.use('*', cors())
app.use('*', renderer)
app.use('*', errorLoggingMiddleware)
app.use('*', timingMiddleware)
app.use('*', apiCacheHintMiddleware)

// Static files
// @ts-ignore - Cloudflare Workers types mismatch
app.use('/static/*', serveStatic({ root: './public' }))
// @ts-ignore - Cloudflare Workers types mismatch
app.use('/images/*', serveStatic({ root: './public' }))

// Auth middleware (all routes)
app.use('*', authMiddleware)

// Auth routes
app.route('/auth', auth)

// AI Analyzer API
app.route('/api/ai-analyzer', analyzerRoutes)

// Phase 1 routes
app.route('', shareRoutes)
app.route('', commentRoutes)
app.route('', feedbackRoutes)
app.route('', adminRoutes)
app.route('', uploadRoutes)
app.route('', contentEditorRoutes)
app.route('', howtoEditorRoutes)
app.route('', jobEditorRoutes)
app.route('', majorEditorRoutes)

// Phase 2 routes
app.route('/howto', howtoRoutes)
app.route('', jobListRoutes)       // /job (list) - BEFORE /job/:slug
app.route('', majorListRoutes)     // /major (list) - BEFORE /major/:slug
app.route('', searchRoutes)        // /search
app.route('', jobDetailRoutes)     // /job/:slug
app.route('', majorDetailRoutes)   // /major/:slug, /majors/:id

// Phase 3 routes
app.route('/analyzer/job', analyzerJobPage)
app.route('/analyzer/major', analyzerMajorPage)
app.route('', pagesRoutes)
app.route('', userRoutes)
app.route('', apiDataRoutes)
app.route('', apiMiscRoutes)

// Global 404 fallback
app.notFound((c) => {
  const user = c.get('user')
  const userData = user ? { id: user.id, name: user.name, email: user.email, role: user.role, picture_url: user.picture_url, custom_picture_url: user.custom_picture_url, username: user.username } : null
  const userMenuHtml = renderUserMenu(userData)
  return c.html(renderNotFoundPage({ userMenuHtml, requestedPath: c.req.path }), 404)
})

export default app

export const scheduled: ExportedHandlerScheduledHandler<Bindings> = async (event, env, ctx) => {
  // SERP freshness refresh
  const serpRun = Promise.all(
    SERP_FRESHNESS_TARGETS.map(async (target) => {
      try {
        const result = await attemptScheduledRefresh(env.KV, env, target, {
          reason: event.cron ? `cron:${event.cron}` : 'scheduled-cron'
        })
        if (result.outcome === 'error') {
        }
      } catch (error) {
      }
    })
  )

  // Auto Vectorize indexing (jobs/majors/HowTo)
  const indexRun = (async () => {
    const openaiApiKey = (env as any).OPENAI_API_KEY as string | undefined
    if (!openaiApiKey || !env.VECTORIZE) return
    try {
      const { incrementalUpsertToVectorize, incrementalUpsertMajorsToVectorize, incrementalUpsertHowtosToVectorize } =
        await import('./services/ai-analyzer/vectorize-pipeline')
      await Promise.all([
        incrementalUpsertToVectorize(env.DB, env.VECTORIZE, openaiApiKey, { maxJobs: 20 }),
        incrementalUpsertMajorsToVectorize(env.DB, env.VECTORIZE, openaiApiKey, { maxItems: 20 }),
        incrementalUpsertHowtosToVectorize(env.DB, env.VECTORIZE, openaiApiKey, { maxItems: 20 }),
      ])
    } catch {}
  })()

  const allRun = Promise.all([serpRun, indexRun])
  ctx.waitUntil(allRun)
  await allRun
}
