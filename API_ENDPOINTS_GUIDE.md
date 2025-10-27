# API 엔드포인트 가이드

## 🌐 현재 사용 중인 API

### 커리어넷 (CareerNet) - 교육부

#### 1. **직업정보 API** (getOpenApi)
- **URL**: `https://www.career.go.kr/cnet/openapi/getOpenApi`
- **포맷**: JSON (우선) / XML (폴백)
- **용도**: 직업 상세 정보 (기본 정보 + 확장 데이터)

**파라미터 (변호사):**
```
apiKey: [환경변수]
svcType: api
svcCode: JOB_VIEW
contentType: json
gubun: job_dic_list
jobdicSeq: 375
```

**응답 예시 (JSON):**
```json
{
  "dataSearch": {
    "content": {
      "baseInfo": {
        "jobName": "변호사",
        "summary": "...",
        "avgSalary": "..."
      },
      "workList": [...],
      "performList": {
        "environment": [...],
        "perform": [...],
        "knowledge": [...]
      },
      "abilityList": [...],
      ...
    }
  }
}
```

#### 2. **직업백과 API** (jobs.json) ✨ 새로 추가!
- **URL**: `https://www.career.go.kr/cnet/front/openapi/jobs.json`
- **포맷**: JSON
- **용도**: 직업백과 추가 정보 (보조 데이터)

**파라미터 (변호사):**
```
apiKey: [환경변수]
id: 375
```

**응답 예시:**
```json
{
  "job": {
    "job_nm": "변호사",
    "job_summary": "...",
    "job_description": "...",
    "job_category": "...",
    ...
  }
}
```

---

### 고용24 (Goyong24) - 고용노동부

#### **직업정보 API** (3개 섹션)
- **URL 베이스**: `https://www.work24.go.kr/cm/openApi/call/hr/`
- **포맷**: XML
- **용도**: 직업 상세 정보 (3개 섹션으로 나뉨)

##### 섹션 1: 요약 (Summary)
- **엔드포인트**: `callOpenApiSvcInfo212D01`
- **dtlGb**: `1`

```
authKey: [환경변수]
returnType: XML
target: JOBCD
dtlGb: 1
jobCd: K000007482
```

##### 섹션 2: 직무 (Duty)
- **엔드포인트**: `callOpenApiSvcInfo212D02`
- **dtlGb**: `2`

```
authKey: [환경변수]
returnType: XML
target: JOBCD
dtlGb: 2
jobCd: K000007482
```

##### 섹션 3: 경로 (Path)
- **엔드포인트**: `callOpenApiSvcInfo212D03`
- **dtlGb**: `3`

```
authKey: [환경변수]
returnType: XML
target: JOBCD
dtlGb: 3
jobCd: K000007482
```

---

## 📊 데이터 수집 구조

### 현재 구조 (3개 API 병렬 호출)

```
변호사 직업 정보 요청
│
├─ CareerNet 직업정보 API (getOpenApi)
│  ├─ JSON 시도 (우선)
│  └─ XML 폴백
│
├─ CareerNet 직업백과 API (jobs.json) ✨
│  └─ JSON
│
└─ Goyong24 API (3개 섹션)
   ├─ 요약 (dtlGb=1)
   ├─ 직무 (dtlGb=2)
   └─ 경로 (dtlGb=3)
```

---

## 🔍 디버그 페이지 구성

### `/job/job:C_375` 페이지에서 확인 가능

#### 1. API 호출 상태
- CareerNet: 성공/실패
- Goyong24: 성공/실패

#### 2. 병합 후 필드 비교 테이블
- 72개 필드 비교
- 출처별 색상 구분

#### 3. 원본 API 응답 (3개 테이블)

##### 📘 커리어넷 직업백과 (jobs.json) - 보라색
- 직업백과 전용 데이터
- 추가적인 직업 설명
- 보조 정보

##### 📗 커리어넷 직업정보 (getOpenApi) - 파란색
- 기본 정보 (baseInfo)
- 업무 목록 (workList)
- 수행 능력 (performList)
- 능력/적성/흥미 (abilityList, aptitudeList, interestList)
- 직업 준비 (jobReadyList)
- 전망 (forecastList)
- 관련 자료 (relVideoList, relSolList 등)

##### 📙 고용24 (callOpenApiSvcInfo212D*) - 초록색
- 요약 정보 (jobSum)
- 직무 정보 (jobsDo)
- 경로 정보 (way)
- 학력/전공 분포
- 관련 학과/자격증/기관

---

## 🔧 코드 위치

### API 호출
| API | 파일 | 함수 |
|-----|------|------|
| 커리어넷 직업정보 | `src/api/careernetAPI.ts` | `getJobDetail()` (line 447) |
| 커리어넷 직업백과 | `src/api/careernetAPI.ts` | `getJobEncyclopedia()` (line 424) |
| 고용24 (3섹션) | `src/api/goyong24API.ts` | `fetchGoyong24JobDetail()` (line 681) |

### 데이터 통합
| 기능 | 파일 | 함수 |
|-----|------|------|
| 원본 데이터 수집 | `src/services/profileDataService.ts` | `getUnifiedJobDetailWithRawData()` (line 676) |
| 데이터 병합 | `src/services/profileMerge.ts` | `mergeJobProfiles()` |
| 디버그 렌더링 | `src/templates/dataDebugTemplate.ts` | `renderDataDebugPage()` |

---

## 🎯 API 선택 가이드

### 언제 어떤 API를 사용하나?

#### 커리어넷 직업정보 (getOpenApi)
✅ **주 데이터 소스**
- 직업 기본 정보
- 상세한 업무 설명
- 능력/적성/흥미 데이터
- 직업 전망
- 관련 자료

#### 커리어넷 직업백과 (jobs.json)
✅ **보조 데이터 소스**
- 추가적인 직업 설명
- 백과사전식 정보
- getOpenApi에 없는 추가 필드

#### 고용24 (callOpenApiSvcInfo212D*)
✅ **정부 공식 데이터**
- 한국 정부 공식 통계
- 학력/전공 분포
- 고용 형태
- 관련 기관 정보

---

## 📈 데이터 우선순위

### 병합 시 우선순위
1. **Goyong24** (고용노동부 공식 데이터)
2. **CareerNet 직업정보** (교육부 상세 데이터)
3. **CareerNet 직업백과** (보조 데이터)

### 특정 필드별 우선순위
- **이름**: Goyong24 > CareerNet
- **설명**: Goyong24.jobSum > CareerNet.summary
- **연봉**: Goyong24.sal > CareerNet.avgSalary
- **전망**: Goyong24.jobProspect > CareerNet.jobOutlook

---

## 🚀 테스트 URL

### 디버그 페이지 (3개 API 모두 확인)
```
https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/job:C_375
```

### 일반 페이지
```
https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/lawyer
```

---

## 📝 추가 정보

### 환경 변수
- `CAREER_NET_API_KEY`: 커리어넷 API 키
- `GOYONG24_JOB_API_KEY`: 고용24 직업 API 키

### API 제한사항
- 커리어넷: 일일 1,000회
- 고용24: 일일 1,000회

### 응답 시간
- 커리어넷 직업정보: ~500ms
- 커리어넷 직업백과: ~300ms
- 고용24 (3섹션): ~800ms (병렬 처리)
