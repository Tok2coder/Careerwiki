/**
 * 병합된 직업의 target에 흡수된 이름을 태그로 추가
 */
const { execSync } = require('child_process');

function d1(sql) {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`;
  const result = execSync(cmd, { encoding: 'utf8', timeout: 60000 });
  return JSON.parse(result)[0].results;
}

const mappings = d1("SELECT source_name, target_name FROM name_mappings WHERE type = 'job' AND is_active = 1");
console.log(`${mappings.length}개 매핑`);

// target별로 source 이름 그룹핑
const targetToSources = {};
for (const m of mappings) {
  if (!targetToSources[m.target_name]) targetToSources[m.target_name] = [];
  targetToSources[m.target_name].push(m.source_name);
}

let count = 0;
for (const [targetName, srcNames] of Object.entries(targetToSources)) {
  const escaped = targetName.replace(/'/g, "''");
  let row;
  try {
    row = d1(`SELECT id, json_extract(merged_profile_json, '$.tagList') as tags, json_extract(merged_profile_json, '$.heroTags') as heroTags FROM jobs WHERE name = '${escaped}' AND is_active = 1 LIMIT 1`);
  } catch (e) { console.log(`  SKIP (query error): ${targetName}`); continue; }
  if (!row || row.length === 0) continue;

  let tags, heroTags;
  try { tags = row[0].tags ? JSON.parse(row[0].tags) : []; } catch { tags = []; }
  try { heroTags = row[0].heroTags ? JSON.parse(row[0].heroTags) : []; } catch { heroTags = []; }

  const tagSet = new Set(tags);
  const heroSet = new Set(heroTags);
  let added = 0;

  for (const sn of srcNames) {
    if (!tagSet.has(sn)) { tags.push(sn); tagSet.add(sn); added++; }
    if (!heroSet.has(sn)) { heroTags.push(sn); heroSet.add(sn); }
  }

  if (added > 0) {
    const tagsVal = JSON.stringify(tags).replace(/'/g, "''");
    const heroVal = JSON.stringify(heroTags).replace(/'/g, "''");
    try {
      d1(`UPDATE jobs SET merged_profile_json = json_set(json_set(merged_profile_json, '$.tagList', json('${tagsVal}')), '$.heroTags', json('${heroVal}')) WHERE id = '${row[0].id}'`);
      count++;
      console.log(`  TAG: '${targetName}' ← ${srcNames.join(', ')}`);
    } catch (e) { console.log(`  SKIP (update error): ${targetName}`); }
  }
}

console.log(`\n완료: ${count}건 태그 추가`);
