const fs = require('fs');

const guides = JSON.parse(fs.readFileSync('tmp_guides_raw.json', 'utf8'))[0].results;
const mapping = JSON.parse(fs.readFileSync('tmp_link_mapping.json', 'utf8'));
const jobMap = mapping.jobMapping;

console.log(`Fixing content links in ${guides.length} guides using ${Object.keys(jobMap).length} job mappings`);

const updates = [];

guides.forEach(g => {
  if (!g.content) return;

  let content = g.content;
  let changed = false;

  // Fix job links: /job/WRONG_SLUG → /job/CORRECT_SLUG
  Object.entries(jobMap).forEach(([wrong, correct]) => {
    // Match both URL-encoded and plain text versions
    const patterns = [
      `/job/${wrong}`,
      `/job/${encodeURIComponent(wrong)}`
    ];

    patterns.forEach(pattern => {
      if (content.includes(pattern)) {
        const replacement = `/job/${correct.slug}`;
        content = content.split(pattern).join(replacement);
        changed = true;
        console.log(`  [${g.id}] ${pattern} → ${replacement}`);
      }
    });
  });

  if (changed) {
    updates.push({
      id: g.id,
      slug: g.slug,
      content: content
    });
  }
});

console.log(`\nGuides needing content updates: ${updates.length}`);

// Save the updates for execution via publish API
fs.writeFileSync('tmp_content_updates.json', JSON.stringify(updates, null, 2));

// Also generate SQL (content is large, so we'll use the API instead)
// But let's count the changes
updates.forEach(u => {
  console.log(`  ${u.id}: ${u.slug.substring(0, 50)}`);
});
