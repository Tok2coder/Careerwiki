/**
 * 커리어트리 서비스
 * 유명 인물의 실제 커리어 경로 CRUD + 직업 페이지 조회
 */
import type { D1Database } from '@cloudflare/workers-types'
import type { CareerTree, CareerTreeForJob, CareerTreeStage } from '../types/careerTree'

// ─── DB Row → Domain Object 변환 ────────────────────────────
interface CareerTreeRow {
  id: number
  person_name: string
  person_name_en: string | null
  person_title: string | null
  person_image_url: string | null
  stages_json: string
  display_priority: number
  is_active: number
  created_at: number
  updated_at: number
}

function parseCareerTree(row: CareerTreeRow): CareerTree {
  let stages: CareerTreeStage[] = []
  try {
    stages = JSON.parse(row.stages_json || '[]')
  } catch {
    stages = []
  }
  return {
    id: row.id,
    personName: row.person_name,
    personNameEn: row.person_name_en ?? undefined,
    personTitle: row.person_title ?? undefined,
    personImageUrl: row.person_image_url ?? undefined,
    stages,
    displayPriority: row.display_priority,
    isActive: row.is_active === 1,
  }
}

// ─── 직업 페이지 조회 (핵심 함수) ────────────────────────────

/**
 * 특정 직업 페이지에 표시할 커리어트리 목록 조회
 * career_tree_job_links.job_slug로 매칭, display_priority 순 정렬
 */
export async function getCareerTreesForJob(
  db: D1Database,
  jobSlug: string
): Promise<CareerTreeForJob[]> {
  const { results } = await db.prepare(`
    SELECT ct.*, ctl.stage_index
    FROM career_tree_job_links ctl
    JOIN career_trees ct ON ctl.career_tree_id = ct.id
    WHERE ctl.job_slug = ? AND ct.is_active = 1
    ORDER BY ct.display_priority ASC, ct.id ASC
  `).bind(jobSlug).all<CareerTreeRow & { stage_index: number | null }>()

  if (!results || results.length === 0) return []

  return results.map(row => ({
    ...parseCareerTree(row),
    highlightStageIndex: row.stage_index,
  }))
}

// ─── Admin CRUD ─────────────────────────────────────────────

/** 전체 커리어트리 목록 (관리자용, 비활성 포함) */
export async function listCareerTrees(db: D1Database): Promise<CareerTree[]> {
  const { results } = await db.prepare(
    'SELECT * FROM career_trees ORDER BY display_priority ASC, id DESC'
  ).all<CareerTreeRow>()
  return (results || []).map(parseCareerTree)
}

/** 단건 조회 */
export async function getCareerTreeById(
  db: D1Database,
  id: number
): Promise<(CareerTree & { linkedJobs: Array<{ jobSlug: string; stageIndex: number | null }> }) | null> {
  const row = await db.prepare(
    'SELECT * FROM career_trees WHERE id = ?'
  ).bind(id).first<CareerTreeRow>()
  if (!row) return null

  const { results: links } = await db.prepare(
    'SELECT job_slug, stage_index FROM career_tree_job_links WHERE career_tree_id = ?'
  ).bind(id).all<{ job_slug: string; stage_index: number | null }>()

  return {
    ...parseCareerTree(row),
    linkedJobs: (links || []).map(l => ({
      jobSlug: l.job_slug,
      stageIndex: l.stage_index,
    })),
  }
}

/** 커리어트리 생성 — stages 내 job_slug에서 자동으로 job_links 생성 */
export async function createCareerTree(
  db: D1Database,
  data: {
    personName: string
    personNameEn?: string
    personTitle?: string
    personImageUrl?: string
    stages: CareerTreeStage[]
    displayPriority?: number
    additionalJobLinks?: Array<{ jobSlug: string; stageIndex: number | null }>
  }
): Promise<{ id: number; linkedJobSlugs: string[] }> {
  const stagesJson = JSON.stringify(data.stages)
  const now = Date.now()

  const result = await db.prepare(`
    INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json, display_priority, is_active, created_at, updated_at)
    VALUES (?, ?, ?, ?, ?, ?, 1, ?, ?)
  `).bind(
    data.personName,
    data.personNameEn || null,
    data.personTitle || null,
    data.personImageUrl || null,
    stagesJson,
    data.displayPriority ?? 100,
    now,
    now
  ).run()

  const id = result.meta?.last_row_id as number

  // stages에서 job_slug 추출 → job_links 자동 생성
  const linkedJobSlugs = await syncJobLinks(db, id, data.stages, data.additionalJobLinks)

  return { id, linkedJobSlugs }
}

/** 커리어트리 수정 */
export async function updateCareerTree(
  db: D1Database,
  id: number,
  data: {
    personName?: string
    personNameEn?: string
    personTitle?: string
    personImageUrl?: string
    stages?: CareerTreeStage[]
    displayPriority?: number
    isActive?: boolean
    additionalJobLinks?: Array<{ jobSlug: string; stageIndex: number | null }>
  }
): Promise<{ linkedJobSlugs: string[] }> {
  const setClauses: string[] = []
  const values: any[] = []

  if (data.personName !== undefined) { setClauses.push('person_name = ?'); values.push(data.personName) }
  if (data.personNameEn !== undefined) { setClauses.push('person_name_en = ?'); values.push(data.personNameEn || null) }
  if (data.personTitle !== undefined) { setClauses.push('person_title = ?'); values.push(data.personTitle || null) }
  if (data.personImageUrl !== undefined) { setClauses.push('person_image_url = ?'); values.push(data.personImageUrl || null) }
  if (data.stages !== undefined) { setClauses.push('stages_json = ?'); values.push(JSON.stringify(data.stages)) }
  if (data.displayPriority !== undefined) { setClauses.push('display_priority = ?'); values.push(data.displayPriority) }
  if (data.isActive !== undefined) { setClauses.push('is_active = ?'); values.push(data.isActive ? 1 : 0) }

  setClauses.push('updated_at = ?')
  values.push(Date.now())
  values.push(id)

  if (setClauses.length > 1) {
    await db.prepare(
      `UPDATE career_trees SET ${setClauses.join(', ')} WHERE id = ?`
    ).bind(...values).run()
  }

  // stages가 업데이트된 경우 job_links 재생성
  let linkedJobSlugs: string[] = []
  if (data.stages !== undefined) {
    linkedJobSlugs = await syncJobLinks(db, id, data.stages, data.additionalJobLinks)
  }

  return { linkedJobSlugs }
}

/** 커리어트리 삭제 (soft delete) */
export async function deleteCareerTree(db: D1Database, id: number): Promise<void> {
  await db.prepare(
    'UPDATE career_trees SET is_active = 0, updated_at = ? WHERE id = ?'
  ).bind(Date.now(), id).run()
}

// ─── 내부 헬퍼 ──────────────────────────────────────────────

/**
 * stages 내 job_slug + additionalJobLinks → career_tree_job_links 동기화
 * 기존 links 삭제 후 새로 생성
 */
async function syncJobLinks(
  db: D1Database,
  careerTreeId: number,
  stages: CareerTreeStage[],
  additionalJobLinks?: Array<{ jobSlug: string; stageIndex: number | null }>
): Promise<string[]> {
  // 기존 links 삭제
  await db.prepare(
    'DELETE FROM career_tree_job_links WHERE career_tree_id = ?'
  ).bind(careerTreeId).run()

  // stages에서 job_slug 수집
  const linksToInsert: Array<{ jobSlug: string; stageIndex: number }> = []
  stages.forEach((stage, index) => {
    if (stage.job_slug) {
      linksToInsert.push({ jobSlug: stage.job_slug, stageIndex: index })
    }
  })

  // additionalJobLinks 추가 (UI에서 직접 지정한 연결)
  if (additionalJobLinks) {
    for (const link of additionalJobLinks) {
      // 중복 방지
      if (!linksToInsert.some(l => l.jobSlug === link.jobSlug)) {
        linksToInsert.push({
          jobSlug: link.jobSlug,
          stageIndex: link.stageIndex ?? 0,
        })
      }
    }
  }

  // batch insert
  const linkedSlugs: string[] = []
  for (const link of linksToInsert) {
    await db.prepare(
      'INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES (?, ?, ?)'
    ).bind(careerTreeId, link.jobSlug, link.stageIndex).run()
    linkedSlugs.push(link.jobSlug)
  }

  return linkedSlugs
}
