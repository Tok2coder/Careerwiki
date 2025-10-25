-- AI 분석 파이프라인 및 사용자 세션 기록용 테이블
CREATE TABLE IF NOT EXISTS ai_sessions (
  id TEXT PRIMARY KEY,
  user_identifier TEXT, -- 이메일 또는 익명 세션 식별자
  traits_snapshot TEXT, -- 사용자가 제출한 MBTI/흥미/가치관 JSON
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_active_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- AI 분석 요청 테이블 (Step4)
CREATE TABLE IF NOT EXISTS ai_analysis_requests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL,
  analysis_type TEXT NOT NULL CHECK(analysis_type IN ('job', 'major')),
  pricing_tier TEXT DEFAULT 'free' CHECK(pricing_tier IN ('free', 'pro')),
  prompt_payload TEXT NOT NULL,
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'processing', 'completed', 'failed')),
  requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  processed_at DATETIME,
  FOREIGN KEY (session_id) REFERENCES ai_sessions(id) ON DELETE CASCADE
);

-- AI 분석 결과 저장
CREATE TABLE IF NOT EXISTS ai_analysis_results (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  request_id INTEGER NOT NULL,
  provider TEXT NOT NULL, -- 예: 'anthropic', 'openai'
  model TEXT,
  completion_tokens INTEGER,
  prompt_tokens INTEGER,
  total_tokens INTEGER,
  latency_ms INTEGER,
  response_summary TEXT,
  response_payload TEXT NOT NULL, -- 전체 JSON 응답
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (request_id) REFERENCES ai_analysis_requests(id) ON DELETE CASCADE
);

-- 사용자 검색/상호작용 로그 요약 (하이드레이션 이벤트 → 배치 적재 예정)
CREATE TABLE IF NOT EXISTS serp_interaction_logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major')),
  action TEXT NOT NULL, -- sort-change, filter-submit, per-page-change 등
  keyword_length INTEGER,
  category TEXT,
  per_page INTEGER,
  results INTEGER,
  cache_status TEXT,
  duration_ms INTEGER,
  sampled BOOLEAN DEFAULT 1,
  source TEXT DEFAULT 'hydration',
  recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 지표 집계를 위한 Materialized Summary 테이블 (일/페이지 기준)
CREATE TABLE IF NOT EXISTS serp_interaction_daily_summary (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  log_date TEXT NOT NULL, -- YYYY-MM-DD
  page_type TEXT NOT NULL,
  action TEXT NOT NULL,
  samples INTEGER DEFAULT 0,
  avg_duration_ms REAL,
  avg_results REAL,
  cache_hit_ratio REAL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(log_date, page_type, action)
);

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_ai_requests_session ON ai_analysis_requests(session_id);
CREATE INDEX IF NOT EXISTS idx_ai_results_request ON ai_analysis_results(request_id);
CREATE INDEX IF NOT EXISTS idx_serp_logs_page_action ON serp_interaction_logs(page_type, action);
CREATE INDEX IF NOT EXISTS idx_serp_logs_recorded_at ON serp_interaction_logs(recorded_at);
CREATE INDEX IF NOT EXISTS idx_serp_summary_date ON serp_interaction_daily_summary(log_date);
