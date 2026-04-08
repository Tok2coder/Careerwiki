#!/usr/bin/env node
/**
 * run-batch-pipeline.cjs
 *
 * 원스톱 배치 파이프라인:
 *   1. batch-report.cjs — 직업 현황 리포트
 *   2. auto-audit.cjs   — full-quality-audit 실행
 *   3. generate-codex-prompt.cjs — Codex 프롬프트 생성
 *
 * Usage:
 *   node scripts/run-batch-pipeline.cjs --jobs "물리치료사,미장원,물류관리사" --batch 59
 *
 * 각 단계 실패해도 다음 단계는 계속 진행. 실패는 최종 요약에 기록.
 */

'use strict';

const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const ROOT_DIR = path.resolve(__dirname, '..');
const SCRIPTS_DIR = __dirname;

// ── 단계 실행 ────────────────────────────────────────────────────────────────

function runStep(label, scriptName, scriptArgs) {
  const scriptPath = path.join(SCRIPTS_DIR, scriptName);
  console.log(`\n${'━'.repeat(60)}`);
  console.log(`▶ ${label}`);
  console.log(`  node scripts/${scriptName} ${scriptArgs.join(' ')}`);
  console.log('─'.repeat(60));

  const result = spawnSync('node', [scriptPath, ...scriptArgs], {
    encoding: 'utf8',
    stdio: 'inherit',        // 직접 터미널로 출력
    timeout: 300000,         // 5분
    maxBuffer: 20 * 1024 * 1024,
    cwd: ROOT_DIR,
  });

  const exitCode = result.status ?? 1;
  const success = exitCode === 0;

  if (result.error) {
    console.error(`  ❌ 실행 오류: ${result.error.message}`);
  }

  return { label, scriptName, exitCode, success };
}

// ── 최신 리포트 파일 경로 추측 ────────────────────────────────────────────────

function latestReport(prefix, batchNum) {
  const today = new Date().toISOString().slice(0, 10);
  return `reports/${prefix}-${batchNum}-${today}.json`;
}

// ── 메인 ────────────────────────────────────────────────────────────────────

function main() {
  const args = process.argv.slice(2);
  const jobsArg = args.find(a => a.startsWith('--jobs='));
  const batchArg = args.find(a => a.startsWith('--batch='));

  // --jobs "..." (스페이스 구분 방식도 지원)
  let jobsStr = null;
  if (jobsArg) {
    jobsStr = jobsArg.split('=').slice(1).join('=');
  } else {
    const jobsIdx = args.indexOf('--jobs');
    if (jobsIdx !== -1 && args[jobsIdx + 1]) jobsStr = args[jobsIdx + 1];
  }

  let batchNum = null;
  if (batchArg) {
    batchNum = parseInt(batchArg.split('=')[1]);
  } else {
    const batchIdx = args.indexOf('--batch');
    if (batchIdx !== -1 && args[batchIdx + 1]) batchNum = parseInt(args[batchIdx + 1]);
  }

  if (!jobsStr || !batchNum) {
    console.error('Usage: node scripts/run-batch-pipeline.cjs --jobs="직업1,직업2,직업3" --batch=59');
    console.error('  또는: node scripts/run-batch-pipeline.cjs --jobs "직업1,직업2" --batch 59');
    process.exit(1);
  }

  const slugs = jobsStr.split(',').map(s => s.trim()).filter(Boolean);
  const today = new Date().toISOString().slice(0, 10);

  console.log(`\n${'═'.repeat(60)}`);
  console.log(`🚀 CareerWiki 배치 파이프라인 시작`);
  console.log(`   배치 번호: ${batchNum}`);
  console.log(`   직업 수:   ${slugs.length}개`);
  console.log(`   직업 목록: ${slugs.join(', ')}`);
  console.log(`${'═'.repeat(60)}`);

  const stepResults = [];

  // Step 1: batch-report
  const batchReportPath = `reports/batch-${batchNum}-${today}.json`;
  const step1 = runStep(
    'Step 1: 배치 리포트 생성',
    'batch-report.cjs',
    [`--jobs=${jobsStr}`, `--batch=${batchNum}`]
  );
  stepResults.push(step1);

  // Step 2: auto-audit (batch-report 파일 기반)
  let auditPath = null;
  const batchReportFull = path.join(ROOT_DIR, batchReportPath);

  if (fs.existsSync(batchReportFull)) {
    auditPath = `reports/audit-${batchNum}-${today}.json`;
    const step2 = runStep(
      'Step 2: 품질 감사 (full-quality-audit)',
      'auto-audit.cjs',
      [`--batch-report=${batchReportPath}`]
    );
    stepResults.push(step2);
  } else {
    console.log('\n⚠️ Step 2 건너뜀: batch-report.json 파일 없음 (Step 1 실패)');
    stepResults.push({ label: 'Step 2: 품질 감사', success: false, exitCode: 1, skipped: true });
  }

  // Step 3: generate-codex-prompt
  const auditFull = auditPath ? path.join(ROOT_DIR, auditPath) : null;
  const promptArgs = [`--batch-report=${batchReportPath}`];
  if (auditFull && fs.existsSync(auditFull)) {
    promptArgs.push(`--audit=${auditPath}`);
  }

  if (fs.existsSync(batchReportFull)) {
    const step3 = runStep(
      'Step 3: Codex 프롬프트 생성',
      'generate-codex-prompt.cjs',
      promptArgs
    );
    stepResults.push(step3);
  } else {
    console.log('\n⚠️ Step 3 건너뜀: batch-report.json 파일 없음');
    stepResults.push({ label: 'Step 3: Codex 프롬프트', success: false, exitCode: 1, skipped: true });
  }

  // 최종 요약
  console.log(`\n${'═'.repeat(60)}`);
  console.log(`📊 파이프라인 완료 요약`);
  console.log('─'.repeat(60));

  for (const s of stepResults) {
    const icon = s.skipped ? '⏭️ ' : s.success ? '✅' : '⚠️';
    const status = s.skipped ? 'SKIP' : s.success ? 'OK' : `FAIL (exit ${s.exitCode})`;
    console.log(`  ${icon} ${s.label}: ${status}`);
  }

  // 생성된 파일 목록
  console.log('\n📁 생성된 파일:');
  const expectedFiles = [
    path.join(ROOT_DIR, `reports/batch-${batchNum}-${today}.json`),
    path.join(ROOT_DIR, `reports/batch-${batchNum}-${today}.md`),
    path.join(ROOT_DIR, `reports/audit-${batchNum}-${today}.json`),
    path.join(ROOT_DIR, `reports/audit-${batchNum}-${today}.md`),
    path.join(ROOT_DIR, `reports/codex-prompt-${batchNum}-${today}.md`),
  ];
  for (const f of expectedFiles) {
    const exists = fs.existsSync(f);
    console.log(`  ${exists ? '✅' : '❌'} ${path.relative(ROOT_DIR, f)}`);
  }

  // audit 결과 요약 (있으면)
  const auditJsonFull = path.join(ROOT_DIR, `reports/audit-${batchNum}-${today}.json`);
  if (fs.existsSync(auditJsonFull)) {
    try {
      const audit = JSON.parse(fs.readFileSync(auditJsonFull, 'utf8'));
      const s = audit.summary;
      console.log(`\n🔍 감사 결과: PASS ${s.pass}개 / WARN ${s.warn}개 / FAIL ${s.fail}개`);
      if (s.fail > 0) {
        const failList = audit.results.filter(r => r.overallLevel === 'FAIL' || r.overallLevel === 'ERROR');
        console.log(`\n❌ FAIL 직업:`);
        failList.forEach(r => {
          console.log(`  - ${r.slug}`);
          r.fails.forEach(f => console.log(`    ❌ ${f}`));
        });
      }
    } catch {}
  }

  const codexPromptPath = path.join(ROOT_DIR, `reports/codex-prompt-${batchNum}-${today}.md`);
  if (fs.existsSync(codexPromptPath)) {
    console.log(`\n📋 Codex 프롬프트: reports/codex-prompt-${batchNum}-${today}.md`);
  }

  console.log(`${'═'.repeat(60)}\n`);

  // 전체 성공 여부는 Step 1(리포트) 성공 여부로 판단
  const overallSuccess = stepResults[0]?.success ?? false;
  process.exit(overallSuccess ? 0 : 1);
}

main();
