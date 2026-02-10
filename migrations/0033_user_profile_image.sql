-- 사용자 프로필 이미지 커스텀 URL 추가
-- 작성일: 2025-12-23
-- 설명: 사용자가 직접 업로드한 프로필 이미지 URL을 저장하는 컬럼

-- custom_picture_url: 사용자가 직접 업로드한 프로필 이미지 (R2에 저장)
-- 우선순위: custom_picture_url > picture_url (OAuth) > 기본 아이콘

ALTER TABLE users ADD COLUMN custom_picture_url TEXT;










