-- Migration: 010_add_aggregated_profile
-- ============================================
-- AggregatedProfile 누적 메모리 시스템 지원
-- ============================================
-- 핵심 원칙:
-- - aggregated_profile_json은 "Derived Cache"
-- - Source-of-truth는 step1/2/3/4_answers_json
-- - 언제든 buildAggregatedProfile()로 재생성 가능
-- ============================================

-- 컬럼이 이미 존재하므로 ALTER TABLE 생략 (이전에 수동 적용됨)
-- ALTER TABLE analyzer_drafts ADD COLUMN aggregated_profile_json TEXT;
-- ALTER TABLE analyzer_drafts ADD COLUMN memory_json TEXT;
-- ALTER TABLE analyzer_drafts ADD COLUMN profile_version INTEGER DEFAULT 0;
-- ALTER TABLE analyzer_drafts ADD COLUMN mini_module_result_json TEXT;

-- 인덱스만 idempotent하게 생성
CREATE INDEX IF NOT EXISTS idx_analyzer_drafts_profile_version ON analyzer_drafts(profile_version);
