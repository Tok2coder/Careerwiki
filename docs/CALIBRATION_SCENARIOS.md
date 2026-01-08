# 캘리브레이션 시나리오 20개

> **목적**: 태깅 500개 완료 후 스코어링 품질/일관성 검증  
> **버전**: v1.0.0  
> **사용 시점**: Coverage Set 태깅 완료 후 Phase 5 선행 QA

---

## 1. 개요

### 1.1 캘리브레이션이란?

태깅 데이터가 스코어링에 제대로 반영되는지 확인하는 과정:
1. **정해진 시나리오**로 분석 요청
2. **예상 결과**와 **실제 결과** 비교
3. **오차가 크면** 스코어 룰/룩업 테이블 튜닝

### 1.2 합격 기준

| 지표 | 합격선 |
|------|--------|
| TOP3 Caution 포함률 | 10~30% |
| TOP3 품질 (시나리오 부합도) | 70%+ |
| Follow-up 질문 적합성 | 80%+ |
| Applied Facts 설명 가능성 | 90%+ |

---

## 2. Stage별 시나리오 (20개)

### 2.1 job_explore (탐색, 무경험) - 3개

#### 시나리오 E1: 기술 호기심 학생
```json
{
  "scenario_id": "E1",
  "stage": "job_explore",
  "name": "기술 호기심 학생",
  "universal_answers": {
    "univ_interest": ["tech", "numbers"],
    "univ_dislike": ["people"],
    "univ_workstyle_social": "solo",
    "univ_priority": "growth"
  },
  "expected_top3_contains": ["개발자", "데이터", "연구"],
  "expected_top3_avoids": ["영업", "서비스", "간호"],
  "expected_followup_type": ["discovery", "projection"]
}
```

#### 시나리오 E2: 예술 지향 학생
```json
{
  "scenario_id": "E2",
  "stage": "job_explore",
  "name": "예술 지향 학생",
  "universal_answers": {
    "univ_interest": ["art", "media"],
    "univ_dislike": ["numbers", "routine"],
    "univ_workstyle_social": "team",
    "univ_priority": "autonomy"
  },
  "expected_top3_contains": ["디자인", "미디어", "창작"],
  "expected_top3_avoids": ["회계", "사무", "공장"],
  "expected_followup_type": ["discovery", "projection"]
}
```

#### 시나리오 E3: 사람 좋아하는 학생
```json
{
  "scenario_id": "E3",
  "stage": "job_explore",
  "name": "사람 좋아하는 학생",
  "universal_answers": {
    "univ_interest": ["people", "health"],
    "univ_dislike": ["tech"],
    "univ_workstyle_social": "team",
    "univ_priority": "impact"
  },
  "expected_top3_contains": ["교육", "상담", "의료", "사회복지"],
  "expected_top3_avoids": ["개발자", "DBA", "보안"],
  "expected_followup_type": ["discovery"]
}
```

---

### 2.2 job_student (학생/전공연계) - 3개

#### 시나리오 S1: 컴공 전공 학생
```json
{
  "scenario_id": "S1",
  "stage": "job_student",
  "name": "컴공 전공 학생",
  "universal_answers": {
    "univ_interest": ["tech", "numbers"],
    "univ_workstyle_social": "solo",
    "univ_priority": "income",
    "univ_constraint_location": "big_city"
  },
  "expected_top3_contains": ["소프트웨어", "데이터", "AI"],
  "expected_top3_avoids": ["현장직", "서비스"],
  "expected_followup_type": ["clarification", "tradeoff"]
}
```

#### 시나리오 S2: 간호학과 학생
```json
{
  "scenario_id": "S2",
  "stage": "job_student",
  "name": "간호학과 학생",
  "universal_answers": {
    "univ_interest": ["health", "people"],
    "univ_workstyle_social": "team",
    "univ_priority": "stability",
    "univ_life_constraint": ["none"]
  },
  "expected_top3_contains": ["간호사", "보건", "의료"],
  "expected_top3_avoids": ["개발자", "영업"],
  "expected_followup_type": ["clarification"]
}
```

#### 시나리오 S3: 경영학과 학생
```json
{
  "scenario_id": "S3",
  "stage": "job_student",
  "name": "경영학과 학생",
  "universal_answers": {
    "univ_interest": ["business"],
    "univ_dislike": ["tech"],
    "univ_workstyle_social": "team",
    "univ_priority": "growth"
  },
  "expected_top3_contains": ["마케팅", "인사", "기획", "컨설팅"],
  "expected_top3_avoids": ["개발자", "연구원"],
  "expected_followup_type": ["tradeoff", "priority"]
}
```

---

### 2.3 job_prepare (취업준비) - 3개

#### 시나리오 P1: 워라밸 중시 취준생
```json
{
  "scenario_id": "P1",
  "stage": "job_prepare",
  "name": "워라밸 중시 취준생",
  "universal_answers": {
    "univ_interest": ["tech"],
    "univ_priority": "wlb",
    "univ_constraint_time": "no_overtime",
    "univ_life_constraint": ["caregiving"]
  },
  "expected_top3_avoids_attributes": {
    "work_hours": "overtime_frequent",
    "shift_work": "required"
  },
  "expected_followup_type": ["clarification", "tradeoff"]
}
```

#### 시나리오 P2: 고연봉 추구 취준생
```json
{
  "scenario_id": "P2",
  "stage": "job_prepare",
  "name": "고연봉 추구 취준생",
  "universal_answers": {
    "univ_interest": ["business", "numbers"],
    "univ_priority": "income",
    "univ_workstyle_social": "team"
  },
  "expected_top3_contains_attributes": {
    "income": ">= 70"
  },
  "expected_followup_type": ["tradeoff"]
}
```

#### 시나리오 P3: 안정성 추구 취준생
```json
{
  "scenario_id": "P3",
  "stage": "job_prepare",
  "name": "안정성 추구 취준생",
  "universal_answers": {
    "univ_interest": ["education", "people"],
    "univ_priority": "stability",
    "univ_workstyle_social": "solo"
  },
  "expected_top3_contains_attributes": {
    "stability": ">= 70"
  },
  "expected_top3_contains": ["공무원", "교사", "공기업"],
  "expected_followup_type": ["tradeoff", "priority"]
}
```

---

### 2.4 job_early (초기 경력 0~3년) - 3개

#### 시나리오 C1: 성장 욕구 주니어
```json
{
  "scenario_id": "C1",
  "stage": "job_early",
  "name": "성장 욕구 주니어",
  "universal_answers": {
    "univ_interest": ["tech", "business"],
    "univ_priority": "growth",
    "univ_workstyle_social": "team"
  },
  "expected_top3_contains_attributes": {
    "growth": ">= 70"
  },
  "expected_followup_type": ["behavior", "tradeoff"]
}
```

#### 시나리오 C2: 번아웃 경험 주니어
```json
{
  "scenario_id": "C2",
  "stage": "job_early",
  "name": "번아웃 경험 주니어",
  "universal_answers": {
    "univ_interest": ["tech"],
    "univ_dislike": ["people", "routine"],
    "univ_priority": "wlb",
    "univ_constraint_time": "no_overtime",
    "univ_life_constraint": ["health"]
  },
  "expected_top3_contains_attributes": {
    "wlb": ">= 60",
    "work_hours": "regular"
  },
  "expected_followup_type": ["clarification"]
}
```

#### 시나리오 C3: 이직 고민 주니어
```json
{
  "scenario_id": "C3",
  "stage": "job_early",
  "name": "이직 고민 주니어",
  "universal_answers": {
    "univ_interest": ["business"],
    "univ_priority": "income",
    "univ_workstyle_social": "team"
  },
  "expected_followup_type": ["behavior", "narrative"]
}
```

---

### 2.5 job_mid (경력 3년+) - 3개

#### 시나리오 M1: 전문성 심화 경력자
```json
{
  "scenario_id": "M1",
  "stage": "job_mid",
  "name": "전문성 심화 경력자",
  "universal_answers": {
    "univ_interest": ["tech", "numbers"],
    "univ_priority": "growth",
    "univ_workstyle_social": "solo"
  },
  "expected_top3_contains_attributes": {
    "solo_deep": ">= 60",
    "analytical": ">= 60"
  },
  "expected_followup_type": ["narrative", "tradeoff"]
}
```

#### 시나리오 M2: 관리자 지향 경력자
```json
{
  "scenario_id": "M2",
  "stage": "job_mid",
  "name": "관리자 지향 경력자",
  "universal_answers": {
    "univ_interest": ["business", "people"],
    "univ_priority": "growth",
    "univ_workstyle_social": "team"
  },
  "expected_top3_contains": ["매니저", "팀장", "관리"],
  "expected_followup_type": ["narrative", "priority"]
}
```

#### 시나리오 M3: 워라밸 전환 경력자
```json
{
  "scenario_id": "M3",
  "stage": "job_mid",
  "name": "워라밸 전환 경력자",
  "universal_answers": {
    "univ_interest": ["tech"],
    "univ_priority": "wlb",
    "univ_constraint_location": "remote_ok",
    "univ_life_constraint": ["caregiving"]
  },
  "expected_top3_contains_attributes": {
    "remote_possible": ["partial", "full"],
    "wlb": ">= 60"
  },
  "expected_followup_type": ["clarification"]
}
```

---

### 2.6 job_transition (전환/복귀) - 3개

#### 시나리오 T1: 육아 후 복귀
```json
{
  "scenario_id": "T1",
  "stage": "job_transition",
  "name": "육아 후 복귀",
  "universal_answers": {
    "univ_interest": ["education", "people"],
    "univ_priority": "wlb",
    "univ_constraint_time": "no_overtime",
    "univ_life_constraint": ["caregiving"]
  },
  "expected_top3_contains_attributes": {
    "wlb": ">= 70",
    "work_hours": "regular"
  },
  "expected_followup_type": ["clarification", "priority"]
}
```

#### 시나리오 T2: 직무 전환 희망
```json
{
  "scenario_id": "T2",
  "stage": "job_transition",
  "name": "직무 전환 희망 (영업→마케팅)",
  "universal_answers": {
    "univ_interest": ["business", "media"],
    "univ_dislike": ["people"],
    "univ_priority": "growth"
  },
  "expected_top3_contains": ["마케팅", "기획", "콘텐츠"],
  "expected_top3_avoids": ["영업", "고객응대"],
  "expected_followup_type": ["narrative", "behavior"]
}
```

#### 시나리오 T3: 산업 전환 희망
```json
{
  "scenario_id": "T3",
  "stage": "job_transition",
  "name": "산업 전환 희망 (제조→IT)",
  "universal_answers": {
    "univ_interest": ["tech"],
    "univ_priority": "growth",
    "univ_workstyle_social": "team"
  },
  "expected_top3_contains": ["IT", "개발", "데이터"],
  "expected_followup_type": ["behavior", "narrative"]
}
```

---

### 2.7 job_second (세컨드 커리어) - 2개

#### 시나리오 SC1: 은퇴 후 가벼운 일
```json
{
  "scenario_id": "SC1",
  "stage": "job_second",
  "name": "은퇴 후 가벼운 일",
  "universal_answers": {
    "univ_interest": ["education", "people"],
    "univ_priority": "wlb",
    "univ_constraint_time": "part_time",
    "univ_life_constraint": ["health"]
  },
  "expected_top3_contains_attributes": {
    "wlb": ">= 70"
  },
  "expected_top3_avoids_attributes": {
    "work_hours": "overtime_frequent"
  },
  "expected_followup_type": ["clarification"]
}
```

#### 시나리오 SC2: 의미 있는 일 추구
```json
{
  "scenario_id": "SC2",
  "stage": "job_second",
  "name": "의미 있는 일 추구",
  "universal_answers": {
    "univ_interest": ["education", "health"],
    "univ_priority": "impact",
    "univ_workstyle_social": "team"
  },
  "expected_top3_contains": ["사회복지", "상담", "교육", "NGO"],
  "expected_followup_type": ["priority", "narrative"]
}
```

---

## 3. 검증 방법

### 3.1 자동 검증 스크립트

```bash
# 시나리오 실행
npx tsx scripts/calibration/run-scenarios.ts

# 결과 리포트 생성
npx tsx scripts/calibration/generate-report.ts
```

### 3.2 수동 검증 체크리스트

각 시나리오에 대해:

- [ ] TOP3에 예상 직업군이 포함되는가?
- [ ] TOP3에 회피해야 할 직업군이 없는가?
- [ ] Follow-up 질문이 Stage에 적합한가?
- [ ] Applied facts/rules가 설명 가능한가?
- [ ] 디버그 패널의 점수 분해가 합리적인가?

### 3.3 튜닝 대상

검증 실패 시:

| 문제 | 튜닝 대상 |
|------|----------|
| 예상 직업 미포함 | `fact-score-mapping.ts` 매핑 룰 |
| 회피 직업 포함 | Risk Penalty 조정 |
| Follow-up 부적합 | `question-generation.ts` 로직 |
| 점수 분해 이상 | 태깅 데이터 품질 검토 |

---

## 4. 다음 단계

1. **태깅 500개 완료 후** 이 시나리오들로 캘리브레이션
2. **합격선 미달 시** 스코어 룰/태깅 품질 튜닝
3. **합격 후** Phase 4 Safe 대체 로직 구현
4. **전체 통과 후** 태깅 확장 (500 → 2,000)

---

*Version: v1.0.0*
*Created: 2026-01-05*






