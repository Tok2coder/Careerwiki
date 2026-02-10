-- Migration: 002_add_job_attributes_table
-- Phase 1B: job_attributes 테이블 추가 (7,000개 직업 태깅)
-- Created: 2026-01-03

-- ============================================
-- job_attributes 테이블: 직업별 태깅 결과 저장
-- ============================================
CREATE TABLE IF NOT EXISTS job_attributes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 직업 식별
  job_id TEXT NOT NULL UNIQUE,
  job_name TEXT,
  source_system TEXT,  -- 'CAREERNET', 'WORK24_JOB', 'MERGED'
  
  -- 태거 버전 (재생성용)
  tagger_version TEXT NOT NULL,
  
  -- ============================================
  -- 핵심 Attributes (0~100 스케일)
  -- ============================================
  
  -- Work-Life Balance 관련
  wlb INTEGER,                    -- 워라밸 점수 0~100
  work_hours TEXT,                -- 'regular', 'overtime_some', 'overtime_frequent'
  shift_work TEXT,                -- 'none', 'possible', 'required'
  travel TEXT,                    -- 'none', 'some', 'frequent'
  remote_possible TEXT,           -- 'none', 'partial', 'full'
  
  -- Career Growth 관련
  growth INTEGER,                 -- 성장 가능성 0~100
  stability INTEGER,              -- 안정성 0~100
  income INTEGER,                 -- 수입 수준 0~100
  
  -- Work Style 관련
  teamwork INTEGER,               -- 협업 비중 0~100
  solo_deep INTEGER,              -- 집중 업무 비중 0~100
  analytical INTEGER,             -- 분석적 업무 0~100
  creative INTEGER,               -- 창의적 업무 0~100
  execution INTEGER,              -- 실행/운영 업무 0~100
  people_facing INTEGER,          -- 대인 업무 0~100
  
  -- Requirements (Constraint 관련)
  degree_required TEXT,           -- 'none', 'college', 'bachelor', 'master', 'phd'
  license_required TEXT,          -- 'none', 'preferred', 'required', 'multiple_required'
  experience_required TEXT,       -- 'none', 'entry', 'junior', 'mid', 'senior'
  
  -- ============================================
  -- Confidence Scores (0~1)
  -- ============================================
  _confidence REAL NOT NULL,      -- 전체 신뢰도
  _field_confidence_json TEXT,    -- { "wlb": 0.9, "degree_required": 0.95, ... }
  
  -- ============================================
  -- Evidence (추적용)
  -- ============================================
  evidence_json TEXT,             -- { "wlb": [{source, snippet, weight}], ... }
  
  -- ============================================
  -- 메타데이터
  -- ============================================
  raw_source_json TEXT,           -- 원본 데이터 참조 (디버깅용)
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 인덱스
CREATE INDEX IF NOT EXISTS idx_job_attr_job_id ON job_attributes(job_id);
CREATE INDEX IF NOT EXISTS idx_job_attr_tagger ON job_attributes(tagger_version);
CREATE INDEX IF NOT EXISTS idx_job_attr_source ON job_attributes(source_system);
CREATE INDEX IF NOT EXISTS idx_job_attr_confidence ON job_attributes(_confidence);

-- 복합 인덱스 (필터링용)
CREATE INDEX IF NOT EXISTS idx_job_attr_wlb ON job_attributes(wlb);
CREATE INDEX IF NOT EXISTS idx_job_attr_remote ON job_attributes(remote_possible);
CREATE INDEX IF NOT EXISTS idx_job_attr_degree ON job_attributes(degree_required);
CREATE INDEX IF NOT EXISTS idx_job_attr_license ON job_attributes(license_required);

-- ============================================
-- tagger_runs 테이블: 배치 실행 기록
-- ============================================
CREATE TABLE IF NOT EXISTS tagger_runs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  run_id TEXT NOT NULL UNIQUE,
  tagger_version TEXT NOT NULL,
  
  -- 배치 정보
  batch_size INTEGER,
  total_jobs INTEGER,
  processed_jobs INTEGER DEFAULT 0,
  failed_jobs INTEGER DEFAULT 0,
  
  -- 상태
  status TEXT DEFAULT 'running' CHECK(status IN ('running', 'completed', 'failed', 'paused')),
  
  -- QA 결과
  qa_passed INTEGER DEFAULT 0,
  qa_failed INTEGER DEFAULT 0,
  avg_confidence REAL,
  
  -- 타임스탬프
  started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  completed_at DATETIME,
  
  -- 에러 로그
  error_log TEXT
);

CREATE INDEX IF NOT EXISTS idx_tagger_runs_status ON tagger_runs(status);
CREATE INDEX IF NOT EXISTS idx_tagger_runs_version ON tagger_runs(tagger_version);

-- ============================================
-- tagger_errors 테이블: 실패 job_id 기록 (재시도용)
-- ============================================
CREATE TABLE IF NOT EXISTS tagger_errors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  run_id TEXT NOT NULL,
  job_id TEXT NOT NULL,
  error_type TEXT,  -- 'parse_error', 'api_error', 'validation_error', 'timeout'
  error_message TEXT,
  retry_count INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(run_id, job_id)
);

CREATE INDEX IF NOT EXISTS idx_tagger_errors_run ON tagger_errors(run_id);
CREATE INDEX IF NOT EXISTS idx_tagger_errors_job ON tagger_errors(job_id);








