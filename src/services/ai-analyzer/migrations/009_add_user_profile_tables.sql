-- CareerWiki AI Analyzer - User Profile Tables
-- Migration: 009_add_user_profile_tables.sql
-- Version: v1.0.0
-- Created: 2026-01-06
--
-- Purpose: Premium 서비스를 위한 사용자 프로필 저장
-- - conversation_turns: 각 대화 턴별 원본 답변 저장
-- - user_profile_snapshots: 보고서 생성 시점의 프로필 스냅샷
--
-- ⚠️ 설계 원칙 (피드백 반영)
-- - 가설 신뢰도 변화 (before/after) 기록
-- - 이번 세션에서 새로 확정된 사항 기록
-- - 불확실성 감소 항목 추적
-- → "다음에 올수록 더 똑똑해지는 서비스" 구현 기반

-- ============================================
-- 1. 대화 턴 저장 (conversation_turns)
-- ============================================
-- 각 턴별로 사용자의 원본 답변을 저장
-- 이를 통해 전체 대화 히스토리를 재구성 가능

CREATE TABLE IF NOT EXISTS conversation_turns (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 세션/사용자 식별
  session_id TEXT NOT NULL,
  user_id TEXT,
  request_id INTEGER,                    -- ai_analysis_requests.id 참조
  
  -- 턴 정보
  turn_number INTEGER NOT NULL,          -- 해당 세션에서 몇 번째 턴인지 (1부터 시작)
  turn_type TEXT NOT NULL CHECK(turn_type IN (
    'universal_intake',                  -- 기본 universal 질문 답변
    'stage_intake',                      -- 단계별 심화 질문 답변
    'deep_intake',                       -- Deep Intake (자유 텍스트)
    'followup_v2',                       -- 기존 FollowupV2 답변
    'followup_v3',                       -- 새로운 3종 분류 Followup 답변
    'premium_report_generated'           -- 보고서 생성 시점 마커
  )),
  
  -- 질문 정보 (어떤 질문에 대한 답변인지)
  question_id TEXT,                      -- 질문 ID (있으면)
  question_type TEXT,                    -- FollowupPurpose: contradiction_resolver, decision_variable, reality_constraint
  question_why_asked TEXT,               -- 이 질문을 한 이유
  
  -- 답변 원본
  answer_raw TEXT NOT NULL,              -- 원본 답변 (텍스트 또는 JSON)
  answer_type TEXT DEFAULT 'text' CHECK(answer_type IN ('text', 'single_choice', 'multi_choice', 'json')),
  
  -- 추출된 신호 (Extracted Signals)
  extracted_signals_json TEXT,           -- 답변에서 추출한 신호 JSON
                                         -- 예: {"preferences": ["wlb"], "constraints": ["no_overtime"], "motivations": ["growth"]}
  
  -- 영향 받은 속성
  affected_dimensions_json TEXT,         -- 이 답변으로 영향받은 직업 속성들 ["wlb", "growth", "income"]
  
  -- 메타
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_conv_turns_session ON conversation_turns(session_id);
CREATE INDEX IF NOT EXISTS idx_conv_turns_user ON conversation_turns(user_id);
CREATE INDEX IF NOT EXISTS idx_conv_turns_request ON conversation_turns(request_id);
CREATE INDEX IF NOT EXISTS idx_conv_turns_type ON conversation_turns(turn_type);

-- ============================================
-- 2. 사용자 프로필 스냅샷 (user_profile_snapshots)
-- ============================================
-- 보고서 생성 시점의 프로필 상태를 스냅샷으로 저장
-- 가설 신뢰도 변화 추적 가능

CREATE TABLE IF NOT EXISTS user_profile_snapshots (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 세션/사용자 식별
  session_id TEXT NOT NULL,
  user_id TEXT,
  request_id INTEGER,                    -- ai_analysis_requests.id 참조
  report_id TEXT,                        -- 생성된 보고서 ID
  
  -- 스냅샷 트리거
  trigger_type TEXT NOT NULL CHECK(trigger_type IN (
    'initial_analysis',                  -- 첫 분석 완료 시
    'followup_completed',                -- 팔로업 완료 시
    'premium_report',                    -- 프리미엄 보고서 생성 시
    'manual_update'                      -- 수동 업데이트
  )),
  
  -- 프로필 데이터 (핵심!)
  profile_json TEXT NOT NULL,            -- 전체 프로필 JSON (아래 구조 참조)
  
  -- ============================================
  -- profile_json 구조 (스키마 문서화):
  -- {
  --   // 원본 답변 요약
  --   "raw_answers_summary": {
  --     "total_turns": 5,
  --     "intake_turns": 2,
  --     "followup_turns": 3
  --   },
  --   
  --   // 추출된 신호
  --   "extracted_signals": {
  --     "preferences": ["wlb", "growth"],
  --     "constraints": ["no_overtime", "remote_preferred"],
  --     "motivations": ["meaning", "income"],
  --     "dislikes": ["repetitive_work", "strict_hierarchy"]
  --   },
  --   
  --   // 가설 (핵심!)
  --   "hypotheses": [
  --     {
  --       "id": "hypothesis_1",
  --       "statement": "사용자는 성장 가능성을 가장 중시한다",
  --       "confidence_before": 0.5,      // 이전 세션
  --       "confidence_after": 0.8,       // 현재 세션
  --       "confidence_change": 0.3,      // 변화량
  --       "supporting_facts": ["priority.top1=growth", "deep_intake.best_moment=성장"],
  --       "contradicting_facts": [],
  --       "status": "strengthened"       // strengthened | weakened | unchanged | new | invalidated
  --     }
  --   ],
  --   
  --   // 이번 세션에서 새로 확정된 사항
  --   "newly_confirmed": [
  --     {"fact_key": "constraint.remote_required", "value": true, "turn_number": 3}
  --   ],
  --   
  --   // 불확실성 감소 항목
  --   "uncertainty_reduced": [
  --     {
  --       "dimension": "wlb_preference",
  --       "before_uncertainty": 0.7,
  --       "after_uncertainty": 0.2,
  --       "resolved_by_turn": 4
  --     }
  --   ],
  --   
  --   // 다음 세션에서 확인할 사항
  --   "pending_clarifications": [
  --     {"question": "야근 허용 범위", "priority": "high", "affected_dimensions": ["wlb"]}
  --   ]
  -- }
  -- ============================================
  
  -- 가설 요약 (빠른 조회용)
  hypotheses_count INTEGER DEFAULT 0,
  hypotheses_strengthened INTEGER DEFAULT 0,
  hypotheses_weakened INTEGER DEFAULT 0,
  hypotheses_new INTEGER DEFAULT 0,
  
  -- 불확실성 감소 지표
  uncertainty_reduction_score REAL DEFAULT 0,  -- 0~1, 이번 세션에서 감소한 불확실성 총량
  
  -- 메타
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- 이전 스냅샷 참조 (변화 추적용)
  previous_snapshot_id INTEGER,
  
  UNIQUE(session_id, trigger_type, created_at)
);

CREATE INDEX IF NOT EXISTS idx_profile_snapshots_session ON user_profile_snapshots(session_id);
CREATE INDEX IF NOT EXISTS idx_profile_snapshots_user ON user_profile_snapshots(user_id);
CREATE INDEX IF NOT EXISTS idx_profile_snapshots_request ON user_profile_snapshots(request_id);
CREATE INDEX IF NOT EXISTS idx_profile_snapshots_trigger ON user_profile_snapshots(trigger_type);

-- ============================================
-- 3. 가설 히스토리 (hypothesis_history)
-- ============================================
-- 개별 가설의 신뢰도 변화 히스토리 추적
-- "더 똑똑해지는 서비스" 핵심 데이터

CREATE TABLE IF NOT EXISTS hypothesis_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 세션/사용자 식별
  session_id TEXT NOT NULL,
  user_id TEXT,
  snapshot_id INTEGER,                   -- user_profile_snapshots.id 참조
  
  -- 가설 정보
  hypothesis_id TEXT NOT NULL,           -- 가설 고유 ID (예: "h_workstyle_solo")
  hypothesis_statement TEXT NOT NULL,    -- 가설 문장
  
  -- 신뢰도 변화
  confidence_before REAL,                -- 0~1
  confidence_after REAL NOT NULL,        -- 0~1
  confidence_change REAL,                -- -1~1
  
  -- 변화 원인
  change_reason TEXT,                    -- 변화 원인 설명
  triggered_by_turn INTEGER,             -- 어떤 턴에서 변화가 발생했는지
  triggered_by_fact_key TEXT,            -- 어떤 fact에 의해 변화했는지
  
  -- 상태
  status TEXT NOT NULL CHECK(status IN (
    'new',                               -- 새로 생성됨
    'strengthened',                      -- 신뢰도 상승
    'weakened',                          -- 신뢰도 하락
    'unchanged',                         -- 변화 없음
    'invalidated'                        -- 무효화됨 (모순 발견)
  )),
  
  -- 메타
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_hypothesis_session ON hypothesis_history(session_id);
CREATE INDEX IF NOT EXISTS idx_hypothesis_user ON hypothesis_history(user_id);
CREATE INDEX IF NOT EXISTS idx_hypothesis_id ON hypothesis_history(hypothesis_id);
CREATE INDEX IF NOT EXISTS idx_hypothesis_status ON hypothesis_history(status);





