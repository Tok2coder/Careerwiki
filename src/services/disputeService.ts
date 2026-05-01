/**
 * 정책 dispute §1~§8 — 토론·합의 서비스 레이어 (D2~D8)
 */

import type { D1Database } from '@cloudflare/workers-types'

export type DisputeTargetType = 'job' | 'major' | 'howto' | 'comment' | 'policy'
export type DisputeThreadStatus = 'open' | 'consensus_pending' | 'consensus_window' | 'closed_consensus' | 'closed_no_consensus' | 'invalidated'
export type DisputeProposalStatus = 'pending' | 'awaiting_objection' | 'agreed' | 'rejected' | 'invalidated'

export interface DisputeThread {
  id: number
  target_type: DisputeTargetType
  target_id: string
  target_field: string | null
  opened_by: number | null
  opener_position: string | null
  opener_evidence: string | null
  frozen_text: string | null
  frozen_at: string
  status: DisputeThreadStatus
  resolution: string | null
  created_at: string
  updated_at: string
  closed_at: string | null
  parent_thread_id: number | null
}

/**
 * 토론 발제 (D1 진입점)
 */
export async function openDispute(
  db: D1Database,
  params: {
    targetType: DisputeTargetType
    targetId: string
    targetField?: string
    openedBy: number | null
    openerPosition: string
    openerEvidence?: string
    frozenText?: string
  }
): Promise<{ id: number }> {
  // D6 다중 토론 가드: 같은 (target_type, target_id, target_field)에 7일 이내 닫힌 토론이 있으면 parent로 연결
  const recentClosed = await db.prepare(
    `SELECT id FROM dispute_threads
     WHERE target_type = ? AND target_id = ? AND COALESCE(target_field, '') = COALESCE(?, '')
       AND status IN ('closed_consensus', 'closed_no_consensus', 'invalidated')
       AND closed_at > datetime('now', '-7 days')
     ORDER BY closed_at DESC LIMIT 1`
  ).bind(params.targetType, params.targetId, params.targetField ?? null).first<{ id: number }>()

  const result = await db.prepare(
    `INSERT INTO dispute_threads
       (target_type, target_id, target_field, opened_by, opener_position, opener_evidence, frozen_text, parent_thread_id)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?)`
  ).bind(
    params.targetType,
    params.targetId,
    params.targetField ?? null,
    params.openedBy,
    params.openerPosition,
    params.openerEvidence ?? null,
    params.frozenText ?? null,
    recentClosed?.id ?? null
  ).run()
  return { id: Number(result.meta?.last_row_id ?? 0) }
}

/**
 * 합의안 제시 (D2)
 */
export async function proposeConsensus(
  db: D1Database,
  params: {
    threadId: number
    proposerId: number
    proposedText: string
    proposedEvidence?: string
  }
): Promise<{ id: number }> {
  const result = await db.prepare(
    `INSERT INTO dispute_proposals (thread_id, proposer_id, proposed_text, proposed_evidence, status)
     VALUES (?, ?, ?, ?, 'pending')`
  ).bind(params.threadId, params.proposerId, params.proposedText, params.proposedEvidence ?? null).run()

  await db.prepare(
    `UPDATE dispute_threads SET status = 'consensus_pending', updated_at = CURRENT_TIMESTAMP WHERE id = ?`
  ).bind(params.threadId).run()

  return { id: Number(result.meta?.last_row_id ?? 0) }
}

/**
 * 동의 또는 이의 (D2)
 * - agreement_count 증가, 1명 이상 동의 시 awaiting_objection 단계로 진입
 * - 이의 제기 시:
 *   · 새 근거(commentText 30자 이상) 의무 — 단순 반대 차단
 *   · 동일인이 같은 합의안에 2회 이상 이의 제기 시 차단 (운영자 검토 필요)
 *   · 위 둘 모두 통과한 이의만 objection window 6시간 갱신 (전체 최대 2회)
 *
 * 에러 코드:
 *   OBJECTION_REQUIRES_EVIDENCE — 이의 시 30자 이상 근거 미제출
 *   OBJECTION_DUPLICATE_OBJECTOR — 동일인 2회째 이의
 */
export async function castDisputeVote(
  db: D1Database,
  params: {
    proposalId: number
    userId: number
    voteType: 'agree' | 'object' | 'comment'
    commentText?: string
  }
): Promise<void> {
  // ── 이의 제기는 사전 검증 (정책 dispute §2 + namu-wiki 비판 §4 다수결 룰 보강)
  if (params.voteType === 'object') {
    const evidence = (params.commentText || '').trim()
    if (evidence.length < 30) {
      throw new Error('OBJECTION_REQUIRES_EVIDENCE')
    }
    // 동일인이 같은 합의안에 이미 이의 제기한 적 있는지 검사
    const dup = await db.prepare(
      `SELECT id FROM dispute_votes
       WHERE proposal_id = ? AND user_id = ? AND vote_type = 'object'
       LIMIT 1`
    ).bind(params.proposalId, params.userId).first()
    if (dup) {
      throw new Error('OBJECTION_DUPLICATE_OBJECTOR')
    }
  }

  await db.prepare(
    `INSERT OR IGNORE INTO dispute_votes (proposal_id, user_id, vote_type, comment_text)
     VALUES (?, ?, ?, ?)`
  ).bind(params.proposalId, params.userId, params.voteType, params.commentText ?? null).run()

  if (params.voteType === 'agree') {
    const row = await db.prepare(
      `SELECT COUNT(DISTINCT user_id) AS c FROM dispute_votes WHERE proposal_id = ? AND vote_type = 'agree'`
    ).bind(params.proposalId).first<{ c: number }>()
    const count = Number(row?.c ?? 0)

    if (count >= 1) {
      const startsAt = new Date().toISOString()
      const endsAt = new Date(Date.now() + 48 * 3600_000).toISOString()
      await db.prepare(
        `UPDATE dispute_proposals
         SET agreement_count = ?, status = 'awaiting_objection',
             objection_window_starts_at = COALESCE(objection_window_starts_at, ?),
             objection_window_ends_at = COALESCE(objection_window_ends_at, ?)
         WHERE id = ?`
      ).bind(count, startsAt, endsAt, params.proposalId).run()
    } else {
      await db.prepare(
        `UPDATE dispute_proposals SET agreement_count = ? WHERE id = ?`
      ).bind(count, params.proposalId).run()
    }
  } else if (params.voteType === 'object') {
    const proposal = await db.prepare(
      `SELECT objection_extensions, objection_window_ends_at, status FROM dispute_proposals WHERE id = ?`
    ).bind(params.proposalId).first<{ objection_extensions: number; objection_window_ends_at: string; status: string }>()

    if (proposal && proposal.status === 'awaiting_objection' && (proposal.objection_extensions ?? 0) < 2) {
      const newEnds = new Date(Date.parse(proposal.objection_window_ends_at) + 6 * 3600_000).toISOString()
      await db.prepare(
        `UPDATE dispute_proposals
         SET objection_window_ends_at = ?, objection_extensions = objection_extensions + 1
         WHERE id = ?`
      ).bind(newEnds, params.proposalId).run()
    }
  }
}

/**
 * 만료된 합의안 일괄 종결 (cron 권장 — 매시간)
 */
export async function finalizeExpiredProposals(db: D1Database): Promise<number> {
  const expired = await db.prepare(
    `SELECT id, thread_id FROM dispute_proposals
     WHERE status = 'awaiting_objection'
       AND objection_window_ends_at < CURRENT_TIMESTAMP`
  ).all<{ id: number; thread_id: number }>()

  let count = 0
  for (const row of expired.results || []) {
    await db.prepare(
      `UPDATE dispute_proposals SET status = 'agreed', finalized_at = CURRENT_TIMESTAMP WHERE id = ?`
    ).bind(row.id).run()
    await db.prepare(
      `UPDATE dispute_threads SET status = 'closed_consensus', closed_at = CURRENT_TIMESTAMP WHERE id = ?`
    ).bind(row.thread_id).run()
    count++
  }
  return count
}

/**
 * D5 합의 무효화
 */
export async function invalidateProposal(
  db: D1Database,
  params: { proposalId: number; reason: string; invalidatedBy: number }
): Promise<void> {
  await db.prepare(
    `UPDATE dispute_proposals SET status = 'invalidated' WHERE id = ?`
  ).bind(params.proposalId).run()

  const thread = await db.prepare(`SELECT thread_id FROM dispute_proposals WHERE id = ?`).bind(params.proposalId).first<{ thread_id: number }>()
  if (thread) {
    await db.prepare(
      `UPDATE dispute_threads SET status = 'invalidated', resolution = ?, closed_at = CURRENT_TIMESTAMP WHERE id = ?`
    ).bind(params.reason, thread.thread_id).run()
  }
}

/**
 * 페이지의 활성 토론 목록 (D1 토론 버튼 카운트용)
 */
export async function listActiveDisputesForTarget(
  db: D1Database,
  targetType: DisputeTargetType,
  targetId: string
): Promise<DisputeThread[]> {
  const result = await db.prepare(
    `SELECT * FROM dispute_threads
     WHERE target_type = ? AND target_id = ?
       AND status NOT IN ('closed_consensus', 'closed_no_consensus', 'invalidated')
     ORDER BY created_at DESC`
  ).bind(targetType, targetId).all<DisputeThread>()
  return result.results || []
}

export async function getDisputeThread(
  db: D1Database,
  id: number
): Promise<DisputeThread | null> {
  const row = await db.prepare(`SELECT * FROM dispute_threads WHERE id = ? LIMIT 1`).bind(id).first<DisputeThread>()
  return row || null
}

export async function getProposalsForThread(db: D1Database, threadId: number): Promise<any[]> {
  const result = await db.prepare(
    `SELECT * FROM dispute_proposals WHERE thread_id = ? ORDER BY created_at ASC`
  ).bind(threadId).all()
  return result.results || []
}

/**
 * D7 회사 답글 등록 (운영자가 신원 확인 후 사용)
 */
export async function submitCompanyReply(
  db: D1Database,
  params: {
    commentId: number
    companyName: string
    responderName?: string
    replyContent: string
  }
): Promise<{ id: number }> {
  // 같은 댓글에 이미 승인된 회사 답글이 있으면 차단 (정책 community §6-B: 1회 답글)
  const existing = await db.prepare(
    `SELECT id FROM company_replies WHERE comment_id = ? AND status = 'approved' LIMIT 1`
  ).bind(params.commentId).first()
  if (existing) {
    throw new Error('COMPANY_REPLY_ALREADY_EXISTS')
  }
  const result = await db.prepare(
    `INSERT INTO company_replies (comment_id, company_name, responder_name, reply_content)
     VALUES (?, ?, ?, ?)`
  ).bind(params.commentId, params.companyName, params.responderName ?? null, params.replyContent).run()
  return { id: Number(result.meta?.last_row_id ?? 0) }
}
