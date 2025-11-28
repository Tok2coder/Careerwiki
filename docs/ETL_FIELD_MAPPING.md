# ETL 필드 매핑 (ETL → 템플릿 섹션)

> **작성일**: 2025-01-XX  
> **목적**: ETL이 생성하는 `merged_profile_json` 필드와 템플릿 섹션 매핑

---

## 1. 히어로 섹션

### 1.1. 카테고리 (제목 위)
**ETL 필드**: `heroCategory` (조건부 병합)

**원본 소스 경로**:
- `WORK24_JOB.summary.jobLrclNm` (대분류)
- `WORK24_JOB.summary.jobMdclNm` (중분류)
- `WORK24_JOB.summary.jobSmclNm` (소분류)
- 또는 `CAREERNET.encyclopedia.baseInfo.aptit_name`
- 또는 `WORK24_DJOB.optionJobInfo.dJobICdNm`

**병합 규칙**: 
- 고용24 직업정보에 대/중/소분류가 모두 있으면 브레드크럼 형식
- 없으면 단일 값 (커리어넷 → 직업사전 순)

---

### 1.2. 직업명 (제목)
**ETL 필드**: `heroTitle`

**원본 소스 경로**:
- `CAREERNET.name` (1순위)
- `WORK24_JOB.summary.jobNm` (2순위)
- `WORK24_DJOB.dJobNm` (3순위)

---

### 1.3. 직업 소개 (직업명 아래)
**ETL 필드**: `heroIntro`

**원본 소스 경로**:
- `CAREERNET.summary` (1순위)
- `WORK24_JOB.duty.jobSum` 또는 `WORK24_JOB.summary.jobSum` (2순위)
- `WORK24_DJOB.workSum` (3순위)

---

### 1.5. 태그 (이미지 아래)
**ETL 필드**: `heroTags` (배열, 중복제거)

**원본 소스 경로**:
- `CAREERNET.encyclopedia.baseInfo.tag` (문자열, 쉼표/공백 분리)
- `CAREERNET.encyclopedia.tagList` (배열)
- `WORK24_DJOB.optionJobInfo.similarNm` (유사 직업명)
- `WORK24_DJOB.optionJobInfo.connectJob` (연관 직업)

**병합 규칙**: 쉼표/공백 기준 split 후 중복제거

---

## 2. 본 섹션 - 개요 탭

### 2.1.1. 주요 업무
**ETL 필드**: `summary`, `duties`, `doWork`, `workStrong`, `workPlace`, `physicalAct`

**원본 소스 경로**:
- `CAREERNET.summary` (1순위, 우선 선택)
- `WORK24_JOB.duty.execJob` (2순위)
- `WORK24_DJOB.doWork` (3순위)
- `WORK24_DJOB.optionJobInfo.workStrong` (작업강도, 무조건 표시)
- `WORK24_DJOB.optionJobInfo.workPlace` (작업장소, 무조건 표시)
- `WORK24_DJOB.optionJobInfo.physicalAct` (육체활동, 무조건 표시)

**병합 규칙**: 
- 1-3번: 우선순위에 따라 하나만 선택
- 4-6번: 있으면 무조건 표시 (소제목 포함)

---

### 2.1.2. 커리어 전망
**ETL 필드**: `forecastList`, `prospect`, `jobSumProspect`

**원본 소스 경로**:
- `CAREERNET.encyclopedia.forecastList` (1순위, 배열)
- `WORK24_JOB.salProspect.jobProspect` (2순위)
- `WORK24_JOB.summary.jobProspect` (3순위)
- `WORK24_JOB.salProspect.jobSumProspect` (전망 요약 차트, 고용24 사용 시 함께 표시)

---

### 2.1.3. 핵심 능력·자격
**ETL 필드**: `abilityList`, `curriculum`, `technKnow`, `eduLevel`, `skillYear`

**원본 소스 경로**:
- `CAREERNET.encyclopedia.abilityList` (핵심 역량, 배열)
- `CAREERNET.encyclopedia.jobReadyList.curriculum` (정규교육과정)
- `WORK24_JOB.path.technKnow` (필수 기술 및 지식)
- `WORK24_DJOB.optionJobInfo.eduLevel` (교육수준)
- `WORK24_DJOB.optionJobInfo.skillYear` (숙련기간)

**병합 규칙**: 모두 있으면 무조건 표시 (소제목 포함)

---

### 2.1.4. 적성 및 흥미
**ETL 필드**: `aptitudeList`, `interestList`

**원본 소스 경로**:
- `CAREERNET.encyclopedia.aptitudeList` (적성, 배열)
- `CAREERNET.encyclopedia.interestList` (흥미, 배열)

---

### 2.1.5. 임금 정보
**ETL 필드**: `salary`

**원본 소스 경로**:
- `WORK24_JOB.salProspect.sal` (1순위)
- `WORK24_JOB.summary.sal` (2순위)
- `CAREERNET.encyclopedia.baseInfo.wage` (3순위)

---

### 2.1.6. 여담
**ETL 필드**: 없음 (유저 기여 공간)

---

## 2. 본 섹션 - 상세정보 탭

### 2.2.1. 업무 상세
**ETL 필드**: `duties`, `workList`

**원본 소스 경로**:
- `CAREERNET.duties`
- `CAREERNET.workList` (배열)
- `WORK24_JOB.duty.execJob`

---

### 2.2.2. 학력·전공 분포
**ETL 필드**: `educationDistribution`, `majorDistribution`

**원본 소스 경로**:
- `WORK24_JOB.path.edubg` (학력분포)
- `WORK24_JOB.path.schDpt` (전공학과분포)

---

### 2.2.3. 한국의 직업지표 (개요→상세 이동)
**ETL 필드**: `indicatorChart`

**원본 소스 경로**:
- `CAREERNET.encyclopedia.indicatorChart` (7개 지표 배열)

---

### 2.2.4. 워라밸 & 사회적 평가
**ETL 필드**: `wlb`, `social`

**원본 소스 경로**:
- `CAREERNET.encyclopedia.baseInfo.wlb` (워라밸)
- `CAREERNET.encyclopedia.baseInfo.social` (사회적 평가)

---

### 2.2.5. 직업 준비하기
**ETL 필드**: `jobReadyList`, `way`

**원본 소스 경로**:
- `CAREERNET.encyclopedia.jobReadyList`
- `WORK24_JOB.path.technKnow` (필수 기술 및 지식)
- `WORK24_JOB.path.relMajorList` (관련전공)
- `WORK24_JOB.path.relCertList` (관련자격증)

---

### 2.2.6. 직업 분류
**ETL 필드**: `category`, `classifications`, `kecoCodes`

**원본 소스 경로**:
- `CAREERNET.category`
- `WORK24_JOB.summary.jobLrclNm`, `jobMdclNm`, `jobSmclNm`
- `WORK24_JOB.path.kecoList` (KECO 코드)

---

## 2. 본 섹션 - 업무특성 탭

### 2.3.1. 필수 지식
**ETL 필드**: `knowledge`

**원본 소스 경로**:
- `CAREERNET.knowledge`
- `WORK24_JOB.ablKnwEnv.Knwldg` (지식 중요도)

---

### 2.3.2. 고용 현황
**ETL 필드**: `status`

**원본 소스 경로**:
- `WORK24_JOB.salProspect.jobStatus` (일자리현황)
- `WORK24_JOB.salProspect.jobStatusList` (일자리현황 리스트)

---

### 2.3.3. 근무 환경
**ETL 필드**: `environment`

**원본 소스 경로**:
- `CAREERNET.environment`
- `WORK24_JOB.ablKnwEnv.jobsEnv` (업무환경)

---

### 2.3.4. 업무 수행 지표
**ETL 필드**: `performList`, `activitiesImportance`, `activitiesLevels`

**원본 소스 경로**:
- `CAREERNET.encyclopedia.performList`
- `WORK24_JOB.actv.jobActvImprtnc` (업무활동 중요도)
- `WORK24_JOB.actv.jobActvLvl` (업무활동 수준)

---

## 3. 사이드바

### 3.1. 연관 직업
**ETL 필드**: `relatedJobs` (배열)

**원본 소스 경로**:
- `CAREERNET.encyclopedia.relJobList`
- `WORK24_JOB.summary.relJobList`
- `WORK24_JOB.duty.relJobList`

---

### 3.2. 관련 전공
**ETL 필드**: `relatedMajors` (배열)

**원본 소스 경로**:
- `CAREERNET.encyclopedia.relMajorList`
- `WORK24_JOB.summary.relMajorList`
- `WORK24_JOB.path.relMajorList`

---

### 3.3. 관련 기관
**ETL 필드**: `relatedOrganizations` (배열)

**원본 소스 경로**:
- `CAREERNET.encyclopedia.relOrgList`
- `WORK24_JOB.path.relOrgList`

---

### 3.4. 추천 자격증
**ETL 필드**: `relatedCertificates` (배열)

**원본 소스 경로**:
- `CAREERNET.encyclopedia.relCertList`
- `WORK24_JOB.summary.relCertList`
- `WORK24_JOB.path.relCertList`

---

## 📝 참고사항

1. **우선순위 병합**: `mergeFieldByPriority()` 함수 사용 (CAREERNET → WORK24_JOB → WORK24_DJOB)
2. **배열 병합**: `mergeArrayFields()` 함수 사용 (중복제거 포함)
3. **조건부 병합**: 히어로 카테고리는 특수 로직 적용
4. **소제목 추가**: 템플릿에서 처리 (ETL은 데이터만 제공)

