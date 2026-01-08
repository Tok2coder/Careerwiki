# Safe 대체 알고리즘 규칙

> **목적**: Follow-up에서 answer="no" 시 Safe 직업으로 대체하는 로직 정의  
> **버전**: v1.0.0  
> **구현 시점**: 태깅 500개 + 캘리브레이션 완료 후

---

## 1. 개요

### 1.1 문제 상황

```
유저: "야근 많아도 괜찮아요?"
→ answer: "no" (야근 절대 싫어)
→ TOP3에 야근 많은 직업이 있음
→ 대체 필요!
```

### 1.2 목표

1. **거절된 속성/제약**을 `fact_level=1`(confirmed_constraint)로 승격 저장
2. **후보 풀**에서 해당 속성이 위험한 직업을 강하게 컷
3. **남은 후보**에서 유사 관심/스타일을 유지한 채 TOP3 재산출
4. **Rank Change diff**를 결과에 자동 갱신

---

## 2. 알고리즘 상세

### 2.1 Step 1: Fact 승격 저장

```typescript
// answer="no" 처리
async function handleFollowupNo(
  db: D1Database,
  sessionId: string,
  questionId: string,
  constraintType: string,  // 'work_hours_strict', 'remote_only', etc.
  jobId: string            // 거절된 직업
): Promise<void> {
  // 1. raw_events에 원문 저장
  await db.prepare(`
    INSERT INTO raw_events (session_id, event_type, payload_json)
    VALUES (?, 'FOLLOWUP_NO', ?)
  `).bind(sessionId, JSON.stringify({
    question_id: questionId,
    constraint_type: constraintType,
    rejected_job_id: jobId,
    answer: 'no',
    timestamp: new Date().toISOString(),
  })).run()

  // 2. facts에 confirmed_constraint 저장 (fact_level=1)
  await db.prepare(`
    INSERT INTO facts (session_id, fact_key, value_json, confidence, source_type, fact_level)
    VALUES (?, ?, ?, 1.0, 'followup', 1)
    ON CONFLICT(session_id, fact_key) DO UPDATE SET
      value_json = excluded.value_json,
      confidence = 1.0,
      fact_level = 1
  `).bind(
    sessionId,
    `confirmed_constraint.${constraintType}`,
    JSON.stringify({
      confirmed: true,
      rejected_job_id: jobId,
      confirmed_at: new Date().toISOString(),
    })
  ).run()
}
```

### 2.2 Step 2: 후보 풀 필터링

```typescript
interface FilterConfig {
  constraintType: string
  attributeField: string
  riskValues: string[]  // 이 값이면 제외
  penaltyBoost: number  // Risk Penalty 추가 증가량
}

const CONSTRAINT_FILTER_MAP: Record<string, FilterConfig> = {
  'work_hours_strict': {
    constraintType: 'work_hours_strict',
    attributeField: 'work_hours',
    riskValues: ['overtime_frequent'],
    penaltyBoost: 40,  // 기존 Risk + 40
  },
  'shift_work_no': {
    constraintType: 'shift_work_no',
    attributeField: 'shift_work',
    riskValues: ['required'],
    penaltyBoost: 40,
  },
  'remote_only': {
    constraintType: 'remote_only',
    attributeField: 'remote_possible',
    riskValues: ['none'],
    penaltyBoost: 35,
  },
  'degree_impossible': {
    constraintType: 'degree_impossible',
    attributeField: 'degree_required',
    riskValues: ['bachelor', 'master', 'phd'],
    penaltyBoost: 30,
  },
  'license_impossible': {
    constraintType: 'license_impossible',
    attributeField: 'license_required',
    riskValues: ['required', 'multiple_required'],
    penaltyBoost: 25,
  },
}

function filterCandidates(
  candidates: ScoredJob[],
  confirmedConstraints: string[]
): ScoredJob[] {
  return candidates.filter(job => {
    for (const constraint of confirmedConstraints) {
      const config = CONSTRAINT_FILTER_MAP[constraint]
      if (!config) continue

      const attrValue = job.attributes[config.attributeField]
      if (config.riskValues.includes(attrValue)) {
        // 완전 제외 (Hard Filter)
        return false
      }
    }
    return true
  })
}
```

### 2.3 Step 3: 유사 직업 선정

```typescript
interface ReplacementCriteria {
  // 원래 TOP3 직업과 유사성 유지
  sameInterestTags: boolean    // 흥미 태그 유사
  sameWorkStyle: boolean       // 업무 스타일 유사
  similarIncomeRange: boolean  // 수입 범위 유사 (±20)
  
  // 새 제약 만족
  satisfiesConstraint: boolean
}

function findReplacement(
  rejectedJob: ScoredJob,
  remainingCandidates: ScoredJob[],
  originalTop10: ScoredJob[],
  confirmedConstraint: string
): ScoredJob | null {
  // 1. 원래 TOP10 중 Safe한 것 우선
  const safeFromTop10 = originalTop10.filter(job => 
    !isRiskForConstraint(job, confirmedConstraint)
  )
  
  if (safeFromTop10.length > 0) {
    // 유사도 계산 후 가장 유사한 것 반환
    return findMostSimilar(rejectedJob, safeFromTop10)
  }

  // 2. 전체 후보에서 유사한 것 찾기
  const similarCandidates = remainingCandidates
    .filter(job => calculateSimilarity(rejectedJob, job) > 0.5)
    .sort((a, b) => b.scores.fit - a.scores.fit)

  return similarCandidates[0] || null
}

function calculateSimilarity(job1: ScoredJob, job2: ScoredJob): number {
  let score = 0
  
  // 1. 흥미 태그 유사도 (0~0.3)
  const interestOverlap = intersection(
    job1.attributes.interest_tags,
    job2.attributes.interest_tags
  ).length / Math.max(job1.attributes.interest_tags.length, 1)
  score += interestOverlap * 0.3

  // 2. 업무 스타일 유사도 (0~0.3)
  const styleFields = ['teamwork', 'solo_deep', 'analytical', 'creative']
  let styleDiff = 0
  for (const field of styleFields) {
    styleDiff += Math.abs(job1.attributes[field] - job2.attributes[field])
  }
  const styleScore = 1 - (styleDiff / (styleFields.length * 100))
  score += styleScore * 0.3

  // 3. 수입 유사도 (0~0.2)
  const incomeDiff = Math.abs(job1.attributes.income - job2.attributes.income)
  score += (1 - incomeDiff / 100) * 0.2

  // 4. 같은 버킷/분류 (0~0.2)
  if (job1.bucket === job2.bucket) score += 0.2

  return score
}
```

### 2.4 Step 4: 결과 갱신

```typescript
interface ReplacementResult {
  original_job: {
    job_id: string
    job_name: string
    rank: number  // 1, 2, or 3
  }
  replacement_job: {
    job_id: string
    job_name: string
    similarity_score: number
  }
  reason: string  // "confirmed_constraint.work_hours_strict"
}

interface UpdatedAnalysisResult {
  // 기존 result_json 필드들...
  
  // 새로 추가
  rank_change: {
    changed: boolean
    replacements: ReplacementResult[]
    before_top3: string[]
    after_top3: string[]
  }
}

async function updateResultWithReplacement(
  db: D1Database,
  requestId: number,
  originalResult: AnalysisResultJSON,
  replacements: ReplacementResult[]
): Promise<UpdatedAnalysisResult> {
  const beforeTop3 = originalResult.fit_top3.map(j => j.job_name)
  
  // TOP3 교체
  const newTop3 = [...originalResult.fit_top3]
  for (const rep of replacements) {
    const idx = newTop3.findIndex(j => j.job_id === rep.original_job.job_id)
    if (idx >= 0) {
      newTop3[idx] = rep.replacement_job
    }
  }

  const afterTop3 = newTop3.map(j => j.job_name)

  const updatedResult: UpdatedAnalysisResult = {
    ...originalResult,
    fit_top3: newTop3,
    rank_change: {
      changed: true,
      replacements,
      before_top3: beforeTop3,
      after_top3: afterTop3,
    }
  }

  // DB 업데이트
  await db.prepare(`
    UPDATE ai_analysis_results
    SET result_json = ?
    WHERE request_id = ?
  `).bind(JSON.stringify(updatedResult), requestId).run()

  return updatedResult
}
```

---

## 3. API 흐름

### 3.1 Follow-up "no" 요청

```
POST /api/ai-analyzer/followup
{
  "session_id": "session-123",
  "request_id": 1,
  "question_id": "q-work-hours",
  "constraint": "work_hours_strict",
  "job_id": "job-456",
  "answer": "no"
}
```

### 3.2 응답

```json
{
  "success": true,
  "action": "replaced",
  "rank_change": {
    "changed": true,
    "replacements": [
      {
        "original_job": {
          "job_id": "job-456",
          "job_name": "투자은행원",
          "rank": 2
        },
        "replacement_job": {
          "job_id": "job-789",
          "job_name": "금융데이터분석가",
          "similarity_score": 0.72
        },
        "reason": "confirmed_constraint.work_hours_strict"
      }
    ],
    "before_top3": ["데이터분석가", "투자은행원", "컨설턴트"],
    "after_top3": ["데이터분석가", "금융데이터분석가", "컨설턴트"]
  },
  "fact_saved": {
    "fact_key": "confirmed_constraint.work_hours_strict",
    "fact_level": 1
  }
}
```

---

## 4. 다양성 룰 준수

### 4.1 대체 시 다양성 검사

```typescript
const DIVERSITY_RULES = {
  MAX_SAME_BUCKET: 2,      // 같은 버킷 최대 2개
  MAX_SAME_MEDIUM: 2,      // 같은 중분류 최대 2개
}

function checkDiversityAfterReplacement(
  newTop3: ScoredJob[]
): boolean {
  // 버킷 카운트
  const bucketCounts: Record<string, number> = {}
  for (const job of newTop3) {
    bucketCounts[job.bucket] = (bucketCounts[job.bucket] || 0) + 1
    if (bucketCounts[job.bucket] > DIVERSITY_RULES.MAX_SAME_BUCKET) {
      return false
    }
  }

  // 중분류 카운트
  const mediumCounts: Record<string, number> = {}
  for (const job of newTop3) {
    const medium = job.classifications?.medium || ''
    mediumCounts[medium] = (mediumCounts[medium] || 0) + 1
    if (mediumCounts[medium] > DIVERSITY_RULES.MAX_SAME_MEDIUM) {
      return false
    }
  }

  return true
}
```

### 4.2 다양성 위반 시

다양성 위반하면 그 다음 후보로 넘어가서 검색:

```typescript
function findDiverseReplacement(
  rejectedJob: ScoredJob,
  candidates: ScoredJob[],
  currentTop3: ScoredJob[]
): ScoredJob | null {
  const sortedCandidates = candidates.sort((a, b) => 
    calculateSimilarity(rejectedJob, b) - calculateSimilarity(rejectedJob, a)
  )

  for (const candidate of sortedCandidates) {
    const newTop3 = [...currentTop3.filter(j => j.job_id !== rejectedJob.job_id), candidate]
    if (checkDiversityAfterReplacement(newTop3)) {
      return candidate
    }
  }

  return null  // 다양성 만족하는 대체 직업 없음
}
```

---

## 5. 에러 처리

### 5.1 대체 직업 없음

```typescript
if (!replacement) {
  return {
    success: true,
    action: "removed",
    message: "대체 가능한 Safe 직업이 없어 TOP3에서 제외되었습니다.",
    rank_change: {
      changed: true,
      replacements: [],
      before_top3: beforeTop3,
      after_top3: afterTop3.filter(j => j !== rejectedJob.job_name),
    }
  }
}
```

### 5.2 이미 확정된 제약

```typescript
const existingConstraint = await db.prepare(`
  SELECT * FROM facts
  WHERE session_id = ? AND fact_key = ?
`).bind(sessionId, `confirmed_constraint.${constraintType}`).first()

if (existingConstraint) {
  return {
    success: true,
    action: "already_confirmed",
    message: "이미 확인된 제약 조건입니다.",
  }
}
```

---

## 6. 테스트 시나리오

### 6.1 기본 대체

```
입력:
- TOP3: [개발자A, 투자은행원, 컨설턴트]
- Follow-up: "투자은행원 야근 많아도 괜찮아요?" → "no"

예상 결과:
- TOP3: [개발자A, 금융분석가, 컨설턴트]
- 투자은행원 → 금융분석가 (유사 금융 분야, 야근 적음)
```

### 6.2 다양성 위반 방지

```
입력:
- TOP3: [개발자A, 개발자B, 컨설턴트]
- Follow-up: "개발자B 야근 많아도 괜찮아요?" → "no"
- 후보: 개발자C, 데이터분석가, ...

예상 결과:
- TOP3: [개발자A, 데이터분석가, 컨설턴트]
- 개발자C는 다양성 위반으로 스킵 → 데이터분석가 선택
```

### 6.3 대체 불가

```
입력:
- TOP3: [간호사A, 간호사B, 물리치료사]
- 제약: 모든 의료직 교대근무 필수
- Follow-up: "교대근무 괜찮아요?" → "no"

예상 결과:
- 대체 가능한 Safe 직업 없음
- TOP3에서 해당 직업 제외 또는 경고 표시
```

---

## 7. 구현 체크리스트

- [ ] `handleFollowupNo()` 함수 구현
- [ ] `filterCandidates()` 함수 구현
- [ ] `findReplacement()` 함수 구현
- [ ] `updateResultWithReplacement()` 함수 구현
- [ ] 다양성 검사 로직 추가
- [ ] API 응답에 `rank_change` 포함
- [ ] UI에서 대체 결과 표시
- [ ] 테스트 시나리오 통과

---

*Version: v1.0.0*
*Created: 2026-01-05*






