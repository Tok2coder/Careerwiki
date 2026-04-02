const { execSync } = require('child_process');
const result = execSync(`npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT merged_profile_json FROM jobs WHERE name = '작곡가' AND is_active = 1"`, {encoding:'utf8', timeout: 30000});
const parsed = JSON.parse(result);
const row = parsed[0].results[0];
const profile = JSON.parse(row.merged_profile_json);

console.log('=== TOP LEVEL KEYS ===');
console.log(Object.keys(profile).join('\n'));

console.log('\n=== way? ===', profile.way ? profile.way.substring(0,100) : 'NULL');
console.log('\n=== trivia? ===', profile.trivia ? profile.trivia.substring(0,100) : 'NULL');

if (profile.overviewSalary) {
  console.log('\n=== overviewSalary keys ===', Object.keys(profile.overviewSalary).join(','));
  if (profile.overviewSalary.sal) console.log('sal:', String(profile.overviewSalary.sal).substring(0,200));
}

if (profile.overviewProspect) {
  console.log('\n=== overviewProspect keys ===', Object.keys(profile.overviewProspect).join(','));
  if (profile.overviewProspect.main) console.log('main:', String(profile.overviewProspect.main).substring(0,200));
}

if (profile.detailWlb) {
  console.log('\n=== detailWlb keys ===', Object.keys(profile.detailWlb).join(','));
}

if (profile.detailEducation) {
  console.log('\n=== detailEducation keys ===', Object.keys(profile.detailEducation).join(','));
  if (profile.detailEducation.way) console.log('way:', String(profile.detailEducation.way).substring(0,300));
}
