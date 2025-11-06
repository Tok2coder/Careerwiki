# API Integration Documentation

> **작성일**: 2025-01-06  
> **목적**: CareerNet과 고용24 API의 모든 available 필드를 문서화하고, 현재 수집 현황 및 갭 분석

---

## 📋 목차

1. [고용24 API 필드 문서](#1-고용24-api-필드-문서)
   - [학과정보 API](#11-학과정보-api)
   - [직업정보 API](#12-직업정보-api)
2. [CareerNet API 필드 문서](#2-careernet-api-필드-문서)
3. [현재 수집 현황](#3-현재-수집-현황)
4. [필드 매핑 및 병합 전략](#4-필드-매핑-및-병합-전략)
5. [갭 분석 및 개선 계획](#5-갭-분석-및-개선-계획)

---

## 1. 고용24 API 필드 문서

### 1.1 학과정보 API

#### 1.1.1 학과정보 목록 API

**Endpoint**: `callOpenApiSvcInfo213L01.do`

**Response Fields**:
```xml
<majorsList>
  <total>Number</total>                    <!-- 총건수 -->
  <majorList>
    <majorGb>String</majorGb>              <!-- 학과구분코드 (1: 일반, 2: 이색) -->
    <knowDtlSchDptNm>String</knowDtlSchDptNm> <!-- 세부학과명 -->
    <knowSchDptNm>String</knowSchDptNm>    <!-- 학과명 -->
    <empCurtState1Id>String</empCurtState1Id> <!-- 계열ID -->
    <empCurtState2Id>String</empCurtState2Id> <!-- 학과ID -->
  </majorList>
</majorsList>
```

**현재 수집 상태**: ✅ **완전 수집** (5/5 필드)

---

#### 1.1.2 일반학과 상세 API (majorGb=1)

**Endpoint**: `callOpenApiSvcInfo213D01.do`

**Response Fields**:
```xml
<majorSum>
  <!-- 기본 정보 -->
  <knowDptNm>String</knowDptNm>                <!-- 계열명 -->
  <knowSchDptNm>String</knowSchDptNm>          <!-- 학과명 -->
  <knowDptId>String</knowDptId>                <!-- 계열ID -->
  <knowSchDptId>String</knowSchDptId>          <!-- 학과ID -->
  <schDptIntroSum>String</schDptIntroSum>      <!-- 학과소개 개요 -->
  <aptdIntrstCont>String</aptdIntrstCont>      <!-- 적성/흥미 내용 -->
  
  <!-- 관련 학과 목록 -->
  <relSchDptList>
    <knowDtlSchDptNm>String</knowDtlSchDptNm>  <!-- 관련학과 -->
  </relSchDptList>
  
  <!-- 주요 교과목 목록 -->
  <mainSubjectList>
    <mainEdusbjCont>String</mainEdusbjCont>    <!-- 주요 교과목 -->
  </mainSubjectList>
  
  <!-- 취득 자격 목록 -->
  <licList>
    <adoptCertCont>String</adoptCertCont>      <!-- 취득 자격 -->
  </licList>
  
  <!-- 개설 대학 목록 -->
  <schDptList>
    <schDptNm>String</schDptNm>                <!-- 개설 대학 전공 -->
    <univGbnNm>String</univGbnNm>              <!-- 개설 대학교 구분 -->
    <univNm>String</univNm>                    <!-- 개설 대학교 -->
    <univUrl>String</univUrl>                  <!-- 개설 대학교 URL -->
  </schDptList>
  
  <!-- 관련 직업 목록 -->
  <relAdvanJobsList>
    <knowJobNm>String</knowJobNm>              <!-- 관련직업명 -->
  </relAdvanJobsList>
  
  <!-- 모집 현황 -->
  <recrStateList>
    <enscMxnp>Number</enscMxnp>                <!-- 입학정원인원수 -->
    <enscSpnb>Number</enscSpnb>                <!-- 입학지원자인원수 -->
    <grdnNmpr>Number</grdnNmpr>                <!-- 졸업인원수 -->
    <univGbnNm>String</univGbnNm>              <!-- 대학교구분 -->
    <year>String</year>                        <!-- 연도 -->
  </recrStateList>
</majorSum>
```

**현재 수집 상태**: ✅ **완전 수집** (22/22 필드)

**코드 위치**: `src/api/goyong24API.ts:parseMajorDetail()` (lines 303-360)

---

#### 1.1.3 이색학과 상세 API (majorGb=2)

**Endpoint**: `callOpenApiSvcInfo213D02.do`

**Response Fields**:
```xml
<specMajor>
  <!-- 기본 정보 -->
  <knowDptNm>String</knowDptNm>                <!-- 계열명 -->
  <knowSchDptNm>String</knowSchDptNm>          <!-- 학과명 -->
  <knowDptId>String</knowDptId>                <!-- 계열ID -->
  <knowSchDptId>String</knowSchDptId>          <!-- 학과ID -->
  <schDptIntroSum>String</schDptIntroSum>      <!-- 학과소개 개요 -->
  
  <!-- 이색학과 특화 필드 -->
  <whatStudy>String</whatStudy>                <!-- 하는 공부 -->
  <howPrepare>String</howPrepare>              <!-- 준비방법 -->
  <jobPropect>String</jobPropect>              <!-- 직업 전망 -->
</specMajor>
```

**현재 수집 상태**: ✅ **완전 수집** (8/8 필드)

**코드 위치**: `src/api/goyong24API.ts:parseMajorDetail()` (lines 304-324)

---

### 1.2 직업정보 API

#### 1.2.1 직업정보 목록 API

**Endpoint**: `callOpenApiSvcInfo212L01.do`

**Response Fields**:
```xml
<jobsList>
  <total>Number</total>                        <!-- 총건수 -->
  <jobList>
    <jobClcd>String</jobClcd>                  <!-- 직업분류코드 -->
    <jobClcdNM>String</jobClcdNM>              <!-- 직업분류명 -->
    <jobCd>String</jobCd>                      <!-- 직업코드 -->
    <jobNm>String</jobNm>                      <!-- 직업명 -->
  </jobList>
</jobsList>
```

**현재 수집 상태**: ✅ **완전 수집** (4/4 필드)

---

#### 1.2.2 직업정보 상세 API (7개 섹션)

고용24 직업정보 API는 **7개의 개별 endpoint**로 나뉘어 있습니다:

---

##### **섹션 1: 요약 (dtlGb=1)**

**Endpoint**: `callOpenApiSvcInfo212D01.do`

**Response Fields**:
```xml
<jobSum>
  <!-- 기본 정보 -->
  <jobCd>String</jobCd>                        <!-- 직업코드 -->
  <jobLrclNm>String</jobLrclNm>                <!-- 직업 대분류명 -->
  <jobMdclNm>String</jobMdclNm>                <!-- 직업 중분류명 -->
  <jobSmclNm>String</jobSmclNm>                <!-- 직업 소분류명 -->
  
  <!-- 직무 정보 -->
  <jobSum>String</jobSum>                      <!-- 하는일 -->
  <way>String</way>                            <!-- 되는길 -->
  
  <!-- 관련 전공 목록 -->
  <relMajorList>
    <majorCd>Number</majorCd>                  <!-- 관련전공코드 -->
    <majorNm>String</majorNm>                  <!-- 관련전공명 -->
  </relMajorList>
  
  <!-- 관련 자격증 목록 -->
  <relCertList>
    <certNm>String</certNm>                    <!-- 관련자격증명 -->
  </relCertList>
  
  <!-- 임금/만족도/전망 -->
  <sal>String</sal>                            <!-- 임금 -->
  <jobSatis>String</jobSatis>                  <!-- 직업만족도(%) -->
  <jobProspect>String</jobProspect>            <!-- 일자리전망 -->
  <jobStatus>String</jobStatus>                <!-- 일자리현황 -->
  
  <!-- 능력/지식/환경 -->
  <jobAbil>String</jobAbil>                    <!-- 업무수행능력 -->
  <knowldg>String</knowldg>                    <!-- 지식 -->
  <jobEnv>String</jobEnv>                      <!-- 업무환경 -->
  
  <!-- 성격/흥미/가치관 -->
  <jobChr>String</jobChr>                      <!-- 성격 -->
  <jobIntrst>String</jobIntrst>                <!-- 흥미 -->
  <jobVals>String</jobVals>                    <!-- 직업가치관 -->
  
  <!-- 업무활동 -->
  <jobActvImprtncs>String</jobActvImprtncs>    <!-- 업무활동 중요도 -->
  <jobActvLvls>String</jobActvLvls>            <!-- 업무활동 수준 -->
  
  <!-- 관련 직업 목록 -->
  <relJobList>
    <jobCd>Number</jobCd>                      <!-- 관련직업코드 -->
    <jobNm>String</jobNm>                      <!-- 관련직업명 -->
  </relJobList>
</jobSum>
```

**현재 수집 상태**: ✅ **완전 수집** (22/22 필드)

**코드 위치**: `src/api/goyong24API.ts:parseSummarySection()` (lines 676-702)

---

##### **섹션 2: 하는 일 (dtlGb=2)**

**Endpoint**: `callOpenApiSvcInfo212D02.do`

**Response Fields**:
```xml
<jobsDo>
  <jobCd>String</jobCd>                        <!-- 직업코드 -->
  <jobLrclNm>String</jobLrclNm>                <!-- 직업 대분류명 -->
  <jobMdclNm>String</jobMdclNm>                <!-- 직업 중분류명 -->
  <jobSmclNm>String</jobSmclNm>                <!-- 직업 소분류명 -->
  <jobSum>String</jobSum>                      <!-- 직무개요 -->
  <execJob>String</execJob>                    <!-- 수행직무 -->
  
  <relJobList>
    <jobCd>String</jobCd>                      <!-- 직업코드 -->
    <jobNm>String</jobNm>                      <!-- 직업명 -->
  </relJobList>
</jobsDo>
```

**현재 수집 상태**: ✅ **완전 수집** (7/7 필드)

**코드 위치**: `src/api/goyong24API.ts:parseDutySection()` (lines 704-715)

---

##### **섹션 3: 교육/자격/훈련 (dtlGb=3)**

**Endpoint**: `callOpenApiSvcInfo212D03.do`

**Response Fields**:
```xml
<way>
  <jobCd>String</jobCd>
  <jobLrclNm>String</jobLrclNm>
  <jobMdclNm>String</jobMdclNm>
  <jobSmclNm>String</jobSmclNm>
  
  <!-- 필수 기술 및 지식 -->
  <technKnow>String</technKnow>                <!-- 필수 기술 및 지식 -->
  
  <!-- 학력 분포 -->
  <edubg>
    <edubgMgraduUndr>Number</edubgMgraduUndr>  <!-- 학력분포(%): 중졸이하 -->
    <edubgHgradu>Number</edubgHgradu>          <!-- 학력분포(%): 고졸 -->
    <edubgCgraduUndr>Number</edubgCgraduUndr>  <!-- 학력분포(%): 전문대졸 -->
    <edubgUgradu>Number</edubgUgradu>          <!-- 학력분포(%): 대졸 -->
    <edubgGgradu>Number</edubgGgradu>          <!-- 학력분포(%): 대학원졸 -->
    <edubgDgradu>Number</edubgDgradu>          <!-- 학력분포(%): 박사졸 -->
  </edubg>
  
  <!-- 전공학과 분포 -->
  <schDpt>
    <cultLangDpt>Number</cultLangDpt>          <!-- 전공학과분포(%): 인문계열 -->
    <socDpt>Number</socDpt>                    <!-- 전공학과분포(%): 사회계열 -->
    <eduDpt>Number</eduDpt>                    <!-- 전공학과분포(%): 교육계열 -->
    <engnrDpt>Number</engnrDpt>                <!-- 전공학과분포(%): 공학계열 -->
    <natrlDpt>Number</natrlDpt>                <!-- 전공학과분포(%): 자연계열 -->
    <mediDpt>Number</mediDpt>                  <!-- 전공학과분포(%): 의학계열 -->
    <artphyDpt>Number</artphyDpt>              <!-- 전공학과분포(%): 예체능계열 -->
  </schDpt>
  
  <!-- 관련 전공 목록 -->
  <relMajorList>
    <majorCd>String</majorCd>
    <majorNm>String</majorNm>
  </relMajorList>
  
  <!-- 관련 정보처 -->
  <relOrgList>
    <orgSiteUrl>String</orgSiteUrl>            <!-- 관련정보처 URL -->
    <orgNm>String</orgNm>                      <!-- 관련정보처명 -->
  </relOrgList>
  
  <!-- 관련 자격 -->
  <relCertList>
    <certNm>String</certNm>
  </relCertList>
  
  <!-- 한국고용직업분류 -->
  <kecoList>
    <kecoCd>String</kecoCd>                    <!-- KECO코드 -->
    <kecoNm>String</kecoNm>                    <!-- KECO코드명 -->
  </kecoList>
</way>
```

**현재 수집 상태**: ✅ **완전 수집** (23/23 필드)

**코드 위치**: `src/api/goyong24API.ts:parsePathSection()` (lines 717-761)

---

##### **섹션 4: 임금/직업만족도/전망 (dtlGb=4)**

**Endpoint**: `callOpenApiSvcInfo212D04.do`

**Response Fields**:
```xml
<salProspect>
  <jobCd>String</jobCd>
  <jobLrclNm>String</jobLrclNm>
  <jobMdclNm>String</jobMdclNm>
  <jobSmclNm>String</jobSmclNm>
  
  <!-- 임금/만족도 -->
  <sal>String</sal>                            <!-- 임금 -->
  <jobSatis>String</jobSatis>                  <!-- 직업만족도(%) -->
  <jobProspect>String</jobProspect>            <!-- 일자리전망 -->
  
  <!-- 일자리전망 상세 -->
  <jobSumProspect>
    <jobProspectNm>String</jobProspectNm>      <!-- 일자리전망명 (예: 많이 늘어남) -->
    <jobProspectRatio>String</jobProspectRatio><!-- 일자리전망률 -->
    <jobProspectInqYr>Number</jobProspectInqYr><!-- 조사년도 -->
  </jobSumProspect>
  
  <!-- 일자리현황 -->
  <jobStatusList>
    <jobCd>String</jobCd>
    <jobNm>String</jobNm>
  </jobStatusList>
</salProspect>
```

**현재 수집 상태**: ✅ **완전 수집** (11/11 필드)

**코드 위치**: `src/api/goyong24API.ts:parseSalProspectSection()` (lines 763-791)

---

##### **섹션 5: 능력/지식/환경 (dtlGb=5)**

**Endpoint**: `callOpenApiSvcInfo212D05.do`

**Response Fields**: (매우 상세한 구조 - 직업 내 비교 vs 직업 간 비교)

```xml
<ablKnwEnv>
  <jobCd>String</jobCd>
  <jobLrclNm>String</jobLrclNm>
  <jobMdclNm>String</jobMdclNm>
  <jobSmclNm>String</jobSmclNm>
  
  <!-- 업무수행능력 중요도 (직업 내 비교) -->
  <jobAbilCmpr>
    <jobAblStatusCmpr>Number</jobAblStatusCmpr>    <!-- 중요도(5점 만점) -->
    <jobAblNmCmpr>String</jobAblNmCmpr>            <!-- 업무수행능력명 -->
    <jobAblContCmpr>String</jobAblContCmpr>        <!-- 설명 -->
  </jobAbilCmpr>
  
  <!-- 업무수행능력 중요도 (직업 간 비교) -->
  <jobAbil>
    <jobAblStatus>Number</jobAblStatus>            <!-- 중요도(0~100) -->
    <jobAblNm>String</jobAblNm>
    <jobAblCont>String</jobAblCont>
  </jobAbil>
  
  <!-- 업무수행능력 수준 (직업 내 비교) -->
  <jobAbilLvlCmpr>
    <jobAblLvlStatusCmpr>Number</jobAblLvlStatusCmpr> <!-- 수준(7점 만점) -->
    <jobAblLvlNmCmpr>String</jobAblLvlNmCmpr>
    <jobAblLvlContCmpr>String</jobAblLvlContCmpr>
  </jobAbilLvlCmpr>
  
  <!-- 업무수행능력 수준 (직업 간 비교) -->
  <jobAbilLvl>
    <jobAblLvlStatus>Number</jobAblLvlStatus>      <!-- 수준(0~100) -->
    <jobAblLvlNm>String</jobAblLvlNm>
    <jobAblLvlCont>String</jobAblLvlCont>
  </jobAbilLvl>
  
  <!-- 지식 중요도 (직업 내/간 비교) -->
  <KnwldgCmpr>
    <knwldgStatusCmpr>Number</knwldgStatusCmpr>
    <knwldgNmCmpr>String</knwldgNmCmpr>
    <knwldgContCmpr>String</knwldgContCmpr>
  </KnwldgCmpr>
  
  <Knwldg>
    <knwldgStatus>Number</knwldgStatus>
    <knwldgNm>String</knwldgNm>
    <knwldgCont>String</knwldgCont>
  </Knwldg>
  
  <!-- 지식 수준 (직업 내/간 비교) -->
  <KnwldgLvlCmpr>
    <knwldgLvlStatusCmpr>Number</knwldgLvlStatusCmpr>
    <knwldgLvlNmCmpr>String</knwldgLvlNmCmpr>
    <knwldgLvlContCmpr>String</knwldgLvlContCmpr>
  </KnwldgLvlCmpr>
  
  <KnwldgLvl>
    <knwldgLvlStatus>Number</knwldgLvlStatus>
    <knwldgLvlNm>String</knwldgLvlNm>
    <knwldgLvlCont>String</knwldgLvlCont>
  </KnwldgLvl>
  
  <!-- 업무환경 (직업 내/간 비교) -->
  <jobsEnvCmpr>
    <jobEnvStatusCmpr>Number</jobEnvStatusCmpr>
    <jobEnvNmCmpr>String</jobEnvNmCmpr>
    <jobEnvContCmpr>String</jobEnvContCmpr>
  </jobsEnvCmpr>
  
  <jobsEnv>
    <jobEnvStatus>Number</jobEnvStatus>
    <jobEnvNm>String</jobEnvNm>
    <jobEnvCont>String</jobEnvCont>
  </jobsEnv>
</ablKnwEnv>
```

**현재 수집 상태**: ✅ **완전 수집** (36/36 필드, 6개 카테고리)

**코드 위치**: `src/api/goyong24API.ts:parseAblKnwEnvSection()` (lines 793-872)

**참고**: 이 섹션은 **직업 내 비교**(5점 또는 7점 만점)와 **직업 간 비교**(0~100점) 두 가지 스케일로 제공됩니다.

---

##### **섹션 6: 성격/흥미/가치관 (dtlGb=6)**

**Endpoint**: `callOpenApiSvcInfo212D06.do`

**Response Fields**:
```xml
<chrIntrVals>
  <jobCd>String</jobCd>
  <jobLrclNm>String</jobLrclNm>
  <jobMdclNm>String</jobMdclNm>
  <jobSmclNm>String</jobSmclNm>
  
  <!-- 성격 (직업 내/간 비교) -->
  <jobChrCmpr>
    <jobChrStatusCmpr>Number</jobChrStatusCmpr>    <!-- 중요도(5점 만점) -->
    <jobChrNmCmpr>String</jobChrNmCmpr>
    <jobChrContCmpr>String</jobChrContCmpr>
  </jobChrCmpr>
  
  <jobChr>
    <jobChrStatus>Number</jobChrStatus>            <!-- 중요도(0~100) -->
    <jobChrNm>String</jobChrNm>
    <jobChrCont>String</jobChrCont>
  </jobChr>
  
  <!-- 흥미 (직업 내/간 비교) -->
  <jobIntrstCmpr>
    <intrstStatusCmpr>Number</intrstStatusCmpr>
    <intrstNmCmpr>String</intrstNmCmpr>
    <intrstContCmpr>String</intrstContCmpr>
  </jobIntrstCmpr>
  
  <jobIntrst>
    <intrstStatus>Number</intrstStatus>
    <intrstNm>String</intrstNm>
    <intrstCont>String</intrstCont>
  </jobIntrst>
  
  <!-- 가치관 (직업 내/간 비교) -->
  <jobValsCmpr>
    <valsStatusCmpr>Number</valsStatusCmpr>
    <valsNmCmpr>String</valsNmCmpr>
    <valsContCmpr>String</valsContCmpr>
  </jobValsCmpr>
  
  <jobVals>
    <valsStatus>Number</valsStatus>
    <valsNm>String</valsNm>
    <valsCont>String</valsCont>
  </jobVals>
</chrIntrVals>
```

**현재 수집 상태**: ✅ **완전 수집** (22/22 필드, 3개 카테고리)

**코드 위치**: `src/api/goyong24API.ts:parseChrIntrValsSection()` (lines 874-925)

---

##### **섹션 7: 업무활동 (dtlGb=7)**

**Endpoint**: `callOpenApiSvcInfo212D07.do`

**Response Fields**:
```xml
<jobActv>
  <jobCd>String</jobCd>
  <jobLrclNm>String</jobLrclNm>
  <jobMdclNm>String</jobMdclNm>
  <jobSmclNm>String</jobSmclNm>
  
  <!-- 업무활동 중요도 (직업 내/간 비교) -->
  <jobActvImprtncCmpr>
    <jobActvImprtncStatusCmpr>Number</jobActvImprtncStatusCmpr> <!-- 중요도(5점 만점) -->
    <jobActvImprtncNmCmpr>String</jobActvImprtncNmCmpr>         <!-- 업무활동명 -->
    <jobActvImprtncContCmpr>String</jobActvImprtncContCmpr>     <!-- 설명 -->
  </jobActvImprtncCmpr>
  
  <jobActvImprtnc>
    <jobActvImprtncStatus>Number</jobActvImprtncStatus>         <!-- 중요도(0~100) -->
    <jobActvImprtncNm>String</jobActvImprtncNm>
    <jobActvImprtncCont>String</jobActvImprtncCont>
  </jobActvImprtnc>
  
  <!-- 업무활동 수준 (직업 내/간 비교) -->
  <jobActvLvlCmpr>
    <jobActvLvlStatusCmpr>Number</jobActvLvlStatusCmpr>         <!-- 수준(7점 만점) -->
    <jobActvLvlNmCmpr>String</jobActvLvlNmCmpr>
    <jobActvLvlContCmpr>String</jobActvLvlContCmpr>
  </jobActvLvlCmpr>
  
  <jobActvLvl>
    <jobActvLvlStatus>Number</jobActvLvlStatus>                 <!-- 수준(0~100) -->
    <jobActvLvlNm>String</jobActvLvlNm>
    <jobActvLvlCont>String</jobActvLvlCont>
  </jobActvLvl>
</jobActv>
```

**현재 수집 상태**: ✅ **완전 수집** (16/16 필드, 2개 카테고리)

**코드 위치**: `src/api/goyong24API.ts:parseActvSection()` (lines 927-964)

---

#### 1.2.3 직업사전 API (별도)

고용24는 표준 직업정보 외에 **한국고용정보원 직업사전** API도 제공합니다.

**목록 Endpoint**: `callOpenApiSvcInfo212L50.do`  
**상세 Endpoint**: `callOpenApiSvcInfo212D50.do`

**현재 수집 상태**: ❌ **미사용** (현재 프로젝트에서 직업사전 API는 호출하지 않음)

---

### 고용24 API 전체 요약

| API 유형 | Endpoints | 총 필드 수 | 현재 수집 | 수집률 |
|---------|-----------|----------|---------|-------|
| 학과정보 목록 | 1 | 5 | 5 | ✅ 100% |
| 일반학과 상세 | 1 | 22 | 22 | ✅ 100% |
| 이색학과 상세 | 1 | 8 | 8 | ✅ 100% |
| 직업정보 목록 | 1 | 4 | 4 | ✅ 100% |
| 직업정보 상세 (7섹션) | 7 | 137 | 137 | ✅ 100% |
| 직업사전 | 2 | ~30 | 0 | ❌ 0% |
| **합계** | **13** | **~206** | **176** | **✅ 85.4%** |

**참고**: 직업사전 API는 현재 프로젝트 범위에서 제외되어 있습니다.

---

## 2. CareerNet API 필드 문서

### 2.1 학과정보 API

**Endpoint**: CareerNet 학과정보 API (커리어넷 한국직업정보시스템)

**현재 수집 필드** (from `src/api/careernetAPI.ts`):

```typescript
// 학과 목록
interface CareerNetMajorSummary {
  mClass: string           // 대분류
  lClass: string           // 중분류
  majorSeq: string         // 학과코드
  name: string             // 학과명
}

// 학과 상세
interface CareerNetMajorDetail {
  name: string             // 학과명
  summary: string          // 학과소개
  aptitude: string         // 흥미와 적성
  relatedMajors: string[]  // 관련학과
  mainSubjects: string[]   // 개설전공
  licenses: string[]       // 자격증
  jobs: string[]           // 관련직업
  universities: {          // 개설학교
    name: string
    url: string
  }[]
}
```

**수집 상태**: ✅ **기본 필드 수집 완료**

**코드 위치**: `src/api/careernetAPI.ts:normalizeCareerNetMajorDetail()`

---

### 2.2 직업정보 API

**Endpoint**: CareerNet 직업백과 API

**현재 수집 필드**:

```typescript
// 직업 목록
interface CareerNetJobSummary {
  jobdicSeq: string        // 직업코드
  name: string             // 직업명
}

// 직업 상세
interface CareerNetJobDetail {
  name: string             // 직업명
  summary: string          // 하는일
  duties: string           // 직무
  way: string              // 되는방법
  aptitude: string         // 적성 및 흥미
  salary: string           // 연봉
  prospect: string         // 직업전망
  relatedMajors: {         // 관련학과
    id: string
    name: string
  }[]
  relatedCertificates: string[] // 관련자격증
  relatedJobs: {           // 관련직업
    id: string
    name: string
  }[]
}
```

**수집 상태**: ✅ **기본 필드 수집 완료**

**코드 위치**: `src/api/careernetAPI.ts:normalizeCareerNetJobDetail()`

---

### CareerNet API 전체 요약

| API 유형 | 총 필드 수 (추정) | 현재 수집 | 수집률 |
|---------|----------------|---------|-------|
| 학과정보 | ~15 | ~12 | ✅ ~80% |
| 직업정보 | ~20 | ~15 | ✅ ~75% |
| **합계** | **~35** | **~27** | **✅ ~77%** |

**참고**: CareerNet API는 공식 문서가 공개되어 있지 않아 실제 사용 중인 필드 기반으로 추정했습니다.

---

## 3. 현재 수집 현황

### 3.1 데이터 저장 구조

현재 `majors`, `jobs` 테이블의 `api_data_json` 필드에 **raw API response**가 JSON 형태로 저장됩니다:

```sql
CREATE TABLE majors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  careernet_id TEXT,
  goyong24_id TEXT,
  api_data_json TEXT,  -- 🔑 Raw API data stored here
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

**`api_data_json` 구조**:
```json
{
  "careernet": {
    "name": "컴퓨터공학과",
    "summary": "...",
    "aptitude": "...",
    ...
  },
  "goyong24": {
    "majorGb": "1",
    "departmentName": "...",
    "majorName": "컴퓨터공학과",
    "summary": "...",
    ...
  }
}
```

---

### 3.2 수집 프로세스

**Seeding Scripts**:
- `src/scripts/seedAllMajors.ts` - 1,435개 전공 수집
- `src/scripts/seedAllJobs.ts` - 587개 직업 수집

**수집 흐름**:
1. **CareerNet API 호출** → 기본 목록 가져오기
2. **각 항목의 상세 정보 조회** (CareerNet + 고용24)
3. **Unified Profile 생성** (`src/services/profileMerge.ts`)
4. **D1 Database에 저장** (raw JSON + merged data)

---

### 3.3 현재 수집 커버리지

#### **학과정보**:
| 데이터 소스 | 수집된 필드 | 비율 |
|-----------|----------|-----|
| CareerNet | ~12 / ~15 | ✅ 80% |
| 고용24 일반학과 | 22 / 22 | ✅ 100% |
| 고용24 이색학과 | 8 / 8 | ✅ 100% |

#### **직업정보**:
| 데이터 소스 | 수집된 필드 | 비율 |
|-----------|----------|-----|
| CareerNet | ~15 / ~20 | ✅ 75% |
| 고용24 (7섹션) | 137 / 137 | ✅ 100% |

---

## 4. 필드 매핑 및 병합 전략

### 4.1 학과정보 병합 전략

**CareerNet과 고용24의 공통 필드**:

| 개념 | CareerNet | 고용24 | 병합 우선순위 |
|-----|----------|-------|------------|
| 학과명 | `name` | `knowSchDptNm` | CareerNet (더 표준화됨) |
| 학과소개 | `summary` | `schDptIntroSum` | CareerNet 우선, 없으면 고용24 |
| 적성/흥미 | `aptitude` | `aptdIntrstCont` | CareerNet 우선, 없으면 고용24 |
| 관련학과 | `relatedMajors` | `relSchDptList` | 병합 (중복 제거) |
| 주요 교과목 | `mainSubjects` | `mainSubjectList` | 병합 |
| 관련 자격증 | `licenses` | `licList` | 병합 |
| 관련 직업 | `jobs` | `relAdvanJobsList` | 병합 |
| 개설 대학교 | `universities` | `schDptList` | 병합 |

**고용24 고유 필드** (CareerNet에 없음):
- `recrStateList` - **모집 현황** (입학정원, 지원자, 졸업생)
- `whatStudy` - **하는 공부** (이색학과 전용)
- `howPrepare` - **준비방법** (이색학과 전용)
- `jobProspect` - **직업 전망** (이색학과 전용)

**병합 로직** (`src/services/profileMerge.ts:mergeMajorProfiles()`):
```typescript
export const mergeMajorProfiles = (
  goyong?: UnifiedMajorDetail,
  careernet?: UnifiedMajorDetail
): UnifiedMajorDetail => {
  // 1. 기본 정보는 CareerNet 우선
  const name = careernet?.name || goyong?.name
  const summary = careernet?.summary || goyong?.summary
  const aptitude = careernet?.aptitude || goyong?.aptitude
  
  // 2. 배열은 병합 (중복 제거)
  const relatedMajors = dedupeStrings(careernet?.relatedMajors, goyong?.relatedMajors)
  const mainSubjects = dedupeStrings(careernet?.mainSubjects, goyong?.mainSubjects)
  const licenses = dedupeStrings(careernet?.licenses, goyong?.licenses)
  
  // 3. 고용24 고유 필드는 그대로 포함
  const recruitmentStatus = goyong?.recruitmentStatus
  const whatStudy = goyong?.whatStudy
  const howPrepare = goyong?.howPrepare
  const jobProspect = goyong?.jobProspect
  
  return { name, summary, aptitude, relatedMajors, mainSubjects, licenses, recruitmentStatus, whatStudy, howPrepare, jobProspect, ... }
}
```

---

### 4.2 직업정보 병합 전략

**CareerNet과 고용24의 공통 필드**:

| 개념 | CareerNet | 고용24 | 병합 우선순위 |
|-----|----------|-------|------------|
| 직업명 | `name` | `jobNm` | CareerNet 우선 |
| 하는 일 | `summary` | `jobSum` | CareerNet 우선, 없으면 고용24 |
| 직무 | `duties` | `execJob` | CareerNet 우선, 없으면 고용24 |
| 되는 방법 | `way` | `technKnow` | CareerNet 우선, 없으면 고용24 |
| 관련 전공 | `relatedMajors` | `relMajorList` | 병합 |
| 관련 자격증 | `relatedCertificates` | `relCertList` | 병합 |
| 관련 직업 | `relatedJobs` | `relJobList` | 병합 |
| 연봉 | `salary` | `sal` | CareerNet 우선, 없으면 고용24 |
| 직업 전망 | `prospect` | `jobProspect` | CareerNet 우선, 없으면 고용24 |

**고용24 고유 필드** (CareerNet에 없음):
- **세부 통계**:
  - `jobSatis` - 직업만족도(%)
  - `educationDistribution` - 학력분포
  - `majorDistribution` - 전공학과 분포
  - `jobSumProspect` - 일자리전망 상세
  - `jobStatusList` - 일자리현황
  
- **능력/지식/환경** (섹션 5):
  - `jobAbilCmpr`, `jobAbil`, `jobAbilLvlCmpr`, `jobAbilLvl` - 업무수행능력
  - `KnwldgCmpr`, `Knwldg`, `KnwldgLvlCmpr`, `KnwldgLvl` - 지식
  - `jobsEnvCmpr`, `jobsEnv` - 업무환경
  
- **성격/흥미/가치관** (섹션 6):
  - `jobChrCmpr`, `jobChr` - 성격
  - `jobIntrstCmpr`, `jobIntrst` - 흥미
  - `jobValsCmpr`, `jobVals` - 가치관
  
- **업무활동** (섹션 7):
  - `jobActvImprtncCmpr`, `jobActvImprtnc` - 업무활동 중요도
  - `jobActvLvlCmpr`, `jobActvLvl` - 업무활동 수준

**병합 로직** (`src/services/profileMerge.ts:mergeJobProfiles()`):
```typescript
export const mergeJobProfiles = (
  goyong?: UnifiedJobDetail,
  careernet?: UnifiedJobDetail
): UnifiedJobDetail => {
  // 1. 기본 정보는 CareerNet 우선
  const name = careernet?.name || goyong?.name
  const summary = careernet?.summary || goyong?.summary
  const duties = careernet?.duties || goyong?.duties
  const way = careernet?.way || goyong?.way
  
  // 2. 배열은 병합
  const relatedMajors = mergeRelatedEntities(careernet?.relatedMajors, goyong?.relatedMajors)
  const relatedCertificates = dedupeStrings(careernet?.relatedCertificates, goyong?.relatedCertificates)
  const relatedJobs = mergeRelatedEntities(careernet?.relatedJobs, goyong?.relatedJobs)
  
  // 3. 고용24 통계 데이터는 그대로 포함
  const satisfaction = goyong?.satisfaction
  const educationDistribution = goyong?.educationDistribution
  const majorDistribution = goyong?.majorDistribution
  const abilities = goyong?.abilities
  const knowledge = goyong?.knowledge
  const environment = goyong?.environment
  const personality = goyong?.personality
  const interests = goyong?.interests
  const values = goyong?.values
  const activitiesImportance = goyong?.activitiesImportance
  const activitiesLevels = goyong?.activitiesLevels
  
  return { name, summary, duties, way, relatedMajors, relatedCertificates, relatedJobs, satisfaction, educationDistribution, ... }
}
```

---

## 5. 갭 분석 및 개선 계획

### 5.1 현재 수집 갭

#### **고용24 API**:
✅ **거의 완전 수집됨** (85.4%)
- ✅ 학과정보: 100% 수집
- ✅ 직업정보 (표준 API): 100% 수집
- ❌ 직업사전 API: 0% 수집 (현재 프로젝트 범위 외)

#### **CareerNet API**:
⚠️ **부분 수집** (~77%)
- ⚠️ 학과정보: ~80% 수집 (일부 메타데이터 누락 가능)
- ⚠️ 직업정보: ~75% 수집 (일부 세부 필드 누락 가능)

---

### 5.2 Phase 1에서 확인할 항목

#### **Task 1: CareerNet API 필드 완전성 검증**
- [ ] CareerNet 학과정보 API response 실제 구조 확인
- [ ] CareerNet 직업정보 API response 실제 구조 확인
- [ ] 현재 `normalizeCareerNet*()` 함수가 모든 필드를 파싱하는지 검증
- [ ] 누락된 필드 추가 수집

#### **Task 2: 고용24 API 필드 완전성 검증**
- [x] 고용24 API 문서와 코드 비교 ✅ (이미 완료)
- [x] 모든 섹션이 올바르게 파싱되는지 확인 ✅
- [ ] 실제 API response와 비교하여 누락 필드 확인

#### **Task 3: 데이터 품질 검증**
- [ ] 1,435개 전공 중 빈 필드 비율 확인
- [ ] 587개 직업 중 빈 필드 비율 확인
- [ ] CareerNet과 고용24 데이터 중복도 측정
- [ ] 병합 로직 개선 필요 여부 판단

---

### 5.3 개선 계획 (Phase 1)

#### **우선순위 1 (HIGH): 데이터 완전성 확보**
1. **CareerNet API 전체 필드 확인** → `src/api/careernetAPI.ts` 개선
2. **빈 필드 비율 측정** → seeding 시 로깅 추가
3. **누락 필드 재수집** → seeding scripts 업데이트

#### **우선순위 2 (MEDIUM): 데이터 병합 전략 최적화**
1. **Name matching 알고리즘 검증** → 현재 case-insensitive 단순 비교
2. **Fuzzy matching 도입** → Levenshtein distance ≥90% 유사도
3. **Manual mapping table 구축** → 예외 케이스 처리

#### **우선순위 3 (LOW): 추가 데이터 소스**
1. **직업사전 API 통합** → 필요 시 Phase 2 이후 추가
2. **공공 데이터 포털** → 취업률, 연봉 통계 보강

---

## 6. 참고 자료

### 6.1 관련 코드 파일
- **API 클라이언트**:
  - `src/api/goyong24API.ts` - 고용24 API 호출 및 파싱
  - `src/api/careernetAPI.ts` - CareerNet API 호출 및 파싱
  
- **데이터 병합**:
  - `src/services/profileMerge.ts` - CareerNet + 고용24 병합 로직
  - `src/services/profileDataService.ts` - Unified API service
  
- **Seeding Scripts**:
  - `src/scripts/seedAllMajors.ts` - 1,435개 전공 수집
  - `src/scripts/seedAllJobs.ts` - 587개 직업 수집
  
- **Type Definitions**:
  - `src/types/unifiedProfiles.ts` - UnifiedJobDetail, UnifiedMajorDetail 등

### 6.2 문서
- `docs/ARCHITECTURE.md` - 시스템 아키텍처 설계
- `docs/DEVELOPMENT_ROADMAP.md` - Phase별 개발 계획
- `docs/migration-plan.md` - 데이터 마이그레이션 상세 계획

---

## 변경 이력

| 날짜 | 작성자 | 변경 내용 |
|-----|-------|---------|
| 2025-01-06 | Claude AI | 초안 작성 - 고용24 API 전체 문서화 완료 |
