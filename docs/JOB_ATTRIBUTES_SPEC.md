# 직업 속성 태깅 스펙 (Job Attributes Spec) v1.0

> 작성일: 2026-01-02
> 버전: tagger-v1.0.0
> 목적: 자유 텍스트 직업 데이터를 구조화된 태그로 변환

---

## 1. 목적

### 1.1 왜 필요한가?
현재 직업 DB의 주요 필드가 **자유 텍스트**임:
- `interests`: "탐구형(I) + 기업형(E)"
- `personality`: "공감 능력, 책임감..."
- `environment`: "법원·검찰청 출석, 로펌/사무소 근무..."

이 상태로는 **Like/Can/Risk 점수 계산이 어려움**.

### 1.2 목표
직업마다 `job_attributes` 구조화 JSON을 생성하여:
- 유저 fact와 직업 속성 간 **정확한 매칭** 가능
- Risk 판단을 위한 **명시적 속성** 확보
- 점수 계산의 **일관성과 재현성** 보장

---

## 2. 태그 카테고리 정의

### 2.1 work_style (업무 방식)
```typescript
type WorkStyle = 
  | 'analysis'      // 데이터/자료 분석 중심
  | 'people'        // 대인 관계 중심 (상담, 영업, 교육)
  | 'creative'      // 창작/기획 중심
  | 'field'         // 현장/외근 중심
  | 'desk'          // 사무실 업무 중심
  | 'technical'     // 기술/개발/연구 중심
  | 'management'    // 관리/운영 중심
  | 'physical'      // 신체 활동 중심
```

**복수 선택 가능**: 배열로 저장 (예: `["analysis", "desk"]`)

### 2.2 wlb (워라밸)
```typescript
type WLB = 
  | 'low_overtime'      // 야근 적음 (주 45시간 이하)
  | 'moderate'          // 보통 (주 45~55시간)
  | 'high_overtime'     // 야근 많음 (주 55시간+)
  | 'shift_work'        // 교대근무
  | 'flexible'          // 유연근무 가능
  | 'seasonal'          // 시즌별 편차 큼
  | 'unknown'           // 정보 불충분
```

**단일 선택**: 가장 대표적인 것 1개
**⚠️ Risk 판단의 핵심 필드** - QA 집중 대상

### 2.3 environment (근무 환경)
```typescript
type Environment = 
  | 'office'            // 일반 사무실
  | 'hospital'          // 병원/의료시설
  | 'school'            // 학교/교육기관
  | 'court'             // 법원/법률기관
  | 'government'        // 공공기관
  | 'outdoors'          // 야외/현장
  | 'factory'           // 공장/제조시설
  | 'lab'               // 연구소/실험실
  | 'studio'            // 스튜디오/작업실
  | 'retail'            // 매장/판매시설
  | 'remote_possible'   // 원격근무 가능
  | 'travel_required'   // 출장 잦음
```

**복수 선택 가능**: 배열로 저장

### 2.4 interest_tags (흥미 유형 - Holland RIASEC)
```typescript
type InterestTag = 
  | 'realistic'         // 현실형 (R) - 기계, 도구, 야외, 동물
  | 'investigative'     // 탐구형 (I) - 분석, 연구, 과학
  | 'artistic'          // 예술형 (A) - 창작, 표현, 미적 감각
  | 'social'            // 사회형 (S) - 돕기, 가르치기, 치료
  | 'enterprising'      // 진취형 (E) - 설득, 리더십, 경영
  | 'conventional'      // 관습형 (C) - 정리, 관리, 데이터 처리
```

**복수 선택 가능**: 최대 3개 (우선순위 순)

### 2.5 values_tags (가치관)
```typescript
type ValueTag = 
  | 'stability'         // 안정성 (고용, 수입)
  | 'growth'            // 성장/발전 가능성
  | 'money'             // 높은 수입
  | 'impact'            // 사회적 영향/공헌
  | 'autonomy'          // 자율성/독립성
  | 'recognition'       // 인정/명예
  | 'creativity'        // 창의성 발휘
  | 'work_life_balance' // 워라밸
  | 'expertise'         // 전문성/기술 심화
  | 'variety'           // 다양성/변화
```

**복수 선택 가능**: 최대 3개

### 2.6 core_skills_tags (핵심 스킬)
```typescript
// 대분류
type SkillCategory = 
  | 'communication'     // 의사소통 (발표, 협상, 글쓰기)
  | 'analysis'          // 분석력 (데이터, 논리, 문제해결)
  | 'technical'         // 기술력 (프로그래밍, 공학, 도구)
  | 'creative'          // 창의력 (디자인, 기획, 콘텐츠)
  | 'leadership'        // 리더십 (관리, 조직, 의사결정)
  | 'interpersonal'     // 대인관계 (공감, 설득, 서비스)
  | 'physical'          // 신체능력 (체력, 손재주, 민첩성)
  | 'specialized'       // 전문지식 (법률, 의료, 금융)

// 세부 스킬 (동적 확장)
type DetailedSkill = string  // 'python', 'sql', 'negotiation', 'design' 등
```

**복수 선택 가능**: 대분류 + 세부 스킬 배열

### 2.7 entry_requirements (진입 요건)
```typescript
interface EntryRequirements {
  degree_required: boolean | 'preferred' | 'unknown'
  min_education: 'any' | 'high_school' | 'college' | 'university' | 'graduate' | 'unknown'
  license_required: boolean | 'preferred' | 'unknown'
  license_names?: string[]  // 필요한 자격증 이름들
  experience_years: number | 'unknown'  // 필요 경력 (0 = 신입 가능)
  estimated_learning_months: number | 'unknown'  // 진입까지 예상 학습 기간
}
```

**⚠️ Risk 판단의 핵심 필드들** - QA 집중 대상

---

## 3. job_attributes 전체 스키마

```typescript
interface JobAttributes {
  // 버전 관리
  tagger_version: string  // 'tagger-v1.0.0'
  tagged_at: string       // ISO 8601 timestamp
  
  // 태그들
  work_style: WorkStyle[]
  wlb: WLB
  environment: Environment[]
  interest_tags: InterestTag[]
  values_tags: ValueTag[]
  core_skills: {
    categories: SkillCategory[]
    detailed: string[]
  }
  entry_requirements: EntryRequirements
  
  // 신뢰도 (v0.2 추가 - Risk 판단에 사용)
  _confidence: number | 'low' | 'medium' | 'high'  // 전체 태깅 신뢰도
  _field_confidence: {  // 필드별 신뢰도 (Risk 핵심 필드)
    wlb: number | 'low' | 'medium' | 'high'
    degree_required: number | 'low' | 'medium' | 'high'
    license_required: number | 'low' | 'medium' | 'high'
    remote_possible: number | 'low' | 'medium' | 'high'
  }
  
  // 메타
  source_fields: string[]  // 태깅에 사용된 원본 필드들
}
```

---

## 4. 태깅 방식

### 4.1 LLM 1회성 태깅 (주 방식)

**프롬프트 템플릿**:
```
당신은 직업 데이터 분석 전문가입니다. 아래 직업 정보를 분석하여 구조화된 속성을 추출하세요.

## 직업 정보
- 직업명: {{name}}
- 직업 설명: {{summary}}
- 주요 업무: {{duties}}
- 근무 환경: {{environment}}
- 필요 역량: {{abilities}}
- 성격 특성: {{personality}}
- 흥미 유형: {{interests}}
- 가치관: {{values}}
- 준비 방법: {{way}}
- 연봉 정보: {{salary}}
- 전망: {{prospect}}

## 추출 규칙
1. 정보가 명확하지 않으면 "unknown" 사용
2. 추측하지 말고 주어진 텍스트에서만 추출
3. wlb는 반드시 하나만 선택
4. interest_tags는 최대 3개
5. estimated_learning_months는 자격증/학위 취득 기간 포함

## 출력 형식 (JSON)
{
  "work_style": ["..."],
  "wlb": "...",
  "environment": ["..."],
  "interest_tags": ["..."],
  "values_tags": ["..."],
  "core_skills": {
    "categories": ["..."],
    "detailed": ["..."]
  },
  "entry_requirements": {
    "degree_required": true/false/"preferred"/"unknown",
    "min_education": "...",
    "license_required": true/false/"preferred"/"unknown",
    "license_names": ["..."],
    "experience_years": 0,
    "estimated_learning_months": 0
  },
  "_confidence": 0.0~1.0,
  "_field_confidence": {
    "wlb": 0.0~1.0,
    "degree_required": 0.0~1.0,
    "license_required": 0.0~1.0,
    "remote_possible": 0.0~1.0
  }
}
```

### 4.2 규칙 기반 보조 (후처리)

일부 필드는 규칙으로 검증/보정:

```typescript
// 직업명 기반 자동 보정
const KNOWN_OVERRIDES = {
  '변호사': { degree_required: true, license_required: true, estimated_learning_months: 36 },
  '의사': { degree_required: true, license_required: true, estimated_learning_months: 72 },
  '간호사': { degree_required: true, license_required: true, estimated_learning_months: 36 },
  '공인회계사': { license_required: true, estimated_learning_months: 24 },
  '교사': { degree_required: true, license_required: true },
  // ... 고위험 직업군 추가
}

function postProcessAttributes(jobName: string, llmResult: JobAttributes): JobAttributes {
  const override = KNOWN_OVERRIDES[jobName]
  if (override) {
    return { ...llmResult, entry_requirements: { ...llmResult.entry_requirements, ...override } }
  }
  return llmResult
}
```

---

## 4.3 Confidence (신뢰도) 산출 (v0.2 추가)

하드필터가 없으므로, **태깅 신뢰도가 Risk 판단에 직접 영향**을 줌.

### 신뢰도 산출 기준

| 조건 | Confidence |
|------|------------|
| 원본 텍스트에 명시적 언급 있음 | 0.8~0.95 (high) |
| 원본 텍스트에서 추론 가능 | 0.5~0.7 (medium) |
| 추론도 어려움 / 정보 부족 | 0.3~0.5 (low) |
| 직업명 기반 규칙 오버라이드 | 0.9+ (known job) |

### LLM 프롬프트에 Confidence 출력 강제

```
각 필드에 대해 confidence도 함께 출력하세요:
- 0.9+: 텍스트에 명확히 언급됨
- 0.6~0.8: 텍스트에서 추론 가능
- 0.3~0.5: 정보 부족, 추측

특히 아래 필드는 confidence가 중요합니다 (Risk 판단에 사용):
- wlb
- degree_required
- license_required
- environment (remote_possible 포함 여부)
```

### Risk 판단에서의 활용 (v0.2.1 정책)

> ⚠️ **핵심**: UNKNOWN은 OK로 완화하지 않음! 상태 유지 + 페널티 0

```typescript
// confidence 낮으면 RISK → UNKNOWN으로만 완화
function adjustRiskByFieldConfidence(
  rawStatus: 'RISK' | 'UNKNOWN' | 'OK',
  fieldConfidence: number
): 'RISK' | 'UNKNOWN' | 'OK' {
  
  // RISK인데 confidence 낮으면 → UNKNOWN으로 완화
  if (rawStatus === 'RISK' && fieldConfidence < 0.5) {
    return 'UNKNOWN'  // 확신 없으니 RISK 대신 UNKNOWN
  }
  
  // ❌ UNKNOWN → OK 완화는 하지 않음!
  // UNKNOWN은 "모른다"는 상태 자체가 의미 있음
  // 페널티만 0으로 하고 상태는 유지 (뱃지/설명용)
  
  return rawStatus
}

// UNKNOWN 처리 예시
// status: UNKNOWN, penalty: 0, badge: "⚠️ 확인 필요"
```

### QA 시 Confidence 검증

고위험 필드(wlb, degree, license)의 confidence가:
- 0.8 이상인데 실제로 틀리면 → 프롬프트 문제
- 0.5 이하인데 실제로 맞으면 → confidence 보정 필요

---

## 5. 저장 위치

### 5.1 권장: api_data_json.merged에 추가

```json
{
  "careernet": { "..." },
  "goyong24": { "..." },
  "merged": {
    "id": "lawyer",
    "name": "변호사",
    "summary": "...",
    "duties": "...",
    // ... 기존 필드들
    
    "job_attributes": {
      "tagger_version": "tagger-v1.0.0",
      "tagged_at": "2026-01-02T10:00:00Z",
      "work_style": ["analysis", "people"],
      "wlb": "high_overtime",
      "environment": ["office", "court"],
      "interest_tags": ["investigative", "enterprising", "social"],
      "values_tags": ["impact", "recognition", "expertise"],
      "core_skills": {
        "categories": ["communication", "analysis", "specialized"],
        "detailed": ["negotiation", "legal_knowledge", "writing", "critical_thinking"]
      },
      "entry_requirements": {
        "degree_required": true,
        "min_education": "graduate",
        "license_required": true,
        "license_names": ["변호사 자격증"],
        "experience_years": 0,
        "estimated_learning_months": 36
      },
      "_confidence": 0.85,
      "_field_confidence": {
        "wlb": 0.7,
        "degree_required": 0.95,
        "license_required": 0.95,
        "remote_possible": 0.6
      },
      "source_fields": ["summary", "duties", "environment", "abilities"]
    }
  }
}
```

### 5.2 DB 업데이트 방식

```sql
-- 기존 api_data_json 업데이트
UPDATE jobs 
SET api_data_json = json_set(
  api_data_json, 
  '$.merged.job_attributes', 
  json(:new_attributes)
)
WHERE id = :job_id;
```

---

## 6. 실행 계획

### 6.1 배치 처리 흐름

```
1. 직업 데이터 추출 (D1에서 ~7,000개)
   ↓
2. LLM 태깅 (배치, 100개/분)
   ↓
3. 규칙 기반 후처리 (고위험 직업군)
   ↓
4. QA 샘플링 검수
   ↓
5. DB 업데이트
   ↓
6. 템플릿 버전 증가 (캐시 무효화)
```

### 6.2 예상 비용 및 시간

| 항목 | 예상치 |
|------|--------|
| 직업 수 | ~7,000개 |
| 토큰/직업 | ~2,000 (입력+출력) |
| 총 토큰 | ~14M |
| OpenAI 비용 (GPT-4o-mini) | ~$2-3 |
| 처리 시간 | ~2-3시간 |

### 6.3 실행 명령어

```bash
# 1. 태깅 실행
npx tsx scripts/rag/tag-jobs.ts

# 2. QA 검수용 샘플 추출
npx tsx scripts/rag/extract-qa-samples.ts

# 3. DB 업데이트 (검수 후)
npx tsx scripts/rag/apply-job-attributes.ts

# 4. 템플릿 버전 증가
# src/constants/template-versions.ts에서 JOB 버전 +1
```

---

## 7. QA (품질 검수) 규칙

### 7.1 샘플링 기준

| 그룹 | 개수 | 선정 기준 |
|------|------|----------|
| 랜덤 샘플 | 50개 | 전체에서 무작위 |
| 고위험 직업군 | 20개 | 의료/법률/항공/건설/교대근무 |
| **총 검수 대상** | **70개** | |

### 7.2 고위험 직업군 (필수 검수)

```typescript
const HIGH_RISK_CATEGORIES = [
  '의료',      // 의사, 간호사, 약사
  '법률',      // 변호사, 판사, 법무사
  '항공',      // 조종사, 승무원
  '건설',      // 건축사, 현장감독
  '금융',      // 회계사, 금융전문가
  '교육',      // 교사, 교수
  '공무원',    // 공무원, 경찰, 소방관
]
```

### 7.3 통과 기준

| 필드 | 정확도 기준 | 중요도 |
|------|------------|--------|
| `wlb` | ≥ 80% | 🔴 Critical |
| `degree_required` | ≥ 90% | 🔴 Critical |
| `license_required` | ≥ 90% | 🔴 Critical |
| `estimated_learning_months` | ≥ 70% | 🟡 Medium |
| `work_style` | ≥ 75% | 🟢 Low |
| `interest_tags` | ≥ 75% | 🟢 Low |

### 7.4 QA 체크리스트

```markdown
## QA 검수 시트

직업명: _______________
검수자: _______________
검수일: _______________

### 1. wlb (워라밸) ✅/❌
- LLM 결과: __________
- 실제 판단: __________
- 일치 여부: [ ]

### 2. degree_required ✅/❌
- LLM 결과: __________
- 실제 판단: __________
- 일치 여부: [ ]

### 3. license_required ✅/❌
- LLM 결과: __________
- 실제 판단: __________
- 일치 여부: [ ]

### 4. estimated_learning_months ✅/❌
- LLM 결과: __________
- 실제 판단: __________
- 오차 범위: [ ] 6개월 이내

### 5. 종합 판정
- [ ] 통과
- [ ] 수동 보정 필요
- [ ] 재태깅 필요
```

### 7.5 실패 시 대응

| 상황 | 대응 |
|------|------|
| 특정 필드 정확도 미달 | 해당 필드 프롬프트 튜닝 후 재태깅 |
| 특정 직업군 오류 다발 | KNOWN_OVERRIDES에 추가 |
| 전체 정확도 미달 | 프롬프트 전면 수정 + 샘플 10개 재테스트 |

---

## 8. 버전 관리

### 8.1 현재 버전
- **tagger_version**: `tagger-v1.0.0`
- **적용일**: 2026-01-02

### 8.2 버전 변경 시
태깅 로직 변경 시 반드시:
1. `tagger_version` 증가
2. 기존 태그된 직업 재태깅 (또는 변경분만)
3. `analysis_requests`에 버전 기록

### 8.3 변경 이력

| 버전 | 날짜 | 변경 내용 |
|------|------|----------|
| v1.0.0 | 2026-01-02 | 초기 버전 |

---

## 9. 체크리스트

### 태깅 전
- [ ] 프롬프트 샘플 10개 테스트
- [ ] KNOWN_OVERRIDES 목록 확인
- [ ] QA 샘플링 대상 선정

### 태깅 후
- [ ] 70개 샘플 검수 완료
- [ ] 정확도 기준 통과 확인
- [ ] 오류 직업 수동 보정

### 적용 후
- [ ] DB 업데이트 완료
- [ ] 템플릿 버전 증가
- [ ] tagger_version 기록 확인

