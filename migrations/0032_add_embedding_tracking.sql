-- Migration: Add embedding tracking columns to jobs table
-- Version: 0032
-- Date: 2026-01-27
-- Purpose: Freeze v1.1 - 증분 업서트 지원을 위한 인덱싱 추적 컬럼 추가

-- indexed_at: Vectorize에 마지막으로 인덱싱된 시간
-- embedding_version: 사용된 인덱싱 텍스트 버전 (JOB_PROFILE_COMPACT_V1 등)

-- 컬럼이 이미 존재하므로 ALTER TABLE 생략 (이전에 수동 적용됨)
-- ALTER TABLE jobs ADD COLUMN indexed_at DATETIME DEFAULT NULL;
-- ALTER TABLE jobs ADD COLUMN embedding_version TEXT DEFAULT NULL;

-- 인덱스만 idempotent하게 생성
CREATE INDEX IF NOT EXISTS idx_jobs_indexed_at ON jobs(indexed_at);
CREATE INDEX IF NOT EXISTS idx_jobs_embedding_version ON jobs(embedding_version);
CREATE INDEX IF NOT EXISTS idx_jobs_needs_indexing
ON jobs(is_active, indexed_at, embedding_version);
