-- Pages table for wiki content
CREATE TABLE IF NOT EXISTS pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major', 'guide')),
  content TEXT NOT NULL, -- Markdown content
  summary TEXT,
  meta_data TEXT, -- JSON string for additional metadata
  view_count INTEGER DEFAULT 0,
  status TEXT DEFAULT 'published' CHECK(status IN ('published', 'draft', 'deleted')),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Comments table
CREATE TABLE IF NOT EXISTS comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  parent_id INTEGER, -- For nested comments
  nickname TEXT DEFAULT '익명',
  content TEXT NOT NULL,
  ip_hash TEXT,
  likes INTEGER DEFAULT 0,
  flagged BOOLEAN DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE,
  FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE
);

-- Career analysis records
CREATE TABLE IF NOT EXISTS career_analyses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_email TEXT,
  user_name TEXT,
  analysis_data TEXT NOT NULL, -- JSON string with full analysis
  report_type TEXT CHECK(report_type IN ('basic', 'professional', 'premium')),
  payment_status TEXT DEFAULT 'pending',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Search index table
CREATE TABLE IF NOT EXISTS search_index (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  content TEXT NOT NULL, -- Searchable text content
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);

-- Page revisions for version history
CREATE TABLE IF NOT EXISTS page_revisions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  content TEXT NOT NULL,
  editor_ip TEXT,
  change_summary TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_pages_slug ON pages(slug);
CREATE INDEX IF NOT EXISTS idx_pages_type ON pages(page_type);
CREATE INDEX IF NOT EXISTS idx_pages_status ON pages(status);
CREATE INDEX IF NOT EXISTS idx_comments_page_id ON comments(page_id);
CREATE INDEX IF NOT EXISTS idx_search_content ON search_index(content);

-- Insert sample data
INSERT OR IGNORE INTO pages (slug, title, page_type, content, summary, meta_data) VALUES
('software-engineer', '소프트웨어 엔지니어', 'job', 
'## 개요
소프트웨어 엔지니어는 컴퓨터 프로그램과 애플리케이션을 설계, 개발, 테스트하는 전문가입니다.

## 주요 업무
- 소프트웨어 요구사항 분석 및 설계
- 프로그래밍 언어를 사용한 코드 작성
- 버그 수정 및 성능 최적화
- 기술 문서 작성 및 코드 리뷰
- 팀 협업 및 프로젝트 관리

## 필요 역량
- Python, Java, JavaScript 등 프로그래밍 언어
- 자료구조와 알고리즘
- 데이터베이스 설계 및 관리
- Git 등 버전 관리 시스템
- 문제 해결 능력과 논리적 사고

## 관련 학과
- 컴퓨터공학과
- 소프트웨어학과
- 정보통신공학과
- 전산학과',
'소프트웨어를 설계, 개발, 유지보수하는 IT 전문가',
'{"avgSalary": "6500", "growth": "high", "difficulty": "medium-high"}'
),

('data-scientist', '데이터 사이언티스트', 'job',
'## 개요
데이터 사이언티스트는 대량의 데이터를 수집, 처리, 분석하여 비즈니스 인사이트를 도출하는 전문가입니다.

## 주요 업무
- 데이터 수집 및 전처리
- 통계 분석 및 머신러닝 모델 개발
- 데이터 시각화 및 리포트 작성
- A/B 테스팅 및 실험 설계
- 비즈니스 의사결정 지원

## 필요 역량
- Python, R 등 프로그래밍 언어
- 통계학 및 머신러닝 지식
- SQL 및 데이터베이스
- 데이터 시각화 도구
- 비즈니스 이해도',
'데이터를 분석하여 인사이트를 도출하는 전문가',
'{"avgSalary": "7000", "growth": "very-high", "difficulty": "high"}'
),

('product-manager', '프로덕트 매니저', 'job',
'## 개요
프로덕트 매니저는 제품의 전략, 로드맵, 기능을 정의하고 개발 팀과 협업하여 제품을 시장에 출시하는 역할을 합니다.

## 주요 업무
- 제품 비전 및 전략 수립
- 사용자 리서치 및 요구사항 분석
- 제품 로드맵 관리
- 개발팀과의 협업
- 제품 성과 분석 및 개선

## 필요 역량
- 제품 전략 및 기획 능력
- 데이터 분석 능력
- 커뮤니케이션 스킬
- 프로젝트 관리
- 비즈니스 감각',
'제품 전략과 개발을 총괄하는 관리자',
'{"avgSalary": "8000", "growth": "high", "difficulty": "high"}'
),

('computer-science', '컴퓨터공학과', 'major',
'## 개요
컴퓨터공학과는 컴퓨터 시스템의 하드웨어와 소프트웨어를 연구하는 학과입니다.

## 주요 교과목
- 자료구조와 알고리즘
- 운영체제
- 데이터베이스
- 컴퓨터 네트워크
- 소프트웨어 공학

## 진로 전망
- 소프트웨어 개발자
- 시스템 엔지니어
- 데이터 사이언티스트
- AI 엔지니어
- 보안 전문가',
'컴퓨터 시스템과 소프트웨어를 연구하는 학과',
'{"employmentRate": "95", "popularity": "very-high"}'
);

-- Insert sample comments
INSERT OR IGNORE INTO comments (page_id, nickname, content) VALUES
(1, '현직자A', '실제로 일해보니 문제 해결 능력이 가장 중요한 것 같아요. 기술은 계속 바뀌지만 문제를 분석하고 해결하는 능력은 변하지 않습니다.'),
(1, '취준생B', '정말 도움이 되는 정보네요. 포트폴리오 준비하는데 참고하겠습니다!'),
(2, '데이터분석가', 'SQL 능력이 정말 중요합니다. 처음 시작하시는 분들은 SQL부터 탄탄히 다지세요.');