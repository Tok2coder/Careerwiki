#!/usr/bin/env node
/**
 * 로컬과 Production D1 테이블 데이터 개수 비교
 */

import { execSync } from 'child_process';

const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';

function runQuery(isRemote, sql) {
  const flag = isRemote ? '--remote' : '--local';
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki-db ${flag} --command "${sql}" --json`,
      {
        encoding: 'utf-8',
        env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN },
        stdio: ['pipe', 'pipe', 'pipe']
      }
    );
    return JSON.parse(result);
  } catch (e) {
    return null;
  }
}

function getTableNames(isRemote) {
  const result = runQuery(isRemote, 
    "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE '_cf_%' AND name NOT LIKE '%_fts%' ORDER BY name;"
  );
  return result?.[0]?.results?.map(r => r.name) || [];
}

function getRowCount(isRemote, table) {
  const result = runQuery(isRemote, `SELECT COUNT(*) as cnt FROM ${table};`);
  return result?.[0]?.results?.[0]?.cnt || 0;
}

async function main() {
  console.log('='.repeat(70));
  console.log('로컬 vs Production D1 데이터 비교');
  console.log('='.repeat(70));
  console.log('');

  const localTables = getTableNames(false);
  const remoteTables = getTableNames(true);

  const allTables = [...new Set([...localTables, ...remoteTables])].sort();

  console.log(`${'테이블'.padEnd(35)} ${'로컬'.padStart(8)} ${'Prod'.padStart(8)} ${'상태'.padStart(8)}`);
  console.log('-'.repeat(70));

  let totalLocal = 0;
  let totalRemote = 0;
  let mismatchCount = 0;
  const mismatches = [];

  for (const table of allTables) {
    const inLocal = localTables.includes(table);
    const inRemote = remoteTables.includes(table);

    let localCount = 0;
    let remoteCount = 0;
    let status = '';

    if (inLocal && inRemote) {
      localCount = getRowCount(false, table);
      remoteCount = getRowCount(true, table);
      
      if (localCount === remoteCount) {
        status = localCount > 0 ? '✅' : '⬜';
      } else {
        status = '⚠️';
        mismatchCount++;
        mismatches.push({ table, localCount, remoteCount, diff: localCount - remoteCount });
      }
    } else if (inLocal && !inRemote) {
      localCount = getRowCount(false, table);
      status = '❌ Prod없음';
      if (localCount > 0) {
        mismatchCount++;
        mismatches.push({ table, localCount, remoteCount: 0, diff: localCount });
      }
    } else {
      remoteCount = getRowCount(true, table);
      status = '➕ 로컬없음';
    }

    totalLocal += localCount;
    totalRemote += remoteCount;

    const localStr = inLocal ? localCount.toString() : '-';
    const remoteStr = inRemote ? remoteCount.toString() : '-';

    console.log(`${table.padEnd(35)} ${localStr.padStart(8)} ${remoteStr.padStart(8)} ${status.padStart(8)}`);
  }

  console.log('-'.repeat(70));
  console.log(`${'합계'.padEnd(35)} ${totalLocal.toString().padStart(8)} ${totalRemote.toString().padStart(8)}`);
  console.log('');

  if (mismatches.length > 0) {
    console.log('⚠️  불일치 테이블:');
    for (const m of mismatches) {
      console.log(`   ${m.table}: 로컬 ${m.localCount} → Prod ${m.remoteCount} (차이: ${m.diff})`);
    }
  } else {
    console.log('✅ 모든 데이터가 일치합니다!');
  }

  console.log('');
  console.log('='.repeat(70));
}

main().catch(console.error);

