# CareerWiki ETL & Seeding 종합 가이드

## 개요

이 문서는 CareerWiki의 전공(Major) 및 직업사전(Job Dictionary) 데이터를 수집하고 정규화하는 ETL 프로세스를 설명합니다.

---

## 아키텍처 원칙

### 1. 원본 보존 (Source Preservation)
모든 외부 API 데이터는 `*_sources` 테이블에 원본 그대로 저장됩니다.

```
job_sources / major_sources
├── raw_payload (원본 JSON)
├── normalized_payload (정규화된 JSON)
├── source_system (CAREERNET, WORK24_JOB, 등)
├── source_type (LIST, DETAIL, DICTIONARY, 등)
└── fetched_at, updated_at
```

### 2. 정규화 (Normalization)
원본 데이터를 `Unified*Detail` 형식으로 변환하여 `normalized_payload`에 저장합니다.

### 3. 통합 (Canonical Entity)
`jobs`, `majors` 테이블에 통합된 엔티티를 저장합니다.

```
jobs / majors
├── canonical_id (내부 식별자)
├── api_data_json (병합된 프로필)
├── ai_data_json (AI 생성 콘텐츠)
├── user_contributed_json (사용자 기여)
└── admin_data_json (관리자 큐레이션)
```

---

## 데이터 소스

### 전공(Major) 데이터

#### A. CareerNet 전공 API

**1) 목록 조회**
```typescript
// 대학교 전공
searchCareerNetMajors({
  gubun: '대학교',
  subject: '100394', // 공학계열 (optional)
  thisPage: 1,
  perPage: 100
})

// 고등학교 전공
searchCareerNetMajors({
  gubun: '고등학교',
  thisPage: 1,
  perPage: 100
})
```

**계열 코드:**
- 100391: 인문계열
- 100392: 사회계열
- 100393: 교육계열
- 100394: 공학계열
- 100395: 자연계열
- 100396: 의약계열
- 100397: 예체능계열

**2) 상세 조회**
```typescript
getMajorDetail(majorSeq, gubun)
```

**응답 구조 차이:**
- **대학교**: summary, salary, employment, relate_subject, career_act, main_subject, university, chartData 등
- **고등학교**: purpose (주요교육내용), setshl (설치학교), graduation_gender, after_graduation 등

#### B. Work24 학과정보 API

**1) 목록 조회**
```typescript
fetchWork24MajorList({
  srchType: 'A',  // 전체검색
  keyword: ''
})
```

**응답:**
```xml
<majorList>
  <majorGb>1</majorGb>  <!-- 1: 일반학과, 2: 이색학과 -->
  <knowDtlSchDptNm>컴퓨터공학과</knowDtlSchDptNm>
  <empCurtState1Id>계열ID</empCurtState1Id>
  <empCurtState2Id>학과ID</empCurtState2Id>
</majorList>
```

**2) 일반학과 상세 (majorGb=1)**
```typescript
fetchWork24MajorDetail({
  majorGb: '1',
  empCurtState1Id: '계열ID',
  empCurtState2Id: '학과ID'
})
```

**응답 필드:**
- knowDptNm: 계열명
- knowSchDptNm: 학과명
- schDptIntroSum: 학과소개
- aptdIntrstCont: 적성/흥미
- relSchDptList: 관련학과
- mainSubjectList: 주요 교과목
- licList: 취득 자격
- schDptList: 개설 대학
- relAdvanJobsList: 관련직업

**3) 이색학과 상세 (majorGb=2)**
```typescript
fetchWork24MajorDetailSpecial({
  majorGb: '2',
  empCurtState1Id: '계열ID',
  empCurtState2Id: '학과ID'
})
```

**응답 필드:**
- whatStudy: 하는 공부
- howPrepare: 준비방법
- jobPropect: 직업 전망

### 직업사전(Job Dictionary) 데이터

#### Work24 직업사전 (dJobDTL)

**마스터 코드 리스트:**
- 파일: `docs/직업사전_세세분류_코드.csv`
- 총 6,581개 직업
- 구조: 대분류 > 중분류 > 소분류 > 직업코드 > 일련번호

**API 호출:**
```typescript
fetchWork24JobDictionary({
  dJobCd: '1110',      // 4자리 직업코드
  dJobCdSeq: '1'       // 일련번호
})
```

---

## 시딩 프로세스

### Phase 1: 직업사전 마스터 코드 로드

```bash
# 1. CSV 파일 파싱 및 DB 저장
tsx src/scripts/loadJobDictionaryIndex.ts

# Result: job_dictionary_index 테이블에 6,581개 레코드 생성
```

### Phase 2: 직업사전 상세 정보 시딩

```bash
# 2. job_dictionary_index의 각 코드로 212D50 API 호출
tsx src/scripts/seedWork24JobDictionary.ts

# Options:
# --limit=1000    # 한 번에 처리할 개수
# --offset=0      # 시작 오프셋
# --retry=true    # 실패한 항목 재시도

# Result: job_sources 테이블에 원본 + 정규화된 데이터 저장
```

### Phase 3: CareerNet 전공 목록 시딩

```bash
# 3a. 대학교 전공 목록
tsx src/scripts/seedCareerNetMajors.ts --track=university

# 3b. 고등학교 전공 목록
tsx src/scripts/seedCareerNetMajors.ts --track=highschool

# Result: major_sources 테이블에 LIST 타입으로 저장
```

### Phase 4: CareerNet 전공 상세 시딩

```bash
# 4. major_sources에서 majorSeq를 읽어 상세 조회
tsx src/scripts/seedCareerNetMajorDetails.ts

# Result: major_sources 테이블에 DETAIL_UNIV/DETAIL_HIGH 타입으로 저장
```

### Phase 5: Work24 전공 목록 시딩

```bash
# 5. Work24 학과정보 목록 조회
tsx src/scripts/seedWork24Majors.ts

# Result: major_sources 테이블에 LIST 타입으로 저장
```

### Phase 6: Work24 전공 상세 시딩

```bash
# 6. major_sources에서 majorGb, empCurtState1Id, empCurtState2Id로 상세 조회
tsx src/scripts/seedWork24MajorDetails.ts

# Result: major_sources 테이블에 DETAIL_GENERAL/DETAIL_SPECIAL 타입으로 저장
```

### Phase 7: 정규화 및 통합

```bash
# 7. *_sources → jobs/majors 테이블로 정규화
tsx src/scripts/normalizeToCanonical.ts

# Result: 각 소스를 독립된 canonical 엔티티로 생성
```

---

## 데이터베이스 스키마

### job_dictionary_index (직업사전 마스터 코드)

```sql
CREATE TABLE job_dictionary_index (
    d_job_cd TEXT NOT NULL,           -- 직업코드 (4자리)
    d_job_cd_seq TEXT NOT NULL,       -- 일련번호
    large_class_cd TEXT,               -- 대분류코드
    medium_class_cd TEXT,              -- 중분류코드
    small_class_cd TEXT,               -- 소분류코드
    large_class_nm TEXT,               -- 대분류명
    medium_class_nm TEXT,              -- 중분류명
    small_class_nm TEXT,               -- 소분류명
    job_nm TEXT NOT NULL,              -- 직업명
    related_job TEXT,                  -- 관련직업
    similar_job_nm TEXT,               -- 유사직업명칭
    is_seeded INTEGER DEFAULT 0,       -- 시딩 완료 여부
    seeded_at INTEGER,
    seed_error TEXT,
    retry_count INTEGER DEFAULT 0,
    UNIQUE(d_job_cd, d_job_cd_seq)
);
```

### major_sources (전공 원본 데이터)

```sql
CREATE TABLE major_sources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    major_id TEXT,                      -- 연결된 canonical major ID (NULL 가능)
    source_system TEXT NOT NULL,        -- 'CAREERNET', 'WORK24_MAJOR'
    source_key TEXT NOT NULL,           -- 'CAREERNET:665', 'WORK24_MAJOR:1:101:201'
    source_type TEXT,                   -- 'LIST', 'DETAIL_UNIV', 'DETAIL_HIGH', 등
    track TEXT,                         -- '대학교', '고등학교', '공통'
    gubun TEXT,                         -- CareerNet gubun 값
    major_seq TEXT,                     -- CareerNet majorSeq
    department_cd TEXT,                 -- Work24 department code
    raw_payload TEXT NOT NULL,          -- 원본 JSON
    normalized_payload TEXT NOT NULL,   -- 정규화된 JSON (UnifiedMajorDetail)
    fetched_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    last_error TEXT,
    retry_count INTEGER DEFAULT 0,
    UNIQUE(source_system, source_key)
);
```

### seed_logs (시딩 작업 로그)

```sql
CREATE TABLE seed_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    seed_type TEXT NOT NULL,           -- 'CAREERNET_MAJOR_LIST', 등
    started_at INTEGER NOT NULL,
    completed_at INTEGER,
    status TEXT NOT NULL,              -- 'running', 'completed', 'failed', 'partial'
    total_count INTEGER DEFAULT 0,
    success_count INTEGER DEFAULT 0,
    failed_count INTEGER DEFAULT 0,
    skipped_count INTEGER DEFAULT 0,
    error_message TEXT,
    error_details TEXT,                -- JSON 배열
    meta_json TEXT,                    -- 파라미터 등
    created_at INTEGER NOT NULL
);
```

### seed_errors (실패 항목 추적)

```sql
CREATE TABLE seed_errors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    seed_log_id INTEGER,
    seed_type TEXT NOT NULL,
    entity_type TEXT NOT NULL,         -- 'job', 'major', 'job_dict'
    entity_id TEXT NOT NULL,           -- majorSeq, dJobCd+dJobCdSeq 등
    entity_name TEXT,
    error_message TEXT,
    error_stack TEXT,
    request_params TEXT,               -- JSON
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    last_retry_at INTEGER,
    resolved_at INTEGER,
    created_at INTEGER NOT NULL
);
```

---

## 재시도 로직

### 자동 재시도
```typescript
async function fetchWithRetry(
  fn: () => Promise<any>,
  maxRetries = 3,
  delay = 1000
): Promise<any> {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await fn()
    } catch (error) {
      if (attempt === maxRetries) throw error
      
      await sleep(delay * attempt)  // Exponential backoff
    }
  }
}
```

### 실패 항목 재시도
```bash
# 실패한 항목만 재시도
tsx src/scripts/retryFailedSeeds.ts --type=major --max-retries=3

# 특정 시드 로그의 실패 항목 재시도
tsx src/scripts/retryFailedSeeds.ts --seed-log-id=123
```

---

## 로깅 구조

### 시딩 시작 시
```typescript
const seedLogId = await db.prepare(`
  INSERT INTO seed_logs (
    seed_type, started_at, status, created_at
  ) VALUES (?, ?, 'running', ?)
`).bind('CAREERNET_MAJOR_LIST', Date.now(), Date.now()).run()
```

### 개별 항목 실패 시
```typescript
await db.prepare(`
  INSERT INTO seed_errors (
    seed_log_id, seed_type, entity_type, entity_id,
    entity_name, error_message, retry_count, created_at
  ) VALUES (?, ?, ?, ?, ?, ?, 0, ?)
`).bind(
  seedLogId,
  'CAREERNET_MAJOR_DETAIL',
  'major',
  majorSeq,
  majorName,
  error.message,
  Date.now()
).run()
```

### 시딩 완료 시
```typescript
await db.prepare(`
  UPDATE seed_logs SET
    completed_at = ?,
    status = ?,
    total_count = ?,
    success_count = ?,
    failed_count = ?
  WHERE id = ?
`).bind(
  Date.now(),
  failed > 0 ? 'partial' : 'completed',
  total,
  success,
  failed,
  seedLogId
).run()
```

---

## 증분 업데이트

### 새 데이터만 시딩
```typescript
// major_sources에 없는 majorSeq만 가져오기
const unseeded = await db.prepare(`
  SELECT ml.major_seq
  FROM major_list ml
  LEFT JOIN major_sources ms 
    ON ms.source_system = 'CAREERNET' 
    AND ms.source_key = 'CAREERNET:' || ml.major_seq
  WHERE ms.id IS NULL
`).all()
```

### 오래된 데이터 재갱신
```typescript
// 30일 이상 지난 데이터 재조회
const stale = await db.prepare(`
  SELECT source_key
  FROM major_sources
  WHERE updated_at < ?
  AND source_type = 'DETAIL_UNIV'
`).bind(Date.now() - 30 * 24 * 60 * 60 * 1000).all()
```

---

## 모니터링 쿼리

### 시딩 진행 상황
```sql
SELECT 
  seed_type,
  status,
  total_count,
  success_count,
  failed_count,
  ROUND((success_count * 100.0 / total_count), 2) as success_rate
FROM seed_logs
WHERE started_at > datetime('now', '-24 hours')
ORDER BY started_at DESC;
```

### 실패율 높은 타입
```sql
SELECT 
  seed_type,
  COUNT(*) as error_count,
  COUNT(DISTINCT entity_id) as unique_entities
FROM seed_errors
WHERE created_at > datetime('now', '-7 days')
GROUP BY seed_type
ORDER BY error_count DESC;
```

### 재시도 필요 항목
```sql
SELECT 
  entity_type,
  entity_id,
  entity_name,
  error_message,
  retry_count
FROM seed_errors
WHERE resolved_at IS NULL
  AND retry_count < max_retries
ORDER BY created_at;
```

---

## 주의사항

### Rate Limiting
- CareerNet: 300ms 간격 권장
- Work24: 300ms 간격 권장
- 대량 시딩 시 sleep 추가

### API 안정성
- Work24 목록 API는 srchType='A'가 불안정할 수 있음
- 실패 시 srchType='K' + keyword='가','나',... 폴백 전략 사용

### 데이터 정합성
- canonical_id 생성 규칙 일관성 유지
- source_key는 UNIQUE 제약으로 중복 방지
- major_id/job_id는 NULL 허용 (매칭 전)

---

## 트러블슈팅

### 문제: API 타임아웃
**해결:** retry_count 증가, delay 증가, 배치 크기 감소

### 문제: 메모리 부족
**해결:** 배치 처리, 페이지네이션 사용

### 문제: 중복 데이터
**해결:** source_key UNIQUE 제약 확인, dedup 로직 추가

### 문제: 인코딩 오류
**해결:** UTF-8 확인, decodeXmlEntities 함수 사용

---

**Last Updated**: 2025-01-20  
**Version**: 1.0  
**Authors**: CareerWiki Team

