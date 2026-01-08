-- CareerWiki AI Analyzer D1 Schema
-- Version: v0.2.1-final
-- Created: 2026-01-02
--
-- ⚠️ DESIGN DECISION: Foreign Keys intentionally omitted
-- Reason: D1/SQLite FK constraints cause dev/replay friction.
-- We use "logical joins + event sourcing" pattern instead.
-- Indexes are added for query performance.

-- ============================================
-- 1. 원본 이벤트 저장 (append-only, Event Sourcing)
-- ============================================
CREATE TABLE IF NOT EXISTS raw_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT,
  session_id TEXT NOT NULL,
  event_type TEXT NOT NULL CHECK(event_type IN (
    'FORM_SUBMITTED',
    'FOLLOWUP_ANSWERED',
    'ANALYSIS_REQUESTED',
    'ANALYSIS_COMPLETED',
    'FACT_CONFIRMED',           -- follow-up "no" → constraint 확정
    'RISK_ACCEPTED'             -- follow-up "yes" → 특정 직업 risk 수용
  )),
  payload_json TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  client_meta TEXT              -- user-agent, referrer 등
);

CREATE INDEX IF NOT EXISTS idx_raw_events_session ON raw_events(session_id);
CREATE INDEX IF NOT EXISTS idx_raw_events_user ON raw_events(user_id);
CREATE INDEX IF NOT EXISTS idx_raw_events_type ON raw_events(event_type);

-- ============================================
-- 2. 분석 요청 (버전 잠금으로 재현성 보장)
-- ============================================
CREATE TABLE IF NOT EXISTS ai_analysis_requests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL,
  user_id TEXT,
  analysis_type TEXT DEFAULT 'job' CHECK(analysis_type IN ('job', 'major')),
  pricing_tier TEXT DEFAULT 'free' CHECK(pricing_tier IN ('free', 'pro')),
  
  -- 유저 입력 (정규화된 프로필)
  prompt_payload TEXT NOT NULL,   -- 분석에 사용된 유저 프로필 JSON
  
  -- 상태
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'processing', 'completed', 'failed')),
  requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  processed_at DATETIME,
  
  -- 버전 잠금 (재현성 핵심!)
  recipe_version TEXT NOT NULL DEFAULT 'recipe-v1.0.0',
  tagger_version TEXT NOT NULL DEFAULT 'tagger-v1.0.0',
  scoring_version TEXT NOT NULL DEFAULT 'scoring-v0.2.1-final',
  
  -- 프로필 스냅샷 (향후 확장)
  profile_revision_id TEXT
  -- FK 제거: session_id는 raw_events와 논리적으로만 연결 (조인용)
);

CREATE INDEX IF NOT EXISTS idx_requests_session ON ai_analysis_requests(session_id);
CREATE INDEX IF NOT EXISTS idx_requests_status ON ai_analysis_requests(status);

-- ============================================
-- 3. 분석 결과 (result_json 저장)
-- ============================================
CREATE TABLE IF NOT EXISTS ai_analysis_results (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  request_id INTEGER NOT NULL,
  
  -- 전체 결과 JSON (Fit TOP3 + Like TOP10 + Can TOP10 + caution_jobs + ux_flags)
  result_json TEXT NOT NULL,
  
  -- 메타
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  -- FK 제거: 논리적으로만 연결
);

CREATE INDEX IF NOT EXISTS idx_results_request ON ai_analysis_results(request_id);

-- ============================================
-- 4. follow-up 응답 저장
-- ============================================
CREATE TABLE IF NOT EXISTS followup_responses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  request_id INTEGER NOT NULL,
  
  -- 질문 정보
  question_id TEXT NOT NULL,
  
  -- constraint_type: 표준 5개만 허용!
  constraint_type TEXT NOT NULL CHECK(constraint_type IN (
    'work_hours_strict',
    'remote_only',
    'shift_work_no',
    'degree_impossible',
    'license_impossible'
  )),
  
  -- 대상 직업
  job_id TEXT NOT NULL,
  job_name TEXT,
  
  -- 응답
  answer TEXT NOT NULL CHECK(answer IN ('yes', 'no')),
  
  -- 메타
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  -- FK 제거: 논리적으로만 연결
);

CREATE INDEX IF NOT EXISTS idx_followup_request ON followup_responses(request_id);
CREATE INDEX IF NOT EXISTS idx_followup_constraint ON followup_responses(constraint_type);

-- ============================================
-- 5. 확정된 제약 (follow-up "no"에서 생성)
-- ============================================
CREATE TABLE IF NOT EXISTS confirmed_constraints (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT,
  session_id TEXT NOT NULL,
  
  -- constraint_type: 표준 5개만!
  constraint_type TEXT NOT NULL CHECK(constraint_type IN (
    'work_hours_strict',
    'remote_only',
    'shift_work_no',
    'degree_impossible',
    'license_impossible'
  )),
  
  -- 소스 정보
  source_followup_id INTEGER,
  
  -- 메타
  confirmed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- FK 제거: 논리적으로만 연결
  UNIQUE(session_id, constraint_type)  -- 세션당 제약 유형별 1개
);

CREATE INDEX IF NOT EXISTS idx_confirmed_session ON confirmed_constraints(session_id);
CREATE INDEX IF NOT EXISTS idx_confirmed_user ON confirmed_constraints(user_id);

