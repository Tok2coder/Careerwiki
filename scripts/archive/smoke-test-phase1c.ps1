# Phase 1C (Deep Intake) Smoke Test Script
# PowerShell

Write-Host ""
Write-Host "========================================"
Write-Host "  Phase 1C (Deep Intake) 연결 테스트"
Write-Host "========================================"
Write-Host ""

$API_BASE = "http://localhost:3000/api/ai-analyzer"
$SESSION_ID = "phase1c-test-$(Get-Date -Format 'yyyyMMddHHmmss')"

# ============================================
# Test 1: 기본 분석 (Deep Intake 없이)
# ============================================
Write-Host "[1] 기본 분석 (Deep Intake 없이)..."

$body1 = @{
    session_id = $SESSION_ID
    profile = @{
        interest = @{ keywords = @("데이터", "분석", "AI") }
        value = @{ priority = @("성장", "워라밸") }
        skill = @(
            @{ name = "Python"; level = "intermediate" }
        )
        dislike = @{ keywords = @("영업", "야근") }
        constraints = @{
            work_hours_strict = $true
        }
    }
} | ConvertTo-Json -Depth 5

try {
    $r1 = Invoke-RestMethod -Uri "$API_BASE/analyze" -Method POST -Body $body1 -ContentType "application/json"
    Write-Host "    Request ID: $($r1.request_id)"
    Write-Host "    Candidates: $($r1.result.total_candidates)"
    Write-Host "    TOP3: $($r1.result.fit_top3[0].job_name), $($r1.result.fit_top3[1].job_name), $($r1.result.fit_top3[2].job_name)"
    Write-Host "    User Insight: $(if ($r1.result.user_insight) { 'YES' } else { 'NO (expected)' })"
    Write-Host "    Deep Intake Processed: $($r1.deep_intake_processed)"
    Write-Host "    [OK] 기본 분석 완료"
} catch {
    Write-Host "    [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# ============================================
# Test 2: Deep Intake 포함 분석
# ============================================
Write-Host ""
Write-Host "[2] Deep Intake 포함 분석..."

$SESSION_ID_2 = "phase1c-deep-$(Get-Date -Format 'yyyyMMddHHmmss')"

$body2 = @{
    session_id = $SESSION_ID_2
    profile = @{
        interest = @{ keywords = @("데이터", "분석") }
        value = @{ priority = @("성장") }
        skill = @(
            @{ name = "Python"; level = "intermediate" }
        )
        dislike = @{ keywords = @("야근") }
        constraints = @{}
    }
    deep_intake = @{
        mbti = "INTJ"
        best_moment = "혼자 데이터 분석에 몰입하며 패턴을 발견했을 때 정말 즐거웠어요"
        worst_moment = "회의가 너무 많아서 집중할 시간이 없었던 적이 힘들었어요"
        change_reason = "더 성장할 수 있는 기회가 필요해요"
        priority_top1 = "growth"
    }
} | ConvertTo-Json -Depth 5

try {
    $r2 = Invoke-RestMethod -Uri "$API_BASE/analyze" -Method POST -Body $body2 -ContentType "application/json"
    Write-Host "    Request ID: $($r2.request_id)"
    Write-Host "    Candidates: $($r2.result.total_candidates)"
    Write-Host "    Deep Intake Processed: $($r2.deep_intake_processed)"
    
    if ($r2.result.user_insight) {
        Write-Host "    User Insight: YES" -ForegroundColor Green
        Write-Host "        Summary: $($r2.result.user_insight.summary)"
        Write-Host "        Key Traits: $($r2.result.user_insight.key_traits.Count)개"
        foreach ($trait in $r2.result.user_insight.key_traits) {
            Write-Host "          - $($trait.trait): $($trait.score_impact)"
        }
    } else {
        Write-Host "    User Insight: NO (unexpected)" -ForegroundColor Yellow
    }
    
    Write-Host "    [OK] Deep Intake 분석 완료"
} catch {
    Write-Host "    [ERROR] $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# ============================================
# Test 3: facts 저장 확인
# ============================================
Write-Host ""
Write-Host "[3] facts 저장 확인..."

try {
    $facts = Invoke-RestMethod -Uri "$API_BASE/facts/$SESSION_ID_2" -Method GET
    Write-Host "    Total facts: $($facts.count)"
    
    $expectedFactKeys = @("profile.mbti", "discovery.best_moment", "discovery.worst_moment", "motivation.change_reason", "priority.top1")
    $foundKeys = @()
    
    foreach ($fact in $facts.facts) {
        Write-Host "      - $($fact.fact_key)"
        if ($expectedFactKeys -contains $fact.fact_key) {
            $foundKeys += $fact.fact_key
        }
    }
    
    if ($foundKeys.Count -ge 4) {
        Write-Host "    [OK] 필수 fact keys 저장됨 ($($foundKeys.Count)/5)" -ForegroundColor Green
    } else {
        Write-Host "    [WARN] 일부 fact keys 누락 ($($foundKeys.Count)/5)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "    [ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

# ============================================
# Test 4: Follow-up 후 재분석 (TOP3 변화 확인)
# ============================================
Write-Host ""
Write-Host "[4] Follow-up 후 재분석..."

# 먼저 Follow-up 답변
$followupBody = @{
    session_id = $SESSION_ID_2
    question_id = "tradeoff_salary_vs_wlb"
    fact_key = "tradeoff.salary_vs_wlb"
    answer = "wlb"
} | ConvertTo-Json

try {
    $followupResult = Invoke-RestMethod -Uri "$API_BASE/followup" -Method POST -Body $followupBody -ContentType "application/json"
    Write-Host "    Followup saved: $($followupResult.fact_saved.fact_key) = $($followupResult.fact_saved.value)"
} catch {
    Write-Host "    [ERROR] Followup: $($_.Exception.Message)" -ForegroundColor Red
}

# 재분석
$reanalyzeBody = @{
    session_id = $SESSION_ID_2
    profile = @{
        interest = @{ keywords = @("데이터", "분석") }
        value = @{ priority = @("성장") }
        skill = @(
            @{ name = "Python"; level = "intermediate" }
        )
        dislike = @{ keywords = @("야근") }
        constraints = @{}
    }
} | ConvertTo-Json -Depth 5

try {
    $r3 = Invoke-RestMethod -Uri "$API_BASE/analyze" -Method POST -Body $reanalyzeBody -ContentType "application/json"
    Write-Host "    Re-analysis Request ID: $($r3.request_id)"
    Write-Host "    Facts Applied: $($r3.facts_applied)"
    Write-Host "    Applied Rules: $($r3.result.input_summary.applied_rules -join ', ')"
    
    # TOP3 비교
    $newTop3 = $r3.result.fit_top3 | ForEach-Object { $_.job_name }
    $oldTop3 = $r2.result.fit_top3 | ForEach-Object { $_.job_name }
    
    Write-Host "    Before: $($oldTop3 -join ' -> ')"
    Write-Host "    After:  $($newTop3 -join ' -> ')"
    
    $changed = ($newTop3 -join ',') -ne ($oldTop3 -join ',')
    if ($changed) {
        Write-Host "    [OK] TOP3 변화 있음!" -ForegroundColor Green
    } else {
        Write-Host "    [INFO] TOP3 변화 없음 (점수는 조정됨)" -ForegroundColor Cyan
    }
    
    Write-Host "    [OK] 재분석 완료"
} catch {
    Write-Host "    [ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

# ============================================
# Test 5: UI 테스트 (Step Wizard)
# ============================================
Write-Host ""
Write-Host "[5] UI 테스트 (Step Wizard)..."

try {
    $ui = Invoke-WebRequest -Uri "http://localhost:3000/analyzer/job?debug=true" -Method GET -UseBasicParsing
    
    $hasStep1 = $ui.Content -match 'id="step1"'
    $hasStep2 = $ui.Content -match 'id="step2"'
    $hasMBTI = $ui.Content -match 'name="mbti"'
    $hasBestMoment = $ui.Content -match 'name="best_moment"'
    $hasWorstMoment = $ui.Content -match 'name="worst_moment"'
    $hasChangeReason = $ui.Content -match 'name="change_reason"'
    $hasPriorityTop1 = $ui.Content -match 'name="priority_top1"'
    $hasUserInsightCard = $ui.Content -match 'id="user-insight-card"'
    
    Write-Host "    Step 1 (Quick Start): $(if ($hasStep1) { 'OK' } else { 'MISSING' })"
    Write-Host "    Step 2 (Deep Intake): $(if ($hasStep2) { 'OK' } else { 'MISSING' })"
    Write-Host "    MBTI 선택: $(if ($hasMBTI) { 'OK' } else { 'MISSING' })"
    Write-Host "    best_moment 입력: $(if ($hasBestMoment) { 'OK' } else { 'MISSING' })"
    Write-Host "    worst_moment 입력: $(if ($hasWorstMoment) { 'OK' } else { 'MISSING' })"
    Write-Host "    change_reason 입력: $(if ($hasChangeReason) { 'OK' } else { 'MISSING' })"
    Write-Host "    priority_top1 선택: $(if ($hasPriorityTop1) { 'OK' } else { 'MISSING' })"
    Write-Host "    User Insight 카드: $(if ($hasUserInsightCard) { 'OK' } else { 'MISSING' })"
    
    if ($hasStep1 -and $hasStep2 -and $hasMBTI -and $hasBestMoment -and $hasUserInsightCard) {
        Write-Host "    [OK] UI 요소 모두 정상" -ForegroundColor Green
    } else {
        Write-Host "    [WARN] 일부 UI 요소 누락" -ForegroundColor Yellow
    }
} catch {
    Write-Host "    [ERROR] $($_.Exception.Message)" -ForegroundColor Red
}

# ============================================
# 결과 요약
# ============================================
Write-Host ""
Write-Host "========================================"
Write-Host "  Phase 1C 연결 테스트 완료"
Write-Host "========================================"
Write-Host ""
Write-Host "다음 단계:"
Write-Host "  1. http://localhost:3000/analyzer/job?debug=true 에서 직접 테스트"
Write-Host "  2. Deep Intake 입력 후 User Insight 카드 확인"
Write-Host "  3. Follow-up 질문에 Narrative/Pattern 타입 포함 확인"
Write-Host ""







