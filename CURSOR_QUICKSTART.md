# 🚀 Cursor 빠른 시작 가이드

> **5분 안에 개발 환경 완성!**

---

## 📥 Step 1: 프로젝트 클론

```bash
git clone https://github.com/Tok2coder/Careerwiki.git
cd Careerwiki
```

---

## ⚡ Step 2: 자동 설정 (추천)

```bash
./setup-local.sh
```

이 명령어 하나로:
- ✅ npm 패키지 설치
- ✅ PM2 설치 확인
- ✅ .dev.vars 환경 변수 생성
- ✅ serveStatic 설정 복원
- ✅ D1 데이터베이스 초기화
- ✅ 프로젝트 빌드

---

## 🎯 Step 3: 서버 시작

```bash
# PM2로 시작 (권장)
pm2 start ecosystem.config.cjs

# 또는 Vite 개발 서버
npm run dev:d1
```

---

## 🌐 Step 4: 브라우저에서 확인

```
http://localhost:3000
```

---

## ✅ 테스트할 페이지

1. **홈**: http://localhost:3000
2. **직업 목록**: http://localhost:3000/job
3. **직업 상세** (탭 테스트): http://localhost:3000/job/software-developer
4. **전공 상세** (탭 테스트): http://localhost:3000/major/digital-marketing-major
5. **디버그 모드**: http://localhost:3000/major/digital-marketing-major?debug=true

---

## 🐛 해결할 문제 (우선순위)

### 1. JavaScript 403 에러 (최우선) ⚠️
- **증상**: 탭 전환 안 됨, Console에 [DetailTabs] 로그 없음
- **예상**: 로컬 빌드 후 자동 해결
- **확인**: 브라우저 개발자 도구 → Network → `/static/api-client.js` Status 200 확인

### 2. 전공 디버그 페이지 데이터 렌더링 ⚠️
- **파일**: `src/templates/dataDebugTemplate.ts`
- **문제**: Major 프로필 데이터가 표시되지 않음 (title만 나옴)
- **원인**: 템플릿이 `UnifiedJobDetail` 전용으로 설계됨
- **해결**: Major 프로필 필드 (`categoryName`, `mainSubjects`, `universities` 등) 지원 추가

### 3. ISR을 `/job/:slug`에 적용
- **참고**: `src/index.tsx`의 `/major/:slug` ISR 로직 복사
- **목표**: Job 페이지도 동일한 캐시 성능

---

## 📚 상세 가이드

더 자세한 내용은 `MIGRATION_TO_CURSOR.md` 참조

---

## 🆘 문제 해결

### 포트 3000이 이미 사용 중
```bash
npm run clean-port
# 또는
lsof -ti:3000 | xargs kill -9
```

### 빌드 실패
```bash
rm -rf dist/ .wrangler/ node_modules/.vite
npm run build
```

### D1 데이터베이스 오류
```bash
npm run db:reset
```

---

## 💡 유용한 명령어

```bash
# PM2 관리
pm2 list                        # 서비스 목록
pm2 logs careerwiki --nostream  # 로그 확인
pm2 restart careerwiki          # 재시작
pm2 stop careerwiki             # 중지

# 개발
npm run build                   # 빌드
npm run dev                     # Vite dev server
npm run dev:d1                  # Wrangler with D1

# 배포
npm run deploy:prod             # Cloudflare Pages 배포

# 데이터베이스
npm run db:migrate:local        # 마이그레이션
npm run db:seed                 # 샘플 데이터
npm run db:reset                # 완전 초기화
```

---

## 🎯 바로 시작하기

```bash
# 전체 과정 (5분)
git clone https://github.com/Tok2coder/Careerwiki.git
cd Careerwiki
./setup-local.sh
pm2 start ecosystem.config.cjs
open http://localhost:3000
```

**그게 다입니다! 🎉**

---

## 📞 도움이 필요하면

- 📖 상세 가이드: `MIGRATION_TO_CURSOR.md`
- 📋 프로젝트 현황: `README.md`
- 🐛 알려진 이슈: `MIGRATION_TO_CURSOR.md` → "알려진 이슈" 섹션
