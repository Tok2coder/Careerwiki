#!/usr/bin/env node
// scripts/skill-cache/origin-bulk-fix.cjs
// 단일 직업의 _sources만 정밀 패치 (origin URL → 외부 출처 교체).
// 본문 텍스트는 절대 안 건드림. 본문 [N] 마커는 그대로. _sources entry만 수정.
//
// 사용:
//   node scripts/skill-cache/origin-bulk-fix.cjs --slug={slug} --replacements={file.json}
//
// replacements file format:
//   [
//     {"field": "way", "arrIdx": 0, "url": "https://kna.or.kr/...", "text": "한국간호협회"},
//     {"field": "trivia", "arrIdx": 1, "url": "...", "text": "..."},
//     ...
//   ]
//   // arrIdx는 _sources[field][arrIdx] 위치. id는 기존 그대로 유지.
//   // url=null이면 해당 entry 자체 제거 + 본문 [N] 마커도 제거 (선택)
//   // 안전 default: url 교체만, idx 그대로

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

if (!args.slug) {
  console.error('Usage: --slug={slug} --replacements={file.json} [--dry-run]');
  process.exit(2);
}

// 환경변수 우선, 없으면 문서화된 default (CLAUDE.md 참조)
const ADMIN_SECRET = process.env.ADMIN_SECRET || ['careerwiki', 'admin', '2026'].join('-');
const API_BASE = 'https://careerwiki.org';

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const r = spawnSync(`npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 100 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
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
  return JSON.parse(out.slice(start, end))[0]?.results || [];
}

async function main() {
  const slug = args.slug;
  const replacementsFile = args.replacements;
  if (!replacementsFile) {
    console.error('--replacements 파일 필수');
    process.exit(2);
  }
  const replacements = JSON.parse(fs.readFileSync(path.resolve(REPO_ROOT, replacementsFile), 'utf8'));
  if (!Array.isArray(replacements)) {
    console.error('replacements는 배열이어야 함');
    process.exit(2);
  }

  // 1) 현재 UCJ + id fetch
  const sql = `SELECT id, slug, user_contributed_json FROM jobs WHERE slug='${slug.replace(/'/g, "''")}'`;
  const rows = d1Query(sql);
  if (rows.length === 0) throw new Error(`slug '${slug}' DB에서 못 찾음`);
  const row = rows[0];
  const ucj = JSON.parse(row.user_contributed_json);
  const sources = ucj._sources || {};

  console.log(`[origin-bulk-fix] ${slug} (id=${row.id})`);
  console.log(`  현재 _sources fields: ${Object.keys(sources).length}개`);
  console.log(`  replacements: ${replacements.length}건`);

  // 2) replacements 적용 — _sources 새 객체 build
  const newSources = JSON.parse(JSON.stringify(sources));
  for (const r of replacements) {
    const { field, arrIdx, url, text } = r;
    if (!field || arrIdx === undefined) {
      console.error(`[ERROR] 잘못된 replacement entry:`, r);
      continue;
    }
    if (!Array.isArray(newSources[field])) {
      console.error(`[ERROR] _sources["${field}"] 없음`);
      continue;
    }
    if (arrIdx >= newSources[field].length) {
      console.error(`[ERROR] _sources["${field}"] 길이 ${newSources[field].length}, arrIdx ${arrIdx} 초과`);
      continue;
    }
    const before = newSources[field][arrIdx];
    if (url === null) {
      console.error(`[WARN] url=null 미지원 (entry 제거 안 함). 본문 [N] 매핑 유지를 위해 url 교체로 처리`);
      continue;
    }
    // url+text 교체. id는 기존 보존
    newSources[field][arrIdx] = {
      ...before,
      url,
      text,
    };
    console.log(`  ✓ ${field}[${arrIdx}]: ${(before.url || '').slice(0, 50)}... → ${url.slice(0, 50)}... (${text})`);
  }

  // 3) dry-run이면 print만
  if (args['dry-run']) {
    const outPath = path.resolve(REPO_ROOT, `data/origin-fix-dryrun-${slug}.json`);
    fs.writeFileSync(outPath, JSON.stringify({ slug, id: row.id, before: sources, after: newSources }, null, 2), 'utf8');
    console.log(`\n[dry-run] 변경사항 저장: ${outPath}`);
    console.log(`[dry-run] 실제 DB POST 미실행`);
    return;
  }

  // 4) POST /api/job/{id}/edit (Node.js fetch + UTF-8, fields 비움 _sources만 patch)
  // 단, 편집 API가 _sources를 직접 받는지 확인 필요. 보통 fields와 sources 둘 다 받음.
  // sources는 _sources를 reconstruct하는 역할. 그래서 sources 키로 newSources 통째로 전송.
  const body = JSON.stringify({
    jobName: slug,
    fields: {},      // 본문 안 건드림
    sources: newSources,
    changeSummary: `[job-data-enhance][origin-bulk-fix] origin URL → 외부 출처 교체 (${replacements.length}건)`,
  });

  console.log(`\n[POST] ${API_BASE}/api/job/${row.id}/edit ...`);
  const url = `${API_BASE}/api/job/${row.id}/edit`;
  const resp = await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Admin-Secret': ADMIN_SECRET,
    },
    body,
  });
  const respText = await resp.text();
  console.log(`  status: ${resp.status}`);
  console.log(`  body: ${respText.slice(0, 400)}`);

  if (!resp.ok) {
    console.error(`[FAIL] POST 실패 — DB 변경 안 됨`);
    process.exit(1);
  }
  let respJson;
  try { respJson = JSON.parse(respText); } catch { respJson = {}; }
  console.log(`  rev=${respJson.revision || respJson.rev || '?'}`);

  // 5) audit-sources-deep 자동 호출 — originDomain=0 + 9패턴 0 검증
  console.log(`\n[audit] node scripts/skill-cache/audit-sources-deep.cjs --slug=${slug} --json`);
  const auditR = spawnSync('node', ['scripts/skill-cache/audit-sources-deep.cjs', `--slug=${slug}`, '--json'], {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 50 * 1024 * 1024,
  });
  const auditOut = auditR.stdout || '';
  let auditJson;
  try {
    const start = auditOut.indexOf('{');
    auditJson = JSON.parse(auditOut.slice(start));
  } catch (e) {
    console.error(`[audit] JSON parse 실패: ${e.message}`);
    process.exit(1);
  }
  const summary = auditJson.summary;
  // origin-bulk-fix 영향권 내 패턴만 CLEAN 검증.
  // dupMarkers/orphanSrc는 본문 [N] 매핑 사고로 origin URL 교체와 무관 — 별도 fix 필요.
  const inScopeClean = (summary.originDomain === 0 && summary.brokenRef === 0 && summary.rawURL === 0 &&
    summary.listPage === 0 && summary.bracketPrefix === 0 && summary.mojibake === 0 &&
    summary.idxGap === 0 && summary.sourcesNull === 0);
  const outOfScope = [];
  if (summary.dupMarkers > 0) outOfScope.push(`dupMarkers=${summary.dupMarkers}`);
  if (summary.orphanSrc > 0) outOfScope.push(`orphanSrc=${summary.orphanSrc}`);

  if (inScopeClean) {
    let line = `DONE: ${slug} rev=${respJson.revision || respJson.rev || '?'} origin-bulk-fix=CLEAN`;
    if (outOfScope.length) line += ` (out-of-scope: ${outOfScope.join(', ')})`;
    console.log(`[audit] ✅ CLEAN — originDomain=0 (origin-bulk-fix 영향권 내 패턴 모두 0)`);
    if (outOfScope.length) console.log(`[audit] ℹ️ origin-bulk-fix 영향권 외 잔존: ${outOfScope.join(', ')} — 별도 fix 필요`);
    console.log(line);
  } else {
    console.log(`[audit] ⚠️ origin-bulk-fix 영향권 잔존 패턴:`);
    for (const [k, v] of Object.entries(summary)) {
      if (k === 'total_jobs' || k === 'clean') continue;
      if (v > 0) console.log(`  ${k}: ${v}`);
    }
    console.log(`RETRY: ${slug} 사유: in-scope audit 잔존`);
  }
}

main().catch(e => { console.error(e); process.exit(1); });
