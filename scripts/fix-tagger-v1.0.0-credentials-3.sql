-- tagger-v1.0.0 credentials 수정 스크립트 3차
-- 2026-01-06: 추가 발견된 문제 직종 수정

-- 1. 기사 (국가기술자격증)
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '냉동기사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '통신장비기사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '방송송출장비기사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '재활공학기사' AND tagger_version = 'tagger-v1.0.0';

-- 2. 관리사/상담사 (국가자격)
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '주택관리사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '직업상담사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor', license_required = 'required' WHERE job_name = '기록물관리사' AND tagger_version = 'tagger-v1.0.0';

-- 3. 기자/아나운서 (대졸 요구)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '신문기자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '방송기자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '잡지기자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '아나운서' AND tagger_version = 'tagger-v1.0.0';

-- 4. 컨설턴트/매니저 (대졸 요구)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '경영컨설턴트' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '금융자산운용가(펀드매니저)' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '정보통신컨설턴트 및 감리원' AND tagger_version = 'tagger-v1.0.0';

-- 5. 작가/창작 (대졸 선호)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '방송작가' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '영화시나리오작가' AND tagger_version = 'tagger-v1.0.0';

-- 6. 방송/영상 기사
UPDATE job_attributes SET degree_required = 'college' WHERE job_name = '촬영기사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'college' WHERE job_name = '조명기사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'college' WHERE job_name = '음향기사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'college' WHERE job_name = '영사기사' AND tagger_version = 'tagger-v1.0.0';

-- 7. 속기사 (자격증 선호)
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '속기사' AND tagger_version = 'tagger-v1.0.0';



