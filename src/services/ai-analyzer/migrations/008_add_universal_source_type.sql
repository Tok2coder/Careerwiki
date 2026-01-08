-- ============================================
-- 008: facts 테이블에 'universal' source_type 추가
-- [수정사항 2] CHECK 제약 사용 금지 - 테이블 재생성으로 CHECK 제거
-- ============================================

-- 1. 기존 데이터 백업
CREATE TABLE IF NOT EXISTS facts_backup_008 AS SELECT * FROM facts;

-- 2. 기존 테이블 삭제
DROP TABLE IF EXISTS facts;

-- 3. 새 테이블 생성 (CHECK 제약 제거 - 수정사항 2 준수)
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
  -- CHECK 제약 제거: 'followup', 'form', 'inferred', 'deep_intake', 'universal', 'stage_followup' 등 자유롭게 저장
  source_type TEXT DEFAULT 'followup',
  
  -- Phase 1A: fact level (L1=constraint, L2=dealbreaker, L3=discovery, L4=profile)
  -- CHECK 제약 제거
  fact_level INTEGER DEFAULT 3,
  
  -- 타임스탬프
  collected_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- Unique constraint
  UNIQUE(session_id, fact_key)
);

-- 4. 백업에서 데이터 복원
INSERT INTO facts (id, session_id, user_id, fact_key, value_json, confidence, question_id, source_type, fact_level, collected_at)
SELECT id, session_id, user_id, fact_key, value_json, confidence, question_id, source_type, fact_level, collected_at
FROM facts_backup_008;

-- 5. 인덱스 재생성
CREATE INDEX IF NOT EXISTS idx_facts_session ON facts(session_id);
CREATE INDEX IF NOT EXISTS idx_facts_user ON facts(user_id);
CREATE INDEX IF NOT EXISTS idx_facts_fact_key ON facts(fact_key);

-- 6. 백업 테이블 삭제 (선택적 - 안전을 위해 유지하는 경우 주석 처리)
DROP TABLE IF EXISTS facts_backup_008;







