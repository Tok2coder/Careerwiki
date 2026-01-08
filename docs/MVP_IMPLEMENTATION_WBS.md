# CareerWiki AI Analyzer MVP 구현 WBS

> 작성일: 2026-01-02
> 기준 스펙: SCORING_SPEC v0.2.1
> 목표: Fit TOP3 + Like TOP10 + Can TOP10 추천 MVP

---

## ⚠️ 구현 착수 전 체크리스트 (6가지 최종)

| # | 항목 | 상태 | SCORING_SPEC 위치 |
|---|------|------|------------------|
| 1 | **constraint 네이밍 통일** (표준 5개: work_hours_strict, remote_only, shift_work_no, degree_impossible, license_impossible) | ✅ | §2.2 |
| 2 | **RiskDetail.status에 OK 추가** (`'OK' \| 'UNKNOWN' \| 'RISK'`) | ✅ | §8.2 |
| 3 | **safe_unknown 처리 함수 시그니처** (buckets, totalCandidates 인자 포함) | ✅ | §7.1.1 |
| 4 | **ux_flags 필터 전/후 카운트** (counts_before_filter, counts_after_filter) | ✅ | §8.1 |
| 5 | **후보 풀 80~120 확보** (다양성 룰 충돌 방지, CANDIDATE_POOL_SIZE=80) | ✅ | §6.0.2 |
| 6 | **Phase 1 병렬 범위** (DB 없이 로컬 JSON/프롬프트/샘플 QA 가능) | ✅ | WBS |

> **위 6개 모두 SCORING_SPEC v0.2.1 Final에 확정됨** → 이제 구현 시작!

---

## 📊 전체 타임라인 (5주)

```
Week 1: Phase 0 (저장 인프라) + Phase 1 병렬 (태깅 샘플/QA)
Week 2: Phase 1 완료 (전체 태깅) + Phase 2 (스코어링 엔진)
Week 3: Phase 3 (API + 결과 JSON)
Week 4: Phase 4 (follow-up + 재확인)
Week 5: Phase 5 (QA + 캘리브레이션 + 배포)
```

### 병렬 가능 범위

> ⚠️ **Phase 0은 필수 먼저!** (재현성/저장의 핵심)

| Phase | 의존성 | 병렬 가능 범위 |
|-------|--------|--------------|
| **Phase 0** | 없음 | ❌ 먼저 완료 필수 |
| **Phase 1** | DB 없이 가능 | ✅ 로컬 JSON 산출, 프롬프트 튜닝, 샘플 QA (30개) |
| **Phase 2** | Phase 1 job_attributes | ⚠️ Phase 1 완료 후 시작 |

**추천 실행 순서**:
1. **Day 1~3**: Phase 0 착수 + Phase 1 병렬 (프롬프트 작성, 샘플 30개 태깅, QA)
2. **Day 4~5**: Phase 0 완료, Phase 1 전체 태깅 (7,000개)
3. **Week 2~**: Phase 2 시작

---

## Phase 0: 저장 인프라 (2~3일) - 필수 먼저!

> **목표**: Event Sourcing 기반 저장 구조 구축

### 0.1 DB 스키마 생성

```sql
-- D1 SQLite

-- 1. 원본 이벤트 저장 (append-only)
CREATE TABLE raw_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT,
  session_id TEXT NOT NULL,
  event_type TEXT NOT NULL,  -- 'FORM_SUBMITTED', 'FOLLOWUP_ANSWERED', 'ANALYSIS_REQUESTED'
  payload_json TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  client_meta TEXT
);

-- 2. 분석 요청/결과
CREATE TABLE ai_analysis_requests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL,
  analysis_type TEXT DEFAULT 'job',
  pricing_tier TEXT DEFAULT 'free',
  prompt_payload TEXT NOT NULL,
  status TEXT DEFAULT 'pending',
  requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  processed_at DATETIME,
  
  -- 버전 잠금 (재현성)
  recipe_version TEXT NOT NULL,     -- 'recipe-v1.0.0'
  tagger_version TEXT NOT NULL,     -- 'tagger-v1.0.0'
  scoring_version TEXT NOT NULL,    -- 'scoring-v0.2.1'
  profile_revision_id TEXT
);

CREATE TABLE ai_analysis_results (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  request_id INTEGER NOT NULL,
  result_json TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (request_id) REFERENCES ai_analysis_requests(id)
);

-- 3. follow-up 응답 저장
CREATE TABLE followup_responses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  request_id INTEGER NOT NULL,
  question_id TEXT NOT NULL,
  constraint_type TEXT NOT NULL,  -- 'work_hours_strict', 'remote_only' 등
  job_id TEXT NOT NULL,
  answer TEXT NOT NULL,  -- 'yes', 'no'
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (request_id) REFERENCES ai_analysis_requests(id)
);
```

### 0.2 API 엔드포인트 뼈대

```typescript
// src/routes/ai-analyzer.ts

// POST /api/ai/analyze - 분석 요청
// POST /api/ai/followup - follow-up 응답 처리
// GET /api/ai/result/:requestId - 결과 조회
```

### 0.3 체크리스트

- [ ] D1 마이그레이션 SQL 작성
- [ ] raw_events insert 함수
- [ ] ai_analysis_requests/results CRUD
- [ ] followup_responses insert/query
- [ ] 버전 상수 파일 생성 (`src/constants/analyzer-versions.ts`)

---

## Phase 1: 직업 태깅 배치 (3~5일)

> **목표**: 전체 ~7,000개 직업에 job_attributes 태깅

### 1.1 태깅 스크립트 구조

```
scripts/
├── tagging/
│   ├── tag-jobs.ts           # 메인 배치 스크립트
│   ├── prompts/
│   │   └── job-tagger-v1.txt # LLM 프롬프트
│   ├── utils/
│   │   ├── llm-client.ts     # OpenAI/Claude 클라이언트
│   │   └── db-client.ts      # D1 직접 연결
│   └── validate/
│       └── schema-validator.ts # job_attributes 스키마 검증
```

### 1.2 배치 실행 계획

| 단계 | 작업 | 예상 시간 |
|------|------|----------|
| 1 | 샘플 10개 프롬프트 테스트 | 2시간 |
| 2 | 프롬프트 튜닝 (실패 케이스 분석) | 4시간 |
| 3 | 전체 배치 (7,000개 × $0.001) | 3시간 |
| 4 | 스키마 검증 + 오류 수정 | 2시간 |
| 5 | QA 샘플링 (200개 랜덤) | 2시간 |

### 1.3 QA 합격선

| 필드 | 합격선 |
|------|--------|
| `wlb` | 85%+ |
| `degree_required` | 90%+ |
| `license_required` | 90%+ |
| `remote_possible` | 80%+ |

### 1.4 체크리스트

- [ ] LLM 프롬프트 작성 (JOB_ATTRIBUTES_SPEC 기준)
- [ ] 배치 스크립트 구현
- [ ] 스키마 검증 로직
- [ ] 실패/재시도 로직
- [ ] DB 업데이트 (api_data_json.merged.job_attributes)
- [ ] QA 샘플링 + 정확도 측정

---

## Phase 2: 스코어링 엔진 (4~5일)

> **목표**: Like/Can/Risk 점수 계산 + 버킷 분리

### 2.1 파일 구조

```
src/services/ai-analyzer/
├── scoring/
│   ├── index.ts              # 메인 엔트리
│   ├── like-score.ts         # Like 점수 (40+30+30)
│   ├── can-score.ts          # Can 점수 (60+40)
│   ├── risk-penalty.ts       # Risk 페널티 (0~80)
│   ├── fit-calculator.ts     # Fit = 0.5*Like + 0.5*Can - Risk
│   └── bucket-separator.ts   # safe_known/safe_unknown/caution 분리
├── utils/
│   ├── keyword-separator.ts  # separateDislikeKeywords (유일!)
│   ├── holland-mapper.ts     # 키워드 → Holland 코드
│   └── tag-matcher.ts        # 태그 교집합 계산
└── types/
    └── scoring-types.ts      # 타입 정의
```

### 2.2 핵심 함수

```typescript
// fit-calculator.ts
export function calculateFitScore(
  user: UserProfile,
  job: JobWithAttributes
): FitResult {
  const like = calculateLikeScore(user, job)
  const can = calculateCanScore(user, job)
  const risk = calculateRiskPenalty(user.constraints, job.job_attributes)
  
  const fit = 0.5 * like.total + 0.5 * can.total - risk.total
  
  return {
    fit: Math.round(fit * 100) / 100,
    like,
    can,
    risk,
    bucket: determineBucket(risk)
  }
}

// bucket-separator.ts
export function separateIntoBuckets(
  scoredJobs: ScoredJob[]
): BucketedResults {
  return {
    safe_known: scoredJobs.filter(j => 
      j.risk.total === 0 && !j.risk.hasUnknown
    ),
    safe_unknown: scoredJobs.filter(j => 
      j.risk.total === 0 && j.risk.hasUnknown
    ),
    caution: scoredJobs.filter(j => j.risk.total > 0)
  }
}
```

### 2.3 체크리스트

- [ ] Like 점수: 흥미(40) + 가치관(30) + 싫은것회피(30)
- [ ] Can 점수: 스킬(60) + 경험/학습가능성(40)
- [ ] Risk 페널티: 양수 계산 + 상한 80
- [ ] Confidence 반영: field_confidence 사용
- [ ] UNKNOWN 처리: penalty=0, 상태만 유지
- [ ] 중복 감점 방지: separateDislikeKeywords 유틸
- [ ] 3단계 버킷 분리

---

## Phase 3: API + 결과 JSON (3~4일)

> **목표**: 분석 API + result_json 생성

### 3.1 API 흐름

```
1. POST /api/ai/analyze
   └── raw_events에 ANALYSIS_REQUESTED 저장
   └── ai_analysis_requests 생성 (버전 잠금)
   └── Vector search로 후보 50개
   └── 스코어링 + 버킷 분리
   └── TOP3/TOP10 선정 (우선순위 + 다양성)
   └── follow-up 질문 생성 (Caution TOP3 시)
   └── result_json 생성
   └── ai_analysis_results 저장
   └── 응답 반환
```

### 3.2 result_json 구조

```typescript
interface AnalysisResultJSON {
  versions: {
    recipe: 'recipe-v1.0.0'
    tagger: 'tagger-v1.0.0'
    scoring: 'scoring-v0.2.1'
  }
  
  fit_top3: FitRecommendation[]
  like_top10: SimpleRecommendation[]
  can_top10: SimpleRecommendation[]
  caution_jobs: CautionRecommendation[]
  
  ux_flags: {
    has_caution_in_top3: boolean
    has_unknown_in_top3: boolean
    safe_known_count: number
    safe_unknown_count: number
    caution_count: number
    needs_followup_question: boolean
  }
  
  followup_questions?: FollowupQuestion[]
  
  generated_at: string
  total_candidates: number
}
```

### 3.3 체크리스트

- [ ] Vector search 후보 추출 (Vectorize 연동)
- [ ] 스코어링 파이프라인 연결
- [ ] TOP3 선정 (safe_known > safe_unknown > caution)
- [ ] 다양성 룰 적용 (중분류 최대 2개)
- [ ] follow-up 질문 생성 (Caution TOP3 시 필수)
- [ ] result_json 생성 + 저장
- [ ] 버전 정보 필수 포함

---

## Phase 4: follow-up 처리 (2~3일)

> **목표**: follow-up 응답 → 결과 수정 + fact 저장

### 4.1 API 흐름

```
1. POST /api/ai/followup
   └── followup_responses에 저장
   └── answer === 'no' ?
       └── Safe에서 대체 직업 선정 (다양성 룰)
       └── result_json 업데이트
       └── fact로 저장 (다음 분석에 반영)
   └── answer === 'yes' ?
       └── 결과 유지
       └── fact로 저장 (수용 기록)
   └── 수정된 result_json 반환
```

### 4.2 fact 저장 구조

```typescript
// answer === 'no'
{
  fact_key: 'confirmed_constraint.work_hours_strict',
  fact_value: { strict: true, confirmed_at: '2026-01-02T...' },
  confidence: 1.0,  // 유저 직접 확인
  source: 'followup_response'
}

// answer === 'yes'
{
  fact_key: 'accepted_risk.work_hours_strict',
  fact_value: { job_id: 'lawyer', accepted_at: '2026-01-02T...' },
  confidence: 1.0,
  source: 'followup_response'
}
```

### 4.3 체크리스트

- [ ] follow-up 응답 API 구현
- [ ] 대체 직업 선정 로직 (다양성 룰)
- [ ] result_json 업데이트 로직
- [ ] fact 저장 (raw_events)
- [ ] 다음 분석 시 fact 자동 반영

---

## Phase 5: QA + 캘리브레이션 + 배포 (3~5일)

> **목표**: 품질 검증 + 페널티 튜닝 + 프로덕션 배포

### 5.1 캘리브레이션

```typescript
// 테스트 시나리오 생성
const scenarios = [
  { constraints: { work_hours_strict: true } },
  { constraints: { remote_only: true } },
  { constraints: { degree_impossible: true } },
  // ...20개
]

// KPI 측정
for (const scenario of scenarios) {
  const result = await analyze(scenario)
  
  // TOP3 Caution 포함률
  const cautionInTop3 = result.fit_top3.filter(
    j => j.bucket === 'caution'
  ).length / 3
  
  // 목표: 10~30%
  log(`Caution rate: ${cautionInTop3}`)
}
```

### 5.2 E2E 테스트

| 테스트 케이스 | 기대 결과 |
|-------------|----------|
| 제약 없는 유저 | Safe TOP3, follow-up 없음 |
| 야근 싫음 유저 | 야근 많은 직업 Caution, follow-up 생성 |
| 학위 불가 유저 | 학위 필수 직업 Caution |
| follow-up "no" | Safe로 대체, fact 저장 |
| follow-up "yes" | 결과 유지, 수용 기록 |

### 5.3 체크리스트

- [ ] 캘리브레이션 시나리오 20개 실행
- [ ] TOP3 Caution 포함률 10~30% 확인
- [ ] 태깅 QA (wlb/degree/license 85%+)
- [ ] E2E 테스트 통과
- [ ] Cloudflare Pages 배포
- [ ] 프로덕션 모니터링 설정

---

## 📋 전체 체크리스트 (한눈에)

### Phase 0: 저장 인프라
- [ ] D1 스키마 생성
- [ ] API 뼈대 구현
- [ ] 버전 상수 파일

### Phase 1: 태깅 배치
- [ ] LLM 프롬프트 작성
- [ ] 배치 스크립트
- [ ] QA 합격선 통과

### Phase 2: 스코어링 엔진
- [ ] Like/Can/Risk 계산
- [ ] 3단계 버킷 분리
- [ ] 중복 감점 방지 유틸

### Phase 3: API + 결과
- [ ] 분석 API
- [ ] result_json 생성
- [ ] follow-up 질문 생성

### Phase 4: follow-up
- [ ] 응답 처리 API
- [ ] Safe 대체 로직
- [ ] fact 저장

### Phase 5: QA + 배포
- [ ] 캘리브레이션
- [ ] E2E 테스트
- [ ] 프로덕션 배포

---

## 🎯 MVP 완료 기준

1. **기능**: Fit TOP3 + Like TOP10 + Can TOP10 추천 동작
2. **품질**: 태깅 QA 합격선 통과 (85%+)
3. **캘리브레이션**: TOP3 Caution 포함률 10~30%
4. **재현성**: 버전 정보로 동일 결과 재현 가능
5. **신뢰도**: follow-up으로 Caution 재확인 동작

