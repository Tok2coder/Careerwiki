-- Phase 9: 추천 결과 캐싱 — 동일 프로필+답변 → 동일 추천 결과 (일관성 보장)
-- Workers AI(분산 GPU)의 비결정성을 우회하기 위해 결과 자체를 캐싱

CREATE TABLE IF NOT EXISTS recommendation_result_cache (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  profile_hash TEXT NOT NULL,
  analysis_type TEXT NOT NULL DEFAULT 'job',
  engine_version TEXT NOT NULL,
  result_json TEXT NOT NULL,
  premium_report_json TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  hit_count INTEGER NOT NULL DEFAULT 0,
  UNIQUE(profile_hash, analysis_type, engine_version)
);

CREATE INDEX IF NOT EXISTS idx_rec_cache_hash ON recommendation_result_cache(profile_hash, analysis_type, engine_version);
