-- Comment system enhancements: password, anonymous number, edit tracking, etc.

-- Add password hash for anonymous comments (4-digit numeric password)
ALTER TABLE comments ADD COLUMN password_hash TEXT;

-- Add anonymous number (익명 1, 익명 2, etc.)
ALTER TABLE comments ADD COLUMN anonymous_number INTEGER;

-- Add edit tracking
ALTER TABLE comments ADD COLUMN is_edited INTEGER DEFAULT 0 CHECK(is_edited IN (0, 1));
ALTER TABLE comments ADD COLUMN edited_at DATETIME;

-- Add mention support (JSON array of mentioned user IDs or comment IDs)
ALTER TABLE comments ADD COLUMN mentions TEXT; -- JSON array

-- Add depth column for nested comments (0=root, 1=reply, 2=reply to reply, 3=max)
ALTER TABLE comments ADD COLUMN depth INTEGER DEFAULT 0;

-- Update best like threshold to 5 (from 8)
-- This will be handled in code, but documenting here

-- Add index for anonymous number lookup per page
CREATE INDEX IF NOT EXISTS idx_comments_anonymous_number ON comments(page_id, anonymous_number);

-- Add index for edit tracking
CREATE INDEX IF NOT EXISTS idx_comments_edited ON comments(is_edited, edited_at);

-- Table to track anonymous comment numbers per page
CREATE TABLE IF NOT EXISTS anonymous_comment_counters (
  page_id INTEGER NOT NULL PRIMARY KEY,
  next_number INTEGER DEFAULT 1,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);

-- Table to track daily comment limits for anonymous users (by IP hash)
CREATE TABLE IF NOT EXISTS anonymous_daily_limits (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  ip_hash TEXT NOT NULL,
  date DATE NOT NULL,
  count INTEGER DEFAULT 1,
  UNIQUE(page_id, ip_hash, date),
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_anonymous_daily_limits_lookup ON anonymous_daily_limits(page_id, ip_hash, date);

-- Update comment_votes to support anonymous users (use ip_hash instead of user_id for anonymous)
-- Note: This requires changing the schema, but we'll handle anonymous votes differently
-- For now, anonymous users can't vote (as per requirements, they can only like/dislike once)
-- But we need to track this by IP hash

-- Add ip_hash to comment_votes for anonymous voting
ALTER TABLE comment_votes ADD COLUMN ip_hash TEXT;
ALTER TABLE comment_votes ADD COLUMN is_anonymous INTEGER DEFAULT 0 CHECK(is_anonymous IN (0, 1));

-- Update unique constraint: for logged-in users, use (comment_id, user_id)
-- For anonymous users, use (comment_id, ip_hash)
-- This will be handled in application logic

