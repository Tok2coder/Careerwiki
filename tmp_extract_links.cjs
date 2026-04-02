const fs = require('fs');
const data = JSON.parse(fs.readFileSync('tmp_guides_raw.json', 'utf8'));
const guides = data[0].results;

console.log(`Total guides: ${guides.length}`);

// Extract all internal links from content
const linkPattern = /\/(?:job|major)\/([^"\\]+)/g;
const allLinks = [];

guides.forEach(g => {
  if (!g.content) return;
  let match;
  const content = g.content;
  while ((match = linkPattern.exec(content)) !== null) {
    const fullHref = match[0];
    const slug = match[1];
    const type = fullHref.startsWith('/job/') ? 'job' : 'major';
    allLinks.push({
      guideId: g.id,
      guideSlug: g.slug,
      type,
      slug,
      fullHref
    });
  }
});

console.log(`Total internal links found: ${allLinks.length}`);

// Group by type
const jobSlugs = [...new Set(allLinks.filter(l => l.type === 'job').map(l => l.slug))];
const majorSlugs = [...new Set(allLinks.filter(l => l.type === 'major').map(l => l.slug))];

console.log(`\nUnique job slugs (${jobSlugs.length}):`);
jobSlugs.forEach(s => console.log(`  /job/${s}`));

console.log(`\nUnique major slugs (${majorSlugs.length}):`);
majorSlugs.forEach(s => console.log(`  /major/${s}`));

// Save for next step
fs.writeFileSync('tmp_internal_links.json', JSON.stringify({ allLinks, jobSlugs, majorSlugs }, null, 2));
