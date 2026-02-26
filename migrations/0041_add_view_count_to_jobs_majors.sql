-- jobs, majors 테이블에 view_count 컬럼 추가
ALTER TABLE jobs ADD COLUMN view_count INTEGER DEFAULT 0;
ALTER TABLE majors ADD COLUMN view_count INTEGER DEFAULT 0;
