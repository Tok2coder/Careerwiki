-- Migration 0027: 온보딩 시스템
-- 작성일: 2025-12-09
-- 변경 내용:
--   1. users 테이블에 provider/provider_user_id/onboarded 컬럼 추가
--   2. user_attributions 테이블 생성 (유입경로)
--   3. consents 테이블 생성 (약관 동의 이력)
--   4. profanity_rules 테이블 생성 (금칙어 사전)

-- ============================================
-- 1. users 테이블 수정
-- ============================================

-- provider/provider_user_id/onboarded 컬럼 추가 (없는 경우)
-- SQLite는 IF NOT EXISTS를 지원하지 않아서 에러 무시가 어려움
-- 직접 ALTER TABLE 실행

ALTER TABLE users ADD COLUMN provider TEXT DEFAULT 'google';
ALTER TABLE users ADD COLUMN provider_user_id TEXT;
ALTER TABLE users ADD COLUMN onboarded INTEGER DEFAULT 0;

-- 기존 google_id 값을 provider_user_id로 복사
UPDATE users SET provider_user_id = google_id WHERE provider_user_id IS NULL;

-- 기존 사용자는 온보딩 완료 처리
UPDATE users SET onboarded = 1 WHERE onboarded = 0;

-- provider + provider_user_id 복합 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_users_provider_user ON users(provider, provider_user_id);

-- ============================================
-- 2. user_attributions 테이블 (유입경로)
-- ============================================

CREATE TABLE IF NOT EXISTS user_attributions (
  user_id INTEGER PRIMARY KEY,
  
  -- 자가보고 유입경로
  self_channel TEXT NOT NULL,  -- 프리셋 값
  self_channel_other TEXT,      -- 기타 선택 시 텍스트
  
  -- 선택 항목
  interest_state TEXT,  -- 관심 상태: job_search, major_search, career_change, consult_interest, browsing
  career_state TEXT,    -- 커리어 상태: high_school, university, job_seeker, employed, transition, other
  
  -- 기술적 캡처 (UTM 파라미터)
  utm_source TEXT,
  utm_medium TEXT,
  utm_campaign TEXT,
  utm_content TEXT,
  utm_term TEXT,
  
  -- 리퍼러
  referrer TEXT,
  
  -- 타임스탬프
  first_touch_at INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ============================================
-- 3. consents 테이블 (약관 동의 이력)
-- ============================================

CREATE TABLE IF NOT EXISTS consents (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  
  -- 동의 유형: 'terms' (이용약관) | 'privacy' (개인정보처리방침)
  type TEXT NOT NULL CHECK(type IN ('terms', 'privacy')),
  
  -- 동의한 약관 버전 (예: v1.0-2025-12-01)
  version TEXT NOT NULL,
  
  -- 동의 시점
  consented_at INTEGER NOT NULL,
  
  -- 감사 로그용
  ip TEXT,
  ua TEXT,
  
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 사용자별 동의 조회용 인덱스
CREATE INDEX IF NOT EXISTS idx_consents_user_id ON consents(user_id);
CREATE INDEX IF NOT EXISTS idx_consents_type ON consents(type);

-- ============================================
-- 4. profanity_rules 테이블 (금칙어 사전)
-- ============================================

CREATE TABLE IF NOT EXISTS profanity_rules (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 금칙어 패턴 (정규식 또는 단순 문자열)
  pattern TEXT NOT NULL UNIQUE,
  
  -- 치환 문자열
  replacement TEXT DEFAULT '**',
  
  -- 활성화 여부
  is_active INTEGER DEFAULT 1,
  
  -- 타임스탬프
  created_at INTEGER DEFAULT (strftime('%s','now'))
);

-- 초기 금칙어 데이터 삽입
INSERT OR IGNORE INTO profanity_rules (pattern, replacement) VALUES
  -- 예약어 (닉네임 금지)
  ('운영자', '**'),
  ('관리자', '**'),
  ('익명', '**'),
  ('admin', '**'),
  ('moderator', '**'),
  ('시스템', '**'),
  ('system', '**'),
  ('careerwiki', '**'),
  ('커리어위키', '**');

-- 참고:
-- - 실제 욕설 패턴은 운영 중 관리자가 추가
-- - pattern은 대소문자 무시하여 매칭 (코드에서 처리)
-- - 유니코드 유사문자 변형은 코드에서 정규화 후 검사

-- ============================================
-- 5. comments 테이블에 moderated 컬럼 추가
-- ============================================

-- comments 테이블 컬럼(moderated, original_content)은 이미 존재할 수 있으므로 추가를 생략한다.

