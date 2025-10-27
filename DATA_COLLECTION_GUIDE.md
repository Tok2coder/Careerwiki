# 데이터 수집 가이드 - 변호사 직업 정보

## 📌 페이지 구분

### 1. `/job/lawyer` - 일반 사용자 페이지
- **목적**: 일반 사용자를 위한 깔끔한 직업 정보 페이지
- **내용**: 변호사 직업에 대한 정리된 정보 (병합된 데이터)
- **URL**: https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/lawyer

### 2. `/job/job:C_375` - 데이터 디버그 페이지
- **목적**: 개발자/관리자용 완전한 API 응답 확인
- **내용**: 
  - ✅ CareerNet 원본 API 응답 (JSON 전체)
  - ✅ Goyong24 원본 API 응답 (XML 파싱 결과)
  - ✅ 필드별 데이터 비교 테이블
  - ✅ 병합된 최종 프로필
  - ✅ API 호출 상태 및 에러 정보
- **URL**: https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/job:C_375

---

## 🔍 변호사 직업 식별 방법

### 시스템 내부 식별자

변호사 직업은 다음 **모든 패턴**으로 자동 인식됩니다:

#### 1. 영어 키워드
- `lawyer` (URL slug로 사용)

#### 2. 한국어 키워드
- `변호사`

#### 3. CareerNet ID 패턴
- `job:C_375` (정규 ID 형식)
- `job-c-375` (URL 친화적 형식)
- `c_375` (축약형)
- `375` (순수 ID)

#### 4. Goyong24 ID 패턴
- `job:G_K000007482` (정규 ID 형식)
- `job-g-k000007482` (URL 친화적 형식)
- `jobgk000007482` (붙여쓰기)
- `K000007482` (순수 ID)

### 구현 위치
- 파일: `src/services/profileDataService.ts`
- 함수: `matchesLawyerIdentifier()`, `resolveJobSourceOverride()`
- 라인: 116-157

---

## 🌐 API 호출 세부사항

### CareerNet API (커리어넷)

#### 엔드포인트
```
https://www.career.go.kr/cnet/openapi/getOpenApi
```

#### 파라미터 (변호사)
```
apiKey: [환경변수 CAREER_NET_API_KEY]
svcType: api
svcCode: JOB_VIEW
contentType: json (우선) 또는 xml (폴백)
gubun: job_dic_list
jobdicSeq: 375
```

#### 응답 형식
- **우선**: JSON (풍부한 데이터)
- **폴백**: XML (기본 데이터)

#### 추출 필드 (46개)
**기본 정보:**
- jobdicSeq, jobName, summary, aptdType, jobCategoryName
- avgSalary, salaryRange, jobOutlook, employmentTrend
- relatedMajor, requiredEducation, requiredCertification

**확장 정보 (JSON 전용):**
- **workList[]**: 세부 업무 목록 (workName, workDesc)
- **performList**:
  - environment[] (중요도 포함)
  - perform[] (중요도 포함)
  - knowledge[] (중요도 포함)
- **abilityList[]**: 필요 능력 (점수 포함)
- **aptitudeList[]**: 필요 적성 (점수 포함)
- **interestList[]**: 흥미 유형 (점수 포함)
- **jobReadyList**: 채용, 자격증, 교육과정
- **forecastList[]**: 미래 전망
- **indicatorChart[]**: 직업 지표
- **relVideoList[]**: 관련 영상
- **relSolList[]**: 관련 자료
- **relJinsolList[]**: 진로 상담 자료
- **researchList[]**: 연구 자료

#### 구현 위치
- 파일: `src/api/careernetAPI.ts`
- 함수: `getJobDetail()`, `normalizeCareerNetJobDetail()`

---

### Goyong24 API (고용노동부)

#### 엔드포인트 (3개 섹션)
```
1. 요약: https://www.work24.go.kr/cm/openApi/call/hr/callOpenApiSvcInfo212D01
2. 직무: https://www.work24.go.kr/cm/openApi/call/hr/callOpenApiSvcInfo212D02
3. 경로: https://www.work24.go.kr/cm/openApi/call/hr/callOpenApiSvcInfo212D03
```

#### 파라미터 (변호사)
```
authKey: [환경변수 GOYONG24_JOB_API_KEY]
returnType: XML
target: JOBCD
dtlGb: 1 (요약) / 2 (직무) / 3 (경로)
jobCd: K000007482
```

#### 응답 형식
- **고정**: XML

#### 추출 필드 (26개)

**섹션 1 - 요약 (jobSum):**
- jobCd, jobNm, jobLrclNm, jobMdclNm, jobSmclNm
- jobSum, way, sal, jobSatis, jobProspect, jobStatus
- jobAbil, knowldg, jobEnv, jobChr, jobIntrst, jobVals
- jobActvImprtncs, jobActvLvls
- relMajorList[], relCertList[], relJobList[]

**섹션 2 - 직무 (jobsDo):**
- execJob, jobSum, relJobList[]

**섹션 3 - 경로 (way):**
- technKnow
- educationDistribution (학력 분포 6개)
- majorDistribution (전공 분포 7개)
- relMajorList[], relOrgList[], relCertList[], kecoList[]

#### 구현 위치
- 파일: `src/api/goyong24API.ts`
- 함수: `fetchGoyong24JobDetail()`, `normalizeGoyong24JobDetail()`

---

## 🔄 데이터 통합 프로세스

### 1. 데이터 수집
```typescript
// src/services/profileDataService.ts - getUnifiedJobDetailWithRawData()

1. 변호사 식별자 감지
   → careernetId: "375"
   → goyong24JobId: "K000007482"

2. CareerNet API 호출 (JSON 우선)
   → 원본 응답 저장: rawCareernetData
   → 정규화: careernetProfile

3. Goyong24 API 호출 (3개 섹션)
   → 원본 응답 저장: rawGoyong24Data
   → 정규화: goyongProfile
```

### 2. 데이터 병합
```typescript
// src/services/profileMerge.ts - mergeJobProfiles()

우선순위:
1. Goyong24 데이터 (한국 정부 공식 데이터)
2. CareerNet 데이터 (교육부 공식 데이터)
3. 둘 다 없으면 null
```

### 3. 특수 처리 (변호사 전용)
```typescript
// src/services/profileDataService.ts - applyJobDetailOverrides()

- 이름 강제: "변호사"
- 필드별 우선순위 재조정
- 잘못된 매핑 수정 (way ↔ technKnow)
```

---

## 📊 현재 데이터 수집 현황

### CareerNet (46개 필드)
✅ **기본 필드**: 12개
✅ **확장 배열 필드**: 34개 (workList, performList, abilityList 등)

### Goyong24 (26개 필드)
✅ **요약 섹션**: 21개
✅ **직무 섹션**: 2개
✅ **경로 섹션**: 3개

### 총합
**72개 고유 필드** (일부 중복 제외)

---

## 🚀 테스트 방법

### 1. 일반 페이지 확인
```
https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/lawyer
```
→ 사용자 친화적인 정리된 정보

### 2. 디버그 페이지 확인
```
https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/job:C_375
```
→ 완전한 원본 API 응답 및 데이터 비교

### 3. 다른 직업 디버그 모드
```
https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/소프트웨어개발자?debug=true
```
→ 아무 직업에나 `?debug=true` 추가

---

## 🔧 코드 위치 요약

| 기능 | 파일 | 함수/영역 |
|------|------|-----------|
| 변호사 식별 | `src/services/profileDataService.ts` | `matchesLawyerIdentifier()` (line 131) |
| CareerNet API | `src/api/careernetAPI.ts` | `getJobDetail()` (line 337) |
| Goyong24 API | `src/api/goyong24API.ts` | `fetchGoyong24JobDetail()` (line 681) |
| 데이터 병합 | `src/services/profileMerge.ts` | `mergeJobProfiles()` |
| 디버그 템플릿 | `src/templates/dataDebugTemplate.ts` | `renderDataDebugPage()` |
| 라우팅 | `src/index.tsx` | `/job/:slug` (line 2047) |

---

## 📋 다음 단계 제안

1. ✅ `/job/job:C_375` 페이지에서 **실제 API 응답 확인**
2. ⬜ 누락된 필드 발견 시 추가 구현
3. ⬜ 다른 직업들도 동일하게 데이터 수집 확인
4. ⬜ 필드 우선순위 및 중요도 조정
5. ⬜ UI/UX 개선 (너무 많은 데이터 표시 문제)
