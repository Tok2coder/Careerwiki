$ErrorActionPreference = "Stop"
Write-Host "🚀 Work24 직업사전 DB 저장 시작...`n"

Write-Host "[1/64] djob_insert_batch_001.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_001.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[2/64] djob_insert_batch_002.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_002.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[3/64] djob_insert_batch_003.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_003.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[4/64] djob_insert_batch_004.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_004.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[5/64] djob_insert_batch_005.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_005.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[6/64] djob_insert_batch_006.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_006.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[7/64] djob_insert_batch_007.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_007.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[8/64] djob_insert_batch_008.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_008.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[9/64] djob_insert_batch_009.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_009.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[10/64] djob_insert_batch_010.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_010.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[11/64] djob_insert_batch_011.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_011.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[12/64] djob_insert_batch_012.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_012.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[13/64] djob_insert_batch_013.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_013.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[14/64] djob_insert_batch_014.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_014.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[15/64] djob_insert_batch_015.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_015.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[16/64] djob_insert_batch_016.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_016.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[17/64] djob_insert_batch_017.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_017.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[18/64] djob_insert_batch_018.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_018.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[19/64] djob_insert_batch_019.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_019.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[20/64] djob_insert_batch_020.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_020.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[21/64] djob_insert_batch_021.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_021.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[22/64] djob_insert_batch_022.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_022.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[23/64] djob_insert_batch_023.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_023.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[24/64] djob_insert_batch_024.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_024.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[25/64] djob_insert_batch_025.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_025.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[26/64] djob_insert_batch_026.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_026.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[27/64] djob_insert_batch_027.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_027.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[28/64] djob_insert_batch_028.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_028.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[29/64] djob_insert_batch_029.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_029.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[30/64] djob_insert_batch_030.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_030.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[31/64] djob_insert_batch_031.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_031.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[32/64] djob_insert_batch_032.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_032.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[33/64] djob_insert_batch_033.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_033.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[34/64] djob_insert_batch_034.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_034.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[35/64] djob_insert_batch_035.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_035.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[36/64] djob_insert_batch_036.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_036.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[37/64] djob_insert_batch_037.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_037.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[38/64] djob_insert_batch_038.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_038.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[39/64] djob_insert_batch_039.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_039.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[40/64] djob_insert_batch_040.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_040.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[41/64] djob_insert_batch_041.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_041.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[42/64] djob_insert_batch_042.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_042.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[43/64] djob_insert_batch_043.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_043.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[44/64] djob_insert_batch_044.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_044.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[45/64] djob_insert_batch_045.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_045.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[46/64] djob_insert_batch_046.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_046.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[47/64] djob_insert_batch_047.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_047.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[48/64] djob_insert_batch_048.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_048.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[49/64] djob_insert_batch_049.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_049.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[50/64] djob_insert_batch_050.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_050.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[51/64] djob_insert_batch_051.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_051.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[52/64] djob_insert_batch_052.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_052.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[53/64] djob_insert_batch_053.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_053.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[54/64] djob_insert_batch_054.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_054.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[55/64] djob_insert_batch_055.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_055.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[56/64] djob_insert_batch_056.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_056.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[57/64] djob_insert_batch_057.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_057.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[58/64] djob_insert_batch_058.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_058.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[59/64] djob_insert_batch_059.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_059.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[60/64] djob_insert_batch_060.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_060.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[61/64] djob_insert_batch_061.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_061.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[62/64] djob_insert_batch_062.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_062.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[63/64] djob_insert_batch_063.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_063.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "[64/64] djob_insert_batch_064.sql 실행 중..."
npx wrangler d1 execute careerwiki-db --local --file=.temp/djob_insert_batch_064.sql 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }

Write-Host "`n✅ 모든 배치 저장 완료!`n"

Write-Host "📊 DB 확인 중...`n"
npx wrangler d1 execute careerwiki-db --local --command="SELECT COUNT(*) as count FROM job_sources WHERE source_system = 'WORK24_DJOB';" 2>&1 | Select-String -Pattern "count"
