// Parse wrangler d1 JSON output file -> extract merged_profile_json, pretty print
const fs = require('fs');
const inFile = process.argv[2];
const outFile = process.argv[3];
const raw = fs.readFileSync(inFile, 'utf8');
// find first '[' that starts the JSON array
const start = raw.indexOf('[\n');
const jsonText = raw.slice(start);
let arr;
try { arr = JSON.parse(jsonText); }
catch (e) {
  // wrangler sometimes duplicates keys; try to salvage the merged_profile_json string via regex
  const m = raw.match(/"merged_profile_json":\s*"((?:\\.|[^"\\])*)"/);
  if (m) {
    const inner = JSON.parse('"' + m[1] + '"');
    const obj = JSON.parse(inner);
    fs.writeFileSync(outFile, JSON.stringify(obj, null, 2), 'utf8');
    console.log('SALVAGED keys=' + Object.keys(obj).join(','));
    process.exit(0);
  }
  console.error('PARSE FAIL: ' + e.message);
  process.exit(1);
}
const row = arr[0].results[0];
const mpj = row.merged_profile_json;
const obj = typeof mpj === 'string' ? JSON.parse(mpj) : mpj;
fs.writeFileSync(outFile, JSON.stringify(obj, null, 2), 'utf8');
console.log('OK keys=' + Object.keys(obj).join(','));
