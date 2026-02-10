-- src/services/ai-analyzer/migrations/010_career_tree_tables.sql
-- ============================================
-- 커리어트리 핵심 테이블 생성
-- ============================================

-- ============================================
-- 1. 분석 초안 (임시저장)
-- ============================================
CREATE TABLE IF NOT EXISTS analyzer_drafts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,           -- 로그인 필수이므로 NOT NULL
  session_id TEXT NOT NULL,
  analysis_type TEXT CHECK(analysis_type IN ('job', 'major')) NOT NULL,
  current_step INTEGER DEFAULT 0,     -- 0~5
  
  -- 상태 좌표
  career_state_json TEXT,             -- CareerState JSON
  
  -- 각 단계별 답변
  step1_answers_json TEXT,            -- 상태 좌표 답변
  step2_answers_json TEXT,            -- 기본 질문 답변 (Universal)
  step3_answers_json TEXT,            -- 전이 신호 답변
  step4_answers_json TEXT,            -- LLM 팔로업 답변
  
  -- 메타데이터
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP  -- P0-7: 코드에서 명시적 갱신 필요
);

CREATE INDEX IF NOT EXISTS idx_analyzer_drafts_user ON analyzer_drafts(user_id);
CREATE INDEX IF NOT EXISTS idx_analyzer_drafts_session ON analyzer_drafts(session_id);

-- ============================================
-- 2. 이력서 첨부 (P1에서 본격 사용, P0는 텍스트만)
-- ============================================
CREATE TABLE IF NOT EXISTS user_resumes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  session_id TEXT NOT NULL,
  
  -- 파일 정보 (P1에서 R2 키 사용)
  file_key TEXT,                      -- R2 키 (P1)
  file_name TEXT,
  file_size INTEGER,
  file_type TEXT DEFAULT 'application/pdf',
  
  -- 파싱 결과
  parsed_status TEXT CHECK(parsed_status IN ('pending', 'processing', 'completed', 'failed')) DEFAULT 'pending',
  parsed_data_json TEXT,              -- LLM 파싱 결과 JSON (마스킹 후)
  parsing_error TEXT,
  
  -- 원본 텍스트 (P0: 클라이언트에서 추출한 텍스트 저장용)
  extracted_text TEXT,
  
  -- 메타데이터
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  parsed_at DATETIME
);

CREATE INDEX IF NOT EXISTS idx_user_resumes_user ON user_resumes(user_id);
CREATE INDEX IF NOT EXISTS idx_user_resumes_session ON user_resumes(session_id);

-- ============================================
-- 3. 정형 Fact 저장 (커리어트리 통계용)
-- ============================================
-- P0-2: fact_key는 단수형만 (배열 분해 저장)
-- P0-4: CHECK 제약으로 draft_id OR request_id 필수 강제
-- P0-5: value_text, rank_int 추가 (JSON 추출 대신 인덱스 완전 적용)

CREATE TABLE IF NOT EXISTS analyzer_facts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 연결 키
  user_id INTEGER,                    -- NULL이면 익명 통계용
  session_id TEXT NOT NULL,
  draft_id INTEGER,                   -- Step 진행 중 저장
  request_id INTEGER,                 -- 결과 확정 후 저장
  
  -- Fact 데이터 (원본)
  fact_key TEXT NOT NULL,             -- 단수형만! 예: 'transition.desired_type'
  value_json TEXT NOT NULL,           -- 원본 JSON (디버깅/백업용)
  
  -- P0-5: 통계용 컬럼 (인덱스 완전 적용!)
  value_text TEXT,                    -- 실제 값 (transition type 등)
  rank_int INTEGER,                   -- 우선순위 (1, 2, 3 / NULL이면 순위 없음)
  
  -- 메타데이터
  source TEXT CHECK(source IN ('user_input', 'resume_parsed', 'inferred', 'followup')) DEFAULT 'user_input',
  confidence_weight REAL DEFAULT 1.0, -- P0.5: 신뢰도 가중치 (resume_parsed=1.3 등)
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- P0-4: 최소 하나 필수 강제
  CHECK (draft_id IS NOT NULL OR request_id IS NOT NULL)
);

-- 통계 쿼리 최적화를 위한 인덱스
CREATE INDEX IF NOT EXISTS idx_analyzer_facts_key ON analyzer_facts(fact_key);
CREATE INDEX IF NOT EXISTS idx_analyzer_facts_session ON analyzer_facts(session_id);
CREATE INDEX IF NOT EXISTS idx_analyzer_facts_user ON analyzer_facts(user_id);
CREATE INDEX IF NOT EXISTS idx_analyzer_facts_draft ON analyzer_facts(draft_id);
CREATE INDEX IF NOT EXISTS idx_analyzer_facts_request ON analyzer_facts(request_id);

-- P0-5: 핵심 인덱스 - 1순위 Top N 집계가 초고속으로 동작
CREATE INDEX IF NOT EXISTS idx_facts_key_rank ON analyzer_facts(fact_key, rank_int, value_text);
CREATE INDEX IF NOT EXISTS idx_facts_key_value ON analyzer_facts(fact_key, value_text);
