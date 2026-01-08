/**
 * R2 메타데이터 확인 스크립트
 */

const Database = require('better-sqlite3');
const path = require('path');

const SERVER_SQLITE_PATH = path.resolve(__dirname, '../.wrangler/state/v3/r2/miniflare-R2BucketObject/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite');

const db = new Database(SERVER_SQLITE_PATH);

// 간호과 이미지 키 확인
console.log('=== 전공 이미지 샘플 ===');
const majors = db.prepare("SELECT key FROM _mf_objects WHERE key LIKE 'majors/%' LIMIT 5").all();
majors.forEach(r => console.log(r.key));

console.log('\n=== 직업 이미지 샘플 ===');
const jobs = db.prepare("SELECT key FROM _mf_objects WHERE key LIKE 'jobs/%' LIMIT 5").all();
jobs.forEach(r => console.log(r.key));

// blob_id 확인
console.log('\n=== blob_id 샘플 ===');
const sample = db.prepare("SELECT key, blob_id FROM _mf_objects WHERE key LIKE 'majors/%' LIMIT 1").get();
console.log('key:', sample.key);
console.log('blob_id:', sample.blob_id);

db.close();

