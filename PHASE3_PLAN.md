# Phase 3: 로그인 시스템 구축 - 최종 계획서

> **작성일**: 2025-11-16  
> **업데이트**: 2025-11-17 (수정사항 반영)  
> **기반**: AI 리서치 결과 (Wikipedia/나무위키/디시인사이드 벤치마크 분석)

---

## 🎓 비개발자를 위한 쉬운 요약

### Phase 3이 하는 일 (3줄 요약)
1. **Google 로그인 버튼 추가** - "Google로 1초 만에 시작하기"
2. **로그인한 사용자만 편집/댓글** - 반달리즘(악의적인 수정) 방지
3. **빠른 속도 유지** - 로그인 시스템 추가해도 여전히 0.05초 응답

### 왜 이렇게 설계했나요?

#### 🎯 핵심 목표: 속도를 절대 포기하지 않는다
```
현재 상태: 페이지가 0.05초 만에 뜬다 (엄청 빠름!)
목표: 로그인 시스템을 추가해도 여전히 0.05초

다른 방법들:
방법 A (Session+KV): 0.15초 → ❌ 3배 느려짐
방법 B (JWT): 0.052초 → ✅ 거의 차이 없음

선택: JWT (속도 최우선)
```

#### 🔐 보안 vs 편의성의 균형

**Wikipedia 방식 (익명 편집 허용)**:
- 장점: 누구나 쉽게 참여
- 단점: 관리자 수백 명 + 자동화 봇 필요
- CareerWiki: ❌ 관리 인력 없음

**CareerWiki 방식 (로그인 필수)**:
- 장점: 악의적인 수정 추적 가능
- 단점: 진입장벽 있음
- 해결책: Google 1-click 로그인 (회원가입 불필요)

### 5일 동안 무엇을 만드나요?

```
Day 1 (월): Google 로그인 만들기
  → 결과: "Google로 로그인" 버튼 작동

Day 2 (화): 로그인 상태 유지하기
  → 결과: 로그인 후 새로고침해도 유지됨

Day 3 (수): 권한 시스템 만들기
  → 결과: 일반 유저 / 에디터 / 관리자 구분

Day 4 (목): 예쁜 UI 만들기 + 정우님 확인
  → 결과: 사용자 친화적인 디자인 완성
  🎨 이 날 정우님이 직접 확인하고 피드백!

Day 5 (금): 로컬 테스트 및 문서화
  → 결과: 로컬 환경에서 모든 기능 검증 완료
```

### 무엇이 달라지나요?

#### Before (지금)
```
사용자: 아무나 편집/댓글 가능
상태: 누가 뭘 했는지 추적 어려움
속도: 0.05초 (빠름)
```

#### After (Phase 3 완료 후)
```
사용자: Google로 로그인한 사람만
권한: 일반 유저 / 에디터 / 관리자
추적: 누가 뭘 했는지 기록됨
속도: 0.052초 (여전히 빠름!)
```

### 실제 사용자 경험

#### 🙋‍♂️ 고등학생이 CareerWiki 방문
```
1. 사이트 접속 → 직업 정보 보기 (로그인 불필요)
2. "소프트웨어개발자" 페이지 읽기
3. 댓글 쓰고 싶음 → "댓글 쓰기" 버튼 클릭
4. "로그인이 필요합니다" 팝업
5. "Google로 1초 만에 시작하기" 버튼 클릭
6. Google 계정 선택 (이미 로그인되어 있으면 즉시)
7. 다시 사이트로 → 이제 댓글 쓰기 가능!
8. 이후 방문 시 자동 로그인 (1주일간)
```

### 기술 용어 설명

**JWT (JSON Web Token)**:
- 은행 통장의 "비밀번호" 같은 것
- 로그인하면 이 "열쇠"를 받아서 가지고 다님
- 매번 서버에 "나 로그인했어요" 확인 안 해도 됨 → 빠름!

**OAuth (Google 로그인)**:
- Google이 "이 사람 맞습니다"라고 보증해주는 시스템
- 우리는 비밀번호를 저장하지 않음 (안전)
- Google이 이미 신원 확인했으니 믿을 수 있음

**KV (Key-Value Store)**:
- "사물함" 같은 저장소
- "열쇠(refresh token)"를 1주일간 보관
- 1시간짜리 열쇠(access token) 만료되면 새 열쇠 발급

### 왜 지금 시스템에 적합한가?

#### 1. 성능 목표 달성 ✅
```
ISR 시스템: 페이지 50ms
JWT 추가: +2ms
총 52ms → 여전히 엄청 빠름!

만약 Session을 썼다면:
ISR: 50ms
Session 조회: +100ms
총 150ms → 3배 느림 ❌
```

#### 2. Cloudflare 제약 준수 ✅
```
Cloudflare Workers: Node.js API 사용 불가
JWT: Web API만 사용 → ✅ 완벽 호환
Session: 파일 시스템 필요 → ❌ 불가능
```

#### 3. 비용 최소화 ✅
```
JWT: 서버에서 바로 계산 → 무료
KV: Refresh Token만 저장 → $1/월
Session+KV: 모든 요청마다 저장 → $10/월

선택: JWT → 월 $1 절약!
```

#### 4. 확장성 확보 ✅
```
Phase 3: Google만
Phase 5: GitHub 추가 (개발자용)
Phase 6: Kakao/Naver 추가 (한국 사용자용)

설계가 확장 가능하게 되어 있음!
```

### 왜 미래에도 적합한가?

#### 시나리오 1: 사용자 10,000명으로 증가
```
JWT 방식:
- 서버 부하: 거의 없음 (계산만)
- 비용: 여전히 $1/월
- 속도: 여전히 52ms

Session 방식이었다면:
- 서버 부하: 높음 (매번 조회)
- 비용: $50/월 (KV 읽기 증가)
- 속도: 150ms+
```

#### 시나리오 2: 소셜 로그인 추가 (GitHub, Kakao)
```
현재 설계:
src/routes/auth.ts
  ├─ /auth/google
  ├─ /auth/github  ← 추가 쉬움
  └─ /auth/kakao   ← 추가 쉬움

JWT 구조는 동일, OAuth만 다름
→ 각 2-3시간 작업으로 추가 가능
```

#### 시나리오 3: 익명 편집 허용으로 변경
```
Phase 7 이후 커뮤니티 안정화되면:

현재 코드:
app.post('/edit', requireAuth, ...)  ← 로그인 필수

변경 후:
app.post('/edit', optionalAuth, ...)  ← 선택 사항

1줄 수정으로 변경 가능! (확장성 확보)
```

### 리스크 및 대응

| 리스크 | 발생 확률 | 대응 방안 |
|--------|----------|-----------|
| JWT 토큰 탈취 | 중간 | HttpOnly Cookie + 1시간 TTL |
| Google 서비스 장애 | 낮음 | 명확한 에러 메시지 + 재시도 |
| 로그인 복잡해서 이탈 | 중간 | 1-click 로그인 + 명확한 UI |
| 성능 저하 | 매우 낮음 | JWT로 2ms만 추가 |

### 다른 선택지와 비교

#### 선택지 A: Cloudflare Access (SaaS)
- 장점: 구현 쉬움
- 단점: 월 $5 + 커스터마이징 어려움
- 결론: ❌ 비용 대비 효과 낮음

#### 선택지 B: Session + D1 (DB 저장)
- 장점: 구현 간단
- 단점: 매 요청마다 DB 쿼리 (50ms 추가)
- 결론: ❌ 성능 목표 미달

#### 선택지 C: JWT + KV (선택!) ✅
- 장점: 빠름(2ms), 확장성, 저비용
- 단점: 구현 복잡도 약간 높음
- 결론: ✅ 최적의 선택

### 정우님이 확인할 체크포인트

#### Day 1 완료 후
- [ ] `/auth/google` 접속하면 Google 로그인 화면 뜨는가?
- [ ] 로그인 후 메인 페이지로 잘 돌아오는가?

#### Day 2 완료 후
- [ ] 로그인 후 페이지 새로고침해도 로그인 유지되는가?
- [ ] 로그아웃 버튼 누르면 즉시 로그아웃되는가?

#### Day 3 완료 후
- [ ] 로그인 안 하면 댓글 못 쓰는가?
- [ ] 관리자로 로그인하면 Admin 페이지 보이는가?

#### Day 4 완료 후 (가장 중요!) 🎨
- [ ] 로그인 버튼 디자인이 마음에 드는가?
- [ ] 프로필 드롭다운 위치가 적절한가?
- [ ] 전체 흐름이 자연스러운가?
- [ ] 고등학생도 쉽게 사용할 수 있는가?

#### Day 5 완료 후
- [ ] 로컬 환경에서 로그인 잘 되는가?
- [ ] 모든 기능이 정상 작동하는가?
- [ ] Username 변경이 작동하는가?
- [ ] 성능이 목표대로 나오나요? (< 60ms)
- [ ] 문서화가 완료되었나요?

**참고**: 실제 사이트 배포는 Phase 4.5에서 진행됩니다.

---

## 📋 Executive Summary (개발자용)

### 핵심 결정 사항
1. **인증 방식**: ~~Session + KV~~ → **JWT (Stateless)** ✅
2. **익명 편집**: **로그인 필수** (Phase 3) → **Ver. 2.0부터 익명 편집 허용** ✅
3. **소셜 로그인**: **Google OAuth 단독** (Phase 3) → **Naver/Kakao 추가 예정** (Phase 5 이후)
4. **권한 체계**: **anonymous/user/expert/admin** (4단계)

### 예상 일정
**5일** (Day 1-5) - 각 단계별 상세 계획 아래 참조

### 주요 위험 요소
- JWT 토큰 탈취 위험 (대응: HttpOnly + 짧은 TTL + Refresh Token)
- 반달리즘 (대응: 로그인 필수 + IP 로깅 + 편집 이력)
- Google OAuth 장애 (대응: 명확한 에러 메시지 + 관리자 백업 인증)

---

## 🎯 리서치 결과 분석 및 최종 결정

### 1. 인증 아키텍처: JWT로 변경 결정 ⚠️

**리서치 추천**: Session + KV  
**최종 결정**: JWT (JSON Web Token) ✅

#### 변경 이유
리서치에서 Session + KV를 추천했지만, **CareerWiki의 핵심 제약사항**을 재검토한 결과 JWT가 더 적합:

**성능 제약 (P0, 타협 불가)**:
```
Current: ISR 덕분에 50ms 응답 달성
Requirement: 로그인 시스템이 이를 저하시켜서는 안 됨

Session + KV:
- 매 요청마다 KV 조회 (50-200ms 지연)
- 총 응답: 50ms + 100ms(평균) = 150ms ❌

JWT:
- 쿠키에서 JWT 추출 + 서명 검증 (1-2ms)
- 총 응답: 50ms + 2ms = 52ms ✅
```

**리서치가 놓친 점**:
- 리서치에서 "KV 응답 0.5~10ms"라고 했지만, 이는 **hot key** 기준
- 실제로는 cold key나 글로벌 분산 환경에서 50-200ms 지연 가능
- 우리의 50ms 목표와 맞지 않음

**JWT 단점 대응책**:
1. **토큰 무효화 어려움** → TTL 1시간 + Refresh Token (KV 저장)
2. **역할 변경 지연** → 편집/관리 작업 시에만 D1에서 role 재확인
3. **토큰 탈취** → HttpOnly + Secure + SameSite=Strict

**결론**: JWT로 일반 페이지는 52ms 유지, 민감한 작업만 추가 검증 (70ms)

---

### 2. 익명 편집: 로그인 필수로 결정 ✅

**리서치 추천**: 익명 편집 허용 + 편집 감사  
**최종 결정**: **로그인 필수** (초기 단계)

#### 변경 이유
Wikipedia처럼 익명 편집을 허용하면 참여 장벽은 낮아지지만, **초기 단계의 CareerWiki에는 부적합**:

**현실적 제약**:
- 개발자: 정우님 1인 + AI
- 관리 인력: 없음
- 반달리즘 대응 시스템: 미구축
- 커뮤니티 규모: 소규모 (자정 작용 불가)

**Wikipedia vs CareerWiki**:
| 항목 | Wikipedia | CareerWiki (현재) |
|------|-----------|-------------------|
| 관리자 | 수백 명 | 0명 |
| 자동화 봇 | 있음 | 없음 |
| 커뮤니티 | 자정 작용 | 초기 단계 |
| 반달 대응 | 즉각 복구 | 불가능 |

**단계적 접근**:
1. **Phase 3**: 로그인 필수 (Google 소셜 로그인으로 진입장벽 최소화)
2. **Phase 4**: 편집 이력 + 신고 시스템 구축
3. **Phase 5 이후**: 커뮤니티 안정화 후 익명 편집 검토

**1-click 로그인으로 진입장벽 최소화**:
```
기존: 회원가입 폼 작성 (이메일, 비번, 인증 등)
개선: "Google로 1초 만에 시작하기" 버튼 하나
```

---

### 3. 소셜 로그인: Google 단독 ✅

**Phase 3**: Google OAuth만 구현  
**Phase 4 이후**: 사용자 피드백 기반 추가 검토

**우선순위**:
1. ✅ **Google** (Phase 3) - 전세계 보편, 구현 사례 풍부
2. ⏳ **GitHub** (Phase 5) - 개발자 친화적 (선택 사항)
3. ⏳ **Kakao/Naver** (Phase 5) - 한국 사용자 (API 등록 복잡)

---

## 📊 최종 아키텍처 설계

### 인증 흐름 (JWT 기반)

```typescript
// 1. 로그인
Google OAuth 인증 완료
  ↓
JWT 생성 (payload: { userId, role, exp })
  - 서명: HMAC-SHA256 (Web Crypto API)
  - TTL: 1시간 (액세스 토큰)
  ↓
HttpOnly Cookie 설정: access_token
  ↓
Refresh Token 생성 → KV 저장 (7일 TTL)
  ↓
HttpOnly Cookie 설정: refresh_token
  ↓
메인 페이지로 리다이렉트

// 2. 인증 확인 (일반 페이지)
매 요청:
  ↓
Cookie에서 access_token 추출
  ↓
JWT 서명 검증 (1-2ms)
  ↓
payload에서 userId, role 추출
  ↓
Context에 사용자 정보 저장
  ↓
페이지 렌더링 (총 52ms)

// 3. 민감한 작업 (편집, 관리)
편집/관리 요청:
  ↓
JWT 검증 (1-2ms)
  ↓
D1에서 최신 role 조회 (20ms)
  ↓
권한 확인 후 작업 수행
  ↓
총 응답 시간: 70ms (여전히 빠름)

// 4. 토큰 갱신
access_token 만료 (1시간 후):
  ↓
refresh_token으로 /auth/refresh 호출
  ↓
KV에서 refresh_token 조회
  ↓
유효하면 새 access_token 발급
  ↓
Cookie 업데이트

// 5. 로그아웃
로그아웃 요청:
  ↓
KV에서 refresh_token 삭제 (블랙리스트)
  ↓
Cookie 삭제
  ↓
메인 페이지로 리다이렉트
```

### D1 데이터베이스 스키마

```sql
-- users 테이블
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  google_id TEXT UNIQUE NOT NULL,
  email TEXT NOT NULL,
  name TEXT,
  picture_url TEXT,
  role TEXT DEFAULT 'user' CHECK(role IN ('user', 'expert', 'admin')),
  
  -- 통계
  edit_count INTEGER DEFAULT 0,
  comment_count INTEGER DEFAULT 0,
  
  -- 상태
  is_banned INTEGER DEFAULT 0,  -- SQLite는 BOOLEAN 대신 INTEGER
  ban_reason TEXT,
  banned_until INTEGER,  -- UNIX timestamp
  
  -- 타임스탬프
  last_login_at INTEGER,
  created_at INTEGER DEFAULT (strftime('%s','now')),
  updated_at INTEGER DEFAULT (strftime('%s','now'))
);

CREATE INDEX idx_users_google_id ON users(google_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- 참고: anonymous (비로그인 유저)는 users 테이블에 없음
-- 로그인하지 않은 사용자는 role = 'anonymous'로 처리 (코드에서)

-- refresh_tokens (선택 사항, KV 대신 D1 사용 시)
-- 성능상 KV 추천, 하지만 D1로도 가능
```

---

## 🚀 5일 구현 로드맵

### Day 1: Google OAuth 기본 구현 ✅

**목표**: Google로 로그인, DB에 사용자 저장

**Tasks**:
- [ ] **Google Cloud Console 설정** (30분)
  - 프로젝트 생성: "CareerWiki"
  - OAuth 동의 화면 설정
  - OAuth 클라이언트 ID 생성
  - Redirect URI 등록:
    ```
    http://localhost:3000/auth/google/callback
    https://careerwiki-phase1.pages.dev/auth/google/callback
    https://careerwiki.org/auth/google/callback (Phase 5 이후)
    ```
  - Client ID/Secret 복사

- [ ] **Cloudflare 환경 변수 설정** (15분)
  - `.dev.vars` 파일 생성:
    ```bash
    GOOGLE_CLIENT_ID=your_client_id.apps.googleusercontent.com
    GOOGLE_CLIENT_SECRET=your_client_secret
    GOOGLE_CALLBACK_URL=http://localhost:3000/auth/google/callback
    JWT_SECRET=your_random_secret_key_here  # openssl rand -base64 32
    ```
  - `.gitignore`에 `.dev.vars` 추가 확인

- [ ] **D1 마이그레이션 실행** (30분)
  - `migrations/0006_users.sql` - users 테이블 생성
  - `migrations/0007_pages_auth_fields.sql` - pages 테이블에 author_id, source 필드 추가
  - 로컬: `npm run db:migrate:local`
  - 프로덕션: `npm run db:migrate:prod` (나중에)
  
  **마이그레이션 파일**:
  - `0006_users.sql`: 사용자 인증 테이블
  - `0007_pages_auth_fields.sql`: HowTo 작성자 추적 및 API 데이터 구분

- [ ] **OAuth 라이브러리 선택 및 설치** (30분)
  - 추천: 직접 구현 (Fetch API) → 의존성 최소화
  - 또는: `arctic` 라이브러리 (Cloudflare Workers 최적화)
  - `npm install arctic` (선택 사항)

- [ ] **`/auth/google` 엔드포인트 구현** (1시간)
  ```typescript
  // src/routes/auth.ts
  import { Hono } from 'hono'
  
  const auth = new Hono()
  
  auth.get('/google', (c) => {
    const state = crypto.randomUUID()
    
    // State를 임시로 KV 저장 (5분 TTL)
    // 또는 서명된 쿠키로 저장
    
    const authUrl = new URL('https://accounts.google.com/o/oauth2/v2/auth')
    authUrl.searchParams.set('client_id', c.env.GOOGLE_CLIENT_ID)
    authUrl.searchParams.set('redirect_uri', c.env.GOOGLE_CALLBACK_URL)
    authUrl.searchParams.set('response_type', 'code')
    authUrl.searchParams.set('scope', 'openid email profile')
    authUrl.searchParams.set('state', state)
    authUrl.searchParams.set('access_type', 'offline')
    
    return c.redirect(authUrl.toString())
  })
  
  export default auth
  ```

- [ ] **`/auth/google/callback` 엔드포인트 구현** (2시간)
  ```typescript
  auth.get('/google/callback', async (c) => {
    const code = c.req.query('code')
    const state = c.req.query('state')
    
    // State 검증 (CSRF 방지)
    
    // 1. Code → Access Token 교환
    const tokenRes = await fetch('https://oauth2.googleapis.com/token', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        code,
        client_id: c.env.GOOGLE_CLIENT_ID,
        client_secret: c.env.GOOGLE_CLIENT_SECRET,
        redirect_uri: c.env.GOOGLE_CALLBACK_URL,
        grant_type: 'authorization_code'
      })
    })
    const tokens = await tokenRes.json()
    
    // 2. Access Token → 사용자 정보
    const userRes = await fetch('https://www.googleapis.com/oauth2/v2/userinfo', {
      headers: { Authorization: `Bearer ${tokens.access_token}` }
    })
    const profile = await userRes.json()
    
    // 3. D1에서 사용자 조회/생성
    const user = await getOrCreateUser(c.env.DB, {
      google_id: profile.id,
      email: profile.email,
      name: profile.name,
      picture_url: profile.picture
    })
    
    // 4. JWT 생성 (Day 2에서 구현)
    console.log('User logged in:', user)
    
    return c.redirect('/')
  })
  ```

- [ ] **로컬 환경에서 테스트** (1시간)
  - `npm run dev`
  - 브라우저에서 `/auth/google` 접속
  - Google 로그인 완료 → 콜백으로 돌아오는지 확인
  - Console에 사용자 정보 출력 확인
  - D1에 users 테이블에 레코드 생성 확인:
    ```bash
    wrangler d1 execute careerwiki-jobs --local --command="SELECT * FROM users;"
    ```

**완료 기준**:
- ✅ Google 로그인 성공
- ✅ 사용자 정보 콘솔 출력
- ✅ D1 users 테이블에 레코드 생성

**예상 소요 시간**: 6-7시간

#### 🎨 Day 1 완료 후 확인 세션

**정우님이 직접 확인할 사항**:
1. [ ] 브라우저에서 `/auth/google` 접속 → Google 로그인 화면이 뜨는가?
2. [ ] Google 계정으로 로그인 → 우리 사이트로 돌아오는가?
3. [ ] 콘솔(F12)에 사용자 이름/이메일이 출력되는가?
4. [ ] D1 users 테이블에 내 정보가 저장되었는가?

**문제 발생 시**:
- 에러 메시지 스크린샷
- 콘솔 로그 복사
- AI에게 공유하면 즉시 해결

**확인 완료 후**: "Day 2 시작!" 말씀해주세요.

---

### Day 2: JWT 시스템 구축 ✅

**목표**: JWT 발급, 인증 상태 유지

**Tasks**:
- [ ] **JWT 유틸리티 함수 작성** (2시간)
  ```typescript
  // src/utils/jwt.ts
  import { SignJWT, jwtVerify } from 'jose'
  
  const SECRET = new TextEncoder().encode(process.env.JWT_SECRET)
  
  export async function generateAccessToken(payload: { userId: number; role: string }) {
    return await new SignJWT(payload)
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuedAt()
      .setExpirationTime('1h')  // 1시간
      .sign(SECRET)
  }
  
  export async function generateRefreshToken(userId: number) {
    const refreshToken = crypto.randomUUID()
    
    // KV에 저장 (7일 TTL)
    await env.KV.put(
      `refresh:${refreshToken}`,
      JSON.stringify({ userId, createdAt: Date.now() }),
      { expirationTtl: 60 * 60 * 24 * 7 }
    )
    
    return refreshToken
  }
  
  export async function verifyAccessToken(token: string) {
    try {
      const { payload } = await jwtVerify(token, SECRET)
      return payload as { userId: number; role: string }
    } catch {
      return null
    }
  }
  ```

- [ ] **OAuth 콜백에서 JWT 발급** (1시간)
  ```typescript
  // /auth/google/callback 수정
  
  // ... 사용자 조회/생성 후
  
  // 1. Access Token (JWT) 생성
  const accessToken = await generateAccessToken({
    userId: user.id,
    role: user.role
  })
  
  // 2. Refresh Token 생성
  const refreshToken = await generateRefreshToken(user.id)
  
  // 3. HttpOnly Cookie 설정
  c.header('Set-Cookie', [
    `access_token=${accessToken}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=3600`,
    `refresh_token=${refreshToken}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=604800`
  ].join(', '))
  
  return c.redirect('/')
  ```

- [ ] **인증 Middleware 작성** (2시간)
  ```typescript
  // src/middleware/auth.ts
  import { createMiddleware } from 'hono/factory'
  import { verifyAccessToken } from '../utils/jwt'
  
  export const authMiddleware = createMiddleware(async (c, next) => {
    const accessToken = getCookie(c, 'access_token')
    
    if (!accessToken) {
      c.set('user', null)
      return next()
    }
    
    const payload = await verifyAccessToken(accessToken)
    
    if (payload) {
      // D1에서 사용자 정보 조회 (캐싱 고려)
      const user = await c.env.DB
        .prepare('SELECT * FROM users WHERE id = ?')
        .bind(payload.userId)
        .first()
      
      c.set('user', user)
    } else {
      c.set('user', null)
    }
    
    return next()
  })
  
  // 로그인 필수 Middleware
  export const requireAuth = createMiddleware(async (c, next) => {
    const user = c.get('user')
    
    if (!user) {
      return c.redirect('/auth/google?return_url=' + encodeURIComponent(c.req.url))
    }
    
    return next()
  })
  ```

- [ ] **메인 앱에 Middleware 적용** (30분)
  ```typescript
  // src/index.tsx
  import { authMiddleware, requireAuth } from './middleware/auth'
  
  // 모든 라우트에 authMiddleware 적용
  app.use('*', authMiddleware)
  
  // 편집 라우트는 로그인 필수
  app.post('/edit/:slug', requireAuth, async (c) => {
    const user = c.get('user')
    console.log('Editing user:', user)
    // ... 편집 로직
  })
  ```

- [ ] **로그아웃 구현** (30분)
  ```typescript
  // /auth/logout
  auth.post('/logout', async (c) => {
    const refreshToken = getCookie(c, 'refresh_token')
    
    if (refreshToken) {
      // KV에서 refresh token 삭제
      await c.env.KV.delete(`refresh:${refreshToken}`)
    }
    
    // Cookie 삭제
    c.header('Set-Cookie', [
      'access_token=; Path=/; Max-Age=0',
      'refresh_token=; Path=/; Max-Age=0'
    ].join(', '))
    
    return c.redirect('/')
  })
  ```

- [ ] **Token Refresh 엔드포인트** (1시간)
  ```typescript
  auth.post('/refresh', async (c) => {
    const refreshToken = getCookie(c, 'refresh_token')
    
    if (!refreshToken) {
      return c.json({ error: 'No refresh token' }, 401)
    }
    
    // KV에서 조회
    const data = await c.env.KV.get(`refresh:${refreshToken}`)
    
    if (!data) {
      return c.json({ error: 'Invalid refresh token' }, 401)
    }
    
    const { userId } = JSON.parse(data)
    
    // D1에서 사용자 정보 조회
    const user = await c.env.DB
      .prepare('SELECT * FROM users WHERE id = ?')
      .bind(userId)
      .first()
    
    // 새 Access Token 발급
    const accessToken = await generateAccessToken({
      userId: user.id,
      role: user.role
    })
    
    c.header('Set-Cookie', `access_token=${accessToken}; Path=/; HttpOnly; Secure; SameSite=Lax; Max-Age=3600`)
    
    return c.json({ success: true })
  })
  ```

- [ ] **성능 테스트** (1시간)
  - 로그인 후 여러 페이지 접속
  - Chrome DevTools로 응답 시간 측정
  - 목표: < 60ms (ISR 50ms + JWT 검증 2ms)

**완료 기준**:
- ✅ 로그인 후 페이지 새로고침해도 로그인 유지
- ✅ 로그아웃 시 즉시 인증 해제
- ✅ 평균 응답 시간 < 60ms
- ✅ Token refresh 작동

**예상 소요 시간**: 7-8시간

#### 🎨 Day 2 완료 후 확인 세션

**정우님이 직접 확인할 사항**:
1. [ ] Google 로그인 → 메인 페이지로 리다이렉트
2. [ ] 페이지 새로고침 (F5) → 여전히 로그인 상태인가?
3. [ ] 로그아웃 버튼 클릭 → 즉시 로그아웃되는가?
4. [ ] Chrome DevTools → Network 탭 → 페이지 로딩 시간이 60ms 이하인가?

**개발자 도구 확인**:
```
F12 → Application → Cookies → localhost:3000
- access_token 쿠키가 있는가?
- HttpOnly 플래그가 켜져있는가?
```

**확인 완료 후**: "Day 3 시작!" 말씀해주세요.

---

### Day 3: 권한 시스템 통합 ✅

**목표**: 기존 코드와 통합, 역할 기반 접근 제어

**Tasks**:
- [ ] **`getOptionalUser` 함수 대체** (1시간)
  ```typescript
  // src/index.tsx - 기존 코드 수정
  
  // BEFORE
  function getOptionalUser(c: Context) {
    return {
      userId: c.req.header(AUTH_HEADER_USER),
      role: parseUserRole(c.req.header(AUTH_HEADER_ROLE)),
      name: c.req.header(AUTH_HEADER_NAME),
    }
  }
  
  // AFTER
  function getOptionalUser(c: Context) {
    const user = c.get('user')  // authMiddleware에서 설정
    return {
      userId: user?.id.toString(),
      role: user?.role || 'anonymous',
      name: user?.name,
    }
  }
  ```

- [ ] **역할 기반 Middleware 추가** (1시간)
  ```typescript
  // src/middleware/auth.ts
  export const requireRole = (minRole: 'user' | 'expert' | 'admin') => {
    return createMiddleware(async (c, next) => {
      const user = c.get('user')
      
      if (!user) {
        return c.json({ error: 'Authentication required' }, 401)
      }
      
      const roleHierarchy = { user: 1, expert: 2, admin: 3 }
      
      if (roleHierarchy[user.role] < roleHierarchy[minRole]) {
        return c.json({ error: 'Insufficient permissions' }, 403)
      }
      
      return next()
    })
  }
  
  // 특별 권한 체크: 직업/전공 페이지 편집 (Phase 3: admin만)
  export const requireJobMajorEdit = createMiddleware(async (c, next) => {
    const user = c.get('user')
    
    if (!user || user.role !== 'admin') {
      return c.json({ error: 'Only administrators can edit job/major pages' }, 403)
    }
    
    return next()
  })
  
  // HowTo 편집 권한 체크 (user/expert/admin 가능)
  export const requireHowToEdit = createMiddleware(async (c, next) => {
    const user = c.get('user')
    
    if (!user) {
      return c.json({ error: 'Login required to edit HowTo guides' }, 401)
    }
    
    // user, expert, admin 모두 가능
    return next()
  })
  ```

- [ ] **댓글 시스템 통합** (2시간)
  ```typescript
  // Role 매핑 함수 (기존 댓글 시스템과 호환)
  // 기존: 'super-admin' | 'operator' | 'user'
  // 신규: 'anonymous' | 'user' | 'expert' | 'admin'
  function mapRoleForComments(newRole: string | null): 'super-admin' | 'operator' | 'user' {
    if (!newRole || newRole === 'anonymous') {
      return 'user'  // 익명 유저도 댓글 작성 가능
    }
    
    switch(newRole) {
      case 'admin': return 'super-admin'
      case 'expert': return 'operator'
      case 'user': 
      default: return 'user'
    }
  }
  
  // 댓글 작성 (로그인 불필요 - anonymous도 가능)
  app.post('/api/comments', async (c) => {
    const user = c.get('user')  // null일 수 있음 (익명)
    const { pageId, content, nickname } = await c.req.json()
    
    // 익명 유저는 nickname 필수
    const displayName = user ? user.name : (nickname || '익명')
    const userId = user ? user.id : null
    
    // 기존 댓글 시스템 호환을 위한 역할 매핑
    const commentRole = mapRoleForComments(user?.role || 'anonymous')
    
    await c.env.DB
      .prepare(`
        INSERT INTO comments (page_id, user_id, nickname, content, created_at)
        VALUES (?, ?, ?, ?, ?)
      `)
      .bind(pageId, userId, displayName, content, Date.now())
      .run()
    
    return c.json({ success: true })
  })
  
  // 댓글 수정/삭제 (자신이 작성한 것만, admin은 모두 가능)
  app.patch('/api/comments/:id', async (c) => {
    const user = c.get('user')
    const commentId = parseInt(c.req.param('id'))
    const { content } = await c.req.json()
    
    // 댓글 조회
    const comment = await c.env.DB
      .prepare('SELECT * FROM comments WHERE id = ?')
      .bind(commentId)
      .first()
    
    if (!comment) {
      return c.json({ error: 'Comment not found' }, 404)
    }
    
    // 권한 체크: 자신이 작성했거나 admin이어야 함
    if (!user) {
      return c.json({ error: 'Login required' }, 401)
    }
    
    if (user.role !== 'admin' && comment.user_id !== user.id) {
      return c.json({ error: 'You can only edit your own comments' }, 403)
    }
    
    // 수정
    await c.env.DB
      .prepare('UPDATE comments SET content = ? WHERE id = ?')
      .bind(content, commentId)
      .run()
    
    return c.json({ success: true })
  })
  ```

- [ ] **Admin 페이지 접근 제어** (1시간)
  ```typescript
  // Admin 라우트
  app.get('/admin/*', requireRole('admin'), async (c) => {
    // 관리자 페이지
  })
  ```

- [ ] **편집 페이지 권한 체크 및 UI 표시** (2시간)
  ```typescript
  // 직업/전공 페이지 편집 (Phase 3: admin만)
  app.post('/api/pages/:slug/edit', requireJobMajorEdit, async (c) => {
    const user = c.get('user')
    const { content, changeSummary } = await c.req.json()
    const slug = c.req.param('slug')
    
    // 페이지 조회 (pages 테이블 또는 jobs/majors 테이블)
    // 실제로는 jobs/majors 테이블에 데이터가 있지만, 편집 권한 체크를 위해 pages 테이블도 확인
    const page = await c.env.DB
      .prepare('SELECT * FROM pages WHERE slug = ? AND page_type IN ("job", "major")')
      .bind(slug)
      .first()
    
    // API 데이터 수정 불가 체크
    // source가 'careernet', 'goyong24', 'admin'이면 수정 불가
    if (page && (page.source === 'careernet' || page.source === 'goyong24' || page.source === 'admin')) {
      return c.json({ error: 'API data cannot be edited. Only user-contributed content can be edited.' }, 403)
    }
    
    // 실제로는 jobs/majors 테이블의 user_contributed_json만 수정 가능
    // admin_data_json은 운영진만 수정 가능
    // api_data_json은 API 동기화로만 업데이트됨
    
    // 편집 로직...
    // (실제 구현은 jobs/majors 테이블 구조에 맞춰야 함)
    // 여기서는 예시로 pages 테이블 업데이트
    if (page) {
      await c.env.DB
        .prepare(`
          UPDATE pages 
          SET content = ?, updated_at = CURRENT_TIMESTAMP
          WHERE slug = ? AND page_type IN ('job', 'major')
        `)
        .bind(content, slug)
        .run()
      
      // 편집 이력 기록
      await c.env.DB
        .prepare(`
          INSERT INTO page_revisions (page_id, user_id, content, change_summary, created_at)
          VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)
        `)
        .bind(page.id, user.id, content, changeSummary)
        .run()
    }
    
    return c.json({ success: true })
  })
  
  // HowTo 편집 (user/expert/admin 가능)
  app.post('/api/howto/:slug/edit', requireHowToEdit, async (c) => {
    const user = c.get('user')
    const { content, changeSummary } = await c.req.json()
    
    // HowTo 조회
    const howto = await c.env.DB
      .prepare('SELECT * FROM pages WHERE slug = ? AND page_type = "guide"')
      .bind(c.req.param('slug'))
      .first()
    
    if (!howto) {
      return c.json({ error: 'HowTo guide not found' }, 404)
    }
    
    // 자신이 작성한 글만 수정 가능 (admin 제외)
    if (user.role !== 'admin' && howto.author_id !== user.id) {
      return c.json({ error: 'You can only edit your own HowTo guides' }, 403)
    }
    
    // 편집 로직...
    await c.env.DB
      .prepare(`
        UPDATE pages 
        SET content = ?, updated_at = CURRENT_TIMESTAMP
        WHERE slug = ? AND page_type = 'guide'
      `)
      .bind(content, c.req.param('slug'))
      .run()
    
    // 편집 이력 기록
    await c.env.DB
      .prepare(`
        INSERT INTO page_revisions (page_id, user_id, content, change_summary, created_at)
        VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)
      `)
      .bind(howto.id, user.id, content, changeSummary)
      .run()
    
    return c.json({ success: true })
  })
  
  // HowTo 생성
  app.post('/api/howto/create', requireHowToEdit, async (c) => {
    const user = c.get('user')
    const { slug, title, content, summary } = await c.req.json()
    
    // HowTo 생성
    const result = await c.env.DB
      .prepare(`
        INSERT INTO pages (slug, title, page_type, content, summary, author_id, source, created_at, updated_at)
        VALUES (?, ?, 'guide', ?, ?, ?, 'user', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
      `)
      .bind(slug, title, content, summary, user.id)
      .run()
    
    return c.json({ success: true, pageId: result.meta.last_row_id })
  })
  
  // 편집 페이지 템플릿에서 역할 정보 표시
  const user = c.get('user')
  
  if (user?.role === 'admin') {
    // 관리자 전용 기능 표시 (문서 삭제, 보호 등)
  }
  
  if (user?.role === 'expert') {
    // 전문가 배지 표시
  }
  ```

- [ ] **IP 로깅 추가** (선택 사항) (1시간)
  ```typescript
  // 편집 시 IP 기록 (반달리즘 추적용)
  const ip = c.req.header('CF-Connecting-IP') || 'unknown'
  
  await c.env.DB
    .prepare(`
      INSERT INTO page_revisions (page_id, user_id, editor_ip, content, change_summary, created_at)
      VALUES (?, ?, ?, ?, ?, ?)
    `)
    .bind(pageId, user?.id, ip, content, summary, Date.now())
    .run()
  ```

**완료 기준**:
- ✅ 댓글은 로그인 여부와 관계없이 모두 작성 가능
- ✅ 댓글 수정/삭제는 자신이 작성한 것만 가능 (admin은 모두 가능)
- ✅ Admin 페이지는 admin 역할만 접근 가능
- ✅ 직업/전공 페이지 편집은 admin만 가능
- ✅ HowTo 편집은 로그인한 user/expert/admin 가능 (자신 글만 수정)
- ✅ 편집 시 사용자 정보 자동 기록

**예상 소요 시간**: 6-7시간

#### 🎨 Day 3 완료 후 확인 세션

**정우님이 직접 확인할 사항**:
1. [ ] 로그인 없이 댓글 작성 → 성공? (익명으로 작성됨)
2. [ ] 로그인 후 댓글 작성 → 내 이름으로 작성되는가?
3. [ ] 댓글 수정 (자신이 작성한 것) → 성공?
4. [ ] 댓글 수정 (다른 사람이 작성한 것) → 차단?
5. [ ] `/admin` 페이지 접근 (일반 유저) → 403 에러?
6. [ ] 직업/전공 페이지 편집 (일반 유저) → 차단?
7. [ ] D1에서 본인을 admin으로 변경 후 접근 → 성공?

**D1에서 본인을 admin으로 변경**:
```bash
wrangler d1 execute careerwiki-jobs --local --command="UPDATE users SET role='admin' WHERE email='your@email.com';"
```

**확인 완료 후**: "Day 4 시작!" 말씀해주세요.

---

### Day 4: UI/UX 개선 ✅

**목표**: 사용자 친화적인 로그인 UI

**Tasks**:
- [ ] **헤더에 로그인 버튼 추가** (2시간)
  ```html
  <!-- 기존 헤더 수정 -->
  <header>
    <nav>
      <a href="/">CareerWiki</a>
      
      {user ? (
        <div class="user-menu">
          <img src={user.picture_url} alt={user.name} />
          <span>{user.name}</span>
          <button onclick="logout()">로그아웃</button>
        </div>
      ) : (
        <a href="/auth/google" class="login-btn">
          <img src="/google-icon.svg" />
          Google로 1초 만에 시작하기
        </a>
      )}
    </nav>
  </header>
  ```

- [ ] **프로필 드롭다운 구현** (2시간)
  ```html
  <div class="profile-dropdown">
    <button class="profile-btn">
      <img src={user.picture_url} />
      <span>{user.name}</span>
    </button>
    
    <div class="dropdown-menu">
      <a href="/user/{user.id}">내 프로필</a>
      <a href="/user/{user.id}/contributions">내 기여</a>
      {user.role === 'admin' && (
        <a href="/admin">관리자 페이지</a>
      )}
      <hr />
      <form action="/auth/logout" method="POST">
        <button type="submit">로그아웃</button>
      </form>
    </div>
  </div>
  ```

- [ ] **로그인 필요 시 모달** (2시간)
  ```typescript
  // 편집 버튼 클릭 시
  function handleEditClick() {
    const user = getCurrentUser()  // 클라이언트 JS
    
    if (!user) {
      showLoginModal()
    } else {
      window.location.href = `/edit/${slug}`
    }
  }
  
  function showLoginModal() {
    // 모달 표시
    // "이 기능은 로그인이 필요합니다"
    // [Google로 로그인] 버튼
  }
  ```

- [ ] **로딩 상태 처리** (1시간)
  - Google OAuth 리디렉트 후 돌아올 때 로딩 표시
  - JWT 갱신 중 로딩 표시

- [ ] **에러 메시지 개선** (1시간)
  - OAuth 실패 시: "Google 로그인에 실패했습니다. 다시 시도해주세요."
  - Token 만료 시: "세션이 만료되었습니다. 다시 로그인해주세요."
  - 권한 부족 시: "이 작업은 관리자만 수행할 수 있습니다."

**완료 기준**:
- ✅ 고등학생도 쉽게 로그인 가능
- ✅ 1-click 로그인 달성
- ✅ 로그인 상태 명확히 표시
- ✅ 에러 메시지 사용자 친화적

**예상 소요 시간**: 8시간

---

### Day 5: 로컬 테스트 및 문서화 ✅

**목표**: 로컬 환경에서 모든 기능 검증 완료

**Tasks**:
- [ ] **로컬 환경 종합 테스트** (2시간)
  - [ ] Google 로그인 작동 확인
  - [ ] 로그아웃 작동 확인
  - [ ] Token Refresh 작동 확인
  - [ ] 권한 확인 (일반 유저, 관리자)
  - [ ] 사용자 설정 페이지 작동 확인
  - [ ] Username 변경 기능 확인
  - [ ] 사용자 메뉴가 모든 페이지에서 작동하는지 확인

- [ ] **보안 체크리스트 확인** (코드 레벨) (1시간)
  - [ ] `.dev.vars`가 `.gitignore`에 포함되어 있는지
  - [ ] HttpOnly Cookie 설정 확인 (코드 확인)
  - [ ] Secure 플래그 설정 확인 (코드 확인)
  - [ ] SameSite=Lax 설정 확인 (코드 확인)
  - [ ] JWT Secret 충분히 복잡한지 (32+ characters)
  - [ ] 환경 변수 노출 방지 확인

- [ ] **성능 테스트** (로컬) (1시간)
  - Chrome DevTools → Network 탭
  - 로그인 전/후 페이지 로딩 시간 측정
  - 목표: < 60ms 달성 확인

- [ ] **에러 시나리오 테스트** (1시간)
  - Google OAuth 거부 시
  - Token 만료 시
  - 잘못된 Token으로 요청 시
  - 권한 없는 페이지 접근 시

- [ ] **문서화** (1시간)
  - MASTER_PLAN.md 업데이트 (Phase 3 완료 체크)
  - 코드 주석 정리
  - 다음 개발자를 위한 주석 추가

**완료 기준**:
- ✅ 로컬 환경에서 모든 기능 정상 작동
- ✅ 보안 체크리스트 통과 (코드 레벨)
- ✅ 성능 목표 달성 (< 60ms)
- ✅ 에러 시나리오 모두 처리
- ✅ 문서화 완료

**예상 소요 시간**: 6시간

#### 🎨 Day 5 완료 후 로컬 확인 세션

**로컬 환경 최종 테스트** (정우님):
1. [ ] `http://localhost:3000` 접속
2. [ ] Google 로그인 → 정상 작동?
3. [ ] 프로필 드롭다운 → 모든 메뉴 표시?
4. [ ] Username 변경 → 정상 작동?
5. [ ] 로그아웃 → 즉시 반영?
6. [ ] 모든 페이지에서 사용자 메뉴 작동하는가?
7. [ ] 모바일 반응형이 잘 되는가?

**성능 확인**:
```
Chrome DevTools → Network 탭
- 페이지 로딩 시간: < 60ms ✅
```

**보안 확인** (코드 레벨):
```
코드에서 확인:
- HttpOnly Cookie 설정 ✅
- Secure 플래그 설정 ✅ (프로덕션에서만 활성화)
- SameSite=Lax 설정 ✅
```

**Phase 3 완료!** 🎉

**참고**: 배포 관련 작업은 **Phase 4.5**에서 편집 시스템과 함께 진행됩니다.

다음 단계: Phase 4 (편집 시스템 구축)

---

## 🔧 구현 팁 및 주의사항

### JWT 구현 시 주의사항

1. **Secret Key 생성**:
```bash
# 안전한 랜덤 키 생성
openssl rand -base64 32
```

2. **jose 라이브러리 사용** (Cloudflare Workers 호환):
```bash
npm install jose
```

3. **Payload 최소화**:
```typescript
// Good ✅
{ userId: 123, role: 'user' }

// Bad ❌
{ userId: 123, role: 'user', email: '...', name: '...', picture: '...', ... }
```

4. **TTL 설정**:
- Access Token: 1시간 (짧게)
- Refresh Token: 7일 (길게)

### KV Namespace 생성

```bash
# Production
wrangler kv:namespace create "AUTH_KV"

# Development (--preview 플래그)
wrangler kv:namespace create "AUTH_KV" --preview
```

`wrangler.jsonc`에 추가:
```jsonc
{
  "kv_namespaces": [
    {
      "binding": "AUTH_KV",
      "id": "your_kv_namespace_id",
      "preview_id": "your_preview_id"
    }
  ]
}
```

### D1 마이그레이션 명령어

```bash
# 로컬 테스트
npm run db:migrate:local

# 프로덕션 배포
npm run db:migrate:prod

# 롤백 (필요 시)
wrangler d1 execute careerwiki-jobs --command="DROP TABLE users;"
```

---

## ✅ 정우님 확인 완료 사항

### 1. 익명 편집 허용 범위
**결정**: ❌ **로그인 필수** (Phase 3) → ✅ **Ver. 2.0부터 익명 편집 허용**  
**이유**: 
- Phase 3: 반달리즘 대응 인력 없음, Google 소셜 로그인으로 진입장벽 이미 낮음
- Ver. 2.0: 커뮤니티 안정화 후 익명 편집 검토

### 2. 권한(Role) 정의
**결정**: ✅ **4단계** (anonymous/user/expert/admin)  
**역할 설명**:
- `anonymous`: 비로그인 유저
- `user`: 로그인한 일반 유저
- `expert`: 전문가 (추후 선정)
- `admin`: 운영자

**권한 매트릭스**:

| 기능 | anonymous | user | expert | admin |
|------|-----------|------|--------|-------|
| **직업/전공 페이지 편집** | ❌ | ❌ | ❌ | ✅ (Phase 3) |
| **직업/전공 페이지 편집** | ✅ | ✅ | ✅ | ✅ (Ver. 2.0, 단 API 데이터 제외) |
| **댓글 작성** | ✅ | ✅ | ✅ | ✅ |
| **댓글 수정/삭제** | 자신 것만 | 자신 것만 | 자신 것만 | 모두 가능 |
| **HowTo 편집/생성** | ❌ | ✅ | ✅ | ✅ |
| **HowTo 수정/삭제** | ❌ | 자신 것만 | 자신 것만 | 모두 가능 |
| **API 데이터 수정** | ❌ | ❌ | ❌ | ❌ (모든 버전) |

**특별 규칙**:
- CareerNet/Goyong24/운영진 추가 데이터는 **모든 사용자 편집 불가** (데이터 무결성 보장)
- 댓글은 로그인 여부와 관계없이 모두 작성 가능
- HowTo는 로그인 필수, 자신이 작성한 글만 수정/삭제 가능

### 3. 소셜 로그인 추가
**결정**: ✅ **Google만** (Phase 3) → ⏳ **Naver/Kakao 추가 예정** (Phase 5 이후)  
**우선순위**: 
1. Google (Phase 3) ✅
2. Naver/Kakao (Phase 5 이후) ⏳

### 4. 콘텐츠 저장 방식
**결정**: ✅ **D1에 Markdown 저장** (추천대로 따름)  
**이유**: 
- Git 연동은 복잡도 높음 (Phase 4 이후 검토)
- D1 저장 → 간단하고 빠름
- Markdown → 편집 용이, HTML 변환 쉬움

### 5. 편집 승인 절차
**결정**: ✅ **즉시 적용** (Wikipedia 방식, 추천대로 따름)  
**이유**: 빠른 콘텐츠 축적, 승인 절차는 관리 부담

### 6. Cloudflare 비용 플랜
**결정**: ✅ **무료 플랜 시작** (추천대로 따름)  
**예상 비용** (월 10,000 방문자 기준):
- Workers: 무료 구간 내
- KV: ~$1
- D1: 무료 구간 내
- **총: ~$1/월** (무료 플랜 충분)

---

## 📋 체크리스트 (시작 전 확인)

### 사전 준비
- [ ] Google 계정 (OAuth Console용)
- [ ] Cloudflare 계정 (Pages, D1, KV)
- [ ] GitHub 계정 (코드 저장)
- [ ] Node.js 18+ 설치
- [ ] Wrangler CLI 설치 (`npm install -g wrangler`)

### 개발 환경
- [ ] VSCode (또는 선호하는 에디터)
- [ ] Chrome DevTools (디버깅용)
- [ ] Postman/Thunder Client (API 테스트용, 선택)

### 지식 요구사항
- [ ] TypeScript 기본
- [ ] Hono 프레임워크 기본
- [ ] OAuth 2.0 플로우 이해
- [ ] JWT 개념 이해
- [ ] Cloudflare Workers 기본

---

## 🎯 다음 단계

✅ **정우님 확인 완료!** (2025-11-17)

모든 결정사항이 반영되었습니다:
- ✅ 익명 편집: Ver. 2.0부터 허용
- ✅ 권한 체계: anonymous/user/expert/admin
- ✅ 소셜 로그인: Google만 (Phase 3), Naver/Kakao 추가 예정
- ✅ 콘텐츠 저장: D1에 Markdown
- ✅ 편집 승인: 즉시 적용
- ✅ 비용 플랜: 무료 플랜 시작

**이제 바로 시작 가능합니다!**

**준비되셨으면 "Day 1 시작"이라고 말씀해주세요!** 🚀

