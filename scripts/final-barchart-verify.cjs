#!/usr/bin/env node
/**
 * final-barchart-verify.cjs  — 바 차트 전수 최종 검증
 *
 * 검증 범위:
 *   - UCJ 있는 모든 직업 (스킬이 수정한 직업) — 현재 1,129개
 *   - api_data_json.overviewSalary.wage 있는 CAREERNET 직업 포함
 *
 * 판정 기준:
 *   ✅ 정상: merged wage 있음 OR 현재 sal이 렌더러 패턴에 매칭됨
 *   ⏭  원래 없음: 초기 snapshot에도 구조화 sal/wage 없었음
 *   ❌ 복원 필요: 초기 snapshot에는 있었으나 현재 없음
 *
 * 추가 시그널:
 *   D) api_data_json.overviewSalary.wage 있는데 merged wage 없음 (deepMerge 손실)
 *   E) 초기 snapshot에 overviewSalary.wage 필드 있었는데 현재 없음
 *   F) 이미 복원된 31개 직업 재확인
 *
 * 사용법:
 *   node scripts/final-barchart-verify.cjs --dry-run
 *   node scripts/final-barchart-verify.cjs --execute
 */

'use strict';

const { execSync } = require('child_process');
const https = require('https');
const path = require('path');

const DRY_RUN = process.argv.includes('--dry-run');
const EXECUTE = process.argv.includes('--execute');

if (!DRY_RUN && !EXECUTE) {
  console.error('Usage: node scripts/final-barchart-verify.cjs --dry-run');
  console.error('       node scripts/final-barchart-verify.cjs --execute');
  process.exit(1);
}

const API_BASE = 'https://careerwiki.org';
const ADMIN_SECRET = 'careerwiki-admin-2026';
const PROJECT_ROOT = path.join(__dirname, '..');

// 렌더러와 동일한 패턴
const GOYONG24_RE = /하위\(25%\)\s*([\d,]+)만원.*?평균\(50%\)\s*([\d,]+)만원.*?상위\(25%\)\s*([\d,]+)만원/s;
const CAREERNET_RE = /임금\s*하위\(25%\)\s*([\d,]+)만원.*?평균\(50%\)\s*([\d,]+)만원.*?상위\(25%\)\s*([\d,]+)만원/s;

// 이미 복원된 31개 직업 (건축 3개 + 이전 배치 28개)
const ALREADY_RESTORED = new Set([
  '1765283440746327', // 건축감리기술자
  '1765283441570636', // 건축구조기술자
  '176528344210340',  // 건축가(건축설계사)
]);

function isNumericWage(w) {
  if (!w || typeof w !== 'string') return false;
  return /^\d{1,3}(,\d{3})*$/.test(w.trim());
}

function currentSalRendersChart(sal) {
  if (!sal) return false;
  const raw = sal.trim();
  if (CAREERNET_RE.test(raw) || GOYONG24_RE.test(raw)) return true;
  if (raw.includes('~') && (raw.match(/\d[\d,]*/g) || []).length === 2) return true;
  const numOnly = raw.replace(/[,\s만원]/g, '');
  if (/^\d{3,6}$/.test(numOnly)) { const n = parseInt(numOnly, 10); if (n > 0) return true; }
  return false;
}

function extractMedianFromStructured(sal) {
  const m = CAREERNET_RE.exec(sal) || GOYONG24_RE.exec(sal);
  if (m) {
    const n = parseInt(m[2].replace(/,/g, ''), 10);
    return Number.isFinite(n) && n > 0 ? n.toLocaleString('ko-KR') : null;
  }
  return null;
}

function parseNum(s) {
  if (!s) return null;
  const n = parseInt(String(s).replace(/,/g, ''), 10);
  return Number.isFinite(n) && n > 0 ? n : null;
}

function extractWageFromCurrentSal(sal) {
  if (!sal) return null;
  let m;
  m = /(?:중위|중앙값?)\s*(?:\(50%\)|50%)[^0-9]*?약?\s*([\d,]+)만/.exec(sal);
  if (m) return parseNum(m[1]);
  m = /평균\(중위[^)]*\)[^0-9]*?약?\s*([\d,]+)만/.exec(sal);
  if (m) return parseNum(m[1]);
  m = /(?:중위(?:값?|\([^)]*\))|중앙값?)[^0-9]{0,25}([\d,]+)만/.exec(sal);
  if (m) { const n = parseNum(m[1]); if (n && n >= 1500) return n; }
  m = /평균\s*(?:연봉|임금|소득|급여)[^0-9]{0,20}?약?\s*([\d,]+)만(?!\s*원?\s*~)/.exec(sal);
  if (m) { const n = parseNum(m[1]); if (n && n >= 1500) return n; }
  m = /약\s*([\d,]+)만(?!\s*원?\s*~)/.exec(sal);
  if (m) { const n = parseNum(m[1]); if (n && n >= 1500) return n; }
  m = /([\d,]+)\s*(?:만\s*원?)?\s*[~～]\s*([\d,]+)\s*만/.exec(sal);
  if (m) {
    const lo = parseNum(m[1]), hi = parseNum(m[2]);
    if (lo && hi && lo >= 500 && hi >= 500 && lo < hi) return Math.round((lo + hi) / 2);
  }
  return null;
}

function isDailyRate(s) {
  return /일당|시급|시간당|\/일|하루\s*\d/.test(s || '');
}

function d1Query(sql) {
  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: PROJECT_ROOT, timeout: 120000, maxBuffer: 64 * 1024 * 1024 }
  );
  return JSON.parse(out)[0].results;
}

function apiCall(method, urlPath, body) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const url = new URL(API_BASE + urlPath);
    const req = https.request({
      hostname: url.hostname, path: url.pathname, method,
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data),
        'X-Admin-Secret': ADMIN_SECRET,
      },
    }, (res) => {
      let buf = '';
      res.on('data', c => buf += c);
      res.on('end', () => {
        try { resolve({ status: res.statusCode, body: JSON.parse(buf) }); }
        catch { resolve({ status: res.statusCode, body: buf }); }
      });
    });
    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

async function main() {
  console.log('\n=== final-barchart-verify: 바 차트 최종 전수 검증 ===');
  console.log('모드: ' + (DRY_RUN ? 'DRY-RUN' : 'EXECUTE'));
  console.log('실행: ' + new Date().toISOString() + '\n');

  // ── STEP 1: UCJ 있는 모든 직업 조회 (경량 필드만) ──
  console.log('[Step 1] UCJ 있는 직업 전체 조회...');
  const ucjJobs = d1Query(
    "SELECT id, name, slug, " +
    "json_extract(merged_profile_json,'$.overviewSalary.wage') as wage, " +
    "json_extract(merged_profile_json,'$.overviewSalary.sal') as sal, " +
    "json_extract(api_data_json,'$.overviewSalary.wage') as api_wage " +
    "FROM jobs WHERE user_contributed_json IS NOT NULL"
  );
  console.log('  UCJ 있는 직업: ' + ucjJobs.length + '개\n');

  // ── STEP 2: 현재 바 차트 상태 분류 ──
  const hasBarchart = [];   // 현재 바 차트 있음
  const missingList = [];   // 현재 바 차트 없음 (sal 있음)
  const noSal = [];         // sal 자체 없음 → 바 차트 없어도 정상

  for (const row of ucjJobs) {
    const wage = row.wage;
    const sal = row.sal;

    if (isNumericWage(wage)) {
      hasBarchart.push({ id: row.id, name: row.name, slug: row.slug, reason: 'wage=' + wage });
      ALREADY_RESTORED.add(row.id); // mark as known-good
      continue;
    }
    if (currentSalRendersChart(sal)) {
      hasBarchart.push({ id: row.id, name: row.name, slug: row.slug, reason: 'sal_pattern' });
      continue;
    }
    if (!sal) {
      noSal.push({ id: row.id, name: row.name, slug: row.slug });
      continue;
    }
    // No bar chart, sal exists
    missingList.push({ id: row.id, name: row.name, slug: row.slug, sal, api_wage: row.api_wage, mergedSalObj: null, sources: {} });
  }

  console.log('  현재 바 차트 있음: ' + hasBarchart.length + '개');
  console.log('  sal 없음 (정상): ' + noSal.length + '개');
  console.log('  바 차트 없음 (sal 있음): ' + missingList.length + '개\n');

  // ── STEP 1b: missingList에 대해서만 sources + merged_sal_obj 배치 조회 ──
  if (missingList.length > 0) {
    console.log('  [상세 조회] missing ' + missingList.length + '개 sources/merged_sal_obj...');
    const DBATCH = 80;
    const missBatchIds = missingList.map(r => "'" + r.id + "'");
    for (let i = 0; i < missBatchIds.length; i += DBATCH) {
      const chunk = missBatchIds.slice(i, i + DBATCH).join(',');
      const drows = d1Query(
        "SELECT id, " +
        "json_extract(merged_profile_json,'$.overviewSalary') as merged_sal_obj, " +
        "json_extract(user_contributed_json,'$._sources') as sources " +
        "FROM jobs WHERE id IN (" + chunk + ")"
      );
      for (const dr of drows) {
        const entry = missingList.find(r => r.id === dr.id);
        if (!entry) continue;
        try { entry.mergedSalObj = dr.merged_sal_obj ? JSON.parse(dr.merged_sal_obj) : null; } catch {}
        try { entry.sources = dr.sources ? JSON.parse(dr.sources) : {}; } catch {}
      }
      process.stdout.write('.');
    }
    console.log(' 완료\n');
  }

  // ── STEP 3: Signal D — api_data_json.wage 있는데 merged wage 없음 ──
  console.log('[Step 2] Signal D — api_data_json wage 손실 체크...');
  const signalD = missingList.filter(r => isNumericWage(r.api_wage));
  console.log('  api_wage 있지만 merged wage 없음: ' + signalD.length + '개\n');

  // ── STEP 4: Signal E — 초기 snapshot에 wage 또는 구조화 sal ──
  console.log('[Step 3] 초기 snapshot 체크 (Signal A+E)...');
  const missIds = missingList.filter(r => !isNumericWage(r.api_wage)).map(r => "'" + r.id + "'");
  const snapshotData = {};

  const BATCH = 200;
  for (let i = 0; i < missIds.length; i += BATCH) {
    const batch = missIds.slice(i, i + BATCH);
    // Signal A: 구조화 sal
    const rows = d1Query(
      "SELECT pr.entity_id, " +
      "json_extract(pr.data_snapshot,'$.overviewSalary.sal') as snap_sal, " +
      "json_extract(pr.data_snapshot,'$.overviewSalary.wage') as snap_wage " +
      "FROM page_revisions pr " +
      "WHERE pr.entity_type='job' " +
      "AND pr.entity_id IN (" + batch.join(',') + ") " +
      "AND json_type(pr.data_snapshot,'$.changedFields') IS NULL " +
      "ORDER BY pr.created_at DESC"
    );
    for (const row of rows) {
      if (snapshotData[row.entity_id]) continue; // 가장 최근 snapshot만
      const structuredWage = extractMedianFromStructured(row.snap_sal || '');
      const existingWage = isNumericWage(row.snap_wage) ? row.snap_wage : null;
      if (structuredWage || existingWage) {
        snapshotData[row.entity_id] = {
          wage: structuredWage || existingWage,
          from: structuredWage ? 'structured_sal' : 'snap_wage',
        };
      }
    }
    process.stdout.write('.');
  }
  console.log();
  console.log('  snapshot에서 wage 복원 가능: ' + Object.keys(snapshotData).length + '개\n');

  // ── STEP 5: 복원 대상 최종 판정 ──
  const toRestore = [];
  const neverHad = [];
  const alreadyFixed = [];

  for (const row of missingList) {
    if (ALREADY_RESTORED.has(row.id)) {
      // should have been fixed — check again
      alreadyFixed.push({ ...row, concern: '이미 복원 대상이었는데 wage 없음!' });
      continue;
    }

    // Signal D: api_wage 있음
    if (isNumericWage(row.api_wage)) {
      if (isDailyRate(row.sal)) {
        neverHad.push({ id: row.id, name: row.name, reason: '일당/시급 기준 sal' });
        continue;
      }
      const currentExtracted = extractWageFromCurrentSal(row.sal);
      const finalWage = (currentExtracted && currentExtracted >= 1500)
        ? currentExtracted.toLocaleString('ko-KR')
        : row.api_wage;
      toRestore.push({ id: row.id, name: row.name, slug: row.slug, wage: finalWage, signal: 'D', mergedSalObj: row.mergedSalObj, sources: row.sources });
      continue;
    }

    // Signal A/E: snapshot에서 발견
    const snap = snapshotData[row.id];
    if (snap) {
      if (isDailyRate(row.sal)) {
        neverHad.push({ id: row.id, name: row.name, reason: '일당/시급 기준 sal (snapshot 있음)' });
        continue;
      }
      if (parseInt(snap.wage.replace(/,/g, ''), 10) < 1500) {
        neverHad.push({ id: row.id, name: row.name, reason: '월급 기준 데이터 추정 (' + snap.wage + '만원)' });
        continue;
      }
      const currentExtracted = extractWageFromCurrentSal(row.sal);
      const finalWage = (currentExtracted && currentExtracted >= 1500)
        ? currentExtracted.toLocaleString('ko-KR')
        : snap.wage;
      toRestore.push({ id: row.id, name: row.name, slug: row.slug, wage: finalWage, signal: snap.from, mergedSalObj: row.mergedSalObj, sources: row.sources });
      continue;
    }

    neverHad.push({ id: row.id, name: row.name, reason: '초기 snapshot에 바 차트 데이터 없음 (원래부터 없음)' });
  }

  // ── STEP 6: 복원 대상 출력 ──
  console.log('=== 최종 검증 결과 ===\n');
  console.log('✅ 현재 바 차트 정상: ' + hasBarchart.length + '개');
  console.log('⏭  sal 없음 (정상):   ' + noSal.length + '개');
  console.log('⏭  원래부터 없음:     ' + neverHad.length + '개');
  console.log('❌ 복원 대상:          ' + toRestore.length + '개');
  if (alreadyFixed.length > 0) console.log('⚠  복원 확인 실패:    ' + alreadyFixed.length + '개');
  console.log();

  if (alreadyFixed.length > 0) {
    console.log('⚠  이미 복원됐어야 하는데 wage 없는 직업:');
    for (const r of alreadyFixed) console.log('   - ' + r.name + ' (' + r.id + ')');
    console.log();
  }

  if (toRestore.length === 0) {
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('✅ 추가 복원 대상 0건 — 전수조사 완료');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log();
    console.log('[스킵 내역 (월급/일당 기준 데이터):');
    const monthly = neverHad.filter(r => r.reason.includes('월급 기준') || r.reason.includes('일당/시급'));
    for (const r of monthly) console.log('  ⏭  ' + r.name + ' — ' + r.reason);
    return;
  }

  console.log('❌ 추가 복원 대상 (' + toRestore.length + '개):\n');
  for (const r of toRestore) {
    console.log('  ❌ ' + r.name + ' (시그널: ' + r.signal + ')');
    console.log('     설정할 wage: ' + r.wage + '만원');
    console.log('     https://careerwiki.org/job/' + encodeURIComponent(r.slug));
    console.log();
  }

  if (DRY_RUN) {
    console.log('[DRY-RUN] 변경 없음. --execute로 재실행하면 복원됩니다.');
    return;
  }

  // ── STEP 7: EXECUTE ──
  console.log('[EXECUTE] API 호출...\n');
  const results = [];
  for (const r of toRestore) {
    const newSal = Object.assign({}, r.mergedSalObj, { wage: r.wage });
    process.stdout.write('  ' + r.name + '... ');
    try {
      const res = await apiCall('POST', '/api/job/' + r.id + '/edit', {
        fields: { overviewSalary: newSal },
        sources: r.sources || {},
      });
      if (res.status >= 200 && res.status < 300) {
        console.log('✅ HTTP ' + res.status);
        results.push({ ...r, ok: true });
      } else {
        console.log('❌ HTTP ' + res.status + ': ' + JSON.stringify(res.body));
        results.push({ ...r, ok: false, error: res.body });
      }
    } catch (err) {
      console.log('❌ ' + err.message);
      results.push({ ...r, ok: false, error: err.message });
    }
    await new Promise(resolve => setTimeout(resolve, 600));
  }

  const ok = results.filter(r => r.ok);
  const fail = results.filter(r => !r.ok);
  console.log('\n=== 결과: 성공 ' + ok.length + '개 / 실패 ' + fail.length + '개 ===');
  if (fail.length > 0) {
    for (const r of fail) console.log('  ❌ ' + r.name + ': ' + JSON.stringify(r.error));
    process.exit(1);
  }
}

main().catch(err => { console.error('Fatal:', err); process.exit(1); });
