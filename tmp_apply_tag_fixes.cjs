const { execSync } = require('child_process');
const fs = require('fs');

const toFix = JSON.parse(fs.readFileSync('C:/Users/PC/Careerwiki/tmp_tags_to_fix.json', 'utf8'));
console.log(`Total jobs to fix: ${toFix.length}`);

let success = 0;
let fail = 0;

for (let i = 0; i < toFix.length; i++) {
  const job = toFix[i];
  const tagsJson = JSON.stringify(job.fixed).replace(/'/g, "''");

  // Update merged_profile_json heroTags via json_set
  const sql = `UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.heroTags', json('${tagsJson}')) WHERE id = '${job.id}'`;

  try {
    execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --command "${sql.replace(/"/g, '\\"')}"`,
      { encoding: 'utf8', timeout: 15000 }
    );
    success++;
    if ((i + 1) % 50 === 0) console.log(`Progress: ${i + 1}/${toFix.length} (${success} ok, ${fail} fail)`);
  } catch (e) {
    fail++;
    console.log(`FAIL: ${job.name} (${job.id}): ${e.message.substring(0, 100)}`);
  }
}

console.log(`\nDone! Success: ${success}, Fail: ${fail}`);
