-- ============================================
-- CareerWiki 정적 위키 페이지 아키텍처
-- ============================================

-- 1. 위키 페이지 메인 테이블 (완전한 HTML 저장)
CREATE TABLE IF NOT EXISTS wiki_pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 기본 정보
  slug TEXT UNIQUE NOT NULL,                    -- URL 슬러그 (예: "컴퓨터공학과")
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major')),
  title TEXT NOT NULL,                          -- 페이지 제목
  
  -- 완전한 HTML 콘텐츠 (렌더링된 최종 버전)
  content TEXT NOT NULL,                        -- 완전한 HTML 페이지
  
  -- 섹션 메타데이터 (JSON)
  -- 각 섹션의 데이터 출처와 마지막 업데이트 시간 추적
  -- 예: {
  --   "overview": { "source": "API", "last_updated": 1234567890 },
  --   "universities": { "source": "API", "last_updated": 1234567890 },
  --   "reviews": { "source": "USER", "last_updated": 1234567890 },
  --   "career_path": { "source": "AI", "last_updated": 1234567890 }
  -- }
  sections_meta TEXT,
  
  -- 원본 데이터 참조 (빠른 재생성을 위해)
  careernet_id TEXT,
  goyong24_id TEXT,
  
  -- SEO & 메타데이터
  meta_title TEXT,
  meta_description TEXT,
  canonical_url TEXT,
  
  -- 버전 관리
  version INTEGER DEFAULT 1,
  
  -- 통계
  view_count INTEGER DEFAULT 0,
  contribution_count INTEGER DEFAULT 0,         -- 사용자 기여 횟수
  
  -- 상태
  status TEXT DEFAULT 'published' CHECK(status IN ('published', 'draft', 'archived')),
  
  -- 타임스탬프
  created_at INTEGER NOT NULL,                  -- Unix timestamp
  updated_at INTEGER NOT NULL,                  -- Unix timestamp
  last_api_sync_at INTEGER,                     -- 마지막 API 동기화 시간
  
  -- 인덱스
  UNIQUE(slug)
);

CREATE INDEX idx_wiki_pages_type ON wiki_pages(page_type);
CREATE INDEX idx_wiki_pages_status ON wiki_pages(status);
CREATE INDEX idx_wiki_pages_updated ON wiki_pages(updated_at);

-- 2. API 데이터 원본 저장소 (현재 majors/jobs 테이블 역할)
CREATE TABLE IF NOT EXISTS api_data_cache (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  entity_type TEXT NOT NULL CHECK(entity_type IN ('job', 'major')),
  entity_id TEXT NOT NULL,                      -- 커리어넷 ID 또는 고용24 ID
  
  source TEXT NOT NULL CHECK(source IN ('CAREERNET', 'GOYONG24')),
  
  -- 원본 API 응답 (JSON)
  raw_data TEXT NOT NULL,
  
  -- 정규화된 데이터 (UnifiedMajorDetail / UnifiedJobDetail)
  normalized_data TEXT NOT NULL,
  
  -- 데이터 무결성
  data_hash TEXT NOT NULL,
  
  -- 타임스탬프
  fetched_at INTEGER NOT NULL,
  expires_at INTEGER,                           -- 캐시 만료 시간
  
  UNIQUE(entity_type, entity_id, source)
);

CREATE INDEX idx_api_cache_entity ON api_data_cache(entity_type, entity_id);
CREATE INDEX idx_api_cache_expires ON api_data_cache(expires_at);

-- 3. 사용자 기여 데이터
CREATE TABLE IF NOT EXISTS user_contributions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  page_slug TEXT NOT NULL,
  section_name TEXT NOT NULL,                   -- 예: "reviews", "tips", "courses"
  
  -- 기여 내용
  contribution_type TEXT NOT NULL CHECK(contribution_type IN (
    'review',           -- 졸업생 후기
    'tip',             -- 학습 팁
    'course',          -- 추천 강좌
    'resource',        -- 추천 자료
    'correction',      -- 정보 수정
    'addition'         -- 정보 추가
  )),
  
  content TEXT NOT NULL,                        -- 기여 내용 (Markdown)
  
  -- 기여자 정보
  user_id INTEGER,                              -- 로그인 유저 (향후)
  user_nickname TEXT DEFAULT '익명',
  user_ip_hash TEXT,                            -- 익명 기여 추적용
  
  -- 상태
  status TEXT DEFAULT 'pending' CHECK(status IN (
    'pending',         -- 검토 대기
    'approved',        -- 승인됨
    'rejected',        -- 거부됨
    'archived'         -- 아카이브됨
  )),
  
  -- 투표
  upvotes INTEGER DEFAULT 0,
  downvotes INTEGER DEFAULT 0,
  
  -- 관리자 검토
  reviewed_by INTEGER,                          -- 관리자 ID
  review_note TEXT,
  reviewed_at INTEGER,
  
  -- 타임스탬프
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  
  FOREIGN KEY (page_slug) REFERENCES wiki_pages(slug) ON DELETE CASCADE
);

CREATE INDEX idx_contributions_page ON user_contributions(page_slug);
CREATE INDEX idx_contributions_status ON user_contributions(status);
CREATE INDEX idx_contributions_type ON user_contributions(contribution_type);

-- 4. AI 생성 데이터
CREATE TABLE IF NOT EXISTS ai_generated_content (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  page_slug TEXT NOT NULL,
  section_name TEXT NOT NULL,                   -- 예: "career_path", "skills", "salary_forecast"
  
  -- AI 생성 내용
  content_type TEXT NOT NULL CHECK(content_type IN (
    'career_path',     -- AI 생성 진로 경로
    'skills',          -- AI 추천 스킬
    'salary_forecast', -- AI 연봉 예측
    'job_outlook',     -- AI 취업 전망
    'study_plan'       -- AI 학습 계획
  )),
  
  content TEXT NOT NULL,                        -- 생성된 콘텐츠 (HTML/Markdown)
  
  -- AI 메타데이터
  model TEXT NOT NULL,                          -- 예: "gpt-4", "claude-3"
  prompt_hash TEXT,                             -- 프롬프트 해시 (재생성 감지)
  confidence_score REAL,                        -- 신뢰도 (0.0 ~ 1.0)
  
  -- 검증 상태
  status TEXT DEFAULT 'pending' CHECK(status IN (
    'pending',         -- 검토 대기
    'approved',        -- 승인됨
    'rejected',        -- 거부됨
    'regenerating'     -- 재생성 중
  )),
  
  verified_by INTEGER,                          -- 관리자 ID
  verified_at INTEGER,
  
  -- 타임스탬프
  generated_at INTEGER NOT NULL,
  expires_at INTEGER,                           -- 재생성 필요 시점
  
  FOREIGN KEY (page_slug) REFERENCES wiki_pages(slug) ON DELETE CASCADE
);

CREATE INDEX idx_ai_content_page ON ai_generated_content(page_slug);
CREATE INDEX idx_ai_content_status ON ai_generated_content(status);
CREATE INDEX idx_ai_content_expires ON ai_generated_content(expires_at);

-- 5. 페이지 변경 이력 (감사 로그)
CREATE TABLE IF NOT EXISTS page_revisions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  page_slug TEXT NOT NULL,
  version INTEGER NOT NULL,
  
  -- 변경 내용
  change_type TEXT NOT NULL CHECK(change_type IN (
    'api_sync',        -- API 데이터 동기화
    'user_contribution',  -- 사용자 기여 반영
    'ai_generation',   -- AI 콘텐츠 추가
    'admin_edit',      -- 관리자 수정
    'template_update'  -- 템플릿 업데이트
  )),
  
  sections_changed TEXT,                        -- 변경된 섹션 목록 (JSON 배열)
  
  -- 변경 전 콘텐츠 (필요시 복구용)
  previous_content TEXT,
  
  -- 변경자 정보
  changed_by TEXT,                              -- "API", "USER:123", "AI", "ADMIN:456"
  change_summary TEXT,
  
  -- 타임스탬프
  created_at INTEGER NOT NULL,
  
  FOREIGN KEY (page_slug) REFERENCES wiki_pages(slug) ON DELETE CASCADE
);

CREATE INDEX idx_revisions_page ON page_revisions(page_slug, version);
CREATE INDEX idx_revisions_type ON page_revisions(change_type);

-- 6. 페이지 업데이트 큐 (비동기 처리용)
CREATE TABLE IF NOT EXISTS page_update_queue (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  page_slug TEXT NOT NULL,
  update_type TEXT NOT NULL CHECK(update_type IN (
    'api_sync',
    'user_contribution',
    'ai_generation',
    'template_refresh'
  )),
  
  -- 업데이트할 섹션
  sections_to_update TEXT,                      -- JSON 배열
  
  -- 우선순위
  priority INTEGER DEFAULT 5,                   -- 1 (highest) ~ 10 (lowest)
  
  -- 상태
  status TEXT DEFAULT 'pending' CHECK(status IN (
    'pending',
    'processing',
    'completed',
    'failed'
  )),
  
  -- 처리 정보
  attempts INTEGER DEFAULT 0,
  last_error TEXT,
  
  -- 타임스탬프
  created_at INTEGER NOT NULL,
  started_at INTEGER,
  completed_at INTEGER,
  
  FOREIGN KEY (page_slug) REFERENCES wiki_pages(slug) ON DELETE CASCADE
);

CREATE INDEX idx_update_queue_status ON page_update_queue(status, priority);

-- ============================================
-- 샘플 데이터 (예시)
-- ============================================

-- 컴퓨터공학과 위키 페이지
INSERT OR IGNORE INTO wiki_pages (
  slug, page_type, title, content, sections_meta,
  careernet_id, goyong24_id,
  meta_title, meta_description,
  version, created_at, updated_at
) VALUES (
  '컴퓨터공학과',
  'major',
  '컴퓨터공학과',
  '<html>...</html>',  -- 완전한 HTML 페이지
  '{"overview": {"source": "API", "last_updated": 1234567890}}',
  '569',
  NULL,
  '컴퓨터공학과 - CareerWiki',
  '컴퓨터공학과의 교육과정, 취업 정보, 추천 대학 정보를 확인하세요.',
  1,
  strftime('%s', 'now'),
  strftime('%s', 'now')
);
