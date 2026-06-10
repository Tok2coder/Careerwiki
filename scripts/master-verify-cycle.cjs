#!/usr/bin/env node
/*
 * master-verify-cycle.cjs — cycle 일괄 기계 검증 게이트 (R41 사후 신설)
 *
 * ⚠️ 이름 주의: cycle-script-block.cjs hook 이 /^_?cycle.../ 패턴으로 "cycle"로 시작하는
 *   파일명을 차단함. "master-" 접두 필수 (master-cycle-helper.cjs와 동일 관례).
 *   이 스크립트는 자작 enhance dispatcher가 아니라 cycle 결과를 기계 검증하는 read-only 게이트.
 *   POST/edit 절대 X — DB SELECT + prod GET + URL fetch만.
 *
 * 배경 (R41 실사고):
 *   ① broken URL 11건이 CLEAN 통과 → URL 생존 미검사
 *   ② opus 세션이 totalE=18(<19)을 임의 PASS → 기계 검증 부재
 *   ③ 배치 보고 형식 위반 다발
 *
 * 사용:
 *   node scripts/master-verify-cycle.cjs --cycle=41
 *   node scripts/master-verify-cycle.cjs --slugs-file=scripts/skill-cache/_tmp_slugs.txt
 *   node scripts/master-verify-cycle.cjs --cycle=41 --jaccard "slug1:slug2,slug3:slug4"
 *
 * 직업별 검사:
 *   a. latest content rev(NOT LIKE '%[sidebar-fill]%')가 [job-data-master] 마커 + UCJ NOT NULL
 *   b. totalEntries(sal 제외) ≥ 19
 *   c. distinct 출처 URL 수 (정보 표기)
 *   d. _sources URL 생존 (url-liveness.cjs 공유 — dead=FAIL, unverified=WARN)
 *   e. origin 보존: merged_profile_json.sources / .sourceIds 존재
 *
 * exit code: FAIL > 0 → 1, else 0
 */

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..');
const { checkUrls } = require(path.join(REPO_ROOT, 'scripts', 'skill-cache', 'url-liveness.cjs'));

const SAL_PROTECTED_FIELDS = ['overviewSalary.sal'];
const TOTAL_ENTRIES_MIN = 19;

// ─── arg parse ───
const argv = process.argv.slice(2);
const getArg = (name) => {
  const a = argv.find((x) => x.startsWith(`--${name}=`));
  if (a) return a.split('=').slice(1).join('=');
  // 공백 분리형 (--jaccard "...") 지원
  const i = argv.indexOf(`--${name}`);
  if (i >= 0 && argv[i + 1] && !argv[i + 1].startsWith('--')) return argv[i + 1];
  return null;
};

// ─── wrangler D1 plain stdout 파서 (--json 플래그 금지 — Windows 호환 사고 이력) ───
function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const r = spawnSync(`npx wrangler d1 execute careerwiki-kr --remote --command "${escaped}"`, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 64 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  const out = (r.stdout || '').trim();
  const start = out.indexOf('[');
  if (start < 0) return [];
  // bracket matching (문자열 내 [] 무시)
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
  try {
    return JSON.parse(out.slice(start, end))[0]?.results || [];
  } catch (e) {
    return [];
  }
}

// ─── slug/id 명단 로드 ───
function loadJobs() {
  const cycle = getArg('cycle');
  const slugsFile = getArg('slugs-file');
  const jobs = [];
  if (cycle) {
    // data/cycle/R{N}_B*.txt — 각 줄 "name | id=N | slug=X"
    const files = fs.readdirSync(path.join(REPO_ROOT, 'data', 'cycle'))
      .filter((f) => new RegExp(`^R${cycle}_B\\d+\\.txt$`).test(f))
      .sort();
    if (files.length === 0) {
      console.error(`[error] data/cycle/R${cycle}_B*.txt 없음`);
      process.exit(2);
    }
    for (const fn of files) {
      const txt = fs.readFileSync(path.join(REPO_ROOT, 'data', 'cycle', fn), 'utf8');
      for (const line of txt.split('\n').map((l) => l.trim()).filter(Boolean)) {
        const idM = line.match(/id=([0-9]+)/);
        const slugM = line.match(/slug=(.+?)\s*$/);
        const nameM = line.split('|')[0].trim();
        jobs.push({ name: nameM, id: idM ? idM[1] : null, slug: slugM ? slugM[1].trim() : nameM });
      }
    }
  } else if (slugsFile) {
    // 각 줄: "slug" 또는 "name | id=N | slug=X" 또는 "id=N slug=X"
    const txt = fs.readFileSync(path.resolve(REPO_ROOT, slugsFile), 'utf8');
    for (const line of txt.split('\n').map((l) => l.trim()).filter(Boolean)) {
      const idM = line.match(/id=([0-9]+)/);
      const slugM = line.match(/slug=(.+?)\s*$/);
      if (slugM || idM) {
        jobs.push({ name: line.split('|')[0].trim(), id: idM ? idM[1] : null, slug: slugM ? slugM[1].trim() : line.split('|')[0].trim() });
      } else {
        jobs.push({ name: line, id: null, slug: line });
      }
    }
  } else {
    console.error('사용: node scripts/master-verify-cycle.cjs --cycle=N | --slugs-file=path [--jaccard "a:b,c:d"]');
    process.exit(2);
  }
  return jobs;
}

// ─── prod /edit-data fetch (sources + proseRaw) ───
async function fetchEditData(slug) {
  const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
  try {
    const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
    if (r.status !== 200) return { error: `HTTP ${r.status}` };
    const j = await r.json();
    if (!j.success) return { error: j.error || 'API failure' };
    return { data: j.data };
  } catch (e) {
    return { error: e.message };
  }
}

// ─── _sources 통계: totalEntries(sal 제외), distinct URL, all URL ───
function sourceStats(sources) {
  let totalEntries = 0;
  const urls = [];
  for (const [field, arr] of Object.entries(sources || {})) {
    if (!Array.isArray(arr)) continue;
    if (SAL_PROTECTED_FIELDS.includes(field)) continue; // sal 제외
    for (const src of arr) {
      if (!src || typeof src !== 'object') continue;
      totalEntries++;
      if (src.url && typeof src.url === 'string') urls.push(src.url);
    }
  }
  return { totalEntries, distinct: new Set(urls).size, urls };
}

// ─── 4-gram Jaccard (prose 표절/중복 검출) ───
function ngrams(text, n = 4) {
  const norm = String(text || '').replace(/\s+/g, '').toLowerCase();
  const set = new Set();
  for (let i = 0; i + n <= norm.length; i++) set.add(norm.slice(i, i + n));
  return set;
}
function jaccard(a, b) {
  const A = ngrams(a), B = ngrams(b);
  if (A.size === 0 || B.size === 0) return 0;
  let inter = 0;
  for (const g of A) if (B.has(g)) inter++;
  return inter / (A.size + B.size - inter);
}

// 두 직업의 신규 prose 영역(_proseRaw) 결합 텍스트 비교
function proseConcat(data) {
  const pr = (data && data._proseRaw) || {};
  return Object.values(pr).map((v) => (Array.isArray(v) ? v.join(' ') : String(v || ''))).join(' ');
}

// ─── DB: 직업별 마커/UCJ/origin 일괄 조회 ───
function fetchDbInfo(ids) {
  const info = {};
  for (const id of ids) {
    if (!id) continue;
    // a) latest content rev 마커 + UCJ
    const rev = d1Query(
      `SELECT change_summary AS cs FROM page_revisions WHERE entity_type='job' AND entity_id='${id}' AND change_summary NOT LIKE '%[sidebar-fill]%' ORDER BY id DESC LIMIT 1`
    );
    const csLatest = rev[0] ? String(rev[0].cs || '') : '';
    // b) UCJ NOT NULL + e) origin (merged_profile_json.sources/sourceIds)
    const job = d1Query(
      `SELECT (user_contributed_json IS NOT NULL) AS has_ucj, (json_extract(merged_profile_json,'$.sources') IS NOT NULL) AS has_src, (json_extract(merged_profile_json,'$.sourceIds') IS NOT NULL) AS has_srcids FROM jobs WHERE id='${id}'`
    );
    const j0 = job[0] || {};
    info[id] = {
      markerOk: /\[job-data-master\]/.test(csLatest),
      csLatest,
      hasUcj: Number(j0.has_ucj) === 1,
      hasOriginSources: Number(j0.has_src) === 1,
      hasOriginSourceIds: Number(j0.has_srcids) === 1,
    };
  }
  return info;
}

// ─── jaccard pair 파싱 ───
function parseJaccardPairs() {
  const raw = getArg('jaccard');
  if (!raw) return [];
  return raw.split(',').map((p) => {
    const [a, b] = p.split(':').map((s) => s.trim());
    return { a, b };
  }).filter((p) => p.a && p.b);
}

(async () => {
  const jobs = loadJobs();
  console.log(`[master-verify-cycle] 대상 ${jobs.length} 직업\n`);

  const dbInfo = fetchDbInfo(jobs.map((j) => j.id));

  const rows = [];
  for (const job of jobs) {
    const reasons = [];
    const warns = [];
    const db = (job.id && dbInfo[job.id]) || {};

    // DB checks (a, b-partial, e)
    if (!job.id) { warns.push('id-unknown(DB검사 skip)'); }
    else {
      if (!db.markerOk) reasons.push('마커없음');
      if (!db.hasUcj) reasons.push('UCJ-NULL');
      if (!db.hasOriginSources && !db.hasOriginSourceIds) reasons.push('origin없음');
      else if (!db.hasOriginSources || !db.hasOriginSourceIds) warns.push('origin부분');
    }

    // prod /edit-data → sources/totalE/distinct + URL liveness (b, c, d)
    let totalE = 0, distinct = 0, pr0 = null;
    const ed = await fetchEditData(job.slug);
    if (ed.error) {
      reasons.push(`edit-data:${ed.error}`);
    } else {
      const stats = sourceStats(ed.data._sources || {});
      totalE = stats.totalEntries;
      distinct = stats.distinct;
      pr0 = ed.data;
      if (totalE < TOTAL_ENTRIES_MIN) reasons.push(`totalE=${totalE}<${TOTAL_ENTRIES_MIN}`);
      // d) URL 생존
      const live = await checkUrls(stats.urls);
      if (live.dead.length) reasons.push(`urlDead(${live.dead.length})`);
      if (live.unverified.length) warns.push(`urlUnverified(${live.unverified.length})`);
      job._urlDead = live.dead;
      job._urlUnverified = live.unverified;
    }

    job._totalE = totalE;
    job._distinct = distinct;
    job._prose = pr0 ? proseConcat(pr0) : '';
    const verdict = reasons.length ? 'FAIL' : (warns.length ? 'WARN' : 'PASS');
    rows.push({ job, verdict, reasons, warns, markerOk: db.markerOk });

    const markerCol = job.id ? (db.markerOk ? 'OK' : 'NO') : '?';
    console.log(
      `${verdict.padEnd(4)} ${job.slug.padEnd(24)} | totalE=${String(totalE).padStart(2)} | distinct=${String(distinct).padStart(2)} | marker=${markerCol} | ${reasons.concat(warns.map((w) => 'WARN:' + w)).join(', ') || 'clean'}`
    );
    (job._urlDead || []).forEach((u) => console.log(`        [urlDead] ${u.reason}: ${u.url}`));
    (job._urlUnverified || []).forEach((u) => console.log(`        [urlUnverified] ${u.reason}: ${u.url}`));
  }

  // ─── jaccard pair 비교 ───
  const pairs = parseJaccardPairs();
  let jaccardFail = 0;
  if (pairs.length) {
    console.log(`\n=== Jaccard 4-gram (신규 prose, ≥0.5 FAIL) ===`);
    const bySlug = Object.fromEntries(rows.map((r) => [r.job.slug, r.job._prose]));
    for (const { a, b } of pairs) {
      const ta = bySlug[a] ?? null;
      const tb = bySlug[b] ?? null;
      if (ta == null || tb == null) {
        console.log(`?    ${a} : ${b} — 대상 명단에 없음 (prose 미수집)`);
        continue;
      }
      const sim = jaccard(ta, tb);
      const v = sim >= 0.5 ? 'FAIL' : 'ok';
      if (sim >= 0.5) jaccardFail++;
      console.log(`${v.padEnd(4)} ${a} : ${b} — ${(sim * 100).toFixed(1)}%`);
    }
  }

  // ─── 요약 ───
  const fail = rows.filter((r) => r.verdict === 'FAIL');
  const warn = rows.filter((r) => r.verdict === 'WARN');
  const pass = rows.filter((r) => r.verdict === 'PASS');
  console.log(`\n=== Summary: PASS ${pass.length}/${rows.length}${warn.length ? `, WARN ${warn.length}` : ''}${fail.length ? `, FAIL ${fail.length}` : ''} ===`);
  if (fail.length) console.log(`FAIL: ${fail.map((r) => `${r.job.slug}(${r.reasons.join('/')})`).join(', ')}`);
  if (warn.length) console.log(`WARN: ${warn.map((r) => `${r.job.slug}(${r.warns.join('/')})`).join(', ')}`);
  if (jaccardFail) console.log(`JACCARD FAIL: ${jaccardFail} pair ≥0.5`);

  process.exit(fail.length > 0 || jaccardFail > 0 ? 1 : 0);
})();
