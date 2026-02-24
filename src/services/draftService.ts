/**
 * HowTo 초안 서비스
 * - CRUD 작업
 * - 버전 관리 (낙관적 락)
 * - 관계 데이터 관리 (태그, 연결)
 */

export interface DraftData {
  id: number
  userId: number
  baseHowtoId: number | null
  title: string | null
  slug: string | null
  summary: string | null
  thumbnailUrl: string | null
  contentJson: string | null
  contentHtml: string | null
  version: number
  stage: 'DRAFT' | 'REVIEW'
  lastSavedAt: string | null
  createdAt: string
  updatedAt: string
  publishedPageId: number | null
}

export interface DraftRelations {
  tags: string[]
  relatedJobs: Array<{ id: string; name: string; slug: string }>
  relatedMajors: Array<{ id: string; name: string; slug: string }>
  relatedHowtos: Array<{ id: number; title: string; slug: string }>
}

export interface CreateDraftPayload {
  userId: number
  baseHowtoId?: number
  title?: string
  slug?: string
  summary?: string
  thumbnailUrl?: string
  contentJson?: string
  contentHtml?: string
}

export interface UpdateDraftPayload {
  title?: string
  slug?: string
  summary?: string
  thumbnailUrl?: string
  contentJson?: string
  contentHtml?: string
  tags?: string[]
  relatedJobs?: Array<{ id: string; name: string; slug: string }>
  relatedMajors?: Array<{ id: string; name: string; slug: string }>
  relatedHowtos?: Array<{ id: number; title: string; slug: string }>
}

/**
 * 새 초안 생성
 */
export async function createDraft(
  db: D1Database,
  payload: CreateDraftPayload
): Promise<{ success: boolean; draftId?: number; error?: string }> {
  try {
    const result = await db.prepare(`
      INSERT INTO howto_drafts (
        user_id, base_howto_id, title, slug, summary, 
        thumbnail_url, content_json, content_html, last_saved_at
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
    `).bind(
      payload.userId,
      payload.baseHowtoId ?? null,
      payload.title ?? null,
      payload.slug ?? null,
      payload.summary ?? null,
      payload.thumbnailUrl ?? null,
      payload.contentJson ?? null,
      payload.contentHtml ?? null
    ).run()
    
    if (!result.success) {
      return { success: false, error: '초안 생성에 실패했습니다' }
    }
    
    return { success: true, draftId: Number(result.meta.last_row_id) }
  } catch (error) {
    return { success: false, error: '초안 생성 중 오류가 발생했습니다' }
  }
}

/**
 * 초안 조회
 */
export async function getDraft(
  db: D1Database,
  draftId: number,
  userId?: number
): Promise<{ success: boolean; draft?: DraftData & DraftRelations; error?: string }> {
  try {
    // 기본 초안 데이터 조회
    const draftRow = await db.prepare(`
      SELECT 
        id, user_id, base_howto_id, title, slug, summary,
        thumbnail_url, content_json, content_html, version, stage,
        last_saved_at, created_at, updated_at, published_page_id
      FROM howto_drafts
      WHERE id = ? ${userId ? 'AND user_id = ?' : ''}
    `).bind(...(userId ? [draftId, userId] : [draftId])).first<{
      id: number
      user_id: number
      base_howto_id: number | null
      title: string | null
      slug: string | null
      summary: string | null
      thumbnail_url: string | null
      content_json: string | null
      content_html: string | null
      version: number
      stage: 'DRAFT' | 'REVIEW'
      last_saved_at: string | null
      created_at: string
      updated_at: string
      published_page_id: number | null
    }>()
    
    if (!draftRow) {
      return { success: false, error: '초안을 찾을 수 없습니다' }
    }
    
    // 태그 조회
    const tagsResult = await db.prepare(`
      SELECT t.name FROM draft_tags dt
      JOIN tags t ON dt.tag_id = t.id
      WHERE dt.draft_id = ?
      ORDER BY t.name
    `).bind(draftId).all<{ name: string }>()
    
    // 관련 직업 조회 (JOIN 실패 시에도 job_id는 반환)
    const jobsResult = await db.prepare(`
      SELECT drj.job_id as id, COALESCE(j.name, drj.job_id) as name, drj.job_id as slug
      FROM draft_related_jobs drj
      LEFT JOIN jobs j ON drj.job_id = j.id
      WHERE drj.draft_id = ?
      ORDER BY drj.display_order
    `).bind(draftId).all<{ id: string; name: string; slug: string }>()
    
    // 관련 전공 조회 (JOIN 실패 시에도 major_id는 반환)
    const majorsResult = await db.prepare(`
      SELECT drm.major_id as id, COALESCE(m.name, drm.major_id) as name, drm.major_id as slug
      FROM draft_related_majors drm
      LEFT JOIN majors m ON drm.major_id = m.id
      WHERE drm.draft_id = ?
      ORDER BY drm.display_order
    `).bind(draftId).all<{ id: string; name: string; slug: string }>()
    
    // 관련 HowTo 조회 (JOIN 실패 시에도 howto_id는 반환)
    const howtosResult = await db.prepare(`
      SELECT drh.howto_id as id, COALESCE(p.title, CAST(drh.howto_id AS TEXT)) as name, COALESCE(p.slug, CAST(drh.howto_id AS TEXT)) as slug
      FROM draft_related_howtos drh
      LEFT JOIN pages p ON drh.howto_id = p.id AND p.page_type = 'guide'
      WHERE drh.draft_id = ?
      ORDER BY drh.display_order
    `).bind(draftId).all<{ id: number; name: string; slug: string }>()
    
    const draft: DraftData & DraftRelations = {
      id: draftRow.id,
      userId: draftRow.user_id,
      baseHowtoId: draftRow.base_howto_id,
      title: draftRow.title,
      slug: draftRow.slug,
      summary: draftRow.summary,
      thumbnailUrl: draftRow.thumbnail_url,
      contentJson: draftRow.content_json,
      contentHtml: draftRow.content_html,
      version: draftRow.version,
      stage: draftRow.stage,
      lastSavedAt: draftRow.last_saved_at,
      createdAt: draftRow.created_at,
      updatedAt: draftRow.updated_at,
      publishedPageId: draftRow.published_page_id,
      tags: tagsResult.results?.map(r => r.name) ?? [],
      relatedJobs: jobsResult.results ?? [],
      relatedMajors: majorsResult.results ?? [],
      relatedHowtos: howtosResult.results ?? []
    }
    
    return { success: true, draft }
  } catch (error) {
    return { success: false, error: '초안 조회 중 오류가 발생했습니다' }
  }
}

/**
 * 초안 업데이트 (낙관적 락)
 */
export async function updateDraft(
  db: D1Database,
  draftId: number,
  userId: number,
  expectedVersion: number,
  payload: UpdateDraftPayload
): Promise<{ success: boolean; newVersion?: number; serverVersion?: number; error?: string }> {
  try {
    // 현재 버전 확인
    const current = await db.prepare(`
      SELECT version, user_id FROM howto_drafts WHERE id = ?
    `).bind(draftId).first<{ version: number; user_id: number }>()
    
    if (!current) {
      return { success: false, error: '초안을 찾을 수 없습니다' }
    }
    
    // 소유자 확인
    if (current.user_id !== userId) {
      return { success: false, error: '수정 권한이 없습니다' }
    }
    
    // 버전 충돌 확인
    if (current.version !== expectedVersion) {
      return { 
        success: false, 
        error: 'VERSION_CONFLICT',
        serverVersion: current.version
      }
    }
    
    // 업데이트 쿼리 구성
    const updates: string[] = []
    const values: (string | number | null)[] = []
    
    if (payload.title !== undefined) {
      updates.push('title = ?')
      values.push(payload.title)
    }
    if (payload.slug !== undefined) {
      updates.push('slug = ?')
      values.push(payload.slug)
    }
    if (payload.summary !== undefined) {
      updates.push('summary = ?')
      values.push(payload.summary)
    }
    if (payload.thumbnailUrl !== undefined) {
      updates.push('thumbnail_url = ?')
      values.push(payload.thumbnailUrl)
    }
    if (payload.contentJson !== undefined) {
      updates.push('content_json = ?')
      values.push(payload.contentJson)
    }
    if (payload.contentHtml !== undefined) {
      updates.push('content_html = ?')
      values.push(payload.contentHtml)
    }
    
    // 버전 증가 및 저장 시각 업데이트
    updates.push('version = version + 1')
    updates.push('last_saved_at = CURRENT_TIMESTAMP')
    
    const result = await db.prepare(`
      UPDATE howto_drafts 
      SET ${updates.join(', ')}
      WHERE id = ? AND version = ?
    `).bind(...values, draftId, expectedVersion).run()
    
    if (!result.success || result.meta.changes === 0) {
      // 다시 버전 확인 (경쟁 조건)
      const recheck = await db.prepare(`
        SELECT version FROM howto_drafts WHERE id = ?
      `).bind(draftId).first<{ version: number }>()
      
      return { 
        success: false, 
        error: 'VERSION_CONFLICT',
        serverVersion: recheck?.version
      }
    }
    
    // 태그 업데이트
    if (payload.tags !== undefined) {
      await updateDraftTags(db, draftId, payload.tags)
    }
    
    // 관련 직업 업데이트
    if (payload.relatedJobs !== undefined) {
      await updateDraftRelatedJobs(db, draftId, payload.relatedJobs)
    }
    
    // 관련 전공 업데이트
    if (payload.relatedMajors !== undefined) {
      await updateDraftRelatedMajors(db, draftId, payload.relatedMajors)
    }
    
    // 관련 HowTo 업데이트
    if (payload.relatedHowtos !== undefined) {
      await updateDraftRelatedHowtos(db, draftId, payload.relatedHowtos)
    }
    
    return { success: true, newVersion: expectedVersion + 1 }
  } catch (error) {
    return { success: false, error: '초안 업데이트 중 오류가 발생했습니다' }
  }
}

/**
 * 내 초안 목록 조회
 */
export async function listMyDrafts(
  db: D1Database,
  userId: number,
  options: { limit?: number; offset?: number; stage?: string } = {}
): Promise<{ success: boolean; drafts?: DraftData[]; total?: number; error?: string }> {
  try {
    const { limit = 20, offset = 0, stage } = options
    
    let whereClause = 'WHERE user_id = ?'
    const bindings: (number | string)[] = [userId]
    
    if (stage) {
      whereClause += ' AND stage = ?'
      bindings.push(stage)
    }
    
    // 총 개수
    const countResult = await db.prepare(`
      SELECT COUNT(*) as total FROM howto_drafts ${whereClause}
    `).bind(...bindings).first<{ total: number }>()
    
    // 목록 조회
    const draftsResult = await db.prepare(`
      SELECT 
        id, user_id, base_howto_id, title, slug, summary,
        thumbnail_url, content_json, content_html, version, stage,
        last_saved_at, created_at, updated_at
      FROM howto_drafts
      ${whereClause}
      ORDER BY updated_at DESC
      LIMIT ? OFFSET ?
    `).bind(...bindings, limit, offset).all<{
      id: number
      user_id: number
      base_howto_id: number | null
      title: string | null
      slug: string | null
      summary: string | null
      thumbnail_url: string | null
      content_json: string | null
      content_html: string | null
      version: number
      stage: 'DRAFT' | 'REVIEW'
      last_saved_at: string | null
      created_at: string
      updated_at: string
    }>()
    
    const drafts: DraftData[] = (draftsResult.results ?? []).map(row => ({
      id: row.id,
      userId: row.user_id,
      baseHowtoId: row.base_howto_id,
      title: row.title,
      slug: row.slug,
      summary: row.summary,
      thumbnailUrl: row.thumbnail_url,
      contentJson: row.content_json,
      contentHtml: row.content_html,
      version: row.version,
      stage: row.stage,
      lastSavedAt: row.last_saved_at,
      createdAt: row.created_at,
      updatedAt: row.updated_at
    }))
    
    return { success: true, drafts, total: countResult?.total ?? 0 }
  } catch (error) {
    return { success: false, error: '초안 목록 조회 중 오류가 발생했습니다' }
  }
}

/**
 * 초안 삭제
 */
export async function deleteDraft(
  db: D1Database,
  draftId: number,
  userId: number
): Promise<{ success: boolean; error?: string }> {
  try {
    const result = await db.prepare(`
      DELETE FROM howto_drafts WHERE id = ? AND user_id = ?
    `).bind(draftId, userId).run()
    
    if (!result.success || result.meta.changes === 0) {
      return { success: false, error: '초안을 찾을 수 없거나 삭제 권한이 없습니다' }
    }
    
    return { success: true }
  } catch (error) {
    return { success: false, error: '초안 삭제 중 오류가 발생했습니다' }
  }
}

/**
 * 검수 요청 (DRAFT → REVIEW)
 */
export async function submitForReview(
  db: D1Database,
  draftId: number,
  userId: number
): Promise<{ success: boolean; error?: string }> {
  try {
    // 초안 확인
    const draft = await db.prepare(`
      SELECT id, user_id, title, content_json, stage 
      FROM howto_drafts WHERE id = ?
    `).bind(draftId).first<{
      id: number
      user_id: number
      title: string | null
      content_json: string | null
      stage: string
    }>()
    
    if (!draft) {
      return { success: false, error: '초안을 찾을 수 없습니다' }
    }
    
    if (draft.user_id !== userId) {
      return { success: false, error: '권한이 없습니다' }
    }
    
    if (draft.stage === 'REVIEW') {
      return { success: false, error: '이미 검수 요청된 초안입니다' }
    }
    
    // 필수 필드 확인
    if (!draft.title || !draft.title.trim()) {
      return { success: false, error: '제목을 입력해주세요' }
    }
    
    if (!draft.content_json) {
      return { success: false, error: '본문을 작성해주세요' }
    }
    
    // 최소 길이 확인 (JSON 파싱 후)
    try {
      const content = JSON.parse(draft.content_json)
      // Tiptap 문서의 텍스트 길이 확인
      const textLength = extractTextLength(content)
      if (textLength < 100) {
        return { success: false, error: '본문은 최소 100자 이상 작성해주세요' }
      }
    } catch {
      return { success: false, error: '본문 형식이 올바르지 않습니다' }
    }
    
    // 상태 변경
    await db.prepare(`
      UPDATE howto_drafts SET stage = 'REVIEW' WHERE id = ?
    `).bind(draftId).run()
    
    return { success: true }
  } catch (error) {
    return { success: false, error: '검수 요청 중 오류가 발생했습니다' }
  }
}

// =====================================================
// 헬퍼 함수
// =====================================================

/**
 * Tiptap JSON에서 텍스트 길이 추출
 */
function extractTextLength(doc: unknown): number {
  if (!doc || typeof doc !== 'object') return 0
  
  let length = 0
  const stack = [doc]
  
  while (stack.length > 0) {
    const node = stack.pop() as Record<string, unknown>
    
    if (node.text && typeof node.text === 'string') {
      length += node.text.length
    }
    
    if (Array.isArray(node.content)) {
      stack.push(...node.content)
    }
  }
  
  return length
}

/**
 * 태그 업데이트
 */
async function updateDraftTags(db: D1Database, draftId: number, tags: string[]): Promise<void> {
  // 기존 태그 삭제
  await db.prepare(`DELETE FROM draft_tags WHERE draft_id = ?`).bind(draftId).run()
  
  for (const tagName of tags) {
    const trimmed = tagName.trim()
    if (!trimmed) continue
    
    // 태그 조회 또는 생성
    let tag = await db.prepare(`SELECT id FROM tags WHERE name = ?`).bind(trimmed).first<{ id: number }>()
    
    if (!tag) {
      const slug = trimmed.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9가-힣-]/g, '')
      const result = await db.prepare(`
        INSERT INTO tags (name, slug) VALUES (?, ?)
      `).bind(trimmed, slug).run()
      tag = { id: Number(result.meta.last_row_id) }
    }
    
    // 연결
    await db.prepare(`
      INSERT OR IGNORE INTO draft_tags (draft_id, tag_id) VALUES (?, ?)
    `).bind(draftId, tag.id).run()
  }
}

/**
 * 관련 직업 업데이트
 */
async function updateDraftRelatedJobs(
  db: D1Database, 
  draftId: number, 
  jobs: Array<{ id: string; name: string; slug: string }>
): Promise<void> {
  await db.prepare(`DELETE FROM draft_related_jobs WHERE draft_id = ?`).bind(draftId).run()
  
  for (let i = 0; i < jobs.length; i++) {
    await db.prepare(`
      INSERT INTO draft_related_jobs (draft_id, job_id, display_order) VALUES (?, ?, ?)
    `).bind(draftId, jobs[i].id, i).run()
  }
}

/**
 * 관련 전공 업데이트
 */
async function updateDraftRelatedMajors(
  db: D1Database, 
  draftId: number, 
  majors: Array<{ id: string; name: string; slug: string }>
): Promise<void> {
  await db.prepare(`DELETE FROM draft_related_majors WHERE draft_id = ?`).bind(draftId).run()
  
  for (let i = 0; i < majors.length; i++) {
    await db.prepare(`
      INSERT INTO draft_related_majors (draft_id, major_id, display_order) VALUES (?, ?, ?)
    `).bind(draftId, majors[i].id, i).run()
  }
}

/**
 * 관련 HowTo 업데이트
 */
async function updateDraftRelatedHowtos(
  db: D1Database, 
  draftId: number, 
  howtos: Array<{ id: number; title: string; slug: string }>
): Promise<void> {
  await db.prepare(`DELETE FROM draft_related_howtos WHERE draft_id = ?`).bind(draftId).run()
  
  for (let i = 0; i < howtos.length; i++) {
    await db.prepare(`
      INSERT INTO draft_related_howtos (draft_id, howto_id, display_order) VALUES (?, ?, ?)
    `).bind(draftId, howtos[i].id, i).run()
  }
}

