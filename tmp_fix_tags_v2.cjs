const { execSync } = require('child_process');
const fs = require('fs');

// Step 1: Get all jobs with heroTags
console.log('Fetching all jobs with heroTags...');
const raw = execSync(
  `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT id, name, json_extract(merged_profile_json, '$.heroTags') as tags FROM jobs WHERE is_active = 1 AND json_extract(merged_profile_json, '$.heroTags') IS NOT NULL AND json_array_length(json_extract(merged_profile_json, '$.heroTags')) > 0"`,
  { encoding: 'utf8', maxBuffer: 100 * 1024 * 1024 }
);

const parsed = JSON.parse(raw);
const jobs = parsed[0].results;
console.log(`Total jobs with tags: ${jobs.length}`);

// ========== TAG FIXING RULES ==========

// 1. Rejoin split English abbreviations: CEO(Chief + Executive + Officer) → CEO
function rejoinEnglishAbbrs(tags) {
  const result = [];
  let i = 0;
  while (i < tags.length) {
    const t = tags[i];
    // Pattern: "XXX(Word" starts an abbreviation
    if (/^[A-Z]{2,}\([A-Z][a-z]/.test(t)) {
      // Collect until we find "Word)" ending
      let abbr = t.split('(')[0]; // Extract just the abbreviation
      let j = i + 1;
      while (j < tags.length && !tags[j].endsWith(')')) j++;
      // Skip all the English words, keep just the abbreviation
      result.push(abbr);
      i = j + 1;
    } else {
      result.push(t);
      i++;
    }
  }
  return result;
}

// 2. Sentence fragment detection
const SENTENCE_FRAGMENTS = new Set([
  '따라', '경우', '있는', '하는', '되는', '없는', '않는', '위한', '위하여', '통해', '통하여',
  '관한', '대한', '같은', '동의', '사이의', '담당하는', '연구하는', '전문적으로', '수립하여',
  '보여주는', '종사하는', '대표하는', '운전하는', '가르치는', '지도하는', '촬영하는',
  '설명하는', '응대하는', '디자인하는', '걸어', '권유하고', '허용하고', '집결하여',
  '제시하고', '건설하고', '연결하는', '설치한', '선발된',
]);

const JOSA_ENDINGS = [
  '에서', '에게', '한테', '으로', '에서부터', '으로서', '으로써',
  '만을', '에서의', '과의', '와의', '까지의',
];

function isSentenceFragment(tag) {
  if (!tag || tag.length <= 1) return true;

  // Exact match fragments
  if (SENTENCE_FRAGMENTS.has(tag)) return true;

  // Ends with josa (but not a valid compound noun)
  for (const josa of JOSA_ENDINGS) {
    if (tag.endsWith(josa) && tag.length < 8) return true;
  }

  // Short words ending with common josa (but allow known valid tags)
  const VALID_SHORT_TAGS = new Set([
    '소믈리에', '동화놀이', '패러글라이', '보울러', '프로게이머',
    '바리스타', '파티시에', '큐레이터', '소프트웨어', '프리랜서',
    '아나운서', '프로듀서', '디자이너', '엔지니어', '매니저',
    '콘텐츠', '마케팅', '서비스', '플래너', '컨설팅',
  ]);
  if (tag.length <= 4 && /[을를의에는은이가]$/.test(tag) && !VALID_SHORT_TAGS.has(tag)) return true;

  // Patterns like "~의", "~에", "~를" that are clearly fragments
  if (/^.{1,3}(의|에|를|을|는|은|가|이)$/.test(tag)) return true;

  // Specific fragment patterns
  if (/^(프로그램에|업무형태에|매체에|분야에|과목에|종류에|성격에|종류나|분야의)$/.test(tag)) return true;
  if (/^(버스의|차량의|출판물의|단체의|교도소의|신체의|일부분만을|광고에서)$/.test(tag)) return true;
  // 텔레비전/라디오는 맥락에 따라 유효할 수 있으므로 제거하지 않음

  // Starts with ( or ends with ) alone
  if (/^\(/.test(tag) && !/\)/.test(tag)) return true;
  if (/\)$/.test(tag) && !/\(/.test(tag)) return true;

  // Pure English words that are part of split abbreviations
  if (/^(Executive|Officer|Privacy|Information|Marketing|Technology|Financial|Operating|Knowledge|Administration|Security|Relationship|Management|Customer|Director|Technical)$/i.test(tag)) return true;

  return false;
}

// 3. Clean parenthesized tags: "도장원(도장기조작원)" → keep as-is (valid alternate name)
function isValidParenTag(tag) {
  // "직업명(다른이름)" pattern is valid
  return /^[가-힣A-Za-z]+\([가-힣A-Za-z·\s]+\)$/.test(tag);
}

// ========== PROCESS ==========

const toFix = [];
let alreadyClean = 0;

for (const job of jobs) {
  let tags;
  try { tags = JSON.parse(job.tags); } catch (e) { continue; }
  if (!Array.isArray(tags)) continue;

  // Step 1: Rejoin English abbreviations
  let cleaned = rejoinEnglishAbbrs(tags);

  // Step 2: Remove sentence fragments
  cleaned = cleaned.filter(t => {
    if (isValidParenTag(t)) return true;
    return !isSentenceFragment(t);
  });

  // Step 3: Remove duplicates (case-insensitive for Korean)
  const seen = new Set();
  cleaned = cleaned.filter(t => {
    const key = t.toLowerCase().trim();
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });

  // Step 4: Trim and filter empty
  cleaned = cleaned.map(t => t.trim()).filter(t => t.length >= 2);

  // Check if anything changed
  const origStr = JSON.stringify(tags);
  const cleanStr = JSON.stringify(cleaned);

  if (origStr !== cleanStr) {
    toFix.push({
      id: job.id,
      name: job.name,
      original: tags,
      fixed: cleaned,
      removed: tags.filter(t => !cleaned.includes(t)),
    });
  } else {
    alreadyClean++;
  }
}

console.log(`\nAlready clean: ${alreadyClean}`);
console.log(`Need fixing: ${toFix.length}`);

// Show samples
console.log('\n=== Fix samples (first 15) ===\n');
for (const j of toFix.slice(0, 15)) {
  console.log(`${j.name}`);
  console.log(`  Before (${j.original.length}): ${j.original.slice(0, 8).join(', ')}${j.original.length > 8 ? '...' : ''}`);
  console.log(`  After  (${j.fixed.length}): ${j.fixed.slice(0, 8).join(', ')}${j.fixed.length > 8 ? '...' : ''}`);
  console.log(`  Removed: ${j.removed.join(', ')}`);
  console.log();
}

// Save for batch update
fs.writeFileSync('C:/Users/PC/Careerwiki/tmp_tags_to_fix.json', JSON.stringify(toFix, null, 2));
console.log(`Saved ${toFix.length} jobs to tmp_tags_to_fix.json`);

// Generate SQL for batch update (via user_contributed_json heroTags field)
// We'll use the edit API instead for safety
