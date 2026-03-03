# AI 추천 핵심 병목 해결 계획서

> 작성일: 2026-02-28
> 업데이트: 2026-03-03 (Phase 5 결과 반영)
> 목적: V4 E2E 테스트에서 발견된 3가지 핵심 병목을 해결하여 유료 서비스 수준 달성
> 현재 수준: 6/10 (Phase 5 후) → 목표: 8/10
>
> ## Phase 5 실행 결과 요약
> - **A-1 (Judge temp+seed)**: ✅ 구현 → Top10 overlap 50%, Top1 일관성 개선 없음 (인터뷰가 근본 원인)
> - **A-2 (PS blending)**: ✅ 구현 → Spread 9.3→7.5, 점수 안정화 효과
> - **B-1 (Relevance Gate)**: ✅ 구현 → LLM이 프롬프트 후반 지시 무시, 버섯연구원 여전히 like=72
> - **핵심 학습**: 프롬프트 기반 제어 한계 확인. 코드 레벨 post-filter + 인터뷰 안정화가 필요

---

## 병목 A: 실행 간 일관성 (현재 17% → 목표 70%+)

### 문제 정의

동일 시나리오를 V3→V4로 실행했을 때 6개 중 5개 Top1이 바뀜.
유저가 같은 프로필로 두 번 테스트하면 완전히 다른 결과가 나올 수 있음.

### 원인 분석 (영향도 순)

```
LLM 인터뷰 (temperature=0.7) ← 가장 큰 변동 원인
  ↓ 매번 다른 질문 생성
자동 답변 매칭 → 다른 답변 선택
  ↓
다른 narrative_facts 수집
  ↓
다른 벡터 검색 쿼리 → 다른 후보 풀
  ↓
LLM Judge (temperature=0.5) ← 두 번째 변동 원인
  ↓ 같은 후보도 다른 점수 부여
다른 최종 순위
```

### 해결 전략: 3단계

#### A-1. LLM Judge temperature 0.5 → 0.1 + seed 고정 (즉시)

**대상 파일**: `src/services/ai-analyzer/llm-judge.ts` (line 842, 2146)
**대상 파일**: `src/services/ai-analyzer/openai-client.ts` (seed 파라미터 추가)

**변경 내용**:
```typescript
// openai-client.ts — seed 파라미터 지원 추가
options: {
  model?: string
  temperature?: number
  max_tokens?: number
  timeout_ms?: number
  seed?: number  // ★ 추가
}

// API 호출 body에 seed 포함
body: JSON.stringify({
  model,
  messages,
  temperature,
  max_tokens,
  ...(seed !== undefined && { seed }),
})

// llm-judge.ts — temperature + seed 설정
temperature: 0.1,  // 0.5 → 0.1
seed: 42,          // 고정 seed
```

**근거**: Judge는 "평가" 단계. 동일 입력이면 동일 결과가 나와야 함. 다양성이 아닌 일관성이 핵심.
**기대 효과**: Judge 변동 제거 → 같은 후보 풀이면 같은 순위
**위험**: 없음. 평가 정확도에 영향 없음 (같은 프롬프트+입력이면 best 답이 동일)

#### A-2. Personalized Scoring 가중치 확대 (중기)

**대상 파일**: `src/services/ai-analyzer/routes.ts` (recommend 엔드포인트)

**현재 문제**: 최종 순위가 Judge 점수에 과도하게 의존 → Judge 변동이 곧 순위 변동
**해결**: Pre-filter 단계에서 deterministic score (Personalized Scoring)의 비중을 높여 Judge 의존도 감소

```
현재: Pre-filter(PS 기반) → Judge(LLM 기반) → 최종 순위 = Judge 100%
개선: Pre-filter(PS 기반) → Judge(LLM 기반) → 최종 순위 = PS 30% + Judge 70%
```

**변경 내용**:
```typescript
// 최종 Fit 계산에 PS 점수 블렌딩
const finalFit = 0.7 * judgeFit + 0.3 * normalizedPsScore
```

**근거**: PS는 deterministic (같은 입력이면 같은 결과). 비중을 30% 확보하면 Judge 변동의 영향을 70%로 축소.
**기대 효과**: 일관성 17% → ~50% (Judge만 고정하면 70%+)

#### A-3. 인터뷰 질문 캐싱 (장기)

**대상 파일**: `src/services/ai-analyzer/llm-interviewer.ts`

**현재 문제**: 인터뷰가 매번 다른 질문 → 다른 답변 → 다른 fact → 다른 추천 경로
**해결**: 동일 프로필 해시(miniModule 5축 값)에 대해 인터뷰 질문을 캐싱

```typescript
// 프로필 해시 생성
const profileHash = hashMiniModule(miniModule) // interest+value+strength+constraint+workstyle 해시

// D1에서 캐시된 질문 조회
const cached = await db.prepare(
  'SELECT questions FROM interview_question_cache WHERE profile_hash = ? AND round = ?'
).bind(profileHash, round).first()

if (cached) {
  return JSON.parse(cached.questions) // 캐시 히트 → 동일 질문
}

// 캐시 미스 → LLM 생성 후 캐시 저장
const questions = await generateQuestions(...)
await db.prepare(
  'INSERT INTO interview_question_cache (profile_hash, round, questions) VALUES (?, ?, ?)'
).bind(profileHash, round, JSON.stringify(questions)).run()
```

**주의사항**:
- 캐시 TTL 설정 필요 (프롬프트 변경 시 무효화)
- Round 1만 캐싱 (Round 2,3은 이전 답변에 의존하므로 캐싱 어려움)
- 완전한 일관성은 불가능 — Round 2,3은 유저 답변에 따라 달라져야 하는 것이 정상

**기대 효과**: Round 1 질문 고정 → 초기 탐색 방향 일관성 확보 → 전체 일관성 ~60-70%

---

## 병목 B: 노이즈 추천 (현재 1-3개/10개 → 목표 0개)

### 문제 정의

Top 10에 유저 프로필과 명백히 무관한 직업이 포함됨:
- S1(데이터분석가) → "버섯연구원" #2
- S4(디자이너) → "대중악기연주자" #3, "대중가수" #9

### 원인 분석

```
벡터 검색 (600-800개 후보)
  ↓ semantic 유사도가 넓음 (코사인 유사도 기반)
  ↓ "분석"과 "연구"가 semantic으로 가까움 → "버섯연구원" 후보 진입
Pre-filter (~50개)
  ↓ PS 점수 기반 정렬 — 속성 매칭만 봄, 직업 분야 무시
LLM Judge
  ↓ Like/Can/Feasibility/Risk 4축으로만 평가
  ↓ "유저의 명시적 관심 분야와 직접 관련 있는지" 검증 없음
  ↓ "버섯연구원"의 analytical 속성이 높으면 Can 점수가 높게 나옴
Top 10에 노이즈 포함
```

### 해결 전략: 3단계

#### B-1. Judge 프롬프트에 "관련성 게이트" 추가 (즉시)

**대상 파일**: `src/services/ai-analyzer/llm-judge.ts`

**변경 내용**: 시스템 프롬프트에 관련성 체크 지시 추가

```
## 관련성 게이트 (Relevance Gate)

Like 점수를 매기기 전에, 먼저 이 직업이 유저의 **명시적 관심 분야**와 직접 관련이 있는지 판단하세요.

유저의 관심 키워드: {interest_keywords}  (예: "데이터", "분석", "AI", "프로그래밍")

판단 기준:
- 직업명 또는 직업 설명에 관심 키워드가 포함되어 있으면 → 관련 있음
- 관심 키워드와 같은 산업/분야에 속하면 → 관련 있음
- 위 두 가지 모두 아니면 → 관련 없음

관련 없는 직업:
- Like 점수를 최대 45로 제한
- likeReason에 "유저의 명시적 관심 분야와 직접 관련 없음" 기재
```

**interest_keywords 추출 방법**:
```typescript
// narrative_facts에서 관심 키워드 추출
const interestKeywords = extractInterestKeywords(narrativeFacts, miniModule)
// miniModule의 interest_top 토큰 + narrative에서 언급된 키워드
```

**기대 효과**: "버섯연구원"의 Like가 45 이하로 제한 → Fit 점수 하락 → Top 10 탈락
**위험**: 키워드 추출이 부정확하면 관련 있는 직업도 제한될 수 있음 → 보수적 키워드만 사용

#### B-2. 후처리 관련성 필터 추가 (중기)

**대상 파일**: `src/services/ai-analyzer/routes.ts` (recommend 엔드포인트)

Judge 결과 후 최종 Top 10 선정 전에 관련성 필터 추가:

```typescript
// Judge 결과에서 Top 10 선정 전
const filteredResults = judgeResults.filter(job => {
  // 유저의 관심 분야 키워드
  const userInterests = extractTopicFromFacts(narrativeFacts)

  // 직업명 + 카테고리로 관련성 체크
  const jobTopics = extractJobTopics(job.name, job.attributes)

  // 교집합이 0이면 관련성 낮음 → 제외 (단, 상위 20개 내에서만)
  const overlap = intersect(userInterests, jobTopics)
  if (overlap.size === 0 && job.rank <= 20) {
    return false // 노이즈 필터링
  }
  return true
})
```

**topic 사전 구축**:
```typescript
const TOPIC_MAP = {
  'data_numbers': ['데이터', '분석', '통계', 'AI', '빅데이터', '정보', '시스템'],
  'art_design': ['디자인', '그래픽', '미술', '시각', '일러스트', 'UI', 'UX'],
  'music_performance': ['음악', '악기', '연주', '가수', '작곡'],
  'agriculture': ['농업', '농촌', '작물', '버섯', '원예', '축산'],
  // ... 20-30개 토픽
}
```

**기대 효과**: "데이터" 관심 유저에게 "버섯연구원" 확실 제거
**위험**: 토픽맵이 불완전하면 정상 추천도 필터링될 수 있음 → 소프트 필터링(순위 하향)으로 시작

#### B-3. Diversity Guard 강화 (즉시)

**대상 파일**: `src/services/ai-analyzer/routes.ts`

현재 Diversity Guard는 같은 카테고리 직업 최대 3개 제한만 있음. 추가 규칙:

```typescript
// "완전 무관 직업" 최대 1개로 제한
const unrelatedCount = top10.filter(j => j.relevanceScore < 0.3).length
if (unrelatedCount > 1) {
  // relevanceScore가 가장 낮은 것부터 제거, 대체 후보로 교체
}
```

---

## 병목 C: 데이터 완성도 (현재 34% → 목표 100%)

### 문제 정의

- Flat-50: 1,339건 중 452건 완료 (34%) — 887건 남음
- 카테고리 기본값: 4,795건 중 ~65건 완료 (1.4%) — 4,730건 남음
- 전체 직업 7,312건 중 ~84%가 어떤 형태로든 데이터 불완전

### 현재 진행 상태

| 작업 | 인프라 | 성공률 | 속도 | ETA |
|------|--------|--------|------|-----|
| Flat-50 | ✅ 엔드포인트+스크립트 | 99.8% | ~5건/분 | ~3시간 |
| 카테고리 | ✅ 엔드포인트+스크립트 | 100% | ~5건/분 | ~16시간 |

### 해결 전략: 3단계

#### C-1. 재태깅 완료 (현재 진행 중)

**Flat-50 완료**: 백그라운드 스크립트 실행 중. 중단되면 재실행:
```bash
npx tsx scripts/batch-retag-flat50.ts --batch-size=5 --max-batches=250
```

**카테고리 완료**: 백그라운드 스크립트 실행 중. 중단되면 재실행:
```bash
npx tsx scripts/batch-retag-categories.ts --batch-size=5 --max-batches=1000
```

**병렬 실행 가능**: 두 스크립트는 다른 대상을 처리하므로 동시 실행 가능 (단, Worker 부하 주의)

#### C-2. 재태깅 품질 검증 (완료 후 즉시)

재태깅이 완료되면 품질 검증 필수:

```sql
-- 1. Flat-50이 실제로 해소되었는지 확인
SELECT COUNT(*) as remaining_flat50
FROM job_attributes
WHERE analytical = 50 AND creative = 50 AND execution = 50 AND people_facing = 50;
-- 목표: 0건 (또는 <50건)

-- 2. 카테고리 기본값이 해소되었는지 확인
SELECT job_type, COUNT(*) as cnt, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM job_attributes), 1) as pct
FROM job_attributes
GROUP BY job_type
ORDER BY cnt DESC;
-- 목표: knowledge < 50% (기존 88.6%)

-- 3. 새 태깅의 다양성 확인
SELECT work_environment, COUNT(*) as cnt
FROM job_attributes
GROUP BY work_environment
ORDER BY cnt DESC;
-- 목표: office < 60% (기존 ~95%)

-- 4. 속성 분포 검증 (flat 방지)
SELECT
  CASE
    WHEN analytical = creative AND creative = execution AND execution = people_facing THEN 'flat'
    ELSE 'diverse'
  END as status,
  COUNT(*) as cnt
FROM job_attributes
GROUP BY status;
-- 목표: flat < 100건
```

**관리자 API 추가 권장**: 데이터 건강도 대시보드
```
GET /admin/api/ai/data-health
→ { flat50_count, category_bias: { job_type, work_env }, diversity_score }
```

#### C-3. 재태깅 후 E2E V5 실행 (검증 후)

데이터 품질 검증 통과 후 E2E V5를 실행하여 추천 품질 변화 측정:

```bash
npx tsx scripts/e2e-full-test.ts --base-url=https://careerwiki.org --output-dir=docs/e2e-results/full-e2e-v5
```

**비교 기준**:
- V4 (데이터 34% 정리) vs V5 (데이터 100% 정리)
- 노이즈 추천 감소 여부
- 카테고리 기반 TAG 필터 작동 확인 (기존에 88% knowledge라 작동 못함)

---

## 실행 우선순위 + 로드맵

### Phase 5: 즉시 실행 가능 (코드 변경 1-2시간)

| 순서 | 작업 | 파일 | 영향 범위 | 기대 효과 |
|------|------|------|----------|----------|
| 1 | Judge temperature 0.5→0.1 | llm-judge.ts | Judge 스코어링 | 일관성 +30% |
| 2 | openai-client에 seed 지원 | openai-client.ts | 전체 LLM 호출 | 재현성 확보 |
| 3 | Judge에 seed=42 추가 | llm-judge.ts | Judge 스코어링 | 일관성 +10% |
| 4 | Judge 관련성 게이트 추가 | llm-judge.ts | Judge 프롬프트 | 노이즈 -50% |
| 5 | batch_size=0 카운트 전용 수정 | admin-api.ts | 관리자 API | 부수효과 방지 |
| 6 | E2E V5 실행 | 없음 (스크립트 실행) | 측정 | 개선 효과 정량화 |

### Phase 6: 중기 (코드 변경 3-5시간)

| 순서 | 작업 | 파일 | 영향 범위 | 기대 효과 |
|------|------|------|----------|----------|
| 7 | PS 점수 블렌딩 (30%) | routes.ts | 최종 순위 | 일관성 +15% |
| 8 | 후처리 관련성 필터 | routes.ts | 최종 순위 | 노이즈 -30% |
| 9 | 데이터 건강도 대시보드 | admin-api.ts + admin UI | 모니터링 | 품질 가시성 |
| 10 | Feasibility 가이드 세분화 | llm-judge.ts | Judge 프롬프트 | Can 정확도 +20% |

### Phase 7: 장기 (설계 필요 4-8시간)

| 순서 | 작업 | 파일 | 영향 범위 | 기대 효과 |
|------|------|------|----------|----------|
| 11 | 인터뷰 R1 질문 캐싱 | llm-interviewer.ts + DB | 인터뷰 | 일관성 +10% |
| 12 | E2E 자동답변 LLM화 | e2e-full-test.ts | 테스트 정확도 | 측정 신뢰도 향상 |
| 13 | 토픽맵 사전 구축 | 신규 파일 | 관련성 필터 | 노이즈 완전 제거 |

---

## 목표 달성 시 예상 결과

| 지표 | 현재 (V4) | Phase 5 후 | Phase 6 후 | Phase 7 후 |
|------|----------|-----------|-----------|-----------|
| 일관성 | 17% (1/6) | 50% (3/6) | 65% (4/6) | 75% (4-5/6) |
| 노이즈 | 1-3개/10 | 0-1개/10 | 0개/10 | 0개/10 |
| 데이터 | 34% | 100% | 100% | 100% |
| Fit 정확도 | 6/10 | 7/10 | 8/10 | 8.5/10 |
| **종합** | **5.5/10** | **7/10** | **8/10** | **8.5/10** |

---

## 전공 추천 적용 시 동일 병목 예방

위 3가지 병목은 전공 추천에서도 **동일하게 발생할 것**:

1. **일관성**: 전공 인터뷰도 LLM 기반이면 같은 변동 발생 → 처음부터 Judge temperature=0.1 + seed 적용
2. **노이즈**: 전공 벡터 검색도 semantic 유사도 → "물리학 관심에 체육학 추천" 가능 → 관련성 게이트 처음부터 포함
3. **데이터**: 전공 속성도 flat-50 + 카테고리 기본값 문제 발생 가능 → 태깅 시 품질 검증 자동화

**핵심**: 직업 추천에서 발견한 문제를 전공 추천에서 **사전에 방지**하는 것이 이 문서의 목적.
