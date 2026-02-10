-- src/services/ai-analyzer/migrations/011_ai_analysis_results_add_career_state.sql
-- P0-5: ALTER TABLE은 컬럼별로 분리된 마이그레이션 파일로 실행

ALTER TABLE ai_analysis_results ADD COLUMN career_state_json TEXT;
