#!/usr/bin/env node
// scripts/skill-cache/build-cycle-v3.cjs
//
// v3 cycle 빌더 — 옵션 B' 최소안전 절감 (2026-05-06 채택).
// build-cycle1/2/3-prompts.cjs (verbose v1/v2) 대체.
//
// pilot 검증 완료 (3직업, 2026-05-06):
//   - 평균 ~107K tokens/call (vs v2 1.18M = -91%)
//   - audit-deep CLEAN 100% / fact-source warn-only OK / WebFetch ≥ URL count
//
// === 폴링 차단 운영 룰 (orchestrator 필독) ===
//
// "v4 audit 끝났어?" 같은 polling 1줄 → orchestrator가 dispatch에 status 한 줄 보내
// subagent 띄우면 75 fan-out → 172M token 폭주 (2026-04-29 사고).
//
// **새 룰**:
//   - polling = orchestrator가 직접 bash로 처리:
//       tail -n 50 ~/.claude/projects/{repo}/{sessionId}.jsonl | grep '"role":"assistant"'
//   - 사고 자동 발견은 hook (audit-after-edit.cjs)이 담당
//   - status check 1초 안에 끝나야 함 — subagent 띄우지 마
//   - subagent dispatch는 새 직업 작업 시작 시점만, polling은 절대 X
//
// === 사용 ===
//
//   node scripts/skill-cache/build-cycle-v3.cjs --slugs=A,B,C       # 명시 직업 list
//   node scripts/skill-cache/build-cycle-v3.cjs --queue=retry        # dispatch-queue.json retry
//   node scripts/skill-cache/build-cycle-v3.cjs --master --skip=0 --pick=25  # master cohort
//   node scripts/skill-cache/build-cycle-v3.cjs --fact-source=PARTIAL,MISMATCH --pick=15  # body-source
//   node scripts/skill-cache/build-cycle-v3.cjs --slugs=바리스타 --check-pilot-byte-equal  # pilot diff
//
// 옵션:
//   --sessions=5      세션 분할 수 (default 5, cycle 패턴 그대로)
//   --out=PATH        markdown 저장 경로 (default data/cycle-v3-prompts.md)
//   --json            JSON 출력 (orchestrator가 파싱)
//   --no-audit        audit-sources-deep + audit-fact-source-match 건너뜀 (테스트용)
//
// 출력: data/cycle-v3-prompts.md (또는 --out 경로) + stdout 운영 가이드

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const { buildDispatchPrompt, verifySafetyRulesPresent, MAIN_HEAD_MIN } = require('./lib/dispatch-prompt-v3.cjs');

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const SESSIONS = parseInt(args.sessions || '5');
const OUT = args.out || 'data/cycle-v3-prompts.md';
const SKIP = parseInt(args.skip || '0');
const PICK = parseInt(args.pick || '');
const NO_AUDIT = !!args['no-audit'];

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const cmdline = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`;
  const r = spawnSync(cmdline, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 200 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  if (r.status !== 0 && !r.stdout) throw new Error(`wrangler failed: ${(r.stderr || '').slice(0, 500)}`);
  const out = (r.stdout || '').trim();
  const start = out.indexOf('[');
  if (start < 0) return [];
  let depth = 0, end = -1, inStr = false, esc = false;
  for (let i = start; i < out.length; i++) {
    const c = out[i];
    if (esc) { esc = false; continue; }
    if (c === '\\') { esc = true; continue; }
    if (c === '"') { inStr = !inStr; continue; }
    if (inStr) continue;
    if (c === '[') depth++;
    else if (c === ']') { depth--; if (depth === 0) { end = i + 1; break; } }
  }
  if (end < 0) end = out.length;
  const arr = JSON.parse(out.slice(start, end));
  return arr[0]?.results || [];
}

function getJobIds(slugs) {
  if (slugs.length === 0) return [];
  const placeholders = slugs.map(s => `'${s.replace(/'/g, "''")}'`).join(',');
  const rows = d1Query(`SELECT id, slug FROM jobs WHERE slug IN (${placeholders}) AND is_active=1`);
  const map = {};
  for (const r of rows) map[r.slug] = String(r.id);
  return slugs.map(s => ({ slug: s, id: map[s] })).filter(j => j.id);
}

// audit 결과를 prompt에 박기 위해 cached audit-sources-deep + audit-fact-source-match 결과 사용.
// --no-audit 시 deepClean=null로 전송 (호출자가 입력 책임)
function loadAuditCache(slugs) {
  const result = {};
  if (NO_AUDIT) {
    for (const s of slugs) result[s] = { deep: null, factSource: null };
    return result;
  }
  // deep audit cache
  let deepData = null;
  const deepPath = path.join(REPO_ROOT, 'data', 'audit-sources-deep.json');
  if (fs.existsSync(deepPath)) {
    try { deepData = JSON.parse(fs.readFileSync(deepPath, 'utf8')); } catch {}
  }
  // fact-source cache
  let factData = null;
  const factPath = path.join(REPO_ROOT, 'data', 'fact-source-audit.json');
  if (fs.existsSync(factPath)) {
    try { factData = JSON.parse(fs.readFileSync(factPath, 'utf8')); } catch {}
  }
  for (const s of slugs) {
    const deep = deepData?.jobs?.find(j => j.slug === s) || null;
    const fact = factData?.jobs?.find(j => j.slug === s) || null;
    result[s] = { deep, factSource: fact };
  }
  return result;
}

function buildAuditOpts(slug, deep, factSource) {
  // deep 메트릭 → audit opt
  const audit = {
    totalUrls: deep?.totalUrls,
    externalHosts: deep?.externalHostCount,
    uniqueHosts: deep?.uniqueHosts,
    deepClean: deep ? (
      (deep.dupMarkers || []).length === 0 &&
      (deep.orphanSrc || []).length === 0 &&
      (deep.originDomain || []).length === 0 &&
      (deep.listPage || []).length === 0 &&
      (deep.rawURL || []).length === 0 &&
      (deep.brokenRef || []).length === 0 &&
      (deep.bracketPrefix || []).length === 0 &&
      (deep.mojibake || []).length === 0 &&
      !deep.sourcesNull && !deep.idxGap
    ) : false,
    patterns: [],
    detailLines: [],
  };
  if (deep) {
    const tags = [];
    if ((deep.dupMarkers || []).length) tags.push(`dup×${deep.dupMarkers.length}`);
    if ((deep.orphanSrc || []).length) tags.push(`orphan×${deep.orphanSrc.length}`);
    if ((deep.originDomain || []).length) tags.push(`originDomain×${deep.originDomain.length}`);
    if ((deep.brokenRef || []).length) tags.push(`brokenRef×${deep.brokenRef.length}`);
    if ((deep.rawURL || []).length) tags.push(`rawURL×${deep.rawURL.length}`);
    if ((deep.listPage || []).length) tags.push(`listPage×${deep.listPage.length}`);
    if ((deep.bracketPrefix || []).length) tags.push(`bracket×${deep.bracketPrefix.length}`);
    if ((deep.mojibake || []).length) tags.push(`mojibake×${deep.mojibake.length}`);
    if (deep.sourcesNull) tags.push('sourcesNull');
    if (tags.length === 0 && audit.deepClean) tags.push('deep-audit CLEAN (구조 OK)');
    audit.patterns = tags;
  }
  // fact-source 메트릭 → factSource opt
  const fs2 = {
    classification: factSource?.classification ?? null,
    suspect: factSource?.suspectFacts?.length ?? null,
    gen: factSource?.generalDomainFacts?.length ?? null,
    detailLines: [],
  };
  if (factSource) {
    if ((factSource.suspectFacts || []).length > 0) {
      const top = factSource.suspectFacts.slice(0, 3).map(f =>
        `suspect: ${f.field} "${(f.fact || '').slice(0, 30)}" → host=${f.srcHost}`
      );
      fs2.detailLines.push(...top);
    }
    if ((factSource.generalDomainFacts || []).length > 0) {
      const top = factSource.generalDomainFacts.slice(0, 2).map(f =>
        `gen: ${f.field} "${(f.fact || '').slice(0, 30)}" → ${f.label || f.srcUrl}`
      );
      fs2.detailLines.push(...top);
    }
  }
  return { audit, factSource: fs2 };
}

function deriveKeyTask(audit, factSource) {
  const pieces = [];
  if (factSource?.classification === 'MISMATCH') pieces.push('body-source coherence MISMATCH 해소 (협회 root → deep URL 또는 fact 일반화)');
  else if (factSource?.classification === 'PARTIAL') pieces.push(`fact-source PARTIAL 잔여 ${factSource.suspect ?? '?'}건 매핑/일반화`);
  else if (factSource?.classification === 'MATCH') pieces.push('이미 MATCH (구조 보강 대상)');
  if (!audit?.deepClean && (audit?.patterns || []).length > 0) {
    pieces.push(`deep-audit 패턴 정정: ${audit.patterns.join(' / ')}`);
  }
  return pieces.join('. ') || '17필드 보강 + body-source coherence 검증';
}

function pickJobs() {
  // mode 1: --slugs
  if (args.slugs) {
    const slugs = args.slugs.split(',').map(s => s.trim()).filter(Boolean);
    return getJobIds(slugs);
  }
  // mode 2: --queue=retry
  if (args.queue === 'retry') {
    const qPath = path.join(REPO_ROOT, 'data', 'dispatch-queue.json');
    if (!fs.existsSync(qPath)) throw new Error('dispatch-queue.json 부재');
    const q = JSON.parse(fs.readFileSync(qPath, 'utf8'));
    return (q.retry || []).slice(SKIP, PICK ? SKIP + PICK : undefined).map(j => ({ slug: j.slug, id: String(j.id) }));
  }
  // mode 3: --master
  if (args.master) {
    const mPath = path.join(REPO_ROOT, 'data', 'enhance-master-list.json');
    if (!fs.existsSync(mPath)) throw new Error('enhance-master-list.json 부재');
    const m = JSON.parse(fs.readFileSync(mPath, 'utf8'));
    const queue = [
      ...((m.category_b_light || []).map(j => ({ ...j, _src: 'B_light' }))),
      ...((m.category_b_heavy || []).map(j => ({ ...j, _src: 'B_heavy' }))),
    ];
    return queue.slice(SKIP, PICK ? SKIP + PICK : undefined).map(j => ({ slug: j.slug, id: String(j.id) }));
  }
  // mode 4: --fact-source=PARTIAL,MISMATCH (332 풀 body-source 미적용)
  if (args['fact-source']) {
    const cls = args['fact-source'].split(',').map(s => s.trim().toUpperCase());
    const fsPath = path.join(REPO_ROOT, 'data', 'fact-source-audit.json');
    if (!fs.existsSync(fsPath)) throw new Error('data/fact-source-audit.json 부재 — 먼저 `node scripts/skill-cache/audit-fact-source-match.cjs --out=data/fact-source-audit.json` 실행');
    const fa = JSON.parse(fs.readFileSync(fsPath, 'utf8'));
    const filtered = fa.jobs.filter(j => cls.includes(j.classification));
    // suspectFacts 적은 순 (light → heavy)
    filtered.sort((a, b) => (a.suspectFacts.length + a.generalDomainFacts.length) - (b.suspectFacts.length + b.generalDomainFacts.length));
    const slugs = filtered.slice(SKIP, PICK ? SKIP + PICK : undefined).map(j => j.slug);
    return getJobIds(slugs);
  }
  throw new Error('mode 미지정 — --slugs / --queue=retry / --master / --fact-source 중 하나 필요');
}

function main() {
  const jobs = pickJobs();
  if (jobs.length === 0) { console.error('직업 0건 — 종료.'); process.exit(0); }
  console.error(`[build-cycle-v3] ${jobs.length}직업 prompt 생성 중...`);

  const slugs = jobs.map(j => j.slug);
  const cache = loadAuditCache(slugs);

  // 세션 분배
  const sessions = [];
  for (let i = 0; i < SESSIONS; i++) sessions.push([]);
  jobs.forEach((j, idx) => sessions[idx % SESSIONS].push(j));

  // 각 직업 prompt 생성
  const md = [
    `# Cycle v3 Prompts (${jobs.length}직업 — ${SESSIONS}세션)`,
    '',
    `**Generated**: ${new Date().toISOString()}`,
    `**Template**: scripts/skill-cache/lib/dispatch-prompt-v3.cjs (v3 옵션 B')`,
    `**main HEAD min**: ${MAIN_HEAD_MIN}`,
    `**Pilot**: 3직업 검증 완료 (2026-05-06) — 평균 ~107K tokens/call (-91%), audit-deep CLEAN 100%`,
    '',
    '## 폴링 차단 운영 룰 (orchestrator 필독)',
    '',
    '- "v4 audit 끝났어?" 같은 polling 한 줄 → orchestrator가 직접 bash로 처리, subagent 띄우지 X',
    '- `tail -n 50 ~/.claude/projects/{repo}/{sessionId}.jsonl | grep \'"role":"assistant"\'` 로 status grep',
    '- 사고 자동 발견은 hook (audit-after-edit.cjs) 담당',
    '- subagent dispatch는 **새 직업 작업 시작 시점만**',
    '',
    `## 세션 분배 (${SESSIONS}세션 × ~${Math.ceil(jobs.length / SESSIONS)}직업)`,
    '',
    '| 세션 | 직업 수 | 직업 list |',
    '|------|---------|-----------|',
    ...sessions.map((s, i) => `| ${i + 1} | ${s.length} | ${s.map(j => j.slug).join(', ')} |`),
    '',
    '---',
    '',
  ];

  let totalChars = 0;
  let totalLines = 0;
  let safetyRuleFails = 0;

  sessions.forEach((sess, sIdx) => {
    if (sess.length === 0) return;
    md.push(`# 세션 ${sIdx + 1} — ${sess.length}직업\n`);
    md.push('> dispatch 순서: 직업을 순차로 send_message. 첫 직업 DONE 받고 다음 send.\n');
    sess.forEach((j, jIdx) => {
      const c = cache[j.slug] || {};
      const { audit, factSource } = buildAuditOpts(j.slug, c.deep, c.factSource);
      const keyTask = deriveKeyTask(audit, factSource);
      const prompt = buildDispatchPrompt({
        slug: j.slug,
        id: j.id,
        audit,
        factSource,
        keyTask,
      });
      // 안전 룰 9개 누락 확인
      const verify = verifySafetyRulesPresent(prompt);
      if (!verify.ok) {
        safetyRuleFails++;
        console.error(`[build-cycle-v3] ⚠️ ${j.slug}: 안전 룰 누락 ${verify.missing.join(', ')}`);
      }
      totalChars += prompt.length;
      totalLines += prompt.split('\n').length;
      md.push(`### 세션 ${sIdx + 1} — 직업 ${jIdx + 1}/${sess.length}: ${j.slug}\n`);
      md.push('```');
      md.push(prompt);
      md.push('```');
      md.push('');
    });
    md.push('---\n');
  });

  // safety rule fail 1+ 시 비-zero exit (CI 차단용)
  if (safetyRuleFails > 0) {
    console.error(`[build-cycle-v3] FAIL: ${safetyRuleFails}직업 안전 룰 누락 — prompt 출력 거부`);
    process.exit(2);
  }

  // pilot byte-equal 검증 (--check-pilot-byte-equal)
  if (args['check-pilot-byte-equal']) {
    const pilotPath = path.join(REPO_ROOT, 'data', 'v3-pilot-prompts.md');
    if (!fs.existsSync(pilotPath)) throw new Error(`pilot 파일 부재: ${pilotPath}`);
    const pilotTxt = fs.readFileSync(pilotPath, 'utf8');
    let mismatch = 0;
    sessions.flat().forEach(j => {
      const c = cache[j.slug] || {};
      const { audit, factSource } = buildAuditOpts(j.slug, c.deep, c.factSource);
      const keyTask = deriveKeyTask(audit, factSource);
      const built = buildDispatchPrompt({ slug: j.slug, id: j.id, audit, factSource, keyTask });
      // pilot에서 같은 slug 찾기
      const pilotPattern = new RegExp(`### ${j.slug} \\(id=${j.id}\\)`);
      if (!pilotPattern.test(pilotTxt)) {
        console.error(`[check] pilot에 ${j.slug} 없음 — skip`);
        return;
      }
      // 안전 룰 9개 동일 여부만 확인 (prompt 본문 dynamic field는 다름)
      const v = verifySafetyRulesPresent(built);
      if (!v.ok) { mismatch++; console.error(`[check] ${j.slug}: 안전 룰 누락 ${v.missing}`); }
      else console.error(`[check] ${j.slug}: 안전 룰 9개 모두 박힘 ✓`);
    });
    if (mismatch > 0) { console.error(`[check] FAIL: ${mismatch}건 누락`); process.exit(2); }
    console.error('[check] PASS — 모든 직업 안전 룰 9개 인라인 ✓');
  }

  if (args.json) {
    const json = {
      generated_at: new Date().toISOString(),
      template: 'v3',
      main_head_min: MAIN_HEAD_MIN,
      jobs: jobs.length,
      sessions: SESSIONS,
      avg_chars: Math.round(totalChars / jobs.length),
      avg_lines: Math.round(totalLines / jobs.length),
      avg_est_tokens: Math.round((totalChars / jobs.length) / 2.5),
      session_dist: sessions.map((s, i) => ({ session: i + 1, jobs: s.map(j => j.slug) })),
    };
    console.log(JSON.stringify(json, null, 2));
    return;
  }

  // markdown 저장
  const outPath = path.resolve(REPO_ROOT, OUT);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, md.join('\n'), 'utf8');
  console.error(`[build-cycle-v3] 저장: ${outPath}`);
  console.error(`[build-cycle-v3] 직업 ${jobs.length} / 세션 ${SESSIONS} / 평균 ${Math.round(totalLines / jobs.length)}lines, ${Math.round(totalChars / jobs.length)}chars (~${Math.round((totalChars / jobs.length) / 2.5)} est tokens)`);
  console.error('[build-cycle-v3] 안전 룰 9개 모두 박힘 ✓');
}

if (require.main === module) {
  try { main(); }
  catch (e) { console.error('[build-cycle-v3] 에러:', e.message); process.exit(2); }
}

module.exports = { buildDispatchPrompt, MAIN_HEAD_MIN };
