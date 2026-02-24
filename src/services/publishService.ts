/**
 * HowTo 게시/검수 서비스
 * - DRAFT → REVIEW → PUBLISHED 워크플로우
 * - HTML sanitize
 * - howtos 테이블로 게시
 */

// 허용 태그/속성 화이트리스트
const ALLOWED_TAGS = [
  'p', 'br', 'strong', 'b', 'em', 'i', 'u', 's', 'strike', 'del',
  'h1', 'h2', 'h3', 'h4', 'h5', 'h6',
  'ul', 'ol', 'li', 'blockquote', 'pre', 'code',
  'a', 'img', 'hr',
  'table', 'thead', 'tbody', 'tr', 'th', 'td',
  'div', 'span', 'mark',
  // 커스텀 블록
  'div[data-checkpoint-box]', 'div[data-conclusion-box]',
  'div[data-qna-block]', 'div[data-qna-question]', 'div[data-qna-answer]',
  'div[data-career-list]', 'div[data-career-list-item]'
]

const ALLOWED_ATTRS: Record<string, string[]> = {
  '*': ['class', 'style'],
  'a': ['href', 'target', 'rel'],
  'img': ['src', 'alt', 'width', 'height', 'loading'],
  'div': ['data-checkpoint-box', 'data-conclusion-box', 'data-qna-block', 
          'data-qna-question', 'data-qna-answer', 'data-career-list', 'data-career-list-item'],
  'input': ['type', 'checked', 'disabled']
}

/**
 * 간단한 HTML sanitize (서버측)
 * 실제 프로덕션에서는 sanitize-html 패키지 사용 권장
 */
export function sanitizeHtml(html: string): string {
  if (!html) return ''
  
  // 스크립트 태그 제거
  let clean = html.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
  
  // on* 이벤트 핸들러 제거
  clean = clean.replace(/\s+on\w+\s*=\s*["'][^"']*["']/gi, '')
  clean = clean.replace(/\s+on\w+\s*=\s*[^\s>]+/gi, '')
  
  // javascript: URL 제거
  clean = clean.replace(/href\s*=\s*["']javascript:[^"']*["']/gi, 'href="#"')
  
  // data: URL 이미지 허용 (단, script는 차단)
  clean = clean.replace(/src\s*=\s*["']data:(?!image\/)[^"']*["']/gi, 'src=""')
  
  // iframe, embed, object 제거
  clean = clean.replace(/<(iframe|embed|object|applet|form)[^>]*>[\s\S]*?<\/\1>/gi, '')
  clean = clean.replace(/<(iframe|embed|object|applet|form)[^>]*\/>/gi, '')
  
  // style 태그 제거
  clean = clean.replace(/<style\b[^<]*(?:(?!<\/style>)<[^<]*)*<\/style>/gi, '')
  
  // meta, link 태그 제거
  clean = clean.replace(/<(meta|link|base)[^>]*\/?>/gi, '')
  
  return clean.trim()
}

/**
 * 초안 승인 (REVIEW → PUBLISHED)
 */
export async function approveDraft(
  db: D1Database,
  draftId: number,
  reviewerId: number
): Promise<{ success: boolean; howtoId?: number; slug?: string; error?: string }> {
  try {
    // 초안 조회
    const draft = await db.prepare(`
      SELECT 
        d.id, d.user_id, d.base_howto_id, d.title, d.slug, d.summary,
        d.thumbnail_url, d.content_json, d.content_html, d.stage
      FROM howto_drafts d
      WHERE d.id = ? AND d.stage = 'REVIEW'
    `).bind(draftId).first<{
      id: number
      user_id: number
      base_howto_id: number | null
      title: string | null
      slug: string | null
      summary: string | null
      thumbnail_url: string | null
      content_json: string | null
      content_html: string | null
      stage: string
    }>()
    
    if (!draft) {
      return { success: false, error: '검수 요청된 초안을 찾을 수 없습니다' }
    }
    
    if (!draft.title || !draft.content_json) {
      return { success: false, error: '제목과 본문이 필요합니다' }
    }
    
    // HTML sanitize
    const cleanHtml = sanitizeHtml(draft.content_html || '')
    
    // 슬러그 생성/확인
    let slug = draft.slug
    if (!slug) {
      const { checkAndGenerateUniqueSlug } = await import('./slugService')
      const slugResult = await checkAndGenerateUniqueSlug(db, draft.title, draft.base_howto_id ?? undefined)
      if (!slugResult.success) {
        return { success: false, error: slugResult.error }
      }
      slug = slugResult.slug!
    }
    
    let howtoId: number
    
    if (draft.base_howto_id) {
      // 기존 글 수정
      const existing = await db.prepare(`SELECT id, slug FROM howtos WHERE id = ?`).bind(draft.base_howto_id).first<{ id: number; slug: string }>()
      
      if (!existing) {
        return { success: false, error: '원본 HowTo를 찾을 수 없습니다' }
      }
      
      // 슬러그가 변경되었으면 히스토리에 기록
      if (existing.slug !== slug) {
        const { recordSlugHistory } = await import('./slugService')
        await recordSlugHistory(db, existing.id, existing.slug)
      }
      
      // 업데이트
      await db.prepare(`
        UPDATE howtos SET
          title = ?, slug = ?, summary = ?, thumbnail_url = ?,
          content_json = ?, content_html = ?, version = version + 1
        WHERE id = ?
      `).bind(
        draft.title, slug, draft.summary, draft.thumbnail_url,
        draft.content_json, cleanHtml, existing.id
      ).run()
      
      howtoId = existing.id
    } else {
      // 새 글 생성
      const result = await db.prepare(`
        INSERT INTO howtos (
          author_id, title, slug, summary, thumbnail_url,
          content_json, content_html, version
        ) VALUES (?, ?, ?, ?, ?, ?, ?, 1)
      `).bind(
        draft.user_id, draft.title, slug, draft.summary, draft.thumbnail_url,
        draft.content_json, cleanHtml
      ).run()
      
      if (!result.success) {
        return { success: false, error: '게시 중 오류가 발생했습니다' }
      }
      
      howtoId = Number(result.meta.last_row_id)
    }
    
    // 태그, 관련 콘텐츠 복사 (draft_ 테이블 → 본 테이블)
    await copyDraftRelations(db, draftId, howtoId)
    
    // 검수 로그 기록
    await db.prepare(`
      INSERT INTO howto_reviews (draft_id, reviewer_id, decision)
      VALUES (?, ?, 'APPROVED')
    `).bind(draftId, reviewerId).run()
    
    // 초안 삭제
    await db.prepare(`DELETE FROM howto_drafts WHERE id = ?`).bind(draftId).run()
    
    return { success: true, howtoId, slug }
  } catch (error) {
    return { success: false, error: '승인 처리 중 오류가 발생했습니다' }
  }
}

/**
 * 초안 반려 (REVIEW → DRAFT)
 */
export async function rejectDraft(
  db: D1Database,
  draftId: number,
  reviewerId: number,
  reason: string
): Promise<{ success: boolean; error?: string }> {
  try {
    // 초안 확인
    const draft = await db.prepare(`
      SELECT id, stage FROM howto_drafts WHERE id = ? AND stage = 'REVIEW'
    `).bind(draftId).first<{ id: number; stage: string }>()
    
    if (!draft) {
      return { success: false, error: '검수 요청된 초안을 찾을 수 없습니다' }
    }
    
    // 상태 변경
    await db.prepare(`
      UPDATE howto_drafts SET stage = 'DRAFT' WHERE id = ?
    `).bind(draftId).run()
    
    // 검수 로그 기록
    await db.prepare(`
      INSERT INTO howto_reviews (draft_id, reviewer_id, decision, reason)
      VALUES (?, ?, 'REJECTED', ?)
    `).bind(draftId, reviewerId, reason).run()
    
    return { success: true }
  } catch (error) {
    return { success: false, error: '반려 처리 중 오류가 발생했습니다' }
  }
}

/**
 * 검수 대기 목록 (관리자용)
 */
export async function listPendingReviews(
  db: D1Database,
  options: { limit?: number; offset?: number } = {}
): Promise<{ success: boolean; drafts?: unknown[]; total?: number; error?: string }> {
  const { limit = 20, offset = 0 } = options
  
  try {
    const countResult = await db.prepare(`
      SELECT COUNT(*) as total FROM howto_drafts WHERE stage = 'REVIEW'
    `).first<{ total: number }>()
    
    const draftsResult = await db.prepare(`
      SELECT 
        d.id, d.user_id, d.title, d.slug, d.summary, d.stage,
        d.created_at, d.updated_at,
        u.username, u.email
      FROM howto_drafts d
      LEFT JOIN users u ON d.user_id = u.id
      WHERE d.stage = 'REVIEW'
      ORDER BY d.updated_at DESC
      LIMIT ? OFFSET ?
    `).bind(limit, offset).all()
    
    return {
      success: true,
      drafts: draftsResult.results ?? [],
      total: countResult?.total ?? 0
    }
  } catch (error) {
    return { success: false, error: '조회 중 오류가 발생했습니다' }
  }
}

/**
 * 초안 관계 데이터 복사
 */
async function copyDraftRelations(db: D1Database, draftId: number, howtoId: number): Promise<void> {
  // 기존 관계 삭제
  await db.prepare(`DELETE FROM howto_tags WHERE howto_id = ?`).bind(howtoId).run()
  await db.prepare(`DELETE FROM howto_related_jobs WHERE howto_id = ?`).bind(howtoId).run()
  await db.prepare(`DELETE FROM howto_related_majors WHERE howto_id = ?`).bind(howtoId).run()
  await db.prepare(`DELETE FROM howto_related_howtos WHERE parent_howto_id = ?`).bind(howtoId).run()
  
  // 태그 복사
  await db.prepare(`
    INSERT INTO howto_tags (howto_id, tag_id)
    SELECT ?, tag_id FROM draft_tags WHERE draft_id = ?
  `).bind(howtoId, draftId).run()
  
  // 관련 직업 복사
  await db.prepare(`
    INSERT INTO howto_related_jobs (howto_id, job_id, display_order)
    SELECT ?, job_id, display_order FROM draft_related_jobs WHERE draft_id = ?
  `).bind(howtoId, draftId).run()
  
  // 관련 전공 복사
  await db.prepare(`
    INSERT INTO howto_related_majors (howto_id, major_id, display_order)
    SELECT ?, major_id, display_order FROM draft_related_majors WHERE draft_id = ?
  `).bind(howtoId, draftId).run()
  
  // 관련 HowTo 복사
  await db.prepare(`
    INSERT INTO howto_related_howtos (parent_howto_id, child_howto_id, display_order)
    SELECT ?, howto_id, display_order FROM draft_related_howtos WHERE draft_id = ?
  `).bind(howtoId, draftId).run()
}

