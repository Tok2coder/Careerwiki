# D1 데이터베이스 구조 분석 보고서

**생성일**: 2025-01-06  
**데이터베이스 ID**: `edc21e23-c2ac-4693-bb79-389b6914e173`  
**데이터베이스명**: `careerwiki-jobs`

---

## 📊 **전체 구조 개요**

D1 데이터베이스는 **3계층 아키텍처**로 구성되어 있습니다:

```
┌─────────────────────────────────────────┐
│  Layer 1: 캐시 레이어 (wiki_pages)      │
│  - 렌더링된 HTML 저장                    │
│  - 템플릿 버전 관리                      │
└─────────────────────────────────────────┘
              ↑
┌─────────────────────────────────────────┐
│  Layer 2: 데이터 레이어 (jobs/majors)   │
│  - API 원본 데이터 (JSON)                │
│  - 사용자 기여 데이터                     │
│  - 운영진 데이터                         │
└─────────────────────────────────────────┘
              ↑
┌─────────────────────────────────────────┐
│  Layer 3: 메타데이터 레이어              │
│  - 댓글, 로그, 분석 등                   │
└─────────────────────────────────────────┘
```

---

## 🗄️ **핵심 테이블 상세 분석**

### **1. `jobs` 테이블 - 직업 데이터**

**구조**: 각 직업별로 **1개 레코드** 저장

```sql
CREATE TABLE jobs (
    -- 기본 식별자
    id TEXT PRIMARY KEY,                    -- 예: "354", "G_K000007482"
    careernet_id TEXT,                      -- CareerNet 직업 ID (nullable)
    goyong24_id TEXT,                       -- Goyong24 직업 ID (nullable)
    name TEXT NOT NULL,                     -- 직업명 (예: "간호사")
    
    -- API 데이터 (자동 업데이트, 2주 주기)
    api_data_json TEXT,                     -- 통합 JSON 데이터
    api_data_hash TEXT,                     -- SHA-256 해시 (변경 감지용)
    api_last_fetched_at INTEGER,            -- 마지막 API 호출 시각 (Unix timestamp)
    api_last_updated_at INTEGER,            -- API 데이터 실제 변경 시각
    
    -- 사용자 기여 데이터 (수동 관리, API 업데이트 시 보존)
    user_contributed_json TEXT,             -- 사용자가 추가한 정보 (JSON)
    user_last_updated_at INTEGER,          -- 사용자 데이터 마지막 수정 시각
    
    -- 운영진 데이터 (최우선, 수동 관리)
    admin_data_json TEXT,                  -- 운영진이 추가한 정보 (JSON)
    admin_last_updated_at INTEGER,         -- 운영진 데이터 마지막 수정 시각
    
    -- 메타데이터
    created_at INTEGER NOT NULL,           -- 레코드 생성 시각
    is_active INTEGER DEFAULT 1            -- 활성화 여부 (0=비활성)
);
```

**인덱스**:
```sql
CREATE INDEX idx_jobs_name ON jobs(name);
CREATE INDEX idx_jobs_careernet_id ON jobs(careernet_id);
CREATE INDEX idx_jobs_is_active ON jobs(is_active);
```

**데이터 우선순위**:
```
운영진 데이터 (admin_data_json) 
  > 사용자 기여 데이터 (user_contributed_json) 
  > API 데이터 (api_data_json)
```

**현재 데이터 현황**:
- 총 직업 레코드: **980개**
  - CareerNet 직업: 443개
  - Goyong24 직업: 537개
- 각 직업은 **1개 레코드**로 저장됨
- `api_data_json`에는 통합된 `UnifiedJobDetail` 객체가 JSON으로 저장됨

**api_data_json 구조 예시**:
```json
{
  "careernet": { /* CareerNet 원본 API 응답 */ },
  "goyong24": { /* Goyong24 원본 API 응답 */ },
  "merged": { /* UnifiedJobDetail 통합 객체 */ },
  "sources": ["CAREERNET", "GOYONG24"]
}
```

---

### **2. `majors` 테이블 - 전공 데이터**

**구조**: 각 전공별로 **1개 레코드** 저장

```sql
CREATE TABLE majors (
    -- 기본 식별자
    id TEXT PRIMARY KEY,                    -- 예: "123", "G_12345_컴퓨터공학과"
    careernet_id TEXT,                      -- CareerNet majorSeq (nullable)
    goyong24_id TEXT,                       -- Goyong24 ID (nullable)
    name TEXT NOT NULL,                     -- 학과명 (예: "컴퓨터공학과")
    
    -- API 데이터 (자동 업데이트, 2주 주기)
    api_data_json TEXT,                     -- 통합 JSON 데이터
    api_data_hash TEXT,                     -- SHA-256 해시 (변경 감지용)
    api_last_fetched_at INTEGER,            -- 마지막 API 호출 시각
    api_last_updated_at INTEGER,             -- API 데이터 실제 변경 시각
    
    -- 사용자 기여 데이터 (수동 관리)
    user_contributed_json TEXT,             -- 사용자가 추가한 정보 (JSON)
    user_last_updated_at INTEGER,          -- 사용자 데이터 마지막 수정 시각
    
    -- 운영진 데이터 (최우선)
    admin_data_json TEXT,                  -- 운영진이 추가한 정보 (JSON)
    admin_last_updated_at INTEGER,         -- 운영진 데이터 마지막 수정 시각
    
    -- 메타데이터
    created_at INTEGER NOT NULL,           -- 레코드 생성 시각
    is_active INTEGER DEFAULT 1            -- 활성화 여부 (0=비활성)
);
```

**인덱스**:
```sql
CREATE INDEX idx_majors_name ON majors(name);
```

**현재 데이터 현황**:
- 총 전공 레코드: **1,427개**
  - CareerNet 전공: 504개
  - Goyong24 전공: 923개
- 각 전공은 **1개 레코드**로 저장됨
- `api_data_json`에는 통합된 `UnifiedMajorDetail` 객체가 JSON으로 저장됨

**api_data_json 구조 예시**:
```json
{
  "careernet": { /* CareerNet 원본 API 응답 */ },
  "goyong24": { /* Goyong24 원본 API 응답 */ },
  "merged": { /* UnifiedMajorDetail 통합 객체 */ },
  "sources": ["CAREERNET"] 또는 ["GOYONG24"]
}
```

---

### **3. `wiki_pages` 테이블 - ISR 캐시 레이어**

**구조**: 각 페이지별로 **1개 레코드** 저장 (렌더링된 HTML)

```sql
CREATE TABLE wiki_pages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    
    -- 페이지 식별자
    slug TEXT NOT NULL,                     -- URL 슬러그 (예: "computer-science")
    page_type TEXT NOT NULL                 -- 페이지 타입 ('job', 'major', 'guide')
        CHECK(page_type IN ('job', 'major', 'guide')),
    
    -- 캐시 데이터
    content TEXT NOT NULL,                  -- 완성된 HTML 문서 (최대 2MB)
    cache_version INTEGER NOT NULL,         -- 템플릿 버전 번호 (자동 무효화용)
    
    -- 메타데이터
    title TEXT NOT NULL,                    -- 페이지 제목
    description TEXT,                       -- SEO 메타 설명
    og_image_url TEXT,                     -- Open Graph 이미지 URL
    
    -- 타임스탬프
    created_at INTEGER NOT NULL DEFAULT (unixepoch()),  -- Unix timestamp (초)
    updated_at INTEGER NOT NULL DEFAULT (unixepoch()),  -- Unix timestamp (초)
    
    -- 제약조건
    UNIQUE(slug, page_type)                 -- 같은 slug+page_type 조합은 1개만
);
```

**인덱스**:
```sql
CREATE INDEX idx_wiki_pages_lookup 
    ON wiki_pages(slug, page_type, cache_version);
CREATE INDEX idx_wiki_pages_type 
    ON wiki_pages(page_type);
CREATE INDEX idx_wiki_pages_updated 
    ON wiki_pages(updated_at DESC);
```

**동작 방식**:
1. 사용자가 `/major/computer-science` 요청
2. `wiki_pages`에서 `slug='computer-science' AND page_type='major'` 조회
3. `cache_version`이 현재 템플릿 버전과 일치하면 → 캐시 히트 (50ms)
4. 버전 불일치 또는 캐시 없음 → `majors` 테이블에서 데이터 조회 → 렌더링 → `wiki_pages` 저장

**캐시 무효화**:
- 템플릿 코드 수정 시 `template-versions.ts`에서 버전 번호 증가
- 다음 요청 시 자동으로 새 HTML 생성

---

### **4. `update_logs` 테이블 - 업데이트 추적**

**구조**: 각 업데이트마다 **1개 레코드** 추가

```sql
CREATE TABLE update_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id TEXT NOT NULL,                   -- 직업 ID (majors는 NULL)
    update_type TEXT NOT NULL,              -- 'api', 'user', 'admin'
    changed_fields TEXT,                    -- JSON array: ["salary", "duties"]
    old_hash TEXT,                          -- 이전 해시값
    new_hash TEXT,                          -- 새 해시값
    updated_at INTEGER NOT NULL,            -- 업데이트 시각
    updated_by TEXT                         -- 'cron', 'user:123', 'admin:456'
);
```

**인덱스**:
```sql
CREATE INDEX idx_logs_job_id ON update_logs(job_id);
CREATE INDEX idx_logs_updated_at ON update_logs(updated_at);
```

**용도**: 
- API 자동 업데이트 시 변경된 필드 추적
- 사용자/운영진 수정 이력 관리

---

### **5. `comments` 테이블 - 댓글 시스템**

**구조**: 각 댓글마다 **1개 레코드**

```sql
CREATE TABLE comments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    page_id INTEGER NOT NULL,               -- pages 테이블 참조 (구버전)
    parent_id INTEGER,                      -- 대댓글용 (부모 댓글 ID)
    nickname TEXT DEFAULT '익명',
    content TEXT NOT NULL,
    ip_hash TEXT,                           -- IP 해시 (개인정보 보호)
    likes INTEGER DEFAULT 0,
    flagged BOOLEAN DEFAULT 0,
    
    -- 추가 컬럼 (0003_comment_policy.sql)
    author_id TEXT,                         -- 작성자 ID
    is_anonymous INTEGER DEFAULT 0,
    display_ip TEXT,                        -- 표시용 IP (마스킹됨)
    status TEXT DEFAULT 'visible',          -- 'visible', 'blinded', 'deleted'
    dislike_count INTEGER DEFAULT 0,
    report_count INTEGER DEFAULT 0,
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE
);
```

---

### **6. `comment_votes` 테이블 - 댓글 좋아요/싫어요**

```sql
CREATE TABLE comment_votes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    comment_id INTEGER NOT NULL,
    user_id TEXT NOT NULL,
    vote INTEGER NOT NULL CHECK(vote IN (-1, 1)),  -- -1=싫어요, 1=좋아요
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(comment_id, user_id),            -- 사용자당 1개만
    FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
);
```

---

### **7. `comment_reports` 테이블 - 댓글 신고**

```sql
CREATE TABLE comment_reports (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    comment_id INTEGER NOT NULL,
    reporter_id TEXT NOT NULL,
    reporter_ip_hash TEXT,
    reason TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
);
```

---

### **8. `ip_blocks` 테이블 - IP 차단 관리**

```sql
CREATE TABLE ip_blocks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ip_hash TEXT NOT NULL UNIQUE,
    reason TEXT,
    status TEXT DEFAULT 'active' CHECK(status IN ('active', 'released')),
    blocked_by TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    released_at DATETIME
);
```

---

### **9. AI 분석 관련 테이블들**

#### `ai_sessions` - 사용자 세션
```sql
CREATE TABLE ai_sessions (
    id TEXT PRIMARY KEY,
    user_identifier TEXT,                   -- 이메일 또는 익명 세션 ID
    traits_snapshot TEXT,                   -- MBTI/흥미/가치관 JSON
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_active_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

#### `ai_analysis_requests` - 분석 요청
```sql
CREATE TABLE ai_analysis_requests (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id TEXT NOT NULL,
    analysis_type TEXT NOT NULL CHECK(analysis_type IN ('job', 'major')),
    pricing_tier TEXT DEFAULT 'free' CHECK(pricing_tier IN ('free', 'pro')),
    prompt_payload TEXT NOT NULL,
    status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'processing', 'completed', 'failed')),
    requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    processed_at DATETIME,
    FOREIGN KEY (session_id) REFERENCES ai_sessions(id) ON DELETE CASCADE
);
```

#### `ai_analysis_results` - 분석 결과
```sql
CREATE TABLE ai_analysis_results (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    request_id INTEGER NOT NULL,
    provider TEXT NOT NULL,                 -- 'anthropic', 'openai'
    model TEXT,
    completion_tokens INTEGER,
    prompt_tokens INTEGER,
    total_tokens INTEGER,
    latency_ms INTEGER,
    response_summary TEXT,
    response_payload TEXT NOT NULL,         -- 전체 JSON 응답
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (request_id) REFERENCES ai_analysis_requests(id) ON DELETE CASCADE
);
```

---

### **10. 검색 상호작용 로그 테이블들**

#### `serp_interaction_logs` - 검색 상호작용 로그
```sql
CREATE TABLE serp_interaction_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major')),
    action TEXT NOT NULL,                   -- 'sort-change', 'filter-submit', 'per-page-change'
    keyword_length INTEGER,
    category TEXT,
    per_page INTEGER,
    results INTEGER,
    cache_status TEXT,
    duration_ms INTEGER,
    sampled BOOLEAN DEFAULT 1,
    source TEXT DEFAULT 'hydration',
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

#### `serp_interaction_daily_summary` - 일일 집계
```sql
CREATE TABLE serp_interaction_daily_summary (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    log_date TEXT NOT NULL,                -- YYYY-MM-DD
    page_type TEXT NOT NULL,
    action TEXT NOT NULL,
    samples INTEGER DEFAULT 0,
    avg_duration_ms REAL,
    avg_results REAL,
    cache_hit_ratio REAL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(log_date, page_type, action)
);
```

---

## 🔑 **핵심 질문에 대한 답변**

### **Q1: 전공은 전공별로 되어있는지?**

✅ **예, 맞습니다!**
- `majors` 테이블에 각 전공이 **1개 레코드**로 저장됨
- `id`가 PRIMARY KEY로 각 전공을 고유하게 식별
- 현재 **1,427개 전공** 레코드 존재
- 각 레코드에는 해당 전공의 모든 정보가 `api_data_json`에 JSON으로 저장됨

**예시**:
```
id: "123"
name: "컴퓨터공학과"
api_data_json: { "careernet": {...}, "goyong24": {...}, "merged": {...} }
```

---

### **Q2: 직업은 직업별로 나뉘어져 있는지?**

✅ **예, 맞습니다!**
- `jobs` 테이블에 각 직업이 **1개 레코드**로 저장됨
- `id`가 PRIMARY KEY로 각 직업을 고유하게 식별
- 현재 **980개 직업** 레코드 존재
- 각 레코드에는 해당 직업의 모든 정보가 `api_data_json`에 JSON으로 저장됨

**예시**:
```
id: "354"
name: "간호사"
api_data_json: { "careernet": {...}, "goyong24": {...}, "merged": {...} }
```

---

### **Q3: 데이터는 어떻게 저장되는가?**

**3계층 구조**:

1. **원본 데이터** (`jobs`/`majors` 테이블)
   - API에서 받은 원본 데이터를 JSON으로 저장
   - 해시값으로 변경 감지
   - 사용자/운영진 수정 데이터도 별도 컬럼에 저장

2. **통합 데이터** (`api_data_json` 내부)
   - `careernet` + `goyong24` 데이터가 병합된 `merged` 객체
   - 통합 로직은 `src/services/profileMerge.ts`에서 처리

3. **렌더링된 HTML** (`wiki_pages` 테이블)
   - `majors`/`jobs` 데이터를 템플릿으로 렌더링한 완성 HTML
   - 템플릿 버전과 함께 저장되어 자동 무효화

---

## 📈 **데이터 흐름 다이어그램**

```
사용자 요청: /major/computer-science
    ↓
1. wiki_pages 조회 (캐시 확인)
    ├─ 캐시 히트 + 버전 일치 → HTML 반환 (50ms) ✅
    └─ 캐시 미스 또는 버전 불일치 → 2단계로
        ↓
2. majors 테이블 조회
    ├─ id로 조회 → api_data_json 파싱
    ├─ user_contributed_json 병합
    └─ admin_data_json 병합
        ↓
3. 템플릿 렌더링
    ├─ UnifiedMajorDetail → HTML 변환
    └─ wiki_pages에 저장 (다음 요청용)
        ↓
4. HTML 반환 (300ms)
```

---

## 🔄 **자동 업데이트 프로세스**

### **2주 주기 업데이트 (Cron)**

```
매월 1일, 15일 새벽 2시:
    ↓
1. 모든 활성 jobs/majors ID 조회
    ↓
2. 각 ID마다:
    ├─ API 호출 (CareerNet + Goyong24)
    ├─ 해시 생성 (SHA-256)
    ├─ 기존 해시와 비교
    │   ├─ 같음 → last_fetched_at만 갱신 (변경 없음)
    │   └─ 다름 → 업데이트 진행
    │       ├─ api_data_json 업데이트
    │       ├─ api_data_hash 업데이트
    │       ├─ api_last_updated_at 갱신
    │       └─ update_logs에 기록
    └─ user_contributed_json, admin_data_json은 절대 건드리지 않음
```

---

## 📊 **현재 데이터 현황 요약**

| 테이블 | 레코드 수 | 설명 |
|--------|----------|------|
| `jobs` | 980개 | 각 직업별 1개 레코드 |
| `majors` | 1,427개 | 각 전공별 1개 레코드 |
| `wiki_pages` | ~2,000개 (추정) | 렌더링된 HTML 캐시 |
| `update_logs` | 수백~수천개 | 업데이트 이력 |
| `comments` | - | 댓글 (현재 사용 안 함) |
| `ai_sessions` | - | AI 분석 세션 |
| `serp_interaction_logs` | - | 검색 상호작용 로그 |

**총 데이터**: 약 **2,407개** 핵심 레코드 (jobs + majors)

---

## ✅ **결론**

1. ✅ **전공은 전공별로 저장됨**: `majors` 테이블에 각 전공 1개 레코드
2. ✅ **직업은 직업별로 저장됨**: `jobs` 테이블에 각 직업 1개 레코드
3. ✅ **데이터 구조가 명확함**: 3계층 아키텍처 (캐시 → 데이터 → 메타데이터)
4. ✅ **자동 업데이트 시스템**: 해시 기반 변경 감지로 효율적 관리
5. ✅ **데이터 보호**: 사용자/운영진 데이터는 API 업데이트 시 보존됨

**현재 구조는 매우 잘 설계되어 있으며, 확장 가능하고 유지보수하기 좋은 구조입니다!** 🎯

