# CareerWiki 직업 태깅 가이드

## 📋 개요

이 문서는 직업 데이터를 수동으로 태깅하는 방법을 설명합니다.
태깅된 데이터는 AI 분석기의 추천 품질을 직접적으로 결정합니다.

---

## 🛠️ 사전 준비

### 1. 프로젝트 설정

```bash
# 프로젝트 폴더로 이동
cd C:\Users\PC\Careerwiki

# 의존성 설치 (최초 1회)
npm install
```

### 2. 로컬 DB 확인

```bash
# DB 테이블 확인
npx wrangler d1 execute careerwiki-db --local --command="SELECT name FROM sqlite_master WHERE type='table'"

# job_attributes 현황 확인
npx wrangler d1 execute careerwiki-db --local --command="SELECT COUNT(*) as total, status FROM job_attributes GROUP BY status"
```

---

## 📝 태깅 프로세스

### Step 1: 태깅 대상 추출

```bash
# 미태깅 직업 50개 추출
npx tsx scripts/export-jobs-for-tagging.ts --limit 50

# 특정 소스만 추출
npx tsx scripts/export-jobs-for-tagging.ts --limit 50 --source CAREERNET

# 다음 배치 (offset 사용)
npx tsx scripts/export-jobs-for-tagging.ts --limit 50 --offset 50 --output jobs_batch2.json
```

결과 파일: `jobs_for_tagging.json`

### Step 2: Cursor/Grok에서 태깅

1. **`docs/TAGGING_PROMPT_TEMPLATE.md`** 열기
2. 프롬프트 복사
3. `jobs_for_tagging.json`에서 직업 정보 붙여넣기
4. LLM 응답에서 JSON 추출

**예시 입력:**
```json
{
  "job_id": "data-scientist",
  "job_name": "데이터 과학자",
  "content": {
    "duties": "빅데이터 분석, 머신러닝 모델 개발, 인사이트 도출 및 보고",
    "environment": "IT기업, 연구소, 대기업 데이터팀에서 근무",
    "qualifications": "석사 이상 선호, 통계학/수학/컴퓨터공학 전공 우대"
  }
}
```

### Step 3: 결과 저장

태깅 결과를 `tagging-results.json`에 저장:

```json
[
  {
    "job_id": "data-scientist",
    "job_name": "데이터 과학자",
    "source_system": "MERGED",
    "tagger_version": "tagger-v1.0.0",
    "status": "tagged",
    "wlb": 65,
    "work_hours": "overtime_some",
    "shift_work": "none",
    "travel": "none",
    "remote_possible": "partial",
    "growth": 85,
    "stability": 70,
    "income": 80,
    "teamwork": 55,
    "solo_deep": 75,
    "analytical": 95,
    "creative": 60,
    "execution": 50,
    "people_facing": 30,
    "degree_required": "master",
    "license_required": "none",
    "_confidence": 0.85,
    "evidence": {
      "analytical": "빅데이터 분석, 머신러닝 모델 개발이 핵심 업무"
    }
  }
]
```

### Step 4: SQL 생성 및 적용

```bash
# SQL 생성
npx tsx scripts/generate-tagging-sql.ts --input tagging-results.json

# 검증 (dry-run)
npx tsx scripts/generate-tagging-sql.ts --input tagging-results.json --dry-run

# 로컬 DB에 적용
npx wrangler d1 execute careerwiki-db --local --file migrations/batch_tagging_YYYYMMDD.sql
```

### Step 5: 검증

```bash
# 태깅 결과 확인
npx wrangler d1 execute careerwiki-db --local --command="SELECT job_id, job_name, wlb, analytical FROM job_attributes WHERE job_id = 'data-scientist'"

# 전체 현황
npx wrangler d1 execute careerwiki-db --local --command="SELECT status, COUNT(*) as count FROM job_attributes GROUP BY status"
```

---

## 📊 태깅 품질 체크리스트

### 필수 확인 사항

- [ ] **점수 일관성**: 같은 유형의 직업은 비슷한 점수
- [ ] **증거 기반**: 각 점수에 대한 근거가 있는가
- [ ] **제약 필드 보수적**: degree_required, license_required는 false positive 최소화
- [ ] **범위 준수**: 0-100 점수, enum 값 정확

### 점수 스케일 참고

| 필드 | 0점 | 50점 | 100점 |
|------|-----|------|-------|
| wlb | 항상 야근 | 가끔 야근 | 정시 퇴근 |
| growth | 반복 업무 | 일부 성장 | 고성장 |
| stability | 불안정 | 보통 | 매우 안정 |
| income | 최저임금 | 중간 | 상위 10% |
| analytical | 없음 | 일부 | 핵심 |
| creative | 정해진 절차 | 일부 창의 | 창의 핵심 |

---

## 🚨 흔한 실수

### 1. 제약 필드 과대 평가

❌ 잘못된 예:
```json
{
  "degree_required": "bachelor",  // 정보 없으면 보수적으로 "none"
  "license_required": "required"  // "우대"면 "preferred", 확실한 경우만 "required"
}
```

✅ 올바른 예:
```json
{
  "degree_required": "none",  // 정보 없으면 기본값
  "license_required": "preferred"  // 우대 사항 → preferred
}
```

### 2. WLB 점수 불일관

- IT 개발자: 보통 50-70
- 공무원: 보통 70-90
- 의료/서비스: 보통 30-50
- 프리랜서: 40-80 (분야 따라 다름)

### 3. 신뢰도 과신

- 정보가 부족하면 `_confidence: 0.5-0.7` 사용
- 모든 필드가 확실해야 `_confidence: 0.9+`

---

## 📈 진행 현황 추적

### 태깅 목표

| 단계 | 목표 | 현황 | 상태 |
|------|------|------|------|
| 1차 | 30개 (골든셋) | 30개 | ✅ |
| 2차 | 300개 (커버리지) | 403개 | ✅ |
| 3차 | 500개 | - | 🔄 |
| 최종 | 7,000개 | - | 📋 |

### 현황 확인 명령어

```bash
# 전체 현황
npx wrangler d1 execute careerwiki-db --local --command="SELECT COUNT(*) FROM job_attributes WHERE status = 'tagged'"

# 소스별 현황
npx wrangler d1 execute careerwiki-db --local --command="SELECT source_system, COUNT(*) FROM job_attributes GROUP BY source_system"
```

---

## 🔗 관련 파일

| 파일 | 용도 |
|------|------|
| `scripts/export-jobs-for-tagging.ts` | 태깅 대상 추출 |
| `scripts/generate-tagging-sql.ts` | SQL 생성 |
| `docs/TAGGING_PROMPT_TEMPLATE.md` | 프롬프트 템플릿 |
| `src/services/ai-analyzer/job-attributes-types.ts` | 스키마 정의 |
