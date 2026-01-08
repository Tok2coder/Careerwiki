-- howto_drafts 테이블에 published_page_id 컬럼 추가
-- 발행된 페이지(pages 테이블)를 편집할 때 draft와 연결하기 위함

ALTER TABLE howto_drafts ADD COLUMN published_page_id INTEGER;

-- 인덱스 추가
CREATE INDEX IF NOT EXISTS idx_drafts_published_page ON howto_drafts(published_page_id);

