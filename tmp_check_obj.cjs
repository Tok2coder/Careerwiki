const { execSync } = require('child_process');

const raw = execSync(
  'npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT merged_profile_json FROM majors WHERE name = \'건축학과\' AND is_active = 1"',
  { encoding: 'utf8', maxBuffer: 50 * 1024 * 1024 }
);

const parsed = JSON.parse(raw);
const mpj = JSON.parse(parsed[0].results[0].merged_profile_json);

// Find all arrays that contain objects
function scan(obj, path) {
  if (!obj || typeof obj !== 'object') return;
  for (const [k, v] of Object.entries(obj)) {
    const p = path ? path + '.' + k : k;
    if (Array.isArray(v)) {
      v.forEach((item, i) => {
        if (item && typeof item === 'object') {
          console.log(`${p}[${i}]:`, JSON.stringify(item).substring(0, 200));
        }
      });
    } else if (v && typeof v === 'object') {
      scan(v, p);
    }
  }
}

scan(mpj, '');
