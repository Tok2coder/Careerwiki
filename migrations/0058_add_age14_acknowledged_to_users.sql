-- 0058_add_age14_acknowledged_to_users.sql
-- 정보통신망법 §31 — 만 14세 이상 자격 확인 시각 기록
-- 약관 동의가 아니라 "법적 자격 확인"이므로 consents 테이블이 아닌 users 테이블에 별도 저장

ALTER TABLE users ADD COLUMN age14_acknowledged_at TEXT;
