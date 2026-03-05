-- ============================================================================
-- Migration 0040: 수의사(일반) → 수의사 이름 매핑 추가
-- 두 직업을 하나로 합치기 위한 name_mapping 등록
-- ============================================================================

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active)
VALUES ('job', '수의사(일반)', '수의사', 1.0, 'manual_merge', 'admin', unixepoch() * 1000, 1);
