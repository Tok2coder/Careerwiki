const { execSync } = require('child_process');
const fs = require('fs');

const ABBR_MAP = {
  'CEO': 'Chief Executive Officer',
  'CTO': 'Chief Technology Officer',
  'CFO': 'Chief Financial Officer',
  'COO': 'Chief Operating Officer',
  'CMO': 'Chief Marketing Officer',
  'CIO': 'Chief Information Officer',
  'CPO': 'Chief Privacy Officer',
  'CKO': 'Chief Knowledge Officer',
  'CAO': 'Chief Administration Officer',
  'CISO': 'Chief Information Security Officer',
  'CSO': 'Chief Security Officer',
  'CD': 'Creative Director',
};

console.log('Fetching jobs with abbreviation tags...');
const raw = execSync(
  `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT id, name, json_extract(merged_profile_json, '$.heroTags') as tags FROM jobs WHERE is_active = 1 AND json_extract(merged_profile_json, '$.heroTags') IS NOT NULL"`,
  { encoding: 'utf8', maxBuffer: 100 * 1024 * 1024 }
);

const parsed = JSON.parse(raw);
const jobs = parsed[0].results;

const toUpdate = [];

for (const job of jobs) {
  let tags;
  try { tags = JSON.parse(job.tags); } catch { continue; }
  if (!Array.isArray(tags)) continue;

  let changed = false;
  const newTags = [...tags];
  const existing = new Set(tags.map(t => t.toLowerCase()));

  for (const tag of tags) {
    const upper = tag.toUpperCase();
    if (ABBR_MAP[upper]) {
      const fullName = ABBR_MAP[upper];
      if (!existing.has(fullName.toLowerCase())) {
        newTags.push(fullName);
        existing.add(fullName.toLowerCase());
        changed = true;
      }
    }
  }

  if (changed) {
    toUpdate.push({ id: job.id, name: job.name, tags: newTags });
  }
}

console.log(`Jobs to update: ${toUpdate.length}`);

// Apply updates
let success = 0, fail = 0;
const BATCH_SIZE = 20;

for (let b = 0; b < toUpdate.length; b += BATCH_SIZE) {
  const slice = toUpdate.slice(b, b + BATCH_SIZE);
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
    // one by one fallback
    for (const j of slice) {
      const json = JSON.stringify(j.tags).replace(/'/g, "''");
      fs.writeFileSync(sqlFile, `UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.heroTags', json('${json}')) WHERE id = '${j.id}';`);
      try {
        execSync(`npx wrangler d1 execute careerwiki-kr --remote --file="${sqlFile}"`, { encoding: 'utf8', timeout: 15000 });
        success++;
      } catch { fail++; console.log(`FAIL: ${j.name}`); }
    }
  }
}

console.log(`\nDone! Success: ${success}, Fail: ${fail}`);

// Show samples
for (const j of toUpdate.slice(0, 5)) {
  console.log(`${j.name}: ${j.tags.join(', ')}`);
}
