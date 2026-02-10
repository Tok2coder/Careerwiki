# CareerWiki AI 분석기 테스트 가이드

## 📋 개요

이 문서는 AI 분석기의 동작을 테스트하고 디버그하는 방법을 설명합니다.
개발 중 품질 확인과 캘리브레이션에 활용하세요.

---

## 🛠️ 테스트 환경 설정

### 1. 개발 서버 시작

```bash
# 프로젝트 폴더로 이동
cd C:\Users\PC\Careerwiki

# 개발 서버 시작
npm run dev
```

### 2. 테스트 URL

| URL | 용도 |
|-----|------|
| `http://localhost:3000/analyzer/job` | 일반 분석기 |
| `http://localhost:3000/analyzer/job?debug=true` | **디버그 모드** |
| `http://localhost:3000/admin/ai-analyzer` | 관리자 대시보드 |

---

## 🔍 디버그 모드 사용법

### 접속 방법

브라우저에서:
```
http://localhost:3000/analyzer/job?debug=true
```

### 디버그 패널 표시 항목

디버그 모드에서는 결과 화면에 다음 정보가 표시됩니다:

#### 1. Candidate Source
후보 생성 방식을 표시합니다:
- `🏷️ tagged (DB)`: job_attributes에서 조회
- `⚠️ sample_fallback`: DB 없이 하드코딩된 샘플 사용
- `🔍 vector`: Vectorize 벡터 검색 사용 (준비 중)

#### 2. 점수 분해 (TOP3)
각 TOP3 직업의 점수 분해:
```
1. 데이터 과학자 (Fit: 75)
   Base: L55/C70/R10 → Final: L65/C75/R10
   Like ↑: profile.interest.keywords
   Can ↑: profile.workstyle.social
```

#### 3. Follow-up 근거
다음 질문의 근거:
- Split Attr: 어떤 속성이 분별력이 높은지
- Gain: 질문의 정보 이득 점수
- Reason: 질문 생성 이유

#### 4. Rank Change
답변 전후 TOP3 비교:
```
Before: 데이터분석가 → 연구원 → 컨설턴트
After: 연구원 → 데이터분석가 → 교육전문가
```

#### 5. Applied Facts & Rules
적용된 사용자 정보:
```
profile.interest.keywords: tech, creative (applied)
priority.top1: growth (applied)
profile.constraints.time: work_hours_strict (stored)
```

#### 6. 버전 정보
```
recipe: v0.2.1 | tagger: tagger-v1.0.0 | scoring: v0.1.0 | embedding: none
```

#### Phase4 상태
```
Diversity Guard: ✓ 적용됨
Research Bias Cap: ✓ 적용됨
변경: [연구직 → 서비스직으로 교체]
```

---

## 📊 Phase별 테스트 체크리스트

### Phase 0: 저장 확인

**테스트 목표:** 이벤트와 데이터가 DB에 저장되는지

**테스트 방법:**
1. `/analyzer/job?debug=true` 접속
2. Stage 선택 후 Universal 질문 답변
3. "바로 결과 보기" 클릭

**확인 사항:**
```bash
# raw_events 확인
npx wrangler d1 execute careerwiki --local --command="SELECT * FROM raw_events ORDER BY id DESC LIMIT 5"

# facts 확인
npx wrangler d1 execute careerwiki --local --command="SELECT * FROM facts ORDER BY id DESC LIMIT 5"
```

- [ ] `STAGE_SELECTED` 이벤트 저장됨
- [ ] `UNIVERSAL_SUBMITTED` 이벤트 저장됨
- [ ] `facts` 테이블에 사용자 답변 저장됨

### Phase 1: 태깅 연동 확인

**테스트 목표:** job_attributes 데이터가 점수에 반영되는지

**테스트 방법:**
1. 디버그 모드로 분석 실행
2. 디버그 패널 확인

**확인 사항:**
- [ ] Candidate Source가 `tagged (DB)` 표시
- [ ] tagged_count > 0
- [ ] TOP3 직업이 태깅된 직업 중에서 선정됨

### Phase 2: 점수 분해 확인

**테스트 목표:** Like/Can/Risk 점수가 올바르게 계산되는지

**테스트 방법:**
1. 특정 답변 조합으로 분석 실행
2. 디버그 패널에서 점수 분해 확인

**확인 사항:**
- [ ] Base 점수와 Final 점수가 다름 (보정 적용됨)
- [ ] Applied Rules에 해당 fact_key 표시
- [ ] 점수 변화가 논리적 (관심사와 매칭되는 직업이 Like↑)

### Phase 3: Follow-up 질문 확인

**테스트 방법:**
1. "더 정확한 추천 받기" 클릭
2. Follow-up 질문 확인
3. 답변 후 Rank Change 확인

**확인 사항:**
- [ ] Stage에 맞는 질문 생성 (`job_explore`는 경험 질문 없음)
- [ ] 답변 후 TOP3 순위 변경됨
- [ ] Rank Change에 변경 내역 표시

### Phase 4: Diversity Guard 확인

**테스트 목표:** Research Bias 방지 및 다양성 보장

**테스트 시나리오:**
```
Universal 답변:
- 관심: 분석, 연구
- 우선순위: 성장
```

**확인 사항:**
- [ ] TOP3에 동일 클러스터 직업이 1개 이하
- [ ] Phase4 상태에 Diversity Guard 표시
- [ ] 연구직만 3개 추천되지 않음

---

## 🧪 캘리브레이션 시나리오

### 시나리오 1: 탐색 단계 - WLB 우선

```json
{
  "stage": "job_explore",
  "universal_answers": {
    "univ_priority": "wlb",
    "univ_workstyle_social": "mixed",
    "univ_constraint_time": ["work_hours_strict"]
  }
}
```

**기대 결과:**
- TOP3에 야근 많은 직업 없음
- WLB 점수 높은 직업 우선

### 시나리오 2: 학생 단계 - 성장 중시

```json
{
  "stage": "job_student",
  "universal_answers": {
    "univ_interest": ["tech", "numbers"],
    "univ_priority": "growth",
    "univ_strength": ["analysis", "learning"]
  }
}
```

**기대 결과:**
- 성장 가능성 높은 IT/분석 직업 추천
- Research Bias 방지 작동 (연구직만 3개 아님)

### 시나리오 3: 제약 조건 테스트

```json
{
  "stage": "job_early",
  "universal_answers": {
    "univ_constraint_location": ["travel_no"],
    "univ_constraint_time": ["shift_work_no"]
  }
}
```

**기대 결과:**
- 출장 잦은 직업 제외
- 교대근무 직업 제외

---

## 🔧 API 직접 테스트

### PowerShell 사용

```powershell
# V3 분석 요청
$body = @{
  session_id = "test-$(Get-Date -Format 'HHmmss')"
  stage = "job_explore"
  universal_answers = @{
    univ_interest = @("tech", "creative")
    univ_priority = "growth"
  }
  debug = $true
} | ConvertTo-Json -Depth 3

Invoke-RestMethod -Uri "http://localhost:3000/api/ai-analyzer/analyze" -Method Post -ContentType "application/json" -Body $body | ConvertTo-Json -Depth 10
```

### 응답 확인 포인트

```json
{
  "result": {
    "engine_state": "phase2_stage_based",
    "total_candidates": 80,
    "fit_top3": [...],
    "debug_info": {
      "candidate_source": "tagged",
      "tagged_count": 403,
      "score_breakdown": [...],
      "diversity_guard_triggered": true
    }
  }
}
```

---

## 🚨 트러블슈팅

### 문제: Candidate Source가 `sample_fallback`

**원인:** job_attributes 테이블에 데이터 없음

**해결:**
```bash
# 태깅 데이터 확인
npx wrangler d1 execute careerwiki --local --command="SELECT COUNT(*) FROM job_attributes WHERE tagger_version = 'tagger-v1.0.0'"

# 0이면 태깅 진행 필요
npx tsx scripts/export-jobs-for-tagging.ts --limit 50
```

### 문제: 점수 변화 없음

**원인:** Fact-Score 매핑 규칙 누락

**확인:**
1. `src/services/ai-analyzer/fact-score-mapping.ts` 확인
2. 해당 fact_key에 대한 규칙 존재 여부 확인

### 문제: Research Bias (연구직 독점)

**원인:** Phase 4 미적용 또는 analytical 점수 과다

**확인:**
```powershell
# Phase 4 메트릭 확인
Invoke-RestMethod -Uri "http://localhost:3000/admin/api/ai/metrics?days=1"
```

---

## 📈 메트릭 확인

### 관리자 대시보드

```
http://localhost:3000/admin/ai-analyzer
```

### API 메트릭

```powershell
# Phase 4 발동률
Invoke-RestMethod -Uri "http://localhost:3000/admin/api/ai/metrics?days=7"
```

출력 예시:
```json
{
  "diversity_guard_rate": 0.45,
  "research_bias_cap_rate": 0.12,
  "phase4_applied_rate": 1.0,
  "total_analyses": 150
}
```

---

## 🔗 관련 파일

| 파일 | 용도 |
|------|------|
| `src/services/ai-analyzer/routes.ts` | API 라우트 |
| `src/services/ai-analyzer/fact-score-mapping.ts` | 점수 계산 |
| `src/services/ai-analyzer/safe-replacement.ts` | Phase 4 로직 |
| `scripts/run-calibration.ts` | 자동 캘리브레이션 |
| `src/index.tsx` (line 1714+) | 테스트 UI |
