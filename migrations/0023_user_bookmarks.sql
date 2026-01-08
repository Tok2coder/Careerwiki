-- 사용자 저장함 (북마크) 테이블
-- 작성일: 2025-12-01
-- 용도: 직업, 전공, HowTo 저장 기능

CREATE TABLE IF NOT EXISTS user_bookmarks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  item_type TEXT NOT NULL CHECK(item_type IN ('job', 'major', 'howto')),
  item_slug TEXT NOT NULL,
  item_title TEXT,
  created_at INTEGER DEFAULT (strftime('%s','now')),
  
  -- 외래키
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  
  -- 동일 항목 중복 저장 방지
  UNIQUE(user_id, item_type, item_slug)
);

-- 인덱스
CREATE INDEX IF NOT EXISTS idx_user_bookmarks_user ON user_bookmarks(user_id);
CREATE INDEX IF NOT EXISTS idx_user_bookmarks_type ON user_bookmarks(item_type);
CREATE INDEX IF NOT EXISTS idx_user_bookmarks_slug ON user_bookmarks(item_slug);

