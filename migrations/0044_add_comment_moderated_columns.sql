-- comments 테이블에 moderated, original_content 컬럼 추가
-- createComment()와 updateComment()에서 욕설 필터 결과 저장에 사용
ALTER TABLE comments ADD COLUMN moderated INTEGER DEFAULT 0;
ALTER TABLE comments ADD COLUMN original_content TEXT;
