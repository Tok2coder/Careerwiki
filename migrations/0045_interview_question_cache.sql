-- R1 질문 캐싱: 동일 프로필 → 동일 R1 질문 반환 (일관성 향상)
CREATE TABLE IF NOT EXISTS interview_question_cache (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  profile_hash TEXT NOT NULL,           -- mini_module_result + narrative_facts 해시
  analysis_type TEXT NOT NULL DEFAULT 'job',  -- 'job' | 'major'
  round_number INTEGER NOT NULL DEFAULT 1,
  questions_json TEXT NOT NULL,          -- 캐시된 질문 배열 (JSON)
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  hit_count INTEGER NOT NULL DEFAULT 0,  -- 캐시 히트 횟수
  UNIQUE(profile_hash, analysis_type, round_number)
);

CREATE INDEX IF NOT EXISTS idx_interview_cache_hash ON interview_question_cache(profile_hash, analysis_type, round_number);
