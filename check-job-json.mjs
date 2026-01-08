import Database from 'better-sqlite3';
import { existsSync, writeFileSync } from 'fs';

// D1 로컬 DB 경로
const dbPath = '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite';

if (!existsSync(dbPath)) {
  console.error('DB 파일을 찾을 수 없습니다:', dbPath);
  process.exit(1);
}

const db = new Database(dbPath);

// 취업알선원의 전체 JSON 저장
const row = db.prepare("SELECT merged_profile_json FROM jobs WHERE name = '취업알선원'").get();
if (row && row.merged_profile_json) {
  writeFileSync('good-job-json.json', JSON.stringify(JSON.parse(row.merged_profile_json), null, 2));
  console.log('취업알선원 JSON 저장됨: good-job-json.json');
}

// 인력파견관리자의 JSON 저장
const row2 = db.prepare("SELECT merged_profile_json FROM jobs WHERE name = '인력파견관리자'").get();
if (row2 && row2.merged_profile_json) {
  writeFileSync('bad-job-json.json', JSON.stringify(JSON.parse(row2.merged_profile_json), null, 2));
  console.log('인력파견관리자 JSON 저장됨: bad-job-json.json');
}

db.close();

