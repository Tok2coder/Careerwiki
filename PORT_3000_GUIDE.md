# 🔌 포트 3000 관리 가이드

> 서버를 항상 포트 3000에서 실행하고, 충돌 시 해결하는 방법

---

## ✅ 포트 3000 설정 완료

프로젝트는 이제 **항상 포트 3000**에서 실행됩니다:
- `vite.config.ts`에 포트 3000 설정됨
- `package.json`의 `dev` 스크립트에 `--port 3000` 추가됨

---

## 🚀 서버 실행

```bash
npm run dev
```

**결과**: http://localhost:3000 에서 실행됩니다.

---

## 🛑 포트 3000 사용 중인 프로세스 종료하기

### 방법 1: npm 스크립트 사용 (추천)

```bash
npm run clean-port
```

또는

```bash
npm run stop
```

**동작**: 포트 3000을 사용하는 모든 프로세스를 자동으로 종료합니다.

---

### 방법 2: 수동으로 종료 (Windows)

#### Step 1: 포트 3000 사용 중인 프로세스 확인
```powershell
netstat -ano | findstr :3000
```

**출력 예시:**
```
TCP    0.0.0.0:3000           0.0.0.0:0              LISTENING       12345
TCP    [::]:3000              [::]:0                 LISTENING       12345
```

마지막 숫자 (12345)가 **PID (Process ID)**입니다.

#### Step 2: 프로세스 종료
```powershell
taskkill /F /PID 12345
```

**예시:**
```powershell
# PID가 12345인 경우
taskkill /F /PID 12345
```

---

### 방법 3: Node.js 프로세스 모두 종료

```powershell
# 모든 Node.js 프로세스 종료
taskkill /F /IM node.exe
```

**주의**: 다른 Node.js 프로세스도 모두 종료됩니다.

---

## 🔍 포트 상태 확인

### 포트 3000 사용 중인지 확인
```powershell
netstat -ano | findstr :3000
```

**출력이 없으면**: 포트 3000이 비어있습니다.
**출력이 있으면**: 포트 3000을 사용 중인 프로세스가 있습니다.

---

## 📋 빠른 참조

### 서버 시작
```bash
npm run dev
```

### 포트 정리 후 서버 시작
```bash
npm run clean-port
npm run dev
```

### 서버 중지
```bash
# 방법 1: 포트 정리 스크립트
npm run stop

# 방법 2: Ctrl+C (터미널에서 실행 중인 경우)
```

---

## ⚠️ 문제 해결

### "포트 3000이 이미 사용 중입니다" 에러

1. **포트 정리**:
   ```bash
   npm run clean-port
   ```

2. **다시 시작**:
   ```bash
   npm run dev
   ```

### 포트 정리 스크립트가 작동하지 않을 때

수동으로 종료:
```powershell
# 1. PID 확인
netstat -ano | findstr :3000

# 2. PID로 종료 (예: PID가 12345인 경우)
taskkill /F /PID 12345
```

---

## 💡 팁

### PM2 사용 시
PM2로 실행한 서버를 중지하려면:
```bash
pm2 stop careerwiki
pm2 delete careerwiki
```

### 여러 터미널에서 실행 중일 때
각 터미널에서 `Ctrl+C`로 종료하거나:
```bash
npm run clean-port
```

---

**마지막 업데이트**: 2025-11-06

