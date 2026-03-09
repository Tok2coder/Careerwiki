/**
 * 커리어트리 Admin API 라우트
 * GET    /admin/api/career-trees       — 전체 목록
 * GET    /admin/api/career-trees/:id   — 단건 조회
 * POST   /admin/api/career-trees       — 생성
 * PUT    /admin/api/career-trees/:id   — 수정
 * DELETE /admin/api/career-trees/:id   — 삭제 (soft)
 */
import { Hono } from 'hono'
import { createMiddleware } from 'hono/factory'
import type { AppEnv } from '../types/app'
import {
  listCareerTrees,
  getCareerTreeById,
  createCareerTree,
  updateCareerTree,
  deleteCareerTree,
} from '../services/careerTreeService'

/** Admin 인증: 세션 쿠키 OR X-Admin-Secret 헤더 */
const requireCareerTreeAdmin = createMiddleware<AppEnv>(async (c, next) => {
  const user = c.get('user') as { role?: string } | undefined
  const isAdmin = user?.role === 'admin' || user?.role === 'super-admin' || user?.role === 'operator'

  const adminSecret = c.req.header('X-Admin-Secret')
  const isSecretValid = adminSecret && c.env.ADMIN_SECRET && adminSecret === c.env.ADMIN_SECRET

  if (!isAdmin && !isSecretValid) {
    return c.json({ success: false, error: '관리자 권한이 필요합니다' }, 403)
  }
  return next()
})

const careerTreeAdminRoutes = new Hono<AppEnv>()

// 전체 목록
careerTreeAdminRoutes.get('/admin/api/career-trees', requireCareerTreeAdmin, async (c) => {
  try {
    const trees = await listCareerTrees(c.env.DB)
    return c.json({ success: true, data: trees })
  } catch (error) {
    console.error('Career tree list error:', error)
    return c.json({ success: false, error: '커리어트리 목록 조회 실패' }, 500)
  }
})

// 단건 조회
careerTreeAdminRoutes.get('/admin/api/career-trees/:id', requireCareerTreeAdmin, async (c) => {
  try {
    const id = parseInt(c.req.param('id'), 10)
    if (isNaN(id)) return c.json({ success: false, error: '잘못된 ID' }, 400)

    const tree = await getCareerTreeById(c.env.DB, id)
    if (!tree) return c.json({ success: false, error: '커리어트리를 찾을 수 없습니다' }, 404)

    return c.json({ success: true, data: tree })
  } catch (error) {
    console.error('Career tree get error:', error)
    return c.json({ success: false, error: '커리어트리 조회 실패' }, 500)
  }
})

// 생성
careerTreeAdminRoutes.post('/admin/api/career-trees', requireCareerTreeAdmin, async (c) => {
  try {
    const body = await c.req.json()

    if (!body.personName || !body.stages || !Array.isArray(body.stages)) {
      return c.json({ success: false, error: 'personName, stages 필수' }, 400)
    }

    const result = await createCareerTree(c.env.DB, {
      personName: body.personName,
      personNameEn: body.personNameEn,
      personTitle: body.personTitle,
      personImageUrl: body.personImageUrl,
      stages: body.stages,
      displayPriority: body.displayPriority,
      additionalJobLinks: body.additionalJobLinks,
    })

    return c.json({ success: true, data: result })
  } catch (error) {
    console.error('Career tree create error:', error)
    return c.json({ success: false, error: '커리어트리 생성 실패' }, 500)
  }
})

// 수정
careerTreeAdminRoutes.put('/admin/api/career-trees/:id', requireCareerTreeAdmin, async (c) => {
  try {
    const id = parseInt(c.req.param('id'), 10)
    if (isNaN(id)) return c.json({ success: false, error: '잘못된 ID' }, 400)

    const body = await c.req.json()

    const result = await updateCareerTree(c.env.DB, id, {
      personName: body.personName,
      personNameEn: body.personNameEn,
      personTitle: body.personTitle,
      personImageUrl: body.personImageUrl,
      stages: body.stages,
      displayPriority: body.displayPriority,
      isActive: body.isActive,
      additionalJobLinks: body.additionalJobLinks,
    })

    return c.json({ success: true, data: result })
  } catch (error) {
    console.error('Career tree update error:', error)
    return c.json({ success: false, error: '커리어트리 수정 실패' }, 500)
  }
})

// 삭제 (soft delete)
careerTreeAdminRoutes.delete('/admin/api/career-trees/:id', requireCareerTreeAdmin, async (c) => {
  try {
    const id = parseInt(c.req.param('id'), 10)
    if (isNaN(id)) return c.json({ success: false, error: '잘못된 ID' }, 400)

    await deleteCareerTree(c.env.DB, id)
    return c.json({ success: true })
  } catch (error) {
    console.error('Career tree delete error:', error)
    return c.json({ success: false, error: '커리어트리 삭제 실패' }, 500)
  }
})

export { careerTreeAdminRoutes }
