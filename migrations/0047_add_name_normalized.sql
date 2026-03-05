-- jobs 테이블에 name_normalized 컬럼 추가
ALTER TABLE jobs ADD COLUMN name_normalized TEXT;

-- majors 테이블에 name_normalized 컬럼 추가
ALTER TABLE majors ADD COLUMN name_normalized TEXT;

-- 기존 데이터 업데이트: name에서 특수문자 제거 + 소문자화
UPDATE jobs SET name_normalized = LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, '-', ''), ',', ''), '·', ''), 'ㆍ', ''), '/', ''), ' ', ''), '(', ''), ')', ''));
UPDATE majors SET name_normalized = LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, '-', ''), ',', ''), '·', ''), 'ㆍ', ''), '/', ''), ' ', ''), '(', ''), ')', ''));

-- 인덱스 추가
CREATE INDEX IF NOT EXISTS idx_jobs_name_normalized ON jobs(name_normalized);
CREATE INDEX IF NOT EXISTS idx_majors_name_normalized ON majors(name_normalized);
