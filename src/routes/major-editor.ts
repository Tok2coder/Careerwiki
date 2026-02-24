/**
 * 전공 편집기 API 라우트
 * content-editor.ts에서 추출: 전공 CRUD, 관리자 생성, Reseed
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { authMiddleware, requireAuth, requireAdmin, requireJobMajorEdit } from '../middleware/auth'
import { editMajor, createMajor } from '../services/editService'
import { invalidatePageCache } from '../utils/page-cache'
import { getOptionalUser, hashIpAddress, escapeHtml } from '../utils/shared-helpers'
import type { R2Bucket } from '@cloudflare/workers-types'

const majorEditorRoutes = new Hono<AppEnv>()

// 전공 데이터 Reseed (admin)
majorEditorRoutes.post('/api/admin/reseed-empty-majors', async (c) => {
  const user = c.get('user')
  const isAdminUser = user && ((user.role as string) === 'admin' || (user.role as string) === 'super-admin' || (user.role as string) === 'operator')
  const secretHeader = c.req.header('X-Admin-Secret')
  const hasSecretAuth = secretHeader && c.env.ADMIN_SECRET && secretHeader === c.env.ADMIN_SECRET
  if (!isAdminUser && !hasSecretAuth) {
    return c.json({ error: 'Admin authentication required' }, 401)
  }
  try {
    const db = c.env.DB as import('@cloudflare/workers-types').D1Database
    const { searchMajors, getMajorDetail, normalizeCareerNetMajorDetail } = await import('../api/careernetAPI')

    const emptyMajors = await db.prepare(`
      SELECT id, name FROM majors
      WHERE is_active = 1
        AND (merged_profile_json IS NULL OR LENGTH(merged_profile_json) < 10)
      ORDER BY name
    `).all<{ id: string; name: string }>()

    if (!emptyMajors.results || emptyMajors.results.length === 0) {
      return c.json({ message: 'No empty majors found', total: 0 })
    }

    const results: Array<{ name: string; status: string; error?: string }> = []
    let successCount = 0
    let failedCount = 0

    for (const major of emptyMajors.results) {
      try {
        const searchResults = await searchMajors({ keyword: major.name, perPage: 20 }, c.env)

        if (!searchResults || searchResults.length === 0) {
          results.push({ name: major.name, status: 'not_found', error: 'No CareerNet results' })
          failedCount++
          continue
        }

        const exactMatch = searchResults.find((r: any) => {
          const mClass = (r.mClass || '').trim()
          return mClass === major.name || mClass === major.name.replace(/학과$|과$/, '')
        })
        const bestMatch = exactMatch || searchResults[0]
        const majorSeq = bestMatch.majorSeq

        if (!majorSeq) {
          results.push({ name: major.name, status: 'no_seq', error: 'No majorSeq in result' })
          failedCount++
          continue
        }

        const detail = await getMajorDetail(majorSeq, c.env)
        if (!detail) {
          results.push({ name: major.name, status: 'no_detail', error: 'Detail API returned null' })
          failedCount++
          continue
        }

        const normalized = normalizeCareerNetMajorDetail(detail)

        const merged: any = {
          ...normalized,
          name: major.name,
          heroSummary: normalized.summary ? normalized.summary.split(/[.?!。]/)[0]?.trim() + '.' : undefined,
          categoryName: (bestMatch as any).facilName || (normalized as any).category?.name || undefined,
          categoryDisplay: (bestMatch as any).facilName || (normalized as any).category?.name || undefined,
          majorGb: (bestMatch as any).majorGb || '1',
          sources: ['CAREERNET'],
          sourceIds: { careernet: majorSeq }
        }

        Object.keys(merged).forEach(key => {
          if (merged[key] === null || merged[key] === undefined || merged[key] === '') {
            delete merged[key]
          }
        })

        await db.prepare(`
          UPDATE majors
          SET merged_profile_json = ?, careernet_id = ?, primary_source = 'CAREERNET'
          WHERE id = ?
        `).bind(JSON.stringify(merged), majorSeq, major.id).run()

        results.push({ name: major.name, status: 'success' })
        successCount++

        await new Promise(resolve => setTimeout(resolve, 350))

      } catch (err) {
        const errMsg = err instanceof Error ? err.message : String(err)
        results.push({ name: major.name, status: 'error', error: errMsg })
        failedCount++
      }
    }

    const successNames = results.filter(r => r.status === 'success').map(r => r.name)
    if (successNames.length > 0 && c.env.DB) {
      try {
        for (const name of successNames) {
          await db.prepare(`DELETE FROM wiki_pages WHERE slug = ? AND page_type = 'major'`).bind(name).run()
        }
      } catch { /* cache invalidation is best-effort */ }
    }

    return c.json({
      total: emptyMajors.results.length,
      success: successCount,
      failed: failedCount,
      results
    })

  } catch (error) {
    const msg = error instanceof Error ? error.message : String(error)
    return c.json({ error: 'Reseed failed', details: msg }, 500)
  }
})

// ============================================================================
// Group C: Major CRUD (static paths first)
// ============================================================================

// 전공 생성 (일반 사용자)
majorEditorRoutes.post('/api/major/create', requireAuth, async (c) => {
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
    const categoryName = typeof body.categoryName === 'string' ? body.categoryName.trim() : ''

    if (!name || name.length < 2) {
      return c.json({ success: false, error: '전공명은 최소 2자 이상이어야 합니다' }, 400)
    }
    if (!summary || summary.length < 2) {
      return c.json({ success: false, error: '설명은 최소 2자 이상이어야 합니다' }, 400)
    }

    const slug = name.replace(/[\s\-\/\.·ㆍ,()]+/g, '-').toLowerCase()
    const id = `U_${slug}_${Date.now().toString(36)}`

    const existing = await c.env.DB.prepare(
      'SELECT id FROM majors WHERE name = ? AND is_active = 1'
    ).bind(name).first()

    if (existing) {
      return c.json({ success: false, error: '이미 존재하는 전공입니다' }, 400)
    }

    const userData: Record<string, any> = {
      summary
    }
    if (heroTags.length > 0) {
      userData.heroTags = [...new Set(heroTags.filter((t: any) => typeof t === 'string' && t.trim()))]
    }
    if (categoryName) {
      userData.categoryName = categoryName
    }

    const mergedProfile = {
      id,
      name,
      summary,
      overview: { summary },
      heroTags: userData.heroTags || [],
      categoryName: userData.categoryName || '',
      source: 'USER' as const
    }

    const urlSlug = name.replace(/[\s]+/g, '-').toLowerCase()

    const now = Date.now()

    await c.env.DB.prepare(`
      INSERT INTO majors (id, name, slug, user_contributed_json, merged_profile_json, user_last_updated_at, created_at, is_active, primary_source)
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

    const { createRevision } = await import('../services/revisionService')
    await createRevision(c.env.DB, {
      entityType: 'major',
      entityId: id,
      dataSnapshot: { id, name, ...userData },
      editorId: user.id.toString(),
      editorType: user.role as 'user' | 'expert' | 'admin',
      editorName: user.username || `User ${user.id}`,
      changeType: 'initial',
      changeSummary: '전공 생성',
      changedFields: Object.keys(userData),
      storeFullSnapshot: true
    })

    let imageUrl: string | undefined
    let imagePrompt: string | undefined

    const geminiKey = (c.env as any).GEMINI_API_KEY
    const evolinkKey = (c.env as any).EVOLINK_API_KEY
    const uploadsR2 = (c.env as any).UPLOADS as R2Bucket | undefined

    if (geminiKey && evolinkKey && uploadsR2) {
      try {
        const { generateMajorImage } = await import('../services/autoImageService')
        const baseUrl = new URL(c.req.url).origin

        const imageResult = await generateMajorImage(
          { GEMINI_API_KEY: geminiKey, EVOLINK_API_KEY: evolinkKey, UPLOADS: uploadsR2 },
          name,
          urlSlug,
          baseUrl
        )

        if (imageResult.success) {
          imageUrl = imageResult.imageUrl
          imagePrompt = imageResult.imagePrompt

          await c.env.DB.prepare(`
            UPDATE majors SET image_url = ?, image_prompt = ? WHERE id = ?
          `).bind(imageUrl, imagePrompt, id).run()

        } else {
          if (imageResult.imagePrompt) {
            await c.env.DB.prepare(`
              UPDATE majors SET image_prompt = ? WHERE id = ?
            `).bind(imageResult.imagePrompt, id).run()
            imagePrompt = imageResult.imagePrompt
          }
        }
      } catch (imageError) {
      }
    } else {
    }

    const openaiKeyForIdx = (c.env as any).OPENAI_API_KEY
    if (openaiKeyForIdx && (c.env as any).VECTORIZE) {
      c.executionCtx.waitUntil(
        import('../services/ai-analyzer/vectorize-pipeline').then(({ indexSingleMajor }) =>
          indexSingleMajor(c.env.DB, (c.env as any).VECTORIZE, openaiKeyForIdx, id)
        ).catch(() => {})
      )
    }

    return c.json({
      success: true,
      id,
      slug: urlSlug,
      imageUrl,
      imagePrompt,
      message: '전공이 생성되었습니다'
    }, 201)

  } catch (error) {
    const message = error instanceof Error ? error.message : 'create failed'
    return c.json({ success: false, error: message }, 500)
  }
})

// 숨겨진 전공 목록 조회 (운영자/관리자 전용)
majorEditorRoutes.get('/api/major/hidden', requireAuth, async (c) => {
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

    const majors = await c.env.DB.prepare(`
      SELECT id, name, slug, user_last_updated_at
      FROM majors
      WHERE is_active = 0
      ORDER BY user_last_updated_at DESC
    `).all<{ id: string; name: string; slug: string | null; user_last_updated_at: number }>()

    return c.json({
      success: true,
      majors: majors.results || []
    })
  } catch (error) {
    return c.json({ success: false, error: 'FETCH_FAILED' }, 500)
  }
})

// 전공 계열 목록 조회
majorEditorRoutes.get('/api/major/categories', async (c) => {
  try {
    const q = c.req.query('q')?.trim().toLowerCase() || ''
    const limit = parseInt(c.req.query('limit') || '20')

    let query = `
      SELECT DISTINCT
        COALESCE(
          JSON_EXTRACT(user_contributed_json, '$.categoryName'),
          JSON_EXTRACT(admin_data_json, '$.categoryName'),
          JSON_EXTRACT(api_data_json, '$.facilMajorCategory')
        ) as category
      FROM majors
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
      '인문계열', '사회계열', '교육계열', '공학계열', '자연계열',
      '의약계열', '예체능계열', '농림수산계열'
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

// 전공 이름 중복 체크
majorEditorRoutes.get('/api/major/check-name', async (c) => {
  try {
    const name = c.req.query('name')?.trim()

    if (!name) {
      return c.json({ success: false, error: '전공명이 필요합니다' }, 400)
    }

    if (name.length < 2) {
      return c.json({
        success: true,
        available: false,
        reason: '전공명은 최소 2자 이상이어야 합니다'
      })
    }

    const existing = await c.env.DB.prepare(`
      SELECT id, name FROM majors
      WHERE LOWER(name) = LOWER(?) AND is_active = 1
      LIMIT 1
    `).bind(name).first<{ id: string; name: string }>()

    if (existing) {
      return c.json({
        success: true,
        available: false,
        reason: `이미 같은 이름의 전공이 존재합니다: "${existing.name}"`,
        existingId: existing.id,
        existingName: existing.name
      })
    }

    return c.json({ success: true, available: true })
  } catch (error) {
    return c.json({ success: false, error: '전공명 확인 중 오류가 발생했습니다' }, 500)
  }
})

// 전공 편집 (단일 필드 또는 다중 필드 지원)
majorEditorRoutes.post('/api/major/:id/edit', requireJobMajorEdit, async (c) => {
  try {
    const majorIdParam = c.req.param('id')
    const user = getOptionalUser(c)
    let body: any

    try {
      body = await c.req.json()
    } catch {
      return c.json({ success: false, error: 'invalid json body' }, 400)
    }

    const ipAddress = c.req.header('cf-connecting-ip') ?? null
    const ipHash = await hashIpAddress(ipAddress)

    let majorId = majorIdParam
    let majorRecord = await c.env.DB.prepare('SELECT * FROM majors WHERE id = ? AND is_active = 1')
      .bind(majorId)
      .first()

    if (!majorRecord) {
      let extractedId = majorId
      if (majorId.includes(':')) {
        const parts = majorId.split(':')
        if (parts.length > 1) {
          extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
          majorRecord = await c.env.DB.prepare('SELECT * FROM majors WHERE id = ? AND is_active = 1')
            .bind(extractedId)
            .first()
          if (majorRecord) majorId = extractedId
        }
      }

      if (!majorRecord) {
        const decodedSlug = decodeURIComponent(majorId)
        const normalizedSlug = decodedSlug.toLowerCase()

        majorRecord = await c.env.DB.prepare(
          'SELECT * FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first()

        if (!majorRecord) {
          majorRecord = await c.env.DB.prepare(
            'SELECT * FROM majors WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
          ).bind(normalizedSlug).first()
        }

        if (!majorRecord) {
          majorRecord = await c.env.DB.prepare(
            'SELECT * FROM majors WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(decodedSlug).first()
        }

        if (majorRecord) majorId = majorRecord.id as string
      }
    }

    if (!majorRecord) {
      return c.json({ success: false, error: 'MAJOR_NOT_FOUND' }, 404)
    }

    // 다중 필드 편집 (새로운 방식)
    if (body.fields && typeof body.fields === 'object') {
      const fields = body.fields as Record<string, any>
      const sources = body.sources as Record<string, { url?: string; text?: string; delete?: boolean }> | undefined
      const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined

      if (Object.keys(fields).length === 0) {
        return c.json({ success: false, error: 'No fields to update' }, 400)
      }

      for (const [key, value] of Object.entries(fields)) {
        if (typeof value === 'string' && value.length > 7000) {
          return c.json({ success: false, error: `${key}: 최대 7000자까지 입력 가능합니다` }, 400)
        }
      }

      let userData: Record<string, any> = {}
      try {
        userData = majorRecord.user_contributed_json ? JSON.parse(majorRecord.user_contributed_json as string) : {}
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
      if (nestedFields.trivia && updatedUserData.jobProspect) {
        delete updatedUserData.jobProspect
      }

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
        currentMerged = majorRecord.merged_profile_json ? JSON.parse(majorRecord.merged_profile_json as string) : {}
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

      if (updatedUserData.trivia && updatedMerged.jobProspect) {
        delete updatedMerged.jobProspect
      }

      await c.env.DB.prepare(`
        UPDATE majors SET user_contributed_json = ?, merged_profile_json = ?, user_last_updated_at = ?
        WHERE id = ?
      `).bind(JSON.stringify(updatedUserData), JSON.stringify(updatedMerged), now, majorId).run()

      const { createRevision, getCurrentRevision } = await import('../services/revisionService')

      const existingRevision = await getCurrentRevision(c.env.DB, 'major', majorId)
      if (!existingRevision) {
        const originalSnapshot = currentMerged || {}
        await createRevision(c.env.DB, {
          entityType: 'major',
          entityId: majorId,
          dataSnapshot: originalSnapshot,
          previousValues: {},
          editorId: null,
          editorType: 'system',
          editorName: '원본',
          ipHash: null,
          changeType: 'initial',
          changeSummary: '원본 버전',
          changedFields: Object.keys(originalSnapshot),
          storeFullSnapshot: true
        })
      }

      const revision = await createRevision(c.env.DB, {
        entityType: 'major',
        entityId: majorId,
        dataSnapshot: updatedMerged,
        previousValues,
        editorId: user?.id?.toString() ?? null,
        editorType: (['user', 'expert', 'admin'].includes(user?.role || '') ? user?.role : 'anonymous') as 'user' | 'expert' | 'admin' | 'anonymous',
        editorName: user?.username ?? (ipHash ? `익명` : '익명 사용자'),
        ipHash: ipHash ?? null,
        changeType: 'edit',
        changeSummary: `${Object.keys(fields).length}개 필드 수정`,
        changedFields: Object.keys(fields),
        storeFullSnapshot: true
      })

      await invalidatePageCache(c.env.DB, { majorId, pageType: 'major' })

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

    const result = await editMajor(c.env.DB, majorId, {
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
      majorId: majorId,
      pageType: 'major'
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

// 전공 숨기기/삭제 (운영자/관리자 전용)
majorEditorRoutes.delete('/api/major/:id', requireAuth, async (c) => {
  try {
    const majorId = c.req.param('id')
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

    const major = await c.env.DB.prepare('SELECT id, name, is_active FROM majors WHERE id = ?')
      .bind(majorId)
      .first<{ id: string; name: string; is_active: number }>()

    if (!major) {
      return c.json({ success: false, error: 'MAJOR_NOT_FOUND' }, 404)
    }

    await invalidatePageCache(c.env.DB, { majorId, pageType: 'major' })

    if (permanent) {
      const majorWithImage = await c.env.DB.prepare('SELECT image_url FROM majors WHERE id = ?')
        .bind(majorId)
        .first<{ image_url: string | null }>()

      if (majorWithImage?.image_url && majorWithImage.image_url.startsWith('/uploads/') && c.env.UPLOADS) {
        const fileKey = majorWithImage.image_url.replace('/uploads/', '')
        try {
          await c.env.UPLOADS.delete(fileKey)
        } catch (e) {
        }
      }

      try {
        await c.env.DB.prepare('DELETE FROM revisions WHERE entity_type = ? AND entity_id = ?')
          .bind('major', majorId)
          .run()
      } catch (e) {
      }

      await c.env.DB.prepare('DELETE FROM majors WHERE id = ?')
        .bind(majorId)
        .run()


      return c.json({
        success: true,
        message: `전공 "${major.name}"이(가) 완전히 삭제되었습니다. (복구 불가)`
      })
    } else {
      await c.env.DB.prepare('UPDATE majors SET is_active = 0, user_last_updated_at = ? WHERE id = ?')
        .bind(Date.now(), majorId)
        .run()


      return c.json({
        success: true,
        message: `전공 "${major.name}"이(가) 숨겨졌습니다. (관리자만 볼 수 있음)`
      })
    }
  } catch (error) {
    return c.json({ success: false, error: 'DELETE_FAILED' }, 500)
  }
})

// 전공 복구 (운영자/관리자 전용)
majorEditorRoutes.post('/api/major/:id/restore', requireAuth, async (c) => {
  try {
    const majorId = c.req.param('id')
    const user = c.get('user')

    if (!user) {
      return c.json({ success: false, error: 'LOGIN_REQUIRED' }, 401)
    }

    const role = user.role as string
    const isAdmin = role === 'super-admin' || role === 'operator' || role === 'admin'
    if (!isAdmin) {
      return c.json({ success: false, error: 'ADMIN_ONLY' }, 403)
    }

    const major = await c.env.DB.prepare('SELECT id, name, is_active FROM majors WHERE id = ?')
      .bind(majorId)
      .first<{ id: string; name: string; is_active: number }>()

    if (!major) {
      return c.json({ success: false, error: 'MAJOR_NOT_FOUND' }, 404)
    }

    if (major.is_active === 1) {
      return c.json({ success: false, error: 'ALREADY_ACTIVE' }, 400)
    }

    await c.env.DB.prepare('UPDATE majors SET is_active = 1, user_last_updated_at = ? WHERE id = ?')
      .bind(Date.now(), majorId)
      .run()


    return c.json({
      success: true,
      message: `전공 "${major.name}"이(가) 복구되었습니다.`
    })
  } catch (error) {
    return c.json({ success: false, error: 'RESTORE_FAILED' }, 500)
  }
})

majorEditorRoutes.post('/api/admin/major', requireAdmin, async (c) => {
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
    const property = typeof body.property === 'string' ? body.property : undefined
    const aptitude = typeof body.aptitude === 'string' ? body.aptitude : undefined
    const whatStudy = typeof body.whatStudy === 'string' ? body.whatStudy : undefined
    const howPrepare = typeof body.howPrepare === 'string' ? body.howPrepare : undefined
    const enterField = typeof body.enterField === 'string' ? body.enterField : undefined

    if (!id) {
      return c.json({ success: false, error: 'id is required' }, 400)
    }
    if (!name) {
      return c.json({ success: false, error: 'name is required' }, 400)
    }

    const result = await createMajor(c.env.DB, {
      id,
      name,
      summary,
      property,
      aptitude,
      whatStudy,
      howPrepare,
      enterField,
      userId: user.id.toString()
    })

    const openaiKeyForIdx = (c.env as any).OPENAI_API_KEY
    if (openaiKeyForIdx && (c.env as any).VECTORIZE) {
      c.executionCtx.waitUntil(
        import('../services/ai-analyzer/vectorize-pipeline').then(({ indexSingleMajor }) =>
          indexSingleMajor(c.env.DB, (c.env as any).VECTORIZE, openaiKeyForIdx, id)
        ).catch(() => {})
      )
    }

    return c.json({
      success: true,
      id: result.id,
      revisionId: result.revisionId,
      message: 'Major created successfully'
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

export { majorEditorRoutes }
