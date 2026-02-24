-- 0034: narrative_facts 테이블에 existential_answer 컬럼 추가
-- "7일 뒤 지구 멸망" 실존적 질문 답변 저장용
-- 2026-02-11

-- 컬럼이 이미 존재하므로 ALTER TABLE 생략 (이전에 수동 적용됨)
-- ALTER TABLE narrative_facts ADD COLUMN existential_answer TEXT;
SELECT 1; -- no-op placeholder
