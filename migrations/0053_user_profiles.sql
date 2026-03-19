-- 사용자 AI 프로필 영구 저장 테이블
-- 직업/전공별 분리, 분석 완료 시 누적 업데이트
CREATE TABLE IF NOT EXISTS user_profiles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  analysis_type TEXT NOT NULL DEFAULT 'job', -- 'job' | 'major'

  -- 기본 정보 (career_state)
  role_identity TEXT,           -- 한글: '학생', '직장인' 등
  career_stage TEXT,            -- 한글: '0~3년 (초기)' 등
  transition_status TEXT,       -- 한글
  skill_level INTEGER,

  -- 관심사/성향 (universal_answers) - JSON 배열 (한글)
  interests_json TEXT,          -- ["기술/IT", "과학/연구"]
  values_json TEXT,             -- ["자율성", "인정받고 영향력 발휘"]
  strengths_json TEXT,          -- ["분석력", "학습력"]
  constraints_json TEXT,        -- ["시간 제약"]
  workstyle TEXT,               -- 한글: '혼자 집중'
  drains_json TEXT,             -- ["대인관계 스트레스"]
  sacrifices_json TEXT,         -- ["낮은 초봉 감수"]

  -- 전공 전용 필드
  good_subjects_json TEXT,      -- ["수학", "과학"] (전공 추천용)

  -- 심층 답변 (narrative)
  narrative_json TEXT,          -- { highAliveMoment, lostMoment, round_answers: [...] }

  -- 메타데이터
  last_request_id INTEGER,      -- 마지막 분석 request_id
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT NOT NULL DEFAULT (datetime('now')),

  UNIQUE(user_id, analysis_type)
);

CREATE INDEX IF NOT EXISTS idx_user_profiles_user ON user_profiles(user_id);
