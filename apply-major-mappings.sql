-- 전공 매핑 저장 (사용자 제공 + 정규화 중복)
-- 실행: npx wrangler d1 execute careerwiki-db --local --file=apply-major-mappings.sql

-- 사용자가 선택한 매핑들
INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active)
VALUES 
  ('major', '안경광학과', '(안경)광학과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '광고홍보학과', '광고·홍보학과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '국어국문학과', '국어·국문학과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '금융보험학과', '금융·보험학과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '러시아어문학과', '러시아어·문학과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '만화애니메이션학과', '만화·애니메이션학과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '방송연예과', '방송·연예과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '세무회계학과', '세무·회계학과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '연극영화학과', '연극·영화학과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '정보통신공학과', '정보·통신공학과', 0.98, 'normalized', 1732819200000, 1),
  ('major', '기타아시아어학과', '기타 아시아어·문학과', 0.89, 'levenshtein', 1732819200000, 1),
  ('major', '기타유럽어학과', '기타 유럽어·문학과', 0.88, 'levenshtein', 1732819200000, 1),
  ('major', '스페인어학과', '스페인어·문학과', 0.86, 'levenshtein', 1732819200000, 1),
  ('major', '의류ㆍ의상학과', '의류·의상학과', 0.86, 'levenshtein', 1732819200000, 1),
  ('major', '세무회계과', '세무·회계학과', 0.83, 'levenshtein', 1732819200000, 1),
  ('major', '식품조리학과', '식품조리과', 0.83, 'levenshtein', 1732819200000, 1),
  ('major', '연극영화과', '연극·영화학과', 0.83, 'levenshtein', 1732819200000, 1),
  ('major', '초등교육학과', '초등교육과', 0.83, 'levenshtein', 1732819200000, 1),
  ('major', '메카트로닉스공학과', '메카트로닉스(기전)공학과', 0.82, 'levenshtein', 1732819200000, 1),
  ('major', '물리학과', '물리·과학과', 0.8, 'levenshtein', 1732819200000, 1),
  ('major', '언어학과', '언어과학과', 0.8, 'levenshtein', 1732819200000, 1),
  ('major', '국제학부', '국제학과', 0.75, 'levenshtein', 1732819200000, 1),
  ('major', '독일어·문학과', '독어독문학과', 0.67, 'levenshtein', 1732819200000, 1),
  ('major', '일어일문학과', '일본어·문학과', 0.67, 'levenshtein', 1732819200000, 1);

-- 확인
SELECT COUNT(*) as total_major_mappings FROM name_mappings WHERE type = 'major' AND is_active = 1;

