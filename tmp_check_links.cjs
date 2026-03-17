const fs = require('fs');

// Load existing slugs
const jobData = JSON.parse(fs.readFileSync('tmp_all_job_slugs.json', 'utf8'));
const majorData = JSON.parse(fs.readFileSync('tmp_all_major_slugs.json', 'utf8'));
const existingJobSlugs = new Set(jobData[0].results.map(r => r.slug));
const existingMajorSlugs = new Set(majorData[0].results.map(r => r.slug));

console.log(`Existing jobs: ${existingJobSlugs.size}, majors: ${existingMajorSlugs.size}`);

// Load links
const { allLinks, jobSlugs, majorSlugs } = JSON.parse(fs.readFileSync('tmp_internal_links.json', 'utf8'));

// Check which don't exist
const missingJobs = jobSlugs.filter(s => !existingJobSlugs.has(s));
const missingMajors = majorSlugs.filter(s => !existingMajorSlugs.has(s));

console.log(`\n=== Missing Job Slugs (${missingJobs.length}) ===`);
missingJobs.forEach(s => {
  const guides = allLinks.filter(l => l.slug === s && l.type === 'job').map(l => `${l.guideId}:${l.guideSlug.substring(0,30)}`);
  console.log(`  ${s} → used in: ${guides.join(', ')}`);
});

console.log(`\n=== Missing Major Slugs (${missingMajors.length}) ===`);
missingMajors.forEach(s => {
  const guides = allLinks.filter(l => l.slug === s && l.type === 'major').map(l => `${l.guideId}:${l.guideSlug.substring(0,30)}`);
  console.log(`  ${s} → used in: ${guides.join(', ')}`);
});

// Save missing for next step
fs.writeFileSync('tmp_missing_links.json', JSON.stringify({ missingJobs, missingMajors }, null, 2));
