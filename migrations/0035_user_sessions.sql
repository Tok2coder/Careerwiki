-- 세션 감사 로그 테이블
-- 활성 세션 검증은 KV로 처리하며, 이 테이블은 이력 추적용

CREATE TABLE IF NOT EXISTS user_sessions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  session_token_hash TEXT NOT NULL,
  provider TEXT NOT NULL DEFAULT 'google',
  ip_address TEXT,
  device_label TEXT,
  created_at INTEGER NOT NULL DEFAULT (strftime('%s','now')),
  last_active_at INTEGER,
  expired_at INTEGER,
  logout_reason TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_user_sessions_user_id ON user_sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_user_sessions_active ON user_sessions(user_id, expired_at);
