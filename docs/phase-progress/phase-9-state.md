# Phase 9 완료 보고서 — 관리자 대시보드 강화
마지막 갱신: 2026-02-27 완료

## 진행 상태
- [x] 팀 구성 완료
- [x] Analyst 코드 분석 완료
- [x] Researcher GA4/검색어 리서치 완료
- [x] Designer 대시보드 UX 설계 완료
- [x] 구현 우선순위 결정 (설계서 승인)
- [x] DB 마이그레이션 (0042, 0043)
- [x] API 엔드포인트 구현
- [x] 대시보드 UI 구현
- [x] 코드 리뷰 게이트 통과
- [x] 프로덕션 배포 및 확인
- [x] 완료 보고서 작성

## 팀 구성
- Team Leader: Opus (메인 세션, 리서치 종합/설계/리뷰)
- Analyst: Sonnet (admin 코드 분석, D1 스키마 분석, 코드 리뷰)
- Researcher: Sonnet (GA4 API vs 자체수집 비교, 검색어 로깅 설계)
- Designer: Sonnet (대시보드 레이아웃, 차트 UX, 버그 발견)
- Implementer: Sonnet (Batch 1~4 순차 구현)

## 핵심 결정 사항

### 1. 자체 D1 수집 > GA4 API
- GA4 Data API는 서비스 계정 설정, Quota 제한, 실시간 불가 등 복잡도 높음
- D1 UPSERT 집계 + waitUntil() 비동기 로깅으로 충분한 정밀도 달성
- GA4/Search Console은 Phase 10+ 후순위로 연기

### 2. Chart.js CDN (기존 로드됨) + CSS 인라인 바
- 추이 차트: Chart.js line chart (이미 adminLayout.tsx에서 CDN 로드)
- 랭킹 바: CSS `bg-blue-500` 인라인 바 (라이브러리 불필요)
- SSR 친화적, 번들 크기 증가 없음

### 3. 집계 테이블만 사용 (원시 로그 없음)
- search_query_daily: 일별 검색어 집계 (UPSERT 패턴)
- daily_view_stats: 일별 entity_type별 조회수 집계
- D1 쓰기 부담 최소화 (검색 1회 = UPSERT 1번)

## 구현 완료 기능

### Batch 1: 버그 수정 + AI 전환율 + 커버리지 (commit 18d2ea1)
- adminStats.tsx 중복 채널 테이블 제거
- renderAdminStatsLegacy 데드코드 제거
- AI 분석기 전환율 탭 (KPI 카드 + Chart.js 추이 + 일별 테이블)
- 콘텐츠 커버리지 섹션 (직업/전공 편집률 프로그레스 바 + 편집 우선순위 TOP 10)

### Batch 2: 검색어 로깅 시스템 (commit ce34d62)
- 마이그레이션 0042: search_query_daily 테이블
- searchQueryLogger.ts: PII 필터링 + UPSERT 패턴
- search.ts, job-list.ts, major-list.ts에 waitUntil 로깅 추가
- 관리자 "검색" 탭: 인기 검색어 TOP 20 + 실패 키워드

### Batch 3: 일별 조회수 + 방문자 추이 차트 (commit 2631108)
- 마이그레이션 0043: daily_view_stats 테이블
- viewCounter.ts 4개 함수에 일별 UPSERT 추가
- adminDashboard.tsx에 Chart.js line chart (job/major/howto 3색)
- 7일 평균, 최대 일자 요약 표시

### Batch 4: TOP20 인라인 바 + 모바일 탭 (commit e918bb1)
- renderTopTable 함수에 CSS 인라인 바 인디케이터 추가
- 모바일 탭 `<select>` 드롭다운 (sm 미만 표시)
- 데스크톱 탭 `hidden sm:flex` (sm 이상 표시)

### Batch 5: 코드 리뷰 수정 (commit e426794)
- H-1: getDailyViewStats SQL date() 함수 D1 호환성 수정
- H-2: getCoverageStats NULLS LAST → COALESCE() 패턴 수정

## 변경된 파일 (총 14개)

### 신규 파일 (3개)
| 파일 | 설명 |
|------|------|
| `migrations/0042_search_query_daily.sql` | 검색어 일별 집계 테이블 |
| `migrations/0043_daily_view_stats.sql` | 일별 조회수 집계 테이블 |
| `src/services/searchQueryLogger.ts` | 검색어 로깅 서비스 (PII 필터 + UPSERT) |

### 수정 파일 (11개)
| 파일 | 변경 내용 |
|------|-----------|
| `src/services/adminService.ts` | getAiConversionStats, getCoverageStats, getSearchStats, getDailyViewStats 추가 |
| `src/routes/admin.ts` | 새 쿼리 함수 호출, 라우트 데이터 연결 |
| `src/routes/search.ts` | waitUntil(logSearchQuery) 추가 |
| `src/routes/job-list.ts` | waitUntil(logSearchQuery) 추가 |
| `src/routes/major-list.ts` | waitUntil(logSearchQuery) 추가 |
| `src/templates/admin/adminStats.tsx` | 검색/AI퍼널 탭 + 인라인 바 + 모바일 select |
| `src/templates/admin/adminContent.tsx` | 커버리지 섹션 추가 |
| `src/templates/admin/adminDashboard.tsx` | 방문자 추이 Chart.js line chart |
| `src/utils/viewCounter.ts` | daily_view_stats UPSERT (4개 함수) |

## 코드 리뷰 결과 요약

### 수정 완료 (High)
- **H-1**: `date('now', '-' || ? || ' days')` → `date('now', '-${days} days')` (D1 호환성)
- **H-2**: `ORDER BY view_count DESC NULLS LAST` → `ORDER BY COALESCE(view_count, 0) DESC`

### 보류 (Medium, 기능 영향 있어 별도 대응)
- **M-3**: howto.ts `await trackPageView` — view_count 실시간 표시에 결과값 사용 중이므로 단순 waitUntil 전환 불가
- **M-4**: 모바일 select `e.target.value` 타입 안전성 — 런타임 영향 없음
- **M-5**: 탭 `activate(btn.dataset.tab)` undefined 가능성 — data-tab 항상 존재하므로 실질 위험 없음

## 성과 지표

| 항목 | 이전 | 이후 |
|------|------|------|
| 관리자 탭 | 4개 (dashboard/job/major/howto) | 6개 (+search, ai-funnel) |
| 검색어 분석 | 없음 | 인기 TOP20 + 실패 키워드 |
| AI 전환율 | 수동 DB 쿼리 | 자동 추이 차트 + KPI 카드 |
| 콘텐츠 커버리지 | 없음 | 편집률 시각화 + 우선순위 TOP 10 |
| 조회수 추이 | 없음 | 30일 일별 추이 라인 차트 |
| 인기 페이지 | 숫자만 표시 | 비율 인라인 바 시각화 |
| 모바일 UX | 탭 가로 스크롤 | select 드롭다운 |

## 프로덕션 URL
- 대시보드: https://careerwiki.org/admin
- 통계: https://careerwiki.org/admin/stats
- 콘텐츠: https://careerwiki.org/admin/content
