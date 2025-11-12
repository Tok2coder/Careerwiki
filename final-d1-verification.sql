-- D1 데이터 최종 검증
-- 1. 전공 데이터 통계
SELECT 
  '전공(majors)' as table_name,
  COUNT(*) as total_count,
  SUM(CASE WHEN careernet_id IS NOT NULL AND careernet_id != 'null' THEN 1 ELSE 0 END) as careernet_count,
  SUM(CASE WHEN goyong24_id IS NOT NULL AND goyong24_id != 'null' THEN 1 ELSE 0 END) as goyong24_count
FROM majors

UNION ALL

-- 2. 직업 데이터 통계
SELECT 
  '직업(jobs)' as table_name,
  COUNT(*) as total_count,
  SUM(CASE WHEN careernet_id IS NOT NULL AND careernet_id != 'null' THEN 1 ELSE 0 END) as careernet_count,
  SUM(CASE WHEN goyong24_id IS NOT NULL AND goyong24_id != 'null' THEN 1 ELSE 0 END) as goyong24_count
FROM jobs;

-- 3. 간호학과 레코드 확인
SELECT '=== 간호학과 레코드 ===' as separator;
SELECT id, name, careernet_id, goyong24_id FROM majors WHERE LOWER(name) LIKE '%간호%' ORDER BY name;


