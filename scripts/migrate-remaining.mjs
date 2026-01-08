#!/usr/bin/env node
/**
 * 남은 소량 데이터 마이그레이션
 */

import { execSync } from 'child_process';

const API_TOKEN = 'H3nfdRXvuqu9qr28KxzGrL5XoeezZ7_GG1SdPAmL';

const TABLES = [
  'uploaded_files',
  'wiki_pages',
  'user_bookmarks',
  'page_revisions',
  'user_attributions',
  'draft_related_jobs',
  'draft_related_majors',
  'draft_tags'
];

function runLocal(sql) {
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki-db --local --command "${sql}" --json`,
      { encoding: 'utf-8', env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN }, maxBuffer: 100*1024*1024, stdio: ['pipe','pipe','pipe'] }
    );
    return JSON.parse(result);
  } catch { return null; }
}

function runRemote(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\$/g, '\\$');
  try {
    execSync(`npx wrangler d1 execute careerwiki-db --remote --command "${escaped}"`,
      { encoding: 'utf-8', env: { ...process.env, CLOUDFLARE_API_TOKEN: API_TOKEN }, stdio: ['pipe','pipe','pipe'] });
    return true;
  } catch { return false; }
}

function escapeSQL(val) {
  if (val === null || val === undefined) return 'NULL';
  if (typeof val === 'number') return val.toString();
  const str = String(val).replace(/'/g, "''");
  return `'${str}'`;
}

async function main() {
  console.log('남은 소량 데이터 마이그레이션\n');

  for (const table of TABLES) {
    const cols = runLocal(`PRAGMA table_info(${table});`)?.[0]?.results?.map(r => r.name) || [];
    const rows = runLocal(`SELECT * FROM ${table};`)?.[0]?.results || [];
    
    if (rows.length === 0) {
      console.log(`⬜ ${table}: 데이터 없음`);
      continue;
    }

    let ok = 0, fail = 0;
    for (const row of rows) {
      const vals = cols.map(c => escapeSQL(row[c])).join(', ');
      if (runRemote(`INSERT OR REPLACE INTO ${table} (${cols.join(', ')}) VALUES (${vals});`)) ok++;
      else fail++;
    }
    console.log(`${fail === 0 ? '✅' : '⚠️'} ${table}: ${ok}/${rows.length}`);
  }

  console.log('\n완료!');
}

main();

