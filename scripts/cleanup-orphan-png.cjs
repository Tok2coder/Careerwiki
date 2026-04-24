#!/usr/bin/env node
'use strict';

/**
 * cleanup-orphan-png.cjs
 *
 * PNG → WebP 마이그레이션 이후 R2에 남은 orphan .png 파일 일괄 삭제.
 *
 * 배경:
 *   convert-png-to-webp.cjs가 DB의 image_url만 .webp로 갱신했고 R2의 .png 파일은
 *   그대로 두었음. 사용자에게는 보이지 않지만 약 1.6GB의 orphan이 남아 있음.
 *
 * 안전장치:
 *   1. DB에서 아직 .png를 참조하는 image_url이 있으면 FAIL (활성 이미지 삭제 방지)
 *   2. 서버 엔드포인트 /api/admin/image/delete-orphan 가 HEAD → DELETE 순으로
 *      존재 확인 후 삭제 (존재하지 않는 키는 notFound로 카운트)
 *   3. 한 번에 최대 1000개까지 배치 전송 (서버 제한)
 *
 * 사용법:
 *   node scripts/cleanup-orphan-png.cjs [옵션]
 *
 * 옵션:
 *   --dry-run       대상 목록 + 예상 삭제 개수만 출력 (실제 삭제 X)
 *   --test=N        N개만 시도 (검증용)
 *   --only=jobs     직업만
 *   --only=majors   전공만
 *   --batch=N       한 요청당 아이템 수 (기본 200, 최대 1000)
 *   --concurrency=N 동시 요청 수 (기본 3, 서버 부하 제한)
 */

const fs   = require('fs');
const path = require('path');
const { execSync, spawnSync } = require('child_process');

// ─────────────────────────────────────────────────────────────────────────────
// 설정
// ─────────────────────────────────────────────────────────────────────────────

const SITE_BASE  = 'https://careerwiki.org';
const DELETE_URL = `${SITE_BASE}/api/admin/image/delete-orphan`;
const DB_NAME    = 'careerwiki-kr';
const ROOT       = path.join(__dirname, '..');
const LOG_FILE   = path.join(__dirname, 'cleanup-orphan-png.log');
const REQUEST_TIMEOUT = 120_000;

// ─────────────────────────────────────────────────────────────────────────────
// CLI
// ─────────────────────────────────────────────────────────────────────────────

function parseArgs() {
  const args = process.argv.slice(2);
  const only = (args.find(a => a.startsWith('--only=')) || '').split('=')[1] || null;
  const testMatch = (args.find(a => a.startsWith('--test=')) || '').split('=')[1];
  const testCount = testMatch ? parseInt(testMatch, 10) : null;
  const batchMatch = (args.find(a => a.startsWith('--batch=')) || '').split('=')[1];
  const batch = batchMatch ? Math.min(parseInt(batchMatch, 10) || 200, 1000) : 200;
  const concMatch = (args.find(a => a.startsWith('--concurrency=')) || '').split('=')[1];
  const concurrency = concMatch ? parseInt(concMatch, 10) || 3 : 3;
  return {
    dryRun: args.includes('--dry-run'),
    testCount: (testCount && testCount > 0) ? testCount : null,
    onlyJobs: only === 'jobs',
    onlyMajors: only === 'majors',
    batch: Math.max(1, batch),
    concurrency: Math.max(1, concurrency),
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// dev.vars
// ─────────────────────────────────────────────────────────────────────────────

function loadDevVars() {
  const vars = {};
  const candidates = [
    path.join(ROOT, 'dev.vars'),
    path.join(ROOT, '.dev.vars'),
    path.join(ROOT, '..', '..', '..', 'dev.vars'),
    path.join(ROOT, '..', '..', '..', '.dev.vars'),
  ];
  const p = candidates.find(c => fs.existsSync(c));
  if (!p) return vars;
  for (const line of fs.readFileSync(p, 'utf8').split(/\r?\n/)) {
    const t = line.trim();
    if (!t || t.startsWith('#')) continue;
    const idx = t.indexOf('=');
    if (idx > 0) vars[t.slice(0, idx).trim()] = t.slice(idx + 1).trim();
  }
  return vars;
}

// ─────────────────────────────────────────────────────────────────────────────
// D1 쿼리 (convert 스크립트와 동일 — 단일 라인 SQL + stdout→파일 리다이렉트)
// ─────────────────────────────────────────────────────────────────────────────

function queryD1(sql) {
  const tag = `${Date.now()}-${Math.random().toString(36).slice(2, 8)}`;
  const tmpOut = path.join(__dirname, `.d1-tmp-${tag}.json`);
  const outFd = fs.openSync(tmpOut, 'w');
  try {
    const singleLine = sql.replace(/\s+/g, ' ').trim();
    const escapedSql = singleLine.replace(/"/g, '\\"');
    const cmdStr = `npx wrangler d1 execute ${DB_NAME} --remote --json --command "${escapedSql}"`;
    const result = spawnSync(cmdStr, {
      cwd: ROOT,
      stdio: ['ignore', outFd, 'pipe'],
      shell: true,
      windowsHide: true,
    });
    fs.closeSync(outFd);
    if (result.status !== 0) {
      const errMsg = (result.stderr?.toString('utf8') || '').slice(0, 400);
      throw new Error(`wrangler exit ${result.status}: ${errMsg}`);
    }
    const raw = fs.readFileSync(tmpOut, 'utf8');
    const startIdx = Math.min(
      ...['[', '{'].map(ch => {
        const i = raw.indexOf(ch);
        return i === -1 ? Infinity : i;
      })
    );
    if (!isFinite(startIdx)) throw new Error('wrangler 출력에 JSON 시작 없음');
    const parsed = JSON.parse(raw.slice(startIdx));
    return (parsed?.[0]?.results) || [];
  } catch (err) {
    try { fs.closeSync(outFd); } catch {}
    throw new Error(`D1 쿼리 실패: ${err.message || err}`);
  } finally {
    try { if (fs.existsSync(tmpOut)) fs.unlinkSync(tmpOut); } catch {}
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 로그 (UTF-8 BOM)
// ─────────────────────────────────────────────────────────────────────────────

function ensureLogBom() {
  try {
    if (!fs.existsSync(LOG_FILE) || fs.statSync(LOG_FILE).size === 0) {
      fs.writeFileSync(LOG_FILE, '\uFEFF', 'utf8');
    }
  } catch {}
}

function appendLog(line) {
  try {
    const ts = new Date().toISOString().replace('T', ' ').slice(0, 19);
    fs.appendFileSync(LOG_FILE, `[${ts}] ${line}\n`, 'utf8');
  } catch {}
}

// ─────────────────────────────────────────────────────────────────────────────
// HTTP
// ─────────────────────────────────────────────────────────────────────────────

async function fetchJSON(url, opts, timeoutMs) {
  const ctrl = new AbortController();
  const timer = setTimeout(() => ctrl.abort(), timeoutMs);
  try {
    const res = await fetch(url, { ...opts, signal: ctrl.signal });
    const text = await res.text().catch(() => '');
    let body;
    try { body = text ? JSON.parse(text) : {}; }
    catch { body = { success: false, error: text.slice(0, 200) || `HTTP ${res.status}` }; }
    if (!res.ok) throw new Error(body?.error || `HTTP ${res.status} ${res.statusText}`);
    if (body?.success === false) throw new Error(body?.error || `HTTP ${res.status}`);
    return body;
  } catch (err) {
    if (err.name === 'AbortError') throw new Error(`timeout after ${timeoutMs}ms`);
    throw err;
  } finally {
    clearTimeout(timer);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Chunk 유틸
// ─────────────────────────────────────────────────────────────────────────────

function chunk(arr, size) {
  const out = [];
  for (let i = 0; i < arr.length; i += size) out.push(arr.slice(i, i + size));
  return out;
}

// ─────────────────────────────────────────────────────────────────────────────
// 메인
// ─────────────────────────────────────────────────────────────────────────────

async function main() {
  const opts = parseArgs();
  const devVars = loadDevVars();
  const adminSecret = process.env.ADMIN_SECRET || devVars.ADMIN_SECRET;

  if (!opts.dryRun && !adminSecret) {
    console.error('❌ ADMIN_SECRET 없음. dev.vars 또는 환경변수로 설정하세요.');
    process.exit(1);
  }

  ensureLogBom();

  console.log('═'.repeat(64));
  console.log('  R2 Orphan PNG 일괄 삭제');
  console.log(`  모드: ${opts.dryRun ? 'DRY-RUN' : (opts.testCount ? `TEST-${opts.testCount}개` : '실제 삭제')}`);
  console.log(`  배치 크기: ${opts.batch} / 동시 요청: ${opts.concurrency}`);
  console.log('═'.repeat(64));

  // ── 1. 안전 검증: DB에 .png 참조 남아있는지 확인 ────────────────────
  console.log('\n[안전 검증] DB image_url에 .png 참조 확인 중...');
  const pngRefs = queryD1(
    "SELECT 'jobs' AS t, COUNT(*) AS c FROM jobs WHERE image_url LIKE '%.png%' AND is_active = 1 UNION ALL SELECT 'majors', COUNT(*) FROM majors WHERE image_url LIKE '%.png%' AND is_active = 1"
  );
  const totalPngRefs = pngRefs.reduce((a, r) => a + (r.c || 0), 0);
  if (totalPngRefs > 0) {
    console.error(`\n❌ DB에 활성 .png 참조 ${totalPngRefs}개 발견 — 삭제 중단.`);
    console.error('   convert-png-to-webp.cjs를 먼저 실행해서 전부 .webp로 전환하세요.');
    process.exit(1);
  }
  console.log('  ✓ DB에 활성 .png 참조 없음 — 안전하게 삭제 가능\n');

  // ── 2. 대상 수집: 모든 활성 slug (전부 시도, 서버가 존재 여부 확인) ───
  //    원래 PNG였던 것만 보내고 싶지만, DB에서는 이미 .webp로 바뀌어
  //    과거 PNG 여부를 알 수 없음. 서버측 HEAD로 필터링하도록 전체 전송.
  //    존재하지 않는 키는 notFound로 카운트되고 오버헤드는 HEAD 요청 한 번뿐.
  const items = [];

  if (!opts.onlyMajors) {
    process.stdout.write('직업 slug 조회 중... ');
    const rows = queryD1("SELECT slug FROM jobs WHERE is_active = 1 ORDER BY id");
    for (const r of rows) items.push({ type: 'jobs', slug: r.slug, ext: 'png' });
    console.log(`${rows.length}개`);
  }
  if (!opts.onlyJobs) {
    process.stdout.write('전공 slug 조회 중... ');
    const rows = queryD1("SELECT slug FROM majors WHERE is_active = 1 ORDER BY id");
    for (const r of rows) items.push({ type: 'majors', slug: r.slug, ext: 'png' });
    console.log(`${rows.length}개`);
  }

  let targets = items;
  if (opts.testCount) targets = targets.slice(0, opts.testCount);

  console.log(`\n전체 slug: ${items.length}개 → 이번 요청 대상: ${targets.length}개`);
  console.log('(각 slug당 두 가지 인코딩 시도 → 최대 삭제 시도 = 대상 × 2)');

  if (opts.dryRun) {
    console.log('\n샘플 10개:');
    targets.slice(0, 10).forEach((t, i) => {
      const prefix = t.type === 'jobs' ? 'job' : 'major';
      console.log(`  [${i + 1}] ${t.type}/${prefix}-${t.slug}.png`);
    });
    console.log('\n실제 실행: node scripts/cleanup-orphan-png.cjs');
    return;
  }

  // ── 3. 배치 전송 ─────────────────────────────────────────────────────
  const batches = chunk(targets, opts.batch);
  console.log(`\n배치 ${batches.length}개로 분할 (각 ${opts.batch}개 이하)\n`);
  appendLog(`── 배치 시작 (대상 ${targets.length}개, ${batches.length} 배치) ──`);

  const t0 = Date.now();
  let totalDeleted = 0;
  let totalNotFound = 0;
  let totalErrors = 0;
  let doneBatches = 0;

  // 동시성 제한 워커 풀
  let idx = 0;
  async function worker(wid) {
    while (idx < batches.length) {
      const my = idx++;
      const batch = batches[my];
      try {
        const t1 = Date.now();
        const resp = await fetchJSON(
          DELETE_URL,
          {
            method: 'POST',
            headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': adminSecret },
            body: JSON.stringify({ items: batch }),
          },
          REQUEST_TIMEOUT
        );
        totalDeleted  += (resp.deleted || 0);
        totalNotFound += (resp.notFound || 0);
        totalErrors   += (resp.errorCount || 0);
        const dt = ((Date.now() - t1) / 1000).toFixed(1);
        doneBatches++;
        const line = `✓ 배치 ${my + 1}/${batches.length} (W${wid}): 삭제 ${resp.deleted} / 없음 ${resp.notFound} / 에러 ${resp.errorCount || 0} — ${dt}s`;
        console.log(`  [${doneBatches}/${batches.length}] ${line}`);
        appendLog(line);
      } catch (err) {
        doneBatches++;
        const line = `✗ 배치 ${my + 1}/${batches.length} 실패: ${(err.message || String(err)).slice(0, 200)}`;
        console.log(`  [${doneBatches}/${batches.length}] ${line}`);
        appendLog(line);
      }
    }
  }
  await Promise.all(Array.from({ length: opts.concurrency }, (_, i) => worker(i + 1)));

  // ── 4. 요약 ────────────────────────────────────────────────────────
  const elapsedSec = ((Date.now() - t0) / 1000).toFixed(1);
  console.log('');
  console.log('═'.repeat(64));
  console.log('  삭제 완료');
  console.log('═'.repeat(64));
  console.log(`  삭제됨:       ${totalDeleted.toLocaleString()}개`);
  console.log(`  이미 없음:    ${totalNotFound.toLocaleString()}개`);
  console.log(`  에러:         ${totalErrors.toLocaleString()}개`);
  console.log(`  경과:         ${elapsedSec}s`);
  console.log(`  용량 절약:    약 ${(totalDeleted * 0.77).toFixed(0)} MB (평균 PNG 770KB 기준)`);
  appendLog(`── 배치 종료 (삭제 ${totalDeleted} / 없음 ${totalNotFound} / 에러 ${totalErrors}, ${elapsedSec}s) ──`);
}

main().catch(err => {
  console.error('치명적 오류:', err?.message || err);
  process.exit(1);
});
