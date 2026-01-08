-- Migration 0026: Add 'USER' to primary_source CHECK constraint
-- 사용자가 직접 생성한 직업/전공을 구분하기 위해 'USER' 소스 추가

-- SQLite에서는 CHECK 제약 조건을 직접 수정할 수 없으므로 테이블 재생성 필요
-- (이미지 필드 등 최신 스키마를 유지하며 primary_source 제약만 확장)

-- 1. jobs 테이블 재생성
-- 기존 테이블 백업
CREATE TABLE jobs_backup AS SELECT * FROM jobs;

-- 기존 테이블 삭제
DROP TABLE jobs;

-- 새 테이블 생성 (USER 소스 추가)
CREATE TABLE jobs (
    id TEXT PRIMARY KEY,
    careernet_id TEXT,
    goyong24_id TEXT,
    name TEXT NOT NULL,
    api_data_json TEXT,
    api_data_hash TEXT,
    api_last_fetched_at INTEGER,
    api_last_updated_at INTEGER,
    user_contributed_json TEXT,
    user_last_updated_at INTEGER,
    admin_data_json TEXT,
    admin_last_updated_at INTEGER,
    created_at INTEGER NOT NULL,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    slug TEXT UNIQUE,
    primary_source TEXT CHECK(primary_source IN ('CAREERNET', 'WORK24_JOB', 'WORK24_DJOB', 'USER')),
    merged_profile_json TEXT,
    ai_data_json TEXT,
    ai_last_updated_at INTEGER,
    image_url TEXT,
    image_alt TEXT,
    image_credits TEXT
);

-- 데이터 복원
INSERT INTO jobs SELECT * FROM jobs_backup;

-- 백업 테이블 삭제
DROP TABLE jobs_backup;

-- 인덱스 재생성
CREATE INDEX IF NOT EXISTS idx_jobs_name ON jobs(name);
CREATE INDEX IF NOT EXISTS idx_jobs_is_active ON jobs(is_active);
CREATE INDEX IF NOT EXISTS idx_jobs_primary_source ON jobs(primary_source);
CREATE INDEX IF NOT EXISTS idx_jobs_slug ON jobs(slug);

-- 2. majors 테이블 재생성
-- 기존 테이블 백업
CREATE TABLE majors_backup AS SELECT * FROM majors;

-- 기존 테이블 삭제
DROP TABLE majors;

-- 새 테이블 생성 (USER 소스 추가)
CREATE TABLE majors (
    id TEXT PRIMARY KEY,
    careernet_id TEXT,
    goyong24_id TEXT,
    name TEXT NOT NULL,
    api_data_json TEXT,
    api_data_hash TEXT,
    api_last_fetched_at INTEGER,
    api_last_updated_at INTEGER,
    user_contributed_json TEXT,
    user_last_updated_at INTEGER,
    admin_data_json TEXT,
    admin_last_updated_at INTEGER,
    created_at INTEGER NOT NULL,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    slug TEXT UNIQUE,
    primary_source TEXT CHECK(primary_source IN ('CAREERNET', 'WORK24_MAJOR', 'USER')),
    merged_profile_json TEXT,
    ai_data_json TEXT,
    ai_last_updated_at INTEGER,
    image_url TEXT,
    image_alt TEXT,
    image_credits TEXT
);

-- 데이터 복원
INSERT INTO majors SELECT * FROM majors_backup;

-- 백업 테이블 삭제
DROP TABLE majors_backup;

-- 인덱스 재생성
CREATE INDEX IF NOT EXISTS idx_majors_name ON majors(name);
CREATE INDEX IF NOT EXISTS idx_majors_is_active ON majors(is_active);
CREATE INDEX IF NOT EXISTS idx_majors_primary_source ON majors(primary_source);
CREATE INDEX IF NOT EXISTS idx_majors_slug ON majors(slug);
