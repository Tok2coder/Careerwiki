const { execSync } = require('child_process');

function runQuery(sql, label) {
  console.log(`\n=== ${label} ===`);
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
      { cwd: 'C:/Users/PC/Careerwiki', timeout: 60000, encoding: 'utf8' }
    );
    const parsed = JSON.parse(result);
    if (parsed[0] && parsed[0].results) {
      console.log(JSON.stringify(parsed[0].results, null, 2));
      return parsed[0].results;
    }
  } catch (e) {
    console.error('ERROR:', e.message.slice(0, 500));
  }
  return null;
}

// Query 1: 전체 완성도 통계
const q1 = `SELECT COUNT(*) as total, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.way') IS NOT NULL AND json_extract(merged_profile_json, '$.way') != '' THEN 1 ELSE 0 END) as has_way, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.overviewWork.main') IS NOT NULL THEN 1 ELSE 0 END) as has_duties, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NOT NULL OR json_extract(merged_profile_json, '$.overviewSalary.wage') IS NOT NULL THEN 1 ELSE 0 END) as has_salary, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.overviewProspect.main') IS NOT NULL THEN 1 ELSE 0 END) as has_prospect, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.overviewAptitude.aptitudeList') IS NOT NULL THEN 1 ELSE 0 END) as has_aptitude, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.overviewAptitude.interestList') IS NOT NULL THEN 1 ELSE 0 END) as has_interest, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.detailReady.curriculum') IS NOT NULL THEN 1 ELSE 0 END) as has_curriculum, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.detailReady.certificate') IS NOT NULL THEN 1 ELSE 0 END) as has_certificate, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.detailReady.training') IS NOT NULL THEN 1 ELSE 0 END) as has_training, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.trivia') IS NOT NULL AND json_extract(merged_profile_json, '$.trivia') != '[]' THEN 1 ELSE 0 END) as has_trivia, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.sidebarJobs') IS NOT NULL THEN 1 ELSE 0 END) as has_sidebarJobs, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.sidebarMajors') IS NOT NULL THEN 1 ELSE 0 END) as has_sidebarMajors, ` +
  `SUM(CASE WHEN json_extract(merged_profile_json, '$.sidebarCerts') IS NOT NULL THEN 1 ELSE 0 END) as has_sidebarCerts ` +
  `FROM jobs WHERE is_active = 1`;

runQuery(q1, '전체 필드 완성도 통계');

// Query 2: 빈 필드 TOP 50
const q2 = `SELECT id, name, slug, ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.way') IS NULL OR json_extract(merged_profile_json, '$.way') = '' THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.overviewWork.main') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NULL AND json_extract(merged_profile_json, '$.overviewSalary.wage') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.overviewProspect.main') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.overviewAptitude.aptitudeList') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.detailReady.curriculum') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.detailReady.certificate') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.trivia') IS NULL OR json_extract(merged_profile_json, '$.trivia') = '[]' THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.sidebarJobs') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.sidebarMajors') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.sidebarCerts') IS NULL THEN 1 ELSE 0 END) as missing_count ` +
  `FROM jobs WHERE is_active = 1 ORDER BY missing_count DESC LIMIT 50`;

runQuery(q2, '빈 필드 TOP 50');

// Query 3: 모범 사례 (잘 채워진 직업 5개)
const q3 = `SELECT id, name, slug, ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.way') IS NULL OR json_extract(merged_profile_json, '$.way') = '' THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.overviewWork.main') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NULL AND json_extract(merged_profile_json, '$.overviewSalary.wage') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.overviewProspect.main') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.overviewAptitude.aptitudeList') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.detailReady.curriculum') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.detailReady.certificate') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.trivia') IS NULL OR json_extract(merged_profile_json, '$.trivia') = '[]' THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.sidebarJobs') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.sidebarMajors') IS NULL THEN 1 ELSE 0 END) + ` +
  `(CASE WHEN json_extract(merged_profile_json, '$.sidebarCerts') IS NULL THEN 1 ELSE 0 END) as missing_count ` +
  `FROM jobs WHERE is_active = 1 ORDER BY missing_count ASC LIMIT 5`;

const bestCases = runQuery(q3, '모범 사례 직업 (빈 필드 가장 적은 5개)');

if (bestCases && bestCases.length > 0) {
  const ids = bestCases.slice(0, 3).map(r => r.id).join(',');

  // Query 4: 모범 사례 실제 데이터
  const q4 = `SELECT id, name, ` +
    `json_extract(merged_profile_json, '$.way') as way, ` +
    `json_extract(merged_profile_json, '$.overviewWork.main') as duties, ` +
    `json_extract(merged_profile_json, '$.overviewSalary.sal') as salary_sal, ` +
    `json_extract(merged_profile_json, '$.overviewSalary.wage') as salary_wage, ` +
    `json_extract(merged_profile_json, '$.overviewProspect.main') as prospect, ` +
    `json_extract(merged_profile_json, '$.overviewAptitude.aptitudeList') as aptitudeList, ` +
    `json_extract(merged_profile_json, '$.detailReady.curriculum') as curriculum, ` +
    `json_extract(merged_profile_json, '$.detailReady.certificate') as certificate, ` +
    `json_extract(merged_profile_json, '$.trivia') as trivia ` +
    `FROM jobs WHERE id IN (${ids})`;

  const detailResults = runQuery(q4, '모범 사례 실제 데이터');

  if (detailResults) {
    console.log('\n=== 모범 사례 필드별 상세 ===');
    for (const row of detailResults) {
      console.log(`\n--- 직업: ${row.name} (id=${row.id}) ---`);
      for (const [key, val] of Object.entries(row)) {
        if (key === 'id' || key === 'name') continue;
        const str = val ? String(val) : null;
        if (str) {
          console.log(`  [${key}] 길이=${str.length}자`);
          console.log(`  값(앞200자): ${str.slice(0, 200)}`);
        } else {
          console.log(`  [${key}] NULL`);
        }
      }
    }
  }
}
