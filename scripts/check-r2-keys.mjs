import Database from 'better-sqlite3';

const db = new Database('.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite', { readonly: true });

console.log('=== jobs/ 키 샘플 ===');
const jobKeys = db.prepare("SELECT key FROM _mf_objects WHERE key LIKE 'jobs/%' LIMIT 10").all();
jobKeys.forEach(k => console.log(k.key));

console.log('\n=== majors/ 키 샘플 ===');
const majorKeys = db.prepare("SELECT key FROM _mf_objects WHERE key LIKE 'majors/%' LIMIT 5").all();
majorKeys.forEach(k => console.log(k.key));

console.log('\n=== 키 패턴별 개수 ===');
const allKeys = db.prepare("SELECT key FROM _mf_objects").all();
const prefixCount = {};
allKeys.forEach(({ key }) => {
  const prefix = key.split('/')[0];
  prefixCount[prefix] = (prefixCount[prefix] || 0) + 1;
});
Object.entries(prefixCount).sort((a, b) => b[1] - a[1]).forEach(([prefix, cnt]) => {
  console.log(`${prefix}/: ${cnt}`);
});

db.close();

