const { execSync } = require('child_process');
const fs = require('fs');

const updates = JSON.parse(fs.readFileSync('C:/Users/PC/Careerwiki/tmp_new_tags.json', 'utf8'));
console.log(`Total jobs to update: ${updates.length}`);

const BATCH_SIZE = 20;
let success = 0, fail = 0;

for (let b = 0; b < updates.length; b += BATCH_SIZE) {
  const slice = updates.slice(b, b + BATCH_SIZE);
  const stmts = slice.map(j => {
    const json = JSON.stringify(j.tags).replace(/'/g, "''");
    return `UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.heroTags', json('${json}')) WHERE id = '${j.id}';`;
  });

  const sqlFile = 'C:/Users/PC/Careerwiki/tmp_batch_sql.sql';
  fs.writeFileSync(sqlFile, stmts.join('\n'));

  try {
    execSync(`npx wrangler d1 execute careerwiki-kr --remote --file="${sqlFile}"`, { encoding: 'utf8', timeout: 30000 });
    success += slice.length;
  } catch (e) {
    for (const j of slice) {
      const json = JSON.stringify(j.tags).replace(/'/g, "''");
      fs.writeFileSync(sqlFile, `UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.heroTags', json('${json}')) WHERE id = '${j.id}';`);
      try {
        execSync(`npx wrangler d1 execute careerwiki-kr --remote --file="${sqlFile}"`, { encoding: 'utf8', timeout: 15000 });
        success++;
      } catch { fail++; console.log(`FAIL: ${j.name}`); }
    }
  }

  if ((b + BATCH_SIZE) % 200 < BATCH_SIZE) {
    console.log(`Progress: ${Math.min(b + BATCH_SIZE, updates.length)}/${updates.length} (${success} ok, ${fail} fail)`);
  }
}

console.log(`\nDone! Success: ${success}, Fail: ${fail}`);
