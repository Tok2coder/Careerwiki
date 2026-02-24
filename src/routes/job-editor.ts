/**
 * 직업 편집기 API 라우트
 * content-editor.ts에서 추출: 직업 CRUD, 관리자 생성, 데이터 갱신
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { authMiddleware, requireAuth, requireAdmin, requireJobMajorEdit } from '../middleware/auth'
import { editJob, createJob } from '../services/editService'
import { invalidatePageCache } from '../utils/page-cache'
import { getOptionalUser, hashIpAddress, escapeHtml } from '../utils/shared-helpers'
import type { R2Bucket } from '@cloudflare/workers-types'

const jobEditorRoutes = new Hono<AppEnv>()

// ============================================================================
// Group B: Job CRUD (static paths first)
// ============================================================================

// 직업 생성 (일반 사용자)
jobEditorRoutes.post('/api/job/create', requireAuth, async (c) => {
  try {
    const user = c.get('user')
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }

    let body: any
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }

    const name = typeof body.name === 'string' ? body.name.trim() : ''
    const summary = typeof body.summary === 'string' ? body.summary.trim() : ''
    const heroTags = Array.isArray(body.heroTags) ? body.heroTags : []
    const heroCategory = typeof body.heroCategory === 'string' ? body.heroCategory.trim() : ''

    if (!name || name.length < 2) {
      return c.json({ success: false, error: '직업명은 최소 2자 이상이어야 합니다' }, 400)
    }
    if (!summary || summary.length < 2) {
      return c.json({ success: false, error: '설명은 최소 2자 이상이어야 합니다' }, 400)
    }

    const slug = name.replace(/[\s\-\/\.·ㆍ,()]+/g, '-').toLowerCase()
    const id = `U_${slug}_${Date.now().toString(36)}`

    const existing = await c.env.DB.prepare(
      'SELECT id FROM jobs WHERE name = ? AND is_active = 1'
    ).bind(name).first()

    if (existing) {
      return c.json({ success: false, error: '이미 존재하는 직업입니다' }, 400)
    }

    const userData: Record<string, any> = {
      summary,
      overview: {
        summary
      }
    }
    if (heroTags.length > 0) {
      userData.heroTags = [...new Set(heroTags.filter((t: any) => typeof t === 'string' && t.trim()))]
    }
    if (heroCategory) {
      userData.heroCategory = heroCategory
    }

    const mergedProfile = {
      id,
      name,
      summary,
      heroTags: userData.heroTags || [],
      heroCategory: userData.heroCategory || '',
      source: 'USER' as const
    }

    const urlSlug = name.replace(/[\s]+/g, '-').toLowerCase()

    const now = Date.now()

    try {
      await c.env.DB.prepare(`
        INSERT INTO jobs (id, name, slug, user_contributed_json, merged_profile_json, user_last_updated_at, created_at, is_active, primary_source)
        VALUES (?, ?, ?, ?, ?, ?, ?, 1, 'USER')
      `).bind(
        id,
        name,
        urlSlug,
        JSON.stringify(userData),
        JSON.stringify(mergedProfile),
        now,
        now
      ).run()
    } catch (insertError) {
      throw insertError
    }

    try {
      const { createRevision } = await import('../services/revisionService')
      await createRevision(c.env.DB, {
        entityType: 'job',
        entityId: id,
        dataSnapshot: { id, name, ...userData },
        editorId: user.id.toString(),
        editorType: user.role as 'user' | 'expert' | 'admin',
        editorName: user.username || `User ${user.id}`,
        changeType: 'initial',
        changeSummary: '직업 생성',
        changedFields: Object.keys(userData),
        storeFullSnapshot: true
      })
    } catch (revisionError) {
      throw revisionError
    }

    let imageUrl: string | undefined
    let imagePrompt: string | undefined

    const geminiKey = (c.env as any).GEMINI_API_KEY
    const evolinkKey = (c.env as any).EVOLINK_API_KEY
    const uploadsR2 = (c.env as any).UPLOADS as R2Bucket | undefined

    if (geminiKey && evolinkKey && uploadsR2) {
      try {
        const { generateJobImage } = await import('../services/autoImageService')
        const baseUrl = new URL(c.req.url).origin

        const imageResult = await generateJobImage(
          { GEMINI_API_KEY: geminiKey, EVOLINK_API_KEY: evolinkKey, UPLOADS: uploadsR2 },
          name,
          urlSlug,
          baseUrl
        )

        if (imageResult.success) {
          imageUrl = imageResult.imageUrl
          imagePrompt = imageResult.imagePrompt

          await c.env.DB.prepare(`
            UPDATE jobs SET image_url = ?, image_prompt = ? WHERE id = ?
          `).bind(imageUrl, imagePrompt, id).run()

        } else {
          if (imageResult.imagePrompt) {
            await c.env.DB.prepare(`
              UPDATE jobs SET image_prompt = ? WHERE id = ?
            `).bind(imageResult.imagePrompt, id).run()
            imagePrompt = imageResult.imagePrompt
          }
        }
      } catch (imageError) {
      }
    } else {
    }

    const openaiKeyForTag = (c.env as any).OPENAI_API_KEY
    if (openaiKeyForTag) {
      c.executionCtx.waitUntil(
        import('../services/ai-analyzer/auto-tagger').then(({ autoTagJob }) =>
          autoTagJob(c.env.DB, {
            id,
            name,
            user_contributed_json: JSON.stringify(userData),
            merged_profile_json: JSON.stringify(mergedProfile),
          }, openaiKeyForTag)
        ).catch(() => {})
      )
    }

    const openaiKeyForIdx = (c.env as any).OPENAI_API_KEY
    if (openaiKeyForIdx && (c.env as any).VECTORIZE) {
      c.executionCtx.waitUntil(
        import('../services/ai-analyzer/vectorize-pipeline').then(({ indexSingleJob }) =>
          indexSingleJob(c.env.DB, (c.env as any).VECTORIZE, openaiKeyForIdx, id)
        ).catch(() => {})
      )
    }

    return c.json({
      success: true,
      id,
      slug: urlSlug,
      imageUrl,
      imagePrompt,
      message: '직업이 생성되었습니다'
    }, 201)

  } catch (error) {
    const message = error instanceof Error ? error.message : 'create failed'
    return c.json({ success: false, error: message }, 500)
  }
})

// 숨겨진 직업 목록 조회 (운영자/관리자 전용)
jobEditorRoutes.get('/api/job/hidden', requireAuth, async (c) => {
  try {
    const user = c.get('user')

    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }

    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }

    const jobs = await c.env.DB.prepare(`
      SELECT id, name, slug, user_last_updated_at
      FROM jobs
      WHERE is_active = 0
      ORDER BY user_last_updated_at DESC
    `).all<{ id: string; name: string; slug: string | null; user_last_updated_at: number }>()

    return c.json({
      success: true,
      jobs: jobs.results || []
    })
  } catch (error) {
    return c.json({ success: false, error: 'FETCH_FAILED' }, 500)
  }
})

// 직업 분류 목록 조회
jobEditorRoutes.get('/api/job/categories', async (c) => {
  try {
    const q = c.req.query('q')?.trim().toLowerCase() || ''
    const limit = parseInt(c.req.query('limit') || '20')

    let query = `
      SELECT DISTINCT
        COALESCE(
          JSON_EXTRACT(user_contributed_json, '$.heroCategory'),
          JSON_EXTRACT(admin_data_json, '$.heroCategory'),
          JSON_EXTRACT(api_data_json, '$.category'),
          JSON_EXTRACT(api_data_json, '$.jobType')
        ) as category
      FROM jobs
      WHERE is_active = 1
        AND category IS NOT NULL
        AND category != ''
    `

    if (q) {
      query += ` AND LOWER(category) LIKE '%' || ? || '%'`
    }

    query += ` ORDER BY category LIMIT ?`

    const bindings = q ? [q, limit] : [limit]
    const result = await c.env.DB.prepare(query).bind(...bindings).all<{ category: string }>()

    const categories = result.results
      ?.map(r => r.category)
      .filter(c => c && c.trim()) || []

    const defaultCategories = [
      '경영/사무', '영업/마케팅', '연구개발', 'IT/소프트웨어', '디자인',
      '미디어/콘텐츠', '교육', '의료/보건', '법률/법무', '금융/보험',
      '건설/토목', '제조/생산', '물류/유통', '서비스', '예술/문화',
      '스포츠/레저', '농림어업', '공무원', '군인/경찰', '기타'
    ]

    const filtered = q
      ? defaultCategories.filter(c => c.toLowerCase().includes(q))
      : defaultCategories

    const allCategories = [...new Set([...categories, ...filtered])].slice(0, limit)

    return c.json({ success: true, categories: allCategories })
  } catch (error) {
    return c.json({ success: true, categories: [] })
  }
})

// 직업 이름 중복 체크
jobEditorRoutes.get('/api/job/check-name', async (c) => {
  try {
    const name = c.req.query('name')?.trim()

    if (!name) {
      return c.json({ success: false, error: '직업명이 필요합니다' }, 400)
    }

    if (name.length < 2) {
      return c.json({
        success: true,
        available: false,
        reason: '직업명은 최소 2자 이상이어야 합니다'
      })
    }

    const existing = await c.env.DB.prepare(`
      SELECT id, name FROM jobs
      WHERE LOWER(name) = LOWER(?) AND is_active = 1
      LIMIT 1
    `).bind(name).first<{ id: string; name: string }>()

    if (existing) {
      return c.json({
        success: true,
        available: false,
        reason: `이미 같은 이름의 직업이 존재합니다: "${existing.name}"`,
        existingId: existing.id,
        existingName: existing.name
      })
    }

    return c.json({ success: true, available: true })
  } catch (error) {
    return c.json({ success: false, error: '직업명 확인 중 오류가 발생했습니다' }, 500)
  }
})

// 직업 편집 (단일 필드 또는 다중 필드 지원)
jobEditorRoutes.post('/api/job/:id/edit', requireJobMajorEdit, async (c) => {
  try {
    const jobId = c.req.param('id')
    const user = getOptionalUser(c)
    let body: any

    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }

    const ipAddress = c.req.header('cf-connecting-ip') ?? null
    const ipHash = await hashIpAddress(ipAddress)

    // 다중 필드 편집 (새로운 방식)
    if (body.fields && typeof body.fields === 'object') {
      const fields = body.fields as Record<string, any>
      const sources = body.sources as Record<string, { url?: string; text?: string; delete?: boolean }> | undefined
      const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined

      if (fields['overviewWork.main']) {
      }

      if (Object.keys(fields).length === 0) {
        return c.json({ success: false, error: 'No fields to update' }, 400)
      }

      for (const [key, value] of Object.entries(fields)) {
        if (typeof value === 'string' && value.length > 7000) {
          return c.json({ success: false, error: `${key}: 최대 7000자까지 입력 가능합니다` }, 400)
        }
      }

      const job = await c.env.DB.prepare('SELECT * FROM jobs WHERE id = ? AND is_active = 1')
        .bind(jobId)
        .first()

      if (!job) {
        return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
      }

      let userData: Record<string, any> = {}
      try {
        userData = job.user_contributed_json ? JSON.parse(job.user_contributed_json as string) : {}
      } catch { userData = {} }

      const flattenToNested = (flatFields: Record<string, any>): Record<string, any> => {
        const result: Record<string, any> = {}
        for (const [key, value] of Object.entries(flatFields)) {
          const parts = key.split('.')
          let current = result
          for (let i = 0; i < parts.length - 1; i++) {
            if (!current[parts[i]]) current[parts[i]] = {}
            current = current[parts[i]]
          }
          current[parts[parts.length - 1]] = value
        }
        return result
      }

      const nestedFields = flattenToNested(fields)
      const deepMerge = (target: any, source: any): any => {
        for (const key of Object.keys(source)) {
          if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
            target[key] = deepMerge(target[key] || {}, source[key])
          } else {
            target[key] = source[key]
          }
        }
        return target
      }

      const updatedUserData = deepMerge({ ...userData }, nestedFields)

      const previousValues: Record<string, any> = {}
      for (const key of Object.keys(fields)) {
        const parts = key.split('.')
        let value: any = userData
        for (const part of parts) {
          value = value?.[part]
        }
        previousValues[key] = value ?? null
      }

      if (sources && Object.keys(sources).length > 0) {
        updatedUserData._sources = updatedUserData._sources || {}
        const existingIds: number[] = []
        Object.values(updatedUserData._sources).forEach((val: any) => {
          if (Array.isArray(val)) {
            val.forEach(v => v?.id && existingIds.push(v.id))
          } else if (val?.id) {
            existingIds.push(val.id)
          }
        })
        let nextId = Math.max(0, ...existingIds) + 1

        for (const [key, source] of Object.entries(sources)) {
          if ((source as any)?.delete) {
            delete updatedUserData._sources[key]
            continue
          }

          const sourceArray = Array.isArray(source)
            ? source
            : [source]
          const normalized = sourceArray
            .map((s: any) => (s?.text || s?.url || '').trim())
            .filter(Boolean)
            .map(text => ({ id: nextId++, text }))

          if (normalized.length > 0) {
            updatedUserData._sources[key] = normalized
          }
        }
      }

      if (updatedUserData._sources && Object.keys(updatedUserData._sources).length === 0) {
        delete updatedUserData._sources
      }

      const now = Date.now()

      let currentMerged: any = {}
      try {
        currentMerged = job.merged_profile_json ? JSON.parse(job.merged_profile_json as string) : {}
      } catch { /* ignore */ }

      if (currentMerged._sources) {
        delete currentMerged._sources
      }

      const deepMergeForUpdate = (target: any, source: any): any => {
        if (!source) return target
        if (!target) return source
        const result = { ...target }
        for (const key of Object.keys(source)) {
          if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
            result[key] = deepMergeForUpdate(result[key] || {}, source[key])
          } else if (source[key] !== undefined) {
            result[key] = source[key]
          }
        }
        return result
      }

      const updatedMerged = deepMergeForUpdate(currentMerged, updatedUserData)

      await c.env.DB.prepare(`
        UPDATE jobs SET user_contributed_json = ?, merged_profile_json = ?, user_last_updated_at = ?
        WHERE id = ?
      `).bind(JSON.stringify(updatedUserData), JSON.stringify(updatedMerged), now, jobId).run()

      const { createRevision, getCurrentRevision } = await import('../services/revisionService')

      const existingRevision = await getCurrentRevision(c.env.DB, 'job', jobId)
      if (!existingRevision) {
        await createRevision(c.env.DB, {
          entityType: 'job',
          entityId: jobId,
          dataSnapshot: previousValues,
          previousValues: {},
          editorId: null,
          editorType: 'system',
          editorName: '원본',
          ipHash: null,
          changeType: 'initial',
          changeSummary: '원본 버전',
          changedFields: Object.keys(previousValues),
          storeFullSnapshot: true
        })
      }

      const revision = await createRevision(c.env.DB, {
        entityType: 'job',
        entityId: jobId,
        dataSnapshot: fields,
        previousValues,
        editorId: user?.id?.toString() ?? null,
        editorType: (['user', 'expert', 'admin'].includes(user?.role || '') ? user?.role : 'anonymous') as 'user' | 'expert' | 'admin' | 'anonymous',
        editorName: user?.username ?? (ipHash ? `익명` : '익명 사용자'),
        ipHash: ipHash ?? null,
        changeType: 'edit',
        changeSummary: `${Object.keys(fields).length}개 필드 수정`,
        changedFields: Object.keys(fields),
        storeFullSnapshot: false
      })

      await invalidatePageCache(c.env.DB, { jobId, pageType: 'job' })

      return c.json({
        success: true,
        revisionId: revision.id,
        message: 'Edit saved successfully'
      })
    }

    // 단일 필드 편집 (기존 방식 호환)
    const field = typeof body.field === 'string' ? body.field : ''
    const content = typeof body.content === 'string' ? body.content : ''
    const source = typeof body.source === 'string' ? body.source : ''
    const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined
    const anonymous = Boolean(body.anonymous)
    const password = typeof body.password === 'string' ? body.password : undefined

    if (!field || !content) {
      return c.json({ success: false, error: 'field and content are required' }, 400)
    }

    const result = await editJob(c.env.DB, jobId, {
      field,
      content,
      source,
      changeSummary,
      anonymous,
      password,
      ipHash: ipHash ?? undefined,
      userId: user?.id?.toString(),
      editorType: user?.role as 'user' | 'expert' | 'admin' | undefined
    })

    await invalidatePageCache(c.env.DB, {
      jobId: jobId,
      pageType: 'job'
    })

    return c.json({
      success: true,
      revisionId: result.revisionId,
      message: 'Edit saved successfully'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'edit failed'
    const status = message.includes('NOT_FOUND') ? 404
      : message.includes('REQUIRED') || message.includes('INVALID') ? 400
      : message.includes('LIMIT') ? 403
      : 500

    return c.json({ success: false, error: message }, status)
  }
})

// 직업 숨기기/삭제 (운영자/관리자 전용)
jobEditorRoutes.delete('/api/job/:id', requireAuth, async (c) => {
  try {
    const jobId = c.req.param('id')
    const permanent = c.req.query('permanent') === 'true'
    const user = c.get('user')

    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }

    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }

    const job = await c.env.DB.prepare('SELECT id, name, is_active FROM jobs WHERE id = ?')
      .bind(jobId)
      .first<{ id: string; name: string; is_active: number }>()

    if (!job) {
      return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
    }

    await invalidatePageCache(c.env.DB, { jobId, pageType: 'job' })

    if (permanent) {
      const jobWithImage = await c.env.DB.prepare('SELECT image_url FROM jobs WHERE id = ?')
        .bind(jobId)
        .first<{ image_url: string | null }>()

      if (jobWithImage?.image_url && jobWithImage.image_url.startsWith('/uploads/') && c.env.UPLOADS) {
        const fileKey = jobWithImage.image_url.replace('/uploads/', '')
        try {
          await c.env.UPLOADS.delete(fileKey)
        } catch (e) {
        }
      }

      try {
        await c.env.DB.prepare('DELETE FROM revisions WHERE entity_type = ? AND entity_id = ?')
          .bind('job', jobId)
          .run()
      } catch (e) {
      }

      await c.env.DB.prepare('DELETE FROM jobs WHERE id = ?')
        .bind(jobId)
        .run()

      c.executionCtx.waitUntil(
        import('../services/ai-analyzer/auto-tagger').then(({ deleteJobAttributes }) =>
          deleteJobAttributes(c.env.DB, jobId)
        ).catch(() => {})
      )


      return c.json({
        success: true,
        message: `직업 "${job.name}"이(가) 완전히 삭제되었습니다. (복구 불가)`
      })
    } else {
      await c.env.DB.prepare('UPDATE jobs SET is_active = 0, user_last_updated_at = ? WHERE id = ?')
        .bind(Date.now(), jobId)
        .run()


      return c.json({
        success: true,
        message: `직업 "${job.name}"이(가) 숨겨졌습니다. (관리자만 볼 수 있음)`
      })
    }
  } catch (error) {
    return c.json({ success: false, error: 'DELETE_FAILED' }, 500)
  }
})

// 직업 복구 (운영자/관리자 전용)
jobEditorRoutes.post('/api/job/:id/restore', requireAuth, async (c) => {
  try {
    const jobId = c.req.param('id')
    const user = c.get('user')

    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }

    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }

    const job = await c.env.DB.prepare('SELECT id, name, is_active FROM jobs WHERE id = ?')
      .bind(jobId)
      .first<{ id: string; name: string; is_active: number }>()

    if (!job) {
      return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
    }

    if (job.is_active === 1) {
      return c.json({ success: false, error: 'ALREADY_ACTIVE' }, 400)
    }

    await c.env.DB.prepare('UPDATE jobs SET is_active = 1, user_last_updated_at = ? WHERE id = ?')
      .bind(Date.now(), jobId)
      .run()


    return c.json({
      success: true,
      message: `직업 "${job.name}"이(가) 복구되었습니다.`
    })
  } catch (error) {
    return c.json({ success: false, error: 'RESTORE_FAILED' }, 500)
  }
})

// ============================================================================
// Group D: Admin job/major
// ============================================================================

jobEditorRoutes.post('/api/admin/job', requireAdmin, async (c) => {
  try {
    const user = c.get('user')
    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }

    let body: any
    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }

    const id = typeof body.id === 'string' ? body.id.trim() : ''
    const name = typeof body.name === 'string' ? body.name.trim() : ''
    const summary = typeof body.summary === 'string' ? body.summary : undefined
    const duties = typeof body.duties === 'string' ? body.duties : undefined
    const salary = typeof body.salary === 'string' ? body.salary : undefined
    const prospect = typeof body.prospect === 'string' ? body.prospect : undefined
    const way = typeof body.way === 'string' ? body.way : undefined

    if (!id) {
      return c.json({ success: false, error: 'id is required' }, 400)
    }
    if (!name) {
      return c.json({ success: false, error: 'name is required' }, 400)
    }

    const result = await createJob(c.env.DB, {
      id,
      name,
      summary,
      duties,
      salary,
      prospect,
      way,
      userId: user.id.toString()
    })

    const openaiKey = (c.env as any).OPENAI_API_KEY
    if (openaiKey) {
      c.executionCtx.waitUntil(
        import('../services/ai-analyzer/auto-tagger').then(({ autoTagJob }) =>
          autoTagJob(c.env.DB, {
            id,
            name,
            admin_data_json: JSON.stringify({ summary, duties, salary, prospect, way }),
          }, openaiKey)
        ).catch(() => {})
      )
    }

    if (openaiKey && (c.env as any).VECTORIZE) {
      c.executionCtx.waitUntil(
        import('../services/ai-analyzer/vectorize-pipeline').then(({ indexSingleJob }) =>
          indexSingleJob(c.env.DB, (c.env as any).VECTORIZE, openaiKey, id)
        ).catch(() => {})
      )
    }

    return c.json({
      success: true,
      id: result.id,
      revisionId: result.revisionId,
      message: 'Job created successfully'
    }, 201)
  } catch (error) {
    const message = error instanceof Error ? error.message : 'create failed'

    const status = message.includes('REQUIRED') ? 400
      : message.includes('ALREADY_EXISTS') ? 409
      : message.includes('LOGIN') ? 401
      : 500

    return c.json({ success: false, error: message }, status)
  }
})

// ============================================================================
// Group L: Data refresh
// ============================================================================

jobEditorRoutes.post('/api/job/:id/refetch-api-data', authMiddleware, async (c) => {
  try {
    const jobIdParam = c.req.param('id')

    let jobId = jobIdParam
    let job = await c.env.DB.prepare('SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE id = ? AND is_active = 1')
      .bind(jobId)
      .first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()

    if (!job) {
      let extractedId = jobId
      if (jobId.includes(':')) {
        const parts = jobId.split(':')
        if (parts.length > 1) {
          extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          job = await c.env.DB.prepare('SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()

          if (job) {
            jobId = extractedId
          }
        }
      }

      if (!job) {
        const decodedSlug = decodeURIComponent(jobId)
        const normalizedSlug = decodedSlug.toLowerCase()

        job = await c.env.DB.prepare(
          'SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()

        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()
        }

        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(decodedSlug).first<{ id: string; name: string; careernet_id: string | null; goyong24_id: string | null }>()
        }

        if (job) {
          jobId = job.id
        }
      }
    }

    if (!job) {
      return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
    }


    const { getUnifiedJobDetailWithRawData } = await import('../services/profileDataService')
    const result = await getUnifiedJobDetailWithRawData(
      {
        id: jobId,
        careernetId: job.careernet_id || undefined,
        goyong24JobId: job.goyong24_id || undefined,
        includeSources: ['CAREERNET', 'GOYONG24']
      },
      c.env as any
    )

    if (!result.profile) {
      return c.json({ success: false, error: 'Failed to fetch data from API' }, 500)
    }

    const rawApiData = result.rawApiData || { careernet: null, goyong24: null }

    const now = Date.now()
    const apiDataJson = JSON.stringify(rawApiData)

    const normalized = JSON.stringify(rawApiData, Object.keys(rawApiData).sort())
    const encoder = new TextEncoder()
    const dataBuffer = encoder.encode(normalized)
    const hashBuffer = await crypto.subtle.digest('SHA-256', dataBuffer)
    const hashArray = Array.from(new Uint8Array(hashBuffer))
    const dataHash = hashArray.map(b => b.toString(16).padStart(2, '0')).join('')

    await c.env.DB.prepare(`
      UPDATE jobs
      SET api_data_json = ?, api_data_hash = ?, api_last_fetched_at = ?, api_last_updated_at = ?
      WHERE id = ?
    `).bind(apiDataJson, dataHash, now, now, jobId).run()

    const updateResult = { updated: true, changedFields: [] }

    await invalidatePageCache(c.env.DB, {
      jobId: jobId,
      pageType: 'job'
    })

    return c.json({
      success: true,
      message: 'API data refetched and saved successfully',
      updated: updateResult.updated,
      changedFields: updateResult.changedFields
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to refetch API data'
    return c.json({ success: false, error: message }, 500)
  }
})

jobEditorRoutes.post('/api/job/:id/reset-contributions', authMiddleware, async (c) => {
  try {
    const jobIdParam = c.req.param('id')

    let jobId = jobIdParam
    let job = await c.env.DB.prepare('SELECT id FROM jobs WHERE id = ? AND is_active = 1')
      .bind(jobId)
      .first<{ id: string }>()

    if (!job) {
      let extractedId = jobId
      if (jobId.includes(':')) {
        const parts = jobId.split(':')
        if (parts.length > 1) {
          extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          job = await c.env.DB.prepare('SELECT id FROM jobs WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first<{ id: string }>()

          if (job) {
            jobId = extractedId
          }
        }
      }

      if (!job) {
        const decodedSlug = decodeURIComponent(jobId)
        const normalizedSlug = decodedSlug.toLowerCase()

        job = await c.env.DB.prepare(
          'SELECT id FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first<{ id: string }>()

        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id FROM jobs WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first<{ id: string }>()
        }

        if (!job) {
          job = await c.env.DB.prepare(
            'SELECT id FROM jobs WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(decodedSlug).first<{ id: string }>()
        }

        if (job) {
          jobId = job.id
        }
      }
    }

    if (!job) {
      return c.json({ success: false, error: 'JOB_NOT_FOUND' }, 404)
    }

    const now = Date.now()
    await c.env.DB.prepare(`
      UPDATE jobs
      SET user_contributed_json = '{}', user_last_updated_at = ?
      WHERE id = ?
    `).bind(now, jobId).run()

    await invalidatePageCache(c.env.DB, {
      jobId: jobId,
      pageType: 'job'
    })

    return c.json({
      success: true,
      message: 'User contributions cleared. Original API data will now be displayed.'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to reset contributions'
    return c.json({ success: false, error: message }, 500)
  }
})

export { jobEditorRoutes }
