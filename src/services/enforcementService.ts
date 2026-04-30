/**
 * 정책 enforcement §1~§10 — 신고·이의·제재 절차 서비스 레이어
 *
 * - moderation_decisions: 운영자 검토 큐 + 결정 기록 (B2)
 * - user_appeals: 이의제기·소명 (B3, B6)
 * - user_sanctions: 단계제 제재 카운터 + 즉시 영구 사유 (B4, B5)
 *
 * 정책 문서: /policy/enforcement
 */

import type { D1Database } from '@cloudflare/workers-types'

// ============================================================================
// 타입
// ============================================================================

export type ModerationDecision = 'keep' | 'delete' | 'warn_keep' | 'request_revision'
export type ModerationPriority = 'urgent' | 'high' | 'normal' | 'low'
export type ModerationStatus = 'pending' | 'in_review' | 'decided' | 'appealed'
export type ModerationTargetType = 'comment' | 'howto' | 'wiki_edit'

export type SanctionStage = 'warn' | 'suspend_7d' | 'suspend_30d' | 'permanent'
export type SanctionStatus = 'active' | 'lifted' | 'expired'
export type SanctionReasonCategory =
  | 'hate' | 'abuse' | 'misinfo' | 'privacy' | 'spam' | 'other'
  | 'csam' | 'threat' | 'evasion' | 'malware' | 'repeated_falsehood'

export type AppealTargetType = 'comment_takedown' | 'sanction' | 'content_removal'
export type AppealStatus = 'pending' | 'reviewing' | 'accepted' | 'rejected' | 'partially_accepted' | 'expired'

export interface ModerationQueueItem {
  id: number
  target_type: ModerationTargetType
  target_id: number
  source_report_id: number | null
  source_report_type: string | null
  decision: ModerationDecision | null
  priority: ModerationPriority
  status: ModerationStatus
  sla_deadline: string | null
  auto_flagged: number
  decided_by: number | null
  decided_at: string | null
  decision_reason: string | null
  created_at: string
}

export interface UserSanction {
  id: number
  user_id: number
  stage: SanctionStage
  is_immediate: number
  reason_category: SanctionReasonCategory
  reason_detail: string | null
  started_at: string
  ends_at: string | null
  status: SanctionStatus
  issued_by: number | null
}

// ============================================================================
// 즉시 영구 사유 자동 검출 (B5)
// 정책 enforcement §6 — 단계 건너뛰기
// ============================================================================

const IMMEDIATE_PERMANENT_KEYWORDS = {
  csam: [/아동.*성착취/, /CSAM/i, /child.*porn/i, /미성년.*성행위/],
  threat: [/(?:죽이|죽여|살해).{0,8}(?:할|하겠|버리)/, /폭탄.*테러/, /흉기.*협박/, /칼.*들고/],
  evasion: [/(?:차단|밴|정지).*우회/, /부계정.*만들/, /다중계정.*우회/],
  malware: [/(?:malware|랜섬웨어|트로이|backdoor)/i, /(?:phishing|피싱).*링크/i],
}

/**
 * 텍스트가 즉시 영구 정지 사유에 해당하는지 검사 (B5)
 */
export function detectImmediatePermanent(text: string | null | undefined): {
  hit: boolean
  category: SanctionReasonCategory | null
} {
  if (!text) return { hit: false, category: null }
  for (const [cat, patterns] of Object.entries(IMMEDIATE_PERMANENT_KEYWORDS)) {
    for (const re of patterns) {
      if (re.test(text)) {
        return { hit: true, category: cat as SanctionReasonCategory }
      }
    }
  }
  return { hit: false, category: null }
}

// ============================================================================
// 큐 (B2)
// ============================================================================

export async function listPendingModerationQueue(
  db: D1Database,
  opts: { limit?: number; priority?: ModerationPriority } = {}
): Promise<ModerationQueueItem[]> {
  const limit = Math.min(opts.limit ?? 50, 200)
  const where: string[] = ["status IN ('pending', 'in_review')"]
  const bindings: any[] = []
  if (opts.priority) {
    where.push('priority = ?')
    bindings.push(opts.priority)
  }
  const whereSql = where.join(' AND ')
  const stmt = db.prepare(
    `SELECT * FROM moderation_decisions
     WHERE ${whereSql}
     ORDER BY
       CASE priority
         WHEN 'urgent' THEN 0
         WHEN 'high' THEN 1
         WHEN 'normal' THEN 2
         WHEN 'low' THEN 3
       END ASC,
       created_at ASC
     LIMIT ?`
  )
  const result = await stmt.bind(...bindings, limit).all<ModerationQueueItem>()
  return result.results || []
}

/**
 * 큐 항목 추가 (신고 접수 시 자동 호출 권장)
 */
export async function enqueueModeration(
  db: D1Database,
  params: {
    targetType: ModerationTargetType
    targetId: number
    sourceReportId?: number | null
    sourceReportType?: string | null
    priority?: ModerationPriority
    autoFlagged?: boolean
  }
): Promise<{ id: number }> {
  const priority = params.priority ?? 'normal'
  const slaHours = priority === 'urgent' ? 2 : priority === 'high' ? 24 : priority === 'normal' ? 72 : 168
  const slaDeadline = new Date(Date.now() + slaHours * 3600_000).toISOString()
  const result = await db.prepare(
    `INSERT INTO moderation_decisions (target_type, target_id, source_report_id, source_report_type, priority, sla_deadline, auto_flagged, status)
     VALUES (?, ?, ?, ?, ?, ?, ?, 'pending')`
  ).bind(
    params.targetType,
    params.targetId,
    params.sourceReportId ?? null,
    params.sourceReportType ?? null,
    priority,
    slaDeadline,
    params.autoFlagged ? 1 : 0
  ).run()
  return { id: Number(result.meta?.last_row_id ?? 0) }
}

/**
 * 4결정 처리 (B2) — 정책 enforcement §4 Phase 3
 */
export async function applyModerationDecision(
  db: D1Database,
  params: {
    queueId: number
    decision: ModerationDecision
    decidedBy: number
    note?: string
  }
): Promise<void> {
  await db.prepare(
    `UPDATE moderation_decisions
     SET decision = ?, decision_reason = ?, decided_by = ?, decided_at = CURRENT_TIMESTAMP, status = 'decided', updated_at = CURRENT_TIMESTAMP
     WHERE id = ?`
  ).bind(params.decision, params.note ?? null, params.decidedBy, params.queueId).run()
}

// ============================================================================
// 단계제 제재 (B4) + 즉시 영구 (B5)
// ============================================================================

/**
 * 사용자의 활성 제재 조회
 */
export async function getActiveSanctions(db: D1Database, userId: number): Promise<UserSanction[]> {
  const result = await db.prepare(
    `SELECT * FROM user_sanctions
     WHERE user_id = ? AND status = 'active'
       AND (ends_at IS NULL OR ends_at > CURRENT_TIMESTAMP)
     ORDER BY started_at DESC`
  ).bind(userId).all<UserSanction>()
  return result.results || []
}

/**
 * 사용자의 누적 제재 횟수 (3개월 이내) — 다음 단계 결정용
 */
export async function getRecentSanctionCount(db: D1Database, userId: number): Promise<number> {
  const row = await db.prepare(
    `SELECT COUNT(*) AS cnt FROM user_sanctions
     WHERE user_id = ? AND started_at > datetime('now', '-90 days')`
  ).bind(userId).first<{ cnt: number }>()
  return Number(row?.cnt ?? 0)
}

/**
 * 다음 단계 자동 결정 (정책 enforcement §6)
 * - 0회 → warn (1차 경고)
 * - 1회 → suspend_7d (2차 7일)
 * - 2회 → suspend_30d (3차 30일)
 * - 3회+ → permanent (4차 영구)
 */
export function nextSanctionStage(recentCount: number): SanctionStage {
  if (recentCount <= 0) return 'warn'
  if (recentCount === 1) return 'suspend_7d'
  if (recentCount === 2) return 'suspend_30d'
  return 'permanent'
}

/**
 * 제재 부과
 */
export async function issueSanction(
  db: D1Database,
  params: {
    userId: number
    stage?: SanctionStage              // 미지정 시 누적 카운트로 자동 결정
    isImmediate?: boolean              // B5 — 단계 건너뜀
    reasonCategory: SanctionReasonCategory
    reasonDetail?: string
    sourceDecisionId?: number
    issuedBy: number
  }
): Promise<UserSanction> {
  let stage: SanctionStage
  if (params.stage) {
    stage = params.stage
  } else if (params.isImmediate) {
    stage = 'permanent'
  } else {
    const recentCount = await getRecentSanctionCount(db, params.userId)
    stage = nextSanctionStage(recentCount)
  }

  let endsAt: string | null = null
  if (stage === 'suspend_7d') {
    endsAt = new Date(Date.now() + 7 * 24 * 3600_000).toISOString()
  } else if (stage === 'suspend_30d') {
    endsAt = new Date(Date.now() + 30 * 24 * 3600_000).toISOString()
  }
  // warn / permanent → endsAt = null

  const result = await db.prepare(
    `INSERT INTO user_sanctions (user_id, stage, is_immediate, reason_category, reason_detail, ends_at, source_decision_id, issued_by, status)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'active')
     RETURNING *`
  ).bind(
    params.userId,
    stage,
    params.isImmediate ? 1 : 0,
    params.reasonCategory,
    params.reasonDetail ?? null,
    endsAt,
    params.sourceDecisionId ?? null,
    params.issuedBy
  ).first<UserSanction>()

  if (!result) {
    throw new Error('SANCTION_INSERT_FAILED')
  }
  return result
}

/**
 * 작성권 차단 여부 검사 (댓글·HowTo·편집 작성 시 호출)
 * - 활성 suspend 또는 permanent 제재가 있으면 차단
 */
export async function isUserSuspended(db: D1Database, userId: number): Promise<{
  suspended: boolean
  stage: SanctionStage | null
  endsAt: string | null
}> {
  const active = await getActiveSanctions(db, userId)
  for (const s of active) {
    if (s.stage === 'suspend_7d' || s.stage === 'suspend_30d' || s.stage === 'permanent') {
      return { suspended: true, stage: s.stage, endsAt: s.ends_at }
    }
  }
  return { suspended: false, stage: null, endsAt: null }
}

// ============================================================================
// 이의제기·소명 (B3, B6)
// ============================================================================

export async function submitAppeal(
  db: D1Database,
  params: {
    userId: number
    targetType: AppealTargetType
    targetId: number
    reason: string
    evidence?: string
  }
): Promise<{ id: number }> {
  // 재소명 금지 카운터 검사
  const blocked = await db.prepare(
    `SELECT id FROM user_appeals
     WHERE user_id = ? AND target_type = ? AND target_id = ?
       AND resubmit_blocked_until IS NOT NULL
       AND resubmit_blocked_until > CURRENT_TIMESTAMP
     ORDER BY id DESC LIMIT 1`
  ).bind(params.userId, params.targetType, params.targetId).first()
  if (blocked) {
    throw new Error('APPEAL_RESUBMIT_BLOCKED')
  }

  // 30일 임시조치 만료 시각
  const tempEnds = new Date(Date.now() + 30 * 24 * 3600_000).toISOString()

  const result = await db.prepare(
    `INSERT INTO user_appeals
       (user_id, target_type, target_id, reason, evidence, temp_action_ends_at, status)
     VALUES (?, ?, ?, ?, ?, ?, 'pending')`
  ).bind(
    params.userId,
    params.targetType,
    params.targetId,
    params.reason,
    params.evidence ?? null,
    tempEnds
  ).run()
  return { id: Number(result.meta?.last_row_id ?? 0) }
}

/**
 * 운영자가 이의제기 검토·결정
 */
export async function reviewAppeal(
  db: D1Database,
  params: {
    appealId: number
    reviewedBy: number
    status: 'accepted' | 'rejected' | 'partially_accepted'
    note?: string
  }
): Promise<void> {
  // 자기 사안 회피 — 1차 결정자가 본인이면 거부
  const ownerCheck = await db.prepare(
    `SELECT a.user_id, a.target_type, a.target_id, m.decided_by AS first_decider
     FROM user_appeals a
     LEFT JOIN moderation_decisions m
       ON (a.target_type = 'comment_takedown' AND m.id = a.target_id)
     WHERE a.id = ? LIMIT 1`
  ).bind(params.appealId).first<{ user_id: number; first_decider: number | null }>()

  if (ownerCheck?.first_decider && ownerCheck.first_decider === params.reviewedBy) {
    throw new Error('APPEAL_SAME_DECIDER')
  }

  const resubmitBlock = params.status === 'rejected'
    ? new Date(Date.now() + 30 * 24 * 3600_000).toISOString()
    : null

  await db.prepare(
    `UPDATE user_appeals
     SET status = ?, reviewed_by = ?, reviewed_at = CURRENT_TIMESTAMP,
         review_note = ?, resubmit_blocked_until = ?, updated_at = CURRENT_TIMESTAMP
     WHERE id = ?`
  ).bind(params.status, params.reviewedBy, params.note ?? null, resubmitBlock, params.appealId).run()
}

export async function listUserAppeals(
  db: D1Database,
  userId: number,
  opts: { limit?: number } = {}
): Promise<any[]> {
  const limit = Math.min(opts.limit ?? 20, 100)
  const result = await db.prepare(
    `SELECT * FROM user_appeals
     WHERE user_id = ?
     ORDER BY created_at DESC
     LIMIT ?`
  ).bind(userId, limit).all()
  return result.results || []
}
