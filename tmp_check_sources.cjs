const fs = require('fs');
const { execSync } = require('child_process');

// Fetch data from 5 jobs
const jobs = [
  { id: '1765283284733631', name: '경찰관' },
  { id: '1765283329480426', name: '소방관' },
  { id: '1765283308861305', name: '미용사' },
  { id: '1765283315034317', name: '변호사' },
  { id: '1765283331383599', name: '수의사' },
];

for (const job of jobs) {
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT user_contributed_json FROM jobs WHERE id='${job.id}'"`,
      { encoding: 'utf8', timeout: 30000 }
    );
    const parsed = JSON.parse(result);
    const ucj = parsed[0].results[0].user_contributed_json;
    if (!ucj) {
      console.log(`\n=== ${job.name}: NO DATA ===`);
      continue;
    }
    const data = JSON.parse(ucj);
    const fields = Object.keys(data).filter(k => k !== '_sources');
    console.log(`\n=== ${job.name} ===`);
    console.log(`Fields: ${fields.join(', ')}`);

    if (data._sources) {
      const sourceKeys = Object.keys(data._sources);
      console.log(`Source keys: ${sourceKeys.join(', ')}`);
      let totalSources = 0;
      for (const [k, v] of Object.entries(data._sources)) {
        totalSources += v.length;
        console.log(`  ${k}: ${v.length}개 (IDs: ${v.map(s => s.id).join(',')})`);
      }
      console.log(`Total sources: ${totalSources}`);
    } else {
      console.log('NO _sources found!');
    }
  } catch (e) {
    console.log(`\n=== ${job.name}: ERROR === ${e.message.substring(0, 100)}`);
  }
}
