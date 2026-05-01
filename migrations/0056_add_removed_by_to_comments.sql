-- 0056_add_removed_by_to_comments.sql
-- 정책 §3 검열·삭제 투명성 — 댓글 삭제 출처 구분
-- - removed_by: 'author' (작성자 자진 삭제) | 'moderator' (운영자 결정) | NULL (legacy/미상)
-- - removed_at: 삭제 시각 (이의제기 30일 임시조치 만료 계산용)
-- - removed_reason_category: 운영자 삭제 시 사유 카테고리 (hate/abuse/misinfo/privacy/spam/other)
-- - removed_decision_id: moderation_decisions.id 참조 (운영자 결정 추적)

ALTER TABLE comments ADD COLUMN removed_by TEXT
  CHECK(removed_by IS NULL OR removed_by IN ('author', 'moderator'));
ALTER TABLE comments ADD COLUMN removed_at DATETIME;
ALTER TABLE comments ADD COLUMN removed_reason_category TEXT;
ALTER TABLE comments ADD COLUMN removed_decision_id INTEGER;

-- 인덱스: 삭제된 댓글 조회·필터링용
CREATE INDEX IF NOT EXISTS idx_comments_removed_by ON comments(removed_by) WHERE removed_by IS NOT NULL;
