/**
 * 콘텐츠 편집기 API 라우트 (공통)
 * 슬러그, 검색, 태그, 리비전, 유사 이름, 사용자 관리
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { authMiddleware, requireAuth, requireAdmin } from '../middleware/auth'
import { getRevisionById, listRevisions, restoreRevision } from '../services/revisionService'
import { findSimilarNames, saveNameMappings, deleteNameMapping, getExistingMappings } from '../services/similarNamesService'
import { invalidatePageCache } from '../utils/page-cache'
import { renderAdminSimilarNamesPage } from '../templates/adminSimilarNames'
import { getOptionalUser, hashIpAddress, escapeHtml } from '../utils/shared-helpers'

const contentEditorRoutes = new Hono<AppEnv>()

// ============================================================================
// Group A: User/Admin management
// ============================================================================

contentEditorRoutes.patch('/api/user/username', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'Unauthorized' }, 401)
  }

  try {
    const body = await c.req.json() as { username?: string }

    if (!body.username) {
      return c.json({ success: false, error: 'Username is required' }, 400)
    }

    const { updateUsername } = await import('../utils/auth-helpers')
    await updateUsername(c.env.DB, user.id, body.username)

    return c.json({ success: true, message: 'Username updated successfully' })
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : 'Failed to update username'
    return c.json({ success: false, error: errorMessage }, 400)
  }
})

// Admin API: Seed all jobs to D1
contentEditorRoutes.post('/api/admin/seed-jobs', requireAdmin, async (c) => {
  const background = c.req.query('background') === 'true'

  try {
    return c.json({
      error: 'This endpoint is deprecated. Please use the new ETL scripts in src/scripts/etl/'
    }, 501)
  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : String(error)
    return c.json({
      error: 'Failed to start seed',
      details: errorMessage
    }, 500)
  }
})

// Admin API: Re-seed empty majors from CareerNet API

// ============================================================================
// Group F: Slug/Search validation
// ============================================================================

contentEditorRoutes.get('/api/slug/check', authMiddleware, async (c) => {
  try {
    const title = c.req.query('title')
    const excludeId = c.req.query('excludeId')

    if (!title) {
      return c.json({ success: false, error: 'title 파라미터가 필요합니다' }, 400)
    }

    const { checkAndGenerateUniqueSlug, generateSlug } = await import('../services/slugService')

    const baseSlug = generateSlug(title)

    const result = await checkAndGenerateUniqueSlug(
      c.env.DB,
      title,
      excludeId ? parseInt(excludeId) : undefined
    )

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 400)
    }

    return c.json({
      success: true,
      baseSlug,
      slug: result.slug,
      isUnique: result.isUnique,
      hasSuffix: result.slug !== baseSlug
    })
  } catch (error) {
    return c.json({ success: false, error: '슬러그 생성 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.get('/api/slug/validate', authMiddleware, async (c) => {
  try {
    const slug = c.req.query('slug')

    if (!slug) {
      return c.json({ success: false, error: 'slug 파라미터가 필요합니다' }, 400)
    }

    const { validateSlug } = await import('../services/slugService')
    const result = validateSlug(slug)

    return c.json({ success: true, valid: result.valid, error: result.error })
  } catch (error) {
    return c.json({ success: false, error: '검증 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.get('/api/search', authMiddleware, async (c) => {
  try {
    const domain = c.req.query('domain') as 'jobs' | 'majors' | 'howtos' | 'tags'
    const query = c.req.query('q') || ''
    const limit = parseInt(c.req.query('limit') || '10')
    const typeahead = c.req.query('typeahead') !== 'false'

    if (!domain || !['jobs', 'majors', 'howtos', 'tags'].includes(domain)) {
      return c.json({ success: false, error: 'domain 파라미터가 필요합니다 (jobs, majors, howtos, tags)' }, 400)
    }

    const { search } = await import('../services/searchService')
    const result = await search(c.env.DB, { domain, query, limit, typeahead })

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }

    return c.json({ success: true, results: result.results })
  } catch (error) {
    return c.json({ success: false, error: '검색 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.get('/api/search/validate', authMiddleware, async (c) => {
  try {
    const domain = c.req.query('domain') as 'jobs' | 'majors' | 'howtos' | 'tags'
    const id = c.req.query('id')

    if (!domain || !id) {
      return c.json({ success: false, error: 'domain과 id 파라미터가 필요합니다' }, 400)
    }

    const { validateExists } = await import('../services/searchService')
    const result = await validateExists(c.env.DB, domain, id)

    return c.json({ success: true, exists: result.exists, data: result.data })
  } catch (error) {
    return c.json({ success: false, error: '검증 중 오류가 발생했습니다' }, 500)
  }
})

// ============================================================================
// Group G: Tags & Categories (already added above except popular tags and check-title)
// ============================================================================

contentEditorRoutes.get('/api/tags/popular', async (c) => {
  try {
    const limit = parseInt(c.req.query('limit') || '20')

    const { getPopularTags } = await import('../services/searchService')
    const result = await getPopularTags(c.env.DB, limit)

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }

    return c.json({ success: true, tags: result.tags })
  } catch (error) {
    return c.json({ success: false, error: '태그 조회 중 오류가 발생했습니다' }, 500)
  }
})


// ============================================================================
// Group K: Revisions
// ============================================================================

contentEditorRoutes.get('/api/revision/:id', authMiddleware, async (c) => {
  try {
    const revisionId = Number(c.req.param('id'))
    const includeFullData = c.req.query('fullData') === 'true'
    const formatForEdit = c.req.query('formatForEdit') === 'true'

    if (!Number.isFinite(revisionId) || revisionId <= 0) {
      return c.json({ success: false, error: 'invalid revision id' }, 400)
    }

    const revision = await getRevisionById(c.env.DB, revisionId)

    if (!revision) {
      return c.json({ success: false, error: 'revision not found' }, 404)
    }

    let fullData = null
    let editFormattedData = null

    if (includeFullData) {
      const { reconstructFullData } = await import('../services/revisionService')
      try {
        const snapshot = JSON.parse(revision.dataSnapshot)

        if (snapshot.changedFields !== undefined) {
          if (revision.entityType === 'job' || revision.entityType === 'major' || revision.entityType === 'howto') {
            fullData = await reconstructFullData(
              c.env.DB,
              revision.entityType,
              revision.entityId,
              revision.revisionNumber
            )
          } else {
            fullData = snapshot
          }
        } else {
          fullData = snapshot
        }

        if (formatForEdit && revision.entityType === 'job' && fullData) {
          const { mergeJobData } = await import('../services/jobDataMerger')

          let rawApiData: { careernet: any; goyong24: any } = { careernet: null, goyong24: null }
          if (fullData.careernet !== undefined || fullData.goyong24 !== undefined) {
            rawApiData = {
              careernet: fullData.careernet || null,
              goyong24: fullData.goyong24 || null
            }
          } else {
            rawApiData = fullData as any
          }

          const mergedData = mergeJobData(rawApiData)

          const profile = {
            name: fullData.name || '',
            summary: fullData.summary || (rawApiData?.goyong24 as any)?.duty?.jobSum || '',
            duties: fullData.duties || '',
            way: fullData.way || '',
            salary: fullData.salary || '',
            prospect: fullData.prospect || '',
            satisfaction: fullData.satisfaction || '',
            status: fullData.status || '',
            abilities: fullData.abilities || '',
            knowledge: fullData.knowledge || '',
            environment: fullData.environment || '',
            personality: fullData.personality || '',
            interests: fullData.interests || '',
            values: fullData.values || '',
            technKnow: fullData.technKnow || '',
            aptitudeList: fullData.aptitudeList || [],
            educationDistribution: fullData.educationDistribution || null,
            majorDistribution: fullData.majorDistribution || null
          }

          const summaryForEdit = profile.summary || (rawApiData?.goyong24 as any)?.duty?.jobSum || ''
          const workSummary = mergedData.work.summary || profile.summary || ''

          const workSimple = mergedData.work.simple
          let duties = ''
          if (workSimple && Array.isArray(workSimple) && workSimple.length > 0) {
            duties = workSimple
              .map((item: any) => {
                const text = typeof item === 'string' ? item : item.work || item.list_content || ''
                return text?.trim() || ''
              })
              .filter(Boolean)
              .join('\n')
          } else if (profile.duties?.trim()) {
            duties = profile.duties
          }

          const tagList = (rawApiData?.careernet as any)?.encyclopedia?.tagList || []
          const tagText = Array.isArray(tagList)
            ? tagList.map((tag: any) => {
                const tagText = typeof tag === 'string' ? tag : (tag?.tag || tag?.list_content || '')
                return tagText?.trim() || ''
              }).filter(Boolean).join('\n')
            : ''

          let heroTags: string[] = []
          if (Array.isArray(fullData.heroTags)) {
            heroTags = fullData.heroTags
          } else if (Array.isArray(tagList) && tagList.length > 0) {
            heroTags = tagList.map((tag: any) => {
              if (typeof tag === 'string') return tag.trim()
              return (tag?.tag || tag?.list_content || '').trim()
            }).filter(Boolean)
          }

          let heroCategory = ''
          if (typeof fullData.heroCategory === 'string') {
            heroCategory = fullData.heroCategory
          } else if (fullData.heroCategory?.value) {
            heroCategory = fullData.heroCategory.value
          } else if (fullData.heroCategory?.large) {
            heroCategory = fullData.heroCategory.large
          }

          editFormattedData = {
            name: profile.name || '',
            summary: summaryForEdit,
            heroTags: heroTags,
            heroCategory: heroCategory,
            duties: duties,
            way: profile.way || '',
            salary: mergedData.salary.primary || profile.salary || '',
            prospect: mergedData.prospect.primary || profile.prospect || '',
            satisfaction: mergedData.satisfaction.primary || profile.satisfaction || '',
            status: profile.status || '',
            abilities: profile.abilities || '',
            knowledge: profile.knowledge || '',
            environment: profile.environment || '',
            personality: profile.personality || '',
            interests: profile.interests || '',
            values: profile.values || '',
            technKnow: profile.technKnow || '',
            aptitude: profile.aptitudeList?.map((item: any) => item.name || '').join('\n') || '',
            educationDistribution: profile.educationDistribution ? JSON.stringify(profile.educationDistribution, null, 2) : '',
            majorDistribution: profile.majorDistribution ? JSON.stringify(profile.majorDistribution, null, 2) : '',
            tags: tagText,
            workSummary: workSummary
          }
        }
      } catch (error) {
      }
    }

    return c.json({
      success: true,
      data: {
        ...revision,
        fullData,
        editFormattedData
      }
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to get revision'
    return c.json({ success: false, error: message }, 500)
  }
})

contentEditorRoutes.get('/api/job/:id/revisions', authMiddleware, async (c) => {
  try {
    const jobIdParam = c.req.param('id')
    const limit = parseInt(c.req.query('limit') || '20', 10)
    const offset = parseInt(c.req.query('offset') || '0', 10)

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

    const result = await listRevisions(c.env.DB, 'job', jobId, {
      limit: Math.min(Math.max(limit, 1), 100),
      offset: Math.max(offset, 0)
    })

    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to list revisions'
    return c.json({ success: false, error: message }, 500)
  }
})

contentEditorRoutes.get('/api/major/:id/revisions', authMiddleware, async (c) => {
  try {
    let majorId = c.req.param('id')
    const limit = parseInt(c.req.query('limit') || '20', 10)
    const offset = parseInt(c.req.query('offset') || '0', 10)

    if (c.env.DB && majorId) {
      try {
        const db = c.env.DB

        if (majorId.includes(':')) {
          const parts = majorId.split(':')
          if (parts.length > 1) {
            const sourceId = parts[parts.length - 1].replace(/^C_/, '').replace(/^G_/, '')
            const dbResult = await db.prepare(
              'SELECT id FROM majors WHERE careernet_id = ? OR goyong24_id = ? LIMIT 1'
            ).bind(sourceId, sourceId).first() as { id: string } | null
            if (dbResult?.id) {
              majorId = dbResult.id
            }
          }
        } else {
          let dbResult = await db.prepare(
            'SELECT id FROM majors WHERE id = ? AND is_active = 1 LIMIT 1'
          ).bind(majorId).first() as { id: string } | null

          if (!dbResult) {
            const decodedSlug = decodeURIComponent(majorId)
            const normalizedSlug = decodedSlug.toLowerCase()
            dbResult = await db.prepare(
              'SELECT id FROM majors WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
            ).bind(normalizedSlug).first() as { id: string } | null

            if (dbResult?.id) {
              majorId = dbResult.id
            }
          }
        }
      } catch (dbError) {
      }
    }

    const result = await listRevisions(c.env.DB, 'major', majorId, {
      limit: Math.min(Math.max(limit, 1), 100),
      offset: Math.max(offset, 0)
    })


    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to list revisions'
    return c.json({ success: false, error: message }, 500)
  }
})

contentEditorRoutes.get('/api/howto/:slug/revisions', authMiddleware, async (c) => {
  try {
    const slug = c.req.param('slug')
    const limit = parseInt(c.req.query('limit') || '20', 10)
    const offset = parseInt(c.req.query('offset') || '0', 10)

    const howto = await c.env.DB.prepare(
      'SELECT slug FROM pages WHERE slug = ? AND page_type = \'guide\' AND status = \'published\''
    ).bind(slug).first()

    if (!howto) {
      return c.json({ success: false, error: 'HOWTO_NOT_FOUND' }, 404)
    }

    const result = await listRevisions(c.env.DB, 'howto', slug, {
      limit: Math.min(Math.max(limit, 1), 100),
      offset: Math.max(offset, 0)
    })

    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'failed to list revisions'
    return c.json({ success: false, error: message }, 500)
  }
})

contentEditorRoutes.post('/api/revision/:id/restore', authMiddleware, async (c) => {
  try {
    const revisionId = Number(c.req.param('id'))
    const user = getOptionalUser(c)
    let body: any

    try {
      body = await c.req.json()
    } catch {
      body = {}
    }

    if (!Number.isFinite(revisionId) || revisionId <= 0) {
      return c.json({ success: false, error: 'invalid revision id' }, 400)
    }

    const password = typeof body.password === 'string' ? body.password : undefined

    const targetRevision = await getRevisionById(c.env.DB, revisionId)
    if (targetRevision?.editorType === 'anonymous' && targetRevision.passwordHash) {
      if (!password) {
        return c.json({ success: false, error: 'PASSWORD_REQUIRED' }, 403)
      }

      const { verifyEditPassword } = await import('../utils/anonymousEdit')
      const isValid = await verifyEditPassword(password, targetRevision.passwordHash)
      if (!isValid) {
        return c.json({ success: false, error: 'INVALID_PASSWORD' }, 403)
      }
    }

    const revision = await restoreRevision(
      c.env.DB,
      revisionId,
      user?.id?.toString() ?? null,
      password,
      user?.username ?? user?.name ?? null
    )

    await invalidatePageCache(c.env.DB, {
      jobId: revision.entityType === 'job' ? revision.entityId : undefined,
      majorId: revision.entityType === 'major' ? revision.entityId : undefined,
      slug: revision.entityType === 'howto' ? revision.entityId : undefined,
      pageType: revision.entityType === 'howto' ? 'guide' : revision.entityType
    })

    return c.json({
      success: true,
      revisionId: revision.id,
      message: 'Revision restored successfully'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'restore failed'
    const status = message.includes('NOT_FOUND') ? 404
      : message.includes('REQUIRED') || message.includes('UNAUTHORIZED') ? 403
      : message.includes('INVALID') ? 400
      : 500

    return c.json({ success: false, error: message }, status)
  }
})

// ============================================================================
// Group M: Similar names
// ============================================================================

contentEditorRoutes.get('/similar-names', async (c) => {
  const typeParam = c.req.query('type') || 'job'
  const type = typeParam === 'major' ? 'major' : 'job'

  return c.html(renderAdminSimilarNamesPage({ type }))
})

contentEditorRoutes.get('/api/similar-names/:type', async (c) => {
  try {
    const type = c.req.param('type') as 'job' | 'major'
    if (type !== 'job' && type !== 'major') {
      return c.json({ success: false, error: 'Invalid type. Must be "job" or "major".' }, 400)
    }

    const minScoreParam = c.req.query('minScore')
    const minScore = minScoreParam ? parseFloat(minScoreParam) : 0.7

    if (isNaN(minScore) || minScore < 0 || minScore > 1) {
      return c.json({ success: false, error: 'minScore must be between 0 and 1' }, 400)
    }

    const result = await findSimilarNames(c.env.DB, type, minScore)

    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to find similar names'
    return c.json({ success: false, error: message }, 500)
  }
})

contentEditorRoutes.post('/api/name-mappings', async (c) => {
  try {
    const body = await c.req.json<{
      mappings: Array<{
        type: 'job' | 'major'
        sourceName: string
        targetName: string
        similarityScore?: number
        matchReason?: string
      }>
    }>()

    if (!body.mappings || !Array.isArray(body.mappings) || body.mappings.length === 0) {
      return c.json({ success: false, error: 'mappings array is required' }, 400)
    }

    for (const mapping of body.mappings) {
      if (!mapping.type || !['job', 'major'].includes(mapping.type)) {
        return c.json({ success: false, error: 'Invalid type in mapping' }, 400)
      }
      if (!mapping.sourceName || !mapping.targetName) {
        return c.json({ success: false, error: 'sourceName and targetName are required' }, 400)
      }
    }

    const user = c.get('user')
    const createdBy = user ? String(user.id) : 'admin'

    const result = await saveNameMappings(c.env.DB, body.mappings, createdBy)

    return c.json({
      success: true,
      data: result
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to save mappings'
    return c.json({ success: false, error: message }, 500)
  }
})

contentEditorRoutes.get('/api/name-mappings/:type', async (c) => {
  try {
    const type = c.req.param('type') as 'job' | 'major'
    if (type !== 'job' && type !== 'major') {
      return c.json({ success: false, error: 'Invalid type. Must be "job" or "major".' }, 400)
    }

    const mappings = await getExistingMappings(c.env.DB, type)

    return c.json({
      success: true,
      data: mappings
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to get mappings'
    return c.json({ success: false, error: message }, 500)
  }
})

contentEditorRoutes.delete('/api/name-mappings/:id', async (c) => {
  try {
    const idParam = c.req.param('id')
    const id = parseInt(idParam, 10)

    if (isNaN(id)) {
      return c.json({ success: false, error: 'Invalid mapping ID' }, 400)
    }

    const result = await deleteNameMapping(c.env.DB, id)

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }

    return c.json({ success: true })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to delete mapping'
    return c.json({ success: false, error: message }, 500)
  }
})

export { contentEditorRoutes }
