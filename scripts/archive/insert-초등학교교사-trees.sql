INSERT INTO career_trees (person_name, person_name_en, person_title, stages_json, display_priority, created_at, updated_at)
VALUES (
  '나태주',
  'Na Tae-ju',
  '시인·전 초등학교 교장',
  '[{"order":0,"title":"공주사범학교 졸업 및 교직 입문","organization":"공주사범학교","years":"1964","description":"공주사범학교를 졸업하고 교직에 입문했다. 이후 충청남도 여러 초등학교에서 교사 생활을 시작했다.","job_slug":null},{"order":1,"title":"초등학교 교사·교감 재직","organization":"충청남도 각 초등학교","years":"1964–1997","description":"경기도 군남국민학교를 시작으로 충청남도 여러 초등학교에서 33년간 교사 및 교감으로 근무했다. 재직 중인 1971년 서울신문 신춘문예로 시인으로 등단했다.","job_slug":"초등학교교사"},{"order":2,"title":"초등학교 교장 재직","organization":"공주시 왕흥초·상서초·장기초등학교","years":"1997–2007","description":"공주 지역 초등학교 교장으로 재직하다 2007년 정년퇴임했다. 황조근정훈장을 수훈했다.","job_slug":null},{"order":3,"title":"전업 시인·공주풀꽃문학관 관장","organization":"공주풀꽃문학관","years":"2007–현재","description":"퇴임 후 대표작 「풀꽃」으로 전국적 명성을 얻으며 시인 활동에 전념했다. 공주풀꽃문학관을 운영하고 있다.","job_slug":null},{"order":4,"title":"시집 출간·강연 활동","organization":"독립","years":"2010–현재","description":"「풀꽃」·「꽃을 보듯 너를 본다」 등 누적 수백만 부 판매, 전국 순회 강연과 방송 출연으로 대중 시인으로 자리매김했다.","job_slug":null}]',
  100,
  datetime('now'),
  datetime('now')
);

INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index)
VALUES (
  (SELECT id FROM career_trees WHERE person_name='나태주' ORDER BY id DESC LIMIT 1),
  '초등학교교사',
  1
);
