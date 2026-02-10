-- 006_add_deep_intake_source_type.sql
-- Phase 1C: facts 테이블에 deep_intake source_type 추가
-- SQLite에서 CHECK 제약을 수정하려면 테이블을 재생성해야 함

-- 1. 기존 테이블 백업
CREATE TABLE IF NOT EXISTS facts_backup AS SELECT * FROM facts;

-- 2. 기존 테이블 삭제
DROP TABLE IF EXISTS facts;

-- 3. 새 테이블 생성 (deep_intake source_type 추가)
CREATE TABLE IF NOT EXISTS facts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 세션/유저 연결
  session_id TEXT NOT NULL,
  user_id TEXT,
  
  -- fact 식별
  fact_key TEXT NOT NULL,
  
  -- 값 (JSON으로 유연하게)
  value_json TEXT NOT NULL,
  
  -- 메타
  confidence REAL DEFAULT 1.0,
  question_id TEXT,
  source_type TEXT DEFAULT 'followup' CHECK(source_type IN (
    'followup', 
    'form', 
    'inferred',
    'deep_intake'  -- Phase 1C 추가
  )),
  
  -- Phase 1A: fact level (L1=constraint, L2=dealbreaker, L3=discovery, L4=profile)
  fact_level INTEGER DEFAULT 3,
  
  -- 타임스탬프
  collected_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- 세션+fact_key 유니크 (동일 세션에서 같은 fact는 업데이트)
  UNIQUE(session_id, fact_key)
);

-- 4. 백업에서 데이터 복원
INSERT OR IGNORE INTO facts (id, session_id, user_id, fact_key, value_json, confidence, question_id, source_type, fact_level, collected_at)
SELECT id, session_id, user_id, fact_key, value_json, confidence, question_id, source_type, fact_level, collected_at
FROM facts_backup;

-- 5. 인덱스 재생성
CREATE INDEX IF NOT EXISTS idx_facts_session_id ON facts(session_id);
CREATE INDEX IF NOT EXISTS idx_facts_fact_key ON facts(fact_key);
CREATE INDEX IF NOT EXISTS idx_facts_level ON facts(fact_level);

-- 6. 백업 테이블 유지 (안전을 위해)
-- DROP TABLE IF EXISTS facts_backup;








