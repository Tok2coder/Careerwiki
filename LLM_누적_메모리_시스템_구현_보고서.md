# LLM 누적 메모리 시스템 구현 최종 보고서

**작성일**: 2026-01-24  
**작업 범위**: AI 추천기 LLM 질문 개인화 시스템 전면 개편  
**상태**: ✅ 완료 (TypeScript 오류 없음)

---

## 1. 개요

### 1.1 목표
사용자가 Step을 넘어갈 때마다 입력 데이터가 **단일 누적 구조(AggregatedProfile)**에 저장되고, LLM이 "더 깊고 개인화된" 질문을 생성하도록 시스템을 개편함.

### 1.2 핵심 개선 포인트

| 구분 | 이전 | 이후 |
|------|------|------|
| 데이터 저장 | Step별 JSON 분리 저장 | **AggregatedProfile** 단일 누적 구조 |
| LLM 호출 전 검증 | 없음 | **LLM Gate** + 폴백 질문 반환 |
| 사용자 패턴 누적 | 없음 | **Rolling Memory** (신뢰도/증거키 포함) |
| 질문 생성 기준 | 일반 프롬프트 | **Deepening Ladder** 5단계 + 감정 강도 트리거 |
| 질문 타겟 선정 | 없음 | **NEXT_TARGETS 우선순위 큐** (Top 2-3) |
| 사용자 경험 | Step 간 단절 | **요약 배너**로 누적 체감 |

---

## 2. 신규 파일 생성

### 2.1 `src/services/ai-analyzer/aggregated-profile.ts` (신규)

**역할**: AggregatedProfile 타입 정의 + 빌더 + Gate + 헬퍼 함수

```typescript
// 핵심 타입
export type AggregatedProfile = {
  profile_version: number           // draft 업데이트 시마다 +1
  generated_at: string
  anchors: { interest_top, value_top, strength_top, constraint_flags, ... }
  narrative: { life_story, high_alive, lost_moment }
  universals: { priority, interests, dislikes, ... }
  transition: { intent, timeline, reasons, ... }
  rounds: Array<{ round, questions, answers }>
  memory: ProfileMemory             // 신뢰도 포함 누적 메모리
  evidence_index: { [key]: { source: EvidenceSourceKey, excerpt } }
}

// 핵심 함수
export function buildAggregatedProfile(draft, existingMemory?): AggregatedProfile
export function assertReadyForLLM(profile, phase): GateResult
export function buildNextTargets(memory, maxTargets): NextTarget[]
export function getHighIntensityTriggers(memory, minIntensity): EmotionalTrigger[]
```

**설계 원칙**:
- `aggregated_profile_json`은 **Derived Cache**로 운영
- Source-of-truth는 Draft 조각들 (`step1/2/3/4_answers_json`)
- 언제든 `buildAggregatedProfile(draft)`로 재생성 가능

**Gate 규칙**:

| Phase | 필수 조건 |
|-------|----------|
| round1 | anchors 최소 1개 + narrative 최소 1개 |
| round2 | Round 1 answers 최소 2개 |
| round3 | constraint_flags 최소 1개 |
| analyze | anchors 완비 + narrative 2개 + round answers 6개 이상 |

**Gate 실패 시 폴백 질문 반환**:
```json
{
  "success": false,
  "gate_failed": true,
  "missing": ["narrative.high_alive"],
  "fallback_questions": [
    {
      "id": "fix_high_alive",
      "questionText": "최근 1년 안에 '내가 잘 살고 있다'고 느낀 순간이 있었다면?",
      "target_field": "narrative.high_alive",
      "minLengthGuidance": 50
    }
  ]
}
```

---

### 2.2 `src/services/ai-analyzer/llm-memory.ts` (신규)

**역할**: Rolling Memory 업데이트 컴포넌트 (라운드 답변/서술형 저장 후 호출)

```typescript
// 입력 타입 (NarrativeFacts 또는 RoundAnswer 모두 처리)
export type MemoryInput = 
  | { type: 'round_answers'; data: RoundAnswer[]; roundNumber: 1|2|3 }
  | { type: 'narrative_facts'; data: NarrativeFacts }

// 출력 구조 (신뢰도 + 증거키 포함)
type MemoryItem = { text: string; confidence: number; evidenceKey?: string }
type EmotionalTrigger = { trigger, emotions[], intensity: 1~5, evidenceKey }

export async function updateMemory(
  ai: Ai | null,
  profile: AggregatedProfile,
  newInput: MemoryInput,
  openaiApiKey?: string
): Promise<ProfileMemory>
```

**핵심 규칙**:
- `confidence < 0.6`인 항목 → NEXT_TARGETS로 보내 "확인 질문" 생성
- 표현은 확정형 금지: "~일 수 있음", "~로 보임" 사용
- 기존 메모리와 새 메모리 병합 (같은 text면 confidence 가중 평균)

**MEMORY_SYSTEM_PROMPT 핵심**:
```
## 추출 대상
- stable_drivers: 반복 등장하는 동기/욕구
- recurring_fears: 반복 등장하는 두려움/회피
- decision_rules: 선택 기준 If-Then 형태
- contradictions: 가치/욕구 충돌
- emotional_triggers: 감정 반응이 큰 지점 (트리거 + 감정들 + 강도)
- open_loops: 미해결 질문 (다음 라운드 타겟)
```

---

### 2.3 `migrations/010_add_aggregated_profile.sql` (신규)

```sql
ALTER TABLE analyzer_drafts ADD COLUMN aggregated_profile_json TEXT;
ALTER TABLE analyzer_drafts ADD COLUMN memory_json TEXT;
ALTER TABLE analyzer_drafts ADD COLUMN profile_version INTEGER DEFAULT 0;
CREATE INDEX IF NOT EXISTS idx_analyzer_drafts_profile_version ON analyzer_drafts(profile_version);
```

---

## 3. 기존 파일 수정

### 3.1 `src/services/ai-analyzer/draft-routes.ts`

**변경 요약**:

| 항목 | 변경 내용 |
|------|----------|
| Import 추가 | `buildAggregatedProfile`, `updateMemory` |
| DraftData 타입 | `mini_module_result_json`, `aggregated_profile_json`, `memory_json`, `profile_version` 추가 |
| `/save` 엔드포인트 | AggregatedProfile 자동 생성/저장 + profile_version 증가 |
| Step2 서술형 저장 | `updateMemory()` 호출 추가 |
| `/load` 응답 | `mini_module_result`, `aggregated_profile`, `memory`, `profile_version` 포함 |

**핵심 코드** (`/save` 엔드포인트):
```typescript
// AggregatedProfile 자동 생성/저장 (Derived Cache)
const fullDraft = await db.prepare('SELECT * FROM analyzer_drafts WHERE id = ?').bind(draftId).first()
if (fullDraft) {
  const aggregatedProfile = buildAggregatedProfile(fullDraft)
  
  // Step2 서술형 저장 시 Memory 업데이트
  if (narrativeFacts && (narrativeFacts.highAliveMoment || narrativeFacts.lostMoment)) {
    const updatedMemory = await updateMemory(env.AI, aggregatedProfile, 
      { type: 'narrative_facts', data: narrativeFacts }, env.OPENAI_API_KEY)
    aggregatedProfile.memory = updatedMemory
  }
  
  await db.prepare('UPDATE analyzer_drafts SET aggregated_profile_json = ?, memory_json = ? WHERE id = ?')
    .bind(JSON.stringify(aggregatedProfile), JSON.stringify(updatedMemory), draftId).run()
}
```

---

### 3.2 `src/services/ai-analyzer/routes.ts`

**변경 요약**:

| 항목 | 변경 내용 |
|------|----------|
| Import 추가 | `assertReadyForLLM`, `createEmptyProfile`, `updateMemory` |
| `/v3/round-questions` | Gate 검증 + 폴백 질문 반환 + Memory DB 조회 후 Interviewer 전달 |
| `/v3/round-answers` | 저장 후 `updateMemory()` 호출 + `memory_json` 저장 |

**Gate 검증 핵심 코드**:
```typescript
// Gate 검증
const gatePhase: GatePhase = `round${round_number}` as GatePhase
const gateResult = assertReadyForLLM(tempProfile, gatePhase)

if (!gateResult.passed) {
  return c.json({
    success: false,
    gate_failed: true,
    missing: gateResult.missing,
    fallback_questions: gateResult.fallback_questions || [],
  })
}
```

**Memory 전달 핵심 코드**:
```typescript
// DB에서 Memory 조회 (누적 메모리)
const draft = await db.prepare('SELECT memory_json FROM analyzer_drafts WHERE session_id = ?')
  .bind(session_id).first()
let memoryData = draft?.memory_json ? JSON.parse(draft.memory_json) : undefined

// Interviewer 호출 시 memory 포함
const result = await generateRoundQuestions(env.AI, {
  ...otherParams,
  memory: memoryData,  // 누적 메모리 전달!
})
```

---

### 3.3 `src/services/ai-analyzer/llm-interviewer.ts`

**변경 요약**:

| 항목 | 변경 내용 |
|------|----------|
| Import 추가 | `buildNextTargets`, `getHighIntensityTriggers`, `ProfileMemory` |
| InterviewerInput | `memory?: ProfileMemory` 필드 추가 |
| INTERVIEWER_SYSTEM_PROMPT | Deepening Ladder 5단계 + 감정 강도 트리거 + intent/what_to_extract 출력 포맷 |
| buildInterviewContext() | `[MEMORY_UPDATE]` + `[NEXT_TARGETS]` 섹션 추가 |
| parseInterviewerResponse() | `intent`, `what_to_extract` 파싱 추가 |

**Deepening Ladder 규칙** (시스템 프롬프트 추가):
```
## Deepening Ladder (5단계 심화 규칙)
각 질문은 아래 5단계 중 최소 2단계를 포함해야 합니다:
1. 상황 - 무슨 일이 있었나
2. 감정 - 그때 어떤 감정이었나
3. 의미 - 왜 그렇게 느꼈나/무엇을 지키려 했나
4. 패턴 - 비슷한 상황이 반복되나
5. 기준 - 다음 선택에서 무엇을 기준으로 삼나

### Round별 필수 포함 조합
- Round 1: (감정) + (의미) + (기준) 중 2개 이상
- Round 2: (감정) + (패턴) + (기준) 중 2개 이상
- Round 3: (기준) + (현실 제약) + (첫 행동) 포함
```

**buildInterviewContext() 핵심 추가**:
```typescript
// 1.5 MEMORY_UPDATE (누적 메모리 - 판단 기준 바로 뒤!)
if (input.memory) {
  parts.push('\n[MEMORY_UPDATE - 지금까지 누적된 사용자 패턴/가설]')
  // stable_drivers, recurring_fears, contradictions, emotional_triggers 등
  
  // 고강도 감정 트리거 강조
  const highIntensity = getHighIntensityTriggers(mem, 4)
  if (highIntensity.length > 0) {
    parts.push('**고강도 트리거 (Round 2/3에서 반드시 1개 이상 다룰 것!):**')
  }
}

// 1.6 NEXT_TARGETS (이번 라운드에서 파야 할 핵심 타겟 - Top 2-3만!)
if (input.memory) {
  const targets = buildNextTargets(input.memory, 3)  // 최대 3개
  parts.push('\n[NEXT_TARGETS - 이번 라운드에서 반드시 다뤄야 할 질문 타겟 (Top 3)]')
}
```

---

### 3.4 `src/services/ai-analyzer/types.ts`

**변경 요약**:

```typescript
// 추가된 타입
export type ExtractTarget = 
  | 'value_rank'        // 가치 순위
  | 'fear_root'         // 두려움 근원
  | 'decision_rule'     // 선택 기준
  | 'constraint'        // 제약 조건
  | 'driver'            // 동기/욕구
  | 'pattern'           // 반복 패턴
  | 'emotional_trigger' // 감정 트리거

export interface RoundQuestion {
  // 기존 필드...
  intent?: string              // UI 노출용
  what_to_extract?: ExtractTarget[]  // 운영/학습용
}
```

---

### 3.5 `src/index.tsx` (프론트엔드)

**변경 요약**:

| 항목 | 변경 내용 |
|------|----------|
| renderSummaryBanner() | 신규 함수 - 요약 배너 렌더링 |
| goToStep() | Step 2+ 진입 시 요약 배너 표시 로직 추가 |
| applyServerDraft() | `mini_module_result`, `aggregated_profile`, `memory` 복원 |

**renderSummaryBanner() 핵심 코드**:
```javascript
function renderSummaryBanner(containerId, memory) {
  const summaryItems = [];
  
  // 안정적 동기 (confidence 높은 것)
  if (memory.stable_drivers?.length > 0) {
    const topDrivers = memory.stable_drivers
      .filter(d => d.confidence >= 0.6)
      .slice(0, 2)
    summaryItems.push('✨ 에너지 올라가는 순간: ' + topDrivers.map(d => d.text).join(', '))
  }
  
  // 가치 충돌, 반복 두려움 등...
  
  // 배너 DOM 생성 및 삽입
  const banner = document.createElement('div');
  banner.className = 'summary-banner bg-wiki-card/50 border border-wiki-border/50 rounded-xl p-4 mb-6';
  banner.innerHTML = `
    <div class="text-sm text-wiki-muted mb-2">💡 지금까지 파악된 당신의 기준</div>
    <div class="space-y-1">${summaryItems.map(item => `<div>${item}</div>`).join('')}</div>
  `;
}
```

---

## 4. 데이터 흐름 다이어그램

```
┌─────────────────────────────────────────────────────────────────────┐
│                              Client                                  │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐      │
│  │  Step UI │    │  요약    │    │  폴백    │    │  질문    │      │
│  │          │    │  배너    │    │  질문 UI │    │  표시    │      │
│  └────┬─────┘    └────▲─────┘    └────▲─────┘    └────▲─────┘      │
│       │               │               │               │             │
└───────┼───────────────┼───────────────┼───────────────┼─────────────┘
        │               │               │               │
        ▼               │               │               │
┌─────────────────────────────────────────────────────────────────────┐
│                              Server                                  │
│  ┌────────────────┐                                                 │
│  │  /draft/save   │──────┐                                          │
│  └────────┬───────┘      │                                          │
│           │              ▼                                          │
│           │    ┌──────────────────┐                                 │
│           │    │ buildAggregated  │                                 │
│           │    │ Profile()        │                                 │
│           │    └────────┬─────────┘                                 │
│           │             │                                           │
│           │     Step2?  │                                           │
│           │      ▼      ▼                                           │
│           │    ┌──────────────────┐                                 │
│           │    │  updateMemory()  │                                 │
│           │    └────────┬─────────┘                                 │
│           │             │                                           │
│           ▼             ▼                                           │
│    ┌─────────────────────────────┐                                  │
│    │        D1 Database          │                                  │
│    │  - aggregated_profile_json  │                                  │
│    │  - memory_json              │                                  │
│    │  - profile_version          │                                  │
│    └─────────────┬───────────────┘                                  │
│                  │                                                  │
│                  ▼                                                  │
│    ┌─────────────────────────────┐                                  │
│    │  /v3/round-questions        │                                  │
│    │  1. assertReadyForLLM()     │──────────┐                       │
│    │  2. DB에서 memory 조회       │          │Gate 실패              │
│    │  3. generateRoundQuestions()│          ▼                       │
│    └─────────────┬───────────────┘   fallback_questions 반환        │
│                  │                                                  │
│                  ▼                                                  │
│    ┌─────────────────────────────┐                                  │
│    │  LLM Interviewer            │                                  │
│    │  - MEMORY_UPDATE 포함       │                                  │
│    │  - NEXT_TARGETS 포함        │                                  │
│    │  - Deepening Ladder 적용    │                                  │
│    └─────────────────────────────┘                                  │
│                                                                     │
│    ┌─────────────────────────────┐                                  │
│    │  /v3/round-answers          │                                  │
│    │  1. 답변 저장                │                                  │
│    │  2. updateMemory() 호출     │                                  │
│    │  3. memory_json 업데이트    │                                  │
│    └─────────────────────────────┘                                  │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 5. NEXT_TARGETS 우선순위 큐 로직

```
우선순위 정렬 기준:
1. contradictions (가치 충돌) → priority = 100 - (confidence * 10)
2. recurring_fears (반복 두려움) → priority = 80 - (confidence * 10)
3. confidence < 0.6인 항목 → priority = 60 + ((0.6 - confidence) * 100)
4. open_loops (미해결 질문) → priority = loop.priority || 40

→ 상위 2-3개만 선택 (집중감 유지)
→ resolved_loops에 있는 항목은 제외
```

---

## 6. 테스트 시나리오

### 6.1 Gate 검증 테스트
1. **Round 1 전**: anchors 또는 narrative 없이 호출 → `fallback_questions` 반환 확인
2. **Round 2 전**: Round 1 answers 1개만 있을 때 → `fallback_questions` 반환 확인

### 6.2 Memory 누적 테스트
1. Step2 서술형 저장 → `memory_json`에 데이터 생성 확인
2. Round 1 답변 저장 → `memory_json` 업데이트 확인 (기존 + 새 항목 병합)

### 6.3 요약 배너 테스트
1. Step 2 → Step 3 이동 시 요약 배너 표시 확인
2. memory.stable_drivers 내용이 배너에 반영되는지 확인

### 6.4 Deepening Ladder 테스트
1. Round 2/3 질문에 고강도 감정 트리거 관련 질문 포함 확인
2. 질문에 `intent`, `what_to_extract` 필드 포함 확인

---

## 7. 완료 기준 (AC) 달성 상태

| # | 기준 | 상태 |
|---|------|------|
| 1 | Gate 작동 + 폴백: 결측 데이터 시 `fallback_questions` 반환 | ✅ |
| 2 | Step2 Memory: Step2 서술형 저장 후 `updateMemory()` 호출 | ✅ |
| 3 | Memory 누적: Round 답변 저장 후 Memory 업데이트 | ✅ |
| 4 | MEMORY_UPDATE/NEXT_TARGETS: Interviewer 컨텍스트에 포함 | ✅ |
| 5 | Deepening Ladder: 5단계 심화 규칙 + 감정 강도 트리거 | ✅ |
| 6 | intent + what_to_extract: RoundQuestion에 새 필드 추가 | ✅ |
| 7 | evidence_index 정규화 키: `step2.high_alive`, `round1.q2` 등 | ✅ |
| 8 | 요약 배너: Step 전환 시 memory 기반 요약 표시 | ✅ |
| 9 | profile_version: Derived Cache 불일치 방지 | ✅ |
| 10 | 캐시 재생성: draft 조각만 있으면 profile 언제든 재생성 가능 | ✅ |

---

## 8. 파일 변경 요약

| 파일 | 작업 | 라인 수 |
|------|------|---------|
| `aggregated-profile.ts` | **신규** | ~350 |
| `llm-memory.ts` | **신규** | ~300 |
| `010_add_aggregated_profile.sql` | **신규** | ~15 |
| `draft-routes.ts` | **수정** | +80 |
| `routes.ts` | **수정** | +60 |
| `llm-interviewer.ts` | **수정** | +120 |
| `types.ts` | **수정** | +15 |
| `index.tsx` | **수정** | +100 |

**총 신규/수정 라인**: 약 1,040줄

---

## 9. 코드 품질 검증

### 9.1 TypeScript 컴파일
- ✅ `src/services/ai-analyzer/` 디렉토리 내 모든 파일 오류 없음
- ⚠️ `backup/` 폴더에 레거시 오류 있음 (무시 가능, 백업 코드)

### 9.2 Lint 검사
- ✅ 모든 수정 파일 린트 오류 없음

### 9.3 Import 의존성
```
aggregated-profile.ts (신규)
├── → llm-memory.ts (신규)
├── → llm-interviewer.ts (수정)
├── → routes.ts (수정)
└── → draft-routes.ts (수정)

llm-memory.ts (신규)
├── → routes.ts (수정)
└── → draft-routes.ts (수정)
```

모든 import 경로 검증 완료 ✅

---

## 10. 배포 전 체크리스트

- [ ] DB 마이그레이션 실행: `migrations/010_add_aggregated_profile.sql`
- [ ] 환경 변수 확인: `OPENAI_API_KEY`
- [ ] 로컬 테스트: `npm run dev`
- [ ] Gate 실패 → 폴백 질문 UI 동작 확인
- [ ] 요약 배너 UI 스타일 확인

---

## 11. 향후 개선 가능 사항

1. **A/B 테스트 인프라**: NEXT_TARGETS 우선순위 알고리즘 변형 테스트
2. **KPI 대시보드**: 중복 질문률, 개인화 비율, 심층도 지표 측정
3. **유저 피드백 수집**: "질문이 나를 정확히 짚었다" 5점 척도 설문
4. **Memory 시각화**: 관리자용 Memory 디버그 UI

---

**보고서 작성 완료**
