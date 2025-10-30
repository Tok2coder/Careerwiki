# 변호사 페이지 필드 사용 현황 분석

**분석 일시**: 2025-10-30  
**분석 대상**: https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/lawyer  
**API 디버그**: https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/job:C_375

---

## 📊 요약

| 구분 | 개수 |
|------|------|
| **실제 표시되는 섹션** | 15개 |
| **사용되는 API 필드** | ~45개 |
| **사용 가능한 전체 API 필드** | ~120개 |
| **누락된 필드 (데이터 있음)** | ~75개 |

---

## ✅ 현재 표시되는 섹션 (15개)

### **개요 탭 (Overview)**
1. ✅ **하는 일** (`workList`, `jobSum`)
2. ✅ **커리어 전망** (`forecastList`, `jobProspect`)
3. ✅ **핵심 능력** (`abilityList`, `jobAbil`)
4. ✅ **적성 및 흥미** (`aptitudeList`, `jobChr`, `jobIntrst`, `jobVals`)

### **상세 정보 탭 (Details)**
5. ✅ **필수 지식** (`performList.knowledge`, `knowldg`)
6. ✅ **업무 수행 지표** (`jobActvImprtncs`, `jobActvLvls`)
7. ✅ **학력 분포** (`educationDistribution`) - 파이 차트
8. ✅ **전공 분포** (`majorDistribution`) - 파이 차트
9. ✅ **업무 상세** (`duty.execJob`)
10. ✅ **워라밸 & 사회적 평가** (`wlb`, `social`)
11. ✅ **진로 준비방법** (`jobReadyList`)
12. ✅ **근무환경 상세** (`workCond.envrnCndtn`, `workCond.empmtCndtn`) - 데이터 없음
13. ✅ **성격 특성 분석** (`chrIntrVals.jobChrCmpr`, `jobChr`)
14. ✅ **흥미 분야 분석** (`chrIntrVals.jobIntrstCmpr`, `jobIntrst`)
15. ✅ **가치관 분석** (`chrIntrVals.jobValsCmpr`, `jobVals`)
16. ✅ **활동 중요도 분석** (`actv.jobActvImprtncCmpr`, `jobActvImprtnc`)
17. ✅ **활동 수준 분석** (`actv.jobActvLvlCmpr`, `jobActvLvl`)
18. ✅ **필수 지식 상세 비교** (`ablKnwEnv.KnwldgCmpr`, `Knwldg`)
19. ✅ **필수 능력 상세 비교** (`ablKnwEnv.jobAbilCmpr`, `jobAbil`)
20. ✅ **직업 분류 체계** (`jobLrclNm`, `jobMdclNm`, `jobSmclNm`)

---

## ⚠️ 누락된 필드 (데이터는 있지만 표시 안 됨)

### **1. 고용24 API - ablKnwEnv (능력/지식/환경)**

#### **업무환경 상세 필드** ❌ **현재 누락됨!**
```
ablKnwEnv.jobsEnvCmpr[] (직업 내 비교)
  - jobEnvNmCmpr: 업무환경 이름 (예: "이메일 이용하기", "전화 대화하기")
  - jobEnvStatusCmpr: 5점 척도 (예: 4.8)
  - jobEnvContCmpr: 설명

ablKnwEnv.jobsEnv[] (직업 간 비교)
  - jobEnvNm: 업무환경 이름 (예: "재택근무", "의사결정 권한")
  - jobEnvStatus: 백분위 (예: 99, 93)
  - jobEnvCont: 설명
```

**데이터 샘플** (변호사):
- 재택근무: 99% (최상위)
- 의사결정 권한: 93%
- 이메일 이용: 4.8/5
- 전화 대화: 4.7/5
- 실내 근무: 4.7/5
- 앉아서 근무: 4.7/5

**문제**: `workCond.envrnCndtn`와 `workCond.empmtCndtn`에 데이터가 없어서 "근무환경 상세" 섹션이 표시 안 됨. 대신 `ablKnwEnv.jobsEnvCmpr`와 `ablKnwEnv.jobsEnv`를 사용해야 함!

---

### **2. 커리어넷 API - performList**

#### **업무 환경 항목** ❌ **현재 누락됨!**
```
encyclopedia.performList.environment[]
  - environment: 환경 이름 (예: "이미지/평판/재정에 미치는 영향력")
  - inform: 상세 설명
  - importance: 중요도 (예: 99)
```

**데이터 샘플** (변호사):
- 이미지/평판/재정에 미치는 영향력: 99
- 정확성, 정밀성 유지: 98
- 결과에 대한 책임: 98

**문제**: 이 데이터는 "업무 맥락/책임"에 가까우므로 별도 섹션이 필요할 수 있음.

#### **업무 수행 활동** ❌ **현재 누락됨!**
```
encyclopedia.performList.perform[]
  - perform: 수행 활동 (예: "조언하고 상담하기")
  - importance: 중요도
```

---

### **3. 고용24 API - workCond (근무조건)**

#### **입직 통계** ❌ **현재 누락됨!**
```
workCond.entry
  - entInfo: 입직 정보 텍스트
```

**데이터 확인 필요**: API에서 이 필드에 값이 있는지 확인 필요.

---

### **4. 커리어넷 API - 기타 유용한 필드들**

#### **라이센스 정보** ❌ **부분적으로만 표시됨**
```
encyclopedia.licenseList[]
  - license: 자격증 이름
  - license_source: 출처
  - summary: 요약

encyclopedia.baseInfo.license_adv
  - 자격증 유리 여부 설명
```

**현재 상태**: 자격증 이름만 표시됨. `license_adv` 설명은 누락됨.

#### **조사/연구 자료** ❌ **현재 누락됨!**
```
encyclopedia.researchList[]
  - research_title: 연구 제목
  - research_agency: 연구 기관
  - research_year: 연구 년도
  - research_url: URL
```

#### **태그** ❌ **현재 누락됨!**
```
encyclopedia.tagList[]
  - tag: 태그 이름 (예: "법률", "소송", "변론")
```

#### **관련 동영상** ❌ **현재 누락됨!**
```
encyclopedia.videoList[]
  - video_title: 동영상 제목
  - video_url: YouTube URL
  - video_source: 출처
```

---

### **5. 고용24 API - chrIntrVals (성격/흥미/가치관)**

#### **현재 잘 표시되고 있음** ✅
- 성격 특성 분석
- 흥미 분야 분석
- 가치관 분석

**모두 직업 내 비교 + 직업 간 비교로 제대로 표시됨!**

---

### **6. 고용24 API - actv (활동)**

#### **현재 잘 표시되고 있음** ✅
- 활동 중요도 분석
- 활동 수준 분석

**모두 직업 내 비교 + 직업 간 비교로 제대로 표시됨!**

---

## 🎯 우선순위별 개선 제안

### **🔴 High Priority (즉시 추가)**

1. **업무환경 상세 섹션 수정** ⭐ **가장 중요!**
   - 현재: `workCond.envrnCndtn/empmtCndtn` 사용 (데이터 없음)
   - 변경: `ablKnwEnv.jobsEnvCmpr` + `ablKnwEnv.jobsEnv` 사용
   - 진행 바로 시각화 (현재 비교 분석 섹션과 동일한 스타일)

2. **자격증 유리 여부 추가**
   - `encyclopedia.baseInfo.license_adv` 텍스트 표시
   - "관련 자격증" 섹션에 함께 표시

### **🟡 Medium Priority (추후 추가)**

3. **조사/연구 자료 섹션**
   - `encyclopedia.researchList` 표시
   - 외부 링크 제공

4. **태그 섹션**
   - `encyclopedia.tagList` 뱃지 형태로 표시
   - 검색 연동 가능

5. **업무 맥락/책임 섹션**
   - `encyclopedia.performList.environment` 표시
   - 중요도순 정렬

### **🟢 Low Priority (선택적)**

6. **관련 동영상**
   - `encyclopedia.videoList` YouTube 임베드
   - 별도 탭 또는 섹션

7. **입직 통계**
   - `workCond.entry` (데이터 확인 필요)

---

## 📝 필드 매핑 요약표

| 섹션 | 현재 사용 | 올바른 사용 | 상태 |
|------|----------|------------|------|
| 근무환경 상세 | `workCond.envrnCndtn/empmtCndtn` | `ablKnwEnv.jobsEnvCmpr/jobsEnv` | ❌ 수정 필요 |
| 자격증 정보 | `licenseList[].license` | `+ baseInfo.license_adv` | ⚠️ 부분적 |
| 조사/연구 | (없음) | `encyclopedia.researchList` | ❌ 추가 필요 |
| 태그 | (없음) | `encyclopedia.tagList` | ❌ 추가 필요 |
| 업무 맥락 | (없음) | `performList.environment` | ❌ 추가 필요 |
| 동영상 | (없음) | `encyclopedia.videoList` | ❌ 추가 필요 |

---

## 🔍 다음 작업

1. **"근무환경 상세" 섹션 수정** (가장 시급!)
2. 실제 변호사 페이지에서 새로운 섹션들이 제대로 표시되는지 테스트
3. 다른 직업(의사, 간호사 등)에서도 동일하게 작동하는지 검증

---

**작성**: Claude (AI Assistant)  
**최종 업데이트**: 2025-10-30
