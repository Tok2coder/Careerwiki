-- 전공(학과) 데이터 통합 테이블
CREATE TABLE majors (
    id TEXT PRIMARY KEY,
    careernet_id TEXT,
    goyong24_id TEXT,
    name TEXT NOT NULL,
    
    -- API 데이터 (자동 업데이트)
    api_data_json TEXT,           -- 커리어넷 + 고용24 통합 데이터
    api_data_hash TEXT,            -- 변경 감지용 해시
    api_last_fetched_at INTEGER,  -- 마지막 API 호출 시각
    api_last_updated_at INTEGER,  -- 실제 API 데이터 변경 시각
    
    -- 사용자 기여 데이터 (수동 관리, API 업데이트 시 보존)
    user_contributed_json TEXT,    -- 유저가 추가한 정보
    user_last_updated_at INTEGER,
    
    -- 운영진 데이터 (수동 관리, API 업데이트 시 보존)
    admin_data_json TEXT,          -- 운영진이 추가한 정보
    admin_last_updated_at INTEGER,
    
    -- 메타데이터
    created_at INTEGER NOT NULL,
    is_active INTEGER DEFAULT 1    -- 0이면 비활성 (삭제 표시)
);

CREATE INDEX idx_majors_name ON majors(name);
CREATE INDEX idx_majors_careernet_id ON majors(careernet_id);
CREATE INDEX idx_majors_goyong24_id ON majors(goyong24_id);
CREATE INDEX idx_majors_is_active ON majors(is_active);

-- 전공 업데이트 로그 (무엇이 언제 변경되었는지 추적)
CREATE TABLE major_update_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    major_id TEXT NOT NULL,
    update_type TEXT NOT NULL,     -- 'api', 'user', 'admin'
    changed_fields TEXT,            -- JSON array: ["curriculum", "career_prospects"]
    old_hash TEXT,
    new_hash TEXT,
    updated_at INTEGER NOT NULL,
    updated_by TEXT                 -- 'cron', 'user:123', 'admin:456'
);

CREATE INDEX idx_major_logs_major_id ON major_update_logs(major_id);
CREATE INDEX idx_major_logs_updated_at ON major_update_logs(updated_at);
