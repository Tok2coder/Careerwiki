# 🎯 Cursor 시작 가이드 (정우님용)

> **이 파일을 Cursor에서 열고 Composer에 붙여넣으세요!**

---

## 📥 Step 1: Cursor에서 프로젝트 열기

### 방법 1: Cursor에서 직접 클론 (추천)

1. **Cursor 열기**
2. **Cmd+Shift+P** (Mac) 또는 **Ctrl+Shift+P** (Windows)
3. **"Git: Clone"** 입력
4. GitHub URL 입력:
   ```
   https://github.com/Tok2coder/Careerwiki.git
   ```
5. 저장 위치 선택 (예: `~/Documents/`)
6. "Open" 클릭

### 방법 2: 터미널에서 클론 후 Cursor로 열기

```bash
cd ~/Documents
git clone https://github.com/Tok2coder/Careerwiki.git
cd Careerwiki
```

그 다음:
- **Mac**: 터미널에서 `cursor .` 실행
- **Windows**: Cursor 열고 "File → Open Folder" → Careerwiki 폴더 선택

---

## 🔐 Step 2: GitHub 인증 (한 번만)

### Cursor가 GitHub에 접근하려면 인증 필요

1. **터미널 열기** (Cursor 내부 터미널: Ctrl+` 또는 Cmd+`)

2. **Git 글로벌 설정**:
   ```bash
   git config --global user.name "Tok2coder"
   git config --global user.email "your-email@example.com"
   ```

3. **GitHub CLI로 인증** (가장 쉬운 방법):
   ```bash
   # GitHub CLI 설치 확인
   gh --version
   
   # 없으면 설치 (Mac)
   brew install gh
   
   # 없으면 설치 (Windows)
   # https://cli.github.com/ 에서 다운로드
   
   # GitHub 로그인
   gh auth login
   ```
   
   **선택지**:
   - `GitHub.com` 선택
   - `HTTPS` 선택
   - `Login with a web browser` 선택
   - 브라우저에서 인증 완료

4. **인증 확인**:
   ```bash
   git pull origin main  # 에러 없으면 성공
   ```

### 대안: Personal Access Token (PAT) 사용

GitHub CLI 설치가 어려우면:

1. **GitHub.com → Settings → Developer settings → Personal access tokens → Tokens (classic)**
2. **Generate new token (classic)** 클릭
3. **권한 선택**:
   - ✅ `repo` (전체)
   - ✅ `workflow`
4. **생성된 토큰 복사** (예: `ghp_xxxxxxxxxxxx`)

5. **Cursor 터미널에서**:
   ```bash
   # 첫 git 명령 시 username/password 요청되면:
   # Username: Tok2coder
   # Password: <복사한 PAT 붙여넣기>
   
   # 또는 credential helper 설정
   git config --global credential.helper store
   git pull origin main  # username/password 입력 → 저장됨
   ```

---

## ⚡ Step 3: 자동 환경 설정

**Cursor 터미널에서 실행**:

```bash
./setup-local.sh
```

이 명령어가 실패하면 (권한 문제):
```bash
chmod +x setup-local.sh
./setup-local.sh
```

**Windows에서는**:
```bash
bash setup-local.sh
```

### setup-local.sh가 하는 일:
- ✅ npm install
- ✅ PM2 설치 확인
- ✅ .dev.vars 파일 생성 (API 키 포함)
- ✅ src/index.tsx의 serveStatic 복원
- ✅ D1 데이터베이스 초기화
- ✅ npm run build

**예상 소요 시간**: 3-5분

---

## 🚀 Step 4: 개발 서버 시작

```bash
# PM2로 시작 (백그라운드 실행)
pm2 start ecosystem.config.cjs

# 확인
pm2 list

# 로그 확인
pm2 logs careerwiki --nostream
```

**또는 Vite dev server로 시작** (hot reload 지원):
```bash
npm run dev:d1
```

---

## 🌐 Step 5: 브라우저에서 확인

```
http://localhost:3000
```

**테스트할 페이지**:
1. 홈: http://localhost:3000
2. 직업 상세: http://localhost:3000/job/software-developer
3. 전공 상세: http://localhost:3000/major/digital-marketing-major
4. 디버그: http://localhost:3000/major/digital-marketing-major?debug=true

---

## 🤖 Step 6: Cursor AI에게 첫 지시

### Cursor Composer 열기
- **Mac**: `Cmd+I`
- **Windows**: `Ctrl+I`

### 정확한 첫 지시문 (복사해서 붙여넣기)

```
안녕! GenSpark에서 이어받은 CareerWiki 프로젝트를 계속 작업하려고 해.

현재 상황:
1. GenSpark 샌드박스 메모리 부족으로 Vite 빌드 실패
2. 모든 코드는 GitHub에 최신 상태로 푸시됨
3. 로컬 환경에서 setup-local.sh 실행 완료
4. 개발 서버 실행 중 (http://localhost:3000)

해결해야 할 문제 (우선순위):
1. JavaScript 403 에러 수정 - 탭 전환 작동하지 않음
2. 전공 디버그 페이지 데이터 렌더링 - 데이터가 표시되지 않음
3. ISR을 /job/:slug 라우트에도 적용

먼저 다음을 확인해줘:
1. src/index.tsx의 serveStatic이 제대로 복원되었는지
2. npm run build가 성공했는지
3. 브라우저에서 http://localhost:3000/job/software-developer 접속 시 탭 전환이 작동하는지
4. 개발자 도구 Console에 [DetailTabs] 로그가 나타나는지
5. Network 탭에서 /static/api-client.js가 200 OK인지

확인 후 첫 번째 문제부터 해결하자.

참고 문서:
- MIGRATION_TO_CURSOR.md - 전체 마이그레이션 가이드
- HANDOFF_SUMMARY.md - 작업 요약
- .cursorrules - 프로젝트 컨텍스트
```

---

## 🔍 Step 7: 문제 진단 체크리스트

### 1. JavaScript 파일 로딩 확인

**브라우저 개발자 도구** (F12):
- **Network 탭** 열기
- http://localhost:3000/job/software-developer 접속
- `/static/api-client.js` 찾기
- **Status**: 200 ✅ / 403 ❌ / 404 ❌

### 2. 탭 전환 확인

- "개요", "상세정보", "업무특성" 탭 클릭
- **작동함** ✅ / **작동 안 함** ❌

### 3. Console 로그 확인

**Console 탭**에서 찾기:
```
[DetailTabs] Initializing tabs for entityType: ...
```
- **로그 보임** ✅ / **로그 안 보임** ❌

### 4. 디버그 페이지 데이터 확인

http://localhost:3000/major/digital-marketing-major?debug=true

페이지에서 찾기:
- "상경계열" ✅ / ❌
- "Growth" ✅ / ❌
- "퍼포먼스" ✅ / ❌
- "주요 과목" ✅ / ❌

---

## 💬 Cursor AI와 대화하는 팁

### ✅ 좋은 지시 예시

```
src/index.tsx 파일을 열어서 line 95 근처의 serveStatic 설정을 확인해줘.
주석 처리되어 있으면 주석을 해제하고, 제대로 작동하는지 설명해줘.
```

```
브라우저에서 /static/api-client.js가 403 에러가 나고 있어.
현재 serveStatic 설정과 파일 위치를 확인해서 문제를 찾아줘.
```

```
src/templates/dataDebugTemplate.ts 파일을 분석해서,
왜 UnifiedMajorDetail 데이터가 렌더링되지 않는지 설명해줘.
그리고 수정 방법도 제안해줘.
```

### ❌ 피해야 할 지시

```
탭 좀 고쳐줘
```
→ 너무 모호함. 어떤 탭? 어떤 문제?

```
에러 났어
```
→ 구체적인 에러 메시지, 위치, 상황을 알려줘야 함

```
이거 왜 안돼?
```
→ 무엇이, 어떻게 안 되는지 설명 필요

### 💡 효과적인 대화 패턴

**1단계: 문제 확인 요청**
```
브라우저 개발자 도구 Console에 어떤 에러가 나타나는지 확인하고 싶어.
현재 /job/software-developer 페이지에서 탭 전환이 작동하지 않는데,
관련 에러 메시지나 로그가 있는지 찾아줘.
```

**2단계: 파일 분석 요청**
```
src/index.tsx 파일에서 serveStatic 관련 코드를 찾아서,
현재 설정이 올바른지 확인해줘. 
public/static/ 폴더의 파일들이 제대로 서빙되고 있는지도 체크해줘.
```

**3단계: 수정 요청**
```
문제를 찾았으면 수정해줘.
수정 전후 코드를 보여주고, 왜 그렇게 수정했는지 설명해줘.
```

**4단계: 테스트 요청**
```
수정 후 npm run build를 다시 실행하고,
브라우저에서 테스트해서 탭 전환이 작동하는지 확인해줘.
```

---

## 🎯 우선순위별 Cursor 지시문

### 🔥 우선순위 1: JavaScript 403 에러 (15분)

```
[Cursor Composer에 붙여넣기]

현재 상황:
- 브라우저에서 /static/api-client.js가 403 Forbidden 에러
- 탭 전환 기능이 작동하지 않음
- Console에 [DetailTabs] 로그가 나타나지 않음

다음을 순서대로 진행해줘:

1. src/index.tsx 파일 열기
   - Line 95 근처에 serveStatic 설정 확인
   - 주석 처리되어 있으면 주석 해제
   - 현재 코드 상태 알려주기

2. public/static/ 폴더 확인
   - api-client.js 파일이 존재하는지
   - 파일 크기와 권한 확인

3. serveStatic 설정이 올바른지 검증
   - root 경로가 './public'로 설정되어 있는지
   - '/static/*' 패턴이 맞는지

4. 수정 후 재빌드
   - npm run build 실행
   - 빌드 성공 확인

5. PM2 재시작
   - pm2 restart careerwiki
   - 로그 확인

6. 브라우저 테스트
   - http://localhost:3000/job/software-developer 접속
   - Network 탭에서 /static/api-client.js Status 확인
   - Console에서 [DetailTabs] 로그 확인
   - 탭 클릭해서 전환 작동하는지 확인

각 단계의 결과를 알려줘.
```

### 🔥 우선순위 2: 전공 디버그 페이지 데이터 렌더링 (30분)

```
[JavaScript 403 해결 후 실행]

현재 상황:
- http://localhost:3000/major/digital-marketing-major?debug=true 접속 시
- 페이지 제목은 나타나지만 데이터 내용이 표시되지 않음
- "상경계열", "Growth", "퍼포먼스" 등의 텍스트가 없음

다음을 순서대로 진행해줘:

1. src/templates/dataDebugTemplate.ts 파일 분석
   - DataDebugTemplateParams 타입 정의 확인
   - 현재 UnifiedJobDetail만 지원하는지 확인
   - UnifiedMajorDetail 타입 지원 여부 확인

2. src/data/sampleRegistry.ts 확인
   - major 샘플 데이터 구조 확인 (lines 327-394)
   - UnifiedMajorDetail 필드들:
     * categoryName (예: "상경계열")
     * mainSubjects (주요 과목)
     * universities (개설 대학)
     * aptitude (적성)
     * licenses (자격증)

3. dataDebugTemplate.ts 수정 계획 수립
   - UnifiedMajorDetail 지원 추가 방법
   - Major 전용 필드 렌더링 함수 추가 필요 여부

4. 수정 구현
   - 타입 정의 확장
   - Major 필드 렌더링 로직 추가

5. 테스트
   - npm run build
   - pm2 restart careerwiki
   - http://localhost:3000/major/digital-marketing-major?debug=true 접속
   - "상경계열", "주요 과목" 등 데이터 표시 확인

각 단계의 결과와 수정 코드를 알려줘.
```

### 🔥 우선순위 3: ISR을 /job/:slug에 적용 (20분)

```
[우선순위 1, 2 완료 후 실행]

현재 상황:
- /major/:slug 라우트는 ISR 캐시 적용됨 (50ms 응답)
- /job/:slug 라우트는 아직 ISR 미적용 (매번 렌더링)

다음을 순서대로 진행해줘:

1. src/index.tsx에서 /major/:slug ISR 구현 찾기
   - getOrGeneratePage() 사용 패턴 확인
   - 템플릿 버전 기반 캐시 무효화 로직 확인
   - 디버그 모드 우회 로직 확인

2. /job/:slug 라우트 찾기
   - 현재 구현 방식 확인 (SSR인지 확인)

3. ISR 적용
   - /major/:slug와 동일한 패턴으로 수정
   - page_type을 'job'으로 설정
   - 템플릿 버전은 JOB_DETAIL_VERSION 사용

4. 테스트
   - npm run build
   - pm2 restart careerwiki
   - http://localhost:3000/job/software-developer 첫 접속 (캐시 생성)
   - 새로고침 (캐시 사용, 빠른 응답)
   - Response time 확인 (50ms 정도)

코드 수정과 테스트 결과를 알려줘.
```

---

## 🛠️ 문제 발생 시 디버깅

### 문제: "npm: command not found"

**해결**:
```bash
# Node.js 설치 확인
node --version

# 없으면 설치
# Mac: brew install node
# Windows: https://nodejs.org 다운로드
```

### 문제: "pm2: command not found"

**해결**:
```bash
npm install -g pm2
```

### 문제: "Port 3000 already in use"

**해결**:
```bash
# Mac/Linux
lsof -ti:3000 | xargs kill -9

# Windows
netstat -ano | findstr :3000
taskkill /PID <PID번호> /F
```

### 문제: Build 실패

**해결**:
```bash
rm -rf node_modules dist .wrangler
npm install
npm run build
```

### 문제: D1 데이터베이스 에러

**해결**:
```bash
npm run db:reset
```

### 문제: Git push 권한 에러

**해결**:
```bash
# GitHub CLI로 재인증
gh auth logout
gh auth login

# 또는 PAT 재설정
git config --global credential.helper store
git pull origin main  # username/password 재입력
```

---

## 📝 작업 완료 후 GitHub 푸시

```bash
# 변경사항 확인
git status

# 스테이징
git add .

# 커밋
git commit -m "fix: Resolve JavaScript 403 errors and tab switching"

# 푸시
git push origin main
```

---

## ✅ 최종 확인 체크리스트

### 환경 설정
- [ ] Git clone 완료
- [ ] `./setup-local.sh` 실행 성공
- [ ] `npm run build` 성공
- [ ] PM2 시작 성공
- [ ] http://localhost:3000 접속 성공

### 버그 수정
- [ ] `/static/api-client.js` Status 200
- [ ] Console에 `[DetailTabs]` 로그 출력
- [ ] 탭 전환 작동 (개요/상세정보/업무특성)
- [ ] 전공 디버그 페이지 데이터 표시

### 추가 작업
- [ ] `/job/:slug` ISR 적용
- [ ] 모든 테스트 URL 정상 작동

### Git
- [ ] 변경사항 커밋
- [ ] GitHub 푸시

---

## 🎉 성공 시나리오

**모든 것이 정상 작동하면**:

1. ✅ 탭 전환 스무스하게 작동
2. ✅ Console에 디버그 로그 정상 출력
3. ✅ 전공 디버그 페이지에 데이터 표시
4. ✅ ISR 캐시로 페이지 로딩 10배 빠름
5. ✅ 모든 변경사항 GitHub에 푸시

**그 다음**:
```bash
npm run deploy:prod  # Cloudflare Pages에 배포
```

---

## 💡 Cursor 단축키 (자주 사용)

| 기능 | Mac | Windows |
|------|-----|---------|
| **Composer 열기** | `Cmd+I` | `Ctrl+I` |
| **Terminal 열기** | `Ctrl+\`` | `Ctrl+\`` |
| **Command Palette** | `Cmd+Shift+P` | `Ctrl+Shift+P` |
| **파일 찾기** | `Cmd+P` | `Ctrl+P` |
| **전체 검색** | `Cmd+Shift+F` | `Ctrl+Shift+F` |
| **사이드바 토글** | `Cmd+B` | `Ctrl+B` |

---

**이 파일을 Cursor에서 열고 참고하면서 작업하세요!** 🚀
