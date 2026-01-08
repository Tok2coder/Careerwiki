# Job Attributes Tagger Specification

## Version: tagger-v1.0.0 (Phase 1B)

---

## 1. 개요

CareerWiki AI 추천 시스템의 핵심 데이터 파이프라인으로, 7,000개 이상의 직업 데이터에서 구조화된 속성(job_attributes)을 추출합니다.

### 목적
- **fact-score-mapping**: 사용자 fact(답변)와 직업 속성 매칭
- **question-generation**: 후보군 갈림 포인트 기반 질문 생성
- **추천 품질 향상**: 구조화된 속성으로 정밀한 스코어링

---

## 2. 출력 스키마

### 2.1 핵심 Attributes (0~100 스케일)

| Field | Type | 설명 | QA 기준 |
|-------|------|------|---------|
| `wlb` | 0~100 | 워라밸 점수 | 85%+ |
| `growth` | 0~100 | 성장 가능성 | 75%+ |
| `stability` | 0~100 | 안정성 | 75%+ |
| `income` | 0~100 | 수입 수준 | 75%+ |
| `teamwork` | 0~100 | 협업 비중 | 75%+ |
| `solo_deep` | 0~100 | 집중 업무 비중 | 75%+ |
| `analytical` | 0~100 | 분석적 업무 | 75%+ |
| `creative` | 0~100 | 창의적 업무 | 75%+ |
| `execution` | 0~100 | 실행/운영 업무 | 75%+ |
| `people_facing` | 0~100 | 대인 업무 | 75%+ |

### 2.2 Categorical Attributes

| Field | Values | QA 기준 |
|-------|--------|---------|
| `work_hours` | regular, overtime_some, overtime_frequent | 85%+ |
| `shift_work` | none, possible, required | 85%+ |
| `travel` | none, some, frequent | 80%+ |
| `remote_possible` | none, partial, full | 85%+ |
| `degree_required` | none, college, bachelor, master, phd | 90%+ |
| `license_required` | none, preferred, required, multiple_required | 90%+ |
| `experience_required` | none, entry, junior, mid, senior | 75%+ |

### 2.3 Confidence Scores

```typescript
interface FieldConfidence {
  wlb: number           // 0~1
  growth: number
  stability: number
  income: number
  remote_possible: number
  work_hours: number
  shift_work: number
  travel: number
  degree_required: number
  license_required: number
  teamwork: number
  solo_deep: number
  analytical: number
  creative: number
  execution: number
  people_facing: number
}

interface JobAttributes {
  _confidence: number           // 전체 신뢰도 0~1
  _field_confidence: FieldConfidence
  evidence: {
    [field: string]: Array<{
      source: string    // 'duties', 'environment', 'qualifications'
      snippet: string   // 근거 텍스트 (최대 200자)
      weight: number    // 0~1
    }>
  }
}
```

---

## 3. Confidence 산출 방식

### 3.1 필드별 Confidence

| 상황 | Confidence |
|------|------------|
| 명시적 언급 + 수치/기준 포함 | 0.95~1.0 |
| 명시적 언급 | 0.85~0.95 |
| 간접적 추론 (관련 키워드) | 0.70~0.85 |
| 약한 추론 | 0.50~0.70 |
| 정보 없음 | 0.50 (기본값) |

### 3.2 전체 Confidence

```
_confidence = weighted_avg(field_confidences, field_weights)

where:
  - constraint 관련 필드 (degree, license, work_hours): weight = 2.0
  - 일반 필드: weight = 1.0
```

### 3.3 False Positive 최소화 정책

Constraint 관련 필드는 **보수적으로** 태깅:

| Field | 보수적 판단 기준 |
|-------|-----------------|
| `degree_required` | "학사 이상" 명시 시에만 bachelor+ |
| `license_required` | "자격증 필수" 명시 시에만 required |
| `remote_possible` | "재택 가능" 명시 시에만 partial/full |
| `shift_work` | "교대근무" 명시 시에만 possible/required |

---

## 4. QA 합격선

### 4.1 필드별 합격선

```typescript
const QA_THRESHOLDS = {
  MIN_CONFIDENCE: 0.70,     // 전체 최소
  
  // Critical fields (constraint 관련)
  wlb: 0.85,
  degree_required: 0.90,
  license_required: 0.90,
  remote_possible: 0.85,
  work_hours: 0.85,
  shift_work: 0.85,
  travel: 0.80,
  
  // General fields
  DEFAULT: 0.75,
}
```

### 4.2 QA 리포트 항목

1. **Confusion Matrix** (가능하면)
   - True Positive / True Negative
   - False Positive / False Negative

2. **Low-Confidence Jobs** (상위 100개)
   - job_id, job_name, confidence, weak_fields

3. **Field별 평균 Confidence**

4. **Source별 품질 편차**
   - CAREERNET vs WORK24_JOB

---

## 5. 배치 처리

### 5.1 설정

```typescript
const DEFAULT_BATCH_CONFIG = {
  batchSize: 50,            // 한 번에 처리할 job 수
  maxRetries: 3,            // 최대 재시도 횟수
  retryDelayMs: 1000,       // 재시도 대기 (1초)
  saveIntervalMs: 60000,    // 중간 저장 (1분)
  timeoutMs: 30000,         // 단일 job 타임아웃 (30초)
}
```

### 5.2 실패/재시도 정책

```
1. API 오류 (rate limit, network)
   → 지수 백오프로 재시도 (1s, 2s, 4s)
   → 3회 실패 시 에러 로그 + 건너뛰기

2. 파싱 오류 (JSON 형식)
   → 재시도 없이 에러 로그
   → 수동 검토 대상

3. 검증 오류 (스키마 불일치)
   → 기본값으로 채우고 저장
   → 낮은 confidence 부여
```

### 5.3 중간 저장

- 1분마다 진행 상황 DB 저장
- `tagger_runs` 테이블에 processed_jobs, failed_jobs 업데이트
- 실패한 job_id는 `tagger_errors` 테이블에 기록

---

## 6. API 엔드포인트

### 6.1 태깅 실행

```bash
# 골든셋 30개 태깅
POST /api/ai-analyzer/tagger/run-golden

# 커스텀 배치 태깅
POST /api/ai-analyzer/tagger/run-batch
Body: {
  "job_ids": ["id1", "id2"],  // 또는
  "limit": 100,
  "offset": 0
}
```

### 6.2 QA 리포트

```bash
# JSON 형식
GET /api/ai-analyzer/tagger/qa-report/{runId}

# Markdown 형식
GET /api/ai-analyzer/tagger/qa-report/{runId}?format=markdown
```

### 6.3 통계

```bash
# 태깅 통계
GET /api/ai-analyzer/tagger/stats

# 실행 이력
GET /api/ai-analyzer/tagger/runs

# 단일 job 조회
GET /api/ai-analyzer/tagger/job/{jobId}
```

---

## 7. 데이터 흐름

```
job_sources (원본)
    │
    ▼
[Tagger Batch]
    │ Gemini API 호출
    │ JSON 파싱 + 검증
    │ Confidence 계산
    ▼
job_attributes (태깅 결과)
    │
    ├─▶ fact-score-mapping (점수 계산)
    │
    └─▶ question-generation (질문 생성)
```

---

## 8. 버전 관리

| Version | Date | Changes |
|---------|------|---------|
| tagger-v1.0.0 | 2026-01-03 | Initial release, Phase 1B |

### 재태깅 정책

- `tagger_version` 변경 시 전체 재생성 가능
- job_id별 upsert로 기존 데이터 덮어쓰기
- 이전 버전 데이터는 자동 교체

---

## 9. 파일 구조

```
src/services/ai-analyzer/
├── job-attributes-types.ts     # 타입 정의
├── tagger-batch.ts             # 배치 처리 로직
├── qa-report.ts                # QA 리포트 생성
├── tagger-routes.ts            # API 라우트
└── migrations/
    └── 002_add_job_attributes_table.sql
```

---

## 10. 테스트 체크리스트

### Phase 1B 합격 기준

- [ ] 골든셋 30개 태깅 완료
- [ ] wlb 85%+, degree/license 90%+ 달성
- [ ] QA 리포트 자동 생성
- [ ] analyze 시 candidate pool 80 확보
- [ ] follow-up 답변으로 TOP3 변화 확인 (10케이스)

---

## 부록: LLM 프롬프트

```
You are a job attribute tagger for CareerWiki.
Your task is to analyze job information and extract structured attributes.
Be conservative with confidence scores - only give high confidence (>0.9) when evidence is clear.
For constraint-related fields (degree_required, license_required, remote_possible, work_hours, shift_work), minimize false positives.

Output ONLY valid JSON matching the schema, no explanation.
```






