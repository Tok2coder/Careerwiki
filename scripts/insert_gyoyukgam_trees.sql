
DELETE FROM career_trees WHERE id IN (273, 274);

INSERT INTO career_trees (person_name, person_name_en, person_title, stages_json, display_priority, is_active, created_at, updated_at)
VALUES ('이재정', 'Lee Jae-jeong', '경기도교육감 (2014-2022)', '[{"order":0,"title":"교사","organization":"경기 상문고등학교","years":"1970년대","description":"고등학교 교사로 교직 생활 시작"},{"order":1,"title":"국회의원 (14·15·16대)","organization":"대한민국 국회","years":"1992–2004","description":"국회의원 3선, 교육·통일 분야 활동"},{"order":2,"title":"통일부 장관","organization":"통일부","years":"2006–2008","description":"노무현 정부 통일부 장관 역임"},{"order":3,"title":"경기도교육감","organization":"경기도교육청","years":"2014–2022","description":"경기도교육감 2선, 혁신학교 확산 및 고교무상교육 선도","job_slug":"교육감"},{"order":4,"title":"강연·집필·시민사회 활동","organization":"(퇴임 후)","years":"2022–","description":"퇴임 후 교육 관련 강연 및 집필 활동 전개"}]', 50, 1, unixepoch()*1000, unixepoch()*1000);

INSERT INTO career_trees (person_name, person_name_en, person_title, stages_json, display_priority, is_active, created_at, updated_at)
VALUES ('김승환', 'Kim Seung-hwan', '전라북도교육감 (2010-2022)', '[{"order":0,"title":"교원","organization":"전라북도 중·고등학교","years":"1970–1990년대","description":"교사로 교직 경력 쌓음"},{"order":1,"title":"전북대학교 법학 교수","organization":"전북대학교","years":"1990년대–2010","description":"전북대 법과대학 교수로 재직, 헌법·교육법 연구"},{"order":2,"title":"전라북도교육감","organization":"전라북도교육청","years":"2010–2022","description":"전라북도교육감 3선, 진보교육 정책 추진","job_slug":"교육감"},{"order":3,"title":"강연·교육운동 활동","organization":"(퇴임 후)","years":"2022–","description":"퇴임 후 교육 강연 및 지역 시민교육 활동"}]', 51, 1, unixepoch()*1000, unixepoch()*1000);
