const { execSync } = require('child_process');
const fs = require('fs');
const { missingJobs, missingMajors } = JSON.parse(fs.readFileSync('tmp_missing_links.json', 'utf8'));

// Test each slug via curl
function testSlug(type, slug) {
  const encoded = encodeURIComponent(slug);
  const url = `https://careerwiki.org/${type}/${encoded}`;
  try {
    const result = execSync(`curl -s -o /dev/null -w "%{http_code}" "${url}"`, { timeout: 15000 }).toString().trim();
    return { slug, type, status: parseInt(result), url };
  } catch (e) {
    return { slug, type, status: 'error', url };
  }
}

console.log('Testing job links...');
const jobResults = missingJobs.map(s => testSlug('job', s));
const brokenJobs = jobResults.filter(r => r.status !== 200);
const okJobs = jobResults.filter(r => r.status === 200);

console.log(`  OK: ${okJobs.length}, Broken (302/other): ${brokenJobs.length}`);
brokenJobs.forEach(r => console.log(`  ${r.status} /job/${r.slug}`));

console.log('\nTesting major links...');
const majorResults = missingMajors.map(s => testSlug('major', s));
const brokenMajors = majorResults.filter(r => r.status !== 200);
const okMajors = majorResults.filter(r => r.status === 200);

console.log(`  OK: ${okMajors.length}, Broken (302/other): ${brokenMajors.length}`);
brokenMajors.forEach(r => console.log(`  ${r.status} /major/${r.slug}`));

fs.writeFileSync('tmp_broken_links.json', JSON.stringify({ brokenJobs, brokenMajors }, null, 2));
console.log(`\nTotal truly broken: ${brokenJobs.length} jobs + ${brokenMajors.length} majors`);
