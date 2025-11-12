-- wiki_pages 캐시만 완전히 삭제 (데이터는 보존)
DELETE FROM wiki_pages;

-- 확인
SELECT '✅ 모든 캐시 삭제 완료' as message;
SELECT COUNT(*) as remaining_cache_count FROM wiki_pages;

