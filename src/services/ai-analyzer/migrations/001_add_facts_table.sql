-- Migration: 001_add_facts_table
-- Phase 1A: facts 테이블 추가 (자기발견 엔진 MVE)
-- Created: 2026-01-02

-- ============================================
-- facts 테이블: follow-up에서 추출/정규화된 fact 저장
-- ============================================
CREATE TABLE IF NOT EXISTS facts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 세션/유저 연결
  session_id TEXT NOT NULL,
  user_id TEXT,
  
  -- fact 식별
  fact_key TEXT NOT NULL,  -- 'motivation.work_hours_reason', 'tradeoff.salary_vs_wlb' 등
  
  -- 값 (JSON으로 유연하게)
  value_json TEXT NOT NULL,  -- { "value": "wlb", "tags": ["work_life_balance"], "reason": "가족" }
  
  -- 메타
  confidence REAL DEFAULT 1.0,  -- 0~1, 추출 신뢰도
  question_id TEXT,             -- 어떤 질문에서 나왔는지
  source_type TEXT DEFAULT 'followup' CHECK(source_type IN ('followup', 'form', 'inferred')),
  
  -- 타임스탬프
  collected_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- 레벨 구분 (L1~L4)
  fact_level INTEGER DEFAULT 3 CHECK(fact_level BETWEEN 1 AND 4),
  -- L1: confirmed_constraint (명시적 제약)
  -- L2: priority.dealbreaker (강한 선호)
  -- L3: motivation, tradeoff (일반 선호)
  -- L4: discovery, insight (발견된 인사이트)
  
  -- 유니크 제약: 같은 세션에서 같은 fact_key는 최신 값으로 덮어씀
  UNIQUE(session_id, fact_key)
);

-- 인덱스
CREATE INDEX IF NOT EXISTS idx_facts_session ON facts(session_id);
CREATE INDEX IF NOT EXISTS idx_facts_user ON facts(user_id);
CREATE INDEX IF NOT EXISTS idx_facts_key ON facts(fact_key);
CREATE INDEX IF NOT EXISTS idx_facts_level ON facts(fact_level);

-- ============================================
-- question_history 테이블: 어떤 질문을 언제 했는지 기록
-- ============================================
CREATE TABLE IF NOT EXISTS question_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL,
  request_id INTEGER,  -- 어떤 분석 요청에서 생성된 질문인지
  question_id TEXT NOT NULL,
  question_type TEXT NOT NULL,  -- 'clarification', 'tradeoff', 'priority', 'discovery'
  attribute TEXT,  -- 어떤 attribute에 대한 질문인지
  asked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  answered_at DATETIME,
  answer_value TEXT,
  
  UNIQUE(session_id, question_id)
);

CREATE INDEX IF NOT EXISTS idx_qh_session ON question_history(session_id);
CREATE INDEX IF NOT EXISTS idx_qh_request ON question_history(request_id);







