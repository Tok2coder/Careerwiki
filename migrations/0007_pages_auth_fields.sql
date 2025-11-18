-- Phase 3: pages 테이블에 인증 관련 필드 추가
-- 작성일: 2025-11-17
-- 목적: HowTo 작성자 추적 및 API 데이터 구분

-- pages 테이블에 author_id 추가 (HowTo 작성자 추적용)
ALTER TABLE pages ADD COLUMN author_id INTEGER;

-- pages 테이블에 source 필드 추가 (데이터 출처 구분)
-- 'careernet': CareerNet API 데이터
-- 'goyong24': Goyong24 API 데이터
-- 'admin': 운영진이 추가한 데이터
-- 'user': 사용자가 추가한 데이터 (HowTo 등)
ALTER TABLE pages ADD COLUMN source TEXT CHECK(source IN ('careernet', 'goyong24', 'admin', 'user'));

-- 기존 데이터 업데이트
-- 직업/전공 페이지는 API 데이터로 간주 (실제로는 jobs/majors 테이블에 있지만, pages 테이블과의 일관성을 위해)
UPDATE pages 
SET source = 'admin' 
WHERE source IS NULL AND page_type IN ('job', 'major');

-- HowTo는 사용자 생성으로 간주 (기본값)
UPDATE pages 
SET source = 'user' 
WHERE source IS NULL AND page_type = 'guide';

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_pages_author_id ON pages(author_id);
CREATE INDEX IF NOT EXISTS idx_pages_source ON pages(source);

-- page_revisions 테이블에 user_id 추가 (편집자 추적)
ALTER TABLE page_revisions ADD COLUMN user_id INTEGER;

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_page_revisions_user_id ON page_revisions(user_id);

-- 참고:
-- - author_id: HowTo 작성자 (user.id 참조)
-- - source: 데이터 출처 ('careernet', 'goyong24', 'admin', 'user')
-- - page_revisions.user_id: 편집자 추적 (user.id 참조)
-- - Phase 3: 직업/전공 페이지 편집은 admin만 가능
-- - Ver. 2.0: 익명 편집 허용 예정


