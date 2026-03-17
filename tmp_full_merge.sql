-- ============================================================
-- Migration: Merge 38 duplicate jobs (일반 variants + bracket variants)
-- Date: 2026-03-09
-- ============================================================

-- Step 1: name_mappings 등록 (38건)
-- (일반) 변형 26건
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '금속공학기술자(일반)', '금속공학기술자', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '기술영업원(일반)', '기술영업원', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '무역사무원(일반)', '무역사무원', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '미장공(일반)', '미장공', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '방수공(일반)', '방수공', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '번역가(일반)', '번역가', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '사무보조원(일반)', '사무보조원', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '사진사(일반)', '사진사', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '사회복지사(일반)', '사회복지사', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '수의사(일반)', '수의사', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '여행안내원(일반)', '여행안내원', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '용접원(일반)', '용접원', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '재단사(일반)', '재단사', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '재봉사(일반)', '재봉사', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '정부행정관리자(일반)', '정부행정관리자', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '제품디자이너(일반)', '제품디자이너', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '조적공(일반)', '조적공', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '직업운동선수(일반)', '직업운동선수', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '청소원(일반)', '청소원', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '청원경찰(일반)', '청원경찰', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '측량사(일반)', '측량사', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '캐드원(일반)', '캐드원', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '통역가(일반)', '통역가', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '품질관리사무원(일반)', '품질관리사무원', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '한약사(일반)', '한약사', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '환경시험원(일반)', '환경시험원', 1, 'general_variant', 'admin-claude', unixepoch() * 1000, 1);

-- 괄호 변형 12건
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '단조원(단조기조작원)', '단조원', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '도장원(도장기조작원)', '도장원', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '비디오저널리스트(VJ)', '비디오저널리스트', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '세탁원(다림질원)', '세탁원', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '용접원(용접기조작원)', '용접원', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '인쇄기조작원(무늬롤)', '인쇄기조작원', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '제관원(제관기조작원)', '제관원', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '주조원(주조기조작원)', '주조원', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '철골공(강구조물건립원)', '철골공', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '투자분석가(애널리스트)', '투자분석가', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '판금원(판금기조작원)', '판금원', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);
INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '학예사(큐레이터)', '학예사', 0.95, 'bracket_variant', 'admin-claude', unixepoch() * 1000, 1);

-- Step 2: job_sources 이관 (source job → target job)
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '금속공학기술자' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '금속공학기술자(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '기술영업원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '기술영업원(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '무역사무원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '무역사무원(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '미장공' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '미장공(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '방수공' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '방수공(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '번역가' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '번역가(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '사무보조원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '사무보조원(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '사진사' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '사진사(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '사회복지사' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '사회복지사(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '수의사' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '수의사(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '여행안내원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '여행안내원(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '용접원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '용접원(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '재단사' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '재단사(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '재봉사' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '재봉사(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '정부행정관리자' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '정부행정관리자(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '제품디자이너' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '제품디자이너(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '조적공' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '조적공(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '직업운동선수' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '직업운동선수(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '청소원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '청소원(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '청원경찰' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '청원경찰(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '측량사' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '측량사(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '캐드원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '캐드원(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '통역가' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '통역가(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '품질관리사무원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '품질관리사무원(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '한약사' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '한약사(일반)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '환경시험원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '환경시험원(일반)' AND is_active = 1 LIMIT 1);
-- 괄호 변형
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '단조원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '단조원(단조기조작원)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '도장원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '도장원(도장기조작원)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '비디오저널리스트' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '비디오저널리스트(VJ)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '세탁원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '세탁원(다림질원)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '용접원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '용접원(용접기조작원)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '인쇄기조작원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '인쇄기조작원(무늬롤)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '제관원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '제관원(제관기조작원)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '주조원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '주조원(주조기조작원)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '철골공' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '철골공(강구조물건립원)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '투자분석가' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '투자분석가(애널리스트)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '판금원' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '판금원(판금기조작원)' AND is_active = 1 LIMIT 1);
UPDATE job_sources SET job_id = (SELECT id FROM jobs WHERE name = '학예사' AND is_active = 1 LIMIT 1) WHERE job_id = (SELECT id FROM jobs WHERE name = '학예사(큐레이터)' AND is_active = 1 LIMIT 1);

-- Step 3: source jobs 비활성화 (is_active = 0)
UPDATE jobs SET is_active = 0 WHERE name IN (
  '금속공학기술자(일반)', '기술영업원(일반)', '무역사무원(일반)', '미장공(일반)', '방수공(일반)',
  '번역가(일반)', '사무보조원(일반)', '사진사(일반)', '사회복지사(일반)', '수의사(일반)',
  '여행안내원(일반)', '용접원(일반)', '재단사(일반)', '재봉사(일반)', '정부행정관리자(일반)',
  '제품디자이너(일반)', '조적공(일반)', '직업운동선수(일반)', '청소원(일반)', '청원경찰(일반)',
  '측량사(일반)', '캐드원(일반)', '통역가(일반)', '품질관리사무원(일반)', '한약사(일반)', '환경시험원(일반)',
  '단조원(단조기조작원)', '도장원(도장기조작원)', '비디오저널리스트(VJ)', '세탁원(다림질원)',
  '용접원(용접기조작원)', '인쇄기조작원(무늬롤)', '제관원(제관기조작원)', '주조원(주조기조작원)',
  '철골공(강구조물건립원)', '투자분석가(애널리스트)', '판금원(판금기조작원)', '학예사(큐레이터)'
) AND is_active = 1;

-- Step 4: pages 캐시 무효화 — updated_at 갱신으로 ISR 캐시 리프레시 유도
UPDATE pages SET updated_at = CURRENT_TIMESTAMP WHERE page_type = 'job' AND slug IN (
  SELECT slug FROM jobs WHERE name IN (
    '금속공학기술자', '기술영업원', '무역사무원', '미장공', '방수공',
    '번역가', '사무보조원', '사진사', '사회복지사', '수의사',
    '여행안내원', '용접원', '재단사', '재봉사', '정부행정관리자',
    '제품디자이너', '조적공', '직업운동선수', '청소원', '청원경찰',
    '측량사', '캐드원', '통역가', '품질관리사무원', '한약사', '환경시험원',
    '단조원', '도장원', '비디오저널리스트', '세탁원',
    '인쇄기조작원', '제관원', '주조원',
    '철골공', '투자분석가', '판금원', '학예사'
  )
);
