// Parse wrangler all5 dump -> per-job field summary + write individual pretty files
const fs = require('fs');
const raw = fs.readFileSync('data/cycle/r12-a4/_raw_all5.txt', 'utf8');
const start = raw.indexOf('[\n');
let arr;
try { arr = JSON.parse(raw.slice(start)); }
catch (e) { console.error('TOP PARSE FAIL: ' + e.message); process.exit(1); }
const rows = arr[0].results;
const lines = [];
for (const r of rows) {
  let obj;
  try { obj = typeof r.merged_profile_json === 'string' ? JSON.parse(r.merged_profile_json) : r.merged_profile_json; }
  catch (e) { lines.push(`### ${r.name} id=${r.id} -- MPJ PARSE FAIL: ${e.message}`); continue; }
  // write pretty
  const safe = r.name.replace(/[^가-힣A-Za-z0-9]/g,'_');
  fs.writeFileSync(`data/cycle/r12-a4/_pretty_${r.id}.json`, JSON.stringify(obj, null, 2), 'utf8');
  lines.push(`\n### ${r.name}  id=${r.id}  active=${r.is_active}`);
  lines.push(`top-keys: ${Object.keys(obj).join(', ')}`);
  const proseFields = ['summary','way','trivia'];
  for (const f of proseFields) {
    const v = obj[f];
    const s = Array.isArray(v) ? v.join(' / ') : (typeof v === 'string' ? v : v == null ? '' : JSON.stringify(v));
    lines.push(`  ${f}: len=${(s||'').length} :: ${(s||'').slice(0,120)}`);
  }
  // nested overview/detail
  for (const grp of ['overviewWork','overviewProspect','overviewAbilities','overviewSalary','detailWlb','detailReady']) {
    if (obj[grp] && typeof obj[grp] === 'object') {
      const sub = Object.keys(obj[grp]).map(k => {
        const vv = obj[grp][k];
        const ss = Array.isArray(vv) ? `[arr${vv.length}]` : (typeof vv==='string'? `len${vv.length}` : typeof vv);
        return `${k}=${ss}`;
      }).join(', ');
      lines.push(`  ${grp}: { ${sub} }`);
    }
  }
  // _sources
  if (obj._sources) {
    const srcKeys = Object.keys(obj._sources).map(k => `${k}(${Array.isArray(obj._sources[k])?obj._sources[k].length:'?'})`).join(', ');
    lines.push(`  _sources: ${srcKeys || '(none)'}`);
  } else lines.push(`  _sources: ABSENT`);
  // youtube / careerTree / sidebar
  for (const f of ['youtubeLinks','careerTree','heroTags','sidebarCerts','sidebarOrgs','sidebarMajors','sidebarJobs']) {
    if (obj[f] !== undefined) {
      const v = obj[f];
      lines.push(`  ${f}: ${Array.isArray(v)?`[arr${v.length}]`:(typeof v==='object'?JSON.stringify(v).slice(0,80):v)}`);
    }
  }
}
fs.writeFileSync('data/cycle/r12-a4/_summary.txt', lines.join('\n'), 'utf8');
console.log('SUMMARY WRITTEN rows=' + rows.length);
console.log(lines.join('\n'));
