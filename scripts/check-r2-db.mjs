#!/usr/bin/env node
import Database from 'better-sqlite3';

const DB_PATH = '.wrangler/state/v3/r2/careerwiki-uploads/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite';

const db = new Database(DB_PATH, { readonly: true });

console.log('테이블 목록:');
const tables = db.prepare(`
  SELECT name FROM sqlite_master 
  WHERE type='table' 
  ORDER BY name
`).all();

tables.forEach(t => console.log(`  - ${t.name}`));

// _mf_objects 테이블 확인
console.log('\n_mf_objects 구조:');
const schema = db.prepare(`PRAGMA table_info(_mf_objects)`).all();
schema.forEach(col => {
  console.log(`  ${col.name} (${col.type})`);
});

console.log(`\n샘플 데이터 (최대 5개):`);
const samples = db.prepare(`SELECT * FROM _mf_objects LIMIT 5`).all();
console.log(JSON.stringify(samples, null, 2));

console.log(`\n총 객체 수:`);
const count = db.prepare(`SELECT COUNT(*) as cnt FROM _mf_objects`).get();
console.log(`  ${count.cnt}개`);

db.close();

