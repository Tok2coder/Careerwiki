-- HowTo 에디터 시스템 전체 스키마
-- 설계 원칙:
-- - 초안(drafts)은 DRAFT/REVIEW만 관리, 퍼블리시되면 본 테이블(howtos)로 이동
-- - JSON 배열 대신 정규화된 관계 테이블로 검색/집계/무결성 확보
-- - content_html은 퍼블리시 시점에만 확정

-- =====================================================
-- 본문 테이블 (퍼블리시된 문서)
-- =====================================================
CREATE TABLE IF NOT EXISTS howtos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  summary TEXT,
  thumbnail_url TEXT,
  content_json TEXT NOT NULL,    -- Tiptap JSON (편집용 truth)
  content_html TEXT NOT NULL,    -- 렌더링용 HTML (퍼블리시 시 확정)
  version INTEGER NOT NULL DEFAULT 1,
  view_count INTEGER DEFAULT 0,
  report_count INTEGER DEFAULT 0,
  status TEXT DEFAULT 'published' CHECK(status IN ('published', 'blinded', 'deleted')),
  blind_reason TEXT,
  blinded_at DATETIME,
  blinded_by INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);

-- =====================================================
-- 초안 테이블 (DRAFT/REVIEW만)
-- =====================================================
CREATE TABLE IF NOT EXISTS howto_drafts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  base_howto_id INTEGER,           -- 기존 글 수정 초안인 경우 참조
  title TEXT,
  slug TEXT,                       -- 미정/후보일 수 있음
  summary TEXT,
  thumbnail_url TEXT,
  content_json TEXT,               -- Tiptap JSON
  content_html TEXT,               -- (선택) 미리보기 캐시
  version INTEGER NOT NULL DEFAULT 1,  -- 낙관적 락용
  stage TEXT NOT NULL DEFAULT 'DRAFT' CHECK(stage IN ('DRAFT', 'REVIEW')),
  last_saved_at DATETIME,          -- 마지막 저장 시각 (자동저장용)
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (base_howto_id) REFERENCES howtos(id) ON DELETE SET NULL
);

-- =====================================================
-- 태그 테이블 (정규화)
-- =====================================================
CREATE TABLE IF NOT EXISTS tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE,
  usage_count INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- HowTo-태그 연결 테이블
CREATE TABLE IF NOT EXISTS howto_tags (
  howto_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  PRIMARY KEY (howto_id, tag_id),
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- 초안-태그 연결 테이블 (초안 단계에서도 태그 관리)
CREATE TABLE IF NOT EXISTS draft_tags (
  draft_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  PRIMARY KEY (draft_id, tag_id),
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- =====================================================
-- 연결 테이블 (직업/전공/HowTo)
-- =====================================================
-- HowTo-직업 연결
CREATE TABLE IF NOT EXISTS howto_related_jobs (
  howto_id INTEGER NOT NULL,
  job_id TEXT NOT NULL,            -- jobs 테이블의 id (문자열)
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (howto_id, job_id),
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);

-- HowTo-전공 연결
CREATE TABLE IF NOT EXISTS howto_related_majors (
  howto_id INTEGER NOT NULL,
  major_id TEXT NOT NULL,          -- majors 테이블의 id (문자열)
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (howto_id, major_id),
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);

-- HowTo-HowTo 연결 (관련 가이드)
CREATE TABLE IF NOT EXISTS howto_related_howtos (
  parent_howto_id INTEGER NOT NULL,
  child_howto_id INTEGER NOT NULL,
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (parent_howto_id, child_howto_id),
  FOREIGN KEY (parent_howto_id) REFERENCES howtos(id) ON DELETE CASCADE,
  FOREIGN KEY (child_howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);

-- 초안용 연결 테이블 (퍼블리시 전 관계 저장)
CREATE TABLE IF NOT EXISTS draft_related_jobs (
  draft_id INTEGER NOT NULL,
  job_id TEXT NOT NULL,
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (draft_id, job_id),
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS draft_related_majors (
  draft_id INTEGER NOT NULL,
  major_id TEXT NOT NULL,
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (draft_id, major_id),
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS draft_related_howtos (
  draft_id INTEGER NOT NULL,
  howto_id INTEGER NOT NULL,
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (draft_id, howto_id),
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE,
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);

-- =====================================================
-- 슬러그 히스토리 (301 리다이렉트용, SEO 유지)
-- =====================================================
CREATE TABLE IF NOT EXISTS slug_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  howto_id INTEGER NOT NULL,
  old_slug TEXT NOT NULL,
  changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);

-- =====================================================
-- 검수 로그 (승인/반려 기록)
-- =====================================================
CREATE TABLE IF NOT EXISTS howto_reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  draft_id INTEGER NOT NULL,
  reviewer_id INTEGER NOT NULL,
  decision TEXT NOT NULL CHECK(decision IN ('APPROVED', 'REJECTED')),
  reason TEXT,                     -- 반려 시 사유
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE,
  FOREIGN KEY (reviewer_id) REFERENCES users(id) ON DELETE SET NULL
);

-- =====================================================
-- 업로드 파일 메타데이터 (R2 파일 추적)
-- =====================================================
CREATE TABLE IF NOT EXISTS uploaded_files (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  file_key TEXT NOT NULL UNIQUE,   -- R2 키 (howto/2024/11/30/uuid.jpg)
  original_name TEXT,              -- 원본 파일명
  content_type TEXT NOT NULL,
  file_size INTEGER NOT NULL,
  width INTEGER,                   -- 이미지 너비
  height INTEGER,                  -- 이미지 높이
  alt_text TEXT,                   -- 대체 텍스트
  caption TEXT,                    -- 캡션
  used_in_howto_id INTEGER,        -- 사용 중인 HowTo ID (NULL이면 미사용)
  used_in_draft_id INTEGER,        -- 사용 중인 초안 ID
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (used_in_howto_id) REFERENCES howtos(id) ON DELETE SET NULL,
  FOREIGN KEY (used_in_draft_id) REFERENCES howto_drafts(id) ON DELETE SET NULL
);

-- =====================================================
-- 인덱스
-- =====================================================
CREATE INDEX IF NOT EXISTS idx_howtos_slug ON howtos(slug);
CREATE INDEX IF NOT EXISTS idx_howtos_author ON howtos(author_id);
CREATE INDEX IF NOT EXISTS idx_howtos_status ON howtos(status);
CREATE INDEX IF NOT EXISTS idx_howtos_updated_at ON howtos(updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_howtos_created_at ON howtos(created_at DESC);

CREATE INDEX IF NOT EXISTS idx_drafts_user ON howto_drafts(user_id);
CREATE INDEX IF NOT EXISTS idx_drafts_stage ON howto_drafts(stage);
CREATE INDEX IF NOT EXISTS idx_drafts_base ON howto_drafts(base_howto_id);
CREATE INDEX IF NOT EXISTS idx_drafts_updated_at ON howto_drafts(updated_at DESC);

CREATE INDEX IF NOT EXISTS idx_tags_slug ON tags(slug);
CREATE INDEX IF NOT EXISTS idx_tags_usage ON tags(usage_count DESC);

CREATE INDEX IF NOT EXISTS idx_slug_history_old ON slug_history(old_slug);
CREATE INDEX IF NOT EXISTS idx_slug_history_howto ON slug_history(howto_id);

CREATE INDEX IF NOT EXISTS idx_reviews_draft ON howto_reviews(draft_id);
CREATE INDEX IF NOT EXISTS idx_reviews_reviewer ON howto_reviews(reviewer_id);

CREATE INDEX IF NOT EXISTS idx_uploads_user ON uploaded_files(user_id);
CREATE INDEX IF NOT EXISTS idx_uploads_key ON uploaded_files(file_key);
CREATE INDEX IF NOT EXISTS idx_uploads_howto ON uploaded_files(used_in_howto_id);
CREATE INDEX IF NOT EXISTS idx_uploads_draft ON uploaded_files(used_in_draft_id);

-- =====================================================
-- 트리거: updated_at 자동 갱신
-- (D1 remote에서 CREATE TRIGGER 문법 이슈로 주석 처리)
-- =====================================================
-- CREATE TRIGGER IF NOT EXISTS trg_howtos_updated_at
-- AFTER UPDATE ON howtos FOR EACH ROW
-- BEGIN
--   UPDATE howtos SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
-- END;

-- CREATE TRIGGER IF NOT EXISTS trg_drafts_updated_at
-- AFTER UPDATE ON howto_drafts FOR EACH ROW
-- BEGIN
--   UPDATE howto_drafts SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
-- END;

-- =====================================================
-- 트리거: 태그 사용 횟수 자동 갱신
-- =====================================================
-- CREATE TRIGGER IF NOT EXISTS trg_howto_tags_insert
-- AFTER INSERT ON howto_tags FOR EACH ROW
-- BEGIN
--   UPDATE tags SET usage_count = usage_count + 1 WHERE id = NEW.tag_id;
-- END;

-- CREATE TRIGGER IF NOT EXISTS trg_howto_tags_delete
-- AFTER DELETE ON howto_tags FOR EACH ROW
-- BEGIN
--   UPDATE tags SET usage_count = usage_count - 1 WHERE id = OLD.tag_id;
-- END;
