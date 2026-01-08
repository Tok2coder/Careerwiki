# 직업 데이터 병합 로직 (Job Data Merge Logic)

## 개요

이 문서는 각 데이터 소스 조합별로 **어떤 필드를 어떻게 병합**하여 최종 직업 페이지를 렌더링할지 정의합니다.

- **ETL (`mergeJobProfiles.ts`)**: 데이터 병합 + 중복 제거 + 정규화
- **템플릿 (`unifiedJobDetail.ts`)**: 스타일링만

## 데이터 소스 우선순위 원칙

### 기본 원칙
1. **고용24 직업정보 (WORK24_JOB)** > **커리어넷 (CAREERNET)** > **고용24 직업사전 (WORK24_DJOB)**
2. 고용24 직업정보가 가장 최신이고 상세한 데이터
3. 커리어넷은 진로·교육 관련 데이터가 풍부
4. 고용24 직업사전은 기본 정보만 제공

### 예외 사항
- **진로탐색활동 (researchList)**: 커리어넷만 제공
- **백과사전 정보 (encyclopedia)**: 커리어넷만 제공
- **학력·전공 분포**: 커리어넷이 더 상세
- **워라밸, 사회적 기여도**: 커리어넷만 제공

---

## 케이스별 병합 로직

### Case 1: 커리어넷 + 고용24직업 + 고용24사전 (완전 데이터)

**테스트 직업**: 가상현실전문가, 간호사, 간호조무사

#### 히어로 섹션
- `heroTitle`: `profile.name` (병합된 이름)
- `heroDescription`: 우선순위
  1. `profile.heroIntro` (ETL에서 병합)
  2. `profile.summary` (ETL에서 병합, 고용24직업 > 커리어넷)
  3. `rawApiData.goyong24.duty.jobSum`
- `heroCategory`: `profile.heroCategory` (ETL에서 병합)
- `heroTags`: `profile.heroTags` (ETL에서 병합)

#### 개요 탭

##### 주요 업무
- `workMainDesc`: `profile.doWork` (고용24사전) > `profile.summary` (고용24직업) > `profile.duties` (커리어넷)
- `workStrong`: `profile.workStrong` (고용24사전 전용)
- `workPlace`: `profile.workPlace` (고용24사전 전용)
- `physicalAct`: `profile.physicalAct` (고용24사전 전용)

##### 커리어 전망
- `prospectPrimary`: `profile.prospect` (고용24직업 > 커리어넷)
- `jobSumProspect`: `profile.goyong24Only.prospectChart` (고용24직업 전용 - 재직자 설문)
- `forecastList`: `profile.forecastList` (커리어넷 전용 - 기간별 전망)

##### 한국의 직업지표
- `indicatorChart`: `profile.indicatorChart` (커리어넷 전용)

##### 핵심 능력·자격
- `abilityList`: `profile.abilityList` (병합, 고용24직업 > 커리어넷)
- `eduLevel`: `profile.eduLevel` (고용24사전 전용)
- `skillYear`: `profile.skillYear` (고용24사전 전용)
- `curriculum`: `profile.jobReadyList.curriculum` (커리어넷 전용)

##### 적성 및 흥미
- `satisfaction`: `profile.satisfaction` (커리어넷 전용)
- `personality`: `profile.personality` (고용24직업 > 커리어넷)
- `interests`: `profile.interests` (고용24직업 > 커리어넷)
- `values`: `profile.values` (고용24직업 > 커리어넷)

##### 임금 정보
- `salary`: `profile.salary` (고용24직업 > 커리어넷)

#### 상세정보 탭

##### 업무 상세
- `duties`: `profile.duties` (커리어넷 전용)
  - **중복 제거 로직**: 개요 탭의 "주요 업무"에서 커리어넷 duties가 사용되었으면 상세정보 탭에서는 숨김

##### 학력·전공 분포
- `educationDistribution`: `profile.educationDistribution` (커리어넷 > 고용24직업)
- `majorDistribution`: `profile.majorDistribution` (커리어넷 > 고용24직업)

##### 워라밸 & 사회적 평가
- `wlb`: `profile.careernetOnly.wlb` (커리어넷 전용)
- `social`: `profile.careernetOnly.social` (커리어넷 전용)

##### 교육·자격
- `technKnow`: `profile.technKnow` (고용24직업 전용)

##### 직업 준비하기
- `jobReadyList.recruit`: `profile.jobReadyList.recruit` (커리어넷 전용)
- `jobReadyList.certificate`: `profile.jobReadyList.certificate` (커리어넷 전용)
  - **ETL에서 중복 제거**: `relatedCertificates`와 겹치는 항목 제거
- `jobReadyList.training`: `profile.jobReadyList.training` (커리어넷 전용)
- `jobReadyList.curriculum`: `profile.jobReadyList.curriculum` (커리어넷 전용)
- `researchList`: `profile.researchList` (커리어넷 전용 - 진로 탐색 활동)

##### 직업 분류 체계
- `classifications`: `profile.classifications` (병합, 커리어넷 > 고용24직업)

#### 업무특성 탭

##### 필수 지식
- `knowledge`: `profile.knowledge` (고용24직업 > 커리어넷)

##### 고용 현황
- `status`: `profile.status` (고용24직업 > 커리어넷)

##### 근무 환경
- `environment`: `profile.environment` (고용24직업 > 커리어넷)

##### 업무수행능력
- `goyong24Only.workEnvironment`: 고용24직업 전용 (직업 내/간 비교 표)

##### 지식
- `goyong24Only.workEnvironment.KnwldgCmpr`: 고용24직업 전용 (직업 내/간 비교 표)

##### 업무환경
- `goyong24Only.workEnvironment.jobsEnvCmpr`: 고용24직업 전용
- `careernetOnly.performList.environment`: 커리어넷 전용 (중요도 표)

##### 성격
- `goyong24Only.personality`: 고용24직업 전용 (직업 내/간 비교 표)

##### 흥미
- `goyong24Only.interest`: 고용24직업 전용 (직업 내/간 비교 표)

##### 가치관
- `goyong24Only.values`: 고용24직업 전용 (직업 내/간 비교 표)

##### 업무활동
- `goyong24Only.activity`: 고용24직업 전용 (직업 내/간 비교 표)

#### 사이드바

##### 연관 직업
- `relatedJobs`: `profile.relatedJobs` (병합, 모든 소스)

##### 관련 전공
- `relatedMajors`: `profile.relatedMajors` (병합, 모든 소스)

##### 관련 기관
- `relatedOrganizations`: `profile.relatedOrganizations` (병합, 모든 소스)

##### 추천 자격증
- `relatedCertificates`: `profile.relatedCertificates` (병합, 모든 소스)

---

### Case 2: 커리어넷 + 고용24직업

**테스트 직업**: 가수, 경제학연구원, 공업기계설치 및 정비원

#### 차이점
- 고용24사전 전용 필드 **없음**:
  - `workStrong`, `workPlace`, `physicalAct` 제거
  - `eduLevel`, `skillYear` 제거
- 나머지는 **Case 1과 동일**

---

### Case 3: 커리어넷 + 고용24사전

**테스트 직업**: 간병인, 간판제작원, 건축사

#### 차이점
- 고용24직업 전용 필드 **없음**:
  - 업무특성 탭의 모든 비교 표 제거 (`goyong24Only.*`)
  - `jobSumProspect` (재직자 설문 차트) 제거
  - `technKnow` 제거
- 고용24사전 필드 **사용**:
  - `workStrong`, `workPlace`, `physicalAct` 사용
  - `eduLevel`, `skillYear` 사용
- 커리어넷 필드 우선 사용
- **히어로 섹션 `workMainDesc`**: `profile.doWork` (고용24사전) > `profile.duties` (커리어넷)

---

### Case 4: 고용24직업 + 고용24사전

**테스트 직업**: 3D프린팅모델러, 가사관리사, 감사사무원

#### 차이점
- 커리어넷 전용 필드 **없음**:
  - `indicatorChart` 제거
  - `satisfaction` 제거
  - `wlb`, `social` 제거
  - `jobReadyList` 제거
  - `researchList` 제거
  - `forecastList` 제거
  - `careernetOnly.performList.environment` 제거
- 고용24직업 + 고용24사전 필드만 사용
- **히어로 섹션 `workMainDesc`**: `profile.doWork` (고용24사전) > `profile.summary` (고용24직업)

---

### Case 5: 고용24사전만

**테스트 직업**: 3D지도개발자, 3D프린터설치정비원, 3D프린팅운영기사

#### 사용 가능 필드
- `name`, `doWork`, `workStrong`, `workPlace`, `physicalAct`
- `eduLevel`, `skillYear`
- 기본 분류 정보 (`classifications`)

#### 제거 필드
- 고용24직업 전용 필드 전부
- 커리어넷 전용 필드 전부
- 업무특성 탭 대부분 제거 (데이터 없음)

#### 템플릿 표시
- **개요 탭**: "주요 업무" 섹션만 표시
  - `doWork`, `workStrong`, `workPlace`, `physicalAct`
  - `eduLevel`, `skillYear`
- **상세정보 탭**: 거의 비어있음 (분류 정보만)
- **업무특성 탭**: 비어있음

---

### Case 6: 커리어넷만

**테스트 직업**: GIS전문가, IT컨설턴트, 가구제조,수리원

#### 사용 가능 필드
- 커리어넷 모든 필드
- 백과사전 정보 (`encyclopedia`)
- `jobReadyList`, `researchList`
- `indicatorChart`, `forecastList`
- `satisfaction`, `wlb`, `social`

#### 제거 필드
- 고용24직업 전용 필드 전부 (`goyong24Only.*`)
- 고용24사전 전용 필드 전부 (`workStrong`, `workPlace`, `physicalAct`, `eduLevel`, `skillYear`)

#### 템플릿 표시
- **개요 탭**: 커리어넷 데이터로 완성
- **상세정보 탭**: 커리어넷 데이터로 완성
- **업무특성 탭**: 커리어넷 기본 필드만 사용 (비교 표 없음)

---

### Case 7: 고용24직업만

**테스트 직업**: IT기술지원전문가, IT테스터 및 IT QA전문가, UX·UI디자이너

#### 사용 가능 필드
- 고용24직업 모든 필드
- `goyong24Only.*` (비교 표 데이터)
- `jobSumProspect` (재직자 설문)
- `technKnow`

#### 제거 필드
- 커리어넷 전용 필드 전부
- 고용24사전 전용 필드 전부

#### 템플릿 표시
- **개요 탭**: 고용24직업 데이터로 구성
  - "재직자가 생각하는 일자리 전망" 차트 우선 표시
  - `indicatorChart` 없음
- **상세정보 탭**: 기본 정보만
- **업무특성 탭**: 고용24직업 비교 표 데이터 모두 표시

---

## ETL 업데이트 체크리스트

### `mergeJobProfiles.ts`에서 수정할 사항

1. **heroIntro 병합 로직**:
   - 고용24직업 `duty.jobSum` 우선
   - 커리어넷 `summary` 첫 문장 fallback

2. **workMainDesc 병합 로직**:
   - `doWork` (고용24사전) > `summary` (고용24직업) > `duties` (커리어넷)
   - 소스별로 우선순위 명확히

3. **jobReadyList.certificate 중복 제거**:
   - ✅ 이미 구현됨

4. **duties 중복 제거 플래그 추가**:
   - `overviewUsesCareernetDuty` 플래그를 merged_profile_json에 포함
   - 템플릿에서 이 플래그 기반으로 상세정보 탭의 "업무 상세" 표시 여부 결정

5. **소스별 분리 저장**:
   - `careernetOnly`, `goyong24Only` 구조 유지
   - 원본 API 데이터도 `rawApiData`로 저장 (디버그용)

---

## 템플릿 업데이트 체크리스트

### `unifiedJobDetail.ts`에서 수정할 사항

1. **데이터 병합 로직 제거**:
   - ✅ ETL에서 이미 병합된 데이터를 그대로 사용
   - ✅ `jobReadyList.certificate` 중복 제거 로직 제거 완료

2. **Fallback 로직 단순화**:
   - `profile.field || fallback` 형태로 단순화
   - `rawApiData` 접근 최소화 (ETL에서 이미 병합됨)

3. **조건부 렌더링**:
   - 필드가 없으면 섹션 자체를 숨김
   - "정보 준비 중" 메시지는 탭 레벨에서만 표시

4. **스타일링 개선**:
   - 데이터 로직은 ETL에, 프레젠테이션은 템플릿에
   - Tailwind CSS 클래스 일관성 유지

---

## 다음 단계

1. ✅ **ETL 실행**: `run-test-etl.ps1` 실행하여 21개 직업 병합
2. **각 케이스별 페이지 확인**: `TEST_JOBS_MATRIX.md` URL로 테스트
3. **병합 로직 검증**: 각 케이스별로 올바른 필드가 표시되는지 확인
4. **ETL `mergeJobProfiles.ts` 업데이트**: 위 체크리스트 기반으로 수정
5. **템플릿 `unifiedJobDetail.ts` 정리**: 스타일링만 남기고 데이터 로직 제거
6. **템플릿 버전 업데이트**: `JOB` 버전 증가하여 캐시 무효화






