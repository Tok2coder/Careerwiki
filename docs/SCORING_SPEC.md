# CareerWiki Scoring Spec v0.2.1 (Hard Filter Zero + Risk Policy Refined)

> 작성일: 2026-01-02
> 버전: scoring-v0.2.1
> 목적: 추천 엔진의 점수 계산 규칙 정의 (하드필터 완전 제거 + 페널티 정책 정교화)

---

## 0. 핵심 원칙 (v0.2 변경사항)

### 0.1 하드필터 완전 제거
```
❌ 이전: "야근 절대 불가" → 직업 탈락
✅ 현재: "야근 절대 불가" → 강한 페널티 + Caution 분류 + 경고문
```

### 0.2 왜 하드필터를 없애는가?
1. **직업 ≠ 회사/팀**: 같은 직업도 회사/포지션/시즌에 따라 야근/재택이 다름
2. **태깅 정밀도 한계**: `wlb`, `remote_possible` 같은 건 추정값이라 "단정(탈락)"은 위험
3. **유저 선택권**: "절대 싫지만 그래도 보고 싶다"는 케이스 존재

### 0.3 대신 어떻게 처리하는가?
```
탈락(삭제) → Risk Penalty + Caution Bucket + 명확한 경고문 + 재확인 질문
```

---

## 1. 점수 체계

### 1.1 점수 범위
| 점수 | 범위 | 의미 |
|------|------|------|
| Like | 0~100 | 좋아할 확률 |
| Can | 0~100 | 잘할 확률 |
| RiskPenalty | 0~80 | 제약 충돌 감점 (상한 80) |

### 1.2 Fit 점수 공식
```
Fit = 0.5 × Like + 0.5 × Can - RiskPenalty
```

**범위**: 이론상 -80 ~ 100 (실제로는 대부분 0~100)

### 1.3 결과 버킷 분류
| 버킷 | 조건 | 설명 |
|------|------|------|
| **Safe** | `RiskPenalty == 0` | 제약 충돌 없음 |
| **Caution** | `RiskPenalty > 0` | 제약 충돌 가능성 있음 |

---

## 2. Risk 정책 (핵심)

### 2.1 Risk 상태 정의
| 상태 | 페널티 | 조건 | 설명 |
|------|--------|------|------|
| **OK** | 0 | 충돌 없음 | Safe 버킷 |
| **UNKNOWN** | 0 (중립) | 데이터 불충분 | "확인 필요" 뱃지 (상태만 유지) |
| **RISK** | 25~40 | 명확히 충돌 | Caution + 강한 경고문 |

> ⚠️ **v0.2.1 변경**: 페널티는 **양수**로 통일, UNKNOWN은 **점수 0 + 상태만 유지**

### 2.2 페널티 강도 테이블 (양수 통일)

> ⚠️ **v0.2.1 Final**: constraint_type은 **폼 스키마 키로 통일** (아래 5개만 허용)

| constraint_type (표준) | RISK 페널티 | UNKNOWN 페널티 | 비고 |
|-----------------------|-------------|----------------|------|
| `work_hours_strict` | 40 | 0 | 야근 절대 불가 |
| `remote_only` | 35 | 0 | 원격만 가능 |
| `shift_work_no` | 40 | 0 | 교대근무 절대 불가 |
| `degree_impossible` | 30 | 0 | 학위 취득 불가 |
| `license_impossible` | 25 | 0 | 자격증 준비 불가 |

**금지 키 (사용 금지)**:
- ❌ `work_hours` → ✅ `work_hours_strict`
- ❌ `shift_work` → ✅ `shift_work_no`
- ❌ `degree_required` → ✅ `degree_impossible`
- ❌ `license_required` → ✅ `license_impossible`

> **UNKNOWN 처리 원칙**: 페널티는 0 (모르니까 감점도 확신 못함), 하지만 상태는 UNKNOWN 유지 + "확인 필요" 뱃지 표시

### 2.3 RiskPenalty 계산
```typescript
function calculateRiskPenalty(
  user: UserConstraints,
  job: JobAttributes
): RiskResult {
  const risks: RiskItem[] = []
  let totalPenalty = 0
  
  // 1. 야근 체크
  if (user.work_hours_strict) {
    const result = checkWorkHours(job.wlb, job._confidence)
    risks.push(result)
    totalPenalty += result.penalty
  }
  
  // 2. 원격 체크
  if (user.remote_only) {
    const result = checkRemote(job.environment, job._confidence)
    risks.push(result)
    totalPenalty += result.penalty
  }
  
  // 3. 교대근무 체크
  if (user.shift_work_no) {
    const result = checkShiftWork(job.wlb, job._confidence)
    risks.push(result)
    totalPenalty += result.penalty
  }
  
  // 4. 학위 체크
  if (user.degree_impossible) {
    const result = checkDegree(job.entry_requirements, job._confidence)
    risks.push(result)
    totalPenalty += result.penalty
  }
  
  // 5. 자격증 체크
  if (user.license_impossible) {
    const result = checkLicense(job.entry_requirements, job._confidence)
    risks.push(result)
    totalPenalty += result.penalty
  }
  
  // 상한 적용: 합산 후 clamp (항목별 아님)
  // 예: work_hours_strict(40) + remote_only(35) + degree_impossible(30) = 105 → 80으로 clamp
  totalPenalty = Math.min(totalPenalty, 80)
  
  // ⚠️ risk breakdown은 항상 포함 (캘리브레이션/디버깅 필수)
  return {
    total: totalPenalty,
    items: risks,  // 항목별 status/penalty/confidence 필수!
    hasUnknown: risks.some(r => r.status === 'UNKNOWN'),
    bucket: determineBucket(totalPenalty, risks)
  }
}

// 버킷 결정 로직
function determineBucket(
  penalty: number, 
  risks: RiskItem[]
): 'safe_known' | 'safe_unknown' | 'caution' {
  if (penalty > 0) return 'caution'
  if (risks.some(r => r.status === 'UNKNOWN')) return 'safe_unknown'
  return 'safe_known'
}
```

### 2.4 Confidence 반영 (필드별 신뢰도 기반 조정)

> ⚠️ **v0.2.1 변경**: 전체 `_confidence`가 아닌 **해당 필드의 `_field_confidence`**만 사용

Risk 완화는 **해당 제약의 필드 confidence**만 봄:
- 야근(wlb) → `_field_confidence.wlb`
- 원격(remote) → `_field_confidence.remote_possible`
- 학위/자격 → `_field_confidence.degree_required` / `license_required`

```typescript
function adjustForFieldConfidence(
  rawStatus: 'OK' | 'UNKNOWN' | 'RISK',
  fieldConfidence: number | 'low' | 'medium' | 'high'
): 'OK' | 'UNKNOWN' | 'RISK' {
  
  // confidence를 숫자로 변환
  const confNum = typeof fieldConfidence === 'number' 
    ? fieldConfidence 
    : { low: 0.3, medium: 0.6, high: 0.9 }[fieldConfidence]
  
  // 신뢰도 낮으면 RISK를 UNKNOWN으로 완화
  if (rawStatus === 'RISK' && confNum < 0.5) {
    return 'UNKNOWN'  // 확신 없으니 RISK 대신 UNKNOWN
  }
  
  // ❌ UNKNOWN을 OK로 보내지 않음! (상태는 유지, 페널티만 0)
  // UNKNOWN은 "모른다"는 상태 자체가 의미 있음
  
  return rawStatus
}

// 사용 예시
function checkWorkHours(
  jobWlb: string, 
  fieldConfidence: JobAttributes['_field_confidence']
): RiskItem {
  const rawStatus = jobWlb === 'high_overtime' ? 'RISK' 
                  : jobWlb === 'unknown' ? 'UNKNOWN' 
                  : 'OK'
  
  // ✅ 해당 필드의 confidence만 사용
  const adjustedStatus = adjustForFieldConfidence(rawStatus, fieldConfidence.wlb)
  
  return {
    constraint: 'work_hours_strict',  // ✅ 표준 키 사용 (work_hours 금지!)
    status: adjustedStatus,
    penalty: adjustedStatus === 'RISK' ? 40 : 0  // UNKNOWN은 0점
  }
}
```

---

## 3. 유저 제약 입력 구분

### 3.1 Non-negotiable vs Preference

폼에서 제약을 2단계로 구분:

| 유형 | 의미 | Risk 처리 | UX |
|------|------|----------|-----|
| **Non-negotiable** | "절대 불가" | RISK → 강페널티 (-25~-40) | Caution 강제 + 경고문 + 재확인 질문 |
| **Preference** | "선호" | RISK → 약페널티 (-10~-15) | Caution 분류만 |

### 3.2 입력 스키마

```typescript
interface UserConstraints {
  // Non-negotiable (절대 불가)
  work_hours_strict?: boolean      // "야근 절대 불가"
  remote_only?: boolean            // "원격만 가능"
  shift_work_no?: boolean          // "교대근무 절대 불가"
  degree_impossible?: boolean      // "학위 취득 불가"
  license_impossible?: boolean     // "자격증 준비 불가"
  
  // Preference (선호)
  prefer_low_overtime?: boolean    // "야근 적은 곳 선호"
  prefer_remote?: boolean          // "원격 선호"
  prefer_stability?: boolean       // "안정성 선호"
  learning_window_months?: number  // "N개월 내 진입 희망"
}
```

### 3.3 페널티 차등 적용 (양수 통일)

```typescript
const PENALTY_TABLE = {
  // Non-negotiable → 강페널티 (양수)
  work_hours_strict: { RISK: 40, UNKNOWN: 0 },
  remote_only: { RISK: 35, UNKNOWN: 0 },
  shift_work_no: { RISK: 40, UNKNOWN: 0 },
  degree_impossible: { RISK: 30, UNKNOWN: 0 },
  license_impossible: { RISK: 25, UNKNOWN: 0 },
  
  // Preference → 약페널티 (양수)
  prefer_low_overtime: { RISK: 15, UNKNOWN: 0 },
  prefer_remote: { RISK: 10, UNKNOWN: 0 },
}

// 사용
totalPenalty += PENALTY_TABLE[constraint][status]
// 최종: Fit = 0.5*Like + 0.5*Can - totalPenalty
```

---

## 3.5 Like/Can vs Risk 역할 분리 (중복 감점 방지)

> ⚠️ **v0.2.1 추가**: 같은 요소가 Like와 Risk에서 이중 감점되지 않도록 역할 분리

### 원칙

| 점수 | 역할 | 포함 | 제외 |
|------|------|------|------|
| **Like** | 취향/적성 | 흥미, 가치관, 업무스타일 선호 | 현실 제약 (야근/교대/원격 등) |
| **Can** | 역량/적합성 | 스킬, 경험, 학습가능성 | 현실 제약 |
| **RiskPenalty** | 현실 제약 | 야근, 교대, 원격, 학위, 자격증, 학습기간 | 취향/역량 |

### 구현 규칙

```typescript
// dislike.keywords 분류
const CONSTRAINT_KEYWORDS = ['야근', '교대', '출장', '현장', '재택불가']
const PREFERENCE_KEYWORDS = ['사람', '숫자', '반복', '창의', '분석']

function separateDislikeKeywords(dislikeKeywords: string[]) {
  return {
    // Like에서 감점 (취향)
    forLike: dislikeKeywords.filter(k => 
      !CONSTRAINT_KEYWORDS.some(c => k.includes(c))
    ),
    // Risk에서 처리 (현실 제약) → Like에서 제외
    forRisk: dislikeKeywords.filter(k => 
      CONSTRAINT_KEYWORDS.some(c => k.includes(c))
    )
  }
}

// Like 싫은 것 회피 점수에서는 forLike만 사용
function calculateDislikeAvoidance(user: User, job: Job): number {
  const { forLike } = separateDislikeKeywords(user.dislike.keywords)
  // forLike만 사용 → 야근 싫다가 Risk랑 중복 감점 안됨
  // ...
}
```

> **효과**: "야근 싫음" → Risk에서 40점 감점만. Like에서 또 감점되지 않음.

---

## 3.6 유저 하드-제외 (UI 프리퍼런스 필터)

> ⚠️ **v0.2.1 추가**: 하드필터를 시스템이 아닌 **유저 선택**으로 옮김

### 왜 필요한가?

하드필터(시스템 탈락)는 없애되, 유저가 **결과에서 아예 숨기기**는 필요함.

### UI 제공 방식

```typescript
// 결과 화면 필터 옵션
interface ResultFilterOptions {
  // 기본값: 모두 false (Caution도 보여줌)
  hideRiskWorkHours: boolean    // 야근 RISK 직업 숨김
  hideRiskRemote: boolean       // 원격불가 RISK 직업 숨김
  hideRiskShiftWork: boolean    // 교대근무 RISK 직업 숨김
  hideRiskDegree: boolean       // 학위필수 RISK 직업 숨김
  hideRiskLicense: boolean      // 자격증필수 RISK 직업 숨김
  hideAllCaution: boolean       // 모든 Caution 직업 숨김
}
```

### UX 예시

```
📋 추천 결과 (총 23개)
  
[필터] ☑️ 조건 충돌 직업도 보기 (Caution 포함)
       ☐ 야근 RISK만 숨기기
       ☐ 자격증 RISK만 숨기기
```

### 서버 vs 클라이언트

| 방식 | 설명 |
|------|------|
| **서버 필터링** | 결과 JSON 생성 시 숨김 (추천) |
| **클라이언트 필터링** | 전체 결과 받고 UI에서 숨김 |

> **추천**: 서버에서 필터링하되, `caution_jobs` 전체도 함께 보내서 유저가 토글하면 보이게

---

## 4. Like 점수 구성 (0~100)

### 4.1 구성 요소
| 요소 | 배점 | 설명 |
|------|------|------|
| 흥미 매칭 | 40점 | 유저 관심사 ↔ 직업 흥미 태그 |
| 가치관 매칭 | 30점 | 유저 가치관 ↔ 직업 가치 태그 |
| 싫은 것 회피 | 30점 | 유저 싫은 것 ↔ 직업 텍스트/태그 |

### 4.2 정규화 원칙
- 각 항목은 **0~1로 정규화 후 배점 반영**
- 태그 결손(empty/unknown)은 **중립 점수** (배점의 50%)
- 유저 입력 없으면 **중립 점수**

```typescript
// 흥미 매칭 예시 (40점 만점)
function calculateInterestScore(user: User, job: Job): number {
  const userTags = mapToHollandCodes(user.interest.keywords)
  const jobTags = job.job_attributes.interest_tags
  
  // 입력 없으면 중립
  if (userTags.length === 0) return 20
  if (jobTags.length === 0) return 20
  
  const overlap = intersection(userTags, jobTags)
  const ratio = overlap.length / Math.min(userTags.length, 4)
  
  return Math.round(ratio * 40)
}
```

---

## 5. Can 점수 구성 (0~100)

### 5.1 구성 요소
| 요소 | 배점 | 설명 |
|------|------|------|
| 스킬 매칭 | 60점 | 유저 스킬 ↔ 직업 필요 스킬 |
| 경험/학습가능성 | 40점 | 관련 경험 + 학습 여력 |

### 5.2 정규화 원칙
- Like와 동일하게 0~1 정규화 후 배점 반영
- 입력/태그 없으면 중립 점수

---

## 6. 후보 추출 (Vector Search)

> ⚠️ **v0.2.1 추가**: 후보 50개 뽑는 단계가 성능의 70%를 좌우함

### 6.0.1 후보 추출 입력 (쿼리 생성)

**입력 구성**:
```typescript
function buildCandidateQuery(user: UserProfile): string {
  // 1. 핵심 키워드 합성 (최대 100토큰)
  const keywords = [
    ...user.interest.keywords.slice(0, 3),        // 흥미 키워드 상위 3개
    ...user.value.priority.slice(0, 2),           // 가치관 상위 2개
    ...user.skill.map(s => s.name).slice(0, 3),   // 스킬 상위 3개
  ].join(' ')
  
  // 2. 선호 업무 방식 (있으면)
  const workStyle = user.preference?.work_style || ''
  
  // 3. 기본 폼 요약 (자유 서술 있으면)
  const summary = user.form_summary?.slice(0, 200) || ''
  
  return `${keywords} ${workStyle} ${summary}`.trim()
}
```

**쿼리 예시**:
```
"AI 데이터분석 성장 자율 python sql 분석형 업무"
```

### 6.0.2 후보 풀 크기 설정

> ⚠️ **v0.2.1 Final**: 다양성 룰(max 2) 충돌 방지를 위해 **80~120개 확보 권장**

| 설정 | 기본값 | 범위 | 비고 |
|------|--------|------|------|
| `CANDIDATE_POOL_SIZE` | 80 | 50~120 | 다양성 룰 적용 시 TOP3 모자람 방지 |
| `MIN_SCORE` | 0.5 | 0.4~0.7 | 유사도 임계값 |
| `FALLBACK_POOL_SIZE` | 200 | 150~300 | 폴백 시 확장 |

**다양성 룰 충돌 시나리오**:
- 후보 50개 중 40개가 'IT/개발' 중분류 → max 2 적용하면 TOP3에 2개만 가능
- **해결**: 후보 풀을 80~120으로 늘려서 다른 중분류 후보도 충분히 확보

### 6.0.3 후보 추출 실패 시 폴백

| 상황 | 폴백 전략 |
|------|----------|
| **후보 < 20개** | interest_tags 기반 broad 검색 (200개) → 그 중 상위 80개 |
| **후보가 너무 다양** (유사도 낮음) | topK를 120으로 늘리고 minScore 0.4로 낮춤 |
| **후보 0개** | 인기 직업 + 유저 interest 기반 추천 (탐색 모드) |

**폴백 코드**:
```typescript
const CANDIDATE_POOL_SIZE = 80  // ✅ 50 → 80 (다양성 룰 충돌 방지)

async function getCandidates(
  query: string,
  userInterests: string[]
): Promise<ScoredJob[]> {
  // 1차 시도: 정밀 검색 (80개)
  let candidates = await vectorSearch(query, { topK: CANDIDATE_POOL_SIZE, minScore: 0.5 })
  
  // 폴백 1: 후보 부족
  if (candidates.length < 20) {
    const broadQuery = userInterests.join(' ')  // interest만으로
    const broadCandidates = await vectorSearch(broadQuery, { topK: 200, minScore: 0.4 })
    candidates = [...candidates, ...broadCandidates].slice(0, 50)
  }
  
  // 폴백 2: 완전 실패
  if (candidates.length === 0) {
    candidates = await getPopularJobsByInterest(userInterests)
  }
  
  return candidates
}
```

---

## 7. 결과 선정 규칙

### 7.1 버킷 분리 (3단계)

> ⚠️ **v0.2.1 추가**: UNKNOWN이 Safe로 섞이는 문제 해결을 위해 3단계 버킷

```typescript
interface BucketedResults {
  safe_known: ScoredJob[]    // RiskPenalty === 0 && Risk 상태에 UNKNOWN 없음
  safe_unknown: ScoredJob[]  // RiskPenalty === 0 && Risk 상태에 UNKNOWN 있음
  caution: ScoredJob[]       // RiskPenalty > 0 (RISK 상태 있음)
}

function separateBuckets(jobs: ScoredJob[]): BucketedResults {
  return {
    // Safe 중에서도 "확실히 OK"인 것과 "UNKNOWN이 있는 것" 분리
    safe_known: jobs.filter(j => 
      j.risk.total === 0 && 
      !j.risk.items.some(r => r.status === 'UNKNOWN')
    ),
    safe_unknown: jobs.filter(j => 
      j.risk.total === 0 && 
      j.risk.items.some(r => r.status === 'UNKNOWN')
    ),
    caution: jobs.filter(j => j.risk.total > 0)
  }
}
```

**버킷 설명**:

| 버킷 | 조건 | 의미 | 배지 |
|------|------|------|------|
| **safe_known** | penalty=0, UNKNOWN 없음 | 완전히 확인됨 | ✅ 안전 |
| **safe_unknown** | penalty=0, UNKNOWN 있음 | 감점은 없지만 불확실 | ⚠️ 일부 확인 필요 |
| **caution** | penalty > 0 | 제약 충돌 가능성 | 🚨 주의 |

### 6.1.1 safe_unknown 처리 정책 (필수)

> ⚠️ **v0.2.1 확정**: safe_unknown이 TOP3에 들어올 때의 행동

**정책 2줄**:

1. **safe_unknown이 TOP3에 포함되면** → 해당 직업에 "⚠️ 일부 정보 확인 필요" 배지 + UNKNOWN 필드별 근거 표시 + 확인 질문 후보로 올림
2. **safe_unknown이 전체 후보의 50% 이상이면** → "이 직업군은 정보가 부족합니다. 다른 분야도 살펴보세요" 안내 + safe_known 비율 높은 다른 직업군 추천

**구현 코드**:

```typescript
// ✅ 시그니처에 buckets, totalCandidates 명시 (스코프 오류 방지)
function handleSafeUnknownInTop3(
  top3: ScoredJob[],
  sources: ('safe_known' | 'safe_unknown' | 'caution')[],
  buckets: BucketedResults,  // ← 추가
  totalCandidates: number    // ← 추가
): {
  unknownWarnings: UnknownWarning[]
  shouldSuggestOtherFields: boolean
} {
  const unknownJobs = top3.filter((_, i) => sources[i] === 'safe_unknown')
  
  // 1. safe_unknown 직업에 배지 + 확인 질문 생성
  const unknownWarnings = unknownJobs.map(job => ({
    job_id: job.job_id,
    badge: '⚠️ 일부 정보 확인 필요',
    unknown_fields: job.risk.items
      .filter(r => r.status === 'UNKNOWN')
      .map(r => r.constraint_label),
    confirmation_hint: '면접에서 확인해보세요'
  }))
  
  // 2. UNKNOWN 비율 체크
  const shouldSuggestOtherFields = 
    (buckets.safe_unknown.length / totalCandidates) > 0.5
  
  return { unknownWarnings, shouldSuggestOtherFields }
}
```

### 6.2 Fit TOP 3 선정 로직 (우선순위)

> **우선순위**: safe_known > safe_unknown > caution

```typescript
function selectFitTop3(buckets: BucketedResults): {
  top3: ScoredJob[]
  sources: ('safe_known' | 'safe_unknown' | 'caution')[]
  needsWarning: boolean
  hasUnknown: boolean
} {
  const safeKnownSorted = buckets.safe_known.sort((a, b) => b.fit - a.fit)
  const safeUnknownSorted = buckets.safe_unknown.sort((a, b) => b.fit - a.fit)
  const cautionSorted = buckets.caution.sort((a, b) => b.fit - a.fit)
  
  const top3: ScoredJob[] = []
  const sources: ('safe_known' | 'safe_unknown' | 'caution')[] = []
  
  // 1순위: safe_known에서 채우기
  for (const job of safeKnownSorted) {
    if (top3.length >= 3) break
    top3.push(job)
    sources.push('safe_known')
  }
  
  // 2순위: 부족하면 safe_unknown에서 보충
  if (top3.length < 3) {
    for (const job of safeUnknownSorted) {
      if (top3.length >= 3) break
      top3.push(job)
      sources.push('safe_unknown')
    }
  }
  
  // 3순위: 그래도 부족하면 Caution에서 보충
  if (top3.length < 3) {
    for (const job of cautionSorted) {
      if (top3.length >= 3) break
      top3.push(job)
      sources.push('caution')
    }
  }
  
  return {
    top3,
    sources,
    needsWarning: sources.includes('caution'),
    hasUnknown: sources.includes('safe_unknown')
  }
}
```

### 6.3 Caution TOP3 → follow-up 질문 자동 생성 (필수)

> ⚠️ **v0.2.1 정책**: TOP3에 Caution이 포함되면 **반드시** follow-up 질문 생성

```typescript
function generateFollowupIfNeeded(
  top3: ScoredJob[], 
  sources: ('safe' | 'caution')[]
): FollowupQuestion[] {
  
  // Caution이 TOP3에 없으면 생략
  if (!sources.includes('caution')) return []
  
  const questions: FollowupQuestion[] = []
  
  // Caution 직업들의 Risk 상세 수집
  const cautionJobs = top3.filter((_, i) => sources[i] === 'caution')
  
  for (const job of cautionJobs) {
    for (const risk of job.risk_details || []) {
      if (risk.status === 'RISK') {
        questions.push({
          id: `confirm_${job.job_id}_${risk.constraint}`,
          question: FOLLOWUP_TEMPLATES[risk.constraint](job.job_name, risk.job_value),
          context: `"${job.job_name}"이 추천 TOP3에 포함되었습니다`,
          options: {
            yes: { 
              label: '네, 그래도 알아볼게요', 
              effect: 'Caution 유지, 추천 포함' 
            },
            no: { 
              label: '이 조건은 안 맞아요', 
              effect: '추천에서 제외 (Safe 직업으로 대체)' 
            }
          },
          affects_jobs: [job.job_id]
        })
      }
    }
  }
  
  return questions
}

// follow-up 질문 템플릿
const FOLLOWUP_TEMPLATES = {
  work_hours_strict: (jobName: string, value: string) => 
    `"${jobName}"는 야근이 잦을 수 있어요. 그래도 괜찮으세요?`,
  remote_only: (jobName: string, value: string) => 
    `"${jobName}"는 현장 출근이 필요해요. 가능하세요?`,
  shift_work_no: (jobName: string, value: string) => 
    `"${jobName}"는 교대근무가 있을 수 있어요. 괜찮으세요?`,
  degree_impossible: (jobName: string, value: string) => 
    `"${jobName}"는 학위가 필요해요. 학위 취득을 고려하시겠어요?`,
  license_impossible: (jobName: string, value: string) => 
    `"${jobName}"는 자격증이 필요해요. 준비 가능하세요?`,
}
```

### follow-up 응답 처리 (v0.2.1 완성형)

> ⚠️ **핵심 정책**:
> 1. "no" 응답 시 Safe 직업으로 **즉시 대체** (다양성 룰 적용)
> 2. 응답을 **fact로 저장**하여 다음 분석에 자동 반영 (Event Sourcing)

### fact key 네이밍 규칙 (고정)

> ⚠️ **이 네이밍을 바꾸지 마세요!** 다음 분석 시 자동 반영에 사용됨

| 응답 | fact_key 패턴 | 의미 | 다음 분석 시 |
|------|--------------|------|-------------|
| **"no"** | `confirmed_constraint.{constraint}` | 이 조건 절대 불가 확정 | 해당 Risk → 강페널티 자동 적용 |
| **"yes"** | `accepted_risk.{constraint}.{job_id}` | 이 직업의 이 조건은 수용 | 해당 직업만 Risk 완화 |

**constraint 값 목록** (고정):
- `work_hours_strict` - 야근
- `remote_only` - 원격
- `shift_work_no` - 교대근무
- `degree_impossible` - 학위
- `license_impossible` - 자격증

**예시**:
```typescript
// "no" 응답 시 → 다음 분석부터 사실상 "하드필터"처럼 작동
{ fact_key: 'confirmed_constraint.work_hours_strict', ... }

// "yes" 응답 시 → 해당 직업만 Risk 완화
{ fact_key: 'accepted_risk.work_hours_strict.lawyer', ... }
```

```typescript
interface FollowupResponse {
  question_id: string
  answer: 'yes' | 'no'
  constraint: string  // 'work_hours_strict', 'remote_only' 등
  job_id: string
}

async function handleFollowupResponse(
  response: FollowupResponse,
  currentResults: AnalysisResultJSON,
  buckets: BucketedResults,
  userId: string
): Promise<{
  updatedResults: AnalysisResultJSON
  factToSave?: ExtractedFact  // Event Sourcing용
}> {
  
  if (response.answer === 'no') {
    // ===== 1. TOP3에서 제거 =====
    const newTop3 = currentResults.fit_top3.filter(
      j => j.job_id !== response.job_id
    )
    
    // ===== 2. 대체 직업 선정 (우선순위 + 다양성) =====
    const alreadyInTop3 = new Set(newTop3.map(j => j.job_id))
    
    // 대체 후보: safe_known → safe_unknown → caution 순서
    const replacementCandidates = [
      ...buckets.safe_known.filter(j => !alreadyInTop3.has(j.job_id)),
      ...buckets.safe_unknown.filter(j => !alreadyInTop3.has(j.job_id)),
      // caution은 또 같은 문제 생길 수 있어서 safe만 사용
    ].sort((a, b) => b.fit - a.fit)
    
    // 다양성 룰 적용하여 대체 직업 1개 선정
    const replacement = selectReplacementWithDiversity(
      replacementCandidates, 
      newTop3
    )
    
    if (replacement) {
      newTop3.push(replacement)
    }
    
    // ===== 3. 응답을 Fact로 저장 (다음 분석에 반영) =====
    const factToSave: ExtractedFact = {
      fact_key: `confirmed_constraint.${response.constraint}`,
      fact_value: { strict: true, confirmed_at: new Date().toISOString() },
      confidence: 1.0,  // 유저가 직접 확인했으므로 최고 신뢰도
      source: 'followup_response',
      source_span: `${response.question_id}: answered 'no'`
    }
    
    return {
      updatedResults: {
        ...currentResults,
        fit_top3: newTop3,
        ux_flags: {
          ...currentResults.ux_flags,
          followup_applied: true,
          replaced_jobs: [response.job_id]
        }
      },
      factToSave  // raw_events에 저장하여 다음 분석 시 자동 반영
    }
  }
  
  // ===== 'yes' 응답 시: 결과 유지 + Fact 저장 =====
  const factToSave: ExtractedFact = {
    fact_key: `accepted_risk.${response.constraint}`,
    fact_value: { 
      job_id: response.job_id, 
      accepted_at: new Date().toISOString() 
    },
    confidence: 1.0,
    source: 'followup_response',
    source_span: `${response.question_id}: answered 'yes'`
  }
  
  return {
    updatedResults: currentResults,  // 결과 유지
    factToSave  // "이 유저는 이 조건을 수용했다" 기록
  }
}

// 다양성 룰 적용 대체 직업 선정
function selectReplacementWithDiversity(
  candidates: ScoredJob[],
  currentTop3: ScoredJob[]
): ScoredJob | null {
  const categoryCount = new Map<string, number>()
  
  // 현재 TOP3의 카테고리 카운트
  for (const job of currentTop3) {
    const cat = job.classifications?.medium || 'unknown'
    categoryCount.set(cat, (categoryCount.get(cat) || 0) + 1)
  }
  
  // 다양성 룰(같은 중분류 최대 2개) 만족하는 첫 번째 후보
  for (const candidate of candidates) {
    const cat = candidate.classifications?.medium || 'unknown'
    if ((categoryCount.get(cat) || 0) < 2) {
      return candidate
    }
  }
  
  // 다양성 안 맞아도 Fit 최고인 것
  return candidates[0] || null
}
```

> **핵심**: 
> - "아니요" → Safe에서 대체 (다양성 룰 적용)
> - 모든 응답은 **fact로 저장** → 다음 분석 시 자동 반영 (Event Sourcing)

---

### 6.4 다양성 룰 적용

```typescript
// TOP 3에서 같은 중분류 최대 2개
function applyDiversityRule(
  candidates: ScoredJob[],
  maxSameCategory: number = 2
): ScoredJob[] {
  const result: ScoredJob[] = []
  const categoryCount = new Map<string, number>()
  
  for (const job of candidates) {
    const category = job.classifications?.medium || 'unknown'
    const count = categoryCount.get(category) || 0
    
    if (count < maxSameCategory) {
      result.push(job)
      categoryCount.set(category, count + 1)
      if (result.length >= 3) break
    }
  }
  
  // 다양성 적용 후 부족하면 남은 것에서 채우기
  if (result.length < 3) {
    for (const job of candidates) {
      if (!result.includes(job)) {
        result.push(job)
        if (result.length >= 3) break
      }
    }
  }
  
  return result
}
```

---

## 8. 결과 JSON 구조 (result_json)

### 8.1 전체 구조

```typescript
interface AnalysisResultJSON {
  // 버전 정보
  versions: {
    recipe: string      // 'recipe-v1.0.0'
    tagger: string      // 'tagger-v1.0.0'
    scoring: string     // 'scoring-v0.2.0'
  }
  
  // 입력 요약
  input_summary: {
    profile_revision_id: string
    key_interests: string[]
    key_skills: string[]
    non_negotiables: string[]  // 절대 제약 목록
    preferences: string[]      // 선호 목록
  }
  
  // 메인 결과: Fit TOP 3
  fit_top3: FitRecommendation[]
  
  // 보조 결과
  like_top10: SimpleRecommendation[]
  can_top10: SimpleRecommendation[]
  
  // Caution 후보 전체 (주의 필요)
  caution_jobs: CautionRecommendation[]
  
  // UX 플래그 (v0.2.1 Final)
  ux_flags: {
    // TOP3 상태
    has_caution_in_top3: boolean       // TOP3에 Caution이 포함됨
    has_unknown_in_top3: boolean       // TOP3에 safe_unknown이 포함됨
    needs_followup_question: boolean   // 갈림길 질문 필요 (Caution TOP3시 true)
    
    // 버킷별 카운트 (필터 적용 전)
    counts_before_filter: {
      safe_known: number
      safe_unknown: number
      caution: number
      total: number
    }
    
    // 버킷별 카운트 (유저 필터 적용 후)
    counts_after_filter: {
      safe_known: number
      safe_unknown: number
      caution: number
      total: number
    }
    
    // follow-up 상태
    followup_applied?: boolean         // follow-up 응답으로 결과 변경됨
    replaced_jobs?: string[]           // follow-up으로 제외된 직업 ID
  }
  
  // 갈림길 질문 (선택)
  followup_questions?: FollowupQuestion[]
  
  // LLM 생성 설명
  llm_explanation: string
  
  // 메타
  generated_at: string
  total_candidates: number
}
```

### 8.2 Fit 추천 상세 구조

```typescript
interface FitRecommendation {
  job_id: string
  job_name: string
  job_category: string
  
  // 점수
  scores: {
    fit: number           // 최종 Fit
    like: number          // Like 점수
    can: number           // Can 점수
    risk_penalty: number  // Risk 감점
  }
  
  // 버킷 정보 (v0.2.1 3단계)
  bucket: 'safe_known' | 'safe_unknown' | 'caution'
  
  // 근거 (최소 3개)
  evidence: EvidenceLink[]
  
  // Risk 상세 (항상 포함 - breakdown 필수)
  risk_details: RiskDetail[]  // ✅ 옵셔널 아님! safe_known도 포함
  
  // 요약
  summary: string
  next_steps: string[]
}

interface RiskDetail {
  // constraint_type: 표준 5개만 허용
  constraint: 'work_hours_strict' | 'remote_only' | 'shift_work_no' | 'degree_impossible' | 'license_impossible'
  constraint_label: string   // '야근 절대 불가'
  job_attribute: string      // 'wlb'
  job_value: string          // 'high_overtime' | 'unknown' | 'low_overtime'
  
  // ✅ OK 추가! safe_known에서도 breakdown 필요
  status: 'OK' | 'UNKNOWN' | 'RISK'
  
  penalty: number            // OK=0, UNKNOWN=0, RISK=25~40
  warning_message: string    // OK면 빈 문자열, UNKNOWN이면 "확인 필요", RISK면 경고
  confidence: number         // 태깅 신뢰도 (0~1)
}
```

### 8.3 Caution 후보 구조

```typescript
interface CautionRecommendation {
  job_id: string
  job_name: string
  
  scores: {
    fit: number
    like: number
    can: number
    risk_penalty: number
  }
  
  // Risk 상세 (필수)
  risk_details: RiskDetail[]
  
  // 한 줄 경고
  caution_summary: string  // "야근이 잦고, 자격증이 필요해요"
  
  // 재확인 질문
  confirmation_question?: string  // "그래도 이 직업을 알아보시겠어요?"
}
```

### 8.4 갈림길 질문 구조

```typescript
interface FollowupQuestion {
  id: string
  question: string              // "사람을 많이 상대하는 일도 괜찮으세요?"
  context: string               // "TOP 후보 중 3개가 대인업무가 많아요"
  options: {
    yes: { label: string, effect: string }
    no: { label: string, effect: string }
  }
  affects_jobs: string[]        // 영향받는 job_id 목록
}
```

---

## 9. UX 경고문 템플릿

### 8.1 Caution 배지 문구

| 상황 | 경고문 |
|------|--------|
| TOP3에 Caution 포함 | "⚠️ 일부 추천은 회원님의 조건과 맞지 않을 수 있어요" |
| Safe가 3개 미만 | "조건에 완벽히 맞는 직업이 {N}개뿐이에요. 주의 표시된 직업도 살펴보세요" |
| 전체가 Caution | "모든 추천에 확인이 필요한 부분이 있어요" |

### 8.2 Risk 상세 경고문

| Risk 유형 | 경고문 |
|----------|--------|
| `work_hours_strict` RISK | "🕐 이 직업은 야근이 잦을 수 있어요" |
| `work_hours_strict` UNKNOWN | "🕐 야근 여부는 회사/팀에 따라 달라요" |
| `remote_only` RISK | "🏢 이 직업은 현장 출근이 필요해요" |
| `remote_only` UNKNOWN | "🏢 재택근무 가능 여부는 회사마다 달라요" |
| `degree_required` RISK | "🎓 이 직업은 학위가 필수예요" |
| `license_required` RISK | "📜 이 직업은 자격증이 필수예요" |

### 8.3 재확인 질문

```
Q: "변호사"는 야근이 잦을 수 있어요. 그래도 알아보시겠어요?
   [ 네, 보여주세요 ]  [ 제외할게요 ]
```

---

## 10. 정규화 및 예외 처리

### 9.1 정규화 원칙
- Like/Can 하위 점수: 0~1 정규화 후 배점 반영
- 태그 결손: 해당 항목 중립 점수 (50%)
- 유저 입력 없음: 해당 항목 중립 점수

### 9.2 Unknown 처리 정책 (v0.2.1 정책)

> ⚠️ **핵심 원칙**: UNKNOWN은 "모른다"는 상태 자체가 의미 있음. OK로 보내지 않음!

| 상황 | 점수 계산 | Risk 상태 | 페널티 |
|------|----------|----------|--------|
| 직업 태그 없음 (`interest_tags = []`) | 중립 점수 | Risk 대상 아님 | 0 |
| `_field_confidence.{field}` 낮음 | 중립 가중 | RISK → UNKNOWN 완화 | 0 |
| `wlb = 'unknown'` | 중립 점수 | UNKNOWN (뱃지 표시) | **0** |

**UNKNOWN 처리 요약**:
```typescript
// UNKNOWN = 상태 유지 + 페널티 0 + "확인 필요" 뱃지
{
  status: 'UNKNOWN',      // 상태는 유지
  penalty: 0,             // 모르니까 감점 확신 못함
  badge: '⚠️ 확인 필요',  // UX에 표시
  message: '이 조건은 회사/팀에 따라 달라요. 면접에서 확인해보세요.'
}
```

### 9.3 예외 케이스

```typescript
// Safe가 0개일 때
if (buckets.safe.length === 0) {
  // 1. 전체가 Caution이어도 결과 제공
  // 2. 경고문 강화: "모든 추천에 확인이 필요해요"
  // 3. 갈림길 질문 생성: "조건을 조금 완화해보시겠어요?"
}

// 후보가 전체적으로 적을 때 (< 10개)
if (totalCandidates < 10) {
  // 1. 검색 범위 확장 제안
  // 2. "관련 직업" 추가 노출
}
```

---

## 11. 근거 링크 (Evidence Links)

### 10.1 필수 출력
모든 추천 직업에 **최소 3개 근거** 필수

```typescript
interface EvidenceLink {
  user_fact: {
    key: string        // 'interest.keywords'
    value: string      // 'AI, 데이터분석'
    label: string      // '관심 분야'
  }
  job_attribute: {
    key: string        // 'interest_tags'
    value: string      // 'investigative'
    label: string      // '탐구형 직업'
  }
  match_type: 'positive' | 'neutral' | 'negative'
  score_contribution: number
  explanation: string  // "AI/데이터 관심과 탐구형 직업 특성이 잘 맞아요"
}
```

### 10.2 LLM 프롬프트에 강제

```
추천 직업마다 반드시 아래 표를 포함하세요:

| 회원님 정보 | 직업 특성 | 매칭 |
|------------|----------|------|
| {user_fact} | {job_attribute} | {explanation} |
```

---

## 12. 캘리브레이션 & QA 기준 (v0.2.1 추가)

### 12.1 RiskPenalty 캘리브레이션 KPI

> **목표**: Risk 40이 "적당히" 영향을 주되 Fit이 높으면 여전히 추천될 수 있게

**측정 KPI**:

| KPI | 목표 범위 | 측정 방법 |
|-----|----------|----------|
| **TOP3 Caution 포함률** | 10~30% | `(caution in TOP3) / total_analyses` |
| **Safe vs Caution Fit 갭** | 15~30점 | 평균 Safe Fit - 평균 Caution Fit |
| **UNKNOWN TOP3 포함률** | 20~40% | `(safe_unknown in TOP3) / total_analyses` |

**캘리브레이션 방법**:

```typescript
// 샘플 유저 20명 × 제약 5종류 = 100개 시나리오
const testScenarios = [
  { user: '야근 싫음', constraint: 'work_hours_strict' },
  { user: '원격만', constraint: 'remote_only' },
  { user: '학위 불가', constraint: 'degree_impossible' },
  // ...
]

// 결과 분석
function analyzeCalibration(results: AnalysisResult[]) {
  const cautionInTop3Rate = results.filter(r => 
    r.sources.includes('caution')
  ).length / results.length
  
  // 목표: 10~30%
  if (cautionInTop3Rate < 0.1) {
    console.warn('Risk 페널티가 너무 약함 → 값 증가 필요')
  }
  if (cautionInTop3Rate > 0.3) {
    console.warn('Risk 페널티가 너무 강함 → 값 감소 필요')
  }
}
```

### 12.2 중복 감점 방지 유틸 (단일화)

> **핵심**: 모든 파이프라인에서 동일한 유틸 사용 → 중복 감점 방지

```typescript
// ===== 유일한 키워드 분리 유틸 =====
// 이 함수만 사용! 여기저기 구현 금지!

const CONSTRAINT_KEYWORDS = [
  '야근', '초과근무', '밤샘',
  '교대', '교대근무', '3교대',
  '출장', '외근', '이동',
  '현장', '현장근무',
  '재택불가', '출근필수'
]

export function separateDislikeKeywords(
  dislikeKeywords: string[]
): { forLike: string[], forRisk: string[] } {
  const forRisk: string[] = []
  const forLike: string[] = []
  
  for (const keyword of dislikeKeywords) {
    if (CONSTRAINT_KEYWORDS.some(c => keyword.includes(c))) {
      forRisk.push(keyword)
    } else {
      forLike.push(keyword)
    }
  }
  
  return { forLike, forRisk }
}

// 사용처:
// - Like 점수 계산 시: forLike만 사용
// - Risk 체크 시: forRisk를 Non-negotiable로 변환
```

### 12.2.1 단일화 강제 방법 (권장)

> ⚠️ **이 유틸 외에 다른 곳에서 키워드 분류 구현 금지!**

**방법 1: export 제한**
```typescript
// src/services/ai-analyzer/utils/keyword-separator.ts
// 이 파일에서만 CONSTRAINT_KEYWORDS 정의 + export

// 다른 파일에서 import해서만 사용
import { separateDislikeKeywords } from '@/services/ai-analyzer/utils/keyword-separator'
```

**방법 2: ESLint 커스텀 룰 (권장)**
```javascript
// .eslintrc.js
rules: {
  'no-restricted-syntax': [
    'error',
    {
      selector: 'CallExpression[callee.property.name="includes"][arguments.0.value=/야근|교대|출장|현장/]',
      message: 'separateDislikeKeywords() 유틸을 사용하세요'
    }
  ]
}
```

**방법 3: 코드 리뷰 체크리스트**
- [ ] dislike 관련 로직에서 `separateDislikeKeywords` 사용 여부 확인
- [ ] 문자열 포함 체크(`includes`)로 직접 구현 안 했는지 확인

### 12.3 job_attributes 태깅 QA 합격선

> **핵심**: 하드필터 없으니 태깅 품질이 UX 신뢰 좌우

**QA 기준 (필수)**:

| 필드 | 합격선 | 측정 방법 |
|------|--------|----------|
| `wlb` | **85%+** | 랜덤 200개 샘플링 + 사람 판정 |
| `degree_required` | **90%+** | 공식 자격 요건과 비교 |
| `license_required` | **90%+** | 공식 자격 요건과 비교 |
| `remote_possible` | **80%+** | 채용공고 표본과 비교 |
| `interest_tags` | **75%+** | Holland 코드 전문가 검수 |

**QA 프로세스**:

```typescript
// 1. 샘플링
const sample = await db.query(
  'SELECT * FROM jobs ORDER BY RANDOM() LIMIT 200'
)

// 2. 사람 판정 (Google Sheet 등)
// - 각 필드별로 O/X 판정
// - 의심되는 케이스 기록

// 3. 정확도 계산
const accuracy = {
  wlb: correctCount.wlb / 200,
  degree: correctCount.degree / 200,
  // ...
}

// 4. 합격선 미달 시 → 프롬프트 재튜닝
if (accuracy.wlb < 0.85) {
  // 실패 케이스 분석 → 프롬프트 수정 → 재태깅
}
```

**태깅 재튜닝 트리거**:

| 상황 | 액션 |
|------|------|
| 정확도 85% 미만 | 프롬프트 재튜닝 |
| Confidence 높은데 틀림 | Confidence 산출 로직 수정 |
| Confidence 낮은데 맞음 | Confidence 임계값 조정 |

---

## 13. 버전 정보

### 13.1 현재 버전
- **scoring_version**: `scoring-v0.2.1-final`
- **변경 사항**: v0.2.1 + constraint 네이밍 통일 + RiskDetail OK 추가 + 후보 풀 80 확보

### 13.2 v0.2.1 → v0.2.1-final 변경 이력

| 항목 | v0.2.1 | v0.2.1-final |
|------|--------|--------------|
| constraint 네이밍 | 혼재 (work_hours, work_hours_strict) | **표준 5개로 통일** |
| RiskDetail.status | 'RISK' \| 'UNKNOWN' | **'OK' \| 'UNKNOWN' \| 'RISK'** |
| safe_unknown 함수 | 인자 부족 | **buckets, totalCandidates 추가** |
| ux_flags 카운트 | 단일 | **before/after 필터 2세트** |
| 후보 풀 크기 | 50 | **80 (다양성 룰 충돌 방지)** |

### 13.3 v0.2.0 → v0.2.1 변경 이력

| 항목 | v0.2.0 | v0.2.1 |
|------|--------|--------|
| 페널티 부호 | 음수 (-40, -10) | **양수 (40, 10)로 통일** |
| UNKNOWN 처리 | penalty -5~-10 + OK 완화 가능 | **penalty 0 + 상태만 유지** |
| Confidence 사용 | `_confidence` (전체) | **`_field_confidence` (필드별)** |
| Like/Risk 역할 | 분리 없음 | **중복 감점 방지 규칙 추가** |
| Caution TOP3 | follow-up 선택 | **follow-up 필수** |
| 유저 하드-제외 | 없음 | **UI 프리퍼런스 필터 추가** |

### 13.4 v0.1 → v0.2 변경 이력

| 항목 | v0.1 | v0.2 |
|------|------|------|
| Hard Filter | 4개 (탈락) | **0개 (제거)** |
| Risk 처리 | 페널티만 | **버킷 분리 + 경고문 + 재확인** |
| Confidence | 없음 | **태깅 신뢰도 반영** |
| Non-negotiable | 구분 없음 | **Preference와 분리** |
| 페널티 상한 | 없음 | **80점** |

### 13.5 v0.3 개선 예정
- [ ] 벡터 유사도 기반 Like 보조
- [ ] 유저 피드백 반영 (재확인 질문 응답 → 프로필 자동 반영)
- [ ] A/B 테스트 기반 가중치 조정
- [ ] follow-up 응답 기반 rerank

---

## 14. 체크리스트

### 14.1 설계 확정 (완료)
- [x] Fit 공식 확정 (0.5×Like + 0.5×Can - Risk)
- [x] Hard Filter 0개 확정
- [x] Risk 페널티 테이블 확정 (양수 통일)
- [x] 3단계 버킷 정책 확정 (safe_known > safe_unknown > caution)
- [x] Confidence 반영 로직 확정 (field_confidence)
- [x] UNKNOWN 정책 확정 (상태 유지 + 점수 0)
- [x] Non-negotiable/Preference 구분 확정
- [x] Like/Risk 역할 분리 확정 (중복 감점 방지)
- [x] Caution TOP3 → follow-up 필수 확정
- [x] follow-up "no" → Safe 대체 + fact 저장 확정
- [x] 유저 하드-제외 UI 정책 확정
- [x] result_json 구조 확정

### 14.2 구현 착수 전 체크리스트 (6가지 최종)

> ⚠️ **이거 다 확인 후 구현 시작!** (정우님 최종 검토 반영)

| # | 항목 | 상태 | 위치 |
|---|------|------|------|
| 1 | **constraint 네이밍 통일** (표준 5개만 허용, 금지 키 정의) | ✅ | §2.2 |
| 2 | **RiskDetail.status에 OK 추가** (`'OK' \| 'UNKNOWN' \| 'RISK'`) | ✅ | §8.2 |
| 3 | **safe_unknown 함수 시그니처** (buckets, totalCandidates 인자 포함) | ✅ | §7.1.1 |
| 4 | **ux_flags 필터 전/후 카운트** (counts_before_filter, counts_after_filter) | ✅ | §8.1 |
| 5 | **후보 풀 80~120 확보** (CANDIDATE_POOL_SIZE=80, 다양성 룰 충돌 방지) | ✅ | §6.0.2 |
| 6 | **`separateDislikeKeywords()` 단일화** (utils에만, lint rule 권장) | ✅ | §12.2.1 |

### 14.3 구현 시 주의사항

**점수 계산**:
- [ ] 점수: 소수점 2자리까지
- [ ] RiskPenalty: **양수로 계산** + 상한 80점 체크
- [ ] UNKNOWN: **penalty=0, 상태는 유지**
- [ ] Confidence: **_field_confidence 사용** (전체 아님)

**결과 출력**:
- [ ] 근거 링크: 3개 이상 강제
- [ ] 버전 정보: result_json에 반드시 포함
- [ ] Caution 경고문: 템플릿 적용
- [ ] Caution TOP3: **follow-up 질문 필수 생성**

**유틸/정책**:
- [ ] dislike 중복 감점 방지: `separateDislikeKeywords` 유틸만 사용
- [ ] 버킷 우선순위: safe_known → safe_unknown → caution
- [ ] follow-up "no": Safe에서 대체 + fact 저장
