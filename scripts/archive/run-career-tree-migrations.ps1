# CareerTree DB 마이그레이션 실행 스크립트
# Usage: .\scripts\run-career-tree-migrations.ps1

Write-Host "=== CareerTree DB Migration ===" -ForegroundColor Cyan
Write-Host ""

$migrations = @(
    "src/services/ai-analyzer/migrations/010_career_tree_tables.sql",
    "src/services/ai-analyzer/migrations/011_ai_analysis_results_add_career_state.sql",
    "src/services/ai-analyzer/migrations/012_ai_analysis_results_add_transition_signal.sql",
    "src/services/ai-analyzer/migrations/013_ai_analysis_results_add_resume_id.sql",
    "src/services/ai-analyzer/migrations/014_ai_analysis_results_add_confidence_score.sql",
    "src/services/ai-analyzer/migrations/015_ai_analysis_results_add_key_decision_variables.sql",
    "src/services/ai-analyzer/migrations/016_ai_analysis_results_add_scoring_trace.sql"
)

$dbName = "careerwiki-db"

foreach ($migration in $migrations) {
    $fileName = Split-Path $migration -Leaf
    Write-Host "Running: $fileName" -ForegroundColor Yellow
    
    try {
        npx wrangler d1 execute $dbName --file=$migration --remote
        Write-Host "  ✓ Success" -ForegroundColor Green
    } catch {
        Write-Host "  ✗ Failed: $_" -ForegroundColor Red
    }
    
    Write-Host ""
}

Write-Host "=== Migration Complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Verify tables with:" -ForegroundColor Gray
Write-Host "  npx wrangler d1 execute $dbName --command=`".tables`" --remote"
