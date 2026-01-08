# 직업 태깅 프롬프트 템플릿

## 📋 개요

이 템플릿은 Cursor/Grok 등 LLM에 직업 데이터를 태깅할 때 사용합니다.
일관된 점수 스케일과 명확한 근거를 확보하기 위해 작성되었습니다.

---

## 🎯 태깅 프롬프트

```
당신은 CareerWiki의 직업 속성 태거입니다.
주어진 직업 정보를 분석하여 구조화된 속성을 추출하세요.

### 중요 규칙
1. 증거가 명확할 때만 높은 신뢰도(>0.9)를 부여하세요
2. 제약 관련 필드(degree_required, license_required, remote_possible, work_hours, shift_work)는 false positive를 최소화하세요
3. 정보가 없거나 불확실하면 중간값(50)과 낮은 신뢰도(0.5-0.7)를 사용하세요
4. 각 필드에 대해 근거(evidence)를 간결하게 제시하세요 (최대 200자)

### 점수 스케일 앵커

| 필드 | 0점 | 50점 | 100점 |
|------|-----|------|-------|
| wlb | 거의 항상 야근/교대/콜 | 주 1-2회 야근 | 정시 퇴근/예측 가능 |
| growth | 반복업무 위주 | 일부 학습 기회 | 학습/승진/스코프 확장 매우 큼 |
| stability | 프리랜서/계약직 위주 | 혼합 | 정규직/공무원급 안정 |
| income | 최저임금 수준 | 중간 | 상위 10% |
| teamwork | 완전 독립 작업 | 협업 반반 | 팀 중심 |
| solo_deep | 팀 협업 중심 | 혼합 | 혼자 깊이 파는 작업 |
| analytical | 분석 거의 없음 | 일부 분석 | 분석이 핵심 |
| creative | 정해진 절차대로 | 일부 창의성 | 창의성이 핵심 |
| execution | 기획 위주 | 혼합 | 실행/구현 위주 |
| people_facing | 고객 대면 없음 | 일부 대면 | 대부분 대면 |

### Enum 값 정의

- **work_hours**: `regular` (정시) | `overtime_some` (가끔 야근) | `overtime_frequent` (상시 야근)
- **shift_work**: `none` (없음) | `possible` (가능) | `required` (필수)
- **travel**: `none` (없음) | `some` (가끔) | `frequent` (잦음)
- **remote_possible**: `none` (불가) | `partial` (부분 가능) | `full` (완전 재택)
- **degree_required**: `none` | `college` (전문대) | `bachelor` (학사) | `master` (석사) | `phd` (박사)
- **license_required**: `none` | `preferred` (우대) | `required` (필수) | `multiple_required` (복수 필수)

### 출력 JSON 스키마

{
  "job_id": "string",
  "job_name": "string",
  "source_system": "CAREERNET" | "WORK24_JOB" | "MERGED",
  "tagger_version": "tagger-v1.0.0",
  "status": "tagged",
  
  "wlb": 0-100,
  "work_hours": "regular" | "overtime_some" | "overtime_frequent",
  "shift_work": "none" | "possible" | "required",
  "travel": "none" | "some" | "frequent",
  "remote_possible": "none" | "partial" | "full",
  
  "growth": 0-100,
  "stability": 0-100,
  "income": 0-100,
  
  "teamwork": 0-100,
  "solo_deep": 0-100,
  "analytical": 0-100,
  "creative": 0-100,
  "execution": 0-100,
  "people_facing": 0-100,
  
  "degree_required": "none" | "college" | "bachelor" | "master" | "phd",
  "license_required": "none" | "preferred" | "required" | "multiple_required",
  
  "_confidence": 0.0-1.0,
  "_field_confidence": {
    "wlb": 0.0-1.0,
    "growth": 0.0-1.0,
    ...
  },
  "evidence": {
    "wlb": "근거 텍스트 (최대 200자)",
    "degree_required": "근거 텍스트",
    ...
  }
}

### 직업 정보

[여기에 직업 정보를 붙여넣으세요]

---

위 직업에 대해 JSON 형식으로 태깅 결과를 생성해주세요.
설명 없이 JSON만 출력하세요.
```

---

## 📝 사용 방법

### 1. 직업 데이터 추출

```bash
npx tsx scripts/export-jobs-for-tagging.ts --limit 50
```

### 2. Cursor/Grok에서 태깅

1. 위 프롬프트를 복사
2. `[여기에 직업 정보를 붙여넣으세요]` 부분에 직업 정보 추가
3. LLM 응답에서 JSON 추출

### 3. 결과 저장

태깅 결과를 `tagging-results.json` 파일에 저장:

```json
[
  { "job_id": "data-analyst", "job_name": "데이터 분석가", ... },
  { "job_id": "software-developer", "job_name": "소프트웨어 개발자", ... }
]
```

### 4. SQL 생성 및 적용

```bash
npx tsx scripts/generate-tagging-sql.ts --input tagging-results.json
npx wrangler d1 execute careerwiki-db --local --file migrations/batch_tagging_YYYYMMDD.sql
```

---

## ⚠️ 주의사항

1. **일관성 유지**: 같은 유형의 직업은 비슷한 점수를 받아야 함
2. **증거 기반**: 추측보다는 제공된 텍스트에서 근거를 찾기
3. **제약 필드 보수적**: false positive가 사용자 경험에 큰 영향
4. **필드당 최대 2개 근거**: 너무 많은 근거는 노이즈

---

## 📊 예시

### 입력

```json
{
  "job_id": "data-scientist",
  "job_name": "데이터 과학자",
  "content": {
    "duties": "빅데이터 분석, 머신러닝 모델 개발, 인사이트 도출 및 보고",
    "environment": "IT기업, 연구소, 대기업 데이터팀에서 근무. 재택 가능한 곳 많음.",
    "qualifications": "석사 이상 선호, 통계학/수학/컴퓨터공학 전공 우대",
    "salary_info": "연봉 6,000-15,000만원 수준"
  }
}
```

### 출력

```json
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
  "_field_confidence": {
    "wlb": 0.75,
    "growth": 0.9,
    "analytical": 0.95,
    "degree_required": 0.8
  },
  "evidence": {
    "wlb": "IT기업 환경, 재택 가능으로 양호한 WLB 예상",
    "analytical": "빅데이터 분석, 머신러닝 모델 개발이 핵심 업무",
    "degree_required": "석사 이상 선호 명시"
  }
}
```

---

## 🔄 버전 관리

- 현재 버전: `tagger-v1.0.0`
- 업데이트 시 버전 번호 변경 필수
- 변경 내역은 이 파일 하단에 기록
