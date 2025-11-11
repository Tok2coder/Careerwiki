# 커리어넷 & 고용24 전공 API 필드 매핑 문서

## 📋 전공 필드 전체 목록

### 현재 전공명 위에 표시되는 필드
**필드명**: `categoryName` (계열/분야)
**API 출처**: CareerNet `department` 필드
**예시 데이터**: "공학계열", "인문계열", "상경계열"

**문제**: 현재 일부 전공에서 관련 학과명들이 나열되어 표시됨
예: "경영학과 항공경영전공,항공과,항공관광과,..."

---

## CareerNet 전공 API 필드 (17개)

### 1️⃣ 기본 정보
| 필드명 | API 필드 | 설명 | 예시 데이터 |
|--------|----------|------|-------------|
| `majorSeq` | `majorSeq` | 전공 코드 | "10001" |
| `major` (name) | `major` | 전공명 | "항공여행과" |
| `summary` | `summary` | 전공 소개 | "항공사 승무원, 공항 지상직 등을 양성하는 학과입니다." |
| `categoryName` | `department` | **계열/분야** | **"상경계열"** ← 이것만 표시 필요 |
| `categoryId` | `mClass` | 계열 코드 | "11" |

### 2️⃣ 취업/진로 정보
| 필드명 | API 필드 | 설명 | 예시 데이터 |
|--------|----------|------|-------------|
| `employmentRate` | `employment` | 취업률 | "85.2%" |
| `salaryAfterGraduation` | `salary` | 졸업 후 평균 연봉 | "3,200만원" |
| `relatedJob` | `job` | 관련 직업 | "항공기객실승무원,지상조업원" |
| `enterField` | `enter_field` | 졸업 후 진출 분야 | [{ title: "항공사", description: "승무원, 지상직" }] |

### 3️⃣ 교육 과정
| 필드명 | API 필드 | 설명 | 예시 데이터 |
|--------|----------|------|-------------|
| `relateSubject` | `relate_subject` | 고교 추천 교과목 | [{ title: "영어", description: "..." }] |
| `mainSubject` | `main_subject` | 대학 주요 교과목 | [{ title: "항공서비스론", description: "..." }] |
| `careerAct` | `career_act` | 진로 탐색 활동 | [{ title: "항공사 채용설명회", description: "..." }] |
| `property` | (별도 필드) | 전공 특성 | "고객 서비스 중심의 실무형 전공" |

### 4️⃣ 대학 정보
| 필드명 | API 필드 | 설명 | 예시 데이터 |
|--------|----------|------|-------------|
| `universityList` | `university` | 개설 대학 상세 | [{ schoolName: "한국항공대", schoolURL: "...", area: "서울" }] |
| `recruitmentStatus` | (통계 데이터) | 모집 정원/지원 현황 | [{ year: "2023", enscMxnp: 50, enscSpnb: 120 }] |

### 5️⃣ 통계/차트 데이터
| 필드명 | API 필드 | 설명 | 예시 데이터 |
|--------|----------|------|-------------|
| `chartData` | `chartData` | 전망 통계 (지원자/취업률/만족도) | { applicant: [...], employment_rate: [...] } |
| `lstMiddleAptd` | `lstMiddleAptd` | 중학생 적성 유형 | { popular: [{ CD_NM: "예술형" }] } |
| `lstHighAptd` | `lstHighAptd` | 고등학생 적성 유형 | { popular: [{ CD_NM: "탐구형" }] } |
| `lstVals` | `lstVals` | 선호 직업가치 | { popular: [{ CD_NM: "안정성" }] } |

---

## Goyong24 전공 API 필드 (7개)

### 1️⃣ 기본 정보
| 필드명 | API 필드 | 설명 | 예시 데이터 |
|--------|----------|------|-------------|
| `knowDptNm` | `knowDptNm` | **계열명** | **"자연계열"** ← 이것만 표시 필요 |
| `knowSchDptNm` | `knowSchDptNm` | 학과명 | "농학과" |
| `schDptIntroSum` | `schDptIntroSum` | 학과 소개 | "작물 재배, 육종, 병충해 관리 등을 다루는 학과입니다." |

### 2️⃣ 교육 과정
| 필드명 | API 필드 | 설명 | 예시 데이터 |
|--------|----------|------|-------------|
| `aptdIntrstCont` | `aptdIntrstCont` | 적성/흥미 내용 | "생물학에 흥미가 있고..." |
| `mainSubjectList` | `mainSubjectList` | 주요 교과목 | [{ mainEdusbjCont: "작물학" }] |
| `licList` | `licList` | 취득 자격 | [{ adoptCertCont: "식물보호기사" }] |

### 3️⃣ 대학/진로 정보
| 필드명 | API 필드 | 설명 | 예시 데이터 |
|--------|----------|------|-------------|
| `schDptList` | `schDptList` | 개설 대학 목록 | [{ univNm: "서울대", univGbnNm: "4년제" }] |
| `relAdvanJobsList` | `relAdvanJobsList` | 관련 직업 목록 | [{ knowJobNm: "농업기술자" }] |
| `recrStateList` | `recrStateList` | 모집 현황 | [{ year: "2023", enscMxnp: 30 }] |

---

## 🔍 문제 해결

### 현재 문제
**전공명 위 표시**: "경영학과 항공경영전공,항공과,항공관광과,항공관광과 글로벌관광면세전공,..."

### 원인 추정
`categoryName` 필드에 **관련 학과명**이 잘못 매핑되었을 가능성

### 올바른 표시
- CareerNet: `department` (예: "상경계열")
- Goyong24: `knowDptNm` (예: "자연계열")

---

## 📌 다음 단계
1. 항공여행과 데이터 확인 (`categoryName` 필드 값)
2. API 매핑 로직 점검 (`normalizeCareerNetMajorDetail` 함수)
3. 수정 후 캐시 갱신
