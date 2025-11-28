# 테스트용 21개 직업 ETL 병합 스크립트 (PowerShell)
# 각 데이터 소스 조합별로 3개씩 총 21개 직업

Write-Host "🚀 Starting Test ETL for 21 jobs..." -ForegroundColor Green
Write-Host "=================================="

npm run etl:merge-jobs -- `
  "가상현실전문가" "간호사" "간호조무사" `
  "가수" "경제학연구원" "공업기계설치 및 정비원" `
  "간병인" "간판제작원" "건축사" `
  "3D프린팅모델러" "가사관리사" "감사사무원" `
  "3D지도개발자" "3D프린터설치정비원" "3D프린팅운영기사" `
  "GIS전문가" "IT컨설턴트" "가구제조,수리원" `
  "IT기술지원전문가" "IT테스터 및 IT QA전문가" "UX·UI디자이너"

Write-Host ""
Write-Host "==================================" -ForegroundColor Green
Write-Host "✅ ETL Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Update template version: src/constants/template-versions.ts"
Write-Host "2. Restart server: pm2 restart ecosystem.config.cjs"
Write-Host "3. Test pages: See TEST_JOBS_MATRIX.md for URLs"


