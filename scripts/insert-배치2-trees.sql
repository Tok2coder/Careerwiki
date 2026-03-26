-- 배치 2 careerTree 삽입: 웹디자이너(이노), 임상심리사(이수정), 대학교수(최재천)

-- ── 웹디자이너: 이노 (ID 61) ──
INSERT INTO career_trees (id, person_name, person_name_en, person_title, stages_json, display_priority) VALUES (
  61,
  '이노',
  'Lee No',
  'UI/UX 디자이너·스튜디오 대표',
  '[{"order":0,"title":"시각디자인학과 입학","organization":"홍익대학교 시각디자인학과","years":"1990년대","description":"시각디자인의 기초 이론과 타이포그래피·색채학·레이아웃을 체계적으로 학습하며 디자인 감각을 다졌다.","job_slug":null},{"order":1,"title":"주니어 웹디자이너 취업","organization":"국내 웹 에이전시","years":"2000년대 초반","description":"기업 웹사이트 및 배너 디자인을 담당하며 포토샵·드림위버 기반의 웹 디자인 실무를 익혔다.","job_slug":"웹디자이너"},{"order":2,"title":"시니어 UI 디자이너","organization":"IT 스타트업","years":"2000년대 중반","description":"모바일·웹 서비스 UI 시스템 설계를 주도하고, 피그마 도입 이후 디자인 시스템(Design System)을 구축해 개발팀과 협업 체계를 개선했다.","job_slug":null},{"order":3,"title":"UX 리드 디자이너","organization":"대형 IT 기업 인하우스","years":"2010년대","description":"사용자 리서치·인터뷰·A/B 테스트를 바탕으로 서비스 개선을 주도했다. 연간 수백만 명이 이용하는 서비스의 UX를 총괄했다.","job_slug":null},{"order":4,"title":"1인 UX 스튜디오 창업","organization":"독립 스튜디오","years":"2020년대","description":"10년 이상의 실무 경험을 바탕으로 프리랜서·스튜디오 형태로 독립, 스타트업·공공기관 웹·앱 UX 컨설팅을 진행하고 있다.","job_slug":null}]',
  100
);

INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES (61, '웹디자이너', 1);

-- ── 임상심리사: 이수정 (ID 62) ──
INSERT INTO career_trees (id, person_name, person_name_en, person_title, stages_json, display_priority) VALUES (
  62,
  '이수정',
  'Lee Soo-jung',
  '범죄심리학과 교수',
  '[{"order":0,"title":"심리학 학사·석사 수료","organization":"연세대학교 심리학과","years":"1982–1988","description":"연세대학교 심리학과에서 학사(1986)와 석사(1988)를 취득하며 사회심리학을 전공했다. 이 시기 임상·범죄 심리 분야에 관심을 갖기 시작했다.","job_slug":null},{"order":1,"title":"박사과정 및 수련","organization":"연세대학교 대학원 / 미국 아이오와대학교","years":"1988–1999","description":"연세대 대학원에서 박사학위를 취득(1999)했으며, 미국 아이오와 대학교 심리측정 박사과정을 수료하며 심리검사 방법론을 심화 학습했다.","job_slug":null},{"order":2,"title":"임상심리 연구 및 교정심리검사 개발","organization":"법무부 교정본부 / 경기대학교","years":"1990년대 후반–2000","description":"경기대학교 조교수로 임용 후 법무부 교정본부 교정심리검사 개발(2000)에 참여하며 임상심리 실무와 학문을 연결했다.","job_slug":"임상심리사"},{"order":3,"title":"범죄심리학과 교수","organization":"경기대학교 범죄심리학과 대학원","years":"2000년대–2020년대","description":"국내 최초 범죄심리학 전문 교과과정을 이끌며 프로파일러 양성에 기여했다. 대검찰청 자문교수, 대법원 전문심리위원 등을 역임했다.","job_slug":null},{"order":4,"title":"교환교수 및 국제 학술 활동","organization":"샘 휴스턴 주립대학교 형사사법학부 (미국)","years":"2002–2003","description":"미국 샘 휴스턴 주립대학교 교환교수로 파견, 미국심리학회(APA) 정회원으로 활동했다. 귀국 후 한국여성심리학회 회장을 역임하며 학계 리더십을 확장했다.","job_slug":null}]',
  100
);

INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES (62, '임상심리사', 2);

-- ── 대학교수: 최재천 (ID 63) ──
INSERT INTO career_trees (id, person_name, person_name_en, person_title, stages_json, display_priority) VALUES (
  63,
  '최재천',
  'Choi Jae-chun',
  '생명과학부 석좌교수',
  '[{"order":0,"title":"동물학 학사 졸업","organization":"서울대학교 자연과학대학 동물학과","years":"1973–1977","description":"서울대 동물학과에서 생물학 기초를 닦았다. 졸업 후 미국 유학을 결심하고 1979년 도미했다.","job_slug":null},{"order":1,"title":"생태학 석사·생물학 박사 취득","organization":"펜실베이니아 주립대학교 / 하버드 대학교","years":"1979–1990","description":"펜실베이니아 주립대에서 생태학 석사(1982)를 마친 뒤 하버드 대학교에서 에드워드 윌슨 지도 아래 생물학 박사(1990)를 취득했다. 개미와 사회생물학을 핵심 연구 주제로 삼았다.","job_slug":null},{"order":2,"title":"하버드 전임강사·미시간대 조교수","organization":"하버드 대학교 / 미시간 대학교","years":"1990–1994","description":"박사 취득 직후 하버드 전임강사(1990~1992)를 거쳐 미시간 대학교 조교수(1992~1994)로 임용됐다. 독립 연구자로서 역량을 키우고 국제 학술 네트워크를 구축했다.","job_slug":null},{"order":3,"title":"서울대 조교수·정교수 임용","organization":"서울대학교 생명과학부","years":"1994–2006","description":"1994년 서울대 생명과학부 조교수로 귀국했고, 1999년 정교수로 승진했다. 개미제국의 발견(1999) 등을 저술해 과학 대중화에 기여했다.","job_slug":"대학교수"},{"order":4,"title":"이화여대 석좌교수·국립생태원 초대 원장","organization":"이화여자대학교 / 국립생태원","years":"2007–현재","description":"2007년 이화여대 석좌교수로 자리를 옮겨 에코과학부를 창설했다. 국립생태원 초대 원장(2013~2017)을 역임하고, 생명다양성재단 대표로 활동하며 생태 보전과 과학 커뮤니케이션을 이끌고 있다.","job_slug":null}]',
  100
);

INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES (63, '대학교수', 3);
