const { execSync } = require('child_process');
const fs = require('fs');

// Step 1: Get all jobs without heroTags + their API data sources
console.log('Fetching jobs without tags...');
const raw = execSync(
  `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT id, name, json_extract(merged_profile_json, '$.heroCategory') as category, json_extract(api_data_json, '$.CAREERNET.encyclopedia.baseInfo.tag') as cn_tag, json_extract(api_data_json, '$.CAREERNET.encyclopedia.tagList') as cn_tagList, json_extract(api_data_json, '$.WORK24_DJOB.similarNm') as djob_similar, json_extract(api_data_json, '$.WORK24_DJOB.optionJobInfo.similarNm') as djob_similar2 FROM jobs WHERE is_active = 1 AND (json_extract(merged_profile_json, '$.heroTags') IS NULL OR json_array_length(json_extract(merged_profile_json, '$.heroTags')) = 0)"`,
  { encoding: 'utf8', maxBuffer: 200 * 1024 * 1024 }
);

const parsed = JSON.parse(raw);
const jobs = parsed[0].results;
console.log(`Total jobs without tags: ${jobs.length}`);

// Tag generation rules
const INVALID_TAGS = new Set(['등', '외', '기타', '및', '그외', '그 외', '기타 등', '등등']);

// Sentence fragment filter (from step 1)
function isSentenceFragment(tag) {
  if (!tag || tag.length <= 1) return true;
  if (INVALID_TAGS.has(tag)) return true;
  if (/^[0-9]+$/.test(tag)) return true;
  // Josa endings on short words
  if (tag.length <= 4 && /[을를의에는은이가]$/.test(tag)) return true;
  // Common fragments
  if (/^(따라|경우|있는|하는|되는|없는|않는|위한|위하여|통해|대한|같은|동의|담당하는|연구하는|전문적으로|종사하는|대표하는|운전하는|촬영하는|설명하는|응대하는|디자인하는)$/.test(tag)) return true;
  // Josa-heavy patterns
  if (/^.{1,3}(의|에|를|을)$/.test(tag)) return true;
  if (/^(프로그램에|업무형태에|매체에|분야에|과목에|종류에|성격에|종류나|신체의|일부분만을|광고에서)$/.test(tag)) return true;
  // Broken parens
  if (/^\(/.test(tag) && !/\)/.test(tag)) return true;
  if (/\)$/.test(tag) && !/\(/.test(tag)) return true;
  // Split English
  if (/^(Executive|Officer|Privacy|Information|Marketing|Technology|Financial|Operating|Knowledge|Administration|Security|Director|Technical)$/i.test(tag)) return true;
  return false;
}

function extractTags(source) {
  if (!source) return [];
  if (typeof source === 'string') {
    // Split by comma only (NOT space)
    return source.split(/[,，]+/).map(t => t.trim()).filter(t => t.length >= 2 && !isSentenceFragment(t));
  }
  if (Array.isArray(source)) {
    return source.map(t => typeof t === 'string' ? t.trim() : '').filter(t => t.length >= 2 && !isSentenceFragment(t));
  }
  // Might be JSON string of array
  try {
    const arr = JSON.parse(source);
    if (Array.isArray(arr)) return arr.map(t => typeof t === 'string' ? t.trim() : '').filter(t => t.length >= 2 && !isSentenceFragment(t));
  } catch {}
  return [];
}

// Rejoin English abbreviations
function rejoinAbbrs(tags) {
  const result = [];
  let i = 0;
  while (i < tags.length) {
    const t = tags[i];
    if (/^[A-Z]{2,}\([A-Z][a-z]/.test(t)) {
      result.push(t.split('(')[0]);
      let j = i + 1;
      while (j < tags.length && !tags[j].endsWith(')')) j++;
      i = j + 1;
    } else {
      result.push(t);
      i++;
    }
  }
  return result;
}

const updates = [];
let noSourceCount = 0;

for (const job of jobs) {
  const tagSet = new Set();

  // Source 1: CareerNet tag
  for (const t of extractTags(job.cn_tag)) tagSet.add(t);

  // Source 2: CareerNet tagList
  for (const t of extractTags(job.cn_tagList)) tagSet.add(t);

  // Source 3: DJOB similarNm
  const similar = job.djob_similar || job.djob_similar2;
  for (const t of extractTags(similar)) tagSet.add(t);

  let tags = rejoinAbbrs(Array.from(tagSet));

  // Deduplicate
  const seen = new Set();
  tags = tags.filter(t => {
    const k = t.toLowerCase();
    if (seen.has(k)) return false;
    seen.add(k);
    return true;
  });

  if (tags.length === 0) {
    noSourceCount++;
    continue;
  }

  updates.push({ id: job.id, name: job.name, tags });
}

console.log(`\nGenerated tags for: ${updates.length} jobs`);
console.log(`No tag sources available: ${noSourceCount} jobs`);

// Samples
console.log('\n=== Samples ===\n');
for (const u of updates.slice(0, 15)) {
  console.log(`${u.name}: ${u.tags.join(', ')}`);
}

// Save
fs.writeFileSync('C:/Users/PC/Careerwiki/tmp_new_tags.json', JSON.stringify(updates, null, 2));
console.log(`\nSaved to tmp_new_tags.json`);
