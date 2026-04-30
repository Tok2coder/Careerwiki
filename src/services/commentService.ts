import type { D1Database } from '@cloudflare/workers-types'
import { filterProfanity } from './profanityService'

export type PageType = 'job' | 'major' | 'guide'
export type CommentStatus = 'visible' | 'blinded' | 'deleted'
export type VoteDirection = 'up' | 'down' | 'clear'
export type VoteValue = -1 | 0 | 1
export type UserRole = 'super-admin' | 'operator' | 'user'

const DEFAULT_PAGE_CONTENT = '# Synthetic placeholder\n\nThis placeholder record enables comments for SSR pages.'

const BEST_LIKE_THRESHOLD = 5  // Updated: 5개 이상 공감 필요
const BEST_LIMIT = 10
export const REPORT_BLIND_THRESHOLD = 3  // Updated: 3회 이상 신고 시 블라인드
const DAILY_VOTE_LIMIT = 5
const VOTE_WINDOW_HOURS = 24
const ANONYMOUS_DAILY_COMMENT_LIMIT = 5  // 익명 사용자 하루 최대 5건
const LOGGED_IN_DAILY_COMMENT_LIMIT = 30  // 로그인 사용자 하루 최대 30건
const PASSWORD_MAX_ATTEMPTS = 5  // 비밀번호 시도 최대 5회/일
const DEFAULT_IP_DISPLAY_MODE: 'masked' = 'masked'
const MODERATOR_IP_BLOCK_ENABLED = true
const MODERATOR_ROLE_ORDER: ReadonlyArray<UserRole> = ['super-admin', 'operator']
const BLINDED_PLACEHOLDER = '신고 누적으로 블라인드 처리된 댓글입니다.'
const MAX_CONTENT_LENGTH = 500  // 한글 기준 500자
const MAX_DEPTH = 3  // 최대 3단계 답글

const MODERATOR_ROLES: ReadonlySet<UserRole> = new Set(['super-admin', 'operator'])

interface PageRecordRow {
  id: number
  slug: string
  title: string
  page_type: PageType
  summary: string | null
  meta_data: string | null
}

export interface PageRecord extends PageRecordRow {}

export interface CommentRecord {
  id: number
  pageId: number
  parentId: number | null
  authorId: string | null
  authorRole?: string | null  // 작성자 역할 (admin, expert, user 등)
  authorPictureUrl?: string | null  // 작성자 프로필 이미지 (custom > OAuth > null)
  nickname: string
  content: string
  likeCount: number
  dislikeCount: number
  reportCount: number
  status: CommentStatus
  isAnonymous: boolean
  displayIp: string | null
  createdAt: string
  viewerVote: VoteValue
  passwordHash?: string | null  // 익명 댓글 비밀번호 해시
  anonymousNumber?: number | null  // 익명 번호 (익명 1, 익명 2, ...)
  isEdited?: boolean  // 수정 여부
  editedAt?: string | null  // 수정 시간
  mentions?: string[] | null  // 멘션된 사용자/댓글 ID 배열
  depth?: number  // 답글 깊이 (0=최상위, 1=답글, 2=답글의 답글, 3=최대)
  moderated?: boolean  // 욕설 필터 적용 여부
  originalContent?: string | null  // 필터링 전 원본 내용
}

export interface CommentThread extends CommentRecord {
  replies: CommentRecord[]
  isBest: boolean
}

export interface CommentListResult {
  page: PageRecord
  comments: CommentThread[]
  totalCount: number
  policy: {
    bestLikeThreshold: number
    bestLimit: number
    reportBlindThreshold: number
    requiresAuth: boolean
    dailyVoteLimit: number
    voteWindowHours: number
    ipDisplayMode: 'hash' | 'masked' | 'hidden'
    moderatorIpBlockEnabled: boolean
    moderatorRoles: UserRole[]
  }
  nextAnonymousNumber?: number  // 익명 사용자를 위한 다음 익명 번호 (읽기 전용)
}

export interface CreateCommentPayload {
  slug: string
  pageType: PageType
  title: string
  summary?: string | null
  content: string
  nickname?: string | null
  parentId?: number | null
  authorId: string | null  // Phase 3 Day 3: 익명 사용자 지원을 위해 null 허용
  isAnonymous?: boolean
  ipHash?: string | null
  displayIp?: string | null
  password?: string | null  // 익명 댓글 비밀번호 (4자리 숫자)
  mentions?: string[] | null  // 멘션된 사용자/댓글 ID 배열
  requestAnonymous?: boolean  // 로그인 사용자가 익명으로 작성 요청
}

export interface VotePayload {
  commentId: number
  userId: string  // 로그인 사용자 ID 또는 익명 투표 시 ip 해시 기반 ID
  direction: VoteDirection
}

export interface ReportPayload {
  commentId: number
  reporterId: string
  reporterIpHash?: string | null
  reason?: string | null
  /** 정책 enforcement §2: 신고 사유 6종 (혐오/욕설/허위/개인정보/스팸/기타) */
  reasonType?: 'hate' | 'abuse' | 'misinfo' | 'privacy' | 'spam' | 'other' | null
  /** 신고자 가입 시점 (B8: 24시간 내 가입자 신고권 제한 검사용) */
  reporterJoinedAt?: string | null
}

/** 정책 enforcement §2-A: 신고 사유 6종 */
export const COMMENT_REPORT_REASON_TYPES = ['hate', 'abuse', 'misinfo', 'privacy', 'spam', 'other'] as const
export type CommentReportReasonType = typeof COMMENT_REPORT_REASON_TYPES[number]

export const COMMENT_REPORT_REASON_LABELS: Record<CommentReportReasonType, string> = {
  hate: '혐오·차별',
  abuse: '욕설·인신공격',
  misinfo: '허위 사실·명예훼손',
  privacy: '개인정보 노출',
  spam: '스팸·광고·도배',
  other: '기타'
}

export interface IpBlockRecord {
  id: number
  ipHash: string
  reason: string | null
  status: 'active' | 'released'
  blockedBy: string | null
  createdAt: string
  releasedAt: string | null
}

const normalizeNickname = (value: string | null | undefined): string => {
  if (!value) return '익명'
  const trimmed = value.trim()
  return trimmed.length ? trimmed.slice(0, 40) : '익명'
}

const normalizeContent = (value: string): string => {
  // 한글 기준 500자 제한 (실제로는 바이트 기준이지만, 간단히 문자 수로 제한)
  const trimmed = value.trim()
  return trimmed.length > MAX_CONTENT_LENGTH ? trimmed.slice(0, MAX_CONTENT_LENGTH) : trimmed
}

// 비밀번호 해시 생성 (간단한 해시, 실제로는 더 강력한 해시 사용 권장)
const hashPassword = async (password: string): Promise<string> => {
  if (!password || password.length !== 4 || !/^\d{4}$/.test(password)) {
    throw new Error('INVALID_PASSWORD')
  }
  // Web Crypto API 사용
  const encoder = new TextEncoder()
  const data = encoder.encode(password)
  const hashBuffer = await crypto.subtle.digest('SHA-256', data)
  const hashArray = Array.from(new Uint8Array(hashBuffer))
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('')
}

// 비밀번호 검증
const verifyPassword = async (password: string, hash: string): Promise<boolean> => {
  try {
    const computedHash = await hashPassword(password)
    return computedHash === hash
  } catch {
    return false
  }
}

const normalizeDisplayIp = (value: string | null | undefined): string | null => {
  if (!value) return null
  return value.trim().slice(0, 80)
}

const sanitizeReason = (value: string | null | undefined, maxLength = 200): string | null => {
  if (!value) return null
  const trimmed = value.trim()
  if (!trimmed) return null
  return trimmed.slice(0, maxLength)
}

const isModeratorRole = (role: UserRole | null | undefined): boolean => (role ? MODERATOR_ROLES.has(role) : false)

const applyViewerPolicy = (record: CommentRecord, role: UserRole): CommentRecord => {
  // 익명 댓글: displayIp는 이미 마스킹된 상태. 일반 사용자도 표시 허용.
  const allowIp = isModeratorRole(role)
    ? record.displayIp
    : record.isAnonymous
      ? record.displayIp
      : null
  if (role === 'user' && record.status !== 'visible') {
    return {
      ...record,
      content: BLINDED_PLACEHOLDER,
      displayIp: allowIp,
      likeCount: record.likeCount,
      dislikeCount: record.dislikeCount
    }
  }
  return {
    ...record,
    displayIp: allowIp
  }
}

const mapRowToIpBlock = (row: any): IpBlockRecord => ({
  id: Number(row.id),
  ipHash: String(row.ip_hash),
  reason: typeof row.reason === 'string' ? row.reason : null,
  status: row.status === 'released' ? 'released' : 'active',
  blockedBy: typeof row.blocked_by === 'string' ? row.blocked_by : null,
  createdAt: typeof row.created_at === 'string' ? row.created_at : new Date().toISOString(),
  releasedAt: typeof row.released_at === 'string' ? row.released_at : null
})

const mapRowToComment = (row: any): CommentRecord => {
  const voteRaw = Number(row.viewer_vote ?? 0)
  const viewerVote: VoteValue = voteRaw === 1 ? 1 : voteRaw === -1 ? -1 : 0

  // 멘션 파싱
  let mentions: string[] | null = null
  if (row.mentions && typeof row.mentions === 'string') {
    try {
      const parsed = JSON.parse(row.mentions)
      mentions = Array.isArray(parsed) ? parsed : null
    } catch {
      mentions = null
    }
  }

  // 프로필 이미지 우선순위: custom_picture_url > picture_url > null
  const authorPictureUrl = row.author_custom_picture_url || row.author_picture_url || null

  return {
    id: Number(row.id),
    pageId: Number(row.page_id),
    parentId: row.parent_id !== null ? Number(row.parent_id) : null,
    authorId: typeof row.author_id === 'string' ? row.author_id : null,
    authorRole: typeof row.author_role === 'string' ? row.author_role : null,
    authorPictureUrl,
    nickname: typeof row.nickname === 'string' && row.nickname.trim() ? row.nickname.trim() : '익명',
    content: typeof row.content === 'string' ? row.content : '',
    likeCount: Number(row.likes ?? 0),
    dislikeCount: Number(row.dislike_count ?? 0),
    reportCount: Number(row.report_count ?? 0),
    status: (row.status as CommentStatus) ?? 'visible',
    isAnonymous: Number(row.is_anonymous ?? 0) === 1,
    displayIp: row.display_ip ?? null,
    createdAt: typeof row.created_at === 'string' ? row.created_at : new Date().toISOString(),
    viewerVote,
    passwordHash: typeof row.password_hash === 'string' ? row.password_hash : null,
    anonymousNumber: row.anonymous_number !== null && row.anonymous_number !== undefined ? Number(row.anonymous_number) : null,
    isEdited: Number(row.is_edited ?? 0) === 1,
    editedAt: typeof row.edited_at === 'string' ? row.edited_at : null,
    mentions,
    depth: row.depth !== null && row.depth !== undefined ? Number(row.depth) : 0,
    moderated: Number(row.moderated ?? 0) === 1,
    originalContent: typeof row.original_content === 'string' ? row.original_content : null
  }
}

// 깊이 계산 헬퍼 함수
const calculateDepth = (comment: CommentRecord, byId: Map<number, CommentThread>, depth = 0): number => {
  if (!comment.parentId || depth >= MAX_DEPTH) {
    return depth
  }
  const parent = byId.get(comment.parentId)
  if (!parent) {
    return depth
  }
  return calculateDepth(parent, byId, depth + 1)
}

const toThreads = (records: CommentRecord[], bestSet: Set<number>): CommentThread[] => {
  const byId = new Map<number, CommentThread>()
  const roots: CommentThread[] = []

  records.forEach((record) => {
    byId.set(record.id, {
      ...record,
      replies: [],
      isBest: bestSet.has(record.id),
      depth: record.depth ?? 0
    })
  })

  // 깊이 계산
  byId.forEach((comment) => {
    if (comment.parentId && byId.has(comment.parentId)) {
      const parent = byId.get(comment.parentId)!
      const depth = calculateDepth(comment, byId)
      comment.depth = Math.min(depth, MAX_DEPTH)
      parent.replies.push(comment)
    } else {
      comment.depth = 0
      roots.push(comment)
    }
  })

  // 답글 정렬 (최신순)
  byId.forEach((comment) => {
    comment.replies.sort((a, b) => (a.createdAt < b.createdAt ? 1 : -1))
  })

  return roots
}

const recalcCommentVotes = async (db: D1Database, commentId: number): Promise<void> => {
  const counts = await db
    .prepare(
      `SELECT
         SUM(CASE WHEN vote = 1 THEN 1 ELSE 0 END) AS likes,
         SUM(CASE WHEN vote = -1 THEN 1 ELSE 0 END) AS dislikes
       FROM comment_votes
       WHERE comment_id = ?`
    )
    .bind(commentId)
    .first<{ likes: number; dislikes: number }>()

  const likeCount = Number(counts?.likes ?? 0)
  const dislikeCount = Number(counts?.dislikes ?? 0)

  await db
    .prepare(
      `UPDATE comments
       SET likes = ?, dislike_count = ?, flagged = CASE WHEN status = 'visible' THEN 0 ELSE 1 END
       WHERE id = ?`
    )
    .bind(likeCount, dislikeCount, commentId)
    .run()
}

const recalcCommentReports = async (db: D1Database, commentId: number): Promise<void> => {
  const countRow = await db
    .prepare('SELECT COUNT(*) AS reports FROM comment_reports WHERE comment_id = ?')
    .bind(commentId)
    .first<{ reports: number }>()

  const reportCount = Number(countRow?.reports ?? 0)
  let status: CommentStatus | null = null

  if (reportCount >= REPORT_BLIND_THRESHOLD) {
    // 정책 community §5-E (B1): 신고 N개 자동 누적 → 자동 블라인드 시
    // 자살·자해 SOS 신호가 포함된 댓글은 보호한다 (에브리타임 사고 교훈).
    // 운영자가 직접 검토하기 전까지는 가시 상태 유지하고 flagged만 켜서 큐에 올린다.
    let preserveSosGlobally = false
    try {
      const { detectSelfHarmSignal } = await import('../utils/safety')
      const target = await db
        .prepare('SELECT content FROM comments WHERE id = ? LIMIT 1')
        .bind(commentId)
        .first<{ content: string }>()
      if (target?.content && detectSelfHarmSignal(target.content)) {
        preserveSosGlobally = true
      }
    } catch (err) {
      console.error('[recalcCommentReports] sos-detect failed:', err)
    }
    status = preserveSosGlobally ? null : 'blinded'
  }

  const queryParts = ['UPDATE comments SET report_count = ?, flagged = ?']
  const bindings: Array<number | string> = [reportCount, reportCount >= REPORT_BLIND_THRESHOLD ? 1 : 0]

  if (status) {
    queryParts.push(', status = ?')
    bindings.push(status)
  }

  queryParts.push(' WHERE id = ?')
  bindings.push(commentId)

  await db.prepare(queryParts.join('')).bind(...bindings).run()
}

export const ensurePageRecord = async (
  db: D1Database,
  page: { slug: string; title: string; pageType: PageType; summary?: string | null; meta?: Record<string, unknown> | null }
): Promise<PageRecord> => {
  const existing = await db
    .prepare('SELECT id, slug, title, page_type, summary, meta_data FROM pages WHERE slug = ? LIMIT 1')
    .bind(page.slug)
    .first<PageRecordRow>()

  if (existing) {
    return existing
  }

  const metaJson = page.meta ? JSON.stringify(page.meta) : null

  const result = await db
    .prepare(
      `INSERT INTO pages (slug, title, page_type, content, summary, meta_data)
       VALUES (?, ?, ?, ?, ?, ?)`
    )
    .bind(page.slug, page.title, page.pageType, DEFAULT_PAGE_CONTENT, page.summary ?? null, metaJson)
    .run()

  const pageId = Number(result.meta?.last_row_id)

  return {
    id: pageId,
    slug: page.slug,
    title: page.title,
    page_type: page.pageType,
    summary: page.summary ?? null,
    meta_data: metaJson
  }
}

export const getCommentsForPage = async (
  db: D1Database,
  options: { pageId: number; limit?: number; viewerId?: string | null; viewerRole?: UserRole; includeModerated?: boolean }
): Promise<{ comments: CommentThread[]; totalCount: number; policy: CommentListResult['policy'] }> => {
  const limit = Math.min(Math.max(options.limit ?? 50, 1), 200)
  const viewerId = options.viewerId && options.viewerId.trim().length ? options.viewerId.trim() : null
  const viewerRole = options.viewerRole ?? 'user'
  const includeModerated = options.includeModerated ?? isModeratorRole(viewerRole)

  const selectSql = viewerId
    ? `SELECT c.id, c.page_id, c.parent_id, c.author_id, c.nickname, c.content, c.likes, c.dislike_count, c.report_count,
             c.status, c.is_anonymous, c.display_ip, c.created_at, c.password_hash, c.anonymous_number,
             c.is_edited, c.edited_at, c.mentions, c.depth, v.vote AS viewer_vote, u.role AS author_role,
             u.picture_url AS author_picture_url, u.custom_picture_url AS author_custom_picture_url
       FROM comments c
       LEFT JOIN comment_votes v ON v.comment_id = c.id AND v.user_id = ?
       LEFT JOIN users u ON u.id = c.author_id
       WHERE c.page_id = ? ${includeModerated ? "AND c.status != 'deleted'" : "AND c.status = 'visible'"}
       ORDER BY c.created_at DESC
       LIMIT ?`
    : `SELECT c.id, c.page_id, c.parent_id, c.author_id, c.nickname, c.content, c.likes, c.dislike_count, c.report_count,
             c.status, c.is_anonymous, c.display_ip, c.created_at, c.password_hash, c.anonymous_number,
             c.is_edited, c.edited_at, c.mentions, c.depth, 0 AS viewer_vote, u.role AS author_role,
             u.picture_url AS author_picture_url, u.custom_picture_url AS author_custom_picture_url
       FROM comments c
       LEFT JOIN users u ON u.id = c.author_id
       WHERE c.page_id = ? ${includeModerated ? "AND c.status != 'deleted'" : "AND c.status = 'visible'"}
       ORDER BY c.created_at DESC
       LIMIT ?`

  const rows = viewerId
    ? await db.prepare(selectSql).bind(viewerId, options.pageId, limit).all()
    : await db.prepare(selectSql).bind(options.pageId, limit).all()

  const rawRecords = Array.isArray(rows.results) ? rows.results.map(mapRowToComment) : []
  const records = rawRecords.map((record) => applyViewerPolicy(record, viewerRole))

  // Best 댓글 선정: 공감 5개 이상, 공감 > 싫어요, 최상위 댓글만
  const bestCandidates = rawRecords
    .filter((record) => 
      record.parentId === null && 
      record.status === 'visible' &&
      record.likeCount >= BEST_LIKE_THRESHOLD &&
      record.likeCount > record.dislikeCount  // 공감이 싫어요보다 많아야 함
    )
    .sort((a, b) => {
      // 공감 수 내림차순, 같으면 최신순
      if (a.likeCount < b.likeCount) return 1
      if (a.likeCount > b.likeCount) return -1
      return a.createdAt < b.createdAt ? 1 : -1
    })
    .slice(0, BEST_LIMIT)

  const bestSet = new Set(bestCandidates.map((comment) => comment.id))
  const threads = toThreads(records, bestSet)

  const bestThreads = threads.filter((thread) => bestSet.has(thread.id))
  const otherThreads = threads
    .filter((thread) => !bestSet.has(thread.id))
    .sort((a, b) => (a.createdAt < b.createdAt ? 1 : -1))

  const orderedThreads = [...bestThreads, ...otherThreads]

  const countRow = await db
    .prepare(
      includeModerated
        ? 'SELECT COUNT(*) AS total FROM comments WHERE page_id = ?'
        : "SELECT COUNT(*) AS total FROM comments WHERE page_id = ? AND status = 'visible'"
    )
    .bind(options.pageId)
    .first<{ total: number }>()

  return {
    comments: orderedThreads,
    totalCount: Number(countRow?.total ?? records.length),
    policy: {
      bestLikeThreshold: BEST_LIKE_THRESHOLD,
      bestLimit: BEST_LIMIT,
      reportBlindThreshold: REPORT_BLIND_THRESHOLD,
      requiresAuth: false,  // Phase 3 Day 3: 익명 사용자도 댓글 작성 가능
      dailyVoteLimit: 0,  // 일일 투표 제한 제거
      voteWindowHours: 0,  // 투표 윈도우 제거
      ipDisplayMode: DEFAULT_IP_DISPLAY_MODE,
      moderatorIpBlockEnabled: MODERATOR_IP_BLOCK_ENABLED,
      moderatorRoles: [...MODERATOR_ROLE_ORDER]
    }
  }
}

export const getCommentsBySlug = async (
  db: D1Database,
  options: {
    slug: string
    pageType: PageType
    title: string
    summary?: string | null
    limit?: number
    viewerId?: string | null
    viewerRole?: UserRole
    includeModerated?: boolean
    ipHash?: string | null
  }
): Promise<CommentListResult> => {
  const page = await ensurePageRecord(db, {
    slug: options.slug,
    title: options.title,
    pageType: options.pageType,
    summary: options.summary ?? null
  })

  const { comments, totalCount, policy } = await getCommentsForPage(db, {
    pageId: page.id,
    limit: options.limit,
    viewerId: options.viewerId,
    viewerRole: options.viewerRole,
    includeModerated: options.includeModerated
  })

  // 익명 사용자를 위한 다음 익명 번호 조회 (읽기 전용)
  const nextAnonymousNumber = await peekNextAnonymousNumber(db, page.id, options.ipHash ?? null)

  return {
    page,
    comments,
    totalCount,
    policy,
    nextAnonymousNumber
  }
}

// 다음 익명 번호 조회 (읽기 전용, 실제 할당하지 않음)
const peekNextAnonymousNumber = async (db: D1Database, pageId: number, ipHash: string | null): Promise<number> => {
  // 동일 IP가 해당 페이지에서 사용한 익명 번호가 있으면 재사용
  if (ipHash) {
    const existing = await db
      .prepare(
        `SELECT anonymous_number 
         FROM comments 
         WHERE page_id = ? AND ip_hash = ? AND is_anonymous = 1 AND anonymous_number IS NOT NULL 
         ORDER BY created_at DESC LIMIT 1`
      )
      .bind(pageId, ipHash)
      .first<{ anonymous_number: number | null }>()

    if (existing?.anonymous_number) {
      return Number(existing.anonymous_number)
    }
  }

  const counter = await db
    .prepare('SELECT next_number FROM anonymous_comment_counters WHERE page_id = ?')
    .bind(pageId)
    .first()

  if (counter) {
    return Number(counter.next_number ?? 1)
  } else {
    // 아직 익명 댓글이 없는 경우
    return 1
  }
}

// 익명 번호 할당 (동일 IP는 기존 번호 재사용, 없으면 증가)
const getNextAnonymousNumber = async (db: D1Database, pageId: number, ipHash: string | null): Promise<number> => {
  if (ipHash) {
    const existing = await db
      .prepare(
        `SELECT anonymous_number 
         FROM comments 
         WHERE page_id = ? AND ip_hash = ? AND is_anonymous = 1 AND anonymous_number IS NOT NULL 
         ORDER BY created_at DESC LIMIT 1`
      )
      .bind(pageId, ipHash)
      .first<{ anonymous_number: number | null }>()

    if (existing?.anonymous_number) {
      return Number(existing.anonymous_number)
    }
  }

  const counter = await db
    .prepare('SELECT next_number FROM anonymous_comment_counters WHERE page_id = ?')
    .bind(pageId)
    .first()

  if (counter) {
    const nextNumber = Number(counter.next_number ?? 1)
    // 다음 번호 업데이트
    await db
      .prepare('UPDATE anonymous_comment_counters SET next_number = ? WHERE page_id = ?')
      .bind(nextNumber + 1, pageId)
      .run()
    return nextNumber
  } else {
    // 첫 익명 댓글인 경우
    await db
      .prepare('INSERT INTO anonymous_comment_counters (page_id, next_number) VALUES (?, ?)')
      .bind(pageId, 2)
      .run()
    return 1
  }
}

// 일일 댓글 제한 체크 (익명 사용자만)
const checkDailyLimit = async (db: D1Database, pageId: number, ipHash: string | null): Promise<boolean> => {
  if (!ipHash) return true  // IP가 없으면 제한 없음 (로그인 사용자)

  const today = new Date().toISOString().split('T')[0]  // YYYY-MM-DD
  const limitRow = await db
    .prepare('SELECT count FROM anonymous_daily_limits WHERE page_id = ? AND ip_hash = ? AND date = ?')
    .bind(pageId, ipHash, today)
    .first()

  const currentCount = limitRow ? Number(limitRow.count ?? 0) : 0
  if (currentCount >= ANONYMOUS_DAILY_COMMENT_LIMIT) {
    return false
  }

  // 카운트 증가 또는 생성
  if (limitRow) {
    await db
      .prepare('UPDATE anonymous_daily_limits SET count = count + 1 WHERE page_id = ? AND ip_hash = ? AND date = ?')
      .bind(pageId, ipHash, today)
      .run()
  } else {
    await db
      .prepare('INSERT INTO anonymous_daily_limits (page_id, ip_hash, date, count) VALUES (?, ?, ?, 1)')
      .bind(pageId, ipHash, today)
      .run()
  }

  return true
}

// 로그인 사용자 일일 댓글 제한 체크 (comments 테이블 직접 COUNT)
const checkLoggedInDailyLimit = async (db: D1Database, authorId: string): Promise<boolean> => {
  const today = new Date().toISOString().split('T')[0]
  const row = await db
    .prepare("SELECT COUNT(*) as cnt FROM comments WHERE author_id = ? AND created_at >= ? AND status = 'visible'")
    .bind(authorId, today)
    .first()

  return Number(row?.cnt ?? 0) < LOGGED_IN_DAILY_COMMENT_LIMIT
}

// 비밀번호 시도 횟수 체크 (anonymous_daily_limits 테이블 재사용, 댓글의 실제 page_id 사용)
const checkPasswordAttempts = async (db: D1Database, commentId: number, pageId: number): Promise<boolean> => {
  const today = new Date().toISOString().split('T')[0]
  const key = `pwd:${commentId}`
  const limitRow = await db
    .prepare('SELECT count FROM anonymous_daily_limits WHERE page_id = ? AND ip_hash = ? AND date = ?')
    .bind(pageId, key, today)
    .first()

  const currentCount = limitRow ? Number(limitRow.count ?? 0) : 0
  return currentCount < PASSWORD_MAX_ATTEMPTS
}

const recordPasswordFailure = async (db: D1Database, commentId: number, pageId: number): Promise<void> => {
  const today = new Date().toISOString().split('T')[0]
  const key = `pwd:${commentId}`
  const limitRow = await db
    .prepare('SELECT count FROM anonymous_daily_limits WHERE page_id = ? AND ip_hash = ? AND date = ?')
    .bind(pageId, key, today)
    .first()

  if (limitRow) {
    await db
      .prepare('UPDATE anonymous_daily_limits SET count = count + 1 WHERE page_id = ? AND ip_hash = ? AND date = ?')
      .bind(pageId, key, today)
      .run()
  } else {
    await db
      .prepare('INSERT INTO anonymous_daily_limits (page_id, ip_hash, date, count) VALUES (?, ?, ?, 1)')
      .bind(pageId, key, today)
      .run()
  }
}

export const createComment = async (db: D1Database, payload: CreateCommentPayload): Promise<CommentRecord> => {
  const trimmedContent = normalizeContent(payload.content)
  if (!trimmedContent) {
    throw new Error('EMPTY_CONTENT')
  }

  // G1 댓글 도배 rate limit (정책 community §9): 1분당 5개 초과 차단
  // - 같은 IP 또는 같은 사용자가 1분 안에 5개 이상 댓글 생성하면 throw
  if (payload.ipHash || payload.authorId) {
    try {
      const rateRow = await db.prepare(
        `SELECT COUNT(*) AS cnt FROM comments
         WHERE ${payload.ipHash ? 'display_ip = ? OR ' : ''}${payload.authorId ? 'author_id = ?' : ''}
           AND created_at > datetime('now', '-60 seconds')`.replace(/OR\s+$/, '')
      ).bind(...[payload.ipHash, payload.authorId].filter(Boolean) as any[])
        .first<{ cnt: number }>()
      const recentCount = Number(rateRow?.cnt ?? 0)
      if (recentCount >= 5) {
        throw new Error('RATE_LIMITED')
      }
    } catch (err: any) {
      if (err?.message === 'RATE_LIMITED') throw err
      // 쿼리 실패는 무시
    }
  }

  // G2 5분 내 동일 단어 반복 도배 검사 (정책 community §9)
  if (payload.authorId || payload.ipHash) {
    try {
      const recentRow = await db.prepare(
        `SELECT content FROM comments
         WHERE ${payload.authorId ? 'author_id = ?' : 'display_ip = ?'}
           AND created_at > datetime('now', '-300 seconds')
         ORDER BY created_at DESC LIMIT 5`
      ).bind(payload.authorId || payload.ipHash).all<{ content: string }>()
      const recentTexts = (recentRow.results || []).map((r: any) => String(r.content || ''))
      const { detectKeywordSpam } = await import('../utils/trust')
      if (detectKeywordSpam(trimmedContent, recentTexts)) {
        throw new Error('KEYWORD_SPAM')
      }
    } catch (err: any) {
      if (err?.message === 'KEYWORD_SPAM') throw err
    }
  }

  // 욕설 필터 적용
  const profanityResult = await filterProfanity(db, trimmedContent)
  const finalContent = profanityResult.output
  const isModerated = profanityResult.moderated
  const originalContent = isModerated ? profanityResult.originalInput : null

  const isAnonymousUser = !payload.authorId || payload.isAnonymous || payload.requestAnonymous
  // 익명 사용자는 닉네임 입력하지 않음 (익명 번호는 자동 배정)
  const nickname = isAnonymousUser ? null : normalizeNickname(payload.nickname)
  const page = await ensurePageRecord(db, {
    slug: payload.slug,
    title: payload.title,
    pageType: payload.pageType,
    summary: payload.summary ?? null
  })

  // 일일 제한 체크
  if (isAnonymousUser && payload.ipHash) {
    const canComment = await checkDailyLimit(db, page.id, payload.ipHash)
    if (!canComment) {
      throw new Error('DAILY_LIMIT_REACHED')
    }
  } else if (!isAnonymousUser && payload.authorId) {
    const canComment = await checkLoggedInDailyLimit(db, payload.authorId)
    if (!canComment) {
      throw new Error('DAILY_LIMIT_REACHED')
    }
  }

  // 비밀번호 해시 생성 (익명 사용자만)
  let passwordHash: string | null = null
  if (isAnonymousUser && payload.password) {
    if (!/^\d{4}$/.test(payload.password)) {
      throw new Error('INVALID_PASSWORD')
    }
    passwordHash = await hashPassword(payload.password)
  } else if (isAnonymousUser && !payload.password) {
    throw new Error('PASSWORD_REQUIRED')
  }

  // 익명 번호 할당
  let anonymousNumber: number | null = null
  if (isAnonymousUser) {
    anonymousNumber = await getNextAnonymousNumber(db, page.id, payload.ipHash ?? null)
  }

  // 부모 댓글 확인 및 깊이 계산
  let depth = 0
  if (payload.parentId) {
    const parent = await db
      .prepare('SELECT id, parent_id FROM comments WHERE id = ? AND page_id = ? LIMIT 1')
      .bind(payload.parentId, page.id)
      .first()

    if (!parent) {
      throw new Error('INVALID_PARENT')
    }

    // 부모의 깊이 계산
    if (parent.parent_id) {
      const grandparent = await db
        .prepare('SELECT depth FROM comments WHERE id = ? LIMIT 1')
        .bind(parent.parent_id)
        .first()
      depth = grandparent ? (Number(grandparent.depth ?? 0) + 1) : 2
    } else {
      depth = 1
    }

    // 최대 깊이 제한
    if (depth >= MAX_DEPTH) {
      depth = MAX_DEPTH
    }
  }

  // 멘션 JSON 변환
  const mentionsJson = payload.mentions && Array.isArray(payload.mentions) && payload.mentions.length > 0
    ? JSON.stringify(payload.mentions.slice(0, 10))  // 최대 10개 멘션
    : null

  const result = await db
    .prepare(
      `INSERT INTO comments (page_id, parent_id, author_id, nickname, content, ip_hash, is_anonymous, display_ip, status,
                             password_hash, anonymous_number, mentions, depth, moderated, original_content)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'visible', ?, ?, ?, ?, ?, ?)`
    )
    .bind(
      page.id,
      payload.parentId ?? null,
      payload.authorId,
      isAnonymousUser && anonymousNumber 
        ? `익명 ${anonymousNumber}` 
        : (nickname || (isAnonymousUser ? '익명' : null)),
      finalContent,
      payload.ipHash ?? null,
      isAnonymousUser ? 1 : 0,
      normalizeDisplayIp(payload.displayIp),
      passwordHash,
      anonymousNumber,
      mentionsJson,
      depth,
      isModerated ? 1 : 0,
      originalContent
    )
    .run()

  const commentId = Number(result.meta?.last_row_id)

  const row = await db
    .prepare(
      `SELECT id, page_id, parent_id, author_id, nickname, content, likes, dislike_count, report_count,
              status, is_anonymous, display_ip, created_at, password_hash, anonymous_number,
              is_edited, edited_at, mentions, depth, moderated, original_content, 0 AS viewer_vote
       FROM comments WHERE id = ? LIMIT 1`
    )
    .bind(commentId)
    .first()

  if (!row) {
    throw new Error('COMMENT_NOT_FOUND')
  }

  return mapRowToComment(row)
}

export const setCommentVote = async (db: D1Database, payload: VotePayload): Promise<CommentRecord | null> => {
  if (!payload.userId || !payload.userId.trim()) {
    throw new Error('USER_REQUIRED')
  }

  const voteValue: VoteValue = payload.direction === 'up' ? 1 : payload.direction === 'down' ? -1 : 0

  const target = await db
    .prepare('SELECT author_id, status FROM comments WHERE id = ? LIMIT 1')
    .bind(payload.commentId)
    .first<{ author_id: string | null; status: string }>()

  if (!target || target.status === 'deleted') {
    throw new Error('COMMENT_NOT_FOUND')
  }

  if (target.author_id && target.author_id === payload.userId && voteValue !== 0) {
    throw new Error('SELF_VOTE_NOT_ALLOWED')
  }

  const existing = await db
    .prepare('SELECT id, vote FROM comment_votes WHERE comment_id = ? AND user_id = ? LIMIT 1')
    .bind(payload.commentId, payload.userId)
    .first<{ id: number; vote: number }>()

  // 일일 투표 제한 제거 - 여러 댓글에 공감/싫어요는 제한 없음 (한 댓글에만 제한)
  // 제한 로직 제거됨

  if (voteValue === 0) {
    if (existing) {
      await db.prepare('DELETE FROM comment_votes WHERE id = ?').bind(existing.id).run()
    }
  } else if (!existing) {
    try {
      await db
        .prepare('INSERT INTO comment_votes (comment_id, user_id, vote) VALUES (?, ?, ?)')
        .bind(payload.commentId, payload.userId, voteValue)
        .run()
    } catch {
      // UNIQUE constraint violation (race condition) → UPDATE로 폴백
      await db
        .prepare('UPDATE comment_votes SET vote = ?, updated_at = CURRENT_TIMESTAMP WHERE comment_id = ? AND user_id = ?')
        .bind(voteValue, payload.commentId, payload.userId)
        .run()
    }
  } else if (existing.vote !== voteValue) {
    await db
      .prepare('UPDATE comment_votes SET vote = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?')
      .bind(voteValue, existing.id)
      .run()
  }

  await recalcCommentVotes(db, payload.commentId)

  const row = await db
    .prepare(
      `SELECT id, page_id, parent_id, author_id, nickname, content, likes, dislike_count, report_count,
              status, is_anonymous, display_ip, created_at, ? AS viewer_vote
       FROM comments WHERE id = ? LIMIT 1`
    )
    .bind(voteValue, payload.commentId)
    .first()

  return row ? mapRowToComment(row) : null
}

export const reportComment = async (db: D1Database, payload: ReportPayload): Promise<CommentRecord | null> => {
  if (!payload.reporterId || !payload.reporterId.trim()) {
    throw new Error('REPORTER_REQUIRED')
  }

  // 정책 enforcement §2-A (B7): 신고 사유 6종 검증 + "기타" 시 20자 이상 강제
  if (payload.reasonType !== undefined && payload.reasonType !== null) {
    const validTypes: CommentReportReasonType[] = [...COMMENT_REPORT_REASON_TYPES]
    if (!validTypes.includes(payload.reasonType)) {
      throw new Error('INVALID_REASON_TYPE')
    }
    if (payload.reasonType === 'other') {
      const txt = (payload.reason || '').trim()
      if (txt.length < 20) {
        throw new Error('OTHER_REASON_TOO_SHORT')
      }
    }
  }

  // 정책 enforcement §2-B (B8): 신규 가입 24시간 이내 신고권 제한 (Reddit 모델)
  if (payload.reporterJoinedAt) {
    const joinedMs = Date.parse(payload.reporterJoinedAt)
    if (Number.isFinite(joinedMs) && Date.now() - joinedMs < 24 * 60 * 60 * 1000) {
      throw new Error('REPORTER_TOO_NEW')
    }
  }

  // 정책 enforcement §2-B (B8): 허위 신고 누적 3회 시 신고권 박탈
  // — 본인이 한 신고 중 dismissed 처리된 건수가 3회 이상이면 차단
  try {
    const dismissedRow = await db
      .prepare(
        `SELECT COUNT(*) AS dismissed FROM comment_reports
         WHERE reporter_id = ? AND reason LIKE '%[DISMISSED]%'`
      )
      .bind(payload.reporterId)
      .first<{ dismissed: number }>()
    const dismissedCount = Number(dismissedRow?.dismissed ?? 0)
    if (dismissedCount >= 3) {
      throw new Error('REPORTER_BANNED_FALSE_REPORTS')
    }
  } catch (err) {
    // 카운트 검사 실패는 무시(신고는 진행) — 단, 명시적 BANNED는 throw
    if ((err as Error)?.message === 'REPORTER_BANNED_FALSE_REPORTS') throw err
  }

  const target = await db
    .prepare('SELECT id, status FROM comments WHERE id = ? LIMIT 1')
    .bind(payload.commentId)
    .first()

  if (!target || target.status === 'deleted') {
    throw new Error('COMMENT_NOT_FOUND')
  }

  const existing = await db
    .prepare('SELECT id FROM comment_reports WHERE comment_id = ? AND reporter_id = ? LIMIT 1')
    .bind(payload.commentId, payload.reporterId)
    .first()

  if (existing) {
    throw new Error('REPORT_ALREADY_FILED')
  }

  await db
    .prepare(
      `INSERT INTO comment_reports (comment_id, reporter_id, reporter_ip_hash, reason)
       VALUES (?, ?, ?, ?)`
    )
    .bind(payload.commentId, payload.reporterId, payload.reporterIpHash ?? null, sanitizeReason(payload.reason, 300))
    .run()

  await recalcCommentReports(db, payload.commentId)

  // 자살·자해/긴급 신고 우선순위 태그 (정책 community §5, enforcement SLA 2시간)
  // 동시에 운영자 검토 큐에 자동 등록 (B2) + 즉시 영구 사유 자동 검출 (B5)
  try {
    const { detectSelfHarmSignal, detectSelfHarmMethod } = await import('../utils/safety')
    const { enqueueModeration, detectImmediatePermanent } = await import('./enforcementService')
    const reasonText = (payload.reason || '').toString()
    const commentRow = await db
      .prepare('SELECT content FROM comments WHERE id = ? LIMIT 1')
      .bind(payload.commentId)
      .first<{ content: string }>()
    const commentText = commentRow?.content || ''
    const isUrgent =
      detectSelfHarmSignal(reasonText) ||
      detectSelfHarmSignal(commentText) ||
      detectSelfHarmMethod(commentText) ||
      /(\[긴급\]|아동성착취|살해\s?협박|자해|자살)/i.test(reasonText)

    // B5: 즉시 영구 사유 자동 검출
    const immediate = detectImmediatePermanent(commentText)

    if (isUrgent || immediate.hit) {
      await db
        .prepare(
          `UPDATE comment_reports
           SET reason = COALESCE(reason, '') || ?
           WHERE comment_id = ? AND reporter_id = ?`
        )
        .bind(
          immediate.hit ? ` [IMMEDIATE-PERMANENT:${immediate.category}]` : ' [URGENT-2H-SLA]',
          payload.commentId,
          payload.reporterId
        )
        .run()
    }

    // B2: 운영자 검토 큐 자동 등록 (모든 신고)
    const reportRow = await db
      .prepare('SELECT id FROM comment_reports WHERE comment_id = ? AND reporter_id = ? ORDER BY id DESC LIMIT 1')
      .bind(payload.commentId, payload.reporterId)
      .first<{ id: number }>()
    if (reportRow?.id) {
      await enqueueModeration(db, {
        targetType: 'comment',
        targetId: payload.commentId,
        sourceReportId: reportRow.id,
        sourceReportType: 'comment_report',
        priority: immediate.hit ? 'urgent' : isUrgent ? 'urgent' : 'normal',
        autoFlagged: false
      })
    }
  } catch (err) {
    // 안전: 우선순위 태그·큐 등록 실패해도 신고 자체는 성공시킨다
    console.error('[reportComment] urgent-tag/queue failed:', err)
  }

  const row = await db
    .prepare(
      `SELECT id, page_id, parent_id, author_id, nickname, content, likes, dislike_count, report_count,
              status, is_anonymous, display_ip, created_at, 0 AS viewer_vote
       FROM comments WHERE id = ? LIMIT 1`
    )
    .bind(payload.commentId)
    .first()

  return row ? mapRowToComment(row) : null
}

export interface UpdateCommentPayload {
  commentId: number
  content: string
  userId: string | null  // 로그인 사용자 ID 또는 null
  password?: string | null  // 익명 댓글 수정 시 비밀번호
  userRole?: 'user' | 'expert' | 'admin' | 'super-admin' | 'operator' | null  // 사용자 역할 (admin은 모든 댓글 수정 가능)
}

export interface DeleteCommentPayload {
  commentId: number
  userId: string | null  // 로그인 사용자 ID 또는 null
  password?: string | null  // 익명 댓글 삭제 시 비밀번호
  userRole?: 'user' | 'expert' | 'admin' | 'super-admin' | 'operator' | null  // 관리자/운영자는 모든 댓글 삭제 가능
}

export interface ModerationComment {
  id: number
  parentId: number | null
  pageId: number
  pageType: PageType
  slug: string
  title: string
  content: string
  nickname: string | null
  isAnonymous: boolean
  displayIp: string | null
  status: CommentStatus
  reportCount: number
  likes: number
  dislikes: number
  createdAt: string
}

export const updateComment = async (db: D1Database, payload: UpdateCommentPayload): Promise<CommentRecord> => {
  const trimmedContent = normalizeContent(payload.content)
  if (!trimmedContent) {
    throw new Error('EMPTY_CONTENT')
  }

  // 댓글 조회
  const comment = await db
    .prepare('SELECT id, page_id, author_id, password_hash, is_anonymous, status FROM comments WHERE id = ? LIMIT 1')
    .bind(payload.commentId)
    .first()

  if (!comment) {
    throw new Error('COMMENT_NOT_FOUND')
  }

  if (comment.status === 'deleted') {
    throw new Error('COMMENT_NOT_FOUND')
  }

  const commentPageId = Number(comment.page_id)
  const authorId = typeof comment.author_id === 'string' ? comment.author_id : null
  const isAnonymous = Number(comment.is_anonymous ?? 0) === 1
  const passwordHash = typeof comment.password_hash === 'string' ? comment.password_hash : null

  // 권한 확인 (admin은 모든 댓글 수정 가능)
  const isAdmin =
    payload.userRole === 'admin' ||
    payload.userRole === 'super-admin' ||
    payload.userRole === 'operator'

  if (!isAdmin) {
    if (authorId) {
      // 로그인 사용자 댓글: 작성자만 수정 가능
      if (!payload.userId || payload.userId !== authorId) {
        throw new Error('UNAUTHORIZED')
      }
    } else if (isAnonymous) {
      // 익명 댓글: 비밀번호 확인 필요
      if (!payload.password || !passwordHash) {
        throw new Error('PASSWORD_REQUIRED')
      }
      const canAttempt = await checkPasswordAttempts(db, payload.commentId, commentPageId)
      if (!canAttempt) {
        throw new Error('PASSWORD_ATTEMPTS_EXCEEDED')
      }
      const isValid = await verifyPassword(payload.password, passwordHash)
      if (!isValid) {
        await recordPasswordFailure(db, payload.commentId, commentPageId)
        throw new Error('INVALID_PASSWORD')
      }
    } else {
      throw new Error('UNAUTHORIZED')
    }
  }

  // 욕설 필터 적용
  const profanityResult = await filterProfanity(db, trimmedContent)
  const finalContent = profanityResult.output
  const isModerated = profanityResult.moderated
  const originalContent = isModerated ? profanityResult.originalInput : null

  // 댓글 수정
  await db
    .prepare('UPDATE comments SET content = ?, is_edited = 1, edited_at = CURRENT_TIMESTAMP, moderated = ?, original_content = ? WHERE id = ?')
    .bind(finalContent, isModerated ? 1 : 0, originalContent, payload.commentId)
    .run()

  // 수정된 댓글 조회
  const row = await db
    .prepare(
      `SELECT id, page_id, parent_id, author_id, nickname, content, likes, dislike_count, report_count,
              status, is_anonymous, display_ip, created_at, password_hash, anonymous_number,
              is_edited, edited_at, mentions, depth, 0 AS viewer_vote
       FROM comments WHERE id = ? LIMIT 1`
    )
    .bind(payload.commentId)
    .first()

  if (!row) {
    throw new Error('COMMENT_NOT_FOUND')
  }

  return mapRowToComment(row)
}

export const deleteComment = async (db: D1Database, payload: DeleteCommentPayload): Promise<boolean> => {
  // 댓글 조회
  const comment = await db
    .prepare('SELECT id, page_id, author_id, password_hash, is_anonymous, status FROM comments WHERE id = ? LIMIT 1')
    .bind(payload.commentId)
    .first()

  if (!comment) {
    throw new Error('COMMENT_NOT_FOUND')
  }

  if (comment.status === 'deleted') {
    throw new Error('COMMENT_NOT_FOUND')
  }

  const commentPageId = Number(comment.page_id)
  const authorId = typeof comment.author_id === 'string' ? comment.author_id : null
  const isAnonymous = Number(comment.is_anonymous ?? 0) === 1
  const passwordHash = typeof comment.password_hash === 'string' ? comment.password_hash : null

  // 권한 확인 (관리자/운영자는 모든 댓글 삭제 가능)
  const isAdmin =
    payload.userRole === 'admin' ||
    payload.userRole === 'super-admin' ||
    payload.userRole === 'operator'

  if (!isAdmin) {
    if (authorId) {
      // 로그인 사용자 댓글: 작성자만 삭제 가능
      if (!payload.userId || payload.userId !== authorId) {
        throw new Error('UNAUTHORIZED')
      }
    } else if (isAnonymous) {
      // 익명 댓글: 비밀번호 확인 필요
      if (!payload.password || !passwordHash) {
        throw new Error('PASSWORD_REQUIRED')
      }
      const canAttempt = await checkPasswordAttempts(db, payload.commentId, commentPageId)
      if (!canAttempt) {
        throw new Error('PASSWORD_ATTEMPTS_EXCEEDED')
      }
      const isValid = await verifyPassword(payload.password, passwordHash)
      if (!isValid) {
        await recordPasswordFailure(db, payload.commentId, commentPageId)
        throw new Error('INVALID_PASSWORD')
      }
    } else {
      throw new Error('UNAUTHORIZED')
    }
  }

  // Soft delete: 손자 → 자식 → 원본 순으로 status='deleted' 전환
  await db
    .prepare('UPDATE comments SET status = ?, content = ? WHERE parent_id IN (SELECT id FROM comments WHERE parent_id = ?)')
    .bind('deleted', '삭제된 댓글입니다.', payload.commentId)
    .run()
  await db
    .prepare('UPDATE comments SET status = ?, content = ? WHERE parent_id = ?')
    .bind('deleted', '삭제된 댓글입니다.', payload.commentId)
    .run()
  await db
    .prepare('UPDATE comments SET status = ?, content = ? WHERE id = ?')
    .bind('deleted', '삭제된 댓글입니다.', payload.commentId)
    .run()

  return true
}

// 관리자: 블라인드/신고 댓글 목록 조회
export const listFlaggedComments = async (db: D1Database, page = 1, perPage = 20): Promise<{ items: ModerationComment[]; total: number }> => {
  const offset = (page - 1) * perPage
  const rows = await db
    .prepare(
      `SELECT c.id, c.parent_id, c.page_id, c.nickname, c.content, c.report_count, c.status,
              c.is_anonymous, c.display_ip, c.likes, c.dislike_count, c.created_at,
              p.slug, p.page_type, p.title
       FROM comments c
       JOIN pages p ON p.id = c.page_id
       WHERE c.status = 'blinded' OR c.report_count > 0
       ORDER BY c.report_count DESC, c.created_at DESC
       LIMIT ? OFFSET ?`
    )
    .bind(perPage, offset)
    .all()

  const countRow = await db
    .prepare(
      `SELECT COUNT(*) AS total
       FROM comments c
       WHERE c.status = 'blinded' OR c.report_count > 0`
    )
    .first<{ total: number }>()

  const items: ModerationComment[] = Array.isArray(rows?.results)
    ? rows.results.map((r: any) => ({
        id: Number(r.id),
        parentId: r.parent_id !== null ? Number(r.parent_id) : null,
        pageId: Number(r.page_id),
        pageType: r.page_type as PageType,
        slug: r.slug,
        title: r.title,
        content: typeof r.content === 'string' ? r.content : '',
        nickname: typeof r.nickname === 'string' ? r.nickname : null,
        isAnonymous: Number(r.is_anonymous ?? 0) === 1,
        displayIp: r.display_ip ?? null,
        status: (r.status as CommentStatus) ?? 'visible',
        reportCount: Number(r.report_count ?? 0),
        likes: Number(r.likes ?? 0),
        dislikes: Number(r.dislike_count ?? 0),
        createdAt: typeof r.created_at === 'string' ? r.created_at : new Date().toISOString()
      }))
    : []

  return { items, total: Number(countRow?.total ?? 0) }
}

export const setCommentStatus = async (db: D1Database, commentId: number, status: CommentStatus): Promise<boolean> => {
  await db.prepare('UPDATE comments SET status = ? WHERE id = ?').bind(status, commentId).run()
  return true
}

export const resetCommentReports = async (db: D1Database, commentId: number): Promise<boolean> => {
  await db.prepare('UPDATE comments SET report_count = 0 WHERE id = ?').bind(commentId).run()
  await db.prepare('DELETE FROM comment_reports WHERE comment_id = ?').bind(commentId).run()
  return true
}

export const deleteOrphanReplies = async (db: D1Database): Promise<number> => {
  const res = await db
    .prepare(
      `DELETE FROM comments
       WHERE parent_id IS NOT NULL
         AND parent_id NOT IN (SELECT id FROM comments)`
    )
    .run()
  const changes = (res as any)?.meta?.changes ?? 0
  return Number(changes)
}

export const isIpBlocked = async (db: D1Database, ipHash: string | null | undefined): Promise<boolean> => {
  if (!ipHash) return false
  const row = await db
    .prepare('SELECT COUNT(*) AS count FROM ip_blocks WHERE ip_hash = ? AND status = "active"')
    .bind(ipHash)
    .first<{ count: number }>()
  return Number(row?.count ?? 0) > 0
}

export const listIpBlocks = async (
  db: D1Database,
  options?: { includeReleased?: boolean }
): Promise<IpBlockRecord[]> => {
  const includeReleased = Boolean(options?.includeReleased)
  const sql = includeReleased
    ? 'SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks ORDER BY created_at DESC'
    : 'SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks WHERE status = "active" ORDER BY created_at DESC'

  const rows = await db.prepare(sql).all()
  return Array.isArray(rows.results) ? rows.results.map(mapRowToIpBlock) : []
}

export const blockIpAddress = async (
  db: D1Database,
  payload: { ipHash: string | null | undefined; reason?: string | null; blockedBy: string }
): Promise<IpBlockRecord> => {
  const ipHash = payload.ipHash?.trim().toLowerCase()
  if (!ipHash) {
    throw new Error('IP_HASH_REQUIRED')
  }
  if (!payload.blockedBy || !payload.blockedBy.trim()) {
    throw new Error('BLOCK_ACTOR_REQUIRED')
  }

  const reason = sanitizeReason(payload.reason)

  const existing = await db
    .prepare('SELECT id, status FROM ip_blocks WHERE ip_hash = ? LIMIT 1')
    .bind(ipHash)
    .first<{ id: number; status: string }>()

  if (existing) {
    if (existing.status === 'active') {
      throw new Error('IP_ALREADY_BLOCKED')
    }
    await db
      .prepare('UPDATE ip_blocks SET status = "active", reason = ?, blocked_by = ?, created_at = CURRENT_TIMESTAMP, released_at = NULL WHERE id = ?')
      .bind(reason, payload.blockedBy.trim(), existing.id)
      .run()
  } else {
    await db
      .prepare('INSERT INTO ip_blocks (ip_hash, reason, status, blocked_by) VALUES (?, ?, "active", ?)')
      .bind(ipHash, reason, payload.blockedBy.trim())
      .run()
  }

  const row = await db
    .prepare('SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks WHERE ip_hash = ? LIMIT 1')
    .bind(ipHash)
    .first()

  if (!row) {
    throw new Error('IP_BLOCK_NOT_FOUND')
  }

  return mapRowToIpBlock(row)
}

export const releaseIpAddress = async (
  db: D1Database,
  payload: { ipHash: string | null | undefined; releasedBy: string; reason?: string | null }
): Promise<IpBlockRecord | null> => {
  const ipHash = payload.ipHash?.trim().toLowerCase()
  if (!ipHash) {
    throw new Error('IP_HASH_REQUIRED')
  }
  if (!payload.releasedBy || !payload.releasedBy.trim()) {
    throw new Error('RELEASE_ACTOR_REQUIRED')
  }

  const record = await db
    .prepare('SELECT id, status FROM ip_blocks WHERE ip_hash = ? LIMIT 1')
    .bind(ipHash)
    .first<{ id: number; status: string }>()

  if (!record) {
    return null
  }

  if (record.status === 'released') {
    const row = await db
      .prepare('SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks WHERE id = ?')
      .bind(record.id)
      .first()
    return row ? mapRowToIpBlock(row) : null
  }

  const reason = sanitizeReason(payload.reason)

  await db
    .prepare('UPDATE ip_blocks SET status = "released", released_at = CURRENT_TIMESTAMP, reason = COALESCE(?, reason) WHERE id = ?')
    .bind(reason, record.id)
    .run()

  const row = await db
    .prepare('SELECT id, ip_hash, reason, status, blocked_by, created_at, released_at FROM ip_blocks WHERE id = ?')
    .bind(record.id)
    .first()

  return row ? mapRowToIpBlock(row) : null
}
