-- job-detail.ts hot 경로 step 2 (LOWER(REPLACE(slug,'-','')) = ?) 인덱스화
-- 사용자-facing /job/:slug fallback이 활성 직업 전건(~6,900 rows) 스캔 → 인덱스 point lookup 전환
-- VIRTUAL generated column: ALTER TABLE ADD COLUMN 허용 (STORED은 불가), 인덱스가 표현식을 물리화
ALTER TABLE jobs ADD COLUMN slug_normalized TEXT
  GENERATED ALWAYS AS (LOWER(REPLACE(slug, '-', ''))) VIRTUAL;

CREATE INDEX IF NOT EXISTS idx_jobs_slug_normalized ON jobs(slug_normalized);
