-- 검색어 일별 집계 테이블 (PII 미저장, 정규화된 검색어만)
CREATE TABLE IF NOT EXISTS search_query_daily (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  stat_date       TEXT    NOT NULL,
  query           TEXT    NOT NULL,
  search_type     TEXT    NOT NULL DEFAULT 'all',
  count           INTEGER NOT NULL DEFAULT 1,
  zero_result_count INTEGER NOT NULL DEFAULT 0,
  UNIQUE(stat_date, query, search_type)
);

CREATE INDEX IF NOT EXISTS idx_sqd_date ON search_query_daily(stat_date DESC);
CREATE INDEX IF NOT EXISTS idx_sqd_zero ON search_query_daily(zero_result_count)
  WHERE zero_result_count > 0;
