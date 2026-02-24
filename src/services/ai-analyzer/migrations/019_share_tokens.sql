-- 019: 공유 토큰 테이블 생성
-- AI 분석 결과를 SNS 공유 시 사용하는 share_token 관리
-- 2026-02-09

CREATE TABLE IF NOT EXISTS share_tokens (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  share_token TEXT UNIQUE NOT NULL,
  request_id INTEGER UNIQUE NOT NULL,
  user_id TEXT NOT NULL,
  share_data_json TEXT NOT NULL,
  share_version INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME NOT NULL DEFAULT (datetime('now', '+30 days')),
  revoked_at DATETIME,
  is_revoked INTEGER DEFAULT 0,
  view_count INTEGER DEFAULT 0,
  last_viewed_at DATETIME,
  FOREIGN KEY (request_id) REFERENCES ai_analysis_requests(id)
);

CREATE INDEX IF NOT EXISTS idx_share_tokens_token ON share_tokens(share_token);
CREATE INDEX IF NOT EXISTS idx_share_tokens_request ON share_tokens(request_id);
