-- 005_add_deep_intake_event_type.sql
-- Phase 1C: Deep Intake 이벤트 타입 추가
-- SQLite에서 CHECK 제약을 수정하려면 테이블을 재생성해야 함

-- 1. 기존 테이블 백업
CREATE TABLE IF NOT EXISTS raw_events_backup AS SELECT * FROM raw_events;

-- 2. 기존 테이블 삭제
DROP TABLE IF EXISTS raw_events;

-- 3. 새 테이블 생성 (DEEP_INTAKE_SUBMITTED 추가)
CREATE TABLE IF NOT EXISTS raw_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT,
  session_id TEXT NOT NULL,
  event_type TEXT NOT NULL CHECK(event_type IN (
    'FORM_SUBMITTED',
    'FOLLOWUP_ANSWERED',
    'ANALYSIS_REQUESTED',
    'ANALYSIS_COMPLETED',
    'FACT_CONFIRMED',
    'RISK_ACCEPTED',
    'DEEP_INTAKE_SUBMITTED'  -- Phase 1C 추가
  )),
  payload_json TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  client_meta TEXT
);

-- 4. 백업에서 데이터 복원
INSERT INTO raw_events (id, user_id, session_id, event_type, payload_json, created_at, client_meta)
SELECT id, user_id, session_id, event_type, payload_json, created_at, client_meta
FROM raw_events_backup;

-- 5. 인덱스 재생성
CREATE INDEX IF NOT EXISTS idx_raw_events_session ON raw_events(session_id);
CREATE INDEX IF NOT EXISTS idx_raw_events_user ON raw_events(user_id);
CREATE INDEX IF NOT EXISTS idx_raw_events_type ON raw_events(event_type);

-- 6. 백업 테이블 삭제 (선택사항 - 안전을 위해 유지 가능)
-- DROP TABLE IF EXISTS raw_events_backup;








