# CareerWiki 프로젝트 현황

**최종 업데이트**: 2025-11-28

---

## ✅ 완료된 작업

### 1️⃣ 데이터 파이프라인
- ✅ 3개 직업 소스 시딩 완료 (CareerNet, Work24 Job, Work24 DJob)
- ✅ 2개 전공 소스 시딩 완료 (CareerNet, Work24 Major)
- ✅ ETL 병합 시스템 구축 (오프라인 merged_profile_json)
- ✅ **이름 매핑 시스템** (name_mappings 테이블)
- ✅ **유사 이름 관리 UI** (/similar-names)
- ✅ **관련 직업 연결** (etl:related-jobs)

### 2️⃣ 데이터 현황
| 구분 | 원본 소스 | 병합 후 | 이름 매핑 |
|------|----------|--------|----------|
| 직업 | ~21,000 | ~6,945 | 166개 |
| 전공 | ~619 | ~595 | 24개 |

### 3️⃣ 템플릿
- ✅ 직업 상세 페이지 (`unifiedJobDetail.ts`)
- ✅ 전공 상세 페이지 (`unifiedMajorDetail.ts`)
- ✅ How-to 가이드 페이지
- ✅ ISR 캐시 시스템

### 4️⃣ 기본 기능
- ✅ 사용자 인증 (Google OAuth)
- ✅ 댓글 시스템
- ✅ 검색 기능
- ✅ SERP 인터랙션 추적

---

## 🚧 진행 예정 (배포 전)

### Phase 6: 편집 시스템 & 이미지 (다음)
- [ ] **편집 시스템 업데이트**
- [ ] **이미지 추가** (직업/전공 대표 이미지)
- [ ] **커뮤니티 개선**

### Phase 7: 관리자 페이지
- [ ] **관리자 대시보드** 구축
- [ ] 사용자 관리
- [ ] 콘텐츠 관리
- [ ] 통계 대시보드

### Phase 8: 권한별 기능 테스트 ⚠️ 중요
모든 기능을 **익명 / 유저 / 관리자** 권한에서 테스트:

| 기능 | 익명 | 유저 | 관리자 |
|------|------|------|--------|
| 직업 상세페이지 편집 | - | - | - |
| 전공 상세페이지 편집 | - | - | - |
| 커뮤니티 | - | - | - |
| HowTo 생성 | - | - | - |
| HowTo 편집 | - | - | - |

### Phase 9: 프로덕션 배포 🚀
- [ ] **careerwiki.org 도메인 연동**
- [ ] **데이터 이전 작업** (로컬 → 프로덕션 D1)
- [ ] SSL/TLS 설정
- [ ] DNS 설정
- [ ] Google Search Console 등록

---

## 📋 배포 체크리스트

### 배포 전 필수 완료
- [ ] 편집 시스템 업데이트 완료
- [ ] 이미지 추가 완료
- [ ] 커뮤니티 개선 완료
- [ ] 관리자 페이지 완료
- [ ] 권한별 테스트 통과 (익명/유저/관리자)
  - [ ] 직업 상세페이지 편집
  - [ ] 전공 상세페이지 편집
  - [ ] 커뮤니티
  - [ ] HowTo 생성
  - [ ] HowTo 편집

### 배포 작업
- [ ] careerwiki.org 도메인 연동
- [ ] 프로덕션 D1 데이터베이스 준비
- [ ] 데이터 이전 (로컬 → 프로덕션)
- [ ] 환경 변수 설정
- [ ] 최종 테스트

---

## 🗂️ 주요 문서

### 필수 문서
| 문서 | 설명 |
|------|------|
| `ETL_GUIDE.md` | ETL 가이드 |
| `docs/ETL_CURRENT_STATE.md` | ETL 현재 상태 |
| `CURSOR_QUICKSTART.md` | 개발 시작 가이드 |
| `docs/D1_DATABASE_STRUCTURE.md` | 데이터베이스 구조 |
| `docs/DEVELOPMENT_ROADMAP.md` | 개발 로드맵 |

---

## 🛠️ 기술 스택

### 프론트엔드
- Hono JSX (SSR)
- Tailwind CSS (CDN)
- Vanilla JavaScript (클라이언트)

### 백엔드
- Hono (TypeScript)
- Cloudflare Workers
- Cloudflare D1 (SQLite)
- Cloudflare KV (캐시)

### 빌드/배포
- Vite + esbuild
- Cloudflare Pages

---

## 📊 데이터베이스 현황

### 주요 테이블
| 테이블 | 설명 | 레코드 수 |
|--------|------|----------|
| `jobs` | 병합된 직업 | ~6,945 |
| `majors` | 병합된 전공 | ~595 |
| `job_sources` | 직업 원본 소스 | ~21,000 |
| `major_sources` | 전공 원본 소스 | ~619 |
| `name_mappings` | 이름 매핑 | 190 |
| `users` | 사용자 계정 | - |
| `comments` | 댓글 | - |
| `page_revisions` | 편집 이력 | - |

---

## 🚀 Quick Start

```bash
# 의존성 설치
npm install

# 로컬 서버 시작
npm run build && npx wrangler pages dev ./dist --port 3000 --local

# ETL 실행
npm run etl:merge-all

# 프로덕션 배포
npm run deploy:prod
```

---

## 🔗 링크

- **로컬**: http://localhost:3000
- **프로덕션 (예정)**: https://careerwiki.org
- **유사 이름 관리**: http://localhost:3000/similar-names

---

## 👥 팀

- **개발자**: 정우 (Jeong-woo)
- **AI 어시스턴트**: Claude (Cursor)
