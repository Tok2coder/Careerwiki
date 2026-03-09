-- 테스트 커리어트리 데이터: 나이팅게일 (간호사 페이지)
INSERT INTO career_trees (person_name, person_name_en, person_title, stages_json, display_priority, is_active, created_at, updated_at)
VALUES (
  '나이팅게일',
  'Florence Nightingale',
  '근대 간호학의 창시자',
  '[{"order":0,"title":"수학·통계학 공부","organization":"가정교사 수업","years":"1840-1850","description":"수학과 통계학에 뛰어난 재능을 보이며 독학"},{"order":1,"title":"간호사","organization":"카이저스베르트 병원","years":"1850-1853","description":"독일에서 간호 수련 시작","job_slug":"간호사"},{"order":2,"title":"간호 감독관","organization":"영국군 야전병원","years":"1854-1856","description":"크림전쟁 중 야전병원 위생 개혁으로 사망률 대폭 감소"},{"order":3,"title":"간호학교 설립자","organization":"나이팅게일 간호학교","years":"1860-1910","description":"세계 최초 정규 간호 교육기관 설립"}]',
  10,
  1,
  1741500000000,
  1741500000000
);

-- 간호사 페이지와 연결 (stage_index = 1: 간호사 단계 하이라이트)
INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index)
VALUES (
  (SELECT id FROM career_trees WHERE person_name = '나이팅게일' LIMIT 1),
  '간호사',
  1
);
