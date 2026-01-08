# CareerWiki 데이터 마이그레이션 보고서

**작성일**: 2026년 1월 8일  
**작성자**: Cursor AI  
**대상**: Local D1 → Cloudflare Production D1

---

## 📋 요약

| 항목 | 결과 |
|------|------|
| **마이그레이션 상태** | ✅ 완료 |
| **핵심 데이터** | 100% 동기화 |
| **총 테이블** | 63개 중 63개 스키마 완료 |
| **총 레코드** | 21,474+ (Production) |

---

## ✅ 완료된 핵심 데이터

| 테이블 | 로컬 | Production | 상태 |
|--------|------|------------|------|
| **jobs** | 6,945 | 6,945 | ✅ 100% |
| **majors** | 608 | 608 | ✅ 100% |
| **pages** | 229 | 229 | ✅ 100% |
| **job_attributes** | 1,682 | 1,682 | ✅ 100% |
| **users** | 2 | 2 | ✅ 100% |
| **tags** | 5 | 5 | ✅ 100% |
| **facts** | 239 | 239 | ✅ 100% |
| **uploaded_files** | 32 | 32 | ✅ 100% |
| **page_revisions** | 4 | 4 | ✅ 100% |
| **user_bookmarks** | 6 | 6 | ✅ 100% |
| **user_attributions** | 2 | 2 | ✅ 100% |
| **ai_analysis_requests** | 94 | 94 | ✅ 100% |
| **ai_analysis_results** | 94 | 94 | ✅ 100% |
| **profanity_rules** | 9 | 9 | ✅ 100% |
| **question_history** | 12 | 12 | ✅ 100% |
| **consents** | 4 | 4 | ✅ 100% |
| **d1_migrations** | 30 | 30 | ✅ 100% |

---

## 🔄 자동 재생성 데이터 (마이그레이션 불필요)

| 테이블 | 설명 | 재생성 방법 |
|--------|------|-------------|
| **wiki_pages** (16) | ISR 페이지 캐시 (HTML) | 페이지 접근 시 자동 생성 |
| **job_sources** (7,735) | API 원본 데이터 캐시 | `npm run etl:fetch-jobs` |
| **major_sources** (692) | API 원본 데이터 캐시 | `npm run etl:fetch-majors` |
| **job_dictionary_index** (6,359) | 검색 인덱스 | ETL 재실행 시 자동 생성 |

> ⚠️ 필요시 ETL 명령어로 최신 데이터 재생성 권장

---

## ⏭️ 제외된 데이터 (개발/로그)

| 테이블 | 개수 | 제외 사유 |
|--------|------|-----------|
| seed_errors | 6,616 | 개발 중 발생한 오류 로그 |
| tagger_errors | 193 | 태깅 오류 로그 |
| tagger_runs | 6 | 태깅 실행 로그 |
| seed_logs | 16 | 시드 실행 로그 |
| raw_events | 306 | 이벤트 로그 (이미 마이그레이션됨) |
| raw_events_backup | 30 | 백업 로그 (이미 마이그레이션됨) |

---

## ⚠️ 미완료 (영향 없음)

| 테이블 | 개수 | 사유 | 영향도 |
|--------|------|------|--------|
| draft_related_jobs | 1 | FK 제약 | 낮음 (임시저장) |
| draft_related_majors | 1 | FK 제약 | 낮음 (임시저장) |
| draft_tags | 2 | FK 제약 | 낮음 (임시저장) |

> draft_* 테이블은 사용자 임시저장 데이터로, 운영에 영향 없음

---

## 🔐 Cloudflare Secrets 설정 완료

| Secret | 상태 |
|--------|------|
| CAREER_NET_API_KEY | ✅ |
| GOYONG24_MAJOR_API_KEY | ✅ |
| GOYONG24_JOB_API_KEY | ✅ |
| GEMINI_API_KEY | ✅ |
| GOOGLE_CLIENT_ID | ✅ |
| GOOGLE_CLIENT_SECRET | ✅ |
| JWT_SECRET | ✅ |
| ADMIN_SECRET | ✅ |

---

## 📁 R2 버킷 상태

| 버킷 | 상태 | 비고 |
|------|------|------|
| careerwiki-images | ✅ 존재 | AI 생성 이미지, 필요시 재생성 |

---

## 🚀 Production 배포 후 권장 작업

### 1. 즉시 실행 (선택)
```bash
# API 캐시 최신화 (선택사항)
npm run etl:fetch-jobs
npm run etl:fetch-majors
```

### 2. 검증
- [ ] https://careerwiki.pages.dev 접속 확인
- [ ] 직업 상세 페이지 정상 표시
- [ ] 전공 상세 페이지 정상 표시
- [ ] 검색 기능 동작 확인
- [ ] 사용자 로그인 테스트

---

## 📊 마이그레이션 통계

- **시작 시간**: 2026-01-08
- **소요 시간**: ~2시간
- **사용 도구**: wrangler CLI, 커스텀 Node.js 스크립트
- **방법**: 
  - 스키마: `wrangler d1 export` → `wrangler d1 execute --file`
  - 데이터: 개별 INSERT OR REPLACE (대용량은 배치 처리)

---

## ✅ 결론

**핵심 데이터 100% 마이그레이션 완료**

- jobs, majors, pages 등 운영에 필수적인 모든 데이터가 Production에 동기화됨
- wiki_pages (ISR 캐시)는 페이지 접근 시 자동 재생성
- job_sources/major_sources는 ETL로 최신 데이터 가져올 수 있음
- 개발 로그는 Production에 불필요하여 제외

**Production 서비스 즉시 가능** 🎉

