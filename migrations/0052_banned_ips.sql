-- IP 해시 기반 편집 차단
CREATE TABLE IF NOT EXISTS banned_ips (
  ip_hash TEXT PRIMARY KEY,
  reason TEXT,
  banned_by INTEGER,             -- admin user id
  banned_at TEXT NOT NULL DEFAULT (datetime('now')),
  banned_until TEXT               -- NULL = 영구 차단
);
