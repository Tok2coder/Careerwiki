# AI 추천기 아키텍처 보고서 v2.2

> **작성일**: 2026-01-28  
> **주요 변경**: 미니모듈 8개 질문 추가 (Q8-Q15), 실패반응/버팀앵커/기대반응 포함

---

## 1. 개요

CareerWiki AI 추천기는 사용자의 배경, 선호, 가치관을 분석하여 적합한 직업을 추천하는 시스템입니다.

### 1.1 핵심 설계 원칙

1. **태깅 없는 추천**: 사전 태깅 없이 모든 직업 검색 가능
2. **의미 기반 검색**: OpenAI Embedding으로 한국어 직접 처리
3. **LLM 기반 평가**: 직업 적합도를 LLM이 직접 판단
4. **누적 데이터 활용**: 사용자 답변이 쌓일수록 정확도 향상

### 1.2 기술 스택

| 구성요소 | 기술 | 용도 |
|---------|------|------|
| **임베딩** | OpenAI `text-embedding-3-small` | 직업/사용자 프로필 벡터화 |
| **벡터 DB** | Cloudflare Vectorize | 유사 직업 검색 |
| **LLM (주)** | OpenAI `gpt-4o-mini` | 질문 생성, 메모리 업데이트, 리포트 |
| **LLM (Judge)** | Cloudflare Llama-3.1-8b | 직업 적합도 평가 |
| **데이터베이스** | Cloudflare D1 | 직업 정보, 사용자 데이터 저장 |

---

## 2. 추천 파이프라인

```
┌─────────────────────────────────────────────────────────────┐
│                    사용자 입력 단계                           │
├─────────────────────────────────────────────────────────────┤
│  Step 1: 기본 프로필                                         │
│    - 역할 (직장인/학생/구직자/경영자)                          │
│    - 경력 단계                                               │
│    - 전환 상태                                               │
│                                                             │
│  Step 1.5: 미니모듈 (판단 앵커) - 총 9개 모듈                  │
│    - Q1-Q4: 기본 모듈                                        │
│      - 흥미 (interest_top)                                  │
│      - 가치 (value_top)                                     │
│      - 강점 (strength_top)                                  │
│      - 제약 (constraint_flags)                              │
│    - Q8-Q12: 심층 분기 모듈 (2026-01-28 추가)                 │
│      - 포기 가능성 (sacrifice_flags) - 최대 2개              │
│      - 에너지 소모원 (energy_drain_flags) - 최대 2개         │
│      - 성취 피드백 (achievement_feedback_top) - 최대 2개     │
│      - 실행 속도 (execution_style) - 단일 선택               │
│      - 영향 범위 (impact_scope) - 단일 선택                  │
│                                                             │
│  Step 2: 범용 질문                                           │
│    - 중요한 것, 원하는 것, 싫은 것, 잘하는 것 등               │
│                                                             │
│  Step 3: 상태 신호 (선택적)                                   │
│    - 전환 의도, 타임라인, 희망 산업 등                         │
│                                                             │
│  Step 4: 서술형 질문                                         │
│    - 삶 이야기, 가장 살아있던 순간 등                          │
│                                                             │
│  Step 5+: 심층 라운드 (3라운드)                               │
│    - LLM이 생성한 개인화 질문                                 │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    후보군 확장 (Vectorize)                    │
├─────────────────────────────────────────────────────────────┤
│  1. SearchProfile 생성                                       │
│     - 미니모듈 결과 + 서술형 답변 + 범용 답변 통합             │
│                                                             │
│  2. OpenAI Embedding 생성                                   │
│     - 한국어 직접 처리 (영어 변환 불필요)                      │
│     - text-embedding-3-small (1536차원)                     │
│                                                             │
│  3. Vectorize 검색                                          │
│     - 코사인 유사도 기반 500개 후보 검색                       │
│     - 태깅 여부 무관 - 모든 직업 검색 가능                     │
│                                                             │
│  4. Hard Constraint 필터링 (선택적)                          │
│     - 야근 많은 직업 제외 등                                  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    LLM Judge (적합도 평가)                    │
├─────────────────────────────────────────────────────────────┤
│  입력:                                                       │
│    - 후보 직업 목록 (이름, 설명)                              │
│    - 사용자 프로필 (미니모듈 결과 + 답변 요약)                 │
│                                                             │
│  처리 (Llama-3.1-8b):                                       │
│    - Fit Score: 사용자 강점 ↔ 직업 요구사항 매칭              │
│    - Desire Score: 사용자 흥미/가치 ↔ 직업 보상 매칭          │
│    - Feasibility Score: 사용자 제약 ↔ 직업 조건 매칭         │
│    - Risk Penalty: 가치 충돌, 구조적 미스매치 감지            │
│                                                             │
│  출력:                                                       │
│    - Overall Score (종합 점수)                               │
│    - Evidence Quotes (근거 인용)                             │
│    - Rationale (판단 근거)                                   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    리포트 생성 (GPT-4o-mini)                  │
├─────────────────────────────────────────────────────────────┤
│  Executive Summary (핵심 요약)                               │
│    - 판단 구조 한 줄 요약                                     │
│    - 현재 커리어 단계 진단                                    │
│                                                             │
│  Work Style Map (업무 스타일)                                │
│    - 협업 vs 독립                                            │
│    - 분석 vs 창의                                            │
│    - 안정 vs 도전                                            │
│                                                             │
│  Inner Conflict Analysis (내면 갈등)                         │
│    - 가치 충돌 패턴                                          │
│    - 미해결 포인트                                           │
│                                                             │
│  Job Recommendations (직업 추천)                             │
│    - Top 5 종합 추천                                         │
│    - Fit Top 10 (잘할 것 같은)                               │
│    - Desire Top 10 (좋아할 것 같은)                          │
│                                                             │
│  Expert Guidance (전문가 조언)                               │
│    - 지금 하면 좋은 것 / 하지 말아야 할 것                    │
│    - 실험해볼 것                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 3. 데이터 흐름

### 3.1 직업 검색 흐름 (태깅 없음)

```
사용자 답변
    │
    ▼
SearchProfile 생성
(미니모듈 + 서술형 + 범용 답변 통합)
    │
    ▼
🆕 decision_summary 생성 (한 줄 메타 요약)
예: "Exploration-ready but low tolerance for 
     social pressure and unpredictability"
    │
    ▼
searchProfileToQuery() ─────────────────────────────┐
(한국어 검색 쿼리 생성)                              │
    │                                               │
    ▼                                               │
OpenAI Embedding API ◄──────────────────────────────┤
(text-embedding-3-small)                            │
    │                                               │
    ▼                                               │
1536차원 벡터                                        │
    │                                               │
    ▼                                               │
Cloudflare Vectorize                                │
(코사인 유사도 검색)                                 │
    │                                               │
    ▼                                               │
상위 500개 직업 후보                                 │
(벡터 유사도 순)                                     │
    │                                               │
    ▼                                               │
[선택적] Hard Constraint 필터 ◄─────────────────────┘
    │
    ▼
LLM Judge로 전달
```

### 3.2 폴백 흐름 (Vectorize 불가 시)

```
Vectorize 사용 불가
    │
    ▼
D1 Database 직접 조회
    │
    ▼
SELECT * FROM job_attributes
ORDER BY RANDOM()
LIMIT 500
    │
    ▼
(태깅 여부 무관, NULL 값은 기본값 50 적용)
    │
    ▼
LLM Judge로 전달
```

---

## 4. 컴포넌트 상세

### 4.1 벡터 검색 (`vectorize-pipeline.ts`)

**역할**: 사용자 프로필과 유사한 직업 후보군 확보

**주요 함수**:
- `expandCandidates()`: 기본 후보군 확장
- `expandCandidatesV3()`: SearchProfile 기반 확장
- `expandCandidatesV3WithCache()`: 캐시 + Pre-Filter 지원

**변경 사항 (2026-01-26)**:
- `minTaggedJobs` 옵션 완전 제거
- `tagger_version` 조건 제거
- 모든 직업 검색 가능

```typescript
// 변경 전
const { targetSize = 500, minTaggedJobs = 80 } = options
// ...
WHERE ja.tagger_version = 'tagger-v1.0.0'

// 변경 후
const { targetSize = 500 } = options
// ...
ORDER BY RANDOM()  // 태깅 조건 없음
```

### 4.2 미니모듈 심층 분기 (2026-01-28 추가)

**⚠️ 중요: Bias 가중치 계층**

미니모듈 질문은 **Hard Bias**와 **Soft Bias**로 구분됩니다:

```
┌─────────────────────────────────────────────────────────────┐
│                     🔴 Hard Bias (우선 적용)                  │
├─────────────────────────────────────────────────────────────┤
│  Q8. 포기 가능성 (sacrifice_flags)                           │
│  Q9. 에너지 소모원 (energy_drain_flags)                       │
│                                                             │
│  → 이 두 축이 직업 요구사항과 강하게 충돌하면                   │
│    interest/value 매칭보다 높은 페널티 적용                    │
│                                                             │
│  Judge 프롬프트 지침:                                         │
│  "If sacrifice_flags or energy_drain_flags conflict         │
│   strongly, apply higher penalty than interest/value        │
│   mismatch."                                                │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                 🟠 Hard Bias급 보정자 (준우선)                │
├─────────────────────────────────────────────────────────────┤
│  Q13. 실패 반응 (failure_response)                           │
│  Q14. 버팀 앵커 (persistence_anchor)                         │
│                                                             │
│  → Hard Bias는 아니지만 Q9와 결합 시 버틸 수 있는 직업 예측    │
│  → Desire ↔ Feasibility 갈등 해소에 결정적                   │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                     🟡 Soft Bias (보조 적용)                  │
├─────────────────────────────────────────────────────────────┤
│  Q10. 성취 피드백 (achievement_feedback_top)                 │
│  Q11. 실행 속도 (execution_style)                            │
│  Q12. 영향 범위 (impact_scope)                               │
│  Q15. 타인 기대 반응 (external_expectation)                  │
│                                                             │
│  → 추천 품질 향상에 기여하지만 Hard Bias만큼 결정적이지 않음    │
│  → 비슷한 점수의 직업들 사이에서 세부 순위 조정에 사용          │
└─────────────────────────────────────────────────────────────┘
```

**왜 Hard/Soft 구분이 필요한가?**

> Hard Bias 없이는 "좋아할 것 같은데 못 버티는 직업"이 상위에 남을 수 있음.
> 예: 사람 상대가 힘든 사람에게 영업직 추천 (흥미는 맞지만 지속 불가)

---

**🔧 Hard Bias 간 충돌 처리 규칙 (Q8 ↔ Q9)**

Q8과 Q9는 각각 직업 요구/환경과 매칭되지만, **두 Hard Bias 간 내부 충돌**도 발생할 수 있습니다:

```
┌─────────────────────────────────────────────────────────────┐
│              ⚠️ Hard Bias 내부 충돌 예시                      │
├─────────────────────────────────────────────────────────────┤
│  no_sacrifice + unpredictability_drain                      │
│  → "변화 없이 안정 원함" + "예측 불가 상황 싫음"              │
│  → 이 조합은 탐색 범위를 극도로 좁힘                          │
│                                                             │
│  low_initial_income + time_pressure_drain                   │
│  → "초봉 낮아도 OK" + "시간 압박 싫음"                        │
│  → 스타트업 추천하기엔 시간 압박 충돌                         │
│                                                             │
│  willing_to_study + cognitive_drain                         │
│  → "재학습 OK" + "인지 피로 싫음"                             │
│  → 학습 의지는 있지만 지속력 우려                             │
└─────────────────────────────────────────────────────────────┘
```

**충돌 해소 원칙: "버티는 쪽으로 보수 해석"**

```
Judge 프롬프트 지침:
"If multiple Hard Bias flags conflict internally,
 prioritize stability-preserving interpretation."

예:
- low_initial_income + time_pressure_drain 충돌 시
  → "성장은 원하지만 과도한 희생은 원하지 않음"으로 해석
  → 스타트업보다 성장 가능한 중견기업 추천

- willing_to_study + cognitive_drain 충돌 시
  → "배움 의지는 있지만 지속 가능한 페이스 필요"로 해석
  → 단기 집중 학습보다 점진적 성장 경로 추천
```

> ⚠️ 이 규칙 없으면 LLM Judge가 가끔 애매한 타협을 함.

---

**🔴 Hard Bias: Q8-Q9 상세**

| 질문 | 토큰 | 분기 효과 |
|-----|------|----------|
| **Q8. 포기 가능성** | | 전공 vs 직업, 안정 vs 성장, 현실 vs 이상 |
| 📉 초반 연봉 낮아도 OK | `low_initial_income` | 성장형, 이상형 직업 추천 |
| 📚 재학습 OK | `willing_to_study` | 전공 추천, 전환 용이 직업 |
| 🔄 분야 전환 OK | `field_change_ok` | 폭넓은 직업군 탐색 |
| 🧑‍🤝‍🧑 시선 감수 | `ignore_social_pressure` | 비전통적 직업 추천 |
| ⛔ **포기 불가** | `no_sacrifice` | **⚠️ 특별 처리 필요** (아래 참조) |
| **Q9. 에너지 소모원** | | stress_tolerance, people, environment 보강 |
| 😵 사람 상대 | `people_drain` | 독립적, 저상호작용 직업 |
| 🧠 인지 피로 | `cognitive_drain` | 루틴형, 실무형 직업 |
| ⏱️ 시간 압박 | `time_pressure_drain` | 유연한 일정의 직업 |
| 📊 책임 스트레스 | `responsibility_drain` | 서포트 역할, 팀 기여자 |
| 🔁 반복 피로 | `repetition_drain` | 창의적, 다양한 직업 |
| ❓ 불확실성 | `unpredictability_drain` | 체계적, 예측 가능 직업 |

---

**⛔ `no_sacrifice` 특별 처리 (매우 중요)**

`no_sacrifice`는 단순한 옵션이 아닌 **강력한 경고 신호**입니다:

```
사용자가 "아무것도 포기하고 싶지 않다" 선택 시:

1. 추천 동작 변경:
   - 탐색 폭 축소 (기존 직업군 중심)
   - 전환 비용 낮은 직업 우선
   - 현실형/안정형 직업 가중치 증가

2. 리포트 톤 변경:
   - 메타 메시지 삽입: 
     "지금은 '선택'보다 '정리'가 먼저 필요한 상태일 수 있습니다."
   - 새 직업 탐색보다 현재 상황 정리 조언 우선
   - 작은 실험부터 시작 권장

3. Judge 프롬프트 지침:
   "If no_sacrifice is selected, reduce exploration range.
    Prioritize low-transition-cost jobs and add meta-guidance
    about readiness assessment in report."
```

---

**🟡 Soft Bias: Q10-Q12 상세**

| 질문 | 토큰 | 분기 효과 |
|-----|------|----------|
| **Q10. 성취 피드백** | | 직업 만족도 예측 정확도 향상 |
| 🏆 수치 성과 | `metric_feedback` | KPI 기반 직업 |
| 🙌 직접 도움 | `helping_feedback` | 서비스, 케어 직업 |
| 🧩 문제 해결 | `problem_solved_feedback` | 기술, 분석 직업 |
| 🎨 결과물 산출 | `tangible_output_feedback` | 창작, 개발 직업 |
| 📈 성장 실감 | `growth_feedback` | 학습/성장 기회 많은 직업 |
| **Q11. 실행 속도** | | 스타트업/기획/연구 vs 운영/관리/전문직 |
| 🚀 행동 우선 | `action_first` | 스타트업, 기획, 실험적 직업 |
| 🧱 계획 우선 | `plan_first` | 운영, 관리, 전문직 |
| 🔄 상황 적응 | `flexible_execution` | 범용적 추천 |
| **Q12. 영향 범위** | | 의미 지향 직업 추천 정확도 보강 |
| 👤 개인 | `impact_individual` | 1:1 코칭, 상담 직업 |
| 🧑‍🤝‍🧑 팀/조직 | `impact_team` | 팀 리더, 부서 관리 |
| 🏢 회사/산업 | `impact_industry` | B2B, 기업 대상 직업 |
| 🌏 사회 전반 | `impact_society` | 공공, NGO, 사회적 기업 |
| 🤷 미정 | `impact_unsure` | 탐색 모드 유지 |

---

### 4.4 신규 미니모듈 (Q13-Q15) - 2026-01-28 추가

**📊 Hard Bias급 보정자 질문들**

| 질문 | 토큰 | 분기 효과 |
|------|------|----------|
| **Q13. 실패 반응** | | '버틸 수 있는 직업' 결정 핵심 (Hard Bias급) |
| 🔄 다시 구조를 고쳐본다 | `iterate_on_failure` | 체계적 문제 해결, 엔지니어/분석직 적합 |
| 🧪 다른 방식으로 빠르게 바꾼다 | `pivot_on_failure` | 스타트업, 기획, 빠른 실행 환경 적합 |
| ⏸️ 잠시 멈추고 정리한다 | `pause_on_failure` | 숙고형, 연구/전문직 적합 |
| 💥 크게 흔들린다 | `emotionally_affected` | 안정적 환경 필수, 지원직 적합 |

**왜 Q13이 중요한가?**
> 정부 검사에서 스트레스·회복탄력성을 10~20개 문항으로 측정하던 것을 **1문항**으로 압축.
> Q9(에너지 소모)와 결합하면 **Judge 정확도가 크게 상승**함.

| 질문 | 토큰 | 분기 효과 |
|------|------|----------|
| **Q14. 버팀 앵커** | | Desire ↔ Feasibility 갈등 해소 |
| 💰 보상이 명확함 | `reward_anchor` | 성과급 중심 직업 선호 |
| 📈 성장 체감 | `growth_anchor` | 경력 개발 기회 중요 |
| 🤝 함께하는 사람 | `people_anchor` | 팀 문화 결정적, 관계 기반 |
| 🧭 의미/방향성 | `meaning_anchor` | 미션 기반 조직 적합 |
| 🛡️ 안정성 | `stability_anchor` | 고용 안정성 최우선 |

**왜 Q14가 중요한가?**
> 정부 검사에서 가치관 + 직업적응력 + 만족도를 나눠 묻는 것을 **'버팀 앵커' 하나로 통합**.
> "싫은 게 많지만 이건 견딘다"를 명확히 드러냄.

| 질문 | 토큰 | 분기 효과 |
|------|------|----------|
| **Q15. 타인 기대 반응** | | 직업 형태 분기 (전문직/조직/프리랜서/창작직) |
| 🧱 기준이 있으면 편하다 | `external_structure_ok` | 조직, 전문직, 가이드라인 있는 환경 적합 |
| 😐 상관없다 | `neutral_to_expectation` | 유연한 적응력 |
| 😣 부담이 된다 | `expectation_pressure` | 프리랜서, 창작직, 자율 환경 적합 |

**왜 Q15가 중요한가?**
> Q9의 `people_drain`과는 결이 다름 - 이건 **'사회적 평가 구조'에 대한 반응**.
> 전문직 / 조직 / 프리랜서 / 창작직 분기에 매우 유용.

---

**📊 Q13-Q15의 시스템 통합 효과**

```
┌─────────────────────────────────────────────────────────────┐
│                   Q13 + Q9 시너지 효과                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Q9: 에너지 소모원 (무엇이 힘든가?)                          │
│  Q13: 실패 반응 (힘들 때 어떻게 대처하는가?)                  │
│                                                             │
│  → 조합하면 "이 직업에서 버틸 수 있는가?" 예측 정확도 ↑↑      │
│                                                             │
│  예시:                                                       │
│  ├─ people_drain + emotionally_affected                     │
│  │  → 대인 업무 + 민감한 반응 = 서비스직 강력 비추천          │
│  │                                                          │
│  ├─ time_pressure_drain + iterate_on_failure                │
│  │  → 시간 압박 싫음 + 체계적 해결 = 컨설팅보단 연구직        │
│  │                                                          │
│  └─ unpredictability_drain + pivot_on_failure               │
│     → 예측불가 싫음 + 빠른 전환 = 모순, 신중한 탐색 필요      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

```
┌─────────────────────────────────────────────────────────────┐
│                   Q14의 핵심 역할                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Desire Score: 이 직업을 얼마나 원하는가? (흥미, 가치)        │
│  Feasibility Score: 이 직업이 현실적인가? (제약, 환경)       │
│                                                             │
│  → 둘이 충돌할 때 Q14가 중재자 역할:                         │
│    "이것만 충족되면 힘들어도 버틴다"                          │
│                                                             │
│  예시:                                                       │
│  ├─ Desire↓ + Feasibility↑ + reward_anchor                  │
│  │  → "딱히 좋진 않지만 돈 되면 OK" → 추천 유지              │
│  │                                                          │
│  └─ Desire↑ + Feasibility↓ + meaning_anchor                 │
│     → "힘들어도 의미 있으면 버팀" → 추천 유지 (경고 표시)     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

**🔧 Hard Bias → Hard Constraint 자동 연결 (권장 구현)**

현재 구조에서:
- **Hard Bias** = "사람 기준" (Q8, Q9의 사용자 응답)
- **Hard Constraint** = "직업 조건 기준" (야근 많은 직업 제외 등)

이 둘이 논리적으로 연결되어야 완전해집니다:

```
┌─────────────────────────────────────────────────────────────┐
│          Hard Bias → Hard Constraint 자동 제안               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Q9 energy_drain_flags        →    Hard Constraint 제안     │
│  ─────────────────────────────────────────────────────────  │
│  people_drain                 →    대면비중 높은 직업 soft   │
│                                    exclude (서비스업, 영업)  │
│                                                             │
│  time_pressure_drain          →    상시 야근 직업 penalty   │
│                                    (스타트업, 컨설팅)        │
│                                                             │
│  unpredictability_drain       →    불규칙 근무 직업 제외    │
│                                    (프리랜서, 이벤트)        │
│                                                             │
│  responsibility_drain         →    관리직/리더십 역할       │
│                                    가중치 감소              │
│                                                             │
└─────────────────────────────────────────────────────────────┘

구현 예시:
function applyHardBiasToConstraint(energyDrain: string[]): FilterOptions {
  const filters: FilterOptions = {}
  
  if (energyDrain.includes('people_drain')) {
    filters.maxPeopleInteraction = 40  // 0-100 스케일
  }
  if (energyDrain.includes('time_pressure_drain')) {
    filters.maxOvertimeScore = 30
  }
  // ...
  return filters
}
```

> 핵심: "사람이 싫다"고 말했으면, 시스템이 직업 조건에서도 그걸 반영해야 함.

### 4.3 LLM Interviewer (`llm-interviewer.ts`)

**역할**: 심층 질문 생성

**사용 모델**: OpenAI GPT-4o-mini (주), Llama-3.1-8b (폴백)

**입력**:
- 미니모듈 결과 (기본 4개 + 심층 5개)
- 누적 메모리 (stable_drivers, contradictions, open_loops)
- 이전 라운드 답변

**출력**:
- 3-5개의 개인화 질문
- 각 질문의 의도 (intent), 추출 대상 (what_to_extract)

### 4.4 LLM Judge (`llm-judge.ts`)

**역할**: 직업 적합도 평가

**사용 모델**: Cloudflare Llama-3.1-8b

**입력**:
- 후보 직업 목록 (최대 120개, 20개씩 배치)
- 사용자 프로필 (SearchProfile)
- 서술형 답변 (NarrativeFacts)
- 🆕 `decision_summary` (한 줄 메타 요약)

---

**🔧 SearchProfile의 `decision_summary` 필드 (권장 추가)**

현재 SearchProfile은 정보 묶음입니다. 여기에 **한 줄 메타 요약**을 추가하면 Judge 품질이 크게 향상됩니다:

```typescript
interface SearchProfile {
  // 기존 필드들...
  miniModule: MiniModuleResult
  narrativeAnswers: string[]
  
  // 🆕 추가 필드
  decision_summary: string  // 한 줄 메타 요약
}

// 생성 예시
decision_summary: "Exploration-ready but low tolerance for social pressure and unpredictability"
decision_summary: "Career changer seeking stability with gradual growth path"
decision_summary: "High achiever but conflicts between autonomy and income goals"
```

**효과:**
- LLM Judge의 점수 일관성 ↑
- rationale 품질 ↑
- batch 평가 흔들림 ↓ (20개씩 배치 처리할 때 맥락 유지)

**생성 방법:**
```typescript
// GPT-4o-mini로 decision_summary 생성
const summary = await generateDecisionSummary({
  sacrifice: miniModule.sacrifice_flags,
  energyDrain: miniModule.energy_drain_flags,
  values: miniModule.value_top,
  conflicts: miniModule.internal_conflict_flags,
})
```

---

**출력**:
- `fitScore`: 잘할 것 같은 정도 (0-100)
- `desireScore`: 좋아할 것 같은 정도 (0-100)
- `feasibilityScore`: 현실적 가능성 (0-100)
- `overallScore`: 종합 점수
- `riskPenalty`: 위험 요소 감점
- `evidenceQuotes`: 근거 인용
- `rationale`: 판단 근거 설명

### 4.5 LLM Reporter (`llm-reporter.ts`)

**역할**: 최종 프리미엄 리포트 생성

**사용 모델**: OpenAI GPT-4o-mini

**입력**:
- Judge 결과 (직업 추천 목록)
- 사용자 컨텍스트 (미니모듈 + 답변 요약)

**출력**:
- `PremiumReportV3` 구조체
  - Executive Summary
  - Work Style Map
  - Inner Conflict Analysis
  - Job Recommendations (Top 5, Fit 10, Desire 10)
  - Expert Guidance

### 4.6 LLM Memory (`llm-memory.ts`)

**역할**: 누적 메모리 업데이트

**사용 모델**: OpenAI GPT-4o-mini

**저장 항목**:
- `stable_drivers`: 반복 등장 동기/욕구
- `recurring_fears`: 반복 등장 두려움
- `decision_rules`: 선택 기준 (If-Then)
- `contradictions`: 가치/욕구 충돌
- `open_loops`: 미해결 질문
- `emotional_triggers`: 감정 반응 지점

---

## 5. AI 모델 사용 현황

### 5.1 전체 모델 맵

```
┌─────────────────────────────────────────────────────────────┐
│                     OpenAI 사용 (4개)                        │
├─────────────────────────────────────────────────────────────┤
│  ✅ text-embedding-3-small (Embedding)                      │
│     - 직업 벡터화 (1,682개 인덱싱 완료)                       │
│     - 사용자 쿼리 벡터화                                     │
│                                                             │
│  ✅ gpt-4o-mini (LLM)                                       │
│     - llm-interviewer.ts: 심층 질문 생성                     │
│     - llm-memory.ts: 누적 메모리 업데이트                    │
│     - llm-reporter.ts: 프리미엄 리포트 생성                  │
│     - llm-followup.ts: 후속 질문 강화                        │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                  Cloudflare AI 사용 (2개)                    │
├─────────────────────────────────────────────────────────────┤
│  ⚠️ Llama-3.1-8b-instruct (LLM)                             │
│     - llm-judge.ts: 직업 적합도 평가                         │
│     - resume-parser.ts: 이력서 파싱                          │
│     - llm-interviewer.ts: OpenAI 실패 시 폴백                │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                   Google AI 사용 (1개)                       │
├─────────────────────────────────────────────────────────────┤
│  ⚠️ Gemini-1.5-flash (LLM)                                  │
│     - tagger-batch.ts: 직업 속성 추출 (현재 미사용)           │
└─────────────────────────────────────────────────────────────┘
```

### 5.2 비용 구조 (예상)

| 컴포넌트 | 호출 횟수/분석 | 예상 토큰 | 비용 (GPT-4o-mini) |
|---------|---------------|----------|-------------------|
| Embedding | 1회 | ~500 | $0.00001 |
| Interviewer | 3회 | ~3000 | $0.00045 |
| Memory | 3회 | ~2000 | $0.00030 |
| Reporter | 6회 병렬 | ~5000 | $0.00075 |
| Followup | 3회 | ~600 | $0.00009 |
| **총합** | | | **~$0.0016/분석** |

---

## 6. 태깅 제거의 영향

### 6.1 변경 전 (태깅 의존)

```
문제점:
- 태깅된 직업만 검색 가능 (1,682개 / 전체의 26%)
- 새 직업 추가 시 반드시 태깅 필요 (수동 작업 또는 Gemini 호출)
- 태깅 데이터 품질에 추천 결과 의존

쿼리 예시:
WHERE ja.tagger_version = 'tagger-v1.0.0'
```

### 6.2 변경 후 (태깅 무관)

```
개선점:
- 모든 직업 검색 가능 (벡터 인덱스에 있는 모든 직업)
- 새 직업 추가 시 Vectorize 인덱싱만 필요 (자동화 가능)
- LLM Judge가 직업 설명을 직접 읽고 판단

쿼리 예시:
ORDER BY RANDOM()  -- 태깅 조건 없음
COALESCE(ja.wlb, 50)  -- NULL 값은 기본값 사용
```

### 6.3 새 직업 추가 프로세스

```
[태깅 제거 전]
1. jobs 테이블에 직업 추가
2. job_attributes에 태깅 데이터 추가 (Gemini 호출)
3. Vectorize에 임베딩 추가

[태깅 제거 후]
1. jobs 테이블에 직업 추가
2. job_attributes에 기본 행 추가 (빈 값 OK)
3. Vectorize에 임베딩 추가 (직업명+설명)

→ 태깅 작업 불필요, 자동화 가능
```

### 6.4 코드 정리 내역 (2026-01-26)

| 작업 | 파일 | 내용 |
|-----|------|------|
| **삭제** | `tagger-routes.ts` | 태깅 배치 실행 API 전체 |
| **삭제** | `tagger-batch.ts` | Gemini 호출 태깅 로직 전체 |
| **삭제** | `qa-report.ts` | 태깅 QA 리포트 생성 로직 |
| **수정** | `routes.ts` | `taggerRoutes` import 및 마운트 제거 |
| **수정** | `vectorize-pipeline.ts` | `minTaggedJobs`, `tagger_version` 조건 제거 |
| **유지** | `admin-api.ts` | 레거시 통계 조회용 (어드민 페이지) |
| **유지** | `job-attributes-types.ts` | `TAGGER_VERSION` 상수 (어드민 표시용) |

### 6.5 미니모듈 확장 (2026-01-28)

| 작업 | 파일 | 내용 |
|-----|------|------|
| **추가** | `mini-module-questions.ts` | Q8-Q12 심층 분기 질문 모듈 5개 추가 |

**MiniModuleResult 타입 확장:**

```typescript
interface MiniModuleResult {
  // 기존 필드
  interest_top: string[]
  value_top: string[]
  strength_top: string[]
  constraint_flags: string[]
  
  // 신규 필드 (2026-01-28)
  sacrifice_flags?: string[]           // Q8. 포기 가능성
  energy_drain_flags?: string[]        // Q9. 에너지 소모원
  achievement_feedback_top?: string[]  // Q10. 성취 피드백
  execution_style?: string             // Q11. 실행 속도
  impact_scope?: string                // Q12. 영향 범위
  failure_response?: string            // Q13. 실패 반응 (Hard Bias급)
  persistence_anchor?: string          // Q14. 버팀 앵커
  external_expectation?: string        // Q15. 타인 기대 반응
}
```

**분기 효과 요약:**
- Q8 → 전공 vs 직업, 안정 vs 성장, 현실 vs 이상 분기
- Q9 → 스트레스 내성, 대인관계 선호, 환경 선호 보강
- Q10 → 직업 만족도 예측 정확도 향상
- Q11 → 스타트업/기획 vs 운영/관리/전문직 분기
- Q12 → 의미 지향 직업 추천 정확도 보강
- **Q13 → '버틸 수 있는 직업' 예측 (Q9와 시너지)**
- **Q14 → Desire ↔ Feasibility 갈등 해소**
- **Q15 → 전문직/조직/프리랜서/창작직 분기**

---

## 7. 향후 개선 방향

### 7.1 단기 (1-2주)

- [ ] `llm-judge.ts`도 GPT-4o-mini로 전환 (비용 증가 주의)
- [ ] 새 직업 추가 시 자동 Vectorize 인덱싱 API 구현
- [ ] 벡터 검색 품질 모니터링 대시보드
- [x] ✅ **Hard Bias 프롬프트 적용**: Q8/Q9 충돌 시 높은 페널티 로직 구현 (2026-01-28 완료)
- [ ] **`no_sacrifice` 특별 처리**: 리포트 톤 분기 구현 (리포터에 적용 필요)
- [x] ✅ **Hard Bias 내부 충돌 규칙**: Q8↔Q9 충돌 시 "버티는 쪽 보수 해석" 로직 (2026-01-28 완료)
- [x] ✅ **`decision_summary` 필드**: SearchProfile에 한 줄 메타 요약 추가 (2026-01-28 완료)
- [x] ✅ **Hard Bias → Hard Constraint 연결**: Q9 응답 기반 직업 조건 자동 필터 (2026-01-28 완료)

### 7.2 중기 (1-2개월)

- [ ] 사용자 피드백 기반 추천 품질 개선
- [ ] A/B 테스트 프레임워크 구축
- [ ] 멀티모달 입력 지원 (이미지, 파일)
- [ ] **Step 2 범용 질문 중복 제거** (아래 7.4 참조)

### 7.3 장기

- [ ] 개인화 모델 파인튜닝 (사용자 데이터 활용)
- [ ] 실시간 직업 시장 데이터 연동
- [ ] 커리어 경로 시뮬레이션

### 7.4 ⚠️ Step 2 범용 질문 중복 개선 (권장)

**문제점:**

Step 2 범용 질문(가치, 잘하는 것, 싫은 것 등)이 Q8-Q10에서 이미 부분 추론 가능:

```
Step 2 질문          →  Q8-Q10에서 추론 가능한 부분
─────────────────────────────────────────────────────
"뭐가 중요해요?"      →  Q8 포기 가능성에서 우선순위 파악
"뭘 잘해요?"         →  Q10 성취 피드백에서 강점 추론
"뭐가 싫어요?"       →  Q9 에너지 소모원에서 회피 요소 추론
```

**개선 방안:**

1. **질문 수 축소**:
   - Step 2 질문을 6개 → 3개로 축소
   - Q8-Q10으로 커버되지 않는 질문만 유지

2. **LLM 동적 스킵**:
   - LLM이 미니모듈 결과 확인 후 "이미 아는 건 스킵"
   - 프롬프트: `"Based on mini-module results, skip questions where answer is already implied."`

3. **조건부 질문 로직**:
   ```typescript
   // 예시: Q9에서 people_drain 선택 시 "대인관계" 관련 Step 2 질문 스킵
   if (miniModule.energy_drain_flags?.includes('people_drain')) {
     skipQuestion('step2_people_preference')
   }
   ```

**기대 효과:**
- 사용자 응답 시간 단축 (2-3분 절약)
- 중복 질문으로 인한 피로감 감소
- LLM 토큰 사용량 절감

---

## 8. 참고: 파일 구조

### 8.1 현재 사용 중인 파일

```
src/services/ai-analyzer/
├── openai-client.ts         # OpenAI API 클라이언트 (Chat + Embedding)
├── vectorize-pipeline.ts    # Vectorize 검색 파이프라인 (태깅 무관)
├── routes.ts                # API 라우트 (분석 엔드포인트)
├── llm-interviewer.ts       # 심층 질문 생성 (GPT-4o-mini)
├── llm-judge.ts             # 직업 적합도 평가 (Llama)
├── llm-reporter.ts          # 리포트 생성 (GPT-4o-mini)
├── llm-memory.ts            # 누적 메모리 (GPT-4o-mini)
├── llm-followup.ts          # 후속 질문 (GPT-4o-mini)
├── mini-module-questions.ts # 미니모듈 질문/토큰 정의
├── tag-filter.ts            # Hard Constraint 필터링
├── types.ts                 # 타입 정의
├── admin-api.ts             # 어드민 API (레거시 태깅 통계 조회용)
├── job-attributes-types.ts  # 직업 속성 타입 정의 (TAGGER_VERSION 상수 포함)
└── insert-stub-data.ts      # 스텁 데이터 생성 (테스트용)
```

### 8.2 삭제된 파일 (2026-01-26 태깅 코드 정리)

```
[삭제됨] tagger-routes.ts    # 태깅 배치 실행 API - 더 이상 필요 없음
[삭제됨] tagger-batch.ts     # Gemini 기반 태깅 로직 - 더 이상 필요 없음
[삭제됨] qa-report.ts        # 태깅 QA 리포트 생성 - 더 이상 필요 없음
```

### 8.3 유지된 레거시 항목

- `TAGGER_VERSION` 상수 (`job-attributes-types.ts`)
  - 어드민 대시보드에서 버전 표시용으로 유지
  - DB에 기존 태깅 데이터 남아있어 참조용 필요

- `tagger_runs` / `tagger_errors` 테이블
  - 기존 태깅 이력 조회용으로 유지
  - 새 태깅 작업은 발생하지 않음

---

## 9. 결론

### v2.0 (2026-01-26)
AI 추천기는 **태깅 없이도 모든 직업을 검색하고 추천**할 수 있게 되었습니다.

핵심 변경:
1. **OpenAI Embedding**으로 한국어 직접 처리
2. **tagger_version 조건 제거**로 전체 직업 검색
3. **LLM Judge**가 직업 설명을 직접 읽고 적합도 판단

### v2.1 (2026-01-28)
미니모듈에 **5개 심층 분기 질문**(Q8-Q12)을 추가하여 추천 정확도를 향상시켰습니다.

핵심 추가:
1. **Q8. 포기 가능성** → 안정 vs 성장, 현실 vs 이상 분기
2. **Q9. 에너지 소모원** → 스트레스 내성, 대인관계 선호 보강
3. **Q10. 성취 피드백** → 직업 만족도 예측 정확도 향상
4. **Q11. 실행 속도** → 스타트업 vs 전문직 분기
5. **Q12. 영향 범위** → 의미 지향 직업 추천 정확도 보강
6. **Q13. 실패 반응** → '버틸 수 있는 직업' 예측 (Q9와 시너지, Hard Bias급)
7. **Q14. 버팀 앵커** → Desire ↔ Feasibility 갈등 해소
8. **Q15. 타인 기대 반응** → 전문직/조직/프리랜서/창작직 분기

**중요 설계 원칙:**
- 🔴 **Hard Bias**: Q8(포기), Q9(에너지)는 interest/value보다 우선 적용
  - "좋아할 것 같은데 못 버티는 직업" 상위 노출 방지
- 🟠 **Hard Bias급 보정자**: Q13(실패 반응), Q14(버팀 앵커)
  - Q9와 결합해 "버틸 수 있는 직업" 예측 정확도 ↑
  - Desire ↔ Feasibility 갈등 중재
- ⛔ **`no_sacrifice` 특별 처리**: 탐색 폭 축소 + 리포트 톤 변경
  - "지금은 '선택'보다 '정리'가 먼저 필요한 상태" 메타 메시지
- 🟡 **Soft Bias**: Q10-Q12, Q15는 세부 순위 조정에 활용

**구현 완료:**
1. ✅ **Hard Bias 내부 충돌 규칙**: Q8↔Q9 충돌 시 "버티는 쪽 보수 해석" (2026-01-28)
2. ✅ **Hard Bias → Hard Constraint 연결**: `people_drain` → 대면직 soft exclude 등 (2026-01-28)
3. ✅ **`decision_summary` 필드**: SearchProfile에 한 줄 메타 요약 추가로 Judge 품질 ↑ (2026-01-28)
4. ✅ **Q13-Q15 추가**: 실패 반응, 버팀 앵커, 타인 기대 반응 질문 (2026-01-28)

**향후 개선:**
- Step 2 범용 질문 중복 제거 (Q8-Q10으로 추론 가능한 부분 스킵)
- LLM이 "이미 아는 건 스킵"하도록 동적 질문 로직 구현

이 15개의 미니모듈 질문은 사용자의 핵심 성향을 빠르게 파악하여 LLM Judge가 더 정확한 적합도 평가를 할 수 있게 합니다.
