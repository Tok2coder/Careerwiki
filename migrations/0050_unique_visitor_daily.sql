-- 순방문자(UV) 일별 추적 테이블
-- IP 해시 기반 중복 제거로 DAU/MAU 측정
CREATE TABLE IF NOT EXISTS unique_visitor_daily (
  stat_date TEXT NOT NULL,
  ip_hash TEXT NOT NULL,
  PRIMARY KEY (stat_date, ip_hash)
);

CREATE INDEX IF NOT EXISTS idx_uvd_date ON unique_visitor_daily(stat_date);
