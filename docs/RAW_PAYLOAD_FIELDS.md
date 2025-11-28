# Raw Payload 필드 구조 문서

각 API에서 받아오는 raw_payload의 전체 필드 구조입니다.
이 문서는 정규화 함수 개선 및 ETL 병합 규칙 설계의 기초 자료입니다.

---

## 1. CAREERNET (커리어넷 직업백과)

### API 엔드포인트
- `https://www.career.go.kr/cnet/front/openapi/job.json`
- 정규화 함수: `normalizeCareerNetJobDetail()` in `src/api/careernetAPI.ts`

### Raw Payload 구조 (`JobEncyclopediaResponse`)

```typescript
{
  baseInfo?: {
    seq?: number                    // 직업 시퀀스
    job_cd?: number                 // 직업 코드
    job_nm?: string                 // 직업명
    aptit_name?: string             // 적성유형명 (예: "연구형")
    emp_job_cd?: string | number    // 고용직업분류코드
    emp_job_nm?: string             // 고용직업분류명
    std_job_cd?: string             // 표준직업분류코드
    std_job_nm?: string             // 표준직업분류명
    rel_job_nm?: string             // 관련직업명 (쉼표 구분)
    wage?: number                   // 평균 임금 (만원)
    wage_source?: string            // 임금 출처
    satisfication?: number          // 직업 만족도
    satisfi_source?: string         // 만족도 출처
    social?: string                 // 사회적 평판
    wlb?: string                    // 워라밸 평가
    INTRST_JOB_YN?: string          // 관심직업 여부
    views?: number                  // 조회수
    likes?: number                  // 좋아요 수
    tag?: string                    // 태그 (쉼표 구분)
    reg_dt?: string                 // 등록일
    edit_dt?: string                // 수정일
  }
  
  workList?: Array<{                // 하는 일 목록
    work?: string                   // 업무 설명
  }>
  
  abilityList?: Array<{             // 핵심 역량 목록
    ability_name?: string           // 역량명
    SORT_ORDR?: string              // 정렬 순서
  }>
  
  departList?: Array<{              // 관련 학과 목록
    depart_id?: number              // 학과 ID
    depart_name?: string            // 학과명
  } | null>
  
  certiList?: Array<{               // 관련 자격증 목록
    certi?: string                  // 자격증명
    LINK?: string                   // 링크
  }>
  
  aptitudeList?: Array<{            // 적성 목록
    aptitude?: string               // 적성
  }>
  
  interestList?: Array<{            // 흥미 목록
    interest?: string               // 흥미
  }>
  
  tagList?: string[]                // 태그 목록
  
  researchList?: Array<{            // 진로탐색활동 목록
    research?: string               // 활동 내용
  }>
  
  relVideoList?: Array<{            // 관련 영상 목록
    video_id?: string               // 영상 ID
    video_name?: string             // 영상 제목
    job_cd?: string                 // 직업 코드
    CID?: string                    // CID
    THUMBNAIL_FILE_SER?: string     // 썸네일 파일 번호
    THUMNAIL_PATH?: string          // 썸네일 경로
    OUTPATH3?: string               // 외부 경로
  }>
  
  relSolList?: Array<{              // 관련 솔루션 목록
    cnslt_seq?: number              // 상담 시퀀스
    cnslt?: string                  // 상담 내용
    SJ?: string                     // 제목
    CN?: string                     // 내용
    TRGET_SE?: string               // 대상 구분
    REGIST_DT?: string              // 등록일
  }>
  
  relJinsolList?: Array<{           // 관련 진솔 목록
    SEQ?: number                    // 시퀀스
    ALT?: string                    // 대체 텍스트
    SUBJECT?: string                // 제목
    THUMBNAIL?: string              // 썸네일
  }>
  
  jobReadyList?: {                  // 직업 준비 정보
    recruit?: Array<{               // 입직 방법
      recruit?: string
    }>
    certificate?: Array<{           // 관련 자격증
      certificate?: string
    }>
    training?: Array<{              // 관련 교육훈련
      training?: string
    }>
    curriculum?: Array<{            // 관련 정규교육과정
      curriculum?: string
    }>
  }
  
  jobRelOrgList?: Array<{           // 관련 기관 목록
    rel_org?: string                // 기관명
    rel_org_url?: string            // 기관 URL
  }>
  
  forecastList?: Array<{            // 직업전망 목록
    forecast?: string               // 전망 내용
  }>
  
  eduChart?: Array<{                // 학력 분포 차트
    chart_name?: string             // 차트명
    chart_data?: string             // 차트 데이터
    source?: string                 // 출처
  }>
  
  majorChart?: Array<{              // 전공 분포 차트
    major?: string                  // 전공명
    major_data?: string             // 데이터
    source?: string                 // 출처
  }>
  
  indicatorChart?: Array<{          // 직업지표 차트
    indicator?: string              // 지표명
    indicator_data?: string         // 지표 데이터
    source?: string                 // 출처
  }>
  
  performList?: {                   // 업무수행 정보
    environment?: Array<{           // 업무환경
      environment?: string          // 환경명
      inform?: string               // 설명
      importance?: number           // 중요도
      source?: string               // 출처
    }>
    perform?: Array<{               // 업무수행능력
      perform?: string              // 능력명
      inform?: string               // 설명
      importance?: number           // 중요도
      source?: string               // 출처
    }>
    knowledge?: Array<{             // 필요지식
      knowledge?: string            // 지식명
      inform?: string               // 설명
      importance?: number           // 중요도
      source?: string               // 출처
    }>
  }
}
```

### 현재 정규화 매핑 상태

| Raw 필드 | Normalized 필드 | 매핑 상태 |
|---------|----------------|---------|
| `baseInfo.job_nm` | `name` | ✅ 매핑됨 |
| `baseInfo.aptit_name` | `classifications.large` | ✅ 매핑됨 |
| `baseInfo.rel_job_nm` | `relatedJobs` | ✅ 매핑됨 |
| `baseInfo.wage` | `salary` | ✅ 매핑됨 |
| `baseInfo.satisfication` | `satisfaction` | ✅ 매핑됨 |
| `baseInfo.social` | ❌ | ❌ 누락 (ETL에서 직접 사용) |
| `baseInfo.wlb` | ❌ | ❌ 누락 (ETL에서 직접 사용) |
| `baseInfo.tag` | ❌ | ❌ 누락 |
| `workList` | `summary`, `duties`, `workList` | ✅ 매핑됨 |
| `abilityList` | `abilities`, `abilityList` | ✅ 매핑됨 |
| `departList` | `relatedMajors` | ✅ 매핑됨 |
| `certiList` | `relatedCertificates` | ✅ 매핑됨 |
| `aptitudeList` | `personality`, `aptitudeList` | ✅ 매핑됨 |
| `interestList` | `interests`, `interestList` | ✅ 매핑됨 |
| `tagList` | ❌ | ❌ 누락 |
| `researchList` | `researchList` | ✅ 매핑됨 |
| `relVideoList` | `relVideoList` | ✅ 매핑됨 |
| `relSolList` | `relSolList` | ✅ 매핑됨 |
| `relJinsolList` | `relJinsolList` | ✅ 매핑됨 |
| `jobReadyList` | `jobReadyList` | ✅ 매핑됨 |
| `jobRelOrgList` | `relatedOrganizations` | ✅ 매핑됨 |
| `forecastList` | `prospect`, `forecastList` | ✅ 매핑됨 |
| `eduChart` | ❌ | ❌ 누락 |
| `majorChart` | ❌ | ❌ 누락 |
| `indicatorChart` | `indicatorChart` | ✅ 매핑됨 |
| `performList` | `performList` | ✅ 매핑됨 |

---

## 2. WORK24_JOB (고용24 직업정보)

### API 엔드포인트
- `https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212D01~07.do`
- 정규화 함수: `normalizeGoyong24JobDetail()` in `src/api/goyong24API.ts`

### Raw Payload 구조 (`Goyong24JobDetailAggregated`)

7개 API 섹션으로 구성됩니다:

#### 2.1 Summary 섹션 (D01)
```typescript
summary?: {
  jobCd: string                     // 직업코드
  jobNm?: string                    // 직업명
  jobLrclNm?: string                // 대분류명
  jobMdclNm?: string                // 중분류명
  jobSmclNm?: string                // 소분류명
  jobSum?: string                   // 직업 요약
  way?: string                      // 되는 방법 (실제로는 직업설명)
  sal?: string                      // 평균 연봉
  jobSatis?: string                 // 직업 만족도
  jobProspect?: string              // 직업 전망
  jobStatus?: string                // 고용 현황
  jobAbil?: string                  // 업무수행능력
  knowldg?: string                  // 지식
  jobEnv?: string                   // 업무환경
  jobChr?: string                   // 성격
  jobIntrst?: string                // 흥미
  jobVals?: string                  // 가치관
  jobActvImprtncs?: string          // 업무활동 중요도
  jobActvLvls?: string              // 업무활동 수준
  relMajorList?: Array<{            // 관련 학과
    majorCd: string
    majorNm: string
  }>
  relCertList?: string[]            // 관련 자격증
  relJobList?: Array<{              // 관련 직업
    jobCd: string
    jobNm: string
  }>
}
```

#### 2.2 Duty 섹션 (D02) - 수행직무
```typescript
duty?: {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  jobSum?: string                   // 직업 요약
  execJob?: string                  // 수행직무 상세
  relJobList?: Array<{
    jobCd: string
    jobNm: string
  }>
}
```

#### 2.3 Path 섹션 (D03) - 되는 방법
```typescript
path?: {
  jobCd: string
  technKnow?: string                // 필요기술 및 지식 (실제로는 되는 방법)
  educationDistribution?: {         // 학력 분포
    middleSchoolOrLess?: string
    highSchool?: string
    college?: string
    university?: string
    graduate?: string
    doctor?: string
  }
  majorDistribution?: {             // 전공 분포
    humanities?: string
    social?: string
    education?: string
    engineering?: string
    natural?: string
    medical?: string
    artsSports?: string
  }
  relMajorList?: Array<{
    majorCd: string
    majorNm: string
  }>
  relOrgList?: Array<{              // 관련 기관
    orgNm: string
    orgSiteUrl?: string
  }>
  relCertList?: string[]
  kecoList?: Array<{                // 한국표준직업분류
    kecoCd: string
    kecoNm: string
  }>
}
```

#### 2.4 SalProspect 섹션 (D04) - 임금/전망
```typescript
salProspect?: {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  sal?: string                      // 평균 연봉
  jobSatis?: string                 // 직업 만족도
  jobProspect?: string              // 직업 전망 텍스트
  jobSumProspect?: Array<{          // 재직자 전망 데이터 (차트용)
    jobProspectNm: string           // 전망명 (증가, 유지, 감소 등)
    jobProspectRatio: string        // 비율
    jobProspectInqYr: string        // 조사년도
  }>
  jobStatusList?: Array<{
    jobCd: string
    jobNm: string
  }>
}
```

#### 2.5 AblKnwEnv 섹션 (D05) - 능력/지식/환경
```typescript
ablKnwEnv?: {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  // 업무수행능력 비교
  jobAbilCmpr?: Array<{
    jobAblStatusCmpr: string        // 상태 (높음/보통/낮음)
    jobAblNmCmpr: string            // 능력명
    jobAblContCmpr: string          // 설명
  }>
  jobAbil?: Array<{
    jobAblStatus: string
    jobAblNm: string
    jobAblCont: string
  }>
  // 업무수행능력 수준 비교
  jobAbilLvlCmpr?: Array<{...}>
  jobAbilLvl?: Array<{...}>
  // 지식 비교
  KnwldgCmpr?: Array<{
    knwldgStatusCmpr: string
    knwldgNmCmpr: string
    knwldgContCmpr: string
  }>
  Knwldg?: Array<{
    knwldgStatus: string
    knwldgNm: string
    knwldgCont: string
  }>
  // 지식 수준 비교
  KnwldgLvlCmpr?: Array<{...}>
  KnwldgLvl?: Array<{...}>
  // 업무환경 비교
  jobsEnvCmpr?: Array<{
    jobEnvStatusCmpr: string
    jobEnvNmCmpr: string
    jobEnvContCmpr: string
  }>
  jobsEnv?: Array<{
    jobEnvStatus: string
    jobEnvNm: string
    jobEnvCont: string
  }>
}
```

#### 2.6 ChrIntrVals 섹션 (D06) - 성격/흥미/가치관
```typescript
chrIntrVals?: {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  // 성격 비교
  jobChrCmpr?: Array<{
    chrStatusCmpr: string
    chrNmCmpr: string
    chrContCmpr: string
  }>
  jobChr?: Array<{
    chrStatus: string
    chrNm: string
    chrCont: string
  }>
  // 흥미 비교
  jobIntrstCmpr?: Array<{
    intrstStatusCmpr: string
    intrstNmCmpr: string
    intrstContCmpr: string
  }>
  jobIntrst?: Array<{
    intrstStatus: string
    intrstNm: string
    intrstCont: string
  }>
  // 가치관 비교
  jobValsCmpr?: Array<{
    valsStatusCmpr: string
    valsNmCmpr: string
    valsContCmpr: string
  }>
  jobVals?: Array<{
    valsStatus: string
    valsNm: string
    valsCont: string
  }>
}
```

#### 2.7 Actv 섹션 (D07) - 업무활동
```typescript
actv?: {
  jobCd: string
  jobLrclNm?: string
  jobMdclNm?: string
  jobSmclNm?: string
  // 업무활동 중요도 비교
  jobActvImprtncCmpr?: Array<{
    jobActvImprtncStatusCmpr: string
    jobActvImprtncNmCmpr: string
    jobActvImprtncContCmpr: string
  }>
  jobActvImprtnc?: Array<{
    jobActvImprtncStatus: string
    jobActvImprtncNm: string
    jobActvImprtncCont: string
  }>
  // 업무활동 수준 비교
  jobActvLvlCmpr?: Array<{
    jobActvLvlStatusCmpr: string
    jobActvLvlNmCmpr: string
    jobActvLvlContCmpr: string
  }>
  jobActvLvl?: Array<{
    jobActvLvlStatus: string
    jobActvLvlNm: string
    jobActvLvlCont: string
  }>
}
```

### 현재 정규화 매핑 상태

| Raw 필드 | Normalized 필드 | 매핑 상태 |
|---------|----------------|---------|
| `summary.jobNm` | `name` | ✅ 매핑됨 |
| `summary.jobLrclNm/jobMdclNm/jobSmclNm` | `classifications` | ✅ 매핑됨 |
| `summary.way` | `summary` | ✅ 매핑됨 (필드명 혼동 주의) |
| `summary.jobSum` | `summary` (fallback) | ✅ 매핑됨 |
| `duty.execJob` | `duties` | ✅ 매핑됨 |
| `duty.jobSum` | `duties` (fallback) | ✅ 매핑됨 |
| `path.technKnow` | `way` | ✅ 매핑됨 (필드명 혼동 주의) |
| `path.educationDistribution` | `educationDistribution` | ✅ 매핑됨 |
| `path.majorDistribution` | `majorDistribution` | ✅ 매핑됨 |
| `path.relMajorList` | `relatedMajors` | ✅ 매핑됨 |
| `path.relOrgList` | `relatedOrganizations` | ✅ 매핑됨 |
| `path.relCertList` | `relatedCertificates` | ✅ 매핑됨 |
| `path.kecoList` | `kecoCodes` | ✅ 매핑됨 |
| `summary.sal` / `salProspect.sal` | `salary` | ✅ 매핑됨 |
| `summary.jobSatis` / `salProspect.jobSatis` | `satisfaction` | ✅ 매핑됨 |
| `summary.jobProspect` / `salProspect.jobProspect` | `prospect` | ✅ 매핑됨 |
| `salProspect.jobSumProspect` | ❌ | ❌ 누락 (ETL에서 직접 사용) |
| `summary.jobStatus` | `status` | ✅ 매핑됨 |
| `summary.jobAbil` | `abilities` | ✅ 매핑됨 |
| `summary.knowldg` | `knowledge` | ✅ 매핑됨 |
| `summary.jobEnv` | `environment` | ✅ 매핑됨 |
| `summary.jobChr` | `personality` | ✅ 매핑됨 |
| `summary.jobIntrst` | `interests` | ✅ 매핑됨 |
| `summary.jobVals` | `values` | ✅ 매핑됨 |
| `summary.jobActvImprtncs` | `activitiesImportance` | ✅ 매핑됨 |
| `summary.jobActvLvls` | `activitiesLevels` | ✅ 매핑됨 |
| `ablKnwEnv.*` | ❌ | ❌ 누락 (ETL에서 직접 사용) |
| `chrIntrVals.*` | ❌ | ❌ 누락 (ETL에서 직접 사용) |
| `actv.*` | ❌ | ❌ 누락 (ETL에서 직접 사용) |

---

## 3. WORK24_DJOB (고용24 직업사전)

### API 엔드포인트
- `https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212D50.do`
- 정규화 함수: `normalizeGoyong24JobDictionaryDetail()` in `src/api/goyong24API.ts`

### Raw Payload 구조 (`Goyong24JobDictionaryDetail`)

```typescript
{
  dJobCd: string                    // 직업코드 (4자리)
  dJobCdSeq: string                 // 일련번호
  dJobNm?: string                   // 직업명
  dJobJCd?: string                  // 표준직업분류코드
  dJobICd?: string                  // 표준산업분류코드
  jobDefiSumryCont?: string         // 직업정의 요약
  jobDefiCont?: string              // 직업정의 상세
  reprDutyCont?: string             // 대표 업무
  execJobCont?: string              // 수행직무
  prepEdursbjNm?: string            // 준비 교육과목
  needKnowlgCont?: string           // 필요 지식
  needAbilCont?: string             // 필요 능력
  jobIntrstCont?: string            // 흥미
  jobAptdCont?: string              // 적성
  jobChrCont?: string               // 성격
  jobValCont?: string               // 가치관
  relJobNmCont?: string             // 관련 직업 (텍스트)
  relCertNmCont?: string            // 관련 자격증 (텍스트)
  jobWorkEnvCont?: string           // 근무환경
  doWork?: string                   // 하는 일
  workSum?: string                  // 업무 요약
  
  optionJobInfo?: {                 // 부가 직업정보
    dJobICdNm?: string              // 표준산업분류명 (예: "[J602]텔레비전 방송업")
    workStrong?: string             // 작업강도
    workPlace?: string              // 작업장소
    physicalAct?: string            // 신체활동
    eduLevel?: string               // 정규교육
    skillYear?: string              // 숙련기간
    workEnv?: string                // 작업환경
    similarNm?: string              // 유사직업명
    connectJob?: string             // 연관직업
    certLic?: string                // 자격증
  }
  
  relJobList?: Array<{              // 관련 직업 목록
    relJobCd: string
    relJobNm: string
  }>
}
```

### 현재 정규화 매핑 상태

| Raw 필드 | Normalized 필드 | 매핑 상태 |
|---------|----------------|---------|
| `dJobNm` | `name` | ✅ 매핑됨 |
| `dJobCd` + `dJobCdSeq` | `id`, `sourceIds.work24_djob` | ✅ 매핑됨 |
| `jobDefiSumryCont` | `summary` | ✅ 매핑됨 |
| `jobDefiCont` | `description` | ✅ 매핑됨 |
| `reprDutyCont` | `duties` | ✅ 매핑됨 |
| `execJobCont` | `work` | ✅ 매핑됨 |
| `prepEdursbjNm` | `relatedMajors` | ✅ 매핑됨 |
| `needKnowlgCont` | `knowledge` | ✅ 매핑됨 |
| `needAbilCont` | `abilities` | ✅ 매핑됨 |
| `jobIntrstCont` | `interests` | ✅ 매핑됨 |
| `jobAptdCont` | ❌ | ❌ 누락 |
| `jobChrCont` | `personality` | ✅ 매핑됨 |
| `jobValCont` | `values` | ✅ 매핑됨 |
| `relCertNmCont` | `relatedCertificates` | ✅ 매핑됨 |
| `jobWorkEnvCont` | `environment` | ✅ 매핑됨 |
| `doWork` | `doWork` | ✅ 매핑됨 |
| `workSum` | `workSum` | ✅ 매핑됨 |
| `optionJobInfo.dJobICdNm` | `dJobICdNm` | ✅ 매핑됨 (브라켓 제거) |
| `optionJobInfo.workStrong` | `workStrong` | ✅ 매핑됨 |
| `optionJobInfo.workPlace` | `workPlace` | ✅ 매핑됨 |
| `optionJobInfo.physicalAct` | `physicalAct` | ✅ 매핑됨 |
| `optionJobInfo.eduLevel` | `eduLevel` | ✅ 매핑됨 |
| `optionJobInfo.skillYear` | `skillYear` | ✅ 매핑됨 |
| `optionJobInfo.workEnv` | `workEnv` | ✅ 매핑됨 |
| `optionJobInfo.similarNm` | `similarNm` | ✅ 매핑됨 |
| `optionJobInfo.connectJob` | `connectJob` | ✅ 매핑됨 |
| `optionJobInfo.certLic` | `certLic` | ✅ 매핑됨 |
| `relJobList` | `relatedJobs` | ✅ 매핑됨 |
| `relJobNmCont` | ❌ | ❌ 누락 (텍스트 형태) |

---

## 누락된 필드 요약

### CAREERNET 누락 필드
1. `baseInfo.social` - 사회적 평판
2. `baseInfo.wlb` - 워라밸 평가
3. `baseInfo.tag` - 태그
4. `tagList` - 태그 목록
5. `eduChart` - 학력 분포 차트
6. `majorChart` - 전공 분포 차트

### WORK24_JOB 누락 필드
1. `salProspect.jobSumProspect` - 재직자 전망 차트 데이터
2. `ablKnwEnv.*` - 능력/지식/환경 상세 비교 데이터
3. `chrIntrVals.*` - 성격/흥미/가치관 상세 비교 데이터
4. `actv.*` - 업무활동 상세 비교 데이터

### WORK24_DJOB 누락 필드
1. `jobAptdCont` - 적성 내용
2. `relJobNmCont` - 관련 직업 (텍스트 형태)

---

## 다음 단계

1. Phase 1.2에서 누락된 필드들을 정규화 함수에 추가
2. 특히 ETL에서 직접 사용하는 필드들을 정규화로 옮겨서 일관성 확보
3. 템플릿에서 rawApiData 의존성 제거 가능하도록 준비

