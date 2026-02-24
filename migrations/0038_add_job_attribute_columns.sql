-- 0038: job_attributes에 누락된 속성 컬럼 추가
-- physical_demand, work_environment, employment_type, decision_authority, repetitive_level, job_type
-- 기존 tag-filter 규칙이 참조하지만 DB에 없던 6개 컬럼

ALTER TABLE job_attributes ADD COLUMN physical_demand TEXT DEFAULT 'medium';
ALTER TABLE job_attributes ADD COLUMN work_environment TEXT DEFAULT 'office';
ALTER TABLE job_attributes ADD COLUMN employment_type TEXT DEFAULT 'permanent';
ALTER TABLE job_attributes ADD COLUMN decision_authority INTEGER DEFAULT 50;
ALTER TABLE job_attributes ADD COLUMN repetitive_level INTEGER DEFAULT 50;
ALTER TABLE job_attributes ADD COLUMN job_type TEXT DEFAULT 'knowledge';
