const { execSync } = require('child_process');
const fs = require('fs');

const toFix = JSON.parse(fs.readFileSync('C:/Users/PC/Careerwiki/tmp_tags_to_fix.json', 'utf8'));
console.log(`Total jobs to fix: ${toFix.length}`);

// Batch approach: write SQL to file, execute file
const BATCH_SIZE = 20;
let success = 0;
let fail = 0;

for (let batch = 0; batch < toFix.length; batch += BATCH_SIZE) {
  const slice = toFix.slice(batch, batch + BATCH_SIZE);
  const statements = [];

  for (const job of slice) {
    // Escape for SQLite: double single quotes
    const tagsJson = JSON.stringify(job.fixed).replace(/'/g, "''");
    statements.push(`UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.heroTags', json('${tagsJson}')) WHERE id = '${job.id}';`);
  }

  const sqlFile = 'C:/Users/PC/Careerwiki/tmp_batch_sql.sql';
  fs.writeFileSync(sqlFile, statements.join('\n'));

  try {
    execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --file="${sqlFile}"`,
      { encoding: 'utf8', timeout: 30000 }
    );
    success += slice.length;
  } catch (e) {
    // Try one by one for this batch
    for (const job of slice) {
      const tagsJson = JSON.stringify(job.fixed).replace(/'/g, "''");
      const singleSql = `UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.heroTags', json('${tagsJson}')) WHERE id = '${job.id}';`;
      fs.writeFileSync(sqlFile, singleSql);
      try {
        execSync(
          `npx wrangler d1 execute careerwiki-kr --remote --file="${sqlFile}"`,
          { encoding: 'utf8', timeout: 15000 }
        );
        success++;
      } catch (e2) {
        fail++;
        console.log(`FAIL: ${job.name} (${job.id})`);
      }
    }
  }

  if ((batch + BATCH_SIZE) % 100 < BATCH_SIZE) {
    console.log(`Progress: ${Math.min(batch + BATCH_SIZE, toFix.length)}/${toFix.length} (${success} ok, ${fail} fail)`);
  }
}

console.log(`\nDone! Success: ${success}, Fail: ${fail}`);
