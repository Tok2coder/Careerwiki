UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.sidebarCerts', '[{"name":"직업상담사(1급, 2급)","url":null}]') WHERE name = '취업알선원';

UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.sidebarCerts', '[{"name":"직업상담사(1급, 2급)","url":null}]') WHERE name = '인력파견관리자';

UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.sidebarCerts', '[{"name":"사회복지사(1급, 2급)","url":null},{"name":"정신건강사회복지사","url":null},{"name":"직업상담사(1급, 2급)","url":null}]') WHERE name = '사회복지사(일반)';

UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.sidebarCerts', '[{"name":"직업상담사(1급, 2급)","url":null},{"name":"장애인재활상담사","url":null}]') WHERE name = '장애인직업능력평가사';

UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.sidebarCerts', '[{"name":"직업상담사(1급, 2급)","url":null}]') WHERE name = '전직지원전문가';









