const fs = require('fs');

const jobData = JSON.parse(fs.readFileSync('tmp_all_job_slugs.json', 'utf8'));
const majorData = JSON.parse(fs.readFileSync('tmp_all_major_slugs.json', 'utf8'));
const allJobSlugs = jobData[0].results.map(r => r.slug);
const allMajorSlugs = majorData[0].results.map(r => r.slug);

const { missingJobs, missingMajors } = JSON.parse(fs.readFileSync('tmp_missing_links.json', 'utf8'));

// For each missing slug, try to find a match
function findMatches(missing, existing) {
  const results = {};
  missing.forEach(slug => {
    // Remove hyphens and spaces for comparison
    const clean = slug.replace(/[-\s]/g, '');

    // Exact match (with hyphen removed)
    const exact = existing.find(e => e === clean);
    if (exact) {
      results[slug] = { match: exact, type: 'exact-clean' };
      return;
    }

    // Contains match - slug is contained in an existing slug
    const contains = existing.filter(e => e.includes(clean) || clean.includes(e));
    if (contains.length > 0 && contains.length <= 5) {
      results[slug] = { match: contains[0], candidates: contains.slice(0, 5), type: 'contains' };
      return;
    }

    // Partial match - first 3 chars
    const partial = existing.filter(e => e.startsWith(clean.substring(0, 3)));
    if (partial.length > 0 && partial.length <= 10) {
      results[slug] = { match: null, candidates: partial.slice(0, 5), type: 'partial' };
      return;
    }

    results[slug] = { match: null, type: 'no-match' };
  });
  return results;
}

const jobMatches = findMatches(missingJobs, allJobSlugs);
const majorMatches = findMatches(missingMajors, allMajorSlugs);

console.log('=== JOB MATCHES ===');
Object.entries(jobMatches).forEach(([slug, info]) => {
  if (info.type === 'exact-clean') {
    console.log(`  ✓ ${slug} → ${info.match}`);
  } else if (info.type === 'contains') {
    console.log(`  ? ${slug} → candidates: ${info.candidates.join(', ')}`);
  } else if (info.type === 'partial') {
    console.log(`  ~ ${slug} → partial: ${info.candidates.join(', ')}`);
  } else {
    console.log(`  ✗ ${slug} → NO MATCH`);
  }
});

console.log('\n=== MAJOR MATCHES ===');
Object.entries(majorMatches).forEach(([slug, info]) => {
  if (info.type === 'exact-clean') {
    console.log(`  ✓ ${slug} → ${info.match}`);
  } else if (info.type === 'contains') {
    console.log(`  ? ${slug} → candidates: ${info.candidates.join(', ')}`);
  } else if (info.type === 'partial') {
    console.log(`  ~ ${slug} → partial: ${info.candidates.join(', ')}`);
  } else {
    console.log(`  ✗ ${slug} → NO MATCH`);
  }
});

fs.writeFileSync('tmp_slug_matches.json', JSON.stringify({ jobMatches, majorMatches }, null, 2));
