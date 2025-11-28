-- Phase 4: 편집 시스템 - page_revisions 테이블 확장 및 편집 관련 테이블 생성
-- 작성일: 2025-01-XX
-- 목적: 버전 히스토리 시스템 및 익명 편집 지원을 위한 데이터베이스 확장

-- ============================================
-- 1. page_revisions 테이블 확장
-- ============================================

-- page_id를 NULL 허용으로 변경 (새로운 entity_type/entity_id 구조 사용)
-- SQLite는 ALTER COLUMN을 직접 지원하지 않으므로, 기본값만 설정
-- 실제로는 INSERT 시 NULL을 허용하도록 애플리케이션에서 처리

-- 엔티티 식별 필드 추가 (job, major, howto 모두 지원)
ALTER TABLE page_revisions ADD COLUMN entity_type TEXT CHECK(entity_type IN ('job', 'major', 'howto', 'guide'));
ALTER TABLE page_revisions ADD COLUMN entity_id TEXT;

-- 버전 정보 필드 추가
ALTER TABLE page_revisions ADD COLUMN revision_number INTEGER;
ALTER TABLE page_revisions ADD COLUMN is_current INTEGER DEFAULT 0 CHECK(is_current IN (0, 1));

-- 편집자 정보 필드 추가
ALTER TABLE page_revisions ADD COLUMN editor_id TEXT;  -- users.id (익명이면 null)
ALTER TABLE page_revisions ADD COLUMN editor_type TEXT CHECK(editor_type IN ('anonymous', 'user', 'expert', 'admin', 'system'));
ALTER TABLE page_revisions ADD COLUMN editor_name TEXT;  -- 사용자명 또는 "익명 1" 또는 "시스템"
ALTER TABLE page_revisions ADD COLUMN password_hash TEXT;  -- 익명 편집 시 비밀번호 해시
ALTER TABLE page_revisions ADD COLUMN anonymous_number INTEGER;  -- 익명 번호
ALTER TABLE page_revisions ADD COLUMN ip_hash TEXT;  -- IP 해시 (개인정보 보호)

-- 편집 내용 필드 추가
ALTER TABLE page_revisions ADD COLUMN change_type TEXT CHECK(change_type IN ('initial', 'edit', 'restore', 'merge'));
ALTER TABLE page_revisions ADD COLUMN changed_fields TEXT;  -- JSON array: ["summary", "duties"]

-- 전체 데이터 스냅샷 필드 추가 (핵심!)
ALTER TABLE page_revisions ADD COLUMN data_snapshot TEXT;  -- 전체 JSON 데이터 (api_data_json + user_contributed_json + admin_data_json 병합 결과)

-- 출처 정보 필드 추가
ALTER TABLE page_revisions ADD COLUMN source_url TEXT;  -- 출처 URL
ALTER TABLE page_revisions ADD COLUMN source_type TEXT CHECK(source_type IN ('website', 'academic', 'government', 'news', 'other'));

-- ============================================
-- 2. 기존 데이터 마이그레이션 (page_id → entity_type + entity_id)
-- ============================================

-- 기존 page_revisions 데이터를 새 구조로 마이그레이션
-- page_id가 pages 테이블을 참조하므로, pages 테이블의 slug와 page_type을 사용
UPDATE page_revisions 
SET 
  entity_type = CASE 
    WHEN EXISTS (
      SELECT 1 FROM pages 
      WHERE pages.id = page_revisions.page_id 
      AND pages.page_type = 'guide'
    ) THEN 'guide'
    ELSE NULL  -- job, major는 pages 테이블에 없을 수 있음 (jobs/majors 테이블에 있음)
  END,
  entity_id = (
    SELECT slug FROM pages 
    WHERE pages.id = page_revisions.page_id
  ),
  revision_number = (
    SELECT COUNT(*) 
    FROM page_revisions pr2 
    WHERE pr2.page_id = page_revisions.page_id 
    AND pr2.created_at <= page_revisions.created_at
  ),
  is_current = CASE 
    WHEN created_at = (
      SELECT MAX(created_at) 
      FROM page_revisions pr2 
      WHERE pr2.page_id = page_revisions.page_id
    )
    THEN 1 
    ELSE 0 
  END,
  editor_type = CASE 
    WHEN user_id IS NOT NULL THEN 'user'
    ELSE 'anonymous'
  END,
  change_type = 'edit',
  data_snapshot = json_object(
    'content', content,
    'change_summary', change_summary
  )
WHERE entity_type IS NULL;

-- ============================================
-- 3. anonymous_edit_limits 테이블 생성 (일일 편집 제한용)
-- ============================================

CREATE TABLE IF NOT EXISTS anonymous_edit_limits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    entity_type TEXT NOT NULL CHECK(entity_type IN ('job', 'major', 'howto')),
    entity_id TEXT NOT NULL,
    ip_hash TEXT NOT NULL,
    edit_date TEXT NOT NULL,  -- YYYY-MM-DD 형식
    edit_count INTEGER DEFAULT 0,
    last_edit_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(entity_type, entity_id, ip_hash, edit_date)
);

-- ============================================
-- 4. 인덱스 추가 (성능 최적화)
-- ============================================

-- page_revisions 테이블 인덱스
CREATE INDEX IF NOT EXISTS idx_revisions_entity ON page_revisions(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_revisions_current ON page_revisions(entity_type, entity_id, is_current);
CREATE INDEX IF NOT EXISTS idx_revisions_number ON page_revisions(entity_type, entity_id, revision_number);
CREATE INDEX IF NOT EXISTS idx_revisions_editor ON page_revisions(editor_id, editor_type);
CREATE INDEX IF NOT EXISTS idx_revisions_created ON page_revisions(created_at DESC);

-- anonymous_edit_limits 테이블 인덱스
CREATE INDEX IF NOT EXISTS idx_anonymous_limits ON anonymous_edit_limits(entity_type, entity_id, ip_hash, edit_date);

-- ============================================
-- 5. UNIQUE 제약 조건 추가 (revision_number 중복 방지)
-- ============================================

-- SQLite는 ALTER TABLE로 UNIQUE 제약을 추가할 수 없으므로, 
-- 애플리케이션 레벨에서 검증하거나 별도 인덱스로 처리
-- (이미 idx_revisions_number 인덱스가 있으므로 충분)

-- 참고:
-- - entity_type: 'job', 'major', 'howto', 'guide' (기존 guide 호환)
-- - entity_id: jobs.id, majors.id, pages.slug 등
-- - revision_number: 1부터 시작하는 순차 번호
-- - is_current: 현재 활성 버전만 1, 나머지는 0
-- - data_snapshot: 전체 데이터 스냅샷 (JSON)
-- - editor_type: 'anonymous', 'user', 'expert', 'admin', 'system'
-- - anonymous_edit_limits: IP별 일일 편집 제한 추적

