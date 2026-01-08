-- Migration: Add image fields for jobs and majors
-- Created: 2024-11-24
-- Description: 직업/전공 페이지 히어로 이미지를 위한 필드 추가

-- Jobs 테이블에 이미지 필드 추가
ALTER TABLE jobs ADD COLUMN image_url TEXT;
ALTER TABLE jobs ADD COLUMN image_alt TEXT;
ALTER TABLE jobs ADD COLUMN image_credits TEXT; -- 이미지 출처/저작권 정보

-- Majors 테이블에 이미지 필드 추가
ALTER TABLE majors ADD COLUMN image_url TEXT;
ALTER TABLE majors ADD COLUMN image_alt TEXT;
ALTER TABLE majors ADD COLUMN image_credits TEXT;

-- 인덱스 생성 (이미지가 있는 항목 빠르게 조회)
CREATE INDEX IF NOT EXISTS idx_jobs_image ON jobs(image_url) WHERE image_url IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_majors_image ON majors(image_url) WHERE image_url IS NOT NULL;

-- 메타데이터 기록 (wrangler d1 migrations가 자동 추적하므로 불필요)
-- INSERT INTO schema_migrations (version, description, applied_at) 
-- VALUES ('0019', 'Add image fields for jobs and majors', datetime('now'));

