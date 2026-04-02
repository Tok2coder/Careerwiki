/**
 * 병합된 직업 후처리:
 * 1. sidebarJobs/relatedJobs에서 비활성화된 이름 → target으로 교체
 * 2. target job의 tagList에 흡수된 이름 추가
 *
 * D1 API 용량 제한 때문에 json_extract로 필요한 필드만 조회
 */
const { execSync } = require('child_process');
const fs = require('fs');

const SESSION_TOKEN = process.env.SESSION_TOKEN;

function d1(sql) {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`;
  const result = execSync(cmd, { encoding: 'utf8', timeout: 60000 });
  return JSON.parse(result)[0].results;
}

async function main() {
  // 1. name_mappings에서 모든 병합 쌍 가져오기
  console.log('=== Step 1: name_mappings 조회 ===');
  const mappings = d1("SELECT source_name, target_name FROM name_mappings WHERE type = 'job' AND is_active = 1");
  console.log(`${mappings.length}개 병합 매핑 발견`);

  const mergeMap = {};
  for (const m of mappings) {
    mergeMap[m.source_name] = m.target_name;
  }
  const sourceNames = Object.keys(mergeMap);

  // 2. sidebarJobs에 비활성화된 이름이 포함된 job 찾기
  console.log('\n=== Step 2: sidebarJobs 링크 교체 ===');

  let totalFixed = 0;

  for (const sourceName of sourceNames) {
    const escaped = sourceName.replace(/'/g, "''");
    const targetName = mergeMap[sourceName];

    // sidebarJobs에 source 이름이 포함된 active job 찾기 (json_extract 사용)
    const affected = d1(`SELECT id, name, json_extract(merged_profile_json, '$.sidebarJobs') as sidebar FROM jobs WHERE is_active = 1 AND merged_profile_json IS NOT NULL AND json_extract(merged_profile_json, '$.sidebarJobs') LIKE '%${escaped}%'`);

    for (const job of affected) {
      if (!job.sidebar) continue;
      let sidebar;
      try { sidebar = JSON.parse(job.sidebar); } catch { continue; }
      if (!Array.isArray(sidebar)) continue;

      const newSidebar = sidebar.map(n => mergeMap[n] || n);
      const deduped = [...new Set(newSidebar)];

      // 변경이 있으면 업데이트 (json_set 사용)
      if (JSON.stringify(deduped) !== JSON.stringify(sidebar)) {
        const newVal = JSON.stringify(deduped).replace(/'/g, "''");
        d1(`UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.sidebarJobs', json('${newVal}')) WHERE id = '${job.id}'`);
        totalFixed++;
        console.log(`  FIX: '${job.name}' sidebarJobs: '${sourceName}' → '${targetName}'`);
      }
    }
  }

  console.log(`sidebarJobs 교체 완료: ${totalFixed}건`);

  // 3. relatedJobs도 동일하게
  console.log('\n=== Step 3: relatedJobs 링크 교체 ===');

  let relatedFixed = 0;

  for (const sourceName of sourceNames) {
    const escaped = sourceName.replace(/'/g, "''");
    const targetName = mergeMap[sourceName];

    const affected = d1(`SELECT id, name, json_extract(merged_profile_json, '$.relatedJobs') as related FROM jobs WHERE is_active = 1 AND merged_profile_json IS NOT NULL AND json_extract(merged_profile_json, '$.relatedJobs') LIKE '%${escaped}%'`);

    for (const job of affected) {
      if (!job.related) continue;
      let related;
      try { related = JSON.parse(job.related); } catch { continue; }
      if (!Array.isArray(related)) continue;

      let changed = false;
      const newRelated = related.map(item => {
        if (typeof item === 'string' && mergeMap[item]) { changed = true; return mergeMap[item]; }
        if (item && typeof item === 'object' && item.name && mergeMap[item.name]) {
          changed = true;
          return { ...item, name: mergeMap[item.name] };
        }
        return item;
      });

      if (changed) {
        // 중복 제거
        const seen = new Set();
        const deduped = newRelated.filter(item => {
          const key = typeof item === 'string' ? item : item?.name;
          if (seen.has(key)) return false;
          seen.add(key);
          return true;
        });

        const newVal = JSON.stringify(deduped).replace(/'/g, "''");
        d1(`UPDATE jobs SET merged_profile_json = json_set(merged_profile_json, '$.relatedJobs', json('${newVal}')) WHERE id = '${job.id}'`);
        relatedFixed++;
      }
    }
  }

  console.log(`relatedJobs 교체 완료: ${relatedFixed}건`);

  // 4. target job의 tagList/heroTags에 흡수된 이름 추가
  console.log('\n=== Step 4: target tagList에 흡수된 이름 추가 ===');

  const targetToSources = {};
  for (const [source, target] of Object.entries(mergeMap)) {
    if (!targetToSources[target]) targetToSources[target] = [];
    targetToSources[target].push(source);
  }

  let tagCount = 0;

  for (const [targetName, srcNames] of Object.entries(targetToSources)) {
    const escaped = targetName.replace(/'/g, "''");
    const row = d1(`SELECT id, json_extract(merged_profile_json, '$.tagList') as tags, json_extract(merged_profile_json, '$.heroTags') as heroTags FROM jobs WHERE name = '${escaped}' AND is_active = 1 LIMIT 1`);
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
      d1(`UPDATE jobs SET merged_profile_json = json_set(json_set(merged_profile_json, '$.tagList', json('${tagsVal}')), '$.heroTags', json('${heroVal}')) WHERE id = '${row[0].id}'`);
      tagCount++;
      console.log(`  TAG: '${targetName}' ← ${srcNames.join(', ')}`);
    }
  }

  console.log(`태그 추가 완료: ${tagCount}건`);

  // 5. user_contributed_json의 sidebarJobs도 교체
  console.log('\n=== Step 5: user_contributed_json sidebarJobs 교체 ===');

  const ucjJobs = d1("SELECT id, name, user_contributed_json FROM jobs WHERE is_active = 1 AND user_contributed_json IS NOT NULL AND length(user_contributed_json) > 10");
  let ucjCount = 0;

  for (const job of ucjJobs) {
    let ucj;
    try { ucj = JSON.parse(job.user_contributed_json); } catch { continue; }
    let changed = false;

    if (Array.isArray(ucj.sidebarJobs)) {
      const newJobs = ucj.sidebarJobs.map(n => { if (mergeMap[n]) { changed = true; return mergeMap[n]; } return n; });
      ucj.sidebarJobs = [...new Set(newJobs)];
    }

    if (changed) {
      const val = JSON.stringify(ucj).replace(/'/g, "''");
      d1(`UPDATE jobs SET user_contributed_json = '${val}' WHERE id = '${job.id}'`);
      ucjCount++;
      console.log(`  UCJ: '${job.name}' sidebarJobs 교체`);
    }
  }

  console.log(`user_contributed_json 교체 완료: ${ucjCount}건`);

  console.log('\n=== 전체 완료 ===');
  console.log(`sidebarJobs: ${totalFixed}건, relatedJobs: ${relatedFixed}건, 태그: ${tagCount}건, UCJ: ${ucjCount}건`);
}

main().catch(console.error);
