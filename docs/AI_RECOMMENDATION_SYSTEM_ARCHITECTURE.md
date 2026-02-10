# CareerWiki AI 직업 추천 시스템 아키텍처 문서

> **버전**: v5.0 (LLM-Powered RAG + Personalized Cross-Matching)
> **최종 수정**: 2026-02-10
> **상태**: 구현 완료
> **작성 목적**: 기술 특허 출원 수준의 시스템 아키텍처 명세

---

## 목차

1. [시스템 개요](#1-시스템-개요)
2. [핵심 공식](#2-핵심-공식)
3. [5단계 파이프라인](#3-5단계-파이프라인)
4. [Stage 1: CAG - 사용자 프로필 캐싱](#4-stage-1-cag---사용자-프로필-캐싱)
5. [Stage 2: RAG - 벡터 의미 검색](#5-stage-2-rag---벡터-의미-검색)
6. [Stage 3: TAG - 규칙 기반 필터링](#6-stage-3-tag---규칙-기반-필터링)
7. [Stage 4: Personalized Scoring Engine](#7-stage-4-personalized-scoring-engine)
8. [Stage 5: LLM Judge - 대규모 언어 모델 평가](#8-stage-5-llm-judge---대규모-언어-모델-평가)
9. [Stage 6: LLM Reporter - 심리 분석 리포트](#9-stage-6-llm-reporter---심리-분석-리포트)
10. [한국어 자연어 후처리](#10-한국어-자연어-후처리)
11. [인프라 아키텍처](#11-인프라-아키텍처)
12. [데이터 흐름 전체도](#12-데이터-흐름-전체도)
13. [핵심 혁신 요약](#13-핵심-혁신-요약)

---

## 1. 시스템 개요

CareerWiki AI 추천 시스템은 사용자의 심리적 프로필(흥미, 가치관, 강점, 제약조건, 에너지 소모원, 실패 대응 방식 등 15개 축)을 수집하고, 이를 800개 이상의 직업 속성과 교차 매칭(Cross-Matching)하여 개인화된 직업 추천을 제공하는 다단계 하이브리드 AI 시스템이다.

### 1.1 설계 철학

기존 직업 추천 시스템은 "직업 중심 점수"(Job-Centric Scoring)를 사용한다. 즉, 각 직업의 속성(성장성, 안정성, 수입 등)을 단순 평균하여 점수를 산출하므로, **모든 사용자에게 동일한 점수가 산출**되는 한계가 있다.

본 시스템은 이를 근본적으로 해결하기 위해 **"사용자×직업 교차 매칭"(User×Job Cross-Matching)** 패러다임을 도입했다:

```
기존: Score(Job) = f(job_attributes)           → 모든 사용자에게 동일
본 시스템: Score(User, Job) = f(user_profile × job_attributes)  → 사용자별 고유 점수
```

### 1.2 핵심 구성 요소

| 구성 요소 | 역할 | 기술 |
|-----------|------|------|
| **CAG** (Cache-Augmented Generation) | 사용자 심리 프로필 수집/캐싱 | 15-문항 미니모듈 + D1 영속화 |
| **RAG** (Retrieval-Augmented Generation) | LLM 동적 쿼리 + 의미적 유사 직업 검색 | GPT-4o-mini 쿼리 생성 + OpenAI Embedding + Cloudflare Vectorize |
| **TAG** (Tag-based Filtering) | 규칙 기반 하드/소프트 필터링 | 직업 속성 태깅 + 조건부 배제 |
| **Personalized Scoring** | 사용자×직업 교차 점수 산출 | 가중 매트릭스 매칭 |
| **LLM Judge** | LLM 기반 정밀 평가 | GPT-4o-mini 배치 평가 |
| **LLM Reporter** | 심리 분석 리포트 생성 | GPT-4o-mini 8-섹션 병렬 생성 |

---

## 2. 핵심 공식

### 2.1 Fit Score (최종 적합도)

```
Fit = 0.55 × Like + 0.45 × Can - Risk
```

| 차원 | 설명 | 범위 | 가중치 |
|------|------|------|--------|
| **Like** | 사용자가 이 직업을 좋아할 정도 (흥미, 가치관, 워크스타일 매칭) | 0-100 | 55% |
| **Can** | 사용자가 이 직업을 잘 할 수 있는 정도 (강점, 적응성, 진입장벽) | 0-100 | 45% |
| **Risk** | 사용자의 제약조건과 충돌하는 정도 (야근, 교대, 원격, 학력 등) | 0-50 | 감산 |

Like 가중치를 55%로 높인 이유: 고Like-중Can 직업(예: 기상연구원 Like:78, Can:50)이 중Like-중Can 직업(예: 직업운동선수 Like:60, Can:63)보다 사용자 만족도가 높은 것으로 판단됨.

### 2.2 LLM Judge 가중치 (2차 정밀 평가)

```
Overall = 0.45 × fitScore + 0.35 × desireScore + 0.20 × feasibilityScore - riskPenalty
```

| LLM 평가 차원 | 매핑 대상 | 평가 기준 |
|---------------|-----------|-----------|
| **fitScore** | Can Score | 사용자 강점/스타일 ↔ 직업 요구역량 매칭 |
| **desireScore** | Like Score | 사용자 흥미/가치관 ↔ 직업 보상/환경 매칭 |
| **feasibilityScore** | 현실성 참고 | 사용자 제약조건 ↔ 직업 진입장벽 호환성 |
| **overallScore** | Fit Score | 종합 적합도 |

---

## 3. 5단계 파이프라인

```
사용자 답변 입력
    │
    ▼
┌──────────────────────────────────────────────────────────┐
│ Stage 1: CAG (사용자 프로필 캐싱)                          │
│   15개 미니모듈 질문 → 토큰화 → MiniModuleResult 생성       │
│   내부 갈등 감지 + Hard Bias 판정                          │
└──────────────────────────────────────────────────────────┘
    │ MiniModuleResult (15+ 토큰 카테고리)
    ▼
┌──────────────────────────────────────────────────────────┐
│ Stage 2: RAG (LLM 동적 벡터 검색)                          │
│   MiniModule → GPT-4o-mini → 적합 직업명/카테고리 생성      │
│   → OpenAI Embedding → Vectorize 검색                     │
│   ~800개 의미적 유사 직업 후보 검색                         │
└──────────────────────────────────────────────────────────┘
    │ 800개 후보 (VectorSearchResult[])
    ▼
┌──────────────────────────────────────────────────────────┐
│ Stage 3: TAG (규칙 기반 필터링) - 2단계                     │
│   3-1. TAG Hard Filter: 직업 속성 기반 배제 (11규칙)        │
│   3-2. MiniModule Hard Filter: 심리 프로필 기반 배제 (15규칙)│
│   3-3. Risk Penalty: 소프트 감점 (10규칙)                   │
└──────────────────────────────────────────────────────────┘
    │ ~400-600개 통과 후보 (ScoredJob[])
    ▼
┌──────────────────────────────────────────────────────────┐
│ Stage 4: Personalized Scoring (사용자×직업 교차 점수)        │
│   Like Score: 흥미×직업속성 + 가치×직업속성 + 스타일×직업속성 │
│   Can Score: 강점×직업요구 + 적응성보너스 - 진입장벽페널티    │
│   → final_score 기준 상위 40개 선별                        │
└──────────────────────────────────────────────────────────┘
    │ 40개 후보 (preFilteredJobs)
    ▼
┌──────────────────────────────────────────────────────────┐
│ Stage 5: LLM Judge (GPT-4o-mini 정밀 평가)                 │
│   40개 후보 → 4배치(10개/배치) → 병렬 평가                  │
│   fitScore/desireScore/feasibilityScore/overallScore 산출  │
│   증거 인용(Evidence Quotes) 검증                          │
│   → 상위 20개 최종 선정                                    │
└──────────────────────────────────────────────────────────┘
    │ 20개 최종 추천 (topJobs)
    ▼
┌──────────────────────────────────────────────────────────┐
│ Stage 6: LLM Reporter (심리 분석 리포트)                    │
│   8개 섹션 병렬 생성 (GPT-4o-mini)                         │
│   메타인지/업무스타일/내면갈등/성장곡선/전문가가이던스         │
│   한국어 조사 자동 교정 (받침 감지)                         │
└──────────────────────────────────────────────────────────┘
    │
    ▼
최종 응답: top_jobs(20) + like_top10 + can_top10 + premium_report
```

---

## 4. Stage 1: CAG - 사용자 프로필 캐싱

### 4.1 미니모듈 질문 체계 (15개 모듈)

사용자의 심리적 프로필을 15개 축으로 수집한다. 각 질문은 선택지 기반이며, 선택 결과가 표준 토큰으로 변환된다.

#### Q1. 흥미 (Interest) - 복수 선택, 상위 2개 추출

| 선택지 | 토큰 | 설명 |
|--------|------|------|
| 문제를 분석하고 해결책을 찾는 것 | `problem_solving` | 분석적 문제해결 선호 |
| 새로운 것을 만들거나 디자인하는 것 | `creating` | 창작/디자인 선호 |
| 사람들을 돕거나 가르치는 것 | `helping_teaching` | 대인 서비스 선호 |
| 데이터나 숫자를 다루는 것 | `data_numbers` | 데이터/수리 선호 |
| 조직하고 체계적으로 관리하는 것 | `organizing` | 관리/실행 선호 |
| 영향력을 발휘하고 설득하는 것 | `influencing` | 리더십/영향력 선호 |

#### Q2. 가치관 (Value) - 복수 선택, 상위 2개 추출

| 선택지 | 토큰 |
|--------|------|
| 스스로 결정하고 자율적으로 일하기 | `autonomy` |
| 새로운 것을 배우고 성장하기 | `growth` |
| 안정적이고 예측 가능한 환경 | `stability` |
| 높은 수입과 경제적 보상 | `income` |
| 의미 있는 일, 사회에 기여 | `meaning` |
| 인정받고 영향력 발휘하기 | `recognition` |

#### Q3. 강점 (Strength) - 복수 선택, 상위 2개 추출

| 선택지 | 토큰 |
|--------|------|
| 복잡한 것을 분석하고 논리적으로 정리 | `analytical` |
| 새로운 아이디어를 떠올리고 창의적 해결 | `creative` |
| 다른 사람에게 설명하고 소통하기 | `communication` |
| 계획을 세우고 체계적으로 실행 | `structured_execution` |
| 끈기 있게 끝까지 해내기 | `persistence` |
| 빠르게 배우고 적응하기 | `fast_learning` |

#### Q4. 제약조건 (Constraint) - 복수 선택, 전체 수집

| 선택지 | 토큰 |
|--------|------|
| 야근이나 긴 근무시간은 어려움 | `time_constraint` |
| 수입이 일정 수준 이상이어야 함 | `income_constraint` |
| 특정 지역에서만 근무 가능 | `location_constraint` |
| 육체적으로 힘든 일은 어려움 | `physical_constraint` |
| 새로운 자격증/학위 취득은 어려움 | `qualification_constraint` |
| 불확실하거나 불안정한 환경은 어려움 | `uncertainty_constraint` |

#### Q5. 업무 스타일 (Workstyle) - 복수 선택, 최대 2개

| 선택지 | 토큰 |
|--------|------|
| 혼자 집중 | `solo` |
| 팀워크 | `team` |
| 규칙/절차 있는 환경 | `structured` |
| 자유로운 환경 | `flexible` |

#### Q6. 배경 (Background) - 복수 선택, 최대 3개

| 선택지 | 토큰 |
|--------|------|
| 해외 거주/유학 | `overseas_living` |
| 전문 자격증/면허 | `license_cert` |
| 창업/사업 경험 | `startup_experience` |
| 연구/학술 경험 | `research_academic` |
| 봉사/NGO 활동 | `volunteer_ngo` |

#### Q7. 외국어 능력 (Language) - 복수 선택, 수준 포함

```typescript
{ language: 'english' | 'chinese' | 'japanese' | ..., level: 'basic' | 'business' | 'native' }
```

#### Q8. 희생 감수 (Sacrifice) - 복수 선택, 최대 2개

| 선택지 | 토큰 | Hard Bias 연관 |
|--------|------|---------------|
| 초반 연봉이 낮아도 괜찮다 | `low_initial_income` | 성장 투자형 |
| 다시 공부/훈련하는 건 괜찮다 | `willing_to_study` | 학습 감수형 |
| 완전히 다른 분야로 가도 괜찮다 | `field_change_ok` | 전환 수용형 |
| 주변의 시선을 감수할 수 있다 | `ignore_social_pressure` | 독립 판단형 |
| 아무것도 포기하고 싶지 않다 | `no_sacrifice` | 보수적/현상유지형 |

#### Q9. 에너지 소모원 (Energy Drain) - 복수 선택, 최대 2개

| 선택지 | 토큰 | 페널티 대상 직업 |
|--------|------|-----------------|
| 사람 상대할 때 | `people_drain` | people_facing > 70인 직업 |
| 계속 생각해야 하는 일 | `cognitive_drain` | analytical > 70인 직업 |
| 시간 압박이 있을 때 | `time_pressure_drain` | work_hours가 overtime인 직업 |
| 책임이 큰 결정을 해야 할 때 | `responsibility_drain` | execution > 80인 직업 |
| 반복 작업할 때 | `repetition_drain` | execution > 70 && creative < 30인 직업 |
| 예측 불가한 상황 | `unpredictability_drain` | shift_work가 required인 직업 |

#### Q10. 성취 피드백 (Achievement Feedback) - 복수 선택, 상위 2개

| 선택지 | 토큰 |
|--------|------|
| 결과가 수치로 보일 때 | `metric_feedback` |
| 누군가에게 직접 도움이 됐을 때 | `helping_feedback` |
| 어려운 문제를 해결했을 때 | `problem_solved_feedback` |
| 내가 만든 결과물이 남을 때 | `tangible_output_feedback` |
| 시간이 지날수록 성장할 때 | `growth_feedback` |

#### Q11. 실행 스타일 (Execution Style) - 단일 선택

| 선택지 | 토큰 |
|--------|------|
| 일단 해보며 배우는 편 | `action_first` |
| 계획이 서야 시작하는 편 | `plan_first` |
| 둘 다 상황 따라 다름 | `flexible_execution` |

#### Q12. 영향 범위 (Impact Scope) - 단일 선택

| 선택지 | 토큰 |
|--------|------|
| 개인 한 명 | `impact_individual` |
| 작은 팀/조직 | `impact_team` |
| 회사/산업 | `impact_industry` |
| 사회 전반 | `impact_society` |
| 잘 모르겠다 | `impact_unsure` |

#### Q13. 실패 대응 (Failure Response) - 단일 선택, **Hard Bias 보정자**

| 선택지 | 토큰 | Can 보너스 |
|--------|------|-----------|
| 다시 구조를 고쳐본다 | `iterate_on_failure` | +3 |
| 다른 방식으로 빠르게 바꾼다 | `pivot_on_failure` | +2 |
| 잠시 멈추고 정리한다 | `pause_on_failure` | 0 |
| 크게 흔들린다 | `emotionally_affected` | -3 |

#### Q14. 지속 동기 앵커 (Persistence Anchor) - 단일 선택

| 선택지 | 토큰 | Like 매칭 대상 |
|--------|------|---------------|
| 보상이 명확함 | `reward_anchor` | income 속성 |
| 성장 체감 | `growth_anchor` | growth 속성 |
| 함께하는 사람 | `people_anchor` | people_facing + teamwork 속성 |
| 의미/방향성 | `meaning_anchor` | people_facing + 기본 25점 |
| 안정성 | `stability_anchor` | stability 속성 |

#### Q15. 외부 기대 반응 (External Expectation) - 단일 선택

| 선택지 | 토큰 |
|--------|------|
| 기준이 있으면 편하다 | `external_structure_ok` |
| 상관없다 | `neutral_to_expectation` |
| 부담이 된다 | `expectation_pressure` |

### 4.2 MiniModuleResult 인터페이스

```typescript
interface MiniModuleResult {
  // Core (Q1-Q4)
  interest_top: string[]           // 상위 2개 흥미 토큰
  value_top: string[]              // 상위 2개 가치관 토큰
  strength_top: string[]           // 상위 2개 강점 토큰
  constraint_flags: string[]       // 전체 제약조건 플래그

  // Style & Background (Q5-Q7)
  workstyle_top?: string[]         // 최대 2개 워크스타일 토큰
  background_flags?: string[]      // 최대 3개 배경 플래그
  language_skills?: Array<{ language: string; level: string }>

  // Extended Modules (Q8-Q15)
  sacrifice_flags?: string[]       // Q8: 최대 2개
  energy_drain_flags?: string[]    // Q9: 최대 2개
  achievement_feedback_top?: string[]  // Q10: 상위 2개
  execution_style?: string         // Q11: 단일
  impact_scope?: string            // Q12: 단일
  failure_response?: string        // Q13: 단일 (Hard Bias)
  persistence_anchor?: string      // Q14: 단일
  external_expectation?: string    // Q15: 단일

  // Meta-signals
  low_confidence_flags?: string[]      // 신뢰도 낮은 축
  internal_conflict_flags?: string[]   // 내부 갈등 감지
}
```

### 4.3 내부 갈등 감지 (Conflict Detection)

Q8(희생 감수)과 Q9(에너지 소모원) 조합에서 Hard Bias를 감지한다:

| Q8 토큰 | Q9 토큰 | 해석 | 판정 |
|---------|---------|------|------|
| `no_sacrifice` | `unpredictability_drain` | 변화 거부 + 예측불가 회피 → 현 직업 유지형 | Conservative |
| `no_sacrifice` | `time_pressure_drain` | 포기 불가 + 시간압박 회피 → 워라밸 최우선 | Conservative |
| `no_sacrifice` | `responsibility_drain` | 포기 불가 + 책임 회피 → 전문가형(관리직X) | Conservative |
| `low_initial_income` | `time_pressure_drain` | 성장 투자 + 시간압박 민감 → 중견기업 성장 | Balanced |
| `willing_to_study` | `cognitive_drain` | 학습 감수 + 인지 피로 → 점진적 학습 | Balanced |
| `field_change_ok` | `unpredictability_drain` | 전환 수용 + 불확실성 회피 → 체계적 전환 | Balanced |
| `field_change_ok` | `people_drain` | 전환 수용 + 대인 피로 → 독립형 새 분야 | Exploratory |

### 4.4 가치관 갈등 쌍 (Value Conflict Pairs)

| 가치 A | 가치 B | 갈등 플래그 |
|--------|--------|------------|
| `autonomy` | `stability` | `autonomy_vs_stability` |
| `growth` | `income` | `growth_vs_income` |
| `meaning` | `income` | `meaning_vs_income` |
| `autonomy` | `recognition` | `autonomy_vs_recognition` |

### 4.5 CAG 상태 관리

```typescript
interface CAGState {
  sessionId: string
  asked_questions_log: AskedQuestionLog[]    // 이미 물어본 질문 추적
  axis_coverage_state: AxisCoverage          // 축별 정보 수집 상태
  qsp_history: QSP[]                         // QSP 히스토리 (최대 3개)
  tag_decision_log: TagDecisionLog           // TAG 판단 로그
  collection_progress: CollectionProgress    // Like/Can/Risk 수집 진행도
  currentRound: 1 | 2 | 3
}
```

수집 진행도 기준:
- **Like**: 최소 3개 항목 수집 필요
- **Can**: 최소 2개 항목 수집 필요
- **Risk**: 최소 1개 항목 수집 필요

---

## 5. Stage 2: RAG - LLM 동적 벡터 검색

### 5.1 개요

**v5.0 핵심 변경**: 정적 토큰→키워드 매핑 대신, GPT-4o-mini가 사용자 프로필을 보고 적합한 직업 카테고리/직업명을 **동적으로 생성**한다. 이 LLM 생성 텍스트를 OpenAI Embedding으로 벡터화하여 Cloudflare Vectorize에서 의미적으로 유사한 직업을 검색한다.

### 5.2 LLM 기반 검색 쿼리 생성 (buildLLMSearchQuery)

#### 5.2.1 기존 방식 (v4.0 이전) vs 현재 방식 (v5.0)

```
[v4.0 - 정적 매핑]
stability → "안정 정규직 공무원 공공기관" (수동 매핑, 누락 시 엉뚱한 결과)
routine  → (매핑 없음) → 의복수선원, 건강코디네이터 등 무관 직업 검색

[v5.0 - LLM 동적 생성]
{stability, routine, organizing} →
GPT-4o-mini → "공무원, 행정사무원, 세무공무원, 관세사, 경리사무원,
               사무보조원, 통계분석가, 노무사, 감사관, 법원서기관..."
→ 모든 유저 프로파일 조합에서 자동 추론
```

#### 5.2.2 LLM 검색 쿼리 생성 프로세스

```
1. MiniModuleResult → 자연어 프로필 변환
   "흥미: helping, organizing, routine
    가치관: stability, wlb, income
    강점: structured_execution, persistence, communication
    제약조건: qualification_constraint
    에너지소모: people_drain"

2. GPT-4o-mini 시스템 프롬프트:
   "당신은 한국 직업 전문가입니다. 사용자의 프로파일을 보고,
    이 사람에게 적합할 수 있는 한국 직업 카테고리 5~8개,
    구체적 직업명 15~25개를 나열해주세요."

3. LLM 출력 → 벡터 검색 쿼리로 사용
   "적합 직업: 공무원, 행정사무원, 세무사, 관세사, ..."
```

#### 5.2.3 비용 및 성능

| 항목 | 값 |
|------|-----|
| **모델** | GPT-4o-mini |
| **입력 토큰** | ~300 |
| **출력 토큰** | ~200 |
| **비용** | ~$0.001/call (1원 이하) |
| **지연** | ~1-2초 추가 |
| **온도** | 0.3 (일관성 우선) |
| **실패 처리** | 에러 전파 (fallback 없음) |

#### 5.2.4 LLM 프롬프트 규칙

1. 직업 카테고리 5~8개, 구체적 직업명 15~25개 나열
2. 한국어로 작성
3. 사용자의 흥미, 가치관, 강점, 제약조건 모두 고려
4. 뻔한 것만 나열하지 않고 숨겨진 적합 직업도 포함
5. 제약조건이 있으면 현실적인 직업 위주
6. 쉼표 구분, 한 줄 출력
7. 설명/번호 없이 직업명/카테고리만

### 5.3 검색 파라미터

| 파라미터 | 값 | 설명 |
|---------|-----|------|
| **임베딩 모델** | OpenAI `text-embedding-3-small` | 1536차원 |
| **topK** | 800 (기본) | 최대 1000 |
| **거리 메트릭** | Cosine Similarity | |
| **메타데이터** | job_name, category, ksco_major, ksco_mid, education_level | |
| **쿼리 최대 길이** | 500자 | LLM 출력 절단 |

### 5.4 벡터 관련 보너스

검색 결과의 벡터 유사도 점수가 기본 점수에 보너스로 반영된다:

```
Like 보너스 = vectorScore × 15   (최대 +15점)
Can 보너스  = vectorScore × 7.5  (최대 +7.5점)
Final 보너스 = vectorScore × 20  (최대 +20점, final_score에 직접 가산)
```

---

## 6. Stage 3: TAG - 규칙 기반 필터링

### 6.1 2단계 필터링 구조

TAG 필터링은 2단계로 구성된다:
1. **TAG Hard Filter**: 직업 속성(DB 태깅) 기반 11개 배제 규칙
2. **MiniModule Hard Filter**: 사용자 심리 프로필 기반 15개 배제 규칙

두 필터는 서로 보완적으로 작동한다:

| 구분 | TAG Filter | MiniModule Filter |
|------|-----------|-------------------|
| **데이터 소스** | 직업 속성 DB | 사용자 미니모듈 답변 |
| **규칙 수** | 11 하드 + 6 소프트 | 15 하드 + 4 소프트 |
| **속성 유형** | 근무시간, 교대, 원격, 학력, 자격증 | 에너지 소모원, 워크스타일, 강점, 흥미 |
| **판단 방식** | 문자열/숫자 비교 | 심리적 미스매치 콜백 |
| **패널티 상한** | 35점 | 40점 |

### 6.2 TAG Hard Exclusion Rules (11개)

| ID | 사용자 조건 | 직업 속성 | 배제 조건 |
|----|-----------|-----------|----------|
| `remote_only_vs_none` | 원격필수 | remote_possible | 'none' |
| `work_hours_strict_vs_heavy` | 야근불가 | work_hours | 'overtime_heavy' 또는 'always_overtime' |
| `shift_work_no_vs_required` | 교대불가 | shift_work | 'required' 또는 'always' |
| `degree_impossible_vs_required` | 학위취득불가 | degree_required | 'required' 또는 'masters_required' |
| `license_impossible_vs_required` | 자격증취득불가 | license_required | 'required' 또는 'mandatory' |
| `physical_labor_no_vs_high` | 육체노동 회피 | physical_demand | 'high' 또는 'very_high' |
| `physical_labor_no_vs_field` | 육체노동 회피 | work_environment | 'field', 'factory', 'workshop' |
| `repetitive_manual_no_vs_high` | 반복 회피 | repetitive_level | >= 70 |
| `repetitive_manual_no_vs_manufacturing` | 반복 회피 | job_type | manufacturing, assembly, production |
| `no_decision_impact_avoid_vs_low` | 의사결정 필요 | decision_authority | < 20 |
| `requires_data_work_vs_none` | 분석 선호 | analytical | < 20 |

### 6.3 TAG Risk Penalty Rules (6개)

| ID | 사용자 조건 | 직업 속성 | 감점 |
|----|-----------|-----------|------|
| 야근 빈번 선호 | prefer_low_overtime | overtime_frequent | -10 |
| 원격 선호 vs 불가 | prefer_remote | remote_possible='none' | -8 |
| 안정성 선호 vs 계약직 | prefer_stability | contract/freelance | -12 |
| 야근 엄격 vs 가끔 | work_hours_strict | overtime_sometimes | -15 |
| 교대 불가 vs 가능 | shift_work_no | sometimes/possible | -10 |
| 출장 잦음 | remote_only | travel=frequent | -8 |

### 6.4 MiniModule Hard Filter Rules (15개)

#### 에너지 소모원 기반 배제

| 토큰 | 배제 대상 | 조건 |
|------|----------|------|
| `people_drain` | 대인 서비스 직업 | people_facing > 70 |
| `time_pressure_drain` | 야근 직업 | work_hours = 'overtime_heavy' |
| `responsibility_drain` | 관리/리더십 직업 | job_name에 '관리자/팀장/본부장' 포함 |
| `repetition_drain` | 저변동 직업 | creative < 30 AND execution > 60 |
| `cognitive_drain` | 고인지부하 직업 | analytical > 80 |
| `unpredictability_drain` | 불규칙 일정 | shift_work = 'required' |

#### 워크스타일 기반 배제

| 토큰 | 배제 대상 | 조건 |
|------|----------|------|
| `solo` | 팀워크 필수 직업 | teamwork > 80 |
| `team` | 극단적 독립 직업 | solo_deep > 85 |
| `structured` | 비구조 직업 | job_type에 'freelance/creative' |
| `leader` | 독립 직업 | solo_deep > 70 |

#### 직업 유형 기반 광범위 배제 (Rule #15)

지식노동형 사용자(interest: data_numbers/problem_solving/creating, strength: analytical/creative)에 대해 7개 카테고리의 비지식 직업을 자동 배제:

| 카테고리 | 패턴 예시 | 배제 직업 수 |
|---------|----------|------------|
| **공장/제조** | 조작원, 기능원, 용융원, 성형원, 연마공, 주형, 주조, 도장, 도금, 절삭, 용접 등 | ~45종 |
| **스포츠** | 운동선수, 코치, 심판, 체육, 스포츠 | ~10종 |
| **농축산** | 재배원, 사육사, 농부, 축산, 목장, 양식, 종돈, 종축, 원예 | ~15종 |
| **식품가공** | 등급원, 식품가공, 도축, 도계, 제분 | ~8종 |
| **건설** | 건축기능, 미장, 타일, 방수공, 비계, 철근, 배관 | ~12종 |
| **운송** | 택시운전, 버스운전, 화물차, 택배, 굴삭기 | ~8종 |
| **개인서비스** | 미용사, 이용사, 네일아티스트, 세탁 | ~5종 |

### 6.5 MiniModule Risk Penalty Rules (4개)

| 조건 | 대상 | 감점 |
|------|------|------|
| cognitive_drain + 고인지 직업 | analytical > 70 | -20 |
| structured 선호 + 자유 환경 | creative > 60 | -15 |
| team 선호 + 독립 직업 | solo_deep > 60 | -10 |
| unpredictability_drain + 불규칙 | shift_work != 'none' | -15 |

---

## 7. Stage 4: Personalized Scoring Engine

### 7.1 개요

본 시스템의 핵심 혁신인 **사용자×직업 교차 매칭 엔진**이다. 사용자의 미니모듈 토큰과 직업 속성을 교차 참조하여 Like/Can 기본 점수를 산출한다.

### 7.2 Like Score 산출 공식

```
Like = weightedAverage(
  흥미 매칭(w=1.0),
  가치 매칭(w=0.8),
  워크스타일 매칭(w=0.5),
  지속동기 매칭(w=0.3)
) - 에너지소모 페널티 - 미스매치 페널티
```

#### 7.2.1 흥미 → 직업 속성 교차 매칭 (가중치: 1.0)

| 사용자 흥미 토큰 | 직업 속성 매핑 |
|-----------------|--------------|
| `data_numbers` | analytical×0.7 + execution×0.3 |
| `problem_solving` | analytical×0.6 + creative×0.2 + execution×0.2 |
| `creating` | creative×0.8 + analytical×0.2 |
| `helping_teaching` | people_facing×0.7 + teamwork×0.3 |
| `organizing` | execution×0.6 + teamwork×0.4 |
| `influencing` | people_facing×0.5 + execution×0.3 + income×0.2 |

**예시**: 사용자가 `data_numbers` + `problem_solving` 선택, 직업 A의 analytical=80, execution=40, creative=30인 경우:
- data_numbers 매칭 = 80×0.7 + 40×0.3 = 68
- problem_solving 매칭 = 80×0.6 + 30×0.2 + 40×0.2 = 62
- 흥미 평균 = (68 + 62) / 2 = 65

#### 7.2.2 가치관 → 직업 속성 교차 매칭 (가중치: 0.8)

| 사용자 가치 토큰 | 직업 속성 매핑 | 기본 가산 |
|----------------|--------------|---------|
| `growth` | growth×1.0 | - |
| `stability` | stability×1.0 | - |
| `income` | income×1.0 | - |
| `autonomy` | solo_deep×0.6 + wlb×0.4 | - |
| `meaning` | people_facing×0.3 + growth×0.3 | +25 |
| `recognition` | income×0.4 + growth×0.3 + people_facing×0.3 | - |

`meaning`에 기본 25점이 가산되는 이유: "의미"는 특정 직업 속성에 직접 매핑되기 어려우므로, 최소 보장 점수를 부여한다.

#### 7.2.3 업무 스타일 → 직업 속성 교차 매칭 (가중치: 0.5)

| 사용자 스타일 토큰 | 직업 속성 매핑 |
|------------------|--------------|
| `solo` | solo_deep×1.0 |
| `team` | teamwork×1.0 |
| `structured` | execution×0.6 + stability×0.4 |
| `flexible` | creative×0.5 + wlb×0.5 |

#### 7.2.4 지속 동기 앵커 → 직업 속성 매칭 (가중치: 0.3)

| 사용자 앵커 토큰 | 직업 속성 매핑 | 기본 가산 |
|----------------|--------------|---------|
| `reward_anchor` | income×1.0 | - |
| `growth_anchor` | growth×1.0 | - |
| `stability_anchor` | stability×1.0 | - |
| `meaning_anchor` | people_facing×0.4 | +25 |
| `people_anchor` | people_facing×0.6 + teamwork×0.4 | - |

#### 7.2.5 에너지 소모 페널티 (Like에서 감산)

| 토큰 | 조건 | 감점 |
|------|------|------|
| `people_drain` | people_facing > 70 | -15 |
| `people_drain` | people_facing 51-70 | -8 |
| `cognitive_drain` | analytical > 70 | -10 |
| `time_pressure_drain` | always_overtime / overtime_heavy | -15 |
| `time_pressure_drain` | overtime_frequent / overtime_some | -8 |
| `repetition_drain` | execution > 70 AND creative < 30 | -10 |
| `responsibility_drain` | execution > 80 | -8 |
| `unpredictability_drain` | shift_work = required | -12 |
| `unpredictability_drain` | shift_work = possible | -5 |

#### 7.2.6 워크스타일 미스매치 페널티

- solo 선호 + solo_deep < 30 → **-12점**
- solo 선호 + solo_deep < 40 → **-6점**

#### 7.2.7 지식노동 vs 육체노동 미스매치 페널티

지식노동형 사용자(data_numbers/problem_solving/creating)가 고execution/저analytical 직업을 만나면:
- execution > 60 AND analytical < 50 AND creative < 40 → **최대 -25점** (격차 비례)
- manualScore > knowledgeScore × 1.5 AND execution > 50 → 추가 **-10점**

#### 7.2.8 최종 Like 산출

```
rawLike = weightedAverage(위의 모든 매칭 점수)
rawLike -= 에너지소모 페널티 합계
rawLike -= 워크스타일 미스매치 페널티
rawLike -= 지식노동 미스매치 페널티
Like = clamp(rawLike, 0, 100)
```

### 7.3 Can Score 산출 공식

```
Can = 30(기본)
    + 강점 매칭 (비례 0~30/직업당)
    + 적응성 보너스 (-5~+5)
    + 회복탄력성 보너스 (-3~+3)
    - 진입장벽 페널티 (0~-95)
    - 미스매치 페널티 (0~-45)
```

#### 7.3.1 강점 → 직업 요구 속성 비례 매칭

| 사용자 강점 토큰 | 대응 직업 속성 | 점수 산출 |
|----------------|-------------|----------|
| `analytical` | analytical | (직업의 analytical / 100) × 30 |
| `creative` | creative | (직업의 creative / 100) × 30 |
| `communication` | people_facing | (직업의 people_facing / 100) × 30 |
| `structured_execution` | execution | (직업의 execution / 100) × 30 |
| `persistence` | (범용) | +5 |
| `fast_learning` | (범용) | +8 |

**예시**: 사용자 강점이 `analytical` + `fast_learning`, 직업 B의 analytical=67인 경우:
- analytical 매칭 = (67/100) × 30 = 20
- fast_learning = +8
- 기본 30 + 20 + 8 = **58점**

#### 7.3.2 적응성 보너스 (sacrifice_flags)

| 토큰 | 보너스 |
|------|--------|
| `willing_to_study` | +5 |
| `field_change_ok` | +3 |
| `low_initial_income` | +2 |
| `ignore_social_pressure` | +1 |
| `no_sacrifice` | -5 |

#### 7.3.3 회복탄력성 보너스 (failure_response)

| 토큰 | 보너스 |
|------|--------|
| `iterate_on_failure` | +3 |
| `pivot_on_failure` | +2 |
| `flexible_execution` | +1 |
| `pause_on_failure` | 0 |
| `emotionally_affected` | -3 |

#### 7.3.4 진입장벽 페널티

직업이 요구하는 학력/자격/경력에 따른 기본 페널티:

| 학력 요구 | 페널티 | 자격증 요구 | 페널티 | 경력 요구 | 페널티 |
|----------|--------|-----------|--------|----------|--------|
| none | 0 | none | 0 | none | 0 |
| college | -5 | preferred | -5 | entry | -3 |
| bachelor | -12 | required | -18 | junior | -8 |
| master | -22 | multiple_required | -30 | mid | -18 |
| phd | -35 | | | senior | -30 |

#### 7.3.5 배경에 따른 페널티 완화

| 사용자 배경 | 완화 대상 | 완화율 |
|-----------|----------|--------|
| `license_cert` | license_required 페널티 | 60% 감소 |
| `research_academic` | degree_required 페널티 | 40% 감소 |
| `willing_to_study` | experience_required 페널티 | 30% 감소 |

**예시**: 직업 C가 master 학위 요구(-22), 사용자가 research_academic 배경인 경우:
- 완화 후 페널티 = -22 × 0.6 = **-13점** (원래 -22에서 9점 완화)

#### 7.3.6 주요 속성 미스매치 페널티

직업의 지배적 속성(60 이상)이 사용자 강점에 없으면:
- **최대 -25점** (격차 비례, `(dominantVal - 50) × 0.5`)

지식노동형 강점(analytical/creative)인데 고execution 직업이면:
- execution > 60 AND analytical < 50 AND creative < 40 → **최대 -20점**

#### 7.3.7 최종 Can 산출

```
Can = 30 + strengthMatches + adaptabilityBonus + resilienceBonus
    + degreePenalty + licensePenalty + experiencePenalty
    - mismatchPenalty
Can = clamp(Can, 5, 100)   // 최소 5점 보장
```

### 7.4 Fallback (mm 없는 경우)

MiniModuleResult가 없으면 기존 직업 중심 공식으로 fallback:

```
Like = (wlb + growth + stability + income) / 4
Can  = (teamwork + analytical×0.7 + creative) / 3
```

### 7.5 Fact Score 보정

LLM 인터뷰(3라운드 심층 질문)에서 추출된 Fact 데이터가 추가 보정을 제공한다:

| 정책 | 값 | 설명 |
|------|-----|------|
| MAX_BOOST_PER_FACT | 20 | 단일 Fact의 최대 보정치 |
| DUPLICATE_POLICY | highest_wins | 같은 속성 중복 시 최고값만 |
| MAX_TOTAL_LIKE_BOOST | 25 | Like 보정 총합 상한 |
| MAX_TOTAL_CAN_BOOST | 30 | Can 보정 총합 상한 |
| MAX_TOTAL_RISK_REDUCTION | 20 | Risk 감소 상한 |

Fact 우선순위:
1. `confirmed_constraint` (100): 확인된 제약
2. `priority.dealbreaker` (80): 딜브레이커
3. `priority.top1` (70): 최우선 가치
4. `tradeoff` (60): 트레이드오프 선택
5. `motivation` (50): 동기
6. `discovery` (40): 발견
7. `insight` (30): 통찰

---

## 8. Stage 5: LLM Judge - 대규모 언어 모델 평가

### 8.1 개요

상위 40개 후보를 GPT-4o-mini가 정밀 평가한다. 사용자의 전체 프로필(미니모듈 15개 축 + 서술형 답변 + 3라운드 심층 답변)을 참고하여 각 직업의 적합도를 다각도로 평가한다.

### 8.2 입력 데이터 (JudgeInput)

```typescript
interface JudgeInput {
  candidates: FilteredCandidate[]     // 40개 후보 직업
  searchProfile: SearchProfile        // 검색 프로필
  miniModuleResult?: MiniModuleResult // 전체 미니모듈 결과 (15축)
}
```

### 8.3 사용자 컨텍스트 구성 (buildUserContext)

LLM Judge에 전달되는 사용자 데이터:

```
[USER_DATA]
  [DECISION_SUMMARY] - 1줄 메타 요약
  [HARD_BIAS_CONFLICTS] - Q8↔Q9 갈등 해석

  [JUDGMENT_BASIS]
    user_interest_tokens: [상위 2개]
    user_value_tokens: [상위 2개]
    user_strength_tokens: [상위 2개]
    user_constraint_flags: [전체]

  [EXTENDED_TOKENS]
    user_sacrifice_flags: [Q8]
    user_energy_drain_flags: [Q9]
    user_achievement_feedback: [Q10]
    user_execution_style: [Q11]
    user_impact_scope: [Q12]
    user_failure_response: [Q13]
    user_persistence_anchor: [Q14]
    user_external_expectation: [Q15]

  [NARRATIVE_FACTS]
    highAliveMoment: "가장 살아있다고 느낀 순간" (서술)
    lostMoment: "가장 힘들었던 순간" (서술)

  [UNIVERSAL_ANSWERS]
    Interest, Dislike, Priority, Strength, Work Style

  [ROUND_ANSWERS]
    Round 1 (욕망/동기): 3-5개 답변
    Round 2 (회피/두려움): 3-5개 답변
    Round 3 (현실/전략): 3-5개 답변
[/USER_DATA]
```

### 8.4 직업 컨텍스트 구성 (buildJobContext)

각 직업에 대해 D1 DB에서 추출된 데이터:

```
[JOB: {job_id}]
  Name: 직업명
  Description: 직업 설명 (150자)
  Skills: 핵심 스킬 (Top 5, 쉼표 구분)
  CareerPath: 경력 경로 (Junior → Senior → Director)
  WorkEnvironment: 근무 환경 (50자)
  IncomeInfo: 수입 범위
  EducationRequired: 요구 학력
  Certifications: 관련 자격증 (Top 3)
  SuitablePersonality: 적합한 성격 특성
  GrowthPotential: 성장 잠재력
  RiskWarnings: 위험 경고 (TAG 필터 결과)
[/JOB]
```

### 8.5 평가 기준

시스템 프롬프트에 의해 LLM Judge는 각 직업을 3가지 축으로 평가한다:

| 축 | 이름 | 평가 기준 | 가중치 |
|----|------|----------|--------|
| **Fit** | 역량 적합도 | 사용자 강점/스타일 ↔ 직업 요구역량 | 45% |
| **Desire** | 흥미 적합도 | 사용자 흥미/가치관 ↔ 직업 보상/환경 | 35% |
| **Feasibility** | 현실 호환성 | 사용자 제약조건 ↔ 직업 진입장벽 | 20% |

### 8.6 점수 산출

```
overallScore = fitScore × 0.45 + desireScore × 0.35 + feasibilityScore × 0.20 - riskPenalty
```

모든 점수는 0-100 범위로 클램핑된다.

### 8.7 배치 처리

| 파라미터 | 값 |
|---------|-----|
| **배치 크기** | 10개 직업/배치 |
| **병렬 배치 수** | 3 |
| **최대 후보** | 60개 |
| **재시도** | 2회 (지수 백오프: 1초, 2초) |
| **모델** | GPT-4o-mini (OpenAI API) |
| **온도** | 0.5 |
| **최대 토큰** | 8000 |

### 8.8 증거 인용 검증 (Evidence Quote Validation)

LLM Judge의 출력에 포함된 증거 인용(Evidence Quotes)을 검증한다:

1. 인용문이 실제 사용자 텍스트에 존재하는지 확인
2. 환각(hallucinated) 인용문 제거
3. 유효 인용문이 2개 미만이면 점수 -10점 페널티
4. 각 무효 인용문에 대해 경고 로그

### 8.9 점수 정규화 (Z-Score Normalization)

배치 간 점수 편차를 보정하기 위해 Z-점수 정규화를 수행한다:

- 결과가 10개 이상일 때만 적용
- 평균=50, 표준편차=15로 정규화
- 기존 편차가 5 미만이면 스킵 (이미 균일)

### 8.10 점수 매핑 (Judge → 최종 점수)

```typescript
topJobs = judgeResults.map(result => ({
  like_score: result.desireScore,        // Desire = Like (흥미/가치 매칭)
  can_score: result.fitScore,            // Fit = Can (강점/역량 매칭)
  fit_score: result.overallScore,        // Overall = Fit (종합)
  final_score: result.overallScore,
  feasibility_score: result.feasibilityScore,  // 현실성 (참고용)
  risk_penalty: result.riskPenalty,
  rationale: result.rationale,           // 추천 이유 (한국어)
  like_reason: result.likeReason,        // 좋아할 이유
  can_reason: result.canReason,          // 잘할 이유
  evidence_quotes: result.evidenceQuotes,
}))
```

### 8.11 Fallback

LLM Judge 실패 시 서버 500 에러를 반환한다 (규칙 기반 fallback 없음). 이는 추천 품질 보장을 위한 의도적 설계이다.

---

## 9. Stage 6: LLM Reporter - 심리 분석 리포트

### 9.1 개요

LLM Judge 완료 후, GPT-4o-mini가 사용자의 심리적 프로필을 깊이 분석하여 8개 섹션으로 구성된 프리미엄 리포트를 생성한다.

### 9.2 입력 데이터 (ReporterInput)

```typescript
interface ReporterInput {
  sessionId: string
  judgeResults: LLMJudgeResult[]       // 상위 20개 직업 평가 결과
  searchProfile: SearchProfile          // 검색 프로필
  narrativeFacts?: NarrativeFacts       // 서술형 답변 (가장 살아있던 순간, 힘들었던 순간)
  roundAnswers?: RoundAnswer[]          // 3라운드 심층 답변
  universalAnswers?: Record<string, string | string[]>  // 통합 답변
  hardCutList: HardCutItem[]            // 배제된 직업 목록
  miniModuleResult?: MiniModuleResult   // 미니모듈 전체 결과
}
```

### 9.3 출력 구조 (PremiumReportV3)

| 섹션 | 설명 | 생성 방식 |
|------|------|----------|
| **executiveSummary** | 판단 구조 요약 + 핵심 흥미/가치/강점 + 추천 방향 | LLM |
| **workStyleMap** | 5축 점수 (-100~+100): 분석↔창의, 혼자↔팀, 구조↔자유, 빠름↔꼼꼼, 지시↔자율 | LLM |
| **workStyleNarrative** | 업무 스타일 서술형 분석 | LLM |
| **innerConflictAnalysis** | 핵심 내면 갈등 분석 | LLM |
| **conflictPatterns** | 갈등 패턴 배열 | LLM |
| **failurePattern** | 번아웃 트리거 + 이직 패턴 | LLM |
| **stressProfile** | 자기평가 오류 + 관계 갈등 분석 | LLM |
| **stressTriggers** | 3개 이상 스트레스 트리거 + 설명 | LLM |
| **growthCurveType** | 성장 곡선 유형 분류 | LLM |
| **growthCurveDescription** | 성장 전략 상세 | LLM |
| **transitionTiming** | 30/60/90일 실행 계획 | LLM |
| **lifeVersionStatement** | 인생 한 줄 + 3문장 확장 (why/how/where) | LLM |
| **expertGuidance** | doNow(3-5), stopDoing(2-3), experiment(2-3), cognitiveTrapFixes, conflictResponses | LLM |
| **profileInterpretation** | 토큰 의미 해석 (흥미/강점/가치/제약) + 종합 프로필 | LLM/Fallback |
| **metaCognition** | 자기 이해 (나의 무기, 선호 지도, 내면 탐색, 스트레스 회복, 성장 잠재력) | LLM/Fallback |
| **jobRecommendations** | Top 5(종합), Top 10(Like), Top 10(Can) | 데이터 |
| **appendix** | hardCutList, evidenceIndex, totalCandidates | 데이터 |
| **safetyCompliance** | 진단용어 미사용 확인 + 전문 도움 제안 여부 | 검증 |

### 9.4 시스템 프롬프트 핵심 원칙

```
이 분석은 '당신이 어떤 사람인가'를 판단하지 않습니다.
대신, 당신이 어떤 기준으로 선택할 때 가장 안정적인지를 분석합니다.

금지: "당신에게 어울리는 직업은...", "AI가 추천합니다"
사용: "현재 당신의 판단 구조 기준에서, 다음 선택이 가장 일관됩니다"
```

### 9.5 모델 파라미터

| 파라미터 | 값 |
|---------|-----|
| **모델** | GPT-4o-mini |
| **온도** | 0.6 |
| **최대 토큰** | 1500 (섹션별) |
| **병렬 섹션** | 8개 동시 생성 |

### 9.6 Fallback 리포트

OpenAI API 키가 없거나 실패 시, 규칙 기반 fallback 리포트를 생성한다:

- TOKEN_TO_KOREAN 사전을 활용한 토큰 의미 해석
- 강점/흥미/가치/제약 매핑 테이블 기반 텍스트 생성
- 내부 갈등 감지 (autonomy_vs_stability 등)
- `_meta.generated_by: 'rule'` 표시

---

## 10. 한국어 자연어 후처리

### 10.1 조사 자동 교정 시스템

LLM이 생성한 한국어 텍스트에서 조사 오류를 자동 교정한다.

#### 10.1.1 받침 감지 (hasBatchim)

유니코드 한글 음절의 받침 유무를 판별한다:

```
한글 음절 범위: 0xAC00 ~ 0xD7A3
받침 여부 = (charCode - 0xAC00) % 28 !== 0

숫자 받침: 0,1,3,6,7,8 → 있음 / 2,4,5,9 → 없음
```

#### 10.1.2 교정 대상 조사 패턴

| 패턴 | 받침 있을 때 | 받침 없을 때 | 예시 |
|------|------------|------------|------|
| 은(는) | 은 | 는 | 분석은, 자율는→자율은 |
| 이(가) | 이 | 가 | 성장이, 소통가→소통이 |
| 을(를) | 을 | 를 | 안정을, 인정를→인정을 |
| 와(과) | 과 | 와 | 성장과, 자율와→자율과 |
| 로(으로) | 으로 | 로 | 분석으로, 자율로 |

반각 괄호 `()` 및 전각 괄호 `（）` 모두 처리.

#### 10.1.3 재귀적 심층 적용 (fixParticlesDeep)

리포트 전체 객체를 재귀 순회하며 모든 문자열 필드에 조사 교정을 적용한다:

```typescript
function fixParticlesDeep(obj: any): any {
  if (typeof obj === 'string') return fixKoreanParticles(obj)
  if (Array.isArray(obj)) return obj.map(fixParticlesDeep)
  if (obj && typeof obj === 'object') {
    for (const [k, v] of Object.entries(obj)) result[k] = fixParticlesDeep(v)
    return result
  }
  return obj
}
```

LLM 리포트 출력과 Fallback 리포트 모두에 적용된다.

---

## 11. 인프라 아키텍처

### 11.1 Cloudflare Workers 스택

| 서비스 | 바인딩 | 용도 |
|--------|--------|------|
| **D1 Database** | `DB` | 직업/학과/HowTo/유저/세션/직업속성 저장 (SQLite) |
| **R2 Storage** | `UPLOADS` | 이미지/파일 업로드 저장소 |
| **Vectorize** | `VECTORIZE` | 직업 임베딩 벡터 인덱스 (1536차원, cosine) |
| **Workers AI** | `AI` | LLM 호출 (Llama 3.1 fallback) |
| **OpenAI API** | (Secret) | GPT-4o-mini 호출 (Judge/Reporter/Embedding) |

### 11.2 주요 데이터베이스 테이블

| 테이블 | 역할 | 주요 컬럼 |
|--------|------|----------|
| `jobs` | 직업 마스터 | id, job_name, slug, api_data_json, merged_profile_json |
| `job_attributes` | 직업 속성 태그 | wlb, growth, stability, income, analytical, creative, execution, people_facing, teamwork, solo_deep, work_hours, shift_work, degree_required, license_required |
| `ai_analysis_results` | 분석 결과 저장 | session_id, result_json, career_state, confidence_score |
| `narrative_facts` | 서술형 Fact | session_id, high_alive_moment, lost_moment |
| `round_answers` | 라운드별 답변 | session_id, round_number, question_id, answer |

### 11.3 API 엔드포인트

```
POST /api/ai-analyzer/v3/recommend
  Input: { session_id, draft_id, mini_module_result, topK?, judgeTopN?, debug? }
  Output: {
    success: true,
    recommendations: { top_jobs[20], like_top10, can_top10, total_candidates, filtered_count },
    premium_report: PremiumReportV3,
    report_mode: 'llm' | 'fallback' | 'none',
    duration_ms: number
  }
```

---

## 12. 데이터 흐름 전체도

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        사용자 인터랙션 레이어                             │
│                                                                        │
│  [미니모듈 15문항] → [서술형 2문항] → [3라운드 심층질문] → [추천 요청]      │
└────────────────────────────────────┬────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         CAG Layer (캐시)                                │
│                                                                        │
│  MiniModuleResult {                                                    │
│    interest_top: ["data_numbers", "problem_solving"]                   │
│    value_top: ["growth", "income"]                                     │
│    strength_top: ["analytical", "fast_learning"]                       │
│    constraint_flags: ["qualification_constraint"]                      │
│    workstyle_top: ["solo", "structured"]                               │
│    sacrifice_flags: ["willing_to_study"]                               │
│    energy_drain_flags: ["people_drain", "repetition_drain"]            │
│    failure_response: "iterate_on_failure"                              │
│    persistence_anchor: "growth_anchor"                                 │
│    ...                                                                 │
│  }                                                                     │
└────────────────────────────────────┬────────────────────────────────────┘
                                     │
                    ┌────────────────┼────────────────┐
                    ▼                ▼                ▼
         ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
         │  RAG Layer   │  │  TAG Layer   │  │  Scoring     │
         │              │  │              │  │  Engine       │
         │ MiniModule→  │  │ Hard: 11+15  │  │              │
         │ GPT-4o-mini→ │  │ Soft: 6+4    │  │ Like=f(U×J)  │
         │ 직업명 생성→  │  │ Name Filter  │  │ Can=f(U×J)   │
         │ Embedding→   │  │              │  │ Risk=f(U,J)   │
         │ Vectorize    │  │ 400~600 통과  │  │ Fit=.55L+    │
         │ 800 후보     │  │              │  │   .45C-R      │
         └──────┬───────┘  └──────┬───────┘  └──────┬───────┘
                │                 │                  │
                └────────┬────────┘                  │
                         │      ┌────────────────────┘
                         ▼      ▼
                ┌─────────────────────┐
                │   Pre-Filter        │
                │   final_score 기준   │
                │   상위 40개 선별     │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │   LLM Judge         │
                │   GPT-4o-mini       │
                │                     │
                │   40 → 4배치 × 10   │
                │   3배치 병렬 평가    │
                │                     │
                │   fitScore (→Can)   │
                │   desireScore (→Like)│
                │   feasibility       │
                │   overallScore (→Fit)│
                │                     │
                │   → 상위 20개 선정   │
                └──────────┬──────────┘
                           │
                ┌──────────┴──────────┐
                │                     │
                ▼                     ▼
        ┌──────────────┐     ┌──────────────┐
        │ like_top10   │     │ can_top10    │
        │              │     │              │
        │ Like 내림차순 │     │ Can 내림차순  │
        │ Fit≥25 필터  │     │ Fit≥25 필터  │
        └──────────────┘     └──────────────┘
                │                     │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │   LLM Reporter      │
                │   GPT-4o-mini       │
                │                     │
                │   8개 섹션 병렬 생성  │
                │   메타인지           │
                │   업무스타일 5축      │
                │   내면갈등           │
                │   성장곡선           │
                │   전문가 가이던스     │
                │   인생 한 줄         │
                │                     │
                │   + 한국어 조사 교정  │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │   최종 응답          │
                │                     │
                │   top_jobs: 20개    │
                │   like_top10: 10개  │
                │   can_top10: 10개   │
                │   premium_report    │
                │   report_mode       │
                │   duration_ms       │
                └─────────────────────┘
```

---

## 13. 핵심 혁신 요약

### 13.1 사용자×직업 교차 매칭 (Cross-Matching)

기존 직업 추천 시스템과의 차별점:

| 구분 | 기존 방식 | 본 시스템 |
|------|----------|----------|
| **점수 산출** | Job-Centric: `f(job)` | User×Job: `f(user, job)` |
| **개인화** | Fact 보정만 (±5~30) | 기본 점수 자체가 개인화 |
| **사용자 데이터** | 3-5개 속성 | 15개 축 × 6개 이상 토큰 |
| **매칭 방식** | 단순 가감산 | 가중 행렬 곱 + 비례 스코어링 |
| **미스매치 감지** | 없음 | 지식/육체 미스매치 자동 페널티 |
| **에너지 소모** | 반영 안 됨 | 6개 소모원 × 6개 직업 조건 매칭 |

### 13.2 LLM 동적 검색 쿼리 생성 (v5.0 신규)

기존 RAG의 핵심 한계: 정적 토큰→키워드 매핑은 수동으로 관리해야 하며, 누락된 매핑이 있으면 엉뚱한 직업이 검색된다.

| 구분 | 정적 매핑 (v4.0) | LLM 동적 생성 (v5.0) |
|------|----------------|---------------------|
| **매핑 방식** | 토큰별 수동 키워드 등록 | GPT-4o-mini가 프로필 해석 후 직업명 생성 |
| **커버리지** | 등록된 토큰만 매핑 | 모든 토큰 조합 자동 커버 |
| **유지보수** | 새 토큰마다 수동 추가 필요 | 유지보수 불필요 |
| **비용** | 0 | ~$0.001/call |
| **정밀도** | 키워드 수준 (의미 손실) | 직업명 수준 (의미 보존) |
| **실패 처리** | 빈 키워드 → 랜덤 결과 | 에러 전파 (즉시 감지) |

### 13.3 다단계 하이브리드 필터링

```
LLM 검색 쿼리 생성 → 벡터 의미 검색 (RAG) → 규칙 하드 필터 (TAG)
     → 심리 프로필 필터 (MiniModule) → 교차 점수 산출
     → LLM 정밀 평가 → 심리 분석 리포트
```

이 6단계 파이프라인은 각 단계의 장단점을 상호 보완한다:
- **LLM Search Query**: 유저 프로필에서 적합 직업군 자동 추론 (검색 품질 보장)
- **RAG**: 의미적 유사성 기반 광범위 탐색 (recall 최대화)
- **TAG**: 하드 조건 기반 부적합 제거 (precision 보장)
- **MiniModule Filter**: 심리적 미스매치 제거 (개인화 보장)
- **Personalized Scoring**: 사용자별 고유 점수 산출 (차별화 보장)
- **LLM Judge**: 맥락적 종합 평가 (설명 가능성 보장)
- **LLM Reporter**: 깊이 있는 심리 분석 (사용자 경험 완성)

### 13.4 15축 심리 프로필링

단일 질문지 대신 15개 독립 축으로 사용자를 다각도 분석:

1. **흥미** (무엇에 끌리는가)
2. **가치관** (무엇을 중시하는가)
3. **강점** (무엇을 잘하는가)
4. **제약조건** (무엇이 불가능한가)
5. **업무 스타일** (어떻게 일하고 싶은가)
6. **배경** (어떤 경험이 있는가)
7. **외국어** (어떤 언어를 구사하는가)
8. **희생 감수** (무엇을 포기할 수 있는가)
9. **에너지 소모원** (무엇이 지치게 하는가)
10. **성취 피드백** (언제 보람을 느끼는가)
11. **실행 스타일** (어떻게 시작하는가)
12. **영향 범위** (어디까지 영향을 미치고 싶은가)
13. **실패 대응** (실패 시 어떻게 반응하는가)
14. **지속 동기** (무엇이 계속하게 하는가)
15. **외부 기대** (타인의 기대에 어떻게 반응하는가)

이 15개 축의 조합은 이론적으로 6^4 × 4^1 × 5^3 × 6^1 × 5^2 × 3^3 × 5^1 × 3^1 = **수십억 가지** 고유 프로필을 생성할 수 있다.

### 13.5 Hard Bias 갈등 해석 시스템

Q8(희생)과 Q9(에너지 소모)의 조합에서 자동으로 의사결정 편향을 감지한다. 이는 사용자 스스로도 인식하지 못하는 내면의 갈등을 발견하는 핵심 기능이다.

### 13.6 한국어 특화 자연어 처리

유니코드 받침 감지 기반 조사 자동 교정 시스템은 LLM이 생성한 한국어 텍스트의 문법 오류를 실시간으로 수정한다. 재귀적 심층 적용으로 중첩된 JSON 객체 내의 모든 문자열 필드에 적용된다.

---

## 부록: 파일 구조

```
src/services/ai-analyzer/
├── routes.ts                  # 메인 파이프라인 오케스트레이션
├── personalized-scoring.ts    # 사용자×직업 교차 매칭 엔진
├── vectorize-pipeline.ts      # LLM 검색 쿼리 생성 + 벡터 검색 + ScoredJob 변환
├── tag-filter.ts              # TAG/MiniModule 하드 필터링
├── llm-judge.ts               # LLM Judge (GPT-4o-mini)
├── llm-reporter.ts            # LLM Reporter (심리 분석 리포트)
├── llm-interviewer.ts         # 3라운드 심층 질문 생성
├── mini-module-questions.ts   # 미니모듈 15문항 정의
├── cag-manager.ts             # CAG 상태 관리
├── fact-score-mapping.ts      # Fact → 점수 매핑 규칙
├── qsp-generator.ts           # 질문 선택 프로토콜
├── axis-framework.ts          # 5축 커버리지 프레임워크
├── aggregated-profile.ts      # 프로필 통합/메모리
├── openai-client.ts           # OpenAI API 클라이언트
├── types.ts                   # 타입 정의
└── prompts/                   # 프롬프트 템플릿
```

---

> **문서 끝**
>
> 이 문서는 CareerWiki AI 직업 추천 시스템의 전체 아키텍처를 특허 출원 수준으로 기술한 것입니다.
> 코드베이스의 실제 구현과 1:1 대응되며, 모든 수치와 공식은 실행 코드에서 추출되었습니다.
