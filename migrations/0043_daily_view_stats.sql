-- 일별 조회수 집계 테이블
CREATE TABLE IF NOT EXISTS daily_view_stats (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  stat_date       TEXT    NOT NULL,
  entity_type     TEXT    NOT NULL,
  total_views     INTEGER NOT NULL DEFAULT 0,
  UNIQUE(stat_date, entity_type)
);

CREATE INDEX IF NOT EXISTS idx_dvs_date ON daily_view_stats(stat_date DESC);
