-- Feedback board schema
CREATE TABLE IF NOT EXISTS feedback_posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL REFERENCES users(id),
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  type TEXT NOT NULL DEFAULT 'suggestion',
  status TEXT NOT NULL DEFAULT 'open',
  is_private INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL DEFAULT (strftime('%s','now')),
  updated_at INTEGER NOT NULL DEFAULT (strftime('%s','now'))
);

CREATE INDEX IF NOT EXISTS idx_feedback_posts_created_at ON feedback_posts (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_feedback_posts_status ON feedback_posts (status);
CREATE INDEX IF NOT EXISTS idx_feedback_posts_is_private ON feedback_posts (is_private);
CREATE INDEX IF NOT EXISTS idx_feedback_posts_type ON feedback_posts (type);

CREATE TABLE IF NOT EXISTS feedback_replies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id INTEGER NOT NULL REFERENCES feedback_posts(id) ON DELETE CASCADE,
  admin_id INTEGER NOT NULL REFERENCES users(id),
  body TEXT NOT NULL,
  created_at INTEGER NOT NULL DEFAULT (strftime('%s','now')),
  updated_at INTEGER NOT NULL DEFAULT (strftime('%s','now'))
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_feedback_replies_post ON feedback_replies (post_id);

