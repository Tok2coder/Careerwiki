-- 0054_enforcement_system.sql
-- 정책 enforcement §4~§7 구현용 테이블 (B2~B6)
-- - moderation_decisions: 운영자 검토 큐 + 4결과 결정 기록 (B2)
-- - user_appeals: 작성자 이의제기 + 30일 임시조치 상태 (B3)
-- - user_sanctions: 단계제 제재 카운터 (1차 경고 → 7일 → 30일 → 영구) (B4)
-- - user_appeals.permanent_reason: 즉시 영구 사유 (B5)
-- - user_appeals (소명 폼) (B6)
-- 모두 idempotent하게 설계.

-- ============================================================================
-- moderation_decisions: 운영자가 신고 검토 후 내린 결정 기록
-- ============================================================================
CREATE TABLE IF NOT EXISTS moderation_decisions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  -- 대상 콘텐츠
  target_type TEXT NOT NULL CHECK(target_type IN ('comment', 'howto', 'wiki_edit')),
  target_id INTEGER NOT NULL,
  -- 신고 출처 (있는 경우)
  source_report_id INTEGER,            -- comment_reports.id 또는 howto_reports.id
  source_report_type TEXT,              -- 'comment_report' | 'howto_report'
  -- 결정
  decision TEXT NOT NULL CHECK(decision IN ('keep', 'delete', 'warn_keep', 'request_revision')),
  decision_reason TEXT,                 -- 운영자 메모
  -- 우선순위
  priority TEXT DEFAULT 'normal' CHECK(priority IN ('urgent', 'high', 'normal', 'low')),
  sla_deadline DATETIME,                -- urgent=2시간, high=24시간, normal=72시간
  -- 처리자
  decided_by INTEGER,                   -- users.id (operator)
  decided_at DATETIME,
  -- 자동/수동 구분
  auto_flagged INTEGER DEFAULT 0,       -- 1=자동 분류기로 큐에 들어감
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'in_review', 'decided', 'appealed')),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (decided_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_moddec_status ON moderation_decisions(status, priority);
CREATE INDEX IF NOT EXISTS idx_moddec_target ON moderation_decisions(target_type, target_id);
CREATE INDEX IF NOT EXISTS idx_moddec_decided_by ON moderation_decisions(decided_by);
CREATE INDEX IF NOT EXISTS idx_moddec_sla ON moderation_decisions(sla_deadline) WHERE status = 'pending';

-- ============================================================================
-- user_sanctions: 단계제 제재 카운터 (B4)
-- - 1차 경고 → 2차 7일 정지 → 3차 30일 정지 → 4차 영구
-- - 즉시 영구 사유 (B5)는 stage='permanent', is_immediate=1
-- ============================================================================
CREATE TABLE IF NOT EXISTS user_sanctions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  stage TEXT NOT NULL CHECK(stage IN ('warn', 'suspend_7d', 'suspend_30d', 'permanent')),
  is_immediate INTEGER DEFAULT 0,       -- 1=즉시 영구 (단계 건너뜀, B5)
  reason_category TEXT NOT NULL CHECK(reason_category IN (
    'hate', 'abuse', 'misinfo', 'privacy', 'spam', 'other',
    'csam', 'threat', 'evasion', 'malware', 'repeated_falsehood'
  )),
  reason_detail TEXT,
  -- 시작/종료
  started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  ends_at DATETIME,                     -- NULL = 영구 또는 경고
  -- 출처 (있는 경우)
  source_decision_id INTEGER,           -- moderation_decisions.id
  -- 처리자
  issued_by INTEGER,                    -- users.id (operator)
  -- 상태
  status TEXT DEFAULT 'active' CHECK(status IN ('active', 'lifted', 'expired')),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (issued_by) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (source_decision_id) REFERENCES moderation_decisions(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_sanct_user ON user_sanctions(user_id, status);
CREATE INDEX IF NOT EXISTS idx_sanct_active ON user_sanctions(status, ends_at);

-- ============================================================================
-- user_appeals: 이의제기 폼 + 소명 (B3, B6)
-- - 30일 임시조치 상태 추적
-- ============================================================================
CREATE TABLE IF NOT EXISTS user_appeals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  -- 대상
  target_type TEXT NOT NULL CHECK(target_type IN ('comment_takedown', 'sanction', 'content_removal')),
  target_id INTEGER NOT NULL,           -- moderation_decisions.id 또는 user_sanctions.id
  -- 신청자
  user_id INTEGER NOT NULL,
  -- 내용
  reason TEXT NOT NULL,
  evidence TEXT,                        -- 추가 증빙 (외부 링크 등 텍스트)
  -- 임시조치 (정보통신망법)
  temp_action_started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  temp_action_ends_at DATETIME,         -- 30일 후
  -- 처리
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'reviewing', 'accepted', 'rejected', 'partially_accepted', 'expired')),
  reviewed_by INTEGER,                  -- 다른 운영자 (1차 결정자 회피)
  reviewed_at DATETIME,
  review_note TEXT,
  -- 재소명 금지 카운터 (기각 후 30일)
  resubmit_blocked_until DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (reviewed_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_appeal_user ON user_appeals(user_id);
CREATE INDEX IF NOT EXISTS idx_appeal_status ON user_appeals(status, temp_action_ends_at);
CREATE INDEX IF NOT EXISTS idx_appeal_target ON user_appeals(target_type, target_id);
