#!/usr/bin/env node
/**
 * generate-codex-prompt.cjs
 *
 * batch-report.json + audit.json을 읽어 Codex에 붙여넣기할 수 있는
 * 검증 프롬프트를 자동 생성한다.
 *
 * Usage:
 *   node scripts/generate-codex-prompt.cjs \
 *     --batch-report=reports/batch-59-2026-04-08.json \
 *     --audit=reports/audit-59-2026-04-08.json
 *
 * Output:
 *   reports/codex-prompt-59-2026-04-08.md  (파일)
 *   콘솔 출력 (클립보드 복사용)
 */

'use strict';

const fs = require('fs');
const path = require('path');

const ROOT_DIR = path.resolve(__dirname, '..');
const REPORTS_DIR = path.join(ROOT_DIR, 'reports');
const AGENTS_MD_PATH = path.join(ROOT_DIR, 'AGENTS.md');

// ── 프롬프트 생성 ────────────────────────────────────────────────────────────

function buildPrompt(batchReport, auditReport) {
  const batchNum = batchReport.batchNum;
  const jobResults = batchReport.results || [];
  const auditResults = auditReport ? (auditReport.results || []) : [];
  const auditBySlug = Object.fromEntries(auditResults.map(r => [r.slug, r]));

  const failedJobs = auditResults.filter(r => r.overallLevel === 'FAIL' || r.overallLevel === 'ERROR');
  const warnedJobs = auditResults.filter(r => r.overallLevel === 'WARN');
  const passedJobs = auditResults.filter(r => r.overallLevel === 'PASS');

  const today = new Date().toISOString().slice(0, 10);

  let prompt = `# CareerWiki Batch ${batchNum} — Codex 검증 요청 (${today})\n\n`;
  prompt += `> **AGENTS.md**를 먼저 읽고 아래 직업들을 검증해줘.\n`;
  prompt += `> 프로젝트 루트의 \`AGENTS.md\`에 모든 규칙이 있어.\n\n`;
  prompt += `---\n\n`;

  // 배치 요약
  prompt += `## 📦 이번 배치 정보\n\n`;
  prompt += `- **배치 번호**: ${batchNum}\n`;
  prompt += `- **처리 직업 수**: ${jobResults.length}개\n`;
  if (auditReport) {
    const s = auditReport.summary;
    prompt += `- **감사 결과**: PASS ${s.pass}개 / WARN ${s.warn}개 / FAIL ${s.fail}개\n`;
  }
  prompt += `\n`;

  // 직업 목록
  prompt += `## 📋 직업 목록\n\n`;
  prompt += `| 직업 | slug | 출처 수 | YouTube | salary 연도 | 감사 결과 |\n`;
  prompt += `|------|------|--------|---------|------------|----------|\n`;
  for (const r of jobResults) {
    const audit = auditBySlug[r.slug];
    const auditIcon = !audit ? '—'
      : audit.overallLevel === 'PASS' ? '✅'
      : audit.overallLevel === 'WARN' ? '⚠️'
      : '❌';
    prompt += `| ${r.name} | \`${r.slug}\` | ${r.userSourceCount}개 | ${r.youtubeCount}개 | ${r.salaryHasYear ? '✅' : '❌'} | ${auditIcon} ${audit?.overallLevel || '—'} |\n`;
  }
  prompt += `\n`;

  // FAIL 항목 상세
  if (failedJobs.length > 0) {
    prompt += `## ❌ FAIL 직업 — 우선 검토 필요\n\n`;
    for (const r of failedJobs) {
      const br = jobResults.find(j => j.slug === r.slug);
      prompt += `### ${br?.name || r.slug} (\`${r.slug}\`)\n\n`;
      if (r.fails.length > 0) {
        prompt += `**FAIL 항목:**\n`;
        r.fails.forEach(f => { prompt += `- ❌ ${f}\n`; });
        prompt += '\n';
      }
      if (r.warns.length > 0) {
        prompt += `**WARN 항목:**\n`;
        r.warns.forEach(w => { prompt += `- ⚠️ ${w}\n`; });
        prompt += '\n';
      }
      prompt += `**확인 URL**: https://careerwiki.org/job/${r.slug}\n\n`;
    }
  }

  // WARN 항목
  if (warnedJobs.length > 0) {
    prompt += `## ⚠️ WARN 직업 — 확인 권장\n\n`;
    for (const r of warnedJobs) {
      const br = jobResults.find(j => j.slug === r.slug);
      prompt += `### ${br?.name || r.slug} (\`${r.slug}\`)\n\n`;
      if (r.warns.length > 0) {
        r.warns.forEach(w => { prompt += `- ⚠️ ${w}\n`; });
        prompt += '\n';
      }
      prompt += `**확인 URL**: https://careerwiki.org/job/${r.slug}\n\n`;
    }
  }

  // 검증 지시사항
  prompt += `---\n\n`;
  prompt += `## 🔍 Codex 검증 지시사항\n\n`;
  prompt += `각 직업 페이지(https://careerwiki.org/job/{slug})를 열어서:\n\n`;
  prompt += `### 필수 체크\n\n`;
  prompt += `1. **각주 번호 순서** — 위에서 아래로 스크롤하면서 [1], [2], [3]... 순서대로 나오는지\n`;
  prompt += `2. **출처 배지 수** — 페이지 하단 출처 섹션의 숫자가 본문 [N] 마커 수와 일치하는지\n`;
  prompt += `   - 배지 수 = 커리어넷(1) + 사용자 출처(N) 이 맞는지\n`;
  prompt += `3. **기존 데이터 보존** — 임금 바 차트가 표시되는지, overviewProspect 그래프가 있는지\n`;
  prompt += `4. **salary 연도** — 임금 설명에 "20XX년 기준" 형식의 연도가 포함되어 있는지\n`;
  prompt += `5. **detailReady 항목** — 정규 교육과정/채용정보/훈련/자격증이 올바르게 렌더링되는지\n`;
  prompt += `6. **추천 자격증 [N] 마커** — 자격증 이름에 [숫자]가 그대로 노출되지 않는지\n\n`;

  // FAIL/WARN 직업 추가 지시
  if (failedJobs.length > 0) {
    prompt += `### FAIL 직업 추가 확인\n\n`;
    prompt += `위 FAIL 목록의 직업들은 full-quality-audit에서 문제가 감지되었음. `;
    prompt += `각 FAIL 항목을 읽고 페이지에서 직접 확인해줘.\n\n`;
  }

  prompt += `### 발견한 문제 보고 방법\n\n`;
  prompt += `문제 발견 시 다음 형식으로 보고:\n\n`;
  prompt += `\`\`\`\n`;
  prompt += `직업: [직업명] (slug: [slug])\n`;
  prompt += `문제: [구체적 설명]\n`;
  prompt += `위치: [어느 섹션/필드]\n`;
  prompt += `권장 조치: [수정 방법]\n`;
  prompt += `\`\`\`\n\n`;
  prompt += `이슈를 Claude에게 전달하면 Claude가 DB 수정 + 배포를 처리함.\n`;

  return prompt;
}

// ── 메인 ────────────────────────────────────────────────────────────────────

function main() {
  const args = process.argv.slice(2);
  const batchArg = args.find(a => a.startsWith('--batch-report='));
  const auditArg = args.find(a => a.startsWith('--audit='));

  if (!batchArg) {
    console.error('Usage: node scripts/generate-codex-prompt.cjs --batch-report=reports/batch-59-2026-04-08.json [--audit=reports/audit-59-2026-04-08.json]');
    process.exit(1);
  }

  const batchPath = path.resolve(ROOT_DIR, batchArg.split('=').slice(1).join('='));
  if (!fs.existsSync(batchPath)) {
    console.error(`❌ batch-report 파일 없음: ${batchPath}`);
    process.exit(1);
  }

  const batchReport = JSON.parse(fs.readFileSync(batchPath, 'utf8'));
  let auditReport = null;

  if (auditArg) {
    const auditPath = path.resolve(ROOT_DIR, auditArg.split('=').slice(1).join('='));
    if (fs.existsSync(auditPath)) {
      auditReport = JSON.parse(fs.readFileSync(auditPath, 'utf8'));
    } else {
      console.warn(`⚠️ audit 파일 없음: ${auditPath} — 감사 결과 없이 프롬프트 생성`);
    }
  }

  const prompt = buildPrompt(batchReport, auditReport);

  // 파일 저장
  if (!fs.existsSync(REPORTS_DIR)) fs.mkdirSync(REPORTS_DIR, { recursive: true });
  const today = new Date().toISOString().slice(0, 10);
  const batchNum = batchReport.batchNum;
  const outPath = path.join(REPORTS_DIR, `codex-prompt-${batchNum}-${today}.md`);

  fs.writeFileSync(outPath, prompt, 'utf8');
  console.log(`\n✅ Codex 프롬프트 저장: ${outPath}\n`);
  console.log('─'.repeat(70));
  console.log(prompt);
  console.log('─'.repeat(70));
  console.log(`\n👆 위 내용을 Codex에 붙여넣으세요.\n`);
}

module.exports = { buildPrompt };
main();
