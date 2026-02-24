-- 버전 관리: AI 분석 요청에 버전 추적 컬럼 추가
-- parent_request_id: NULL이면 최초 분석, 값이 있으면 재분석
-- version_number: 같은 분석 체인에서의 순서 (1, 2, 3, ...)
-- version_note: UI에 표시할 버전 설명 ("입력 수정", "내용 추가: ..." 등)

ALTER TABLE ai_analysis_requests ADD COLUMN parent_request_id INTEGER REFERENCES ai_analysis_requests(id);
ALTER TABLE ai_analysis_requests ADD COLUMN version_number INTEGER DEFAULT 1;
ALTER TABLE ai_analysis_requests ADD COLUMN version_note TEXT;

-- 버전 조회 최적화 인덱스
CREATE INDEX IF NOT EXISTS idx_requests_parent ON ai_analysis_requests(parent_request_id);
