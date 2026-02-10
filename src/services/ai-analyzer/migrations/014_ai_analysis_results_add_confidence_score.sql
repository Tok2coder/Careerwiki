-- src/services/ai-analyzer/migrations/014_ai_analysis_results_add_confidence_score.sql
-- P0-5: ALTER TABLE은 컬럼별로 분리된 마이그레이션 파일로 실행

ALTER TABLE ai_analysis_results ADD COLUMN confidence_score REAL;
