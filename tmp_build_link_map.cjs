const fs = require('fs');

// Load all existing slugs from DB
const jobData = JSON.parse(fs.readFileSync('tmp_all_job_slugs.json', 'utf8'));
const majorData = JSON.parse(fs.readFileSync('tmp_all_major_slugs.json', 'utf8'));

// These have prefix like "job:변호사" - strip prefix for matching
const existingJobSlugs = jobData[0].results.map(r => r.slug);
const existingMajorSlugs = majorData[0].results.map(r => r.slug);

// Get the name part (after the prefix)
const jobNames = new Map(); // name -> full slug
existingJobSlugs.forEach(s => {
  const name = s.replace(/^job:/, '');
  jobNames.set(name, s);
  // Also store without hyphens
  jobNames.set(name.replace(/-/g, ''), s);
});

const majorNames = new Map();
existingMajorSlugs.forEach(s => {
  const name = s.replace(/^major:/, '');
  majorNames.set(name, s);
  majorNames.set(name.replace(/-/g, ''), s);
});

const { allLinks } = JSON.parse(fs.readFileSync('tmp_internal_links.json', 'utf8'));

// For each link, find correct slug
// The URL format should be /job/{slug} where slug matches the jobs table slug field
// Let me check what the actual DB structure is

// Actually, from the route code, it does:
// 1. jobs.slug = decodedSlug
// 2. jobs.slug with hyphens removed
// 3. jobs.name_normalized
// So the link /job/변호사 works if there's a job with slug='변호사' or name_normalized='변호사'

// But we also saw that some have "job:" prefix in the pages table slugs
// The jobs table slug is different from pages table slug
// Let me just query the jobs table directly to get correct slugs

console.log('Job names map size:', jobNames.size);
console.log('Major names map size:', majorNames.size);

// Check a few
console.log('변호사 in jobs:', jobNames.has('변호사'));
console.log('카페경영자 in jobs:', jobNames.has('카페경영자'));
console.log('컴퓨터공학과 in majors:', majorNames.has('컴퓨터공학과'));
