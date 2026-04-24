#!/usr/bin/env node
const { execSync } = require('child_process');

const sql = [
  "SELECT * FROM (",
  "SELECT id, name, slug,",
  "(CASE WHEN json_extract(merged_profile_json,'$.way') IS NULL OR json_extract(merged_profile_json,'$.way')='' THEN 1 ELSE 0 END)",
  "+ (CASE WHEN json_extract(merged_profile_json,'$.overviewProspect.main') IS NULL THEN 1 ELSE 0 END)",
  "+ (CASE WHEN json_extract(merged_profile_json,'$.trivia') IS NULL THEN 1 ELSE 0 END) as mc,",
  "LENGTH(user_contributed_json) as ucj_len",
  "FROM jobs WHERE is_active=1",
  ") WHERE mc>=2 ORDER BY mc DESC, ucj_len ASC LIMIT 10"
].join(' ');

const r = execSync(
  `npx wrangler d1 execute careerwiki-kr --remote --command "${sql}"`,
  { encoding: 'utf8', cwd: process.cwd(), maxBuffer: 4*1024*1024 }
);
console.log(r);
