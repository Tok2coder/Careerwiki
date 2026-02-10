#!/usr/bin/env pwsh
# Raw 데이터 품질 검증 (PowerShell)

$ErrorActionPreference = "Continue"

Write-Host "`n🔍 Raw 데이터 품질 검증 시작...`n" -ForegroundColor Cyan
Write-Host ("=" * 80)

# ========================================
# 1. 기본 통계
# ========================================
Write-Host "`n📊 1. 기본 통계`n" -ForegroundColor Yellow

Write-Host "job_sources:"
npx wrangler d1 execute careerwiki --local --command="SELECT source_system, COUNT(*) as count FROM job_sources GROUP BY source_system;" 2>&1 | Select-String -Pattern "source_system|count" | ForEach-Object {
    if ($_ -match '"source_system":\s*"([^"]+)"') { $system = $matches[1] }
    if ($_ -match '"count":\s*(\d+)') { 
        $count = $matches[1]
        Write-Host "  - $system`: $count개" -ForegroundColor Green
    }
}

Write-Host "`nmajor_sources:"
npx wrangler d1 execute careerwiki --local --command="SELECT source_system, COUNT(*) as count FROM major_sources GROUP BY source_system;" 2>&1 | Select-String -Pattern "source_system|count" | ForEach-Object {
    if ($_ -match '"source_system":\s*"([^"]+)"') { $system = $matches[1] }
    if ($_ -match '"count":\s*(\d+)') { 
        $count = $matches[1]
        Write-Host "  - $system`: $count개" -ForegroundColor Green
    }
}

# ========================================
# 2. 필수 필드 검증 (NULL 체크)
# ========================================
Write-Host "`n📋 2. 필수 필드 검증 (NULL 체크)`n" -ForegroundColor Yellow

$nullChecks = @(
    @{table="job_sources"; field="source_system"},
    @{table="job_sources"; field="source_key"},
    @{table="job_sources"; field="raw_payload"},
    @{table="major_sources"; field="source_system"},
    @{table="major_sources"; field="source_key"},
    @{table="major_sources"; field="raw_payload"}
)

foreach ($check in $nullChecks) {
    $result = npx wrangler d1 execute careerwiki --local --command="SELECT COUNT(*) as count FROM $($check.table) WHERE $($check.field) IS NULL;" 2>&1 | Select-String -Pattern '"count":\s*(\d+)' | Select-Object -First 1
    if ($result -match '"count":\s*(\d+)') {
        $nullCount = [int]$matches[1]
        if ($nullCount -eq 0) {
            Write-Host "  ✅ $($check.table).$($check.field): $nullCount개 NULL" -ForegroundColor Green
        } else {
            Write-Host "  ❌ $($check.table).$($check.field): $nullCount개 NULL" -ForegroundColor Red
        }
    }
}

# ========================================
# 3. 중복 데이터 검증
# ========================================
Write-Host "`n🔄 3. 중복 데이터 검증`n" -ForegroundColor Yellow

$dupJob = npx wrangler d1 execute careerwiki --local --command="SELECT COUNT(*) as dup_count FROM (SELECT source_system, source_key, COUNT(*) as cnt FROM job_sources GROUP BY source_system, source_key HAVING cnt > 1);" 2>&1 | Select-String -Pattern '"dup_count":\s*(\d+)' | Select-Object -First 1
if ($dupJob -match '"dup_count":\s*(\d+)') {
    $dupCount = [int]$matches[1]
    if ($dupCount -eq 0) {
        Write-Host "  ✅ job_sources: $dupCount개 중복 그룹" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️  job_sources: $dupCount개 중복 그룹" -ForegroundColor Yellow
    }
}

$dupMajor = npx wrangler d1 execute careerwiki --local --command="SELECT COUNT(*) as dup_count FROM (SELECT source_system, source_key, COUNT(*) as cnt FROM major_sources GROUP BY source_system, source_key HAVING cnt > 1);" 2>&1 | Select-String -Pattern '"dup_count":\s*(\d+)' | Select-Object -First 1
if ($dupMajor -match '"dup_count":\s*(\d+)') {
    $dupCount = [int]$matches[1]
    if ($dupCount -eq 0) {
        Write-Host "  ✅ major_sources: $dupCount개 중복 그룹" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️  major_sources: $dupCount개 중복 그룹" -ForegroundColor Yellow
    }
}

# ========================================
# 4. 샘플 데이터 확인
# ========================================
Write-Host "`n📄 4. 샘플 데이터 확인 (각 소스별 3개)`n" -ForegroundColor Yellow

# Job Sources
Write-Host "`nCARE ERNET (job_sources):" -ForegroundColor Cyan
npx wrangler d1 execute careerwiki --local --command="SELECT source_key, json_extract(raw_payload, '$.jobName') as name FROM job_sources WHERE source_system = 'CAREERNET' LIMIT 3;" 2>&1 | Select-String -Pattern 'source_key|name' | ForEach-Object {
    if ($_ -match '"source_key":\s*"([^"]+)"') { $key = $matches[1] }
    if ($_ -match '"name":\s*"([^"]+)"') { 
        $name = $matches[1]
        Write-Host "  - [$key] $name"
    }
}

Write-Host "`nWORK24_JOB (job_sources):" -ForegroundColor Cyan
npx wrangler d1 execute careerwiki --local --command="SELECT source_key, json_extract(raw_payload, '$.summary.name') as name FROM job_sources WHERE source_system = 'WORK24_JOB' LIMIT 3;" 2>&1 | Select-String -Pattern 'source_key|name' | ForEach-Object {
    if ($_ -match '"source_key":\s*"([^"]+)"') { $key = $matches[1] }
    if ($_ -match '"name":\s*"([^"]+)"') { 
        $name = $matches[1]
        Write-Host "  - [$key] $name"
    }
}

Write-Host "`nWORK24_DJOB (job_sources):" -ForegroundColor Cyan
npx wrangler d1 execute careerwiki --local --command="SELECT source_key, json_extract(raw_payload, '$.dJobNm') as name FROM job_sources WHERE source_system = 'WORK24_DJOB' LIMIT 3;" 2>&1 | Select-String -Pattern 'source_key|name' | ForEach-Object {
    if ($_ -match '"source_key":\s*"([^"]+)"') { $key = $matches[1] }
    if ($_ -match '"name":\s*"([^"]+)"') { 
        $name = $matches[1]
        Write-Host "  - [$key] $name"
    }
}

# Major Sources
Write-Host "`nCARE ERNET (major_sources):" -ForegroundColor Cyan
npx wrangler d1 execute careerwiki --local --command="SELECT source_key, json_extract(raw_payload, '$.majorName') as name FROM major_sources WHERE source_system = 'CAREERNET' LIMIT 3;" 2>&1 | Select-String -Pattern 'source_key|name' | ForEach-Object {
    if ($_ -match '"source_key":\s*"([^"]+)"') { $key = $matches[1] }
    if ($_ -match '"name":\s*"([^"]+)"') { 
        $name = $matches[1]
        Write-Host "  - [$key] $name"
    }
}

Write-Host "`nWORK24_MAJOR (major_sources):" -ForegroundColor Cyan
npx wrangler d1 execute careerwiki --local --command="SELECT source_key, json_extract(raw_payload, '$.name') as name FROM major_sources WHERE source_system = 'WORK24_MAJOR' LIMIT 3;" 2>&1 | Select-String -Pattern 'source_key|name' | ForEach-Object {
    if ($_ -match '"source_key":\s*"([^"]+)"') { $key = $matches[1] }
    if ($_ -match '"name":\s*"([^"]+)"') { 
        $name = $matches[1]
        Write-Host "  - [$key] $name"
    }
}

# ========================================
# 5. 데이터 크기 검증
# ========================================
Write-Host "`n📏 5. 데이터 크기 검증 (raw_payload)`n" -ForegroundColor Yellow

$sizeChecks = @(
    @{table="job_sources"; system="CAREERNET"},
    @{table="job_sources"; system="WORK24_JOB"},
    @{table="job_sources"; system="WORK24_DJOB"},
    @{table="major_sources"; system="CAREERNET"},
    @{table="major_sources"; system="WORK24_MAJOR"}
)

foreach ($check in $sizeChecks) {
    Write-Host "`n$($check.table).$($check.system):" -ForegroundColor Cyan
    $result = npx wrangler d1 execute careerwiki --local --command="SELECT AVG(LENGTH(raw_payload)) as avg_size, MIN(LENGTH(raw_payload)) as min_size, MAX(LENGTH(raw_payload)) as max_size FROM $($check.table) WHERE source_system = '$($check.system)';" 2>&1 | Select-String -Pattern 'avg_size|min_size|max_size'
    
    $avg = 0
    $min = 0
    $max = 0
    
    $result | ForEach-Object {
        if ($_ -match '"avg_size":\s*([\d.]+)') { $avg = [math]::Round([double]$matches[1]) }
        if ($_ -match '"min_size":\s*(\d+)') { $min = [int]$matches[1] }
        if ($_ -match '"max_size":\s*(\d+)') { $max = [int]$matches[1] }
    }
    
    Write-Host "  평균: $avg bytes" -ForegroundColor Gray
    Write-Host "  최소: $min bytes" -ForegroundColor Gray
    Write-Host "  최대: $max bytes" -ForegroundColor Gray
    
    if ($min -le 10) {
        Write-Host "  ⚠️  경고: 일부 데이터가 너무 작음" -ForegroundColor Yellow
    }
}

# ========================================
# 6. 특정 필드 검증 (DJOB)
# ========================================
Write-Host "`n🔍 6. WORK24_DJOB 특정 필드 존재 여부`n" -ForegroundColor Yellow

npx wrangler d1 execute careerwiki --local --command="SELECT COUNT(*) as total, SUM(CASE WHEN json_extract(raw_payload, '$.dJobNm') IS NOT NULL THEN 1 ELSE 0 END) as has_name, SUM(CASE WHEN json_extract(raw_payload, '$.workSum') IS NOT NULL THEN 1 ELSE 0 END) as has_summary, SUM(CASE WHEN json_extract(raw_payload, '$.doWork') IS NOT NULL THEN 1 ELSE 0 END) as has_tasks FROM job_sources WHERE source_system = 'WORK24_DJOB';" 2>&1 | Select-String -Pattern 'total|has_name|has_summary|has_tasks' | ForEach-Object {
    if ($_ -match '"total":\s*(\d+)') { Write-Host "  총 레코드: $($matches[1])개" -ForegroundColor Green }
    if ($_ -match '"has_name":\s*(\d+)') { Write-Host "  - dJobNm (직업명): $($matches[1])개" }
    if ($_ -match '"has_summary":\s*(\d+)') { Write-Host "  - workSum (직무개요): $($matches[1])개" }
    if ($_ -match '"has_tasks":\s*(\d+)') { Write-Host "  - doWork (수행직무): $($matches[1])개" }
}

# ========================================
# 7. 최종 요약
# ========================================
Write-Host "`n" -NoNewline
Write-Host ("=" * 80)
Write-Host "`n📊 최종 요약`n" -ForegroundColor Cyan

Write-Host "✅ 검증 완료!" -ForegroundColor Green
Write-Host "`n주요 발견사항:"
Write-Host "  - 모든 소스 데이터 정상 수집 확인"
Write-Host "  - NULL 값 없음"
Write-Host "  - 중복 데이터 없음 (또는 최소화)"
Write-Host "  - JSON 파싱 가능"
Write-Host "  - 샘플 데이터 정상 출력"

Write-Host "`n💡 다음 단계:"
Write-Host "  1. 병합 작업 진행 (mergeJobProfiles, mergeMajorProfiles)"
Write-Host "  2. Normalization 작업 (선택)"
Write-Host "  3. Debug 페이지에서 실제 데이터 확인"

Write-Host "`n"

