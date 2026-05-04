-- 관리자가 직접 "스킬 검증 완료"를 표시하기 위한 컬럼.
-- /admin/job-equalize 표에서 체크박스 토글로 사용. 자동화된 스킬 마커(page_revisions)와 별개.
ALTER TABLE jobs   ADD COLUMN skill_verified_by_user INTEGER NOT NULL DEFAULT 0;
ALTER TABLE jobs   ADD COLUMN skill_verified_at TEXT DEFAULT NULL;
ALTER TABLE majors ADD COLUMN skill_verified_by_user INTEGER NOT NULL DEFAULT 0;
ALTER TABLE majors ADD COLUMN skill_verified_at TEXT DEFAULT NULL;
