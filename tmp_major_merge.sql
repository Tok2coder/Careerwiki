-- Migration: Merge duplicate major name (bracket variant)
-- 메카트로닉스(기전)공학과 → 메카트로닉스공학과
-- Date: 2026-03-09

-- 1. name_mappings에 매핑 등록
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active)
VALUES ('major', '메카트로닉스(기전)공학과', '메카트로닉스공학과', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);

-- 2. major_sources 이관 (소스 전공 → 타겟 전공)
UPDATE major_sources
SET major_id = (SELECT id FROM majors WHERE name = '메카트로닉스공학과' LIMIT 1)
WHERE major_id = (SELECT id FROM majors WHERE name = '메카트로닉스(기전)공학과' LIMIT 1)
  AND major_id IS NOT NULL;

-- 3. 소스 전공 비활성화
UPDATE majors SET is_active = 0 WHERE name = '메카트로닉스(기전)공학과';

-- 4. 캐시 무효화 (pages 테이블)
UPDATE pages SET updated_at = CURRENT_TIMESTAMP WHERE slug LIKE '%메카트로닉스%';
