-- Migration: 018_cache_versioning.sql
-- Description: P1-2 SearchProfile 캐시 버전화 (답변 변경 시 캐시 무효화)
-- Date: 2026-01-17

-- search_profile_cache 테이블에 answers_hash 컬럼 추가
ALTER TABLE search_profile_cache ADD COLUMN answers_hash TEXT;

-- 기존 UNIQUE 제약 제거 후 새로운 복합 인덱스 생성
-- SQLite에서 ALTER로 UNIQUE 제약 변경이 어려우므로 새 인덱스 추가
DROP INDEX IF EXISTS idx_search_profile_cache_session;
CREATE UNIQUE INDEX idx_search_profile_cache_versioned ON search_profile_cache(session_id, answers_hash);

-- llm_judge_cache에도 answers_hash 추가 (선택적)
ALTER TABLE llm_judge_cache ADD COLUMN answers_hash TEXT;
