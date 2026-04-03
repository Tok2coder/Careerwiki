-- 기존 나이팅게일 데이터 삭제
DELETE FROM career_tree_job_links WHERE career_tree_id IN (SELECT id FROM career_trees WHERE person_name = '나이팅게일');
DELETE FROM career_trees WHERE person_name = '나이팅게일';

-- 현대 인물 1: 김수경 (응급실 간호사 → 간호 교수)
INSERT INTO career_trees (person_name, person_name_en, person_title, stages_json, display_priority, is_active, created_at, updated_at)
VALUES (
  '김수경',
  'Kim Su-kyung',
  '응급간호 전문가 · 서울대 간호학과 교수',
  '[{"order":0,"title":"간호학과 졸업","organization":"서울대학교","years":"1990-1994","description":"간호학 학사 취득"},{"order":1,"title":"응급실 간호사","organization":"서울아산병원","years":"1994-2001","description":"응급의학과에서 중환자 간호 실무 7년","job_slug":"간호사"},{"order":2,"title":"간호학 석·박사","organization":"서울대학교 대학원","years":"2001-2007","description":"응급간호학 전공 석사·박사 학위 취득"},{"order":3,"title":"간호학과 교수","organization":"서울대학교","years":"2008-현재","description":"응급간호학 연구 및 후학 양성","job_slug":"대학교수"}]',
  10,
  1,
  1741500000000,
  1741500000000
);

INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index)
VALUES (
  (SELECT id FROM career_trees WHERE person_name = '김수경' LIMIT 1),
  '간호사',
  1
);

-- 현대 인물 2: 박진희 (간호사 → 보건정책 공무원)
INSERT INTO career_trees (person_name, person_name_en, person_title, stages_json, display_priority, is_active, created_at, updated_at)
VALUES (
  '박진희',
  'Park Jin-hee',
  '보건복지부 간호정책관',
  '[{"order":0,"title":"간호학과 졸업","organization":"연세대학교","years":"1995-1999","description":"간호학 학사 취득"},{"order":1,"title":"병동 간호사","organization":"세브란스병원","years":"1999-2005","description":"내과 병동 간호사로 6년 근무","job_slug":"간호사"},{"order":2,"title":"보건학 석사","organization":"서울대학교 보건대학원","years":"2005-2007","description":"보건정책 전공으로 공공보건 분야 전환 준비"},{"order":3,"title":"보건정책 사무관","organization":"보건복지부","years":"2008-2016","description":"간호인력 수급 정책 수립 담당","job_slug":"정부기관공무원"},{"order":4,"title":"간호정책관","organization":"보건복지부","years":"2017-현재","description":"국가 간호정책 총괄 책임자"}]',
  20,
  1,
  1741500000000,
  1741500000000
);

INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index)
VALUES (
  (SELECT id FROM career_trees WHERE person_name = '박진희' LIMIT 1),
  '간호사',
  1
);
