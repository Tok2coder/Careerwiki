# Recipe Versioning Spec v1.0

> 작성일: 2026-01-02
> 버전: recipe-v1.0.0
> 목적: 추천 결과의 재현성과 추적성 보장을 위한 버전 관리 체계

---

## 1. 왜 필요한가?

### 1.1 문제 상황
```
유저: "어제 받은 결과랑 오늘 결과가 다른데요?"

원인 가능성:
1. 유저 입력이 바뀜
2. 추천 알고리즘(Recipe)이 바뀜
3. 직업 데이터(태깅)가 바뀜
4. 임베딩이 바뀜

→ 원인 분리 불가능 = 디버깅 지옥
```

### 1.2 해결책: Version Lock
```
모든 분석 요청에 버전 정보를 기록하여:
1. 같은 입력 + 같은 버전 = 같은 결과 (재현성)
2. 결과가 다르면 → 어떤 버전이 바뀌었는지 추적 가능
```

---

## 2. 버전 관리 대상

### 2.1 핵심 버전 3개 (v0.1 필수)

| 버전 | 의미 | 변경 트리거 |
|------|------|------------|
| `recipe_version` | 추천 알고리즘 전체 | Fit 공식, 가중치, 후보 수, 다양성 룰 변경 |
| `tagger_version` | 직업 속성 태깅 | 태깅 프롬프트, 카테고리, 후처리 로직 변경 |
| `scoring_version` | 점수 계산 로직 | Like/Can/Risk 계산식, 매핑 테이블 변경 |

### 2.2 확장 버전 (v0.2 이후)

| 버전 | 의미 | 변경 트리거 |
|------|------|------------|
| `embedding_version` | 벡터 임베딩 | 임베딩 모델, 텍스트 템플릿 변경 |
| `prompt_version` | LLM 설명 생성 | 설명 프롬프트, 출력 포맷 변경 |
| `extractor_version` | 유저 입력 추출 | Fact 추출 로직, 매핑 변경 |

---

## 3. 버전 포맷

### 3.1 형식
```
{component}-v{major}.{minor}.{patch}

예시:
- recipe-v1.0.0
- tagger-v1.0.0
- scoring-v0.1.0
```

### 3.2 버전 업데이트 규칙

| 변경 유형 | 버전 업데이트 |
|----------|--------------|
| 결과에 영향 없는 리팩토링 | patch (+0.0.1) |
| 점수/순위가 약간 달라지는 변경 | minor (+0.1.0) |
| 결과 구조나 로직 대폭 변경 | major (+1.0.0) |

---

## 4. 데이터베이스 설계

### 4.1 analysis_requests 테이블

```sql
CREATE TABLE analysis_requests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- 유저/세션 정보
  user_id TEXT,
  session_id TEXT NOT NULL,
  
  -- 버전 정보 (Version Lock)
  recipe_version TEXT NOT NULL,      -- 'recipe-v1.0.0'
  tagger_version TEXT NOT NULL,      -- 'tagger-v1.0.0'
  scoring_version TEXT NOT NULL,     -- 'scoring-v0.1.0'
  
  -- 입력 스냅샷
  profile_revision_id TEXT,          -- user_profile_revisions.id
  analysis_type TEXT NOT NULL CHECK(analysis_type IN ('job', 'major')),
  pricing_tier TEXT DEFAULT 'free' CHECK(pricing_tier IN ('free', 'pro')),
  
  -- 상태
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'processing', 'completed', 'failed')),
  
  -- 타임스탬프
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  completed_at DATETIME
);

CREATE INDEX idx_analysis_requests_session ON analysis_requests(session_id);
CREATE INDEX idx_analysis_requests_versions ON analysis_requests(recipe_version, tagger_version, scoring_version);
```

### 4.2 analysis_results 테이블

```sql
CREATE TABLE analysis_results (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  request_id INTEGER NOT NULL,
  
  -- 결과 데이터
  result_json TEXT NOT NULL,  -- 전체 결과 (아래 구조 참조)
  
  -- LLM 메타데이터
  llm_provider TEXT,
  llm_model TEXT,
  prompt_tokens INTEGER,
  completion_tokens INTEGER,
  llm_latency_ms INTEGER,
  
  -- 타임스탬프
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (request_id) REFERENCES analysis_requests(id) ON DELETE CASCADE
);

CREATE INDEX idx_analysis_results_request ON analysis_results(request_id);
```

### 4.3 result_json 구조

```typescript
interface AnalysisResultJSON {
  // 버전 정보 (재확인용)
  versions: {
    recipe: string
    tagger: string
    scoring: string
  }
  
  // 입력 요약
  input_summary: {
    profile_revision_id: string
    key_interests: string[]
    key_constraints: string[]
  }
  
  // 메인 결과
  fit_top3: Array<{
    job_id: string
    job_name: string
    scores: {
      fit: number
      like: number
      can: number
      risk_penalty: number
    }
    risk_status: 'safe' | 'caution'
    evidence_links: EvidenceLink[]
    summary: string
  }>
  
  // 보조 결과
  like_top10: Array<{
    job_id: string
    job_name: string
    like_score: number
  }>
  
  can_top10: Array<{
    job_id: string
    job_name: string
    can_score: number
  }>
  
  // 주의 후보 (Risk Bucket)
  caution_jobs: Array<{
    job_id: string
    job_name: string
    scores: { fit: number, like: number, can: number, risk_penalty: number }
    risk_reasons: RiskEvidence[]
  }>
  
  // LLM 생성 설명
  llm_explanation: string
  
  // 메타
  generated_at: string
  total_candidates_evaluated: number
}
```

---

## 5. 버전 관리 흐름

### 5.1 분석 요청 시

```typescript
async function createAnalysisRequest(
  env: Env,
  input: AnalyzerInput
): Promise<AnalysisRequest> {
  
  // 1. 현재 버전 가져오기
  const versions = getCurrentVersions()
  // {
  //   recipe: 'recipe-v1.0.0',
  //   tagger: 'tagger-v1.0.0',
  //   scoring: 'scoring-v0.1.0'
  // }
  
  // 2. 유저 프로필 스냅샷 생성
  const profileRevision = await createProfileRevision(env.DB, input)
  
  // 3. 분석 요청 저장
  const request = await env.DB.prepare(`
    INSERT INTO analysis_requests (
      session_id, recipe_version, tagger_version, scoring_version,
      profile_revision_id, analysis_type, pricing_tier, status
    ) VALUES (?, ?, ?, ?, ?, ?, ?, 'pending')
  `).bind(
    input.sessionId,
    versions.recipe,
    versions.tagger,
    versions.scoring,
    profileRevision.id,
    input.analysisType,
    input.pricingTier
  ).run()
  
  return { id: request.meta.last_row_id, ...versions }
}
```

### 5.2 버전 일치 확인

```typescript
// 같은 입력 + 같은 버전이면 캐시된 결과 반환 가능
async function findExistingResult(
  env: Env,
  profileHash: string,
  versions: Versions
): Promise<AnalysisResult | null> {
  
  const result = await env.DB.prepare(`
    SELECT ar.result_json
    FROM analysis_requests req
    JOIN analysis_results ar ON req.id = ar.request_id
    JOIN user_profile_revisions upr ON req.profile_revision_id = upr.id
    WHERE upr.profile_hash = ?
      AND req.recipe_version = ?
      AND req.tagger_version = ?
      AND req.scoring_version = ?
      AND req.status = 'completed'
    ORDER BY req.created_at DESC
    LIMIT 1
  `).bind(
    profileHash,
    versions.recipe,
    versions.tagger,
    versions.scoring
  ).first()
  
  return result ? JSON.parse(result.result_json) : null
}
```

---

## 6. 버전 변경 절차

### 6.1 Recipe 변경 시

```bash
# 1. 버전 상수 업데이트
# src/constants/versions.ts
export const VERSIONS = {
  recipe: 'recipe-v1.1.0',  // 변경
  tagger: 'tagger-v1.0.0',
  scoring: 'scoring-v0.1.0'
}

# 2. 변경 로그 작성
# docs/RECIPE_VERSIONING.md 하단에 추가

# 3. 배포
npm run deploy:prod
```

### 6.2 Tagger 변경 시

```bash
# 1. 태깅 재실행 (변경된 직업만 또는 전체)
npx tsx scripts/rag/tag-jobs.ts --version=tagger-v1.1.0

# 2. QA 검수

# 3. 버전 상수 업데이트
export const VERSIONS = {
  recipe: 'recipe-v1.0.0',
  tagger: 'tagger-v1.1.0',  // 변경
  scoring: 'scoring-v0.1.0'
}

# 4. 배포
```

### 6.3 Scoring 변경 시

```bash
# 1. 점수 계산 로직 수정
# src/rag/scoring/...

# 2. 버전 상수 업데이트
export const VERSIONS = {
  recipe: 'recipe-v1.0.0',
  tagger: 'tagger-v1.0.0',
  scoring: 'scoring-v0.2.0'  // 변경
}

# 3. 테스트 (샘플 입력으로 점수 비교)

# 4. 배포
```

---

## 7. 버전 상수 파일

### 7.1 파일 위치
`src/constants/versions.ts`

### 7.2 파일 내용

```typescript
/**
 * 추천 엔진 버전 관리
 * 
 * 버전 변경 시 반드시:
 * 1. 해당 버전 상수 업데이트
 * 2. docs/RECIPE_VERSIONING.md 변경 이력 추가
 * 3. 테스트 후 배포
 */

export const VERSIONS = {
  /**
   * Recipe Version
   * - Fit 공식, 가중치, 후보 수, 다양성 룰 변경 시 업데이트
   */
  recipe: 'recipe-v1.0.0',
  
  /**
   * Tagger Version
   * - 태깅 프롬프트, 카테고리, 후처리 로직 변경 시 업데이트
   * - 태깅 재실행 필요
   */
  tagger: 'tagger-v1.0.0',
  
  /**
   * Scoring Version
   * - Like/Can/Risk 계산식, 매핑 테이블 변경 시 업데이트
   */
  scoring: 'scoring-v0.1.0',
} as const

export type Versions = typeof VERSIONS

export function getCurrentVersions(): Versions {
  return { ...VERSIONS }
}

export function formatVersionString(versions: Versions): string {
  return `${versions.recipe}+${versions.tagger}+${versions.scoring}`
}
```

---

## 8. A/B 테스트 지원

### 8.1 버전별 비교

```typescript
// 다른 버전으로 같은 입력 테스트
async function compareVersions(
  env: Env,
  profileRevisionId: string,
  versionA: Versions,
  versionB: Versions
): Promise<{
  versionA: AnalysisResult
  versionB: AnalysisResult
  diff: VersionDiff
}> {
  const resultA = await runAnalysisWithVersions(env, profileRevisionId, versionA)
  const resultB = await runAnalysisWithVersions(env, profileRevisionId, versionB)
  
  return {
    versionA: resultA,
    versionB: resultB,
    diff: {
      fitTop3Changed: !arraysEqual(resultA.fit_top3, resultB.fit_top3),
      scoresDiff: calculateScoreDiff(resultA, resultB),
      newJobs: findNewJobs(resultA, resultB),
      removedJobs: findRemovedJobs(resultA, resultB)
    }
  }
}
```

### 8.2 유저별 버전 할당 (향후)

```typescript
// 유저 ID 기반 버전 할당 (A/B 테스트용)
function getVersionForUser(userId: string): Versions {
  const hash = simpleHash(userId)
  
  // 10% 유저에게 새 버전 노출
  if (hash % 100 < 10) {
    return {
      ...VERSIONS,
      scoring: 'scoring-v0.2.0'  // 새 버전
    }
  }
  
  return VERSIONS
}
```

---

## 9. 변경 이력

### 9.1 현재 버전

| Component | Version | 적용일 | 변경 내용 |
|-----------|---------|--------|----------|
| Recipe | `recipe-v1.0.0` | 2026-01-02 | 초기 버전 |
| Tagger | `tagger-v1.0.0` | 2026-01-02 | 초기 버전 |
| Scoring | `scoring-v0.1.0` | 2026-01-02 | 초기 버전 |

### 9.2 이력 기록 템플릿

```markdown
### vX.Y.Z (YYYY-MM-DD)

**Component**: recipe / tagger / scoring

**변경 내용**:
- 변경 1
- 변경 2

**영향**:
- 점수 변화 예상: ±X점
- 순위 변화 예상: 상위 N% 영향

**롤백 가능 여부**: Y/N

**테스트 결과**:
- 샘플 N개 테스트
- 주요 변화: ...
```

---

## 10. 체크리스트

### 버전 변경 전
- [ ] 변경 사유 문서화
- [ ] 영향 범위 분석
- [ ] 샘플 테스트 계획

### 버전 변경 시
- [ ] 버전 상수 업데이트
- [ ] 변경 이력 기록
- [ ] 테스트 실행 및 검증

### 버전 변경 후
- [ ] 배포 완료 확인
- [ ] 모니터링 (오류율, 피드백)
- [ ] 롤백 계획 준비






