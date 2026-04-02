const { execSync } = require('child_process');
const fs = require('fs');

const { allLinks } = JSON.parse(fs.readFileSync('tmp_internal_links.json', 'utf8'));

// Get unique broken slugs by type
const jobSlugs = [...new Set(allLinks.filter(l => l.type === 'job').map(l => l.slug))];
const majorSlugs = [...new Set(allLinks.filter(l => l.type === 'major').map(l => l.slug))];

function query(sql) {
  const escaped = sql.replace(/"/g, '\\"');
  try {
    const result = execSync(`npx wrangler d1 execute careerwiki-kr --remote --command "${escaped}" --json`, {
      cwd: 'C:/Users/PC/Careerwiki',
      stdio: 'pipe',
      timeout: 15000
    }).toString();
    return JSON.parse(result)[0].results;
  } catch (e) {
    return [];
  }
}

// For each slug, check if it resolves
function resolveJobSlug(slug) {
  const clean = slug.replace(/-/g, '').replace(/\s/g, '');

  // Step 1: exact slug match
  let results = query(`SELECT slug, name FROM jobs WHERE slug = '${slug}' LIMIT 1`);
  if (results.length > 0) return { slug, resolved: results[0].slug, name: results[0].name, method: 'exact' };

  // Step 2: slug without hyphens
  results = query(`SELECT slug, name FROM jobs WHERE REPLACE(slug, '-', '') = '${clean}' LIMIT 1`);
  if (results.length > 0) return { slug, resolved: results[0].slug, name: results[0].name, method: 'no-hyphen' };

  // Step 3: name_normalized
  const normalized = slug.toLowerCase().replace(/[-,·ㆍ\/\s()]/g, '');
  results = query(`SELECT slug, name FROM jobs WHERE name_normalized = '${normalized}' LIMIT 1`);
  if (results.length > 0) return { slug, resolved: results[0].slug, name: results[0].name, method: 'name_normalized' };

  // Step 4: name LIKE
  const firstWord = slug.split('-')[0];
  if (firstWord.length >= 2) {
    results = query(`SELECT slug, name FROM jobs WHERE name LIKE '%${firstWord}%' LIMIT 5`);
    if (results.length > 0) return { slug, resolved: null, name: null, method: 'suggestions', candidates: results };
  }

  return { slug, resolved: null, name: null, method: 'no-match' };
}

function resolveMajorSlug(slug) {
  const clean = slug.replace(/-/g, '').replace(/\s/g, '');

  let results = query(`SELECT slug, name FROM majors WHERE slug = '${slug}' LIMIT 1`);
  if (results.length > 0) return { slug, resolved: results[0].slug, name: results[0].name, method: 'exact' };

  results = query(`SELECT slug, name FROM majors WHERE REPLACE(slug, '-', '') = '${clean}' LIMIT 1`);
  if (results.length > 0) return { slug, resolved: results[0].slug, name: results[0].name, method: 'no-hyphen' };

  const normalized = slug.toLowerCase().replace(/[-,·ㆍ\/\s()]/g, '');
  results = query(`SELECT slug, name FROM majors WHERE name_normalized = '${normalized}' LIMIT 1`);
  if (results.length > 0) return { slug, resolved: results[0].slug, name: results[0].name, method: 'name_normalized' };

  return { slug, resolved: null, name: null, method: 'no-match' };
}

console.log('Resolving', jobSlugs.length, 'job slugs...');
const jobResolutions = jobSlugs.map((s, i) => {
  if (i % 10 === 0) process.stdout.write(`  ${i}/${jobSlugs.length}\r`);
  return resolveJobSlug(s);
});
console.log();

console.log('Resolving', majorSlugs.length, 'major slugs...');
const majorResolutions = majorSlugs.map((s, i) => {
  return resolveMajorSlug(s);
});

// Report
const resolved = jobResolutions.filter(r => r.resolved);
const unresolved = jobResolutions.filter(r => !r.resolved);

console.log(`\n=== JOB RESOLUTIONS ===`);
console.log(`Resolved: ${resolved.length}, Unresolved: ${unresolved.length}`);
resolved.forEach(r => console.log(`  ✓ ${r.slug} → ${r.resolved} (${r.method})`));
console.log(`\n  Unresolved:`);
unresolved.forEach(r => {
  if (r.candidates) {
    console.log(`  ✗ ${r.slug} → suggestions: ${r.candidates.map(c => c.slug).join(', ')}`);
  } else {
    console.log(`  ✗ ${r.slug} → NO MATCH`);
  }
});

const mResolved = majorResolutions.filter(r => r.resolved);
const mUnresolved = majorResolutions.filter(r => !r.resolved);
console.log(`\n=== MAJOR RESOLUTIONS ===`);
console.log(`Resolved: ${mResolved.length}, Unresolved: ${mUnresolved.length}`);
mResolved.forEach(r => console.log(`  ✓ ${r.slug} → ${r.resolved} (${r.method})`));
mUnresolved.forEach(r => console.log(`  ✗ ${r.slug}`));

fs.writeFileSync('tmp_link_resolutions.json', JSON.stringify({ jobResolutions, majorResolutions }, null, 2));
