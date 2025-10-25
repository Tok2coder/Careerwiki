import type {
  SerpInteractionLogInput,
  SerpInteractionLogRecord,
  SerpInteractionSummaryRow,
  SerpSummaryQueryOptions
} from '../types/aiAnalysis'

export async function recordSerpInteraction(
  db: D1Database,
  input: SerpInteractionLogInput
): Promise<SerpInteractionLogRecord> {
  const result = await db
    .prepare(
      `INSERT INTO serp_interaction_logs (
        page_type,
        action,
        keyword_length,
        category,
        per_page,
        results,
        cache_status,
        duration_ms,
        sampled,
        source
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`
    )
    .bind(
      input.pageType,
      input.action,
      input.keywordLength ?? null,
      input.category ?? null,
      input.perPage ?? null,
      input.results ?? null,
      input.cacheStatus ?? null,
      input.durationMs ?? null,
      typeof input.sampled === 'boolean' ? (input.sampled ? 1 : 0) : input.sampled === null ? null : 1,
      input.source ?? 'hydration'
    )
    .run()

  const id = Number(result.lastRowId)
  const row = await db.prepare('SELECT * FROM serp_interaction_logs WHERE id = ?').bind(id).first()
  if (!row) {
    throw new Error('failed to record serp interaction')
  }

  return {
    id,
    pageType: row.page_type,
    action: row.action,
    keywordLength: row.keyword_length ?? null,
    category: row.category ?? null,
    perPage: row.per_page ?? null,
    results: row.results ?? null,
    cacheStatus: row.cache_status ?? null,
    durationMs: row.duration_ms ?? null,
    sampled: row.sampled === null || row.sampled === undefined ? null : Boolean(row.sampled),
    source: row.source ?? null,
    recordedAt: row.recorded_at
  }
}

export async function getDailySerpSummary(
  db: D1Database,
  options: SerpSummaryQueryOptions = {}
): Promise<SerpInteractionSummaryRow[]> {
  const conditions: string[] = []
  const bindings: unknown[] = []

  if (options.startDate) {
    conditions.push('log_date >= ?')
    bindings.push(options.startDate)
  }

  if (options.endDate) {
    conditions.push('log_date <= ?')
    bindings.push(options.endDate)
  }

  if (options.pageType) {
    conditions.push('page_type = ?')
    bindings.push(options.pageType)
  }

  if (options.action) {
    conditions.push('action = ?')
    bindings.push(options.action)
  }

  const whereClause = conditions.length ? `WHERE ${conditions.join(' AND ')}` : ''
  const limit = options.limit ?? 50

  const query = `
    SELECT log_date, page_type, action, samples, avg_duration_ms, avg_results, cache_hit_ratio
    FROM serp_interaction_daily_summary
    ${whereClause}
    ORDER BY log_date DESC
    LIMIT ?
  `

  const rows = await db.prepare(query).bind(...bindings, limit).all()
  return (rows.results ?? []).map((row) => ({
    logDate: row.log_date,
    pageType: row.page_type,
    action: row.action,
    samples: row.samples,
    avgDurationMs: row.avg_duration_ms ?? null,
    avgResults: row.avg_results ?? null,
    cacheHitRatio: row.cache_hit_ratio ?? null
  }))
}

export async function listRecentSerpInteractions(
  db: D1Database,
  limit = 50
): Promise<SerpInteractionLogRecord[]> {
  const rows = await db
    .prepare('SELECT * FROM serp_interaction_logs ORDER BY recorded_at DESC LIMIT ?')
    .bind(limit)
    .all()

  return (rows.results ?? []).map((row) => ({
    id: row.id,
    pageType: row.page_type,
    action: row.action,
    keywordLength: row.keyword_length ?? null,
    category: row.category ?? null,
    perPage: row.per_page ?? null,
    results: row.results ?? null,
    cacheStatus: row.cache_status ?? null,
    durationMs: row.duration_ms ?? null,
    sampled: row.sampled === null || row.sampled === undefined ? null : Boolean(row.sampled),
    source: row.source ?? null,
    recordedAt: row.recorded_at
  }))
}
