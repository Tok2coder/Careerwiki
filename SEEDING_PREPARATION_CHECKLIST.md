# ✅ 데이터 시딩 준비 체크리스트

**목표**: 모든 전공 데이터(1,424개)와 모든 직업 데이터(587개)를 **모든 필드**와 함께 수집

---

## 📋 준비 항목

### 1. API 키 확인 ✅
- [x] `.dev.vars` 파일 존재
- [x] `CAREER_NET_API_KEY` 설정됨
- [x] `GOYONG24_MAJOR_API_KEY` 설정됨
- [x] `GOYONG24_JOB_API_KEY` 설정됨

**현재 상태:**
```
CAREER_NET_API_KEY=38aef3e2-5a9d-4e71-8c2e-7a1da49b33e0
GOYONG24_MAJOR_API_KEY=38aef3e2-5a9d-4e71-8c2e-7a1da49b33e0
GOYONG24_JOB_API_KEY=38aef3e2-5a9d-4e71-8c2e-7a1da49b33e0
```

---

### 2. API 연결 테스트 ⚠️
- [ ] CareerNet API 연결 테스트
- [ ] Goyong24 Major API 연결 테스트
- [ ] Goyong24 Job API 연결 테스트

**필요한 작업:**
- API 키 유효성 검증
- 네트워크 연결 확인
- API 엔드포인트 접근 가능 여부 확인

---

### 3. 데이터베이스 준비 ✅
- [x] D1 데이터베이스 마이그레이션 완료
- [x] `majors` 테이블 생성됨
- [x] `jobs` 테이블 생성됨
- [x] `wiki_pages` 테이블 생성됨

---

### 4. 시딩 스크립트 검증 🔄

#### 4.1 전공 시딩 스크립트 (`seedAllMajors.ts`)
- [x] 스크립트 파일 존재
- [x] Miniflare D1 연결 설정
- [x] 환경 변수 로드 로직
- [ ] **모든 필드 수집 확인 필요**

**수집해야 하는 필드:**

**기본 필드 (Phase 0):**
- [x] id, name, summary
- [x] category, aptitude
- [x] mainSubjects, licenses
- [x] universities, recruitmentStatus
- [x] relatedJobs, relatedMajors
- [x] whatStudy, howPrepare
- [x] jobProspect, salaryAfterGraduation, employmentRate

**Phase 1 필드 (44개):**
- [x] relateSubject (관련 고교 교과목)
- [x] careerAct (진로 탐색 활동)
- [x] mainSubject (대학 주요 교과목)
- [x] enterField (졸업 후 진출분야)
- [x] property (학과 특성)
- [x] chartData (통계 차트 데이터)
- [x] genCD (성별 통계)
- [x] schClass (학교 분류 통계)
- [x] lstMiddleAptd (중학교 적성)
- [x] lstHighAptd (고등학교 적성)
- [x] lstVals (가치관)
- [ ] universityList (개설 대학 상세) - 로직 이슈 있음

**확인 필요:**
- [ ] `getUnifiedMajorDetail()` 함수가 모든 필드를 반환하는지
- [ ] `normalizeCareerNetMajorDetail()` 함수가 모든 Phase 1 필드를 매핑하는지
- [ ] `normalizeGoyong24MajorDetail()` 함수가 모든 필드를 매핑하는지

#### 4.2 직업 시딩 스크립트 (`seedAllJobs.ts`)
- [x] 스크립트 파일 존재
- [x] Miniflare D1 연결 설정
- [x] 환경 변수 로드 로직
- [ ] **모든 필드 수집 확인 필요**

**수집해야 하는 필드:**
- [x] id, name, summary
- [x] category, classifications
- [x] duties, way
- [x] relatedMajors, relatedCertificates
- [x] salary, satisfaction, prospect, status
- [x] abilities, knowledge, environment
- [x] personality, interests, values
- [x] technKnow, relatedJobs
- [ ] 모든 CareerNet 필드
- [ ] 모든 Goyong24 필드

---

### 5. 에러 처리 개선 🔄
- [ ] API 요청 실패 시 재시도 로직
- [ ] 네트워크 타임아웃 처리
- [ ] Rate limiting 처리
- [ ] 부분 실패 시 진행 상황 저장
- [ ] 에러 로그 상세화

---

### 6. 진행 상황 모니터링 🔄
- [x] 진행률 표시 (processed/total)
- [x] 예상 시간 계산
- [x] Phase 1 필드 수집 통계 (전공)
- [ ] 실시간 데이터베이스 확인 스크립트
- [ ] 중단 시 재개 가능 여부 확인

---

### 7. 데이터 검증 🔄
- [ ] 시딩 완료 후 데이터 수 확인
- [ ] 필드별 수집률 확인
- [ ] 샘플 데이터 검증
- [ ] 데이터 소스별 통계 확인

---

## 🚨 현재 발견된 문제

### 1. API 요청 실패
**에러:**
```
학과정보 검색 오류: Error: API 요청 실패
```

**원인 분석 필요:**
- API 키 유효성
- 네트워크 연결
- API 엔드포인트 변경
- Rate limiting

### 2. universityList 필드 매핑 이슈
- 원본 데이터는 수집되지만 매핑 로직 문제
- Phase 2에서 수정 예정

---

## 📝 다음 단계

1. **API 연결 테스트 스크립트 작성**
2. **시딩 스크립트 필드 수집 로직 검증**
3. **에러 처리 개선**
4. **테스트 시딩 (소량 데이터)**
5. **전체 시딩 실행**

---

**준비 상태**: 🔄 진행 중
**예상 완료 시간**: 준비 완료 후 알림

