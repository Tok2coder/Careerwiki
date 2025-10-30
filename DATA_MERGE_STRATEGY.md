# 직업 정보 데이터 병합 전략

## 📊 데이터 소스 분석

### 커리어넷 직업백과 (encyclopedia)
**장점:**
- 한국 교육 중심의 신뢰할 수 있는 데이터
- 학생/구직자 관점의 친화적 설명
- 관련 학과, 관련 동영상 등 교육 리소스 풍부

**약점:**
- 업데이트 주기가 느림
- 임금/전망 데이터가 오래됨

**주요 필드:**
- baseInfo: 직업명, 임금, 만족도, 사회적평가, 워라밸
- workList: 하는 일 (교육적 설명)
- abilityList: 필요 능력
- departList: 관련 학과
- certiList: 관련 자격증
- forecastList: 전망 (교육적 설명)
- relVideoList: 관련 동영상

### 고용24 (7개 섹션)
**장점:**
- 고용노동부 공식 데이터 - 최신성 높음
- 임금/전망 데이터 신뢰도 높음
- 직업간/직업내 비교 데이터 제공
- 상세한 능력/지식/환경 데이터

**약점:**
- 공공기관 특유의 딱딱한 설명
- 교육 리소스 부족

**주요 필드:**
- summary: 직업명, 임금, 만족도, 전망 (최신)
- salProspect: 임금/만족도/전망 상세 (최신)
- ablKnwEnv: 능력/지식/환경 (상세, 비교 데이터)
- chrIntrVals: 성격/흥미/가치관 (상세, 비교 데이터)
- duty: 수행 직무 (실무적)
- path: 교육/자격/훈련 (통계 데이터)

---

## 🎯 방안 1: 우선순위 기반 병합 (Fallback 전략)

### 개요 탭 필드 매핑
| 필드 | 1순위 소스 | 2순위 소스 | 이유 |
|------|-----------|-----------|------|
| **직업명** | goyong24.summary.jobNm | encyclopedia.baseInfo.job_nm | 동일하지만 고용24가 표준 |
| **직업 분류** | goyong24.summary (대/중/소) | - | 공식 분류 체계 |
| **임금** | goyong24.salProspect.sal | encyclopedia.baseInfo.wage | 고용24가 최신 |
| **만족도** | goyong24.salProspect.jobSatis | encyclopedia.baseInfo.satisfication | 고용24가 최신 |
| **워라밸** | encyclopedia.baseInfo.wlb | - | 커리어넷만 보유 |
| **사회적 평가** | encyclopedia.baseInfo.social | - | 커리어넷만 보유 |
| **전망** | goyong24.salProspect.jobProspect | encyclopedia.forecastList | 고용24가 최신 |
| **하는 일** | encyclopedia.workList | goyong24.summary.jobSum | 커리어넷이 친화적 |

### 상세정보 탭 카테고리 구성

#### 1. 💼 직무 정보
- **하는 일**: encyclopedia.workList (주), goyong24.duty.execJob (보조)
- **수행 직무**: goyong24.duty.execJob
- **되는 길**: goyong24.summary.way

#### 2. 💰 임금 & 전망
- **임금**: goyong24.salProspect.sal (상세)
- **직업만족도**: goyong24.salProspect.jobSatis
- **일자리 전망**: goyong24.salProspect.jobProspect
- **전망 상세**: goyong24.salProspect.jobSumProspect (배열)
- **일자리 현황**: goyong24.salProspect.jobStatusList

#### 3. 🎓 교육 & 학력
- **학력 분포**: goyong24.path.educationDistribution (통계), encyclopedia.eduChart (보조)
- **전공 분포**: goyong24.path.majorDistribution (통계), encyclopedia.majorChart (보조)
- **관련 학과**: encyclopedia.departList (주), goyong24.path.relMajorList (보조)
- **관련 자격증**: 병합 (둘 다 사용)

#### 4. 🧠 능력 & 지식
- **업무수행능력**: goyong24.ablKnwEnv.jobAbilCmpr/jobAbil (상세 비교)
- **필요 능력**: encyclopedia.abilityList (보조)
- **지식**: goyong24.ablKnwEnv.KnwldgCmpr/Knwldg (상세 비교)
- **필요 지식**: encyclopedia.performList.knowledge (보조)
- **기술/지식**: goyong24.path.technKnow

#### 5. 🌍 업무환경
- **업무환경**: goyong24.ablKnwEnv.jobsEnvCmpr/jobsEnv (상세 비교)
- **업무환경 정보**: encyclopedia.performList.environment (보조)

#### 6. 🎭 성격/흥미/가치관
- **성격**: goyong24.chrIntrVals.jobChrCmpr/jobChr (상세 비교)
- **적성**: encyclopedia.aptitudeList
- **흥미**: goyong24.chrIntrVals.jobIntrstCmpr/jobIntrst (상세 비교)
- **가치관**: goyong24.chrIntrVals.jobValsCmpr/jobVals (상세 비교)

#### 7. ⚡ 업무활동
- **업무활동 중요도**: goyong24.actv.jobActvImprtncCmpr/jobActvImprtnc
- **업무활동 수준**: goyong24.actv.jobActvLvlCmpr/jobActvLvl

#### 8. 🔗 관련 정보
- **관련 직업**: goyong24.summary.relJobList
- **관련 기관**: encyclopedia.jobRelOrgList, goyong24.path.relOrgList
- **한국고용직업분류**: goyong24.path.kecoList
- **진로탐색**: encyclopedia.researchList
- **관련 동영상**: encyclopedia.relVideoList
- **직업준비**: encyclopedia.jobReadyList

---

## 🎯 방안 2: 스마트 병합 (Quality-Based Merge)

### 개요 탭 필드 매핑
동일하게 방안 1과 같음

### 상세정보 탭 - 스마트 병합 로직

#### 병합 규칙
1. **최신성 우선**: 임금/전망 → 고용24 우선
2. **상세도 우선**: 배열 데이터가 더 많은 쪽 선택
3. **친화도 우선**: 설명 텍스트 → 커리어넷 우선
4. **보완 표시**: 두 소스 모두 표시하되 구분 (예: "고용24: ...", "커리어넷: ...")

#### 구체적 병합 예시

**임금 필드:**
```typescript
{
  primary: goyong24.salProspect.sal,  // 최신
  secondary: encyclopedia.baseInfo.wage,  // 보조
  display: goyong24.salProspect.sal || encyclopedia.baseInfo.wage,
  showBoth: true  // 둘 다 있으면 비교 표시
}
```

**하는 일 필드:**
```typescript
{
  primary: encyclopedia.workList,  // 친화적 설명
  secondary: goyong24.summary.jobSum,  // 공식 설명
  detail: goyong24.duty.execJob  // 상세 직무
}
```

**능력 필드:**
```typescript
{
  detailed: goyong24.ablKnwEnv.jobAbilCmpr,  // 상세 비교 데이터
  simple: encyclopedia.abilityList,  // 간단 리스트
  display: goyong24가 있으면 goyong24 (더 상세), 없으면 encyclopedia
}
```

---

## 🎯 방안 3: 소스 분리 표시 (Dual Source Display)

### 개요 탭
방안 1, 2와 동일

### 상세정보 탭 - 소스별 탭/섹션 구분

#### UI 구조
각 카테고리 내에서 **소스별로 구분 표시**:

```
💰 임금 & 전망
├─ 📊 공식 통계 (고용24)
│  ├─ 임금: 5,000만원
│  ├─ 만족도: 75%
│  └─ 전망: 증가
│
└─ 📚 교육 자료 (커리어넷)
   ├─ 임금: 4,800만원
   └─ 전망: 긍정적

🧠 능력 & 지식
├─ 📊 상세 분석 (고용24)
│  ├─ 직업내 비교 (5개 항목)
│  └─ 직업간 비교 (5개 항목)
│
└─ 📚 필요 능력 (커리어넷)
   └─ 간단 리스트 (3개 항목)
```

#### 장점
- 정보 출처 명확
- 사용자가 선택 가능
- 데이터 신뢰도 향상

#### 단점
- UI가 복잡해질 수 있음
- 중복 정보 표시

---

## 🏆 추천 방안: **방안 1 (우선순위 기반 병합)** + 방안 2 일부

### 추천 이유

1. **단순하고 명확한 사용자 경험**
   - 한 필드당 하나의 값만 표시 (최적)
   - 혼란 최소화

2. **데이터 품질 최적화**
   - 임금/전망 → 고용24 (최신)
   - 설명 텍스트 → 커리어넷 (친화적)
   - 상세 분석 → 고용24 (전문적)

3. **확장 가능성**
   - 필요시 방안 2의 스마트 병합 로직 추가
   - "다른 자료 보기" 토글로 보조 데이터 제공 가능

4. **구현 복잡도**
   - 방안 1: 낮음 ✅
   - 방안 2: 중간
   - 방안 3: 높음

### 구현 우선순위

#### Phase 1: 개요 탭 (핵심 정보)
```typescript
{
  jobName: goyong24.summary.jobNm || encyclopedia.baseInfo.job_nm,
  classification: goyong24.summary (jobLrclNm, jobMdclNm, jobSmclNm),
  salary: goyong24.salProspect.sal || encyclopedia.baseInfo.wage,
  satisfaction: goyong24.salProspect.jobSatis || encyclopedia.baseInfo.satisfication,
  workLifeBalance: encyclopedia.baseInfo.wlb,
  socialReputation: encyclopedia.baseInfo.social,
  prospect: goyong24.salProspect.jobProspect || encyclopedia.forecastList,
  description: encyclopedia.workList || goyong24.summary.jobSum
}
```

#### Phase 2: 상세정보 탭 - 카테고리별 구현
1. 직무 정보 (encyclopedia.workList 주, goyong24.duty 보조)
2. 임금 & 전망 (goyong24.salProspect 전체 활용)
3. 교육 & 학력 (통계는 goyong24, 리스트는 encyclopedia)
4. 능력 & 지식 (goyong24 상세 비교 데이터)
5. 성격/흥미/가치관 (goyong24 상세 비교 데이터)
6. 관련 정보 (두 소스 병합)

### 데이터 없을 때 처리

**Fallback 체인:**
```typescript
const salary = 
  goyong24?.salProspect?.sal ||  // 1순위
  goyong24?.summary?.sal ||       // 2순위
  encyclopedia?.baseInfo?.wage || // 3순위
  '정보 없음'                      // 기본값
```

**"정보 없음" 대신 다른 표현:**
- "현재 집계 중"
- "곧 업데이트 예정"
- 관련 필드 추천

---

## 📝 구현 체크리스트

### 개요 탭
- [ ] 직업명 병합
- [ ] 임금 병합 (고용24 우선)
- [ ] 만족도 병합 (고용24 우선)
- [ ] 전망 병합 (고용24 우선)
- [ ] 워라밸 표시 (커리어넷)
- [ ] 하는 일 표시 (커리어넷 우선)

### 상세정보 탭
- [ ] 직무 정보 카테고리
- [ ] 임금 & 전망 카테고리 (고용24 상세)
- [ ] 교육 & 학력 카테고리
- [ ] 능력 & 지식 카테고리 (고용24 상세)
- [ ] 업무환경 카테고리
- [ ] 성격/흥미/가치관 카테고리 (고용24 상세)
- [ ] 업무활동 카테고리 (고용24)
- [ ] 관련 정보 카테고리

### 데이터 품질
- [ ] Fallback 로직 구현
- [ ] "정보 없음" 처리
- [ ] 데이터 유효성 검증
- [ ] 출처 표시 (선택사항)

---

## 🎨 UI 제안

### 개요 탭 레이아웃
```
┌─────────────────────────────────────┐
│ 직업명 (대분류 > 중분류 > 소분류)    │
├─────────────────────────────────────┤
│ 💰 임금: 5,000만원                  │
│ 😊 만족도: 75%                      │
│ ⚖️ 워라밸: 좋음                     │
│ 📈 전망: 증가                       │
├─────────────────────────────────────┤
│ 💼 하는 일                          │
│ (커리어넷 친화적 설명 3-5개)         │
└─────────────────────────────────────┘
```

### 상세정보 탭 - 아코디언 방식
```
▼ 💼 직무 정보
  - 하는 일 상세
  - 수행 직무
  - 되는 길

▼ 💰 임금 & 전망
  - 임금
  - 만족도
  - 전망 상세
  - 일자리 현황

▶ 🎓 교육 & 학력
▶ 🧠 능력 & 지식
▶ 🌍 업무환경
▶ 🎭 성격/흥미/가치관
▶ ⚡ 업무활동
▶ 🔗 관련 정보
```

---

## 💡 추가 제안

### 데이터 신선도 표시
```typescript
{
  value: "5,000만원",
  source: "고용24",
  lastUpdate: "2024-03",
  badge: "최신" // 6개월 이내면 "최신" 배지
}
```

### 비교 기능 (Phase 3)
- 같은 필드의 커리어넷 vs 고용24 비교
- "다른 자료 보기" 토글
- 차이점 하이라이트

### 사용자 맞춤
- 학생 모드: 교육 정보 강조 (커리어넷 위주)
- 구직자 모드: 실무 정보 강조 (고용24 위주)
