-- Comment policy enhancements

-- Add new columns to comments table
ALTER TABLE comments ADD COLUMN author_id TEXT;
ALTER TABLE comments ADD COLUMN is_anonymous INTEGER DEFAULT 0 CHECK(is_anonymous IN (0, 1));
ALTER TABLE comments ADD COLUMN display_ip TEXT;
ALTER TABLE comments ADD COLUMN status TEXT DEFAULT 'visible' CHECK(status IN ('visible', 'blinded', 'deleted'));
ALTER TABLE comments ADD COLUMN dislike_count INTEGER DEFAULT 0;
ALTER TABLE comments ADD COLUMN report_count INTEGER DEFAULT 0;

-- Votes table to enforce single vote (like or dislike) per user/comment
CREATE TABLE IF NOT EXISTS comment_votes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  comment_id INTEGER NOT NULL,
  user_id TEXT NOT NULL,
  vote INTEGER NOT NULL CHECK(vote IN (-1, 1)),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(comment_id, user_id),
  FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
);

-- Reports table to track individual reports and automate blinding threshold
CREATE TABLE IF NOT EXISTS comment_reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  comment_id INTEGER NOT NULL,
  reporter_id TEXT NOT NULL,
  reporter_ip_hash TEXT,
  reason TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
);

-- IP block list managed by moderators
CREATE TABLE IF NOT EXISTS ip_blocks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ip_hash TEXT NOT NULL UNIQUE,
  reason TEXT,
  status TEXT DEFAULT 'active' CHECK(status IN ('active', 'released')),
  blocked_by TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  released_at DATETIME
);

CREATE INDEX IF NOT EXISTS idx_comment_votes_comment ON comment_votes(comment_id);
CREATE INDEX IF NOT EXISTS idx_comment_votes_user ON comment_votes(user_id);
CREATE INDEX IF NOT EXISTS idx_comment_reports_comment ON comment_reports(comment_id);
CREATE INDEX IF NOT EXISTS idx_comment_reports_reporter ON comment_reports(reporter_id);
CREATE INDEX IF NOT EXISTS idx_ip_blocks_status ON ip_blocks(status);
