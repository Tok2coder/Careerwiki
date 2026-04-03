#!/usr/bin/env node
/**
 * CareerWiki DB 데이터 건강 상태 보고서
 * 사용법: node scripts/data-health-report.cjs
 */

'use strict';
const { execSync } = require('child_process');

const DB_NAME = 'careerwiki-kr';

function q(sql) {
  try {
    const raw = execSync(
      `npx wrangler d1 execute ${DB_NAME} --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
      { encoding: 'utf-8', stdio: ['pipe', 'pipe', 'pipe'] }
    );
    const parsed = JSON.parse(raw);
    return parsed[0]?.results ?? [];
  } catch (e) {
    const msg = e.stderr || e.message || '';
    console.error(`  [SQL ERROR] ${sql.slice(0, 80)}...\n  ${msg.slice(0, 200)}`);
    return [];
  }
}

function pad(str, len, right = false) {
  str = String(str ?? '');
  if (right) return str.padStart(len);
  return str.padEnd(len);
}

function pct(num, denom) {
  if (!denom) return '  0.0%';
  return (((num / denom) * 100).toFixed(1) + '%').padStart(6);
}

function hr(char = '-', len = 68) {
  return char.repeat(len);
}

function section(title) {
  console.log('\n' + hr('='));
  console.log(' ' + title);
  console.log(hr('='));
}

function tableRow(cols, widths) {
  return '| ' + cols.map((c, i) => pad(c, widths[i])).join(' | ') + ' |';
}

function tableDivider(widths) {
  return '+-' + widths.map(w => '-'.repeat(w)).join('-+-') + '-+';
}

async function main() {
  console.log('\n' + hr('#'));
  console.log('# CareerWiki 데이터 건강 상태 보고서');
  console.log('# 생성 시각: ' + new Date().toISOString().replace('T', ' ').slice(0, 19));
  console.log(hr('#'));

  // ─── 1. 전체 현황 ───────────────────────────────────────────
  section('1. 전체 현황');

  const totalRow = q('SELECT COUNT(*) as cnt FROM jobs');
  const total = totalRow[0]?.cnt ?? 0;

  const doneRow = q("SELECT COUNT(*) as cnt FROM jobs WHERE LENGTH(user_contributed_json) >= 500");
  const done = doneRow[0]?.cnt ?? 0;

  const nullRow = q("SELECT COUNT(*) as cnt FROM jobs WHERE user_contributed_json IS NULL OR user_contributed_json = ''");
  const nullCnt = nullRow[0]?.cnt ?? 0;

  const thinRow = q("SELECT COUNT(*) as cnt FROM jobs WHERE user_contributed_json IS NOT NULL AND user_contributed_json != '' AND LENGTH(user_contributed_json) < 500");
  const thin = thinRow[0]?.cnt ?? 0;

  const widths = [22, 8, 7];
  console.log(tableDivider(widths));
  console.log(tableRow(['항목', '직업 수', '비율'], widths));
  console.log(tableDivider(widths));
  console.log(tableRow(['전체 직업', total, '100.0%'], widths));
  console.log(tableRow(['보완 완료 (>=500자)', done, pct(done, total)], widths));
  console.log(tableRow(['부실 (<500자)', thin, pct(thin, total)], widths));
  console.log(tableRow(['NULL (미보완)', nullCnt, pct(nullCnt, total)], widths));
  console.log(tableDivider(widths));

  // ─── 2. 필드 완성도 ─────────────────────────────────────────
  section('2. 필드 완성도 (보완 완료 직업 기준)');

  const fields = [
    { label: 'youtubeLinks', sql: "youtubeLinks" },
    { label: '_sources', sql: "_sources" },
    { label: 'overviewSalary', sql: "overviewSalary" },
    { label: 'heroTags', sql: "heroTags" },
    { label: 'sidebarJobs', sql: "sidebarJobs" },
    { label: 'overviewProspect', sql: "overviewProspect" },
    { label: 'way', sql: "way" },
    { label: 'trivia', sql: "trivia" },
  ];

  const fw = [18, 8, 8, 7];
  console.log(tableDivider(fw));
  console.log(tableRow(['필드명', '있음', '없음', '완성율'], fw));
  console.log(tableDivider(fw));

  for (const f of fields) {
    const hasRow = q(
      `SELECT COUNT(*) as cnt FROM jobs WHERE LENGTH(user_contributed_json) >= 500 AND json_extract(user_contributed_json, '$.${f.sql}') IS NOT NULL AND json_extract(user_contributed_json, '$.${f.sql}') != '' AND json_extract(user_contributed_json, '$.${f.sql}') != '[]' AND json_extract(user_contributed_json, '$.${f.sql}') != '{}'`
    );
    const has = hasRow[0]?.cnt ?? 0;
    const missing = done - has;
    console.log(tableRow([f.label, has, missing, pct(has, done)], fw));
  }
  console.log(tableDivider(fw));

  // ─── 3. 품질 이슈 탐지 ──────────────────────────────────────
  section('3. 품질 이슈 탐지');

  const qw = [40, 8];
  console.log(tableDivider(qw));
  console.log(tableRow(['이슈', '건수'], qw));
  console.log(tableDivider(qw));

  // way가 배열인 직업 (JSON array 체크 - 문자열이어야 정상)
  const wayArrayRow = q(
    `SELECT COUNT(*) as cnt FROM jobs WHERE user_contributed_json IS NOT NULL AND json_extract(user_contributed_json, '$.way') IS NOT NULL AND json_type(user_contributed_json, '$.way') = 'array'`
  );
  const wayArray = wayArrayRow[0]?.cnt ?? 0;
  console.log(tableRow(['way가 배열(array)인 직업 [위험]', wayArray + (wayArray > 0 ? ' !' : '')], qw));

  // image_url 포맷 이상 (정상: /uploads/... 또는 https://...)
  const badImgRow = q(
    `SELECT COUNT(*) as cnt FROM jobs WHERE image_url IS NOT NULL AND image_url != '' AND image_url NOT LIKE '/uploads/%' AND image_url NOT LIKE 'https://%' AND image_url NOT LIKE 'http://%'`
  );
  const badImg = badImgRow[0]?.cnt ?? 0;
  console.log(tableRow(['image_url 비정상 포맷 (/uploads/ 아닌 것)', badImg + (badImg > 0 ? ' !' : '')], qw));

  // way 필드 잘린 의심 (비정상 종결)
  const truncRow = q(
    `SELECT COUNT(*) as cnt FROM jobs WHERE LENGTH(user_contributed_json) >= 500 AND json_extract(user_contributed_json, '$.way') IS NOT NULL AND json_type(user_contributed_json, '$.way') != 'array' AND LENGTH(json_extract(user_contributed_json, '$.way')) > 20 AND json_extract(user_contributed_json, '$.way') NOT LIKE '%.' AND json_extract(user_contributed_json, '$.way') NOT LIKE '%다' AND json_extract(user_contributed_json, '$.way') NOT LIKE '%요' AND json_extract(user_contributed_json, '$.way') NOT LIKE '%음' AND json_extract(user_contributed_json, '$.way') NOT LIKE '%죠' AND json_extract(user_contributed_json, '$.way') NOT LIKE '%?' AND json_extract(user_contributed_json, '$.way') NOT LIKE '%!'`
  );
  const trunc = truncRow[0]?.cnt ?? 0;
  console.log(tableRow(['way 잘린 의심 (비정상 종결)', trunc + (trunc > 0 ? ' ?' : '')], qw));

  // _sources 순서 이상: 첫 번째 출처가 CareerNet이 아닌 경우
  const srcOrderRow = q(
    `SELECT COUNT(*) as cnt FROM jobs WHERE LENGTH(user_contributed_json) >= 500 AND json_extract(user_contributed_json, '$._sources') IS NOT NULL AND json_type(user_contributed_json, '$._sources') = 'array' AND json_extract(user_contributed_json, '$._sources[0].name') NOT LIKE '%커리어넷%' AND json_extract(user_contributed_json, '$._sources[0].name') NOT LIKE '%CareerNet%' AND json_extract(user_contributed_json, '$._sources[0].name') NOT LIKE '%Careernet%'`
  );
  const srcOrder = srcOrderRow[0]?.cnt ?? 0;
  console.log(tableRow(['_sources[0]이 커리어넷 아닌 직업', srcOrder], qw));

  // youtubeLinks 개수가 3 미만인 직업
  const ytLowRow = q(
    `SELECT COUNT(*) as cnt FROM jobs WHERE LENGTH(user_contributed_json) >= 500 AND json_extract(user_contributed_json, '$.youtubeLinks') IS NOT NULL AND json_type(user_contributed_json, '$.youtubeLinks') = 'array' AND json_array_length(user_contributed_json, '$.youtubeLinks') < 3`
  );
  const ytLow = ytLowRow[0]?.cnt ?? 0;
  console.log(tableRow(['youtubeLinks 3개 미만인 직업', ytLow + (ytLow > 0 ? ' ?' : '')], qw));

  console.log(tableDivider(qw));

  // ─── 4. 최근 변경 ───────────────────────────────────────────
  section('4. 최근 변경 (7일 이내)');

  const rw = [30, 8];
  console.log(tableDivider(rw));
  console.log(tableRow(['항목', '건수'], rw));
  console.log(tableDivider(rw));

  // created_at, user_last_updated_at은 INTEGER (Unix epoch, milliseconds)
  const sevenDaysAgo = Date.now() - 7 * 86400 * 1000;

  const recentUpdateRow = q(
    `SELECT COUNT(*) as cnt FROM jobs WHERE user_last_updated_at IS NOT NULL AND CAST(user_last_updated_at AS INTEGER) >= ${sevenDaysAgo}`
  );
  const recentUpdate = recentUpdateRow[0]?.cnt ?? 0;

  const recentCreateRow = q(
    `SELECT COUNT(*) as cnt FROM jobs WHERE created_at >= ${sevenDaysAgo}`
  );
  const recentCreate = recentCreateRow[0]?.cnt ?? 0;

  console.log(tableRow(['최근 7일 내 수정된 직업', recentUpdate], rw));
  console.log(tableRow(['최근 7일 내 신규 추가된 직업', recentCreate], rw));
  console.log(tableDivider(rw));

  // 최근 수정 직업 목록 (최대 10개)
  const recentList = q(
    `SELECT name, user_last_updated_at FROM jobs WHERE user_last_updated_at IS NOT NULL AND CAST(user_last_updated_at AS INTEGER) >= ${sevenDaysAgo} ORDER BY CAST(user_last_updated_at AS INTEGER) DESC LIMIT 10`
  );
  if (recentList.length > 0) {
    console.log('\n  최근 수정 직업 목록 (최대 10개):');
    for (const row of recentList) {
      const tsVal = parseInt(row.user_last_updated_at);
      const ts = !isNaN(tsVal) && tsVal > 0 ? new Date(tsVal).toISOString().slice(0, 10) : '-';
      console.log(`  - ${row.name}  (${ts})`);
    }
  }

  // ─── 5. 전공 현황 ───────────────────────────────────────────
  section('5. 전공 현황 (요약)');

  const majorTotalRow = q('SELECT COUNT(*) as cnt FROM majors');
  const majorTotal = majorTotalRow[0]?.cnt ?? 0;

  const majorDoneRow = q("SELECT COUNT(*) as cnt FROM majors WHERE LENGTH(user_contributed_json) >= 500");
  const majorDone = majorDoneRow[0]?.cnt ?? 0;

  const majorNullRow = q("SELECT COUNT(*) as cnt FROM majors WHERE user_contributed_json IS NULL OR user_contributed_json = ''");
  const majorNull = majorNullRow[0]?.cnt ?? 0;

  const mw = [22, 8, 7];
  console.log(tableDivider(mw));
  console.log(tableRow(['항목', '전공 수', '비율'], mw));
  console.log(tableDivider(mw));
  console.log(tableRow(['전체 전공', majorTotal, '100.0%'], mw));
  console.log(tableRow(['보완 완료 (>=500자)', majorDone, pct(majorDone, majorTotal)], mw));
  console.log(tableRow(['NULL (미보완)', majorNull, pct(majorNull, majorTotal)], mw));
  console.log(tableDivider(mw));

  console.log('\n' + hr('#'));
  console.log('# 보고서 끝');
  console.log(hr('#') + '\n');
}

main().catch(e => {
  console.error('\n[FATAL]', e.message);
  process.exit(1);
});
