# D1 데이터베이스 Production 마이그레이션 스크립트
# 테이블별로 분할 export 후 순차 적용

$env:CLOUDFLARE_API_TOKEN = "H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "D1 Production 마이그레이션 시작" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

# 1. 스키마 적용
Write-Host "`n[1/3] Production에 스키마 적용 중..." -ForegroundColor Yellow
npx wrangler d1 execute careerwiki --remote --file=migration_schema.sql
if ($LASTEXITCODE -ne 0) {
    Write-Host "스키마 적용 실패!" -ForegroundColor Red
    exit 1
}
Write-Host "스키마 적용 완료!" -ForegroundColor Green

# 2. 주요 테이블 목록 (의존성 순서)
$tables = @(
    "d1_migrations",
    "users",
    "pages",
    "jobs",
    "majors",
    "howtos",
    "job_sources",
    "major_sources",
    "job_attributes",
    "job_assets",
    "major_assets",
    "job_dictionary_index",
    "job_match_overrides",
    "name_mappings",
    "tags",
    "howto_tags",
    "howto_related_jobs",
    "howto_related_majors",
    "howto_related_howtos",
    "howto_reports",
    "howto_reviews",
    "howto_drafts",
    "draft_tags",
    "draft_related_jobs",
    "draft_related_majors",
    "draft_related_howtos",
    "comments",
    "comment_votes",
    "comment_reports",
    "page_revisions",
    "page_relations",
    "wiki_pages",
    "search_index",
    "uploaded_files",
    "user_bookmarks",
    "user_attributions",
    "seed_logs",
    "seed_errors",
    "slug_history",
    "tagger_runs",
    "tagger_errors",
    "ip_blocks",
    "profanity_rules",
    "schema_migrations",
    "ai_sessions",
    "ai_analysis_requests",
    "ai_analysis_results",
    "career_analyses",
    "raw_events",
    "raw_events_backup",
    "facts",
    "facts_backup",
    "confirmed_constraints",
    "followup_responses",
    "question_history",
    "consents",
    "serp_interaction_logs",
    "serp_interaction_daily_summary",
    "anonymous_comment_counters",
    "anonymous_daily_limits",
    "anonymous_edit_limits",
    "feedback_posts",
    "feedback_comments",
    "feedback_replies"
)

# 3. 테이블별 데이터 export 및 적용
Write-Host "`n[2/3] 테이블별 데이터 마이그레이션 중..." -ForegroundColor Yellow

$exportDir = "migration_data"
if (!(Test-Path $exportDir)) {
    New-Item -ItemType Directory -Path $exportDir | Out-Null
}

$successCount = 0
$failCount = 0
$skipCount = 0

foreach ($table in $tables) {
    $outputFile = "$exportDir\$table.sql"
    
    # Export
    Write-Host "  - $table 처리 중..." -NoNewline
    
    # 데이터 개수 확인
    $countResult = npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) as count FROM $table;" --json 2>$null | ConvertFrom-Json
    $rowCount = $countResult[0].results[0].count
    
    if ($rowCount -eq 0) {
        Write-Host " (0 rows, 스킵)" -ForegroundColor Gray
        $skipCount++
        continue
    }
    
    # Export (데이터만)
    npx wrangler d1 export careerwiki --local --output=$outputFile --table=$table 2>$null
    
    if ($LASTEXITCODE -ne 0 -or !(Test-Path $outputFile)) {
        Write-Host " Export 실패!" -ForegroundColor Red
        $failCount++
        continue
    }
    
    # Production에 적용
    npx wrangler d1 execute careerwiki --remote --file=$outputFile 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host " 완료 ($rowCount rows)" -ForegroundColor Green
        $successCount++
    } else {
        Write-Host " 적용 실패!" -ForegroundColor Red
        $failCount++
    }
}

# 4. 결과 요약
Write-Host "`n[3/3] 마이그레이션 결과" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  성공: $successCount 테이블" -ForegroundColor Green
Write-Host "  스킵: $skipCount 테이블 (데이터 없음)" -ForegroundColor Gray
Write-Host "  실패: $failCount 테이블" -ForegroundColor Red
Write-Host "============================================" -ForegroundColor Cyan

# 5. Production 데이터 확인
Write-Host "`nProduction 데이터 확인 중..." -ForegroundColor Yellow
npx wrangler d1 execute careerwiki --remote --command "SELECT COUNT(*) as job_count FROM jobs;"
npx wrangler d1 execute careerwiki --remote --command "SELECT COUNT(*) as table_count FROM sqlite_master WHERE type='table';"

