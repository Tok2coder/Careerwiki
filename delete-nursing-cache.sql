-- 간호학과 캐시 삭제
DELETE FROM wiki_pages WHERE slug = '간호학과' AND page_type = 'major';

-- 결과 확인
SELECT 'Cache deleted for 간호학과' as message;

