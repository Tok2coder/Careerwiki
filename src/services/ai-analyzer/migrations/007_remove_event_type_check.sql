-- Migration 007: Remove event_type CHECK constraint
-- Reason: [수정사항 2] 새로운 event_type 문자열 기록 허용
-- Warning: SQLite requires table recreation to modify constraints
-- This migration is for LOCAL DEVELOPMENT only

-- Step 1: Create new table without CHECK constraint
CREATE TABLE IF NOT EXISTS raw_events_new (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT,
  session_id TEXT NOT NULL,
  event_type TEXT NOT NULL,  -- CHECK constraint REMOVED
  payload_json TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  client_meta TEXT
);

-- Step 2: Copy existing data
INSERT INTO raw_events_new (id, user_id, session_id, event_type, payload_json, created_at, client_meta)
SELECT id, user_id, session_id, event_type, payload_json, created_at, client_meta FROM raw_events;

-- Step 3: Drop old table
DROP TABLE IF EXISTS raw_events;

-- Step 4: Rename new table
ALTER TABLE raw_events_new RENAME TO raw_events;

-- Step 5: Recreate indexes
CREATE INDEX IF NOT EXISTS idx_raw_events_session ON raw_events(session_id);
CREATE INDEX IF NOT EXISTS idx_raw_events_user ON raw_events(user_id);
CREATE INDEX IF NOT EXISTS idx_raw_events_type ON raw_events(event_type);








