-- 0055_dispute_system.sql
-- 정책 dispute §1~§8 — 토론·합의·분쟁 인프라 (D2~D8)
-- - dispute_threads: 토론 발제 (D2)
-- - dispute_proposals: 합의안 + 이의제기 기간 카운트다운 (D2)
-- - dispute_proposals.frozen_text: 서술 시점 고정 (D3)
-- - dispute_company_replies: 회사 답글권 (D7, Glassdoor)

CREATE TABLE IF NOT EXISTS dispute_threads (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  -- 대상
  target_type TEXT NOT NULL CHECK(target_type IN ('job', 'major', 'howto', 'comment', 'policy')),
  target_id TEXT NOT NULL,                      -- 직업/전공 슬러그 또는 페이지 ID
  target_field TEXT,                            -- 분쟁 필드 (예: way, salary, trivia, content_general)
  -- 발제
  opened_by INTEGER,                            -- users.id (NULL = 익명/시스템)
  opener_position TEXT,                         -- 발제자의 입장 (자유 서술)
  opener_evidence TEXT,                         -- 출처/근거
  -- 서술 시점 고정 (D3)
  frozen_text TEXT,                             -- 토론 진행 중 변경 차단된 원본 텍스트
  frozen_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  -- 상태
  status TEXT DEFAULT 'open' CHECK(status IN ('open', 'consensus_pending', 'consensus_window', 'closed_consensus', 'closed_no_consensus', 'invalidated')),
  resolution TEXT,                              -- 종결 사유
  -- 메타
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  closed_at DATETIME,
  -- 다중 토론 가드 (D6)
  parent_thread_id INTEGER,                     -- 같은 주제 재발제 시 이전 토론 링크
  FOREIGN KEY (opened_by) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (parent_thread_id) REFERENCES dispute_threads(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_dthread_target ON dispute_threads(target_type, target_id, target_field);
CREATE INDEX IF NOT EXISTS idx_dthread_status ON dispute_threads(status);
CREATE INDEX IF NOT EXISTS idx_dthread_opened_by ON dispute_threads(opened_by);

-- 합의안 + 이의제기 기간
CREATE TABLE IF NOT EXISTS dispute_proposals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  thread_id INTEGER NOT NULL,
  proposer_id INTEGER,
  proposed_text TEXT NOT NULL,
  proposed_evidence TEXT,
  -- 동의자
  agreement_count INTEGER DEFAULT 0,             -- 발제자 외 동의자 수
  -- 이의 제기 기간 (정책: 최소 48h + 6h × 2회 갱신)
  objection_window_starts_at DATETIME,
  objection_window_ends_at DATETIME,
  objection_extensions INTEGER DEFAULT 0,        -- 이의로 인한 갱신 횟수 (max 2)
  -- 상태
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'awaiting_objection', 'agreed', 'rejected', 'invalidated')),
  finalized_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (thread_id) REFERENCES dispute_threads(id) ON DELETE CASCADE,
  FOREIGN KEY (proposer_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_dprop_thread ON dispute_proposals(thread_id);
CREATE INDEX IF NOT EXISTS idx_dprop_status ON dispute_proposals(status, objection_window_ends_at);

-- 토론 동의/이의 (D2)
CREATE TABLE IF NOT EXISTS dispute_votes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  proposal_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  vote_type TEXT NOT NULL CHECK(vote_type IN ('agree', 'object', 'comment')),
  comment_text TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(proposal_id, user_id, vote_type),
  FOREIGN KEY (proposal_id) REFERENCES dispute_proposals(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 회사 답글권 (D7 — Glassdoor 모델)
CREATE TABLE IF NOT EXISTS company_replies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  -- 대상 댓글
  comment_id INTEGER NOT NULL,
  -- 회사 측 작성자 (운영팀이 신원 확인 후 발급)
  company_name TEXT NOT NULL,
  responder_name TEXT,                           -- 응답자 직책·이름
  reply_content TEXT NOT NULL,
  -- 운영자 검증
  approved_by INTEGER,                           -- users.id (operator)
  approved_at DATETIME,
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'approved', 'rejected')),
  -- 메타
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE,
  FOREIGN KEY (approved_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_creply_comment ON company_replies(comment_id);
CREATE INDEX IF NOT EXISTS idx_creply_status ON company_replies(status);
