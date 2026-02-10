-- Migration: 010_add_aggregated_profile
-- ============================================
-- AggregatedProfile 누적 메모리 시스템 지원
-- ============================================
-- 핵심 원칙:
-- - aggregated_profile_json은 "Derived Cache"
-- - Source-of-truth는 step1/2/3/4_answers_json
-- - 언제든 buildAggregatedProfile()로 재생성 가능
-- ============================================

-- 1. aggregated_profile_json 컬럼 추가 (Derived Cache)
ALTER TABLE analyzer_drafts ADD COLUMN aggregated_profile_json TEXT;

-- 2. memory_json 컬럼 추가 (Rolling Memory)
ALTER TABLE analyzer_drafts ADD COLUMN memory_json TEXT;

-- 3. profile_version 컬럼 추가 (캐시 버전 관리)
ALTER TABLE analyzer_drafts ADD COLUMN profile_version INTEGER DEFAULT 0;

-- 4. mini_module_result_json 컬럼 추가
ALTER TABLE analyzer_drafts ADD COLUMN mini_module_result_json TEXT;

-- 5. 인덱스 추가 (성능 최적화)
CREATE INDEX IF NOT EXISTS idx_analyzer_drafts_profile_version ON analyzer_drafts(profile_version);
