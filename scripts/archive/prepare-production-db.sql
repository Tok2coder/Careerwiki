-- Production DB 초기화 스크립트
-- ⚠️ 기존 데이터 삭제됨 (Production jobs=0이므로 안전)

PRAGMA foreign_keys = OFF;

-- 기존 테이블 삭제 (시스템 테이블 제외)
DROP TABLE IF EXISTS update_logs;
DROP TABLE IF EXISTS serp_interaction_logs;
DROP TABLE IF EXISTS serp_interaction_daily_summary;
DROP TABLE IF EXISTS search_index;
DROP TABLE IF EXISTS page_revisions;
DROP TABLE IF EXISTS pages;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS ip_blocks;
DROP TABLE IF EXISTS d1_migrations;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS comment_votes;
DROP TABLE IF EXISTS comment_reports;
DROP TABLE IF EXISTS career_analyses;
DROP TABLE IF EXISTS ai_sessions;
DROP TABLE IF EXISTS ai_analysis_results;
DROP TABLE IF EXISTS ai_analysis_requests;

PRAGMA foreign_keys = ON;

