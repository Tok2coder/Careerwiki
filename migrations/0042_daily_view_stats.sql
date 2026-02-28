-- 일별 조회수 통계 테이블 (entity_type별 일일 집계)
CREATE TABLE IF NOT EXISTS daily_view_stats (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  stat_date TEXT NOT NULL,
  entity_type TEXT NOT NULL CHECK(entity_type IN ('job', 'major', 'howto', 'share')),
  total_views INTEGER DEFAULT 0,
  UNIQUE(stat_date, entity_type)
);
