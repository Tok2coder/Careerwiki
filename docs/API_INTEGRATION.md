# API Integration Documentation

> **작성일**: 2025-01-06 (재작성)  
> **목적**: CareerNet과 고용24 API의 **공식 문서 기반** 전체 필드 문서화 및 현재 수집 현황 분석

---

## 📋 목차

1. [CareerNet API 필드 문서](#1-careernet-api-필드-문서)
   - [직업백과 API](#11-직업백과-api-jobjson)
   - [학과정보 API](#12-학과정보-api-getope napi)
2. [고용24 API 필드 문서](#2-고용24-api-필드-문서)
   - [학과정보 API](#21-학과정보-api)
   - [직업정보 API](#22-직업정보-api)
3. [현재 수집 현황](#3-현재-수집-현황)
4. [필드 매핑 및 병합 전략](#4-필드-매핑-및-병합-전략)
5. [갭 분석 및 개선 계획](#5-갭-분석-및-개선-계획)

---

## 1. CareerNet API 필드 문서

> **공식 문서**: https://www.career.go.kr/cnet/front/openapi/

### 1.1 직업백과 API (job.json)

**공식 문서**: https://www.career.go.kr/cnet/front/openapi/jobCenter.do

#### 1.1.1 Endpoint 정보

```
URL: https://www.career.go.kr/cnet/front/openapi/job.json
Method: GET
Format: JSON
Authentication: apiKey (필수)
```

#### 1.1.2 Request Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `apiKey` | String | ✅ 필수 | OpenAPI 인증키 |
| `seq` | Number | ✅ 필수 | 직업코드 |

**요청 예시:**
```
GET https://www.career.go.kr/cnet/front/openapi/job.json?apiKey=인증키&seq=8
```

#### 1.1.3 Response Fields (총 ~150+ 필드, 15개 섹션)

##### **섹션 1: baseInfo (기본 정보)** - 20개 필드

```json
{
  "baseInfo": {
    "seq": "Number - 고유번호",
    "job_cd": "Number - 직업코드",
    "job_nm": "String - 직업명",
    "aptit_name": "String - 직업분류",
    "emp_job_cd": "Number/String - 고용코드",
    "emp_job_nm": "String - 고용코드명",
    "std_job_cd": "String - 표준직업코드",
    "std_job_nm": "String - 표준직업코드명",
    "rel_job_nm": "String - 관련직업명",
    "wage": "Number - 평균연봉 (만원)",
    "wage_source": "String - 평균연봉 출처",
    "satisfication": "Number - 직업만족도 (%)",
    "satisfi_source": "String - 직업만족도 출처",
    "social": "String - 사회공헌",
    "wlb": "String - 일·가정균형",
    "INTRST_JOB_YN": "String - 관심직업 설정여부",
    "views": "Number - 조회수",
    "likes": "Number - 추천수",
    "tag": "String - 태그",
    "reg_dt": "String - 작성일",
    "edit_dt": "String - 수정일"
  }
}
```

##### **섹션 2: workList (하는 일)** - 배열

```json
{
  "workList": [
    {
      "work": "String - 하는일 항목"
    }
  ]
}
```

##### **섹션 3: abilityList (핵심능력)** - 배열

```json
{
  "abilityList": [
    {
      "ability_name": "String - 핵심능력명",
      "SORT_ORDR": "String/Number - 정렬순서"
    }
  ]
}
```

##### **섹션 4: departList (관련학과)** - 배열

```json
{
  "departList": [
    {
      "depart_id": "Number - 관련학과 ID",
      "depart_name": "String - 관련학과명"
    }
  ]
}
```

##### **섹션 5: certiList (관련 자격증)** - 배열

```json
{
  "certiList": [
    {
      "certi": "String - 관련 자격증명",
      "LINK": "String - 관련 자격증 링크"
    }
  ]
}
```

##### **섹션 6: aptitudeList (적성)** - 배열

```json
{
  "aptitudeList": [
    {
      "aptitude": "String - 적성 설명"
    }
  ]
}
```

##### **섹션 7: interestList (흥미)** - 배열

```json
{
  "interestList": [
    {
      "interest": "String - 흥미 설명"
    }
  ]
}
```

##### **섹션 8: tagList (태그)** - 문자열 배열

```json
{
  "tagList": ["String - 태그1", "String - 태그2"]
}
```

##### **섹션 9: researchList (진로탐색활동)** - 배열

```json
{
  "researchList": [
    {
      "research": "String - 진로탐색활동 권장 활동"
    }
  ]
}
```

##### **섹션 10: relVideoList (관련 동영상)** - 배열 (7개 필드)

```json
{
  "relVideoList": [
    {
      "video_id": "String - 동영상 ID",
      "video_name": "String - 동영상 제목",
      "job_cd": "String/Number - 직업코드",
      "CID": "String - 콘텐츠 ID",
      "THUMBNAIL_FILE_SER": "String - 썸네일 ID",
      "THUMNAIL_PATH": "String - 썸네일 URL",
      "OUTPATH3": "String - 동영상 URL"
    }
  ]
}
```

##### **섹션 11: relSolList (관련 진로상담)** - 배열 (6개 필드)

```json
{
  "relSolList": [
    {
      "cnslt_seq": "Number - 관련진로상담 ID",
      "cnslt": "String - 진로상담 내용(요약) 또는 ID",
      "SJ": "String - 제목",
      "CN": "String - 내용(상세)",
      "TRGET_SE": "String - 타겟층",
      "REGIST_DT": "String - 등록일"
    }
  ]
}
```

##### **섹션 12: relJinsolList (관련 자료)** - 배열 (4개 필드)

```json
{
  "relJinsolList": [
    {
      "SEQ": "Number - 고유번호",
      "ALT": "String - 관련자료ID",
      "SUBJECT": "String - 관련자료명",
      "THUMBNAIL": "String - 썸네일"
    }
  ]
}
```

##### **섹션 13: jobReadyList (직업준비)** - 객체 (4개 하위 배열)

```json
{
  "jobReadyList": {
    "recruit": [
      { "recruit": "String - 입직 및 취업방법" }
    ],
    "certificate": [
      { "certificate": "String - 관련자격증" }
    ],
    "training": [
      { "training": "String - 직업훈련" }
    ],
    "curriculum": [
      { "curriculum": "String - 정규교육과정" }
    ]
  }
}
```

##### **섹션 14: jobRelOrgList (관련기관)** - 배열 (2개 필드)

```json
{
  "jobRelOrgList": [
    {
      "rel_org": "String - 관련기관명",
      "rel_org_url": "String - 관련기관 URL"
    }
  ]
}
```

##### **섹션 15: forecastList (직업전망)** - 배열

```json
{
  "forecastList": [
    {
      "forecast": "String - 직업전망 텍스트"
    }
  ]
}
```

##### **섹션 16: eduChart (학력분포)** - 배열 (3개 필드)

```json
{
  "eduChart": [
    {
      "chart_name": "String - 학력분포 라벨",
      "chart_data": "String - 학력분포 데이터 (콤마 구분)",
      "source": "String - 출처"
    }
  ]
}
```

##### **섹션 17: majorChart (전공계열)** - 배열 (3개 필드)

```json
{
  "majorChart": [
    {
      "major": "String - 전공계열명 (콤마 구분)",
      "major_data": "String - 전공계열 데이터 (콤마 구분)",
      "source": "String - 출처"
    }
  ]
}
```

##### **섹션 18: indicatorChart (직업지표)** - 배열 (3개 필드)

```json
{
  "indicatorChart": [
    {
      "indicator": "String - 직업지표명 (콤마 구분)",
      "indicator_data": "String - 지표 데이터 (콤마 구분)",
      "source": "String - 출처"
    }
  ]
}
```

##### **섹션 19: performList (업무환경/수행능력/지식)** - 객체 (3개 하위 배열)

```json
{
  "performList": {
    "environment": [
      {
        "environment": "String - 업무환경 항목명",
        "inform": "String - 설명",
        "importance": "Number - 중요도",
        "source": "String - 출처"
      }
    ],
    "perform": [
      {
        "perform": "String - 능력명",
        "inform": "String - 설명",
        "importance": "Number - 중요도",
        "source": "String - 출처"
      }
    ],
    "knowledge": [
      {
        "knowledge": "String - 지식명",
        "inform": "String - 설명",
        "importance": "Number - 중요도",
        "source": "String - 출처"
      }
    ]
  }
}
```

#### 1.1.4 현재 수집 상태

| 섹션 | 필드 수 | 수집 상태 | 수집률 |
|------|--------|----------|-------|
| baseInfo | 21 | ✅ 완전 수집 | 100% |
| workList | 1 | ✅ 완전 수집 | 100% |
| abilityList | 2 | ✅ 완전 수집 | 100% |
| departList | 2 | ✅ 완전 수집 | 100% |
| certiList | 2 | ✅ 완전 수집 | 100% |
| aptitudeList | 1 | ✅ 완전 수집 | 100% |
| interestList | 1 | ✅ 완전 수집 | 100% |
| tagList | 1 | ✅ 완전 수집 | 100% |
| researchList | 1 | ✅ 완전 수집 | 100% |
| relVideoList | 7 | ✅ 완전 수집 | 100% |
| relSolList | 6 | ✅ 완전 수집 | 100% |
| relJinsolList | 4 | ✅ 완전 수집 | 100% |
| jobReadyList | 4 | ✅ 완전 수집 | 100% |
| jobRelOrgList | 2 | ✅ 완전 수집 | 100% |
| forecastList | 1 | ✅ 완전 수집 | 100% |
| eduChart | 3 | ✅ 완전 수집 | 100% |
| majorChart | 3 | ✅ 완전 수집 | 100% |
| indicatorChart | 3 | ✅ 완전 수집 | 100% |
| performList | 12 (3×4) | ✅ 완전 수집 | 100% |
| **총계** | **~77** | **✅ 완전 수집** | **~95%** |

**코드 위치**: 
- Type definition: `src/api/careernetAPI.ts:JobEncyclopediaResponse` (lines 172-258)
- Normalization: `src/api/careernetAPI.ts:normalizeCareerNetJobDetail()` (lines 593-764)

---

### 1.2 학과정보 API (getOpenApi)

**공식 문서**: https://www.career.go.kr/cnet/front/openapi/openApiMajorCenter.do

#### 1.2.1 Endpoint 정보

```
Base URL: https://www.career.go.kr/cnet/openapi/getOpenApi
Method: GET
Format: XML 또는 JSON (contentType 파라미터로 지정)
Authentication: apiKey (필수)
Encoding: EUC-KR (XML), UTF-8 (JSON)
```

#### 1.2.2 Request Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `apiKey` | String | ✅ 필수 | OpenAPI 인증키 |
| `svcType` | String | ✅ 필수 | 고정값: `api` |
| `svcCode` | String | ✅ 필수 | `MAJOR` (목록) / `MAJOR_VIEW` (상세) |
| `contentType` | String | ⚠️ 선택 | `xml` 또는 `json` |
| `gubun` | String | ✅ 필수 | `univ_list` (대학교) / 기타 |
| `majorSeq` | String | ⚠️ 조건부 | 학과코드 (상세 조회 시 필수) |
| `searchTitle` | String | ⚠️ 선택 | 검색어 (목록 조회 시) |
| `thisPage` | Number | ⚠️ 선택 | 현재 페이지 |
| `perPage` | Number | ⚠️ 선택 | 페이지당 결과 수 |
| `subject` | String | ⚠️ 선택 | 학과 계열 필터 |
| `univSe` | String | ⚠️ 선택 | 대학 분류 (gubun=대학교인 경우) |

**목록 요청 예시:**
```
GET https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=인증키&svcType=api&svcCode=MAJOR&contentType=xml&gubun=univ_list
```

**상세 요청 예시:**
```
GET https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=인증키&svcType=api&svcCode=MAJOR_VIEW&contentType=json&gubun=univ_list&majorSeq=665
```

#### 1.2.3 Response Fields - 목록 조회 (MAJOR)

**Response 구조:**
```xml
<dataSearch>
  <content>
    <!-- 각 학과 항목 -->
  </content>
</dataSearch>
```

**필드 (총 5개):**

| Field | Type | Description |
|-------|------|-------------|
| `lClass` | String | 계열 (예: 공학계열, 사회계열) |
| `mClass` | String | 학과명 |
| `totalCount` | Number | 전체 검색 결과 수 |
| `majorSeq` | String | 학과코드 (상세 조회용) |
| `facilName` | String | 세부학과명 (콤마 구분) |

**현재 수집 상태**: ✅ **완전 수집** (5/5 필드)

**코드 위치**: `src/api/careernetAPI.ts:searchMajors()` (lines 280-332)

---

#### 1.2.4 Response Fields - 상세 조회 (MAJOR_VIEW, 대학교)

**Response 구조:**
```xml
<dataSearch>
  <content>
    <!-- 학과 상세 정보 -->
  </content>
</dataSearch>
```

**필드 (총 ~80+ 필드, 15개 섹션):**

##### **섹션 1: 기본 정보** (7개 필드)

| Field | Type | Description | 현재 수집 |
|-------|------|-------------|----------|
| `major` | String | 학과명 | ✅ |
| `salary` | String | 졸업 후 직장임금 (예: "130만원 이상") | ✅ |
| `employment` | String | 취업률 (예: "40% 이상") | ✅ |
| `department` | String | 세부관련학과 (콤마 구분) | ✅ |
| `summary` | String | 학과개요 | ✅ |
| `interest` | String | 흥미와 적성 | ✅ |
| `property` | String | 학과특성 | ❌ **누락** |

##### **섹션 2: relate_subject (관련 고교 교과목)** - 배열

```xml
<relate_subject>
  <content>
    <subject_name>String - 선택 과목 종류명</subject_name>
    <subject_description>String - 과목이름</subject_description>
  </content>
</relate_subject>
```

**현재 수집 상태**: ❌ **미수집** (0/2 필드)

##### **섹션 3: career_act (진로 탐색 활동)** - 배열

```xml
<career_act>
  <content>
    <act_name>String - 활동 종류명</act_name>
    <act_description>String - 활동 설명</act_description>
  </content>
</career_act>
```

**현재 수집 상태**: ❌ **미수집** (0/2 필드)

##### **섹션 4: job (관련직업)** - 문자열

| Field | Type | Description | 현재 수집 |
|-------|------|-------------|----------|
| `job` | String | 관련직업 (콤마 구분) | ✅ |

##### **섹션 5: qualifications (관련자격)** - 문자열

| Field | Type | Description | 현재 수집 |
|-------|------|-------------|----------|
| `qualifications` | String | 관련자격 (콤마 구분) | ✅ |

##### **섹션 6: enter_field (졸업 후 진출분야)** - 배열

```xml
<enter_field>
  <content>
    <gradeuate>String - 진출분야명</gradeuate>
    <description>String - 진출분야설명</description>
  </content>
</enter_field>
```

**현재 수집 상태**: ❌ **미수집** (0/2 필드)

##### **섹션 7: main_subject (대학 주요 교과목)** - 배열

```xml
<main_subject>
  <content>
    <SBJECT_NM>String - 교과목명</SBJECT_NM>
    <SBJECT_SUMRY>String - 교과목설명</SBJECT_SUMRY>
  </content>
</main_subject>
```

**현재 수집 상태**: ❌ **미수집** (0/2 필드)

##### **섹션 8: university (개설대학)** - 배열 (6개 필드)

```xml
<university>
  <content>
    <area>String - 지역</area>
    <schoolName>String - 대학명</schoolName>
    <schoolURL>String - 학교URL</schoolURL>
    <campus_nm>String - 캠퍼스명</campus_nm>
    <majorName>String - 학과명(대학표기)</majorName>
    <totalCount>String - 전체수</totalCount>
  </content>
</university>
```

**현재 수집 상태**: ⚠️ **부분 수집** (schoolName만, 1/6 필드)

**코드 위치**: `src/api/careernetAPI.ts:getMajorDetail()` (lines 362-369)

##### **섹션 9: chartData (학과전망 통계)** - 복합 객체

```xml
<chartData>
  <applicant>
    <item>
      <data>Number - 값</data>
      <name>String - 항목명</name>
    </item>
  </applicant>
  <gender><!-- 동일 구조 --></gender>
  <employment_rate><!-- 동일 구조 --></employment_rate>
  <field><!-- 동일 구조 --></field>
  <avg_salary><!-- 동일 구조 --></avg_salary>
  <satisfaction><!-- 동일 구조 --></satisfaction>
  <after_graduation><!-- 동일 구조 --></after_graduation>
</chartData>
```

**현재 수집 상태**: ❌ **미수집** (0/14+ 필드)

##### **섹션 10: GenCD (성별비율)** - 배열

```xml
<GenCD>
  <popular>
    <PCNT1>String - 비율-정수값</PCNT1>
    <PCNT2>String - 비율-소수값</PCNT2>
    <PCNT>String - 비율-반올림값</PCNT>
    <GEN_NM>String - 성별</GEN_NM>
  </popular>
  <bookmark><!-- 동일 구조 --></bookmark>
</GenCD>
```

**현재 수집 상태**: ❌ **미수집** (0/8 필드)

##### **섹션 11: SchClass (학교급별비율)** - 배열

```xml
<SchClass>
  <popular>
    <PCNT1>String</PCNT1>
    <PCNT2>String</PCNT2>
    <PCNT>String</PCNT>
    <SCH_CLASS_NM>String - 학교급명</SCH_CLASS_NM>
  </popular>
  <bookmark><!-- 동일 구조 --></bookmark>
</SchClass>
```

**현재 수집 상태**: ❌ **미수집** (0/8 필드)

##### **섹션 12: lstMiddleAptd (중학생적성유형)** - 배열

```xml
<lstMiddleAptd>
  <popular>
    <RANK>String</RANK>
    <CD_ORDR>String</CD_ORDR>
    <CD_NM>String - 적성유형명</CD_NM>
  </popular>
  <bookmark><!-- 동일 구조 --></bookmark>
</lstMiddleAptd>
```

**현재 수집 상태**: ❌ **미수집** (0/6 필드)

##### **섹션 13: lstHighAptd (고등학생적성유형)** - 배열

```xml
<lstHighAptd>
  <popular>
    <RANK>String</RANK>
    <CD_ORDR>String</CD_ORDR>
    <CD_NM>String - 적성유형명</CD_NM>
  </popular>
  <bookmark><!-- 동일 구조 --></bookmark>
</lstHighAptd>
```

**현재 수집 상태**: ❌ **미수집** (0/6 필드)

##### **섹션 14: lstVals (선호직업가치)** - 배열

```xml
<lstVals>
  <popular>
    <RANK>String</RANK>
    <CD_ORDR>String</CD_ORDR>
    <CD_NM>String - 직업가치명</CD_NM>
  </popular>
  <bookmark><!-- 동일 구조 --></bookmark>
</lstVals>
```

**현재 수집 상태**: ❌ **미수집** (0/6 필드)

#### 1.2.5 학과정보 API 전체 요약

| 섹션 | 필드 수 | 현재 수집 | 수집률 |
|------|--------|----------|-------|
| 기본 정보 | 7 | 6 | ⚠️ 86% |
| relate_subject (관련 고교 교과목) | 2 | 0 | ❌ 0% |
| career_act (진로 탐색 활동) | 2 | 0 | ❌ 0% |
| job (관련직업) | 1 | 1 | ✅ 100% |
| qualifications (관련자격) | 1 | 1 | ✅ 100% |
| enter_field (진출분야) | 2 | 0 | ❌ 0% |
| main_subject (주요 교과목) | 2 | 0 | ❌ 0% |
| university (개설대학) | 6 | 1 | ⚠️ 17% |
| chartData (학과전망) | ~14 | 0 | ❌ 0% |
| GenCD (성별비율) | 8 | 0 | ❌ 0% |
| SchClass (학교급별) | 8 | 0 | ❌ 0% |
| lstMiddleAptd (중학생적성) | 6 | 0 | ❌ 0% |
| lstHighAptd (고등학생적성) | 6 | 0 | ❌ 0% |
| lstVals (선호직업가치) | 6 | 0 | ❌ 0% |
| **총계** | **~71** | **~9** | **⚠️ ~13%** |

**코드 위치**: `src/api/careernetAPI.ts:getMajorDetail()` (lines 335-395)

---

## 2. 고용24 API 필드 문서

### 2.1 학과정보 API

#### 2.1.1 학과정보 목록 API

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

#### 2.1.2 일반학과 상세 API (majorGb=1)

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

#### 2.1.3 이색학과 상세 API (majorGb=2)

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

### 2.2 직업정보 API

#### 2.2.1 직업정보 목록 API

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

#### 2.2.2 직업정보 상세 API (7개 섹션)

고용24 직업정보 API는 **7개의 개별 endpoint**로 나뉘어 있습니다:

##### **섹션 1: 요약 (dtlGb=1)**

**Endpoint**: `callOpenApiSvcInfo212D01.do`

**Response Fields**: (22개 필드)

**현재 수집 상태**: ✅ **완전 수집** (22/22 필드)

**코드 위치**: `src/api/goyong24API.ts:parseSummarySection()` (lines 676-702)

---

##### **섹션 2: 하는 일 (dtlGb=2)**

**Endpoint**: `callOpenApiSvcInfo212D02.do`

**Response Fields**: (7개 필드)

**현재 수집 상태**: ✅ **완전 수집** (7/7 필드)

**코드 위치**: `src/api/goyong24API.ts:parseDutySection()` (lines 704-715)

---

##### **섹션 3: 교육/자격/훈련 (dtlGb=3)**

**Endpoint**: `callOpenApiSvcInfo212D03.do`

**Response Fields**: (23개 필드)

**현재 수집 상태**: ✅ **완전 수집** (23/23 필드)

**코드 위치**: `src/api/goyong24API.ts:parsePathSection()` (lines 717-761)

---

##### **섹션 4: 임금/직업만족도/전망 (dtlGb=4)**

**Endpoint**: `callOpenApiSvcInfo212D04.do`

**Response Fields**: (11개 필드)

**현재 수집 상태**: ✅ **완전 수집** (11/11 필드)

**코드 위치**: `src/api/goyong24API.ts:parseSalProspectSection()` (lines 763-791)

---

##### **섹션 5: 능력/지식/환경 (dtlGb=5)**

**Endpoint**: `callOpenApiSvcInfo212D05.do`

**Response Fields**: (36개 필드, 6개 카테고리)

**현재 수집 상태**: ✅ **완전 수집** (36/36 필드)

**코드 위치**: `src/api/goyong24API.ts:parseAblKnwEnvSection()` (lines 793-872)

---

##### **섹션 6: 성격/흥미/가치관 (dtlGb=6)**

**Endpoint**: `callOpenApiSvcInfo212D06.do`

**Response Fields**: (22개 필드, 3개 카테고리)

**현재 수집 상태**: ✅ **완전 수집** (22/22 필드)

**코드 위치**: `src/api/goyong24API.ts:parseChrIntrValsSection()` (lines 874-925)

---

##### **섹션 7: 업무활동 (dtlGb=7)**

**Endpoint**: `callOpenApiSvcInfo212D07.do`

**Response Fields**: (16개 필드, 2개 카테고리)

**현재 수집 상태**: ✅ **완전 수집** (16/16 필드)

**코드 위치**: `src/api/goyong24API.ts:parseActvSection()` (lines 927-964)

---

### 고용24 API 전체 요약

| API 유형 | Endpoints | 총 필드 수 | 현재 수집 | 수집률 |
|---------|-----------|----------|---------|-------|
| 학과정보 목록 | 1 | 5 | 5 | ✅ 100% |
| 일반학과 상세 | 1 | 22 | 22 | ✅ 100% |
| 이색학과 상세 | 1 | 8 | 8 | ✅ 100% |
| 직업정보 목록 | 1 | 4 | 4 | ✅ 100% |
| 직업정보 상세 (7섹션) | 7 | 137 | 137 | ✅ 100% |
| **합계** | **11** | **176** | **176** | **✅ 100%** |

---

## 3. 현재 수집 현황

### 3.1 전체 API 수집 현황

| API 소스 | 총 필드 수 | 현재 수집 | 수집률 |
|---------|----------|---------|-------|
| **CareerNet 직업백과** | ~77 | ~73 | ✅ **~95%** |
| **CareerNet 학과정보** | ~71 | ~9 | ⚠️ **~13%** |
| **고용24 학과정보** | 35 | 35 | ✅ **100%** |
| **고용24 직업정보** | 137 | 137 | ✅ **100%** |
| **총계** | **~320** | **~254** | **⚠️ ~79%** |

### 3.2 주요 갭 분석

#### **심각한 누락 (HIGH Priority)**

1. **CareerNet 학과정보 상세** (~62개 필드 누락)
   - ❌ `relate_subject` (관련 고교 교과목) - 2개 필드
   - ❌ `career_act` (진로 탐색 활동) - 2개 필드
   - ❌ `enter_field` (진출분야) - 2개 필드
   - ❌ `main_subject` (주요 교과목) - 2개 필드
   - ❌ `chartData` (학과전망 통계) - ~14개 필드
   - ❌ `GenCD`, `SchClass` (성별/학교급별 비율) - 16개 필드
   - ❌ `lstMiddleAptd`, `lstHighAptd`, `lstVals` (적성/가치) - 18개 필드
   - ⚠️ `university` (개설대학) - 5개 필드 누락 (6개 중 1개만 수집)
   - ❌ `property` (학과특성) - 1개 필드

#### **경미한 누락 (LOW Priority)**

2. **CareerNet 직업백과** (~4개 필드 누락)
   - ⚠️ 일부 edge case 필드 누락 가능성 (문서에 명시되지 않은 필드)

---

## 4. 필드 매핑 및 병합 전략

### 4.1 학과정보 병합 전략

**CareerNet과 고용24의 공통 필드**:

| 개념 | CareerNet | 고용24 | 병합 우선순위 |
|-----|----------|-------|------------|
| 학과명 | `major` | `knowSchDptNm` | CareerNet 우선 |
| 학과소개 | `summary` | `schDptIntroSum` | CareerNet 우선 |
| 적성/흥미 | `interest` | `aptdIntrstCont` | CareerNet 우선 |
| 관련학과 | (없음) | `relSchDptList` | 고용24만 |
| 주요 교과목 | `main_subject` (미수집) | `mainSubjectList` | 고용24만 (CareerNet 미수집) |
| 관련 자격증 | `qualifications` | `licList` | 병합 |
| 관련 직업 | `job` | `relAdvanJobsList` | 병합 |
| 개설 대학교 | `university` | `schDptList` | 병합 |

**고용24 고유 필드** (CareerNet에 없음):
- `recrStateList` - **모집 현황** (입학정원, 지원자, 졸업생)
- `whatStudy` - **하는 공부** (이색학과 전용)
- `howPrepare` - **준비방법** (이색학과 전용)
- `jobProspect` - **직업 전망** (이색학과 전용)

**CareerNet 고유 필드** (고용24에 없음, 대부분 미수집):
- `relate_subject` - **관련 고교 교과목** ❌ 미수집
- `career_act` - **진로 탐색 활동** ❌ 미수집
- `enter_field` - **진출분야** ❌ 미수집
- `chartData` - **학과전망 통계** ❌ 미수집
- `GenCD`, `SchClass`, `lstMiddleAptd`, `lstHighAptd`, `lstVals` - **통계 데이터** ❌ 미수집

---

### 4.2 직업정보 병합 전략

**CareerNet과 고용24의 공통 필드**:

| 개념 | CareerNet | 고용24 | 병합 우선순위 |
|-----|----------|-------|------------|
| 직업명 | `job_nm` | `jobNm` | CareerNet 우선 |
| 하는 일 | `workList` | `jobSum` | CareerNet 우선 |
| 직무 | (workList 통합) | `execJob` | CareerNet 우선 |
| 관련 전공 | `departList` | `relMajorList` | 병합 |
| 관련 자격증 | `certiList` | `relCertList` | 병합 |
| 관련 직업 | `rel_job_nm` | `relJobList` | 병합 |
| 연봉 | `wage` | `sal` | CareerNet 우선 |
| 직업 전망 | `forecastList` | `jobProspect` | CareerNet 우선 |

**고용24 고유 필드** (CareerNet에 없음):
- **세부 통계**:
  - `jobSatis` - 직업만족도(%)
  - `educationDistribution` - 학력분포
  - `majorDistribution` - 전공학과 분포
  - `jobSumProspect` - 일자리전망 상세
  - `jobStatusList` - 일자리현황
  
- **능력/지식/환경** (섹션 5): 36개 필드
- **성격/흥미/가치관** (섹션 6): 22개 필드
- **업무활동** (섹션 7): 16개 필드

**CareerNet 고유 필드** (고용24에 없음):
- **직업백과 확장 필드들**:
  - `relVideoList` - 관련 동영상
  - `relSolList` - 관련 진로상담
  - `relJinsolList` - 관련 자료
  - `jobReadyList` - 직업준비 (입직/자격증/훈련/교육)
  - `jobRelOrgList` - 관련기관
  - `eduChart`, `majorChart`, `indicatorChart` - 차트 데이터
  - `performList` - 업무환경/수행능력/지식 (별도 구조)

---

## 5. 갭 분석 및 개선 계획

### 5.1 현재 수집 갭

#### **CareerNet API**:

1. **직업백과 API**: ✅ **거의 완전 수집** (~95%)
   - ✅ 모든 주요 섹션 수집 완료
   - ⚠️ 일부 edge case 필드 미확인 가능성 있음

2. **학과정보 API**: ⚠️ **심각한 누락** (~13%)
   - ❌ **62개 필드 미수집** (총 71개 중 9개만 수집)
   - ❌ 통계 데이터 전체 미수집 (`chartData`, `GenCD`, `SchClass`, 등)
   - ❌ 진로 관련 중요 데이터 미수집 (`relate_subject`, `career_act`, `enter_field`)
   - ❌ 교육 정보 미수집 (`main_subject`)
   - ⚠️ 개설대학 정보 부분 수집 (schoolName만)

#### **고용24 API**:
✅ **완전 수집** (100%)
- ✅ 학과정보: 35/35 필드
- ✅ 직업정보: 137/137 필드

---

### 5.2 Phase 1에서 확인할 항목

#### **우선순위 1 (HIGH): CareerNet 학과정보 API 완전 수집**

**필수 추가 수집 필드** (62개):

1. **relate_subject** (관련 고교 교과목) - 2개 필드
   - `subject_name` (과목 종류명)
   - `subject_description` (과목 이름)

2. **career_act** (진로 탐색 활동) - 2개 필드
   - `act_name` (활동 종류명)
   - `act_description` (활동 설명)

3. **property** (학과특성) - 1개 필드

4. **enter_field** (진출분야) - 2개 필드
   - `gradeuate` (진출분야명)
   - `description` (진출분야설명)

5. **main_subject** (주요 교과목) - 2개 필드
   - `SBJECT_NM` (교과목명)
   - `SBJECT_SUMRY` (교과목설명)

6. **university** (개설대학) - 추가 5개 필드
   - `area` (지역)
   - `schoolURL` (학교URL)
   - `campus_nm` (캠퍼스명)
   - `majorName` (학과명)
   - `totalCount` (전체수)

7. **chartData** (학과전망 통계) - ~14개 필드
   - `applicant`, `gender`, `employment_rate`, `field`, `avg_salary`, `satisfaction`, `after_graduation`
   - 각각 `<item><data>`, `<item><name>` 구조

8. **GenCD** (성별비율) - 8개 필드
   - `popular` / `bookmark` 각각 4개 필드
   - `PCNT1`, `PCNT2`, `PCNT`, `GEN_NM`

9. **SchClass** (학교급별비율) - 8개 필드
   - `popular` / `bookmark` 각각 4개 필드
   - `PCNT1`, `PCNT2`, `PCNT`, `SCH_CLASS_NM`

10. **lstMiddleAptd** (중학생적성유형) - 6개 필드
    - `popular` / `bookmark` 각각 3개 필드
    - `RANK`, `CD_ORDR`, `CD_NM`

11. **lstHighAptd** (고등학생적성유형) - 6개 필드
    - `popular` / `bookmark` 각각 3개 필드
    - `RANK`, `CD_ORDR`, `CD_NM`

12. **lstVals** (선호직업가치) - 6개 필드
    - `popular` / `bookmark` 각각 3개 필드
    - `RANK`, `CD_ORDR`, `CD_NM`

**수정 파일**:
- `src/api/careernetAPI.ts:Major` 인터페이스 확장
- `src/api/careernetAPI.ts:getMajorDetail()` 함수 개선
- `src/api/careernetAPI.ts:normalizeCareerNetMajorDetail()` 함수 확장

---

#### **우선순위 2 (MEDIUM): 데이터 병합 전략 최적화**

1. **Name matching 알고리즘 검증** → 현재 case-insensitive 단순 비교
2. **Fuzzy matching 도입** → Levenshtein distance ≥90% 유사도
3. **Manual mapping table 구축** → 예외 케이스 처리

---

#### **우선순위 3 (LOW): 추가 검증**

1. **CareerNet 직업백과 edge case 확인** → 실제 API 응답과 비교
2. **고용24 API 재검증** → 모든 필드가 실제로 수집되는지 확인

---

### 5.3 개선 계획 타임라인

**Phase 1 (2-3일):**

1. **Day 1**: CareerNet 학과정보 API 코드 개선
   - `Major` 인터페이스에 62개 필드 추가
   - `getMajorDetail()` 함수에 XML/JSON 파싱 로직 추가
   - `normalizeCareerNetMajorDetail()` 함수에 필드 매핑 추가

2. **Day 2**: 재시딩 실행 및 검증
   - 1,435개 전공 재수집
   - 데이터 품질 검증 (빈 필드율, 완전성)
   - 병합 로직 검증

3. **Day 3**: Fuzzy matching 및 Manual mapping
   - Levenshtein distance 기반 매칭 추가
   - 예외 케이스 처리 테이블 구축

**예상 수집률 개선**:
- CareerNet 학과정보: 13% → **~95%**
- 전체: 79% → **~98%**

---

## 6. 참고 자료

### 6.1 공식 문서

- **CareerNet 직업백과 API**: https://www.career.go.kr/cnet/front/openapi/jobCenter.do
- **CareerNet 학과정보 API**: https://www.career.go.kr/cnet/front/openapi/openApiMajorCenter.do
- **고용24 API 문서**: `docs/고용24_API_extracted.txt`

### 6.2 관련 코드 파일

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

### 6.3 문서

- `docs/ARCHITECTURE.md` - 시스템 아키텍처 설계
- `docs/DEVELOPMENT_ROADMAP.md` - Phase별 개발 계획
- `docs/migration-plan.md` - 데이터 마이그레이션 상세 계획

---

## 변경 이력

| 날짜 | 작성자 | 변경 내용 |
|-----|-------|---------|
| 2025-01-06 (초안) | Claude AI | 고용24 API 문서화 (추정치 기반) |
| 2025-01-06 (재작성) | Claude AI | **완전 재작성 - CareerNet 공식 문서 기반 전체 필드 문서화** |

---

## 요약

### ✅ 완전 수집 완료
- 고용24 학과정보: **100%** (35/35 필드)
- 고용24 직업정보: **100%** (137/137 필드)
- CareerNet 직업백과: **~95%** (~73/77 필드)

### ⚠️ 개선 필요
- **CareerNet 학과정보**: **~13%** (~9/71 필드)
  - **62개 필드 누락** (통계, 진로, 교육 데이터)
  - Phase 1에서 최우선 개선 대상

### 📊 전체 수집률
- **현재**: ~79% (254/320 필드)
- **목표** (Phase 1 후): ~98% (316/320 필드)
