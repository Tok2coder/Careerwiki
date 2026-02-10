-- src/services/ai-analyzer/migrations/013_ai_analysis_results_add_resume_id.sql
-- P0-5: ALTER TABLE은 컬럼별로 분리된 마이그레이션 파일로 실행
-- P0-6: REFERENCES 제거 (D1에서 FK 기대 금지, 논리 FK만 사용)

ALTER TABLE ai_analysis_results ADD COLUMN resume_id INTEGER;
