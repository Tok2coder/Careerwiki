# Fact → Job Field 매핑 테이블 v0.1.1

> 작성일: 2026-01-02
> 버전: mapping-v0.1.1
> 목적: 유저 입력(Fact)과 직업 속성(Job Attributes) 간 매핑 정의
> v0.1.1 변경: Like/Risk 역할 분리 (중복 감점 방지)

---

## 1. 개요

### 1.1 목적
유저가 입력한 정보(Fact)를 직업 데이터의 어떤 필드/태그와 비교하여 점수를 계산하는지 명시

### 1.2 매핑 구조
```
User Fact (유저 입력)
    ↓ 변환/매핑
Job Field/Attribute (직업 속성)
    ↓ 비교
Score Contribution (점수 기여)
```

---

## 2. Like 점수용 매핑

### 2.1 흥미 매칭 (40점)

| User Fact | 변환 | Job Attribute | 비교 방식 |
|-----------|------|---------------|----------|
| `interest.keywords[]` | Holland 코드 변환 | `job_attributes.interest_tags[]` | 교집합 크기 |

**변환 테이블 (키워드 → Holland 코드)**:

| 유저 키워드 (예시) | 변환 태그 |
|-------------------|----------|
| AI, 인공지능, 머신러닝 | `investigative` |
| 데이터, 분석, 통계 | `investigative` |
| 연구, 실험, 과학 | `investigative` |
| 창작, 디자인, 예술 | `artistic` |
| 글쓰기, 영상, 콘텐츠 | `artistic` |
| 음악, 연기, 공연 | `artistic` |
| 사람, 상담, 심리 | `social` |
| 교육, 가르치기, 멘토링 | `social` |
| 의료, 돌봄, 복지 | `social` |
| 경영, 리더십, 창업 | `enterprising` |
| 영업, 마케팅, 설득 | `enterprising` |
| 정치, 협상, 외교 | `enterprising` |
| 기계, 제조, 수리 | `realistic` |
| 건축, 건설, 현장 | `realistic` |
| 스포츠, 운동, 야외 | `realistic` |
| 회계, 행정, 사무 | `conventional` |
| 관리, 정리, 체계화 | `conventional` |
| 법률, 규정, 절차 | `conventional` |

**점수 계산**:
```typescript
const score = Math.min(
  (overlap.length / Math.min(userTags.length, 4)) * 40,
  40
)
```

---

### 2.2 가치관 매칭 (30점)

| User Fact | 변환 | Job Attribute | 비교 방식 |
|-----------|------|---------------|----------|
| `value.priority[]` | 태그 변환 | `job_attributes.values_tags[]` | 교집합 크기 |

**변환 테이블 (가치관 → 태그)**:

| 유저 입력 (예시) | 변환 태그 |
|-----------------|----------|
| 안정, 정규직, 공무원, 평생직장 | `stability` |
| 성장, 배움, 발전, 커리어 | `growth` |
| 돈, 연봉, 수입, 부자 | `money` |
| 사회공헌, 영향력, 의미, 보람 | `impact` |
| 자율, 자유, 재택, 프리랜서 | `autonomy` |
| 인정, 명예, 존경, 권위 | `recognition` |
| 창의, 아이디어, 혁신 | `creativity` |
| 워라밸, 가정, 여가, 취미 | `work_life_balance` |
| 전문성, 기술, 깊이 | `expertise` |
| 변화, 다양성, 새로움 | `variety` |

**점수 계산**:
```typescript
const score = Math.min(
  (overlap.length / Math.min(userTags.length, 3)) * 30,
  30
)
```

---

### 2.3 싫은 것 회피 (30점)

> ⚠️ **v0.2.1 변경**: 싫은 것 중 "현실 제약"은 Risk에서 처리 (중복 감점 방지)

| User Fact | Job Field | 비교 방식 |
|-----------|-----------|----------|
| `dislike.keywords[]` (취향) | 텍스트: `summary`, `duties`, `environment` | 텍스트 포함 여부 |
| `dislike.keywords[]` (취향) | 태그: `job_attributes.work_style[]` | 태그 충돌 |

**싫은 것 분류 (Like vs Risk)**:

| 분류 | 싫은 것 키워드 | 처리 위치 |
|------|--------------|----------|
| **취향 (Like)** | 반복, 단순, 사람, 고객응대, 육체노동, 스트레스, 책임, 숫자 | Like 감점 |
| **현실 제약 (Risk)** | 야근, 교대, 출장, 재택불가, 현장근무 | **Risk에서만 처리** |

> Like에서 야근/교대/출장 감점 안 함 → Risk에서 40점 감점만

**싫은 것 → 검사 대상 매핑 (취향만)**:

| 유저 싫은 것 (취향) | 검사 대상 | Like 감점 |
|-------------------|----------|----------|
| 반복, 단순, 루틴 | 텍스트 검색 | -10 |
| 사람, 대면, 고객응대 | `work_style` ∋ `people` | -10 |
| 육체노동, 힘든일 | `work_style` ∋ `physical` | -10 |
| 스트레스, 압박, 긴장 | 텍스트 검색 | -10 |
| 책임, 결정, 리더 | `work_style` ∋ `management` | -10 |
| ~~야근, 교대, 출장~~ | ~~`wlb`, `environment`~~ | **Risk로 이동** |

**점수 계산 (v0.2.1)**:
```typescript
// 1. 싫은 것 분류
const { forLike, forRisk } = separateDislikeKeywords(userDislikes)

// 2. Like에서는 취향만 감점
let penalty = 0
for (const dislike of forLike) {  // forRisk 제외!
  if (matchesDislike(job, dislike)) {
    penalty += 10
  }
}
const score = Math.max(30 - penalty, 0)

// forRisk는 Risk 계산에서 별도 처리
```

---

## 3. Can 점수용 매핑

### 3.1 스킬 매칭 (60점)

| User Fact | Job Attribute | 비교 방식 |
|-----------|---------------|----------|
| `skill[].name` | `job_attributes.core_skills.detailed[]` | 스킬 존재 여부 |
| `skill[].name` | `job_attributes.core_skills.categories[]` | 카테고리 매칭 |
| `skill[].level` | (가중치) | 레벨별 가중치 |

**스킬 → 카테고리 매핑** (세부 스킬이 없을 때 폴백):

| 유저 스킬 | 카테고리 |
|----------|----------|
| python, javascript, sql, java | `technical` |
| 발표, 협상, 글쓰기, 커뮤니케이션 | `communication` |
| 데이터분석, 논리, 문제해결 | `analysis` |
| 디자인, 기획, UX | `creative` |
| 관리, 조직, 팀리딩 | `leadership` |
| 상담, 설득, 서비스 | `interpersonal` |

**레벨 가중치**:
| Level | Weight |
|-------|--------|
| `beginner` | 0.5 |
| `intermediate` | 0.8 |
| `advanced` | 1.0 |

**점수 계산**:
```typescript
let rawScore = 0
for (const { name, level } of userSkills) {
  if (jobSkills.detailed.includes(name) || jobSkills.categories.includes(mapToCategory(name))) {
    rawScore += 15 * levelWeight[level]
  }
}
const score = Math.min((rawScore / (Math.min(userSkills.length, 4) * 15)) * 60, 60)
```

---

### 3.2 경험/학습가능성 (40점)

| User Fact | Job Attribute | 비교 방식 |
|-----------|---------------|----------|
| `evidence.projects[]` | `summary`, `duties` | 키워드 유사도 |
| `evidence.experience[]` | `summary`, `duties` | 키워드 유사도 |
| `constraint.learning_window_months` | `entry_requirements.estimated_learning_months` | 숫자 비교 |

**경험 관련성 판단**:
```typescript
function hasRelatedExperience(user: User, job: Job): boolean {
  const userKeywords = extractKeywords([
    ...user.evidence.projects,
    ...user.evidence.experience
  ])
  const jobKeywords = extractKeywords([job.summary, job.duties])
  
  const overlap = intersection(userKeywords, jobKeywords)
  return overlap.length >= 2  // 2개 이상 키워드 겹침
}
```

**학습 가능성 판단**:
```typescript
function canLearnInTime(user: User, job: Job): boolean {
  const required = job.job_attributes.entry_requirements.estimated_learning_months
  const available = user.constraint.learning_window_months
  
  if (required === 'unknown' || available === undefined) return true  // 정보 없으면 통과
  return available >= required
}
```

**점수 계산**:
```typescript
const experienceScore = hasRelatedExperience(user, job) ? 20 : 10
const learningScore = canLearnInTime(user, job) ? 20 : 5
const score = experienceScore + learningScore
```

---

## 4. Risk 판단용 매핑

### 4.1 절대 조건 → 직업 속성 매핑

| User Constraint | Job Attribute | RISK 조건 | UNKNOWN 조건 |
|-----------------|---------------|-----------|--------------|
| `work_hours_strict = true` | `wlb` | `= 'high_overtime'` or `= 'shift_work'` | `= 'unknown'` |
| `remote_only = true` | `environment[]` | `!includes('remote_possible')` | `= []` or 없음 |
| `degree_impossible = true` | `entry_requirements.degree_required` | `= true` | `= 'unknown'` |
| `license_impossible = true` | `entry_requirements.license_required` | `= true` | `= 'unknown'` |
| `shift_work_no = true` | `wlb` | `= 'shift_work'` | `= 'unknown'` |

### 4.2 Risk 판단 함수

```typescript
interface RiskCheck {
  constraint: string
  jobAttribute: string
  status: 'OK' | 'UNKNOWN' | 'RISK'
  penalty: number
}

function checkWorkHoursRisk(userStrict: boolean, jobWlb: WLB): RiskCheck {
  if (!userStrict) return { constraint: 'work_hours', jobAttribute: 'wlb', status: 'OK', penalty: 0 }
  
  if (jobWlb === 'high_overtime' || jobWlb === 'shift_work') {
    return { constraint: 'work_hours', jobAttribute: 'wlb', status: 'RISK', penalty: 25 }
  }
  if (jobWlb === 'unknown') {
    return { constraint: 'work_hours', jobAttribute: 'wlb', status: 'UNKNOWN', penalty: 5 }
  }
  return { constraint: 'work_hours', jobAttribute: 'wlb', status: 'OK', penalty: 0 }
}

function checkRemoteRisk(userRemoteOnly: boolean, jobEnv: Environment[]): RiskCheck {
  if (!userRemoteOnly) return { constraint: 'remote_only', jobAttribute: 'environment', status: 'OK', penalty: 0 }
  
  if (!jobEnv || jobEnv.length === 0) {
    return { constraint: 'remote_only', jobAttribute: 'environment', status: 'UNKNOWN', penalty: 5 }
  }
  if (!jobEnv.includes('remote_possible')) {
    return { constraint: 'remote_only', jobAttribute: 'environment', status: 'RISK', penalty: 25 }
  }
  return { constraint: 'remote_only', jobAttribute: 'environment', status: 'OK', penalty: 0 }
}

function checkDegreeRisk(userDegreeImpossible: boolean, jobDegreeRequired: boolean | 'preferred' | 'unknown'): RiskCheck {
  if (!userDegreeImpossible) return { constraint: 'degree_impossible', jobAttribute: 'degree_required', status: 'OK', penalty: 0 }
  
  if (jobDegreeRequired === true) {
    return { constraint: 'degree_impossible', jobAttribute: 'degree_required', status: 'RISK', penalty: 25 }
  }
  if (jobDegreeRequired === 'unknown') {
    return { constraint: 'degree_impossible', jobAttribute: 'degree_required', status: 'UNKNOWN', penalty: 5 }
  }
  return { constraint: 'degree_impossible', jobAttribute: 'degree_required', status: 'OK', penalty: 0 }
}

function checkLicenseRisk(userLicenseImpossible: boolean, jobLicenseRequired: boolean | 'preferred' | 'unknown'): RiskCheck {
  if (!userLicenseImpossible) return { constraint: 'license_impossible', jobAttribute: 'license_required', status: 'OK', penalty: 0 }
  
  if (jobLicenseRequired === true) {
    return { constraint: 'license_impossible', jobAttribute: 'license_required', status: 'RISK', penalty: 25 }
  }
  if (jobLicenseRequired === 'unknown') {
    return { constraint: 'license_impossible', jobAttribute: 'license_required', status: 'UNKNOWN', penalty: 5 }
  }
  return { constraint: 'license_impossible', jobAttribute: 'license_required', status: 'OK', penalty: 0 }
}
```

---

## 5. 매핑 요약 테이블

### 5.1 전체 매핑 한눈에 보기

| 점수 종류 | User Fact | Job Field/Attribute | 점수 기여 |
|----------|-----------|---------------------|----------|
| **Like** | `interest.keywords` | `interest_tags` | 최대 40점 |
| **Like** | `value.priority` | `values_tags` | 최대 30점 |
| **Like** | `dislike.keywords` | 텍스트 + 태그 | 최대 30점 |
| **Can** | `skill[].name/level` | `core_skills` | 최대 60점 |
| **Can** | `evidence.*` | `summary`, `duties` | 최대 20점 |
| **Can** | `constraint.learning_window_months` | `estimated_learning_months` | 최대 20점 |
| **Risk** | `constraint.work_hours_strict` | `wlb` | -25 or -5 |
| **Risk** | `constraint.remote_only` | `environment` | -25 or -5 |
| **Risk** | `constraint.degree_impossible` | `degree_required` | -25 or -5 |
| **Risk** | `constraint.license_impossible` | `license_required` | -25 or -5 |

---

## 6. 근거 링크 생성

### 6.1 Evidence Link 구조

```typescript
interface EvidenceLink {
  userFactKey: string
  userFactValue: string | string[]
  jobField: string
  jobFieldValue: string | string[]
  matchType: 'exact' | 'category' | 'contains' | 'conflict'
  scoreType: 'like' | 'can' | 'risk'
  scoreContribution: number
}
```

### 6.2 Evidence Link 생성 예시

```typescript
// Like - 흥미 매칭
{
  userFactKey: 'interest.keywords',
  userFactValue: ['AI', '데이터분석'],
  jobField: 'job_attributes.interest_tags',
  jobFieldValue: ['investigative', 'conventional'],
  matchType: 'category',
  scoreType: 'like',
  scoreContribution: 20
}

// Can - 스킬 매칭
{
  userFactKey: 'skill',
  userFactValue: ['python (advanced)', 'sql (intermediate)'],
  jobField: 'job_attributes.core_skills.detailed',
  jobFieldValue: ['python', 'sql', 'data_analysis'],
  matchType: 'exact',
  scoreType: 'can',
  scoreContribution: 27
}

// Risk - 야근 충돌
{
  userFactKey: 'constraint.work_hours_strict',
  userFactValue: '야근 절대 불가',
  jobField: 'job_attributes.wlb',
  jobFieldValue: 'high_overtime',
  matchType: 'conflict',
  scoreType: 'risk',
  scoreContribution: -25
}
```

---

## 7. 버전 관리

### 7.1 현재 버전
- **mapping_version**: `mapping-v0.1.0`
- **적용일**: 2026-01-02

### 7.2 변경 시 영향
매핑 변경 시:
1. 점수 계산 결과 달라짐
2. `scoring_version` 함께 업데이트 필요
3. 기존 분석 결과와 비교 불가 (버전 명시로 구분)

---

## 8. 확장 예정 (v0.2)

- [ ] 벡터 유사도 기반 흥미/가치관 매칭
- [ ] 세부 스킬 동적 확장 (DB에서 학습)
- [ ] 지역 제약 매핑 추가
- [ ] 연봉 기대치 매핑 추가

