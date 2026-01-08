-- HowTo 신고 테이블
CREATE TABLE IF NOT EXISTS howto_reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  reporter_id INTEGER,
  reporter_ip_hash TEXT,
  reason_type TEXT NOT NULL CHECK(reason_type IN ('defamation', 'obscene', 'spam', 'copyright', 'false_info', 'other')),
  reason_detail TEXT,
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'resolved', 'dismissed')),
  resolved_by INTEGER,
  resolved_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE,
  FOREIGN KEY (reporter_id) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (resolved_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_howto_reports_page ON howto_reports(page_id);
CREATE INDEX IF NOT EXISTS idx_howto_reports_status ON howto_reports(status);
CREATE INDEX IF NOT EXISTS idx_howto_reports_reporter ON howto_reports(reporter_id);
