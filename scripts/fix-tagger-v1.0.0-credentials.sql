-- tagger-v1.0.0 credentials 수정 스크립트
-- 2026-01-06: 중간점검 결과 발견된 문제 직종 수정

-- 1. 조종사 (면허 필수, 학사 이상)
UPDATE job_attributes SET degree_required = 'bachelor', license_required = 'required' WHERE job_name = '항공기조종사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor', license_required = 'required' WHERE job_name = '헬리콥터조종사' AND tagger_version = 'tagger-v1.0.0';

-- 2. 운전원 (면허 필수)
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '건설기계운전원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '대형트럭 및 특수차운전원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '크레인 및 호이스트운전원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '버스운전원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '택시운전원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '화물차·특수차운전원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '크레인·호이스트운전원' AND tagger_version = 'tagger-v1.0.0';

-- 3. 기관사 (면허 필수)
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '철도 및 지하철기관사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'required' WHERE job_name = '철도·전동차기관사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'college', license_required = 'required' WHERE job_name = '선박기관사' AND tagger_version = 'tagger-v1.0.0';

-- 4. 조리사 (자격증 선호)
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '일식조리사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '한식조리사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '중식조리사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '양식조리사' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '음료조리사' AND tagger_version = 'tagger-v1.0.0';

-- 5. 은행직원 (대졸 선호)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '은행출납사무원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '은행사무원' AND tagger_version = 'tagger-v1.0.0';

-- 6. 회계사무원 (전문대졸 선호)
UPDATE job_attributes SET degree_required = 'college' WHERE job_name = '회계사무원' AND tagger_version = 'tagger-v1.0.0';




