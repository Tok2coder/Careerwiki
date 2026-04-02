// Fix 수의사 _sources by removing numeric keys
const { execSync } = require('child_process');

// Get current user_contributed_json
const output = execSync(
  `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT user_contributed_json FROM jobs WHERE id='1765283331383599'"`,
  { encoding: 'utf8', maxBuffer: 1024 * 1024 }
);

// Parse the JSON from wrangler output
const lines = output.split('\n');
let jsonStart = -1;
for (let i = 0; i < lines.length; i++) {
  if (lines[i].trim().startsWith('[')) { jsonStart = i; break; }
}
if (jsonStart < 0) {
  console.log('Could not find JSON start');
  console.log(output.substring(0, 500));
  process.exit(1);
}

const jsonStr = lines.slice(jsonStart).join('\n');
const parsed = JSON.parse(jsonStr);
const ucjStr = parsed[0].results[0].user_contributed_json;
const ucj = JSON.parse(ucjStr);

console.log('Current _sources keys:', Object.keys(ucj._sources));

// Remove numeric keys
const newSources = {};
for (const [key, val] of Object.entries(ucj._sources)) {
  if (/^\d+$/.test(key)) {
    console.log('Removing numeric key:', key);
    continue;
  }
  newSources[key] = val;
}

ucj._sources = newSources;
console.log('New _sources keys:', Object.keys(ucj._sources));

// Write the fixed JSON to a file for manual SQL update
const fixedJson = JSON.stringify(ucj);
require('fs').writeFileSync('tmp_suui_fixed_ucj.json', fixedJson);
console.log('Fixed JSON written to tmp_suui_fixed_ucj.json, length:', fixedJson.length);
