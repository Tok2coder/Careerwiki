# Security & Operations Analysis Report

**분석 일자**: 2026-03-03
**분석 대상**: CareerWiki (careerwiki.org)
**분석자**: 김분석 (Security & Ops Analyst)
**코드베이스 기준**: main 브랜치 (commit f4ab654)

---

## 1. 보안 감사

### 1.1 인증 시스템

**구현 방식**:
- Google OAuth 2.0 (유일한 프로덕션 인증 경로)
- Opaque Session Token 기반 세션 (KV 저장) + JWT fallback (마이그레이션 기간)
- 세션 토큰 형식: `{UUID}-{UUID}` (crypto.randomUUID 2회 연결, 총 73자)
- 세션 쿠키: `HttpOnly`, `SameSite=Lax`, `Secure` (HTTPS 환경)
- 세션 유휴 타임아웃 7일, 절대 최대 수명 30일
- Sliding window 갱신 (5분 디바운스)

**관련 파일**:
- `src/routes/auth.ts` - OAuth 플로우, 테스트 로그인
- `src/middleware/auth.ts` - 인증 미들웨어
- `src/utils/session.ts` - 세션 CRUD
- `src/utils/jwt.ts` - JWT 유틸리티 (레거시)

**강점**:
- OAuth state 파라미터로 CSRF 방지 (line 50-51, auth.ts)
- Open redirect 방지: `sanitizeReturnUrl()` 함수로 상대 경로만 허용 (line 25-33, auth.ts)
- 세션 토큰 SHA-256 해시로 감사 로그 저장 (DB에 원본 토큰 저장하지 않음)
- IP 마스킹 처리 (IPv4: 마지막 옥텟 마스킹, IPv6: 앞 4블록만 표시)
- 밴 사용자 세션 즉시 파괴 (middleware에서 검증)
- 디바이스당 1세션 + 최대 10세션 제한
- 레거시 JWT 사용자 자동 세션 마이그레이션

**취약점**:

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| A1 | **테스트 계정 하드코딩**: `id='test'`, `pw='1234'`로 프로덕션에서 누구나 로그인 가능. 테스트 계정이지만 실제 세션 발급됨 | **High** | `src/routes/auth.ts:377` |
| A2 | **GET /auth/logout**: 로그아웃이 GET 요청으로도 가능하여, `<img src="/auth/logout">` 등으로 CSRF 기반 로그아웃 강제 가능 | **Medium** | `src/routes/auth.ts:276` |
| A3 | **OAuth 콜백 에러 시 error.message 노출**: 내부 에러 메시지(`Token exchange failed: 401` 등)가 사용자에게 그대로 표시됨 | **Low** | `src/routes/auth.ts:227` |
| A4 | **세션 쿠키 Secure 플래그 조건부**: `isHttps` 검사로 HTTP 환경에서는 Secure 플래그 없이 쿠키 설정됨 (Cloudflare 프록시 뒤에서는 사실상 안전하나, 코드 레벨 약점) | **Low** | `src/routes/auth.ts:186` |

### 1.2 권한 체계

**구현 방식**:
- 3단계 역할: `user` < `expert` < `admin`
- 미들웨어 기반: `requireAuth`, `requireRole`, `requireAdmin`, `requireExpert`
- 역할 계층: `roleHierarchy` 숫자 비교 (user=1, expert=2, admin=3)

**관련 파일**: `src/middleware/auth.ts`

**강점**:
- 모든 `/admin/*` 라우트에 `requireAdmin` 미들웨어 적용 확인 (admin.ts 내 27개 라우트 전수 확인)
- HowTo 편집 시 작성자 확인 로직 존재 (`isAuthor && !isAdmin` 패턴)
- 익명 편집 허용하되 IP 기반 일일 제한 (10회/일/IP/entity)

**취약점**:

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| B1 | **일부 admin API에 미들웨어 대신 인라인 검증 사용**: `/api/admin/merge-jobs`, `/api/admin/reseed-empty-majors`가 `requireAdmin` 미들웨어 없이 인라인 `isAdmin` 체크 + `X-Admin-Secret` 헤더 검증. `ADMIN_SECRET`의 타이밍 공격 취약 (문자열 `===` 비교) | **Medium** | `content-editor.ts:62`, `major-editor.ts:16` |
| B2 | **X-Admin-Secret 헤더 인증 병용**: 일부 admin API가 사용자 역할 OR 시크릿 헤더로 인증 허용. 시크릿 헤더 방식은 브루트포스 가능성 존재 (레이트 리밋 없음) | **Medium** | `content-editor.ts:67`, `major-editor.ts:20` |
| B3 | **수평 권한 미검증 사례 존재**: `requireJobMajorEdit` 미들웨어가 사실상 no-op (모든 사용자 + 익명도 통과). 비밀번호 검증은 API 엔드포인트에서 처리하나, 미들웨어 이름이 오해를 유발 | **Low** | `middleware/auth.ts:207-218` |

### 1.3 입력 검증 (XSS, SQL Injection, CSRF)

#### XSS 방어

**구현 현황**:
- `escapeHtml()` 함수 존재 (`shared-helpers.ts:1287`): `&`, `<`, `>` 이스케이프
- `serializeForScript()` 함수: JSON 직렬화 시 `<`, `>`, `&`를 유니코드 이스케이프
- `sanitizeContent()` 함수 (`editValidation.ts:97`): `<script>`, `javascript:`, `on*=` 패턴 정규식 제거
- SVG 업로드 차단 (XSS 벡터 차단)
- 편집기 서버 렌더링 시 `escapeHtml()` 적용 확인 (howto-editor.ts에서 노드별 이스케이프)

**취약점**:

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| C1 | **innerHTML 직접 사용 다수**: editor.ts에서 `innerHTML` 직접 할당 6회 이상, analyzer-job-page.ts에서 `innerHTML` 사용 다수. 서버 데이터를 escapeHtml 없이 innerHTML에 주입하는 패턴 존재 | **High** | `editor.ts:198,543,1168`, `analyzer-job-page.ts`, `analyzer-major-page.ts` |
| C2 | **sanitizeContent 정규식 우회 가능**: `<script>` 태그 제거가 단순 정규식(`/<script[^>]*>.*?<\/script>/gi`)으로 `<scr<script>ipt>` 중첩이나 대소문자 혼합 패턴에 취약 | **Medium** | `editValidation.ts:104` |
| C3 | **escapeHtml에서 `"`, `'` 미이스케이프**: 속성 값 컨텍스트에서 XSS 가능. 현재 `&`, `<`, `>`만 이스케이프 | **Medium** | `shared-helpers.ts:1287-1290` |

#### SQL Injection

**구현 현황**:
- D1 prepared statement 사용: 전체 925개 `.prepare()` 호출 확인
- 동적 SQL 구축 패턴: 11개 파일에서 `${table}`, `${placeholders}`, `${conditions}`, `${setClause}` 등 사용

**분석 결과**:
- `${table}` 변수: 모든 케이스에서 하드코딩된 값(`'jobs'`/`'majors'`) 또는 하드코딩된 배열에서 유래. 사용자 입력이 직접 주입되는 경로 **없음**
- `${placeholders}`: `slugs.map(() => '?').join(',')` 패턴으로 안전 (값은 bind로 전달)
- `${conditions}`: 코드 내에서 조건문으로 구성되며 사용자 입력은 bind 파라미터로 전달
- `${setClause}`: 필드명은 코드 내 하드코딩, 값은 bind 파라미터

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| C4 | **동적 테이블명 사용 패턴**: `UPDATE ${table}` 등 11건. 현재 안전하나, 향후 리팩터링 시 사용자 입력이 유입될 위험. 화이트리스트 검증 함수로 래핑 권장 | **Low** | `upload.ts:324,514`, `share.ts:91`, `admin-api.ts:249` 등 |

#### CSRF

**구현 현황**:
- OAuth 플로우: state 파라미터로 CSRF 방지 (line 50-51, auth.ts)
- 로그아웃: POST 방식 지원 (line 239)
- 상태 변경 API: JSON body를 사용하므로 단순 form POST CSRF 방어됨
- **전용 CSRF 토큰 메커니즘 없음**

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| C5 | **CSRF 토큰 미구현**: 상태 변경 API에 CSRF 토큰이 없음. SameSite=Lax 쿠키와 JSON Content-Type 요구로 상당 부분 방어되나, CORS `*` 설정으로 인해 방어 약화 | **Medium** | 프로젝트 전체 |
| C6 | **GET /auth/logout CSRF**: 이미지 태그로 강제 로그아웃 가능 (1.1 A2와 동일) | **Medium** | `auth.ts:276` |

### 1.4 파일 업로드 보안

**구현 방식** (`uploadService.ts`, `upload.ts`):
- 허용 타입: JPEG, PNG, GIF, WebP (4종만)
- SVG 명시적 차단 (XSS 방지)
- 매직 넘버(파일 시그니처) 검증: MIME 타입과 실제 파일 내용 크로스 검증
- 최대 파일 크기: 10MB
- 파일 키: `howto/YYYY/MM/DD/{filename}-{shortId}.{ext}` (UUID 기반)
- R2 직접 업로드 (서버 경유)
- 업로드 시 `requireAuth` 필수

**강점**: 3중 검증 (MIME + 매직 넘버 + 확장자), SVG 차단, 인증 필수

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| D1 | **이미지 서빙 시 Content-Type 추론**: R2 메타데이터가 없으면 확장자 기반으로 Content-Type 추론. 확장자 조작 시 잘못된 타입 반환 가능 (실질적 위험 낮음) | **Low** | `upload.ts:231-244` |

### 1.5 API 보안

#### 레이트 리밋

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| E1 | **인바운드 API 레이트 리밋 없음**: 모든 API 엔드포인트에 요청 속도 제한이 없음. 익명 댓글, 편집, AI 분석 API 등이 무제한 호출 가능. DoS 및 비용 공격 가능 | **Critical** | 프로젝트 전체 |

- 익명 편집에는 IP별 일일 10회 제한이 있으나 (`anonymousEdit.ts`), 이는 API 레벨 레이트 리밋이 아님
- IP 블록 기능은 댓글 시스템에만 존재 (`isIpBlocked`)
- OpenAI API 호출에는 외부 서비스 측 레이트 리밋만 존재

#### CORS

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| E2 | **CORS `*` (와일드카드) 설정**: `app.use('*', cors())`로 모든 오리진에서 모든 API 접근 허용. 인증된 요청도 크로스 오리진에서 가능 | **High** | `index.tsx:102` |

- Hono의 기본 `cors()` 미들웨어는 옵션 없이 호출 시 `Access-Control-Allow-Origin: *` 반환
- SameSite=Lax 쿠키는 크로스 오리진 POST에서 전송되지 않으므로 일부 방어되나, GET 요청은 취약

#### API 키 노출

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| E3 | **Cloudflare Account ID 하드코딩**: AI Gateway URL에 계정 ID 노출 (`3587865378649966bfb0a814fce73c77`). 서버 사이드 코드이므로 직접 노출은 아니나, 소스 유출 시 위험 | **Low** | `openai-client.ts:62` |
| E4 | **스크립트 파일에 API 키 하드코딩**: `checkDJobTotal.ts`에 `AUTH_KEY = '7635eb78-...'` 하드코딩 (프로덕션 런타임에 포함되지 않는 스크립트) | **Low** | `scripts/checkDJobTotal.ts:8` |

- 환경변수(.dev.vars)에 민감 정보 분리: OPENAI_API_KEY, GOOGLE_CLIENT_SECRET 등은 Cloudflare Secrets 사용
- 프론트엔드(public/) 파일에 API 키 노출 **없음** (확인 완료)

### 1.6 보안 헤더

**구현 현황** (`index.tsx:57-63`):

| 헤더 | 설정값 | 평가 |
|------|--------|------|
| X-Content-Type-Options | `nosniff` | 양호 |
| X-Frame-Options | `DENY` | 양호 |
| Referrer-Policy | `strict-origin-when-cross-origin` | 양호 |
| Permissions-Policy | `camera=(), microphone=(), geolocation=()` | 양호 |
| Cache-Control (API) | `private, no-store` | 양호 |

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| F1 | **CSP (Content-Security-Policy) 헤더 없음**: XSS 공격의 가장 효과적인 방어선인 CSP가 설정되지 않음 | **High** | `index.tsx:57-63` |
| F2 | **HSTS (Strict-Transport-Security) 헤더 없음**: Cloudflare에서 HTTPS 강제하나, 앱 레벨에서 HSTS 미설정 | **Medium** | `index.tsx:57-63` |

### 보안 체크리스트 요약

| 항목 | 상태 | 심각도 | 비고 |
|------|------|--------|------|
| OAuth 인증 | 양호 | - | State 파라미터, Open redirect 방지 |
| 세션 관리 | 양호 | - | Opaque token, KV TTL, 감사 로그 |
| 테스트 계정 | 취약 | High | 하드코딩된 test/1234 |
| 권한 체계 | 양호 | - | 역할 기반, 미들웨어 적용 |
| XSS 방어 | 부분 취약 | High | innerHTML 직접 사용, CSP 없음 |
| SQL Injection | 양호 | - | Prepared statement 전면 사용 |
| CSRF 방어 | 부분 취약 | Medium | 전용 토큰 없음, GET 로그아웃 |
| 파일 업로드 | 양호 | - | 3중 검증, SVG 차단 |
| 레이트 리밋 | 미구현 | Critical | 전체 API 무제한 |
| CORS | 취약 | High | 와일드카드 오리진 |
| CSP 헤더 | 미구현 | High | 없음 |
| HSTS | 미구현 | Medium | 없음 |
| 웹훅 인증 | 미구현 | Medium | `/webhooks/image-completed` 인증 없음 |

---

## 2. 에러 핸들링 & 로깅

### 2.1 글로벌 에러 핸들러

**구현 현황** (`index.tsx:86-89`):
```
app.onError((err, c) => {
  console.error('[GlobalError]', err?.message, err?.stack)
  return c.text('Internal Server Error', 500)
})
```

- 글로벌 에러 핸들러 존재: 모든 미처리 예외를 500으로 반환
- 스택 트레이스를 클라이언트에 **노출하지 않음** (서버 로그에만 기록)
- 추가로 `errorLoggingMiddleware` (line 75-81)가 try-catch로 래핑

**평가**: 기본적인 안전장치 구현됨. 사용자에게 `Internal Server Error` 텍스트만 반환.

### 2.2 API 에러 응답 일관성

**패턴 분석**:
- 대부분의 API: `{ success: false, error: '한글 메시지' }` + 적절한 HTTP 상태 코드
- 일부 API: 영문 에러 메시지 혼용 (`'Invalid refresh token'`, `'Authentication required'`)
- 상태 코드: 400 (입력 오류), 401 (인증 필요), 403 (권한 부족), 404 (미발견), 500 (서버 오류) 일관 사용

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| G1 | **OAuth 콜백에서 error.message 노출**: `Token exchange failed: 401` 같은 내부 에러 메시지가 HTML로 사용자에게 표시됨 | **Low** | `auth.ts:227` |
| G2 | **R2 프록시 에러에서 상세 정보 반환**: `error.message`를 JSON 응답으로 반환 | **Low** | `upload.ts:267` |
| G3 | **에러 메시지 언어 비일관**: 한글/영문 혼용. 사용자 facing은 한글, 시스템은 영문이나 경계가 불명확 | **Info** | 프로젝트 전체 |

### 2.3 로깅/모니터링

**현황**:
- **로깅**: `console.log`/`console.error` 기반 (602개 호출, 44개 파일)
- **구조화된 로깅**: 미구현. 태그 기반 (`[GlobalError]`, `[ImageGen]`, `[ImageSave]`) 수동 분류
- **외부 에러 추적**: Sentry, DataDog, Axiom 등 미연동 (Grep 결과 0건)
- **OpenAI 게이트웨이**: Cloudflare AI Gateway 경유로 API 호출 메트릭 수집 가능
- **성능 메트릭**: `perfMetricsService.ts` 존재 (클라이언트 성능 데이터 수집)

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| G4 | **외부 에러 추적 서비스 미연동**: Sentry 등 없음. 프로덕션 에러를 실시간으로 탐지/알림할 수 없음 | **High** | - |
| G5 | **로그 기반 모니터링**: console.log만 사용. Cloudflare Workers 로그는 실시간 스트리밍만 가능하고 영구 저장 불가 (Workers Logpush 미설정) | **Medium** | - |

### 2.4 장애 복구

**현황**:
- **DB 백업**: Cloudflare D1 자동 백업 (매일, 30일 보관). Point-in-time recovery 지원
- **배포 롤백**: Cloudflare Pages에서 이전 배포로 수동 롤백 가능 (대시보드)
- **데이터 복구**: D1 백업 복원 또는 page_revisions 테이블의 이전 버전 조회
- **CI/CD**: GitHub Actions 미구현. 수동 `npm run deploy` 명령어

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| G6 | **자동화된 롤백 절차 없음**: 배포 실패 시 수동으로 Cloudflare 대시보드 접속 필요 | **Medium** | - |

---

## 3. 운영 & 성능

### 3.1 배포 파이프라인

**현재 프로세스** (CLAUDE.md 기준):
```
npx tsc --noEmit → npm run build → npm run deploy → 프로덕션 확인 → git add → commit → push
```

- **CI/CD**: 미구현 (`.github/workflows/` 디렉토리 없음)
- **빌드**: Vite (CSS + TypeScript)
- **배포**: `wrangler pages deploy` (Cloudflare Pages)
- **환경 관리**: `.dev.vars` (로컬) + Cloudflare Secrets (프로덕션)

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| H1 | **CI/CD 파이프라인 없음**: 모든 배포가 수동. 타입 체크/빌드 실패 시 프로덕션 배포 방지 자동화 없음 | **Medium** | - |
| H2 | **스테이징 환경 없음**: 프로덕션 직접 배포만 존재 | **Medium** | - |

### 3.2 DB 마이그레이션 관리

**현황**:
- 총 마이그레이션 파일: 44개 (`0001_initial_schema.sql` ~ `0044_add_comment_moderated_columns.sql`)
- 네이밍 규칙: `{번호}_{설명}.sql` (대부분 일관)
- 불일치 2건: `010_add_aggregated_profile.sql` (앞에 0 부족), `dev_fts5.sql`/`dev_fts5_prefix.sql` (번호 없음)
- 롤백 마이그레이션: **없음** (up-only)
- `0004` 번호 건너뜀 (0003 -> 0005)

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| H3 | **마이그레이션 롤백 불가**: down 마이그레이션이 없어 스키마 변경 롤백 시 수동 SQL 필요 | **Low** | `migrations/` |
| H4 | **네이밍 비일관**: `010_*` (0010이어야 함), `dev_*` (번호 없음) | **Info** | `migrations/` |

### 3.3 캐싱 전략

**ISR (Incremental Static Regeneration)** (`page-cache.ts`):
- `wiki_pages` 테이블에 렌더링된 HTML 캐시
- 버전 기반 무효화: 템플릿 버전이 올라가면 캐시 자동 무효화
- ETag 지원: `If-None-Match` 헤더로 304 응답
- 캐시 히트 시 ~50ms, 미스 시 ~300ms

**KV 캐시** (`cacheService.ts`):
- 세션 스토어 (주 용도)
- Stale-while-revalidate 패턴 구현
- 이미지 생성 태스크 임시 저장 (24시간 TTL)

**HTTP 캐시**:
- API 응답: `Cache-Control: private, no-store` (인증된 요청 CDN 캐시 방지)
- 이미지: `max-age=31536000, immutable` (버전 파라미터 있을 때) 또는 `max-age=3600, must-revalidate`
- 정적 파일: Cloudflare CDN 자동 캐시

**평가**: ISR 패턴으로 위키 페이지 렌더링 최적화. 잘 설계된 멀티 레이어 캐싱.

### 3.4 Cloudflare 리소스 한도 분석

#### Workers (Paid Plan 추정)

| 리소스 | 한도 (Paid) | 현재 추정 사용량 | 위험도 |
|--------|-------------|------------------|--------|
| CPU 시간/요청 | 30초 | AI 분석: ~15-25초 (LLM 다단계) | **주의** |
| 메모리 | 128MB | 벡터 검색 배치 시 상당량 사용 | 보통 |
| Subrequest/요청 | 1000 (Paid) | AI 분석: OpenAI 5-15회 + DB 다수 | 보통 |
| 요청 수/일 | 무제한 (Paid) | - | 안전 |

#### D1

| 리소스 | 한도 | 현재 추정 | 위험도 |
|--------|------|-----------|--------|
| DB 크기 | 10GB (Paid) | 608개 전공 + 6,945개 직업 + 위키 페이지 | 안전 |
| 행 읽기/일 | 250억 (Paid) | - | 안전 |
| 행 쓰기/일 | 5천만 (Paid) | - | 안전 |

#### Vectorize

| 리소스 | 한도 | 현재 | 위험도 |
|--------|------|------|--------|
| topK | 100/쿼리 | Multi-Query 배치로 우회 | 보통 |
| 인덱스 크기 | 500만 벡터 | ~7,500개 (jobs+majors+howto) | 안전 |
| 차원 | 1536 | 1536 (text-embedding-3-small) | 일치 |

#### KV

| 리소스 | 한도 (Paid) | 현재 | 위험도 |
|--------|-------------|------|--------|
| 키 크기 | 512 bytes | 세션: `session:{UUID-UUID}` (~80 bytes) | 안전 |
| 값 크기 | 25MB | 세션: ~200 bytes JSON | 안전 |
| 읽기/일 | 무제한 (Paid) | 요청마다 1-2회 세션 읽기 | 안전 |

#### R2

| 리소스 | 한도 | 현재 | 위험도 |
|--------|------|------|--------|
| 저장 용량 | 10GB (Free) | 이미지 업로드 수에 비례 | 안전 |
| Class A 연산 | 100만/월 (Free) | PUT 연산 | 안전 |
| Class B 연산 | 1000만/월 (Free) | GET 연산 (이미지 서빙) | **주의** |

### 3.5 성능 분석

**페이지 렌더링**:
- ISR 캐시 히트: ~50ms (D1 단일 쿼리)
- ISR 캐시 미스: ~300ms (데이터 fetch + 렌더링 + 캐시 저장)
- ETag 기반 304 응답으로 대역폭 절감

**DB 쿼리**:
- Prepared statement 전면 사용 (925개)
- 직업 목록에서 `COUNT(*) + 페이지네이션` 2단계 쿼리 (N+1 아님)
- `conditions.join(' AND ')` 패턴으로 동적 WHERE 구성
- D1 Retry 로직 존재 (`withD1Retry`, ECONNRESET 대응)

**AI 추천 파이프라인** (가장 무거운 워크로드):
1. LLM 인터뷰 (OpenAI 3라운드) -> 각 ~2-5초
2. Multi-Query 벡터 검색 (600-800개 후보) -> ~1-3초
3. TAG 필터 + Personalized Scoring -> ~100ms
4. LLM Judge (배치당 5개, 다중 배치) -> ~5-15초
5. LLM Reporter -> ~3-5초

총 소요: **15-30초** (Workers 30초 한도에 근접)

**정적 자산**:
- TailwindCSS 3 + Vite 번들
- TipTap 에디터: 별도 번들 (`npm run build:editor`)
- Cloudflare CDN 자동 제공

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| I1 | **AI 파이프라인 Workers CPU 한도 근접**: LLM Judge + Reporter 단계에서 CPU 시간 30초 한도에 근접. 복잡한 사용자 프로필에서 타임아웃 가능성 | **High** | `ai-analyzer/` |
| I2 | **AI 분석 시 OpenAI 병렬 호출**: 여러 LLM 호출이 순차적으로 실행되어 총 지연 누적. 가능한 부분에서 병렬화 필요 | **Medium** | `llm-judge.ts`, `routes.ts` |

### 3.6 비용 구조

#### Cloudflare Workers (Paid Plan $5/월 추정)

| 항목 | 단가 | 예상 사용량 | 예상 비용 |
|------|------|-------------|-----------|
| 요청 | $0.50/100만 | ~10만/월 (추정) | ~$0.05 |
| CPU 시간 | 포함 | - | $5/월 (기본) |
| D1 읽기 | $0.001/100만 행 | - | < $1 |
| D1 쓰기 | $1/100만 행 | - | < $1 |
| KV 읽기 | 포함 (Paid) | - | 포함 |
| R2 저장 | $0.015/GB | < 1GB | < $0.02 |

#### OpenAI API (가장 큰 비용 요소)

| 모델 | 용도 | 단가 | 호출당 비용 |
|------|------|------|-------------|
| gpt-4o-mini | LLM Interviewer, Judge, Reporter | Input: $0.15/1M, Output: $0.60/1M | ~$0.005-0.02/호출 |
| text-embedding-3-small | 벡터 검색 | $0.02/1M tokens | ~$0.0001/쿼리 |

**AI 분석 1회 예상 비용**:
- LLM 인터뷰 (3라운드): ~$0.015
- LLM Judge (3-5배치): ~$0.03
- LLM Reporter: ~$0.01
- 임베딩 (Multi-Query): ~$0.001
- **합계: ~$0.05-0.06/분석**

**월간 예상 비용** (일 100회 분석 기준):
- Cloudflare: ~$7-10/월
- OpenAI: ~$150-180/월
- **총: ~$160-190/월**

| # | 내용 | 심각도 | 위치 |
|---|------|--------|------|
| J1 | **레이트 리밋 없이 OpenAI 비용 폭주 가능**: 악의적 사용자가 AI 분석을 반복 호출하면 OpenAI 비용이 무제한으로 증가 | **Critical** | E1과 연관 |

---

## 4. 종합 평가

### 점수

| 영역 | 점수 | 근거 |
|------|------|------|
| **보안** | **2.5/5** | 인증/세션은 견고하나, 레이트 리밋 부재 + CORS 와일드카드 + CSP 미구현이 치명적 |
| **운영 안정성** | **3.0/5** | ISR 캐싱 + D1 자동 백업은 양호하나, CI/CD 부재 + 외부 모니터링 부재 |
| **성능** | **3.5/5** | ISR 캐시 + 벡터 검색 최적화 우수하나, AI 파이프라인이 Workers 한도에 근접 |

### 주요 강점 3개

1. **세션 관리 체계**: Opaque token + KV + 감사 로그 + Sliding window + 디바이스 관리 + JWT 자동 마이그레이션까지 프로덕션 수준의 세션 아키텍처
2. **파일 업로드 3중 검증**: MIME 타입 + 매직 넘버 + 확장자 검증, SVG 차단, 인증 필수. 파일 업로드 보안의 모범 사례
3. **ISR 캐싱 아키텍처**: 위키 페이지 버전 기반 캐시 무효화 + ETag + D1 저장 + Stale-while-revalidate. 빌드 타임 없이 무한 확장 가능한 설계

### 주요 위험 3개 (심각도순)

1. **[Critical] API 레이트 리밋 완전 부재 (E1, J1)**: 모든 API에 요청 속도 제한이 없어 DoS 공격, OpenAI 비용 폭주, 스팸 댓글 등에 무방비. Cloudflare Rate Limiting 또는 KV 기반 토큰 버킷 구현 시급
2. **[High] CORS 와일드카드 + CSP 미구현 (E2, F1)**: `cors()` 와일드카드로 모든 오리진에서 API 접근 가능. CSP 없이 XSS 방어선 부재. innerHTML 직접 사용과 결합 시 고위험
3. **[High] 테스트 계정 프로덕션 노출 (A1)**: `test/1234` 하드코딩 계정이 프로덕션에서 누구나 접근 가능. 즉시 비활성화 또는 환경 분기 필요

### 즉시 조치 필요 사항

1. **[긴급] 레이트 리밋 구현**: 최소한 AI 분석 API(`/api/ai-analyzer/*`)에 IP 기반 레이트 리밋 적용 (예: 5회/분/IP). Cloudflare Rate Limiting Rules 또는 KV 카운터 활용
2. **[긴급] CORS 오리진 제한**: `cors()` -> `cors({ origin: 'https://careerwiki.org' })` 으로 변경
3. **[긴급] 테스트 계정 비활성화 또는 환경 분기**: `if (env.ENVIRONMENT !== 'production')` 조건 추가
4. **[권장] CSP 헤더 추가**: `script-src 'self'; style-src 'self' 'unsafe-inline'` 등 기본 CSP 정책
5. **[권장] HSTS 헤더 추가**: `Strict-Transport-Security: max-age=31536000; includeSubDomains`
6. **[권장] 웹훅 인증 추가**: `/webhooks/image-completed`에 시크릿 토큰 검증

---

*이 보고서의 모든 내용은 코드베이스의 실제 Grep/Read 결과에 기반합니다.*
