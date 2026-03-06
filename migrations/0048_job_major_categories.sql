-- 직업 MECE 분류 테이블 (대분류 + 중분류)
CREATE TABLE IF NOT EXISTS job_categories (
  job_id TEXT PRIMARY KEY,
  large_category TEXT NOT NULL,
  medium_category TEXT,
  source TEXT NOT NULL DEFAULT 'llm',
  confidence REAL DEFAULT 0.8,
  created_at INTEGER DEFAULT (unixepoch() * 1000),
  updated_at INTEGER DEFAULT (unixepoch() * 1000),
  FOREIGN KEY (job_id) REFERENCES jobs(id)
);
CREATE INDEX IF NOT EXISTS idx_jc_large ON job_categories(large_category);
CREATE INDEX IF NOT EXISTS idx_jc_medium ON job_categories(medium_category);

-- 전공 분류 테이블 (대분류만)
CREATE TABLE IF NOT EXISTS major_categories (
  major_id TEXT PRIMARY KEY,
  large_category TEXT NOT NULL,
  source TEXT NOT NULL DEFAULT 'attribute',
  confidence REAL DEFAULT 1.0,
  created_at INTEGER DEFAULT (unixepoch() * 1000),
  updated_at INTEGER DEFAULT (unixepoch() * 1000),
  FOREIGN KEY (major_id) REFERENCES majors(id)
);
CREATE INDEX IF NOT EXISTS idx_mc_large ON major_categories(large_category);
