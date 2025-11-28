-- ============================================================================
-- Migration 0018: Complete ETL System - All-in-One
-- 이 마이그레이션은 0013-0017의 내용을 모두 포함합니다
-- ============================================================================

-- ============================================================================
-- PART 1: Source Tables (0013)
-- ============================================================================

CREATE TABLE IF NOT EXISTS job_sources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id TEXT,
    source_system TEXT NOT NULL CHECK(source_system IN ('CAREERNET', 'WORK24_JOB', 'WORK24_DJOB')),
    source_key TEXT NOT NULL,
    source_type TEXT CHECK(source_type IN ('LIST', 'DETAIL', 'ENCYCLOPEDIA', 'DICTIONARY')),
    std_job_cd TEXT,
    keco_cd TEXT,
    ksoc_cd TEXT,
    industry_cd TEXT,
    raw_payload TEXT NOT NULL,
    normalized_payload TEXT NOT NULL,
    fetched_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    last_error TEXT,
    retry_count INTEGER DEFAULT 0,
    UNIQUE(source_system, source_key),
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_job_sources_job_id ON job_sources(job_id);
CREATE INDEX IF NOT EXISTS idx_job_sources_system_key ON job_sources(source_system, source_key);
CREATE INDEX IF NOT EXISTS idx_job_sources_codes ON job_sources(std_job_cd, keco_cd, ksoc_cd);
CREATE INDEX IF NOT EXISTS idx_job_sources_type ON job_sources(source_type);

CREATE TABLE IF NOT EXISTS major_sources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    major_id TEXT,
    source_system TEXT NOT NULL CHECK(source_system IN ('CAREERNET', 'WORK24_MAJOR')),
    source_key TEXT NOT NULL,
    source_type TEXT CHECK(source_type IN ('LIST', 'DETAIL_UNIV', 'DETAIL_HIGH', 'DETAIL_GENERAL', 'DETAIL_SPECIAL')),
    major_seq TEXT,
    department_cd TEXT,
    track TEXT,
    gubun TEXT,
    raw_payload TEXT NOT NULL,
    normalized_payload TEXT NOT NULL,
    fetched_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    last_error TEXT,
    retry_count INTEGER DEFAULT 0,
    UNIQUE(source_system, source_key),
    FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_major_sources_major_id ON major_sources(major_id);
CREATE INDEX IF NOT EXISTS idx_major_sources_system_key ON major_sources(source_system, source_key);
CREATE INDEX IF NOT EXISTS idx_major_sources_codes ON major_sources(major_seq, department_cd);
CREATE INDEX IF NOT EXISTS idx_major_sources_type ON major_sources(source_type);
CREATE INDEX IF NOT EXISTS idx_major_sources_track ON major_sources(track);

-- ============================================================================
-- PART 2: Match Overrides (0014)
-- ============================================================================

CREATE TABLE IF NOT EXISTS job_match_overrides (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id TEXT NOT NULL,
    source_system TEXT NOT NULL,
    source_key TEXT NOT NULL,
    reason TEXT,
    confidence REAL,
    created_by TEXT,
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    UNIQUE(job_id, source_system, source_key),
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_job_match_overrides_job_id ON job_match_overrides(job_id);
CREATE INDEX IF NOT EXISTS idx_job_match_overrides_source ON job_match_overrides(source_system, source_key);

-- ============================================================================
-- PART 3: Assets Tables (0015)
-- ============================================================================

CREATE TABLE IF NOT EXISTS job_assets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('hero_image', 'infographic', 'icon', 'chart', 'video_thumbnail', 'other')),
    source TEXT NOT NULL CHECK(source IN ('AI', 'USER', 'ADMIN', 'OFFICIAL', 'API')),
    url TEXT NOT NULL,
    caption TEXT,
    alt_text TEXT,
    meta_json TEXT,
    display_order INTEGER DEFAULT 0,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_job_assets_job_id ON job_assets(job_id);
CREATE INDEX IF NOT EXISTS idx_job_assets_type ON job_assets(type);
CREATE INDEX IF NOT EXISTS idx_job_assets_is_active ON job_assets(is_active);

CREATE TABLE IF NOT EXISTS major_assets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    major_id TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('hero_image', 'infographic', 'icon', 'chart', 'campus_photo', 'other')),
    source TEXT NOT NULL CHECK(source IN ('AI', 'USER', 'ADMIN', 'OFFICIAL', 'API')),
    url TEXT NOT NULL,
    caption TEXT,
    alt_text TEXT,
    meta_json TEXT,
    display_order INTEGER DEFAULT 0,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_major_assets_major_id ON major_assets(major_id);
CREATE INDEX IF NOT EXISTS idx_major_assets_type ON major_assets(type);
CREATE INDEX IF NOT EXISTS idx_major_assets_is_active ON major_assets(is_active);

-- ============================================================================
-- PART 4: Create and Alter Jobs/Majors Tables (0016)
-- ============================================================================

-- First, create jobs table if it doesn't exist
CREATE TABLE IF NOT EXISTS jobs (
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
    primary_source TEXT CHECK(primary_source IN ('CAREERNET', 'WORK24_JOB', 'WORK24_DJOB')),
    merged_profile_json TEXT,
    ai_data_json TEXT,
    ai_last_updated_at INTEGER
);

-- Create majors table if it doesn't exist
CREATE TABLE IF NOT EXISTS majors (
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
    primary_source TEXT CHECK(primary_source IN ('CAREERNET', 'WORK24_MAJOR')),
    merged_profile_json TEXT,
    ai_data_json TEXT,
    ai_last_updated_at INTEGER
);

-- Note: columns are already included in CREATE TABLE above, no ALTER needed

CREATE INDEX IF NOT EXISTS idx_jobs_slug ON jobs(slug);
CREATE INDEX IF NOT EXISTS idx_jobs_primary_source ON jobs(primary_source);
CREATE INDEX IF NOT EXISTS idx_majors_slug ON majors(slug);
CREATE INDEX IF NOT EXISTS idx_majors_primary_source ON majors(primary_source);

-- ============================================================================
-- PART 5: Job Dictionary Index (0017)
-- ============================================================================

CREATE TABLE IF NOT EXISTS job_dictionary_index (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    d_job_cd TEXT NOT NULL,
    d_job_cd_seq TEXT NOT NULL,
    large_class_cd TEXT,
    medium_class_cd TEXT,
    small_class_cd TEXT,
    large_class_nm TEXT,
    medium_class_nm TEXT,
    small_class_nm TEXT,
    job_nm TEXT NOT NULL,
    related_job TEXT,
    similar_job_nm TEXT,
    is_seeded INTEGER DEFAULT 0 CHECK(is_seeded IN (0, 1)),
    seeded_at INTEGER,
    seed_error TEXT,
    retry_count INTEGER DEFAULT 0,
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    UNIQUE(d_job_cd, d_job_cd_seq)
);

CREATE INDEX IF NOT EXISTS idx_job_dict_codes ON job_dictionary_index(d_job_cd, d_job_cd_seq);
CREATE INDEX IF NOT EXISTS idx_job_dict_seeded ON job_dictionary_index(is_seeded);
CREATE INDEX IF NOT EXISTS idx_job_dict_job_nm ON job_dictionary_index(job_nm);
CREATE INDEX IF NOT EXISTS idx_job_dict_class ON job_dictionary_index(large_class_cd, medium_class_cd, small_class_cd);

-- ============================================================================
-- PART 6: Seed Logs and Errors (0017)
-- ============================================================================

CREATE TABLE IF NOT EXISTS seed_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    seed_type TEXT NOT NULL CHECK(seed_type IN (
      'CAREERNET_JOB_LIST',
      'CAREERNET_JOB_DETAIL',
      'CAREERNET_JOB_ENCYCLOPEDIA',
      'WORK24_JOB_LIST',
      'WORK24_JOB_DETAIL',
      'WORK24_JOB_DICT_LOAD',
      'WORK24_JOB_DICT_DETAIL',
      'CAREERNET_MAJOR_LIST',
      'CAREERNET_MAJOR_DETAIL',
      'WORK24_MAJOR_LIST',
      'WORK24_MAJOR_DETAIL',
      'ETL_MERGE_JOBS',
      'ETL_MERGE_MAJORS'
    )),
    started_at INTEGER NOT NULL,
    completed_at INTEGER,
    status TEXT NOT NULL CHECK(status IN ('running', 'completed', 'failed', 'partial')),
    total_count INTEGER DEFAULT 0,
    success_count INTEGER DEFAULT 0,
    failed_count INTEGER DEFAULT 0,
    skipped_count INTEGER DEFAULT 0,
    error_message TEXT,
    error_details TEXT,
    meta_json TEXT,
    created_at INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_seed_logs_type ON seed_logs(seed_type);
CREATE INDEX IF NOT EXISTS idx_seed_logs_status ON seed_logs(status);
CREATE INDEX IF NOT EXISTS idx_seed_logs_started ON seed_logs(started_at DESC);

CREATE TABLE IF NOT EXISTS seed_errors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    seed_log_id INTEGER,
    seed_type TEXT NOT NULL,
    entity_type TEXT NOT NULL CHECK(entity_type IN ('job', 'major', 'job_dict')),
    entity_id TEXT NOT NULL,
    entity_name TEXT,
    error_message TEXT,
    error_stack TEXT,
    request_params TEXT,
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    last_retry_at INTEGER,
    resolved_at INTEGER,
    created_at INTEGER NOT NULL,
    FOREIGN KEY (seed_log_id) REFERENCES seed_logs(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_seed_errors_type ON seed_errors(seed_type, entity_type);
CREATE INDEX IF NOT EXISTS idx_seed_errors_retry ON seed_errors(retry_count, resolved_at);
CREATE INDEX IF NOT EXISTS idx_seed_errors_entity ON seed_errors(entity_type, entity_id);

-- ============================================================================
-- Migration Complete
-- ============================================================================

