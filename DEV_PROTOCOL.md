# CareerWiki 개발 프로토콜

## 🎯 핵심 원칙

**로컬 개발 시작 전 Production 데이터를 동기화합니다.**

이렇게 하면:
- 실제 데이터로 개발 및 테스트
- 데이터 불일치 문제 방지
- Production 환경과 동일한 조건

---

## 🚀 개발 시작하기

### 1. 동기화 (처음 또는 주기적)
```powershell
$env:CLOUDFLARE_API_TOKEN="your-token"
npm run sync:prod-to-local
```

### 2. 개발 서버 실행
```bash
npm run dev
```

이제 **실제 Production 데이터**로 로컬에서 개발할 수 있습니다!

---

## 📋 명령어 정리

| 명령어 | 용도 |
|--------|------|
| `npm run dev` | Vite 개발 서버 (Hot Reload) |
| `npm run dev:build` | 빌드 후 wrangler 개발 서버 |
| `npm run preview` | 빌드 결과 미리보기 |
| `npm run deploy` | Production 배포 |
| `npm run sync:prod-to-local` | Production → 로컬 데이터 동기화 |
| `npm run db:migrate:local` | 로컬 스키마 마이그레이션 |
| `npm run db:migrate:prod` | Production 스키마 마이그레이션 |

---

## 🔄 워크플로우

### 일반 개발
```
1. npm run sync:prod-to-local   # Production 데이터 가져오기
2. npm run dev                   # 개발 시작
3. 코드 수정 (자동 반영)
4. 테스트 완료
5. npm run deploy                # 배포
```

### 스키마 변경
```
1. migrations/00XX_xxx.sql 작성
2. npm run db:migrate:local      # 로컬 적용
3. npm run dev                   # 테스트
4. npm run db:migrate:prod       # Production 적용
5. npm run deploy                # 배포
```

### 데이터 확인/수정
```powershell
# Production 조회
npx wrangler d1 execute careerwiki-db --remote --command "SELECT COUNT(*) FROM jobs;"

# 로컬 조회
npx wrangler d1 execute careerwiki-db --local --command "SELECT COUNT(*) FROM jobs;"

# Production에 데이터 추가 (주의!)
npx wrangler d1 execute careerwiki-db --remote --command "INSERT INTO ..."
```

---

## 📊 데이터 흐름

```
┌─────────────────┐
│  Production D1  │ ←── 실제 서비스 데이터
└────────┬────────┘
         │ sync:prod-to-local
         ▼
┌─────────────────┐
│    로컬 D1      │ ←── 개발/테스트용 복제본
└────────┬────────┘
         │ npm run dev
         ▼
┌─────────────────┐
│  로컬 개발 서버  │ ←── http://localhost:3000
└─────────────────┘
```

---

## ⚠️ 주의사항

### 동기화 관련
- 동기화 시 **로컬 데이터가 Production으로 덮어씌워집니다**
- 로컬에서 만든 테스트 데이터는 동기화 시 사라짐
- 중요한 로컬 작업이 있으면 동기화 전 백업

### Production 직접 조작
```powershell
# ⚠️ 위험! Production 데이터 직접 수정
npx wrangler d1 execute careerwiki-db --remote --command "DELETE FROM ..."
```
- **DELETE, DROP, TRUNCATE** 전 백업 필수
- 실수 시 복구 어려움

### 환경 변수
```powershell
# 매 세션마다 설정 필요
$env:CLOUDFLARE_API_TOKEN="your-token"
```

또는 `.dev.vars`에 설정 (Git에 커밋하지 않도록 주의)

---

## 🔐 인증 설정

### Cloudflare API Token
1. https://dash.cloudflare.com/profile/api-tokens
2. "Create Token" → "Edit Cloudflare Workers" 템플릿
3. 권한: D1 Edit, Pages Edit, R2 Edit

### 토큰 사용
```powershell
# 세션용
$env:CLOUDFLARE_API_TOKEN="your-token"

# 영구 설정 (권장하지 않음)
# Windows 환경변수에 추가
```

---

## 🆘 문제 해결

### 동기화 실패
```bash
# 로컬 D1 초기화 후 재시도
npm run db:reset
npm run sync:prod-to-local
```

### 인증 오류
```powershell
# 토큰 확인
echo $env:CLOUDFLARE_API_TOKEN

# 로그인 시도
npx wrangler login
```

### 포트 충돌
```bash
npm run stop
npm run dev
```

---

## 📁 파일 구조

```
.dev.vars              # 로컬 환경변수 (Git 제외)
.wrangler/state/v3/d1/ # 로컬 D1 데이터
wrangler.jsonc         # Cloudflare 설정
migrations/            # 스키마 마이그레이션
scripts/               # 유틸리티 스크립트
```
