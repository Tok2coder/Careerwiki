#!/bin/bash
# 🚀 CareerWiki 로컬 환경 자동 설정 스크립트
# Cursor AI에서 바로 실행 가능

set -e  # 에러 발생 시 중단

echo "🚀 CareerWiki 로컬 환경 설정 시작..."
echo ""

# Step 1: Node.js 버전 확인
echo "📋 Step 1: Node.js 버전 확인..."
NODE_VERSION=$(node --version)
echo "   ✅ Node.js: $NODE_VERSION"
if [[ ! "$NODE_VERSION" =~ ^v18 ]] && [[ ! "$NODE_VERSION" =~ ^v20 ]] && [[ ! "$NODE_VERSION" =~ ^v22 ]]; then
    echo "   ⚠️  경고: Node.js v18 이상 권장 (현재: $NODE_VERSION)"
fi
echo ""

# Step 2: 의존성 설치
echo "📦 Step 2: 의존성 설치 중..."
npm install
echo "   ✅ npm install 완료"
echo ""

# Step 3: PM2 설치 확인
echo "🔧 Step 3: PM2 설치 확인..."
if ! command -v pm2 &> /dev/null; then
    echo "   PM2가 설치되지 않았습니다. 전역 설치 중..."
    npm install -g pm2
    echo "   ✅ PM2 설치 완료"
else
    echo "   ✅ PM2 이미 설치됨"
fi
echo ""

# Step 4: .dev.vars 파일 생성
echo "🔐 Step 4: 환경 변수 설정..."
if [ -f ".dev.vars" ]; then
    echo "   ⚠️  .dev.vars 파일이 이미 존재합니다. 건너뜁니다."
else
    cat > .dev.vars << 'EOF'
ENVIRONMENT=development
CAREER_NET_API_KEY=38aef3e2-5a9d-4e71-8c2e-7a1da49b33e0
GOYONG24_MAJOR_API_KEY=38aef3e2-5a9d-4e71-8c2e-7a1da49b33e0
GOYONG24_JOB_API_KEY=38aef3e2-5a9d-4e71-8c2e-7a1da49b33e0
ADMIN_SECRET=careerwiki-local-dev-secret
EOF
    echo "   ✅ .dev.vars 파일 생성 완료"
fi
echo ""

# Step 5: serveStatic 복원
echo "🔧 Step 5: serveStatic 설정 복원 중..."
if grep -q "// app.use('/static/\*', serveStatic" src/index.tsx; then
    echo "   serveStatic이 주석 처리되어 있습니다. 복원 중..."
    sed -i.bak "s|// app.use('/static/\*', serveStatic({ root: './public' }))  // Disabled for wrangler dev compatibility|app.use('/static/*', serveStatic({ root: './public' }))|g" src/index.tsx
    rm -f src/index.tsx.bak
    echo "   ✅ serveStatic 복원 완료"
else
    echo "   ✅ serveStatic 이미 활성화됨"
fi
echo ""

# Step 6: D1 데이터베이스 초기화
echo "🗄️  Step 6: D1 데이터베이스 초기화..."
if npm run db:migrate:local > /dev/null 2>&1; then
    echo "   ✅ 마이그레이션 완료"
else
    echo "   ⚠️  마이그레이션 실패 (무시하고 계속)"
fi

if npm run db:seed > /dev/null 2>&1; then
    echo "   ✅ 샘플 데이터 추가 완료"
else
    echo "   ⚠️  샘플 데이터 추가 실패 (무시하고 계속)"
fi
echo ""

# Step 7: 빌드
echo "🔨 Step 7: 프로젝트 빌드 중..."
if npm run build; then
    echo "   ✅ 빌드 성공!"
else
    echo "   ❌ 빌드 실패. 로그를 확인해주세요."
    exit 1
fi
echo ""

# Step 8: 완료
echo "🎉 설정 완료!"
echo ""
echo "다음 명령어로 개발 서버를 시작하세요:"
echo "   pm2 start ecosystem.config.cjs"
echo ""
echo "또는 Vite 개발 서버로 시작:"
echo "   npm run dev:d1"
echo ""
echo "브라우저에서 접속:"
echo "   http://localhost:3000"
echo ""
echo "PM2 명령어:"
echo "   pm2 list              # 서비스 목록"
echo "   pm2 logs careerwiki   # 로그 확인"
echo "   pm2 restart careerwiki # 재시작"
echo "   pm2 stop careerwiki   # 중지"
echo ""
echo "✅ 준비 완료! Happy coding! 🚀"
