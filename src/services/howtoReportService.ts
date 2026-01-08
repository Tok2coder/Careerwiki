/**
 * HowTo 신고/블라인드 서비스
 */
import type { D1Database } from '@cloudflare/workers-types'
import { hashIpAddress } from '../utils/anonymousEdit'

export type ReportReasonType = 'defamation' | 'obscene' | 'spam' | 'copyright' | 'false_info' | 'other'

export interface CreateReportPayload {
  pageId: number
  reporterId?: number | null      // 로그인 사용자
  reporterIp?: string | null      // 익명 사용자
  reasonType: ReportReasonType
  reasonDetail?: string
}

export interface ReportRecord {
  id: number
  page_id: number
  reporter_id: number | null
  reporter_ip_hash: string | null
  reason_type: ReportReasonType
  reason_detail: string | null
  status: 'pending' | 'resolved' | 'dismissed'
  resolved_by: number | null
  resolved_at: string | null
  created_at: string
}

// 신고 사유 한글 레이블
export const REPORT_REASON_LABELS: Record<ReportReasonType, string> = {
  defamation: '명예훼손',
  obscene: '음란물',
  spam: '스팸/광고',
  copyright: '저작권 침해',
  false_info: '허위정보',
  other: '기타'
}

// 자동 블라인드 임계값 (신고 N회 이상이면 자동 블라인드)
const AUTO_BLIND_THRESHOLD = 5

/**
 * HowTo 신고 생성
 */
export async function createHowtoReport(
  db: D1Database,
  payload: CreateReportPayload
): Promise<{ success: boolean; reportId: number; autoBlinded: boolean }> {
  const ipHash = payload.reporterIp ? await hashIpAddress(payload.reporterIp) : null
  
  // 중복 신고 확인 (동일 사용자/IP)
  const existingReport = await db.prepare(`
    SELECT id FROM howto_reports 
    WHERE page_id = ? AND (
      (reporter_id IS NOT NULL AND reporter_id = ?) OR
      (reporter_ip_hash IS NOT NULL AND reporter_ip_hash = ?)
    )
  `).bind(payload.pageId, payload.reporterId ?? null, ipHash).first()
  
  if (existingReport) {
    throw new Error('ALREADY_REPORTED')
  }
  
  // 신고 삽입
  const result = await db.prepare(`
    INSERT INTO howto_reports (page_id, reporter_id, reporter_ip_hash, reason_type, reason_detail)
    VALUES (?, ?, ?, ?, ?)
  `).bind(
    payload.pageId,
    payload.reporterId ?? null,
    ipHash,
    payload.reasonType,
    payload.reasonDetail ?? null
  ).run()
  
  if (!result.success) {
    throw new Error('신고 저장 실패')
  }
  
  // report_count 업데이트
  await db.prepare(`
    UPDATE pages SET report_count = COALESCE(report_count, 0) + 1 WHERE id = ?
  `).bind(payload.pageId).run()
  
  // 현재 신고 수 확인
  const page = await db.prepare(`SELECT report_count FROM pages WHERE id = ?`).bind(payload.pageId).first<{ report_count: number }>()
  const reportCount = page?.report_count ?? 1
  
  let autoBlinded = false
  
  // 자동 블라인드 처리
  if (reportCount >= AUTO_BLIND_THRESHOLD) {
    await db.prepare(`
      UPDATE pages 
      SET status = 'blinded', blind_reason = '신고 누적 자동 블라인드', blinded_at = CURRENT_TIMESTAMP
      WHERE id = ? AND status = 'published'
    `).bind(payload.pageId).run()
    autoBlinded = true
  }
  
  return {
    success: true,
    reportId: Number(result.meta.last_row_id),
    autoBlinded
  }
}

/**
 * 신고 목록 조회 (관리자용)
 */
export async function listHowtoReports(
  db: D1Database,
  options: { status?: string; pageId?: number; limit?: number; offset?: number } = {}
): Promise<{ reports: ReportRecord[]; total: number }> {
  const { status, pageId, limit = 50, offset = 0 } = options
  
  let whereClause = ''
  const bindings: (string | number)[] = []
  
  if (status) {
    whereClause = 'WHERE r.status = ?'
    bindings.push(status)
  }
  if (pageId) {
    whereClause = whereClause ? `${whereClause} AND r.page_id = ?` : 'WHERE r.page_id = ?'
    bindings.push(pageId)
  }
  
  const countResult = await db.prepare(`
    SELECT COUNT(*) as total FROM howto_reports r ${whereClause}
  `).bind(...bindings).first<{ total: number }>()
  
  const reports = await db.prepare(`
    SELECT r.*, p.slug as page_slug, p.title as page_title
    FROM howto_reports r
    LEFT JOIN pages p ON r.page_id = p.id
    ${whereClause}
    ORDER BY r.created_at DESC
    LIMIT ? OFFSET ?
  `).bind(...bindings, limit, offset).all<ReportRecord & { page_slug: string; page_title: string }>()
  
  return {
    reports: reports.results ?? [],
    total: countResult?.total ?? 0
  }
}

/**
 * 신고 해결/기각 처리 (관리자용)
 */
export async function resolveHowtoReport(
  db: D1Database,
  reportId: number,
  adminId: number,
  action: 'resolve' | 'dismiss'
): Promise<{ success: boolean }> {
  const newStatus = action === 'resolve' ? 'resolved' : 'dismissed'
  
  const result = await db.prepare(`
    UPDATE howto_reports 
    SET status = ?, resolved_by = ?, resolved_at = CURRENT_TIMESTAMP
    WHERE id = ?
  `).bind(newStatus, adminId, reportId).run()
  
  return { success: result.success }
}

/**
 * HowTo 블라인드 처리 (관리자용)
 */
export async function blindHowto(
  db: D1Database,
  pageId: number,
  adminId: number,
  reason: string
): Promise<{ success: boolean }> {
  const result = await db.prepare(`
    UPDATE pages 
    SET status = 'blinded', blind_reason = ?, blinded_at = CURRENT_TIMESTAMP, blinded_by = ?
    WHERE id = ?
  `).bind(reason, adminId, pageId).run()
  
  return { success: result.success }
}

/**
 * HowTo 블라인드 해제 (관리자용)
 */
export async function unblindHowto(
  db: D1Database,
  pageId: number
): Promise<{ success: boolean }> {
  const result = await db.prepare(`
    UPDATE pages 
    SET status = 'published', blind_reason = NULL, blinded_at = NULL, blinded_by = NULL
    WHERE id = ?
  `).bind(pageId).run()
  
  return { success: result.success }
}

