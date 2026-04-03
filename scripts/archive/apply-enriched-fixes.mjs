/**
 * 보완된 직업 프로필 수정사항 DB 반영 스크립트
 * fix-enriched-quality.mjs의 결과를 D1에 적용 (SQL 파일 방식)
 */
import { execSync } from 'child_process';
import fs from 'fs';

const fixes = JSON.parse(fs.readFileSync('/tmp/fixes_to_apply.json', 'utf8'));
console.log(`Total fixes to apply: ${fixes.length}`);

// Generate SQL file in batches (D1 has limits per execution)
const BATCH_SIZE = 20;
let totalSuccess = 0;
let totalFail = 0;

for (let batchStart = 0; batchStart < fixes.length; batchStart += BATCH_SIZE) {
  const batch = fixes.slice(batchStart, batchStart + BATCH_SIZE);
  let sql = '';

  for (const fix of batch) {
    const profileJson = JSON.stringify(fix.profile);
    const escaped = profileJson.replace(/'/g, "''");
    sql += `UPDATE jobs SET merged_profile_json = '${escaped}' WHERE id = '${fix.id}';\n`;
  }

  const sqlFile = `/tmp/fix_batch_${batchStart}.sql`;
  fs.writeFileSync(sqlFile, sql);

  try {
    execSync(`npx wrangler d1 execute careerwiki-kr --remote --file="${sqlFile}"`, {
      cwd: 'C:\\Users\\PC\\Careerwiki',
      encoding: 'utf8',
      maxBuffer: 50 * 1024 * 1024,
      stdio: ['pipe', 'pipe', 'pipe'],
      timeout: 60000
    });
    totalSuccess += batch.length;
  } catch (e) {
    console.error(`FAIL batch ${batchStart}: ${e.message?.slice(0, 300)}`);
    // Try individual updates for failed batch
    for (const fix of batch) {
      const profileJson = JSON.stringify(fix.profile);
      const escaped = profileJson.replace(/'/g, "''");
      const singleSql = `UPDATE jobs SET merged_profile_json = '${escaped}' WHERE id = '${fix.id}';`;
      const singleFile = `/tmp/fix_single_${fix.id}.sql`;
      fs.writeFileSync(singleFile, singleSql);
      try {
        execSync(`npx wrangler d1 execute careerwiki-kr --remote --file="${singleFile}"`, {
          cwd: 'C:\\Users\\PC\\Careerwiki',
          encoding: 'utf8',
          maxBuffer: 50 * 1024 * 1024,
          stdio: ['pipe', 'pipe', 'pipe'],
          timeout: 30000
        });
        totalSuccess++;
      } catch (e2) {
        console.error(`  FAIL individual [${fix.name}]: ${e2.message?.slice(0, 200)}`);
        totalFail++;
      }
    }
  }

  const progress = Math.min(batchStart + BATCH_SIZE, fixes.length);
  if (progress % 100 === 0 || progress >= fixes.length) {
    console.log(`Progress: ${progress}/${fixes.length} (success: ${totalSuccess}, fail: ${totalFail})`);
  }
}

console.log(`\n=== DONE ===`);
console.log(`Success: ${totalSuccess}`);
console.log(`Failed: ${totalFail}`);
