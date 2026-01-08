import Database from 'better-sqlite3';
import { join } from 'path';

// 직업상담사 자격증 데이터 수정
const dbPath = '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/careerwiki-db.sqlite';
const db = new Database(dbPath);

console.log('=== 직업상담사 자격증 데이터 수정 ===');

// 현재 데이터 확인
const currentData = db.prepare(`
  SELECT id, name, json_extract(merged_profile_json, '$.sidebarCerts') as sidebarCerts
  FROM jobs
  WHERE name = '직업상담사'
`).get();

console.log('현재 sidebarCerts:', currentData.sidebarCerts);

// 잘못된 데이터를 수정
const fixedCerts = [
  { "name": "직업상담사 1, 2급(국가기술)", "url": null }
];

const updateStmt = db.prepare(`
  UPDATE jobs
  SET merged_profile_json = json_set(
    merged_profile_json,
    '$.sidebarCerts',
    ?
  )
  WHERE name = '직업상담사'
`);

const result = updateStmt.run(JSON.stringify(fixedCerts));
console.log('수정 결과:', result);

db.close();
console.log('완료되었습니다.');








