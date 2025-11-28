-- 사용자가 확인한 직업 이름 매핑 저장
-- 유사도가 높은 것들 (다른 소스 간)

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '자재·구매사무원', '자재구매사무원', 0.98, 'normalized', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '자동조립라인 및 산업용로봇조작원', '자동조립라인·산업용 로봇조작원', 0.93, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '상ㆍ하수도 처리장치 조작원', '상·하수도처리장치조작원', 0.92, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '크레인·호이스트운전원', '크레인 및 호이스트운전원', 0.91, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '가전제품 설치 및 수리원', '가전제품설치·수리원', 0.90, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '귀금속 및 보석세공원', '귀금속·보석세공원', 0.89, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '가구제조,수리원', '가구제조·수리원', 0.88, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '곡식작물재배자', '곡식작물재배원', 0.86, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '과수작물재배자', '과수작물재배원', 0.86, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '여행상품개발자', '여행상품개발원', 0.86, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '재활용 처리 및 소각로 조작원', '재활용 처리장치·소각로조작원', 0.85, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '주차장관리원', '주차관리원', 0.83, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '출판물편집자', '출판편집자', 0.83, 'levenshtein', strftime('%s','now') * 1000, 1);

INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) 
VALUES ('job', '종이제품생산직(기계조작)', '종이제품생산기계조작원', 0.82, 'levenshtein', strftime('%s','now') * 1000, 1);

