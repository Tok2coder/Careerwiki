-- Phase 3: 사용자 인증 시스템
-- users 테이블 생성
-- 작성일: 2025-11-17

CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  google_id TEXT UNIQUE NOT NULL,
  email TEXT NOT NULL,
  name TEXT,
  picture_url TEXT,
  role TEXT DEFAULT 'user' CHECK(role IN ('user', 'expert', 'admin')),
  
  -- 통계
  edit_count INTEGER DEFAULT 0,
  comment_count INTEGER DEFAULT 0,
  
  -- 상태
  is_banned INTEGER DEFAULT 0,  -- SQLite는 BOOLEAN 대신 INTEGER
  ban_reason TEXT,
  banned_until INTEGER,  -- UNIX timestamp
  
  -- 타임스탬프
  last_login_at INTEGER,
  created_at INTEGER DEFAULT (strftime('%s','now')),
  updated_at INTEGER DEFAULT (strftime('%s','now'))
);

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_users_google_id ON users(google_id);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

-- 참고:
-- - anonymous (비로그인 유저)는 users 테이블에 없음
-- - 로그인하지 않은 사용자는 role = 'anonymous'로 처리 (코드에서)
-- - Phase 3: 직업/전공 페이지 편집은 admin만 가능
-- - Ver. 2.0: 익명 편집 허용 예정







