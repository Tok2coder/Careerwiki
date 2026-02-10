-- src/services/ai-analyzer/migrations/015_ai_analysis_results_add_key_decision_variables.sql
-- P0-5: ALTER TABLE은 컬럼별로 분리된 마이그레이션 파일로 실행

ALTER TABLE ai_analysis_results ADD COLUMN key_decision_variables TEXT;
