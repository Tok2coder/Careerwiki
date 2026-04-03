-- 작가: 김영하 (ID 65), 공지영 (ID 66)

-- ── 김영하 (ID 65) ──
INSERT INTO career_trees (id, person_name, person_name_en, person_title, stages_json, display_priority) VALUES (
  65,
  '김영하',
  'Kim Young-ha',
  '소설가',
  '[{"order":0,"title":"연세대 경영학과 재학 중 글쓰기 시작","organization":"연세대학교 경영학과","years":"1987–1994","description":"연세대학교 경영학과 입학 후 동대학원까지 수료하면서 1990년부터 PC통신을 통해 글쓰기를 시작했다.","job_slug":null},{"order":1,"title":"계간 리뷰 단편 발표로 문단 등장","organization":"계간 리뷰 / 문학동네","years":"1995–1996","description":"1995년 단편 거울에 대한 명상을 계간 리뷰에 발표하며 작품활동을 시작했다. 이듬해 장편 나는 나를 파괴할 권리가 있다로 제1회 문학동네작가상을 수상하며 주목받았다.","job_slug":"작가"},{"order":2,"title":"장편·단편 연속 발표, 문단 입지 구축","organization":"문학동네 / 창비","years":"1996–2003","description":"나는 나를 파괴할 권리가 있다(1996), 아랑은 왜(1997) 등을 발표하며 젊은 소설가로 자리매김했다.","job_slug":null},{"order":3,"title":"국내 3대 문학상 동시 수상, 국제 번역 시작","organization":"한국예술종합학교 / 문학동네","years":"2004–2012","description":"2004년 검은 꽃으로 동인문학상, 단편집 오빠가 돌아왔다로 이산문학상, 보물선으로 황순원문학상을 동시 수상했다. 작품이 프랑스어·영어 등 다수 언어로 번역 출간되기 시작했다.","job_slug":null},{"order":4,"title":"전업작가·방송·강연으로 대중 작가 입지 완성","organization":"독립 / 방송 활동","years":"2013–현재","description":"한국예술종합학교 교수직을 사임하고 전업작가의 길을 선택했다. 살인자의 기억법(2013)이 영화화(2017)되며 대중적 인지도가 높아졌고, 가장 영향력 있는 한국 현대 소설가 중 한 명으로 자리했다.","job_slug":null}]',
  100
);

INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES (65, '작가', 1);

-- ── 공지영 (ID 66) ──
INSERT INTO career_trees (id, person_name, person_name_en, person_title, stages_json, display_priority) VALUES (
  66,
  '공지영',
  'Gong Ji-young',
  '소설가',
  '[{"order":0,"title":"연세대 영어영문학과 재학 및 사회운동 참여","organization":"연세대학교 영어영문학과","years":"1981–1987","description":"연세대학교 영어영문학과에 재학하며 1980년대 민주화 운동에 참여했다. 구치소에서의 경험이 첫 등단작의 직접적 소재가 됐다.","job_slug":null},{"order":1,"title":"창작과비평 단편 발표로 등단","organization":"계간 창작과비평","years":"1988","description":"1988년 단편 동트는 새벽을 계간 창작과비평에 발표하며 공식 등단했다.","job_slug":"작가"},{"order":2,"title":"장편소설 연속 발표","organization":"창비 / 문학동네","years":"1989–1993","description":"더 이상 아름다운 방황은 없다(1989), 무소의 뿔처럼 혼자서 가라(1993) 등을 발표하며 독자층을 형성했다.","job_slug":null},{"order":3,"title":"베스트셀러 작가 등극, 공지영 신드롬","organization":"창비 / 문학동네","years":"1994–2004","description":"1994년 고등어, 인간에 대한 예의, 무소의 뿔처럼 혼자서 가라 세 권이 동시에 베스트셀러 10위권에 오르며 공지영 신드롬이라는 용어가 생겨났다. 오영수문학상, 한국소설문학상 등을 수상했다.","job_slug":null},{"order":4,"title":"이상문학상 수상 및 사회파 소설 대표 작가","organization":"창비 / 문학동네","years":"2005–현재","description":"우리들의 행복한 시간(2005)이 영화화되어 400만 관객을 기록했고, 도가니(2009)는 영화화(2011) 후 실제 법 개정(도가니법)에 영향을 줬다. 2011년 이상문학상 대상을 수상했다.","job_slug":null}]',
  90
);

INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES (66, '작가', 1);
