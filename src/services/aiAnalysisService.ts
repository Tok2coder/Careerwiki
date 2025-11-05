import type { D1Database, KVNamespace } from '@cloudflare/workers-types'
import type {
  AiAnalysisRequestRecord,
  AiAnalysisResultRecord,
  AiSessionRecord,
  AnalysisType,
  CreateAnalysisRequestInput,
  CreateAnalysisResultInput,
  CreateSessionInput,
  PricingTier,
  RequestStatus
} from '../types/aiAnalysis'

const SESSION_SELECT = `
  SELECT id, user_identifier, traits_snapshot, created_at, last_active_at
  FROM ai_sessions
  WHERE id = ?
`

const REQUEST_WITH_RESULT_SELECT = `
  SELECT
    r.id AS request_id,
    r.session_id,
    r.analysis_type,
    r.pricing_tier,
    r.prompt_payload,
    r.status,
    r.requested_at,
    r.processed_at,
    res.id AS result_id,
    res.provider,
    res.model,
    res.completion_tokens,
    res.prompt_tokens,
    res.total_tokens,
    res.latency_ms,
    res.response_summary,
    res.response_payload,
    res.created_at AS result_created_at
  FROM ai_analysis_requests r
  LEFT JOIN ai_analysis_results res ON res.request_id = r.id
  WHERE r.id = ?
`

function parseJson<T>(value: unknown): T | undefined {
  if (typeof value !== 'string' || !value) return undefined
  try {
    return JSON.parse(value) as T
  } catch {
    return undefined
  }
}

function mapSessionRow(row: any): AiSessionRecord {
  return {
    id: row.id,
    userIdentifier: row.user_identifier ?? undefined,
    traitsSnapshot: parseJson(row.traits_snapshot) ?? row.traits_snapshot,
    createdAt: row.created_at,
    lastActiveAt: row.last_active_at
  }
}

function mapRequestRow(row: any): AiAnalysisRequestRecord {
  return {
    id: Number(row.id),
    sessionId: row.session_id,
    analysisType: row.analysis_type as AnalysisType,
    pricingTier: (row.pricing_tier ?? 'free') as PricingTier,
    promptPayload: parseJson(row.prompt_payload) ?? row.prompt_payload,
    status: row.status as RequestStatus,
    requestedAt: row.requested_at,
    processedAt: row.processed_at ?? null
  }
}

function mapResultRow(row: any): AiAnalysisResultRecord {
  return {
    id: Number(row.id),
    requestId: Number(row.request_id),
    provider: row.provider,
    model: row.model ?? null,
    completionTokens: row.completion_tokens ?? null,
    promptTokens: row.prompt_tokens ?? null,
    totalTokens: row.total_tokens ?? null,
    latencyMs: row.latency_ms ?? null,
    responseSummary: row.response_summary ?? null,
    responsePayload: parseJson(row.response_payload) ?? row.response_payload,
    createdAt: row.created_at
  }
}

export async function createOrUpdateSession(db: D1Database, input: CreateSessionInput): Promise<AiSessionRecord> {
  const sessionId = input.sessionId ?? crypto.randomUUID()
  const traitsJson = input.traitsSnapshot !== undefined ? JSON.stringify(input.traitsSnapshot) : undefined

  const existing = await db.prepare('SELECT id FROM ai_sessions WHERE id = ?').bind(sessionId).first()

  if (existing) {
    const fields: string[] = []
    const bindings: unknown[] = []

    if (input.userIdentifier !== undefined) {
      fields.push('user_identifier = ?')
      bindings.push(input.userIdentifier ?? null)
    }

    if (traitsJson !== undefined) {
      fields.push('traits_snapshot = ?')
      bindings.push(traitsJson)
    }

    fields.push('last_active_at = CURRENT_TIMESTAMP')

    const setClause = fields.join(', ')
    await db.prepare(`UPDATE ai_sessions SET ${setClause} WHERE id = ?`).bind(...bindings, sessionId).run()
  } else {
    await db
      .prepare(
        `INSERT INTO ai_sessions (id, user_identifier, traits_snapshot, created_at, last_active_at)
         VALUES (?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`
      )
      .bind(sessionId, input.userIdentifier ?? null, traitsJson ?? null)
      .run()
  }

  const row = await db.prepare(SESSION_SELECT).bind(sessionId).first()
  if (!row) {
    throw new Error('session upsert failed')
  }
  return mapSessionRow(row)
}

export async function getSession(db: D1Database, sessionId: string): Promise<AiSessionRecord | null> {
  const row = await db.prepare(SESSION_SELECT).bind(sessionId).first()
  return row ? mapSessionRow(row) : null
}

export async function createAnalysisRequest(db: D1Database, input: CreateAnalysisRequestInput): Promise<AiAnalysisRequestRecord> {
  const pricingTier = input.pricingTier ?? 'free'
  const status = input.status ?? 'pending'
  const promptPayloadJson = JSON.stringify(input.promptPayload)

  const result = await db
    .prepare(
      `INSERT INTO ai_analysis_requests (session_id, analysis_type, pricing_tier, prompt_payload, status)
       VALUES (?, ?, ?, ?, ?)`
    )
    .bind(input.sessionId, input.analysisType, pricingTier, promptPayloadJson, status)
    .run()

  const requestId = Number(result.lastRowId)
  const row = await db
    .prepare('SELECT * FROM ai_analysis_requests WHERE id = ?')
    .bind(requestId)
    .first()

  if (!row) {
    throw new Error('failed to create analysis request')
  }

  return mapRequestRow(row)
}

export async function updateRequestStatus(
  db: D1Database,
  requestId: number,
  status: RequestStatus,
  processedAt: string | null = null
): Promise<AiAnalysisRequestRecord> {
  await db
    .prepare('UPDATE ai_analysis_requests SET status = ?, processed_at = ? WHERE id = ?')
    .bind(status, processedAt, requestId)
    .run()

  const row = await db.prepare('SELECT * FROM ai_analysis_requests WHERE id = ?').bind(requestId).first()
  if (!row) {
    throw new Error('request not found')
  }
  return mapRequestRow(row)
}

export async function createAnalysisResult(
  db: D1Database,
  input: CreateAnalysisResultInput
): Promise<{ request: AiAnalysisRequestRecord; result: AiAnalysisResultRecord }> {
  const payloadJson = JSON.stringify(input.responsePayload)

  const insert = await db
    .prepare(
      `INSERT INTO ai_analysis_results (
        request_id,
        provider,
        model,
        completion_tokens,
        prompt_tokens,
        total_tokens,
        latency_ms,
        response_summary,
        response_payload
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`
    )
    .bind(
      input.requestId,
      input.provider,
      input.model ?? null,
      input.completionTokens ?? null,
      input.promptTokens ?? null,
      input.totalTokens ?? null,
      input.latencyMs ?? null,
      input.responseSummary ?? null,
      payloadJson
    )
    .run()

  const resultId = Number(insert.lastRowId)
  const resultRow = await db
    .prepare('SELECT * FROM ai_analysis_results WHERE id = ?')
    .bind(resultId)
    .first()

  if (!resultRow) {
    throw new Error('failed to create analysis result')
  }

  const requestStatus = input.requestStatus ?? 'completed'
  const processedAt = requestStatus === 'processing' || requestStatus === 'pending' ? null : new Date().toISOString()
  const request = await updateRequestStatus(db, input.requestId, requestStatus, processedAt)

  return {
    request,
    result: mapResultRow({ ...resultRow, response_payload: payloadJson })
  }
}

export async function getAnalysisRequestWithResult(
  db: D1Database,
  requestId: number
): Promise<{ request: AiAnalysisRequestRecord; result?: AiAnalysisResultRecord } | null> {
  const row = await db.prepare(REQUEST_WITH_RESULT_SELECT).bind(requestId).first()
  if (!row) return null

  const requestRow = {
    id: row.request_id,
    session_id: row.session_id,
    analysis_type: row.analysis_type,
    pricing_tier: row.pricing_tier,
    prompt_payload: row.prompt_payload,
    status: row.status,
    requested_at: row.requested_at,
    processed_at: row.processed_at
  }
  const request = mapRequestRow(requestRow)

  if (!row.result_id) {
    return { request }
  }

  const resultRow = {
    id: row.result_id,
    request_id: row.request_id,
    provider: row.provider,
    model: row.model,
    completion_tokens: row.completion_tokens,
    prompt_tokens: row.prompt_tokens,
    total_tokens: row.total_tokens,
    latency_ms: row.latency_ms,
    response_summary: row.response_summary,
    response_payload: row.response_payload,
    created_at: row.result_created_at
  }

  return {
    request,
    result: mapResultRow(resultRow)
  }
}

export async function listRequestsBySession(
  db: D1Database,
  sessionId: string,
  limit = 20
): Promise<AiAnalysisRequestRecord[]> {
  const rows = await db
    .prepare('SELECT * FROM ai_analysis_requests WHERE session_id = ? ORDER BY requested_at DESC LIMIT ?')
    .bind(sessionId, limit)
    .all()

  return (rows.results ?? []).map(mapRequestRow)
}
