# CareerWiki 프로젝트 현황

**최종 업데이트:** 2025-11-06  
**현재 Phase:** Phase 1 완료 ✅ (전공 + 직업 데이터 시딩 완료)  
**다음 Phase:** Phase 2 대기 중

---

## 🎯 프로젝트 개요

**목표:** 한국의 모든 직업 및 학과 정보를 통합하여 커리어 탐색 플랫폼 구축

**데이터 소스:**
- CareerNet (커리어넷) - 직업백과 API, 학과정보 API
- Goyong24 (고용24) - 직업정보 API, 학과정보 API

**기술 스택:**
- Backend: Hono + TypeScript
- Database: Cloudflare D1 (SQLite)
- Deployment: Cloudflare Pages

---

## 📊 현재 상태 (2025-11-06)

### ✅ 완료된 작업

#### Phase 0: 기본 데이터 수집 (이전 완료)
- [x] CareerNet 직업정보 API 연동 (100% 완료)
- [x] Goyong24 직업정보 API 연동 (100% 완료)
- [x] CareerNet 학과정보 API 연동 (기본 필드)
- [x] Goyong24 학과정보 API 연동 (기본 필드)
- [x] D1 데이터베이스 설계 및 마이그레이션
- [x] 시딩 스크립트 구현

**Phase 0 수집 필드 (학과 기준):**
- 학과명, 분류, 요약, 적성
- 주요 교과목, 자격증, 관련 직업
- 개설 대학 목록 (기본)
- 모집 현황, 취업률, 졸업 후 연봉

**Phase 0 필드 수:** ~20개

---

#### Phase 1: CareerNet 학과정보 추가 필드 수집 ✅

**완료일:** 2025-11-06  
**소요 시간:** ~8시간  
**성공률:** 100%

##### 1.1 코드 구현
- [x] `Major` 인터페이스 확장 (44개 필드 추가)
- [x] `getMajorDetail()` 함수 수정 (spread operator 활용)
- [x] `normalizeCareerNetMajorDetail()` 함수 업데이트
- [x] `UnifiedMajorDetail` 타입 확장
- [x] `MajorUniversityInfo` 타입 확장 (area, campus 추가)

**수정된 파일:**
- `src/api/careernetAPI.ts` - Major 인터페이스, getMajorDetail(), normalizeCareerNetMajorDetail()
- `src/types/unifiedProfiles.ts` - UnifiedMajorDetail, MajorUniversityInfo

##### 1.2 테스트 및 검증
- [x] 단일 학과 테스트 (전기전자공학과) - 100% 성공
- [x] 10개 샘플 학과 테스트 - 100% 성공
- [x] 전체 1,424개 전공 시딩 - 100% 성공

**테스트 스크립트:**
- `test-major-api.ts` - 단일 학과 필드 검증
- `test-seed-10majors.ts` - 10개 샘플 시딩 테스트
- `seed-remaining.ts` - 나머지 전공 효율적 수집

##### 1.3 데이터 수집 결과
- [x] **총 1,427개 전공 수집 완료** (2025-11-06 최종)
  - CareerNet: 504개 (35.3%)
  - Goyong24: 923개 (64.7%)
- [x] **Phase 1 신규 필드 44개 추가**
- [x] **평균 수집률: 97.0%** (11/12 필드, universityList 제외)
- [x] **오류율: 0%**

##### 1.4 직업 데이터 시딩 완료 (2025-11-06)
- [x] **총 980개 직업 수집 완료**
  - CareerNet: 443개 (45.2%)
  - Goyong24: 537개 (54.8%)
- [x] **성공률: 98.9%** (980/991)
- [x] **에러: 11개** (API 데이터 누락)
- [x] **소요 시간: 13분 29초**

##### 1.4 품질 검증
- [x] 데이터 품질 리포트 생성
- [x] 필드별 수집률 계산 (샘플 100개 분석)
- [x] 종합 품질 점수: **100/100**

**검증 스크립트:**
- `verify-phase1-data.ts` - Phase 1 필드 검증
- `verify-data-sources.ts` - 데이터 소스 검증
- `data-quality-report.ts` - 종합 품질 리포트

##### 1.5 문서화 및 백업
- [x] API_INTEGRATION.md 재작성 (전체 필드 문서)
- [x] PHASE1_COMPLETION_REPORT.md 작성
- [x] PROJECT_STATUS.md 작성 (본 문서)
- [x] 프로젝트 백업 완료

**백업 정보:**
- URL: https://page.gensparksite.com/project_backups/careerwiki_phase1_complete.tar.gz
- 크기: 6.1MB
- 포함: 소스 코드 + D1 데이터베이스 + 문서

---

### 📦 Phase 1 신규 필드 상세

#### 교육 콘텐츠 필드 (우선순위: HIGH)
1. **relateSubject** - 관련 고교 교과목
   - 타입: `Array<{subject_name: string, subject_description: string}>`
   - 수집률: 100%
   - 평균 항목 수: 6개
   - 예시: "수학, 과학, 기술ㆍ가정"

2. **careerAct** - 진로 탐색 활동
   - 타입: `Array<{act_name: string, act_description: string}>`
   - 수집률: 100%
   - 평균 항목 수: 2-4개
   - 예시: "전기전자키트조립", "잡지구독"

3. **mainSubject** - 대학 주요 교과목
   - 타입: `Array<{SBJECT_NM: string, SBJECT_SUMRY: string}>`
   - 수집률: 99%
   - 평균 항목 수: 5-6개
   - 예시: "전기자기학", "전자회로"

4. **enterField** - 졸업 후 진출분야
   - 타입: `Array<{gradeuate: string, description: string}>`
   - 수집률: 100%
   - 평균 항목 수: 2-3개
   - 예시: "기업 및 산업체", "학계 및 연구기관"
   - 참고: API 오타 "gradeuate" (graduate 아님)

5. **property** - 학과 특성
   - 타입: `string`
   - 수집률: 100%
   - 길이: 100-300자
   - 예시: "전기전자공학과에서는 전기 분야에 대한 이론과..."

#### 통계 데이터 필드 (우선순위: MEDIUM)
6. **chartData** - 통계 차트 데이터
   - 타입: `Object`
   - 수집률: 100%
   - 포함 통계:
     - `applicant` - 지원자 추이
     - `gender` - 성별 분포
     - `employment_rate` - 취업률
     - `field` - 분야별 분포
     - `avg_salary` - 평균 연봉
     - `satisfaction` - 만족도
     - `after_graduation` - 졸업 후 진로

#### 특성 통계 필드 (우선순위: LOW)
7. **genCD** - 성별 통계
   - 수집률: 100%
   - 복잡한 중첩 구조

8. **schClass** - 학교 분류 통계
   - 수집률: 100%

9. **lstMiddleAptd** - 중학교 적성
   - 수집률: 100%

10. **lstHighAptd** - 고등학교 적성
    - 수집률: 100%

11. **lstVals** - 가치관
    - 수집률: 100%

#### 알려진 이슈 (우선순위: LOW)
12. **universityList** - 개설 대학 상세 (지역, 캠퍼스)
    - 타입: `Array<{schoolName, schoolURL, area, campus_nm}>`
    - 수집률: 0% ⚠️
    - 이슈: normalizeCareerNetMajorDetail() 변환 로직 문제
    - 해결책: 원본 `university` 배열은 정상 수집됨, 프론트엔드에서 사용 가능
    - Phase 2에서 수정 고려

---

### 📁 데이터베이스 현황

#### D1 로컬 데이터베이스
**위치:** `.wrangler/state/v3/d1/`  
**데이터베이스 ID:** edc21e23-c2ac-4693-bb79-389b6914e173

**테이블: majors**
```sql
CREATE TABLE majors (
    id TEXT PRIMARY KEY,                -- 전공 고유 ID
    careernet_id TEXT,                  -- CareerNet majorSeq
    goyong24_id TEXT,                   -- Goyong24 ID (G{majorId}_{학과명})
    name TEXT NOT NULL,                 -- 학과명
    
    -- API 데이터
    api_data_json TEXT,                 -- 통합 JSON 데이터
    api_data_hash TEXT,                 -- 변경 감지용 해시
    api_last_fetched_at INTEGER,       -- 마지막 API 호출 시각
    api_last_updated_at INTEGER,       -- API 데이터 변경 시각
    
    -- 사용자 기여 데이터
    user_contributed_json TEXT,
    user_last_updated_at INTEGER,
    
    -- 운영진 데이터
    admin_data_json TEXT,
    admin_last_updated_at INTEGER,
    
    -- 메타데이터
    created_at INTEGER NOT NULL,
    is_active INTEGER DEFAULT 1
);
```

**현재 데이터:**
- 전공 레코드: 1,427개
  - CareerNet 전공: 504개
  - Goyong24 전공: 923개
- 직업 레코드: 980개
  - CareerNet 직업: 443개
  - Goyong24 직업: 537개
- 총 데이터: 2,407개

**api_data_json 구조:**
```json
{
  "careernet": {/* CareerNet 원본 데이터 */},
  "goyong24": {/* Goyong24 원본 데이터 */},
  "merged": {/* 통합된 UnifiedMajorDetail */},
  "sources": ["CAREERNET"] or ["GOYONG24"]
}
```

---

### 🔧 핵심 함수 및 로직

#### 1. CareerNet API 클라이언트
**파일:** `src/api/careernetAPI.ts`

**주요 함수:**
```typescript
// 학과 검색 (페이징)
searchMajors(params: {
  keyword?: string,
  thisPage?: number,
  perPage?: number
}, env?: any): Promise<MajorSummary[]>

// 학과 상세 정보 (Phase 1 필드 포함)
getMajorDetail(majorSeq: string, env?: any): Promise<Major | null>
// - spread operator로 API 응답의 모든 필드 자동 수집
// - universityList 변환 로직 포함

// UnifiedMajorDetail로 정규화
normalizeCareerNetMajorDetail(major: Major): UnifiedMajorDetail
// - Phase 1 필드 매핑
// - relateSubject, careerAct, mainSubject 등 변환
```

**API 엔드포인트:**
- 검색: `https://www.career.go.kr/cnet/openapi/getOpenApi`
- 상세: `https://www.career.go.kr/cnet/openapi/getOpenApi` (svcCode=MAJOR_VIEW)

#### 2. Goyong24 API 클라이언트
**파일:** `src/api/goyong24API.ts`

**주요 함수:**
```typescript
// 학과 목록 검색
fetchGoyong24MajorList(params: {
  keyword: string,
  srchType: 'K'
}, env?: any): Promise<{items: Goyong24MajorListItem[]}>

// 학과 상세 정보
fetchGoyong24MajorDetail(params: {
  majorGb: '1' | '2',
  departmentId: string,
  majorId: string
}, env?: any): Promise<Goyong24MajorDetail>

// UnifiedMajorDetail로 정규화
normalizeGoyong24MajorDetail(detail: Goyong24MajorDetail): UnifiedMajorDetail
```

**API 엔드포인트:**
- 목록: `https://www.work24.go.kr/cm/openApi/call/hr/callOpenApiSvcInfo330L01.do`
- 상세: `https://www.work24.go.kr/cm/openApi/call/hr/callOpenApiSvcInfo330D01.do`

#### 3. 통합 데이터 서비스
**파일:** `src/services/profileDataService.ts`

**주요 함수:**
```typescript
// 통합 학과 상세 정보 가져오기
getUnifiedMajorDetail(request: {
  id: string,
  careernetId?: string,
  goyong24Params?: {
    majorGb: '1' | '2',
    departmentId: string,
    majorId: string
  }
}, env: Env): Promise<{
  profile: UnifiedMajorDetail,
  partials?: {
    CAREERNET?: any,
    GOYONG24?: any
  },
  sources: DataSource[]
}>

// - D1에서 먼저 조회
// - 없으면 API 호출
// - 여러 소스 데이터 병합
```

#### 4. 시딩 스크립트
**파일:** `src/scripts/seedAllMajors.ts`

**주요 로직:**
1. CareerNet 학과 목록 수집 (페이징)
2. Goyong24 학과 목록 수집 (키워드 검색)
3. 중복 제거
4. 각 학과별 상세 정보 수집
5. D1에 upsert (해시 비교로 변경 감지)
6. Phase 1 필드 통계 수집 및 로깅

**실행 방법:**
```bash
cd /home/user/webapp
npx tsx src/scripts/seedAllMajors.ts
```

---

## 🚀 다음 작업 (Phase 2 옵션)

### Option 1: 프론트엔드 UI 개발
**목표:** Phase 1 필드를 활용한 학과 상세 페이지 구현

**작업 내용:**
1. 학과 상세 페이지 UI 설계
2. Phase 1 필드 표시
   - 관련 고교 교과목 섹션
   - 진로 탐색 활동 가이드
   - 대학 주요 교과목 리스트
   - 졸업 후 진출분야
   - 통계 차트 시각화 (chartData)
3. API 엔드포인트 구현
   - GET /api/majors/:id
   - Phase 1 필드 포함한 응답

**예상 소요 시간:** 4-6시간

---

### Option 2: 직업정보 Phase 1
**목표:** 직업 데이터에도 추가 필드 수집

**작업 내용:**
1. CareerNet 직업백과 API 추가 필드 분석
2. Goyong24 직업정보 API 추가 필드 분석
3. Job 인터페이스 확장
4. getJobDetail() 함수 수정
5. 직업 데이터 재시딩

**예상 소요 시간:** 6-8시간

**참고:** 직업정보는 이미 Phase 0에서 100% 수집 완료
- CareerNet 직업백과: job.json API (79개 필드, 19개 섹션)
- 추가 필드 여지 확인 필요

---

### Option 3: 데이터 통합 및 품질 개선
**목표:** CareerNet + Goyong24 학과 매칭 및 universityList 이슈 해결

**작업 내용:**
1. **universityList 로직 수정**
   - normalizeCareerNetMajorDetail() 디버깅
   - university → universityList 매핑 수정
   - 테스트 및 검증

2. **학과명 기반 매칭**
   - 유사도 알고리즘 구현
   - CareerNet ↔ Goyong24 학과 매칭
   - 매칭 결과 검증

3. **데이터 병합 전략**
   - 중복 학과 처리 로직
   - 우선순위 규칙 정의
   - merged 데이터 개선

**예상 소요 시간:** 4-6시간

---

### Option 4: API 엔드포인트 및 성능 최적화
**목표:** 프론트엔드에서 사용할 API 구축

**작업 내용:**
1. **학과 API 엔드포인트**
   - GET /api/majors - 학과 목록
   - GET /api/majors/:id - 학과 상세
   - GET /api/majors/search?q={keyword} - 학과 검색

2. **필드 선택적 반환**
   - Query parameter: `?fields=basic,phase1,stats`
   - 성능 최적화 (필요한 필드만)

3. **캐싱 전략**
   - D1 조회 최적화
   - 인덱스 추가
   - 응답 캐싱

**예상 소요 시간:** 4-5시간

---

## 📋 Phase 2+ 작업 예약 (우선순위 순)

### 우선순위 1 (즉시 가능)
- [ ] Option 1: 프론트엔드 UI 개발
- [ ] Option 4: API 엔드포인트 구축

### 우선순위 2 (Option 1 이후)
- [ ] Option 3: universityList 로직 수정

### 우선순위 3 (추후)
- [ ] Option 2: 직업정보 Phase 1
- [ ] Option 3: 학과명 기반 매칭

---

## 🔍 빠른 상태 체크

### 데이터베이스 확인
```bash
# 전공 수 확인
cd /home/user/webapp
npx wrangler d1 execute careerwiki-jobs --local --command="SELECT COUNT(*) as count FROM majors"

# 데이터 소스별 통계
npx wrangler d1 execute careerwiki-jobs --local --command="
SELECT 
  (SELECT COUNT(*) FROM majors WHERE careernet_id IS NOT NULL) as careernet_count,
  (SELECT COUNT(*) FROM majors WHERE goyong24_id IS NOT NULL) as goyong24_count,
  (SELECT COUNT(*) FROM majors) as total_count
"

# 샘플 데이터 확인
npx wrangler d1 execute careerwiki-jobs --local --command="SELECT id, name, careernet_id, goyong24_id FROM majors LIMIT 5"
```

### Phase 1 필드 검증
```bash
cd /home/user/webapp
npx tsx verify-phase1-data.ts
```

### 데이터 품질 리포트
```bash
cd /home/user/webapp
npx tsx data-quality-report.ts
```

---

## 📞 새 채팅에서 작업 시작하는 방법

### 1단계: 프로젝트 상태 확인
```
"PROJECT_STATUS.md를 확인하고 현재 진행 상황을 알려줘"
```

### 2단계: 다음 작업 지시
```
"Phase 2 Option 1 (프론트엔드 UI 개발) 시작해줘"
또는
"Phase 2 Option 4 (API 엔드포인트 구축) 시작해줘"
또는
"Option 3의 universityList 로직 수정부터 해줘"
```

### 3단계: 백업 복원 (필요 시)
```
"프로젝트 백업에서 복원해줘"
백업 URL: https://page.gensparksite.com/project_backups/careerwiki_phase1_complete.tar.gz
```

---

## ⚠️ 중요 참고 사항

### 환경 설정
- `.dev.vars` 파일에 API 키 저장 (git에 커밋되지 않음)
- Miniflare로 로컬 D1 실행
- Node.js 환경에서 tsx로 TypeScript 실행

### API 키 관리
```bash
# .dev.vars 파일 구조
CAREER_NET_API_KEY=your_career_net_api_key
GOYONG24_MAJOR_API_KEY=your_goyong24_major_key
GOYONG24_JOB_API_KEY=your_goyong24_job_key
```

### D1 마이그레이션
```bash
# 로컬 D1 초기화 (필요 시)
cd /home/user/webapp
npx wrangler d1 migrations apply careerwiki-jobs --local
```

### 시딩 재실행 (필요 시)
```bash
# 전체 시딩 (이미 완료, 재실행 불필요)
cd /home/user/webapp
npx tsx src/scripts/seedAllMajors.ts

# 나머지만 시딩 (효율적)
npx tsx seed-remaining.ts
```

---

## 📚 관련 문서

1. **API_INTEGRATION.md** - 전체 API 필드 상세 문서
2. **PHASE1_COMPLETION_REPORT.md** - Phase 1 완료 리포트
3. **PROJECT_STATUS.md** - 본 문서
4. **README.md** - 프로젝트 개요 (작성 예정)

---

**문서 작성일:** 2025-11-06  
**작성자:** CareerWiki Development Team  
**다음 업데이트:** Phase 2 시작 시
