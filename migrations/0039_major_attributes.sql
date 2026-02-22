-- Migration: 0039_major_attributes.sql
-- 전공 속성 테이블 (job_attributes에 대응하는 전공 버전)
-- 전공 추천 파이프라인의 스코어링, 필터링, LLM Judge에서 사용

CREATE TABLE IF NOT EXISTS major_attributes (
  major_id INTEGER PRIMARY KEY,
  major_name TEXT NOT NULL,

  -- 학문적 특성 (0-100)
  academic_rigor INTEGER DEFAULT 50,        -- 이론/연구 비중
  math_intensity INTEGER DEFAULT 50,        -- 수학/정량적 요구
  creativity INTEGER DEFAULT 50,            -- 창의/디자인 요소
  social_interaction INTEGER DEFAULT 50,    -- 발표/그룹워크/대인관계
  lab_practical INTEGER DEFAULT 50,         -- 실험/실습 비중
  reading_writing INTEGER DEFAULT 50,       -- 독해/글쓰기 강도

  -- 진로/취업 연계 (0-100)
  career_breadth INTEGER DEFAULT 50,        -- 진출 가능 분야 넓이
  career_income_potential INTEGER DEFAULT 50, -- 졸업 후 소득 잠재력
  employment_rate INTEGER DEFAULT 50,       -- 취업률

  -- 전공 환경 (0-100)
  competition_level INTEGER DEFAULT 50,     -- 입학 경쟁률
  growth_outlook INTEGER DEFAULT 50,        -- 산업 성장성
  stability INTEGER DEFAULT 50,             -- 취업시장 안정성
  autonomy INTEGER DEFAULT 50,              -- 자기주도 학습 정도
  teamwork INTEGER DEFAULT 50,              -- 팀 프로젝트 비중

  -- 메타데이터
  field_category TEXT DEFAULT 'general',    -- 공학/인문/사회/자연/예체능/의약/교육/경영 등
  degree_level TEXT DEFAULT 'bachelor',     -- bachelor / master_preferred / phd_required
  prerequisite_subjects TEXT DEFAULT '[]',  -- 선이수 과목 JSON (예: ["수학","과학"])
  related_careers TEXT DEFAULT '[]',        -- 관련 직업 JSON (예: ["소프트웨어 개발자","데이터 분석가"])
  key_skills TEXT DEFAULT '[]',             -- 핵심 역량 JSON (예: ["논리적 사고","프로그래밍"])
  description TEXT,                         -- 전공 설명 텍스트

  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (major_id) REFERENCES majors(id)
);

CREATE INDEX IF NOT EXISTS idx_major_attrs_category ON major_attributes(field_category);
CREATE INDEX IF NOT EXISTS idx_major_attrs_name ON major_attributes(major_name);
