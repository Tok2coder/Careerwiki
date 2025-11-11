# 전공 디버그 페이지 링크

## 1. 항공여행과
- **일반 페이지**: http://localhost:3000/major/%ED%95%AD%EA%B3%B5%EC%97%AC%ED%96%89%EA%B3%BC
- **디버그 페이지**: http://localhost:3000/major/%ED%95%AD%EA%B3%B5%EC%97%AC%ED%96%89%EA%B3%BC?debug=true

## 2. 한국어과
- **일반 페이지**: http://localhost:3000/major/%ED%95%9C%EA%B5%AD%EC%96%B4%EA%B3%BC
- **디버그 페이지**: http://localhost:3000/major/%ED%95%9C%EA%B5%AD%EC%96%B4%EA%B3%BC?debug=true

## 3. 작곡과
- **일반 페이지**: http://localhost:3000/major/%EC%9E%91%EA%B3%A1%EA%B3%BC
- **디버그 페이지**: http://localhost:3000/major/%EC%9E%91%EA%B3%A1%EA%B3%BC?debug=true

---

## 디버그 페이지 사용법

디버그 페이지(`?debug=true`)를 열면 다음 정보를 확인할 수 있습니다:

1. **데이터 수집 상태**
   - CareerNet 데이터 수집 여부
   - Goyong24 데이터 수집 여부

2. **필드별 데이터 존재 여부**
   - 각 필드가 비어있는지 확인
   - 배열 필드의 항목 수 확인

3. **원본 API 응답**
   - CareerNet 원본 데이터
   - Goyong24 원본 데이터

---

## 확인해야 할 항목

### 개요 탭
- [ ] summary (전공 개요)
- [ ] property (전공 특성)
- [ ] aptitude (이 전공에 어울리는 사람)
- [ ] enterField (졸업 후 진출 분야)
- [ ] salaryAfterGraduation (연봉)
- [ ] employmentRate (취업률)

### 상세정보 탭 - 커리큘럼
- [ ] relateSubject (고교 추천 교과목)
- [ ] mainSubjects (주요 교과목)
- [ ] mainSubject (대학 주요 교과목 상세)
- [ ] whatStudy (무엇을 배우나요)
- [ ] howPrepare (어떻게 준비하나요)
- [ ] careerAct (진로 탐색 활동)
- [ ] licenses (추천 자격증)

### 상세정보 탭 - 진로·전망
- [ ] jobProspect (진로 전망)
- [ ] chartData (통계 정보)

### 상세정보 탭 - 연결정보
- [ ] relatedMajors (추천 유사 전공)

### 개설 대학 탭
- [ ] universities (개설 대학)
- [ ] recruitmentStatus (모집 정원 & 지원 현황)

### 사이드바
- [ ] relatedJobs (관련 직업)

### 히어로 태그
- [ ] relatedMajors (관련 학과명)

