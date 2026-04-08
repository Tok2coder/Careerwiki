#!/usr/bin/env node
/**
 * auto-audit.cjs
 *
 * batch-report.json을 읽어 해당 직업들에 full-quality-audit.cjs를 실행하고
 * 결과를 reports/audit-{번호}-{날짜}.json + .md로 저장한다.
 *
 * Usage:
 *   node scripts/auto-audit.cjs --batch-report reports/batch-59-2026-04-08.json
 *
 * Exit codes: 0 = 모두 PASS, 1 = 하나 이상 FAIL
 */

'use strict';

const { execSync, spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const ROOT_DIR = path.resolve(__dirname, '..');
const REPORTS_DIR = path.join(ROOT_DIR, 'reports');

// ── full-quality-audit.cjs 실행 ───────────────────────────────────────────────

function runAuditForSlug(slug) {
  const scriptPath = path.join(__dirname, 'full-quality-audit.cjs');
  try {
    const result = spawnSync(
      'node',
      [scriptPath, `--slug=${slug}`],
      {
        encoding: 'utf8',
        timeout: 120000,
        maxBuffer: 10 * 1024 * 1024,
        cwd: ROOT_DIR,
      }
    );

    const stdout = result.stdout || '';
    const stderr = result.stderr || '';
    const exitCode = result.status ?? 1;

    // 출력에서 PASS/FAIL/WARN 라인 파싱
    const issues = [];
    const lines = stdout.split('\n');
    for (const line of lines) {
      if (line.includes('[Gate') || line.includes('FAIL') || line.includes('WARN') || line.includes('PASS')) {
        const trimmed = line.trim();
        if (trimmed) issues.push(trimmed);
      }
    }

    // 오버올 레벨 추출
    let overallLevel = 'PASS';
    if (exitCode !== 0) overallLevel = 'FAIL';
    else if (stdout.includes('⚠️') || stdout.includes('WARN')) overallLevel = 'WARN';

    // Gate별 이슈 파싱
    const gateIssues = { FAIL: [], WARN: [], PASS: [] };
    for (const line of lines) {
      const clean = line.replace(/^\s+/, '').replace(/❌\s*/, '').replace(/⚠️\s*/, '').replace(/✅\s*/, '');
      if (line.includes('❌') && clean.includes('[Gate')) gateIssues.FAIL.push(clean);
      else if (line.includes('⚠️') && clean.includes('[Gate')) gateIssues.WARN.push(clean);
      else if (line.includes('✅') && clean.includes('[Gate')) gateIssues.PASS.push(clean);
    }

    return { slug, overallLevel, exitCode, gateIssues, stdout, stderr };
  } catch (e) {
    return {
      slug,
      overallLevel: 'ERROR',
      exitCode: 2,
      gateIssues: { FAIL: [`실행 오류: ${e.message}`], WARN: [], PASS: [] },
      stdout: '',
      stderr: e.message,
    };
  }
}

// ── 마크다운 리포트 생성 ────────────────────────────────────────────────────────

function generateMarkdown(batchNum, batchReport, auditResults, generatedAt) {
  const fails = auditResults.filter(r => r.overallLevel === 'FAIL' || r.overallLevel === 'ERROR');
  const warns = auditResults.filter(r => r.overallLevel === 'WARN');
  const passes = auditResults.filter(r => r.overallLevel === 'PASS');

  let md = `# Batch ${batchNum} 품질 감사 결과\n\n`;
  md += `**원본 배치**: ${path.basename(batchReport)}  \n`;
  md += `**감사 일시**: ${generatedAt}  \n`;
  md += `**총 직업**: ${auditResults.length}개\n\n`;
  md += `| 결과 | 수 |\n|------|----|\n`;
  md += `| ✅ PASS | ${passes.length}개 |\n`;
  md += `| ⚠️ WARN | ${warns.length}개 |\n`;
  md += `| ❌ FAIL | ${fails.length}개 |\n\n`;
  md += `---\n\n`;

  // FAIL 먼저
  for (const r of [...fails, ...warns, ...passes]) {
    const icon = r.overallLevel === 'FAIL' || r.overallLevel === 'ERROR' ? '❌'
      : r.overallLevel === 'WARN' ? '⚠️' : '✅';
    md += `## ${icon} ${r.slug} — ${r.overallLevel}\n\n`;

    if (r.gateIssues.FAIL.length > 0) {
      md += `**FAIL 항목:**\n`;
      r.gateIssues.FAIL.forEach(i => { md += `- ❌ ${i}\n`; });
      md += '\n';
    }
    if (r.gateIssues.WARN.length > 0) {
      md += `**WARN 항목:**\n`;
      r.gateIssues.WARN.forEach(i => { md += `- ⚠️ ${i}\n`; });
      md += '\n';
    }
    if (r.gateIssues.PASS.length > 0) {
      md += `**PASS 항목:**\n`;
      r.gateIssues.PASS.forEach(i => { md += `- ✅ ${i}\n`; });
      md += '\n';
    }
    if (r.gateIssues.FAIL.length === 0 && r.gateIssues.WARN.length === 0 && r.gateIssues.PASS.length === 0) {
      md += `*감사 항목 없음 (데이터 부재 또는 UCJ 없음)*\n\n`;
    }
  }

  return md;
}

// ── 메인 ────────────────────────────────────────────────────────────────────

function main() {
  const args = process.argv.slice(2);
  const reportArg = args.find(a => a.startsWith('--batch-report='));

  if (!reportArg) {
    console.error('Usage: node scripts/auto-audit.cjs --batch-report=reports/batch-59-2026-04-08.json');
    process.exit(1);
  }

  const reportPath = path.resolve(ROOT_DIR, reportArg.split('=').slice(1).join('='));

  if (!fs.existsSync(reportPath)) {
    console.error(`❌ 리포트 파일 없음: ${reportPath}`);
    process.exit(1);
  }

  const batchReport = JSON.parse(fs.readFileSync(reportPath, 'utf8'));
  const { batchNum, results: jobResults } = batchReport;

  if (!Array.isArray(jobResults) || jobResults.length === 0) {
    console.error('❌ batch-report에 직업 목록이 없습니다.');
    process.exit(1);
  }

  const slugs = jobResults.map(r => r.slug);
  const today = new Date().toISOString().slice(0, 10);
  const jsonOutPath = path.join(REPORTS_DIR, `audit-${batchNum}-${today}.json`);
  const mdOutPath = path.join(REPORTS_DIR, `audit-${batchNum}-${today}.md`);

  if (!fs.existsSync(REPORTS_DIR)) fs.mkdirSync(REPORTS_DIR, { recursive: true });

  console.log(`\n🔍 Batch ${batchNum} 품질 감사 시작 (${slugs.length}개 직업)\n`);
  console.log('─'.repeat(60));

  const auditResults = [];
  for (const slug of slugs) {
    process.stdout.write(`  감사 중: ${slug}... `);
    const result = runAuditForSlug(slug);
    const icon = result.overallLevel === 'FAIL' ? '❌' : result.overallLevel === 'WARN' ? '⚠️ ' : '✅';
    console.log(`${icon} ${result.overallLevel}`);
    auditResults.push(result);
  }

  console.log('─'.repeat(60));

  const generatedAt = new Date().toISOString();
  const output = {
    batchNum,
    batchReportPath: reportPath,
    generatedAt,
    summary: {
      total: auditResults.length,
      pass: auditResults.filter(r => r.overallLevel === 'PASS').length,
      warn: auditResults.filter(r => r.overallLevel === 'WARN').length,
      fail: auditResults.filter(r => r.overallLevel === 'FAIL' || r.overallLevel === 'ERROR').length,
    },
    results: auditResults.map(r => ({
      slug: r.slug,
      overallLevel: r.overallLevel,
      fails: r.gateIssues.FAIL,
      warns: r.gateIssues.WARN,
    })),
  };

  fs.writeFileSync(jsonOutPath, JSON.stringify(output, null, 2), 'utf8');
  fs.writeFileSync(mdOutPath, generateMarkdown(batchNum, path.basename(reportPath), auditResults, generatedAt), 'utf8');

  const { total, pass, warn, fail } = output.summary;
  console.log(`\n감사 완료: 총 ${total}개`);
  console.log(`  ✅ PASS: ${pass}개`);
  console.log(`  ⚠️  WARN: ${warn}개`);
  console.log(`  ❌ FAIL: ${fail}개`);
  console.log(`\n✅ JSON: ${jsonOutPath}`);
  console.log(`✅ MD:   ${mdOutPath}\n`);

  process.exit(fail > 0 ? 1 : 0);
}

module.exports = { runAuditForSlug };
main();
