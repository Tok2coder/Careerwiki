-- 자격요건 보정 SQL
-- 옵션 C: 잘못 태깅된 degree_required, license_required 수동 보정

-- ===== 의사 직군 (의사 면허 필수, 의대 졸업 필수) =====
UPDATE job_attributes SET 
  degree_required = 'doctorate',
  license_required = 'required'
WHERE job_name LIKE '%의사%' AND degree_required = 'none';

-- ===== 약사 직군 (약사 면허 필수) =====
UPDATE job_attributes SET 
  degree_required = 'doctorate',
  license_required = 'required'
WHERE (job_name LIKE '%약사%' OR job_name LIKE '%한약사%') AND degree_required = 'none';

-- ===== 교수 직군 (박사 학위 필수) =====
UPDATE job_attributes SET 
  degree_required = 'doctorate',
  license_required = 'none'
WHERE job_name LIKE '%교수%' AND degree_required = 'none';

UPDATE job_attributes SET 
  degree_required = 'doctorate',
  license_required = 'none'
WHERE job_name LIKE '%시간강사%' AND degree_required = 'none';

-- ===== 교사 직군 (학사 + 교원자격증 필수) =====
UPDATE job_attributes SET 
  degree_required = 'bachelor',
  license_required = 'required'
WHERE job_name LIKE '%교사%' 
  AND job_name NOT LIKE '%보조교사%'
  AND degree_required = 'none';

-- 보조교사는 자격요건 낮음
UPDATE job_attributes SET 
  degree_required = 'college',
  license_required = 'preferred'
WHERE job_name LIKE '%보조교사%' AND degree_required = 'none';

-- ===== 연구원 직군 (석사 이상 필수) =====
UPDATE job_attributes SET 
  degree_required = 'master',
  license_required = 'none'
WHERE job_name LIKE '%연구원%' AND degree_required = 'none';

-- ===== 치료사 직군 (학사 + 면허 필수) =====
UPDATE job_attributes SET 
  degree_required = 'bachelor',
  license_required = 'required'
WHERE (job_name LIKE '%치료사%' OR job_name LIKE '%물리치료%' OR job_name LIKE '%작업치료%') 
  AND degree_required = 'none';

-- ===== 의료기사 직군 (전문대/학사 + 면허 필수) =====
UPDATE job_attributes SET 
  degree_required = 'college',
  license_required = 'required'
WHERE job_name LIKE '%방사선사%' AND degree_required = 'none';

UPDATE job_attributes SET 
  degree_required = 'college',
  license_required = 'required'
WHERE job_name LIKE '%임상병리사%' AND degree_required = 'none';

UPDATE job_attributes SET 
  degree_required = 'bachelor',
  license_required = 'required'
WHERE job_name LIKE '%임상심리사%' AND degree_required = 'none';

-- ===== 전문 자격사 직군 =====
UPDATE job_attributes SET 
  degree_required = 'bachelor',
  license_required = 'required'
WHERE job_name LIKE '%건축가%' AND degree_required = 'none';

UPDATE job_attributes SET 
  degree_required = 'none',
  license_required = 'required'
WHERE job_name LIKE '%도선사%' AND degree_required = 'none';

UPDATE job_attributes SET 
  degree_required = 'bachelor',
  license_required = 'required'
WHERE job_name LIKE '%법무사%' AND degree_required = 'none';

UPDATE job_attributes SET 
  degree_required = 'bachelor',
  license_required = 'required'
WHERE job_name LIKE '%사서%' AND degree_required = 'none';

UPDATE job_attributes SET 
  degree_required = 'college',
  license_required = 'required'
WHERE job_name LIKE '%위생사%' AND degree_required = 'none';

UPDATE job_attributes SET 
  degree_required = 'college',
  license_required = 'required'
WHERE job_name LIKE '%이용사%' AND degree_required = 'none';

UPDATE job_attributes SET 
  degree_required = 'college',
  license_required = 'required'
WHERE job_name LIKE '%속기사%' AND degree_required = 'none';

-- ===== 공학기술자 직군 (학사 이상 권장) =====
UPDATE job_attributes SET 
  degree_required = 'bachelor',
  license_required = 'preferred'
WHERE job_name LIKE '%기술자%' AND degree_required = 'none';

-- ===== 강사 직군 (학사 이상 권장) =====
UPDATE job_attributes SET 
  degree_required = 'bachelor',
  license_required = 'none'
WHERE job_name LIKE '%강사%' 
  AND job_name NOT LIKE '%시간강사%'
  AND degree_required = 'none';

-- ===== 의료정보 직군 =====
UPDATE job_attributes SET 
  degree_required = 'college',
  license_required = 'required'
WHERE job_name LIKE '%보건의료정보관리사%' AND degree_required = 'none';

-- ===== 호스피스 간호사 (CAREERNET에서 태깅된 것) =====
UPDATE job_attributes SET 
  degree_required = 'bachelor',
  license_required = 'required'
WHERE job_name LIKE '%호스피스%간호사%' AND degree_required = 'none';

-- ===== 장례지도사 (자격증 권장) =====
UPDATE job_attributes SET 
  degree_required = 'none',
  license_required = 'preferred'
WHERE job_name LIKE '%장례지도사%' AND degree_required = 'none';

-- ===== 부사관 (고졸 이상, 시험 필수) =====
UPDATE job_attributes SET 
  degree_required = 'none',
  license_required = 'required'
WHERE job_name LIKE '%부사관%' AND degree_required = 'none';




