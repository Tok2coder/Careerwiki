# 설계서: 추천 리포트 지연 생성 전환 (Deferred Report) v1

작성: 차민혁 / 2026-07-06 / 상태: **구현 완료** (프론트 분석 반영)

## 1. 기능 정의

### 목적
cold 추천 응답 60초 중 리포트 생성 15~20초(33%)를 응답 경로에서 분리한다.
추천 목록은 **~40초에 먼저 표시**, 심리분석 리포트는 백그라운드에서 생성해 도착 시 채운다.

### 품질 영향
**없음 (설계 목표).** 동일한 리포터(`generateLLMPremiumReport` / `generateMajorPremiumReport`)를
동일 입력으로 시점만 뒤로 미뤄 호출한다. 추천 산출 파이프라인(검색·스코어·Judge)은 일절 무변.

### 근거 실측 (2026-07-06 timings)
| 구간 | job | major |
|---|---|---|
| candidates | 7.4s | 6.5s |
| judge | 28.7s | 28.9s |
| **report** | **19.8s** | **14.9s** |
| other | 2.4s | 2.5s |

### 기존 인프라 (이미 있음)
- `/v3/recommend`·`/v3/recommend-major`: `skipReport=true` → `report_mode='deferred'` 지원 (서버 완성, 프론트 미사용)
- `POST /v3/recommend/report` (job 전용): 세션 저장결과에서 리포트 생성 + `ai_analysis_results` 갱신

## 2. 서버 변경

### 2-1. `/v3/recommend/report` (job) 보강
- **캐시 주입 추가**: 생성 후 `recommendation_result_cache`의 해당 row(`profile_hash`)에
  `premium_report_json` + `result_json`(premium_report 주입, report_mode→'llm') UPDATE.
  - `profile_hash`는 recommend 응답에 신규 노출하고 report 요청 payload로 돌려받는다.
  - 없으면 캐시 갱신 skip (기능 동작엔 무영향).
- **오조회 방지**: `ai_analysis_requests` 조회에 `analysis_type` 조건 추가 (major와 세션 겹침 방어).

### 2-2. `/v3/recommend-major/report` 신설
- job 버전 미러: 저장된 `fit_top_majors` → `MajorReporterInput` 재구성 → `generateMajorPremiumReport`
  → `ai_analysis_results` 갱신(analysis_type='major') + 캐시 주입(analysis_type='major').

### 2-3. recommend 응답에 `profile_hash` 필드 추가 (job·major)
- 캐시 키를 프론트가 report 요청에 에코백. 불투명 해시라 보안 영향 없음.

### 2-4. 캐시 동작 (변경 없음 확인)
- skipReport=true여도 recommend는 캐시를 쓴다(report null). report 완료 시 2-1/2-2가 주입.
- 이후 cache-hit 사용자는 리포트 포함 결과를 즉시 받는다 (deferred 처리 자체가 불필요).

## 3. 동작 명세

### 정상 (cold)
1. 프론트 `skipReport:true`로 recommend 호출 → ~40s에 추천 수신 (`report_mode:'deferred'`, `premium_report:null`)
2. 추천 즉시 렌더 + 리포트 영역 로딩 스켈레톤
3. 프론트가 `/v3/recommend(-major)/report` 호출 (session_id + profile_hash) → 15~20s 후 리포트 렌더
4. 서버는 ai_analysis_results + 캐시에 리포트 영구 저장 → 재열람·cache-hit 모두 리포트 포함

### warm (cache-hit)
- 캐시에 리포트가 이미 주입돼 있으므로 기존과 동일하게 즉시 전체 표시. deferred 분기 미진입.

### 엣지: cache-hit인데 리포트 아직 null (원 세션이 생성 중인 ~20s window)
- 프론트: report 엔드포인트 호출 → 자기 세션 저장결과 없음 404 →
  **15초 후 recommend 1회 재호출**(캐시에서 리포트 획득 기대) → 실패 시 "리포트 다시 생성" 버튼.
- 발생 확률: 동일 프로필 해시 사용자가 20초 window에 겹칠 때만. 베타 트래픽에서 희귀.

### 에러
- 리포터 LLM 실패: 서버 내장 rule-fallback 리포트 반환 (기존 동작 유지) → 프론트 정상 렌더
- report 호출 네트워크 실패: 리포트 영역에 재시도 버튼 (추천 목록은 이미 표시된 상태 유지)

### 롤백
- 프론트 `skipReport`를 false로 되돌리면 즉시 원복. 서버는 양 경로 모두 상시 지원.

## 4. 프론트 변경 (호출부 5곳 + 헬퍼)

### JOB (`analyzer-job-page.ts`)
- 헬퍼 신설: `fetchDeferredReport(endpoint, sessionId, profileHash)` / `showReportPendingBanner()` / `markReportBannerFailed()` (displayResults 직전)
- 첫 분석(4465권): `skipReport:true` + mergeRecommendations에 `_profile_hash`·`_report_deferred`·`engine_version` 복사(v3 게이트 통과 보장) + displayResults 후 배너·백그라운드 report fetch → 도착 시 `displayResults` 재호출
- 재분석(8057권): 동일 패턴
- **편집 모드**: 결과 페이지로 redirect하는 경로는 이동 전에 report 생성을 `await` (저장 결과에 리포트 보장 — 총 대기시간은 기존과 동일, 일반 사용자 경로 아님)
- 리포트 없는 동안: v3 탭 UI는 뜨되(engine_version 게이트) 내장 fallback 텍스트 + 상단 "생성 중" 배너

### MAJOR (`analyzer-major-page.ts`)
- 헬퍼 신설: `fetchDeferredReportMajor` / `showReportPendingBannerMajor` / `markReportBannerFailedMajor`
- 3곳(첫 분석·followup·재분석) `skipReport:true` + 동일 deferred 패턴, 편집 모드 2곳 await
- **의도적 결정: 3068 게이트(`if (result.premium_report)`)는 건드리지 않음** — 리포트 대기 중엔 기존 V2 추천 목록을 먼저 보여주고, 리포트 도착 시 displayResults 재호출로 4탭 리포트 UI로 전환. report={}로 4탭을 강제 렌더하는 방식은 미검증 크래시 위험이 있어 회피(브라우저 자동화 검증 불가 환경).

### 알려진 minor UX
- 리포트 도착 시 통짜 재렌더라 사용자가 보던 탭이 summary로 리셋됨 (도착 시점 ~15-20s 후, 영향 작음 — 추후 개선 여지)

## 5. 영향 분석

| 영역 | 영향 |
|---|---|
| 추천 품질 | 없음 (파이프라인 무변, 하네스 전/후 검증) |
| 사용자 체감 | 추천 61s→~40s. 리포트 탭은 총 소요 동일(~60s)하나 추천을 먼저 봄 |
| 비용 | 동일 (같은 LLM 호출을 분리했을 뿐) |
| 저장/재열람 | 동일 (ai_analysis_results에 최종 저장) |
| 하위 호환 | skipReport:false 경로 유지 — 구 클라이언트/외부 호출 무영향 |

## 6. 검증 계획

1. `npx tsc --noEmit` + `npm run build` + prod smoke
2. API 레벨 E2E (신규 프로필): recommend(skipReport:true) wall ~40s·timings.report≈0 → report 호출 완료 → recommend 재호출 시 cache-hit + 리포트 포함
3. 품질 회귀: 베이스라인 하네스 job 시나리오 재실행 → hit@10 동일 확인
4. 프론트: prod HTML/JS에 변경 반영 확인(curl grep) + 결과 페이지 HTTP 200
   (브라우저 자동화 금지 환경 — 렌더 육안 검증 한계는 보고에 명시)
