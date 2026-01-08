-- 피드백 댓글 테이블 (스레드 형태 지원)
-- 기존 feedback_replies는 admin 단일 답변용, 이 테이블은 다중 댓글용
CREATE TABLE IF NOT EXISTS feedback_comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id INTEGER NOT NULL REFERENCES feedback_posts(id) ON DELETE CASCADE,
  user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
  is_admin INTEGER NOT NULL DEFAULT 0,
  body TEXT NOT NULL,
  created_at INTEGER NOT NULL DEFAULT (strftime('%s','now')),
  updated_at INTEGER NOT NULL DEFAULT (strftime('%s','now'))
);

CREATE INDEX IF NOT EXISTS idx_feedback_comments_post ON feedback_comments (post_id);
CREATE INDEX IF NOT EXISTS idx_feedback_comments_user ON feedback_comments (user_id);

-- 피드백 마지막 활동 시간 컬럼 추가 (자동 CLOSE용)
-- SQLite ALTER TABLE은 non-constant default를 지원하지 않으므로 NULL 허용
ALTER TABLE feedback_posts ADD COLUMN last_activity_at INTEGER;

