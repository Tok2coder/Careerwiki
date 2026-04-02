const { execSync } = require('child_process');

function runQuery(sql, label) {
  try {
    const result = execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
      { cwd: 'C:/Users/PC/Careerwiki', timeout: 60000, encoding: 'utf8' }
    );
    const parsed = JSON.parse(result);
    if (parsed[0] && parsed[0].results) {
      return parsed[0].results;
    }
  } catch (e) {
    console.error('ERROR in', label, ':', e.message.slice(0, 300));
  }
  return null;
}

// TOP 50 직업 각각의 어떤 필드가 비어있는지 확인
const top50ids = [
  '1765283597569463', '1765284119607113', '1765284123381364', '176528453022913',
  '1765284606371564', '176528481549749', '1765285588370379', '1765285609501353',
  '1765285619185265', '1765285620540307', 'U_푸드-브로커_mjginndj'
].map(id => `'${id}'`).join(',');

const q = `SELECT id, name, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.way') IS NULL OR json_extract(merged_profile_json, '$.way') = '' THEN 1 ELSE 0 END as no_way, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.overviewWork.main') IS NULL THEN 1 ELSE 0 END as no_duties, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NULL AND json_extract(merged_profile_json, '$.overviewSalary.wage') IS NULL THEN 1 ELSE 0 END as no_salary, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.overviewProspect.main') IS NULL THEN 1 ELSE 0 END as no_prospect, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.overviewAptitude.aptitudeList') IS NULL THEN 1 ELSE 0 END as no_aptitude, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.detailReady.curriculum') IS NULL THEN 1 ELSE 0 END as no_curriculum, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.detailReady.certificate') IS NULL THEN 1 ELSE 0 END as no_certificate, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.trivia') IS NULL OR json_extract(merged_profile_json, '$.trivia') = '[]' THEN 1 ELSE 0 END as no_trivia, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.sidebarJobs') IS NULL THEN 1 ELSE 0 END as no_sidebarJobs, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.sidebarMajors') IS NULL THEN 1 ELSE 0 END as no_sidebarMajors, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.sidebarCerts') IS NULL THEN 1 ELSE 0 END as no_sidebarCerts ` +
  `FROM jobs WHERE id IN (${top50ids})`;

const rows = runQuery(q, '빈 필드 상세 (missing=10인 직업들)');
if (rows) {
  console.log('\n=== 빈 필드 상세 (missing_count=10 직업) ===');
  for (const row of rows) {
    const missing = [];
    if (row.no_way) missing.push('way');
    if (row.no_duties) missing.push('duties');
    if (row.no_salary) missing.push('salary');
    if (row.no_prospect) missing.push('prospect');
    if (row.no_aptitude) missing.push('aptitude');
    if (row.no_curriculum) missing.push('curriculum');
    if (row.no_certificate) missing.push('certificate');
    if (row.no_trivia) missing.push('trivia');
    if (row.no_sidebarJobs) missing.push('sidebarJobs');
    if (row.no_sidebarMajors) missing.push('sidebarMajors');
    if (row.no_sidebarCerts) missing.push('sidebarCerts');
    console.log(`  ${row.name} (${row.id}): [${missing.join(', ')}]`);
  }
}

// missing_count=9 직업들 중 첫 30개의 빈 필드 상세
const top9ids = [
  '1765283536074109', '1765283536478100', '1765283536852321', '1765283537217788',
  '1765283537507460', '1765283538007427', '1765283538435221', '176528353918165',
  '1765283539566800', '1765283539945705', '1765283540338776', '1765283540713856',
  '1765283540988406', '1765283541418388', '1765283542208228', '1765283542853983',
  '1765283543257922', '1765283543641384', '176528354403447', '1765283544344858',
  '1765283544710282', '1765283545023124', '1765283545838587', '176528354663362',
  '1765283546950254', '1765283547402516', '1765283547778490', '1765283548178252',
  '176528354856231', '1765283548991708'
].map(id => `'${id}'`).join(',');

const q2 = `SELECT id, name, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.way') IS NULL OR json_extract(merged_profile_json, '$.way') = '' THEN 1 ELSE 0 END as no_way, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.overviewWork.main') IS NULL THEN 1 ELSE 0 END as no_duties, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NULL AND json_extract(merged_profile_json, '$.overviewSalary.wage') IS NULL THEN 1 ELSE 0 END as no_salary, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.overviewProspect.main') IS NULL THEN 1 ELSE 0 END as no_prospect, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.overviewAptitude.aptitudeList') IS NULL THEN 1 ELSE 0 END as no_aptitude, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.detailReady.curriculum') IS NULL THEN 1 ELSE 0 END as no_curriculum, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.detailReady.certificate') IS NULL THEN 1 ELSE 0 END as no_certificate, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.trivia') IS NULL OR json_extract(merged_profile_json, '$.trivia') = '[]' THEN 1 ELSE 0 END as no_trivia, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.sidebarJobs') IS NULL THEN 1 ELSE 0 END as no_sidebarJobs, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.sidebarMajors') IS NULL THEN 1 ELSE 0 END as no_sidebarMajors, ` +
  `CASE WHEN json_extract(merged_profile_json, '$.sidebarCerts') IS NULL THEN 1 ELSE 0 END as no_sidebarCerts ` +
  `FROM jobs WHERE id IN (${top9ids})`;

const rows2 = runQuery(q2, '빈 필드 상세 (missing=9인 직업들 30개)');
if (rows2) {
  console.log('\n=== 빈 필드 상세 (missing_count=9 직업 첫 30개) ===');
  for (const row of rows2) {
    const missing = [];
    if (row.no_way) missing.push('way');
    if (row.no_duties) missing.push('duties');
    if (row.no_salary) missing.push('salary');
    if (row.no_prospect) missing.push('prospect');
    if (row.no_aptitude) missing.push('aptitude');
    if (row.no_curriculum) missing.push('curriculum');
    if (row.no_certificate) missing.push('certificate');
    if (row.no_trivia) missing.push('trivia');
    if (row.no_sidebarJobs) missing.push('sidebarJobs');
    if (row.no_sidebarMajors) missing.push('sidebarMajors');
    if (row.no_sidebarCerts) missing.push('sidebarCerts');
    console.log(`  ${row.name} (${row.id}): [${missing.join(', ')}]`);
  }
}

// 전체 직업 중 missing_count 분포 확인
const q3 = `SELECT ` +
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
  `(CASE WHEN json_extract(merged_profile_json, '$.sidebarCerts') IS NULL THEN 1 ELSE 0 END) as missing_count, ` +
  `COUNT(*) as cnt ` +
  `FROM jobs WHERE is_active = 1 GROUP BY missing_count ORDER BY missing_count`;

const dist = runQuery(q3, '빈 필드 수 분포');
if (dist) {
  console.log('\n=== 빈 필드 수 분포 ===');
  let total = 0;
  for (const row of dist) {
    total += row.cnt;
    console.log(`  missing=${row.missing_count}: ${row.cnt}개 직업`);
  }
  console.log(`  합계: ${total}개`);
}
