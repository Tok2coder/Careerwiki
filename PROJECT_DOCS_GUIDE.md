# 📚 CareerWiki 문서 가이드

> 프로젝트의 모든 문서를 정리한 가이드  
> **최종 업데이트**: 2025-11-06

---

## 🎯 어떤 문서를 읽어야 할까?

### 1. 프로젝트가 처음이라면
1. **[README.md](./README.md)** - 프로젝트 개요, 기술 스택, 설치 방법
2. **[MASTER_PLAN.md](./MASTER_PLAN.md)** - 전체 계획 및 진행 상황 (Goal-Period-Target-Work-Step)

### 2. 개발에 참여하고 싶다면
1. **[MASTER_PLAN.md](./MASTER_PLAN.md)** - 현재 진행 상황 및 다음 할 일
2. **[DEVELOPMENT_ROADMAP.md](./docs/DEVELOPMENT_ROADMAP.md)** - Phase별 상세 로드맵
3. **[ARCHITECTURE.md](./docs/ARCHITECTURE.md)** - 시스템 아키텍처

### 3. 기술 상세를 알고 싶다면
1. **[ISR_CACHE_EXPLAINED.md](./docs/ISR_CACHE_EXPLAINED.md)** - ISR 캐시 시스템
2. **[API_INTEGRATION.md](./docs/API_INTEGRATION.md)** - API 필드 매핑
3. **[D1_DATABASE_STRUCTURE.md](./docs/D1_DATABASE_STRUCTURE.md)** - 데이터베이스 구조

---

## 📁 문서 디렉토리 구조

### 루트 디렉토리 (최상위 문서)

#### 필수 문서
- **README.md** - 프로젝트 메인 문서
- **MASTER_PLAN.md** - 전체 프로젝트 계획 (Goal-Period-Target-Work-Step) ⭐
- **PROJECT_DOCS_GUIDE.md** - 본 문서 (문서 가이드)

#### 리포트 문서
- **SEEDING_COMPLETE_REPORT.md** - 데이터 시딩 완료 리포트
- **JOB_SEEDING_COMPLETE_REPORT.md** - 직업 데이터 시딩 리포트
- **DATA_VERIFICATION_REPORT.md** - 데이터 검증 리포트
- **ALL_FIELDS_COLLECTION_VERIFICATION.md** - 전체 필드 수집 검증

#### 템플릿 관련
- **MAJOR_TEMPLATE_ANALYSIS_REPORT.md** - 전공 템플릿 분석
- **MAJOR_TEMPLATE_FIELD_ANALYSIS.md** - 전공 필드 분석
- **MAJOR_TEMPLATE_ENHANCEMENT_COMPLETE.md** - 전공 템플릿 개선 완료
- **JOB_TEMPLATE_ENHANCEMENT_COMPLETE.md** - 직업 템플릿 개선 완료
- **TEMPLATE_UPDATE_LOG.md** - 템플릿 업데이트 로그
- **TEMPLATE_TESTING_GUIDE.md** - 템플릿 테스트 가이드

#### 기술 문서
- **TECH_SPEC.md** - 기술 스펙 문서
- **TROUBLESHOOTING.md** - 문제 해결 가이드

#### 데이터베이스 관련
- **D1_DATABASE_STATUS.md** - D1 데이터베이스 상태
- **PORT_3000_GUIDE.md** - 포트 3000 설정 가이드

#### 분석 문서
- **FIELD_MERGE_RULES.md** - 필드 병합 규칙
- **FIELD_USAGE_ANALYSIS.md** - 필드 사용 분석
- **DATA_MERGE_STRATEGY.md** - 데이터 병합 전략
- **DATA_STORAGE_GUIDE.md** - 데이터 저장 가이드
- **DATA_COLLECTION_GUIDE.md** - 데이터 수집 가이드
- **JOB_DATA_MERGE_STRATEGY.md** - 직업 데이터 병합 전략

#### 상세 분석 리포트
- **CURRENT_MERGE_LOGIC_EXPLAINED.md** - 현재 병합 로직 설명
- **DETAIL_PAGE_DESIGN_ANALYSIS.md** - 상세 페이지 디자인 분석
- **UNIVERSITY_LIST_FIX_REPORT.md** - 대학 목록 수정 리포트

#### API 관련
- **API_ENDPOINTS_GUIDE.md** - API 엔드포인트 가이드
- **API_ISSUE_REPORT.md** - API 이슈 리포트
- **API_FIX_SUMMARY.md** - API 수정 요약
- **MAJOR_API_FIELDS_MAPPING.md** - 전공 API 필드 매핑

#### 디버그 관련
- **MAJOR_DEBUG_LINKS.md** - 전공 디버그 링크
- **MAJOR_MERGE_DEBUG_PAGE.md** - 전공 병합 디버그 페이지

#### 마이그레이션 관련
- **MIGRATION_TO_CURSOR.md** - Cursor 마이그레이션 가이드
- **CURSOR_QUICKSTART.md** - Cursor 빠른 시작
- **CURSOR_START_INSTRUCTIONS.md** - Cursor 시작 가이드

#### 기타
- **SAMPLE_PAGES.md** - 샘플 페이지 목록
- **HANDOFF_SUMMARY.md** - 인수인계 요약
- **fix-job-merge-logic-summary.md** - 직업 병합 로직 수정 요약

---

### docs/ 디렉토리 (상세 문서)

#### 프로젝트 관리
- **PROJECT_STATUS.md** - 프로젝트 현황
- **DEVELOPMENT_ROADMAP.md** - 개발 로드맵 (Phase 0-6)
- **PHASE1_COMPLETION_REPORT.md** - Phase 1 완료 리포트

#### 아키텍처
- **ARCHITECTURE.md** - 시스템 아키텍처
- **WIKI_ARCHITECTURE_STRATEGY.md** - 위키 아키텍처 전략
- **FINAL_ARCHITECTURE_DECISION.md** - 최종 아키텍처 결정

#### 기술 스택
- **TECH_STACK_VALIDATION.md** - 기술 스택 검증
- **ISR_CACHE_EXPLAINED.md** - ISR 캐시 설명
- **D1_DATABASE_STRUCTURE.md** - D1 데이터베이스 구조

#### API 통합
- **API_INTEGRATION.md** - API 통합 문서
- **고용24_API_extracted.txt** - 고용24 API 추출 데이터

#### SEO 및 최적화
- **SEO_AEO_GEO_ANALYSIS.md** - SEO/AEO/GEO 분석

#### 마이그레이션
- **migration-plan.md** - 정적 위키 마이그레이션 계획

#### 문제 해결
- **problems-and-solutions.md** - 문제 및 해결 방법
- **job-list-system-fix-2025-11-04.md** - 직업 목록 시스템 수정

#### 기타
- **telemetry-phase1-task3.md** - Phase 1 Task 3 텔레메트리
- **proposed-wiki-architecture.sql** - 제안된 위키 아키텍처 SQL

---

## 🗑️ 삭제된 문서 (2025-11-06 정리)

다음 문서들은 **MASTER_PLAN.md**에 통합되어 삭제되었습니다:

- ❌ CURRENT_STATUS_AND_NEXT_STEPS.md (중복)
- ❌ NEXT_STEPS.md (중복)
- ❌ NEXT_ACTION_PLAN.md (중복)
- ❌ CONTINUE_HERE.md (오래됨, 2025-10-30)
- ❌ PHASE1_COMPLETION_STATUS.md (오래됨, 직업 템플릿 작업)
- ❌ SEEDING_PREPARATION_CHECKLIST.md (시딩 완료)
- ❌ SEEDING_READY_REPORT.md (시딩 완료)
- ❌ SEEDING_GUIDE.md (시딩 완료)

---

## 📝 문서 작성 규칙

### 새 문서를 만들 때
1. **위치 결정**
   - 루트: 프로젝트 전체 관련
   - docs/: 기술 상세 문서

2. **파일명 규칙**
   - 대문자 사용: `PROJECT_STATUS.md`
   - 언더스코어 사용: `API_INTEGRATION.md`
   - 날짜 포함 시: `job-list-system-fix-2025-11-04.md`

3. **필수 포함 내용**
   - 작성일
   - 최종 업데이트
   - 목적 및 개요
   - 관련 문서 링크

### 문서 업데이트 시
1. **최종 업데이트** 날짜 변경
2. **변경 이력** 추가 (중요한 변경 시)
3. **관련 문서** 링크 업데이트

---

## 🔍 빠른 검색

### 상황별 문서 찾기

**"지금 뭘 해야 하지?"**
→ [MASTER_PLAN.md](./MASTER_PLAN.md) 의 "지금 당장 할 일" 섹션

**"Phase 2가 뭐였지?"**
→ [MASTER_PLAN.md](./MASTER_PLAN.md) 또는 [DEVELOPMENT_ROADMAP.md](./docs/DEVELOPMENT_ROADMAP.md)

**"ISR이 뭐지?"**
→ [ISR_CACHE_EXPLAINED.md](./docs/ISR_CACHE_EXPLAINED.md)

**"API 필드가 뭐가 있지?"**
→ [API_INTEGRATION.md](./docs/API_INTEGRATION.md)

**"에러가 났는데?"**
→ [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) 또는 [problems-and-solutions.md](./docs/problems-and-solutions.md)

**"데이터베이스 구조가 궁금해"**
→ [D1_DATABASE_STRUCTURE.md](./docs/D1_DATABASE_STRUCTURE.md)

**"템플릿을 수정하고 싶어"**
→ [TEMPLATE_UPDATE_LOG.md](./TEMPLATE_UPDATE_LOG.md)

---

## 📊 문서 통계

### 전체 문서 수
- 루트 디렉토리: 약 50개
- docs/ 디렉토리: 약 15개
- **총: 약 65개**

### 필수 문서 (반드시 읽어야 함)
1. README.md
2. MASTER_PLAN.md
3. DEVELOPMENT_ROADMAP.md

### 참고 문서 (필요시 참고)
- 나머지 약 60개 문서

---

**마지막 업데이트**: 2025-11-06  
**작성자**: CareerWiki Development Team

