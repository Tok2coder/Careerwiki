-- Phase 3 Day 4: 운영자 권한 부여
-- 작성일: 2025-11-17

-- jungwkim15@gmail.com 이메일을 가진 사용자에게 운영자 권한 부여
UPDATE users 
SET role = 'admin', updated_at = strftime('%s','now')
WHERE email = 'jungwkim15@gmail.com';

-- 참고:
-- - 기존 사용자의 role이 'user'에서 'admin'으로 변경됨
-- - 신규 사용자는 회원가입 시 'user'로 시작


