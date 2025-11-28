-- Migration: Fix multiple is_current = 1 revisions
-- Purpose: Ensure only one revision has is_current = 1 per entity
-- Date: 2025-11-19

-- Step 1: For each entity, keep only the latest revision (highest revision_number) as current
-- SQLite-compatible approach: Use subquery to find the latest revision per entity

-- Update: Set is_current = 0 for all revisions except the latest one per entity
UPDATE page_revisions
SET is_current = 0
WHERE is_current = 1
  AND id NOT IN (
    SELECT id
    FROM (
      SELECT pr1.id
      FROM page_revisions pr1
      WHERE pr1.is_current = 1
        AND pr1.revision_number = (
          SELECT MAX(pr2.revision_number)
          FROM page_revisions pr2
          WHERE pr2.entity_type = pr1.entity_type
            AND pr2.entity_id = pr1.entity_id
            AND pr2.is_current = 1
        )
        AND pr1.id = (
          SELECT MAX(pr3.id)
          FROM page_revisions pr3
          WHERE pr3.entity_type = pr1.entity_type
            AND pr3.entity_id = pr1.entity_id
            AND pr3.is_current = 1
            AND pr3.revision_number = pr1.revision_number
        )
    )
  );

-- Verify: Check if there are still multiple is_current = 1 per entity
-- This query should return 0 rows if the fix worked correctly
-- SELECT entity_type, entity_id, COUNT(*) as current_count
-- FROM page_revisions
-- WHERE is_current = 1
-- GROUP BY entity_type, entity_id
-- HAVING COUNT(*) > 1;

