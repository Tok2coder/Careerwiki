const Database = require('better-sqlite3');
const path = require('path');

const sqlitePath = path.resolve(__dirname, '../.wrangler/state/v3/r2/miniflare-R2BucketObject/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite');
const db = new Database(sqlitePath);

// 전공 이미지 수
const count = db.prepare("SELECT COUNT(*) as cnt FROM _mf_objects WHERE key LIKE 'majors/%'").get();
console.log('전공 이미지 수:', count.cnt);

// 샘플 출력
const sample = db.prepare("SELECT key FROM _mf_objects WHERE key LIKE 'majors/%' LIMIT 5").all();
console.log('샘플:', sample.map(r => r.key));

db.close();










