#!/usr/bin/env node
import { execSync } from 'child_process';

const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';

const TABLES = [
  'uploaded_files',
  'wiki_pages',
  'page_revisions',
  'draft_related_jobs',
  'draft_related_majors',
  'draft_tags'
];

function runLocal(sql) {
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki --local --command "${sql}" --json`,
      { encoding: 'utf-8', env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN }, maxBuffer: 100*1024*1024, stdio: ['pipe','pipe','pipe'] }
    );
    return JSON.parse(result);
  } catch { return null; }
}

function runRemote(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\$/g, '\\$');
  try {
    execSync(`npx wrangler d1 execute careerwiki --remote --command "${escaped}"`,
      { encoding: 'utf-8', env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN }, stdio: ['pipe','pipe','pipe'] });
    return true;
  } catch (e) { 
    console.log(`    에러: ${e.message?.slice(0, 100)}`);
    return false; 
  }
}

function escapeSQL(val) {
  // "null" 문자열도 NULL로 처리
  if (val === null || val === undefined || val === 'null') return 'NULL';
  if (typeof val === 'number') return val.toString();
  const str = String(val).replace(/'/g, "''");
  return `'${str}'`;
}

async function main() {
  console.log('남은 데이터 마이그레이션 (v2)\n');

  for (const table of TABLES) {
    const cols = runLocal(`PRAGMA table_info(${table});`)?.[0]?.results?.map(r => r.name) || [];
    const rows = runLocal(`SELECT * FROM ${table};`)?.[0]?.results || [];
    
    if (rows.length === 0) {
      console.log(`⬜ ${table}: 없음`);
      continue;
    }

    console.log(`📦 ${table}: ${rows.length}개...`);
    let ok = 0, fail = 0;
    
    for (const row of rows) {
      const vals = cols.map(c => escapeSQL(row[c])).join(', ');
      const sql = `INSERT OR REPLACE INTO ${table} (${cols.join(', ')}) VALUES (${vals});`;
      if (runRemote(sql)) ok++;
      else fail++;
    }
    console.log(`${fail === 0 ? '✅' : '⚠️'} ${table}: ${ok}/${rows.length}`);
  }

  console.log('\n완료!');
}

main();

