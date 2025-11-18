-- Phase 3 Day 4: 사용자 아이디(username) 필드 추가
-- 작성일: 2025-11-17

-- username 컬럼 추가 (NULL 허용 - 기존 사용자는 NULL)
-- SQLite는 UNIQUE 제약조건을 ALTER TABLE에서 직접 추가할 수 없으므로, 먼저 일반 컬럼으로 추가
ALTER TABLE users ADD COLUMN username TEXT;

-- username 고유 인덱스 생성 (UNIQUE 제약조건 역할)
CREATE UNIQUE INDEX IF NOT EXISTS idx_users_username ON users(username);

-- 참고:
-- - 신규 사용자는 회원가입 시 자동으로 username 생성
-- - 기존 사용자는 username이 NULL일 수 있음 (선택적 업데이트)
-- - UNIQUE 인덱스로 중복 방지

