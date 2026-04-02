const { execSync } = require('child_process');
const fs = require('fs');

console.log('Fetching tagless jobs...');
const raw = execSync(
  `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT id, name, json_extract(merged_profile_json, '$.heroCategory') as category FROM jobs WHERE is_active = 1 AND (json_extract(merged_profile_json, '$.heroTags') IS NULL OR json_array_length(json_extract(merged_profile_json, '$.heroTags')) = 0)"`,
  { encoding: 'utf8', maxBuffer: 200 * 1024 * 1024 }
);

const parsed = JSON.parse(raw);
const jobs = parsed[0].results;
console.log(`Total tagless jobs: ${jobs.length}`);

// Category extraction
function parseCategory(catJson) {
  if (!catJson) return null;
  try {
    const cat = JSON.parse(catJson);
    return cat.value || cat.large || null;
  } catch { return null; }
}

// Generate tags from job name + category
// Strategy: the job name itself becomes the primary tag,
// plus we extract meaningful sub-components
function generateTags(name, category) {
  const tags = new Set();

  // The job name is always a tag (if not too long)
  if (name.length <= 15) tags.add(name);

  // Extract category as tag (skip vague/long ones)
  if (category) {
    const cat = parseCategory(category);
    if (cat && cat.length <= 10 && !cat.startsWith('기타') && cat !== '전체' && !cat.includes('서비스업') && !cat.includes('제조업')) {
      tags.add(cat);
    }
  }

  // Common suffix patterns → extract the field/domain
  const suffixPatterns = [
    { suffix: '관리자', extract: (n) => n.replace(/관리자$/, '') },
    { suffix: '연구원', extract: (n) => n.replace(/연구원$/, '') },
    { suffix: '기술자', extract: (n) => n.replace(/기술자$/, '') },
    { suffix: '기사', extract: (n) => n.replace(/기사$/, '') },
    { suffix: '설계자', extract: (n) => n.replace(/설계자$/, '') },
    { suffix: '개발자', extract: (n) => n.replace(/개발자$/, '') },
    { suffix: '전문가', extract: (n) => n.replace(/전문가$/, '') },
    { suffix: '기획자', extract: (n) => n.replace(/기획자$/, '') },
    { suffix: '엔지니어', extract: (n) => n.replace(/엔지니어$/, '') },
    { suffix: '디자이너', extract: (n) => n.replace(/디자이너$/, '') },
    { suffix: '상담사', extract: (n) => n.replace(/상담사$/, '') },
    { suffix: '교사', extract: (n) => n.replace(/교사$/, '') },
    { suffix: '강사', extract: (n) => n.replace(/강사$/, '') },
    { suffix: '조작원', extract: (n) => n.replace(/조작원$/, '') },
    { suffix: '운전원', extract: (n) => n.replace(/운전원$/, '') },
    { suffix: '정비원', extract: (n) => n.replace(/정비원$/, '') },
    { suffix: '원장', extract: (n) => n.replace(/원장$/, '') },
    { suffix: '서장', extract: (n) => n.replace(/서장$/, '') },
    { suffix: '총장', extract: (n) => n.replace(/총장$/, '') },
    { suffix: '처장', extract: (n) => n.replace(/처장$/, '') },
  ];

  for (const { suffix, extract } of suffixPatterns) {
    if (name.endsWith(suffix)) {
      const domain = extract(name);
      if (domain.length >= 2 && domain.length <= 12) {
        tags.add(domain);
      }
      // Also add the role type
      if (suffix.length >= 2) tags.add(suffix);
      break;
    }
  }

  return Array.from(tags).filter(t => t.length >= 2);
}

const updates = [];

for (const job of jobs) {
  const tags = generateTags(job.name, job.category);
  if (tags.length > 0) {
    updates.push({ id: job.id, name: job.name, tags });
  }
}

console.log(`Generated tags for: ${updates.length} jobs`);

// Samples
console.log('\n=== Samples (first 30) ===\n');
for (const u of updates.slice(0, 30)) {
  console.log(`${u.name} → [${u.tags.join(', ')}]`);
}

// Save
fs.writeFileSync('C:/Users/PC/Careerwiki/tmp_new_tags.json', JSON.stringify(updates, null, 2));
console.log(`\nSaved to tmp_new_tags.json`);
