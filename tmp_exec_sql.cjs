const { execSync } = require('child_process');
const fs = require('fs');

const sql = fs.readFileSync('tmp_fix_howto_slugs.sql', 'utf8');
const statements = sql.split('\n').filter(s => s.trim());

// Skip first one (already executed)
const remaining = statements.slice(1);

console.log(`Total remaining: ${remaining.length} statements`);

for (let i = 0; i < remaining.length; i++) {
  const stmt = remaining[i];
  const shortDesc = stmt.substring(0, 60) + '...';
  console.log(`[${i+1}/${remaining.length}] ${shortDesc}`);

  // Escape for shell
  const escaped = stmt.replace(/"/g, '\\"');

  try {
    execSync(`npx wrangler d1 execute careerwiki-kr --remote --command "${escaped}"`, {
      cwd: 'C:/Users/PC/Careerwiki',
      stdio: 'pipe',
      timeout: 30000
    });
    console.log('  OK');
  } catch (e) {
    console.error('  FAILED:', e.stderr?.toString().substring(0, 200));
  }
}

console.log('Done!');
