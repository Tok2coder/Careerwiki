-- ============================================================================
-- Migration 0020: Name Mappings for Similar Name Merge
-- 유사 이름 병합을 위한 매핑 테이블
-- ============================================================================

-- 이름 매핑 테이블: ETL에서 source_name을 target_name으로 정규화
CREATE TABLE IF NOT EXISTS name_mappings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL CHECK(type IN ('job', 'major')),
    source_name TEXT NOT NULL,        -- 원본 이름 (병합될 이름)
    target_name TEXT NOT NULL,        -- 대상 이름 (병합 기준 이름)
    similarity_score REAL,            -- 유사도 점수 (0.0 ~ 1.0)
    match_reason TEXT,                -- 매칭 이유 (normalized, contains, levenshtein 등)
    created_by TEXT,                  -- 생성자 (admin user id)
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    UNIQUE(type, source_name)
);

-- 인덱스
CREATE INDEX IF NOT EXISTS idx_name_mappings_type ON name_mappings(type);
CREATE INDEX IF NOT EXISTS idx_name_mappings_source ON name_mappings(source_name);
CREATE INDEX IF NOT EXISTS idx_name_mappings_target ON name_mappings(target_name);
CREATE INDEX IF NOT EXISTS idx_name_mappings_active ON name_mappings(is_active);
CREATE INDEX IF NOT EXISTS idx_name_mappings_type_active ON name_mappings(type, is_active);

-- ============================================================================
-- Migration Complete
-- ============================================================================

