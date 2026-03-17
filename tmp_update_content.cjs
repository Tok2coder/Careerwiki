const { execSync } = require('child_process');
const fs = require('fs');

const updates = JSON.parse(fs.readFileSync('tmp_content_updates.json', 'utf8'));

console.log(`Updating content for ${updates.length} guides...`);

for (let i = 0; i < updates.length; i++) {
  const u = updates[i];
  console.log(`[${i+1}/${updates.length}] ID=${u.id} ${u.slug.substring(0, 40)}`);

  // Escape content for SQL
  const escapedContent = u.content.replace(/'/g, "''");

  // Write SQL to temp file to avoid command line length limits
  const sql = `UPDATE pages SET content = '${escapedContent}' WHERE id = ${u.id};`;
  fs.writeFileSync('tmp_single_update.sql', sql);

  try {
    execSync(`npx wrangler d1 execute careerwiki-kr --remote --file tmp_single_update.sql`, {
      cwd: 'C:/Users/PC/Careerwiki',
      stdio: 'pipe',
      timeout: 30000
    });
    console.log('  OK');
  } catch (e) {
    const stderr = e.stderr?.toString() || '';
    console.error('  FAILED:', stderr.substring(0, 200));
  }
}

// Clean up
try { fs.unlinkSync('tmp_single_update.sql'); } catch(e) {}
console.log('\nDone!');
