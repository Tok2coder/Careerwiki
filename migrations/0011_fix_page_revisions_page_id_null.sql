-- Phase 4: page_revisions 테이블의 page_id를 NULL 허용으로 변경
-- 작성일: 2025-01-XX
-- 목적: 새로운 entity_type/entity_id 구조에서 page_id를 선택적으로 사용

-- SQLite는 ALTER COLUMN을 직접 지원하지 않으므로, 테이블을 재생성해야 합니다.
-- 하지만 기존 데이터를 보존해야 하므로, 다음 단계로 진행합니다:

-- 1. 임시 테이블 생성 (page_id를 NULL 허용)
CREATE TABLE IF NOT EXISTS page_revisions_new (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER,  -- NULL 허용으로 변경
  entity_type TEXT CHECK(entity_type IN ('job', 'major', 'howto', 'guide')),
  entity_id TEXT,
  revision_number INTEGER,
  is_current INTEGER DEFAULT 0 CHECK(is_current IN (0, 1)),
  editor_id TEXT,
  editor_type TEXT CHECK(editor_type IN ('anonymous', 'user', 'expert', 'admin', 'system')),
  editor_name TEXT,
  password_hash TEXT,
  anonymous_number INTEGER,
  ip_hash TEXT,
  change_type TEXT CHECK(change_type IN ('initial', 'edit', 'restore', 'merge')),
  change_summary TEXT,
  changed_fields TEXT,
  data_snapshot TEXT,
  source_url TEXT,
  source_type TEXT CHECK(source_type IN ('website', 'academic', 'government', 'news', 'other')),
  content TEXT NOT NULL DEFAULT '',
  editor_ip TEXT,
  user_id TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);

-- 2. 기존 데이터 복사 (모든 컬럼을 명시적으로 지정하여 안전하게 복사)
INSERT INTO page_revisions_new (
  id, page_id, entity_type, entity_id, revision_number, is_current,
  editor_id, editor_type, editor_name, password_hash, anonymous_number, ip_hash,
  change_type, change_summary, changed_fields, data_snapshot,
  source_url, source_type, content, editor_ip, user_id, created_at
)
SELECT 
  id, page_id, entity_type, entity_id, revision_number, is_current,
  editor_id, editor_type, editor_name, password_hash, anonymous_number, ip_hash,
  change_type, change_summary, changed_fields, data_snapshot,
  source_url, source_type, 
  COALESCE(content, '') as content,  -- content가 NULL이면 빈 문자열로
  editor_ip, 
  user_id,  -- user_id 컬럼이 없을 수도 있으므로 (0010 마이그레이션 전 데이터)
  created_at
FROM page_revisions;

-- 3. 기존 테이블 삭제
DROP TABLE page_revisions;

-- 4. 새 테이블을 원래 이름으로 변경
ALTER TABLE page_revisions_new RENAME TO page_revisions;

-- 5. 인덱스 재생성
CREATE INDEX IF NOT EXISTS idx_revisions_entity ON page_revisions(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_revisions_current ON page_revisions(entity_type, entity_id, is_current);
CREATE INDEX IF NOT EXISTS idx_revisions_number ON page_revisions(entity_type, entity_id, revision_number);
CREATE INDEX IF NOT EXISTS idx_revisions_editor ON page_revisions(editor_id, editor_type);
CREATE INDEX IF NOT EXISTS idx_revisions_created ON page_revisions(created_at DESC);

