# CareerWiki 마스터 플랜

> **Goal-Period-Target-Work-Step** 구조로 정리한 전체 프로젝트 진행 계획  
> **최종 업데이트**: 2025-01-XX  
> **현재 위치**: Phase 3 완료 ✅ → **Phase 4 시작** (편집 시스템 구축)

---

## 🎯 GOAL (최종 목표)

**AI 기반 협업형 진로 위키 플랫폼 구축**

- 한국의 모든 직업(980개) + 전공(1,427개) 정보 통합
- Wikipedia 스타일 ISR 아키텍처 (0.05초 응답)
- Google OAuth 로그인 + 사용자 기여 시스템
- AI 콘텐츠 보강 + API 자동 동기화

---

## 📊 전체 진행 상황

```
Phase 0: ████████████ 100% (완료)
Phase 1: ████████████ 100% (완료)
Phase 2: ████████████ 100% (완료)
Phase 3: ████████████ 100% (완료) ✅
Phase 4: ░░░░░░░░░░░░   0% (대기)
Phase 4.5: ░░░░░░░░░░░░   0% (대기) - 배포 준비
Phase 5: ░░░░░░░░░░░░   0% (대기)
Phase 6: ░░░░░░░░░░░░   0% (대기)
Phase 7: ░░░░░░░░░░░░   0% (대기)
────────────────────────────────
전체:    ██████████░░  50% 완료
```

---

## 📅 PERIOD (기간별 계획)

### ✅ Week 1-2: 데이터 + 인프라 구축 (완료)
- Phase 0: 아키텍처 설계 ✅
- Phase 1: 데이터 수집 (2,407개) ✅
- Phase 2: ISR 캐시 시스템 + 템플릿 ✅

### 🔥 Week 3: 로그인 시스템 (진행 중)
- **Phase 3: Google OAuth + JWT 인증** (2025-11-17 ~ 11-21, 5일)
  - Day 1: OAuth 기본 구현
  - Day 2: JWT 시스템
  - Day 3: 권한 관리
  - Day 4: UI/UX + 디자인 확인
  - Day 5: 로컬 테스트 및 문서화

### 📅 Week 4: 편집 시스템 (예정)
- **Phase 4: 편집 시스템 구축** (2025-01-XX ~ XX, 4일)
  - Day 1: 데이터베이스 및 기본 서비스
  - Day 2: API 엔드포인트 구현
  - Day 3: UI 구현
  - Day 4: 통합 및 테스트
- Phase 4.5: 배포 준비 및 스테이징 테스트 (1-2일)

### 📅 Week 5: 배포 및 AI (예정)
- Phase 5: 프로덕션 배포 (careerwiki.org)
- Phase 6: AI 데이터 보완
- Phase 7: AI 분석기 고도화

---

## 🎯 TARGET (Phase별 목표)

### ✅ Phase 0: 아키텍처 기반 구축 (완료)
**Goal**: 모든 후속 작업의 기반 설계  
**Period**: 2025-10-25 ~ 2025-10-28 (3일)  
**Target**: D1 스키마 설계 + 핵심 문서 작성  
**Work**: 
- ✅ D1 스키마 설계 완료
- ✅ README, ARCHITECTURE, ROADMAP 문서 작성
- ✅ 기술 스택 검증 완료

---

### ✅ Phase 1: 데이터 완전성 확보 (완료)
**Goal**: 모든 API 필드를 빠짐없이 수집  
**Period**: 2025-11-01 ~ 2025-11-06 (6일)  
**Target**: 전공 1,427개 + 직업 980개 데이터 수집  
**Work**: 
- ✅ CareerNet 학과정보 API 44개 필드 추가 수집
- ✅ 전공 데이터 시딩 완료 (1,427개)
  - CareerNet: 504개 (35.3%)
  - Goyong24: 923개 (64.7%)
  - Phase 1 필드 수집률: 97.0%
- ✅ 직업 데이터 시딩 완료 (980개)
  - CareerNet: 443개 (45.2%)
  - Goyong24: 537개 (54.8%)
  - 성공률: 98.9%
- ✅ 데이터 검증 완료 (품질 점수: 100/100)

**Step**:
1. ✅ Major 인터페이스 확장 (44개 필드)
2. ✅ getMajorDetail() 함수 수정
3. ✅ 전체 시딩 실행 (17분 53초)
4. ✅ 데이터 품질 검증

---

### ✅ Phase 2.1: ISR 캐시 시스템 구축 (완료)
**Goal**: Wikipedia 스타일 ISR 아키텍처 구현  
**Period**: 2025-11-06 (1일)  
**Target**: 캐시 히트 시 50ms 응답 달성  
**Work**: 
- ✅ `wiki_pages` 테이블 생성 (D1)
- ✅ `getOrGeneratePage()` 유틸리티 함수 구현
- ✅ 템플릿 버전 관리 시스템 구축
- ✅ `/major/:slug` ISR 적용 완료

**Step**:
1. ✅ D1 마이그레이션 실행 (0005_wiki_pages_cache.sql)
2. ✅ src/utils/page-cache.ts 구현
3. ✅ src/constants/template-versions.ts 구현
4. ✅ 성능 테스트 (500ms → 50ms, 10배 개선)

---

### ✅ Phase 2.2: 직업 상세페이지 ISR 적용 (완료)
**Goal**: 직업 페이지도 ISR 캐싱 적용  
**Period**: 2025-11-06 (0.5일)  
**Target**: `/job/:slug` ISR 적용 완료  
**Work**: 
- ✅ `/job/:slug` 라우트 ISR 방식 변경
- ✅ 성능 개선 확인 (500ms → 50ms)
- ✅ API 엔드포인트 구축 완료
  - `/api/majors/search?q={keyword}`
  - `/api/jobs/search?q={keyword}`

**Step**:
1. ✅ src/index.tsx `/job/:slug` 라우트 리팩토링
2. ✅ getOrGeneratePage() 함수 사용하도록 변경
3. ✅ 성능 벤치마크 완료

---

### ✅ Phase 2.3: 템플릿 개발 및 Phase 1 필드 적용 (완료)
**Goal**: 수집한 데이터를 사용자에게 보여주기  
**Period**: 2025-11-06 ~ 2025-11-16 (완료)  
**Target**: Phase 1 필드를 활용한 풍부한 UI 제공  
**Work**: 
- ✅ 전공 상세 페이지 UI 개선 완료
  - ✅ 관련 고교 교과목 섹션 (`relateSubject`)
  - ✅ 진로 탐색 활동 가이드 (`careerAct`)
  - ✅ 대학 주요 교과목 리스트 (`mainSubject`)
  - ✅ 졸업 후 진출분야 (`enterField`)
  - ✅ 통계 차트 시각화 (`chartData`)
- ✅ 직업 상세 페이지 UI 개선 완료
  - ✅ 성격/흥미/가치관 분석 섹션
  - ✅ 활동 중요도/수준 분석 섹션
  - ✅ 지식/능력 상세 비교 섹션
  - ✅ 디버깅 코드 제거 완료
- ✅ 통계 차트 라이브러리 선택 완료

**Step**:
1. ✅ 통계 차트 라이브러리 선택 및 설정
2. ✅ unifiedMajorDetail.ts 템플릿 수정
3. ✅ unifiedJobDetail.ts 디버깅 코드 제거
4. ✅ 반응형 디자인 및 접근성 개선

---

### ✅ Phase 2.4: 프로토타입 검증 (완료)
**Goal**: 10개 페이지로 아키텍처 검증  
**Period**: 2025-11-16 (완료)  
**Target**: SEO, 성능, 데이터 품질 검증  
**Work**: 
- ✅ 프로토타입 페이지 10개 생성
  - 전공 5개: 컴퓨터공학과, 간호학과, 경영학과, 건축학과, 의예과
  - 직업 5개: 소프트웨어개발자, 간호사, 변호사, 의사, 교사
- ✅ 성능 비교 (SSR vs ISR)
- ✅ SEO 메타태그 검증
- ✅ Core Web Vitals 확인

**Step**:
1. ✅ 10개 페이지 생성 스크립트 실행
2. ✅ 성능 벤치마크 (Lighthouse)
3. ✅ SEO 검증 (Google Search Console)
4. ✅ 캐시 히트율 측정

**결과**:
- ✅ 평균 응답 시간: 50ms (ISR 캐시 히트 시)
- ✅ Lighthouse 점수: 95+ (성능, 접근성, SEO)
- ✅ 캐시 히트율: 98%+

---

### ✅ Phase 3: 로그인 시스템 구축 (완료)
**Goal**: Google OAuth + JWT 기반 사용자 인증 시스템  
**Period**: 2025-11-17 ~ 2025-11-21 (5일)  
**Target**: 1-click 로그인, 역할 기반 권한 관리, 성능 유지 (50ms)  

**📚 문서**:
- **[PHASE3_PLAN.md](./PHASE3_PLAN.md)** - 개발자용 상세 구현 계획
- **[PHASE3_EXPLANATION_SIMPLE.md](./PHASE3_EXPLANATION_SIMPLE.md)** - 비개발자용 쉬운 설명

**🎯 핵심 목표 (3줄 요약)**:
1. **Google 로그인 버튼 추가** - "Google로 1초 만에 시작하기"
2. **로그인한 사용자만 편집/댓글** - 반달리즘 방지
3. **빠른 속도 유지** - 0.05초 → 0.052초 (거의 차이 없음)

**핵심 결정사항**:
- ✅ **인증 방식**: JWT (Stateless) - 성능 최적화 (52ms 응답)
- ✅ **익명 편집**: Phase 4에서 비밀번호 기반 편집 지원
- ✅ **소셜 로그인**: Google OAuth 단독 (Phase 3) → Naver/Kakao 추가 예정 (Phase 5 이후)
- ✅ **권한 체계**: anonymous / user / expert / admin (4단계)

**권한 매트릭스** (Phase 4 업데이트):
| 기능 | anonymous | user | expert | admin |
|------|-----------|------|--------|-------|
| 직업/전공 편집 | ✅ (비밀번호) | ✅ | ✅ | ✅ |
| API 데이터 편집 | ✅ (비밀번호) | ✅ | ✅ | ✅ |
| HowTo 편집/생성 | ✅ (비밀번호) | ✅ | ✅ | ✅ |
| HowTo 수정/삭제 | ✅ (비밀번호) | 자신 것만 | 자신 것만 | 모두 가능 |
| 댓글 작성 | ✅ | ✅ | ✅ | ✅ |
| 댓글 수정/삭제 | 자신 것만 (비밀번호) | 자신 것만 | 자신 것만 | 모두 가능 |
| 편집 승인 | ❌ | ❌ | ✅ (전문 분야) | ✅ (모든 분야) |

**⚠️ Phase 4 변경사항**:
- 익명 사용자도 모든 편집 가능 (비밀번호 기반)
- API 데이터도 모든 사용자가 편집 가능 (원본 보존)

**왜 이 방식인가?**:
```
성능 비교:
- Session+KV: 150ms (❌ 3배 느려짐)
- JWT: 52ms (✅ 거의 차이 없음)

비용 비교:
- Session+KV: $10/월
- JWT+KV: $1/월 (✅ 10배 저렴)

→ JWT 선택: 속도 + 비용 + 확장성 모두 최고
```

---

#### ✅ Day 1: Google OAuth 기본 구현 (완료)
**목표**: Google로 로그인, D1에 사용자 저장

**Work**:
- [x] Google Cloud Console OAuth 클라이언트 설정
- [x] Cloudflare 환경 변수 설정 (GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, JWT_SECRET)
- [x] D1 users 테이블 마이그레이션 (`migrations/0006_users.sql`)
- [x] `/auth/google` 엔드포인트 구현 (OAuth redirect)
- [x] `/auth/google/callback` 엔드포인트 구현 (토큰 교환, 사용자 정보 저장)
- [x] 로컬 환경 테스트

**Step**:
1. [x] Google Cloud Console 설정 (30분)
   - 프로젝트 생성, OAuth 동의 화면
   - Client ID/Secret 발급
   - Redirect URI 등록: `http://localhost:3000/auth/google/callback`
2. [x] `.dev.vars` 파일 생성 및 환경 변수 설정 (15분)
3. [x] D1 마이그레이션 실행: `npm run db:migrate:local` (30분)
4. [x] OAuth 엔드포인트 구현 (3시간)
5. [x] 로컬 테스트 (1시간)

**완료 기준**:
- ✅ Google 로그인 성공
- ✅ 사용자 정보 콘솔 출력
- ✅ D1 users 테이블에 레코드 생성 확인

**실제 소요 시간**: 완료

🎨 **UI 확인 포인트**:
- Google 로그인 버튼이 정상 작동하는가?
- OAuth 동의 화면이 제대로 표시되는가?
- 로그인 후 리다이렉트가 자연스러운가?

---

#### ✅ Day 2: JWT 시스템 구축 (완료)
**목표**: JWT 발급, 인증 상태 유지, Token Refresh

**Work**:
- [x] JWT 유틸리티 함수 작성 (`src/utils/jwt.ts`)
  - `generateAccessToken()` - 1시간 TTL
  - `generateRefreshToken()` - 7일 TTL, KV 저장
  - `verifyAccessToken()`
- [x] OAuth 콜백에서 JWT 발급 및 Cookie 설정
- [x] 인증 Middleware 작성 (`src/middleware/auth.ts`)
  - `authMiddleware` - 모든 요청에 적용
  - `requireAuth` - 로그인 필수 라우트용
- [x] 로그아웃 엔드포인트 (`/auth/logout`)
- [x] Token Refresh 엔드포인트 (`/auth/refresh`)
- [x] 성능 테스트 (목표: < 60ms)

**Step**:
1. [x] `jose` 라이브러리 설치 및 JWT 함수 구현 (2시간)
2. [x] KV Namespace 생성 및 바인딩 (30분)
3. [x] OAuth 콜백 수정 (JWT 발급) (1시간)
4. [x] Middleware 구현 (2시간)
5. [x] 로그아웃/Refresh 구현 (1시간)
6. [x] 성능 테스트 (1시간)

**완료 기준**:
- ✅ 로그인 후 페이지 새로고침해도 로그인 유지
- ✅ 로그아웃 시 즉시 인증 해제
- ✅ Token refresh 작동
- ✅ 평균 응답 시간 < 60ms

**실제 소요 시간**: 완료

🎨 **UI 확인 포인트**:
- 로그인 상태가 유지되는가?
- 새로고침 후에도 로그인이 유지되는가?
- 로그아웃이 즉시 반영되는가?

---

#### ✅ Day 3: 권한 시스템 통합 (완료)
**목표**: 기존 코드와 통합, 역할 기반 접근 제어

**Work**:
- [x] `getOptionalUser()` 함수를 실제 JWT 기반으로 대체
- [x] `requireRole()` Middleware 구현 (user/expert/admin)
- [x] 댓글 시스템에 로그인 사용자 연결 (익명 허용)
- [x] Admin 페이지 접근 제어 적용
- [x] 편집 권한 체크 로직 추가
- [x] IP 로깅 추가 (반달리즘 추적용)

**Step**:
1. [x] `getOptionalUser()` 수정 (1시간)
2. [x] `requireRole()` Middleware (1시간)
3. [x] 댓글 API 통합 (2시간)
4. [x] Admin 라우트 보호 (1시간)
5. [x] 편집 권한 로직 (1시간)

**완료 기준**:
- ✅ 댓글은 로그인 여부와 관계없이 모두 작성 가능 (익명 허용)
- ✅ Admin 페이지는 admin만 접근 가능
- ✅ 편집 시 사용자 정보 자동 기록

**실제 소요 시간**: 완료

---

#### ✅ Day 4: UI/UX 개선 + 디자인 확인 (완료)
**목표**: 사용자 친화적인 로그인 UI, 정우님 디자인 확인

**Work**:
- [x] 헤더에 사용자 메뉴 추가
  - 비로그인: IP 주소 표시 + 로그인 버튼
  - 로그인: 사용자 아이콘 + 권한 표시 + 드롭다운
- [x] 프로필 드롭다운 구현
  - 권한 표시 (관리자/사용자)
  - 설정 링크
  - 로그아웃
- [x] 사용자 설정 페이지 구현 (`/user/settings`)
- [x] Username 변경 기능 구현 (`PATCH /api/user/username`)
- [x] 모든 페이지에서 사용자 메뉴 작동 확인

**Step**:
1. [x] 헤더 UI 구현 (2시간)
2. [x] 프로필 드롭다운 (2시간)
3. [x] 사용자 설정 페이지 구현 (1시간)
4. [x] Username 변경 기능 구현 (1시간)
5. 🎨 **정우님 UI/UX 확인 및 피드백** (완료)
   - 사용자 메뉴 디자인 확인
   - 프로필 드롭다운 위치/스타일 확인
   - Username 변경 기능 확인
   - 전체 흐름 확인
6. [x] 피드백 반영 및 수정 (완료)

**완료 기준**:
- ✅ 고등학생도 쉽게 로그인 가능
- ✅ 1-click 로그인 달성
- ✅ 로그인 상태 명확히 표시
- ✅ 에러 메시지 사용자 친화적
- ✅ **정우님 디자인 승인** (완료)

**실제 소요 시간**: 완료

🎨 **UI 확인 및 피드백 세션** (중요!):
```markdown
## 확인 사항
1. 로그인 버튼 위치: 헤더 우측 상단? 중앙?
2. 버튼 스타일: 파란색? 흰색? 테두리?
3. 프로필 드롭다운: 위치와 애니메이션
4. 로그인 필요 모달: 팝업 vs 페이지 리다이렉트
5. 모바일 반응형 디자인

## 수정 방향
- [ ] 버튼 크기 조정
- [ ] 색상 변경
- [ ] 간격/여백 조정
- [ ] 폰트 크기
- [ ] 기타 개선사항
```

---

#### ✅ Day 5: 로컬 테스트 및 문서화 (완료)
**목표**: 로컬 환경에서 모든 기능 검증 완료

**Work**:
- [x] 로컬 환경 종합 테스트
- [x] 보안 체크리스트 확인 (코드 레벨)
- [x] 성능 테스트 (로컬)
- [x] 에러 시나리오 테스트
- [x] 문서화

**Step**:
1. [x] 로컬 종합 테스트 (2시간)
   - Google 로그인
   - 로그아웃
   - Token refresh
   - 권한 확인
   - 사용자 설정 페이지
   - Username 변경
2. [x] 보안 체크리스트 확인 (1시간)
   - `.dev.vars`가 `.gitignore`에 포함되어 있는지 ✅
   - HttpOnly Cookie 설정 확인 ✅
   - JWT Secret 충분히 복잡한지 ✅ (43자)
3. [x] 성능 테스트 (1시간)
   - 로그인 전/후 페이지 로딩 시간 측정
   - 목표: < 60ms 달성 확인 ✅
4. [x] 에러 시나리오 테스트 (1시간)
   - Google OAuth 거부 시
   - Token 만료 시
   - 잘못된 Token으로 요청 시
   - 권한 없는 페이지 접근 시
5. [x] 문서화 (1시간)
   - Phase 3 완료 체크 ✅
   - PHASE3_COMPLETION_REPORT.md 작성 ✅
   - 다음 개발자를 위한 주석 추가 ✅

**완료 기준**:
- ✅ 로컬 환경에서 모든 기능 정상 작동
- ✅ 보안 체크리스트 통과
- ✅ 성능 목표 달성 (< 60ms)
- ✅ 에러 시나리오 모두 처리
- ✅ 문서화 완료

**실제 소요 시간**: 완료

🎨 **로컬 확인 포인트**:
- 로그인/로그아웃이 정상 작동하는가?
- 사용자 메뉴가 모든 페이지에서 작동하는가?
- Username 변경이 정상 작동하는가?
- 모바일 반응형이 잘 되는가?

---

**Phase 3 실제 소요 시간**: 5일 (완료)

**주요 위험 요소 및 대응**:
- ⚠️ JWT 토큰 탈취 → HttpOnly + Secure + 짧은 TTL + Refresh Token
- ⚠️ OAuth 설정 오류 → 상세 에러 로그 + 단계별 검증
- ⚠️ 성능 저하 → JWT 경량화, D1 쿼리 최적화
- ⚠️ UI/UX 불만족 → Day 4 피드백 세션에서 충분히 조정

---

### 📅 Phase 4: 편집 시스템 구축 (예정)
**Goal**: 사용자가 페이지를 편집하고 기여 (익명/로그인 모두 가능)  
**Period**: 2025-01-XX ~ 2025-01-XX (4일)  
**Target**: Wikipedia 스타일 편집 시스템 + 익명 편집 + API 데이터 편집  
**기반 문서**: 
- `PHASE4_EDIT_SYSTEM_RESEARCH_PROMPT.md` (리서치 프롬프트)
- `PHASE4_IMPLEMENTATION_PLAN.md` (상세 구현 계획)

**⚠️ 중요 변경사항**:
- ✅ 익명 사용자도 모든 편집 가능 (비밀번호 기반)
- ✅ API 데이터(커리어넷/고용24)도 모든 사용자가 편집 가능
- ✅ 버전 히스토리 시스템: 모든 편집을 revision으로 저장 (되돌리기 가능)

**Work**: 
- [ ] 데이터베이스 스키마 확장 (Revision 테이블로 버전 히스토리 구축)
- [ ] 편집 API 엔드포인트 구현 (익명 편집 지원)
- [ ] 편집 UI 구현 (Notion 스타일 블록 편집)
- [ ] 익명 편집 시스템 (비밀번호 기반)
- [ ] 충돌 해결 시스템 (GitHub 스타일 Diff)
- [ ] 버전 이력 관리 및 되돌리기
- [ ] 출처 검증 시스템
- [ ] 캐시 무효화 전략

**Step** (상세 계획은 `PHASE4_IMPLEMENTATION_PLAN.md` 참조):

#### Day 1: 데이터베이스 및 기본 서비스 (8시간)
- [ ] 마이그레이션 파일 생성 (`0010_edit_system.sql`)
- [ ] Revision 테이블 생성/확장 (버전 히스토리 시스템)
- [ ] Revision 테이블 확장
- [ ] 충돌/승인/출처 테이블 생성
- [ ] 데이터 구조 타입 정의 (`src/types/editSystem.ts`)
- [ ] 편집 서비스 함수 구현 (`src/services/editService.ts`)
- [ ] 익명 편집 유틸리티 구현 (`src/utils/anonymousEdit.ts`)

#### Day 2: API 엔드포인트 구현 (8시간)
- [ ] `POST /api/job/:id/edit` - 직업 편집 (익명 지원)
- [ ] `POST /api/major/:id/edit` - 전공 편집
- [ ] `POST /api/howto/:slug/edit` - HowTo 편집
- [ ] `GET /api/job/:id/revisions` - 편집 이력 조회
- [ ] `POST /api/revision/:id/restore` - 되돌리기
- [ ] `GET/POST /api/conflict/:id/resolve` - 충돌 해결
- [ ] 권한 검증 및 보안 로직

#### Day 3: UI 구현 (8시간)
- [ ] 편집 버튼 컴포넌트 (섹션별)
- [ ] 편집 모달 (Notion 스타일 인라인 편집)
- [ ] 익명 편집 UI (비밀번호 입력)
- [ ] 충돌 해결 UI (GitHub Diff 스타일)
- [ ] 편집 이력 UI
- [ ] 모바일 반응형 구현

#### Day 4: 통합 및 테스트 (8시간)
- [ ] 데이터 병합 로직 통합
- [ ] 템플릿 렌더링 수정
- [ ] 종합 테스트 (로그인/익명/충돌/성능)
- [ ] 버그 수정 및 최적화
- [ ] 문서화

**예상 소요 시간**: 4일 (32시간)

**완료 기준**:
- ✅ 익명 사용자가 비밀번호로 편집 가능
- ✅ 로그인 사용자가 편집 가능
- ✅ API 데이터 편집 가능 (버전 히스토리로 모든 버전 보존)
- ✅ 충돌 해결 정상 작동
- ✅ 편집 이력 및 되돌리기 정상 작동
- ✅ 출처 검증 정상 작동
- ✅ 성능 목표 달성 (< 100ms)

**주요 위험 요소**:
- ⚠️ Revision 생성 실패 → 트랜잭션으로 원자성 보장 (데이터 업데이트 + revision 생성)
- ⚠️ 익명 편집 악용 → 일일 제한 + IP 차단 + 스팸 필터
- ⚠️ 충돌 해결 복잡도 → 낙관적 락 + 자동 병합 시도
- ⚠️ 성능 저하 → 병합 결과 캐싱 + 변경 시에만 재계산

---

### 📅 Phase 4.5: 배포 준비 및 스테이징 테스트 (예정)
**Goal**: 편집 시스템 포함 전체 기능을 스테이징 환경에 배포 및 테스트  
**Period**: 2025-11-27 ~ 2025-11-28 (1-2일)  
**Target**: 스테이징 환경에서 모든 기능 검증 완료  

**Work**:
- [ ] Cloudflare Pages 환경 변수 설정 (프로덕션)
- [ ] Google OAuth Redirect URI 업데이트
- [ ] 프로덕션 D1 마이그레이션
- [ ] 보안 체크리스트 확인
- [ ] 스테이징 환경 테스트
- [ ] 성능 테스트
- [ ] 에러 시나리오 테스트
- [ ] 최종 배포 (스테이징)
- [ ] 모니터링 설정
- [ ] 문서화

**Step**:
1. [ ] 환경 변수 설정 (30분)
   - Cloudflare Dashboard → Pages → Settings → Environment variables
   - Production 환경에 추가: GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, JWT_SECRET 등
2. [ ] Google Console 업데이트 (15분)
   - OAuth 클라이언트 편집
   - Redirect URI 추가: `https://careerwiki-phase1.pages.dev/auth/google/callback`
3. [ ] 프로덕션 마이그레이션 (15분)
   - `npm run db:migrate:prod`
   - 모든 마이그레이션 파일 실행 확인
4. [ ] 보안 체크리스트 (1시간)
   - `.dev.vars`가 `.gitignore`에 포함되어 있는지
   - GitHub에 secrets 노출되지 않았는지
   - HttpOnly Cookie 설정 확인
   - Secure 플래그 설정 확인 (HTTPS)
   - SameSite=Lax 설정 확인
   - JWT Secret 충분히 복잡한지 (32+ characters)
5. [ ] 스테이징 테스트 (2시간)
   - Google 로그인 작동 확인
   - 로그아웃 작동 확인
   - Token refresh 작동 확인
   - 편집 권한 확인
   - Admin 페이지 접근 제어 확인
   - 편집 시스템 작동 확인
   - 모바일 브라우저 테스트
   - 여러 브라우저 테스트 (Chrome, Firefox, Safari)
6. [ ] 성능 테스트 (1시간)
   - Chrome DevTools → Network 탭
   - 로그인 전/후 페이지 로딩 시간 측정
   - 목표: < 60ms 달성 확인
7. [ ] 에러 테스트 (1시간)
   - Google OAuth 거부 시
   - Token 만료 시
   - 잘못된 Token으로 요청 시
   - 권한 없는 페이지 접근 시
8. [ ] 최종 배포 (30분)
   - `git add .`
   - `git commit -m "feat: Phase 3-4 완료 - 로그인 및 편집 시스템"`
   - `git push origin main`
   - Cloudflare Pages 자동 배포 확인
9. [ ] 모니터링 (1시간)
   - Cloudflare Analytics 확인
   - 로그인 성공/실패 로그 확인
   - 에러 알림 설정 (선택 사항)
10. [ ] 문서 작성 (1시간)
    - MASTER_PLAN.md 업데이트 (Phase 3-4 완료 체크)
    - PHASE4_COMPLETION_REPORT.md 작성

**완료 기준**:
- ✅ 스테이징 환경에서 로그인 작동
- ✅ 스테이징 환경에서 편집 시스템 작동
- ✅ 모든 보안 체크리스트 통과
- ✅ 성능 목표 달성 (< 60ms)
- ✅ 에러 시나리오 모두 처리
- ✅ 문서화 완료

**예상 소요 시간**: 8시간

🎨 **스테이징 확인 포인트**:
- `https://careerwiki-phase1.pages.dev`에서 로그인이 정상 작동하는가?
- 편집 시스템이 정상 작동하는가?
- UI가 모든 브라우저에서 일관되게 표시되는가?
- 모바일에서도 사용하기 편한가?

---

### 📅 Phase 5: 프로덕션 배포 및 도메인 연동 (예정)
**Goal**: careerwiki.org 도메인 연결 및 서비스 오픈  
**Period**: 2025-11-19 ~ 2025-11-20 (1일)  
**Target**: 실제 서비스 런칭  
**Work**: 
- [ ] careerwiki.org 도메인 Cloudflare Pages 연결
- [ ] DNS 설정 및 SSL 인증서 발급
- [ ] 프로덕션 환경 변수 설정
- [ ] 모니터링 및 알림 시스템 구축
- [ ] Google Search Console 등록
- [ ] Sitemap 제출

**Step**:
1. [ ] Cloudflare Pages Custom Domain 추가
2. [ ] DNS CNAME 레코드 설정
3. [ ] SSL/TLS 설정 (Full strict)
4. [ ] 환경 변수 프로덕션 배포
5. [ ] 성능 모니터링 설정 (Cloudflare Analytics)
6. [ ] SEO 도구 연동 (Google Search Console)

**예상 소요 시간**: 4-6시간 (반나절)

**결과물**:
- ✅ https://careerwiki.org 접속 가능
- ✅ HTTPS 보안 연결
- ✅ 모니터링 대시보드 운영

---

### 📅 Phase 6: AI 데이터 보완 (예정)
**Goal**: 기존 데이터의 부족한 부분을 AI로 채우기  
**Period**: 2025-11-21 ~ 2025-11-25 (3-5일)  
**Target**: 데이터 완전성 100% 달성  
**Work**: 
- [ ] 부족한 필드 자동 감지 시스템
- [ ] AI 콘텐츠 자동 생성
- [ ] 데이터 품질 검증 및 필터링
- [ ] 관리자 검토 및 승인 시스템

**Step**:
1. [ ] Claude API 연동 (또는 GPT-4)
2. [ ] 부족한 필드 스캔 스크립트 작성
   ```typescript
   // 예: 전공 설명이 100자 미만이면 AI 생성
   if (!major.property || major.property.length < 100) {
     major.property = await AI.generateDescription(major.name)
   }
   ```
3. [ ] AI 프롬프트 템플릿 작성
   - 전공 특성 생성
   - 직업 전망 생성
   - 관련 직업/전공 추천
4. [ ] 배치 처리 시스템 구현 (100개씩)
5. [ ] 생성된 콘텐츠 품질 검증
6. [ ] ai_generated_content 테이블에 저장

**예상 소요 시간**: 3-5일

**예상 결과**:
- ✅ 전공 1,427개 데이터 완전성 95% → 100%
- ✅ 직업 980개 데이터 완전성 98% → 100%
- ✅ 빈 필드 자동 채우기 완료

---

### 📅 Phase 7: AI 분석기 고도화 (예정)
**Goal**: 사용자 맞춤형 AI 진로 분석 제공  
**Period**: 2025-11-26 ~ 2025-11-30 (3-5일)  
**Target**: AI 기반 커리어 컨설팅 기능  
**Work**: 
- [ ] 사용자 프로필 분석 시스템
- [ ] AI 진로 추천 엔진
- [ ] 커리어 패스 시각화
- [ ] 적합도 분석 리포트

**Step**:
1. [ ] 사용자 입력 폼 설계
   - 관심 분야
   - 적성 테스트 결과
   - 선호 근무 조건
2. [ ] AI 분석 프롬프트 작성
   ```typescript
   const analysis = await AI.analyzeCareerFit({
     interests: user.interests,
     aptitude: user.aptitudeScores,
     preferences: user.workPreferences
   })
   ```
3. [ ] 추천 알고리즘 구현
4. [ ] 분석 리포트 템플릿 작성
5. [ ] 시각화 차트 구현
6. [ ] 결과 저장 및 공유 기능

**예상 소요 시간**: 3-5일

**예상 결과**:
- ✅ 사용자별 맞춤 진로 추천
- ✅ 직업/전공 적합도 분석
- ✅ 커리어 패스 로드맵 제공

---

## 📊 전체 진행률

```
Phase 0:  ████████████████████ 100% ✅ (완료)
Phase 1:  ████████████████████ 100% ✅ (완료)
Phase 2.1: ████████████████████ 100% ✅ (완료)
Phase 2.2: ████████████████████ 100% ✅ (완료)
Phase 2.3: ████████████████████ 100% ✅ (완료)
Phase 2.4: ████████████████████ 100% ✅ (완료)
Phase 3:  ████████████████████ 100% ✅ (완료)
Phase 4:  ░░░░░░░░░░░░░░░░░░░░   0% 📅 (예정)
Phase 4.5: ░░░░░░░░░░░░░░░░░░░░   0% 📅 (예정 - 배포 준비)
Phase 5:  ░░░░░░░░░░░░░░░░░░░░   0% 📅 (예정 - 프로덕션 배포)
Phase 6:  ░░░░░░░░░░░░░░░░░░░░   0% 📅 (예정 - AI 보완)
Phase 7:  ░░░░░░░░░░░░░░░░░░░░   0% 📅 (예정 - AI 분석)
─────────────────────────────────────────
전체:     ██████████████████░░  90% (Phase 3 완료)
```

---

## 🎯 지금 당장 할 일 (Phase 3 준비)

### 🎉 Phase 2 완료!
**축하합니다!** Phase 2 (ISR 캐시 시스템 + 템플릿 개발)가 완료되었습니다.

**완료된 작업**:
- ✅ ISR 캐시 시스템 구축 완료
- ✅ 전공/직업 상세 페이지 템플릿 개발 완료
- ✅ Phase 1 필드 모두 UI에 적용
- ✅ 프로토타입 10개 페이지 검증 완료

---

### 🎉 Phase 3 완료!

**완료된 작업**:
- ✅ Google OAuth 로그인 시스템 구축
- ✅ JWT 기반 인증 상태 유지
- ✅ 역할 기반 권한 관리 (anonymous/user/expert/admin)
- ✅ 사용자 메뉴 UI 구현
- ✅ 사용자 설정 페이지 구현
- ✅ Username 자동 생성 및 변경 기능

**다음 단계: Phase 4 (편집 시스템) 시작!**

**계획된 순서**:
```
✅ Phase 2 완료 (ISR + 템플릿)
✅ Phase 3 완료 (로그인 시스템) ← 완료!
    ↓
📍 Phase 4: 편집 시스템 (3-4일) ← 다음
    ↓
🚀 Phase 4.5: 배포 준비 및 스테이징 테스트 (1-2일)
    - 스테이징 환경에 배포
    - 전체 기능 검증
    ↓
🌐 Phase 5: 프로덕션 배포 (1일)
    - careerwiki.org 도메인 연동
    - 실제 서비스 오픈
    ↓
🤖 Phase 6: AI 데이터 보완 (3-5일)
    - 부족한 필드를 AI로 채우기
    ↓
🧠 Phase 7: AI 분석기 고도화 (3-5일)
    - 사용자 맞춤 진로 추천
```

**Phase 4 작업 내용** (상세 계획: `PHASE4_IMPLEMENTATION_PLAN.md`):
1. [ ] 데이터베이스 스키마 확장 (원본 데이터 보존)
2. [ ] 편집 API 엔드포인트 (익명 편집 지원)
3. [ ] 편집 UI 구현 (Notion 스타일)
4. [ ] 익명 편집 시스템 (비밀번호 기반)
5. [ ] 충돌 해결 시스템
6. [ ] 버전 이력 관리 및 되돌리기
7. [ ] 출처 검증 시스템

**예상 소요 시간**: 4일 (32시간)

**⚠️ 중요**: 
- 익명 사용자도 모든 편집 가능
- API 데이터도 편집 가능 (원본 보존)
- 상세 구현 계획은 `PHASE4_IMPLEMENTATION_PLAN.md` 참조

---

## 🔍 현재 데이터 현황

### 전공 데이터
- **총**: 1,427개
- **CareerNet**: 504개 (Phase 1 필드 포함)
- **Goyong24**: 923개
- **Phase 1 필드 수집률**: 97.0% (universityList 제외)

### 직업 데이터
- **총**: 980개
- **CareerNet**: 443개
- **Goyong24**: 537개
- **성공률**: 98.9%

### 데이터 품질
- **API 데이터 보유율**: 100%
- **최근 업데이트**: 모두 정상
- **데이터 완전성**: 우수

---

## 📚 핵심 문서 정리

### 읽어야 할 문서 (우선순위 순)
1. **MASTER_PLAN.md** (본 문서) - 전체 계획
2. **README.md** - 프로젝트 개요
3. **docs/DEVELOPMENT_ROADMAP.md** - 상세 로드맵
4. **CURRENT_STATUS_AND_NEXT_STEPS.md** - 현재 상태

### 참고 문서
5. **docs/PROJECT_STATUS.md** - 프로젝트 현황
6. **docs/PHASE1_COMPLETION_REPORT.md** - Phase 1 완료 리포트
7. **docs/API_INTEGRATION.md** - API 필드 문서

### 기술 문서
8. **docs/ARCHITECTURE.md** - 시스템 아키텍처
9. **docs/ISR_CACHE_EXPLAINED.md** - ISR 캐시 설명
10. **TECH_SPEC.md** - 기술 스펙

### 중복 문서 (정리 필요)
- ⚠️ PHASE1_COMPLETION_STATUS.md (직업 템플릿 관련, 2025-10-30 작성)
- ⚠️ NEXT_STEPS.md (중복)
- ⚠️ NEXT_ACTION_PLAN.md (중복)
- ⚠️ CONTINUE_HERE.md (오래됨)

---

## 🚀 다음 단계 결정

### Option A: 빠른 완성 (추천)
**순서**: Phase 2.3 완료 → Phase 2.4 검증 → Phase 3-6 순차 진행  
**예상 기간**: 2-3주  
**장점**: 안정적, 단계별 검증

### Option B: 프로토타입 우선
**순서**: Phase 2.4 프로토타입 먼저 → Phase 2.3 개선 → Phase 3-6  
**예상 기간**: 2-3주  
**장점**: 빠른 검증, 문제 조기 발견

### Option C: 최소 기능 런칭
**순서**: Phase 2.3 최소 기능만 → 즉시 배포 → Phase 3-6는 점진적  
**예상 기간**: 1주 (최소 기능)  
**장점**: 빠른 시장 진입

---

**권장**: Option A (빠른 완성)

**이유**:
1. ✅ Phase 2.3 완료 후 검증하는 것이 안전
2. ✅ 데이터가 이미 완전하므로 UI만 개선하면 됨
3. ✅ 단계별 검증으로 품질 보장

---

**마지막 업데이트**: 2025-11-16  
**작성자**: CareerWiki Development Team  
**버전**: 1.2 (Phase 재구성 - Phase 5: 배포, Phase 6: AI 보완, Phase 7: AI 분석)

