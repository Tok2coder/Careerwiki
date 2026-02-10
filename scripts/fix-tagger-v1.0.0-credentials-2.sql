-- tagger-v1.0.0 credentials 수정 스크립트 2차
-- 2026-01-06: 추가 발견된 문제 직종 수정

-- 1. 치과/의료 보조 (국가자격증 필수, 전문대졸)
UPDATE job_attributes SET degree_required = 'college', license_required = 'required' WHERE job_name = '치과위생사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'college', license_required = 'required' WHERE job_name = '치과기공사' AND tagger_version = 'tagger-v1.0.0';

-- 2. 용접원 (자격증 선호)
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '용접원(용접기조작원)' AND tagger_version = 'tagger-v1.0.0';

-- 3. 연구원 (석사 이상 학력 요구)
UPDATE job_attributes SET degree_required = 'master' WHERE job_name = '사회학연구원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'master' WHERE job_name = '생물공학연구원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'master' WHERE job_name = '생물학연구원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'master' WHERE job_name = '정치학연구원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'master' WHERE job_name = '지리학연구원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'master' WHERE job_name = '행정학연구원' AND tagger_version = 'tagger-v1.0.0';

-- 4. 기술자/연구원 (학사 이상)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '기계공학 기술자ㆍ연구원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '컴퓨터하드웨어 기술자 및 연구원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '통신공학 기술자 및 연구원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '환경공학기술자 및 연구원' AND tagger_version = 'tagger-v1.0.0';

-- 5. 개발자/연구 (학사 이상)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '디스플레이연구 및 개발자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '태양광발전연구 및 개발자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '풍력발전연구 및 개발자' AND tagger_version = 'tagger-v1.0.0';

-- 6. 분석가 (학사 이상)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '증권분석가' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '투자분석가(애널리스트)' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '투자분석가' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '신용분석가' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '컴퓨터시스템설계 및 분석가' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '데이터분석가(빅데이터분석가)' AND tagger_version = 'tagger-v1.0.0';

-- 7. 전기 관련 (자격증 선호)
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '전기설비조작원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '전기·전자설비조작원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '전기·전자공학시험원' AND tagger_version = 'tagger-v1.0.0';




