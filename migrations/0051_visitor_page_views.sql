-- 방문자 페이지뷰 상세 기록
-- IP 해시별 방문 페이지, 유입경로(referer) 추적
CREATE TABLE IF NOT EXISTS visitor_page_views (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ip_hash TEXT NOT NULL,
  page_type TEXT NOT NULL,       -- 'job' | 'major' | 'howto' | 'share'
  page_id TEXT NOT NULL,         -- slug or pageId
  referer TEXT,                  -- 유입 경로 (도메인만 저장)
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_vpv_ip ON visitor_page_views(ip_hash);
CREATE INDEX IF NOT EXISTS idx_vpv_date ON visitor_page_views(created_at);
