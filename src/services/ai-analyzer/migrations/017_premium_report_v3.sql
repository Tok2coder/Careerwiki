-- Migration: 017_premium_report_v3.sql
-- Description: V3 LLM+RAG 기반 프리미엄 리포트 스키마 추가
-- Date: 2026-01-16

-- ai_analysis_results 테이블에 V3 필드 추가
ALTER TABLE ai_analysis_results ADD COLUMN premium_report_json TEXT;
ALTER TABLE ai_analysis_results ADD COLUMN engine_version TEXT DEFAULT 'v2';

-- 서술형 답변 저장 테이블
CREATE TABLE IF NOT EXISTS narrative_facts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL,
  user_id TEXT,
  high_alive_moment TEXT,
  lost_moment TEXT,
  created_at TEXT DEFAULT (datetime('now')),
  
  -- 인덱스
  UNIQUE(session_id)
);

-- 3라운드 심층 질문 답변 저장 테이블
CREATE TABLE IF NOT EXISTS round_answers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL,
  request_id INTEGER,
  round_number INTEGER NOT NULL CHECK (round_number IN (1, 2, 3)),
  question_id TEXT NOT NULL,
  question_text TEXT,
  purpose_tag TEXT CHECK (purpose_tag IN ('ENGINE', 'AVOIDANCE', 'INTEGRATION')),
  answer TEXT NOT NULL,
  answered_at TEXT DEFAULT (datetime('now')),
  
  -- 인덱스
  FOREIGN KEY (request_id) REFERENCES ai_analysis_requests(id)
);

CREATE INDEX IF NOT EXISTS idx_round_answers_session ON round_answers(session_id);
CREATE INDEX IF NOT EXISTS idx_round_answers_request ON round_answers(request_id);

-- LLM Judge 결과 캐시 테이블 (비용 절감용)
CREATE TABLE IF NOT EXISTS llm_judge_cache (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  request_id INTEGER NOT NULL,
  job_id TEXT NOT NULL,
  job_name TEXT,
  fit_score INTEGER,
  desire_score INTEGER,
  feasibility_score INTEGER,
  overall_score INTEGER,
  risk_penalty INTEGER DEFAULT 0,
  risk_flags_json TEXT,
  evidence_quotes_json TEXT,
  rationale TEXT,
  first_30_days_plan_json TEXT,
  created_at TEXT DEFAULT (datetime('now')),
  
  FOREIGN KEY (request_id) REFERENCES ai_analysis_requests(id),
  UNIQUE(request_id, job_id)
);

CREATE INDEX IF NOT EXISTS idx_llm_judge_cache_request ON llm_judge_cache(request_id);

-- SearchProfile 캐시 테이블
CREATE TABLE IF NOT EXISTS search_profile_cache (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL,
  profile_json TEXT NOT NULL,
  created_at TEXT DEFAULT (datetime('now')),
  
  UNIQUE(session_id)
);

-- V3 버전 마커 (기존 결과와 구분)
-- 기존 결과는 engine_version = 'v2'로 설정
UPDATE ai_analysis_results 
SET engine_version = 'v2' 
WHERE engine_version IS NULL;
