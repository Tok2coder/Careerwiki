-- 0049_career_trees.sql
-- 커리어트리: 유명 인물의 실제 커리어 경로 저장
-- 직업 상세 페이지 "과정" 탭에서 크로스 레퍼런스 표시

-- 커리어트리: 한 인물의 전체 커리어 경로
CREATE TABLE IF NOT EXISTS career_trees (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  person_name TEXT NOT NULL,
  person_name_en TEXT,
  person_title TEXT,              -- 간략 소개 (예: 'Apple CEO')
  person_image_url TEXT,
  stages_json TEXT NOT NULL DEFAULT '[]',  -- JSON: CareerTreeStage[]
  display_priority INTEGER NOT NULL DEFAULT 100,  -- 낮을수록 먼저 표시
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER DEFAULT (unixepoch() * 1000),
  updated_at INTEGER DEFAULT (unixepoch() * 1000)
);

-- 커리어트리 ↔ 직업 페이지 연결 (N:M)
-- 한 인물이 여러 직업 페이지에 노출, 한 직업 페이지에 여러 인물
CREATE TABLE IF NOT EXISTS career_tree_job_links (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  career_tree_id INTEGER NOT NULL,
  job_slug TEXT NOT NULL,
  stage_index INTEGER,            -- stages_json에서의 인덱스 (하이라이트용)
  FOREIGN KEY (career_tree_id) REFERENCES career_trees(id) ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS idx_ctjl_job_slug ON career_tree_job_links(job_slug);
CREATE INDEX IF NOT EXISTS idx_ctjl_tree_id ON career_tree_job_links(career_tree_id);
