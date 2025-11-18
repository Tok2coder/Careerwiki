# Phase 4 편집 시스템 구현 계획서

**생성일**: 2025-01-XX  
**기반 문서**: Phase 4 편집 시스템 설계 종합 보고서  
**목적**: 보고서 내용을 바탕으로 오류 없이 구현하기 위한 상세 작업 계획

---

## 📋 목차

1. [요구사항 분석 및 변경사항](#요구사항-분석-및-변경사항)
2. [데이터베이스 스키마 설계](#데이터베이스-스키마-설계)
3. [API 엔드포인트 설계](#api-엔드포인트-설계)
4. [UI/UX 구현 계획](#uiux-구현-계획)
5. [보안 및 권한 구현](#보안-및-권한-구현)
6. [단계별 구현 계획](#단계별-구현-계획)
7. [테스트 계획](#테스트-계획)
8. [체크리스트](#체크리스트)

---

## 🔍 요구사항 분석 및 변경사항

### 보고서 기반 설계 vs 현재 요구사항

| 항목 | 보고서 설계 | 현재 요구사항 | 변경 필요 |
|------|-----------|-------------|----------|
| **익명 편집** | ❌ 언급 없음 | ✅ 비밀번호 기반 편집 가능 | ✅ 추가 필요 |
| **API 데이터 편집** | ❌ 관리자만 가능 | ✅ 모든 사용자 편집 가능 | ✅ 수정 필요 |
| **권한 체계** | User/Expert/Admin | Anonymous/User/Expert/Admin | ✅ 익명 추가 |
| **버전 관리** | ✅ Revision 테이블 | ✅ 버전 히스토리 시스템 (모든 버전 보존) | ✅ 수정 완료 |

### 핵심 변경사항

1. **익명 사용자 편집 지원**
   - 비밀번호 기반 권한 관리 (댓글 시스템과 동일)
   - IP 해시 기반 일일 편집 제한
   - 익명 번호 시스템 (익명 1, 익명 2 등)

2. **API 데이터 편집 허용**
   - 모든 사용자가 API 원본 데이터 편집 가능
   - 편집 시 새 revision 생성 (전체 데이터 스냅샷 저장)
   - API 원본도 하나의 revision으로 관리 (첫 번째 revision)
   - 되돌리기는 특정 revision의 스냅샷으로 복원

3. **권한 검증 로직 수정**
   - `requireAuth` Middleware 제거 (익명 허용)
   - 비밀번호 검증 로직 추가
   - 버전 히스토리 시스템으로 모든 편집 기록

---

## 🗄️ 데이터베이스 스키마 설계

### 1. 기존 테이블 수정

**⚠️ 중요**: `jobs`, `majors` 테이블에 원본 데이터 컬럼을 추가할 필요 없음  
**이유**: 버전 히스토리 시스템으로 모든 버전을 보존하므로, API 원본 데이터도 첫 번째 revision으로 저장됨

### 2. 새 테이블 생성

#### `page_revisions` 테이블 확장 (핵심: 버전 히스토리)

```sql
-- 기존 테이블 확인 필요 (migrations/0001_initial_schema.sql 참조)
-- page_revisions 테이블이 없으면 새로 생성, 있으면 확장

-- 테이블이 없는 경우 전체 생성
CREATE TABLE IF NOT EXISTS page_revisions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    
    -- 엔티티 식별 (어떤 페이지의 버전인지)
    entity_type TEXT NOT NULL CHECK(entity_type IN ('job', 'major', 'howto')),
    entity_id TEXT NOT NULL,  -- jobs.id 또는 majors.id 또는 pages.slug
    
    -- 버전 정보
    revision_number INTEGER NOT NULL,  -- 1, 2, 3... 순차 증가
    is_current INTEGER DEFAULT 0 CHECK(is_current IN (0, 1)),  -- 현재 활성 버전인지
    
    -- 편집자 정보
    editor_id TEXT,  -- users.id (익명이면 null)
    editor_type TEXT NOT NULL CHECK(editor_type IN ('anonymous', 'user', 'expert', 'admin', 'system')),
    editor_name TEXT,  -- 사용자명 또는 "익명 1" 또는 "시스템"
    password_hash TEXT,  -- 익명 편집 시 비밀번호 해시
    anonymous_number INTEGER,  -- 익명 번호
    ip_hash TEXT,  -- IP 해시 (개인정보 보호)
    
    -- 편집 내용
    change_type TEXT NOT NULL CHECK(change_type IN ('initial', 'edit', 'restore', 'merge')),
    change_summary TEXT,  -- 변경 요약
    changed_fields TEXT,  -- JSON array: ["summary", "duties"]
    
    -- 전체 데이터 스냅샷 (핵심!)
    -- API 원본 데이터도 첫 번째 revision의 snapshot에 저장됨
    data_snapshot TEXT NOT NULL,  -- 전체 JSON 데이터 (api_data_json + user_contributed_json + admin_data_json 병합 결과)
    
    -- 출처 정보
    source_url TEXT,  -- 출처 URL
    source_type TEXT CHECK(source_type IN ('website', 'academic', 'government', 'news', 'other')),
    
    -- 메타데이터
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    -- 인덱스
    UNIQUE(entity_type, entity_id, revision_number)
);

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_revisions_entity ON page_revisions(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_revisions_current ON page_revisions(entity_type, entity_id, is_current);
CREATE INDEX IF NOT EXISTS idx_revisions_editor ON page_revisions(editor_id, editor_type);
CREATE INDEX IF NOT EXISTS idx_revisions_created ON page_revisions(created_at DESC);

-- ⚠️ 중요: 기존 page_revisions 테이블이 있는 경우 마이그레이션 필요
-- 기존 구조: page_id (INTEGER) → pages 테이블만 참조
-- 새 구조: entity_type + entity_id (TEXT) → jobs, majors, pages 모두 지원

-- 마이그레이션 스크립트 (기존 데이터 처리):
-- 1. 새 컬럼 추가
ALTER TABLE page_revisions ADD COLUMN entity_type TEXT;
ALTER TABLE page_revisions ADD COLUMN entity_id TEXT;
ALTER TABLE page_revisions ADD COLUMN revision_number INTEGER;
ALTER TABLE page_revisions ADD COLUMN is_current INTEGER DEFAULT 0;
ALTER TABLE page_revisions ADD COLUMN data_snapshot TEXT;
ALTER TABLE page_revisions ADD COLUMN editor_type TEXT;
ALTER TABLE page_revisions ADD COLUMN editor_name TEXT;
ALTER TABLE page_revisions ADD COLUMN password_hash TEXT;
ALTER TABLE page_revisions ADD COLUMN anonymous_number INTEGER;
ALTER TABLE page_revisions ADD COLUMN ip_hash TEXT;
ALTER TABLE page_revisions ADD COLUMN change_type TEXT;
ALTER TABLE page_revisions ADD COLUMN changed_fields TEXT;
ALTER TABLE page_revisions ADD COLUMN source_url TEXT;
ALTER TABLE page_revisions ADD COLUMN source_type TEXT;

-- 2. 기존 데이터 마이그레이션 (page_id → entity_type + entity_id)
UPDATE page_revisions 
SET 
  entity_type = 'guide',
  entity_id = (SELECT slug FROM pages WHERE pages.id = page_revisions.page_id),
  revision_number = (
    SELECT COUNT(*) 
    FROM page_revisions pr2 
    WHERE pr2.page_id = page_revisions.page_id 
    AND pr2.created_at <= page_revisions.created_at
  ),
  is_current = CASE 
    WHEN created_at = (
      SELECT MAX(created_at) 
      FROM page_revisions pr2 
      WHERE pr2.page_id = page_revisions.page_id
    )
    THEN 1 
    ELSE 0 
  END,
  data_snapshot = json_object(
    'content', content,
    'change_summary', change_summary
  ),
  editor_type = CASE 
    WHEN user_id IS NOT NULL THEN 'user'
    ELSE 'anonymous'
  END,
  change_type = 'edit'
WHERE entity_type IS NULL;

-- 3. 제약 조건 및 인덱스 추가
CREATE UNIQUE INDEX IF NOT EXISTS idx_revisions_unique 
  ON page_revisions(entity_type, entity_id, revision_number);

CREATE INDEX IF NOT EXISTS idx_revisions_current 
  ON page_revisions(entity_type, entity_id, is_current);
```

#### `edit_conflicts` 테이블 (충돌 관리)

```sql
CREATE TABLE IF NOT EXISTS edit_conflicts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    entity_type TEXT NOT NULL CHECK(entity_type IN ('job', 'major', 'howto')),
    entity_id TEXT NOT NULL,
    revision_id INTEGER NOT NULL,  -- 충돌 발생한 revision
    editor_id TEXT,  -- 편집자 ID (익명이면 null)
    editor_type TEXT CHECK(editor_type IN ('anonymous', 'user', 'expert', 'admin')),
    conflict_data TEXT NOT NULL,  -- 충돌한 편집 내용 (JSON)
    resolved_at DATETIME,
    resolved_by TEXT,
    resolution_type TEXT CHECK(resolution_type IN ('merged', 'rejected', 'manual')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (revision_id) REFERENCES page_revisions(id)
);
```

#### `edit_approvals` 테이블 (승인형 워크플로우)

```sql
CREATE TABLE IF NOT EXISTS edit_approvals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    revision_id INTEGER NOT NULL,
    entity_type TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'approved', 'rejected')),
    approver_id TEXT,  -- 승인자 ID
    approver_type TEXT CHECK(approver_type IN ('expert', 'admin')),
    approval_comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    reviewed_at DATETIME,
    FOREIGN KEY (revision_id) REFERENCES page_revisions(id)
);
```

#### `edit_sources` 테이블 (출처 관리)

```sql
CREATE TABLE IF NOT EXISTS edit_sources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    revision_id INTEGER NOT NULL,
    source_url TEXT NOT NULL,
    source_title TEXT,
    source_type TEXT CHECK(source_type IN ('website', 'academic', 'government', 'news', 'other')),
    verified INTEGER DEFAULT 0 CHECK(verified IN (0, 1)),  -- 검증 여부
    verified_by TEXT,
    verified_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (revision_id) REFERENCES page_revisions(id)
);
```

#### `anonymous_edit_limits` 테이블 (익명 편집 제한)

```sql
CREATE TABLE IF NOT EXISTS anonymous_edit_limits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    entity_type TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    ip_hash TEXT NOT NULL,
    date DATE NOT NULL,
    edit_count INTEGER DEFAULT 1,
    last_edit_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(entity_type, entity_id, ip_hash, date)
);

CREATE INDEX idx_anonymous_edit_limits_lookup 
    ON anonymous_edit_limits(entity_type, entity_id, ip_hash, date);
```

### 3. 데이터 구조 설계

#### 버전 히스토리 시스템 구조

**핵심 개념**: 모든 편집은 새로운 revision으로 저장되며, 각 revision에는 전체 데이터 스냅샷이 포함됨

#### `page_revisions.data_snapshot` 구조

```typescript
// 각 revision의 data_snapshot은 병합된 최종 데이터
interface RevisionSnapshot {
  // API 원본 데이터 (첫 번째 revision에만 있음, 이후 편집 시 수정 가능)
  apiData?: {
    summary?: string
    duties?: string
    salary?: string
    // ... 모든 API 필드
  }
  
  // 사용자 기여 데이터
  userContributions?: {
    [field: string]: {
      content: string
      source: string
      editorId: string | null
      editorType: 'anonymous' | 'user' | 'expert' | 'admin'
      anonymousNumber?: number
      revisionId: number  // 이 편집이 포함된 revision ID
    }
  }
  
  // 관리자 승인 데이터
  adminData?: {
    [field: string]: {
      content: string
      source: string
      approvedBy: string
      approvedAt: number
      revisionId: number
    }
  }
  
  // 메타데이터
  version: number  // revision_number
  mergedAt: number  // 병합 시각
}
```

#### 현재 데이터 저장 구조 (jobs/majors 테이블)

**현재 활성 데이터**는 `jobs`/`majors` 테이블에 저장:
- `api_data_json`: API 원본 데이터 (변경 가능, 편집 시 수정됨)
- `user_contributed_json`: 사용자 기여 데이터
- `admin_data_json`: 관리자 데이터

**버전 히스토리**는 `page_revisions` 테이블에 저장:
- 각 revision마다 전체 병합 결과를 `data_snapshot`에 저장
- `data_snapshot`에는 병합된 최종 데이터만 저장 (admin > user > api 우선순위 적용 후)
- API 원본 데이터도 편집되면 새 revision에 반영됨
- 되돌리기는 특정 revision의 `data_snapshot`을 복원

**⚠️ 용량 고려사항**:
- `data_snapshot`에 전체 JSON 저장 시 용량 증가 가능 (직업 1개당 평균 50KB)
- 직업 980개 × revision 10개 = 약 490MB 예상
- 필요 시 delta 저장 또는 압축 저장 고려

#### 편집 플로우 예시

```
초기 상태:
  - jobs.api_data_json = { summary: "API 원본", ... }
  - Revision 1: data_snapshot = { apiData: { summary: "API 원본" } }
  
사용자 A가 summary 편집:
  - jobs.api_data_json = { summary: "편집된 내용", ... }
  - Revision 2: data_snapshot = { apiData: { summary: "편집된 내용" }, ... }
  
사용자 B가 duties 편집:
  - jobs.api_data_json = { summary: "편집된 내용", duties: "새로운 업무", ... }
  - Revision 3: data_snapshot = { apiData: { summary: "편집된 내용", duties: "새로운 업무" }, ... }
  
Revision 1로 되돌리기:
  - Revision 1의 data_snapshot 조회
  - jobs.api_data_json = { summary: "API 원본", ... }
  - Revision 4: data_snapshot = { apiData: { summary: "API 원본" } } (복원)
```

**장점**:
- ✅ API 원본도 하나의 revision으로 관리
- ✅ 모든 버전이 동일한 방식으로 저장
- ✅ 특정 시점으로 자유롭게 되돌리기 가능
- ✅ 별도 원본 컬럼 불필요

---

## 🔌 API 엔드포인트 설계

### 1. 편집 관련 엔드포인트

#### `POST /api/job/:id/edit` - 직업 편집

**요청 본문**:
```typescript
{
  // 필수
  field: string  // 'summary', 'duties', 'salary' 등
  content: string  // 편집 내용
  source: string  // 출처 URL (필수)
  
  // 익명 편집 시 필수
  password?: string  // 4자리 숫자
  anonymous?: boolean  // true면 익명 편집
  
  // 선택
  changeSummary?: string  // 변경 요약
  workflowType?: 'immediate' | 'approval'  // 즉시 반영 vs 승인형
}
```

**응답**:
```typescript
{
  success: boolean
  revisionId: number
  message: string
  // 승인형인 경우
  status?: 'pending' | 'approved'
  approvalId?: number
}
```

**권한 체크**:
- 로그인 사용자: 자동 허용
- 익명 사용자: 비밀번호 필수
- **버전 관리**: 편집 시 현재 버전의 스냅샷을 저장하고 새 revision 생성

#### `POST /api/major/:id/edit` - 전공 편집

동일한 구조, `job` 대신 `major` 사용

#### `POST /api/howto/:slug/edit` - HowTo 편집

**요청 본문**:
```typescript
{
  content: string  // JSON 문자열 (HowtoGuideDetail 구조)
  password?: string  // 익명 편집 시
  anonymous?: boolean
  changeSummary?: string
}
```

#### `GET /api/job/:id/revisions` - 편집 이력 조회

**쿼리 파라미터**:
- `limit`: 페이지당 개수 (기본 20)
- `offset`: 페이지 오프셋
- `field`: 특정 필드만 필터링

**응답**:
```typescript
{
  revisions: Array<{
    id: number
    editorType: 'anonymous' | 'user' | 'expert' | 'admin'
    editorName: string  // 사용자명 또는 "익명 1"
    changedFields: string[]
    changeSummary: string
    source: string
    createdAt: string
    // 익명인 경우
    anonymousNumber?: number
  }>
  total: number
}
```

#### `POST /api/revision/:id/restore` - 되돌리기

**권한**: 본인 편집 또는 관리자만 가능

**요청 본문**:
```typescript
{
  password?: string  // 익명 편집인 경우 필수
}
```

**동작 방식**:
1. 지정된 revision의 `data_snapshot` 조회
2. 현재 revision의 스냅샷을 저장 (되돌리기 전 상태 보존)
3. 새 revision 생성 (change_type='restore')
4. `data_snapshot`을 현재 데이터로 복원
5. `is_current` 플래그 업데이트 (이전 버전은 0, 새 버전은 1)

**예시**:
```
Revision 1: API 원본 데이터 (시스템 생성)
Revision 2: 사용자 A 편집
Revision 3: 사용자 B 편집 (현재)
  ↓
Revision 3으로 되돌리기
  ↓
Revision 4: Revision 1의 데이터로 복원 (change_type='restore')
```

#### `POST /api/revision/:id/approve` - 편집 승인 (관리자/전문가)

**권한**: Expert 이상

**요청 본문**:
```typescript
{
  action: 'approve' | 'reject'
  comment?: string
}
```

#### `GET /api/conflict/:id/resolve` - 충돌 해결 UI 데이터

**응답**:
```typescript
{
  current: {
    content: string
    revisionId: number
    editor: string
  }
  conflicting: {
    content: string
    revisionId: number
    editor: string
  }
  diff: Array<{
    type: 'added' | 'removed' | 'modified'
    line: string
    lineNumber: number
  }>
}
```

#### `POST /api/conflict/:id/resolve` - 충돌 해결 제출

**요청 본문**:
```typescript
{
  resolution: 'current' | 'conflicting' | 'merged'
  mergedContent?: string  // 수동 병합인 경우
  password?: string  // 익명인 경우
}
```

### 2. 익명 편집 관련 엔드포인트

#### `POST /api/edit/anonymous/verify` - 익명 편집 비밀번호 확인

**요청 본문**:
```typescript
{
  entityType: 'job' | 'major' | 'howto'
  entityId: string
  revisionId: number
  password: string
}
```

**응답**:
```typescript
{
  verified: boolean
  message?: string
}
```

---

## 🎨 UI/UX 구현 계획

### 1. 편집 버튼 배치

#### 직업/전공 상세 페이지

**위치**: 각 섹션 제목 옆
```html
<h2>
  직업 소개
  <button class="edit-btn" data-section="summary" data-entity-type="job" data-entity-id="354">
    <i class="fas fa-edit"></i> 편집
  </button>
</h2>
```

**시각적 구분**:
- API 데이터 섹션: 파란색 배지 "API 데이터"
- 사용자 추가 섹션: 초록색 배지 "사용자 기여"
- 편집 가능: 연필 아이콘 표시
- 편집 불가: 회색 처리

### 2. 편집 모달 UI

#### Notion 스타일 인라인 편집

**구조**:
```html
<div class="edit-modal" data-section="summary">
  <!-- 편집 모드 -->
  <div class="edit-mode">
    <textarea class="content-editor" placeholder="내용을 입력하세요..."></textarea>
    <div class="source-input">
      <label>출처 (필수)</label>
      <input type="url" placeholder="https://..." required>
      <button class="verify-source">출처 검증</button>
    </div>
    <div class="anonymous-option" v-if="!user">
      <label>
        <input type="checkbox" v-model="anonymous"> 익명으로 편집
      </label>
      <input v-if="anonymous" type="password" placeholder="4자리 비밀번호" maxlength="4" pattern="[0-9]{4}">
    </div>
    <div class="workflow-type">
      <label>
        <input type="radio" value="immediate" v-model="workflowType"> 즉시 반영
      </label>
      <label>
        <input type="radio" value="approval" v-model="workflowType"> 검토 요청
      </label>
    </div>
    <div class="actions">
      <button class="cancel">취소</button>
      <button class="save">저장</button>
    </div>
  </div>
</div>
```

### 3. 익명 편집 UI

#### 비밀번호 입력 플로우

1. 편집 버튼 클릭
2. 모달 열림
3. "익명으로 편집" 체크박스 표시
4. 체크 시 비밀번호 입력 필드 표시
5. 저장 시 비밀번호 검증

#### 익명 번호 표시

```html
<div class="editor-info">
  <span class="editor-name">익명 1</span>
  <span class="edit-time">2시간 전</span>
  <button class="edit-again" data-password-required>수정</button>
</div>
```

### 4. 충돌 해결 UI

#### GitHub 스타일 Diff 뷰

```html
<div class="conflict-resolution">
  <div class="conflict-header">
    <h3>편집 충돌 발생</h3>
    <p>다른 사용자가 먼저 이 문서를 수정했습니다.</p>
  </div>
  
  <div class="diff-view">
    <div class="current-version">
      <h4>현재 최신 버전</h4>
      <div class="content">...</div>
    </div>
    
    <div class="your-version">
      <h4>귀하의 편집 내용</h4>
      <div class="content">...</div>
    </div>
  </div>
  
  <div class="resolution-options">
    <button class="use-current">최신 버전 사용</button>
    <button class="use-yours">내 편집 사용</button>
    <button class="merge-manually">수동 병합</button>
  </div>
</div>
```

### 5. 모바일 편집 UI

#### 풀스크린 편집 모드

- 편집 버튼 클릭 시 전체 화면 모달
- 키보드 올라올 때 자동 스크롤
- 저장/취소 버튼 하단 고정
- 터치 친화적 버튼 크기 (최소 44x44px)

---

## 🔐 보안 및 권한 구현

### 1. 권한 검증 Middleware

#### 수정된 Middleware 구조

```typescript
// src/middleware/editAuth.ts

// 익명 편집 허용하는 편집 Middleware
export const allowEdit = createMiddleware(async (c, next) => {
  // 로그인 사용자면 통과
  const user = c.get('user')
  if (user) {
    return next()
  }
  
  // 익명 사용자도 통과 (비밀번호는 API에서 검증)
  return next()
})

// 비밀번호 검증 함수
export async function verifyEditPassword(
  db: D1Database,
  revisionId: number,
  password: string
): Promise<boolean> {
  const revision = await db
    .prepare('SELECT password_hash FROM page_revisions WHERE id = ?')
    .bind(revisionId)
    .first()
  
  if (!revision?.password_hash) return false
  
  return await verifyPassword(password, revision.password_hash)
}
```

### 2. 출처 검증 로직

```typescript
// src/utils/sourceValidator.ts

export async function validateSource(sourceUrl: string): Promise<{
  valid: boolean
  type?: 'website' | 'academic' | 'government' | 'news'
  error?: string
}> {
  // URL 형식 검증
  try {
    new URL(sourceUrl)
  } catch {
    return { valid: false, error: '올바른 URL 형식이 아닙니다' }
  }
  
  // 금지된 도메인 체크
  const blockedDomains = ['spam.com', 'malicious.org']
  const domain = new URL(sourceUrl).hostname
  if (blockedDomains.includes(domain)) {
    return { valid: false, error: '신뢰할 수 없는 출처입니다' }
  }
  
  // 도메인 타입 분류
  let type: 'website' | 'academic' | 'government' | 'news' = 'website'
  if (domain.includes('.ac.kr') || domain.includes('.edu')) {
    type = 'academic'
  } else if (domain.includes('.go.kr') || domain.includes('.gov')) {
    type = 'government'
  } else if (domain.includes('news') || domain.includes('press')) {
    type = 'news'
  }
  
  return { valid: true, type }
}
```

### 3. 캐시 무효화 함수

```typescript
// src/utils/cacheInvalidation.ts

/**
 * 편집 후 ISR 캐시 무효화
 * wiki_pages 테이블에서 해당 페이지의 캐시된 HTML 삭제
 */
export async function invalidateCache(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string
): Promise<void> {
  if (entityType === 'job' || entityType === 'major') {
    // jobs/majors는 entityId가 id이므로 slug로 변환 필요
    // 또는 wiki_pages 테이블의 slug 형식 확인 필요
    await db.prepare(`
      DELETE FROM wiki_pages 
      WHERE slug = ? AND page_type = ?
    `).bind(entityId, entityType).run()
  } else {
    // HowTo는 pages 테이블의 slug 사용
    await db.prepare(`
      DELETE FROM wiki_pages 
      WHERE slug = ?
    `).bind(entityId).run()
  }
}
```

### 4. 익명 편집 제한 체크

```typescript
// src/utils/anonymousEditLimits.ts

const MAX_DAILY_EDITS = 10  // IP당 일일 최대 편집 수

export async function checkAnonymousEditLimit(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string,
  ipHash: string
): Promise<{ allowed: boolean; remaining: number }> {
  const today = new Date().toISOString().split('T')[0]
  
  const result = await db
    .prepare(`
      SELECT edit_count 
      FROM anonymous_edit_limits 
      WHERE entity_type = ? AND entity_id = ? AND ip_hash = ? AND date = ?
    `)
    .bind(entityType, entityId, ipHash, today)
    .first<{ edit_count: number }>()
  
  const currentCount = result?.edit_count || 0
  const remaining = Math.max(0, MAX_DAILY_EDITS - currentCount)
  
  return {
    allowed: currentCount < MAX_DAILY_EDITS,
    remaining
  }
}
```

### 4. XSS 방지

```typescript
// src/utils/sanitize.ts

import { escapeHtml } from './escape'

export function sanitizeEditContent(content: string): string {
  // HTML 태그 제거 또는 이스케이프
  // Markdown은 허용하되 <script> 등은 제거
  return escapeHtml(content)
    .replace(/<script[^>]*>.*?<\/script>/gi, '')
    .replace(/on\w+="[^"]*"/gi, '')  // 이벤트 핸들러 제거
}
```

---

## 📅 단계별 구현 계획

### Day 1: 데이터베이스 및 기본 API (8시간)

#### 작업 1: 데이터베이스 마이그레이션 (2시간)

**파일**: `migrations/0010_edit_system.sql`

**작업 내용**:
- [ ] 기존 `page_revisions` 테이블 구조 확인 (`migrations/0001_initial_schema.sql` 참조)
- [ ] 새 컬럼 추가 (entity_type, entity_id, revision_number, is_current, data_snapshot 등)
- [ ] 기존 데이터 마이그레이션 (page_id → entity_type='guide' + entity_id=slug)
- [ ] revision_number 자동 할당 (기존 데이터 기준)
- [ ] is_current 플래그 설정 (최신 revision만 1)
- [ ] `edit_conflicts` 테이블 생성
- [ ] `edit_approvals` 테이블 생성
- [ ] `edit_sources` 테이블 생성
- [ ] `anonymous_edit_limits` 테이블 생성
- [ ] 인덱스 생성 (UNIQUE 제약 포함)

**마이그레이션 스크립트 구조**:
```sql
-- 1. 컬럼 추가
ALTER TABLE page_revisions ADD COLUMN ...;

-- 2. 기존 데이터 마이그레이션
UPDATE page_revisions SET ... WHERE entity_type IS NULL;

-- 3. 제약 조건 및 인덱스
CREATE UNIQUE INDEX ...;
```

**검증**:
```bash
npm run db:migrate:local
# D1에서 테이블 구조 확인
# 기존 데이터가 올바르게 마이그레이션되었는지 확인
```

#### 작업 2: 데이터 구조 타입 정의 (1시간)

**파일**: `src/types/editSystem.ts`

**작업 내용**:
- [ ] `UserContributedData` 인터페이스 정의
- [ ] `AdminData` 인터페이스 정의
- [ ] `EditRevision` 인터페이스 정의
- [ ] `EditConflict` 인터페이스 정의
- [ ] `EditApproval` 인터페이스 정의

#### 작업 3: 기본 편집 서비스 함수 (3시간)

**파일**: `src/services/editService.ts`

**작업 내용**:
- [ ] `createEditRevision()` - 편집 이력 생성
- [ ] `saveUserContribution()` - 사용자 기여 저장
- [ ] `saveAdminData()` - 관리자 데이터 저장
- [ ] `mergeEditData()` - 데이터 병합 로직
- [ ] `getNextRevisionNumber()` - 다음 revision 번호 조회 (자동 증가)
- [ ] `createRevision()` - 새 revision 생성 (전체 스냅샷 저장, is_current 관리)
- [ ] `getCurrentRevision()` - 현재 활성 revision 조회
- [ ] `getRevisionSnapshot()` - 특정 revision의 스냅샷 조회
- [ ] `invalidateCache()` - 편집 후 ISR 캐시 무효화 (wiki_pages 테이블 삭제)

**테스트**:
```typescript
// 단위 테스트 작성
describe('editService', () => {
  it('should create new revision with full snapshot', async () => {
    // 편집 시 새 revision 생성 및 스냅샷 저장 확인
  })
  
  it('should restore to specific revision', async () => {
    // 되돌리기 시 지정된 revision의 스냅샷으로 복원 확인
  })
  
  it('should maintain revision history', async () => {
    // 모든 편집이 revision으로 기록되는지 확인
  })
})
```
```

#### 작업 4: 익명 편집 유틸리티 (2시간)

**파일**: `src/utils/anonymousEdit.ts`

**작업 내용**:
- [ ] `hashEditPassword()` - 비밀번호 해시
- [ ] `verifyEditPassword()` - 비밀번호 검증
- [ ] `getNextAnonymousNumber()` - 익명 번호 할당 (entity별, IP별 재사용)
- [ ] `checkAnonymousEditLimit()` - 일일 제한 체크
- [ ] `incrementAnonymousEditCount()` - 편집 카운트 증가

---

### Day 2: API 엔드포인트 구현 (8시간)

#### 작업 1: 직업 편집 API (2시간)

**파일**: `src/index.tsx` 또는 `src/routes/edit.ts`

**엔드포인트**: `POST /api/job/:id/edit`

**구현 내용**:
- [ ] 권한 체크 (익명 허용)
- [ ] 비밀번호 검증 (익명인 경우)
- [ ] 출처 검증
- [ ] 현재 활성 revision의 스냅샷 저장 (변경 전 상태 보존)
- [ ] `getNextRevisionNumber()`로 다음 revision 번호 조회
- [ ] 편집 내용 반영하여 새 revision 생성
- [ ] **트랜잭션(batch)으로 원자적 처리**:
  - 이전 revision의 `is_current = 0` 업데이트
  - 새 revision 생성 (`is_current = 1`)
  - jobs/majors 테이블 업데이트
  - `invalidateCache()` 호출 (wiki_pages 테이블 삭제)
- [ ] 익명 편집 제한 체크

**에러 처리**:
- 비밀번호 없음 (익명인 경우)
- 비밀번호 불일치
- 출처 없음
- 일일 편집 제한 초과
- Revision 생성 실패

#### 작업 2: 전공 편집 API (1시간)

**엔드포인트**: `POST /api/major/:id/edit`

**구현 내용**: 직업 편집과 동일한 로직

#### 작업 3: HowTo 편집 API (1.5시간)

**엔드포인트**: `POST /api/howto/:slug/edit`

**구현 내용**:
- [ ] JSON 구조 검증
- [ ] HowtoGuideDetail 스키마 검증
- [ ] 작성자 확인 (본인 또는 관리자)
- [ ] 익명 편집 비밀번호 검증

#### 작업 4: 편집 이력 조회 API (1시간)

**엔드포인트**: `GET /api/job/:id/revisions`

**구현 내용**:
- [ ] 페이지네이션
- [ ] 필드 필터링
- [ ] 익명 번호 표시
- [ ] 편집자 정보 마스킹 (개인정보 보호)

#### 작업 5: 되돌리기 API (1시간)

**엔드포인트**: `POST /api/revision/:id/restore`

**구현 내용**:
- [ ] 권한 확인 (본인 또는 관리자)
- [ ] 비밀번호 검증 (익명인 경우)
- [ ] 지정된 revision의 `data_snapshot` 조회
- [ ] 현재 활성 revision의 스냅샷 저장 (되돌리기 전 상태 보존)
- [ ] `getNextRevisionNumber()`로 다음 revision 번호 조회
- [ ] **트랜잭션(batch)으로 원자적 처리**:
  - 이전 revision의 `is_current = 0` 업데이트
  - 새 revision 생성 (change_type='restore', `is_current = 1`)
  - `data_snapshot`을 현재 데이터로 복원 (jobs/majors 테이블 업데이트)
  - `invalidateCache()` 호출

#### 작업 6: 충돌 해결 API (1.5시간)

**엔드포인트**: 
- `GET /api/conflict/:id/resolve` - 충돌 데이터 조회
- `POST /api/conflict/:id/resolve` - 충돌 해결 제출

**구현 내용**:
- [ ] 충돌 감지 로직
- [ ] Diff 생성 (변경사항 비교)
- [ ] 병합 옵션 제공
- [ ] 수동 병합 처리

---

### Day 3: UI 구현 (8시간)

#### 작업 1: 편집 버튼 컴포넌트 (1시간)

**파일**: `public/static/edit-ui.js` 또는 `src/components/EditButton.tsx`

**구현 내용**:
- [ ] 섹션별 편집 버튼 렌더링
- [ ] 편집 가능/불가능 상태 표시
- [ ] API 데이터 vs 사용자 데이터 구분 표시
- [ ] 클릭 이벤트 핸들러

#### 작업 2: 편집 모달 컴포넌트 (3시간)

**구현 내용**:
- [ ] Notion 스타일 인라인 편집 모달
- [ ] 텍스트 에디터 (Markdown 지원)
- [ ] 출처 입력 필드
- [ ] 익명 편집 옵션
- [ ] 비밀번호 입력 필드
- [ ] 워크플로우 선택 (즉시/승인)
- [ ] 저장/취소 버튼

**스타일링**:
- Tailwind CSS 사용
- 모바일 반응형
- 접근성 (ARIA 라벨, 키보드 네비게이션)

#### 작업 3: 익명 편집 UI (1시간)

**구현 내용**:
- [ ] "익명으로 편집" 체크박스
- [ ] 비밀번호 입력 필드 (4자리 숫자만)
- [ ] 익명 번호 표시
- [ ] 비밀번호 재입력 확인

#### 작업 4: 충돌 해결 UI (2시간)

**구현 내용**:
- [ ] GitHub 스타일 Diff 뷰
- [ ] 좌우 비교 레이아웃
- [ ] 변경사항 하이라이트
- [ ] 병합 옵션 버튼
- [ ] 수동 병합 에디터

#### 작업 5: 편집 이력 UI (1시간)

**구현 내용**:
- [ ] 이력 목록 표시
- [ ] 편집자 정보 표시 (익명 번호 포함)
- [ ] 변경사항 요약 표시
- [ ] 되돌리기 버튼
- [ ] 페이지네이션

---

### Day 4: 통합 및 테스트 (8시간)

#### 작업 1: 데이터 병합 로직 통합 (2시간)

**파일**: `src/services/jobStorage.ts`, `src/services/majorStorage.ts`

**구현 내용**:
- [ ] 현재 활성 revision의 `data_snapshot` 조회
- [ ] 스냅샷에서 데이터 병합 (admin > user > api 우선순위)
- [ ] 병합된 결과를 템플릿에 전달
- [ ] 편집 시 새 revision 생성 및 스냅샷 저장
- [ ] 캐시 무효화 트리거

#### 작업 2: 템플릿 렌더링 수정 (2시간)

**파일**: `src/templates/unifiedJobDetail.ts`, `src/templates/unifiedMajorDetail.ts`

**구현 내용**:
- [ ] 편집된 데이터 표시
- [ ] 출처 배지 표시
- [ ] 편집자 정보 표시
- [ ] 편집 버튼 렌더링

#### 작업 3: 종합 테스트 (3시간)

**테스트 시나리오**:

1. **로그인 사용자 편집**
   - [ ] 직업 페이지 편집
   - [ ] 전공 페이지 편집
   - [ ] HowTo 편집
   - [ ] 출처 없이 편집 시도 (에러)
   - [ ] 편집 이력 확인

2. **익명 사용자 편집**
   - [ ] 비밀번호 없이 편집 시도 (에러)
   - [ ] 비밀번호로 편집
   - [ ] 익명 번호 확인
   - [ ] 일일 제한 초과 시도 (에러)
   - [ ] 비밀번호로 수정

3. **API 데이터 편집 및 버전 관리**
   - [ ] API 원본 데이터 편집
   - [ ] 새 revision 생성 확인
   - [ ] 이전 revision으로 되돌리기
   - [ ] 특정 revision 조회 및 비교

4. **충돌 해결**
   - [ ] 동시 편집 시도
   - [ ] 충돌 감지
   - [ ] 충돌 해결 UI 표시
   - [ ] 병합 처리

5. **성능 테스트**
   - [ ] 편집 후 페이지 로딩 시간
   - [ ] 캐시 무효화 확인
   - [ ] 병합 로직 성능

#### 작업 4: 버그 수정 및 최적화 (1시간)

- [ ] 발견된 버그 수정
- [ ] 성능 최적화
- [ ] 에러 메시지 개선

---

## 🧪 테스트 계획

### 단위 테스트

#### 편집 서비스 테스트

```typescript
// src/services/__tests__/editService.test.ts

describe('editService', () => {
  test('should preserve original API data when editing', async () => {
    // ...
  })
  
  test('should merge admin > user > api priority', async () => {
    // ...
  })
  
  test('should create revision with anonymous editor', async () => {
    // ...
  })
})
```

#### 익명 편집 유틸리티 테스트

```typescript
// src/utils/__tests__/anonymousEdit.test.ts

describe('anonymousEdit', () => {
  test('should hash password correctly', async () => {
    // ...
  })
  
  test('should check daily edit limit', async () => {
    // ...
  })
  
  test('should assign anonymous number', async () => {
    // ...
  })
})
```

### 통합 테스트

#### API 엔드포인트 테스트

```typescript
// tests/integration/edit.test.ts

describe('POST /api/job/:id/edit', () => {
  test('should allow logged-in user to edit', async () => {
    // ...
  })
  
  test('should require password for anonymous edit', async () => {
    // ...
  })
  
  test('should preserve original API data', async () => {
    // ...
  })
  
  test('should reject edit without source', async () => {
    // ...
  })
})
```

### E2E 테스트 시나리오

1. **로그인 사용자 편집 플로우**
   - 로그인 → 직업 페이지 접속 → 편집 버튼 클릭 → 내용 수정 → 출처 입력 → 저장 → 이력 확인

2. **익명 사용자 편집 플로우**
   - 비로그인 상태 → 편집 버튼 클릭 → 익명 옵션 선택 → 비밀번호 입력 → 내용 수정 → 출처 입력 → 저장 → 익명 번호 확인

3. **충돌 해결 플로우**
   - 사용자 A 편집 시작 → 사용자 B 먼저 저장 → 사용자 A 저장 시도 → 충돌 감지 → Diff 뷰 표시 → 병합 선택 → 저장

---

## ✅ 체크리스트

### 데이터베이스
- [ ] 마이그레이션 파일 생성 및 실행
- [ ] Revision 테이블 생성/확장 확인 (버전 히스토리 시스템)
- [ ] data_snapshot 컬럼 확인 (전체 데이터 스냅샷 저장)
- [ ] revision_number 자동 증가 확인
- [ ] is_current 플래그 관리 확인
- [ ] 인덱스 생성 확인

### API 엔드포인트
- [ ] 직업 편집 API 구현
- [ ] 전공 편집 API 구현
- [ ] HowTo 편집 API 구현
- [ ] 편집 이력 조회 API 구현
- [ ] 되돌리기 API 구현
- [ ] 충돌 해결 API 구현
- [ ] 익명 편집 비밀번호 검증 구현

### 권한 및 보안
- [ ] 익명 편집 허용 Middleware 수정
- [ ] 비밀번호 검증 로직 구현
- [ ] 출처 검증 로직 구현
- [ ] 일일 편집 제한 구현
- [ ] XSS 방지 구현
- [ ] 버전 히스토리 무결성 확인 (모든 편집이 revision으로 기록되는지)

### UI/UX
- [ ] 편집 버튼 컴포넌트 구현
- [ ] 편집 모달 구현
- [ ] 익명 편집 UI 구현
- [ ] 충돌 해결 UI 구현
- [ ] 편집 이력 UI 구현
- [ ] 모바일 반응형 구현
- [ ] 접근성 (ARIA, 키보드) 구현

### 데이터 병합 및 버전 관리
- [ ] `getNextRevisionNumber()` 함수 구현 (revision 번호 자동 증가)
- [ ] 현재 revision의 스냅샷 조회 로직 구현
- [ ] 스냅샷에서 데이터 병합 (admin > user > api 우선순위)
- [ ] `createRevision()` 함수 구현 (트랜잭션/batch로 원자적 처리)
- [ ] `is_current` 플래그 관리 로직 구현
- [ ] 되돌리기 로직 구현 (특정 revision으로 복원)
- [ ] `invalidateCache()` 함수 구현 (ISR 캐시 무효화)

### 테스트
- [ ] 단위 테스트 작성
- [ ] 통합 테스트 작성
- [ ] E2E 테스트 시나리오 실행
- [ ] 성능 테스트 실행
- [ ] 보안 테스트 실행

### 문서화
- [ ] API 문서 작성
- [ ] 사용자 가이드 작성
- [ ] 개발자 가이드 작성
- [ ] 변경사항 기록

---

## 🚨 주의사항 및 위험 요소

### 1. 버전 히스토리 무결성
**위험**: Revision 생성 실패 시 편집 내용 손실  
**대응**: 
- D1 batch를 사용한 원자적 처리 (is_current 업데이트 + revision 생성 + 데이터 업데이트 + 캐시 삭제)
- Revision 생성 실패 시 편집 거부
- 에러 발생 시 상세 로그 기록
- 정기적인 revision 백업 (선택 사항)

**주의**: D1은 트랜잭션을 지원하지 않으므로 batch 사용 시 모든 작업이 성공해야 함

### 2. 익명 편집 악용
**위험**: 스팸, 악성 편집  
**대응**:
- 일일 편집 제한
- IP 기반 차단
- 자동 스팸 필터링
- 관리자 모니터링

### 3. 충돌 해결 복잡도
**위험**: 동시 편집 시 데이터 손실  
**대응**:
- 낙관적 락 사용
- 충돌 감지 및 알림
- 자동 병합 시도
- 수동 병합 UI 제공

### 4. 성능 저하
**위험**: 병합 로직이 느려지면 페이지 로딩 지연  
**대응**:
- 병합 결과 캐싱
- 변경 시에만 재계산
- 인덱스 최적화

---

## 📊 성공 지표

### 기능 완성도
- [ ] 모든 편집 기능 구현 완료
- [ ] 익명 편집 정상 작동
- [ ] API 데이터 편집 정상 작동
- [ ] 충돌 해결 정상 작동

### 성능
- [ ] 편집 후 페이지 로딩 < 100ms
- [ ] 병합 로직 실행 < 50ms
- [ ] 캐시 히트율 > 80%

### 보안
- [ ] XSS 공격 방어 확인
- [ ] 비밀번호 해시 안전성 확인
- [ ] 출처 검증 정상 작동

### 사용성
- [ ] 모바일에서 편집 가능
- [ ] 키보드만으로 편집 가능
- [ ] 에러 메시지 명확함

---

**다음 단계**: 이 계획서를 기반으로 단계별로 구현을 진행하세요. 각 작업 완료 시 체크리스트를 업데이트하고, 문제 발생 시 즉시 문서화하여 수정하세요.

