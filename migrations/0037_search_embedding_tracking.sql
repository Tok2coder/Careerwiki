-- 전공/HowTo Vectorize 인덱싱 추적 컬럼
-- majors/pages 테이블에 indexed_at, embedding_version 추가

ALTER TABLE majors ADD COLUMN indexed_at DATETIME DEFAULT NULL;
ALTER TABLE majors ADD COLUMN embedding_version TEXT DEFAULT NULL;
ALTER TABLE pages ADD COLUMN indexed_at DATETIME DEFAULT NULL;
ALTER TABLE pages ADD COLUMN embedding_version TEXT DEFAULT NULL;
CREATE INDEX IF NOT EXISTS idx_majors_indexed_at ON majors(indexed_at);
CREATE INDEX IF NOT EXISTS idx_pages_indexed_at ON pages(indexed_at);
