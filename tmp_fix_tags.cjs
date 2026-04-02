const { execSync } = require('child_process');

// Step 1: Get all jobs with heroTags
console.log('Fetching all jobs with heroTags...');
const raw = execSync(
  `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT id, name, json_extract(merged_profile_json, '$.heroTags') as tags FROM jobs WHERE is_active = 1 AND json_extract(merged_profile_json, '$.heroTags') IS NOT NULL AND json_array_length(json_extract(merged_profile_json, '$.heroTags')) > 0"`,
  { encoding: 'utf8', maxBuffer: 100 * 1024 * 1024 }
);

const parsed = JSON.parse(raw);
const jobs = parsed[0].results;
console.log(`Total jobs with tags: ${jobs.length}`);

// Sentence fragment indicators - these should NOT be tags
const JOSA_PATTERNS = /^(의|를|을|에서|에|는|은|이|가|와|과|로|으로|도|만|까지|부터|에게|한테|께|에서부터|으로서|으로써|라|이라|처럼|같은|보다|마다|밖에|조차|따라|대한|위한|위하여|통해|통하여|관한|있는|하는|되는|하여|않는|없는|같은|경우|등의|등을|등에|등이)$/;

const FRAGMENT_PATTERNS = [
  /^.{1}$/, // 1 char
  /[을를이가은는에서의로]+$/, // ends with josa
  /^(동의|신체의|일부분만을|광고에서|보여주는|하는|경우|있는|따라|등의|등을|걸어|담당하는|연구하는|전문적으로|수립하여|사이의)$/,
  /^(종류에|업무형태에|매체에|분야에|과목에|운전하는|버스의|차량의|출판물의|종류나|연구분야에|가르치는|지도하는|취재|활동을)$/,
  /^(텔레비전|라디오|광고대행사와|광고주|연락|기획업무를|교도소의|관장\)|선발된|모범수형자를|집결하여|수용자치제를|허용하고)$/,
  /^(홈쇼핑|등에서|의상의|착용사진을|전문으로|촬영하는|누드화의|모델이|되는)$/,
  /^(Urban|Designer|도시|내부를|연결하는|건설하고|설치한|등\)을|디자인하는)$/,
  /^(광고회사에서|광고물을|광고주나|예상고객에게|제시하고|설명하는)$/,
  /^(고객의|문의나|상담에|응대하는|직접|전화를|권유하고)$/,
  /^(외국에|주재하여)$/,
  /\)$/, // ends with )
  /^\(/, // starts with (
  /^(CEO|CPO|Officer|Executive|Chief|Privacy|Management|Relationship|Customer|CRM)$/i, // split English
];

function isBrokenTag(tag) {
  if (!tag || typeof tag !== 'string') return true;
  const t = tag.trim();
  if (t.length <= 1) return true;
  if (t.length > 20) return true; // too long for a tag
  if (JOSA_PATTERNS.test(t)) return true;
  for (const p of FRAGMENT_PATTERNS) {
    if (p.test(t)) return true;
  }
  // Check if it looks like a sentence fragment (has verb endings)
  if (/[다는를을에]$/.test(t) && t.length <= 4) return true;
  return false;
}

let brokenCount = 0;
let cleanCount = 0;
const brokenJobs = [];

for (const job of jobs) {
  let tags;
  try {
    tags = JSON.parse(job.tags);
  } catch (e) { continue; }

  if (!Array.isArray(tags)) continue;

  const brokenTags = tags.filter(t => isBrokenTag(t));
  const cleanTags = tags.filter(t => !isBrokenTag(t));

  if (brokenTags.length > 0) {
    brokenCount++;
    brokenJobs.push({
      id: job.id,
      name: job.name,
      original: tags,
      broken: brokenTags,
      clean: cleanTags
    });
  } else {
    cleanCount++;
  }
}

console.log(`\nClean: ${cleanCount}, Broken: ${brokenCount}`);
console.log(`\n=== Sample broken jobs (first 20) ===\n`);

for (const j of brokenJobs.slice(0, 20)) {
  console.log(`${j.name} (${j.id})`);
  console.log(`  Original (${j.original.length}): ${j.original.join(', ')}`);
  console.log(`  Broken: ${j.broken.join(', ')}`);
  console.log(`  Clean (${j.clean.length}): ${j.clean.join(', ')}`);
  console.log();
}

// Save full list for review
const fs = require('fs');
fs.writeFileSync('C:/Users/PC/Careerwiki/tmp_broken_tags.json', JSON.stringify(brokenJobs, null, 2));
console.log(`\nFull list saved to tmp_broken_tags.json (${brokenJobs.length} jobs)`);
