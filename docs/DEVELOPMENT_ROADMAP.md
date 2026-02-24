# CareerWiki 개발 로드맵

**최종 업데이트**: 2026-02-04

---

## 📊 Phase 진행 현황

| Phase | 상태 | 설명 |
|-------|------|------|
| Phase 0 | ✅ 완료 | 아키텍처 기반 구축 |
| Phase 1 | ✅ 완료 | 데이터 완전성 확보 |
| Phase 2 | ✅ 완료 | ISR 캐시 시스템 |
| Phase 3 | ✅ 완료 | 로그인 시스템 (Google OAuth) |
| Phase 4 | ✅ 완료 | 기본 편집 시스템 |
| Phase 5 | ✅ 완료 | 이름 매핑 & 유사 병합 |
| **Phase 6** | 🔄 **진행 중** | **AI 추천기 고도화 & 이미지 & 커뮤니티** |
| Phase 7 | 📋 예정 | 관리자 페이지 |
| Phase 8 | 📋 예정 | 권한별 테스트 |
| Phase 9 | 📋 예정 | 프로덕션 배포 (careerwiki.org) |

---

## ✅ 완료된 Phase

### Phase 0-5: 기반 구축 완료
- 아키텍처 설계 및 DB 스키마
- 데이터 수집 (CareerNet, 고용24)
  - 1,427개 전공 데이터
  - 980개 직업 데이터
- ISR 캐시 시스템 (응답시간 500ms → 50ms로 10배 개선)
- Google OAuth 로그인
- 기본 편집 시스템 (직업/전공/HowTo)
- 이름 매핑 & ETL 병합
- **Production 데이터베이스 마이그레이션 완료** (2026-01-08)
  - Cloudflare D1 (careerwiki-kr) 사용
  - Cloudflare R2 (careerwiki-uploads) 이미지 저장
  - 로컬 개발 시에도 Production 리소스 직접 연동

---

## 🔄 Phase 6: AI 추천기 고도화 & 이미지 & 커뮤니티 (진행 중)

### 6.1 AI 추천기 고도화 (🔄 진행 중)
- [x] **Freeze v1.1**: Interview/Recommendation 모드 분리 (2026-01-27 완료)
  - Axis Framework (10개 핵심 축)
  - QSP (Question Signals Packet) 생성
  - 설문 중 직업명 비노출, 제출 후 추천 실행
- [x] **LLM 누적 메모리 시스템** (2026-01-24 완료)
  - AggregatedProfile 단일 구조 도입
  - Rolling Memory + 신뢰도 추적
  - LLM Gate 및 폴백 질문 시스템
- [ ] **LLM 구조적 앵커 개편** (진행 중)
  - 인터뷰 정보 구조화 (Identity/Values/Context)
  - 메모리 누적 메커니즘 고도화
- [ ] RAG + CAG + Tag 기반 추천 고도화
- [ ] 추천 정확도 캘리브레이션

### 6.2 이미지 생성 및 저장 (✅ 완료)
- [x] 직업/전공 대표 이미지 생성 (DALL-E/ComfyUI)
- [x] Cloudflare R2 저장 및 연동
- [x] 이미지 프롬프트 자동 생성 워크플로우
- [x] Production R2 마이그레이션 완료 (~7,500개 이미지)

### 6.3 편집 시스템 업데이트
- [x] 직업 상세페이지 편집 기능
- [x] 전공 상세페이지 편집 기능
- [x] HowTo 생성/편집 시스템
- [x] Tiptap 기반 위키 에디터
- [ ] 편집 권한 체계 정비

### 6.4 커뮤니티 개선
- [x] 커뮤니티 기본 기능 (댓글)
- [ ] UI/UX 개선
- [ ] 신고/관리 기능

---

## 📋 Phase 7: 관리자 페이지

### 목표
관리자 전용 대시보드 구축

### TODO
- [ ] 관리자 대시보드 메인
- [ ] 사용자 관리 (권한 부여/취소)
- [ ] 콘텐츠 관리 (편집 승인/거부)
- [ ] 통계 대시보드
- [ ] 데이터 품질 모니터링

---

## 📋 Phase 8: 권한별 기능 테스트 ⚠️ 중요

### 테스트 대상 기능
1. 직업 상세페이지 편집시스템
2. 전공 상세페이지 편집시스템
3. 커뮤니티
4. HowTo 생성
5. HowTo 편집

### 테스트 권한
| 권한 | 설명 |
|------|------|
| 익명 | 로그인하지 않은 사용자 |
| 유저 | 일반 로그인 사용자 |
| 관리자 | admin 권한 사용자 |

### 테스트 매트릭스

| 기능 | 익명 | 유저 | 관리자 | 비고 |
|------|------|------|--------|------|
| 직업 페이지 보기 | ✅ | ✅ | ✅ | |
| 직업 페이지 편집 | ❌ | ⭕ | ✅ | |
| 전공 페이지 보기 | ✅ | ✅ | ✅ | |
| 전공 페이지 편집 | ❌ | ⭕ | ✅ | |
| 커뮤니티 보기 | ✅ | ✅ | ✅ | |
| 커뮤니티 글쓰기 | ❌ | ✅ | ✅ | |
| 커뮤니티 삭제 | ❌ | ⭕ | ✅ | 본인 글만 |
| HowTo 보기 | ✅ | ✅ | ✅ | |
| HowTo 생성 | ❌ | ⭕ | ✅ | |
| HowTo 편집 | ❌ | ⭕ | ✅ | |

**범례**: ✅ 가능, ❌ 불가, ⭕ 제한적 가능

### 통과 조건
- 모든 기능이 권한에 맞게 동작
- 권한 없는 접근 시 적절한 에러 메시지
- UI에서 권한 없는 기능 숨김 처리

---

## 📋 Phase 9: 프로덕션 배포 🚀

### 전제 조건
- [ ] Phase 6 완료 (편집/이미지/커뮤니티)
- [ ] Phase 7 완료 (관리자 페이지)
- [ ] Phase 8 통과 (권한별 테스트)

### 배포 작업

#### 1. 도메인 연동
```bash
# careerwiki.org 도메인을 Cloudflare Pages에 연결
npx wrangler pages domain add careerwiki.org --project-name careerwiki
```

#### 2. DNS 설정
```
Type: CNAME
Name: @ (또는 careerwiki.org)
Content: careerwiki.pages.dev
Proxy: Enabled (오렌지 구름)
```

#### 3. 프로덕션 D1 데이터베이스
```bash
# 프로덕션 DB에 마이그레이션 적용
npx wrangler d1 migrations apply careerwiki --remote

# 데이터 이전 (로컬 → 프로덕션)
# 별도 스크립트 필요
```

#### 4. 환경 변수 설정
- Google OAuth 클라이언트 ID/Secret
- 기타 프로덕션 설정

#### 5. SSL/TLS
- Cloudflare 자동 SSL 인증서
- Full (strict) 모드

#### 6. SEO 설정
```bash
# sitemap.xml 확인
# robots.txt 확인
# Google Search Console 등록
```

### 배포 체크리스트
- [ ] 모든 Phase 완료
- [ ] careerwiki.org DNS 설정
- [ ] 프로덕션 D1 준비
- [ ] 데이터 이전 완료
- [ ] 환경 변수 설정
- [ ] SSL 활성화
- [ ] 최종 테스트
- [ ] Google Search Console 등록

---

## 🏗️ 아키텍처 개요

```
┌──────────────────────────────────────────────────────────────────┐
│                      Cloudflare Pages                            │
│  ┌─────────────┐  ┌─────────────┐  ┌──────────────────────────┐ │
│  │   Static    │  │   Hono      │  │    ISR Cache             │ │
│  │   Assets    │  │   Workers   │  │    (wiki_pages)          │ │
│  └─────────────┘  └──────┬──────┘  └──────────────────────────┘ │
│                          │                                        │
│  ┌───────────────────────┴────────────────────────────────────┐  │
│  │                   Cloudflare D1 (careerwiki-kr)            │  │
│  │  ┌──────────┐ ┌─────────┐ ┌──────────────┐ ┌────────────┐ │  │
│  │  │  jobs    │ │ majors  │ │ job_sources  │ │   users    │ │  │
│  │  │  (980)   │ │ (1,427) │ │              │ │            │ │  │
│  │  └──────────┘ └─────────┘ └──────────────┘ └────────────┘ │  │
│  │  ┌──────────────────────────────────────────────────────┐  │  │
│  │  │  AI Analysis Tables (ai_analysis_results,            │  │  │
│  │  │  aggregated_profiles, job_attributes, facts, etc)    │  │  │
│  │  └──────────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘
           │                          │                      │
           ▼                          ▼                      ▼
┌────────────────────┐  ┌──────────────────────┐  ┌─────────────────┐
│  Cloudflare R2     │  │ Cloudflare Vectorize │  │  External APIs  │
│ (careerwiki-       │  │ (임베딩 검색)         │  │ - CareerNet     │
│  uploads)          │  │ text-embedding-3-    │  │ - 고용24        │
│ ~7,500개 이미지    │  │ small (1536dim)      │  │ - Claude/GPT-4  │
└────────────────────┘  └──────────────────────┘  └─────────────────┘
```

### 💾 데이터 저장 현황 (2026-02-04)

| 리소스 | 저장 위치 | 내용 | 비고 |
|--------|----------|------|------|
| **데이터베이스** | Cloudflare D1 (careerwiki-kr) | 모든 직업/전공/사용자/분석 데이터 | Production 사용 중 |
| **이미지** | Cloudflare R2 (careerwiki-uploads) | ~7,500개 직업/전공 대표 이미지 | Production 사용 중 |
| **임베딩** | Cloudflare Vectorize | 직업/전공 벡터 검색용 | OpenAI embedding 사용 |
| **로컬 개발** | 동일 리소스 | Production과 동일한 D1/R2 사용 | `npm run dev`로 자동 연결 |

---

## 📅 진행 현황 및 예상 일정

### 현재 브랜치
- **feature/analyzer-llm-rag-main** (AI 추천기 고도화 작업 중)
- Main branch: **main**

### 최근 완료 작업 (2026-01-27)
- ✅ Freeze v1.1: Interview/Recommendation 모드 분리
- ✅ LLM 누적 메모리 시스템 구현
- ✅ AggregatedProfile 단일 구조 도입
- ✅ Axis Framework 및 QSP 생성

### 예상 일정

| Phase | 예상 기간 | 상태 |
|-------|----------|------|
| Phase 6 | 진행 중 | 🔄 AI 추천기 고도화 집중 |
| Phase 7 | 1주 | 📋 예정 |
| Phase 8 | 2-3일 | 📋 예정 |
| Phase 9 | 1일 | 📋 예정 |

**배포 상태**: Production 환경 가동 중 (https://careerwiki.org)

---

## 👥 기여자

- **정우 (Jeong-woo)**: 프로젝트 오너, 기획
- **Claude (Cursor)**: AI 개발 어시스턴트

---

## 📚 참고 문서

### 개발 가이드
- [DEV_PROTOCOL.md](../DEV_PROTOCOL.md) - 개발 프로토콜 및 워크플로우
- [docs/D1_DATABASE_STRUCTURE.md](D1_DATABASE_STRUCTURE.md) - DB 구조
- [docs/ETL_CURRENT_STATE.md](ETL_CURRENT_STATE.md) - ETL 상세 상태

### 기능별 가이드
- [IMAGE_STORAGE_GUIDE.md](../IMAGE_STORAGE_GUIDE.md) - 이미지 저장 가이드
- [TAGGING_WORKFLOW.md](../TAGGING_WORKFLOW.md) - 태깅 워크플로우
- [PROMPT_WORKFLOW_GUIDE.md](../PROMPT_WORKFLOW_GUIDE.md) - 프롬프트 생성 가이드
- [docs/ANALYZER_TEST_GUIDE.md](ANALYZER_TEST_GUIDE.md) - 분석기 테스트 가이드

### 최근 구현 보고서
- [Freeze_v1.1_구현_완료_보고서.md](../Freeze_v1.1_구현_완료_보고서.md) - Interview/Recommend 분리 (2026-01-27)
- [LLM_누적_메모리_시스템_구현_보고서.md](../LLM_누적_메모리_시스템_구현_보고서.md) - 메모리 시스템 (2026-01-24)
- [Vectorize_재인덱싱_작업_보고서.md](../Vectorize_재인덱싱_작업_보고서.md) - 벡터 DB 재구축
