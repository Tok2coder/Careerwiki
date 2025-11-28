/**
 * Work24 직업사전 JSON 데이터 → D1 DB 저장
 */

import { readFileSync, writeFileSync } from 'fs';

function generateSQLInserts() {
  console.log('\n📥 JSON 데이터 읽는 중...\n');
  
  const jsonData = JSON.parse(readFileSync('.temp/djob_data_final.json', 'utf-8'));
  console.log(`✅ ${jsonData.length}개 직업 로드 완료\n`);

  console.log('📝 SQL INSERT 문 생성 중...\n');

  const batchSize = 100;
  const batches = Math.ceil(jsonData.length / batchSize);

  for (let i = 0; i < batches; i++) {
    const start = i * batchSize;
    const end = Math.min(start + batchSize, jsonData.length);
    const batchData = jsonData.slice(start, end);

    const inserts: string[] = [];

    for (const job of batchData) {
      const sourceKey = `${job.dJobCd}:${job.dJobCdSeq}`;
      const rawPayload = JSON.stringify(job).replace(/'/g, "''"); // Escape single quotes

      inserts.push(
        `INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', '${sourceKey}', '${rawPayload}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;`
      );
    }

    const batchSQL = inserts.join('\n\n');
    const filename = `.temp/djob_insert_batch_${String(i + 1).padStart(3, '0')}.sql`;
    writeFileSync(filename, batchSQL, 'utf-8');

    console.log(`  ✅ Batch ${i + 1}/${batches} → ${filename} (${batchData.length}개)`);
  }

  console.log('\n✅ SQL 파일 생성 완료!\n');

  // PowerShell 실행 스크립트 생성
  const psLines = [
    '$ErrorActionPreference = "Stop"',
    'Write-Host "🚀 Work24 직업사전 DB 저장 시작...`n"',
    '',
  ];

  for (let i = 0; i < batches; i++) {
    const filename = `djob_insert_batch_${String(i + 1).padStart(3, '0')}.sql`;
    psLines.push(
      `Write-Host "[${i + 1}/${batches}] ${filename} 실행 중..."`,
      `npx wrangler d1 execute careerwiki-db --local --file=.temp/${filename} 2>&1 | Out-Null`,
      `if ($LASTEXITCODE -eq 0) { Write-Host "  ✅ 완료" } else { Write-Host "  ❌ 실패"; exit 1 }`,
      ''
    );
  }

  psLines.push(
    'Write-Host "`n✅ 모든 배치 저장 완료!`n"',
    '',
    'Write-Host "📊 DB 확인 중...`n"',
    'npx wrangler d1 execute careerwiki-db --local --command="SELECT COUNT(*) as count FROM job_sources WHERE source_system = \'WORK24_DJOB\';" 2>&1 | Select-String -Pattern "count"',
    ''
  );

  writeFileSync('.temp/import_djob.ps1', psLines.join('\n'), 'utf-8');
  console.log('📄 PowerShell 스크립트: .temp/import_djob.ps1\n');
  console.log('🔧 실행 방법:\n');
  console.log('   .temp/import_djob.ps1\n');
}

generateSQLInserts();

