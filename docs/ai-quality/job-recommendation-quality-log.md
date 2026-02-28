# AI 직업 추천 품질 개선 이력

> 마지막 업데이트: 2026-02-28
> 목적: 직업 추천 엔진의 모든 변경사항을 기록하여, 향후 전공 추천 개선 시 참고 자료로 활용

---

## 아키텍처 요약

### 추천 파이프라인 흐름

```
사용자 입력 (MiniModule 5축 + 내러티브 3개)
    ↓
LLM 인터뷰 (3라운드: ENGINE→AVOIDANCE→INTEGRATION)
    ↓
Multi-Query 벡터 검색 (600-800개 후보)
    ↓
TAG 필터 (Hard Exclusion 규칙 16개)
    ↓
Personalized Scoring (토큰→속성 매핑)
    ↓
Pre-filter (~50개로 축소)
    ↓
LLM Judge (GPT-4o-mini, 다차원 평가)
    ↓
Diversity Guard (동일 분류 쏠림 방지)
    ↓
Top 10 추천 결과
```

### 점수 공식

```
Fit = 0.45 × Like + 0.35 × Can + 0.20 × Feasibility - RiskPenalty(cap 8)
```

- **Like (욕구 부합)**: 관심사·가치관·워크스타일 ↔ 직업 속성 매칭
- **Can (역량 부합)**: 강점·배경·경험 ↔ 직업 요구역량 매칭
- **Feasibility (현실성)**: LLM이 판단하는 진입 난이도 + 유저 배경 고려
- **RiskPenalty**: 제약·회피 조건 위반 시 감점 (최대 8점)

### 핵심 파일 구조

| 파일 | 역할 |
|------|------|
| `routes.ts` | API 엔드포인트 (analyze, round-questions, round-answers, recommend) |
| `vectorize-pipeline.ts` | Multi-Query 벡터 검색 |
| `tag-filter.ts` | Hard Exclusion 규칙 (16개) |
| `personalized-scoring.ts` | 토큰→속성 매핑 + Like/Can 점수 계산 |
| `llm-judge.ts` | GPT-4o-mini 기반 다차원 평가 |
| `safe-replacement.ts` | 니치 도메인 필터 + 대체 후보 생성 |
| `auto-tagger.ts` | 직업 속성 자동 태깅 (35개 컬럼) |
| `llm-interviewer.ts` | 3라운드 인터뷰 질문 생성 |
| `llm-reporter.ts` | 프리미엄 리포트 생성 |

---

## 변경 이력

### [2026-02-27] Phase 2-1: Auto-Tagger 카테고리 필드 개선

- **파일**: `src/services/ai-analyzer/auto-tagger.ts`
- **문제**: `cleanTagResult()`의 기본값이 `knowledge/office/permanent/medium`으로 폴백 → 카테고리 필드 88-99%가 기본값
- **변경**: `TAGGING_SYSTEM_PROMPT`에 카테고리 필드 결정 규칙 섹션 추가
  - `job_type`: 직업명·업무 기반 판단 기준 (반장→manufacturing, 디자이너→creative 등)
  - `work_environment`: 현장/공장/야외 키워드 → office 아님
  - `physical_demand`: 반장/정비/조립/운전 → medium 이상
  - `employment_type`: 프리랜서/배우/작가 → permanent 아님
  - 10개 앵커 예시 (소방관, 배우, 열처리반장, 데이터분석가, 웹개발자, 간호사, 건설현장감독, 프리랜서디자이너, 택배기사, 회계사)
- **근거**: Phase A 감사에서 카테고리 편향 발견 (job_type 88.6% knowledge, work_environment ~95% office)
- **전공 추천 적용 시**: 전공의 `major_attributes` 테이블도 유사 카테고리 필드 존재. 동일 앵커링 기법 적용 가능. `auto-tagger-major.ts`에도 동일 패턴 추가 권장.

### [2026-02-27] Phase 2-2: Safe-Replacement 반장/현장직 필터

- **파일**: `src/services/ai-analyzer/safe-replacement.ts`
- **문제**: 안정형 유저(S2)에게 "전송설비유지보수반장", "열처리반장" 등 제조현장 반장직 추천됨
- **변경**: `NICHE_DOMAINS` 배열에 제조현장 감독/반장 도메인 추가
  ```typescript
  {
    patterns: ['반장', '현장감독', '작업반장', '조장', '유지보수반장'],
    exemptBackgrounds: ['license_cert', 'field_experience'],
    exemptInterests: ['physical_activity'],
  }
  ```
- **효과**: 반장 패턴 포함 직업이 사무직 지향 유저에게 필터링됨 (면허/현장경험 보유자 제외)
- **전공 추천 적용 시**: 전공에는 직접 해당 없지만, 니치 도메인 필터 패턴 자체는 재사용 가능

### [2026-02-27] Phase 2-3: Tag-Filter 안정+사무 vs 현장직 제외 규칙

- **파일**: `src/services/ai-analyzer/tag-filter.ts`
- **문제**: stability + structured/team_harmony 선호 유저에게 현장/제조직이 올라옴
- **변경**: `MINI_MODULE_EXCLUSION_RULES`에 규칙 #16 추가
  ```
  Rule ID: stability_office_vs_field_manufacturing
  조건: value_top에 stability 포함 + workstyle_top에 structured 또는 team_harmony 포함
  제외: work_environment가 field/factory/workshop/outdoor이거나,
        job_type이 manufacturing/manual_skilled/field_work/crafts이거나,
        job_name에 반장/공장/현장/제조 등 패턴 매칭
  ```
- **주의**: job_type 88.6%가 'knowledge' 기본값이므로 `isFieldByType` 체크는 재태깅 전에는 효과 제한적. `isFieldByName` 정규식이 즉시 효과를 발휘.
- **전공 추천 적용 시**: 안정 지향 유저에게 불안정한 전공 (예: 순수예술, 프리랜서 성향) 제외하는 유사 규칙 고려 가능

### [2026-02-27] Phase 2-4: Flat-50 노이즈 데이터 재태깅

- **파일**: `src/services/ai-analyzer/admin-api.ts` (새 엔드포인트)
- **문제**: 1,339건(18.3%)의 직업이 주요 4개 속성(analytical, creative, execution, people_facing) 전부 50 → 추천 차별화 불가
- **변경**: `/admin/api/ai/retag-flat50` 엔드포인트 추가. 기존 flat-50 속성 삭제 후 개선된 프롬프트로 재태깅.
- **전공 추천 적용 시**: 전공 데이터에도 flat-50 문제 존재할 수 있음. 동일 패턴으로 진단 + 재태깅 가능.

### [2026-02-27] P0-1: 토큰 매핑 RIASEC 기반 재설계

- **파일**: `src/services/ai-analyzer/personalized-scoring.ts`
- **변경**:
  - `autonomy` → Artistic(A) + Investigative(I) 특성 반영, creative/analytical 매핑 강화
  - `meaning` → Social(S) 특성 반영, people_facing 매핑 추가
  - `recognition` → Enterprising(E) 특성 반영, execution/leadership 가중치
  - `persistence` → Conventional(C) 특성 반영, stability/structured 매핑
  - `fast_learning` → Investigative(I) 특성, analytical 가중치 상승
  - 신규 토큰 3개: `leadership`, `nature`, `physical_activity`
- **근거**: Holland RIASEC 6유형과 CareerWiki 토큰 간 학술 근거 기반 대응
- **효과**: 평균 품질 6.2 → 6.5/10 (단독 효과)
- **전공 추천 적용 시**: 전공의 속성도 동일 구조(analytical, creative, execution, people_facing)이므로 매핑 로직 직접 재사용 가능. RIASEC 근거 동일하게 적용.

### [2026-02-27] P0-2: 신입/무경력자 Feasibility 앵커

- **파일**: `src/services/ai-analyzer/llm-judge.ts`
- **변경**:
  - `buildUserContext()`에 "배경 정보 없음" 블록 추가 (background_flags 비어있을 때)
  - 시스템 프롬프트에 경험별 Feasibility 점수 가이드:
    - 관련 경력 5년+ → 85-95
    - 관련 경력 1-4년 → 70-85
    - 전공/자격증만 → 55-70
    - 배경 없음 → 40-60
- **효과**: S5(Can 부족 유저) top 점수 90→73 (현실적)
- **전공 추천 적용 시**: 전공도 "배경 없음" 시나리오 존재. 동일 패턴으로 비전공자의 전공 진입 난이도를 현실적으로 평가 가능.

### [2026-02-27] P0-3: 점수 공식 리밸런싱

- **파일**: `src/services/ai-analyzer/llm-judge.ts`
- **변경**:
  - Feasibility 가중치: 10% → 20%
  - RiskPenalty 상한: 3점 → 8점
  - 전체 공식: `Fit = 0.45×Like + 0.35×Can + 0.20×Feasibility - RiskPenalty(cap 8)`
- **효과**: 비현실적 고점 방지, 리스크 요소 반영 강화
- **전공 추천 적용 시**: 동일 공식 구조 적용 가능. 전공은 Feasibility(수능 성적, 전공 변경 난이도 등)가 더 중요할 수 있으므로 가중치 조정 필요.

### [2026-02-28] Phase 3-1: 인터뷰 앵커링 강화

- **파일**: `src/services/ai-analyzer/llm-interviewer.ts`
- **문제**: LLM이 유저의 실제 발화를 인용하지 않고 일반적 질문만 생성 (앵커링 0/6)
- **변경**:
  - STEP 4(앵커링)를 선택적 → **필수**로 강화: "5개 중 최소 3개 필수 인용"
  - 4가지 앵커 패턴 제시 (A: 그대로 인용, B: 핵심 키워드 인용, C: 감정 반영, D: 패러프레이징)
  - anchor 필드 비어있으면 최대 2개까지만 허용
  - 직업/전공 양쪽 프롬프트 모두 동일하게 업데이트
- **효과**: 실질적 앵커링 패턴("~다고 하셨는데", "~라고 말씀하셨는데") 사용 빈도 증가. 형식적 감지(따옴표 인용)는 1/6 → 자연어 앵커링으로 전환.
- **전공 추천 적용 시**: 동일 프롬프트 구조 적용. 전공 상담사 페르소나에 맞춰 앵커 패턴 수정.

### [2026-02-28] Phase 3-2: CAG 중복 질문 필터 강화

- **파일**: `src/services/ai-analyzer/cag-manager.ts`, `src/services/ai-analyzer/llm-interviewer.ts`
- **문제**: 3/6 시나리오에서 라운드 간 중복 질문 발생 (유사 주제 반복)
- **변경**:
  - `TOPIC_SYNONYMS` 맵 추가 (8개 토픽 그룹: 에너지, 가치, 감정, 관계, 환경, 성장, 안정, 한계)
  - `isQuestionAlreadyAsked` 유사도 임계값 0.80 → 0.65로 하향 (더 엄격한 중복 감지)
  - 토픽 그룹 교차 검사 추가: 공유 토픽 ≥2개면 중복으로 판단
  - LLM 생성 후 CAG post-generation 필터링 추가 (`cagGuardQuestion`)
  - 시스템 프롬프트에 "이미 다룬 핵심 토픽" 정보 추가
- **효과**: 중복 발생 시나리오 3/6 → 2/6 (33% 감소). S2(안정형)와 S6(종합)에서만 잔여 중복.
- **전공 추천 적용 시**: 동일 CAG 구조 재사용. TOPIC_SYNONYMS에 전공 관련 토픽 그룹 추가.

### [2026-02-28] Phase 3-3: 카테고리 기본값 일괄 재태깅 인프라

- **파일**: `src/services/ai-analyzer/admin-api.ts`, `scripts/batch-retag-categories.ts`
- **문제**: 4,795건의 직업이 카테고리 기본값(job_type='knowledge', work_environment='office') 보유
- **변경**:
  - `POST /admin/api/ai/retag-category-defaults` 엔드포인트 추가
  - flat-50 제외 (별도 재태깅), 카테고리 필드만 타겟팅
  - `scripts/batch-retag-categories.ts` CLI 스크립트
- **상태**: 인프라 구축 완료. 실행 중.
- **전공 추천 적용 시**: 전공 카테고리 필드에도 동일 재태깅 패턴 적용 가능.

---

## E2E 테스트 결과 비교

### 베이스라인 (코드 변경 전, 인터뷰 포함)

| 시나리오 | Top1 직업 | Fit#1 | Fit#10 | Spread |
|----------|----------|-------|--------|--------|
| 분석형 유저 | 인공지능모델개발자 | 75 | 59 | 16 |
| 안정 지향 유저 | 공공행정사무원(일반) | 81 | 71 | 10 |
| 내면갈등 유저 | VR·AR게임기획자 | 77 | 66 | 11 |
| 창의형 유저 | 게임그래픽디자이너 | 84 | 71 | 13 |
| Can 부족 유저 | 지능형로봇연구원 | 77 | 66 | 11 |
| 종합 테스트 | 인공지능연구원 | 76 | 64 | 12 |

**알려진 문제:**
- S2: 열처리반장(#6), 직물수지가공반장(#7) → 안정형 사무직 유저에 부적절
- S3: 기능성식품연구원, 가스설비안전성연구원 → 자율성+안정성 갈등 유저에 관련성 낮음
- 인터뷰 앵커링: 6개 시나리오 모두 ❌ (유저 발화 인용 0%)
- 중복 질문: S2, S4, S5에서 발견 (3/6)

### 개선 후 (Phase 2 코드 변경 적용, flat-50 재태깅 150건 진행)

| 시나리오 | Top1 직업 | Fit#1 | Fit#10 | Spread |
|----------|----------|-------|--------|--------|
| 분석형 유저 | 빅데이터아키텍처전문가 | 79 | 61 | 18 |
| 안정 지향 유저 | 금융기관지점관리사무원 | 81 | 73 | 8 |
| 내면갈등 유저 | 기능성식품연구원 | 76 | 62 | 14 |
| 창의형 유저 | UX·UI디자이너 | 80 | 72 | 8 |
| Can 부족 유저 | 고객관리시스템(CRM)전문가 | 73 | 66 | 7 |
| 종합 테스트 | 인공지능연구원 | 79 | 70 | 9 |

### 베이스라인 → V2 비교 분석

| 시나리오 | Baseline Top1 | V2 Top1 | 점수 변화 | 핵심 개선 |
|----------|--------------|---------|----------|----------|
| S1 분석형 | 75 | **79** | +4 | 데이터분석가(일반) #7에 등장 |
| S2 안정형 | 81 | 81 | 0 | **반장직 2개 완전 제거** ✅ |
| S3 갈등형 | 77 | 76 | -1 | UX·UI디자이너 #2로 상승 |
| S4 창의형 | 84 | 80 | -4 | Top10 전부 디자인 직종 |
| S5 Can부족 | 77 | 73 | -4 | 더 현실적 (CRM, 빅데이터) |
| S6 종합 | 76 | **79** | +3 | AI연구원+엔지니어 상위 |

**핵심 개선 사항:**
1. **S2 반장직 제거**: 열처리반장(#6→제거), 직물수지가공반장(#7→제거) — safe-replacement + tag-filter 변경 효과
2. **S4 디자인 집중**: 모든 Top 10이 디자인/크리에이티브 직종 (광고, UI, VFX, 3D 등)
3. **S1 데이터 직종 강화**: 데이터분석가(일반)이 Top 10에 진입
4. **S6 점수 상승**: 인공지능연구원 76→79, 인공지능엔지니어 78 신규 진입

**점수 추이:**
- 평균 Top1 Fit: 78.3 → 78.0 (유사)
- 점수보다 **추천 적합성**이 크게 향상됨 (미스매치 제거, 관련직종 집중)

### V3 (Phase 3 코드 변경 + 앵커링/중복필터 강화 + flat-50 재태깅 460건)

| 시나리오 | Top1 직업 | Fit#1 | Fit#10 | Spread |
|----------|----------|-------|--------|--------|
| 분석형 유저 | 빅데이터아키텍처전문가 | 76 | 65 | 11 |
| 안정 지향 유저 | 공공행정전문가(일반) | 84 | 68 | 16 |
| 내면갈등 유저 | 광고·홍보·마케팅전문가 | 74 | 61 | 13 |
| 창의형 유저 | 게임캐릭터원화디자이너 | 83 | 73 | 10 |
| Can 부족 유저 | 빅데이터전문가 | 73 | 63 | 10 |
| 종합 테스트 | VR·AR게임기획자 | 77 | 62 | 15 |

### Baseline → V2 → V3 전체 비교

| 시나리오 | Baseline Top1 (Fit) | V2 Top1 (Fit) | V3 Top1 (Fit) | 핵심 변화 |
|----------|---------------------|---------------|---------------|----------|
| S1 분석형 | 인공지능모델개발자 (75) | 빅데이터아키텍처전문가 (79) | 빅데이터아키텍처전문가 (76) | 데이터/AI 계열 안정 유지 |
| S2 안정형 | 공공행정사무원 (81) | 금융기관지점관리사무원 (81) | **공공행정전문가 (84)** | 공공행정 최상위 + 반장직 완전 제거 ✅ |
| S3 갈등형 | VR·AR게임기획자 (77) | 기능성식품연구원 (76) | **광고·홍보·마케팅전문가 (74)** | 마케팅/홍보 직종으로 수렴 |
| S4 창의형 | 게임그래픽디자이너 (84) | UX·UI디자이너 (80) | **게임캐릭터원화디자이너 (83)** | 디자인 직종 중 원화 특화 |
| S5 Can부족 | 지능형로봇연구원 (77) | CRM전문가 (73) | **빅데이터전문가 (73)** | 현실적 수준 유지 |
| S6 종합 | 인공지능연구원 (76) | 인공지능연구원 (79) | **VR·AR게임기획자 (77)** | 게임/VR 관심 반영 |

**V3 인터뷰 품질 변화:**

| 항목 | Baseline | V3 | 개선 |
|------|----------|-----|------|
| 앵커링 | 0/6 (0%) | 1/6 (17%) + 자연어 앵커링 다수 | ⬆️ |
| 중복 질문 | 3/6 (50%) | 2/6 (33%) | ⬆️ 33% 감소 |
| 에러 | 0 | 0 | ✅ 유지 |
| 평균 Fit#1 | 78.3 | 77.8 | → 유사 (추천 적합성 향상) |

---

## 인터뷰 품질 분석

### LLM 인터뷰 구조

| 라운드 | 주제 | Purpose Tag | 목표 |
|--------|------|-------------|------|
| 1 | ENGINE (욕망 탐색) | ENGINE | 유저가 진정으로 원하는 것 탐색 |
| 2 | AVOIDANCE (회피 탐색) | AVOIDANCE | 절대 하기 싫은 것, 에너지 소모원 |
| 3 | INTEGRATION (통합) | INTEGRATION | 현실 제약 + 트레이드오프 수용 |

### 베이스라인 인터뷰 품질

| 항목 | 결과 | 평가 |
|------|------|------|
| 질문 생성 방식 | 100% LLM (llm) | ✅ 정상 |
| 라운드당 질문 수 | 3-5개 | ✅ 적절 |
| 질문 자연스러움 | 높음 | ✅ 상담사 톤 유지 |
| 맥락 연결 | 보통 | ⚠️ 이전 답변 반영 미흡 |
| 앵커링 (발화 인용) | 0/6 시나리오 | ❌ 개선 필요 |
| 중복 질문 | 3/6 시나리오 | ⚠️ CAG 필터 강화 필요 |

### 앵커링 미작동 원인 분석

현재 `llm-interviewer.ts`의 시스템 프롬프트에 "유저의 실제 표현을 인용하여 질문" 지시가 포함되어 있으나, E2E 테스트에서 앵커링이 전혀 감지되지 않음. 추정 원인:
1. E2E 테스트의 답변이 시나리오 스크립트의 패턴 매칭 기반이라 실제 대화처럼 자연스럽지 않음
2. LLM이 "인용" 대신 "참조"하는 방식으로 이전 발화를 반영
3. 앵커링 감지 로직(`checkAnchoring`)이 정확한 따옴표 인용만 감지

---

## 데이터 품질 현황

### Phase A 감사 결과 (2026-02-27)

| 항목 | 수치 | 상태 |
|------|------|------|
| 총 직업 수 | 7,312 | - |
| 태깅 완료 | 7,312 (100%) | ✅ |
| Flat-50 노이즈 | 1,339 (18.3%) | ⚠️ 재태깅 진행 중 |
| 카테고리 편향 (job_type) | 88.6% knowledge | ⚠️ 프롬프트 개선 완료 |
| 카테고리 편향 (work_env) | ~95% office | ⚠️ 프롬프트 개선 완료 |
| 수치 모순 | 0건 | ✅ |

### Flat-50 재태깅 현황

- 대상: 1,339건 (analytical=50, creative=50, execution=50, people_facing=50)
- 방법: 개선된 `TAGGING_SYSTEM_PROMPT`로 GPT-4o-mini 재태깅
- 엔드포인트: `POST /admin/api/ai/retag-flat50` (batch_size=10)
- 상태: **진행 중** (~460건 완료 → 나머지 실행 중)
- 성공률: 99.8% (502 일시 에러 1건 외 전부 성공)

### 카테고리 기본값 재태깅 현황

- 대상: 4,795건 (job_type='knowledge' AND work_environment='office', flat-50 제외)
- 방법: 개선된 카테고리 결정 규칙이 포함된 프롬프트로 재태깅
- 엔드포인트: `POST /admin/api/ai/retag-category-defaults` (batch_size=5~10)
- 상태: **인프라 구축 완료, 실행 대기**

---

## 주요 학습 사항

### 1. 기본값 편향은 프롬프트에서 잡아야 한다
`cleanTagResult()`의 기본값(knowledge/office/permanent/medium)은 안전망이지만, LLM이 기본값을 출력하지 않도록 프롬프트에 앵커 예시를 충분히 제공하는 것이 핵심.

### 2. 이름 기반 필터링이 즉효성이 있다
카테고리 데이터(job_type, work_environment)가 부정확할 때, `job_name` 정규식 기반 필터링이 즉시 효과를 발휘. 데이터 품질 개선과 병행하여 사용.

### 3. RIASEC은 범용적 근거
Holland의 6유형 이론은 직업 추천뿐 아니라 전공 추천에도 동일하게 적용 가능. 토큰→속성 매핑의 학술적 근거로 활용.

### 4. Feasibility 앵커링이 현실감을 높인다
경력별 점수 가이드를 제공하면 LLM이 비현실적 고점을 피하고 실용적 평가를 함. 전공 추천에서도 배경/성적/경험에 따른 가이드 필요.

### 5. E2E 테스트는 인터뷰 포함이 필수
인터뷰 없이 miniModule만으로 테스트하면 실제 유저 경험과 30% 이상 결과 차이 발생. 인터뷰에서 추가 수집되는 fact가 추천에 유의미한 영향.
