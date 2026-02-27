/**
 * HowTo 편집기 API 라우트
 * content-editor.ts에서 추출: HowTo CRUD, 초안, 발행, 관리자 모더레이션
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { authMiddleware, requireAuth, requireAdmin, requireHowToEdit } from '../middleware/auth'
import { editHowTo, createHowTo } from '../services/editService'
import { invalidatePageCache } from '../utils/page-cache'
import { getOptionalUser, escapeHtml, cleanGuidePrefix } from '../utils/shared-helpers'
import type { R2Bucket } from '@cloudflare/workers-types'

const howtoEditorRoutes = new Hono<AppEnv>()

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
// Group E: HowTo CRUD
// ============================================================================

// HowTo 생성 (로그인 필수)
howtoEditorRoutes.post('/api/howto', requireAuth, async (c) => {
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
howtoEditorRoutes.post('/api/howto/:slug/edit', requireHowToEdit, async (c) => {
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
howtoEditorRoutes.post('/api/howto/:slug/report', authMiddleware, async (c) => {
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


howtoEditorRoutes.get('/api/howto/check-title', async (c) => {
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

howtoEditorRoutes.post('/api/howto/drafts', requireAuth, async (c) => {
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

howtoEditorRoutes.get('/api/howto/drafts', requireAuth, async (c) => {
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

howtoEditorRoutes.get('/api/howto/drafts/:id', requireAuth, async (c) => {
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

howtoEditorRoutes.put('/api/howto/drafts/:id', requireAuth, async (c) => {
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

howtoEditorRoutes.delete('/api/howto/drafts/:id', requireAuth, async (c) => {
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

howtoEditorRoutes.post('/api/howto/drafts/:id/submit', requireAuth, async (c) => {
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

howtoEditorRoutes.post('/api/howto/drafts/:id/publish', requireAuth, async (c) => {
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

howtoEditorRoutes.post('/api/howto/publish-direct', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const body = await c.req.json()

    if (!user || !user.id) {
      return c.json({ success: false, error: '로그인이 필요합니다' }, 401)
    }

    const { draftId, title, summary, contentJson, contentHtml, tags, relatedJobs, relatedMajors, relatedHowtos, thumbnailUrl, updatePageId } = body

    if (!title || !title.trim()) {
      return c.json({ success: false, error: '제목을 입력해주세요' }, 400)
    }
    if (!contentJson || contentJson === '{}') {
      return c.json({ success: false, error: '본문을 입력해주세요' }, 400)
    }

    const now = new Date().toISOString()

    let existingPageId: number | null = null
    let existingSlug: string | null = null

    // updatePageId가 주어지면 기존 페이지를 직접 업데이트
    if (updatePageId && typeof updatePageId === 'number') {
      const pageInfo = await c.env.DB.prepare(`
        SELECT id, slug FROM pages WHERE id = ? AND page_type = 'guide' AND author_id = ?
      `).bind(updatePageId, user.id).first<{ id: number; slug: string }>()
      if (pageInfo) {
        existingPageId = pageInfo.id
        existingSlug = pageInfo.slug
      }
    }

    if (!existingPageId && draftId) {
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

      // publish-direct로 페이지가 업데이트되면 연결된 기존 draft를 삭제
      // (편집 버튼 클릭 시 최신 페이지 데이터로 새 draft가 생성되도록)
      await c.env.DB.prepare(`
        DELETE FROM howto_drafts
        WHERE published_page_id = ? AND id != ?
      `).bind(existingPageId, draftId || 0).run()
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

howtoEditorRoutes.post('/api/howto/:pageId/publish-final', requireAuth, async (c) => {
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

howtoEditorRoutes.post('/api/howto/save-publish', requireAuth, async (c) => {
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

howtoEditorRoutes.get('/api/admin/howto/pending', requireAdmin, async (c) => {
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

howtoEditorRoutes.get('/api/admin/howto/reports', requireAdmin, async (c) => {
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

howtoEditorRoutes.post('/api/admin/howto/drafts/:id/approve', requireAdmin, async (c) => {
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

howtoEditorRoutes.post('/api/admin/howto/drafts/:id/reject', requireAdmin, async (c) => {
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

howtoEditorRoutes.post('/api/admin/howto/:slug/blind', requireAdmin, async (c) => {
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

howtoEditorRoutes.post('/api/admin/howto/:slug/unblind', requireAdmin, async (c) => {
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

howtoEditorRoutes.post('/api/admin/howto/reports/:id/resolve', requireAdmin, async (c) => {
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
// Group N: HowTo 업데이트/삭제 API (Phase 1 누락 → Phase 2에서 이동)
// ============================================================================

// HowTo 업데이트 API (발행된 HowTo 수정)
howtoEditorRoutes.put('/api/howto/:id/update', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const pageId = parseInt(c.req.param('id'))

    if (!Number.isFinite(pageId)) {
      return c.json({ success: false, error: '유효하지 않은 ID입니다' }, 400)
    }

    // 권한 확인 (작성자 또는 관리자만)
    const page = await c.env.DB.prepare(
      'SELECT author_id FROM pages WHERE id = ? AND page_type = ?'
    ).bind(pageId, 'guide').first<{ author_id: number | null }>()

    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }

    const isAuthor = page.author_id && user.id === page.author_id
    const isAdmin = user.role === 'admin'

    if (!isAuthor && !isAdmin) {
      return c.json({ success: false, error: '편집 권한이 없습니다' }, 403)
    }

    const body = await c.req.json()
    const { title, summary, contentHtml, contentJson, tags, relatedJobs, relatedMajors, relatedHowtos, thumbnailUrl, footnotes } = body

    if (!title || !title.trim()) {
      return c.json({ success: false, error: '제목을 입력해주세요' }, 400)
    }

    // 첫 번째 이미지 추출 (썸네일이 명시적으로 설정되지 않은 경우)
    let finalThumbnailUrl = thumbnailUrl || ''
    let extractedFootnotes = footnotes || []
    if (contentJson) {
      try {
        const contentObj = JSON.parse(contentJson)
        if (!finalThumbnailUrl) {
          finalThumbnailUrl = extractFirstImage(contentObj)
        }
        // 각주 추출 (클라이언트에서 안 보내면 서버에서 추출)
        if (!footnotes || footnotes.length === 0) {
          extractedFootnotes = extractFootnotes(contentObj)
        }
      } catch {}
    }

    // meta_data 구성
    const metaData = JSON.stringify({
      contentJson,
      tags: tags || [],
      relatedJobs: relatedJobs || [],
      relatedMajors: relatedMajors || [],
      relatedHowtos: relatedHowtos || [],
      footnotes: extractedFootnotes,
      authorName: user.username || user.email?.split('@')[0] || '작성자',
      thumbnailUrl: finalThumbnailUrl
    })

    // 업데이트
    const now = new Date().toISOString()
    await c.env.DB.prepare(`
      UPDATE pages
      SET title = ?, summary = ?, content = ?, meta_data = ?, updated_at = ?
      WHERE id = ?
    `).bind(title.trim(), summary || '', contentHtml || '', metaData, now, pageId).run()

    return c.json({ success: true, message: '저장되었습니다' })
  } catch (error) {
    return c.json({ success: false, error: '저장 중 오류가 발생했습니다' }, 500)
  }
})

// HowTo 삭제 API
howtoEditorRoutes.delete('/api/howto/:id', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const pageId = parseInt(c.req.param('id'))

    if (!Number.isFinite(pageId)) {
      return c.json({ success: false, error: '유효하지 않은 ID입니다' }, 400)
    }

    // 권한 확인 + 이미지 삭제를 위한 content, meta_data 조회
    const page = await c.env.DB.prepare(
      'SELECT author_id, content, meta_data FROM pages WHERE id = ? AND page_type = ?'
    ).bind(pageId, 'guide').first<{ author_id: number | null; content: string | null; meta_data: string | null }>()

    if (!page) {
      return c.json({ success: false, error: 'HowTo를 찾을 수 없습니다' }, 404)
    }

    const isAuthor = page.author_id && user.id === page.author_id
    const isAdmin = user.role === 'admin'

    if (!isAuthor && !isAdmin) {
      return c.json({ success: false, error: '삭제 권한이 없습니다' }, 403)
    }

    // R2 이미지 삭제 (본문 이미지 + 썸네일)
    const imageKeysToDelete: string[] = []

    // 1) 본문에서 /uploads/ 경로 이미지 추출
    if (page.content) {
      const uploadMatches = page.content.match(/\/uploads\/[^\s"'<>]+/g) || []
      for (const match of uploadMatches) {
        const key = match.replace('/uploads/', '')
        if (key && !imageKeysToDelete.includes(key)) {
          imageKeysToDelete.push(key)
        }
      }
    }

    // 2) 썸네일 URL 추출
    if (page.meta_data) {
      try {
        const meta = JSON.parse(page.meta_data)
        if (meta.thumbnailUrl && meta.thumbnailUrl.startsWith('/uploads/')) {
          const key = meta.thumbnailUrl.replace('/uploads/', '')
          if (key && !imageKeysToDelete.includes(key)) {
            imageKeysToDelete.push(key)
          }
        }
      } catch (e) {
        // meta_data 파싱 실패 시 무시
      }
    }

    // R2에서 이미지 삭제 (실패해도 D1 삭제는 진행)
    if (imageKeysToDelete.length > 0 && c.env.UPLOADS) {
      for (const key of imageKeysToDelete) {
        try {
          await c.env.UPLOADS.delete(key)
        } catch (e) {
        }
      }
    }

    // D1에서 페이지 삭제
    await c.env.DB.prepare('DELETE FROM pages WHERE id = ?').bind(pageId).run()

    return c.json({ success: true, message: '삭제되었습니다' })
  } catch (error) {
    return c.json({ success: false, error: '삭제 중 오류가 발생했습니다' }, 500)
  }
})

export { howtoEditorRoutes }
