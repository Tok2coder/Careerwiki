-- 0034: narrative_facts 테이블에 existential_answer 컬럼 추가
-- "7일 뒤 지구 멸망" 실존적 질문 답변 저장용
-- 2026-02-11

ALTER TABLE narrative_facts ADD COLUMN existential_answer TEXT;
