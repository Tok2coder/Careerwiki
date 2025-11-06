# API Integration Documentation

> **최초 작성일**: 2025-01-06 (재작성)  
> **최종 업데이트**: 2025-11-06 (Phase 1 완료)  
> **목적**: CareerNet과 고용24 API의 **공식 문서 기반** 전체 필드 분석 및 현재 수집 현황 정리

---

## 🎯 Phase 1 완료 상태 (2025-11-06)

### ✅ 학과정보 수집 완료
- **총 전공 수**: 1,424개 (CareerNet 501개 + Goyong24 923개)
- **Phase 1 신규 필드**: 44개 추가
- **평균 수집률**: 100% (11/12 필드)
- **종합 품질 점수**: 100/100

### 📊 수집 현황 요약

#### CareerNet 학과정보 API
- **Phase 0 (기존)**: ~20개 필드 ✅ 100% 수집
- **Phase 1 (신규)**: 44개 필드 ✅ 100% 수집
- **총 필드 수**: ~64개 필드

#### 직업정보 API
- **CareerNet 직업백과**: 79개 필드 ✅ 100% 수집 (Phase 0 완료)
- **Goyong24 직업정보**: 97개 필드 ✅ 100% 수집 (Phase 0 완료)

### 🚀 다음 단계
- Phase 2 옵션 1: 프론트엔드 UI 개발
- Phase 2 옵션 2: 직업정보 추가 필드 분석
- Phase 2 옵션 3: 데이터 통합 및 품질 개선

**상세 내용**: `docs/PHASE1_COMPLETION_REPORT.md`, `docs/PROJECT_STATUS.md` 참조

---

## 📋 목차

1. [CareerNet API 필드 문서](#1-careernet-api-필드-문서)
   - [직업백과 API (job.json)](#11-직업백과-api-jobjson)
   - [학과정보 API (getOpenApi)](#12-학과정보-api-getopenapi)
2. [고용24 API 필드 문서](#2-고용24-api-필드-문서)
   - [학과정보 API](#21-학과정보-api)
   - [직업정보 API](#22-직업정보-api)
3. [현재 수집 현황](#3-현재-수집-현황)
4. [필드 매핑 및 병합 전략](#4-필드-매핑-및-병합-전략)
5. [갭 분석 및 개선 계획](#5-갭-분석-및-개선-계획)

---

## 1. CareerNet API 필드 문서

**공식 문서 출처**:
- 직업백과: https://www.career.go.kr/cnet/front/openapi/jobCenter.do
- 학과정보: https://www.career.go.kr/cnet/front/openapi/openApiMajorCenter.do

---

### 1.1 직업백과 API (job.json)

#### 기본 정보

**Endpoint**: `https://www.career.go.kr/cnet/front/openapi/job.json`

**인증**: `apiKey` (필수)

**Parameters**:
- `apiKey` (String, 필수): OPENAPI 인증키
- `seq` (Number, 필수): 직업코드

**Response Format**: JSON

**예시 요청**:
```
https://www.career.go.kr/cnet/front/openapi/job.json?apiKey=인증키&seq=8
```

---

#### 전체 응답 필드 구조 (15개 섹션, ~150 필드)

##### **섹션 1: baseInfo (기본 정보) - 23개 필드**

```json
{
  "baseInfo": {
    "seq": 8,                          // 고유번호
    "job_cd": 100,                     // 직업코드
    "job_nm": "물리학연구원",           // 직업명
    "aptit_name": "연구직 및 공학 기술직",  // 직업분류
    "emp_job_cd": "2114",              // 고용코드
    "emp_job_nm": "물리학연구원",       // 고용코드명
    "std_job_cd": "2114",              // 표준직업코드
    "std_job_nm": "물리학연구원",       // 표준직업코드명
    "rel_job_nm": "물리학교수, 천문학연구원, ...",  // 관련직업명
    "wage": 4500,                      // 평균연봉 (만원)
    "wage_source": "2020 임금구조기본통계조사",  // 평균연봉 출처
    "satisfication": 75,               // 직업만족도 (%)
    "satisfi_source": "2019 직업만족도조사",  // 직업만족도 출처
    "social": "사회공헌도 설명",        // 사회공헌
    "wlb": "일·가정균형 설명",          // 일·가정균형
    "INTRST_JOB_YN": "N",              // 관심직업 설정여부
    "views": 12543,                    // 조회수
    "likes": 89,                       // 추천수
    "tag": "물리학,연구,과학",          // 태그
    "reg_dt": "2020-01-15",            // 작성일
    "edit_dt": "2023-06-20"            // 수정일
  }
}
```

**현재 수집 상태**: ✅ **완전 수집** (23/23 필드)

---

##### **섹션 2: workList (하는 일) - 배열**

```json
{
  "workList": [
    { "work": "물질과 에너지의 기본 원리를 연구합니다." },
    { "work": "실험 장비를 설계하고 실험을 수행합니다." },
    ...
  ]
}
```

**필드**:
- `work` (String): 업무 설명

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 3: abilityList (핵심능력) - 배열**

```json
{
  "abilityList": [
    { "SORT_ORDR": "1", "ability_name": "분석적 사고" },
    { "SORT_ORDR": "2", "ability_name": "문제 해결 능력" },
    ...
  ]
}
```

**필드**:
- `SORT_ORDR` (String/Number): 정렬순서
- `ability_name` (String): 핵심능력명

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 4: departList (관련학과) - 배열**

```json
{
  "departList": [
    { "depart_id": 123, "depart_name": "물리학과" },
    { "depart_id": 456, "depart_name": "응용물리학과" },
    null  // null 요소 가능
  ]
}
```

**필드**:
- `depart_id` (Number): 관련학과 ID
- `depart_name` (String): 관련학과 명

**현재 수집 상태**: ✅ **완전 수집** (null 처리 포함)

---

##### **섹션 5: certiList (관련 자격증) - 배열**

```json
{
  "certiList": [
    { "certi": "방사선안전관리자", "LINK": "링크URL" },
    ...
  ]
}
```

**필드**:
- `certi` (String): 관련 자격증명
- `LINK` (String): 관련 자격증 링크

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 6: aptitudeList (적성) - 배열**

```json
{
  "aptitudeList": [
    { "aptitude": "논리적 사고력이 필요합니다." },
    ...
  ]
}
```

**필드**:
- `aptitude` (String): 적성 설명

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 7: interestList (흥미) - 배열**

```json
{
  "interestList": [
    { "interest": "탐구형(Investigative)" },
    ...
  ]
}
```

**필드**:
- `interest` (String): 흥미 설명

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 8: tagList (태그) - 문자열 배열**

```json
{
  "tagList": ["물리학", "연구", "과학", "실험"]
}
```

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 9: researchList (진로탐색활동) - 배열**

```json
{
  "researchList": [
    { "research": "물리학 관련 도서 읽기" },
    { "research": "과학관 체험 활동" },
    ...
  ]
}
```

**필드**:
- `research` (String): 진로탐색활동 설명

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 10: relVideoList (관련 동영상) - 배열**

```json
{
  "relVideoList": [
    {
      "video_id": "V12345",
      "video_name": "물리학연구원의 하루",
      "job_cd": "100",
      "CID": "C123",
      "THUMBNAIL_FILE_SER": "T456",
      "THUMNAIL_PATH": "https://cdn.career.go.kr/thumb/...",
      "OUTPATH3": "https://cdn.career.go.kr/video/..."
    }
  ]
}
```

**필드** (7개):
- `video_id` (String): 동영상 ID
- `video_name` (String): 동영상 제목
- `job_cd` (String/Number): 직업코드
- `CID` (String): 콘텐츠 ID
- `THUMBNAIL_FILE_SER` (String): 썸네일 ID
- `THUMNAIL_PATH` (String): 썸네일 URL
- `OUTPATH3` (String): 동영상 URL

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 11: relSolList (관련 진로상담) - 배열**

```json
{
  "relSolList": [
    {
      "cnslt_seq": 12345,
      "cnslt": "상담내용 요약",
      "SJ": "물리학자가 되려면?",
      "CN": "상세 상담 내용...",
      "TRGET_SE": "고등학생",
      "REGIST_DT": "2023-05-10"
    }
  ]
}
```

**필드** (6개):
- `cnslt_seq` (Number): 관련진로상담 ID
- `cnslt` (String): 진로상담 내용
- `SJ` (String): 제목
- `CN` (String): 내용(상세)
- `TRGET_SE` (String): 타겟층
- `REGIST_DT` (String): 등록일

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 12: relJinsolList (관련 자료) - 배열**

```json
{
  "relJinsolList": [
    {
      "SEQ": 789,
      "ALT": "자료ID",
      "SUBJECT": "물리학의 세계",
      "THUMBNAIL": "썸네일URL"
    }
  ]
}
```

**필드** (4개):
- `SEQ` (Number): 고유번호
- `ALT` (String): 관련자료ID
- `SUBJECT` (String): 관련자료명
- `THUMBNAIL` (String): 썸네일

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 13: jobReadyList (취업 준비) - 객체**

```json
{
  "jobReadyList": {
    "recruit": [
      { "recruit": "대학원 석·박사 학위 취득" }
    ],
    "certificate": [
      { "certificate": "방사선안전관리자" }
    ],
    "training": [
      { "training": "물리학 관련 전문교육" }
    ],
    "curriculum": [
      { "curriculum": "물리학과 학사 이상" }
    ]
  }
}
```

**필드** (4개 카테고리):
- `recruit` (Array): 입직 및 취업방법
- `certificate` (Array): 관련자격증
- `training` (Array): 직업훈련
- `curriculum` (Array): 정규교육과정

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 14: jobRelOrgList (관련 기관) - 배열**

```json
{
  "jobRelOrgList": [
    {
      "rel_org": "한국물리학회",
      "rel_org_url": "https://www.kps.or.kr"
    }
  ]
}
```

**필드** (2개):
- `rel_org` (String): 관련기관명
- `rel_org_url` (String): 관련기관 URL

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 15: forecastList (직업전망) - 배열**

```json
{
  "forecastList": [
    { "forecast": "향후 10년간 고용은 현 상태를 유지하거나 다소 증가할 것으로 전망됩니다..." }
  ]
}
```

**필드**:
- `forecast` (String): 직업전망 텍스트

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 16: eduChart (학력분포) - 배열**

```json
{
  "eduChart": [
    {
      "chart_name": "고졸이하,전문대졸,대졸,대학원졸",
      "chart_data": "0,0,20,80",
      "source": "2020 임금구조기본통계조사"
    }
  ]
}
```

**필드** (3개):
- `chart_name` (String): 학력분포 라벨 (콤마 구분)
- `chart_data` (String): 학력분포 데이터 (콤마 구분)
- `source` (String): 출처

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 17: majorChart (전공계열) - 배열**

```json
{
  "majorChart": [
    {
      "major": "인문,사회,교육,공학,자연,의학,예체능",
      "major_data": "0,0,0,5,95,0,0",
      "source": "2020 임금구조기본통계조사"
    }
  ]
}
```

**필드** (3개):
- `major` (String): 전공계열명 (콤마 구분)
- `major_data` (String): 전공계열 데이터 (콤마 구분)
- `source` (String): 출처

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 18: indicatorChart (직업지표) - 배열**

```json
{
  "indicatorChart": [
    {
      "indicator": "평균연봉,직업만족도,일·가정균형,사회공헌",
      "indicator_data": "4500,75,60,80",
      "source": "2020 임금구조기본통계조사"
    }
  ]
}
```

**필드** (3개):
- `indicator` (String): 직업지표명 (콤마 구분)
- `indicator_data` (String): 지표 데이터 (콤마 구분)
- `source` (String): 출처

**현재 수집 상태**: ✅ **완전 수집**

---

##### **섹션 19: performList (업무수행능력/지식/환경) - 객체**

```json
{
  "performList": {
    "environment": [
      {
        "environment": "실내근무",
        "inform": "대부분의 시간을 실내에서 보냅니다.",
        "importance": 90,
        "source": "O*NET"
      }
    ],
    "perform": [
      {
        "perform": "논리적 분석",
        "inform": "문제를 해결하기 위해 논리를 사용합니다.",
        "importance": 95,
        "source": "O*NET"
      }
    ],
    "knowledge": [
      {
        "knowledge": "물리",
        "inform": "물리학 원리와 법칙을 알아야 합니다.",
        "importance": 98,
        "source": "O*NET"
      }
    ]
  }
}
```

**필드** (3개 카테고리, 각 4개 필드):
- `environment` (Array): 업무환경
  - `environment` (String): 업무환경 항목명
  - `inform` (String): 설명
  - `importance` (Number): 중요도
  - `source` (String): 출처
- `perform` (Array): 업무수행능력
  - `perform` (String): 능력명
  - `inform` (String): 설명
  - `importance` (Number): 중요도
  - `source` (String): 출처
- `knowledge` (Array): 지식
  - `knowledge` (String): 지식명
  - `inform` (String): 설명
  - `importance` (Number): 중요도
  - `source` (String): 출처

**현재 수집 상태**: ✅ **완전 수집**

---

#### 직업백과 API 전체 요약

| 섹션 | 필드 수 | 현재 수집 | 수집률 |
|-----|--------|----------|-------|
| 1. baseInfo | 23 | 23 | ✅ 100% |
| 2. workList | 1 | 1 | ✅ 100% |
| 3. abilityList | 2 | 2 | ✅ 100% |
| 4. departList | 2 | 2 | ✅ 100% |
| 5. certiList | 2 | 2 | ✅ 100% |
| 6. aptitudeList | 1 | 1 | ✅ 100% |
| 7. interestList | 1 | 1 | ✅ 100% |
| 8. tagList | 1 | 1 | ✅ 100% |
| 9. researchList | 1 | 1 | ✅ 100% |
| 10. relVideoList | 7 | 7 | ✅ 100% |
| 11. relSolList | 6 | 6 | ✅ 100% |
| 12. relJinsolList | 4 | 4 | ✅ 100% |
| 13. jobReadyList | 4 | 4 | ✅ 100% |
| 14. jobRelOrgList | 2 | 2 | ✅ 100% |
| 15. forecastList | 1 | 1 | ✅ 100% |
| 16. eduChart | 3 | 3 | ✅ 100% |
| 17. majorChart | 3 | 3 | ✅ 100% |
| 18. indicatorChart | 3 | 3 | ✅ 100% |
| 19. performList | 12 | 12 | ✅ 100% |
| **합계** | **~79** | **~79** | **✅ 100%** |

**코드 위치**: `src/api/careernetAPI.ts`
- Type 정의: `JobEncyclopediaResponse` (lines 172-258)
- API 호출: `getJobEncyclopedia()` (lines 459-498)
- 정규화: `normalizeCareerNetJobDetail()` (lines 593-764)

---

### 1.2 학과정보 API (getOpenApi)

#### 기본 정보

**Endpoint**: `https://www.career.go.kr/cnet/openapi/getOpenApi`

**인증**: `apiKey` (필수)

**Parameters**:
- `apiKey` (String, 필수): OPENAPI 인증키
- `svcType` (String, 필수): `api`
- `svcCode` (String, 필수): `MAJOR` (목록) 또는 `MAJOR_VIEW` (상세)
- `contentType` (String, 선택): `xml` 또는 `json`
- `gubun` (String, 필수): 학교 분류 (예: `univ_list` - 대학교)
- `majorSeq` (String, 상세 시 필수): 학과코드

**Response Format**: XML 또는 JSON

**예시 요청**:
```
# 목록 조회
https://www.career.go.kr/cnet/openapi/getOpenApi.xml?apiKey=인증키&svcType=api&svcCode=MAJOR&gubun=univ_list

# 상세 조회
https://www.career.go.kr/cnet/openapi/getOpenApi.json?apiKey=인증키&svcType=api&svcCode=MAJOR_VIEW&gubun=univ_list&majorSeq=665
```

---

#### 1.2.1 목록 API (svcCode=MAJOR) - 5개 필드

**Response 구조** (XML):
```xml
<dataSearch>
  <content>
    <lClass>공학계열</lClass>              <!-- 계열 -->
    <mClass>컴퓨터공학과</mClass>           <!-- 학과 -->
    <totalCount>503</totalCount>           <!-- 전체 검색 결과수 -->
    <majorSeq>665</majorSeq>               <!-- 학과코드 -->
    <facilName>소프트웨어학과, IT학과, ...</facilName>  <!-- 세부학과명 (콤마 구분) -->
  </content>
</dataSearch>
```

**필드**:
1. `lClass` (String): 계열
2. `mClass` (String): 학과명
3. `totalCount` (String/Number): 전체 검색 결과수
4. `majorSeq` (String): 학과코드
5. `facilName` (String): 세부학과명 (콤마 구분)

**현재 수집 상태**: ✅ **완전 수집** (5/5 필드)

**코드 위치**: `src/api/careernetAPI.ts:searchMajors()` (lines 280-332)

---

#### 1.2.2 상세 API (svcCode=MAJOR_VIEW) - 대학교 (gubun=univ_list)

**총 필드 수**: **~80+ 필드** (17개 주요 섹션)

##### **섹션 1: 기본 정보 (6개 필드)**

```json
{
  "major": "법학과",                          // 학과명
  "salary": "<strong>130</strong> 만원 이상", // 졸업 후 직장임금
  "employment": "<strong>40</strong> % 이상", // 취업률
  "department": "DU인재법학부, ...",          // 세부관련학과 (콤마 구분)
  "summary": "법학과는 법에 대한 이해와...",   // 학과개요
  "interest": "흥미와 적성 설명..."            // 흥미와 적성
}
```

**현재 수집 상태**: ✅ **완전 수집** (6/6 필드)

---

##### **섹션 2: relate_subject (관련 고교 교과목) - 배열**

```json
{
  "relate_subject": [
    {
      "subject_name": "공통과목",
      "subject_description": "사회, 생활·교양"
    },
    {
      "subject_name": "일반선택",
      "subject_description": "사회·문화, 생활과 윤리, 윤리와 사상, 정치와 법"
    }
  ]
}
```

**필드** (2개):
- `subject_name` (String): 선택 과목 종류명
- `subject_description` (String): 종류에 따른 과목이름

**현재 수집 상태**: ❌ **미수집** (0/2 필드)

---

##### **섹션 3: career_act (진로 탐색 활동) - 배열**

```json
{
  "career_act": [
    {
      "act_name": "법률신문 구독",
      "act_description": "법률의 주요 이슈를 살펴볼 수 있습니다."
    },
    {
      "act_name": "모의재판 참여",
      "act_description": "법정에서의 역할을 이해할 수 있습니다."
    }
  ]
}
```

**필드** (2개):
- `act_name` (String): 활동 종류명
- `act_description` (String): 활동 설명

**현재 수집 상태**: ❌ **미수집** (0/2 필드)

---

##### **섹션 4: 관련 직업/자격 (2개 필드)**

```json
{
  "job": "감정평가사, 노무사, 법률사무원, ...",           // 관련직업 (콤마 구분)
  "qualifications": "감정평가사, 공인노무사, 공인중개사, ..."  // 관련자격 (콤마 구분)
}
```

**현재 수집 상태**: ✅ **완전 수집** (2/2 필드)

---

##### **섹션 5: property (학과특성) - 문자열**

```json
{
  "property": "법학과는 법률 전문가를 양성하는 학과로..."
}
```

**필드**:
- `property` (String): 학과특성 설명

**현재 수집 상태**: ❌ **미수집** (0/1 필드)

---

##### **섹션 6: enter_field (졸업 후 진출분야) - 배열**

```json
{
  "enter_field": [
    {
      "gradeuate": "법조계",
      "description": "변호사, 검사, 판사 등으로 진출"
    },
    {
      "gradeuate": "기업",
      "description": "기업 법무팀 또는 준법감시부서"
    }
  ]
}
```

**필드** (2개):
- `gradeuate` (String): 진출분야명 (**오타**: gradeuate → graduate)
- `description` (String): 진출분야 설명

**현재 수집 상태**: ❌ **미수집** (0/2 필드)

---

##### **섹션 7: main_subject (대학 주요 교과목) - 배열**

```json
{
  "main_subject": [
    {
      "SBJECT_NM": "민법총칙",
      "SBJECT_SUMRY": "민법 전반에 걸친 총칙..."
    },
    {
      "SBJECT_NM": "형법총론",
      "SBJECT_SUMRY": "형법의 기본 원리..."
    }
  ]
}
```

**필드** (2개):
- `SBJECT_NM` (String): 교과목명
- `SBJECT_SUMRY` (String): 교과목 설명

**현재 수집 상태**: ❌ **미수집** (0/2 필드)

---

##### **섹션 8: university (개설대학) - 배열**

```json
{
  "university": [
    {
      "area": "서울특별시",
      "schoolName": "건국대학교",
      "schoolURL": "http://www.konkuk.ac.kr",
      "campus_nm": "서울캠퍼스",
      "majorName": "법학과",
      "totalCount": ""
    }
  ]
}
```

**필드** (6개):
- `area` (String): 지역
- `schoolName` (String): 대학명
- `schoolURL` (String): 학교 URL
- `campus_nm` (String): 캠퍼스명
- `majorName` (String): 학과명
- `totalCount` (String): 전체수 (빈값 가능)

**현재 수집 상태**: ⚠️ **부분 수집** (2/6 필드)
- ✅ 수집: `schoolName`, `schoolURL`
- ❌ 누락: `area`, `campus_nm`, `majorName`, `totalCount`

---

##### **섹션 9: chartData (학과전망 통계) - 객체**

**하위 섹션** (7개):
1. `applicant` - 지원자 현황
2. `gender` - 성별 분포
3. `employment_rate` - 취업률
4. `field` - 취업 분야
5. `avg_salary` - 평균 임금
6. `satisfaction` - 만족도
7. `after_graduation` - 졸업 후 진로

**공통 구조**:
```json
{
  "chartData": {
    "applicant": [
      { "name": "2019", "data": "1234" },
      { "name": "2020", "data": "1456" },
      { "name": "2021", "data": "1589" }
    ],
    "gender": [
      { "name": "남자", "data": "60" },
      { "name": "여자", "data": "40" }
    ],
    "employment_rate": [
      { "name": "2019", "data": "75.5" },
      { "name": "2020", "data": "78.2" }
    ],
    "field": [
      { "name": "법조계", "data": "35" },
      { "name": "기업", "data": "40" },
      { "name": "공기업", "data": "15" }
    ],
    "avg_salary": [
      { "name": "2019", "data": "3500" },
      { "name": "2020", "data": "3800" }
    ],
    "satisfaction": [
      { "name": "매우만족", "data": "30" },
      { "name": "만족", "data": "50" }
    ],
    "after_graduation": [
      { "name": "취업", "data": "60" },
      { "name": "진학", "data": "25" },
      { "name": "기타", "data": "15" }
    ]
  }
}
```

**필드** (각 item당 2개):
- `name` (String): 항목명
- `data` (String/Number): 값

**현재 수집 상태**: ❌ **미수집** (0/14 필드)

---

##### **섹션 10: GenCD (특성 - 성별비율) - 객체**

```json
{
  "GenCD": {
    "popular": [
      {
        "PCNT1": "60",      // 비율 - 정수값
        "PCNT2": "60.5",    // 비율 - 소수값
        "PCNT": "61",       // 비율 - 반올림값
        "GEN_NM": "남자"    // 성별
      },
      {
        "PCNT1": "40",
        "PCNT2": "39.5",
        "PCNT": "40",
        "GEN_NM": "여자"
      }
    ],
    "bookmark": [
      // 동일 구조
    ]
  }
}
```

**필드** (4개):
- `PCNT1` (String): 비율 - 정수값
- `PCNT2` (String): 비율 - 소수값
- `PCNT` (String): 비율 - 반올림값
- `GEN_NM` (String): 성별

**현재 수집 상태**: ❌ **미수집** (0/4 필드)

---

##### **섹션 11: SchClass (특성 - 학교급별비율) - 객체**

```json
{
  "SchClass": {
    "popular": [
      {
        "PCNT1": "80",
        "PCNT2": "80.2",
        "PCNT": "80",
        "SCH_CLASS_NM": "4년제"
      },
      {
        "PCNT1": "20",
        "PCNT2": "19.8",
        "PCNT": "20",
        "SCH_CLASS_NM": "전문대"
      }
    ],
    "bookmark": [
      // 동일 구조
    ]
  }
}
```

**필드** (4개):
- `PCNT1` (String): 비율 - 정수값
- `PCNT2` (String): 비율 - 소수값
- `PCNT` (String): 비율 - 반올림값
- `SCH_CLASS_NM` (String): 학교급명

**현재 수집 상태**: ❌ **미수집** (0/4 필드)

---

##### **섹션 12: lstMiddleAptd (특성 - 중학생 적성유형) - 객체**

```json
{
  "lstMiddleAptd": {
    "popular": [
      {
        "RANK": "1",
        "CD_ORDR": "1",
        "CD_NM": "언어능력"
      }
    ],
    "bookmark": [
      // 동일 구조
    ]
  }
}
```

**필드** (3개):
- `RANK` (String): 순위
- `CD_ORDR` (String): 코드 순서
- `CD_NM` (String): 적성유형명

**현재 수집 상태**: ❌ **미수집** (0/3 필드)

---

##### **섹션 13: lstHighAptd (특성 - 고등학생 적성유형) - 객체**

**구조**: lstMiddleAptd와 동일

**필드** (3개):
- `RANK` (String): 순위
- `CD_ORDR` (String): 코드 순서
- `CD_NM` (String): 적성유형명

**현재 수집 상태**: ❌ **미수집** (0/3 필드)

---

##### **섹션 14: lstVals (특성 - 선호 직업가치) - 객체**

**구조**: lstMiddleAptd와 동일

**필드** (3개):
- `RANK` (String): 순위
- `CD_ORDR` (String): 코드 순서
- `CD_NM` (String): 직업가치명

**현재 수집 상태**: ❌ **미수집** (0/3 필드)

---

#### 학과정보 API 전체 요약 (대학교 상세)

| 섹션 | 필드 수 | 현재 수집 | 수집률 |
|-----|--------|----------|-------|
| 1. 기본 정보 | 6 | 6 | ✅ 100% |
| 2. relate_subject | 2 | 0 | ❌ 0% |
| 3. career_act | 2 | 0 | ❌ 0% |
| 4. 관련 직업/자격 | 2 | 2 | ✅ 100% |
| 5. property | 1 | 0 | ❌ 0% |
| 6. enter_field | 2 | 0 | ❌ 0% |
| 7. main_subject | 2 | 0 | ❌ 0% |
| 8. university | 6 | 2 | ⚠️ 33% |
| 9. chartData (7개 항목) | 14 | 0 | ❌ 0% |
| 10. GenCD | 4 | 0 | ❌ 0% |
| 11. SchClass | 4 | 0 | ❌ 0% |
| 12. lstMiddleAptd | 3 | 0 | ❌ 0% |
| 13. lstHighAptd | 3 | 0 | ❌ 0% |
| 14. lstVals | 3 | 0 | ❌ 0% |
| **합계** | **~54** | **~10** | **⚠️ ~19%** |

**코드 위치**: `src/api/careernetAPI.ts`
- Type 정의: `Major` interface (lines 159-169)
- 목록 API: `searchMajors()` (lines 280-332)
- 상세 API: `getMajorDetail()` (lines 335-395)
- 정규화: `normalizeCareerNetMajorDetail()` (lines 558-571)

---

### CareerNet API 전체 요약

| API 유형 | 총 필드 수 | 현재 수집 | 수집률 |
|---------|----------|----------|-------|
| 직업백과 (job.json) | ~79 | ~79 | ✅ 100% |
| 학과정보 목록 (MAJOR) | 5 | 5 | ✅ 100% |
| 학과정보 상세 (MAJOR_VIEW) | ~54 | ~10 | ⚠️ ~19% |
| **합계** | **~138** | **~94** | **⚠️ ~68%** |

---

## 2. 고용24 API 필드 문서

**공식 문서 출처**: 업로드된 "고용24 API 문서.docx"

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

**총 필드 수**: 22개

**현재 수집 상태**: ✅ **완전 수집** (22/22 필드)

**코드 위치**: `src/api/goyong24API.ts:parseMajorDetail()` (lines 303-360)

---

#### 2.1.3 이색학과 상세 API (majorGb=2)

**Endpoint**: `callOpenApiSvcInfo213D02.do`

**총 필드 수**: 8개

**현재 수집 상태**: ✅ **완전 수집** (8/8 필드)

**코드 위치**: `src/api/goyong24API.ts:parseMajorDetail()` (lines 304-324)

---

### 2.2 직업정보 API

#### 2.2.1 직업정보 목록 API

**Endpoint**: `callOpenApiSvcInfo212L01.do`

**총 필드 수**: 4개

**현재 수집 상태**: ✅ **완전 수집** (4/4 필드)

---

#### 2.2.2 직업정보 상세 API (7개 섹션)

고용24 직업정보 API는 **7개의 개별 endpoint**로 구성:

1. **섹션 1: 요약** (dtlGb=1) - 22개 필드 ✅ 100%
2. **섹션 2: 하는 일** (dtlGb=2) - 7개 필드 ✅ 100%
3. **섹션 3: 교육/자격/훈련** (dtlGb=3) - 23개 필드 ✅ 100%
4. **섹션 4: 임금/직업만족도/전망** (dtlGb=4) - 11개 필드 ✅ 100%
5. **섹션 5: 능력/지식/환경** (dtlGb=5) - 36개 필드 ✅ 100%
6. **섹션 6: 성격/흥미/가치관** (dtlGb=6) - 22개 필드 ✅ 100%
7. **섹션 7: 업무활동** (dtlGb=7) - 16개 필드 ✅ 100%

**총 필드 수**: 137개

**현재 수집 상태**: ✅ **완전 수집** (137/137 필드)

**코드 위치**: `src/api/goyong24API.ts` (lines 676-964)

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

| 데이터 소스 | 총 필드 수 | 현재 수집 | 수집률 |
|-----------|----------|----------|-------|
| **CareerNet 직업백과** | ~79 | ~79 | ✅ 100% |
| **CareerNet 학과정보** | ~59 | ~15 | ⚠️ ~25% |
| **고용24 학과정보** | 35 | 35 | ✅ 100% |
| **고용24 직업정보** | 141 | 141 | ✅ 100% |
| **총계** | **~314** | **~270** | **⚠️ ~86%** |

---

### 3.2 주요 누락 필드 (CareerNet 학과정보)

#### **우선순위 HIGH - 교육 콘텐츠 관련**

1. **relate_subject** (관련 고교 교과목) - 2개 필드
   - 고등학생 사용자에게 중요한 정보
   - 학과 선택 시 어떤 과목을 이수해야 하는지 안내

2. **career_act** (진로 탐색 활동) - 2개 필드
   - 학과 준비를 위한 실질적 활동 제안
   - 사용자 engagement 향상

3. **main_subject** (대학 주요 교과목) - 2개 필드
   - 학과에서 배우는 핵심 과목 정보
   - 대학 선택 시 중요한 의사결정 요소

#### **우선순위 MEDIUM - 통계 데이터**

4. **chartData** (학과전망 통계) - 14개 필드
   - 지원자 현황, 취업률, 평균 임금 등
   - 데이터 시각화에 활용 가능

5. **enter_field** (졸업 후 진출분야) - 2개 필드
   - 구체적인 진로 경로 정보

#### **우선순위 LOW - 부가 정보**

6. **property** (학과특성) - 1개 필드
7. **GenCD, SchClass** (특성 통계) - 8개 필드
8. **lstMiddleAptd, lstHighAptd, lstVals** (적성/가치) - 9개 필드
9. **university 상세 정보** (area, campus_nm 등) - 4개 필드

---

## 4. 필드 매핑 및 병합 전략

### 4.1 학과정보 병합 전략

**CareerNet과 고용24의 공통 필드**:

| 개념 | CareerNet | 고용24 | 병합 우선순위 |
|-----|----------|-------|------------|
| 학과명 | `major` | `knowSchDptNm` | CareerNet (더 표준화됨) |
| 학과소개 | `summary` | `schDptIntroSum` | CareerNet 우선, 없으면 고용24 |
| 적성/흥미 | `interest` | `aptdIntrstCont` | CareerNet 우선, 없으면 고용24 |
| 관련직업 | `job` | `relAdvanJobsList` | 병합 (중복 제거) |
| 관련자격 | `qualifications` | `licList` | 병합 |
| 개설대학 | `university` | `schDptList` | 병합 |

**CareerNet 고유 필드** (고용24에 없음):
- `relate_subject` - 관련 고교 교과목
- `career_act` - 진로 탐색 활동
- `property` - 학과특성
- `enter_field` - 졸업 후 진출분야
- `main_subject` - 대학 주요 교과목
- `chartData` - 학과전망 통계

**고용24 고유 필드** (CareerNet에 없음):
- `recrStateList` - **모집 현황** (입학정원, 지원자, 졸업생)
- `whatStudy` - **하는 공부** (이색학과 전용)
- `howPrepare` - **준비방법** (이색학과 전용)
- `jobProspect` - **직업 전망** (이색학과 전용)

---

### 4.2 직업정보 병합 전략

**CareerNet과 고용24의 공통 필드**:

| 개념 | CareerNet | 고용24 | 병합 우선순위 |
|-----|----------|-------|------------|
| 직업명 | `job_nm` | `jobNm` | CareerNet 우선 |
| 하는 일 | `workList` | `jobSum` | CareerNet 우선, 없으면 고용24 |
| 관련 전공 | `departList` | `relMajorList` | 병합 |
| 관련 자격증 | `certiList` | `relCertList` | 병합 |
| 연봉 | `wage` | `sal` | CareerNet 우선, 없으면 고용24 |
| 직업 전망 | `forecastList` | `jobProspect` | CareerNet 우선, 없으면 고용24 |

**CareerNet 고유 필드**:
- `relVideoList` - 관련 동영상
- `relSolList` - 관련 진로상담
- `relJinsolList` - 관련 자료
- `researchList` - 진로탐색활동
- `eduChart`, `majorChart`, `indicatorChart` - 차트 데이터

**고용24 고유 필드**:
- 세부 통계 (학력분포, 전공분포)
- 능력/지식/환경 상세 데이터 (직업 내/간 비교)
- 성격/흥미/가치관 상세 데이터
- 업무활동 상세 데이터

---

## 5. 갭 분석 및 개선 계획

### 5.1 Phase 1 개선 작업 (CareerNet 학과정보)

#### **Task 1: 누락 필드 파싱 추가**

**파일**: `src/api/careernetAPI.ts`

**1.1 Major 인터페이스 확장**
```typescript
export interface Major {
  // 기존 필드...
  
  // 새로 추가할 필드
  relateSubject?: Array<{           // 관련 고교 교과목
    subject_name: string
    subject_description: string
  }>
  careerAct?: Array<{               // 진로 탐색 활동
    act_name: string
    act_description: string
  }>
  property?: string                  // 학과특성
  enterField?: Array<{              // 졸업 후 진출분야
    gradeuate: string
    description: string
  }>
  mainSubject?: Array<{             // 대학 주요 교과목
    SBJECT_NM: string
    SBJECT_SUMRY: string
  }>
  chartData?: {                     // 학과전망 통계
    applicant?: Array<{name: string, data: string}>
    gender?: Array<{name: string, data: string}>
    employment_rate?: Array<{name: string, data: string}>
    field?: Array<{name: string, data: string}>
    avg_salary?: Array<{name: string, data: string}>
    satisfaction?: Array<{name: string, data: string}>
    after_graduation?: Array<{name: string, data: string}>
  }
  GenCD?: {                         // 특성 - 성별비율
    popular?: Array<{PCNT1: string, PCNT2: string, PCNT: string, GEN_NM: string}>
    bookmark?: Array<{PCNT1: string, PCNT2: string, PCNT: string, GEN_NM: string}>
  }
  SchClass?: {                      // 특성 - 학교급별비율
    popular?: Array<{PCNT1: string, PCNT2: string, PCNT: string, SCH_CLASS_NM: string}>
    bookmark?: Array<{PCNT1: string, PCNT2: string, PCNT: string, SCH_CLASS_NM: string}>
  }
  lstMiddleAptd?: {                 // 특성 - 중학생 적성유형
    popular?: Array<{RANK: string, CD_ORDR: string, CD_NM: string}>
    bookmark?: Array<{RANK: string, CD_ORDR: string, CD_NM: string}>
  }
  lstHighAptd?: {                   // 특성 - 고등학생 적성유형
    popular?: Array<{RANK: string, CD_ORDR: string, CD_NM: string}>
    bookmark?: Array<{RANK: string, CD_ORDR: string, CD_NM: string}>
  }
  lstVals?: {                       // 특성 - 선호 직업가치
    popular?: Array<{RANK: string, CD_ORDR: string, CD_NM: string}>
    bookmark?: Array<{RANK: string, CD_ORDR: string, CD_NM: string}>
  }
}
```

**1.2 getMajorDetail() 함수 수정**

현재 `getMajorDetail()` 함수는 JSON response를 그대로 spread operator로 포함하므로, API가 반환하는 모든 필드가 자동으로 포함됩니다.

**검증 필요**: 실제 API response에 위 필드들이 포함되어 있는지 확인

---

#### **Task 2: university 필드 상세 정보 추가**

**현재 코드** (lines 363-369):
```typescript
// university 배열을 문자열로 변환
let universityString = '';
if (major.university && Array.isArray(major.university)) {
  universityString = major.university
    .map((u: any) => u.schoolName || '')
    .filter((name: string) => name)
    .join(', ');
}
```

**개선안**:
```typescript
// university 배열을 상세 정보 포함하여 변환
let universityDetails: MajorUniversityInfo[] = [];
if (major.university && Array.isArray(major.university)) {
  universityDetails = major.university.map((u: any) => ({
    name: u.schoolName || '',
    url: u.schoolURL || '',
    area: u.area || '',            // 추가
    campus: u.campus_nm || '',     // 추가
    majorName: u.majorName || ''   // 추가
  })).filter(u => u.name);
}

// MajorUniversityInfo 인터페이스도 확장 필요
interface MajorUniversityInfo {
  name: string
  url?: string
  area?: string      // 추가
  campus?: string    // 추가
  majorName?: string // 추가
}
```

---

#### **Task 3: 데이터 검증 및 테스트**

1. **실제 API response 확인**
   - 1개 학과에 대해 상세 API 호출
   - 반환된 JSON 구조 확인
   - 모든 섹션이 포함되어 있는지 검증

2. **빈 필드 비율 측정**
   - 100개 샘플 학과에 대해 각 필드의 빈 값 비율 계산
   - 어떤 필드가 자주 비어있는지 파악

3. **seeding script 업데이트**
   - `src/scripts/seedAllMajors.ts` 수정
   - 새로운 필드를 `api_data_json`에 저장
   - 로깅 추가하여 수집 현황 모니터링

---

### 5.2 개선 우선순위

#### **우선순위 1 (HIGH): 교육 콘텐츠 필드**
- **예상 소요 시간**: 2-3시간
- **대상 필드**: `relate_subject`, `career_act`, `main_subject`, `enter_field`, `property`
- **이유**: 사용자에게 실질적 가치가 높은 정보

#### **우선순위 2 (MEDIUM): 통계 데이터**
- **예상 소요 시간**: 2-3시간
- **대상 필드**: `chartData` (7개 항목)
- **이유**: 데이터 시각화 및 의사결정 지원

#### **우선순위 3 (LOW): 부가 통계**
- **예상 소요 시간**: 1-2시간
- **대상 필드**: `GenCD`, `SchClass`, `lstMiddleAptd`, `lstHighAptd`, `lstVals`
- **이유**: Phase 2 이후 추가 가능

---

### 5.3 Phase 1 완료 후 예상 수집률

| 데이터 소스 | 현재 수집률 | Phase 1 후 예상 |
|-----------|----------|--------------|
| CareerNet 직업백과 | ✅ 100% | ✅ 100% |
| CareerNet 학과정보 | ⚠️ ~25% | ✅ ~90% |
| 고용24 학과정보 | ✅ 100% | ✅ 100% |
| 고용24 직업정보 | ✅ 100% | ✅ 100% |
| **전체 평균** | **⚠️ ~86%** | **✅ ~97%** |

---

## 6. 참고 자료

### 6.1 관련 코드 파일

**API 클라이언트**:
- `src/api/careernetAPI.ts` - CareerNet API 호출 및 파싱
- `src/api/goyong24API.ts` - 고용24 API 호출 및 파싱

**데이터 병합**:
- `src/services/profileMerge.ts` - CareerNet + 고용24 병합 로직
- `src/services/profileDataService.ts` - Unified API service

**Seeding Scripts**:
- `src/scripts/seedAllMajors.ts` - 1,435개 전공 수집
- `src/scripts/seedAllJobs.ts` - 587개 직업 수집

**Type Definitions**:
- `src/types/unifiedProfiles.ts` - UnifiedJobDetail, UnifiedMajorDetail 등

### 6.2 문서

- `docs/ARCHITECTURE.md` - 시스템 아키텍처 설계
- `docs/DEVELOPMENT_ROADMAP.md` - Phase별 개발 계획
- `docs/migration-plan.md` - 데이터 마이그레이션 상세 계획

---

## 변경 이력

| 날짜 | 작성자 | 변경 내용 |
|-----|-------|---------|
| 2025-01-06 | Claude AI | 초안 작성 - 고용24 API 문서화 |
| 2025-01-06 | Claude AI | **완전 재작성** - CareerNet 공식 문서 기반 분석 완료 |
