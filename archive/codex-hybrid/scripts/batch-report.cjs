#!/usr/bin/env node
/**
 * batch-report.cjs
 *
 * 배치 처리 완료 후 직업 데이터 현황 리포트를 생성한다.
 * D1에서 직접 데이터를 읽어 각 직업의 각주 정합성, 출처, 필드 완성도를 기록.
 *
 * Usage:
 *   node scripts/batch-report.cjs --jobs "물리치료사,미장원,물류관리사" --batch 59
 *   node scripts/batch-report.cjs --slugs "물리치료사,미장원" --batch 59
 *
 * Output:
 *   reports/batch-59-2026-04-08.json
 *   reports/batch-59-2026-04-08.md
 */

'use strict';

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const DB_NAME = 'careerwiki-kr';
const ROOT_DIR = path.resolve(__dirname, '..');
const REPORTS_DIR = path.join(ROOT_DIR, 'reports');

// ── D1 쿼리 헬퍼 ────────────────────────────────────────────────────────────

function queryD1(sql) {
  const escaped = sql.replace(/"/g, '\\"');
  try {
    const raw = execSync(
      `npx wrangler d1 execute ${DB_NAME} --remote --command "${escaped}"`,
      { encoding: 'utf8', timeout: 60000, maxBuffer: 50 * 1024 * 1024, cwd: ROOT_DIR }
    );
    const jsonStart = raw.indexOf('[');
    if (jsonStart === -1) throw new Error(`JSON 응답 없음. 출력: ${raw.substring(0, 300)}`);
    const parsed = JSON.parse(raw.substring(jsonStart));
    return parsed[0]?.results || [];
  } catch (e) {
    if (e.message && e.message.startsWith('JSON 응답 없음')) throw e;
    throw new Error(`D1 쿼리 실패: ${e.message}`);
  }
}

function sqlStr(val) {
  return val.replace(/'/g, "''");
}

// ── 분석 헬퍼 ────────────────────────────────────────────────────────────────

function getNestedValue(obj, path) {
  if (!obj || typeof obj !== 'object') return undefined;
  if (obj[path] !== undefined) return obj[path];
  const parts = path.split('.');
  let cur = obj;
  for (const p of parts) {
    if (cur == null || typeof cur !== 'object') return undefined;
    cur = cur[p];
  }
  return cur;
}

/**
 * UCJ와 merged_profile에서 직업 상태를 분석한다.
 */
function analyzeJob(job) {
  let ucj = {};
  let merged = {};

  try { ucj = job.user_contributed_json ? JSON.parse(job.user_contributed_json) : {}; } catch {}
  try { merged = job.merged_profile_json ? JSON.parse(job.merged_profile_json) : {}; } catch {}

  const sources = ucj._sources || {};
  const userSourceCount = Object.values(sources)
    .filter(Array.isArray)
    .reduce((sum, arr) => sum + arr.length, 0);

  // 출처가 등록된 필드 목록
  const fieldsWithSources = Object.keys(sources).filter(k => Array.isArray(sources[k]) && sources[k].length > 0);

  // salary 연도 포함 여부
  const sal = getNestedValue(merged, 'overviewSalary.sal') || '';
  const salaryHasYear = /\d{4}년/.test(sal);

  // detailReady 항목 타입 검사
  const dr = ucj.detailReady || merged.detailReady;
  const detailReadyIssues = [];
  if (dr && typeof dr === 'object') {
    for (const sub of ['curriculum', 'training']) {
      if (Array.isArray(dr[sub])) {
        dr[sub].forEach((item, i) => {
          if (item !== null && typeof item === 'object') {
            detailReadyIssues.push(`detailReady.${sub}[${i}] is object (should be string)`);
          }
        });
      }
    }
  }

  // 각주 현황
  const footnoteFields = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia',
    'detailWlb.wlbDetail', 'detailWlb.socialDetail', 'overviewAbilities.technKnow'];
  const footnoteInfo = {};
  for (const fp of footnoteFields) {
    const text = getNestedValue(merged, fp);
    if (text && typeof text === 'string') {
      const markers = text.match(/\[(\d+)\]/g) || [];
      if (markers.length > 0) footnoteInfo[fp] = markers.length;
    }
  }

  // way 있는지
  const hasWay = !!(ucj.way || merged.way);
  // youtubeLinks
  const ytLinks = merged.youtubeLinks;
  const youtubeCount = Array.isArray(ytLinks) ? ytLinks.length : 0;

  return {
    jobId: job.id,
    name: job.name,
    slug: job.slug,
    hasWay,
    youtubeCount,
    userSourceCount,
    totalBadgeCount: userSourceCount + 1, // API(커리어넷) 1 + user
    fieldsWithSources,
    footnoteInfo,
    salaryHasYear,
    salaryText: sal ? sal.substring(0, 60) + (sal.length > 60 ? '…' : '') : null,
    detailReadyIssues,
    hasDetialReady: !!(ucj.detailReady || merged.detailReady),
  };
}

// ── 리포트 생성 ──────────────────────────────────────────────────────────────

function todayStr() {
  return new Date().toISOString().slice(0, 10);
}

function generateMarkdown(batchNum, slugs, results, generatedAt) {
  const pass = results.filter(r => r.detailReadyIssues.length === 0);
  const warn = results.filter(r => r.detailReadyIssues.length > 0);

  let md = `# Batch ${batchNum} 리포트\n\n`;
  md += `**생성일시**: ${generatedAt}  \n`;
  md += `**직업 수**: ${results.length}개  \n`;
  md += `**이슈 없음**: ${pass.length}개 / **이슈 있음**: ${warn.length}개\n\n`;
  md += `---\n\n`;

  for (const r of results) {
    const icon = r.detailReadyIssues.length > 0 ? '⚠️' : '✅';
    md += `## ${icon} ${r.name} (\`${r.slug}\`)\n\n`;
    md += `| 항목 | 값 |\n|------|----|\n`;
    md += `| Job ID | \`${r.jobId}\` |\n`;
    md += `| way | ${r.hasWay ? '✅ 있음' : '❌ 없음'} |\n`;
    md += `| YouTube | ${r.youtubeCount}개 |\n`;
    md += `| 사용자 출처 수 | ${r.userSourceCount}개 |\n`;
    md += `| 출처 배지 | ${r.totalBadgeCount}개 (커리어넷 1 + ${r.userSourceCount}) |\n`;
    md += `| salary 연도 포함 | ${r.salaryHasYear ? '✅' : '❌ 없음'} |\n`;
    md += `| detailReady 타입 이슈 | ${r.detailReadyIssues.length > 0 ? r.detailReadyIssues.join(', ') : '없음'} |\n`;
    md += `\n`;

    if (r.fieldsWithSources.length > 0) {
      md += `**출처 등록 필드**: ${r.fieldsWithSources.join(', ')}\n\n`;
    }
    if (Object.keys(r.footnoteInfo).length > 0) {
      const fnList = Object.entries(r.footnoteInfo).map(([f, n]) => `${f}(${n}개)`).join(', ');
      md += `**각주 현황**: ${fnList}\n\n`;
    }
    if (r.salaryText) {
      md += `**salary 미리보기**: ${r.salaryText}\n\n`;
    }
  }

  return md;
}

function generateReport({ jobs: slugList, batchNum }) {
  if (!fs.existsSync(REPORTS_DIR)) fs.mkdirSync(REPORTS_DIR, { recursive: true });

  const today = todayStr();
  const jsonPath = path.join(REPORTS_DIR, `batch-${batchNum}-${today}.json`);
  const mdPath = path.join(REPORTS_DIR, `batch-${batchNum}-${today}.md`);

  console.log(`\n📋 Batch ${batchNum} 리포트 생성 중... (${slugList.length}개 직업)\n`);

  // D1에서 한 번에 조회
  const slugsIn = slugList.map(s => `'${sqlStr(s.trim())}'`).join(', ');
  const rows = queryD1(
    `SELECT id, name, slug, user_contributed_json, merged_profile_json FROM jobs ` +
    `WHERE slug IN (${slugsIn}) AND is_active = 1`
  );

  if (rows.length === 0) {
    console.error('❌ 직업을 하나도 찾지 못했습니다. slug 목록을 확인하세요.');
    process.exit(1);
  }

  // 요청 순서 유지
  const rowBySlug = Object.fromEntries(rows.map(r => [r.slug, r]));
  const results = [];
  const notFound = [];

  for (const slug of slugList) {
    const s = slug.trim();
    if (rowBySlug[s]) {
      results.push(analyzeJob(rowBySlug[s]));
    } else {
      notFound.push(s);
      console.warn(`  ⚠️ 찾을 수 없음: ${s}`);
    }
  }

  const generatedAt = new Date().toISOString();
  const report = {
    batchNum,
    generatedAt,
    slugs: slugList,
    notFound,
    jobCount: results.length,
    results,
  };

  fs.writeFileSync(jsonPath, JSON.stringify(report, null, 2), 'utf8');
  fs.writeFileSync(mdPath, generateMarkdown(batchNum, slugList, results, generatedAt), 'utf8');

  console.log(`✅ JSON: ${jsonPath}`);
  console.log(`✅ MD:   ${mdPath}`);

  // 콘솔 요약
  const issueJobs = results.filter(r => r.detailReadyIssues.length > 0 || !r.salaryHasYear && r.userSourceCount > 0);
  if (issueJobs.length > 0) {
    console.log(`\n⚠️ 주의 필요 직업:`);
    issueJobs.forEach(r => {
      const issues = [];
      if (r.detailReadyIssues.length > 0) issues.push('detailReady 타입 오류');
      if (!r.salaryHasYear && r.userSourceCount > 0) issues.push('salary 연도 없음');
      console.log(`  - ${r.name}: ${issues.join(', ')}`);
    });
  }

  return { jsonPath, mdPath, report };
}

// ── 메인 ────────────────────────────────────────────────────────────────────

function main() {
  const args = process.argv.slice(2);
  const jobsArg = args.find(a => a.startsWith('--jobs=') || a.startsWith('--slugs='));
  const batchArg = args.find(a => a.startsWith('--batch='));

  if (!jobsArg || !batchArg) {
    console.error('Usage: node scripts/batch-report.cjs --jobs="직업1,직업2,직업3" --batch=59');
    process.exit(1);
  }

  const slugList = jobsArg.split('=').slice(1).join('=').split(',').map(s => s.trim()).filter(Boolean);
  const batchNum = parseInt(batchArg.split('=')[1]);

  if (slugList.length === 0) {
    console.error('직업 목록이 비어있습니다.');
    process.exit(1);
  }

  generateReport({ jobs: slugList, batchNum });
}

module.exports = { generateReport };
main();
