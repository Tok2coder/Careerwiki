#!/usr/bin/env node
/*
 * major-verify-cycle.cjs — 전공(major) cycle 일괄 기계 검증 게이트
 *   (master-verify-cycle.cjs 포크 — 설계: data/cycle/major_cycle_design_v1.md §1·§2·§5)
 *
 * ⚠️ 이름 주의: cycle-script-block.cjs hook 이 /^_?cycle.../ 패턴으로 "cycle"로 시작하는
 *   파일명을 차단함. "major-" 접두 필수 (master-verify-cycle.cjs와 동일 관례).
 *   이 스크립트는 자작 enhance dispatcher가 아니라 cycle 결과를 기계 검증하는 read-only 게이트.
 *   POST/edit 절대 X — DB SELECT + prod GET + URL fetch만.
 *
 * 사용:
 *   node scripts/major-verify-cycle.cjs --cycle=M0   (또는 --cycle=0)
 *   node scripts/major-verify-cycle.cjs --slugs-file=scripts/skill-cache/_tmp_slugs.txt
 *   node scripts/major-verify-cycle.cjs --cycle=M1 --jaccard "slug1:slug2,slug3:slug4"
 *
 * 전공별 검사 (직업판 a~e 구조 유지 + f 신설):
 *   a. latest content rev(NOT LIKE '%[sidebar-fill]%')가 [major-data-master] 마커
 *      (legacy 마커 없음) + user_contributed_json NOT NULL
 *   b. totalEntries ≥ 12
 *   c. distinct 출처 URL ≥ 8
 *   d. _sources URL 생존 (url-liveness.cjs 공유 — dead=FAIL, unverified=WARN)
 *   e. origin 보존: merged_profile_json.sources / .sourceIds 존재
 *   f. 보호영역 비접촉: user_contributed_json에 chartData/employmentRate/
 *      salaryAfterGraduation/universities/recruitmentStatus 키 존재 시 FAIL (설계 §2 보호영역)
 *
 * exit code: FAIL > 0 → 1, else 0
 */

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..');
const { checkUrls } = require(path.join(REPO_ROOT, 'scripts', 'skill-cache', 'url-liveness.cjs'));

const MARKER_RE = /\[major-data-master\]/;
const TOTAL_ENTRIES_MIN = 12; // 설계 §2 게이트 수치 (v1 잠정 — M0 후 확정)
const DISTINCT_MIN = 8;
// f. 보호영역 (전공판 sal — UCJ에 이 키가 있으면 접촉 사고)
const PROTECTED_UCJ_KEYS = ['chartData', 'employmentRate', 'salaryAfterGraduation', 'universities', 'recruitmentStatus'];

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
function loadMajors() {
  const cycleRaw = getArg('cycle');
  const slugsFile = getArg('slugs-file');
  const majors = [];
  if (cycleRaw) {
    // 명단 소스: data/cycle/major_list_M0_M25.jsonl — 각 줄 JSON object, cycle 필드로 필터
    const listPath = path.join(REPO_ROOT, 'data', 'cycle', 'major_list_M0_M25.jsonl');
    if (!fs.existsSync(listPath)) {
      console.error(`[error] ${path.relative(REPO_ROOT, listPath)} 없음 — 명단 생성(B6) 전이면 --slugs-file 모드 사용`);
      process.exit(2);
    }
    // "M0" / "m0" / "0" 모두 허용 → 정규화 "M{n}"
    const want = `M${String(cycleRaw).replace(/^[Mm]/, '').trim()}`;
    const txt = fs.readFileSync(listPath, 'utf8');
    for (const line of txt.split('\n').map((l) => l.trim()).filter(Boolean)) {
      let o;
      try { o = JSON.parse(line); } catch (e) { continue; }
      const lineCycle = o.cycle ?? o.m ?? o.mcycle;
      if (lineCycle == null) continue;
      const norm = `M${String(lineCycle).replace(/^[Mm]/, '').trim()}`;
      if (norm !== want) continue;
      // 실제 형식: {"cycle":"M0","batch":1,"jobs":[{id,slug,name},...]} (배치당 1줄, 중첩 배열)
      const entries = Array.isArray(o.jobs) ? o.jobs : [o];
      for (const e of entries) {
        const slug = e.slug || e.name;
        if (!slug) continue;
        majors.push({ name: e.name || slug, id: e.id != null ? String(e.id) : null, slug });
      }
    }
    if (majors.length === 0) {
      console.error(`[error] major_list_M0_M25.jsonl에 cycle=${want} 항목 없음`);
      process.exit(2);
    }
  } else if (slugsFile) {
    // 각 줄: "slug" 또는 "name | id=N | slug=X" 또는 "id=N slug=X"
    const txt = fs.readFileSync(path.resolve(REPO_ROOT, slugsFile), 'utf8');
    for (const line of txt.split('\n').map((l) => l.trim()).filter(Boolean)) {
      const idM = line.match(/id=([^\s|]+)/);
      const slugM = line.match(/slug=(.+?)\s*$/);
      if (slugM || idM) {
        majors.push({ name: line.split('|')[0].trim(), id: idM ? idM[1] : null, slug: slugM ? slugM[1].trim() : line.split('|')[0].trim() });
      } else {
        majors.push({ name: line, id: null, slug: line });
      }
    }
  } else {
    console.error('사용: node scripts/major-verify-cycle.cjs --cycle=M0 | --slugs-file=path [--jaccard "a:b,c:d"]');
    process.exit(2);
  }
  return majors;
}

// ─── prod /edit-data fetch (major — _sources 포함, 한글 slug는 encodeURIComponent) ───
async function fetchEditData(slug) {
  const url = `https://careerwiki.org/api/major/${encodeURIComponent(slug)}/edit-data`;
  try {
    const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
    if (r.status !== 200) return { error: `HTTP ${r.status}` };
    const j = await r.json();
    if (!j.success) return { error: j.error || 'API failure' };
    return { data: j.data, entityId: j.entityId };
  } catch (e) {
    return { error: e.message };
  }
}

// ─── _sources 통계: totalEntries, distinct URL, all URL ───
function sourceStats(sources) {
  let totalEntries = 0;
  const urls = [];
  for (const [field, arr] of Object.entries(sources || {})) {
    if (!Array.isArray(arr)) continue;
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

// 두 전공의 신규 prose 영역(whatStudy/howPrepare/jobProspect) 결합 텍스트 비교
function proseConcat(data) {
  const fields = ['whatStudy', 'howPrepare', 'jobProspect'];
  return fields.map((k) => {
    const v = data ? data[k] : '';
    return Array.isArray(v) ? v.join(' ') : String(v || '');
  }).join(' ');
}

// ─── DB: 전공별 마커/UCJ/origin/보호영역 일괄 조회 ───
// ⚠️ id별 개별 쿼리(전공당 wrangler 2회 순차 spawn) 금지 — 2회 일괄 배치 (직업판 2026-06-10 사고 승계).
function fetchDbInfo(ids) {
  const valid = ids.filter(Boolean);
  const info = {};
  if (!valid.length) return info;
  const idList = valid.map((id) => `'${String(id).replace(/'/g, "''")}'`).join(',');
  console.log(`[db] 일괄 조회 중 (${valid.length} id, wrangler 2회 — 약 1분)...`);
  // a) latest content rev 마커 (일괄)
  const revs = d1Query(
    `WITH latest AS (SELECT entity_id, MAX(id) AS max_id FROM page_revisions WHERE entity_type='major' AND entity_id IN (${idList}) AND change_summary NOT LIKE '%[sidebar-fill]%' GROUP BY entity_id) SELECT pr.entity_id AS eid, pr.change_summary AS cs FROM page_revisions pr JOIN latest l ON l.max_id = pr.id`
  );
  const csById = {};
  for (const r of revs) csById[String(r.eid)] = String(r.cs || '');
  // a) UCJ NOT NULL + e) origin + f) 보호영역 키 존재 (일괄)
  //    json_type()은 키가 JSON null이어도 'null'을 반환 → 키 "존재" 자체를 검출
  const protCols = PROTECTED_UCJ_KEYS
    .map((k, i) => `(json_type(user_contributed_json,'$.${k}') IS NOT NULL) AS prot_${i}`)
    .join(', ');
  const majorRows = d1Query(
    `SELECT id, (user_contributed_json IS NOT NULL) AS has_ucj, (json_extract(merged_profile_json,'$.sources') IS NOT NULL) AS has_src, (json_extract(merged_profile_json,'$.sourceIds') IS NOT NULL) AS has_srcids, ${protCols} FROM majors WHERE id IN (${idList})`
  );
  const rowById = {};
  for (const r of majorRows) rowById[String(r.id)] = r;
  for (const id of valid) {
    const csLatest = csById[id] || '';
    const r0 = rowById[id] || {};
    const touched = PROTECTED_UCJ_KEYS.filter((k, i) => Number(r0[`prot_${i}`]) === 1);
    info[id] = {
      markerOk: MARKER_RE.test(csLatest),
      csLatest,
      hasUcj: Number(r0.has_ucj) === 1,
      hasOriginSources: Number(r0.has_src) === 1,
      hasOriginSourceIds: Number(r0.has_srcids) === 1,
      protectedTouched: touched,
    };
  }
  console.log(`[db] 완료 — rev ${revs.length}건 / major ${majorRows.length}건 매칭. 전공별 검사 시작 (1건당 20~40초)\n`);
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
  const majors = loadMajors();
  console.log(`[major-verify-cycle] 대상 ${majors.length} 전공\n`);

  const dbInfo = fetchDbInfo(majors.map((m) => m.id));

  const rows = [];
  for (const major of majors) {
    const reasons = [];
    const warns = [];
    const db = (major.id && dbInfo[major.id]) || {};

    // DB checks (a, e, f)
    if (!major.id) { warns.push('id-unknown(DB검사 skip)'); }
    else {
      if (!db.markerOk) reasons.push('마커없음');
      if (!db.hasUcj) reasons.push('UCJ-NULL');
      if (!db.hasOriginSources && !db.hasOriginSourceIds) reasons.push('origin없음');
      else if (!db.hasOriginSources || !db.hasOriginSourceIds) warns.push('origin부분');
      if (db.protectedTouched && db.protectedTouched.length) {
        reasons.push(`보호영역접촉(${db.protectedTouched.join('/')})`);
      }
    }

    // prod /edit-data → sources/totalE/distinct + URL liveness (b, c, d)
    let totalE = 0, distinct = 0, pr0 = null;
    const ed = await fetchEditData(major.slug);
    if (ed.error) {
      reasons.push(`edit-data:${ed.error}`);
    } else {
      const stats = sourceStats(ed.data._sources || {});
      totalE = stats.totalEntries;
      distinct = stats.distinct;
      pr0 = ed.data;
      if (totalE < TOTAL_ENTRIES_MIN) reasons.push(`totalE=${totalE}<${TOTAL_ENTRIES_MIN}`);
      if (distinct < DISTINCT_MIN) reasons.push(`distinct=${distinct}<${DISTINCT_MIN}`);
      // d) URL 생존
      const live = await checkUrls(stats.urls);
      if (live.dead.length) reasons.push(`urlDead(${live.dead.length})`);
      if (live.unverified.length) warns.push(`urlUnverified(${live.unverified.length})`);
      major._urlDead = live.dead;
      major._urlUnverified = live.unverified;
    }

    major._totalE = totalE;
    major._distinct = distinct;
    major._prose = pr0 ? proseConcat(pr0) : '';
    const verdict = reasons.length ? 'FAIL' : (warns.length ? 'WARN' : 'PASS');
    rows.push({ major, verdict, reasons, warns, markerOk: db.markerOk });

    const markerCol = major.id ? (db.markerOk ? 'OK' : 'NO') : '?';
    console.log(
      `${verdict.padEnd(4)} ${major.slug.padEnd(24)} | totalE=${String(totalE).padStart(2)} | distinct=${String(distinct).padStart(2)} | marker=${markerCol} | ${reasons.concat(warns.map((w) => 'WARN:' + w)).join(', ') || 'clean'}`
    );
    (major._urlDead || []).forEach((u) => console.log(`        [urlDead] ${u.reason}: ${u.url}`));
    (major._urlUnverified || []).forEach((u) => console.log(`        [urlUnverified] ${u.reason}: ${u.url}`));
  }

  // ─── jaccard pair 비교 ───
  const pairs = parseJaccardPairs();
  let jaccardFail = 0;
  if (pairs.length) {
    console.log(`\n=== Jaccard 4-gram (신규 prose, ≥0.5 FAIL) ===`);
    const bySlug = Object.fromEntries(rows.map((r) => [r.major.slug, r.major._prose]));
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
  if (fail.length) console.log(`FAIL: ${fail.map((r) => `${r.major.slug}(${r.reasons.join('/')})`).join(', ')}`);
  if (warn.length) console.log(`WARN: ${warn.map((r) => `${r.major.slug}(${r.warns.join('/')})`).join(', ')}`);
  if (jaccardFail) console.log(`JACCARD FAIL: ${jaccardFail} pair ≥0.5`);

  // ⚠️ process.exit() 사용 금지 — Windows에서 wrangler spawnSync 잔존 libuv 핸들과 충돌해
  //    "Assertion failed: !(handle->flags & UV_HANDLE_CLOSING)" 크래시(exit 127)로 게이트 exit code가 깨짐 (2026-07-02 실측).
  //    exitCode 지정 후 자연 종료.
  process.exitCode = fail.length > 0 || jaccardFail > 0 ? 1 : 0;
})();
