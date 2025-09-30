# CareerWiki - AI 진로 분석 플랫폼

## 프로젝트 개요
- **프로젝트명**: CareerWiki
- **목표**: AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 위키형 플랫폼
- **주요 기능**: 
  - 🧠 AI 커리어 분석기 (이력서 분석, 포지션 추천, 스킬 갭 진단)
  - 📚 진로 위키백과 (1,000+ 직업/전공 정보)
  - 💬 커뮤니티 댓글 시스템
  - 🔍 강력한 검색 기능

## 🌐 URLs
- **개발 서버**: https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/
- **프로덕션**: https://careerwiki.org (배포 예정)
- **GitHub**: https://github.com/[username]/careerwiki (연결 예정)

## ✅ 현재 구현된 기능

### 1. 메인 홈페이지 (구글 스타일)
- ✅ 중앙 배치 로고 (8가지 옵션 제공)
- ✅ 깔끔한 검색바 (구글 스타일)
- ✅ AI 진로 분석 & 직업 탐색 버튼
- ✅ 미니멀한 디자인

### 2. AI 커리어 분석기 (/analyzer)
- ✅ 분석 입력 폼 (경력, 스킬, 목표)
- ✅ 2단계 요금제 (무료/Pro 9,900원)
- ✅ 분석 내용:
  - 무료: 기본 분석, 포지션 3개, PDF 리포트
  - Pro: 심층 분석, 포지션 10개, 스킬 갭, 학습 로드맵, 1:1 피드백(예정)

### 3. 직업 위키 (/job)
- ✅ 직업 목록 페이지
- ✅ 개별 직업 상세 페이지
  - 평균 연봉, 성장 전망
  - 주요 업무
  - 필요 역량
  - 관련 학과
- ✅ 댓글 시스템 UI

### 4. 전공 위키 (/major)
- ✅ 전공 목록 페이지
- ✅ 개별 전공 상세 페이지 템플릿

### 5. 데이터베이스 스키마
- ✅ D1 Database 설정
- ✅ 테이블 구조 (pages, comments, career_analyses, search_index)
- ✅ 샘플 데이터

### 6. UI/UX 개선
- ✅ 다크 테마 (나무위키 감성)
- ✅ 그래디언트 효과
- ✅ Glass morphism 카드
- ✅ 반응형 디자인
- ✅ 모바일 메뉴
- ✅ 헤더 내장 검색창 (메인 제외)
- ✅ 구글 스타일 메인 페이지

## 📊 데이터 아키텍처

### 데이터 모델
```sql
- pages: 위키 문서 (직업/전공 정보)
- comments: 댓글 시스템
- career_analyses: AI 분석 결과 저장
- page_revisions: 문서 수정 이력
- search_index: 검색 인덱스
```

### 스토리지 서비스
- **Cloudflare D1**: 위키 콘텐츠 및 댓글 저장
- **Cloudflare KV**: 캐싱 및 세션 관리
- **Cloudflare R2**: (추후) 파일 업로드 저장

## 🚀 기능별 진입 URI

| 기능 | URL | 설명 |
|------|-----|------|
| 홈 | `/` | 메인 페이지 |
| AI 분석기 | `/analyzer` | AI 커리어 분석 도구 |
| 직업 목록 | `/job` | 전체 직업 리스트 |
| 직업 상세 | `/job/{slug}` | 개별 직업 정보 (예: `/job/software-engineer`) |
| 전공 목록 | `/major` | 전체 전공 리스트 |
| 전공 상세 | `/major/{slug}` | 개별 전공 정보 |
| 검색 | `/search?q={query}` | 통합 검색 |
| 소개 | `/about` | 플랫폼 소개 |

## 📝 미구현 기능 (TODO)

### 우선순위 높음
1. **AI 분석 실제 구현**
   - Claude/GPT API 연동
   - 분석 결과 생성 로직
   - PDF 리포트 생성

2. **결제 시스템**
   - Stripe/토스페이먼츠 연동
   - 요금제별 접근 제어

3. **데이터베이스 실제 연결**
   - D1 쿼리 구현
   - 댓글 저장/조회
   - 검색 기능 구현

### 우선순위 중간
4. **사용자 시스템**
   - 회원가입/로그인
   - 분석 이력 관리
   - 마이페이지

5. **콘텐츠 관리**
   - 관리자 페이지
   - 위키 수정 제안 시스템
   - 콘텐츠 승인 플로우

6. **SEO 최적화**
   - 사이트맵 생성
   - 메타태그 동적 생성
   - 구조화된 데이터

## 🎯 추천 다음 단계

### Phase 1 (1-2주)
1. **Cloudflare 배포 설정**
   - Cloudflare Pages 프로젝트 생성
   - D1 데이터베이스 프로덕션 설정
   - 커스텀 도메인 연결

2. **핵심 API 구현**
   - 댓글 CRUD API
   - 검색 API (D1 FTS 활용)
   - 조회수 트래킹

### Phase 2 (2-3주)
3. **AI 분석기 MVP**
   - Claude API 연동
   - 기본 분석 로직
   - 결과 페이지 구현

4. **콘텐츠 확충**
   - 100개 이상 직업 데이터
   - 50개 이상 전공 데이터
   - 공공 API 연동 (워크넷 등)

### Phase 3 (3-4주)
5. **수익화 준비**
   - 결제 시스템 통합
   - 이메일 알림
   - 분석 리포트 템플릿

6. **마케팅 & 런칭**
   - SEO 최적화 완료
   - 소셜 미디어 공유 기능
   - 베타 테스트 진행

## 🛠 기술 스택

- **프레임워크**: Hono (Cloudflare Workers)
- **배포**: Cloudflare Pages
- **데이터베이스**: Cloudflare D1 (SQLite)
- **캐싱**: Cloudflare KV
- **스타일링**: Tailwind CSS
- **아이콘**: Font Awesome
- **빌드 도구**: Vite

## 📦 설치 및 실행

### 개발 환경 설정
```bash
# 의존성 설치
npm install

# 개발 서버 실행 (로컬)
npm run dev

# 프로덕션 빌드
npm run build

# Cloudflare Pages 로컬 프리뷰
npm run preview
```

### 배포
```bash
# Cloudflare Pages 배포
npm run deploy

# D1 마이그레이션 (로컬)
npm run db:migrate:local

# D1 마이그레이션 (프로덕션)
npm run db:migrate:prod
```

## 📈 배포 상태
- **플랫폼**: Cloudflare Pages
- **상태**: ✅ 개발 서버 활성
- **기술 스택**: Hono + TypeScript + Cloudflare D1 + Tailwind CSS
- **최종 업데이트**: 2024-01-29

## 💰 비용 구조

### 초기 (0-3개월): 월 0원
- Cloudflare Pages: 무료
- Cloudflare D1: 무료 티어
- Cloudflare KV: 무료 티어

### 성장기 (3-6개월): 월 2-5만원
- Cloudflare Pro: $20
- AI API 비용: 2-3만원

### 확장기 (6개월+): 월 10-20만원
- AI API 사용량 증가
- 추가 스토리지/컴퓨팅

## 📞 문의
- 이메일: contact@careerwiki.org
- 개발자: 김정우

---

**Note**: 이 프로젝트는 현재 MVP 단계이며, 지속적으로 기능이 추가될 예정입니다.