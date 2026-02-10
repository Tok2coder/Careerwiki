-- tagger-v1.0.0 credentials 수정 스크립트 4차
-- 2026-01-06: 공학기술자 및 전문직 수정

-- 1. 공학기술자 (대졸 요구)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '금속공학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '메카트로닉스공학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '반도체공학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '석유화학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '섬유공학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '전자공학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '조선공학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '통신망설계운영기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '항공우주공학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '해양공학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '화학공학기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '상수도기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '해양수산기술자' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '특수효과기술자' AND tagger_version = 'tagger-v1.0.0';

-- 2. 학예사/큐레이터 (대졸+자격증)
UPDATE job_attributes SET degree_required = 'bachelor', license_required = 'required' WHERE job_name = '학예사(큐레이터)' AND tagger_version = 'tagger-v1.0.0';

-- 3. 청능사 (자격증 필수)
UPDATE job_attributes SET degree_required = 'bachelor', license_required = 'required' WHERE job_name = '청능사' AND tagger_version = 'tagger-v1.0.0';

-- 4. 제과/제빵사 (자격증 선호)
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '제과사 및 제빵사' AND tagger_version = 'tagger-v1.0.0';

-- 5. 사회복지관리자 (대졸+자격증)
UPDATE job_attributes SET degree_required = 'bachelor', license_required = 'required' WHERE job_name = '사회복지관리자' AND tagger_version = 'tagger-v1.0.0';

-- 6. 국제무역사무원 (대졸)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '국제무역사무원' AND tagger_version = 'tagger-v1.0.0';

-- 7. 법률사무원 (대졸)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '법률사무원' AND tagger_version = 'tagger-v1.0.0';

-- 8. 검사원 (자격증 선호)
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '건설공사품질관리원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '환경위생검사원' AND tagger_version = 'tagger-v1.0.0';
UPDATE job_attributes SET license_required = 'preferred' WHERE job_name = '보건위생·환경검사원' AND tagger_version = 'tagger-v1.0.0';

-- 9. 제도사 (전문대졸)
UPDATE job_attributes SET degree_required = 'college' WHERE job_name = '제도사(캐드원)' AND tagger_version = 'tagger-v1.0.0';

-- 10. 사이버교육운영자 (대졸)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '사이버교육운영자' AND tagger_version = 'tagger-v1.0.0';

-- 11. 행사기획자 (대졸)
UPDATE job_attributes SET degree_required = 'bachelor' WHERE job_name = '행사기획자' AND tagger_version = 'tagger-v1.0.0';




