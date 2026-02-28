# 전공 추천 개선 시 재사용 가능한 패턴

> 직업 추천 엔진 개선 과정에서 발견한 패턴 중 전공 추천에 적용 가능한 것들을 정리.
> 전공 추천 엔진 개선 시 이 문서를 참고 자료로 활용.

---

## 1. 토큰 → 속성 매핑 (RIASEC 기반)

### 직업 추천에서의 구현

`personalized-scoring.ts`에서 유저의 MiniModule 토큰(interest, value, strength 등)을 직업 속성(analytical, creative, execution, people_facing)에 매핑.

**핵심 매핑 테이블:**

| 유저 토큰 | RIASEC 유형 | 직업 속성 매핑 |
|-----------|-------------|---------------|
| autonomy | Artistic(A) + Investigative(I) | creative↑, analytical↑ |
| meaning | Social(S) | people_facing↑ |
| recognition | Enterprising(E) | execution↑, leadership↑ |
| persistence | Conventional(C) | stability↑, structured↑ |
| fast_learning | Investigative(I) | analytical↑ |
| leadership | Enterprising(E) | execution↑, people_facing↑ |
| nature | Realistic(R) | physical_activity↑ |

### 전공 추천 적용 방법

전공도 동일한 4축 속성 구조(`major_attributes` 테이블)를 가지므로:

1. 동일한 토큰→속성 매핑 로직을 `personalized-scoring-major.ts`에 복제
2. 전공 고유 속성 추가 고려:
   - `academic_difficulty`: 학업 난이도 (수학 비중, 이론 깊이)
   - `career_flexibility`: 졸업 후 진로 폭 (다양한 직업 연결 가능성)
   - `lab_fieldwork`: 실험실/현장학습 비중
3. RIASEC 근거는 동일하게 적용 가능

---

## 2. LLM Judge 앵커링 패턴

### 직업 추천에서의 구현

`llm-judge.ts`의 `buildUserContext()` 함수에서 유저 배경 정보를 LLM에 전달.

**경험별 Feasibility 가이드:**
```
관련 경력 5년+ → 85-95
관련 경력 1-4년 → 70-85
전공/자격증만 → 55-70
배경 없음 → 40-60
```

이 가이드를 시스템 프롬프트에 포함하여 LLM이 현실적 점수를 부여.

### 전공 추천 적용 방법

전공의 Feasibility는 다른 요소로 판단:

**전공 진입 Feasibility 가이드 (제안):**
```
관련 수능 성적 상위 20% + 전공 관련 활동 → 85-95
관련 수능 성적 상위 50% → 65-80
성적 무관 또는 비관련 배경 → 45-65
전공 변경/편입 → 35-55
```

핵심: LLM에게 "무조건 90점" 주지 않도록 배경별 점수 범위를 명시적으로 제공.

---

## 3. 카테고리 필드 편향 방지

### 직업 추천에서의 구현

`auto-tagger.ts`의 `TAGGING_SYSTEM_PROMPT`에 카테고리 필드 결정 규칙 + 앵커 예시 10개 추가.

**문제**: 기본값 `knowledge/office/permanent/medium`으로 88-99% 폴백
**해결**:
1. 각 카테고리 필드별 판단 기준을 프롬프트에 명시
2. 다양한 직업의 올바른 카테고리 예시 제공 (앵커링)
3. `cleanTagResult()` 기본값은 안전망으로 유지

### 전공 추천 적용 방법

`auto-tagger-major.ts`에도 동일 패턴 적용:

1. 전공 카테고리 필드 (예: `major_type`, `study_environment`) 기본값 편향 확인
2. 프롬프트에 전공별 카테고리 앵커 추가:
   ```
   | 전공 | major_type | study_environment | academic_load |
   | 간호학과 | applied_science | clinical | high |
   | 철학과 | humanities | classroom | medium |
   | 기계공학과 | engineering | lab_workshop | high |
   | 경영학과 | social_science | classroom | medium |
   ```
3. 재태깅 시 flat-50 문제 동시 해결

---

## 4. Hard Exclusion (TAG Filter) 규칙 패턴

### 직업 추천에서의 구현

`tag-filter.ts`의 `MINI_MODULE_EXCLUSION_RULES` — 유저 프로필과 직업 속성 간 Hard Mismatch 시 제외.

**규칙 구조:**
```typescript
{
  id: 'rule_name',
  description: '설명',
  shouldExclude: (miniModule, jobAttributes) => boolean
}
```

**현재 16개 규칙 예시:**
- creativity 중시 → routine/structured 직업 제외
- stability 중시 → 현장/제조직 제외
- physical_activity 회피 → 고강도 현장직 제외

### 전공 추천 적용 방법

유사 구조로 `tag-filter-major.ts` 구현:

```typescript
// 예시 규칙
{
  id: 'creativity_vs_rigid_major',
  description: '창의성 중시 → 정형화된 전공 제외',
  shouldExclude: (mm, majorAttrs) => {
    const wantsCreativity = mm.value_top?.includes('creativity')
    const isRigidMajor = majorAttrs.academic_flexibility === 'rigid'
    return wantsCreativity && isRigidMajor
  }
}
```

---

## 5. Niche Domain 필터링 패턴

### 직업 추천에서의 구현

`safe-replacement.ts`의 `NICHE_DOMAINS` — 특정 배경/관심이 없으면 니치 직업 필터링.

**패턴 구조:**
```typescript
{
  patterns: ['키워드1', '키워드2'],       // 직업명 매칭 패턴
  exemptBackgrounds: ['bg1', 'bg2'],      // 이 배경 있으면 제외 안 함
  exemptInterests: ['interest1'],          // 이 관심사 있으면 제외 안 함
}
```

### 전공 추천 적용 방법

전공에도 니치 도메인 존재:
```typescript
// 예시: 특수 전공 필터
{
  patterns: ['항공우주', '원자력', '해양'],
  exemptBackgrounds: ['stem_background', 'military_interest'],
  exemptInterests: ['technology', 'physical_activity'],
}
```

---

## 6. Diversity Guard 패턴

### 직업 추천에서의 구현

동일 카테고리 직업이 Top 10을 독점하지 않도록 다양성 보장.
현재 `routes.ts`의 recommend 엔드포인트에서 카테고리별 최대 3개 제한.

### 전공 추천 적용 방법

전공도 동일 계열 독점 방지 필요:
- 같은 대학, 같은 계열(인문/이공/예체능) 최대 3-4개
- 관련 학과와 비관련 학과 혼합 추천

---

## 7. E2E 테스트 자동화 구조

### 직업 추천에서의 구현

`scripts/e2e-full-test.ts`:
1. 6개 시나리오 × 6-step API 호출 (analyze → narrative-facts → round-questions×3 → round-answers×3 → recommend)
2. 자동 답변 생성 (패턴 매칭 → 폴백 → 기본)
3. 결과 JSON + 마크다운 트레이스 자동 생성
4. SUMMARY.md에 시나리오별 비교표

### 전공 추천 적용 방법

동일 구조 복제:
1. 전공 추천 전용 시나리오 6개 설계
   - 이과 지향 + 분석형
   - 문과 지향 + 안정형
   - 예체능 지향 + 창의형
   - 진로 고민 (갈등형)
   - 성적 제약형 (특정 과목 약함)
   - 종합형
2. API 엔드포인트 대응 (analyze-major → major-questions → major-recommend 등)
3. 동일 트레이스 구조로 품질 추적

---

## 8. 프롬프트 엔지니어링 패턴

### 직업 추천에서 효과 있었던 기법

1. **앵커 예시 제공**: 프롬프트에 10개 이상의 구체적 예시 → 기본값 폴백 80% 감소
2. **점수 범위 명시**: "이 경우 60-75 사이" → LLM의 비현실적 고점 방지
3. **역할 부여**: "당신은 10년 경력의 직업 상담사입니다" → 자연스러운 톤 + 전문성
4. **구조화된 출력**: JSON 스키마 강제 → 파싱 에러 90% 감소
5. **부정 지시**: "절대 모든 항목을 50으로 설정하지 마세요" → 기본값 방지

### 전공 추천 적용 시 주의점

1. 앵커 예시를 전공별로 재작성 (직업 예시를 그대로 쓰면 안 됨)
2. "당신은 대학 입학 상담사입니다" 역할로 변경
3. 전공 고유 평가 축 반영 (학업 난이도, 취업률, 진로 폭)

---

## 요약: 재사용 체크리스트

| # | 패턴 | 직업 파일 | 전공 대응 | 난이도 |
|---|------|----------|----------|--------|
| 1 | 토큰→속성 매핑 | personalized-scoring.ts | 직접 복제 + 전공 축 추가 | ⭐⭐ |
| 2 | Feasibility 앵커 | llm-judge.ts | 전공 진입 기준으로 수정 | ⭐⭐ |
| 3 | 카테고리 편향 방지 | auto-tagger.ts | auto-tagger-major.ts에 적용 | ⭐ |
| 4 | Hard Exclusion 규칙 | tag-filter.ts | 전공용 규칙 새로 설계 | ⭐⭐⭐ |
| 5 | 니치 도메인 필터 | safe-replacement.ts | 특수 전공 필터 추가 | ⭐⭐ |
| 6 | Diversity Guard | routes.ts | 같은 계열 독점 방지 | ⭐ |
| 7 | E2E 테스트 | scripts/e2e-full-test.ts | 전공 시나리오 설계 | ⭐⭐⭐ |
| 8 | 프롬프트 앵커링 | auto-tagger.ts, llm-judge.ts | 전공별 예시 재작성 | ⭐⭐ |

| 9 | 인터뷰 앵커링 | llm-interviewer.ts | 동일 프롬프트 구조 적용 | ⭐ |
| 10 | CAG 중복 필터 | cag-manager.ts | TOPIC_SYNONYMS에 전공 토픽 추가 | ⭐⭐ |

> ⭐ = 간단한 복제, ⭐⭐ = 수정 필요, ⭐⭐⭐ = 새로 설계 필요

---

## 9. 인터뷰 앵커링 패턴

### 직업 추천에서의 구현

`llm-interviewer.ts`의 시스템 프롬프트 STEP 4에서 앵커링 규칙:

**4가지 앵커 패턴:**
- A: 그대로 인용 — `"○○라고 하셨는데, ..."`
- B: 핵심 키워드 인용 — `"앞서 '키워드'를 언급하셨는데, ..."`
- C: 감정/태도 반영 — `"~에 대해 강한 의지를 보이셨는데, ..."`
- D: 패러프레이징 — `"말씀하신 내용을 정리하면, ..."`

**규칙**: 5개 질문 중 최소 3개에 앵커 필수, anchor 필드 비어있으면 최대 2개까지만 허용

### 전공 추천 적용 방법

동일 프롬프트 구조 그대로 적용. 전공 상담사 페르소나에 맞는 앵커 예시만 변경:
```
"수학이 재밌다고 하셨는데, 혹시 수학적 사고를 활용하는 전공에 관심이 있으신가요?"
"실험이 좋다고 말씀하셨는데, 실험실 중심 전공과 현장 중심 전공 중 어떤 게..."
```

---

## 10. CAG 기반 중복 질문 필터링

### 직업 추천에서의 구현

`cag-manager.ts`의 `isQuestionAlreadyAsked()` + `cagGuardQuestion()`:

1. **토픽 시노님 그룹** (8개): 에너지, 가치, 감정, 관계, 환경, 성장, 안정, 한계
2. **유사도 임계값**: 0.65 (단어 레벨 자카드 유사도)
3. **토픽 그룹 교차**: 공유 토픽 ≥2개 → 중복으로 판단
4. **Post-generation 필터**: LLM 생성 후 CAG로 최종 검증

### 전공 추천 적용 방법

동일 CAG 구조 재사용 + 전공 관련 토픽 그룹 추가:
```typescript
const MAJOR_TOPIC_SYNONYMS = {
  '학업': ['공부', '학습', '수업', '강의', '과제', '시험', '학점'],
  '진로': ['취업', '직업', '커리어', '미래', '진출', '분야'],
  '적성': ['흥미', '관심', '재능', '소질', '적합', '맞는'],
  '환경': ['캠퍼스', '대학', '학교', '분위기', '문화', '동아리'],
}
```
