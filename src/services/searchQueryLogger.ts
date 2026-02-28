/**
 * 검색어 로깅 서비스
 * - D1 search_query_daily 테이블에 UPSERT 패턴으로 일별 집계
 * - PII 필터링 (전화번호, 이메일 감지 시 기록 안 함)
 * - waitUntil()로 비동기 처리하여 응답 블로킹 없음
 */

import type { D1Database } from '@cloudflare/workers-types'

const PII_PATTERN = /\d{3}[-\s]?\d{4}[-\s]?\d{4}|\S+@\S+\.\S+/

function sanitizeQuery(q: string): string | null {
  const clean = q.trim().toLowerCase().slice(0, 100)
  if (!clean || clean.length < 1) return null
  if (PII_PATTERN.test(clean)) return null
  return clean
}

export async function logSearchQuery(db: D1Database, params: {
  query: string
  resultCount: number
  searchType: 'all' | 'job' | 'major'
  role?: string  // 'admin' 이면 로깅 제외
}): Promise<void> {
  try {
    if (params.role === 'admin') return
    const sanitized = sanitizeQuery(params.query)
    if (!sanitized) return

    const zeroResult = params.resultCount === 0 ? 1 : 0

    await db.prepare(`
      INSERT INTO search_query_daily (stat_date, query, search_type, count, zero_result_count)
      VALUES (date('now'), ?, ?, 1, ?)
      ON CONFLICT (stat_date, query, search_type)
      DO UPDATE SET
        count = count + 1,
        zero_result_count = zero_result_count + excluded.zero_result_count
    `).bind(sanitized, params.searchType, zeroResult).run()
  } catch (_e) {
    // 로깅 실패는 무시 (사용자 경험에 영향 없음)
  }
}
