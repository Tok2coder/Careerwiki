#!/usr/bin/env pwsh
# 단일 소스 직업 데이터 완전성 확인 스크립트

$ErrorActionPreference = "Continue"

Write-Host "`n🔍 단일 소스 직업 데이터 완전성 확인 시작...`n" -ForegroundColor Cyan
Write-Host ("=" * 80)

# 테스트 직업 목록
$testJobs = @{
    "Case 5 (고용24사전만)" = @("3D지도개발자", "3D프린터설치정비원", "3D프린팅운영기사")
    "Case 6 (커리어넷만)" = @("GIS전문가", "IT컨설턴트", "가구제조,수리원")
    "Case 7 (고용24직업만)" = @("IT기술지원전문가", "IT테스터 및 IT QA전문가", "UX·UI디자이너")
}

$results = @()

foreach ($case in $testJobs.Keys) {
    Write-Host "`n📋 $case`n" -ForegroundColor Yellow
    
    $sourceSystem = switch ($case) {
        { $_ -match "Case 5" } { "WORK24_DJOB" }
        { $_ -match "Case 6" } { "CAREERNET" }
        { $_ -match "Case 7" } { "WORK24_JOB" }
    }
    
    foreach ($jobName in $testJobs[$case]) {
        Write-Host "  📌 $jobName" -ForegroundColor Cyan
        
        # 1. job_sources 확인
        $sourceQuery = @"
SELECT 
    source_system,
    source_key,
    LENGTH(raw_payload) as raw_size,
    LENGTH(normalized_payload) as normalized_size,
    CASE 
        WHEN JSON_EXTRACT(normalized_payload, '$.name') IS NOT NULL THEN 'name'
        WHEN JSON_EXTRACT(raw_payload, '$.dJobNm') IS NOT NULL THEN 'dJobNm'
        WHEN JSON_EXTRACT(raw_payload, '$.jobNm') IS NOT NULL THEN 'jobNm'
        ELSE 'none'
    END as name_field
FROM job_sources
WHERE source_system = '$sourceSystem'
  AND (
    JSON_EXTRACT(normalized_payload, '$.name') = '$jobName'
    OR JSON_EXTRACT(raw_payload, '$.dJobNm') = '$jobName'
    OR JSON_EXTRACT(raw_payload, '$.jobNm') = '$jobName'
  )
LIMIT 1
"@
        
        $sourceResult = npx wrangler d1 execute careerwiki-db --local --command="$sourceQuery" 2>&1 | ConvertFrom-Json
        
        $hasJobSource = $sourceResult.results.Count -gt 0
        
        if ($hasJobSource) {
            $sourceRow = $sourceResult.results[0]
            Write-Host "     ✅ job_sources 존재: $($sourceRow.source_key)" -ForegroundColor Green
            Write-Host "        raw_payload 크기: $($sourceRow.raw_size) bytes" -ForegroundColor Gray
            Write-Host "        normalized_payload 크기: $($sourceRow.normalized_size) bytes" -ForegroundColor Gray
            Write-Host "        이름 필드: $($sourceRow.name_field)" -ForegroundColor Gray
        } else {
            Write-Host "     ❌ job_sources 없음" -ForegroundColor Red
        }
        
        # 2. jobs.merged_profile_json 확인
        $jobQuery = @"
SELECT 
    id,
    name,
    slug,
    primary_source,
    LENGTH(merged_profile_json) as merged_size,
    CASE 
        WHEN merged_profile_json IS NULL THEN 'NULL'
        WHEN merged_profile_json = '{}' THEN 'EMPTY'
        ELSE 'EXISTS'
    END as merged_status
FROM jobs
WHERE name = '$jobName'
LIMIT 1
"@
        
        $jobResult = npx wrangler d1 execute careerwiki-db --local --command="$jobQuery" 2>&1 | ConvertFrom-Json
        
        $hasMergedProfile = $jobResult.results.Count -gt 0 -and $jobResult.results[0].merged_status -eq 'EXISTS'
        
        if ($hasMergedProfile) {
            $jobRow = $jobResult.results[0]
            Write-Host "     ✅ jobs.merged_profile_json 존재" -ForegroundColor Green
            Write-Host "        ID: $($jobRow.id)" -ForegroundColor Gray
            Write-Host "        Slug: $($jobRow.slug)" -ForegroundColor Gray
            Write-Host "        Primary Source: $($jobRow.primary_source)" -ForegroundColor Gray
            Write-Host "        merged_profile_json 크기: $($jobRow.merged_size) bytes" -ForegroundColor Gray
            
            # 주요 필드 확인
            $fieldCheckQuery = @"
SELECT 
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.name') IS NOT NULL THEN 1 ELSE 0 END as has_name,
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.heroTitle') IS NOT NULL THEN 1 ELSE 0 END as has_heroTitle,
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.heroIntro') IS NOT NULL THEN 1 ELSE 0 END as has_heroIntro,
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.summary') IS NOT NULL THEN 1 ELSE 0 END as has_summary,
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.duties') IS NOT NULL THEN 1 ELSE 0 END as has_duties,
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.prospect') IS NOT NULL THEN 1 ELSE 0 END as has_prospect,
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.salary') IS NOT NULL THEN 1 ELSE 0 END as has_salary,
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.relatedMajors') IS NOT NULL THEN 1 ELSE 0 END as has_relatedMajors,
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.relatedCertificates') IS NOT NULL THEN 1 ELSE 0 END as has_relatedCertificates,
    CASE WHEN JSON_EXTRACT(merged_profile_json, '$.relatedJobs') IS NOT NULL THEN 1 ELSE 0 END as has_relatedJobs
FROM jobs
WHERE name = '$jobName'
LIMIT 1
"@
            
            $fieldCheckResult = npx wrangler d1 execute careerwiki-db --local --command="$fieldCheckQuery" 2>&1 | ConvertFrom-Json
            
            if ($fieldCheckResult.results.Count -gt 0) {
                $fields = $fieldCheckResult.results[0]
                $fieldCount = 0
                $fieldList = @()
                
                if ($fields.has_name -eq 1) { $fieldCount++; $fieldList += "name" }
                if ($fields.has_heroTitle -eq 1) { $fieldCount++; $fieldList += "heroTitle" }
                if ($fields.has_heroIntro -eq 1) { $fieldCount++; $fieldList += "heroIntro" }
                if ($fields.has_summary -eq 1) { $fieldCount++; $fieldList += "summary" }
                if ($fields.has_duties -eq 1) { $fieldCount++; $fieldList += "duties" }
                if ($fields.has_prospect -eq 1) { $fieldCount++; $fieldList += "prospect" }
                if ($fields.has_salary -eq 1) { $fieldCount++; $fieldList += "salary" }
                if ($fields.has_relatedMajors -eq 1) { $fieldCount++; $fieldList += "relatedMajors" }
                if ($fields.has_relatedCertificates -eq 1) { $fieldCount++; $fieldList += "relatedCertificates" }
                if ($fields.has_relatedJobs -eq 1) { $fieldCount++; $fieldList += "relatedJobs" }
                
                Write-Host "        주요 필드 존재: $fieldCount/10개 ($($fieldList -join ', '))" -ForegroundColor Gray
            }
        } else {
            Write-Host "     ❌ jobs.merged_profile_json 없음 또는 비어있음" -ForegroundColor Red
            if ($jobResult.results.Count -gt 0) {
                Write-Host "        상태: $($jobResult.results[0].merged_status)" -ForegroundColor Gray
            }
        }
        
        # 결과 저장
        $results += [PSCustomObject]@{
            Case = $case
            JobName = $jobName
            SourceSystem = $sourceSystem
            HasJobSource = $hasJobSource
            HasMergedProfile = $hasMergedProfile
        }
        
        Write-Host ""
    }
}

# 종합 리포트
Write-Host "`n" + ("=" * 80)
Write-Host "📊 종합 리포트`n" -ForegroundColor Yellow

$total = $results.Count
$hasJobSource = ($results | Where-Object { $_.HasJobSource }).Count
$hasMergedProfile = ($results | Where-Object { $_.HasMergedProfile }).Count
$complete = ($results | Where-Object { $_.HasJobSource -and $_.HasMergedProfile }).Count

Write-Host "총 확인 직업: $total개" -ForegroundColor Cyan
Write-Host "job_sources 존재: $hasJobSource개" -ForegroundColor $(if ($hasJobSource -eq $total) { "Green" } else { "Yellow" })
Write-Host "jobs.merged_profile_json 존재: $hasMergedProfile개" -ForegroundColor $(if ($hasMergedProfile -eq $total) { "Green" } else { "Yellow" })
Write-Host "완전한 데이터: $complete개" -ForegroundColor $(if ($complete -eq $total) { "Green" } else { "Yellow" })

if ($complete -lt $total) {
    Write-Host "`n⚠️ 불완전한 데이터:`n" -ForegroundColor Red
    $results | Where-Object { -not $_.HasJobSource -or -not $_.HasMergedProfile } | ForEach-Object {
        $issues = @()
        if (-not $_.HasJobSource) { $issues += "job_sources 없음" }
        if (-not $_.HasMergedProfile) { $issues += "merged_profile_json 없음" }
        Write-Host "  - $($_.JobName) ($($_.Case)): $($issues -join ', ')" -ForegroundColor Red
    }
}

Write-Host "`n✅ 확인 완료!`n" -ForegroundColor Green

