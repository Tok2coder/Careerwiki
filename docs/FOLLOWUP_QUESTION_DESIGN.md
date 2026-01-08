# Follow-up 질문 설계 가이드

> **목표**: 자기가 원하는 게 뭔지 모르는 사람에게서, 그걸 파악하기 위한 모든 정보를 끌어낸다.

---

## 1. 핵심 원칙

### 1.1 질문의 목적 전환

| 기존 (리스크 확인) | 변경 (자기 발견 유도) |
|-------------------|---------------------|
| "야근 괜찮아요?" | "야근이 싫은 가장 큰 이유가 뭔가요?" |
| 조건 확인 (yes/no) | **이유 탐색 (왜?)** |
| 사고 방지 | **히든 가치관 발굴** |

### 1.2 질문 설계 3원칙

1. **기본 폼으로 수집한 건 다시 묻지 않는다**
   - ❌ "야근 싫어요?" (이미 물어봤음)
   - ✅ "야근이 싫은 이유 중 가장 큰 건 뭔가요?"

2. **"왜?"를 판다**
   - 표면: "원격근무 원해요"
   - 진짜: 왜? → 집중? 통근 싫음? 가족? 체력?
   - 이유가 다르면 추천도 달라져야 함

3. **유저가 "아, 나 이런 사람이구나" 발견하게 한다**
   - 질문에 답하다 보면 스스로 정리됨
   - 추천 결과에 "당신은 이런 점을 중요하게 생각하시네요" 포함

---

## 2. 질문 유형 분류

### 2.1 3단계 질문 흐름

```
[1단계: 탐색] → [2단계: 명료화] → [3단계: 우선순위]
```

| 단계 | 목적 | 예시 |
|------|------|------|
| **탐색** | 아직 모호한 걸 구체화 | "일할 때 가장 피하고 싶은 상황이 뭔가요?" |
| **명료화** | 이유/맥락 파악 | "그게 싫은 가장 큰 이유가 뭔가요?" |
| **우선순위** | 트레이드오프 확인 | "둘 중 하나만 골라야 한다면?" |

### 2.2 질문 유형별 템플릿

#### 🔍 탐색형 (Discovery)
```
목적: 유저가 명시하지 않은 숨은 선호 발굴

템플릿:
- "일할 때 가장 [기분 좋은/힘든] 순간이 언제예요?"
- "이전 경험에서 [가장 좋았던/피하고 싶은] 건 뭐였어요?"
- "[이상적인 하루/최악의 하루]를 상상해보면 어떤 모습이에요?"

저장되는 fact:
- fact_key: "discovery.ideal_work_moment"
- fact_key: "discovery.worst_experience"
```

#### 💡 명료화형 (Clarification)
```
목적: 표면 답변 뒤의 진짜 이유 파악

템플릿:
- "[X]가 싫다고 하셨는데, 가장 큰 이유가 뭔가요?"
  → 체력 / 가족 / 공부 병행 / 정신적 스트레스 / 기타
- "[Y]를 원한다고 하셨는데, 그게 왜 중요한가요?"
  → 성장 / 안정 / 인정 / 자율 / 수입 / 기타

저장되는 fact:
- fact_key: "motivation.{constraint}_reason"
- value: { reason: "체력", detail: "장기적으로 지속 불가능" }
```

#### ⚖️ 트레이드오프형 (Tradeoff)
```
목적: 가치관 우선순위 파악

템플릿:
- "연봉 30% 높은 야근 많은 회사 vs 연봉 낮지만 칼퇴 보장, 어느 쪽이에요?"
- "빠른 성장 but 불안정 vs 느린 성장 but 안정, 어느 쪽이에요?"
- "혼자 깊게 파는 일 vs 여러 명과 협업하는 일, 어느 쪽이에요?"

저장되는 fact:
- fact_key: "tradeoff.salary_vs_wlb"
- value: { choice: "wlb", confidence: 0.8 }
```

#### 🎯 우선순위형 (Priority)
```
목적: 여러 가치 중 진짜 1순위 파악

템플릿:
- "지금 말씀하신 것들 중에서 딱 하나만 골라야 한다면?"
- "이 중에서 절대 포기 못 하는 건 뭔가요?"
- "10년 뒤에도 후회 안 할 선택은 어느 쪽일 것 같아요?"

저장되는 fact:
- fact_key: "priority.top1"
- value: { item: "work_life_balance", reason: "가족과의 시간" }
```

---

## 3. Fact Key 스키마 확장

### 3.1 기존 fact_key (Phase 0)

```typescript
// 제약 확인용 (리스크)
"confirmed_constraint.work_hours_strict"
"accepted_risk.remote_only.job_123"
```

### 3.2 확장된 fact_key (Phase 1)

```typescript
// 동기/이유 (왜 그렇게 생각하는지)
"motivation.work_hours_reason"        // 야근 싫은 이유
"motivation.remote_reason"            // 원격 원하는 이유
"motivation.career_change_reason"     // 이직/전직 이유

// 발견된 가치관
"discovery.ideal_work_moment"         // 일할 때 가장 좋은 순간
"discovery.worst_experience"          // 피하고 싶은 경험
"discovery.long_term_goal"            // 장기 목표

// 트레이드오프 선택
"tradeoff.salary_vs_wlb"              // 연봉 vs 워라밸
"tradeoff.growth_vs_stability"        // 성장 vs 안정
"tradeoff.solo_vs_team"               // 혼자 vs 협업

// 우선순위
"priority.top1"                       // 절대 포기 못 하는 것
"priority.top3"                       // 상위 3개 가치
"priority.dealbreaker"                // 절대 안 되는 것

// 자기 이해 인사이트
"insight.work_style"                  // "분석형" / "실행형" / "창의형"
"insight.energy_source"               // "혼자 충전" / "사람에게서 충전"
"insight.decision_style"              // "신중형" / "직관형"
```

### 3.3 Fact Value 구조

```typescript
interface FactValue {
  // 핵심 값
  value: string | string[] | number
  
  // 맥락
  reason?: string           // 왜 이렇게 답했는지
  confidence?: number       // 0~1, 얼마나 확신하는지
  source?: string           // 어떤 질문에서 나왔는지
  
  // 메타
  collected_at: string      // 수집 시점
  question_id: string       // 질문 ID
}
```

---

## 4. 질문 → 점수 매핑

### 4.1 Like 점수에 영향

| fact_key | 영향 | 예시 |
|----------|------|------|
| `motivation.work_hours_reason = "체력"` | 체력 소모 적은 직업 +점수 | 사무직, 연구직 선호 |
| `discovery.ideal_work_moment = "혼자 깊게 파기"` | 집중형 직업 +점수 | 개발자, 연구원 선호 |
| `tradeoff.solo_vs_team = "solo"` | 1인 작업 비중 높은 직업 +점수 | |

### 4.2 Can 점수에 영향

| fact_key | 영향 | 예시 |
|----------|------|------|
| `motivation.career_change_reason = "학습 의지 높음"` | 학습 기간 긴 직업도 OK | 진입장벽 페널티 감소 |
| `discovery.long_term_goal = "전문가"` | 깊이 있는 커리어 가능 직업 +점수 | |
| `priority.top1 = "성장"` | 성장 가능성 높은 직업 +점수 | |

### 4.3 Risk 판단에 영향

> ⚠️ **정책 준수**: Hard Filter 0개 원칙. dealbreaker도 Risk Penalty + follow-up으로만 처리

| fact_key | 영향 | 처리 방식 |
|----------|------|----------|
| `motivation.work_hours_reason = "가족"` | 야근 있는 직업 → 더 강한 경고 | Risk Penalty 증가 + 경고문 |
| `tradeoff.salary_vs_wlb = "salary"` | 야근 있어도 연봉 높으면 OK | Risk Penalty 감소 |
| `priority.dealbreaker = "출장"` | 출장 많은 직업 → 강한 경고 | **Risk Penalty 최대 + follow-up 재확인** (hard filter ❌) |

**dealbreaker 처리 정책**:
- ❌ Hard Filter로 결과에서 제외 (금지)
- ✅ Risk Penalty 최대값(40) 적용
- ✅ Caution 버킷으로 분류
- ✅ "⚠️ 주의 필요" 배지 + follow-up 재확인
- ✅ 유저가 원하면 `ux_flags.hide_dealbreaker_jobs = true`로 UI에서 숨김

### 4.4 fact_key 레벨 구분 (중요)

> **Phase 0의 `confirmed_constraint.*`와 Phase 1의 `priority.dealbreaker`는 다른 레벨**

| 레벨 | fact_key 패턴 | 의미 | 처리 |
|------|--------------|------|------|
| **L1: 명시적 제약** | `confirmed_constraint.*` | 유저가 "이건 절대 안 돼"라고 명시 | Risk Penalty 최대 + 강한 경고 |
| **L2: 강한 선호** | `priority.dealbreaker` | 유저가 "이건 피하고 싶어"라고 표현 | Risk Penalty 높음 + follow-up 재확인 |
| **L3: 일반 선호** | `motivation.*`, `tradeoff.*` | 이유/가치관 기반 선호 | Like/Can boost |
| **L4: 발견된 인사이트** | `discovery.*`, `insight.*` | 질문으로 발굴된 정보 | 부스트 또는 컨텍스트 |

**구현 시 주의**: L1과 L2를 같은 코드 경로로 처리하면 안 됨!

---

## 5. Fact-Score 매핑 규칙 체계 (v1.0.2 추가)

### 5.1 매핑 룰 상한/중복/충돌 정책

> **단일 파일**: `src/services/ai-analyzer/fact-score-mapping.ts`

```typescript
// ============================================
// 매핑 룰 전역 정책
// ============================================
const MAPPING_POLICY = {
  // 상한: 하나의 fact가 줄 수 있는 최대 boost
  MAX_BOOST_PER_FACT: 20,
  
  // 같은 job_attribute에 대한 중복 boost 처리
  DUPLICATE_POLICY: 'highest_wins',  // 'sum' | 'highest_wins' | 'average'
  
  // 전체 Like/Can에 대한 fact boost 총합 상한
  MAX_TOTAL_LIKE_BOOST: 40,
  MAX_TOTAL_CAN_BOOST: 30,
  
  // 충돌 시 우선순위 (높은 숫자가 우선)
  PRIORITY_ORDER: {
    'confirmed_constraint': 100,  // L1: 최우선
    'priority.dealbreaker': 80,   // L2
    'priority.top1': 70,
    'tradeoff': 60,
    'motivation': 50,
    'discovery': 40,
    'insight': 30,
  }
}
```

### 5.2 충돌 해결 예시

```typescript
// 상황: 같은 직업의 'wlb' attribute에 여러 boost가 적용될 때
const boosts = [
  { source: 'motivation.work_hours_reason', value: 15 },
  { source: 'tradeoff.salary_vs_wlb', value: 10 },
  { source: 'discovery.ideal_work_moment', value: 5 },
]

// DUPLICATE_POLICY = 'highest_wins' → 15점만 적용
// DUPLICATE_POLICY = 'sum' → 30점 적용 (단, MAX_TOTAL_LIKE_BOOST=40 상한)
```

---

## 6. 자유 텍스트 → 표준 태그 정규화 (v1.0.2 추가)

### 6.1 문제

```
motivation.work_hours_reason = "가족이랑 시간 보내고 싶어서"
```

이 자유 텍스트를 바로 if문으로 비교하면 확장성 ❌

### 6.2 해결: 표준 태그(ValueTag) 룩업 테이블

```typescript
// ============================================
// 표준 태그 정의
// ============================================
type ValueTag = 
  | 'work_life_balance'  // 워라밸
  | 'stability'          // 안정
  | 'growth'             // 성장
  | 'autonomy'           // 자율
  | 'impact'             // 영향력/의미
  | 'income'             // 수입
  | 'recognition'        // 인정
  | 'health'             // 건강/체력
  | 'family'             // 가족
  | 'learning'           // 학습/성장

type WorkStyleTag =
  | 'solo_deep'          // 혼자 깊게
  | 'collaborative'      // 협업
  | 'analytical'         // 분석형
  | 'creative'           // 창의형
  | 'execution'          // 실행형

// ============================================
// 자유 텍스트 → 태그 매핑 (룩업 테이블)
// ============================================
const REASON_TO_TAG_MAP: Record<string, ValueTag[]> = {
  // 야근 싫은 이유
  '체력': ['health'],
  '가족': ['family', 'work_life_balance'],
  '공부': ['learning', 'growth'],
  '스트레스': ['health', 'work_life_balance'],
  '취미': ['work_life_balance', 'autonomy'],
  
  // 원격 원하는 이유
  '집중': ['autonomy', 'solo_deep'],
  '통근': ['work_life_balance', 'health'],
  '육아': ['family', 'work_life_balance'],
}

// ============================================
// 정규화 함수
// ============================================
function normalizeReasonToTags(
  fact_key: string,
  freeText: string
): ValueTag[] {
  // 1. 룩업 테이블에서 직접 매칭
  const directMatch = REASON_TO_TAG_MAP[freeText]
  if (directMatch) return directMatch
  
  // 2. 부분 매칭 (키워드 포함 여부)
  for (const [keyword, tags] of Object.entries(REASON_TO_TAG_MAP)) {
    if (freeText.includes(keyword)) return tags
  }
  
  // 3. 매칭 실패 → LLM 폴백 (비용 발생)
  return extractTagsWithLLM(fact_key, freeText)
}
```

### 6.3 LLM 폴백 (룩업 실패 시)

```typescript
async function extractTagsWithLLM(
  fact_key: string,
  freeText: string
): Promise<ValueTag[]> {
  const prompt = `
다음 텍스트에서 가치관 태그를 추출하세요.
fact_key: ${fact_key}
텍스트: "${freeText}"

가능한 태그: work_life_balance, stability, growth, autonomy, impact, income, recognition, health, family, learning

JSON 형식으로 반환: { "tags": ["태그1", "태그2"] }
`
  // LLM 호출 (비용 발생하므로 룩업 실패 시에만)
  const result = await callLLM(prompt)
  return result.tags
}
```

---

## 7. 질문 생성 = 후보군 갈림 포인트 기반 (v1.0.2 추가)

### 7.1 기존 문제

```
질문 생성 기준: "유저 프로필이 모호하면 질문"
→ 추천 결과와 무관한 질문이 나올 수 있음
```

### 7.2 개선: 후보군 분별력 기반 질문

```typescript
// ============================================
// 질문 생성 입력
// ============================================
interface QuestionGenerationInput {
  userProfile: UserProfile
  candidates: ScoredJob[]  // 후보 80개
  topK: ScoredJob[]        // TOP 후보 10개
}

// ============================================
// 분별력 계산
// ============================================
function calculateDiscriminatingAttributes(
  topK: ScoredJob[]
): AttributeDiscrimination[] {
  // TOP 후보들 간 점수 차이를 만드는 attribute 찾기
  const attributes = ['wlb', 'growth', 'stability', 'income', 'remote', ...]
  
  return attributes.map(attr => {
    const values = topK.map(job => job.attributes[attr])
    const variance = calculateVariance(values)
    
    return {
      attribute: attr,
      variance,  // 분산이 크면 = 후보들 간 차이가 큼
      splitGain: calculateSplitGain(topK, attr)  // 이 attribute로 나눴을 때 정보 이득
    }
  }).sort((a, b) => b.splitGain - a.splitGain)
}
```

### 7.3 분별력 높은 질문 생성

```typescript
// ============================================
// 질문 생성 로직
// ============================================
function generateDiscriminatingQuestions(
  input: QuestionGenerationInput
): FollowupQuestion[] {
  // 1. 후보군에서 분별력 높은 attribute 추출
  const discriminatingAttrs = calculateDiscriminatingAttributes(input.topK)
  
  // 예: [{ attribute: 'wlb', splitGain: 0.8 }, { attribute: 'growth', splitGain: 0.6 }]
  
  // 2. 해당 attribute에 대한 질문 매핑
  const questions = discriminatingAttrs.slice(0, 3).map(attr => {
    return ATTRIBUTE_TO_QUESTION_MAP[attr.attribute]
  })
  
  // 예: wlb → "연봉 30% 높은 야근 많은 회사 vs 연봉 낮지만 칼퇴?"
  // 예: growth → "빠른 성장 but 불안정 vs 느린 성장 but 안정?"
  
  return questions
}

// ============================================
// Attribute → 질문 매핑
// ============================================
const ATTRIBUTE_TO_QUESTION_MAP: Record<string, FollowupQuestion> = {
  'wlb': {
    id: 'tradeoff_wlb_salary',
    type: 'tradeoff',
    question: '연봉 30% 높지만 야근 가능성 vs 연봉 낮지만 칼퇴 보장?',
    options: [
      { value: 'salary', label: '연봉 우선' },
      { value: 'wlb', label: '워라밸 우선' }
    ],
    fact_key: 'tradeoff.salary_vs_wlb'
  },
  'growth': {
    id: 'tradeoff_growth_stability',
    type: 'tradeoff',
    question: '빠른 성장 but 불안정 vs 느린 성장 but 안정?',
    options: [
      { value: 'growth', label: '성장 우선' },
      { value: 'stability', label: '안정 우선' }
    ],
    fact_key: 'tradeoff.growth_vs_stability'
  },
  // ... 더 많은 매핑
}
```

---

## 8. 질문 선택 점수화 (정보이득 기반) (v1.0.2 추가)

### 8.1 질문 선택 스코어

```typescript
interface QuestionScore {
  question: FollowupQuestion
  
  // 정보 이득 점수 (0~1)
  informationGain: number
  
  // 추천 순위 변동 예상치 (높을수록 좋음)
  expectedRankChange: number
  
  // 최종 점수
  totalScore: number
}

function scoreQuestion(
  question: FollowupQuestion,
  candidates: ScoredJob[],
  userProfile: UserProfile
): QuestionScore {
  // 1. 정보 이득: 이 질문으로 얼마나 불확실성이 줄어드는가?
  const informationGain = calculateInformationGain(question, userProfile)
  
  // 2. 순위 변동 예상: 이 질문 답변에 따라 TOP3가 얼마나 바뀔 수 있는가?
  const expectedRankChange = simulateRankChange(question, candidates)
  
  // 3. 최종 점수
  const totalScore = 0.4 * informationGain + 0.6 * expectedRankChange
  
  return { question, informationGain, expectedRankChange, totalScore }
}
```

### 8.2 질문 선택 알고리즘

```typescript
function selectTopQuestions(
  allQuestions: FollowupQuestion[],
  candidates: ScoredJob[],
  userProfile: UserProfile,
  maxQuestions: number = 3
): FollowupQuestion[] {
  // 1. 모든 질문 점수화
  const scored = allQuestions.map(q => 
    scoreQuestion(q, candidates, userProfile)
  )
  
  // 2. 점수 순 정렬
  scored.sort((a, b) => b.totalScore - a.totalScore)
  
  // 3. 상위 N개 선택 (기본 3개, 최대 5개)
  const selected = scored.slice(0, maxQuestions)
  
  // 4. 최소 정보이득 임계값 체크 (너무 낮으면 질문 안 함)
  return selected.filter(s => s.informationGain > 0.2)
}
```

### 8.3 정보이득 계산 예시

```typescript
function calculateInformationGain(
  question: FollowupQuestion,
  userProfile: UserProfile
): number {
  // 이미 알고 있는 정보면 gain = 0
  const relatedFacts = getRelatedFacts(question.fact_key, userProfile)
  if (relatedFacts.length > 0 && relatedFacts[0].confidence > 0.8) {
    return 0  // 이미 충분히 알고 있음
  }
  
  // 아직 모르는 정보면 gain = 높음
  const missingInfo = getMissingInfoScore(question.fact_key, userProfile)
  
  return missingInfo
}

function simulateRankChange(
  question: FollowupQuestion,
  candidates: ScoredJob[]
): number {
  // 질문의 각 선택지별로 TOP3가 어떻게 바뀌는지 시뮬레이션
  const option1Top3 = simulateTop3(candidates, question, question.options[0].value)
  const option2Top3 = simulateTop3(candidates, question, question.options[1].value)
  
  // 두 결과가 다르면 = 분별력 있음
  const changeCount = countDifferences(option1Top3, option2Top3)
  
  return changeCount / 3  // 0~1 정규화
}
```

---

## 9. 질문 생성 로직 (v1.0.2 업데이트)

### 5.1 질문 선택 우선순위

```
1. 아직 모르는 핵심 정보가 있는가?
   → 탐색형 질문

2. 표면 답변만 있고 이유를 모르는가?
   → 명료화형 질문

3. 여러 가치가 충돌하는가?
   → 트레이드오프형 질문

4. 우선순위가 불명확한가?
   → 우선순위형 질문
```

### 5.2 질문 생성 예시 (실제 흐름)

**유저 입력:**
```
- 좋아하는 것: AI, 데이터분석
- 싫어하는 것: 영업, 야근
- 제약: 야근 절대 불가
```

**AI가 생성할 질문 (순서대로):**

```
[1] 명료화: 야근이 싫은 가장 큰 이유가 뭔가요?
    → 체력 / 가족 / 공부 병행 / 정신적 스트레스

[2] 탐색: 일할 때 가장 에너지가 나는 순간은 언제예요?
    → 문제 해결 / 새로운 걸 배울 때 / 인정받을 때 / 팀과 협업할 때

[3] 트레이드오프: 빠르게 성장하지만 야근 가끔 vs 천천히 성장하지만 칼퇴 보장
    → (야근 절대 불가라고 했지만, 진짜 절대인지 확인)

[4] 우선순위: AI/데이터 분야에서 가장 끌리는 건 뭔가요?
    → 기술 깊이 / 비즈니스 임팩트 / 연봉 / 워라밸
```

---

## 6. 결과 출력에 반영

### 6.1 추천 결과 + 인사이트

```json
{
  "fit_top3": [...],
  
  "user_insight": {
    "summary": "당신은 '장기 지속 가능성'을 가장 중요하게 생각하시네요.",
    "key_values": [
      "체력 관리가 가능한 환경",
      "혼자 깊게 파는 업무 스타일",
      "꾸준한 성장 > 빠른 성장"
    ],
    "recommendation_basis": "이 추천은 위 가치관을 기반으로 했습니다."
  },
  
  "discovered_facts": [
    { "key": "motivation.work_hours_reason", "value": "체력", "影響": "야근 없는 직업 우선" },
    { "key": "tradeoff.growth_vs_stability", "value": "stability", "影響": "안정적인 산업 우선" }
  ]
}
```

### 6.2 유저가 느껴야 할 것

> "아, 이 서비스는 나를 이해하려고 하는구나"
> "질문에 답하다 보니까 내가 뭘 원하는지 정리가 됐네"
> "추천 결과가 왜 이렇게 나왔는지 납득이 가네"

---

## 7. Phase 1 필수 보장 사항

### 7.1 저장 정책 (필수)

```
follow-up 답변 → 2곳에 저장:
1. raw_events (원문 그대로, 절대 안 잃어버림)
2. facts (extracted/canonical, 점수 계산용)
```

**이유**: 원문은 나중에 재분석/디버깅/재현에 필요, fact는 점수 계산에 필요

### 7.2 점수 매핑 테이블 단일화 (필수)

```typescript
// ❌ 매핑이 여기저기 흩어지면 안 됨
// ✅ 단일 파일에서 관리: src/services/ai-analyzer/fact-score-mapping.ts

const FACT_SCORE_MAPPING: FactScoreRule[] = [
  {
    fact_key: 'motivation.work_hours_reason',
    affects: 'like',
    rule: (value) => {
      if (value === '체력') return { job_attribute: 'wlb', boost: 10 }
      if (value === '가족') return { job_attribute: 'wlb', boost: 15 }
      return null
    }
  },
  // ... 모든 매핑을 이 파일에서 관리
]
```

### 7.3 질문 개수 제한 (필수)

> **1회 분석당 follow-up 질문: 최대 3~5개**

| 질문 유형 | 우선순위 | 최대 개수 |
|----------|---------|----------|
| 명료화 (이유 파악) | 1순위 | 2개 |
| 탐색 (숨은 선호) | 2순위 | 1개 |
| 트레이드오프 | 3순위 | 1개 |
| 우선순위 확인 | 4순위 | 1개 |

**질문 선택 원칙**:
- "이 질문에 답하면 추천이 더 좋아지는가?"로 판단
- 정보 이득이 낮은 질문은 스킵
- 유저 피로도 고려 (너무 많으면 이탈)

---

## 8. Phase 1 체크리스트

### ✅ 구현 완료 기준

**저장**:
- [ ] follow-up 원문 → raw_events 저장
- [ ] follow-up 가공 → facts 테이블 저장
- [ ] 같은 세션에서 fact 누적

**매핑**:
- [ ] fact → 점수 매핑 테이블 단일 파일로 관리
- [ ] 매핑 규칙이 Like/Can/Risk에 실제로 영향

**질문**:
- [ ] 질문이 "왜?"를 파는 형태
- [ ] 1회당 최대 5개 제한
- [ ] 탐색→명료화→트레이드오프→우선순위 순서

### ✅ 검증 시나리오

```
1. 첫 분석 요청 → 추천 결과 A
2. follow-up "야근 싫은 이유?" → "가족" 답변
3. 같은 사람이 다시 분석 요청 → 추천 결과 B
4. A와 B가 달라야 함 (워라밸 중시 직업이 더 상위로)
```

**이 시나리오가 통과하면 "자기 발견 엔진"이 실제로 작동하는 것**

---

## 9. 뻔한 질문 → 좋은 질문 변환 예시

| 뻔한 질문 (❌) | 좋은 질문 (✅) | 발굴되는 정보 |
|---------------|---------------|--------------|
| 야근 괜찮아요? | 야근이 싫은 가장 큰 이유가 뭔가요? | motivation |
| 원격 원해요? | 원격이 중요한 이유가 뭔가요? (집중? 통근? 가족?) | motivation |
| IT 좋아해요? | IT에서 가장 끌리는 부분이 뭔가요? | discovery |
| 연봉 얼마 원해요? | 연봉과 시간 중 하나만 고르면? | tradeoff |
| 안정 원해요? | 10년 뒤에도 후회 안 할 선택은? | priority |
| 사람 만나는 거 좋아해요? | 에너지가 충전되는 순간이 언제예요? | discovery |

---

## 10. 다음 단계

이 문서가 확정되면:

1. **질문 템플릿 DB화** - 어떤 상황에서 어떤 질문?
2. **질문 생성 로직 구현** - fact 상태 보고 자동 선택
3. **점수 매핑 테이블 구현** - fact → Like/Can/Risk 영향
4. **태깅 (병렬)** - 직업 데이터 구조화

---

*Version: v1.0.2*
*Created: 2026-01-02*
*Updated: 2026-01-02*
*Author: CareerWiki AI Team*

### Changelog
- v1.0.2: 
  - fact_key 레벨 구분 (L1~L4) 추가
  - fact-score-mapping 룰 체계화 (상한/중복/충돌 우선순위)
  - 자유 텍스트 → 표준 태그 정규화 (룩업 + LLM 폴백)
  - 질문 생성 = 후보군 갈림 포인트 기반으로 변경
  - 질문 선택 점수화 (정보이득 + 순위 변동 예상치)
- v1.0.1: Hard Filter 0개 정책 준수, 질문 개수 제한, 저장/매핑 필수 보장
- v1.0.0: 초기 버전

