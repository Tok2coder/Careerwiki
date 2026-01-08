# 🔄 GenSpark → Cursor 마이그레이션 가이드

**작성일**: 2025-11-06  
**상태**: 진행 중 (WIP - Work In Progress)  
**다음 작업자**: Cursor AI

---

## 📋 현재 상황 요약

### ✅ 완료된 작업
1. **"관련 HowTo" 섹션 제거** - `src/templates/unifiedJobDetail.ts` (lines 1932-1953)
2. **전공 디버그 모드 구현** - `/major/:slug?debug=true` 라우트 추가
3. **Import 에러 수정** - `getUnifiedMajorDetailWithRawData` 제거
4. **경량 빌드 시스템 구현** - esbuild 기반 (62ms, 710KB)
5. **모든 변경사항 커밋 및 푸시** - GitHub에 최신 코드 반영

### ⚠️ 미완료 (Cursor에서 진행할 작업)

#### 1. JavaScript 403 Forbidden 에러 수정 (최우선)
**문제**: 탭 전환 기능이 작동하지 않음 (클라이언트 JS 로딩 실패)

**원인 분석**:
- GenSpark 샌드박스 메모리 부족 (987MB < Vite 빌드 필요 1.5GB)
- esbuild로 빌드는 성공했으나, Cloudflare Workers 환경에서 정적 파일 서빙 실패
- `serveStatic` 미들웨어가 Cloudflare Workers 런타임에서 파일 시스템 접근 불가

**해결 방법**:
```bash
# Cursor 로컬 환경에서 (메모리 충분)
npm run build  # Vite 빌드 성공할 것
pm2 start ecosystem.config.cjs
```

**변경된 파일**:
- `src/index.tsx` (line 95): `serveStatic` 주석 처리됨 → **다시 활성화 필요**
- `ecosystem.config.cjs`: wrangler pages dev 설정 → **원래 설정으로 복원 필요**

#### 2. 전공 디버그 페이지 데이터 렌더링 수정
**문제**: `/major/digital-marketing-major?debug=true` 페이지 로드는 되지만 데이터가 표시되지 않음

**원인**:
- `src/templates/dataDebugTemplate.ts`가 `UnifiedJobDetail` 타입에 특화되어 설계됨
- Major 프로필 (`UnifiedMajorDetail`)은 다른 필드 구조 사용:
  - `categoryName`, `mainSubjects`, `universities`, `aptitude`, `licenses` 등
  - Job 프로필과 필드가 다름

**해결 방법**:
1. `dataDebugTemplate.ts`를 major 프로필도 지원하도록 수정
2. 또는 별도의 `majorDebugTemplate.ts` 생성

**샘플 데이터 위치**: `src/data/sampleRegistry.ts` (lines 327-394)

#### 3. ISR 캐시를 `/job/:slug` 라우트에도 적용
**현재**: `/major/:slug`만 ISR 적용됨  
**필요**: `/job/:slug`에도 동일한 ISR 캐시 로직 적용

---

## 🚀 Cursor에서 시작하는 방법

### Step 1: 프로젝트 클론

```bash
# 원하는 폴더로 이동
cd ~/Documents

# GitHub에서 클론
git clone https://github.com/Tok2coder/Careerwiki.git
cd Careerwiki
```

### Step 2: 환경 설정

```bash
# 의존성 설치 (3-5분 소요)
npm install

# PM2 전역 설치 (없다면)
npm install -g pm2

# .dev.vars 파일 생성
cat > .dev.vars << 'EOF'
ENVIRONMENT=development
CAREER_NET_API_KEY=38aef3e2-5a9d-4e71-8c2e-7a1da49b33e0
GOYONG24_MAJOR_API_KEY=38aef3e2-5a9d-4e71-8c2e-7a1da49b33e0
GOYONG24_JOB_API_KEY=38aef3e2-5a9d-4e71-8c2e-7a1da49b33e0
ADMIN_SECRET=your-admin-secret-key
EOF

# D1 데이터베이스 초기화
npm run db:migrate:local
npm run db:seed
```

### Step 3: 원래 설정 복원

#### 3.1. `src/index.tsx` 수정 (line 93-95)
```typescript
// BEFORE (현재 주석 처리됨):
// Serve static files from public directory
// Static files are served by wrangler's --assets flag
// app.use('/static/*', serveStatic({ root: './public' }))  // Disabled for wrangler dev compatibility

// AFTER (복원):
// Serve static files from public directory
// All static assets including JS, CSS, images are served from /static/* path
app.use('/static/*', serveStatic({ root: './public' }))
```

#### 3.2. `ecosystem.config.cjs` 수정
```javascript
// BEFORE (현재 wrangler pages dev):
args: 'wrangler pages dev dist --d1=careerwiki-jobs --local --ip 0.0.0.0 --port 3000',

// AFTER (Vite dev server로 복원):
args: 'wrangler pages dev dist --d1=careerwiki-jobs --local --ip 0.0.0.0 --port 3000',
// 또는 개발 중에는:
// args: 'vite --host 0.0.0.0 --port 3000',
```

### Step 4: 빌드 및 실행

```bash
# 빌드 (로컬 환경에서는 성공할 것)
npm run build

# 개발 서버 시작
pm2 start ecosystem.config.cjs

# 브라우저에서 테스트
open http://localhost:3000
```

### Step 5: 버그 확인 및 수정

#### 5.1. JavaScript 403 에러 해결 확인
```bash
# 브라우저 개발자 도구 → Console
# [DetailTabs] 로그가 나타나야 함

# 브라우저 개발자 도구 → Network
# /static/api-client.js - Status: 200 ✅
# /static/perf-metrics.js - Status: 200 ✅
```

#### 5.2. 탭 전환 테스트
```bash
open http://localhost:3000/job/software-developer
# "개요", "상세정보", "업무특성" 탭 클릭이 작동하는지 확인
```

#### 5.3. 디버그 페이지 데이터 표시 확인
```bash
open "http://localhost:3000/major/digital-marketing-major?debug=true"
# "상경계열", "Growth", "퍼포먼스" 등 데이터가 표시되는지 확인
```

---

## 📁 주요 파일 위치

### 수정이 필요한 파일
```
src/index.tsx                       # serveStatic 복원 필요 (line 95)
ecosystem.config.cjs                # 설정 복원 필요
src/templates/dataDebugTemplate.ts  # Major 프로필 지원 추가 필요
```

### 참고할 파일
```
src/data/sampleRegistry.ts          # 샘플 데이터 (major, job)
src/templates/unifiedJobDetail.ts   # Job 상세 페이지 템플릿
src/templates/unifiedMajorDetail.ts # Major 상세 페이지 템플릿
public/static/api-client.js         # 탭 전환 클라이언트 스크립트
```

---

## 🐛 알려진 이슈

### Issue 1: 탭 전환 작동 안 함
- **상태**: 미해결 (GenSpark 메모리 제약으로 테스트 불가)
- **원인**: JavaScript 파일 403 에러
- **예상 해결**: 로컬 빌드 후 자동 해결될 것

### Issue 2: 전공 디버그 데이터 렌더링 안 됨
- **상태**: 미해결 (템플릿 수정 필요)
- **원인**: `dataDebugTemplate.ts`가 job 프로필 전용
- **해결 필요**: Major 프로필 필드 매핑 추가

### Issue 3: ISR 미적용 라우트
- **상태**: 미해결
- **대상**: `/job/:slug` 라우트
- **필요**: `/major/:slug`와 동일한 ISR 로직 적용

---

## 🔧 디버깅 팁

### PM2 명령어
```bash
pm2 list                        # 서비스 목록
pm2 logs careerwiki --nostream  # 최근 로그만 보기
pm2 logs careerwiki             # 실시간 로그 (Ctrl+C로 종료)
pm2 restart careerwiki          # 재시작
pm2 stop careerwiki             # 중지
pm2 delete careerwiki           # 제거
```

### 포트 정리
```bash
npm run clean-port              # 포트 3000 정리
# 또는
lsof -ti:3000 | xargs kill -9
```

### 빌드 문제 해결
```bash
# 빌드 캐시 정리
rm -rf dist/ .wrangler/ node_modules/.vite

# 재빌드
npm run build
```

### D1 데이터베이스 문제
```bash
# 로컬 DB 완전 초기화
npm run db:reset

# 마이그레이션 확인
npm run db:console:local
# > SELECT name FROM sqlite_master WHERE type='table';
```

---

## 📊 테스트 URL

### 정상 작동 확인 필요한 페이지

1. **홈페이지**: http://localhost:3000
2. **직업 목록**: http://localhost:3000/job
3. **직업 상세 (탭 테스트)**: http://localhost:3000/job/software-developer
4. **전공 목록**: http://localhost:3000/major
5. **전공 상세 (탭 테스트)**: http://localhost:3000/major/digital-marketing-major
6. **직업 디버그 (작동)**: http://localhost:3000/job/software-developer?debug=true
7. **전공 디버그 (데이터 안 나옴)**: http://localhost:3000/major/digital-marketing-major?debug=true

---

## 🎯 우선순위 작업 순서

### 1단계: 기본 기능 복구 (30분)
- [ ] `src/index.tsx`에서 `serveStatic` 주석 해제
- [ ] 로컬에서 `npm run build` 성공 확인
- [ ] PM2로 서비스 시작
- [ ] JavaScript 403 에러 해결 확인
- [ ] 탭 전환 작동 확인

### 2단계: 디버그 페이지 수정 (1시간)
- [ ] `dataDebugTemplate.ts` 분석
- [ ] Major 프로필 필드 매핑 추가
- [ ] `/major/:slug?debug=true` 테스트
- [ ] 데이터 표시 확인

### 3단계: ISR 확장 (30분)
- [ ] `/job/:slug` 라우트에 ISR 적용
- [ ] 캐시 동작 테스트
- [ ] 성능 확인

### 4단계: 최종 검증 및 배포 (30분)
- [ ] 모든 테스트 URL 확인
- [ ] Git commit
- [ ] GitHub push
- [ ] Cloudflare Pages 배포: `npm run deploy:prod`

---

## 📝 GenSpark에서의 마지막 작업

### Git 커밋 히스토리
```
01279d9 - WIP: Migrate to esbuild-based lightweight build
355df1d - fix: Revert to /static/* paths for JS files to fix 403 errors
c3c0c5b - Fix: Static files 403 error and major page debug mode
5237d3e - feat: Implement ISR (Incremental Static Regeneration) cache system
```

### 변경된 설정
- **compatibility_date**: `2024-01-01` → `2024-09-23`
- **빌드 방식**: Vite → esbuild (임시)
- **ecosystem.config.cjs**: Vite dev → wrangler pages dev

---

## 💬 Cursor AI에게

안녕하세요! 정우님의 Careerwiki 프로젝트를 이어받았습니다.

**현재 상황**:
- GenSpark 샌드박스 메모리 부족으로 Vite 빌드 실패
- esbuild로 임시 빌드했으나 정적 파일 서빙 문제 발생
- 모든 코드는 GitHub에 최신 상태로 푸시됨

**바로 진행하실 작업**:
1. 로컬 환경에서 `npm run build` (메모리 충분하므로 성공할 것)
2. `src/index.tsx`의 `serveStatic` 주석 해제
3. 탭 전환 기능 테스트
4. 전공 디버그 페이지 데이터 렌더링 수정

위 문서의 "Step 1-5"를 순서대로 따라하시면 바로 이어서 작업하실 수 있습니다.

**중요**: 
- `.dev.vars` 파일의 API 키는 위에 포함되어 있습니다
- D1 데이터베이스는 `npm run db:migrate:local`로 초기화하세요
- 모든 샘플 데이터는 `src/data/sampleRegistry.ts`에 있습니다

화이팅! 🚀
