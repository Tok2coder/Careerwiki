-- src/services/ai-analyzer/migrations/016_ai_analysis_results_add_scoring_trace.sql
-- P1-1: scoring_trace 추가 (결정변수 산출용)

ALTER TABLE ai_analysis_results ADD COLUMN scoring_trace_json TEXT;
