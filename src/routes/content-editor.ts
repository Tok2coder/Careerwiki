/**
 * 콘텐츠 편집기 API 라우트
 * index.tsx에서 추출: 직업/전공/HowTo CRUD, 슬러그, 검색, 태그, 초안, 발행, 리비전, 유사 이름
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { authMiddleware, requireAuth, requireAdmin, requireJobMajorEdit, requireHowToEdit } from '../middleware/auth'
import { editJob, editMajor, editHowTo, createHowTo, createJob, createMajor } from '../services/editService'
import { getRevisionById, listRevisions, restoreRevision } from '../services/revisionService'
import { findSimilarNames, saveNameMappings, deleteNameMapping, getExistingMappings } from '../services/similarNamesService'
import { invalidatePageCache } from '../utils/page-cache'
import { renderAdminSimilarNamesPage } from '../templates/adminSimilarNames'
import { getOptionalUser, hashIpAddress, escapeHtml, cleanGuidePrefix } from '../utils/shared-helpers'
import type { R2Bucket } from '@cloudflare/workers-types'

const contentEditorRoutes = new Hono<AppEnv>()

// ============================================================================
// Tiptap 헬퍼 함수
// ============================================================================

// Tiptap JSON에서 첫 번째 이미지 URL 추출 (썸네일용)
export function extractFirstImage(doc: any): string {
  let firstImage = ''

  const traverse = (node: any) => {
    if (firstImage) return
    if (!node) return

    if (node.type === 'image' && node.attrs?.src) {
      firstImage = node.attrs.src
      return
    }

    if (node.content && Array.isArray(node.content)) {
      for (const child of node.content) {
        traverse(child)
        if (firstImage) break
      }
    }
  }

  traverse(doc)
  return firstImage
}

// Tiptap JSON에서 각주 추출
export function extractFootnotes(doc: any): Array<{ id: number; text: string; url?: string }> {
  const footnotes: Array<{ id: number; text: string; url?: string }> = []

  const traverse = (node: any) => {
    if (!node) return

    if (node.type === 'footnote') {
      footnotes.push({
        id: node.attrs?.id || 0,
        text: node.attrs?.text || '',
        url: node.attrs?.url || undefined
      })
    }

    if (node.content && Array.isArray(node.content)) {
      node.content.forEach(traverse)
    }
  }

  traverse(doc)

  return footnotes.sort((a, b) => a.id - b.id)
}

// Tiptap JSON → HTML 변환 헬퍼
export function convertTiptapToHtml(doc: any): string {
  if (!doc || !doc.content) return ''

  const processNode = (node: any): string => {
    if (!node) return ''

    switch (node.type) {
      case 'paragraph':
        const pContent = node.content?.map(processNode).join('') || ''
        const pAlign = node.attrs?.textAlign
        const pStyle = pAlign && pAlign !== 'left' ? ' style="text-align:' + pAlign + '"' : ''
        return pContent ? '<p' + pStyle + '>' + pContent + '</p>' : '<p><br></p>'

      case 'text':
        let text = escapeHtml(node.text || '')
        if (node.marks) {
          for (const mark of node.marks) {
            switch (mark.type) {
              case 'bold': text = '<strong>' + text + '</strong>'; break
              case 'italic': text = '<em>' + text + '</em>'; break
              case 'underline': text = '<u>' + text + '</u>'; break
              case 'strike': text = '<s>' + text + '</s>'; break
              case 'code': text = '<code>' + text + '</code>'; break
              case 'link': {
                let href = mark.attrs?.href || '#'
                if (href.startsWith('www.')) {
                  href = 'https://' + href
                }
                else if (!href.startsWith('http') && !href.startsWith('/') && !href.startsWith('#') && !href.startsWith('mailto:') && href.includes('.')) {
                  href = 'https://' + href
                }
                const isExternal = href.startsWith('http://') || href.startsWith('https://') || href.startsWith('mailto:')
                const targetAttr = isExternal ? ' target="_blank" rel="noopener noreferrer"' : ''
                text = '<a href="' + escapeHtml(href) + '"' + targetAttr + '>' + text + '</a>'
                break
              }
              case 'textStyle': {
                const styles: string[] = []
                if (mark.attrs?.color) styles.push('color:' + mark.attrs.color)
                if (mark.attrs?.fontSize) styles.push('font-size:' + mark.attrs.fontSize)
                if (mark.attrs?.fontFamily) styles.push('font-family:' + mark.attrs.fontFamily)
                if (styles.length) text = '<span style="' + styles.join(';') + '">' + text + '</span>'
                break
              }
              case 'highlight':
                text = '<mark style="background:' + (mark.attrs?.color || '#ffeb3b') + '">' + text + '</mark>'
                break
            }
          }
        }
        return text

      case 'heading':
        const level = node.attrs?.level || 1
        const hContent = node.content?.map(processNode).join('') || ''
        const hAlign = node.attrs?.textAlign
        const hStyle = hAlign && hAlign !== 'left' ? ' style="text-align:' + hAlign + '"' : ''
        return '<h' + level + hStyle + '>' + hContent + '</h' + level + '>'

      case 'bulletList':
        return '<ul>' + (node.content?.map(processNode).join('') || '') + '</ul>'

      case 'orderedList':
        return '<ol>' + (node.content?.map(processNode).join('') || '') + '</ol>'

      case 'listItem':
        return '<li>' + (node.content?.map(processNode).join('') || '') + '</li>'

      case 'taskList':
        return '<ul class="task-list" data-type="taskList">' + (node.content?.map(processNode).join('') || '') + '</ul>'

      case 'taskItem':
        const checked = node.attrs?.checked ? ' checked' : ''
        const dataChecked = node.attrs?.checked ? ' data-checked="true"' : ''
        return '<li class="task-item"' + dataChecked + '><label><input type="checkbox"' + checked + '></label><div>' + (node.content?.map(processNode).join('') || '') + '</div></li>'

      case 'blockquote':
        const bqAlign = node.attrs?.align || 'left'
        const bqSize = node.attrs?.size || 'medium'
        const bqClass = `blockquote-align-${bqAlign} blockquote-size-${bqSize}`
        return '<blockquote class="' + bqClass + '" data-align="' + bqAlign + '" data-size="' + bqSize + '">' + (node.content?.map(processNode).join('') || '') + '</blockquote>'

      case 'codeBlock':
        return '<pre><code>' + escapeHtml(node.content?.[0]?.text || '') + '</code></pre>'

      case 'horizontalRule':
        return '<hr>'

      case 'image':
        const imgSrc = node.attrs?.src || ''
        const imgAlt = node.attrs?.alt || ''
        const imgWidth = node.attrs?.width
        const imgHeight = node.attrs?.height
        const imgAlign = node.attrs?.align || 'center'

        let imgStyle = ''
        if (imgWidth) imgStyle += 'width:' + imgWidth + 'px;'
        if (imgHeight) imgStyle += 'height:' + imgHeight + 'px;'

        const imgAttrs = ' src="' + escapeHtml(imgSrc) + '" alt="' + escapeHtml(imgAlt) + '"' +
          (imgStyle ? ' style="' + imgStyle + '"' : '') +
          ' loading="lazy" class="rounded-lg"'

        return '<figure class="image-wrapper image-align-' + imgAlign + '" data-align="' + imgAlign + '"><img' + imgAttrs + '></figure>'

      case 'table':
        return '<table>' + (node.content?.map(processNode).join('') || '') + '</table>'

      case 'tableRow':
        return '<tr>' + (node.content?.map(processNode).join('') || '') + '</tr>'

      case 'tableCell':
        const cellBg = node.attrs?.backgroundColor
        const cellStyle = cellBg ? ' style="background-color:' + cellBg + '"' : ''
        return '<td' + cellStyle + '>' + (node.content?.map(processNode).join('') || '') + '</td>'

      case 'tableHeader':
        return '<th>' + (node.content?.map(processNode).join('') || '') + '</th>'

      case 'checkpointBox':
        return '<div class="checkpoint-box">' + (node.content?.map(processNode).join('') || '') + '</div>'

      case 'conclusionBox':
        return '<div class="conclusion-box">' + (node.content?.map(processNode).join('') || '') + '</div>'

      case 'qnaBlock':
        return '<div class="qna-block">' + (node.content?.map(processNode).join('') || '') + '</div>'

      case 'qnaQuestion':
        return '<div class="qna-question"><span class="qna-label-q">Q</span><div class="qna-text">' + (node.content?.map(processNode).join('') || '') + '</div></div>'

      case 'qnaAnswer':
        return '<div class="qna-answer"><span class="qna-label-a">A</span><div class="qna-text">' + (node.content?.map(processNode).join('') || '') + '</div></div>'

      case 'careerList':
        return '<div class="career-list">' + (node.content?.map(processNode).join('') || '') + '</div>'

      case 'careerListItem':
        return '<div class="career-list-item">' + (node.content?.map(processNode).join('') || '') + '</div>'

      case 'footnote':
        const fnId = node.attrs?.id || 1
        return '<sup class="footnote-ref"><a href="#fn-' + fnId + '" id="fnref-' + fnId + '" data-footnote-id="' + fnId + '">' + fnId + '</a></sup>'

      case 'hardBreak':
        return '<br>'

      default:
        if (node.content) {
          return node.content.map(processNode).join('')
        }
        return ''
    }
  }

  return doc.content.map(processNode).join('')
}

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
contentEditorRoutes.post('/api/admin/reseed-empty-majors', async (c) => {
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
// Group B: Job CRUD (static paths first)
// ============================================================================

// 직업 생성 (일반 사용자)
contentEditorRoutes.post('/api/job/create', requireAuth, async (c) => {
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
contentEditorRoutes.get('/api/job/hidden', requireAuth, async (c) => {
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
contentEditorRoutes.get('/api/job/categories', async (c) => {
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
contentEditorRoutes.get('/api/job/check-name', async (c) => {
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
contentEditorRoutes.post('/api/job/:id/edit', requireJobMajorEdit, async (c) => {
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
contentEditorRoutes.delete('/api/job/:id', requireAuth, async (c) => {
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
contentEditorRoutes.post('/api/job/:id/restore', requireAuth, async (c) => {
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
// Group C: Major CRUD (static paths first)
// ============================================================================

// 전공 생성 (일반 사용자)
contentEditorRoutes.post('/api/major/create', requireAuth, async (c) => {
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
contentEditorRoutes.get('/api/major/hidden', requireAuth, async (c) => {
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
contentEditorRoutes.get('/api/major/categories', async (c) => {
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
contentEditorRoutes.get('/api/major/check-name', async (c) => {
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
contentEditorRoutes.post('/api/major/:id/edit', requireJobMajorEdit, async (c) => {
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
contentEditorRoutes.delete('/api/major/:id', requireAuth, async (c) => {
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
contentEditorRoutes.post('/api/major/:id/restore', requireAuth, async (c) => {
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

// ============================================================================
// Group D: Admin job/major
// ============================================================================

contentEditorRoutes.post('/api/admin/job', requireAdmin, async (c) => {
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

contentEditorRoutes.post('/api/admin/major', requireAdmin, async (c) => {
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

// ============================================================================
// Group E: HowTo CRUD
// ============================================================================

// HowTo 생성 (로그인 필수)
contentEditorRoutes.post('/api/howto', requireAuth, async (c) => {
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

    const title = typeof body.title === 'string' ? body.title.trim() : ''
    const slug = typeof body.slug === 'string' ? body.slug.trim() : ''
    const summary = typeof body.summary === 'string' ? body.summary.trim() : ''
    const content = typeof body.content === 'string' ? body.content : ''

    if (!title) {
      return c.json({ success: false, error: 'title is required' }, 400)
    }
    if (!slug) {
      return c.json({ success: false, error: 'slug is required' }, 400)
    }
    if (!summary) {
      return c.json({ success: false, error: 'summary is required' }, 400)
    }
    if (!content) {
      return c.json({ success: false, error: 'content is required' }, 400)
    }

    const result = await createHowTo(c.env.DB, {
      title,
      slug,
      summary,
      content,
      userId: user.id.toString(),
      editorType: user.role as 'user' | 'expert' | 'admin'
    })

    return c.json({
      success: true,
      slug: result.slug,
      revisionId: result.revisionId,
      message: 'HowTo created successfully'
    }, 201)
  } catch (error) {
    const message = error instanceof Error ? error.message : 'create failed'

    const status = message.includes('REQUIRED') ? 400
      : message.includes('INVALID') ? 400
      : message.includes('ALREADY_EXISTS') ? 409
      : message.includes('LOGIN') ? 401
      : 500

    return c.json({ success: false, error: message }, status)
  }
})

// HowTo 편집 (로그인 필수, 본인 글만 - admin 제외)
contentEditorRoutes.post('/api/howto/:slug/edit', requireHowToEdit, async (c) => {
  try {
    const slug = c.req.param('slug')
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

    const content = typeof body.content === 'string' ? body.content : ''
    const source = typeof body.source === 'string' ? body.source : undefined
    const changeSummary = typeof body.changeSummary === 'string' ? body.changeSummary : undefined

    if (!content) {
      return c.json({ success: false, error: 'content is required' }, 400)
    }

    const result = await editHowTo(c.env.DB, slug, {
      content,
      source,
      changeSummary,
      userId: user.id.toString(),
      editorType: user.role as 'user' | 'expert' | 'admin'
    })

    await invalidatePageCache(c.env.DB, {
      slug,
      pageType: 'guide'
    })

    return c.json({
      success: true,
      revisionId: result.revisionId,
      message: 'Edit saved successfully'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'edit failed'

    const status = message.includes('NOT_FOUND') ? 404
      : message.includes('NOT_AUTHOR') ? 403
      : message.includes('LOGIN_REQUIRED') ? 401
      : message.includes('REQUIRED') || message.includes('INVALID') ? 400
      : message.includes('LIMIT') ? 403
      : 500

    return c.json({ success: false, error: message }, status)
  }
})

// HowTo 신고 (로그인/익명 모두 가능)
contentEditorRoutes.post('/api/howto/:slug/report', authMiddleware, async (c) => {
  try {
    const slug = c.req.param('slug')
    const authUser = c.get('user')
    const body = await c.req.json()

    const { reasonType, reasonDetail } = body

    const validReasons = ['defamation', 'obscene', 'spam', 'copyright', 'false_info', 'other']
    if (!reasonType || !validReasons.includes(reasonType)) {
      return c.json({ success: false, error: '유효한 신고 사유를 선택해주세요' }, 400)
    }

    const page = await c.env.DB.prepare(`
      SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'
    `).bind(slug).first<{ id: number }>()

    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }

    const { createHowtoReport } = await import('../services/howtoReportService')
    const clientIp = c.req.header('CF-Connecting-IP') || c.req.header('X-Forwarded-For')?.split(',')[0]?.trim()

    const result = await createHowtoReport(c.env.DB, {
      pageId: page.id,
      reporterId: authUser?.id ?? null,
      reporterIp: !authUser ? clientIp : null,
      reasonType,
      reasonDetail: reasonDetail?.slice(0, 500)
    })

    return c.json({
      success: true,
      reportId: result.reportId,
      autoBlinded: result.autoBlinded,
      message: result.autoBlinded
        ? '신고가 접수되었으며, 신고 누적으로 해당 글이 블라인드 처리되었습니다.'
        : '신고가 접수되었습니다. 관리자 검토 후 조치될 예정입니다.'
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error)

    if (message === 'ALREADY_REPORTED') {
      return c.json({ success: false, error: '이미 신고한 글입니다' }, 400)
    }

    return c.json({ success: false, error: '신고 처리 중 오류가 발생했습니다' }, 500)
  }
})

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

contentEditorRoutes.get('/api/howto/check-title', async (c) => {
  try {
    const title = c.req.query('title')?.trim()
    const excludeId = c.req.query('excludeId')

    if (!title) {
      return c.json({ success: false, error: '제목이 필요합니다' }, 400)
    }

    if (title.length < 2) {
      return c.json({
        success: true,
        available: false,
        reason: '제목은 최소 2자 이상이어야 합니다'
      })
    }

    let query = `
      SELECT id, title FROM pages
      WHERE page_type = 'guide'
        AND status IN ('published', 'draft_published')
        AND LOWER(title) = LOWER(?)
    `
    const bindings: any[] = [title]

    if (excludeId) {
      query += ` AND id != ?`
      bindings.push(parseInt(excludeId))
    }

    query += ` LIMIT 1`

    const existing = await c.env.DB.prepare(query).bind(...bindings).first<{ id: number; title: string }>()

    if (existing) {
      return c.json({
        success: true,
        available: false,
        reason: `이미 같은 제목의 가이드가 존재합니다`
      })
    }

    return c.json({ success: true, available: true })
  } catch (error) {
    return c.json({ success: false, error: '제목 확인 중 오류가 발생했습니다' }, 500)
  }
})

// ============================================================================
// Group H: HowTo Drafts
// ============================================================================

contentEditorRoutes.post('/api/howto/drafts', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const body = await c.req.json()

    const { createDraft, updateDraft } = await import('../services/draftService')
    const result = await createDraft(c.env.DB, {
      userId: user.id,
      baseHowtoId: body.baseHowtoId,
      title: body.title,
      slug: body.slug,
      summary: body.summary,
      thumbnailUrl: body.thumbnailUrl,
      contentJson: body.contentJson,
      contentHtml: body.contentHtml
    })

    if (!result.success || !result.draftId) {
      return c.json({ success: false, error: result.error }, 400)
    }

    const draftId = result.draftId
    const tags = body.tags || []
    const relatedJobs = body.relatedJobs || []
    const relatedMajors = body.relatedMajors || []
    const relatedHowtos = body.relatedHowtos || []

    for (const tagName of tags) {
      if (!tagName || !String(tagName).trim()) continue
      const trimmed = String(tagName).trim()

      let tag = await c.env.DB.prepare(`SELECT id FROM tags WHERE name = ?`).bind(trimmed).first<{ id: number }>()
      if (!tag) {
        const tagSlug = trimmed.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9가-힣-]/g, '')
        const tagResult = await c.env.DB.prepare(`INSERT INTO tags (name, slug) VALUES (?, ?)`).bind(trimmed, tagSlug).run()
        tag = { id: Number(tagResult.meta.last_row_id) }
      }
      await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_tags (draft_id, tag_id) VALUES (?, ?)`).bind(draftId, tag.id).run()
    }

    for (let i = 0; i < relatedJobs.length; i++) {
      const job = relatedJobs[i]
      const jobId = job.id || job.slug || job.name
      if (jobId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_jobs (draft_id, job_id, display_order) VALUES (?, ?, ?)`).bind(draftId, String(jobId), i).run()
      }
    }

    for (let i = 0; i < relatedMajors.length; i++) {
      const major = relatedMajors[i]
      const majorId = major.id || major.slug || major.name
      if (majorId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_majors (draft_id, major_id, display_order) VALUES (?, ?, ?)`).bind(draftId, String(majorId), i).run()
      }
    }

    for (let i = 0; i < relatedHowtos.length; i++) {
      const howto = relatedHowtos[i]
      const howtoId = howto.id || howto.slug || howto.name
      if (howtoId) {
        await c.env.DB.prepare(`INSERT OR IGNORE INTO draft_related_howtos (draft_id, howto_id, display_order) VALUES (?, ?, ?)`).bind(draftId, String(howtoId), i).run()
      }
    }

    return c.json({ success: true, draftId: draftId }, 201)
  } catch (error) {
    return c.json({ success: false, error: '초안 생성 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.get('/api/howto/drafts', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const limit = parseInt(c.req.query('limit') || '20')
    const offset = parseInt(c.req.query('offset') || '0')
    const stage = c.req.query('stage')

    const { listMyDrafts } = await import('../services/draftService')
    const result = await listMyDrafts(c.env.DB, user.id, { limit, offset, stage })

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }

    return c.json({ success: true, drafts: result.drafts, total: result.total })
  } catch (error) {
    return c.json({ success: false, error: '초안 목록 조회 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.get('/api/howto/drafts/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))

    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }

    const { getDraft } = await import('../services/draftService')
    const result = await getDraft(c.env.DB, draftId, user.id)

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 404)
    }

    return c.json({ success: true, draft: result.draft })
  } catch (error) {
    return c.json({ success: false, error: '초안 조회 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.put('/api/howto/drafts/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))
    const ifMatch = c.req.header('If-Match')

    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }

    if (!ifMatch) {
      return c.json({ success: false, error: 'If-Match 헤더가 필요합니다 (버전 관리)' }, 428)
    }

    const expectedVersion = parseInt(ifMatch)
    if (!Number.isFinite(expectedVersion)) {
      return c.json({ success: false, error: '유효하지 않은 버전입니다' }, 400)
    }

    const body = await c.req.json()

    const { updateDraft } = await import('../services/draftService')
    const result = await updateDraft(c.env.DB, draftId, user.id, expectedVersion, {
      title: body.title,
      slug: body.slug,
      summary: body.summary,
      thumbnailUrl: body.thumbnailUrl,
      contentJson: body.contentJson,
      contentHtml: body.contentHtml,
      tags: body.tags,
      relatedJobs: body.relatedJobs,
      relatedMajors: body.relatedMajors,
      relatedHowtos: body.relatedHowtos
    })

    if (!result.success) {
      if (result.error === 'VERSION_CONFLICT') {
        return c.json({
          success: false,
          error: '버전 충돌이 발생했습니다. 다른 곳에서 수정되었습니다.',
          serverVersion: result.serverVersion
        }, 409)
      }
      return c.json({ success: false, error: result.error }, 400)
    }

    return c.json({ success: true, version: result.newVersion })
  } catch (error) {
    return c.json({ success: false, error: '초안 업데이트 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.delete('/api/howto/drafts/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))

    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }

    const draft = await c.env.DB.prepare(`
      SELECT thumbnail_url, content_html FROM howto_drafts WHERE id = ? AND user_id = ?
    `).bind(draftId, user.id).first<{ thumbnail_url: string | null; content_html: string | null }>()

    if (!draft) {
      return c.json({ success: false, error: '초안을 찾을 수 없거나 삭제 권한이 없습니다' }, 404)
    }

    const imageKeysToDelete: string[] = []

    if (draft.content_html) {
      const uploadMatches = draft.content_html.match(/\/uploads\/[^\s"'<>]+/g) || []
      for (const match of uploadMatches) {
        const key = match.replace('/uploads/', '')
        if (key && !imageKeysToDelete.includes(key)) {
          imageKeysToDelete.push(key)
        }
      }
    }

    if (draft.thumbnail_url && draft.thumbnail_url.startsWith('/uploads/')) {
      const key = draft.thumbnail_url.replace('/uploads/', '')
      if (key && !imageKeysToDelete.includes(key)) {
        imageKeysToDelete.push(key)
      }
    }

    if (imageKeysToDelete.length > 0 && c.env.UPLOADS) {
      for (const key of imageKeysToDelete) {
        try {
          await c.env.UPLOADS.delete(key)
        } catch (e) {
        }
      }
    }

    const { deleteDraft } = await import('../services/draftService')
    const result = await deleteDraft(c.env.DB, draftId, user.id)

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 404)
    }

    return c.json({ success: true })
  } catch (error) {
    return c.json({ success: false, error: '초안 삭제 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.post('/api/howto/drafts/:id/submit', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))

    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }

    const { submitForReview } = await import('../services/draftService')
    const result = await submitForReview(c.env.DB, draftId, user.id)

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 400)
    }

    return c.json({ success: true, message: '검수 요청이 완료되었습니다' })
  } catch (error) {
    return c.json({ success: false, error: '검수 요청 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.post('/api/howto/drafts/:id/publish', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))

    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }

    let clientData: any = {}
    try {
      const body = await c.req.text()
      if (body) {
        clientData = JSON.parse(body)
      }
    } catch {}

    const { getDraft } = await import('../services/draftService')
    const draft = await getDraft(c.env.DB, draftId, user.id)

    if (!draft.success || !draft.draft) {
      return c.json({ success: false, error: draft.error || '초안을 찾을 수 없습니다' }, 404)
    }

    const d = draft.draft

    if (!d.title || !d.title.trim()) {
      return c.json({ success: false, error: '제목을 입력해주세요' }, 400)
    }
    if (!d.contentJson || d.contentJson === '{}') {
      return c.json({ success: false, error: '본문을 입력해주세요' }, 400)
    }

    const publishedPageId = d.publishedPageId

    const { generateSlug } = await import('../services/slugService')
    let baseSlug = cleanGuidePrefix(d.slug || generateSlug(d.title))
    let slug = baseSlug
    let suffix = 2

    while (suffix <= 100) {
      const existing = await c.env.DB.prepare(
        `SELECT id FROM pages WHERE page_type = 'guide' AND slug = ? ${publishedPageId ? 'AND id != ?' : ''} LIMIT 1`
      ).bind(...(publishedPageId ? [slug, publishedPageId] : [slug])).first()
      if (!existing) break
      slug = baseSlug + '-' + suffix
      suffix++
    }

    let contentHtml = ''
    let footnotes: Array<{ id: number; text: string; url?: string }> = []
    let firstImageUrl = ''
    try {
      const contentObj = JSON.parse(d.contentJson)
      contentHtml = convertTiptapToHtml(contentObj)
      footnotes = extractFootnotes(contentObj)
      firstImageUrl = extractFirstImage(contentObj)
    } catch {
      contentHtml = '<p>내용을 불러올 수 없습니다.</p>'
    }

    const thumbnailUrl = d.thumbnailUrl || firstImageUrl || ''

    const relatedJobs = (clientData.relatedJobs && clientData.relatedJobs.length > 0)
      ? clientData.relatedJobs
      : (d.relatedJobs || [])
    const relatedMajors = (clientData.relatedMajors && clientData.relatedMajors.length > 0)
      ? clientData.relatedMajors
      : (d.relatedMajors || [])
    const relatedHowtos = (clientData.relatedHowtos && clientData.relatedHowtos.length > 0)
      ? clientData.relatedHowtos
      : (d.relatedHowtos || [])
    const tags = (clientData.tags && clientData.tags.length > 0)
      ? clientData.tags
      : (d.tags || [])

    const metaData = JSON.stringify({
      contentJson: d.contentJson,
      tags,
      relatedJobs,
      relatedMajors,
      relatedHowtos,
      footnotes,
      authorName: user.username || user.email?.split('@')[0] || '작성자',
      thumbnailUrl
    })

    const now = new Date().toISOString()
    let result
    let finalPageId = publishedPageId

    if (publishedPageId) {
      result = await c.env.DB.prepare(`
        UPDATE pages SET
          slug = ?, title = ?, summary = ?, content = ?, meta_data = ?,
          status = 'published', updated_at = ?
        WHERE id = ? AND page_type = 'guide'
      `).bind(
        slug,
        d.title,
        d.summary || '',
        contentHtml,
        metaData,
        now,
        publishedPageId
      ).run()
    } else {
      result = await c.env.DB.prepare(`
        INSERT INTO pages (
          page_type, slug, title, summary, content, meta_data,
          status, author_id, source, created_at, updated_at
        ) VALUES (?, ?, ?, ?, ?, ?, 'published', ?, 'user', ?, ?)
      `).bind(
        'guide',
        slug,
        d.title,
        d.summary || '',
        contentHtml,
        metaData,
        user.id,
        now,
        now
      ).run()

      if (result.success && result.meta.last_row_id) {
        finalPageId = Number(result.meta.last_row_id)
      }
    }

    if (!result.success) {
      return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
    }

    await c.env.DB.prepare('DELETE FROM howto_drafts WHERE id = ?').bind(draftId).run()

    return c.json({
      success: true,
      message: '발행이 완료되었습니다',
      slug: slug,
      url: '/howto/' + slug
    })
  } catch (error) {
    return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
  }
})

// ============================================================================
// Group I: HowTo Publish
// ============================================================================

contentEditorRoutes.post('/api/howto/publish-direct', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const body = await c.req.json()

    if (!user || !user.id) {
      return c.json({ success: false, error: '로그인이 필요합니다' }, 401)
    }

    const { draftId, title, summary, contentJson, contentHtml, tags, relatedJobs, relatedMajors, relatedHowtos, thumbnailUrl } = body

    if (!title || !title.trim()) {
      return c.json({ success: false, error: '제목을 입력해주세요' }, 400)
    }
    if (!contentJson || contentJson === '{}') {
      return c.json({ success: false, error: '본문을 입력해주세요' }, 400)
    }

    const now = new Date().toISOString()

    let existingPageId: number | null = null
    let existingSlug: string | null = null


    if (draftId) {
      const draftInfo = await c.env.DB.prepare(`
        SELECT published_page_id, slug FROM howto_drafts WHERE id = ? AND user_id = ?
      `).bind(draftId, user.id).first<{ published_page_id: number | null; slug: string | null }>()


      if (draftInfo?.published_page_id) {
        existingPageId = draftInfo.published_page_id
        existingSlug = draftInfo.slug
      }
    }


    let finalContentHtml = contentHtml || ''
    let footnotes: Array<{ id: number; text: string; url?: string }> = []
    let firstImageUrl = ''
    try {
      const contentObj = JSON.parse(contentJson)
      finalContentHtml = convertTiptapToHtml(contentObj)
      footnotes = extractFootnotes(contentObj)
      firstImageUrl = extractFirstImage(contentObj)
    } catch {}

    const finalThumbnail = thumbnailUrl || firstImageUrl || ''

    const metaData = JSON.stringify({
      contentJson,
      tags: tags || [],
      relatedJobs: relatedJobs || [],
      relatedMajors: relatedMajors || [],
      relatedHowtos: relatedHowtos || [],
      footnotes,
      authorName: user.username || user.email?.split('@')[0] || '작성자',
      thumbnailUrl: finalThumbnail
    })

    let pageId: number | null = null
    let slug: string

    const { generateSlug } = await import('../services/slugService')
    let baseSlug = cleanGuidePrefix(generateSlug(title))
    slug = baseSlug

    if (existingPageId) {
      slug = cleanGuidePrefix(existingSlug || '') || slug

      await c.env.DB.prepare(`
        UPDATE pages SET
          slug = ?, title = ?, summary = ?, content = ?, meta_data = ?,
          status = 'published', updated_at = ?
        WHERE id = ? AND page_type = 'guide'
      `).bind(slug, title, summary || '', finalContentHtml, metaData, now, existingPageId).run()
      pageId = existingPageId

      if (draftId) {
        await c.env.DB.prepare(`
          UPDATE howto_drafts SET slug = ? WHERE id = ?
        `).bind(slug, draftId).run()
      }
    } else {
      let suffix = 2

      while (suffix <= 100) {
        const existing = await c.env.DB.prepare(
          `SELECT id FROM pages WHERE page_type = 'guide' AND slug = ? LIMIT 1`
        ).bind(slug).first()
        if (!existing) break
        slug = baseSlug + '-' + suffix
        suffix++
      }

      const result = await c.env.DB.prepare(`
        INSERT INTO pages (
          page_type, slug, title, summary, content, meta_data,
          status, author_id, source, created_at, updated_at
        ) VALUES (?, ?, ?, ?, ?, ?, 'published', ?, 'user', ?, ?)
      `).bind('guide', slug, title, summary || '', finalContentHtml, metaData, user.id, now, now).run()

      if (!result.success) {
        return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
      }

      pageId = result.meta.last_row_id ? Number(result.meta.last_row_id) : null

      if (draftId && pageId) {
        await c.env.DB.prepare(`
          UPDATE howto_drafts SET published_page_id = ?, slug = ? WHERE id = ?
        `).bind(pageId, slug, draftId).run()
      }
    }

    if (pageId) {
      for (const job of (relatedJobs || [])) {
        if (!job.slug) continue
        const jobPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'job'`).bind(job.slug).first<{ id: number }>()
        if (jobPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_job')`)
            .bind(pageId, jobPage.id).run()
        }
      }

      for (const major of (relatedMajors || [])) {
        if (!major.slug) continue
        const majorPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'major'`).bind(major.slug).first<{ id: number }>()
        if (majorPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_major')`)
            .bind(pageId, majorPage.id).run()
        }
      }

      for (const howto of (relatedHowtos || [])) {
        if (!howto.slug) continue
        const howtoPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'`).bind(howto.slug).first<{ id: number }>()
        if (howtoPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_howto')`)
            .bind(pageId, howtoPage.id).run()
        }
      }
    }

    const openaiKeyForIdx = (c.env as any).OPENAI_API_KEY
    if (openaiKeyForIdx && (c.env as any).VECTORIZE && pageId) {
      c.executionCtx.waitUntil(
        import('../services/ai-analyzer/vectorize-pipeline').then(({ indexSingleHowto }) =>
          indexSingleHowto(c.env.DB, (c.env as any).VECTORIZE, openaiKeyForIdx, pageId!)
        ).catch(() => {})
      )
    }

    return c.json({ success: true, slug, pageId, status: 'published' })
  } catch (error) {
    return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.post('/api/howto/:pageId/publish-final', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const pageId = parseInt(c.req.param('pageId'))

    if (!Number.isFinite(pageId)) {
      return c.json({ success: false, error: '유효하지 않은 페이지 ID입니다' }, 400)
    }

    const page = await c.env.DB.prepare(`
      SELECT id, author_id, status FROM pages WHERE id = ? AND page_type = 'guide'
    `).bind(pageId).first<{ id: number; author_id: number; status: string }>()

    if (!page) {
      return c.json({ success: false, error: '페이지를 찾을 수 없습니다' }, 404)
    }

    const isAuthor = String(user.id) === String(page.author_id)
    const isAdmin = (user.role as string) === 'super-admin' || (user.role as string) === 'operator'

    if (!isAuthor && !isAdmin) {
      return c.json({ success: false, error: '권한이 없습니다' }, 403)
    }

    if (page.status !== 'draft_published') {
      return c.json({ success: false, error: '임시 발행 상태가 아닙니다' }, 400)
    }

    const now = new Date().toISOString()
    await c.env.DB.prepare(`
      UPDATE pages SET status = 'published', updated_at = ? WHERE id = ?
    `).bind(now, pageId).run()

    return c.json({ success: true })
  } catch (error) {
    return c.json({ success: false, error: '발행 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.post('/api/howto/save-publish', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const body = await c.req.json()

    if (!user || !user.id) {
      return c.json({ success: false, error: '로그인이 필요합니다' }, 401)
    }

    const { title, summary, contentJson, contentHtml, tags, relatedJobs, relatedMajors, relatedHowtos, thumbnailUrl, forceDraftPublished } = body
    let draftId = body.draftId

    if (!title || !title.trim()) {
      return c.json({ success: false, error: '제목을 입력해주세요' }, 400)
    }
    if (!contentJson || contentJson === '{}') {
      return c.json({ success: false, error: '본문을 입력해주세요' }, 400)
    }

    const now = new Date().toISOString()

    if (!draftId) {
      const { createDraft } = await import('../services/draftService')
      const draftResult = await createDraft(c.env.DB, {
        userId: user.id,
        title,
        summary,
        thumbnailUrl,
        contentJson,
        contentHtml
      })
      if (!draftResult.success || !draftResult.draftId) {
        return c.json({ success: false, error: draftResult.error || '초안 생성 실패' }, 400)
      }
      draftId = draftResult.draftId
    } else {
      await c.env.DB.prepare(`
        UPDATE howto_drafts SET
          title = ?, summary = ?, content_json = ?, content_html = ?, thumbnail_url = ?,
          updated_at = ?, version = version + 1
        WHERE id = ? AND user_id = ?
      `).bind(title, summary || '', contentJson, contentHtml || '', thumbnailUrl || '', now, draftId, user.id).run()
    }

    const draftInfo = await c.env.DB.prepare(`
      SELECT published_page_id, (SELECT status FROM pages WHERE id = published_page_id) as page_status
      FROM howto_drafts WHERE id = ? AND user_id = ?
    `).bind(draftId, user.id).first<{ published_page_id: number | null; page_status: string | null }>()


    const publishedPageId = draftInfo?.published_page_id
    const currentStatus = draftInfo?.page_status || ''


    const { generateSlug } = await import('../services/slugService')
    let baseSlug = cleanGuidePrefix(generateSlug(title))
    let slug = baseSlug
    let suffix = 2


    while (suffix <= 100) {
      const existing = await c.env.DB.prepare(
        `SELECT id FROM pages WHERE page_type = 'guide' AND slug = ? ${publishedPageId ? 'AND id != ?' : ''} LIMIT 1`
      ).bind(...(publishedPageId ? [slug, publishedPageId] : [slug])).first()
      if (!existing) break
      slug = baseSlug + '-' + suffix
      suffix++
    }

    let finalContentHtml = contentHtml || ''
    let footnotes: Array<{ id: number; text: string; url?: string }> = []
    let firstImageUrl = ''
    try {
      const contentObj = JSON.parse(contentJson)
      finalContentHtml = convertTiptapToHtml(contentObj)
      footnotes = extractFootnotes(contentObj)
      firstImageUrl = extractFirstImage(contentObj)
    } catch {}

    const finalThumbnail = thumbnailUrl || firstImageUrl || ''

    const metaData = JSON.stringify({
      contentJson,
      tags: tags || [],
      relatedJobs: relatedJobs || [],
      relatedMajors: relatedMajors || [],
      relatedHowtos: relatedHowtos || [],
      footnotes,
      authorName: user.username || user.email?.split('@')[0] || '작성자',
      thumbnailUrl: finalThumbnail
    })

    const newStatus = forceDraftPublished ? 'draft_published' : (currentStatus === 'published' ? 'published' : 'draft_published')

    let finalPageId = publishedPageId

    if (publishedPageId) {
      await c.env.DB.prepare(`
        UPDATE pages SET
          slug = ?, title = ?, summary = ?, content = ?, meta_data = ?,
          status = ?, updated_at = ?
        WHERE id = ? AND page_type = 'guide'
      `).bind(slug, title, summary || '', finalContentHtml, metaData, newStatus, now, publishedPageId).run()

      await c.env.DB.prepare(`
        UPDATE howto_drafts SET slug = ? WHERE id = ?
      `).bind(slug, draftId).run()
    } else {
      const result = await c.env.DB.prepare(`
        INSERT INTO pages (
          page_type, slug, title, summary, content, meta_data,
          status, author_id, source, created_at, updated_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'user', ?, ?)
      `).bind('guide', slug, title, summary || '', finalContentHtml, metaData, 'draft_published', user.id, now, now).run()

      if (result.success && result.meta.last_row_id) {
        finalPageId = Number(result.meta.last_row_id)

        await c.env.DB.prepare(`
          UPDATE howto_drafts SET published_page_id = ?, slug = ? WHERE id = ?
        `).bind(finalPageId, slug, draftId).run()
      }
    }

    if (finalPageId) {
      await c.env.DB.prepare(`DELETE FROM page_relations WHERE page_id = ?`).bind(finalPageId).run()

      for (const job of (relatedJobs || [])) {
        if (!job.slug) continue
        const jobPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'job'`).bind(job.slug).first<{ id: number }>()
        if (jobPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_job')`)
            .bind(finalPageId, jobPage.id).run()
        }
      }

      for (const major of (relatedMajors || [])) {
        if (!major.slug) continue
        const majorPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'major'`).bind(major.slug).first<{ id: number }>()
        if (majorPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_major')`)
            .bind(finalPageId, majorPage.id).run()
        }
      }

      for (const howto of (relatedHowtos || [])) {
        if (!howto.slug) continue
        const howtoPage = await c.env.DB.prepare(`SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'`).bind(howto.slug).first<{ id: number }>()
        if (howtoPage) {
          await c.env.DB.prepare(`INSERT INTO page_relations (page_id, related_page_id, relation_type) VALUES (?, ?, 'related_howto')`)
            .bind(finalPageId, howtoPage.id).run()
        }
      }
    }

    return c.json({ success: true, slug, pageId: finalPageId, status: newStatus })
  } catch (error) {
    return c.json({ success: false, error: '저장 중 오류가 발생했습니다' }, 500)
  }
})

// ============================================================================
// Group J: Admin HowTo moderation
// ============================================================================

contentEditorRoutes.get('/api/admin/howto/pending', requireAdmin, async (c) => {
  try {
    const limit = parseInt(c.req.query('limit') || '20')
    const offset = parseInt(c.req.query('offset') || '0')

    const { listPendingReviews } = await import('../services/publishService')
    const result = await listPendingReviews(c.env.DB, { limit, offset })

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 500)
    }

    return c.json({ success: true, drafts: result.drafts, total: result.total })
  } catch (error) {
    return c.json({ success: false, error: '조회 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.get('/api/admin/howto/reports', requireAdmin, async (c) => {
  try {
    const status = c.req.query('status')
    const pageId = c.req.query('pageId')
    const limit = parseInt(c.req.query('limit') || '50')
    const offset = parseInt(c.req.query('offset') || '0')

    const { listHowtoReports } = await import('../services/howtoReportService')
    const result = await listHowtoReports(c.env.DB, {
      status: status || undefined,
      pageId: pageId ? parseInt(pageId) : undefined,
      limit,
      offset
    })

    return c.json({ success: true, ...result })
  } catch (error) {
    return c.json({ success: false, error: '조회 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.post('/api/admin/howto/drafts/:id/approve', requireAdmin, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))

    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }

    const { approveDraft } = await import('../services/publishService')
    const result = await approveDraft(c.env.DB, draftId, user.id)

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 400)
    }

    const openaiKeyForIdx = (c.env as any).OPENAI_API_KEY
    if (openaiKeyForIdx && (c.env as any).VECTORIZE && result.howtoId) {
      c.executionCtx.waitUntil(
        import('../services/ai-analyzer/vectorize-pipeline').then(({ indexSingleHowto }) =>
          indexSingleHowto(c.env.DB, (c.env as any).VECTORIZE, openaiKeyForIdx, result.howtoId!)
        ).catch(() => {})
      )
    }

    return c.json({
      success: true,
      howtoId: result.howtoId,
      slug: result.slug,
      message: '승인되어 게시되었습니다'
    })
  } catch (error) {
    return c.json({ success: false, error: '승인 처리 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.post('/api/admin/howto/drafts/:id/reject', requireAdmin, async (c) => {
  try {
    const user = c.get('user')!
    const draftId = parseInt(c.req.param('id'))
    const body = await c.req.json()
    const { reason } = body

    if (!Number.isFinite(draftId)) {
      return c.json({ success: false, error: '유효하지 않은 초안 ID입니다' }, 400)
    }

    if (!reason || typeof reason !== 'string' || reason.trim().length === 0) {
      return c.json({ success: false, error: '반려 사유를 입력해주세요' }, 400)
    }

    const { rejectDraft } = await import('../services/publishService')
    const result = await rejectDraft(c.env.DB, draftId, user.id, reason.trim())

    if (!result.success) {
      return c.json({ success: false, error: result.error }, 400)
    }

    return c.json({ success: true, message: '반려 처리되었습니다' })
  } catch (error) {
    return c.json({ success: false, error: '반려 처리 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.post('/api/admin/howto/:slug/blind', requireAdmin, async (c) => {
  try {
    const slug = c.req.param('slug')
    const user = c.get('user')!
    const body = await c.req.json()
    const { reason } = body

    if (!reason || typeof reason !== 'string' || reason.trim().length === 0) {
      return c.json({ success: false, error: '블라인드 사유를 입력해주세요' }, 400)
    }

    const page = await c.env.DB.prepare(`
      SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'
    `).bind(slug).first<{ id: number }>()

    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }

    const { blindHowto } = await import('../services/howtoReportService')
    await blindHowto(c.env.DB, page.id, user.id, reason.trim())

    return c.json({ success: true, message: '블라인드 처리되었습니다' })
  } catch (error) {
    return c.json({ success: false, error: '처리 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.post('/api/admin/howto/:slug/unblind', requireAdmin, async (c) => {
  try {
    const slug = c.req.param('slug')

    const page = await c.env.DB.prepare(`
      SELECT id FROM pages WHERE slug = ? AND page_type = 'guide'
    `).bind(slug).first<{ id: number }>()

    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }

    const { unblindHowto } = await import('../services/howtoReportService')
    await unblindHowto(c.env.DB, page.id)

    return c.json({ success: true, message: '블라인드가 해제되었습니다' })
  } catch (error) {
    return c.json({ success: false, error: '처리 중 오류가 발생했습니다' }, 500)
  }
})

contentEditorRoutes.post('/api/admin/howto/reports/:id/resolve', requireAdmin, async (c) => {
  try {
    const reportId = parseInt(c.req.param('id'))
    const user = c.get('user')!
    const body = await c.req.json()
    const { action } = body

    if (!['resolve', 'dismiss'].includes(action)) {
      return c.json({ success: false, error: '유효하지 않은 액션입니다' }, 400)
    }

    const { resolveHowtoReport } = await import('../services/howtoReportService')
    await resolveHowtoReport(c.env.DB, reportId, user.id, action)

    return c.json({
      success: true,
      message: action === 'resolve' ? '신고가 처리되었습니다' : '신고가 기각되었습니다'
    })
  } catch (error) {
    return c.json({ success: false, error: '처리 중 오류가 발생했습니다' }, 500)
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
// Group L: Data refresh
// ============================================================================

contentEditorRoutes.post('/api/job/:id/refetch-api-data', authMiddleware, async (c) => {
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

contentEditorRoutes.post('/api/job/:id/reset-contributions', authMiddleware, async (c) => {
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
